Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8D346B41
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhCWVlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbhCWVjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:39:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC57C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:39:47 -0700 (PDT)
Message-Id: <20210323213708.001857655@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616535586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=V5ckO608TB8rf5CzfVyKefdgOoJ9ih05IR74Fj6BTS8=;
        b=zAcFCsLXSgPMmFcyfPgy+7zLbd2dJLG6ArFKH0IrtUJiU36ibofi+AiXBPw82glgDAQS7e
        MPiehuBjvhg4uHdysYiJM6Svd/onU9U6j7F3RfV3ZYvZHAOHCJTrDa+GRB4RiKO20XcIUA
        vH4JUsk/DXTM29GfkYtc5/1S9vWKv4WhSf66x7X5NU9QsgBR3DYiWhA/TyJ/pqM31DNnkL
        YfyZQyG0D3aYEc0Gv9wbrzf6OlomSAo029Am1HUVkIQ0cNtRmLjrT51jJo1QFBAvd9L2u2
        TWFrzH+vd8mBYrzMzSxcuDqBmIz2+YRJTmmsjuisgR/s18ol34lyY0UFLXNkkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616535586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=V5ckO608TB8rf5CzfVyKefdgOoJ9ih05IR74Fj6BTS8=;
        b=QjUlshgU73vW32E/VEclhNtdgWkQBRJjQPdu7H3CaNM0CeWz1b6x7RhyxE/1pMUznawBuR
        l47sLmuDpgYwVLCA==
Date:   Tue, 23 Mar 2021 22:30:24 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 05/14] locking/rtmutex: Remove empty and unused debug stubs
References: <20210323213019.217008708@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users just ballast.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rtmutex.h        |   14 ++------------
 kernel/locking/rtmutex-debug.c |    9 ---------
 kernel/locking/rtmutex.c       |   17 -----------------
 kernel/locking/rtmutex.h       |    2 --
 4 files changed, 2 insertions(+), 40 deletions(-)

--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -40,18 +40,9 @@ struct rt_mutex_waiter;
 struct hrtimer_sleeper;
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
- extern int rt_mutex_debug_check_no_locks_freed(const void *from,
-						unsigned long len);
- extern void rt_mutex_debug_check_no_locks_held(struct task_struct *task);
- extern void rt_mutex_debug_task_free(struct task_struct *tsk);
+extern void rt_mutex_debug_task_free(struct task_struct *tsk);
 #else
- static inline int rt_mutex_debug_check_no_locks_freed(const void *from,
-						       unsigned long len)
- {
-	return 0;
- }
-# define rt_mutex_debug_check_no_locks_held(task)	do { } while (0)
-# define rt_mutex_debug_task_free(t)			do { } while (0)
+static inline void rt_mutex_debug_task_free(struct task_struct *tsk) { }
 #endif
 
 #define rt_mutex_init(mutex) \
@@ -88,7 +79,6 @@ static inline int rt_mutex_is_locked(str
 }
 
 extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
-extern void rt_mutex_destroy(struct rt_mutex *lock);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass);
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -38,20 +38,11 @@ void rt_mutex_debug_task_free(struct tas
 	DEBUG_LOCKS_WARN_ON(task->pi_blocked_on);
 }
 
-void debug_rt_mutex_lock(struct rt_mutex *lock)
-{
-}
-
 void debug_rt_mutex_unlock(struct rt_mutex *lock)
 {
 	DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current);
 }
 
-void
-debug_rt_mutex_proxy_lock(struct rt_mutex *lock, struct task_struct *powner)
-{
-}
-
 void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock)
 {
 	DEBUG_LOCKS_WARN_ON(!rt_mutex_owner(lock));
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -885,9 +885,6 @@ static int try_to_take_rt_mutex(struct r
 	raw_spin_unlock(&task->pi_lock);
 
 takeit:
-	/* We got the lock. */
-	debug_rt_mutex_lock(lock);
-
 	/*
 	 * This either preserves the RT_MUTEX_HAS_WAITERS bit if there
 	 * are still waiters or clears it.
@@ -1581,20 +1578,6 @@ void __sched rt_mutex_futex_unlock(struc
 }
 
 /**
- * rt_mutex_destroy - mark a mutex unusable
- * @lock: the mutex to be destroyed
- *
- * This function marks the mutex uninitialized, and any subsequent
- * use of the mutex is forbidden. The mutex must not be locked when
- * this function is called.
- */
-void rt_mutex_destroy(struct rt_mutex *lock)
-{
-	WARN_ON(rt_mutex_is_locked(lock));
-}
-EXPORT_SYMBOL_GPL(rt_mutex_destroy);
-
-/**
  * __rt_mutex_init - initialize the rt_mutex
  *
  * @lock:	The rt_mutex to be initialized
--- a/kernel/locking/rtmutex.h
+++ b/kernel/locking/rtmutex.h
@@ -13,8 +13,6 @@
 
 #define debug_rt_mutex_init_waiter(w)			do { } while (0)
 #define debug_rt_mutex_free_waiter(w)			do { } while (0)
-#define debug_rt_mutex_lock(l)				do { } while (0)
-#define debug_rt_mutex_proxy_lock(l,p)			do { } while (0)
 #define debug_rt_mutex_proxy_unlock(l)			do { } while (0)
 #define debug_rt_mutex_unlock(l)			do { } while (0)
 #define debug_rt_mutex_init(m, n, k)			do { } while (0)

