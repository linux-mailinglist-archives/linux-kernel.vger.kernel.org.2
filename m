Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD313DE548
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 06:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbhHCE0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 00:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233726AbhHCEYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 00:24:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40D2461167;
        Tue,  3 Aug 2021 04:23:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@rostedt.homelinux.com>)
        id 1mAly8-002qns-5i; Tue, 03 Aug 2021 00:23:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Ahmed S . Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v2 18/21] libtracefs: Allow for simple SQL statements to create a histogram
Date:   Tue,  3 Aug 2021 00:23:44 -0400
Message-Id: <20210803042347.679499-19-rostedt@goodmis.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210803042347.679499-1-rostedt@goodmis.org>
References: <20210803042347.679499-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Allow tracefs_sql() to take a simple select statement without the
JOIN .. ON clause, that will simply update the start event. This, along
with tracefs_synth_get_start_hist(), will allow a user to utilize
tracefs_sql() to create a synthetic event.

Link: https://lore.kernel.org/linux-rt-users/YQakDYRnId+bK+ue@lx-t490/

Suggested-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/libtracefs-sql.txt |  27 +++++-
 include/tracefs-local.h          |   3 +
 src/sqlhist.y                    |  11 ++-
 src/tracefs-hist.c               |  60 +++++++++----
 src/tracefs-sqlhist.c            | 141 +++++++++++++++++++++++++++++--
 5 files changed, 212 insertions(+), 30 deletions(-)

diff --git a/Documentation/libtracefs-sql.txt b/Documentation/libtracefs-sql.txt
index 242e348a5bbf..190abe641d7c 100644
--- a/Documentation/libtracefs-sql.txt
+++ b/Documentation/libtracefs-sql.txt
@@ -32,6 +32,8 @@ to attach two events together and form another event (table). Utilizing the
 SQL *SELECT* *FROM* *JOIN* *ON* [ *WHERE* ] syntax, a synthetic event can easily
 be created from two different events.
 
+For simple SQL queries to make a histogram instead of a synthetic event, see
+HISTOGRAMS below.
 
 *tracefs_sql*() takes in a *tep* handler (See _tep_local_events_(3)) that is used to
 verify the events within the _sql_buffer_ expression. The _name_ is the name of the
@@ -160,6 +162,12 @@ select start.pid, (end.TIMESTAMP_USECS - start.TIMESTAMP_USECS) as lat from sche
    WHERE start.prio < 100 || end.prev_prio < 100
 --
 
+HISTOGRAMS
+----------
+
+Simple SQL statements without the *JOIN* *ON* may also be used, which will create a histogram
+instead. When doing this, the struct tracefs_hist descriptor can be retrieved from the
+returned synthetic event descriptor via the *tracefs_synth_get_start_hist*(3).
 
 RETURN VALUE
 ------------
@@ -243,9 +251,22 @@ static int do_sql(const char *buffer, const char *name,
 		exit(-1);
 	}
 
-	tracefs_synth_show(&seq, NULL, synth);
-	if (execute)
-		tracefs_synth_create(NULL, synth);
+	if (tracefs_synth_complete(synth)) {
+		tracefs_synth_show(&seq, NULL, synth);
+		if (execute)
+			tracefs_synth_create(NULL, synth);
+	} else {
+		struct tracefs_hist *hist;
+		hist = tracefs_synth_get_start_hist(synth);
+		if (!hist) {
+			perror("get_start_hist");
+			exit(-1);
+		}
+		tracefs_hist_show(&seq, NULL, hist, 0);
+		if (execute)
+			tracefs_hist_start(NULL, hist);
+	}
+
 	tracefs_synth_free(synth);
 
 	trace_seq_do_printf(&seq);
diff --git a/include/tracefs-local.h b/include/tracefs-local.h
index 41fbcc0faa95..09288aeac521 100644
--- a/include/tracefs-local.h
+++ b/include/tracefs-local.h
@@ -85,4 +85,7 @@ int trace_append_filter(char **filter, unsigned int *state,
 			enum tracefs_compare compare,
 			 const char *val);
 
