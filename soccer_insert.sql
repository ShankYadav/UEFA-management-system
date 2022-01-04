\c soccer

INSERT into LEAGUE values('Bundesliga','Derbystar','GER',1);
INSERT into LEAGUE values('LaLiga','Santander','ESP',2);
INSERT into LEAGUE values('PremierLeague','Barclays','GRB',4);
INSERT into LEAGUE values('SerieA','TIM','ITA',1);
INSERT into LEAGUE values('Ligue1','UberEats','FRA',1);

INSERT into MANAGER values('Julian','Nagelsmann','GER',6,'RBLeipzig','2021-04-27',0034);
INSERT into MANAGER values('Carlo','Ancelotti','ITA',27,'Everton','2021-06-01',0062);
INSERT into MANAGER values('Ole ','Solskjaer','NOR',16,'Molde','2018-12-19',0048);
INSERT into MANAGER values('Simone','Inzaghi','ITA',11,'Lazio','2021-05-27',0045);
INSERT into MANAGER values('Mauricio','Pochettino','ARG',21,'Tottenham','2021-01-02',0049);

INSERT into LEADERBOARD values(0,0,0,0,0001);

INSERT into TOURNAMENT values('UEFA League','Seville','2021-08-14','2022-05-28','BayernMunich','ManUnited',0001);

INSERT into TEAM values('BayernMunich','FCB','Hainer',1900,'AllianzArena',0034,'UEFA League','Bundesliga');
INSERT into TEAM values('RealMadrid','RMA','Perez',1902,'BernabeuStadium',0062,'UEFA League','LaLiga');
INSERT into TEAM values('ManUnited','MNU','Glazer',1878,'OldTrafford',0048,'UEFA League','PremierLeague');
INSERT into TEAM values('Intermilan','INT','Sunning',1908,'SanSiro',0045,'UEFA League','SerieA');
INSERT into TEAM values('ParisSaintGermn','PSG','Al-Khelaifi',1970,'LeParcDes',0049,'UEFA League','Ligue1');

INSERT into MATCH values(01,'2021-08-14','INT-PSG','PSG','INT','N','UEFA League');
INSERT into MATCH values(11,'2021-10-19','FCB-MNU','NIL','NIL','Y','UEFA League');
INSERT into MATCH values(21,'2021-12-27','MNU-RMA','MNU','RMA','N','UEFA League');
INSERT into MATCH values(31,'2022-02-05','PSG-MNU','MNU','PSG','N','UEFA League');
INSERT into MATCH values(41,'2022-05-28','MNU-FCB','FCB','MNU','N','UEFA League');

INSERT into REFEREE values('Bjorn','Kuipers','NET',0048,'1973-03-28',01);
INSERT into REFEREE values('Roberto','Rosetti','ITA',0054,'1967-08-18',11);
INSERT into REFEREE values('Antonio','Mateu','ESP',0044,'1977-03-12',21);
INSERT into REFEREE values('Anthony','Taylor','GRB',0043,'1978-09-20',31);
INSERT into REFEREE values('Danny','Makkelie','NET',0038,'1983-01-28',41);
INSERT into REFEREE values('Clement','Turpin','FRA',0039,'1982-05-16',41);

INSERT into STADIUM values('LeParcDes',90000,'Paris',01);
INSERT into STADIUM values('AllianzArena',120000,'Germany',11);
INSERT into STADIUM values('BernabeuStadium',95000,'Spain',21);
INSERT into STADIUM values('OldTrafford',100000,'England',31);
INSERT into STADIUM values('SanchezPizjuan',50000,'Spain',41);

INSERT into PLAYER values('Robert','Lewandowski',9,'POL','1988-08-21','CF',319,39,61,'FCB09','BayernMunich');
INSERT into PLAYER values('Thomas','Muller',25,'GER','1995-02-08','AM',132,40,139,'FCB25','BayernMunich');
INSERT into PLAYER values('Joshua','Kimmich',6,'GER','1988-08-21','FB',23,51,48,'FCB06','BayernMunich');
INSERT into PLAYER values('Alphonso','Davies',19,'CAN','2000-12-02','FB',15,32,21,'FCB19','BayernMunich');
INSERT into PLAYER values('Manuel','Neuer',1,'GER','1986-03-27','GK',0,29,0,'FCB01','BayernMunich');

