Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C102D33435D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhCJQoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:44:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:37313 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232650AbhCJQny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:43:54 -0500
IronPort-SDR: 8DU9HqsPbig1As6DDRYi6QrXLptqKN+209ycgcxMyD0QN355mS+f47hzqwQMnemqEpYyBmPnuo
 yRaHJQ+YK06w==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188546453"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="188546453"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:43:54 -0800
IronPort-SDR: rfw0RJHuxpsg56BTjXYPvt/Tr77PWwv6PEB7FxnJuOUo1+BX7XMwWncqV7GUFnzTzCll2hIP/a
 /jCJ4D9y541A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="509729157"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 08:43:54 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 08/25] perf/x86: Hybrid PMU support for hardware cache event
Date:   Wed, 10 Mar 2021 08:37:44 -0800
Message-Id: <1615394281-68214-9-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
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
index 039a851..1db4a67 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -352,6 +352,7 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
 	unsigned int cache_type, cache_op, cache_result;
+	struct x86_hybrid_pmu *pmu = is_hybrid() ? hybrid_pmu(event->pmu) : NULL;
 	u64 config, val;
 
 	config = attr->config;
@@ -371,7 +372,10 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
 		return -EINVAL;
 	cache_result = array_index_nospec(cache_result, PERF_COUNT_HW_CACHE_RESULT_MAX);
 
-	val = hw_cache_event_ids[cache_type][cache_op][cache_result];
+	if (pmu)
+		val = pmu->hw_cache_event_ids[cache_type][cache_op][cache_result];
+	else
+		val = hw_cache_event_ids[cache_type][cache_op][cache_result];
 
 	if (val == 0)
 		return -ENOENT;
@@ -380,7 +384,10 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
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
index 7bce193..f464bda 100644
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

