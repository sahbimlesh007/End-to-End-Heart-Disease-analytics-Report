CREATE VIEW vw_patient_summary AS
SELECT
    patient_id,
    age,
    sex,
    chest_pain_type,
    resting_bp,
    cholesterol,
    fasting_bs,
    resting_ecg,
    max_hr,
    exercise_angina,
    oldpeak,
    st_slope,
    heart_disease
FROM heart;


select  * from vw_patient_summary limit 10;

CREATE VIEW vw_gender_analysis AS
SELECT
    sex,
    COUNT(*) AS total_patients,
    SUM(heart_disease) AS disease_cases,
    ROUND(
        (SUM(heart_disease) * 100.0) / COUNT(*),
        2
    ) AS disease_rate
FROM heart
GROUP BY sex;


CREATE VIEW vw_chest_pain_analysis AS
SELECT
    chest_pain_type,
    COUNT(*) AS total_patients,
    SUM(heart_disease) AS disease_cases,
    ROUND(
        (SUM(heart_disease) * 100.0) / COUNT(*),
        2
    ) AS disease_rate
FROM heart
GROUP BY chest_pain_type;


CREATE VIEW vw_age_analysis AS
SELECT
    CASE
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 40 THEN '30-40'
        WHEN age BETWEEN 41 AND 50 THEN '41-50'
        WHEN age BETWEEN 51 AND 60 THEN '51-60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS total_patients,
    SUM(heart_disease) AS disease_cases
FROM heart
GROUP BY age_group;


CREATE VIEW vw_cholesterol_analysis AS
SELECT
    CASE
        WHEN cholesterol < 200 THEN 'Normal'
        WHEN cholesterol BETWEEN 200 AND 239 THEN 'Borderline'
        ELSE 'High'
    END AS cholesterol_category,
    COUNT(*) AS total_patients,
    SUM(heart_disease) AS disease_cases
FROM heart
GROUP BY cholesterol_category;