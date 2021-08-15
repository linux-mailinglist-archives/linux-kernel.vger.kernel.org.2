Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C6D3ECB32
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhHOVai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhHOV3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BFFC0612E7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:28:14 -0700 (PDT)
Message-ID: <20210815211303.311535693@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2xS8QWVahu8/8w7KR5UEL9NWaduMF4dun19PsgD8pk0=;
        b=ldQ3hg7t0llqIwW9EKCFnSR2sTlWEGfzGrP6UbKyRE0QHz6oWQmjSOQ5YWbGUui06K39xI
        V/6fYZUWVBf7VKjV1gLB83t5NBmKSxC3yz4eF1lTAbr5PEqCouy6Oo1Fx/PRFJGIQ7Wmsu
        Se65GsUqrsjyJQTg6Osv0V4McNg6Wxgbr1v5V96N4pk6FF7dWRIkeiY5wxjFsHFE3TxYM9
        HcTV+vohHL6GgWRrpavclxUiDCk+Uvr07oKwN6rdXwn+XR6KcP8BxJ3ks+Yr721dRxus+Y
        DIUQ13fm+Zz26icfRHD9pE6Ys8KBkmnmIALvB5s4NBxaveyGt4ZeJt/DVZm/DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2xS8QWVahu8/8w7KR5UEL9NWaduMF4dun19PsgD8pk0=;
        b=uOyJaEJrbAA0+AJkBvwVqrqNyamVSWUpNNzXuqXhnHMvtKcUQl+10iMmugYoFS52jFnT6D
        cq/EwbM2Tc7S+2Cg==
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
Subject: [patch V5 24/72] locking/rtmutex: Guard regular sleeping locks
 specific functions
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:12 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Guard the regular sleeping lock specific functionality which is used for
rtmutex on non-RT enabled kernels and for mutex, rtmutex and semaphores on
RT enabled kernels so the code can be reused for the RT specific
implementation of spinlocks and rwlocks in a different compilation unit.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c     |  254 ++++++++++++++++++++++---------------------
 kernel/locking/rtmutex_api.c |    1 
 kernel/locking/rwsem.c       |    1 
 3 files changed, 133 insertions(+), 123 deletions(-)
---
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1075,10 +1075,139 @@ static void __sched mark_wakeup_next_wai
 	raw_spin_unlock(&current->pi_lock);
 }
 
