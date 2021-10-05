Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35FC421E03
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 07:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhJEFhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 01:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230403AbhJEFhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 01:37:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C3F26128A;
        Tue,  5 Oct 2021 05:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633412120;
        bh=c0zOIE7vt4wKW/TfMgZHiuu+ZBb42iLRmo41vPhT7Fk=;
        h=Date:From:To:Cc:Subject:From;
        b=QDEQAFezSOBQnY5i4XdlnmdV0NRKTV6AZr2eKazTY1WOBrykfPK32LUm4EB20mVTG
         jFXNOrT+sBrUp0+EewY8pfc3fIJfSSZZu3wzmdoGAsRRII3rlS9g63e02/dbDnIe8G
         NdJdJIs+iFA0TmlEuMmCwkYNwPnhZsVX0ntqIlkzxfqX1nMl0RyBLmOnfDHhkL59EW
         RGVfthiZUZfro0dFCUkJcQSIXaAtU4P4AtfF/c+BRN++RB1EHgKbZhE7ay4vw0sOMh
         qdlpzdPnh56RqvufEtr7dzr2ARqtxVrVNqFen/404yYalT92ZMQqSNikps7/S7x2AW
         AkZyjWiLstxuA==
Date:   Tue, 5 Oct 2021 00:39:22 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] ftrace: Fix -Wcast-function-type warnings on powerpc64
Message-ID: <20211005053922.GA702049@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make sure new function cast mismatches are not introduced
in the kernel (to avoid tripping CFI checking), the kernel should be
globally built with -Wcast-function-type.

So, fix the following -Wcast-function-type warnings on powerpc64
(ppc64_defconfig):

kernel/trace/ftrace.c: In function 'ftrace_ops_get_list_func':
kernel/trace/ftrace.c:128:31: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)' [-Wcast-function-type]
  128 | #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
      |                               ^
kernel/trace/ftrace.c:174:10: note: in expansion of macro 'ftrace_ops_list_func'
  174 |   return ftrace_ops_list_func;
      |          ^~~~~~~~~~~~~~~~~~~~
kernel/trace/ftrace.c: In function 'update_ftrace_function':
kernel/trace/ftrace.c:128:31: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)' [-Wcast-function-type]
  128 | #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
      |                               ^
kernel/trace/ftrace.c:207:10: note: in expansion of macro 'ftrace_ops_list_func'
  207 |   func = ftrace_ops_list_func;
      |          ^~~~~~~~~~~~~~~~~~~~
kernel/trace/ftrace.c:128:31: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)' [-Wcast-function-type]
  128 | #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
      |                               ^
kernel/trace/ftrace.c:220:14: note: in expansion of macro 'ftrace_ops_list_func'
  220 |  if (func == ftrace_ops_list_func) {
      |              ^~~~~~~~~~~~~~~~~~~~
kernel/trace/ftrace.c: In function 'ftrace_modify_all_code':
kernel/trace/ftrace.c:128:31: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)' [-Wcast-function-type]
  128 | #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
      |                               ^
kernel/trace/ftrace.c:2698:35: note: in expansion of macro 'ftrace_ops_list_func'
 2698 |   err = ftrace_update_ftrace_func(ftrace_ops_list_func);
      |                                   ^~~~~~~~~~~~~~~~~~~~
kernel/trace/ftrace.c:128:31: warning: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)' [-Wcast-function-type]

  128 | #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
      |                               ^
