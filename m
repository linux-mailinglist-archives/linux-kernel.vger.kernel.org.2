Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AC637631C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbhEGJwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbhEGJwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:52:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5A4C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 02:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XhAS3nHY+ewwfUPWZBfOCBYBM6yNG5VL0Nf/Qz7wVfs=; b=b5PQK04tZ88rkBnTyPRjhEqglj
        CiRiv3LG1oA7FCM+QJpnUU8WogiKArNxAQ4RZ0IxvlNBxSMum4xkPdlEUZfWjAYUbEGiQVywBkefo
        nBNjjeI6TK0gAZDugP6mA2m0YHt1c4wDwJbbf7QLJx/dDwo+YvTukZVLrGUAks/ma3jSW8NWkd0bH
        bwgueOD9C4eH3Iz1OajbfGB/EDuyWhUTJT1VjbO5N7QgBXNCN9Tb1VUKXH6D/rCqtY07oRgNbqLhS
        eW04RZwaDXFkfewfXOGUpF1HyesbzBLxJQX6S7euGWq2v9GIavg5UA97GouY6IF9gfIFukuURH4Is
        Z/+auXVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lex8K-0033Si-Hs; Fri, 07 May 2021 09:50:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A12130022C;
        Fri,  7 May 2021 11:50:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A8012028F00F; Fri,  7 May 2021 11:50:55 +0200 (CEST)
Date:   Fri, 7 May 2021 11:50:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: [PATCH v2 05/19] sched: Core-wide rq->lock
Message-ID: <YJUNfzSgptjX7tG6@hirez.programming.kicks-ass.net>
References: <20210422120459.447350175@infradead.org>
 <20210422123308.256677625@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422123308.256677625@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce the basic infrastructure to have a core wide rq->lock.

This relies on the rq->__lock order being in increasing CPU number
(inside a core). It is also constrained to SMT8 per lockdep (and
SMT256 per preempt_count).

Luckily SMT8 is the max supported SMT count for Linux (Mips, Sparc and
Power are known to have this).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
---
 kernel/Kconfig.preempt |    6 +
 kernel/sched/core.c    |  164 +++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h   |   58 +++++++++++++++++
 3 files changed, 224 insertions(+), 4 deletions(-)

--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -99,3 +99,9 @@ config PREEMPT_DYNAMIC
 
 	  Interesting if you want the same pre-built kernel should be used for
 	  both Server and Desktop workloads.
+
+config SCHED_CORE
+	bool "Core Scheduling for SMT"
+	default y
+	depends on SCHED_SMT
+
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -84,6 +84,108 @@ unsigned int sysctl_sched_rt_period = 10
 
 __read_mostly int scheduler_running;
 
