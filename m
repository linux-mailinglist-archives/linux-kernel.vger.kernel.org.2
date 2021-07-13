Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B836E3C73F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhGMQQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhGMQQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E64C0613EE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:13:22 -0700 (PDT)
Message-Id: <20210713160746.897411744@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=EklltaEgzl8Hg+2FsjfnhVsZ5WiFfWb23kWvpEcaAas=;
        b=hfCqEpwvV16auMdd/9MHbfAjNjJq9T95auWGn4rwtE7BGg6rGN2LJ0ohHjBA6a6E0tUMIU
        fIWfFHQEUoniLdqZu9qufiQAy0gHVMTiciIqvD8IG4sVSxOZM/qraGAC0/J+AD4n9Uv8WB
        8C5nXMCRxnS/Dg+ZwX52GibmvfVI+HIHmGYwWNbFHtx8JKfIk0ieROGiJUKEx5cg3o92jF
        bPUGVnpKadRTWZPIoLw73umXCmOuR3rjmQBMbUyBe30dEIBqcoHPkSn7JIz7WYxghi+iqQ
        4yrghxVVKlaW717jUwwk6gENReA2sMwACWBiW+PNLiHWkS5oruFjvIiK7+3Xvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=EklltaEgzl8Hg+2FsjfnhVsZ5WiFfWb23kWvpEcaAas=;
        b=z3bxTYSaLhLaA/yugPIehq1lXi8iGgpjACPGuLWnAauWdMbfi0svd/XBGPYesym9GnZ6ck
        ++YXikJnvI+GkXCQ==
Date:   Tue, 13 Jul 2021 17:11:04 +0200
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
Subject: [patch 10/50] locking/rtmutex: Provide rt_mutex_slowlock_locked()
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Split the inner workings of rt_mutex_slowlock() out into a seperate
function which can be reused by the upcoming RT lock substitutions,
e.g. for rw_semaphores.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c        |   95 ++++++++++++++++++++++------------------
 kernel/locking/rtmutex_api.c    |   16 ++++++
 kernel/locking/rtmutex_common.h |    3 +
 3 files changed, 72 insertions(+), 42 deletions(-)
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
@@ -1115,9 +1115,10 @@ static void __sched remove_waiter(struct
  *
  * Must be called with lock->wait_lock held and interrupts disabled
  */
-static int __sched __rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state,
-				       struct hrtimer_sleeper *timeout,
-				       struct rt_mutex_waiter *waiter)
+static int __sched rt_mutex_slowlock_block(struct rt_mutex *lock,
+					   unsigned int state,
+					   struct hrtimer_sleeper *timeout,
+					   struct rt_mutex_waiter *waiter)
 {
 	int ret = 0;
 
@@ -1167,51 +1168,37 @@ static void __sched rt_mutex_handle_dead
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
-static int __sched rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state,
-				     struct hrtimer_sleeper *timeout,
-				     enum rtmutex_chainwalk chwalk)
+static int __sched __rt_mutex_slowlock(struct rt_mutex *lock,
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
@@ -1219,14 +1206,40 @@ static int __sched rt_mutex_slowlock(str
 	 * unconditionally. We might have to fix that up.
 	 */
 	fixup_rt_mutex_waiters(lock);
+	return ret;
+}
 
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+static inline int __rt_mutex_slowlock_locked(struct rt_mutex *lock,
+					     unsigned int state)
+{
+	struct rt_mutex_waiter waiter;
 
-	/* Remove pending timer: */
-	if (unlikely(timeout))
-		hrtimer_cancel(&timeout->timer);
+	rt_mutex_init_waiter(&waiter);
+
+	return __rt_mutex_slowlock(lock, state, RT_MUTEX_MIN_CHAINWALK, &waiter);
+}
+
+/*
+ * rt_mutex_slowlock - Locking slowpath invoked when fast path fails
+ * @lock:	The rtmutex to block lock
+ * @state:	The task state for sleeping
+ */
+static int __sched rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state)
+{
+	unsigned long flags;
+	int ret;
 
-	debug_rt_mutex_free_waiter(&waiter);
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
@@ -1237,7 +1250,7 @@ static __always_inline int __rt_mutex_lo
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
 
-	return rt_mutex_slowlock(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK);
+	return rt_mutex_slowlock(lock, state);
 }
 
 static int __sched __rt_mutex_slowtrylock(struct rt_mutex *lock)
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -337,7 +337,7 @@ int __sched rt_mutex_wait_proxy_lock(str
 	raw_spin_lock_irq(&lock->wait_lock);
 	/* sleep on the mutex */
 	set_current_state(TASK_INTERRUPTIBLE);
-	ret = __rt_mutex_slowlock(lock, TASK_INTERRUPTIBLE, to, waiter);
+	ret = rt_mutex_slowlock_block(lock, TASK_INTERRUPTIBLE, to, waiter);
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
 	 * have to fix that up.
@@ -451,3 +451,17 @@ void rt_mutex_debug_task_free(struct tas
 	DEBUG_LOCKS_WARN_ON(task->pi_blocked_on);
 }
 #endif
+
+/* Interfaces for PREEMPT_RT lock substitutions */
+#ifdef CONFIG_PREEMPT_RT
+/**
+ * rwsem_rt_mutex_slowlock_locked - Lock slowpath invoked with @lock::wait_lock held
+ * @lock:	The rtmutex to acquire
+ * @state:	The task state for blocking
+ */
+int __sched rwsem_rt_mutex_slowlock_locked(struct rt_mutex *lock,
+					  unsigned int state)
+{
+	return __rt_mutex_slowlock_locked(lock, state);
+}
+#endif
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -64,6 +64,9 @@ extern bool __rt_mutex_futex_unlock(stru
 
 extern void rt_mutex_postunlock(struct wake_q_head *wake_q);
 
+/* Special interfaces for RT lock substitutions */
+int rwsem_rt_mutex_slowlock_locked(struct rt_mutex *lock, unsigned int state);
+
 /*
  * Must be guarded because this header is included from rcu/tree_plugin.h
  * unconditionally.

