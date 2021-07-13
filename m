Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCF93C740A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhGMQQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbhGMQQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C873BC0613EE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:13:31 -0700 (PDT)
Message-Id: <20210713160747.710766613@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=FF6MvAvtRttkwQnBpmp7rVGNOncLIBtp2kxN9m9Ox+A=;
        b=IeS2cUe3wCcsuHfwExno/zVq5zYEvUlaWmBEwcmEKIT0jc/hW0p7+qru6C0mWYIdntEXNk
        FqcisTEOl4PIy7xYIHiq88dsQLAUbG4olcnSSP3WwHQM4xyjVGSJHhk8fuIPhMimRUWbiW
        YyJJMxYUKbV7m0GIMu724f3ceDDNUlGCil67drUKN2NM75Xjkfd/uvDTg6k4BbCp345z2i
        8fq8EOTuLI/i9R4kWnDW8GDsa3rFI+Gl/SH7GIkJjMV5J36NHCQ77u53q3YgGjwOHGzNxv
        D4zo2ftTOzo4zuECwoVw3XVUwsvmGT0uQjuVfigHvLC2D6+lhTPy8k2Qozv8Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=FF6MvAvtRttkwQnBpmp7rVGNOncLIBtp2kxN9m9Ox+A=;
        b=Z1yJM6iKs2wu+69v3AcgBcaNTKA3xiKOyBnqur0HNnSw2iYgUW2K5EfuIksoUVWDSLarfU
        oGohy2Ea68Ctf4Bg==
Date:   Tue, 13 Jul 2021 17:11:12 +0200
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
Subject: [patch 18/50] locking/rtmutex: Guard regular sleeping locks specific
 functions
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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
 2 files changed, 132 insertions(+), 123 deletions(-)
---
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1073,10 +1073,139 @@ static void __sched mark_wakeup_next_wai
 	raw_spin_unlock(&current->pi_lock);
 }
 
+static int __sched __rt_mutex_slowtrylock(struct rt_mutex *lock)
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
+static int __sched rt_mutex_slowtrylock(struct rt_mutex *lock)
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
+static __always_inline int __rt_mutex_trylock(struct rt_mutex *lock)
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
+static void __sched rt_mutex_slowunlock(struct rt_mutex *lock)
+{
+	DEFINE_RT_MUTEX_WAKE_Q_HEAD(wqh);
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
+static __always_inline void __rt_mutex_unlock(struct rt_mutex *lock)
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
 static void __sched remove_waiter(struct rt_mutex *lock,
@@ -1279,125 +1408,4 @@ static __always_inline int __rt_mutex_lo
 
 	return rt_mutex_slowlock(lock, state);
 }
-
-static int __sched __rt_mutex_slowtrylock(struct rt_mutex *lock)
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
-static int __sched rt_mutex_slowtrylock(struct rt_mutex *lock)
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
-static __always_inline int __rt_mutex_trylock(struct rt_mutex *lock)
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
-static void __sched rt_mutex_slowunlock(struct rt_mutex *lock)
-{
-	DEFINE_RT_MUTEX_WAKE_Q_HEAD(wqh);
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
-static __always_inline void __rt_mutex_unlock(struct rt_mutex *lock)
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

