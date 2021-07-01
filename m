Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CFE3B8D85
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 07:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbhGAF4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 01:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhGAF4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 01:56:07 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BD3C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 22:53:36 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id a7so5137787pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 22:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nnc8SGC3tFxZ59O88HilSk7TnH2ERKA2KVLoI2ZMWOw=;
        b=dEGPgMpevdPfdKdTQcztcFf/wvUQ/HKxhFOdxEbD76FhCxUvIakbx/PteHv83AweS4
         1xiVaHVLDzCrH7UtHFruOC+ZXfqoh7R3OCwIEhe4hKs0bhVPo1u0Pj8KXWjpZPEu/NK0
         2Kc01t/xtDnsrOTVKDf7FKqkMhEJhLti7Dpo090Z3HtsIg+6izjwtbLotJswGJw/My9K
         TmcvdLradB3cg2XWlYO86+qyQCHWjuM1+mw3T0+bxmVS0rV4euvFmTMQgp4fEePkGFoe
         A6WDo8P8JrklN/mSkcO6l4qiVNZ22+SwlRKvXujf8SdYxzrzkEHPVFkQnlCgk9kJYhYR
         lG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nnc8SGC3tFxZ59O88HilSk7TnH2ERKA2KVLoI2ZMWOw=;
        b=sAlGO5b7mfqb9Us2sEYzF6WpVrpuxJWJPvMn+4TeB8u3SIYYSBOESA098soM1vj7Qi
         e3uBRMChk1/gJZP90Bds5EjkU0Q1eZlzcuRzDY6MPpIVZ41pMzOZf71pJVyvXkv71svu
         nukRhpSUg80cyGZ3y9VuasaZNPwdjqkgssv/hDVWvo6n3ZhA/JabuDJW7GTqsF0SV/o3
         8CXId2bMQrghhIdeQPGnoeIXZiuxznAh1aoZee6BWipWbrbofmYX9FyHfKpS2Zef4cky
         tXr59vFMpSi58qyHjBcw1IqvS7saqSupK4X4XmO6jXOh+O4KAgY7EOKLrG6YfMB8fyh2
         4NLw==
X-Gm-Message-State: AOAM532nsOukMlll2HalTwxD/7CeNhT2LwsyQzIHhwBiTz3W++HVq0xT
        KDFNwbvfp5paWm417il+THs058ggXXU=
X-Google-Smtp-Source: ABdhPJwqtWtNhuR8Sfp+40nYDz5VlMjLAYjyD8rGd/YwtSvin7ysMx3VEBB5IJJ+MVH6Lno99pkg2w==
X-Received: by 2002:a05:6a00:1496:b029:308:29bc:6d4d with SMTP id v22-20020a056a001496b029030829bc6d4dmr37478652pfu.14.1625118815690;
        Wed, 30 Jun 2021 22:53:35 -0700 (PDT)
Received: from bobo.ibm.com (220-244-87-52.tpgi.com.au. [220.244.87.52])
        by smtp.gmail.com with ESMTPSA id 20sm24005661pfi.170.2021.06.30.22.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 22:53:34 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH] nohz: nohz idle balancing per node
Date:   Thu,  1 Jul 2021 15:53:23 +1000
Message-Id: <20210701055323.2199175-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a single nohz idle CPU is designated to perform balancing on
behalf of all other nohz idle CPUs in the system. Implement a per node
nohz balancer to minimize cross-node memory accesses and runqueue lock
acquisitions.

On a 4 node system, this improves performance by 9.3% on a 'pgbench -N'
with 32 clients/jobs (which is about where throughput maxes out due to
IO and contention in postgres).

Performance consistency and drop-off after peak is much improved:

https://user-images.githubusercontent.com/19833002/124070985-0e923a80-da82-11eb-81c8-6788be27dfdb.png

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/sched/core.c |  3 ++
 kernel/sched/fair.c | 90 +++++++++++++++++++++++++++++++--------------
 2 files changed, 65 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cf16f8fda9a6..52681f11e98c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9067,6 +9067,9 @@ void __init sched_init(void)
 	 */
 	init_idle(current, smp_processor_id());
 
