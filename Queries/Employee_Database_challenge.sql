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
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
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
FROM employees AS e
--INTO mentorship_eligibilty
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no ASC;