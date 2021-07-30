Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195063DBA63
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbhG3OW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:22:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56044 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbhG3OSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:18:10 -0400
Message-ID: <20210730135208.033835435@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dkx+40ybxvCYh8q1hGT+KN9hnpF6WEFXVhZaV2LnVZM=;
        b=t2PyKhQtvm1XifZc+6wofw/8xWxzT3kxF1stH/rAwW4lVqf2DA9jGXsX+NkhYW1BVgPak+
        5A2zmjCDSeR2OL+Gmxm12xRB6qke8aa8vVwb9rQOuS9/a6Su0FhVdGeaqDh1shsVbKTXeS
        W7dPeUTk0SKJbxsbAAO/96BvTxy/iL/2yj+7Xgn1rxHB9CV49v+CTmgqjy2bRscIJr4MvM
        aGNNs80QVh0SV0XSN+GPeqgbchv1sLYeQj+ZFprxzB/8HArt4aq3Ni9Bx922auzvB0qzXR
        hypiIx6CBksYWwEkupZ0Q1pmYLsfksutip39DUzAJgMuu+yCzHVK42zwfejz0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dkx+40ybxvCYh8q1hGT+KN9hnpF6WEFXVhZaV2LnVZM=;
        b=gKf6KV5gFrU7R9PCH+l3j6bhPMUTk1zb1SF7UUwSIRWe2eL2k0VbkrE3JmbQHsV/AFocPv
        7wiaxXHvKbZKv0Bw==
Date:   Fri, 30 Jul 2021 15:50:58 +0200
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
Subject: [patch 51/63] locking/rtmutex: Add mutex variant for RT
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Add the necessary defines, helpers and API functions for replacing mutex on
a PREEMPT_RT enabled kernel with a rtmutex based variant.

No functional change when CONFIG_PREEMPT_RT=n

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mutex.h        |   67 ++++++++++++++++++++---
 kernel/locking/mutex.c       |    4 +
 kernel/locking/rtmutex_api.c |  122 +++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug            |   11 ++-
 4 files changed, 188 insertions(+), 16 deletions(-)
---
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -20,6 +20,18 @@
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
+		, .dep_map = {					\
+			.name = #lockname,			\
+			.wait_type_inner = LD_WAIT_SLEEP,	\
+		}
+#else
+# define __DEP_MAP_MUTEX_INITIALIZER(lockname)
+#endif
+
+#ifndef CONFIG_PREEMPT_RT
+
 /*
  * Simple, straightforward mutexes with strict semantics:
  *
@@ -93,16 +105,6 @@ do {									\
 	__mutex_init((mutex), #mutex, &__key);				\
 } while (0)
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
-		, .dep_map = {					\
-			.name = #lockname,			\
-			.wait_type_inner = LD_WAIT_SLEEP,	\
-		}
-#else
-# define __DEP_MAP_MUTEX_INITIALIZER(lockname)
-#endif
-
 #define __MUTEX_INITIALIZER(lockname) \
 		{ .owner = ATOMIC_LONG_INIT(0) \
 		, .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
@@ -124,6 +126,51 @@ extern void __mutex_init(struct mutex *l
  */
 extern bool mutex_is_locked(struct mutex *lock);
 
