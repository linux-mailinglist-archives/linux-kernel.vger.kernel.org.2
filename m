Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7583C34AB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 15:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhGJNMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 09:12:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:52363 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231550AbhGJNL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 09:11:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10040"; a="209867324"
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="209867324"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2021 06:09:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="488742396"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2021 06:09:08 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v7 16/26] x86/fpu/xstate: Adjust the XSAVE feature table to address gaps in state component numbers
Date:   Sat, 10 Jul 2021 06:03:03 -0700
Message-Id: <20210710130313.5072-17-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210710130313.5072-1-chang.seok.bae@intel.com>
References: <20210710130313.5072-1-chang.seok.bae@intel.com>
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
Changes from v5:
* Folded a few lines.

Changes from v4:
* Simplified the implementation. (Thomas Gleixner)
* Updated the patch title accordingly.

Changes from v1:
* Rebased on the upstream kernel (5.10)
---
 arch/x86/kernel/fpu/xstate.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index b8a8e8e38dad..353125a18274 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -43,18 +43,17 @@ static const char *xfeature_names[] =
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
@@ -955,7 +954,8 @@ void __init fpu__init_system_xstate(void)
 	 * Clear XSAVE features that are disabled in the normal CPUID.
 	 */
 	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
-		if (!boot_cpu_has(xsave_cpuid_features[i]))
+		if (((i == 0) || xsave_cpuid_features[i]) &&
+		    !boot_cpu_has(xsave_cpuid_features[i]))
 			xfeatures_mask_all &= ~BIT_ULL(i);
 	}
 
-- 
2.17.1

