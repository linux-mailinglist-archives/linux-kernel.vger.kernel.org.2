Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1E43C741C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhGMQR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54372 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbhGMQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:43 -0400
Message-Id: <20210713160749.452934858@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7I6VpmDqiL4ogQFKmdWfhtocTvEkd8yvIIm5Y9xLVJY=;
        b=w7rQfoFkJk0MGHWb/RlAsy0BTZ38K4Z7n6W3xiRbPlfwa+Hf5Ux6uR/OjdEWkqQsVh0dmp
        OPTrroz8iwvgQedGblt7Qb/8UhiQ65dUJSvKk/OQZJUdFT0Ibtlmk510O8QdOQr5DVqMlg
        dXDLUuOSVTCRV5uq4rlIZR3WgWBvaJZOaC7ZgRWiazmyupTDixd8EYYuyACyy9mqFJYuJQ
        HbRCAMuLjyLBE2H6TkCyGH7DnXKIljFHKyMP+wa32JNijIHDE4XK4btIMcMxuxlOV342ec
        QOtpoQAf10c2ENsGDEKRZXBamiiZmjc4dbGchrUU6Ip+Exg6zMo9CwRkwxiodA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7I6VpmDqiL4ogQFKmdWfhtocTvEkd8yvIIm5Y9xLVJY=;
        b=3fj7dGW0eOQEHcDigus4hEOK7rZLgU9JBAXhfKzMTecTGtaO/t0NEuFqUUAJudszqOp0xC
        Y7ET8/+a3JuJIPDA==
Date:   Tue, 13 Jul 2021 17:11:30 +0200
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
Subject: [patch 36/50] locking/mutex: Replace struct mutex in core code
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

PREEMPT_RT replaces 'struct mutex' with a rtmutex based variant so all
mutex operations are included into the priority inheritance scheme, but
wants to utilize the ww_mutex specific part of the regular mutex
implementation as is.

As the regular mutex and ww_mutex implementation are tightly coupled
(ww_mutex has a 'struct mutex' inside) and share a lot of code (ww_mutex is
mostly an extension) a simple replacement of 'struct mutex' does not work.

'struct mutex' has a typedef '_mutex_t' associated. Replace all 'struct
mutex' references in the mutex code code with '_mutex_t' which allows to
have a RT specific 'struct mutex' in the final step.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/mutex-debug.c |   12 ++++-----
 kernel/locking/mutex.c       |   52 +++++++++++++++++++++----------------------
 kernel/locking/mutex.h       |   14 +++++------
 3 files changed, 39 insertions(+), 39 deletions(-)
---
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -25,14 +25,14 @@
 /*
  * Must be called with lock->wait_lock held.
  */
-void debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
+void debug_mutex_lock_common(_mutex_t *lock, struct mutex_waiter *waiter)
 {
 	memset(waiter, MUTEX_DEBUG_INIT, sizeof(*waiter));
 	waiter->magic = waiter;
 	INIT_LIST_HEAD(&waiter->list);
 }
 
