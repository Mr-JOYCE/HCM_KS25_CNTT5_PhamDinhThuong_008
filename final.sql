CREATE DATABASE IF NOT EXISTS Manager_Football;
drop database manager_football;
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
	( 1, '', 9, '',1),
    ( 2, '', 17, '', , 1),
    ( 3, '', 19, '', , 3),
    ( 4, '', 7, '', , 2),
    ( 5, '', 10, '', , 3);

