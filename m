Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59003E185B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbhHEPmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242349AbhHEPlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:41:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A78C06179C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 08:41:32 -0700 (PDT)
Message-ID: <20210805153953.859110252@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fP9XsUlBVD2vjkCEGGDuvxemWGwIcwoms9TDZrdDGfM=;
        b=dQ4/oTo2c8gzKcojkX9986ULDPeu797cH/22QqSKYwUqfyxlRtkU94IumiZ//EruhcuoGL
        Kftk9vA12Wdk9yi2MuOt4YbYUzf7j+9ePLnuQzu5eLsAoDnvF7Ik45mcYrLFPHgVjkW/oR
        Q1oGv6141CRO5giBwdvI2D8JW7qg/sEoZjn7YEfx3r33Sf0XWViQpB3zXoKgwX+6PA1ZzT
        eGBBZAT9KpUuNlwovPDvN3fOA3Goe66wV0Z44iKOz8Zk9uIIEG2kxuVmlBBCD0Wx2FG2kL
        LAxlkIPmfzETVwiqUjw4ad113YTlOQyTvqkS3vgOhRwEcrMyvoICa02PC6sbEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fP9XsUlBVD2vjkCEGGDuvxemWGwIcwoms9TDZrdDGfM=;
        b=ZF6O+lDrGCT6O+uRMt7xBXFOgzDS/qLhBtpfLnhVJfIiXMyPoAWq3CbouOEN9uT8H81iiy
        3D3n3UBGgSVQ0jBw==
Date:   Thu, 05 Aug 2021 17:13:18 +0200
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
Subject: [patch V3 18/64] locking/rtmutex: Add wake_state to rt_mutex_waiter
References: <20210805151300.330412127@linutronix.de>
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
blocked. This state preserving is achieved by having a separate task state
for blocking on a RT spin/rwlock and a saved_state field in task_struct
along with careful handling of these wakeup scenarios in try_to_wake_up().

To avoid conditionals in the rtmutex code, store the wake state which has
to be used for waking a lock waiter in rt_mutex_waiter which allows to
handle the regular and RT spin/rwlocks by handing it to wake_up_state().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Use unsigned int for wake_state (Peter Z.)
---
 kernel/locking/rtmutex.c        |    2 +-
 kernel/locking/rtmutex_common.h |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)
---
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -692,7 +692,7 @@ static int __sched rt_mutex_adjust_prio_
 		 * to get the lock.
 		 */
 		if (prerequeue_top_waiter != rt_mutex_top_waiter(lock))
-			wake_up_process(rt_mutex_top_waiter(lock)->task);
+			wake_up_state(waiter->task, waiter->wake_state);
 		raw_spin_unlock_irq(&lock->wait_lock);
 		return 0;
 	}
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
 	struct rt_mutex_base	*lock;
+	unsigned int		wake_state;
 	int			prio;
 	u64			deadline;
 };
@@ -158,9 +160,16 @@ static inline void rt_mutex_init_waiter(
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
 static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)

