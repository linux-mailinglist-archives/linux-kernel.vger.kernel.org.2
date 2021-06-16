Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE77C3AA401
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 21:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhFPTMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 15:12:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:10731 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232530AbhFPTMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 15:12:34 -0400
IronPort-SDR: b/N74u2BgH1V1x3R3vekE+EqCLZLgxooHrCmHRF26F/XxGQHM/hrOBcNsnRnacBmr5V8EDDDok
 ffwcmYPOeNMg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="291874248"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="291874248"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 12:10:27 -0700
IronPort-SDR: /mBTKQ7fpKHXrBB1Ag4Fmq/Z44vZMgVqYCNhmAMnpakBrexpmN4sBFGig1PPtMQzFeE9IWUtfS
 Pp+c/ayrXOaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="479208317"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2021 12:10:27 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, mark.rutland@arm.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@redhat.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/4] perf: Check the supported CPU of an event
Date:   Wed, 16 Jun 2021 11:55:33 -0700
Message-Id: <1623869734-133974-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623869734-133974-1-git-send-email-kan.liang@linux.intel.com>
References: <1623869734-133974-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

All architectures, which support the filter_match callback, check
whether an event is schedulable on the current CPU. Since the
supported_cpus is moved to struct pmu, the check can be done in the
generic code. The filter_match callback can be avoided for some
architecture, e.g., x86.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b172f54..7140f40 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2225,9 +2225,19 @@ static bool is_orphaned_event(struct perf_event *event)
 	return event->state == PERF_EVENT_STATE_DEAD;
 }
 
+static __always_inline bool pmu_can_sched_on_this_cpu(struct pmu *pmu)
+{
+	return cpumask_empty(&pmu->supported_cpus) ||
+	       cpumask_test_cpu(smp_processor_id(), &pmu->supported_cpus);
+}
+
 static inline int __pmu_filter_match(struct perf_event *event)
 {
 	struct pmu *pmu = event->pmu;
+
+	if (!pmu_can_sched_on_this_cpu(pmu))
+		return 0;
+
 	return pmu->filter_match ? pmu->filter_match(event) : 1;
 }
 
@@ -3825,7 +3835,7 @@ static inline void perf_event_context_update_hybrid(struct perf_event_context *c
 {
 	struct pmu *pmu = ctx->pmu;
 
-	if (cpumask_empty(&pmu->supported_cpus) || cpumask_test_cpu(smp_processor_id(), &pmu->supported_cpus))
+	if (pmu_can_sched_on_this_cpu(pmu))
 		return;
 
 	rcu_read_lock();
-- 
2.7.4

