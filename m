Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850833AD596
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 00:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbhFRXBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 19:01:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:13197 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235189AbhFRXAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 19:00:54 -0400
IronPort-SDR: bSXpas64B00/sZNL1cSlk9rOwX632yADVOLGjwLOeoTeEhlvJAHe+DF6YWjnYEEMt64B9vbHTs
 avggvE62v6iA==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="193763421"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="193763421"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 15:58:44 -0700
IronPort-SDR: aYoiG4H0jlH4FpRiooiG9CrkQXBUOzgqvJQ6sPzrHGVs6hxtDAX0dox0BNffoKmWXSVKie2fMR
 VPpN7vR3sQZg==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="554874193"
Received: from shahdhav-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.6.127])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 15:58:43 -0700
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
Subject: [PATCH v3 09/11] x86/tdx: Wire up KVM hypercalls
Date:   Fri, 18 Jun 2021 15:57:53 -0700
Message-Id: <20210618225755.662725-10-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
 * Removed __tdx_hypercall_vendor_kvm() and re-used __tdx_hypercall().

 arch/x86/Kconfig                |  5 +++++
 arch/x86/include/asm/kvm_para.h | 22 ++++++++++++++++++++++
 arch/x86/include/asm/tdx.h      | 30 ++++++++++++++++++++++++++++--
 arch/x86/kernel/tdcall.S        |  2 ++
 4 files changed, 57 insertions(+), 2 deletions(-)

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
index 69299878b200..bc0e70734053 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -4,7 +4,9 @@
 
 #include <asm/processor.h>
 #include <asm/alternative.h>
+#include <asm/tdx.h>
 #include <linux/interrupt.h>
+#include <linux/protected_guest.h>
 #include <uapi/asm/kvm_para.h>
 
 #ifdef CONFIG_KVM_GUEST
@@ -32,6 +34,10 @@ static inline bool kvm_check_and_clear_guest_paused(void)
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
@@ -42,6 +48,10 @@ static inline long kvm_hypercall0(unsigned int nr)
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
@@ -53,6 +63,10 @@ static inline long kvm_hypercall2(unsigned int nr, unsigned long p1,
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
@@ -64,6 +78,10 @@ static inline long kvm_hypercall3(unsigned int nr, unsigned long p1,
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
@@ -76,6 +94,10 @@ static inline long kvm_hypercall4(unsigned int nr, unsigned long p1,
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
index 5b07f01a0f99..f9d8c2036348 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -6,8 +6,9 @@
 #include <linux/cpufeature.h>
 #include <linux/types.h>
 
-#define TDX_CPUID_LEAF_ID	0x21
-#define TDX_HYPERCALL_STANDARD  0
+#define TDX_CPUID_LEAF_ID			0x21
+#define TDX_HYPERCALL_STANDARD			0
+#define TDX_HYPERCALL_VENDOR_KVM		0x4d564b2e584454
 
 /*
  * Used in __tdx_module_call() helper function to gather the
@@ -80,4 +81,29 @@ static inline bool tdx_protected_guest_has(unsigned long flag) { return false; }
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
+#ifdef CONFIG_INTEL_TDX_GUEST_KVM
+
+static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
+				     unsigned long p2, unsigned long p3,
+				     unsigned long p4)
+{
+	struct tdx_hypercall_output out;
+	u64 err;
+
+	err = __tdx_hypercall(TDX_HYPERCALL_VENDOR_KVM, nr, p1, p2,
+			      p3, p4, &out);
+
+	BUG_ON(err);
+
+	return out.r10;
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
index 3cf1d1af7889..0c7739559b05 100644
--- a/arch/x86/kernel/tdcall.S
+++ b/arch/x86/kernel/tdcall.S
@@ -3,6 +3,7 @@
 #include <asm/asm.h>
 #include <asm/frame.h>
 #include <asm/unwind_hints.h>
+#include <asm/export.h>
 
 #include <linux/linkage.h>
 #include <linux/bits.h>
@@ -279,3 +280,4 @@ SYM_FUNC_START(__tdx_hypercall)
 
        retq
 SYM_FUNC_END(__tdx_hypercall)
+EXPORT_SYMBOL(__tdx_hypercall);
-- 
2.25.1

