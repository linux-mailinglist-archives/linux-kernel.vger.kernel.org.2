Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6727131123B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhBESht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:37:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:42539 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233106AbhBEPKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:10:21 -0500
IronPort-SDR: 763rtp2EEfcCfRPvcBVvB6GodoOrSHibdvLrgacgy/k4zvKsUzgoL5zngwktV4iBqC31EwZZWI
 473smzJLkNGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="161198903"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="161198903"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 07:16:44 -0800
IronPort-SDR: EibHNiZ91C0Tmq4y4iB9oIR3gazpluwVlvsuKvYkTvjDhuWIpGSlZWr58fZ1ftAigaHF5a4k8v
 ZMErmyBea09g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="358274755"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 05 Feb 2021 07:16:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id CB8B92A7; Fri,  5 Feb 2021 17:16:40 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC 3/9] x86: CPUID and CR3/CR4 flags for Linear Address Masking
Date:   Fri,  5 Feb 2021 18:16:24 +0300
Message-Id: <20210205151631.43511-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enumerate Linear Address Masking and provide defines for CR3 and CR4
flags.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/cpufeatures.h          | 1 +
 arch/x86/include/uapi/asm/processor-flags.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dad350d42ecf..3ae25d88216e 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -293,6 +293,7 @@
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_LAM			(12*32+26) /* Linear Address Masking */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index bcba3c643e63..f2a4a53308e2 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -82,6 +82,10 @@
 #define X86_CR3_PCID_BITS	12
 #define X86_CR3_PCID_MASK	(_AC((1UL << X86_CR3_PCID_BITS) - 1, UL))
 
+#define X86_CR3_LAM_U48_BIT	61 /* Activate LAM for userspace, 62:48 bits masked */
+#define X86_CR3_LAM_U48		_BITULL(X86_CR3_LAM_U48_BIT)
+#define X86_CR3_LAM_U57_BIT	62 /* Activate LAM for userspace, 62:57 bits masked */
+#define X86_CR3_LAM_U57		_BITULL(X86_CR3_LAM_U57_BIT)
 #define X86_CR3_PCID_NOFLUSH_BIT 63 /* Preserve old PCID */
 #define X86_CR3_PCID_NOFLUSH    _BITULL(X86_CR3_PCID_NOFLUSH_BIT)
 
@@ -130,6 +134,8 @@
 #define X86_CR4_SMAP		_BITUL(X86_CR4_SMAP_BIT)
 #define X86_CR4_PKE_BIT		22 /* enable Protection Keys support */
 #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
+#define X86_CR4_LAM_SUP_BIT	28 /* LAM for supervisor pointers */
+#define X86_CR4_LAM_SUP		_BITUL(X86_CR4_LAM_SUP_BIT)
 
 /*
  * x86-64 Task Priority Register, CR8
-- 
2.26.2

