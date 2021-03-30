Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADE434DE48
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhC3CX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhC3CXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:23:49 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACFCC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:23:49 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s11so5053996pfm.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAIOBI91GIjhBKpgI+rdVaxFSeQVs/G0EM+EoZHgFTE=;
        b=BmLvV/nXtFfho2FL4lVqaHewg4+5aNgECKztHtZwCfix7jBIAEIq+nfOtWpq1fKZSG
         IKTQDit67QWiwJNHBmYsgR0sFWQ4gq1n2wGX7tUqjRjEgENzWVDPts6ev7VRXLhVbOzw
         wL4Y4eWmYIGWlt/k/cnlnnApeOaswQXU5FYkgYarnO+RtrQoJEqLLdt8F/Uu1CFMz40t
         YzWeNg2UaYYxypVt29sSl7zVuXIw9jynpYdN13T4t9r5Y8i/CkoJx4CAnLaedURxEwSP
         w6lHqb24SmcdaXbqnitHuiKiHknZgPI9PSjqu7S8rjAKJtjNSR6gbPdI6wkwYWyZNtkk
         z/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAIOBI91GIjhBKpgI+rdVaxFSeQVs/G0EM+EoZHgFTE=;
        b=dCC9SuTCbYBct+u0mY6HmdilHkryWcswntYve2w+pd6stCgEf0VQepQLXNyxxjp06T
         nMGEXVdlD5b1ACZc/QPjfDhJjNlHZxVuWOzXfn3zTh5FeiBcgUdNVonR0d5Z3E8/X4T3
         hjH3I+9aqx67UAygLdCj76673oW9KCy+MjnxguOX7HDHMYGtB3vBvIDD7Fk2MGsK35st
         l5oI30+kuvcuS67nVXXbHzBim0yejK4pTICvDPppg1i26XiBEmjenig+/sPnrLPZWdUo
         3PsrUjyFTvz/iZMKAwPETSDikWpoWLtdbZyecygVW8qstWmb3mQWTDI6HEV3hhA7Sgl+
         O4Bw==
X-Gm-Message-State: AOAM530BQDcJSIBes+s3xyQOI+0P3Ikypyms92qXD9TlECnXfFnxTtQL
        Zz0/MTo1Tjx67W8gw5W0wfgSiA/xlQYqfhi1XfNPUA==
X-Google-Smtp-Source: ABdhPJxHzsRLCIMXLRRp9B1Lu8XCKiV2CpZk+zsudnBKbf2GMr2bBl2MiZhgT9WpDlDFlgj2Fwd8pGXFvc7jQXk1Yrc=
X-Received: by 2002:aa7:9614:0:b029:1fa:e77b:722 with SMTP id
 q20-20020aa796140000b02901fae77b0722mr28875702pfg.2.1617071029158; Mon, 29
 Mar 2021 19:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210329232402.575396-1-mike.kravetz@oracle.com> <20210329232402.575396-4-mike.kravetz@oracle.com>
In-Reply-To: <20210329232402.575396-4-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 30 Mar 2021 10:23:12 +0800
Message-ID: <CAMZfGtUKt+PDZ8CvM7BMFcYDa76rMhf-0gCD+bEDhyUqjBmtSQ@mail.gmail.com>
Subject: Re: [External] [PATCH v2 3/8] hugetlb: add per-hstate mutex to
 synchronize user adjustments
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 7:24 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> The helper routine hstate_next_node_to_alloc accesses and modifies the
> hstate variable next_nid_to_alloc.  The helper is used by the routines
> alloc_pool_huge_page and adjust_pool_surplus.  adjust_pool_surplus is
> called with hugetlb_lock held.  However, alloc_pool_huge_page can not
> be called with the hugetlb lock held as it will call the page allocator.
> Two instances of alloc_pool_huge_page could be run in parallel or
> alloc_pool_huge_page could run in parallel with adjust_pool_surplus
> which may result in the variable next_nid_to_alloc becoming invalid
> for the caller and pages being allocated on the wrong node.
>
> Both alloc_pool_huge_page and adjust_pool_surplus are only called from
> the routine set_max_huge_pages after boot.  set_max_huge_pages is only
> called as the reusult of a user writing to the proc/sysfs nr_hugepages,
> or nr_hugepages_mempolicy file to adjust the number of hugetlb pages.
>
> It makes little sense to allow multiple adjustment to the number of
> hugetlb pages in parallel.  Add a mutex to the hstate and use it to only
> allow one hugetlb page adjustment at a time.  This will synchronize
> modifications to the next_nid_to_alloc variable.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks Mike.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/hugetlb.h | 1 +
>  mm/hugetlb.c            | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index d9b78e82652f..b92f25ccef58 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -566,6 +566,7 @@ HPAGEFLAG(Freed, freed)
>  #define HSTATE_NAME_LEN 32
>  /* Defines one hugetlb page size */
>  struct hstate {
> +       struct mutex resize_lock;
>         int next_nid_to_alloc;
>         int next_nid_to_free;
>         unsigned int order;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1d62f0492e7b..8497a3598c86 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2730,6 +2730,11 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>         else
>                 return -ENOMEM;
>
> +       /*
> +        * resize_lock mutex prevents concurrent adjustments to number of
> +        * pages in hstate via the proc/sysfs interfaces.
> +        */
> +       mutex_lock(&h->resize_lock);
>         spin_lock(&hugetlb_lock);
>
>         /*
> @@ -2762,6 +2767,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>         if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
>                 if (count > persistent_huge_pages(h)) {
>                         spin_unlock(&hugetlb_lock);
> +                       mutex_unlock(&h->resize_lock);
>                         NODEMASK_FREE(node_alloc_noretry);
>                         return -EINVAL;
>                 }
> @@ -2836,6 +2842,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  out:
>         h->max_huge_pages = persistent_huge_pages(h);
>         spin_unlock(&hugetlb_lock);
> +       mutex_unlock(&h->resize_lock);
>
>         NODEMASK_FREE(node_alloc_noretry);
>
> @@ -3323,6 +3330,7 @@ void __init hugetlb_add_hstate(unsigned int order)
>         BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
>         BUG_ON(order == 0);
>         h = &hstates[hugetlb_max_hstate++];
> +       mutex_init(&h->resize_lock);
>         h->order = order;
>         h->mask = ~(huge_page_size(h) - 1);
>         for (i = 0; i < MAX_NUMNODES; ++i)
> --
> 2.30.2
>
