#SALES ANALYSIS PROJECT

CREATE TABLE sales
	(  transactions_id	INT,
		sale_date DATE,	
		sale_time TIME,
		customer_id	INT,
		gender VARCHAR(15),
		age	INT,
		category VARCHAR(15),
		quantiy	INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
        );
        
#DATA EXPLORATION       

#Looking at the dataset content
SELECT * FROM sales;

#No.of records
SELECT COUNT(*) FROM sales;

#No.of distinct customers
SELECT COUNT(DISTINCT customer_id) FROM sales;

#Looking at the different sales catogories and no.of each
SELECT COUNT(DISTINCT category) FROM sales;
SELECT DISTINCT category FROM sales;

#Checking for sales that occurred on a specific day
SELECT *
FROM sales
WHERE sale_date = '2022-11-05';

#Transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT 
*
FROM sales
	WHERE
	category = 'Clothing'
	AND
    DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND
    quantiy >= 4;


#Calculating the total sales for each category
SELECT
	category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
    FROM sales
    GROUP BY 1;

#Calculating the average age of customers who purchsed items from the beauty category
SELECT
	ROUND(AVG(age), 2) as avg_age
    FROM sales
    WHERE 
    category = 'Beauty';
    
#Finding all transactions where total sales is greater than 1000
SELECT * FROM sales
WHERE total_sale > 1000;

#FInding the maximum total sale
SELECT 
	MAX(total_sale)
    FROM sales;
    
#Finding the total number of transactions (transaction_id) made by each gender in each category
SELECT 
    category, gender, COUNT(*) AS total_trans
FROM
    sales
GROUP BY category , gender
ORDER BY 1;

#Calculating average sale for each month
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as 'rank'
FROM sales
GROUP BY year, month
) as t1;

#Top 5 customers based on the highest total sales
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

#Top 5 sales
SELECT customer_id, total_sale
FROM sales
ORDER BY total_sale DESC
LIMIT 5;

#Number of unique customers who purchased items from each category
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM sales
GROUP BY category;

#Findings
#Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
#High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
#Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.
#Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.

#These findings are very useful to understand and improve the market.

