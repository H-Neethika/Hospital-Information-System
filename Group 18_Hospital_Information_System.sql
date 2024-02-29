
show databases;
CREATE DATABASE Hospital_Information_System;

USE Hospital_Information_System;

CREATE TABLE Doctor(
Doctor_id varchar(15) not null,
First_name varchar(30) not null,
Last_name varchar(30) not null,
Date_of_birth date not null,
Street varchar(50),
City varchar(20),
Province varchar(40),
Specialization varchar(40),
primary key(Doctor_id),
unique key Name_birth (First_name,Last_name,Date_of_birth)
 );
 insert into Doctor values
 ('D01','Sanath','Kumara','1980-10-28','Clock tower junction','Vavuniya','Northern','Orthopedics'),
 ('D02','Lahiru','Kumara','1980-10-28','Kurumankadu','Colombo','Western','Pediatrics'),
 ('D03','Madushan','Lahiru','1975-09-20','Wakvella','Galle','Southern','Neurology'),
 ('D04','Madushan','Thilanka','1975-09-20','Wellavatta','Colombo','Western','Dermatology'),
 ('D05','Thilanka','Weerasinghe','1982-10-28','Nalloor','Jaffna','Northern','Psychiatry'),
 ('D06','Madushan','Thilanka','1972-03-18','Kithul Road','Hatton','Central','Cardiology');
 select * from Doctor;


 CREATE TABLE Doctor_PhoneNumber 
 (Doc_id varchar(15) not null,
 Phone_number varchar(10) not null,
 primary key(Doc_id,Phone_number),
 constraint fkDoc foreign key(Doc_id) references Doctor(Doctor_id) on delete cascade on update cascade);
  
 insert into Doctor_PhoneNumber values
 ('D01','0768993412'),
 ('D01','0728393412'),
 ('D02','0776493412'),
 ('D03','0769341412'),
 ('D04','0728972812'),
 ('D04','0768283934'),
 ('D05','0740993412'),
 ('D06','0728123412');
 
  select * from Doctor_Phonenumber;
  
 create table medicine(
 Medicine_id varchar(30) not null,
 Medincine_name varchar(25),
 Price integer not null,
 Description varchar(100),
 Quantity_in_mg int not null,
 primary key(Medicine_id));
 
 insert into medicine values
 ('M0001','Carisoprodol ','485.00','Pain reliever',50),
 ('M0002','Cetirizine ','600.00','Allergy medication',50),
 ('M0003','amoxicillin','385.00',null,50),
 ('M0004','diclofenac gel','100.00','Pain reliever',50),
 ('M0005','Delsym (syrup)','250.00','Cough suppressant',50),
 ('M0006','Chlorzoxazone ','900.00','Muscle relaxant',50);
 
 select * from medicine;
  
 create table Prescription
 (Prescription_id varchar(100) not null,
 Dosage int ,
 No_of_days int,
 Prescibed_date date,
 primary key(Prescription_id),
 Doc_id varchar(15) not null default 'D01',
 constraint fk_PresDoc foreign key(Doc_id) references Doctor(Doctor_id) on delete cascade on update cascade);
 
 INSERT INTO Prescription(Prescription_id,Dosage,No_of_days,Prescibed_date) VALUES
('PR001', 2, 7, '2023-08-15'),
('PR002', 1, 14 ,'2023-08-20'),
('PR003', 3, 5, '2023-08-25'),
('PR004', 2, 10, '2023-08-28'),
('PR005', 1, 7, '2023-08-30'),
('PR006', 2, 3, '2023-09-02');
 select * from Prescription;
 
 
create table Pres_Medi_Relation(
Prescription_id varchar(100) not null,
Med_id varchar(30) not null,
primary key(Prescription_id,Med_id),
constraint fk_pres foreign key(Prescription_id) references Prescription(Prescription_id)on delete cascade on update cascade,
constraint fk_med foreign key(Med_id) references medicine(Medicine_id)on delete cascade on update cascade);
 INSERT INTO Pres_Medi_Relation VALUES
 ('PR001','M0001'),
 ('PR001','M0002'),
 ('PR002','M0004'),
 ('PR002','M0003'),
 ('PR002','M0001'),
 ('PR003','M0001'),
 ('PR004','M0001'),
 ('PR005','M0001');
 select * from Pres_Medi_Relation;
  
 create table Non_medical_staff(
	Staff_id varchar(10) not null,
	Manager_id varchar(10) ,
	First_name varchar(30) not null,
	Last_name varchar(30) not null,
	Date_of_birth date not null,
	Gender varchar(1),
	Job_title varchar(30),
	Street varchar(50),
	City varchar(20),
	Province varchar(40),
	unique key Name_birth (First_name,Last_name,Date_of_birth),
	primary key( Staff_id),
	constraint fk_staff foreign key(Manager_id) references Non_medical_staff(Staff_id));
