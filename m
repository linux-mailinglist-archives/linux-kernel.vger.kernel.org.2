Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF9538B760
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbhETTWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238137AbhETTWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:22:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB2CC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:21:14 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e15so3042502plh.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CeN9GBd+V6Hx1HhJKDIlPQtnd+p0opbcdXSqGR3n21U=;
        b=u1IVQcySroL4ZbG3Jr/riMk3838ALT3P/KkmuA20Ph2fBVKn9gkslFjYIQwCIw1wV6
         0W30HB14NFhfOFQm+pz7rbUT6YG/IMYVn18yVWSLg8SxnHxBYBIwuxIsvxjSLxPqXWkL
         qy4SU1WGw8AinnnGpX0U9OCnli+tklLLkqGIVJICDlwIoHY39w/ykal55s/YVndhxUxq
         e4YoaYVyjNqEKEqxIGDbJmYxVSBHSmcK4FfOyD6L7D6MfQdq82bMw6m+MrB779W/3XVb
         fH3Qxp8J0nU0O1ue6HZQ/Hr0zlIoSzEchIs1pZKTwPAd7Q5Uy8deUyjDnlPi34H/nRmY
         gTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CeN9GBd+V6Hx1HhJKDIlPQtnd+p0opbcdXSqGR3n21U=;
        b=emty0F+p9L/cg3qRMjET4tLAZhCuJEpl3rKCBP0JLqGJV1kOJ6n4IFAUNZxM3jhVUC
         1PWGdwKkEq+jB8e7CorAONCSSlQtljLPtJzfNUa2JbSj9Ap+zyvSKaXSV2mofE39htB8
         U+ZFmrtZFLYHEu9pvEnEQlCOgAyzJ3tWfIbEzeqWOA7dG4bFaJBs4C6cofrVm/itXa0h
         e0St7pMOep9d2lWM9dSWsfZ7Zz6waTnGHFN5TtrK3YbTlLX1uRbucwsQQcxrBMiwX3pA
         kDYyXC5oRpKW0vyKkucZ/kImFagCX0dKOgQDNcOKVsmTFmy14MwUd1n8vdLI5V0MjSly
         /f+w==
X-Gm-Message-State: AOAM531U9kLHKJXMTL6GJ1m2bc4sYcJXxmlJrhIiMHtIdF5C99cMRFuL
        vASAy8EeZ2Pq7m+9rbjvVcBGRvZEnGzsHIP3/CDzUQ==
X-Google-Smtp-Source: ABdhPJw1xiHvxvKZB1SEt+sOCQGr0Dt7pF3pl7FeojUfoj8x7Ugg9sps1kdQdQF+DJgKcOFNqUCjtI6c/IwnqVP/YTo=
X-Received: by 2002:a17:90b:1885:: with SMTP id mn5mr6520504pjb.24.1621538473309;
 Thu, 20 May 2021 12:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210513234309.366727-1-almasrymina@google.com>
 <CAHS8izNkBvS9gkSjy8FbWBOPDynwr8PXXXbMHt_2=5sZJsa6-Q@mail.gmail.com>
 <09dc0712-48e8-8ba2-f170-4c2febcfff83@oracle.com> <CAHS8izN3+DwCMnVotW7UoiROKEpBh=i+n2jb+oMJQwbKeegx7Q@mail.gmail.com>
