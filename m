Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E1B36F54E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 07:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhD3FYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 01:24:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:54053 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230085AbhD3FYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 01:24:09 -0400
IronPort-SDR: YoYAlgmiRhSYUwZXsiO/g7VnOoirSKSzSd5ka8lav05m7ZXUncZz82QxjVj8Yk16+S/edrCoBP
 4armm7Z31YAg==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="282543268"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="282543268"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 22:23:18 -0700
IronPort-SDR: APR3BpjXAr3DUNOrnyYgzaB1XLIscEEqLdhTqxozXLMjODMjMn0P0Kb1punqxqjPCExtHaQka/
 rEbSOh72z+hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="527506049"
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.108])
  by fmsmga001.fm.intel.com with ESMTP; 29 Apr 2021 22:23:15 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, seanjc@google.com,
        x86@kernel.org, Like Xu <like.xu@linux.intel.com>
Subject: [PATCH v2 1/2] perf/x86: Skip checking if 0x0 MSR exists for guest Arch LBR
Date:   Fri, 30 Apr 2021 13:22:46 +0800
Message-Id: <20210430052247.3079672-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Architecture LBR does not have MSR_LBR_TOS (0x000001c9).
In a guest that should support Architecture LBR, check_msr()
will be a non-related check for the architecture MSR 0x0
(IA32_P5_MC_ADDR) that is also not supported by KVM.

The failure will cause x86_pmu.lbr_nr = 0, thereby preventing
the initialization of the guest Arch LBR. Fix it by avoiding
this extraneous check in intel_pmu_init() for Arch LBR.

Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
v1->v2 Changelog:
- Avoid checking unrelated Architecture MSR 0x0 in a simple way

 arch/x86/events/intel/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5272f349dca2..456aa6ffd9a1 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6250,7 +6250,8 @@ __init int intel_pmu_init(void)
 	 * Check all LBT MSR here.
 	 * Disable LBR access if any LBR MSRs can not be accessed.
 	 */
-	if (x86_pmu.lbr_nr && !check_msr(x86_pmu.lbr_tos, 0x3UL))
+	if (x86_pmu.lbr_nr && !static_cpu_has(X86_FEATURE_ARCH_LBR) &&
+	    !check_msr(x86_pmu.lbr_tos, 0x3UL))
 		x86_pmu.lbr_nr = 0;
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&
-- 
2.30.2

