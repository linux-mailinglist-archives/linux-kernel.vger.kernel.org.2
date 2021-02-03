Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D0030DF66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbhBCQNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:13:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234918AbhBCQH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:07:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E523F64FA4;
        Wed,  3 Feb 2021 16:05:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1l7Kf7-009J8X-Po; Wed, 03 Feb 2021 11:05:49 -0500
Message-ID: <20210203160549.674058717@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Feb 2021 11:05:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [for-next][PATCH 07/15] tracing: Inline tracing_gen_ctx_flags()
References: <20210203160517.982448432@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Inline tracing_gen_ctx_flags(). This allows to have one ifdef
CONFIG_TRACE_IRQFLAGS_SUPPORT.

This requires to move `trace_flag_type' so tracing_gen_ctx_flags() can
use it.

Link: https://lkml.kernel.org/r/20210125194511.3924915-3-bigeasy@linutronix.de

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20210125140323.6b1ff20c@gandalf.local.home
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h | 54 ++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.c         | 38 ++-----------------------
 kernel/trace/trace.h         | 19 -------------
 3 files changed, 53 insertions(+), 58 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 091250b0895a..67ae708de40d 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -160,9 +160,57 @@ static inline void tracing_generic_entry_update(struct trace_entry *entry,
 	entry->flags =			trace_ctx >> 16;
 }
 
-unsigned int tracing_gen_ctx_flags(unsigned long irqflags);
-unsigned int tracing_gen_ctx(void);
-unsigned int tracing_gen_ctx_dec(void);
+unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status);
+
+enum trace_flag_type {
+	TRACE_FLAG_IRQS_OFF		= 0x01,
+	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,
+	TRACE_FLAG_NEED_RESCHED		= 0x04,
+	TRACE_FLAG_HARDIRQ		= 0x08,
+	TRACE_FLAG_SOFTIRQ		= 0x10,
+	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
+	TRACE_FLAG_NMI			= 0x40,
+};
+
+#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
+static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
+{
+	unsigned int irq_status = irqs_disabled_flags(irqflags) ?
+		TRACE_FLAG_IRQS_OFF : 0;
+	return tracing_gen_ctx_irq_test(irq_status);
+}
+static inline unsigned int tracing_gen_ctx(void)
+{
+	unsigned long irqflags;
+
+	local_save_flags(irqflags);
+	return tracing_gen_ctx_flags(irqflags);
+}
+#else
+
+static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
+{
+	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+}
+static inline unsigned int tracing_gen_ctx(void)
+{
+	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+}
+#endif
+
+static inline unsigned int tracing_gen_ctx_dec(void)
+{
+	unsigned int trace_ctx;
+
+	trace_ctx = tracing_gen_ctx();
+	/*
+	 * Subtract one from the preeption counter if preemption is enabled,
+	 * see trace_event_buffer_reserve()for details.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPTION))
+		trace_ctx--;
+	return trace_ctx;
+}
 
 struct trace_event_file;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0b3cce6ecf52..584fa2a1304a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2579,20 +2579,13 @@ enum print_line_t trace_handle_return(struct trace_seq *s)
 }
 EXPORT_SYMBOL_GPL(trace_handle_return);
 
-unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
+unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 {
-	unsigned int trace_flags = 0;
+	unsigned int trace_flags = irqs_status;
 	unsigned int pc;
 
 	pc = preempt_count();
 
-#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
-	if (irqs_disabled_flags(irqflags))
-		trace_flags |= TRACE_FLAG_IRQS_OFF;
-#else
-	trace_flags |= TRACE_FLAG_IRQS_NOSUPPORT;
-#endif
-
 	if (pc & NMI_MASK)
 		trace_flags |= TRACE_FLAG_NMI;
 	if (pc & HARDIRQ_MASK)
@@ -2608,33 +2601,6 @@ unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
 	return (trace_flags << 16) | (pc & 0xff);
 }
 
-unsigned int tracing_gen_ctx(void)
-{
-	unsigned long irqflags;
-
-#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
-	local_save_flags(irqflags);
-#else
-	irqflags = 0;
-#endif
-	return tracing_gen_ctx_flags(irqflags);
-}
-
-unsigned int tracing_gen_ctx_dec(void)
-{
-	unsigned int trace_ctx;
-
-	trace_ctx = tracing_gen_ctx();
-
-	/*
-	 * Subtract one from the preeption counter if preemption is enabled,
-	 * see trace_event_buffer_reserve()for details.
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPTION))
-		trace_ctx--;
-	return trace_ctx;
-}
-
 struct ring_buffer_event *
 trace_buffer_lock_reserve(struct trace_buffer *buffer,
 			  int type,
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 8daf3a0758b1..93fb08ab8bb6 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -136,25 +136,6 @@ struct kretprobe_trace_entry_head {
 	unsigned long		ret_ip;
 };
 
-/*
- * trace_flag_type is an enumeration that holds different
- * states when a trace occurs. These are:
- *  IRQS_OFF		- interrupts were disabled
- *  IRQS_NOSUPPORT	- arch does not support irqs_disabled_flags
- *  NEED_RESCHED	- reschedule is requested
- *  HARDIRQ		- inside an interrupt handler
- *  SOFTIRQ		- inside a softirq handler
- */
-enum trace_flag_type {
-	TRACE_FLAG_IRQS_OFF		= 0x01,
-	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,
-	TRACE_FLAG_NEED_RESCHED		= 0x04,
-	TRACE_FLAG_HARDIRQ		= 0x08,
-	TRACE_FLAG_SOFTIRQ		= 0x10,
-	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
-	TRACE_FLAG_NMI			= 0x40,
-};
-
 #define TRACE_BUF_SIZE		1024
 
 struct trace_array;
-- 
2.29.2


