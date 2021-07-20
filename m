Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F0D3D0493
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 00:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhGTVlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 17:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhGTVkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 17:40:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A63C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 15:21:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h8so30376462eds.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUTmtTejbEnPRbu3cg3+KcdqGXEVg+RQFqP1834V1W8=;
        b=oTaTN1zAc2XovdqoMGL9tGPcZxHy+uTyPFvZma1Xs2GZBOZsYqBEBQX21g9dmGdzYJ
         5V2f+jPLPfwIuauC0Qyvqb8lfZTU2JUDubJmRCzWV6xNUhf/qBKAOVTLXpuWrEmlQgs8
         qA/6JMjdoQ9aqObLG+2AAmuXy1xhHNINHCY1ToEfkjImp4N5LmubaxPOpi/9pPoLtuLx
         ubBTH2U6QSbqTSSiLFkuI+OK4BwoxL9bgCktUMLxvVlHs7wnC1Fg7fvLaQreBfkaa0KJ
         ovyE5wRzxqUlb+usX2FuzlKvEZienUmydtXG57KmiRjLdF5P3qzitQmTRHFojUJnt0yS
         +Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUTmtTejbEnPRbu3cg3+KcdqGXEVg+RQFqP1834V1W8=;
        b=XQAq4Ox8hOmeKB/LStPcqAntYP+CNh80fQQSE5Iu9VTN/PZZ5lhheVoBYP02bamGPA
         mQ4Va/nFvJOZS/PNM4GZeliSUqwQkz7lQxvsgPmU87T5OoxFUWQo3HonG20kRawc2bwz
         pIyxFjqAbNedYqdeAl7qkzfJ5zD7DjpF9yX6jqenHW+8i2yY2D+/UncS5g3mgMfdBUam
         sETLgLcmO2OWpANjy4X4H1h7QAt8PHUnIsIpiA/GMIznEyHxuXphQ4bEFvW/iwJ9WQzQ
         IY0P18Gdyj1rFdB6GWuf5hCLhGKlSswtwycgmV6E/EInsqYdq8TvJVWkAiKO+i6qn8j0
         QP7A==
X-Gm-Message-State: AOAM5315dIkQbBm6Lku7eFIwJsH2dycXOHB3haKHEV/DfhI8YKvd6S4Y
        1SMIstc2TwqFPZKucmC0VexZ1TXknLk77KqRJNA=
X-Google-Smtp-Source: ABdhPJwdwBIjPIhxMElcrJDHN7H8Naz43IOlQjuV3+TkDHVJUoYB06Oe3nclcfDJpwuqlDUnygbmwdorai+cH5PkELE=
X-Received: by 2002:aa7:ca54:: with SMTP id j20mr44196757edt.137.1626819688962;
 Tue, 20 Jul 2021 15:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210720065529.716031-1-ying.huang@intel.com> <CAHbLzkrKZNT1MwrCp0SOzZ43C12DZzNmPKXLwxKZ=j+YgOaW=g@mail.gmail.com>
In-Reply-To: <CAHbLzkrKZNT1MwrCp0SOzZ43C12DZzNmPKXLwxKZ=j+YgOaW=g@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 20 Jul 2021 15:21:06 -0700
Message-ID: <CAHbLzkrRDPnJ=T4hBARgo4pHkrZu4Hrx=u3wuSjceDF4eXN+HQ@mail.gmail.com>
Subject: Re: [PATCH] mm,do_huge_pmd_numa_page: remove unnecessary TLB flushing code
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mel Gorman <mgorman@suse.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 1:48 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Mon, Jul 19, 2021 at 11:56 PM Huang Ying <ying.huang@intel.com> wrote:
> >
> > Before the commit c5b5a3dd2c1f ("mm: thp: refactor NUMA fault
> > handling"), the TLB flushing is done in do_huge_pmd_numa_page() itself
> > via flush_tlb_range().
> >
> > But after commit c5b5a3dd2c1f ("mm: thp: refactor NUMA fault
> > handling"), the TLB flushing is done in migrate_pages() as in the
> > following code path anyway.
> >
> > do_huge_pmd_numa_page
> >   migrate_misplaced_page
> >     migrate_pages
> >
> > So now, the TLB flushing code in do_huge_pmd_numa_page() becomes
> > unnecessary.  So the code is deleted in this patch to simplify the
> > code.  This is only code cleanup, there's no visible performance
> > difference.
>
> Yes, there is tlb flush in try_to_migrate(), but it seems mmu notifier
> invalidate is missed for the THP migration case. I'm not quite sure
> why it is not needed, maybe just missed?
>
> So, you may need the below change too:
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2d29a57d29e8..e1c8b654563d 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1749,6 +1749,8 @@ static bool try_to_migrate_one(struct page
> *page, struct vm_area_struct *vma,
>                                        !PageTransCompound(page), page);
>
>                         set_pmd_migration_entry(&pvmw, page);
> +                       mmu_notifier_invalidate_range(mm, range.start,
> +                                                     range.end);
>                         continue;
>                 }
>  #endif

Per the discussion with Zi Yan the mmu notifier invalidate should be
not needed. The patch looks good to me. Reviewed-by: Yang Shi
<shy828301@gmail.com>

>
> >
> > Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Yang Shi <shy828301@gmail.com>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > Cc: Heiko Carstens <hca@linux.ibm.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Zi Yan <ziy@nvidia.com>
> > ---
> >  mm/huge_memory.c | 26 --------------------------
> >  1 file changed, 26 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index afff3ac87067..9f21e44c9030 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1440,32 +1440,6 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
> >                 goto out;
> >         }
> >
> > -       /*
> > -        * Since we took the NUMA fault, we must have observed the !accessible
> > -        * bit. Make sure all other CPUs agree with that, to avoid them
> > -        * modifying the page we're about to migrate.
> > -        *
> > -        * Must be done under PTL such that we'll observe the relevant
> > -        * inc_tlb_flush_pending().
> > -        *
> > -        * We are not sure a pending tlb flush here is for a huge page
> > -        * mapping or not. Hence use the tlb range variant
> > -        */
> > -       if (mm_tlb_flush_pending(vma->vm_mm)) {
> > -               flush_tlb_range(vma, haddr, haddr + HPAGE_PMD_SIZE);
> > -               /*
> > -                * change_huge_pmd() released the pmd lock before
> > -                * invalidating the secondary MMUs sharing the primary
> > -                * MMU pagetables (with ->invalidate_range()). The
> > -                * mmu_notifier_invalidate_range_end() (which
> > -                * internally calls ->invalidate_range()) in
> > -                * change_pmd_range() will run after us, so we can't
> > -                * rely on it here and we need an explicit invalidate.
> > -                */
> > -               mmu_notifier_invalidate_range(vma->vm_mm, haddr,
> > -                                             haddr + HPAGE_PMD_SIZE);
> > -       }
> > -
> >         pmd = pmd_modify(oldpmd, vma->vm_page_prot);
> >         page = vm_normal_page_pmd(vma, haddr, pmd);
> >         if (!page)
> > --
> > 2.30.2
> >
