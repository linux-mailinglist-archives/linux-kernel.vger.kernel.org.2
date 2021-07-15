Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE8F3CA488
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhGORfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbhGORfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:35:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B733C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 10:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nm33CutapPw8lNVhoUuk/NVOXhhOE5GJ5qYHc/Ewmts=; b=K911H6E0aDmvUGNNcZh1J6ctE5
        ULkyqYym/nJxNQAmbtVfL/ZJ3tbHqerng31e3+cobbvRXsIN0Om9IWg6X9rIOTseSL9/xl5nISbrP
        72M6Iq3FIjnx6c06/UN0YOlnyy9e3WzvzF28UcHElxkVwMfugI++k4hDfGueQdxLHi4Lp7UQJHmek
        8qcex36zm5MO+52DKcpu0k8ZbciHYX1sOPYgU9r0WWRzJptA4uzZvzSzTM6PRPkQ7flxnDRHJYZRn
        2BiUjEl/0Qw4MSv96EdRs0lMsIlE8/EEXw/f/62E+7fchdgyzFnTo1Bue5I+xWG39LyYpIEhgDtri
        7XTf0OEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m45D8-000Bbc-P2; Thu, 15 Jul 2021 17:31:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B62D9869EF; Thu, 15 Jul 2021 19:31:45 +0200 (CEST)
Date:   Thu, 15 Jul 2021 19:31:45 +0200
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
        Davidlohr Bueso <dave@stgolabs.net>, thellstrom@vmware.com,
        dev@mblankhorst.nl, chris@chris-wilson.co.uk
Subject: Re: [patch 33/50] locking/mutex: Introduce _mutex_t
Message-ID: <20210715173145.GC4717@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de>
 <20210713160749.161666350@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713160749.161666350@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 05:11:27PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> PREEMPT_RT replaces 'struct mutex' with a rtmutex based variant so all
> mutex operations are included into the priority inheritance scheme.
> 
> But a complete replacement of the mutex implementation would require to
> reimplement ww_mutex on top of the rtmutex based variant. That has been
> tried, but the outcome was suboptimal.
> 
> As ww_mutex is mostly used in DRM and the code pathes are not really
> relevant to typical RT applications, it's also hard to argue for a full
> reimplementation which can't even share code with the regular ww_mutex code
> adding the risk of diversion and different bugs in both code bases.
> 
> The alternative solution is to make it possible to compile the ww_mutex
> specific part of the regular mutex implementation as is on RT and have a
> rtmutex based 'struct mutex' variant.
> 
> As the regular mutex and ww_mutex implementation are tightly coupled
> (ww_mutex has a 'struct mutex' inside) and share a lot of code (ww_mutex is
> mostly an extension) a simple replacement of 'struct mutex' does not work.
> 
> To solve this attach a typedef to 'struct mutex': _mutex_t

I couldn't let go of this, sorry... the below compiles and might even
work.

I'll try and complete it tomorrow and add copy of the ww_mutex selftest
for ww_rt_mutex to see what it does.

(it includes a bunch of the cleanup/prep patches from this series)

---
 include/linux/mutex.h           |  26 +-
 include/linux/ww_mutex.h        |  35 ++-
 kernel/locking/mutex-debug.c    |   5 +-
 kernel/locking/mutex-debug.h    |  29 ---
 kernel/locking/mutex.c          | 423 ++-----------------------------
 kernel/locking/mutex.h          |  33 ++-
 kernel/locking/rtmutex.c        |  81 +++++-
 kernel/locking/rtmutex_common.h |   5 +-
 kernel/locking/ww_mutex.h       | 544 ++++++++++++++++++++++++++++++++++++++++
 9 files changed, 703 insertions(+), 478 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index e19323521f9c..52476efc9b04 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -20,9 +20,6 @@
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
 
