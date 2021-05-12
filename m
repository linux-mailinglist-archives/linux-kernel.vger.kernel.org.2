Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C7837ED51
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386257AbhELUUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382763AbhELTpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 15:45:52 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C892C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 12:42:44 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c17so19426962pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNyPKfewiOG+4JoXBtJw18X3m/UEfPNiCXv5phkC7h8=;
        b=o5UsP0rDLBAs6y1mbILO2meD6IT6Od+Ft5nlgQk0YYxULqecly13h60X5jo0/KH34M
         nDakxS4l2wvVzfBQUQHwq7pyhOW4HvkNfufVP7lWvXV9dv5dzi8Q84xOTKzktCDaZVnT
         tNmmIPxy6i0XyMr8ZrgBugntU3oCme2qFKhIbLxkAWpfb4XnIWTjQQQ6QcfOMxg97tOB
         hni9AtGwTG5h0VuQPAjhtXwrUwu1wKjDPdUw3WqtH6k7xRbEwUNFOM6G2494lfLfr7+R
         RhHETiU0rN3fBKpql5Ej3uGA8KGawv/gL1aHE91gI1VjZhX6Lm53AnRBQzwtovhAn40s
         BpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNyPKfewiOG+4JoXBtJw18X3m/UEfPNiCXv5phkC7h8=;
        b=Alz4Aka8UCAH6MpEpBDrIXUd99GfKiLE5eHjW1n23C7wedwZsn/rXEL52uacWd7C7p
         HyZbP7Bha7eUNFC7arWrkQV1lT8zoCffcGLaKNr5FVahoyzOgBPF4fd3S8IkWqTq8s56
         H/QpvbRuERBg4QandRPhC5duBlMF1wBScXFtE9hZI68zpm2+5wUaWuXPKlsEqzeoTduE
         WmncDjmvZ8hCOoSeAqP4vIjRvk0O+uRXZoKziF9OJmFlrRJ/XVCo98KhaO4IMGOKM2kt
         yPyYq9bZfG9TVFo/cxzOweyoHQSaCQh79METbHHnmJHdDZswbnyy92ucrdCTcMPtcSn/
         tSmA==
X-Gm-Message-State: AOAM531+ig3kW2bzKjXQ9S5waWp3zIW08Yj9knKautk5hg/tAzHxiQma
        fRFO8Ustao6ZnNMqWpBl0A6HPH933VHIvA4akyzLnA==
X-Google-Smtp-Source: ABdhPJxdjiDtYqG8gqEjdRdc5eyzwsSYcqQAijzO2agw0h+mdwirm/gE8rrNbZQe2evUTaA7XXaMf5kfpPij0Oetxig=
X-Received: by 2002:aa7:904e:0:b029:28f:da01:1a5f with SMTP id
 n14-20020aa7904e0000b029028fda011a5fmr36651523pfo.67.1620848563984; Wed, 12
 May 2021 12:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <e134d74d-c218-a01d-a315-82b909c84051@oracle.com>
 <20210512065813.89270-1-almasrymina@google.com> <CAJHvVch0ZMapPVEc0Ge5V4KDgNDNhECbqwDi0y9XxsxFXQZ-gg@mail.gmail.com>
 <c455d241-11f6-95a6-eb29-0ddd94eedbd7@oracle.com>
