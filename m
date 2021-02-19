Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDDD31F9A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 14:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhBSNFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 08:05:36 -0500
Received: from foss.arm.com ([217.140.110.172]:35956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230235AbhBSNEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 08:04:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 494421435;
        Fri, 19 Feb 2021 05:02:43 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B6B963F73B;
        Fri, 19 Feb 2021 05:02:41 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: [PATCH v2 7/7] sched/fair: Relax task_hot() for misfit tasks
Date:   Fri, 19 Feb 2021 13:00:03 +0000
Message-Id: <20210219130003.2890-8-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210219130003.2890-1-valentin.schneider@arm.com>
References: <20210219130003.2890-1-valentin.schneider@arm.com>
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

Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ee172b384e29..554430fd249c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7448,6 +7448,17 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 	if (env->sd->flags & SD_SHARE_CPUCAPACITY)
 		return 0;
 
+	/*
+	 * On a (sane) asymmetric CPU capacity system, the increase in compute
+	 * capacity should offset any potential performance hit caused by a
+	 * migration.
+	 */
+	if (sd_has_asym_cpucapacity(env->sd) &&
+	    env->idle != CPU_NOT_IDLE &&
+	    !task_fits_capacity(p, capacity_of(env->src_cpu)) &&
+	    cpu_capacity_greater(env->dst_cpu, env->src_cpu))
+		return 0;
+
 	/*
 	 * Buddy candidates are cache hot:
 	 */
-- 
2.27.0

