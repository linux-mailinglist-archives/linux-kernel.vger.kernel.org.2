Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83D539E6CB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhFGSow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:44:52 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:35551 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhFGSos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:44:48 -0400
Received: by mail-ed1-f41.google.com with SMTP id ba2so19853681edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 11:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uH3JX7eLYLyOx1BXQqsWzSMIggN9SNhVfMkmQqWxCNc=;
        b=ikWnpIie5hZMfnWHLaAlHOf3oFbHhY+zg+SStiWL60r5U+C0O4Ue2By9cpXdtflevA
         uWT39JDJ19Cm+CO+hACPkQJyJY5t0jPVbHzfaZqjESs07e14KndIApuWEMYzopEuXvzN
         0Aml7wOvBPkK8Eq8PyrYVZGn5r0ZsN9mv58nFGPbjC1HZMYobQBZSwBTWxxL7k7r6/YZ
         Tshq72TGLuXYsLvaJBytxAfSZJASVXMWAHLRxoXzohOSQb6z+V/6/Ob+bZc0CFYJNqkA
         jyFkgEDete6cM1nyN61V+H/vnGEa+aNDriUXOySLUkbg2DneeT3nhegxTvbCLi+w+QtO
         6lPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uH3JX7eLYLyOx1BXQqsWzSMIggN9SNhVfMkmQqWxCNc=;
        b=OSyh+CMbpIui8V7UQar4hGG3Nyw1Y2RKzeNVeK4YsqhmsxpKrCyzdgdlwjgAVaj9X7
         DUXXKZ1/LLkGMhgZmG8BIUXYnQUmV/vC2LhczZwmbthzgTSadFq5u/h93BPuvCA5616H
         ik7K3wOfeSBvt2VFBu1mz7pkiSEbpj5x5KrtnUMsO1AaLo7BHbO2Hb/P9KtQmhoLawXV
         CNHlnUr+rGFTsZ+IqBMSM2vutO6r/059PEEmc+F+LDK1XKIL9v9ij8yu8+nQfgxds8T1
         MFjF5rAAjagw5r5Pvp1WPMrFw2U2wDXNy9kEWoJTeJCzI1LFJQWIkdCzGa+qEqS4Jhio
         gAIQ==
X-Gm-Message-State: AOAM533qwi2oeoCT2mksKbFMrFdKlpUd1IBTAMSadI0WIJsm05E/5i+y
        SMS0+RwDFVMOXO8nXwWRAxCqkOB8M4lcIyCqCuQ=
X-Google-Smtp-Source: ABdhPJxXXvFSZ4J8Womwhx/S9wH7EqXmcyHijmzrDfdRjsFBFnuDp0KcoJnDN2VODbCoopayt21wrEL7t478AIamAko=
X-Received: by 2002:a05:6402:42d2:: with SMTP id i18mr21378919edc.168.1623091299806;
 Mon, 07 Jun 2021 11:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210604203513.240709-1-shy828301@gmail.com> <YL265A86DQe5Rgon@dhcp22.suse.cz>
 <CAHbLzkowcskM=p==-q48Ca12D=h9SgqUuUB4NknRNR=64TyXCw@mail.gmail.com>
