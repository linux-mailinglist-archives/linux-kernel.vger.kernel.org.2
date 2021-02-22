Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD9332137D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhBVJz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:55:27 -0500
Received: from foss.arm.com ([217.140.110.172]:38176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhBVJzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:55:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8C78D6E;
        Mon, 22 Feb 2021 01:54:27 -0800 (PST)
Received: from e124901.arm.com (unknown [10.57.11.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 74B203F73B;
        Mon, 22 Feb 2021 01:54:25 -0800 (PST)
From:   vincent.donnefort@arm.com
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        qperret@google.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH] sched/fair: Fix task utilization accountability in cpu_util_next()
Date:   Mon, 22 Feb 2021 09:54:01 +0000
Message-Id: <20210222095401.37158-1-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

Currently, cpu_util_next() estimates the CPU utilization as follows:

  max(cpu_util + task_util,
      cpu_util_est + task_util_est)

This is an issue when making a comparison between CPUs, as the task
contribution can be either:

  (1) task_util_est, on a mostly idle CPU, where cpu_util is close to 0
      and task_util_est > cpu_util.
  (2) task_util, on a mostly busy CPU, where cpu_util > task_util_est.

This gives an unfair advantage to some CPUs, when comparing energy deltas
in the task waking placement, where task_util is always smaller than
task_util_est. The energy delta is therefore, likely to be bigger on
a mostly idle CPU (1) than a mostly busy CPU (2).

This issue is, moreover, not sporadic. By starving idle CPUs, it keeps
their cpu_util < task_util_est (1) while others will maintain cpu_util >
task_util_est (2).

The new approach uses (if UTIL_EST is enabled) task_util_est() as task
contribution, which ensures that all CPUs will use the same value:

  max(cpu_util + max(task_util, task_util_est),
      cpu_util_est + max(task_util, task_util_est))

This patch doesn't modify the !UTIL_EST behaviour.

Also, replace sub_positive with lsub_positive which saves one explicit
load-store.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fb9f10d4312b..dd143aafaf97 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6516,32 +6516,42 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 {
 	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
-	unsigned long util_est, util = READ_ONCE(cfs_rq->avg.util_avg);
+	unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
 
 	/*
-	 * If @p migrates from @cpu to another, remove its contribution. Or,
-	 * if @p migrates from another CPU to @cpu, add its contribution. In
-	 * the other cases, @cpu is not impacted by the migration, so the
-	 * util_avg should already be correct.
+	 * UTIL_EST case: hide the task_util contribution from util.
+	 * During wake-up, the task isn't enqueued yet and doesn't
+	 * appear in the util_est of any CPU. No contribution has
+	 * therefore to be removed from util_est.
+	 *
+	 * If @p migrates to this CPU, add its contribution to util and
+	 * util_est.
 	 */
-	if (task_cpu(p) == cpu && dst_cpu != cpu)
-		sub_positive(&util, task_util(p));
-	else if (task_cpu(p) != cpu && dst_cpu == cpu)
-		util += task_util(p);
-
 	if (sched_feat(UTIL_EST)) {
+		unsigned long util_est;
+
 		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
 
-		/*
-		 * During wake-up, the task isn't enqueued yet and doesn't
-		 * appear in the cfs_rq->avg.util_est.enqueued of any rq,
-		 * so just add it (if needed) to "simulate" what will be
-		 * cpu_util() after the task has been enqueued.
-		 */
-		if (dst_cpu == cpu)
-			util_est += _task_util_est(p);
+		if (task_cpu(p) == cpu)
+			lsub_positive(&util, task_util(p));
+
+		if (dst_cpu == cpu) {
+			unsigned long task_util = task_util_est(p);
+
+			util += task_util;
+			util_est += task_util;
+		}
 
 		util = max(util, util_est);
+	/*
+	 * !UTIL_EST case: If @p migrates from @cpu to another, remove its
+	 * contribution. If @p migrates to @cpu, add it.
+	 */
+	} else {
+		if (task_cpu(p) == cpu && dst_cpu != cpu)
+			lsub_positive(&util, task_util(p));
+		else if (task_cpu(p) != cpu && dst_cpu == cpu)
+			util += task_util(p);
 	}
 
 	return min(util, arch_scale_cpu_capacity(cpu));
-- 
2.25.1

