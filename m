Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E0B3CF18A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 03:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbhGTBA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:00:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:28259 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378846AbhGTAKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 20:10:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="191435155"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="191435155"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 17:42:12 -0700
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="660970667"
Received: from ywei11-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 17:42:11 -0700
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
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v4 07/11] x86/traps: Add #VE support for TDX guest
Date:   Mon, 19 Jul 2021 17:40:53 -0700
Message-Id: <20210720004057.2112666-8-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720004057.2112666-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210720004057.2112666-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Virtualization Exceptions (#VE) are delivered to TDX guests due to
specific guest actions which may happen in either user space or the kernel:

 * Specific instructions (WBINVD, for example)
 * Specific MSR accesses
 * Specific CPUID leaf accesses
 * Access to TD-shared memory, which includes MMIO

In the settings that Linux will run in, virtual exceptions are never
generated on accesses to normal, TD-private memory that has been
accepted.

The entry paths do not access TD-shared memory, MMIO regions or use
those specific MSRs, instructions, CPUID leaves that might generate #VE.
In addition, all interrupts including NMIs are blocked by the hardware
starting with #VE delivery until TDGETVEINFO is called.  This eliminates
the chance of a #VE during the syscall gap or paranoid entry paths and
simplifies #VE handling.

After TDGETVEINFO #VE could happen in theory (e.g. through an NMI),
but it is expected not to happen because TDX expects NMIs not to
trigger #VEs. Another case where they could happen is if the #VE
exception panics, but in this case there are no guarantees on anything
anyways.

If a guest kernel action which would normally cause a #VE occurs in the
interrupt-disabled region before TDGETVEINFO, a #DF is delivered to the
guest which will result in an oops (and should eventually be a panic, as
we would like to set panic_on_oops to 1 for TDX guests).

Add basic infrastructure to handle any #VE which occurs in the kernel or
userspace.  Later patches will add handling for specific #VE scenarios.

Convert unhandled #VE's (everything, until later in this series) so that
they appear just like a #GP by calling ve_raise_fault() directly.
ve_raise_fault() is similar to #GP handler and is responsible for
sending SIGSEGV to userspace and cpu die and notifying debuggers and
other die chain users.  

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v3:
 * None

 arch/x86/include/asm/idtentry.h |  4 ++
 arch/x86/include/asm/tdx.h      | 19 +++++++++
 arch/x86/kernel/idt.c           |  6 +++
 arch/x86/kernel/tdx.c           | 36 +++++++++++++++++
 arch/x86/kernel/traps.c         | 69 +++++++++++++++++++++++++++++++++
 5 files changed, 134 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 1345088e9902..8ccc81d653b3 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -625,6 +625,10 @@ DECLARE_IDTENTRY_XENCB(X86_TRAP_OTHER,	exc_xen_hypervisor_callback);
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
index 72a6a719ce37..846fe58f0426 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -39,6 +39,20 @@ struct tdx_hypercall_output {
 	u64 r15;
 };
 
+/*
+ * Used by #VE exception handler to gather the #VE exception
+ * info from the TDX module. This is software only structure
+ * and not related to TDX module/VMM.
+ */
+struct ve_info {
+	u64 exit_reason;
+	u64 exit_qual;
+	u64 gla;	/* Guest Linear (virtual) Address */
+	u64 gpa;	/* Guest Physical (virtual) Address */
+	u32 instr_len;
+	u32 instr_info;
+};
+
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 void __init tdx_early_init(void);
@@ -53,6 +67,11 @@ u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 u64 __tdx_hypercall(u64 type, u64 fn, u64 r12, u64 r13, u64 r14,
 		    u64 r15, struct tdx_hypercall_output *out);
 
+unsigned long tdg_get_ve_info(struct ve_info *ve);
+
+int tdg_handle_virtualization_exception(struct pt_regs *regs,
+					struct ve_info *ve);
+
 #else
 
 static inline void tdx_early_init(void) { };
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index df0fa695bb09..a5eaae8e6c44 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -68,6 +68,9 @@ static const __initconst struct idt_data early_idts[] = {
 	 */
 	INTG(X86_TRAP_PF,		asm_exc_page_fault),
 #endif
+#ifdef CONFIG_INTEL_TDX_GUEST
+	INTG(X86_TRAP_VE,		asm_exc_virtualization_exception),
+#endif
 };
 
 /*
@@ -91,6 +94,9 @@ static const __initconst struct idt_data def_idts[] = {
 	INTG(X86_TRAP_MF,		asm_exc_coprocessor_error),
 	INTG(X86_TRAP_AC,		asm_exc_alignment_check),
 	INTG(X86_TRAP_XF,		asm_exc_simd_coprocessor_error),
+#ifdef CONFIG_INTEL_TDX_GUEST
+	INTG(X86_TRAP_VE,		asm_exc_virtualization_exception),
+#endif
 
 #ifdef CONFIG_X86_32
 	TSKG(X86_TRAP_DF,		GDT_ENTRY_DOUBLEFAULT_TSS),
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 5d05c77cd85b..1bbcf7626af2 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -10,6 +10,7 @@
 
 /* TDX Module call Leaf IDs */
 #define TDINFO				1
+#define TDGETVEINFO			3
 
 static struct {
 	unsigned int gpa_width;
@@ -79,6 +80,41 @@ static void tdg_get_info(void)
 	td_info.attributes = out.rdx;
 }
 
+unsigned long tdg_get_ve_info(struct ve_info *ve)
+{
+	u64 ret;
+	struct tdx_module_output out = {0};
+
+	/*
+	 * NMIs and machine checks are suppressed. Before this point any
+	 * #VE is fatal. After this point (TDGETVEINFO call), NMIs and
+	 * additional #VEs are permitted (but we don't expect them to
+	 * happen unless you panic).
+	 */
+	ret = __tdx_module_call(TDGETVEINFO, 0, 0, 0, 0, &out);
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
+					struct ve_info *ve)
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
index a58800973aed..028622a8ada0 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -61,6 +61,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/vdso.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -1140,6 +1141,74 @@ DEFINE_IDTENTRY(exc_device_not_available)
 	}
 }
 
