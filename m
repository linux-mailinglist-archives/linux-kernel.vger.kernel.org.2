Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FBF3A4202
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhFKMaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:30:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:62778 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231180AbhFKMaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:30:19 -0400
IronPort-SDR: mKGIVo5NgZNyGuPQ11v85ozEJ6OVK4epF3y6POpnKm2P4ptpf2JEju/UbGQG365wNzZ20pBp36
 MUWgJ/26j3sg==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="269363132"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="269363132"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 05:28:20 -0700
IronPort-SDR: DRSNXBODlKPn1nfs1wGZzPk1nfZOpFEkNbRCz5X+53PunBd2CugsYRxHHFSorKJ+PyplCv0kEj
 Z6UIUlVZPIOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="414434734"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jun 2021 05:28:19 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/1] perf/x86/intel: Fix fixed counter check warning for some ADL
Date:   Fri, 11 Jun 2021 05:14:22 -0700
Message-Id: <1623413662-18373-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

For some ADL machine, the below fixed counter check warning may be
triggered.

[    2.010766] hw perf events fixed 5 > max(4), clipping!

Current perf unconditionally increases the number of the GP counters and
the fixed counters for a big core PMU on an ADL system, because the
number enumerated in the CPUID only reflects the common counters. The
big core may has more counters. However, ADL may have an alternative
configuration. With that configuration, the X86_FEATURE_HYBRID_CPU is
not set. The number of the GP counters and fixed counters enumerated in
the CPUID is accurate. Perf mistakenly increases the number of counters.
The warning is triggered.

Directly use the enumerated value on the system with the alternative
configuration.

Fixes: f83d2f91d259 ("perf/x86/intel: Add Alder Lake Hybrid support")
Reported-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e00b0f3..63e2bb1 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6374,8 +6374,13 @@ __init int intel_pmu_init(void)
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
 		pmu->name = "cpu_core";
 		pmu->cpu_type = hybrid_big;
-		pmu->num_counters = x86_pmu.num_counters + 2;
-		pmu->num_counters_fixed = x86_pmu.num_counters_fixed + 1;
+		if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)) {
+			pmu->num_counters = x86_pmu.num_counters + 2;
+			pmu->num_counters_fixed = x86_pmu.num_counters_fixed + 1;
+		} else {
+			pmu->num_counters = x86_pmu.num_counters;
+			pmu->num_counters_fixed = x86_pmu.num_counters_fixed;
+		}
 		pmu->max_pebs_events = min_t(unsigned, MAX_PEBS_EVENTS, pmu->num_counters);
 		pmu->unconstrained = (struct event_constraint)
 					__EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
-- 
2.7.4

