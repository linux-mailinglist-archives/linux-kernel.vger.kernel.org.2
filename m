Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703613A50C2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 23:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhFLVKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 17:10:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:4813 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhFLVKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 17:10:13 -0400
IronPort-SDR: 0neGMO3e18bLcAdL2InHI6aoxR2TwPXX/p/gilfwT6i5TI6pAuqTnhcSHFO5NbdK/yaajPO+GE
 8DVbqybfK2uA==
X-IronPort-AV: E=McAfee;i="6200,9189,10013"; a="185374068"
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="185374068"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2021 14:08:13 -0700
IronPort-SDR: LfhS9chPiX3yGk9Ef8BkAlXTIVrGajpE/XkWh/otUly7u+xxvzHa6cV5rChISujGcNI/tkyu/2
 KjwnKxMaZrJw==
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="449468367"
Received: from rong2-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.36.179])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2021 14:08:11 -0700
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
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/12] x86/tdx: Wire up KVM hypercalls
Date:   Sat, 12 Jun 2021 14:08:07 -0700
Message-Id: <20210612210807.2165241-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602022136.2186759-10-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210602022136.2186759-10-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Changes since v1:
 * Replaced is_tdx_guest() with prot_guest_has(PR_GUEST_TDX).
 * Replaced tdx_kvm_hypercall{1-4} with single generic 
   function tdx_kvm_hypercall().

 arch/x86/Kconfig                |  5 +++++
 arch/x86/include/asm/kvm_para.h | 21 +++++++++++++++++++++
 arch/x86/include/asm/tdx.h      | 19 +++++++++++++++++++
 arch/x86/kernel/tdcall.S        | 26 ++++++++++++++++++++++++++
 4 files changed, 71 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d506aae29dd9..fc51579e54ad 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -892,6 +892,11 @@ config INTEL_TDX_GUEST
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
index 69299878b200..00cf96de04a0 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -5,6 +5,7 @@
 #include <asm/processor.h>
 #include <asm/alternative.h>
 #include <linux/interrupt.h>
+#include <linux/protected_guest.h>
 #include <uapi/asm/kvm_para.h>
 
 #ifdef CONFIG_KVM_GUEST
@@ -32,6 +33,10 @@ static inline bool kvm_check_and_clear_guest_paused(void)
 static inline long kvm_hypercall0(unsigned int nr)
 {
 	long ret;
+
+	if (prot_guest_has(PR_GUEST_TDX))
+		return tdx_kvm_hypercall(nr, 0, 0, 0, 0);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr)
@@ -42,6 +47,10 @@ static inline long kvm_hypercall0(unsigned int nr)
 static inline long kvm_hypercall1(unsigned int nr, unsigned long p1)
 {
 	long ret;
+
+	if (prot_guest_has(PR_GUEST_TDX))
+		return tdx_kvm_hypercall(nr, p1, 0, 0, 0);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr), "b"(p1)
@@ -53,6 +62,10 @@ static inline long kvm_hypercall2(unsigned int nr, unsigned long p1,
 				  unsigned long p2)
 {
 	long ret;
+
+	if (prot_guest_has(PR_GUEST_TDX))
+		return tdx_kvm_hypercall(nr, p1, p2, 0, 0);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr), "b"(p1), "c"(p2)
@@ -64,6 +77,10 @@ static inline long kvm_hypercall3(unsigned int nr, unsigned long p1,
 				  unsigned long p2, unsigned long p3)
 {
 	long ret;
+
+	if (prot_guest_has(PR_GUEST_TDX))
+		return tdx_kvm_hypercall(nr, p1, p2, p3, 0);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr), "b"(p1), "c"(p2), "d"(p3)
@@ -76,6 +93,10 @@ static inline long kvm_hypercall4(unsigned int nr, unsigned long p1,
 				  unsigned long p4)
 {
 	long ret;
+
+	if (prot_guest_has(PR_GUEST_TDX))
+		return tdx_kvm_hypercall(nr, p1, p2, p3, p4);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr), "b"(p1), "c"(p2), "d"(p3), "S"(p4)
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 504291a57d48..7076f9c6dbd3 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -78,4 +78,23 @@ static inline bool tdx_protected_guest_has(unsigned long flag) { return false; }
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
+#ifdef CONFIG_INTEL_TDX_GUEST_KVM
+u64 __tdx_hypercall_vendor_kvm(u64 fn, u64 r12, u64 r13, u64 r14,
+			       u64 r15, struct tdx_hypercall_output *out);
+
+static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
+				      unsigned long p2, unsigned long p3,
+				      unsigned long p4)
+{
+	return __tdx_hypercall_vendor_kvm(nr, p1, p2, p3, p4, NULL);
+}
+#else
+static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
+				     unsigned long p2, unsigned long p3,
+				     unsigned long p4)
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

