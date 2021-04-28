Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84E836DE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbhD1Rn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:43:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:55342 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243285AbhD1Rny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:43:54 -0400
IronPort-SDR: 857BkgmWlCqlDlBh9pG1S1+mG7Awu4ATr56OMI07cplwCj8tjUacr/gpXciZIzXimWgt0AUNdB
 UPR5Qerl7qGw==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="258104418"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="258104418"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 10:43:08 -0700
IronPort-SDR: VPOJEQXonGZF4/WbmuNR78T48IhF/MLd6LCYw05kyHjHtJy5q9tOxtayQLGTP5f/GX0Uxsfnbd
 yXwRfL+qn7fg==
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="430415234"
Received: from turnerrx-desk.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.37.37])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 10:43:06 -0700
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
Subject: [PATCH v1 1/1] x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper functions
Date:   Wed, 28 Apr 2021 10:42:46 -0700
Message-Id: <20210428174246.291680-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3a7c0bba-cc43-e4ba-f7fe-43c8627c2fc2@intel.com>
References: <3a7c0bba-cc43-e4ba-f7fe-43c8627c2fc2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guests communicate with VMMs with hypercalls. Historically, these
are implemented using instructions that are known to cause VMEXITs
like vmcall, vmlaunch, etc. However, with TDX, VMEXITs no longer
expose guest state to the host.  This prevents the old hypercall
mechanisms from working. So to communicate with VMM, TDX
specification defines a new instruction called "tdcall".

In TDX based VM, since VMM is an untrusted entity, a intermediary
layer (TDX module) exists between host and guest to facilitate the
secure communication. And "tdcall" instruction  is used by the guest
to request services from TDX module. And a variant of "tdcall"
instruction (with specific arguments as defined by GHCI) is used by
the guest to request services from  VMM via the TDX module.

Implement common helper functions to communicate with the TDX Module
and VMM (using TDCALL instruction).
   
__tdx_hypercall()    - function can be used to request services from
		       the VMM.
__tdx_module_call()  - function can be used to communicate with the
		       TDX Module.

Also define two additional wrappers, tdx_hypercall() and
tdx_hypercall_out_r11() to cover common use cases of
__tdx_hypercall() function. Since each use case of
__tdx_module_call() is different, we don't need such wrappers for it.

Implement __tdx_module_call() and __tdx_hypercall() helper functions
in assembly.

Rationale behind choosing to use assembly over inline assembly are,

1. Since the number of lines of instructions (with comments) in
__tdx_hypercall() implementation is over 70, using inline assembly
to implement it will make it hard to read.
   
2. Also, since many registers (R8-R15, R[A-D]X)) will be used in
TDCALL operation, if all these registers are included in in-line
assembly constraints, some of the older compilers may not
be able to meet this requirement.

Also, just like syscalls, not all TDVMCALL/TDCALLs use cases need to
use the same set of argument registers. The implementation here picks
the current worst-case scenario for TDCALL (4 registers). For TDCALLs
with fewer than 4 arguments, there will end up being a few superfluous
(cheap) instructions.  But, this approach maximizes code reuse. The
same argument applies to __tdx_hypercall() function as well.

