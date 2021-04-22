Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6C136809A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbhDVMiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbhDVMhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:37:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36FDC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BthT6RyAZkudy0AYLEWRysJU+3Mm6X/AJt8DtPc0RUk=; b=En+gjB9wECzHVj350lyj499RcN
        muiur+oaxPzUgE1T84r9U5fEmuyIlO2Do9IRGliTDYlbGbN4KrLfHIQwucZ6YI9bO183fuZVNzRfZ
        AzHlG0d5ovZ7SQzZq/BUq0/vKLXTV9hAVeyP8UyeBlc4vl/h6jXFEwrCx5qCD4IKIcV6AFYqESRiW
        75gs9ZSUr91GZ2KYv6WjcPKSUk2jSJLb111oW9taWKl9vMyU569PEy0I0IB8MNmqDFA5mTJahgdTm
        sMDLK0d34K3NSX1w0nN7TIdJL1mbWj8X1zvRRu81HklBgsj0roFjU8XN4gKrXragph0GQyt/lExFX
        FQHYlMfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZYYF-000I8z-AO; Thu, 22 Apr 2021 12:35:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B67E300212;
        Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 343882C67966D; Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Message-ID: <20210422123308.196692074@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Apr 2021 14:05:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
References: <20210422120459.447350175@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
---
 kernel/sched/core.c  |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h |   41 +++++++++++------------------------------
 2 files changed, 57 insertions(+), 32 deletions(-)

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
+	if (rq1->cpu > rq2->cpu)
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
@@ -2231,10 +2236,12 @@ unsigned long arch_scale_freq_capacity(i
 }
 #endif
 
+
 #ifdef CONFIG_SMP
-#ifdef CONFIG_PREEMPTION
 
-static inline void double_rq_lock(struct rq *rq1, struct rq *rq2);
+extern void double_rq_lock(struct rq *rq1, struct rq *rq2);
+
+#ifdef CONFIG_PREEMPTION
 
 /*
  * fair double_lock_balance: Safely acquires both rq->locks in a fair
@@ -2274,14 +2281,13 @@ static inline int _double_lock_balance(s
 	if (likely(raw_spin_rq_trylock(busiest)))
 		return 0;
 
-	if (rq_lockp(busiest) >= rq_lockp(this_rq)) {
+	if (busiest->cpu > this_rq->cpu) {
 		raw_spin_rq_lock_nested(busiest, SINGLE_DEPTH_NESTING);
 		return 0;
 	}
 
 	raw_spin_rq_unlock(this_rq);
-	raw_spin_rq_lock(busiest);
-	raw_spin_rq_lock_nested(this_rq, SINGLE_DEPTH_NESTING);
+	double_rq_lock(this_rq, busiest);
 
 	return 1;
 }
@@ -2334,31 +2340,6 @@ static inline void double_raw_lock(raw_s
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


