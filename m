Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45F03DBA57
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbhG3OVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239198AbhG3ORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A67C061798
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:17:40 -0700 (PDT)
Message-ID: <20210730135206.865728220@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=znxSzez5VUkabXTQ/VNC+Hl/M6UicmM7e594Xaf6Grg=;
        b=FYngdz0fmroM3uImZFM1+U4MuQmqKW4TQJ4PWcytMQz0QwU3dJ6mRBUKmjXJsSK6zhJed/
        85fIopn9E88YpRdLDhOq6WP/n/9Fw2+jPdck0giGMr6H/s5mKgoj8cMoMqbgYav0iFsIxr
        EGCrDa41lGmpP6yo52Pc7bZrrkwr2aAdoM7WxssukTsCwJEQgiGIIwhNNUOl9YzOWk/KrC
        9r2OGex+SrrM+PKTRbEgT1P2govtod9RexeLJul8ZcwozOuXhBdxEFQGA1C623/TdVHGKd
        rXyVrosiV0tWps8AXjXa4yLSYcZlE7Dqf+3NzkyJoBeWMWlWlxWaHaS+0nBw1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=znxSzez5VUkabXTQ/VNC+Hl/M6UicmM7e594Xaf6Grg=;
        b=+ECFPlTSkh8NEDJQxoKETS9H72MVlI9d8IZNi220x3ngg8Bnb84HKOP5LCGhWQfphKkAG1
        KpNWSzXwjQE+1xDw==
Date:   Fri, 30 Jul 2021 15:50:37 +0200
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
Subject: [patch 30/63] locking/spinlock: Provide RT variant
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Provide the actual locking functions which make use of the general and
spinlock specific rtmutex code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/Makefile      |    1 
 kernel/locking/spinlock_rt.c |  128 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)
 create mode 100644 kernel/locking/spinlock_rt.c
---
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_LOCK_SPIN_ON_OWNER) += osq_
 obj-$(CONFIG_PROVE_LOCKING) += spinlock.o
 obj-$(CONFIG_QUEUED_SPINLOCKS) += qspinlock.o
 obj-$(CONFIG_RT_MUTEXES) += rtmutex_api.o
+obj-$(CONFIG_PREEMPT_RT) += spinlock_rt.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock_debug.o
 obj-$(CONFIG_QUEUED_RWLOCKS) += qrwlock.o
--- /dev/null
+++ b/kernel/locking/spinlock_rt.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PREEMPT_RT substitution for spin/rw_locks
+ *
+ * spin_lock and rw_lock on RT are based on rtmutex with a few twists to
+ * resemble the non RT semantics
+ *
+ * - Contrary to a plain rtmutex, spin_lock and rw_lock are state
+ *   preserving. The task state is saved before blocking on the underlying
+ *   rtmutex and restored when the lock has been acquired. Regular wakeups
+ *   during that time are redirected to the saved state so no wake up is
+ *   missed.
+ *
+ * - Non RT spin/rw_locks disable preemption and evtl. interrupts.
+ *   Disabling preemption has the side effect of disabling migration and
+ *   preventing RCU grace periods.
+ *
+ *   The RT substitutions explicitly disable migration and take
+ *   rcu_read_lock() across the lock held section.
+ */
+#include <linux/spinlock.h>
+#include <linux/export.h>
+
+#define RT_MUTEX_BUILD_SPINLOCKS
+#include "rtmutex.c"
+
+static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
+{
+	if (unlikely(!rt_mutex_cmpxchg_acquire(rtm, NULL, current)))
+		rtlock_slowlock(rtm);
+}
+
+static __always_inline void __rt_spin_lock(spinlock_t *lock)
+{
+	rtlock_lock(&lock->lock);
+	rcu_read_lock();
+	migrate_disable();
+}
+
+void __sched rt_spin_lock(spinlock_t *lock)
+{
+	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	__rt_spin_lock(lock);
+}
+EXPORT_SYMBOL(rt_spin_lock);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void __sched rt_spin_lock_nested(spinlock_t *lock, int subclass)
+{
+	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	__rt_spin_lock(lock);
+}
+EXPORT_SYMBOL(rt_spin_lock_nested);
+
+void __sched rt_spin_lock_nest_lock(spinlock_t *lock,
+				    struct lockdep_map *nest_lock)
+{
+	spin_acquire_nest(&lock->dep_map, 0, 0, nest_lock, _RET_IP_);
+	__rt_spin_lock(lock);
+}
+EXPORT_SYMBOL(rt_spin_lock_nest_lock);
+#endif
+
+void __sched rt_spin_unlock(spinlock_t *lock)
+{
+	spin_release(&lock->dep_map, _RET_IP_);
+	migrate_enable();
+	rcu_read_unlock();
+
+	if (unlikely(!rt_mutex_cmpxchg_release(&lock->lock, current, NULL)))
+		rt_mutex_slowunlock(&lock->lock);
+}
+EXPORT_SYMBOL(rt_spin_unlock);
+
+/*
+ * Wait for the lock to get unlocked: instead of polling for an unlock
+ * (like raw spinlocks do), lock and unlock, to force the kernel to
+ * schedule if there's contention:
+ */
+void __sched rt_spin_lock_unlock(spinlock_t *lock)
+{
+	spin_lock(lock);
+	spin_unlock(lock);
+}
+EXPORT_SYMBOL(rt_spin_lock_unlock);
+
+static __always_inline int __rt_spin_trylock(spinlock_t *lock)
+{
+	int ret = 1;
+
+	if (unlikely(!rt_mutex_cmpxchg_acquire(&lock->lock, NULL, current)))
+		ret = rt_mutex_slowtrylock(&lock->lock);
+
+	if (ret) {
+		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		rcu_read_lock();
+		migrate_disable();
+	}
+	return ret;
+}
+
+int __sched rt_spin_trylock(spinlock_t *lock)
+{
+	return __rt_spin_trylock(lock);
+}
+EXPORT_SYMBOL(rt_spin_trylock);
+
+int __sched rt_spin_trylock_bh(spinlock_t *lock)
+{
+	int ret;
+
+	local_bh_disable();
+	ret = __rt_spin_trylock(lock);
+	if (!ret)
+		local_bh_enable();
+	return ret;
+}
+EXPORT_SYMBOL(rt_spin_trylock_bh);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void __rt_spin_lock_init(spinlock_t *lock, const char *name,
+			 struct lock_class_key *key)
+{
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
+	lockdep_init_map(&lock->dep_map, name, key, 0);
+}
+EXPORT_SYMBOL(__rt_spin_lock_init);
+#endif

