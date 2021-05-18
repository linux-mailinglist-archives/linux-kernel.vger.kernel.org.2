Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4FD386EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 03:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242118AbhERBBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:01:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:52803 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239539AbhERBBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:01:19 -0400
IronPort-SDR: NFMScb0ALJQXV+8jZiUjrE54Uw5xmEZiZoxvHSY1jpeMHM8gXAyPnnN/6rsvd3GXSfAxaWdz30
 pWgrt56RXqaw==
Subject: [WARNING: UNSCANNABLE EXTRACTION FAILED][WARNING: UNSCANNABLE EXTRACTION FAILED][RFC v2-fix 1/1] x86/boot: Avoid #VE during boot for TDX platforms
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="188002988"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="188002988"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 18:00:01 -0700
IronPort-SDR: wuepASz99PonOrmiU+HoI0FxDUgYZf51wMR5FxgaqTZ/TFXvIHiJBrZL4gx3Ly0PBFl17u0aa/
 E5AOc5nJa3zQ==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="541531992"
Received: from sdayal-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.213.167.196])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 17:59:59 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Mon, 17 May 2021 17:59:51 -0700
Message-Id: <20210518005951.258819-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAPcyv4jqr8vyh7BwYxW3QJ_ui_yH+iGniJYuUMEnTLWjiYsvPQ@mail.gmail.com>
References: <CAPcyv4jqr8vyh7BwYxW3QJ_ui_yH+iGniJYuUMEnTLWjiYsvPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Avoid operations which will inject #VE during boot process,
which is obviously fatal for TDX platforms.

Details are,

1. TDX module injects #VE if a TDX guest attempts to write
   EFER.
   
   Boot code updates EFER in following cases:
   
   * When enabling Long Mode configuration, EFER.LME bit will
     be set. Since TDX forces EFER.LME=1, we can skip updating
     it again. Check for EFER.LME before updating it and skip
     it if it is already set.

   * EFER is also updated to enable support for features like
     System call and No Execute page setting. In TDX, these
     features are set up by the TDX module. So check whether
     it is already enabled, and skip enabling it again.
   
2. TDX module also injects a #VE if the guest attempts to clear
   CR0.NE. Ensure CR0.NE is set when loading CR0 during compressed
   boot. The Setting CR0.NE should be a nop on all CPUs that
   support 64-bit mode.
   
3. The TDX-Module (effectively part of the hypervisor) requires
   CR4.MCE to be set at all times and injects a #VE if the guest
   attempts to clear CR4.MCE. So, preserve CR4.MCE instead of
   clearing it during boot to avoid #VE.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since RFC v2:
 * Merged Avoid #VE related changes together.
   * [RFC v2 22/32] x86/boot: Avoid #VE during compressed boot
     for TDX platforms
   * [RFC v2 23/32] x86/boot: Avoid unnecessary #VE during boot process.
 * Fixed commit log as per review comments.

 arch/x86/boot/compressed/head_64.S   | 10 +++++++---
 arch/x86/kernel/head_64.S            | 13 +++++++++++--
 arch/x86/realmode/rm/trampoline_64.S | 11 +++++++++--
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index e94874f4bbc1..2d79e5f97360 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -616,12 +616,16 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	$MSR_EFER, %ecx
 	rdmsr
 	btsl	$_EFER_LME, %eax
+	jc	1f
 	wrmsr
-	popl	%edx
+1:	popl	%edx
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
@@ -636,7 +640,7 @@ SYM_CODE_START(trampoline_32bit_src)
 	pushl	%eax
 
 	/* Enable paging again */
-	movl	$(X86_CR0_PG | X86_CR0_PE), %eax
+	movl	$(X86_CR0_PG | X86_CR0_NE | X86_CR0_PE), %eax
 	movl	%eax, %cr0
 
 	lret
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
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index 754f8d2ac9e8..12b734b1da8b 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -143,13 +143,20 @@ SYM_CODE_START(startup_32)
 	movl	%eax, %cr3
 
 	# Set up EFER
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	cmp	pa_tr_efer, %eax
+	jne	.Lwrite_efer
+	cmp	pa_tr_efer + 4, %edx
+	je	.Ldone_efer
+.Lwrite_efer:
 	movl	pa_tr_efer, %eax
 	movl	pa_tr_efer + 4, %edx
-	movl	$MSR_EFER, %ecx
 	wrmsr
 
+.Ldone_efer:
 	# Enable paging and in turn activate Long Mode
-	movl	$(X86_CR0_PG | X86_CR0_WP | X86_CR0_PE), %eax
+	movl	$(X86_CR0_PG | X86_CR0_WP | X86_CR0_NE | X86_CR0_PE), %eax
 	movl	%eax, %cr0
 
 	/*
-- 
2.25.1

