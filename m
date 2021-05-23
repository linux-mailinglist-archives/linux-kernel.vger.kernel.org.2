Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920E938DCB0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhEWTk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:40:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:12053 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231981AbhEWTj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:39:57 -0400
IronPort-SDR: JV1bdqwO5kscVap7FwNu8xAwWyN8YZGDf3vSn8HRyeyk3l1RaqK2SRT/l0KlWzPrHl6WVmkrPQ
 zAVQcX6CZLLw==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="265703536"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="265703536"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:29 -0700
IronPort-SDR: BRXig8pw9PpDWE/DsQj5RdcSls0asJgB1zxoopGku0qnrpIhBqahweMykJLXFaWEUKp8ZUDcPy
 +etPmXvJmTRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467111"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:28 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 17/28] x86/fpu/xstate: Adjust the XSAVE feature table to address gaps in state component numbers
Date:   Sun, 23 May 2021 12:32:48 -0700
Message-Id: <20210523193259.26200-18-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210523193259.26200-1-chang.seok.bae@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At compile-time xfeatures_mask_all includes all possible XCR0 features. At
run-time fpu__init_system_xstate() clears features in xfeatures_mask_all
that are not enabled in CPUID. It does this by looping through all possible
XCR0 features.

Update the code to handle the possibility that there will be gaps in the
XCR0 feature bit numbers.

No functional change.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v4:
* Simplified the implementation. (Thomas Gleixner)
* Updated the patch title accordingly.

Changes from v1:
* Rebased on the upstream kernel (5.10)
---
 arch/x86/kernel/fpu/xstate.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 126c4a509669..1cf5888210aa 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -44,18 +44,17 @@ static const char *xfeature_names[] =
 	"unknown xstate feature"	,
 };
 
-static short xsave_cpuid_features[] __initdata = {
-	X86_FEATURE_FPU,
-	X86_FEATURE_XMM,
-	X86_FEATURE_AVX,
-	X86_FEATURE_MPX,
-	X86_FEATURE_MPX,
-	X86_FEATURE_AVX512F,
-	X86_FEATURE_AVX512F,
-	X86_FEATURE_AVX512F,
-	X86_FEATURE_INTEL_PT,
-	X86_FEATURE_PKU,
-	X86_FEATURE_ENQCMD,
+static unsigned short xsave_cpuid_features[] __initdata = {
+	[XFEATURE_SSE]				= X86_FEATURE_XMM,
+	[XFEATURE_YMM]				= X86_FEATURE_AVX,
+	[XFEATURE_BNDREGS]			= X86_FEATURE_MPX,
+	[XFEATURE_BNDCSR]			= X86_FEATURE_MPX,
+	[XFEATURE_OPMASK]			= X86_FEATURE_AVX512F,
+	[XFEATURE_ZMM_Hi256]			= X86_FEATURE_AVX512F,
+	[XFEATURE_Hi16_ZMM]			= X86_FEATURE_AVX512F,
+	[XFEATURE_PT_UNIMPLEMENTED_SO_FAR]	= X86_FEATURE_INTEL_PT,
+	[XFEATURE_PKRU]				= X86_FEATURE_PKU,
+	[XFEATURE_PASID]			= X86_FEATURE_ENQCMD,
 };
 
 /*
@@ -1022,8 +1021,13 @@ void __init fpu__init_system_xstate(void)
 	/*
 	 * Clear XSAVE features that are disabled in the normal CPUID.
 	 */
-	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
-		if (!boot_cpu_has(xsave_cpuid_features[i]))
+
+	/* Handle the first component separately as its value is zero. */
+	if (!boot_cpu_has(X86_FEATURE_FPU))
+		xfeatures_mask_all &= ~BIT_ULL(XFEATURE_FP);
+
+	for (i = 1; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
+		if (xsave_cpuid_features[i] && !boot_cpu_has(xsave_cpuid_features[i]))
 			xfeatures_mask_all &= ~BIT_ULL(i);
 	}
 
-- 
2.17.1

