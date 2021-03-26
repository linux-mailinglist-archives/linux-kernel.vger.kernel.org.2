Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB9534AEF6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhCZTJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:09:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:27815 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230159AbhCZTI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:08:58 -0400
IronPort-SDR: gr1UAofSwtehp/l9q+hRS7GhvHZEo5Jlf4xf0P7A+bsdPqxPK63k/NkHqC2rhEaKgGoIw8SPIq
 gneASJ8pXsyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="191234784"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="191234784"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 12:08:57 -0700
IronPort-SDR: FxTeLh8zko9ekrmkrlbvrOpHfNXxF/g+gpC5x3sUd5xqz1xpcSLTDyMBsyqGqI53/Z89+LCsGc
 iOHHb/Q9yI0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="392321082"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2021 12:08:57 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 08/25] perf/x86: Hybrid PMU support for hardware cache event
Date:   Fri, 26 Mar 2021 12:01:55 -0700
Message-Id: <1616785332-165261-9-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616785332-165261-1-git-send-email-kan.liang@linux.intel.com>
References: <1616785332-165261-1-git-send-email-kan.liang@linux.intel.com>
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
index 665fa0b..c9974d0 100644
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
 
 static __always_inline bool is_hybrid(void)
-- 
2.7.4

