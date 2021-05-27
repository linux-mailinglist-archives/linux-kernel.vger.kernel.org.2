Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF693923CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 02:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhE0AcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 20:32:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:19769 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234174AbhE0AcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 20:32:19 -0400
IronPort-SDR: bYDfKbdVPlytVnbttyNqyvYVAHIARdfHKNlrNBy9ffWAESWhBd9fTmYmZUPE5VZl0CheYHoBd4
 bp5SVtde6FHQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202378496"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="202378496"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 17:30:43 -0700
IronPort-SDR: k2YTcVOziir0LExXF+Hp78KzyHVmxPhZhezgnwDpgaOOkYgLPMS/qcrmu+Pkj+soGyYxtC5g+h
 RxiyLzRyeo1Q==
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="414679411"
Received: from skgangad-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.33.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 17:30:41 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2-fix-v2 1/1] x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper functions
Date:   Wed, 26 May 2021 17:30:33 -0700
Message-Id: <20210527003033.3632700-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <77545da6-d534-e4c2-a60b-085705e3f0b7@linux.intel.com>
References: <77545da6-d534-e4c2-a60b-085705e3f0b7@linux.intel.com>
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

In a TDX based VM, since VMM is an untrusted entity, a intermediary
layer (TDX module) exists between host and guest to facilitate the
secure communication. TDX guests communicate with the TDX module and
with the VMM using a new instruction: TDCALL.

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
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since RFC v2-fix-v1:
 * No code changes (Adding Tony to "To" list)

Changes since RFC v2: 
 * Renamed __tdcall()/__tdvmcall() to __tdx_module_call()/__tdx_hypercall().
 * Renamed reg offsets from TDCALL_rx to TDX_MODULE_rx.
 * Renamed reg offsets from TDVMCALL_rx to TDX_HYPERCALL_rx.
 * Renamed struct tdcall_output to struct tdx_module_output.
 * Renamed struct tdvmcall_output to struct tdx_hypercall_output.
 * Used BIT() to derive TDVMCALL_EXPOSE_REGS_MASK.
 * Removed unnecessary push/pop sequence in __tdcall() function.
 * Fixed comments as per Dave's review.

 arch/x86/include/asm/tdx.h    |  38 ++++++
 arch/x86/kernel/Makefile      |   2 +-
 arch/x86/kernel/asm-offsets.c |  22 ++++
 arch/x86/kernel/tdcall.S      | 223 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/tdx.c         |  38 ++++++
 5 files changed, 322 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/tdcall.S

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 69af72d08d3d..fcd42119a287 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -8,12 +8,50 @@
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 #include <asm/cpufeature.h>
+#include <linux/types.h>
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
index 60b9f42ce3c1..70cafbae4fea 100644
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
+	/* Offset for fields in tdx_module_output */
+	OFFSET(TDX_MODULE_rcx, tdx_module_output, rcx);
+	OFFSET(TDX_MODULE_rdx, tdx_module_output, rdx);
+	OFFSET(TDX_MODULE_r8,  tdx_module_output, r8);
+	OFFSET(TDX_MODULE_r9,  tdx_module_output, r9);
+	OFFSET(TDX_MODULE_r10, tdx_module_output, r10);
+	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
+
+	/* Offset for fields in tdx_hypercall_output */
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
index 000000000000..b06e8b62dfe2
--- /dev/null
+++ b/arch/x86/kernel/tdcall.S
@@ -0,0 +1,223 @@
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
+ * TDX module. If the "tdcall" operation is successful and a valid
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
+	/* Check if caller provided an output struct */
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
+ * This function is created to contain common code between vendor
+ * specific and standard type TDX hypercalls. So the caller of this
+ * function had to set the TDVMCALL type in the R10 register before
+ * calling it.
+ *
+ * This function serves as a wrapper to move user call arguments to the
+ * correct registers as specified by "tdcall" ABI and shares it with VMM
+ * via the TDX module. If the "tdcall" operation is successful and a
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
+ *
+ */
+SYM_FUNC_START_LOCAL(do_tdx_hypercall)
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
+	 * Non-zero RAX values indicate a failure of TDCALL itself.
+	 * Panic for those.  This value is unrelated to the hypercall
+	 * result in R10.
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
+	/* Check if caller provided an output struct */
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
+	 * This needs to include all registers present in
+	 * TDVMCALL_EXPOSE_REGS_MASK.
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
+	ret
+2:
+	ud2
+SYM_FUNC_END(do_tdx_hypercall)
+
+/*
+ * Helper function for standard type of TDVMCALLs. This assembly
+ * wrapper reuses do_tdvmcall() for standard type of hypercalls
+ * (R10 is set as zero).
+ */
+SYM_FUNC_START(__tdx_hypercall)
+	FRAME_BEGIN
+	/*
+	 * R10 is not part of the function call ABI, but it is a part
+	 * of the TDVMCALL ABI. So set it 0 for standard type TDVMCALL
+	 * before making call to the do_tdx_hypercall().
+	 */
+	xor %r10, %r10
+	call do_tdx_hypercall
+	FRAME_END
+	retq
+SYM_FUNC_END(__tdx_hypercall)
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 5e70617e9877..97b54317f799 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -1,8 +1,46 @@
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
+ * Wrapper for the semi-common case where user need single output
+ * value (R11). Callers of this function does not care about the
+ * hypercall error code (mainly for IN or MMIO usecase).
+ */
+static inline u64 tdx_hypercall_out_r11(u64 fn, u64 r12, u64 r13,
+					u64 r14, u64 r15)
+{
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

