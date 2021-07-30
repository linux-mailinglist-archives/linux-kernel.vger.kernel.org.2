Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B263DBA74
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239345AbhG3OXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:23:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56208 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239267AbhG3OSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:18:23 -0400
Message-ID: <20210730135208.637100512@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=URiW1DpWQn2DQGU5xY05q85pYyCqEZVgNpP6syhj+00=;
        b=4I1x3Q/SzKukFiEZnmQLRSXPDNvEIjxGzvDkN0q67JpCJm1IcPC0A0BtHKoXF3ibJ4TslA
        MkJSZPeq+tu62Jxl1khM/17Ou+q4rCAfqygq6BOVMHoQFmJp3SGoag0Vgbt0/RFEiffG+t
        eXVAEoaiqeT6mf3mD6GREuJGMxFC7M28ckbEoB3mFUNcdAf8Ci783siSGx5Zwd+dM8Yjzq
        WlGh9JJuYvXNXuiqIdypauuHkqJURq1gGG3oSoFQtyRIyNdvuN+N72YUP+CsVJroBYBn8H
        jdr0lCsN75Dr8OIfEYKYLDz0FbbShTy1IKGlXfNCeuomPHM6P9hMH9Qj4xawfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=URiW1DpWQn2DQGU5xY05q85pYyCqEZVgNpP6syhj+00=;
        b=ytSQEh/JB+QJ0A/0XFx5dzgzk8k46WDeybM1rSqn7/YbY12z0m00m5SHEfKBymjVQfhBrO
        Kem8VmvFlUX26UCQ==
Date:   Fri, 30 Jul 2021 15:51:09 +0200
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
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [patch 62/63] locking/rtmutex: Add adaptive spinwait mechanism
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

Going to sleep when a spinlock or rwlock is contended can be quite
inefficient when the contention time is short and the lock owner is running
on a different CPU. The MCS mechanism is not applicable to rtmutex based
locks, so provide a simple adaptive spinwait mechanism for the RT specific
spin/rwlock implementations.

[ tglx: Provide a contemporary changelog ]

Originally-by: Gregory Haskins <ghaskins@novell.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)
---
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -8,6 +8,11 @@
  *  Copyright (C) 2005-2006 Timesys Corp., Thomas Gleixner <tglx@timesys.com>
  *  Copyright (C) 2005 Kihon Technologies Inc., Steven Rostedt
  *  Copyright (C) 2006 Esben Nielsen
+ * Adaptive Spinlocks:
+ *  Copyright (C) 2008 Novell, Inc., Gregory Haskins, Sven Dietrich,
+ *				     and Peter Morreale,
+ * Adaptive Spinlocks simplification:
+ *  Copyright (C) 2008 Red Hat, Inc., Steven Rostedt <srostedt@redhat.com>
  *
  *  See Documentation/locking/rt-mutex-design.rst for details.
  */
@@ -1529,6 +1534,43 @@ static __always_inline int __rt_mutex_lo
  * Functions required for spin/rw_lock substitution on RT kernels
  */
 
+#ifdef CONFIG_SMP
+/*
+ * Note that owner is a speculative pointer and dereferencing relies
+ * on rcu_read_lock() and the check against the lock owner.
+ */
+static bool rtlock_adaptive_spinwait(struct rt_mutex_base *lock,
+				     struct task_struct *owner)
+{
+	bool res = true;
+
+	rcu_read_lock();
+	for (;;) {
+		/* Owner changed. Trylock again */
+		if (owner != rt_mutex_owner(lock))
+			break;
+		/*
+		 * Ensure that owner->on_cpu is dereferenced _after_
+		 * checking the above to be valid.
+		 */
+		barrier();
+		if (!owner->on_cpu) {
+			res = false;
+			break;
+		}
+		cpu_relax();
+	}
+	rcu_read_unlock();
+	return res;
+}
+#else
+static bool rtlock_adaptive_spinwait(struct rt_mutex_base *lock,
+				     struct task_struct *owner)
+{
+	return false;
+}
+#endif
+
 /**
  * rtlock_slowlock_locked - Slow path lock acquisition for RT locks
  * @lock:	The underlying rt mutex
@@ -1536,6 +1578,7 @@ static __always_inline int __rt_mutex_lo
 static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 {
 	struct rt_mutex_waiter waiter;
+	struct task_struct *owner;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -1554,9 +1597,14 @@ static void __sched rtlock_slowlock_lock
 		if (try_to_take_rt_mutex(lock, current, &waiter))
 			break;
 
+		if (&waiter == rt_mutex_top_waiter(lock))
+			owner = rt_mutex_owner(lock);
+		else
+			owner = NULL;
 		raw_spin_unlock_irq(&lock->wait_lock);
 
-		schedule_rtlock();
+		if (!owner || !rtlock_adaptive_spinwait(lock, owner))
+			schedule_rtlock();
 
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(TASK_RTLOCK_WAIT);

