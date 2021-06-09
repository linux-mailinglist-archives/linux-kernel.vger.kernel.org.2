Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701FF3A1F6B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFIVzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:55:14 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:42761 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhFIVzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:55:13 -0400
Received: by mail-ed1-f52.google.com with SMTP id i13so30298643edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 14:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5PRgHHIIgTRdkB8/6mBxXJGkSQIhkneFEmfNdmtFn5g=;
        b=uZhAJ80pi8a8J0lvLdWtgaqPpTTbpxUOmHlUAL1fjEuYGzTq4qbl/rhVL3OpHSqbrH
         yAKQ+dLQdux+VZaCfEikMeK85JudN7BkJOyrcjKU3BeDr5vBld5T/Oo7RoPllIa/9Bz0
         Xut3XqjG4klR3TBw1BMg/dJgDvureeNeNP6JzwlAJGjxKETmn4xSQfix8J+umRoHsyo5
         7ntrkN/V29MmZfxvhl7lPHj9wtixmfBdioCFaQS6RgOOBQRQjfUoD57qnnJ/AJ4pRSVd
         a4Vp0addKmlR8Xl647WGXiKARk8n1Zea93nvBdkzuwiSWA19TPLXkEu+PNcs7s58ZPrt
         vV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5PRgHHIIgTRdkB8/6mBxXJGkSQIhkneFEmfNdmtFn5g=;
        b=sRo7lO4eYuGNLOebusLYakzhcCfl1uyPTtWt9D1AtqxMHKoCk4GOUjTTk6+UKU/7ki
         +oV1xsMMj1/e+3v1fMOkYjcoRYAOPQlPSYDg2yQrKSJPZESU3lzRcWUPYHiTj6KAhFFl
         p4qiJkKPF6numLaZc8ghPsGaabDPl19mswKF+87VsW6VwlEHy04d+pPKAY6pxyQbOLB7
         OPFZcTZdTvhNjpIT0M4lpKII6bhOcS+mXTr4OUglppQXDxX3l7/pja51Tp+8seEusA/M
         vTDhYx43/PvuSm0kYD9cCLFdwrorfTS49Et5aazEQ32wajfe35D7hAbyjTLNfWiSXgeM
         GNXQ==
X-Gm-Message-State: AOAM533ns8VOkUDM3Ap2ZbfZ/ovy96bFPErJqpgRBWwT6wFhRkUMdISd
        UcdJ4QJA8t/zkL9kjnTWccDyLKgwZyNenE1ZXAM=
X-Google-Smtp-Source: ABdhPJy7yppG66WxlN0hHUuoirVaGxFaTzxXKCPteRzfo/zc0wGyWnMX9bpraNLe3kdhC9KJRqwBiCIoSbxezpCYgH8=
X-Received: by 2002:a05:6402:145a:: with SMTP id d26mr1430601edx.151.1623275521983;
 Wed, 09 Jun 2021 14:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <af88612-1473-2eaa-903-8d1a448b26@google.com> <f1f68716-5a53-20ff-7ac0-d82fc3978d4e@google.com>
 <CAHbLzkqCJx11qCz0rNNz89C9O+Po8UoS5v_H_Qg3M8Q1eUp5pw@mail.gmail.com>
 <50eb41a-e6f8-e566-20ef-22fb63b0a529@google.com> <a2a4a148-cdd8-942c-4ef8-51b77f643dbe@google.com>