kernel/trace/ftrace.c:2708:41: note: in expansion of macro 'ftrace_ops_list_func'
 2708 |  if (update && ftrace_trace_function != ftrace_ops_list_func) {

Link: https://github.com/KSPP/linux/issues/20
Link: https://lore.kernel.org/lkml/20210930095300.73be1555@canb.auug.org.au/
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---

Hi Steven,

I need your help here, please. In particular to review the following
pieces of code:

 @@ -142,6 +142,7 @@ static inline void ftrace_ops_init(struct ftrace_ops *ops)
 static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
                            struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 +#if ARCH_SUPPORTS_FTRACE_OPS
        struct trace_array *tr = op->private;
        int pid;
 
 @@ -155,6 +156,7 @@ static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
        }
 
        op->saved_func(ip, parent_ip, op, fregs);
 +#endif

 @@ -7006,7 +7008,11 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
                                pr_warn("op=%p %pS\n", op, op);
                                goto out;
                        }
 +#if ARCH_SUPPORTS_FTRACE_OPS
                        op->func(ip, parent_ip, op, fregs);
 +#else
 +                       op->func(ip, parent_ip);
 +#endif
                }
        } while_for_each_ftrace_op(op);
 out:

 @@ -7050,6 +7056,7 @@ NOKPROBE_SYMBOL(ftrace_ops_no_ops);
 static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
                                   struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 +#if ARCH_SUPPORTS_FTRACE_OPS
        int bit;
 
        bit = trace_test_and_set_recursion(ip, parent_ip, TRACE_LIST_START, TRACE_LIST_MAX);
 @@ -7063,6 +7070,7 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
 
        preempt_enable_notrace();
        trace_clear_recursion(bit);
 +#endif
 }

Not sure if the above is the right solution when ARCH_SUPPORTS_FTRACE_OPS
is not supported. So, this is my first try to solve this issue.

JFYI: These are the last know -Wcast-function-type warnings. So, after
fixing this we will able to enable -Wcast-function-type, globally.

Thanks!

 include/linux/ftrace.h            |  7 +++++++
 kernel/trace/fgraph.c             |  2 +-
 kernel/trace/ftrace.c             | 34 +++++++++++++++++++------------
 kernel/trace/trace_event_perf.c   |  2 +-
 kernel/trace/trace_functions.c    | 10 ++++-----
 kernel/trace/trace_sched_wakeup.c |  2 +-
 kernel/trace/trace_stack.c        |  2 +-
 7 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 832e65f06754..30ff2f8c5107 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -114,8 +114,15 @@ static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs
 	return arch_ftrace_get_regs(fregs);
 }
 
+#if ARCH_SUPPORTS_FTRACE_OPS
 typedef void (*ftrace_func_t)(unsigned long ip, unsigned long parent_ip,
 			      struct ftrace_ops *op, struct ftrace_regs *fregs);
+#else
+typedef void (*ftrace_func_t)(unsigned long ip, unsigned long parent_ip);
+#endif
+
+typedef void (*ftrace_func_base_t)(void);
+#define CAST_FTRACE_FUNC(f) ((ftrace_func_t)((ftrace_func_base_t)(f)))
 
 ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops);
 
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index b8a0d1d564fb..874eff384ca8 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -333,7 +333,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 #endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
 
 static struct ftrace_ops graph_ops = {
-	.func			= ftrace_stub,
+	.func			= CAST_FTRACE_FUNC(ftrace_stub),
 	.flags			= FTRACE_OPS_FL_INITIALIZED |
 				   FTRACE_OPS_FL_PID |
 				   FTRACE_OPS_FL_STUB,
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f15badf31f52..7c9f11920773 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -79,7 +79,7 @@ enum {
 };
 
 struct ftrace_ops ftrace_list_end __read_mostly = {
-	.func		= ftrace_stub,
+	.func		= CAST_FTRACE_FUNC(ftrace_stub),
 	.flags		= FTRACE_OPS_FL_STUB,
 	INIT_OPS_HASH(ftrace_list_end)
 };
@@ -116,7 +116,7 @@ static int ftrace_disabled __read_mostly;
 DEFINE_MUTEX(ftrace_lock);
 
 struct ftrace_ops __rcu *ftrace_ops_list __read_mostly = &ftrace_list_end;
-ftrace_func_t ftrace_trace_function __read_mostly = ftrace_stub;
+ftrace_func_t ftrace_trace_function __read_mostly = CAST_FTRACE_FUNC(ftrace_stub);
 struct ftrace_ops global_ops;
 
 #if ARCH_SUPPORTS_FTRACE_OPS
@@ -142,6 +142,7 @@ static inline void ftrace_ops_init(struct ftrace_ops *ops)
 static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
 			    struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
+#if ARCH_SUPPORTS_FTRACE_OPS
 	struct trace_array *tr = op->private;
 	int pid;
 
@@ -155,6 +156,7 @@ static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
 	}
 
 	op->saved_func(ip, parent_ip, op, fregs);
