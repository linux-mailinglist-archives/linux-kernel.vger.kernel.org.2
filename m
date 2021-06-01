Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DBF397B9B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhFAVQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:16:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:25996 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234707AbhFAVQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:16:33 -0400
IronPort-SDR: ipO4zXYjOCrABzJK2YhCBZe/mVrnyo6i76uNLy6us53OwZ9bGTt4LQkdobFmMHFpTeVSid1pSl
 O0PLJM1YZwrw==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="267517780"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="267517780"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 14:14:49 -0700
IronPort-SDR: t78zm8rcEF5sDShRAySYuIz3k2kbvbDzP9oBnv1bDHwlbucZout0xsr8LnvqGBllPD7fPQJWkz
 9kTNm3hovkHw==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="549191489"
Received: from mjdelaro-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.3.23])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 14:14:45 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest abstraction
Date:   Tue,  1 Jun 2021 14:14:17 -0700
Message-Id: <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic way to check if we run with an encrypted guest,
without requiring x86 specific ifdefs. This can then be used in
non architecture specific code. 

protected_guest_has() is used to check for protected guest
feature flags.

Originally-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
Changes since RFC v2-fix-v1:
 * Changed the title from "tdx: Introduce generic protected_guest
   abstraction" to "x86: Introduce generic protected guest"
 * Removed usage of ARCH_HAS_PROTECTED_GUEST and directly called TDX
   and AMD specific xx_protected_guest_has() variants from
   linux/protected_guest.h.
 * Added support for amd_protected_guest_has() helper function.
 * Removed redundant is_tdx_guest() check in tdx_protected_guest_has()
   function.
 * Fixed commit log to reflect the latest changes.

 arch/x86/include/asm/mem_encrypt.h |  4 +++
 arch/x86/include/asm/tdx.h         |  7 ++++++
 arch/x86/kernel/tdx.c              | 16 ++++++++++++
 arch/x86/mm/mem_encrypt.c          | 13 ++++++++++
 include/linux/protected_guest.h    | 40 ++++++++++++++++++++++++++++++
 5 files changed, 80 insertions(+)
 create mode 100644 include/linux/protected_guest.h

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 9c80c68d75b5..1492b0eb29d0 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -56,6 +56,8 @@ bool sev_es_active(void);
 
 #define __bss_decrypted __section(".bss..decrypted")
 
+bool amd_protected_guest_has(unsigned long flag);
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define sme_me_mask	0ULL
@@ -86,6 +88,8 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 
 static inline void mem_encrypt_free_decrypted_mem(void) { }
 
+static inline bool amd_protected_guest_has(unsigned long flag) { return false; }
+
 #define __bss_decrypted
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index f0c1912837c8..cbfe7479f2a3 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -71,6 +71,8 @@ u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 u64 __tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
 		    struct tdx_hypercall_output *out);
 
+bool tdx_protected_guest_has(unsigned long flag);
+
 #else // !CONFIG_INTEL_TDX_GUEST
 
 static inline bool is_tdx_guest(void)
@@ -80,6 +82,11 @@ static inline bool is_tdx_guest(void)
 
 static inline void tdx_early_init(void) { };
 
+static inline bool tdx_protected_guest_has(unsigned long flag)
+{
+	return false;
+}
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #ifdef CONFIG_INTEL_TDX_GUEST_KVM
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 17725646eb30..b1cdb37a8636 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -7,6 +7,7 @@
 #include <asm/vmx.h>
 
 #include <linux/cpu.h>
+#include <linux/protected_guest.h>
 
 /* TDX Module call Leaf IDs */
 #define TDINFO				1
@@ -75,6 +76,21 @@ bool is_tdx_guest(void)
 }
 EXPORT_SYMBOL_GPL(is_tdx_guest);
 
+bool tdx_protected_guest_has(unsigned long flag)
+{
+	switch (flag) {
+	case VM_MEM_ENCRYPT:
+	case VM_MEM_ENCRYPT_ACTIVE:
+	case VM_UNROLL_STRING_IO:
+	case VM_HOST_MEM_ENCRYPT:
+	case VM_SHARED_MAPPING_INIT:
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(tdx_protected_guest_has);
+
 static void tdg_get_info(void)
 {
 	u64 ret;
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index ff08dc463634..7019eab20096 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -20,6 +20,7 @@
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
 #include <linux/virtio_config.h>
+#include <linux/protected_guest.h>
 
 #include <asm/tlbflush.h>
 #include <asm/fixmap.h>
@@ -389,6 +390,18 @@ bool noinstr sev_es_active(void)
 	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 }
 
+bool amd_protected_guest_has(unsigned long flag)
+{
+	switch (flag) {
+	case VM_MEM_ENCRYPT:
+	case VM_MEM_ENCRYPT_ACTIVE:
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(amd_protected_guest_has);
+
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
 {
diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
new file mode 100644
index 000000000000..303dfba81d52
--- /dev/null
+++ b/include/linux/protected_guest.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_PROTECTED_GUEST_H
+#define _LINUX_PROTECTED_GUEST_H 1
+
+#include <linux/mem_encrypt.h>
+
+/* Protected Guest Feature Flags (leave 0-0xff for arch specific flags) */
+
+/* Support for guest encryption */
+#define VM_MEM_ENCRYPT			0x100
+/* Encryption support is active */
+#define VM_MEM_ENCRYPT_ACTIVE		0x101
+/* Support for unrolled string IO */
+#define VM_UNROLL_STRING_IO		0x102
+/* Support for host memory encryption */
+#define VM_HOST_MEM_ENCRYPT		0x103
+/* Support for shared mapping initialization (after early init) */
+#define VM_SHARED_MAPPING_INIT		0x104
+
+#if defined(CONFIG_INTEL_TDX_GUEST) || defined(CONFIG_AMD_MEM_ENCRYPT)
+
+#include <asm/tdx.h>
+
+static inline bool protected_guest_has(unsigned long flag)
+{
+	if (is_tdx_guest())
+		return tdx_protected_guest_has(flag);
+	else if (mem_encrypt_active())
+		return amd_protected_guest_has(flag);
+
+	return false;
+}
+
+#else
+
+static inline bool protected_guest_has(unsigned long flag) { return false; }
+
+#endif
+
+#endif
-- 
2.25.1

