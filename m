Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A1A421CB4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 04:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhJECy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 22:54:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:43315 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231461AbhJECyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 22:54:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="248894644"
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="248894644"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 19:52:29 -0700
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="483409115"
Received: from asaini1-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.96])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 19:52:28 -0700
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
Subject: [PATCH v8 06/11] x86/traps: Add #VE support for TDX guest
Date:   Mon,  4 Oct 2021 19:52:00 -0700
Message-Id: <20211005025205.1784480-7-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
it is expected panic_on_oops is set to 1 for TDX guests).

Add basic infrastructure to handle any #VE which occurs in the kernel or
userspace.  Later patches will add handling for specific #VE scenarios.

Convert unhandled #VE's (everything, until later in this series) so that
they appear just like a #GP by calling ve_raise_fault() directly.
ve_raise_fault() is similar to #GP handler and is responsible for
sending SIGSEGV to userspace and CPU die and notifying debuggers and
other die chain users.  

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v7:
 * None

Changes since v6:
 * None

Changes since v5:
 * Fixed "We" usage in commit log and replaced cpu -> CPU.
 * Renamed "tdg_" prefix with "tdx_".
 * Removed TODO comment in tdg_handle_virtualization_exception() as
   per Boris review comments.
 * Added comments for ve_raise_fault().

Changes since v4:
 * Since ve_raise_fault() is used only by TDX code, moved it
   within #ifdef CONFIG_INTEL_TDX_GUEST.

Changes since v3:
 * None

 arch/x86/include/asm/idtentry.h |  4 ++
 arch/x86/include/asm/tdx.h      | 19 ++++++++
 arch/x86/kernel/idt.c           |  6 +++
 arch/x86/kernel/tdx.c           | 33 ++++++++++++++
 arch/x86/kernel/traps.c         | 77 +++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+)

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
index 8d83a719b90b..458a564dd4c2 100644
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
 
 extern u64 is_tdx_guest;
@@ -52,6 +66,11 @@ u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 u64 __tdx_hypercall(u64 type, u64 fn, u64 r12, u64 r13, u64 r14,
 		    u64 r15, struct tdx_hypercall_output *out);
 
+unsigned long tdx_get_ve_info(struct ve_info *ve);
+
+int tdx_handle_virtualization_exception(struct pt_regs *regs,
+					struct ve_info *ve);
+
 #else
 
 #define is_tdx_guest		0ULL
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
index d5fc2904facf..f7885c777a09 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -6,6 +6,9 @@
 
 #include <asm/tdx.h>
 
+/* TDX Module call Leaf IDs */
+#define TDGETVEINFO			3
+
 /*
  * Allocate it in the data region to avoid zeroing it during
  * BSS initialization. It is mainly used in cc_platform_has()
@@ -50,6 +53,36 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
 	return out->r10;
 }
 
+unsigned long tdx_get_ve_info(struct ve_info *ve)
+{
+	struct tdx_module_output out = {0};
+	u64 ret;
+
+	/*
+	 * NMIs and machine checks are suppressed. Before this point any
+	 * #VE is fatal. After this point (TDGETVEINFO call), NMIs and
+	 * additional #VEs are permitted (but it is expected not to
+	 * happen unless kernel panics).
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
+int tdx_handle_virtualization_exception(struct pt_regs *regs,
+					struct ve_info *ve)
+{
+	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
+	return -EFAULT;
+}
+
 void __init tdx_early_init(void)
 {
 	is_tdx_guest_init();
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a58800973aed..152d1d3b9dc8 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -61,6 +61,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/vdso.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -1140,6 +1141,82 @@ DEFINE_IDTENTRY(exc_device_not_available)
 	}
 }
 
+#ifdef CONFIG_INTEL_TDX_GUEST
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
+		 * because it is expected that VDSO doesn't trigger #VE.
+		 */
+		show_signal(tsk, SIGSEGV, "", VEFSTR, regs, error_code);
+		force_sig(SIGSEGV);
+		return;
+	}
+
+	/*
+	 * Attempt to recover from #VE exception failure without
+	 * triggering OOPS (useful for MSR read/write failures)
+	 */
+	if (fixup_exception(regs, X86_TRAP_VE, error_code, 0))
+		return;
+
+	tsk->thread.error_code = error_code;
+	tsk->thread.trap_nr = X86_TRAP_VE;
+
+	/*
+	 * To be potentially processing a kprobe fault and to trust the result
+	 * from kprobe_running(), it should be non-preemptible.
+	 */
+	if (!preemptible() &&
+	    kprobe_running() &&
+	    kprobe_fault_handler(regs, X86_TRAP_VE))
+		return;
+
+	/* Notify about #VE handling failure, useful for debugger hooks */
+	if (notify_die(DIE_GPF, VEFSTR, regs, error_code,
+		       X86_TRAP_VE, SIGSEGV) == NOTIFY_STOP)
+		return;
+
+	/* Trigger OOPS and panic */
+	die_addr(VEFSTR, regs, error_code, 0);
+}
+
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
+	ret = tdx_get_ve_info(&ve);
+
+	cond_local_irq_enable(regs);
+
+	if (!ret)
+		ret = tdx_handle_virtualization_exception(regs, &ve);
+	/*
+	 * If tdx_handle_virtualization_exception() could not process
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

