Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF5B42744B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 01:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243946AbhJHXmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 19:42:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:35990 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243911AbhJHXm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 19:42:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="213752079"
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="213752079"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 16:40:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="590706772"
Received: from dmsojoza-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.135.62])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 16:40:28 -0700
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
Subject: [PATCH v9 05/11] x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper functions
Date:   Fri,  8 Oct 2021 16:40:03 -0700
Message-Id: <20211008234009.1211215-6-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008234009.1211215-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211008234009.1211215-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guests communicate with VMMs with hypercalls. Historically, these
are implemented using instructions that are known to cause VMEXITs
like VMCALL, VMLAUNCH, etc. However, with TDX, VMEXITs no longer
expose guest state to the host.  This prevents the old hypercall
mechanisms from working. So to communicate with VMM, TDX
specification defines a new instruction called TDCALL.

In a TDX based VM, since VMM is an untrusted entity, a intermediary
layer (TDX module) exists between host and guest to facilitate
secure communication. TDX guests communicate with the TDX module
using TDCALL instruction. 

Both TDX module and VMM communication uses TDCALL instruction. Value
of the RAX register when executing TDCALL instruction is used to
determine the TDCALL type. If the TDCALL is executed with value "0"
in RAX, then it is the service request to VMM. Any other value in
RAX means it is a TDX module related call.

Implement common helper functions to communicate with the TDX Module
and VMM (using TDCALL instruction).
   
__tdx_hypercall()    - request services from the VMM.
__tdx_module_call()  - communicate with the TDX Module.

Also define two additional wrappers, tdx_hypercall() and
tdx_hypercall_out_r11() to cover common use cases of
__tdx_hypercall() function. Since each use case of
__tdx_module_call() is different, it does not need
multiple wrappers.

Implement __tdx_module_call() and __tdx_hypercall() helper functions
in assembly.

Rationale behind choosing to use assembly over inline assembly is,
since the number of lines of instructions (with comments) in
__tdx_hypercall() implementation is over 70, using inline assembly
to implement it will make it hard to read.
   
Also, just like syscalls, not all TDVMCALL/TDCALLs use cases need to
use the same set of argument registers. The implementation here picks
the current worst-case scenario for TDCALL (4 registers). For TDCALLs
with fewer than 4 arguments, there will end up being a few superfluous
(cheap) instructions.  But, this approach maximizes code reuse. The
same argument applies to __tdx_hypercall() function as well.

For registers used by TDCALL instruction, please check TDX GHCI
specification, sec 2.4 and 3.

https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface.pdf

Originally-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v8:
 * Removed ifdef CONFIG_FRAME_POINTER for ARG7_SP_OFFSET.
 * Removed push/pop for R9 register in__tdx_hypercall().

Changes since v7:
 * None

Changes since v6:
 * None

Changes since v5:
 * Fixed commit log (vmcall -> VMCALL, vmlaunch -> VMLAUNCH).
 * Fixed comments typo in __tdx_hypercall().

Changes since v4:
 * None

Changes since v3:
 * Fixed ARG7_SP_OFFSET value for CONFIG_FRAME_POINTER case.
 * Fixed usage of we/you in comments.

