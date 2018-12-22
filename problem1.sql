--[Part a]

SELECT DISTINCT p.pid, p.pname, p.color
FROM parts p 
WHERE NOT EXISTS (
	SELECT *
	FROM suppliers s
	WHERE NOT EXISTS (
		SELECT *
		FROM catalog c
		WHERE c.sid = s.sid AND c.pid = p.pid
		)
);

--[Part b]

SELECT DISTINCT p.pid, p.pname, p.color
FROM suppliers s, parts p, catalog c
WHERE s.sname LIKE 'A%' AND p.pid = c.pid AND c.sid = s.sid
MINUS
SELECT DISTINCT p.pid, p.pname, p.color
FROM suppliers s, parts p, catalog c
WHERE s.sname NOT LIKE 'A%' AND p.pid = c.pid AND c.sid = s.sid;

--[Part c]

SELECT DISTINCT e.eid, e.salary
FROM employees e
WHERE NOT EXISTS ((SELECT a.aid 
	FROM aircraft a 
	WHERE a.cruisingrange < 2000
)
MINUS
SELECT c.aid
FROM certified c
WHERE c.eid = e.eid
);

--[Part d]

SELECT DISTINCT e.eid, MAX(e.salary)
FROM employees e
WHERE NOT EXISTS ((SELECT a.aid 
	FROM aircraft a 
	WHERE a.cruisingrange < 2000
)
MINUS
SELECT c.aid
FROM certified c
WHERE c.eid = e.eid
)
GROUP BY e.eid
HAVING MAX(e.salary) = (SELECT DISTINCT MAX(e.salary)
	FROM employees e
	);
