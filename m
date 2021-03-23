Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73B0345C84
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhCWLMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhCWLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:11:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24DAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 04:11:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id dm8so22983298edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 04:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h99mrYzfsAwlTiTzu15Mp7yHjt4opABk4ZadMmFWJmA=;
        b=OrK1UFdM90mDCYLzFzULlN/dOqwuInUPzHlAVrNxBnkPKaE/Nr2dEbMI/M272SzM+D
         VC9kYrkaAu4GWOu11ZTKBNCbNB0gK0zqIuswJXmRiYnc2MMEOu479d97PNfD1REQ8FGy
         trkO+7HkA1dWizzBokNRnsNjE3woHC9jQOgtLBXRGXhmO3OCl7ZaJjJYMVN9H3xVes6Z
         CO0LwTQpAVocXT6c+R+AA+jrEe9/Dm2NHvtuTegIDPpPXVVpY0Q9S0fAMN6Vc1Jtno6l
         v/EnK6PAczFQ76Vk6fF6HLKUC26iSLXFds+zkgj8DZE1wX92Ymj7OaEDsm4RZIk1IXsw
         zVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=h99mrYzfsAwlTiTzu15Mp7yHjt4opABk4ZadMmFWJmA=;
        b=MOEFfeRyg9z3hok18ZamIM97HdXbQQ2L8EcNi6qtFLpJxqFKlq7MS2AJmO7fWLvmKi
         5sJuZzJyb0WzSl702VNguWQzA7nl/MuCY1GN8/PoSpnmszLzmqpejRm0AjPDeUP6OIe/
         Hc4gFVCNgkyRt0AEdDDv+5bwo9uvyD3PSM4plia0iktBpamcqgYIn8ANW51sx8KMx3LR
         AlaFuTU/TKGLG0Hy/v5o+mmsweHfoHtem/bV8Rp3VgIVlWkOxNiKPH/MtFS96SPYa0mQ
         S3DxxVapC1tJS5WRBV3Ck9wicWBIdDQ5F2Sykd6D0TWUDzWxbG7MMCitqsJ78+DY2txZ
         rFmQ==
X-Gm-Message-State: AOAM532c92f/AG+Dbnek6DILDhJOM9ZSL6ZhP5PfjrHhujdbS+KqJWm1
        B2aiyjaFrUotoJ/7u3iHZiw=
X-Google-Smtp-Source: ABdhPJzQOdrQTzcDxcWNY0rS+HzbaG7r25lcU4awU9IWKul4IktgzRX2BIkUzipiF2Ne8jIzKw9k7g==
X-Received: by 2002:aa7:cf02:: with SMTP id a2mr3990695edy.59.1616497912470;
        Tue, 23 Mar 2021 04:11:52 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id mp12sm2724807ejc.1.2021.03.23.04.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 04:11:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 23 Mar 2021 12:11:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: [PATCH, -v2] tracing: Fix various typos in comments
Message-ID: <20210323111150.GA3939639@gmail.com>
References: <20210322224546.GA1981273@gmail.com>
 <5e563a58-2ed6-3a1a-d92d-231fb6eecfa9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e563a58-2ed6-3a1a-d92d-231fb6eecfa9@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Randy Dunlap <rdunlap@infradead.org> wrote:

> > @@ -748,7 +748,7 @@ BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
> >  		fmt_cnt++;
> >  	}
> >  
> > -	/* Maximumly we can have MAX_SEQ_PRINTF_VARARGS parameter, just give
> > +	/* Maximum we can have MAX_SEQ_PRINTF_VARARGS parameter, just give
> 
> That's awkward either way IMO. How about:
>
> 	/* The maximum we can have is MAX_SEQ_PRINTF_VARARGS parameters, so just give

OK, fixed.

> >  	/*
> >  	 * Skip graph tracing if the return location is served by direct trampoline,
> > -	 * since call sequence and return addresses is unpredicatable anymore.
> > +	 * since call sequence and return addresses is unpredictable anymore.
> 
> 	                                            are

Agreed, but the 'anymore' at the end is wrong too I think:

  s/anymore/anyway

I.e.:

        /*
         * Skip graph tracing if the return location is served by direct trampoline,
         * since call sequence and return addresses are unpredictable anyway.
         * Ex: BPF trampoline may call original function and may skip frame
         * depending on type of BPF programs attached.
         */

