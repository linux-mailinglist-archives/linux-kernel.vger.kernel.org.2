Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057373C741F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhGMQRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54590 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhGMQQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:46 -0400
Message-Id: <20210713160749.741589043@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uOrndOHPQPC+6FBoafYd9HtmTvm+zCxBeOUpXJ5u35M=;
        b=vDiHtXdCbCaI8MBDEQwMBw06RaGL2meJNhVQ+UnqGUuCDjczO9Fp4IKFeyaDZukznd1pWQ
        nuyzuikY72bW2KYAkXVv4yvwvVDgd+EFHfYiFNEl5iYTGScxLpwpjqFFReMWXHpCEuEhM6
        oFK2vf+4Pdy3IPIZPvHJATCz1tBFWI6+orvQaNv0FynQi9nu9g4hfhSjtKyngIqRV5YWYW
        1mTp4VHjTYJYJ8h7zxy29drofThOTZAO2OLomzKdnrS/2rzGcKkmyQNjwHr/WtMrbKbUuC
        N0ZnxmL4zEQqVPTgG8n/C/aChUsil6q1IT5AGuDZIBpA7Z/emZh6yUsGt4ev9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uOrndOHPQPC+6FBoafYd9HtmTvm+zCxBeOUpXJ5u35M=;
        b=z3GU32xBjJKKmH91jmzxYmIarZwMCyBDoT8alc+sn1U7c/bjahBUWAJuXyguYcoJnwUpL+
        3Cq532S25aYBqcBQ==
Date:   Tue, 13 Jul 2021 17:11:33 +0200
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
Subject: [patch 39/50] locking/rtmutex: Add mutex variant for RT
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Add the necessary defines, helpers and API functions for replacing mutex on
a PREEMPT_RT enabled kernel with a rtmutex based variant.

If PREEMPT_RT is enabled then the regular 'struct mutex' is renamed to
'struct __mutex', which is still typedef'ed as '_mutex_t' to allow the
standalone compilation and utilization of ww_mutex.

No functional change when CONFIG_PREEMPT_RT=n

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mutex.h        |  53 ++++++++++++++++++-
 kernel/locking/rtmutex_api.c | 122 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 173 insertions(+), 2 deletions(-)
---
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 827c32bb44bc..2cfc234a786d 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -64,7 +64,12 @@
  * built on the regular mutex code in RT kernels while mutex itself is
  * substituted by a rt_mutex.
  */
-typedef struct mutex {
+#ifndef CONFIG_PREEMPT_RT
+typedef struct mutex
+#else
+typedef struct __mutex
+#endif
+{
 	atomic_long_t		owner;
 	raw_spinlock_t		wait_lock;
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
@@ -94,6 +99,7 @@ extern void _mutex_t_destroy(_mutex_t *lock);
 static inline void _mutex_t_destroy(_mutex_t *lock) {}
 #endif
 
+#ifndef CONFIG_PREEMPT_RT
 /**
  * mutex_init - initialize the mutex
  * @mutex: the mutex to be initialized
@@ -159,6 +165,51 @@ static __always_inline int mutex_trylock(struct mutex *lock)
 	return _mutex_t_trylock(lock);
 }
 
+#else /* !CONFIG_PREEMPT_RT */
+/*
+ * Preempt-RT variant based on rtmutexes.
+ */
+#include <linux/rtmutex.h>
+
+struct mutex {
+	struct rt_mutex		rtmutex;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+
+#define __MUTEX_INITIALIZER(mutexname)					\
+	{								\
+		.rtmutex = __RT_MUTEX_INITIALIZER(mutexname.rtmutex)	\
+		__DEP_MAP_MUTEX_INITIALIZER(mutexname)			\
+	}
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
+#define mutex_is_locked(l)	rt_mutex_is_locked(&(l)->rtmutex)
+
+#define mutex_init(mutex)				\
+do {							\
+	static struct lock_class_key __key;		\
+							\
+	rt_mutex_init(&(mutex)->rtmutex);		\
+	__mutex_rt_init((mutex), #mutex, &__key);	\
+} while (0)
+
+#define __mutex_init(mutex, name, key)			\
+do {							\
+	rt_mutex_init(&(mutex)->rtmutex);		\
+	__mutex_rt_init((mutex), name, key);		\
+} while (0)
+#endif /* CONFIG_PREEMPT_RT */
+
 /*
  * See kernel/locking/mutex.c for detailed documentation of these APIs.
  * Also see Documentation/locking/mutex-design.rst.
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index d9a2ec9c1ad4..1091a53eb99f 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -512,4 +512,124 @@ void rwsem_rt_mutex_unlock(struct rt_mutex *lock)
 
 	rt_mutex_slowunlock(lock);
 }
-#endif
+
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

