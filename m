Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82BC4521A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 02:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346159AbhKPBFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 20:05:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:28600 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376332AbhKPA64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 19:58:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="231044933"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="231044933"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 16:45:59 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="671742574"
Received: from asu1-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.20.192])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 16:45:58 -0800
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
Subject: [PATCH v1 1/4] x86/sev: Remove sev_enable_key usage in outs##bwl()/ins##bwl()
Date:   Mon, 15 Nov 2021 16:45:25 -0800
Message-Id: <20211116004528.2928887-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116004528.2928887-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211116004528.2928887-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

String I/O instructions (INS/OUTS) can be used to move blocks of
data between I/O ports and memory space. But emulation of these
instructions is not supported in AMD SEV platform. Since these
instructions are obsolete, hypervisors rarely emulate them. So to
support the legacy usage, INS/OUTS are unrolled using IN/OUT
instructions.

Currently, this is implemented by adding a SEV specific static
key check in outs##bwl()/ins##bwl() macros. Since TDX VM guests
also need similar support, the implementation needs to be made
generic using the cc_platform_has() call.

In preparation for adding cc_platform_has() based support, as a
first step remove the sev_enable_key usage and replace it with
direct reference to "sev_status".

Since this patch replaces the static key usage, it might lead to
some performance gap.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/io.h | 15 ++++++++-------
 arch/x86/mm/mem_encrypt.c | 11 +----------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 5c6a4af0b911..69093a610630 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -257,17 +257,18 @@ static inline void slow_down_io(void)
 #endif
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-#include <linux/jump_label.h>
 
-extern struct static_key_false sev_enable_key;
-static inline bool sev_key_active(void)
+extern u64 sev_status;
+
+static inline bool is_sev_enabled(void)
 {
-	return static_branch_unlikely(&sev_enable_key);
+	return ((sev_status & MSR_AMD64_SEV_ENABLED) &&
+		!(sev_status & MSR_AMD64_SEV_ES_ENABLED));
 }
 
 #else /* !CONFIG_AMD_MEM_ENCRYPT */
 
-static inline bool sev_key_active(void) { return false; }
+static inline bool is_sev_enabled(void) { return false; }
 
 #endif /* CONFIG_AMD_MEM_ENCRYPT */
 
@@ -301,7 +302,7 @@ static inline unsigned type in##bwl##_p(int port)			\
 									\
 static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 {									\
-	if (sev_key_active()) {						\
+	if (is_sev_enabled()) {						\
 		unsigned type *value = (unsigned type *)addr;		\
 		while (count) {						\
 			out##bwl(*value, port);				\
@@ -317,7 +318,7 @@ static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 									\
 static inline void ins##bwl(int port, void *addr, unsigned long count)	\
 {									\
-	if (sev_key_active()) {						\
+	if (is_sev_enabled()) {						\
 		unsigned type *value = (unsigned type *)addr;		\
 		while (count) {						\
 			*value = in##bwl(port);				\
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 35487305d8af..49e5dfc23785 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -43,8 +43,7 @@ u64 sme_me_mask __section(".data") = 0;
 u64 sev_status __section(".data") = 0;
 u64 sev_check_data __section(".data") = 0;
 EXPORT_SYMBOL(sme_me_mask);
-DEFINE_STATIC_KEY_FALSE(sev_enable_key);
-EXPORT_SYMBOL_GPL(sev_enable_key);
+EXPORT_SYMBOL_GPL(sev_status);
 
 /* Buffer used for early in-place encryption by BSP, no locking needed */
 static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
@@ -499,14 +498,6 @@ void __init mem_encrypt_init(void)
 	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
 	swiotlb_update_mem_attributes();
 
-	/*
-	 * With SEV, we need to unroll the rep string I/O instructions,
-	 * but SEV-ES supports them through the #VC handler.
-	 */
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
-	    !cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
-		static_branch_enable(&sev_enable_key);
-
 	print_mem_encrypt_feature_info();
 }
 
-- 
2.25.1