INSERT INTO Non_medical_staff VALUES
 ('S001',null,'Christi','Smith','1985-05-10','M','Manager','123 Main St','Cityville','CA'),
 ('S002','S001','Emily','Williams','1970-01-10','M','Admin Asst','456 Elm St','Townsville','NY'),
 ('S003','S001','Jane','Williams','1970-01-10','F','IT Support','123 second St','Southwest','Central'),
 ('S004','S002','Emily','Doe','1970-01-10','F','HR Asst',null,'Vavuniya','Northern'),
 ('S005','S002','Michael','Doe','1975-05-10','M','Ambulance driver','101 Pine Ave','Galle','Southern'),
 ('S006','S002','Christi','Smith','1995-05-10','F','Ward clerk','13 Main St','Hatton','Central');
select * from Non_medical_staff;
  
 create table Staff_contact_relation
	(Staff_id varchar(10) not null,
	Phone_number varchar(10) not null,
	primary key(Staff_id,Phone_number),
	constraint fkStaff foreign key(Staff_id) references Non_medical_staff(Staff_id) on delete cascade on update cascade);
 
 insert into Staff_contact_relation values
	('S001','0768993412'),
	('S001','0728393412'),
	('S002','0776493412'),
	('S003','0769341412'),
	('S004','0728972812'),
	('S005','0768283934'),
	('S006','0740993412'),
	('S006','0728123412');
    
 select * from Staff_contact_relation;
  
 create table Department(
	Department_id varchar(10) not null,
	Department_name varchar(20) , 
	Head_id varchar(15) not null,
	primary key(Department_id),
	constraint fk_dep foreign key(Head_id) references doctor(Doctor_id)on delete cascade on update cascade);
 
 insert into department values
	('DE01','Pediatrics ','D02'),
	('DE02','Orthopaedic','D01'),
	('DE03','Psychiatry ','D05'),
	('DE04','Neurology ','D03'),
	('DE05','Dermatology','D04'),
	('DE06','Inpatient ','D06');
 select  * from department;
 
create table Department_Staff_Relation(
	Dep_id varchar(10) not null,
	Staff_id varchar(10) not null,
	primary key(Dep_id,Staff_id),
	constraint fkDepStaff foreign key(Staff_id) references Non_medical_staff(Staff_id) on delete cascade on update cascade,
	constraint fkDep foreign key(Dep_id) references Department(Department_id) on delete cascade on update cascade);
insert into Department_Staff_Relation values
	('DE01','S001'),
	('DE01','S002'),
	('DE02','S002'),
	('DE02','S003'),
	('DE02','S004'),
	('DE03','S001'),
	('DE04','S001'),
	('DE05','S005'),
	('DE06','S006');
 
select  * from  Department_Staff_Relation;
 
create table Department_Doc_Relation(
	Dep_id varchar(10) not null,
	Doc_id varchar(10) not null,
	primary key(Dep_id,Doc_id),
	constraint fkDepDoc foreign key(Doc_id) references Doctor(Doctor_id) on delete cascade on update cascade,
	constraint fk_RDep foreign key(Dep_id) references Department(Department_id) on delete cascade on update cascade);
insert into Department_Doc_Relation values
	('DE01','D02'),
	('DE01','D01'),
	('DE01','D05'),
	('DE02','D01'),
	('DE03','D02'),
	('DE03','D05'),
	('DE04','D03'),
	('DE05','D04'),
	('DE05','D06'),
	('DE06','D06');
select  * from  Department_Doc_Relation;

create table Test_report(
Test_id  varchar(10) not null,
Test_name varchar(50),
Tested_date date,
Tested_time time,
result varchar(100),
primary key(Test_id));

insert into Test_report values
('TR0001','Blood test','2023-07-13','15:00','All are normal'),
('TR0002','hematocrit','2023-07-14','11:00','All are normal'),
('TR0003','Liver function test','2023-07-14','09:00','All are normal'),
('TR0004','Pregnancy test','2023-07-16','15:00','positve'),
('TR0005','Kidney function test','2023-07-18','14:00','In the middle level of kidney failure'),
('TR0006','Syphilis test','2023-07-19','15:30','All are normal'); 

select * from Test_report;
create table Patient(
	patient_id varchar(20)not null,
	First_name varchar(30) not null,
	Last_name varchar(30) not null,
	Gender varchar(1),
	Age int,
	Street varchar(50),
	City varchar(20),
	Province varchar(40),
	primary key(Patient_id)
);
INSERT INTO Patient VALUES
('P001', 'John', 'Smith', 'M', 45, '123 Main St', 'Anytown', 'California'),
('P002', 'Jane', 'Doe', 'F', 32, '456 Elm Ave', 'Springfield', 'Illinois'),
('P003', 'Michael', 'Johnson', 'M', 28, '789 Oak Rd', 'Oakville', 'New York'),
('P004', 'Emily', 'Williams', 'F', 60, '101 Pine St', 'Pineville', 'Louisiana'),
('P005', 'David', 'Brown', 'M', 50, '222 Maple Lane', 'Maple City', 'Michigan'),
('P006', 'Sarah', 'Anderson', 'F', 22, '555 Cedar Ave', 'Cedarville', 'Texas');
select * from patient;


