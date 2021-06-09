Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F6A3A1F77
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhFIV5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:57:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:1779 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229966AbhFIV5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:57:45 -0400
IronPort-SDR: esmI3391Il/YQCfm4/c9V946p+JHW5Geg4EjhGZMHqxPLNJ49g4sWvWsA6f6XRVTcbLAuQByF8
 kj0KTRX96NHA==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="205208541"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="205208541"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:55:50 -0700
IronPort-SDR: VBrQArJCcd2n61mgUmPAvU8SEAWgRty4mZFipSOPQw9MIrV9DXxUPyg9Pp8voD+wO15n9nLVlf
 cXqgk8tHE9ZQ==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="482555070"
Received: from qwang4-mobl1.ccr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.35.228])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:55:48 -0700
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
Subject: [PATCH v1 2/7] x86/tdx: Exclude Shared bit from physical_mask
Date:   Wed,  9 Jun 2021 14:55:32 -0700
Message-Id: <20210609215537.1956150-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609215537.1956150-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210609215537.1956150-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Also, note that we cannot club shared mapping configuration between
AMD SME and Intel TDX Guest platforms in common function. SME has
to do it very early in __startup_64() as it sets the bit on all
memory, except what is used for communication. TDX can postpone it,
as it don't need any shared mapping in very early boot.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/Kconfig           | 1 +
 arch/x86/include/asm/tdx.h | 6 ++++++
 arch/x86/kernel/tdx.c      | 9 +++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2adc0df1838b..1ee034d2d3ba 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -884,6 +884,7 @@ config INTEL_TDX_GUEST
 	select X86_X2APIC
 	select SECURITY_LOCKDOWN_LSM
 	select ARCH_HAS_PROTECTED_GUEST
+	select X86_MEM_ENCRYPT_COMMON
 	help
 	  Provide support for running in a trusted domain on Intel processors
 	  equipped with Trusted Domain eXtenstions. TDX is a new Intel
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index fab5eebf4023..70e0931bbf52 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -122,6 +122,8 @@ do {									\
 } while (0)
 #endif
 
+extern phys_addr_t tdg_shared_mask(void);
+
 #else // !CONFIG_INTEL_TDX_GUEST
 
 static inline bool is_tdx_guest(void)
@@ -141,6 +143,10 @@ static inline bool tdg_early_handle_ve(struct pt_regs *regs)
 	return false;
 }
 
+static inline phys_addr_t tdg_shared_mask(void)
+{
+	return 0;
+}
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #ifdef CONFIG_INTEL_TDX_GUEST_KVM
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 06fcbca402cb..1cd572a35eea 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -99,6 +99,12 @@ bool tdx_protected_guest_has(unsigned long flag)
 }
 EXPORT_SYMBOL_GPL(tdx_protected_guest_has);
 
+/* The highest bit of a guest physical address is the "sharing" bit */
+phys_addr_t tdg_shared_mask(void)
+{
+	return 1ULL << (td_info.gpa_width - 1);
+}
+
 static void tdg_get_info(void)
 {
 	u64 ret;
@@ -110,6 +116,9 @@ static void tdg_get_info(void)
 
 	td_info.gpa_width = out.rcx & GENMASK(5, 0);
 	td_info.attributes = out.rdx;
+
+	/* Exclude Shared bit from the __PHYSICAL_MASK */
+	physical_mask &= ~tdg_shared_mask();
 }
 
 static __cpuidle void tdg_halt(void)
-- 
2.25.1

