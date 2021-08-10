Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9373E50EC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 04:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbhHJCID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 22:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237394AbhHJCHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 22:07:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CA076105A;
        Tue, 10 Aug 2021 02:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628561251;
        bh=gEeBxm+ueJ0LFn7wFEpt/yOroxqppJ4T//SLER1Q/Zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZftd9U8HH1+7UpezLrAms2nRiRnd/jiv0vRYXyZUNcT+hzGYRgTG4C1s3Sx113p7
         hQlPV0dqDl1XnslWmRtCGBkJzudhuXUcTfzMqGMISJlrSm9C7LxuBbKI4zvpCIF38R
         8Vy6KVA07gZvxTdpf+KioskMJfwZzzZ0twMreis8eKj+bXUzTxdgz2FQpev3qV7wJ/
         5XSVcYnyudu/GmlxPM0cKVIyFLy/4BaL9skgI7xg7LSLD4DM+7B0gRf5Ihe/8j999p
         +119zWeF36vIuw7ppiB2HLGyxuirjpK9U+iWBNj3xzG4cxsgtIDGf5uclUaziL0MOi
         Rcqd5UVp+FNQQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 03/10] tracing/boot: Support multiple handlers for per-event histogram
Date:   Tue, 10 Aug 2021 11:07:29 +0900
Message-Id: <162856124905.203126.14913731908137885922.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162856122550.203126.17607127017097781682.stgit@devnote2>
References: <162856122550.203126.17607127017097781682.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support multiple handlers for per-event histogram in boot-time tracing.
Since the histogram can register multiple same handler-actions with
different parameters, this expands the syntax to support such cases.

With this update, the 'onmax', 'onchange' and 'onmatch' handler subkeys
under per-event histogram option will take a number subkeys optionally
as below. (see [.N])

ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist {
     onmax|onchange[.N] { var = <VAR>; <ACTION> [= <PARAM>] }
     onmatch[.N] { event = <EVENT>; <ACTION> [= <PARAM>] }
}

The 'N' must be a digit (or digit started word).

Thus user can add several handler-actions to the histogram,
for example,

ftrace.event.SOMEGROUP.SOMEEVENT.hist {
   keys = SOME_ID; lat = common_timestamp.usecs-$ts0
   onmatch.1 {
	event = GROUP1.STARTEVENT1
	trace = latency_event, SOME_ID, $lat
   }
   onmatch.2 {
	event = GROUP2.STARTEVENT2
	trace = latency_event, SOME_ID, $lat
   }
}

Then, it can trace the elapsed time from GROUP1.STARTEVENT1 to
SOMEGROUP.SOMEEVENT, and from GROUP2.STARTEVENT2 to
SOMEGROUP.SOMEEVENT with SOME_ID key.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c |   43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 3d0e51368f51..f024f27b3602 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -245,8 +245,9 @@ trace_boot_hist_add_array(struct xbc_node *hnode, char **bufp,
 }
 
 static int __init
-trace_boot_hist_add_handler(struct xbc_node *hnode, char **bufp,
-			    char *end, const char *param)
+trace_boot_hist_add_one_handler(struct xbc_node *hnode, char **bufp,
+				char *end, const char *handler,
+				const char *param)
 {
 	struct xbc_node *knode, *anode;
 	const char *p;
@@ -259,7 +260,7 @@ trace_boot_hist_add_handler(struct xbc_node *hnode, char **bufp,
 		       xbc_node_get_data(hnode), param);
 		return -EINVAL;
 	}
-	append_printf(bufp, end, ":%s(%s)", xbc_node_get_data(hnode), p);
+	append_printf(bufp, end, ":%s(%s)", handler, p);
 
 	/* Compose 'action' parameter */
 	knode = xbc_node_find_child(hnode, "trace");
@@ -294,6 +295,32 @@ trace_boot_hist_add_handler(struct xbc_node *hnode, char **bufp,
 	return 0;
 }
 
+static int __init
+trace_boot_hist_add_handlers(struct xbc_node *hnode, char **bufp,
+			     char *end, const char *param)
+{
+	struct xbc_node *node;
+	const char *p, *handler;
+	int ret;
+
+	handler = xbc_node_get_data(hnode);
+
+	xbc_node_for_each_subkey(hnode, node) {
+		p = xbc_node_get_data(node);
+		if (!isdigit(p[0]))
+			continue;
+		/* All digit started node should be instances. */
+		ret = trace_boot_hist_add_one_handler(node, bufp, end, handler, param);
+		if (ret < 0)
+			break;
+	}
+
+	if (xbc_node_find_child(hnode, param))
+		ret = trace_boot_hist_add_one_handler(hnode, bufp, end, handler, param);
+
+	return ret;
+}
+
 /*
  * Histogram boottime tracing syntax.
  *
@@ -305,8 +332,8 @@ trace_boot_hist_add_handler(struct xbc_node *hnode, char **bufp,
  *	name = <HISTNAME>
  *	var { <VAR> = <EXPR> ... }
  *	pause|continue|clear
- *	onmax|onchange { var = <VAR>; <ACTION> [= <PARAM>] }
- *	onmatch { event = <EVENT>; <ACTION> [= <PARAM>] }
+ *	onmax|onchange[.N] { var = <VAR>; <ACTION> [= <PARAM>] }
+ *	onmatch[.N] { event = <EVENT>; <ACTION> [= <PARAM>] }
  *	filter = <FILTER>
  * }
  *
@@ -368,13 +395,13 @@ trace_boot_compose_hist_cmd(struct xbc_node *hnode, char *buf, size_t size)
 
 	/* Histogram handler and actions */
 	node = xbc_node_find_child(hnode, "onmax");
-	if (node && trace_boot_hist_add_handler(node, &buf, end, "var") < 0)
+	if (node && trace_boot_hist_add_handlers(node, &buf, end, "var") < 0)
 		return -EINVAL;
 	node = xbc_node_find_child(hnode, "onchange");
-	if (node && trace_boot_hist_add_handler(node, &buf, end, "var") < 0)
+	if (node && trace_boot_hist_add_handlers(node, &buf, end, "var") < 0)
 		return -EINVAL;
 	node = xbc_node_find_child(hnode, "onmatch");
-	if (node && trace_boot_hist_add_handler(node, &buf, end, "event") < 0)
+	if (node && trace_boot_hist_add_handlers(node, &buf, end, "event") < 0)
 		return -EINVAL;
 
 	p = xbc_node_find_value(hnode, "filter", NULL);

