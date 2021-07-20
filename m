Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11783CF30C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 06:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343836AbhGTDfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 23:35:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:8869 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241191AbhGTDeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 23:34:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="232950377"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="232950377"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:13:52 -0700
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="468818632"
Received: from ywei11-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.31])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:13:52 -0700
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
Subject: [PATCH v3 2/7] x86/tdx: Exclude Shared bit from physical_mask
Date:   Mon, 19 Jul 2021 21:13:41 -0700
Message-Id: <20210720041346.2121680-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720041346.2121680-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210720041346.2121680-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
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

Add a helper, tdg_shared_mask() to generate the mask.  The processor
enumerates its physical address width to include the shared bit, which
means it gets included in __PHYSICAL_MASK by default.

Remove the shared mask from 'physical_mask' since any bits in
tdg_shared_mask() are not used for physical addresses in page table
entries.

Also, note that shared mapping configuration cannot be clubbed between
AMD SME and Intel TDX Guest platforms in common function. SME has
to do it very early in __startup_64() as it sets the bit on all
memory, except what is used for communication. TDX can postpone it,
as it don't need any shared mapping in very early boot.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v1:
 * Fixed format issues in commit log.

 arch/x86/Kconfig           | 1 +
 arch/x86/include/asm/tdx.h | 4 ++++
 arch/x86/kernel/tdx.c      | 9 +++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9898faa83b79..2c6febebc368 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -873,6 +873,7 @@ config INTEL_TDX_GUEST
 	select X86_X2APIC
 	select SECURITY_LOCKDOWN_LSM
 	select ARCH_HAS_PROTECTED_GUEST
+	select X86_MEM_ENCRYPT_COMMON
 	help
 	  Provide support for running in a trusted domain on Intel processors
 	  equipped with Trusted Domain eXtensions. TDX is a new Intel
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 72154d3f63c2..1e2a1c6a1898 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -77,6 +77,8 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 
 bool tdg_early_handle_ve(struct pt_regs *regs);
 
+extern phys_addr_t tdg_shared_mask(void);
+
 /*
  * To support I/O port access in decompressor or early kernel init
  * code, since #VE exception handler cannot be used, use paravirt
@@ -145,6 +147,8 @@ static inline bool tdx_prot_guest_has(unsigned long flag) { return false; }
 
 static inline bool tdg_early_handle_ve(struct pt_regs *regs) { return false; }
 
+static inline phys_addr_t tdg_shared_mask(void) { return 0; }
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #ifdef CONFIG_INTEL_TDX_GUEST_KVM
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 254997315a2f..7c4998bb47f8 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -78,6 +78,12 @@ bool tdx_prot_guest_has(unsigned long flag)
 }
 EXPORT_SYMBOL_GPL(tdx_prot_guest_has);
 
+/* The highest bit of a guest physical address is the "sharing" bit */
+phys_addr_t tdg_shared_mask(void)
+{
+	return 1ULL << (td_info.gpa_width - 1);
+}
+
 static void tdg_get_info(void)
 {
 	u64 ret;
@@ -89,6 +95,9 @@ static void tdg_get_info(void)
 
 	td_info.gpa_width = out.rcx & GENMASK(5, 0);
 	td_info.attributes = out.rdx;
+
+	/* Exclude Shared bit from the __PHYSICAL_MASK */
+	physical_mask &= ~tdg_shared_mask();
 }
 
 static __cpuidle void tdg_halt(void)
-- 
2.25.1

