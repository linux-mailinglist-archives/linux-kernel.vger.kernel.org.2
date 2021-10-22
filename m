Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61692437F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhJVUva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:51:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234365AbhJVUu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:50:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB1CB6135F;
        Fri, 22 Oct 2021 20:48:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1Sx-000QGU-Rq;
        Fri, 22 Oct 2021 16:48:39 -0400
Message-ID: <20211022204839.688697490@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 09/40] bootconfig: Split parse-tree part from xbc_init
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Split bootconfig data parser to build tree code from
xbc_init(). This is an internal cosmetic change.

Link: https://lkml.kernel.org/r/163187296647.2366983.15590065167920474865.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 lib/bootconfig.c | 99 ++++++++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 45 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index a3ce5a0c3ca4..b7e5a32b30d3 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -801,6 +801,58 @@ static int __init xbc_verify_tree(void)
 	return 0;
 }
 
+/* Need to setup xbc_data and xbc_nodes before call this. */
+static int __init xbc_parse_tree(void)
+{
+	char *p, *q;
+	int ret, c;
+
+	last_parent = NULL;
+	p = xbc_data;
+	do {
+		q = strpbrk(p, "{}=+;:\n#");
+		if (!q) {
+			p = skip_spaces(p);
+			if (*p != '\0')
+				ret = xbc_parse_error("No delimiter", p);
+			break;
+		}
+
+		c = *q;
+		*q++ = '\0';
+		switch (c) {
+		case ':':
+		case '+':
+			if (*q++ != '=') {
+				ret = xbc_parse_error(c == '+' ?
+						"Wrong '+' operator" :
+						"Wrong ':' operator",
+							q - 2);
+				break;
+			}
+			fallthrough;
+		case '=':
+			ret = xbc_parse_kv(&p, q, c);
+			break;
+		case '{':
+			ret = xbc_open_brace(&p, q);
+			break;
+		case '#':
+			q = skip_comment(q);
+			fallthrough;
+		case ';':
+		case '\n':
+			ret = xbc_parse_key(&p, q);
+			break;
+		case '}':
+			ret = xbc_close_brace(&p, q);
+			break;
+		}
+	} while (!ret);
+
+	return ret;
+}
+
 /**
  * xbc_exit() - Clean up all parsed bootconfig
  *
@@ -836,8 +888,7 @@ void __init xbc_exit(void)
  */
 int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 {
-	char *p, *q;
-	int ret, c;
+	int ret;
 
 	if (epos)
 		*epos = -1;
@@ -874,49 +925,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 	}
 	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
 
-	last_parent = NULL;
-	p = xbc_data;
-	do {
-		q = strpbrk(p, "{}=+;:\n#");
-		if (!q) {
-			p = skip_spaces(p);
-			if (*p != '\0')
-				ret = xbc_parse_error("No delimiter", p);
-			break;
-		}
-
-		c = *q;
-		*q++ = '\0';
-		switch (c) {
-		case ':':
-		case '+':
-			if (*q++ != '=') {
-				ret = xbc_parse_error(c == '+' ?
-						"Wrong '+' operator" :
-						"Wrong ':' operator",
-							q - 2);
-				break;
-			}
-			fallthrough;
-		case '=':
-			ret = xbc_parse_kv(&p, q, c);
-			break;
-		case '{':
-			ret = xbc_open_brace(&p, q);
-			break;
-		case '#':
-			q = skip_comment(q);
-			fallthrough;
-		case ';':
-		case '\n':
-			ret = xbc_parse_key(&p, q);
-			break;
-		case '}':
-			ret = xbc_close_brace(&p, q);
-			break;
-		}
-	} while (!ret);
-
+	ret = xbc_parse_tree();
 	if (!ret)
 		ret = xbc_verify_tree();
 
-- 
2.33.0
