Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289483C741A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbhGMQRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54372 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhGMQQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:38 -0400
Message-Id: <20210713160749.071380596@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=elwT5t+pzooM4E97Vb3k27mIhbT4w6Kj6oGs71SqCtg=;
        b=M+d9bxnRambqcZjRty+Lbf1v3QbCm6gSPxC17sr4zB3PpKPSMUHE/RtHX6GAP65j1yEhn2
        2rteeoMVEIToPbQfPRMou7+RWSNsXcQOiV1WWV/HT2a7ILK18fg0G2FizKLumGEpAH2Vbe
        eiQzRko5k4tAF0OPq+wnBLV+DDtlA/jJCXnjqIIKz4utbbrMfUqVbziom06AA1AlWF90ws
        jajrTtugpiUPJ9CcQ/Uzd6I7/OiYgXU/7MbxeNVYyBriv/tHMBXyCEdTjywN9srI6RQSyL
        i5PsH4+FYZJrIC2UHHzQVhHa/kX2wll2egxbwy1q+H/gbKBYk4NRIUgwZOIfEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=elwT5t+pzooM4E97Vb3k27mIhbT4w6Kj6oGs71SqCtg=;
        b=+Y1qIXSXLY8vBUVbGow/N5yonVlcOfHtaZG7HqJ7c+3YjENDIPg9AFkYpGzQbAi3J1JHux
        GfEnrl7P+kwEkbCQ==
Date:   Tue, 13 Jul 2021 17:11:26 +0200
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
Subject: [patch 32/50] locking/mutex: Make mutex::wait_lock raw
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

PREEMPT_RT wants to utilize the existing ww_mutex implementation instead of
trying to mangle ww_mutex functionality into the rtmutex based mutex
implementation. The mutex internal wait_lock is a regular spinlock which
would be converted to a sleeping spinlock on RT, but that's not really
required because the wait_lock held times are short and limited.

Convert it to a raw_spinlock like the wait_lock of rtmutex.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mutex.h  |  4 ++--
 kernel/locking/mutex.c | 22 +++++++++++-----------
 2 files changed, 13 insertions(+), 13 deletions(-)
---
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index db3367586a06..0bbc872ba72b 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -50,7 +50,7 @@
  */
 struct mutex {
 	atomic_long_t		owner;
-	spinlock_t		wait_lock;
+	raw_spinlock_t		wait_lock;
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 	struct optimistic_spin_queue osq; /* Spinner MCS lock */
 #endif
@@ -105,7 +105,7 @@ do {									\
 
 #define __MUTEX_INITIALIZER(lockname) \
 		{ .owner = ATOMIC_LONG_INIT(0) \
-		, .wait_lock = __SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
+		, .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
 		, .wait_list = LIST_HEAD_INIT(lockname.wait_list) \
 		__DEBUG_MUTEX_INITIALIZER(lockname) \
 		__DEP_MAP_MUTEX_INITIALIZER(lockname) }
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 68723b49c22e..16360787aa47 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -36,7 +36,7 @@ void
 __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
 {
 	atomic_long_set(&lock->owner, 0);
-	spin_lock_init(&lock->wait_lock);
+	raw_spin_lock_init(&lock->wait_lock);
 	INIT_LIST_HEAD(&lock->wait_list);
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 	osq_lock_init(&lock->osq);
@@ -487,9 +487,9 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * Uh oh, we raced in fastpath, check if any of the waiters need to
 	 * die or wound us.
 	 */
-	spin_lock(&lock->base.wait_lock);
+	raw_spin_lock(&lock->base.wait_lock);
 	__ww_mutex_check_waiters(&lock->base, ctx);
-	spin_unlock(&lock->base.wait_lock);
+	raw_spin_unlock(&lock->base.wait_lock);
 }
 
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
@@ -964,7 +964,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		return 0;
 	}
 
-	spin_lock(&lock->wait_lock);
+	raw_spin_lock(&lock->wait_lock);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -1028,7 +1028,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 				goto err;
 		}
 
-		spin_unlock(&lock->wait_lock);
+		raw_spin_unlock(&lock->wait_lock);
 		schedule_preempt_disabled();
 
 		/*
@@ -1051,9 +1051,9 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		    (first && mutex_optimistic_spin(lock, ww_ctx, &waiter)))
 			break;
 
-		spin_lock(&lock->wait_lock);
+		raw_spin_lock(&lock->wait_lock);
 	}
-	spin_lock(&lock->wait_lock);
+	raw_spin_lock(&lock->wait_lock);
 acquired:
 	__set_current_state(TASK_RUNNING);
 
@@ -1078,7 +1078,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
-	spin_unlock(&lock->wait_lock);
+	raw_spin_unlock(&lock->wait_lock);
 	preempt_enable();
 	return 0;
 
@@ -1086,7 +1086,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
-	spin_unlock(&lock->wait_lock);
+	raw_spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
 	preempt_enable();
@@ -1255,7 +1255,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		owner = old;
 	}
 
-	spin_lock(&lock->wait_lock);
+	raw_spin_lock(&lock->wait_lock);
 	debug_mutex_unlock(lock);
 	if (!list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
@@ -1272,7 +1272,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
-	spin_unlock(&lock->wait_lock);
+	raw_spin_unlock(&lock->wait_lock);
 
 	wake_up_q(&wake_q);
 }

