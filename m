Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F2A4163A9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbhIWQ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:56:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35966 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhIWQ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:56:08 -0400
Message-ID: <20210923165357.928693482@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632416076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ewd4pU+vwBo7kb7O/Zi1128ArMzkauCl+FkloHOqYe0=;
        b=jhmvAFq7AAotnBtVTWHvHTcvYtdLjbr5MdpVqwINbgk/Pxl7TY86kUHOoQ+nhLhiDQDF7Z
        lcI+8k9UnwQE8sZ4psuo+0Y3WXN4pciOdjzuWioXa7iKkoDI3TMVXfY+gtI1Toe9t2nE3e
        P9JF1yP9bRIhaQSXnEWhiPwK5QUjn8eCTc6a1yj7WBYDyei4OkQmwVlQTCSavMJCEpj543
        58Ah/LXaTuu+PF5jOvCHi1ynFjuEofW5oju+xEzTYoDTZwXli57L3SABeJ6oYmbPkvB0B7
        PrtL15orKhZAGldSSyRgpRGuC+9mLAWnytEPKgJCF3DFIQfuxz2hv4SzYwi2tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632416076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ewd4pU+vwBo7kb7O/Zi1128ArMzkauCl+FkloHOqYe0=;
        b=03kNRFRdIf0bGQObGAHR40HfsP/1FEkIkGbuwJxrbKsNyvcpIrkcJasoluwfCFs2qsyjKX
        6IpiCzbnrt9yiVDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: [patch 1/8] sched: Clean up the might_sleep() underscore zoo
References: <20210923164145.466686140@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 23 Sep 2021 18:54:35 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__might_sleep() vs. ___might_sleep() is hard to distinguish. Aside of that
the three underscore variant is exposed to provide a checkpoint for
rescheduling points which are distinct from blocking points.

They are semantically a preemption point which means that scheduling is
state preserving. A real blocking operation, e.g. mutex_lock(), wait*(),
which cannot preserve a task state which is not equal to RUNNING.

While technically blocking on a "sleeping" spinlock in RT enabled kernels
falls into the voluntary scheduling category because it has to wait until
the contended spin/rw lock becomes available, the RT lock substitution code
can semantically be mapped to a voluntary preemption because the RT lock
substitution code and the scheduler are providing mechanisms to preserve
the task state and to take regular non-lock related wakeups into account.

Rename ___might_sleep() to __might_resched() to make the distinction of
these functions clear.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/kernel.h       |    6 +++---
 include/linux/sched.h        |    8 ++++----
 kernel/locking/spinlock_rt.c |    6 +++---
 kernel/sched/core.c          |    6 +++---
 4 files changed, 13 insertions(+), 13 deletions(-)

--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -111,7 +111,7 @@ static __always_inline void might_resche
 #endif /* CONFIG_PREEMPT_* */
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-extern void ___might_sleep(const char *file, int line, int preempt_offset);
+extern void __might_resched(const char *file, int line, int preempt_offset);
 extern void __might_sleep(const char *file, int line, int preempt_offset);
 extern void __cant_sleep(const char *file, int line, int preempt_offset);
 extern void __cant_migrate(const char *file, int line);
@@ -168,8 +168,8 @@ extern void __cant_migrate(const char *f
  */
 # define non_block_end() WARN_ON(current->non_block_count-- == 0)
 #else
-  static inline void ___might_sleep(const char *file, int line,
-				   int preempt_offset) { }
+  static inline void __might_resched(const char *file, int line,
+				     int preempt_offset) { }
   static inline void __might_sleep(const char *file, int line,
 				   int preempt_offset) { }
 # define might_sleep() do { might_resched(); } while (0)
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2041,7 +2041,7 @@ static inline int _cond_resched(void) {
 #endif /* !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC) */
 
 #define cond_resched() ({			\
-	___might_sleep(__FILE__, __LINE__, 0);	\
+	__might_resched(__FILE__, __LINE__, 0);	\
 	_cond_resched();			\
 })
 
@@ -2049,9 +2049,9 @@ extern int __cond_resched_lock(spinlock_
 extern int __cond_resched_rwlock_read(rwlock_t *lock);
 extern int __cond_resched_rwlock_write(rwlock_t *lock);
 
-#define cond_resched_lock(lock) ({				\
-	___might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);\
-	__cond_resched_lock(lock);				\
+#define cond_resched_lock(lock) ({					\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
+	__cond_resched_lock(lock);					\
 })
 
 #define cond_resched_rwlock_read(lock) ({			\
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -32,7 +32,7 @@ static __always_inline void rtlock_lock(
 
 static __always_inline void __rt_spin_lock(spinlock_t *lock)
 {
-	___might_sleep(__FILE__, __LINE__, 0);
+	__might_resched(__FILE__, __LINE__, 0);
 	rtlock_lock(&lock->lock);
 	rcu_read_lock();
 	migrate_disable();
@@ -210,7 +210,7 @@ EXPORT_SYMBOL(rt_write_trylock);
 
 void __sched rt_read_lock(rwlock_t *rwlock)
 {
-	___might_sleep(__FILE__, __LINE__, 0);
+	__might_resched(__FILE__, __LINE__, 0);
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_read_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
@@ -220,7 +220,7 @@ EXPORT_SYMBOL(rt_read_lock);
 
 void __sched rt_write_lock(rwlock_t *rwlock)
 {
-	___might_sleep(__FILE__, __LINE__, 0);
+	__might_resched(__FILE__, __LINE__, 0);
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_write_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9446,11 +9446,11 @@ void __might_sleep(const char *file, int
 			(void *)current->task_state_change,
 			(void *)current->task_state_change);
 
-	___might_sleep(file, line, preempt_offset);
+	__might_resched(file, line, preempt_offset);
 }
 EXPORT_SYMBOL(__might_sleep);
 
-void ___might_sleep(const char *file, int line, int preempt_offset)
+void __might_resched(const char *file, int line, int preempt_offset)
 {
 	/* Ratelimiting timestamp: */
 	static unsigned long prev_jiffy;
@@ -9495,7 +9495,7 @@ void ___might_sleep(const char *file, in
 	dump_stack();
 	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 }
-EXPORT_SYMBOL(___might_sleep);
+EXPORT_SYMBOL(__might_resched);
 
 void __cant_sleep(const char *file, int line, int preempt_offset)
 {

