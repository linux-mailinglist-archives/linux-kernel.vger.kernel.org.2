Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD9A3C7414
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbhGMQRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54502 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbhGMQQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:33 -0400
Message-Id: <20210713160748.693475434@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Fg/f1U2eudIcAZLDNBjW25KYrRfDULLCpKFoWUXGkjs=;
        b=MmNBz4fiU0IruoaGVSeoQ6xt1IY8Xtgb2cKwmsiw3i/j9dBAaiqZpOCy44jGHCSUoC984n
        jZKCIoFmst6wixEZsw+4ZNBxhDk2jcBLCmvVrYazrhnkGsoSd/bt0wwQQOU2qKGzqTPG2j
        22syTQ5Ta7KwUcHdAWScg1c7B9ipmFZVF1cZ8nj5jflDdHgURH+M13TDMirL/sAqswAQ8C
        p24s8c1UOfD7tRJh/ho1PNJHI7YeqlOEJZl0JCItRG/MTE2wpgDEho5f6LwNXcxrrUUl51
        HbAk3k8qDdlwq9Ghwt2Zf0bd6EYLmNc1MesoOydNwnzOI/IePN5UHa2dZzVD9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Fg/f1U2eudIcAZLDNBjW25KYrRfDULLCpKFoWUXGkjs=;
        b=x96L+s9gVLzKJUiyyY6OX8FoZl2h+2Dd6Ey7AvV5o5IgOuN5tWN3HT6i8hVsMxle90plAm
        tAaihcrW/JoGBWBQ==
Date:   Tue, 13 Jul 2021 17:11:22 +0200
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
Subject: [patch 28/50] locking/rwlock: Provide RT variant
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Similar to rw_semaphores on RT the rwlock substitution is not writer fair
because it's not feasible to have a writer inherit it's priority to
multiple readers. Readers blocked on a writer follow the normal rules of
priority inheritance. Like RT spinlocks RT rwlocks are state preserving
accross the slow lock operations (contended case).

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rwlock_rt.h       |  140 ++++++++++++++++++++++++++++++++++++++++
 include/linux/rwlock_types.h    |   35 +++++++++-
 include/linux/spinlock_rt.h     |    2 
 kernel/Kconfig.locks            |    2 
 kernel/locking/spinlock.c       |    7 ++
 kernel/locking/spinlock_debug.c |    5 +
 kernel/locking/spinlock_rt.c    |  129 ++++++++++++++++++++++++++++++++++++
 7 files changed, 317 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/rwlock_rt.h
