Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFB236B894
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhDZSEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:04:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:6419 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234313AbhDZSDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:33 -0400
IronPort-SDR: UfCykPGmWF+VkQnedUnUufot4Sw/EGGNXChX6T0yfKOu1yz8bZ5p7dsIc+L+iKhFsd7PWgJ+u2
 IF8SIfvL0QNw==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="281710679"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="281710679"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:47 -0700
IronPort-SDR: wm1KNH5BrdOdIFyyY2ye2YnM7214haPyhOAAGmgHL6xTgAq1Fe+Lf6Gqh2h5YCM+B+teM7fNPp
 vMm7CAuEBCTQ==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353377"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:46 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2 11/32] x86/tdx: Add MSR support for TDX guest
Date:   Mon, 26 Apr 2021 11:01:38 -0700
Message-Id: <d9012bb65c6934aa9c77eda7335fdf8bdf36c78c.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
instruction, ignore accesses to CSTAR MSR.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 85 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 721c213d807d..5b16707b3577 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -107,6 +107,73 @@ static __cpuidle void tdg_safe_halt(void)
 	tdg_halt();
 }
 
+static bool tdg_is_context_switched_msr(unsigned int msr)
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
+static u64 tdg_read_msr_safe(unsigned int msr, int *err)
+{
+	u64 ret;
+	struct tdvmcall_output out = {0};
+
+	WARN_ON_ONCE(tdg_is_context_switched_msr(msr));
+
+	/*
+	 * Since CSTAR MSR is not used by Intel CPUs as SYSCALL
+	 * instruction, just ignore it. Even raising TDVMCALL
+	 * will lead to same result.
+	 */
+	if (msr == MSR_CSTAR)
+		return 0;
+
+	ret = __tdvmcall(EXIT_REASON_MSR_READ, msr, 0, 0, 0, &out);
+
+	*err = (ret) ? -EIO : 0;
+
+	return out.r11;
+}
+
+static int tdg_write_msr_safe(unsigned int msr, unsigned int low,
+			      unsigned int high)
+{
+	u64 ret;
+
+	WARN_ON_ONCE(tdg_is_context_switched_msr(msr));
+
+	/*
+	 * Since CSTAR MSR is not used by Intel CPUs as SYSCALL
+	 * instruction, just ignore it. Even raising TDVMCALL
+	 * will lead to same result.
+	 */
+	if (msr == MSR_CSTAR)
+		return 0;
+
+	ret = __tdvmcall(EXIT_REASON_MSR_WRITE, msr, (u64)high << 32 | low,
+			 0, 0, NULL);
+
+	return ret ? -EIO : 0;
+}
+
 unsigned long tdg_get_ve_info(struct ve_info *ve)
 {
 	u64 ret;
@@ -136,19 +203,33 @@ unsigned long tdg_get_ve_info(struct ve_info *ve)
 int tdg_handle_virtualization_exception(struct pt_regs *regs,
 		struct ve_info *ve)
 {
+	unsigned long val;
+	int ret = 0;
+
 	switch (ve->exit_reason) {
 	case EXIT_REASON_HLT:
 		tdg_halt();
 		break;
+	case EXIT_REASON_MSR_READ:
+		val = tdg_read_msr_safe(regs->cx, (unsigned int *)&ret);
+		if (!ret) {
+			regs->ax = val & UINT_MAX;
+			regs->dx = val >> 32;
+		}
+		break;
+	case EXIT_REASON_MSR_WRITE:
+		ret = tdg_write_msr_safe(regs->cx, regs->ax, regs->dx);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return -EFAULT;
 	}
 
 	/* After successful #VE handling, move the IP */
-	regs->ip += ve->instr_len;
+	if (!ret)
+		regs->ip += ve->instr_len;
 
-	return 0;
+	return ret;
 }
 
 void __init tdx_early_init(void)
-- 
2.25.1

