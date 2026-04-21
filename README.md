🏥 Healthcare Data Analysis Project (SQL)
##

📌 Project Overview

This project focuses on analyzing a healthcare dataset using SQL to uncover key business insights related to hospital performance, patient demographics, doctor efficiency, and revenue generation.

The dataset was normalized into multiple relational tables:

🔹patients

🔹doctors

🔹hospitals

🔹insurance

🔹admissions

The goal of this project is to simulate real world healthcare analytics and answer important business questions using SQL.
##

🎯 Objectives

🔹Analyze hospital and doctor performance

🔹Understand patient demographics and trends

🔹Identify high revenue areas

🔹Evaluate operational efficiency (admissions, stay duration)

🔹Discover patterns in medical conditions and treatments
##

🗂️ Database Structure

The dataset was transformed into a relational database with the following relationships:

🔹Each patient can have multiple admissions

Each admission is linked to:

🔹one doctor

🔹one hospital

🔹one insurance provider


This structure ensures:

🔹Reduced data redundancy

🔹Better query performance

🔹Real world database design practices
##

📊 Key Business Questions & Analysis

💰 Revenue Analysis

🔹What is the total revenue generated per hospital?

🔹Which doctors generate the most revenue?

🔹Who are the top 5 revenue generating doctors?

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
##

🛠️ Tools & Technologies

🔹SQL (MySQL)

🔹Relational Database Design

🔹Data Cleaning & Transformation

🔹Joins, Aggregations, Grouping, Sorting
##

🧠 SQL Analysis - 📈Key Insights

🔹Total Revenue Per Hospital

SELECT h.hospital_name, SUM(a.billing_amount) AS total_revenue

FROM admissions a

JOIN hospitals h ON a.hospital_id = h.hospital_id

GROUP BY h.hospital_name

ORDER BY total_revenue DESC;

📈Insight: 

Certain hospitals generate significantly higher revenue, not due to higher admission rates but type and cost of treatment.

🔹Doctor with the most patients

SELECT d.doctor_name, COUNT(a.admission_id) AS total_patients

FROM admissions a

JOIN doctors d ON a.doctor_id = d.doctor_id

GROUP BY d.doctor_name

ORDER BY total_patients DESC;

📈Insight:

Dr. M Smith handles the highest number of patients, indicating a significant workload concentration. This may suggest strong expertise or high demand for their specialization, but it could also highlight potential workload imbalance within the hospital.

🔹High billing condition

SELECT medical_condition, SUM(billing_amount) as Total_Revenue

FROM admissions

GROUP BY medical_condition

ORDER BY Total_Revenue DESC;

📈Insight:

The dataset does not have enough variation to show meaningful differences between total billing per medical conditions.

🔹Common Medical Condition

SELECT medical_condition, COUNT(*) AS cases

FROM admissions

GROUP BY medical_condition

ORDER BY cases DESC;

📈Insight:

The dataset does not have enough variation to show meaningful differences between medical conditions.


🔹Revenue Per Doctor

SELECT d.doctor_name, SUM(a.billing_amount) as Total_Revenue

FROM admissions a

JOIN doctors d ON a.doctor_id = d.doctor_id

GROUP BY d.doctor_name

ORDER BY Total_Revenue DESC

LIMIT 5;

📈Insight:

A small number of doctors contribute to a large portion of total revenue of 7 figures.

🔹Admission by Age Group

SELECT 

    CASE 
    
        WHEN p.age BETWEEN 0 AND 18 THEN '0-18'
        
        WHEN p.age BETWEEN 19 AND 35 THEN '19-35'
        
        WHEN p.age BETWEEN 36 AND 60 THEN '36-60'
        
        ELSE '60+'
    
    END AS age_group,
    
    COUNT(a.admission_id) AS total_admissions

FROM admissions a

JOIN patients p ON a.patient_id = p.patient_id

GROUP BY age_group

ORDER BY total_admissions DESC;

📈Insight:

Middle aged and older patients show higher admission rates compared to teenagers.

🔹Total admissions per Hospital

SELECT h.hospital_name, COUNT(a.admission_id) as Total_Admissions

FROM admissions a

JOIN hospitals h ON a.hospital_id = h.hospital_id

GROUP BY h.hospital_name

ORDER BY Total_Admissions DESC;

📈Insight:

Although some hospitals handle the highest number of admissions, they are not the top revenue generators. This indicates that patient volume alone does not drive profitability, and that higher revenue is likely associated with specialized or higher-cost treatments.

🔹Average Stay Per Admission type

SELECT admission_type, ROUND(AVG(DATEDIFF(discharge_date, admission_date)),2) as AVG_Stay

FROM admissions

GROUP BY admission_type

ORDER BY AVG_Stay DESC;

📈Insight:

Despite differences in admission types (Emergency, Urgent, Elective), the average hospital stay remains consistent at around 15 days. This suggests that admission type has minimal impact on patient stay duration, and that medical condition or treatment complexity may be the primary drivers.

🔹most revenue generating insurance provider

SELECT i.provider_name, SUM(a.billing_amount) as Total_Amount

FROM admissions a

JOIN insurance i ON a.insurance_id = i.insurance_id

GROUP BY i.provider_name

ORDER BY Total_Amount DESC;

📈Insight:
The dataset may not capture real world variation in insurance billing, The analysis shows that revenue contribution from insurance providers is relatively uniform across hospitals.


🔹billing amount per length of stay 

SELECT 

    CASE 
    
        WHEN DATEDIFF(discharge_date, admission_date) <= 3 THEN 'Short Stay (0-3 days)'
        
        WHEN DATEDIFF(discharge_date, admission_date) <= 7 THEN 'Medium Stay (4-7 days)'
        
        ELSE 'Long Stay (8+ days)'
   
    END AS stay_category,
    
    COUNT(*) AS total_patients,
    
    ROUND(AVG(billing_amount), 2) AS avg_billing

FROM admissions

GROUP BY stay_category

ORDER BY total_patients DESC; 

📈Insight:

Although long staying patients make up the majority of admissions, the average billing amount remains consistent across all stay durations. Interestingly, medium length stays show the highest average cost, suggesting that billing is more influenced by treatment intensity rather than duration of stay.

##

🚀 What I Learned

🔹How to normalize raw datasets into structured relational databases

🔹Writing advanced SQL queries using:

🔹JOINS

🔹GROUP BY

🔹агрегations (SUM, COUNT, AVG, DATEDIFF)

🔹Translating business questions into SQL queries

🔹Extracting meaningful insights from data
##

📌 Conclusion

This project demonstrates the use of SQL in solving real world healthcare problems by transforming raw data into actionable insights. It highlights key areas such as revenue generation, hospital efficiency, and patient trends.
