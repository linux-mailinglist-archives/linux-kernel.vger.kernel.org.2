Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A75839261B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhE0EZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:25:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:41864 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229744AbhE0EZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:25:47 -0400
IronPort-SDR: Xays9yGgyJqM+lcB9cKrc9Geij6p4ic4GuIzdNV78iXSuhvk7Wv8b8M3wLvX1Kl82vBc3K8ruv
 92ODJF4TVsOw==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="223844428"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="223844428"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:24:14 -0700
IronPort-SDR: H3e85iHs8TwK6U/umaRoYxMzR9vndp8fNXN4pa7zc2C8Pg7RMXRfS97cwB0XjjvpD9ezJHAKy4
 f/owgpyGuXJg==
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="480391418"
Received: from skgangad-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.33.45])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:24:13 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2-fix-v1 3/3] x86/tdx: Handle port I/O
Date:   Wed, 26 May 2021 21:23:56 -0700
Message-Id: <20210527042356.3983284-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527042356.3983284-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <CAPcyv4gBNqDFQEYjWqYTckPg-yy=LrvMw_FNY+tUuEwD35CfyA@mail.gmail.com>
 <20210527042356.3983284-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

TDX hypervisors cannot emulate instructions directly. This
includes port IO which is normally emulated in the hypervisor.
All port IO instructions inside TDX trigger the #VE exception
in the guest and would be normally emulated there.

For the really early code in the decompressor, #VE cannot be
used because the IDT needed for handling the exception is not
set-up, and some other infrastructure needed by the handler
is missing. So to support port IO in decompressor code, add
support for paravirt based I/O port virtualization.

Also string I/O is not supported in TDX guest. So, unroll the
string I/O operation into a loop operating on one element at
a time. This method is similar to AMD SEV, so just extend the
support for TDX guest platform.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/boot/compressed/Makefile |  1 +
 arch/x86/boot/compressed/tdcall.S |  3 ++
 arch/x86/boot/compressed/tdx.c    | 28 ++++++++++++++++++
 arch/x86/include/asm/io.h         |  7 +++--
 arch/x86/include/asm/tdx.h        | 47 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/tdx.c             | 39 +++++++++++++++++++++++++
 6 files changed, 122 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdcall.S

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index a2554621cefe..a944a2038797 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -97,6 +97,7 @@ endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o
+vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdcall.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
diff --git a/arch/x86/boot/compressed/tdcall.S b/arch/x86/boot/compressed/tdcall.S
new file mode 100644
index 000000000000..aafadc136c88
--- /dev/null
+++ b/arch/x86/boot/compressed/tdcall.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "../../kernel/tdcall.S"
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 0a87c1775b67..cb20962c7da6 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -4,6 +4,8 @@
  */
 
 #include <asm/tdx.h>
+#include <asm/vmx.h>
+#include <vdso/limits.h>
 
 static int __ro_after_init tdx_guest = -1;
 
@@ -30,3 +32,29 @@ bool is_tdx_guest(void)
 	return !!tdx_guest;
 }
 
+/*
+ * Helper function used for making hypercall for "out"
+ * instruction. It will be called from __out IO
+ * macro (in tdx.h).
+ */
+void tdg_out(int size, int port, unsigned int value)
+{
+	__tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, 1,
+			port, value, NULL);
+}
+
+/*
+ * Helper function used for making hypercall for "in"
+ * instruction. It will be called from __in IO macro
+ * (in tdx.h). If IO is failed, it will return all 1s.
+ */
+unsigned int tdg_in(int size, int port)
+{
+	struct tdx_hypercall_output out = {0};
+	int err;
+
+	err = __tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, 0,
+			      port, 0, &out);
+
+	return err ? UINT_MAX : out.r11;
+}
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index ef7a686a55a9..daa75c8eef5d 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -40,6 +40,7 @@
 
 #include <linux/string.h>
 #include <linux/compiler.h>
+#include <linux/protected_guest.h>
 #include <asm/page.h>
 #include <asm/early_ioremap.h>
 #include <asm/pgtable_types.h>
