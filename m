Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1943E90EB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbhHKM04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:26:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50874 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbhHKMYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:24:18 -0400
Message-ID: <20210811121418.181768544@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BU+a69+6ahUqAFhsziSIuOkhY64ZRPFjxofuSmf1/Ac=;
        b=c40J4TZhei4jHzXVkjfi2hPPgxxIfdC9VVzWJkoSLRTqBDn0qRet7+8rW4axMsInhrcsYt
        ESHONGGQUo6iAbrvg6vD0npuT4oyYT4k9riCzHpSfMeZ1eTRd6r1NswmpJP99R90dx5s/k
        sla8QECWEeE0T99EoIhy2BdV9FZ8DAdmA5dKe+VD5vaDVjCu4WpSonm3aDdi+rEGFbgO/C
        /6ylA3sWVFHFcIR7xqJT7nXN6MQhlOJx69PfqdNeWE/X1DE5p659LSPj3NWbPe3w8JsXQL
        rJggw+yoTOFBNu60ZhMGAXkhbWHvlq7Fu34Ihhi7ftLONj3MJO8gpJhWMVuKTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BU+a69+6ahUqAFhsziSIuOkhY64ZRPFjxofuSmf1/Ac=;
        b=4nYnITFp9TEDBLhWcS+uA/BK12z92V6W+PKE/u4WRxLgmDDO/o8Tt9hHv0io7cn7EfdAz3
        Qim13oImEkb8nYCw==
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
Subject: [patch V4 68/68] locking/rtmutex: Add adaptive spinwait mechanism
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:54 +0200 (CEST)
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

[ tglx: Provide a contemporary changelog, extended it to all rtmutex based
  	locks and updated it to match the other spin on owner implementations ]

Originally-by: Gregory Haskins <ghaskins@novell.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Rename to rtmutex_spin_on_owner() (PeterZ)
    Check for top waiter changes and rewrite comment (Davidlohr)
V3: Fold the extension for regular sleeping locks and add the missing spin
    wait checks (PeterZ)
---
 kernel/locking/rtmutex.c |   67 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)
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
@@ -1297,6 +1302,52 @@ static __always_inline void __rt_mutex_u
 	rt_mutex_slowunlock(lock);
 }
 
+#ifdef CONFIG_SMP
+static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
+				  struct rt_mutex_waiter *waiter,
+				  struct task_struct *owner)
+{
+	bool res = true;
+
+	rcu_read_lock();
+	for (;;) {
+		/* If owner changed, trylock again. */
+		if (owner != rt_mutex_owner(lock))
+			break;
+		/*
+		 * Ensure that @owner is dereferenced after checking that
+		 * the lock owner still matches @owner. If that fails,
+		 * @owner might point to freed memory. If it still matches,
+		 * the rcu_read_lock() ensures the memory stays valid.
+		 */
+		barrier();
+		/*
+		 * Stop spinning when:
+		 *  - the lock owner has been scheduled out
+		 *  - current is not longer the top waiter
+		 *  - current is requested to reschedule (redundant
+		 *    for CONFIG_PREEMPT_RCU=y)
+		 *  - the VCPU on which owner runs is preempted
+		 */
+		if (!owner->on_cpu || waiter != rt_mutex_top_waiter(lock) ||
+		    need_resched() || vcpu_is_preempted(task_cpu(owner))) {
+			res = false;
+			break;
+		}
+		cpu_relax();
+	}
+	rcu_read_unlock();
+	return res;
+}
+#else
+static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
+				  struct rt_mutex_waiter *waiter,
+				  struct task_struct *owner)
+{
+	return false;
+}
+#endif
+
 #ifdef RT_MUTEX_BUILD_MUTEX
 /*
  * Functions required for:
@@ -1381,6 +1432,7 @@ static int __sched rt_mutex_slowlock_blo
 					   struct rt_mutex_waiter *waiter)
 {
 	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
+	struct task_struct *owner;
 	int ret = 0;
 
 	for (;;) {
@@ -1403,9 +1455,14 @@ static int __sched rt_mutex_slowlock_blo
 				break;
 		}
 
+		if (waiter == rt_mutex_top_waiter(lock))
+			owner = rt_mutex_owner(lock);
+		else
+			owner = NULL;
 		raw_spin_unlock_irq(&lock->wait_lock);
 
-		schedule();
+		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
+			schedule();
 
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(state);
@@ -1561,6 +1618,7 @@ static __always_inline int __rt_mutex_lo
 static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 {
 	struct rt_mutex_waiter waiter;
+	struct task_struct *owner;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -1579,9 +1637,14 @@ static void __sched rtlock_slowlock_lock
 		if (try_to_take_rt_mutex(lock, current, &waiter))
 			break;
 
+		if (&waiter == rt_mutex_top_waiter(lock))
+			owner = rt_mutex_owner(lock);
+		else
+			owner = NULL;
 		raw_spin_unlock_irq(&lock->wait_lock);
 
-		schedule_rtlock();
+		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner))
+			schedule_rtlock();
 
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(TASK_RTLOCK_WAIT);