+#ifdef CONFIG_SCHED_CORE
+
+DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
+
+/*
+ * Magic required such that:
+ *
+ *	raw_spin_rq_lock(rq);
+ *	...
+ *	raw_spin_rq_unlock(rq);
+ *
+ * ends up locking and unlocking the _same_ lock, and all CPUs
+ * always agree on what rq has what lock.
+ *
+ * XXX entirely possible to selectively enable cores, don't bother for now.
+ */
+
+static DEFINE_MUTEX(sched_core_mutex);
+static int sched_core_count;
+static struct cpumask sched_core_mask;
+
+static void __sched_core_flip(bool enabled)
+{
+	int cpu, t, i;
+
+	cpus_read_lock();
+
+	/*
+	 * Toggle the online cores, one by one.
+	 */
+	cpumask_copy(&sched_core_mask, cpu_online_mask);
+	for_each_cpu(cpu, &sched_core_mask) {
+		const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+
+		i = 0;
+		local_irq_disable();
+		for_each_cpu(t, smt_mask) {
+			/* supports up to SMT8 */
+			raw_spin_lock_nested(&cpu_rq(t)->__lock, i++);
+		}
+
+		for_each_cpu(t, smt_mask)
+			cpu_rq(t)->core_enabled = enabled;
+
+		for_each_cpu(t, smt_mask)
+			raw_spin_unlock(&cpu_rq(t)->__lock);
+		local_irq_enable();
+
+		cpumask_andnot(&sched_core_mask, &sched_core_mask, smt_mask);
+	}
+
+	/*
+	 * Toggle the offline CPUs.
+	 */
+	cpumask_copy(&sched_core_mask, cpu_possible_mask);
+	cpumask_andnot(&sched_core_mask, &sched_core_mask, cpu_online_mask);
+
+	for_each_cpu(cpu, &sched_core_mask)
+		cpu_rq(cpu)->core_enabled = enabled;
+
+	cpus_read_unlock();
+}
+
+static void __sched_core_enable(void)
+{
+	// XXX verify there are no cookie tasks (yet)
+
+	static_branch_enable(&__sched_core_enabled);
+	/*
+	 * Ensure all previous instances of raw_spin_rq_*lock() have finished
+	 * and future ones will observe !sched_core_disabled().
+	 */
+	synchronize_rcu();
+	__sched_core_flip(true);
+}
+
+static void __sched_core_disable(void)
+{
+	// XXX verify there are no cookie tasks (left)
+
+	__sched_core_flip(false);
+	static_branch_disable(&__sched_core_enabled);
+}
+
+void sched_core_get(void)
+{
+	mutex_lock(&sched_core_mutex);
+	if (!sched_core_count++)
+		__sched_core_enable();
+	mutex_unlock(&sched_core_mutex);
+}
+
+void sched_core_put(void)
+{
+	mutex_lock(&sched_core_mutex);
+	if (!--sched_core_count)
+		__sched_core_disable();
+	mutex_unlock(&sched_core_mutex);
+}
+
+#endif /* CONFIG_SCHED_CORE */
+
 /*
  * part of the period that we allow rt tasks to run in us.
  * default: 0.95s
@@ -188,16 +290,23 @@ void raw_spin_rq_lock_nested(struct rq *
 {
 	raw_spinlock_t *lock;
 
+	/* Matches synchronize_rcu() in __sched_core_enable() */
+	preempt_disable();
 	if (sched_core_disabled()) {
 		raw_spin_lock_nested(&rq->__lock, subclass);
+		/* preempt_count *MUST* be > 1 */
+		preempt_enable_no_resched();
 		return;
 	}
 
 	for (;;) {
 		lock = rq_lockp(rq);
 		raw_spin_lock_nested(lock, subclass);
-		if (likely(lock == rq_lockp(rq)))
+		if (likely(lock == rq_lockp(rq))) {
+			/* preempt_count *MUST* be > 1 */
+			preempt_enable_no_resched();
 			return;
+		}
 		raw_spin_unlock(lock);
 	}
 }
@@ -207,14 +316,21 @@ bool raw_spin_rq_trylock(struct rq *rq)
 	raw_spinlock_t *lock;
 	bool ret;
 
-	if (sched_core_disabled())
-		return raw_spin_trylock(&rq->__lock);
+	/* Matches synchronize_rcu() in __sched_core_enable() */
+	preempt_disable();
+	if (sched_core_disabled()) {
+		ret = raw_spin_trylock(&rq->__lock);
+		preempt_enable();
+		return ret;
+	}
 
 	for (;;) {
 		lock = rq_lockp(rq);
 		ret = raw_spin_trylock(lock);
-		if (!ret || (likely(lock == rq_lockp(rq))))
+		if (!ret || (likely(lock == rq_lockp(rq)))) {
+			preempt_enable();
 			return ret;
+		}
 		raw_spin_unlock(lock);
 	}
 }
@@ -5042,6 +5158,40 @@ pick_next_task(struct rq *rq, struct tas
 	BUG();
 }
 
