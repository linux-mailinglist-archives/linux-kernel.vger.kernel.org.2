Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FD8352451
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbhDBARq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:17:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:48424 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236360AbhDBARl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:17:41 -0400
IronPort-SDR: 1hXro4raYSDGhgzphVNwf94wld3012c2fzJhzdbAZu3SF+TqSm8Jpbs1mfz5yniAlsZEwT0/UN
 /INVz3Y/DFRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="171775021"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="171775021"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 17:17:41 -0700
IronPort-SDR: w4PGN2bDSihb94RsVeA2/Pry5zs6CfysdnzG+8kyXejVmVqKmisqfT3o3rlUpQ6Syfhr+DOV8l
 uxuS5eTEE7SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="528399287"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2021 17:17:41 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 07/25] perf/x86: Hybrid PMU support for unconstrained
Date:   Thu,  1 Apr 2021 17:10:34 -0700
Message-Id: <1617322252-154215-8-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
References: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
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

