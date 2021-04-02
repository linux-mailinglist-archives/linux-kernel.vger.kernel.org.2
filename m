Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE368352457
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbhDBASC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:18:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:48424 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236524AbhDBARt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:17:49 -0400
IronPort-SDR: uuBNGnKPZp8d0N0Rtw62sy6Lhb1oc/joTa9ot6P5H/10Zwvqno+rMY80ygl+qiSTocWJXgLdaq
 6daLfmWqlzYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="171775040"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="171775040"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 17:17:47 -0700
IronPort-SDR: 9MKDjPVJfTlOmH46vLULb04V3b1IZ4cZFUMXfrzOgOIU70FOWzo2SoEDfjqs+AB7mteBYlrS/C
 MupKNfq5Twag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="528399351"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2021 17:17:47 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 13/25] perf/x86/intel: Factor out intel_pmu_check_extra_regs
Date:   Thu,  1 Apr 2021 17:10:40 -0700
Message-Id: <1617322252-154215-14-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
References: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
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