+struct tracefs_synth *synth_init_from(struct tep_handle *tep,
+				      const char *start_system,
+				      const char *start_event);
 #endif /* _TRACE_FS_LOCAL_H */
diff --git a/src/sqlhist.y b/src/sqlhist.y
index 9d03a457ae84..d5cbecc7bf92 100644
--- a/src/sqlhist.y
+++ b/src/sqlhist.y
@@ -63,7 +63,7 @@ extern void yyerror(struct sqlhist_bison *, char *fmt, ...);
 
 %type <string> name label
 
-%type <expr>  selection_expr field item named_field join_clause
+%type <expr>  selection_expr field item named_field
 %type <expr>  selection_addition
 %type <expr>  compare compare_list compare_cmds compare_items
 %type <expr>  compare_and_or
@@ -202,8 +202,13 @@ opt_where_clause :
  | where_clause
 ;
 
+opt_join_clause :
+  /* empty set */
+  | join_clause
+ ;
+
 table_exp :
-   from_clause join_clause opt_where_clause
+   from_clause opt_join_clause opt_where_clause
  ;
 
 from_clause :
@@ -222,7 +227,7 @@ from_clause :
  ;
 
 join_clause :
-  JOIN item ON match_clause	{ add_to(sb, $2); }
+ JOIN item ON match_clause	{ add_to(sb, $2); }
  ;
 
 match :
diff --git a/src/tracefs-hist.c b/src/tracefs-hist.c
index 0605e1fe600e..f6f7149b07d4 100644
--- a/src/tracefs-hist.c
+++ b/src/tracefs-hist.c
@@ -724,6 +724,33 @@ static int add_var(char ***list, const char *name, const char *var, bool is_var)
 	return 0;
 }
 
+__hidden struct tracefs_synth *
+synth_init_from(struct tep_handle *tep, const char *start_system,
+		const char *start_event_name)
+{
+	struct tep_event *start_event;
+	struct tracefs_synth *synth;
+
+	start_event = tep_find_event_by_name(tep, start_system,
+					     start_event_name);
+	if (!start_event) {
+		errno = ENODEV;
+		return NULL;
+	}
+
+	synth = calloc(1, sizeof(*synth));
+	if (!synth)
+		return NULL;
+
+	synth->start_event = start_event;
+
+	/* Hold onto a reference to this handler */
+	tep_ref(tep);
+	synth->tep = tep;
+
+	return synth;
+}
+
 /**
  * tracefs_synth_init - create a new tracefs_synth instance
  * @tep: The tep handle that holds the events to work on
@@ -778,7 +805,6 @@ struct tracefs_synth *tracefs_synth_init(struct tep_handle *tep,
 					 const char *end_match_field,
 					 const char *match_name)
 {
-	struct tep_event *start_event;
 	struct tep_event *end_event;
 	struct tracefs_synth *synth;
 	int ret = 0;
@@ -789,25 +815,18 @@ struct tracefs_synth *tracefs_synth_init(struct tep_handle *tep,
 		return NULL;
 	}
 
-	start_event = tep_find_event_by_name(tep, start_system,
-					     start_event_name);
-	if (!start_event) {
-		errno = ENODEV;
+	synth = synth_init_from(tep, start_system, start_event_name);
+	if (!synth)
 		return NULL;
-	}
 
 	end_event = tep_find_event_by_name(tep, end_system,
 					   end_event_name);
 	if (!end_event) {
+		tep_unref(tep);
 		errno = ENODEV;
 		return NULL;
 	}
 
-	synth = calloc(1, sizeof(*synth));
-	if (!synth)
-		return NULL;
-
-	synth->start_event = start_event;
 	synth->end_event = end_event;
 
 	synth->name = strdup(name);
@@ -815,10 +834,6 @@ struct tracefs_synth *tracefs_synth_init(struct tep_handle *tep,
 	ret = tracefs_synth_add_match_field(synth, start_match_field,
 					    end_match_field, match_name);
 
-	/* Hold onto a reference to this handler */
-	tep_ref(tep);
-	synth->tep = tep;
-
 	if (!synth->name || !synth->start_keys || !synth->end_keys || ret) {
 		tracefs_synth_free(synth);
 		synth = NULL;
@@ -1457,6 +1472,11 @@ int tracefs_synth_create(struct tracefs_instance *instance,
 		return -1;
 	}
 
+	if (!synth->name || !synth->end_event) {
+		errno = EUNATCH;
+		return -1;
+	}
+
 	if (verify_state(synth) < 0)
 		return -1;
 
@@ -1539,6 +1559,11 @@ int tracefs_synth_destroy(struct tracefs_instance *instance,
 		return -1;
 	}
 
+	if (!synth->name || !synth->end_event) {
+		errno = EUNATCH;
+		return -1;
+	}
+
 	/* Try to disable the event if possible */
 	tracefs_event_disable(instance, "synthetic", synth->name);
 
@@ -1595,6 +1620,11 @@ int tracefs_synth_show(struct trace_seq *seq,
 		return -1;
 	}
 
+	if (!synth->name || !synth->end_event) {
+		errno = EUNATCH;
+		return -1;
+	}
+
 	synthetic_event = create_synthetic_event(synth);
 	if (!synthetic_event)
 		return -1;
diff --git a/src/tracefs-sqlhist.c b/src/tracefs-sqlhist.c
index c27f7478a527..c4514409645c 100644
--- a/src/tracefs-sqlhist.c
+++ b/src/tracefs-sqlhist.c
@@ -591,6 +591,69 @@ static int update_vars(struct sql_table *table, struct field *event)
 	return 0;
 }
 
