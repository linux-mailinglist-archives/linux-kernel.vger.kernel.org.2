Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598173C7408
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhGMQQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhGMQQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B054C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:13:29 -0700 (PDT)
Message-Id: <20210713160747.508939354@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=RgEvoilDtZuvM/rgzZYNRaINN+JqCA34j/+gxoDFym4=;
        b=PYkN/gNUcszegeryogzllVg2k4Mp6I4LGQL4JTB72mmhDXHDVJHo/gpNCYVkaZIPzA9eCl
        jPNSevqbWtcyRT1GvVO18hxM/Dag07p1icoeQoKrLDtjBk7EsBuEiyHqs9q97XxmIiD4HQ
        MpRqjQJ4GopEvcQhXFKGL0C9TtKwp4HtFlmA+t3LuHtIQWv+M0GBXbqsMz9N/7n0TLLIAc
        IOBa7j08KJ+YxyQAyhFC6vkMr6jjliHH2ajMgq+QxcwIXU93e+caI8+GSDX6zHXq9/RIp+
        1c03XKPjLIr1/jfWmSYrpx4l5xyI+saGUbnn3Q65Z5ZzuCn7Ez+vlLsDeeI9Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=RgEvoilDtZuvM/rgzZYNRaINN+JqCA34j/+gxoDFym4=;
        b=7pnWJp7biunq8YKUNyZTHx5hCF+pfryPGtg3BpUwLB+bc/dL5hn8FkjHnH+UFiE3Fk1ZAR
        2gy+Ays9IYBgNADQ==
Date:   Tue, 13 Jul 2021 17:11:10 +0200
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
Subject: [patch 16/50] locking/rtmutex: Use rt_mutex_wake_q_head
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Prepare for the required state aware handling of waiter wakeups via wake_q
and switch the rtmutex code over to the rtmutex specific wrapper.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c                  |  6 +++---
 kernel/locking/rtmutex.c        | 12 ++++++------
 kernel/locking/rtmutex_api.c    | 19 ++++++++-----------
 kernel/locking/rtmutex_common.h |  4 ++--
 4 files changed, 19 insertions(+), 22 deletions(-)
---
diff --git a/kernel/futex.c b/kernel/futex.c
index 408cad5e8968..e60bcddec287 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1493,11 +1493,11 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
  */
 static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
 {
+	DEFINE_RT_MUTEX_WAKE_Q_HEAD(wqh);
 	u32 curval, newval;
 	struct rt_mutex_waiter *top_waiter;
 	struct task_struct *new_owner;
 	bool postunlock = false;
-	DEFINE_WAKE_Q(wake_q);
 	int ret = 0;
 
 	top_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
@@ -1549,14 +1549,14 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_
 		 * not fail.
 		 */
 		pi_state_update_owner(pi_state, new_owner);
-		postunlock = __rt_mutex_futex_unlock(&pi_state->pi_mutex, &wake_q);
+		postunlock = __rt_mutex_futex_unlock(&pi_state->pi_mutex, &wqh);
 	}
 
 out_unlock:
 	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 
 	if (postunlock)
-		rt_mutex_postunlock(&wake_q);
+		rt_mutex_postunlock(&wqh);
 
 	return ret;
 }
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index db3103e2733b..11b2e7d29641 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1017,7 +1017,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex *lock,
  *
  * Called with lock->wait_lock held and interrupts disabled.
  */
