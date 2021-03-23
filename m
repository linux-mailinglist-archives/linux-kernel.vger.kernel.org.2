Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEA7346B40
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhCWVlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:41:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35868 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbhCWVjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:39:44 -0400
Message-Id: <20210323213707.773152524@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616535583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4rKCd7KXHzmGgu2ygyaX0d8MaeubBAsTzRFWw9DszXg=;
        b=kkyPTH6r8oYEOlo97wjawNGVaWASmhtzkSXanvFE/p85xM1WtNO29pLH35J3yPAOklfL9K
        hWwLH0jBj+A8kOEB90BkFgutRGJtvwG8u85CFq08Bqx1y1wMNu+qDoGtBt6DFTK7nEeG6p
        zIaCupr08hKVPmcYR/ZmPAYdwMLKzHKzbeHQH1fAYpxoIHEy2fhVuZAMdCv4MlwBqHqu7S
        /Zn0dgKRMekdnPaIhKggPLnPKdJXJeZcSCMNRg9mClfWVosrbgAVAgfGHMcN8WoMtYJt8X
        xerW3iQpfTLL7VgoZC0/T5fLIkEOBrT0inNJzt6E627pVG9LV++odJYwtZ0NeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616535583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4rKCd7KXHzmGgu2ygyaX0d8MaeubBAsTzRFWw9DszXg=;
        b=ySIHnNgz2tUwycQjcHBAFCTVp+Ag9cT5iSSaYGehAmegiJznjoZIOK/woi4n8+7cDj5WPR
        5JE5Ow9gecmz1fDQ==
Date:   Tue, 23 Mar 2021 22:30:22 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 03/14] locking/rtmutex: Remove output from deadlock detector.
References: <20210323213019.217008708@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The rtmutex specific deadlock detector predates lockdep coverage of rtmutex
and since commit f5694788ad8da ("rt_mutex: Add lockdep annotations") it
contains a lot of redundant functionality.

 - lockdep will detect an potential deadlock before rtmutex-debug
   has a chance to do so

 - the dead lock debugging is restricted to rtmutexes which are not
   associated to futexes and have an active waiter, which is covered by
   lockdep already

Remove the redundant functionality and move actual deadlock WARN() into the
deadlock code path. The latter needs a seperate cleanup.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rtmutex.h         |    7 --
 kernel/locking/rtmutex-debug.c  |   97 ----------------------------------------
 kernel/locking/rtmutex-debug.h  |    9 ---
 kernel/locking/rtmutex.c        |    7 --
 kernel/locking/rtmutex.h        |    7 --
 kernel/locking/rtmutex_common.h |    4 -
 6 files changed, 1 insertion(+), 130 deletions(-)

