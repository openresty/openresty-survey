create table user_survey (
    id serial primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    country varchar(125) not null,
    city varchar(35) not null,
    email varchar(255) not null unique,
    homepage varchar(2038),
    github varchar(40),
    twitter varchar(40),
    weibo varchar(40),
    company varchar(50),
    company_url varchar(2038),
    job_title varchar(30),
    department varchar(30),
    logo varchar(2038),
    typical_uses varchar(2048),
    dev_count integer,
    traffic varchar(50),
    prod tinyint,
    fun tinyint,
    extern tinyint,
    intern tinyint,
    show_logo tinyint,
    subscribed tinyint,
    will_tell tinyint,
    client_addr varchar(45) not null,
    inserted datetime not null
)
engine = InnoDB
default character set = utf8
collate = utf8_bin;
