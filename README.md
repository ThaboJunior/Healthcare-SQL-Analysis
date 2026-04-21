🏥 Healthcare Data Analysis Project (SQL)
📌 Project Overview

This project focuses on analyzing a healthcare dataset using SQL to uncover key business insights related to hospital performance, patient demographics, doctor efficiency, and revenue generation.

The dataset was normalized into multiple relational tables:

🔹patients

🔹doctors

🔹hospitals

🔹insurance

🔹admissions

The goal of this project is to simulate real-world healthcare analytics and answer important business questions using SQL.

🎯 Objectives
🔹Analyze hospital and doctor performance

🔹Understand patient demographics and trends

🔹Identify high-revenue areas

🔹Evaluate operational efficiency (admissions, stay duration)

🔹Discover patterns in medical conditions and treatments


🗂️ Database Structure

The dataset was transformed into a relational database with the following relationships:

Each patient can have multiple admissions

Each admission is linked to:

one doctor

one hospital

one insurance provider


This structure ensures:

🔹Reduced data redundancy

🔹Better query performance

🔹Real-world database design practices


📊 Key Business Questions & Analysis

💰 Revenue Analysis
🔹What is the total revenue generated per hospital?
🔹Which doctors generate the most revenue?
🔹Who are the top 5 revenue-generating doctors?
🔹Which medical conditions generate the highest revenue?
🔹Is there a relationship between length of stay and billing amount?


👨‍⚕️ Doctor Performance
🔹Which doctor handles the most patients?
🔹What is the total number of patients per doctor?


🏥 Hospital Performance
🔹Which hospitals have the highest number of admissions?
🔹What are the top 5 busiest hospitals?


🧑‍🤝‍🧑 Patient & Demographics
🔹Are certain age groups admitted more frequently?
🔹What are the most common blood types among patients?


🏥 Admissions Analysis
🔹Which admission type is most common?
🔹Do emergency admissions occur more frequently than planned ones?


💊 Medical Insights
🔹What are the most common medical conditions?
🔹Which medications are used the most?
🔹Which conditions result in longer hospital stays?


🧾 Insurance Analysis
🔹Which insurance providers are most commonly used?


⏱️ Operational Efficiency
🔹What is the average hospital stay per admission type?
🔹Do emergency admissions lead to longer stays?


🛠️ Tools & Technologies
🔹SQL (MySQL)
🔹Relational Database Design
🔹Data Cleaning & Transformation
🔹Joins, Aggregations, Grouping, Sorting


📈 Key Insights (Example)

(Replace these with your actual results after running queries)

Certain hospitals generate significantly higher revenue due to higher admission rates.
A small number of doctors contribute to a large portion of total revenue.
Emergency admissions tend to have longer average stay durations.
Some medical conditions consistently result in higher billing amounts.
Middle-aged and older patients show higher admission rates.

🧠 SQL Analysis

🔹Total Revenue Per Hospital

SELECT h.hospital_name, SUM(a.billing_amount) AS total_revenue

FROM admissions a

JOIN hospitals h ON a.hospital_id = h.hospital_id

GROUP BY h.hospital_name

ORDER BY total_revenue DESC;

📈Insight: 

Certain hospitals generate significantly higher revenue due to higher admission rates.

🔹Doctor with the most patients
📈Insight:

🔹Common Medical Condition
📈Insight:

🔹Revenue Per Doctor
📈Insight:
A small number of doctors contribute to a large portion of total revenue.

🔹Admission by Age Group
📈Insight:
Middle-aged and older patients show higher admission rates.

🔹Total admissions per Hospital
📈Insight:

🔹Average Stay Per Admission type
📈Insight:

🔹Common insurance provider
📈Insight:

🔹Days stayed per admission type
📈Insight:
Although long-stay patients make up the majority of admissions, the average billing amount remains consistent across all stay durations. This suggests that hospital charges are likely driven more by treatment type rather than length of stay.


🚀 What I Learned
How to normalize raw datasets into structured relational databases
Writing advanced SQL queries using:
JOINS
GROUP BY
агрегations (SUM, COUNT, AVG, DATEDIFF)
Translating business questions into SQL queries
Extracting meaningful insights from data


📌 Conclusion

This project demonstrates the use of SQL in solving real-world healthcare problems by transforming raw data into actionable insights. It highlights key areas such as revenue generation, hospital efficiency, and patient trends.
