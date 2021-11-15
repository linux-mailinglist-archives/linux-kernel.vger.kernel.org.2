Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3677451BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344051AbhKPAHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346073AbhKOT3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:29:52 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFBFC0D909C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 11:10:54 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b15so76149620edd.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 11:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V0Ve19ZRiN+HEb7FgnykGLArE+cyMvKMte5Sm1A4UfI=;
        b=Jv5zNde4KksxoMpqcJyhkUsu4MRIuH7stt6fPPHWuK8jIc3i8AJ27AcqMeRPXjydIT
         2BmTSSZFcwnUwwo66ChRKtxZOgTB4LA89yZBybubdcXvXwufok6m5Nhow8gnvQFz4NJG
         +xj3jxVq0Ao1G6egWCBv/v35fTT96Q3w4dwokgm39V65V2O42PMf4IvQkmwkx7Z8aYE1
         2EpiCrGpPluMrCCAvoJ69dxVG6hox/w5uo5QjfpKQxDDiHGAShVmwTZVU7I2VRW45YXX
         EjbFNPlQiCB5n2uTM/IoMjddnXGeOxEm/pZ2x/9ZZ4HWWT8vjrTt+odjc+/UEv3MmLDW
         zzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0Ve19ZRiN+HEb7FgnykGLArE+cyMvKMte5Sm1A4UfI=;
        b=jD+miWQeuGTtAg7nnlEV/gaMOi8wkTAEhIDdnooJuqXnnaBj6T/yKfCt/PL4pznNZx
         aJi8MK8mLfJYl0we3TpYaAZdmvtb1TZ7+ikMuB+imh7aLE73kf7dOMWq4Eb/Q2iDnE5k
         ljL4ZbqbW571iLeqqcRRvoP7HeP3zwghoinprjhWIH7D48D0mBJMnqV5RJlm2CbG0Keb
         8cbwYRojq5S60WLRxL2WbPsuLc+JO8FzlCJxTM/+IwxbS/gxLWH5+rmSu/YvMTxB/vHZ
         RSazFom2p5z/VTVGD+gV3bIAp9GKVsPVXOLoDxDCi+nB9rAEqv5jMUfr0bnMIMsZY9eb
         RL/A==
X-Gm-Message-State: AOAM533U/ND/sC0TTMzMyftzXOfYEGWZeHE0ha8tOpPJAqxM/kNOX1+B
        UtOLKIXyTIoA0LIEFantRhONli7+4coidFA+wOs=
X-Google-Smtp-Source: ABdhPJzUPWJOp8IzVNkzPDf7iQNrQ5ZYTythcn+H/qWxYk+QKM4pyPvfaDBYxMpzho3PD0hPh2Ev3HMXDFdo5LbAbiM=
X-Received: by 2002:a50:a6ca:: with SMTP id f10mr1427178edc.81.1637003452353;
 Mon, 15 Nov 2021 11:10:52 -0800 (PST)
