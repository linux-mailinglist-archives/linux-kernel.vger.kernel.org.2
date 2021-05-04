Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F333727D0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 11:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhEDJJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 05:09:15 -0400
Received: from foss.arm.com ([217.140.110.172]:55984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230113AbhEDJJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 05:09:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4E27106F;
        Tue,  4 May 2021 02:08:16 -0700 (PDT)
Received: from e120189.arm.com (unknown [10.57.63.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9C95C3F73B;
        Tue,  4 May 2021 02:08:13 -0700 (PDT)
From:   Pierre Gondois <Pierre.Gondois@arm.com>
To:     linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        qperret@qperret.net, Lukasz.Luba@arm.com, dietmar.eggemann@arm.com
Cc:     Vincent.Donnefort@arm.com, Pierre Gondois <Pierre.Gondois@arm.com>,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com
Subject: [PATCH v3 2/2] sched/fair: Fix negative energy delta in find_energy_efficient_cpu()
Date:   Tue,  4 May 2021 10:07:43 +0100
Message-Id: <20210504090743.9688-3-Pierre.Gondois@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504090743.9688-1-Pierre.Gondois@arm.com>
References: <20210504090743.9688-1-Pierre.Gondois@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_energy_efficient_cpu() (feec()) searches the best energy CPU
to place a task on. To do so, compute_energy() estimates the energy
impact of placing the task on a CPU, based on CPU and task utilization
signals.

Utilization signals can be concurrently updated while evaluating a
performance domain (pd). In some cases, this leads to having a
'negative delta', i.e. placing the task in the pd is seen as an
energy gain. Thus, any further energy comparison is biased.

In case of a 'negative delta', return prev_cpu since:
1. a 'negative delta' happens in less than 0.5% of feec() calls,
   on a Juno with 6 CPUs (4 little, 2 big)
2. it is unlikely to have two consecutive 'negative delta' for
   a task, so if the first call fails, feec() will correctly
   place the task in the next feec() call
3. EAS current behavior tends to select prev_cpu if the task
   doesn't raise the OPP of its current pd. prev_cpu is EAS's
   generic decision
4. prev_cpu should be preferred to returning an error code.
   In the latter case, select_idle_sibling() would do the placement,
   selecting a big (and not energy efficient) CPU. As 3., the task
   would potentially reside on the big CPU for a long time

Reported-by: Xuewen Yan <xuewen.yan@unisoc.com>
Suggested-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/sched/fair.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fcb9595fc123..c20c6e1acf41 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6594,15 +6594,15 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
 	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
 	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
+	int cpu, best_energy_cpu = prev_cpu, target = -1;
 	unsigned long cpu_cap, util, base_energy = 0;
-	int cpu, best_energy_cpu = prev_cpu;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
 
 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
 	if (!pd || READ_ONCE(rd->overutilized))
-		goto fail;
+		goto unlock;
 
 	/*
 	 * Energy-aware wake-up happens on the lowest sched_domain starting
@@ -6612,7 +6612,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	while (sd && !cpumask_test_cpu(prev_cpu, sched_domain_span(sd)))
 		sd = sd->parent;
 	if (!sd)
-		goto fail;
+		goto unlock;
+
+	target = prev_cpu;
 
 	sync_entity_load_avg(&p->se);
 	if (!task_util_est(p))
@@ -6667,6 +6669,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		/* Evaluate the energy impact of using prev_cpu. */
 		if (compute_prev_delta) {
 			prev_delta = compute_energy(p, prev_cpu, pd);
+			if (prev_delta < base_energy_pd)
+				goto unlock;
 			prev_delta -= base_energy_pd;
 			best_delta = min(best_delta, prev_delta);
 		}
@@ -6674,6 +6678,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		/* Evaluate the energy impact of using max_spare_cap_cpu. */
 		if (max_spare_cap_cpu >= 0) {
 			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
+			if (cur_delta < base_energy_pd)
+				goto unlock;
 			cur_delta -= base_energy_pd;
 			if (cur_delta < best_delta) {
 				best_delta = cur_delta;
@@ -6681,25 +6687,22 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			}
 		}
 	}
-unlock:
 	rcu_read_unlock();
 
 	/*
 	 * Pick the best CPU if prev_cpu cannot be used, or if it saves at
 	 * least 6% of the energy used by prev_cpu.
 	 */
-	if (prev_delta == ULONG_MAX)
-		return best_energy_cpu;
+	if ((prev_delta == ULONG_MAX) ||
+	    (prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
+		target = best_energy_cpu;
 
-	if ((prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
-		return best_energy_cpu;
-
-	return prev_cpu;
+	return target;
 
-fail:
+unlock:
 	rcu_read_unlock();
 
-	return -1;
+	return target;
 }
 
 /*
-- 
2.17.1

