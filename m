Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC39844F5E0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 02:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhKNBV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 20:21:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhKNBV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 20:21:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE12E6054E;
        Sun, 14 Nov 2021 01:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636852715;
        bh=Ime68l8ko2O//HqZPOmtfYs0qtM5PGclDvyi74D2cpM=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=ujr2qUnZk1GfxzWIkzGPPFq8RFjW3ypkr8Gce2w6gA7dobgp06s5jjgDxDXkhj3ZL
         Xgg0KJttrp4Zed38+ZVcK3jKwTww69xFW0O4WjqDoazxBYpvD/V6+lj3tGJ7y3r8SZ
         hgl1KqIgkXmVL+b44gvmFby9i1hDgS8Mle1dXzudjUa0apkWK+t9ec9VqghCUb1mmx
         3XX61OI8mIB5Zl2hrVt0V4eEV/SSf/A+xvUt7OHlgbWjJNM1qcXLPSVv0Q/VI4nn9g
         Wb0UkfHhslwqV1e2HifOC4RB4t9/qpiltWf300B4s084hioZzv0VrD1bcUkiKS0U/u
         a3ALX1QvJBU9w==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9287827C0054;
        Sat, 13 Nov 2021 20:18:33 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Sat, 13 Nov 2021 20:18:33 -0500
X-ME-Sender: <xms:6WOQYcf5XM8TO8kA2nRHX1VjbcIZTOnQZJtGEXADtoAMtce4-vPdrA>
    <xme:6WOQYeM_afDzExxewIDiJxOSNO8DlrkbDndsHbUnecwdBtVpFL3aI5Ac7xA2DX7Zq
    bc7vcI5vA_2DDNNLzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvdeigdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnugih
    ucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhephedtkefguddvvedtgfektdeuiefhueffgeejudeghffhffelgfffgfeh
    jeegfeffnecuffhomhgrihhnpeeigedrshgspdhlughsrdhssgenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluh
    htoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:6WOQYdh92qJzgJYWstNWPB6tcEO7xz51L9T18PMPfs-DpTy60Fm8nQ>
    <xmx:6WOQYR8RGzz6x0jmaDOgSPrSqBxk2_Lf4iPCS7POm3u8eIlhUUdj0w>
    <xmx:6WOQYYvov88wWzqP7jGRZw4LEp8DZNXaMuzTLAqwhfW2lHKDTF7mxw>
    <xmx:6WOQYaIFVFG_dMODYNpGvx7fS5PWy6-Y_o_Y6Yj1lphajrlSsKxXlw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1CB8321E006E; Sat, 13 Nov 2021 20:18:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <719e0170-7645-4787-8c3a-676f34068c27@www.fastmail.com>
In-Reply-To: <20211113124035.9180-4-brgerst@gmail.com>
References: <20211113124035.9180-1-brgerst@gmail.com>
 <20211113124035.9180-4-brgerst@gmail.com>
Date:   Sat, 13 Nov 2021 17:18:11 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Brian Gerst" <brgerst@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Cc:     "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@kernel.org>
Subject: Re: [PATCH 3/3] x86_64: Use relative per-cpu offsets
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, Nov 13, 2021, at 4:40 AM, Brian Gerst wrote:
> The per-cpu section is currently linked at virtual address 0, because
> older compilers hardcoded the stack protector canary value at a fixed
> offset from the start of the GS segment.  Use a standard relative offset
> as the GS base when the stack protector is disabled, or a newer compiler
> is used that supports a configurable location for the stack canary.

Can you explain the benefit?  Also, I think we should consider dropping support for the fixed model like we did on x86_32.

