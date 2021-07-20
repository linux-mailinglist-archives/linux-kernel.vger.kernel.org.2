Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C4D3CF16D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 03:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbhGTA5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 20:57:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:28372 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378313AbhGTAKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 20:10:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="191435149"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="191435149"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 17:42:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="660970653"
Received: from ywei11-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 17:42:09 -0700
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
Subject: [PATCH v4 04/11] x86/tdx: Add protected guest support for TDX guest
Date:   Mon, 19 Jul 2021 17:40:50 -0700
Message-Id: <20210720004057.2112666-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720004057.2112666-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210720004057.2112666-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TDX architecture provides a way for VM guests to be highly secure and
isolated (from untrusted VMM). To achieve this requirement, we can't
completely trust any data coming from VMM. TDX guest fixes this issue
by hardening the IO drivers against the attack from the VMM. Since we
have a requirement to modify the generic drivers, we need to use the
generic prot_guest_has() API to add TDX specific code in generic
drivers.

So add TDX guest support in prot_guest_has() API.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/Kconfig                       |  1 +
 arch/x86/include/asm/protected_guest.h |  6 ++++++
 arch/x86/include/asm/tdx.h             |  4 ++++
 arch/x86/kernel/tdx.c                  | 17 +++++++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index abb3ffc7d041..151d946da1a6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -872,6 +872,7 @@ config INTEL_TDX_GUEST
 	depends on SECURITY
 	select X86_X2APIC
 	select SECURITY_LOCKDOWN_LSM
+	select ARCH_HAS_PROTECTED_GUEST
 	help
 	  Provide support for running in a trusted domain on Intel processors
 	  equipped with Trusted Domain eXtensions. TDX is a new Intel
diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
index 54cb119c197f..46a425572684 100644
--- a/arch/x86/include/asm/protected_guest.h
+++ b/arch/x86/include/asm/protected_guest.h
@@ -3,8 +3,14 @@
 #ifndef _ASM_X86_PROTECTED_GUEST_H
 #define _ASM_X86_PROTECTED_GUEST_H 1
 
+#include <asm/processor.h>
+#include <asm/tdx.h>
+
 static inline bool prot_guest_has(unsigned long flag)
 {
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		return tdx_prot_guest_has(flag);
+
 	return false;
 }
 
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index c738bde944d1..eee226e4b3b4 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -11,10 +11,14 @@
 
 void __init tdx_early_init(void);
 
+bool tdx_prot_guest_has(unsigned long flag);
+
 #else
 
 static inline void tdx_early_init(void) { };
 
+static inline bool tdx_prot_guest_has(unsigned long flag) { return false; }
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 39dd1515b131..1e3dc11288f1 100644
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
 
+bool tdx_prot_guest_has(unsigned long flag)
+{
+	switch (flag) {
+	case PR_GUEST_MEM_ENCRYPT:
+	case PR_GUEST_MEM_ENCRYPT_ACTIVE:
+	case PR_GUEST_UNROLL_STRING_IO:
+	case PR_GUEST_SHARED_MAPPING_INIT:
+	case PR_GUEST_TDX:
+		return cpu_feature_enabled(X86_FEATURE_TDX_GUEST);
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(tdx_prot_guest_has);
+
 void __init tdx_early_init(void)
 {
 	if (!cpuid_has_tdx_guest())
-- 
2.25.1

