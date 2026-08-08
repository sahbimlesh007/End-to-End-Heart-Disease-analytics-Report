import streamlit as st
import pandas as pd
import joblib

# Load saved objects
model = joblib.load("LOG_heart.pkl")
scaler = joblib.load("scaler.pkl")
expected_columns = joblib.load("columns.pkl")

st.title("Heart Disease Prediction System")
st.markdown("Provide the following details to predict your heart disease risk.")

# -------------------------
# User Inputs
# -------------------------
age = st.slider("Age", 18, 100, 30)
sex = st.selectbox("Sex", ["M", "F"])
chest_pain = st.selectbox("Chest Pain Type", ["ATA", "NAP", "TA", "ASY"])
resting_bp = st.number_input("Resting Blood Pressure (mm Hg)", 80, 200, 120)
cholesterol = st.number_input("Cholesterol (mg/dL)", 100, 600, 200)
fasting_bs = st.selectbox("Fasting Blood Sugar > 120 mg/dL", [0, 1])
resting_ecg = st.selectbox("Resting ECG", ["Normal", "ST", "LVH"])
max_hr = st.slider("Maximum Heart Rate", 60, 220, 150)
exercise_angina = st.selectbox("Exercise-Induced Angina", ["N", "Y"])
oldpeak = st.slider("Oldpeak (ST Depression)", 0.0, 6.0, 1.0)
st_slope = st.selectbox("ST Slope", ["Up", "Flat", "Down"])

# -------------------------
# Prediction
# -------------------------
if st.button("Predict"):

    # Create raw dataframe (same format as original dataset)
    input_df = pd.DataFrame([{
        "Age": age,
        "Sex": sex,
        "ChestPainType": chest_pain,
        "RestingBP": resting_bp,
        "Cholesterol": cholesterol,
        "FastingBS": fasting_bs,
        "RestingECG": resting_ecg,
        "MaxHR": max_hr,
        "ExerciseAngina": exercise_angina,
        "Oldpeak": oldpeak,
        "ST_Slope": st_slope
    }])

    # Apply the same encoding used during training
    input_df = pd.get_dummies(input_df, drop_first=True)

    # Add any missing columns
    for col in expected_columns:
        if col not in input_df.columns:
            input_df[col] = 0

    # Keep only training columns and in the same order
    input_df = input_df[expected_columns]

    # Scale
    scaled_input = scaler.transform(input_df)

    # Predict
    prediction = model.predict(scaled_input)[0]
    probability = model.predict_proba(scaled_input)[0]

    # Debug (remove later if you don't need it)
    st.subheader("Processed Input")
    st.dataframe(input_df)

    st.write("Prediction:", prediction)
    st.write(
        f"Probability of Heart Disease: {probability[1]:.2%}"
    )

    if prediction == 1:
        st.error(
            f"⚠️ High Risk of Heart Disease\n\nProbability: {probability[1]:.2%}"
        )
    else:
        st.success(
            f"✅ Low Risk of Heart Disease\n\nProbability: {probability[1]:.2%}"
        )