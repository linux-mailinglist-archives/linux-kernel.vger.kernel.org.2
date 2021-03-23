Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48222346B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbhCWVlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:41:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35882 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbhCWVjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:39:55 -0400
Message-Id: <20210323213708.699640478@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616535594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=FYzwTvyJk5l6vSLRPwqDCXw55YXZDDKcWIt7ezPOy7k=;
        b=lz3dvH5psGtQThScld4AIfnvcXQOgfxtFE3qUy+w3+x4y5RCiBlT/cJ9UjFcb1XGPx7dw6
        GZhP5JknFdFs/ColBk1v7PiLJbfjcTNlmlQ8DtROoFI674mAIK17I2mBw6hoDKSyc14jSw
        OVN3shfrg6qj9Y70D9ElTjo2f+dAmgoGQRbIc17QzyRMfCJP0CHwmMskiWBDbNB06TvxZm
        Qlg1II7r6r1N5jpIpa5mcwcojcvaRP40co+FaBGtmsuqUVa42iTJdrocR3xlrG1AVMc2Ic
        R+5XMayQUEuN+nxCoFL/qna0BjQDPpEej5sODBXIeMspwb1O10czROkqxLsiGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616535594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=FYzwTvyJk5l6vSLRPwqDCXw55YXZDDKcWIt7ezPOy7k=;
        b=YJIBMjAogYiOOHUn03YJCPD57xBtcEyIXnL7L+msRZX232Z8vTA8eSsplNB6+gI+K0+cbC
        PfnUEtlyUofecMDg==
Date:   Tue, 23 Mar 2021 22:30:31 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 12/14] locking/rtmutex: Consolidate the fast/slowpath invocation
References: <20210323213019.217008708@linutronix.de>
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
 kernel/locking/rtmutex.c |  129 +++++++++++++++++------------------------------
 1 file changed, 49 insertions(+), 80 deletions(-)

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
@@ -1370,60 +1381,20 @@ static bool __sched rt_mutex_slowunlock(
  * The atomic acquire/release ops are compiled away, when either the
  * architecture does not support cmpxchg or when debugging is enabled.
  */
-static __always_inline int
-rt_mutex_fastlock(struct rt_mutex *lock, int state,
-		  int (*slowfn)(struct rt_mutex *lock, int state,
-				struct hrtimer_sleeper *timeout,
-				enum rtmutex_chainwalk chwalk))
+static __always_inline int __rt_mutex_lock(struct rt_mutex *lock, long state)
 {
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
-		return 0;
+	int ret;
 
-	return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK);
-}
+	might_sleep();
 
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
+		return 0;
 
-static __always_inline void __rt_mutex_lock(struct rt_mutex *lock,
-					    unsigned int subclass)
-{
-	might_sleep();
+	ret = rt_mutex_slowlock(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK);
+	if (ret)
+		mutex_release(&lock->dep_map, _RET_IP_);
 
-	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
-	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, rt_mutex_slowlock);
+	return ret;
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -1435,7 +1406,8 @@ static __always_inline void __rt_mutex_l
  */
 void __sched rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass)
 {
-	__rt_mutex_lock(lock, subclass);
+	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	__rt_mutex_lock(lock);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
 
@@ -1448,7 +1420,7 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
  */
 void __sched rt_mutex_lock(struct rt_mutex *lock)
 {
-	__rt_mutex_lock(lock, 0);
+	__rt_mutex_lock(lock, TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock);
 #endif
@@ -1464,32 +1436,10 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock);
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
+	return __rt_mutex_lock(lock, TASK_INTERRUPTIBLE);
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
@@ -1508,7 +1458,10 @@ int __sched rt_mutex_trylock(struct rt_m
 	if (WARN_ON_ONCE(in_irq() || in_nmi() || in_serving_softirq()))
 		return 0;
 
-	ret = rt_mutex_fasttrylock(lock, rt_mutex_slowtrylock);
+	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
+		return 1;
+
+	ret = rt_mutex_slowtrylock(lock);
 	if (ret)
 		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 
@@ -1524,10 +1477,26 @@ EXPORT_SYMBOL_GPL(rt_mutex_trylock);
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

