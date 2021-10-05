Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F483421CB6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 04:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhJECyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 22:54:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:43315 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231483AbhJECyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 22:54:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="248894656"
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="248894656"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 19:52:31 -0700
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="483409126"
Received: from asaini1-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.96])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 19:52:30 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 08/11] x86/tdx: Wire up KVM hypercalls
Date:   Mon,  4 Oct 2021 19:52:02 -0700
Message-Id: <20211005025205.1784480-9-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

KVM hypercalls use the VMCALL or VMMCALL instructions. Although the ABI
is similar, those instructions no longer function for TDX guests. Make
vendor-specific TDVMCALLs instead of VMCALL. This enables TDX guests to
run with KVM acting as the hypervisor. TDX guests running under other
hypervisors will continue to use those hypervisors' hypercalls.

Since KVM driver can be built as a kernel module, export
tdx_kvm_hypercall*() to make the symbols visible to kvm.ko.

Also, add asm/tdx.h to asm/asm-prototypes.h so that asm symbol's
checksum can be generated in order to support CONFIG_MODVERSIONS with
it and fix:

WARNING: modpost: EXPORT symbol "__tdx_hypercall" [vmlinux] version \
generation failed, symbol will not be versioned.

[Isaku Yamahata: proposed KVM VENDOR string]
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v7:
 * None

Changes since v6:
 * Used cc_platform_has() in place of prot_guest_has().

Changes since v5:
 * Added more info about version generation failed error in commit
   log.
 * Fixed commit log as per review comments.
 * Removed CONFIG_INTEL_TDX_GUEST_KVM and used
   CONFIG_KVM_GUEST/CONFIG_INTEL_TDX_GUEST for TDX KVM hypercall
   implementation.
 * Used EXPORT_SYMBOL_GPL for __tdx_hypercall() export.

Changes since v4:
 * No functional changes.

Changes since v3:
 * Fixed ASM sysmbol generation issue in tdcall.S by including tdx.h
   in asm-prototypes.h

Changes since v1:
 * Replaced is_tdx_guest() with prot_guest_has(PR_GUEST_TDX).
 * Replaced tdx_kvm_hypercall{1-4} with single generic 
   function tdx_kvm_hypercall().
 * Removed __tdx_hypercall_vendor_kvm() and re-used __tdx_hypercall().

 arch/x86/include/asm/asm-prototypes.h |  1 +
 arch/x86/include/asm/kvm_para.h       | 22 ++++++++++++++++++
 arch/x86/include/asm/tdx.h            | 32 +++++++++++++++++++++++++--
 arch/x86/kernel/tdcall.S              |  2 ++
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 4cb726c71ed8..404add7ee720 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -6,6 +6,7 @@
 #include <asm/page.h>
 #include <asm/checksum.h>
 #include <asm/mce.h>
+#include <asm/tdx.h>
 
 #include <asm-generic/asm-prototypes.h>
 
diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 69299878b200..e51977e77590 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -4,7 +4,9 @@
 
 #include <asm/processor.h>
 #include <asm/alternative.h>
+#include <asm/tdx.h>
 #include <linux/interrupt.h>
+#include <linux/cc_platform.h>
 #include <uapi/asm/kvm_para.h>
 
 #ifdef CONFIG_KVM_GUEST
@@ -32,6 +34,10 @@ static inline bool kvm_check_and_clear_guest_paused(void)
 static inline long kvm_hypercall0(unsigned int nr)
 {
 	long ret;
+
+	if (cc_platform_has(CC_ATTR_GUEST_TDX))
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
+	if (cc_platform_has(CC_ATTR_GUEST_TDX))
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
+	if (cc_platform_has(CC_ATTR_GUEST_TDX))
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
+	if (cc_platform_has(CC_ATTR_GUEST_TDX))
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
+	if (cc_platform_has(CC_ATTR_GUEST_TDX))
+		return tdx_kvm_hypercall(nr, p1, p2, p3, p4);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr), "b"(p1), "c"(p2), "d"(p3), "S"(p4)
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 458a564dd4c2..ebb97e082376 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -6,8 +6,9 @@
 #include <linux/cpufeature.h>
 #include <linux/types.h>
 
-#define TDX_CPUID_LEAF_ID	0x21
-#define TDX_HYPERCALL_STANDARD  0
+#define TDX_CPUID_LEAF_ID			0x21
+#define TDX_HYPERCALL_STANDARD			0
+#define TDX_HYPERCALL_VENDOR_KVM		0x4d564b2e584454 /* TDX.KVM */
 
 /*
  * Used in __tdx_module_call() helper function to gather the
@@ -78,4 +79,31 @@ static inline void tdx_early_init(void) { };
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
+#if defined(CONFIG_KVM_GUEST) && defined(CONFIG_INTEL_TDX_GUEST)
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
+	/*
+	 * Non zero return value means buggy TDX module (which is fatal).
+	 * So use BUG_ON() to panic.
+	 */
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
+#endif /* CONFIG_INTEL_TDX_GUEST && CONFIG_KVM_GUEST */
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
index 1b9649ec2e29..fa87f5e2cf29 100644
--- a/arch/x86/kernel/tdcall.S
+++ b/arch/x86/kernel/tdcall.S
@@ -3,6 +3,7 @@
 #include <asm/asm.h>
 #include <asm/frame.h>
 #include <asm/unwind_hints.h>
+#include <asm/export.h>
 
 #include <linux/linkage.h>
 #include <linux/bits.h>
@@ -310,3 +311,4 @@ skip_sti:
 
        retq
 SYM_FUNC_END(__tdx_hypercall)
+EXPORT_SYMBOL_GPL(__tdx_hypercall);
-- 
2.25.1