MIME-Version: 1.0
References: <20211115084006.3728254-1-naoya.horiguchi@linux.dev> <20211115084006.3728254-4-naoya.horiguchi@linux.dev>
In-Reply-To: <20211115084006.3728254-4-naoya.horiguchi@linux.dev>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 15 Nov 2021 11:10:40 -0800
Message-ID: <CAHbLzkrsYiDgAnCAyVsggsEks-SkLOsm5n6OKDbiVOJMbWoi1Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm/hwpoison: fix unpoison_memory()
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 12:40 AM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>
> After recent soft-offline rework, error pages can be taken off from
> buddy allocator, but the existing unpoison_memory() does not properly
> undo the operation.  Moreover, due to the recent change on
> __get_hwpoison_page(), get_page_unless_zero() is hardly called for
> hwpoisoned pages.  So __get_hwpoison_page() highly likely returns -EBUSY
> (meaning to fail to grab page refcount) and unpoison just clears
> PG_hwpoison without releasing a refcount.  That does not lead to a
> critical issue like kernel panic, but unpoisoned pages never get back to
> buddy (leaked permanently), which is not good.
>
> To (partially) fix this, we need to identify "taken off" pages from
> other types of hwpoisoned pages.  We can't use refcount or page flags
> for this purpose, so a pseudo flag is defined by hacking ->private
> field.  Someone might think that put_page() is enough to cancel
> taken-off pages, but the normal free path contains some operations not
> suitable for the current purpose, and can fire VM_BUG_ON().
>
> Note that unpoison_memory() is now supposed to be cancel hwpoison events
> injected only by madvise() or /sys/devices/system/memory/{hard,soft}_offline_page,
> not by MCE injection, so please don't try to use unpoison when testing
> with MCE injection.
>
> [lkp@intel.com: report build failure for ARCH=i386]
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
> ChangeLog v4:
> - use integer value for MAGIC_HWPOISON to avoid compile error for ARCH=i386
> - close race in unpoison_taken_off_page()

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> ChangeLog v3:
> - fix description
> - add PageTable check in unpoison_memory()
> - fix return value of clear_page_hwpoison()
> - pass page instead head to PageHWPoisonTakenOff check.
> - rename take_page_back_buddy() with put_page_back_buddy()
>
> ChangeLog v2:
> - unpoison_memory() returns as commented
> - explicitly avoids unpoisoning slab pages
> - separates internal pinning function into __get_unpoison_page()
> ---
>  include/linux/mm.h         |   1 +
>  include/linux/page-flags.h |   4 ++
>  mm/memory-failure.c        | 109 ++++++++++++++++++++++++++++++-------
>  mm/page_alloc.c            |  27 +++++++++
>  4 files changed, 122 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7941bca871dc..8bbb7205ef9f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3220,6 +3220,7 @@ enum mf_flags {
>         MF_ACTION_REQUIRED = 1 << 1,
>         MF_MUST_KILL = 1 << 2,
>         MF_SOFT_OFFLINE = 1 << 3,
> +       MF_UNPOISON = 1 << 4,
>  };
>  extern int memory_failure(unsigned long pfn, int flags);
>  extern void memory_failure_queue(unsigned long pfn, int flags);
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 52ec4b5e5615..a4fe056910bb 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -522,7 +522,11 @@ PAGEFLAG_FALSE(Uncached, uncached)
>  PAGEFLAG(HWPoison, hwpoison, PF_ANY)
>  TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
>  #define __PG_HWPOISON (1UL << PG_hwpoison)
> +#define MAGIC_HWPOISON 0x48575053U     /* HWPS */
> +extern void SetPageHWPoisonTakenOff(struct page *page);
> +extern void ClearPageHWPoisonTakenOff(struct page *page);
>  extern bool take_page_off_buddy(struct page *page);
> +extern bool put_page_back_buddy(struct page *page);
>  #else
>  PAGEFLAG_FALSE(HWPoison, hwpoison)
>  #define __PG_HWPOISON 0
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 722036539b44..0f8b798cba69 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1160,6 +1160,22 @@ static int page_action(struct page_state *ps, struct page *p,
>         return (result == MF_RECOVERED || result == MF_DELAYED) ? 0 : -EBUSY;
>  }
>
> +static inline bool PageHWPoisonTakenOff(struct page *page)
> +{
> +       return PageHWPoison(page) && page_private(page) == MAGIC_HWPOISON;
> +}
> +
> +void SetPageHWPoisonTakenOff(struct page *page)
> +{
> +       set_page_private(page, MAGIC_HWPOISON);
> +}
> +
> +void ClearPageHWPoisonTakenOff(struct page *page)
> +{
> +       if (PageHWPoison(page))
> +               set_page_private(page, 0);
> +}
> +
>  /*
>   * Return true if a page type of a given page is supported by hwpoison
>   * mechanism (while handling could fail), otherwise false.  This function
> @@ -1262,6 +1278,27 @@ static int get_any_page(struct page *p, unsigned long flags)
>         return ret;
>  }
>
> +static int __get_unpoison_page(struct page *page)
> +{
> +       struct page *head = compound_head(page);
> +       int ret = 0;
> +       bool hugetlb = false;
> +
> +       ret = get_hwpoison_huge_page(head, &hugetlb);
> +       if (hugetlb)
> +               return ret;
> +
> +       /*
> +        * PageHWPoisonTakenOff pages are not only marked as PG_hwpoison,
> +        * but also isolated from buddy freelist, so need to identify the
> +        * state and have to cancel both operations to unpoison.
> +        */
> +       if (PageHWPoisonTakenOff(page))
> +               return -EHWPOISON;
> +
> +       return get_page_unless_zero(page) ? 1 : 0;
> +}
> +
>  /**
>   * get_hwpoison_page() - Get refcount for memory error handling
>   * @p:         Raw error page (hit by memory error)
> @@ -1278,18 +1315,26 @@ static int get_any_page(struct page *p, unsigned long flags)
>   * extra care for the error page's state (as done in __get_hwpoison_page()),
>   * and has some retry logic in get_any_page().
>   *
> + * When called from unpoison_memory(), the caller should already ensure that
> + * the given page has PG_hwpoison. So it's never reused for other page
> + * allocations, and __get_unpoison_page() never races with them.
> + *
>   * Return: 0 on failure,
>   *         1 on success for in-use pages in a well-defined state,
>   *         -EIO for pages on which we can not handle memory errors,
>   *         -EBUSY when get_hwpoison_page() has raced with page lifecycle
> - *         operations like allocation and free.
> + *         operations like allocation and free,
> + *         -EHWPOISON when the page is hwpoisoned and taken off from buddy.
>   */
>  static int get_hwpoison_page(struct page *p, unsigned long flags)
>  {
>         int ret;
>
>         zone_pcp_disable(page_zone(p));
> -       ret = get_any_page(p, flags);
> +       if (flags & MF_UNPOISON)
> +               ret = __get_unpoison_page(p);
> +       else
> +               ret = get_any_page(p, flags);
>         zone_pcp_enable(page_zone(p));
>
>         return ret;
> @@ -1942,6 +1987,28 @@ core_initcall(memory_failure_init);
>                 pr_info(fmt, pfn);                      \
>  })
>
> +static inline int clear_page_hwpoison(struct ratelimit_state *rs, struct page *p)
> +{
> +       if (TestClearPageHWPoison(p)) {
> +               unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
> +                                page_to_pfn(p), rs);
> +               num_poisoned_pages_dec();
> +               return 1;
> +       }
> +       return 0;
> +}
> +
> +static inline int unpoison_taken_off_page(struct ratelimit_state *rs,
> +                                         struct page *p)
> +{
> +       if (put_page_back_buddy(p)) {
> +               unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
> +                                page_to_pfn(p), rs);
> +               return 0;
> +       }
> +       return -EBUSY;
> +}
> +
>  /**
>   * unpoison_memory - Unpoison a previously poisoned page
>   * @pfn: Page number of the to be unpoisoned page
> @@ -1958,9 +2025,7 @@ int unpoison_memory(unsigned long pfn)
>  {
>         struct page *page;
>         struct page *p;
> -       int freeit = 0;
> -       int ret = 0;
> -       unsigned long flags = 0;
> +       int ret = -EBUSY;
>         static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
>                                         DEFAULT_RATELIMIT_BURST);
>
> @@ -1996,24 +2061,30 @@ int unpoison_memory(unsigned long pfn)
>                 goto unlock_mutex;
>         }
>
> -       if (!get_hwpoison_page(p, flags)) {
> -               if (TestClearPageHWPoison(p))
> -                       num_poisoned_pages_dec();
> -               unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
> -                                pfn, &unpoison_rs);
> +       if (PageSlab(page) || PageTable(page))
>                 goto unlock_mutex;
> -       }
>
> -       if (TestClearPageHWPoison(page)) {
> -               unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
> -                                pfn, &unpoison_rs);
> -               num_poisoned_pages_dec();
> -               freeit = 1;
> -       }
> +       ret = get_hwpoison_page(p, MF_UNPOISON);
> +       if (!ret) {
> +               if (clear_page_hwpoison(&unpoison_rs, page))
> +                       ret = 0;
> +               else
> +                       ret = -EBUSY;
> +       } else if (ret < 0) {
> +               if (ret == -EHWPOISON) {
> +                       ret = unpoison_taken_off_page(&unpoison_rs, p);
> +               } else
> +                       unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
> +                                        pfn, &unpoison_rs);
> +       } else {
> +               int freeit = clear_page_hwpoison(&unpoison_rs, p);
>
> -       put_page(page);
> -       if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1))
>                 put_page(page);
> +               if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1)) {
> +                       put_page(page);
> +                       ret = 0;
> +               }
> +       }
>
>  unlock_mutex:
>         mutex_unlock(&mf_mutex);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c5952749ad40..d9ba6c1b9f43 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -19,6 +19,7 @@
>  #include <linux/mm.h>
>  #include <linux/highmem.h>
>  #include <linux/swap.h>
> +#include <linux/swapops.h>
>  #include <linux/interrupt.h>
>  #include <linux/pagemap.h>
>  #include <linux/jiffies.h>
> @@ -9448,6 +9449,7 @@ bool take_page_off_buddy(struct page *page)
>                         del_page_from_free_list(page_head, zone, page_order);
>                         break_down_buddy_pages(zone, page_head, page, 0,
>                                                 page_order, migratetype);
> +                       SetPageHWPoisonTakenOff(page);
>                         if (!is_migrate_isolate(migratetype))
>                                 __mod_zone_freepage_state(zone, -1, migratetype);
>                         ret = true;
> @@ -9459,4 +9461,29 @@ bool take_page_off_buddy(struct page *page)
>         spin_unlock_irqrestore(&zone->lock, flags);
>         return ret;
>  }
> +
> +/*
> + * Cancel takeoff done by take_page_off_buddy().
> + */
> +bool put_page_back_buddy(struct page *page)
> +{
> +       struct zone *zone = page_zone(page);
> +       unsigned long pfn = page_to_pfn(page);
> +       unsigned long flags;
> +       int migratetype = get_pfnblock_migratetype(page, pfn);
> +       bool ret = false;
> +
> +       spin_lock_irqsave(&zone->lock, flags);
> +       if (put_page_testzero(page)) {
> +               ClearPageHWPoisonTakenOff(page);
> +               __free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE);
> +               if (TestClearPageHWPoison(page)) {
> +                       num_poisoned_pages_dec();
> +                       ret = true;
> +               }
> +       }
> +       spin_unlock_irqrestore(&zone->lock, flags);
> +
> +       return ret;
> +}
>  #endif
> --
> 2.25.1
>
