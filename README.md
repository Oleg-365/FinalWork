# Студент: Попов Олег  4830
-------------------------------------------

## **Решение**

1. Используя команду cat в терминале операционной системы Linux, создать два файла Домашние животные (заполнив файл 
собаками, кошками, хомяками) и Вьючные животными (заполнив файл Лошадьми, верблюдами иослы), а затем объединить их.
Просмотреть содержимое созданного файла. Переименовать файл, дав ему новое имя (Друзья человека).

 ```
ubuntu@ubuntu-VirtualBox:~$ cat >Pets.txt
Собаки
Кошки
Хомяки

ubuntu@ubuntu-VirtualBox:~$ cat Pets.txt
Собаки
Кошки
Хомяки

ubuntu@ubuntu-VirtualBox:~$ cat >Pack_animals.txt
Лошади
Верблюды
Ослы

ubuntu@ubuntu-VirtualBox:~$ cat Pack_animals.txt
Лошади
Верблюды
Ослы

ubuntu@ubuntu-VirtualBox:~$ cat Pets.txt Pack_animals.txt > Animals.txt

ubuntu@ubuntu-VirtualBox:~$ cat Animals.txt
Собаки
Кошки
Хомяки
Лошади
Верблюды
Ослы

ubuntu@ubuntu-VirtualBox:~$ mv Animals.txt HumanFriends.txt

ubuntu@ubuntu-VirtualBox:~$ ls

 dbui  Pack  Pets.txt   snap  wordpress   Документы   Изображения   Общедоступные   Шаблоны
 HumanFriends.txt   Pack_animals.txt   sem      Видео       Загрузки    Музыка       'Рабочий стол'
 ```

2. Создать директорию, переместить файл туда.

```
ubuntu@ubuntu-VirtualBox:~$ mkdir animals

ubuntu@ubuntu-VirtualBox:~$ mv HumanFriends.txt animals

ubuntu@ubuntu-VirtualBox:~$ cd animals/

ubuntu@ubuntu-VirtualBox:~/animals$ ll

итого 12

drwxrwxr-x  2 ubuntu ubuntu 4096 фев 14 14:43 ./
drwxr-x--- 19 ubuntu ubuntu 4096 фев 14 14:43 ../
-rw-rw-r--  1 ubuntu ubuntu   76 фев 13 20:41 HumanFriends.txt
```

3. Подключить дополнительный репозиторий MySQL. Установить любой пакет
из этого репозитория.

```
ubuntu@ubuntu-VirtualBox:~$ cd animals/

ubuntu@ubuntu-VirtualBox:~/animals$ wget https://dev.mysql.com/get/mysql-apt-config_0.8.26-1_all.deb

ubuntu@ubuntu-VirtualBox:~/animals$ sudo dpkg -i mysql-apt-config_0.8.26-1_all.deb

ubuntu@ubuntu-VirtualBox:~/animals$ sudo apt install mysql-client mysql-community-server mysql-server

ubuntu@ubuntu-VirtualBox:~/animals$ sudo apt update

ubuntu@ubuntu-VirtualBox:~/animals$ sudo mysql_secure_installation

ubuntu@ubuntu-VirtualBox:~/animals$ sudo mysql
```

4. Установить и удалить deb-пакет с помощью dpkg.

```
ubuntu@ubuntu-VirtualBox:~$ apt download lftp

ubuntu@ubuntu-VirtualBox:~$ sudo dpkg -i lftp_4.9.2-1build1_amd64.deb

ubuntu@ubuntu-VirtualBox:~$ sudo dpkg -r lftp
```

5. Выложить историю команд в терминале ubuntu

```
366  cat >Pets.txt
368  cat Pets.txt
369  cat >Pack animals.txt
370  cat >Pack_animals.txt
371  cat Pack_animals
372  cat Pack_animals.txt
373  cat Pets.txt Pack_animals.txt > Animals.txt
374  cat Animals.txt
375  ls
376  mv Animals.txt HumanFriends.txt
377  ls
378  mkdir animals
379  mv Human_Friends.txt
380  mv Human_Friends.txt animals
381  ls
382  mkdir animals
383  rmdir animals
384  mkdir animals
385  mv HumanFriends.txt animals
386  cd animals/
387  ll
388  cd animals/
389  wget https://dev.mysql.com/get/mysql-apt-config_0.8.26-1_all.deb
390  sudo dpkg -i mysql-apt-config_0.8.26-1_all.deb
391  sudo apt install mysql-client mysql-community-server mysql-server
392  sudo apt update
393  sudo mysql_secure_installation
394  sudo mysql
395  cd
396  apt download lftp
397  sudo dpkg -i lftp_4.9.2-1build1_amd64.deb
398  sudo dpkg -r lftp
399  history
```

6. Нарисовать диаграмму, в которой есть класс родительский класс, домашние
животные и вьючные животные, в составы которых в случае домашних
животных войдут классы: собаки, кошки, хомяки, а в класс вьючные животные
войдут: Лошади, верблюды и ослы.

![diagram](https://github.com/Oleg-365/FinalWork/blob/main/img/diagram.png)

7. В подключенном MySQL репозитории создать базу данных “Друзья человека”.

```
CREATE DATABASE human_friends;

USE human_friends;
```

8. Создать таблицы с иерархией из диаграммы в БД.

```
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
```

9. Заполнить низкоуровневые таблицы именами(животных), командами
      которые они выполняют и датами рождения.

```
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
```

10. Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой
      питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.

```
DELETE FROM camels;

CREATE TABLE horses_and_donkeys SELECT * FROM horses
UNION SELECT * FROM donkeys;
```

11. Создать новую таблицу “молодые животные” в которую попадут все
      животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью
      до месяца подсчитать возраст животных в новой таблице.

```
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
```

12. Объединить все таблицы в одну, при этом сохраняя поля, указывающие на прошлую принадлежность к старым таблицам.

```
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
```

## Реестр питомника

Консольное приложение имитирует работу реестра домашних животных.\
Запуск приложения через файл Main.java.\
Данные животных сохраняются в файле в формате csv.

Реализованные функции в программе: просмотр списка всех животных в питомнике, добавление нового животного с определением в правильный класс, просмотр команд указанного животного, обучение животного новым командам, организована навигация через меню, счетчик организован в файле View.java.
