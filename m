Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7F43EF2C3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbhHQTnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:43:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhHQTnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF2196102A;
        Tue, 17 Aug 2021 19:43:03 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mG4zG-004TLd-Su; Tue, 17 Aug 2021 15:43:02 -0400
Message-ID: <20210817194302.725791545@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Aug 2021 15:42:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 01/19] tracing/boot: Fix a hist trigger dependency for boot time tracing
References: <20210817194207.947725935@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Fixes a build error when CONFIG_HIST_TRIGGERS=n with boot-time
tracing. Since the trigger_process_regex() is defined only
when CONFIG_HIST_TRIGGERS=y, if it is disabled, the 'actions'
event option also must be disabled.

Link: https://lkml.kernel.org/r/162856123376.203126.582144262622247352.stgit@devnote2

Fixes: 81a59555ff15 ("tracing/boot: Add per-event settings")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 94ef2d099e32..d713714cba67 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -205,12 +205,15 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 			pr_err("Failed to apply filter: %s\n", buf);
 	}
 
-	xbc_node_for_each_array_value(enode, "actions", anode, p) {
-		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
-			pr_err("action string is too long: %s\n", p);
-		else if (trigger_process_regex(file, buf) < 0)
-			pr_err("Failed to apply an action: %s\n", buf);
-	}
+	if (IS_ENABLED(CONFIG_HIST_TRIGGERS)) {
+		xbc_node_for_each_array_value(enode, "actions", anode, p) {
+			if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
+				pr_err("action string is too long: %s\n", p);
+			else if (trigger_process_regex(file, buf) < 0)
+				pr_err("Failed to apply an action: %s\n", buf);
+		}
+	} else if (xbc_node_find_value(enode, "actions", NULL))
+		pr_err("Failed to apply event actions because CONFIG_HIST_TRIGGERS is not set.\n");
 
 	if (xbc_node_find_value(enode, "enable", NULL)) {
 		if (trace_event_enable_disable(file, 1, 0) < 0)
-- 
2.30.2