Current implementation of __tdx_hypercall() includes error handling
(ud2 on failure case) in assembly function instead of doing it in C
wrapper function. The reason behind this choice is, when adding support
for in/out instructions (refer to patch titled "x86/tdx: Handle port
I/O" in this series), we use alternative_io() to substitute in/out
instruction with  __tdx_hypercall() calls. So use of C wrappers is not
trivial in this case because the input parameters will be in the wrong
registers and it's tricky to include proper buffer code to make this
happen.

For registers used by TDCALL instruction, please check TDX GHCI
specification, sec 2.4 and 3.

https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface.pdf

Originally-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Hi Dave,

It includes all fixes suggested by you. Please let me know your
comments.

Changes since v1:
 * Renamed __tdcall()/__tdvmcall() to
   __tdx_module_call()/__tdx_hypercall().
 * Used BIT() to derive TDVMCALL_EXPOSE_REGS_MASK.
 * Removed unnecessary code in __tdcall() function.
 * Fixed comments as per Dave's review.

 arch/x86/include/asm/tdx.h    |  26 ++++
 arch/x86/kernel/Makefile      |   2 +-
 arch/x86/kernel/asm-offsets.c |  22 ++++
 arch/x86/kernel/tdcall.S      | 215 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/tdx.c         |  39 ++++++
 5 files changed, 303 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/tdcall.S

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 69af72d08d3d..95a6a6c6061a 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -8,12 +8,38 @@
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 #include <asm/cpufeature.h>
+#include <linux/types.h>
+
+struct tdx_module_output {
+	u64 rcx;
+	u64 rdx;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+};
+
+struct tdx_hypercall_output {
+	u64 r11;
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+};
 
 /* Common API to check TDX support in decompression and common kernel code. */
 bool is_tdx_guest(void);
 
 void __init tdx_early_init(void);
 
+/* Helper function used to communicate with the TDX module */
+u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+		      struct tdx_module_output *out);
+
+/* Helper function used to request services from VMM */
+u64 __tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
+		    struct tdx_hypercall_output *out);
+
 #else // !CONFIG_INTEL_TDX_GUEST
 
 static inline bool is_tdx_guest(void)
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index ea111bf50691..7966c10ea8d1 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -127,7 +127,7 @@ obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
 obj-$(CONFIG_X86_PMEM_LEGACY_DEVICE) += pmem.o
 
 obj-$(CONFIG_JAILHOUSE_GUEST)	+= jailhouse.o
-obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx.o
+obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdcall.o tdx.o
 
 obj-$(CONFIG_EISA)		+= eisa.o
 obj-$(CONFIG_PCSPKR_PLATFORM)	+= pcspeaker.o
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 60b9f42ce3c1..e6b3bb983992 100644
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
@@ -75,6 +79,24 @@ static void __used common(void)
 	OFFSET(XEN_vcpu_info_arch_cr2, vcpu_info, arch.cr2);
 #endif
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+	BLANK();
+	/* Offset for fields in tdcall_output */
+	OFFSET(TDX_MODULE_rcx, tdx_module_output, rcx);
+	OFFSET(TDX_MODULE_rdx, tdx_module_output, rdx);
+	OFFSET(TDX_MODULE_r8,  tdx_module_output, r8);
+	OFFSET(TDX_MODULE_r9,  tdx_module_output, r9);
+	OFFSET(TDX_MODULE_r10, tdx_module_output, r10);
+	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
+
+	/* Offset for fields in tdvmcall_output */
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
index 000000000000..7e14b4a2312e
--- /dev/null
+++ b/arch/x86/kernel/tdcall.S
@@ -0,0 +1,215 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/asm-offsets.h>
+#include <asm/asm.h>
+#include <asm/frame.h>
+#include <asm/unwind_hints.h>
+
+#include <linux/linkage.h>
+#include <linux/bits.h>
+
+#define TDG_R10		BIT(10)
+#define TDG_R11		BIT(11)
+#define TDG_R12		BIT(12)
+#define TDG_R13		BIT(13)
+#define TDG_R14		BIT(14)
+#define TDG_R15		BIT(15)
+
+/*
+ * Expose registers R10-R15 to VMM. It is passed via RCX register
+ * to the TDX Module, which will be used by the TDX module to
+ * identify the list of registers exposed to VMM. Each bit in this
+ * mask represents a register ID. You can find the bit field details
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
+ * correct registers as specified by "tdcall" ABI and shares it with the
+ * TDX module.  And if the "tdcall" operation is successful and a valid
+ * "struct tdx_module_output" pointer is available (in "out" argument),
+ * output from the TDX module is saved to the memory specified in the
+ * "out" pointer. Also the status of the "tdcall" operation is returned
+ * back to the user as a function return value.
+ *
+ * @fn  (RDI)		- TDCALL Leaf ID,    moved to RAX
+ * @rcx (RSI)		- Input parameter 1, moved to RCX
+ * @rdx (RDX)		- Input parameter 2, moved to RDX
+ * @r8  (RCX)		- Input parameter 3, moved to R8
+ * @r9  (R8)		- Input parameter 4, moved to R9
+ *
+ * @out (R9)		- struct tdx_module_output pointer
+ *			  stored temporarily in R12 (not
+ * 			  shared with the TDX module)
+ *
+ * Return status of tdcall via RAX.
+ *
+ * NOTE: This function should not be used for TDX hypercall
+ *       use cases.
+ */
+SYM_FUNC_START(__tdx_module_call)
+	FRAME_BEGIN
+
+	/*
+	 * R12 will be used as temporary storage for
+	 * struct tdx_module_output pointer. You can
+	 * find struct tdx_module_output details in
+	 * arch/x86/include/asm/tdx.h. Also note that
+	 * registers R12-R15 are not used by TDCALL
+	 * services supported by this helper function.
+	 */
+	push %r12	/* Callee saved, so preserve it */
+	mov %r9,  %r12 	/* Move output pointer to R12 */
+
+	/* Mangle function call ABI into TDCALL ABI: */
+	mov %rdi, %rax	/* Move TDCALL Leaf ID to RAX */
+	mov %r8,  %r9	/* Move input 4 to R9 */
+	mov %rcx, %r8	/* Move input 3 to R8 */
+	mov %rsi, %rcx	/* Move input 1 to RCX */
+	/* Leave input param 2 in RDX */
+
+	tdcall
+
+	/* Check for TDCALL success: 0 - Successful, otherwise failed */
+	test %rax, %rax
+	jnz 1f
+
+	/* Check for TDCALL output struct != NULL */
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
+	pop %r12 /* Restore the state of R12 register */
+
+	FRAME_END
+	ret
+SYM_FUNC_END(__tdx_module_call)
+
+/*
+ * do_tdx_hypercall()  - Helper function used by TDX guests to request
+ * services from the VMM. All requests are made via the TDX module
+ * using "TDCALL" instruction.
+ *
+ * This function is created to contain common between vendor specific
+ * and standard type tdx hypercalls. So the caller of this function had
+ * to set the TDVMCALL type in the R10 register before calling it.
+ *
+ * This function serves as a wrapper to move user call arguments to the
+ * correct registers as specified by "tdcall" ABI and shares it with VMM
+ * via the TDX module. And if the "tdcall" operation is successful and a
+ * valid "struct tdx_hypercall_output" pointer is available (in "out"
+ * argument), output from the VMM is saved to the memory specified in the
+ * "out" pointer. 
+ *
+ * @fn  (RDI)		- TDVMCALL function, moved to R11
+ * @r12 (RSI)		- Input parameter 1, moved to R12
+ * @r13 (RDX)		- Input parameter 2, moved to R13
+ * @r14 (RCX)		- Input parameter 3, moved to R14
+ * @r15 (R8)		- Input parameter 4, moved to R15
+ *
+ * @out (R9)		- struct tdx_hypercall_output pointer
+ *
+ * On successful completion, return TDX hypercall error code.
+ * If the "tdcall" operation fails, panic.
+ *
+ */
+SYM_CODE_START_LOCAL(do_tdx_hypercall)
+	FRAME_BEGIN
+
+	/* Save non-volatile GPRs that are exposed to the VMM. */
+	push %r15
+	push %r14
+	push %r13
+	push %r12
+
+	/* Leave hypercall output pointer in R9, it's not clobbered by VMM */
+
+	/* Mangle function call ABI into TDCALL ABI: */
+	xor %eax, %eax /* Move TDCALL leaf ID (TDVMCALL (0)) to RAX */
+	mov %rdi, %r11 /* Move TDVMCALL function id to R11 */
+	mov %rsi, %r12 /* Move input 1 to R12 */
+	mov %rdx, %r13 /* Move input 2 to R13 */
+	mov %rcx, %r14 /* Move input 1 to R14 */
+	mov %r8,  %r15 /* Move input 1 to R15 */
+	/* Caller of do_tdx_hypercall() will set TDVMCALL type in R10 */
+
+	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
+
+	tdcall
+
+	/*
+	 * Check for TDCALL success: 0 - Successful, otherwise failed.
+	 * If failed, there is an issue with TDX Module which is fatal
+	 * for the guest. So panic. Also note that RAX is controlled
+	 * only by the TDX module and not exposed to VMM.
+	 */
+	test %rax, %rax
+	jnz 2f
+
+	/* Move hypercall error code to RAX to return to user */
+	mov %r10, %rax
+
+	/* Check for hypercall success: 0 - Successful, otherwise failed */
+	test %rax, %rax
+	jnz 1f
+
+	/* Check for hypercall output struct != NULL */
+	test %r9, %r9
+	jz 1f
+
+	/* Copy hypercall result registers to output struct: */
+	movq %r11, TDX_HYPERCALL_r11(%r9)
+	movq %r12, TDX_HYPERCALL_r12(%r9)
+	movq %r13, TDX_HYPERCALL_r13(%r9)
+	movq %r14, TDX_HYPERCALL_r14(%r9)
+	movq %r15, TDX_HYPERCALL_r15(%r9)
+1:
+	/*
+	 * Zero out registers exposed to the VMM to avoid
+	 * speculative execution with VMM-controlled values.
+	 */
+	xor %r10d, %r10d
+	xor %r11d, %r11d
+	xor %r12d, %r12d
+	xor %r13d, %r13d
+	xor %r14d, %r14d
+	xor %r15d, %r15d
+
+	/* Restore non-volatile GPRs that are exposed to the VMM. */
+	pop %r12
+	pop %r13
+	pop %r14
+	pop %r15
+
+	FRAME_END
+	ret
+2:
+	ud2
+SYM_CODE_END(do_tdx_hypercall)
+
+/* Helper function for standard type of TDVMCALL */
+SYM_FUNC_START(__tdx_hypercall)
+	/* Set TDVMCALL type info (0 - Standard, > 0 - vendor) in R10 */
+	xor %r10, %r10
+	call do_tdx_hypercall
+	retq
+SYM_FUNC_END(__tdx_hypercall)
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 6a7193fead08..cbfefc42641e 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -1,8 +1,47 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2020 Intel Corporation */
 
