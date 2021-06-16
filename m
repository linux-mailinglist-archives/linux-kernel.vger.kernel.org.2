Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953D23AA400
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 21:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhFPTMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 15:12:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:10721 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232469AbhFPTMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 15:12:34 -0400
IronPort-SDR: avuKb97z1VyO9UQZroC3RCfbR7i9W2XoOucHpvvyNf0s/0n0ZH44N2PbHbY4WMFHh4WQ2miF0J
 rzMx7aGkfadA==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="291874247"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="291874247"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 12:10:27 -0700
IronPort-SDR: q8SXpgsaL/iX0wUDMhIQ0TMZdpdJW8gj/31TWIDKTs43qf2PECeYvqJK6Y2XV3mXUNFxH/qnf1
 NjYxNtbx9Y/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="479208302"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2021 12:10:26 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, mark.rutland@arm.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@redhat.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/4] perf/x86: Fix the x86_pmu_start WARNING on a hybrid system
Date:   Wed, 16 Jun 2021 11:55:32 -0700
Message-Id: <1623869734-133974-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623869734-133974-1-git-send-email-kan.liang@linux.intel.com>
References: <1623869734-133974-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The below WARNING may be triggered, when a user enables per-task
monitoring with all available perf_hw_context PMUs on a hybrid system.

WARNING: CPU: 8 PID: 37107 at arch/x86/events/core.c:1505
x86_pmu_start+0x77/0x90
Call Trace:
x86_pmu_enable+0x111/0x2f0
event_sched_in+0x167/0x230
merge_sched_in+0x1a7/0x3d0
visit_groups_merge.constprop.0.isra.0+0x16f/0x450
? x86_pmu_del+0x42/0x190
ctx_sched_in+0xb8/0x170
perf_event_sched_in+0x61/0x90
__perf_event_task_sched_in+0x20b/0x2a0
finish_task_switch.isra.0+0x16a/0x290
__schedule+0x2fd/0x970
? free_inode_nonrcu+0x18/0x20
schedule+0x4f/0xc0
do_wait+0x176/0x2f0
kernel_wait4+0xaf/0x150

Here is the line of the WARNING.
        if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))

The current generic perf code doesn't know the supported CPU mask of a
specific PMU. It cannot update the ctx->pmu when the task is scheduled
on a CPU which has a different type of PMU from the previous CPU.
If many events are scheduled in the context switch and the perf
scheduler tries to move the early event to a new counter, the WARNING
will be triggered, because the corresponding PMU is not disabled. The
early events are probably already running.

Update the supported_cpus in struct pmu for a hybrid system. So the
generic perf code understands the supported CPU mask of a specific PMU.
Since the supported_cpus is tracked in the struct pmu, remove it from
the struct x86_hybrid_pmu.

Fixes: f83d2f91d259 ("perf/x86/intel: Add Alder Lake Hybrid support")
Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 12 ++++--------
 arch/x86/events/intel/core.c | 13 +++++--------
 arch/x86/events/perf_event.h |  1 -
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8f71dd7..ecebc66 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2060,6 +2060,7 @@ void x86_pmu_update_cpu_context(struct pmu *pmu, int cpu)
 
 	cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
 	cpuctx->ctx.pmu = pmu;
+	cpumask_set_cpu(cpu, &pmu->supported_cpus);
 }
 
 static int __init init_hw_perf_events(void)
@@ -2331,12 +2332,9 @@ static struct cpu_hw_events *allocate_fake_cpuc(struct pmu *event_pmu)
 	cpuc->is_fake = 1;
 
 	if (is_hybrid()) {
-		struct x86_hybrid_pmu *h_pmu;
-
-		h_pmu = hybrid_pmu(event_pmu);
-		if (cpumask_empty(&h_pmu->supported_cpus))
+		if (cpumask_empty(&event_pmu->supported_cpus))
 			goto error;
-		cpu = cpumask_first(&h_pmu->supported_cpus);
+		cpu = cpumask_first(&event_pmu->supported_cpus);
 	} else
 		cpu = raw_smp_processor_id();
 	cpuc->pmu = event_pmu;
