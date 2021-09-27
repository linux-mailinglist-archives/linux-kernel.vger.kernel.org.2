Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBA6418F01
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 08:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhI0GXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 02:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232122AbhI0GXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 02:23:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2F296117A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 06:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632723713;
        bh=rAzqtdkzmasWhc6P96P3ZVcdsCjYL4o8Q3yuP5FVT1o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ck+zCHop7KYWO72g4tYIDnoyIYNnzOXpFNUESVgh3s8KuOQfu4G0mq2bk4dBJlnVb
         4KpC03FlwRI2mrxTRcsjSVaw/sFCL70kzwseCMB0Zd1ptbDWMCLawuLMV+UUy6yFvz
         fsYJ1lFcIOB6PY9QLpQTNV1Q86Llar11Qba2MEUJ4AeCC09dVfo1eg2dl4eCdW2Dby
         6jfDZb0B2sQewTpl/NBNvyj5vLM53LVo+LgXpaJ5oUFhvQlqmBSGS095NUJBsoTJWL
         3ieH97UFiEJ19M1syXl6p8OgZ28Qpy3pw594rMfmeZKBA58kiJBT/HwXKiNuzKLUpC
         atMnqPL4/yGaQ==
Received: by mail-lf1-f42.google.com with SMTP id m3so72752081lfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 23:21:53 -0700 (PDT)
X-Gm-Message-State: AOAM531mrCNNzP3ddhzNagk1LYVB7aNxU5TbvdZhzt/0bZjsjO67eIUB
        nuavU9TEZQQlmYTqM13y6dCxV7UViT1ZSraQayA=
X-Google-Smtp-Source: ABdhPJw+qj+k7e3EfZQynDm+jWx3Ct+iTCG+gtpxuutNZ9U03OIH4gAlQHYX8iHJzILyRMa923fnBaCWifjoiUyaKTc=
X-Received: by 2002:a2e:898c:: with SMTP id c12mr27784494lji.16.1632723712220;
 Sun, 26 Sep 2021 23:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210924060821.1138281-1-guoren@kernel.org> <30c10b5f-1b26-e0a8-8185-6fa3296d68dc@arm.com>
In-Reply-To: <30c10b5f-1b26-e0a8-8185-6fa3296d68dc@arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 27 Sep 2021 14:21:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRmvYBG5=NN4-53z2Gk-bC42LOHsEzHV6cnruoq1Xh0LA@mail.gmail.com>
Message-ID: <CAJF2gTRmvYBG5=NN4-53z2Gk-bC42LOHsEzHV6cnruoq1Xh0LA@mail.gmail.com>
Subject: Re: [PATCH V2] mm: debug_vm_pgtable: Don't use __P000 directly
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it, thanks!

On Mon, Sep 27, 2021 at 10:16 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 9/24/21 11:38 AM, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The __Pxxx/__Sxxx macros are only for protection_map[] init. All
> > usage of them in linux should come from protection_map array.
> >
> > Because a lot of architectures would re-initilize protection_map[]
> > array, eg: x86-mem_encrypt, m68k-motorola, mips, arm, sparc.
> >
> > Using __P000 is not rigorous.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
>
>
> >
> > ---
> >
> > Changes since V2:
> >  - s/init protection_map[]/protection_map[] init/
> >  - s/Becasue/Because/
> >  - Remove unclear part
> >  - Replace __P000 and __S000 with protection_map[0] and
> >    protection_map[8]
> > ---
> >  mm/debug_vm_pgtable.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> > index 1403639302e4..228e3954b90c 100644
> > --- a/mm/debug_vm_pgtable.c
> > +++ b/mm/debug_vm_pgtable.c
> > @@ -1104,13 +1104,14 @@ static int __init init_args(struct pgtable_debug_args *args)
> >       /*
> >        * Initialize the debugging data.
> >        *
> > -      * __P000 (or even __S000) will help create page table entries with
> > -      * PROT_NONE permission as required for pxx_protnone_tests().
> > +      * protection_map[0] (or even protection_map[8]) will help create
> > +      * page table entries with PROT_NONE permission as required for
> > +      * pxx_protnone_tests().
> >        */
> >       memset(args, 0, sizeof(*args));
> >       args->vaddr              = get_random_vaddr();
> >       args->page_prot          = vm_get_page_prot(VMFLAGS);
> > -     args->page_prot_none     = __P000;
> > +     args->page_prot_none     = protection_map[0];
> >       args->is_contiguous_page = false;
> >       args->pud_pfn            = ULONG_MAX;
> >       args->pmd_pfn            = ULONG_MAX;
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
