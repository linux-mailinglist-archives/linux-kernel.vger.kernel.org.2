Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A704E311B2F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhBFEzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:55:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:63384 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231436AbhBFD3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:29:34 -0500
IronPort-SDR: QNQxINdFsOyGLQVZyvKDx9rNlbWH2hxR/zQaUBlpUCSti1FhIzM/BL2sgE3c7qNWMAJl0jsJpz
 aRlNcvpT1Ljw==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650731"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650731"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:10 -0800
IronPort-SDR: /LB1d4eon4QJNLQQGRwd5V1mRB4FWMtvHMoQG5aiQM4J+Uabfnxp7kSzRaEXe4pl9cxovEXgav
 h4b9CYSjEdSw==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183907"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:09 -0800
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
Subject: [RFC v1 11/26] x86/tdx: Handle port I/O
Date:   Fri,  5 Feb 2021 15:38:28 -0800
Message-Id: <0de5075374836f21e75dfb1d1e8632a1abc4493b.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Unroll string operations and handle port I/O through TDVMCALLs.
Also handle #VE due to I/O operations with the same TDVMCALLs.

Decompression code uses port IO for earlyprintk. We must use
paravirt calls there too if we want to allow earlyprintk.

Decompresion code cannot deal with alternatives: use branches
instead to implement inX() and outX() helpers.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/boot/compressed/Makefile     |   1 +
 arch/x86/boot/compressed/tdx_io.S     |   9 ++
 arch/x86/include/asm/asm-prototypes.h |   1 +
 arch/x86/include/asm/io.h             |   5 +-
 arch/x86/include/asm/tdx.h            |  62 +++++++++--
 arch/x86/kernel/Makefile              |   2 +-
 arch/x86/kernel/tdx.c                 |  72 +++++++++++++
 arch/x86/kernel/tdx_io.S              | 143 ++++++++++++++++++++++++++
 8 files changed, 284 insertions(+), 11 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdx_io.S
 create mode 100644 arch/x86/kernel/tdx_io.S

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index a2554621cefe..54da333adc4e 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -97,6 +97,7 @@ endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o
+vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx_io.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
diff --git a/arch/x86/boot/compressed/tdx_io.S b/arch/x86/boot/compressed/tdx_io.S
new file mode 100644
index 000000000000..67498f67cb18
--- /dev/null
+++ b/arch/x86/boot/compressed/tdx_io.S
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <asm/export.h>
+
+/* Do not export symbols in decompression code */
+#undef EXPORT_SYMBOL
+#define EXPORT_SYMBOL(sym)
+
+#include "../../kernel/tdx_io.S"
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 51e2bf27cc9b..6bc97aa39a21 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -6,6 +6,7 @@
 #include <asm/page.h>
 #include <asm/checksum.h>
 #include <asm/mce.h>
+#include <asm/tdx.h>
 
 #include <asm-generic/asm-prototypes.h>
 
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index ef7a686a55a9..30a3b30395ad 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -43,6 +43,7 @@
 #include <asm/page.h>
 #include <asm/early_ioremap.h>
 #include <asm/pgtable_types.h>
+#include <asm/tdx.h>
 
 #define build_mmio_read(name, size, type, reg, barrier) \
 static inline type name(const volatile void __iomem *addr) \
