Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7C4320D0B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 20:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhBUTJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 14:09:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:53122 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230164AbhBUTDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 14:03:11 -0500
IronPort-SDR: SUw7B27SGJZ0eDjt/oEVJLw/kCCU0nSgEblbfJy8Pr7vZClJBJUYlJ3Plc2DEm8v2o6r5/AWhq
 qOb8NP2CGdww==
X-IronPort-AV: E=McAfee;i="6000,8403,9902"; a="248330317"
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="248330317"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 11:01:28 -0800
IronPort-SDR: RTtMUD3TEzzWTo2bwosTruDucT5z+sJ1E3gJtTB2BoQ3yiYDS/2SyqnO/zEAMBPDAo+GAQqjLO
 BI1NfNIYFOBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="429792131"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2021 11:01:29 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v4 17/22] x86/cpufeatures/amx: Enumerate Advanced Matrix Extension (AMX) feature bits
Date:   Sun, 21 Feb 2021 10:56:32 -0800
Message-Id: <20210221185637.19281-18-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210221185637.19281-1-chang.seok.bae@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel's Advanced Matrix Extension (AMX) is a new 64-bit extended feature
consisting of two-dimensional registers and an accelerator unit. The first
implementation of the latter is the tile matrix multiply unit (TMUL). TMUL
performs SIMD dot-products on four bytes (INT8) or two bfloat16
floating-point (BF16) elements.

Here we add AMX to the kernel/user ABI, by enumerating the capability.
E.g., /proc/cpuinfo: amx_tile, amx_bf16, amx_int8

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/cpufeatures.h | 3 +++
 arch/x86/kernel/cpu/cpuid-deps.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3170ab367cf2..f9990841238a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -379,6 +379,9 @@
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
 #define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
+#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX BF16 Support */
+#define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
+#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX INT8 Support */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 4423046c2d74..154c18e493c5 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -73,6 +73,9 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_PER_THREAD_MBA,		X86_FEATURE_MBA       },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
+	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XSAVE     },
+	{ X86_FEATURE_AMX_INT8,			X86_FEATURE_AMX_TILE  },
+	{ X86_FEATURE_AMX_BF16,			X86_FEATURE_AMX_TILE  },
 	{}
 };
 
-- 
2.17.1