-static void __sched mark_wakeup_next_waiter(struct wake_q_head *wake_q,
+static void __sched mark_wakeup_next_waiter(struct rt_mutex_wake_q_head *wqh,
 					    struct rt_mutex *lock)
 {
 	struct rt_mutex_waiter *waiter;
@@ -1054,10 +1054,10 @@ static void __sched mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 	 * deboost but before waking our donor task, hence the preempt_disable()
 	 * before unlock.
 	 *
-	 * Pairs with preempt_enable() in rt_mutex_postunlock();
+	 * Pairs with preempt_enable() in rt_mutex_wake_up_q();
 	 */
 	preempt_disable();
-	wake_q_add(wake_q, waiter->task);
+	rt_mutex_wake_q_add(wqh, waiter);
 	raw_spin_unlock(&current->pi_lock);
 }
 
@@ -1323,7 +1323,7 @@ static __always_inline int __rt_mutex_trylock(struct rt_mutex *lock)
  */
 static void __sched rt_mutex_slowunlock(struct rt_mutex *lock)
 {
-	DEFINE_WAKE_Q(wake_q);
+	DEFINE_RT_MUTEX_WAKE_Q_HEAD(wqh);
 	unsigned long flags;
 
 	/* irqsave required to support early boot calls */
@@ -1376,10 +1376,10 @@ static void __sched rt_mutex_slowunlock(struct rt_mutex *lock)
 	 *
 	 * Queue the next waiter for wakeup once we release the wait_lock.
 	 */
-	mark_wakeup_next_waiter(&wake_q, lock);
+	mark_wakeup_next_waiter(&wqh, lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
-	rt_mutex_postunlock(&wake_q);
+	rt_mutex_wake_up_q(&wqh);
 }
 
 static __always_inline void __rt_mutex_unlock(struct rt_mutex *lock)
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 976ad96477eb..174af1375068 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -131,10 +131,10 @@ int __sched __rt_mutex_futex_trylock(struct rt_mutex *lock)
  * do not use the fast-path, can be simple and will not need to retry.
  *
  * @lock:	The rt_mutex to be unlocked
- * @wake_q:	The wake queue head from which to get the next lock waiter
+ * @wqh:	The wake queue head from which to get the next lock waiter
  */
 bool __sched __rt_mutex_futex_unlock(struct rt_mutex *lock,
-				     struct wake_q_head *wake_q)
+				     struct rt_mutex_wake_q_head *wqh)
 {
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -151,23 +151,23 @@ bool __sched __rt_mutex_futex_unlock(struct rt_mutex *lock,
 	 * avoid inversion prior to the wakeup.  preempt_disable()
 	 * therein pairs with rt_mutex_postunlock().
 	 */
-	mark_wakeup_next_waiter(wake_q, lock);
+	mark_wakeup_next_waiter(wqh, lock);
 
 	return true; /* call postunlock() */
 }
 
 void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
 {
-	DEFINE_WAKE_Q(wake_q);
+	DEFINE_RT_MUTEX_WAKE_Q_HEAD(wqh);
 	unsigned long flags;
 	bool postunlock;
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-	postunlock = __rt_mutex_futex_unlock(lock, &wake_q);
+	postunlock = __rt_mutex_futex_unlock(lock, &wqh);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	if (postunlock)
-		rt_mutex_postunlock(&wake_q);
+		rt_mutex_postunlock(&wqh);
 }
 
 /**
@@ -436,12 +436,9 @@ void __sched rt_mutex_adjust_pi(struct task_struct *task)
 /*
  * Performs the wakeup of the top-waiter and re-enables preemption.
  */
-void __sched rt_mutex_postunlock(struct wake_q_head *wake_q)
+void __sched rt_mutex_postunlock(struct rt_mutex_wake_q_head *wqh)
 {
-	wake_up_q(wake_q);
-
-	/* Pairs with preempt_disable() in mark_wakeup_next_waiter() */
-	preempt_enable();
+	rt_mutex_wake_up_q(wqh);
 }
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index b1ea7fe88546..f6a453c4ad69 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -76,9 +76,9 @@ extern int __rt_mutex_futex_trylock(struct rt_mutex *l);
 
 extern void rt_mutex_futex_unlock(struct rt_mutex *lock);
 extern bool __rt_mutex_futex_unlock(struct rt_mutex *lock,
-				struct wake_q_head *wake_q);
+				struct rt_mutex_wake_q_head *wqh);
 
-extern void rt_mutex_postunlock(struct wake_q_head *wake_q);
+extern void rt_mutex_postunlock(struct rt_mutex_wake_q_head *wqh);
 
 /* Special interfaces for RT lock substitutions */
 int rwsem_rt_mutex_slowlock_locked(struct rt_mutex *lock, unsigned int state);

