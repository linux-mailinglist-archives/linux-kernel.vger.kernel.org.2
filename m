Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B03143C910
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 13:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbhJ0MB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbhJ0MB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:01:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C67C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 04:59:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t11so1811796plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 04:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NAF596Qj6efpmAkGxvXG/gMnt9KDRrv8LXG4QYDtD18=;
        b=Y9j0ASAEirN01ZlIYk5ExIAS3rEgGCnX9OZQjR4oxfDULRsMvdGPWeLBLh3aRUuxYT
         LTWNBL0G3nznDAyq9KliKAjoUiY+Diw3KSoVPsAiANViOhXl6lSTG7w0Z04dx6GDylEc
         5B5QuiR7je5VV0so8RcRJWM1RQ+IgWL0er+a/85mTc9EC7qYYFoby5LGVhtwp5tmB9Gq
         PeBnQKy9NPbAnaPHMiu84olvRlIJHOwCL4MNvYpFbUTTlCzz/3RMlD3E2rnTJkGWVdoX
         HLBxyq1XowOvx6gv2Gmvia0x5Oid3Y+CXjOGzQMx2oIAZCKgER9PP63wJKZaoqg/P5m5
         Wz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NAF596Qj6efpmAkGxvXG/gMnt9KDRrv8LXG4QYDtD18=;
        b=18skZKIEiNloD4CNNvjXMqUKladoMVjCrkmf5chEDIr6GhVcBcRVuF2Zfd/czKURx/
         5NneWobfoFGfLytMuhovb2/SudLtRpLGUvzSguVA+wNVXnlDO2ugtoyc03iz2QW+PGb6
         HkX4evL7j0Sqbk1PKQa1+S9PtF99irWCLZ/3uq/bL4lgT7tfcc05J9HIqpqoP3r0y5yl
         dnbdTczJ8Wf/lhANt4udz6sL9OBMgrpcEv6n/rzfgECFaBKuRW/dcWVBn57Qo+RA99n7
         XnDgimjtwO9+qe6O/O2kefTIgxGa+VxxO0Lr4iMUQfY0+pUMwryPMlImOh8M93nmZ48s
         U9dQ==
X-Gm-Message-State: AOAM532DCey4sEKjZqD4JHFDWox/IuKcl7J2ScIvBIf43Li3DX4rbzAu
        uhCN8TPQqo+qat9+KPMn4Q==
X-Google-Smtp-Source: ABdhPJwjpe5PCYauNnmKp/b3l1bhyXpF8xixysy6TBmTPE1IO4cUgbjwDTEL6PbJjWxt8Q07dMd+fQ==
X-Received: by 2002:a17:902:778a:b0:13f:672c:103a with SMTP id o10-20020a170902778a00b0013f672c103amr28307498pll.55.1635335942274;
        Wed, 27 Oct 2021 04:59:02 -0700 (PDT)
Received: from u2004 ([2407:c800:3f11:740:d516:6e06:7fb9:e4e7])
        by smtp.gmail.com with ESMTPSA id 17sm9170036pfp.14.2021.10.27.04.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 04:59:01 -0700 (PDT)
Date:   Wed, 27 Oct 2021 20:58:56 +0900
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Yang Shi <shy828301@gmail.com>
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
Subject: Re: [PATCH v2 4/4] mm/hwpoison: fix unpoison_memory()
Message-ID: <20211027115856.GA2717805@u2004>
References: <20211025230503.2650970-1-naoya.horiguchi@linux.dev>
 <20211025231618.GA2651507@u2004>
 <CAHbLzkp45EuAJnGoA7NtWPunW1QEb5GcY7eWm89ZKQfpsi_GkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkp45EuAJnGoA7NtWPunW1QEb5GcY7eWm89ZKQfpsi_GkA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 09:00:37PM -0700, Yang Shi wrote:
