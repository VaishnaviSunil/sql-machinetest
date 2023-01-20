-- Machine test-1

1.machinetest=# create table tbl_stock (pk_int_stock_id serial primary key,vchr_name varchar(50),int_quantity int,int_price int);
CREATE TABLE
machinetest=# \dt
           List of relations
 Schema |   Name    | Type  |  Owner
--------+-----------+-------+----------
 public | tbl_stock | table | postgres
(1 row)


machinetest=# select * from tbl_stock;
 pk_int_stock_id | vchr_name | int_quantity | int_price
-----------------+-----------+--------------+-----------
(0 rows)

2.machinetest=# alter table tbl_stock alter column int_price type float;
ALTER TABLE

3.machinetest=# create table tbl_supplier(pk_int_supplier_id serial primary key,vchr_supplier_name varchar(50));
CREATE TABLE
machinetest=# \d tbl_supplier;
                                                 Table "public.tbl_supplier"
       Column       |         Type          | Collation | Nullable |                         Default
--------------------+-----------------------+-----------+----------+----------------------------------------------------------
 pk_int_supplier_id | integer               |           | not null | nextval('tbl_supplier_pk_int_supplier_id_seq'::regclass)
 vchr_supplier_name | character varying(50) |           |          |
Indexes:
    "tbl_supplier_pkey" PRIMARY KEY, btree (pk_int_supplier_id)

4.machinetest=# alter table tbl_stock add column fk_int_supplier int;
ALTER TABLE
machinetest=# \d tbl_stock
                                              Table "public.tbl_stock"
     Column      |         Type          | Collation | Nullable |                      Default
-----------------+-----------------------+-----------+----------+----------------------------------------------------
 pk_int_stock_id | integer               |           | not null | nextval('tbl_stock_pk_int_stock_id_seq'::regclass)
 vchr_name       | character varying(50) |           |          |
 int_quantity    | integer               |           |          |
 int_price       | double precision      |           |          |
 fk_int_supplier | integer               |           |          |
Indexes:
    "tbl_stock_pkey" PRIMARY KEY, btree (pk_int_stock_id)

5.machinetest=# alter table tbl_stock add foreign key (fk_int_supplier) references tbl_supplier (pk_int_supplier_id);
ALTER TABLE
machinetest=# \d tbl_stock
                                              Table "public.tbl_stock"
     Column      |         Type          | Collation | Nullable |                      Default
-----------------+-----------------------+-----------+----------+----------------------------------------------------
 pk_int_stock_id | integer               |           | not null | nextval('tbl_stock_pk_int_stock_id_seq'::regclass)
 vchr_name       | character varying(50) |           |          |
 int_quantity    | integer               |           |          |
 int_price       | double precision      |           |          |
 fk_int_supplier | integer               |           |          |
Indexes:
    "tbl_stock_pkey" PRIMARY KEY, btree (pk_int_stock_id)
Foreign-key constraints:
    "tbl_stock_fk_int_supplier_fkey" FOREIGN KEY (fk_int_supplier) REFERENCES tbl_supplier(pk_int_supplier_id)


6.machinetest=# create table tbl_dept (pk_int_dpt_id serial primary key,vchr_dept_name varchar(50));
CREATE TABLE
machinetest=# \d tbl_dpt
Did not find any relation named "tbl_dpt".
machinetest=# \d tbl_dept
                                             Table "public.tbl_dept"
     Column     |         Type          | Collation | Nullable |                     Default
----------------+-----------------------+-----------+----------+-------------------------------------------------
 pk_int_dpt_id  | integer               |           | not null | nextval('tbl_dept_pk_int_dpt_id_seq'::regclass)
 vchr_dept_name | character varying(50) |           |          |
Indexes:
    "tbl_dept_pkey" PRIMARY KEY, btree (pk_int_dpt_id)

7.machinetest=# create table tbl_classes (pk_int_class_id serial primary key,vchr_class_name varchar(50),fk_int_dept_id int,foreign key(fk_int_dept_id) references tbl_dept(pk_int_dpt_id));
CREATE TABLE
machinetest=# \d tbl_classes
                                              Table "public.tbl_classes"
     Column      |         Type          | Collation | Nullable |                       Default
