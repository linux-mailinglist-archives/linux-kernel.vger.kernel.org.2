Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CFC324C23
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 09:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbhBYIiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 03:38:11 -0500
Received: from foss.arm.com ([217.140.110.172]:47680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235875AbhBYIiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 03:38:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B125101E;
        Thu, 25 Feb 2021 00:37:17 -0800 (PST)
Received: from e124901.arm.com (unknown [10.57.11.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A52F3F70D;
        Thu, 25 Feb 2021 00:37:15 -0800 (PST)
From:   vincent.donnefort@arm.com
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        qperret@google.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v2 1/2] sched/fair: Fix task utilization accountability in compute_energy()
Date:   Thu, 25 Feb 2021 08:36:11 +0000
Message-Id: <20210225083612.1113823-2-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225083612.1113823-1-vincent.donnefort@arm.com>
References: <20210225083612.1113823-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

find_energy_efficient_cpu() (feec()) computes for each perf_domain (pd) an
energy delta as follows:

  feec(task)
    for_each_pd
      base_energy = compute_energy(task, -1, pd)
        -> for_each_cpu(pd)
           -> cpu_util_next(cpu, task, -1)

      energy_delta = compute_energy(task, dst_cpu, pd)
        -> for_each_cpu(pd)
           -> cpu_util_next(cpu, task, dst_cpu)
      energy_delta -= base_energy

Then it picks the best CPU as being the one that minimizes energy_delta.

cpu_util_next() estimates the CPU utilization that would happen if the
task was placed on dst_cpu as follows:

  max(cpu_util + task_util, cpu_util_est + _task_util_est)

The task contribution to the energy delta can then be either:

  (1) _task_util_est, on a mostly idle CPU, where cpu_util is close to 0
      and _task_util_est > cpu_util.
  (2) task_util, on a mostly busy CPU, where cpu_util > _task_util_est.

  (cpu_util_est doesn't appear here. It is 0 when a CPU is idle and
   otherwise must be small enough so that feec() takes the CPU as a
   potential target for the task placement)

This is problematic for feec(), as cpu_util_next() might give an unfair
advantage to a CPU which is mostly busy (2) compared to one which is
mostly idle (1). _task_util_est being always bigger than task_util in
feec() (as the task is waking up), the task contribution to the energy
might look smaller on certain CPUs (2) and this breaks the energy
comparison.

This issue is, moreover, not sporadic. By starving idle CPUs, it keeps
their cpu_util < _task_util_est (1) while others will maintain cpu_util >
_task_util_est (2).

Fix this problem by always using max(task_util, _task_util_est) as a task
contribution to the energy (ENERGY_UTIL). The new estimated CPU
utilization for the energy would then be:

  max(cpu_util, cpu_util_est) + max(task_util, _task_util_est)

compute_energy() still needs to know which OPP would be selected if the
task would be migrated in the perf_domain (FREQUENCY_UTIL). Hence,
cpu_util_next() is still used to estimate the maximum util within the pd.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7043bb0f2621..146ac9fec4b6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6573,8 +6573,24 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 	 * its pd list and will not be accounted by compute_energy().
 	 */
 	for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
-		unsigned long cpu_util, util_cfs = cpu_util_next(cpu, p, dst_cpu);
-		struct task_struct *tsk = cpu == dst_cpu ? p : NULL;
+		unsigned long util_freq = cpu_util_next(cpu, p, dst_cpu);
+		unsigned long cpu_util, util_running = util_freq;
+		struct task_struct *tsk = NULL;
+
+		/*
+		 * When @p is placed on @cpu:
+		 *
+		 * util_running = max(cpu_util, cpu_util_est) +
+		 *		  max(task_util, _task_util_est)
+		 *
+		 * while cpu_util_next is: max(cpu_util + task_util,
+		 *			       cpu_util_est + _task_util_est)
+		 */
+		if (cpu == dst_cpu) {
+			tsk = p;
+			util_running =
+				cpu_util_next(cpu, p, -1) + task_util_est(p);
+		}
 
 		/*
 		 * Busy time computation: utilization clamping is not
@@ -6582,7 +6598,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * is already enough to scale the EM reported power
 		 * consumption at the (eventually clamped) cpu_capacity.
 		 */
-		sum_util += effective_cpu_util(cpu, util_cfs, cpu_cap,
+		sum_util += effective_cpu_util(cpu, util_running, cpu_cap,
 					       ENERGY_UTIL, NULL);
 
 		/*
@@ -6592,7 +6608,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * NOTE: in case RT tasks are running, by default the
 		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		cpu_util = effective_cpu_util(cpu, util_cfs, cpu_cap,
+		cpu_util = effective_cpu_util(cpu, util_freq, cpu_cap,
 					      FREQUENCY_UTIL, tsk);
 		max_util = max(max_util, cpu_util);
 	}
-- 
2.25.1

