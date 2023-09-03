## Supply Chain Data Analysis

You have been provided a dataset of a company that supplies different types of paper to other businesses. The company wants to setup basic reporting using this data at hand.

To get started, you have been provided raw data in the form of csv files. You are required to prototype reporting ideas using this dataset.

The company has chosen to use `postgresql` as sql engine as they plan to migrate to a `redshift` datawarehouse engine in future, `redshift` is based on `postgresql` so, the tech team at the business believes that creating their reporting infrastructure using `postgresql` is a good idea.

The first task that you need to do before any analysis is done, is to create a database and insert the `csv` files into these tables.

**You can view the self paced content on bulk loading data, there are detailed videos on how to do bulk upload using `psql` and `\copy`**

Following relationship should exist between different tables:
![](./imgs/erd.png) 


**Task 1**

You need to create a database named `dwh`. Within that database, you need to create the five tables which are given to you [here](./data/)

Make sure that the foreign and primary key relationships are properly modelled based on the ERD diagram given earlier.

**You can view the self paced content on bulk loading data, there are detailed videos on how to do bulk upload using `psql` and `\copy`**

You will also need to insert the data into the five tables. You can use the bulk loading ability of `psql` using the `\copy` command or you can use a python driver program to load the data into respective tables. Detailed expected schema of the tables is given below:

```shell
REGION
- ID (pk)
- NAME

SALES_REP
- ID (pk)
- NAME
- REGION_ID (fk)(REGION ID)

ACCOUNTS
- ID (pk)
- NAME
- WEBSITE
- LAT
- LONG
- PRIMARY_POC
- SALES_REP_ID (fk)(SALES_REP ID)

WEB_EVENTS
- ID (pk)
- ACCOUNT_ID (fk)(ACCOUNTS ID)
- OCCURED_AT
- CHANNEL

ORDERS
- ID (pk)
- ACCOUNT_ID (fk)(ACCOUNT ID)
- OCCURED_AT
- STANDARD_QTY
- GLOSS_QTY
- POSTER_QTY
- TOTAL
- STANDARD_AMOUNT_USD
- GLOSS_AMT_USD
- POSTER_AMT_USD
- TOTAL_AMT_USD
```

**Task 2**

One of the reporting view that the business wants to setup is to track how the sales reps are performing. There is a need to track the following:

1. Which sales reps are handling which accounts? Your output should look as given below:

![](./imgs/task2.1.png)

2. One of the aspects that  the business wants to explore is what has been the share of each sales representative's s year on year sales out of the total yearly sales. The result of your query should look as given below

![](./imgs/task2.2.png)

3. Repeat the analysis given above but this time for region. Generate the percentage contribution of each region to total yearly revenue over years.

## Task 3
The business wants to understand which accounts contribute to the bulk of the revenue and the business also wants to see year on year trend on the revenue contribution of each account.

The final table should show revenue share of each account for each year's total revenue. As an example your final table should look like the one below

![](./imgs/task3.1.png)


## Deliverables

We expect you to submit a zipped folder with the following structure:

```shell
submission
    - task1
        - bulk_load.ipynb or bulk_load.sql
    - task2
        - task2.sql
    - task3
        - task3.sql
```
You should have a parent folder called  `submission`. For each of the tasks create a separate folder `task1`, `task2` and `task3`.

- You can do `task1` either using a python driver (this has been explained in self paced content) or using `\copy` command. Either submit a jupyter notebook or an sql file that contains table creation and bulk loading commands

- For `task2` and `task3` submit sql files with relevant code. 
