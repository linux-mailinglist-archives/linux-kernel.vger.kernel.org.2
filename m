Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8423ECB2D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhHOVaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:30:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48012 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhHOV2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:28:37 -0400
Message-ID: <20210815211303.016885947@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hEjzSpdao0jOoQR8yH72suopORVoPCbsse/QwGUC3ek=;
        b=m4glR2gExa6Rr0flH2hZvM/hEe9POVu+WzstR2USw9TYxgQ4IfLGoQhD2oVgDXLG4WGBbt
        I6eAkRpexOuWitV6fpaiKlzoWKf8kqrcPyEnoQjxp6jRpinFue6n4IC0I8SIQlDL876CVH
        d2P/RYA6SzrT5bE6A/Jkrx1TSuWrwrqKekw3crscqeCTML8wibnjFyO1SlCudGaQHgBYNH
        t91YmcgbydP5iv/c0rmV88/7SV0yMDHNiIHIM267/lj7m8nEL19e2YaxRegAqVSd1B9cZ/
        ad3nTr9058y/3zVEcB6DIEJY4EECjNoB3j+fagC7kQLjXg7YIouB0hsnJjIk2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hEjzSpdao0jOoQR8yH72suopORVoPCbsse/QwGUC3ek=;
        b=Kcd1+0Wv4xcyfeyzXfys5EgTF9WdYoUp9ISzy/zVmXmYRPeggsffb3i8CcmWOsxuHFL5cb
        R0FeQaaEj0TqC0Bg==
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
Subject: [patch V5 19/72] locking/rwsem: Add rtmutex based R/W semaphore
 implementation
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:05 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The RT specific R/W semaphore implementation used to restrict the number of
readers to one because a writer cannot block on multiple readers and
inherit its priority or budget.

The single reader restricting was painful in various ways:

 - Performance bottleneck for multi-threaded applications in the page fault
   path (mmap sem)

 - Progress blocker for drivers which are carefully crafted to avoid the
   potential reader/writer deadlock in mainline.

The analysis of the writer code paths shows, that properly written RT tasks
should not take them. Syscalls like mmap(), file access which take mmap sem
write locked have unbound latencies which are completely unrelated to mmap
sem. Other R/W sem users like graphics drivers are not suitable for RT tasks
either.

So there is little risk to hurt RT tasks when the RT rwsem implementation is
done in the following way:

 - Allow concurrent readers

 - Make writers block until the last reader left the critical section. This
   blocking is not subject to priority/budget inheritance.

 - Readers blocked on a writer inherit their priority/budget in the normal
   way.

There is a drawback with this scheme. R/W semaphores become writer unfair
though the applications which have triggered writer starvation (mostly on
mmap_sem) in the past are not really the typical workloads running on a RT
system. So while it's unlikely to hit writer starvation, it's possible. If
there are unexpected workloads on RT systems triggering it, the problem
has to be revisited.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Fix indent fail (Peter Z)
---
 include/linux/rwsem.h  |   78 ++++++++++++++++++++++++++++++-----
 kernel/locking/rwsem.c |  108 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+), 10 deletions(-)
---
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -16,6 +16,19 @@
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <linux/err.h>
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define __RWSEM_DEP_MAP_INIT(lockname)			\
+	.dep_map = {					\
+		.name = #lockname,			\
+		.wait_type_inner = LD_WAIT_SLEEP,	\
+	},
+#else
+# define __RWSEM_DEP_MAP_INIT(lockname)
+#endif
+
+#ifndef CONFIG_PREEMPT_RT
+
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 #include <linux/osq_lock.h>
 #endif
