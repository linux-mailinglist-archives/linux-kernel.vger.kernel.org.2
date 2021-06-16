Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B67B3AA3FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 21:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhFPTMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 15:12:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:10721 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232469AbhFPTMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 15:12:31 -0400
IronPort-SDR: mDVYcis5rpEGdMdokjEP66LkN/KFebYHbgqcKkl1gLIIV/LlC0l5n7I9PB/TFi0aXTyWpQ3oSH
 tsVtMzFRsTbQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="291874243"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="291874243"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 12:10:25 -0700
IronPort-SDR: QVBF0NcYT+ayvU3uoL6AmVpJO32eYPHkAys+0H9LBSxo5hmDJvLsGPA5GDwluLZeMN63xFZrD/
 ShNXj50M3yqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="479208293"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2021 12:10:24 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, mark.rutland@arm.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@redhat.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/4] perf: Update the ctx->pmu for a hybrid system
Date:   Wed, 16 Jun 2021 11:55:31 -0700
Message-Id: <1623869734-133974-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623869734-133974-1-git-send-email-kan.liang@linux.intel.com>
References: <1623869734-133974-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The current generic perf code is not hybrid-friendly. A task perf
context assumes that there is only one perf_hw_context PMU. The PMU
is stored in the ctx->pmu when allocating the perf context. In a
context switch, before scheduling any events, the corresponding PMU
has to be disabled. But on a hybrid system, the task may be scheduled to
a CPU which has a different PMU from the ctx->pmu. The PMU of the new
CPU may not be disabled.

Add a supported_cpus in struct pmu to indicate the supported CPU mask
of the current PMU. When a new task is scheduled, check the supported
CPU of the ctx->pmu. Update the ctx->pmu if the CPU doesn't support it.

For a non-hybrid system or the generic supported_cpus is not implemented
in the specific codes yet, the behavior is not changed.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h |  7 +++++++
 kernel/events/core.c       | 29 ++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f5a6a2f..111b1c1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -301,6 +301,13 @@ struct pmu {
 	unsigned int			nr_addr_filters;
 
 	/*
+	 * For hybrid systems with PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
+	 * @supported_cpus: The supported CPU mask of the current PMU.
+	 *		    Empty means a non-hybrid system or not implemented.
+	 */
+	cpumask_t			supported_cpus;
+
+	/*
 	 * Fully disable/enable this PMU, can be used to protect from the PMI
 	 * as well as for lazy/batch writing of the MSRs.
 	 */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6fee4a7..b172f54 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3817,11 +3817,38 @@ static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
 	ctx_sched_in(ctx, cpuctx, event_type, task);
 }
 
+/*
+ * Update the ctx->pmu if the new task is scheduled in a CPU
+ * which has a different type of PMU
+ */
+static inline void perf_event_context_update_hybrid(struct perf_event_context *ctx)
+{
+	struct pmu *pmu = ctx->pmu;
+
+	if (cpumask_empty(&pmu->supported_cpus) || cpumask_test_cpu(smp_processor_id(), &pmu->supported_cpus))
+		return;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(pmu, &pmus, entry) {
+		if ((pmu->task_ctx_nr == perf_hw_context) &&
+		    cpumask_test_cpu(smp_processor_id(), &pmu->supported_cpus)) {
+			ctx->pmu = pmu;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &ctx->pmu->supported_cpus));
+}
+
 static void perf_event_context_sched_in(struct perf_event_context *ctx,
 					struct task_struct *task)
 {
 	struct perf_cpu_context *cpuctx;
-	struct pmu *pmu = ctx->pmu;
+	struct pmu *pmu;
+
+	if (ctx->pmu->capabilities & PERF_PMU_CAP_HETEROGENEOUS_CPUS)
+		perf_event_context_update_hybrid(ctx);
+	pmu = ctx->pmu;
 
 	cpuctx = __get_cpu_context(ctx);
 	if (cpuctx->task_ctx == ctx) {
-- 
2.7.4