> On Mon, Oct 25, 2021 at 4:16 PM Naoya Horiguchi <nao.horiguchi@gmail.com> wrote:
> >
> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> >
> > After recent soft-offline rework, error pages can be taken off from
> > buddy allocator, but the existing unpoison_memory() does not properly
> > undo the operation.  Moreover, due to the recent change on
> > __get_hwpoison_page(), get_page_unless_zero() is hardly called for
> > hwpoisoned pages.  So __get_hwpoison_page() highly likely returns zero
> > (meaning to fail to grab page refcount) and unpoison just clears
> > PG_hwpoison without releasing a refcount.  That does not lead to a
> > critical issue like kernel panic, but unpoisoned pages never get back to
> > buddy (leaked permanently), which is not good.
> >
> > To (partially) fix this, we need to identify "taken off" pages from
> > other types of hwpoisoned pages.  We can't use refcount or page flags
> > for this purpose, so a pseudo flag is defined by hacking ->private
> > field.  Someone might think that put_page() is enough to cancel
> > taken-off pages, but the normal free path contains some operations not
> > suitable for the current purpose, and can fire VM_BUG_ON().
> >
> > Note that unpoison_memory() is now supposed to be cancel hwpoison events
> > injected only by madvise() or /sys/devices/system/memory/{hard,soft}_offline_page,
> > not by MCE injection, so please don't try to use unpoison when testing
> > with MCE injection.
> >
> > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > ---
> > ChangeLog v2:
> > - unpoison_memory() returns as commented
> > - explicitly avoids unpoisoning slab pages
> > - separates internal pinning function into __get_unpoison_page()
> > ---
...
> > @@ -1262,6 +1278,27 @@ static int get_any_page(struct page *p, unsigned long flags)
> >         return ret;
> >  }
> >
> > +static int __get_unpoison_page(struct page *page)
> > +{
> > +       struct page *head = compound_head(page);
> > +       int ret = 0;
> > +       bool hugetlb = false;
> > +
> > +       ret = get_hwpoison_huge_page(head, &hugetlb);
> > +       if (hugetlb)
> > +               return ret;
> > +
> > +       /*
> > +        * PageHWPoisonTakenOff pages are not only marked as PG_hwpoison,
> > +        * but also isolated from buddy freelist, so need to identify the
> > +        * state and have to cancel both operations to unpoison.
> > +        */
> > +       if (PageHWPoisonTakenOff(head))
> > +               return -EHWPOISON;
> 
> I don't think we could see compound page here, but checking head page
> might be confusing since private is per subpage, so it might be better
> to use page instead of head.

OK, I'll do this (and pass page to get_page_unless_zero() too).

> > +
> > +       return get_page_unless_zero(head) ? 1 : 0;
> > +}
> > +
> >  /**
> >   * get_hwpoison_page() - Get refcount for memory error handling
> >   * @p:         Raw error page (hit by memory error)
> > @@ -1278,18 +1315,26 @@ static int get_any_page(struct page *p, unsigned long flags)
> >   * extra care for the error page's state (as done in __get_hwpoison_page()),
> >   * and has some retry logic in get_any_page().
> >   *
> > + * When called from unpoison_memory(), the caller should already ensure that
> > + * the given page has PG_hwpoison. So it's never reused for other page
> > + * allocations, and __get_unpoison_page() never races with them.
> > + *
> >   * Return: 0 on failure,
> >   *         1 on success for in-use pages in a well-defined state,
> >   *         -EIO for pages on which we can not handle memory errors,
> >   *         -EBUSY when get_hwpoison_page() has raced with page lifecycle
> > - *         operations like allocation and free.
> > + *         operations like allocation and free,
> > + *         -EHWPOISON when the page is hwpoisoned and taken off from buddy.
> >   */
> >  static int get_hwpoison_page(struct page *p, unsigned long flags)
> >  {
> >         int ret;
> >
> >         zone_pcp_disable(page_zone(p));
> > -       ret = get_any_page(p, flags);
> > +       if (flags & MF_UNPOISON)
> > +               ret = __get_unpoison_page(p);
> > +       else
> > +               ret = get_any_page(p, flags);
> >         zone_pcp_enable(page_zone(p));
> >
> >         return ret;
> > @@ -1942,6 +1987,26 @@ core_initcall(memory_failure_init);
> >                 pr_info(fmt, pfn);                      \
> >  })
> >
> > +static inline int clear_page_hwpoison(struct ratelimit_state *rs, struct page *p)
> > +{
> > +       if (TestClearPageHWPoison(p)) {
> > +               unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
> > +                                page_to_pfn(p), rs);
> > +               num_poisoned_pages_dec();
> > +               return 0;
> > +       }
> > +       return -EBUSY;
> 
> I don't quite get why -EBUSY is returned. TestClear returns the old
> value, so returning 0 means the flag was cleared before. It is fine,
> right? I don't see why we have to return different values.

