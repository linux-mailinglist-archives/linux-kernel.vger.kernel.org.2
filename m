Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60ECD34AC34
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhCZQCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhCZQBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:01:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751B7C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:01:45 -0700 (PDT)
Message-Id: <20210326153944.247927548@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616774504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jPGOL6lFgYenW29LknCmZgY9M6HKxCXkjqLKyS0EtLk=;
        b=3Ir09po8HhY+Q+n2oe5YTjpM6amnamBfipHszWaAoZP0BzSUHAI/OL/KJLwDoOseR7abHT
        GEuwvPuUXniBw8oLgY1xaKwn1hlDCzAi00zl4osiTJYjr8DCb/c1KntCx0l4QxNNo3TxJd
        TKOWClhrfwcpefzwQ7xD8Qg0G6n5BXGpQOu81mReByr97s8aZYPtOiwBZFU9XwrTN2O+3z
        UqwmiusAAm/b5YDHNole0LdB/lleh8l6clH7oLX+gF0YF/e1NeKGmltAFz3lMaW5YQHd11
        Nktu81FUAACV5CUButSoiSEosQrkeCtpBWSbu0MYJM7KNJU3se3P/Aa0gN70lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616774504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jPGOL6lFgYenW29LknCmZgY9M6HKxCXkjqLKyS0EtLk=;
        b=hsSF2S6DhX+dgiEmUD81WDS/hzR4+O7MyGhH6ht2gKU1WUmX75eZIA8TGi4NY5OYbnbead
        UBsK4wM8JkmJ4LAQ==
Date:   Fri, 26 Mar 2021 16:29:41 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 12/15] locking/rtmutex: Consolidate the fast/slowpath invocation
References: <20210326152929.709289883@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The indirection via a function pointer (which is at least optimized into a
tail call by the compiler) is making the code hard to read.

Clean it up and move the futex related trylock functions down to the futex
section.

Move the wake_q wakeup into rt_mutex_slowunlock(). No point in handing it
to the caller. The futex code uses a different function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Make lockdep work by design and not just by chance
---
 kernel/locking/rtmutex.c |  144 +++++++++++++++++++----------------------------
 1 file changed, 59 insertions(+), 85 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1299,13 +1299,24 @@ static int __sched rt_mutex_slowtrylock(
 }
 
 /*
+ * Performs the wakeup of the top-waiter and re-enables preemption.
+ */
+void __sched rt_mutex_postunlock(struct wake_q_head *wake_q)
+{
+	wake_up_q(wake_q);
+
+	/* Pairs with preempt_disable() in rt_mutex_slowunlock() */
+	preempt_enable();
+}
+
+/*
  * Slow path to release a rt-mutex.
  *
  * Return whether the current task needs to call rt_mutex_postunlock().
  */
