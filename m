Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B803680A2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbhDVMi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236121AbhDVMh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:37:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AF8C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=3s5y/pfEnLxLzjg317PczInV19dw5E5siJ0c288XUBs=; b=r0qruQLcuc+PhDUn3CmS0NUvtz
        vWBTxkpsfy9Sw16alzzhg2wzy287N/FidwpE3oOll+0M6WCkMpoMhq6PBfiSM/ODCMm3Mb9sktgAf
        hOrgjZ9ckKZCNU5rtSvu+nySI2oKDWV0GSOwbxOSMdDW9zdd8G6kmpyiFTAcvMdG0Ipn1ByvgFkHv
        qB2ESCRDkSVmK8cRAOzWtHoP+OyS6/mv55UDUHb+fXfqlUbYzxJKhYiQE0dKkCeO87Mrztyi1+ovA
        LTP1b2pUC3H6K0JXWa9HAXX7SAJUqghH/n2N46EZlphGS4BSdya8Bm+wbbQAnaYkTUviSvydWbL4n
        EbyDIMNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZYZ2-000ICA-FX; Thu, 22 Apr 2021 12:36:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C8C7300311;
        Thu, 22 Apr 2021 14:35:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3BEB92C679686; Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Message-ID: <20210422123308.316696988@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Apr 2021 14:05:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: [PATCH 06/19] sched: Optimize rq_lockp() usage
References: <20210422120459.447350175@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rq_lockp() includes a static_branch(), which is asm-goto, which is
asm volatile which defeats regular CSE. This means that:

	if (!static_branch(&foo))
		return simple;

	if (static_branch(&foo) && cond)
		return complex;

Doesn't fold and we get horrible code. Introduce __rq_lockp() without
the static_branch() on.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c     |   16 ++++++++--------
 kernel/sched/deadline.c |    4 ++--
 kernel/sched/fair.c     |    2 +-
 kernel/sched/sched.h    |   33 +++++++++++++++++++++++++--------
 4 files changed, 36 insertions(+), 19 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -281,9 +281,9 @@ void raw_spin_rq_lock_nested(struct rq *
 	}
 
 	for (;;) {
-		lock = rq_lockp(rq);
+		lock = __rq_lockp(rq);
 		raw_spin_lock_nested(lock, subclass);
-		if (likely(lock == rq_lockp(rq)))
+		if (likely(lock == __rq_lockp(rq)))
 			return;
 		raw_spin_unlock(lock);
 	}
@@ -298,9 +298,9 @@ bool raw_spin_rq_trylock(struct rq *rq)
 		return raw_spin_trylock(&rq->__lock);
 
 	for (;;) {
-		lock = rq_lockp(rq);
+		lock = __rq_lockp(rq);
 		ret = raw_spin_trylock(lock);
-		if (!ret || (likely(lock == rq_lockp(rq))))
+		if (!ret || (likely(lock == __rq_lockp(rq))))
 			return ret;
 		raw_spin_unlock(lock);
 	}
@@ -323,7 +323,7 @@ void double_rq_lock(struct rq *rq1, stru
 		swap(rq1, rq2);
 
 	raw_spin_rq_lock(rq1);
-	if (rq_lockp(rq1) == rq_lockp(rq2))
+	if (__rq_lockp(rq1) == __rq_lockp(rq2))
 		return;
 
 	raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
@@ -2594,7 +2594,7 @@ void set_task_cpu(struct task_struct *p,
 	 * task_rq_lock().
 	 */
 	WARN_ON_ONCE(debug_locks && !(lockdep_is_held(&p->pi_lock) ||
-				      lockdep_is_held(rq_lockp(task_rq(p)))));
+				      lockdep_is_held(__rq_lockp(task_rq(p)))));
 #endif
 	/*
 	 * Clearly, migrating tasks to offline CPUs is a fairly daft thing.
@@ -4220,7 +4220,7 @@ prepare_lock_switch(struct rq *rq, struc
 	 * do an early lockdep release here:
 	 */
 	rq_unpin_lock(rq, rf);
-	spin_release(&rq_lockp(rq)->dep_map, _THIS_IP_);
+	spin_release(&__rq_lockp(rq)->dep_map, _THIS_IP_);
 #ifdef CONFIG_DEBUG_SPINLOCK
 	/* this is a valid case when another task releases the spinlock */
 	rq_lockp(rq)->owner = next;
