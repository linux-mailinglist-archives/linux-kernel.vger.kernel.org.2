Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6850A3E1858
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbhHEPmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242303AbhHEPll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:41:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8296AC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 08:41:26 -0700 (PDT)
Message-ID: <20210805153953.626686331@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7Gt7wkKDeTyrAIfWaoS+eX8qMORYsBHar2hZJqWkADQ=;
        b=Omp2btIaX9tPrrOqvTE8pfu1GYnqwHyF7bgUlqkmSXOQmKGFKL1sB/w/C+GOSgsqN7IhNG
        6eriFjzhn1CZ2Bw1i/gXN/YsQBjRkk98o1PPqC3/xaU+5+oUxtI1VcIDSugXylnSbPG4Sn
        QO6UnqepN0oaBDwj6h5/IsSmhbLy7BqKD6Yac3/Xc42vdb0ln9V/N5/CAbjAtbSS1jrOev
        rQeA6++S4tsbtZEuMa/wNVrZhektU4HYiF9A///6e/fsPNpz2o/5yzifUzEeGVquYVM8GX
        WPc9VYM8ovsWdvbZ5Nhh1yTMbYtlmG9kUyKi9XjLScbxmv8uTXmfP+TfTCz1vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7Gt7wkKDeTyrAIfWaoS+eX8qMORYsBHar2hZJqWkADQ=;
        b=E6WOLR/tByA8gl/dK9j4L5Q6NIlgZapdgdkpSIpMw7oTr5Pi8cSFzLG0/vVWw4jn4jFUum
        XBZCZy++vQXyK0Dw==
Date:   Thu, 05 Aug 2021 17:13:14 +0200
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
Subject: [patch V3 14/64] locking/rtmutex: Provide rt_mutex_slowlock_locked()
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Split the inner workings of rt_mutex_slowlock() out into a separate
function which can be reused by the upcoming RT lock substitutions,
e.g. for rw_semaphores.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Add the dropped debug_rt_mutex_free_waiter() - Valentin
---
 kernel/locking/rtmutex.c     |  100 ++++++++++++++++++++++++-------------------
 kernel/locking/rtmutex_api.c |    2 
 2 files changed, 59 insertions(+), 43 deletions(-)
---
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1106,7 +1106,7 @@ static void __sched remove_waiter(struct
 }
 
 /**
- * __rt_mutex_slowlock() - Perform the wait-wake-try-to-take loop
+ * rt_mutex_slowlock_block() - Perform the wait-wake-try-to-take loop
  * @lock:		 the rt_mutex to take
  * @state:		 the state the task should block in (TASK_INTERRUPTIBLE
  *			 or TASK_UNINTERRUPTIBLE)
@@ -1115,10 +1115,10 @@ static void __sched remove_waiter(struct
  *
  * Must be called with lock->wait_lock held and interrupts disabled
  */
-static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
-				       unsigned int state,
-				       struct hrtimer_sleeper *timeout,
-				       struct rt_mutex_waiter *waiter)
+static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
+					   unsigned int state,
+					   struct hrtimer_sleeper *timeout,
+					   struct rt_mutex_waiter *waiter)
 {
 	int ret = 0;
 
@@ -1168,52 +1168,37 @@ static void __sched rt_mutex_handle_dead
 	}
 }
 
-/*
- * Slow path lock function:
+/**
+ * __rt_mutex_slowlock - Locking slowpath invoked with lock::wait_lock held
+ * @lock:	The rtmutex to block lock
+ * @state:	The task state for sleeping
+ * @chwalk:	Indicator whether full or partial chainwalk is requested
+ * @waiter:	Initializer waiter for blocking
  */
