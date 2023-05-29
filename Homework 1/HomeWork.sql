CREATE TABLE IF NOT EXISTS Teacher (
	id serial PRIMARY KEY NOT NULL,
	FirstName varchar(20) NOT NULL,
	LastName varchar(30) NOT NULL,
	DateOfBirth date NOT NULL,
	AcademicRank varchar(20) NOT NULL,
	HireDate date NOT NULL
)

INSERT INTO Teacher(FirstName,LastName,DateOfBirth,AcademicRank,HireDate)
VALUES ('Ivo','Kostovski','1995-01-01','Senior','2019-01-01')

SELECT * FROM Teacher

-- 
-- 
-- 

CREATE TABLE IF NOT EXISTS Student (
	id serial PRIMARY KEY NOT NULL,
	FirstName varchar(20) NOT NULL,
	LastName varchar(30) NOT NULL,
	DateOfBirth date NOT NULL,
	EnrolledDate date NOT NULL,
	Gender nchar(1) NOT NULL,
	NationalIDNumber varchar(20) NOT NULL,
	StudentCardNumber varchar(20) NOT NULL
)

INSERT INTO Student(FirstName,LastName,DateOfBirth,EnrolledDate,Gender,NationalIDNumber,StudentCardNumber)
VALUES ('Marko','Ingjikj','2003-06-12','2022-10-28','M','123','123')

SELECT * FROM Student

-- 
-- 
-- 

Create TABLE IF NOT EXISTS Course (
	id serial PRIMARY KEY NOT NULL,
	Name varchar(50) NOT NULL,
	Credit integer NOT NULL,
	AcademicYear smallint NOT NULL,
	Semester smallint NOT NULL
)

INSERT INTO Course(Name,Credit,AcademicYear,Semester)
VALUES('Academy for programming',10,1,2)

SELECT * FROM Course

-- 
-- 
-- 

Create TABLE IF NOT EXISTS Grade (
	id serial PRIMARY KEY NOT NULL,
	StudentId integer REFERENCES Student(id) NOT NULL,
	CourseId integer REFERENCES Course(id) NOT NULL,
	TeacherId integer REFERENCES Teacher(id) NOT NULL,
	Grade smallint CHECK(Grade <= 5) NOT NULL,
	Comment varchar(100) NOT NULL,
	CreatedDate date NOT NULL
)

INSERT INTO Grade(StudentId,CourseId,TeacherId,Grade,Comment,CreatedDate)
VALUES(1,1,1,5,'Excellent','2023-05-21')

SELECT * FROM Grade

SELECT * FROM Student s
INNER JOIN Grade g
ON s.id = g.StudentId

SELECT * FROM Teacher t
INNER JOIN Grade g
ON t.id = g.TeacherId

SELECT * FROM Course c
INNER JOIN Grade g
ON c.id = g.CourseId

-- 
-- 
-- 

CREATE TABLE IF NOT EXISTS AchievementType (
	id serial PRIMARY KEY NOT NULL,
	Name varchar(20) NOT NULL,
	Description varchar(50) NOT NULL,
	ParticipationRate varchar(10) NOT NULL
)

INSERT INTO AchievementType(Name,Description,ParticipationRate)
VALUES ('Achievement','Good','100%')

SELECT * FROM AchievementType

-- 
-- 
-- 

CREATE TABLE IF NOT EXISTS GradeDetails (
	id serial PRIMARY KEY NOT NULL,
	GradeID integer REFERENCES Grade (id) NOT NULL,
	AchievementTypeID integer REFERENCES AchievementType (id) NOT NULL,
	AchievementPoints integer NOT NULL,
	AchievementMaxPoints integer NOT NULL,
	AchievementDate date NOT NULL
)

INSERT INTO GradeDetails(GradeID,AchievementTypeID,AchievementPoints,AchievementMaxPoints,AchievementDate)
VALUES (1,1,100,100,'2023-05-21')

SELECT * FROM GradeDetails

SELECT * FROM Grade g
INNER JOIN GradeDetails d
ON g.id = d.GradeID

SELECT * FROM AchievementType a
INNER JOIN GradeDetails d
ON a.id = d.AchievementTypeID