I think clear_page_hwpoison()'s return value is used in the path where
get_hwpoison_page(MF_UNPOISON) returns 1.  But as you mentioned -EBUSY might
not be a good return value.  And I noticed that freeit's semantics is wrongly
reversed, that's just a bug, so I'll fix it.

> 
> > +}
> > +
> > +static inline int unpoison_taken_off_page(struct ratelimit_state *rs,
> > +                                         struct page *p)
> > +{
> > +       if (take_page_back_buddy(p) && !clear_page_hwpoison(rs, p))
> 
> If clear_page_hwpoison() is void, it can be moved into take_page_back_buddy().
> 
> > +               return 0;
> > +       else
> > +               return -EBUSY;
> > +}
> > +
> >  /**
> >   * unpoison_memory - Unpoison a previously poisoned page
> >   * @pfn: Page number of the to be unpoisoned page
> > @@ -1958,9 +2023,7 @@ int unpoison_memory(unsigned long pfn)
> >  {
> >         struct page *page;
> >         struct page *p;
> > -       int freeit = 0;
> > -       int ret = 0;
> > -       unsigned long flags = 0;
> > +       int ret = -EBUSY;
> >         static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
> >                                         DEFAULT_RATELIMIT_BURST);
> >
> > @@ -1996,24 +2059,27 @@ int unpoison_memory(unsigned long pfn)
> >                 goto unlock_mutex;
> >         }
> >
> > -       if (!get_hwpoison_page(p, flags)) {
> > -               if (TestClearPageHWPoison(p))
> > -                       num_poisoned_pages_dec();
> > -               unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
> > -                                pfn, &unpoison_rs);
> > +       if (PageSlab(page))
> >                 goto unlock_mutex;
> > -       }
> >
> > -       if (TestClearPageHWPoison(page)) {
> > -               unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
> > -                                pfn, &unpoison_rs);
> > -               num_poisoned_pages_dec();
> > -               freeit = 1;
> > -       }
> > +       ret = get_hwpoison_page(p, MF_UNPOISON);
> > +       if (!ret) {
> > +               ret = clear_page_hwpoison(&unpoison_rs, p);
> > +       } else if (ret < 0) {
> > +               if (ret == -EHWPOISON) {
> > +                       ret = unpoison_taken_off_page(&unpoison_rs, p);
> > +               } else
> > +                       unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
> > +                                        pfn, &unpoison_rs);
> > +       } else {
> > +               int freeit = clear_page_hwpoison(&unpoison_rs, p);
> >
> > -       put_page(page);
> > -       if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1))
> >                 put_page(page);
> > +               if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1)) {
> > +                       put_page(page);
> > +                       ret = 0;
> > +               }
> > +       }
> >
> >  unlock_mutex:
> >         mutex_unlock(&mf_mutex);
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 4ea590646f89..b6e4cbb44c54 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -9466,6 +9466,7 @@ bool take_page_off_buddy(struct page *page)
> >                         del_page_from_free_list(page_head, zone, page_order);
> >                         break_down_buddy_pages(zone, page_head, page, 0,
> >                                                 page_order, migratetype);
> > +                       SetPageHWPoisonTakenOff(page);
> >                         if (!is_migrate_isolate(migratetype))
> >                                 __mod_zone_freepage_state(zone, -1, migratetype);
> >                         ret = true;
> > @@ -9477,4 +9478,26 @@ bool take_page_off_buddy(struct page *page)
> >         spin_unlock_irqrestore(&zone->lock, flags);
> >         return ret;
> >  }
> > +
> > +/*
> > + * Cancel takeoff done by take_page_off_buddy().
> > + */
> > +bool take_page_back_buddy(struct page *page)
> 
> put_page_back_buddy() sounds more natural?

Thanks for the suggestion, sounds nice, so I'll rename it.

Thanks,
Naoya Horiguchi
