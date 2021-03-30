Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E429B34EDFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhC3Qeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhC3Qeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:34:44 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6293C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:34:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z1so18963673edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tb1iiWaE4NYfh8qMRuLct9CC/jvF2xlsJa5BguwsPYc=;
        b=HmXrspowOmFkqTO6GyLVRZ/0IYeywcjYLrET9yDo3B6x+GI5nAcYaAgXkFrg2+ORlg
         qAD3HkbBo40pWwfDlPcJwlZqoXMAr2aTPi9u+T9iN0kti+jW86OMfyjuykUHZchpVUkz
         lAwX898XL466Le7KPtVCmwHicyyt22tXUnmKeqqYHqT5H0uJkE05lL4ktYixDB9c4tF1
         FYx0jfcel8ZC8LQij9K3KUxuxTlgdnR6Pk7+RUTAQzLNhFltu8RtQ1J6nO/uVDTIoMgz
         TtOIdWjw9pbxsH107tZiq0d+BpI/vR4fBTr+Wk3NaVrydjgDxsQpEgOLANaZB4vNd0N3
         U/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tb1iiWaE4NYfh8qMRuLct9CC/jvF2xlsJa5BguwsPYc=;
        b=SPKPhL1iuczo+iIcOLrR/LGPe1cTK9qGN//wq0O5XxXNaEVeBp6RpgiAprmDV9uBz1
         Q/xrXE9ybuWme20n5mJpnHAtY37BvsqeVM+Mg9Zuu2iaAccuJo4BH2VbFjbqauY7z260
         h6SnNKHr2yk5UJwXoXMQEOTbY9h3I9XkNc8xKUmX6b1EoVB4Ziz4WSyLv7uIVSejIW7a
         B2jDsSOflKD/uGLlozxc6dSC6OtL+8hu0OmIYuQt23qnOzyJ/2WCz2QilkIlLkHF0rf0
         mEd+AdVchc0hl3eVbSz8VazgdcN/R0MSc2OrpBaS5VchcE0JhXzHXqhwUbV4bsTyNM+d
         /tbw==
X-Gm-Message-State: AOAM533CkoDJNgId71naAT4AqozjvfwoWhmixiMg+UC8LO7WeMu6VdfI
        o7ADPW3XzFfnGbkbS7d96Uar9HKgfCVVMN+KzTVJVzOs
X-Google-Smtp-Source: ABdhPJwSK0oW6GQDVlUqBmcJJcMsPvnCYbuT/7DEydBQpl73UZHju2ZhcVyexOOCFuXwNKF9/u2BnbBsYvc/va/W06M=
X-Received: by 2002:a05:6402:518d:: with SMTP id q13mr34909966edd.313.1617122082598;
 Tue, 30 Mar 2021 09:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210329193828.179993-1-shy828301@gmail.com> <624d1172-cdf9-ce82-aa0b-6646f3bee757@nvidia.com>
In-Reply-To: <624d1172-cdf9-ce82-aa0b-6646f3bee757@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 30 Mar 2021 09:34:30 -0700
Message-ID: <CAHbLzkqWhKRaXpjkCp2JUMJ9wn3aTeCyG+3NjVZt3mDhXAE9GA@mail.gmail.com>
Subject: Re: [PATCH] mm: gup: remove FOLL_SPLIT
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 12:08 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 3/29/21 12:38 PM, Yang Shi wrote:
> > Since commit 5a52c9df62b4 ("uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT")
> > and commit ba925fa35057 ("s390/gmap: improve THP splitting") FOLL_SPLIT
> > has not been used anymore.  Remove the dead code.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >   include/linux/mm.h |  1 -
> >   mm/gup.c           | 28 ++--------------------------
> >   2 files changed, 2 insertions(+), 27 deletions(-)
> >
>
> Looks nice.
>
> As long as I'm running git grep here, there is one more search hit that should also
> be fixed up, as part of a "remove FOLL_SPLIT" patch:
>
> git grep -nw FOLL_SPLIT
> Documentation/vm/transhuge.rst:57:follow_page, the FOLL_SPLIT bit can be specified as a parameter to
>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thanks. Removed the reference to FOLL_SPLIT in documentation for v2.

>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 8ba434287387..3568836841f9 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2780,7 +2780,6 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
> >   #define FOLL_NOWAIT 0x20    /* if a disk transfer is needed, start the IO
> >                                * and return without waiting upon it */
> >   #define FOLL_POPULATE       0x40    /* fault in page */
> > -#define FOLL_SPLIT   0x80    /* don't return transhuge pages, split them */
> >   #define FOLL_HWPOISON       0x100   /* check page is hwpoisoned */
> >   #define FOLL_NUMA   0x200   /* force NUMA hinting page fault */
> >   #define FOLL_MIGRATION      0x400   /* wait for page to replace migration entry */
> > diff --git a/mm/gup.c b/mm/gup.c
> > index e40579624f10..f3d45a8f18ae 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -435,18 +435,6 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
> >               }
> >       }
> >
> > -     if (flags & FOLL_SPLIT && PageTransCompound(page)) {
> > -             get_page(page);
> > -             pte_unmap_unlock(ptep, ptl);
> > -             lock_page(page);
> > -             ret = split_huge_page(page);
> > -             unlock_page(page);
> > -             put_page(page);
> > -             if (ret)
> > -                     return ERR_PTR(ret);
> > -             goto retry;
> > -     }
> > -
> >       /* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
> >       if (unlikely(!try_grab_page(page, flags))) {
> >               page = ERR_PTR(-ENOMEM);
> > @@ -591,7 +579,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
> >               spin_unlock(ptl);
> >               return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
> >       }
> > -     if (flags & (FOLL_SPLIT | FOLL_SPLIT_PMD)) {
> > +     if (flags & FOLL_SPLIT_PMD) {
> >               int ret;
> >               page = pmd_page(*pmd);
> >               if (is_huge_zero_page(page)) {
> > @@ -600,19 +588,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
> >                       split_huge_pmd(vma, pmd, address);
> >                       if (pmd_trans_unstable(pmd))
> >                               ret = -EBUSY;
> > -             } else if (flags & FOLL_SPLIT) {
> > -                     if (unlikely(!try_get_page(page))) {
> > -                             spin_unlock(ptl);
> > -                             return ERR_PTR(-ENOMEM);
> > -                     }
> > -                     spin_unlock(ptl);
> > -                     lock_page(page);
> > -                     ret = split_huge_page(page);
> > -                     unlock_page(page);
> > -                     put_page(page);
> > -                     if (pmd_none(*pmd))
> > -                             return no_page_table(vma, flags);
> > -             } else {  /* flags & FOLL_SPLIT_PMD */
> > +             } else {
> >                       spin_unlock(ptl);
> >                       split_huge_pmd(vma, pmd, address);
> >                       ret = pte_alloc(mm, pmd) ? -ENOMEM : 0;
> >
>
