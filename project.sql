CREATE DATABASE OnlineStore;
use OnlineStore;

CREATE TABLE Categories (
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50) NOT NULL,
Description TEXT
);

# Create Products Table
CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(255) NOT NULL,
Description TEXT,
Price DECIMAL(10, 2) NOT NULL,
QuantityInStock INT NOT NULL
);

# Create Customers Table
CREATE TABLE Customers (
CustomerID INT PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Email VARCHAR(255) UNIQUE NOT NULL,
Address TEXT,
PhoneNumber VARCHAR(15)
);

# Create Users Table (for authentication)
CREATE TABLE Users (
UserID INT PRIMARY KEY,
Username VARCHAR(50) UNIQUE NOT NULL,
Password VARCHAR(255) NOT NULL,
Email VARCHAR(255) UNIQUE NOT NULL,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL
);

# Create Orders Table
CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
OrderDate DATE NOT NULL,
TotalAmount DECIMAL(10, 2) NOT NULL,
Status VARCHAR(20) NOT NULL
);

# Create OrderDetails Table
CREATE TABLE OrderDetails (
OrderDetailID INT PRIMARY KEY,
OrderID INT,
ProductID INT,
Quantity INT NOT NULL,
Subtotal DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
# add a foreign key to 
alter table customers add UserID int;

alter table customers add foreign key (UserID) references users (UserID);
alter table products add CategoryID int;
alter table products add foreign key(CategoryID)references categories(CategoryID);
#add foreign key to orders
alter table  orders add CustomerID int;
alter table orders add foreign key(CustomerID)references customers (CustomerID);
-- Add more tables or modify as needed based on your specific requirements
# Insert Sample Data into Categories Table
INSERT INTO Categories (CategoryID, CategoryName, Description)
VALUES(1, 'Electronics', 'Electronic devices and accessories'),
	  (2, 'Clothing', 'Fashion apparel and accessories'),
      (3, 'Footwear', 'Shoes and related items'),
      (4, 'Home & Furniture', 'Home decor and furniture'),
      (5, 'Books', 'Books and literature');


INSERT INTO Products (ProductID, ProductName, Description, Price, QuantityInStock, CategoryID)
VALUES(1, 'Smartphone X', 'High-end smartphone', 9999.00, 50, 1),
      (2, 'Laptop Pro', 'Powerful laptop for professionals', 32599.99, 30, 1),
      (3, 'Casual T-Shirt', 'Comfortable cotton T-shirt', 800.00, 100, 2),
      (4, 'Running Shoes', 'Lightweight running shoes', 2000.00, 50, 3),
      (5, 'Coffee Table', 'Modern coffee table for living room', 4500.00, 20, 4);


INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Address, PhoneNumber)
VALUES(1, 'Dennis', 'Nadar' , 'denn@gmail.com', 'chembur Main St, diamond garden','9004451019'),
      (2, 'Roger', 'Mel', 'roger@gmail.com', 'chembur Main St, diamond garden','8992929921'),
      (3, 'Mayur', 'Pnassare' , 'mayur@gmail.com','vashi sec 30 ','9224451019'),
      (4, 'Nivetha', 'Thomas' , 'nivu@gmail.com', 'juinagar sec 7','7004451019'),
      (5, 'Akash', 'Pandey' , 'akki@gmail.com', 'Panvel sec 46', '8904451019');

# Insert Sample Data into Users Table
INSERT INTO Users (UserID, Username, Password, Email, FirstName, LastName)
VALUES (1001, 'Denn_11', 'denn1211' , 'denn@gmail.com', 'Dennis','Nadar'),
      (1002, 'Roger_12', 'rog1133', 'roger@gmail.com', 'Roger','Mel'),
      (1003, 'MaINy_13', 'may2111' , 'mayur@gmail.com','Mayur ','Pnassare'),
      (1004, 'Nivu_14', 'nivu1311' , 'nivu@gmail.com', 'Nivetha','Thomas'),
      (1005, 'Aka_15', 'aka1451' , 'akki@gmail.com', 'Akash', 'Pandey');


INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, Status)
VALUES(101, 1, '2023-01-10', 9999.00, 'Shipped'),
      (102, 2, '2023-02-15', 32599.99, 'Processing'),
      (103, 3, '2023-03-20', 800.00, 'Delivered'),
      (104, 4, '2023-04-25', 2000.00, 'Shipped'),
	  (105, 5, '2023-05-30', 4500.00, 'Processing');
