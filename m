Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493C83EF2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhHQToM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233595AbhHQTnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB6B761073;
        Tue, 17 Aug 2021 19:43:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mG4zI-004TRn-Ux; Tue, 17 Aug 2021 15:43:04 -0400
Message-ID: <20210817194304.795397004@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Aug 2021 15:42:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 12/19] tracing/boot: Show correct histogram error command
References: <20210817194207.947725935@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since trigger_process_regex() modifies given trigger actions
while parsing, the error message couldn't show what command
was passed to the trigger_process_regex() when it returns
an error.

To fix that, show the backed up trigger action command
instead of parsed buffer.

Link: https://lkml.kernel.org/r/162856126413.203126.9465564928450701424.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 1a2b270e9cda..1060b0446032 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -422,6 +422,7 @@ trace_boot_init_histograms(struct trace_event_file *file,
 {
 	struct xbc_node *node;
 	const char *p;
+	char *tmp;
 
 	xbc_node_for_each_subkey(hnode, node) {
 		p = xbc_node_get_data(node);
@@ -429,15 +430,20 @@ trace_boot_init_histograms(struct trace_event_file *file,
 			continue;
 		/* All digit started node should be instances. */
 		if (trace_boot_compose_hist_cmd(node, buf, size) == 0) {
+			tmp = kstrdup(buf, GFP_KERNEL);
 			if (trigger_process_regex(file, buf) < 0)
-				pr_err("Failed to apply hist trigger: %s\n", buf);
+				pr_err("Failed to apply hist trigger: %s\n", tmp);
+			kfree(tmp);
 		}
 	}
 
 	if (xbc_node_find_child(hnode, "keys")) {
-		if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0)
+		if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0) {
+			tmp = kstrdup(buf, GFP_KERNEL);
 			if (trigger_process_regex(file, buf) < 0)
-				pr_err("Failed to apply hist trigger: %s\n", buf);
+				pr_err("Failed to apply hist trigger: %s\n", tmp);
+			kfree(tmp);
+		}
 	}
 }
 #else
@@ -488,7 +494,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 			if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
 				pr_err("action string is too long: %s\n", p);
 			else if (trigger_process_regex(file, buf) < 0)
-				pr_err("Failed to apply an action: %s\n", buf);
+				pr_err("Failed to apply an action: %s\n", p);
 		}
 		anode = xbc_node_find_child(enode, "hist");
 		if (anode)
-- 
2.30.2
