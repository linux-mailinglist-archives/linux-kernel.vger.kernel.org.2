Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F7934B317
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 00:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhCZXjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 19:39:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:45644 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhCZXi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 19:38:57 -0400
IronPort-SDR: duMiOiur50Znd9vy3k5w+AH6QNmSw4QHfa8eDP1Jh//lB7HdbqdqaIZ385BJ5URuXlaDMJMLxk
 P29ysib/S4Kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="191268813"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="191268813"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 16:38:55 -0700
IronPort-SDR: LDx3bnVXLfLYD7DGy0aKfhs27HrtbtGeqMvB5B7YfvHAg0SY2ryRkfhOKQCwSoGRf6tStvnAxy
 OvJ+toS3/CWw==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="609033006"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.255.231.203])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 16:38:47 -0700
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
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v2 1/1] x86/tdx: Add __tdcall() and __tdvmcall() helper functions
Date:   Fri, 26 Mar 2021 16:38:38 -0700
Message-Id: <c015093fdbc8e6a5aa9fc43f78fec8d9c38295c7.1616801167.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <8723950c-e07c-9a03-503a-ab232701d1e9@linux.intel.com>
References: <8723950c-e07c-9a03-503a-ab232701d1e9@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement common helper functions to communicate with
the TDX Module and VMM (using TDCALL instruction).

__tdvmcall() function can be used to request services
from VMM.

__tdcall() function can be used to communicate with the
TDX Module.

Using common helper functions makes the code more readable
and less error prone compared to distributed and use case
specific inline assembly code. Only downside in using this
approach is, it adds a few extra instructions for every
TDCALL use case when compared to distributed checks. Although
it's a bit less efficient, it's worth it to make the code more
readable.

Originally-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Hi All,

Please let me know your review comments. If you agree with this patch
and want to see the use of these APIs in rest of the patches, I will
re-send the patch series with updated code. Please let me know.

Changes since v1:
 * Implemented tdvmcall and tdcall helper functions as assembly code.
 * Followed suggestion provided by Sean & Dave.

 arch/x86/include/asm/tdx.h    |  23 +++++
 arch/x86/kernel/Makefile      |   2 +-
 arch/x86/kernel/asm-offsets.c |  22 +++++
 arch/x86/kernel/tdcall.S      | 163 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/tdx.c         |  30 +++++++
 5 files changed, 239 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/tdcall.S

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 69af72d08d3d..ce6212ce5f45 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -8,12 +8,35 @@
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
 
