create database Assignment;
use assignment;
CREATE TABLE Customers (
CustomerID INT,
CustomerName VARCHAR(50),
City VARCHAR(30),
JoinDate DATE
);
INSERT INTO Customers VALUES
(101,'Rahul Sharma','Bangalore','2023-01-15'),
(102,'Priya Mehta','Mumbai','2024-03-20'),
(103,'Arjun Nair','Chennai','2025-01-12'),
(104,'Sneha Gupta','Delhi','2022-07-10'),
(105,'Kavya Reddy','Hyderabad','2024-08-15'),
(106,'Amit Verma','Pune','2023-11-05'),
(107,'Rohan Singh','Kolkata','2024-05-18'),
(108,'Simran Kaur','Delhi','2025-02-01'),
(109,'Anjali Jain','Mumbai','2023-09-22'),
(110,'Vikram Patel','Ahmedabad','2022-12-30');
CREATE TABLE Orders (
OrderID INT,
CustomerID INT,
OrderDate DATE,
OrderAmount DECIMAL(10,2),
Status VARCHAR(20)
);
INSERT INTO Orders VALUES
(5001,101,'2025-01-05',12000,'Delivered'),
(5002,102,'2025-01-15',8500,'Pending'),
(5003,101,'2025-02-10',22000,'Delivered'),
(5004,104,'2025-02-15',4500,'Cancelled'),
(5005,103,'2025-03-01',17500,'Delivered'),
(5006,105,'2025-03-10',9800,'Pending'),
(5007,106,'2025-03-18',25000,'Delivered'),
(5008,107,'2025-04-02',14500,'Delivered'),
(5009,101,'2025-04-10',30000,'Delivered'),
(5010,109,'2025-04-15',6500,'Pending'),
(5011,110,'2025-05-01',42000,'Delivered'),
(5012,104,'2025-05-08',18000,'Delivered'),
(5013,106,'2025-05-15',7000,'Cancelled'),
(5014,102,'2025-05-20',27000,'Delivered'),
(5015,107,'2025-06-01',15500,'Pending');
CREATE TABLE Employees (
EmployeeID INT,
EmployeeName VARCHAR(50),
ManagerID INT,
Department VARCHAR(30),
JoiningDate DATE,
Salary DECIMAL(10,2)
);
INSERT INTO Employees VALUES
(1,'Rajesh Kumar',NULL,'Management','2018-01-10',150000),
(2,'Neha Sharma',1,'Sales','2020-03-15',90000),
(3,'Amit Gupta',1,'IT','2019-06-20',110000),
(4,'Priyanka Singh',2,'Sales','2022-01-12',65000),
(5,'Vikas Patel',2,'Sales','2021-09-18',70000),
(6,'Rohit Jain',3,'IT','2023-02-05',60000),
(7,'Anjali Verma',3,'IT','2022-11-10',62000),
(8,'Karan Mehta',1,'HR','2021-05-25',80000),
(9,'Sneha Kapoor',8,'HR','2024-01-05',50000),
(10,'Arjun Malhotra',3,'IT','2024-04-15',55000);
show tables;
select * from customers;
select * from employees;
select * from orders;

----- Q. 1 
select customers.CustomerName, orders.OrderAmount 
from customers inner join orders on customers.customerID=orders.customerID
order by orderamount desc limit 5;

-----  Q. 2
select * from customers where left(customerName, 1) in ('A', 'R', 'S');

----- Q. 3
select customers.CustomerName, orders.OrderId, orders.OrderAmount, orders.Status
from customers inner join orders on customers.customerID=orders.customerID 
where orderamount>10000 and status='pending';

-----  Q. 4
select *, datediff(Current_Date, joinDate)
as Days from customers where datediff(Current_Date, joinDate) > 365;

----- Q. 5
select OrderId, OrderAmount as CurrentAmount, 
(orderAmount * 0.18) as GST_18_Percent, (orderamount * 1.18) as TotalAmountAfterGST,
date_add(orderdate, interval 15 day) as ExpectedCollectionDate
from orders;

----- Q. 6
select orders.CustomerId,customers.CustomerName, orders.OrderAmount, 
rank() over(order by orders.orderamount desc) as Ranking
from customers inner join orders on customers.customerID=orders.customerID
limit 10 offset 10;

----- Q. 7
select CustomerId, CustomerName, Joindate, 
datediff(now(), joindate) as Days_SinceRegistration from customers;

----- Q. 8 
select employeeName as EmployeeName, managerid as ManagerName, Department from employees;

----- Q. 9
select customers.CustomerName, Customers.Joindate, orders.OrderDate, 
datediff(orders.orderdate, customers.joindate) as Days_Taken_To_Place_First_Order
from customers inner join orders on customers.customerID=orders.customerID 
where datediff(orders.orderdate, customers.joindate)<30;

----- Q. 10
select customers.CustomerName, sum(orders.orderamount) as Total_Purchase_Amount,  
case
when sum(orders.orderamount) > 50000 then "Premium"
when sum(orders.orderamount) between 20000 and 50000 then "Gold"
when sum(orders.orderamount) < 20000 then "Silver"
end as Spending_Category,
case
when year(min(customers.joindate))<2024 then "Loyal Customer"
else "New Customer"
end as Loyalty_Status
from customers inner join orders on customers.customerID=orders.customerID
group by customers.customername; 

----- Q. 11
select customers.CustomerName, orders.OrderID, orders.OrderAmount 
from customers Inner join orders on customers.customerID=orders.customerID 
where orders.orderamount > (select avg(orderamount) from orders);

----- Q. 12
select customers.CustomerName, orders.OrderID, orders.OrderAmount 
from customers Inner join orders on customers.customerID=orders.customerID
order by orders.orderamount desc limit 5 offset 1;

