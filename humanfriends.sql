CREATE DATABASE IF NOT EXISTS HumanFriends;
   USE HumanFriends;


CREATE TABLE Commands
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name varchar(30),
    description varchar(255)
);


CREATE TABLE AnimalGroup
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name varchar(30)
);

CREATE TABLE AnimalGenius
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name varchar(30),
    group_id INT,
    FOREIGN KEY (group_id) REFERENCES AnimalGroup (id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE KennelAnimal
(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name varchar(30),
    birthDate DATE,
    genius_id INT,
    FOREIGN KEY (genius_id) REFERENCES AnimalGenius (id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE AnimalCommands
(
    animal_id INT NOT NULL,
    command_id INT NOT NULL,

    PRIMARY KEY (animal_id, command_id),
    FOREIGN KEY (animal_id) REFERENCES KennelAnimal (id)
     ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (command_id) REFERENCES Commands (id)
     ON DELETE CASCADE  ON UPDATE CASCADE
);


 USE HumanFriends;

INSERT INTO commands(name)
VALUES
 ('Принести мячик'),
 ('Дать лапу'),
 ('Галоп!'),
 ('Поклон!'),
 ('Крути колесо!'),
 ('Вперед!'),
 ('Аппорт');

INSERT INTO AnimalGroup (name)
VALUES
 ('Вьючные животные'),
 ('Домашние животные');

INSERT INTO AnimalGenius (name, group_id)
VALUES
 ('Собака', 1),
 ('Собака', 1),
 ('Хомяк', 2),
 ('Кошка', 3),
 ('Лошадь', 4),
 ('Верблюд', 5),
 ('Осел', 6);

INSERT INTO KennelAnimal (name, birthDate, genius_id)
VALUES
 ('Грей', '2019-02-04', 1),
 ('Мухтар_2', '2017-18-01', 2),
 ('Яшка', '2023-05-24', 3),
 ('Бафи', '2020-05-31', 4),
 ('Мустанг', '2008-08-24', 5),
 ('Сахарыч', '2005-10-20', 6),
 ('Моисей', '2001-04-12', 7);

INSERT INTO AnimalCommands (animal_id, command_id)
VALUES
 (1, 2), (2, 7), (3, 5), (4, 1),
 (5, 3), (6, 6), (7, 6);


   USE HumanFriends;
   DELETE FROM KennelAnimal WHERE genius_id = 2;

   CREATE TABLE HorseAndDonkey AS
   SELECT * from KennelAnimal WHERE genius_id = 2
   UNION
   SELECT * from KennelAnimal WHERE genius_id = 3;


   CREATE TABLE YoungAnimals AS
      SELECT id, name, birthDate, 
      datediff(curdate(),birthDate) DIV 31 as age, genius_id 
      from KennelAnimal 
      WHERE date_add(birthDate, INTERVAL 1 YEAR) < curdate() 
	  AND date_add(birthDate, INTERVAL 3 YEAR) > curdate();

   SELECT id, name, birthDate, genius_id FROM HorseDonkey
   UNION
   SELECT id, name, birthDate, genius_id FROM YoungAnimals;