-----------------+-----------------------+-----------+----------+------------------------------------------------------
 pk_int_class_id | integer               |           | not null | nextval('tbl_classes_pk_int_class_id_seq'::regclass)
 vchr_class_name | character varying(50) |           |          |
 fk_int_dept_id  | integer               |           |          |
Indexes:
    "tbl_classes_pkey" PRIMARY KEY, btree (pk_int_class_id)
Foreign-key constraints:
    "tbl_classes_fk_int_dept_id_fkey" FOREIGN KEY (fk_int_dept_id) REFERENCES tbl_dept(pk_int_dpt_id)


8.machinetest=# create table tbl_enrollment (pk_int_enrollment_id serial primary key,int_count int,fk_int_class_id int,foreign key(fk_int_class_id) references tbl_classes(pk_int_class_id));
CREATE TABLE
machinetest=# \d tbl_enrollment
                                            Table "public.tbl_enrollment"
        Column        |  Type   | Collation | Nullable |                           Default
----------------------+---------+-----------+----------+--------------------------------------------------------------
 pk_int_enrollment_id | integer |           | not null | nextval('tbl_enrollment_pk_int_enrollment_id_seq'::regclass)
 int_count            | integer |           |          |
 fk_int_class_id      | integer |           |          |
Indexes:
    "tbl_enrollment_pkey" PRIMARY KEY, btree (pk_int_enrollment_id)
Foreign-key constraints:
    "tbl_enrollment_fk_int_class_id_fkey" FOREIGN KEY (fk_int_class_id) REFERENCES tbl_classes(pk_int_class_id)

9.machinetest=# alter table tbl_classes add unique (vchr_class_name);
ALTER TABLE
machinetest=# \d tbl_classes
                                              Table "public.tbl_classes"
     Column      |         Type          | Collation | Nullable |                       Default
-----------------+-----------------------+-----------+----------+------------------------------------------------------
 pk_int_class_id | integer               |           | not null | nextval('tbl_classes_pk_int_class_id_seq'::regclass)
 vchr_class_name | character varying(50) |           |          |
 fk_int_dept_id  | integer               |           |          |
Indexes:
    "tbl_classes_pkey" PRIMARY KEY, btree (pk_int_class_id)
    "tbl_classes_vchr_class_name_key" UNIQUE CONSTRAINT, btree (vchr_class_name)
Foreign-key constraints:
    "tbl_classes_fk_int_dept_id_fkey" FOREIGN KEY (fk_int_dept_id) REFERENCES tbl_dept(pk_int_dpt_id)
Referenced by:
    TABLE "tbl_enrollment" CONSTRAINT "tbl_enrollment_fk_int_class_id_fkey" FOREIGN KEY (fk_int_class_id) REFERENCES tbl_classes(pk_int_class_id)


10.machinetest=# alter table tbl_dept add column vchr_dept_description varchar(100);
ALTER TABLE
machinetest=# \d tbl_dept
                                                 Table "public.tbl_dept"
        Column         |          Type          | Collation | Nullable |                     Default
-----------------------+------------------------+-----------+----------+-------------------------------------------------
 pk_int_dpt_id         | integer                |           | not null | nextval('tbl_dept_pk_int_dpt_id_seq'::regclass)
 vchr_dept_name        | character varying(50)  |           |          |
 vchr_dept_description | character varying(100) |           |          |
Indexes:
    "tbl_dept_pkey" PRIMARY KEY, btree (pk_int_dpt_id)
Referenced by:
    TABLE "tbl_classes" CONSTRAINT "tbl_classes_fk_int_dept_id_fkey" FOREIGN KEY (fk_int_dept_id) REFERENCES tbl_dept(pk_int_dpt_id)

11.machinetest=# insert into tbl_supplier (vchr_supplier_name) values('Logitech');
INSERT 0 1
machinetest=# insert into tbl_supplier (vchr_supplier_name) values('Samsung');
INSERT 0 1
machinetest=# insert into tbl_supplier (vchr_supplier_name) values('Iball');
INSERT 0 1
machinetest=# insert into tbl_supplier (vchr_supplier_name) values('LG');
INSERT 0 1
machinetest=# insert into tbl_supplier (vchr_supplier_name) values('Creative');
INSERT 0 1
machinetest=# select * from tbl_supplier;
 pk_int_supplier_id | vchr_supplier_name
