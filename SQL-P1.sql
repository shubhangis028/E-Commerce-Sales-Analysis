CREATE DATABASE sales_P1;
USE sales_P1;


CREATE TABLE sales(transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT)

SELECT * FROM Sales
limit 10;

SELECT 
    count(*) 
FROM Sales;

ALTER TABLE sales
RENAME COLUMN ï»¿transactions_id TO  transaction_id;

SELECT * FROM Sales
WHERE transaction_id is not null;

SELECT * FROM sales
WHERE
	Transaction_id is null
    or 
    sale_date is null
    or
    sale_time is null
    or
    gender is null
    or
    age is null
    or
    category is null
    or
    quantiy is null
    or
    price_per_unit is null
    or
    cogs is null
    or
    total_sale is null;
    
DELETE FROM sales
WHERE
	Transaction_id is null
    or 
    sale_date is null
    or
    sale_time is null
    or
    gender is null
    or
    age is null
    or
    category is null
    or
    quantiy is null
    or
    price_per_unit is null
    or
    cogs is null
    or
    total_sale is null;
    
-- DATA EXPLORATION
-- Lets see how many records we have?
SELECT COUNT(*) AS tatal_sales from sales;

-- How many unique customer we have?
 SELECT COUNT(Distinct Customer_id) AS Total_Customer from sales;
 
 -- Data analysis & Business key problem & answers
 -- Q.1 Write a sql query tp retrieve all column for sales made on '2022-11-05'
 
 SELECT * FROM sales
 WHERE Sale_date='2022-11-05';
 
-- Q.2 Write as sql query to retrieve all transaction where the category is "Clothing" and the quantity sold is more than 4 in the  
--  month of nov-2022?

SELECT category, sum(quantiy) FROM sales
WHERE 
    Category="Clothing" 
    and
    DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    and
    quantiy >=4;
    
-- Q.3 Write sql query to calculalte the total sales (total_sale) for each category
SELECT category, sum(total_sale) as Total_sale FROM sales
GROUP BY Category;

-- Q.4 Write SQL query to find the avarage age of customers who purchased items from the 'Beauty' category
 SELECT 
     Round(avg(age),2) as Avg_age FROM sales
where category='Beauty';  

-- Q.5  Write SQL query to find all transactions where the total_sales is greater than 1000.
SELECT *
FROM Sales
WHERE total_sale >=1000;

-- Q.6 Write a SQL query to find the total number of transaction made by each gender in each category
SELECT 
      category,
      gender,
	  count(transaction_id) as Total_transactions 
FROM sales
GROUP BY 
      category,
      Gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT * FROM
(SELECT 
     extract(YEAR FROM Sale_date) as Year,
     extract(Month FROM Sale_date) as Month,
     Avg(total_sale) as Avg_sale,
     Rank() OVER (partition by extract(YEAR FROM Sale_date) ORDER BY Avg(total_sale) DESC) as Rank1
FROM sales
Group by 1,2) as table1
Where Rank1 = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total-sale?
SELECT customer_id, Sum(total_sale) as total_sale FROM Sales
group BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the Number of unique customer who purchased item from each category
SELECT 
      Category,
      COUNT(DISTINCT Customer_id) AS Unique_customer 
FROM sales
Group by 1;

-- Q.9 Write a SQL query to Creat each shift and number of orders (example morning<=12, Afternoon Between 12 & 17, Evening >17)

with Hourly_sale
As
(SELECT *,
    case
        WHEN EXTRACT(Hour FROM Sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(Hour FROM Sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	    ELSE 'Evening'
	END AS shift
FROM Sales)
SELECT 
     shift,
     COUNT(*) as total_orders
FROM Hourly_sale
Group by shift;


















     








    
    
    