-static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
-					struct wake_q_head *wake_q)
+static void __sched rt_mutex_slowunlock(struct rt_mutex *lock)
 {
+	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
 
 	/* irqsave required to support early boot calls */
@@ -1347,7 +1358,7 @@ static bool __sched rt_mutex_slowunlock(
 	while (!rt_mutex_has_waiters(lock)) {
 		/* Drops lock->wait_lock ! */
 		if (unlock_rt_mutex_safe(lock, flags) == true)
-			return false;
+			return;
 		/* Relock the rtmutex and try again */
 		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
@@ -1358,10 +1369,10 @@ static bool __sched rt_mutex_slowunlock(
 	 *
 	 * Queue the next waiter for wakeup once we release the wait_lock.
 	 */
-	mark_wakeup_next_waiter(wake_q, lock);
+	mark_wakeup_next_waiter(&wake_q, lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
-	return true; /* call rt_mutex_postunlock() */
+	rt_mutex_postunlock(&wake_q);
 }
 
 /*
@@ -1370,60 +1381,21 @@ static bool __sched rt_mutex_slowunlock(
  * The atomic acquire/release ops are compiled away, when either the
  * architecture does not support cmpxchg or when debugging is enabled.
  */
-static __always_inline int
-rt_mutex_fastlock(struct rt_mutex *lock, int state,
-		  int (*slowfn)(struct rt_mutex *lock, int state,
-				struct hrtimer_sleeper *timeout,
-				enum rtmutex_chainwalk chwalk))
+static __always_inline int __rt_mutex_lock(struct rt_mutex *lock, long state,
+					   unsigned int subclass)
 {
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
-		return 0;
+	int ret;
 
-	return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK);
-}
+	might_sleep();
+	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
 
-static __always_inline int
-rt_mutex_fasttrylock(struct rt_mutex *lock,
-		     int (*slowfn)(struct rt_mutex *lock))
-{
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
-		return 1;
-
-	return slowfn(lock);
-}
-
-/*
- * Performs the wakeup of the top-waiter and re-enables preemption.
- */
-void __sched rt_mutex_postunlock(struct wake_q_head *wake_q)
-{
-	wake_up_q(wake_q);
-
-	/* Pairs with preempt_disable() in rt_mutex_slowunlock() */
-	preempt_enable();
-}
-
-static __always_inline void
-rt_mutex_fastunlock(struct rt_mutex *lock,
-		    bool (*slowfn)(struct rt_mutex *lock,
-				   struct wake_q_head *wqh))
-{
-	DEFINE_WAKE_Q(wake_q);
-
-	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
-		return;
-
-	if (slowfn(lock, &wake_q))
-		rt_mutex_postunlock(&wake_q);
-}
-
-static __always_inline void __rt_mutex_lock(struct rt_mutex *lock,
-					    unsigned int subclass)
-{
-	might_sleep();
+		return 0;
 
-	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
-	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, rt_mutex_slowlock);
+	ret = rt_mutex_slowlock(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK);
+	if (ret)
+		mutex_release(&lock->dep_map, _RET_IP_);
+	return ret;
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -1435,7 +1407,7 @@ static __always_inline void __rt_mutex_l
  */
 void __sched rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass)
 {
-	__rt_mutex_lock(lock, subclass);
+	__rt_mutex_lock(lock, TASK_UNINTERRUPTIBLE, subclass);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
 
@@ -1448,7 +1420,7 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
  */
 void __sched rt_mutex_lock(struct rt_mutex *lock)
 {
-	__rt_mutex_lock(lock, 0);
+	__rt_mutex_lock(lock, TASK_UNINTERRUPTIBLE, 0);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock);
 #endif
@@ -1464,42 +1436,21 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock);
  */
 int __sched rt_mutex_lock_interruptible(struct rt_mutex *lock)
 {
-	int ret;
-
-	might_sleep();
-
-	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	ret = rt_mutex_fastlock(lock, TASK_INTERRUPTIBLE, rt_mutex_slowlock);
-	if (ret)
-		mutex_release(&lock->dep_map, _RET_IP_);
-
-	return ret;
+	return __rt_mutex_lock(lock, TASK_INTERRUPTIBLE, 0);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible);
 
-/*
- * Futex variant, must not use fastpath.
- */
-int __sched rt_mutex_futex_trylock(struct rt_mutex *lock)
-{
-	return rt_mutex_slowtrylock(lock);
-}
-
-int __sched __rt_mutex_futex_trylock(struct rt_mutex *lock)
-{
-	return __rt_mutex_slowtrylock(lock);
-}
-
 /**
  * rt_mutex_trylock - try to lock a rt_mutex
  *
  * @lock:	the rt_mutex to be locked
  *
- * This function can only be called in thread context. It's safe to
- * call it from atomic regions, but not from hard interrupt or soft
- * interrupt context.
+ * This function can only be called in thread context. It's safe to call it
+ * from atomic regions, but not from hard or soft interrupt context.
  *
- * Returns 1 on success and 0 on contention
+ * Returns:
+ *  1 on success
+ *  0 on contention
  */
 int __sched rt_mutex_trylock(struct rt_mutex *lock)
 {
@@ -1508,7 +1459,14 @@ int __sched rt_mutex_trylock(struct rt_m
 	if (WARN_ON_ONCE(in_irq() || in_nmi() || in_serving_softirq()))
 		return 0;
 
-	ret = rt_mutex_fasttrylock(lock, rt_mutex_slowtrylock);
+	/*
+	 * No lockdep annotation required because lockdep disables the fast
+	 * path.
+	 */
+	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
+		return 1;
+
+	ret = rt_mutex_slowtrylock(lock);
 	if (ret)
 		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 
@@ -1524,10 +1482,26 @@ EXPORT_SYMBOL_GPL(rt_mutex_trylock);
 void __sched rt_mutex_unlock(struct rt_mutex *lock)
 {
 	mutex_release(&lock->dep_map, _RET_IP_);
-	rt_mutex_fastunlock(lock, rt_mutex_slowunlock);
+	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
+		return;
+
+	rt_mutex_slowunlock(lock);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_unlock);
 
+/*
+ * Futex variants, must not use fastpath.
+ */
+int __sched rt_mutex_futex_trylock(struct rt_mutex *lock)
+{
+	return rt_mutex_slowtrylock(lock);
+}
+
+int __sched __rt_mutex_futex_trylock(struct rt_mutex *lock)
+{
+	return __rt_mutex_slowtrylock(lock);
+}
+
 /**
  * __rt_mutex_futex_unlock - Futex variant, that since futex variants
  * do not use the fast-path, can be simple and will not need to retry.

