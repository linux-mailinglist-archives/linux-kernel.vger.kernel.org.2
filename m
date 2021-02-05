Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CB23119D3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhBFDU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:20:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:27618 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhBFCm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:42:28 -0500
IronPort-SDR: i5IYJ4kRs695HKp1O6zV93PTux4KZ8vN1KzJVC72uX2k0hMLM6degFyWralXZDkkdWOWs4MUIr
 5u3+8mlUnNSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650764"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650764"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:17 -0800
IronPort-SDR: 3OqvPMokJbY5/lPq+f9clMaW9NYGxcFC88aPsD0kXsNKy6UFRSqVetToQiRutjFmWuhGSlIOd2
 uxaQjC6IcTag==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183988"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:17 -0800
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
        Kai Huang <kai.huang@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v1 25/26] x86/tdx: Make DMA pages shared
Date:   Fri,  5 Feb 2021 15:38:42 -0800
Message-Id: <0bc9209a36760ee7c8591322327ddbfe87351b09.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
accepted by the

BUG() if TDACCEPTPAGE fails (except the above case), as the guest is
completely hosed if it can't access memory.

Tested-by: Kai Huang <kai.huang@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/tdx.h       |  3 +++
 arch/x86/kernel/tdx.c            | 29 ++++++++++++++++++++++++++---
 arch/x86/mm/mem_encrypt_common.c |  4 ++--
 arch/x86/mm/pat/set_memory.c     | 23 ++++++++++++++++++-----
 4 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index efffdef35c78..9b66c3a5cf83 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -8,6 +8,9 @@
 #define TDVMCALL	0
 #define TDINFO		1
 #define TDGETVEINFO	3
+#define TDACCEPTPAGE	6
+
+#define TDX_PAGE_ALREADY_ACCEPTED       0x00000B0A00000000
 
 /* TDVMCALL R10 Input */
 #define TDVMCALL_STANDARD	0
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index f99fe54b4f88..f51a19168adc 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -68,7 +68,7 @@ static void tdx_get_info(void)
 	physical_mask &= ~tdx_shared_mask();
 }
 
-int tdx_map_gpa(phys_addr_t gpa, int numpages, bool private)
+static int __tdx_map_gpa(phys_addr_t gpa, int numpages, bool private)
 {
 	register long r10 asm("r10") = TDVMCALL_STANDARD;
 	register long r11 asm("r11") = TDVMCALL_MAP_GPA;
@@ -89,11 +89,34 @@ int tdx_map_gpa(phys_addr_t gpa, int numpages, bool private)
 			  "r"(r13)
 			: );
 
-	// Host kernel doesn't implement it yet.
-	// WARN_ON(ret || r10);
+	WARN_ON(ret || r10);
 	return ret || r10 ? -EIO : 0;
 }
 
+static void tdx_accept_page(phys_addr_t gpa)
+{
+	u64 ret;
+
+	asm volatile(TDCALL : "=a"(ret) : "a"(TDACCEPTPAGE), "c"(gpa));
+
+	BUG_ON(ret && (ret & ~0xffull) != TDX_PAGE_ALREADY_ACCEPTED);
+}
+
+
+int tdx_map_gpa(phys_addr_t gpa, int numpages, bool private)
+{
+	int ret, i;
+
+	ret = __tdx_map_gpa(gpa, numpages, private);
+	if (ret || !private)
+		return ret;
+
+	for (i = 0; i < numpages; i++)
+		tdx_accept_page(gpa + i*PAGE_SIZE);
+
+	return 0;
+}
+
 static __cpuidle void tdx_halt(void)
 {
 	register long r10 asm("r10") = TDVMCALL_STANDARD;
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
index 16f878c26667..6f23a9816ef0 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -27,6 +27,7 @@
 #include <asm/proto.h>
 #include <asm/memtype.h>
 #include <asm/set_memory.h>
+#include <asm/tdx.h>
 
 #include "../mm_internal.h"
 
@@ -1977,8 +1978,8 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	struct cpa_data cpa;
 	int ret;
 
-	/* Nothing to do if memory encryption is not active */
-	if (!mem_encrypt_active())
+	/* Nothing to do if memory encryption and TDX are not active */
+	if (!mem_encrypt_active() && !is_tdx_guest())
 		return 0;
 
 	/* Should not be working on unaligned addresses */
@@ -1988,8 +1989,14 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	memset(&cpa, 0, sizeof(cpa));
 	cpa.vaddr = &addr;
 	cpa.numpages = numpages;
-	cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
-	cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
+	if (is_tdx_guest()) {
+		cpa.mask_set = __pgprot(enc ? 0 : tdx_shared_mask());
+		cpa.mask_clr = __pgprot(enc ? tdx_shared_mask() : 0);
+	} else {
+		cpa.mask_set = __pgprot(enc ? _PAGE_ENC : 0);
+		cpa.mask_clr = __pgprot(enc ? 0 : _PAGE_ENC);
+	}
+
 	cpa.pgd = init_mm.pgd;
 
 	/* Must avoid aliasing mappings in the highmem code */
@@ -1999,7 +2006,8 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	/*
 	 * Before changing the encryption attribute, we need to flush caches.
 	 */
-	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
+	if (!enc || !is_tdx_guest())
+		cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -2012,6 +2020,11 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	 */
 	cpa_flush(&cpa, 0);
 
+	if (!ret && is_tdx_guest()) {
+		ret = tdx_map_gpa(__pa(addr), numpages, enc);
+		// XXX: need to undo on error?
+	}
+
 	return ret;
 }
 
-- 
2.25.1

