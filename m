Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2323BF167
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 23:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhGGV3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 17:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhGGV3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 17:29:30 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE8CC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 14:26:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id l24so5290697edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 14:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5yuPn7bjyzZ0FHn2GkilfPCZhHanR6XcSlMUG83h9I=;
        b=QUIveI2p1y7h+sAn0j62P3Mdoa7rUpgwg0tx/L7fmh0k1BebfugcI+3e3pilJ03QnQ
         ziJB1UYK+Ig3kNejFe7Mg0ztrn8VjMRhxCmejEp+LRSy1PViVjShyvqCdPGQNSEmcOd5
         FvISft4acfszDveneptbTK96ovLs8VjJKgy1/mHYgJd7wDfxl04U5dNcIhatj0A6Dc22
         1eE44wWJho+1czHxoWsLAmxRylIK+LbIDLvsSmm5APuAkwjf/P7042H+2VlZ7/ESZJiY
         63DKMEeAfKkUGhRbbJdGSOkQHvZxTp/6AAQ2l2afgX4xAEfliiQ8no1xtyYC7dGBJfFY
         RuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5yuPn7bjyzZ0FHn2GkilfPCZhHanR6XcSlMUG83h9I=;
        b=jNC+8l3h9K9rx4wVKAPm6mAm6oxHb4ahlF+kVNUFWN1iwbSK+LmUSK4O2Rv4ECfY2c
         Uahob4nAvFSwHmwLeN73dthpT/+MCAC3GIiRqFL8n04EpCGBM1A4C3J8q4q3ZMvamASp
         fg8Oceh7e7W56pfi4aqDOs9YyfG1RG/+Fe3wh6Z2KaBhgjuEGzTUiizni/YIz+GPq2T9
         pqEjPkuPSYFyei1//QxrD1Dw7LF9Shs2zmGR6yAaf/Y6oMnILE62r2Ia6aqUHtzxrWjf
         Grwiu8lGAnFrGdj3GFSX41tsz7vZgxsrS5ImUTeFGlHfwjWHNKIsiDJvMdUbevbnwGG2
         ondw==
X-Gm-Message-State: AOAM531cBgYBNcuIPFO9iPWYm5On1JBWxuoDj7hEUBRaZjYSNy39FXxm
        i5yu6aNQSfdFrmGQQCqXWVYBv+/afNS2+PPt+r8=
X-Google-Smtp-Source: ABdhPJyLvPHMlKTmjU+EYvKxuQDmxiR7Lep0nFMVKU3sFZG5gywIAHf+hHgQXJpt0biOQA5ryOqCpAA0mkLAh4MCcvI=
X-Received: by 2002:a50:cdcb:: with SMTP id h11mr33350232edj.366.1625693207943;
 Wed, 07 Jul 2021 14:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com>
In-Reply-To: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 7 Jul 2021 14:26:36 -0700
Message-ID: <CAHbLzkpRfJOssBaNpch1OjJbgLc-BbSa+N9Ntay2NixNiQb0pg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/rmap: fix comments left over from recent changes
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 1:06 PM Hugh Dickins <hughd@google.com> wrote:
>
> Parallel developments in mm/rmap.c have left behind some out-of-date
> comments: try_to_migrate_one() also accepts TTU_SYNC (already commented
> in try_to_migrate() itself), and try_to_migrate() returns nothing at all.
>
> TTU_SPLIT_FREEZE has just been deleted, so reword the comment about it in
> mm/huge_memory.c; and TTU_IGNORE_ACCESS was removed in 5.11, so delete

I just realized this. Currently unmap_page() just unmaps file pages
when splitting THP. But it seems this may cause some trouble for page
cache speculative get for the below case IIUC. Am I missing something?

    CPU A                  CPU B
unmap_page()
...
freeze refcount
                              find_get_page() ->
                                  __page_cache_add_speculative() ->
                                      VM_BUG_ON_PAGE(page_count(page)
== 0, page); //When CONFIG_TINY_RCU is enabled


The race is acceptable, I think we could replace the VM_BUG_ON to
page_ref_add_unless(), just like !CONFIG_TINY_RCU case.


> the "recently referenced" comment from try_to_unmap_one() (once upon a
> time the comment was near the removed codeblock, but they drifted apart).
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/huge_memory.c | 2 +-
>  mm/rmap.c        | 7 +------
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 8b731d53e9f4..afff3ac87067 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2331,7 +2331,7 @@ static void remap_page(struct page *page, unsigned int nr)
>  {
>         int i;
>
> -       /* If TTU_SPLIT_FREEZE is ever extended to file, remove this check */
> +       /* If unmap_page() uses try_to_migrate() on file, remove this check */
>         if (!PageAnon(page))
>                 return;
>         if (PageTransHuge(page)) {
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 37c24672125c..746013e282c3 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1439,8 +1439,6 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>         while (page_vma_mapped_walk(&pvmw)) {
>                 /*
>                  * If the page is mlock()d, we cannot swap it out.
> -                * If it's recently referenced (perhaps page_referenced
> -                * skipped over this mm) then we should reactivate it.
>                  */
>                 if (!(flags & TTU_IGNORE_MLOCK)) {
>                         if (vma->vm_flags & VM_LOCKED) {
> @@ -1687,8 +1685,7 @@ void try_to_unmap(struct page *page, enum ttu_flags flags)
>   * @arg: enum ttu_flags will be passed to this argument.
>   *
>   * If TTU_SPLIT_HUGE_PMD is specified any PMD mappings will be split into PTEs
> - * containing migration entries. This and TTU_RMAP_LOCKED are the only supported
> - * flags.
> + * containing migration entries.
>   */
>  static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>                      unsigned long address, void *arg)
> @@ -1928,8 +1925,6 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>   *
>   * Tries to remove all the page table entries which are mapping this page and
>   * replace them with special swap entries. Caller must hold the page lock.
> - *
> - * If is successful, return true. Otherwise, false.
>   */
>  void try_to_migrate(struct page *page, enum ttu_flags flags)
>  {
> --
> 2.26.2
>
