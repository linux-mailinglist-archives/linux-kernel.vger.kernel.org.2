Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1853E90C6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbhHKMZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:25:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50646 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbhHKMXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:32 -0400
Message-ID: <20210811121415.939671868@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UhZlfkZHli3kJViY0uXJXqXJyf0hkjx6ZecSBVuLjiI=;
        b=KnsCG8TBNv9UthkS1NQkO+HMBvpArUsvXwW4dqTrqF9e9DZmYg3ZfdnLdDFWhO9cYWYEu7
        tfWbcsUgr6404wzDZPPwf+iBYmFsJEGs/lklUV8+F9PGwPKqaika+SpdQ2S+Vzkc06uYGx
        vGrzHYAGRH5nImtHNVuP1c0X8SamEmoAVwmr2BcNzDfsLK1rEgwo+vgt3uK4Au2m/FqepE
        /pTkKZ/FNqUQSO6I/+eUhERTrMtS+ZlhVskwxy+69js9fmY29hy3bflf6HG9LOdGe8JAli
        rrE0T5wI0cJkFlliqjAblf/tHyyYfe4661wRz2rTywOpqXELzNBCAxG7loqTkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=UhZlfkZHli3kJViY0uXJXqXJyf0hkjx6ZecSBVuLjiI=;
        b=s/LiwXzad3F2R1MabW7wn5roJ0xkWoeDnwggIo3OcuElQXXpJyRmMrm/O59DN3PfC2t4KP
        Fi3nCJSqMWrFd4BQ==
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
Subject: [patch V4 30/68] locking/rtmutex: Provide the spin/rwlock core lock function
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:07 +0200 (CEST)
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

