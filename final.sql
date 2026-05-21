CREATE DATABASE IF NOT EXISTS Manager_Football;

USE Manager_Football;

CREATE TABLE Teams (
	team_id INT PRIMARY KEY AUTO_INCREMENT,
    team_name VARCHAR(100) NOT NULL,
    founded_year INT NOT NULL,
    CONSTRAINT chk_founded_year CHECK(founded_year < 2026),
    
    stadium VARCHAR(100) NOT NULL,
    ranking_position INT DEFAULT 0
);

CREATE TABLE Coaches (
	coach_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50) NOT NULL,
    experience_years INT DEFAULT 0,
    team_id INT,
    
    CONSTRAINT fk_teams_coaches FOREIGN KEY (team_id) REFERENCES Teams(team_id)
    
);

CREATE TABLE Players (
	player_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    jersey_number INT NOT NULL,
    `position` VARCHAR(50) NOT NULL,
    salary DECIMAL(12, 2) NOT NULL,
    team_id INT,
    
    CONSTRAINT fk_teams_players FOREIGN KEY (team_id) REFERENCES Teams(team_id)
    
);

CREATE TABLE Matches (
	match_id INT PRIMARY KEY AUTO_INCREMENT,
    home_team_id INT,
    away_team_id INT,
    match_date DATETIME NOT NULL,
    stadium VARCHAR(100) NOT NULL,
    match_status VARCHAR(30) DEFAULT 'Scheduled',
    
    CONSTRAINT fk_teams_matches FOREIGN KEY (home_team_id) REFERENCES Teams(team_id),
    CONSTRAINT fk_teams_matche FOREIGN KEY (away_team_id) REFERENCES Teams(team_id)

);

CREATE TABLE Player_statistics (
	stat_id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT,
    match_id INT,
    goals INT DEFAULT 0,
    assists INT DEFAULT 0,
    yellow_cards INT DEFAULT 0,
    rating_score DECIMAL(3, 1) DEFAULT 0,
    
	CONSTRAINT fk_player_sta_Players FOREIGN KEY (player_id) REFERENCES Players(player_id),
	CONSTRAINT fk_player_sta_matches FOREIGN KEY (match_id) REFERENCES Matches(match_id)

);

-- INSERT VALUES
INSERT INTO Teams(team_id, team_name, founded_year, stadium, ranking_position)
VALUE 
	(1, 'Manchester City', '1880', 'Etihad Stadium', 1),
    (2, 'Real Madrid', '1920', 'Santiago Bemabeu', 2),
    (3, 'Hanoi FC', '2006', 'Hang Day Stadium', 3),
    (4, 'Saigon United', '2015', 'Thong Nhat Stadium', 5),
    (5, 'Thep xanh Nam Dinh', '1979', 'Thien Truong Stadium', 10);
    
INSERT INTO Coaches(coach_id, full_name, nationality, experience_years, team_id)
VALUE
	( 1, 'Pep Guardiola', 'Spanish', 15, 1),
    ( 2, 'Carlo Ancelotti', 'Italian', 25, 2),
    ( 3, 'Chu Dinh Nghiem', 'Vietnamese', 12, 3),
    ( 4, 'Alexandre Polking', 'German-Brazilian', 10, 4),
    ( 5, 'Park Hang-seo', 'Korean', 30, 5);
    
INSERT INTO Players(player_id, full_name, jersey_number, `position`, salary, team_id)
VALUE 
	( 1, 'Erling Haaland', 9, 'Forward', 450000000,1),
    ( 2, 'Kevin De Brruyne', 17, 'Midfielder', 400000000, 1),
    ( 3, 'Nguyen Quang Hai', 19, 'Midfielder', 60000000, 3),
    ( 4, 'Kylian Mbappe', 7, 'Forward', 500000000, 2),
    ( 5, 'Nguyen Van Quyet', 10, 'Forward', 55000000, 3);
    
INSERT INTO Matches(match_id, home_team_id, away_team_id, match_date, stadium, match_status)
VALUE 
	( 1, 1, 2, '2026-05-10 19:00', 'Etihad Stadium', 'Finished'),
    ( 2, 3, 4, '2026-05-12 18:30', 'Hang Day Stadium', 'Finished'),
    ( 3, 5, 1, '2026-05-15 20:00', 'Thien Truong Stadium', 'Schedulel'),
    ( 4, 2, 3, '2026-05-20 21:00', 'Santiago Bemabeu', 'Schedulel'),
    ( 5, 4, 5, '2026-05-25 17:00', 'Thong Nhat Stadium', 'Schedulel');
    
INSERT INTO Player_statistics(stat_id, player_id, match_id, goals, assists, yellow_cards, rating_score)
VALUE 
	( 1, 1, 1, 10, 1, 0, 9.5),
    ( 2, 4, 1, 5, 0, 1, 8.2),
    ( 3, 3, 2, 6, 2, 0, 8.5),
    ( 4, 5, 2, 7, 0, 0, 9.0),
    ( 5, 1, 4, 6, 0, 3, 5.0);
    
-- Cau 2:
UPDATE Players
SET salary = salary * 1.15
WHERE `positon` = 'Forward';



-- PHAN 3:

-- CAU 1: 
SELECT full_name, jersey_number, `position`
FROM Players
WHERE salary > 50000000 OR `position` = 'Midfielder';

-- CAU 2:
SELECT team_name, stadium
FROM Teams
WHERE (ranking_position BETWEEN 1 AND 5) AND team_name LIKE 'S%';

-- Cau 3:
SELECT match_id, stadium, match_date
FROM Matches
ORDER BY match_date 
LIMIT 3 OFFSET 3;

-- PHAN 4:

-- CAU 1:
SELECT full_name , team_name , goals , assists 
FROM Player_statistics s
INNER JOIN Players p 
ON s.player_id = p.player_id
INNER JOIN Teams t
ON p.team_id = t.team_id;

-- CAU 2:
SELECT team_name, SUM(goals) AS TOTAL_GOAL
FROM Player_statistics s
INNER JOIN Players p 
ON s.player_id = p.player_id
INNER JOIN Teams t
ON p.team_id = t.team_id
GROUP BY team_name
HAVING SUM(goals) > 10;

-- CAU 3:
SELECT player_id, full_name, salary
FROM Players 
ORDER BY salary DESC;

-- PHAN 5:
-- CAU 2:
CREATE VIEW total AS
SELECT team_name, COUNT(player_id) AS sum_player, SUM(salary) AS sum_salary
FROM Players p
INNER JOIN Teams t 
ON p.team_id = t.team_id
GROUP BY team_name;