In-Reply-To: <CAHS8izN3+DwCMnVotW7UoiROKEpBh=i+n2jb+oMJQwbKeegx7Q@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 20 May 2021 12:21:02 -0700
Message-ID: <CAHS8izNECN6U4KDLS-jrtni6WMszK6rF1XjcWwwGAByb3pEr8A@mail.gmail.com>
Subject: Re: [PATCH] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 12:18 PM Mina Almasry <almasrymina@google.com> wrote:
>
> On Thu, May 13, 2021 at 5:14 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 5/13/21 4:49 PM, Mina Almasry wrote:
> > > On Thu, May 13, 2021 at 4:43 PM Mina Almasry <almasrymina@google.com> wrote:
> > >>
> > >> When hugetlb_mcopy_atomic_pte() is called with:
> > >> - mode==MCOPY_ATOMIC_NORMAL and,
> > >> - we already have a page in the page cache corresponding to the
> > >> associated address,
> > >>
> > >> We will allocate a huge page from the reserves, and then fail to insert it
> > >> into the cache and return -EEXIST. In this case, we need to return -EEXIST
> > >> without allocating a new page as the page already exists in the cache.
> > >> Allocating the extra page causes the resv_huge_pages to underflow temporarily
> > >> until the extra page is freed.
> > >>
> > >> To fix this we check if a page exists in the cache, and allocate it and
> > >> insert it in the cache immediately while holding the lock. After that we
> > >> copy the contents into the page.
> > >>
> > >> As a side effect of this, pages may exist in the cache for which the
> > >> copy failed and for these pages PageUptodate(page) == false. Modify code
> > >> that query the cache to handle this correctly.
> > >>
> > >
> > > To be honest, I'm not sure I've done this bit correctly. Please take a
> > > look and let me know what you think. It may be too overly complicated
> > > to have !PageUptodate() pages in the cache and ask the rest of the
> > > code to handle that edge case correctly, but I'm not sure how else to
> > > fix this issue.
> > >
> >
> > I think you just moved the underflow from hugetlb_mcopy_atomic_pte to
> > hugetlb_no_page.  Why?
> >
> > Consider the case where there is only one reserve left and someone does
> > the MCOPY_ATOMIC_NORMAL for the address.  We will allocate the page and
> > consume the reserve (reserve count == 0) and insert the page into the
> > cache.  Now, if the copy_huge_page_from_user fails we must drop the
> > locks/fault mutex to do the copy.  While locks are dropped, someone
> > faults on the address and ends up in hugetlb_no_page.  The page is in
> > the cache but not up to date, so we go down the allocate new page path
> > and will decrement the reserve count again to cause underflow.
> >
> > How about this approach?
> > - Keep the check for hugetlbfs_pagecache_present in hugetlb_mcopy_atomic_pte
> >   that you added.  That will catch the race where the page was added to
> >   the cache before entering the routine.
> > - With the above check in place, we only need to worry about the case
> >   where copy_huge_page_from_user fails and we must drop locks.  In this
> >   case we:
> >   - Free the page previously allocated.
> >   - Allocate a 'temporary' huge page without consuming reserves.  I'm
> >     thinking of something similar to page migration.
> >   - Drop the locks and let the copy_huge_page_from_user be done to the
> >     temporary page.
> >   - When reentering hugetlb_mcopy_atomic_pte after dropping locks (the
> >     *pagep case) we need to once again check
> >     hugetlbfs_pagecache_present.
> >   - We then try to allocate the huge page which will consume the
> >     reserve.  If successful, copy contents of temporary page to newly
> >     allocated page.  Free temporary page.
> >
> > There may be issues with this, and I have not given it deep thought.  It
> > does abuse the temporary huge page concept, but perhaps no more than
> > page migration.  Things do slow down if the extra page allocation and
> > copy is required, but that would only be the case if copy_huge_page_from_user
> > needs to be done without locks.  Not sure, but hoping that is rare.
>
> Just following up this a bit: I've implemented this approach locally,
> and with it it's passing the test as-is. When I hack the code such
> that the copy in hugetlb_mcopy_atomic_pte() always fails, I run into
> this edge case, which causes resv_huge_pages to underflow again (this
> time permemantly):
>
> - hugetlb_no_page() is called on an index and a page is allocated and
> inserted into the cache consuming the reservation.
> - remove_huge_page() is called on this index and the page is removed from cache.
> - hugetlb_mcopy_atomic_pte() is called on this index, we do not find
> the page in the cache and we trigger this code patch and the copy
> fails.
> - The allocations in this code path seem to double consume the
> reservation and resv_huge_pages underflows.
>
> I'm looking at this edge case to understand why a prior
> remove_huge_page() causes my code to underflow resv_huge_pages.
>

I should also mention, without a prior remove_huge_page() this code
path works fine, so it seems the fact that the reservation is consumed
before causes trouble, but I'm not sure why yet.

> > --
> > Mike Kravetz
