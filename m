Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE3D36B887
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbhDZSDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:03:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:31731 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234231AbhDZSDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:23 -0400
IronPort-SDR: FA+kx4EARuUNJ0gFI+noQRS8N2aYLPf9kFyr5KVKhQhQYDhl3ZVL7UwHhEpXy6qCpXY0+sgKNW
 4tfxv+l35vUw==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="195934020"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="195934020"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:42 -0700
IronPort-SDR: Io6PjEDlYejx2FeDv2IovhT29X9k1BVlQxOVFkAQ3JLQ9toqBPTbHM29Mw7G1yHKysoYIFAfkM
 JMcV0bl3Votw==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353341"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:41 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [RFC v2 04/32] x86/x86: Add is_tdx_guest() interface
Date:   Mon, 26 Apr 2021 11:01:31 -0700
Message-Id: <72a11cdb0a3e5086cfc11a49ba3e20d05dc3a119.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
Reviewed-by: Tony Luck <tony.luck@intel.com>
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
index 679500e807f3..69af72d08d3d 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -9,10 +9,18 @@
 
 #include <asm/cpufeature.h>
 
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
index f927e36769d5..6a7193fead08 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -19,6 +19,12 @@ static inline bool cpuid_has_tdx_guest(void)
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

