Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63B53C820B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbhGNJwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:52:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60044 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbhGNJwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:52:40 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626256188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iFylwh+okNWxznog4U8C1a5YWUPU+IHchq160zUcO9g=;
        b=HeKF7JcCbasrUgqrNlngGN5B9bpvg/ywnHvv2SZafX7syFiF6+4VxMOpjoOkt9I4jrpCy5
        yQk4a4630bhrL/ktNIqQEMHjqP0Eh3R0qBUJAQ6KaPKenyMbTdH0G0oqrCVxE1GoFMiKpc
        54d1SXjpnOR5lFoVc9A0/ff8HOJi/eKRMJmfbrJhMtj5GXL2gXl8wKsQ7s9NmmN740tSh9
        Ncs943f1P11FkPVQzarC0uzdc0/4Z7h5q4rA1HTkDAWjrx7k8rqmdE+NG9xmjQmFA1UMNo
        n3DVl06gZL8rdK/GeCvwl3JS2pqUelE/bkYvTDUDrL8B4oX+QPbgIpSa3/jtqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626256188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iFylwh+okNWxznog4U8C1a5YWUPU+IHchq160zUcO9g=;
        b=HB5Wa+GCM1OFgK89fzvkjQeKYF3jssccfW0Sfltv2oJPlP9ma0CrohxWbbRdV+tqlESCBf
        tHOpBDH6xKcnaDBQ==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 05/50] sched: Provide schedule point for RT locks
