Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983A640F58F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343773AbhIQKEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343745AbhIQKEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:04:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9C1B6103C;
        Fri, 17 Sep 2021 10:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631872968;
        bh=sjSOWfDl78wBSIhR2Adf/whp7HulfHzVr6zB8WI9jyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9ktbp1vo7VfVWThQTRbYoTdybdSHYpbIVQmvZ142sWvMz/tP5NRdr1xG0KcqY81I
         MSOqZHuv0+KUQE2K7BYgMJhfB/9I4hBueQfje2Bd5+OxbYDQD1/p3HmQPYZz8Tz8aI
         PMjsaUquApX8aKmXsvAUUHjOoExL7As+qI88y8Lqk4aHXigf8qTvqgRx31RXm5TW6i
         J31kC/Qg58Ai1KBvg6qpUgKBzWRDVExMLOTfCdosNHtr6SVaaoxgiALQYPgjmuKi+l
         l3Lmtixyl7i2YmPjLlDz75P+2yDuMCjwnoc754BgHX5y8G3roYvYuvnVTZ8D8bn+2m
         a5nirQn1DdY6Q==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/7] bootconfig: Split parse-tree part from xbc_init
Date:   Fri, 17 Sep 2021 19:02:46 +0900
Message-Id: <163187296647.2366983.15590065167920474865.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163187294400.2366983.7393164788107844569.stgit@devnote2>
References: <163187294400.2366983.7393164788107844569.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split bootconfig data parser to build tree code from
xbc_init(). This is an internal cosmetic change.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 lib/bootconfig.c |   99 +++++++++++++++++++++++++++++-------------------------
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
 

