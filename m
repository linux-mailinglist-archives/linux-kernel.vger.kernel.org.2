Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E4C38BC44
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbhEUCHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhEUCH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:07:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66841C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:06:03 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 69so10150884plc.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pHsoSdXDoBgVt5ifSJzNWOLZxLWzbSBEL6tWMupQiKE=;
        b=Yx011/9eFDb5C4Y3NgsxdifLXakfccVGr5EY0Eny6o4tzN9mIIU6dWpbwPPhG0F1bc
         EyTGPJ+DiQu3fnzwSL+SlgnZ4HsNfKDSZ4DJbtR98SZNSnNUoRxBaUR6wsFgVuig+S1p
         LePxOXVqFTyMNs/wn0J6wO1LP2oKXrEw6I4oNRgdWCL66cskP5mVmimjSGd9BTwXR1gH
         boA4lB7iKRrVRYqi9+W+iFXmFMKpI6iwY4TS5CU6uu1fmkQ0P1RIutyhdOBizFZCAjRP
         7TaE/C98RKV0P7DO2lou6j0HaJOe2z8eVQc1MTz5JM3l4yTfkEE2qcXeEbuf7rlHv0fj
         HLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pHsoSdXDoBgVt5ifSJzNWOLZxLWzbSBEL6tWMupQiKE=;
        b=LqlWP3CA6f0iCxu+Bi6hy+/7UEWfZus1W8um3UqEOSdZwtbMmpGhEjTEOxZpRBdxZ9
         RHdUlwcYmi9Kwo9MhmfzUOh/PnpA7CQRlZePtVCAMBHdmZ7/Q1iYMaD9aYAntrXg1P5v
         gnVuhP6BeIkSgIQtQ+p6LkwoBCB3EoTY0jA4VcEliZsLfUukVgHAqAO0tDlTXrmxkdZv
         8qiZBNgC8/xBZYB1oJdinWS68IUDkC5aDt/6ZJg2bnXk+Xd5TagFES+CVtHsSaVdMDsA
         GvWe135JlAk2wQ6cO6/DQV4PHfxh3AUjRkC/HxAxkQf9xJFrcQQcDHglJeZ2e7xFC1NF
         9D4w==
X-Gm-Message-State: AOAM532wN+MVSwD87reH5Zm8aFEM0sZsxwltauxPRjWK3CIxg9WGObay
        +ZWLgWT3nLTGymWWEVFRy1jgELSbLst7O8rtFbYmvw==
X-Google-Smtp-Source: ABdhPJwWV7tQAt4/AAohsYPwYwLS23El1UDsc3ooDjQM/g07Vm6EmVq9NMt2Wm/IQZwWumNEgRpDgoiNEabzJeWUULA=
X-Received: by 2002:a17:90a:1a:: with SMTP id 26mr8200181pja.187.1621562762563;
 Thu, 20 May 2021 19:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210513234309.366727-1-almasrymina@google.com>
 <CAHS8izNkBvS9gkSjy8FbWBOPDynwr8PXXXbMHt_2=5sZJsa6-Q@mail.gmail.com>
 <09dc0712-48e8-8ba2-f170-4c2febcfff83@oracle.com> <CAHS8izN3+DwCMnVotW7UoiROKEpBh=i+n2jb+oMJQwbKeegx7Q@mail.gmail.com>
 <CAHS8izNECN6U4KDLS-jrtni6WMszK6rF1XjcWwwGAByb3pEr8A@mail.gmail.com>
 <61c78897-27a2-768b-f4fe-04e24b617ab6@oracle.com> <CAHS8izOHs0ZYR-0FCsDS6nxYbnNfYJFzWKGwB_utBJ_9bswjkA@mail.gmail.com>
In-Reply-To: <CAHS8izOHs0ZYR-0FCsDS6nxYbnNfYJFzWKGwB_utBJ_9bswjkA@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 20 May 2021 19:05:51 -0700
Message-ID: <CAHS8izNhJRvAAWOBWG0E5hTOkLC4xSmsesnNYgZ+Feg+ZUzANg@mail.gmail.com>
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

