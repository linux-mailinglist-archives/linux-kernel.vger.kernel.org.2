Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7DB320D08
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 20:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhBUTI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 14:08:26 -0500
Received: from mga05.intel.com ([192.55.52.43]:37210 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230492AbhBUTCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 14:02:50 -0500
IronPort-SDR: conn5oI8xQlB9TNaUSMY1I7cv69f8Ub6anT7SXNu167x/n6l59wbzsbL+p87Hx5dM30vd7NrQL
 No1hKdYArevQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9902"; a="269192156"
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="269192156"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 11:01:29 -0800
IronPort-SDR: OZxA8hF2NojsoPqnvW/si+YRRskkDm+Hkd0wAXCj1GdRdgI1doah1RpG29psSCRXQVF3gaj/6A
 Y6lugRT01TpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="429792128"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2021 11:01:29 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v4 16/22] x86/fpu/xstate: Extend the table to map state components with features
Date:   Sun, 21 Feb 2021 10:56:31 -0800
Message-Id: <20210221185637.19281-17-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210221185637.19281-1-chang.seok.bae@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
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
Changes from v1:
* Rebased on the upstream kernel (5.10)
---
 arch/x86/kernel/fpu/xstate.c | 41 ++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index b69913ae30ed..4421ef424670 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -43,18 +43,23 @@ static const char *xfeature_names[] =
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
+struct xfeature_capflag_info {
+	int xfeature_idx;
+	short cpu_cap;
+};
+
+static struct xfeature_capflag_info xfeature_capflags[] __initdata = {
+	{ XFEATURE_FP,				X86_FEATURE_FPU },
+	{ XFEATURE_SSE,				X86_FEATURE_XMM },
+	{ XFEATURE_YMM,				X86_FEATURE_AVX },
+	{ XFEATURE_BNDREGS,			X86_FEATURE_MPX },
+	{ XFEATURE_BNDCSR,			X86_FEATURE_MPX },
+	{ XFEATURE_OPMASK,			X86_FEATURE_AVX512F },
+	{ XFEATURE_ZMM_Hi256,			X86_FEATURE_AVX512F },
+	{ XFEATURE_Hi16_ZMM,			X86_FEATURE_AVX512F },
+	{ XFEATURE_PT_UNIMPLEMENTED_SO_FAR,	X86_FEATURE_INTEL_PT },
+	{ XFEATURE_PKRU,			X86_FEATURE_PKU },
+	{ XFEATURE_PASID,			X86_FEATURE_ENQCMD },
 };
 
 /*
@@ -1010,11 +1015,15 @@ void __init fpu__init_system_xstate(void)
 	}
 
 	/*
-	 * Clear XSAVE features that are disabled in the normal CPUID.
+	 * Cross-check XSAVE feature with CPU capability flag. Clear the
+	 * mask bit for disabled features.
 	 */
-	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
-		if (!boot_cpu_has(xsave_cpuid_features[i]))
-			xfeatures_mask_all &= ~BIT_ULL(i);
+	for (i = 0; i < ARRAY_SIZE(xfeature_capflags); i++) {
+		short cpu_cap = xfeature_capflags[i].cpu_cap;
+		int idx = xfeature_capflags[i].xfeature_idx;
+
+		if (!boot_cpu_has(cpu_cap))
+			xfeatures_mask_all &= ~BIT_ULL(idx);
 	}
 
 	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
-- 
2.17.1

