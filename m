Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDFA33435C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhCJQoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:44:18 -0500
Received: from mga03.intel.com ([134.134.136.65]:37313 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232616AbhCJQnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:43:53 -0500
IronPort-SDR: vV/TDTK48S09YDV9ELEZYOp9CrNjgD2o758yMMDo7lAVU3NdYSaDHheKOSMaHiShodisa3SGoB
 7JEDz7g2LMqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188546449"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="188546449"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:43:53 -0800
IronPort-SDR: dcgR+gRBsQSOKc8tc499R/JXTmiE15kFPIeUGtk3XgGw4B3ueQjepK5qzCYeH20M1Qzppj7idW
 w8DUcLlBGqvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="509729140"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 08:43:52 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 07/25] perf/x86: Hybrid PMU support for unconstrained
Date:   Wed, 10 Mar 2021 08:37:43 -0800
Message-Id: <1615394281-68214-8-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
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
index e187cf5..540dba2 100644
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
index d2f97bd..7bce193 100644
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

