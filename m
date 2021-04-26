Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6806236B890
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbhDZSEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:04:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:31744 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234283AbhDZSDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:30 -0400
IronPort-SDR: iiRhV4w60o5tc8rZTyFEdio768D3IJNZapGEoFy2mK6KLljlgx2M7fL9tg8LBCauDKGBWwMdCC
 iwmSz5ZjViWw==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="195934042"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="195934042"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:47 -0700
IronPort-SDR: tBBgFdamlHP0+DALQaEyGOgfV75gRQBtU0xsbtMlLMVgyDwbOMCrw7i8cZxGRLo3Le4RdrIZl6
 LI20kkCeXj0w==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353371"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:46 -0700
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
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2 10/32] x86/tdx: Wire up KVM hypercalls
Date:   Mon, 26 Apr 2021 11:01:37 -0700
Message-Id: <04de6cd6549eee0b77fe3b0937c4b4b7f0e3ff2e.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

KVM hypercalls have to be wrapped into vendor-specific TDVMCALLs.

[Isaku: proposed KVM VENDOR string]
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/kvm_para.h | 21 +++++++++++++++
 arch/x86/include/asm/tdx.h      | 39 ++++++++++++++++++++++++++++
 arch/x86/kernel/tdcall.S        |  7 +++++
 arch/x86/kernel/tdx-kvm.c       | 45 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/tdx.c           |  4 +++
 5 files changed, 116 insertions(+)
 create mode 100644 arch/x86/kernel/tdx-kvm.c

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 338119852512..2fa85481520b 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -6,6 +6,7 @@
 #include <asm/alternative.h>
 #include <linux/interrupt.h>
 #include <uapi/asm/kvm_para.h>
+#include <asm/tdx.h>
 
 extern void kvmclock_init(void);
 
@@ -34,6 +35,10 @@ static inline bool kvm_check_and_clear_guest_paused(void)
 static inline long kvm_hypercall0(unsigned int nr)
 {
 	long ret;
+
+	if (is_tdx_guest())
+		return tdx_kvm_hypercall0(nr);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr)
@@ -44,6 +49,10 @@ static inline long kvm_hypercall0(unsigned int nr)
 static inline long kvm_hypercall1(unsigned int nr, unsigned long p1)
 {
 	long ret;
+
+	if (is_tdx_guest())
+		return tdx_kvm_hypercall1(nr, p1);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr), "b"(p1)
@@ -55,6 +64,10 @@ static inline long kvm_hypercall2(unsigned int nr, unsigned long p1,
 				  unsigned long p2)
 {
 	long ret;
+
+	if (is_tdx_guest())
+		return tdx_kvm_hypercall2(nr, p1, p2);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr), "b"(p1), "c"(p2)
@@ -66,6 +79,10 @@ static inline long kvm_hypercall3(unsigned int nr, unsigned long p1,
 				  unsigned long p2, unsigned long p3)
 {
 	long ret;
+
+	if (is_tdx_guest())
+		return tdx_kvm_hypercall3(nr, p1, p2, p3);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr), "b"(p1), "c"(p2), "d"(p3)
@@ -78,6 +95,10 @@ static inline long kvm_hypercall4(unsigned int nr, unsigned long p1,
 				  unsigned long p4)
 {
 	long ret;
+
+	if (is_tdx_guest())
+		return tdx_kvm_hypercall4(nr, p1, p2, p3, p4);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr), "b"(p1), "c"(p2), "d"(p3), "S"(p4)
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 1ca55d8e9963..e0b3ed9e262c 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -56,6 +56,16 @@ u64 __tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 /* Helper function used to request services from VMM */
 u64 __tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
 	       struct tdvmcall_output *out);
+u64 __tdvmcall_vendor_kvm(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
+			  struct tdvmcall_output *out);
+
+long tdx_kvm_hypercall0(unsigned int nr);
+long tdx_kvm_hypercall1(unsigned int nr, unsigned long p1);
+long tdx_kvm_hypercall2(unsigned int nr, unsigned long p1, unsigned long p2);
+long tdx_kvm_hypercall3(unsigned int nr, unsigned long p1, unsigned long p2,
+		unsigned long p3);
+long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1, unsigned long p2,
+		unsigned long p3, unsigned long p4);
 
 #else // !CONFIG_INTEL_TDX_GUEST
 