In-Reply-To: <CAHbLzkowcskM=p==-q48Ca12D=h9SgqUuUB4NknRNR=64TyXCw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 7 Jun 2021 11:41:27 -0700
Message-ID: <CAHbLzkqWa2SMQTc6vfsus5u58X9ODZ1BhEwmg1t+1XynrnbNHA@mail.gmail.com>
Subject: Re: [PATCH] mm: mempolicy: don't have to split pmd for huge zero page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Zi Yan <ziy@nvidia.com>, nao.horiguchi@gmail.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 10:00 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Sun, Jun 6, 2021 at 11:21 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 04-06-21 13:35:13, Yang Shi wrote:
> > > When trying to migrate pages to obey mempolicy, the huge zero page is
> > > split then the page table walk at PTE level just skips zero page.  So it
> > > seems pointless to split huge zero page, it could be just skipped like
> > > base zero page.
> >
> > My THP knowledge is not the best but this is incorrect AIACS. Huge zero
> > page is not split. We do split the pmd which is mapping the said page. I
> > suspect you refer to vm_normal_page when talking about a zero page but
> > please be aware that huge zero page is not a normal zero page. It is
> > allocated dynamically (see get_huge_zero_page).
>
> For a normal huge page, yes, split_huge_pmd() just splits pmd. But
> actually the base zero pfn will be inserted to PTEs when splitting
> huge zero pmd. Please check __split_huge_zero_page_pmd() out.
>
> I should make this point clearer in the commit log. Sorry for the confusion.
>
> >
> > So in the end you patch disables mbind of zero pages to a target node
> > and that is a regression.
>
> Do we really migrate zero page? IIUC zero page is just skipped by
> vm_normal_page() check in queue_pages_pte_range(), isn't it?
>
> >
> > Have you tested the patch?
>
> No, just build test. I thought this change was straightforward.

Just came up with a quick test, the test is trying to mbind 1G address
space (use huge zero page) to another node, the result is:

w/o patch:
pgmigrate_success 0
pgmigrate_fail 0
thp_migration_success 0
thp_migration_fail 0
thp_migration_split 0

thp_split_pmd 512
thp_split_pud 0
thp_zero_page_alloc 1


w/ patch:
pgmigrate_success 0
pgmigrate_fail 0
thp_migration_success 0
thp_migration_fail 0
thp_migration_split 0

thp_split_pmd 0
thp_split_pud 0
thp_zero_page_alloc 1


We can tell neither huge zero nor base zero was migrated even before
the patch. The patch just kills the pointless pmd split and we keep
the huge zero page.

>
> >
> > > Set ACTION_CONTINUE to prevent the walk_page_range() split the pmd for
> > > this case.
> >
> > Btw. this changelog is missing a problem statement. I suspect there is
> > no actual problem that it should fix and it is likely driven by reading
> > the code. Right?
>
> The actual problem is it is pointless to split a huge zero pmd. Yes,
> it is driven by visual inspection.
>
> The behavior before the patch for huge zero page is:
> split huge zero pmd (insert base zero pfn to ptes)
> walk ptes
> skip zero pfn
>
> So why not just skip the huge zero page in the first place?
>
> >
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> > >  mm/mempolicy.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > index b5f4f584009b..205c1a768775 100644
> > > --- a/mm/mempolicy.c
> > > +++ b/mm/mempolicy.c
> > > @@ -436,7 +436,8 @@ static inline bool queue_pages_required(struct page *page,
> > >
> > >  /*
> > >   * queue_pages_pmd() has four possible return values:
> > > - * 0 - pages are placed on the right node or queued successfully.
> > > + * 0 - pages are placed on the right node or queued successfully, or
> > > + *     special page is met, i.e. huge zero page.
> > >   * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
> > >   *     specified.
> > >   * 2 - THP was split.
> > > @@ -460,8 +461,7 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
> > >       page = pmd_page(*pmd);
> > >       if (is_huge_zero_page(page)) {
> > >               spin_unlock(ptl);
> > > -             __split_huge_pmd(walk->vma, pmd, addr, false, NULL);
> > > -             ret = 2;
> > > +             walk->action = ACTION_CONTINUE;
> > >               goto out;
> > >       }
> > >       if (!queue_pages_required(page, qp))
> > > @@ -488,7 +488,8 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
> > >   * and move them to the pagelist if they do.
> > >   *
> > >   * queue_pages_pte_range() has three possible return values:
> > > - * 0 - pages are placed on the right node or queued successfully.
> > > + * 0 - pages are placed on the right node or queued successfully, or
> > > + *     special page is met, i.e. zero page.
> > >   * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
> > >   *     specified.
> > >   * -EIO - only MPOL_MF_STRICT was specified and an existing page was already
> > > --
> > > 2.26.2
> >
> > --
> > Michal Hocko
> > SUSE Labs
