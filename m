Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35733E0758
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbhHDSPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:15:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:49808 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240050AbhHDSPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:15:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="201151095"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="201151095"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 11:14:47 -0700
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="503075831"
Received: from mjkendri-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.17.117])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 11:14:46 -0700
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
Subject: [PATCH v5 04/12] x86/tdx: Add protected guest support for TDX guest
Date:   Wed,  4 Aug 2021 11:13:21 -0700
Message-Id: <20210804181329.2899708-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Change since v4:
 * Rebased on top of Tom Lendacky's protected guest changes.
 * Moved memory encryption related protected guest flags in
   tdx_prot_guest_has() to the patch that actually uses them.

 arch/x86/Kconfig                       |  1 +
 arch/x86/include/asm/protected_guest.h |  5 +++++
 arch/x86/include/asm/tdx.h             |  4 ++++
 arch/x86/kernel/tdx.c                  | 13 +++++++++++++
 include/linux/protected_guest.h        |  3 +++
 5 files changed, 26 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ab0e7c346c44..10f2cb51a39d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -871,6 +871,7 @@ config INTEL_TDX_GUEST
 	depends on SECURITY
 	select X86_X2APIC
 	select SECURITY_LOCKDOWN_LSM
+	select ARCH_HAS_PROTECTED_GUEST
 	help
 	  Provide support for running in a trusted domain on Intel processors
 	  equipped with Trusted Domain eXtensions. TDX is a new Intel
diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
index b4a267dddf93..c67bf13c8ad3 100644
--- a/arch/x86/include/asm/protected_guest.h
+++ b/arch/x86/include/asm/protected_guest.h
@@ -12,12 +12,17 @@
 
 #include <linux/mem_encrypt.h>
 
+#include <asm/processor.h>
+#include <asm/tdx.h>
+
 #ifndef __ASSEMBLY__
 
 static inline bool prot_guest_has(unsigned int attr)
 {
 	if (sme_me_mask)
 		return amd_prot_guest_has(attr);
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		return tdx_prot_guest_has(attr);
 
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
index 39dd1515b131..1a032d700f51 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -4,6 +4,8 @@
 #undef pr_fmt
 #define pr_fmt(fmt)     "x86/tdx: " fmt
 
+#include <linux/protected_guest.h>
+
 #include <asm/tdx.h>
 
 static inline bool cpuid_has_tdx_guest(void)
@@ -18,6 +20,17 @@ static inline bool cpuid_has_tdx_guest(void)
 	return !memcmp("IntelTDX    ", sig, 12);
 }
 
+bool tdx_prot_guest_has(unsigned long flag)
+{
+	switch (flag) {
+	case PATTR_GUEST_TDX:
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
diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
index 7a7120abbb62..9085f5dd834c 100644
--- a/include/linux/protected_guest.h
+++ b/include/linux/protected_guest.h
@@ -22,6 +22,9 @@
 #define PATTR_SEV			0x801
 #define PATTR_SEV_ES			0x802
 
+/* 0x900 - 0x9ff reserved for Intel */
+#define PATTR_GUEST_TDX			0x900
+
 #ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
 
 #include <asm/protected_guest.h>
-- 
2.25.1