-struct ww_class;
-struct ww_acquire_ctx;
-
 /*
  * Simple, straightforward mutexes with strict semantics:
  *
@@ -53,7 +50,7 @@ struct ww_acquire_ctx;
  */
 struct mutex {
 	atomic_long_t		owner;
-	spinlock_t		wait_lock;
+	raw_spinlock_t		wait_lock;
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 	struct optimistic_spin_queue osq; /* Spinner MCS lock */
 #endif
@@ -66,27 +63,6 @@ struct mutex {
 #endif
 };
 
-struct ww_mutex {
-	struct mutex base;
-	struct ww_acquire_ctx *ctx;
-#ifdef CONFIG_DEBUG_MUTEXES
-	struct ww_class *ww_class;
-#endif
-};
-
-/*
- * This is the control structure for tasks blocked on mutex,
- * which resides on the blocked task's kernel stack:
- */
-struct mutex_waiter {
-	struct list_head	list;
-	struct task_struct	*task;
-	struct ww_acquire_ctx	*ww_ctx;
-#ifdef CONFIG_DEBUG_MUTEXES
-	void			*magic;
-#endif
-};
-
 #ifdef CONFIG_DEBUG_MUTEXES
 
 #define __DEBUG_MUTEX_INITIALIZER(lockname)				\
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index b77f39f319ad..7fcf00bd177c 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -18,6 +18,11 @@
 #define __LINUX_WW_MUTEX_H
 
 #include <linux/mutex.h>
+#include <linux/rtmutex.h>
+
+#if defined(CONFIG_DEBUG_MUTEXES) || defined(CONFIG_DEBUG_RT_MUTEXES)
+#define DEBUG_WW_MUTEXES
+#endif
 
 struct ww_class {
 	atomic_long_t stamp;
@@ -28,13 +33,29 @@ struct ww_class {
 	unsigned int is_wait_die;
 };
 
+struct ww_mutex {
+	struct mutex base;
+	struct ww_acquire_ctx *ctx;
+#ifdef DEBUG_WW_MUTEXES
+	struct ww_class *ww_class;
+#endif
+};
+
+struct ww_rt_mutex {
+	struct rt_mutex base;
+	struct ww_acquire_ctx *ctx;
+#ifdef DEBUG_WW_MUTEXES
+	struct ww_class *ww_class;
+#endif
+};
+
 struct ww_acquire_ctx {
 	struct task_struct *task;
 	unsigned long stamp;
 	unsigned int acquired;
 	unsigned short wounded;
 	unsigned short is_wait_die;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	unsigned int done_acquire;
 	struct ww_class *ww_class;
 	struct ww_mutex *contending_lock;
@@ -76,7 +97,7 @@ static inline void ww_mutex_init(struct ww_mutex *lock,
 {
 	__mutex_init(&lock->base, ww_class->mutex_name, &ww_class->mutex_key);
 	lock->ctx = NULL;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	lock->ww_class = ww_class;
 #endif
 }
@@ -113,7 +134,7 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
 	ctx->acquired = 0;
 	ctx->wounded = false;
 	ctx->is_wait_die = ww_class->is_wait_die;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	ctx->ww_class = ww_class;
 	ctx->done_acquire = 0;
 	ctx->contending_lock = NULL;
@@ -143,7 +164,7 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
  */
 static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
 {
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	lockdep_assert_held(ctx);
 
 	DEBUG_LOCKS_WARN_ON(ctx->done_acquire);
@@ -163,7 +184,7 @@ static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	mutex_release(&ctx->dep_map, _THIS_IP_);
 #endif
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	DEBUG_LOCKS_WARN_ON(ctx->acquired);
 	if (!IS_ENABLED(CONFIG_PROVE_LOCKING))
 		/*
@@ -269,7 +290,7 @@ static inline void
 ww_mutex_lock_slow(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
 	int ret;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	DEBUG_LOCKS_WARN_ON(!ctx->contending_lock);
 #endif
 	ret = ww_mutex_lock(lock, ctx);
@@ -305,7 +326,7 @@ static inline int __must_check
 ww_mutex_lock_slow_interruptible(struct ww_mutex *lock,
 				 struct ww_acquire_ctx *ctx)
 {
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	DEBUG_LOCKS_WARN_ON(!ctx->contending_lock);
 #endif
 	return ww_mutex_lock_interruptible(lock, ctx);
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index db9301591e3f..30dc4faba524 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -1,6 +1,4 @@
 /*
- * kernel/mutex-debug.c
- *
  * Debugging code for mutexes
  *
  * Started by Ingo Molnar:
@@ -22,7 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/debug_locks.h>
 
-#include "mutex-debug.h"
+#include "mutex.h"
 
 /*
  * Must be called with lock->wait_lock held.
@@ -32,6 +30,7 @@ void debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
 	memset(waiter, MUTEX_DEBUG_INIT, sizeof(*waiter));
 	waiter->magic = waiter;
 	INIT_LIST_HEAD(&waiter->list);
+	waiter.ww_ctx = MUTEX_POISON_WW_CTX;
 }
 
 void debug_mutex_wake_waiter(struct mutex *lock, struct mutex_waiter *waiter)
diff --git a/kernel/locking/mutex-debug.h b/kernel/locking/mutex-debug.h
deleted file mode 100644
index 53e631e1d76d..000000000000
--- a/kernel/locking/mutex-debug.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Mutexes: blocking mutual exclusion locks
- *
- * started by Ingo Molnar:
- *
- *  Copyright (C) 2004, 2005, 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
- *
- * This file contains mutex debugging related internal declarations,
- * prototypes and inline functions, for the CONFIG_DEBUG_MUTEXES case.
- * More details are in kernel/mutex-debug.c.
- */
-
-/*
- * This must be called with lock->wait_lock held.
- */
-extern void debug_mutex_lock_common(struct mutex *lock,
-				    struct mutex_waiter *waiter);
-extern void debug_mutex_wake_waiter(struct mutex *lock,
-				    struct mutex_waiter *waiter);
-extern void debug_mutex_free_waiter(struct mutex_waiter *waiter);
-extern void debug_mutex_add_waiter(struct mutex *lock,
-				   struct mutex_waiter *waiter,
-				   struct task_struct *task);
-extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
-				struct task_struct *task);
-extern void debug_mutex_unlock(struct mutex *lock);
-extern void debug_mutex_init(struct mutex *lock, const char *name,
-			     struct lock_class_key *key);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index d2df5e68b503..4d50b7b774d8 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -30,17 +30,13 @@
 #include <linux/debug_locks.h>
 #include <linux/osq_lock.h>
 
-#ifdef CONFIG_DEBUG_MUTEXES
-# include "mutex-debug.h"
-#else
-# include "mutex.h"
-#endif
+#include "mutex.h"
 
 void
 __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
 {
 	atomic_long_set(&lock->owner, 0);
-	spin_lock_init(&lock->wait_lock);
+	raw_spin_lock_init(&lock->wait_lock);
 	INIT_LIST_HEAD(&lock->wait_list);
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 	osq_lock_init(&lock->osq);
@@ -286,215 +282,7 @@ void __sched mutex_lock(struct mutex *lock)
 EXPORT_SYMBOL(mutex_lock);
 #endif
 
-/*
- * Wait-Die:
- *   The newer transactions are killed when:
- *     It (the new transaction) makes a request for a lock being held
- *     by an older transaction.
- *
- * Wound-Wait:
- *   The newer transactions are wounded when:
- *     An older transaction makes a request for a lock being held by
- *     the newer transaction.
- */
-
-/*
- * Associate the ww_mutex @ww with the context @ww_ctx under which we acquired
- * it.
- */
-static __always_inline void
-ww_mutex_lock_acquired(struct ww_mutex *ww, struct ww_acquire_ctx *ww_ctx)
-{
-#ifdef CONFIG_DEBUG_MUTEXES
-	/*
-	 * If this WARN_ON triggers, you used ww_mutex_lock to acquire,
-	 * but released with a normal mutex_unlock in this call.
-	 *
-	 * This should never happen, always use ww_mutex_unlock.
-	 */
-	DEBUG_LOCKS_WARN_ON(ww->ctx);
-
-	/*
-	 * Not quite done after calling ww_acquire_done() ?
-	 */
-	DEBUG_LOCKS_WARN_ON(ww_ctx->done_acquire);
-
-	if (ww_ctx->contending_lock) {
-		/*
-		 * After -EDEADLK you tried to
-		 * acquire a different ww_mutex? Bad!
-		 */
-		DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock != ww);
-
-		/*
-		 * You called ww_mutex_lock after receiving -EDEADLK,
-		 * but 'forgot' to unlock everything else first?
-		 */
-		DEBUG_LOCKS_WARN_ON(ww_ctx->acquired > 0);
-		ww_ctx->contending_lock = NULL;
-	}
-
-	/*
-	 * Naughty, using a different class will lead to undefined behavior!
-	 */
-	DEBUG_LOCKS_WARN_ON(ww_ctx->ww_class != ww->ww_class);
-#endif
-	ww_ctx->acquired++;
-	ww->ctx = ww_ctx;
-}
-
-/*
- * Determine if context @a is 'after' context @b. IOW, @a is a younger
- * transaction than @b and depending on algorithm either needs to wait for
- * @b or die.
- */
-static inline bool __sched
-__ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
-{
-
-	return (signed long)(a->stamp - b->stamp) > 0;
-}
-
-/*
- * Wait-Die; wake a younger waiter context (when locks held) such that it can
- * die.
- *
- * Among waiters with context, only the first one can have other locks acquired
- * already (ctx->acquired > 0), because __ww_mutex_add_waiter() and
- * __ww_mutex_check_kill() wake any but the earliest context.
- */
-static bool __sched
-__ww_mutex_die(struct mutex *lock, struct mutex_waiter *waiter,
-	       struct ww_acquire_ctx *ww_ctx)
-{
-	if (!ww_ctx->is_wait_die)
-		return false;
-
-	if (waiter->ww_ctx->acquired > 0 &&
-			__ww_ctx_stamp_after(waiter->ww_ctx, ww_ctx)) {
-		debug_mutex_wake_waiter(lock, waiter);
-		wake_up_process(waiter->task);
-	}
-
-	return true;
-}
-
-/*
- * Wound-Wait; wound a younger @hold_ctx if it holds the lock.
- *
- * Wound the lock holder if there are waiters with older transactions than
- * the lock holders. Even if multiple waiters may wound the lock holder,
- * it's sufficient that only one does.
- */
-static bool __ww_mutex_wound(struct mutex *lock,
-			     struct ww_acquire_ctx *ww_ctx,
-			     struct ww_acquire_ctx *hold_ctx)
-{
-	struct task_struct *owner = __mutex_owner(lock);
-
-	lockdep_assert_held(&lock->wait_lock);
-
-	/*
-	 * Possible through __ww_mutex_add_waiter() when we race with
-	 * ww_mutex_set_context_fastpath(). In that case we'll get here again
-	 * through __ww_mutex_check_waiters().
-	 */
-	if (!hold_ctx)
-		return false;
-
-	/*
-	 * Can have !owner because of __mutex_unlock_slowpath(), but if owner,
-	 * it cannot go away because we'll have FLAG_WAITERS set and hold
-	 * wait_lock.
-	 */
-	if (!owner)
-		return false;
-
-	if (ww_ctx->acquired > 0 && __ww_ctx_stamp_after(hold_ctx, ww_ctx)) {
-		hold_ctx->wounded = 1;
-
-		/*
-		 * wake_up_process() paired with set_current_state()
-		 * inserts sufficient barriers to make sure @owner either sees
-		 * it's wounded in __ww_mutex_check_kill() or has a
-		 * wakeup pending to re-read the wounded state.
-		 */
-		if (owner != current)
-			wake_up_process(owner);
-
-		return true;
-	}
-
-	return false;
-}
-
-/*
- * We just acquired @lock under @ww_ctx, if there are later contexts waiting
- * behind us on the wait-list, check if they need to die, or wound us.
- *
- * See __ww_mutex_add_waiter() for the list-order construction; basically the
- * list is ordered by stamp, smallest (oldest) first.
- *
- * This relies on never mixing wait-die/wound-wait on the same wait-list;
- * which is currently ensured by that being a ww_class property.
- *
- * The current task must not be on the wait list.
- */
-static void __sched
-__ww_mutex_check_waiters(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
-{
-	struct mutex_waiter *cur;
-
-	lockdep_assert_held(&lock->wait_lock);
-
-	list_for_each_entry(cur, &lock->wait_list, list) {
-		if (!cur->ww_ctx)
-			continue;
-
-		if (__ww_mutex_die(lock, cur, ww_ctx) ||
-		    __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx))
-			break;
-	}
-}
-
-/*
- * After acquiring lock with fastpath, where we do not hold wait_lock, set ctx
- * and wake up any waiters so they can recheck.
- */
-static __always_inline void
-ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
-{
-	ww_mutex_lock_acquired(lock, ctx);
-
-	/*
-	 * The lock->ctx update should be visible on all cores before
-	 * the WAITERS check is done, otherwise contended waiters might be
-	 * missed. The contended waiters will either see ww_ctx == NULL
-	 * and keep spinning, or it will acquire wait_lock, add itself
-	 * to waiter list and sleep.
-	 */
-	smp_mb(); /* See comments above and below. */
-
-	/*
-	 * [W] ww->ctx = ctx	    [W] MUTEX_FLAG_WAITERS
-	 *     MB		        MB
-	 * [R] MUTEX_FLAG_WAITERS   [R] ww->ctx
-	 *
-	 * The memory barrier above pairs with the memory barrier in
-	 * __ww_mutex_add_waiter() and makes sure we either observe ww->ctx
-	 * and/or !empty list.
-	 */
-	if (likely(!(atomic_long_read(&lock->base.owner) & MUTEX_FLAG_WAITERS)))
-		return;
-
-	/*
-	 * Uh oh, we raced in fastpath, check if any of the waiters need to
-	 * die or wound us.
-	 */
-	spin_lock(&lock->base.wait_lock);
-	__ww_mutex_check_waiters(&lock->base, ctx);
-	spin_unlock(&lock->base.wait_lock);
-}
+#include "ww_mutex.h"
 
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 
@@ -752,173 +540,13 @@ EXPORT_SYMBOL(mutex_unlock);
  * This function must not be used in interrupt context. Unlocking
  * of a unlocked mutex is not allowed.
  */
-void __sched ww_mutex_unlock(struct ww_mutex *lock)
+void ww_mutex_unlock(struct WW_MUTEX *lock)
 {
-	/*
-	 * The unlocking fastpath is the 0->1 transition from 'locked'
-	 * into 'unlocked' state:
-	 */
-	if (lock->ctx) {
-#ifdef CONFIG_DEBUG_MUTEXES
-		DEBUG_LOCKS_WARN_ON(!lock->ctx->acquired);
-#endif
-		if (lock->ctx->acquired > 0)
-			lock->ctx->acquired--;
-		lock->ctx = NULL;
-	}
-
+	__ww_mutex_unlock(lock);
 	mutex_unlock(&lock->base);
 }
 EXPORT_SYMBOL(ww_mutex_unlock);
 
-
-static __always_inline int __sched
-__ww_mutex_kill(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
-{
-	if (ww_ctx->acquired > 0) {
-#ifdef CONFIG_DEBUG_MUTEXES
-		struct ww_mutex *ww;
-
-		ww = container_of(lock, struct ww_mutex, base);
-		DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock);
-		ww_ctx->contending_lock = ww;
-#endif
-		return -EDEADLK;
-	}
-
-	return 0;
-}
-
-
-/*
- * Check the wound condition for the current lock acquire.
- *
- * Wound-Wait: If we're wounded, kill ourself.
- *
- * Wait-Die: If we're trying to acquire a lock already held by an older
- *           context, kill ourselves.
- *
- * Since __ww_mutex_add_waiter() orders the wait-list on stamp, we only have to
- * look at waiters before us in the wait-list.
- */
-static inline int __sched
-__ww_mutex_check_kill(struct mutex *lock, struct mutex_waiter *waiter,
-		      struct ww_acquire_ctx *ctx)
-{
-	struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
-	struct ww_acquire_ctx *hold_ctx = READ_ONCE(ww->ctx);
-	struct mutex_waiter *cur;
-
-	if (ctx->acquired == 0)
-		return 0;
-
-	if (!ctx->is_wait_die) {
-		if (ctx->wounded)
-			return __ww_mutex_kill(lock, ctx);
-
-		return 0;
-	}
-
-	if (hold_ctx && __ww_ctx_stamp_after(ctx, hold_ctx))
-		return __ww_mutex_kill(lock, ctx);
-
-	/*
-	 * If there is a waiter in front of us that has a context, then its
-	 * stamp is earlier than ours and we must kill ourself.
-	 */
-	cur = waiter;
-	list_for_each_entry_continue_reverse(cur, &lock->wait_list, list) {
-		if (!cur->ww_ctx)
-			continue;
-
-		return __ww_mutex_kill(lock, ctx);
-	}
-
-	return 0;
-}
-
-/*
- * Add @waiter to the wait-list, keep the wait-list ordered by stamp, smallest
- * first. Such that older contexts are preferred to acquire the lock over
- * younger contexts.
- *
- * Waiters without context are interspersed in FIFO order.
- *
- * Furthermore, for Wait-Die kill ourself immediately when possible (there are
- * older contexts already waiting) to avoid unnecessary waiting and for
- * Wound-Wait ensure we wound the owning context when it is younger.
- */
-static inline int __sched
-__ww_mutex_add_waiter(struct mutex_waiter *waiter,
-		      struct mutex *lock,
-		      struct ww_acquire_ctx *ww_ctx)
-{
-	struct mutex_waiter *cur;
-	struct list_head *pos;
-	bool is_wait_die;
-
-	if (!ww_ctx) {
-		__mutex_add_waiter(lock, waiter, &lock->wait_list);
-		return 0;
-	}
-
-	is_wait_die = ww_ctx->is_wait_die;
-
-	/*
-	 * Add the waiter before the first waiter with a higher stamp.
-	 * Waiters without a context are skipped to avoid starving
-	 * them. Wait-Die waiters may die here. Wound-Wait waiters
-	 * never die here, but they are sorted in stamp order and
-	 * may wound the lock holder.
-	 */
-	pos = &lock->wait_list;
-	list_for_each_entry_reverse(cur, &lock->wait_list, list) {
-		if (!cur->ww_ctx)
-			continue;
-
-		if (__ww_ctx_stamp_after(ww_ctx, cur->ww_ctx)) {
-			/*
-			 * Wait-Die: if we find an older context waiting, there
-			 * is no point in queueing behind it, as we'd have to
-			 * die the moment it would acquire the lock.
-			 */
-			if (is_wait_die) {
-				int ret = __ww_mutex_kill(lock, ww_ctx);
-
-				if (ret)
-					return ret;
-			}
-
-			break;
-		}
-
-		pos = &cur->list;
-
-		/* Wait-Die: ensure younger waiters die. */
-		__ww_mutex_die(lock, cur, ww_ctx);
-	}
-
-	__mutex_add_waiter(lock, waiter, pos);
-
-	/*
-	 * Wound-Wait: if we're blocking on a mutex owned by a younger context,
-	 * wound that such that we might proceed.
-	 */
-	if (!is_wait_die) {
-		struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
-
-		/*
-		 * See ww_mutex_set_context_fastpath(). Orders setting
-		 * MUTEX_FLAG_WAITERS vs the ww->ctx load,
-		 * such that either we or the fastpath will wound @ww->ctx.
-		 */
-		smp_mb();
-		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
-	}
-
-	return 0;
-}
-
 /*
  * Lock a mutex (possibly interruptible), slowpath:
  */
@@ -953,6 +581,10 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		 */
 		if (ww_ctx->acquired == 0)
 			ww_ctx->wounded = 0;
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+		nest_lock = &ww_ctx->dep_map;
+#endif
 	}
 
 	preempt_disable();
@@ -968,7 +600,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		return 0;
 	}
 
-	spin_lock(&lock->wait_lock);
+	raw_spin_lock(&lock->wait_lock);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -987,10 +619,6 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		/* add waiting tasks to the end of the waitqueue (FIFO): */
 		__mutex_add_waiter(lock, &waiter, &lock->wait_list);
 
-
-#ifdef CONFIG_DEBUG_MUTEXES
-		waiter.ww_ctx = MUTEX_POISON_WW_CTX;
-#endif
 	} else {
 		/*
 		 * Add in stamp order, waking up waiters that must kill
@@ -999,8 +627,6 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx);
 		if (ret)
 			goto err_early_kill;
-
-		waiter.ww_ctx = ww_ctx;
 	}
 
 	waiter.task = current;
@@ -1032,7 +658,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 				goto err;
 		}
 
-		spin_unlock(&lock->wait_lock);
+		raw_spin_unlock(&lock->wait_lock);
 		schedule_preempt_disabled();
 
 		/*
@@ -1055,9 +681,9 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		    (first && mutex_optimistic_spin(lock, ww_ctx, &waiter)))
 			break;
 
-		spin_lock(&lock->wait_lock);
+		raw_spin_lock(&lock->wait_lock);
 	}
-	spin_lock(&lock->wait_lock);
+	raw_spin_lock(&lock->wait_lock);
 acquired:
 	__set_current_state(TASK_RUNNING);
 
@@ -1082,7 +708,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
-	spin_unlock(&lock->wait_lock);
+	raw_spin_unlock(&lock->wait_lock);
 	preempt_enable();
 	return 0;
 
@@ -1090,7 +716,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
-	spin_unlock(&lock->wait_lock);
+	raw_spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
 	preempt_enable();
@@ -1106,10 +732,9 @@ __mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
 
 static int __sched
 __ww_mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
-		struct lockdep_map *nest_lock, unsigned long ip,
-		struct ww_acquire_ctx *ww_ctx)
+		unsigned long ip, struct ww_acquire_ctx *ww_ctx)
 {
-	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, ww_ctx, true);
+	return __mutex_lock_common(lock, state, subclass, NULL, ip, ww_ctx, true);
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -1189,8 +814,7 @@ ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 
 	might_sleep();
 	ret =  __ww_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE,
-			       0, ctx ? &ctx->dep_map : NULL, _RET_IP_,
-			       ctx);
+			       0, _RET_IP_, ctx);
 	if (!ret && ctx && ctx->acquired > 1)
 		return ww_mutex_deadlock_injection(lock, ctx);
 
@@ -1205,8 +829,7 @@ ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 
 	might_sleep();
 	ret = __ww_mutex_lock(&lock->base, TASK_INTERRUPTIBLE,
-			      0, ctx ? &ctx->dep_map : NULL, _RET_IP_,
-			      ctx);
+			      0, _RET_IP_, ctx);
 
 	if (!ret && ctx && ctx->acquired > 1)
 		return ww_mutex_deadlock_injection(lock, ctx);
@@ -1259,7 +882,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		owner = old;
 	}
 
-	spin_lock(&lock->wait_lock);
+	raw_spin_lock(&lock->wait_lock);
 	debug_mutex_unlock(lock);
 	if (!list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
@@ -1276,7 +899,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
-	spin_unlock(&lock->wait_lock);
+	raw_spin_unlock(&lock->wait_lock);
 
 	wake_up_q(&wake_q);
 }
@@ -1380,7 +1003,7 @@ __mutex_lock_interruptible_slowpath(struct mutex *lock)
 static noinline int __sched
 __ww_mutex_lock_slowpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
-	return __ww_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE, 0, NULL,
+	return __ww_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE, 0,
 			       _RET_IP_, ctx);
 }
 
@@ -1388,7 +1011,7 @@ static noinline int __sched
 __ww_mutex_lock_interruptible_slowpath(struct ww_mutex *lock,
 					    struct ww_acquire_ctx *ctx)
 {
-	return __ww_mutex_lock(&lock->base, TASK_INTERRUPTIBLE, 0, NULL,
+	return __ww_mutex_lock(&lock->base, TASK_INTERRUPTIBLE, 0,
 			       _RET_IP_, ctx);
 }
 
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index f0c710b1d192..8d1b0ee49062 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -5,11 +5,37 @@
  * started by Ingo Molnar:
  *
  *  Copyright (C) 2004, 2005, 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
- *
- * This file contains mutex debugging related internal prototypes, for the
- * !CONFIG_DEBUG_MUTEXES case. Most of them are NOPs:
  */
 
+/*
+ * This is the control structure for tasks blocked on mutex, which resides
+ * on the blocked task's kernel stack:
+ */
+struct mutex_waiter {
+	struct list_head	list;
+	struct task_struct	*task;
+	struct ww_acquire_ctx	*ww_ctx;
+#ifdef CONFIG_DEBUG_MUTEXES
+	void			*magic;
+#endif
+};
+
+#ifdef CONFIG_DEBUG_MUTEXES
+extern void debug_mutex_lock_common(struct mutex *lock,
+				    struct mutex_waiter *waiter);
+extern void debug_mutex_wake_waiter(struct mutex *lock,
+				    struct mutex_waiter *waiter);
+extern void debug_mutex_free_waiter(struct mutex_waiter *waiter);
+extern void debug_mutex_add_waiter(struct mutex *lock,
+				   struct mutex_waiter *waiter,
+				   struct task_struct *task);
+extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+				      struct task_struct *task);
+extern void debug_mutex_unlock(struct mutex *lock);
+extern void debug_mutex_init(struct mutex *lock, const char *name,
+			     struct lock_class_key *key);
+#else /* CONFIG_DEBUG_MUTEXES */
+
 #define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
 #define debug_mutex_free_waiter(waiter)			do { } while (0)
 #define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
@@ -21,3 +47,4 @@ static inline void
 debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
 {
 }
+#endif /* !CONFIG_DEBUG_MUTEXES */
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index b5d9bb5202c6..72b2a31f9af7 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -19,6 +19,7 @@
 #include <linux/sched/wake_q.h>
 #include <linux/sched/debug.h>
 #include <linux/timer.h>
+#include <linux/ww_mutex.h>
 
 #include "rtmutex_common.h"
 
@@ -1125,6 +1126,9 @@ void __sched rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 	waiter->task = NULL;
 }
 
