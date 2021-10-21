Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC842436DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhJUXIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:08:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:4528 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232587AbhJUXHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:07:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="292634894"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="292634894"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033445"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:28 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 19/23] x86/fpu/xstate: Prepare XSAVE feature table for gaps in state component numbers
Date:   Thu, 21 Oct 2021 15:55:23 -0700
Message-Id: <20211021225527.10184-20-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel checks at boot time which features are available by walking a
XSAVE feature table which contains the CPUID feature bit numbers which need
to be checked whether a feature is available on a CPU or not. So far the
feature numbers have been linear, but AMX will create a gap which the
current code cannot handle.

Make the table entries explicitly indexed and adjust the loop code
accordingly to prepare for that.

No functional change.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 3f65140b4e6f..a2e17aca6318 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -53,18 +53,18 @@ static const char *xfeature_names[] =
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
+	[XFEATURE_FP]				= X86_FEATURE_FPU,
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
 
 static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
@@ -809,7 +809,10 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	 * Clear XSAVE features that are disabled in the normal CPUID.
 	 */
 	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
-		if (!boot_cpu_has(xsave_cpuid_features[i]))
+		unsigned short cid = xsave_cpuid_features[i];
+
+		/* Careful: X86_FEATURE_FPU is 0! */
+		if ((i != XFEATURE_FP && !cid) || !boot_cpu_has(cid))
 			fpu_kernel_cfg.max_features &= ~BIT_ULL(i);
 	}
 
-- 
2.17.1

