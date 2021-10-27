Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4299543C115
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 06:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhJ0EDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 00:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhJ0EDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 00:03:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C74C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:00:51 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g10so5130374edj.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ZEaxGjKcUNwopSJsejZRl5qOjp/bxPqmxY873M58jE=;
        b=p+fGoWN++hvKLlu0UnoCC97VtDaJaAHjMi6R+jk16/IYAGMqBm3vVZoyxKwGlzjK2e
         D6wO9xwk5E6dQUv79YXo5J2hriGrQA2GvAtPBVUoAsHUJ7C4vd1wkMHTuqZA7scaGDAP
         3zVmr42/o5LGWg8vBVi3ZIIG9FOxW5okvh0QFViT3CmgvuMHFUE26zV3iODAwkO/l8PB
         VQn7WxQTf3U0MDeKQNcC8p30fHFG+jKceIcWFBIgebTKZMHWlFeeqfl43WvmgsZjkaFm
         Z4uEhVBwfhMpXX/2y57nIxdZ4ZBCT6KXBJPcqMgXSwxZ4ma9diJ2qQdKhhy8tBw03quJ
         Viaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ZEaxGjKcUNwopSJsejZRl5qOjp/bxPqmxY873M58jE=;
        b=b4hiv78+OEdBEEyd+IV+2ujJrXwtEkdyU1RO8Q4RMYrZZTmkCNI1vW2VokdLlUwMw1
         HNNSurrVKzgonoQod2BG3rXO5IjsPDt7BuEjZmxUN2WYjYsjb6il2e5grruOf8kWBiYZ
         CJ68a7AYbdTEuWawgrVRcuLuGMC5eC12kYJaKo7mQsFpUIP0Y2ofNpmVITkYCje3QPy/
         HmNpcXvTDYvZfoA2dKVZ6i2cZQR6yZ3YYs9a+6ms2h1xfMurApnqe8YIbm7t83VmGoWd
         i4sZcpKPkOXkNztD90K9FyORGlifTprUZn2Qn5KYLRjljwb2lRWtmjyWNQ1NzV1pOUji
         nheA==
X-Gm-Message-State: AOAM5329kAgFz/ZEQJ7BZ/dYyIppX32MDh7Y+5MJgmkOlqLXgZJYw8YA
        MfAsDBFVuu4jlQMatUzbHo5BxSithTSFLh5dKlE=
X-Google-Smtp-Source: ABdhPJwEuFUFQXM/zHPOlAcNVs1SvX7Tr7g1S/FdiJlP6bf9EArKpTW5RDUQtu3lPIFuPrIbEnfAKD4Tgjvgs6yyQR4=
X-Received: by 2002:a17:906:6088:: with SMTP id t8mr35060256ejj.537.1635307249697;
 Tue, 26 Oct 2021 21:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211025230503.2650970-1-naoya.horiguchi@linux.dev> <20211025231618.GA2651507@u2004>
In-Reply-To: <20211025231618.GA2651507@u2004>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 26 Oct 2021 21:00:37 -0700
Message-ID: <CAHbLzkp45EuAJnGoA7NtWPunW1QEb5GcY7eWm89ZKQfpsi_GkA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] mm/hwpoison: fix unpoison_memory()
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
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

On Mon, Oct 25, 2021 at 4:16 PM Naoya Horiguchi <nao.horiguchi@gmail.com> wrote:
>
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>
> After recent soft-offline rework, error pages can be taken off from
> buddy allocator, but the existing unpoison_memory() does not properly
> undo the operation.  Moreover, due to the recent change on
> __get_hwpoison_page(), get_page_unless_zero() is hardly called for
> hwpoisoned pages.  So __get_hwpoison_page() highly likely returns zero
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
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
> ChangeLog v2:
> - unpoison_memory() returns as commented
> - explicitly avoids unpoisoning slab pages
> - separates internal pinning function into __get_unpoison_page()
> ---
>  include/linux/mm.h         |   1 +
>  include/linux/page-flags.h |   4 ++
>  mm/memory-failure.c        | 104 ++++++++++++++++++++++++++++++-------
>  mm/page_alloc.c            |  23 ++++++++
>  4 files changed, 113 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 71d886470d71..c7ad3fdfee7c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3219,6 +3219,7 @@ enum mf_flags {
>         MF_ACTION_REQUIRED = 1 << 1,
>         MF_MUST_KILL = 1 << 2,
>         MF_SOFT_OFFLINE = 1 << 3,
> +       MF_UNPOISON = 1 << 4,
>  };
>  extern int memory_failure(unsigned long pfn, int flags);
>  extern void memory_failure_queue(unsigned long pfn, int flags);
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index b78f137acc62..8add006535f6 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -522,7 +522,11 @@ PAGEFLAG_FALSE(Uncached, uncached)
>  PAGEFLAG(HWPoison, hwpoison, PF_ANY)
>  TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
>  #define __PG_HWPOISON (1UL << PG_hwpoison)
> +#define MAGIC_HWPOISON 0x4857504f49534f4e
> +extern void SetPageHWPoisonTakenOff(struct page *page);
> +extern void ClearPageHWPoisonTakenOff(struct page *page);
>  extern bool take_page_off_buddy(struct page *page);
> +extern bool take_page_back_buddy(struct page *page);
>  #else
>  PAGEFLAG_FALSE(HWPoison, hwpoison)
>  #define __PG_HWPOISON 0
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 09f079987928..a6f80a670012 100644
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
> +       if (PageHWPoisonTakenOff(head))
> +               return -EHWPOISON;