> > @@ -3367,7 +3367,7 @@ int trace_array_vprintk(struct trace_array *tr,
> >   * buffer (use trace_printk() for that), as writing into the top level
> >   * buffer should only have events that can be individually disabled.
> >   * trace_printk() is only used for debugging a kernel, and should not
> > - * be ever encorporated in normal use.
> > + * be ever incorporated in normal use.
> 
> preferably
>     * ever be

I think 'be ever' is correct spelling too, I'll leave this one alone.


> >   * trace_array_printk() can be used, as it will not add noise to the
> >   * top level tracing buffer.
> 
> and at first I skipped over these, but I'll go back and mention them anyway:

Fixed.

-v2 attached - I preemptively added your Reviewed-by as well, if 
that's fine. :-)

Thanks,

	Ingo

=====================>
From: Ingo Molnar <mingo@kernel.org>
Date: Mon, 22 Mar 2021 23:45:46 +0100
Subject: [PATCH] tracing: Fix various typos in comments

Fix ~59 single-word typos in the tracing code comments, and fix
the grammer in a handful of places.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20210322224546.GA1981273@gmail.com
---
 arch/microblaze/include/asm/ftrace.h |  2 +-
 arch/nds32/kernel/ftrace.c           |  2 +-
 arch/powerpc/include/asm/ftrace.h    |  4 ++--
 arch/sh/kernel/ftrace.c              |  2 +-
 arch/sparc/include/asm/ftrace.h      |  2 +-
 fs/tracefs/inode.c                   |  2 +-
 include/linux/ftrace.h               |  4 ++--
 include/linux/trace_events.h         |  2 +-
 include/linux/tracepoint.h           |  2 +-
 include/trace/events/io_uring.h      |  2 +-
 include/trace/events/rcu.h           |  2 +-
 include/trace/events/sched.h         |  2 +-
 include/trace/events/timer.h         |  2 +-
 kernel/trace/bpf_trace.c             |  5 +++--
 kernel/trace/fgraph.c                |  4 ++--
 kernel/trace/ftrace.c                |  8 ++++----
 kernel/trace/ring_buffer.c           |  2 +-
 kernel/trace/synth_event_gen_test.c  |  2 +-
 kernel/trace/trace.c                 | 18 +++++++++---------
 kernel/trace/trace.h                 |  4 ++--
 kernel/trace/trace_event_perf.c      |  2 +-
 kernel/trace/trace_events.c          |  4 ++--
 kernel/trace/trace_events_filter.c   |  4 ++--
 kernel/trace/trace_events_synth.c    |  2 +-
 kernel/trace/trace_functions_graph.c |  2 +-
 kernel/trace/trace_hwlat.c           |  4 ++--
 kernel/trace/trace_kprobe.c          |  2 +-
 kernel/trace/trace_probe.c           |  6 +++---
 kernel/trace/trace_probe.h           |  2 +-
 kernel/trace/trace_probe_tmpl.h      |  2 +-
 kernel/trace/trace_selftest.c        |  4 ++--
 kernel/trace/trace_seq.c             | 12 ++++++------
 32 files changed, 60 insertions(+), 59 deletions(-)

diff --git a/arch/microblaze/include/asm/ftrace.h b/arch/microblaze/include/asm/ftrace.h
index 5db7f4489f05..6a92bed37794 100644
--- a/arch/microblaze/include/asm/ftrace.h
+++ b/arch/microblaze/include/asm/ftrace.h
@@ -13,7 +13,7 @@ extern void ftrace_call_graph(void);
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-/* reloction of mcount call site is the same as the address */
+/* relocation of mcount call site is the same as the address */
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	return addr;
diff --git a/arch/nds32/kernel/ftrace.c b/arch/nds32/kernel/ftrace.c
index 414f8a780cc3..0e23e3a8df6b 100644
--- a/arch/nds32/kernel/ftrace.c
+++ b/arch/nds32/kernel/ftrace.c
@@ -236,7 +236,7 @@ void __naked return_to_handler(void)
 		"bal ftrace_return_to_handler\n\t"
 		"move $lp, $r0               \n\t"
 
-		/* restore state nedded by the ABI  */
+		/* restore state needed by the ABI  */
 		"lmw.bim $r0,[$sp],$r1,#0x0  \n\t");
 }
 
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index bc76970b6ee5..debe8c4f7062 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -12,7 +12,7 @@
 
 #ifdef __ASSEMBLY__
 
