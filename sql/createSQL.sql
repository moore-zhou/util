-- 邮件表添加字段
alter table mail_send add column bcc_addr varchar(5000) default '' not null;

-- 创建序列
DROP TABLE IF EXISTS "public"."tbl_whitelist";
DROP SEQUENCE IF EXISTS "public"."tbl_whitelist_node_seq";
create sequence "public"."tbl_whitelist_node_seq"
minvalue 100
maxvalue 9223372036854775807
start with 100
increment by 1
CACHE 1;

-- 创建表（白名单表）
create table public.tbl_whitelist(
node_id int4 primary key DEFAULT nextval('tbl_whitelist_node_seq'::regclass) NOT NULL,
ip varchar(50) NOT NULL,
create_user varchar(50),
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

-- 创建表（白名单组）
create table public.tbl_whitelist_group(
group_id int4 primary key DEFAULT nextval('tbl_whitelist_group_id_seq'::regclass) NOT NULL,
group_name varchar(64) NOT NULL,
create_user varchar(64),
describe text,
create_time int8 NOT NULL,
update_time int8 NOT NULL,
group_class int4 NOT NULL,
is_enabled bool DEFAULT false
);

-- 创建表（组分类）
DROP TABLE IF EXISTS "public"."tbl_whitelist_group_class";
create table public.tbl_whitelist_group_class(
group_class_id int4 primary key NOT NULL,
group_class_name varchar(64) NOT NULL,
create_user varchar(64),
describe text,
create_time int8,
update_time int8
);
insert into public.tbl_whitelist_group_class(group_class_id,group_class_name,create_user) values(1,'事件白名单','admin');
insert into public.tbl_whitelist_group_class(group_class_id,group_class_name,create_user) values(2,'封堵白名单','admin');

-- 创建关系表
DROP TABLE IF EXISTS "public"."whitelist_node";
create table public.whitelist_node(
node int4 not null,
group_node int4 not null,
availability CHAR(2) default 'N' check (availability in('Y','N')),
create_time int8 NOT NULL,
update_time int8 NOT NULL
);

-- 创建邮件内容操作表
DROP TABLE IF EXISTS "public"."send_mail_value";
create table public.send_mail_value(
id varchar(64) primary key NOT NULL,
value text NOT NULL,
count int4,
plug_ip text,
unplg_ip varchar(64),
time int4 NOT NULL,
start_time int8 NOT NULL,
start bool DEFAULT true,
alarm_id varchar(64),
event_start_time varchar(32),
event_end_time varchar(32),
to_user varchar(64),
cc varchar(64),
bcc varchar(64),
subject varchar(64),
mail_value text
);

-- 邮件发送内容 告警事件对应关系记录表
DROP TABLE IF EXISTS "public"."send_mail_value_evenid";
CREATE TABLE "public"."send_mail_value_evenid" (
"alarm_id" varchar(64) COLLATE "default" NOT NULL,
"event_id" varchar(64) COLLATE "default" NOT NULL,
"event_end_time" int8
)
WITH (OIDS=FALSE)
;
