use dwh;

## The business wants to understand which accounts contribute to the bulk of the revenue and the 
## business also wants to see year on year trend on the revenue contribution of each account.

WITH YearlyRevenue AS (
    SELECT
        EXTRACT(YEAR FROM ORDERS.occurred_at) AS `Year`,
        ACCOUNTS.NAME AS `Account Name`,
        SUM(ORDERS.TOTAL_AMT_USD) AS `Yearly Revenue`
    FROM
        ORDERS
    JOIN
        ACCOUNTS ON ORDERS.ACCOUNT_ID = ACCOUNTS.ID
    GROUP BY
        `Year`, `Account Name`
),
TotalYearlyRevenue AS (
    SELECT
        EXTRACT(YEAR FROM ORDERS.occurred_at) AS `Year`,
        SUM(ORDERS.TOTAL_AMT_USD) AS `Total Yearly Revenue`
    FROM
        ORDERS
    GROUP BY
        `Year`
)
SELECT
    YR.`Year`,
    YR.`Account Name`,
    YR.`Yearly Revenue`,
    TYR.`Total Yearly Revenue`,
    (YR.`Yearly Revenue` / TYR.`Total Yearly Revenue`) * 100 AS `Revenue Contribution (%)`
FROM
    YearlyRevenue YR
JOIN
    TotalYearlyRevenue TYR ON YR.`Year` = TYR.`Year`
ORDER BY
    YR.`Year`, `Revenue Contribution (%)` DESC;

## The final table should show revenue share of each account for each year's total revenue. As an example 
## your final table should look like the one below

WITH YearlyRevenue AS (
    SELECT
        EXTRACT(YEAR FROM orders.occurred_at) AS `Year`,
        ACCOUNTS.NAME AS `Account Name`,
        SUM(ORDERS.TOTAL_AMT_USD) AS `Yearly Revenue`
    FROM
        ORDERS
    JOIN
        ACCOUNTS ON ORDERS.ACCOUNT_ID = ACCOUNTS.ID
    GROUP BY
        `Year`, `Account Name`
),
TotalYearlyRevenue AS (
    SELECT
        EXTRACT(YEAR FROM orders.occurred_at) AS `Year`,
        SUM(ORDERS.TOTAL_AMT_USD) AS `Total Yearly Revenue`
    FROM
        ORDERS
    GROUP BY
        `Year`
)
SELECT
    YR.`Year`,
    YR.`Account Name`,
    YR.`Yearly Revenue`,
    TYR.`Total Yearly Revenue`,
    (YR.`Yearly Revenue` / TYR.`Total Yearly Revenue`) * 100 AS `Revenue Share (%)`
FROM
    YearlyRevenue YR
JOIN
    TotalYearlyRevenue TYR ON YR.`Year` = TYR.`Year`
ORDER BY
    YR.`Year`, `Account Name`;