+	/* Must run before init_sched_fair_class(), which tests housekeeping */
+	housekeeping_init();
+
 	calc_load_update = jiffies + LOAD_FREQ;
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fb469b26b00a..832f8673bba1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5722,13 +5722,27 @@ DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 
-static struct {
+struct nohz {
 	cpumask_var_t idle_cpus_mask;
 	atomic_t nr_cpus;
 	int has_blocked;		/* Idle CPUS has blocked load */
 	unsigned long next_balance;     /* in jiffy units */
 	unsigned long next_blocked;	/* Next update of blocked load in jiffies */
-} nohz ____cacheline_aligned;
+} ____cacheline_aligned;
+
+static struct nohz **nohz_nodes __ro_after_init;
+
+static struct nohz *get_nohz(void)
+{
+#ifdef CONFIG_CPU_ISOLATION
+	/*
+	 * May not have a house keeping CPU per node, do global idle balancing.
+	 */
+	if (static_branch_unlikely(&housekeeping_overridden))
+		return nohz_nodes[0];
+#endif
+	return nohz_nodes[numa_node_id()];
+}
 
 #endif /* CONFIG_NO_HZ_COMMON */
 
@@ -10217,7 +10231,7 @@ static inline int find_new_ilb(void)
 {
 	int ilb;
 
-	for_each_cpu_and(ilb, nohz.idle_cpus_mask,
+	for_each_cpu_and(ilb, get_nohz()->idle_cpus_mask,
 			      housekeeping_cpumask(HK_FLAG_MISC)) {
 
 		if (ilb == smp_processor_id())
@@ -10243,7 +10257,7 @@ static void kick_ilb(unsigned int flags)
 	 * not if we only update stats.
 	 */
 	if (flags & NOHZ_BALANCE_KICK)
-		nohz.next_balance = jiffies+1;
+		get_nohz()->next_balance = jiffies+1;
 
 	ilb_cpu = find_new_ilb();
 
@@ -10291,14 +10305,14 @@ static void nohz_balancer_kick(struct rq *rq)
 	 * None are in tickless mode and hence no need for NOHZ idle load
 	 * balancing.
 	 */
-	if (likely(!atomic_read(&nohz.nr_cpus)))
+	if (likely(!atomic_read(&get_nohz()->nr_cpus)))
 		return;
 
-	if (READ_ONCE(nohz.has_blocked) &&
-	    time_after(now, READ_ONCE(nohz.next_blocked)))
+	if (READ_ONCE(get_nohz()->has_blocked) &&
+	    time_after(now, READ_ONCE(get_nohz()->next_blocked)))
 		flags = NOHZ_STATS_KICK;
 
-	if (time_before(now, nohz.next_balance))
+	if (time_before(now, get_nohz()->next_balance))
 		goto out;
 
 	if (rq->nr_running >= 2) {
@@ -10328,7 +10342,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * currently idle; in which case, kick the ILB to move tasks
 		 * around.
 		 */
-		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
+		for_each_cpu_and(i, sched_domain_span(sd), get_nohz()->idle_cpus_mask) {
 			if (sched_asym_prefer(i, cpu)) {
 				flags = NOHZ_KICK_MASK;
 				goto unlock;
@@ -10405,8 +10419,8 @@ void nohz_balance_exit_idle(struct rq *rq)
 		return;
 
 	rq->nohz_tick_stopped = 0;
-	cpumask_clear_cpu(rq->cpu, nohz.idle_cpus_mask);
-	atomic_dec(&nohz.nr_cpus);
+	cpumask_clear_cpu(rq->cpu, get_nohz()->idle_cpus_mask);
+	atomic_dec(&get_nohz()->nr_cpus);
 
 	set_cpu_sd_state_busy(rq->cpu);
 }
@@ -10467,8 +10481,8 @@ void nohz_balance_enter_idle(int cpu)
 
 	rq->nohz_tick_stopped = 1;
 
-	cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
-	atomic_inc(&nohz.nr_cpus);
+	cpumask_set_cpu(cpu, get_nohz()->idle_cpus_mask);
+	atomic_inc(&get_nohz()->nr_cpus);
 
 	/*
 	 * Ensures that if nohz_idle_balance() fails to observe our
@@ -10484,7 +10498,7 @@ void nohz_balance_enter_idle(int cpu)
 	 * Each time a cpu enter idle, we assume that it has blocked load and
 	 * enable the periodic update of the load of idle cpus
 	 */
-	WRITE_ONCE(nohz.has_blocked, 1);
+	WRITE_ONCE(get_nohz()->has_blocked, 1);
 }
 
 static bool update_nohz_stats(struct rq *rq)
@@ -10494,7 +10508,7 @@ static bool update_nohz_stats(struct rq *rq)
 	if (!rq->has_blocked_load)
 		return false;
 
-	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
+	if (!cpumask_test_cpu(cpu, get_nohz()->idle_cpus_mask))
 		return false;
 
 	if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
@@ -10532,7 +10546,7 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	 * setting the flag, we are sure to not clear the state and not
 	 * check the load of an idle cpu.
 	 */
-	WRITE_ONCE(nohz.has_blocked, 0);
+	WRITE_ONCE(get_nohz()->has_blocked, 0);
 
 	/*
 	 * Ensures that if we miss the CPU, we must see the has_blocked
@@ -10544,10 +10558,7 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	 * Start with the next CPU after this_cpu so we will end with this_cpu and let a
 	 * chance for other idle cpu to pull load.
 	 */
-	for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1) {
-		if (!idle_cpu(balance_cpu))
-			continue;
-
+	for_each_cpu_wrap(balance_cpu,  get_nohz()->idle_cpus_mask, this_cpu+1) {
 		/*
 		 * If this CPU gets work to do, stop the load balancing
 		 * work being done for other CPUs. Next load
@@ -10558,6 +10569,9 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 			goto abort;
 		}
 
+		if (!idle_cpu(balance_cpu))
+			continue;
+
 		rq = cpu_rq(balance_cpu);
 
 		has_blocked_load |= update_nohz_stats(rq);
@@ -10589,15 +10603,15 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	 * updated.
 	 */
 	if (likely(update_next_balance))
-		nohz.next_balance = next_balance;
+		get_nohz()->next_balance = next_balance;
 
-	WRITE_ONCE(nohz.next_blocked,
+	WRITE_ONCE(get_nohz()->next_blocked,
 		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
 
 abort:
 	/* There is still blocked load, enable periodic update */
 	if (has_blocked_load)
-		WRITE_ONCE(nohz.has_blocked, 1);
+		WRITE_ONCE(get_nohz()->has_blocked, 1);
 }
 
 /*
@@ -10655,8 +10669,8 @@ static void nohz_newidle_balance(struct rq *this_rq)
 		return;
 
 	/* Don't need to update blocked load of idle CPUs*/
-	if (!READ_ONCE(nohz.has_blocked) ||
-	    time_before(jiffies, READ_ONCE(nohz.next_blocked)))
+	if (!READ_ONCE(get_nohz()->has_blocked) ||
+	    time_before(jiffies, READ_ONCE(get_nohz()->next_blocked)))
 		return;
 
 	/*
@@ -11573,9 +11587,29 @@ __init void init_sched_fair_class(void)
 	open_softirq(SCHED_SOFTIRQ, run_rebalance_domains);
 
 #ifdef CONFIG_NO_HZ_COMMON
-	nohz.next_balance = jiffies;
-	nohz.next_blocked = jiffies;
-	zalloc_cpumask_var(&nohz.idle_cpus_mask, GFP_NOWAIT);
+	if (static_branch_unlikely(&housekeeping_overridden)) {
+		struct nohz *nohz;
+
+		nohz_nodes = kcalloc(1, sizeof(struct nohz *), GFP_NOWAIT);
+		nohz = kmalloc(sizeof(struct nohz), GFP_NOWAIT);
+		nohz->next_balance = jiffies;
+		nohz->next_blocked = jiffies;
+		zalloc_cpumask_var(&nohz->idle_cpus_mask, GFP_NOWAIT);
+		nohz_nodes[0] = nohz;
+	} else {
+		int n;
+
+		nohz_nodes = kcalloc(nr_node_ids, sizeof(struct nohz *), GFP_NOWAIT);
+		for_each_node(n) {
+			struct nohz *nohz;
+
+			nohz = kmalloc_node(sizeof(struct nohz), GFP_NOWAIT, n);
+			nohz->next_balance = jiffies;
+			nohz->next_blocked = jiffies;
+			zalloc_cpumask_var_node(&nohz->idle_cpus_mask, GFP_NOWAIT, n);
+			nohz_nodes[n] = nohz;
+		}
+	}
 #endif
 #endif /* SMP */
 
-- 
2.23.0

