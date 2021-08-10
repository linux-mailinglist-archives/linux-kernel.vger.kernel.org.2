Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CD93DE50F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 06:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhHCEYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 00:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232667AbhHCEYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 00:24:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED468610A0;
        Tue,  3 Aug 2021 04:23:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@rostedt.homelinux.com>)
        id 1mAly7-002qnO-Sq; Tue, 03 Aug 2021 00:23:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH v2 08/21] libtracefs: Make parser unique to libtracefs
Date:   Tue,  3 Aug 2021 00:23:34 -0400
Message-Id: <20210803042347.679499-9-rostedt@goodmis.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210803042347.679499-1-rostedt@goodmis.org>
References: <20210803042347.679499-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add %define api.prefix and defines to have the parser global variables use
tracefs_* instead of yy*, as without this, if a tool that links to this
library, and tries to use the synth sql parsing, it may end up using its
own yyparse() and friends functions.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 src/sqlhist.y         | 10 ++++++++++
 src/tracefs-sqlhist.c |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/sqlhist.y b/src/sqlhist.y
index ce9cb58fb3a9..9d03a457ae84 100644
--- a/src/sqlhist.y
+++ b/src/sqlhist.y
@@ -30,6 +30,16 @@ extern void yyerror(struct sqlhist_bison *, char *fmt, ...);
 %}
 
 %define api.pure
+
+/* Change the globals to use tracefs_ prefix */
+%define api.prefix{tracefs_}
+%code provides
+{
+  #define YYSTYPE TRACEFS_STYPE
+  #define yylex tracefs_lex
+  #define yyerror tracefs_error
+}
+
 %lex-param {void *scanner}
 %parse-param {struct sqlhist_bison *sb}
 
diff --git a/src/tracefs-sqlhist.c b/src/tracefs-sqlhist.c
index e8f77d60659f..933b3609733b 100644
--- a/src/tracefs-sqlhist.c
+++ b/src/tracefs-sqlhist.c
@@ -1021,7 +1021,7 @@ struct tracefs_synth *tracefs_sql(struct tep_handle *tep, const char *name,
 		return NULL;
 	}
 
-	ret = yyparse(&sb);
+	ret = tracefs_parse(&sb);
 	yylex_destroy(sb.scanner);
 
 	if (ret)
-- 
2.30.2