+static int __sched __rt_mutex_slowtrylock(struct rt_mutex_base *lock)
+{
+	int ret = try_to_take_rt_mutex(lock, current, NULL);
+
+	/*
+	 * try_to_take_rt_mutex() sets the lock waiters bit
+	 * unconditionally. Clean this up.
+	 */
+	fixup_rt_mutex_waiters(lock);
+
+	return ret;
+}
+
+/*
+ * Slow path try-lock function:
+ */
+static int __sched rt_mutex_slowtrylock(struct rt_mutex_base *lock)
+{
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * If the lock already has an owner we fail to get the lock.
+	 * This can be done without taking the @lock->wait_lock as
+	 * it is only being read, and this is a trylock anyway.
+	 */
+	if (rt_mutex_owner(lock))
+		return 0;
+
+	/*
+	 * The mutex has currently no owner. Lock the wait lock and try to
+	 * acquire the lock. We use irqsave here to support early boot calls.
+	 */
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+
+	ret = __rt_mutex_slowtrylock(lock);
+
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+
+	return ret;
+}
+
+static __always_inline int __rt_mutex_trylock(struct rt_mutex_base *lock)
+{
+	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
+		return 1;
+
+	return rt_mutex_slowtrylock(lock);
+}
+
+/*
+ * Slow path to release a rt-mutex.
+ */
+static void __sched rt_mutex_slowunlock(struct rt_mutex_base *lock)
+{
+	DEFINE_RT_WAKE_Q(wqh);
+	unsigned long flags;
+
+	/* irqsave required to support early boot calls */
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+
+	debug_rt_mutex_unlock(lock);
+
+	/*
+	 * We must be careful here if the fast path is enabled. If we
+	 * have no waiters queued we cannot set owner to NULL here
+	 * because of:
+	 *
+	 * foo->lock->owner = NULL;
+	 *			rtmutex_lock(foo->lock);   <- fast path
+	 *			free = atomic_dec_and_test(foo->refcnt);
+	 *			rtmutex_unlock(foo->lock); <- fast path
+	 *			if (free)
+	 *				kfree(foo);
+	 * raw_spin_unlock(foo->lock->wait_lock);
+	 *
+	 * So for the fastpath enabled kernel:
+	 *
+	 * Nothing can set the waiters bit as long as we hold
+	 * lock->wait_lock. So we do the following sequence:
+	 *
+	 *	owner = rt_mutex_owner(lock);
+	 *	clear_rt_mutex_waiters(lock);
+	 *	raw_spin_unlock(&lock->wait_lock);
+	 *	if (cmpxchg(&lock->owner, owner, 0) == owner)
+	 *		return;
+	 *	goto retry;
+	 *
+	 * The fastpath disabled variant is simple as all access to
+	 * lock->owner is serialized by lock->wait_lock:
+	 *
+	 *	lock->owner = NULL;
+	 *	raw_spin_unlock(&lock->wait_lock);
+	 */
+	while (!rt_mutex_has_waiters(lock)) {
+		/* Drops lock->wait_lock ! */
+		if (unlock_rt_mutex_safe(lock, flags) == true)
+			return;
+		/* Relock the rtmutex and try again */
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	}
+
+	/*
+	 * The wakeup next waiter path does not suffer from the above
+	 * race. See the comments there.
+	 *
+	 * Queue the next waiter for wakeup once we release the wait_lock.
+	 */
+	mark_wakeup_next_waiter(&wqh, lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+
+	rt_mutex_wake_up_q(&wqh);
+}
+
+static __always_inline void __rt_mutex_unlock(struct rt_mutex_base *lock)
+{
+	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
+		return;
+
+	rt_mutex_slowunlock(lock);
+}
+
+#ifdef RT_MUTEX_BUILD_MUTEX
+/*
+ * Functions required for:
+ *	- rtmutex, futex on all kernels
+ *	- mutex and rwsem substitutions on RT kernels
+ */
+
 /*
  * Remove a waiter from a lock and give up
  *
- * Must be called with lock->wait_lock held and interrupts disabled. I must
+ * Must be called with lock->wait_lock held and interrupts disabled. It must
  * have just failed to try_to_take_rt_mutex().
  */
 static void __sched remove_waiter(struct rt_mutex_base *lock,
@@ -1286,125 +1415,4 @@ static __always_inline int __rt_mutex_lo
 
 	return rt_mutex_slowlock(lock, state);
 }
-
-static int __sched __rt_mutex_slowtrylock(struct rt_mutex_base *lock)
-{
-	int ret = try_to_take_rt_mutex(lock, current, NULL);
-
-	/*
-	 * try_to_take_rt_mutex() sets the lock waiters bit
-	 * unconditionally. Clean this up.
-	 */
-	fixup_rt_mutex_waiters(lock);
-
-	return ret;
-}
-
-/*
- * Slow path try-lock function:
- */
-static int __sched rt_mutex_slowtrylock(struct rt_mutex_base *lock)
-{
-	unsigned long flags;
-	int ret;
-
-	/*
-	 * If the lock already has an owner we fail to get the lock.
-	 * This can be done without taking the @lock->wait_lock as
-	 * it is only being read, and this is a trylock anyway.
-	 */
-	if (rt_mutex_owner(lock))
-		return 0;
-
-	/*
-	 * The mutex has currently no owner. Lock the wait lock and try to
-	 * acquire the lock. We use irqsave here to support early boot calls.
-	 */
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-
-	ret = __rt_mutex_slowtrylock(lock);
-
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-
-	return ret;
-}
-
-static __always_inline int __rt_mutex_trylock(struct rt_mutex_base *lock)
-{
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
-		return 1;
-
-	return rt_mutex_slowtrylock(lock);
-}
-
-/*
- * Slow path to release a rt-mutex.
- */
-static void __sched rt_mutex_slowunlock(struct rt_mutex_base *lock)
-{
-	DEFINE_RT_WAKE_Q(wqh);
-	unsigned long flags;
-
-	/* irqsave required to support early boot calls */
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-
-	debug_rt_mutex_unlock(lock);
-
-	/*
-	 * We must be careful here if the fast path is enabled. If we
-	 * have no waiters queued we cannot set owner to NULL here
-	 * because of:
-	 *
-	 * foo->lock->owner = NULL;
-	 *			rtmutex_lock(foo->lock);   <- fast path
-	 *			free = atomic_dec_and_test(foo->refcnt);
-	 *			rtmutex_unlock(foo->lock); <- fast path
-	 *			if (free)
-	 *				kfree(foo);
-	 * raw_spin_unlock(foo->lock->wait_lock);
-	 *
-	 * So for the fastpath enabled kernel:
-	 *
-	 * Nothing can set the waiters bit as long as we hold
-	 * lock->wait_lock. So we do the following sequence:
-	 *
-	 *	owner = rt_mutex_owner(lock);
-	 *	clear_rt_mutex_waiters(lock);
-	 *	raw_spin_unlock(&lock->wait_lock);
-	 *	if (cmpxchg(&lock->owner, owner, 0) == owner)
-	 *		return;
-	 *	goto retry;
-	 *
-	 * The fastpath disabled variant is simple as all access to
-	 * lock->owner is serialized by lock->wait_lock:
-	 *
-	 *	lock->owner = NULL;
-	 *	raw_spin_unlock(&lock->wait_lock);
-	 */
-	while (!rt_mutex_has_waiters(lock)) {
-		/* Drops lock->wait_lock ! */
-		if (unlock_rt_mutex_safe(lock, flags) == true)
-			return;
-		/* Relock the rtmutex and try again */
-		raw_spin_lock_irqsave(&lock->wait_lock, flags);
-	}
-
-	/*
-	 * The wakeup next waiter path does not suffer from the above
-	 * race. See the comments there.
-	 *
-	 * Queue the next waiter for wakeup once we release the wait_lock.
-	 */
-	mark_wakeup_next_waiter(&wqh, lock);
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-
-	rt_mutex_wake_up_q(&wqh);
-}
-
-static __always_inline void __rt_mutex_unlock(struct rt_mutex_base *lock)
-{
-	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
-		return;
-
-	rt_mutex_slowunlock(lock);
-}
+#endif /* RT_MUTEX_BUILD_MUTEX */
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -5,6 +5,7 @@
 #include <linux/spinlock.h>
 #include <linux/export.h>
 
+#define RT_MUTEX_BUILD_MUTEX
 #include "rtmutex.c"
 
 /*
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1347,6 +1347,7 @@ static inline void __downgrade_write(str
 
 #else /* !CONFIG_PREEMPT_RT */
 
+#define RT_MUTEX_BUILD_MUTEX
 #include "rtmutex.c"
 
 #define rwbase_set_and_save_current_state(state)	\