create table Patient_Doctor_relation
	(Patient_id varchar(20)not null,
	Doctor_id varchar(15) not null,
	primary key(Patient_id,Doctor_id),
	constraint fkPat foreign key(Patient_id) references patient(Patient_id) on delete cascade on update cascade,
	constraint fk_Doc foreign key(Doctor_id) references Doctor(Doctor_id) on delete cascade on update cascade
);
INSERT INTO Patient_Doctor_relation VALUES
('P001','D01'),
('P001','D02'),
('P001','D03'),
('P002','D01'),
('P003','D03'),
('P004','D01'),
('P004','D05'),
('P005','D02'),
('P005','D03'),
('P006','D06');
select * from Patient_Doctor_relation;

create table Patient_Med_relation
	(Patient_id varchar(20)not null,
	Med_id varchar(15) not null,
	primary key(Patient_id,Med_id),
	constraint fk_Pat foreign key(Patient_id) references patient(Patient_id) on delete cascade on update cascade,
	constraint fk_PMed foreign key(Med_id) references Medicine(Medicine_id) on delete cascade on update cascade
);
insert into Patient_Med_relation values
('P001','M0001'),
('P002','M0001'),
('P002','M0002'),
('P002','M0004'),
('P003','M0005'),
('P003','M0001'),
('P004','M0006'),
('P005','M0004'),
('P006','M0002');
select * from Patient_Med_relation;


 create table Patient_contact_relation
 (Pat_id varchar(10) not null,
 Phone_number varchar(10) not null,
 primary key(Pat_id,Phone_number),
 constraint fkPC foreign key(Pat_id) references Patient(Patient_id) on delete cascade on update cascade);
 
 insert into Patient_contact_relation values
 ('P001','0768993412'),
 ('P001','0728393412'),
 ('P002','0724787912'),
 ('P003','0769001412'),
 ('P004','0728972812'),
 ('P005','0765778684'),
 ('P006','0740993412'),
 ('P006','0728123412');
 
 select * from Patient_contact_relation;
 
 
 
 create table Patient_Test_relation
(Patient_id varchar(20)not null,
Test_id varchar(15) not null,
primary key(Patient_id,Test_id),
constraint fk_TPat foreign key(Patient_id) references patient(Patient_id) on delete cascade on update cascade,
constraint fk_PTest foreign key(Test_id) references Test_report(Test_id) on delete cascade on update cascade);

insert into Patient_Test_relation values
('P001','TR0001'),
('P001','TR0003'),
('P002','TR0002'),
('P002','TR0004'),
('P003','TR0005'),
('P004','TR0006');

select * from Patient_Test_relation;

create table Patient_Prescription_relation
(Patient_id varchar(20)not null,
Pres_id varchar(15) not null,
primary key(Patient_id,Pres_id),
constraint fk_PPat foreign key(Patient_id) references patient(Patient_id) on delete cascade on update cascade,
constraint fk_PPres foreign key(Pres_id) references Prescription(Prescription_id) on delete cascade on update cascade);

insert into Patient_Prescription_relation values
('P001','PR001'),
('P001','PR002'),
('P001','PR003'),
('P002','PR004'),
('P003','PR005'),
('P004','PR006');

select * from Patient_Prescription_relation;

create table appointment(
Appintment_date date not null,
Appintment_time time not null,
current_status varchar(20),
patient_id varchar(30) not null,
constraint fk_PatApp foreign key(Patient_id) references patient(Patient_id) on delete cascade on update cascade);

insert into appointment values
('2023-08-20','17:00','pending','P001'),
('2023-08-21','15:00','confirmed','P001'),
('2023-08-23','15:00','completed','P001'),
('2023-08-20','15:00','canceled','P001'),
('2023-08-20','15:00','confirmed','P005'),
('2023-08-21','17:00','pending','P004');

select * from appointment;

create table app_reason(
Appintment_date date not null,
Appintment_time time not null,
patient_id varchar(30) not null,
reason varchar(30) not null,
constraint fk_AppReason foreign key(Patient_id) references patient(Patient_id) on delete cascade on update cascade);

insert into app_reason values
('2023-08-20','17:00','P001','ill'),
('2023-08-20','17:00','P001','Diabetics'),
('2023-08-21','15:00','P001','Full checkup'),
('2023-08-23','15:00','P001','Knee pain'),
('2023-08-20','15:00','P001','ill'),
('2023-08-22','15:00','P005','Tooth pain'),
('2023-08-21','17:00','P004','ill'); 

select * from app_reason;


create table record(
Record_id varchar(50) not null,
Date_addmitted date ,
Date_discharged date,
primary key(Record_id),
Patient_id varchar(100) not null default 'P004',
constraint fkP_rec foreign key(Patient_id) references patient(Patient_id)  on delete cascade on update cascade);

insert into record(Record_id,Date_addmitted,Date_discharged) values
('R0001','2023-08-23','2023-08-26'),
('R0002',null,null),
('R0003','2023-07-23','2023-07-26'),
('R0004','2023-05-13','2023-05-16'),
('R0005','2023-04-27','2023-04-29'),
('R0006','2023-02-23','2023-02-26');

select * from record;

create table Record_Doctor_relation
(Record_id varchar(20)not null,
Doctor_id varchar(15) not null,
primary key(Record_id,Doctor_id),
constraint fkrec foreign key(Record_id) references record(Record_id) on delete cascade on update cascade,
constraint fk_ReDoc foreign key(Doctor_id) references Doctor(Doctor_id) on delete cascade on update cascade);

