Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F599396ADA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 04:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhFACJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 22:09:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:56879 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232132AbhFACJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 22:09:26 -0400
IronPort-SDR: 96efeDu6S7E9NQ8WyPJLIu9KnoRpub3/QE1JjtQYowo9Sn4Iu+Kdk6MnzXhYHsHsvPeJWlNez7
 Yk/GiTkdTS5g==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="203455437"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="203455437"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 19:07:46 -0700
IronPort-SDR: As42Cbbr/YTVbz4sczaIX114cAxCAWGWMCM0IHzvnJRZd1sOpY5BfLD3OEZKHeKE9CgGWAYtFc
 +pjmCxqikqTw==
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="479093989"
Received: from mjdelaro-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.3.23])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 19:07:45 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2-fix-v1 1/1] x86/tdx: Make pages shared in ioremap()
Date:   Mon, 31 May 2021 19:07:36 -0700
Message-Id: <20210601020736.4011-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YLU1peNu/744jR/R@zn.tnic>
References: <YLU1peNu/744jR/R@zn.tnic>
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
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since RFC v2:
 * Replaced is_tdx_guest() checks with protected_guest_has() calls.
 * Renamed pgprot_tdg_shared() to pgprot_protected_guest()

 arch/x86/include/asm/pgtable.h | 4 ++++
 arch/x86/mm/ioremap.c          | 9 ++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a02c67291cfc..7988e1fc2ce9 100644
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
index 9e5ccc56f8e0..f0d31f6fd98c 100644
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
+	if (!sev_active() && !protected_guest_has(VM_MEM_ENCRYPT))
 		return 0;
 
 	switch (res->desc) {
@@ -244,6 +245,8 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	prot = PAGE_KERNEL_IO;
 	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
 		prot = pgprot_encrypted(prot);
+	else if (protected_guest_has(VM_SHARED_MAPPING_INIT))
+		prot = pgprot_protected_guest(prot);
 
 	switch (pcm) {
 	case _PAGE_CACHE_MODE_UC:
-- 
2.25.1

