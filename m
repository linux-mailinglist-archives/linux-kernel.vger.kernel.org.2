Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9C3397ECF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 04:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFBCUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:20:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:20888 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229981AbhFBCUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:20:22 -0400
IronPort-SDR: +XGTdF8SyId0wErUI09hztF1U0Qsdci8vzJqZW5aaSsa816hdTSuiKGXxlcHlfpzMCalXiMQSj
 30hY+1KHcsVw==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="224968900"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="224968900"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 19:18:39 -0700
IronPort-SDR: RxBbaCL78VPBP+xx7KCaZoUjVCbtodjgC74P+BQTrEs/VteArDz6wQVIEuvudM+FuLXwbYj1Cj
 /5+KhTmxr+HQ==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="633067917"
Received: from mjdelaro-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.3.23])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 19:18:39 -0700
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v1 04/11] x86/x86: Add is_tdx_guest() interface
Date:   Tue,  1 Jun 2021 19:18:28 -0700
Message-Id: <20210602021833.2186419-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602021833.2186419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210602021833.2186419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
index 5b14b72e41c5..5e70617e9877 100644
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

