select * 
from reaction_types;

select *
from content;

alter table content
drop column url;

alter table content
drop column user_id;

delete from content 
where content_id IS NULL;

UPDATE content
SET category = TRIM(BOTH '" "' FROM category)
WHERE category LIKE '"%"' OR category LIKE '"%"';

UPDATE content
SET category = LOWER(category);

ALTER TABLE content
RENAME COLUMN type to content_type;

select *
from reactions;

alter table reactions
drop column user_id;

-- removing the primary keys of the tables, so I can drop the field1 columns that are not needed.

ALTER TABLE reactions
DROP CONSTRAINT reactions_pkey;

alter table reactions
drop column field1;

ALTER TABLE content
DROP CONSTRAINT content_pkey;

alter table content
drop column field1;

--Joining the three tables into a single table

CREATE TABLE content_reactions AS
SELECT *
FROM reactions
JOIN content USING (content_id);

SELECT *
FROM content_reactions;

CREATE TABLE cleaned_socialbuzz_table AS
SELECT *
FROM content_reactions
JOIN reaction_types USING (type);

SELECT *
FROM cleaned_socialbuzz_table;

ALTER TABLE cleaned_socialbuzz_table
DROP COLUMN field1;

-- To find the top 5 performing categories 

CREATE TABLE top_five_categories AS
SELECT category,SUM(score)
FROM cleaned_socialbuzz_table
GROUP BY category
ORDER BY 2 DESC
LIMIT 5;

SELECT *
FROM top_five_categories;
