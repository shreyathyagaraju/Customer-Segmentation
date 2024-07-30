# Customer Segmentation Project

This project involves creating a database for customer segmentation analysis, inserting sample data, and performing various queries to analyze the data. Additionally, it includes visualizations using Tableau.

## Table of Contents
- [Overview](#overview)
- [Setup Instructions](#setup-instructions)
- [SQL Scripts](#sql-scripts)
- [Tableau Visualizations](#tableau-visualizations)
- [Contributing](#contributing)
- [License](#license)

## Overview

The Customer Segmentation Project aims to analyze customer data to identify different segments based on various criteria such as income, age, and transaction behavior. The project includes creating a database, inserting sample data, performing analytical queries, and visualizing the results.

## Setup Instructions

To set up and run the analysis, follow these steps:

1. **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/customer-segmentation.git
    cd customer-segmentation
    ```

2. **Set up the database:**

    ```sql
    -- Create and use the database
    CREATE DATABASE customer_segmentation;
    USE customer_segmentation;

    -- Create tables
    CREATE TABLE customers (
        customer_id INT PRIMARY KEY,
        name VARCHAR(50),
        age INT,
        gender VARCHAR(10),
        income DECIMAL(10, 2),
        region VARCHAR(50)
    );

    CREATE TABLE transactions (
        transaction_id INT PRIMARY KEY,
        customer_id INT,
        transaction_date DATE,
        amount DECIMAL(10, 2),
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    );

    -- Insert sample data into tables
    INSERT INTO customers (customer_id, name, age, gender, income, region) VALUES
    (1, 'Alice Johnson', 34, 'Female', 75000, 'North'),
    (2, 'Bob Smith', 45, 'Male', 55000, 'South'),
    (3, 'Charlie Davis', 29, 'Male', 80000, 'East'),
    (4, 'Diana Miller', 52, 'Female', 90000, 'West'),
    (5, 'Evan Brown', 41, 'Male', 60000, 'North');

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
    ```

3. **Run analysis queries:**

    ```sql
    -- Total Transactions and Average Transaction Amount by Customer
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

    -- Income Segmentation
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

    -- Transactions by Region
    SELECT 
        region, 
        SUM(amount) AS total_spent
    FROM 
        transactions
    JOIN 
        customers ON transactions.customer_id = customers.customer_id
    GROUP BY 
        region;

    -- Age Group Segmentation
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
    ```

## Tableau Visualizations

1. **Connect to MySQL Database:**
   - Open Tableau and connect to your MySQL database `customer_segmentation`.

2. **Import Tables:**
   - Import the `customers` and `transactions` tables into Tableau.

3. **Create Visualizations:**
   - **Total Transactions and Average Transaction Amount by Customer:** Create a bar chart with `customer_id` on the x-axis and `total_transactions` on the y-axis.
   - **Income Segmentation:** Create a pie chart showing the `income_segment` and `customer_count`.
   - **Transactions by Region:** Create a map visualization with `region` and `total_spent`.
   - **Age Group Segmentation:** Create a bar chart with `age_group` and `customer_count`.

## Contributing

If you have any suggestions or improvements, feel free to open an issue or submit a pull request. Contributions are welcome!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
