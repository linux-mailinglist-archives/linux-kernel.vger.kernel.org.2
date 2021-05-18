Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCF3386F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 03:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbhERBUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:20:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:3514 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233019AbhERBUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:20:37 -0400
IronPort-SDR: Lm3wm05AbkS8erHyFmqUaoN3o2a5nOBbPOOnXZr9xvLCNWyJhsBP/mzrimUxfzg4ZN0yWWMRj3
 DWUxUBXgwGOQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="180204483"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="180204483"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 18:19:19 -0700
IronPort-SDR: 9uIN8SnLI9/qMmXP656eKh+ya40r+aljYbT0CqmuodWoqdrY7nrXvnQytGxO1+OFtASTIni4ZN
 tKEaoeM/BWYA==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="543901242"
Received: from sdayal-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.213.167.196])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 18:19:18 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
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
Subject: [RFC v2-fix 1/1] x86/tdx: Make DMA pages shared
Date:   Mon, 17 May 2021 18:19:12 -0700
Message-Id: <20210518011912.259112-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1ccf5e60d2d79308d50f93c8c3b32b1394bc7baf.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <1ccf5e60d2d79308d50f93c8c3b32b1394bc7baf.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Intel TDX doesn't allow VMM to access guest memory. Any memory
that is required for communication with VMM must be shared
explicitly by setting the bit in page table entry. And, after
setting the shared bit, the conversion must be completed with
MapGPA TDVMALL. The call informs VMM about the conversion and
makes it remove the GPA from the S-EPT mapping. The shared
memory is similar to unencrypted memory in AMD SME/SEV terminology
but the underlying process of sharing/un-sharing the memory is
different for Intel TDX guest platform.

SEV assumes that I/O devices can only do DMA to "decrypted"
physical addresses without the C-bit set.  In order for the CPU
to interact with this memory, the CPU needs a decrypted mapping.
To add this support, AMD SME code forces force_dma_unencrypted()
to return true for platforms that support AMD SEV feature. It will
be used for DMA memory allocation API to trigger
set_memory_decrypted() for platforms that support AMD SEV feature.

TDX is similar.  TDX architecturally prevents access to private
guest memory by anything other than the guest itself. This means
that any DMA buffers must be shared.

So create a new file mem_encrypt_tdx.c to hold TDX specific memory
initialization code, and re-define force_dma_unencrypted() for
TDX guest and make it return true to get DMA pages mapped as shared.

__set_memory_enc_dec() is now aware about TDX and sets Shared bit
accordingly following with relevant TDVMCALL.

Also, Do TDACCEPTPAGE on every 4k page after mapping the GPA range when
converting memory to private.  If the VMM uses a common pool for private
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

Changes since RFC v2:
 * Since the common code between AMD-SEV and TDX is very minimal,
   defining a new config (X86_MEM_ENCRYPT_COMMON) for common code
   is not very useful. So createed a seperate file for Intel TDX
   specific memory initialization (similar to AMD SEV).
 * Removed patch titled "x86/mm: Move force_dma_unencrypted() to
   common code" from this series. And merged required changes in
   this patch.

 arch/x86/Kconfig              |  1 +
 arch/x86/include/asm/tdx.h    |  3 +++
 arch/x86/kernel/tdx.c         | 26 ++++++++++++++++++-
 arch/x86/mm/Makefile          |  1 +
 arch/x86/mm/mem_encrypt_tdx.c | 19 ++++++++++++++
 arch/x86/mm/pat/set_memory.c  | 48 +++++++++++++++++++++++++++++------
 6 files changed, 89 insertions(+), 9 deletions(-)
 create mode 100644 arch/x86/mm/mem_encrypt_tdx.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a055594e2664..69a98bcdc07a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -879,6 +879,7 @@ config INTEL_TDX_GUEST
 	select X86_X2APIC
 	select SECURITY_LOCKDOWN_LSM
 	select ARCH_HAS_PROTECTED_GUEST
+	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select DYNAMIC_PHYSICAL_MASK
 	help
 	  Provide support for running in a trusted domain on Intel processors
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index f5e8088dabc5..4ad436cc2146 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -19,6 +19,9 @@ enum tdx_map_type {
 
 #define TDINFO			1
 #define TDGETVEINFO		3
+#define TDACCEPTPAGE		6
+
+#define TDX_PAGE_ALREADY_ACCEPTED	0x8000000000000001
 
 struct tdx_module_output {
 	u64 rcx;
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 9ddb80adc034..caf8e4c5ddbc 100644
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
+	ret = __tdx_module_call(TDACCEPTPAGE, gpa, 0, 0, 0, NULL);
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
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 5864219221ca..555dcc0cd087 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -55,3 +55,4 @@ obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
+obj-$(CONFIG_INTEL_TDX_GUEST)	+= mem_encrypt_tdx.o
diff --git a/arch/x86/mm/mem_encrypt_tdx.c b/arch/x86/mm/mem_encrypt_tdx.c
new file mode 100644
index 000000000000..f394a43bf46d
--- /dev/null
+++ b/arch/x86/mm/mem_encrypt_tdx.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel TDX Memory Encryption Support
+ *
+ * Copyright (C) 2020 Intel Corporation
+ *
+ * Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/tdx.h>
+
+/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
+bool force_dma_unencrypted(struct device *dev)
+{
+	return is_tdx_guest();
+}
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