-/* Based off of objdump optput from glibc */
+/* Based off of objdump output from glibc */
 
 #define MCOUNT_SAVE_FRAME			\
 	stwu	r1,-48(r1);			\
@@ -52,7 +52,7 @@ extern void _mcount(void);
 
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
-       /* reloction of mcount call site is the same as the address */
+       /* relocation of mcount call site is the same as the address */
        return addr;
 }
 
diff --git a/arch/sh/kernel/ftrace.c b/arch/sh/kernel/ftrace.c
index 0646c5961846..295c43315bbe 100644
--- a/arch/sh/kernel/ftrace.c
+++ b/arch/sh/kernel/ftrace.c
@@ -67,7 +67,7 @@ static unsigned char *ftrace_call_replace(unsigned long ip, unsigned long addr)
  * Modifying code must take extra care. On an SMP machine, if
  * the code being modified is also being executed on another CPU
  * that CPU will have undefined results and possibly take a GPF.
- * We use kstop_machine to stop other CPUS from exectuing code.
+ * We use kstop_machine to stop other CPUS from executing code.
  * But this does not stop NMIs from happening. We still need
  * to protect against that. We separate out the modification of
  * the code to take care of this.
diff --git a/arch/sparc/include/asm/ftrace.h b/arch/sparc/include/asm/ftrace.h
index d3aa1a524431..e284394cb3aa 100644
--- a/arch/sparc/include/asm/ftrace.h
+++ b/arch/sparc/include/asm/ftrace.h
@@ -17,7 +17,7 @@ void _mcount(void);
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-/* reloction of mcount call site is the same as the address */
+/* relocation of mcount call site is the same as the address */
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	return addr;
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 4b83cbded559..1261e8b41edb 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -477,7 +477,7 @@ struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
  *
  * The instances directory is special as it allows for mkdir and rmdir to
  * to be done by userspace. When a mkdir or rmdir is performed, the inode
- * locks are released and the methhods passed in (@mkdir and @rmdir) are
+ * locks are released and the methods passed in (@mkdir and @rmdir) are
  * called without locks and with the name of the directory being created
  * within the instances directory.
  *
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 86e5028bfa20..a69f363b61bf 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -33,7 +33,7 @@
 /*
  * If the arch's mcount caller does not support all of ftrace's
  * features, then it must call an indirect function that
- * does. Or at least does enough to prevent any unwelcomed side effects.
+ * does. Or at least does enough to prevent any unwelcome side effects.
  */
 #if !ARCH_SUPPORTS_FTRACE_OPS
 # define FTRACE_FORCE_LIST_FUNC 1
