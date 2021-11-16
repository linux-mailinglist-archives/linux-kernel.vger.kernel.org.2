Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75F64521AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 02:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346261AbhKPBGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 20:06:05 -0500
Received: from mga11.intel.com ([192.55.52.93]:28723 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376334AbhKPA64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 19:58:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="231044945"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="231044945"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 16:46:00 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="671742579"
Received: from asu1-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.20.192])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 16:45:59 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] x86/sev: Use CC_ATTR attribute to generalize string I/O unroll
Date:   Mon, 15 Nov 2021 16:45:26 -0800
Message-Id: <20211116004528.2928887-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116004528.2928887-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211116004528.2928887-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INS/OUTS instructions are obsolete and hence many hypervisors do not
support its emulation. To support existing usage, string I/O operations
are unrolled using IN/OUT instructions.

AMD SEV platform implements this support by adding unroll logic in
ins#bwl()/outs#bwl() macros with SEV specific checks. Since TDX VM
guests will also need similar support, use
CC_ATTR_GUEST_UNROLL_STRING_IO and generic cc_platform_has() API to
implement it.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/io.h     | 21 +++------------------
 arch/x86/kernel/cc_platform.c |  4 ++++
 arch/x86/mm/mem_encrypt.c     |  1 -
 include/linux/cc_platform.h   | 11 +++++++++++
 4 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 69093a610630..f6d91ecb8026 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -40,6 +40,7 @@
 
 #include <linux/string.h>
 #include <linux/compiler.h>
+#include <linux/cc_platform.h>
 #include <asm/page.h>
 #include <asm/early_ioremap.h>
 #include <asm/pgtable_types.h>
@@ -256,22 +257,6 @@ static inline void slow_down_io(void)
 
 #endif
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-
-extern u64 sev_status;
-
-static inline bool is_sev_enabled(void)
-{
-	return ((sev_status & MSR_AMD64_SEV_ENABLED) &&
-		!(sev_status & MSR_AMD64_SEV_ES_ENABLED));
-}
-
-#else /* !CONFIG_AMD_MEM_ENCRYPT */
-
-static inline bool is_sev_enabled(void) { return false; }
-
-#endif /* CONFIG_AMD_MEM_ENCRYPT */
-
 #define BUILDIO(bwl, bw, type)						\
 static inline void out##bwl(unsigned type value, int port)		\
 {									\
@@ -302,7 +287,7 @@ static inline unsigned type in##bwl##_p(int port)			\
 									\
 static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 {									\
-	if (is_sev_enabled()) {						\
+	if (cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\
 		unsigned type *value = (unsigned type *)addr;		\
 		while (count) {						\
 			out##bwl(*value, port);				\
@@ -318,7 +303,7 @@ static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 									\
 static inline void ins##bwl(int port, void *addr, unsigned long count)	\
 {									\
-	if (is_sev_enabled()) {						\
+	if (cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\
 		unsigned type *value = (unsigned type *)addr;		\
 		while (count) {						\
 			*value = in##bwl(port);				\
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 03bb2f343ddb..cc1ffe710dd2 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -50,6 +50,10 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_GUEST_STATE_ENCRYPT:
 		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 
+	case CC_ATTR_GUEST_UNROLL_STRING_IO:
+		return (sev_status & MSR_AMD64_SEV_ENABLED) &&
+			!(sev_status & MSR_AMD64_SEV_ES_ENABLED);
+
 	default:
 		return false;
 	}
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 49e5dfc23785..b520021a7e7b 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -43,7 +43,6 @@ u64 sme_me_mask __section(".data") = 0;
 u64 sev_status __section(".data") = 0;
 u64 sev_check_data __section(".data") = 0;
 EXPORT_SYMBOL(sme_me_mask);
-EXPORT_SYMBOL_GPL(sev_status);
 
 /* Buffer used for early in-place encryption by BSP, no locking needed */
 static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index a075b70b9a70..f47f0c9edb3b 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -61,6 +61,17 @@ enum cc_attr {
 	 * Examples include SEV-ES.
 	 */
 	CC_ATTR_GUEST_STATE_ENCRYPT,
+
+	/**
+	 * @CC_ATTR_GUEST_UNROLL_STRING_IO: String I/O is implemented with
+	 *                                  IN/OUT instructions
+	 *
+	 * The platform/OS is running as a guest/virtual machine and uses
+	 * IN/OUT instructions in place of string I/O.
+	 *
+	 * Examples include TDX Guest & SEV.
+	 */
+	CC_ATTR_GUEST_UNROLL_STRING_IO,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-- 
2.25.1

