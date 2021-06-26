Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494753B4EE1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFZOT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 10:19:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:42501 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhFZOTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 10:19:51 -0400
IronPort-SDR: krT1sEZHlDFvnQwi6laXablT36iwzPn7PKZz2dM7qEmPwhaDypxmPTUiY9i5QbsJQ4qtESaT24
 2EbrtyFqw5mw==
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="207729770"
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="207729770"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:17:29 -0700
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="624775846"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.8.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:17:28 -0700
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
Subject: [PATCH v2 02/10] x86/tdx: Add early_is_tdx_guest() interface
Date:   Sat, 26 Jun 2021 07:17:10 -0700
Message-Id: <8ba1cc1571ec7d8f0404e62bd39bbaa88370dfca.1624716673.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1624716673.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1624716673.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper function to detect TDX feature support. It will be used
to protect TDX specific code in decompression code (for example to
add TDX specific I/O fixes in decompression code).

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v1:
 * Modified cpuid_has_tdx_guest() to use cpuid_count() instead of native_cpuid().
 * Reused cpuid_count() from cpuflags.c.
 * Added a new function cpuid_eax().
 * Renamed native_cpuid_has_tdx_guest() as early_cpuid_has_tdx_guest().

 arch/x86/boot/compressed/Makefile |  1 +
 arch/x86/boot/compressed/tdx.c    | 31 +++++++++++++++++++++++++++++++
 arch/x86/boot/cpuflags.c          | 12 ++++++++++--
 arch/x86/boot/cpuflags.h          |  2 ++
 4 files changed, 44 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdx.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 431bf7f846c3..22a2a6cc2ab4 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -98,6 +98,7 @@ ifdef CONFIG_X86_64
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
+vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
new file mode 100644
index 000000000000..51cf655d8b60
--- /dev/null
+++ b/arch/x86/boot/compressed/tdx.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tdx.c - Early boot code for TDX
+ */
+
+#include "../cpuflags.h"
+#include "../string.h"
+
+#define TDX_CPUID_LEAF_ID                       0x21
+
+static int tdx_guest = -1;
+
+static inline bool early_cpuid_has_tdx_guest(void)
+{
+	u32 eax = TDX_CPUID_LEAF_ID, sig[3] = {0};
+
+	if (cpuid_eax(0) < TDX_CPUID_LEAF_ID)
+		return false;
+
+	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[1], &sig[2]);
+
+	return !memcmp("IntelTDX    ", sig, 12);
+}
+
+bool early_is_tdx_guest(void)
+{
+	if (tdx_guest < 0)
+		tdx_guest = early_cpuid_has_tdx_guest();
+
+	return !!tdx_guest;
+}
diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
index a0b75f73dc63..102613a092aa 100644
--- a/arch/x86/boot/cpuflags.c
+++ b/arch/x86/boot/cpuflags.c
@@ -71,8 +71,7 @@ int has_eflag(unsigned long mask)
 # define EBX_REG "=b"
 #endif
 
-static inline void cpuid_count(u32 id, u32 count,
-		u32 *a, u32 *b, u32 *c, u32 *d)
+void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d)
 {
 	asm volatile(".ifnc %%ebx,%3 ; movl  %%ebx,%3 ; .endif	\n\t"
 		     "cpuid					\n\t"
@@ -82,6 +81,15 @@ static inline void cpuid_count(u32 id, u32 count,
 	);
 }
 
+u32 cpuid_eax(u32 id)
+{
+	u32 eax, ebx, ecx, edx;
+
+	cpuid_count(id, 0, &eax, &ebx, &ecx, &edx);
+
+	return eax;
+}
+
 #define cpuid(id, a, b, c, d) cpuid_count(id, 0, a, b, c, d)
 
 void get_cpuflags(void)
diff --git a/arch/x86/boot/cpuflags.h b/arch/x86/boot/cpuflags.h
index 2e20814d3ce3..5a72233eb8fd 100644
--- a/arch/x86/boot/cpuflags.h
+++ b/arch/x86/boot/cpuflags.h
@@ -17,5 +17,7 @@ extern u32 cpu_vendor[3];
 
 int has_eflag(unsigned long mask);
 void get_cpuflags(void);
+void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d);
+u32 cpuid_eax(u32 id);
 
 #endif
-- 
2.25.1

