create database warehouse ;


# Headquarter Database

use warehouse ;
create table customer(
    customer_id varchar(20),
    customer_name varchar(20),
    city_id varchar(20),
    first_order_date date 
);

insert into customer values('1','pratham','1','2023-03-14') ;


use warehouse ;
create table walk_in_customers (
	customer_id varchar(20) ,
    tourism_guide varchar(50) ,
    timing date, 
    foreign key(customer_id) references customer(customer_id)
);

use warehouse ;
insert into walk_in_customers values('1','prathamesh','2023-03-14') ;

create table mail_order_customers (
	customer_id varchar(20) ,
    post_address varchar(50) ,
    timing date, 
    foreign key(customer_id) references customer(customer_id)
);

insert into mail_order_customers values('1','sahyog nagar','2023-03-14') ;

#Sales Database

use warehouse ;
create table Headquarters (
	city_id varchar(20) primary key,
    city_name varchar(50) ,
    headquarters_addr varchar(50),
    state varchar(20),
    timing date
);

insert into Headquarters values('1','Sangli','vishrambagh','MH','2023-03-14');

use warehouse ;
create table Stores (
	store_id varchar(20) primary key,
    city_id varchar(50) ,
    phone varchar(20),
    timing date,
    foreign key(city_id) references Headquarters(city_id) 
);

insert into Stores values('1','1','1234567890','2023-03-14');

use warehouse ;
create table Items (
	item_id varchar(20) primary key,
    description varchar(50) ,
    size int,
    weight int,
    unit_price int,
    timing date
);

insert into Items values('1','This is descr',1,1,12,'2023-03-14');


use warehouse ;
create table Stored_Items (
    store_id varchar(20) ,
	item_id varchar(20),
	quantity_held int,
    timing date,
    primary key(store_id,item_id),
    foreign key(store_id) references Stores(store_id) ,
    foreign key(item_id) references items(item_id) 
);

insert into Stored_Items values('1','1',13,'2023-03-14');


use warehouse ;
create table orders (
    order_no varchar(20) primary key,
    order_date date,
    customer_id varchar(20)
);

insert into orders values('1','2023-03-14','1');


use warehouse ;
create table Ordered_Items (
    order_no varchar(20) ,
	item_id varchar(20),
	quantity_ordered int,
    ordered_price int,
    timing date,
    primary key(order_no,item_id),
    foreign key(order_no) references orders(order_no) ,
    foreign key(item_id) references items(item_id) 
);

insert into Ordered_Items values('1','1',13,1232,'2023-03-14');


#Q1

use warehouse ;
create table stores_data(
    city_name varchar(50) ,
    state varchar(20),
    phone varchar(20),
    description varchar(50) ,
    size int,
    weight int,
    unit_price int
);


select city_name, state,phone,description,size,weight,unit_price
from Items,stores,Headquarters ;

insert into stores_data 
	select city_name, state,phone,description,size,weight,unit_price
	from Items,stores,Headquarters ;
    

select * from stores_data ;

#Q2

use warehouse ;
create table Q2(
	store_id varchar(20),
    order_no varchar(20),
    customer_name varchar(20),
    order_date date
);

select stores.store_id,orders.order_no,customer_name,order_date
from stores,orders,Ordered_items,customer,Stored_Items 
where quantity_ordered <= quantity_held ;

insert into Q2 
select stores.store_id,orders.order_no,customer_name,order_date
from stores,orders,Ordered_items,customer,Stored_Items 
where quantity_ordered <= quantity_held ;


#Q3

use warehouse ;
create table Q3(
	customer_id varchar(20),
    store_id varchar(20),
    city_name varchar(20),
    phone varchar(20)
);

select customer.customer_id,stores.store_id,city_name,phone 
from orders,customer,Stored_Items,Stores,Headquarters ;

insert into Q3
select customer.customer_id,stores.store_id,city_name,phone 
from orders,customer,Stored_Items,Stores,Headquarters ;

#Q4
use warehouse ;
create table Q4(
	city_name varchar(50) ,
    headquarters_addr varchar(50),
    state varchar(20),
    quantity_held varchar(20)
);

select city_name,headquarters_addr,state,quantity_held
from Headquarters,Stored_items ;

insert into Q4 
select city_name,headquarters_addr,state,quantity_held
from Headquarters,Stored_items ;

# Q5

create table Q5(
	order_no varchar(20),
    item_id varchar(20),
    description varchar(20),
    store_id varchar(20),
    city_name varchar(20)
);

select order_no,item_id,description,store_id,city_name
from orders,((Stored_Items natural join items) natural join Stores) natural join Headquarters ;

insert into Q5
select order_no,item_id,description,store_id,city_name
from orders,((Stored_Items natural join items) natural join Stores) natural join Headquarters ;


# Q6

create table Q6(
	customer_id varchar(20),
    city_name varchar(20),
    state varchar(20)
);

select customer_id,city_name,state
from customer natural join Headquarters ;

insert into Q6
select customer_id,city_name,state
from customer natural join Headquarters ;

# Q7

create table Q7(
    quantity_held int,
    item_id varchar(20),
    city_name varchar(20)
);

select sum(quantity_held),item_id,city_name
from (Stored_items natural join stores) natural join Headquarters ;

insert into Q7
select sum(quantity_held),item_id,city_name
from (Stored_items natural join stores) natural join Headquarters ;


# Q8

create table Q8(
	order_no varchar(20),
    item_id varchar(20),
    quantity_ordered int,
    customer_id varchar(20),
    store_id varchar(20),
    city_id varchar(20)
);

select order_no,item_id,quantity_ordered,customer_id,store_id,city_id
from (Ordered_items natural join orders natural join stored_items) natural join stores ;

insert into Q8
select order_no,item_id,quantity_ordered,customer_id,store_id,city_id
from (Ordered_items natural join orders natural join stored_items) natural join stores ;


# Q9

create table Q9(
	customer_id varchar(20)
);

select customer_id
from walk_in_customers natural join mail_order_customers ;

insert into Q9
select customer_id
from walk_in_customers natural join mail_order_customers ;