INSERT INTO Record_Doctor_relation VALUES
('R0001','D01'),
('R0001','D02'),
('R0002','D03'),
('R0002','D04'),
('R0002','D05'),
('R0003','D05'),
('R0004','D06');

select * from Record_Doctor_relation;

 create table Record_Test_relation
(Rec_id varchar(20)not null,
Test_id varchar(15) not null,
primary key(Rec_id,Test_id),
constraint fk_TRec foreign key(Rec_id) references record(record_id) on delete cascade on update cascade,
constraint fk_RecTest foreign key(Test_id) references Test_report(Test_id) on delete cascade on update cascade);

insert into Record_Test_relation values
('R0001','TR0001'),
('R0001','TR0003'),
('R0002','TR0002'),
('R0003','TR0004'),
('R0003','TR0005'),
('R0003','TR0006');


select * from Record_Test_relation;

create table Record_Med_relation
(Record_id varchar(20)not null,
Med_id varchar(15) not null,
primary key(Record_id,Med_id),
constraint fk_RecM foreign key(Record_id) references record(record_id) on delete cascade on update cascade,
constraint fk_RecMed foreign key(Med_id) references Medicine(Medicine_id) on delete cascade on update cascade);

insert into Record_Med_relation values
('R0001','M0001'),
('R0002','M0002'),
('R0002','M0003'),
('R0002','M0004'),
('R0003','M0005'),
('R0004','M0006'),
('R0005','M0003');

select * from Record_Med_relation;

create table nurse(
	Nurse_id varchar(15) not null,
	First_name varchar(30) not null,
	Last_name varchar(30) not null,
	Date_of_birth date not null default '2000-04-12',
	Gender varchar(1) default 'F',
	primary key(Nurse_id)
);
INSERT INTO nurse (Nurse_id,  First_name, Last_name, Date_of_birth, Gender)
VALUES
    ('N001', 'Mary', 'Johnson', '1985-07-15', 'F'),
    ('N002', 'Robert', 'Anderson', '1990-02-20', 'M'),
    ('N003', 'Jennifer', 'Smith', '1988-11-05', 'F'),
    ('N004', 'William', 'Brown', '1982-09-10', 'M'),
    ('N005', 'Jessica', 'Williams', '1995-06-25', 'F'),
    ('N006', 'Daniel', 'Davis', '1998-03-18','F');
    select * from nurse;

create table Nurse_contact_relation
 (Nurse_id varchar(10) not null,
 Phone_number varchar(10) not null,
 primary key(Nurse_id,Phone_number),
 constraint fkNC foreign key(Nurse_id) references nurse(Nurse_id) on delete cascade on update cascade);
 
insert into Nurse_contact_relation values
 ('N001','0768993412'),
 ('N001','0728393412'),
 ('N002','0724787912'),
 ('N003','0769001412'),
 ('N004','0728972812'),
 ('N005','0765778684'),
 ('N006','0740993412'),
 ('N006','0728123412');
 
 select* from Nurse_contact_relation;
 
 
 create table NursePat_relation
(Nurse_id varchar(20)not null,
Pat_id varchar(15) not null,
primary key(Nurse_id,Pat_id),
constraint fk_PNu foreign key(Nurse_id) references nurse(Nurse_id) on delete cascade on update cascade,
constraint fk_NuPat foreign key(Pat_id) references Patient(patient_id) on delete cascade on update cascade);

insert into NursePat_relation values
('N001','P001'),
('N002','P002'),
('N003','P003'),
('N003','P004'),
('N006','P005'),
('N003','P006'),
('N004','P006'),
('N005','P001');

select * from NursePat_relation;

create table bill
(Bill_number int auto_increment primary key not null,
Ward_charge int ,
Medicine_charge int not null,
Test_charge int,
bill_date date,
patient_id varchar(10) ,
foreign key(patient_id) references patient(patient_id) on delete cascade on update cascade);

insert into bill values
(null,1000,1500,2000,'2023-04-23','P001'),
(null,500,1200,2500,'2023-02-13','P002'),
(null,1000,1500,1000,'2023-04-03','P001'),
(null,1000,2500,1500,'2023-03-15','P003'),
(null,900,1500,2000,'2023-01-30','P003'),
(null,1000,1500,3000,'2023-12-16','P004');

select * from bill;

create table ward
(Ward_number int not null,
Capacity int ,
Availability bool ,
department_id varchar(10) ,
foreign key(department_id) references department(department_id) on delete cascade on update cascade);

INSERT INTO ward VALUES
(1,10, TRUE, 'DE01'),
(1,20, FALSE,'DE02'),
(2,15, TRUE, 'DE03'),
(2,12, TRUE, 'DE01'),
(3,25, TRUE, 'DE02'),
(3,18, TRUE, 'DE03');

select * from ward;

create table ward_staff_relation 
(Ward_number int not null,
Dept_id varchar(10) not null,
Staff_id varchar(50) not null,
primary key(Ward_number,Dept_id,Staff_id),
foreign key(Dept_id) references department(department_id) on delete cascade on update cascade,
foreign key(Staff_id) references Non_medical_staff(Staff_id) on delete cascade on update cascade);

