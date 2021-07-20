Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061633CF30D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 06:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbhGTDf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 23:35:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:8806 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242622AbhGTDeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 23:34:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="232950380"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="232950380"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:13:53 -0700
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="468818635"
Received: from ywei11-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.31])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:13:52 -0700
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
Subject: [PATCH v3 3/7] x86/tdx: Make pages shared in ioremap()
Date:   Mon, 19 Jul 2021 21:13:42 -0700
Message-Id: <20210720041346.2121680-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720041346.2121680-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210720041346.2121680-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

All ioremap()ed pages that are not backed by normal memory (NONE or
RESERVED) have to be mapped as shared.

Reuse the infrastructure from AMD SEV code.

Note that DMA code doesn't use ioremap() to convert memory to shared as
DMA buffers backed by normal memory. DMA code make buffer shared with
set_memory_decrypted().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v1:
 * Fixed format issues in commit log.

 arch/x86/include/asm/pgtable.h |  4 ++++
 arch/x86/mm/ioremap.c          | 10 +++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 448cd01eb3ec..2d4d518651d2 100644
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
 #include <asm/pkru.h>
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 60ade7dd71bd..e47eb4694b3c 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -17,6 +17,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/efi.h>
 #include <linux/pgtable.h>
+#include <linux/protected_guest.h>
 
 #include <asm/set_memory.h>
 #include <asm/e820/api.h>
@@ -26,6 +27,7 @@
 #include <asm/pgalloc.h>
 #include <asm/memtype.h>
 #include <asm/setup.h>
+#include <asm/tdx.h>
 
 #include "physaddr.h"
 
@@ -87,12 +89,12 @@ static unsigned int __ioremap_check_ram(struct resource *res)
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
@@ -246,6 +248,8 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	prot = PAGE_KERNEL_IO;
 	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
 		prot = pgprot_encrypted(prot);
+	else if (prot_guest_has(PR_GUEST_SHARED_MAPPING_INIT))
+		prot = pgprot_protected_guest(prot);
 
 	switch (pcm) {
 	case _PAGE_CACHE_MODE_UC:
-- 
2.25.1

