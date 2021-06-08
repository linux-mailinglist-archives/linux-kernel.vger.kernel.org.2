Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABF639FB07
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhFHPmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:42:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:7767 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230460AbhFHPm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:42:28 -0400
IronPort-SDR: z6a/4M3uS3E648rmqolDWt4nCnOcuNmlNoizf/6MhpRswAoljn4hRjRbki17CcrLVfDCi+JZof
 BjelkoVfZJGw==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="201849038"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="201849038"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 08:40:30 -0700
IronPort-SDR: +GYRRZHink+JcLfuUobGYig3Syc9MAfdEbXVAH7BZvhhyjLQaoq8cRNiEH50I9nG4yikPkvJ5l
 ILOztZsQDImw==
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="552314843"
Received: from ticela-az-103.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.36.77])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 08:40:30 -0700
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
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2-fix-v2 1/3] x86/tdx: Handle port I/O in decompression code
Date:   Tue,  8 Jun 2021 08:40:21 -0700
Message-Id: <e743d11960f58f1694ced91edd1b262ce7eb82db.1623165571.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1623165571.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1623165571.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/boot/compressed/Makefile |  1 +
 arch/x86/boot/compressed/tdcall.S |  3 ++
 arch/x86/include/asm/io.h         |  9 +++---
 arch/x86/include/asm/tdx.h        | 48 +++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 4 deletions(-)
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
index be96bf1e667a..391205dace98 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -40,6 +40,7 @@
 
 #include <linux/string.h>
 #include <linux/compiler.h>
+#include <linux/protected_guest.h>
 #include <asm/page.h>
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