In-Reply-To: <a2a4a148-cdd8-942c-4ef8-51b77f643dbe@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 9 Jun 2021 14:51:50 -0700
Message-ID: <CAHbLzkp=HfoGhPj9Cqo4nvqjqby4H310ywtrM=QiJaX=Bx37HA@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] mm/thp: unmap_mapping_page() to fix THP truncate_cleanup_page()
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 2:16 PM Hugh Dickins <hughd@google.com> wrote:
>
> There is a race between THP unmapping and truncation, when truncate sees
> pmd_none() and skips the entry, after munmap's zap_huge_pmd() cleared it,
> but before its page_remove_rmap() gets to decrement compound_mapcount:
> generating false "BUG: Bad page cache" reports that the page is still
> mapped when deleted.  This commit fixes that, but not in the way I hoped.
>
> The first attempt used try_to_unmap(page, TTU_SYNC|TTU_IGNORE_MLOCK)
> instead of unmap_mapping_range() in truncate_cleanup_page(): it has often
> been an annoyance that we usually call unmap_mapping_range() with no pages
> locked, but there apply it to a single locked page.  try_to_unmap() looks
> more suitable for a single locked page.
>
> However, try_to_unmap_one() contains a VM_BUG_ON_PAGE(!pvmw.pte,page):
> it is used to insert THP migration entries, but not used to unmap THPs.
> Copy zap_huge_pmd() and add THP handling now?  Perhaps, but their TLB
> needs are different, I'm too ignorant of the DAX cases, and couldn't
> decide how far to go for anon+swap.  Set that aside.
>
> The second attempt took a different tack: make no change in truncate.c,
> but modify zap_huge_pmd() to insert an invalidated huge pmd instead of
> clearing it initially, then pmd_clear() between page_remove_rmap() and
> unlocking at the end.  Nice.  But powerpc blows that approach out of the
> water, with its serialize_against_pte_lookup(), and interesting pgtable
> usage.  It would need serious help to get working on powerpc (with a
> minor optimization issue on s390 too).  Set that aside.
>
> Just add an "if (page_mapped(page)) synchronize_rcu();" or other such
> delay, after unmapping in truncate_cleanup_page()?  Perhaps, but though
> that's likely to reduce or eliminate the number of incidents, it would
> give less assurance of whether we had identified the problem correctly.
>
> This successful iteration introduces "unmap_mapping_page(page)" instead
> of try_to_unmap(), and goes the usual unmap_mapping_range_tree() route,
> with an addition to details.  Then zap_pmd_range() watches for this case,
> and does spin_unlock(pmd_lock) if so - just like page_vma_mapped_walk()
> now does in the PVMW_SYNC case.  Not pretty, but safe.
>
> Note that unmap_mapping_page() is doing a VM_BUG_ON(!PageLocked) to
> assert its interface; but currently that's only used to make sure that
> page->mapping is stable, and zap_pmd_range() doesn't care if the page is
> locked or not.  Along these lines, in invalidate_inode_pages2_range()
> move the initial unmap_mapping_range() out from under page lock, before
> then calling unmap_mapping_page() under page lock if still mapped.
>
> Fixes: fc127da085c2 ("truncate: handle file thp")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> ---
> v3: expanded spin_unlock(pmd_lock()) like in 03/10, per Yang Shi

Thanks. Reviewed-by: Yang Shi <shy828301@gmail.com>

