create database Blinkit;
use blinkit;

create table products
(product_id varchar(10) Primary key,
product_name varchar(50),
category varchar(50),
price int,
stock_qty int);

create table customers(
customer_id varchar(10) primary key,
customer_name varchar(100),
city varchar(40),
join_date date);


create table orders(
order_id varchar(10) primary key,
customer_id varchar (10),
order_date date,
total_amount int,
delivery_Status varchar (20),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id));

create table order_details (
order_id varchar(10),
product_id varchar(10),
quantity int,
subtotal int,
foreign key (order_id) references orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE reviews (
    review_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    product_id VARCHAR(10),
    rating INT,
    review_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE delivery (
    delivery_id VARCHAR(10) PRIMARY KEY,
    order_id VARCHAR(10),
    delivery_date DATE,
    delivery_time_mins INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO products VALUES 
('P101', 'Aashirvaad Atta 5kg', 'Grocery', 250, 120),
('P102', 'Amul Butter 500g', 'Dairy', 275, 60),
('P103', 'Parle-G 1kg Pack', 'Snacks', 80, 200),
('P104', 'Dove Shampoo 340ml', 'Personal Care', 230, 45),
('P105', 'Fortune Rice 1kg', 'Grocery', 110, 100);

INSERT INTO customers VALUES 
('C001', 'Neha Sharma', 'Delhi', '2023-10-11'),
('C002', 'Rajat Verma', 'Mumbai', '2023-12-03'),
('C003', 'Anjali Mehta', 'Bangalore', '2024-01-19'),
('C004', 'Aman Kapoor', 'Noida', '2024-03-22'),
('C005', 'Simran Kaur', 'Chandigarh', '2024-05-05'),
('C006', 'Vikram Singh', 'Pune', '2024-02-15'),
('C007', 'Priya Jain', 'Kolkata', '2024-03-30'),
('C008', 'Rohit Nair', 'Delhi', '2024-04-10'),
('C009', 'Megha Joshi', 'Hyderabad', '2024-05-18'),
('C010', 'Tarun Patel', 'Ahmedabad', '2024-06-01');

INSERT INTO orders VALUES 
('O5001', 'C001', '2024-06-01', 610, 'Delivered'),
('O5002', 'C002', '2024-06-03', 275, 'Delivered'),
('O5003', 'C004', '2024-06-05', 190, 'Cancelled'),
('O5004', 'C005', '2024-06-06', 250, 'Delivered'),
('O5005', 'C001', '2024-06-08', 110, 'Delivered'),
('O5006', 'C006', '2024-06-09', 385, 'Delivered'),
('O5007', 'C007', '2024-06-10', 450, 'Pending'),
('O5008', 'C008', '2024-06-11', 540, 'Delivered'),
('O5009', 'C009', '2024-06-12', 120, 'Delivered'),
('O5010', 'C010', '2024-06-13', 300, 'Delivered');

INSERT INTO order_details VALUES 
('O5001', 'P101', 1, 250),
('O5001', 'P102', 1, 275),
('O5001', 'P103', 1, 80),
('O5002', 'P102', 1, 275),
('O5004', 'P101', 1, 250),
('O5005', 'P105', 1, 110),
('O5006', 'P104', 1, 230),
('O5006', 'P105', 1, 110),
('O5007', 'P103', 2, 160),
('O5008', 'P101', 1, 250),
('O5008', 'P102', 1, 275),
('O5009', 'P105', 1, 110),
('O5010', 'P104', 1, 230);

INSERT INTO reviews VALUES 
('R1001', 'C001', 'P101', 4, '2024-06-02'),
('R1002', 'C002', 'P102', 5, '2024-06-04'),
('R1003', 'C004', 'P103', 2, '2024-06-06'),
('R1004', 'C005', 'P101', 4, '2024-06-07'),
('R1005', 'C001', 'P105', 5, '2024-06-09'),
('R1006', 'C006', 'P104', 3, '2024-06-10'),
('R1007', 'C007', 'P103', 5, '2024-06-11'),
('R1008', 'C008', 'P102', 4, '2024-06-12'),
('R1009', 'C009', 'P105', 3, '2024-06-13'),
('R1010', 'C010', 'P104', 4, '2024-06-14');

INSERT INTO delivery VALUES 
('D9001', 'O5001', '2024-06-01', 35),
('D9002', 'O5002', '2024-06-03', 28),
('D9003', 'O5004', '2024-06-06', 45),
('D9004', 'O5005', '2024-06-08', 25),
('D9005', 'O5006', '2024-06-09', 30),
('D9006', 'O5008', '2024-06-11', 22),
('D9007', 'O5009', '2024-06-12', 40),
('D9008', 'O5010', '2024-06-13', 27);