+#define WW_RT
+#include "ww_mutex.h"
+
 /**
  * __rt_mutex_slowlock() - Perform the wait-wake-try-to-take loop
  * @lock:		 the rt_mutex to take
@@ -1136,6 +1140,7 @@ void __sched rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
  * Must be called with lock->wait_lock held and interrupts disabled
  */
 static int __sched __rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state,
+				       struct ww_acquire_ctx *ww_ctx,
 				       struct hrtimer_sleeper *timeout,
 				       struct rt_mutex_waiter *waiter)
 {
@@ -1155,6 +1160,12 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state
 			break;
 		}
 
+		if (ww_ctx) {
+			ret = __ww_mutex_check_kill(lock, waiter, ww_ctx);
+			if (ret)
+				break;
+		}
+
 		raw_spin_unlock_irq(&lock->wait_lock);
 
 		schedule();
@@ -1192,8 +1203,10 @@ static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
  */
 static int __sched rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state,
 				     struct hrtimer_sleeper *timeout,
+				     struct ww_acquire_ctx *ww_ctx,
 				     enum rtmutex_chainwalk chwalk)
 {
+	struct ww_rt_mutex *ww = container_of(lock, struct ww_rt_mutex, base);
 	struct rt_mutex_waiter waiter;
 	unsigned long flags;
 	int ret = 0;
@@ -1212,6 +1225,10 @@ static int __sched rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state,
 
 	/* Try to acquire the lock again: */
 	if (try_to_take_rt_mutex(lock, current, NULL)) {
+		if (ww_ctx) {
+			__ww_mutex_check_waiters(lock, ww_ctx);
+			ww_mutex_lock_acquired(ww, ww_ctx);
+		}
 		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		return 0;
 	}
@@ -1224,11 +1241,25 @@ static int __sched rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state,
 
 	ret = task_blocks_on_rt_mutex(lock, &waiter, current, chwalk);
 
-	if (likely(!ret))
+	if (!ret && ww_ctx) {
+		/* additional W/W fails */
+		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx);
+	}
+
+	if (likely(!ret)) {
 		/* sleep on the mutex */
-		ret = __rt_mutex_slowlock(lock, state, timeout, &waiter);
+		ret = __rt_mutex_slowlock(lock, state, ww_ctx, timeout, &waiter);
+	}
 
