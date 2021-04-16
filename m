Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600623626C0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbhDPR1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241800AbhDPR1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:27:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F008613C1;
        Fri, 16 Apr 2021 17:26:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lXSF7-0069lv-9x; Fri, 16 Apr 2021 13:26:57 -0400
Message-ID: <20210416172657.161533893@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 16 Apr 2021 13:26:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [for-next][PATCH 6/7] tracing: Add "func_no_repeats" option for function tracing
References: <20210416172612.086725495@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>

If the option is activated the function tracing record gets
consolidated in the cases when a single function is called number
of times consecutively. Instead of having an identical record for
each call of the function we will record only the first call
following by event showing the number of repeats.

Link: https://lkml.kernel.org/r/20210415181854.147448-7-y.karadz@gmail.com

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions.c | 162 ++++++++++++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index f37f73a9b1b8..1f0e63f5d1f9 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -27,15 +27,27 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 static void
 function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 			  struct ftrace_ops *op, struct ftrace_regs *fregs);
+static void
+function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
+			       struct ftrace_ops *op, struct ftrace_regs *fregs);
+static void
+function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
+				     struct ftrace_ops *op,
+				     struct ftrace_regs *fregs);
 static struct tracer_flags func_flags;
 
 /* Our option */
 enum {
-	TRACE_FUNC_NO_OPTS	= 0x0, /* No flags set. */
-	TRACE_FUNC_OPT_STACK	= 0x1,
+
+	TRACE_FUNC_NO_OPTS		= 0x0, /* No flags set. */
+	TRACE_FUNC_OPT_STACK		= 0x1,
+	TRACE_FUNC_OPT_NO_REPEATS	= 0x2,
+
+	/* Update this to next highest bit. */
+	TRACE_FUNC_OPT_HIGHEST_BIT	= 0x4
 };
 
-#define TRACE_FUNC_OPT_MASK	(TRACE_FUNC_OPT_STACK)
+#define TRACE_FUNC_OPT_MASK	(TRACE_FUNC_OPT_HIGHEST_BIT - 1)
 
 int ftrace_allocate_ftrace_ops(struct trace_array *tr)
 {
@@ -96,11 +108,27 @@ static ftrace_func_t select_trace_function(u32 flags_val)
 		return function_trace_call;
 	case TRACE_FUNC_OPT_STACK:
 		return function_stack_trace_call;
+	case TRACE_FUNC_OPT_NO_REPEATS:
+		return function_no_repeats_trace_call;
+	case TRACE_FUNC_OPT_STACK | TRACE_FUNC_OPT_NO_REPEATS:
+		return function_stack_no_repeats_trace_call;
 	default:
 		return NULL;
 	}
 }
 
+static bool handle_func_repeats(struct trace_array *tr, u32 flags_val)
+{
+	if (!tr->last_func_repeats &&
+	    (flags_val & TRACE_FUNC_OPT_NO_REPEATS)) {
+		tr->last_func_repeats = alloc_percpu(struct trace_func_repeats);
+		if (!tr->last_func_repeats)
+			return false;
+	}
+
+	return true;
+}
+
 static int function_trace_init(struct trace_array *tr)
 {
 	ftrace_func_t func;
@@ -116,6 +144,9 @@ static int function_trace_init(struct trace_array *tr)
 	if (!func)
 		return -EINVAL;
 
+	if (!handle_func_repeats(tr, func_flags.val))
+		return -ENOMEM;
+
 	ftrace_init_array_ops(tr, func);
 
 	tr->array_buffer.cpu = raw_smp_processor_id();
@@ -217,10 +248,132 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 	local_irq_restore(flags);
 }
 
