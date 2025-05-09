INSERT INTO "user_logs" ("type", "password")
SELECT 'update', (
    SELECT "password" FROM "users" WHERE "username" = 'carter'
);

-- user_logs is the table, type and password are the columns; SELECT is used rather than values because
-- our inserted values are mixed static and query: 'update' is type value and the query returns the password value
