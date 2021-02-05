Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1A9311AE3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBFEag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:30:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:63384 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231250AbhBFDTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:19:32 -0500
IronPort-SDR: FbmUdRw13APCgm2lDDPIc3ybipe0pI3UM6MkaSnP7GfVkwb90XkRn/hR5t4MaDuELSJJpH39VP
 jNR2St0C9wuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650715"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650715"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:06 -0800
IronPort-SDR: dsnN7qnGEhuDaOfRY52GQVOo34n7+rcS+jy7bZsC7PL6zT8l59JeWIjxa2kRluEe1Yhz1UavT1
 HkQ5c63ti/JA==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183876"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:05 -0800
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
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v1 05/26] x86/traps: Add #VE support for TDX guest
Date:   Fri,  5 Feb 2021 15:38:22 -0800
Message-Id: <48a702f536ccf953eee5778023ed6d1a452f6dcf.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

The TDX module injects #VE exception to the guest TD in cases of
disallowed instructions, disallowed MSR accesses and subset of CPUID
leaves. Also, it's theoretically possible for CPU to inject #VE
exception on EPT violation, but the TDX module makes sure this does
not happen, as long as all memory used is properly accepted using
TDCALLs. You can find more details about it in, Guest-Host-Communication
Interface (GHCI) for Intel Trust Domain Extensions (Intel TDX)
specification, sec 2.3.

Add basic infrastructure to handle #VE. If there is no handler for a
given #VE, since its a unexpected event (fault case), treat it as a
general protection fault and handle it using do_general_protection()
call.

TDCALL[TDGETVEINFO] provides information about #VE such as exit reason.

More details on cases where #VE exceptions are allowed/not-allowed:

The #VE exception do not occur in the paranoid entry paths, like NMIs.
While other operations during an NMI might cause #VE, these are in the
NMI code that can handle nesting, so there is no concern about
reentrancy. This is similar to how #PF is handled in NMIs.

The #VE exception also cannot happen in entry/exit code with the
wrong gs, such as the SWAPGS code, so it's entry point does not
need "paranoid" handling.

Any memory accesses can cause #VE if it causes an EPT
violation.  However, the VMM is only in direct control of some of the
EPT tables.  The Secure EPT tables are controlled by the TDX module
which guarantees no EPT violations will result in #VE for the guest,
once the memory has been accepted.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/idtentry.h |  4 ++
 arch/x86/include/asm/tdx.h      | 14 +++++++
 arch/x86/kernel/idt.c           |  6 +++
 arch/x86/kernel/tdx.c           | 31 ++++++++++++++
 arch/x86/kernel/traps.c         | 73 ++++++++++++++++++++++-----------
 5 files changed, 105 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 247a60a47331..a2cbb68f9ae8 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -615,6 +615,10 @@ DECLARE_IDTENTRY_VC(X86_TRAP_VC,	exc_vmm_communication);
 DECLARE_IDTENTRY_XENCB(X86_TRAP_OTHER,	exc_xen_hypervisor_callback);
 #endif
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+DECLARE_IDTENTRY(X86_TRAP_VE,		exc_virtualization_exception);
+#endif
+
 /* Device interrupts common/spurious */
 DECLARE_IDTENTRY_IRQ(X86_TRAP_OTHER,	common_interrupt);
 #ifdef CONFIG_X86_LOCAL_APIC
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index f8cdc8eb1046..90eb61b07d1f 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -15,6 +15,7 @@
 #define TDCALL	".byte 0x66,0x0f,0x01,0xcc"
 
 #define TDINFO		1
+#define TDGETVEINFO	3
 
 /* Common API to check TDX support in decompression and common kernel code. */
 bool is_tdx_guest(void);
@@ -32,4 +33,17 @@ static inline void tdx_early_init(void) { };
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
+struct ve_info {
+	unsigned int exit_reason;
+	unsigned long exit_qual;
+	unsigned long gla;
+	unsigned long gpa;
+	unsigned int instr_len;
+	unsigned int instr_info;
+};
+
+unsigned long tdx_get_ve_info(struct ve_info *ve);
+int tdx_handle_virtualization_exception(struct pt_regs *regs,
+		struct ve_info *ve);
+
 #endif /* _ASM_X86_TDX_H */
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
index 13303bfdfdd1..ae2d5c847700 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -62,3 +62,34 @@ void __init tdx_early_init(void)
 
 	pr_info("TDX guest is initialized\n");
 }
