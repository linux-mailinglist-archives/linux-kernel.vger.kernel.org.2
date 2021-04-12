Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A3635C8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242511AbhDLOjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:39:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:29206 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242393AbhDLOio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:38:44 -0400
IronPort-SDR: g2PTm1i/FR29I8/+v/XxJ3Vd26lLgSPd4OeHM/8pW/Yta0JgVfIPEcz39CdJ4mLzpStQ9aKOPH
 Razt2FWvxYgg==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194317974"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="194317974"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 07:38:25 -0700
IronPort-SDR: KwnJBnsn9ABGhSZ6s6KSU/iPPiBuQSakJ/8YgzMpZTYpHFddY5GnpjawKFBFewTDsf4J2RmAQQ
 mBU7AR/OZDrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="398392793"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 12 Apr 2021 07:38:25 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, ricardo.neri-calderon@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 11/25] perf/x86/intel: Factor out intel_pmu_check_num_counters
Date:   Mon, 12 Apr 2021 07:30:51 -0700
Message-Id: <1618237865-33448-12-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618237865-33448-1-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Each Hybrid PMU has to check its own number of counters and mask fixed
counters before registration.

The intel_pmu_check_num_counters will be reused later to check the
number of the counters for each hybrid PMU.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f727aa5..d7e2021 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5064,6 +5064,26 @@ static const struct attribute_group *attr_update[] = {
 
 static struct attribute *empty_attrs;
 
+static void intel_pmu_check_num_counters(int *num_counters,
+					 int *num_counters_fixed,
+					 u64 *intel_ctrl, u64 fixed_mask)
+{
+	if (*num_counters > INTEL_PMC_MAX_GENERIC) {
+		WARN(1, KERN_ERR "hw perf events %d > max(%d), clipping!",
+		     *num_counters, INTEL_PMC_MAX_GENERIC);
+		*num_counters = INTEL_PMC_MAX_GENERIC;
+	}
+	*intel_ctrl = (1ULL << *num_counters) - 1;
+
+	if (*num_counters_fixed > INTEL_PMC_MAX_FIXED) {
+		WARN(1, KERN_ERR "hw perf events fixed %d > max(%d), clipping!",
+		     *num_counters_fixed, INTEL_PMC_MAX_FIXED);
+		*num_counters_fixed = INTEL_PMC_MAX_FIXED;
+	}
+
+	*intel_ctrl |= fixed_mask << INTEL_PMC_IDX_FIXED;
+}
+
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_skl_attr = &empty_attrs;
@@ -5703,20 +5723,10 @@ __init int intel_pmu_init(void)
 
 	x86_pmu.attr_update = attr_update;
 
-	if (x86_pmu.num_counters > INTEL_PMC_MAX_GENERIC) {
-		WARN(1, KERN_ERR "hw perf events %d > max(%d), clipping!",
-		     x86_pmu.num_counters, INTEL_PMC_MAX_GENERIC);
-		x86_pmu.num_counters = INTEL_PMC_MAX_GENERIC;
-	}
-	x86_pmu.intel_ctrl = (1ULL << x86_pmu.num_counters) - 1;
-
-	if (x86_pmu.num_counters_fixed > INTEL_PMC_MAX_FIXED) {
-		WARN(1, KERN_ERR "hw perf events fixed %d > max(%d), clipping!",
-		     x86_pmu.num_counters_fixed, INTEL_PMC_MAX_FIXED);
-		x86_pmu.num_counters_fixed = INTEL_PMC_MAX_FIXED;
-	}
-
-	x86_pmu.intel_ctrl |= (u64)fixed_mask << INTEL_PMC_IDX_FIXED;
+	intel_pmu_check_num_counters(&x86_pmu.num_counters,
+				     &x86_pmu.num_counters_fixed,
+				     &x86_pmu.intel_ctrl,
+				     (u64)fixed_mask);
 
 	/* AnyThread may be deprecated on arch perfmon v5 or later */
 	if (x86_pmu.intel_cap.anythread_deprecated)
-- 
2.7.4