--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -31,9 +31,6 @@ struct rt_mutex {
 	raw_spinlock_t		wait_lock;
 	struct rb_root_cached   waiters;
 	struct task_struct	*owner;
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-	const char		*name;
-#endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
@@ -56,8 +53,6 @@ struct hrtimer_sleeper;
 #endif
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
-# define __DEBUG_RT_MUTEX_INITIALIZER(mutexname) \
-	, .name = #mutexname
 
 # define rt_mutex_init(mutex) \
 do { \
@@ -67,7 +62,6 @@ do { \
 
  extern void rt_mutex_debug_task_free(struct task_struct *tsk);
 #else
-# define __DEBUG_RT_MUTEX_INITIALIZER(mutexname)
 # define rt_mutex_init(mutex)			__rt_mutex_init(mutex, NULL, NULL)
 # define rt_mutex_debug_task_free(t)			do { } while (0)
 #endif
@@ -83,7 +77,6 @@ do { \
 	{ .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(mutexname.wait_lock) \
 	, .waiters = RB_ROOT_CACHED \
 	, .owner = NULL \
-	__DEBUG_RT_MUTEX_INITIALIZER(mutexname) \
 	__DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)}
 
 #define DEFINE_RT_MUTEX(mutexname) \
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -32,105 +32,12 @@
 
 #include "rtmutex_common.h"
 
-static void printk_task(struct task_struct *p)
-{
-	if (p)
-		printk("%16s:%5d [%p, %3d]", p->comm, task_pid_nr(p), p, p->prio);
-	else
-		printk("<none>");
-}
-
-static void printk_lock(struct rt_mutex *lock, int print_owner)
-{
-	printk(" [%p] {%s}\n", lock, lock->name);
-
-	if (print_owner && rt_mutex_owner(lock)) {
-		printk(".. ->owner: %p\n", lock->owner);
-		printk(".. held by:  ");
-		printk_task(rt_mutex_owner(lock));
-		printk("\n");
-	}
-}
-
 void rt_mutex_debug_task_free(struct task_struct *task)
 {
 	DEBUG_LOCKS_WARN_ON(!RB_EMPTY_ROOT(&task->pi_waiters.rb_root));
 	DEBUG_LOCKS_WARN_ON(task->pi_blocked_on);
 }
 
-/*
- * We fill out the fields in the waiter to store the information about
- * the deadlock. We print when we return. act_waiter can be NULL in
- * case of a remove waiter operation.
- */
-void debug_rt_mutex_deadlock(enum rtmutex_chainwalk chwalk,
-			     struct rt_mutex_waiter *act_waiter,
-			     struct rt_mutex *lock)
-{
-	struct task_struct *task;
-
-	if (!debug_locks || chwalk == RT_MUTEX_FULL_CHAINWALK || !act_waiter)
-		return;
-
-	task = rt_mutex_owner(act_waiter->lock);
-	if (task && task != current) {
-		act_waiter->deadlock_task_pid = get_pid(task_pid(task));
-		act_waiter->deadlock_lock = lock;
-	}
-}
-
-void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *waiter)
-{
-	struct task_struct *task;
-
-	if (!waiter->deadlock_lock || !debug_locks)
-		return;
-
-	rcu_read_lock();
-	task = pid_task(waiter->deadlock_task_pid, PIDTYPE_PID);
-	if (!task) {
-		rcu_read_unlock();
-		return;
-	}
-
-	if (!debug_locks_off()) {
-		rcu_read_unlock();
-		return;
-	}
-
-	pr_warn("\n");
-	pr_warn("============================================\n");
-	pr_warn("WARNING: circular locking deadlock detected!\n");
-	pr_warn("%s\n", print_tainted());
-	pr_warn("--------------------------------------------\n");
-	printk("%s/%d is deadlocking current task %s/%d\n\n",
-	       task->comm, task_pid_nr(task),
-	       current->comm, task_pid_nr(current));
-
-	printk("\n1) %s/%d is trying to acquire this lock:\n",
-	       current->comm, task_pid_nr(current));
-	printk_lock(waiter->lock, 1);
-
-	printk("\n2) %s/%d is blocked on this lock:\n",
-		task->comm, task_pid_nr(task));
-	printk_lock(waiter->deadlock_lock, 1);
-
-	debug_show_held_locks(current);
-	debug_show_held_locks(task);
-
-	printk("\n%s/%d's [blocked] stackdump:\n\n",
-		task->comm, task_pid_nr(task));
-	show_stack(task, NULL, KERN_DEFAULT);
-	printk("\n%s/%d's [current] stackdump:\n\n",
-		current->comm, task_pid_nr(current));
-	dump_stack();
-	debug_show_all_locks();
-	rcu_read_unlock();
-
-	printk("[ turning off deadlock detection."
-	       "Please report this trace. ]\n\n");
-}
-
 void debug_rt_mutex_lock(struct rt_mutex *lock)
 {
 }
@@ -153,12 +60,10 @@ void debug_rt_mutex_proxy_unlock(struct
 void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 {
 	memset(waiter, 0x11, sizeof(*waiter));
-	waiter->deadlock_task_pid = NULL;
 }
 
 void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter)
 {
-	put_pid(waiter->deadlock_task_pid);
 	memset(waiter, 0x22, sizeof(*waiter));
 }
 
@@ -168,10 +73,8 @@ void debug_rt_mutex_init(struct rt_mutex
 	 * Make sure we are not reinitializing a held lock:
 	 */
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
-	lock->name = name;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	lockdep_init_map(&lock->dep_map, name, key, 0);
 #endif
 }
-
--- a/kernel/locking/rtmutex-debug.h
+++ b/kernel/locking/rtmutex-debug.h
@@ -18,18 +18,9 @@ extern void debug_rt_mutex_unlock(struct
 extern void debug_rt_mutex_proxy_lock(struct rt_mutex *lock,
 				      struct task_struct *powner);
 extern void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock);
-extern void debug_rt_mutex_deadlock(enum rtmutex_chainwalk chwalk,
-				    struct rt_mutex_waiter *waiter,
-				    struct rt_mutex *lock);
-extern void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *waiter);
 
 static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *waiter,
 						  enum rtmutex_chainwalk walk)
 {
 	return (waiter != NULL);
 }
-
-static inline void rt_mutex_print_deadlock(struct rt_mutex_waiter *w)
-{
-	debug_rt_mutex_print_deadlock(w);
-}
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -579,7 +579,6 @@ static int rt_mutex_adjust_prio_chain(st
 	 * walk, we detected a deadlock.
 	 */
 	if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
-		debug_rt_mutex_deadlock(chwalk, orig_waiter, lock);
 		raw_spin_unlock(&lock->wait_lock);
 		ret = -EDEADLK;
 		goto out_unlock_pi;
@@ -1171,8 +1170,6 @@ static int __sched
 
 		raw_spin_unlock_irq(&lock->wait_lock);
 
-		debug_rt_mutex_print_deadlock(waiter);
-
 		schedule();
 
 		raw_spin_lock_irq(&lock->wait_lock);
@@ -1196,7 +1193,7 @@ static void rt_mutex_handle_deadlock(int
 	/*
 	 * Yell loudly and stop the task right here.
 	 */
-	rt_mutex_print_deadlock(w);
+	WARN(1, "rtmutex deadlock detected\n");
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule();
@@ -1704,8 +1701,6 @@ int __rt_mutex_start_proxy_lock(struct r
 		ret = 0;
 	}
 
-	debug_rt_mutex_print_deadlock(waiter);
-
 	return ret;
 }
 
--- a/kernel/locking/rtmutex.h
+++ b/kernel/locking/rtmutex.h
@@ -18,13 +18,6 @@
 #define debug_rt_mutex_proxy_unlock(l)			do { } while (0)
 #define debug_rt_mutex_unlock(l)			do { } while (0)
 #define debug_rt_mutex_init(m, n, k)			do { } while (0)
-#define debug_rt_mutex_deadlock(d, a ,l)		do { } while (0)
-#define debug_rt_mutex_print_deadlock(w)		do { } while (0)
-
-static inline void rt_mutex_print_deadlock(struct rt_mutex_waiter *w)
-{
-	WARN(1, "rtmutex deadlock detected\n");
-}
 
 static inline bool debug_rt_mutex_detect_deadlock(struct rt_mutex_waiter *w,
 						  enum rtmutex_chainwalk walk)
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -29,10 +29,6 @@ struct rt_mutex_waiter {
 	struct rb_node          pi_tree_entry;
 	struct task_struct	*task;
 	struct rt_mutex		*lock;
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-	struct pid		*deadlock_task_pid;
-	struct rt_mutex		*deadlock_lock;
-#endif
 	int prio;
 	u64 deadline;
 };

