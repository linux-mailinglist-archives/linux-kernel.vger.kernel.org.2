Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5961443BEBA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbhJ0BGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbhJ0BGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:06:52 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF752C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:04:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g10so3764967edj.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDz/i6IyMh6CO7idWG+/4e+s/eK8ViVHThqmRp1kNZQ=;
        b=mNkUJb2Y99kLVttKo3d4dZoUgtl+5Bt0KuxH3ZXJ5Ynr10kVpkyfEU6mLZyxXYWXpv
         cuAaslsqOiCV8D5FZLWgY90IBoBAGKsTu1RQY64Q6bzq2HGA1qPNIEJsdawZePOl6SlK
         KVpx8DdcBaW2hM/DiQfGAs+87oE3Pg0bGs+8cAjZUs1/94/WlTpduAl0FXASThH8rr+R
         GBeJ07LbdDMbMc66i/KzYEUsiEcpNUzUqkjZA3mErsoPvw5LOQy+3t36la12qlH2Ifmr
         wpQz1HyYADWgEEsMNwIfBiwh/OkN1ZxkBZIkoV/N+SCKHwTaivvd45DqWwut1tb9aZGx
         tg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDz/i6IyMh6CO7idWG+/4e+s/eK8ViVHThqmRp1kNZQ=;
        b=3dgw1SUrpGUeY7R1ylc23dfgaPohZ0cjU7+ZRGgg3I5Oz9Ulyxttdy2FHoeiFvRhdu
         1NS8f7sGfMmZIydtlUqxiBtqADIdxdTayypNb/76ot8hcwMeMbOwolGV/IGhXRmUgovi
         aQzP8Bd9NXCHpjkaP4GiV65qVUutHHli341tX9iI4Tm3xmcutp6KzgMKam4Is23HfB9t
         Ox4J9vDsTP/tdSPJczIa7rqVOew5Q6a+gPx24zCnvGMLwOH1kikSt33fA7N/vU/+dnJM
         qkUI6ym/nnrsdxqM0aJG8Xw5jD5eAklAZkP0yHnwLajOXFOCWvm2JERh1Yflst3Kn6Id
         ffNg==
X-Gm-Message-State: AOAM533Ba28sNLyBDIK6iKJGLcRbQc6Knprm8XAruAwW2fKY30CB3qJB
        jmzdzKIBaWKsIRqU53A89BoR3KzTyDkLT01vmM8=
X-Google-Smtp-Source: ABdhPJwWMdtrUfTPamyfGICTc6BTJiO46PSUDvMyp5nAXWPvA1mvU1PY3Jf8sMoaPVusDJen1ABaQcfY69f9jdTVw4w=
X-Received: by 2002:a17:907:3f83:: with SMTP id hr3mr34783494ejc.555.1635296665941;
 Tue, 26 Oct 2021 18:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211025230503.2650970-1-naoya.horiguchi@linux.dev> <20211025230503.2650970-3-naoya.horiguchi@linux.dev>
In-Reply-To: <20211025230503.2650970-3-naoya.horiguchi@linux.dev>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 26 Oct 2021 18:04:13 -0700
Message-ID: <CAHbLzkrUb4YcnuXY9MYs+afRCFSfNdTmJAYyqHPxnqrEdFehhA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mm/hwpoison: remove race consideration
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

On Mon, Oct 25, 2021 at 4:06 PM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>
> Now memory_failure() and unpoison_memory() are protected by mf_mutex,
> so no need to explicitly check races between them.  So remove them.

It seems this patch could be folded into patch #1. Some "unlock_mutex"
were added by patch #1 then they were removed by this patch
immediately, it seems a bit of a waste and this patch is actually the
by-product of patch #1.

>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  mm/memory-failure.c | 37 -------------------------------------
>  1 file changed, 37 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 97297edfbd8e..a47b741ca04b 100644
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
> @@ -1789,16 +1781,6 @@ int memory_failure(unsigned long pfn, int flags)
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
> @@ -2016,17 +1998,6 @@ int unpoison_memory(unsigned long pfn)
>                 goto unlock_mutex;
>         }
>
> -       /*
> -        * unpoison_memory() can encounter thp only when the thp is being
> -        * worked by memory_failure() and the page lock is not held yet.
> -        * In such case, we yield to memory_failure() and make unpoison fail.
> -        */
> -       if (!PageHuge(page) && PageTransHuge(page)) {
> -               unpoison_pr_info("Unpoison: Memory failure is now running on %#lx\n",
> -                                pfn, &unpoison_rs);
> -               goto unlock_mutex;
> -       }
> -
>         if (!get_hwpoison_page(p, flags)) {
>                 if (TestClearPageHWPoison(p))
>                         num_poisoned_pages_dec();
> @@ -2035,20 +2006,12 @@ int unpoison_memory(unsigned long pfn)
>                 goto unlock_mutex;
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
> --
> 2.25.1
>
