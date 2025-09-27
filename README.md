# RetailNova End-to-End Sales & Behavioral Analytics

## Project Overview
**Company:** RetailNova Inc. | **Industry:** Retail & E-Commerce  
**Project Type:** End-to-End Retail Performance & Behavioral Analytics  
**Tools:** Python (Pandas, Matplotlib, Seaborn), SQL, Power BI  

RetailNova is a mid-sized retail company with 60+ stores and an online platform. The project demonstrates **full lifecycle analytics**: from raw data ingestion, cleaning, and feature engineering, to SQL analysis, dashboard creation, and business insights for decision-making.

**Objective:**  
Enable RetailNova to make **data-driven decisions** by identifying trends, customer behavior patterns, product and store performance, and return behavior, ultimately improving profitability and operational efficiency.

---

## Business Goals
- Analyze **sales trends and anomalies**  
- Understand **customer segmentation and lifetime value**  
- Optimize **product and store performance**  
- Reduce **returns and operational inefficiencies**  
- Deliver **interactive dashboards** and actionable recommendations to leadership  

---

## Key Datasets
| Dataset | Description |
|---------|-------------|
| `customers_cleaned.csv` | Customer demographics and signup data |
| `orders_cleaned.csv` | Transaction-level sales data |
| `products_cleaned.csv` | Product catalog with pricing and categories |
| `stores_cleaned.csv` | Store details, regions, operating costs |
| `returns_cleaned.csv` | Product return transactions and reasons |
| `RetailNova_Merged.csv` | Combined dataset linking all tables for analysis |

> All datasets are cleaned, standardized, and enhanced with derived features such as profit, discount %, and customer age group.

---

## End-to-End Workflow

### 1. Data Cleaning & Feature Engineering
- Removed duplicates, handled missing values, fixed outliers  
- Standardized data types and date columns  
- Engineered new features: profit per transaction, age group, regional metrics  

### 2. SQL Analysis
- Designed relational database schema and indexes  
- Calculated metrics: total revenue, profit, return rates, customer value  
- Answered key business questions using optimized SQL queries  
- Exported summarized results for dashboard integration  

### 3. Dashboard & Visualization
- Built **Power BI dashboards** covering:  
  - Sales Overview & Monthly Trends  
  - Customer Insights & Segmentation  
  - Product & Store Performance  
  - Return Analysis & KPIs  
- Added **filters, slicers, tooltips**, and interactive charts for decision support  

### 4. Reporting & Insights
- Compiled **executive-level report** with actionable recommendations  
- Highlighted **top-selling products, high-value customers, store profitability**, and **return hotspots**  

---

## Key Insights
- Identified **top 5 products and categories** driving revenue  
- Highlighted **underperforming regions and stores** for strategic attention  
- Analyzed **customer demographics**, revenue contribution, and retention risk  
- Quantified **returns and top returned products** by category  
- Developed **data-driven recommendations** for pricing, inventory, and customer engagement  

---

## Tools & Technologies
- **Python:** Pandas, Matplotlib, Seaborn for data manipulation & visualization  
- **SQL:** PostgreSQL / SQLite for relational analysis and metrics  
- **Power BI:** Interactive dashboards for business intelligence  
- **Version Control:** GitHub  

---

## Folder Structure
RetailNova_Sales_Analysis/
├─ Data/ (raw & cleaned datasets, merged dataset)
├─ Notebooks/ (Python analysis, EDA, and feature engineering)
├─ SQL/ (queries & ER diagram)
├─ Dashboard/ (Power BI dashboards)
├─ Docs/ (final report & data cleaning documentation)
├─ Visualizations/ (charts & insights snapshots)
├─ README.md
└─ requirements.txt

## How to Explore
1. Clone the repository:
```bash
git clone https://github.com/your-username/RetailNova_Sales_Analysis.git

**Open notebooks for Python analysis:**
cd RetailNova_Sales_Analysis/Notebooks
jupyter notebook RetailNova_Sales_Analysis.ipynb

Open Power BI dashboards from the Dashboard folder to explore KPIs and insights.

