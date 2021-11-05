Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD3944685B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 19:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhKES0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 14:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhKES0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 14:26:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432CFC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 11:24:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b15so16688072edd.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 11:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GRxn0JMjSx331eMdc46Cl3J9iqi8wXcpf71hHNMClSI=;
        b=gMxncrJYIzEWUSmC2Vxihm3mtIHSybTCQTcgD+HqvbAtbTsVPtW0+bvXhnEUtabJ+L
         2CHb8jQnyTsqiR3mcowujAi79jG1cfuc6f6GbjI/3ZyoT6+OUIkS2JPixJHXk4Qm6yRR
         +9BiyWyaD1fNojh4kYJoqvLJB7ryQ9GdoZyfIfp83Fy/5MzUkNHloLCLu1HhGCNFhEf4
         CKxJrjAUn7PkpMcQOwX6G240E5e4ZR/LVzimqdPz3NvA31ygIQgcw6Hu5rNOj6tNjqm0
         6mtlZSXHFnVzxHEgg+g6vRVq4zwkKeJu227E7vY9GK9TWDs7GCuY364TGseb8gTCpwpC
         E9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GRxn0JMjSx331eMdc46Cl3J9iqi8wXcpf71hHNMClSI=;
        b=DUIZQRGVGceNdARbyvIvH4DM3UTxKVQf6+CN0kWei2gGjsI/FO/Z9fvSysnAyY5TfW
         dK6vPdqKjtQAABlN98DVEfm9K2P10G+ksDoFfFI44u9rxswc2ggUuoACwo88Ps16qYh7
         uDAHbgdQyiOTrGjucVUrz1egi9YutFOgJ2tZXEPhD8sRLiNFhYn8gazgELXMhQ/Ub0Sm
         FpdvjcPMyUyZ5xcWMLI1p7I+k77dCL71hJS9+fMCpKdUxLYrdLJe5+lwRt4V9s7FYwFP
         O29ZulzlLvLhC8ZhbK50aYIBvd+KJ9Cinc0nq61CkaHxmA+REeFN8uuBTHokJnbzI3JU
         4dTw==
X-Gm-Message-State: AOAM532XQ18JSqnhs9gWfZkcopiaG0sGtwCv3nvBS0axejgS4I7HGmbp
        Y4yQBxBWxluny/npgg8Esr0rjaCJRTufCm+mkbU=
X-Google-Smtp-Source: ABdhPJxXw1zMHW+/GOi3DtAZN9HvvWSw78MAshex0BHFNL+eq32WosimuxDuk9SKmOVyAWHvk3T9j+S0/wn5yeDJlWg=
X-Received: by 2002:a17:906:a94b:: with SMTP id hh11mr75486317ejb.85.1636136638763;
 Fri, 05 Nov 2021 11:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211105055058.3152564-1-naoya.horiguchi@linux.dev> <20211105055058.3152564-2-naoya.horiguchi@linux.dev>
In-Reply-To: <20211105055058.3152564-2-naoya.horiguchi@linux.dev>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 5 Nov 2021 11:23:47 -0700
Message-ID: <CAHbLzkqrt-AiQ0C=DNJMwvA=wGVK4eSnOEdQWCV2hXEddec25A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm/hwpoison: mf_mutex for soft offline and unpoison
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

On Thu, Nov 4, 2021 at 10:52 PM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>
> Originally mf_mutex is introduced to serialize multiple MCE events, but
> it is not that useful to allow unpoison to run in parallel with memory_failure()
> and soft offline.  So apply mf_they to soft offline and unpoison.
                                            ^^^^^^^^
A typo? It should be mf_mutex, right?

Looks good to me other than the above nit. Reviewed-by: Yang Shi
<shy828301@gmail.com>