>
>  include/linux/mm.h |  3 +++
>  mm/memory.c        | 41 +++++++++++++++++++++++++++++++++++++++++
>  mm/truncate.c      | 43 +++++++++++++++++++------------------------
>  3 files changed, 63 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c274f75efcf9..8ae31622deef 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1719,6 +1719,7 @@ struct zap_details {
>         struct address_space *check_mapping;    /* Check page->mapping if set */
>         pgoff_t first_index;                    /* Lowest page->index to unmap */
>         pgoff_t last_index;                     /* Highest page->index to unmap */
> +       struct page *single_page;               /* Locked page to be unmapped */
>  };
>
>  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> @@ -1766,6 +1767,7 @@ extern vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
>  extern int fixup_user_fault(struct mm_struct *mm,
>                             unsigned long address, unsigned int fault_flags,
>                             bool *unlocked);
> +void unmap_mapping_page(struct page *page);
>  void unmap_mapping_pages(struct address_space *mapping,
>                 pgoff_t start, pgoff_t nr, bool even_cows);
>  void unmap_mapping_range(struct address_space *mapping,
> @@ -1786,6 +1788,7 @@ static inline int fixup_user_fault(struct mm_struct *mm, unsigned long address,
>         BUG();
>         return -EFAULT;
>  }
> +static inline void unmap_mapping_page(struct page *page) { }
>  static inline void unmap_mapping_pages(struct address_space *mapping,
>                 pgoff_t start, pgoff_t nr, bool even_cows) { }
>  static inline void unmap_mapping_range(struct address_space *mapping,
> diff --git a/mm/memory.c b/mm/memory.c
> index f3ffab9b9e39..486f4a2874e7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1361,7 +1361,18 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
>                         else if (zap_huge_pmd(tlb, vma, pmd, addr))
>                                 goto next;
>                         /* fall through */
> +               } else if (details && details->single_page &&
> +                          PageTransCompound(details->single_page) &&
> +                          next - addr == HPAGE_PMD_SIZE && pmd_none(*pmd)) {
> +                       spinlock_t *ptl = pmd_lock(tlb->mm, pmd);
> +                       /*
> +                        * Take and drop THP pmd lock so that we cannot return
> +                        * prematurely, while zap_huge_pmd() has cleared *pmd,
> +                        * but not yet decremented compound_mapcount().
> +                        */
> +                       spin_unlock(ptl);
>                 }
> +
>                 /*
>                  * Here there can be other concurrent MADV_DONTNEED or
>                  * trans huge page faults running, and if the pmd is
> @@ -3236,6 +3247,36 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
>         }
>  }
>
> +/**
> + * unmap_mapping_page() - Unmap single page from processes.
> + * @page: The locked page to be unmapped.
> + *
> + * Unmap this page from any userspace process which still has it mmaped.
> + * Typically, for efficiency, the range of nearby pages has already been
> + * unmapped by unmap_mapping_pages() or unmap_mapping_range().  But once
> + * truncation or invalidation holds the lock on a page, it may find that
> + * the page has been remapped again: and then uses unmap_mapping_page()
> + * to unmap it finally.
> + */
> +void unmap_mapping_page(struct page *page)
> +{
> +       struct address_space *mapping = page->mapping;
> +       struct zap_details details = { };
> +
> +       VM_BUG_ON(!PageLocked(page));
> +       VM_BUG_ON(PageTail(page));
> +
> +       details.check_mapping = mapping;
> +       details.first_index = page->index;
> +       details.last_index = page->index + thp_nr_pages(page) - 1;
> +       details.single_page = page;
> +
> +       i_mmap_lock_write(mapping);
> +       if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
> +               unmap_mapping_range_tree(&mapping->i_mmap, &details);
> +       i_mmap_unlock_write(mapping);
> +}
> +
>  /**
>   * unmap_mapping_pages() - Unmap pages from processes.
>   * @mapping: The address space containing pages to be unmapped.
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 95af244b112a..234ddd879caa 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -167,13 +167,10 @@ void do_invalidatepage(struct page *page, unsigned int offset,
>   * its lock, b) when a concurrent invalidate_mapping_pages got there first and
>   * c) when tmpfs swizzles a page between a tmpfs inode and swapper_space.
>   */
> -static void
> -truncate_cleanup_page(struct address_space *mapping, struct page *page)
> +static void truncate_cleanup_page(struct page *page)
>  {
> -       if (page_mapped(page)) {
> -               unsigned int nr = thp_nr_pages(page);
> -               unmap_mapping_pages(mapping, page->index, nr, false);
> -       }
> +       if (page_mapped(page))
> +               unmap_mapping_page(page);
>
>         if (page_has_private(page))
>                 do_invalidatepage(page, 0, thp_size(page));
> @@ -218,7 +215,7 @@ int truncate_inode_page(struct address_space *mapping, struct page *page)
>         if (page->mapping != mapping)
>                 return -EIO;
>
> -       truncate_cleanup_page(mapping, page);
> +       truncate_cleanup_page(page);
>         delete_from_page_cache(page);
>         return 0;
>  }
> @@ -325,7 +322,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
>                 index = indices[pagevec_count(&pvec) - 1] + 1;
>                 truncate_exceptional_pvec_entries(mapping, &pvec, indices);
>                 for (i = 0; i < pagevec_count(&pvec); i++)
> -                       truncate_cleanup_page(mapping, pvec.pages[i]);
> +                       truncate_cleanup_page(pvec.pages[i]);
>                 delete_from_page_cache_batch(mapping, &pvec);
>                 for (i = 0; i < pagevec_count(&pvec); i++)
>                         unlock_page(pvec.pages[i]);
> @@ -639,6 +636,16 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
>                                 continue;
>                         }
>
> +                       if (!did_range_unmap && page_mapped(page)) {
> +                               /*
> +                                * If page is mapped, before taking its lock,
> +                                * zap the rest of the file in one hit.
> +                                */
> +                               unmap_mapping_pages(mapping, index,
> +                                               (1 + end - index), false);
> +                               did_range_unmap = 1;
> +                       }
> +
>                         lock_page(page);
>                         WARN_ON(page_to_index(page) != index);
>                         if (page->mapping != mapping) {
> @@ -646,23 +653,11 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
>                                 continue;
>                         }
>                         wait_on_page_writeback(page);
> -                       if (page_mapped(page)) {
> -                               if (!did_range_unmap) {
> -                                       /*
> -                                        * Zap the rest of the file in one hit.
> -                                        */
> -                                       unmap_mapping_pages(mapping, index,
> -                                               (1 + end - index), false);
> -                                       did_range_unmap = 1;
> -                               } else {
> -                                       /*
> -                                        * Just zap this page
> -                                        */
> -                                       unmap_mapping_pages(mapping, index,
> -                                                               1, false);
> -                               }
> -                       }
> +
> +                       if (page_mapped(page))
> +                               unmap_mapping_page(page);
>                         BUG_ON(page_mapped(page));
> +
>                         ret2 = do_launder_page(mapping, page);
>                         if (ret2 == 0) {
>                                 if (!invalidate_complete_page2(mapping, page))
> --
> 2.26.2
>
