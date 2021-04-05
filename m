Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6EA35434D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 17:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbhDEPSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 11:18:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:43412 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241490AbhDEPSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 11:18:21 -0400
IronPort-SDR: 22+wemizZW2h+fFu891MVF8OGoUInURJCa2z/6eHYU/ZQsxu96sMreyYBGusuMKIrKGhoyDo3N
 GImgdOelWYjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="180402946"
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; 
   d="scan'208";a="180402946"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 08:18:13 -0700
IronPort-SDR: HOVRUkYg62J+cn8c2zJPZ2iYhiYoIyKtScomZfBiBhl/mBRgknW7uloeJFf/jJ1rKmJRrEygae
 EzQ9jmfy+8cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; 
   d="scan'208";a="379006262"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 05 Apr 2021 08:18:13 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, ricardo.neri-calderon@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 08/25] perf/x86: Hybrid PMU support for hardware cache event
Date:   Mon,  5 Apr 2021 08:10:50 -0700
Message-Id: <1617635467-181510-9-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
References: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
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

