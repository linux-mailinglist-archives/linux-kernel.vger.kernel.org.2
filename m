Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2223E909A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbhHKMX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbhHKMW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:22:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C5BC06179C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:22:34 -0700 (PDT)
Message-ID: <20210811121414.179583019@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Ddzbu9shj00bPE22RZT2bhOuL8oRLRncH8m4i2+p1ZA=;
        b=LqfJnmxQHcOozPS2v8Wz/QawhwG1TSKWrsAYCWu832dzYLZap0vmirVRooZCzX2mCeq+BY
        dmbg5EC4ZE92/AQ0HfuTK+tvrpAItqT/X4g4TpnnGHtJ2e/Qxmnj1+VsE+WrNPkT1MaTy4
        Ta+ta9S8eC/6KkveG5Qv31KD/koh610QLkYYbuM5HAJfJDN8ePuzRO0ITJU2cPH8DfwmM7
        CrZzxaDEfshlyVHNt3SEOJQMOZTX6OT+gLBHGGHyUdLSqXnZw5S+seLqGHa+GyrP/oL/Nz
        S1EnLSWQlYq8a0FgHLEsUuL82Ux2bjjxwQwkqmll7FGjexsy8vJ8sDWuKLMT+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Ddzbu9shj00bPE22RZT2bhOuL8oRLRncH8m4i2+p1ZA=;
        b=1UdAGp4vivarCwm/Rg9ouJqN8KWr/DtMG9cmyfAfYvcaDDxNO9fd15azdc0CpK19VBG3Uo
        M4uNzhacMWUcuaCQ==
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
Subject: [patch V4 01/68] sched: Split out the wakeup state check
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:22:31 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

RT kernels have a slightly more complicated handling of wakeups due to
'sleeping' spin/rwlocks. If a task is blocked on such a lock then the
original state of the task is preserved over the blocking and any regular
(non lock related) wakeup has to be targeted at the saved state to ensure
that these wakeups are not lost. Once the task acquired the lock it
restores the task state from the saved state.

To avoid cluttering try_to_wake_up() with that logic, split the wake up
state check out into an inline helper and use it at both places where
task::state is checked against the state argument of try_to_wake_up().

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)
---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3562,6 +3562,22 @@ static void ttwu_queue(struct task_struc
 }
 
 /*
+ * Invoked from try_to_wake_up() to check whether the task can be woken up.
+ *
+ * The caller holds p::pi_lock if p != current or has preemption
+ * disabled when p == current.
+ */
+static __always_inline
+bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
+{
+	if (READ_ONCE(p->__state) & state) {
+		*success = 1;
+		return true;
+	}
+	return false;
+}
+
+/*
  * Notes on Program-Order guarantees on SMP systems.
  *
  *  MIGRATION
@@ -3700,10 +3716,9 @@ try_to_wake_up(struct task_struct *p, un
 		 *  - we're serialized against set_special_state() by virtue of
 		 *    it disabling IRQs (this allows not taking ->pi_lock).
 		 */
-		if (!(READ_ONCE(p->__state) & state))
+		if (!ttwu_state_match(p, state, &success))
 			goto out;
 
-		success = 1;
 		trace_sched_waking(p);
 		WRITE_ONCE(p->__state, TASK_RUNNING);
 		trace_sched_wakeup(p);
@@ -3718,14 +3733,11 @@ try_to_wake_up(struct task_struct *p, un
 	 */
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 	smp_mb__after_spinlock();
-	if (!(READ_ONCE(p->__state) & state))
+	if (!ttwu_state_match(p, state, &success))
 		goto unlock;
 
 	trace_sched_waking(p);
 
-	/* We're going to change ->state: */
-	success = 1;
-
 	/*
 	 * Ensure we load p->on_rq _after_ p->state, otherwise it would
 	 * be possible to, falsely, observe p->on_rq == 0 and get stuck

