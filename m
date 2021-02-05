Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFE9311B06
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhBFEml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:42:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:63384 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231307AbhBFDWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:22:52 -0500
IronPort-SDR: muj7LkkQR7UJOrldMNtAzswEWJDJpv1sAWGlaw/yS+7KNPnJR9Nh6BuOOcHJseldv6AK+Rue/n
 rZ69Cji5cg1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650719"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650719"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:07 -0800
IronPort-SDR: B2kBhUCsclxf2LUKfbYl1v4x1A4kJ4wcL7IgalnAzMDruwg7SgA8o74fGN5c02dinRNT0IKEd9
 QNAt5S7xjzCg==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183885"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:06 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v1 07/26] x86/tdx: Wire up KVM hypercalls
Date:   Fri,  5 Feb 2021 15:38:24 -0800
Message-Id: <00133f56a5fd5796571065f4add3e0b1481e2dff.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

KVM hypercalls have to be wrapped into vendor-specific TDVMCALLs.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/kvm_para.h |  21 ++++++
 arch/x86/include/asm/tdx.h      |   8 +++
 arch/x86/kernel/tdx-kvm.c       | 116 ++++++++++++++++++++++++++++++++
 arch/x86/kernel/tdx.c           |   4 ++
 4 files changed, 149 insertions(+)
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
index b98de067257b..8c3e5af88643 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -51,4 +51,12 @@ unsigned long tdx_get_ve_info(struct ve_info *ve);
 int tdx_handle_virtualization_exception(struct pt_regs *regs,
 		struct ve_info *ve);
 
+long tdx_kvm_hypercall0(unsigned int nr);
+long tdx_kvm_hypercall1(unsigned int nr, unsigned long p1);
+long tdx_kvm_hypercall2(unsigned int nr, unsigned long p1, unsigned long p2);
+long tdx_kvm_hypercall3(unsigned int nr, unsigned long p1, unsigned long p2,
+		unsigned long p3);
+long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1, unsigned long p2,
+		unsigned long p3, unsigned long p4);
+
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/tdx-kvm.c b/arch/x86/kernel/tdx-kvm.c
new file mode 100644
index 000000000000..323d43fcb338
--- /dev/null
+++ b/arch/x86/kernel/tdx-kvm.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+long tdx_kvm_hypercall0(unsigned int nr)
+{
+	register long r10 asm("r10") = TDVMCALL_VENDOR;
+	register long r11 asm("r11") = nr;
+	register long rcx asm("rcx");
+	long ret;
+
+	/* Allow to pass R10 and R11 down to the VMM */
+	rcx = BIT(10) | BIT(11);
+
+	asm volatile(TDCALL
+			: "=a"(ret), "=r"(r10)
+			: "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11)
+			: "memory");
+
+	BUG_ON(ret);
+	return r10;
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall0);
+
+long tdx_kvm_hypercall1(unsigned int nr, unsigned long p1)
+{
+	register long r10 asm("r10") = TDVMCALL_VENDOR;
+	register long r11 asm("r11") = nr;
+	register long r12 asm("r12") = p1;
+	register long rcx asm("rcx");
+	long ret;
+
+	/* Allow to pass R10, R11 and R12 down to the VMM */
+	rcx = BIT(10) | BIT(11) | BIT(12);
+
+	asm volatile(TDCALL
+			: "=a"(ret), "=r"(r10)
+			: "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11), "r"(r12)
+			: "memory");
+
+	BUG_ON(ret);
+	return r10;
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall1);
+
+long tdx_kvm_hypercall2(unsigned int nr, unsigned long p1, unsigned long p2)
+{
+	register long r10 asm("r10") = TDVMCALL_VENDOR;
+	register long r11 asm("r11") = nr;
+	register long r12 asm("r12") = p1;
+	register long r13 asm("r13") = p2;
+	register long rcx asm("rcx");
+	long ret;
+
+	/* Allow to pass R10, R11, R12 and R13 down to the VMM */
+	rcx = BIT(10) | BIT(11) | BIT(12) | BIT(13);
+
+	asm volatile(TDCALL
+			: "=a"(ret), "=r"(r10)
+			: "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11), "r"(r12),
+			  "r"(r13)
+			: "memory");
+
+	BUG_ON(ret);
+	return r10;
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall2);
+
+long tdx_kvm_hypercall3(unsigned int nr, unsigned long p1, unsigned long p2,
+		unsigned long p3)
+{
+	register long r10 asm("r10") = TDVMCALL_VENDOR;
+	register long r11 asm("r11") = nr;
+	register long r12 asm("r12") = p1;
+	register long r13 asm("r13") = p2;
+	register long r14 asm("r14") = p3;
+	register long rcx asm("rcx");
+	long ret;
+
+	/* Allow to pass R10, R11, R12, R13 and R14 down to the VMM */
+	rcx = BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(14);
+
+	asm volatile(TDCALL
+			: "=a"(ret), "=r"(r10)
+			: "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11), "r"(r12),
+			  "r"(r13), "r"(r14)
+			: "memory");
+
+	BUG_ON(ret);
+	return r10;
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall3);
+
+long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1, unsigned long p2,
+		unsigned long p3, unsigned long p4)
+{
+	register long r10 asm("r10") = TDVMCALL_VENDOR;
+	register long r11 asm("r11") = nr;
+	register long r12 asm("r12") = p1;
+	register long r13 asm("r13") = p2;
+	register long r14 asm("r14") = p3;
+	register long r15 asm("r15") = p4;
+	register long rcx asm("rcx");
+	long ret;
+
+	/* Allow to pass R10, R11, R12, R13, R14 and R15 down to the VMM */
+	rcx = BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(14) | BIT(15);
+
+	asm volatile(TDCALL
+			: "=a"(ret), "=r"(r10)
+			: "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11), "r"(r12),
+			  "r"(r13), "r"(r14), "r"(r15)
+			: "memory");
+
+	BUG_ON(ret);
+	return r10;
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall4);
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 25dd33bc2e49..bbefe639a2ed 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -7,6 +7,10 @@
 #include <asm/tdx.h>
 #include <asm/vmx.h>
 
+#ifdef CONFIG_KVM_GUEST
+#include "tdx-kvm.c"
+#endif
+
 static struct {
 	unsigned int gpa_width;
 	unsigned long attributes;
-- 
2.25.1

