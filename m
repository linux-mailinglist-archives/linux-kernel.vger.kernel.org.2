Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC81043CE64
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243119AbhJ0QNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242955AbhJ0QM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:12:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BAC5610FD;
        Wed, 27 Oct 2021 16:10:03 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mflV4-000xtS-Gl;
        Wed, 27 Oct 2021 12:10:02 -0400
Message-ID: <20211027161002.350042850@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 12:09:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Guo Ren <guoren@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Abaci <abaci@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Wang <yun.wang@linux.alibaba.com>
Subject: [for-next][PATCH 14/15] ftrace: disable preemption when recursion locked
References: <20211027160940.084904334@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: =?UTF-8?q?=E7=8E=8B=E8=B4=87?= <yun.wang@linux.alibaba.com>

As the documentation explained, ftrace_test_recursion_trylock()
and ftrace_test_recursion_unlock() were supposed to disable and
enable preemption properly, however currently this work is done
outside of the function, which could be missing by mistake.

And since the internal using of trace_test_and_set_recursion()
and trace_clear_recursion() also require preemption disabled, we
can just merge the logical.

This patch will make sure the preemption has been disabled when
trace_test_and_set_recursion() return bit >= 0, and
trace_clear_recursion() will enable the preemption if previously
enabled.

Link: https://lkml.kernel.org/r/13bde807-779c-aa4c-0672-20515ae365ea@linux.alibaba.com

CC: Petr Mladek <pmladek@suse.com>
Cc: Guo Ren <guoren@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Jisheng Zhang <jszhang@kernel.org>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Miroslav Benes <mbenes@suse.cz>
Reported-by: Abaci <abaci@linux.alibaba.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
[ Removed extra line in comment - SDR ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/csky/kernel/probes/ftrace.c     |  2 --
 arch/parisc/kernel/ftrace.c          |  2 --
 arch/powerpc/kernel/kprobes-ftrace.c |  2 --
 arch/riscv/kernel/probes/ftrace.c    |  2 --
 arch/x86/kernel/kprobes/ftrace.c     |  2 --
 include/linux/trace_recursion.h      | 11 ++++++++++-
 kernel/livepatch/patch.c             | 12 ++++++------
 kernel/trace/ftrace.c                | 15 +++++----------
 kernel/trace/trace_functions.c       |  5 -----
 9 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
index b388228abbf2..834cffcfbce3 100644
--- a/arch/csky/kernel/probes/ftrace.c
+++ b/arch/csky/kernel/probes/ftrace.c
@@ -17,7 +17,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		return;
 
 	regs = ftrace_get_regs(fregs);
-	preempt_disable_notrace();
 	p = get_kprobe((kprobe_opcode_t *)ip);
 	if (!p) {
 		p = get_kprobe((kprobe_opcode_t *)(ip - MCOUNT_INSN_SIZE));
@@ -57,7 +56,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		__this_cpu_write(current_kprobe, NULL);
 	}
 out:
-	preempt_enable_notrace();
 	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(kprobe_ftrace_handler);
diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index 01581f715737..b14011d3c2f1 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -211,7 +211,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		return;
 
 	regs = ftrace_get_regs(fregs);
-	preempt_disable_notrace();
 	p = get_kprobe((kprobe_opcode_t *)ip);
 	if (unlikely(!p) || kprobe_disabled(p))
 		goto out;
@@ -240,7 +239,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	}
 	__this_cpu_write(current_kprobe, NULL);
 out:
-	preempt_enable_notrace();
 	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(kprobe_ftrace_handler);
diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
index 7154d58338cc..072ebe7f290b 100644
--- a/arch/powerpc/kernel/kprobes-ftrace.c
+++ b/arch/powerpc/kernel/kprobes-ftrace.c
@@ -26,7 +26,6 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 		return;
 
 	regs = ftrace_get_regs(fregs);
-	preempt_disable_notrace();
 	p = get_kprobe((kprobe_opcode_t *)nip);
 	if (unlikely(!p) || kprobe_disabled(p))
 		goto out;
@@ -61,7 +60,6 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 		__this_cpu_write(current_kprobe, NULL);
 	}
 out:
-	preempt_enable_notrace();
 	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(kprobe_ftrace_handler);
diff --git a/arch/riscv/kernel/probes/ftrace.c b/arch/riscv/kernel/probes/ftrace.c
index aab85a82f419..7142ec42e889 100644
--- a/arch/riscv/kernel/probes/ftrace.c
+++ b/arch/riscv/kernel/probes/ftrace.c
@@ -15,7 +15,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
-	preempt_disable_notrace();
 	p = get_kprobe((kprobe_opcode_t *)ip);
 	if (unlikely(!p) || kprobe_disabled(p))
 		goto out;
@@ -52,7 +51,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		__this_cpu_write(current_kprobe, NULL);
 	}
 out:
-	preempt_enable_notrace();
 	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(kprobe_ftrace_handler);
diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index 596de2f6d3a5..dd2ec14adb77 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -25,7 +25,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
-	preempt_disable_notrace();
 	p = get_kprobe((kprobe_opcode_t *)ip);
 	if (unlikely(!p) || kprobe_disabled(p))
 		goto out;
@@ -59,7 +58,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		__this_cpu_write(current_kprobe, NULL);
 	}
 out:
-	preempt_enable_notrace();
 	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(kprobe_ftrace_handler);
diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index 24f284eb55a7..a13f23b04d73 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -155,6 +155,9 @@ extern void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip);
 # define do_ftrace_record_recursion(ip, pip)	do { } while (0)
 #endif
 
+/*
+ * Preemption is promised to be disabled when return bit >= 0.
+ */
 static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsigned long pip,
 							int start, int max)
 {
@@ -189,14 +192,20 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 	current->trace_recursion = val;
 	barrier();
 
+	preempt_disable_notrace();
+
 	return bit + 1;
 }
 
+/*
+ * Preemption will be enabled (if it was previously enabled).
+ */
 static __always_inline void trace_clear_recursion(int bit)
 {
 	if (!bit)
 		return;
 
+	preempt_enable_notrace();
 	barrier();
 	bit--;
 	trace_recursion_clear(bit);
@@ -209,7 +218,7 @@ static __always_inline void trace_clear_recursion(int bit)
  * tracing recursed in the same context (normal vs interrupt),
  *
  * Returns: -1 if a recursion happened.
- *           >= 0 if no recursion
+ *           >= 0 if no recursion.
  */
 static __always_inline int ftrace_test_recursion_trylock(unsigned long ip,
 							 unsigned long parent_ip)
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index e8029aea67f1..fe316c021d73 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -49,14 +49,15 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 
 	ops = container_of(fops, struct klp_ops, fops);
 
+	/*
+	 * The ftrace_test_recursion_trylock() will disable preemption,
+	 * which is required for the variant of synchronize_rcu() that is
+	 * used to allow patching functions where RCU is not watching.
+	 * See klp_synchronize_transition() for more details.
+	 */
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (WARN_ON_ONCE(bit < 0))
 		return;
-	/*
-	 * A variant of synchronize_rcu() is used to allow patching functions
-	 * where RCU is not watching, see klp_synchronize_transition().
-	 */
-	preempt_disable_notrace();
 
 	func = list_first_or_null_rcu(&ops->func_stack, struct klp_func,
 				      stack_node);
@@ -120,7 +121,6 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 	klp_arch_set_pc(fregs, (unsigned long)func->new_func);
 
 unlock:
-	preempt_enable_notrace();
 	ftrace_test_recursion_unlock(bit);
 }
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 2057ad363772..b4ed1a301232 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7198,16 +7198,15 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 	struct ftrace_ops *op;
 	int bit;
 
+	/*
+	 * The ftrace_test_and_set_recursion() will disable preemption,
+	 * which is required since some of the ops may be dynamically
+	 * allocated, they must be freed after a synchronize_rcu().
+	 */
 	bit = trace_test_and_set_recursion(ip, parent_ip, TRACE_LIST_START, TRACE_LIST_MAX);
 	if (bit < 0)
 		return;
 
-	/*
-	 * Some of the ops may be dynamically allocated,
-	 * they must be freed after a synchronize_rcu().
-	 */
-	preempt_disable_notrace();
-
 	do_for_each_ftrace_op(op, ftrace_ops_list) {
 		/* Stub functions don't need to be called nor tested */
 		if (op->flags & FTRACE_OPS_FL_STUB)
@@ -7231,7 +7230,6 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 		}
 	} while_for_each_ftrace_op(op);
 out:
-	preempt_enable_notrace();
 	trace_clear_recursion(bit);
 }
 
@@ -7279,12 +7277,9 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
-	preempt_disable_notrace();
-
 	if (!(op->flags & FTRACE_OPS_FL_RCU) || rcu_is_watching())
 		op->func(ip, parent_ip, op, fregs);
 
-	preempt_enable_notrace();
 	trace_clear_recursion(bit);
 }
 NOKPROBE_SYMBOL(ftrace_ops_assist_func);
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 1f0e63f5d1f9..9f1bfbe105e8 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -186,7 +186,6 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 		return;
 
 	trace_ctx = tracing_gen_ctx();
-	preempt_disable_notrace();
 
 	cpu = smp_processor_id();
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
@@ -194,7 +193,6 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 		trace_function(tr, ip, parent_ip, trace_ctx);
 
 	ftrace_test_recursion_unlock(bit);
-	preempt_enable_notrace();
 }
 
 #ifdef CONFIG_UNWINDER_ORC
@@ -298,8 +296,6 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
-	preempt_disable_notrace();
-
 	cpu = smp_processor_id();
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
 	if (atomic_read(&data->disabled))
@@ -324,7 +320,6 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
 
 out:
 	ftrace_test_recursion_unlock(bit);
-	preempt_enable_notrace();
 }
 
 static void
-- 
2.33.0