-	if (unlikely(ret)) {
+	if (likely(!ret)) {
+		/* acquired the lock */
+		if (ww_ctx) {
+			if (!ww_ctx->is_wait_die)
+			    __ww_mutex_check_waiters(lock, ww_ctx);
+			ww_mutex_lock_acquired(ww, ww_ctx);
+		}
+	} else {
+		/* failed */
 		__set_current_state(TASK_RUNNING);
 		remove_waiter(lock, &waiter);
 		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
@@ -1377,22 +1408,45 @@ static void __sched rt_mutex_slowunlock(struct rt_mutex *lock)
  * architecture does not support cmpxchg or when debugging is enabled.
  */
 static __always_inline int __rt_mutex_lock(struct rt_mutex *lock, long state,
+					   struct ww_acquire_ctx *ww_ctx,
 					   unsigned int subclass)
 {
+	struct ww_rt_mutex *ww = container_of(lock, struct ww_rt_mutex, base);
+	struct lockdep_map *nest_lock __maybe_unused = NULL;
 	int ret;
 
+	if (ww_ctx) {
+		if (unlikely(ww_ctx == READ_ONCE(ww->ctx)))
+			return -EALREADY;
+
+		if (ww_ctx->acquired == 0)
+			ww_ctx->wounded = 0;
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+		nest_lock = &ww_ctx->dep_map;
+#endif
+	}
+
 	might_sleep();
-	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, _RET_IP_);
 
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
+	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current))) {
+		if (ww_ctx)
+			ww_mutex_set_context_fastpath(ww, ww_ctx);
 		return 0;
+	}
 
