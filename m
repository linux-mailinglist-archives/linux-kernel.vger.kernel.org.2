Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4306C313C0E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbhBHSAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:00:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:62778 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhBHPfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:35:10 -0500
IronPort-SDR: Z362ajy6HBttU4XwpR5gvN5a5+ir/K/ry+NvYIcBI0KL2mMBYBO2Hd2Wc4GVqhj8HN3nn/O45f
 yqL5gjH2Dhcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180951913"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180951913"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:05 -0800
IronPort-SDR: ffqec0gJwBQNeCaN6BgkVo0e4hjTkTH/pZqcMxlf5hRAwKZWJsurBnbzhPN0aaCbuNLnl100Mk
 fUvqW7zH8Odg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820564"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:05 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 07/49] perf/x86: Hybrid PMU support for hardware cache event
Date:   Mon,  8 Feb 2021 07:25:04 -0800
Message-Id: <1612797946-18784-8-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The hardware cache events are different among hybrid PMUs. Each hybrid
PMU should have its own hw cache event table.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 11 +++++++++--
 arch/x86/events/perf_event.h |  9 +++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5f79b37..27c87a7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -351,6 +351,7 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
 	unsigned int cache_type, cache_op, cache_result;
+	struct x86_hybrid_pmu *pmu = IS_X86_HYBRID ? container_of(event->pmu, struct x86_hybrid_pmu, pmu) : NULL;
 	u64 config, val;
 
 	config = attr->config;
@@ -370,7 +371,10 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
 		return -EINVAL;
 	cache_result = array_index_nospec(cache_result, PERF_COUNT_HW_CACHE_RESULT_MAX);
 
-	val = hw_cache_event_ids[cache_type][cache_op][cache_result];
+	if (pmu)
+		val = pmu->hw_cache_event_ids[cache_type][cache_op][cache_result];
+	else
+		val = hw_cache_event_ids[cache_type][cache_op][cache_result];
 
 	if (val == 0)
 		return -ENOENT;
@@ -379,7 +383,10 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
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
index f11dbc4..00fcd92 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -652,6 +652,15 @@ struct x86_hybrid_pmu {
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
 
 #define IS_X86_HYBRID			cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)
-- 
2.7.4

