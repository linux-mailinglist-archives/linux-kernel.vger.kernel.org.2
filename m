Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91EA3A1F4E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFIVse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:48:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:4874 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230113AbhFIVsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:48:23 -0400
IronPort-SDR: d5HDzWhgK7T9E/dl3jI5So+zg80fkt0p9roIRd4YHnXTORLc53olqfVJFEj+rh9F/uBeWWiEdU
 5uigLL+raOOQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="266330424"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="266330424"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:46:24 -0700
IronPort-SDR: dEJoLBtbuLNU0v4x1N//5DEFrnEOetfjrJHPmlX8T84s1983QRRX15U6gOIy+iAxUHah0VmYDA
 VzSghUby3ZFg==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="448450492"
Received: from qwang4-mobl1.ccr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.35.228])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:46:23 -0700
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
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/10] x86/tdx: Handle port I/O in decompression code
Date:   Wed,  9 Jun 2021 14:45:48 -0700
Message-Id: <20210609214555.1955404-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609214555.1955404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210609214555.1955404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to replace in/out instructions in
decompression code with TDX IO hypercalls.

TDX cannot do port IO directly. The TDX module triggers
a #VE exception to let the guest kernel to emulate port
I/O, by converting them into TDX hypercalls to call the
host.

But for the really early code in the decompressor, #VE
cannot be used because the IDT needed for handling the
exception is not set-up, and some other infrastructure
needed by the handler is missing. So to support port IO
in decompressor code, directly replace in/out instructions
with TDX IO hypercalls. This can beeasily achieved by
modifying __in/__out macros.

Also, since TDX IO hypercall requires an IO size parameter,
modify __in/__out macros to accept size as input parameter.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/boot/compressed/Makefile |  1 +
 arch/x86/boot/compressed/tdcall.S |  3 ++
 arch/x86/include/asm/io.h         |  8 +++---
 arch/x86/include/asm/tdx.h        | 48 +++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 4 deletions(-)
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
index be96bf1e667a..50f9eb17d364 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -272,25 +272,25 @@ static inline bool sev_key_active(void) { return false; }
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
index cbfe7479f2a3..ac38ed5b50db 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -9,6 +9,8 @@
 
 #include <asm/cpufeature.h>
 #include <linux/types.h>
+#include <vdso/limits.h>
+#include <asm/vmx.h>
 
 /*
  * Used in __tdx_module_call() helper function to gather the
@@ -73,6 +75,52 @@ u64 __tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
 
 bool tdx_protected_guest_has(unsigned long flag);
 
+/*
+ * To support I/O port access in decompressor or early kernel init
+ * code, since #VE exception handler cannot be used, use paravirt
+ * model to implement __in/__out macros which will in turn be used
+ * by in{b,w,l}()/out{b,w,l} I/O helper macros used in kernel. You
+ * can find the __in/__out macro usage in arch/x86/include/asm/io.h
+ */
+#ifdef BOOT_COMPRESSED_MISC_H
+
+/*
+ * Helper function used for making hypercall for "in"
+ * instruction. It will be called from __in IO macro
+ * If IO is failed, it will return all 1s.
+ */
+static inline unsigned int tdg_in(int size, int port)
+{
+	struct tdx_hypercall_output out = {0};
+	int err;
+
+	err = __tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, 0,
+			      port, 0, &out);
+
+	return err ? UINT_MAX : out.r11;
+}
+
+#define __out(bwl, bw, sz)						\
+do {									\
+	if (is_tdx_guest()) {						\
+		__tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, sz, 1,	\
+				port, value, NULL);			\
+	} else {							\
+		asm volatile("out" #bwl " %" #bw "0, %w1" : :		\
+				"a"(value), "Nd"(port));		\
+	}								\
+} while (0)
+#define __in(bwl, bw, sz)						\
+do {									\
+	if (is_tdx_guest()) {						\
+		value = tdg_in(sz, port);				\
+	} else {							\
+		asm volatile("in" #bwl " %w1, %" #bw "0" :		\
+				"=a"(value) : "Nd"(port));		\
+	}								\
+} while (0)
+#endif
+
 #else // !CONFIG_INTEL_TDX_GUEST
 
 static inline bool is_tdx_guest(void)
-- 
2.25.1

