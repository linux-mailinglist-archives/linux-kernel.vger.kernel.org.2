Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D4F3A1F4C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFIVs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:48:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:4881 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230254AbhFIVsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:48:18 -0400
IronPort-SDR: 587yZlk2v+K2Lvpbij+5LfvdSrJiew24y4t7Nlte15e4TNkv9Mn75PGb3xR8ykNbSef46ov8ms
 t0fFuQ7nilKA==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="266330409"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="266330409"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:46:22 -0700
IronPort-SDR: 17gORnYRHlmbp9XmhtSvizn1o5jUcVmfGXBg20+MuJs1vk8UZn45x9sqld+6r+ajn4aL1muZFF
 QThjnbt8lvEw==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="448450481"
Received: from qwang4-mobl1.ccr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.35.228])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:46:21 -0700
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
Subject: [PATCH v1 01/10] x86: Introduce generic protected guest abstraction
Date:   Wed,  9 Jun 2021 14:45:46 -0700
Message-Id: <20210609214555.1955404-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609214555.1955404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210609214555.1955404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic way to check if we run with an encrypted guest,
without requiring x86 specific ifdefs. This can then be used in
non architecture specific code. 

prot_guest_has() is used to check for protected guest feature
flags.

Originally-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/Kconfig                           |  3 +++
 arch/x86/Kconfig                       |  2 ++
 arch/x86/include/asm/protected_guest.h | 20 ++++++++++++++++++++
 arch/x86/include/asm/sev.h             |  3 +++
 arch/x86/include/asm/tdx.h             |  7 +++++++
 arch/x86/kernel/sev.c                  | 15 +++++++++++++++
 arch/x86/kernel/tdx.c                  | 15 +++++++++++++++
 arch/x86/mm/mem_encrypt.c              |  1 +
 include/linux/protected_guest.h        | 24 ++++++++++++++++++++++++
 9 files changed, 90 insertions(+)
 create mode 100644 arch/x86/include/asm/protected_guest.h
 create mode 100644 include/linux/protected_guest.h

diff --git a/arch/Kconfig b/arch/Kconfig
index c45b770d3579..3c5bf55ee752 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1011,6 +1011,9 @@ config HAVE_ARCH_NVRAM_OPS
 config ISA_BUS_API
 	def_bool ISA
 
+config ARCH_HAS_PROTECTED_GUEST
+	bool
+
 #
 # ABI hall of shame
 #
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a99adc683db9..fc51579e54ad 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -883,6 +883,7 @@ config INTEL_TDX_GUEST
 	select PARAVIRT_XL
 	select X86_X2APIC
 	select SECURITY_LOCKDOWN_LSM
+	select ARCH_HAS_PROTECTED_GUEST
 	help
 	  Provide support for running in a trusted domain on Intel processors
 	  equipped with Trusted Domain eXtenstions. TDX is a new Intel
@@ -1544,6 +1545,7 @@ config AMD_MEM_ENCRYPT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select INSTRUCTION_DECODER
 	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
+	select ARCH_HAS_PROTECTED_GUEST
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
new file mode 100644
index 000000000000..137976ef894a
--- /dev/null
+++ b/arch/x86/include/asm/protected_guest.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2020 Intel Corporation */
+#ifndef _ASM_PROTECTED_GUEST_H
+#define _ASM_PROTECTED_GUEST_H 1
+
+#include <asm/processor.h>
+#include <asm/tdx.h>
+#include <asm/sev.h>
+
+static inline bool prot_guest_has(unsigned long flag)
+{
+	if (is_tdx_guest())
+		return tdx_protected_guest_has(flag);
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return sev_protected_guest_has(flag);
+
+	return false;
+}
+
+#endif /* _ASM_PROTECTED_GUEST_H */
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index fa5cd05d3b5b..e9b0b93a3157 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -81,12 +81,15 @@ static __always_inline void sev_es_nmi_complete(void)
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
+bool sev_protected_guest_has(unsigned long flag);
+
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
+static inline bool sev_protected_guest_has(unsigned long flag) { return false; }
 #endif
 
 #endif
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
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 651b81cd648e..16e5c5f25e6f 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -19,6 +19,7 @@
 #include <linux/memblock.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/protected_guest.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -1493,3 +1494,17 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 	while (true)
 		halt();
 }
+
+bool sev_protected_guest_has(unsigned long flag)
+{
+	switch (flag) {
+	case PR_GUEST_MEM_ENCRYPT:
+	case PR_GUEST_MEM_ENCRYPT_ACTIVE:
+	case PR_GUEST_UNROLL_STRING_IO:
+	case PR_GUEST_HOST_MEM_ENCRYPT:
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(sev_protected_guest_has);
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 17725646eb30..111f15c05e24 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -7,6 +7,7 @@
 #include <asm/vmx.h>
 
 #include <linux/cpu.h>
+#include <linux/protected_guest.h>
 
 /* TDX Module call Leaf IDs */
 #define TDINFO				1
@@ -75,6 +76,20 @@ bool is_tdx_guest(void)
 }
 EXPORT_SYMBOL_GPL(is_tdx_guest);
 
+bool tdx_protected_guest_has(unsigned long flag)
+{
+	switch (flag) {
+	case PR_GUEST_MEM_ENCRYPT:
+	case PR_GUEST_MEM_ENCRYPT_ACTIVE:
+	case PR_GUEST_UNROLL_STRING_IO:
+	case PR_GUEST_SHARED_MAPPING_INIT:
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
index ff08dc463634..d0026bce47df 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -20,6 +20,7 @@
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
 #include <linux/virtio_config.h>
+#include <linux/protected_guest.h>
 
 #include <asm/tlbflush.h>
 #include <asm/fixmap.h>
diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
new file mode 100644
index 000000000000..0facb8547217
--- /dev/null
+++ b/include/linux/protected_guest.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_PROTECTED_GUEST_H
+#define _LINUX_PROTECTED_GUEST_H 1
+
+/* Protected Guest Feature Flags (leave 0-0xff for arch specific flags) */
+
+/* Support for guest encryption */
+#define PR_GUEST_MEM_ENCRYPT			0x100
+/* Encryption support is active */
+#define PR_GUEST_MEM_ENCRYPT_ACTIVE		0x101
+/* Support for unrolled string IO */
+#define PR_GUEST_UNROLL_STRING_IO		0x102
+/* Support for host memory encryption */
+#define PR_GUEST_HOST_MEM_ENCRYPT		0x103
+/* Support for shared mapping initialization (after early init) */
+#define PR_GUEST_SHARED_MAPPING_INIT		0x104
+
+#ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
+#include <asm/protected_guest.h>
+#else
+static inline bool prot_guest_has(unsigned long flag) { return false; }
+#endif
+
+#endif /* _LINUX_PROTECTED_GUEST_H */
-- 
2.25.1