@@ -389,7 +389,7 @@ DECLARE_PER_CPU(int, disable_stack_tracer);
  */
 static inline void stack_tracer_disable(void)
 {
-	/* Preemption or interupts must be disabled */
+	/* Preemption or interrupts must be disabled */
 	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT))
 		WARN_ON_ONCE(!preempt_count() || !irqs_disabled());
 	this_cpu_inc(disable_stack_tracer);
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 28e7af1406f2..d913afb2a320 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -206,7 +206,7 @@ static inline unsigned int tracing_gen_ctx_dec(void)
 
 	trace_ctx = tracing_gen_ctx();
 	/*
-	 * Subtract one from the preeption counter if preemption is enabled,
+	 * Subtract one from the preemption counter if preemption is enabled,
 	 * see trace_event_buffer_reserve()for details.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPTION))
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 9cfb099da58f..13f65420f188 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -465,7 +465,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  *	*
  *	* The declared 'local variable' is called '__entry'
  *	*
- *	* __field(pid_t, prev_prid) is equivalent to a standard declariton:
+ *	* __field(pid_t, prev_prid) is equivalent to a standard declaration:
  *	*
  *	*	pid_t	prev_pid;
  *	*
diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_uring.h
index 9f0d3b7d56b0..ba78a5602cd1 100644
--- a/include/trace/events/io_uring.h
+++ b/include/trace/events/io_uring.h
@@ -49,7 +49,7 @@ TRACE_EVENT(io_uring_create,
 );
 
 /**
- * io_uring_register - called after a buffer/file/eventfd was succesfully
+ * io_uring_register - called after a buffer/file/eventfd was successfully
  * 					   registered for a ring
  *
  * @ctx:			pointer to a ring context structure
diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 5fc29400e1a2..97177c10bf64 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -48,7 +48,7 @@ TRACE_EVENT(rcu_utilization,
  * RCU flavor, the grace-period number, and a string identifying the
  * grace-period-related event as follows:
  *
- *	"AccReadyCB": CPU acclerates new callbacks to RCU_NEXT_READY_TAIL.
+ *	"AccReadyCB": CPU accelerates new callbacks to RCU_NEXT_READY_TAIL.
  *	"AccWaitCB": CPU accelerates new callbacks to RCU_WAIT_TAIL.
  *	"newreq": Request a new grace period.
  *	"start": Start a grace period.
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index cbe3e152d24c..1eca2305ca42 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -174,7 +174,7 @@ DEFINE_EVENT(sched_wakeup_template, sched_waking,
 	     TP_ARGS(p));
 
 /*
- * Tracepoint called when the task is actually woken; p->state == TASK_RUNNNG.
+ * Tracepoint called when the task is actually woken; p->state == TASK_RUNNING.
  * It is not always called from the waking context.
  */
 DEFINE_EVENT(sched_wakeup_template, sched_wakeup,
diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 19abb6c3eb73..6ad031c71be7 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -119,7 +119,7 @@ TRACE_EVENT(timer_expire_entry,
  * When used in combination with the timer_expire_entry tracepoint we can
  * determine the runtime of the timer callback function.
  *
- * NOTE: Do NOT derefernce timer in TP_fast_assign. The pointer might
+ * NOTE: Do NOT dereference timer in TP_fast_assign. The pointer might
  * be invalid. We solely track the pointer.
  */
 DEFINE_EVENT(timer_class, timer_expire_exit,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b0c45d923f0f..49f7ddb36149 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -658,7 +658,7 @@ BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
 		/* fmt[i] != 0 && fmt[last] == 0, so we can access fmt[i + 1] */
 		i++;
 
-		/* skip optional "[0 +-][num]" width formating field */
+		/* skip optional "[0 +-][num]" width formatting field */
 		while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
 		       fmt[i] == ' ')
 			i++;
@@ -748,7 +748,8 @@ BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
 		fmt_cnt++;
 	}
 
-	/* Maximumly we can have MAX_SEQ_PRINTF_VARARGS parameter, just give
+	/*
+	 * The maximum we can have is MAX_SEQ_PRINTF_VARARGS parameters, so just give
 	 * all of them to seq_printf().
 	 */
 	seq_printf(m, fmt, params[0], params[1], params[2], params[3],
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 29a6ebeebc9e..b8a0d1d564fb 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -42,7 +42,7 @@ bool ftrace_graph_is_dead(void)
 }
 
 /**
- * ftrace_graph_stop - set to permanently disable function graph tracincg
+ * ftrace_graph_stop - set to permanently disable function graph tracing
  *
  * In case of an error int function graph tracing, this is called
  * to try to keep function graph tracing from causing any more harm.
@@ -117,7 +117,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
 	/*
 	 * Skip graph tracing if the return location is served by direct trampoline,
-	 * since call sequence and return addresses is unpredicatable anymore.
+	 * since call sequence and return addresses are unpredictable anyway.
 	 * Ex: BPF trampoline may call original function and may skip frame
 	 * depending on type of BPF programs attached.
 	 */
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4d8e35575549..eb7d677cb466 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1045,7 +1045,7 @@ struct ftrace_ops global_ops = {
 };
 
 /*
- * Used by the stack undwinder to know about dynamic ftrace trampolines.
+ * Used by the stack unwinder to know about dynamic ftrace trampolines.
  */
 struct ftrace_ops *ftrace_ops_trampoline(unsigned long addr)
 {
@@ -3000,7 +3000,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 		 * When the kernel is preemptive, tasks can be preempted
 		 * while on a ftrace trampoline. Just scheduling a task on
 		 * a CPU is not good enough to flush them. Calling
-		 * synchornize_rcu_tasks() will wait for those tasks to
+		 * synchronize_rcu_tasks() will wait for those tasks to
 		 * execute and either schedule voluntarily or enter user space.
 		 */
 		if (IS_ENABLED(CONFIG_PREEMPTION))
@@ -5373,7 +5373,7 @@ EXPORT_SYMBOL_GPL(modify_ftrace_direct);
  * @reset - non zero to reset all filters before applying this filter.
  *
  * Filters denote which functions should be enabled when tracing is enabled
- * If @ip is NULL, it failes to update filter.
+ * If @ip is NULL, it fails to update filter.
  */
 int ftrace_set_filter_ip(struct ftrace_ops *ops, unsigned long ip,
 			 int remove, int reset)
@@ -6325,7 +6325,7 @@ clear_mod_from_hash(struct ftrace_page *pg, struct ftrace_hash *hash)
 	}
 }
 