insert into ward_staff_relation values
(1,'DE02','S001'),
(1,'DE02','S002'),
(2,'DE01','S002'),
(2,'DE01','S003'),
(3,'DE02','S004'),
(3,'DE03','S005');

select * from  ward_staff_relation;

create table ward_nurse_relation 
(Ward_number int not null,
Dept_id varchar(10) not null,
Nurse_id varchar(50) not null,
primary key(Ward_number,Dept_id,Nurse_id),
foreign key(Dept_id) references department(department_id) on delete cascade on update cascade,
foreign key(Nurse_id) references nurse(Nurse_id) on delete cascade on update cascade);

insert into ward_nurse_relation values
(1,'DE02','N001'),
(1,'DE02','N002'),
(1,'DE02','N003'),
(2,'DE01','N004'),
(3,'DE02','N006'),
(3,'DE03','N005');

select * from  ward_nurse_relation;

create table ward_patient_relation 
(Ward_number int not null,
Dept_id varchar(10) not null,
Patient_id varchar(50) not null,
primary key(Ward_number,Dept_id,Patient_id),
foreign key(Dept_id) references department(department_id) on delete cascade on update cascade,
foreign key(Patient_id) references patient(Patient_id) on delete cascade on update cascade);

insert into ward_patient_relation values
(1,'DE02','P001'),
(1,'DE02','P002'),
(1,'DE02','P003'),
(2,'DE01','P004'),
(2,'DE01','P006'),
(3,'DE03','P005');

select * from  ward_patient_relation;

Alter table Nurse
add Age int;

update Nurse
set Age =Date_format(from_days(datediff(now(),Date_of_birth)), '%Y')+0;
select * FROM Nurse;

-- Table Definitions:
SHOW CREATE TABLE Doctor;
SHOW CREATE TABLE Doctor_PhoneNumber ;
SHOW CREATE TABLE Medicine  ;
SHOW CREATE TABLE Prescription ;
SHOW CREATE TABLE Pres_Medi_Relation ;
SHOW CREATE TABLE Non_medical_staff ;
SHOW CREATE TABLE Staff_contact_relation ;
SHOW CREATE TABLE Department ;
SHOW CREATE TABLE Department_Staff_Relation  ;
SHOW CREATE TABLE Department_Doc_Relation  ;
SHOW CREATE TABLE Test_report  ;
SHOW CREATE TABLE Patient ;
SHOW CREATE TABLE Patient_Doctor_relation  ;
SHOW CREATE TABLE Patient_Med_relation  ;
SHOW CREATE TABLE Patient_contact_relation ;
SHOW CREATE TABLE Patient_Test_relation  ;
SHOW CREATE TABLE Patient_Prescription_relation ;
SHOW CREATE TABLE Appointment  ;
SHOW CREATE TABLE App_reason   ;
SHOW CREATE TABLE Record  ;
SHOW CREATE TABLE Record_Doctor_relation  ;
SHOW CREATE TABLE Record_Test_relation  ;
SHOW CREATE TABLE Record_Med_relation   ;
SHOW CREATE TABLE Nurse  ;
SHOW CREATE TABLE Nurse_contact_relation  ;
SHOW CREATE TABLE NursePat_relation   ;
SHOW CREATE TABLE Bill   ;
SHOW CREATE TABLE Ward   ;
SHOW CREATE TABLE Ward_staff_relation  ;
SHOW CREATE TABLE Ward_nurse_relation  ;
SHOW CREATE TABLE Ward_patient_relation;

-- Update and Delete Operations:

SELECT * FROM DOCTOR;
UPDATE Doctor SET City = "Kilinochchi" WHERE Doctor_id = "D01";
UPDATE Doctor SET City = "Kadawatha"   WHERE Doctor_id = "D02";
DELETE FROM Doctor WHERE Doctor_id = "D05";
SELECT * FROM DOCTOR;


SELECT * FROM Doctor_PhoneNumber;
UPDATE Doctor_PhoneNumber SET Phone_Number = "0728883412" WHERE Doc_id = "D01" AND Phone_Number = "0728393412";
UPDATE Doctor_PhoneNumber SET Phone_Number = "0729993412" WHERE Doc_id = "D01" AND Phone_Number = "0768993412";
DELETE FROM Doctor_PhoneNumber WHERE Doc_id = "D06" AND Phone_Number = "0728123412";
SELECT * FROM Doctor_PhoneNumber;


SELECT * FROM Medicine ;
UPDATE Medicine SET Price = 450 WHERE Medicine_id = "M0001";
UPDATE Medicine SET Price = 500 WHERE Medicine_id = "M0002";
DELETE FROM Medicine WHERE Medicine_id = "M0006";
SELECT * FROM Medicine ;


SELECT * FROM Prescription ;
UPDATE Prescription SET Dosage = 1 WHERE Prescription_id = "PR001";
UPDATE Prescription SET Dosage = 2 WHERE Prescription_id = "PR002";
DELETE FROM Prescription WHERE Prescription_id = "PR006";
SELECT * FROM Prescription ;


