Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E16F36B8A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbhDZSFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:05:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:20705 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234245AbhDZSDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:45 -0400
IronPort-SDR: XZOAR1USss7eEeFiSTTIQEgiatqYTldzSJwlArYhPZZDE7rLp3/lSXQRsM4fO7zYbVH+OrSakm
 LTqBtoiHm8YQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="257683624"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="257683624"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:58 -0700
IronPort-SDR: tlTd78ZKLlC3NOmg8v0YgBjD3eD0udOl++lPr7CNOk7NlYNkvRWL0GHzkG7kPnJDX9BTd6qofY
 UEvdfQ/YvrCg==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353456"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:57 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2 30/32] x86/tdx: Make DMA pages shared
Date:   Mon, 26 Apr 2021 11:01:57 -0700
Message-Id: <1ccf5e60d2d79308d50f93c8c3b32b1394bc7baf.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Make force_dma_unencrypted() return true for TDX to get DMA pages mapped
as shared.

__set_memory_enc_dec() is now aware about TDX and sets Shared bit
accordingly following with relevant TDVMCALL.

Also, Do TDACCEPTPAGE on every 4k page after mapping the GPA range when
converting memory to private.  If the VMM uses a common pool for private
and shared memory, it will likely do TDAUGPAGE in response to MAP_GPA
(or on the first access to the private GPA), in which case TDX-Module will
hold the page in a non-present "pending" state until it is explicitly
accepted.

BUG() if TDACCEPTPAGE fails (except the above case), as the guest is
completely hosed if it can't access memory.

Tested-by: Kai Huang <kai.huang@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/tdx.h       |  3 ++
 arch/x86/kernel/tdx.c            | 26 ++++++++++++++++-
 arch/x86/mm/mem_encrypt_common.c |  4 +--
 arch/x86/mm/pat/set_memory.c     | 48 ++++++++++++++++++++++++++------
 4 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 4789798d7737..2794bf71e45c 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -19,6 +19,9 @@ enum tdx_map_type {
 
 #define TDINFO			1
 #define TDGETVEINFO		3
+#define TDACCEPTPAGE		6
+
+#define TDX_PAGE_ALREADY_ACCEPTED	0x8000000000000001
 
 struct tdcall_output {
 	u64 rcx;
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 074136473011..44dd12c693d0 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -100,7 +100,8 @@ static void tdg_get_info(void)
 	physical_mask &= ~tdg_shared_mask();
 }
 
-int tdg_map_gpa(phys_addr_t gpa, int numpages, enum tdx_map_type map_type)
+static int __tdg_map_gpa(phys_addr_t gpa, int numpages,
+			 enum tdx_map_type map_type)
 {
 	u64 ret;
 
@@ -111,6 +112,29 @@ int tdg_map_gpa(phys_addr_t gpa, int numpages, enum tdx_map_type map_type)
 	return ret ? -EIO : 0;
 }
 
+static void tdg_accept_page(phys_addr_t gpa)
+{
+	u64 ret;
+
+	ret = __tdcall(TDACCEPTPAGE, gpa, 0, 0, 0, NULL);
+
+	BUG_ON(ret && ret != TDX_PAGE_ALREADY_ACCEPTED);
+}
+
+int tdg_map_gpa(phys_addr_t gpa, int numpages, enum tdx_map_type map_type)
+{
+	int ret, i;
+
+	ret = __tdg_map_gpa(gpa, numpages, map_type);
+	if (ret || map_type == TDX_MAP_SHARED)
+		return ret;
+
+	for (i = 0; i < numpages; i++)
+		tdg_accept_page(gpa + i*PAGE_SIZE);
+
+	return 0;
+}
+
 static __cpuidle void tdg_halt(void)
 {
 	u64 ret;
diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
index 964e04152417..b6d93b0c5dcf 100644
--- a/arch/x86/mm/mem_encrypt_common.c
+++ b/arch/x86/mm/mem_encrypt_common.c
@@ -15,9 +15,9 @@
 bool force_dma_unencrypted(struct device *dev)
 {
 	/*
-	 * For SEV, all DMA must be to unencrypted/shared addresses.
+	 * For SEV and TDX, all DMA must be to unencrypted/shared addresses.
 	 */
-	if (sev_active())
+	if (sev_active() || is_tdx_guest())
 		return true;
 
 	/*
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 16f878c26667..ea78c7907847 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -27,6 +27,7 @@
 #include <asm/proto.h>
 #include <asm/memtype.h>
 #include <asm/set_memory.h>
+#include <asm/tdx.h>
 
 #include "../mm_internal.h"
 
@@ -1972,13 +1973,15 @@ int set_memory_global(unsigned long addr, int numpages)
 				    __pgprot(_PAGE_GLOBAL), 0);
 }
 
-static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
+static int __set_memory_protect(unsigned long addr, int numpages, bool protect)
 {
+	pgprot_t mem_protected_bits, mem_plain_bits;
 	struct cpa_data cpa;
+	enum tdx_map_type map_type;
 	int ret;
 
-	/* Nothing to do if memory encryption is not active */
-	if (!mem_encrypt_active())
+	/* Nothing to do if memory encryption and TDX are not active */
+	if (!mem_encrypt_active() && !is_tdx_guest())
 		return 0;
 
 	/* Should not be working on unaligned addresses */
@@ -1988,8 +1991,25 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	memset(&cpa, 0, sizeof(cpa));
 	cpa.vaddr = &addr;
 	cpa.numpages = numpages;
-	cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
-	cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
+
+	if (is_tdx_guest()) {
+		mem_protected_bits = __pgprot(0);
+		mem_plain_bits = __pgprot(tdg_shared_mask());
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
@@ -1998,8 +2018,16 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 
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
 
@@ -2012,18 +2040,22 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	 */
 	cpa_flush(&cpa, 0);
 
+	if (!ret && is_tdx_guest()) {
+		ret = tdg_map_gpa(__pa(addr), numpages, map_type);
+	}
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