> The memory failure handler and soft offline handler get simpler with this.
>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
> ChangeLog v3:
> - merge with "mm/hwpoison: remove race consideration"
> - update description
>
> ChangeLog v2:
> - add mutex_unlock() in "page already poisoned" path in soft_offline_page().
>   (Thanks to Ding Hui)
> ---
>  mm/memory-failure.c | 62 +++++++++++++--------------------------------
>  1 file changed, 18 insertions(+), 44 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index e8c38e27b753..d29c79de6034 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1507,14 +1507,6 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>         lock_page(head);
>         page_flags = head->flags;
>
> -       if (!PageHWPoison(head)) {
> -               pr_err("Memory failure: %#lx: just unpoisoned\n", pfn);
> -               num_poisoned_pages_dec();
> -               unlock_page(head);
> -               put_page(head);
> -               return 0;
> -       }
> -
>         /*
>          * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
>          * simply disable it. In order to make it work properly, we need
> @@ -1628,6 +1620,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>         return rc;
>  }
>
> +static DEFINE_MUTEX(mf_mutex);
> +
>  /**
>   * memory_failure - Handle memory failure of a page.
>   * @pfn: Page Number of the corrupted page
> @@ -1654,7 +1648,6 @@ int memory_failure(unsigned long pfn, int flags)
>         int res = 0;
>         unsigned long page_flags;
>         bool retry = true;
> -       static DEFINE_MUTEX(mf_mutex);
>
>         if (!sysctl_memory_failure_recovery)
>                 panic("Memory failure on page %lx", pfn);
> @@ -1788,16 +1781,6 @@ int memory_failure(unsigned long pfn, int flags)
>          */
>         page_flags = p->flags;
>
> -       /*
> -        * unpoison always clear PG_hwpoison inside page lock
> -        */
> -       if (!PageHWPoison(p)) {
> -               pr_err("Memory failure: %#lx: just unpoisoned\n", pfn);
> -               num_poisoned_pages_dec();
> -               unlock_page(p);
> -               put_page(p);
> -               goto unlock_mutex;
> -       }
>         if (hwpoison_filter(p)) {
>                 if (TestClearPageHWPoison(p))
>                         num_poisoned_pages_dec();
> @@ -1978,6 +1961,7 @@ int unpoison_memory(unsigned long pfn)
>         struct page *page;
>         struct page *p;
>         int freeit = 0;
> +       int ret = 0;
>         unsigned long flags = 0;
>         static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
>                                         DEFAULT_RATELIMIT_BURST);
> @@ -1988,39 +1972,30 @@ int unpoison_memory(unsigned long pfn)
>         p = pfn_to_page(pfn);
>         page = compound_head(p);
>
> +       mutex_lock(&mf_mutex);
> +
>         if (!PageHWPoison(p)) {
>                 unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
>                                  pfn, &unpoison_rs);
> -               return 0;
> +               goto unlock_mutex;
>         }
>
>         if (page_count(page) > 1) {
>                 unpoison_pr_info("Unpoison: Someone grabs the hwpoison page %#lx\n",
>                                  pfn, &unpoison_rs);
> -               return 0;
> +               goto unlock_mutex;
>         }
>
>         if (page_mapped(page)) {
>                 unpoison_pr_info("Unpoison: Someone maps the hwpoison page %#lx\n",
>                                  pfn, &unpoison_rs);
> -               return 0;
> +               goto unlock_mutex;
>         }
>
>         if (page_mapping(page)) {
>                 unpoison_pr_info("Unpoison: the hwpoison page has non-NULL mapping %#lx\n",
>                                  pfn, &unpoison_rs);
> -               return 0;
> -       }
> -
> -       /*
> -        * unpoison_memory() can encounter thp only when the thp is being
> -        * worked by memory_failure() and the page lock is not held yet.
> -        * In such case, we yield to memory_failure() and make unpoison fail.
> -        */
> -       if (!PageHuge(page) && PageTransHuge(page)) {
> -               unpoison_pr_info("Unpoison: Memory failure is now running on %#lx\n",
> -                                pfn, &unpoison_rs);
> -               return 0;
> +               goto unlock_mutex;
>         }
>
>         if (!get_hwpoison_page(p, flags)) {
> @@ -2028,29 +2003,23 @@ int unpoison_memory(unsigned long pfn)
>                         num_poisoned_pages_dec();
>                 unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
>                                  pfn, &unpoison_rs);
> -               return 0;
> +               goto unlock_mutex;
>         }
>
> -       lock_page(page);
> -       /*
> -        * This test is racy because PG_hwpoison is set outside of page lock.
> -        * That's acceptable because that won't trigger kernel panic. Instead,
> -        * the PG_hwpoison page will be caught and isolated on the entrance to
> -        * the free buddy page pool.
> -        */
>         if (TestClearPageHWPoison(page)) {
>                 unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
>                                  pfn, &unpoison_rs);
>                 num_poisoned_pages_dec();
>                 freeit = 1;
>         }
> -       unlock_page(page);
>
>         put_page(page);
>         if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1))
>                 put_page(page);
>
> -       return 0;
> +unlock_mutex:
> +       mutex_unlock(&mf_mutex);
> +       return ret;
>  }
>  EXPORT_SYMBOL(unpoison_memory);
>
> @@ -2231,9 +2200,12 @@ int soft_offline_page(unsigned long pfn, int flags)
>                 return -EIO;
>         }
>
> +       mutex_lock(&mf_mutex);
> +
>         if (PageHWPoison(page)) {
>                 pr_info("%s: %#lx page already poisoned\n", __func__, pfn);
>                 put_ref_page(ref_page);
> +               mutex_unlock(&mf_mutex);
>                 return 0;
>         }
>
> @@ -2251,5 +2223,7 @@ int soft_offline_page(unsigned long pfn, int flags)
>                 }
>         }
>
> +       mutex_unlock(&mf_mutex);
> +
>         return ret;
>  }
> --
> 2.25.1
>
>
