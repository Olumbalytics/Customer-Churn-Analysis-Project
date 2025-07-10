SELECT * FROM churnrateanalysis.customer_churn_data;

-- Data Modeling
ALTER TABLE customer_churn_data
MODIFY StartDate DATE;
ALTER TABLE customer_churn_data
MODIFY EndDate DATE;

-- View Churned Customers
SELECT *
FROM churnrateanalysis.customer_churn_data
WHERE Status = 'Churned';
    
-- Monthly Churn Rate SQL
SELECT 
	DATE_FORMAT('month', EndDate) AS Churn_Month,
	COUNT(*) AS Customers_Churned,
(
SELECT COUNT(*)
    FROM churnrateanalysis.customer_churn_data
    WHERE StartDate <=
    DATE_FORMAT('month', EndDate)) AS Customers_At_Start,
    ROUND(COUNT(*) * 100.0)/NULLIF(
(
SELECT COUNT(*)
    FROM churnrateanalysis.customer_churn_data
    WHERE StartDate <=
    DATE_FORMAT('month', EndDate)
    ), 0) AS Churn_Rate_Percent
    FROM churnrateanalysis.customer_churn_data
    WHERE Status = 'Churned'
    GROUP BY DATE_FORMAT('month', EndDate)
    ORDER BY Churn_Month;
    
-- Monthly Churn Summary
SELECT
	MONTH(EndDate) AS ChurnMonth,
    COUNT(*) AS ChurnedCustomers
    FROM churnrateanalysis.customer_churn_data
    WHERE Status = 'Churned'
    GROUP BY MONTH(EndDate);