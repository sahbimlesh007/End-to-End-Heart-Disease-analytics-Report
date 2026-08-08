CREATE TABLE heart (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    age INT NOT NULL,
    sex VARCHAR(10),
    chest_pain_type VARCHAR(20),
    resting_bp INT,
    cholesterol INT,
    fasting_bs TINYINT,
    resting_ecg VARCHAR(20),
    max_hr INT,
    exercise_angina VARCHAR(5),
    oldpeak DECIMAL(4,2),
    st_slope VARCHAR(20),
    heart_disease TINYINT
);
select * from heart;