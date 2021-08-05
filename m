Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCE43E186A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242105AbhHEPn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:43:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44008 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242415AbhHEPmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:05 -0400
Message-ID: <20210805153954.562944225@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UhZlfkZHli3kJViY0uXJXqXJyf0hkjx6ZecSBVuLjiI=;
        b=pzARmaYsGgXAes3z/A3sZFwR0Kvcuu4MNGyRWfRFO4P40itjTa822USG7mePFyCia+62lZ
        ltPPI8Hp4ozJYA5sL95ARrjyLZYvuz5uhWhnTRkkh7uqg3NckQo1yj8H/0vSup7NwK3Inc
        EkjpvgrmKCPMoilfgDbulIFG93/ENA1dyoyrZgLI0Y3QjPCVxjr0p6fvoW8NfHm+TPQxZ3
        wVCxyEgyFUdwMjapgwN2JlNZLRGLa4gErGHBl8Hk5uCuIobACOr628RwhptXl8RS/RvVsN
        l2aacwtDlJzUa+h4j6Bc15TwzE8HdgLode0bPpX+oZmqvHvrqfGwUYZbKCjqdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UhZlfkZHli3kJViY0uXJXqXJyf0hkjx6ZecSBVuLjiI=;
        b=uYTHJihulr0VBYugVUh5XPR0gzfq+/72Kw0LfKaUvKAR1btAWeHdMSJufy+vmL3X8NVIny
        J0Y4RM538h/brWCw==
Date:   Thu, 05 Aug 2021 17:13:30 +0200
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
Subject: [patch V3 30/64] locking/rtmutex: Provide the spin/rwlock core lock function
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

A simplified version of the rtmutex slowlock function which neither handles
signals nor timeouts and is careful about preserving the state of the
blocked task across the lock operation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c        |   60 ++++++++++++++++++++++++++++++++++++++++
 kernel/locking/rtmutex_common.h |    2 -
 2 files changed, 61 insertions(+), 1 deletion(-)
---
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1416,3 +1416,63 @@ static __always_inline int __rt_mutex_lo
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

