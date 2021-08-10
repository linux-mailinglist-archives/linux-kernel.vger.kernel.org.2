Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCEA3DE53E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 06:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhHCEZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 00:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233684AbhHCEYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 00:24:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BE1A61107;
        Tue,  3 Aug 2021 04:23:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@rostedt.homelinux.com>)
        id 1mAly7-002qnX-VY; Tue, 03 Aug 2021 00:23:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH v2 11/21] libtracefs: Add error message when match or init fails from bad events
Date:   Tue,  3 Aug 2021 00:23:37 -0400
Message-Id: <20210803042347.679499-12-rostedt@goodmis.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210803042347.679499-1-rostedt@goodmis.org>
References: <20210803042347.679499-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If the tracefs_synth_init() or the matching fails due to events that do
not exist, or if the match fields are not compatible with each other. Add
an error message that reports this and where the problem is.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 src/tracefs-sqlhist.c | 101 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/src/tracefs-sqlhist.c b/src/tracefs-sqlhist.c
index 0489657bea03..d39851845570 100644
--- a/src/tracefs-sqlhist.c
+++ b/src/tracefs-sqlhist.c
@@ -876,6 +876,101 @@ static int build_filter(struct tracefs_synth *synth,
 	return ret;
 }
 
+static int test_event_exists(struct tep_handle *tep, struct sqlhist_bison *sb,
+			     struct expr *expr, struct tep_event **pevent)
+{
+	const char *system = expr->field.system;
+	const char *event_name = expr->field.event;
+	struct tep_event *event;
+
+	event = tep_find_event_by_name(tep, system, event_name);
+	if (pevent)
+		*pevent = event;
+	if (event)
+		return 0;
+
+	sb->line_no = expr->line;
+	sb->line_idx = expr->idx;
+
+	parse_error(sb, expr->field.raw, "event not found\n");
+	return -1;
+}
+
+static int test_field_exists(struct tep_handle *tep, struct sqlhist_bison *sb,
+			     struct expr *expr)
+{
+	struct tep_event *event;
+
+	if (test_event_exists(tep, sb, expr, &event))
+		return -1;
+
+	if (trace_verify_event_field(event, expr->field.field, NULL))
+		return 0;
+
+	sb->line_no = expr->line;
+	sb->line_idx = expr->idx;
+
+	parse_error(sb, expr->field.raw, "Field '%s' not part of event %s\n",
+		    expr->field.field, expr->field.event);
+	return -1;
+}
+
+static void *field_match_error(struct tep_handle *tep, struct sqlhist_bison *sb,
+			       struct match *match)
+{
+	switch (errno) {
+	case ENODEV:
+	case EBADE:
+		break;
+	default:
+		/* System error */
+		return NULL;
+	}
+
+	/* ENODEV means that an event or field does not exist */
+	if (errno == ENODEV) {
+		if (test_field_exists(tep, sb, match->lval))
+			return NULL;
+		if (test_field_exists(tep, sb, match->rval))
+			return NULL;
+		return NULL;
+	}
+
+	/* fields exist, but values are not compatible */
+	sb->line_no = match->lval->line;
+	sb->line_idx = match->lval->idx;
+
+	parse_error(sb, match->lval->field.raw,
+		    "Field '%s' is not compatible to match field '%s'\n",
+		    match->lval->field.raw, match->rval->field.raw);
+	return NULL;
+}
+
+static void *synth_init_error(struct tep_handle *tep, struct sql_table *table)
+{
+	struct sqlhist_bison *sb = table->sb;
+	struct match *match = table->matches;
+
+	switch (errno) {
+	case ENODEV:
+	case EBADE:
+		break;
+	default:
+		/* System error */
+		return NULL;
+	}
+
+	/* ENODEV could mean that start or end events do not exist */
+	if (errno == ENODEV) {
+		if (test_event_exists(tep, sb, table->from, NULL))
+			return NULL;
+		if (test_event_exists(tep, sb, table->to, NULL))
+			return NULL;
+	}
+
+	return field_match_error(tep, sb, match);
+}
+
 static struct tracefs_synth *build_synth(struct tep_handle *tep,
 					 const char *name,
 					 struct sql_table *table)
@@ -926,7 +1021,7 @@ static struct tracefs_synth *build_synth(struct tep_handle *tep,
 				   start_event, end_system, end_event,
 				   start_match, end_match, NULL);
 	if (!synth)
-		return NULL;
+		return synth_init_error(tep, table);
 
 	for (match = match->next; match; match = match->next) {
 		ret = test_match(table, match);
@@ -939,8 +1034,10 @@ static struct tracefs_synth *build_synth(struct tep_handle *tep,
 		ret = tracefs_synth_add_match_field(synth,
 						    start_match,
 						    end_match, NULL);
-		if (ret < 0)
+		if (ret < 0) {
+			field_match_error(tep, table->sb, match);
 			goto free;
+		}
 	}
 
 	for (expr = table->selections; expr; expr = expr->next) {
-- 
2.30.2