-/* Clear any records from hashs */
+/* Clear any records from hashes */
 static void clear_mod_from_hashes(struct ftrace_page *pg)
 {
 	struct trace_array *tr;
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 68744c51517e..494c74daa590 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3064,7 +3064,7 @@ rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
  * is called before preempt_count() is updated, since the check will
  * be on the NORMAL bit, the TRANSITION bit will then be set. If an
  * NMI then comes in, it will set the NMI bit, but when the NMI code
- * does the trace_recursive_unlock() it will clear the TRANSTION bit
+ * does the trace_recursive_unlock() it will clear the TRANSITION bit
  * and leave the NMI bit set. But this is fine, because the interrupt
  * code that set the TRANSITION bit will then clear the NMI bit when it
  * calls trace_recursive_unlock(). If another NMI comes in, it will
diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index a4b4bbf8c3bf..0b15e975d2c2 100644
--- a/kernel/trace/synth_event_gen_test.c
+++ b/kernel/trace/synth_event_gen_test.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Test module for in-kernel sythetic event creation and generation.
+ * Test module for in-kernel synthetic event creation and generation.
  *
  * Copyright (C) 2019 Tom Zanussi <zanussi@kernel.org>
  */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index eccb4e1187cc..b7738d21d840 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -514,7 +514,7 @@ void trace_free_pid_list(struct trace_pid_list *pid_list)
  * @filtered_pids: The list of pids to check
  * @search_pid: The PID to find in @filtered_pids
  *
- * Returns true if @search_pid is fonud in @filtered_pids, and false otherwis.
+ * Returns true if @search_pid is found in @filtered_pids, and false otherwise.
  */
 bool
 trace_find_filtered_pid(struct trace_pid_list *filtered_pids, pid_t search_pid)
@@ -545,7 +545,7 @@ trace_ignore_this_task(struct trace_pid_list *filtered_pids,
 		       struct task_struct *task)
 {
 	/*
-	 * If filterd_no_pids is not empty, and the task's pid is listed
+	 * If filtered_no_pids is not empty, and the task's pid is listed
 	 * in filtered_no_pids, then return true.
 	 * Otherwise, if filtered_pids is empty, that means we can
 	 * trace all tasks. If it has content, then only trace pids
@@ -612,7 +612,7 @@ void *trace_pid_next(struct trace_pid_list *pid_list, void *v, loff_t *pos)
 
 	(*pos)++;
 
-	/* pid already is +1 of the actual prevous bit */
+	/* pid already is +1 of the actual previous bit */
 	pid = find_next_bit(pid_list->pids, pid_list->pid_max, pid);
 
 	/* Return pid + 1 to allow zero to be represented */
@@ -834,7 +834,7 @@ DEFINE_MUTEX(trace_types_lock);
  * The content of events may become garbage if we allow other process consumes
  * these events concurrently:
  *   A) the page of the consumed events may become a normal page
- *      (not reader page) in ring buffer, and this page will be rewrited
+ *      (not reader page) in ring buffer, and this page will be rewritten
  *      by events producer.
  *   B) The page of the consumed events may become a page for splice_read,
  *      and this page will be returned to system.
