Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69641416B22
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 07:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244097AbhIXFNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 01:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232553AbhIXFNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 01:13:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDDE96103B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632460298;
        bh=JBV4wUFyqvPA6JDZml2Lwl/RV5UFuo9v+vAuM5LVucY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j80bLqbdwj6oiiWU8WnCjOw3HOzFrrmbAdCfE5aEyAKKlCpPsmBiFZUOXQY+9UxzA
         TqalUSxaWGb4pmcfVObstlK4q2tG/PAPSlG6TlbZODBngLcZlZey8eI6QX9kIQ6Cue
         yQtQ8sjm0XG2qnnBJoIr44ltIGuRAqfH1WWZxTOyiKiYsZStJ5DxiztMBfNmxjg+Hr
         jEJV7zQrIBlsAXK6gvbUkPpkGswDADgxcsbN09YbTwgyvfHCZP0Yel4iydh2Olg1hP
         j8wiu/WORKahVtka/Nps7Jy0liD2HTLT2MRA9Ehbc7mafPRfO3trMVB9kVr5hEOp4b
         yH3h6mBGiLfkA==
Received: by mail-vs1-f44.google.com with SMTP id az15so8801376vsb.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 22:11:38 -0700 (PDT)
X-Gm-Message-State: AOAM5302/K3EyOduRRBoRpcaKgAvsevWwzV7brCnBaTEcPhqcQ1pRhUe
        tkarHgs2SjLCC7lXFtdHqAoIPuVS4n58d1MUoV8=
X-Google-Smtp-Source: ABdhPJz+S3tx4XKSaFcdk5DOBZ+n2y4iQ1eHTFWFhE8ShvQuPpGoOE+wZv3Et1SRJ1s2sVBvACtsgwzusjcKF55m7o4=
X-Received: by 2002:a67:2f96:: with SMTP id v144mr7718145vsv.33.1632460298043;
 Thu, 23 Sep 2021 22:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210921201815.284412-1-guoren@kernel.org> <ab52f71f-0419-fd22-d59e-a87713886cfd@arm.com>
In-Reply-To: <ab52f71f-0419-fd22-d59e-a87713886cfd@arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 24 Sep 2021 13:11:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRHMymUm6pWtqkou4W51O9r-q0QEaNn=T-EBarfe=tpWQ@mail.gmail.com>
Message-ID: <CAJF2gTRHMymUm6pWtqkou4W51O9r-q0QEaNn=T-EBarfe=tpWQ@mail.gmail.com>
Subject: Re: [PATCH] mm: debug_vm_pgtable: Don't use __P000 directly
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 11:30 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Hello Guo,
>
> On 9/22/21 1:48 AM, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The __Pxxx/__Sxxx macros are only for init protection_map[]. All
>
> s/init protection_map[]/protection_map[] int/
                                                                   ^^^
Okay, protection_map[] init

>
> Or rephrase with something similar.
>
> > usage of them in linux should come from protection_map array.
>
> Agreed.
>
> >
> > Becasue a lot of architectures would re-initilize protection_map[]
>
> s/Becasue/Because/
>
> ./scripts/checkpatch.pl ./0001-mm-debug_vm_pgtable-Don-t-use-__P000-directly.patch
> WARNING: 'Becasue' may be misspelled - perhaps 'Because'?
> #9:
> Becasue a lot of architectures would re-initilize protection_map[]
> ^^^^^^^
>
> total: 0 errors, 1 warnings, 15 lines checked
I would use checkpatch.pl next time, thx.

>
> > array, eg: x86-mem_encrypt, m68k-motorola, mips, arm, sparc.
> >
> > Using __P000 maybe won't cause bug because hw would deny access
>
> Not very clear. Could you please rephrase.
Using __P000 directly wouldn't equal protection_map[0] in many arches,
but the reason why it didn't cause the problem is the hardware ignores
the other bits when prot-attribute is denied.

>
> > with PROT_NONE permission, but it's not rigorous.
>
> Agreed.
>
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  mm/debug_vm_pgtable.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> > index 1403639302e4..a6ebbf6e53dd 100644
> > --- a/mm/debug_vm_pgtable.c
> > +++ b/mm/debug_vm_pgtable.c
> > @@ -1104,13 +1104,13 @@ static int __init init_args(struct pgtable_debug_args *args)
> >       /*
> >        * Initialize the debugging data.
> >        *
> > -      * __P000 (or even __S000) will help create page table entries with
> > +      * __P000 (protection_map[0]) will help create page table entries with
>
> Please just replace __P000 and __S000 with protection_map[0] and
> protection_map[8] respectively. Also reformat this comment section
> if required.
>
> >        * PROT_NONE permission as required for pxx_protnone_tests().
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
>
> With the above changes in place.
>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
