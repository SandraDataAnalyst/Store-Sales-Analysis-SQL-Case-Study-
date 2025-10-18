# Store Sales Analysis (SQL Case Study)

## 📌Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `SQL_PROJECT1`

This project focuses on analyzing sales data from a fictional online store using SQL Server. The dataset includes customer information, product categories, order details, pricing, and order dates. The goal was to perform exploratory data analysis (EDA) using SQL queries to uncover key business insights, such as total revenue, customer behavior, and sales performance across cities and product categories. By using SQL aggregation functions, grouping, and filtering techniques, meaningful patterns were identified to support data-driven decision-making in marketing, inventory, and customer engagement strategies.

## 🎯Project Objectives
1. Determine the total number of customers and orders in the database.
2. Identify the unique product categories offered by the store.
3. Discover the top-performing products and customers by revenue.
4. Analyze gender-based purchase patterns.
5. Find the average customer age, especially for electronics buyers.
6. Understand monthly and city-based sales trends.
7. Generate recommendations for increasing sales and improving customer engagement.

## Project Structure

### 🔧Tools Used 
**- SQL Server**

### 🛠 Database Setup

**Database Creation**: The project starts by selectin a database named `SQL_PROJECT1`.
**Table Creation**: A tables are named `Customers` and `Orders` are created to store the sales data. The Customers table structure includes columns for customer ID, name, gender,age, and city. The Orders table structure includes columns for order ID, customer ID, product, category, quantity, price, and order_date.
```sql

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
```

## 🔍 Data Analysis 
The following SQL queries were developed to answer specific business questions

**1. How many customers are in the database?**
```sql
Q1 How many customers are in the database?
SELECT COUNT(*) AS total_customers
FROM Customers
```

**2. What are the unique product categories available?**
```sql
--Q2 What are the unique product categories available?
SELECT DISTINCT Category Unique_product
FROM Orders
```

**3. How many total orders have been placed?**
```sql
SELECT COUNT (*) AS Total_orders
FROM Orders 
```

**4. what is the total revenue generated (price × quantity)?**
```sql
SELECT SUM (price * quantity) AS Total_revenue
FROM Orders
```

**5. Which product has the highest total sales revenue?**
```sql
SELECT TOP 1 product, SUM(price * quantity) AS Revenue
FROM Orders
Group By product
ORDER BY Revenue DESC
```

**6. What is the average age of customers who bought Electronics?**
```sql
SELECT AVG(age) AS Average_age
FROM Customers C
JOIN Orders O
ON C.customer_id = O.customer_id
WHERE category = 'Electronics'
```

**7. How many male vs. female customers placed orders?**
```sql
SELECT gender,
		COUNT(customer_id) AS Num_customers
FROM Customers
GROUP BY gender
```

**8. Which customer spent the most overall?** 
```sql
SELECT TOP 1 C.name,
		SUM(O.price) Total_spent
FROM Customers C
JOIN Orders O
ON C.customer_id = O.customer_id
GROUP BY C.name 
ORDER BY Total_spent DESC
```

**9. How many orders were placed per month?** 
```sql
SELECT 
	DATENAME(month, order_date) AS Month_name,
	COUNT(order_id) AS Num_of_orders
FROM Orders
GROUP BY DATENAME(month, order_date), MONTH(order_date)
ORDER BY MONTH(order_date)
```

**10. Which city generated the most revenue?**

```sql
SELECT TOP 1 C.city AS City,
		SUM(price * quantity) AS Revenue
FROM Customers C
JOIN Orders O
ON C.customer_id = O.customer_id
GROUP BY City
ORDER BY Revenue DESC
```
## 📈 Key Insights

**1. Customer Base**: There are 5 total customers in the database, indicating a small but manageable customer base for personalized marketing efforts.

**2. Product Categories**: The store offers three main categories – Education, Electronics, and Fashion – showing a balanced mix of technology, lifestyle, and learning products.

**3. Total Orders**: A total of 10 orders have been placed, suggesting consistent purchase activity among the small customer base.

**4. Total Revenue**: The store generated ₦1,288,000 in total sales revenue across all orders, reflecting a decent sales performance given the sample size.

**5. Top Product**: The HP Laptop recorded the highest revenue of ₦450,000, making it the best-performing product in the dataset.

**6. Customer Demographics**: The average customer age is 32 years, indicating a relatively young and tech-savvy audience likely to buy electronics and fashion items.

**7. Gender Analysis**: 3 male customers and 2 female customers made purchases, showing slightly higher engagement from men in this dataset.

**8. Top Customer**: Tunde Adeyemi spent the most overall, contributing ₦475,000, highlighting a high-value customer segment.

**9. Monthly Trend**: All 10 orders were placed in November, suggesting a seasonal trend, possibly tied to Black Friday or end-of-year promotions.

**10.Top City by Revenue**: Ibadan generated the highest city-level revenue (₦475,000), showing potential for targeted marketing campaigns in that region.


## 💡 Recommendations

**1. Target High-Spending Customers**: Focus loyalty programs and personalized marketing on high-value customers like Tunde Adeyemi to increase retention and repeat sales.

**2. Promote Top-Selling Products**: Since the HP Laptop drives the most revenue, expand promotions, bundles, or discounts on electronics to capitalize on demand.

**3. Gender-Based Campaigns**: Introduce targeted marketing strategies for female customers to balance the gender participation in purchases.

**4. Seasonal Sales Optimization**: Since all orders occurred in November, leverage seasonal events (e.g., Black Friday, Cyber Monday) with early promotions in October.

**5. Expand in High-Performing Cities**: Strengthen inventory and advertising in Ibadan, while exploring reasons for lower performance in other cities like Lagos and Abuja.

**6. Diversify Product Range**: The current product mix is limited; introducing new subcategories under Education or Fashion could boost total revenue.

**7. Age-Specific Marketing**: Since the average customer is 32, social media and influencer-based marketing could increase brand visibility within this age group.

**8. Increase Order Frequency**: With only 10 total orders, encourage repeat purchases through loyalty points, referral bonuses, or limited-time offers.

**9. Data Expansion**: Consider collecting more detailed data (e.g., customer income, device used for purchase, or feedback) to improve analysis depth.

**10. Automate Reporting**: Set up SQL views or Power BI dashboards to automatically track monthly revenue, customer segments, and sales by category.


## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## 📜 License
This project is licensed under the MIT License – you are free to use, modify, and distribute this project, provided proper credit is given.

## Author - Sandra Nnamdi

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:

- **YouTube**: [Subscribe to my channel for tutorials and insights](https://youtube.com/@techwithsandra?si=PmtHNiN0chXppySJ)
- **Instagram**: [Follow me for daily tips and updates](https://www.instagram.com/designsbysandra_/#))
- **LinkedIn**: [Connect with me professionally](www.linkedin.com/in/nnamdi-s-1540441a4)

Thank you for your support, and I look forward to connecting with you!