+#define VEFSTR "VE fault"
+static void ve_raise_fault(struct pt_regs *regs, long error_code)
+{
+	struct task_struct *tsk = current;
+
+	if (user_mode(regs)) {
+		tsk->thread.error_code = error_code;
+		tsk->thread.trap_nr = X86_TRAP_VE;
+
+		/*
+		 * Not fixing up VDSO exceptions similar to #GP handler
+		 * because we don't expect the VDSO to trigger #VE.
+		 */
+		show_signal(tsk, SIGSEGV, "", VEFSTR, regs, error_code);
+		force_sig(SIGSEGV);
+		return;
+	}
+
+	if (fixup_exception(regs, X86_TRAP_VE, error_code, 0))
+		return;
+
+	tsk->thread.error_code = error_code;
+	tsk->thread.trap_nr = X86_TRAP_VE;
+
+	/*
+	 * To be potentially processing a kprobe fault and to trust the result
+	 * from kprobe_running(), we have to be non-preemptible.
+	 */
+	if (!preemptible() &&
+	    kprobe_running() &&
+	    kprobe_fault_handler(regs, X86_TRAP_VE))
+		return;
+
+	notify_die(DIE_GPF, VEFSTR, regs, error_code, X86_TRAP_VE, SIGSEGV);
+
+	die_addr(VEFSTR, regs, error_code, 0);
+}
+
+#ifdef CONFIG_INTEL_TDX_GUEST
+DEFINE_IDTENTRY(exc_virtualization_exception)
+{
+	struct ve_info ve;
+	int ret;
+
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+
+	/*
+	 * NMIs/Machine-checks/Interrupts will be in a disabled state
+	 * till TDGETVEINFO TDCALL is executed. This prevents #VE
+	 * nesting issue.
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
+		ve_raise_fault(regs, 0);
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

