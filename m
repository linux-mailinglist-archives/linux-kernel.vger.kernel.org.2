Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C61435245E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbhDBASQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:18:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:36449 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236548AbhDBARz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:17:55 -0400
IronPort-SDR: 22aVzCvV9KOeiCUasVUVelNtrFrCypzzdR+WjS1SIk3lIicY2sfxIzazingsDYKnvESiL0ksBP
 0muNeYxSfsiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="253696053"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="253696053"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 17:17:40 -0700
IronPort-SDR: N2ga4wVBpk6tFHRl29UEAY4oj9k4EJFMRJIFvUjap+ltnRBInEdheyunJSfSBQEARaiqSKVEZG
 T5Df+Azyy+vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="528399259"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2021 17:17:37 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 03/25] perf/x86: Track pmu in per-CPU cpu_hw_events
Date:   Thu,  1 Apr 2021 17:10:30 -0700
Message-Id: <1617322252-154215-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
References: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some platforms, e.g. Alder Lake, have hybrid architecture. In the same
package, there may be more than one type of CPU. The PMU capabilities
are different among different types of CPU. Perf will register a
dedicated PMU for each type of CPU.

Add a 'pmu' variable in the struct cpu_hw_events to track the dedicated
PMU of the current CPU.

Current x86_get_pmu() use the global 'pmu', which will be broken on a
hybrid platform. Modify it to apply the 'pmu' of the specific CPU.

Initialize the per-CPU 'pmu' variable with the global 'pmu'. There is
nothing changed for the non-hybrid platforms.

The is_x86_event() will be updated in the later patch ("perf/x86:
Register hybrid PMUs") for hybrid platforms. For the non-hybrid
platforms, nothing is changed here.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 17 +++++++++++++----
 arch/x86/events/intel/core.c |  2 +-
 arch/x86/events/intel/ds.c   |  4 ++--
 arch/x86/events/intel/lbr.c  |  9 +++++----
 arch/x86/events/perf_event.h |  4 +++-
 5 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 18df171..e564e96 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -45,9 +45,11 @@
 #include "perf_event.h"
 
 struct x86_pmu x86_pmu __read_mostly;
+static struct pmu pmu;
 
 DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
 	.enabled = 1,
+	.pmu = &pmu,
 };
 
 DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
@@ -724,16 +726,23 @@ void x86_pmu_enable_all(int added)
 	}
 }
 
-static struct pmu pmu;
-
 static inline int is_x86_event(struct perf_event *event)
 {
 	return event->pmu == &pmu;
 }
 
-struct pmu *x86_get_pmu(void)
+struct pmu *x86_get_pmu(unsigned int cpu)
 {
-	return &pmu;
+	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
+
+	/*
+	 * All CPUs of the hybrid type have been offline.
+	 * The x86_get_pmu() should not be invoked.
+	 */
+	if (WARN_ON_ONCE(!cpuc->pmu))
+		return &pmu;
+
+	return cpuc->pmu;
 }
 /*
  * Event scheduler state:
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7bbb5bb..f116c63 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4876,7 +4876,7 @@ static void update_tfa_sched(void *ignored)
 	 * and if so force schedule out for all event types all contexts
 	 */
 	if (test_bit(3, cpuc->active_mask))
-		perf_pmu_resched(x86_get_pmu());
+		perf_pmu_resched(x86_get_pmu(smp_processor_id()));
 }
 
 static ssize_t show_sysctl_tfa(struct device *cdev,
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7ebae18..1bfea8c 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2192,7 +2192,7 @@ void __init intel_ds_init(void)
 					PERF_SAMPLE_TIME;
 				x86_pmu.flags |= PMU_FL_PEBS_ALL;
 				pebs_qual = "-baseline";
-				x86_get_pmu()->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 			} else {
 				/* Only basic record supported */
 				x86_pmu.large_pebs_flags &=
@@ -2207,7 +2207,7 @@ void __init intel_ds_init(void)
 
 			if (x86_pmu.intel_cap.pebs_output_pt_available) {
 				pr_cont("PEBS-via-PT, ");
-				x86_get_pmu()->capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
+				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
 			}
 
 			break;
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 21890da..bb4486c 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -705,7 +705,7 @@ void intel_pmu_lbr_add(struct perf_event *event)
 
 void release_lbr_buffers(void)
 {
-	struct kmem_cache *kmem_cache = x86_get_pmu()->task_ctx_cache;
+	struct kmem_cache *kmem_cache;
 	struct cpu_hw_events *cpuc;
 	int cpu;
 
@@ -714,6 +714,7 @@ void release_lbr_buffers(void)
 
 	for_each_possible_cpu(cpu) {
 		cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
+		kmem_cache = x86_get_pmu(cpu)->task_ctx_cache;
 		if (kmem_cache && cpuc->lbr_xsave) {
 			kmem_cache_free(kmem_cache, cpuc->lbr_xsave);
 			cpuc->lbr_xsave = NULL;
@@ -1609,7 +1610,7 @@ void intel_pmu_lbr_init_hsw(void)
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = hsw_lbr_sel_map;
 
-	x86_get_pmu()->task_ctx_cache = create_lbr_kmem_cache(size, 0);
+	x86_get_pmu(smp_processor_id())->task_ctx_cache = create_lbr_kmem_cache(size, 0);
 
 	if (lbr_from_signext_quirk_needed())
 		static_branch_enable(&lbr_from_quirk_key);
@@ -1629,7 +1630,7 @@ __init void intel_pmu_lbr_init_skl(void)
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = hsw_lbr_sel_map;
 
-	x86_get_pmu()->task_ctx_cache = create_lbr_kmem_cache(size, 0);
+	x86_get_pmu(smp_processor_id())->task_ctx_cache = create_lbr_kmem_cache(size, 0);
 
 	/*
 	 * SW branch filter usage:
@@ -1726,7 +1727,7 @@ static bool is_arch_lbr_xsave_available(void)
 
 void __init intel_pmu_arch_lbr_init(void)
 {
-	struct pmu *pmu = x86_get_pmu();
+	struct pmu *pmu = x86_get_pmu(smp_processor_id());
 	union cpuid28_eax eax;
 	union cpuid28_ebx ebx;
 	union cpuid28_ecx ecx;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 53b2b5f..3e19ca5 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -327,6 +327,8 @@ struct cpu_hw_events {
 	int				n_pair; /* Large increment events */
 
 	void				*kfree_on_online[X86_PERF_KFREE_MAX];
+
+	struct pmu			*pmu;
 };
 
 #define __EVENT_CONSTRAINT_RANGE(c, e, n, m, w, o, f) {	\
@@ -905,7 +907,7 @@ static struct perf_pmu_events_ht_attr event_attr_##v = {		\
 	.event_str_ht	= ht,						\
 }
 
-struct pmu *x86_get_pmu(void);
+struct pmu *x86_get_pmu(unsigned int cpu);
 extern struct x86_pmu x86_pmu __read_mostly;
 
 static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
-- 
2.7.4