-static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
-				     unsigned int state,
-				     struct hrtimer_sleeper *timeout,
-				     enum rtmutex_chainwalk chwalk)
+static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
+				       unsigned int state,
+				       enum rtmutex_chainwalk chwalk,
+				       struct rt_mutex_waiter *waiter)
 {
-	struct rt_mutex_waiter waiter;
-	unsigned long flags;
-	int ret = 0;
-
-	rt_mutex_init_waiter(&waiter);
+	int ret;
 
-	/*
-	 * Technically we could use raw_spin_[un]lock_irq() here, but this can
-	 * be called in early boot if the cmpxchg() fast path is disabled
-	 * (debug, no architecture support). In this case we will acquire the
-	 * rtmutex with lock->wait_lock held. But we cannot unconditionally
-	 * enable interrupts in that early boot case. So we need to use the
-	 * irqsave/restore variants.
-	 */
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	lockdep_assert_held(&lock->wait_lock);
 
 	/* Try to acquire the lock again: */
-	if (try_to_take_rt_mutex(lock, current, NULL)) {
-		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+	if (try_to_take_rt_mutex(lock, current, NULL))
 		return 0;
-	}
 
 	set_current_state(state);
 
-	/* Setup the timer, when timeout != NULL */
-	if (unlikely(timeout))
-		hrtimer_start_expires(&timeout->timer, HRTIMER_MODE_ABS);
-
-	ret = task_blocks_on_rt_mutex(lock, &waiter, current, chwalk);
+	ret = task_blocks_on_rt_mutex(lock, waiter, current, chwalk);
 
 	if (likely(!ret))
-		/* sleep on the mutex */
-		ret = __rt_mutex_slowlock(lock, state, timeout, &waiter);
+		ret = rt_mutex_slowlock_block(lock, state, NULL, waiter);
 
 	if (unlikely(ret)) {
 		__set_current_state(TASK_RUNNING);
-		remove_waiter(lock, &waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
+		remove_waiter(lock, waiter);
+		rt_mutex_handle_deadlock(ret, chwalk, waiter);
 	}
 
 	/*
@@ -1221,14 +1206,45 @@ static int __sched rt_mutex_slowlock(str
 	 * unconditionally. We might have to fix that up.
 	 */
 	fixup_rt_mutex_waiters(lock);
+	return ret;
+}
 
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
+					     unsigned int state)
+{
+	struct rt_mutex_waiter waiter;
+	int ret;
 
-	/* Remove pending timer: */
-	if (unlikely(timeout))
-		hrtimer_cancel(&timeout->timer);
+	rt_mutex_init_waiter(&waiter);
+
+	ret = __rt_mutex_slowlock(lock, state, RT_MUTEX_MIN_CHAINWALK, &waiter);
 
 	debug_rt_mutex_free_waiter(&waiter);
+	return ret;
+}
+
+/*
+ * rt_mutex_slowlock - Locking slowpath invoked when fast path fails
+ * @lock:	The rtmutex to block lock
+ * @state:	The task state for sleeping
+ */
+static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
+				     unsigned int state)
+{
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * Technically we could use raw_spin_[un]lock_irq() here, but this can
+	 * be called in early boot if the cmpxchg() fast path is disabled
+	 * (debug, no architecture support). In this case we will acquire the
+	 * rtmutex with lock->wait_lock held. But we cannot unconditionally
+	 * enable interrupts in that early boot case. So we need to use the
+	 * irqsave/restore variants.
+	 */
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	ret = __rt_mutex_slowlock_locked(lock, state);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	return ret;
 }
@@ -1239,7 +1255,7 @@ static __always_inline int __rt_mutex_lo
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
 
-	return rt_mutex_slowlock(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK);
+	return rt_mutex_slowlock(lock, state);
 }
 
 static int __sched __rt_mutex_slowtrylock(struct rt_mutex_base *lock)
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -342,7 +342,7 @@ int __sched rt_mutex_wait_proxy_lock(str
 	raw_spin_lock_irq(&lock->wait_lock);
 	/* sleep on the mutex */
 	set_current_state(TASK_INTERRUPTIBLE);
-	ret = __rt_mutex_slowlock(lock, TASK_INTERRUPTIBLE, to, waiter);
+	ret = rt_mutex_slowlock_block(lock, TASK_INTERRUPTIBLE, to, waiter);
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
 	 * have to fix that up.

