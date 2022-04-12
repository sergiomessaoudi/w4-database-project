-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema proyecto
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema proyecto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyecto` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `proyecto` ;

-- -----------------------------------------------------
-- Table `proyecto`.`actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`actor` (
  `actor_id` INT NOT NULL,
  `first_name` TEXT NULL DEFAULT NULL,
  `last_name` TEXT NULL DEFAULT NULL,
  `last_update` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`actor_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto`.`film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`film` (
  `film_id` INT NOT NULL,
  `title` TEXT NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `release_year` INT NULL DEFAULT NULL,
  `language_id` INT NULL DEFAULT NULL,
  `original_language_id` TEXT NULL DEFAULT NULL,
  `rental_duration` INT NULL DEFAULT NULL,
  `rental_rate` DOUBLE NULL DEFAULT NULL,
  `length` INT NULL DEFAULT NULL,
  `replacement_cost` DOUBLE NULL DEFAULT NULL,
  `rating` TEXT NULL DEFAULT NULL,
  `special_features` TEXT NULL DEFAULT NULL,
  `last_update` TEXT NULL DEFAULT NULL,
  `old_HDD_film_film_id` INT NOT NULL,
  PRIMARY KEY (`film_id`, `old_HDD_film_film_id`),
  INDEX `fk_film_old_HDD1_idx` (`old_HDD_film_film_id` ASC) VISIBLE,
  CONSTRAINT `fk_film_old_HDD1`
    FOREIGN KEY (`old_HDD_film_film_id`)
    REFERENCES `proyecto`.`old_HDD` (`film_film_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto`.`old_HDD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`old_HDD` (
  `first_name` TEXT NULL DEFAULT NULL,
  `last_name` TEXT NULL DEFAULT NULL,
  `title` TEXT NULL DEFAULT NULL,
  `release_year` INT NULL DEFAULT NULL,
  `category_id` INT NULL DEFAULT NULL,
  `film_film_id` INT NOT NULL,
  PRIMARY KEY (`film_film_id`),
  CONSTRAINT `fk_old_HDD_film1`
    FOREIGN KEY (`film_film_id`)
    REFERENCES `proyecto`.`film` (`film_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`category` (
  `category_id` INT NULL DEFAULT NULL,
  `name` TEXT NULL DEFAULT NULL,
  `last_update` TEXT NULL DEFAULT NULL,
  `old_HDD_film_film_id` INT NOT NULL,
  PRIMARY KEY (`old_HDD_film_film_id`),
  CONSTRAINT `fk_category_old_HDD1`
    FOREIGN KEY (`old_HDD_film_film_id`)
    REFERENCES `proyecto`.`old_HDD` (`film_film_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto`.`film_has_actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`film_has_actor` (
  `film_film_id` INT NOT NULL,
  `actor_actor_id` INT NOT NULL,
  PRIMARY KEY (`film_film_id`, `actor_actor_id`),
  INDEX `fk_film_has_actor_actor1_idx` (`actor_actor_id` ASC) VISIBLE,
  INDEX `fk_film_has_actor_film_idx` (`film_film_id` ASC) VISIBLE,
  CONSTRAINT `fk_film_has_actor_actor1`
    FOREIGN KEY (`actor_actor_id`)
    REFERENCES `proyecto`.`actor` (`actor_id`),
  CONSTRAINT `fk_film_has_actor_film`
    FOREIGN KEY (`film_film_id`)
    REFERENCES `proyecto`.`film` (`film_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`inventory` (
  `inventory_id` INT NULL DEFAULT NULL,
  `film_id` INT NULL DEFAULT NULL,
  `store_id` INT NULL DEFAULT NULL,
  `last_update` TEXT NULL DEFAULT NULL,
  `film_film_id` INT NOT NULL,
  `film_old_HDD_film_film_id` INT NOT NULL,
  PRIMARY KEY (`film_film_id`, `film_old_HDD_film_film_id`),
  CONSTRAINT `fk_inventory_film1`
    FOREIGN KEY (`film_film_id` , `film_old_HDD_film_film_id`)
    REFERENCES `proyecto`.`film` (`film_id` , `old_HDD_film_film_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto`.`language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`language` (
  `language_id` INT NULL DEFAULT NULL,
  `name` TEXT NULL DEFAULT NULL,
  `last_update` TEXT NULL DEFAULT NULL,
  `film_film_id` INT NOT NULL,
  PRIMARY KEY (`film_film_id`),
  CONSTRAINT `fk_language_film1`
    FOREIGN KEY (`film_film_id`)
    REFERENCES `proyecto`.`film` (`film_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto`.`rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto`.`rental` (
  `rental_id` INT NULL DEFAULT NULL,
  `rental_date` TEXT NULL DEFAULT NULL,
  `inventory_id` INT NULL DEFAULT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  `return_date` TEXT NULL DEFAULT NULL,
  `staff_id` INT NULL DEFAULT NULL,
  `last_update` TEXT NULL DEFAULT NULL,
  `inventory_film_film_id` INT NOT NULL,
  `inventory_film_old_HDD_film_film_id` INT NOT NULL,
  PRIMARY KEY (`inventory_film_film_id`, `inventory_film_old_HDD_film_film_id`),
  CONSTRAINT `fk_rental_inventory1`
    FOREIGN KEY (`inventory_film_film_id` , `inventory_film_old_HDD_film_film_id`)
    REFERENCES `proyecto`.`inventory` (`film_film_id` , `film_old_HDD_film_film_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
