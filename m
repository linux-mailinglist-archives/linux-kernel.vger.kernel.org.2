Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0023634AC2C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhCZQCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:02:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55838 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhCZQBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:01:36 -0400
Message-Id: <20210326153943.549192485@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616774495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=f2FMtpvjpa7HVmFLI0huAtBqRxNMsqPKkdzWTQhKpHc=;
        b=m2eHJsV4vysFncstkQ0mRE9Z98rGiOVUk/Sahpq+S79iiZPE/M/X3nOxGijXN10S39z7Ub
        45CkVaPPDFjV6VO+eyMdWzAq/Qg5qCaCxv23a+bIs+rGjXhH8CCWyx3dTOHFjqe7PDTrw5
        ebHqIuN/XOC7ohqF2w6/Ef+bZtvTQ9PNMD8vs3ovbI1HprngtfrMasXda5QjKjrxZF4vrv
        fD8/o5ZnAjWxrIaEGtW2gw1ZwiQKXD9SwfNg4Zf9U6pe3gB+0I3eA6qsuDyVzfG0WA0act
        Kr/3fIMY/dsmlF9vJ+csAL8qX8cIAwM6S4V8CFI1VBNAReRzhzi+RF413n70gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616774495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=f2FMtpvjpa7HVmFLI0huAtBqRxNMsqPKkdzWTQhKpHc=;
        b=rBZcTm/waqf/7TLX9hOOi4kedwhx0lI1wOBYgP8RLGwS5mD5yHOOJgn6lp345K7XfRAHsv
        gVIoO9Tuc4TDksCA==
Date:   Fri, 26 Mar 2021 16:29:34 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 05/15] locking/rtmutex: Remove empty and unused debug stubs
References: <20210326152929.709289883@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users or useless and therefore just ballast.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Remove them properly 
---
 include/linux/rtmutex.h        |   14 ++------------
 kernel/locking/rtmutex-debug.c |    9 ---------
 kernel/locking/rtmutex-debug.h |    3 ---
 kernel/locking/rtmutex.c       |   18 ------------------
 kernel/locking/rtmutex.h       |    2 --
 5 files changed, 2 insertions(+), 44 deletions(-)

--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -40,18 +40,9 @@ struct rt_mutex_waiter;
 struct hrtimer_sleeper;
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
- extern int rt_mutex_debug_check_no_locks_freed(const void *from,
-						unsigned long len);
- extern void rt_mutex_debug_check_no_locks_held(struct task_struct *task);
- extern void rt_mutex_debug_task_free(struct task_struct *tsk);
+extern void rt_mutex_debug_task_free(struct task_struct *tsk);
 #else
- static inline int rt_mutex_debug_check_no_locks_freed(const void *from,
-						       unsigned long len)
- {
-	return 0;
- }
-# define rt_mutex_debug_check_no_locks_held(task)	do { } while (0)
-# define rt_mutex_debug_task_free(t)			do { } while (0)
+static inline void rt_mutex_debug_task_free(struct task_struct *tsk) { }
 #endif
 
 #define rt_mutex_init(mutex) \
@@ -88,7 +79,6 @@ static inline int rt_mutex_is_locked(str
 }
 
 extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
-extern void rt_mutex_destroy(struct rt_mutex *lock);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass);
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -38,20 +38,11 @@ void rt_mutex_debug_task_free(struct tas
 	DEBUG_LOCKS_WARN_ON(task->pi_blocked_on);
 }
 
-void debug_rt_mutex_lock(struct rt_mutex *lock)
-{
-}
-
 void debug_rt_mutex_unlock(struct rt_mutex *lock)
 {
 	DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current);
 }
 
-void
-debug_rt_mutex_proxy_lock(struct rt_mutex *lock, struct task_struct *powner)
-{
-}
-
 void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock)
 {
 	DEBUG_LOCKS_WARN_ON(!rt_mutex_owner(lock));
--- a/kernel/locking/rtmutex-debug.h
+++ b/kernel/locking/rtmutex-debug.h
@@ -13,10 +13,7 @@
 extern void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter);
 extern void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter);
 extern void debug_rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
-extern void debug_rt_mutex_lock(struct rt_mutex *lock);
 extern void debug_rt_mutex_unlock(struct rt_mutex *lock);
-extern void debug_rt_mutex_proxy_lock(struct rt_mutex *lock,
-				      struct task_struct *powner);
 extern void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock);
 
 static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *waiter,
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -885,9 +885,6 @@ static int try_to_take_rt_mutex(struct r
 	raw_spin_unlock(&task->pi_lock);
 
 takeit:
-	/* We got the lock. */
-	debug_rt_mutex_lock(lock);
-
 	/*
 	 * This either preserves the RT_MUTEX_HAS_WAITERS bit if there
 	 * are still waiters or clears it.
@@ -1581,20 +1578,6 @@ void __sched rt_mutex_futex_unlock(struc
 }
 
 /**
- * rt_mutex_destroy - mark a mutex unusable
- * @lock: the mutex to be destroyed
- *
- * This function marks the mutex uninitialized, and any subsequent
- * use of the mutex is forbidden. The mutex must not be locked when
- * this function is called.
- */
-void rt_mutex_destroy(struct rt_mutex *lock)
-{
-	WARN_ON(rt_mutex_is_locked(lock));
-}
-EXPORT_SYMBOL_GPL(rt_mutex_destroy);
-
-/**
  * __rt_mutex_init - initialize the rt_mutex
  *
  * @lock:	The rt_mutex to be initialized
@@ -1635,7 +1618,6 @@ void rt_mutex_init_proxy_locked(struct r
 				struct task_struct *proxy_owner)
 {
 	__rt_mutex_init(lock, NULL, NULL);
-	debug_rt_mutex_proxy_lock(lock, proxy_owner);
 	rt_mutex_set_owner(lock, proxy_owner);
 }
 
--- a/kernel/locking/rtmutex.h
+++ b/kernel/locking/rtmutex.h
@@ -13,8 +13,6 @@
 
 #define debug_rt_mutex_init_waiter(w)			do { } while (0)
 #define debug_rt_mutex_free_waiter(w)			do { } while (0)
-#define debug_rt_mutex_lock(l)				do { } while (0)
-#define debug_rt_mutex_proxy_lock(l,p)			do { } while (0)
 #define debug_rt_mutex_proxy_unlock(l)			do { } while (0)
 #define debug_rt_mutex_unlock(l)			do { } while (0)
 #define debug_rt_mutex_init(m, n, k)			do { } while (0)

