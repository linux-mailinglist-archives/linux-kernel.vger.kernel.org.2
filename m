Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D5E3EF3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 22:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbhHQUSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 16:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbhHQUPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EAAC0611FA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 13:14:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h9so45994ejs.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/HLRdHZP/EooGkLUc5zwmnFLeg6WQf/Ziajpiz1uE/U=;
        b=KiZcJ6vUGOj98sXLVwnmPaSKOped8mD5JeVABbC3Ootq6gltSjTWAkErBfwyqPuudJ
         tE4LVd4e9o5xVEr8SkdxSfJEV1s7ORRUI1eleW7T1evKKKWL1sN0KHhF/JBr+1GQu4GI
         VFIT8KD0eZ9pG2PT9zT7shtb0C3i//HqE/ipFNpLDZ814va1CNQ5u28t2H66cSr5D8eE
         aDbsiQJmSo92qiak1hKE1uO9QLWFvQN9ShU/LJx3yM8pxf8pVpmzRge01PMevGRn1TdX
         zwD2C3AFGT8TwvDecG73a8EXw6b5ilLtTTkE8iL0KiigP0Dj0aJZdRHGVm0Y1Acr/eye
         k2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HLRdHZP/EooGkLUc5zwmnFLeg6WQf/Ziajpiz1uE/U=;
        b=l5yXSBqANG9O68BRuU5gHNqgUJ8U9k0lupYTVhbVkD9Y2r54GJLEy9By06fmrgVBkz
         VqZNPXiS2B9jS7uzlA8eXtQ50e4TYt/B2tNenHr0PJvuS0oU0cXYvjQoK/Ue9BKPIdfl
         WakMbRco46lnGCQxhgBWwNJtgEm7rraU57yxG+ubjuf/3QMhPgeVIEMDM1aV7fc37Xjx
         4j9uojziz6N273ndsy19uI3vRXNwElOhVPZDXMQq0tanPmF9GoGDfqz+Ag1RU8rsAUy4
         UYQKCg/te/FaOe1OBPb/1fmBQTE70/5AwTull0y8W3iTEh2RZhoguB8S8LAIiF/6xi/N
         6VOw==
X-Gm-Message-State: AOAM533feAiW17xHS8B6d+FWxmla6k/30jCl2hyv2a6aemRLTG/qyZdU
        8ym9yWIvCG1UWF3qmxKmINSZ3eBaV10U10CvBbU=
X-Google-Smtp-Source: ABdhPJxP4ACqIGCV5q+PFZajjpBxoBCVAmS/PYsWCGjGqtJYEPoLJFDSf/FeHk0cxSK1SvrUMezXqzTdNE8OUe4PPb8=
X-Received: by 2002:a17:906:491a:: with SMTP id b26mr5894152ejq.25.1629231268841;
 Tue, 17 Aug 2021 13:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <da632211-8e3e-6b1-aee-ab24734429a0@google.com> <1355343b-acf-4653-ef79-6aee40214ac5@google.com>
In-Reply-To: <1355343b-acf-4653-ef79-6aee40214ac5@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 17 Aug 2021 13:14:16 -0700
Message-ID: <CAHbLzkp9yUUtn3kKz3re1fNwmtNmP8wUo+-sEiqWXj4ryJd8gg@mail.gmail.com>
Subject: Re: [PATCH 6/9] huge tmpfs: SGP_NOALLOC to stop collapse_file() on race
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 1:17 AM Hugh Dickins <hughd@google.com> wrote:
>
> khugepaged's collapse_file() currently uses SGP_NOHUGE to tell
> shmem_getpage() not to try allocating a huge page, in the very unlikely
> event that a racing hole-punch removes the swapped or fallocated page as
> soon as i_pages lock is dropped.
>
> We want to consolidate shmem's huge decisions, removing SGP_HUGE and
> SGP_NOHUGE; but cannot quite persuade ourselves that it's okay to regress
> the protection in this case - Yang Shi points out that the huge page
> would remain indefinitely, charged to root instead of the intended memcg.
>
> collapse_file() should not even allocate a small page in this case: why
> proceed if someone is punching a hole?  SGP_READ is almost the right flag
> here, except that it optimizes away from a fallocated page, with NULL to
> tell caller to fill with zeroes (like a hole); whereas collapse_file()'s
> sequence relies on using a cache page.  Add SGP_NOALLOC just for this.
>
> There are too many consecutive "if (page"s there in shmem_getpage_gfp():
> group it better; and fix the outdated "bring it back from swap" comment.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  include/linux/shmem_fs.h |  1 +
>  mm/khugepaged.c          |  2 +-
>  mm/shmem.c               | 29 +++++++++++++++++------------
>  3 files changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 9b7f7ac52351..7d97b15a2f7a 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -94,6 +94,7 @@ extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
>  /* Flag allocation requirements to shmem_getpage */
>  enum sgp_type {
>         SGP_READ,       /* don't exceed i_size, don't allocate page */
> +       SGP_NOALLOC,    /* similar, but fail on hole or use fallocated page */
>         SGP_CACHE,      /* don't exceed i_size, may allocate page */
>         SGP_NOHUGE,     /* like SGP_CACHE, but no huge pages */
>         SGP_HUGE,       /* like SGP_CACHE, huge pages preferred */
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b0412be08fa2..045cc579f724 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1721,7 +1721,7 @@ static void collapse_file(struct mm_struct *mm,
>                                 xas_unlock_irq(&xas);
>                                 /* swap in or instantiate fallocated page */
>                                 if (shmem_getpage(mapping->host, index, &page,
> -                                                 SGP_NOHUGE)) {
> +                                                 SGP_NOALLOC)) {
>                                         result = SCAN_FAIL;
>                                         goto xa_unlocked;
>                                 }
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 740d48ef1eb5..226ac3a911e9 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1871,26 +1871,31 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>                 return error;
>         }
>
> -       if (page)
> +       if (page) {
>                 hindex = page->index;
> -       if (page && sgp == SGP_WRITE)
> -               mark_page_accessed(page);
> -
> -       /* fallocated page? */
> -       if (page && !PageUptodate(page)) {
> +               if (sgp == SGP_WRITE)
> +                       mark_page_accessed(page);
> +               if (PageUptodate(page))
> +                       goto out;
> +               /* fallocated page */
>                 if (sgp != SGP_READ)
>                         goto clear;
>                 unlock_page(page);
>                 put_page(page);
> -               page = NULL;
> -               hindex = index;
>         }
> -       if (page || sgp == SGP_READ)
> -               goto out;
>
>         /*
> -        * Fast cache lookup did not find it:
> -        * bring it back from swap or allocate.
> +        * SGP_READ: succeed on hole, with NULL page, letting caller zero.
> +        * SGP_NOALLOC: fail on hole, with NULL page, letting caller fail.
> +        */
> +       *pagep = NULL;
> +       if (sgp == SGP_READ)
> +               return 0;
> +       if (sgp == SGP_NOALLOC)
> +               return -ENOENT;
> +
> +       /*
> +        * Fast cache lookup and swap lookup did not find it: allocate.
>          */
>
>         if (vma && userfaultfd_missing(vma)) {
> --
> 2.26.2
>
