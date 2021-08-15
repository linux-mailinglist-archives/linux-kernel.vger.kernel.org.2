Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC6B3ECB22
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhHOV3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhHOV2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:28:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519FFC061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:27:48 -0700 (PDT)
Message-ID: <20210815211302.315473019@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5dwcdaKLl0A27YFMGPABxh5fxtEFEBZTXW/B6G9PPd0=;
        b=Vuk6PvswcEi1OXETiO0ZzZ+1KWqLEnJn0evIqspZkWzl/B4rHYYgbmVGKSwne9kFqfeL1F
        fBGZqwp4l6hJtde7scgalUH/sGNRRlpLHWery2t27M3LOjViEkOgyZrJHvT7JsMRixNHX4
        YRFF3MU369tcb+Xd+8ydCz8OfeJ8aSDm2dCf8RXXcsemHuYrXb03lu2AX91n+P79oCg1Td
        iT3xYCq8rXdu85PLEtBszKMy2KqA3aQ8MajzodO3/QVr2vYmLIIyzLTZedps/F9MJvg3Ld
        W/7d8WkQmko9JjWqt7pJtESl+x6bZo0wXfrKSvQ90IYVTS5CYZXv24QXS2adAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5dwcdaKLl0A27YFMGPABxh5fxtEFEBZTXW/B6G9PPd0=;
        b=L+BK8nKgRrocI13n3gE/qbsDDVWNqcx2w9CRUqnJphXDj0+L+oo/IwnnE34uAwG4LpA3eS
        NrQnBZBH0/3402DA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: [patch V5 07/72] sched: Rework the __schedule() preempt argument
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:27:46 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

PREEMPT_RT needs to hand a special state into __schedule() when a task
blocks on a 'sleeping' spin/rwlock. This is required to handle
rcu_note_context_switch() correctly without having special casing in the
RCU code. From an RCU point of view the blocking on the sleeping spinlock
is equivalent to preemption because the task might be in a read side
critical section.

schedule_debug() also has a check which would trigger with the !preempt
case, but that could be handled differently.

To avoid adding another argument and extra checks which cannot be optimized
out by the compiler the following solution has been chosen:

 - Replace the boolean 'preempt' argument with an unsigned integer
   'sched_mode' argument and define constants to hand in:
   (0 == No preemption, 1 = preemption).

 - Add two masks to apply on that mode one for the debug/rcu invocations
   and one for the actual scheduling decision.

   For a non RT kernel these masks are UINT_MAX, i.e. all bits are set
   which allows the compiler to optimize the AND operation out because it is
   not masking out anything. IOW, it's not different from the boolean.

   RT enabled kernels will define these masks separately.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Simplify the masking logic
---
 kernel/sched/core.c |   34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)
---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5820,6 +5820,18 @@ pick_next_task(struct rq *rq, struct tas
 #endif /* CONFIG_SCHED_CORE */
 
 /*
+ * Constants for the sched_mode argument of __schedule().
+ *
+ * The mode argument allows RT enabled kernels to differentiate a
+ * preemption from blocking on an 'sleeping' spin/rwlock. Note, that
+ * SM_MASK_PREEMPT for !RT has all bits set which allows the compiler to
+ * optimize the AND operation out and just check for zero.
+ */
+#define SM_NONE			0x0
+#define SM_PREEMPT		0x1
+#define SM_MASK_PREEMPT		(~0U)
+
+/*
  * __schedule() is the main scheduler function.
  *
  * The main means of driving the scheduler and thus entering this function are:
@@ -5858,7 +5870,7 @@ pick_next_task(struct rq *rq, struct tas
  *
  * WARNING: must be called with preemption disabled!
  */
-static void __sched notrace __schedule(bool preempt)
+static void __sched notrace __schedule(unsigned int sched_mode)
 {
 	struct task_struct *prev, *next;
 	unsigned long *switch_count;
@@ -5871,13 +5883,13 @@ static void __sched notrace __schedule(b
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
@@ -5911,7 +5923,7 @@ static void __sched notrace __schedule(b
 	 *  - ptrace_{,un}freeze_traced() can change ->state underneath us.
 	 */
 	prev_state = READ_ONCE(prev->__state);
-	if (!preempt && prev_state) {
+	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
 			WRITE_ONCE(prev->__state, TASK_RUNNING);
 		} else {
@@ -5977,7 +5989,7 @@ static void __sched notrace __schedule(b
 		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
-		trace_sched_switch(preempt, prev, next);
+		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next);
 
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
@@ -5998,7 +6010,7 @@ void __noreturn do_task_dead(void)
 	/* Tell freezer to ignore us: */
 	current->flags |= PF_NOFREEZE;
 
-	__schedule(false);
+	__schedule(SM_NONE);
 	BUG();
 
 	/* Avoid "noreturn function does return" - but don't continue if BUG() is a NOP: */
@@ -6059,7 +6071,7 @@ asmlinkage __visible void __sched schedu
 	sched_submit_work(tsk);
 	do {
 		preempt_disable();
-		__schedule(false);
+		__schedule(SM_NONE);
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
 	sched_update_worker(tsk);
@@ -6087,7 +6099,7 @@ void __sched schedule_idle(void)
 	 */
 	WARN_ON_ONCE(current->__state);
 	do {
-		__schedule(false);
+		__schedule(SM_NONE);
 	} while (need_resched());
 }
 
@@ -6140,7 +6152,7 @@ static void __sched notrace preempt_sche
 		 */
 		preempt_disable_notrace();
 		preempt_latency_start(1);
-		__schedule(true);
+		__schedule(SM_PREEMPT);
 		preempt_latency_stop(1);
 		preempt_enable_no_resched_notrace();
 
@@ -6219,7 +6231,7 @@ asmlinkage __visible void __sched notrac
 		 * an infinite recursion.
 		 */
 		prev_ctx = exception_enter();
-		__schedule(true);
+		__schedule(SM_PREEMPT);
 		exception_exit(prev_ctx);
 
 		preempt_latency_stop(1);
@@ -6368,7 +6380,7 @@ asmlinkage __visible void __sched preemp
 	do {
 		preempt_disable();
 		local_irq_enable();
-		__schedule(true);
+		__schedule(SM_PREEMPT);
 		local_irq_disable();
 		sched_preempt_enable_no_resched();
 	} while (need_resched());

