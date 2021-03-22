Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD76343946
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 07:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhCVGOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 02:14:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:15223 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229871AbhCVGO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 02:14:26 -0400
IronPort-SDR: HHXhyrEOHxBsASsnAHrJHVBCXlrsfBCIbhxeS2OWqJ6/XPreOWgqQ+beqejIEA6X6YCiQ8e0LH
 9iov77i4agRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="186889264"
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="186889264"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 23:14:26 -0700
IronPort-SDR: 0t9CtwKeqTZXjmRs7QFrHB6KVny460Wz72wcGJqwHtouuQsih7m1w2BP+Z88gOUBOXnnpnfiEh
 C/wwDqD1twOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="441026295"
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.108])
  by fmsmga002.fm.intel.com with ESMTP; 21 Mar 2021 23:14:22 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <like.xu@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4 RESEND 4/5] perf/x86/lbr: Skip checking for the existence of LBR_TOS for Arch LBR
Date:   Mon, 22 Mar 2021 14:06:34 +0800
Message-Id: <20210322060635.821531-5-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210322060635.821531-1-like.xu@linux.intel.com>
References: <20210322060635.821531-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Architecture LBR does not have MSR_LBR_TOS (0x000001c9). KVM will
generate #GP for this MSR access, thereby preventing the initialization
of the guest LBR.

Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
Signed-off-by: Like Xu <like.xu@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/intel/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 382dd3994463..7f6d748421f2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5740,7 +5740,8 @@ __init int intel_pmu_init(void)
 	 * Check all LBR MSR here.
 	 * Disable LBR access if any LBR MSRs can not be accessed.
 	 */
-	if (x86_pmu.lbr_nr && !check_msr(x86_pmu.lbr_tos, 0x3UL))
+	if (x86_pmu.lbr_nr && !boot_cpu_has(X86_FEATURE_ARCH_LBR) &&
+	    !check_msr(x86_pmu.lbr_tos, 0x3UL))
 		x86_pmu.lbr_nr = 0;
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&
-- 
2.29.2