---
--- /dev/null
+++ b/include/linux/rwlock_rt.h
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef __LINUX_RWLOCK_RT_H
+#define __LINUX_RWLOCK_RT_H
+
+#ifndef __LINUX_SPINLOCK_RT_H
+#error Do not include directly. Use spinlock.h
+#endif
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+extern void __rt_rwlock_init(rwlock_t *rwlock, const char *name,
+			     struct lock_class_key *key);
+#else
+static inline void __rt_rwlock_init(rwlock_t *rwlock, char *name,
+				    struct lock_class_key *key)
+{
+}
+#endif
+
+#define rwlock_init(rwl)				\
+do {							\
+	static struct lock_class_key __key;		\
+							\
+	init_rwbase_rt(&(rwl)->rwbase);		\
+	__rt_rwlock_init(rwl, #rwl, &__key);		\
+} while (0)
+
+extern void rt_read_lock(rwlock_t *rwlock);
+extern int rt_read_trylock(rwlock_t *rwlock);
+extern void rt_read_unlock(rwlock_t *rwlock);
+extern void rt_write_lock(rwlock_t *rwlock);
+extern int rt_write_trylock(rwlock_t *rwlock);
+extern void rt_write_unlock(rwlock_t *rwlock);
+
+static __always_inline void read_lock(rwlock_t *rwlock)
+{
+	rt_read_lock(rwlock);
+}
+
+static __always_inline void read_lock_bh(rwlock_t *rwlock)
+{
+	local_bh_disable();
+	rt_read_lock(rwlock);
+}
+
+static __always_inline void read_lock_irq(rwlock_t *rwlock)
+{
+	rt_read_lock(rwlock);
+}
+
+#define read_lock_irqsave(lock, flags)			\
+	do {						\
+		typecheck(unsigned long, flags);	\
+		rt_read_lock(lock);			\
+		flags = 0;				\
+	} while (0)
+
+#define read_trylock(lock)	__cond_lock(lock, rt_read_trylock(lock))
+
+static __always_inline void read_unlock(rwlock_t *rwlock)
+{
+	rt_read_unlock(rwlock);
+}
+
+static __always_inline void read_unlock_bh(rwlock_t *rwlock)
+{
+	rt_read_unlock(rwlock);
+	local_bh_enable();
+}
+
+static __always_inline void read_unlock_irq(rwlock_t *rwlock)
+{
+	rt_read_unlock(rwlock);
+}
+
+static __always_inline void read_unlock_irqrestore(rwlock_t *rwlock,
+						   unsigned long flags)
+{
+	rt_read_unlock(rwlock);
+}
+
+static __always_inline void write_lock(rwlock_t *rwlock)
+{
+	rt_write_lock(rwlock);
+}
+
+static __always_inline void write_lock_bh(rwlock_t *rwlock)
+{
+	local_bh_disable();
+	rt_write_lock(rwlock);
+}
+
+static __always_inline void write_lock_irq(rwlock_t *rwlock)
+{
+	rt_write_lock(rwlock);
+}
+
+#define write_lock_irqsave(lock, flags)			\
+	do {						\
+		typecheck(unsigned long, flags);	\
+		rt_write_lock(lock);			\
+		flags = 0;				\
+	} while (0)
+
+#define write_trylock(lock)	__cond_lock(lock, rt_write_trylock(lock))
+
+#define write_trylock_irqsave(lock, flags)		\
+({							\
+	int __locked;					\
+							\
+	typecheck(unsigned long, flags);		\
+	flags = 0;					\
+	__locked = write_trylock(lock);			\
+	__locked;					\
+})
+
+static __always_inline void write_unlock(rwlock_t *rwlock)
+{
+	rt_write_unlock(rwlock);
+}
+
+static __always_inline void write_unlock_bh(rwlock_t *rwlock)
+{
+	rt_write_unlock(rwlock);
+	local_bh_enable();
+}
+
+static __always_inline void write_unlock_irq(rwlock_t *rwlock)
+{
+	rt_write_unlock(rwlock);
+}
+
+static __always_inline void write_unlock_irqrestore(rwlock_t *rwlock,
+						    unsigned long flags)
+{
+	rt_write_unlock(rwlock);
+}
+
+#define rwlock_is_contended(lock)		(((void)(lock), 0))
+
+#endif
--- a/include/linux/rwlock_types.h
+++ b/include/linux/rwlock_types.h
@@ -5,9 +5,9 @@
 # error "Do not include directly, include spinlock_types.h"
 #endif
 
+#ifndef CONFIG_PREEMPT_RT
 /*
- * include/linux/rwlock_types.h - generic rwlock type definitions
- *				  and initializers
+ * generic rwlock type definitions and initializers
  *
  * portions Copyright 2005, Red Hat, Inc., Ingo Molnar
  * Released under the General Public License (GPL).
@@ -50,4 +50,35 @@ typedef struct {
 
 #define DEFINE_RWLOCK(x)	rwlock_t x = __RW_LOCK_UNLOCKED(x)
 
+#else /* !CONFIG_PREEMPT_RT */
+
+#include <linux/rwbase_rt.h>
+
+typedef struct {
+	struct rwbase_rt	rwbase;
+	atomic_t		readers;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+} rwlock_t;
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define RW_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname }
+#else
+# define RW_DEP_MAP_INIT(lockname)
+#endif
+
+#define __RW_LOCK_UNLOCKED(name) __RWLOCK_RT_INITIALIZER(name)
+
+#define DEFINE_RWLOCK(name) \
+	rwlock_t name = __RW_LOCK_UNLOCKED(name)
+
+#define __RWLOCK_RT_INITIALIZER(name)					\
+{									\
+	.rwbase = __RWBASE_INITIALIZER(name),				\
+	RW_DEP_MAP_INIT(name)						\
+}
+
+#endif /* CONFIG_PREEMPT_RT */
+
 #endif /* __LINUX_RWLOCK_TYPES_H */
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -146,4 +146,6 @@ static inline int spin_is_locked(spinloc
 
 #define assert_spin_locked(lock) BUG_ON(!spin_is_locked(lock))
 
+#include <linux/rwlock_rt.h>
+
 #endif
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -251,7 +251,7 @@ config ARCH_USE_QUEUED_RWLOCKS
 
 config QUEUED_RWLOCKS
 	def_bool y if ARCH_USE_QUEUED_RWLOCKS
-	depends on SMP
+	depends on SMP && !PREEMPT_RT
 
 config ARCH_HAS_MMIOWB
 	bool
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -124,8 +124,11 @@ void __lockfunc __raw_##op##_lock_bh(loc
  *         __[spin|read|write]_lock_bh()
  */
 BUILD_LOCK_OPS(spin, raw_spinlock);
+
+#ifndef CONFIG_PREEMPT_RT
 BUILD_LOCK_OPS(read, rwlock);
 BUILD_LOCK_OPS(write, rwlock);
+#endif
 
 #endif
 
@@ -209,6 +212,8 @@ void __lockfunc _raw_spin_unlock_bh(raw_
 EXPORT_SYMBOL(_raw_spin_unlock_bh);
 #endif
 
+#ifndef CONFIG_PREEMPT_RT
+
 #ifndef CONFIG_INLINE_READ_TRYLOCK
 int __lockfunc _raw_read_trylock(rwlock_t *lock)
 {
@@ -353,6 +358,8 @@ void __lockfunc _raw_write_unlock_bh(rwl
 EXPORT_SYMBOL(_raw_write_unlock_bh);
 #endif
 
+#endif /* !CONFIG_PREEMPT_RT */
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 void __lockfunc _raw_spin_lock_nested(raw_spinlock_t *lock, int subclass)
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -31,6 +31,7 @@ void __raw_spin_lock_init(raw_spinlock_t
 
 EXPORT_SYMBOL(__raw_spin_lock_init);
 
+#ifndef CONFIG_PREEMPT_RT
 void __rwlock_init(rwlock_t *lock, const char *name,
 		   struct lock_class_key *key)
 {
@@ -48,6 +49,7 @@ void __rwlock_init(rwlock_t *lock, const
 }
 
 EXPORT_SYMBOL(__rwlock_init);
+#endif
 
 static void spin_dump(raw_spinlock_t *lock, const char *msg)
 {
@@ -139,6 +141,7 @@ void do_raw_spin_unlock(raw_spinlock_t *
 	arch_spin_unlock(&lock->raw_lock);
 }
 
+#ifndef CONFIG_PREEMPT_RT
 static void rwlock_bug(rwlock_t *lock, const char *msg)
 {
 	if (!debug_locks_off())
@@ -228,3 +231,5 @@ void do_raw_write_unlock(rwlock_t *lock)
 	debug_write_unlock(lock);
 	arch_write_unlock(&lock->raw_lock);
 }
+
+#endif /* !CONFIG_PREEMPT_RT */
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -126,3 +126,132 @@ void __rt_spin_lock_init(spinlock_t *loc
 }
 EXPORT_SYMBOL(__rt_spin_lock_init);
 #endif
+
+/*
+ * RT-specific reader/writer locks
+ */
+#define rwbase_set_and_save_current_state(state)	\
+	current_save_and_set_rtlock_wait_state()
+
+#define rwbase_restore_current_state()			\
+	current_restore_rtlock_saved_state()
+
+static __always_inline int rwbase_rtmutex_lock_state(struct rt_mutex *rtm,
+						     unsigned int state)
+{
+	if (unlikely(!rt_mutex_cmpxchg_acquire(rtm, NULL, current)))
+		rtlock_slowlock(rtm);
+	return 0;
+}
+
+static __always_inline int rwbase_rtmutex_slowlock_locked(struct rt_mutex *rtm,
+							  unsigned int state)
+{
+	rtlock_slowlock_locked(rtm);
+	return 0;
+}
+
+static __always_inline void rwbase_rtmutex_unlock(struct rt_mutex *rtm)
+{
+	if (likely(rt_mutex_cmpxchg_acquire(rtm, current, NULL)))
+		return;
+
+	rt_mutex_slowunlock(rtm);
+}
+
+static __always_inline int  rwbase_rtmutex_trylock(struct rt_mutex *rtm)
+{
+	if (likely(rt_mutex_cmpxchg_acquire(rtm, NULL, current)))
+		return 1;
+
+	return rt_mutex_slowtrylock(rtm);
+}
+
+#define rwbase_signal_pending_state(state, current)	(0)
+
+#define rwbase_schedule()				\
+	schedule_rtlock()
+
+#include "rwbase_rt.c"
+/*
+ * The common functions which get wrapped into the rwlock API.
+ */
+int __sched rt_read_trylock(rwlock_t *rwlock)
+{
+	int ret;
+
+	ret = rwbase_read_trylock(&rwlock->rwbase);
+	if (ret) {
+		rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);
+		rcu_read_lock();
+		migrate_disable();
+	}
+	return ret;
+}
+EXPORT_SYMBOL(rt_read_trylock);
+
+int __sched rt_write_trylock(rwlock_t *rwlock)
+{
+	int ret;
+
+	ret = rwbase_write_trylock(&rwlock->rwbase);
+	if (ret) {
+		rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
+		rcu_read_lock();
+		migrate_disable();
+	}
+	return ret;
+}
+EXPORT_SYMBOL(rt_write_trylock);
+
+void __sched rt_read_lock(rwlock_t *rwlock)
+{
+	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
+	rwbase_read_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
+	rcu_read_lock();
+	migrate_disable();
+}
+EXPORT_SYMBOL(rt_read_lock);
+
+void __sched rt_write_lock(rwlock_t *rwlock)
+{
+	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
+	rwbase_write_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
+	rcu_read_lock();
+	migrate_disable();
+}
+EXPORT_SYMBOL(rt_write_lock);
+
+void __sched rt_read_unlock(rwlock_t *rwlock)
+{
+	rwlock_release(&rwlock->dep_map, _RET_IP_);
+	migrate_enable();
+	rcu_read_unlock();
+	rwbase_read_unlock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
+}
+EXPORT_SYMBOL(rt_read_unlock);
+
+void __sched rt_write_unlock(rwlock_t *rwlock)
+{
+	rwlock_release(&rwlock->dep_map, _RET_IP_);
+	rcu_read_unlock();
+	migrate_enable();
+	rwbase_write_unlock(&rwlock->rwbase);
+}
+EXPORT_SYMBOL(rt_write_unlock);
+
+int __sched rt_rwlock_is_contended(rwlock_t *rwlock)
+{
+	return rw_base_is_contended(&rwlock->rwbase);
+}
+EXPORT_SYMBOL(rt_rwlock_is_contended);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void __rt_rwlock_init(rwlock_t *rwlock, const char *name,
+		      struct lock_class_key *key)
+{
+	debug_check_no_locks_freed((void *)rwlock, sizeof(*rwlock));
+	lockdep_init_map(&rwlock->dep_map, name, key, 0);
+}
+EXPORT_SYMBOL(__rt_rwlock_init);
+#endif