+u64 __tdcall(u64 fn, u64 rcx, u64 rdx, struct tdcall_output *out);
+
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
index 60b9f42ce3c1..72de0b49467e 100644
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
+	OFFSET(TDCALL_r8, tdcall_output, r8);
+	OFFSET(TDCALL_r9, tdcall_output, r9);
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
index 000000000000..a73b67c0b407
--- /dev/null
+++ b/arch/x86/kernel/tdcall.S
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/asm-offsets.h>
+#include <asm/asm.h>
+#include <asm/frame.h>
+#include <asm/unwind_hints.h>
+
+#include <linux/linkage.h>
+
+#define TDVMCALL_EXPOSE_REGS_MASK	0xfc00
+
+/*
+ * TDCALL instruction is newly added in TDX architecture,
+ * used by TD for requesting the host VMM to provide
+ * (untrusted) services. Supported in Binutils >= 2.36
+ */
+#define tdcall .byte 0x66,0x0f,0x01,0xcc
+
+/* Only for non TDVMCALL use cases */
+SYM_FUNC_START(__tdcall)
+	FRAME_BEGIN
+
+	/* Save/restore non-volatile GPRs that are exposed to the VMM. */
+	push %r15
+	push %r14
+	push %r13
+	push %r12
+
+	/*
+	 * RDI  => RAX = TDCALL leaf
+	 * RSI  => RCX = input param 1
+	 * RDX  => RDX = input param 2
+	 * RCX  => N/A = output struct
+	 */
+
+	/* Save output pointer to R12 */
+	mov %rcx, %r12
+	/* Move TDCALL Leaf ID to RAX */
+	mov %rdi, %rax
+	/* Move input param 1 to rcx*/
+	mov %rsi, %rcx
+
+	tdcall
+
+	/*
+	 * On success, propagate TDCALL outputs values to the output struct,
+	 * if an output struct is provided.
+	 */
+	test %rax, %rax
+	jnz 1f
+	test %r12, %r12
+	jz 1f
+
+	movq %rcx, TDCALL_rcx(%r12)
+	movq %rdx, TDCALL_rdx(%r12)
+	movq %r8, TDCALL_r8(%r12)
+	movq %r9, TDCALL_r9(%r12)
+	movq %r10, TDCALL_r10(%r12)
+	movq %r11, TDCALL_r11(%r12)
+1:
+	/*
+	 * Zero out registers exposed to the VMM to avoid speculative execution
+	 * with VMM-controlled values.
+	 */
+        xor %rcx, %rcx
+        xor %rdx, %rdx
+        xor %r8d, %r8d
+        xor %r9d, %r9d
+        xor %r10d, %r10d
+        xor %r11d, %r11d
+
+	pop %r12
+	pop %r13
+	pop %r14
+	pop %r15
+
+	FRAME_END
+	ret
+SYM_FUNC_END(__tdcall)
+
+.macro tdvmcall_core
+	FRAME_BEGIN
+
+	/* Save/restore non-volatile GPRs that are exposed to the VMM. */
+	push %r15
+	push %r14
+	push %r13
+	push %r12
+
+	/*
+	 * 0    => RAX = TDCALL leaf
+	 * RDI  => R11 = TDVMCALL function, e.g. exit reason
+	 * RSI  => R12 = input param 0
+	 * RDX  => R13 = input param 1
+	 * RCX  => R14 = input param 2
+	 * R8   => R15 = input param 3
+	 * MASK => RCX = TDVMCALL register behavior
+	 * R9   => R9  = output struct
+	 */
+
+	xor %eax, %eax
+	mov %rdi, %r11
+	mov %rsi, %r12
+	mov %rdx, %r13
+	mov %rcx, %r14
+	mov %r8,  %r15
+
+	/*
+	 * Expose R10 - R15, i.e. all GPRs that may be used by TDVMCALLs
+	 * defined in the GHCI.  Note, RAX and RCX are consumed, but only by
+	 * TDX-Module and so don't need to be listed in the mask.
+	 */
+	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
+
+	tdcall
+
+	/* Panic if TDCALL reports failure. */
+	test %rax, %rax
+	jnz 2f
+
+	/* Propagate TDVMCALL success/failure to return value. */
+	mov %r10, %rax
+
+	/*
+	 * On success, propagate TDVMCALL outputs values to the output struct,
+	 * if an output struct is provided.
+	 */
+	test %rax, %rax
+	jnz 1f
+	test %r9, %r9
+	jz 1f
+
+	movq %r11, TDVMCALL_r11(%r9)
+	movq %r12, TDVMCALL_r12(%r9)
+	movq %r13, TDVMCALL_r13(%r9)
+	movq %r14, TDVMCALL_r14(%r9)
+	movq %r15, TDVMCALL_r15(%r9)
+1:
+	/*
+	 * Zero out registers exposed to the VMM to avoid speculative execution
+	 * with VMM-controlled values.
+	 */
+	xor %r10d, %r10d
+	xor %r11d, %r11d
+	xor %r12d, %r12d
+	xor %r13d, %r13d
+	xor %r14d, %r14d
+	xor %r15d, %r15d
+
+	pop %r12
+	pop %r13
+	pop %r14
+	pop %r15
+
+	FRAME_END
+	ret
+2:
+	ud2
+.endm
+
+SYM_FUNC_START(__tdvmcall)
+	xor %r10, %r10
+	tdvmcall_core
+SYM_FUNC_END(__tdvmcall)
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 0d00dd50a6ff..1147e7e765d6 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -3,6 +3,36 @@
 
 #include <asm/tdx.h>
 
+/*
+ * Wrapper for the common case with standard output value (R10).
+ */
+static inline u64 tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
+{
+	u64 err;
+
+	err = __tdvmcall(fn, r12, r13, r14, r15, NULL);
+
+	WARN_ON(err);
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
+	WARN_ON(err);
+
+	return out.r11;
+}
+
 static inline bool cpuid_has_tdx_guest(void)
 {
 	u32 eax, signature[3];
-- 
2.25.1

