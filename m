Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438393DF38A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 19:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbhHCRG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 13:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237551AbhHCRGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 13:06:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DFF8611C5;
        Tue,  3 Aug 2021 17:06:09 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@rostedt.homelinux.com>)
        id 1mAxrk-002ucK-3P; Tue, 03 Aug 2021 13:06:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH v3 20/22] libtracefs: Allow trace_sql() to take keywords for fields with backslash
Date:   Tue,  3 Aug 2021 13:06:04 -0400
Message-Id: <20210803170606.694085-21-rostedt@goodmis.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210803170606.694085-1-rostedt@goodmis.org>
References: <20210803170606.694085-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Some events have fields with keywords, and the parsing will not let it
work. For example, you can have:

  select from from regcache_drop_region

And that will produce a syntax error, as the from will confuse the parser.
Allow fields to start with a backslash, which will allow the parser to see
"from" as a field and not as a keyword. That is:

  select \from from regcache_drop_region

will work as expected. Note, any field can start with a backslash, and the
starting backslash will be ignored.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/libtracefs-sql.txt | 20 ++++++++++++++++++++
 src/sqlhist.l                    |  6 ++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/libtracefs-sql.txt b/Documentation/libtracefs-sql.txt
index ee8d5c1d63c7..bc2811cfe08b 100644
--- a/Documentation/libtracefs-sql.txt
+++ b/Documentation/libtracefs-sql.txt
@@ -162,6 +162,26 @@ select start.pid, (end.TIMESTAMP_USECS - start.TIMESTAMP_USECS) as lat from sche
    WHERE start.prio < 100 || end.prev_prio < 100
 --
 
+
+KEYWORDS AS EVENT FIELDS
+------------------------
+
+In some cases, an event may have a keyword. For example, regcache_drop_region has "from"
+as a field and the following will not work
+
+[source,c]
+--
+  select from from regcache_drop_region
+--
+
+In such cases, add a backslash to the conflicting field, and this will tell the parser
+that the "from" is a field and not a keyword:
+
+[source,c]
+--
+  select \from from regcache_drop_region
+--
+
 HISTOGRAMS
 ----------
 
diff --git a/src/sqlhist.l b/src/sqlhist.l
index f9e0fcc17e63..897daac7d2a8 100644
--- a/src/sqlhist.l
+++ b/src/sqlhist.l
@@ -25,7 +25,7 @@ extern int my_yyinput(void *extra, char *buf, int max);
 %option reentrant
 %option bison-bridge
 
-field		[a-z_][a-z0-9_\.]*
+field		\\?[a-z_][a-z0-9_\.]*
 qstring		\"[^\"]*\"
 hexnum		0x[0-9a-f]+
 number		[0-9a-f]+
@@ -46,8 +46,10 @@ where { HANDLE_COLUMN; return WHERE; }
 }
 
 {field} {
+	const char *str = yyg->yytext_r;
 	HANDLE_COLUMN;
-	yylval->string = store_str(TRACE_SB, yyg->yytext_r);
+	if (str[0] == '\\') { str++; };
+	yylval->string = store_str(TRACE_SB, str);
 	return FIELD;
 }
 
-- 
2.30.2

