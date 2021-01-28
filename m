Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF76430816F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhA1Wu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:50:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:61310 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231704AbhA1Wts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:49:48 -0500
IronPort-SDR: 5L4yoiJGl8IbP9SlJtiZw5z9EYquQS/reN4P1uXyKLSSpCNmikYkaNaTfjQ5H7Kxa40LhD+bLx
 8mAK6H9+Hqrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="244413001"
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="244413001"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 14:45:43 -0800
IronPort-SDR: Po+UIcbRqyB9AsuL+ZOmySJp70qzqxxntGled6Eor0Wze6kWZdf8YGZLnP6PZy2xuEWRPjV0zx
 h4DAcHOTVQIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="389034604"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga008.jf.intel.com with ESMTP; 28 Jan 2021 14:45:42 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, mpe@ellerman.id.au,
        maddy@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 3/5] perf/x86/intel: Filter unsupported Topdown metrics event
Date:   Thu, 28 Jan 2021 14:40:09 -0800
Message-Id: <1611873611-156687-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611873611-156687-1-git-send-email-kan.liang@linux.intel.com>
References: <1611873611-156687-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Intel Sapphire Rapids server will introduce 8 metrics events. Intel
Ice Lake only supports 4 metrics events. A perf tool user may mistakenly
use the unsupported events via RAW format on Ice Lake. The user can
still get a value from the unsupported Topdown metrics event once the
following Sapphire Rapids enabling patch is applied.

To enable the 8 metrics events on Intel Sapphire Rapids, the
INTEL_TD_METRIC_MAX has to be updated, which impacts the
is_metric_event(). The is_metric_event() is a generic function.
On Ice Lake, the newly added SPR metrics events will be mistakenly
accepted as metric events on creation. At runtime, the unsupported
Topdown metrics events will be updated.

Add a variable num_topdown_events in x86_pmu to indicate the available
number of the Topdown metrics event on the platform. Apply the number
into is_metric_event(). Only the supported Topdown metrics events
should be created as metrics events.

Apply the num_topdown_events in icl_update_topdown_event() as well. The
function can be reused by the following patch.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c |  4 +++-
 arch/x86/events/perf_event.h | 22 ++++++++++++++--------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8eba41b..892c753 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2422,7 +2422,8 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
 
 static u64 icl_update_topdown_event(struct perf_event *event)
 {
-	return intel_update_topdown_event(event, INTEL_PMC_IDX_TD_BE_BOUND);
+	return intel_update_topdown_event(event, INTEL_PMC_IDX_METRIC_BASE +
+						 x86_pmu.num_topdown_events - 1);
 }
 
 static void intel_pmu_read_topdown_event(struct perf_event *event)
@@ -5489,6 +5490,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xc9, .umask=0x04);
 		x86_pmu.lbr_pt_coexist = true;
 		intel_pmu_pebs_data_source_skl(pmem);
+		x86_pmu.num_topdown_events = 4;
 		x86_pmu.update_topdown_event = icl_update_topdown_event;
 		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
 		pr_cont("Icelake events, ");
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 7895cf4..89066c8 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -86,14 +86,7 @@ static inline bool is_topdown_count(struct perf_event *event)
 	return event->hw.flags & PERF_X86_EVENT_TOPDOWN;
 }
 
-static inline bool is_metric_event(struct perf_event *event)
-{
-	u64 config = event->attr.config;
-
-	return ((config & ARCH_PERFMON_EVENTSEL_EVENT) == 0) &&
-		((config & INTEL_ARCH_EVENT_MASK) >= INTEL_TD_METRIC_RETIRING)  &&
-		((config & INTEL_ARCH_EVENT_MASK) <= INTEL_TD_METRIC_MAX);
-}
+static inline bool is_metric_event(struct perf_event *event);
 
 static inline bool is_slots_event(struct perf_event *event)
 {
@@ -776,6 +769,7 @@ struct x86_pmu {
 	/*
 	 * Intel perf metrics
 	 */
+	int		num_topdown_events;
 	u64		(*update_topdown_event)(struct perf_event *event);
 	int		(*set_topdown_event_period)(struct perf_event *event);
 
@@ -900,6 +894,18 @@ static struct perf_pmu_events_ht_attr event_attr_##v = {		\
 struct pmu *x86_get_pmu(void);
 extern struct x86_pmu x86_pmu __read_mostly;
 
+#define INTEL_TD_METRIC_AVAILABLE_MAX	(INTEL_TD_METRIC_RETIRING + \
+					 ((x86_pmu.num_topdown_events - 1) << 8))
+
+static inline bool is_metric_event(struct perf_event *event)
+{
+	u64 config = event->attr.config;
+
+	return ((config & ARCH_PERFMON_EVENTSEL_EVENT) == 0) &&
+		((config & INTEL_ARCH_EVENT_MASK) >= INTEL_TD_METRIC_RETIRING)  &&
+		((config & INTEL_ARCH_EVENT_MASK) <= INTEL_TD_METRIC_AVAILABLE_MAX);
+}
+
 static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
 {
 	if (static_cpu_has(X86_FEATURE_ARCH_LBR))
-- 
2.7.4

