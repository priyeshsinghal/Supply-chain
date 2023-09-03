use dwh;

## Report 1: Which Sales Reps Are Handling Which Accounts?
SELECT
    SR.NAME AS SALES_REP_NAME,
    A.NAME AS ACCOUNT_NAME
FROM
    SALES_REP SR
JOIN
    ACCOUNTS A ON SR.ID = A.SALES_REP_ID
ORDER BY
    SR.NAME, A.NAME;

##  One of the aspects that  the business wants to explore is what has been the 
## share of each sales representative's s year on year sales out of the total yearly sales. 
## The result of your query should look as given below

WITH YearlySales AS (
    SELECT
        YEAR(occurred_at) AS Year,
        SALES_REP.NAME AS `Sales Rep Name`,
        SUM(TOTAL_AMT_USD) AS `Yearly Sales`
    FROM
        ORDERS
    JOIN
        SALES_REP ON ORDERS.ACCOUNT_ID = SALES_REP.ID
    GROUP BY
        Year, `Sales Rep Name`
),
TotalYearlySales AS (
    SELECT
        YEAR(occurred_at) AS Year,
        SUM(TOTAL_AMT_USD) AS `Total Yearly Sales`
    FROM
        ORDERS
    GROUP BY
        Year
)
SELECT
    YearlySales.Year AS Year,
    YearlySales.`Sales Rep Name`,
    (YearlySales.`Yearly Sales` / TotalYearlySales.`Total Yearly Sales`) * 100 AS `Sales Share (%)`
FROM
    YearlySales
JOIN
    TotalYearlySales ON YearlySales.Year = TotalYearlySales.Year
ORDER BY
    Year, `Sales Rep Name`;


## Repeat the analysis given above but this time for region. Generate the percentage contribution 
## of each region to total yearly revenue over years.

WITH YearlySales AS (
    SELECT
        YEAR(occurred_at) AS Year,
        REGION.NAME AS `Region Name`,
        SUM(TOTAL_AMT_USD) AS `Yearly Sales`
    FROM
        ORDERS
    JOIN
        SALES_REP ON ORDERS.ACCOUNT_ID = SALES_REP.ID
    JOIN
        REGION ON SALES_REP.REGION_ID = REGION.ID
    GROUP BY
        Year, `Region Name`
),
TotalYearlySales AS (
    SELECT
        YEAR(occurred_at) AS Year,
        SUM(TOTAL_AMT_USD) AS `Total Yearly Sales`
    FROM
        ORDERS
    GROUP BY
        Year
)
SELECT
    YearlySales.Year AS Year,
    YearlySales.`Region Name`,
    (YearlySales.`Yearly Sales` / TotalYearlySales.`Total Yearly Sales`) * 100 AS `Region Sales Share (%)`
FROM
    YearlySales
JOIN
    TotalYearlySales ON YearlySales.Year = TotalYearlySales.Year
ORDER BY
    Year, `Region Name`;

