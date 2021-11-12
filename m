Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CF344E2CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 09:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhKLIIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 03:08:38 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:46920 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbhKLIIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 03:08:34 -0500
Received: by mail-ua1-f51.google.com with SMTP id az37so17145471uab.13;
        Fri, 12 Nov 2021 00:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKrL2aGswaQqu3Y4OscoOg26JEi6rIvHQtas6Avt604=;
        b=8Jkv3c5CKUjbv+BKir4RPG5+y1iUoDcgiXCc6NvCW8XYLwA5uc0E3dobUOxvyS7h7M
         0PynA2srSeZ65nDXmI7qp2DqRra86ezb7L1CxeEp1rax0nbrJxfkzoZNitTmJhmMc3ZF
         2T8CG5/307r8vxfcXAzWqjtAkOmFQmsX6mCNn7Tzekr0Q3JFPwOLFrmp46eXbp8My7W1
         TYeiHlBrYLKz/Yo4igcRS/rc9WbFbFBF6cdfLDTAbjhAIvgbG/Mx+FDTWBUM5l6uESO3
         Nv6ksECnUBDe575W7lDjiQvAlZb6afsvmKPUDs/Xqb+2xcBQ1gwCA+FtPMTSebL17qHc
         s3CA==
X-Gm-Message-State: AOAM530ROnvAOSg6losf489dCsYpY0meCUKcn5IkuIpwy2lPJwAzybd2
        5OzD0f3cReTmC0fgaCYnZH9CMy88tj+35Q==
X-Google-Smtp-Source: ABdhPJworejQznrel2T+PwgwV9MCGsQKrJ1lDLAgZV5EqRTbpkzsDAc3xryCCI9yEJiuahKRIMJuFQ==
X-Received: by 2002:a67:f754:: with SMTP id w20mr7360740vso.3.1636704343491;
        Fri, 12 Nov 2021 00:05:43 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id f7sm3569417vkm.31.2021.11.12.00.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 00:05:42 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id o26so17249673uab.5;
        Fri, 12 Nov 2021 00:05:42 -0800 (PST)
X-Received: by 2002:a05:6102:e82:: with SMTP id l2mr7254340vst.37.1636704342222;
 Fri, 12 Nov 2021 00:05:42 -0800 (PST)
MIME-Version: 1.0
References: <1a89fd7d58f22e4817cf5bb406cc191dc0bc9325.1636677401.git.fthain@linux-m68k.org>
In-Reply-To: <1a89fd7d58f22e4817cf5bb406cc191dc0bc9325.1636677401.git.fthain@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Nov 2021 09:05:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXsVvXCbmrdukLCd-AXrqT-LmCz427BdNNCbDUw9vmL1A@mail.gmail.com>
Message-ID: <CAMuHMdXsVvXCbmrdukLCd-AXrqT-LmCz427BdNNCbDUw9vmL1A@mail.gmail.com>
Subject: Re: [PATCH] m68k: Enable memtest functionality
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Sam Creasey <sammy@sammy.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Fri, Nov 12, 2021 at 1:37 AM Finn Thain <fthain@linux-m68k.org> wrote:
> Enable the memtest functionality and rearrange some code to prevent it
> from clobbering the initrd.
>
> The CONFIG_BLK_DEV_INITRD symbol was conditional on !defined(CONFIG_SUN3).
> For simplicity, remove that test on the basis that m68k_ramdisk.size == 0
> on Sun 3.
>
> The SLIME source code at
> http://sammy.net/sun3/ftp/pub/m68k/sun3/slime/slime-2.0.tar.gz
> indicates that no BI_RAMDISK entry is ever passed to the kernel due
> to #ifdef 0 around the relevant code.
>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Sam Creasey <sammy@sammy.net>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Thanks for your patch!

> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -9,6 +9,7 @@ config M68K
>         select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
>         select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
>         select ARCH_NO_PREEMPT if !COLDFIRE
> +       select ARCH_USE_MEMTEST

if MMU_MOTOROLA?

>         select ARCH_WANT_IPC_PARSE_VERSION
>         select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
>         select DMA_DIRECT_REMAP if HAS_DMA && MMU && !COLDFIRE
> diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
> index 4b51bfd38e5f..49e573b94326 100644
> --- a/arch/m68k/kernel/setup_mm.c
> +++ b/arch/m68k/kernel/setup_mm.c
> @@ -338,13 +338,6 @@ void __init setup_arch(char **cmdline_p)
>                 panic("No configuration setup");
>         }
>
> -       paging_init();
> -
> -#ifdef CONFIG_NATFEAT
> -       nf_init();
> -#endif
> -
> -#ifndef CONFIG_SUN3
>  #ifdef CONFIG_BLK_DEV_INITRD
>         if (m68k_ramdisk.size) {
>                 memblock_reserve(m68k_ramdisk.addr, m68k_ramdisk.size);

Does this still work, given the initrd is part of memory that used
to be added before (in paging_init(), but now is added later?
(I'm no memblock expert, so that might be a silly question ;-)

> @@ -354,6 +347,12 @@ void __init setup_arch(char **cmdline_p)
>         }
>  #endif
>
> +       paging_init();
> +
> +#ifdef CONFIG_NATFEAT
> +       nf_init();
> +#endif
> +
>  #ifdef CONFIG_ATARI
>         if (MACH_IS_ATARI)
>                 atari_stram_reserve_pages((void *)availmem);
> @@ -364,8 +363,6 @@ void __init setup_arch(char **cmdline_p)
>         }
>  #endif
>
> -#endif /* !CONFIG_SUN3 */
> -
>  /* set ISA defs early as possible */
>  #if defined(CONFIG_ISA) && defined(MULTI_ISA)
>         if (MACH_IS_Q40) {
> diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
> index 9f3f77785aa7..5b6575eb6d02 100644
> --- a/arch/m68k/mm/motorola.c
> +++ b/arch/m68k/mm/motorola.c
> @@ -455,6 +455,8 @@ void __init paging_init(void)
>
>         flush_tlb_all();
>
> +       early_memtest(min_addr, max_addr);

So this is available only if MMU_MOTOROLA, not for Sun-3, Coldfire,
or nommu.

> +
>         /*
>          * initialize the bad page table and bad page to point
>          * to a couple of allocated pages

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
