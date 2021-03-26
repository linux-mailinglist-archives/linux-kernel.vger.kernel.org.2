Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC16234AEF7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhCZTJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:09:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:27818 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230157AbhCZTI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:08:58 -0400
IronPort-SDR: 62re6+AuhxiB2lEU9IOAt8qy1Ra7fWTmU1IaI49SfIgAe++lZ4uVB9ssgHqbizpOeO6bRHHSFH
 5fm4gkobxXcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="191234781"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="191234781"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 12:08:57 -0700
IronPort-SDR: giQC2oRXQrTnQmwxj85Wfh/9gmzgP1QwJVcNlOY7d/mzadea+nhOpXCZHT0oi7ROt8Vx6wlZJq
 Q6eCVuyH/cqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="392321075"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2021 12:08:56 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 07/25] perf/x86: Hybrid PMU support for unconstrained
Date:   Fri, 26 Mar 2021 12:01:54 -0700
Message-Id: <1616785332-165261-8-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616785332-165261-1-git-send-email-kan.liang@linux.intel.com>
References: <1616785332-165261-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The unconstrained value depends on the number of GP and fixed counters.
Each hybrid PMU should use its own unconstrained.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 5 ++++-
 arch/x86/events/perf_event.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 33d26ed..39f57ae 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3147,7 +3147,10 @@ x86_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 		}
 	}
 
-	return &unconstrained;
+	if (!is_hybrid() || !cpuc->pmu)
+		return &unconstrained;
+
+	return &hybrid_pmu(cpuc->pmu)->unconstrained;
 }
 
 static struct event_constraint *
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index b11fa2f..665fa0b 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -639,6 +639,7 @@ struct x86_hybrid_pmu {
 	int				max_pebs_events;
 	int				num_counters;
 	int				num_counters_fixed;
+	struct event_constraint		unconstrained;
 };
 
 static __always_inline bool is_hybrid(void)
-- 
2.7.4

