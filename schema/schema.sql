DROP TABLE IF EXISTS "ingredients";
DROP TABLE IF EXISTS "donuts";
DROP TABLE IF EXISTS "donut_ingredients";
DROP TABLE IF EXISTS "orders";
DROP TABLE IF EXISTS "order_donuts";
DROP TABLE IF EXISTS "customers";

CREATE TABLE "ingredients" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "cost" NUMERIC NOT NULL,
    "unit" TEXT,
    PRIMARY KEY("id")
);

CREATE TABLE "donuts" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "gluten_free" TEXT NOT NULL CHECK("gluten_free" = 'yes' OR "gluten_free" = 'no'),
    "price" NUMERIC NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE "donut_ingredients" (
    "id" INTEGER,
    "ingredient_id" INTEGER,
    "donut_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("ingredient_id") REFERENCES "ingredients"("id"),
    FOREIGN KEY("donut_id") REFERENCES "donuts"("id")
);

CREATE TABLE "orders" (
    "id" INTEGER,
    "customer_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("customer_id") REFERENCES "customers"("id")
);

CREATE TABLE "order_donuts" (
    "id" INTEGER,
    "order_id" INTEGER,
    "donut_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("order_id") REFERENCES "orders"("id"),
    FOREIGN KEY("donut_id") REFERENCES "donuts"("id")
);

CREATE TABLE "customers" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY("id")
);



