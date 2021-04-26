Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA2D36B88F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhDZSEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:04:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:31744 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234277AbhDZSD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:29 -0400
IronPort-SDR: 6+Cx15Q7I5Lev0tE66RYpAGlWL9doxt0qTRRj7iam/V6Ytdc2nOox7BiNjEfHJhZjeBhaTFQ2r
 tPe0dbF0czqQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="195934041"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="195934041"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:47 -0700
IronPort-SDR: 8y6IxORqbSwD24BQMLZzTEX/SwlzOR8Dmx19c6xUIBHrazvoOF8IiRuS5GujDoxnrzt9lg5hBV
 6rBwPW5vDvJQ==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353364"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:44 -0700
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
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2 08/32] x86/traps: Add #VE support for TDX guest
Date:   Mon, 26 Apr 2021 11:01:35 -0700
Message-Id: <8a1d6930f784cb57c957cf20cea870947db91e05.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

The TDX module injects #VE exception to the guest TD in cases of
disallowed instructions, disallowed MSR accesses and subset of CPUID
leaves. The TDX module guarantees that no #VE is injected on an EPT
violation on guest physical addresses that are memory. We can still
get #VE on MMIO mappings. This avoids any problems with the “system
call gap”.
   
Add basic infrastructure to handle #VE. If there is no handler for a
given #VE, since it is an unexpected event (fault case), treat it as
a general protection fault and handle it using
do_general_protection() call.
   
TDCALL[TDGETVEINFO] provides information about #VE such as exit reason.

The #VE cannot be nested before TDGETVEINFO is called, if there is any
reason for it to nest the TD would shut down. The TDX module guarantees
that no NMIs (or #MC or similar) can happen in this window. After
TDGETVEINFO the #VE handler can nest if needed, although we don’t expect
it to happen normally.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/idtentry.h |  4 ++++
 arch/x86/include/asm/tdx.h      | 15 +++++++++++++
 arch/x86/kernel/idt.c           |  6 ++++++
 arch/x86/kernel/tdx.c           | 38 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/traps.c         | 30 ++++++++++++++++++++++++++
 5 files changed, 93 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 5eb3bdf36a41..41a0732d5f68 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -619,6 +619,10 @@ DECLARE_IDTENTRY_XENCB(X86_TRAP_OTHER,	exc_xen_hypervisor_callback);
 DECLARE_IDTENTRY_RAW(X86_TRAP_OTHER,	exc_xen_unknown_trap);
 #endif
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+DECLARE_IDTENTRY(X86_TRAP_VE,		exc_virtualization_exception);
+#endif
+
 /* Device interrupts common/spurious */
 DECLARE_IDTENTRY_IRQ(X86_TRAP_OTHER,	common_interrupt);
 #ifdef CONFIG_X86_LOCAL_APIC
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index c5a870cef0ae..1ca55d8e9963 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 
 #define TDINFO			1
+#define TDGETVEINFO		3
 
 struct tdcall_output {
 	u64 rcx;
@@ -29,6 +30,20 @@ struct tdvmcall_output {
 	u64 r15;
 };
 
+struct ve_info {
+	u64 exit_reason;
+	u64 exit_qual;
+	u64 gla;
+	u64 gpa;
+	u32 instr_len;
+	u32 instr_info;
+};
+
+unsigned long tdg_get_ve_info(struct ve_info *ve);
+
+int tdg_handle_virtualization_exception(struct pt_regs *regs,
+		struct ve_info *ve);
+
 /* Common API to check TDX support in decompression and common kernel code. */
 bool is_tdx_guest(void);
 
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index ee1a283f8e96..546b6b636c7d 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -64,6 +64,9 @@ static const __initconst struct idt_data early_idts[] = {
 	 */
 	INTG(X86_TRAP_PF,		asm_exc_page_fault),
 #endif
+#ifdef CONFIG_INTEL_TDX_GUEST
+	INTG(X86_TRAP_VE,		asm_exc_virtualization_exception),
+#endif
 };
 
 /*
@@ -87,6 +90,9 @@ static const __initconst struct idt_data def_idts[] = {
 	INTG(X86_TRAP_MF,		asm_exc_coprocessor_error),
 	INTG(X86_TRAP_AC,		asm_exc_alignment_check),
 	INTG(X86_TRAP_XF,		asm_exc_simd_coprocessor_error),
+#ifdef CONFIG_INTEL_TDX_GUEST
+	INTG(X86_TRAP_VE,		asm_exc_virtualization_exception),
+#endif
 
 #ifdef CONFIG_X86_32
 	TSKG(X86_TRAP_DF,		GDT_ENTRY_DOUBLEFAULT_TSS),
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index b63275db1db9..ccfcb07bfb2c 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -82,6 +82,44 @@ static void tdg_get_info(void)
 	td_info.attributes = out.rdx;
 }
 
+unsigned long tdg_get_ve_info(struct ve_info *ve)
+{
+	u64 ret;
+	struct tdcall_output out = {0};
+
+	/*
+	 * The #VE cannot be nested before TDGETVEINFO is called,
+	 * if there is any reason for it to nest the TD would shut
+	 * down. The TDX module guarantees that no NMIs (or #MC or
+	 * similar) can happen in this window. After TDGETVEINFO
+	 * the #VE handler can nest if needed, although we don’t
+	 * expect it to happen normally.
+	 */
+
+	ret = __tdcall(TDGETVEINFO, 0, 0, 0, 0, &out);
+
+	ve->exit_reason = out.rcx;
+	ve->exit_qual   = out.rdx;
+	ve->gla         = out.r8;
+	ve->gpa         = out.r9;
+	ve->instr_len   = out.r10 & UINT_MAX;
+	ve->instr_info  = out.r10 >> 32;
+
+	return ret;
+}
+
+int tdg_handle_virtualization_exception(struct pt_regs *regs,
+		struct ve_info *ve)
+{
+	/*
+	 * TODO: Add handler support for various #VE exit
+	 * reasons. It will be added by other patches in
+	 * the series.
+	 */
+	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
+	return -EFAULT;
+}
+
 void __init tdx_early_init(void)
 {
 	if (!cpuid_has_tdx_guest())
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 213d4aa8e337..64869aa88a5a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -61,6 +61,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/vdso.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -1140,6 +1141,35 @@ DEFINE_IDTENTRY(exc_device_not_available)
 	}
 }
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+DEFINE_IDTENTRY(exc_virtualization_exception)
+{
+	struct ve_info ve;
+	int ret;
+
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+
+	/*
+	 * Consume #VE info before re-enabling interrupts. It will be
+	 * re-enabled after executing the TDGETVEINFO TDCALL.
+	 */
+	ret = tdg_get_ve_info(&ve);
+
+	cond_local_irq_enable(regs);
+
+	if (!ret)
+		ret = tdg_handle_virtualization_exception(regs, &ve);
+	/*
+	 * If tdg_handle_virtualization_exception() could not process
+	 * it successfully, treat it as #GP(0) and handle it.
+	 */
+	if (ret)
+		do_general_protection(regs, 0);
+
+	cond_local_irq_disable(regs);
+}
+#endif
+
 #ifdef CONFIG_X86_32
 DEFINE_IDTENTRY_SW(iret_error)
 {
-- 
2.25.1

