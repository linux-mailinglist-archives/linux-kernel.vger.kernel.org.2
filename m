Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5D1352461
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbhDBASV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:18:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:48434 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236619AbhDBASE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:18:04 -0400
IronPort-SDR: 9EYCCPYbVQ9mcLrnFlrSmKgc3RrTmkBkcTJvG54ldUAsmPghSO4rMe8uUeaajONWYp40uSkwI2
 zSuOpJAovOSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="171775058"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="171775058"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 17:17:54 -0700
IronPort-SDR: 1NeBOaorfLfJCVlWNQGdJj2ThvBxptBrJwniX6mlRB0WOavUjXz93Xb6AGv7H6Qh0T8Go8qzwb
 ooCfaKPACanQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="528399396"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2021 17:17:54 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 21/25] perf: Introduce PERF_TYPE_HARDWARE_PMU and PERF_TYPE_HW_CACHE_PMU
Date:   Thu,  1 Apr 2021 17:10:48 -0700
Message-Id: <1617322252-154215-22-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
References: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Current Hardware events and Hardware cache events have special perf
types, PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE. The two types don't
pass the PMU type in the user interface. For a hybrid system, the perf
subsystem doesn't know which PMU the events belong to. The first capable
PMU will always be assigned to the events. The events never get a chance
to run on the other capable PMUs.

Add a PMU aware version PERF_TYPE_HARDWARE_PMU and
PERF_TYPE_HW_CACHE_PMU. The PMU type ID is stored at attr.config[40:32].
Support the new types for X86.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c          | 10 ++++++++--
 include/uapi/linux/perf_event.h | 26 ++++++++++++++++++++++++++
 kernel/events/core.c            | 14 +++++++++++++-
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 18b75d6..36cfebad 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -488,7 +488,7 @@ int x86_setup_perfctr(struct perf_event *event)
 	if (attr->type == event->pmu->type)
 		return x86_pmu_extra_regs(event->attr.config, event);
 
-	if (attr->type == PERF_TYPE_HW_CACHE)
+	if ((attr->type == PERF_TYPE_HW_CACHE) || (attr->type == PERF_TYPE_HW_CACHE_PMU))
 		return set_ext_hw_attr(hwc, event);
 
 	if (attr->config >= x86_pmu.max_events)
@@ -2452,9 +2452,15 @@ static int x86_pmu_event_init(struct perf_event *event)
 
 	if ((event->attr.type != event->pmu->type) &&
 	    (event->attr.type != PERF_TYPE_HARDWARE) &&
-	    (event->attr.type != PERF_TYPE_HW_CACHE))
+	    (event->attr.type != PERF_TYPE_HW_CACHE) &&
+	    (event->attr.type != PERF_TYPE_HARDWARE_PMU) &&
+	    (event->attr.type != PERF_TYPE_HW_CACHE_PMU))
 		return -ENOENT;
 
+	if ((event->attr.type == PERF_TYPE_HARDWARE_PMU) ||
+	    (event->attr.type == PERF_TYPE_HW_CACHE_PMU))
+		event->attr.config &= PERF_HW_CACHE_EVENT_MASK;
+
 	if (is_hybrid() && (event->cpu != -1)) {
 		pmu = hybrid_pmu(event->pmu);
 		if (!cpumask_test_cpu(event->cpu, &pmu->supported_cpus))
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index ad15e40..c0a511e 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -33,6 +33,8 @@ enum perf_type_id {
 	PERF_TYPE_HW_CACHE			= 3,
 	PERF_TYPE_RAW				= 4,
 	PERF_TYPE_BREAKPOINT			= 5,
+	PERF_TYPE_HARDWARE_PMU			= 6,
+	PERF_TYPE_HW_CACHE_PMU			= 7,
 
 	PERF_TYPE_MAX,				/* non-ABI */
 };
@@ -95,6 +97,30 @@ enum perf_hw_cache_op_result_id {
 };
 
 /*
+ * attr.config layout for type PERF_TYPE_HARDWARE* and PERF_TYPE_HW_CACHE*
+ * PERF_TYPE_HARDWARE:		0xAA
+ *				AA: hardware event ID
+ * PERF_TYPE_HW_CACHE:		0xCCBBAA
+ *				AA: hardware cache ID
+ *				BB: hardware cache op ID
+ *				CC: hardware cache op result ID
+ * PERF_TYPE_HARDWARE_PMU:	0xDD000000AA
+ *				AA: hardware event ID
+ *				DD: PMU type ID
+ * PERF_TYPE_HW_CACHE_PMU:	0xDD00CCBBAA
+ *				AA: hardware cache ID
+ *				BB: hardware cache op ID
+ *				CC: hardware cache op result ID
+ *				DD: PMU type ID
+ */
+#define PERF_HW_CACHE_ID_SHIFT			0
+#define PERF_HW_CACHE_OP_ID_SHIFT		8
+#define PERF_HW_CACHE_OP_RESULT_ID_SHIFT	16
+#define PERF_HW_CACHE_EVENT_MASK		0xffffff
+
+#define PERF_PMU_TYPE_SHIFT			32
+
+/*
  * Special "software" events provided by the kernel, even if the hardware
  * does not support performance events. These events measure various
  * physical and sw events of the kernel (and allow the profiling of them as
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f079431..b8ab756 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11093,6 +11093,14 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 	return ret;
 }
 
+static bool perf_event_is_hw_pmu_type(struct perf_event *event)
+{
+	int type = event->attr.type;
+
+	return type == PERF_TYPE_HARDWARE_PMU ||
+	       type == PERF_TYPE_HW_CACHE_PMU;
+}
+
 static struct pmu *perf_init_event(struct perf_event *event)
 {
 	int idx, type, ret;
@@ -11116,13 +11124,17 @@ static struct pmu *perf_init_event(struct perf_event *event)
 	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)
 		type = PERF_TYPE_RAW;
 
+	if (perf_event_is_hw_pmu_type(event))
+		type = event->attr.config >> PERF_PMU_TYPE_SHIFT;
+
 again:
 	rcu_read_lock();
 	pmu = idr_find(&pmu_idr, type);
 	rcu_read_unlock();
 	if (pmu) {
 		ret = perf_try_init_event(pmu, event);
-		if (ret == -ENOENT && event->attr.type != type) {
+		if (ret == -ENOENT && event->attr.type != type &&
+		    !perf_event_is_hw_pmu_type(event)) {
 			type = event->attr.type;
 			goto again;
 		}
-- 
2.7.4

