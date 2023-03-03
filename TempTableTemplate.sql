# Execute the steps/activites in rough chronological order... as you see fit in your testing/simulation 

# META-Activities
DROP TABLE IF EXISTS hold;
DROP TABLE IF EXISTS asks;

DROP DATABASE IF EXISTS any;

DROP PROCEDURE IF EXISTS dataset;
DROP PROCEDURE IF EXISTS discern;



# DDL-A
CREATE DATABASE any; USE any;


# DDL-B
CREATE TABLE asks (
    ID int,
    LName varchar(255),
    FName varchar(255),
    Property varchar(255),
    Instant long
);
DESCRIBE asks;


# DDL-C
CREATE TEMPORARY TABLE hold (id INT,FName varchar(255),LName varchar(255));
DESCRIBE hold;

#SHOW TABLES; # NB: hold will not be visible



# DML-Synthetic (invoke however-many-times, cache results, use to "craft" a dataset)
select UNIX_TIMESTAMP();



# SPROC1-DATASET: Populates test data (refreshs to known/sane state)
DELIMITER //
CREATE PROCEDURE dataset()
BEGIN

  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (9, "nine", "nine", "LV", 1660196642);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (9, "nine", "nine", "LV", 1660196643);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (9, "nine", "nine", "LV", 1660196644);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (9, "nine", "nine", "LV", 1660196645);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (10, "ten","ten","AC",1660196646);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (10, "ten","ten","AC",1660196647);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (10, "ten","ten","AC",1660196648);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (10, "ten","ten","AC",1660196649);

  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (9, "nine", "nine", "LV", 1660196650);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (10, "ten","ten","AC",1660196651);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (9, "nine", "nine", "LV", 1660196652);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (10, "ten","ten","AC",1660196653);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (9, "nine", "nine", "LV", 1660196654);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (10, "ten","ten","AC",1660196661);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (9, "nine", "nine", "LV", 1660196662);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (10, "ten","ten","AC",1660196663);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (9, "nine", "nine", "LV", 1660196664);

  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (9, "nine", "nine", "LV", 1660196670);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (9, "nine", "nine", "LV", 1660196671);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (10, "ten","ten","AC",1660196672);
  INSERT INTO asks (ID,LName,FName,Property,Instant)
  VALUES (10, "ten","ten","AC",1660196673);

END //
DELIMITER ;


# wildcard specifier future-proofs (identifies any future namespace collisions)
SHOW PROCEDURE STATUS LIKE '%dataset%'; # wildcard specifier future-proofs

# ¡IMPORTANTE!
call dataset;
SELECT * FROM asks;


# SPROC2-DISCERN: Detects events/transactions within a predefined bounds
DELIMITER //
CREATE PROCEDURE discern(IN start long, IN end long)
BEGIN
	SELECT ID FROM asks WHERE Instant BETWEEN start and end;
END //
DELIMITER ;

# OR, Do math, internally, to determine the range (supply just the 'start/inception' value)
call discern(1660196649, 1660196670);


#  ¡Finally!
INSERT INTO hold(id,FName,LName) SELECT ID, FName, LName FROM asks WHERE Instant BETWEEN 1660196650 and 1660196664;



#Get tha goods
SELECT * FROM hold;



# RAW-VALUES
# before synthetic time-boundary
# 1660196642
# 1660196643
# 1660196644
# 1660196645
# 1660196646
# 1660196647
# 1660196648
# 1660196649
#
#
# 1660196650
# 1660196651
# 1660196652
# 1660196653
# 1660196654
# 1660196661
# 1660196662
# 1660196663
# 1660196664
#
#
# beyond synthetic time boundary
# 1660196670
# 1660196671
# 1660196672
# 1660196673




# meta/fun-fact
SHOW FULL PROCESSLIST;
