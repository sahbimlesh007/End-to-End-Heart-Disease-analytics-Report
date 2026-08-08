CREATE INDEX idx_heart_disease ON heart(heart_disease);

CREATE INDEX idx_sex ON heart(sex);

CREATE INDEX idx_age ON heart(age);

CREATE INDEX idx_cholesterol ON heart(cholesterol);

CREATE INDEX idx_max_hr ON heart(max_hr);

CREATE INDEX idx_chest_pain ON heart(chest_pain_type);

show indexes from heart;