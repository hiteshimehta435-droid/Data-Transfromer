create database Datatransfromer;
use Datatransfromer;

create table customers(
customer_id int primary key,
first_name varchar(50),
last_name varchar(50),
Email varchar(100),
RegistrationDate date);

INSERT INTO customers VALUES
(1, 'John', 'Doe', 'john.doe@gmail.com', '2023-01-15'),
(2, 'Jane', 'Smith', 'jane.smith@gmail.com', '2023-02-20'),
(3, 'David', 'Brown', 'david.brown@gmail.com', '2023-03-10'),
(4, 'Emma', 'Wilson', 'emma.wilson@gmail.com', '2023-04-05');

select * from customers;

create table orders(
order_id int primary key,
customer_id int,
orderdate date,
total_amount decimal(10,2),

foreign key (customer_id)
references customers(customer_id));

INSERT INTO orders VALUES
(101, 1, '2023-07-01', 150.50),
(102, 2, '2023-07-03', 200.75),
(103, 1, '2023-07-05', 500.00),
(104, 3, '2023-07-10', 750.25),
(105, 2, '2023-07-15', 120.00);

select * from orders;
create table employees(
employee_id int primary key,
first_name varchar(50),
last_name varchar(50),
department varchar(50),
hiredate date,
salary decimal(10,2));

insert into employees values
(1, 'Mark', 'Johnson', 'Sales', '2020-01-10', 50000),
(2, 'Susan', 'Lee', 'HR', '2021-03-15', 60000),
(3, 'Robert', 'Brown', 'IT', '2019-06-20', 75000),
(4, 'Emily', 'Davis', 'Sales', '2022-02-05', 45000);
select * from employees;

select c.customer_id,c.first_name,c.last_name,o.order_id,o.orderdate,o.total_amount from customers c inner join orders o on c.customer_id = o.customer_id;

select c.customer_id,c.first_name,c.last_name,o.order_id,o.total_amount from customers c left join orders o on c.customer_id = o.customer_id;

select c.customer_id,c.first_name,c.last_name,o.order_id,o.total_amount from customers c right join orders o on c.customer_id = o.customer_id;

select c.customer_id,c.first_name,c.last_name,o.order_id,o.total_amount from
customers c left join orders o on c.customer_id = o.customer_id
union
select c.customer_id,c.first_name,c.last_name,o.order_id,o.total_amount from
customers c right join orders o on c.customer_id = o.customer_id;

select * from orders where total_amount > ( select avg(total_amount) from orders);

select * from employees where salary > (select avg(salary) from employees);

select order_id,orderdate,year(orderdate) as orderyear,month(orderdate) as ordermonth from orders;

select order_id,orderdate, datediff(curdate(), orderdate) as daysdiffernce from orders;

select order_id,date_format(orderdate, '%d-%m-%y') as formateddate from orders;

select customer_id, concat(first_name, ' ',last_name) as fullname from customers;

select first_name , replace(first_name,'John', 'Jonathan') as newname from customers;

select upper(first_name) as upperfirstname,lower(last_name) as lowerlastname from customers;

select email,trim(email) as cleanemail from customers;

select order_id,orderdate,total_amount, sum(total_amount) over(order by orderdate) as runingtotal from orders;

select order_id,total_amount, rank() over ( order by total_amount desc) as orderrank from orders;

select order_id,total_amount, case when total_amount > 1000 then total_amount * 0.10 else total_amount * 0.05 end as discount from orders;

select employee_id,first_name,salary,case when salary >= 70000 then 'High' when salary >= 50000 then 'Medium' else 'low' end as salarycategory from employees;