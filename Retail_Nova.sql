CREATE DATABASE RetailSalesDB;
GO

CREATE TABLE Sales (
    order_id VARCHAR(50) PRIMARY KEY,
    order_date DATE,
    customer_id VARCHAR(50),
    product_id VARCHAR(50),
    store_id VARCHAR(50) NULL,
    sales_channel VARCHAR(20),
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_pct DECIMAL(5,2),
    total_amount DECIMAL(12,2)
);

CREATE TABLE Customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(20),
    age INT,
    signup_date DATE,
    region VARCHAR(50)
);

CREATE TABLE Products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(100),
    brand VARCHAR(100),
    cost_price DECIMAL(10,2),
    unit_price DECIMAL(10,2),
    margin_pct DECIMAL(5,2)
);

CREATE TABLE Stores (
    store_id VARCHAR(50) PRIMARY KEY,
    store_name VARCHAR(255),
    store_type VARCHAR(50),
    region VARCHAR(50),
    city VARCHAR(100),
    operating_cost DECIMAL(12,2)
);

CREATE TABLE Returns (
    return_id VARCHAR(50) PRIMARY KEY,
    order_id VARCHAR(50),
    return_date DATE,
    return_reason VARCHAR(100)
);

ALTER TABLE Customers
ADD tenure_days INT;


#1.Total revenue generated in the last 12 months

SELECT 
    SUM(total_amount) AS Total_Revenue
FROM 
    Sales
WHERE 
    order_date >= DATEADD(YEAR, -1, GETDATE());

#2.Top 5 best-selling products by quantity

SELECT TOP 5
    p.product_name,
    SUM(s.quantity) AS Total_Quantity_Sold
FROM 
    Sales s
JOIN 
    Products p ON s.product_id = p.product_id
GROUP BY 
    p.product_name
ORDER BY 
    Total_Quantity_Sold DESC;

#3.Number of customers from each region

SELECT 
    region,
    COUNT(customer_id) AS Customer_Count
FROM 
    Customers
GROUP BY 
    region;

#4.Store with the highest profit in the past year

SELECT TOP 1
    st.store_name,
    SUM((s.unit_price - p.cost_price) * s.quantity - st.operating_cost) AS Profit
FROM 
    Sales s
JOIN 
    Products p ON s.product_id = p.product_id
JOIN 
    Stores st ON s.store_id = st.store_id
WHERE 
    s.order_date >= DATEADD(YEAR, -1, GETDATE())
GROUP BY 
    st.store_name
ORDER BY 
    Profit DESC;

#5.Return rate by product category

SELECT 
    pr.category,
    CAST(COUNT(r.return_id) AS FLOAT) / COUNT(s.order_id) * 100 AS Return_Rate_Percent
FROM 
    Sales s
LEFT JOIN 
    Returns r ON s.order_id = r.order_id
JOIN 
    Products pr ON s.product_id = pr.product_id
GROUP BY 
    pr.category;

#6.Average revenue per customer by age group

SELECT
    CASE 
        WHEN c.age BETWEEN 18 AND 25 THEN '18-25'
        WHEN c.age BETWEEN 26 AND 35 THEN '26-35'
        WHEN c.age BETWEEN 36 AND 45 THEN '36-45'
        WHEN c.age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+' 
    END AS Age_Group,
    AVG(s.total_amount) AS Avg_Revenue_Per_Customer
FROM 
    Sales s
JOIN 
    Customers c ON s.customer_id = c.customer_id
GROUP BY 
    CASE 
        WHEN c.age BETWEEN 18 AND 25 THEN '18-25'
        WHEN c.age BETWEEN 26 AND 35 THEN '26-35'
        WHEN c.age BETWEEN 36 AND 45 THEN '36-45'
        WHEN c.age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+' 
    END;

#7.Which sales channel is more profitable on average

SELECT 
    sales_channel,
    AVG((s.unit_price - p.cost_price) * s.quantity) AS Avg_Profit
FROM 
    Sales s
JOIN 
    Products p ON s.product_id = p.product_id
GROUP BY 
    sales_channel
ORDER BY 
    Avg_Profit DESC;

#8.Monthly profit change over the last 2 years by region

SELECT 
    c.region,
    FORMAT(s.order_date,'yyyy-MM') AS YearMonth,
    SUM((s.unit_price - p.cost_price) * s.quantity) AS Monthly_Profit
FROM 
    Sales s
JOIN 
    Customers c ON s.customer_id = c.customer_id
JOIN 
    Products p ON s.product_id = p.product_id
WHERE 
    s.order_date >= DATEADD(YEAR, -2, GETDATE())
GROUP BY 
    c.region,
    FORMAT(s.order_date,'yyyy-MM')
ORDER BY 
    c.region, YearMonth;

#9.Top 3 products with highest return rate in each category

WITH ReturnRates AS (
    SELECT 
        pr.category,
        p.product_name,
        CAST(COUNT(r.return_id) AS FLOAT) / COUNT(s.order_id) AS Return_Rate
    FROM 
        Sales s
    LEFT JOIN 
        Returns r ON s.order_id = r.order_id
    JOIN 
        Products p ON s.product_id = p.product_id
    JOIN 
        Products pr ON s.product_id = pr.product_id
    GROUP BY 
        pr.category, p.product_name
)
SELECT category, product_name, Return_Rate
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY category ORDER BY Return_Rate DESC) AS rn
    FROM ReturnRates
) t
WHERE rn <= 3
ORDER BY category, Return_Rate DESC;

#10.Top 5 customers contributing the most to total profit

SELECT TOP 5
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM((s.unit_price - p.cost_price) * s.quantity) AS Total_Profit,
    DATEDIFF(DAY, c.signup_date, GETDATE()) AS Tenure_Days
FROM 
    Sales s
JOIN 
    Customers c ON s.customer_id = c.customer_id
JOIN 
    Products p ON s.product_id = p.product_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name, c.signup_date
ORDER BY 
    Total_Profit DESC;
