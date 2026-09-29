-- retail sales analysis --p1
CREATE DATABASE sql_project_p2

-- create table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transactions_id	INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,	
				customer_id	INT,
				gender VARCHAR(15),	
				age	INT,
				category VARCHAR(12),	
				quantiy	INT,
				price_per_unit FLOAT,	
				cogs FLOAT,	
				total_sale FLOAT
            );
			
SELECT * FROM retail_sales
LIMIT 10

SELECT 
     COUNT(*)
FROM retail_sales	 

--Data Claening
SELECT * FROM retail_sales
WHERE 
      transactions_id ISNULL
	  OR
	  sale_date ISNULL
	  OR
	  sale_time ISNULL
	  OR 
	  customer_ID ISNULL
	  OR
	  category ISNULL
	  OR
	  quantiy ISNULL
	  OR
	  price_per_unit ISNULL
	  OR
	  cogs ISNULL
	  OR
	  total_sale ISNULL;

DELETE FROM retail_sales
WHERE 
       transactions_id ISNULL
	  OR
	  sale_date ISNULL
	  OR
	  sale_time ISNULL
	  OR 
	  customer_ID ISNULL
	  OR
	  category ISNULL
	  OR
	  quantiy ISNULL
	  OR
	  price_per_unit ISNULL
	  OR
	  cogs ISNULL
	  OR
	  total_sale ISNULL;

--Data Exploration

--How many sales we have
SELECT COUNT(*) as total_sale FROM retail_sales

--How many customer we have 
SELECT COUNT(DISTINCT customer_ID) as total_sale FROM retail_sales

SELECT COUNT(DISTINCT category) as total_sale FROM retail_sales

SELECT DISTINCT category as total_sale FROM retail_sales

--Data Analysis & businesss key problems & answers
--My analysis and findings

--Q1 Write a SQL query to retrieve all columns for sale made on '2022-11-05'
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05'

--Q2 Write  a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is equal to or gretaer than 4 in the month of nov?
SELECT *
FROM retail_sales
WHERE 
     category = 'Clothing'
	 AND
	 TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	 AND
	 quantiy >= 4

--Q3 Write a SQL query to calculate the total sales(toatl sale ) for each category?
SELECT 
     category,
	 SUM(total_sale) as net_sale,
	 COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1

--Q4 Write a SQL qyery to calculate the average age of customers who purchased items from the 'beauty' industry?
SELECT 
	 ROUND(AVG(age) , 2) as average_age
FROM retail_sales
WHERE category = 'Beauty'

--Q5 WRite a SQL query to find all transactions where the total sale is greter than 1000
SELECT*
FROM retail_sales
WHERE total_sale >= 1000

--Q6 Write a SQL query to find the total number of transcations (transaction_id) made by each gender in each category?
SELECT
     category,
	 gender,
	 COUNT(*) as total_trans
FROM retail_sales	 
GROUP BY
     gender,
     category
ORDER BY 1	 
		 

--Q7 Write a SQL query to calculate the average sale for each month.Find out best selling month in each year?
SELECT
     year,
	 month,
	 avg_sale
FROM	 
(SELECT 
     EXTRACT(YEAR FROM sale_date) as year,
	 EXTRACT(MONTH FROM sale_date) as month,
	 AVG(total_sale) as avg_sale,
	 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC ) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

--Q8 to find the top 5 customers based on the highest total sales

SELECT 
     customer_id,
	 SUM(total_sale) as total_sales 
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--Q9 to find the no of unique customers who puchased items from each category
SELECT 
     category,
	 COUNT(DISTINCT customer_id) as cnt_unique_cs 
FROM retail_sales
GROUP BY category

--Q10 to create each shift and no of orders (ex morning <= 12, afternoon between 12 and 17 and evening>17 )
WITH hourly_sale
AS
(
SELECT*,
     CASE 
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	    WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE'Evening'
	END AS shift
FROM retail_sales
)
SELECT 
     shift,
	 COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift
	
--End of project
	 

 
	 


