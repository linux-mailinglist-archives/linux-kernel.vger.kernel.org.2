Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8FA337206
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhCKMGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:06:05 -0500
Received: from foss.arm.com ([217.140.110.172]:34036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232782AbhCKMFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:05:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7B131063;
        Thu, 11 Mar 2021 04:05:38 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D7C13F793;
        Thu, 11 Mar 2021 04:05:37 -0800 (PST)
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
Subject: [PATCH v3 2/7] sched/fair: Clean up active balance nr_balance_failed trickery
Date:   Thu, 11 Mar 2021 12:05:22 +0000
Message-Id: <20210311120527.167870-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311120527.167870-1-valentin.schneider@arm.com>
References: <20210311120527.167870-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When triggering an active load balance, sd->nr_balance_failed is set to
such a value that any further can_migrate_task() using said sd will ignore
the output of task_hot().

This behaviour makes sense, as active load balance intentionally preempts a
rq's running task to migrate it right away, but this asynchronous write is
a bit shoddy, as the stopper thread might run active_load_balance_cpu_stop
before the sd->nr_balance_failed write either becomes visible to the
stopper's CPU or even happens on the CPU that appended the stopper work.

Add a struct lb_env flag to denote active balancing, and use it in
can_migrate_task(). Remove the sd->nr_balance_failed write that served the
same purpose.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 83aea97fbf22..f50a902bdf24 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7420,6 +7420,7 @@ enum migration_type {
 #define LBF_NEED_BREAK	0x02
 #define LBF_DST_PINNED  0x04
 #define LBF_SOME_PINNED	0x08
+#define LBF_ACTIVE_LB	0x10
 
 struct lb_env {
 	struct sched_domain	*sd;
@@ -7609,10 +7610,14 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 	/*
 	 * Aggressive migration if:
-	 * 1) destination numa is preferred
-	 * 2) task is cache cold, or
-	 * 3) too many balance attempts have failed.
+	 * 1) active balance
+	 * 2) destination numa is preferred
+	 * 3) task is cache cold, or
+	 * 4) too many balance attempts have failed.
 	 */
+	if (env->flags & LBF_ACTIVE_LB)
+		return 1;
+
 	tsk_cache_hot = migrate_degrades_locality(p, env);
 	if (tsk_cache_hot == -1)
 		tsk_cache_hot = task_hot(p, env);
@@ -9794,9 +9799,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 					active_load_balance_cpu_stop, busiest,
 					&busiest->active_balance_work);
 			}
-
-			/* We've kicked active balancing, force task migration. */
-			sd->nr_balance_failed = sd->cache_nice_tries+1;
 		}
 	} else {
 		sd->nr_balance_failed = 0;
@@ -9952,7 +9954,8 @@ static int active_load_balance_cpu_stop(void *data)
 			 * @dst_grpmask we need to make that test go away with lying
 			 * about DST_PINNED.
 			 */
-			.flags		= LBF_DST_PINNED,
+			.flags		= LBF_DST_PINNED |
+					  LBF_ACTIVE_LB,
 		};
 
 		schedstat_inc(sd->alb_count);
-- 
2.25.1

