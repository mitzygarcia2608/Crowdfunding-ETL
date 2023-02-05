-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT SUM(backers_count) as backer_count_per_id, cf_id
FROM campaign
WHERE outcome = 'live'
GROUP BY cf_id
ORDER BY cf_id DESC;



-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.

SELECT COUNT(b.backer_id) as number_of_backer_ids, cp.cf_id
FROM backer as b
LEFT JOIN campaign as cp
ON cp.cf_id = b.cf_id
WHERE cp.outcome = 'live'
GROUP BY cp.cf_id
ORDER BY cp.cf_id DESC;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT ct.first_name,
ct.last_name,
ct.email,
cp.goal - cp.pledged as remaining_goal_amount
INTO email_contacts_remaining_goal_amount
FROM campaign as cp
LEFT JOIN contacts as ct
ON ct.contact_id = cp.contact_id
WHERE cp.outcome = 'live'
ORDER BY remaining_goal_amount DESC;
--Check the table
SELECT * FROM email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT bc.email,
bc.first_name,
bc.last_name,
cmp.cf_id,
cmp.company_name,
cmp.description,
cmp.end_date,
cmp.goal - cmp.pledged as Left_of_goal
INTO email_backers_remaining_goal_amount
FROM backer as bc
LEFT JOIN campaign as cmp
ON bc.cf_id =cmp.cf_id
WHERE cmp.outcome='live'
ORDER BY bc.last_name;


-- Check the table
SELECT * FROM email_backers_remaining_goal_amount;

