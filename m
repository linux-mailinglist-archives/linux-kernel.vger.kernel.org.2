Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D9C311AFB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhBFEjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:39:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:63285 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232459AbhBFDVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:21:36 -0500
IronPort-SDR: E3CSw61ir3rsTEwlnUabgm+kCSNLm1hkuP7pMpmrKJjFqxYqGJNK/tuPJQkUqCZNYEicjsqKUq
 rdWNIAm0ON9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650717"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650717"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:07 -0800
IronPort-SDR: MLXXc1axfsGGfncj8oRHXQ8WIXVc0o2ZxrqtkH9B1/MCnABGeDE7TvybWSpdkJ8UEjcmDVkeR9
 2xz7OAyUiwaw==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183881"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:06 -0800
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
Subject: [RFC v1 06/26] x86/tdx: Add HLT support for TDX guest
Date:   Fri,  5 Feb 2021 15:38:23 -0800
Message-Id: <aa0ec1154ba91bd445122e815fb3054da2a7520f.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Per Guest-Host-Communication Interface (GHCI) for Intel Trust
Domain Extensions (Intel TDX) specification, sec 3.8,
TDVMCALL[Instruction.HLT] provides HLT operation. Use it to implement
halt() and safe_halt() paravirtualization calls.

The same TDVMCALL is used to handle #VE exception due to
EXIT_REASON_HLT.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/tdx.h |  5 ++++
 arch/x86/kernel/tdx.c      | 61 ++++++++++++++++++++++++++++++++++----
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 90eb61b07d1f..b98de067257b 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -14,9 +14,14 @@
  */
 #define TDCALL	".byte 0x66,0x0f,0x01,0xcc"
 
+#define TDVMCALL	0
 #define TDINFO		1
 #define TDGETVEINFO	3
 
+/* TDVMCALL R10 Input */
+#define TDVMCALL_STANDARD	0
+#define TDVMCALL_VENDOR		1
+
 /* Common API to check TDX support in decompression and common kernel code. */
 bool is_tdx_guest(void);
 
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index ae2d5c847700..25dd33bc2e49 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -51,6 +51,45 @@ static void tdx_get_info(void)
 	td_info.attributes = rdx;
 }
 
+static __cpuidle void tdx_halt(void)
+{
+	register long r10 asm("r10") = TDVMCALL_STANDARD;
+	register long r11 asm("r11") = EXIT_REASON_HLT;
+	register long rcx asm("rcx");
+	long ret;
+
+	/* Allow to pass R10 and R11 down to the VMM */
+	rcx = BIT(10) | BIT(11);
+
+	asm volatile(TDCALL
+			: "=a"(ret), "=r"(r10), "=r"(r11)
+			: "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11)
+			: );
+
+	/* It should never fail */
+	BUG_ON(ret || r10);
+}
+
+static __cpuidle void tdx_safe_halt(void)
+{
+	register long r10 asm("r10") = TDVMCALL_STANDARD;
+	register long r11 asm("r11") = EXIT_REASON_HLT;
+	register long rcx asm("rcx");
+	long ret;
+
+	/* Allow to pass R10 and R11 down to the VMM */
+	rcx = BIT(10) | BIT(11);
+
+	/* Enable interrupts next to the TDVMCALL to avoid performance degradation */
+	asm volatile("sti\n\t" TDCALL
+			: "=a"(ret), "=r"(r10), "=r"(r11)
+			: "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11)
+			: );
+
+	/* It should never fail */
+	BUG_ON(ret || r10);
+}
+
 void __init tdx_early_init(void)
 {
 	if (!cpuid_has_tdx_guest())
@@ -60,6 +99,9 @@ void __init tdx_early_init(void)
 
 	tdx_get_info();
 
+	pv_ops.irq.safe_halt = tdx_safe_halt;
+	pv_ops.irq.halt = tdx_halt;
+
 	pr_info("TDX guest is initialized\n");
 }
 
@@ -86,10 +128,17 @@ unsigned long tdx_get_ve_info(struct ve_info *ve)
 int tdx_handle_virtualization_exception(struct pt_regs *regs,
 		struct ve_info *ve)
 {
-	/*
-	 * TODO: Add handler support for various #VE exit
-	 * reasons
-	 */
-	pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
-	return -EFAULT;
+	switch (ve->exit_reason) {
+	case EXIT_REASON_HLT:
+		tdx_halt();
+		break;
+	default:
+		pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
+		return -EFAULT;
+	}
+
+	/* After successful #VE handling, move the IP */
+	regs->ip += ve->instr_len;
+
+	return ret;
 }
-- 
2.25.1