-void debug_mutex_wake_waiter(struct mutex *lock, struct mutex_waiter *waiter)
+void debug_mutex_wake_waiter(_mutex_t *lock, struct mutex_waiter *waiter)
 {
 	lockdep_assert_held(&lock->wait_lock);
 	DEBUG_LOCKS_WARN_ON(list_empty(&lock->wait_list));
@@ -46,7 +46,7 @@ void debug_mutex_free_waiter(struct mute
 	memset(waiter, MUTEX_DEBUG_FREE, sizeof(*waiter));
 }
 
-void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+void debug_mutex_add_waiter(_mutex_t *lock, struct mutex_waiter *waiter,
 			    struct task_struct *task)
 {
 	lockdep_assert_held(&lock->wait_lock);
@@ -55,7 +55,7 @@ void debug_mutex_add_waiter(struct mutex
 	task->blocked_on = waiter;
 }
 
-void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+void debug_mutex_remove_waiter(_mutex_t *lock, struct mutex_waiter *waiter,
 			 struct task_struct *task)
 {
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
@@ -67,7 +67,7 @@ void debug_mutex_remove_waiter(struct mu
 	waiter->task = NULL;
 }
 
-void debug_mutex_unlock(struct mutex *lock)
+void debug_mutex_unlock(_mutex_t *lock)
 {
 	if (likely(debug_locks)) {
 		DEBUG_LOCKS_WARN_ON(lock->magic != lock);
@@ -75,7 +75,7 @@ void debug_mutex_unlock(struct mutex *lo
 	}
 }
 
-void debug_mutex_init(struct mutex *lock, const char *name,
+void debug_mutex_init(_mutex_t *lock, const char *name,
 		      struct lock_class_key *key)
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -66,7 +66,7 @@ EXPORT_SYMBOL(__mutex_t_init);
  *
  * DO NOT USE (outside of mutex code).
  */
-static inline struct task_struct *__mutex_owner(struct mutex *lock)
+static inline struct task_struct *__mutex_owner(_mutex_t *lock)
 {
 	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
 }
@@ -90,7 +90,7 @@ static inline unsigned long __owner_flag
 /*
  * Trylock variant that returns the owning task on failure.
  */
-static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
+static inline struct task_struct *__mutex_trylock_or_owner(_mutex_t *lock)
 {
 	unsigned long owner, curr = (unsigned long)current;
 
@@ -133,7 +133,7 @@ static inline struct task_struct *__mute
 /*
  * Actual trylock that will work on any unlocked state.
  */
-static inline bool __mutex_trylock(struct mutex *lock)
+static inline bool __mutex_trylock(_mutex_t *lock)
 {
 	return !__mutex_trylock_or_owner(lock);
 }
@@ -149,7 +149,7 @@ static inline bool __mutex_trylock(struc
  * Optimistic trylock that only works in the uncontended case. Make sure to
  * follow with a __mutex_trylock() before failing.
  */
-static __always_inline bool __mutex_trylock_fast(struct mutex *lock)
+static __always_inline bool __mutex_trylock_fast(_mutex_t *lock)
 {
 	unsigned long curr = (unsigned long)current;
 	unsigned long zero = 0UL;
@@ -160,7 +160,7 @@ static __always_inline bool __mutex_tryl
 	return false;
 }
 
-static __always_inline bool __mutex_unlock_fast(struct mutex *lock)
+static __always_inline bool __mutex_unlock_fast(_mutex_t *lock)
 {
 	unsigned long curr = (unsigned long)current;
 
@@ -171,17 +171,17 @@ static __always_inline bool __mutex_unlo
 }
 #endif
 
-static inline void __mutex_set_flag(struct mutex *lock, unsigned long flag)
+static inline void __mutex_set_flag(_mutex_t *lock, unsigned long flag)
 {
 	atomic_long_or(flag, &lock->owner);
 }
 
-static inline void __mutex_clear_flag(struct mutex *lock, unsigned long flag)
+static inline void __mutex_clear_flag(_mutex_t *lock, unsigned long flag)
 {
 	atomic_long_andnot(flag, &lock->owner);
 }
 
-static inline bool __mutex_waiter_is_first(struct mutex *lock, struct mutex_waiter *waiter)
+static inline bool __mutex_waiter_is_first(_mutex_t *lock, struct mutex_waiter *waiter)
 {
 	return list_first_entry(&lock->wait_list, struct mutex_waiter, list) == waiter;
 }
@@ -191,7 +191,7 @@ static inline bool __mutex_waiter_is_fir
  * FLAG_WAITERS flag if it's the first waiter.
  */
 static void
-__mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+__mutex_add_waiter(_mutex_t *lock, struct mutex_waiter *waiter,
 		   struct list_head *list)
 {
 	debug_mutex_add_waiter(lock, waiter, current);
@@ -202,7 +202,7 @@ static void
 }
 
 static void
-__mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
+__mutex_remove_waiter(_mutex_t *lock, struct mutex_waiter *waiter)
 {
 	list_del(&waiter->list);
 	if (likely(list_empty(&lock->wait_list)))
@@ -217,7 +217,7 @@ static void
  * WAITERS. Provides RELEASE semantics like a regular unlock, the
  * __mutex_trylock() provides a matching ACQUIRE semantics for the handoff.
  */
-static void __mutex_handoff(struct mutex *lock, struct task_struct *task)
+static void __mutex_handoff(_mutex_t *lock, struct task_struct *task)
 {
 	unsigned long owner = atomic_long_read(&lock->owner);
 
@@ -360,7 +360,7 @@ static inline bool __sched
  * __ww_mutex_check_kill() wake any but the earliest context.
  */
 static bool __sched
-__ww_mutex_die(struct mutex *lock, struct mutex_waiter *waiter,
+__ww_mutex_die(_mutex_t *lock, struct mutex_waiter *waiter,
 	       struct ww_acquire_ctx *ww_ctx)
 {
 	if (!ww_ctx->is_wait_die)
@@ -382,7 +382,7 @@ static bool __sched
  * the lock holders. Even if multiple waiters may wound the lock holder,
  * it's sufficient that only one does.
  */
-static bool __ww_mutex_wound(struct mutex *lock,
+static bool __ww_mutex_wound(_mutex_t *lock,
 			     struct ww_acquire_ctx *ww_ctx,
 			     struct ww_acquire_ctx *hold_ctx)
 {
@@ -437,7 +437,7 @@ static bool __ww_mutex_wound(struct mute
  * The current task must not be on the wait list.
  */
 static void __sched
-__ww_mutex_check_waiters(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
+__ww_mutex_check_waiters(_mutex_t *lock, struct ww_acquire_ctx *ww_ctx)
 {
 	struct mutex_waiter *cur;
 
@@ -495,7 +495,7 @@ ww_mutex_set_context_fastpath(struct ww_
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 
 static inline
-bool ww_mutex_spin_on_owner(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
+bool ww_mutex_spin_on_owner(_mutex_t *lock, struct ww_acquire_ctx *ww_ctx,
 			    struct mutex_waiter *waiter)
 {
 	struct ww_mutex *ww;
@@ -543,7 +543,7 @@ bool ww_mutex_spin_on_owner(struct mutex
  * "noinline" so that this function shows up on perf profiles.
  */
 static noinline
-bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
+bool mutex_spin_on_owner(_mutex_t *lock, struct task_struct *owner,
 			 struct ww_acquire_ctx *ww_ctx, struct mutex_waiter *waiter)
 {
 	bool ret = true;
@@ -582,7 +582,7 @@ bool mutex_spin_on_owner(struct mutex *l
 /*
  * Initial check for entering the mutex spinning loop
  */
-static inline int mutex_can_spin_on_owner(struct mutex *lock)
+static inline int mutex_can_spin_on_owner(_mutex_t *lock)
 {
 	struct task_struct *owner;
 	int retval = 1;
@@ -631,7 +631,7 @@ static inline int mutex_can_spin_on_owne
  * changed to itself.
  */
 static __always_inline bool
-mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
+mutex_optimistic_spin(_mutex_t *lock, struct ww_acquire_ctx *ww_ctx,
 		      struct mutex_waiter *waiter)
 {
 	if (!waiter) {
@@ -707,14 +707,14 @@ mutex_optimistic_spin(struct mutex *lock
 }
 #else
 static __always_inline bool
-mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
+mutex_optimistic_spin(_mutex_t *lock, struct ww_acquire_ctx *ww_ctx,
 		      struct mutex_waiter *waiter)
 {
 	return false;
 }
 #endif
 
-static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigned long ip);
+static noinline void __sched __mutex_unlock_slowpath(_mutex_t *lock, unsigned long ip);
 
 /**
  * mutex_unlock - release the mutex
@@ -769,7 +769,7 @@ EXPORT_SYMBOL(ww_mutex_unlock);
 
 
 static __always_inline int __sched
-__ww_mutex_kill(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
+__ww_mutex_kill(_mutex_t *lock, struct ww_acquire_ctx *ww_ctx)
 {
 	if (ww_ctx->acquired > 0) {
 #ifdef CONFIG_DEBUG_MUTEXES
@@ -798,7 +798,7 @@ static __always_inline int __sched
  * look at waiters before us in the wait-list.
  */
 static inline int __sched
-__ww_mutex_check_kill(struct mutex *lock, struct mutex_waiter *waiter,
+__ww_mutex_check_kill(_mutex_t *lock, struct mutex_waiter *waiter,
 		      struct ww_acquire_ctx *ctx)
 {
 	struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
@@ -846,7 +846,7 @@ static inline int __sched
  */
 static inline int __sched
 __ww_mutex_add_waiter(struct mutex_waiter *waiter,
-		      struct mutex *lock,
+		      _mutex_t *lock,
 		      struct ww_acquire_ctx *ww_ctx)
 {
 	struct mutex_waiter *cur;
@@ -919,7 +919,7 @@ static inline int __sched
  * Lock a mutex (possibly interruptible), slowpath:
  */
 static __always_inline int __sched
-__mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclass,
+__mutex_lock_common(_mutex_t *lock, unsigned int state, unsigned int subclass,
 		    struct lockdep_map *nest_lock, unsigned long ip,
 		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
 {
@@ -1101,7 +1101,7 @@ static int __sched
 }
 
 static int __sched
-__ww_mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
+__ww_mutex_lock(_mutex_t *lock, unsigned int state, unsigned int subclass,
 		struct lockdep_map *nest_lock, unsigned long ip,
 		struct ww_acquire_ctx *ww_ctx)
 {
@@ -1216,7 +1216,7 @@ EXPORT_SYMBOL_GPL(ww_mutex_lock_interrup
 /*
  * Release the lock, slowpath:
  */
-static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigned long ip)
+static noinline void __sched __mutex_unlock_slowpath(_mutex_t *lock, unsigned long ip)
 {
 	struct task_struct *next = NULL;
 	DEFINE_WAKE_Q(wake_q);
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -21,18 +21,18 @@ struct mutex_waiter {
 };
 
 #ifdef CONFIG_DEBUG_MUTEXES
-extern void debug_mutex_lock_common(struct mutex *lock,
+extern void debug_mutex_lock_common(_mutex_t *lock,
 				    struct mutex_waiter *waiter);
-extern void debug_mutex_wake_waiter(struct mutex *lock,
+extern void debug_mutex_wake_waiter(_mutex_t *lock,
 				    struct mutex_waiter *waiter);
 extern void debug_mutex_free_waiter(struct mutex_waiter *waiter);
-extern void debug_mutex_add_waiter(struct mutex *lock,
+extern void debug_mutex_add_waiter(_mutex_t *lock,
 				   struct mutex_waiter *waiter,
 				   struct task_struct *task);
-extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+extern void debug_mutex_remove_waiter(_mutex_t *lock, struct mutex_waiter *waiter,
 				      struct task_struct *task);
-extern void debug_mutex_unlock(struct mutex *lock);
-extern void debug_mutex_init(struct mutex *lock, const char *name,
+extern void debug_mutex_unlock(_mutex_t *lock);
+extern void debug_mutex_init(_mutex_t *lock, const char *name,
 			     struct lock_class_key *key);
 #else /* CONFIG_DEBUG_MUTEXES */
 
@@ -44,7 +44,7 @@ extern void debug_mutex_init(struct mute
 #define debug_mutex_init(lock, name, key)		do { } while (0)
 
 static inline void
-debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
+debug_mutex_lock_common(_mutex_t *lock, struct mutex_waiter *waiter)
 {
 }
 #endif /* !CONFIG_DEBUG_MUTEXES */

