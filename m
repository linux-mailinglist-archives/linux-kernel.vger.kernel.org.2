Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC603ECB36
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhHOVat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbhHOV3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92D2C0612A6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:28:28 -0700 (PDT)
Message-ID: <20210815211303.826621464@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=pI+FCnLtA7JG9BdX9454ZdKkEHSbsZeN7Xa8xXfUZAE=;
        b=hs6W5K/IFPaG6c+Q1gbctZ3k99qaiJEcOjQHZ24ad0H0RTOvNIn5R1+JyFCmFUxAhMDCs3
        WLGsiD21Et67+OBBN6J1eHK5YNL6UhxPG523Y5tXEgvyVLm22xGLyv0XM+M/elDk8fZf0w
        imZDihmf9lHCIypilrb0z+Mm3rvkPuKZlRBe0FPYRzkJuNz6eBilEIsAagid8mA9iTJni2
        sSRkPQZz3j8KYNDenfZF96o7FaJYRWOUI19PPB4k1dX8tImAVWpjbKkJG72PGQj0YfCQ8L
        dCobmRvBP77uC6nt0gooqowmtJ2/b5ISr37K6NU/6po2zHFphiEMs62cspdmPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=pI+FCnLtA7JG9BdX9454ZdKkEHSbsZeN7Xa8xXfUZAE=;
        b=X6UpkBcr3EI8zwHEQCXCKjI7ysne2JDdIu/CCEETwbvYmc79mkzXr0C2ZmHFo4IAw+Umab
        ESzjpnHuBVYoVkBw==
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
Subject: [patch V5 33/72] locking/spinlock: Provide RT variant
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:27 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Provide the actual locking functions which make use of the general and
spinlock specific rtmutex code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: Add missing might_sleep() and fix lockdep init (Sebastian)
---
 kernel/locking/Makefile      |    1 
 kernel/locking/spinlock_rt.c |  129 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)
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
@@ -0,0 +1,129 @@
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
+ * - Non RT spin/rw_locks disable preemption and eventually interrupts.
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
+	___might_sleep(__FILE__, __LINE__, 0);
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
+	lockdep_init_map_wait(&lock->dep_map, name, key, 0, LD_WAIT_CONFIG);
+}
+EXPORT_SYMBOL(__rt_spin_lock_init);
+#endif

