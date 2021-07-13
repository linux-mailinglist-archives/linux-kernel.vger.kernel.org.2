Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668EC3C7413
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhGMQRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54372 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbhGMQQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:32 -0400
Message-Id: <20210713160748.585453340@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=FziQpiKuLp4N8yuPVAA/BQDHmS1OSWMemZdV4Q8byiI=;
        b=u4JuW5qoXVmBX/TY/UnM5zwJyUMiGjsOR7PzW1J1IaWCDn8RRZkbZpr+MnSzigez7XDWUo
        J78I6JM39zc17gA523pW7adHbi55xAFTpxc8AVj1O8lEcFvVjH/tRCNcxi8okip7OWm+li
        zFhJkOGE5iAa2SXwOVn/IT2DmadexYbs0dam1EY0va9VWaTTkVGdyRK+Z6kLlsLMeepdFQ
        y+/zyld67MEUg4hpVIRGj+x3pPjwwIZTSVQ2clXoI5IuV70nysSX0tljzPPdoux0gxY2Kv
        f8aE1wRXwXo9upjTtkpZW0jgkKwjJRsuKv4TZ+gceYXFUAw+f7efFtxzXJLyZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=FziQpiKuLp4N8yuPVAA/BQDHmS1OSWMemZdV4Q8byiI=;
        b=+O+NOyiugpOhUxpRRaFjmw/rIjbXrJjGA2ZsOW+ZotMNmUPRSpa8mipuW/EOxQhAu7ETkw
        YxM7uFFT/J0wM3Bw==
Date:   Tue, 13 Jul 2021 17:11:21 +0200
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
Subject: [patch 27/50] locking/spinlock: Provide RT variant
References: <20210713151054.700719949@linutronix.de>
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
 kernel/locking/Makefile      |   1 +-
 kernel/locking/spinlock_rt.c | 128 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 129 insertions(+)
 create mode 100644 kernel/locking/spinlock_rt.c
---
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 269f55e1e431..683f0b7fbacc 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_LOCK_SPIN_ON_OWNER) += osq_lock.o
 obj-$(CONFIG_PROVE_LOCKING) += spinlock.o
 obj-$(CONFIG_QUEUED_SPINLOCKS) += qspinlock.o
 obj-$(CONFIG_RT_MUTEXES) += rtmutex_api.o
+obj-$(CONFIG_PREEMPT_RT) += spinlock_rt.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock_debug.o
 obj-$(CONFIG_QUEUED_RWLOCKS) += qrwlock.o
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
new file mode 100644
index 000000000000..0abc06d6092f
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
+static __always_inline void rtlock_lock(struct rt_mutex *rtm)
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

