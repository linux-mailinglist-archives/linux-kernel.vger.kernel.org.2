Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9333439261C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhE0EZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:25:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:56123 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229746AbhE0EZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:25:47 -0400
IronPort-SDR: +eSYvFUtvzTJIQkRIHuXWXSTmjidRttxKXc7f9dG5DhRI3DnLfUzhJjtQ3uZNTLMEgk07IKqOB
 yrdPUfm6ts4w==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="182979646"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="182979646"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:24:14 -0700
IronPort-SDR: zKVaPURvm/X0WU5Mnhex0fTF/SE4TKGkCpsX0sFV3gPsSMspcZUZgTACU8qwNVKfeGjjUxcOOW
 dBWC6T04u03g==
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="480391410"
Received: from skgangad-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.33.45])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:24:12 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2-fix-v1 1/3] tdx: Introduce generic protected_guest abstraction
Date:   Wed, 26 May 2021 21:23:54 -0700
Message-Id: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527042356.3983284-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <CAPcyv4gBNqDFQEYjWqYTckPg-yy=LrvMw_FNY+tUuEwD35CfyA@mail.gmail.com>
 <20210527042356.3983284-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic way to check if we run with an encrypted guest,
without requiring x86 specific ifdefs. This can then be used in
non architecture specific code. 

is_protected_guest() helper function can be implemented using
arch specific CPU feature flags.

protected_guest_has() is used to check for protected guest
feature flags.

Originally-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/Kconfig                           |  3 +++
 arch/x86/Kconfig                       |  1 +
 arch/x86/include/asm/protected_guest.h | 24 ++++++++++++++++++++++++
 arch/x86/include/asm/tdx.h             |  7 +++++++
 arch/x86/kernel/tdx.c                  | 18 ++++++++++++++++++
 include/linux/protected_guest.h        | 23 +++++++++++++++++++++++
 6 files changed, 76 insertions(+)
 create mode 100644 arch/x86/include/asm/protected_guest.h
 create mode 100644 include/linux/protected_guest.h

diff --git a/arch/Kconfig b/arch/Kconfig
index ecfd3520b676..98c30312555b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -956,6 +956,9 @@ config HAVE_ARCH_NVRAM_OPS
 config ISA_BUS_API
 	def_bool ISA
 
+config ARCH_HAS_PROTECTED_GUEST
+	bool
+
 #
 # ABI hall of shame
 #
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 15e66a99dd41..fc588a64d1a0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -878,6 +878,7 @@ config INTEL_TDX_GUEST
 	select PARAVIRT_XL
 	select X86_X2APIC
 	select SECURITY_LOCKDOWN_LSM
+	select ARCH_HAS_PROTECTED_GUEST
 	help
 	  Provide support for running in a trusted domain on Intel processors
 	  equipped with Trusted Domain eXtenstions. TDX is a new Intel
diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
new file mode 100644
index 000000000000..b2838e58ce94
--- /dev/null
+++ b/arch/x86/include/asm/protected_guest.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020 Intel Corporation */
+#ifndef _ASM_PROTECTED_GUEST
+#define _ASM_PROTECTED_GUEST 1
+
+#include <asm/cpufeature.h>
+#include <asm/tdx.h>
+
+/* Only include through linux/protected_guest.h */
+
+static inline bool is_protected_guest(void)
+{
+	return boot_cpu_has(X86_FEATURE_TDX_GUEST);
+}
+
+static inline bool protected_guest_has(unsigned long flag)
+{
+	if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
+		return tdx_protected_guest_has(flag);
+
+	return false;
+}
+
+#endif
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 597a3e1663d7..53f844200909 100644
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
index 17725646eb30..858e7f3d8f36 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -7,6 +7,7 @@
 #include <asm/vmx.h>
 
 #include <linux/cpu.h>
+#include <linux/protected_guest.h>
 
 /* TDX Module call Leaf IDs */
 #define TDINFO				1
@@ -75,6 +76,23 @@ bool is_tdx_guest(void)
 }
 EXPORT_SYMBOL_GPL(is_tdx_guest);
 
+bool tdx_protected_guest_has(unsigned long flag)
+{
+	if (!is_tdx_guest())
+		return false;
+
+	switch (flag) {
+	case VM_MEM_ENCRYPT:
+	case VM_MEM_ENCRYPT_ACTIVE:
+	case VM_UNROLL_STRING_IO:
+	case VM_HOST_MEM_ENCRYPT:
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
diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
new file mode 100644
index 000000000000..f362eea39bd8
--- /dev/null
+++ b/include/linux/protected_guest.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_PROTECTED_GUEST_H
+#define _LINUX_PROTECTED_GUEST_H 1
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
+
+#ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
+#include <asm/protected_guest.h>
+#else
+static inline bool is_protected_guest(void) { return false; }
+static inline bool protected_guest_has(unsigned long flag) { return false; }
+#endif
+
+#endif
-- 
2.25.1

