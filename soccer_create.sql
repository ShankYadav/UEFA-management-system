drop database soccer;
create database soccer;

\c soccer

CREATE TABLE 	League
(
  Name VARCHAR(15) NOT NULL,
  Sponsor VARCHAR(15) NOT NULL,
  Country VARCHAR(3) NOT NULL,
  Position INT NOT NULL,
  PRIMARY KEY (Name)
);

CREATE TABLE 	Manager
(
  First_name VARCHAR(15) NOT NULL,
  Last_name VARCHAR(15) NOT NULL,
  Nationality VARCHAR(3) NOT NULL,
  Experience INT NOT NULL,
  Previous_club VARCHAR(15) NOT NULL,
  Start_date DATE NOT NULL,
  Employee_id INT NOT NULL,
  PRIMARY KEY (Employee_id)
);

CREATE TABLE 	Leaderboard
(
  Goals INT NOT NULL,
  Assists INT NOT NULL,
  Yellow_card INT NOT NULL,
  Red_card INT NOT NULL,
  Leaderboard_id INT NOT NULL,
  PRIMARY KEY (Leaderboard_id)
);

CREATE TABLE 	Sponsor
(
  Sponsor_name VARCHAR(15) NOT NULL,
  Sponsored_amount INT NOT NULL,
  PRIMARY KEY (Sponsor_name)
);

CREATE TABLE 	Tournament
(
  Name VARCHAR(15) NOT NULL,
  Host_City VARCHAR(15) NOT NULL,
  Start_date DATE NOT NULL,
  End_date DATE NOT NULL,
  Winner VARCHAR(15) NOT NULL,
  Runner VARCHAR(15) NOT NULL,
  Leaderboard_id INT NOT NULL,
  PRIMARY KEY (Name),
  FOREIGN KEY (Leaderboard_id) REFERENCES Leaderboard(Leaderboard_id)
);

CREATE TABLE 	Match
(
  Match_number INT NOT NULL,
  Date DATE NOT NULL,
  Played_between VARCHAR(7) NOT NULL,
  Winner VARCHAR(3) NOT NULL,
  Loser VARCHAR(3) NOT NULL,
  Draw CHAR,
  Name VARCHAR(15) NOT NULL,
  PRIMARY KEY (Match_number),
  FOREIGN KEY (Name) REFERENCES Tournament(Name)
);

CREATE TABLE 	Referee
(
  First_name VARCHAR(15) NOT NULL,
  Last_name VARCHAR(15) NOT NULL,
  Nationality VARCHAR(3) NOT NULL,
  License_id INT NOT NULL,
  Date_of_birth DATE NOT NULL,
  Match_number INT NOT NULL,
  PRIMARY KEY (License_id),
  FOREIGN KEY (Match_number) REFERENCES Match(Match_number)
);

CREATE TABLE 	Team
(
  Name VARCHAR(15) NOT NULL,
  Logo VARCHAR(3) NOT NULL,
  Owned_by VARCHAR(15) NOT NULL,
  Year_founded INT NOT NULL,
  Home_Stadium VARCHAR(15) NOT NULL,
  Employee_id INT NOT NULL,
  Tname VARCHAR(15) NOT NULL,
  Lname VARCHAR(15) NOT NULL,
  PRIMARY KEY (Name),
  FOREIGN KEY (Tname) REFERENCES Tournament(Name),
  FOREIGN KEY (Lname) REFERENCES League(Name),
  FOREIGN KEY (Employee_id) REFERENCES Manager(Employee_id)
);

CREATE TABLE 	Player
(
  First_name VARCHAR(15) NOT NULL,
  Last_name VARCHAR(15) NOT NULL,
  Jersey_number INT NOT NULL,
  Nationality VARCHAR(3) NOT NULL,
  Date_of_birth DATE NOT NULL,
  Position VARCHAR(2) NOT NULL,
  Goals INT NOT NULL,
  Cards INT NOT NULL,
  Assists INT NOT NULL,
  Player_id VARCHAR(5) NOT NULL,
  Name VARCHAR(15) NOT NULL,
  PRIMARY KEY (Player_id),
  FOREIGN KEY (Name) REFERENCES Team(Name)
);

CREATE TABLE 	Stadium
(
  Stadium_name VARCHAR(15) NOT NULL,
  Capacity INT NOT NULL,
  Location VARCHAR(15) NOT NULL,
  Match_number INT NOT NULL,
  PRIMARY KEY (Stadium_name),
  FOREIGN KEY (Match_number) REFERENCES Match(Match_number)
);

CREATE TABLE 	Sponsored
(
  Name VARCHAR(15) NOT NULL,
  Sponsor_name VARCHAR(15) NOT NULL,
  PRIMARY KEY (Name, Sponsor_name),
  FOREIGN KEY (Name) REFERENCES Team(Name),
  FOREIGN KEY (Sponsor_name) REFERENCES Sponsor(Sponsor_name)
);