@@ -64,16 +77,6 @@ static inline int rwsem_is_locked(struct
 
 /* Common initializer macros and functions */
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define __RWSEM_DEP_MAP_INIT(lockname)			\
-	.dep_map = {					\
-		.name = #lockname,			\
-		.wait_type_inner = LD_WAIT_SLEEP,	\
-	},
-#else
-# define __RWSEM_DEP_MAP_INIT(lockname)
-#endif
-
 #ifdef CONFIG_DEBUG_RWSEMS
 # define __RWSEM_DEBUG_INIT(lockname) .magic = &lockname,
 #else
@@ -119,6 +122,61 @@ static inline int rwsem_is_contended(str
 	return !list_empty(&sem->wait_list);
 }
 
+#else /* !CONFIG_PREEMPT_RT */
+
+#include <linux/rwbase_rt.h>
+
+struct rw_semaphore {
+	struct rwbase_rt	rwbase;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+
+#define __RWSEM_INITIALIZER(name)				\
+	{							\
+		.rwbase = __RWBASE_INITIALIZER(name),		\
+		__RWSEM_DEP_MAP_INIT(name)			\
+	}
+
+#define DECLARE_RWSEM(lockname) \
+	struct rw_semaphore lockname = __RWSEM_INITIALIZER(lockname)
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+extern void  __rwsem_init(struct rw_semaphore *rwsem, const char *name,
+			  struct lock_class_key *key);
+#else
+static inline void  __rwsem_init(struct rw_semaphore *rwsem, const char *name,
+				 struct lock_class_key *key)
+{
+}
+#endif
+
+#define init_rwsem(sem)						\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	init_rwbase_rt(&(sem)->rwbase);			\
+	__rwsem_init((sem), #sem, &__key);			\
+} while (0)
+
+static __always_inline int rwsem_is_locked(struct rw_semaphore *sem)
+{
+	return rw_base_is_locked(&sem->rwbase);
+}
+
+static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
+{
+	return rw_base_is_contended(&sem->rwbase);
+}
+
+#endif /* CONFIG_PREEMPT_RT */
+
+/*
+ * The functions below are the same for all rwsem implementations including
+ * the RT specific variant.
+ */
+
 /*
  * lock for reading
  */
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -28,6 +28,7 @@
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
 
+#ifndef CONFIG_PREEMPT_RT
 #include "lock_events.h"
 
 /*
@@ -1344,6 +1345,113 @@ static inline void __downgrade_write(str
 		rwsem_downgrade_wake(sem);
 }
 
+#else /* !CONFIG_PREEMPT_RT */
+
+#include "rtmutex.c"
+
+#define rwbase_set_and_save_current_state(state)	\
+	set_current_state(state)
+
+#define rwbase_restore_current_state()			\
+	__set_current_state(TASK_RUNNING)
+
+#define rwbase_rtmutex_lock_state(rtm, state)		\
+	__rt_mutex_lock(rtm, state)
+
+#define rwbase_rtmutex_slowlock_locked(rtm, state)	\
+	__rt_mutex_slowlock_locked(rtm, state)
+
+#define rwbase_rtmutex_unlock(rtm)			\
+	__rt_mutex_unlock(rtm)
+
+#define rwbase_rtmutex_trylock(rtm)			\
+	__rt_mutex_trylock(rtm)
+
+#define rwbase_signal_pending_state(state, current)	\
+	signal_pending_state(state, current)
+
+#define rwbase_schedule()				\
+	schedule()
+
+#include "rwbase_rt.c"
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void __rwsem_init(struct rw_semaphore *sem, const char *name,
+		  struct lock_class_key *key)
+{
+	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
+	lockdep_init_map_wait(&sem->dep_map, name, key, 0, LD_WAIT_SLEEP);
+}
+EXPORT_SYMBOL(__rwsem_init);
+#endif
+
+static inline void __down_read(struct rw_semaphore *sem)
+{
+	rwbase_read_lock(&sem->rwbase, TASK_UNINTERRUPTIBLE);
+}
+
+static inline int __down_read_interruptible(struct rw_semaphore *sem)
+{
+	return rwbase_read_lock(&sem->rwbase, TASK_INTERRUPTIBLE);
+}
+
+static inline int __down_read_killable(struct rw_semaphore *sem)
+{
+	return rwbase_read_lock(&sem->rwbase, TASK_KILLABLE);
+}
+
+static inline int __down_read_trylock(struct rw_semaphore *sem)
+{
+	return rwbase_read_trylock(&sem->rwbase);
+}
+
+static inline void __up_read(struct rw_semaphore *sem)
+{
+	rwbase_read_unlock(&sem->rwbase, TASK_NORMAL);
+}
+
+static inline void __sched __down_write(struct rw_semaphore *sem)
+{
+	rwbase_write_lock(&sem->rwbase, TASK_UNINTERRUPTIBLE);
+}
+
+static inline int __sched __down_write_killable(struct rw_semaphore *sem)
+{
+	return rwbase_write_lock(&sem->rwbase, TASK_KILLABLE);
+}
+
+static inline int __down_write_trylock(struct rw_semaphore *sem)
+{
+	return rwbase_write_trylock(&sem->rwbase);
+}
+
+static inline void __up_write(struct rw_semaphore *sem)
+{
+	rwbase_write_unlock(&sem->rwbase);
+}
+
+static inline void __downgrade_write(struct rw_semaphore *sem)
+{
+	rwbase_write_downgrade(&sem->rwbase);
+}
+
+/* Debug stubs for the common API */
+#define DEBUG_RWSEMS_WARN_ON(c, sem)
+
+static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
+					    struct task_struct *owner)
+{
+}
+
+static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
+{
+	int count = atomic_read(&sem->rwbase.readers);
+
+	return count < 0 && count != READER_BIAS;
+}
+
+#endif /* CONFIG_PREEMPT_RT */
+
 /*
  * lock for reading
  */

