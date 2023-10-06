use friendship;
-- 1) Consulta para obtener los usuarios con los nombres de sus amigos.
SELECT * FROM users u
LEFT JOIN friendships f ON u.id = f.user_id
LEFT JOIN users u2 ON f.friend_id = u2.id;
-- 2) Usuarios que son amigos de Kermit.
SELECT u.id, u.first_name, u.last_name
FROM users u
JOIN friendships f ON u.id = f.friend_id
JOIN users kermit ON f.user_id = kermit.id
WHERE kermit.first_name = 'Kermit';
-- 3) Recuento de todas las amistades.
SELECT COUNT(*) AS friendship_count
FROM friendships;
-- 4) Quién tiene más amigos y recuento de amigos.
SELECT u.id, u.first_name, u.last_name, COUNT(f.friend_id) AS friend_count
FROM users u
LEFT JOIN friendships f ON u.id = f.user_id
GROUP BY u.id
ORDER BY friend_count DESC
LIMIT 1;
-- 5) Crear un nuevo usuario y hacerlos amigos de Eli Byers, Kermit The Frog y Marky Mark.
INSERT INTO users (id, first_name, last_name, created_at, updated_at)
VALUES (100, 'Néstor', 'Larenas', NOW(), NOW());

INSERT INTO friendships (user_id, friend_id, created_at, updated_at)
VALUES (100, (SELECT id FROM users WHERE first_name = 'Eli' AND last_name = 'Byers'), NOW(), NOW());

INSERT INTO friendships (user_id, friend_id, created_at, updated_at)
VALUES (100, (SELECT id FROM users WHERE first_name = 'Kermit'), NOW(), NOW());

INSERT INTO friendships (user_id, friend_id, created_at, updated_at)
VALUES (100, (SELECT id FROM users WHERE first_name = 'Marky' AND last_name = 'Mark'), NOW(), NOW());
-- 6) Amigos de Eli en orden alfabético.
SELECT u.id, u.first_name, u.last_name
FROM users u
JOIN friendships f ON u.id = f.friend_id
JOIN users eli ON f.user_id = eli.id
WHERE eli.first_name = 'Eli'
ORDER BY u.last_name, u.first_name;
-- 7) Eliminar a Marky de los amigos de Eli
DELETE FROM friendships
WHERE user_id = (SELECT id FROM users WHERE first_name = 'Eli' AND last_name = 'Byers')
  AND friend_id = (SELECT id FROM users WHERE first_name = 'Marky' AND last_name = 'Mark');
-- 8) Todas las amistades, mostrando solo el nombre y apellido de ambos amigos
SELECT u1.first_name AS user1_first_name, u1.last_name AS user1_last_name,
       u2.first_name AS user2_first_name, u2.last_name AS user2_last_name
FROM friendships f
JOIN users u1 ON f.user_id = u1.id
JOIN users u2 ON f.friend_id = u2.id;
