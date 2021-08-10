Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72F03DBA7D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbhG3OXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:23:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55524 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbhG3OR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:26 -0400
Message-ID: <20210730135206.074657252@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=zmnhIKtCEBdBUbPTeaXsAflTQ/pCUB3Yr2SAQ9wy2GY=;
        b=1U0fQemOpdYycmuxg0qbAkSepZPxaM2eRqIZ0tVmBSF+cwnD4d+73MNDkaWw3BRR4zXBTV
        X+G8VakrOkNXuhdlZ54DWTa8OG3kzb3pDuqBMJoIRAxI56QVdGgg8SJM0fBq4ZGI8gkZOh
        fyZbo6pYSXObbth7fm2LGUMKhNHE7CdHGTJ0yHetFVN6/19T67ejKMy8gebsib9TcU+G8D
        u41bv9GSN35dyIW3F13wI/Mi907xreQyHn3M4qyXWJQJFQHOImniWTZDzV3gQXS/hJ4qE+
        iI31fGJfcfzdkGIZ4E2aY5n8tZuGA2NypFHTaAvisiQDIKfdenu+CNn6dBQ8kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=zmnhIKtCEBdBUbPTeaXsAflTQ/pCUB3Yr2SAQ9wy2GY=;
        b=/fwO36HlQp+gbquv+hv5HHUCvqLzFujkvJ/axmLVXzACkgVYSgEyYCuW0Ge1AGPdZf0v+I
        pdOv9E9dVmeZjpAA==
Date:   Fri, 30 Jul 2021 15:50:23 +0200
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
Subject: [patch 16/63] locking/rwsem: Add rtmutex based R/W semaphore implementation
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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
 include/linux/rwsem.h  |   58 ++++++++++++++++++++++++++
 kernel/locking/rwsem.c |  108 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+)
---
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -16,6 +16,9 @@
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <linux/err.h>
+
+#ifndef CONFIG_PREEMPT_RT
+
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 #include <linux/osq_lock.h>
 #endif
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
+		RW_DEP_MAP_INIT(name)				\
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
+	lockdep_init_map(&sem->dep_map, name, key, 0);
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

