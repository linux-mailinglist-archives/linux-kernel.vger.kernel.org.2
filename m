Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1C434AF41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhCZTUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:20:03 -0400
Received: from shelob.surriel.com ([96.67.55.147]:60040 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhCZTTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:19:45 -0400
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lPrzZ-0004nJ-5I; Fri, 26 Mar 2021 15:19:33 -0400
Date:   Fri, 26 Mar 2021 15:19:32 -0400
From:   Rik van Riel <riel@surriel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH v3] sched/fair: bring back select_idle_smt, but differently
Message-ID: <20210326151932.2c187840@imladris.surriel.com>
In-Reply-To: <20210322110306.GE3697@techsingularity.net>
References: <20210321150358.71ef52b1@imladris.surriel.com>
        <20210322110306.GE3697@techsingularity.net>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 11:03:06 +0000
Mel Gorman <mgorman@techsingularity.net> wrote:


> Second, select_idle_smt() does not use the cpus mask so consider moving
> the cpus initialisation after select_idle_smt() has been called.
> Specifically this initialisation
> 
> 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> 
> Alternatively, clear the bits in the SMT sibling scan to avoid checking
> the siblings twice. It's a tradeoff because initialising and clearing
> bits is not free and the cost is wasted if a sibling is free.

I tried a number of different variations on moving the CPU mask
initialization, and clearing CPUs from the mask, and failed to
get any clear results from those in testing, even in workloads
with lots of context switches.

Below is a simple version that seems to perform identically to
more complicated versions :)

---8<---
sched,fair: bring back select_idle_smt, but differently

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

On our web serving workload, that effect is usually negligible.

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

With Mel's patches and this patch together, task migrations are still
high, but L2 cache misses, memory bandwidth, and CPU time used are back
down to what they were before. The p95 and p99 response times for the
memcache type application improve by about 10% over what they were
before Mel's patches got merged.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/fair.c | 68 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..69680158963f 100644
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
@@ -6136,23 +6163,32 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
-	if (sched_feat(SIS_PROP) && !smt) {
-		u64 avg_cost, avg_idle, span_avg;
+	if (!smt) {
+		if (cpus_share_cache(prev, target)) {
+			/* No idle core. Check if prev has an idle sibling. */
+			i = select_idle_smt(p, sd, prev);
+			if ((unsigned int)i < nr_cpumask_bits)
+				return i;
+		}
 
-		/*
-		 * Due to large variance we need a large fuzz factor;
-		 * hackbench in particularly is sensitive here.
-		 */
-		avg_idle = this_rq()->avg_idle / 512;
-		avg_cost = this_sd->avg_scan_cost + 1;
+		if (sched_feat(SIS_PROP)) {
+			u64 avg_cost, avg_idle, span_avg;
 
-		span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
-			nr = div_u64(span_avg, avg_cost);
-		else
-			nr = 4;
+			/*
+			 * Due to large variance we need a large fuzz factor;
+			 * hackbench in particularly is sensitive here.
+			 */
+			avg_idle = this_rq()->avg_idle / 512;
+			avg_cost = this_sd->avg_scan_cost + 1;
 
-		time = cpu_clock(this);
+			span_avg = sd->span_weight * avg_idle;
+			if (span_avg > 4*avg_cost)
+				nr = div_u64(span_avg, avg_cost);
+			else
+				nr = 4;
+
+			time = cpu_clock(this);
+		}
 	}
 
 	for_each_cpu_wrap(cpu, cpus, target) {
@@ -6307,7 +6343,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (!sd)
 		return target;
 
-	i = select_idle_cpu(p, sd, target);
+	i = select_idle_cpu(p, sd, prev, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-- 
2.25.4


