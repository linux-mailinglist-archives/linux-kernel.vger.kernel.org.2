Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5DA352466
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbhDBASf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:18:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:48424 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236672AbhDBASW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:18:22 -0400
IronPort-SDR: Li5JxpTH2of4I/5mSuCdhXvDnlU1ORSyEu2OIHUXohrsxt5/V5iZJ5Nn0z+T0kzLwgDOC5GCGu
 MEQ8tPEVfmBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="171775070"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="171775070"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 17:17:57 -0700
IronPort-SDR: iGt63+ATg46WwFRy1K39gC6fBnCUAnEzvrcf0JrIa9ab74AiCPdI29KNRzC81WoH/xj2EntZL+
 6Uw9WzhL+ZVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="528399421"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2021 17:17:57 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V4 25/25] perf/x86/rapl: Add support for Intel Alder Lake
Date:   Thu,  1 Apr 2021 17:10:52 -0700
Message-Id: <1617322252-154215-26-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
References: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Alder Lake RAPL support is the same as previous Sky Lake.
Add Alder Lake model for RAPL.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/rapl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index f42a704..84a1042 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -800,6 +800,8 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&model_hsx),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
 	X86_MATCH_VENDOR_FAM(AMD,	0x17,		&model_amd_fam17h),
 	X86_MATCH_VENDOR_FAM(HYGON,	0x18,		&model_amd_fam17h),
-- 
2.7.4

