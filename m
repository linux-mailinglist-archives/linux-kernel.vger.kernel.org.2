Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F833E188C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242726AbhHEPoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242321AbhHEPmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345F7C0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 08:42:01 -0700 (PDT)
Message-ID: <20210805153954.907103364@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=c+cIgWlDnQ3aXQKTbRULUcUjU6RPX7YqzdNEVN2AsQY=;
        b=O5H/4mVV12233pYxvq6q+tnv55wnOYRrdy8RAiIYpHAssMBA7B61OsM9eLwyQTGA9RMkYR
        ec04w8X3uIXQilYoryWd3qF5wjpNcbc7IrI95AGuUgF1VOu4knTalPtEZX6Mod5pCTQ3w6
        B3jnhfZ5k1FKW204JElgN8RPNYc/epFMdncNzUO5+2BjtyCgedUQleE8db0wgXadg2b4ti
        SBJz1S9UlSmCDQuYA046ak3PVSRBZFZdVSH65XOQCaN/LiaZB/irfuKaVI4FJfiSGxHgte
        FIVs+g6ppyF4YCL/T29B1VqCnJN0ommFY4sAcbFSa2FQJIlDhlZDdHpMbBkoqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=c+cIgWlDnQ3aXQKTbRULUcUjU6RPX7YqzdNEVN2AsQY=;
        b=FCWusfZiEgOmTgi4yXbXLSUgqtb2BT4IsUV/909rR+e8okxahpmR5RlbcE3UWVzd+Pq1Ax
        tpsc0Kx7fm3xa2AQ==
Date:   Thu, 05 Aug 2021 17:13:36 +0200
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
Subject: [patch V3 36/64] locking/mutex: Make mutex::wait_lock raw
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The wait_lock of mutex is really a low level lock. Convert it to a
raw_spinlock like the wait_lock of rtmutex.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mutex.h  |    4 ++--
 kernel/locking/mutex.c |   22 +++++++++++-----------
 2 files changed, 13 insertions(+), 13 deletions(-)
---
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
@@ -487,9 +487,9 @@ ww_mutex_set_context_fastpath(struct ww_
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
@@ -964,7 +964,7 @@ static __always_inline int __sched
 		return 0;
 	}
 
-	spin_lock(&lock->wait_lock);
+	raw_spin_lock(&lock->wait_lock);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -1028,7 +1028,7 @@ static __always_inline int __sched
 				goto err;
 		}
 
-		spin_unlock(&lock->wait_lock);
+		raw_spin_unlock(&lock->wait_lock);
 		schedule_preempt_disabled();
 
 		/*
@@ -1051,9 +1051,9 @@ static __always_inline int __sched
 		    (first && mutex_optimistic_spin(lock, ww_ctx, &waiter)))
 			break;
 
-		spin_lock(&lock->wait_lock);
+		raw_spin_lock(&lock->wait_lock);
 	}
-	spin_lock(&lock->wait_lock);
+	raw_spin_lock(&lock->wait_lock);
 acquired:
 	__set_current_state(TASK_RUNNING);
 
@@ -1078,7 +1078,7 @@ static __always_inline int __sched
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
-	spin_unlock(&lock->wait_lock);
+	raw_spin_unlock(&lock->wait_lock);
 	preempt_enable();
 	return 0;
 
@@ -1086,7 +1086,7 @@ static __always_inline int __sched
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
-	spin_unlock(&lock->wait_lock);
+	raw_spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
 	preempt_enable();
@@ -1255,7 +1255,7 @@ static noinline void __sched __mutex_unl
 		owner = old;
 	}
 
-	spin_lock(&lock->wait_lock);
+	raw_spin_lock(&lock->wait_lock);
 	debug_mutex_unlock(lock);
 	if (!list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
@@ -1272,7 +1272,7 @@ static noinline void __sched __mutex_unl
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
-	spin_unlock(&lock->wait_lock);
+	raw_spin_unlock(&lock->wait_lock);
 
 	wake_up_q(&wake_q);
 }