@@ -309,7 +310,7 @@ static inline unsigned type in##bwl##_p(int port)			\
 									\
 static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 {									\
-	if (sev_key_active()) {						\
+	if (sev_key_active() || is_tdx_guest()) {			\
 		unsigned type *value = (unsigned type *)addr;		\
 		while (count) {						\
 			out##bwl(*value, port);				\
@@ -325,7 +326,7 @@ static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 									\
 static inline void ins##bwl(int port, void *addr, unsigned long count)	\
 {									\
-	if (sev_key_active()) {						\
+	if (sev_key_active() || is_tdx_guest()) {			\
 		unsigned type *value = (unsigned type *)addr;		\
 		while (count) {						\
 			*value = in##bwl(port);				\
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 8c3e5af88643..b46ae140e39b 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -5,7 +5,16 @@
 
 #define TDX_CPUID_LEAF_ID	0x21
 
-#ifdef CONFIG_INTEL_TDX_GUEST
+#define TDVMCALL	0
+#define TDINFO		1
+#define TDGETVEINFO	3
+
+/* TDVMCALL R10 Input */
+#define TDVMCALL_STANDARD	0
+#define TDVMCALL_VENDOR		1
+
+#ifndef __ASSEMBLY__
+#include <asm/cpufeature.h>
 
 /*
  * TDCALL instruction is newly added in TDX architecture,
@@ -14,19 +23,55 @@
  */
 #define TDCALL	".byte 0x66,0x0f,0x01,0xcc"
 
-#define TDVMCALL	0
-#define TDINFO		1
-#define TDGETVEINFO	3
-
-/* TDVMCALL R10 Input */
-#define TDVMCALL_STANDARD	0
-#define TDVMCALL_VENDOR		1
+#ifdef CONFIG_INTEL_TDX_GUEST
 
 /* Common API to check TDX support in decompression and common kernel code. */
 bool is_tdx_guest(void);
 
 void __init tdx_early_init(void);
 
+/* Decompression code doesn't know how to handle alternatives */
+#ifdef BOOT_COMPRESSED_MISC_H
+#define __out(bwl, bw)							\
+do {									\
+	if (is_tdx_guest()) {						\
+		asm volatile("call tdx_out" #bwl : :			\
+				"a"(value), "d"(port));			\
+	} else {							\
+		asm volatile("out" #bwl " %" #bw "0, %w1" : :		\
+				"a"(value), "Nd"(port));		\
+	}								\
+} while (0)
+#define __in(bwl, bw)							\
+do {									\
+	if (is_tdx_guest()) {						\
+		asm volatile("call tdx_in" #bwl :			\
+				"=a"(value) : "d"(port));		\
+	} else {							\
+		asm volatile("in" #bwl " %w1, %" #bw "0" :		\
+				"=a"(value) : "Nd"(port));		\
+	}								\
+} while (0)
+#else
+#define __out(bwl, bw)							\
+	alternative_input("out" #bwl " %" #bw "1, %w2",			\
+			"call tdx_out" #bwl, X86_FEATURE_TDX_GUEST,	\
+			"a"(value), "d"(port))
+
+#define __in(bwl, bw)							\
+	alternative_io("in" #bwl " %w2, %" #bw "0",			\
+			"call tdx_in" #bwl, X86_FEATURE_TDX_GUEST,	\
+			"=a"(value), "d"(port))
+#endif
+
+void tdx_outb(unsigned char value, unsigned short port);
+void tdx_outw(unsigned short value, unsigned short port);
+void tdx_outl(unsigned int value, unsigned short port);
+
+unsigned char tdx_inb(unsigned short port);
+unsigned short tdx_inw(unsigned short port);
+unsigned int tdx_inl(unsigned short port);
+
 #else // !CONFIG_INTEL_TDX_GUEST
 
 static inline bool is_tdx_guest(void)
@@ -59,4 +104,5 @@ long tdx_kvm_hypercall3(unsigned int nr, unsigned long p1, unsigned long p2,
 long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1, unsigned long p2,
 		unsigned long p3, unsigned long p4);
 
+#endif
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index ba8ee9300f23..c1ec77df3213 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -128,7 +128,7 @@ obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
 obj-$(CONFIG_X86_PMEM_LEGACY_DEVICE) += pmem.o
 
 obj-$(CONFIG_JAILHOUSE_GUEST)	+= jailhouse.o
-obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx.o
+obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx.o tdx_io.o
 
 obj-$(CONFIG_EISA)		+= eisa.o
 obj-$(CONFIG_PCSPKR_PLATFORM)	+= pcspeaker.o
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index e98058c048b5..3846d2807a7a 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -201,6 +201,75 @@ static void tdx_handle_cpuid(struct pt_regs *regs)
 	WARN_ON(ret || r10);
 }
 
+static void tdx_out(int size, unsigned int value, int port)
+{
+	register long r10 asm("r10") = TDVMCALL_STANDARD;
+	register long r11 asm("r11") = EXIT_REASON_IO_INSTRUCTION;
+	register long r12 asm("r12") = size;
+	register long r13 asm("r13") = 1;
+	register long r14 asm("r14") = port;
+	register long r15 asm("r15") = value;
+	register long rcx asm("rcx");
+	long ret;
+
+	/* Allow to pass R10, R11, R12, R13, R14 and R15 down to the VMM */
+	rcx = BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(14) | BIT(15);
+
+	asm volatile(TDCALL
+			: "=a"(ret), "=r"(r10), "=r"(r11), "=r"(r12), "=r"(r13),
+			  "=r"(r14), "=r"(r15)
+			: "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11), "r"(r12),
+			  "r"(r13), "r"(r14), "r"(r15)
+			: );
+
+	WARN_ON(ret || r10);
+}
+
+static unsigned int tdx_in(int size, int port)
+{
+	register long r10 asm("r10") = TDVMCALL_STANDARD;
+	register long r11 asm("r11") = EXIT_REASON_IO_INSTRUCTION;
+	register long r12 asm("r12") = size;
+	register long r13 asm("r13") = 0;
+	register long r14 asm("r14") = port;
+	register long rcx asm("rcx");
+	long ret;
+
+	/* Allow to pass R10, R11, R12, R13 and R14 down to the VMM */
+	rcx = BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(14);
+
+	asm volatile(TDCALL
+			: "=a"(ret), "=r"(r10), "=r"(r11), "=r"(r12), "=r"(r13),
+			  "=r"(r14)
+			: "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11), "r"(r12),
+			  "r"(r13), "r"(r14)
+			: );
+
+	WARN_ON(ret || r10);
+
+	return r11;
+}
+
+static void tdx_handle_io(struct pt_regs *regs, u32 exit_qual)
+{
+	bool string = exit_qual & 16;
+	int out, size, port;
+
+	/* I/O strings ops are unrolled at build time. */
+	BUG_ON(string);
+
+	out = (exit_qual & 8) ? 0 : 1;
+	size = (exit_qual & 7) + 1;
+	port = exit_qual >> 16;
+
+	if (out) {
+		tdx_out(size, regs->ax, port);
+	} else {
+		regs->ax &= ~GENMASK(8 * size, 0);
+		regs->ax |= tdx_in(size, port) & GENMASK(8 * size, 0);
+	}
+}
+
 void __init tdx_early_init(void)
 {
 	if (!cpuid_has_tdx_guest())
@@ -259,6 +328,9 @@ int tdx_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_CPUID:
 		tdx_handle_cpuid(regs);
 		break;
+	case EXIT_REASON_IO_INSTRUCTION:
+		tdx_handle_io(regs, ve->exit_qual);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
 		return -EFAULT;
diff --git a/arch/x86/kernel/tdx_io.S b/arch/x86/kernel/tdx_io.S
new file mode 100644
index 000000000000..00ccbc9711fe
--- /dev/null
+++ b/arch/x86/kernel/tdx_io.S
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/linkage.h>
+#include <asm/export.h>
+
+#include <asm/tdx.h>
+
+#define TDCALL .byte 0x66,0x0f,0x01,0xcc
+
+#define EXIT_REASON_IO_INSTRUCTION 30
+
+SYM_FUNC_START(tdx_outb)
+	push	%r15
+	push	%r12
+
+	xor	%r15, %r15
+	mov	%al, %r15b
+	mov	$1, %r12
+	jmp	1f
+
+SYM_FUNC_START(tdx_outw)
+	push	%r15
+	push	%r12
+
+	xor	%r15, %r15
+	mov	%ax, %r15w
+	mov	$2, %r12
+	jmp	1f
+
+SYM_FUNC_START(tdx_outl)
+	push	%r15
+	push	%r12
+
+	xor	%r15, %r15
+	mov	%eax, %r15d
+	mov	$4, %r12
+1:
+	push	%rax
+	push	%rcx
+	push	%r10
+	push	%r11
+	push	%r13
+	push	%r14
+
+	mov	$TDVMCALL, %rax
+	mov	$TDVMCALL_STANDARD, %r10
+	mov	$EXIT_REASON_IO_INSTRUCTION, %r11
+	mov	$1, %r13
+	xor	%r14, %r14
+	mov	%dx, %r14w
+	/* Allow to pass R10, R11, R12, R13, R14 and R15 down to the VMM */
+	mov	$0xfc00, %rcx
+
+	TDCALL
+
+	/* Panic if TDVMCALL reports failure */
+	test	%rax, %rax
+	jnz	1f
+
+	/* Panic if TDVMCALL reports failure */
+	test	%r10, %r10
+	jnz	1f
+
+	pop	%r14
+	pop	%r13
+	pop	%r11
+	pop	%r10
+	pop	%rcx
+	pop	%rax
+
+	pop	%r12
+	pop	%r15
+	ret
+1:
+	ud2
+SYM_FUNC_END(tdx_outb)
+SYM_FUNC_END(tdx_outw)
+SYM_FUNC_END(tdx_outl)
+EXPORT_SYMBOL(tdx_outb)
+EXPORT_SYMBOL(tdx_outw)
+EXPORT_SYMBOL(tdx_outl)
+
+SYM_FUNC_START(tdx_inb)
+	push	%r12
+	mov	$1, %r12
+	jmp	1f
+
+SYM_FUNC_START(tdx_inw)
+	push	%r12
+	mov	$2, %r12
+	jmp	1f
+
+SYM_FUNC_START(tdx_inl)
+	push	%r12
+
+	mov	$4, %r12
+1:
+	push	%r11
+	push	%rax
+	push	%rcx
+	push	%r10
+	push	%r13
+	push	%r14
+
+	mov	$TDVMCALL, %rax
+	mov	$TDVMCALL_STANDARD, %r10
+	mov	$EXIT_REASON_IO_INSTRUCTION, %r11
+	mov	$0, %r13
+	xor	%r14, %r14
+	mov	%dx, %r14w
+
+	/* Allow to pass R10, R11, R12, R13 and R14 down to the VMM */
+	mov	$0x7c00, %rcx
+
+	TDCALL
+
+	/* Panic if TDVMCALL reports failure */
+	test	%rax, %rax
+	jnz	1f
+
+	/* Panic if TDVMCALL reports failure */
+	test	%r10, %r10
+	jnz	1f
+
+	pop	%r14
+	pop	%r13
+	pop	%r10
+	pop	%rcx
+	pop	%rax
+
+	mov %r11d, %eax
+
+	pop	%r11
+	pop	%r12
+	ret
+1:
+	ud2
+SYM_FUNC_END(tdx_inb)
+SYM_FUNC_END(tdx_inw)
+SYM_FUNC_END(tdx_inl)
+EXPORT_SYMBOL(tdx_inb)
+EXPORT_SYMBOL(tdx_inw)
+EXPORT_SYMBOL(tdx_inl)
-- 
2.25.1

