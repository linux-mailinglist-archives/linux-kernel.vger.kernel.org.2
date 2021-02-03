Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F15930DD42
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhBCOwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:52:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233351AbhBCOwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:52:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0302B64E2E;
        Wed,  3 Feb 2021 14:51:20 +0000 (UTC)
Date:   Wed, 3 Feb 2021 09:51:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>
Subject: [GIT PULL] tracing: Fixes for 5.11-rc5
Message-ID: <20210203095119.6627cd56@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes:

 - Initialize tracing-graph-pause at task creation, not start of
   function tracing. Causes the pause counter to be corrupted.
 - Set "pause-on-trace" for latency tracers as that option breaks
   their output (regression).
 - Fix the wrong error return for setting kretprobes on future
   modules (before they are loaded).
 - Fix re-registering the same kretprobe.
 - Add missing value check for added RCU variable reload.


Please pull the latest trace-v5.11-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.11-rc5

Tag SHA1: 829bb4de5bb3102d8e2bf2031c05641b2101e437
Head SHA1: c8b186a8d54d7e12d28e9f9686cb00ff18fc2ab2


Alexey Kardashevskiy (1):
      tracepoint: Fix race between tracing and removing tracepoint

Masami Hiramatsu (1):
      tracing/kprobe: Fix to support kretprobe events on unloaded modules

Steven Rostedt (VMware) (1):
      fgraph: Initialize tracing_graph_pause at task creation

Viktor Rosendahl (1):
      tracing: Use pause-on-trace with the latency tracers

Wang ShaoBo (1):
      kretprobe: Avoid re-registration of the same kretprobe earlier

----
 include/linux/kprobes.h      |  2 +-
 include/linux/tracepoint.h   | 12 +++++++-----
 init/init_task.c             |  3 ++-
 kernel/kprobes.c             | 36 ++++++++++++++++++++++++++++--------
 kernel/trace/fgraph.c        |  2 --
 kernel/trace/trace_irqsoff.c |  4 ++++
 kernel/trace/trace_kprobe.c  | 10 ++++++----
 7 files changed, 48 insertions(+), 21 deletions(-)
---------------------------
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index b3a36b0cfc81..1883a4a9f16a 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -266,7 +266,7 @@ extern void kprobes_inc_nmissed_count(struct kprobe *p);
 extern bool arch_within_kprobe_blacklist(unsigned long addr);
 extern int arch_populate_kprobe_blacklist(void);
 extern bool arch_kprobe_on_func_entry(unsigned long offset);
-extern bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset);
+extern int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset);
 
 extern bool within_kprobe_blacklist(unsigned long addr);
 extern int kprobe_add_ksym_blacklist(unsigned long entry);
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 0f21617f1a66..966ed8980327 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -307,11 +307,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 									\
 		it_func_ptr =						\
 			rcu_dereference_raw((&__tracepoint_##_name)->funcs); \
-		do {							\
-			it_func = (it_func_ptr)->func;			\
-			__data = (it_func_ptr)->data;			\
-			((void(*)(void *, proto))(it_func))(__data, args); \
-		} while ((++it_func_ptr)->func);			\
+		if (it_func_ptr) {					\
+			do {						\
+				it_func = (it_func_ptr)->func;		\
+				__data = (it_func_ptr)->data;		\
+				((void(*)(void *, proto))(it_func))(__data, args); \
+			} while ((++it_func_ptr)->func);		\
+		}							\
 		return 0;						\
 	}								\
 	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
diff --git a/init/init_task.c b/init/init_task.c
index 8a992d73e6fb..3711cdaafed2 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -198,7 +198,8 @@ struct task_struct init_task
 	.lockdep_recursion = 0,
 #endif
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	.ret_stack	= NULL,
+	.ret_stack		= NULL,
+	.tracing_graph_pause	= ATOMIC_INIT(0),
 #endif
 #if defined(CONFIG_TRACING) && defined(CONFIG_PREEMPTION)
 	.trace_recursion = 0,
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f7fb5d135930..d5a3eb74a657 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1954,28 +1954,48 @@ bool __weak arch_kprobe_on_func_entry(unsigned long offset)
 	return !offset;
 }
 
-bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
+/**
+ * kprobe_on_func_entry() -- check whether given address is function entry
+ * @addr: Target address
+ * @sym:  Target symbol name
+ * @offset: The offset from the symbol or the address
+ *
+ * This checks whether the given @addr+@offset or @sym+@offset is on the
+ * function entry address or not.
+ * This returns 0 if it is the function entry, or -EINVAL if it is not.
+ * And also it returns -ENOENT if it fails the symbol or address lookup.
+ * Caller must pass @addr or @sym (either one must be NULL), or this
+ * returns -EINVAL.
+ */
+int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
 {
 	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset);
 
 	if (IS_ERR(kp_addr))
