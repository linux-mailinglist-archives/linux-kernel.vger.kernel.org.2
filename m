Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E1E396AD8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 04:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhFACFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 22:05:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:15901 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232132AbhFACFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 22:05:08 -0400
IronPort-SDR: m5F6g8aUmTWPVl/mnXQt4jvjwF+5i8SpWtor9IOFRNP5F2Ow6/4wiVQsoYhFfpZSj39H1U11oz
 cvvI/RgcrPCQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="267332161"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="267332161"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 19:03:27 -0700
IronPort-SDR: T0HhPcU3LUhlpMXsdvkZNWGRMSCTRZrvkw2oOQoPkxQFDD/Ny3WOn54bPdAjyblncuoZojHruQ
 cHLmSoCGxZ1w==
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="445151825"
Received: from mjdelaro-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.3.23])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 19:03:25 -0700
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
Subject: [RFC v2-fix-v1 1/1] x86/kvm: Use bounce buffers for TD guest
Date:   Mon, 31 May 2021 19:03:16 -0700
Message-Id: <20210601020316.3736-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <de4b67fc6b23718e0cc01aac6efff35f4ef1ad8c.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <de4b67fc6b23718e0cc01aac6efff35f4ef1ad8c.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Intel TDX doesn't allow VMM to directly access guest private
memory. Any memory that is required for communication with
VMM must be shared explicitly. The same rule applies for any
any DMA to and fromTDX guest. All DMA pages had to marked as
shared pages. A generic way to achieve this without any changes
to device drivers is to use the SWIOTLB framework.

This method of handling is similar to AMD SEV. So extend this
support for TDX guest as well. Also since there are some common
code between AMD SEV and TDX guest in mem_encrypt_init(), move it
to mem_encrypt_common.c and call AMD specific init function from
it

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since RFC v2:
 * Fixed commit log as per review comments.
 * Instead of moving all AMD related changes to mem_encrypt_common.c,
   created a AMD specific helper function amd_mem_encrypt_init() and
   called it from mem_encrypt_init().
 * Removed redundant changes in arch/x86/kernel/pci-swiotlb.c.

 arch/x86/include/asm/mem_encrypt_common.h |  2 ++
 arch/x86/kernel/tdx.c                     |  3 +++
 arch/x86/mm/mem_encrypt.c                 |  5 +----
 arch/x86/mm/mem_encrypt_common.c          | 16 ++++++++++++++++
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt_common.h b/arch/x86/include/asm/mem_encrypt_common.h
index 697bc40a4e3d..48d98a3d64fd 100644
--- a/arch/x86/include/asm/mem_encrypt_common.h
+++ b/arch/x86/include/asm/mem_encrypt_common.h
@@ -8,11 +8,13 @@
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 bool amd_force_dma_unencrypted(struct device *dev);
+void __init amd_mem_encrypt_init(void);
 #else /* CONFIG_AMD_MEM_ENCRYPT */
 static inline bool amd_force_dma_unencrypted(struct device *dev)
 {
 	return false;
 }
+static inline void amd_mem_encrypt_init(void) {}
 #endif /* CONFIG_AMD_MEM_ENCRYPT */
 
 #endif
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index e84ae4f302b8..31aa47ba8f91 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -8,6 +8,7 @@
 #include <asm/vmx.h>
 #include <asm/insn.h>
 #include <linux/sched/signal.h> /* force_sig_fault() */
+#include <linux/swiotlb.h>
 
 #include <linux/cpu.h>
 #include <linux/protected_guest.h>
@@ -536,6 +537,8 @@ void __init tdx_early_init(void)
 
 	legacy_pic = &null_legacy_pic;
 
+	swiotlb_force = SWIOTLB_FORCE;
+
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "tdg:cpu_hotplug",
 			  NULL, tdg_cpu_offline_prepare);
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 5a81f73dd61e..073f2105b4af 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -467,14 +467,11 @@ static void print_mem_encrypt_feature_info(void)
 }
 
 /* Architecture __weak replacement functions */
-void __init mem_encrypt_init(void)
+void __init amd_mem_encrypt_init(void)
 {
 	if (!sme_me_mask)
 		return;
 
-	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
-	swiotlb_update_mem_attributes();
-
 	/*
 	 * With SEV, we need to unroll the rep string I/O instructions,
 	 * but SEV-ES supports them through the #VC handler.
diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
index 661c9457c02e..24c9117547b4 100644
--- a/arch/x86/mm/mem_encrypt_common.c
+++ b/arch/x86/mm/mem_encrypt_common.c
@@ -9,6 +9,7 @@
 
 #include <asm/mem_encrypt_common.h>
 #include <linux/dma-mapping.h>
+#include <linux/swiotlb.h>
 
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
@@ -21,3 +22,18 @@ bool force_dma_unencrypted(struct device *dev)
 
 	return false;
 }
+
+/* Architecture __weak replacement functions */
+void __init mem_encrypt_init(void)
+{
+	/*
+	 * For TDX guest or SEV/SME, call into SWIOTLB to update
+	 * the SWIOTLB DMA buffers
+	 */
+	if (sme_me_mask || protected_guest_has(VM_MEM_ENCRYPT))
+		swiotlb_update_mem_attributes();
+
+	if (sme_me_mask)
+		amd_mem_encrypt_init();
+}
+
-- 
2.25.1

