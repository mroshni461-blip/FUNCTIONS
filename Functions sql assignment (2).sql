CREATE DATABASE Student_Performance ;
USE Student_Performance;



CREATE TABLE Student_Performance (
    student_id INT PRIMARY KEY,
    name VARCHAR(50) ,
    course VARCHAR(30),
    score INT,
    attendance INT,
    mentor VARCHAR(50),
    join_date DATE,
    city VARCHAR(50)
);


INSERT INTO Student_Performance
(student_id, name, course, score, attendance, mentor, join_date, city)
VALUES
(101, 'Aarav Mehta', 'Data Science', 88, 92, 'Dr. Sharma', '2023-06-12', 'Mumbai'),
(102, 'Riya Singh', 'Data Science', 76, 85, 'Dr. Sharma', '2023-07-01', 'Delhi'),
(103, 'Kabir Khanna', 'Python', 91, 96, 'Ms. Nair', '2023-06-20', 'Mumbai'),
(104, 'Tanvi Patel', 'SQL', 84, 89, 'Mr. Iyer', '2023-05-30', 'Bengaluru'),
(105, 'Ayesha Khan', 'Python', 67, 81, 'Ms. Nair', '2023-07-10', 'Hyderabad'),
(106, 'Dev Sharma', 'SQL', 73, 78, 'Mr. Iyer', '2023-05-28', 'Pune'),
(107, 'Arjun Verma', 'Tableau', 95, 98, 'Ms. Kapoor', '2023-06-15', 'Delhi'),
(108, 'Meera Pillai', 'Tableau', 82, 87, 'Ms. Kapoor', '2023-06-18', 'Kochi'),
(109, 'Nikhil Rao', 'Data Science', 79, 82, 'Dr. Sharma', '2023-07-05', 'Chennai'),
(110, 'Priya Desai', 'SQL', 92, 94, 'Mr. Iyer', '2023-05-27', 'Bengaluru'),
(111, 'Siddharth Jain', 'Python', 85, 90, 'Ms. Nair', '2023-07-02', 'Mumbai'),
(112, 'Sneha Kulkarni', 'Tableau', 74, 83, 'Ms. Kapoor', '2023-06-10', 'Pune'),
(113, 'Rohan Gupta', 'SQL', 89, 91, 'Mr. Iyer', '2023-05-25', 'Delhi'),
(114, 'Ishita Joshi', 'Data Science', 93, 97, 'Dr. Sharma', '2023-06-25', 'Bengaluru'),
(115, 'Yuvraj Rao', 'Python', 71, 84, 'Ms. Nair', '2023-07-12', 'Hyderabad');



Question 1 : Create a ranking of students based on score (highest first).

SELECT STUDENT_ID, NAME,
RANK() OVER(ORDER BY SCORE DESC)  AS SCORE_RNK
FROM STUDENT_PERFORMANCE;

Question 2 : Show each students score and the previous student’s score (based on score order).

SELECT STUDENT_ID, NAME,
LAG(SCORE, 1) OVER( ORDER BY SCORE DESC) AS PREV_STUDENT_SCORE
FROM STUDENT_PERFORMANCE;

Question 3 : Convert all student names to uppercase and extract the month name from join_date.

SELECT STUDENT_ID, NAME,
upper(name) as name_upper,
monthname(join_date) as join_month
from student_performance;

Question 4 : Show each student's name and the next student’s attendance (ordered by attendance).

select student_id,name,  
lead(attendance,1) over( order by attendance desc) as next_student_attendance
from student_performance;


Question 5 : Assign students into 4 performance groups using NTILE().

select student_id,name, score, 
ntile(4) over(order by score desc) as performance_group
from student_performance;


Question 6 : For each course, assign a row number based on attendance (highest first).

select student_id,name, course, attendance, 
row_number() over(partition by course order by attendance desc)as highest_first_attendance
from student_performance;


Question 7 : Calculate the number of days each student has been enrolled (from join_date to today).
(Assume current date = '2025-01-01')

select student_id,name, join_date,
datediff(2025-01-01, join_date) as enrolled_days
from student_performance ;


Question 8 : Format join_date as “Month Year” (e.g., “June 2023”).

select student_id,name, 
date_format(join_date,'%M %Y') as formatted_join_date
from student_performance  ;


Question 9 : Replace the city ‘Mumbai’ with ‘MUM’ for display purposes.

select student_id,name, 
REPLACE(city, 'Mumbai', 'MUM') AS city_name
FROM student_performance;


Question 10 : For each course, find the highest score using FIRST_VALUE().

select student_id,name, course, score, attendance,
first_value(score) over(partition by course  order by score desc) as highest_score
from student_performance ;

