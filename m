Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D50138011F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 02:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhENAYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 20:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhENAYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 20:24:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEB9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 17:23:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b13-20020a17090a8c8db029015cd97baea9so423391pjo.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 17:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7M2VJY6FHhWqAc/4PJbGV/SNxyzRDLt47x/Is56SyL4=;
        b=XhJvN3eSjiyhi0yCEz6Xj5p90iLOnBn/5RpHpJ0zfBxTJuhFQzRL7XaOCuMMAYfL91
         WoZG2cykWuKvpk6+yeZAwZt7oacaJowgzOvJl+080CjKnZPHsSDd3LHXjVAYVJr4UFpC
         GNrbQuh2i5OBTc75+gtXVbNve+FI/hJf6TVtWK11jYXeeGwc7fIf5swJgu8eAZqH0G0X
         L9VUVBCRSCnkm6Ay2su/nspuyR7Nmb3FoVForYKr8b3BXqDVlraqpwW66uF/mzs7lt9/
         Um9JhacH0rqqJVcsYt6H6fa15DjKU5OveK/cq5xA9Eu6SAiK5LDpfKuGr9uEb8lFA582
         61UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7M2VJY6FHhWqAc/4PJbGV/SNxyzRDLt47x/Is56SyL4=;
        b=JeI0nxbTIKIHsDRgG+wZ97znLI1dwKU9W3dFGf2S8BSZ8U8hzL6QB7JJ1e7DClwZhA
         fWtJR32d3ll4QbImmdHx5hRBKZygR7CHJE09F2/guCpLAsYq2YjibbQ4SmTp6n7snsC4
         fbABLrLWrHaefDC2Ivq1KXbd/gR6TJS5b1kgqVKghTSSw77u/xGPk9OB4A0qQZ2bD0EU
         +AxvLzHvVAoSADdoNDumwOgyQkLekIJsnCs0+gS80Mi9Dtef4kOj0NwI+P22x3JGIFjl
         ZsSKsVByFPvsAPGwLJiWOsl00U4lGrTV+Zt75i3+F461tIPRpPT5nBZ1gxOENtefW+JR
         BCNg==
X-Gm-Message-State: AOAM533ROYHkq3Fh0N5uprjco59S3U0GpXeNTHbeYGnKxHx00OYEeXp+
        8MELUbe9ju+a0DDWO+AcxvKGe9bhCPYvwwaEc1ec7g==
X-Google-Smtp-Source: ABdhPJwKuahZZpjrKaQ2vgQa72PIVHwa5eGmj3dhgowAYvPUNkxcDhSgLpKbduNC/8zh8cJxC3tykC3O1rP/ACwVRMY=
X-Received: by 2002:a17:902:7c85:b029:ed:893d:ec7c with SMTP id
 y5-20020a1709027c85b02900ed893dec7cmr42018311pll.82.1620951791846; Thu, 13
 May 2021 17:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210513234309.366727-1-almasrymina@google.com>
 <CAHS8izNkBvS9gkSjy8FbWBOPDynwr8PXXXbMHt_2=5sZJsa6-Q@mail.gmail.com> <09dc0712-48e8-8ba2-f170-4c2febcfff83@oracle.com>
In-Reply-To: <09dc0712-48e8-8ba2-f170-4c2febcfff83@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 13 May 2021 17:23:00 -0700
Message-ID: <CAHS8izPFc+bSrKN-6gRguGefAqrj6kXaMUvgeUL5U7QxhXfWDw@mail.gmail.com>
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

For what it's worth, I think I fixed the underflow with this patch,
not moved it. I added a check in hugetlb_no_page() such that if we
find a page in the cache with !PageUptodate(page), we will reuse that
page instead of allocating a new one and decrementing the count again.
Running the test with the WARN_ONCE_ON locally shows no warnings
again.

> How about this approach?

I'll give it a shot for sure. FWIW on first glance it looks more
complicated that what I have here, but my guess I'm not doing the
!PageUptodate() handling correctly and that's why it seems this
solution is simpler. I'll give it a shot though.

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
> --
> Mike Kravetz
