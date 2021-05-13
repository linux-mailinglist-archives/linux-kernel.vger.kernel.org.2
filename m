Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC2C37FB09
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhEMPvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:51:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:24119 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232364AbhEMPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:51:12 -0400
IronPort-SDR: eVEVwvuJkJMtRqChWcAgMKNeAz7NXKGRfaG+qgp/Bk5PcQSdckrDcQV//xSIgrljhdU+76wT7F
 waltJBA8l6tw==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="179568910"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="179568910"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 08:50:00 -0700
IronPort-SDR: T/3JXhS0b8/diWUM4Q/7clxKeKoHNx5AXTtzJVEcn3CG7MAU9g4LxSHYyJ1++z8Oks5PsRalkv
 GoMwSJuJNbJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="610418834"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 13 May 2021 08:49:59 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v3 3/6] sched/fair: Provide update_sg_lb_stats() with sched domain statistics
Date:   Thu, 13 May 2021 08:49:06 -0700
Message-Id: <20210513154909.6385-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
References: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before deciding to pull tasks when using asymmetric packing of tasks,
on some architectures (e.g., x86) it is necessary to know not only the
state of dst_cpu but also of its SMT siblings. The decision to classify
a candidate busiest group as group_asym_packing is done in
update_sg_lb_stats(). Give this function access to the scheduling domain
statistics, which contains the statistics of the local group.

Cc: Aubrey Li <aubrey.li@intel.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Quentin Perret <qperret@google.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
  * Introduced this patch.

Changes since v1:
  * N/A
---
 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 96b023432a1c..c8c04e9d0d3b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8455,6 +8455,7 @@ group_type group_classify(unsigned int imbalance_pct,
  * @sg_status: Holds flag indicating the status of the sched_group
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
+				      struct sd_lb_stats *sds,
 				      struct sched_group *group,
 				      struct sg_lb_stats *sgs,
 				      int *sg_status)
@@ -8463,7 +8464,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 	memset(sgs, 0, sizeof(*sgs));
 
-	local_group = cpumask_test_cpu(env->dst_cpu, sched_group_span(group));
+	local_group = group == sds->local;
 
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
@@ -9026,7 +9027,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 				update_group_capacity(env->sd, env->dst_cpu);
 		}
 
-		update_sg_lb_stats(env, sg, sgs, &sg_status);
+		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
 
 		if (local_group)
 			goto next_group;
-- 
2.17.1