+#endif
 }
 
 static void ftrace_sync_ipi(void *data)
@@ -190,7 +192,7 @@ static void update_ftrace_function(void)
 
 	/* If there's no ftrace_ops registered, just call the stub function */
 	if (set_function_trace_op == &ftrace_list_end) {
-		func = ftrace_stub;
+		func = CAST_FTRACE_FUNC(ftrace_stub);
 
 	/*
 	 * If we are at the end of the list and this ops is
@@ -332,7 +334,7 @@ int __register_ftrace_function(struct ftrace_ops *ops)
 	ops->saved_func = ops->func;
 
 	if (ftrace_pids_enabled(ops))
-		ops->func = ftrace_pid_func;
+		ops->func = CAST_FTRACE_FUNC(ftrace_pid_func);
 
 	ftrace_update_trampoline(ops);
 
@@ -367,13 +369,13 @@ static void ftrace_update_pid_func(void)
 	struct ftrace_ops *op;
 
 	/* Only do something if we are tracing something */
-	if (ftrace_trace_function == ftrace_stub)
+	if (ftrace_trace_function == CAST_FTRACE_FUNC(ftrace_stub))
 		return;
 
 	do_for_each_ftrace_op(op, ftrace_ops_list) {
 		if (op->flags & FTRACE_OPS_FL_PID) {
 			op->func = ftrace_pids_enabled(op) ?
-				ftrace_pid_func : op->saved_func;
+				CAST_FTRACE_FUNC(ftrace_pid_func) : op->saved_func;
 			ftrace_update_trampoline(op);
 		}
 	} while_for_each_ftrace_op(op);
@@ -1036,7 +1038,7 @@ static const struct ftrace_hash empty_hash = {
 #define EMPTY_HASH	((struct ftrace_hash *)&empty_hash)
 
 struct ftrace_ops global_ops = {
-	.func				= ftrace_stub,
+	.func				= CAST_FTRACE_FUNC(ftrace_stub),
 	.local_hash.notrace_hash	= EMPTY_HASH,
 	.local_hash.filter_hash		= EMPTY_HASH,
 	INIT_OPS_HASH(global_ops)
@@ -4545,7 +4547,7 @@ register_ftrace_function_probe(char *glob, struct trace_array *tr,
 			return -ENOMEM;
 		}
 		probe->probe_ops = probe_ops;
-		probe->ops.func = function_trace_probe_call;
+		probe->ops.func = CAST_FTRACE_FUNC(function_trace_probe_call);
 		probe->tr = tr;
 		ftrace_ops_init(&probe->ops);
 		list_add(&probe->list, &tr->func_probes);
@@ -6956,7 +6958,7 @@ void ftrace_init_array_ops(struct trace_array *tr, ftrace_func_t func)
 {
 	/* If we filter on pids, update to use the pid function */
 	if (tr->flags & TRACE_ARRAY_FL_GLOBAL) {
-		if (WARN_ON(tr->ops->func != ftrace_stub))
+		if (WARN_ON(tr->ops->func != CAST_FTRACE_FUNC(ftrace_stub)))
 			printk("ftrace ops had %pS for function\n",
 			       tr->ops->func);
 	}
@@ -6966,7 +6968,7 @@ void ftrace_init_array_ops(struct trace_array *tr, ftrace_func_t func)
 
 void ftrace_reset_array_ops(struct trace_array *tr)
 {
-	tr->ops->func = ftrace_stub;
+	tr->ops->func = CAST_FTRACE_FUNC(ftrace_stub);
 }
 
 static nokprobe_inline void
@@ -7006,7 +7008,11 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 				pr_warn("op=%p %pS\n", op, op);
 				goto out;
 			}
+#if ARCH_SUPPORTS_FTRACE_OPS
 			op->func(ip, parent_ip, op, fregs);
+#else
+			op->func(ip, parent_ip);
+#endif
 		}
 	} while_for_each_ftrace_op(op);
 out:
@@ -7050,6 +7056,7 @@ NOKPROBE_SYMBOL(ftrace_ops_no_ops);
 static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
 				   struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
+#if ARCH_SUPPORTS_FTRACE_OPS
 	int bit;
 
 	bit = trace_test_and_set_recursion(ip, parent_ip, TRACE_LIST_START, TRACE_LIST_MAX);
@@ -7063,6 +7070,7 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
 
 	preempt_enable_notrace();
 	trace_clear_recursion(bit);
+#endif
 }
 NOKPROBE_SYMBOL(ftrace_ops_assist_func);
 
