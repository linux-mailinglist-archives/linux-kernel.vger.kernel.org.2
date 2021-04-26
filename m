Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4D136B8A8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbhDZSFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:05:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:20709 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234483AbhDZSDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:46 -0400
IronPort-SDR: 3RmuRWqVo2NnPP8vjunJINIsiV/flcVzpdpyRQB1kpf9FdlMtXefmdEdQd+JmtGNbNGUgMIc28
 ilGetF5u8Bxg==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="257683627"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="257683627"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:58 -0700
IronPort-SDR: MdhlhyPypj5GvO3iUC/NQe1JquciD4vAJ4ovZ7bu0KKgPHNbCZa7E42MiFs7dcfnH0w4dOkqT3
 QcBlWHpPgwhQ==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353461"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:58 -0700
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
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2 31/32] x86/kvm: Use bounce buffers for TD guest
Date:   Mon, 26 Apr 2021 11:01:58 -0700
Message-Id: <de4b67fc6b23718e0cc01aac6efff35f4ef1ad8c.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

TDX doesn't allow to perform DMA access to guest private memory.
In order for DMA to work properly in TD guest, user SWIOTLB bounce
buffers.

Move AMD SEV initialization into common code and adopt for TDX.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/io.h        |  3 +-
 arch/x86/kernel/pci-swiotlb.c    |  2 +-
 arch/x86/kernel/tdx.c            |  3 ++
 arch/x86/mm/mem_encrypt.c        | 45 ------------------------------
 arch/x86/mm/mem_encrypt_common.c | 47 ++++++++++++++++++++++++++++++++
 5 files changed, 53 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 30a3b30395ad..658d9c2c2a9a 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -257,10 +257,11 @@ static inline void slow_down_io(void)
 
 #endif
 
+extern struct static_key_false sev_enable_key;
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 #include <linux/jump_label.h>
 
-extern struct static_key_false sev_enable_key;
 static inline bool sev_key_active(void)
 {
 	return static_branch_unlikely(&sev_enable_key);
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index c2cfa5e7c152..020e13749758 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -49,7 +49,7 @@ int __init pci_swiotlb_detect_4gb(void)
 	 * buffers are allocated and used for devices that do not support
 	 * the addressing range required for the encryption mask.
 	 */
-	if (sme_active())
+	if (sme_active() || is_tdx_guest())
 		swiotlb = 1;
 
 	return swiotlb;
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 44dd12c693d0..6b07e7b4a69c 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -8,6 +8,7 @@
 #include <asm/vmx.h>
 #include <asm/insn.h>
 #include <linux/sched/signal.h> /* force_sig_fault() */
+#include <linux/swiotlb.h>
 
 #include <linux/cpu.h>
 
@@ -470,6 +471,8 @@ void __init tdx_early_init(void)
 
 	legacy_pic = &null_legacy_pic;
 
+	swiotlb_force = SWIOTLB_FORCE;
+
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "tdg:cpu_hotplug",
 			  NULL, tdg_cpu_offline_prepare);
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 6f713c6a32b2..761a98904aa2 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -409,48 +409,3 @@ void __init mem_encrypt_free_decrypted_mem(void)
 
 	free_init_pages("unused decrypted", vaddr, vaddr_end);
 }
-
-static void print_mem_encrypt_feature_info(void)
-{
-	pr_info("AMD Memory Encryption Features active:");
-
-	/* Secure Memory Encryption */
-	if (sme_active()) {
-		/*
-		 * SME is mutually exclusive with any of the SEV
-		 * features below.
-		 */
-		pr_cont(" SME\n");
-		return;
-	}
-
-	/* Secure Encrypted Virtualization */
-	if (sev_active())
-		pr_cont(" SEV");
-
-	/* Encrypted Register State */
-	if (sev_es_active())
-		pr_cont(" SEV-ES");
-
-	pr_cont("\n");
-}
-
-/* Architecture __weak replacement functions */
-void __init mem_encrypt_init(void)
-{
-	if (!sme_me_mask)
-		return;
-
-	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
-	swiotlb_update_mem_attributes();
-
-	/*
-	 * With SEV, we need to unroll the rep string I/O instructions,
-	 * but SEV-ES supports them through the #VC handler.
-	 */
-	if (sev_active() && !sev_es_active())
-		static_branch_enable(&sev_enable_key);
-
-	print_mem_encrypt_feature_info();
-}
-
diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
index b6d93b0c5dcf..625c15fa92f9 100644
--- a/arch/x86/mm/mem_encrypt_common.c
+++ b/arch/x86/mm/mem_encrypt_common.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/mem_encrypt.h>
 #include <linux/dma-mapping.h>
+#include <linux/swiotlb.h>
 
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
@@ -36,3 +37,49 @@ bool force_dma_unencrypted(struct device *dev)
 
 	return false;
 }
+
+static void print_amd_mem_encrypt_feature_info(void)
+{
+	pr_info("AMD Memory Encryption Features active:");
+
+	/* Secure Memory Encryption */
+	if (sme_active()) {
+		/*
+		 * SME is mutually exclusive with any of the SEV
+		 * features below.
+		 */
+		pr_cont(" SME\n");
+		return;
+	}
+
+	/* Secure Encrypted Virtualization */
+	if (sev_active())
+		pr_cont(" SEV");
+
+	/* Encrypted Register State */
+	if (sev_es_active())
+		pr_cont(" SEV-ES");
+
+	pr_cont("\n");
+}
+
+/* Architecture __weak replacement functions */
+void __init mem_encrypt_init(void)
+{
+	if (!sme_me_mask && !is_tdx_guest())
+		return;
+
+	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
+	swiotlb_update_mem_attributes();
+
+	/*
+	 * With SEV, we need to unroll the rep string I/O instructions,
+	 * but SEV-ES supports them through the #VC handler.
+	 */
+	if (sev_active() && !sev_es_active())
+		static_branch_enable(&sev_enable_key);
+
+	/* sme_me_mask !=0 means SME or SEV */
+	if (sme_me_mask)
+		print_amd_mem_encrypt_feature_info();
+}
-- 
2.25.1

