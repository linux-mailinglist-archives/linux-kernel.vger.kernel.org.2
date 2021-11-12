Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A66444E3D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 10:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbhKLJeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 04:34:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhKLJet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 04:34:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6672761002
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636709519;
        bh=WuGdLjk4kZdTXzkz6D9KLeo+9EaMKDbAwn47PiOrUnk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W4wqrQsaqfH+0vaczhu0ptWoF+13a4rfsZs+FDpCjUVqnzrNUtafU2DTdzVVbBCn/
         E/UITkYKxJqLUiHYN37cjXRQG5EJPtt7S0wOtlcz7/Fo/UPr2g0AEI65KVs3ySFPMV
         xLTvzkfydyVQX6w5rAXC0ns0xSOSQxyDulFeDcgQQmZVJSa9sfFJCLaUVJrF6X901q
         wCC3RPkWo8TCi0oJk4gb7E+k6vLUmHSqVVEyo1yedFZ+42/iLO07xIoB8RH+1jTKde
         93WFzCCnO3IbNYfd4JOHOa3KxnzWhd7GVlO24myNNfxc5bJbKS+0JzRVZJoeQk9ZyL
         yeIzkwEmsaE9w==
Received: by mail-ot1-f42.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso12982884otj.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:31:59 -0800 (PST)
X-Gm-Message-State: AOAM531Cho49G/FwHEPrHxowYIxztEwCLoH5koQ0kH9mqTek0oJmfIIq
        W75Kxdxjii05GZ/IhSzFWlCJ51aC8p6h84Lqdro=
X-Google-Smtp-Source: ABdhPJxaUac5pOH2DpLzUy2COU649nLSyREtqg65kDnJfaIV9jNfRqMrJl8103gSHK7SN5j0M8TOpgaH4qUf8Rxs7OM=
X-Received: by 2002:a05:6830:1445:: with SMTP id w5mr11475827otp.112.1636709518685;
 Fri, 12 Nov 2021 01:31:58 -0800 (PST)
MIME-Version: 1.0
References: <1636708842-25787-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1636708842-25787-1-git-send-email-huangzhaoyang@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 12 Nov 2021 10:31:47 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHvo7aXa1X+8dGrmvGimNrX4ONTfG-GWBwZeE1f5r349w@mail.gmail.com>
Message-ID: <CAMj1kXHvo7aXa1X+8dGrmvGimNrX4ONTfG-GWBwZeE1f5r349w@mail.gmail.com>
Subject: Re: [RFC PATCH] arch: arm64: have memblocks out of kernel text use
 section map
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jonathan Marek <jonathan@marek.ca>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 at 10:21, Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> By comparing the swapper_pg_dir with k54

I take it this means Linux v5.4 ?

> and previous versions,we find
> that the linear mappings within which the addr is out of kernel text section
> will use the smallest pte. It should arise for the sake of rodata_full, which
> set all memblock use NO_CONT_MAPPINGS.
>

OK so your intent seems to be to use block mappings for the linear
alias of the kernel text and rodata, right?

What does that achieve? It should make no difference in TLB pressure,
as the linear alias is rarely referenced (we only kept it around for
hibernate). So I guess we save a handful of pages for page tables.

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  arch/arm64/mm/mmu.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index cfd9deb..14e1bea 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -252,6 +252,8 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
>         pmd_clear_fixmap();
>  }
>
> +static bool crash_mem_map __initdata;
> +
>  static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>                                 unsigned long end, phys_addr_t phys,
>                                 pgprot_t prot,
> @@ -259,7 +261,15 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>  {
>         unsigned long next;
>         pud_t pud = READ_ONCE(*pudp);
> +       unsigned long len = end - addr;
> +       phys_addr_t kernel_start = __pa_symbol(_stext);
> +       phys_addr_t kernel_end = __pa_symbol(__init_begin);
>
> +       if (debug_pagealloc_enabled() || crash_mem_map || IS_ENABLED(CONFIG_KFENCE))
> +               ;
> +       else if (phys > kernel_end || phys + len < kernel_start) {
> +               flags &= ~(NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> +       }

Please don't use empty statements like this, and I'm not sure we even
need this check: I wouldn't expect debug_pagealloc or KFENCE to ever
require page granular mappings of this region either.

Also, please add a comment to explain what the condition is meant to
check (i..e, that the PMD entry covers a part of the linear alias of
the kernel image, and so there is no need to map it down to pages or
to avoid contiguous mappings)

>         /*
>          * Check for initial section mappings in the pgd/pud.
>          */
> @@ -483,7 +493,6 @@ void __init mark_linear_text_alias_ro(void)
>                             PAGE_KERNEL_RO);
>  }
>
> -static bool crash_mem_map __initdata;
>
>  static int __init enable_crash_mem_map(char *arg)
>  {
> --
> 1.9.1
>
