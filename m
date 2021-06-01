Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B23396AD9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 04:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhFACHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 22:07:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:55987 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232132AbhFACHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 22:07:45 -0400
IronPort-SDR: AXWxoRNO+9vDutkjxMhzH4aL8ByQIBorTmjszu5SYdSnorjHVSjeY8zRXyrYZ71/G98g4rDSwN
 YtlCF59y0YHw==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="224725290"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="224725290"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 19:06:05 -0700
IronPort-SDR: C+MbI/ug9XIa1LxIf/Pnj8bxoa6zi1zPsC5JOHDa0CKza7+K6ztesRBRwL8GwU+dZ6n0hWCaLF
 /QMPySvm30MQ==
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="479093632"
Received: from mjdelaro-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.3.23])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 19:06:04 -0700
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
Subject: [RFC v2-fix-v2 1/1] x86/tdx: Make DMA pages shared
Date:   Mon, 31 May 2021 19:06:02 -0700
Message-Id: <20210601020602.3856-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3f392477-12b9-ff16-8e32-b00b6593d82a@intel.com>
References: <3f392477-12b9-ff16-8e32-b00b6593d82a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Just like MKTME, TDX reassigns bits of the physical address for
metadata.  MKTME used several bits for an encryption KeyID. TDX
uses a single bit in guests to communicate whether a physical page
should be protected by TDX as private memory (bit set to 0) or
unprotected and shared with the VMM (bit set to 1).

__set_memory_enc_dec() is now aware about TDX and sets Shared bit
accordingly following with relevant TDX hypercall.

Also, Do TDACCEPTPAGE on every 4k page after mapping the GPA range
when converting memory to private. Using 4k page size limit is due
to current TDX spec restriction. Also, If the GPA (range) was
already mapped as an active, private page, the host VMM may remove
the private page from the TD by following the “Removing TD Private
Pages” sequence in the Intel TDX-module specification [1] to safely
block the mapping(s), flush the TLB and cache, and remove the
mapping(s).

BUG() if TDACCEPTPAGE fails (except "previously accepted page" case)
, as the guest is completely hosed if it can't access memory. 

[1] https://software.intel.com/content/dam/develop/external/us/en/documents/tdx-module-1eas-v0.85.039.pdf

Tested-by: Kai Huang <kai.huang@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since RFC v2-fix:
 * Using seperate file for Intel TDX specific memory initialization
   breaks binary compatibility (between AMD/TDX). So revert back to
   older version.
 * Fixed the commit log to reflect the above change.
 * Replaced is_tdx_guest() checks with appropriate
   protected_guest_has() checks.
 * Used tdx_hcall_gpa_intent() instead of __tdg_map_gpa() call.
 * Removed __tdg_map_gpa() helper function and added tdg_accept_page()
   related changes to tdx_hcall_gpa_intent().
 * Used pgprot_pg_shared_mask() macro for __pgprot(tdg_shared_mask()).
 * Fixed commit log  as per review comments.

Changes since RFC v2:
 * Since the common code between AMD-SEV and TDX is very minimal,
   defining a new config (X86_MEM_ENCRYPT_COMMON) for common code
   is not very useful. So createed a seperate file for Intel TDX
   specific memory initialization (similar to AMD SEV).
 * Removed patch titled "x86/mm: Move force_dma_unencrypted() to
   common code" from this series. And merged required changes in
   this patch.

 arch/x86/include/asm/pgtable.h   |  1 +
 arch/x86/kernel/tdx.c            | 34 ++++++++++++++++++-----
 arch/x86/mm/mem_encrypt_common.c |  3 +++
 arch/x86/mm/pat/set_memory.c     | 46 +++++++++++++++++++++++++++-----
 4 files changed, 71 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 7988e1fc2ce9..87c93815c4d7 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -24,6 +24,7 @@
 /* Make the page accesable by VMM for protected guests */
 #define pgprot_protected_guest(prot) __pgprot(pgprot_val(prot) |	\
 					      tdg_shared_mask())
+#define pgprot_pg_shared_mask() __pgprot(tdg_shared_mask())
 
 #ifndef __ASSEMBLY__
 #include <asm/x86_init.h>
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 07610eab1c64..e84ae4f302b8 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -15,10 +15,14 @@
 /* TDX Module call Leaf IDs */
 #define TDINFO				1
 #define TDGETVEINFO			3
+#define TDACCEPTPAGE			6
 
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
 
+/* TDX Module call error codes */
+#define TDX_PAGE_ALREADY_ACCEPTED       0x8000000000000001
+
 #define VE_GET_IO_TYPE(exit_qual)      (((exit_qual) & 8) ? 0 : 1)
 #define VE_GET_IO_SIZE(exit_qual)      (((exit_qual) & 7) + 1)
 #define VE_GET_PORT_NUM(exit_qual)     ((exit_qual) >> 16)
@@ -126,25 +130,43 @@ static void tdg_get_info(void)
 	physical_mask &= ~tdg_shared_mask();
 }
 
