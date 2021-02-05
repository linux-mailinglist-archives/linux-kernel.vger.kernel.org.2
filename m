Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7952031193E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhBFC7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 21:59:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:27618 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231166AbhBFCjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:39:09 -0500
IronPort-SDR: ZFBPtYNaPGvqpwAFCQSMKBtKAdLclWM0iel9MNyqZIFlVnuUiY3QbPBUWpYt/xb2odqMC7IPJZ
 uV7Dha5P+zig==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650754"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650754"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:16 -0800
IronPort-SDR: ooRRoauvwU3zn24lLtrJ+0fdgf9BSnTgdUftW10JCx1A2xk7lpmYXErbDpILgDWHdNtLnmfAMS
 F7G2TZ1hBCvA==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183974"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:15 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v1 21/26] x86/mm: Move force_dma_unencrypted() to common code
Date:   Fri,  5 Feb 2021 15:38:38 -0800
Message-Id: <444fe9c7c035417f6abc3e0be2a4861cb573ab28.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Intel TDX doesn't allow VMM to access guest memory. Any memory that is
required for communication with VMM suppose to be shared explicitly by
setting the bit in page table entry. The shared memory is similar to
unencrypted memory in AMD SME/SEV terminology.

force_dma_unencrypted() has to return true for TDX guest. Move it out of
AMD SME code.

Introduce new config option X86_MEM_ENCRYPT_COMMON that has to be
selected by all x86 memory encryption features.

This is preparation for TDX changes in DMA code.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/Kconfig                 |  8 +++++--
 arch/x86/include/asm/io.h        |  4 +++-
 arch/x86/mm/Makefile             |  2 ++
 arch/x86/mm/mem_encrypt.c        | 30 -------------------------
 arch/x86/mm/mem_encrypt_common.c | 38 ++++++++++++++++++++++++++++++++
 5 files changed, 49 insertions(+), 33 deletions(-)
 create mode 100644 arch/x86/mm/mem_encrypt_common.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0374d9f262a5..8fa654d61ac2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1538,14 +1538,18 @@ config X86_CPA_STATISTICS
 	  helps to determine the effectiveness of preserving large and huge
 	  page mappings when mapping protections are changed.
 
+config X86_MEM_ENCRYPT_COMMON
+	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
+	select DYNAMIC_PHYSICAL_MASK
+	def_bool n
+
 config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
 	select DMA_COHERENT_POOL
-	select DYNAMIC_PHYSICAL_MASK
 	select ARCH_USE_MEMREMAP_PROT
-	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select INSTRUCTION_DECODER
+	select X86_MEM_ENCRYPT_COMMON
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 30a3b30395ad..95e534cffa99 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -257,10 +257,12 @@ static inline void slow_down_io(void)
 
 #endif
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
 #include <linux/jump_label.h>
 
 extern struct static_key_false sev_enable_key;
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+
 static inline bool sev_key_active(void)
 {
 	return static_branch_unlikely(&sev_enable_key);
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 5864219221ca..b31cb52bf1bd 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -52,6 +52,8 @@ obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
 obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
 obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
 
+obj-$(CONFIG_X86_MEM_ENCRYPT_COMMON)	+= mem_encrypt_common.o
+
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index c79e5736ab2b..11a6a7b3af7e 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -15,10 +15,6 @@
 #include <linux/dma-direct.h>
 #include <linux/swiotlb.h>
 #include <linux/mem_encrypt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/bitops.h>
-#include <linux/dma-mapping.h>
 
 #include <asm/tlbflush.h>
 #include <asm/fixmap.h>
@@ -389,32 +385,6 @@ bool noinstr sev_es_active(void)
 	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 }
 
-/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
-bool force_dma_unencrypted(struct device *dev)
-{
-	/*
-	 * For SEV, all DMA must be to unencrypted addresses.
-	 */
-	if (sev_active())
-		return true;
-
-	/*
-	 * For SME, all DMA must be to unencrypted addresses if the
-	 * device does not support DMA to addresses that include the
-	 * encryption mask.
-	 */
-	if (sme_active()) {
-		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
-		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
-						dev->bus_dma_limit);
-
-		if (dma_dev_mask <= dma_enc_mask)
-			return true;
-	}
-
-	return false;
-}
-
 void __init mem_encrypt_free_decrypted_mem(void)
 {
 	unsigned long vaddr, vaddr_end, npages;
diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
new file mode 100644
index 000000000000..964e04152417
--- /dev/null
+++ b/arch/x86/mm/mem_encrypt_common.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Memory Encryption Support
+ *
+ * Copyright (C) 2016 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/mem_encrypt.h>
+#include <linux/dma-mapping.h>
+
+/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
+bool force_dma_unencrypted(struct device *dev)
+{
+	/*
+	 * For SEV, all DMA must be to unencrypted/shared addresses.
+	 */
+	if (sev_active())
+		return true;
+
+	/*
+	 * For SME, all DMA must be to unencrypted addresses if the
+	 * device does not support DMA to addresses that include the
+	 * encryption mask.
+	 */
+	if (sme_active()) {
+		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
+		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
+						dev->bus_dma_limit);
+
+		if (dma_dev_mask <= dma_enc_mask)
+			return true;
+	}
+
+	return false;
+}
-- 
2.25.1

