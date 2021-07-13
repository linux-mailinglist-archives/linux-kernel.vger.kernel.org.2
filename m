Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3163C7428
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhGMQRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54816 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbhGMQRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:17:00 -0400
Message-Id: <20210713160750.848393199@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=EHJeSjZK1+m3nQQLCNy8//V4qilvXkYZKrXA+/ZyTt4=;
        b=jDbKiJTDKL9tsdscVD0AtcCbm6lq5pdotjW6BMFVlxdu+BZTha6lwBwr9HMGMtOkMvaRsT
        X6R8NJjQifRdzF3W0mqB1xPhV1Qq7fTqtuBIoVo5EVStybVU7LpCpI1tV8ufBMFZ3sVATh
        0PmGoF+4I0aDyb0pNIoMDg6ZuHuxAhbU2yIV+ymGTRVQh+2mvwXl28Mz+0wHG0LIbFUfqz
        SoMNR1HEL9KeBbdURF3nVdDQqZ+DTLNGeYWifen5fE/HyC1xiuhX6ZGg+ZPQyI14FlQ+Lm
        Z/0hIwkK5BrfcsR6llNmZM02oSwzdVE3kKSob5Vd/5WGR3ae0926nBvTE4EBmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=EHJeSjZK1+m3nQQLCNy8//V4qilvXkYZKrXA+/ZyTt4=;
        b=zb5nTYCZBqkY2cghf+JFaybP2l6yfQ0PQ5dxs015TkfD1jzP/X+v3OwgjzSO1nUho3dQ0y
        XAU3k6sG59JZnMDA==
Date:   Tue, 13 Jul 2021 17:11:44 +0200
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
Subject: [patch 50/50] locking/rtmutex: Add adaptive spinwait mechanism
References: <20210713151054.700719949@linutronix.de>
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
@@ -1433,6 +1438,43 @@ static __always_inline int __rt_mutex_lo
  * Functions required for spin/rw_lock substitution on RT kernels
  */
 
+#ifdef CONFIG_SMP
+/*
+ * Note that owner is a speculative pointer and dereferencing relies
+ * on rcu_read_lock() and the check against the lock owner.
+ */
+static bool rtlock_adaptive_spinwait(struct rt_mutex *lock,
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
+static bool rtlock_adaptive_spinwait(struct rt_mutex *lock,
+				     struct task_struct *owner)
+{
+	return false;
+}
+#endif
+
 /**
  * rtlock_slowlock_locked - Slow path lock acquisition for RT locks
  * @lock:	The underlying rt mutex
@@ -1440,6 +1482,7 @@ static __always_inline int __rt_mutex_lo
 static void __sched rtlock_slowlock_locked(struct rt_mutex *lock)
 {
 	struct rt_mutex_waiter waiter;
+	struct task_struct *owner;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -1458,9 +1501,14 @@ static void __sched rtlock_slowlock_lock
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

