Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75573DE50B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 06:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhHCEYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 00:24:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231966AbhHCEYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 00:24:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD32D6104F;
        Tue,  3 Aug 2021 04:23:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@rostedt.homelinux.com>)
        id 1mAly7-002qn7-Nw; Tue, 03 Aug 2021 00:23:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH v2 03/21] libtracefs: Add comparing start and end fields in tracefs_sql()
Date:   Tue,  3 Aug 2021 00:23:29 -0400
Message-Id: <20210803042347.679499-4-rostedt@goodmis.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210803042347.679499-1-rostedt@goodmis.org>
References: <20210803042347.679499-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add comparing a field and showing the differences between start and end
for tracefs_sql().

For example:

  SELECT (end.common_timestamp.usecs - start.common_timestamp.usecs) AS
    lat FROM sched_waking AS start JOIN sched_switch AS end ON
    start.pid = stop.next_pid

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 src/sqlhist-parse.h   |  1 +
 src/sqlhist.y         | 16 ++++++++
 src/tracefs-sqlhist.c | 85 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/src/sqlhist-parse.h b/src/sqlhist-parse.h
index aa5232eea451..aeb1738d693f 100644
--- a/src/sqlhist-parse.h
+++ b/src/sqlhist-parse.h
@@ -58,6 +58,7 @@ int table_start(struct sqlhist_bison *sb);
 void *add_field(struct sqlhist_bison *sb, const char *field, const char *label);
 
 int add_match(struct sqlhist_bison *sb, void *A, void *B);
+void *add_compare(struct sqlhist_bison *sb, void *A, void *B, enum compare_type type);
 
 int add_selection(struct sqlhist_bison *sb, void *item, const char *label);
 int add_from(struct sqlhist_bison *sb, void *item);
diff --git a/src/sqlhist.y b/src/sqlhist.y
index ecb0a0ed44b3..1ba3bf62ee43 100644
--- a/src/sqlhist.y
+++ b/src/sqlhist.y
@@ -48,6 +48,7 @@ extern void yyerror(char *fmt, ...);
 %type <string> name label
 
 %type <expr>  selection_expr field item named_field join_clause
+%type <expr>  selection_addition
 
 %%
 
@@ -85,6 +86,21 @@ selection :
 selection_expr :
    field
  | '(' field ')'		{  $$ = $2; }
+ | selection_addition
+ | '(' selection_addition ')'	{  $$ = $2; }
+ ;
+
+selection_addition :
+   field '+' field
+				{
+					$$ = add_compare(sb, $1, $3, COMPARE_ADD);
+					CHECK_RETURN_PTR($$);
+				}
+ | field '-' field
+				{
+					$$ = add_compare(sb, $1, $3, COMPARE_SUB);
+					CHECK_RETURN_PTR($$);
+				}
  ;
 
 item :
diff --git a/src/tracefs-sqlhist.c b/src/tracefs-sqlhist.c
index 7ec0c11b902e..cf2661773679 100644
--- a/src/tracefs-sqlhist.c
+++ b/src/tracefs-sqlhist.c
@@ -42,17 +42,32 @@ struct field {
 	const char		*field;
 };
 
+struct filter {
+	enum filter_type	type;
+	struct expr		*lval;
+	struct expr		*rval;
+};
+
 struct match {
 	struct match		*next;
 	struct expr		*lval;
 	struct expr		*rval;
 };
 
+struct compare {
+	enum compare_type	type;
+	struct expr		*lval;
+	struct expr		*rval;
+	const char		*name;
+};
+
 enum expr_type
 {
 	EXPR_NUMBER,
 	EXPR_STRING,
 	EXPR_FIELD,
+	EXPR_FILTER,
+	EXPR_COMPARE,
 };
 
 struct expr {
@@ -61,6 +76,8 @@ struct expr {
 	enum expr_type		type;
 	union {
 		struct field	field;
+		struct filter	filter;
+		struct compare	compare;
 		const char	*string;
 		long		number;
 	};
@@ -209,8 +226,14 @@ __hidden int add_selection(struct sqlhist_bison *sb, void *select,
 	switch (expr->type) {
 	case EXPR_FIELD:
 		break;
+	case EXPR_COMPARE:
+		if (!name)
+			return -1;
+		expr->compare.name = name;
+		break;
 	case EXPR_NUMBER:
 	case EXPR_STRING:
+	case EXPR_FILTER:
 	default:
 		return -1;
 	}
@@ -277,8 +300,10 @@ static void *create_expr(enum expr_type type, struct expr **expr_p)
 
 	switch (type) {
 	case EXPR_FIELD:	return &expr->field;
+	case EXPR_COMPARE:	return &expr->compare;
 	case EXPR_NUMBER:	return &expr->number;
 	case EXPR_STRING:	return &expr->string;
+	case EXPR_FILTER:	return &expr->filter;
 	}
 
 	return NULL;
@@ -292,6 +317,9 @@ static void *create_expr(enum expr_type type, struct expr **expr_p)
 #define create_field(var, expr)				\
 	__create_expr(var, struct field, FIELD, expr)
 
+#define create_compare(var, expr)				\
+	__create_expr(var, struct compare, COMPARE, expr)
+
 __hidden void *add_field(struct sqlhist_bison *sb,
 			 const char *field_name, const char *label)
 {
@@ -331,6 +359,21 @@ __hidden int add_match(struct sqlhist_bison *sb, void *A, void *B)
 
 	return 0;
 }
+__hidden void *add_compare(struct sqlhist_bison *sb,
+			   void *A, void *B, enum compare_type type)
+{
+	struct compare *compare;
+	struct expr *expr;
+
+	create_compare(compare, &expr);
+
+	compare = &expr->compare;
+	compare->lval = A;
+	compare->rval = B;
+	compare->type = type;
+
+	return expr;
+}
 
 __hidden int add_from(struct sqlhist_bison *sb, void *item)
 {
@@ -522,6 +565,39 @@ static void assign_match(const char *system, const char *event,
 	}
 }
 
+static int build_compare(struct tracefs_synth *synth,
+			 const char *system, const char *event,
+			 struct compare *compare)
+{
+	const char *start_field;
+	const char *end_field;
+	struct field *lval, *rval;
+	enum tracefs_synth_calc calc;
+	int ret;
+
+	lval = &compare->lval->field;
+	rval = &compare->rval->field;
+
+	if (lval->system == system &&
+	    lval->event == event) {
+		start_field = lval->field;
+		end_field = rval->field;
+		calc = TRACEFS_SYNTH_DELTA_START;
+	} else {
+		start_field = rval->field;
+		end_field = lval->field;
+		calc = TRACEFS_SYNTH_DELTA_END;
+	}
+
+	if (compare->type == COMPARE_ADD)
+		calc = TRACEFS_SYNTH_ADD;
+
+	ret = tracefs_synth_add_compare_field(synth, start_field,
+					      end_field, calc,
+					      compare->name);
+	return ret;
+}
+
 static struct tracefs_synth *build_synth(struct tep_handle *tep,
 					 const char *name,
 					 struct sql_table *table)
@@ -602,7 +678,14 @@ static struct tracefs_synth *build_synth(struct tep_handle *tep,
 				goto free;
 			continue;
 		}
-		goto free;
+
+		if (expr->type != EXPR_COMPARE)
+			goto free;
+
+		ret = build_compare(synth, start_system, end_system,
+				    &expr->compare);
+		if (ret < 0)
+			goto free;
 	}
 
 	return synth;
-- 
2.30.2

