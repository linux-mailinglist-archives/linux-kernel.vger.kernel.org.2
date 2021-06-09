Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59EF3A1F78
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFIV5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:57:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:1782 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhFIV5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:57:46 -0400
IronPort-SDR: /HMcKGfJlxTNDgTXA2cyc/Wk0pV4URAQ77+LBYqaA6B4L7Ss7lVHyFRc29yWUchsmIbgvSlFBB
 MxdgPm06+K6w==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="205208543"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="205208543"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:55:51 -0700
IronPort-SDR: bWB+G5SDtvdvfR7DCXmQhI2dTrDq/YhAmwS3gS0yndon3xf2Ls4z4lJD7WChzQA9cGVChuDXh8
 013pOYui6SAQ==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="482555083"
Received: from qwang4-mobl1.ccr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.35.228])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:55:50 -0700
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
Subject: [PATCH v1 3/7] x86/tdx: Make pages shared in ioremap()
Date:   Wed,  9 Jun 2021 14:55:33 -0700
Message-Id: <20210609215537.1956150-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609215537.1956150-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210609215537.1956150-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

All ioremap()ed pages that are not backed by normal memory (NONE or
RESERVED) have to be mapped as shared.

Reuse the infrastructure we have for AMD SEV.

Note that DMA code doesn't use ioremap() to convert memory to shared as
DMA buffers backed by normal memory. DMA code make buffer shared with
set_memory_decrypted().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/pgtable.h | 4 ++++
 arch/x86/mm/ioremap.c          | 9 ++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index b1099f2d9800..5b77843dfa10 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -21,6 +21,10 @@
 #define pgprot_encrypted(prot)	__pgprot(__sme_set(pgprot_val(prot)))
 #define pgprot_decrypted(prot)	__pgprot(__sme_clr(pgprot_val(prot)))
 
+/* Make the page accesable by VMM for protected guests */
+#define pgprot_protected_guest(prot) __pgprot(pgprot_val(prot) |	\
+					      tdg_shared_mask())
+
 #ifndef __ASSEMBLY__
 #include <asm/x86_init.h>
 #include <asm/fpu/xstate.h>
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 12c686c65ea9..94718396e9e6 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -17,6 +17,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/efi.h>
 #include <linux/pgtable.h>
+#include <linux/protected_guest.h>
 
 #include <asm/set_memory.h>
 #include <asm/e820/api.h>
@@ -87,12 +88,12 @@ static unsigned int __ioremap_check_ram(struct resource *res)
 }
 
 /*
- * In a SEV guest, NONE and RESERVED should not be mapped encrypted because
- * there the whole memory is already encrypted.
+ * In a SEV or TDX guest, NONE and RESERVED should not be mapped encrypted (or
+ * private in TDX case) because there the whole memory is already encrypted.
  */
 static unsigned int __ioremap_check_encrypted(struct resource *res)
 {
-	if (!sev_active())
+	if (!sev_active() && !prot_guest_has(PR_GUEST_MEM_ENCRYPT))
 		return 0;
 
 	switch (res->desc) {
@@ -244,6 +245,8 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	prot = PAGE_KERNEL_IO;
 	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
 		prot = pgprot_encrypted(prot);
+	else if (prot_guest_has(PR_GUEST_SHARED_MAPPING_INIT))
+		prot = pgprot_protected_guest(prot);
 
 	switch (pcm) {
 	case _PAGE_CACHE_MODE_UC:
-- 
2.25.1

