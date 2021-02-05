Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6FD311B0D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhBFEo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:44:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:63285 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232482AbhBFDY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:24:59 -0500
IronPort-SDR: vQH8o4LLjQoYBP9X8fW8fL6/yhD0SWxZy1sT95ajbClQXx9tBnt3OrZjNuwVlMhL4rXvvJswF2
 xybeYewZnSDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650721"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650721"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:08 -0800
IronPort-SDR: CJIinL7L8M5rvCVjM4EJ8qTcjk9BWp/RFEgRxkqIXynXK40+EOG1xogtozg55nEbEbejHn40Xv
 PMRcuphuc/4g==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183889"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:07 -0800
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
Subject: [RFC v1 08/26] x86/tdx: Add MSR support for TDX guest
Date:   Fri,  5 Feb 2021 15:38:25 -0800
Message-Id: <fe5682386567f2e02e1b9e8e39a07d43d2d31952.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Operations on context-switched MSRs can be run natively. The rest of
MSRs should be handled through TDVMCALLs.

TDVMCALL[Instruction.RDMSR] and TDVMCALL[Instruction.WRMSR] provide
MSR oprations.

You can find RDMSR and WRMSR details in Guest-Host-Communication
Interface (GHCI) for Intel Trust Domain Extensions (Intel TDX)
specification, sec 3.10, 3.11.

Also, since CSTAR MSR is not used on Intel CPUs as SYSCALL
instruction, ignore accesses to CSTAR MSR. Ignore accesses to
the MSR for compatibility: no need in wrap callers in
!is_tdx_guest().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 94 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index bbefe639a2ed..5d961263601e 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -94,6 +94,84 @@ static __cpuidle void tdx_safe_halt(void)
 	BUG_ON(ret || r10);
 }
 
+static bool tdx_is_context_switched_msr(unsigned int msr)
+{
+	/*  XXX: Update the list of context-switched MSRs */
+
+	switch (msr) {
+	case MSR_EFER:
+	case MSR_IA32_CR_PAT:
+	case MSR_FS_BASE:
+	case MSR_GS_BASE:
+	case MSR_KERNEL_GS_BASE:
+	case MSR_IA32_SYSENTER_CS:
+	case MSR_IA32_SYSENTER_EIP:
+	case MSR_IA32_SYSENTER_ESP:
+	case MSR_STAR:
+	case MSR_LSTAR:
+	case MSR_SYSCALL_MASK:
+	case MSR_IA32_XSS:
+	case MSR_TSC_AUX:
+	case MSR_IA32_BNDCFGS:
+		return true;
+	}
+	return false;
+}
+
+static u64 tdx_read_msr_safe(unsigned int msr, int *err)
+{
+	register long r10 asm("r10") = TDVMCALL_STANDARD;
+	register long r11 asm("r11") = EXIT_REASON_MSR_READ;
+	register long r12 asm("r12") = msr;
+	register long rcx asm("rcx");
+	long ret;
+
+	WARN_ON_ONCE(tdx_is_context_switched_msr(msr));
+
+	if (msr == MSR_CSTAR)
+		return 0;
+
+	/* Allow to pass R10, R11 and R12 down to the VMM */
+	rcx = BIT(10) | BIT(11) | BIT(12);
+
+	asm volatile(TDCALL
+			: "=a"(ret), "=r"(r10), "=r"(r11), "=r"(r12)
+			: "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11), "r"(r12)
+			: );
+
+	/* XXX: Better error handling needed? */
+	*err = (ret || r10) ? -EIO : 0;
+
+	return r11;
+}
+
+static int tdx_write_msr_safe(unsigned int msr, unsigned int low,
+			      unsigned int high)
+{
+	register long r10 asm("r10") = TDVMCALL_STANDARD;
+	register long r11 asm("r11") = EXIT_REASON_MSR_WRITE;
+	register long r12 asm("r12") = msr;
+	register long r13 asm("r13") = (u64)high << 32 | low;
+	register long rcx asm("rcx");
+	long ret;
+
+	WARN_ON_ONCE(tdx_is_context_switched_msr(msr));
+
+	if (msr == MSR_CSTAR)
+		return 0;
+
+	/* Allow to pass R10, R11, R12 and R13 down to the VMM */
+	rcx = BIT(10) | BIT(11) | BIT(12) | BIT(13);
+
+	asm volatile(TDCALL
+			: "=a"(ret), "=r"(r10), "=r"(r11), "=r"(r12), "=r"(r13)
+			: "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11), "r"(r12),
+			  "r"(r13)
+			: );
+
+	return ret || r10 ? -EIO : 0;
+}
+
 void __init tdx_early_init(void)
 {
 	if (!cpuid_has_tdx_guest())
@@ -132,17 +210,31 @@ unsigned long tdx_get_ve_info(struct ve_info *ve)
 int tdx_handle_virtualization_exception(struct pt_regs *regs,
 		struct ve_info *ve)
 {
+	unsigned long val;
+	int ret = 0;
+
 	switch (ve->exit_reason) {
 	case EXIT_REASON_HLT:
 		tdx_halt();
 		break;
+	case EXIT_REASON_MSR_READ:
+		val = tdx_read_msr_safe(regs->cx, (unsigned int *)&ret);
+		if (!ret) {
+			regs->ax = val & UINT_MAX;
+			regs->dx = val >> 32;
+		}
+		break;
+	case EXIT_REASON_MSR_WRITE:
+		ret = tdx_write_msr_safe(regs->cx, regs->ax, regs->dx);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
 		return -EFAULT;
 	}
 
 	/* After successful #VE handling, move the IP */
-	regs->ip += ve->instr_len;
+	if (!ret)
+		regs->ip += ve->instr_len;
 
 	return ret;
 }
-- 
2.25.1

