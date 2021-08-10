Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8234E3DC0FD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhG3WTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232934AbhG3WSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:18:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8EA761074;
        Fri, 30 Jul 2021 22:18:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@rostedt.homelinux.com>)
        id 1m9apt-002V1k-Nf; Fri, 30 Jul 2021 18:18:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 14/17] libtracefs: Add error message when compare fields fail
Date:   Fri, 30 Jul 2021 18:18:21 -0400
Message-Id: <20210730221824.595597-15-rostedt@goodmis.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730221824.595597-1-rostedt@goodmis.org>
References: <20210730221824.595597-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If the processing of comparing fields fail due to not existing or because
they are not compatible to compare, report a proper error message.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 src/tracefs-sqlhist.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/src/tracefs-sqlhist.c b/src/tracefs-sqlhist.c
index e542eb95c17f..ff0869232a9e 100644
--- a/src/tracefs-sqlhist.c
+++ b/src/tracefs-sqlhist.c
@@ -981,6 +981,38 @@ static void selection_error(struct tep_handle *tep,
 	test_field_exists(tep, sb, expr);
 }
 
+static void compare_error(struct tep_handle *tep,
+			    struct sqlhist_bison *sb, struct expr *expr)
+{
+	struct compare *compare = &expr->compare;
+
+	switch (errno) {
+	case ENODEV:
+	case EBADE:
+		break;
+	default:
+		/* System error */
+		return;
+	}
+
+	/* ENODEV means that an event or field does not exist */
+	if (errno == ENODEV) {
+		if (test_field_exists(tep, sb, compare->lval))
+			return;
+		if (test_field_exists(tep, sb, compare->rval))
+			return;
+		return;
+	}
+
+	/* fields exist, but values are not compatible */
+	sb->line_no = compare->lval->line;
+	sb->line_idx = compare->lval->idx;
+
+	parse_error(sb, compare->lval->field.raw,
+		    "'%s' is not compatible to compare with '%s'\n",
+		    compare->lval->field.raw, compare->rval->field.raw);
+}
+
 static struct tracefs_synth *build_synth(struct tep_handle *tep,
 					 const char *name,
 					 struct sql_table *table)
@@ -1073,8 +1105,10 @@ static struct tracefs_synth *build_synth(struct tep_handle *tep,
 
 		ret = build_compare(synth, start_system, end_system,
 				    &expr->compare);
-		if (ret < 0)
+		if (ret < 0) {
+			compare_error(tep, table->sb, expr);
 			goto free;
+		}
 	}
 
 	for (expr = table->where; expr; expr = expr->next) {
-- 
2.30.2

