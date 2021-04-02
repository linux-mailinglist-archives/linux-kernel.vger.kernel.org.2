Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4FA352452
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbhDBARs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:17:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:48424 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236415AbhDBARn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:17:43 -0400
IronPort-SDR: XfJfRg/OujnxnxF+YaGx5C222sO7zlXM2jlhYdKj0PjhJnfMJ8YeH2GlGK0CnqfoOMJ/gbc9Cw
 Ygy4Dt3HB5tQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="171775023"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="171775023"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 17:17:42 -0700
IronPort-SDR: qBEeJR1aq/LDfKD3MewyLqf1MxL0mjE1vn2P/87rBfYu01ryxPXWwz+/MrIm+SFJDN2r40MbQL
 JIq42pFxPlnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="528399297"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2021 17:17:42 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 08/25] perf/x86: Hybrid PMU support for hardware cache event
Date:   Thu,  1 Apr 2021 17:10:35 -0700
Message-Id: <1617322252-154215-9-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
References: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The hardware cache events are different among hybrid PMUs. Each hybrid
PMU should have its own hw cache event table.

The hw_cache_extra_regs is not part of the struct x86_pmu, the hybrid()
cannot be applied here.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 11 +++++++++--
 arch/x86/events/perf_event.h |  9 +++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0bd9554..d71ca69 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -356,6 +356,7 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
 	unsigned int cache_type, cache_op, cache_result;
+	struct x86_hybrid_pmu *pmu = is_hybrid() ? hybrid_pmu(event->pmu) : NULL;
 	u64 config, val;
 
 	config = attr->config;
@@ -375,7 +376,10 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
 		return -EINVAL;
 	cache_result = array_index_nospec(cache_result, PERF_COUNT_HW_CACHE_RESULT_MAX);
 
-	val = hw_cache_event_ids[cache_type][cache_op][cache_result];
+	if (pmu)
+		val = pmu->hw_cache_event_ids[cache_type][cache_op][cache_result];
+	else
+		val = hw_cache_event_ids[cache_type][cache_op][cache_result];
 
 	if (val == 0)
 		return -ENOENT;
@@ -384,7 +388,10 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
 		return -EINVAL;
 
 	hwc->config |= val;
-	attr->config1 = hw_cache_extra_regs[cache_type][cache_op][cache_result];
+	if (pmu)
+		attr->config1 = pmu->hw_cache_extra_regs[cache_type][cache_op][cache_result];
+	else
+		attr->config1 = hw_cache_extra_regs[cache_type][cache_op][cache_result];
 	return x86_pmu_extra_regs(val, event);
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index cfb2da0..203c165 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -640,6 +640,15 @@ struct x86_hybrid_pmu {
 	int				num_counters;
 	int				num_counters_fixed;
 	struct event_constraint		unconstrained;
+
+	u64				hw_cache_event_ids
+					[PERF_COUNT_HW_CACHE_MAX]
+					[PERF_COUNT_HW_CACHE_OP_MAX]
+					[PERF_COUNT_HW_CACHE_RESULT_MAX];
+	u64				hw_cache_extra_regs
+					[PERF_COUNT_HW_CACHE_MAX]
+					[PERF_COUNT_HW_CACHE_OP_MAX]
+					[PERF_COUNT_HW_CACHE_RESULT_MAX];
 };
 
 static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
-- 
2.7.4

