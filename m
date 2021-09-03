Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D740041F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350267AbhICR3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:29:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:65004 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350203AbhICR31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:29:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="206593446"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="206593446"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 10:28:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="534222235"
Received: from dlinsen-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.56.172])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 10:28:26 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/11] x86/tdx: Add protected guest support for TDX guest
Date:   Fri,  3 Sep 2021 10:28:05 -0700
Message-Id: <20210903172812.1097643-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TDX architecture provides a way for VM guests to be highly secure and
isolated (from untrusted VMM). To achieve this requirement, any data
coming from VMM cannot be completely trusted. TDX guest fixes this
issue by hardening the IO drivers against the attack from the VMM.
So, when adding hardening fixes to the generic drivers, to protect
custom fixes use prot_guest_has() API.

Also add TDX guest support to prot_guest_has() API to protect the
TDX specific fixes.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v5:
 * Replaced tdx_prot_guest_has() with intel_prot_guest_has() to
   keep the Intel call non TDX specific.
 * Added TDX guest support to intel_prot_guest_has().

Changes since v4:
 * Rebased on top of Tom Lendacky's protected guest changes.
 * Moved memory encryption related protected guest flags in
   tdx_prot_guest_has() to the patch that actually uses them.

 arch/x86/Kconfig                       |  1 +
 arch/x86/include/asm/protected_guest.h |  9 +++++++++
 arch/x86/kernel/cpu/intel.c            | 14 ++++++++++++++
 include/linux/protected_guest.h        |  3 +++
 4 files changed, 27 insertions(+)

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
index b4a267dddf93..722d11b2c5e8 100644
--- a/arch/x86/include/asm/protected_guest.h
+++ b/arch/x86/include/asm/protected_guest.h
@@ -11,13 +11,22 @@
 #define _X86_PROTECTED_GUEST_H
 
 #include <linux/mem_encrypt.h>
+#include <linux/processor.h>
 
 #ifndef __ASSEMBLY__
 
+#if defined(CONFIG_CPU_SUP_INTEL) && defined(CONFIG_ARCH_HAS_PROTECTED_GUEST)
+bool intel_prot_guest_has(unsigned int flag);
+#else
+static inline bool intel_prot_guest_has(unsigned int flag) { return false; }
+#endif
+
 static inline bool prot_guest_has(unsigned int attr)
 {
 	if (sme_me_mask)
 		return amd_prot_guest_has(attr);
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		return intel_prot_guest_has(attr);
 
 	return false;
 }
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8321c43554a1..134ee3984fdd 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/uaccess.h>
 #include <linux/delay.h>
+#include <linux/protected_guest.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -60,6 +61,19 @@ static u64 msr_test_ctrl_cache __ro_after_init;
  */
 static bool cpu_model_supports_sld __ro_after_init;
 
+#ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
+bool intel_prot_guest_has(unsigned int flag)
+{
+	switch (flag) {
+	case PATTR_GUEST_TDX:
+		return cpu_feature_enabled(X86_FEATURE_TDX_GUEST);
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(intel_prot_guest_has);
+#endif
+
 /*
  * Processors which have self-snooping capability can handle conflicting
  * memory type across CPUs by snooping its own cache. However, there exists
diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
index 5ddef1b6a2ea..b6bb86bdf713 100644
--- a/include/linux/protected_guest.h
+++ b/include/linux/protected_guest.h
@@ -25,6 +25,9 @@
 #define PATTR_SEV			0x801
 #define PATTR_SEV_ES			0x802
 
+/* 0x900 - 0x9ff reserved for Intel */
+#define PATTR_GUEST_TDX			0x900
+
 #ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
 
 #include <asm/protected_guest.h>
-- 
2.25.1