-	ret = rt_mutex_slowlock(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK);
+	ret = rt_mutex_slowlock(lock, state, NULL, ww_ctx, RT_MUTEX_MIN_CHAINWALK);
 	if (ret)
 		mutex_release(&lock->dep_map, _RET_IP_);
 	return ret;
 }
 
+void ww_rt_mutex_lock(struct ww_rt_mutex *lock, struct ww_acquire_ctx *ww_ctx)
+{
+	__rt_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE, ww_ctx, 0);
+}
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /**
  * rt_mutex_lock_nested - lock a rt_mutex
@@ -1402,7 +1456,7 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex *lock, long state,
  */
 void __sched rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass)
 {
-	__rt_mutex_lock(lock, TASK_UNINTERRUPTIBLE, subclass);
+	__rt_mutex_lock(lock, TASK_UNINTERRUPTIBLE, NULL, subclass);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
 
@@ -1415,7 +1469,7 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
  */
 void __sched rt_mutex_lock(struct rt_mutex *lock)
 {
-	__rt_mutex_lock(lock, TASK_UNINTERRUPTIBLE, 0);
+	__rt_mutex_lock(lock, TASK_UNINTERRUPTIBLE, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock);
 #endif
@@ -1431,7 +1485,7 @@ EXPORT_SYMBOL_GPL(rt_mutex_lock);
  */
 int __sched rt_mutex_lock_interruptible(struct rt_mutex *lock)
 {
-	return __rt_mutex_lock(lock, TASK_INTERRUPTIBLE, 0);
+	return __rt_mutex_lock(lock, TASK_INTERRUPTIBLE, NULL, 0);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible);
 
@@ -1484,6 +1538,13 @@ void __sched rt_mutex_unlock(struct rt_mutex *lock)
 }
 EXPORT_SYMBOL_GPL(rt_mutex_unlock);
 
+void ww_rt_mutex_unlock(struct ww_rt_mutex *lock)
+{
+	__ww_mutex_unlock(lock);
+	rt_mutex_unlock(&lock->base);
+}
+EXPORT_SYMBOL_GPL(ww_rt_mutex_unlock);
+
 /*
  * Futex variants, must not use fastpath.
  */
@@ -1708,7 +1769,7 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
 	raw_spin_lock_irq(&lock->wait_lock);
 	/* sleep on the mutex */
 	set_current_state(TASK_INTERRUPTIBLE);
-	ret = __rt_mutex_slowlock(lock, TASK_INTERRUPTIBLE, to, waiter);
+	ret = __rt_mutex_slowlock(lock, TASK_INTERRUPTIBLE, NULL, to, waiter);
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
 	 * have to fix that up.
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index a90c22abdbca..792ff1227ccb 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -35,6 +35,7 @@ struct rt_mutex_waiter {
 	struct rt_mutex		*lock;
 	int			prio;
 	u64			deadline;
+	struct ww_acquire_ctx	*ww_ctx;
 };
 
 /*
@@ -151,8 +152,10 @@ static inline void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock)
 
 static inline void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 {
-	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES)) {
 		memset(waiter, 0x11, sizeof(*waiter));
+		waiter->ww_ctx = MUTEX_POISON_WW_CTX;
+	}
 }
 
 static inline void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter)
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
new file mode 100644
index 000000000000..a65d844c3735
--- /dev/null
+++ b/kernel/locking/ww_mutex.h
@@ -0,0 +1,544 @@
+
+#ifndef WW_RT
+
+#define WW_MUTEX	ww_mutex
+#define MUTEX		mutex
+#define MUTEX_WAITER	mutex_waiter
+
+static inline struct MUTEX_WAITER *
+__ww_waiter_first(struct MUTEX *lock)
+{
+	struct MUTEX_WAITER *w;
+
+	w = list_first_entry(&lock->wait_list, struct MUTEX_WAITER, list);
+	if (list_entry_is_head(w, &lock->wait_list, list))
+		return NULL;
+
+	return w;
+}
+
+static inline struct MUTEX_WAITER *
+__ww_waiter_next(struct MUTEX *lock, struct MUTEX_WAITER *w)
+{
+	w = list_next_entry(w, list);
+	if (list_entry_is_head(w, &lock->wait_list, list))
+		return NULL;
+
+	return w;
+}
+
+static inline struct MUTEX_WAITER *
+__ww_waiter_prev(struct MUTEX *lock, struct MUTEX_WAITER *w)
+{
+	w = list_prev_entry(w, list);
+	if (list_entry_is_head(w, &lock->wait_list, list))
+		return NULL;
+
+	return w;
+}
+
+static inline struct MUTEX_WAITER *
+__ww_waiter_last(struct MUTEX *lock)
+{
+	struct MUTEX_WAITER *w;
+
+	w = list_last_entry(&lock->wait_list, struct MUTEX_WAITER, list);
+	if (list_entry_is_head(w, &lock->wait_list, list))
+		return NULL;
+
+	return w;
+}
+
+static inline void
+__ww_waiter_add(struct MUTEX *lock, struct MUTEX_WAITER *waiter, struct MUTEX_WAITER *pos)
+{
+	struct list_head *p;
+
+	if (!pos)
+		p = &lock->wait_list;
+	else
+		p = &pos->list;
+
+	__mutex_add_waiter(lock, waiter, p);
+}
+
+static inline struct task_struct *
+__ww_mutex_owner(struct MUTEX *lock)
+{
+	return __mutex_owner(lock);
+}
+
+static inline bool
+__ww_mutex_has_waiters(struct MUTEX *lock)
+{
+	return atomic_long_read(&lock->owner) & MUTEX_FLAG_WAITERS;
+}
+
+#else /* WW_RT */
+
+#define WW_MUTEX	ww_rt_mutex
+#define MUTEX		rt_mutex
+#define MUTEX_WAITER	rt_mutex_waiter
+
+static inline struct MUTEX_WAITER *
+__ww_waiter_first(struct MUTEX *lock)
+{
+	struct rb_node *n = rb_first(&lock->waiters.rb_root);
+	if (!n)
+		return NULL;
+	return rb_entry(n, struct MUTEX_WAITER, tree_entry);
+}
+
+static inline struct MUTEX_WAITER *
+__ww_waiter_next(struct MUTEX *lock, struct MUTEX_WAITER *w)
+{
+	struct rb_node *n = rb_next(&w->tree_entry);
+	if (!n)
+		return NULL;
+	return rb_entry(n, struct MUTEX_WAITER, tree_entry);
+}
+
+static inline struct MUTEX_WAITER *
+__ww_waiter_prev(struct MUTEX *lock, struct MUTEX_WAITER *w)
+{
+	struct rb_node *n = rb_prev(&w->tree_entry);
+	if (!n)
+		return NULL;
+	return rb_entry(n, struct MUTEX_WAITER, tree_entry);
+}
+
+static inline struct MUTEX_WAITER *
+__ww_waiter_last(struct MUTEX *lock)
+{
+	struct rb_node *n = rb_last(&lock->waiters.rb_root);
+	if (!n)
+		return NULL;
+	return rb_entry(n, struct MUTEX_WAITER, tree_entry);
+}
+
+static inline void
+__ww_waiter_add(struct MUTEX *lock, struct MUTEX_WAITER *waiter, struct MUTEX_WAITER *pos)
+{
+	/* RT unconditionally adds the waiter first and then removes it on error */
+}
+
+static inline struct task_struct *
+__ww_mutex_owner(struct MUTEX *lock)
+{
+	return rt_mutex_owner(lock);
+}
+
+static inline bool
+__ww_mutex_has_waiters(struct MUTEX *lock)
+{
+	return rt_mutex_has_waiters(lock);
+}
+
+#endif /* WW_RT */
+
+/*
+ * Wait-Die:
+ *   The newer transactions are killed when:
+ *     It (the new transaction) makes a request for a lock being held
+ *     by an older transaction.
+ *
+ * Wound-Wait:
+ *   The newer transactions are wounded when:
+ *     An older transaction makes a request for a lock being held by
+ *     the newer transaction.
+ */
+
+/*
+ * Associate the ww_mutex @ww with the context @ww_ctx under which we acquired
+ * it.
+ */
+static __always_inline void
+ww_mutex_lock_acquired(struct WW_MUTEX *ww, struct ww_acquire_ctx *ww_ctx)
+{
+#ifdef DEBUG_WW_MUTEXES
+	/*
+	 * If this WARN_ON triggers, you used ww_mutex_lock to acquire,
+	 * but released with a normal mutex_unlock in this call.
+	 *
+	 * This should never happen, always use ww_mutex_unlock.
+	 */
+	DEBUG_LOCKS_WARN_ON(ww->ctx);
+
+	/*
+	 * Not quite done after calling ww_acquire_done() ?
+	 */
+	DEBUG_LOCKS_WARN_ON(ww_ctx->done_acquire);
+
+	if (ww_ctx->contending_lock) {
+		/*
+		 * After -EDEADLK you tried to
+		 * acquire a different ww_mutex? Bad!
+		 */
+		DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock != ww);
+
+		/*
+		 * You called ww_mutex_lock after receiving -EDEADLK,
+		 * but 'forgot' to unlock everything else first?
+		 */
+		DEBUG_LOCKS_WARN_ON(ww_ctx->acquired > 0);
+		ww_ctx->contending_lock = NULL;
+	}
+
+	/*
+	 * Naughty, using a different class will lead to undefined behavior!
+	 */
+	DEBUG_LOCKS_WARN_ON(ww_ctx->ww_class != ww->ww_class);
+#endif
+	ww_ctx->acquired++;
+	ww->ctx = ww_ctx;
+}
+
+/*
+ * Determine if @a is 'less' than @b. IOW, either @a is a lower priority task
+ * or, when of equal priority, a younger transaction than @b.
+ *
+ * Depending on the algorithm, @a will either need to wait for @b, or die.
+ */
+static inline bool
+__ww_ctx_less(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
+{
+/*
+ * Can only do the RT prio for WW_RT because task->prio isn't stable due to PI,
+ * so the wait_list ordering will go wobbly. rt_mutex re-queues the waiter and
+ * isn't affected by this.
+ */
+#ifdef WW_RT
+	/* kernel prio; less is more */
+	int a_prio = a->task->prio;
+	int b_prio = b->task->prio;
+
+	if (dl_prio(a_prio) || dl_prio(b_prio)) {
+
+		if (a_prio > b_prio)
+			return true;
+
+		if (a_prio < b_prio)
+			return false;
+
+		/* equal static prio */
+
+		if (dl_prio(a_prio)) {
+			if (dl_time_before(b->task->dl.deadline,
+					   a->task->dl.deadline))
+				return true;
+
+			if (dl_time_before(a->task->dl.deadline,
+					   b->task->dl.deadline))
+				return false;
+		}
+
+		/* equal prio */
+	}
+#endif /* WW_RT */
+
+	/* FIFO order tie break -- bigger is younger */
+	return (signed long)(a->stamp - b->stamp) > 0;
+}
+
+/*
+ * Wait-Die; wake a lesser waiter context (when locks held) such that it can
+ * die.
+ *
+ * Among waiters with context, only the first one can have other locks acquired
+ * already (ctx->acquired > 0), because __ww_mutex_add_waiter() and
+ * __ww_mutex_check_kill() wake any but the earliest context.
+ */
+static bool
+__ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
+	       struct ww_acquire_ctx *ww_ctx)
+{
+	if (!ww_ctx->is_wait_die)
+		return false;
+
+	if (waiter->ww_ctx->acquired > 0 && __ww_ctx_less(waiter->ww_ctx, ww_ctx)) {
+#ifndef WW_RT
+		debug_mutex_wake_waiter(lock, waiter);
+#endif
+		wake_up_process(waiter->task);
+	}
+
+	return true;
+}
+
+/*
+ * Wound-Wait; wound a lesser @hold_ctx if it holds the lock.
+ *
+ * Wound the lock holder if there are waiters with more important transactions
+ * than the lock holders. Even if multiple waiters may wound the lock holder,
+ * it's sufficient that only one does.
+ */
+static bool __ww_mutex_wound(struct MUTEX *lock,
+			     struct ww_acquire_ctx *ww_ctx,
+			     struct ww_acquire_ctx *hold_ctx)
+{
+	struct task_struct *owner = __ww_mutex_owner(lock);
+
+	lockdep_assert_held(&lock->wait_lock);
+
+	/*
+	 * Possible through __ww_mutex_add_waiter() when we race with
+	 * ww_mutex_set_context_fastpath(). In that case we'll get here again
+	 * through __ww_mutex_check_waiters().
+	 */
+	if (!hold_ctx)
+		return false;
+
+	/*
+	 * Can have !owner because of __mutex_unlock_slowpath(), but if owner,
+	 * it cannot go away because we'll have FLAG_WAITERS set and hold
+	 * wait_lock.
+	 */
+	if (!owner)
+		return false;
+
+	if (ww_ctx->acquired > 0 && __ww_ctx_less(hold_ctx, ww_ctx)) {
+		hold_ctx->wounded = 1;
+
+		/*
+		 * wake_up_process() paired with set_current_state()
+		 * inserts sufficient barriers to make sure @owner either sees
+		 * it's wounded in __ww_mutex_check_kill() or has a
+		 * wakeup pending to re-read the wounded state.
+		 */
+		if (owner != current)
+			wake_up_process(owner);
+
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * We just acquired @lock under @ww_ctx, if there are lesser contexts waiting
+ * behind us on the wait-list, check if they need to die, or wound us.
+ *
+ * See __ww_mutex_add_waiter() for the list-order construction; basically the
+ * list is ordered by stamp, smallest (oldest) first.
+ *
+ * This relies on never mixing wait-die/wound-wait on the same wait-list;
+ * which is currently ensured by that being a ww_class property.
+ *
+ * The current task must not be on the wait list.
+ */
+static void
+__ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
+{
+	struct MUTEX_WAITER *cur;
+
+	lockdep_assert_held(&lock->wait_lock);
+
+	for (cur = __ww_waiter_first(lock); cur;
+	     cur = __ww_waiter_next(lock, cur)) {
+		if (!cur->ww_ctx)
+			continue;
+
+		if (__ww_mutex_die(lock, cur, ww_ctx) ||
+		    __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx))
+			break;
+	}
+}
+
+/*
+ * After acquiring lock with fastpath, where we do not hold wait_lock, set ctx
+ * and wake up any waiters so they can recheck.
+ */
+static __always_inline void
+ww_mutex_set_context_fastpath(struct WW_MUTEX *lock, struct ww_acquire_ctx *ctx)
+{
+	ww_mutex_lock_acquired(lock, ctx);
+
+	/*
+	 * The lock->ctx update should be visible on all cores before
+	 * the WAITERS check is done, otherwise contended waiters might be
+	 * missed. The contended waiters will either see ww_ctx == NULL
+	 * and keep spinning, or it will acquire wait_lock, add itself
+	 * to waiter list and sleep.
+	 */
+	smp_mb(); /* See comments above and below. */
+
+	/*
+	 * [W] ww->ctx = ctx	    [W] MUTEX_FLAG_WAITERS
+	 *     MB		        MB
+	 * [R] MUTEX_FLAG_WAITERS   [R] ww->ctx
+	 *
+	 * The memory barrier above pairs with the memory barrier in
+	 * __ww_mutex_add_waiter() and makes sure we either observe ww->ctx
+	 * and/or !empty list.
+	 */
+	if (likely(!__ww_mutex_has_waiters(&lock->base)))
+		return;
+
+	/*
+	 * Uh oh, we raced in fastpath, check if any of the waiters need to
+	 * die or wound us.
+	 */
+	raw_spin_lock(&lock->base.wait_lock);
+	__ww_mutex_check_waiters(&lock->base, ctx);
+	raw_spin_unlock(&lock->base.wait_lock);
+}
+
+static inline void
+__ww_mutex_unlock(struct WW_MUTEX *lock)
+{
+	if (lock->ctx) {
+#ifdef DEBUG_WW_MUTEXES
+		DEBUG_LOCKS_WARN_ON(!lock->ctx->acquired);
+#endif
+		if (lock->ctx->acquired > 0)
+			lock->ctx->acquired--;
+		lock->ctx = NULL;
+	}
+}
+
+static __always_inline int
+__ww_mutex_kill(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
+{
+	if (ww_ctx->acquired > 0) {
+#ifdef DEBUG_WW_MUTEXES
+		struct WW_MUTEX *ww;
+
+		ww = container_of(lock, struct WW_MUTEX, base);
+		DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock);
+		ww_ctx->contending_lock = ww;
+#endif
+		return -EDEADLK;
+	}
+
+	return 0;
+}
+
+/*
+ * Check the wound condition for the current lock acquire.
+ *
+ * Wound-Wait: If we're wounded, kill ourself.
+ *
+ * Wait-Die: If we're trying to acquire a lock already held by an older
+ *           context, kill ourselves.
+ *
+ * Since __ww_mutex_add_waiter() orders the wait-list on stamp, we only have to
+ * look at waiters before us in the wait-list.
+ */
+static inline int
+__ww_mutex_check_kill(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
+		      struct ww_acquire_ctx *ctx)
+{
+	struct WW_MUTEX *ww = container_of(lock, struct WW_MUTEX, base);
+	struct ww_acquire_ctx *hold_ctx = READ_ONCE(ww->ctx);
+	struct MUTEX_WAITER *cur;
+
+	if (ctx->acquired == 0)
+		return 0;
+
+	if (!ctx->is_wait_die) {
+		if (ctx->wounded)
+			return __ww_mutex_kill(lock, ctx);
+
+		return 0;
+	}
+
+	if (hold_ctx && __ww_ctx_less(ctx, hold_ctx))
+		return __ww_mutex_kill(lock, ctx);
+
+	/*
+	 * If there is a waiter in front of us that has a context, then its
+	 * stamp is earlier than ours and we must kill ourself.
+	 */
+	for (cur = waiter; cur; cur = __ww_waiter_prev(lock, cur)) {
+		if (!cur->ww_ctx)
+			continue;
+
+		return __ww_mutex_kill(lock, ctx);
+	}
+
+	return 0;
+}
+
+/*
+ * Add @waiter to the wait-list, keep the wait-list ordered by stamp, smallest
+ * first. Such that older contexts are preferred to acquire the lock over
+ * younger contexts.
+ *
+ * Waiters without context are interspersed in FIFO order.
+ *
+ * Furthermore, for Wait-Die kill ourself immediately when possible (there are
+ * older contexts already waiting) to avoid unnecessary waiting and for
+ * Wound-Wait ensure we wound the owning context when it is younger.
+ */
+static inline int
+__ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
+		      struct MUTEX *lock,
+		      struct ww_acquire_ctx *ww_ctx)
+{
+	struct MUTEX_WAITER *cur, *pos = NULL;
+	bool is_wait_die;
+
+	if (!ww_ctx) {
+		__ww_waiter_add(lock, waiter, NULL);
+		goto done;
+	}
+
+	is_wait_die = ww_ctx->is_wait_die;
+
+	/*
+	 * Add the waiter before the first waiter with a higher stamp.
+	 * Waiters without a context are skipped to avoid starving
+	 * them. Wait-Die waiters may die here. Wound-Wait waiters
+	 * never die here, but they are sorted in stamp order and
+	 * may wound the lock holder.
+	 */
+	for (cur = __ww_waiter_last(lock); cur;
+	     cur = __ww_waiter_prev(lock, cur)) {
+
+		if (cur == waiter || !cur->ww_ctx)
+			continue;
+
+		if (__ww_ctx_less(ww_ctx, cur->ww_ctx)) {
+			/*
+			 * Wait-Die: if we find an older context waiting, there
+			 * is no point in queueing behind it, as we'd have to
+			 * die the moment it would acquire the lock.
+			 */
+			if (is_wait_die) {
+				int ret = __ww_mutex_kill(lock, ww_ctx);
+				if (ret)
+					return ret;
+			}
+
+			break;
+		}
+
+		pos = cur;
+
+		/* Wait-Die: ensure younger waiters die. */
+		__ww_mutex_die(lock, cur, ww_ctx);
+	}
+
+	__ww_waiter_add(lock, waiter, pos);
+
+	/*
+	 * Wound-Wait: if we're blocking on a mutex owned by a younger context,
+	 * wound that such that we might proceed.
+	 */
+	if (!is_wait_die) {
+		struct WW_MUTEX *ww = container_of(lock, struct WW_MUTEX, base);
+
+		/*
+		 * See ww_mutex_set_context_fastpath(). Orders setting
+		 * MUTEX_FLAG_WAITERS vs the ww->ctx load,
+		 * such that either we or the fastpath will wound @ww->ctx.
+		 */
+		smp_mb();
+		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
+	}
+
+done:
+	waiter->ww_ctx = ww_ctx;
+	return 0;
+}
+
