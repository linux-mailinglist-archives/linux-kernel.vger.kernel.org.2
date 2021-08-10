Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C543DC0E8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhG3WTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:19:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232948AbhG3WSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:18:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B609661078;
        Fri, 30 Jul 2021 22:18:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@rostedt.homelinux.com>)
        id 1m9apt-002V1h-Mq; Fri, 30 Jul 2021 18:18:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 13/17] libtracefs; Add error message for bad selections to SQL sequence
Date:   Fri, 30 Jul 2021 18:18:20 -0400
Message-Id: <20210730221824.595597-14-rostedt@goodmis.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730221824.595597-1-rostedt@goodmis.org>
References: <20210730221824.595597-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If the building of the synthetic event fails on creating the selection,
report it properly.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 src/tracefs-sqlhist.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/tracefs-sqlhist.c b/src/tracefs-sqlhist.c
index d39851845570..e542eb95c17f 100644
--- a/src/tracefs-sqlhist.c
+++ b/src/tracefs-sqlhist.c
@@ -971,6 +971,16 @@ static void *synth_init_error(struct tep_handle *tep, struct sql_table *table)
 	return field_match_error(tep, sb, match);
 }
 
+static void selection_error(struct tep_handle *tep,
+			    struct sqlhist_bison *sb, struct expr *expr)
+{
+	/* We just care about event not existing */
+	if (errno != ENODEV)
+		return;
+
+	test_field_exists(tep, sb, expr);
+}
+
 static struct tracefs_synth *build_synth(struct tep_handle *tep,
 					 const char *name,
 					 struct sql_table *table)
@@ -1051,8 +1061,10 @@ static struct tracefs_synth *build_synth(struct tep_handle *tep,
 				ret = tracefs_synth_add_end_field(synth,
 						field->field, field->label);
 			}
-			if (ret < 0)
+			if (ret < 0) {
+				selection_error(tep, table->sb, expr);
 				goto free;
+			}
 			continue;
 		}
 
-- 
2.30.2

