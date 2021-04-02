Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9198D352459
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbhDBASH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:18:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:48434 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236550AbhDBARv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:17:51 -0400
IronPort-SDR: uO0LIJzPtKMQcNN+FdLPGEOlTAoMrI+389ERFhCBQIWqbBKc753MTpdtA44Wh5+/FelWVGOGV2
 S526IDvsDl4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="171775045"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="171775045"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 17:17:49 -0700
IronPort-SDR: Wdc4pxWzLb/KqMQkOZmdCfUQvMwXTZXd6HC6HEIobiwfs/d0pHRjmci5CjkZnlPsBttFO4RPlF
 3yW+xa4Rlltw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="528399363"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2021 17:17:49 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 15/25] perf/x86: Factor out x86_pmu_show_pmu_cap
Date:   Thu,  1 Apr 2021 17:10:42 -0700
Message-Id: <1617322252-154215-16-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
References: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The PMU capabilities are different among hybrid PMUs. Perf should dump
the PMU capabilities information for each hybrid PMU.

Factor out x86_pmu_show_pmu_cap() which shows the PMU capabilities
information. The function will be reused later when registering a
dedicated hybrid PMU.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 25 ++++++++++++++++---------
 arch/x86/events/perf_event.h |  3 +++
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9c931ec..f9d299b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1984,6 +1984,20 @@ static void _x86_pmu_read(struct perf_event *event)
 	x86_perf_event_update(event);
 }
 
+void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
+			  u64 intel_ctrl)
+{
+	pr_info("... version:                %d\n",     x86_pmu.version);
+	pr_info("... bit width:              %d\n",     x86_pmu.cntval_bits);
+	pr_info("... generic registers:      %d\n",     num_counters);
+	pr_info("... value mask:             %016Lx\n", x86_pmu.cntval_mask);
+	pr_info("... max period:             %016Lx\n", x86_pmu.max_period);
+	pr_info("... fixed-purpose events:   %lu\n",
+			hweight64((((1ULL << num_counters_fixed) - 1)
+					<< INTEL_PMC_IDX_FIXED) & intel_ctrl));
+	pr_info("... event mask:             %016Lx\n", intel_ctrl);
+}
+
 static int __init init_hw_perf_events(void)
 {
 	struct x86_pmu_quirk *quirk;
@@ -2044,15 +2058,8 @@ static int __init init_hw_perf_events(void)
 
 	pmu.attr_update = x86_pmu.attr_update;
 
-	pr_info("... version:                %d\n",     x86_pmu.version);
-	pr_info("... bit width:              %d\n",     x86_pmu.cntval_bits);
-	pr_info("... generic registers:      %d\n",     x86_pmu.num_counters);
-	pr_info("... value mask:             %016Lx\n", x86_pmu.cntval_mask);
-	pr_info("... max period:             %016Lx\n", x86_pmu.max_period);
-	pr_info("... fixed-purpose events:   %lu\n",
-			hweight64((((1ULL << x86_pmu.num_counters_fixed) - 1)
-					<< INTEL_PMC_IDX_FIXED) & x86_pmu.intel_ctrl));
-	pr_info("... event mask:             %016Lx\n", x86_pmu.intel_ctrl);
+	x86_pmu_show_pmu_cap(x86_pmu.num_counters, x86_pmu.num_counters_fixed,
+			     x86_pmu.intel_ctrl);
 
 	if (!x86_pmu.read)
 		x86_pmu.read = _x86_pmu_read;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 5679c12..1da91b7 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1083,6 +1083,9 @@ void x86_pmu_enable_event(struct perf_event *event);
 
 int x86_pmu_handle_irq(struct pt_regs *regs);
 
+void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
+			  u64 intel_ctrl);
+
 extern struct event_constraint emptyconstraint;
 
 extern struct event_constraint unconstrained;
-- 
2.7.4