I don't think we could see compound page here, but checking head page
might be confusing since private is per subpage, so it might be better
to use page instead of head.

> +
> +       return get_page_unless_zero(head) ? 1 : 0;
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
> @@ -1942,6 +1987,26 @@ core_initcall(memory_failure_init);
>                 pr_info(fmt, pfn);                      \
>  })
>
> +static inline int clear_page_hwpoison(struct ratelimit_state *rs, struct page *p)
> +{
> +       if (TestClearPageHWPoison(p)) {
> +               unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
> +                                page_to_pfn(p), rs);
> +               num_poisoned_pages_dec();
> +               return 0;
> +       }
> +       return -EBUSY;

I don't quite get why -EBUSY is returned. TestClear returns the old
value, so returning 0 means the flag was cleared before. It is fine,
right? I don't see why we have to return different values.

> +}
> +
> +static inline int unpoison_taken_off_page(struct ratelimit_state *rs,
> +                                         struct page *p)
> +{
> +       if (take_page_back_buddy(p) && !clear_page_hwpoison(rs, p))

If clear_page_hwpoison() is void, it can be moved into take_page_back_buddy().

> +               return 0;
> +       else
> +               return -EBUSY;
> +}
> +
>  /**
>   * unpoison_memory - Unpoison a previously poisoned page
>   * @pfn: Page number of the to be unpoisoned page
> @@ -1958,9 +2023,7 @@ int unpoison_memory(unsigned long pfn)
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
> @@ -1996,24 +2059,27 @@ int unpoison_memory(unsigned long pfn)
>                 goto unlock_mutex;
>         }
>
> -       if (!get_hwpoison_page(p, flags)) {
> -               if (TestClearPageHWPoison(p))
> -                       num_poisoned_pages_dec();
> -               unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
> -                                pfn, &unpoison_rs);
> +       if (PageSlab(page))
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
> +               ret = clear_page_hwpoison(&unpoison_rs, p);
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
> index 4ea590646f89..b6e4cbb44c54 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -9466,6 +9466,7 @@ bool take_page_off_buddy(struct page *page)
>                         del_page_from_free_list(page_head, zone, page_order);
>                         break_down_buddy_pages(zone, page_head, page, 0,
>                                                 page_order, migratetype);
> +                       SetPageHWPoisonTakenOff(page);
>                         if (!is_migrate_isolate(migratetype))
>                                 __mod_zone_freepage_state(zone, -1, migratetype);
>                         ret = true;
> @@ -9477,4 +9478,26 @@ bool take_page_off_buddy(struct page *page)
>         spin_unlock_irqrestore(&zone->lock, flags);
>         return ret;
>  }
> +
> +/*
> + * Cancel takeoff done by take_page_off_buddy().
> + */
> +bool take_page_back_buddy(struct page *page)

put_page_back_buddy() sounds more natural?

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
> +               ret = true;
> +       }
> +       spin_unlock_irqrestore(&zone->lock, flags);
> +
> +       return ret;
> +}
>  #endif
> --
> 2.25.1
>
>
>
> On Tue, Oct 26, 2021 at 08:04:59AM +0900, Naoya Horiguchi wrote:
> > Hi,
> >
> > I updated unpoison fix patchset (sorry for long blank time since v1).
> >
> > Main purpose of this series is to sync unpoison code to recent changes
> > around how hwpoison code takes page refcount.  Unpoison should work or
> > simply fail (without crash) if impossible.
> >
> > The recent works of keeping hwpoison pages in shmem pagecache introduce
> > a new state of hwpoisoned pages, but unpoison for such pages is not
> > supported yet with this series.
> >
> > It seems that soft-offline and unpoison can be used as general purpose
> > page offline/online mechanism (not in the context of memory error). I
> > think that we need some additional works to realize it because currently
> > soft-offline and unpoison are assumed not to happen so frequently
> > (print out too many messages for aggressive usecases). But anyway this
> > could be another interesting next topic.
> >
> > v1: https://lore.kernel.org/linux-mm/20210614021212.223326-1-nao.horiguchi@gmail.com/
> >
> > Thanks,
> > Naoya Horiguchi
> > ---
> > Summary:
> >
> > Naoya Horiguchi (4):
> >       mm/hwpoison: mf_mutex for soft offline and unpoison
> >       mm/hwpoison: remove race consideration
> >       mm/hwpoison: remove MF_MSG_BUDDY_2ND and MF_MSG_POISONED_HUGE
> >       mm/hwpoison: fix unpoison_memory()
> >
> >  include/linux/mm.h         |   3 +-
> >  include/linux/page-flags.h |   4 ++
> >  include/ras/ras_event.h    |   2 -
> >  mm/memory-failure.c        | 166 ++++++++++++++++++++++++++++-----------------
> >  mm/page_alloc.c            |  23 +++++++
> >  5 files changed, 130 insertions(+), 68 deletions(-)
>
> To:
> Cc:
> Bcc: nao.horiguchi@gmail.com
> Subject:
> Reply-To:
>
