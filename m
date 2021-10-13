Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51ADE42CD0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhJMVsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhJMVsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:48:19 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A9DC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:46:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y15so17942641lfk.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rUPiHKYI3IiGHt/c4QX+xoO8xtC6xojKkJlCXULl4So=;
        b=oAT8fjoxBlZc8GrTTmtA1uwkBPdy+udSVS2eT4Dy8Y4EZ9ys1gwAsfS1a90rPCHz7l
         c3bGuhJFzXZ9YrtwsQcHSmvFjQ5aY22W0l04mAwbWtv5wWpgRDwAkajRti9AdoeMULgi
         6LcTe5nVpC5XaxUb59ZLTlMOC7X5LitH11Exs5NI7OOeGyxxCasLXeggEA/uT7YWQeNp
         yCFfyFi6BjRH8g2vIa/7r7oY0qefqTCNABotM1SFV429zk7bXpYoglX1CXaxZSODHHa4
         hJs/DwEYxQG+DJO8Y0G70oN3P96WQgD4dMonc+lspAGUJucUhsf5+7+6DXwE/h+lY66i
         dWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rUPiHKYI3IiGHt/c4QX+xoO8xtC6xojKkJlCXULl4So=;
        b=4LlTPy99S7/r/5cxu92VHIcJlqlq6WpiaDz7d8ZJust70mPXYQObuqas3gpPy2XP5U
         JkgGJFJTSXErnNATmIoUxIiGzjbQX49oowUQr9CJvCiveFmnaX5m5M39EOd8tEF/2sWD
         8wNvfpNcCGRqPHjyE9iooU6BA0twLYtFtZVy+h7/hF13BqAjwg+tf7WMK6fCjNynKqZn
         4zqUgZuclie7xNxUE/3K/wGArCBV7BXv96OrYzDgktYB2Ws5OzXYY+SPyY9MwDNlzXzK
         EbgCXDVT6CIkzq9yBXcecAyCYg+MXa5vseKpGrCsfSSqJzHjKf+6NXILJ6VhBmJZGZPO
         6NjQ==
X-Gm-Message-State: AOAM53160HP3FppTVfLGv8FOM0Oz6rIURmS2fhba5KKU5+dukDb+V4+j
        pR6ggMtmLk05WMchEAerwjgMB+IRp2FTWnJsMOfUlA==
X-Google-Smtp-Source: ABdhPJzYms6VDxNHTH25y6Ve9ZEiVkyoTDg2NOKHPGX4etB6OuHBPtqSDrppQ/lQsLO+qDJnBVmyTJSatPF1JNA1FcU=
X-Received: by 2002:a05:6512:3b0a:: with SMTP id f10mr1512755lfv.8.1634161571450;
 Wed, 13 Oct 2021 14:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210928121040.2547407-1-chenwandun@huawei.com>
In-Reply-To: <20210928121040.2547407-1-chenwandun@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 13 Oct 2021 14:46:00 -0700
Message-ID: <CALvZod4G3SzP3kWxQYn0fj+VgG-G3yWXz=gz17+3N57ru1iajw@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: fix numa spreading for large hash tables
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, guohanjun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 5:03 AM Chen Wandun <chenwandun@huawei.com> wrote:
>
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
>  mm/vmalloc.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index f884706c5280..48e717626e94 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2823,6 +2823,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>                 unsigned int order, unsigned int nr_pages, struct page **pages)
>  {
>         unsigned int nr_allocated = 0;
> +       struct page *page;
> +       int i;
>
>         /*
>          * For order-0 pages we make use of bulk allocator, if
> @@ -2833,6 +2835,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>         if (!order) {

Can you please replace the above with if (!order && nid != NUMA_NO_NODE)?

>                 while (nr_allocated < nr_pages) {
>                         unsigned int nr, nr_pages_request;
> +                       page = NULL;
>
>                         /*
>                          * A maximum allowed request is hard-coded and is 100
> @@ -2842,9 +2845,23 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>                          */
>                         nr_pages_request = min(100U, nr_pages - nr_allocated);
>

Undo the following change in this if block.

> -                       nr = alloc_pages_bulk_array_node(gfp, nid,
> -                               nr_pages_request, pages + nr_allocated);
> -
> +                       if (nid == NUMA_NO_NODE) {
> +                               for (i = 0; i < nr_pages_request; i++) {
> +                                       page = alloc_page(gfp);
> +                                       if (page)
> +                                               pages[nr_allocated + i] = page;
> +                                       else {
> +                                               nr = i;
> +                                               break;
> +                                       }
> +                               }
> +                               if (i >= nr_pages_request)
> +                                       nr = nr_pages_request;
> +                       } else {
> +                               nr = alloc_pages_bulk_array_node(gfp, nid,
> +                                                       nr_pages_request,
> +                                                       pages + nr_allocated);
> +                       }
>                         nr_allocated += nr;
>                         cond_resched();
>
> @@ -2863,11 +2880,13 @@ vm_area_alloc_pages(gfp_t gfp, int nid,

Put the following line under "else if (order)"

>                 gfp |= __GFP_COMP;
>
>         /* High-order pages or fallback path if "bulk" fails. */
> -       while (nr_allocated < nr_pages) {

Keep the following declarations inside the while loop.

> -               struct page *page;
> -               int i;
>
> -               page = alloc_pages_node(nid, gfp, order);
> +       page = NULL;
> +       while (nr_allocated < nr_pages) {
> +               if (nid == NUMA_NO_NODE)
> +                       page = alloc_pages(gfp, order);
> +               else
> +                       page = alloc_pages_node(nid, gfp, order);
>                 if (unlikely(!page))
>                         break;
>
> --
> 2.25.1
>
