Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8008A36B8A6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbhDZSFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:05:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:22347 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234480AbhDZSDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:45 -0400
IronPort-SDR: Seaw6DDaFcgfIJWbOCBUJNgJXPY+g24ySl16A4aMcJ/NjP3fOVV9h6/tz5zHa7ufz1YHtLYLZ+
 o2/HPVJ9jsRQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="194263271"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="194263271"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:55 -0700
IronPort-SDR: Wp6nERpNgXJ0RPJu0MV38RUKJ03VS1th05mt1yPeJGFCEejXkMuqmzxG5F7YbrKx3GXNsuHJKA
 7GkYUaSUdJiQ==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353428"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:53 -0700
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
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2 23/32] x86/boot: Avoid unnecessary #VE during boot process
Date:   Mon, 26 Apr 2021 11:01:50 -0700
Message-Id: <b6e4ea3dfe6648e111e0d9dfcce4174672f8b823.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Skip writing EFER during secondary_startup_64() if the current value is
also the desired value. This avoids a #VE when running as a TDX guest,
as the TDX-Module does not allow writes to EFER (even when writing the
current, fixed value).

Also, preserve CR4.MCE instead of clearing it during boot to avoid a #VE
when running as a TDX guest. The TDX-Module (effectively part of the
hypervisor) requires CR4.MCE to be set at all times and injects a #VE
if the guest attempts to clear CR4.MCE.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/boot/compressed/head_64.S |  5 ++++-
 arch/x86/kernel/head_64.S          | 13 +++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 37c2f37d4a0d..2d79e5f97360 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -622,7 +622,10 @@ SYM_CODE_START(trampoline_32bit_src)
 	popl	%ecx
 
 	/* Enable PAE and LA57 (if required) paging modes */
-	movl	$X86_CR4_PAE, %eax
+	movl	%cr4, %eax
+	/* Clearing CR4.MCE will #VE on TDX guests.  Leave it alone. */
+	andl	$X86_CR4_MCE, %eax
+	orl	$X86_CR4_PAE, %eax
 	testl	%edx, %edx
 	jz	1f
 	orl	$X86_CR4_LA57, %eax
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 04bddaaba8e2..92c77cf75542 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -141,7 +141,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 1:
 
 	/* Enable PAE mode, PGE and LA57 */
-	movl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
+	movq	%cr4, %rcx
+	/* Clearing CR4.MCE will #VE on TDX guests.  Leave it alone. */
+	andl	$X86_CR4_MCE, %ecx
+	orl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
 #ifdef CONFIG_X86_5LEVEL
 	testl	$1, __pgtable_l5_enabled(%rip)
 	jz	1f
@@ -229,13 +232,19 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	/* Setup EFER (Extended Feature Enable Register) */
 	movl	$MSR_EFER, %ecx
 	rdmsr
+	movl    %eax, %edx
 	btsl	$_EFER_SCE, %eax	/* Enable System Call */
 	btl	$20,%edi		/* No Execute supported? */
 	jnc     1f
 	btsl	$_EFER_NX, %eax
 	btsq	$_PAGE_BIT_NX,early_pmd_flags(%rip)
-1:	wrmsr				/* Make changes effective */
 
+	/* Skip the WRMSR if the current value matches the desired value. */
+1:	cmpl	%edx, %eax
+	je	1f
+	xor	%edx, %edx
+	wrmsr				/* Make changes effective */
+1:
 	/* Setup cr0 */
 	movl	$CR0_STATE, %eax
 	/* Make changes effective */
-- 
2.25.1

