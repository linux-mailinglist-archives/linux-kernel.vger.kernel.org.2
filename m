Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA703C7412
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbhGMQRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbhGMQQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E64DC0613EE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:13:41 -0700 (PDT)
Message-Id: <20210713160748.491632534@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=FF2mDtjpAJClhzQr3YiiQQhBtUm0P5Lh8hb/LfPwY9g=;
        b=mcEqdffvxcbEXOCFQoVC8uFdEiJsjv2iPmiAZ5RMKqTf54HFFT7qx7YYcxbjRqU/OD9aUV
        0TSMWqSxtcbE8bntqs6Ke37m85KhChfaD94bHgl9VLZZMP5QzrJ3BdnnnnUSGhwn15fkEB
        tP4ChsBC8xR2oaDWWE5+nTWnAgocme8wJ9QnKVZ2qVNzh+5a6DcN07Z8cch65VqHqBwJaE
        QQyw8JwR2WNM1kjLp5mPMZCSyxPxGBv6yMisBabhY7SJ9HyHZIqQb+0/5PzszmJSq5FbFe
        AErr8T35CsJEdZqSz1+l4UrsKcOqw5rLnPh1aEOGkHfimRXxLEDGnfYf+9XxPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=FF2mDtjpAJClhzQr3YiiQQhBtUm0P5Lh8hb/LfPwY9g=;
        b=uziTiC7fKda6K1nyGIsIOHpxLbxb8PGucAQniRmKRZzVdujxhkctbsfOmwHOb1a3dgnQZl
        fS1B0s7ddgEIZwBA==
Date:   Tue, 13 Jul 2021 17:11:20 +0200
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
Subject: [patch 26/50] locking/rtmutex: Provide the spin/rwlock core lock function
References: <20210713151054.700719949@linutronix.de>
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
 kernel/locking/rtmutex.c        | 60 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/locking/rtmutex_common.h |  2 +-
 2 files changed, 61 insertions(+), 1 deletion(-)
---
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2870a0654216..993ab1047fda 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1409,3 +1409,63 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex *lock,
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
+static void __sched rtlock_slowlock_locked(struct rt_mutex *lock)
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
+static __always_inline void __sched rtlock_slowlock(struct rt_mutex *lock)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	rtlock_slowlock_locked(lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+}
+
+#endif /* RT_MUTEX_BUILD_SPINLOCKS */
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 5ccb9a7f0f56..fecc839cf082 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -187,7 +187,7 @@ static inline void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 	waiter->task = NULL;
 }
 
-static inline void rtlock_init_rtmutex_waiter(struct rt_mutex_waiter *waiter)
+static inline void rt_mutex_init_rtlock_waiter(struct rt_mutex_waiter *waiter)
 {
 	rt_mutex_init_waiter(waiter);
 	waiter->wake_state = TASK_RTLOCK_WAIT;

