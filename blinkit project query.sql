use blinkit;
--                                                     PROJECT TASKS 

--                                      Basic Level (SELECT, WHERE, ORDER BY, LIMIT, LIKE, BETWEEN,subquery)

-- 1.Find all orders placed after ‘2024-06-05’.
select * from orders where order_date > '2024-06-05';

-- 2.List products priced between 100 and 300.
select * from products where price between 100 and 300;

-- 3.Show all customers whose names start with ‘A’.
select * from customers where customer_name like 'a%';

-- 4.Display the top 5 most expensive products.
select * from products order by price desc limit 5;
--                    OR 
select *, dense_rank() over(order by price desc) as "expensive products" from products limit 5 ;

-- 5.List orders that are either "Pending" or "Cancelled".
select * from orders where delivery_status in ("Pending" , "Cancelled");

-- 6. Count how many products are in the “Grocery” category.
Select count(*) as "Total Grocery Products" from products where category = "Grocery";

-- 7. Show the product(s) with stock less than 50.
select * from products where stock_qty < 50;


--                                Intermediate Level (JOINS, GROUP BY, AGGREGATES, ALIAS, IN/NOT IN)
use blinkit;
-- 9. Show product name, quantity, and subtotal for each order.

select order_id,product_name, quantity, subtotal from order_details
join products on products.product_id = order_details.product_id;

-- 10. Find the total number of orders placed by each customer.
select c.customer_id,customer_name, count(o.customer_id) "total orders" from customers c
left join  orders o on c.customer_id = o.customer_id
group by c.customer_id;

-- 11. List the number of products ordered in each category.
select category,count(o.product_id) as "number of products ordered" from products 
join order_details o on products.product_id = o.product_id
group by category;

use blinkit;
-- 12. Show customers who have never placed an order.
select c.customer_id,customer_name from customers c
left join  orders o on c.customer_id = o.customer_id
where order_id is null
group by c.customer_id;

-- 13. Get the total revenue generated from each product.
select products.product_id,product_name,sum(subtotal) as "total revenue" from products 
join order_details o on products.product_id = o.product_id
group by 1;

-- 14. Find customers who placed more than 1 order.
select orders.customer_id,customer_name, count(orders.customer_id) as "more than 1 order" from customers
join orders on orders.customer_id = customers.customer_id 
group by orders.customer_id
having count(orders.customer_id) > 1;


-- 16. Show the average rating received by each product.
select p.product_id,product_name,avg(rating) from reviews r 
join products p on p.product_id = r.product_id
group by p.product_id;

-- 17. Find the highest-rated product in the "Dairy" category.
select max(rating) from reviews;
select p.product_id,product_name,max(rating) from reviews r 
join products p on p.product_id = r.product_id
where category = "dairy"
group by p.product_id;


--                           Advanced Level (Subqueries, HAVING, Window Functions, CTEs)

-- 18. List customers who have placed the highest total order amount.

select o.customer_id,customer_name,sum(total_amount) as total_amount from orders o
join customers c on c.customer_id = o.customer_id
group by c.customer_id
order by 3 desc limit 1 ;
--                OR 
SELECT c.customer_id, c.customer_name,total_spent
FROM customers c
JOIN (SELECT o.customer_id, SUM(total_amount) AS total_spent
    FROM orders o
    GROUP BY o.customer_id
    ORDER BY total_spent DESC
    LIMIT 1) top_spender
ON c.customer_id = top_spender.customer_id;

 

-- 19. Find products that were never ordered.
select * from products p 
left join order_details od on od.product_id = p.product_id
where od.product_id != p.product_id ; 

-- 20.Find the most recent order placed by each customer.
select customer_id , max(order_date) as "recent order placed"
from orders 
group by customer_id;

-- 21. Show top 3 products by total revenue using window functions.
select distinct product_id, sum(subtotal) over(partition by product_id) as "total revenue" from order_details
order by 2 desc
limit 3;

select od.product_id , p.product_name,sum(subtotal) as "total revenue" 
from products p 
join order_details od on od.product_id = p.product_id
group by p.product_id 
order by 3 desc
limit 3;
--                OR 
select  p.product_id,p.product_name from  products p 
join (select product_id ,sum(subtotal) as "total revenue" 
      from order_details 
      group by product_id 
      order by 2 desc
       limit 3) temp 
on temp.product_id = p.product_id;



-- 22. Find customers who gave a rating below the average rating.
select reviews.customer_id,customer_name, rating  from reviews
join customers c on c.customer_id = reviews.customer_id
where rating < ( select avg(rating)  from reviews);

-- 23. List products that received more than 1 review with rating = 5.
select product_id,count(*)  as total_reviews from reviews
where rating = 5
group by product_id
having count(*) > 1 ;

-- 24. Using a CTE, find customers who placed more than 1 orders.
with 
c as (select * from customers),
o as ( select customer_id , count(*) as total_orders from orders group by customer_id having count(*) > 1)

select c.customer_id , customer_name , total_orders from c 
join o on c.customer_id = o.customer_id;

-- 25.Rank customers based on total spending.
select *,rank() over(order by total_spending desc) as "customers ranking" from 
(select customer_id,sum(total_amount) as total_spending 
from orders where delivery_status != "cancelled" group by customer_id)m;

-- 26. Show running total of order amounts by date.
select order_date,total_amount,
sum(total_amount) over(order by order_date) as "running total of order amounts"
from orders;


--                                  Pro Level (Case, Date Functions)


-- 27. Use CASE to label orders as “Fast Delivery” if delivery time < 30 mins, else “Slow”.
select *, 
case when delivery_time_mins < '30 mins' then "Fast Delivery"
else "slow"
end as "delivery labels"
from delivery;


-- 28. List orders placed in the current month using date functions.
select * from orders 
where month(order_date)= month(curdate());

-- 29. Create a query that shows total number of orders and total revenue per day.
select order_date,count(order_id) as "total orders per day", sum(total_amount)  as "total revenue per day"
from orders
group by order_date
order by order_date;

-- 30. Count how many days it took to deliver each order.
select  order_date,delivery_date, 
timestampdiff(day,order_date,delivery_date) as "total days the item delivered" from orders
join delivery on delivery.order_id = orders.order_id
where delivery_status not in ('pending','cancelled');
