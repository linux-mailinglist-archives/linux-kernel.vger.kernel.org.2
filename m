Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4413C73FE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhGMQQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54276 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhGMQQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:16 -0400
Message-Id: <20210713160747.320345860@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uYrqVgiQOQUFZfrPbWQkdQXV4HN3FYgKZ0TiyrkTSHY=;
        b=of2P5WsiHZxbJJc9gOJJxlaO0zLpQKvecamCvin/fj+BnvkMndQakHVq2hU/KsFmM9OfbO
        GZTKCtrDEgLnjRR+gdlY8hBBW/B1MJoWXgeYGsF/oPc673XrWicLDYxlmdP+6W94RCl+Pa
        iAmAwseOldq+g9VqTL8S4ExUfyCpaOPQcs5rC5/1aLr1zMnlsAp6y53LV1VlC1MfknpxhN
        pB6v8gcffwmMNFVHY1FNM6EcmH8rUjHzQ5jiY2E2ZAKUwYWo0651CU61aV2MFNr8hSrAhA
        7FWZfIWjII2CuqB585QUPZFkWcyjhvIOpIj5yQTbp8jP2vDgN4w1K6SPbdX1ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=uYrqVgiQOQUFZfrPbWQkdQXV4HN3FYgKZ0TiyrkTSHY=;
        b=ea/ddLd4Fp690dsw7J2utGa0DR+Uwulr5ruiX6cv7HasyFZL6QpVAwQ9svldM7CeSbLD98
        BK8/prdb69PGaODg==
Date:   Tue, 13 Jul 2021 17:11:08 +0200
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
Subject: [patch 14/50] locking/rtmutex: Add wake_state to rt_mutex_waiter
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Regular sleeping locks like mutexes, rtmutexes and rw_semaphores are always
entering and leaving a blocking section with task state == TASK_RUNNING.

On a non-RT kernel spinlocks and rwlocks never affect the task state, but
on RT kernels these locks are converted to rtmutex based 'sleeping' locks.

So in case of contention the task goes to block which requires to carefully
preserve the task state and restore it after acquiring the lock taking
regular wakeups for the task into account which happened while the task was
blocked. This state preserving is achieved by having a seperate task state
for blocking on a RT spin/rwlock and a saved_state field in task_struct
along with careful handling of these wakeup scenarios in try_to_wake_up().

To avoid conditionals in the rtmutex code, store the wake state which has
to be used for waking a lock waiter in rt_mutex_waiter which allows to
handle the regular and RT spin/rwlocks by handing it to wake_up_state().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c        |  2 +-
 kernel/locking/rtmutex_common.h |  9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)
---
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 16e838a1f199..2aaf3bfc1052 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -692,7 +692,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * to get the lock.
 		 */
 		if (prerequeue_top_waiter != rt_mutex_top_waiter(lock))
-			wake_up_process(rt_mutex_top_waiter(lock)->task);
+			wake_up_state(waiter->task, waiter->wake_state);
 		raw_spin_unlock_irq(&lock->wait_lock);
 		return 0;
 	}
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index e7bfe3a8f10e..dbd261911fdc 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -25,6 +25,7 @@
  * @pi_tree_entry:	pi node to enqueue into the mutex owner waiters tree
  * @task:		task reference to the blocked task
  * @lock:		Pointer to the rt_mutex on which the waiter blocks
+ * @wake_state:		Wakeup state to use (TASK_NORMAL or TASK_RTLOCK_WAIT)
  * @prio:		Priority of the waiter
  * @deadline:		Deadline of the waiter if applicable
  */
@@ -33,6 +34,7 @@ struct rt_mutex_waiter {
 	struct rb_node		pi_tree_entry;
 	struct task_struct	*task;
 	struct rt_mutex		*lock;
+	int			wake_state;
 	int			prio;
 	u64			deadline;
 };
@@ -164,9 +166,16 @@ static inline void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 	debug_rt_mutex_init_waiter(waiter);
 	RB_CLEAR_NODE(&waiter->pi_tree_entry);
 	RB_CLEAR_NODE(&waiter->tree_entry);
+	waiter->wake_state = TASK_NORMAL;
 	waiter->task = NULL;
 }
 
+static inline void rtlock_init_rtmutex_waiter(struct rt_mutex_waiter *waiter)
+{
+	rt_mutex_init_waiter(waiter);
+	waiter->wake_state = TASK_RTLOCK_WAIT;
+}
+
 #else /* CONFIG_RT_MUTEXES */
 /* Used in rcu/tree_plugin.h */
 static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)