alter table orders add order_items varchar(50);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Subtotal)
VALUES(1, 101, 1, 2, 9400.00),
      (2, 102, 3, 3, 31900.50),
      (3, 103, 5, 1, 700.00),
      (4, 104, 2, 2, 1950.98),
      (5, 105, 4, 4, 4200.96);

# Update Order Status
UPDATE Orders
SET Status = 'Shipped'
WHERE OrderID = 101;
# Select the first 5 products from the Products table
SELECT * FROM Products
LIMIT 3;
#Select products with a price greater than 2000 
SELECT * FROM Products
WHERE Price > 2000;
# Count the number of products in each category
SELECT CategoryID, COUNT(ProductID) 
FROM Products
GROUP BY CategoryID;
#total sales amount for each customer
SELECT CustomerID, SUM(TotalAmount) 
FROM Orders
GROUP BY CustomerID;
#Select products ordered by price in descending order
SELECT * FROM Products
ORDER BY Price DESC;
#Select products with a price greater than 9000 and in the "Electronics" category
SELECT * FROM Products
WHERE Price > 9000 AND CategoryID = 1;
# Select products with a price between 600 and 20000
SELECT * FROM Products
WHERE  Price BETWEEN 600 AND 20000;
# Select products in the "Electronics" or "Clothing" category
SELECT * FROM Products
WHERE CategoryID = 1 OR CategoryID = 2;
# Select products that are not in the "Electronics" category
SELECT * FROM Products
WHERE NOT CategoryID = 1;
# Select products in the "Electronics" or "Clothing" category using IN
SELECT * FROM Products
WHERE CategoryID IN (1, 2);
# Select customers with the last name starting with "S"
SELECT * FROM Customers
WHERE LastName LIKE 'P%';
# Get the average price of all products using Aggregate functions
SELECT AVG(Price)
FROM Products;
alter table products add CustomerID int;
alter table products add foreign key(CustomerID)
# Get the total quantity of all products using aggregate functions
select sum(QuantityInStock) 
from products;
# Find categories with average product prices greater than 3000 using having clause
SELECT CategoryID, AVG(Price) 
FROM Products
GROUP BY CategoryID
HAVING AVG(Price) > 3000;
# Select orders along with customer information using INNER JOIN
SELECT *
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;
 #Select all products along with their category information using RIGHT JOIN
SELECT *
FROM Orders
RIGHT JOIN Customer ON Orders.CustomerID = Customers.CustomerID;
select order_items,count(CustomerID)
from orders
group by order_items;
# Select all products along with their category information using LEFT JOIN
SELECT * 
FROM orderdetails
RIGHT JOIN products ON orderdetails.ProductID = products.ProductID;
#subquery
SELECT *
FROM customers where CustomerID =
(SELECT CustomerID FROM orders WHERE(TotalAmount)=
(SELECT MAX(TotalAmount) FROM or



alter table products drop column CustomerID;
select order_items,count(CustomerID)
from orders
group by order_items;
create table returned (
return_id int primary key,
returned_item varchar(50),
returned_date date,
refund_amount varchar(50)
);
insert into returned(return_id,returned_item,returned_date,refund_amount)
values(1001,'Casual T-shirt','2023-05-25','750.00'),
       (1002,'Smartphone X','2023-05-28','9999.00');
       alter table returned add CustomerID int;
       alter table returned add foreign key (CustomerID) references customers (CustomerID);
       select *
       from returned 
        join customers on returned.CustomerID = customers.CustomerID;
       drop table orderdetails;
       INSERT INTO Users (UserID, Username, Password, Email, FirstName, LastName)
VALUES (1007, 'ren_11', 'renn1211' , 'renn@gmail.com', 'Renu','Nadar'),
(1008, 'naq_11', 'nar1211' , 'nann@gmail.com', 'Narain','Nadar'),
(1009, 'nae_11', 'rarn1211' , 'nant@gmail.com', 'Ashok','Nadar'),
(1010, 'na_t11', 'tarn1211' , 'nanr@gmail.com', 'Sunder','Nadar');
 
 select * from customers where CustomerID in (
 select CustomerID from orders where status = "processing");
 
 select status ,count(customerid)
 from orders 
 group by status;