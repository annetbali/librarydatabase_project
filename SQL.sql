-- Table: public.authors

-- DROP TABLE IF EXISTS public.authors;

CREATE TABLE IF NOT EXISTS public.authors
(
    author_id bigint NOT NULL DEFAULT nextval('authors_author_id_seq'::regclass),
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    email_address character varying(255) COLLATE pg_catalog."default" NOT NULL,
    bio character varying(255) COLLATE pg_catalog."default" NOT NULL,
    contact bigint NOT NULL,
    company_id bigint NOT NULL DEFAULT nextval('authors_company_id_seq'::regclass),
    CONSTRAINT authors_pkey PRIMARY KEY (author_id),
    CONSTRAINT authors_fkey FOREIGN KEY (company_id)
        REFERENCES public.publishing_companies (company_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.authors
    OWNER to postgres;
-- Table: public.book_status

-- DROP TABLE IF EXISTS public.book_status;

CREATE TABLE IF NOT EXISTS public.book_status
(
    book_status_id bigint NOT NULL DEFAULT nextval('book_status_book_status_id_seq'::regclass),
    borrow character varying(255) COLLATE pg_catalog."default" NOT NULL,
    shift_id bigint NOT NULL DEFAULT nextval('book_status_shift_id_seq'::regclass),
    student_id bigint NOT NULL DEFAULT nextval('book_status_student_id_seq'::regclass),
    CONSTRAINT book_status_pkey PRIMARY KEY (book_status_id),
    CONSTRAINT book_status_fkey FOREIGN KEY (student_id)
        REFERENCES public.students (student_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.book_status
    OWNER to postgres;
-- Table: public.books

-- DROP TABLE IF EXISTS public.books;

CREATE TABLE IF NOT EXISTS public.books
(
    title character varying(255) COLLATE pg_catalog."default" NOT NULL,
    price integer NOT NULL,
    description text COLLATE pg_catalog."default" NOT NULL,
    publish_date date NOT NULL,
    publish_year integer NOT NULL,
    isbn_number integer NOT NULL,
    image bytea NOT NULL,
    author_id bigint NOT NULL DEFAULT nextval('books_author_id_seq'::regclass),
    book_id bigint NOT NULL DEFAULT nextval('books_book_id_seq'::regclass),
    company_id bigint NOT NULL,
    CONSTRAINT books_pkey PRIMARY KEY (book_id),
    CONSTRAINT title UNIQUE (title),
    CONSTRAINT books_fkey FOREIGN KEY (author_id)
        REFERENCES public.authors (author_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.books
    OWNER to postgres;
-- Table: public.librarians

-- DROP TABLE IF EXISTS public.librarians;

CREATE TABLE IF NOT EXISTS public.librarians
(
    librarian_id bigint NOT NULL DEFAULT nextval('librarians_librarian_id_seq'::regclass),
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    email_address character varying(255) COLLATE pg_catalog."default" NOT NULL,
    telephone_number integer NOT NULL,
    shift_id bigint NOT NULL DEFAULT nextval('librarians_shift_id_seq'::regclass),
    CONSTRAINT librarians_pkey PRIMARY KEY (librarian_id),
    CONSTRAINT email_address UNIQUE (email_address),
    CONSTRAINT telephone_number UNIQUE (telephone_number),
    CONSTRAINT librarians_fkey FOREIGN KEY (shift_id)
        REFERENCES public.shifts (shift_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.librarians
    OWNER to postgres;
-- Table: public.shifts

-- DROP TABLE IF EXISTS public.shifts;

CREATE TABLE IF NOT EXISTS public.shifts
(
    shift_id bigint NOT NULL DEFAULT nextval('shifts_shift_id_seq'::regclass),
    mornig_shift character varying(25) COLLATE pg_catalog."default" NOT NULL,
    evening_shift character varying(25) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT shifts_pkey PRIMARY KEY (shift_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.shifts
    OWNER to postgres;
-- Table: public.publishing_companies

-- DROP TABLE IF EXISTS public.publishing_companies;

CREATE TABLE IF NOT EXISTS public.publishing_companies
(
    company_id bigint NOT NULL DEFAULT nextval('publishing_companies_company_id_seq'::regclass),
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    location character varying(255) COLLATE pg_catalog."default" NOT NULL,
    address character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT publishing_companies_pkey PRIMARY KEY (company_id),
	CONSTRAINT publishing_companies_fkey FOREIGN KEY (book_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.publishing_companies
    OWNER to postgres;
-- Table: public.students

-- DROP TABLE IF EXISTS public.students;

CREATE TABLE IF NOT EXISTS public.students
(
    student_id bigint NOT NULL DEFAULT nextval('students_student_id_seq'::regclass),
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    contact integer NOT NULL,
    address character varying(255) COLLATE pg_catalog."default" NOT NULL,
    date_of_borrowing date NOT NULL,
    date_of_return date NOT NULL,
    book_id bigint NOT NULL DEFAULT nextval('students_book_id_seq'::regclass),
    CONSTRAINT students_pkey PRIMARY KEY (student_id),
    CONSTRAINT contact UNIQUE (contact),
    CONSTRAINT students_fkey FOREIGN KEY (book_id)
        REFERENCES public.books (book_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.students
    OWNER to postgres;