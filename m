Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94144288E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhJKIgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 04:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbhJKIgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:36:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7C3C061762
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 01:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hbnZ7qh/ffjl0gXMr1dqtb8BMzNP58udI8EpQGoAKgU=; b=jPetWT0vpIrrhWLocXWse8QFIl
        Y1S0RM2JkqKEXIRgMr5/eZNV1aGZkeFngEbQ8nr7XgkQuvYXAZyoCm5MHf4FqRyx4zL7CXXmD1C7Z
        YvgPyMsYdaQ/aRKjE9FfE4zcn1BjclMPnjxQqBPeTfECDlgNIMr39pBBc95sC/hX4BuHpKfehuO25
        /mRt5c+YiJGrmzqEvoABxKxxM/Y6TApaTnRQZNf8tZcE3H5JKFOmK8hdfA7r85OzGJnNYkCnXIlLw
        IJCnKHGjkDeHVxKTc6kWyJY1RxWfl4CjqFvPbTDRTQutGkg+yi6LUfkrhBTKAlVKOfU86dLeUGURK
        mGejlbhw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZqjn-005NZu-F5; Mon, 11 Oct 2021 08:33:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB19530032E;
        Mon, 11 Oct 2021 10:32:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D2AD201E521F; Mon, 11 Oct 2021 10:32:46 +0200 (CEST)
Date:   Mon, 11 Oct 2021 10:32:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RESEND PATCH v2] trace: prevent preemption in
 perf_ftrace_function_call()
Message-ID: <YWP2rtX9Ol9dZc/l@hirez.programming.kicks-ass.net>
References: <eafba880-c1ae-2b99-c11e-d5041a2f6c3e@linux.alibaba.com>
 <20211008200328.5b88422d@oasis.local.home>
 <bcdbccc6-a516-2199-d3be-090a5e9f601d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcdbccc6-a516-2199-d3be-090a5e9f601d@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 10:38:39AM +0800, 王贇 wrote:
> 
> 
> On 2021/10/9 上午8:03, Steven Rostedt wrote:
> > On Tue, 28 Sep 2021 11:12:24 +0800
> > 王贇 <yun.wang@linux.alibaba.com> wrote:
> > 
> >> With CONFIG_DEBUG_PREEMPT we observed reports like:
> >>
> >>   BUG: using smp_processor_id() in preemptible
> >>   caller is perf_ftrace_function_call+0x6f/0x2e0
> >>   CPU: 1 PID: 680 Comm: a.out Not tainted
> >>   Call Trace:
> >>    <TASK>
> >>    dump_stack_lvl+0x8d/0xcf
> >>    check_preemption_disabled+0x104/0x110
> >>    ? optimize_nops.isra.7+0x230/0x230
> >>    ? text_poke_bp_batch+0x9f/0x310
> >>    perf_ftrace_function_call+0x6f/0x2e0
> >>    ...
> > 
> > It would be useful to see the full backtrace, to know how this
> > happened. Please do not shorten back traces.
> 
> Here it is, I suppose some where on the path of __text_poke failed to
> exempt from ftrace, whose context is allowed to be preempted?

Urgh, 'funny' trace that... it ends up tracing text_poke while it's
installing the ftrace handlers.

But no, that looks quite all right.

Your patch is also right, I think, except we can improve upon it by
having that recursion_trylock imply preemption disable (as is proper for
a 'lock').

Also, make sure to disable preemption before, and enable it after,
taking, or releasing, the lock. That way we don't have preemption holes.

---
 arch/csky/kernel/probes/ftrace.c     |  2 --
 arch/parisc/kernel/ftrace.c          |  2 --
 arch/powerpc/kernel/kprobes-ftrace.c |  2 --
 arch/s390/kernel/ftrace.c            |  2 --
 arch/x86/kernel/kprobes/ftrace.c     |  2 --
 include/linux/trace_recursion.h      | 10 +++++++++-
 kernel/livepatch/patch.c             |  6 ------
 kernel/trace/trace_functions.c       |  5 -----
 8 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
index ef2bb9bd9605..dff7921531ef 100644
--- a/arch/csky/kernel/probes/ftrace.c
+++ b/arch/csky/kernel/probes/ftrace.c
@@ -24,7 +24,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		return;
 
 	regs = ftrace_get_regs(fregs);
-	preempt_disable_notrace();
 	p = get_kprobe((kprobe_opcode_t *)ip);
 	if (!p) {
 		p = get_kprobe((kprobe_opcode_t *)(ip - MCOUNT_INSN_SIZE));
@@ -64,7 +63,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		__this_cpu_write(current_kprobe, NULL);
 	}
 out:
-	preempt_enable_notrace();
 	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(kprobe_ftrace_handler);
diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index 0a1e75af5382..3543496174d3 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -216,7 +216,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		return;
 
 	regs = ftrace_get_regs(fregs);
-	preempt_disable_notrace();
 	p = get_kprobe((kprobe_opcode_t *)ip);
 	if (unlikely(!p) || kprobe_disabled(p))
 		goto out;
@@ -245,7 +244,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
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
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 1d94ffdf347b..fa1e3510ea98 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -367,7 +367,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		return;
 
 	regs = ftrace_get_regs(fregs);
-	preempt_disable_notrace();
 	p = get_kprobe((kprobe_opcode_t *)ip);
 	if (unlikely(!p) || kprobe_disabled(p))
 		goto out;
@@ -395,7 +394,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	}
 	__this_cpu_write(current_kprobe, NULL);
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
index a9f9c5714e65..ca12e2d8e060 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -214,7 +214,14 @@ static __always_inline void trace_clear_recursion(int bit)
 static __always_inline int ftrace_test_recursion_trylock(unsigned long ip,
 							 unsigned long parent_ip)
 {
-	return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START, TRACE_FTRACE_MAX);
+	bool ret;
+
+	preempt_disable_notrace();
+	ret = trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START, TRACE_FTRACE_MAX);
+	if (!ret)
+		preempt_enable_notrace();
+
+	return ret;
 }
 
 /**
@@ -226,6 +233,7 @@ static __always_inline int ftrace_test_recursion_trylock(unsigned long ip,
 static __always_inline void ftrace_test_recursion_unlock(int bit)
 {
 	trace_clear_recursion(bit);
+	preempt_enable_notrace();
 }
 
 #endif /* CONFIG_TRACING */
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index e8029aea67f1..6e66ccdefaa9 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -52,11 +52,6 @@ static void notrace klp_ftrace_handler(unsigned long ip,
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
@@ -120,7 +115,6 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 	klp_arch_set_pc(fregs, (unsigned long)func->new_func);
 
 unlock:
-	preempt_enable_notrace();
 	ftrace_test_recursion_unlock(bit);
 }
 
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
