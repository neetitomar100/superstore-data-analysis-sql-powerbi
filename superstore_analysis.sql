CREATE TABLE superstore_orders (
    row_id INT,
    order_id VARCHAR(20),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code INT,
    region VARCHAR(50),
    product_id VARCHAR(30),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    sales NUMERIC,
    quantity INT,
    discount NUMERIC,
    profit NUMERIC
);

SELECT * FROM superstore_orders;

COPY superstore_orders
FROM 'C:\Program Files\PostgreSQL\18\Superstore order data 1.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE Superstore_returned_orders (
    returned VARCHAR(5),
    order_id VARCHAR(20)
);

COPY superstore_returned_orders
FROM 'C:\Program Files\PostgreSQL\18\Superstore return order.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM superstore_returned_orders;

CREATE TABLE superstore_people (
    person VARCHAR(100),
    region VARCHAR(50)
);

COPY superstore_people
FROM 'C:\Program Files\PostgreSQL\18\Superstore people data.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM superstore_people;

-- Order table
SELECT * FROM superstore_orders;

-- Return table
SELECT * FROM superstore_returned_orders;

--People table
SELECT * FROM superstore_people;

--Total Sales, Profit and Orders
SELECT 
COUNT(DISTINCT order_id) AS Total_Orders,
SUM(sales) AS Total_Sales,
SUM(profit) AS Total_Profit
FROM superstore_orders;

-- Sales by Region
SELECT 
region, SUM(sales) AS Total_Sales
FROM superstore_orders
GROUP BY region
ORDER BY total_sales DESC;

-- Top 10 Selling Product
SELECT 
product_name, SUM(sales) AS Total_Sales
FROM superstore_orders
GROUP BY product_name
ORDER BY Total_Sales DESC
LIMIT 10;

-- Most Profitable Products
SELECT 
product_name, SUM(profit) AS Total_Profit
FROM superstore_orders
GROUP BY product_name
ORDER BY Total_Profit DESC;

-- Category Performance

1) --Top sale Category wise:
SELECT
category, SUM(sales) AS Category_Sales
FROM superstore_orders
GROUP BY category
order by Category_Sales DESC;

2) --Top profit category wise:
SELECT
category, SUM(profit) AS Category_profit
FROM superstore_orders
GROUP BY category
order by Category_profit DESC;

--Sales by customer segment:
SELECT
segment, SUM(sales) AS Total_Sales
FROM superstore_orders
GROUP BY segment
ORDER by Total_Sales DESC;

--Return rate analysis:
SELECT 
COUNT(r.order_id) AS returned_orders,
COUNT(o.order_id) AS total_orders,
ROUND(COUNT(r.order_id)*100.0 / COUNT(o.order_id),2) AS return_percentage
FROM superstore_orders o
LEFT JOIN superstore_returned_orders r
ON o.order_id = r.order_id;

--Sales by regional Manager:
SELECT 
p.person,
SUM(o.sales) AS total_sales
FROM superstore_orders o
JOIN superstore_people p
ON o.region = p.region
GROUP BY p.person
ORDER BY total_sales DESC;

--Top 10 Customers by Sales:
select
customer_name, sum(sales) AS Total_Sales
From superstore_orders
group by customer_name
order by Total_Sales desc
limit 10;

--Profit by Subcategory:
Select
sub_category, sum(profit) as Total_Profit
from superstore_orders
group by sub_category
order by Total_Profit DESC;

--Monthly Sales Trend:
SELECT 
DATE_TRUNC('month', order_date) AS month,
SUM(sales) AS total_sales
FROM superstore_orders
GROUP BY month
ORDER BY month;

--Top 5 Cities:
select
city, sum(sales) AS Total_Sales
FROM superstore_orders
GROUP BY city
ORDER BY Total_Sales DESC
LIMIT 5;

--Category wise profit:
select
category, sum(profit) as Total_profit
from superstore_orders
group by category
order by Total_Profit DESC;

--category wise profit margin
select
category,
sum(profit) as Total_Profit,
sum(sales) as Total_Sales,
ROUNd(SUM(profit)/SUM(sales)*100) AS profit_margin
from superstore_orders
group by category
order by profit_margin desc;

--Most returned products
SELECT 
o.product_name,
COUNT(r.order_id) AS return_count
FROM superstore_orders o
JOIN superstore_returned_orders r
ON o.order_id = r.order_id
GROUP BY o.product_name
ORDER BY return_count DESC
LIMIT 10;

-- Most return category
select
o.category,
count(r.order_id) as Return_category
from superstore_orders o
join superstore_returned_orders r
on o.order_id = r.order_id
group by o.category
order by return_category desc;

--discount impact on profit
select
discount,
sum(profit) as total_profit
from superstore_orders
group by discount
order by discount;

-- Average  delivery time
Select
AVG(ship_date - order_date) as average_delivery_days
from superstore_orders;

--region with highest return rate
select
o.region,
count(r.order_id) as Return_category
from superstore_orders o
join superstore_returned_orders r
on o.order_id = r.order_id
group by o.region
order by return_category desc;

--yearly sales growth
SELECT 
EXTRACT(YEAR FROM order_date) AS year,
SUM(sales) AS total_sales
FROM superstore_orders
GROUP BY year
ORDER BY year;

--Most Profitable state
Select
state, sum(profit) as total_profit
from superstore_orders
group by state
order by total_profit desc;

--Loss making products
select 
product_name,
sum(profit) as total_profit
from superstore_orders
group by product_name
HAVING SUM(profit) < 0
order by total_profit;

--average order value
SELECT 
ROUND(SUM(sales)/COUNT(DISTINCT order_id)) AS avg_order_value
FROM superstore_orders;

--sub category performance
SELECT 
sub_category,
SUM(sales) AS total_sales,
SUM(profit) AS total_profit
FROM superstore_orders
GROUP BY sub_category
ORDER BY total_sales DESC;

--Top customers by profit
select 
customer_name,
sum(profit) as total_profit
from superstore_orders
group by customer_name
order by total_profit desc
LIMIT 10;

--shipping mode performance
select
ship_mode,
SUM(sales) as Total_Sales
from superstore_orders
group by ship_mode
order by Total_Sales desc;

--product with highest discount
select
product_name,
Max(discount) as highest_discount
from superstore_orders
group by product_name
order by highest_discount desc;

--Region with highest profit
select
region,
sum(profit) as Total_profit
from superstore_orders
group by region
order by Total_profit desc;

SELECT 
customer_name,
COUNT(DISTINCT order_id) AS total_orders
FROM superstore_orders
GROUP BY customer_name
HAVING COUNT(DISTINCT order_id) > 5
ORDER BY total_orders DESC;



















































