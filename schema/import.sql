-- Drop tables on each read
DROP TABLE IF EXISTS "meteorites_temp";
DROP TABLE IF EXISTS "meteorites";

-- Create Tables
CREATE TABLE IF NOT EXISTS "meteorites_temp" (
    "name" TEXT,
    "id" INTEGER,
    "nametype" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" INTEGER,
    "lat" REAL,
    "long" REAL,
    PRIMARY KEY("id")
);

-- This will be read if terminal used --> cat import.sql | sqlite3 my_database.db
-- or if .read used after db creation
.import --csv --skip 1 meteorites.csv meteorites_temp
.nullvalue NULL

-- CLEAN VALUES IN TEMP HERE
-- update mass column here
UPDATE "meteorites_temp"
SET "mass" = ROUND("mass", 2);

UPDATE "meteorites_temp"
SET "mass" = NULL
WHERE "mass" = '';

-- update year column
UPDATE "meteorites_temp"
SET "year" = NULL
WHERE "year" = '';

-- update lat column
UPDATE "meteorites_temp"
SET "lat" = NULL
WHERE "lat" = '';

UPDATE "meteorites_temp"
SET "lat" = ROUND("lat", 2);

-- update long column
UPDATE "meteorites_temp"
SET "long" = NULL
WHERE "long" = '';

UPDATE "meteorites_temp"
SET "long" = ROUND("long", 2);

-- Delete unnecessary lines
DELETE FROM "meteorites_temp"
WHERE "nametype" = 'Relict';

-- Create our final table
CREATE TABLE IF NOT EXISTS "meteorites" (
    "id" INTEGER NOT NULL,
    "name" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" INTEGER,
    "lat" REAL,
    "long" REAL,
    PRIMARY KEY("id")
);

-- Insert into final table from temp
-- we are ordering by year then name if same year
-- and assigning autoincremented id (primary key) values
INSERT INTO "meteorites" ("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name", "class", "mass", "discovery", "year", "lat", "long"
FROM "meteorites_temp"
ORDER BY "year" ASC, "name" DESC;


-- Get rid of temp table
DROP TABLE IF EXISTS "meteorites_temp";