--------------------+--------------------
                  1 | Logitech
                  2 | Samsung
                  3 | Iball
                  4 | LG
                  5 | Creative
(5 rows)


-- macine-test 2
1.machinetest=# insert into tbl_stock (vchr_name,int_quantity,int_price,fk_int_supplier) values('Mouse','10','500','1');
INSERT 0 1
machinetest=# insert into tbl_stock (vchr_name,int_quantity,int_price,fk_int_supplier) values('Keyboard','5','450','3');
INSERT 0 1
machinetest=# insert into tbl_stock (vchr_name,int_quantity,int_price,fk_int_supplier) values('Modem','10','1200','2');
INSERT 0 1
machinetest=# insert into tbl_stock (vchr_name,int_quantity,int_price,fk_int_supplier) values('Memory','100','1500','5');
INSERT 0 1
machinetest=# insert into tbl_stock (vchr_name,int_quantity,int_price,fk_int_supplier) values('Headphone','50','750','4');
INSERT 0 1
machinetest=# insert into tbl_stock (vchr_name,int_quantity,int_price,fk_int_supplier) values('Memory','2','3500','4');
INSERT 0 1
machinetest=# select * from tbl_stock;
 pk_int_stock_id | vchr_name | int_quantity | int_price | fk_int_supplier
-----------------+-----------+--------------+-----------+-----------------
               5 | Mouse     |           10 |       500 |               1
               6 | Keyboard  |            5 |       450 |               3
               7 | Modem     |           10 |      1200 |               2
               8 | Memory    |          100 |      1500 |               5
               9 | Headphone |           50 |       750 |               4
              10 | Memory    |            2 |      3500 |               4
(6 rows)

2.machinetest=# update tbl_stock set int_price = 505.5 where pk_int_stock_id = 5;
UPDATE 1
machinetest=# update tbl_stock set int_price = 451.5 where pk_int_stock_id = 6;
UPDATE 1
machinetest=# update tbl_stock set int_price = 1201.5 where pk_int_stock_id = 7;
UPDATE 1
machinetest=# update tbl_stock set int_price = 1501.5 where pk_int_stock_id = 8;
UPDATE 1
machinetest=# update tbl_stock set int_price = 751.5 where pk_int_stock_id = 9;
UPDATE 1
machinetest=# update tbl_stock set int_price = 3501.5 where pk_int_stock_id = 10;
UPDATE 1
machinetest=# select * from tbl_stock;
 pk_int_stock_id | vchr_name | int_quantity | int_price | fk_int_supplier
-----------------+-----------+--------------+-----------+-----------------
               5 | Mouse     |           10 |     505.5 |               1
               6 | Keyboard  |            5 |     451.5 |               3
               7 | Modem     |           10 |    1201.5 |               2
               8 | Memory    |          100 |    1501.5 |               5
               9 | Headphone |           50 |     751.5 |               4
              10 | Memory    |            2 |    3501.5 |               4
(6 rows)

3.machinetest=# select * from tbl_stock where int_price > 1000;
 pk_int_stock_id | vchr_name | int_quantity | int_price | fk_int_supplier
-----------------+-----------+--------------+-----------+-----------------
               7 | Modem     |           10 |    1201.5 |               2
               8 | Memory    |          100 |    1501.5 |               5
              10 | Memory    |            2 |    3501.5 |               4
(3 rows)


4.machinetest=# select * from tbl_stock order by vchr_name;
 pk_int_stock_id | vchr_name | int_quantity | int_price | fk_int_supplier
-----------------+-----------+--------------+-----------+-----------------
               9 | Headphone |           50 |     751.5 |               4
               6 | Keyboard  |            5 |     451.5 |               3
               8 | Memory    |          100 |    1501.5 |               5
              10 | Memory    |            2 |    3501.5 |               4
               7 | Modem     |           10 |    1201.5 |               2
               5 | Mouse     |           10 |     505.5 |               1
(6 rows)


5.machinetest=# select * from tbl_stock order by vchr_name limit 3;
 pk_int_stock_id | vchr_name | int_quantity | int_price | fk_int_supplier
