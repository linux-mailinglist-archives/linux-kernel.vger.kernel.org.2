Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5169C334361
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhCJQoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:44:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:37313 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232787AbhCJQoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:44:00 -0500
IronPort-SDR: s0mx4TrMvGF5gck2xT3lMkCnG881t7+t294ZGdrqSOIW/xmMiaM7kh55nQDHXtg49Top2j4r7r
 8aU0fFddm2yQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188546474"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="188546474"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:43:59 -0800
IronPort-SDR: EPfSBPZ81jLZRxxlUScQ8SoHQOinsbrPiKsxkRJwyaTWC9E81UEic1RCcxnWmmsfWlTlzl6XcQ
 KutoWpzOx5ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="509729225"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 08:43:59 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 12/25] perf/x86/intel: Factor out intel_pmu_check_event_constraints
Date:   Wed, 10 Mar 2021 08:37:48 -0800
Message-Id: <1615394281-68214-13-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Each Hybrid PMU has to check and update its own event constraints before
registration.

The intel_pmu_check_event_constraints will be reused later when
registering a dedicated hybrid PMU.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 82 +++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2da6ae2..6df8edd7 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4235,6 +4235,49 @@ static void intel_pmu_check_num_counters(int *num_counters,
 	*intel_ctrl |= fixed_mask << INTEL_PMC_IDX_FIXED;
 }
 
+static void intel_pmu_check_event_constraints(struct event_constraint *event_constraints,
+					      int num_counters,
+					      int num_counters_fixed,
+					      u64 intel_ctrl)
+{
+	struct event_constraint *c;
+
+	if (!event_constraints)
+		return;
+
+	/*
+	 * event on fixed counter2 (REF_CYCLES) only works on this
+	 * counter, so do not extend mask to generic counters
+	 */
+	for_each_event_constraint(c, event_constraints) {
+		/*
+		 * Don't extend the topdown slots and metrics
+		 * events to the generic counters.
+		 */
+		if (c->idxmsk64 & INTEL_PMC_MSK_TOPDOWN) {
+			/*
+			 * Disable topdown slots and metrics events,
+			 * if slots event is not in CPUID.
+			 */
+			if (!(INTEL_PMC_MSK_FIXED_SLOTS & intel_ctrl))
+				c->idxmsk64 = 0;
+			c->weight = hweight64(c->idxmsk64);
+			continue;
+		}
+
+		if (c->cmask == FIXED_EVENT_FLAGS) {
+			/* Disabled fixed counters which are not in CPUID */
+			c->idxmsk64 &= intel_ctrl;
+
+			if (c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES)
+				c->idxmsk64 |= (1ULL << num_counters) - 1;
+		}
+		c->idxmsk64 &=
+			~(~0ULL << (INTEL_PMC_IDX_FIXED + num_counters_fixed));
+		c->weight = hweight64(c->idxmsk64);
+	}
+}
+
 static void intel_pmu_cpu_starting(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
@@ -5097,7 +5140,6 @@ __init int intel_pmu_init(void)
 	union cpuid10_edx edx;
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
-	struct event_constraint *c;
 	unsigned int fixed_mask;
 	struct extra_reg *er;
 	bool pmem = false;
@@ -5735,40 +5777,10 @@ __init int intel_pmu_init(void)
 	if (x86_pmu.intel_cap.anythread_deprecated)
 		x86_pmu.format_attrs = intel_arch_formats_attr;
 
-	if (x86_pmu.event_constraints) {
-		/*
-		 * event on fixed counter2 (REF_CYCLES) only works on this
-		 * counter, so do not extend mask to generic counters
-		 */
-		for_each_event_constraint(c, x86_pmu.event_constraints) {
-			/*
-			 * Don't extend the topdown slots and metrics
-			 * events to the generic counters.
-			 */
-			if (c->idxmsk64 & INTEL_PMC_MSK_TOPDOWN) {
-				/*
-				 * Disable topdown slots and metrics events,
-				 * if slots event is not in CPUID.
-				 */
-				if (!(INTEL_PMC_MSK_FIXED_SLOTS & x86_pmu.intel_ctrl))
-					c->idxmsk64 = 0;
-				c->weight = hweight64(c->idxmsk64);
-				continue;
-			}
-
-			if (c->cmask == FIXED_EVENT_FLAGS) {
-				/* Disabled fixed counters which are not in CPUID */
-				c->idxmsk64 &= x86_pmu.intel_ctrl;
-
-				if (c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES)
-					c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
-			}
-			c->idxmsk64 &=
-				~(~0ULL << (INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed));
-			c->weight = hweight64(c->idxmsk64);
-		}
-	}
-
+	intel_pmu_check_event_constraints(x86_pmu.event_constraints,
+					  x86_pmu.num_counters,
+					  x86_pmu.num_counters_fixed,
+					  x86_pmu.intel_ctrl);
 	/*
 	 * Access LBR MSR may cause #GP under certain circumstances.
 	 * E.g. KVM doesn't support LBR MSR
-- 
2.7.4