INSERT into PLAYER values('Karim','Benzema',9,'FRA','1987-12-19','CF',244,46,111,'RMA09','RealMadrid');
INSERT into PLAYER values('Toni','Kroos',8,'GER','1990-01-04','AM',41,36,88,'RMA08','RealMadrid');
INSERT into PLAYER values('Dani','Carvajal',2,'ESP','1992-01-11','FB',6,56,31,'RMA02','RealMadrid');
INSERT into PLAYER values('David','Alaba',4,'AUT','1992-06-24','FB',27,49,38,'RMA04','RealMadrid');
INSERT into PLAYER values('Thibaut','Courtois',1,'BEL','1992-05-11','GK',0,12,0,'RMA01','RealMadrid');

INSERT into PLAYER values('Christiano','Ronaldo',7,'POR','1985-02-05','CF',482,49,137,'MNU07','ManUnited');
INSERT into PLAYER values('Paul','Pogba',6,'FRA','1993-03-15','AM',56,43,59,'MNU06','ManUnited');
INSERT into PLAYER values('Luke','Shaw',23,'GRB','1995-07-12','FB',0,12,1,'MNU23','ManUnited');
INSERT into PLAYER values('Raphael','Varane',19,'FRA','1993-04-25','FB',11,33,6,'MNU19','ManUnited');
INSERT into PLAYER values('David','DeGea',1,'ESP','1990-11-07','GK',0,11,0,'MNU01','ManUnited');

INSERT into PLAYER values('Kylian','Mbappe',7,'FRA','1998-12-20','CF',112,33,41,'PSG07','ParisSaintGermn');
INSERT into PLAYER values('Leonel','Messi',30,'ARG','1987-06-24','AM',474,45,193,'PSG30','ParisSaintGermn');
INSERT into PLAYER values('Achraf','Hakimi',2,'MAR','1998-11-04','FB',19,30,24,'PSG02','ParisSaintGermn');
INSERT into PLAYER values('Sergio','Ramos',4,'ESP','1986-03-30','FB',74,112,25,'PSG04','ParisSaintGermn'	);
INSERT into PLAYER values('Gianluigi','Donnaruma',50,'FRA','1999-02-25','GK',0,0,0,'PSG50','ParisSaintGermn');

INSERT into PLAYER values('Alexis','Sanchez',7,'CHI','1988-12-19','CF',133,37,79,'INT07','Intermilan');
INSERT into PLAYER values('Lautaro','Martinez',10,'ARG','1997-08-22','AM',64,11,16,'INT20','Intermilan');
INSERT into PLAYER values('Stefan','DeVrij',6,'NET','1992-02-05','FB',22,45,8,'INT06','Intermilan');
INSERT into PLAYER values('Milan','Skriniar',37,'SVK','1995-02-11','FB',9,42,1,'INT37','Intermilan');
INSERT into PLAYER values('Samir','Handanovic',1,'SVN','1984-07-14','GK',0,5,0,'INT01','Intermilan');

INSERT into Sponsor values('Addidas',1500000);
INSERT into Sponsor values('Audi',1000000);
INSERT into Sponsor values('Allianz',1000000);
INSERT into Sponsored values('BayernMunich','Addidas');
INSERT into Sponsored values('BayernMunich','Audi');
INSERT into Sponsored values('BayernMunich','Allianz');

INSERT into Sponsor values('Chevorlet',1500000);
INSERT into Sponsor values('TeamViewer',2500000);
INSERT into Sponsor values('Kohler',1000000);
INSERT into Sponsored values('ManUnited','Chevorlet');
INSERT into Sponsored values('ManUnited','TeamViewer');
INSERT into Sponsored values('ManUnited','Kohler');

INSERT into Sponsor values('Puma',1500000);
INSERT into Sponsor values('Emirates',3000000);
INSERT into Sponsor values('EAsports',1000000);
INSERT into Sponsored values('RealMadrid','Puma');
INSERT into Sponsored values('RealMadrid','Emirates');
INSERT into Sponsored values('RealMadrid','EAsports');

INSERT into Sponsor values('Nike',1500000);
INSERT into Sponsor values('ALL',2000000);
INSERT into Sponsor values('QNB',1000000);
INSERT into Sponsored values('ParisSaintGermn','Nike');
INSERT into Sponsored values('ParisSaintGermn','ALL');
INSERT into Sponsored values('ParisSaintGermn','QNB');

INSERT into Sponsor values('Firelli',1500000);
INSERT into Sponsor values('Socios.com',1500000);
INSERT into Sponsor values('DigitalBits',1000000);
INSERT into Sponsored values('Intermilan','Firelli');
INSERT into Sponsored values('Intermilan','Socios.com');
INSERT into Sponsored values('Intermilan','DigitalBits');

