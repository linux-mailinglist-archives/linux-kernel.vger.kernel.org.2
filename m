Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C893AD591
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 00:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbhFRXAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 19:00:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:13194 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235170AbhFRXAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 19:00:47 -0400
IronPort-SDR: 89HXmJTNE5wNCC9cTuvWnNgnW8ADpuFJjfO57vuY0gGiJL94MkBk+uIvSHVHTUg1h8XE2gLwuQ
 pQ5dWZM/WU4w==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="193763413"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="193763413"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 15:58:37 -0700
IronPort-SDR: 6G7sa/nlAFHXQznrPk0WnqmXPMr27cCq8jvetFz+31cUPqUHzGlqbMRBQzMkmXVkKNgXenYcoS
 LUvWmYE5xRzQ==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="554874171"
Received: from shahdhav-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.6.127])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 15:58:36 -0700
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
Subject: [PATCH v3 04/11] x86: Introduce generic protected guest abstraction
Date:   Fri, 18 Jun 2021 15:57:48 -0700
Message-Id: <20210618225755.662725-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Change since v1:
 * Introduced PR_GUEST_TDX and PR_GUEST_SEV vendor flags as per
   Boris suggestion.
 * Replaced is_tdx_guest() with if (boot_cpu_data.x86_vendor ==
   X86_VENDOR_INTEL) in prot_guest_has().
 * Modified tdx_protected_guest_has() and sev_protected_guest_has()
   to support vendor flags.

 arch/Kconfig                           |  3 +++
 arch/x86/Kconfig                       |  2 ++
 arch/x86/include/asm/protected_guest.h | 20 +++++++++++++++++
 arch/x86/include/asm/sev.h             |  3 +++
 arch/x86/include/asm/tdx.h             |  4 ++++
 arch/x86/kernel/sev.c                  | 17 +++++++++++++++
 arch/x86/kernel/tdx.c                  | 17 +++++++++++++++
 include/linux/protected_guest.h        | 30 ++++++++++++++++++++++++++
 8 files changed, 96 insertions(+)
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
index ff79263aebd1..d506aae29dd9 100644
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
@@ -1539,6 +1540,7 @@ config AMD_MEM_ENCRYPT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select INSTRUCTION_DECODER
 	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
+	select ARCH_HAS_PROTECTED_GUEST
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
new file mode 100644
index 000000000000..d47668dee6c2
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
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
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
index c738bde944d1..1c17c9080a2c 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -11,10 +11,14 @@
 
 void __init tdx_early_init(void);
 
+bool tdx_protected_guest_has(unsigned long flag);
+
 #else
 
 static inline void tdx_early_init(void) { };
 
+static inline bool tdx_protected_guest_has(unsigned long flag) { return false; }
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 651b81cd648e..3e88576555d2 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -19,6 +19,7 @@
 #include <linux/memblock.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/protected_guest.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -1493,3 +1494,19 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
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
+	case PR_GUEST_SEV:
+		return sev_active();
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(sev_protected_guest_has);
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index b1492e076168..ae3334a2b29d 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -4,6 +4,8 @@
 #undef pr_fmt
 #define pr_fmt(fmt)     "x86/tdx: " fmt
 
+#include <linux/protected_guest.h>
+
 #include <asm/tdx.h>
 
 static inline bool cpuid_has_tdx_guest(void)
@@ -18,6 +20,21 @@ static inline bool cpuid_has_tdx_guest(void)
 	return !memcmp("IntelTDX    ", sig, 12);
 }
 
+bool tdx_protected_guest_has(unsigned long flag)
+{
+	switch (flag) {
+	case PR_GUEST_MEM_ENCRYPT:
+	case PR_GUEST_MEM_ENCRYPT_ACTIVE:
+	case PR_GUEST_UNROLL_STRING_IO:
+	case PR_GUEST_SHARED_MAPPING_INIT:
+	case PR_GUEST_TDX:
+		return static_cpu_has(X86_FEATURE_TDX_GUEST);
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(tdx_protected_guest_has);
+
 void __init tdx_early_init(void)
 {
 	if (!cpuid_has_tdx_guest())
diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
new file mode 100644
index 000000000000..c5b7547e5a68
--- /dev/null
+++ b/include/linux/protected_guest.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_PROTECTED_GUEST_H
+#define _LINUX_PROTECTED_GUEST_H 1
+
+/* Protected Guest Feature Flags (leave 0-0xfff for vendor specific flags) */
+
+/* 0-ff is reserved for Intel specific flags */
+#define PR_GUEST_TDX				0x0000
+
+/* 100-1ff is reserved for AMD specific flags */
+#define PR_GUEST_SEV				0x0100
+
+/* Support for guest encryption */
+#define PR_GUEST_MEM_ENCRYPT			0x1000
+/* Encryption support is active */
+#define PR_GUEST_MEM_ENCRYPT_ACTIVE		0x1001
+/* Support for unrolled string IO */
+#define PR_GUEST_UNROLL_STRING_IO		0x1002
+/* Support for host memory encryption */
+#define PR_GUEST_HOST_MEM_ENCRYPT		0x1003
+/* Support for shared mapping initialization (after early init) */
+#define PR_GUEST_SHARED_MAPPING_INIT		0x1004
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

