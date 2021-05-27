Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F9839268E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhE0EuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:50:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:3113 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhE0EuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:50:01 -0400
IronPort-SDR: TvaOz1RQfn4CTpVZCbq9GI4bQlRBQjRyTZz35ndk6gwEBMg7Y6YOlWbSS8DKXQN2dVdDHj7w3x
 79BtJ/19TqhA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202681168"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="202681168"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:48:29 -0700
IronPort-SDR: 9bObI0lkbIxUCMOgoKu5Ut7cwQv+2oxXVhmjPwrPhDPJ9cU1daJGTDi5JhqSs4SnhHhEOjsdTs
 OziCXQSkdM7A==
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="477320659"
Received: from skgangad-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.33.45])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:48:28 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2-fix-v1 1/1] x86/mm: Move force_dma_unencrypted() to common code
Date:   Wed, 26 May 2021 21:47:36 -0700
Message-Id: <20210527044736.3984684-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <8ae486b9-6e03-52fd-ee4d-b106e087ef8d@linux.intel.com>
References: <8ae486b9-6e03-52fd-ee4d-b106e087ef8d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Intel TDX doesn't allow VMM to access guest private memory. Any
memory that is required for communication with VMM must be shared
explicitly by setting the bit in page table entry. After setting
the shared bit, the conversion must be completed with MapGPA TDVMALL.
The call informs VMM about the conversion between private/shared
mappings. The shared memory is similar to unencrypted memory in AMD
SME/SEV terminology but the underlying process of sharing/un-sharing
the memory is different for Intel TDX guest platform.

SEV assumes that I/O devices can only do DMA to "decrypted"
physical addresses without the C-bit set.  In order for the CPU
to interact with this memory, the CPU needs a decrypted mapping.
To add this support, AMD SME code forces force_dma_unencrypted()
to return true for platforms that support AMD SEV feature. It will
be used for DMA memory allocation API to trigger
set_memory_decrypted() for platforms that support AMD SEV feature.

TDX is similar. So, to communicate with I/O devices, related pages
need to be marked as shared. As mentioned above, shared memory in
TDX architecture is similar to decrypted memory in AMD SME/SEV. So
similar to AMD SEV, force_dma_unencrypted() has to forced to return
true. This support is added in other patches in this series.

So move force_dma_unencrypted() out of AMD specific code and call
AMD specific (amd_force_dma_unencrypted()) initialization function
from it. force_dma_unencrypted() will be modified by later patches
to include Intel TDX guest platform specific initialization.

Also, introduce new config option X86_MEM_ENCRYPT_COMMON that has
to be selected by all x86 memory encryption features. This will be
selected by both AMD SEV and Intel TDX guest config options.

This is preparation for TDX changes in DMA code and it has not
functional change.    

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since RFC v2:
 * Instead of moving all the contents of force_dma_unencrypted() to
   mem_encrypt_common.c, create sub function for AMD and call it
   from common code.
 * Fixed commit log as per review comments.

 arch/x86/Kconfig                 |  8 ++++++--
 arch/x86/mm/Makefile             |  2 ++
 arch/x86/mm/mem_encrypt.c        |  4 ++--
 arch/x86/mm/mem_encrypt_common.c | 22 ++++++++++++++++++++++
 4 files changed, 32 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/mm/mem_encrypt_common.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fc588a64d1a0..7bc371d8ad7d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1531,14 +1531,18 @@ config X86_CPA_STATISTICS
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
index ae78cef79980..ae4f3924f98f 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -390,8 +390,8 @@ bool noinstr sev_es_active(void)
 	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 }
 
-/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
-bool force_dma_unencrypted(struct device *dev)
+/* Override for DMA direct allocation check - AMD specific initialization */
+bool amd_force_dma_unencrypted(struct device *dev)
 {
 	/*
 	 * For SEV, all DMA must be to unencrypted addresses.
diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
new file mode 100644
index 000000000000..5ebf04482feb
--- /dev/null
+++ b/arch/x86/mm/mem_encrypt_common.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Memory Encryption Support Common Code
+ *
+ * Copyright (C) 2021 Intel Corporation
+ *
+ * Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
+ */
+
+#include <linux/mem_encrypt.h>
+#include <linux/dma-mapping.h>
+
+bool amd_force_dma_unencrypted(struct device *dev);
+
+/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
+bool force_dma_unencrypted(struct device *dev)
+{
+	if (sev_active() || sme_active())
+		return amd_force_dma_unencrypted(dev);
+
+	return false;
+}
-- 
2.25.1