SELECT * FROM Pres_Medi_Relation ;
UPDATE Pres_Medi_Relation SET Med_id = "M0003" WHERE Prescription_id = "PR001" AND Med_id = "M0001";
UPDATE Pres_Medi_Relation SET Med_id = "M0002" WHERE Prescription_id = "PR002" AND Med_id = "M0001";
DELETE FROM Pres_Medi_Relation WHERE Prescription_id = "PR002" AND Med_id = "M0004";
SELECT * FROM Pres_Medi_Relation ;


SELECT * FROM Non_medical_staff ;
UPDATE Non_medical_staff SET Street = "321 Main St" WHERE Staff_id = "S001";
UPDATE Non_medical_staff SET Street = "654 Elm St"  WHERE Staff_id = "S002";
DELETE FROM Non_medical_staff WHERE Staff_id = "S005";
SELECT * FROM Non_medical_staff ;


SELECT * FROM Staff_contact_relation ;
UPDATE Staff_contact_relation SET Phone_number = "0728321412" WHERE Staff_id = "S001" AND Phone_number = "0728393412";
UPDATE Staff_contact_relation SET Phone_number = "0728322412" WHERE Staff_id = "S001" AND Phone_number = "0768993412";
DELETE FROM Staff_contact_relation WHERE Staff_id = "S006" AND Phone_number = "0740993412";
SELECT * FROM Staff_contact_relation ;


SELECT * FROM Department ;
UPDATE Department SET Head_id = "D01" WHERE Department_id = "DE01" ;
UPDATE Department SET Head_id = "D02" WHERE Department_id = "DE02" ;
DELETE FROM Department WHERE Department_id = "DE06" ;
SELECT * FROM Department ;


SELECT * FROM Department_Staff_Relation ;
UPDATE Department_Staff_Relation SET Dep_id   = "DE02" WHERE Dep_id = "DE01" AND Staff_id = "S001";
UPDATE Department_Staff_Relation SET Staff_id = "S002" WHERE Dep_id = "DE04" AND Staff_id = "S001";
DELETE FROM Department_Staff_Relation WHERE Dep_id = "DE02" AND Staff_id = "S004";
SELECT * FROM Department_Staff_Relation ;


SELECT * FROM Department_Doc_Relation ;
UPDATE Department_Doc_Relation SET Dep_id = "DE02" WHERE Dep_id = "DE01" AND Doc_id = "D02";
UPDATE Department_Doc_Relation SET Doc_id = "D02"  WHERE Dep_id = "DE01" AND Doc_id = "D01";
DELETE FROM Department_Doc_Relation WHERE Dep_id = "DE05" AND Doc_id = "D06";
SELECT * FROM Department_Doc_Relation ;


SELECT * FROM Test_report ;
UPDATE Test_report SET Tested_time = "15:30:00" WHERE Test_id = "TR0001" ;
UPDATE Test_report SET Tested_time = "11:30:00" WHERE Test_id = "TR0002" ;
DELETE FROM Test_report WHERE Test_id = "TR0006" ;
SELECT * FROM Test_report ;


SELECT * FROM Patient ;
UPDATE Patient SET Last_name = "Jackson" WHERE Patient_id = "P001" ;
UPDATE Patient SET Last_name = "Clinton" WHERE Patient_id = "P002" ;
DELETE FROM Patient WHERE Patient_id = "P006" ;
SELECT * FROM Patient ;


SELECT * FROM Patient_Doctor_relation  ;
UPDATE Patient_Doctor_relation  SET Doctor_id = "D02" WHERE Patient_id = "P002" AND Doctor_id = "D01";
UPDATE Patient_Doctor_relation  SET Doctor_id = "D02" WHERE Patient_id = "P004" AND Doctor_id = "D01";
DELETE FROM Patient_Doctor_relation  WHERE Patient_id = "P005" AND Doctor_id = "D03";
SELECT * FROM Patient_Doctor_relation  ;


SELECT * FROM Patient_Med_relation ;
UPDATE Patient_Med_relation SET Med_id = "M0003" WHERE Patient_id = "P002" AND Med_id = "M0001";
UPDATE Patient_Med_relation SET Med_id = "M0003" WHERE Patient_id = "P003" AND Med_id = "M0001";
DELETE FROM Patient_Med_relation WHERE Patient_id = "P003" AND Med_id = "M0005";
SELECT * FROM Patient_Med_relation ;


SELECT * FROM Patient_contact_relation  ;
UPDATE Patient_contact_relation  SET Phone_number = "0721393412" WHERE Pat_id = "P001" AND Phone_number = "0728393412";
UPDATE Patient_contact_relation  SET Phone_number = "0722393412" WHERE Pat_id = "P001" AND Phone_number = "0768993412";
DELETE FROM Patient_contact_relation  WHERE Pat_id = "P005" AND Phone_number = "0765778684";
SELECT * FROM Patient_contact_relation  ;


SELECT * FROM Patient_Test_relation ;
UPDATE Patient_Test_relation SET Patient_id = "P003" WHERE Patient_id = "P001" AND Test_id = "TR0003";
UPDATE Patient_Test_relation SET Patient_id = "P004" WHERE Patient_id = "P002" AND Test_id = "TR0004";
DELETE FROM Patient_Test_relation WHERE Patient_id = "P003" AND Test_id = "TR0005";
SELECT * FROM Patient_Test_relation ;


