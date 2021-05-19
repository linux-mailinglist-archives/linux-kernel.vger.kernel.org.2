Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4E9389426
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355438AbhESQye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:54:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:61433 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355419AbhESQyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:54:33 -0400
IronPort-SDR: /G4g7zEiHJ9k8TxTrm3dQWZSOazvKLH2ZZ0Uqsm26ImS1xRjPqMNpvkEhcBNUwpSeWKlXXhXPI
 SLWvfDyX38wg==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="199070392"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="199070392"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 09:53:13 -0700
IronPort-SDR: wue0aEVMPyr2QRX7kZxWjybeA7tSz4/7zhqc+1YRzymL04IPB8HqOgCESUJmRsvOiEF8TqZTes
 F1RLTz65cUvA==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="474705805"
Received: from mconrado-mobl1.amr.corp.intel.com (HELO [10.209.83.57]) ([10.209.83.57])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 09:53:12 -0700
Subject: Re: [RFC v2-fix 1/1] x86/boot: Avoid #VE during boot for TDX
 platforms
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <CAPcyv4jqr8vyh7BwYxW3QJ_ui_yH+iGniJYuUMEnTLWjiYsvPQ@mail.gmail.com>
 <20210518005951.258819-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <b1aafcbb-c5db-efa5-0343-014585e73191@intel.com>
Date:   Wed, 19 May 2021 09:53:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210518005951.258819-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/21 5:59 PM, Kuppuswamy Sathyanarayanan wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Avoid operations which will inject #VE during boot process,
> which is obviously fatal for TDX platforms.

It's not "obviously fatal".  We actually have early exception handlers.
 Please give an actual reason.  "They're easy to avoid, and that sure
beats handling the exceptions" is a perfectly fine reason.

> Details are,
> 
> 1. TDX module injects #VE if a TDX guest attempts to write
>    EFER.
>    
>    Boot code updates EFER in following cases:
>    
>    * When enabling Long Mode configuration, EFER.LME bit will
>      be set. Since TDX forces EFER.LME=1, we can skip updating
>      it again. Check for EFER.LME before updating it and skip
>      it if it is already set.
> 
>    * EFER is also updated to enable support for features like
>      System call and No Execute page setting. In TDX, these
>      features are set up by the TDX module. So check whether
>      it is already enabled, and skip enabling it again.
>    
> 2. TDX module also injects a #VE if the guest attempts to clear
>    CR0.NE. Ensure CR0.NE is set when loading CR0 during compressed
>    boot. The Setting CR0.NE should be a nop on all CPUs that
>    support 64-bit mode.
>    
> 3. The TDX-Module (effectively part of the hypervisor) requires

So, after we've mentioned the TDX module a few times, *NOW* we feel the
need to explain what it is?  I'm also baffled by this little aside.
Literally the WHOLE POINT FOR SEAM TO EXIST is that it is NOT PART OF
THE HYPERVISOR.  The whole point.  Literally.

>    CR4.MCE to be set at all times and injects a #VE if the guest
>    attempts to clear CR4.MCE. So, preserve CR4.MCE instead of
>    clearing it during boot to avoid #VE.

This is a good example of a changelog run amok.  It doesn't need to be
an English language reproduction of the code.  This is getting close.

This can all be replaced and improved with a high-level discussion of
what is going on:

	There are a few MSRs and control register bits which the kernel
	normally needs to modify during boot.  But, TDX disallows
	modification of these registers to help provide consistent
	security guarantees.  Fortunately, TDX ensures that these are
	all in the correct state before the kernel loads, which means
	the kernel has no need to modify them.

	The conditions we need to avoid are:
	1. Any writes to the EFER MSR
	2. Clearing CR0.NE
	3. Clearing CR3.MCE

> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index e94874f4bbc1..2d79e5f97360 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -616,12 +616,16 @@ SYM_CODE_START(trampoline_32bit_src)
>  	movl	$MSR_EFER, %ecx
>  	rdmsr
>  	btsl	$_EFER_LME, %eax
> +	jc	1f
>  	wrmsr
> -	popl	%edx
> +1:	popl	%edx

A comment would be nice:

	/* Avoid writing EFER if no change was made (for TDX guest) */

