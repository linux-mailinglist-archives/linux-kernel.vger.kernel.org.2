Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6483DBA70
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbhG3OW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:22:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56212 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbhG3OSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:18:25 -0400
Message-ID: <20210730135208.691612668@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=EMwGRcY8RvXr6JjSs+RtaU5AQSasgUEmDuYASR2ZIq8=;
        b=BWkax6fvdyZkTTkt2qFBSymvsbsAip3g6LbRKAObsOrKmvAYulR0+KWjSuP6oStf3k5QAG
        N2bPV7sLYut6qRuhEOJHAamgWx8RwDWAS69wKpKuD/zwvf1QG7A+ujC3Bf3LfvEod2mn8+
        ZXvWLlshk0Un/iivL/urQ+i0d+jL46weCyN2g37TL/WP1H8EuPyLJs79gxJUHMIt+Cde6r
        5pRS/omIolc7UYXcmapggxpd19V2RiOyR2rXWodDVGXcwLFYnOeHQPgGZ5LFdscerfCcYh
        IHSNoYdjvnIAgnkql7uT67Z5P6YHgyFKsS8yYMmzpw/6HhwQ0SnT+Wu604tRTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=EMwGRcY8RvXr6JjSs+RtaU5AQSasgUEmDuYASR2ZIq8=;
        b=LckeqWr9LUrLBhUFlaXTuKwF6y7YIyn+Bv6mR3j1YAZTv+80ZzO5NEL1ad2juHpcyyScmY
        9D2kw5nyYRdUFNDg==
Date:   Fri, 30 Jul 2021 15:51:10 +0200
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
Subject: [patch 63/63] locking/rtmutex: Use adaptive spinwait for all rtmutex
 based locks
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to restrict adaptive spinwait to the rt mutex based
'spinlocks'. Testing on RT shows a 4x impromevemt for hackbench.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
---
 kernel/locking/rtmutex.c |   84 +++++++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 39 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1277,6 +1277,43 @@ static __always_inline void __rt_mutex_u
 	rt_mutex_slowunlock(lock);
 }
 
+#ifdef CONFIG_SMP
+/*
+ * Note that owner is a speculative pointer and dereferencing relies
+ * on rcu_read_lock() and the check against the lock owner.
+ */
+static bool rtmutex_adaptive_spinwait(struct rt_mutex_base *lock,
+				     struct task_struct *owner)
+{
+	bool res = true;
+
+	rcu_read_lock();
+	for (;;) {
+		/* Owner changed. Trylock again */
+		if (owner != rt_mutex_owner(lock))
+			break;
+		/*
+		 * Ensure that owner->on_cpu is dereferenced _after_
+		 * checking the above to be valid.
+		 */
+		barrier();
+		if (!owner->on_cpu) {
+			res = false;
+			break;
+		}
+		cpu_relax();
+	}
+	rcu_read_unlock();
+	return res;
+}
+#else
+static bool rtmutex_adaptive_spinwait(struct rt_mutex_base *lock,
+				     struct task_struct *owner)
+{
+	return false;
+}
+#endif
+
 #ifdef RT_MUTEX_BUILD_MUTEX
 /*
  * Functions required for:
@@ -1361,6 +1398,7 @@ static int __sched rt_mutex_slowlock_blo
 					   struct rt_mutex_waiter *waiter)
 {
 	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
+	struct task_struct *owner;
 	int ret = 0;
 
 	for (;;) {
@@ -1383,9 +1421,14 @@ static int __sched rt_mutex_slowlock_blo
 				break;
 		}
 
+		if (waiter == rt_mutex_top_waiter(lock))
+			owner = rt_mutex_owner(lock);
+		else
+			owner = NULL;
 		raw_spin_unlock_irq(&lock->wait_lock);
 
-		schedule();
+		if (!owner || !rtmutex_adaptive_spinwait(lock, owner))
+			schedule();
 
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(state);
@@ -1534,43 +1577,6 @@ static __always_inline int __rt_mutex_lo
  * Functions required for spin/rw_lock substitution on RT kernels
  */
 
-#ifdef CONFIG_SMP
-/*
- * Note that owner is a speculative pointer and dereferencing relies
- * on rcu_read_lock() and the check against the lock owner.
- */
-static bool rtlock_adaptive_spinwait(struct rt_mutex_base *lock,
-				     struct task_struct *owner)
-{
-	bool res = true;
-
-	rcu_read_lock();
-	for (;;) {
-		/* Owner changed. Trylock again */
-		if (owner != rt_mutex_owner(lock))
-			break;
-		/*
-		 * Ensure that owner->on_cpu is dereferenced _after_
-		 * checking the above to be valid.
-		 */
-		barrier();
-		if (!owner->on_cpu) {
-			res = false;
-			break;
-		}
-		cpu_relax();
-	}
-	rcu_read_unlock();
-	return res;
-}
-#else
-static bool rtlock_adaptive_spinwait(struct rt_mutex_base *lock,
-				     struct task_struct *owner)
-{
-	return false;
-}
-#endif
-
 /**
  * rtlock_slowlock_locked - Slow path lock acquisition for RT locks
  * @lock:	The underlying rt mutex
@@ -1603,7 +1609,7 @@ static void __sched rtlock_slowlock_lock
 			owner = NULL;
 		raw_spin_unlock_irq(&lock->wait_lock);
 
-		if (!owner || !rtlock_adaptive_spinwait(lock, owner))
+		if (!owner || !rtmutex_adaptive_spinwait(lock, owner))
 			schedule_rtlock();
 
 		raw_spin_lock_irq(&lock->wait_lock);

