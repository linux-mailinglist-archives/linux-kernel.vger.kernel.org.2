Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36634397EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 04:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhFBCYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:24:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:39490 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhFBCXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:23:34 -0400
IronPort-SDR: MXSiIyTbo/lGQ0IUhLiZxV4658wlRvWc/Wm3+KoM53uKnYaB2mSDiTwlEW4IJXtkQs/j6ohek5
 sVTxa7YKhQHg==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="191037605"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="191037605"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 19:21:51 -0700
IronPort-SDR: krTOSglGUpSMmDSYDQM51LlAf6DwJD4USLejVGam1Lr4CSjN7V7dps7hbe4f8IR20IICRbUYla
 eLqAl1B11/LQ==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="633069237"
Received: from mjdelaro-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.3.23])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 19:21:50 -0700
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v1 09/11] x86/tdx: Wire up KVM hypercalls
Date:   Tue,  1 Jun 2021 19:21:34 -0700
Message-Id: <20210602022136.2186759-10-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
hypervisors will continue to use those hypervisors'
hypercalls.

Since KVM driver can be built as a kernel module, export
tdx_kvm_hypercall*() to make the symbols visible to kvm.ko.

[Isaku Yamahata: proposed KVM VENDOR string]
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/Kconfig                |  5 +++
 arch/x86/include/asm/kvm_para.h | 21 ++++++++++
 arch/x86/include/asm/tdx.h      | 68 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/tdcall.S        | 26 +++++++++++++
 4 files changed, 120 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ff79263aebd1..a99adc683db9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -891,6 +891,11 @@ config INTEL_TDX_GUEST
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
index 69299878b200..9700f70300c9 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -6,6 +6,7 @@
 #include <asm/alternative.h>
 #include <linux/interrupt.h>
 #include <uapi/asm/kvm_para.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_KVM_GUEST
 bool kvm_check_and_clear_guest_paused(void);
@@ -32,6 +33,10 @@ static inline bool kvm_check_and_clear_guest_paused(void)
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
@@ -42,6 +47,10 @@ static inline long kvm_hypercall0(unsigned int nr)
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
@@ -53,6 +62,10 @@ static inline long kvm_hypercall2(unsigned int nr, unsigned long p1,
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
@@ -64,6 +77,10 @@ static inline long kvm_hypercall3(unsigned int nr, unsigned long p1,
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
@@ -76,6 +93,10 @@ static inline long kvm_hypercall4(unsigned int nr, unsigned long p1,
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
index f00008cf1361..f0c1912837c8 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -82,4 +82,72 @@ static inline void tdx_early_init(void) { };
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
+#ifdef CONFIG_INTEL_TDX_GUEST_KVM
+u64 __tdx_hypercall_vendor_kvm(u64 fn, u64 r12, u64 r13, u64 r14,
+			       u64 r15, struct tdx_hypercall_output *out);
+
+/* Used by kvm_hypercall0() to trigger hypercall in TDX guest */
+static inline long tdx_kvm_hypercall0(unsigned int nr)
+{
+	return __tdx_hypercall_vendor_kvm(nr, 0, 0, 0, 0, NULL);
+}
+
+/* Used by kvm_hypercall1() to trigger hypercall in TDX guest */
+static inline long tdx_kvm_hypercall1(unsigned int nr, unsigned long p1)
+{
+	return __tdx_hypercall_vendor_kvm(nr, p1, 0, 0, 0, NULL);
+}
+
+/* Used by kvm_hypercall2() to trigger hypercall in TDX guest */
+static inline long tdx_kvm_hypercall2(unsigned int nr, unsigned long p1,
+				      unsigned long p2)
+{
+	return __tdx_hypercall_vendor_kvm(nr, p1, p2, 0, 0, NULL);
+}
+
+/* Used by kvm_hypercall3() to trigger hypercall in TDX guest */
+static inline long tdx_kvm_hypercall3(unsigned int nr, unsigned long p1,
+				      unsigned long p2, unsigned long p3)
+{
+	return __tdx_hypercall_vendor_kvm(nr, p1, p2, p3, 0, NULL);
+}
+
+/* Used by kvm_hypercall4() to trigger hypercall in TDX guest */
+static inline long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1,
+				      unsigned long p2, unsigned long p3,
+				      unsigned long p4)
+{
+	return __tdx_hypercall_vendor_kvm(nr, p1, p2, p3, p4, NULL);
+}
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
diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
index d95af4486155..289d7fab5b4a 100644
--- a/arch/x86/kernel/tdcall.S
+++ b/arch/x86/kernel/tdcall.S
@@ -3,6 +3,7 @@
 #include <asm/asm.h>
 #include <asm/frame.h>
 #include <asm/unwind_hints.h>
+#include <asm/export.h>
 
 #include <linux/linkage.h>
 #include <linux/bits.h>
@@ -25,6 +26,8 @@
 					  TDG_R12 | TDG_R13 | \
 					  TDG_R14 | TDG_R15 )
 
+#define TDVMCALL_VENDOR_KVM		0x4d564b2e584454 /* "TDX.KVM" */
+
 /*
  * TDX guests use the TDCALL instruction to make requests to the
  * TDX module and hypercalls to the VMM. It is supported in
@@ -226,3 +229,26 @@ SYM_FUNC_START(__tdx_hypercall)
 	FRAME_END
 	retq
 SYM_FUNC_END(__tdx_hypercall)
+
+#ifdef CONFIG_INTEL_TDX_GUEST_KVM
+
+/*
+ * Helper function for KVM vendor TDVMCALLs. This assembly wrapper
+ * lets us reuse do_tdvmcall() for KVM-specific hypercalls (
+ * TDVMCALL_VENDOR_KVM).
+ */
+SYM_FUNC_START(__tdx_hypercall_vendor_kvm)
+	FRAME_BEGIN
+	/*
+	 * R10 is not part of the function call ABI, but it is a part
+	 * of the TDVMCALL ABI. So set it before making call to the
+	 * do_tdx_hypercall().
+	 */
+	movq $TDVMCALL_VENDOR_KVM, %r10
+	call do_tdx_hypercall
+	FRAME_END
+	retq
+SYM_FUNC_END(__tdx_hypercall_vendor_kvm)
+
+EXPORT_SYMBOL(__tdx_hypercall_vendor_kvm);
+#endif /* CONFIG_INTEL_TDX_GUEST_KVM */
-- 
2.25.1

