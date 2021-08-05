Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7348B3E1883
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242563AbhHEPpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:45:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44336 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242303AbhHEPmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:38 -0400
Message-ID: <20210805153955.768030288@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uXhYOMJoqtTs1PguhafTj/FT22yU/ibrWitJB1/+E3U=;
        b=kho8VMBgAHaCIC7NJSFeszbnrOVb8/zbss0ghdjURSf4FOSa1pMKcCmXXZvwPnkZSCASGw
        +vRAYw39LGQJ7ZKUixn2M+iCuqqM1gpomdXtP99gqdOfY5JMCt0C+GikBRfZ2ihuXbnlzI
        Z3zeKtoE7oAY8Ocorqcor54HixbAZd6DsM2jm+YfFVE5hxZzgXbArsUlRh6U/Rk0jQwTL4
        MSrD38XYPqmxzanz9pgSQ6fs21y9nyZoEi7W8DtYo0SINYZTvbf4004558Pe4soBLfcAk+
        aS4nwIyIKEnxyI+8Vt79ntAlDXKZmricSczugDY/xAd1mR7g/WQnZuuadYUrgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uXhYOMJoqtTs1PguhafTj/FT22yU/ibrWitJB1/+E3U=;
        b=UxBKvQ7diy5UoTNv+sj2wVlxXa9EvjCv5G5eAl/EK/wPKQXVBS5VAK404kP1eGqUdfqIjA
        fWGcdsjeARS1zIDw==
Date:   Thu, 05 Aug 2021 17:13:51 +0200
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
Subject: [patch V3 51/64] locking/ww_mutex: Implement rtmutex based ww_mutex
 API functions
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Add the actual ww_mutex API functions which replace the mutex based variant
on RT enabled kernels.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Make lock_interruptible interruptible for real (Mike)
---
 kernel/locking/Makefile      |    2 -
 kernel/locking/ww_rt_mutex.c |   76 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletion(-)
---
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_LOCK_SPIN_ON_OWNER) += osq_
 obj-$(CONFIG_PROVE_LOCKING) += spinlock.o
 obj-$(CONFIG_QUEUED_SPINLOCKS) += qspinlock.o
 obj-$(CONFIG_RT_MUTEXES) += rtmutex_api.o
-obj-$(CONFIG_PREEMPT_RT) += spinlock_rt.o
+obj-$(CONFIG_PREEMPT_RT) += spinlock_rt.o ww_rt_mutex.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock_debug.o
 obj-$(CONFIG_QUEUED_RWLOCKS) += qrwlock.o
--- /dev/null
+++ b/kernel/locking/ww_rt_mutex.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * rtmutex API
+ */
+#include <linux/spinlock.h>
+#include <linux/export.h>
+
+#define RT_MUTEX_BUILD_MUTEX
+#define WW_RT
+#include "rtmutex.c"
+
+static int __sched
+__ww_rt_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx,
+		   unsigned int state, unsigned long ip)
+{
+	struct lockdep_map __maybe_unused *nest_lock = NULL;
+	struct rt_mutex *rtm = &lock->base;
+	int ret;
+
+	might_sleep();
+
+	if (ww_ctx) {
+		if (unlikely(ww_ctx == READ_ONCE(lock->ctx)))
+			return -EALREADY;
+
+		/*
+		 * Reset the wounded flag after a kill. No other process can
+		 * race and wound us here since they can't have a valid owner
+		 * pointer if we don't have any locks held.
+		 */
+		if (ww_ctx->acquired == 0)
+			ww_ctx->wounded = 0;
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+		nest_lock = &ww_ctx->dep_map;
+#endif
+	}
+	mutex_acquire_nest(&rtm->dep_map, 0, 0, nest_lock, ip);
+
+	if (likely(rt_mutex_cmpxchg_acquire(&rtm->rtmutex, NULL, current))) {
+		if (ww_ctx)
+			ww_mutex_set_context_fastpath(lock, ww_ctx);
+		return 0;
+	}
+
+	ret = rt_mutex_slowlock(&rtm->rtmutex, ww_ctx, state);
+
+	if (ret)
+		mutex_release(&rtm->dep_map, ip);
+	return ret;
+}
+
+int __sched
+ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
+{
+	return __ww_rt_mutex_lock(lock, ctx, TASK_UNINTERRUPTIBLE, _RET_IP_);
+}
+EXPORT_SYMBOL(ww_mutex_lock);
+
+int __sched
+ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
+{
+	return __ww_rt_mutex_lock(lock, ctx, TASK_INTERRUPTIBLE, _RET_IP_);
+}
+EXPORT_SYMBOL(ww_mutex_lock_interruptible);
+
+void __sched ww_mutex_unlock(struct ww_mutex *lock)
+{
+	struct rt_mutex *rtm = &lock->base;
+
+	__ww_mutex_unlock(lock);
+
+	mutex_release(&rtm->dep_map, _RET_IP_);
+	__rt_mutex_unlock(&rtm->rtmutex);
+}
+EXPORT_SYMBOL(ww_mutex_unlock);