>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  arch/x86/Kconfig               |  2 +-
>  arch/x86/include/asm/percpu.h  |  4 ++--
>  arch/x86/kernel/head_64.S      |  4 ----
>  arch/x86/kernel/setup_percpu.c |  2 +-
>  arch/x86/kernel/vmlinux.lds.S  | 14 ++++++--------
>  5 files changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 832a6626df72..fae7724505bd 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -403,7 +403,7 @@ config STACKPROTECTOR_FIXED
>  	default y if !$(cc-option,-mstack-protector-guard-reg=gs)
> 
>  config X86_ABSOLUTE_PERCPU
> -	def_bool X86_64 && SMP
> +	def_bool STACKPROTECTOR_FIXED && SMP
>  	select KALLSYMS_ABSOLUTE_PERCPU
> 
>  menu "Processor type and features"
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index a3c33b79fb86..8294781bb483 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -16,7 +16,7 @@
>  #define PER_CPU_VAR(var)	var
>  #endif	/* SMP */
> 
> -#ifdef CONFIG_X86_64_SMP
> +#ifdef CONFIG_X86_ABSOLUTE_PERCPU
>  #define INIT_PER_CPU_VAR(var)  init_per_cpu__##var
>  #else
>  #define INIT_PER_CPU_VAR(var)  var
> @@ -59,7 +59,7 @@
>  #define DECLARE_INIT_PER_CPU(var) \
>         extern typeof(var) init_per_cpu_var(var)
> 
> -#ifdef CONFIG_X86_64_SMP
> +#ifdef CONFIG_X86_ABSOLUTE_PERCPU
>  #define init_per_cpu_var(var)  init_per_cpu__##var
>  #else
>  #define init_per_cpu_var(var)  var
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 6e396ffb1610..c1b6209a01ca 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -339,12 +339,8 @@ SYM_DATA(initial_code,	.quad x86_64_start_kernel)
>  #ifdef CONFIG_STACKPROTECTOR_FIXED
>  SYM_DATA(initial_gs,	.quad INIT_PER_CPU_VAR(fixed_percpu_data))
>  #else
> -#ifdef CONFIG_SMP
> -SYM_DATA(initial_gs,	.quad __per_cpu_load)
> -#else
>  SYM_DATA(initial_gs,	.quad 0)
>  #endif
> -#endif
> 
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
> diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
> index 5afd98559193..4c0020a6ced9 100644
> --- a/arch/x86/kernel/setup_percpu.c
> +++ b/arch/x86/kernel/setup_percpu.c
> @@ -26,7 +26,7 @@
>  DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
>  EXPORT_PER_CPU_SYMBOL(cpu_number);
> 
> -#ifdef CONFIG_X86_64
> +#ifdef CONFIG_X86_ABSOLUTE_PERCPU
>  #define BOOT_PERCPU_OFFSET ((unsigned long)__per_cpu_load)
>  #else
>  #define BOOT_PERCPU_OFFSET 0
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index c475d21d2126..18e1deb9fa52 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -102,10 +102,10 @@ jiffies = jiffies_64;
>  PHDRS {
>  	text PT_LOAD FLAGS(5);          /* R_E */
>  	data PT_LOAD FLAGS(6);          /* RW_ */
> -#ifdef CONFIG_X86_64
> -#ifdef CONFIG_SMP
> +#ifdef CONFIG_X86_ABSOLUTE_PERCPU
>  	percpu PT_LOAD FLAGS(6);        /* RW_ */
>  #endif
> +#ifdef CONFIG_X86_64
>  	init PT_LOAD FLAGS(7);          /* RWE */
>  #endif
>  	note PT_NOTE FLAGS(0);          /* ___ */
> @@ -215,7 +215,7 @@ SECTIONS
>  		__init_begin = .; /* paired with __init_end */
>  	}
> 
> -#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
> +#ifdef CONFIG_X86_ABSOLUTE_PERCPU
>  	/*
>  	 * percpu offsets are zero-based on SMP.  PERCPU_VADDR() changes the
>  	 * output PHDR, so the next output section - .init.text - should
> @@ -339,7 +339,7 @@ SECTIONS
>  		EXIT_DATA
>  	}
> 
> -#if !defined(CONFIG_X86_64) || !defined(CONFIG_SMP)
> +#ifndef CONFIG_X86_ABSOLUTE_PERCPU
>  	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
>  #endif
> 
> @@ -474,7 +474,7 @@ SECTIONS
>  . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
>  	   "kernel image bigger than KERNEL_IMAGE_SIZE");
> 
> -#ifdef CONFIG_X86_64
> +#ifdef CONFIG_X86_ABSOLUTE_PERCPU
>  /*
>   * Per-cpu symbols which need to be offset from __per_cpu_load
>   * for the boot processor.
> @@ -483,13 +483,11 @@ SECTIONS
>  INIT_PER_CPU(gdt_page);
>  INIT_PER_CPU(irq_stack_backing_store);
> 
> -#ifdef CONFIG_STACKPROTECTOR_FIXED
>  INIT_PER_CPU(fixed_percpu_data);
>  . = ASSERT((fixed_percpu_data == 0),
>             "fixed_percpu_data is not at start of per-cpu area");
> -#endif
> 
> -#endif /* CONFIG_X86_64 */
> +#endif /* CONFIG_X86_ABSOLUTE_PERCPU */
> 
>  #ifdef CONFIG_KEXEC_CORE
>  #include <asm/kexec.h>
> -- 
> 2.31.1
