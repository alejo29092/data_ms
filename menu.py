import datos_input as di
import time


def function(option):
    if option == '1':
        init_time = time.time()
        print("With the amount of data you want to handle, it will be created randomly:  ")
        data_new = di.data_random(int(input('Enter the amount of data: ')))
        di.insert_table(data_new)
        data_pre = di.refactor_its(data_new)
        di.insert_purchase(data_pre)

        end_time = time.time()
        time_2 = end_time - init_time
        print('this was the time elapsed: ', time_2)
    if option == '2':
        init_time = time.time()
        data_new = di.data_random(int(input('Enter the amount of data: ')))
        print(data_new)
        end_time = time.time()
        time_2 = end_time - init_time
        print('this was the time elapsed: ', time_2)
    else:
        print('OPTION INVALID')

