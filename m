Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADC33E186D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbhHEPoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:44:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44026 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbhHEPmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:07 -0400
Message-ID: <20210805153954.622918900@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Tf26PRhic8P67fcxzWEwGhStC6LCenZ+7/8JaPvRInA=;
        b=KoQDsmLRTSSKSHL/xv028v/bOyu/+7zZIEGvUK0XehiBbJIZgU/B0GqbRkm1uAsn6ZkWNZ
        MoRDOtyLtG9gPMxOy8T2uT3MtZPeQ0ZFYYeuLYjQd6RgTnfH21a4exaUetyXiURr2g40YJ
        ZcKJyNr5R+ADloKfD0nLR1zJPyIeOOq+QOb7m/xBseiXLtkg05YNURdq/Aj+LovPb+M+wG
        EDxzXewflGWPBKueP65Vh1MHmsuQsTcNFgLtyBeKvf+FFkSLFvRqKz4K2PU2oMs81EGHVQ
        nmcyMlj4Lij2YFHcvz09m5F6hwqXL33kTKQOn1eKZDqs4Ec9hd7sC6JCuIdF8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Tf26PRhic8P67fcxzWEwGhStC6LCenZ+7/8JaPvRInA=;
        b=DOcQ1DHBxYtH65vuODCS+eauV6NUxH6Y9zRMc0+1bZClvrGAOa/c9va32FPr8FndJZZEpw
        Lpa/Q2sQJKbgGbCw==
Date:   Thu, 05 Aug 2021 17:13:31 +0200
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
Subject: [patch V3 31/64] locking/spinlock: Provide RT variant
References: <20210805151300.330412127@linutronix.de>
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

