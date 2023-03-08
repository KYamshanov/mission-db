/**
  Скрипт для создания таблиц mission-id
 */
DROP TABLE IF EXISTS mission_id_table CASCADE;


CREATE TABLE mission_id_table
(
    id                VARCHAR(50) PRIMARY KEY,
    external_id       VARCHAR(50) NOT NULL,
    internal_id       VARCHAR(50) NOT NULL,
    auth_system       VARCHAR(10) NOT NULL
);