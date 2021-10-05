Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015AF421CB5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 04:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhJECyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 22:54:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:43315 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhJECyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 22:54:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="248894651"
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="248894651"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 19:52:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="483409120"
Received: from asaini1-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.96])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 19:52:29 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 07/11] x86/tdx: Add HLT support for TDX guest
Date:   Mon,  4 Oct 2021 19:52:01 -0700
Message-Id: <20211005025205.1784480-8-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Changes since v7:
 * Added section title to spec reference in commit log and comments.
 * Added extra comments as per review suggestion.

Changes since v6:
 * None

Changes since v5:
 * Replaced sti with STI in commit log and comments.
 * Added comments for _tdx_hypercall() usage in _tdx_halt().
 * Added new helper function _tdx_halt() to contain common
   code between tdx_halt() and tdx_safe_halt().
 * Renamed tdg_->tdx_.
 * Removed BUG_ON() and used WARN_ONCE() for HLT emulation
   failure.

Changes since v4:
 * Added exception for EXIT_REASON_HLT in __tdx_hypercall() to
   enable interrupts using sti.

Changes since v3:
 * None

 arch/x86/kernel/tdcall.S | 30 ++++++++++++++++
 arch/x86/kernel/tdx.c    | 75 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
index 2e70133bebf2..1b9649ec2e29 100644
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
@@ -240,6 +243,33 @@ SYM_FUNC_START(__tdx_hypercall)
 
 	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
 
+	/*
+	 * For the idle loop STI needs to be called directly before
+	 * the TDCALL that enters idle (EXIT_REASON_HLT case). STI
+	 * enables interrupts only one instruction later. If there
+	 * are any instructions between the STI and the TDCALL for
+	 * HLT then an interrupt could happen in that time, but the
+	 * code would go back to sleep afterwards, which can cause
+	 * longer delays.
+	 *
+	 * This leads to significant difference in network performance
+	 * benchmarks. So add a special case for EXIT_REASON_HLT to
+	 * trigger STI before TDCALL. But this change is not required
+	 * for all HLT cases. So use R15 register value to identify the
+	 * case which needs STI. So, if R11 is EXIT_REASON_HLT and R15
+	 * is 1, then call STI before TDCALL instruction. Note that R15
+	 * register is not required by TDCALL ABI when triggering the
+	 * hypercall for EXIT_REASON_HLT case. So use it in software to
+	 * select the STI case.
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
index f7885c777a09..3d0416515506 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -5,6 +5,7 @@
 #define pr_fmt(fmt)     "tdx: " fmt
 
 #include <asm/tdx.h>
+#include <asm/vmx.h>
 
 /* TDX Module call Leaf IDs */
 #define TDGETVEINFO			3
@@ -53,6 +54,62 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
 	return out->r10;
 }
 
+static __cpuidle void _tdx_halt(const bool irq_disabled, const bool do_sti)
+{
+	u64 ret;
+
+	/*
+	 * Emulate HLT operation via hypercall. More info about ABI
+	 * can be found in TDX Guest-Host-Communication Interface
+	 * (GHCI), sec 3.8 TDG.VP.VMCALL<Instruction.HLT>.
+	 *
+	 * The VMM uses the "IRQ disabled" param to understand IRQ
+	 * enabled status (RFLAGS.IF) of TD guest and determine
+	 * whether or not it should schedule the halted vCPU if an
+	 * IRQ becomes pending. E.g. if IRQs are disabled the VMM
+	 * can keep the vCPU in virtual HLT, even if an IRQ is
+	 * pending, without hanging/breaking the guest.
+	 *
+	 * do_sti parameter is used by __tdx_hypercall() to decide
+	 * whether to call STI instruction before executing TDCALL
+	 * instruction.
+	 */
+	ret = _tdx_hypercall(EXIT_REASON_HLT, irq_disabled, 0, 0, do_sti, NULL);
+
+	/*
+	 * Use WARN_ONCE() to report the failure. Since tdx_*halt() calls
+	 * are also used in pv_ops, #VE error handler cannot be used to
+	 * report the failure.
+	 */
+	WARN_ONCE(ret, "HLT instruction emulation failed\n");
+}
+
+static __cpuidle void tdx_halt(void)
+{
+	const bool irq_disabled = irqs_disabled();
+	const bool do_sti = false;
+
+	/*
+	 * Non safe halt is mainly used in CPU off-lining
+	 * and the guest will stay in halt state. So,
+	 * STI instruction call is not required (set
+	 * do_sti as false).
+	 */
+	_tdx_halt(irq_disabled, do_sti);
+}
+
+static __cpuidle void tdx_safe_halt(void)
+{
+	 /*
+	  * Since STI instruction will be called in __tdx_hypercall()
+	  * set irq_disabled as false.
+	  */
+	const bool irq_disabled = false;
+	const bool do_sti = true;
+
+	_tdx_halt(irq_disabled, do_sti);
+}
+
 unsigned long tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out = {0};
@@ -79,8 +136,19 @@ unsigned long tdx_get_ve_info(struct ve_info *ve)
 int tdx_handle_virtualization_exception(struct pt_regs *regs,
 					struct ve_info *ve)
 {
-	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
-	return -EFAULT;
+	switch (ve->exit_reason) {
+	case EXIT_REASON_HLT:
+		tdx_halt();
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
@@ -92,5 +160,8 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
+	pv_ops.irq.safe_halt = tdx_safe_halt;
+	pv_ops.irq.halt = tdx_halt;
+
 	pr_info("Guest initialized\n");
 }
-- 
2.25.1

