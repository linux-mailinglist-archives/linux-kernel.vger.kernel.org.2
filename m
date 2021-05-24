Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F07338F63D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhEXX3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:29:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:20410 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhEXX3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:29:40 -0400
IronPort-SDR: 2O6yvtNwJ1dXdmdEnpad85yRlVc1xb87mx6M0QuV7VRl9yl3ZmfbIqRxyCxtm1hkY4P508A0H0
 URaJLNgMtPWA==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="182378901"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="182378901"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 16:28:03 -0700
IronPort-SDR: FdxHIKhN0Byh76JtaTvmtlQIR0LNRdBo3t86k+nwf5ZAmSwUqC903YoSsEYrpftyrQ19e9j8Kz
 WmIXJLVYVPAA==
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="442267330"
Received: from eyoukerh-mobl.ger.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.2.69])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 16:28:01 -0700
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
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2-fix-v3 1/1] x86/boot: Avoid #VE during boot for TDX platforms
Date:   Mon, 24 May 2021 16:27:35 -0700
Message-Id: <20210524232735.801740-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d90b689d-4716-1a3b-1e6d-f32a9a25894a@linux.intel.com>
References: <d90b689d-4716-1a3b-1e6d-f32a9a25894a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

In TDX guests, Virtualization Exceptions (#VE) are delivered
to TDX guests due to specific guest actions like MSR writes,
CPUID leaf accesses or I/O access. But in early boot code, #VE
cannot be allowed because the required exception handler setup
support code is missing. If #VE is triggered without proper
handler support, it would lead to triple fault or kernel hang.
So, avoid operations which will inject #VE during boot process.
They're easy to avoid and it is less complex than handling the
exceptions.

There are a few MSRs and control register bits which the kernel
normally needs to modify during boot. But, TDX disallows
modification of these registers to help provide consistent
security guarantees. Fortunately, TDX ensures that these are all
in the correct state before the kernel loads, which means the
kernel has no need to modify them.

The conditions to avoid are:

  * Any writes to the EFER MSR
  * Clearing CR0.NE
  * Clearing CR3.MCE

This theoretically makes guest boot more fragile. If, for
instance, EFER was set up incorrectly and a WRMSR was performed,
the resulting (unhandled) #VE would triple fault. However, this
is likely to trip up the guest BIOS long before control reaches
the kernel. In any case, these kinds of problems are unlikely to
occur in production environments, and developers have good debug
tools to fix them quickly. 

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
Changes since RFC v2-fix-v2:
 * Fixed commit log as per review comments.

Changes since RFC v2-fix:
 * Fixed commit and comments as per Dave and Dan's suggestions.
 * Merged CR0.NE related change in pa_trampoline_compat() from patch
   titled "x86/boot: Add a trampoline for APs booting in 64-bit mode"
   to this patch. It belongs in this patch.
 * Merged TRAMPOLINE_32BIT_CODE_SIZE related change from patch titled
   "x86/boot: Add a trampoline for APs booting in 64-bit mode" to this
   patch (since it was wrongly merged to that patch during patch split).

 arch/x86/boot/compressed/head_64.S   | 16 ++++++++++++----
 arch/x86/boot/compressed/pgtable.h   |  2 +-
 arch/x86/kernel/head_64.S            | 20 ++++++++++++++++++--
 arch/x86/realmode/rm/trampoline_64.S | 23 +++++++++++++++++++----
 4 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index e94874f4bbc1..f848569e3fb0 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -616,12 +616,20 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	$MSR_EFER, %ecx
 	rdmsr
 	btsl	$_EFER_LME, %eax
+	/* Avoid writing EFER if no change was made (for TDX guest) */
+	jc	1f
 	wrmsr
-	popl	%edx
+1:	popl	%edx
 	popl	%ecx
 
 	/* Enable PAE and LA57 (if required) paging modes */
-	movl	$X86_CR4_PAE, %eax
+	movl	%cr4, %eax
+	/*
+	 * Clear all bits except CR4.MCE, which is preserved.
+	 * Clearing CR4.MCE will #VE in TDX guests.
+	 */
+	andl	$X86_CR4_MCE, %eax
+	orl	$X86_CR4_PAE, %eax
 	testl	%edx, %edx
 	jz	1f
 	orl	$X86_CR4_LA57, %eax
@@ -635,8 +643,8 @@ SYM_CODE_START(trampoline_32bit_src)
 	pushl	$__KERNEL_CS
 	pushl	%eax
 
-	/* Enable paging again */
-	movl	$(X86_CR0_PG | X86_CR0_PE), %eax
+	/* Enable paging again. Avoid clearing X86_CR0_NE for TDX */
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
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 04bddaaba8e2..6cf8d126b80a 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -141,7 +141,13 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 1:
 
 	/* Enable PAE mode, PGE and LA57 */
-	movl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
+	movq	%cr4, %rcx
+	/*
+	 * Clear all bits except CR4.MCE, which is preserved.
+	 * Clearing CR4.MCE will #VE in TDX guests.
+	 */
+	andl	$X86_CR4_MCE, %ecx
+	orl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
 #ifdef CONFIG_X86_5LEVEL
 	testl	$1, __pgtable_l5_enabled(%rip)
 	jz	1f
@@ -229,13 +235,23 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	/* Setup EFER (Extended Feature Enable Register) */
 	movl	$MSR_EFER, %ecx
 	rdmsr
+	/*
+	 * Preserve current value of EFER for comparison and to skip
+	 * EFER writes if no change was made (for TDX guest)
+	 */
+	movl    %eax, %edx
 	btsl	$_EFER_SCE, %eax	/* Enable System Call */
 	btl	$20,%edi		/* No Execute supported? */
 	jnc     1f
 	btsl	$_EFER_NX, %eax
 	btsq	$_PAGE_BIT_NX,early_pmd_flags(%rip)
-1:	wrmsr				/* Make changes effective */
 
+	/* Avoid writing EFER if no change was made (for TDX guest) */
+1:	cmpl	%edx, %eax
+	je	1f
+	xor	%edx, %edx
+	wrmsr				/* Make changes effective */
+1:
 	/* Setup cr0 */
 	movl	$CR0_STATE, %eax
 	/* Make changes effective */
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index 957bb21ce105..cf14d0326a48 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -143,13 +143,27 @@ SYM_CODE_START(startup_32)
 	movl	%eax, %cr3
 
 	# Set up EFER
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	/*
+	 * Skip writing to EFER if the register already has desiered
+	 * value (to avoid #VE for TDX guest).
+	 */
+	cmp	pa_tr_efer, %eax
+	jne	.Lwrite_efer
+	cmp	pa_tr_efer + 4, %edx
+	je	.Ldone_efer
+.Lwrite_efer:
 	movl	pa_tr_efer, %eax
 	movl	pa_tr_efer + 4, %edx
-	movl	$MSR_EFER, %ecx
 	wrmsr
 
-	# Enable paging and in turn activate Long Mode
-	movl	$(X86_CR0_PG | X86_CR0_WP | X86_CR0_PE), %eax
+.Ldone_efer:
+	/*
+	 * Enable paging and in turn activate Long Mode. Avoid clearing
+	 * X86_CR0_NE for TDX.
+	 */
+	movl	$(X86_CR0_PG | X86_CR0_WP | X86_CR0_NE | X86_CR0_PE), %eax
 	movl	%eax, %cr0
 
 	/*
@@ -169,7 +183,8 @@ SYM_CODE_START(pa_trampoline_compat)
 	movl	$rm_stack_end, %esp
 	movw	$__KERNEL_DS, %dx
 
-	movl	$X86_CR0_PE, %eax
+	/* Avoid clearing X86_CR0_NE for TDX */
+	movl	$(X86_CR0_NE | X86_CR0_PE), %eax
 	movl	%eax, %cr0
 	ljmpl   $__KERNEL32_CS, $pa_startup_32
 SYM_CODE_END(pa_trampoline_compat)
-- 
2.25.1

