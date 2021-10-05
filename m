Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD49421CB7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 04:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhJECyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 22:54:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:43315 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231588AbhJECyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 22:54:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="248894660"
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="248894660"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 19:52:32 -0700
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="483409131"
Received: from asaini1-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.96])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 19:52:31 -0700
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
Subject: [PATCH v8 09/11] x86/tdx: Add MSR support for TDX guest
Date:   Mon,  4 Oct 2021 19:52:03 -0700
Message-Id: <20211005025205.1784480-10-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Use hypercall to emulate MSR read/write for TDX platform.

TDVMCALL[Instruction.RDMSR] and TDVMCALL[Instruction.WRMSR] provide MSR
oprations.

RDMSR and WRMSR specification details can be found in
Guest-Host-Communication Interface (GHCI) for Intel Trust Domain
Extensions (Intel TDX) specification, sec titled "TDG.VP.
VMCALL<Instruction.RDMSR>" and "TDG.VP.VMCALL<Instruction.WRMSR>".

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v7:
 * Removed tdx_is_context_switched_msr() support (since the list
   is incomplete).
 * Added section title to spec reference.

Changes since v6:
 * None

Changes since v5:
 * Renamed "tdg" prefix with "tdx".
 * Added comments for _tdx_hypercall() usage in MSR read/write functions.

Change since v4:
 * Removed You usage from commit log.

Changes since v3:
 * None

 arch/x86/kernel/tdx.c | 53 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 3d0416515506..062ac4720434 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -110,6 +110,41 @@ static __cpuidle void tdx_safe_halt(void)
 	_tdx_halt(irq_disabled, do_sti);
 }
 
+static u64 tdx_read_msr_safe(unsigned int msr, int *err)
+{
+	struct tdx_hypercall_output out = {0};
+	u64 ret;
+
+	/*
+	 * Emulate the MSR read via hypercall. More info about ABI
+	 * can be found in TDX Guest-Host-Communication Interface
+	 * (GHCI), sec titled "TDG.VP.VMCALL<Instruction.RDMSR>".
+	 */
+	ret = _tdx_hypercall(EXIT_REASON_MSR_READ, msr, 0, 0, 0, &out);
+
+	*err = ret ? -EIO : 0;
+
+	return out.r11;
+}
+
+static int tdx_write_msr_safe(unsigned int msr, unsigned int low,
+			      unsigned int high)
+{
+	u64 ret;
+
+	WARN_ON_ONCE(tdx_is_context_switched_msr(msr));
+
+	/*
+	 * Emulate the MSR write via hypercall. More info about ABI
+	 * can be found in TDX Guest-Host-Communication Interface
+	 * (GHCI) sec titled "TDG.VP.VMCALL<Instruction.WRMSR>".
+	 */
+	ret = _tdx_hypercall(EXIT_REASON_MSR_WRITE, msr, (u64)high << 32 | low,
+			     0, 0, NULL);
+
+	return ret ? -EIO : 0;
+}
+
 unsigned long tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out = {0};
@@ -136,19 +171,33 @@ unsigned long tdx_get_ve_info(struct ve_info *ve)
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
+			regs->ax = (u32)val;
+			regs->dx = val >> 32;
+		}
+		break;
+	case EXIT_REASON_MSR_WRITE:
+		ret = tdx_write_msr_safe(regs->cx, regs->ax, regs->dx);
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

