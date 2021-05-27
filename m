Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542A0392520
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 04:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhE0DA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhE0DA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:00:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7798BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:58:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t11so1933151pjm.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pru6zig8q3sxmELElDi+3+yZB8QewYE1tT1Q+WjTzFQ=;
        b=pu1KevegNRiVnMibNgq3n/QYJpkV5ZW6F+g/cP4giGCnsVwMugAYUyRUUTzQiFZ/Sr
         4zRqebTMzDTgrKhNw1BQrk2TQaBE2v8LYnyDK7SWz8m55MrNGTxK5sMV3bkE6op2rYCz
         ubuCEBAPeotFJ6a6SUibe/h9J0wlbH7rvR9mYE5xuIBixlk0fnz2IzvPRrsdtcGdRLD7
         wSPULPjwPI7SLHm4hM+dnXqHGltxwtEoLQuipKzuCjIPxgCCLi5FrAt4If1dAXlzoqbk
         XeOIbHSMcaA1Qqc9XvaD8rUxl8aaOathBpBbPKkYQDPtn0P9936/c2DZ+JWqPx7uCer1
         hKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pru6zig8q3sxmELElDi+3+yZB8QewYE1tT1Q+WjTzFQ=;
        b=rrg042h53L9XpsoLQJDYatG7NTJN8pTq+6jhTdReAlR3dNQmh5dvoOrsbNJfKRQEhU
         LovHxDJCUTlu7gwn0BpRpkz7TJNlmnHu+HxmQfmTw8MEKemRta3GufEZntF/Hx34vJG0
         uVCWwscbrXpsQqPy5Qy/Nf7fnjYNLAwSPINBq/hTQqXg+RWhldvXXnw02DS7dJOdUhlq
         0BKqYjaOmibm6QKd2gsWKhKERjFwO506ie38GXDnM3hkitGIMLCkrYoKHTKJYYozbfuG
         d/rJK7npgN0UTo+avd8X2eR8yXLCvPv3OIQVKvWme+LToUG+MTkrtvtNiIYMYOoxqQHf
         v+Aw==
X-Gm-Message-State: AOAM5332qFoT6jaIeoAHPz5aiJcnHM9cQgg6uYsObTRXtBa4G7thMHMD
        347dB2o7fTDJ4IZ5K2MTcqis1HmMqTVSuOa1Zq5QaQ==
X-Google-Smtp-Source: ABdhPJwKzBFxAwJvzP6BwwqnClKQ4aMoY1+3GrUFgWxR/cF94wt214noH7Q2i3NRXn2t0PTFEN/hcR4YjBNR4m0TMAo=
X-Received: by 2002:a17:90b:1885:: with SMTP id mn5mr6807630pjb.24.1622084334680;
 Wed, 26 May 2021 19:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <78359cf0-6e28-2aaa-d17e-6519b117b3db@oracle.com>
 <20210525233134.246444-1-mike.kravetz@oracle.com> <20210525233134.246444-3-mike.kravetz@oracle.com>
In-Reply-To: <20210525233134.246444-3-mike.kravetz@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 26 May 2021 19:58:43 -0700
Message-ID: <CAHS8izNxru+vKc6nSP5x0h24CqMFnXyVZBKRBDxhP9Uh5hZUJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hugetlb: add new hugetlb specific flag HPG_restore_rsv_map
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
> When a hugetlb page is allocated via alloc_huge_page, the reserve map
> as well as global reservation count may be modified.  In case of error
> after allocation, the count and map should be restored to their previous
> state if possible.  The flag HPageRestoreRsvCnt indicates the global
> count was modified.  Add a new flag HPG_restore_rsv_map to indicate the
> reserve map was modified.  Note that during hugetlb page allocation the
> the global count and reserve map could be modified independently.
> Therefore, two specific flags are needed.
>
> The routine restore_reserve_on_error is called to restore reserve data
> on error paths.  Modify the routine to check for the HPG_restore_rsv_map
> flag and adjust the reserve map accordingly.
>

Should be an equivalent function that fixes the reservation on page
freeing? restore_reserve_on_put_page() or something? I'm confused that
we need to restore reservation on error, but seemingly there is no
function that restores reservation on normal operation page freeing.

> Add missing calls to restore_reserve_on_error to error paths  of code
> calling alloc_huge_page.
>

Is it a good idea to add a comment above alloc_huge_page() that to
unroll it we need to put_page() *and* call restore_reserve_on_error()?

> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/hugetlbfs/inode.c    |  1 +
>  include/linux/hugetlb.h | 11 ++++++
>  mm/hugetlb.c            | 82 +++++++++++++++++++++++++++++++----------
>  3 files changed, 75 insertions(+), 19 deletions(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index bb4de5dcd652..9d846a2edc4b 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -735,6 +735,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>                 __SetPageUptodate(page);
>                 error = huge_add_to_page_cache(page, mapping, index);
>                 if (unlikely(error)) {
> +                       restore_reserve_on_error(h, &pseudo_vma, addr, page);
>                         put_page(page);
>                         mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>                         goto out;
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index e5e363fa5d02..da2251b0c609 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -517,6 +517,13 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   *     Synchronization:  Examined or modified by code that knows it has
>   *     the only reference to page.  i.e. After allocation but before use
>   *     or when the page is being freed.
> + * HPG_restore_rsv_map - Set when a hugetlb page allocation results in adding
> + *     an entry to the reserve map.  This can happen without adjustment of
> + *     the global reserve count.  Cleared when page is fully instantiated.
> + *     Error paths (restore_reserve_on_error) check this flag to make
> + *     adjustments to the reserve map.
> + *     Synchronization:  Examined or modified by code that knows it has
> + *     the only reference to page.  i.e. After allocation but before use.
>   * HPG_migratable  - Set after a newly allocated page is added to the page
>   *     cache and/or page tables.  Indicates the page is a candidate for
>   *     migration.
> @@ -536,6 +543,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   */
>  enum hugetlb_page_flags {
>         HPG_restore_rsv_cnt = 0,
> +       HPG_restore_rsv_map,
>         HPG_migratable,
>         HPG_temporary,
>         HPG_freed,
> @@ -582,6 +590,7 @@ static inline void ClearHPage##uname(struct page *page)             \
>   * Create functions associated with hugetlb page flags
>   */
>  HPAGEFLAG(RestoreRsvCnt, restore_rsv_cnt)
> +HPAGEFLAG(RestoreRsvMap, restore_rsv_map)
>  HPAGEFLAG(Migratable, migratable)
>  HPAGEFLAG(Temporary, temporary)
>  HPAGEFLAG(Freed, freed)
> @@ -633,6 +642,8 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
>                                 unsigned long address);
>  int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
>                         pgoff_t idx);
> +void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
> +               unsigned long address, struct page *page);
>
>  /* arch callback */
>  int __init __alloc_bootmem_huge_page(struct hstate *h);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 2a8cea253388..1c3a68d70ab5 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1551,6 +1551,7 @@ void free_huge_page(struct page *page)
>         page->mapping = NULL;
>         restore_reserve = HPageRestoreRsvCnt(page);
>         ClearHPageRestoreRsvCnt(page);
> +       ClearHPageRestoreRsvMap(page);
>
>         /*
>          * If HPageRestoreRsvCnt was set on page, page allocation consumed a
> @@ -2360,24 +2361,26 @@ static long vma_add_reservation(struct hstate *h,
>  }
>
>  /*
> - * This routine is called to restore a reservation on error paths.  In the
> - * specific error paths, a huge page was allocated (via alloc_huge_page)
> - * and is about to be freed.  If a reservation for the page existed,
> - * alloc_huge_page would have consumed the reservation and set
> - * HPageRestoreRsvCnt in the newly allocated page.  When the page is freed
> - * via free_huge_page, the global reservation count will be incremented if
> - * HPageRestoreRsvCnt is set.  However, free_huge_page can not adjust the
> - * reserve map.  Adjust the reserve map here to be consistent with global
> - * reserve count adjustments to be made by free_huge_page.
> + * This routine is called to restore a reservation data on error paths.
> + * It handles two specific cases for pages allocated via alloc_huge_page:
> + * 1) A reservation was in place and page consumed the reservation.
> + *    HPageRestoreRsvCnt is set in the page.
> + * 2) No reservation was in place for the page, so HPageRestoreRsvCnt is
> + *    not set.  However, the reserve map was updated.
> + * In case 1, free_huge_page will increment the global reserve count.  But,
> + * free_huge_page does not have enough context to adjust the reservation map.
> + * This case deals primarily with private mappings.  Adjust the reserve map
> + * here to be consistent with global reserve count adjustments to be made
> + * by free_huge_page.
> + * In case 2, simply undo an reserve map modifications done by alloc_huge_page.
>   */
> -static void restore_reserve_on_error(struct hstate *h,
> -                       struct vm_area_struct *vma, unsigned long address,
> -                       struct page *page)
> +void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
> +                               unsigned long address, struct page *page)
>  {
>         if (unlikely(HPageRestoreRsvCnt(page))) {
>                 long rc = vma_needs_reservation(h, vma, address);
>
> -               if (unlikely(rc < 0)) {
> +               if (unlikely(rc < 0))
>                         /*
>                          * Rare out of memory condition in reserve map
>                          * manipulation.  Clear HPageRestoreRsvCnt so that
> @@ -2390,16 +2393,47 @@ static void restore_reserve_on_error(struct hstate *h,
>                          * accounting of reserve counts.
>                          */
>                         ClearHPageRestoreRsvCnt(page);
> -               } else if (rc) {
> -                       rc = vma_add_reservation(h, vma, address);
> -                       if (unlikely(rc < 0))
> +               else if (rc)
> +                       vma_add_reservation(h, vma, address);
> +               else
> +                       vma_end_reservation(h, vma, address);
> +       } else if (unlikely(HPageRestoreRsvMap(page))) {
> +               struct resv_map *resv = vma_resv_map(vma);
> +               pgoff_t idx = vma_hugecache_offset(h, vma, address);
> +               long rc;
> +
> +               /*
> +                * This handles the specific case where the reserve count
> +                * was not updated during the page allocation process, but
> +                * the reserve map was updated.  We need to undo the reserve
> +                * map update.
> +                *
> +                * The presence of an entry in the reserve map has opposite
> +                * meanings for shared and private mappings.
> +                */
> +               if (vma->vm_flags & VM_MAYSHARE) {
> +                       rc = region_del(resv, idx, idx + 1);
> +                       if (rc < 0)
> +                               /*
> +                                * Rare out of memory condition.  Since we can
> +                                * not delete the reserve entry, set
> +                                * HPageRestoreRsvCnt so that the global count
> +                                * will be consistent with the reserve map.
> +                                */
> +                               SetHPageRestoreRsvCnt(page);
> +               } else {
> +                       rc = vma_needs_reservation(h, vma, address);
> +                       if (rc < 0)
>                                 /*
>                                  * See above comment about rare out of
>                                  * memory condition.
>                                  */
> -                               ClearHPageRestoreRsvCnt(page);
> -               } else
> -                       vma_end_reservation(h, vma, address);
> +                               SetHPageRestoreRsvCnt(page);
> +                       else if (rc)
> +                               vma_add_reservation(h, vma, address);
> +                       else
> +                               vma_end_reservation(h, vma, address);
> +               }

As I mentioned in the other email, this call sequence does not result
in the region_del() call that we really need here. Calling
region_del() directly would be one fix, another would be to call
vma_end_reservation() even if !rc. Not sure which is more semantically
correct. hugetlb_unreserve_pages() calls region_del()
indiscriminately.

>         }
>  }
>
> @@ -2641,6 +2675,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>                         hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
>                                         pages_per_huge_page(h), page);
>         }
> +       if (map_commit)
> +               SetHPageRestoreRsvMap(page);
>         return page;
>
>  out_uncharge_cgroup:
> @@ -4053,6 +4089,7 @@ hugetlb_install_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr
>         hugepage_add_new_anon_rmap(new_page, vma, addr);
>         hugetlb_count_add(pages_per_huge_page(hstate_vma(vma)), vma->vm_mm);
>         ClearHPageRestoreRsvCnt(new_page);
> +       ClearHPageRestoreRsvMap(new_page);
>         SetHPageMigratable(new_page);
>  }
>
> @@ -4174,6 +4211,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>                                 spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>                                 entry = huge_ptep_get(src_pte);
>                                 if (!pte_same(src_pte_old, entry)) {
> +                                       restore_reserve_on_error(h, vma, addr,
> +                                                               new);
>                                         put_page(new);
>                                         /* dst_entry won't change as in child */
>                                         goto again;
> @@ -4526,6 +4565,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>         ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
>         if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
>                 ClearHPageRestoreRsvCnt(new_page);
> +               ClearHPageRestoreRsvMap(new_page);
>
>                 /* Break COW */
>                 huge_ptep_clear_flush(vma, haddr, ptep);
> @@ -4593,6 +4633,7 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
>         if (err)
>                 return err;
>         ClearHPageRestoreRsvCnt(page);
> +       ClearHPageRestoreRsvMap(page);
>
>         /*
>          * set page dirty so that it will not be removed from cache/file
> @@ -4776,6 +4817,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>
>         if (anon_rmap) {
>                 ClearHPageRestoreRsvCnt(page);
> +               ClearHPageRestoreRsvMap(page);
>                 hugepage_add_new_anon_rmap(page, vma, haddr);
>         } else
>                 page_dup_rmap(page, true);
> @@ -5097,6 +5139,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>                 page_dup_rmap(page, true);
>         } else {
>                 ClearHPageRestoreRsvCnt(page);
> +               ClearHPageRestoreRsvMap(page);
>                 hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
>         }
>
> @@ -5133,6 +5176,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>         if (vm_shared || is_continue)
>                 unlock_page(page);
>  out_release_nounlock:
> +       restore_reserve_on_error(h, dst_vma, dst_addr, page);
>         put_page(page);
>         goto out;
>  }
> --
> 2.31.1
>
