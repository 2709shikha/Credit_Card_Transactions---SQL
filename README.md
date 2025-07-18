#  💳  **Credit Card Transactions Analysis (India)**

This SQL-based analysis explores credit card transactions across multiple Indian cities and card types. The project uncovers user spending behaviors, highlights trends across various expense categories, and answers key business questions through data-driven insights.

#  📦 **Dataset**
Source: [Kaggle Dataset](https://www.kaggle.com/datasets/thedevastator/analyzing-credit-card-spending-habits-in-india)


#  🛠 **Tools**

SQL Server


#  🧹 **Data Preparation**

-Removed nulls and cleaned column names

-Converted data types appropriately (e.g., amount to FLOAT, date to DATETIME)

-Columns cleaned: lowercase + spaces replaced with underscores

-Imported into SQL Server table: credit_card_transactions


#  📊 **Key Business Questions Solved**
|  |  |
|---|----------|
| 1 | Top 5 cities by total credit card spends and their percentage contribution |
| 2 | Highest spend month and amount for each card type |
| 3 | Transaction details when each card type reaches ₹1,000,000 cumulative spend |
| 4 | City with lowest percentage spend for Gold card type |
| 5 | City-wise highest and lowest expense categories |
| 6 | Female spend percentage across each expense type |
| 7 | Card and expense type with highest MoM growth in Jan 2014 |
| 8 | Weekend spend-to-transaction ratio — top city |
| 9 | City that reached 500 transactions in the shortest time span |


All solutions are available in [credit_card_transactions.sql](credit_card_transactions.sql)


## 📊 Key Insights from Analysis

- **Greater Mumbai** recorded the **highest percentage contribution** to total credit card spends across all cities.
- In **January 2015**, the **Gold card type** had the **highest overall spend** among all card categories.
- **Dhamtari** showed the **lowest percentage spend** for the Gold card type, indicating minimal usage in that region.
- In **Delhi**, the **highest expense category** was **Bills**, while **Entertainment** had the **lowest spend**.
- **Female cardholders** contributed the **highest percentage of spending** in the **Entertainment** category.
- **Bengaluru** achieved its **500th transaction** in the **shortest number of days** after the first transaction, highlighting rapid adoption.
