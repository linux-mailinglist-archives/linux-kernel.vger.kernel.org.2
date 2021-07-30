Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E753DC0E1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhG3WSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232680AbhG3WSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:18:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DD6F61042;
        Fri, 30 Jul 2021 22:18:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@rostedt.homelinux.com>)
        id 1m9apt-002V1Y-KC; Fri, 30 Jul 2021 18:18:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 10/17] libtracefs: Add a parse_error() helper function to record errors
Date:   Fri, 30 Jul 2021 18:18:17 -0400
Message-Id: <20210730221824.595597-11-rostedt@goodmis.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730221824.595597-1-rostedt@goodmis.org>
References: <20210730221824.595597-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add parse_error() that calls into sql_parse_error() with the appropriate
ap argument. That is, parse_error() takes a normal printf() form and then
translates it to the vprintf from of sql_parse_error.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 src/tracefs-sqlhist.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/tracefs-sqlhist.c b/src/tracefs-sqlhist.c
index 887c2441a39e..c0875d630391 100644
--- a/src/tracefs-sqlhist.c
+++ b/src/tracefs-sqlhist.c
@@ -8,6 +8,7 @@
  */
 #include <trace-seq.h>
 #include <stdlib.h>
+#include <stdarg.h>
 #include <errno.h>
 
 #include "tracefs.h"
@@ -153,6 +154,16 @@ __hidden void sql_parse_error(struct sqlhist_bison *sb, const char *text,
 	trace_seq_destroy(&s);
 }
 
+static void parse_error(struct sqlhist_bison *sb, const char *text,
+			const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	sql_parse_error(sb, text, fmt, ap);
+	va_end(ap);
+}
+
 static inline unsigned int quick_hash(const char *str)
 {
 	unsigned int val = 0;
-- 
2.30.2

