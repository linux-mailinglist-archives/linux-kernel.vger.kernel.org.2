Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DB43AA402
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 21:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhFPTMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 15:12:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:10734 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232538AbhFPTMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 15:12:35 -0400
IronPort-SDR: FinrpevlFCrCMEsZxyG3c+aCY7j1HzThE/uZrfSsAGpLsk9qOKU3xz3yZKTc8R6krCJqr0GPKl
 pK1OYIjgLg8w==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="291874253"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="291874253"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 12:10:29 -0700
IronPort-SDR: MBTsC8G/NmYHOVqvGriYDLqUyGxvT2EpSFr3zWFiS/+l3F290k4W0eVViiQerlqzB91v2MI0uT
 HA83osnY0c4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="479208332"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2021 12:10:28 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, mark.rutland@arm.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@redhat.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/4] perf/x86: Remove filter_match callback
Date:   Wed, 16 Jun 2021 11:55:34 -0700
Message-Id: <1623869734-133974-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623869734-133974-1-git-send-email-kan.liang@linux.intel.com>
References: <1623869734-133974-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The filter_match callback is to check whether an event is schedulable on
the current CPU, which has been supported in the generic code.

Remove the filter_match callback.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 10 ----------
 arch/x86/events/intel/core.c |  8 --------
 arch/x86/events/perf_event.h |  1 -
 3 files changed, 19 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index ecebc66..4965171 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2640,14 +2640,6 @@ static int x86_pmu_aux_output_match(struct perf_event *event)
 	return 0;
 }
 
-static int x86_pmu_filter_match(struct perf_event *event)
-{
-	if (x86_pmu.filter_match)
-		return x86_pmu.filter_match(event);
-
-	return 1;
-}
-
 static struct pmu pmu = {
 	.pmu_enable		= x86_pmu_enable,
 	.pmu_disable		= x86_pmu_disable,
@@ -2675,8 +2667,6 @@ static struct pmu pmu = {
 	.check_period		= x86_pmu_check_period,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
-
-	.filter_match		= x86_pmu_filter_match,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 03ba014..17b86d2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4490,13 +4490,6 @@ static int intel_pmu_aux_output_match(struct perf_event *event)
 	return is_intel_pt_event(event);
 }
 
-static int intel_pmu_filter_match(struct perf_event *event)
-{
-	unsigned int cpu = smp_processor_id();
-
-	return cpumask_test_cpu(cpu, &event->pmu->supported_cpus);
-}
-
 PMU_FORMAT_ATTR(offcore_rsp, "config1:0-63");
 
 PMU_FORMAT_ATTR(ldlat, "config1:0-15");
@@ -6131,7 +6124,6 @@ __init int intel_pmu_init(void)
 		x86_pmu.update_topdown_event = adl_update_topdown_event;
 		x86_pmu.set_topdown_event_period = adl_set_topdown_event_period;
 
-		x86_pmu.filter_match = intel_pmu_filter_match;
 		x86_pmu.get_event_constraints = adl_get_event_constraints;
 		x86_pmu.hw_config = adl_hw_config;
 		x86_pmu.limit_period = spr_limit_period;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 02abcac..9b6c9d8 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -883,7 +883,6 @@ struct x86_pmu {
 
 	int (*aux_output_match) (struct perf_event *event);
 
-	int (*filter_match)(struct perf_event *event);
 	/*
 	 * Hybrid support
 	 *
-- 
2.7.4

