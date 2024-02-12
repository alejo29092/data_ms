import numpy as np
import pandas as pd
import psycopg2
from psycopg2 import sql
import select
import time
from datetime import datetime
from io import StringIO

with open('password') as file_object:
    password = file_object.read()
data_adress = pd.read_csv('address_supermeiker_data.csv')
data_adress_2 = data_adress['address'].tolist()


def data_random(num_arrows):
    """
    For this problem I made a list on this page: https://mockaroo.com/
     can insert data directly into sql, but it was not exactly what I need,
     so I adapted it to my needs

    :return:
    """

    data_name = pd.read_csv('data_name.csv')
    data_name_2 = data_name['name'].tolist()

    data = []
    for _ in range(num_arrows):
        fila = {
            'name': np.random.choice(data_name_2),
            'identification': np.random.randint(100, 50000000),
            'id_Supermarket': np.random.randint(1, 1000),
            'id_product': np.random.randint(1, 500),
            'amount': np.random.randint(1, 20),
            'date': datetime.now()

        }
        data.append(fila)

    df = pd.DataFrame(data)
    return df


def insert_table(data):
    """
    This function receives data to confirm in the person table, if the person exists, the function does not add it,
     If not, add the new data
     :param data: data generated, or to be added
    """
    # Carga la password desde un archivo
    with open('password') as file_object:
        password = file_object.read().strip()

    conn = psycopg2.connect(
        dbname="datos_ms",
        user="user_data",
        password=password,
        host="localhost",
        port="5432"
    )
    try:

        data_table_person = data.loc[:, ['name', 'identification']]

        data_table_person = data_table_person.drop_duplicates(subset='identification', keep='first')

        existing_identifications = check_existing_identifications(conn, data_table_person['identification'])

        if existing_identifications:
            print(f'Duplicate IDs found and removed: {existing_identifications}')

        with conn.cursor() as cursor:
            for index, row in data_table_person.iterrows():
                cursor.execute("""
                      INSERT INTO person (name, identification) VALUES (%s, %s)
                  """, (row['name'], row['identification']))

        conn.commit()

    finally:
        conn.close()


def check_existing_identifications(conn, identifications):
    """
    This function is a help union of the previous one
     :param conn: database path
     :param identifications: confirms existing users in the database
     :return:
    """
    with conn.cursor() as cursor:
        cursor.execute("""
            SELECT identification
            FROM persona
            WHERE identification IN %s
        """, (tuple(identifications),))

        existing_identifications = set(row[0] for row in cursor.fetchall())

    return existing_identifications


# insert_table(data_random)


def input_data():
    """
    This function is created to confirm how much data was put in each table (it is developed since it was
     designed to join data in the form of arrival, but it is better to do it with times, but this is not ruled out
     possibility)
     :return: data message
    """
    with open('password') as file_object:
        password = file_object.read()

    conn = psycopg2.connect(
        dbname="datos_ms",
        user="user_data",
        password=f"{password}",
        host="localhost",
        port="5432"
    )

    conn.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_AUTOCOMMIT)

    cur = conn.cursor()

    cur.execute("LISTEN datos_actualizados;")

    notification_received = False

    while True:
        try:
            if select.select([conn], [], [], 10) == ([], [], []):
                if notification_received:
                    print("Notification received. Closing the cycle.")
                    break
                else:
                    print("No notifications within 10 seconds.")
            else:
                conn.poll()
                while conn.notifies:
                    notify = conn.notifies.pop(0)
                    print(f"Notification received: {notify.payload}")

                    Notification_content = notify.payload

                    print(f"Notification content: {Notification_content}")

                    notification_received = True
                    break

        except Exception as e:
            print(f"Error: {e}")
    return notification_received

    cur.close()
    conn.close()


def table_data(table, column):
    """
   later use

     :param table: table to search for data
     :param column: column to fetch data
     :return:
    """
    with open('password') as file_object:
        password = file_object.read()

    conn = psycopg2.connect(
        dbname="datos_ms",
        user="user_data",
        password=f"{password}",
        host="localhost",
        port="5432"
    )

    cur = conn.cursor()

    try:

        consultation_sql = f"SELECT * FROM {table} WHERE {column};"

        cur.execute(consultation_sql)

        results = cur.fetchall()

        for row in results:
            print(f"row: {row}")

    except psycopg2.Error as e:
        print(f"SQL query error: {e}")

    finally:

        cur.close()
        conn.close()


def refactor_its(data_new_person_table):
    """
         Update the primary table by joining the ids to the identification


         :param data_new_person_table:
         :return:
    """
    conn = psycopg2.connect(
        dbname="datos_ms",
        user="user_data",
        password=f"{password}",
        host="localhost",
        port="5432")
    try:

        with conn.cursor() as cursor:

            cursor.execute("SELECT id, identification FROM persona")
            data_persona = pd.DataFrame(cursor.fetchall(), columns=['id', 'identification'])

            data_complet = pd.merge(data_new_person_table, data_persona, on='identification', how='left')


    except Exception as e:

        print(f"Error: {e}")

    finally:

        conn.close()

    data_complet = data_complet.loc[:, ['id', 'id_product', 'amount', 'id_supermarket', 'date']]
    data_complet = data_complet.rename(columns={'id': 'id_person'})
    return data_complet


def convert_native_data(data_purchase):
    for column in data_purchase.columns:
        data_purchase[column] = data_purchase[column].astype(str).apply(
            lambda x: x.item() if isinstance(x, np.int64) else x)
    return data_purchase


def insert_purchase(data_purchase):
    """
    Insert the missing data into the purchase table
    :param data_purchase:
    :return:
    """
    with open('password') as file_object:
        password = file_object.read()

    conn = psycopg2.connect(
        dbname="datos_ms",
        user="user_data",
        password=f"{password}",
        host="localhost",
        port="5432"
    )

    try:

        data_purchase = convert_native_data(data_purchase)

        with conn.cursor() as cursor:

            for index, row in data_purchase.iterrows():
                cursor.execute("""
                    INSERT INTO purchase (id_person, id_product, amount, id_supermarket, date)
                    VALUES (%s, %s, %s, %s, %s)
                """, (row['id_person'], row['id_product'], row['amount'], row['id_supermarket'], row['date']))

        conn.commit()


    except Exception as e:

        print(f"Error: {e}")

    finally:

        conn.close()

# insert_compra(data_final)