+#else /* !CONFIG_PREEMPT_RT */
+/*
+ * Preempt-RT variant based on rtmutexes.
+ */
+#include <linux/rtmutex.h>
+
+struct mutex {
+	struct rt_mutex_base	rtmutex;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+
+#define __MUTEX_INITIALIZER(mutexname)					\
+{									\
+	.rtmutex = __RT_MUTEX_BASE_INITIALIZER(mutexname.rtmutex)	\
+	__DEP_MAP_MUTEX_INITIALIZER(mutexname)				\
+}
+
+#define DEFINE_MUTEX(mutexname)						\
+	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
+
+extern void __mutex_rt_init(struct mutex *lock, const char *name,
+			    struct lock_class_key *key);
+extern int mutex_trylock(struct mutex *lock);
+
+static inline void mutex_destroy(struct mutex *lock) { }
+
+#define mutex_is_locked(l)	rt_mutex_base_is_locked(&(l)->rtmutex)
+
+#define mutex_init(mutex)				\
+do {							\
+	static struct lock_class_key __key;		\
+							\
+	rt_mutex_base_init(&(mutex)->rtmutex);		\
+	__mutex_rt_init((mutex), #mutex, &__key);	\
+} while (0)
+
+#define __mutex_init(mutex, name, key)			\
+do {							\
+	rt_mutex_base_init(&(mutex)->rtmutex);		\
+	__mutex_rt_init((mutex), name, key);		\
+} while (0)
+#endif /* CONFIG_PREEMPT_RT */
+
 /*
  * See kernel/locking/mutex.c for detailed documentation of these APIs.
  * Also see Documentation/locking/mutex-design.rst.
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -30,6 +30,7 @@
 #include <linux/debug_locks.h>
 #include <linux/osq_lock.h>
 
+#ifndef CONFIG_PREEMPT_RT
 #include "mutex.h"
 
 void
@@ -1078,7 +1079,8 @@ ww_mutex_lock_interruptible(struct ww_mu
 }
 EXPORT_SYMBOL(ww_mutex_lock_interruptible);
 
-#endif
+#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
+#endif /* !CONFIG_PREEMPT_RT */
 
 /**
  * atomic_dec_and_mutex_lock - return holding mutex if we dec to 0
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -454,3 +454,125 @@ void rt_mutex_debug_task_free(struct tas
 	DEBUG_LOCKS_WARN_ON(task->pi_blocked_on);
 }
 #endif
+
+#ifdef CONFIG_PREEMPT_RT
+/* Mutexes */
+void __mutex_rt_init(struct mutex *mutex, const char *name,
+		     struct lock_class_key *key)
+{
+	debug_check_no_locks_freed((void *)mutex, sizeof(*mutex));
+	lockdep_init_map(&mutex->dep_map, name, key, 0);
+}
+EXPORT_SYMBOL(__mutex_rt_init);
+
+static __always_inline int __mutex_lock_common(struct mutex *lock,
+					       unsigned int state,
+					       unsigned int subclass,
+					       struct lockdep_map *nest_lock,
+					       unsigned long ip)
+{
+	int ret;
+
+	might_sleep();
+	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
+	ret = __rt_mutex_lock(&lock->rtmutex, state);
+	if (ret)
+		mutex_release(&lock->dep_map, ip);
+	else
+		lock_acquired(&lock->dep_map, ip);
+	return ret;
+}
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void __sched mutex_lock_nested(struct mutex *lock, unsigned int subclass)
+{
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subclass, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(mutex_lock_nested);
+
+void __sched _mutex_lock_nest_lock(struct mutex *lock,
+				   struct lockdep_map *nest_lock)
+{
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0, nest_lock, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(_mutex_lock_nest_lock);
+
+int __sched mutex_lock_interruptible_nested(struct mutex *lock,
+					    unsigned int subclass)
+{
+	return __mutex_lock_common(lock, TASK_INTERRUPTIBLE, subclass, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(mutex_lock_interruptible_nested);
+
+int __sched mutex_lock_killable_nested(struct mutex *lock,
+					    unsigned int subclass)
+{
+	return __mutex_lock_common(lock, TASK_KILLABLE, subclass, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(mutex_lock_killable_nested);
+
+void __sched mutex_lock_io_nested(struct mutex *lock, unsigned int subclass)
+{
+	int token;
+
+	might_sleep();
+
+	token = io_schedule_prepare();
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subclass, NULL, _RET_IP_);
+	io_schedule_finish(token);
+}
+EXPORT_SYMBOL_GPL(mutex_lock_io_nested);
+
+#else /* CONFIG_DEBUG_LOCK_ALLOC */
+
+void __sched mutex_lock(struct mutex *lock)
+{
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL(mutex_lock);
+
+int __sched mutex_lock_interruptible(struct mutex *lock)
+{
+	return __mutex_lock_common(lock, TASK_INTERRUPTIBLE, 0, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL(mutex_lock_interruptible);
+
+int __sched mutex_lock_killable(struct mutex *lock)
+{
+	return __mutex_lock_common(lock, TASK_KILLABLE, 0, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL(mutex_lock_killable);
+
+void __sched mutex_lock_io(struct mutex *lock)
+{
+	int token = io_schedule_prepare();
+
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0, NULL, _RET_IP_);
+	io_schedule_finish(token);
+}
+EXPORT_SYMBOL(mutex_lock_io);
+#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
+
+int __sched mutex_trylock(struct mutex *lock)
+{
+	int ret;
+
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) && WARN_ON_ONCE(!in_task()))
+		return 0;
+
+	ret = __rt_mutex_trylock(&lock->rtmutex);
+	if (ret)
+		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+
+	return ret;
+}
+EXPORT_SYMBOL(mutex_trylock);
+
+void __sched mutex_unlock(struct mutex *lock)
+{
+	mutex_release(&lock->dep_map, _RET_IP_);
+	__rt_mutex_unlock(&lock->rtmutex);
+}
+EXPORT_SYMBOL(mutex_unlock);
+
+#endif /* CONFIG_PREEMPT_RT */
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1235,7 +1235,7 @@ config PROVE_LOCKING
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select LOCKDEP
 	select DEBUG_SPINLOCK
-	select DEBUG_MUTEXES
+	select DEBUG_MUTEXES if !PREEMPT_RT
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
 	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
@@ -1299,7 +1299,7 @@ config LOCK_STAT
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select LOCKDEP
 	select DEBUG_SPINLOCK
-	select DEBUG_MUTEXES
+	select DEBUG_MUTEXES if !PREEMPT_RT
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
 	select DEBUG_LOCK_ALLOC
 	default n
@@ -1335,7 +1335,7 @@ config DEBUG_SPINLOCK
 
 config DEBUG_MUTEXES
 	bool "Mutex debugging: basic checks"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && !PREEMPT_RT
 	help
 	 This feature allows mutex semantics violations to be detected and
 	 reported.
@@ -1345,7 +1345,8 @@ config DEBUG_WW_MUTEX_SLOWPATH
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select DEBUG_LOCK_ALLOC
 	select DEBUG_SPINLOCK
-	select DEBUG_MUTEXES
+	select DEBUG_MUTEXES if !PREEMPT_RT
+	select DEBUG_RT_MUTEXES if PREEMPT_RT
 	help
 	 This feature enables slowpath testing for w/w mutex users by
 	 injecting additional -EDEADLK wound/backoff cases. Together with
@@ -1368,7 +1369,7 @@ config DEBUG_LOCK_ALLOC
 	bool "Lock debugging: detect incorrect freeing of live locks"
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select DEBUG_SPINLOCK
-	select DEBUG_MUTEXES
+	select DEBUG_MUTEXES if !PREEMPT_RT
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
 	select LOCKDEP
 	help