+
+unsigned long tdx_get_ve_info(struct ve_info *ve)
+{
+	register long r8 asm("r8");
+	register long r9 asm("r9");
+	register long r10 asm("r10");
+	unsigned long ret;
+
+	asm volatile(TDCALL
+		     : "=a"(ret), "=c"(ve->exit_reason), "=d"(ve->exit_qual),
+		     "=r"(r8), "=r"(r9), "=r"(r10)
+		     : "a"(TDGETVEINFO)
+		     :);
+
+	ve->gla = r8;
+	ve->gpa = r9;
+	ve->instr_len = r10 & UINT_MAX;
+	ve->instr_info = r10 >> 32;
+	return ret;
+}
+
+int tdx_handle_virtualization_exception(struct pt_regs *regs,
+		struct ve_info *ve)
+{
+	/*
+	 * TODO: Add handler support for various #VE exit
+	 * reasons
+	 */
+	pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
+	return -EFAULT;
+}
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 7f5aec758f0e..ba98253b47cd 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -61,6 +61,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/vdso.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -527,30 +528,14 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 
 #define GPFSTR "general protection fault"
 
-DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
+static void do_general_protection(struct pt_regs *regs, long error_code)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
 	enum kernel_gp_hint hint = GP_NO_HINT;
-	struct task_struct *tsk;
+	struct task_struct *tsk = current;
 	unsigned long gp_addr;
 	int ret;
 
-	cond_local_irq_enable(regs);
-
-	if (static_cpu_has(X86_FEATURE_UMIP)) {
-		if (user_mode(regs) && fixup_umip_exception(regs))
-			goto exit;
-	}
-
-	if (v8086_mode(regs)) {
-		local_irq_enable();
-		handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
-		local_irq_disable();
-		return;
-	}
-
-	tsk = current;
-
 	if (user_mode(regs)) {
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_nr = X86_TRAP_GP;
@@ -560,11 +545,11 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 
 		show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
 		force_sig(SIGSEGV);
-		goto exit;
+		return;
 	}
 
 	if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
-		goto exit;
+		return;
 
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_nr = X86_TRAP_GP;
@@ -576,11 +561,11 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	if (!preemptible() &&
 	    kprobe_running() &&
 	    kprobe_fault_handler(regs, X86_TRAP_GP))
-		goto exit;
+		return;
 
 	ret = notify_die(DIE_GPF, desc, regs, error_code, X86_TRAP_GP, SIGSEGV);
 	if (ret == NOTIFY_STOP)
-		goto exit;
+		return;
 
 	if (error_code)
 		snprintf(desc, sizeof(desc), "segment-related " GPFSTR);
@@ -601,8 +586,27 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		gp_addr = 0;
 
 	die_addr(desc, regs, error_code, gp_addr);
+}
 
-exit:
+DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
+{
+	cond_local_irq_enable(regs);
+
+	if (static_cpu_has(X86_FEATURE_UMIP)) {
+		if (user_mode(regs) && fixup_umip_exception(regs)) {
+			cond_local_irq_disable(regs);
+			return;
+		}
+	}
+
+	if (v8086_mode(regs)) {
+		local_irq_enable();
+		handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
+		local_irq_disable();
+		return;
+	}
+
+	do_general_protection(regs, error_code);
 	cond_local_irq_disable(regs);
 }
 
@@ -1138,6 +1142,29 @@ DEFINE_IDTENTRY(exc_device_not_available)
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
+	/* Consume #VE info before re-enabling interrupts */
+	ret = tdx_get_ve_info(&ve);
+	cond_local_irq_enable(regs);
+	if (!ret)
+		ret = tdx_handle_virtualization_exception(regs, &ve);
+	/*
+	 * If #VE exception handler could not handle it successfully, treat
+	 * it as #GP(0) and handle it.
+	 */
+	if (ret)
+		do_general_protection(regs, 0);
+	cond_local_irq_disable(regs);
+}
+#endif
+
 #ifdef CONFIG_X86_32
 DEFINE_IDTENTRY_SW(iret_error)
 {
-- 
2.25.1

