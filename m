Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370AE340FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 22:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhCRVcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 17:32:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:4113 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233071AbhCRVbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:31:47 -0400
IronPort-SDR: zEHuzIgF6oUT6h630MbERdM7iX6GzeweGiGzSfW8HdzPy0sW6SNjqAUWI74lXtwF3uWMiYk0g7
 aZVD8yeKQl2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="169070337"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="169070337"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 14:31:41 -0700
IronPort-SDR: irHgnJv6SaRqQqkHEZ/wWzbY0Me28eiJh7BjQ4/PcrEVhzsuknNyksIYxNnA0NfSOx7hDSLbGt
 YAhbpTbPubCA==
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="374715425"
Received: from mrasekh-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.191.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 14:31:39 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v1 1/1] x86/tdx: Add tdcall() and tdvmcall() helper functions
Date:   Thu, 18 Mar 2021 14:30:53 -0700
Message-Id: <20210318213053.203403-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0A886D87-1979-419C-86DE-EA2FABDFF3EB@amacapital.net>
References: <0A886D87-1979-419C-86DE-EA2FABDFF3EB@amacapital.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement common helper functions to communicate with
the TDX Module and VMM (using TDCALL instruction).

tdvmcall() function can be used to request services
from VMM.

tdcall() function can be used to communicate with the
TDX Module.

Using common helper functions makes the code more readable
and less error prone compared to distributed and use case
specific inline assembly code. Only downside in using this
approach is, it adds a few extra instructions for every
TDCALL use case when compared to distributed checks. Although
it's a bit less efficient, it's worth it to make the code more
readable.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Hi All,

As you have suggested, I have created common helper functions
for all tdcall() and tdvmcall() use cases. It uses inline
assembly and passes GPRs R8-15 and r[a-c]x registers to TDX
Module/VMM. Please take a look at it and let me know your
comments. If you agree with the design, I can re-submit the
patchset with changes related to using these new APIs. Please
let me know.

 arch/x86/include/asm/tdx.h | 27 ++++++++++++++++++++
 arch/x86/kernel/tdx.c      | 52 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 0b9d571b1f95..311252a90cfb 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -3,8 +3,27 @@
 #ifndef _ASM_X86_TDX_H
 #define _ASM_X86_TDX_H
 
+#include <linux/types.h>
+
 #define TDX_CPUID_LEAF_ID	0x21
 
+#define TDVMCALL		0
+
+/* TDVMCALL R10 Input */
+#define TDVMCALL_STANDARD	0
+
+/*
+ * TDCALL instruction is newly added in TDX architecture,
+ * used by TD for requesting the host VMM to provide
+ * (untrusted) services. Supported in Binutils >= 2.36
+ */
+#define TDCALL	".byte 0x66,0x0f,0x01,0xcc"
+
+struct tdcall_regs {
+	u64 rax, rcx, rdx;
+	u64 r8, r9, r10, r11, r12, r13, r14, r15;
+};
+
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 /* Common API to check TDX support in decompression and common kernel code. */
@@ -12,6 +31,10 @@ bool is_tdx_guest(void);
 
 void __init tdx_early_init(void);
 
+void tdcall(u64 leafid, struct tdcall_regs *regs);
+
+void tdvmcall(u64 subid, struct tdcall_regs *regs);
+
 #else // !CONFIG_INTEL_TDX_GUEST
 
 static inline bool is_tdx_guest(void)
@@ -21,6 +44,10 @@ static inline bool is_tdx_guest(void)
 
 static inline void tdx_early_init(void) { };
 
+static inline void tdcall(u64 leafid, struct tdcall_regs *regs) { };
+
+static inline void tdvmcall(u64 subid, struct tdcall_regs *regs) { };
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index e44e55d1e519..7ae1d25e272b 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -4,6 +4,58 @@
 #include <asm/tdx.h>
 #include <asm/cpufeature.h>
 
+void tdcall(u64 leafid, struct tdcall_regs *regs)
+{
+	asm volatile(
+			/* RAX = leafid (TDCALL LEAF ID) */
+			"  movq %0, %%rax;"
+			/* Move regs->r[*] data to regs r[a-c]x,  r8-r5 */
+			"  movq 8(%1), %%rcx;"
+			"  movq 16(%1), %%rdx;"
+			"  movq 24(%1), %%r8;"
+			"  movq 32(%1), %%r9;"
+			"  movq 40(%1), %%r10;"
+			"  movq 48(%1), %%r11;"
+			"  movq 56(%1), %%r12;"
+			"  movq 64(%1), %%r13;"
+			"  movq 72(%1), %%r14;"
+			"  movq 80(%1), %%r15;"
+			TDCALL ";"
+			/* Save TDCALL success/failure to regs->rax */
+			"  movq %%rax, (%1);"
+			/* Save rcx and rdx contents to regs->r[c-d]x */
+			"  movq %%rcx, 8(%1);"
+			"  movq %%rdx, 16(%1);"
+			/* Move content of registers R8-R15 regs->r[8-15] */
+			"  movq %%r8, 24(%1);"
+			"  movq %%r9, 32(%1);"
+			"  movq %%r10, 40(%1);"
+			"  movq %%r11, 48(%1);"
+			"  movq %%r12, 56(%1);"
+			"  movq %%r13, 64(%1);"
+			"  movq %%r14, 72(%1);"
+			"  movq %%r15, 80(%1);"
+
+		:
+		: "r" (leafid), "r" (regs)
+		: "memory", "rax", "rbx", "rcx", "rdx", "r8",
+		  "r9", "r10", "r11", "r12", "r13", "r14", "r15"
+		);
+
+}
+
+void tdvmcall(u64 subid, struct tdcall_regs *regs)
+{
+	/* Expose GPRs R8-R15 to VMM */
+	regs->rcx = 0xff00;
+	/* R10 = 0 (standard TDVMCALL) */
+	regs->r10 = TDVMCALL_STANDARD;
+	/* Save subid to r11 register */
+	regs->r11 = subid;
+
+	tdcall(TDVMCALL, regs);
+}
+
 static inline bool cpuid_has_tdx_guest(void)
 {
 	u32 eax, signature[3];
-- 
2.25.1

