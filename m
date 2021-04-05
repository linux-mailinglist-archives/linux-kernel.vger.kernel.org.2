Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF48354351
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 17:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbhDEPSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 11:18:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:43412 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241494AbhDEPSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 11:18:25 -0400
IronPort-SDR: I/olr37+Q7HXYNhUBNIlDrqRoICAsmTibvty6Ugi+F3PSLge3rFNpaGv20WOWgvcrjx8MfbRDA
 XLt63pugtG0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="180402958"
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; 
   d="scan'208";a="180402958"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 08:18:17 -0700
IronPort-SDR: oKh/XHg0BtvCAzgO9rbMWP/aNUsMJNIowl1Mo9WjX5rDmKj1+metRK9ONqnoiZia8R1AmpNINR
 ZcTFQ2lhpvXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; 
   d="scan'208";a="379006319"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 05 Apr 2021 08:18:17 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, ricardo.neri-calderon@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 13/25] perf/x86/intel: Factor out intel_pmu_check_extra_regs
Date:   Mon,  5 Apr 2021 08:10:55 -0700
Message-Id: <1617635467-181510-14-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
References: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Each Hybrid PMU has to check and update its own extra registers before
registration.

The intel_pmu_check_extra_regs will be reused later to check the extra
registers of each hybrid PMU.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 53a2e2e..d1a13e0 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5133,6 +5133,26 @@ static void intel_pmu_check_event_constraints(struct event_constraint *event_con
 	}
 }
 
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
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_skl_attr = &empty_attrs;
@@ -5144,7 +5164,6 @@ __init int intel_pmu_init(void)
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
 	unsigned int fixed_mask;
-	struct extra_reg *er;
 	bool pmem = false;
 	int version, i;
 	char *name;
@@ -5801,19 +5820,7 @@ __init int intel_pmu_init(void)
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