+#define pr_fmt(fmt) "TDX: " fmt
+
 #include <asm/tdx.h>
 
+/*
+ * Wrapper for simple hypercalls that only return a success/error code.
+ */
+static inline u64 tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
+{
+	u64 err;
+
+	err = __tdx_hypercall(fn, r12, r13, r14, r15, NULL);
+
+	if (err)
+		pr_warn_ratelimited("TDVMCALL fn:%llx failed with err:%llx\n",
+				    fn, err);
+
+	return err;
+}
+
+/*
+ * Wrapper for the semi-common case where we need single output
+ * value (R11). Callers of this function does not care about the
+ * hypercall error code (mainly for IN or MMIO usecase).
+ */
+static inline u64 tdx_hypercall_out_r11(u64 fn, u64 r12, u64 r13,
+					u64 r14, u64 r15)
+{
+
+	struct tdx_hypercall_output out = {0};
+	u64 err;
+
+	err = __tdx_hypercall(fn, r12, r13, r14, r15, &out);
+
+	if (err)
+		pr_warn_ratelimited("TDVMCALL fn:%llx failed with err:%llx\n",
+				    fn, err);
+
+	return out.r11;
+}
+
 static inline bool cpuid_has_tdx_guest(void)
 {
 	u32 eax, signature[3];
-- 
2.25.1

