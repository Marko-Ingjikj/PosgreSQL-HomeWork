-- Calculate the count of all grades in the system
SELECT COUNT(grade) as grade_count
FROM grade


-- Calculate the count of all grades per Teacher in the system
SELECT teacherId,COUNT(grade) as grade_count
FROM grade
GROUP BY teacherId



-- Calculate the count of all grades per Teacher in the system for first
-- 100 Students (ID < 100)
SELECT teacherId,COUNT(grade) as grade_count
FROM grade
WHERE teacherId < 100
GROUP BY teacherId




-- Find the Maximal Grade, and the Average Grade per Student on all
-- grades in the system
SELECT MAX(grade) as maximal_grade,AVG(grade) as average_grade
FROM grade



-- Calculate the count of all grades per Teacher in the system and filter
-- only grade count greater then 200
SELECT teacherId, COUNT(grade) AS grade_count
FROM grade
GROUP BY teacherId
HAVING COUNT(grade) > 200;



-- Calculate the count of all grades per Teacher in the system for first
-- 100 Students (ID < 100) and filter teachers with more than 50 Grade
-- count
SELECT teacherId, COUNT(grade) AS grade_count
FROM grade
WHERE studentId < 100
GROUP BY teacherId
HAVING COUNT (grade) > 50



-- Find the Grade Count, Maximal Grade, and the Average Grade per
-- Student on all grades in the system. Filter only records where
-- Maximal Grade is equal to Average Grade
SELECT studentId, COUNT(grade) as grade_count,MAX(grade) as maximal_grade,AVG(grade) as average_grade
FROM grade
GROUP BY studentId
HAVING MAX(grade) = AVG(grade)




-- List Student First Name and Last Name next to the other details from
-- previous query
SELECT g.studentId,s.firstName,s.LastName,COUNT(g.grade) as grade_count,MAX(g.grade) as maximal_grade,AVG(g.grade) as average_grade
FROM grade g
JOIN student s ON s.id = g.studentId
GROUP BY g.studentId,s.firstName,s.LastName
HAVING MAX(grade) = AVG(grade)



-- Create new view (vw_StudentGrades) that will List all StudentIds and
-- count of Grades per student
CREATE VIEW vw_StudentGrades AS
SELECT studentId ,COUNT(grade) as grade_count
FROM grade
GROUP BY studentId

SELECT * FROM vw_StudentGrades




-- Change the view to show Student First and Last Names instead of
-- StudentID
CREATE OR REPLACE VIEW vw_StudentGrades AS
SELECT s.firstName AS first_name,s.lastName AS last_name ,COUNT(g.grade) as grade_count
FROM grade g
JOIN student s ON s.id = g.studentId
GROUP BY s.firstName,s.lastName

SELECT * FROM vw_StudentGrades


-- List all rows from view ordered by biggest Grade Count
SELECT * FROM vw_StudentGrades
ORDER BY grade_count



-- Create new view (vw_StudentGradeDetails) that will List all Students
-- (FirstName and LastName) and Count the courses he passed through
-- the exam
CREATE VIEW vw_StudentGradeDetails AS
SELECT s.firstName,s.lastName,COUNT(g.courseId) as courses_passed
FROM grade g
JOIN student s ON s.id = g.studentId
GROUP BY s.firstName,s.lastName
