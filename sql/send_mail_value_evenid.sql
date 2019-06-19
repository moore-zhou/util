
-- ----------------------------
-- Table structure for send_mail_value_evenid
-- ----------------------------
DROP TABLE IF EXISTS "public"."send_mail_value_evenid";
CREATE TABLE "public"."send_mail_value_evenid" (
"alarm_id" varchar(64) COLLATE "default" NOT NULL,
"event_id" varchar(64) COLLATE "default" NOT NULL,
"event_end_time" int8
)
WITH (OIDS=FALSE)
;

