Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E047541539F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 00:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbhIVW4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 18:56:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:62858 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238357AbhIVW4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 18:56:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="221832433"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="221832433"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 15:54:49 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="653457340"
Received: from mnamagi-mobl1.gar.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.34.84])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 15:54:48 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/10] x86/tdx: Handle port I/O in decompression code
Date:   Wed, 22 Sep 2021 15:52:32 -0700
Message-Id: <20210922225239.3501262-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922225239.3501262-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210922225239.3501262-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to replace IN/OUT instructions in decompression code with
TDX IO hypercalls.

TDX cannot do port IO directly. The TDX module triggers a #VE exception
to let the guest kernel to emulate port I/O, by converting them into
TDX hypercalls to call the host.

But for the really early code in the decompressor, #VE cannot be used
because the IDT needed for handling the exception is not set-up, and
some other infrastructure needed by the handler is missing. So to
support port IO in decompressor code, directly replace IN/OUT
instructions with TDX IO hypercalls. This can be easily achieved by
modifying __in/__out macros.

Also, since TDX IO hypercall requires an IO size parameter, modify
__in/__out macros to accept size as input parameter.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v5:
 * None

Changes since v4:
 * Replaced in/out with IN/OUT.
 * Fixed typo in commit log and comments.
 * Renamed tdg_* prefix with tdx_*

Changes since v3:
 * None

Changes since v2:
 * None

Changes since v1:
 * Modified tdg_{in/out} to adapt to API changes of __tdx_hypercall().
 * Removed !CONFIG_INTEL_TDX_GUEST comment in #if else case.

 arch/x86/boot/compressed/Makefile |  1 +
 arch/x86/boot/compressed/tdcall.S |  3 ++
 arch/x86/include/asm/io.h         |  9 ++---
 arch/x86/include/asm/tdx.h        | 60 +++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdcall.S

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 22a2a6cc2ab4..1bfe30ebadbe 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -99,6 +99,7 @@ endif
 
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
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 3647a96238a9..fa6aa43e5dc3 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -41,6 +41,7 @@
 #include <linux/string.h>
 #include <linux/compiler.h>
 #include <asm/page.h>
+#include <asm/tdx.h>
 #include <asm/early_ioremap.h>
 #include <asm/pgtable_types.h>
 
@@ -272,25 +273,25 @@ static inline bool sev_key_active(void) { return false; }
 #endif /* CONFIG_AMD_MEM_ENCRYPT */
 
 #ifndef __out
-#define __out(bwl, bw)							\
+#define __out(bwl, bw, sz)						\
 	asm volatile("out" #bwl " %" #bw "0, %w1" : : "a"(value), "Nd"(port))
 #endif
 
 #ifndef __in
-#define __in(bwl, bw)							\
+#define __in(bwl, bw, sz)						\
 	asm volatile("in" #bwl " %w1, %" #bw "0" : "=a"(value) : "Nd"(port))
 #endif
 
 #define BUILDIO(bwl, bw, type)						\
 static inline void out##bwl(unsigned type value, int port)		\
 {									\
-	__out(bwl, bw);							\
+	__out(bwl, bw, sizeof(type));					\
 }									\
 									\
 static inline unsigned type in##bwl(int port)				\
 {									\
 	unsigned type value;						\
-	__in(bwl, bw);							\
+	__in(bwl, bw, sizeof(type));					\
 	return value;							\
 }									\
 									\
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index d47fec42df11..b35ebb3c54f0 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -5,6 +5,8 @@
 
 #include <linux/cpufeature.h>
 #include <linux/types.h>
+#include <vdso/limits.h>
+#include <asm/vmx.h>
 
 #define TDX_CPUID_LEAF_ID			0x21
 #define TDX_HYPERCALL_STANDARD			0
@@ -71,6 +73,64 @@ unsigned long tdx_get_ve_info(struct ve_info *ve);
 int tdx_handle_virtualization_exception(struct pt_regs *regs,
 					struct ve_info *ve);
 
+/*
+ * To support I/O port access in decompressor or early kernel init
+ * code, since #VE exception handler cannot be used, use paravirt
+ * model to implement __in/__out macros which will in turn be used
+ * by in{b,w,l}()/out{b,w,l} I/O helper macros used in kernel. Details
+ * about __in/__out macro usage can be found in arch/x86/include/asm/io.h
+ */
+#ifdef BOOT_COMPRESSED_MISC_H
+
+bool early_is_tdx_guest(void);
+
+/*
+ * Helper function used for making hypercall for "in"
+ * instruction. It will be called from __in IO macro
+ * If IO is failed, it will return all 1s.
+ */
+static inline unsigned int tdx_io_in(int size, int port)
+{
+	struct tdx_hypercall_output out = {0};
+
+	__tdx_hypercall(TDX_HYPERCALL_STANDARD, EXIT_REASON_IO_INSTRUCTION,
+			size, 0, port, 0, &out);
+
+	return out.r10 ? UINT_MAX : out.r11;
+}
+
+/*
+ * Helper function used for making hypercall for "out"
+ * instruction. It will be called from __out IO macro
+ */
+static inline void tdx_io_out(int size, int port, u64 value)
+{
+	struct tdx_hypercall_output out = {0};
+
+	__tdx_hypercall(TDX_HYPERCALL_STANDARD, EXIT_REASON_IO_INSTRUCTION,
+			size, 1, port, value, &out);
+}
+
+#define __out(bwl, bw, sz)						\
+do {									\
+	if (early_is_tdx_guest()) {					\
+		tdx_io_out(sz, port, value);				\
+	} else {							\
+		asm volatile("out" #bwl " %" #bw "0, %w1" : :		\
+				"a"(value), "Nd"(port));		\
+	}								\
+} while (0)
+#define __in(bwl, bw, sz)						\
+do {									\
+	if (early_is_tdx_guest()) {					\
+		value = tdx_io_in(sz, port);				\
+	} else {							\
+		asm volatile("in" #bwl " %w1, %" #bw "0" :		\
+				"=a"(value) : "Nd"(port));		\
+	}								\
+} while (0)
+#endif
+
 #else
 
 static inline void tdx_early_init(void) { };
-- 
2.25.1

