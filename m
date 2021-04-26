Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C1F36B888
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhDZSDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:03:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:31731 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234245AbhDZSDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:24 -0400
IronPort-SDR: Sg1F4ON/xm4Qzb9Vb9slKGhqbif3m3NiFLK3O+n2I6G5X0CcCQTQC4bc36bIeQbIMfEsP14EbZ
 okvn2voKTzhA==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="195934025"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="195934025"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:42 -0700
IronPort-SDR: V3nFJaF0Mzyk1WJgjKSUyxJSImDWujBYDWzb3p3aYMYEQyhhUN43KZWUdGDVUnUid2tkOlKRAy
 guJo8eS8t2hw==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353345"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:42 -0700
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
Subject: [RFC v2 05/32] x86/tdx: Add __tdcall() and __tdvmcall() helper functions
Date:   Mon, 26 Apr 2021 11:01:32 -0700
Message-Id: <2f81f67efdf8c68838cdfbb2314e98747cf70120.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
   
__tdvmcall() - function can be used to request services from the VMM.
   
__tdcall()  - function can be used to communicate with the TDX Module.

Also define two additional wrappers, tdvmcall() and tdvmcall_out_r11()
to cover common use cases of __tdvmcall() function. Since each use
case of __tdcall() is different, we don't need such wrappers for it.

Implement __tdcall() and __tdvmcall() helper functions in assembly.
Rationale behind choosing to use assembly over inline assembly are,

1. Since the number of lines of instructions (with comments) in
__tdvmcall() implementation is over 70, using inline assembly to
implement it will make it hard to read.
   
2. Also, since many registers (R8-R15, R[A-D]X)) will be used in
TDVMCAL/TDCALL operation, if all these registers are included in
in-line assembly constraints, some of the older compilers may not
be able to meet this requirement.

Also, just like syscalls, not all TDVMCALL/TDCALLs use cases need to
use the same set of argument registers. The implementation here picks
the current worst-case scenario for TDCALL (4 registers). For TDCALLs
with fewer than 4 arguments, there will end up being a few superfluous
(cheap) instructions.  But, this approach maximizes code reuse. The
same argument applies to __tdvmcall() function as well.

Current implementation of __tdvmcall()  includes error handling (ud2
on failure case) in assembly function instead of doing it in C wrapper
function. The reason behind this choice is, when adding support for
in/out instructions (refer to patch titled "x86/tdx: Handle port I/O"
in this series), we use alternative_io() to substitute in/out
instruction with  __tdvmcall() calls. So use of C wrappers is not trivial
in this case because the input parameters will be in the wrong registers
and it's tricky to include proper buffer code to make this happen.

For registers used by TDCALL instruction, please check TDX GHCI
specification, sec 2.4 and 3.

https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface.pdf

Originally-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/tdx.h    |  26 +++++
 arch/x86/kernel/Makefile      |   2 +-
 arch/x86/kernel/asm-offsets.c |  22 ++++
 arch/x86/kernel/tdcall.S      | 200 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/tdx.c         |  36 ++++++
 5 files changed, 285 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/tdcall.S

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 69af72d08d3d..6c3c71bb57a0 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -8,12 +8,38 @@
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 #include <asm/cpufeature.h>
+#include <linux/types.h>
+
+struct tdcall_output {
+	u64 rcx;
+	u64 rdx;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+};
+
+struct tdvmcall_output {
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
+u64 __tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+	     struct tdcall_output *out);
+
+/* Helper function used to request services from VMM */
+u64 __tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
+	       struct tdvmcall_output *out);
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
index 60b9f42ce3c1..4a9885a9a28b 100644
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
+	OFFSET(TDCALL_rcx, tdcall_output, rcx);
+	OFFSET(TDCALL_rdx, tdcall_output, rdx);
+	OFFSET(TDCALL_r8,  tdcall_output, r8);
+	OFFSET(TDCALL_r9,  tdcall_output, r9);
+	OFFSET(TDCALL_r10, tdcall_output, r10);
+	OFFSET(TDCALL_r11, tdcall_output, r11);
+
+	/* Offset for fields in tdvmcall_output */
+	OFFSET(TDVMCALL_r11, tdvmcall_output, r11);
+	OFFSET(TDVMCALL_r12, tdvmcall_output, r12);
+	OFFSET(TDVMCALL_r13, tdvmcall_output, r13);
+	OFFSET(TDVMCALL_r14, tdvmcall_output, r14);
+	OFFSET(TDVMCALL_r15, tdvmcall_output, r15);
+#endif
+
 	BLANK();
 	OFFSET(BP_scratch, boot_params, scratch);
 	OFFSET(BP_secure_boot, boot_params, secure_boot);
diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
new file mode 100644
index 000000000000..81af70c2acbd
--- /dev/null
+++ b/arch/x86/kernel/tdcall.S
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/asm-offsets.h>
+#include <asm/asm.h>
+#include <asm/frame.h>
+#include <asm/unwind_hints.h>
+
+#include <linux/linkage.h>
+
+/*
+ * Expose registers R10-R15 to VMM (for bitfield info
+ * refer to TDX GHCI specification).
+ */
+#define TDVMCALL_EXPOSE_REGS_MASK	0xfc00
+
+/*
+ * TDX guests use the TDCALL instruction to make
+ * hypercalls to the VMM. It is supported in
+ * Binutils >= 2.36.
+ */
+#define tdcall .byte 0x66,0x0f,0x01,0xcc
+
+/*
+ * __tdcall()  - Used to communicate with the TDX module
+ *
+ * @arg1 (RDI) - TDCALL Leaf ID
+ * @arg2 (RSI) - Input parameter 1 passed to TDX module
+ *               via register RCX
+ * @arg2 (RDX) - Input parameter 2 passed to TDX module
+ *               via register RDX
+ * @arg3 (RCX) - Input parameter 3 passed to TDX module
+ *               via register R8
+ * @arg4 (R8)  - Input parameter 4 passed to TDX module
+ *               via register R9
+ * @arg5 (R9)  - struct tdcall_output pointer
+ *
+ * @out        - Return status of tdcall via RAX.
+ *
+ * NOTE: This function should only used for non TDVMCALL
+ *       use cases
+ */
+SYM_FUNC_START(__tdcall)
+	FRAME_BEGIN
+
+	/* Save non-volatile GPRs that are exposed to the VMM. */
+	push %r15
+	push %r14
+	push %r13
+	push %r12
+
+	/* Move TDCALL Leaf ID to RAX */
+	mov %rdi, %rax
+	/* Move output pointer to R12 */
+	mov %r9, %r12
+	/* Move input param 4 to R9 */
+	mov %r8, %r9
+	/* Move input param 3 to R8 */
+	mov %rcx, %r8
+	/* Leave input param 2 in RDX */
+	/* Move input param 1 to RCX */
+	mov %rsi, %rcx
+
+	tdcall
+
+	/* Check for TDCALL success: 0 - Successful, otherwise failed */
+	test %rax, %rax
+	jnz 1f
+
+	/* Check for a TDCALL output struct */
+	test %r12, %r12
+	jz 1f
+
+	/* Copy TDCALL result registers to output struct: */
+	movq %rcx, TDCALL_rcx(%r12)
+	movq %rdx, TDCALL_rdx(%r12)
+	movq %r8,  TDCALL_r8(%r12)
+	movq %r9,  TDCALL_r9(%r12)
+	movq %r10, TDCALL_r10(%r12)
+	movq %r11, TDCALL_r11(%r12)
+1:
+	/* Zero out registers exposed to the TDX Module. */
+	xor %rcx,  %rcx
+	xor %rdx,  %rdx
+	xor %r8d,  %r8d
+	xor %r9d,  %r9d
+	xor %r10d, %r10d
+	xor %r11d, %r11d
+
+	/* Restore non-volatile GPRs that are exposed to the VMM. */
+	pop %r12
+	pop %r13
+	pop %r14
+	pop %r15
+
+	FRAME_END
+	ret
+SYM_FUNC_END(__tdcall)
+
+/*
+ * do_tdvmcall()  - Used to communicate with the VMM.
+ *
+ * @arg1 (RDI)    - TDVMCALL function, e.g. exit reason
+ * @arg2 (RSI)    - Input parameter 1 passed to VMM
+ *                  via register R12
+ * @arg3 (RDX)    - Input parameter 2 passed to VMM
+ *                  via register R13
+ * @arg4 (RCX)    - Input parameter 3 passed to VMM
+ *                  via register R14
+ * @arg5 (R8)     - Input parameter 4 passed to VMM
+ *                  via register R15
+ * @arg6 (R9)     - struct tdvmcall_output pointer
+ *
+ * @out           - Return status of tdvmcall(R10) via RAX.
+ *
+ */
+SYM_CODE_START_LOCAL(do_tdvmcall)
+	FRAME_BEGIN
+
+	/* Save non-volatile GPRs that are exposed to the VMM. */
+	push %r15
+	push %r14
+	push %r13
+	push %r12
+
+	/* Set TDCALL leaf ID to TDVMCALL (0) in RAX */
+	xor %eax, %eax
+	/* Move TDVMCALL function id (1st argument) to R11 */
+	mov %rdi, %r11
+	/* Move Input parameter 1-4 to R12-R15 */
+	mov %rsi, %r12
+	mov %rdx, %r13
+	mov %rcx, %r14
+	mov %r8,  %r15
+	/* Leave tdvmcall output pointer in R9 */
+
+	/*
+	 * Value of RCX is used by the TDX Module to determine which
+	 * registers are exposed to VMM. Each bit in RCX represents a
+	 * register id. You can find the bitmap details from TDX GHCI
+	 * spec.
+	 */
+	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
+
+	tdcall
+
+	/*
+	 * Check for TDCALL success: 0 - Successful, otherwise failed.
+	 * If failed, there is an issue with TDX Module which is fatal
+	 * for the guest. So panic.
+	 */
+	test %rax, %rax
+	jnz 2f
+
+	/* Move TDVMCALL success/failure to RAX to return to user */
+	mov %r10, %rax
+
+	/* Check for TDVMCALL success: 0 - Successful, otherwise failed */
+	test %rax, %rax
+	jnz 1f
+
+	/* Check for a TDVMCALL output struct */
+	test %r9, %r9
+	jz 1f
+
+	/* Copy TDVMCALL result registers to output struct: */
+	movq %r11, TDVMCALL_r11(%r9)
+	movq %r12, TDVMCALL_r12(%r9)
+	movq %r13, TDVMCALL_r13(%r9)
+	movq %r14, TDVMCALL_r14(%r9)
+	movq %r15, TDVMCALL_r15(%r9)
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
+SYM_CODE_END(do_tdvmcall)
+
+/* Helper function for standard type of TDVMCALL */
+SYM_FUNC_START(__tdvmcall)
+	/* Set TDVMCALL type info (0 - Standard, > 0 - vendor) in R10 */
+	xor %r10, %r10
+	call do_tdvmcall
+	retq
+SYM_FUNC_END(__tdvmcall)
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 6a7193fead08..29c52128b9c0 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -1,8 +1,44 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2020 Intel Corporation */
 
+#define pr_fmt(fmt) "TDX: " fmt
+
 #include <asm/tdx.h>
 
+/*
+ * Wrapper for use case that checks for error code and print warning message.
+ */
+static inline u64 tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
+{
+	u64 err;
+
+	err = __tdvmcall(fn, r12, r13, r14, r15, NULL);
+
+	if (err)
+		pr_warn_ratelimited("TDVMCALL fn:%llx failed with err:%llx\n",
+				    fn, err);
+
+	return err;
+}
+
+/*
+ * Wrapper for the semi-common case where we need single output value (R11).
+ */
+static inline u64 tdvmcall_out_r11(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
+{
+
+	struct tdvmcall_output out = {0};
+	u64 err;
+
+	err = __tdvmcall(fn, r12, r13, r14, r15, &out);
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