On Thu, May 20, 2021 at 1:31 PM Mina Almasry <almasrymina@google.com> wrote:
>
> On Thu, May 20, 2021 at 1:00 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 5/20/21 12:21 PM, Mina Almasry wrote:
> > > On Thu, May 20, 2021 at 12:18 PM Mina Almasry <almasrymina@google.com> wrote:
> > >>
> > >> On Thu, May 13, 2021 at 5:14 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > >>>
> > >>> How about this approach?
> > >>> - Keep the check for hugetlbfs_pagecache_present in hugetlb_mcopy_atomic_pte
> > >>>   that you added.  That will catch the race where the page was added to
> > >>>   the cache before entering the routine.
> > >>> - With the above check in place, we only need to worry about the case
> > >>>   where copy_huge_page_from_user fails and we must drop locks.  In this
> > >>>   case we:
> > >>>   - Free the page previously allocated.
> > >>>   - Allocate a 'temporary' huge page without consuming reserves.  I'm
> > >>>     thinking of something similar to page migration.
> > >>>   - Drop the locks and let the copy_huge_page_from_user be done to the
> > >>>     temporary page.
> > >>>   - When reentering hugetlb_mcopy_atomic_pte after dropping locks (the
> > >>>     *pagep case) we need to once again check
> > >>>     hugetlbfs_pagecache_present.
> > >>>   - We then try to allocate the huge page which will consume the
> > >>>     reserve.  If successful, copy contents of temporary page to newly
> > >>>     allocated page.  Free temporary page.
> > >>>
> > >>> There may be issues with this, and I have not given it deep thought.  It
> > >>> does abuse the temporary huge page concept, but perhaps no more than
> > >>> page migration.  Things do slow down if the extra page allocation and
> > >>> copy is required, but that would only be the case if copy_huge_page_from_user
> > >>> needs to be done without locks.  Not sure, but hoping that is rare.
> > >>
> > >> Just following up this a bit: I've implemented this approach locally,
> > >> and with it it's passing the test as-is. When I hack the code such
> > >> that the copy in hugetlb_mcopy_atomic_pte() always fails, I run into
> > >> this edge case, which causes resv_huge_pages to underflow again (this
> > >> time permemantly):
> > >>
> > >> - hugetlb_no_page() is called on an index and a page is allocated and
> > >> inserted into the cache consuming the reservation.
> > >> - remove_huge_page() is called on this index and the page is removed from cache.
> > >> - hugetlb_mcopy_atomic_pte() is called on this index, we do not find
> > >> the page in the cache and we trigger this code patch and the copy
> > >> fails.
> > >> - The allocations in this code path seem to double consume the
> > >> reservation and resv_huge_pages underflows.
> > >>
> > >> I'm looking at this edge case to understand why a prior
> > >> remove_huge_page() causes my code to underflow resv_huge_pages.
> > >>
> > >
> > > I should also mention, without a prior remove_huge_page() this code
> > > path works fine, so it seems the fact that the reservation is consumed
> > > before causes trouble, but I'm not sure why yet.
> > >
> >
> > Hi Mina,
> >
> > How about quickly posting the code?  I may be able to provide more
> > suggestions if I can see the actual code.
>
> Sure thing, attached my patch so far. It's quite messy with prints
> everywhere and VM_BUG_ON() in error paths that I'm not handling yet.
> I've also hacked the code so that the hugetlb_mcopy_atomic_pte() copy
> always fails so I exercise that code path.
>

Of course right after I send out my patch, I figure out what's wrong.
It turns out freeing the allocated page when the copy fails is
extremely complicated (or complicated to figure out why it's broken).
Turns out I need to:

restore_page_on_error()
if (!HPageRestoreReserves(page)) {
    hugetlb_unreserve_pages(mapping, idx, idx + 1, 1);
}
put_page(page);

This is because even though we always allocate asking for a page from
the reserves, the page may not come from the reserves if the VM
doesn't have reservation for this index (which is the case if the page
has been allocated by hugetlb_no_page() and then removed with
remove_huge_page()). So, we need to correctly handle both cases.

Sorry for the noise but this was hard to track down. Patch should be
incoming soon unless I run into other issues with a closer look.

> > --
> > Mike Kravetz
