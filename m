Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3844E431F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 16:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhJROT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 10:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhJROTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:19:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90840C09426B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 07:05:54 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r18so71812916edv.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6UixV+EdomTwPpwLU4H+5Kh+2/hbrZPIG6cjBtiBusg=;
        b=MCIAtXvnQI30oJmdNR5cBsekek9W/8uNYyD6fDf8QxTZvvO4Fw3ov1ryDrmA4eoomj
         qHOF+qkymVv4YWNCUzfCFRr0f5BaUUyyzHAZmQ8RIwcwjjcjO7+bukagjlYJ76XaseAv
         RomhBIaD8VPkqkqT6wz4p40FZzHfpvr3XWlmHewEmkcS+FqNuva/7g+LiseCCs5ulhUH
         TQNVST1/keSQx+vldfGG//VJ2y1vFnFimWcf3B68wwdloiVZmKWx1NEu9EWDQIrE1VlH
         9VQFiNuFXiwvVGuTy+7lLteAjdnxgfC3xvQ+9SS2NmOJj36kKiULMfzucyCd5V/I3UyT
         nFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UixV+EdomTwPpwLU4H+5Kh+2/hbrZPIG6cjBtiBusg=;
        b=Ol6IZOx5l2w/hVB4BMzPbrwGKsld16KJ6838YvsE4E7uBrfIbRAQJo2n36cBwz/IaC
         DxygHIV8Evu8hBELSKZIedhe+iSBSekX0p/Aw7wELktal1wpu4Vb3yVxQ/zqVOeQ0qcC
         5zeOwjAssV73cACyyXrEdU2mhf4/lL0gvsVkjzcCi9ps0Yb4CIyNxVxhq82rAtVIETo3
         ASFS3I+d8q3V92WvW8XihHxVK1KCk61Y6oXsZGf4xCsiEuD1ZQ7SEOkji7ISMyFhBBAG
         XMuHS4VlWD5F5VuJvX7SZAe+8qyVa85ETbuTdCJNDW3lHP16fdrSrlXxfbxcKU8UhOSh
         WhnA==
X-Gm-Message-State: AOAM531rs+Xgq5sH+jFZztp21J/nazdGFbleyY3oJnQFlSIdZdIhsMtY
        OTYDqzZ9b57Wt2Hrpmm669L2NIdgst1mgqKMdfH0UkCosho=
X-Google-Smtp-Source: ABdhPJw/egDfBK7OLVjazvmdGX0qYDDzi//DgLoi75pycs6jKdhHN9O2O86JjGmU9mywoXPLjqMSyLsu5trSDQhFwZI=
X-Received: by 2002:a05:6402:22d6:: with SMTP id dm22mr45281085edb.209.1634565793970;
 Mon, 18 Oct 2021 07:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211018123710.1540996-1-chenwandun@huawei.com> <20211018123710.1540996-2-chenwandun@huawei.com>
In-Reply-To: <20211018123710.1540996-2-chenwandun@huawei.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Mon, 18 Oct 2021 16:03:02 +0200
Message-ID: <CA+KHdyWxEzqxQNXHjARB8=LtFXo2+Wbmcv+njAQdeGtDcmfw-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/vmalloc: fix numa spreading for large hash tables
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, guohanjun@huawei.com,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Eric Dumazet reported a strange numa spreading info in [1], and found
> commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings") introduced
> this issue [2].
>
> Dig into the difference before and after this patch, page allocation has
> some difference:
>
> before:
> alloc_large_system_hash
>     __vmalloc
>         __vmalloc_node(..., NUMA_NO_NODE, ...)
>             __vmalloc_node_range
>                 __vmalloc_area_node
>                     alloc_page /* because NUMA_NO_NODE, so choose alloc_page branch */
>                         alloc_pages_current
>                             alloc_page_interleave /* can be proved by print policy mode */
>
> after:
> alloc_large_system_hash
>     __vmalloc
>         __vmalloc_node(..., NUMA_NO_NODE, ...)
>             __vmalloc_node_range
>                 __vmalloc_area_node
>                     alloc_pages_node /* choose nid by nuam_mem_id() */
>                         __alloc_pages_node(nid, ....)
>
> So after commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings"),
> it will allocate memory in current node instead of interleaving allocate
> memory.
>
> [1]
> https://lore.kernel.org/linux-mm/CANn89iL6AAyWhfxdHO+jaT075iOa3XcYn9k6JJc7JR2XYn6k_Q@mail.gmail.com/
>
> [2]
> https://lore.kernel.org/linux-mm/CANn89iLofTR=AK-QOZY87RdUZENCZUT4O6a0hvhu3_EwRMerOg@mail.gmail.com/
>
> Fixes: 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  mm/vmalloc.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d77830ff604c..87552a4018aa 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2816,6 +2816,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>                 unsigned int order, unsigned int nr_pages, struct page **pages)
>  {
>         unsigned int nr_allocated = 0;
> +       struct page *page;
> +       int i;
>
>         /*
>          * For order-0 pages we make use of bulk allocator, if
> @@ -2823,7 +2825,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>          * to fails, fallback to a single page allocator that is
>          * more permissive.
>          */
> -       if (!order) {
> +       if (!order && nid != NUMA_NO_NODE) {
>                 while (nr_allocated < nr_pages) {
>                         unsigned int nr, nr_pages_request;
>
> @@ -2848,7 +2850,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>                         if (nr != nr_pages_request)
>                                 break;
>                 }
> -       } else
> +       } else if (order)
>                 /*
>                  * Compound pages required for remap_vmalloc_page if
>                  * high-order pages.
> @@ -2856,11 +2858,13 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>                 gfp |= __GFP_COMP;
>
>         /* High-order pages or fallback path if "bulk" fails. */
> -       while (nr_allocated < nr_pages) {
> -               struct page *page;
> -               int i;
>
> -               page = alloc_pages_node(nid, gfp, order);
> +       page = NULL;
>
Why do you need to set page to NULL here?

-- 
Vlad Rezki
