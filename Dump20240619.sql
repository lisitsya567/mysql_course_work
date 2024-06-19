-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: hospital2
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `8_marta`
--

DROP TABLE IF EXISTS `8_marta`;
/*!50001 DROP VIEW IF EXISTS `8_marta`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `8_marta` AS SELECT 
 1 AS `fname`,
 1 AS `lname`,
 1 AS `gender`,
 1 AS `phone`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_time` datetime DEFAULT NULL,
  `Doctors_id` int NOT NULL,
  `Rooms_number` int NOT NULL,
  `Patients_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Appointments_Doctors1_idx` (`Doctors_id`),
  KEY `fk_Appointments_Rooms1_idx` (`Rooms_number`),
  KEY `fk_Appointments_Patients1_idx` (`Patients_id`),
  CONSTRAINT `fk_Appointments_Doctors1` FOREIGN KEY (`Doctors_id`) REFERENCES `doctors` (`id`),
  CONSTRAINT `fk_Appointments_Patients1` FOREIGN KEY (`Patients_id`) REFERENCES `patients` (`id`),
  CONSTRAINT `fk_Appointments_Rooms1` FOREIGN KEY (`Rooms_number`) REFERENCES `rooms` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (1,'2024-05-03 10:00:00',2,105,1),(2,'2024-05-03 10:00:00',3,106,5),(3,'2024-05-03 10:15:00',2,105,7),(4,'2024-05-01 10:30:00',3,106,2),(5,'2024-05-01 10:30:00',2,105,3),(6,'2024-05-01 10:45:00',2,105,4),(7,'2024-05-01 11:00:00',3,106,3);
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `gender` varchar(6) DEFAULT NULL,
  `specialization` varchar(50) DEFAULT NULL,
  `phone` char(12) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `suborder_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_UNIQUE` (`phone`),
  KEY `fk_Doctors_Doctors1_idx` (`suborder_id`),
  CONSTRAINT `fk_Doctors_Doctors1` FOREIGN KEY (`suborder_id`) REFERENCES `doctors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,'Поликлтника','Зубастик','none','none','+72039932849','Россия, г. Тверь, Молодежная ул., д. 21 кв.45',NULL),(2,'Анастасия','Сергеева','female','Стоматолог-терапевт','+71425090085','Россия, г. Мурманск, Лесной пер., д. 24 кв.141',1),(3,'Мария','Сергеева','female','Стоматолог-хирург','+74053092095','Россия, г. Нижний Тагил, ЯнкиКупалы ул., д. 19 кв.173',1),(4,'Софья','Леонова','female','Стоматолог-хирург','+72715461577','Россия, г. Красногорск, Колхозный пер., д. 13 кв.14',1),(5,'Семён','Скворцов','male','Стоматолог-ортодонт','+73957050497','Россия, г. Астрахань, Приозерная ул., д. 13 кв.98',1),(6,'Ксения','Лаврентьева','female','Стоматолог-ортодонт','+78633368717','Россия, г. Первоуральск, Молодежная ул., д. 21 кв.45',1),(7,'Евгений','Ланский','male','ГлавВрач','+78468091779','Россия, г. Самара, Парковая ул., д. 6 кв.141',NULL);
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Doctors_id` int NOT NULL,
  `Appointments_id` int NOT NULL,
  `Patients_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Invoices_Doctors1_idx` (`Doctors_id`),
  KEY `fk_Invoices_Appointments1_idx` (`Appointments_id`),
  KEY `fk_Invoices_Patients1_idx` (`Patients_id`),
  CONSTRAINT `fk_Invoices_Appointments1` FOREIGN KEY (`Appointments_id`) REFERENCES `appointments` (`id`),
  CONSTRAINT `fk_Invoices_Doctors1` FOREIGN KEY (`Doctors_id`) REFERENCES `doctors` (`id`),
  CONSTRAINT `fk_Invoices_Patients1` FOREIGN KEY (`Patients_id`) REFERENCES `patients` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES (1,2,1,1),(2,3,2,5),(3,2,3,7),(4,3,4,2),(5,2,5,3),(6,2,6,4),(7,3,7,3);
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `gender` varchar(6) DEFAULT NULL,
  `passport` char(10) DEFAULT NULL,
  `phone` char(12) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_UNIQUE` (`phone`),
  UNIQUE KEY `passport_UNIQUE` (`passport`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,'Артем','Любовский','male','4797202798','+78448752988','Россия, г. Альметьевск, Космонавтов ул., д. 1 кв.170',190000.00),(2,'Амелия','Логинова','female','4842695239','+71755015041','Россия, г. Кызыл, Зеленая ул., д. 20 кв.149',231100.00),(3,'Дмитрий','Киселев','male','4195188752','+72099464684','Россия, г. Каменск - Уральский, ЯнкиКупалы ул., д. 13 кв.73',110000.00),(4,'Артём','Соболев','male','4250659535','+70632855234','Россия, г. Омск, Ленина В.И.ул., д. 10 кв.113',100000.00),(5,'Мария','Иванова','female','4820981499','+75513822128','Россия, г. Псков, Сосновая ул., д. 18 кв.21',325125.00),(6,'Данила','Никонов','male','4889205091','+79526186175','Россия, г. Сургут, Зеленая ул., д. 14 кв.143',112320.00),(7,'Илья','Елисеев','male','4653451816','+71557800995','Россия, г. Йошкар-Ола, Дачная ул., д. 10 кв.106',130200.00);
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `number` int NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (101,'Регистратура'),(105,'Терапевтический кабинет'),(106,'Хирургический кабинет'),(107,'Ортодонт'),(110,'ГлавВрач');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salary`
--

DROP TABLE IF EXISTS `salary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Doctors_id` int NOT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Salary_Doctors1_idx` (`Doctors_id`),
  CONSTRAINT `fk_Salary_Doctors1` FOREIGN KEY (`Doctors_id`) REFERENCES `doctors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salary`
--

LOCK TABLES `salary` WRITE;
/*!40000 ALTER TABLE `salary` DISABLE KEYS */;
INSERT INTO `salary` VALUES (1,1,0.00,50009000.00),(2,2,100000.00,100000.00),(3,3,125000.00,132000.00),(4,4,125000.00,234000.00),(5,5,115000.00,124100.00),(6,6,115000.00,112000.00),(7,7,150000.00,231000.00);
/*!40000 ALTER TABLE `salary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_details`
--

DROP TABLE IF EXISTS `service_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_details` (
  `Invoices_id` int NOT NULL,
  `Services_id` int NOT NULL,
  PRIMARY KEY (`Invoices_id`,`Services_id`),
  KEY `fk_Invoices_has_Services_Services1_idx` (`Services_id`),
  KEY `fk_Invoices_has_Services_Invoices1_idx` (`Invoices_id`),
  CONSTRAINT `fk_Invoices_has_Services_Invoices1` FOREIGN KEY (`Invoices_id`) REFERENCES `invoices` (`id`),
  CONSTRAINT `fk_Invoices_has_Services_Services1` FOREIGN KEY (`Services_id`) REFERENCES `services` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_details`
--

LOCK TABLES `service_details` WRITE;
/*!40000 ALTER TABLE `service_details` DISABLE KEYS */;
INSERT INTO `service_details` VALUES (1,1),(3,1),(5,1),(6,1),(2,2),(7,2),(4,3);
/*!40000 ALTER TABLE `service_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Первичный осмотр',500.00),(2,'Удаление постоянного зуба',7200.00),(3,'Удаление постоянного зуба особой сложности',8500.00),(4,'Вторичный осмотр',0.00),(5,'Установка имплантанта производителя',13000.00),(6,'Нейлоновый съемный протез',25500.00);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `8_marta`
--

/*!50001 DROP VIEW IF EXISTS `8_marta`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `8_marta` AS select `patients`.`fname` AS `fname`,`patients`.`lname` AS `lname`,`patients`.`gender` AS `gender`,`patients`.`phone` AS `phone` from `patients` where (`patients`.`gender` = 'female') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-19 21:53:30
