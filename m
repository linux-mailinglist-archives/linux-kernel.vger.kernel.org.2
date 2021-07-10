Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CB03C34A8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 15:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhGJNMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 09:12:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:52358 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231577AbhGJNL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 09:11:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10040"; a="209867326"
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="209867326"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2021 06:09:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="488742403"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2021 06:09:09 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v7 18/26] x86/cpufeatures/amx: Enumerate Advanced Matrix Extension (AMX) feature bits
Date:   Sat, 10 Jul 2021 06:03:05 -0700
Message-Id: <20210710130313.5072-19-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210710130313.5072-1-chang.seok.bae@intel.com>
References: <20210710130313.5072-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel's Advanced Matrix Extension (AMX) is a new 64-bit extended feature
consisting of two-dimensional registers and an accelerator unit. The first
implementation of the latter is the tile matrix multiply unit (TMUL). TMUL
performs SIMD dot-products on four bytes (INT8) or two bfloat16
floating-point (BF16) elements.

Here enumerate this hardware capability to be shown as 'amx_tile',
'amx_bf16', and 'amx_int8' in /proc/cpuinfo.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v4:
* Massaged the changelog a bit.
---
 arch/x86/include/asm/cpufeatures.h | 3 +++
 arch/x86/kernel/cpu/cpuid-deps.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 37150b7a8e44..9e9763ec7713 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -386,7 +386,10 @@
 #define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tracking */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
+#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX BF16 Support */
 #define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
+#define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
+#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX INT8 Support */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 7f891d2eb52e..9a520ab259ac 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -76,6 +76,9 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_SGX1,			X86_FEATURE_SGX       },
 	{ X86_FEATURE_SGX2,			X86_FEATURE_SGX1      },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVE     },
+	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XSAVE     },
+	{ X86_FEATURE_AMX_INT8,			X86_FEATURE_AMX_TILE  },
+	{ X86_FEATURE_AMX_BF16,			X86_FEATURE_AMX_TILE  },
 	{}
 };
 
-- 
2.17.1