@@ -4234,7 +4234,7 @@ static inline void finish_lock_switch(st
 	 * fix up the runqueue lock - which gets 'carried over' from
 	 * prev into current:
 	 */
-	spin_acquire(&rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
+	spin_acquire(&__rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
 	__balance_callbacks(rq);
 	raw_spin_rq_unlock_irq(rq);
 }
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1097,9 +1097,9 @@ static enum hrtimer_restart dl_task_time
 		 * If the runqueue is no longer available, migrate the
 		 * task elsewhere. This necessarily changes rq.
 		 */
-		lockdep_unpin_lock(rq_lockp(rq), rf.cookie);
+		lockdep_unpin_lock(__rq_lockp(rq), rf.cookie);
 		rq = dl_task_offline_migration(rq, p);
-		rf.cookie = lockdep_pin_lock(rq_lockp(rq));
+		rf.cookie = lockdep_pin_lock(__rq_lockp(rq));
 		update_rq_clock(rq);
 
 		/*
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1107,7 +1107,7 @@ struct numa_group {
 static struct numa_group *deref_task_numa_group(struct task_struct *p)
 {
 	return rcu_dereference_check(p->numa_group, p == current ||
-		(lockdep_is_held(rq_lockp(task_rq(p))) && !READ_ONCE(p->on_cpu)));
+		(lockdep_is_held(__rq_lockp(task_rq(p))) && !READ_ONCE(p->on_cpu)));
 }
 
 static struct numa_group *deref_curr_numa_group(struct task_struct *p)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1127,6 +1127,10 @@ static inline bool sched_core_disabled(v
 	return !static_branch_unlikely(&__sched_core_enabled);
 }
 
+/*
+ * Be careful with this function; not for general use. The return value isn't
+ * stable unless you actually hold a relevant rq->__lock.
+ */
 static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 {
 	if (sched_core_enabled(rq))
@@ -1135,6 +1139,14 @@ static inline raw_spinlock_t *rq_lockp(s
 	return &rq->__lock;
 }
 
+static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
+{
+	if (rq->core_enabled)
+		return &rq->core->__lock;
+
+	return &rq->__lock;
+}
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
@@ -1152,11 +1164,16 @@ static inline raw_spinlock_t *rq_lockp(s
 	return &rq->__lock;
 }
 
+static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
+{
+	return &rq->__lock;
+}
+
 #endif /* CONFIG_SCHED_CORE */
 
 static inline void lockdep_assert_rq_held(struct rq *rq)
 {
-	lockdep_assert_held(rq_lockp(rq));
+	lockdep_assert_held(__rq_lockp(rq));
 }
 
 extern void raw_spin_rq_lock_nested(struct rq *rq, int subclass);
@@ -1340,7 +1357,7 @@ extern struct callback_head balance_push
  */
 static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 {
-	rf->cookie = lockdep_pin_lock(rq_lockp(rq));
+	rf->cookie = lockdep_pin_lock(__rq_lockp(rq));
 
 #ifdef CONFIG_SCHED_DEBUG
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
@@ -1358,12 +1375,12 @@ static inline void rq_unpin_lock(struct
 		rf->clock_update_flags = RQCF_UPDATED;
 #endif
 
-	lockdep_unpin_lock(rq_lockp(rq), rf->cookie);
+	lockdep_unpin_lock(__rq_lockp(rq), rf->cookie);
 }
 
 static inline void rq_repin_lock(struct rq *rq, struct rq_flags *rf)
 {
-	lockdep_repin_lock(rq_lockp(rq), rf->cookie);
+	lockdep_repin_lock(__rq_lockp(rq), rf->cookie);
 
 #ifdef CONFIG_SCHED_DEBUG
 	/*
@@ -2306,7 +2323,7 @@ static inline int _double_lock_balance(s
 	__acquires(busiest->lock)
 	__acquires(this_rq->lock)
 {
-	if (rq_lockp(this_rq) == rq_lockp(busiest))
+	if (__rq_lockp(this_rq) == __rq_lockp(busiest))
 		return 0;
 
 	if (likely(raw_spin_rq_trylock(busiest)))
@@ -2338,9 +2355,9 @@ static inline int double_lock_balance(st
 static inline void double_unlock_balance(struct rq *this_rq, struct rq *busiest)
 	__releases(busiest->lock)
 {
-	if (rq_lockp(this_rq) != rq_lockp(busiest))
+	if (__rq_lockp(this_rq) != __rq_lockp(busiest))
 		raw_spin_rq_unlock(busiest);
-	lock_set_subclass(&rq_lockp(this_rq)->dep_map, 0, _RET_IP_);
+	lock_set_subclass(&__rq_lockp(this_rq)->dep_map, 0, _RET_IP_);
 }
 
 static inline void double_lock(spinlock_t *l1, spinlock_t *l2)
@@ -2381,7 +2398,7 @@ static inline void double_rq_unlock(stru
 	__releases(rq2->lock)
 {
 	raw_spin_rq_unlock(rq1);
-	if (rq_lockp(rq1) != rq_lockp(rq2))
+	if (__rq_lockp(rq1) != __rq_lockp(rq2))
 		raw_spin_rq_unlock(rq2);
 	else
 		__release(rq2->lock);


