Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA63135EA94
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346639AbhDNCF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:05:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:7635 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232952AbhDNCFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:05:53 -0400
IronPort-SDR: zPa8Tb4xhdaXeSIZDpDc4yA4I5IRsveqNj9LDbwXdNL69E8KP34G+UgFJdRwmB4g+DHzOsqytL
 n6y6uwtYu2JA==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="194571776"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="194571776"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 19:05:29 -0700
IronPort-SDR: dfRNi2XAqsNUFX2fNmBHGdCj9736rfmDNvoI/OHwGsYqmU8rV3cJFCyd5QejTfXKefy2ryp2qf
 HWC7mDM+CeMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="450625208"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2021 19:05:29 -0700
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
Subject: [PATCH v2 2/4] sched/fair: Introduce arch_sched_asym_prefer_early()
Date:   Tue, 13 Apr 2021 19:04:34 -0700
Message-Id: <20210414020436.12980-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210414020436.12980-1-ricardo.neri-calderon@linux.intel.com>
References: <20210414020436.12980-1-ricardo.neri-calderon@linux.intel.com>
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
Changes since v1:
  * None
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

