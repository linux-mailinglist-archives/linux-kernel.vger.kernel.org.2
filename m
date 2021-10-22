Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D30437F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhJVUwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:52:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234396AbhJVUvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:51:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A68136136F;
        Fri, 22 Oct 2021 20:48:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1Sz-000QME-Pv;
        Fri, 22 Oct 2021 16:48:41 -0400
Message-ID: <20211022204841.619322417@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 19/40] tracing/perf: Add interrupt_context_level() helper
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Now that there are three different instances of doing the addition trick
to the preempt_count() and NMI_MASK, HARDIRQ_MASK and SOFTIRQ_OFFSET
macros, it deserves a helper function defined in the preempt.h header.

Add the interrupt_context_level() helper and replace the three instances
that do that logic with it.

Link: https://lore.kernel.org/all/20211015142541.4badd8a9@gandalf.local.home/

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/preempt.h         | 21 +++++++++++++++++++++
 include/linux/trace_recursion.h |  7 +------
 kernel/events/internal.h        |  7 +------
 kernel/trace/ring_buffer.c      |  7 +------
 4 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 4d244e295e85..b32e3dabe28b 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -77,6 +77,27 @@
 /* preempt_count() and related functions, depends on PREEMPT_NEED_RESCHED */
 #include <asm/preempt.h>
 
+/**
+ * interrupt_context_level - return interrupt context level
+ *
+ * Returns the current interrupt context level.
+ *  0 - normal context
+ *  1 - softirq context
+ *  2 - hardirq context
+ *  3 - NMI context
+ */
+static __always_inline unsigned char interrupt_context_level(void)
+{
+	unsigned long pc = preempt_count();
+	unsigned char level = 0;
+
+	level += !!(pc & (NMI_MASK));
+	level += !!(pc & (NMI_MASK | HARDIRQ_MASK));
+	level += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
+
+	return level;
+}
+
 #define nmi_count()	(preempt_count() & NMI_MASK)
 #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
 #ifdef CONFIG_PREEMPT_RT
diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index f6da7a03bff0..1d8cce02c3fb 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -136,12 +136,7 @@ enum {
 
 static __always_inline int trace_get_context_bit(void)
 {
-	unsigned long pc = preempt_count();
-	unsigned char bit = 0;
-
-	bit += !!(pc & (NMI_MASK));
-	bit += !!(pc & (NMI_MASK | HARDIRQ_MASK));
-	bit += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
+	unsigned char bit = interrupt_context_level();
 
 	return TRACE_CTX_NORMAL - bit;
 }
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 228801e20788..082832738c8f 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -205,12 +205,7 @@ DEFINE_OUTPUT_COPY(__output_copy_user, arch_perf_out_copy_user)
 
 static inline int get_recursion_context(int *recursion)
 {
-	unsigned int pc = preempt_count();
-	unsigned char rctx = 0;
-
-	rctx += !!(pc & (NMI_MASK));
-	rctx += !!(pc & (NMI_MASK | HARDIRQ_MASK));
-	rctx += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
+	unsigned char rctx = interrupt_context_level();
 
 	if (recursion[rctx])
 		return -1;
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 15d4380006e3..f6520d0a4c8c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3167,12 +3167,7 @@ static __always_inline int
 trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	unsigned int val = cpu_buffer->current_context;
-	unsigned long pc = preempt_count();
-	int bit = 0;
-
-	bit += !!(pc & (NMI_MASK));
-	bit += !!(pc & (NMI_MASK | HARDIRQ_MASK));
-	bit += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
+	int bit = interrupt_context_level();
 
 	bit = RB_CTX_NORMAL - bit;
 
-- 
2.33.0
