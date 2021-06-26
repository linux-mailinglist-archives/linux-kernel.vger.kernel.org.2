Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BE43B4EF7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 16:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFZO2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 10:28:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:18171 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhFZO2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 10:28:05 -0400
IronPort-SDR: Xr/dPzk2msV/Dt/Y3EkHGwrq49x+7BqI/FI0iixA8xkf5YflKFYUqY/OYR8jJJJTvssFyR9d4F
 spqt2tdXeGMw==
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="195087077"
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="195087077"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:25:42 -0700
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="640382959"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.8.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:25:42 -0700
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
Subject: [PATCH v2 3/7] x86/tdx: Make pages shared in ioremap()
Date:   Sat, 26 Jun 2021 07:25:31 -0700
Message-Id: <6f07452ce970b7054677d135b65deafe452f33dc.1624667052.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1624667052.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1624667052.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
index 12c686c65ea9..a41ea1e5d0c3 100644
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
@@ -244,6 +246,8 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	prot = PAGE_KERNEL_IO;
 	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
 		prot = pgprot_encrypted(prot);
+	else if (prot_guest_has(PR_GUEST_SHARED_MAPPING_INIT))
+		prot = pgprot_protected_guest(prot);
 
 	switch (pcm) {
 	case _PAGE_CACHE_MODE_UC:
-- 
2.25.1