SELECT * FROM Patient_Prescription_relation  ;
UPDATE Patient_Prescription_relation  SET Patient_id = "P002" WHERE Patient_id = "P001" AND Pres_id = "PR002";
UPDATE Patient_Prescription_relation  SET Patient_id = "P003" WHERE Patient_id = "P001" AND Pres_id = "PR003";
DELETE FROM Patient_Prescription_relation  WHERE Patient_id = "P003" AND Pres_id = "PR005";
SELECT * FROM Patient_Prescription_relation  ;


SELECT * FROM Appointment  ;
UPDATE Appointment  SET Appintment_time = "14:00:00" WHERE Appintment_date = "2023-08-20" AND Appintment_time = "17:00:00" AND Patient_id = "P001" ;
UPDATE Appointment  SET Appintment_date = "2023-08-28" WHERE Appintment_date = "2023-08-23" AND Appintment_time = "15:00:00" AND Patient_id = "P001" ;
DELETE FROM Appointment  WHERE Appintment_date = "2023-08-21" AND Appintment_time = "17:00:00" AND Patient_id = "P004" ;
SELECT * FROM Appointment  ;


SELECT * FROM App_reason  ;
UPDATE App_reason  SET Reason = "Back pain" WHERE Appintment_date = "2023-08-21" AND Appintment_time = "15:00:00" AND Patient_id = "P001" ;
UPDATE App_reason  SET Reason = "Neck pain" WHERE Appintment_date = "2023-08-23" AND Appintment_time = "15:00:00" AND Patient_id = "P001" ;
DELETE FROM App_reason  WHERE Appintment_date = "2023-08-21" AND Appintment_time = "17:00:00" AND Patient_id = "P004" ;
SELECT * FROM App_reason  ;


SELECT * FROM Record  ;
UPDATE Record  SET Date_addmitted = "2023-08-22" WHERE Record_id = "R0001" ;
UPDATE Record  SET Date_addmitted = "2023-08-23" WHERE Record_id = "R0002" ;
DELETE FROM Record  WHERE Record_id = "R0006" ;
SELECT * FROM Record  ;


SELECT * FROM Record_Doctor_relation ;
UPDATE Record_Doctor_relation SET Record_id = "R0002" WHERE Record_id = "R0001" AND Doctor_id = "D02";
UPDATE Record_Doctor_relation SET Record_id = "R0003" WHERE Record_id = "R0002" AND Doctor_id = "D03";
DELETE FROM Record_Doctor_relation WHERE Record_id = "R0004" AND Doctor_id = "D06";
SELECT * FROM Record_Doctor_relation ;


SELECT * FROM Record_Test_relation  ;
UPDATE Record_Test_relation  SET Rec_id = "R0003" WHERE Rec_id = "R0001" AND Test_id = "TR0003";
UPDATE Record_Test_relation  SET Rec_id = "R0002" WHERE Rec_id = "R0003" AND Test_id = "TR0004";
DELETE FROM Record_Test_relation  WHERE Rec_id = "R0003" AND Test_id = "TR0005";
SELECT * FROM Record_Test_relation  ;

SELECT * FROM Record_Med_relation  ;
UPDATE Record_Med_relation  SET Record_id = "R0003" WHERE Record_id = "R0002" AND Med_id = "M0003";
UPDATE Record_Med_relation  SET Record_id = "R0001" WHERE Record_id = "R0005" AND Med_id = "M0003";
DELETE FROM Record_Med_relation  WHERE Record_id = "R0003" AND Med_id = "M0005";
SELECT * FROM Record_Med_relation  ;


SELECT * FROM Nurse   ;
UPDATE Nurse SET Last_name = "Jane" WHERE Nurse_id = "N001" ;
UPDATE Nurse SET Last_name = "Carl" WHERE Nurse_id = "N002" ;
DELETE FROM Nurse WHERE Nurse_id = "N006" ;
SELECT * FROM Nurse   ;


SELECT * FROM Nurse_contact_relation  ;
UPDATE Nurse_contact_relation  SET Phone_number = "0778893412" WHERE Nurse_id = "N001" AND Phone_number = "0728393412";
UPDATE Nurse_contact_relation  SET Phone_number = "0778993412" WHERE Nurse_id = "N001" AND Phone_number = "0768993412";
DELETE FROM Nurse_contact_relation  WHERE Nurse_id = "N005" AND Phone_number = "0765778684";
SELECT * FROM Nurse_contact_relation  ;


SELECT * FROM NursePat_relation   ;
UPDATE NursePat_relation   SET Nurse_id = "N002" WHERE Nurse_id = "N005" AND Pat_id = "P001";
UPDATE NursePat_relation   SET Pat_id = "P002" WHERE Nurse_id = "N001" AND Pat_id = "P001";
DELETE FROM NursePat_relation   WHERE Nurse_id = "N003" AND Pat_id = "P004";
SELECT * FROM NursePat_relation   ;


SELECT * FROM Bill  ;
UPDATE Bill  SET Medicine_charge = 2000 WHERE Bill_number = 1 ;
UPDATE Bill  SET Medicine_charge = 1000 WHERE Bill_number = 2 ;
DELETE FROM Bill  WHERE Bill_number = 6  ;
SELECT * FROM Bill  ;