>  	popl	%ecx
>  
>  	/* Enable PAE and LA57 (if required) paging modes */
> -	movl	$X86_CR4_PAE, %eax
> +	movl	%cr4, %eax
> +	/* Clearing CR4.MCE will #VE on TDX guests.  Leave it alone. */
> +	andl	$X86_CR4_MCE, %eax

Maybe I'm just dense today, but I was boggling about what this 'andl' is
actually doing.  This would help:

	/*
	 * Clear all bits except CR4.MCE, which is preserved.
	 * Clearing CR4.MCE will #VE in TDX guests.
	 */

> +	orl	$X86_CR4_PAE, %eax
>  	testl	%edx, %edx
>  	jz	1f
>  	orl	$X86_CR4_LA57, %eax
> @@ -636,7 +640,7 @@ SYM_CODE_START(trampoline_32bit_src)
>  	pushl	%eax
>  
>  	/* Enable paging again */
> -	movl	$(X86_CR0_PG | X86_CR0_PE), %eax
> +	movl	$(X86_CR0_PG | X86_CR0_NE | X86_CR0_PE), %eax
>  	movl	%eax, %cr0

Shouldn't we also comment the X86_CR0_NE?

	/* Enable paging again.  Avoid clearing X86_CR0_NE for TDX. */

>  	lret
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 04bddaaba8e2..92c77cf75542 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -141,7 +141,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  1:
>  
>  	/* Enable PAE mode, PGE and LA57 */
> -	movl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
> +	movq	%cr4, %rcx
> +	/* Clearing CR4.MCE will #VE on TDX guests.  Leave it alone. */
> +	andl	$X86_CR4_MCE, %ecx
> +	orl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx

Ditto on the comment from above about clearing/preserving bits.

>  #ifdef CONFIG_X86_5LEVEL
>  	testl	$1, __pgtable_l5_enabled(%rip)
>  	jz	1f
> @@ -229,13 +232,19 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  	/* Setup EFER (Extended Feature Enable Register) */
>  	movl	$MSR_EFER, %ecx
>  	rdmsr
> +	movl    %eax, %edx

Comment, please.

>  	btsl	$_EFER_SCE, %eax	/* Enable System Call */
>  	btl	$20,%edi		/* No Execute supported? */
>  	jnc     1f
>  	btsl	$_EFER_NX, %eax
>  	btsq	$_PAGE_BIT_NX,early_pmd_flags(%rip)
> -1:	wrmsr				/* Make changes effective */
>  
> +	/* Skip the WRMSR if the current value matches the desired value. */

If I read this comment in 5 years, I'm going to ask "Why bother?".
Please mention TDX.

> +1:	cmpl	%edx, %eax
> +	je	1f
> +	xor	%edx, %edx
> +	wrmsr				/* Make changes effective */
> +1:
>  	/* Setup cr0 */
>  	movl	$CR0_STATE, %eax
>  	/* Make changes effective */
> diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
> index 754f8d2ac9e8..12b734b1da8b 100644
> --- a/arch/x86/realmode/rm/trampoline_64.S
> +++ b/arch/x86/realmode/rm/trampoline_64.S
> @@ -143,13 +143,20 @@ SYM_CODE_START(startup_32)
>  	movl	%eax, %cr3
>  
>  	# Set up EFER
> +	movl	$MSR_EFER, %ecx
> +	rdmsr
> +	cmp	pa_tr_efer, %eax
> +	jne	.Lwrite_efer
> +	cmp	pa_tr_efer + 4, %edx

Comment, please:

	# Skip EFER writes to avoid faults in TDX guests

> +	je	.Ldone_efer
> +.Lwrite_efer:
>  	movl	pa_tr_efer, %eax
>  	movl	pa_tr_efer + 4, %edx
> -	movl	$MSR_EFER, %ecx
>  	wrmsr
>  
> +.Ldone_efer:
>  	# Enable paging and in turn activate Long Mode
> -	movl	$(X86_CR0_PG | X86_CR0_WP | X86_CR0_PE), %eax
> +	movl	$(X86_CR0_PG | X86_CR0_WP | X86_CR0_NE | X86_CR0_PE), %eax
>  	movl	%eax, %cr0
>  
>  	/*
> 

