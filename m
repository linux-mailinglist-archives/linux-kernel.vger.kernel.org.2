Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C374E427798
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 07:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbhJIFkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 01:40:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:29184 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244336AbhJIFj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 01:39:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="225410052"
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="225410052"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 22:37:59 -0700
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="569280225"
Received: from dmsojoza-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.135.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 22:37:59 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Subject: [PATCH v10 04/11] x86/tdx: Add TDX support to intel_cc_platform_has()
Date:   Fri,  8 Oct 2021 22:37:40 -0700
Message-Id: <20211009053747.1694419-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc_platform_has() can be used to check for specific active confidential
computing attributes, like memory encryption. For Intel platform like
Trusted Domain Extensions (TDX) guest has need for using this function
to protect the TDX specific changes made in generic drivers.

So add TDX guest support to intel_cc_platform_has().

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v9:
 * None

Changes since v8:
 * Rebased this patch on top of x86/tip/master branch.

Changes since v7:
 * Merged patches titled "x86/tdx: Add Intel ARCH support to cc_platform_has()" and
   "x86/tdx: Add TDX guest support to intel_cc_platform_has()" into one patch.
 * Used cpuid_has_tdx_guest() when adding Intel support to cc_platform_has().

Change since v6:
 * Used cc_platform_has() in place of prot_guest_has().
 * Rebased on top of Tom Landecky's CC platform support patch series.
   https://lore.kernel.org/linux-iommu/f9951644147e27772bf4512325e8ba6472e363b7.1631141919.git.thomas.lendacky@amd.com/T/

Changes since v5:
 * Replaced tdx_prot_guest_has() with intel_prot_guest_has() to
   keep the Intel call non TDX specific.
 * Added TDX guest support to intel_prot_guest_has().

Changes since v4:
 * Rebased on top of Tom Lendacky's protected guest changes.
 * Moved memory encryption related protected guest flags in
   tdx_prot_guest_has() to the patch that actually uses them.

 arch/x86/Kconfig              |  1 +
 arch/x86/kernel/cc_platform.c | 12 ++++++++++--
 include/linux/cc_platform.h   |  9 +++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index eab7f2911f94..af49ad084919 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -870,6 +870,7 @@ config INTEL_TDX_GUEST
 	depends on X86_64 && CPU_SUP_INTEL && PARAVIRT
 	depends on SECURITY
 	depends on X86_X2APIC
+	select ARCH_HAS_CC_PLATFORM
 	help
 	  Provide support for running in a trusted domain on Intel processors
 	  equipped with Trusted Domain Extensions. TDX is a Intel technology
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 03bb2f343ddb..589c003d8954 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -11,12 +11,18 @@
 #include <linux/cc_platform.h>
 #include <linux/mem_encrypt.h>
 
+#include <asm/tdx.h>
 #include <asm/processor.h>
 
-static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
+static bool intel_cc_platform_has(enum cc_attr attr)
 {
 #ifdef CONFIG_INTEL_TDX_GUEST
-	return false;
+	switch (attr) {
+	case CC_ATTR_GUEST_TDX:
+		return is_tdx_guest();
+	default:
+		return false;
+	}
 #else
 	return false;
 #endif
@@ -63,6 +69,8 @@ bool cc_platform_has(enum cc_attr attr)
 {
 	if (sme_me_mask)
 		return amd_cc_platform_has(attr);
+	else if (is_tdx_guest())
+		return intel_cc_platform_has(attr);
 
 	return false;
 }
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index a075b70b9a70..6124527a0423 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -61,6 +61,15 @@ enum cc_attr {
 	 * Examples include SEV-ES.
 	 */
 	CC_ATTR_GUEST_STATE_ENCRYPT,
+
+	/**
+	 * @CC_ATTR_GUEST_TDX: Trusted Domain Extension Support
+	 *
+	 * The platform/OS is running as a TDX guest/virtual machine.
+	 *
+	 * Examples include Intel TDX.
+	 */
+	CC_ATTR_GUEST_TDX,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-- 
2.25.1

