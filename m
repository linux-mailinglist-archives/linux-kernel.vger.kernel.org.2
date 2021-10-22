Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D534437F88
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhJVUvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234381AbhJVUu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:50:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D440B61354;
        Fri, 22 Oct 2021 20:48:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1Sz-000QJx-0H;
        Fri, 22 Oct 2021 16:48:41 -0400
Message-ID: <20211022204840.832670759@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Changbin Du <changbin.du@gmail.com>
Subject: [for-next][PATCH 15/40] tracing: in_irq() cleanup
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

Replace the obsolete and ambiguos macro in_irq() with new
macro in_hardirq().

Link: https://lkml.kernel.org/r/20210930000342.6016-1-changbin.du@gmail.com

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.h                 | 2 +-
 kernel/trace/trace_functions_graph.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6c3808132b16..6b60ab9475ed 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -890,7 +890,7 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 		 * is set, and called by an interrupt handler, we still
 		 * want to trace it.
 		 */
-		if (in_irq())
+		if (in_hardirq())
 			trace_recursion_set(TRACE_IRQ_BIT);
 		else
 			trace_recursion_clear(TRACE_IRQ_BIT);
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 6b5ff3ba4251..203204cadf92 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -120,7 +120,7 @@ static inline int ftrace_graph_ignore_irqs(void)
 	if (!ftrace_graph_skip_irqs || trace_recursion_test(TRACE_IRQ_BIT))
 		return 0;
 
-	return in_irq();
+	return in_hardirq();
 }
 
 int trace_graph_entry(struct ftrace_graph_ent *trace)
-- 
2.33.0