+static void tdg_accept_page(phys_addr_t gpa)
+{
+	u64 ret;
+
+	ret = __tdx_module_call(TDACCEPTPAGE, gpa, 0, 0, 0, NULL);
+
+	BUG_ON(ret && ret != TDX_PAGE_ALREADY_ACCEPTED);
+}
+
 /*
  * Inform the VMM of the guest's intent for this physical page:
  * shared with the VMM or private to the guest.  The VMM is
  * expected to change its mapping of the page in response.
- *
- * Note: shared->private conversions require further guest
- * action to accept the page.
  */
 int tdx_hcall_gpa_intent(phys_addr_t gpa, int numpages,
 			 enum tdx_map_type map_type)
 {
-	u64 ret;
+	u64 ret = 0;
+	int i;
 
 	if (map_type == TDX_MAP_SHARED)
 		gpa |= tdg_shared_mask();
 
-	ret = tdx_hypercall(TDVMCALL_MAP_GPA, gpa, PAGE_SIZE * numpages, 0, 0);
+	if (tdx_hypercall(TDVMCALL_MAP_GPA, gpa, PAGE_SIZE * numpages, 0, 0))
+		ret = -EIO;
 
-	return ret ? -EIO : 0;
+	if (ret || map_type == TDX_MAP_SHARED)
+		return ret;
+
+	/*
+	 * For shared->private conversion, accept the page using TDACCEPTPAGE
+	 * TDX module call.
+	 */
+	for (i = 0; i < numpages; i++)
+		tdg_accept_page(gpa + i * PAGE_SIZE);
+
+	return 0;
 }
 
 static __cpuidle void tdg_halt(void)
diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
index 4a9a4d5f36cd..661c9457c02e 100644
--- a/arch/x86/mm/mem_encrypt_common.c
+++ b/arch/x86/mm/mem_encrypt_common.c
@@ -16,5 +16,8 @@ bool force_dma_unencrypted(struct device *dev)
 	if (sev_active() || sme_active())
 		return amd_force_dma_unencrypted(dev);
 
+	if (protected_guest_has(VM_MEM_ENCRYPT))
+		return true;
+
 	return false;
 }
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 16f878c26667..56ea2079cc36 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -27,6 +27,7 @@
 #include <asm/proto.h>
 #include <asm/memtype.h>
 #include <asm/set_memory.h>
+#include <asm/tdx.h>
 
 #include "../mm_internal.h"
 
@@ -1972,13 +1973,16 @@ int set_memory_global(unsigned long addr, int numpages)
 				    __pgprot(_PAGE_GLOBAL), 0);
 }
 
-static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
+static int __set_memory_protect(unsigned long addr, int numpages, bool protect)
 {
+	pgprot_t mem_protected_bits, mem_plain_bits;
 	struct cpa_data cpa;
+	enum tdx_map_type map_type;
 	int ret;
 
 	/* Nothing to do if memory encryption is not active */
-	if (!mem_encrypt_active())
+	if (!mem_encrypt_active() &&
+	    !protected_guest_has(VM_MEM_ENCRYPT_ACTIVE))
 		return 0;
 
 	/* Should not be working on unaligned addresses */
@@ -1988,8 +1992,25 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	memset(&cpa, 0, sizeof(cpa));
 	cpa.vaddr = &addr;
 	cpa.numpages = numpages;
-	cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
-	cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
+
+	if (protected_guest_has(VM_SHARED_MAPPING_INIT)) {
+		mem_protected_bits = __pgprot(0);
+		mem_plain_bits = pgprot_pg_shared_mask();
+	} else {
+		mem_protected_bits = __pgprot(_PAGE_ENC);
+		mem_plain_bits = __pgprot(0);
+	}
+
+	if (protect) {
+		cpa.mask_set = mem_protected_bits;
+		cpa.mask_clr = mem_plain_bits;
+		map_type = TDX_MAP_PRIVATE;
+	} else {
+		cpa.mask_set = mem_plain_bits;
+		cpa.mask_clr = mem_protected_bits;
+		map_type = TDX_MAP_SHARED;
+	}
+
 	cpa.pgd = init_mm.pgd;
 
 	/* Must avoid aliasing mappings in the highmem code */
@@ -1998,8 +2019,16 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 
 	/*
 	 * Before changing the encryption attribute, we need to flush caches.
+	 *
+	 * For TDX we need to flush caches on private->shared. VMM is
+	 * responsible for flushing on shared->private.
 	 */
-	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
+	if (is_tdx_guest()) {
+		if (map_type == TDX_MAP_SHARED)
+			cpa_flush(&cpa, 1);
+	} else {
+		cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
+	}
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -2012,18 +2041,21 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	 */
 	cpa_flush(&cpa, 0);
 
+	if (!ret && protected_guest_has(VM_SHARED_MAPPING_INIT))
+		ret = tdx_hcall_gpa_intent(__pa(addr), numpages, map_type);
+
 	return ret;
 }
 
 int set_memory_encrypted(unsigned long addr, int numpages)
 {
-	return __set_memory_enc_dec(addr, numpages, true);
+	return __set_memory_protect(addr, numpages, true);
 }
 EXPORT_SYMBOL_GPL(set_memory_encrypted);
 
 int set_memory_decrypted(unsigned long addr, int numpages)
 {
-	return __set_memory_enc_dec(addr, numpages, false);
+	return __set_memory_protect(addr, numpages, false);
 }
 EXPORT_SYMBOL_GPL(set_memory_decrypted);
 
-- 
2.25.1

