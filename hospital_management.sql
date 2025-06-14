CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10)
);

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100),
    specialty VARCHAR(50)
);

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Diagnosis (
    diagnosis_id INT PRIMARY KEY,
    patient_id INT,
    disease VARCHAR(100),
    treatment VARCHAR(100),
    discharge_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Sample data
INSERT INTO Patients VALUES (1, 'Ayesha', 30, 'Female');
INSERT INTO Patients VALUES (2, 'Ravi', 42, 'Male');
INSERT INTO Patients VALUES (3, 'Meena', 25, 'Female');

INSERT INTO Doctors VALUES (101, 'Dr. Arun', 'Cardiology');
INSERT INTO Doctors VALUES (102, 'Dr. Priya', 'Orthopedics');
INSERT INTO Doctors VALUES (103, 'Dr. Nithya', 'Neurology');

INSERT INTO Appointments VALUES (1001, 1, 101, '2024-12-01');
INSERT INTO Appointments VALUES (1002, 2, 102, '2024-12-03');
INSERT INTO Appointments VALUES (1003, 3, 101, '2024-12-05');

INSERT INTO Diagnosis VALUES (501, 1, 'Hypertension', 'Medication', '2024-12-10');
INSERT INTO Diagnosis VALUES (502, 2, 'Fracture', 'Surgery', '2024-12-15');
INSERT INTO Diagnosis VALUES (503, 3, 'Migraine', 'Therapy', '2024-12-08');

-- Useful queries

-- 1. List all patient appointments with doctor names
SELECT p.name AS patient, d.name AS doctor, d.specialty, a.appointment_date
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id;

-- 2. Count patients per doctor
SELECT d.name AS doctor, COUNT(*) AS total_patients
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.name;

-- 3. Most common disease treated
SELECT disease, COUNT(*) AS cases
FROM Diagnosis
GROUP BY disease
ORDER BY cases DESC;

-- 4. Average patient age per department
SELECT d.specialty, AVG(p.age) AS avg_age
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
JOIN Patients p ON a.patient_id = p.patient_id
GROUP BY d.specialty;