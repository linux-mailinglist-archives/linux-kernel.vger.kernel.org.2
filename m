Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FF839250F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 04:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhE0Cuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 22:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbhE0Cuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 22:50:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB78C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:49:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e15so1620218plh.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biZYQJ0Hl7mfmo1RQJDiZVXEnYCQBvnxBX+f/vhB3kI=;
        b=Ui6XK3ip+owK7MMd5tsIb7CKyhAqVBlJU96pwDabZr4wMmZ99sHpOBZeKMBvfrg90k
         Z/fB2XaUPli6/fBfwrhHtcpv7bk/qGUfnZWev6IyYtoQAY8kQax707M3lLzMrsEijYpL
         +mjJC2whbXOteUeksVcUpbxAjZGV18LawUCbcAN16Pkp7Uis2uc6Sx1JpgrTBUd7FLg7
         LjgUs1w8axpwPX4IWFU1fz4NqNFoO261znEq341mGjVRMGJYcY4tGm/E+XaTYOkr6imE
         b2LNI4Jcr5mAqzKJzpMymAA0dMFDlV3ah9kqfIlvRNkrwi/sL8oYXHgGVbMtv8BHjeo+
         /9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biZYQJ0Hl7mfmo1RQJDiZVXEnYCQBvnxBX+f/vhB3kI=;
        b=gRNDSEN0p1FxXigXRwAovUicXURf4b9fgK17dtVRNe490/r4/bkLe3jDdLwbXh8QqU
         OyUNd/k5xgK8M3vqL9UfsSQoH+YOdzy68rI6L5N2Hof1KK+p8vrWA+u8xyj9FMmx/WGW
         TZ5+L6MzERragyqPWqKP08HlQoBFjHVjI1KGg6gGYnfQk9aoUk0akXBCZ0v/6Obv/U20
         Zfg8Yu6qoN7MEjU7Lvm8dNghCI64yIu6NJ/B75hE9l7toPy1iT1+M8ehT/OpYmf6a/VL
         mwIyerci7J//2v98FPUfbge78iKn6NNtgLGNLpH9MBCRK21Oa6Uj+GqSJudBEoVcqcGP
         ZaXw==
X-Gm-Message-State: AOAM531WjxpI13OBY3kN8vi7so/jsb288nA1HfgjI/Q/9gSKcXnORYXK
        XTbXu0TNDrElGmEKBUjiHfZ9KfPuG5+r3lhRIYMBsQ==
X-Google-Smtp-Source: ABdhPJyf7CQcGSLUq6422PvaEbpqhIU3RjfVi2CW5Pcxex3wnUkGusioLmJvEjiGVq0MBRhoz0w6plhGssn1AYIpgjA=
X-Received: by 2002:a17:903:189:b029:f1:d67a:5168 with SMTP id
 z9-20020a1709030189b02900f1d67a5168mr1200237plg.82.1622083759802; Wed, 26 May
 2021 19:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <78359cf0-6e28-2aaa-d17e-6519b117b3db@oracle.com>
 <20210525233134.246444-1-mike.kravetz@oracle.com> <20210525233134.246444-2-mike.kravetz@oracle.com>