@@ -7085,7 +7093,7 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops)
 	 */
 	if (ops->flags & (FTRACE_OPS_FL_RECURSION |
 			  FTRACE_OPS_FL_RCU))
-		return ftrace_ops_assist_func;
+		return CAST_FTRACE_FUNC(ftrace_ops_assist_func);
 
 	return ops->func;
 }
@@ -7521,7 +7529,7 @@ void ftrace_kill(void)
 {
 	ftrace_disabled = 1;
 	ftrace_enabled = 0;
-	ftrace_trace_function = ftrace_stub;
+	ftrace_trace_function = CAST_FTRACE_FUNC(ftrace_stub);
 }
 
 /**
@@ -7622,7 +7630,7 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
 		}
 
 		/* stopping ftrace calls (just send to ftrace_stub) */
-		ftrace_trace_function = ftrace_stub;
+		ftrace_trace_function = CAST_FTRACE_FUNC(ftrace_stub);
 
 		ftrace_shutdown_sysctl();
 	}
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 6aed10e2f7ce..507c9516eb28 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -484,7 +484,7 @@ static int perf_ftrace_function_register(struct perf_event *event)
 {
 	struct ftrace_ops *ops = &event->ftrace_ops;
 
-	ops->func    = perf_ftrace_function_call;
+	ops->func    = CAST_FTRACE_FUNC(perf_ftrace_function_call);
 	ops->private = (void *)(unsigned long)nr_cpu_ids;
 
 	return register_ftrace_function(ops);
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 1f0e63f5d1f9..9ef630f0d4d9 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -62,7 +62,7 @@ int ftrace_allocate_ftrace_ops(struct trace_array *tr)
 		return -ENOMEM;
 
 	/* Currently only the non stack version is supported */
-	ops->func = function_trace_call;
+	ops->func = CAST_FTRACE_FUNC(function_trace_call);
 	ops->flags = FTRACE_OPS_FL_PID;
 
 	tr->ops = ops;
@@ -105,13 +105,13 @@ static ftrace_func_t select_trace_function(u32 flags_val)
 {
 	switch (flags_val & TRACE_FUNC_OPT_MASK) {
 	case TRACE_FUNC_NO_OPTS:
-		return function_trace_call;
+		return CAST_FTRACE_FUNC(function_trace_call);
 	case TRACE_FUNC_OPT_STACK:
-		return function_stack_trace_call;
+		return CAST_FTRACE_FUNC(function_stack_trace_call);
 	case TRACE_FUNC_OPT_NO_REPEATS:
-		return function_no_repeats_trace_call;
+		return CAST_FTRACE_FUNC(function_no_repeats_trace_call);
 	case TRACE_FUNC_OPT_STACK | TRACE_FUNC_OPT_NO_REPEATS:
-		return function_stack_no_repeats_trace_call;
+		return CAST_FTRACE_FUNC(function_stack_no_repeats_trace_call);
 	default:
 		return NULL;
 	}
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 2402de520eca..abcdf48888f7 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -673,7 +673,7 @@ static int __wakeup_tracer_init(struct trace_array *tr)
 
 	tr->max_latency = 0;
 	wakeup_trace = tr;
-	ftrace_init_array_ops(tr, wakeup_tracer_call);
+	ftrace_init_array_ops(tr, CAST_FTRACE_FUNC(wakeup_tracer_call));
 	start_wakeup_tracer(tr);
 
 	wakeup_busy = true;
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 63c285042051..546f769d7de2 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -317,7 +317,7 @@ stack_trace_call(unsigned long ip, unsigned long parent_ip,
 
 static struct ftrace_ops trace_ops __read_mostly =
 {
-	.func = stack_trace_call,
+	.func = CAST_FTRACE_FUNC(stack_trace_call),
 };
 
 static ssize_t
-- 
2.27.0

