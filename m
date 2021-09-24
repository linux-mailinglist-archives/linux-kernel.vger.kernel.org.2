Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78900416B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 08:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244187AbhIXGLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 02:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231675AbhIXGLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 02:11:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95FFF61107
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632463776;
        bh=ZOiKLlqiRvlFc3D7uDzwSfVO+ILpnPmwhZUWQMKKk2c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GwSIAfagfLLYpa3iFFHxyLe+dw74ke2k53XYWqgLtnj2fDgOKVCmvTdC6j88xGl4G
         gLwjMk4p2Ryk0mc9NaYFWDzqd3wK98+ncTaJ1S7HN6X9gCQfaariwv6OZSYEVefOhm
         LVMi0ByBAma0G4eIeCgj9XEV04GGlpci8lynt1Ol/6RghyMEVq+Pk4bQRMZCVY95nl
         AGNzM2gHaubeLcew1cw+dgwUupo8xYUxBEO+Jf91CjFHdAAHnjy8+Cazv0af1Q+D7A
         3z05ungRDUb+j8ctxXMTVl9PWmawJvSEkdXxCkkHg2Ro4FqHZJYu0NA7bp5291N1Gz
         HYKrwF/x2LzGw==
Received: by mail-vs1-f50.google.com with SMTP id u8so8951153vsp.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 23:09:36 -0700 (PDT)
X-Gm-Message-State: AOAM533TzMoxNXfY5eUCMvvAmB5H7PCloFL6ALPM6n1aDbsxYobL6giq
        HwTUMU5iJMTSWRn/Svk/2ZQOxEpVGiO0spIUH68=
X-Google-Smtp-Source: ABdhPJzqFJpZxwcQU7NlvCwFlTAZrRJi8bOkUsHWlRKge2v87Wu+bU0EljWXNZvMDY+K+80SsW90iKUFwLq5h//3kHE=
X-Received: by 2002:a67:3204:: with SMTP id y4mr7516832vsy.28.1632463775776;
 Thu, 23 Sep 2021 23:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210924060654.1137902-1-guoren@kernel.org>
In-Reply-To: <20210924060654.1137902-1-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 24 Sep 2021 14:09:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTYHqJdz0+rrNyLPSi+Q-LLQYk=pb86vfnd1u03G+Sovw@mail.gmail.com>
Message-ID: <CAJF2gTTYHqJdz0+rrNyLPSi+Q-LLQYk=pb86vfnd1u03G+Sovw@mail.gmail.com>
Subject: Re: [PATCH] mm: debug_vm_pgtable: Don't use __P000 directly
To:     Guo Ren <guoren@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the patch forgets to add --prefix PATCH V2, abandon.

Review the V2, thx.

On Fri, Sep 24, 2021 at 2:07 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The __Pxxx/__Sxxx macros are only for protection_map[] init. All
> usage of them in linux should come from protection_map array.
>
> Because a lot of architectures would re-initilize protection_map[]
> array, eg: x86-mem_encrypt, m68k-motorola, mips, arm, sparc.
>
> Using __P000 is not rigorous.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
>
> ---
>
> Changes since V2:
>  - s/init protection_map[]/protection_map[] init/
>  - s/Becasue/Because/
>  - Remove unclear part
>  - Replace __P000 and __S000 with protection_map[0] and
>    protection_map[8]
> ---
>  mm/debug_vm_pgtable.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 1403639302e4..228e3954b90c 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -1104,13 +1104,14 @@ static int __init init_args(struct pgtable_debug_args *args)
>         /*
>          * Initialize the debugging data.
>          *
> -        * __P000 (or even __S000) will help create page table entries with
> -        * PROT_NONE permission as required for pxx_protnone_tests().
> +        * protection_map[0] (or even protection_map[8]) will help create
> +        * page table entries with PROT_NONE permission as required for
> +        * pxx_protnone_tests().
>          */
>         memset(args, 0, sizeof(*args));
>         args->vaddr              = get_random_vaddr();
>         args->page_prot          = vm_get_page_prot(VMFLAGS);
> -       args->page_prot_none     = __P000;
> +       args->page_prot_none     = protection_map[0];
>         args->is_contiguous_page = false;
>         args->pud_pfn            = ULONG_MAX;
>         args->pmd_pfn            = ULONG_MAX;
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