-		return false;
+		return PTR_ERR(kp_addr);
 
-	if (!kallsyms_lookup_size_offset((unsigned long)kp_addr, NULL, &offset) ||
-						!arch_kprobe_on_func_entry(offset))
-		return false;
+	if (!kallsyms_lookup_size_offset((unsigned long)kp_addr, NULL, &offset))
+		return -ENOENT;
 
-	return true;
+	if (!arch_kprobe_on_func_entry(offset))
+		return -EINVAL;
+
+	return 0;
 }
 
 int register_kretprobe(struct kretprobe *rp)
 {
-	int ret = 0;
+	int ret;
 	struct kretprobe_instance *inst;
 	int i;
 	void *addr;
 
-	if (!kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset))
+	ret = kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset);
+	if (ret)
+		return ret;
+
+	/* If only rp->kp.addr is specified, check reregistering kprobes */
+	if (rp->kp.addr && check_kprobe_rereg(&rp->kp))
 		return -EINVAL;
 
 	if (kretprobe_blacklist_size) {
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 73edb9e4f354..29a6ebeebc9e 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -394,7 +394,6 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
 		}
 
 		if (t->ret_stack == NULL) {
-			atomic_set(&t->tracing_graph_pause, 0);
 			atomic_set(&t->trace_overrun, 0);
 			t->curr_ret_stack = -1;
 			t->curr_ret_depth = -1;
@@ -489,7 +488,6 @@ static DEFINE_PER_CPU(struct ftrace_ret_stack *, idle_ret_stack);
 static void
 graph_init_task(struct task_struct *t, struct ftrace_ret_stack *ret_stack)
 {
-	atomic_set(&t->tracing_graph_pause, 0);
 	atomic_set(&t->trace_overrun, 0);
 	t->ftrace_timestamp = 0;
 	/* make curr_ret_stack visible before we add the ret_stack */
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index d06aab4dcbb8..6756379b661f 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -562,6 +562,8 @@ static int __irqsoff_tracer_init(struct trace_array *tr)
 	/* non overwrite screws up the latency tracers */
 	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, 1);
 	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, 1);
+	/* without pause, we will produce garbage if another latency occurs */
+	set_tracer_flag(tr, TRACE_ITER_PAUSE_ON_TRACE, 1);
 
 	tr->max_latency = 0;
 	irqsoff_trace = tr;
@@ -583,11 +585,13 @@ static void __irqsoff_tracer_reset(struct trace_array *tr)
 {
 	int lat_flag = save_flags & TRACE_ITER_LATENCY_FMT;
 	int overwrite_flag = save_flags & TRACE_ITER_OVERWRITE;
+	int pause_flag = save_flags & TRACE_ITER_PAUSE_ON_TRACE;
 
 	stop_irqsoff_tracer(tr, is_graph(tr));
 
 	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, lat_flag);
 	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, overwrite_flag);
+	set_tracer_flag(tr, TRACE_ITER_PAUSE_ON_TRACE, pause_flag);
 	ftrace_reset_array_ops(tr);
 
 	irqsoff_busy = false;
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index e6fba1798771..56c7fbff7bd7 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -221,9 +221,9 @@ bool trace_kprobe_on_func_entry(struct trace_event_call *call)
 {
 	struct trace_kprobe *tk = trace_kprobe_primary_from_call(call);
 
-	return tk ? kprobe_on_func_entry(tk->rp.kp.addr,
+	return tk ? (kprobe_on_func_entry(tk->rp.kp.addr,
 			tk->rp.kp.addr ? NULL : tk->rp.kp.symbol_name,
-			tk->rp.kp.addr ? 0 : tk->rp.kp.offset) : false;
+			tk->rp.kp.addr ? 0 : tk->rp.kp.offset) == 0) : false;
 }
 
 bool trace_kprobe_error_injectable(struct trace_event_call *call)
@@ -828,9 +828,11 @@ static int trace_kprobe_create(int argc, const char *argv[])
 		}
 		if (is_return)
 			flags |= TPARG_FL_RETURN;
-		if (kprobe_on_func_entry(NULL, symbol, offset))
+		ret = kprobe_on_func_entry(NULL, symbol, offset);
+		if (ret == 0)
 			flags |= TPARG_FL_FENTRY;
-		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
+		/* Defer the ENOENT case until register kprobe */
+		if (ret == -EINVAL && is_return) {
 			trace_probe_log_err(0, BAD_RETPROBE);
 			goto parse_error;
 		}
