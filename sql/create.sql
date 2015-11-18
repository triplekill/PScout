SET FOREIGN_KEY_CHECKS=0; 
DROP Table IF EXISTS Classes;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE Classes
(
ID int auto_increment PRIMARY KEY,
ClassName varchar(255) NOT NULL,
Version varchar(15) NOT NULL,
Access varchar(63),
SuperClass varchar(255),
Signature text,
Interfaces text,
IsAbstract bit,
IsInterface bit,
IsEnum bit
);

CREATE UNIQUE INDEX IDX_Classes_ClassName_Version
ON Classes (ClassName, Version);

CREATE INDEX IDX_Classes_ClassName
ON Classes (ClassName);

CREATE INDEX IDX_Classes_Version
ON Classes (Version);

CREATE INDEX IDX_Classes_SuperClass
ON Classes (SuperClass);

CREATE INDEX IDX_Classes_Signature
ON Classes (Signature(255));

CREATE INDEX IDX_Classes_Interfaces
ON Classes (Interfaces(255));

CREATE INDEX IDX_Classes_IsInterface
ON Classes (IsInterface);





SET FOREIGN_KEY_CHECKS=0; 
DROP TABLE IF EXISTS Methods;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE Methods
(
ID int auto_increment PRIMARY KEY,
ClassId int NOT NULL,
MethodName varchar(127) NOT NULL,
Version varchar(15) NOT NULL,
Access varchar(63),
Signature text,
Descriptor text NOT NULL,
Exceptions text,
IsAbstract bit,
IsNative bit,
FOREIGN KEY (ClassId) REFERENCES Classes(ID) ON DELETE CASCADE
);

CREATE INDEX IDX_Methods_MethodName
ON Methods (MethodName);

CREATE INDEX IDX_Methods_Version
ON Methods (Version);

CREATE INDEX IDX_Methods_Signature
ON Methods (Signature(255));

CREATE INDEX IDX_Methods_Exceptions
ON Methods (Exceptions(255));

CREATE INDEX IDX_Methods_Descriptor
ON Methods (Descriptor(255));

CREATE INDEX IDX_METHODS_IsAbstract
ON Methods (IsAbstract);

CREATE INDEX IDX_Methods_IsNative
ON Methods (IsNative);






SET FOREIGN_KEY_CHECKS=0; 
DROP TABLE IF EXISTS Invocations;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE Invocations
(
ID int auto_increment PRIMARY KEY,
InvokeType varchar(15) NOT NULL,
CallerClass varchar(255) NOT NULL,
CallerMethod varchar(127) NOT NULL,
CallerMethodDesc text NOT NULL,
TargetClass varchar(255) NOT NULL,
TargetMethod varchar(127) NOT NULL,
TargetMethodDesc text NOT NULL,
Version varchar(15) NOT NULL
);

CREATE INDEX IDX_Invocations_Version
ON Invocations (Version);

CREATE INDEX IDX_Invocations_InvokeType
ON Invocations (InvokeType);

CREATE INDEX IDX_Invocations_CallerClass
ON Invocations (CallerClass);

CREATE INDEX IDX_Invocations_TargetClass
ON Invocations (TargetClass);

CREATE INDEX IDX_Invocations_CallerMethod
ON Invocations (CallerMethod);

CREATE INDEX IDX_Invocations_TargetMethod
ON Invocations (TargetMethod);

CREATE INDEX IDX_Invocations_CallerMethodDesc
ON Invocations (TargetMethodDesc(255));

CREATE INDEX IDX_Invocations_TargetMethodDesc
ON Invocations (CallerMethodDesc(255));







SET FOREIGN_KEY_CHECKS=0; 
DROP TABLE IF EXISTS Permissions;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE Permissions
(
	ID int auto_increment PRIMARY KEY,
	Permission varchar(255) NOT NULL,
	Version varchar(15) NOT NULL
);


DROP VIEW IF EXISTS vwMethods;

CREATE VIEW vwMethods AS
SELECT c.ID as ClassID, m.ID as MethodID, c.ClassName as ClassName, m.MethodName, m.Version, m.Access, m.Signature, m.Descriptor, m.Exceptions, m.IsAbstract, m.IsNative
FROM Methods m, Classes c
WHERE c.ID = m.ClassId