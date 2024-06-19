-- Retrieve the total number of orders placed.
SELECT 
    COUNT(DISTINCT order_id) AS Total_Number_Orders
FROM pizzahut.orders;  -- 21350
 
-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND((SUM(P.price * O.quantity)), 2) AS Total_Revenue
FROM pizzahut.pizzas P
JOIN pizzahut.order_details O ON P.pizza_id = O.pizza_id;  -- 817860.05

-- Retrive how many pizza have been sold 
SELECT 
    SUM(OD.quantity) AS QuantitySold
FROM pizzahut.order_details OD;  -- 49574

-- Retrive average number of pizzas ordered in a single tranaction
SELECT 
    ROUND(SUM(OD.quantity) / COUNT(DISTINCT OD.order_id), 2) AS Avg_Quantity
FROM pizzahut.order_details OD
JOIN pizzahut.pizzas P ON OD.pizza_id = P.pizza_id; -- 2.32

-- Retrive the Average order amount 
SELECT 
    ROUND(SUM(OD.quantity * P.price) / COUNT(DISTINCT OD.order_id)) AS Avg_Amount
FROM pizzahut.order_details OD
JOIN pizzahut.pizzas P ON OD.pizza_id = P.pizza_id;  -- 38

-- How many unique types of pizza are there on the menu?
SELECT 
    COUNT(DISTINCT pizza_type_id) AS Total_Pizza_Types
FROM pizzahut.pizza_types;   -- 32

-- Diffenent size of pizza
SELECT DISTINCT P.size AS Pizza_Size
FROM pizzahut.pizzas P;

-- Diffenent catagory of pizza
SELECT DISTINCT
    PT.category AS PizzaCategory
FROM pizzahut.pizza_types PT
JOIN pizzahut.pizzas P USING (pizza_type_id);

-- Which catagory has the most number of pizza varieties (category-wise distribution)
SELECT 
    category As Pizza_Category, COUNT(name) VarityCount
FROM pizzahut.pizza_types
GROUP BY category
ORDER BY VarityCount DESC;

-- Identify the highest-priced pizza.
SELECT 
    PT.name AS Pizza_Name, P.price AS Price
FROM pizzahut.pizzas P
JOIN pizzahut.pizza_types PT USING (pizza_type_id)
ORDER BY P.price DESC
LIMIT 1;

-- Identify the lowest-priced pizza.
SELECT 
    PT.name AS Pizza_Name, P.price AS Price
FROM pizzahut.pizzas P
JOIN pizzahut.pizza_types PT USING (pizza_type_id)
ORDER BY P.price
LIMIT 1;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
WITH CTE1 AS
(SELECT 
    O.order_date AS OrderDate,
    SUM(OD.quantity) AS QuantityOrdered
FROM
    pizzahut.orders O
        JOIN
    pizzahut.order_details OD USING (ORDER_ID)
GROUP BY OrderDate)
SELECT 
    ROUND(AVG(QuantityOrdered)) AS Avg_Quantity_perDay
FROM
    CTE1;  -- 138

-- Group the orders by date and calculate the average Amount of pizzas ordered per day.
WITH CTE1 AS
(SELECT 
    O.order_date AS OrderDate,
    ROUND(SUM(OD.quantity * P.price), 2) AS Amount
FROM
    pizzahut.orders O
        JOIN
    pizzahut.order_details OD USING (ORDER_ID)
        JOIN
    pizzahut.pizzas P ON OD.pizza_id = P.pizza_id
GROUP BY OrderDate)
SELECT 
    ROUND(AVG(Amount)) AS Avg_Amount_perDay
FROM
    CTE1;  -- 2285
    
-- ********************************************************************************************************* --
-- Based on Pizza Size Analysis (Number of Order, Number of Quantity, Revenue)
SELECT 
    P.SIZE AS PIZZA_SIZE,
    COUNT(O.ORDER_ID) AS NUMBER_OF_ORDER,
    SUM(O.QUANTITY) AS ORDERED_QUANTITY,
    ROUND(SUM(O.QUANTITY * P.PRICE)) AS REVENUE
FROM
    PIZZAHUT.ORDER_DETAILS O
        JOIN
    PIZZAHUT.PIZZAS P USING (PIZZA_ID)
GROUP BY P.SIZE
ORDER BY REVENUE DESC;

-- ********************************************************************************************************* --
-- BASED ON PIZZA TYPE (NUMBER OF ORDER, NUMBER OF QUANTITY, REVENUE)
SELECT 
    PT.NAME AS PIZZA_TYPE,
    COUNT(O.ORDER_ID) AS NUMBER_OF_ORDER,
    SUM(O.QUANTITY) AS QUANTITY_ORDERED,
    ROUND(SUM(O.QUANTITY * P.PRICE)) AS REVENUE
FROM
    PIZZAHUT.PIZZA_TYPES PT
        JOIN
    PIZZAHUT.PIZZAS P ON PT.PIZZA_TYPE_ID = P.PIZZA_TYPE_ID
        JOIN
    PIZZAHUT.ORDER_DETAILS O ON P.PIZZA_ID = O.PIZZA_ID