@@ -1520,7 +1520,7 @@ unsigned long nsecs_to_usecs(unsigned long nsecs)
 #undef C
 #define C(a, b) b
 
-/* These must match the bit postions in trace_iterator_flags */
+/* These must match the bit positions in trace_iterator_flags */
 static const char *trace_options[] = {
 	TRACE_FLAGS
 	NULL
@@ -3367,7 +3367,7 @@ int trace_array_vprintk(struct trace_array *tr,
  * buffer (use trace_printk() for that), as writing into the top level
  * buffer should only have events that can be individually disabled.
  * trace_printk() is only used for debugging a kernel, and should not
- * be ever encorporated in normal use.
+ * be ever incorporated in normal use.
  *
  * trace_array_printk() can be used, as it will not add noise to the
  * top level tracing buffer.
@@ -7331,11 +7331,11 @@ static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr)
  * @cmd: The tracing command that caused the error
  * @str: The string to position the caret at within @cmd
  *
- * Finds the position of the first occurence of @str within @cmd.  The
+ * Finds the position of the first occurrence of @str within @cmd.  The
  * return value can be passed to tracing_log_err() for caret placement
  * within @cmd.
  *
- * Returns the index within @cmd of the first occurence of @str or 0
+ * Returns the index within @cmd of the first occurrence of @str or 0
  * if @str was not found.
  */
 unsigned int err_pos(char *cmd, const char *str)
@@ -9118,7 +9118,7 @@ int tracing_init_dentry(void)
 	 * As there may still be users that expect the tracing
 	 * files to exist in debugfs/tracing, we must automount
 	 * the tracefs file system there, so older tools still
-	 * work with the newer kerenl.
+	 * work with the newer kernel.
 	 */
 	tr->dir = debugfs_create_automount("tracing", NULL,
 					   trace_automount, NULL);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a6446c03cfbc..65b47f689442 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1343,7 +1343,7 @@ __event_trigger_test_discard(struct trace_event_file *file,
 
 /**
  * event_trigger_unlock_commit - handle triggers and finish event commit
- * @file: The file pointer assoctiated to the event
+ * @file: The file pointer associated with the event
  * @buffer: The ring buffer that the event is being written to
  * @event: The event meta data in the ring buffer
  * @entry: The event itself
@@ -1370,7 +1370,7 @@ event_trigger_unlock_commit(struct trace_event_file *file,
 
 /**
  * event_trigger_unlock_commit_regs - handle triggers and finish event commit
- * @file: The file pointer assoctiated to the event
+ * @file: The file pointer associated with the event
  * @buffer: The ring buffer that the event is being written to
  * @event: The event meta data in the ring buffer
  * @entry: The event itself
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 288ad2c274fb..03be4435d103 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -16,7 +16,7 @@ static char __percpu *perf_trace_buf[PERF_NR_CONTEXTS];
 
 /*
  * Force it to be aligned to unsigned long to avoid misaligned accesses
- * suprises
+ * surprises
  */
 typedef typeof(unsigned long [PERF_MAX_TRACE_SIZE / sizeof(unsigned long)])
 	perf_trace_t;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a3563afd412d..9f23cc66e1f7 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2436,7 +2436,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 		}
 
 		/*
-		 * Since calls are grouped by systems, the likelyhood that the
+		 * Since calls are grouped by systems, the likelihood that the
 		 * next call in the iteration belongs to the same system as the
 		 * previous call is high. As an optimization, we skip searching
 		 * for a map[] that matches the call's system if the last call
@@ -2496,7 +2496,7 @@ __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
 }
 
 /*
- * Just create a decriptor for early init. A descriptor is required
+ * Just create a descriptor for early init. A descriptor is required
  * for enabling events at boot. We want to enable events before
  * the filesystem is initialized.
  */
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index e91259f6a722..9730acf3c03e 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -296,7 +296,7 @@ enum {
  * and "FALSE" the program entry after that, we are now done with the first
  * pass.
  *
- * Making the above "a || b && c" have a progam of:
+ * Making the above "a || b && c" have a program of:
  *  prog[0] = { "a", 1, 2 }
  *  prog[1] = { "b", 0, 2 }
  *  prog[2] = { "c", 0, 3 }
@@ -390,7 +390,7 @@ enum {
  * F: return FALSE
  *
  * As "r = a; if (!r) goto n5;" is obviously the same as
- * "if (!a) goto n5;" without doing anything we can interperate the
+ * "if (!a) goto n5;" without doing anything we can interpret the
  * program as:
  * n1: if (!a) goto n5;
  * n2: if (!b) goto n5;
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 8d71e6c83f10..2ac75eb6aa86 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1385,7 +1385,7 @@ static int destroy_synth_event(struct synth_event *se)
 
 /**
  * synth_event_delete - Delete a synthetic event
- * @event_name: The name of the new sythetic event
+ * @event_name: The name of the new synthetic event
  *
  * Delete a synthetic event that was created with synth_event_create().
  *
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 0aa6e6faa943..0de6837722da 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -764,7 +764,7 @@ print_graph_prologue(struct trace_iterator *iter, struct trace_seq *s,
  *  - we are inside irq code
  *  - we just entered irq code
  *
- * retunns 0 if
+ * returns 0 if
  *  - funcgraph-interrupts option is set
  *  - we are not inside irq code
  */
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 34dc1a712dcb..632ef88131a9 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -83,7 +83,7 @@ struct hwlat_sample {
 	u64			nmi_total_ts;	/* Total time spent in NMIs */
 	struct timespec64	timestamp;	/* wall time */
 	int			nmi_count;	/* # NMIs during this sample */
-	int			count;		/* # of iteratons over threash */
+	int			count;		/* # of iterations over thresh */
 };
 
 /* keep the global state somewhere. */
@@ -389,7 +389,7 @@ static int start_kthread(struct trace_array *tr)
 }
 
 /**
- * stop_kthread - Inform the hardware latency samping/detector kthread to stop
+ * stop_kthread - Inform the hardware latency sampling/detector kthread to stop
  *
  * This kicks the running hardware latency sampling/detector kernel thread and
  * tells it to stop sampling now. Use this on unload and at system shutdown.
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 6fe770d86dc3..ea6178cb5e33 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1748,7 +1748,7 @@ kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
 	if (trace_probe_test_flag(&tk->tp, TP_FLAG_PROFILE))
 		kretprobe_perf_func(tk, ri, regs);
 #endif
-	return 0;	/* We don't tweek kernel, so just return 0 */
+	return 0;	/* We don't tweak kernel, so just return 0 */
 }
 NOKPROBE_SYMBOL(kretprobe_dispatcher);
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index ec589a4612df..15413ad7cef2 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -168,7 +168,7 @@ void __trace_probe_log_err(int offset, int err_type)
 	if (!trace_probe_log.argv)
 		return;
 
-	/* Recalcurate the length and allocate buffer */
+	/* Recalculate the length and allocate buffer */
 	for (i = 0; i < trace_probe_log.argc; i++) {
 		if (i == trace_probe_log.index)
 			pos = len;
@@ -182,7 +182,7 @@ void __trace_probe_log_err(int offset, int err_type)
 		/**
 		 * Set the error position is next to the last arg + space.
 		 * Note that len includes the terminal null and the cursor
-		 * appaers at pos + 1.
+		 * appears at pos + 1.
 		 */
 		pos = len;
 		offset = 0;
@@ -592,7 +592,7 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	}
 
 	/*
-	 * Since $comm and immediate string can not be dereferred,
+	 * Since $comm and immediate string can not be dereferenced,
 	 * we can find those by strcmp.
 	 */
 	if (strcmp(arg, "$comm") == 0 || strncmp(arg, "\\\"", 2) == 0) {
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 7ce4027089ee..227d518e5ba5 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -134,7 +134,7 @@ struct fetch_type {
 	size_t			size;		/* Byte size of type */
 	int			is_signed;	/* Signed flag */
 	print_type_func_t	print;		/* Print functions */
-	const char		*fmt;		/* Fromat string */
+	const char		*fmt;		/* Format string */
 	const char		*fmttype;	/* Name in format file */
 };
 
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index e5282828f4a6..f003c5d02a3a 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -167,7 +167,7 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 	return code->op == FETCH_OP_END ? ret : -EILSEQ;
 }
 
-/* Sum up total data length for dynamic arraies (strings) */
+/* Sum up total data length for dynamic arrays (strings) */
 static nokprobe_inline int
 __get_data_size(struct trace_probe *tp, struct pt_regs *regs)
 {
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 73ef12092250..adf7ef194005 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -878,7 +878,7 @@ trace_selftest_startup_preemptoff(struct tracer *trace, struct trace_array *tr)
 	int ret;
 
 	/*
-	 * Now that the big kernel lock is no longer preemptable,
+	 * Now that the big kernel lock is no longer preemptible,
 	 * and this is called with the BKL held, it will always
 	 * fail. If preemption is already disabled, simply
 	 * pass the test. When the BKL is removed, or becomes
@@ -940,7 +940,7 @@ trace_selftest_startup_preemptirqsoff(struct tracer *trace, struct trace_array *
 	int ret;
 
 	/*
-	 * Now that the big kernel lock is no longer preemptable,
+	 * Now that the big kernel lock is no longer preemptible,
 	 * and this is called with the BKL held, it will always
 	 * fail. If preemption is already disabled, simply
 	 * pass the test. When the BKL is removed, or becomes
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index 1d84fcc78e3e..9c90b3a7dce2 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -16,7 +16,7 @@
  * The buffer size is currently PAGE_SIZE, although it may become dynamic
  * in the future.
  *
- * A write to the buffer will either succed or fail. That is, unlike
+ * A write to the buffer will either succeed or fail. That is, unlike
  * sprintf() there will not be a partial write (well it may write into
  * the buffer but it wont update the pointers). This allows users to
  * try to write something into the trace_seq buffer and if it fails
@@ -73,7 +73,7 @@ int trace_print_seq(struct seq_file *m, struct trace_seq *s)
  * @fmt: printf format string
  *
  * The tracer may use either sequence operations or its own
- * copy to user routines. To simplify formating of a trace
+ * copy to user routines. To simplify formatting of a trace
  * trace_seq_printf() is used to store strings into a special
  * buffer (@s). Then the output may be either used by
  * the sequencer or pulled into another buffer.
@@ -133,7 +133,7 @@ EXPORT_SYMBOL_GPL(trace_seq_bitmask);
  * @fmt: printf format string
  *
  * The tracer may use either sequence operations or its own
- * copy to user routines. To simplify formating of a trace
+ * copy to user routines. To simplify formatting of a trace
  * trace_seq_printf is used to store strings into a special
  * buffer (@s). Then the output may be either used by
  * the sequencer or pulled into another buffer.
@@ -226,7 +226,7 @@ EXPORT_SYMBOL_GPL(trace_seq_puts);
  * @c: simple character to record
  *
  * The tracer may use either the sequence operations or its own
- * copy to user routines. This function records a simple charater
+ * copy to user routines. This function records a simple character
  * into a special buffer (@s) for later retrieval by a sequencer
  * or other mechanism.
  */
@@ -348,7 +348,7 @@ int trace_seq_path(struct trace_seq *s, const struct path *path)
 EXPORT_SYMBOL_GPL(trace_seq_path);
 
 /**
- * trace_seq_to_user - copy the squence buffer to user space
+ * trace_seq_to_user - copy the sequence buffer to user space
  * @s: trace sequence descriptor
  * @ubuf: The userspace memory location to copy to
  * @cnt: The amount to copy
@@ -363,7 +363,7 @@ EXPORT_SYMBOL_GPL(trace_seq_path);
  *
  * On failure it returns -EBUSY if all of the content in the
  * sequence has been already read, which includes nothing in the
- * sequenc (@s->len == @s->readpos).
+ * sequence (@s->len == @s->readpos).
  *
  * Returns -EFAULT if the copy to userspace fails.
  */
