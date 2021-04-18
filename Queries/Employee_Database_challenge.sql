-- Retirement Eligble Employees by Title
SELECT e.emp_no, 
e.first_name, 
e.last_name,
t.title,
t.from_date,
t.to_date
--INTO retirement_titles
FROM employees as e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
INNER JOIN dept_employees AS de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no ASC;

--Remove Duplicates
SELECT DISTINCT ON(emp_no) emp_no, 
first_name, 
last_name,
title
--INTO unique_titles
FROM retirement_titles
ORDER BY emp_no ASC, to_date DESC

-- Number Employees by Title for Retirement
SELECT COUNT(title),
title
--INTO retiring_titles
FROM unique_titles
GROUP BY(title)
ORDER BY COUNT(title) DESC;

--Mentorship Eligibility Table
SELECT DISTINCT ON(e.emp_no) e.emp_no, 
e.first_name, 
e.last_name, 
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	 AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no ASC, t.to_date DESC;

--Mentorship Statistics
SELECT COUNT(title) as "Employees Eligible", 
ROUND((100* COUNT(title) / '1549'),0) as "% of Total Eligible",
title as "Title"
FROM mentorship_eligibility
GROUP BY Title
ORDER BY "Employees Eligible" DESC;

-- Total Employees Still Working
SELECT COUNT(e.emp_no)
FROM employees AS e
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
WHERE (de.to_date = '9999-01-01')


-- Retirement Eligble Next 10 Years - Employees by Title
SELECT e.emp_no, 
e.first_name, 
e.last_name,
t.title,
t.from_date,
t.to_date
INTO retirement_titles_10yr
FROM employees as e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
INNER JOIN dept_employees AS de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1962-12-31') 
		AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no ASC;

--Remove Duplicates
SELECT DISTINCT ON(emp_no) emp_no, 
first_name, 
last_name,
title
INTO unique_titles_10yr
FROM retirement_titles_10yr
ORDER BY emp_no ASC, to_date DESC

-- Number Employees in Next 10 Years by Title for Retirement
SELECT COUNT(title),
title
--INTO retiring_titles_10yr
FROM unique_titles_10yr
GROUP BY(title)
ORDER BY COUNT(title) DESC;


--Budget Query
SELECT DISTINCT ON(rt.emp_no) rt.emp_no, 
rt.first_name, 
rt.last_name,
rt.title,
s.salary
INTO unique_retirement_salaries
FROM retirement_titles AS rt
INNER JOIN salaries AS s
ON (rt.emp_no = s.emp_no)
WHERE rt.emp_no IN 
	(SELECT emp_no
	 FROM salaries)
ORDER BY rt.emp_no ASC, rt.to_date DESC;


SELECT SUM(salary) AS "Total Salaries Retired"
FROM unique_retirement_salaries;
