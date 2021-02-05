Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3415E311921
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 03:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhBFCzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 21:55:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:27740 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhBFChL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:37:11 -0500
IronPort-SDR: sBhc5ls8ZGXj/9LBFAa629ZL6f9rOag4Cx65L7QuQWdfErUhl7uI8V0t6eHZDpQmRQFaSN8gUw
 PJGnOHIBKffQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650756"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650756"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:16 -0800
IronPort-SDR: Ltn3hsKQy9h/4K28ivJaWyzFUcN9bJ2Oyos3q87YwKpJTmi0U8fRihQkmf0h2UR2efPfjqcQXt
 f/f63bf4HCrg==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183978"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:15 -0800
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
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v1 22/26] x86/tdx: Exclude Shared bit from __PHYSICAL_MASK
Date:   Fri,  5 Feb 2021 15:38:39 -0800
Message-Id: <76d1bc03ab6f12d1943f5bb83fcf0ff8eac55bc1.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

tdx_shared_mask() returns the mask that has to be set in page table
entry to make page shared with VMM.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/Kconfig           | 1 +
 arch/x86/include/asm/tdx.h | 1 +
 arch/x86/kernel/tdx.c      | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8fa654d61ac2..f10a00c4ad7f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -875,6 +875,7 @@ config INTEL_TDX_GUEST
 	select PARAVIRT_XL
 	select X86_X2APIC
 	select SECURITY_LOCKDOWN_LSM
+	select X86_MEM_ENCRYPT_COMMON
 	help
 	  Provide support for running in a trusted domain on Intel processors
 	  equipped with Trusted Domain eXtenstions. TDX is an new Intel
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index b46ae140e39b..9bbfe6520ea4 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -104,5 +104,6 @@ long tdx_kvm_hypercall3(unsigned int nr, unsigned long p1, unsigned long p2,
 long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1, unsigned long p2,
 		unsigned long p3, unsigned long p4);
 
+phys_addr_t tdx_shared_mask(void);
 #endif
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index ae37498df981..9681f4a0b4e0 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -41,6 +41,11 @@ bool is_tdx_guest(void)
 }
 EXPORT_SYMBOL_GPL(is_tdx_guest);
 
+phys_addr_t tdx_shared_mask(void)
+{
+	return 1ULL << (td_info.gpa_width - 1);
+}
+
 static void tdx_get_info(void)
 {
 	register long rcx asm("rcx");
@@ -56,6 +61,9 @@ static void tdx_get_info(void)
 
 	td_info.gpa_width = rcx & GENMASK(5, 0);
 	td_info.attributes = rdx;
+
+	/* Exclude Shared bit from the __PHYSICAL_MASK */
+	physical_mask &= ~tdx_shared_mask();
 }
 
 static __cpuidle void tdx_halt(void)
-- 
2.25.1

