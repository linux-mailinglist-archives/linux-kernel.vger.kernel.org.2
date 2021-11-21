Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3628445825B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 07:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhKUGcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 01:32:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhKUGc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 01:32:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A73C260C4A;
        Sun, 21 Nov 2021 06:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637476160;
        bh=A2FbeRl3V1l2ksZ9wM0BVAX4t2bfqwjgHNSx9b4lWHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RfJOlGe5boVfDciCEArB8lCo8yXqEnrsL/Qm0w1v0DAU2i00vL+jpIP+vvS5mJpOe
         u01HUX1DEIbOZdZ8qG8PpGWdGANLMn0T05KPV2ot1Lsn3dS1B+eZCSpbAeqhRFQPHz
         foYhfYvz/JTpBEuyc1x209Cwl2SgYmx3GSlWQotfg8GSySTnClhO42XP+F0uq97kFN
         4jCFh2Qox/3dkoBEnxuVjSOCIkgn57zzwa81eytCWm6b45niDJNvN7F8qivxuTJRXB
         BN0qtql4TBx8dokwWV4wUtZSBli55Fga+fQCjAtgRvDbQYcUB8JOo/0+3XQfSBaF7f
         F6+h0TOTuDZMg==
Date:   Sun, 21 Nov 2021 08:29:12 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH v3] m68k: Enable memtest functionality
Message-ID: <YZnnOAoEIS1wmOyr@kernel.org>
References: <8170fe1d1c62426d82275d36ba409ecc18754292.1637274578.git.fthain@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8170fe1d1c62426d82275d36ba409ecc18754292.1637274578.git.fthain@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 09:29:38AM +1100, Finn Thain wrote:
> Enable the memtest functionality and rearrange some code to prevent it
> from clobbering the initrd.
> 
> The code to implement CONFIG_BLK_DEV_INITRD was conditional on
> !defined(CONFIG_SUN3). For simplicity, remove that test on the basis
> that m68k_ramdisk.size == 0 on Sun 3. The SLIME source code at
> http://sammy.net/sun3/ftp/pub/m68k/sun3/slime/slime-2.0.tar.gz
> indicates that no BI_RAMDISK entry is ever passed to the kernel due
> to #ifdef 0 around the relevant code.
> 
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Sam Creasey <sammy@sammy.net>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> Is SLIME the only Linux bootloader on Sun 3?
> ---
> Changed since v2:
>  - Made conditional on MMU_MOTOROLA.
> 
> Changed since v1:
>  - Updated documentation.
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  2 +-
>  arch/m68k/Kconfig                               |  1 +
>  arch/m68k/kernel/setup_mm.c                     | 15 ++++++---------
>  arch/m68k/mm/motorola.c                         |  2 ++
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 43dc35fe5bc0..ac42b421a95c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2924,7 +2924,7 @@
>  			both parameters are enabled, hugetlb_free_vmemmap takes
>  			precedence over memory_hotplug.memmap_on_memory.
>  
> -	memtest=	[KNL,X86,ARM,PPC,RISCV] Enable memtest
> +	memtest=	[KNL,X86,ARM,M68K,PPC,RISCV] Enable memtest
>  			Format: <integer>
>  			default : 0 <disable>
>  			Specifies the number of memtest passes to be
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index 0b50da08a9c5..4cae3fbe7f97 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -9,6 +9,7 @@ config M68K
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
>  	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
>  	select ARCH_NO_PREEMPT if !COLDFIRE
> +	select ARCH_USE_MEMTEST if MMU_MOTOROLA
>  	select ARCH_WANT_IPC_PARSE_VERSION
>  	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
>  	select DMA_DIRECT_REMAP if HAS_DMA && MMU && !COLDFIRE
> diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
> index 4b51bfd38e5f..49e573b94326 100644
> --- a/arch/m68k/kernel/setup_mm.c
> +++ b/arch/m68k/kernel/setup_mm.c
> @@ -338,13 +338,6 @@ void __init setup_arch(char **cmdline_p)
>  		panic("No configuration setup");
>  	}
>  
> -	paging_init();
> -
> -#ifdef CONFIG_NATFEAT
> -	nf_init();
> -#endif
> -
> -#ifndef CONFIG_SUN3
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	if (m68k_ramdisk.size) {
>  		memblock_reserve(m68k_ramdisk.addr, m68k_ramdisk.size);
> @@ -354,6 +347,12 @@ void __init setup_arch(char **cmdline_p)
>  	}
>  #endif
>  
> +	paging_init();
> +
> +#ifdef CONFIG_NATFEAT
> +	nf_init();
> +#endif
> +
>  #ifdef CONFIG_ATARI
>  	if (MACH_IS_ATARI)
>  		atari_stram_reserve_pages((void *)availmem);
> @@ -364,8 +363,6 @@ void __init setup_arch(char **cmdline_p)
>  	}
>  #endif
>  
> -#endif /* !CONFIG_SUN3 */
> -
>  /* set ISA defs early as possible */
>  #if defined(CONFIG_ISA) && defined(MULTI_ISA)
>  	if (MACH_IS_Q40) {
> diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
> index 9f3f77785aa7..5b6575eb6d02 100644
> --- a/arch/m68k/mm/motorola.c
> +++ b/arch/m68k/mm/motorola.c
> @@ -455,6 +455,8 @@ void __init paging_init(void)
>  
>  	flush_tlb_all();
>  
> +	early_memtest(min_addr, max_addr);
> +
>  	/*
>  	 * initialize the bad page table and bad page to point
>  	 * to a couple of allocated pages
> -- 
> 2.26.3
> 

-- 
Sincerely yours,
Mike.
