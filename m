Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4B43E184D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242316AbhHEPlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:41:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43588 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242138AbhHEPl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:41:27 -0400
Message-ID: <20210805153953.093160369@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ifG7s6M0a4Y24T4/SUAo1GqROF7xJ6CZr+/az8A6e2w=;
        b=EJhvH/d+nOMa3ZgUso5S2ZCUtR69nhZFWD9sWhh07E0O1bOjungmVErUFWQm82QcRgWPqn
        d2PzWWeL0ubExlreBtMgUYmBmHXXgb6O3iD4mqXemsF39XiQGubl6N4UIoAMnJqHZe8l2Y
        Ay6/4CCw5aOjzX5Aq0A6e5n1RtntzsSVQ1687SBz6b6DZdZlP3uSaP2Rd/JcAYPDK42M+T
        JeE6zjo6DJgiAedS6EPMUKEPb6LkkH5XWmEKo/a9dLEMhx9hLPHxxW2B/99FiBJVtiee5h
        yVllfXzvR8G4+uP3xUiKcKvVS4/bi5QL7MTPs27SD2Pfo/bX9qeE7u00kybqxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ifG7s6M0a4Y24T4/SUAo1GqROF7xJ6CZr+/az8A6e2w=;
        b=RauMeUKbY2V/qTlIcIeM9nr1qrwGCQue9NVcGAQjTVi/kQhzpqK3IxNk+G1gYDYGkyoEQy
        +P2ImgE1Rgl3KwCg==
Date:   Thu, 05 Aug 2021 17:13:05 +0200
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
Subject: [patch V3 05/64] sched: Rework the __schedule() preempt argument
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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
@@ -5822,6 +5822,18 @@ pick_next_task(struct rq *rq, struct tas
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
@@ -5860,7 +5872,7 @@ pick_next_task(struct rq *rq, struct tas
  *
  * WARNING: must be called with preemption disabled!
  */
-static void __sched notrace __schedule(bool preempt)
+static void __sched notrace __schedule(unsigned int sched_mode)
 {
 	struct task_struct *prev, *next;
 	unsigned long *switch_count;
@@ -5873,13 +5885,13 @@ static void __sched notrace __schedule(b
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
@@ -5913,7 +5925,7 @@ static void __sched notrace __schedule(b
 	 *  - ptrace_{,un}freeze_traced() can change ->state underneath us.
 	 */
 	prev_state = READ_ONCE(prev->__state);
-	if (!preempt && prev_state) {
+	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
 			WRITE_ONCE(prev->__state, TASK_RUNNING);
 		} else {
@@ -5979,7 +5991,7 @@ static void __sched notrace __schedule(b
 		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
-		trace_sched_switch(preempt, prev, next);
+		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next);
 
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
@@ -6000,7 +6012,7 @@ void __noreturn do_task_dead(void)
 	/* Tell freezer to ignore us: */
 	current->flags |= PF_NOFREEZE;
 
-	__schedule(false);
+	__schedule(SM_NONE);
 	BUG();
 
 	/* Avoid "noreturn function does return" - but don't continue if BUG() is a NOP: */
@@ -6061,7 +6073,7 @@ asmlinkage __visible void __sched schedu
 	sched_submit_work(tsk);
 	do {
 		preempt_disable();
-		__schedule(false);
+		__schedule(SM_NONE);
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
 	sched_update_worker(tsk);
@@ -6089,7 +6101,7 @@ void __sched schedule_idle(void)
 	 */
 	WARN_ON_ONCE(current->__state);
 	do {
-		__schedule(false);
+		__schedule(SM_NONE);
 	} while (need_resched());
 }
 
@@ -6142,7 +6154,7 @@ static void __sched notrace preempt_sche
 		 */
 		preempt_disable_notrace();
 		preempt_latency_start(1);
-		__schedule(true);
+		__schedule(SM_PREEMPT);
 		preempt_latency_stop(1);
 		preempt_enable_no_resched_notrace();
 
@@ -6221,7 +6233,7 @@ asmlinkage __visible void __sched notrac
 		 * an infinite recursion.
 		 */
 		prev_ctx = exception_enter();
-		__schedule(true);
+		__schedule(SM_PREEMPT);
 		exception_exit(prev_ctx);
 
 		preempt_latency_stop(1);
@@ -6370,7 +6382,7 @@ asmlinkage __visible void __sched preemp
 	do {
 		preempt_disable();
 		local_irq_enable();
-		__schedule(true);
+		__schedule(SM_PREEMPT);
 		local_irq_disable();
 		sched_preempt_enable_no_resched();
 	} while (need_resched());

