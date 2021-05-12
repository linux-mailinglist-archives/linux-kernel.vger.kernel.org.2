Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C1637B709
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhELHqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhELHqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:46:16 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29882C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 00:45:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b13-20020a17090a8c8db029015cd97baea9so1059246pjo.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 00:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtvdMrkUbTnK66R9+ui61gQOXaiSAm2MDifZQfuXMEA=;
        b=Ghui20jCJRybOfpM0mXz6U9UgcW2lkC5vDJKETWh2HZuuJ7qnjwtoV9TV73YbkBzHf
         lL0KQIkqYfgwdNF+XfP6DHeXf7C9NjzUcLPOAV0sIwnBBLUHLZ+WoKyqzCmcX77l/N7i
         XFRp6KDhcBmEMSdx8EWwYs9GV3ppz7b+JGC5kVKIzpr9vXEc2RaJB4Vo2qNktxMlb8Q6
         FWWCdNWFjO3WCqjqRWYokNE1WfgtomeeBDbvR2BCHmTHQKlZB68tW+FSO/q02A+IWREu
         DgoauqqLm1LM3sEsMpDIaOCP51HlInYgLy8tVZscOvSBZ3uMbj9hwG41HC8Bqn+ONkJD
         uErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtvdMrkUbTnK66R9+ui61gQOXaiSAm2MDifZQfuXMEA=;
        b=P6ZtvNnFd7sl9jMIL9e41tEL4r4TTcEmvZmWvsk6DMNJuiGPNaAhUDQfYIfgdEsCEn
         epSxyIPytxKNd1mifzsV7fBJJW7IW9w1v3KAf4peJQAxiLREcTql6bo1fYYwN5u5sc48
         qw4l1H+6Y7K6tPSdufabill3hPKxJ7K17klsNlDTcWcfR7H4lQ503gpTBSrwzx3Y05F3
         y6pOdMV7fJtlpJ7XQBXqdlWfARCvSOFgLKom2HpaLj0/D1ReJKegUqnig/n5ZmF5qSlX
         wjr4BQE6Fj2vQb9BokjxVHVhzUTlimztBgWn6+N4eEtfpN4YS7LFnc/9PqUwhKwvpC4+
         R0cg==
X-Gm-Message-State: AOAM530GG0ET79b/4NFmeyFDDFiHVz9HFlkMyl4rAj4YKJzoLtkJLxDL
        ROO/EZttGuFZUBQS5HMGb3WxWk5Tt0IaY0LFeWNEUAa6Cjs=
X-Google-Smtp-Source: ABdhPJzIRuma7toXotpPxHLNyDtJU0KEDLYsuq3GkR3RGgIYm+jdCZky96AE9F2jO3wRD2MHIEYkGmHQjYf7ydtxoag=
X-Received: by 2002:a17:902:7c85:b029:ed:893d:ec7c with SMTP id
 y5-20020a1709027c85b02900ed893dec7cmr33237150pll.82.1620805508451; Wed, 12
 May 2021 00:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <e134d74d-c218-a01d-a315-82b909c84051@oracle.com> <20210512065813.89270-1-almasrymina@google.com>
In-Reply-To: <20210512065813.89270-1-almasrymina@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 12 May 2021 00:44:57 -0700
Message-ID: <CAHS8izODzgEOCrorUmNjQZzOgAM3Kbv=DPbVpoDyrk0iKtRYMQ@mail.gmail.com>
Subject: Re: [PATCH] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 11:58 PM Mina Almasry <almasrymina@google.com> wrote:
>
> When hugetlb_mcopy_atomic_pte() is called with:
> - mode==MCOPY_ATOMIC_NORMAL and,
> - we already have a page in the page cache corresponding to the
> associated address,
>
> We will allocate a huge page from the reserves, and then fail to insert it
> into the cache and return -EEXIST.
>
> In this case, we need to return -EEXIST without allocating a new page as
> the page already exists in the cache. Allocating the extra page causes
> the resv_huge_pages to underflow temporarily until the extra page is
> freed.
>
> Also, add the warning so that future similar instances of resv_huge_pages
> underflowing will be caught.
>
> Also, minor drive-by cleanups to this code path:
> - pagep is an out param never set by calling code, so delete code
> assuming there could be a valid page in there.
> - use hugetlbfs_pagecache_page() instead of repeating its
> implementation.
>
> Tested using:
> ./tools/testing/selftests/vm/userfaultfd hugetlb_shared 1024 200 \
> /mnt/huge
>
> Test passes, and dmesg shows no underflow warnings.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Peter Xu <peterx@redhat.com>
>
> ---
>  mm/hugetlb.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 629aa4c2259c..40f4ad1bca29 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1165,6 +1165,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
>         page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
>         if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
>                 SetHPageRestoreReserve(page);
> +               WARN_ON_ONCE(!h->resv_huge_pages);
>                 h->resv_huge_pages--;
>         }
>
> @@ -4868,30 +4869,39 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>                             struct page **pagep)
>  {
>         bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
> -       struct address_space *mapping;
> -       pgoff_t idx;
> +       struct hstate *h = hstate_vma(dst_vma);
> +       struct address_space *mapping = dst_vma->vm_file->f_mapping;
> +       pgoff_t idx = vma_hugecache_offset(h, dst_vma, dst_addr);
>         unsigned long size;
>         int vm_shared = dst_vma->vm_flags & VM_SHARED;
> -       struct hstate *h = hstate_vma(dst_vma);
>         pte_t _dst_pte;
>         spinlock_t *ptl;
> -       int ret;
> +       int ret = -ENOMEM;
>         struct page *page;
>         int writable;
>
> -       mapping = dst_vma->vm_file->f_mapping;
> -       idx = vma_hugecache_offset(h, dst_vma, dst_addr);
> +       /* Out parameter. */
> +       WARN_ON(*pagep);
>
>         if (is_continue) {
>                 ret = -EFAULT;
> -               page = find_lock_page(mapping, idx);
> +               page = hugetlbfs_pagecache_page(h, dst_vma, dst_addr);
>                 if (!page)
>                         goto out;
> -       } else if (!*pagep) {
> -               ret = -ENOMEM;
> +       } else {
> +               /* If a page already exists, then it's UFFDIO_COPY for
> +                * a non-missing case. Return -EEXIST.
> +                */
> +               if (hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
> +                       ret = -EEXIST;
> +                       goto out;
> +               }
> +
>                 page = alloc_huge_page(dst_vma, dst_addr, 0);
> -               if (IS_ERR(page))
> +               if (IS_ERR(page)) {
> +                       ret = -ENOMEM;
>                         goto out;
> +               }
>
>                 ret = copy_huge_page_from_user(page,
>                                                 (const void __user *) src_addr,
> @@ -4904,9 +4914,6 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>                         /* don't free the page */
>                         goto out;
>                 }
> -       } else {
> -               page = *pagep;
> -               *pagep = NULL;
>         }
>
>         /*
> --
> 2.31.1.607.g51e8a6a459-goog

I just realized I missed CCing Andrew and the mailing lists to this
patch's review. I'll collect review comments from folks and send a v2
to the correct folks and mailing lists.