-----------------+-----------+--------------+-----------+-----------------
               9 | Headphone |           50 |     751.5 |               4
               6 | Keyboard  |            5 |     451.5 |               3
               8 | Memory    |          100 |    1501.5 |               5
(3 rows)

6.machinetest=# select * from tbl_stock order by vchr_name desc limit 3;
 pk_int_stock_id | vchr_name | int_quantity | int_price | fk_int_supplier
-----------------+-----------+--------------+-----------+-----------------
               5 | Mouse     |           10 |     505.5 |               1
               7 | Modem     |           10 |    1201.5 |               2
               8 | Memory    |          100 |    1501.5 |               5
(3 rows)

7.machinetest=# select vchr_name,int_quantity,int_price,int_quantity*int_price as extended_price from tbl_stock;
 vchr_name | int_quantity | int_price | extended_price
-----------+--------------+-----------+----------------
 Mouse     |           10 |     505.5 |           5055
 Keyboard  |            5 |     451.5 |         2257.5
 Modem     |           10 |    1201.5 |          12015
 Memory    |          100 |    1501.5 |         150150
 Headphone |           50 |     751.5 |          37575
 Memory    |            2 |    3501.5 |           7003
(6 rows)

8.machinetest=# delete from tbl_stock where fk_int_supplier = 5;
DELETE 1
machinetest=# select * from tbl_stock;
 pk_int_stock_id | vchr_name | int_quantity | int_price | fk_int_supplier
-----------------+-----------+--------------+-----------+-----------------
               5 | Mouse     |           10 |     505.5 |               1
               6 | Keyboard  |            5 |     451.5 |               3
               7 | Modem     |           10 |    1201.5 |               2
               9 | Headphone |           50 |     751.5 |               4
              10 | Memory    |            2 |    3501.5 |               4
(5 rows)

9.machinetest=# insert into tbl_dept (vchr_dept_name,vchr_dept_description) values('Computer Science','CS');
INSERT 0 1
machinetest=# insert into tbl_dept (vchr_dept_name,vchr_dept_description) values('Electronics','EC');
INSERT 0 1
machinetest=# insert into tbl_dept (vchr_dept_name,vchr_dept_description) values('Commerce','CC');
INSERT 0 1
machinetest=# insert into tbl_dept (vchr_dept_name,vchr_dept_description) values('Arts','AR');
INSERT 0 1
machinetest=# select * from tbl_dept;
 pk_int_dpt_id |  vchr_dept_name  | vchr_dept_description
---------------+------------------+-----------------------
             1 | Computer Science | CS
             2 | Electronics      | EC
             3 | Commerce         | CC
             4 | Arts             | AR
(4 rows)


-- Machine test 3
1.machinetest=# select sum(int_quantity*int_price) from tbl_stock;
   sum
---------
 63905.5
(1 row)


2.machinetest=# select sum(int_quantity) from tbl_stock;
 sum
-----
  77
(1 row)

3.machinetest=# select upper(vchr_name),round(int_price) from tbl_stock;
   upper   | round
-----------+-------
 MOUSE     |   506
 KEYBOARD  |   452
 MODEM     |  1202
 HEADPHONE |   752
 MEMORY    |  3502
(5 rows)


4.machinetest=# select count(vchr_name)as items from tbl_stock;
 items
-------
     5
(1 row)

5.machinetest=# select max(int_price) from tbl_stock;
  max
--------
 3501.5
(1 row)
machinetest=# select vchr_name,int_price from tbl_stock where int_price > 1500;
 vchr_name | int_price
-----------+-----------
 Memory    |    3501.5
(1 row)

6.machinetest=# select sum(int_count)as total_enrollment from tbl_enrollment;
 total_enrollment
------------------
              351
(1 row)

7.machinetest=# select count(*)as no_of_classes from tbl_classes;
 no_of_classes
---------------
             7
(1 row)

8.already done 

9.machinetest=# select CONCAT(vchr_name, int_price) AS product_price from tbl_stock;
 product_price
----------------
 Mouse505.5
 Keyboard451.5
 Modem1201.5
 Headphone751.5
 Memory3501.5
(5 rows)







