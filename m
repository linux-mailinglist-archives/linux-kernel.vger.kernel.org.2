Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F6A352455
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbhDBARz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:17:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:48430 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236472AbhDBARq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:17:46 -0400
IronPort-SDR: KUKBg2qYmxUZp2pY96+iAKWhNx+0opc8/3oCsyhyb9ESz6FpsXeb3cHcLYTFACqwsdW32kl2kX
 UZK+78q2cAeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="171775037"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="171775037"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 17:17:46 -0700
IronPort-SDR: fT+eeuA/B7QIF1pVB1h1hB8YT8tLEEBg+qWINVMMdoGwEL7H3PEZacJkc0LMdpiKV3GBOM/a7Q
 q9n1rPg6gAEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="528399337"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2021 17:17:45 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 11/25] perf/x86/intel: Factor out intel_pmu_check_num_counters
Date:   Thu,  1 Apr 2021 17:10:38 -0700
Message-Id: <1617322252-154215-12-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
References: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
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
index b5b7694..9394646 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5070,6 +5070,26 @@ static const struct attribute_group *attr_update[] = {
 
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
@@ -5709,20 +5729,10 @@ __init int intel_pmu_init(void)
 
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

