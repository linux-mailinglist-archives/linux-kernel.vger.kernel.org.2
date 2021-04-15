Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DF636118D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 19:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhDOR71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 13:59:27 -0400
Received: from foss.arm.com ([217.140.110.172]:51824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234419AbhDOR7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 13:59:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24D7212FC;
        Thu, 15 Apr 2021 10:59:01 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 92D983FA45;
        Thu, 15 Apr 2021 10:58:59 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: [PATCH 2/2] sched/fair: Relax task_hot() for misfit tasks
Date:   Thu, 15 Apr 2021 18:58:46 +0100
Message-Id: <20210415175846.494385-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415175846.494385-1-valentin.schneider@arm.com>
References: <20210415175846.494385-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the following topology:

  DIE [          ]
  MC  [    ][    ]
       0  1  2  3

  capacity_orig_of(x \in {0-1}) < capacity_orig_of(x \in {2-3})

w/ CPUs 2-3 idle and CPUs 0-1 running CPU hogs (util_avg=1024).

When CPU2 goes through load_balance() (via periodic / NOHZ balance), it
should pull one CPU hog from either CPU0 or CPU1 (this is misfit task
upmigration). However, should a e.g. pcpu kworker awake on CPU0 just before
this load_balance() happens and preempt the CPU hog running there, we would
have, for the [0-1] group at CPU2's DIE level:

o sgs->sum_nr_running > sgs->group_weight
o sgs->group_capacity * 100 < sgs->group_util * imbalance_pct

IOW, this group is group_overloaded.

Considering CPU0 is picked by find_busiest_queue(), we would then visit the
preempted CPU hog in detach_tasks(). However, given it has just been
preempted by this pcpu kworker, task_hot() will prevent it from being
detached. We then leave load_balance() without having done anything.

Long story short, preempted misfit tasks are affected by task_hot(), while
currently running misfit tasks are intentionally preempted by the stopper
task to migrate them over to a higher-capacity CPU.

Align detach_tasks() with the active-balance logic and let it pick a
cache-hot misfit task when the destination CPU can provide a capacity
uplift.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d2d1a69d7aa7..43fc98d34276 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7493,6 +7493,7 @@ struct lb_env {
 	enum fbq_type		fbq_type;
 	enum migration_type	migration_type;
 	enum group_type         src_grp_type;
+	enum group_type         dst_grp_type;
 	struct list_head	tasks;
 };
 
@@ -7533,6 +7534,31 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 	return delta < (s64)sysctl_sched_migration_cost;
 }
 
+
+/*
+ * What does migrating this task do to our capacity-aware scheduling criterion?
+ *
+ * Returns 1, if the task needs more capacity than the dst CPU can provide.
+ * Returns 0, if the task needs the extra capacity provided by the dst CPU
+ * Returns -1, if the task isn't impacted by the migration wrt capacity.
+ */
+static int migrate_degrades_capacity(struct task_struct *p, struct lb_env *env)
+{
+	if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
+		return -1;
+
+	if (!task_fits_capacity(p, capacity_of(env->src_cpu))) {
+		if (cpu_capacity_greater(env->dst_cpu, env->src_cpu))
+			return 0;
+		else if (cpu_capacity_greater(env->src_cpu, env->dst_cpu))
+			return 1;
+		else
+			return -1;
+	}
+
+	return task_fits_capacity(p, capacity_of(env->dst_cpu)) ? -1 : 1;
+}
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * Returns 1, if task migration degrades locality
@@ -7672,6 +7698,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (tsk_cache_hot == -1)
 		tsk_cache_hot = task_hot(p, env);
 
+	/*
+	 * On a (sane) asymmetric CPU capacity system, the increase in compute
+	 * capacity should offset any potential performance hit caused by a
+	 * migration.
+	 */
+	if ((env->dst_grp_type == group_has_spare) &&
+	    !migrate_degrades_capacity(p, env))
+		tsk_cache_hot = 0;
+
 	if (tsk_cache_hot <= 0 ||
 	    env->sd->nr_balance_failed > env->sd->cache_nice_tries) {
 		if (tsk_cache_hot == 1) {
@@ -9310,6 +9345,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	if (!sds.busiest)
 		goto out_balanced;
 
+	env->dst_grp_type = local->group_type;
 	env->src_grp_type = busiest->group_type;
 
 	/* Misfit tasks should be dealt with regardless of the avg load */
-- 
2.25.1

