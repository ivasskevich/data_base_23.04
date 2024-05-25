use Academy2

SELECT DISTINCT lr.[Name]
FROM [Lectures] l
JOIN [Teachers] t ON l.[TeacherId] = t.[Id]
JOIN [Schedules] s ON l.[Id] = s.[LectureId]
JOIN [LectureRooms] lr ON s.[LectureRoomId] = lr.[Id]
WHERE t.[Name] = 'Edward' AND t.[Surname] = 'Hopper';


SELECT DISTINCT t.[Surname]
FROM [Assistants] a
JOIN [Lectures] l ON a.[TeacherId] = l.[TeacherId]
JOIN [GroupsLectures] gl ON l.[Id] = gl.[LectureId]
JOIN [Groups] g ON gl.[GroupId] = g.[Id]
JOIN [Teachers] t ON a.[TeacherId] = t.[Id]
WHERE g.[Name] = 'F505';


SELECT DISTINCT sub.[Name]
FROM [Lectures] l
JOIN [Teachers] t ON l.[TeacherId] = t.[Id]
JOIN [Subjects] sub ON l.[SubjectId] = sub.[Id]
JOIN [GroupsLectures] gl ON l.[Id] = gl.[LectureId]
JOIN [Groups] g ON gl.[GroupId] = g.[Id]
WHERE t.[Name] = 'Alex' AND t.[Surname] = 'Carmack' AND g.[Year] = 5;



SELECT DISTINCT t.[Surname]
FROM [Teachers] t
LEFT JOIN [Lectures] l ON t.[Id] = l.[TeacherId]
LEFT JOIN [Schedules] s ON l.[Id] = s.[LectureId]
WHERE s.[DayOfWeek] IS NULL OR s.[DayOfWeek] != 1;



SELECT lr.[Name], lr.[Building]
FROM [LectureRooms] lr
LEFT JOIN [Schedules] s ON lr.[Id] = s.[LectureRoomId]
WHERE s.[DayOfWeek] != 3 OR s.[Week] != 2 OR s.[Class] != 3;


SELECT DISTINCT t.[Name], t.[Surname]
FROM [Teachers] t
JOIN [Faculties] f ON f.[DeanId] = t.[Id]
JOIN [Departments] d ON f.[Id] = d.[FacultyId]
LEFT JOIN [GroupsCurators] gc ON gc.[CuratorId] = t.[Id]
LEFT JOIN [Groups] g ON gc.[GroupId] = g.[Id]
WHERE f.[Name] = 'Computer Science'
    AND (g.[DepartmentId] IS NULL OR g.[DepartmentId] NOT IN (
        SELECT d2.[Id]
        FROM [Departments] d2
        WHERE d2.[Name] = 'Software Development'
    ));


SELECT DISTINCT [Building]
FROM [Faculties]
UNION
SELECT DISTINCT [Building]
FROM [Departments]
UNION
SELECT DISTINCT [Building]
FROM [LectureRooms];


SELECT t.[Name], t.[Surname], 'Dean' AS [Role]
FROM [Deans] d
JOIN [Teachers] t ON d.[TeacherId] = t.[Id]
UNION
SELECT t.[Name], t.[Surname], 'Head' AS [Role]
FROM [Heads] h
JOIN [Teachers] t ON h.[TeacherId] = t.[Id]
UNION
SELECT t.[Name], t.[Surname], 'Teacher' AS [Role]
FROM [Teachers] t
WHERE t.[Id] NOT IN (
    SELECT DISTINCT [TeacherId] FROM [Deans]
    UNION
    SELECT DISTINCT [TeacherId] FROM [Heads]
    UNION
    SELECT DISTINCT [TeacherId] FROM [Curators]
    UNION
    SELECT DISTINCT [TeacherId] FROM [Assistants]
)
UNION
SELECT t.[Name], t.[Surname], 'Curator' AS [Role]
FROM [Curators] c
JOIN [Teachers] t ON c.[TeacherId] = t.[Id]
UNION
SELECT t.[Name], t.[Surname], 'Assistant' AS [Role]
FROM [Assistants] a
JOIN [Teachers] t ON a.[TeacherId] = t.[Id];

SELECT DISTINCT s.[DayOfWeek]
FROM [Schedules] s
JOIN [LectureRooms] lr ON s.[LectureRoomId] = lr.[Id]
WHERE lr.[Name] IN ('A311', 'A104') AND lr.[Building] = 6;