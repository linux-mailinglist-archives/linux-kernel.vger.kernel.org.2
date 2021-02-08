Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AFE313CDA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbhBHSKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:10:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:62780 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232951AbhBHPkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:40:15 -0500
IronPort-SDR: IaIvcLkojd5z0RcSZ+QO9xZmn/BaczDFQft+XPPMAiKL9ThQ7gQtIus9S8+pzlEwYQWe0ubcyD
 IczA8qF2uWOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180951954"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180951954"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:16 -0800
IronPort-SDR: T5WFWo68vi0mqIQBnpQir4DpplAjqk+aXaeOpyzPMVldYZgzNmafd2pZdvCENSX4tLUDivp+GO
 0nAojvnbbO/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820667"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:16 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 15/49] perf/x86: Factor out x86_pmu_show_pmu_cap
Date:   Mon,  8 Feb 2021 07:25:12 -0800
Message-Id: <1612797946-18784-16-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
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
index bdcd3ad..bbd87b7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1979,6 +1979,20 @@ perf_guest_get_msrs_nop(int *nr)
 	return NULL;
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
@@ -2039,15 +2053,8 @@ static int __init init_hw_perf_events(void)
 
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
index 560410c..d5fcc15 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1089,6 +1089,9 @@ void x86_pmu_enable_event(struct perf_event *event);
 
 int x86_pmu_handle_irq(struct pt_regs *regs);
 
+void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
+			  u64 intel_ctrl);
+
 extern struct event_constraint emptyconstraint;
 
 extern struct event_constraint unconstrained;
-- 
2.7.4