+/*
+ * Called when there's a FROM but no JOIN(to), which means that the
+ * selections can be fields and not mention the event itself.
+ */
+static int update_fields(struct tep_handle *tep,
+			 struct sql_table *table, struct field *event_field)
+{
+	struct sqlhist_bison *sb = table->sb;
+	struct tep_format_field *tfield;
+	struct tep_event *event;
+	struct expr *expr;
+	struct field *field;
+	const char *p;
+	int len;
+
+	/* First update fields with aliases an such */
+	update_vars(table, event_field);
+
+	/* The update_vars already updated event->system and event->event */
+	event = tep_find_event_by_name(tep, event_field->system,
+				       event_field->event);
+	/*
+	 * If event is not found, the creation of the synth will
+	 * add a proper error, so return "success".
+	*/
+	if (!event)
+		return 0;
+
+	for_each_field(expr, field, table) {
+		const char *field_name;
+
+		field = &expr->field;
+
+		if (field->event)
+			continue;
+
+		field_name = field->raw;
+
+		p = strchr(field_name, '.');
+		if (p) {
+			len = p - field_name;
+			p = strndup(field_name, len);
+			if (!p)
+				return -1;
+			field_name = store_str(sb, p);
+			if (!field_name)
+				return -1;
+			free((char *)p);
+		}
+
+		tfield = tep_find_any_field(event, field_name);
+		/* Let it error properly later */
+		if (!tfield)
+			continue;
+
+		field->system = event_field->system;
+		field->event = event_field->event;
+		field->field = field_name;
+	}
+
+	return 0;
+}
+
 static int match_error(struct sqlhist_bison *sb, struct match *match,
 		       struct field *lmatch, struct field *rmatch)
 {
@@ -1105,6 +1168,42 @@ static void compare_error(struct tep_handle *tep,
 		    compare->lval->field.raw, compare->rval->field.raw);
 }
 
