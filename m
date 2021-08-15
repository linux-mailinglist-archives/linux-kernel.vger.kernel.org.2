Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4973ECB1D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhHOV23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:28:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47738 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhHOV2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:28:11 -0400
Message-ID: <20210815211302.088945085@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=q3uXNGa1+gGA4rMhiSsZsQbWYW3cnQwm2UD5Io6f0II=;
        b=rIarkDDs6cmIBj7NwY7kus6CR3pyG4TsxbzbuyjoOAQZL94D0BIViHrcVJqRXqeiJkLluj
        E+kR9zlqwy7cqXKTmGZC4Xju7ZGi83fZLSv5ezJLBk3IcZGiKfCXR78q4B3vvcM5FOAtA5
        dXbbzBEYO+rP6U0Z1SFayD/Z4sPlxd9/D4wSu6DHoYTIXwkTwAlGaAxDSWY6RblJvz0GQa
        QJ+m1qFuJ+ABLC1zoT5kx6kXojI8U5ybg2iBiQMiFTAdJLR5xhLrK7Xx8FRBstUTKGtGbV
        DaCJI94SRfkV605dnkAVtWYQTKs3wMmHs1gN0ukJKOBf2yVDLz2YnTUbiVZhDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=q3uXNGa1+gGA4rMhiSsZsQbWYW3cnQwm2UD5Io6f0II=;
        b=ygq/5zqTW4cdFO1xZ3haCi11wG24TRugvouozsEymC1mhSoHkFeGp4vc0dsz0SEKFiRjgu
        FoWkD+6j8rDiQ+BA==
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
Subject: [patch V5 03/72] sched: Split out the wakeup state check
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:27:40 +0200 (CEST)
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
@@ -3577,6 +3577,22 @@ static void ttwu_queue(struct task_struc
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
@@ -3715,10 +3731,9 @@ try_to_wake_up(struct task_struct *p, un
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
@@ -3733,14 +3748,11 @@ try_to_wake_up(struct task_struct *p, un
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

