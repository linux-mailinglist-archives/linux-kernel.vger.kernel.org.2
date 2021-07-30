Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39713DBA4A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbhG3OVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239197AbhG3ORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B0FC061796
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:17:38 -0700 (PDT)
Message-ID: <20210730135206.809180862@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0I+0NzRDa//pv/4XVKzi2oPY0dVZvvZjXvv8LXC5GAw=;
        b=Tqf3bwr0b51si7XNitFuxeor59Q7Yy3N/smeLc1kOSEA4dJv/2ATmbZnXRNv/oIcsCstnr
        bpCgYi3m41CbBygzQJUXoo4Y33LSnYWfkr+f1n+yshn3JTxH8Tt+uggMUp8QHalH8iAqZi
        c3cIaGpCcA6N93aJ/vQ+v4CtvjzIZ69qLJGQd5hBMMYXXmsEQ3YgQVviXD9zZ7F4TIL6GJ
        2HdTMEW/r2t09MXeibyiehvAevacP1oe+N/QgPVKuotsuHypW31tTRCJIFmwig7fxj+9ug
        tMVSEz0qoDnGV7uUgyK0DEb04EAKKHG4FHYIK9TvBdDJSvTAYZA1HSMymKSdFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0I+0NzRDa//pv/4XVKzi2oPY0dVZvvZjXvv8LXC5GAw=;
        b=GVeD3mdqjMyzCgz57/2dKCgi0XKueTVGdJu2z57XIMSLzNoYFAR+3MQdN1pwAJG1vhImj3
        G8lYYQ7tkW6L+sDw==
Date:   Fri, 30 Jul 2021 15:50:36 +0200
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
Subject: [patch 29/63] locking/rtmutex: Provide the spin/rwlock core lock function
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

A simplified version of the rtmutex slowlock function which neither handles
signals nor timeouts and is careful about preserving the state of the
blocked task accross the lock operation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c        |   60 ++++++++++++++++++++++++++++++++++++++++
 kernel/locking/rtmutex_common.h |    2 -
 2 files changed, 61 insertions(+), 1 deletion(-)
---
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1410,3 +1410,63 @@ static __always_inline int __rt_mutex_lo
 	return rt_mutex_slowlock(lock, state);
 }
 #endif /* RT_MUTEX_BUILD_MUTEX */
+
+#ifdef RT_MUTEX_BUILD_SPINLOCKS
+/*
+ * Functions required for spin/rw_lock substitution on RT kernels
+ */
+
+/**
+ * rtlock_slowlock_locked - Slow path lock acquisition for RT locks
+ * @lock:	The underlying rt mutex
+ */
+static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
+{
+	struct rt_mutex_waiter waiter;
+
+	lockdep_assert_held(&lock->wait_lock);
+
+	if (try_to_take_rt_mutex(lock, current, NULL))
+		return;
+
+	rt_mutex_init_rtlock_waiter(&waiter);
+
+	/* Save current state and set state to TASK_RTLOCK_WAIT */
+	current_save_and_set_rtlock_wait_state();
+
+	task_blocks_on_rt_mutex(lock, &waiter, current, RT_MUTEX_MIN_CHAINWALK);
+
+	for (;;) {
+		/* Try to acquire the lock again. */
+		if (try_to_take_rt_mutex(lock, current, &waiter))
+			break;
+
+		raw_spin_unlock_irq(&lock->wait_lock);
+
+		schedule_rtlock();
+
+		raw_spin_lock_irq(&lock->wait_lock);
+		set_current_state(TASK_RTLOCK_WAIT);
+	}
+
+	/* Restore the task state */
+	current_restore_rtlock_saved_state();
+
+	/*
+	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We
+	 * might have to fix that up:
+	 */
+	fixup_rt_mutex_waiters(lock);
+	debug_rt_mutex_free_waiter(&waiter);
+}
+
+static __always_inline void __sched rtlock_slowlock(struct rt_mutex_base *lock)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	rtlock_slowlock_locked(lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+}
+
+#endif /* RT_MUTEX_BUILD_SPINLOCKS */
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -181,7 +181,7 @@ static inline void rt_mutex_init_waiter(
 	waiter->task = NULL;
 }
 
-static inline void rtlock_init_rtmutex_waiter(struct rt_mutex_waiter *waiter)
+static inline void rt_mutex_init_rtlock_waiter(struct rt_mutex_waiter *waiter)
 {
 	rt_mutex_init_waiter(waiter);
 	waiter->wake_state = TASK_RTLOCK_WAIT;

