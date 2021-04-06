Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B6A354B86
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 06:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhDFELy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 00:11:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:56295 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229974AbhDFELu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 00:11:50 -0400
IronPort-SDR: bzYK76hfLbdlUDh9lJwFILzzImAJyuANrHnHMIfEyvOvrwz3F1KfPFJfGcjg7ouqwQGDMG9t1a
 GoQ1tzurX6JA==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="193017351"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="193017351"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 21:11:42 -0700
IronPort-SDR: tdCf1s/AgQFRoexj4KZGiu72/RHC39PBbuo6YhI2pOBQn2+yG60gQBtWZoRS6ITjze9XolUBqf
 32B8+/LM6nRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="518864617"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2021 21:11:42 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.comi>, Mel Gorman <mgorman@suse.de>,
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
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 2/4] sched/fair: Introduce arch_sched_asym_prefer_early()
Date:   Mon,  5 Apr 2021 21:11:06 -0700
Message-Id: <20210406041108.7416-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210406041108.7416-1-ricardo.neri-calderon@linux.intel.com>
References: <20210406041108.7416-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce arch_sched_asym_prefer_early() so that architectures with SMT
can delay the decision to label a candidate busiest group as
group_asym_packing.

When using asymmetric packing, high priority idle CPUs pull tasks from
scheduling groups with low priority CPUs. The decision on using asymmetric
packing for load balancing is done after collecting the statistics of a
candidate busiest group. However, this decision needs to consider the
state of SMT siblings of dst_cpu.

Cc: Aubrey Li <aubrey.li@intel.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Quentin Perret <qperret@google.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 include/linux/sched/topology.h |  1 +
 kernel/sched/fair.c            | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 8f0f778b7c91..663b98959305 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -57,6 +57,7 @@ static inline int cpu_numa_flags(void)
 #endif
 
 extern int arch_asym_cpu_priority(int cpu);
+extern bool arch_sched_asym_prefer_early(int a, int b);
 
 struct sched_domain_attr {
 	int relax_domain_level;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4ef3fa0d5e8d..e74da853b046 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -106,6 +106,15 @@ int __weak arch_asym_cpu_priority(int cpu)
 	return -cpu;
 }
 
+/*
+ * For asym packing, early check if CPUs with higher priority should be
+ * preferred. On some architectures, more data is needed to make a decision.
+ */
+bool __weak arch_sched_asym_prefer_early(int a, int b)
+{
+	return sched_asym_prefer(a, b);
+}
+
 /*
  * The margin used when comparing utilization with CPU capacity.
  *
@@ -8458,7 +8467,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
 	    env->idle != CPU_NOT_IDLE &&
 	    sgs->sum_h_nr_running &&
-	    sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
+	    arch_sched_asym_prefer_early(env->dst_cpu, group->asym_prefer_cpu)) {
 		sgs->group_asym_packing = 1;
 	}
 
-- 
2.17.1