In-Reply-To: <c455d241-11f6-95a6-eb29-0ddd94eedbd7@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 12 May 2021 12:42:32 -0700
Message-ID: <CAHS8izM8G948ziJToaNKgqaMQ9_CB+anksGQQHSbTY1a+yGSjg@mail.gmail.com>
Subject: Re: [PATCH] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 10:22 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 5/12/21 8:53 AM, Axel Rasmussen wrote:
> > On Tue, May 11, 2021 at 11:58 PM Mina Almasry <almasrymina@google.com> wrote:
> >>
> >> When hugetlb_mcopy_atomic_pte() is called with:
> >> - mode==MCOPY_ATOMIC_NORMAL and,
> >> - we already have a page in the page cache corresponding to the
> >> associated address,
> >>
> >> We will allocate a huge page from the reserves, and then fail to insert it
> >> into the cache and return -EEXIST.
> >>
> >> In this case, we need to return -EEXIST without allocating a new page as
> >> the page already exists in the cache. Allocating the extra page causes
> >> the resv_huge_pages to underflow temporarily until the extra page is
> >> freed.
> >>
> >> Also, add the warning so that future similar instances of resv_huge_pages
> >> underflowing will be caught.
> >>
> >> Also, minor drive-by cleanups to this code path:
> >> - pagep is an out param never set by calling code, so delete code
> >> assuming there could be a valid page in there.
> >> - use hugetlbfs_pagecache_page() instead of repeating its
> >> implementation.
> >>
> >> Tested using:
> >> ./tools/testing/selftests/vm/userfaultfd hugetlb_shared 1024 200 \
> >> /mnt/huge
> >>
> >> Test passes, and dmesg shows no underflow warnings.
> >>
> >> Signed-off-by: Mina Almasry <almasrymina@google.com>
> >> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> >> Cc: Axel Rasmussen <axelrasmussen@google.com>
> >> Cc: Peter Xu <peterx@redhat.com>
> >>
> >> ---
> >>  mm/hugetlb.c | 33 ++++++++++++++++++++-------------
> >>  1 file changed, 20 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >> index 629aa4c2259c..40f4ad1bca29 100644
> >> --- a/mm/hugetlb.c
> >> +++ b/mm/hugetlb.c
> >> @@ -1165,6 +1165,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
> >>         page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
> >>         if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
> >>                 SetHPageRestoreReserve(page);
> >> +               WARN_ON_ONCE(!h->resv_huge_pages);
>
> This warning catches underflow in a relatively specific case.  In a
> previous email, you mentioned that you have seem underflow on production
> systems several times.  Was it this specific case?  I am also assuming
> that the underflow you saw was transitive and corrected itself.  The
> value did not remain negative?
>
> As mentioned above, this warning only catches the specific case where
> resv_huge_pages goes negative in this routine.  If we believe this is
> possible, then there are likely more cases where resv_huge_pages is simply
> decremented when it should not.  For example: resv_huge_pages temporarily
> goes to 2034 from 2035 when it should not.  Also, there are several
> other places where resv_huge_pages could incorrectly be modified and go
> negative.
>

My only motivation for adding this particular warning is to make sure
this particular issue remains fixed and doesn't get re-introduced in
the future. If that's not too useful then I can remove it, no problem,
I'm not too attached to it or anything.

> I would prefer not to add this warning unless you have seen this
> specific case in production or some other environments.  If so, then
> please add the specifics.  I am not opposed to adding warnings or code to
> detect underflow or other accounting issues.  We just need to make sure
> they are likely to provide useful data.
>

I've actually looked at all the resv_huge_pages underflow issues we
have internally, and upon a closer look I find that they are all on
kernels so old they don't have 1b1edc140dc7 ("hugetlbfs: dirty pages
as they are added to pagecache") or any of the others patches that
fixed resv_huge_pages issues recently. I can't seem to find instances
new enough that they would be useful to look at, so I take back what I
said earlier. If any underflow issues pop up on our newer kernels I'll
bring this up again, but for now, it seems it's just this issue
related to userfaultfd. Sorry for the noise :(

> >>                 h->resv_huge_pages--;
> >>         }
> >>
> >> @@ -4868,30 +4869,39 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >>                             struct page **pagep)
> >>  {
> >>         bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
> >> -       struct address_space *mapping;
> >> -       pgoff_t idx;
> >> +       struct hstate *h = hstate_vma(dst_vma);
> >> +       struct address_space *mapping = dst_vma->vm_file->f_mapping;
> >> +       pgoff_t idx = vma_hugecache_offset(h, dst_vma, dst_addr);
> >>         unsigned long size;
> >>         int vm_shared = dst_vma->vm_flags & VM_SHARED;
> >> -       struct hstate *h = hstate_vma(dst_vma);
> >>         pte_t _dst_pte;
> >>         spinlock_t *ptl;
> >> -       int ret;
> >> +       int ret = -ENOMEM;
> >>         struct page *page;
> >>         int writable;
> >>
> >> -       mapping = dst_vma->vm_file->f_mapping;
> >> -       idx = vma_hugecache_offset(h, dst_vma, dst_addr);
> >> +       /* Out parameter. */
> >> +       WARN_ON(*pagep);
> >
> > I don't think this warning works, because we do set *pagep, in the
> > copy_huge_page_from_user failure case. In that case, the following
> > happens:
> >
> > 1. We set *pagep, and return immediately.
> > 2. Our caller notices this particular error, drops mmap_lock, and then
> > calls us again with *pagep set.
> >
> > In this path, we're supposed to just re-use this existing *pagep
> > instead of allocating a second new page.
> >
> > I think this also means we need to keep the "else" case where *pagep
> > is set below.
> >
>
> +1 to Peter's comment.
>

Gah, sorry about that. I'll fix in v2.

> --
> Mike Kravetz
