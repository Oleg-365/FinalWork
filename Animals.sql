/*7. В подключенном MySQL репозитории создать базу данных “Друзья человека”*/

CREATE DATABASE human_friends;

USE human_friends;

/*8. Создать таблицы с иерархией из диаграммы в БД*/

CREATE TABLE animals
(
	id INT AUTO_INCREMENT PRIMARY KEY,
	animal_type VARCHAR(30)
);

INSERT INTO animals (animal_type)
VALUES ('Домашние животные'), ('Вьючные животные');

CREATE TABLE pets
(
	id INT AUTO_INCREMENT PRIMARY KEY,
	animal_kind VARCHAR(30),
	animal_type_id INT DEFAULT 1,
	FOREIGN KEY (animal_type_id) REFERENCES animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO pets (animal_kind)
VALUES ('Собаки'), ('Кошки'), ('Хомяки');

CREATE TABLE pack_animals
(
	id INT AUTO_INCREMENT PRIMARY KEY,
	animal_kind VARCHAR(30),
	animal_type_id INT DEFAULT 2,
	FOREIGN KEY (animal_type_id) REFERENCES animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO pack_animals (animal_kind)
VALUES ('Лошади'), ('Верблюды'), ('Ослы');

/* 9. Заполнить низкоуровневые таблицы именами(животных), командами
      которые они выполняют и датами рождения.*/

CREATE TABLE dogs 
(       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(30), 
    commands VARCHAR(100),
    birthday DATE,
    animal_kind_id INT DEFAULT 1,
    Foreign KEY (animal_kind_id) REFERENCES pets (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO dogs (name, commands, birthday)
VALUES ('Мухтар', 'лежать, сидеть', '2022-04-21'),
('Снежка', 'дай лапу, голос', '2023-08-08'),
('Цезарь', 'место, фас', '2021-04-17');

CREATE TABLE cats 
(       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(30), 
    commands VARCHAR(100),
    birthday DATE,
    animal_kind_id INT DEFAULT 2,
    Foreign KEY (animal_kind_id) REFERENCES pets (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO cats (name, commands, birthday)
VALUES ('Барсик', 'стоять', '2022-01-10'),
('Кузя', 'дай лапу', '2020-09-11'),
('Бусинка', 'ко мне', '2021-02-15');

CREATE TABLE hamsters 
(       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(30), 
    commands VARCHAR(100),
    birthday DATE,
    animal_kind_id INT DEFAULT 3,
    Foreign KEY (animal_kind_id) REFERENCES pets (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO hamsters (name, commands, birthday)
VALUES ('Жоржик', 'кушать', '2021-11-28'),
('Баззи', 'гулять', '2022-04-13'),
('Сашка', 'стоять', '2021-12-27');

CREATE TABLE horses 
(       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(30), 
    commands VARCHAR(100),
    birthday DATE,
    animal_kind_id INT DEFAULT 1,
    Foreign KEY (animal_kind_id) REFERENCES pack_animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO horses (name, commands, birthday)
VALUES ('Атлантида', 'хоп, тише, вперед', '2020-07-14'),
('Император', 'стой, шагом, рысь', '2018-06-16'),
('Сержант', 'шагом, стой, хоп', '2019-01-29');

CREATE TABLE camels 
(       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(30), 
    commands VARCHAR(100),
    birthday DATE,
    animal_kind_id INT DEFAULT 2,
    Foreign KEY (animal_kind_id) REFERENCES pack_animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO camels (name, commands, birthday)
VALUES ('Вася', 'гит, дурр', '2021-08-10'),
('Агата', 'дурр', '2023-11-07'),
('Джаред', 'гит, каш', '2023-09-21');

CREATE TABLE donkeys 
(       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(30), 
    commands VARCHAR(100),
    birthday DATE,
    animal_kind_id INT DEFAULT 3,
    Foreign KEY (animal_kind_id) REFERENCES pack_animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO donkeys (name, commands, birthday)
VALUES ('Нарцис', 'вперед, стоять', '2023-10-20'),
('Тошир', 'идти, стоять', '2022-09-09'),
('Мaнюня', 'шагом, вперед', '2022-02-22');

/*10. Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой
      питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.*/

DELETE FROM camels;

CREATE TABLE horses_and_donkeys SELECT * FROM horses
UNION SELECT * FROM donkeys;

/*11. Создать новую таблицу “молодые животные” в которую попадут все
      животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью
      до месяца подсчитать возраст животных в новой таблице*/

/*DROP TABLE IF EXISTS all_animals;      
CREATE TEMPORARY TABLE all_animals AS
SELECT * FROM dogs
UNION SELECT * FROM cats
UNION SELECT * FROM hamsters
UNION SELECT * FROM horses
UNION SELECT * FROM camels
UNION SELECT * FROM donkeys;

DROP TABLE IF EXISTS young_animals;
CREATE TABLE young_animals
SELECT name, commands, birthday, animal_kind_id, TIMESTAMPDIFF(MONTH, birthday, CURDATE()) AS age_in_month
FROM all_animals
WHERE birthday BETWEEN ADDDATE(CURDATE(), INTERVAL 1 YEAR) AND ADDDATE(CURDATE(), INTERVAL 3 YEAR);*/

DROP TABLE IF EXISTS temp_animals;
CREATE TEMPORARY TABLE temp_animals 
SELECT * FROM cats
UNION
SELECT * FROM dogs
UNION
SELECT * FROM hamsters
UNION
SELECT * FROM horses
UNION
SELECT * FROM donkeys
UNION
SELECT * FROM camels;

SELECT * FROM temp_animals;

DROP TABLE IF EXISTS young_animals;
CREATE TEMPORARY TABLE young_animals AS
SELECT
	name,  animal_kind_id, birthday, commands, TIMESTAMPDIFF(MONTH, birthday, CURDATE()) AS age_in_month
FROM 
	temp_animals
WHERE birthday BETWEEN ADDDATE(CURDATE(), INTERVAL -3 YEAR) AND ADDDATE(CURDATE(), INTERVAL -1 YEAR);

/*12. Объединить все таблицы в одну, при этом сохраняя поля, указывающие на прошлую принадлежность к старым таблицам.*/

SELECT dogs.name, dogs.commands, dogs.birthday, pets.animal_kind, animals.animal_type
FROM dogs
LEFT JOIN pets ON pets.id = dogs.animal_kind_id
LEFT JOIN animals ON animals.id=pets.animal_type_id
UNION
SELECT cats.name, cats.commands, cats.birthday, pets.animal_kind, animals.animal_type
FROM cats
LEFT JOIN pets ON pets.id = cats.animal_kind_id
LEFT JOIN animals ON animals.id=pets.animal_type_id
UNION
SELECT hamsters.name, hamsters.commands, hamsters.birthday, pets.animal_kind, animals.animal_type
FROM hamsters
LEFT JOIN pets ON pets.id = hamsters.animal_kind_id
LEFT JOIN animals ON animals.id=pets.animal_type_id
UNION
SELECT horses.name, horses.commands, horses.birthday, pack_animals.animal_kind, animals.animal_type
FROM horses
LEFT JOIN pack_animals ON pack_animals.id = horses.animal_kind_id
LEFT JOIN animals ON animals.id=pack_animals.animal_type_id
UNION
SELECT camels.name, camels.commands, camels.birthday, pack_animals.animal_kind, animals.animal_type
FROM camels
LEFT JOIN pack_animals ON pack_animals.id = camels.animal_kind_id
LEFT JOIN animals ON animals.id=pack_animals.animal_type_id
UNION
SELECT donkeys.name, donkeys.commands, donkeys.birthday, pack_animals.animal_kind, animals.animal_type
FROM donkeys
LEFT JOIN pack_animals ON pack_animals.id = donkeys.animal_kind_id
LEFT JOIN animals ON animals.id=pack_animals.animal_type_id;
