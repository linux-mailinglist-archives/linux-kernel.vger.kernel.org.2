Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF733800FF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 01:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhEMXu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 19:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhEMXu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 19:50:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23B0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 16:49:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso388153pjx.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 16:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=SQ6zgb1j+MlQe0RT2WIWbEbaJo5IPcgCveO2XpCmT/Q=;
        b=JVTHzAgrbcqpqwmMjsQM0gGO8yCvsxBgLaWJyBwsVub1nHSmi6zO0b8KG8aSE7/bcp
         uwbXv7j1s48xEI8ihsRCEbEsEQCSw8gZYJr/HspTxMFWJOGk/eCWS3tJGK6JFj8JFXR7
         ulzPFOXUVwBjgMSuTyKdM/5q/FLYRfLUbPD+5y5aEnK7wVK+4tOa8hh8afvlXyLEfm7G
         KDS2dgLgtgl/om+w7V4zn4p0sRFlgKWpwqGWHfcSnAH1GSJdx1D0gFHBzSYpc+9x4+6d
         SgFntlcSr+AFEE4JdjC0ft1qD1sPs/1uMG9sIlC3n64sGHNQzXAOnS3/1ENUOD0IWe48
         FCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=SQ6zgb1j+MlQe0RT2WIWbEbaJo5IPcgCveO2XpCmT/Q=;
        b=DEGJJZN0gOIzP4U23i6VHruw350tGjveNpV/SYbVIempJOVFhx8HIDK2w3QkLuZPVB
         jU7DFqnFn19ZLYk0Om1shM93f3txOIg6Vp/xhUBQY5wnVTn1kO4nHv2em0t3yUNLX0Gc
         W9+9A5aD0QaPTmeXiaBpf0pKBZeocpAo6Yj476fDx1Q8W5G59AIUFSX1911KVJ8bib9t
         /C8PdUtI2WPp6t/VuTfsRzl7E4ZOiPlLxIUuUo1TqsCmCatpnmkhE1wpOutmELUxjApr
         pdiXUq13IUma6GsjnFjGhJ3KFn0MvSzlOd3p5RN7kJDz/v/ubex+F5HboZvWvkHorrMR
         ouQw==
X-Gm-Message-State: AOAM531NE+A2vc1J5kaXyFTFx6PO8FEvHIWCx+TycwtQ7UugKUWuhoh5
        BBAlh/sxh211kgADl2wvvfVnjGN4JG63smYu9O3POUuxQUs=
X-Received: by 2002:a17:90a:1a:: with SMTP id 26mt5210238pja.187.1620949784838;
 Thu, 13 May 2021 16:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210513234309.366727-1-almasrymina@google.com>
In-Reply-To: <20210513234309.366727-1-almasrymina@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 13 May 2021 16:49:33 -0700
Message-ID: <CAHS8izNkBvS9gkSjy8FbWBOPDynwr8PXXXbMHt_2=5sZJsa6-Q@mail.gmail.com>
Subject: Re: [PATCH] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 4:43 PM Mina Almasry <almasrymina@google.com> wrote:
>
> When hugetlb_mcopy_atomic_pte() is called with:
> - mode==MCOPY_ATOMIC_NORMAL and,
> - we already have a page in the page cache corresponding to the
> associated address,
>
> We will allocate a huge page from the reserves, and then fail to insert it
> into the cache and return -EEXIST. In this case, we need to return -EEXIST
> without allocating a new page as the page already exists in the cache.
> Allocating the extra page causes the resv_huge_pages to underflow temporarily
> until the extra page is freed.
>
> To fix this we check if a page exists in the cache, and allocate it and
> insert it in the cache immediately while holding the lock. After that we
> copy the contents into the page.
>
> As a side effect of this, pages may exist in the cache for which the
> copy failed and for these pages PageUptodate(page) == false. Modify code
> that query the cache to handle this correctly.
>

To be honest, I'm not sure I've done this bit correctly. Please take a
look and let me know what you think. It may be too overly complicated
to have !PageUptodate() pages in the cache and ask the rest of the
code to handle that edge case correctly, but I'm not sure how else to
fix this issue.

