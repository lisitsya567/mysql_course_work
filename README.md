![ER_diagram](https://github.com/lisitsya567/mysql_course_work/assets/120280978/6e533a21-1625-44fb-98b7-3743049b8f1f)
![IMG_456цкпукцпц5](https://github.com/lisitsya567/mysql_course_work/assets/120280978/12210b36-2b84-4c2b-afce-43507fb91013)



# Триггер с условием и обработчиком исключений, проверка баланса
```sql
DELIMITER $$

CREATE TRIGGER trigger_update_salary
BEFORE UPDATE
ON salary
FOR EACH ROW
BEGIN
    DECLARE insufficient_balance CONDITION FOR SQLSTATE '45000';
    DECLARE current_balance DECIMAL(10, 2);

    SELECT balance INTO current_balance
    FROM salary
    WHERE id = 1;

    IF current_balance < 1000000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Операция не может быть выполнена из-за недостатка средств на счете';
    END IF;
END;
$$

DELIMITER ;



Проверка


UPDATE salary 
SET balance = balance - 50000 
WHERE id = 2;
```

# Транзакция в хранимой процедуре с условием, оплата выставленного счета
```sql
DELIMITER $$
CREATE PROCEDURE TransferMoney(
  IN accountFrom INT,
  IN amountMoney DECIMAL(10,2)
)
BEGIN
    -- Объявление переменных
    DECLARE balanceAmount DECIMAL(10,2);
    SELECT balance INTO balanceAmount
    FROM patients WHERE id = accountFrom;

    -- Начало транзакции
    START TRANSACTION;

    UPDATE patients
    SET balance = balance - amountMoney
    WHERE id = accountFrom;

    UPDATE salary
    SET balance = balance + amountMoney
    WHERE id = 1;

    IF balanceAmount >= amountMoney THEN
        SELECT balanceAmount, amountMoney, 'Можем перевести, фиксируем транзакцию';
        COMMIT;
    ELSE
        SELECT balanceAmount, amountMoney, 'Не можем перевести, откатываем транзакцию';
        ROLLBACK;
    END IF;

END $$
DELIMITER ;
```
# Представление, выводит все клиентов жеского пола
```sql
CREATE VIEW 8_marta AS
SELECT 
	patients.fname,
    patients.lname,
    patients.gender,
    patients.phone
FROM patients
WHERE gender = 'female';
```
# Пользовательская функция, расчитывает скидку в 20%
```sql

```

# Пользовательская функция
```sql
DELIMITER $$
CREATE FUNCTION calculate_20_sale(amount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE vat DECIMAL(10,2);
    SET vat = amount * 0.2; -- 20% Скидка
    RETURN vat;
END $$
DELIMITER ;
```

# 1 Типовой запрос выводит клиентов у которых прием в 10:00 3-го мая.
```sql
SELECT
	doctors.fname,
    doctors.lname,
    doctors.specialization,
    appointments.date_time,
    rooms.number,
    rooms.title,
    patients.fname,
    patients.lname,
    patients.phone
FROM appointments
JOIN doctors ON appointments.Doctors_id = doctors.id    
JOIN patients ON appointments.Patients_id = patients.id
JOIN rooms ON appointments.Rooms_number = rooms.number
WHERE date_time LIKE '%10:00:00%'
;
```

# 2 Типовой запрос выводит процедуру, которая была сделана клиенту с id=2 и также рассчитывает скидку в 20%
```sql
SELECT 
	invoices.Patients_id,
    services.name,
    services.price,
	hospital2.calculate_20_sale(8500)
FROM service_details
JOIN invoices ON service_details.Invoices_id = invoices.id
JOIN services ON service_details.Services_id = services.id
WHERE Patients_id = 2
;
```

# 3 Типовой запрос выводит номер мобильного телефона второго врача со специальностью Стоматолог-Хирург, по причине, что первый врач взял отгул по состоянию здоровья
```sql
SELECT
	doctors.fname,
    doctors.lname,
    doctors.specialization,
    doctors.phone
FROM doctors
WHERE specialization LIKE '%Стоматолог-хирург%'
;
```

# 4 Типовой запрос выводит названия и цены процедур, которые были предоставлены клиенту с id = 3 
```sql
SELECT 
	invoices.Patients_id,
    services.name,
    services.price
FROM service_details
JOIN invoices ON service_details.Invoices_id = invoices.id
JOIN services ON service_details.Services_id = services.id
WHERE Patients_id = 3
;
```

# 5 Типовой запрос выводит сумму заработаную стоматологией за все время
```sql
SELECT SUM(services.price)
FROM service_details
JOIN invoices ON service_details.Invoices_id = invoices.id
JOIN services ON service_details.Services_id = services.id
```

# Локальные переменные
# 1 Локальная переменная выводит время приема, имя и фамилию у указанного id клиента
```sql
DELIMITER $$

CREATE PROCEDURE time_appointments(
  IN userID INT
)
BEGIN

  DECLARE time DATETIME;
  DECLARE fname VARCHAR(255);
  DECLARE lname VARCHAR(255);

  SET time = (
    SELECT appointments.date_time FROM appointments
    JOIN patients ON appointments.Patients_id = patients.id
	WHERE appointments.id = userID
  );
  
  SET fname = (
    SELECT patients.fname FROM patients
    JOIN appointments ON appointments.Patients_id = patients.id
	WHERE appointments.id = userID
  );
  
  SET lname = (
    SELECT patients.lname FROM patients
    JOIN appointments ON appointments.Patients_id = patients.id
	WHERE appointments.id = userID
  );
  

  SELECT time, fname, lname;

END $$

DELIMITER ;
```

# 2 Локальная переменная выводит имя, фамилию, баланс и зарплату врача с указанным id
```sql
DELIMITER $$

CREATE PROCEDURE ShowCheckSalary(
   IN userID INT
)
BEGIN

  DECLARE fname VARCHAR(255);
  DECLARE lname VARCHAR(255);
  DECLARE salary DECIMAL(10,2);
  DECLARE balance DECIMAL(10,2);
	
  SET fname = (
    SELECT doctors.fname FROM doctors
    JOIN salary ON salary.Doctors_id = doctors.id
    WHERE doctors.id = userID
  );
  
  SET lname = (
    SELECT doctors.lname FROM doctors
    JOIN salary ON salary.Doctors_id = doctors.id
    WHERE doctors.id = userID
  );
  
  SET salary = (
    SELECT salary.salary FROM salary
    JOIN doctors ON salary.Doctors_id = doctors.id
	WHERE salary.Doctors_id = userID
  );
  
  SET balance = (
    SELECT salary.balance FROM salary
    JOIN doctors ON salary.Doctors_id = doctors.id
	WHERE salary.Doctors_id = userID
  );
  

  SELECT fname, lname, salary, balance;

END $$

DELIMITER ;
```

# 3 Локальная переменная выводит название и цену на указанную процедуру с помощью id
```sql
DELIMITER $$

CREATE PROCEDURE ShowServices(
   IN ID INT
)
BEGIN

  DECLARE title VARCHAR(255);
  DECLARE money DECIMAL(10,2);
	
  SET title = (
    SELECT services.name FROM services
    WHERE services.id = ID
  );
  
  SET money = (
    SELECT services.price FROM services
    WHERE services.id = ID
  );
  

  SELECT title, money;

END $$

DELIMITER ;
```


# Роли
# 1 роль «бухгалтер» имеет доступ к таблице salary [зарплаты]
```sql
CREATE USER 'accountant2'@'localhost' IDENTIFIED BY '123123123';
GRANT SELECT, INSERT, UPDATE ON hospital2.salary TO 'accountant2'@'localhost';
FLUSH PRIVILEGES;
```


# Вторая роль «‎клиент»‎ имеет доступ только к таблице services[услуги]
```sql
CREATE USER 'сlient2'@'localhost' IDENTIFIED BY '000';
GRANT SELECT(name, price) ON hospital2.services TO 'сlient2'@'localhost';
FLUSH PRIVILEGES;
```


