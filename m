Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5B73EF2CB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhHQToA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233475AbhHQTni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827C761076;
        Tue, 17 Aug 2021 19:43:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mG4zI-004TQf-It; Tue, 17 Aug 2021 15:43:04 -0400
Message-ID: <20210817194304.431337641@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Aug 2021 15:42:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 10/19] tracing/boot: Support multiple handlers for per-event histogram
References: <20210817194207.947725935@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

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

Link: https://lkml.kernel.org/r/162856124905.203126.14913731908137885922.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 43 +++++++++++++++++++++++++++++++--------
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
-- 
2.30.2
