create database healthcare;
use healthcare;

CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    blood_type VARCHAR(5)
);

CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_name VARCHAR(100)
);

CREATE TABLE hospitals (
    hospital_id INT AUTO_INCREMENT PRIMARY KEY,
    hospital_name VARCHAR(150)
);

CREATE TABLE insurance (
    insurance_id INT AUTO_INCREMENT PRIMARY KEY,
    provider_name VARCHAR(100)
);

CREATE TABLE admissions (
    admission_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    hospital_id INT,
    insurance_id INT,
    medical_condition VARCHAR(100),
    admission_date DATE,
    discharge_date DATE,
    admission_type VARCHAR(50),
    room_number INT,
    billing_amount DECIMAL(10,2),
    medication VARCHAR(100),
    test_results VARCHAR(50)
);

/*Insert statements*/

INSERT INTO patients (name, age, gender, blood_type)
SELECT DISTINCT Name, Age, Gender, `Blood Type`
FROM healthcaredata;

select * 
from patients;

INSERT INTO doctors (doctor_name)
SELECT DISTINCT Doctor
FROM healthcaredata;

select * 
from doctors;

INSERT INTO hospitals (hospital_name)
SELECT DISTINCT Hospital
FROM healthcaredata;

select * 
from hospitals;

INSERT INTO insurance (provider_name)
SELECT DISTINCT `Insurance Provider`
FROM healthcaredata;

select * 
from insurance;

INSERT INTO admissions (
    patient_id,
    doctor_id,
    hospital_id,
    insurance_id,
    medical_condition,
    admission_date,
    discharge_date,
    admission_type,
    room_number,
    billing_amount,
    medication,
    test_results
)
SELECT 
    p.patient_id,
    d.doctor_id,
    ho.hospital_id,
    i.insurance_id,
    h.`Medical Condition`,
    h.`Date of Admission`,
    h.`Discharge Date`,
    h.`Admission Type`,
    h.`Room Number`,
    h.`Billing Amount`,
    h.`Medication`,
    h.`Test Results`
FROM healthcaredata h
JOIN patients p ON h.Name = p.name
JOIN doctors d ON h.Doctor = d.doctor_name
JOIN hospitals ho ON h.Hospital = ho.hospital_name
JOIN insurance i ON h.`Insurance Provider` = i.provider_name;

select * 
from admissions;

/*-------------------------------------------------------------------------------*/

/* 1.Total Revenue Per Hospital */ 
SELECT h.hospital_name, SUM(a.billing_amount) AS total_revenue
FROM admissions a
JOIN hospitals h ON a.hospital_id = h.hospital_id
GROUP BY h.hospital_name
ORDER BY total_revenue DESC;

/* 2.Doctor with the most patients*/
SELECT d.doctor_name, COUNT(a.admission_id) AS total_patients
FROM admissions a
JOIN doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_name
ORDER BY total_patients DESC;

/* 3.Most common medical condition*/
SELECT medical_condition, COUNT(*) AS cases
FROM admissions
GROUP BY medical_condition
ORDER BY cases DESC;

/* 4.Which medications are used the most*/
SELECT medication, COUNT(*) as Common_Medication
FROM admissions 
GROUP BY medication
ORDER BY Common_Medication DESC; 

/* 5.Revenue Per Doctor*/
SELECT d.doctor_name, SUM(a.billing_amount) as Total_Revenue
FROM admissions a
JOIN doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_name
ORDER BY Total_Revenue DESC;

/* Top 5 Revenue generating doctors*/
SELECT d.doctor_name, SUM(a.billing_amount) as Total_Revenue
FROM admissions a
JOIN doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_name
ORDER BY Total_Revenue DESC
LIMIT 5;

/* 6. Admission by age group*/
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

/* 7. Commonly used insurance provider*/
SELECT i.provider_name, COUNT(a.insurance_id) as Times_Used
FROM admissions a
JOIN insurance i ON a.insurance_id = i.insurance_id
GROUP BY i.provider_name
ORDER BY Times_Used DESC;

SELECT distinct h.hospital_name, i.provider_name, COUNT(i.insurance_id) as Total_Times_Used
FROM admissions a
JOIN hospitals h ON a.hospital_id = h.hospital_id
JOIN insurance i ON a.insurance_id = i.insurance_id
GROUP BY h.hospital_name, i.provider_name
ORDER BY Total_Times_Used DESC;

/* 7. Most revenue generating insurance*/
SELECT i.provider_name, SUM(a.billing_amount) as Total_Amount
FROM admissions a
JOIN insurance i ON a.insurance_id = i.insurance_id
GROUP BY i.provider_name
ORDER BY Total_Amount DESC;

/* 8. Common Blood type*/
SELECT blood_type, COUNT(blood_type) as Common_type
FROM patients
GROUP BY blood_type
ORDER BY Common_type DESC;

/* 9. emergency admission vs planned admission*/
SELECT admission_type, COUNT(admission_type) as Total_Admissions
FROM admissions
GROUP BY admission_type
ORDER BY Total_Admissions;

/* 10. Hospital with the highest number of admissions*/
SELECT h.hospital_name, COUNT(a.admission_id) as Total_Admissions
FROM admissions a
JOIN hospitals h ON a.hospital_id = h.hospital_id
GROUP BY h.hospital_name
ORDER BY Total_Admissions DESC;

/* 11. Top 5 hospitals with most admissions*/
SELECT h.hospital_name, COUNT(a.admission_id) as Total_Admissions
FROM admissions a
JOIN hospitals h ON a.hospital_id = h.hospital_id
GROUP BY h.hospital_name
ORDER BY Total_Admissions DESC
LIMIT 5;

/*12. Conditions resulting in longer stays*/
SELECT medical_condition, ROUND(AVG(DATEDIFF(discharge_date, admission_date)), 2) AS avg_stay_days
FROM admissions
GROUP BY medical_condition
ORDER BY avg_stay_days DESC;

/*13. highest billing amounts condition*/
SELECT medical_condition, SUM(billing_amount) as Total_Revenue
FROM admissions
GROUP BY medical_condition
ORDER BY Total_Revenue DESC;

/*14. Average stay per admission type*/
SELECT admission_type, ROUND(AVG(DATEDIFF(discharge_date, admission_date)),2) as AVG_Stay
FROM admissions
GROUP BY admission_type
ORDER BY AVG_Stay DESC;

/*15. Do emergency admissions lead to longer stays?*/
SELECT admission_type, ROUND(AVG(DATEDIFF(discharge_date, admission_date)), 2) AS avg_stay_days
FROM admissions
GROUP BY admission_type
ORDER BY avg_stay_days DESC;

/*16. Admissions per age group*/
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

/*17. does staying longer means paying more?*/
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





