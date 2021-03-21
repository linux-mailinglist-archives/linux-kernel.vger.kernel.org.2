Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1D6343446
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 20:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhCUTEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 15:04:16 -0400
Received: from shelob.surriel.com ([96.67.55.147]:33650 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhCUTEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 15:04:07 -0400
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lO3Ml-0000zB-AC; Sun, 21 Mar 2021 15:03:59 -0400
Date:   Sun, 21 Mar 2021 15:03:58 -0400
From:   Rik van Riel <riel@surriel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH v2] sched/fair: bring back select_idle_smt, but differently
Message-ID: <20210321150358.71ef52b1@imladris.surriel.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Mel Gorman did some nice work in 9fe1f127b913
    ("sched/fair: Merge select_idle_core/cpu()"), resulting in the kernel
    being more efficient at finding an idle CPU, and in tasks spending less
    time waiting to be run, both according to the schedstats run_delay
    numbers, and according to measured application latencies. Yay.
    
    The flip side of this is that we see more task migrations (about
    30% more), higher cache misses, higher memory bandwidth utilization,
    and higher CPU use, for the same number of requests/second.
    
    This is most pronounced on a memcache type workload, which saw
    a consistent 1-3% increase in total CPU use on the system, due
    to those increased task migrations leading to higher L2 cache
    miss numbers, and higher memory utilization. The exclusive L3
    cache on Skylake does us no favors there.
    
    On our web serving workload, that effect is usually negligible,
    but occasionally as large as a 9% regression in the number of
    requests served, due to some interaction between scheduler latency
    and the web load balancer.
    
    It appears that the increased number of CPU migrations is generally
    a good thing, since it leads to lower cpu_delay numbers, reflecting
    the fact that tasks get to run faster. However, the reduced locality
    and the corresponding increase in L2 cache misses hurts a little.
    
    The patch below appears to fix the regression, while keeping the
    benefit of the lower cpu_delay numbers, by reintroducing select_idle_smt
    with a twist: when a socket has no idle cores, check to see if the
    sibling of "prev" is idle, before searching all the other CPUs.
    
    This fixes both the occasional 9% regression on the web serving
    workload, and the continuous 2% CPU use regression on the memcache
    type workload.
    
    With Mel's patches and this patch together, the p95 and p99 response
    times for the memcache type application improve by about 20% over what
    they were before Mel's patches got merged.
    
    Signed-off-by: Rik van Riel <riel@surriel.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..0c986972f4cd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6098,6 +6098,28 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 	return -1;
 }
 
+/*
+ * Scan the local SMT mask for idle CPUs.
+ */
+static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int
+target)
+{
+	int cpu;
+
+	if (!static_branch_likely(&sched_smt_present))
+		return -1;
+
+	for_each_cpu(cpu, cpu_smt_mask(target)) {
+		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
+		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
+			continue;
+		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
+			return cpu;
+	}
+
+	return -1;
+}
+
 #else /* CONFIG_SCHED_SMT */
 
 static inline void set_idle_cores(int cpu, int val)
@@ -6114,6 +6136,11 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 	return __select_idle_cpu(core);
 }
 
+static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
+{
+	return -1;
+}
+
 #endif /* CONFIG_SCHED_SMT */
 
 /*
@@ -6121,7 +6148,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
  * average idle time for this rq (as found in rq->avg_idle).
  */
-static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
+static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int prev, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
@@ -6155,6 +6182,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 		time = cpu_clock(this);
 	}
 
+	if (!smt && cpus_share_cache(prev, target)) {
+		/* No idle core. Check if prev has an idle sibling. */
+		i = select_idle_smt(p, sd, prev);
+		if ((unsigned int)i < nr_cpumask_bits)
+			return i;
+	}
+
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (smt) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
@@ -6307,7 +6341,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (!sd)
 		return target;
 
-	i = select_idle_cpu(p, sd, target);
+	i = select_idle_cpu(p, sd, prev, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 

