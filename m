Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63599307E53
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhA1SnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:43:08 -0500
Received: from foss.arm.com ([217.140.110.172]:37444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232147AbhA1SfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:35:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2024B1480;
        Thu, 28 Jan 2021 10:32:14 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A6A153F719;
        Thu, 28 Jan 2021 10:32:12 -0800 (PST)
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
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 5/8] sched/fair: Make check_misfit_status() only compare dynamic capacities
Date:   Thu, 28 Jan 2021 18:31:38 +0000
Message-Id: <20210128183141.28097-6-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210128183141.28097-1-valentin.schneider@arm.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_misfit_status() checks for both capacity pressure & available CPUs
with higher capacity. Now that we have a sane(ish) capacity comparison
margin which is used throughout load-balance, this can be condensed into a
single check:

  capacity_greater(<root_domain max capacity>, <misfit task CPU's capacity>);

This has the added benefit of returning false if the misfit task CPU's is
heavily pressured, but there are no better candidates for migration.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0959a770ecc0..ef44474b8fbf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8254,14 +8254,12 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
 
 /*
  * Check whether a rq has a misfit task and if it looks like we can actually
- * help that task: we can migrate the task to a CPU of higher capacity, or
- * the task's current CPU is heavily pressured.
+ * help that task: we can migrate the task to a CPU of higher capacity.
  */
-static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
+static inline int check_misfit_status(struct rq *rq)
 {
 	return rq->misfit_task_load &&
-		(capacity_greater(rq->rd->max_cpu_capacity, rq->cpu_capacity_orig) ||
-		 check_cpu_capacity(rq, sd));
+		capacity_greater(rq->rd->max_cpu_capacity, rq->cpu_capacity);
 }
 
 /*
@@ -10238,7 +10236,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * When ASYM_CPUCAPACITY; see if there's a higher capacity CPU
 		 * to run the misfit task on.
 		 */
-		if (check_misfit_status(rq, sd)) {
+		if (check_misfit_status(rq)) {
 			flags = NOHZ_KICK_MASK;
 			goto unlock;
 		}
-- 
2.27.0