GROUP BY PT.NAME
ORDER BY REVENUE DESC;

-- ********************************************************************************************************* --

-- BASED ON PIZZA CATEGORY (NUMBER OF ORDER, NUMBER OF QUANTITY, REVENUE)
SELECT 
    PT.CATEGORY AS PIZZA_CATEGORY,
    COUNT(DISTINCT O.ORDER_ID) AS NUMBER_OF_ORDER,
    SUM(O.QUANTITY) AS QUANTITY_ORDERED,
    ROUND(SUM(O.QUANTITY * P.PRICE)) AS REVENUE
FROM
    PIZZAHUT.PIZZA_TYPES PT
        JOIN
    PIZZAHUT.PIZZAS P ON PT.PIZZA_TYPE_ID = P.PIZZA_TYPE_ID
        JOIN
    PIZZAHUT.ORDER_DETAILS O ON P.PIZZA_ID = O.PIZZA_ID
GROUP BY PT.CATEGORY
ORDER BY REVENUE DESC;

-- ********************************************************************************************************* --

-- Determine the distribution of orders by hour of the day.
SELECT HOUR(O.order_time) AS Hour, COUNT(O.order_id) OrderCount
FROM pizzahut.orders O 
GROUP BY Hour
ORDER BY Hour;

-- Determine the distribution of orders by day.
SELECT DAYNAME(O.order_date) AS OrderDay, COUNT(O.order_id) TotalOrder
FROM pizzahut.orders O 
GROUP BY OrderDay
ORDER BY TotalOrder;

-- Determine the distribution of orders by month.
SELECT MONTHNAME(O.order_date) AS MonthName, COUNT(O.order_id) TotalOrder
FROM pizzahut.orders O 
GROUP BY MonthName,MONTH(O.order_date)
ORDER BY MONTH(O.order_date);

-- ********************************************************************************************************* --

-- Analyze the cumulative revenue generated over time.
SELECT 
	O.order_date AS Order_Date, 
	ROUND(SUM(P.price * OD.quantity)) AS Per_Day_Revenue,
	SUM(ROUND(SUM(P.price * OD.quantity))) OVER(ORDER BY O.order_date) AS Running_Total
FROM pizzahut.order_details OD 
JOIN pizzahut.orders O ON OD.order_id= O.order_id
JOIN pizzahut.pizzas P ON P.pizza_id=OD.pizza_id
GROUP BY O.order_date;

-- ********************************************************************************************************* --

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT * FROM
(SELECT 
	PT.category AS Pizza_Category,
	PT.name AS Pizza_Type, 
	ROUND(SUM(P.price * OD.quantity)) AS Revenue,
	DENSE_RANK() OVER(partition by PT.category ORDER BY SUM(P.price * OD.quantity) DESC) Ranking
FROM pizzahut.pizza_types PT 
JOIN pizzahut.pizzas P ON PT.pizza_type_id=P.pizza_type_id
JOIN pizzahut.order_details OD ON P.pizza_id=OD.pizza_id
GROUP BY PT.category,PT.name) AS TEMP
WHERE TEMP.Ranking BETWEEN 1 AND 3;

-- ********************************************************************************************************* --

-- Calculate the percentage contribution of each pizza size to total revenue.
WITH CTE1 AS 
(SELECT 
	P.size, 
	round(SUM(P.price * OD.quantity),1) AS Category_wise_Revenue,
	SUM(round(SUM(P.price * OD.quantity),1)) OVER() AS Total_Revenue
FROM pizzahut.pizzas P 
JOIN pizzahut.order_details OD ON P.pizza_id=OD.pizza_id
GROUP BY P.size) 
SELECT 
	CTE1.size AS Pizza_Size,
	CTE1.Category_wise_Revenue, 
	CTE1.Total_Revenue, 
	ROUND(Category_wise_Revenue/Total_Revenue * 100,1) AS Percent_Contribution
FROM CTE1
ORDER BY Percent_Contribution DESC;

-- ********************************************************************************************************* --

-- Calculate the percentage contribution of each pizza type to total revenue.
WITH CTE1 AS 
(SELECT 
	PT.category, 
	round(SUM(P.price * OD.quantity),1) AS Category_wise_Revenue,
	SUM(round(SUM(P.price * OD.quantity),1)) OVER() AS Total_Revenue
FROM pizzahut.pizza_types PT 
JOIN pizzahut.pizzas P ON PT.pizza_type_id=P.pizza_type_id
JOIN pizzahut.order_details OD ON P.pizza_id=OD.pizza_id
GROUP BY PT.category) 
SELECT 
	CTE1.category AS Pizza_Category,
	CTE1.Category_wise_Revenue, 
	CTE1.Total_Revenue, 
	ROUND(Category_wise_Revenue/Total_Revenue * 100,1) AS Percent_Contribution
FROM CTE1
ORDER BY Percent_Contribution DESC;
