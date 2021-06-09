Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CE53A1F7B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhFIV55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:57:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:1786 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbhFIV5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:57:51 -0400
IronPort-SDR: 4xl7RBgjAXAOMh9XvgW27MYFNEPfux9c3jdWsxWXZE2PJBMB1eYQQwr/L53Gxo5GczyF22tllw
 ZhRDZ04tumWA==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="205208553"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="205208553"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:55:56 -0700
IronPort-SDR: hI2NpG9d1K/kDxaeizyn4acsgmDr54vPLc0naw/LU9BUr77dbs5m4N8jG7UtDQfYXvWhDdf30z
 FqR5PXmi6gBQ==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="482555112"
Received: from qwang4-mobl1.ccr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.35.228])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:55:55 -0700
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
Subject: [PATCH v1 6/7] x86/kvm: Use bounce buffers for TD guest
Date:   Wed,  9 Jun 2021 14:55:36 -0700
Message-Id: <20210609215537.1956150-7-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609215537.1956150-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210609215537.1956150-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
index c90871a10443..1caf9fa5bb30 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -9,6 +9,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <linux/sched/signal.h> /* force_sig_fault() */
+#include <linux/swiotlb.h>
 
 #include <linux/cpu.h>
 #include <linux/protected_guest.h>
@@ -535,6 +536,8 @@ void __init tdx_early_init(void)
 
 	legacy_pic = &null_legacy_pic;
 
+	swiotlb_force = SWIOTLB_FORCE;
+
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "tdg:cpu_hotplug",
 			  NULL, tdg_cpu_offline_prepare);
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 9c55a3209c88..84ee14446139 100644
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
index 8053b43298ff..2da70f58b208 100644
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
+	if (sme_me_mask || prot_guest_has(PR_GUEST_MEM_ENCRYPT))
+		swiotlb_update_mem_attributes();
+
+	if (sme_me_mask)
+		amd_mem_encrypt_init();
+}
+
-- 
2.25.1

