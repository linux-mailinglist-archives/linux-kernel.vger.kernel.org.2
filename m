Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88023CF116
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 03:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353436AbhGTAZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 20:25:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:28522 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242632AbhGTALV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 20:11:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="191435157"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="191435157"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 17:42:13 -0700
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="660970675"
Received: from ywei11-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 17:42:12 -0700
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
Subject: [PATCH v4 09/11] x86/tdx: Wire up KVM hypercalls
Date:   Mon, 19 Jul 2021 17:40:55 -0700
Message-Id: <20210720004057.2112666-10-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720004057.2112666-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210720004057.2112666-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v3:
 * Fixed ASM sysmbol generation issue in tdcall.S by including tdx.h
   in asm-prototypes.h

Changes since v1:
 * Replaced is_tdx_guest() with prot_guest_has(PR_GUEST_TDX).
 * Replaced tdx_kvm_hypercall{1-4} with single generic 
   function tdx_kvm_hypercall().
 * Removed __tdx_hypercall_vendor_kvm() and re-used __tdx_hypercall().

 arch/x86/Kconfig                      |  5 +++++
 arch/x86/include/asm/asm-prototypes.h |  4 ++++
 arch/x86/include/asm/kvm_para.h       | 22 ++++++++++++++++++++
 arch/x86/include/asm/tdx.h            | 30 +++++++++++++++++++++++++--
 arch/x86/kernel/tdcall.S              |  2 ++
 5 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 151d946da1a6..ac5eef3bba16 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -881,6 +881,11 @@ config INTEL_TDX_GUEST
 	  run in a CPU mode that protects the confidentiality of TD memory
 	  contents and the TD’s CPU state from other software, including VMM.
 
+# This option enables KVM specific hypercalls in TDX guest.
+config INTEL_TDX_GUEST_KVM
+	def_bool y
+	depends on KVM_GUEST && INTEL_TDX_GUEST
+
 endif #HYPERVISOR_GUEST
 
 source "arch/x86/Kconfig.cpu"
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 4cb726c71ed8..9855a9ff2924 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -17,6 +17,10 @@
 extern void cmpxchg8b_emu(void);
 #endif
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+#include <asm/tdx.h>
+#endif
+
 #ifdef CONFIG_RETPOLINE
 
 #undef GEN
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
index 846fe58f0426..8fa33e2c98db 100644
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
@@ -80,4 +81,29 @@ static inline bool tdx_prot_guest_has(unsigned long flag) { return false; }
 
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
index c9c91c1bf99d..5c4a39d03731 100644
--- a/arch/x86/kernel/tdcall.S
+++ b/arch/x86/kernel/tdcall.S
@@ -3,6 +3,7 @@
 #include <asm/asm.h>
 #include <asm/frame.h>
 #include <asm/unwind_hints.h>
+#include <asm/export.h>
 
 #include <linux/linkage.h>
 #include <linux/bits.h>
@@ -280,3 +281,4 @@ SYM_FUNC_START(__tdx_hypercall)
 
        retq
 SYM_FUNC_END(__tdx_hypercall)
+EXPORT_SYMBOL(__tdx_hypercall);
-- 
2.25.1

