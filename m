Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0B538B73B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbhETTUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbhETTUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:20:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F8EC061343
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:18:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x18so8804279pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IbDNLG0jf9xOveSRgWid326dIGGUMcgFP2QxrRiUBDk=;
        b=OaPenAgnZ75QKdCdKloLhNQb8Z9zXb5fJlf0AMLUNKyh2IQyG6fOH8SGnMsDGhQR/D
         Z9GPJJDcyauRgwCRYOZRPKS278ksdR/VyE8apmokWZ2PCalyDyI3xXG8oHMZaYvZRzzz
         w3CkorenoyU81j9m4YTf76wBV5NYQ99BmlPqD7bL9EMsML4WjHcPR1CUPHX/0KyYbhA7
         OoaaLPq6Mi0sOhY75JsC1sO405LIeswBGhCQ5djqy1IrPLVPwvRRKaSvWhS0ksDy/dQr
         Kt8Fdu/GK4aWb1xBVzywxIGiWrxK0sJEFOfU0h0kj8rr060s1oQW3NL4Gel3uBSfa8CU
         7dBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IbDNLG0jf9xOveSRgWid326dIGGUMcgFP2QxrRiUBDk=;
        b=Ei0FoUepeSYJuff8echkxgDW4ZLRmROmglKy5lWmJ25YTQFZT/0/FtBrUmyRCJt3Ks
         RcuHPNa44SafyHdrWPHzd6sRQ6kLMbloc5WZVBGPK+ORiz3MY/quMn1X5JInODu2gWSG
         zv+7+3F2/FR6CGcGgTbTNF1SURASLfvLf+5N521u1kTA58fqe7jRFv50L0M+fjZdxvFS
         v+uJzCUQPdQ/lgj5m8DW3SZK1QNlL4QsIxyDNuNkbWYw766JpaYvTjeanRnKj9IQs9xD
         7nhviX0NqnAMD4bXlgglx4QMgg0GtSAZVitgI2mVOC8mivAYiBkSe/Rbnr+tQh2qXDtc
         06vg==
X-Gm-Message-State: AOAM531D3D1nVxfOB9PjJVym0eL9FLsAq/3RPodlUvHat9L2vjHUbKKY
        a3A1IA8QgR4+m22YWh9sghAYpg2G0BtKbm5FJaNpaw==
X-Google-Smtp-Source: ABdhPJx0izHau/v0BeugY1T+uAckk0gggIKe/29kNNx6qL1yZBDyGN2pLdLwJC0lLKZqaHBfgv69XBzvHeRM5/9yCDU=
X-Received: by 2002:a63:5511:: with SMTP id j17mr6130803pgb.191.1621538315098;
 Thu, 20 May 2021 12:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210513234309.366727-1-almasrymina@google.com>
 <CAHS8izNkBvS9gkSjy8FbWBOPDynwr8PXXXbMHt_2=5sZJsa6-Q@mail.gmail.com> <09dc0712-48e8-8ba2-f170-4c2febcfff83@oracle.com>
In-Reply-To: <09dc0712-48e8-8ba2-f170-4c2febcfff83@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 20 May 2021 12:18:24 -0700
Message-ID: <CAHS8izN3+DwCMnVotW7UoiROKEpBh=i+n2jb+oMJQwbKeegx7Q@mail.gmail.com>
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

On Thu, May 13, 2021 at 5:14 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 5/13/21 4:49 PM, Mina Almasry wrote:
> > On Thu, May 13, 2021 at 4:43 PM Mina Almasry <almasrymina@google.com> wrote:
> >>
> >> When hugetlb_mcopy_atomic_pte() is called with:
> >> - mode==MCOPY_ATOMIC_NORMAL and,
> >> - we already have a page in the page cache corresponding to the
> >> associated address,
> >>
> >> We will allocate a huge page from the reserves, and then fail to insert it
> >> into the cache and return -EEXIST. In this case, we need to return -EEXIST
> >> without allocating a new page as the page already exists in the cache.
> >> Allocating the extra page causes the resv_huge_pages to underflow temporarily
> >> until the extra page is freed.
> >>
> >> To fix this we check if a page exists in the cache, and allocate it and
> >> insert it in the cache immediately while holding the lock. After that we
> >> copy the contents into the page.
> >>
> >> As a side effect of this, pages may exist in the cache for which the
> >> copy failed and for these pages PageUptodate(page) == false. Modify code
> >> that query the cache to handle this correctly.
> >>
> >
> > To be honest, I'm not sure I've done this bit correctly. Please take a
> > look and let me know what you think. It may be too overly complicated
> > to have !PageUptodate() pages in the cache and ask the rest of the
> > code to handle that edge case correctly, but I'm not sure how else to
> > fix this issue.
> >
>
> I think you just moved the underflow from hugetlb_mcopy_atomic_pte to
> hugetlb_no_page.  Why?
>
> Consider the case where there is only one reserve left and someone does
> the MCOPY_ATOMIC_NORMAL for the address.  We will allocate the page and
> consume the reserve (reserve count == 0) and insert the page into the
> cache.  Now, if the copy_huge_page_from_user fails we must drop the
> locks/fault mutex to do the copy.  While locks are dropped, someone
> faults on the address and ends up in hugetlb_no_page.  The page is in
> the cache but not up to date, so we go down the allocate new page path
> and will decrement the reserve count again to cause underflow.
>
> How about this approach?
> - Keep the check for hugetlbfs_pagecache_present in hugetlb_mcopy_atomic_pte
>   that you added.  That will catch the race where the page was added to
>   the cache before entering the routine.
> - With the above check in place, we only need to worry about the case
>   where copy_huge_page_from_user fails and we must drop locks.  In this
>   case we:
>   - Free the page previously allocated.
>   - Allocate a 'temporary' huge page without consuming reserves.  I'm
>     thinking of something similar to page migration.
>   - Drop the locks and let the copy_huge_page_from_user be done to the
>     temporary page.
>   - When reentering hugetlb_mcopy_atomic_pte after dropping locks (the
>     *pagep case) we need to once again check
>     hugetlbfs_pagecache_present.
>   - We then try to allocate the huge page which will consume the
>     reserve.  If successful, copy contents of temporary page to newly
>     allocated page.  Free temporary page.
>
> There may be issues with this, and I have not given it deep thought.  It
> does abuse the temporary huge page concept, but perhaps no more than
> page migration.  Things do slow down if the extra page allocation and
> copy is required, but that would only be the case if copy_huge_page_from_user
> needs to be done without locks.  Not sure, but hoping that is rare.

Just following up this a bit: I've implemented this approach locally,
and with it it's passing the test as-is. When I hack the code such
that the copy in hugetlb_mcopy_atomic_pte() always fails, I run into
this edge case, which causes resv_huge_pages to underflow again (this
time permemantly):

- hugetlb_no_page() is called on an index and a page is allocated and
inserted into the cache consuming the reservation.
- remove_huge_page() is called on this index and the page is removed from cache.
- hugetlb_mcopy_atomic_pte() is called on this index, we do not find
the page in the cache and we trigger this code patch and the copy
fails.
- The allocations in this code path seem to double consume the
reservation and resv_huge_pages underflows.

I'm looking at this edge case to understand why a prior
remove_huge_page() causes my code to underflow resv_huge_pages.

> --
> Mike Kravetz
