-- Create the database
CREATE DATABASE customer_segmentation;
USE customer_segmentation;

-- Create the customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    income DECIMAL(10, 2),
    region VARCHAR(50)
);

-- Create the transactions table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    transaction_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
-- Insert sample data into customers table
INSERT INTO customers (customer_id, name, age, gender, income, region) VALUES
(1, 'Alice Johnson', 34, 'Female', 75000, 'North'),
(2, 'Bob Smith', 45, 'Male', 55000, 'South'),
(3, 'Charlie Davis', 29, 'Male', 80000, 'East'),
(4, 'Diana Miller', 52, 'Female', 90000, 'West'),
(5, 'Evan Brown', 41, 'Male', 60000, 'North');

-- Insert sample data into transactions table
INSERT INTO transactions (transaction_id, customer_id, transaction_date, amount) VALUES
(1, 1, '2023-01-15', 200.50),
(2, 2, '2023-02-20', 150.75),
(3, 3, '2023-03-10', 300.00),
(4, 4, '2023-04-25', 400.25),
(5, 5, '2023-05-30', 100.00),
(6, 1, '2023-06-05', 250.00),
(7, 2, '2023-07-15', 175.00),
(8, 3, '2023-08-20', 350.00),
(9, 4, '2023-09-10', 450.00),
(10, 5, '2023-10-25', 120.00);
SELECT 
    customers.customer_id, 
    customers.name, 
    COUNT(transactions.transaction_id) AS total_transactions,
    AVG(transactions.amount) AS average_transaction_amount
FROM 
    customers
JOIN 
    transactions ON customers.customer_id = transactions.customer_id
GROUP BY 
    customers.customer_id, customers.name;
SELECT 
    income_segment, 
    COUNT(*) AS customer_count
FROM 
    (SELECT 
         customer_id, 
         name, 
         CASE 
             WHEN income < 50000 THEN 'Low Income'
             WHEN income BETWEEN 50000 AND 75000 THEN 'Middle Income'
             ELSE 'High Income'
         END AS income_segment
     FROM 
         customers) AS income_groups
GROUP BY 
    income_segment;
SELECT 
    region, 
    SUM(amount) AS total_spent
FROM 
    transactions
JOIN 
    customers ON transactions.customer_id = customers.customer_id
GROUP BY 
    region;
SELECT 
    age_group, 
    COUNT(*) AS customer_count
FROM 
    (SELECT 
         customer_id, 
         name, 
         CASE 
             WHEN age < 30 THEN 'Young'
             WHEN age BETWEEN 30 AND 50 THEN 'Middle-aged'
             ELSE 'Senior'
         END AS age_group
     FROM 
         customers) AS age_groups
GROUP BY 
    age_group;