+static inline bool is_repeat_check(struct trace_array *tr,
+				   struct trace_func_repeats *last_info,
+				   unsigned long ip, unsigned long parent_ip)
+{
+	if (last_info->ip == ip &&
+	    last_info->parent_ip == parent_ip &&
+	    last_info->count < U16_MAX) {
+		last_info->ts_last_call =
+			ring_buffer_time_stamp(tr->array_buffer.buffer);
+		last_info->count++;
+		return true;
+	}
+
+	return false;
+}
+
+static inline void process_repeats(struct trace_array *tr,
+				   unsigned long ip, unsigned long parent_ip,
+				   struct trace_func_repeats *last_info,
+				   unsigned int trace_ctx)
+{
+	if (last_info->count) {
+		trace_last_func_repeats(tr, last_info, trace_ctx);
+		last_info->count = 0;
+	}
+
+	last_info->ip = ip;
+	last_info->parent_ip = parent_ip;
+}
+
+static void
+function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
+			       struct ftrace_ops *op,
+			       struct ftrace_regs *fregs)
+{
+	struct trace_func_repeats *last_info;
+	struct trace_array *tr = op->private;
+	struct trace_array_cpu *data;
+	unsigned int trace_ctx;
+	unsigned long flags;
+	int bit;
+	int cpu;
+
+	if (unlikely(!tr->function_enabled))
+		return;
+
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0)
+		return;
+
+	preempt_disable_notrace();
+
+	cpu = smp_processor_id();
+	data = per_cpu_ptr(tr->array_buffer.data, cpu);
+	if (atomic_read(&data->disabled))
+		goto out;
+
+	/*
+	 * An interrupt may happen at any place here. But as far as I can see,
+	 * the only damage that this can cause is to mess up the repetition
+	 * counter without valuable data being lost.
+	 * TODO: think about a solution that is better than just hoping to be
+	 * lucky.
+	 */
+	last_info = per_cpu_ptr(tr->last_func_repeats, cpu);
+	if (is_repeat_check(tr, last_info, ip, parent_ip))
+		goto out;
+
+	local_save_flags(flags);
+	trace_ctx = tracing_gen_ctx_flags(flags);
+	process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
+
+	trace_function(tr, ip, parent_ip, trace_ctx);
+
+out:
+	ftrace_test_recursion_unlock(bit);
+	preempt_enable_notrace();
+}
+
+static void
+function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
+				     struct ftrace_ops *op,
+				     struct ftrace_regs *fregs)
+{
+	struct trace_func_repeats *last_info;
+	struct trace_array *tr = op->private;
+	struct trace_array_cpu *data;
+	unsigned long flags;
+	long disabled;
+	int cpu;
+	unsigned int trace_ctx;
+
+	if (unlikely(!tr->function_enabled))
+		return;
+
+	/*
+	 * Need to use raw, since this must be called before the
+	 * recursive protection is performed.
+	 */
+	local_irq_save(flags);
+	cpu = raw_smp_processor_id();
+	data = per_cpu_ptr(tr->array_buffer.data, cpu);
+	disabled = atomic_inc_return(&data->disabled);
+
+	if (likely(disabled == 1)) {
+		last_info = per_cpu_ptr(tr->last_func_repeats, cpu);
+		if (is_repeat_check(tr, last_info, ip, parent_ip))
+			goto out;
+
+		trace_ctx = tracing_gen_ctx_flags(flags);
+		process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
+
+		trace_function(tr, ip, parent_ip, trace_ctx);
+		__trace_stack(tr, trace_ctx, STACK_SKIP);
+	}
+
+ out:
+	atomic_dec(&data->disabled);
+	local_irq_restore(flags);
+}
+
 static struct tracer_opt func_opts[] = {
 #ifdef CONFIG_STACKTRACE
 	{ TRACER_OPT(func_stack_trace, TRACE_FUNC_OPT_STACK) },
 #endif
+	{ TRACER_OPT(func-no-repeats, TRACE_FUNC_OPT_NO_REPEATS) },
 	{ } /* Always set a last empty entry */
 };
 
@@ -267,6 +420,9 @@ func_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 	if (tr->ops->func == func)
 		return 0;
 
+	if (!handle_func_repeats(tr, new_flags))
+		return -ENOMEM;
+
 	unregister_ftrace_function(tr->ops);
 	tr->ops->func = func;
 	register_ftrace_function(tr->ops);
-- 
2.30.1


