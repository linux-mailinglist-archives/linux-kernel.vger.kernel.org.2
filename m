Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE77334362
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhCJQoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:44:24 -0500
Received: from mga03.intel.com ([134.134.136.65]:37313 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232815AbhCJQoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:44:01 -0500
IronPort-SDR: z9stkwKcvYK9Tx/an/+urFA5CqTYWmCy6OQM/2q+sP4Zl01c9EY13CtVArOoWvD1zdFxPhG5qQ
 W6eVzyd4ZL/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188546478"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="188546478"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:44:01 -0800
IronPort-SDR: 8SYtGhFgtAaJr/0WbN7OmKNKQzjFxwCfEjn+NqmwiG+JR7DEjO+RYAGWUNL6R4SubHWdBS4aUa
 Ei3wHNKNqLHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="509729243"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 08:44:00 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 13/25] perf/x86/intel: Factor out intel_pmu_check_extra_regs
Date:   Wed, 10 Mar 2021 08:37:49 -0800
Message-Id: <1615394281-68214-14-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Each Hybrid PMU has to check and update its own extra registers before
registration.

The intel_pmu_check_extra_regs will be reused later when registering a
dedicated hybrid PMU.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6df8edd7..cdfbab3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4278,6 +4278,28 @@ static void intel_pmu_check_event_constraints(struct event_constraint *event_con
 	}
 }
 
+static bool check_msr(unsigned long msr, u64 mask);
+
+static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs)
+{
+	struct extra_reg *er;
+
+	/*
+	 * Access extra MSR may cause #GP under certain circumstances.
+	 * E.g. KVM doesn't support offcore event
+	 * Check all extra_regs here.
+	 */
+	if (!extra_regs)
+		return;
+
+	for (er = extra_regs; er->msr; er++) {
+		er->extra_msr_access = check_msr(er->msr, 0x11UL);
+		/* Disable LBR select mapping */
+		if ((er->idx == EXTRA_REG_LBR) && !er->extra_msr_access)
+			x86_pmu.lbr_sel_map = NULL;
+	}
+}
+
 static void intel_pmu_cpu_starting(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
@@ -5141,7 +5163,6 @@ __init int intel_pmu_init(void)
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
 	unsigned int fixed_mask;
-	struct extra_reg *er;
 	bool pmem = false;
 	int version, i;
 	char *name;
@@ -5798,19 +5819,7 @@ __init int intel_pmu_init(void)
 	if (x86_pmu.lbr_nr)
 		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
 
-	/*
-	 * Access extra MSR may cause #GP under certain circumstances.
-	 * E.g. KVM doesn't support offcore event
-	 * Check all extra_regs here.
-	 */
-	if (x86_pmu.extra_regs) {
-		for (er = x86_pmu.extra_regs; er->msr; er++) {
-			er->extra_msr_access = check_msr(er->msr, 0x11UL);
-			/* Disable LBR select mapping */
-			if ((er->idx == EXTRA_REG_LBR) && !er->extra_msr_access)
-				x86_pmu.lbr_sel_map = NULL;
-		}
-	}
+	intel_pmu_check_extra_regs(x86_pmu.extra_regs);
 
 	/* Support full width counters using alternative MSR range */
 	if (x86_pmu.intel_cap.full_width_write) {
-- 
2.7.4