+static void compare_no_to_error(struct sqlhist_bison *sb, struct expr *expr)
+{
+	struct compare *compare = &expr->compare;
+
+	sb->line_no = compare->lval->line;
+	sb->line_idx = compare->lval->idx;
+
+	parse_error(sb, compare->lval->field.raw,
+		    "Simple SQL (without JOIN/ON) do not allow comparisons\n",
+		    compare->lval->field.raw, compare->rval->field.raw);
+}
+
+static void where_no_to_error(struct sqlhist_bison *sb, struct expr *expr,
+			      const char *from_event, const char *event)
+{
+	while (expr) {
+		switch (expr->filter.type) {
+		case FILTER_OR:
+		case FILTER_AND:
+		case FILTER_GROUP:
+		case FILTER_NOT_GROUP:
+			expr = expr->filter.lval;
+			continue;
+		default:
+			break;
+		}
+		break;
+	}
+	sb->line_no = expr->filter.lval->line;
+	sb->line_idx = expr->filter.lval->idx;
+
+	parse_error(sb, expr->filter.lval->field.raw,
+		    "Event '%s' does not match FROM event '%s'\n",
+		    event, from_event);
+}
+
 static struct tracefs_synth *build_synth(struct tep_handle *tep,
 					 const char *name,
 					 struct sql_table *table)
@@ -1123,17 +1222,31 @@ static struct tracefs_synth *build_synth(struct tep_handle *tep,
 	bool started_end = false;
 	int ret;
 
-	if (!table->to || !table->from)
+	if (!table->from)
 		return NULL;
 
-	ret = update_vars(table, &table->to->field);
-	if (ret < 0)
-		return NULL;
+	/* This could be a simple SQL statement to only build a histogram */
+	if (!table->to) {
+		ret = update_fields(tep, table, &table->from->field);
+		if (ret < 0)
+			return NULL;
+
+		start_system = table->from->field.system;
+		start_event = table->from->field.event;
+
+		synth = synth_init_from(tep, start_system, start_event);
+		if (!synth)
+			return synth_init_error(tep, table);
+		goto hist_only;
+	}
 
 	ret = update_vars(table, &table->from->field);
 	if (ret < 0)
 		return NULL;
 
+	start_system = table->from->field.system;
+	start_event = table->from->field.event;
+
 	match = table->matches;
 	if (!match)
 		return NULL;
@@ -1142,9 +1255,6 @@ static struct tracefs_synth *build_synth(struct tep_handle *tep,
 	if (ret < 0)
 		return NULL;
 
-	start_system = table->from->field.system;
-	start_event = table->from->field.event;
-
 	end_system = table->to->field.system;
 	end_event = table->to->field.event;
 
@@ -1174,14 +1284,18 @@ static struct tracefs_synth *build_synth(struct tep_handle *tep,
 		}
 	}
 
+ hist_only:
+	/* table->to may be NULL here */
+
 	for (expr = table->selections; expr; expr = expr->next) {
 		if (expr->type == EXPR_FIELD) {
+			ret = -1;
 			field = &expr->field;
 			if (field->system == start_system &&
 			    field->event == start_event) {
 				ret = tracefs_synth_add_start_field(synth,
 						field->field, field->label);
-			} else {
+			} else if (table->to) {
 				ret = tracefs_synth_add_end_field(synth,
 						field->field, field->label);
 			}
@@ -1192,6 +1306,11 @@ static struct tracefs_synth *build_synth(struct tep_handle *tep,
 			continue;
 		}
 
+		if (!table->to) {
+			compare_no_to_error(table->sb, expr);
+			goto free;
+		}
+
 		if (expr->type != EXPR_COMPARE)
 			goto free;
 
@@ -1219,7 +1338,11 @@ static struct tracefs_synth *build_synth(struct tep_handle *tep,
 
 		if (start)
 			started = &started_start;
-		else
+		else if (!table->to) {
+			where_no_to_error(table->sb, expr, start_event,
+					  filter_event);
+			goto free;
+		} else
 			started = &started_end;
 
 		ret = build_filter(tep, table->sb, synth, start, expr, started);
-- 
2.30.2

