Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA273DE54D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 06:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhHCE0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 00:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233650AbhHCEYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 00:24:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 219376112F;
        Tue,  3 Aug 2021 04:23:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@rostedt.homelinux.com>)
        id 1mAly8-002qnj-2j; Tue, 03 Aug 2021 00:23:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH v2 15/21] libtracefs: Add error message for bad filters in SQL statement
Date:   Tue,  3 Aug 2021 00:23:41 -0400
Message-Id: <20210803042347.679499-16-rostedt@goodmis.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210803042347.679499-1-rostedt@goodmis.org>
References: <20210803042347.679499-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If a filter has a bad event, or incompatibility with the value assigned to
it, have the error message display it.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 src/tracefs-sqlhist.c | 80 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 6 deletions(-)

diff --git a/src/tracefs-sqlhist.c b/src/tracefs-sqlhist.c
index 1767c33d77d0..f191661610c9 100644
--- a/src/tracefs-sqlhist.c
+++ b/src/tracefs-sqlhist.c
@@ -792,14 +792,80 @@ static int verify_filter(struct sqlhist_bison *sb, struct filter *filter,
 	}
 }
 
-static int build_filter(struct tracefs_synth *synth,
-			bool start, struct filter *filter, bool *started)
+static int test_field_exists(struct tep_handle *tep, struct sqlhist_bison *sb,
+			     struct expr *expr);
+
+static void filter_compare_error(struct tep_handle *tep,
+				 struct sqlhist_bison *sb,
+				 struct expr *expr)
+{
+	struct field *field = &expr->field;
+
+	switch (errno) {
+	case ENODEV:
+	case EBADE:
+		break;
+	case EINVAL:
+		parse_error(sb, field->raw, "Invalid compare\n");
+		break;
+	default:
+		parse_error(sb, field->raw, "System error?\n");
+		return;
+	}
+
+	/* ENODEV means that an event or field does not exist */
+	if (errno == ENODEV) {
+		if (test_field_exists(tep, sb, expr))
+			return;
+		if (test_field_exists(tep, sb, expr))
+			return;
+		return;
+	}
+
+	/* fields exist, but values are not compatible */
+	sb->line_no = expr->line;
+	sb->line_idx = expr->idx;
+
+	parse_error(sb, field->raw,
+		    "Field '%s' is not compatible to be compared with the given value\n",
+		    field->field);
+}
+
+static void filter_error(struct tep_handle *tep,
+			 struct sqlhist_bison *sb, struct expr *expr)
+{
+	struct filter *filter = &expr->filter;
+
+	sb->line_no = expr->line;
+	sb->line_idx = expr->idx;
+
+	switch (filter->type) {
+	case FILTER_NOT_GROUP:
+	case FILTER_GROUP:
+	case FILTER_OR:
+	case FILTER_AND:
+		break;
+	default:
+		filter_compare_error(tep, sb, filter->lval);
+		return;
+	}
+
+	sb->line_no = expr->line;
+	sb->line_idx = expr->idx;
+
+	parse_error(sb, "", "Problem with filter entry?\n");
+}
+
+static int build_filter(struct tep_handle *tep, struct sqlhist_bison *sb,
+			struct tracefs_synth *synth,
+			bool start, struct expr *expr, bool *started)
 {
 	int (*append_filter)(struct tracefs_synth *synth,
 			     enum tracefs_filter type,
 			     const char *field,
 			     enum tracefs_compare compare,
 			     const char *val);
+	struct filter *filter = &expr->filter;
 	enum tracefs_compare cmp;
 	const char *val;
 	int and_or = TRACEFS_FILTER_AND;
@@ -829,7 +895,7 @@ static int build_filter(struct tracefs_synth *synth,
 				    NULL, 0, NULL);
 		if (ret < 0)
 			goto out;
-		ret = build_filter(synth, start, &filter->lval->filter, NULL);
+		ret = build_filter(tep, sb, synth, start, filter->lval, NULL);
 		if (ret < 0)
 			goto out;
 		ret = append_filter(synth, TRACEFS_FILTER_CLOSE_PAREN,
@@ -840,14 +906,14 @@ static int build_filter(struct tracefs_synth *synth,
 		and_or = TRACEFS_FILTER_OR;
 		/* Fall through */
 	case FILTER_AND:
-		ret = build_filter(synth, start, &filter->lval->filter, NULL);
+		ret = build_filter(tep, sb, synth, start, filter->lval, NULL);
 		if (ret < 0)
 			goto out;
 		ret = append_filter(synth, and_or, NULL, 0, NULL);
 
 		if (ret)
 			goto out;
-		ret = build_filter(synth, start, &filter->rval->filter, NULL);
+		ret = build_filter(tep, sb, synth, start, filter->rval, NULL);
 		goto out;
 	default:
 		break;
@@ -881,6 +947,8 @@ static int build_filter(struct tracefs_synth *synth,
 	ret = append_filter(synth, TRACEFS_FILTER_COMPARE,
 			    filter->lval->field.field, cmp, val);
 
+	if (ret)
+		filter_error(tep, sb, expr);
  out:
 	if (!ret && started) {
 		if (*started)
@@ -1145,7 +1213,7 @@ static struct tracefs_synth *build_synth(struct tep_handle *tep,
 		else
 			started = &started_end;
 
-		ret = build_filter(synth, start, &expr->filter, started);
+		ret = build_filter(tep, table->sb, synth, start, expr, started);
 		if (ret < 0)
 			goto free;
 	}
-- 
2.30.2