In-Reply-To: <20210714082820.GB2725@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de> <20210713160746.410991567@linutronix.de> <20210714082820.GB2725@worktop.programming.kicks-ass.net>
Date:   Wed, 14 Jul 2021 11:49:47 +0200
Message-ID: <87y2a9b4xw.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14 2021 at 10:28, Peter Zijlstra wrote:
> On Tue, Jul 13, 2021 at 05:10:59PM +0200, Thomas Gleixner wrote:
>
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -5832,8 +5832,14 @@ pick_next_task(struct rq *rq, struct tas
>>   */
>>  #define	SM_NONE			0x0
>>  #define	SM_PREEMPT		0x1
>> -#define SM_MASK_PREEMPT		UINT_MAX
>> -#define SM_MASK_STATE		SM_MASK_PREEMPT
>> +#ifndef CONFIG_PREEMPT_RT
>> +# define SM_MASK_PREEMPT	UINT_MAX
>> +# define SM_MASK_STATE		SM_MASK_PREEMPT
>> +#else
>> +# define SM_RTLOCK_WAIT		0x2
>> +# define SM_MASK_PREEMPT	SM_PREEMPT
>> +# define SM_MASK_STATE		(SM_PREEMPT | SM_RTLOCK_WAIT)
>> +#endif
>
> Wouldn't something like this:
>
>
> #ifndef CONFIG_PREEMPT_RT
> # define SM_MASK_PREEMPT        (~0U)
> #else
> # define SM_RTLOCK_WAIT         0x2
> # define SM_MASK_PREEMPT        SM_PREEMPT
> #endif
>
> #define SM_MASK_STATE          (~0U)
>
> Be even better?

SM_MASK_STATE is overengineered. See combo patch 4+5 below

Thanks,

        tglx
---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5822,6 +5822,24 @@ pick_next_task(struct rq *rq, struct tas
 #endif /* CONFIG_SCHED_CORE */
 
 /*
+ * Constants for the sched_mode argument of __schedule().
+ *
+ * The mode argument allows RT enabled kernels to differentiate a
+ * preemption from blocking on an 'sleeping' spin/rwlock. Note, that
+ * SM_MASK_PREEMPT for !RT is UINT_MAX which allows the compiler to
+ * optimize the AND operation out and just check for zero.
+ */
+#define SM_NONE			0x0
+#define SM_PREEMPT		0x1
+
+#ifndef CONFIG_PREEMPT_RT
+# define SM_MASK_PREEMPT	UINT_MAX
+#else
+# define SM_RTLOCK_WAIT		0x2
+# define SM_MASK_PREEMPT	SM_PREEMPT
+#endif
+
+/*
  * __schedule() is the main scheduler function.
  *
  * The main means of driving the scheduler and thus entering this function are:
@@ -5860,7 +5878,7 @@ pick_next_task(struct rq *rq, struct tas
  *
  * WARNING: must be called with preemption disabled!
  */
-static void __sched notrace __schedule(bool preempt)
+static void __sched notrace __schedule(unsigned int sched_mode)
 {
 	struct task_struct *prev, *next;
 	unsigned long *switch_count;
@@ -5873,13 +5891,13 @@ static void __sched notrace __schedule(b
 	rq = cpu_rq(cpu);
 	prev = rq->curr;
 
-	schedule_debug(prev, preempt);
+	schedule_debug(prev, !!sched_mode);
 
 	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
 		hrtick_clear(rq);
 
 	local_irq_disable();
-	rcu_note_context_switch(preempt);
+	rcu_note_context_switch(!!sched_mode);
 
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
@@ -5913,7 +5931,7 @@ static void __sched notrace __schedule(b
 	 *  - ptrace_{,un}freeze_traced() can change ->state underneath us.
 	 */
 	prev_state = READ_ONCE(prev->__state);
-	if (!preempt && prev_state) {
+	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
 			WRITE_ONCE(prev->__state, TASK_RUNNING);
 		} else {
@@ -5979,7 +5997,7 @@ static void __sched notrace __schedule(b
 		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
-		trace_sched_switch(preempt, prev, next);
+		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next);
 
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
@@ -6000,7 +6018,7 @@ void __noreturn do_task_dead(void)
 	/* Tell freezer to ignore us: */
 	current->flags |= PF_NOFREEZE;
 
-	__schedule(false);
+	__schedule(SM_NONE);
 	BUG();
 
 	/* Avoid "noreturn function does return" - but don't continue if BUG() is a NOP: */
@@ -6061,7 +6079,7 @@ asmlinkage __visible void __sched schedu
 	sched_submit_work(tsk);
 	do {
 		preempt_disable();
-		__schedule(false);
+		__schedule(SM_NONE);
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
 	sched_update_worker(tsk);
@@ -6089,7 +6107,7 @@ void __sched schedule_idle(void)
 	 */
 	WARN_ON_ONCE(current->__state);
 	do {
-		__schedule(false);
+		__schedule(SM_NONE);
 	} while (need_resched());
 }
 
@@ -6124,6 +6142,18 @@ void __sched schedule_preempt_disabled(v
 	preempt_disable();
 }
 
+#ifdef CONFIG_PREEMPT_RT
+void __sched notrace schedule_rtlock(void)
+{
+	do {
+		preempt_disable();
+		__schedule(SM_RTLOCK_WAIT);
+		sched_preempt_enable_no_resched();
+	} while (need_resched());
+}
+NOKPROBE_SYMBOL(schedule_rtlock);
+#endif
+
 static void __sched notrace preempt_schedule_common(void)
 {
 	do {
@@ -6142,7 +6172,7 @@ static void __sched notrace preempt_sche
 		 */
 		preempt_disable_notrace();
 		preempt_latency_start(1);
-		__schedule(true);
+		__schedule(SM_PREEMPT);
 		preempt_latency_stop(1);
 		preempt_enable_no_resched_notrace();
 
@@ -6221,7 +6251,7 @@ asmlinkage __visible void __sched notrac
 		 * an infinite recursion.
 		 */
 		prev_ctx = exception_enter();
-		__schedule(true);
+		__schedule(SM_PREEMPT);
 		exception_exit(prev_ctx);
 
 		preempt_latency_stop(1);
@@ -6370,7 +6400,7 @@ asmlinkage __visible void __sched preemp
 	do {
 		preempt_disable();
 		local_irq_enable();
-		__schedule(true);
+		__schedule(SM_PREEMPT);
 		local_irq_disable();
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -294,6 +294,9 @@ extern long schedule_timeout_idle(long t
 asmlinkage void schedule(void);
 extern void schedule_preempt_disabled(void);
 asmlinkage void preempt_schedule_irq(void);
+#ifdef CONFIG_PREEMPT_RT
+ extern void schedule_rtlock(void);
+#endif
 
 extern int __must_check io_schedule_prepare(void);
 extern void io_schedule_finish(int token);
