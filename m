Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3880A311AE4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhBFEbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:31:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:63285 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231284AbhBFDSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:18:16 -0500
IronPort-SDR: X/3hvFFfliTeU0MLcflriA6fYKT/VzLW5Xoj4LNjbscjga+ObK6EauprNNXbS+2qYHlIpkcnf4
 Hx0RPw/4dBUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650710"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650710"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:05 -0800
IronPort-SDR: gvuUvlXu0Q7Gu+sFzj2eNxDNMjz7WiThyLLSG3Pe22UU0oQEAGLjzjDTA1kzN9EDCSZHMeEHa3
 bpLmeQvCcN+A==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183869"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:04 -0800
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
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [RFC v1 03/26] x86/cpufeatures: Add is_tdx_guest() interface
Date:   Fri,  5 Feb 2021 15:38:20 -0800
Message-Id: <83c8fcff9ac09f73924104cfb534258747e98bff.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper function to detect TDX feature support. It will be used
to protect TDX specific code.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/boot/compressed/Makefile |  1 +
 arch/x86/boot/compressed/tdx.c    | 32 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/tdx.h        |  8 ++++++++
 arch/x86/kernel/tdx.c             |  6 ++++++
 4 files changed, 47 insertions(+)
 create mode 100644 arch/x86/boot/compressed/tdx.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index e0bc3988c3fa..a2554621cefe 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -96,6 +96,7 @@ ifdef CONFIG_X86_64
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
+vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o
 
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
new file mode 100644
index 000000000000..0a87c1775b67
--- /dev/null
+++ b/arch/x86/boot/compressed/tdx.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tdx.c - Early boot code for TDX
+ */
+
+#include <asm/tdx.h>
+
+static int __ro_after_init tdx_guest = -1;
+
+static inline bool native_cpuid_has_tdx_guest(void)
+{
+	u32 eax = TDX_CPUID_LEAF_ID, signature[3] = {0};
+
+	if (native_cpuid_eax(0) < TDX_CPUID_LEAF_ID)
+		return false;
+
+	native_cpuid(&eax, &signature[0], &signature[1], &signature[2]);
+
+	if (memcmp("IntelTDX    ", signature, 12))
+		return false;
+
+	return true;
+}
+
+bool is_tdx_guest(void)
+{
+	if (tdx_guest < 0)
+		tdx_guest = native_cpuid_has_tdx_guest();
+
+	return !!tdx_guest;
+}
+
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 2cc246c0cecf..0b9d571b1f95 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -7,10 +7,18 @@
 
 #ifdef CONFIG_INTEL_TDX_GUEST
 
+/* Common API to check TDX support in decompression and common kernel code. */
+bool is_tdx_guest(void);
+
 void __init tdx_early_init(void);
 
 #else // !CONFIG_INTEL_TDX_GUEST
 
+static inline bool is_tdx_guest(void)
+{
+	return false;
+}
+
 static inline void tdx_early_init(void) { };
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 473b4c1c0920..e44e55d1e519 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -20,6 +20,12 @@ static inline bool cpuid_has_tdx_guest(void)
 	return true;
 }
 
+bool is_tdx_guest(void)
+{
+	return static_cpu_has(X86_FEATURE_TDX_GUEST);
+}
+EXPORT_SYMBOL_GPL(is_tdx_guest);
+
 void __init tdx_early_init(void)
 {
 	if (!cpuid_has_tdx_guest())
-- 
2.25.1

