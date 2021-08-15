Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7468C3ECB30
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhHOVab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:30:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48068 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbhHOV2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:28:42 -0400
Message-ID: <20210815211303.197113263@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NPuiGoTkGySUcyiF0qz6LOiNNd6d7pwht3zfTC353yI=;
        b=RMRjNIXTRh1EzpAKvhYfH93sy49ptVUcsfpf6xreysBXA6bgZQffrCgctxQaK42G+/DflT
        N9O1Y8sBNhHopREtGn0BV/y/mafEfA8EZ3Nbi60Je6tKZd5olxk7bvR2mK8AN6rGCnGGJt
        DL1HQPJpUs8TQIt+alSQgMZMo2qplzHekXkMKd17lcCCzIKhWDahdi0YabuGfdp/daD5Ok
        Ev/pOZxGpM2lyUIHpMg1iODmoNCdXHXX1QW8I2eBsAYlpSH0h83QiYMuMMQVkjbJFIvG1o
        kMRwerMKcLXHp/KVVqMyM8oIabgOT1DzlCUslIupToLGFTu73tyGR4yEMmDJuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NPuiGoTkGySUcyiF0qz6LOiNNd6d7pwht3zfTC353yI=;
        b=TY15wGOok8TUF6j7eLcRT/cHuOTIp09dj2Q12SJmEExq9XXcUICpPMED6SUOftT8lyZNUv
        lZ2hljVaKXLt4fCA==
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
Subject: [patch V5 22/72] locking/rtmutex: Use rt_mutex_wake_q_head
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:09 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Prepare for the required state aware handling of waiter wakeups via wake_q
and switch the rtmutex code over to the rtmutex specific wrapper.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Adopt to rename
---
 kernel/futex.c                  |    8 ++++----
 kernel/locking/rtmutex.c        |   12 ++++++------
 kernel/locking/rtmutex_api.c    |   19 ++++++++-----------
 kernel/locking/rtmutex_common.h |    4 ++--
 4 files changed, 20 insertions(+), 23 deletions(-)
---
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1493,11 +1493,11 @@ static void mark_wake_futex(struct wake_
  */
 static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
 {
-	u32 curval, newval;
 	struct rt_mutex_waiter *top_waiter;
 	struct task_struct *new_owner;
 	bool postunlock = false;
-	DEFINE_WAKE_Q(wake_q);
+	DEFINE_RT_WAKE_Q(wqh);
+	u32 curval, newval;
 	int ret = 0;
 
 	top_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
@@ -1549,14 +1549,14 @@ static int wake_futex_pi(u32 __user *uad
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
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1017,7 +1017,7 @@ static int __sched task_blocks_on_rt_mut
  *
  * Called with lock->wait_lock held and interrupts disabled.
  */
-static void __sched mark_wakeup_next_waiter(struct wake_q_head *wake_q,
+static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
 					    struct rt_mutex_base *lock)
 {
 	struct rt_mutex_waiter *waiter;
@@ -1054,10 +1054,10 @@ static void __sched mark_wakeup_next_wai
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
 
@@ -1328,7 +1328,7 @@ static __always_inline int __rt_mutex_tr
  */
 static void __sched rt_mutex_slowunlock(struct rt_mutex_base *lock)
 {
-	DEFINE_WAKE_Q(wake_q);
+	DEFINE_RT_WAKE_Q(wqh);
 	unsigned long flags;
 
 	/* irqsave required to support early boot calls */
@@ -1381,10 +1381,10 @@ static void __sched rt_mutex_slowunlock(
 	 *
 	 * Queue the next waiter for wakeup once we release the wait_lock.
 	 */
-	mark_wakeup_next_waiter(&wake_q, lock);
+	mark_wakeup_next_waiter(&wqh, lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
-	rt_mutex_postunlock(&wake_q);
+	rt_mutex_wake_up_q(&wqh);
 }
 
 static __always_inline void __rt_mutex_unlock(struct rt_mutex_base *lock)
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -137,10 +137,10 @@ int __sched __rt_mutex_futex_trylock(str
  * do not use the fast-path, can be simple and will not need to retry.
  *
  * @lock:	The rt_mutex to be unlocked
- * @wake_q:	The wake queue head from which to get the next lock waiter
+ * @wqh:	The wake queue head from which to get the next lock waiter
  */
 bool __sched __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
-				     struct wake_q_head *wake_q)
+				     struct rt_wake_q_head *wqh)
 {
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -157,23 +157,23 @@ bool __sched __rt_mutex_futex_unlock(str
 	 * avoid inversion prior to the wakeup.  preempt_disable()
 	 * therein pairs with rt_mutex_postunlock().
 	 */
-	mark_wakeup_next_waiter(wake_q, lock);
+	mark_wakeup_next_waiter(wqh, lock);
 
 	return true; /* call postunlock() */
 }
 
 void __sched rt_mutex_futex_unlock(struct rt_mutex_base *lock)
 {
-	DEFINE_WAKE_Q(wake_q);
+	DEFINE_RT_WAKE_Q(wqh);
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
@@ -441,12 +441,9 @@ void __sched rt_mutex_adjust_pi(struct t
 /*
  * Performs the wakeup of the top-waiter and re-enables preemption.
  */
-void __sched rt_mutex_postunlock(struct wake_q_head *wake_q)
+void __sched rt_mutex_postunlock(struct rt_wake_q_head *wqh)
 {
-	wake_up_q(wake_q);
-
-	/* Pairs with preempt_disable() in mark_wakeup_next_waiter() */
-	preempt_enable();
+	rt_mutex_wake_up_q(wqh);
 }
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -76,9 +76,9 @@ extern int __rt_mutex_futex_trylock(stru
 
 extern void rt_mutex_futex_unlock(struct rt_mutex_base *lock);
 extern bool __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
-				struct wake_q_head *wake_q);
+				struct rt_wake_q_head *wqh);
 
-extern void rt_mutex_postunlock(struct wake_q_head *wake_q);
+extern void rt_mutex_postunlock(struct rt_wake_q_head *wqh);
 
 /*
  * Must be guarded because this header is included from rcu/tree_plugin.h

