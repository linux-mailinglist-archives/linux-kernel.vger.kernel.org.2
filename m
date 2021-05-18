Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B1438820F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243938AbhERVVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:21:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:8530 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352455AbhERVVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:21:19 -0400
IronPort-SDR: fADZkhg/XhzD6R0GKNfhudtgmL9DQoBArwqX8xrTNO0GRxAfUxKyNY4xhAakCEgIV/imfqkrdP
 yOIqRn2V4h9A==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="197732687"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="197732687"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 14:20:00 -0700
IronPort-SDR: Qp+NBNkeI4PfEeQthwmtSHfnqRsoDYOh/oY8azT/n9vR9PEwqWqa3sdcOTfMadqYvN4PIHL3m8
 mgFkM/hul8xw==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="473153685"
Received: from kmylavar-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.100.98])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 14:19:58 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2-fix-v2 1/1] x86/tdx: Wire up KVM hypercalls
Date:   Tue, 18 May 2021 14:19:38 -0700
Message-Id: <20210518211938.635092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <36760dae-2f61-2072-460a-f8359224fcf1@intel.com>
References: <36760dae-2f61-2072-460a-f8359224fcf1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

KVM hypercalls use the "vmcall" or "vmmcall" instructions.
Although the ABI is similar, those instructions no longer
function for TDX guests. Make vendor-specific TDVMCALLs
instead of VMCALL. This enables TDX guests to run with KVM
acting as the hypervisor. TDX guests running under other
hypervisors will continue to use those hypervisor's
hypercalls.

Since KVM hypercall functions can be included and called
from kernel modules, export tdx_kvm_hypercall*() functions
to avoid symbol errors

[Isaku Yamahata: proposed KVM VENDOR string]
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since RFC v2-fix:
 * Removed "user help" for INTEL_TDX_GUEST_KVM config option
   and added a comment for it.
 * Added details about exporting symbols in the commit log.
 * Removed Isaku's sign-off.

Changes since RFC v2: 
 * Introduced INTEL_TDX_GUEST_KVM config for TDX+KVM related changes.
 * Removed "C" include file.
 * Fixed commit log as per Dave's comments.

 arch/x86/Kconfig                |  5 ++++
 arch/x86/include/asm/kvm_para.h | 21 +++++++++++++++
 arch/x86/include/asm/tdx.h      | 41 ++++++++++++++++++++++++++++
 arch/x86/kernel/Makefile        |  1 +
 arch/x86/kernel/tdcall.S        | 20 ++++++++++++++
 arch/x86/kernel/tdx-kvm.c       | 48 +++++++++++++++++++++++++++++++++
 6 files changed, 136 insertions(+)
 create mode 100644 arch/x86/kernel/tdx-kvm.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9e0e0ff76bab..15e66a99dd41 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -886,6 +886,11 @@ config INTEL_TDX_GUEST
 	  run in a CPU mode that protects the confidentiality of TD memory
 	  contents and the TD’s CPU state from other software, including VMM.
 
+# This option enables KVM specific hypercalls in TDX guest.
+config INTEL_TDX_GUEST_KVM
+	def_bool y
+	depends on KVM_GUEST && INTEL_TDX_GUEST
+
 endif #HYPERVISOR_GUEST
 
 source "arch/x86/Kconfig.cpu"
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
index 8ab4067afefc..eb758b506dba 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -73,4 +73,45 @@ static inline void tdx_early_init(void) { };
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
+#ifdef CONFIG_INTEL_TDX_GUEST_KVM
+u64 __tdx_hypercall_vendor_kvm(u64 fn, u64 r12, u64 r13, u64 r14,
+			       u64 r15, struct tdx_hypercall_output *out);
+long tdx_kvm_hypercall0(unsigned int nr);
+long tdx_kvm_hypercall1(unsigned int nr, unsigned long p1);
+long tdx_kvm_hypercall2(unsigned int nr, unsigned long p1, unsigned long p2);
+long tdx_kvm_hypercall3(unsigned int nr, unsigned long p1, unsigned long p2,
+		unsigned long p3);
+long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1, unsigned long p2,
+		unsigned long p3, unsigned long p4);
+#else
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
+#endif /* CONFIG_INTEL_TDX_GUEST_KVM */
+
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 7966c10ea8d1..a90fec004844 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -128,6 +128,7 @@ obj-$(CONFIG_X86_PMEM_LEGACY_DEVICE) += pmem.o
 
 obj-$(CONFIG_JAILHOUSE_GUEST)	+= jailhouse.o
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdcall.o tdx.o
+obj-$(CONFIG_INTEL_TDX_GUEST_KVM) += tdx-kvm.o
 
 obj-$(CONFIG_EISA)		+= eisa.o
 obj-$(CONFIG_PCSPKR_PLATFORM)	+= pcspeaker.o
diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
index a484c4aef6e6..3c57a1d67b79 100644
--- a/arch/x86/kernel/tdcall.S
+++ b/arch/x86/kernel/tdcall.S
@@ -25,6 +25,8 @@
 					  TDG_R12 | TDG_R13 | \
 					  TDG_R14 | TDG_R15 )
 
+#define TDVMCALL_VENDOR_KVM		0x4d564b2e584454 /* "TDX.KVM" */
+
 /*
  * TDX guests use the TDCALL instruction to make requests to the
  * TDX module and hypercalls to the VMM. It is supported in
@@ -213,3 +215,21 @@ SYM_FUNC_START(__tdx_hypercall)
 	call do_tdx_hypercall
 	retq
 SYM_FUNC_END(__tdx_hypercall)
+
+#ifdef CONFIG_INTEL_TDX_GUEST_KVM
+/*
+ * Helper function for KVM vendor TDVMCALLs. This assembly wrapper
+ * lets us reuse do_tdvmcall() for KVM-specific hypercalls (
+ * TDVMCALL_VENDOR_KVM).
+ */
+SYM_FUNC_START(__tdx_hypercall_vendor_kvm)
+	/*
+	 * R10 is not part of the function call ABI, but it is a part
+	 * of the TDVMCALL ABI. So set it before making call to the
+	 * do_tdx_hypercall().
+	 */
+	movq $TDVMCALL_VENDOR_KVM, %r10
+	call do_tdx_hypercall
+	retq
+SYM_FUNC_END(__tdx_hypercall_vendor_kvm)
+#endif /* CONFIG_INTEL_TDX_GUEST_KVM */
diff --git a/arch/x86/kernel/tdx-kvm.c b/arch/x86/kernel/tdx-kvm.c
new file mode 100644
index 000000000000..b21453a81e38
--- /dev/null
+++ b/arch/x86/kernel/tdx-kvm.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2020 Intel Corporation */
+
+#include <asm/tdx.h>
+
+static long tdx_kvm_hypercall(unsigned int fn, unsigned long r12,
+			      unsigned long r13, unsigned long r14,
+			      unsigned long r15)
+{
+	return __tdx_hypercall_vendor_kvm(fn, r12, r13, r14, r15, NULL);
+}
+
+/* Used by kvm_hypercall0() to trigger hypercall in TDX guest */
+long tdx_kvm_hypercall0(unsigned int nr)
+{
+	return tdx_kvm_hypercall(nr, 0, 0, 0, 0);
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall0);
+
+/* Used by kvm_hypercall1() to trigger hypercall in TDX guest */
+long tdx_kvm_hypercall1(unsigned int nr, unsigned long p1)
+{
+	return tdx_kvm_hypercall(nr, p1, 0, 0, 0);
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall1);
+
+/* Used by kvm_hypercall2() to trigger hypercall in TDX guest */
+long tdx_kvm_hypercall2(unsigned int nr, unsigned long p1, unsigned long p2)
+{
+	return tdx_kvm_hypercall(nr, p1, p2, 0, 0);
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall2);
+
+/* Used by kvm_hypercall3() to trigger hypercall in TDX guest */
+long tdx_kvm_hypercall3(unsigned int nr, unsigned long p1, unsigned long p2,
+		unsigned long p3)
+{
+	return tdx_kvm_hypercall(nr, p1, p2, p3, 0);
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall3);
+
+/* Used by kvm_hypercall4() to trigger hypercall in TDX guest */
+long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1, unsigned long p2,
+		unsigned long p3, unsigned long p4)
+{
+	return tdx_kvm_hypercall(nr, p1, p2, p3, p4);
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall4);
-- 
2.25.1