+#ifdef CONFIG_SCHED_CORE
+
+static inline void sched_core_cpu_starting(unsigned int cpu)
+{
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+	struct rq *rq, *core_rq = NULL;
+	int i;
+
+	core_rq = cpu_rq(cpu)->core;
+
+	if (!core_rq) {
+		for_each_cpu(i, smt_mask) {
+			rq = cpu_rq(i);
+			if (rq->core && rq->core == rq)
+				core_rq = rq;
+		}
+
+		if (!core_rq)
+			core_rq = cpu_rq(cpu);
+
+		for_each_cpu(i, smt_mask) {
+			rq = cpu_rq(i);
+
+			WARN_ON_ONCE(rq->core && rq->core != core_rq);
+			rq->core = core_rq;
+		}
+	}
+}
+#else /* !CONFIG_SCHED_CORE */
+
+static inline void sched_core_cpu_starting(unsigned int cpu) {}
+
+#endif /* CONFIG_SCHED_CORE */
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -8007,6 +8157,7 @@ static void sched_rq_cpu_starting(unsign
 
 int sched_cpu_starting(unsigned int cpu)
 {
+	sched_core_cpu_starting(cpu);
 	sched_rq_cpu_starting(cpu);
 	sched_tick_start(cpu);
 	return 0;
@@ -8291,6 +8442,11 @@ void __init sched_init(void)
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
+
+#ifdef CONFIG_SCHED_CORE
+		rq->core = NULL;
+		rq->core_enabled = 0;
+#endif
 	}
 
 	set_load_weight(&init_task, false);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1075,6 +1075,12 @@ struct rq {
 #endif
 	unsigned int		push_busy;
 	struct cpu_stop_work	push_work;
+
+#ifdef CONFIG_SCHED_CORE
+	/* per rq */
+	struct rq		*core;
+	unsigned int		core_enabled;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -1113,6 +1119,35 @@ static inline bool is_migration_disabled
 #endif
 }
 
+#ifdef CONFIG_SCHED_CORE
+
+DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
+
+static inline bool sched_core_enabled(struct rq *rq)
+{
+	return static_branch_unlikely(&__sched_core_enabled) && rq->core_enabled;
+}
+
+static inline bool sched_core_disabled(void)
+{
+	return !static_branch_unlikely(&__sched_core_enabled);
+}
+
+static inline raw_spinlock_t *rq_lockp(struct rq *rq)
+{
+	if (sched_core_enabled(rq))
+		return &rq->core->__lock;
+
+	return &rq->__lock;
+}
+
+#else /* !CONFIG_SCHED_CORE */
+
+static inline bool sched_core_enabled(struct rq *rq)
+{
+	return false;
+}
+
 static inline bool sched_core_disabled(void)
 {
 	return true;
@@ -1123,6 +1158,8 @@ static inline raw_spinlock_t *rq_lockp(s
 	return &rq->__lock;
 }
 
+#endif /* CONFIG_SCHED_CORE */
+
 static inline void lockdep_assert_rq_held(struct rq *rq)
 {
 	lockdep_assert_held(rq_lockp(rq));
@@ -2241,6 +2278,27 @@ unsigned long arch_scale_freq_capacity(i
 
 static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
 {
+#ifdef CONFIG_SCHED_CORE
+	/*
+	 * In order to not have {0,2},{1,3} turn into into an AB-BA,
+	 * order by core-id first and cpu-id second.
+	 *
+	 * Notably:
+	 *
+	 *	double_rq_lock(0,3); will take core-0, core-1 lock
+	 *	double_rq_lock(1,2); will take core-1, core-0 lock
+	 *
+	 * when only cpu-id is considered.
+	 */
+	if (rq1->core->cpu < rq2->core->cpu)
+		return true;
+	if (rq1->core->cpu > rq2->core->cpu)
+		return false;
+
+	/*
+	 * __sched_core_flip() relies on SMT having cpu-id lock order.
+	 */
+#endif
 	return rq1->cpu < rq2->cpu;
 }
 