> Tested using:
> ./tools/testing/selftests/vm/userfaultfd hugetlb_shared 1024 200 \
> /mnt/huge
>
> Test passes, and dmesg shows no underflow warnings.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
>
> ---
>  fs/hugetlbfs/inode.c |   2 +-
>  mm/hugetlb.c         | 109 +++++++++++++++++++++++--------------------
>  2 files changed, 60 insertions(+), 51 deletions(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index a2a42335e8fd..cc027c335242 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -346,7 +346,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
>
>                 /* Find the page */
>                 page = find_lock_page(mapping, index);
> -               if (unlikely(page == NULL)) {
> +               if (unlikely(page == NULL || !PageUptodate(page))) {
>                         /*
>                          * We have a HOLE, zero out the user-buffer for the
>                          * length of the hole or request.
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 629aa4c2259c..a5a5fbf7ac25 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4543,7 +4543,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>
>  retry:
>         page = find_lock_page(mapping, idx);
> -       if (!page) {
> +       if (!page || !PageUptodate(page)) {
>                 /* Check for page in userfault range */
>                 if (userfaultfd_missing(vma)) {
>                         ret = hugetlb_handle_userfault(vma, mapping, idx,
> @@ -4552,26 +4552,30 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>                         goto out;
>                 }
>
> -               page = alloc_huge_page(vma, haddr, 0);
> -               if (IS_ERR(page)) {
> -                       /*
> -                        * Returning error will result in faulting task being
> -                        * sent SIGBUS.  The hugetlb fault mutex prevents two
> -                        * tasks from racing to fault in the same page which
> -                        * could result in false unable to allocate errors.
> -                        * Page migration does not take the fault mutex, but
> -                        * does a clear then write of pte's under page table
> -                        * lock.  Page fault code could race with migration,
> -                        * notice the clear pte and try to allocate a page
> -                        * here.  Before returning error, get ptl and make
> -                        * sure there really is no pte entry.
> -                        */
> -                       ptl = huge_pte_lock(h, mm, ptep);
> -                       ret = 0;
> -                       if (huge_pte_none(huge_ptep_get(ptep)))
> -                               ret = vmf_error(PTR_ERR(page));
> -                       spin_unlock(ptl);
> -                       goto out;
> +               if (!page) {
> +                       page = alloc_huge_page(vma, haddr, 0);
> +                       if (IS_ERR(page)) {
> +                               /*
> +                                * Returning error will result in faulting task
> +                                * being sent SIGBUS.  The hugetlb fault mutex
> +                                * prevents two tasks from racing to fault in
> +                                * the same page which could result in false
> +                                * unable to allocate errors.  Page migration
> +                                * does not take the fault mutex, but does a
> +                                * clear then write of pte's under page table
> +                                * lock.  Page fault code could race with
> +                                * migration, notice the clear pte and try to
> +                                * allocate a page here.  Before returning
> +                                * error, get ptl and make sure there really is
> +                                * no pte entry.
> +                                */
> +                               ptl = huge_pte_lock(h, mm, ptep);
> +                               ret = 0;
> +                               if (huge_pte_none(huge_ptep_get(ptep)))
> +                                       ret = vmf_error(PTR_ERR(page));
> +                               spin_unlock(ptl);
> +                               goto out;
> +                       }
>                 }
>                 clear_huge_page(page, address, pages_per_huge_page(h));
>                 __SetPageUptodate(page);
> @@ -4868,31 +4872,55 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
> -
>         if (is_continue) {
>                 ret = -EFAULT;
> -               page = find_lock_page(mapping, idx);
> -               if (!page)
> +               page = hugetlbfs_pagecache_page(h, dst_vma, dst_addr);
> +               if (!page) {
> +                       ret = -ENOMEM;
>                         goto out;
> +               }
>         } else if (!*pagep) {
> -               ret = -ENOMEM;
> +               /* If a page already exists, then it's UFFDIO_COPY for
> +                * a non-missing case. Return -EEXIST.
> +                */
> +               if (hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {
> +                       ret = -EEXIST;
> +                       goto out;
> +               }
> +
>                 page = alloc_huge_page(dst_vma, dst_addr, 0);
>                 if (IS_ERR(page))
>                         goto out;
>
> +               /* Add shared, newly allocated pages to the page cache. */
> +               if (vm_shared) {
> +                       size = i_size_read(mapping->host) >> huge_page_shift(h);
> +                       ret = -EFAULT;
> +                       if (idx >= size)
> +                               goto out;
> +
> +                       /*
> +                        * Serialization between remove_inode_hugepages() and
> +                        * huge_add_to_page_cache() below happens through the
> +                        * hugetlb_fault_mutex_table that here must be hold by
> +                        * the caller.
> +                        */
> +                       ret = huge_add_to_page_cache(page, mapping, idx);
> +                       if (ret)
> +                               goto out;
> +               }
> +
>                 ret = copy_huge_page_from_user(page,
>                                                 (const void __user *) src_addr,
>                                                 pages_per_huge_page(h), false);
> @@ -4916,24 +4944,6 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>          */
>         __SetPageUptodate(page);
>
> -       /* Add shared, newly allocated pages to the page cache. */
> -       if (vm_shared && !is_continue) {
> -               size = i_size_read(mapping->host) >> huge_page_shift(h);
> -               ret = -EFAULT;
> -               if (idx >= size)
> -                       goto out_release_nounlock;
> -
> -               /*
> -                * Serialization between remove_inode_hugepages() and
> -                * huge_add_to_page_cache() below happens through the
> -                * hugetlb_fault_mutex_table that here must be hold by
> -                * the caller.
> -                */
> -               ret = huge_add_to_page_cache(page, mapping, idx);
> -               if (ret)
> -                       goto out_release_nounlock;
> -       }
> -
>         ptl = huge_pte_lockptr(h, dst_mm, dst_pte);
>         spin_lock(ptl);
>
> @@ -4994,7 +5004,6 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>         spin_unlock(ptl);
>         if (vm_shared || is_continue)
>                 unlock_page(page);
> -out_release_nounlock:
>         put_page(page);
>         goto out;
>  }
> --
> 2.31.1.751.gd2f1c929bd-goog
