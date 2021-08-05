Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A783E1895
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242810AbhHEPqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:46:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44554 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242478AbhHEPm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:59 -0400
Message-ID: <20210805153956.507589092@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=sZ+ArfnpGIkqlgpVaQdtCxQn6qTi++uYQ5vC8P1LMNY=;
        b=qyo7oFkhGf10jQKCdW214exzWBTfr9gF5IVWmMf37jJ5Lmv02PZxwsmUfaffTO1mcV4D/z
        jkUSoql0gtnqJo836833mDfH/eCR+HMktftHao3nWCY9fq8B543fSNnSLiixlIjuMK+eKe
        3/4AEwCOKkpve/5gG788PDcjsvGTP3pr64QYfkV8oW66QpAb3f4poDVoDaEtsp4nx/OzB+
        95CDQqBdlol6igvxBf/PNc0NxDNJMWJn8kZDrCCYQtsBl5WNbmWmma4ckYhuZ5dAVjNnBC
        Ug+nmjRcdvg6FrSOljPJxXCiGRJ08kRMSj1etrzMxs8sLVSxiy+7PQeQ4bEodg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=sZ+ArfnpGIkqlgpVaQdtCxQn6qTi++uYQ5vC8P1LMNY=;
        b=Bp9otr7/k1+E1O+XIZmu+pXJBwo4Bnp17H7btedDMDs59TzdCUFnV+v3ZBXE7ypj6gkLmM
        oRh5IYgqFHrJKjDg==
Date:   Thu, 05 Aug 2021 17:14:04 +0200
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
Subject: [patch V3 64/64] locking/rtmutex: Add adaptive spinwait mechanism
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

Going to sleep when locks are contended can be quite inefficient when the
contention time is short and the lock owner is running on a different CPU.

The MCS mechanism cannot be used because MCS is strictly FIFO ordered while
for rtmutex based locks the waiter ordering is priority based.

Provide a simple adaptive spinwait mechanism which currently restricts the
spinning to the top priority waiter.

[ tglx: Provide a contemporary changelog ]

Originally-by: Gregory Haskins <ghaskins@novell.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Fold the extension for regular sleeping locks and add the missing spin
    wait checks (PeterZ)
---
 kernel/locking/rtmutex.c |   59 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)
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
@@ -1278,6 +1283,44 @@ static __always_inline void __rt_mutex_u
 	rt_mutex_slowunlock(lock);
 }
 
+#ifdef CONFIG_SMP
+/*
+ * Note that owner is a speculative pointer and dereferencing relies
+ * on rcu_read_lock() and the check against the lock owner.
+ */
+static bool rtmutex_adaptive_spinwait(struct rt_mutex_base *lock,
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
+		if (!owner->on_cpu || need_resched() ||
+		    vcpu_is_preempted(task_cpu(owner))) {
+			res = false;
+			break;
+		}
+		cpu_relax();
+	}
+	rcu_read_unlock();
+	return res;
+}
+#else
+static bool rtmutex_adaptive_spinwait(struct rt_mutex_base *lock,
+				     struct task_struct *owner)
+{
+	return false;
+}
+#endif
+
 #ifdef RT_MUTEX_BUILD_MUTEX
 /*
  * Functions required for:
@@ -1362,6 +1405,7 @@ static int __sched rt_mutex_slowlock_blo
 					   struct rt_mutex_waiter *waiter)
 {
 	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
+	struct task_struct *owner;
 	int ret = 0;
 
 	for (;;) {
@@ -1384,9 +1428,14 @@ static int __sched rt_mutex_slowlock_blo
 				break;
 		}
 
+		if (waiter == rt_mutex_top_waiter(lock))
+			owner = rt_mutex_owner(lock);
+		else
+			owner = NULL;
 		raw_spin_unlock_irq(&lock->wait_lock);
 
-		schedule();
+		if (!owner || !rtmutex_adaptive_spinwait(lock, owner))
+			schedule();
 
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(state);
@@ -1542,6 +1591,7 @@ static __always_inline int __rt_mutex_lo
 static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 {
 	struct rt_mutex_waiter waiter;
+	struct task_struct *owner;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -1560,9 +1610,14 @@ static void __sched rtlock_slowlock_lock
 		if (try_to_take_rt_mutex(lock, current, &waiter))
 			break;
 
+		if (&waiter == rt_mutex_top_waiter(lock))
+			owner = rt_mutex_owner(lock);
+		else
+			owner = NULL;
 		raw_spin_unlock_irq(&lock->wait_lock);
 
-		schedule_rtlock();
+		if (!owner || !rtmutex_adaptive_spinwait(lock, owner))
+			schedule_rtlock();
 
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(TASK_RTLOCK_WAIT);

