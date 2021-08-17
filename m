Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F913EF2CC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhHQToH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233528AbhHQTnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B10046108D;
        Tue, 17 Aug 2021 19:43:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mG4zI-004TRE-Os; Tue, 17 Aug 2021 15:43:04 -0400
Message-ID: <20210817194304.610680086@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Aug 2021 15:42:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 11/19] tracing/boot: Support multiple histograms for each event
References: <20210817194207.947725935@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add multiple histograms support for each event. This allows
user to set multiple histograms to an event.

ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist[.N] {
...
}

The 'N' is a digit started string and it can be omitted
for the default histogram.

For example, multiple hist triggers example in the
Documentation/trace/histogram.rst can be written as below;

ftrace.event.net.netif_receive_skb.hist {
	1 {
		keys = skbaddr.hex
		values = len
		filter = len < 0
	}
	2 {
		keys = skbaddr.hex
		values = len
		filter = len > 4096
	}
	3 {
		keys = skbaddr.hex
		values = len
		filter = len == 256
	}
	4 {
		keys = skbaddr.hex
		values = len
	}
	5 {
		keys = len
		values = common_preempt_count
	}
}

Link: https://lkml.kernel.org/r/162856125628.203126.15846930277378572120.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 41 ++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index f024f27b3602..1a2b270e9cda 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -324,7 +324,7 @@ trace_boot_hist_add_handlers(struct xbc_node *hnode, char **bufp,
 /*
  * Histogram boottime tracing syntax.
  *
- * ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist {
+ * ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist[.N] {
  *	keys = <KEY>[,...]
  *	values = <VAL>[,...]
  *	sort = <SORT-KEY>[,...]
@@ -415,11 +415,37 @@ trace_boot_compose_hist_cmd(struct xbc_node *hnode, char *buf, size_t size)
 
 	return 0;
 }
+
+static void __init
+trace_boot_init_histograms(struct trace_event_file *file,
+			   struct xbc_node *hnode, char *buf, size_t size)
+{
+	struct xbc_node *node;
+	const char *p;
+
+	xbc_node_for_each_subkey(hnode, node) {
+		p = xbc_node_get_data(node);
+		if (!isdigit(p[0]))
+			continue;
+		/* All digit started node should be instances. */
+		if (trace_boot_compose_hist_cmd(node, buf, size) == 0) {
+			if (trigger_process_regex(file, buf) < 0)
+				pr_err("Failed to apply hist trigger: %s\n", buf);
+		}
+	}
+
+	if (xbc_node_find_child(hnode, "keys")) {
+		if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0)
+			if (trigger_process_regex(file, buf) < 0)
+				pr_err("Failed to apply hist trigger: %s\n", buf);
+	}
+}
 #else
-static int __init
-trace_boot_compose_hist_cmd(struct xbc_node *hnode, char *buf, size_t size)
+static void __init
+trace_boot_init_histograms(struct trace_event_file *file,
+			   struct xbc_node *hnode, char *buf, size_t size)
 {
-	return -EOPNOTSUPP;
+	/* do nothing */
 }
 #endif
 
@@ -465,11 +491,8 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 				pr_err("Failed to apply an action: %s\n", buf);
 		}
 		anode = xbc_node_find_child(enode, "hist");
-		if (anode &&
-		    trace_boot_compose_hist_cmd(anode, buf, ARRAY_SIZE(buf)) == 0) {
-			if (trigger_process_regex(file, buf) < 0)
-				pr_err("Failed to apply hist trigger: %s\n", buf);
-		}
+		if (anode)
+			trace_boot_init_histograms(file, anode, buf, ARRAY_SIZE(buf));
 	} else if (xbc_node_find_value(enode, "actions", NULL))
 		pr_err("Failed to apply event actions because CONFIG_HIST_TRIGGERS is not set.\n");
 
-- 
2.30.2
