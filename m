Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4E6311861
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 03:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBFCgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 21:36:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:27618 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229849AbhBFCdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:33:14 -0500
IronPort-SDR: depth9JfAK55MO+n0LlOYQP0XZ46XsZMc0M2H2e9eXliuhkRqauAFrr24lAhaV0kosDKfwAR2k
 J86eBcFESruw==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650742"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650742"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:13 -0800
IronPort-SDR: dto61ySls5Zau0ceTjSVZLN4Sy9D+bBP/J2VHBW9clp0qq592MRb/7toakJ5twkEX5av8W827s
 LoEprNPB7VFA==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183942"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:12 -0800
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
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v1 16/26] x86/boot: Avoid #VE during compressed boot for TDX platforms
Date:   Fri,  5 Feb 2021 15:38:33 -0800
Message-Id: <85c6a5079e02e8bcdb87e8489e22083c07fc1d47.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Avoid operations which will inject #VE during compressed
boot, which is obviously fatal for TDX platforms.

Details are,

 1. TDX module injects #VE if a TDX guest attempts to write
    EFER. So skip the WRMSR to set EFER.LME=1 if it's already
    set. TDX also forces EFER.LME=1, i.e. the branch will always
    be taken and thus the #VE avoided.

 2. TDX module also injects a #VE if the guest attempts to clear
    CR0.NE. Ensure CR0.NE is set when loading CR0 during compressed
    boot. The Setting CR0.NE should be a nop on all CPUs that
    support 64-bit mode.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/boot/compressed/head_64.S | 5 +++--
 arch/x86/boot/compressed/pgtable.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index e94874f4bbc1..37c2f37d4a0d 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -616,8 +616,9 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	$MSR_EFER, %ecx
 	rdmsr
 	btsl	$_EFER_LME, %eax
+	jc	1f
 	wrmsr
-	popl	%edx
+1:	popl	%edx
 	popl	%ecx
 
 	/* Enable PAE and LA57 (if required) paging modes */
@@ -636,7 +637,7 @@ SYM_CODE_START(trampoline_32bit_src)
 	pushl	%eax
 
 	/* Enable paging again */
-	movl	$(X86_CR0_PG | X86_CR0_PE), %eax
+	movl	$(X86_CR0_PG | X86_CR0_NE | X86_CR0_PE), %eax
 	movl	%eax, %cr0
 
 	lret
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index 6ff7e81b5628..cc9b2529a086 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -6,7 +6,7 @@
 #define TRAMPOLINE_32BIT_PGTABLE_OFFSET	0
 
 #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
-#define TRAMPOLINE_32BIT_CODE_SIZE	0x70
+#define TRAMPOLINE_32BIT_CODE_SIZE	0x80
 
 #define TRAMPOLINE_32BIT_STACK_END	TRAMPOLINE_32BIT_SIZE
 
-- 
2.25.1

