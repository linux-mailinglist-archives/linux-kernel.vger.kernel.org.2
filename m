Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B81837631B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhEGJvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbhEGJvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:51:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DD0C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 02:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zrVquqFaRJhpKps5RvpBmC/UtvQuJy72IXSBxKa+DRc=; b=ZPsRgFEv6VAjuxRhgwleDl+9jx
        mwsHDO329HlDl6I60AL13vv8xIi7xY82W7UvUKjo6OIZ6dAWfL4p8Kdk9HVyot/PDr1x3KyKLpCbV
        1MUsC+TAU6hbu+sUpK8S8i7pk4m7yXBVXsiLMDosO+PF3gGCZZM/OHsLOyjINeJd5J4Cq35m/KIx8
        WfA8vcB0p/5NHjJlbq3H1ulWuNNpX0Sbh1jwVm8VpkE/iaoEPsd6iZQkp4hIOuOAyWELe8MunW6AR
        DlFUu1uuETqyVY+GCIp5aiZkoafaabhnZyoJ+UFPgKvkU57ah23dc827mGJnA1HRDwmXeTzgXm0qy
        hAeJ8LOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lex7t-006j4b-QF; Fri, 07 May 2021 09:50:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3698300103;
        Fri,  7 May 2021 11:50:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C41AA2028F00F; Fri,  7 May 2021 11:50:27 +0200 (CEST)
Date:   Fri, 7 May 2021 11:50:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: [PATCH v2 04/19] sched: Prepare for Core-wide rq->lock
Message-ID: <YJUNY0dmrJMD/BIm@hirez.programming.kicks-ass.net>
References: <20210422120459.447350175@infradead.org>
 <20210422123308.196692074@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422123308.196692074@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


When switching on core-sched, CPUs need to agree which lock to use for
their RQ.

The new rule will be that rq->core_enabled will be toggled while
holding all rq->__locks that belong to a core. This means we need to
double check the rq->core_enabled value after each lock acquire and
retry if it changed.

This also has implications for those sites that take multiple RQ
locks, they need to be careful that the second lock doesn't end up
being the first lock.

Verify the lock pointer after acquiring the first lock, because if
they're on the same core, holding any of the rq->__lock instances will
pin the core state.

While there, change the rq->__lock order to CPU number, instead of rq
address, this greatly simplifies the next patch.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
---
 kernel/sched/core.c  |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h |   48 +++++++++++++++++-------------------------------
 2 files changed, 63 insertions(+), 33 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -186,12 +186,37 @@ int sysctl_sched_rt_runtime = 950000;
 
 void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
 {
-	raw_spin_lock_nested(rq_lockp(rq), subclass);
+	raw_spinlock_t *lock;
+
+	if (sched_core_disabled()) {
+		raw_spin_lock_nested(&rq->__lock, subclass);
+		return;
+	}
+
+	for (;;) {
+		lock = rq_lockp(rq);
+		raw_spin_lock_nested(lock, subclass);
+		if (likely(lock == rq_lockp(rq)))
+			return;
+		raw_spin_unlock(lock);
+	}
 }
 
 bool raw_spin_rq_trylock(struct rq *rq)
 {
-	return raw_spin_trylock(rq_lockp(rq));
+	raw_spinlock_t *lock;
+	bool ret;
+
+	if (sched_core_disabled())
+		return raw_spin_trylock(&rq->__lock);
+
+	for (;;) {
+		lock = rq_lockp(rq);
+		ret = raw_spin_trylock(lock);
+		if (!ret || (likely(lock == rq_lockp(rq))))
+			return ret;
+		raw_spin_unlock(lock);
+	}
 }
 
 void raw_spin_rq_unlock(struct rq *rq)
@@ -199,6 +224,25 @@ void raw_spin_rq_unlock(struct rq *rq)
 	raw_spin_unlock(rq_lockp(rq));
 }
 
+#ifdef CONFIG_SMP
+/*
+ * double_rq_lock - safely lock two runqueues
+ */
+void double_rq_lock(struct rq *rq1, struct rq *rq2)
+{
+	lockdep_assert_irqs_disabled();
+
+	if (rq_order_less(rq2, rq1))
+		swap(rq1, rq2);
+
+	raw_spin_rq_lock(rq1);
+	if (rq_lockp(rq1) == rq_lockp(rq2))
+		return;
+
+	raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
+}
+#endif
+
 /*
  * __task_rq_lock - lock the rq @p resides on.
  */
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1113,6 +1113,11 @@ static inline bool is_migration_disabled
 #endif
 }
 
+static inline bool sched_core_disabled(void)
+{
+	return true;
+}
+
 static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 {
 	return &rq->__lock;
@@ -2231,10 +2236,17 @@ unsigned long arch_scale_freq_capacity(i
 }
 #endif
 
+
 #ifdef CONFIG_SMP
-#ifdef CONFIG_PREEMPTION
 
-static inline void double_rq_lock(struct rq *rq1, struct rq *rq2);
+static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
+{
+	return rq1->cpu < rq2->cpu;
+}
+
+extern void double_rq_lock(struct rq *rq1, struct rq *rq2);
+
+#ifdef CONFIG_PREEMPTION
 
 /*
  * fair double_lock_balance: Safely acquires both rq->locks in a fair
@@ -2274,14 +2286,13 @@ static inline int _double_lock_balance(s
 	if (likely(raw_spin_rq_trylock(busiest)))
 		return 0;
 
-	if (rq_lockp(busiest) >= rq_lockp(this_rq)) {
+	if (rq_order_less(this_rq, busiest)) {
 		raw_spin_rq_lock_nested(busiest, SINGLE_DEPTH_NESTING);
 		return 0;
 	}
 
 	raw_spin_rq_unlock(this_rq);
-	raw_spin_rq_lock(busiest);
-	raw_spin_rq_lock_nested(this_rq, SINGLE_DEPTH_NESTING);
+	double_rq_lock(this_rq, busiest);
 
 	return 1;
 }
@@ -2334,31 +2345,6 @@ static inline void double_raw_lock(raw_s
 }
 
 /*
- * double_rq_lock - safely lock two runqueues
- *
- * Note this does not disable interrupts like task_rq_lock,
- * you need to do so manually before calling.
- */
-static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
-	__acquires(rq1->lock)
-	__acquires(rq2->lock)
-{
-	BUG_ON(!irqs_disabled());
-	if (rq_lockp(rq1) == rq_lockp(rq2)) {
-		raw_spin_rq_lock(rq1);
-		__acquire(rq2->lock);	/* Fake it out ;) */
-	} else {
-		if (rq_lockp(rq1) < rq_lockp(rq2)) {
-			raw_spin_rq_lock(rq1);
-			raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
-		} else {
-			raw_spin_rq_lock(rq2);
-			raw_spin_rq_lock_nested(rq1, SINGLE_DEPTH_NESTING);
-		}
-	}
-}
-
-/*
  * double_rq_unlock - safely unlock two runqueues
  *
  * Note this does not restore interrupts like task_rq_unlock,
@@ -2368,11 +2354,11 @@ static inline void double_rq_unlock(stru
 	__releases(rq1->lock)
 	__releases(rq2->lock)
 {
-	raw_spin_rq_unlock(rq1);
 	if (rq_lockp(rq1) != rq_lockp(rq2))
 		raw_spin_rq_unlock(rq2);
 	else
 		__release(rq2->lock);
+	raw_spin_rq_unlock(rq1);
 }
 
 extern void set_rq_online (struct rq *rq);
