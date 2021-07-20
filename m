Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86B43CF312
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 06:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345388AbhGTDhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 23:37:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:8869 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234608AbhGTDeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 23:34:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="232950393"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="232950393"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:13:55 -0700
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="468818645"
Received: from ywei11-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.31])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:13:54 -0700
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
Subject: [PATCH v3 6/7] x86/kvm: Use bounce buffers for TD guest
Date:   Mon, 19 Jul 2021 21:13:45 -0700
Message-Id: <20210720041346.2121680-7-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720041346.2121680-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210720041346.2121680-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v1:
 * Removed sme_me_mask check for amd_mem_encrypt_init() in mem_encrypt_init().

 arch/x86/include/asm/mem_encrypt_common.h |  2 ++
 arch/x86/kernel/tdx.c                     |  3 +++
 arch/x86/mm/mem_encrypt.c                 |  5 +----
 arch/x86/mm/mem_encrypt_common.c          | 14 ++++++++++++++
 4 files changed, 20 insertions(+), 4 deletions(-)

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
index 2f2ed2e255aa..6f818dcf945c 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -13,6 +13,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <linux/sched/signal.h> /* force_sig_fault() */
+#include <linux/swiotlb.h>
 
 /* TDX Module call Leaf IDs */
 #define TDINFO				1
@@ -518,6 +519,8 @@ void __init tdx_early_init(void)
 
 	legacy_pic = &null_legacy_pic;
 
+	swiotlb_force = SWIOTLB_FORCE;
+
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "tdg:cpu_hotplug",
 			  NULL, tdg_cpu_offline_prepare);
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 87178d69d7d1..fa7b0c5fa54b 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -466,14 +466,11 @@ static void print_mem_encrypt_feature_info(void)
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
index 23db7197f1e1..6f68340e8eac 100644
--- a/arch/x86/mm/mem_encrypt_common.c
+++ b/arch/x86/mm/mem_encrypt_common.c
@@ -10,6 +10,7 @@
 #include <asm/mem_encrypt_common.h>
 #include <linux/dma-mapping.h>
 #include <linux/protected_guest.h>
+#include <linux/swiotlb.h>
 
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
@@ -22,3 +23,16 @@ bool force_dma_unencrypted(struct device *dev)
 
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
+	if (sme_me_mask || prot_guest_has(PR_GUEST_MEM_ENCRYPT))
+		swiotlb_update_mem_attributes();
+
+	amd_mem_encrypt_init();
+}
-- 
2.25.1