@@ -309,7 +310,8 @@ static inline unsigned type in##bwl##_p(int port)			\
 									\
 static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 {									\
-	if (sev_key_active()) {						\
+	if (sev_key_active() ||						\
+	    protected_guest_has(VM_UNROLL_STRING_IO)) {			\
 		unsigned type *value = (unsigned type *)addr;		\
 		while (count) {						\
 			out##bwl(*value, port);				\
@@ -325,7 +327,8 @@ static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 									\
 static inline void ins##bwl(int port, void *addr, unsigned long count)	\
 {									\
-	if (sev_key_active()) {						\
+	if (sev_key_active() ||						\
+	    protected_guest_has(VM_UNROLL_STRING_IO)) {			\
 		unsigned type *value = (unsigned type *)addr;		\
 		while (count) {						\
 			*value = in##bwl(port);				\
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index e880a9dd40d3..6ba2dcea533f 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -5,6 +5,8 @@
 
 #define TDX_CPUID_LEAF_ID	0x21
 
+#ifndef __ASSEMBLY__
+
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 #include <asm/cpufeature.h>
@@ -74,6 +76,48 @@ u64 __tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
 bool tdx_protected_guest_has(unsigned long flag);
 bool tdg_early_handle_ve(struct pt_regs *regs);
 
+void tdg_out(int size, int port, unsigned int value);
+unsigned int tdg_in(int size, int port);
+
+/* Helper function for converting {b,w,l} to byte size */
+static inline int tdx_get_iosize(char *str)
+{
+	if (str[0] == 'w')
+		return 2;
+	else if (str[0] == 'l')
+		return 4;
+
+	return 1;
+}
+
+/*
+ * To support I/O port access in decompressor or early kernel init
+ * code, since #VE exception handler cannot be used, use paravirt
+ * model to implement __in/__out macros which will in turn be used
+ * by in{b,w,l}()/out{b,w,l} I/O helper macros used in kernel. You
+ * can find the __in/__out macro usage in arch/x86/include/asm/io.h
+ */
+#ifdef BOOT_COMPRESSED_MISC_H
+#define __out(bwl, bw)							\
+do {									\
+	if (is_tdx_guest()) {						\
+		tdg_out(tdx_get_iosize(#bwl), port, value);		\
+	} else {							\
+		asm volatile("out" #bwl " %" #bw "0, %w1" : :		\
+				"a"(value), "Nd"(port));		\
+	}								\
+} while (0)
+#define __in(bwl, bw)							\
+do {									\
+	if (is_tdx_guest()) {						\
+		value = tdg_in(tdx_get_iosize(#bwl), port);		\
+	} else {							\
+		asm volatile("in" #bwl " %w1, %" #bw "0" :		\
+				"=a"(value) : "Nd"(port));		\
+	}								\
+} while (0)
+#endif
+
 #else // !CONFIG_INTEL_TDX_GUEST
 
 static inline bool is_tdx_guest(void)
@@ -161,6 +205,7 @@ static inline long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1,
 {
 	return -ENODEV;
 }
-#endif /* CONFIG_INTEL_TDX_GUEST_KVM */
 
+#endif /* CONFIG_INTEL_TDX_GUEST_KVM */
+#endif /* __ASSEMBLY__ */
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index ca3442b7accf..4a84487ee8ff 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -202,6 +202,42 @@ static void tdg_handle_cpuid(struct pt_regs *regs)
 	regs->dx = out.r15;
 }
 
+void tdg_out(int size, int port, unsigned int value)
+{
+	tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, 1, port, value);
+}
+
+unsigned int tdg_in(int size, int port)
+{
+	struct tdx_hypercall_output out = {0};
+	u64 err;
+
+	err = __tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, 0,
+			      port, 0, &out);
+
+	return err ? UINT_MAX : out.r11;
+}
+
+static void tdg_handle_io(struct pt_regs *regs, u32 exit_qual)
+{
+	bool string = exit_qual & 16;
+	int out, size, port;
+
+	/* I/O strings ops are unrolled at build time. */
+	BUG_ON(string);
+
+	out = VE_GET_IO_TYPE(exit_qual);
+	size = VE_GET_IO_SIZE(exit_qual);
+	port = VE_GET_PORT_NUM(exit_qual);
+
+	if (out) {
+		tdg_out(size, port, regs->ax);
+	} else {
+		regs->ax &= ~GENMASK(8 * size, 0);
+		regs->ax |= tdg_in(size, port) & GENMASK(8 * size, 0);
+	}
+}
+
 unsigned long tdg_get_ve_info(struct ve_info *ve)
 {
 	u64 ret;
@@ -248,6 +284,9 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_CPUID:
 		tdg_handle_cpuid(regs);
 		break;
+	case EXIT_REASON_IO_INSTRUCTION:
+		tdg_handle_io(regs, ve->exit_qual);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return -EFAULT;
-- 
2.25.1