@@ -66,6 +76,35 @@ static inline bool is_tdx_guest(void)
 
 static inline void tdx_early_init(void) { };
 
+static inline long tdx_kvm_hypercall0(unsigned int nr)
+{
+	return -ENODEV;
+}
+
+static inline long tdx_kvm_hypercall1(unsigned int nr, unsigned long p1)
+{
+	return -ENODEV;
+}
+
+static inline long tdx_kvm_hypercall2(unsigned int nr, unsigned long p1,
+				      unsigned long p2)
+{
+	return -ENODEV;
+}
+
+static inline long tdx_kvm_hypercall3(unsigned int nr, unsigned long p1,
+				      unsigned long p2, unsigned long p3)
+{
+	return -ENODEV;
+}
+
+static inline long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1,
+				      unsigned long p2, unsigned long p3,
+				      unsigned long p4)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
index 81af70c2acbd..964bfd7fc682 100644
--- a/arch/x86/kernel/tdcall.S
+++ b/arch/x86/kernel/tdcall.S
@@ -11,6 +11,7 @@
  * refer to TDX GHCI specification).
  */
 #define TDVMCALL_EXPOSE_REGS_MASK	0xfc00
+#define TDVMCALL_VENDOR_KVM		0x4d564b2e584454 /* "TDX.KVM" */
 
 /*
  * TDX guests use the TDCALL instruction to make
@@ -198,3 +199,9 @@ SYM_FUNC_START(__tdvmcall)
 	call do_tdvmcall
 	retq
 SYM_FUNC_END(__tdvmcall)
+
+SYM_FUNC_START(__tdvmcall_vendor_kvm)
+	movq $TDVMCALL_VENDOR_KVM, %r10
+	call do_tdvmcall
+	retq
+SYM_FUNC_END(__tdvmcall_vendor_kvm)
diff --git a/arch/x86/kernel/tdx-kvm.c b/arch/x86/kernel/tdx-kvm.c
new file mode 100644
index 000000000000..c4264e926712
--- /dev/null
+++ b/arch/x86/kernel/tdx-kvm.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+static long tdvmcall_vendor(unsigned int fn, unsigned long r12,
+			    unsigned long r13, unsigned long r14,
+			    unsigned long r15)
+{
+	return __tdvmcall_vendor_kvm(fn, r12, r13, r14, r15, NULL);
+}
+
+/* Used by kvm_hypercall0() to trigger hypercall in TDX guest */
+long tdx_kvm_hypercall0(unsigned int nr)
+{
+	return tdvmcall_vendor(nr, 0, 0, 0, 0);
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall0);
+
+/* Used by kvm_hypercall1() to trigger hypercall in TDX guest */
+long tdx_kvm_hypercall1(unsigned int nr, unsigned long p1)
+{
+	return tdvmcall_vendor(nr, p1, 0, 0, 0);
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall1);
+
+/* Used by kvm_hypercall2() to trigger hypercall in TDX guest */
+long tdx_kvm_hypercall2(unsigned int nr, unsigned long p1, unsigned long p2)
+{
+	return tdvmcall_vendor(nr, p1, p2, 0, 0);
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall2);
+
+/* Used by kvm_hypercall3() to trigger hypercall in TDX guest */
+long tdx_kvm_hypercall3(unsigned int nr, unsigned long p1, unsigned long p2,
+		unsigned long p3)
+{
+	return tdvmcall_vendor(nr, p1, p2, p3, 0);
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall3);
+
+/* Used by kvm_hypercall4() to trigger hypercall in TDX guest */
+long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1, unsigned long p2,
+		unsigned long p3, unsigned long p4)
+{
+	return tdvmcall_vendor(nr, p1, p2, p3, p4);
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall4);
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 5169f72b6b3f..721c213d807d 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -8,6 +8,10 @@
 
 #include <linux/cpu.h>
 
+#ifdef CONFIG_KVM_GUEST
+#include "tdx-kvm.c"
+#endif
+
 static struct {
 	unsigned int gpa_width;
 	unsigned long attributes;
-- 
2.25.1

