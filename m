Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031E23A50BE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 23:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhFLVGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 17:06:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:10438 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhFLVGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 17:06:51 -0400
IronPort-SDR: efL0Qq+T4wFzDaR7OYJkyJC+FvzLE0gFFaF81omAd+viriDrNOL40cZzcS6lOfOyM0c1P42aMt
 F0bB1a25WyMw==
X-IronPort-AV: E=McAfee;i="6200,9189,10013"; a="202655507"
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="202655507"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2021 14:04:52 -0700
IronPort-SDR: F47yiKVKWrqhY3Ze7On1jO8O1Y5r2HPFQ85Uj0IcnoKbgUQZU05MxaTTNMUs9VoqpljaaBpyKm
 S5ifYln37YTg==
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="449467873"
Received: from rong2-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.36.179])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2021 14:04:47 -0700
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
Subject: [PATCH v2 04/12] x86/x86: Add early_is_tdx_guest() interface
Date:   Sat, 12 Jun 2021 14:04:45 -0700
Message-Id: <20210612210445.2164948-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YMJ/IrBZiCsNMtvO@zn.tnic>
References: <YMJ/IrBZiCsNMtvO@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper function to detect TDX feature support. It will be used
to protect TDX specific code in decompression code.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v1:
 * Removed is_tdx_guest() interface. We will rely on
   prot_guest_has(PR_GUEST_TDX) for TDX related checks.
 * Renamed is_tdx_guest() to early_is_tdx_guest() as per
   review suggestion.
 * Fixed commit title and log to reflect above changes.
 * Simplified native_cpuid_has_tdx_guest() as per review suggestion.

 arch/x86/boot/compressed/Makefile |  1 +
 arch/x86/boot/compressed/tdx.c    | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
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
index 000000000000..ddfa4a6d1939
--- /dev/null
+++ b/arch/x86/boot/compressed/tdx.c
@@ -0,0 +1,28 @@
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
+	u32 eax = TDX_CPUID_LEAF_ID, sig[3] = {0};
+
+	if (native_cpuid_eax(0) < TDX_CPUID_LEAF_ID)
+		return false;
+
+	native_cpuid(&eax, &sig[0], &sig[1], &sig[2]);
+
+	return !memcmp("IntelTDX    ", sig, 12);
+}
+
+bool early_is_tdx_guest(void)
+{
+	if (tdx_guest < 0)
+		tdx_guest = native_cpuid_has_tdx_guest();
+
+	return !!tdx_guest;
+}
-- 
2.25.1

