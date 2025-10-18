USE SQL_PROJECT1 -- (Database)

-- Create Customers Table
DROP TABLE IF EXISTS Customer

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    city VARCHAR(50)
);

-- Insert Data into Customers (Nigerian names & cities)
INSERT INTO Customers (customer_id, name, gender, age, city) VALUES
(1, 'Chinedu Okafor', 'Male', 29, 'Lagos'),
(2, 'Aisha Bello', 'Female', 34, 'Abuja'),
(3, 'Tunde Adeyemi', 'Male', 25, 'Ibadan'),
(4, 'Ngozi Nwankwo', 'Female', 41, 'Enugu'),
(5, 'Emeka Uche', 'Male', 32, 'Port Harcourt');

-- Create Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(50),
    category VARCHAR(30),
    quantity INT,
    price INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert Data into Orders
INSERT INTO Orders (order_id, customer_id, product, category, quantity, price, order_date) VALUES
(101, 1, 'Infinix Phone', 'Electronics', 1, 120000, '2023-11-05'),
(102, 2, 'AirPods', 'Electronics', 2, 60000, '2023-11-06'),
(103, 3, 'Sneakers', 'Fashion', 1, 25000, '2023-11-07'),
(104, 4, 'iPad', 'Electronics', 1, 350000, '2023-11-08'),
(105, 2, 'Ankara Dress', 'Fashion', 3, 15000, '2023-11-09'),
(106, 5, 'Textbook', 'Education', 2, 10000, '2023-11-10'),
(107, 1, 'Backpack', 'Fashion', 1, 18000, '2023-11-11'),
(108, 3, 'HP Laptop', 'Electronics', 1, 450000, '2023-11-12'),
(109, 4, 'Loafers', 'Fashion', 2, 30000, '2023-11-13'),
(110, 5, 'Bluetooth Speaker', 'Electronics', 1, 80000, '2023-11-14');

SELECT * FROM Customers, Orders

--Analysis Questions
/*	
1. How many customers are in the database?
2. What are the unique product categories available?
3. How many total orders have been placed?
4. What is the total revenue generated (price × quantity)?
5. Which product has the highest total sales revenue?
6. What is the average age of customers who bought Electronics?
7. How many male vs. female customers placed orders?
8. Which customer spent the most overall?
9. How many orders were placed per month?
10. Which city generated the most revenue?
*/

--Answers to Questions

--Q1 How many customers are in the database?

SELECT COUNT(*) AS total_customers
FROM Customers

--Q2 What are the unique product categories available?

SELECT DISTINCT Category Unique_product
FROM Orders

--Q3 How many total orders have been placed?

SELECT COUNT (*) AS Total_orders
FROM Orders 

--Q4 what is the total revenue generated (price × quantity)?

SELECT SUM (price * quantity) AS Total_revenue
FROM Orders 

--Q5 Which product has the highest total sales revenue?

SELECT TOP 1 product, SUM(price * quantity) AS Revenue
FROM Orders
Group By product
ORDER BY Revenue DESC

-- Q6 What is the average age of customers who bought Electronics?

SELECT AVG(age) AS Average_age
FROM Customers C
JOIN Orders O
ON C.customer_id = O.customer_id
WHERE category = 'Electronics'
 
-- Q7 How many male vs. female customers placed orders?

SELECT gender,
		COUNT(customer_id) AS Num_customers
FROM Customers
GROUP BY gender

-- Q8 Which customer spent the most overall?

SELECT TOP 1 C.name,
		SUM(O.price) Total_spent
FROM Customers C
JOIN Orders O
ON C.customer_id = O.customer_id
GROUP BY C.name 
ORDER BY Total_spent DESC

-- Q9 How many orders were placed per month?

SELECT 
	DATENAME(month, order_date) AS Month_name,
	COUNT(order_id) AS Num_of_orders
FROM Orders
GROUP BY DATENAME(month, order_date), MONTH(order_date)
ORDER BY MONTH(order_date)

--Q10 Which city generated the most revenue?

SELECT TOP 1 C.city AS City,
		SUM(price * quantity) AS Revenue
FROM Customers C
JOIN Orders O
ON C.customer_id = O.customer_id
GROUP BY City
ORDER BY Revenue DESC


-- End of Project






