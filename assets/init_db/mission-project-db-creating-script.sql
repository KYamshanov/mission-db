DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS participants CASCADE;
DROP TABLE IF EXISTS stage_history CASCADE;


DROP TYPE IF EXISTS participants_role;
DROP TYPE IF EXISTS project_stage;

CREATE TABLE projects
(
    id          VARCHAR(50) PRIMARY KEY,
    title       VARCHAR(50) NOT NULL,
    description TEXT        NOT NULL
);

CREATE TYPE participants_role AS ENUM ('LEADER', 'MENTOR');
CREATE TYPE project_stage AS ENUM ('CREATED', 'CANCELED', 'PREPARING','RESEARCH', 'DEVELOP', 'FINISHING');
CREATE TYPE subtasks_stage AS ENUM ('CREATED', 'IN_WORK', 'FINISHED');

CREATE TABLE participants(
    id               VARCHAR(50) PRIMARY KEY,
    project_id       VARCHAR(50)       NOT NULL REFERENCES projects (id),
    external_user_id VARCHAR(50)       NOT NULL,
    participant_role participants_role NULL DEFAULT null
);

CREATE TABLE stage_history(
    id         VARCHAR(50) PRIMARY KEY,
    project_id VARCHAR(50)   NOT NULL REFERENCES projects (id),
    stage      project_stage not null,
    updatedAt  TIMESTAMPTZ   not null
);

CREATE TABLE tasks(
    id VARCHAR(50) PRIMARY KEY,
    project_id VARCHAR(50) NOT NULL REFERENCES projects (id),
    title VARCHAR(64) NOT NULL,
    text TEXT NOT NULL,
    create_at  TIMESTAMPTZ not null,
    start_at TIMESTAMPTZ not null,
    end_at TIMESTAMPTZ not null,
    max_points INTEGER NOT NULL,
    points INTEGER NOT NULL
);

CREATE TABLE subtasks(
    id VARCHAR(50) PRIMARY KEY,
    task_id VARCHAR(50) NOT NULL REFERENCES tasks (id),
    title VARCHAR(64) NOT NULL,
    text TEXT NOT NULL,
    create_at  TIMESTAMPTZ not null,
    start_at TIMESTAMPTZ not null,
    end_at TIMESTAMPTZ not null,
    responsible VARCHAR(50) NOT NULL,
    stage subtasks_stage NOT NULL,
    execution_result TEXT DEFAULT NULL
);

