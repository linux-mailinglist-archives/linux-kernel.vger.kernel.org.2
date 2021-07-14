Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A9D3C822A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbhGNJ6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbhGNJ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:58:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC255C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K1JbiRtLu0rigiaVI7hC9E0bSh6c22itw9vvNSrmo7s=; b=OeVdZhioRDQiXUf+EpyRWm7Mqx
        UY6f53VY1ySjI3JqwgR6lqAb2+taMj//+gXkheIkccW/WSUeL/RNRSXUND536mP/1ODfngg3r4/xp
        NqxeiJT3VlawL/55qnF8kfJDEabxHZ3Dty8W22SrnbnYtBWQGvbeUM0Eag6V8ya2xQcdnSJ5FTkVz
        26IA+J3J0X+SCW22NiaBjooloOflCdqBrFD0UZxFT6PVBgq1b5ahpQhByeNrP/++bbvrAuNlYnuDl
        FAHK6G37LFZ+5Gg2jRABCpjMAiJ+SfWfadVB88hlPP229j7CUYWg2DgJfRf1zQtNM0QjN3Gj2jWYr
        y0VonkDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3bbX-00HRsx-JT; Wed, 14 Jul 2021 09:54:59 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D380F98689D; Wed, 14 Jul 2021 11:54:58 +0200 (CEST)
Date:   Wed, 14 Jul 2021 11:54:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 24/50] locking/spinlock: Provide RT specific spinlock type
Message-ID: <20210714095458.GF2725@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de>
 <20210713160748.288862984@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713160748.288862984@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 05:11:18PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> RT replaces spinlocks with a simple wrapper around a rtmutex which turns
