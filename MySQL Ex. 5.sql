Ex.No: 05

1. Create tables: customer, product and orders 
2. Insert sample data for 5 customers and 5 products 
3. Display all products ordered by a specific customer using JOIN  
4. Find customers who haven't placed any orders using NOT IN   
5. Create a view that shows product name, quantity and customer name


mysql> CREATE DATABASE sales;

mysql> USE sales;
Database changed

mysql> # CREATE TABLE CUSTOMER
mysql> CREATE TABLE customer (
    -> customer_id INT PRIMARY KEY NOT NULL,
    -> customer_name VARCHAR(25) NOT NULL,
    -> email VARCHAR(30) UNIQUE,
    -> phone VARCHAR(20),
    -> address VARCHAR(50)
    -> );


mysql> # CREATE TABLE PRODUCT
mysql> CREATE TABLE product (
    -> product_id INT PRIMARY KEY NOT NULL,
    -> product_name VARCHAR(25) NOT NULL,
    -> description TEXT,
    -> price DECIMAL(10,2) NOT NULL
    -> );

mysql> # CREATE TABLE ORDERS
mysql> CREATE TABLE orders (
    -> order_id INT PRIMARY KEY NOT NULL,
    -> customer_id INT,
    -> product_id INT,
    -> order_date DATE NOT NULL,
    -> quantity INT NOT NULL,
    -> FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    -> FOREIGN KEY (product_id) REFERENCES product(product_id)
    -> );

# INSERT SAMPLE DATA
mysql> INSERT INTO customer (customer_id, customer_name, email, phone, address) VALUES
    -> (1,'Herbert','herbi@sales.com','9876543211','Chennai'),
    -> (2,'Dhamodar','dhamo@sales.com','9876543212','Bengaluru'),
    -> (3,'Bharani','bharani@sales.com','9876543213','Mysore'),
    -> (4,'Emil Kumar','emilkumar@sales.com','9876543214','Hyderabad'),
    -> (5,'Rajesh','rajesh@sales.com','9876543215','Trivandrum');


mysql> INSERT INTO product (product_id,product_name,description,price) VALUES
    -> (1000,'Laptop','High-performance laptop',60000.00),
    -> (1001,'Mouse','Wireless',1000.00),
    -> (1002,'Keyboard','Mechanical Gaming Keyboard',5000.00),
    -> (1003,'Monitor','27-inch 4K Monitor',15000.00),
    -> (1004,'Webcam','1080p HD Webcam',10000.00);

mysql> INSERT INTO orders (order_id, customer_id, product_id, order_date, quantity) VALUES
    -> (90,1,1000,'2026-01-10',1),
    -> (80,1,1001,'2026-01-10',1),
    -> (70,2,1002,'2026-01-15',2),
    -> (60,3,1003,'2026-01-18',1),
    -> (50,4,1000,'2026-01-21',1),
    -> (40,5,1004,'2026-01-24',1),
    -> (30,2,1003,'2026-01-25',1);

mysql> # DISPLAY ALL PRODUCTS ORDERED BY A SPECIFIC CUSTOMER USING JOIN

mysql> SELECT
    -> p.product_name,
    -> o.quantity
    -> FROM
    -> orders o
    -> JOIN
    -> customer c ON o.customer_id = c.customer_id
    -> JOIN
    -> product p ON o.product_id = p.product_id
    -> WHERE
    -> c.customer_name = 'Herbert';

mysql> # FIND CUSTOMERS WHO HAVEN'T PLACED ANY ORDERS USING NOT IN

mysql> SELECT
    -> customer_id,
    -> customer_name
    -> FROM
    -> customer
    -> WHERE
    -> customer_id NOT IN (SELECT DISTINCT customer_id FROM orders);

\* If the output is Empty Set then Delete any customer from Orders Table */

mysql> DELETE FROM orders WHERE customer_id=5;

mysql> SELECT * FROM orders;

mysql> SELECT
    -> customer_id,
    -> customer_name
    -> FROM
    -> customer
    -> WHERE
    -> customer_id NOT IN (SELECT DISTINCT customer_id FROM orders);

\* Now the output is not empty set */

mysql> # CREATE A VIEW THAT SHOWS PRODUCT NAME, QUANTITY and CUSTOMER NAME

mysql> CREATE VIEW product_order_customer_view AS
    -> SELECT
    -> p.product_name,
    -> o.quantity,
    -> c.customer_name AS customer_full_name
    -> FROM
    -> orders o
    -> JOIN
    -> product p ON o.product_id = p.product_id
    -> JOIN
    -> customer c ON o.customer_id = c.customer_id;

\* To then select from this view to display all info in the view */

mysql> SELECT * FROM product_order_customer_view;





