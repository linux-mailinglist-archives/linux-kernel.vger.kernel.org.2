Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DB24163B5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242503AbhIWQ4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242237AbhIWQ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:56:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50386C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:54:48 -0700 (PDT)
Message-ID: <20210923165358.368305497@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632416087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Hd3wmK0Mcn3SqRowdGJWGN25iN9sOUouw6g+YiSgcl0=;
        b=209FrlQF/pNDLfOq3dBtVvdQPyKfedgJAKbcENp+DgQTKJcHuMwFQ4kPFjvxq6Rd7LorXe
        IRMAdLGOs5UhH4uX375DU9cW8MHDnliqqf3EGSCTtqjxAiepGkXaRLA5AnsgYhK83fokV9
        8wvsuVsDVo5YOC5xT+taQncqe9c9q4pSLmxN03mS3vhFM6RM859Rnkw2PCyMqWWFWfpuDU
        PA7eFGsJrO4RCxaDJbtI+KyRx4ItKx9WZxFbBiGeiLiWI+ouYtj9Iot7Phgdwtc5ZHwoJH
        xwH7QmtUpmWCMX5GHUnu6eqXXIVM2EYO6FVm4RoXtHSHOWr0HngLxHPlPKMKtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632416087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Hd3wmK0Mcn3SqRowdGJWGN25iN9sOUouw6g+YiSgcl0=;
        b=14+0jQ+69AnW/7aQa7uX0O1XrYQ/Gz/xen+0tbokCHvdAoo8rPZqs7nV6bl/cWrFvIcYP0
        gYb0ZOgVh2a7G3Cg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: [patch 8/8] locking/rt: Take RCU nesting into account for __might_resched()
References: <20210923164145.466686140@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 23 Sep 2021 18:54:46 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The general rule that rcu_read_lock() held sections cannot voluntary sleep
does apply even on RT kernels. Though the substitution of spin/rw locks on
RT enabled kernels has to be exempt from that rule. On !RT a spin_lock()
can obviously nest inside a RCU read side critical section as the lock
acquisition is not going to block, but on RT this is not longer the case
due to the 'sleeping' spinlock substitution.

The RT patches contained a cheap hack to ignore the RCU nesting depth in
might_sleep() checks, which was a pragmatic but incorrect workaround.

Instead of generally ignoring the RCU nesting depth in __might_sleep() and
__might_resched() checks, pass the rcu_preempt_depth() via the offsets
argument to __might_resched() from spin/read/write_lock() which makes the
checks work correctly even in RCU read side critical sections.

The actual blocking on such a substituted lock within a RCU read side
critical section is already handled correctly in __schedule() by treating
it as a "preemption" of the RCU read side critical section.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/spinlock_rt.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -24,6 +24,17 @@
 #define RT_MUTEX_BUILD_SPINLOCKS
 #include "rtmutex.c"
 
+/*
+ * __might_resched() skips the state check as rtlocks are state
+ * preserving. Take RCU nesting into account as spin/read/write_lock() can
+ * legitimately nest into an RCU read side critical section.
+ */
+#define RTLOCK_RESCHED_OFFSETS						\
+	(rcu_preempt_depth() << MIGHT_RESCHED_RCU_SHIFT)
+
+#define rtlock_might_resched()						\
+	__might_resched(__FILE__, __LINE__, RTLOCK_RESCHED_OFFSETS)
+
 static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
 {
 	if (unlikely(!rt_mutex_cmpxchg_acquire(rtm, NULL, current)))
@@ -32,7 +43,7 @@ static __always_inline void rtlock_lock(
 
 static __always_inline void __rt_spin_lock(spinlock_t *lock)
 {
-	__might_resched(__FILE__, __LINE__, 0);
+	rtlock_might_resched();
 	rtlock_lock(&lock->lock);
 	rcu_read_lock();
 	migrate_disable();
@@ -210,7 +221,7 @@ EXPORT_SYMBOL(rt_write_trylock);
 
 void __sched rt_read_lock(rwlock_t *rwlock)
 {
-	__might_resched(__FILE__, __LINE__, 0);
+	rtlock_might_resched();
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_read_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
@@ -220,7 +231,7 @@ EXPORT_SYMBOL(rt_read_lock);
 
 void __sched rt_write_lock(rwlock_t *rwlock)
 {
-	__might_resched(__FILE__, __LINE__, 0);
+	rtlock_might_resched();
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_write_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();

