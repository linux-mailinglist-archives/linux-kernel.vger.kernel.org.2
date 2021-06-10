Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3866B3A21B9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 03:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhFJBEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 21:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbhFJBDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 21:03:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66E2761413;
        Thu, 10 Jun 2021 01:01:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lr954-002bbd-FQ; Wed, 09 Jun 2021 21:01:58 -0400
Message-ID: <20210610010158.315830915@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Jun 2021 21:01:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 09/11] tracing/boot: Add per-group/all events enablement
References: <20210610010130.069460694@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add ftrace.event.<GROUP>.enable and ftrace.event.enable
boot-time tracing, which enables all events under
given GROUP and all events respectivly.

Link: https://lkml.kernel.org/r/162264438005.302580.12019174481201855444.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index a82f03f385f8..94ef2d099e32 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -225,14 +225,37 @@ static void __init
 trace_boot_init_events(struct trace_array *tr, struct xbc_node *node)
 {
 	struct xbc_node *gnode, *enode;
+	bool enable, enable_all = false;
+	const char *data;
 
 	node = xbc_node_find_child(node, "event");
 	if (!node)
 		return;
 	/* per-event key starts with "event.GROUP.EVENT" */
-	xbc_node_for_each_child(node, gnode)
-		xbc_node_for_each_child(gnode, enode)
+	xbc_node_for_each_child(node, gnode) {
+		data = xbc_node_get_data(gnode);
+		if (!strcmp(data, "enable")) {
+			enable_all = true;
+			continue;
+		}
+		enable = false;
+		xbc_node_for_each_child(gnode, enode) {
+			data = xbc_node_get_data(enode);
+			if (!strcmp(data, "enable")) {
+				enable = true;
+				continue;
+			}
 			trace_boot_init_one_event(tr, gnode, enode);
+		}
+		/* Event enablement must be done after event settings */
+		if (enable) {
+			data = xbc_node_get_data(gnode);
+			trace_array_set_clr_event(tr, data, NULL, true);
+		}
+	}
+	/* Ditto */
+	if (enable_all)
+		trace_array_set_clr_event(tr, NULL, NULL, true);
 }
 #else
 #define trace_boot_enable_events(tr, node) do {} while (0)
-- 
2.30.2
