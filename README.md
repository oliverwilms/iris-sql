## SQL Privileges

SQL privileges are assigned to a user or role. A role enables you to set the same privileges for multiple users.

InterSystems SQL supports two types of privileges: administrative and object.

Object privileges are specific to a table, view, or stored procedure. They specify the type of access to specific named SQL objects (in the SQL sense of the word: a table, a view, a column, or a stored procedure).

Table-level object privileges provide access (%ALTER, DELETE, SELECT, INSERT, UPDATE, EXECUTE, REFERENCES, CANCEL) to the data in all columns of a table or view, both those columns that currently exist and any subsequently added columns.

## Granting SQL Privileges

From ObjectScript, use the $SYSTEM.SQL.Security.GrantPrivilege() method to grant specific object privileges to a specified user (or list of users).

## Listing SQL Privileges

From ObjectScript, use the $SYSTEM.SQL.Security.CheckPrivilege() method to determine if a specified user has a specific object privilege.
