Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5F4397EEC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 04:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhFBCYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:24:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:39492 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230379AbhFBCXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:23:34 -0400
IronPort-SDR: HNgGpPEJqLnMyf5xOHJqvhGU21StFtJn2x3RO+68TAHce1Gjxsp4PJyqW2mbGe7v3YQnsm9G1Z
 adpReFFSPH0g==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="191037608"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="191037608"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 19:21:51 -0700
IronPort-SDR: A8txEX5/YF9jh1B/XH0xl7H5SqjgQhzhqcqPHPxXbqVaVroNYeqp23rC7PLosmOFRrpMJlA74g
 nJnVjNtMKTdA==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="633069246"
Received: from mjdelaro-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.3.23])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 19:21:51 -0700
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v1 10/11] x86/tdx: Add MSR support for TDX guest
Date:   Tue,  1 Jun 2021 19:21:35 -0700
Message-Id: <20210602022136.2186759-11-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 67 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 76b71bf56b81..af7acea500ab 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -115,6 +115,55 @@ static __cpuidle void tdg_safe_halt(void)
 	BUG_ON(ret);
 }
 
+static bool tdg_is_context_switched_msr(unsigned int msr)
+{
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
+	struct tdx_hypercall_output out = {0};
+
+	WARN_ON_ONCE(tdg_is_context_switched_msr(msr));
+
+	ret = __tdx_hypercall(EXIT_REASON_MSR_READ, msr, 0, 0, 0, &out);
+
+	*err = ret ? -EIO : 0;
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
+	ret = __tdx_hypercall(EXIT_REASON_MSR_WRITE, msr, (u64)high << 32 | low,
+			      0, 0, NULL);
+
+	return ret ? -EIO : 0;
+}
+
 unsigned long tdg_get_ve_info(struct ve_info *ve)
 {
 	u64 ret;
@@ -141,19 +190,33 @@ unsigned long tdg_get_ve_info(struct ve_info *ve)
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

