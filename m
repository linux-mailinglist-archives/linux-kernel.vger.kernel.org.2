Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9BE3E075C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbhHDSPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:15:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:49808 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240119AbhHDSPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:15:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="201151111"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="201151111"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 11:14:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="503075866"
Received: from mjkendri-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.17.117])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 11:14:49 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/12] x86/tdx: Add HLT support for TDX guest
Date:   Wed,  4 Aug 2021 11:13:25 -0700
Message-Id: <20210804181329.2899708-9-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

The same TDX hypercall is used to handle #VE exception due to
EXIT_REASON_HLT.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v4:
 * Added exception for EXIT_REASON_HLT in __tdx_hypercall() to
   enable interrupts using sti.

Changes since v3:
 * None

 arch/x86/kernel/tdcall.S | 29 +++++++++++++++++++++++
 arch/x86/kernel/tdx.c    | 51 ++++++++++++++++++++++++++++++++++------
 2 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
index c9c91c1bf99d..9df94f87465d 100644
--- a/arch/x86/kernel/tdcall.S
+++ b/arch/x86/kernel/tdcall.S
@@ -40,6 +40,9 @@
  */
 #define tdcall .byte 0x66,0x0f,0x01,0xcc
 
+/* HLT TDVMCALL sub-function ID */
+#define EXIT_REASON_HLT			12
+
 /*
  * __tdx_module_call()  - Helper function used by TDX guests to request
  * services from the TDX module (does not include VMM services).
@@ -240,6 +243,32 @@ SYM_FUNC_START(__tdx_hypercall)
 
 	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
 
+	/*
+	 * For the idle loop STI needs to be called directly before
+	 * the TDCALL that enters idle (EXIT_REASON_HLT case). STI
+	 * enables interrupts only one instruction later. If there
+	 * are any instructions between the STI and the TDCALL for
+	 * HLT then an interrupt could happen in that time, but the
+	 * code would go back to sleep afterwards, which can cause
+	 * longer delays. There leads to significant difference in
+	 * network performance benchmarks. So add a special case for
+	 * EXIT_REASON_HLT to trigger sti before TDCALL. But this
+	 * change is not required for all HLT cases. So use R15
+	 * register value to identify the case which needs sti. So,
+	 * if R11 is EXIT_REASON_HLT and R15 is 1, then call sti
+	 * before TDCALL instruction. Note that R15 register is not
+	 * required by TDCALL ABI when triggering the hypercall for
+	 * EXIT_REASON_HLT case. So use it in software to select the
+	 * sti case.
+	 */
+	cmpl $EXIT_REASON_HLT, %r11d
+	jne skip_sti
+	cmpl $1, %r15d
+	jne skip_sti
+	/* Set R15 register to 0, it is unused in EXIT_REASON_HLT case */
+	xor %r15, %r15
+	sti
+skip_sti:
 	tdcall
 
 	/* Restore output pointer to R9 */
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 6169f9c740b2..bdd041c4c509 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -7,6 +7,7 @@
 #include <linux/protected_guest.h>
 
 #include <asm/tdx.h>
+#include <asm/vmx.h>
 
 /* TDX Module call Leaf IDs */
 #define TDINFO				1
@@ -76,6 +77,33 @@ static void tdg_get_info(void)
 	td_info.attributes = out.rdx;
 }
 
+static __cpuidle void tdg_halt(void)
+{
+	u64 ret;
+
+	ret = _tdx_hypercall(EXIT_REASON_HLT, irqs_disabled(), 0, 0, 0, NULL);
+
+	/* It should never fail */
+	BUG_ON(ret);
+}
+
+static __cpuidle void tdg_safe_halt(void)
+{
+	u64 ret;
+
+	/*
+	 * Enable interrupts next to the TDVMCALL to avoid
+	 * performance degradation.
+	 */
+	local_irq_enable();
+
+	/* IRQ is enabled, So set R12 as 0 */
+	ret = _tdx_hypercall(EXIT_REASON_HLT, 0, 0, 0, 1, NULL);
+
+	/* It should never fail */
+	BUG_ON(ret);
+}
+
 unsigned long tdg_get_ve_info(struct ve_info *ve)
 {
 	u64 ret;
@@ -102,13 +130,19 @@ unsigned long tdg_get_ve_info(struct ve_info *ve)
 int tdg_handle_virtualization_exception(struct pt_regs *regs,
 					struct ve_info *ve)
 {
-	/*
-	 * TODO: Add handler support for various #VE exit
-	 * reasons. It will be added by other patches in
-	 * the series.
-	 */
-	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
-	return -EFAULT;
+	switch (ve->exit_reason) {
+	case EXIT_REASON_HLT:
+		tdg_halt();
+		break;
+	default:
+		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
+		return -EFAULT;
+	}
+
+	/* After successful #VE handling, move the IP */
+	regs->ip += ve->instr_len;
+
+	return 0;
 }
 
 void __init tdx_early_init(void)
@@ -120,5 +154,8 @@ void __init tdx_early_init(void)
 
 	tdg_get_info();
 
+	pv_ops.irq.safe_halt = tdg_safe_halt;
+	pv_ops.irq.halt = tdg_halt;
+
 	pr_info("Guest initialized\n");
 }
-- 
2.25.1