Change since v1:
 * Fixed commit comments format issues as per review comments.
 * Fixed empty line and other typo issues found in review.
 * Removed do_tdx_hypercall() helper function and modified
   __tdx_hypercall() to include do_tdx_hypercall() implementation
   and to accept TDVMCALL type as argument.
 * Since the number of arguments in __tdx_hypercall() is more than
   6, it has been modified  to get the 7th argument from the caller stack.
 * Instead of leaving output pointer in register before making
   TDCALL, stored it in a stack.
 * Instead of triggering ud2 for TDCALL failures in __tdx_hypercall(),
   it is modified to return the TDCALL status as return value. we will let
   user add appropriate error info before triggering fatal error. Also,
   extended struct tdx_hypercall_output to store r10 register which
   contains hypercall error code.
 * Included TDCALL ABI details in __tdx_module_call() and __tdx_hypercall.
 * Removed tdx_hypercall_out_r11() helper function. Since it is not really
   useful.
 * Added _tdx_hypercall() as a wrapper for __tdx_hypercall() with BUG_ON
   check for TDCALL failure.

 arch/x86/include/asm/tdx.h    |  40 +++++
 arch/x86/kernel/Makefile      |   2 +-
 arch/x86/kernel/asm-offsets.c |  23 +++
 arch/x86/kernel/tdcall.S      | 274 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/tdx.c         |  23 +++
 5 files changed, 361 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/tdcall.S

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 3bd8fd92106f..a6aa3de2f7fa 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -4,14 +4,54 @@
 #define _ASM_X86_TDX_H
 
 #include <linux/cpufeature.h>
+#include <linux/types.h>
 
 #define TDX_CPUID_LEAF_ID	0x21
+#define TDX_HYPERCALL_STANDARD  0
+
+/*
+ * Used in __tdx_module_call() helper function to gather the
+ * output registers' values of TDCALL instruction when requesting
+ * services from the TDX module. This is software only structure
+ * and not related to TDX module/VMM.
+ */
+struct tdx_module_output {
+	u64 rcx;
+	u64 rdx;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+};
+
+/*
+ * Used in __tdx_hypercall() helper function to gather the
+ * output registers' values of TDCALL instruction when requesting
+ * services from the VMM. This is software only structure
+ * and not related to TDX module/VMM.
+ */
+struct tdx_hypercall_output {
+	u64 r10;
+	u64 r11;
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+};
 
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 bool is_tdx_guest(void);
 void __init tdx_early_init(void);
 
+/* Helper function used to communicate with the TDX module */
+u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+		      struct tdx_module_output *out);
+
+/* Helper function used to request services from VMM */
+u64 __tdx_hypercall(u64 type, u64 fn, u64 r12, u64 r13, u64 r14,
+		    u64 r15, struct tdx_hypercall_output *out);
+
 #else
 
 bool is_tdx_guest(void) { return false; }
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 8c9a9214dd34..59578a6488ad 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -133,7 +133,7 @@ obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
 obj-$(CONFIG_X86_PMEM_LEGACY_DEVICE) += pmem.o
 
 obj-$(CONFIG_JAILHOUSE_GUEST)	+= jailhouse.o
-obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx.o
+obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdcall.o tdx.o
 
 obj-$(CONFIG_EISA)		+= eisa.o
 obj-$(CONFIG_PCSPKR_PLATFORM)	+= pcspeaker.o
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index ecd3fd6993d1..0494ec01218d 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -23,6 +23,10 @@
 #include <xen/interface/xen.h>
 #endif
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+#include <asm/tdx.h>
+#endif
+
 #ifdef CONFIG_X86_32
 # include "asm-offsets_32.c"
 #else
@@ -68,6 +72,25 @@ static void __used common(void)
 	OFFSET(XEN_vcpu_info_arch_cr2, vcpu_info, arch.cr2);
 #endif
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+	BLANK();
+	/* Offset for fields in tdx_module_output */
+	OFFSET(TDX_MODULE_rcx, tdx_module_output, rcx);
+	OFFSET(TDX_MODULE_rdx, tdx_module_output, rdx);
+	OFFSET(TDX_MODULE_r8,  tdx_module_output, r8);
+	OFFSET(TDX_MODULE_r9,  tdx_module_output, r9);
+	OFFSET(TDX_MODULE_r10, tdx_module_output, r10);
+	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
+
+	/* Offset for fields in tdx_hypercall_output */
+	OFFSET(TDX_HYPERCALL_r10, tdx_hypercall_output, r10);
+	OFFSET(TDX_HYPERCALL_r11, tdx_hypercall_output, r11);
+	OFFSET(TDX_HYPERCALL_r12, tdx_hypercall_output, r12);
+	OFFSET(TDX_HYPERCALL_r13, tdx_hypercall_output, r13);
+	OFFSET(TDX_HYPERCALL_r14, tdx_hypercall_output, r14);
+	OFFSET(TDX_HYPERCALL_r15, tdx_hypercall_output, r15);
+#endif
+
 	BLANK();
 	OFFSET(BP_scratch, boot_params, scratch);
 	OFFSET(BP_secure_boot, boot_params, secure_boot);
diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
new file mode 100644
index 000000000000..c7a5b8d79552
--- /dev/null
+++ b/arch/x86/kernel/tdcall.S
@@ -0,0 +1,274 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/asm-offsets.h>
+#include <asm/asm.h>
+#include <asm/frame.h>
+#include <asm/unwind_hints.h>
+
+#include <linux/linkage.h>
+#include <linux/bits.h>
+#include <linux/errno.h>
+
+#define TDG_R10		BIT(10)
+#define TDG_R11		BIT(11)
+#define TDG_R12		BIT(12)
+#define TDG_R13		BIT(13)
+#define TDG_R14		BIT(14)
+#define TDG_R15		BIT(15)
+
+/* Frame offset + 8 (for arg1) */
+#define ARG7_SP_OFFSET		(FRAME_OFFSET + 0x08)
+
+/*
+ * Expose registers R10-R15 to VMM. It is passed via RCX register
+ * to the TDX Module, which will be used by the TDX module to
+ * identify the list of registers exposed to VMM. Each bit in this
+ * mask represents a register ID. Bit field details can be found
+ * in TDX GHCI specification.
+ */
+#define TDVMCALL_EXPOSE_REGS_MASK	( TDG_R10 | TDG_R11 | \
+					  TDG_R12 | TDG_R13 | \
+					  TDG_R14 | TDG_R15 )
+
+/*
+ * TDX guests use the TDCALL instruction to make requests to the
+ * TDX module and hypercalls to the VMM. It is supported in
+ * Binutils >= 2.36.
+ */
+#define tdcall .byte 0x66,0x0f,0x01,0xcc
+
+/*
+ * __tdx_module_call()  - Helper function used by TDX guests to request
+ * services from the TDX module (does not include VMM services).
+ *
+ * This function serves as a wrapper to move user call arguments to the
+ * correct registers as specified by TDCALL ABI and share it with the
+ * TDX module. If the TDCALL operation is successful and a valid
+ * "struct tdx_module_output" pointer is available (in "out" argument),
+ * output from the TDX module is saved to the memory specified in the
+ * "out" pointer. Also the status of the TDCALL operation is returned
+ * back to the user as a function return value.
+ *
+ *-------------------------------------------------------------------------
+ * TDCALL ABI:
+ *-------------------------------------------------------------------------
+ * Input Registers:
+ *
+ * RAX                 - TDCALL Leaf number.
+ * RCX,RDX,R8-R9       - TDCALL Leaf specific input registers.
+ *
+ * Output Registers:
+ *
+ * RAX                 - TDCALL instruction error code.
+ * RCX,RDX,R8-R11      - TDCALL Leaf specific output registers.
+ *
+ *-------------------------------------------------------------------------
+ *
+ * __tdx_module_call() function ABI:
+ *
+ * @fn  (RDI)          - TDCALL Leaf ID,    moved to RAX
+ * @rcx (RSI)          - Input parameter 1, moved to RCX
+ * @rdx (RDX)          - Input parameter 2, moved to RDX
+ * @r8  (RCX)          - Input parameter 3, moved to R8
+ * @r9  (R8)           - Input parameter 4, moved to R9
+ *
+ * @out (R9)           - struct tdx_module_output pointer
+ *                       stored temporarily in R12 (not
+ *                       shared with the TDX module). It
+ *                       can be NULL.
+ *
+ * Return status of TDCALL via RAX.
+ */
+SYM_FUNC_START(__tdx_module_call)
+	FRAME_BEGIN
+
+	/*
+	 * R12 will be used as temporary storage for
+	 * struct tdx_module_output pointer. More
+	 * details about struct tdx_module_output can
+	 * be found in arch/x86/include/asm/tdx.h. Also
+	 * note that registers R12-R15 are not used by
+	 * TDCALL services supported by this helper
+	 * function.
+	 */
+
+	/* Callee saved, so preserve it */
+	push %r12
+
+	/*
+	 * Push output pointer to stack, after TDCALL operation,
+	 * it will be fetched into R12 register.
+	 */
+	push %r9
+
+	/* Mangle function call ABI into TDCALL ABI: */
+	/* Move TDCALL Leaf ID to RAX */
+	mov %rdi, %rax
+	/* Move input 4 to R9 */
+	mov %r8,  %r9
+	/* Move input 3 to R8 */
+	mov %rcx, %r8
+	/* Move input 1 to RCX */
+	mov %rsi, %rcx
+	/* Leave input param 2 in RDX */
+
+	tdcall
+
+	/* Fetch output pointer from stack to R12 */
+	pop %r12
+
+	/* Check for TDCALL success: 0 - Successful, otherwise failed */
+	test %rax, %rax
+	jnz 1f
+
+	/*
+	 * __tdx_module_call() can be initiated without an output pointer.
+	 * So, check if caller provided an output struct before storing
+	 * output registers.
+	 */
+	test %r12, %r12
+	jz 1f
+
+	/* Copy TDCALL result registers to output struct: */
+	movq %rcx, TDX_MODULE_rcx(%r12)
+	movq %rdx, TDX_MODULE_rdx(%r12)
+	movq %r8,  TDX_MODULE_r8(%r12)
+	movq %r9,  TDX_MODULE_r9(%r12)
+	movq %r10, TDX_MODULE_r10(%r12)
+	movq %r11, TDX_MODULE_r11(%r12)
+1:
+	/* Restore the state of R12 register */
+	pop %r12
+
+	FRAME_END
+	ret
+SYM_FUNC_END(__tdx_module_call)
+
+/*
+ * __tdx_hypercall()  - Helper function used by TDX guests to request
+ * services from the VMM. All requests are made via the TDX module
+ * using TDCALL instruction.
+ *
+ * This function serves as a wrapper to move user call arguments to the
+ * correct registers as specified by TDCALL ABI and share it with VMM
+ * via the TDX module. After TDCALL operation, output from the VMM is
+ * saved to the memory specified in the "out" (struct tdx_hypercall_output)
+ * pointer. 
+ *
+ *-------------------------------------------------------------------------
+ * TD VMCALL ABI:
+ *-------------------------------------------------------------------------
+ *
+ * Input Registers:
+ *
+ * RAX                 - TDCALL instruction leaf number (0 - TDG.VP.VMCALL)
+ * RCX                 - BITMAP which controls which part of TD Guest GPR
+ *                       is passed as-is to VMM and back.
+ * R10                 - Set 0 to indicate TDCALL follows standard TDX ABI
+ *                       specification. Non zero value indicates vendor
+ *                       specific ABI.
+ * R11                 - VMCALL sub function number
+ * RBX, RBP, RDI, RSI  - Used to pass VMCALL sub function specific arguments.
+ * R8-R9, R12–R15      - Same as above.
+ *
+ * Output Registers:
+ *
+ * RAX                 - TDCALL instruction status (Not related to hypercall
+ *                        output).
+ * R10                 - Hypercall output error code.
+ * R11-R15             - Hypercall sub function specific output values.
+ *
+ *-------------------------------------------------------------------------
+ *
+ * __tdx_hypercall() function ABI:
+ *
+ * @type  (RDI)        - TD VMCALL type, moved to R10
+ * @fn    (RSI)        - TD VMCALL sub function, moved to R11
+ * @r12   (RDX)        - Input parameter 1, moved to R12
+ * @r13   (RCX)        - Input parameter 2, moved to R13
+ * @r14   (R8)         - Input parameter 3, moved to R14
+ * @r15   (R9)         - Input parameter 4, moved to R15
+ *
+ * @out   (stack)      - struct tdx_hypercall_output pointer (cannot be NULL)
+ *
+ * On successful completion, return TDCALL status or -EINVAL for invalid
+ * inputs.
+ */
+SYM_FUNC_START(__tdx_hypercall)
+	FRAME_BEGIN
+
+	/* Move argument 7 from caller stack to RAX */
+	movq ARG7_SP_OFFSET(%rsp), %rax
+
+	/* Check if caller provided an output struct */
+	test %rax, %rax
+	/* If out pointer is NULL, return -EINVAL */
+	jz 1f
+
+	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
+	push %r15
+	push %r14
+	push %r13
+	push %r12
+
+	/*
+	 * Save output pointer (rax) in stack, it will be used
+	 * again when storing the output registers after TDCALL
+	 * operation.
+	 */
+	push %rax
+
+	/* Mangle function call ABI into TDCALL ABI: */
+	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
+	xor %eax, %eax
+	/* Move TDVMCALL type (standard vs vendor) in R10 */
+	mov %rdi, %r10
+	/* Move TDVMCALL sub function id to R11 */
+	mov %rsi, %r11
+	/* Move input 1 to R12 */
+	mov %rdx, %r12
+	/* Move input 2 to R13 */
+	mov %rcx, %r13
+	/* Move input 3 to R14 */
+	mov %r8,  %r14
+	/* Move input 4 to R15 */
+	mov %r9,  %r15
+
+	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
+
+	tdcall
+
+	/* Restore output pointer to R9 */
+	pop  %r9
+
+	/* Copy hypercall result registers to output struct: */
+	movq %r10, TDX_HYPERCALL_r10(%r9)
+	movq %r11, TDX_HYPERCALL_r11(%r9)
+	movq %r12, TDX_HYPERCALL_r12(%r9)
+	movq %r13, TDX_HYPERCALL_r13(%r9)
+	movq %r14, TDX_HYPERCALL_r14(%r9)
+	movq %r15, TDX_HYPERCALL_r15(%r9)
+
+	/*
+	 * Zero out registers exposed to the VMM to avoid
+	 * speculative execution with VMM-controlled values.
+	 * This needs to include all registers present in
+	 * TDVMCALL_EXPOSE_REGS_MASK (except R12-R15).
+	 * R12-R15 context will be restored.
+	 */
+	xor %r10d, %r10d
+	xor %r11d, %r11d
+
+	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
+	pop %r12
+	pop %r13
+	pop %r14
+	pop %r15
+
+	jmp 2f
+1:
+       movq $(-EINVAL), %rax
+2:
+       FRAME_END
+
+       retq
+SYM_FUNC_END(__tdx_hypercall)
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 88bf12788684..3246ffb3606b 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -27,6 +27,29 @@ bool is_tdx_guest(void)
 	return !!tdx_guest;
 }
 
+/*
+ * Wrapper for standard use of __tdx_hypercall with BUG_ON() check
+ * for TDCALL error.
+ */
+static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
+				 u64 r15, struct tdx_hypercall_output *out)
+{
+	struct tdx_hypercall_output outl;
+	u64 err;
+
+	/* __tdx_hypercall() does not accept NULL output pointer */
+	if (!out)
+		out = &outl;
+
+	err = __tdx_hypercall(TDX_HYPERCALL_STANDARD, fn, r12, r13, r14,
+			      r15, out);
+
+	/* Non zero return value indicates buggy TDX module, so panic */
+	BUG_ON(err);
+
+	return out->r10;
+}
+
 void __init tdx_early_init(void)
 {
 	if (!is_tdx_guest())
-- 
2.25.1

