Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D2736CD0B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 22:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbhD0UsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 16:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239141AbhD0Urk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:47:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F41C06138B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 13:46:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u21so91404933ejo.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 13:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N7anHoC9geqIkxnuhdLcMLt4gZDNLzLFNeoRehcS0eM=;
        b=VGtpo6qcu9pwPNSpCONhtfXzC1L4N3ADxE8GLhYafQrTehJfXYTbV/mVQF1uo8bCHd
         7qdI4XOn9t1qBaG9UN+htWrWmQkEEn5BpVHxmdm9cU+52a63OBb62IeUjMOyH/new9yy
         +E9DgX96XW4QOXIh8k6jJJMYqTS51fpyK2cWJpiDLKeJUQEmWSvOo2mbuRUHArQ2zmwz
         /iodnOSZ4X9lEnAlRvl+dZYttq3OyeXJH0k7irNum+AFbUN8q+arGPVMdqylpEfL5xD0
         C2LrPTIxj1BaQLHteLZ8VUMfLAMAgwc0mAHJQnjmoDUzrNsMFu8tElVJf8w8OhK+zMzN
         bcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7anHoC9geqIkxnuhdLcMLt4gZDNLzLFNeoRehcS0eM=;
        b=dY2wNdQwxmrrqgaeeRr6IPRegGH7CDKLobi9Fs33RFhtKHCmG8as0lHWnZqyz5eCFY
         Cz5Dn0CZNqsm/nDWyMRTFzXwAakATJRnsi5sDcydDW3gtc4n9rH2inoCLIs65IFXadn1
         oQ5X3e6f3Eb/qXYP+Ke8TdWdQ1Vjc2iYe3Du+SHyP5gKNBW3SdHeDhWf9RdPml8x/vs2
         gJdK8w2N79DphNxuqcTkr0K6IjzEV6NhJp0o/pCQw7ca6HrX7kVvbsklyKIXUEMyAL6q
         3sFqo2v5m26ZvT36K4PE7EqgLu7ZnzfX2tVsmUfMpa5iziil77IgXPu0aC0q8qchFnLC
         NKfg==
X-Gm-Message-State: AOAM532+zrCyglPMaYQVrfWy4Kf1XOp4tZlL4g32i7veJvXW34RMgw0m
        4o8WMgNpKDyKNWsJ+QNpiJ+qZ+JhPRRYYBzWUeSL/60sjsg=
X-Google-Smtp-Source: ABdhPJxXo2gK1QGVsMN3JZqRTR6rlQ4Uj9PKOZ1UWnsXGw4hbPccVrX2oBup0LddQn8xy3zYV6h7JlOmwcpwbjmdj7M=
X-Received: by 2002:a17:906:3b13:: with SMTP id g19mr14421196ejf.238.1619556394715;
 Tue, 27 Apr 2021 13:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210427133214.2270207-1-linmiaohe@huawei.com> <20210427133214.2270207-3-linmiaohe@huawei.com>
In-Reply-To: <20210427133214.2270207-3-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 27 Apr 2021 13:46:23 -0700
Message-ID: <CAHbLzkp4ggaFo_6Ot9Uu+2fF0md63HDY+m8U7m9ZAN-yS-N+yQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/huge_memory.c: use page->deferred_list
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        william.kucharski@oracle.com, Matthew Wilcox <willy@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        aneesh.kumar@linux.ibm.com, Ralph Campbell <rcampbell@nvidia.com>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 6:32 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Now that we can represent the location of ->deferred_list instead of
> ->mapping + ->index, make use of it to improve readability.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 63ed6b25deaa..76ca1eb2a223 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2868,7 +2868,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>         /* Take pin on all head pages to avoid freeing them under us */
>         list_for_each_safe(pos, next, &ds_queue->split_queue) {
> -               page = list_entry((void *)pos, struct page, mapping);
> +               page = list_entry((void *)pos, struct page, deferred_list);
>                 page = compound_head(page);
>                 if (get_page_unless_zero(page)) {
>                         list_move(page_deferred_list(page), &list);
> @@ -2883,7 +2883,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>
>         list_for_each_safe(pos, next, &list) {
> -               page = list_entry((void *)pos, struct page, mapping);
> +               page = list_entry((void *)pos, struct page, deferred_list);
>                 if (!trylock_page(page))
>                         goto next;
>                 /* split_huge_page() removes page from list on success */
> --
> 2.23.0
>
>
