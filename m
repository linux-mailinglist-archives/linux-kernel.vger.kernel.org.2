Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B0F313C32
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhBHSEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:04:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:62780 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234086AbhBHPiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:38:13 -0500
IronPort-SDR: 8ISEGD52x/XENsH/WNjCl7+MNyij3veuK1sjaJ8IlC0ydrwX7qOOtjrjJFtOsdf4rKuQt+ho7f
 Kvkl5fIwesYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180951934"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180951934"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:09 -0800
IronPort-SDR: zbIXFgffOvj9BA9TLdwc02gBsS7UiPVdySTM+00PhwjN1ZFlW1jgszrKs2L0nGB/127nhtNPPI
 eub7CJZy2eHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820624"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:09 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 11/49] perf/x86/intel: Factor out intel_pmu_check_event_constraints
Date:   Mon,  8 Feb 2021 07:25:08 -0800
Message-Id: <1612797946-18784-12-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
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
index 2c02e1e..529bb7d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4239,6 +4239,49 @@ static void intel_pmu_check_num_counters(int *num_counters,
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
@@ -5098,7 +5141,6 @@ __init int intel_pmu_init(void)
 	union cpuid10_edx edx;
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
-	struct event_constraint *c;
 	unsigned int fixed_mask;
 	struct extra_reg *er;
 	bool pmem = false;
@@ -5736,40 +5778,10 @@ __init int intel_pmu_init(void)
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

