PGDMP  5                     |            datos_ms    16.0    16.0 D    S           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            T           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            U           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            V           1262    16712    datos_ms    DATABASE     {   CREATE DATABASE datos_ms WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Spain.1252';
    DROP DATABASE datos_ms;
                postgres    false            W           0    0    DATABASE datos_ms    COMMENT     V   COMMENT ON DATABASE datos_ms IS 'datos en grandes cantitades para probar su funcion';
                   postgres    false    4950            �            1255    16791    enviar_a_python()    FUNCTION     6  CREATE FUNCTION public.enviar_a_python() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Lógica para enviar datos a un archivo
  -- Puedes utilizar la función pg_notify o cualquier otro método según tus necesidades
  PERFORM pg_notify('datos_actualizados', NEW.id::text);

  RETURN NEW;
END;
$$;
 (   DROP FUNCTION public.enviar_a_python();
       public          postgres    false            �            1255    17407 4   extract_month_from_date(timestamp without time zone)    FUNCTION     �   CREATE FUNCTION public.extract_month_from_date(date_value timestamp without time zone) RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $_$
  SELECT EXTRACT(MONTH FROM $1)::INTEGER;
$_$;
 V   DROP FUNCTION public.extract_month_from_date(date_value timestamp without time zone);
       public          postgres    false            �            1255    17406 3   extract_year_from_date(timestamp without time zone)    FUNCTION     �   CREATE FUNCTION public.extract_year_from_date(date_value timestamp without time zone) RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $_$
  SELECT EXTRACT(YEAR FROM $1)::INTEGER;
$_$;
 U   DROP FUNCTION public.extract_year_from_date(date_value timestamp without time zone);
       public          postgres    false            �            1255    17565    migrar_datos()    FUNCTION       CREATE FUNCTION public.migrar_datos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Migrar datos desde la tabla original a la nueva tabla particionada
    INSERT INTO public.compra_division (id_compra, fecha)
    VALUES (NEW.id, NEW.fecha::date);

    RETURN NEW;
END;
$$;
 %   DROP FUNCTION public.migrar_datos();
       public          postgres    false            �            1259    16741    compra    TABLE     �   CREATE TABLE public.compra (
    id integer NOT NULL,
    id_persona integer,
    id_producto integer,
    id_supermercado integer,
    cantidad integer,
    fecha timestamp without time zone
);
    DROP TABLE public.compra;
       public         heap    postgres    false            X           0    0    TABLE compra    ACL     2   GRANT INSERT ON TABLE public.compra TO user_data;
          public          postgres    false    220            �            1259    17501    compra_division    TABLE     �   CREATE TABLE public.compra_division (
    id integer NOT NULL,
    id_compra integer,
    fecha date
)
PARTITION BY RANGE (fecha);
 #   DROP TABLE public.compra_division;
       public            postgres    false            Y           0    0    TABLE compra_division    ACL     P   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.compra_division TO user_data;
          public          postgres    false    224            �            1259    17500    compra_division_id_seq    SEQUENCE     �   CREATE SEQUENCE public.compra_division_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.compra_division_id_seq;
       public          postgres    false    224            Z           0    0    compra_division_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.compra_division_id_seq OWNED BY public.compra_division.id;
          public          postgres    false    223            [           0    0    SEQUENCE compra_division_id_seq    ACL     K   GRANT SELECT,USAGE ON SEQUENCE public.compra_division_id_seq TO user_data;
          public          postgres    false    223            �            1259    17517    compra_division202401    TABLE     �   CREATE TABLE public.compra_division202401 (
    id integer DEFAULT nextval('public.compra_division_id_seq'::regclass) NOT NULL,
    id_compra integer,
    fecha date
);
 )   DROP TABLE public.compra_division202401;
       public         heap    postgres    false    223    224            �            1259    17521    compra_division202402    TABLE     �   CREATE TABLE public.compra_division202402 (
    id integer DEFAULT nextval('public.compra_division_id_seq'::regclass) NOT NULL,
    id_compra integer,
    fecha date
);
 )   DROP TABLE public.compra_division202402;
       public         heap    postgres    false    223    224            �            1259    17525    compra_division202403    TABLE     �   CREATE TABLE public.compra_division202403 (
    id integer DEFAULT nextval('public.compra_division_id_seq'::regclass) NOT NULL,
    id_compra integer,
    fecha date
);
 )   DROP TABLE public.compra_division202403;
       public         heap    postgres    false    223    224            �            1259    17529    compra_division202404    TABLE     �   CREATE TABLE public.compra_division202404 (
    id integer DEFAULT nextval('public.compra_division_id_seq'::regclass) NOT NULL,
    id_compra integer,
    fecha date
);
 )   DROP TABLE public.compra_division202404;
       public         heap    postgres    false    223    224            �            1259    17533    compra_division202405    TABLE     �   CREATE TABLE public.compra_division202405 (
    id integer DEFAULT nextval('public.compra_division_id_seq'::regclass) NOT NULL,
    id_compra integer,
    fecha date
);
 )   DROP TABLE public.compra_division202405;
       public         heap    postgres    false    223    224            �            1259    17537    compra_division202406    TABLE     �   CREATE TABLE public.compra_division202406 (
    id integer DEFAULT nextval('public.compra_division_id_seq'::regclass) NOT NULL,
    id_compra integer,
    fecha date
);
 )   DROP TABLE public.compra_division202406;
       public         heap    postgres    false    223    224            �            1259    17541    compra_division202407    TABLE     �   CREATE TABLE public.compra_division202407 (
    id integer DEFAULT nextval('public.compra_division_id_seq'::regclass) NOT NULL,
    id_compra integer,
    fecha date
);
 )   DROP TABLE public.compra_division202407;
       public         heap    postgres    false    223    224            �            1259    17545    compra_division202408    TABLE     �   CREATE TABLE public.compra_division202408 (
    id integer DEFAULT nextval('public.compra_division_id_seq'::regclass) NOT NULL,
    id_compra integer,
    fecha date
);
 )   DROP TABLE public.compra_division202408;
       public         heap    postgres    false    223    224            �            1259    17549    compra_division202409    TABLE     �   CREATE TABLE public.compra_division202409 (
    id integer DEFAULT nextval('public.compra_division_id_seq'::regclass) NOT NULL,
    id_compra integer,
    fecha date
);
 )   DROP TABLE public.compra_division202409;
       public         heap    postgres    false    223    224            �            1259    17553    compra_division202410    TABLE     �   CREATE TABLE public.compra_division202410 (
    id integer DEFAULT nextval('public.compra_division_id_seq'::regclass) NOT NULL,
    id_compra integer,
    fecha date
);
 )   DROP TABLE public.compra_division202410;
       public         heap    postgres    false    223    224            �            1259    17557    compra_division202411    TABLE     �   CREATE TABLE public.compra_division202411 (
    id integer DEFAULT nextval('public.compra_division_id_seq'::regclass) NOT NULL,
    id_compra integer,
    fecha date
);
 )   DROP TABLE public.compra_division202411;
       public         heap    postgres    false    223    224            �            1259    17561    compra_division202412    TABLE     �   CREATE TABLE public.compra_division202412 (
    id integer DEFAULT nextval('public.compra_division_id_seq'::regclass) NOT NULL,
    id_compra integer,
    fecha date
);
 )   DROP TABLE public.compra_division202412;
       public         heap    postgres    false    223    224            �            1259    16740    compra_id_seq    SEQUENCE     �   CREATE SEQUENCE public.compra_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.compra_id_seq;
       public          postgres    false    220            \           0    0    compra_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.compra_id_seq OWNED BY public.compra.id;
          public          postgres    false    219            ]           0    0    SEQUENCE compra_id_seq    ACL     B   GRANT SELECT,USAGE ON SEQUENCE public.compra_id_seq TO user_data;
          public          postgres    false    219            �            1259    16776    persona    TABLE     |   CREATE TABLE public.persona (
    id integer NOT NULL,
    nombre character varying,
    identificacion integer NOT NULL
);
    DROP TABLE public.persona;
       public         heap    postgres    false            ^           0    0    TABLE persona    ACL     H   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.persona TO user_data;
          public          postgres    false    222            �            1259    16775    persona_id_seq    SEQUENCE     �   CREATE SEQUENCE public.persona_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.persona_id_seq;
       public          postgres    false    222            _           0    0    persona_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.persona_id_seq OWNED BY public.persona.id;
          public          postgres    false    221            `           0    0    SEQUENCE persona_id_seq    ACL     C   GRANT SELECT,USAGE ON SEQUENCE public.persona_id_seq TO user_data;
          public          postgres    false    221            �            1259    16732    producto    TABLE     �   CREATE TABLE public.producto (
    id integer NOT NULL,
    nombre_producto character varying,
    precio_producto integer,
    monto double precision
);
    DROP TABLE public.producto;
       public         heap    postgres    false            �            1259    16731    producto_id_seq    SEQUENCE     �   CREATE SEQUENCE public.producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.producto_id_seq;
       public          postgres    false    218            a           0    0    producto_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.producto_id_seq OWNED BY public.producto.id;
          public          postgres    false    217            �            1259    16723    supermercado    TABLE     l   CREATE TABLE public.supermercado (
    id integer NOT NULL,
    direccion_supermercado character varying
);
     DROP TABLE public.supermercado;
       public         heap    postgres    false            �            1259    16722    supermercado _id_seq    SEQUENCE     �   CREATE SEQUENCE public."supermercado _id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."supermercado _id_seq";
       public          postgres    false    216            b           0    0    supermercado _id_seq    SEQUENCE OWNED BY     N   ALTER SEQUENCE public."supermercado _id_seq" OWNED BY public.supermercado.id;
          public          postgres    false    215            �           0    0    compra_division202401    TABLE ATTACH     �   ALTER TABLE ONLY public.compra_division ATTACH PARTITION public.compra_division202401 FOR VALUES FROM ('2024-01-01') TO ('2024-01-31');
          public          postgres    false    225    224            �           0    0    compra_division202402    TABLE ATTACH     �   ALTER TABLE ONLY public.compra_division ATTACH PARTITION public.compra_division202402 FOR VALUES FROM ('2024-02-01') TO ('2024-02-29');
          public          postgres    false    226    224            �           0    0    compra_division202403    TABLE ATTACH     �   ALTER TABLE ONLY public.compra_division ATTACH PARTITION public.compra_division202403 FOR VALUES FROM ('2024-03-01') TO ('2024-03-31');
          public          postgres    false    227    224            �           0    0    compra_division202404    TABLE ATTACH     �   ALTER TABLE ONLY public.compra_division ATTACH PARTITION public.compra_division202404 FOR VALUES FROM ('2024-04-01') TO ('2024-04-30');
          public          postgres    false    228    224            �           0    0    compra_division202405    TABLE ATTACH     �   ALTER TABLE ONLY public.compra_division ATTACH PARTITION public.compra_division202405 FOR VALUES FROM ('2024-05-01') TO ('2024-05-31');
          public          postgres    false    229    224            �           0    0    compra_division202406    TABLE ATTACH     �   ALTER TABLE ONLY public.compra_division ATTACH PARTITION public.compra_division202406 FOR VALUES FROM ('2024-06-01') TO ('2024-06-30');
          public          postgres    false    230    224            �           0    0    compra_division202407    TABLE ATTACH     �   ALTER TABLE ONLY public.compra_division ATTACH PARTITION public.compra_division202407 FOR VALUES FROM ('2024-07-01') TO ('2024-07-31');
          public          postgres    false    231    224            �           0    0    compra_division202408    TABLE ATTACH     �   ALTER TABLE ONLY public.compra_division ATTACH PARTITION public.compra_division202408 FOR VALUES FROM ('2024-08-01') TO ('2024-08-31');
          public          postgres    false    232    224            �           0    0    compra_division202409    TABLE ATTACH     �   ALTER TABLE ONLY public.compra_division ATTACH PARTITION public.compra_division202409 FOR VALUES FROM ('2024-09-01') TO ('2024-09-30');
          public          postgres    false    233    224            �           0    0    compra_division202410    TABLE ATTACH     �   ALTER TABLE ONLY public.compra_division ATTACH PARTITION public.compra_division202410 FOR VALUES FROM ('2024-10-01') TO ('2024-10-31');
          public          postgres    false    234    224            �           0    0    compra_division202411    TABLE ATTACH     �   ALTER TABLE ONLY public.compra_division ATTACH PARTITION public.compra_division202411 FOR VALUES FROM ('2024-11-01') TO ('2024-11-30');
          public          postgres    false    235    224            �           0    0    compra_division202412    TABLE ATTACH     �   ALTER TABLE ONLY public.compra_division ATTACH PARTITION public.compra_division202412 FOR VALUES FROM ('2024-12-01') TO ('2024-12-31');
          public          postgres    false    236    224            �           2604    16744 	   compra id    DEFAULT     f   ALTER TABLE ONLY public.compra ALTER COLUMN id SET DEFAULT nextval('public.compra_id_seq'::regclass);
 8   ALTER TABLE public.compra ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219    220            �           2604    17504    compra_division id    DEFAULT     x   ALTER TABLE ONLY public.compra_division ALTER COLUMN id SET DEFAULT nextval('public.compra_division_id_seq'::regclass);
 A   ALTER TABLE public.compra_division ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223    224            �           2604    16779 
   persona id    DEFAULT     h   ALTER TABLE ONLY public.persona ALTER COLUMN id SET DEFAULT nextval('public.persona_id_seq'::regclass);
 9   ALTER TABLE public.persona ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    222    222            �           2604    16735    producto id    DEFAULT     j   ALTER TABLE ONLY public.producto ALTER COLUMN id SET DEFAULT nextval('public.producto_id_seq'::regclass);
 :   ALTER TABLE public.producto ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217    218            �           2604    16726    supermercado id    DEFAULT     u   ALTER TABLE ONLY public.supermercado ALTER COLUMN id SET DEFAULT nextval('public."supermercado _id_seq"'::regclass);
 >   ALTER TABLE public.supermercado ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    216    216            �           2606    16746    compra compra_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.compra DROP CONSTRAINT compra_pkey;
       public            postgres    false    220            �           2606    16783    persona id_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT id_pkey PRIMARY KEY (id);
 9   ALTER TABLE ONLY public.persona DROP CONSTRAINT id_pkey;
       public            postgres    false    222            �           2606    16739    producto producto_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.producto DROP CONSTRAINT producto_pkey;
       public            postgres    false    218            �           2606    16730    supermercado supermercado _pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.supermercado
    ADD CONSTRAINT "supermercado _pkey" PRIMARY KEY (id);
 K   ALTER TABLE ONLY public.supermercado DROP CONSTRAINT "supermercado _pkey";
       public            postgres    false    216            �           2620    16793    persona trig_enviar_a_python    TRIGGER     {   CREATE TRIGGER trig_enviar_a_python AFTER INSERT ON public.persona FOR EACH ROW EXECUTE FUNCTION public.enviar_a_python();
 5   DROP TRIGGER trig_enviar_a_python ON public.persona;
       public          postgres    false    222    237            �           2620    17566    compra trigger_migrar_datos    TRIGGER     w   CREATE TRIGGER trigger_migrar_datos AFTER INSERT ON public.compra FOR EACH ROW EXECUTE FUNCTION public.migrar_datos();
 4   DROP TRIGGER trigger_migrar_datos ON public.compra;
       public          postgres    false    240    220            �           2606    16784    compra id_persona    FK CONSTRAINT        ALTER TABLE ONLY public.compra
    ADD CONSTRAINT id_persona FOREIGN KEY (id_persona) REFERENCES public.persona(id) NOT VALID;
 ;   ALTER TABLE ONLY public.compra DROP CONSTRAINT id_persona;
       public          postgres    false    222    4796    220            �           2606    16761    compra id_producto    FK CONSTRAINT     �   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT id_producto FOREIGN KEY (id_producto) REFERENCES public.producto(id) NOT VALID;
 <   ALTER TABLE ONLY public.compra DROP CONSTRAINT id_producto;
       public          postgres    false    220    4792    218            �           2606    16756    compra id_supermercado    FK CONSTRAINT     �   ALTER TABLE ONLY public.compra
    ADD CONSTRAINT id_supermercado FOREIGN KEY (id_supermercado) REFERENCES public.supermercado(id) NOT VALID;
 @   ALTER TABLE ONLY public.compra DROP CONSTRAINT id_supermercado;
       public          postgres    false    216    220    4790           