> spinlocks on RT into 'sleeping' spinlocks. The actual implementation of the
> spinlock API differs from a regular rtmutex as it does neither handle
> timeouts nor signals and it is state preserving accross the lock operation.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/spinlock_types.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> ---
> diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
> index 7c8107c280c0..98d498f9e4fc 100644
> --- a/include/linux/spinlock_types.h
> +++ b/include/linux/spinlock_types.h
> @@ -51,6 +51,9 @@
>  
>  #define DEFINE_RAW_SPINLOCK(x)	raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
>  
> +#ifndef CONFIG_PREEMPT_RT
> +
> +/* Non PREEMPT_RT kernels map spinlock to raw_spinlock */
>  typedef struct spinlock {
>  	union {
>  		struct raw_spinlock rlock;
> @@ -79,6 +82,29 @@ typedef struct spinlock {
>  
>  #define DEFINE_SPINLOCK(x)	spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
>  
> +#else /* !CONFIG_PREEMPT_RT */
> +
> +/* PREEMPT_RT kernels map spinlock to rt_mutex */
> +#include <linux/rtmutex.h>
> +
> +typedef struct spinlock {
> +	struct rt_mutex		lock;
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	struct lockdep_map	dep_map;
> +#endif
> +} spinlock_t;

Despite patch #11, struct rt_mutex already includes a lockdep_map. This
means struct spinlock will now include 2 of them (well, 3 if you also
count the one for wait_lock). Which might be pushing things a little.

Do we want something like this instead?

---

--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -19,6 +19,12 @@
 
 extern int max_lock_depth; /* for sysctl */
 
+struct rt_mutex_base {
+	raw_spinlock_t		wait_lock;
+	struct rb_root_cached   waiters;
+	struct task_struct	*owner;
+};
+
 /**
  * The rt_mutex structure
  *
@@ -28,9 +34,7 @@ extern int max_lock_depth; /* for sysctl
  * @owner:	the mutex owner
  */
 struct rt_mutex {
-	raw_spinlock_t		wait_lock;
-	struct rb_root_cached   waiters;
-	struct task_struct	*owner;
+	struct rt_mutex_base	rtmutex;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
@@ -67,17 +71,6 @@ do { \
 #define DEFINE_RT_MUTEX(mutexname) \
 	struct rt_mutex mutexname = __RT_MUTEX_INITIALIZER(mutexname)
 
-/**
- * rt_mutex_is_locked - is the mutex locked
- * @lock: the mutex to be queried
- *
- * Returns 1 if the mutex is locked, 0 if unlocked.
- */
-static inline int rt_mutex_is_locked(struct rt_mutex *lock)
-{
-	return lock->owner != NULL;
-}
-
 extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -179,7 +179,7 @@ struct futex_pi_state {
 	/*
 	 * The PI object:
 	 */
-	struct rt_mutex pi_mutex;
+	struct rt_mutex_base pi_mutex;
 
 	struct task_struct *owner;
 	refcount_t refcount;
@@ -3254,7 +3254,7 @@ static int futex_wait_requeue_pi(u32 __u
 			ret = ret < 0 ? ret : 0;
 		}
 	} else {
-		struct rt_mutex *pi_mutex;
+		struct rt_mutex_base *pi_mutex;
 
 		/*
 		 * We have been woken up by futex_unlock_pi(), a timeout, or a
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -48,7 +48,7 @@
  */
 
 static __always_inline void
-rt_mutex_set_owner(struct rt_mutex *lock, struct task_struct *owner)
+rt_mutex_set_owner(struct rt_mutex_base *lock, struct task_struct *owner)
 {
 	unsigned long val = (unsigned long)owner;
 
@@ -58,13 +58,13 @@ rt_mutex_set_owner(struct rt_mutex *lock
 	WRITE_ONCE(lock->owner, (struct task_struct *)val);
 }
 
-static __always_inline void clear_rt_mutex_waiters(struct rt_mutex *lock)
+static __always_inline void clear_rt_mutex_waiters(struct rt_mutex_base *lock)
 {
 	lock->owner = (struct task_struct *)
 			((unsigned long)lock->owner & ~RT_MUTEX_HAS_WAITERS);
 }
 
-static __always_inline void fixup_rt_mutex_waiters(struct rt_mutex *lock)
+static __always_inline void fixup_rt_mutex_waiters(struct rt_mutex_base *lock)
 {
 	unsigned long owner, *p = (unsigned long *) &lock->owner;
 
@@ -139,14 +139,14 @@ static __always_inline void fixup_rt_mut
  * set up.
  */
 #ifndef CONFIG_DEBUG_RT_MUTEXES
-static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex *lock,
+static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex_base *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
 {
 	return try_cmpxchg_acquire(&lock->owner, &old, new);
 }
 
-static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex *lock,
+static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
 {
@@ -158,7 +158,7 @@ static __always_inline bool rt_mutex_cmp
  * all future threads that attempt to [Rmw] the lock to the slowpath. As such
  * relaxed semantics suffice.
  */
-static __always_inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
+static __always_inline void mark_rt_mutex_waiters(struct rt_mutex_base *lock)
 {
 	unsigned long owner, *p = (unsigned long *) &lock->owner;
 
@@ -174,7 +174,7 @@ static __always_inline void mark_rt_mute
  * 2) Drop lock->wait_lock
  * 3) Try to unlock the lock with cmpxchg
  */
-static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
+static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex_base *lock,
 						 unsigned long flags)
 	__releases(lock->wait_lock)
 {
@@ -210,7 +210,7 @@ static __always_inline bool unlock_rt_mu
 }
 
 #else
-static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex *lock,
+static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex_base *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
 {
@@ -218,14 +218,14 @@ static __always_inline bool rt_mutex_cmp
 
 }
 
-static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex *lock,
+static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
 {
 	return false;
 }
 
-static __always_inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
+static __always_inline void mark_rt_mutex_waiters(struct rt_mutex_base *lock)
 {
 	lock->owner = (struct task_struct *)
 			((unsigned long)lock->owner | RT_MUTEX_HAS_WAITERS);
@@ -234,7 +234,7 @@ static __always_inline void mark_rt_mute
 /*
  * Simple slow path only version: lock->owner is protected by lock->wait_lock.
  */
-static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
+static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex_base *lock,
 						 unsigned long flags)
 	__releases(lock->wait_lock)
 {
@@ -295,13 +295,13 @@ static __always_inline bool __waiter_les
 }
 
 static __always_inline void
-rt_mutex_enqueue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
+rt_mutex_enqueue(struct rt_mutex_base *lock, struct rt_mutex_waiter *waiter)
 {
 	rb_add_cached(&waiter->tree_entry, &lock->waiters, __waiter_less);
 }
 
 static __always_inline void
-rt_mutex_dequeue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
+rt_mutex_dequeue(struct rt_mutex_base *lock, struct rt_mutex_waiter *waiter)
 {
 	if (RB_EMPTY_NODE(&waiter->tree_entry))
 		return;
@@ -392,7 +392,7 @@ rt_mutex_cond_detect_deadlock(struct rt_
 	return chwalk == RT_MUTEX_FULL_CHAINWALK;
 }
 
-static __always_inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
+static __always_inline struct rt_mutex_base *task_blocked_on_lock(struct task_struct *p)
 {
 	return p->pi_blocked_on ? p->pi_blocked_on->lock : NULL;
 }
@@ -462,15 +462,15 @@ static __always_inline struct rt_mutex *
  */
 static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 					      enum rtmutex_chainwalk chwalk,
-					      struct rt_mutex *orig_lock,
-					      struct rt_mutex *next_lock,
+					      struct rt_mutex_base *orig_lock,
+					      struct rt_mutex_base *next_lock,
 					      struct rt_mutex_waiter *orig_waiter,
 					      struct task_struct *top_task)
 {
 	struct rt_mutex_waiter *waiter, *top_waiter = orig_waiter;
 	struct rt_mutex_waiter *prerequeue_top_waiter;
 	int ret = 0, depth = 0;
-	struct rt_mutex *lock;
+	struct rt_mutex_base *lock;
 	bool detect_deadlock;
 	bool requeue = true;
 
@@ -818,7 +818,7 @@ static int __sched rt_mutex_adjust_prio_
  *	    callsite called task_blocked_on_lock(), otherwise NULL
  */
 static int __sched
-try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
+try_to_take_rt_mutex(struct rt_mutex_base *lock, struct task_struct *task,
 		     struct rt_mutex_waiter *waiter)
 {
 	lockdep_assert_held(&lock->wait_lock);
@@ -936,14 +936,14 @@ try_to_take_rt_mutex(struct rt_mutex *lo
  *
  * This must be called with lock->wait_lock held and interrupts disabled
  */
-static int __sched task_blocks_on_rt_mutex(struct rt_mutex *lock,
+static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 					   struct rt_mutex_waiter *waiter,
 					   struct task_struct *task,
 					   enum rtmutex_chainwalk chwalk)
 {
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex_waiter *top_waiter = waiter;
-	struct rt_mutex *next_lock;
+	struct rt_mutex_base *next_lock;
 	int chain_walk = 0, res;
 
 	lockdep_assert_held(&lock->wait_lock);
@@ -1026,7 +1026,7 @@ static int __sched task_blocks_on_rt_mut
  * Called with lock->wait_lock held and interrupts disabled.
  */
 static void __sched mark_wakeup_next_waiter(struct rt_mutex_wake_q_head *wqh,
-					    struct rt_mutex *lock)
+					    struct rt_mutex_base *lock)
 {
 	struct rt_mutex_waiter *waiter;
 
@@ -1069,7 +1069,7 @@ static void __sched mark_wakeup_next_wai
 	raw_spin_unlock(&current->pi_lock);
 }
 
-static int __sched __rt_mutex_slowtrylock(struct rt_mutex *lock)
+static int __sched __rt_mutex_slowtrylock(struct rt_mutex_base *lock)
 {
 	int ret = try_to_take_rt_mutex(lock, current, NULL);
 
@@ -1085,7 +1085,7 @@ static int __sched __rt_mutex_slowtryloc
 /*
  * Slow path try-lock function:
  */
-static int __sched rt_mutex_slowtrylock(struct rt_mutex *lock)
+static int __sched rt_mutex_slowtrylock(struct rt_mutex_base *lock)
 {
 	unsigned long flags;
 	int ret;
@@ -1111,7 +1111,7 @@ static int __sched rt_mutex_slowtrylock(
 	return ret;
 }
 
-static __always_inline int __rt_mutex_trylock(struct rt_mutex *lock)
+static __always_inline int __rt_mutex_trylock(struct rt_mutex_base *lock)
 {
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 1;
@@ -1122,7 +1122,7 @@ static __always_inline int __rt_mutex_tr
 /*
  * Slow path to release a rt-mutex.
  */
-static void __sched rt_mutex_slowunlock(struct rt_mutex *lock)
+static void __sched rt_mutex_slowunlock(struct rt_mutex_base *lock)
 {
 	DEFINE_RT_MUTEX_WAKE_Q_HEAD(wqh);
 	unsigned long flags;
@@ -1183,7 +1183,7 @@ static void __sched rt_mutex_slowunlock(
 	rt_mutex_wake_up_q(&wqh);
 }
 
-static __always_inline void __rt_mutex_unlock(struct rt_mutex *lock)
+static __always_inline void __rt_mutex_unlock(struct rt_mutex_base *lock)
 {
 	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
 		return;
@@ -1204,12 +1204,12 @@ static __always_inline void __rt_mutex_u
  * Must be called with lock->wait_lock held and interrupts disabled. It must
  * have just failed to try_to_take_rt_mutex().
  */
-static void __sched remove_waiter(struct rt_mutex *lock,
+static void __sched remove_waiter(struct rt_mutex_base *lock,
 				  struct rt_mutex_waiter *waiter)
 {
 	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
-	struct rt_mutex *next_lock;
+	struct rt_mutex_base *next_lock;
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -1267,7 +1267,7 @@ static void __sched remove_waiter(struct
  *
  * Must be called with lock->wait_lock held and interrupts disabled
  */
-static int __sched rt_mutex_slowlock_block(struct rt_mutex *lock,
+static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 					   unsigned int state,
 					   struct hrtimer_sleeper *timeout,
 					   struct rt_mutex_waiter *waiter)
@@ -1327,7 +1327,7 @@ static void __sched rt_mutex_handle_dead
  * @chwalk:	Indicator whether full or partial chainwalk is requested
  * @waiter:	Initializer waiter for blocking
  */
-static int __sched __rt_mutex_slowlock(struct rt_mutex *lock,
+static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 				       unsigned int state,
 				       enum rtmutex_chainwalk chwalk,
 				       struct rt_mutex_waiter *waiter)
@@ -1361,7 +1361,7 @@ static int __sched __rt_mutex_slowlock(s
 	return ret;
 }
 
-static inline int __rt_mutex_slowlock_locked(struct rt_mutex *lock,
+static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
 					     unsigned int state)
 {
 	struct rt_mutex_waiter waiter;
@@ -1376,7 +1376,7 @@ static inline int __rt_mutex_slowlock_lo
  * @lock:	The rtmutex to block lock
  * @state:	The task state for sleeping
  */
-static int __sched rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state)
+static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock, unsigned int state)
 {
 	unsigned long flags;
 	int ret;
@@ -1396,7 +1396,7 @@ static int __sched rt_mutex_slowlock(str
 	return ret;
 }
 
-static __always_inline int __rt_mutex_lock(struct rt_mutex *lock,
+static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 					   unsigned int state)
 {
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -27,7 +27,7 @@ static __always_inline int __rt_mutex_lo
 
 	might_sleep();
 	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
-	ret = __rt_mutex_lock(lock, state);
+	ret = __rt_mutex_lock(&lock->rtmutex, state);
 	if (ret)
 		mutex_release(&lock->dep_map, _RET_IP_);
 	return ret;
@@ -94,7 +94,7 @@ int __sched rt_mutex_trylock(struct rt_m
 	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) && WARN_ON_ONCE(!in_task()))
 		return 0;
 
-	ret = __rt_mutex_trylock(lock);
+	ret = __rt_mutex_trylock(&lock->rtmutex);
 	if (ret)
 		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 
@@ -110,19 +110,19 @@ EXPORT_SYMBOL_GPL(rt_mutex_trylock);
 void __sched rt_mutex_unlock(struct rt_mutex *lock)
 {
 	mutex_release(&lock->dep_map, _RET_IP_);
-	__rt_mutex_unlock(lock);
+	__rt_mutex_unlock(&lock->rtmutex);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_unlock);
 
 /*
  * Futex variants, must not use fastpath.
  */
-int __sched rt_mutex_futex_trylock(struct rt_mutex *lock)
+int __sched rt_mutex_futex_trylock(struct rt_mutex_base *lock)
 {
 	return rt_mutex_slowtrylock(lock);
 }
 
-int __sched __rt_mutex_futex_trylock(struct rt_mutex *lock)
+int __sched __rt_mutex_futex_trylock(struct rt_mutex_base *lock)
 {
 	return __rt_mutex_slowtrylock(lock);
 }
@@ -134,7 +134,7 @@ int __sched __rt_mutex_futex_trylock(str
  * @lock:	The rt_mutex to be unlocked
  * @wqh:	The wake queue head from which to get the next lock waiter
  */
-bool __sched __rt_mutex_futex_unlock(struct rt_mutex *lock,
+bool __sched __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
 				     struct rt_mutex_wake_q_head *wqh)
 {
 	lockdep_assert_held(&lock->wait_lock);
@@ -157,7 +157,7 @@ bool __sched __rt_mutex_futex_unlock(str
 	return true; /* call postunlock() */
 }
 
-void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
+void __sched rt_mutex_futex_unlock(struct rt_mutex_base *lock)
 {
 	DEFINE_RT_MUTEX_WAKE_Q_HEAD(wqh);
 	unsigned long flags;
@@ -186,9 +186,8 @@ void __sched __rt_mutex_init(struct rt_m
 		     struct lock_class_key *key)
 {
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
+	__rt_mutex_base_init(&lock->rtmutex);
 	lockdep_init_map(&lock->dep_map, name, key, 0);
-
-	__rt_mutex_basic_init(lock);
 }
 EXPORT_SYMBOL_GPL(__rt_mutex_init);
 
@@ -206,10 +205,10 @@ EXPORT_SYMBOL_GPL(__rt_mutex_init);
  * possible at this point because the pi_state which contains the rtmutex
  * is not yet visible to other tasks.
  */
-void __sched rt_mutex_init_proxy_locked(struct rt_mutex *lock,
+void __sched rt_mutex_init_proxy_locked(struct rt_mutex_base *lock,
 					struct task_struct *proxy_owner)
 {
-	__rt_mutex_basic_init(lock);
+	__rt_mutex_base_init(lock);
 	rt_mutex_set_owner(lock, proxy_owner);
 }
 
@@ -225,7 +224,7 @@ void __sched rt_mutex_init_proxy_locked(
  * possible because it belongs to the pi_state which is about to be freed
  * and it is not longer visible to other tasks.
  */
-void __sched rt_mutex_proxy_unlock(struct rt_mutex *lock)
+void __sched rt_mutex_proxy_unlock(struct rt_mutex_base *lock)
 {
 	debug_rt_mutex_proxy_unlock(lock);
 	rt_mutex_set_owner(lock, NULL);
@@ -250,7 +249,7 @@ void __sched rt_mutex_proxy_unlock(struc
  *
  * Special API call for PI-futex support.
  */
-int __sched __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
+int __sched __rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 					struct rt_mutex_waiter *waiter,
 					struct task_struct *task)
 {
@@ -297,7 +296,7 @@ int __sched __rt_mutex_start_proxy_lock(
  *
  * Special API call for PI-futex support.
  */
-int __sched rt_mutex_start_proxy_lock(struct rt_mutex *lock,
+int __sched rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 				      struct rt_mutex_waiter *waiter,
 				      struct task_struct *task)
 {
@@ -329,7 +328,7 @@ int __sched rt_mutex_start_proxy_lock(st
  *
  * Special API call for PI-futex support
  */
-int __sched rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
+int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
 				     struct hrtimer_sleeper *to,
 				     struct rt_mutex_waiter *waiter)
 {
@@ -369,7 +368,7 @@ int __sched rt_mutex_wait_proxy_lock(str
  *
  * Special API call for PI-futex support
  */
-bool __sched rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
+bool __sched rt_mutex_cleanup_proxy_lock(struct rt_mutex_base *lock,
 					 struct rt_mutex_waiter *waiter)
 {
 	bool cleanup = false;
@@ -414,7 +413,7 @@ bool __sched rt_mutex_cleanup_proxy_lock
 void __sched rt_mutex_adjust_pi(struct task_struct *task)
 {
 	struct rt_mutex_waiter *waiter;
-	struct rt_mutex *next_lock;
+	struct rt_mutex_base *next_lock;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
@@ -457,7 +456,7 @@ void rt_mutex_debug_task_free(struct tas
  * @lock:	The rtmutex to acquire
  * @state:	The task state for blocking
  */
-int __sched rwsem_rt_mutex_slowlock_locked(struct rt_mutex *lock,
+int __sched rwsem_rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
 					  unsigned int state)
 {
 	return __rt_mutex_slowlock_locked(lock, state);
@@ -472,7 +471,7 @@ int __sched rwsem_rt_mutex_slowlock_lock
  * changes have to be done on the callsite related to the locking primitive
  * which embeds the rtmutex. Otherwise lockdep has double tracking.
  */
-int __sched rwsem_rt_mutex_lock_state(struct rt_mutex *lock, unsigned int state)
+int __sched rwsem_rt_mutex_lock_state(struct rt_mutex_base *lock, unsigned int state)
 {
 	return __rt_mutex_lock(lock, state);
 }
@@ -485,7 +484,7 @@ int __sched rwsem_rt_mutex_lock_state(st
  * changes have to be done on the callsite related to the locking primitive
  * which embeds the rtmutex. Otherwise lockdep has double tracking.
  */
-int __sched rwsem_rt_mutex_trylock(struct rt_mutex *lock)
+int __sched rwsem_rt_mutex_trylock(struct rt_mutex_base *lock)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) &&
 	    WARN_ON_ONCE(in_nmi() | in_hardirq()))
@@ -505,7 +504,7 @@ int __sched rwsem_rt_mutex_trylock(struc
  * changes have to be done on the callsite related to the locking primitive
  * which embeds the rtmutex. Otherwise lockdep has double tracking.
  */
-void rwsem_rt_mutex_unlock(struct rt_mutex *lock)
+void rwsem_rt_mutex_unlock(struct rt_mutex_base *lock)
 {
 	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
 		return;
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -33,7 +33,7 @@ struct rt_mutex_waiter {
 	struct rb_node		tree_entry;
 	struct rb_node		pi_tree_entry;
 	struct task_struct	*task;
-	struct rt_mutex		*lock;
+	struct rt_mutex_base	*lock;
 	int			wake_state;
 	int			prio;
 	u64			deadline;
@@ -59,26 +59,26 @@ struct rt_mutex_wake_q_head {
 /*
  * PI-futex support (proxy locking functions, etc.):
  */
-extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
+extern void rt_mutex_init_proxy_locked(struct rt_mutex_base *lock,
 				       struct task_struct *proxy_owner);
-extern void rt_mutex_proxy_unlock(struct rt_mutex *lock);
-extern int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
+extern void rt_mutex_proxy_unlock(struct rt_mutex_base *lock);
+extern int __rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 				     struct rt_mutex_waiter *waiter,
 				     struct task_struct *task);
-extern int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
+extern int rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 				     struct rt_mutex_waiter *waiter,
 				     struct task_struct *task);
-extern int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
+extern int rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
 			       struct hrtimer_sleeper *to,
 			       struct rt_mutex_waiter *waiter);
-extern bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
+extern bool rt_mutex_cleanup_proxy_lock(struct rt_mutex_base *lock,
 				 struct rt_mutex_waiter *waiter);
 
-extern int rt_mutex_futex_trylock(struct rt_mutex *l);
-extern int __rt_mutex_futex_trylock(struct rt_mutex *l);
+extern int rt_mutex_futex_trylock(struct rt_mutex_base *l);
+extern int __rt_mutex_futex_trylock(struct rt_mutex_base *l);
 
-extern void rt_mutex_futex_unlock(struct rt_mutex *lock);
-extern bool __rt_mutex_futex_unlock(struct rt_mutex *lock,
+extern void rt_mutex_futex_unlock(struct rt_mutex_base *lock);
+extern bool __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
 				struct rt_mutex_wake_q_head *wqh);
 
 extern void rt_mutex_postunlock(struct rt_mutex_wake_q_head *wqh);
@@ -94,12 +94,12 @@ void rwsem_rt_mutex_unlock(struct rt_mut
  * unconditionally.
  */
 #ifdef CONFIG_RT_MUTEXES
-static inline int rt_mutex_has_waiters(struct rt_mutex *lock)
+static inline int rt_mutex_has_waiters(struct rt_mutex_base *lock)
 {
 	return !RB_EMPTY_ROOT(&lock->waiters.rb_root);
 }
 
-static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex *lock)
+static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex_base *lock)
 {
 	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
 	struct rt_mutex_waiter *w = NULL;
@@ -124,7 +124,7 @@ static inline struct rt_mutex_waiter *ta
 
 #define RT_MUTEX_HAS_WAITERS	1UL
 
-static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
+static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
 {
 	unsigned long owner = (unsigned long) READ_ONCE(lock->owner);
 
@@ -146,21 +146,21 @@ enum rtmutex_chainwalk {
 	RT_MUTEX_FULL_CHAINWALK,
 };
 
-static inline void __rt_mutex_basic_init(struct rt_mutex *lock)
+static inline void __rt_mutex_base_init(struct rt_mutex_base *lock)
 {
-	lock->owner = NULL;
 	raw_spin_lock_init(&lock->wait_lock);
 	lock->waiters = RB_ROOT_CACHED;
+	lock->owner = NULL;
 }
 
 /* Debug functions */
-static inline void debug_rt_mutex_unlock(struct rt_mutex *lock)
+static inline void debug_rt_mutex_unlock(struct rt_mutex_base *lock)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
 		DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current);
 }
 
-static inline void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock)
+static inline void debug_rt_mutex_proxy_unlock(struct rt_mutex_base *lock)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
 		DEBUG_LOCKS_WARN_ON(!rt_mutex_owner(lock));