In-Reply-To: <20210525233134.246444-2-mike.kravetz@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 26 May 2021 19:49:08 -0700
Message-ID: <CAHS8izOW9j_o2hYWLC-eux8S4fvBH6ADv50aH0JrrnkgKvrGhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hugetlb: rename HPageRestoreReserve flag to HPageRestoreRsvCnt
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 4:31 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> The hugetlb page specific flag HPageRestoreReserve is used to indicate
> that a reservation was consumed and should be restored on error.  More
> specifically, this is related to the global reservation count.
>
> It is also possible to have a hugetlb page allocated where the global
> count is not modified, but the reservation map is modified.  In such
> cases, the reserve map needs modification in error paths.  Code
> performing such modifications will be introduced in a subsequent patch.
>
> Rename the flag HPageRestoreReserve to HPageRestoreRsvCnt so that it
> is more clearly allociated with the global reservation count.  No
> functional changes in this patch, just renaming.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/hugetlbfs/inode.c    |  2 +-
>  include/linux/hugetlb.h |  6 +++---
>  mm/hugetlb.c            | 32 ++++++++++++++++----------------
>  mm/userfaultfd.c        | 14 +++++++-------
>  4 files changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 55efd3dd04f6..bb4de5dcd652 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -529,7 +529,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>                          * the subpool and global reserve usage count can need
>                          * to be adjusted.
>                          */
> -                       VM_BUG_ON(HPageRestoreReserve(page));
> +                       VM_BUG_ON(HPageRestoreRsvCnt(page));
>                         remove_huge_page(page);
>                         freed++;
>                         if (!truncate_op) {
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 03ca83db0a3e..e5e363fa5d02 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -511,7 +511,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   * of the hugetlb head page.  Functions created via the below macros should be
>   * used to manipulate these flags.
>   *
> - * HPG_restore_reserve - Set when a hugetlb page consumes a reservation at
> + * HPG_restore_rsv_cnt - Set when a hugetlb page consumes a reservation at
>   *     allocation time.  Cleared when page is fully instantiated.  Free
>   *     routine checks flag to restore a reservation on error paths.
>   *     Synchronization:  Examined or modified by code that knows it has
> @@ -535,7 +535,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   * HPG_vmemmap_optimized - Set when the vmemmap pages of the page are freed.
>   */
>  enum hugetlb_page_flags {
> -       HPG_restore_reserve = 0,
> +       HPG_restore_rsv_cnt = 0,
>         HPG_migratable,
>         HPG_temporary,
>         HPG_freed,
> @@ -581,7 +581,7 @@ static inline void ClearHPage##uname(struct page *page)             \
>  /*
>   * Create functions associated with hugetlb page flags
>   */
> -HPAGEFLAG(RestoreReserve, restore_reserve)
> +HPAGEFLAG(RestoreRsvCnt, restore_rsv_cnt)
>  HPAGEFLAG(Migratable, migratable)
>  HPAGEFLAG(Temporary, temporary)
>  HPAGEFLAG(Freed, freed)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c3b2a8a494d6..2a8cea253388 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1165,7 +1165,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
>         nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
>         page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
>         if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
> -               SetHPageRestoreReserve(page);
> +               SetHPageRestoreRsvCnt(page);
>                 h->resv_huge_pages--;
>         }
>
> @@ -1549,11 +1549,11 @@ void free_huge_page(struct page *page)
>
>         hugetlb_set_page_subpool(page, NULL);
>         page->mapping = NULL;
> -       restore_reserve = HPageRestoreReserve(page);
> -       ClearHPageRestoreReserve(page);
> +       restore_reserve = HPageRestoreRsvCnt(page);
> +       ClearHPageRestoreRsvCnt(page);
>
>         /*
> -        * If HPageRestoreReserve was set on page, page allocation consumed a
> +        * If HPageRestoreRsvCnt was set on page, page allocation consumed a
>          * reservation.  If the page was associated with a subpool, there
>          * would have been a page reserved in the subpool before allocation
>          * via hugepage_subpool_get_pages().  Since we are 'restoring' the
> @@ -2364,9 +2364,9 @@ static long vma_add_reservation(struct hstate *h,
>   * specific error paths, a huge page was allocated (via alloc_huge_page)
>   * and is about to be freed.  If a reservation for the page existed,
>   * alloc_huge_page would have consumed the reservation and set
> - * HPageRestoreReserve in the newly allocated page.  When the page is freed
> + * HPageRestoreRsvCnt in the newly allocated page.  When the page is freed
>   * via free_huge_page, the global reservation count will be incremented if
> - * HPageRestoreReserve is set.  However, free_huge_page can not adjust the
> + * HPageRestoreRsvCnt is set.  However, free_huge_page can not adjust the
>   * reserve map.  Adjust the reserve map here to be consistent with global
>   * reserve count adjustments to be made by free_huge_page.
>   */
> @@ -2374,13 +2374,13 @@ static void restore_reserve_on_error(struct hstate *h,
>                         struct vm_area_struct *vma, unsigned long address,
>                         struct page *page)
>  {
> -       if (unlikely(HPageRestoreReserve(page))) {
> +       if (unlikely(HPageRestoreRsvCnt(page))) {
>                 long rc = vma_needs_reservation(h, vma, address);
>
>                 if (unlikely(rc < 0)) {
>                         /*
>                          * Rare out of memory condition in reserve map
> -                        * manipulation.  Clear HPageRestoreReserve so that
> +                        * manipulation.  Clear HPageRestoreRsvCnt so that
>                          * global reserve count will not be incremented
>                          * by free_huge_page.  This will make it appear
>                          * as though the reservation for this page was
> @@ -2389,7 +2389,7 @@ static void restore_reserve_on_error(struct hstate *h,
>                          * is better than inconsistent global huge page
>                          * accounting of reserve counts.
>                          */
> -                       ClearHPageRestoreReserve(page);
> +                       ClearHPageRestoreRsvCnt(page);
>                 } else if (rc) {
>                         rc = vma_add_reservation(h, vma, address);
>                         if (unlikely(rc < 0))
> @@ -2397,7 +2397,7 @@ static void restore_reserve_on_error(struct hstate *h,
>                                  * See above comment about rare out of
>                                  * memory condition.
>                                  */
> -                               ClearHPageRestoreReserve(page);
> +                               ClearHPageRestoreRsvCnt(page);
>                 } else
>                         vma_end_reservation(h, vma, address);
>         }
> @@ -2602,7 +2602,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>                 if (!page)
>                         goto out_uncharge_cgroup;
>                 if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
> -                       SetHPageRestoreReserve(page);
> +                       SetHPageRestoreRsvCnt(page);
>                         h->resv_huge_pages--;
>                 }
>                 spin_lock_irq(&hugetlb_lock);
> @@ -4052,7 +4052,7 @@ hugetlb_install_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr
>         set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, new_page, 1));
>         hugepage_add_new_anon_rmap(new_page, vma, addr);
>         hugetlb_count_add(pages_per_huge_page(hstate_vma(vma)), vma->vm_mm);
> -       ClearHPageRestoreReserve(new_page);
> +       ClearHPageRestoreRsvCnt(new_page);
>         SetHPageMigratable(new_page);
>  }
>
> @@ -4525,7 +4525,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>         spin_lock(ptl);
>         ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
>         if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
> -               ClearHPageRestoreReserve(new_page);
> +               ClearHPageRestoreRsvCnt(new_page);
>
>                 /* Break COW */
>                 huge_ptep_clear_flush(vma, haddr, ptep);
> @@ -4592,7 +4592,7 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
>
>         if (err)
>                 return err;
> -       ClearHPageRestoreReserve(page);
> +       ClearHPageRestoreRsvCnt(page);
>
>         /*
>          * set page dirty so that it will not be removed from cache/file
> @@ -4775,7 +4775,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>                 goto backout;
>
>         if (anon_rmap) {
> -               ClearHPageRestoreReserve(page);
> +               ClearHPageRestoreRsvCnt(page);
>                 hugepage_add_new_anon_rmap(page, vma, haddr);
>         } else
>                 page_dup_rmap(page, true);
> @@ -5096,7 +5096,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>         if (vm_shared) {
>                 page_dup_rmap(page, true);
>         } else {
> -               ClearHPageRestoreReserve(page);
> +               ClearHPageRestoreRsvCnt(page);
>                 hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
>         }
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 9ce5a3793ad4..58c706697b17 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -432,27 +432,27 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>                  * If a reservation for the page existed in the reservation
>                  * map of a private mapping, the map was modified to indicate
>                  * the reservation was consumed when the page was allocated.
> -                * We clear the HPageRestoreReserve flag now so that the global
> +                * We clear the HPageRestoreRsvCnt flag now so that the global
>                  * reserve count will not be incremented in free_huge_page.
>                  * The reservation map will still indicate the reservation
>                  * was consumed and possibly prevent later page allocation.
>                  * This is better than leaking a global reservation.  If no
>                  * reservation existed, it is still safe to clear
> -                * HPageRestoreReserve as no adjustments to reservation counts
> +                * HPageRestoreRsvCnt as no adjustments to reservation counts
>                  * were made during allocation.
>                  *
>                  * The reservation map for shared mappings indicates which
>                  * pages have reservations.  When a huge page is allocated
>                  * for an address with a reservation, no change is made to
> -                * the reserve map.  In this case HPageRestoreReserve will be
> +                * the reserve map.  In this case HPageRestoreRsvCnt will be
>                  * set to indicate that the global reservation count should be
>                  * incremented when the page is freed.  This is the desired
>                  * behavior.  However, when a huge page is allocated for an
>                  * address without a reservation a reservation entry is added
> -                * to the reservation map, and HPageRestoreReserve will not be
> +                * to the reservation map, and HPageRestoreRsvCnt will not be
>                  * set. When the page is freed, the global reserve count will
>                  * NOT be incremented and it will appear as though we have
> -                * leaked reserved page.  In this case, set HPageRestoreReserve
> +                * leaked reserved page.  In this case, set HPageRestoreRsvCnt
>                  * so that the global reserve count will be incremented to
>                  * match the reservation map entry which was created.
>                  *
> @@ -461,9 +461,9 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>                  * be different or NULL on error.
>                  */
>                 if (vm_alloc_shared)
> -                       SetHPageRestoreReserve(page);
> +                       SetHPageRestoreRsvCnt(page);
>                 else
> -                       ClearHPageRestoreReserve(page);
> +                       ClearHPageRestoreRsvCnt(page);
>                 put_page(page);
>         }
>         BUG_ON(copied < 0);
> --
> 2.31.1
>

Reviewed-by: Mina Almasry <almasrymina@google.com>
