Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7637349EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhCZB1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:27:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:51734 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230198AbhCZB1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:27:19 -0400
IronPort-SDR: MWgopQEOg84Z4/gWpbLBIc+qLqvmUHMilG7zjfrwfQ/uUjFX0XyMZDVJJ8cshOV5YjCw/OVJ+Q
 G/DbBmkyLtmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="170421825"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="170421825"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 18:27:19 -0700
IronPort-SDR: tGfPw17DfxK/KvCvG5z5ctnHdeDgByfKf225MFrxgbsFl2T1AEV4obkoPBHxUCzKdAltFHyhgF
 VuTiGQI3xhEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="443088994"
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.108])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2021 18:27:16 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     pbonzini@redhat.com, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>, wei.w.wang@intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu@linux.intel.com>
Subject: [PATCH v5 3/5] perf/x86: Skip checking MSR for MSR 0x000
Date:   Fri, 26 Mar 2021 09:19:16 +0800
Message-Id: <20210326011918.183685-4-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210326011918.183685-1-like.xu@linux.intel.com>
References: <20210326011918.183685-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Architecture LBR does not have MSR_LBR_TOS (0x000001c9).
When ARCH_LBR we don't set lbr_tos, the failure from the
check_msr() against MSR 0x000 will make x86_pmu.lbr_nr = 0,
thereby preventing the initialization of the guest LBR.

Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
Signed-off-by: Like Xu <like.xu@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 382dd3994463..564c9851dd34 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4593,10 +4593,10 @@ static bool check_msr(unsigned long msr, u64 mask)
 	u64 val_old, val_new, val_tmp;
 
 	/*
-	 * Disable the check for real HW, so we don't
+	 * Disable the check for real HW or non-sense msr, so we don't
 	 * mess with potentionaly enabled registers:
 	 */
-	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) || !msr)
 		return true;
 
 	/*
-- 
2.29.2

