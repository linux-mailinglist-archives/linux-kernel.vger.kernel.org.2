Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C814421CB2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 04:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhJECyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 22:54:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:43302 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230457AbhJECyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 22:54:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="248894632"
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="248894632"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 19:52:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="483409103"
Received: from asaini1-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.96])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 19:52:26 -0700
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
Subject: [PATCH v8 04/11] x86/tdx: Add Intel ARCH support to cc_platform_has()
Date:   Mon,  4 Oct 2021 19:51:58 -0700
Message-Id: <20211005025205.1784480-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc_platform_has() can be used to check for specific active confidential
computing attributes, like memory encryption. For Intel platform like
Trusted Domain eXtensions (TDX) guest has need for using this function
to protect the TDX specific changes made in generic drivers.

So, extend cc_platform_has() and add support for Intel architecture
variant (intel_cc_platform_has()). Also add TDX guest support to
intel_cc_platform_has().

Since intel_cc_platform_has() can be called with invalid %gs, it
cannot be instrumented. So compile it with KCOV/ASAN disabled.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

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

 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/mem_encrypt.h |  6 ++++++
 arch/x86/kernel/Makefile           |  1 +
 arch/x86/kernel/cc_platform.c      |  5 +++++
 arch/x86/kernel/cpu/Makefile       |  5 +++++
 arch/x86/kernel/cpu/intel.c        | 16 ++++++++++++++++
 include/linux/cc_platform.h        |  9 +++++++++
 7 files changed, 43 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c42dd8a2d1f4..abb249dc829d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -871,6 +871,7 @@ config INTEL_TDX_GUEST
 	depends on SECURITY
 	select X86_X2APIC
 	select SECURITY_LOCKDOWN_LSM
+	select ARCH_HAS_CC_PLATFORM
 	help
 	  Provide support for running in a trusted domain on Intel processors
 	  equipped with Trusted Domain eXtensions. TDX is a Intel technology
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index ed954aa5c448..a73712b6ee0e 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -103,6 +103,12 @@ static inline u64 sme_get_me_mask(void)
 	return sme_me_mask;
 }
 
+#if defined(CONFIG_CPU_SUP_INTEL) && defined(CONFIG_ARCH_HAS_CC_PLATFORM)
+bool intel_cc_platform_has(enum cc_attr attr);
+#else
+static inline bool intel_cc_platform_has(enum cc_attr attr) { return false; }
+#endif
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 159fccfece65..8e5b49be65bd 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -28,6 +28,7 @@ KASAN_SANITIZE_dumpstack.o				:= n
 KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
 KASAN_SANITIZE_stacktrace.o				:= n
 KASAN_SANITIZE_paravirt.o				:= n
+KASAN_SANITIZE_cc_platform.o				:= n
 KASAN_SANITIZE_sev.o					:= n
 KASAN_SANITIZE_tdx.o					:= n
 
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 3c9bacd3c3f3..a84310ba1d8d 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -10,11 +10,16 @@
 #include <linux/export.h>
 #include <linux/cc_platform.h>
 #include <linux/mem_encrypt.h>
+#include <linux/processor.h>
+
+#include <asm/tdx.h>
 
 bool cc_platform_has(enum cc_attr attr)
 {
 	if (sme_me_mask)
 		return amd_cc_platform_has(attr);
+	else if (is_tdx_guest)
+		return intel_cc_platform_has(attr);
 
 	return false;
 }
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 637b499450d1..64d33160e377 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -16,6 +16,11 @@ KCOV_INSTRUMENT_perf_event.o := n
 # As above, instrumenting secondary CPU boot code causes boot hangs.
 KCSAN_SANITIZE_common.o := n
 
+# intel_cc_platform_has cannot be instrumented because it can be called
+# with invalid %gs
+KCOV_INSTRUMENT_intel.o := n
+KCSAN_SANITIZE_intel.o := n
+
 # Make sure load_percpu_segment has no stackprotector
 CFLAGS_common.o		:= -fno-stack-protector
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8321c43554a1..b99ead877549 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/uaccess.h>
 #include <linux/delay.h>
+#include <linux/mem_encrypt.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -26,6 +27,7 @@
 #include <asm/resctrl.h>
 #include <asm/numa.h>
 #include <asm/thermal.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -60,6 +62,20 @@ static u64 msr_test_ctrl_cache __ro_after_init;
  */
 static bool cpu_model_supports_sld __ro_after_init;
 
+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+bool intel_cc_platform_has(enum cc_attr attr)
+{
+	switch (attr) {
+	case CC_ATTR_GUEST_TDX:
+		return is_tdx_guest;
+	default:
+		return false;
+	}
+
+	return false;
+}
+#endif
+
 /*
  * Processors which have self-snooping capability can handle conflicting
  * memory type across CPUs by snooping its own cache. However, there exists
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index 253f3ea66cd8..26eb19f37d56 100644
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

