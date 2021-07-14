Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F26E3C83FE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 13:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbhGNLml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 07:42:41 -0400
Received: from foss.arm.com ([217.140.110.172]:34072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230164AbhGNLmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 07:42:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6B11D6E;
        Wed, 14 Jul 2021 04:39:48 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EEFF93F774;
        Wed, 14 Jul 2021 04:39:47 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH] sched/fair: Update nohz.next_balance for newly NOHZ-idle CPUs
Date:   Wed, 14 Jul 2021 12:39:28 +0100
Message-Id: <20210714113928.2795632-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider a system with some NOHZ-idle CPUs, such that

  nohz.idle_cpus_mask = S
  nohz.next_balance = T

When a new CPU k goes NOHZ idle (nohz_balance_enter_idle()), we end up
with:

  nohz.idle_cpus_mask = S \U {k}
  nohz.next_balance = T

Note that the nohz.next_balance hasn't changed - it won't be updated until
a NOHZ balance is triggered. This is problematic if the newly NOHZ idle CPU
has an earlier rq.next_balance than the other NOHZ idle CPUs, IOW if:

  cpu_rq(k).next_balance < nohz.next_balance

In such scenarios, the existing nohz.next_balance will prevent any NOHZ
balance from happening, which itself will prevent nohz.next_balance from
being updated to this new cpu_rq(k).next_balance. Unnecessary load balance
delays of over 12ms caused by this were observed on an arm64 RB5 board.

Track which CPUs are iterated over during a NOHZ idle balance with a new
cpumask. When considering whether to kick a NOHZ idle balance, use this
cpumask to determine if any CPU has entered NOHZ idle but hasn't had its
rq.next_balance collated into nohz.next_balance yet, and kick a NOHZ_STATS
balance if it is the case.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/core.c |  8 ++++++++
 kernel/sched/fair.c | 19 +++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0c22cd026440..1bc4cbc1f85e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8893,6 +8893,10 @@ static struct kmem_cache *task_group_cache __read_mostly;
 DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
 DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
 
+#ifdef CONFIG_NOHZ_COMMON
+DECLARE_PER_CPU(cpumask_var_t, nohz_balance_mask);
+#endif /* CONFIG_NOHZ_COMMON */
+
 void __init sched_init(void)
 {
 	unsigned long ptr = 0;
@@ -8942,6 +8946,10 @@ void __init sched_init(void)
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
+#ifdef CONFIG_NOHZ_COMMON
+		per_cpu(nohz_balance_mask, i) = (cpumask_var_t)kzalloc_node(
+			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
+#endif /* CONFIG_NOHZ_COMMON */
 	}
 #endif /* CONFIG_CPUMASK_OFFSTACK */
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 11d22943753f..497208a1afb8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5694,8 +5694,11 @@ DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 
+DEFINE_PER_CPU(cpumask_var_t, nohz_balance_mask);
+
 static struct {
-	cpumask_var_t idle_cpus_mask;
+	cpumask_var_t idle_cpus_mask;    /* CPUs in NOHZ idle */
+	cpumask_var_t last_balance_mask; /* CPUs covered by last NOHZ balance */
 	atomic_t nr_cpus;
 	int has_blocked;		/* Idle CPUS has blocked load */
 	unsigned long next_balance;     /* in jiffy units */
@@ -10351,6 +10354,13 @@ static void nohz_balancer_kick(struct rq *rq)
 unlock:
 	rcu_read_unlock();
 out:
+	/*
+	 * Some CPUs have recently gone into NOHZ idle; kick a balance to
+	 * collate the proper next balance interval.
+	 */
+	if (!cpumask_subset(nohz.idle_cpus_mask, nohz.last_balance_mask))
+		flags |= NOHZ_STATS_KICK;
+
 	if (flags)
 		kick_ilb(flags);
 }
@@ -10487,6 +10497,7 @@ static bool update_nohz_stats(struct rq *rq)
 static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 			       enum cpu_idle_type idle)
 {
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(nohz_balance_mask);
 	/* Earliest time when we have to do rebalance again */
 	unsigned long now = jiffies;
 	unsigned long next_balance = now + 60*HZ;
@@ -10518,7 +10529,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	 * Start with the next CPU after this_cpu so we will end with this_cpu and let a
 	 * chance for other idle cpu to pull load.
 	 */
-	for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1) {
+	cpumask_copy(cpus, nohz.idle_cpus_mask);
+	for_each_cpu_wrap(balance_cpu, cpus, this_cpu+1) {
 		if (!idle_cpu(balance_cpu))
 			continue;
 
@@ -10565,6 +10577,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	if (likely(update_next_balance))
 		nohz.next_balance = next_balance;
 
+	cpumask_copy(nohz.last_balance_mask, cpus);
+
 	WRITE_ONCE(nohz.next_blocked,
 		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
 
@@ -11550,6 +11564,7 @@ __init void init_sched_fair_class(void)
 	nohz.next_balance = jiffies;
 	nohz.next_blocked = jiffies;
 	zalloc_cpumask_var(&nohz.idle_cpus_mask, GFP_NOWAIT);
+	zalloc_cpumask_var(&nohz.last_balance_mask, GFP_NOWAIT);
 #endif
 #endif /* SMP */
 
-- 
2.25.1

