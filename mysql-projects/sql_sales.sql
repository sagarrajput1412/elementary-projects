SELECT * FROM pizza.sales;
USE pizza;

SELECT * FROM sales;

-- A. KEEP PERFORMANCE INDICATOR (KPI)

-- 1) Total Revenue of all pizza orders
SELECT COUNT(DISTINCT(order_id)) AS 'total_orders', ROUND(SUM(total_price)) AS 'total_revenue' 
FROM sales;


-- 2) Average Order values
SELECT ROUND(SUM(total_price)/COUNT(DISTINCT(order_id)), 2) AS 'avg_order_value' 
FROM sales;


-- 3) Total Pizzas Sold
SELECT SUM(quantity) AS 'total_pizza_sold' FROM sales;


-- 4) Total Orders
SELECT COUNT(DISTINCT(order_id)) AS total_orders FROM sales;

-- 5) Average Pizzas Per Order
SELECT ROUND(SUM(quantity)/COUNT(DISTINCT(order_id)), 2) AS 'avg_pizzas_per_order'
FROM sales;


DESCRIBE sales;

SELECT COUNT(*) 
FROM sales
WHERE order_date IS NULL;

-- B. DAILY TREND FOR TOTAL ORDERS

UPDATE sales
SET order_date = date(str_to_date(order_date, '%d-%m-%Y'));

ALTER TABLE sales 
MODIFY COLUMN order_date date;

ALTER TABLE sales 
MODIFY COLUMN order_time time;

SELECT DAYNAME(order_date) 
FROM sales;

SELECT DAYNAME(order_date) AS 'order_day', COUNT(DISTINCT(order_id)) AS 'total_orders'
FROM sales
GROUP BY DAYNAME(order_date);


-- C. MONTHLY TREND FOR ORDERS

SELECT MONTHNAME(order_date) AS month, COUNT(DISTINCT(order_id))
FROM sales
GROUP BY MONTHNAME(order_date);


-- D. % OF SALES BY PIZZA CATEGORY

SELECT SUM(total_price) FROM sales;

SELECT pizza_category, ROUND(SUM(total_price), 1) AS 'total_sales', 
ROUND((SUM(total_price)*100)/(SELECT SUM(total_price) FROM sales), 2) AS 'sales_percent'
FROM sales
GROUP BY pizza_category;

SELECT COUNT(*) 
FROM sales
WHERE MONTH(order_date) = 1;

SELECT pizza_category, ROUND(SUM(total_price), 1) AS 'total_sales', 
ROUND((SUM(total_price)*100)/(SELECT SUM(total_price) FROM sales WHERE MONTH(order_date) = 1), 2) AS 'sales_percent'
FROM sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;


-- E. % OF SALES BY PIZZA SIZE

SELECT * FROM sales;

SELECT pizza_size, ROUND(SUM(total_price), 1) AS 'total_sales', 
ROUND((SUM(total_price)*100)/(SELECT SUM(total_price) FROM sales), 2) AS 'sales_percent'
FROM sales
GROUP BY pizza_size
ORDER BY sales_percent DESC;


-- F. TOTAL PIZZAS SOLD BY PIZZA CATEGORY

SELECT pizza_category, SUM(quantity) AS 'pizzas_sold' 
FROM sales
GROUP BY pizza_category;


-- G. TOP 5 PIZZAS BY REVENUE

SELECT DISTINCT(pizza_name)
FROM sales;

SELECT pizza_name, ROUND(SUM(total_price), 2) AS 'total_revenue'
FROM sales 
GROUP BY pizza_name
ORDER BY SUM(total_price) DESC
LIMIT 5;


-- H. BOTTOM 5 PIZZAS BY REVENUE

SELECT pizza_name, ROUND(SUM(total_price), 2) AS 'total_revenue'
FROM sales 
GROUP BY pizza_name
ORDER BY SUM(total_price) ASC
LIMIT 5;


-- I. TOP 5 PIZZAS BY QUANTITY

SELECT pizza_name, SUM(quantity) AS 'total_pizzas_sold'
FROM sales 
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC
LIMIT 5;


-- J. BOTTOM 5 PIZZAS BY QUANTITY

SELECT pizza_name, SUM(quantity) AS 'total_pizzas_sold'
FROM sales 
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC
LIMIT 5;


-- K. TOP 5 PIZZAS BY TOTAL ORDERS

SELECT pizza_name, COUNT(DISTINCT(order_id)) AS 'total_pizza_orders'
FROM sales 
GROUP BY pizza_name
ORDER BY SUM(order_id) DESC
LIMIT 5;

-- L. BOTTOM 5 PIZZAS BY TOTAL ORDERS

SELECT pizza_name, COUNT(DISTINCT(order_id)) AS 'total_pizza_orders'
FROM sales 
GROUP BY pizza_name
ORDER BY SUM(order_id) ASC
LIMIT 5;