SELECT * FROM Ward   ;
UPDATE Ward   SET Capacity = 15 WHERE Ward_number = 1 AND Department_id = "DE01" ;
UPDATE Ward   SET Capacity = 10 WHERE Ward_number = 2 AND Department_id = "DE01" ;
DELETE FROM Ward   WHERE Ward_number = 3 AND Department_id = "DE02" ;
SELECT * FROM Ward   ;


SELECT * FROM Ward_staff_relation   ;
UPDATE Ward_staff_relation   SET Ward_number = 1 WHERE Ward_number = 2 AND Dept_id = "DE01" AND Staff_id = "S002" ;
UPDATE Ward_staff_relation   SET Ward_number = 2 WHERE Ward_number = 1 AND Dept_id = "DE02" AND Staff_id = "S002" ;
DELETE FROM Ward_staff_relation   WHERE Ward_number = 3 AND Dept_id = "DE02" AND Staff_id = "S004" ;
SELECT * FROM Ward_staff_relation   ;


SELECT * FROM Ward_nurse_relation    ;
UPDATE Ward_nurse_relation    SET Ward_number = 1 WHERE Ward_number = 2 AND Dept_id = "DE01" AND Nurse_id = "N004" ;
UPDATE Ward_nurse_relation    SET Ward_number = 2 WHERE Ward_number = 1 AND Dept_id = "DE02" AND Nurse_id = "N001" ;
DELETE FROM Ward_nurse_relation    WHERE Ward_number = 1 AND Dept_id = "DE02" AND Nurse_id = "N003" ;
SELECT * FROM Ward_nurse_relation    ;


SELECT * FROM Ward_patient_relation  ;
UPDATE Ward_patient_relation  SET Ward_number = 1  WHERE Ward_number = 2 AND Dept_id = "DE01" AND Patient_id = "P004" ;
UPDATE Ward_patient_relation  SET Ward_number = 2  WHERE Ward_number = 1 AND Dept_id = "DE02" AND Patient_id = "P002" ;
DELETE FROM Ward_patient_relation  WHERE Ward_number = 1 AND Dept_id = "DE02" AND Patient_id = "P003" ;
SELECT * FROM Ward_patient_relation  ;



-- Transactions

select * from patient where Gender = 'M';

select First_name, Last_name, Specialization from doctor; 


select * from patient cross join appointment; 

create view UV1 as select patient_id, Last_name from patient;
select * from UV1;

rename table nursepat_relation to Nurse_patient_relation;
show tables;

select * from bill where Test_charge = (select max(Test_charge) from bill);

select * from non_medical_staff
where Job_title like "%Asst";

(select Doctor_id, Last_name as Doctor_name, Province from doctor where Province = 'Western')
union 
(select Doctor_id, Last_name as Doctor_name, Province from doctor where Province = 'Northern');


-- Since INTERSECT keyword is not working in  our version ,we have used this query to intersect two queries.
select * from appointment natural join app_reason 
where reason = 'ill' and current_status ='canceled' ;


-- Since EXCEPT keyword is not working in  our version ,we have used this query to excute the "set difference" operation.
-- Here we are selecting all columns from appointment table except the tubles which are containing the current_status values as 'confirmed', 'completed'.
SELECT *
FROM appointment
WHERE current_status NOT IN ('confirmed', 'completed');

/*
 (select * from appointment) except 
(select * from appointment where current_status ='confirmed'or current_status="completed");
*/


-- Division operation

SELECT p.patient_id, p.First_name,p.Last_name
FROM Patient p
WHERE NOT EXISTS (
    SELECT m.Medincine_name
    FROM Medicine as m
    WHERE NOT EXISTS (
        SELECT 1
        FROM patient_med_relation as m2
        WHERE m2.Patient_id = p.Patient_id
    )
);



-- inner join
create view DP as
(select D.Doctor_id, D.First_name, D.Last_name from doctor as D
inner join prescription as P on D.Doctor_id = P.Doc_id);
select * from DP;


-- natural join
create view Ward_Nurse as
select Ward_number, Availability, Nurse_id, department_id from ward
natural join ward_nurse_relation where Capacity<15;
select * from Ward_Nurse;

-- left outer join
create view D_Pres2 as
select * from prescription as P
left outer join doctor as D
on P.Doc_id = D.Doctor_id where No_of_days<=7;
select * from D_Pres2;

 -- right outer join
create view D_Pres1 as
select * from prescription as P
right outer join doctor as D
on P.Doc_id = D.Doctor_id where No_of_days<=7;
select * from D_Pres1;


-- Full outer join
select * from D_Pres1
union
select * from  D_Pres2;


-- Outer union
SELECT * from  doctor as d
inner join department as de ON d.doctor_id = de.head_id
UNION
SELECT doctor_id,First_name,Last_name,Date_of_birth,Street,City,Province,Specialization,null,null,null from doctor ;



-- Nested Queries
-- Query 1
select Department_id from department where department_name
in(select specialization from doctor);

-- Query 2
select nurse_id, Last_name, Gender from nurse 
where age > All(
select age from nurse where Gender = 'F');

-- Query 3
select patient_id from patient where age
in
(select age from patient where age<40);













