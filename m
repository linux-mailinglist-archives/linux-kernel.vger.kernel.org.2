Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC57D35434F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 17:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbhDEPSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 11:18:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:43417 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241505AbhDEPST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 11:18:19 -0400
IronPort-SDR: HRxcHCtVdJ/Vwu0srWbZkK47KtvTFhnYdDyRU8yoDJZWd1r6BZqk6gaOdP4KxWh0ra14RqlWB3
 R5y2+l/Q0UuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="180402943"
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; 
   d="scan'208";a="180402943"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 08:18:12 -0700
IronPort-SDR: qpsFhDHNHP8630l51FKDowfMn/TG2MwFbsxpQtGdXEbGi/RC5ZNL1Fni/5fQQ6Ihp8KYiH1fS5
 Pf38RMT3e7iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; 
   d="scan'208";a="379006250"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 05 Apr 2021 08:18:12 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, ricardo.neri-calderon@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 07/25] perf/x86: Hybrid PMU support for unconstrained
Date:   Mon,  5 Apr 2021 08:10:49 -0700
Message-Id: <1617635467-181510-8-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
References: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
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
index 993f0de..cfb2da0 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -639,6 +639,7 @@ struct x86_hybrid_pmu {
 	int				max_pebs_events;
 	int				num_counters;
 	int				num_counters_fixed;
+	struct event_constraint		unconstrained;
 };
 
 static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
-- 
2.7.4

