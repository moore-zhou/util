DROP TABLE IF EXISTS "public"."whitelist_node";

-- 创建序列
DROP TABLE IF EXISTS "public"."tbl_whitelist";
DROP SEQUENCE IF EXISTS "public"."tbl_whitelist_node_seq";
create sequence "public"."tbl_whitelist_node_seq"
minvalue 1000
maxvalue 9223372036854775807
start with 1000
increment by 1
CACHE 1;

-- 创建表（白名单ip表）
create table public.tbl_whitelist(
node_id int4 primary key DEFAULT nextval('tbl_whitelist_node_seq'::regclass) NOT NULL,
ip varchar(64) NOT NULL,
group_id int4 NOT NULL,
group_name varchar(64),
group_type varchar(32),
create_user varchar(64),
create_time int8 NOT NULL,
update_time int8 NOT NULL
);

-- 创建序列
DROP TABLE IF EXISTS "public"."tbl_whitelist_group";
DROP SEQUENCE IF EXISTS "public"."tbl_whitelist_group_id_seq";
create sequence public.tbl_whitelist_group_id_seq
minvalue 1
maxvalue 9223372036854775807
start with 1
increment by 1
CACHE 1;

-- 创建表（白名单）
create table public.tbl_whitelist_group(
group_id int4 primary key DEFAULT nextval('tbl_whitelist_group_id_seq'::regclass) NOT NULL,
group_name varchar(64) NOT NULL,
group_type varchar(32) NOT NULL,
ip_list text,
ip_count int4,
is_enable bool DEFAULT false,
event_rule text,
closure_strategy text,
create_user varchar(64),
create_time int8 NOT NULL,
update_time int8 NOT NULL,
describe text
);