@@ -2441,7 +2439,6 @@ static int validate_group(struct perf_event *event)
 
 static int x86_pmu_event_init(struct perf_event *event)
 {
-	struct x86_hybrid_pmu *pmu = NULL;
 	int err;
 
 	if ((event->attr.type != event->pmu->type) &&
@@ -2450,8 +2447,7 @@ static int x86_pmu_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	if (is_hybrid() && (event->cpu != -1)) {
-		pmu = hybrid_pmu(event->pmu);
-		if (!cpumask_test_cpu(event->cpu, &pmu->supported_cpus))
+		if (!cpumask_test_cpu(event->cpu, &event->pmu->supported_cpus))
 			return -ENOENT;
 	}
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e288922..03ba014 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4311,7 +4311,7 @@ static bool init_hybrid_pmu(int cpu)
 	}
 
 	/* Only check and dump the PMU information for the first CPU */
-	if (!cpumask_empty(&pmu->supported_cpus))
+	if (!cpumask_empty(&pmu->pmu.supported_cpus))
 		goto end;
 
 	if (!check_hw_exists(&pmu->pmu, pmu->num_counters, pmu->num_counters_fixed))
@@ -4328,9 +4328,7 @@ static bool init_hybrid_pmu(int cpu)
 			     pmu->intel_ctrl);
 
 end:
-	cpumask_set_cpu(cpu, &pmu->supported_cpus);
 	cpuc->pmu = &pmu->pmu;
-
 	x86_pmu_update_cpu_context(&pmu->pmu, cpu);
 
 	return true;
@@ -4463,7 +4461,7 @@ static void intel_pmu_cpu_dead(int cpu)
 	intel_cpuc_finish(cpuc);
 
 	if (is_hybrid() && cpuc->pmu)
-		cpumask_clear_cpu(cpu, &hybrid_pmu(cpuc->pmu)->supported_cpus);
+		cpumask_clear_cpu(cpu, &cpuc->pmu->supported_cpus);
 }
 
 static void intel_pmu_sched_task(struct perf_event_context *ctx,
@@ -4494,10 +4492,9 @@ static int intel_pmu_aux_output_match(struct perf_event *event)
 
 static int intel_pmu_filter_match(struct perf_event *event)
 {
-	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
 	unsigned int cpu = smp_processor_id();
 
-	return cpumask_test_cpu(cpu, &pmu->supported_cpus);
+	return cpumask_test_cpu(cpu, &event->pmu->supported_cpus);
 }
 
 PMU_FORMAT_ATTR(offcore_rsp, "config1:0-63");
@@ -5299,7 +5296,7 @@ static umode_t hybrid_events_is_visible(struct kobject *kobj,
 
 static inline int hybrid_find_supported_cpu(struct x86_hybrid_pmu *pmu)
 {
-	int cpu = cpumask_first(&pmu->supported_cpus);
+	int cpu = cpumask_first(&pmu->pmu.supported_cpus);
 
 	return (cpu >= nr_cpu_ids) ? -1 : cpu;
 }
@@ -5355,7 +5352,7 @@ static ssize_t intel_hybrid_get_attr_cpus(struct device *dev,
 	struct x86_hybrid_pmu *pmu =
 		container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
 
-	return cpumap_print_to_pagebuf(true, buf, &pmu->supported_cpus);
+	return cpumap_print_to_pagebuf(true, buf, &pmu->pmu.supported_cpus);
 }
 
 static DEVICE_ATTR(cpus, S_IRUGO, intel_hybrid_get_attr_cpus, NULL);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ad87cb3..02abcac 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -636,7 +636,6 @@ struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	const char			*name;
 	u8				cpu_type;
-	cpumask_t			supported_cpus;
 	union perf_capabilities		intel_cap;
 	u64				intel_ctrl;
 	int				max_pebs_events;
-- 
2.7.4

