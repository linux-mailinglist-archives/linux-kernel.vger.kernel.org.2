Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62917316CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhBJRgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhBJRdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:33:03 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E3BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:32:22 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p21so4015751lfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EzR3RKneYKSWiiWyad5VBkY/1CELRsyGqG1y+v7sb8Y=;
        b=vlwiD0hJFfwqF3kbno47a0ujL8az+y6CsI7aqWEk7OFgo5MJSGwxqeZK2V0lkXI5JN
         s/dVF4zPbc2emIsRgdyCIEZfTZgA5zWP1A5CZaEw5R3TVRvS/m+P/Chz7ZNKPBa1dl0/
         JgzfQfoLgZTI0KJpaKNxLwYbPhMjbEPAYZh/c9hltVZ+4ViCiiFrd6ML7KC0UmfPjyQA
         1f3YQKKrZ8q75KAQXjkTzmf/DdTe2TzBwA30dEmg90/nLA+4KL/nEOGwq0fkVC4aq3+D
         L1VGHmXJu+SCz72W/EKx21TBA3qKtiO4GTuon7zYvE8bZ0fAjLnkkQEdXWM6ryhriVAZ
         y1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EzR3RKneYKSWiiWyad5VBkY/1CELRsyGqG1y+v7sb8Y=;
        b=TO6amrzc6qFDXyFc20Fk5u1loBRpimsc7Dn3RY5IvnE2VFeINDQRrC9tqwZb92Dh9/
         wQEGdewDKqT6/BuEFndAnPe8RozG/C5hIWrM+W3BeZgaYf3ztC8rGj4gVtRwnx1Pj6y4
         0r4hKLgTBeBCT8rrs/6w3uAOeX6zKdA8MTip2nU5XI7Znzy2eHO4vueTRFy1vXw1Vbzb
         vajtuhRk+zMrVdrWyPTThgDo7kjAwdaU9Gm/p7+9t2y16PKPw/E9hBWtQZyR1JR9RivX
         a72I3V0aqXiKKmJW30GmiB51zVQubXtKSzItPdNi49A1JJ6YV+aC6xqkG18td34XNeSH
         vUYw==
X-Gm-Message-State: AOAM530eLJxKpIli4NBk6X7aK5n/Gmf57fYoLlZ9dN+iMttnfrJg4bO/
        CirjDJU7lGH9+3MWwSGKAo+kK5LWhAJ+TaxooqVndg==
X-Google-Smtp-Source: ABdhPJziYXldWzLWofd/jWFQpmwotcgnz6w+1lH9Lz2U6xpT2p0TR0LSV/pOKu2uWwxGTC8z9fD3i6ZXrYO14X/dllo=
X-Received: by 2002:a19:9c5:: with SMTP id 188mr2106747lfj.626.1612978341098;
 Wed, 10 Feb 2021 09:32:21 -0800 (PST)
MIME-Version: 1.0
References: <20210210162632.3903128-1-minchan@kernel.org>
In-Reply-To: <20210210162632.3903128-1-minchan@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 10 Feb 2021 09:32:09 -0800
Message-ID: <CALAqxLXzc3tfsr0hA6GS-zHjupWx++Bhcrs2pjbz00LNKeThOQ@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: system_heap: do not warn for costly allocation
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        John Dias <joaodias@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 8:26 AM Minchan Kim <minchan@kernel.org> wrote:
>
> Linux VM is not hard to support PAGE_ALLOC_COSTLY_ODER allocation
> so normally expects driver passes __GFP_NOWARN in that case
> if they has fallback options.
>
> system_heap in dmabuf is the case so do not flood into demsg
> with the warning for recording more precious information logs.
> (below is ION warning example I got but dmabuf system heap is
> nothing different).
>
> [ 1233.911533][  T460] warn_alloc: 11 callbacks suppressed
> [ 1233.911539][  T460] allocator@2.0-s: page allocation failure: order:4, mode:0x140dc2(GFP_HIGHUSER|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
> [ 1233.926235][  T460] Call trace:
> [ 1233.929370][  T460]  dump_backtrace+0x0/0x1d8
> [ 1233.933704][  T460]  show_stack+0x18/0x24
> [ 1233.937701][  T460]  dump_stack+0xc0/0x140
> [ 1233.941783][  T460]  warn_alloc+0xf4/0x148
> [ 1233.945862][  T460]  __alloc_pages_slowpath+0x9fc/0xa10
> [ 1233.951101][  T460]  __alloc_pages_nodemask+0x278/0x2c0
> [ 1233.956285][  T460]  ion_page_pool_alloc+0xd8/0x100
> [ 1233.961144][  T460]  ion_system_heap_allocate+0xbc/0x2f0
> [ 1233.966440][  T460]  ion_buffer_create+0x68/0x274
> [ 1233.971130][  T460]  ion_buffer_alloc+0x8c/0x110
> [ 1233.975733][  T460]  ion_dmabuf_alloc+0x44/0xe8
> [ 1233.980248][  T460]  ion_ioctl+0x100/0x320
> [ 1233.984332][  T460]  __arm64_sys_ioctl+0x90/0xc8
> [ 1233.988934][  T460]  el0_svc_common+0x9c/0x168
> [ 1233.993360][  T460]  do_el0_svc+0x1c/0x28
> [ 1233.997358][  T460]  el0_sync_handler+0xd8/0x250
> [ 1234.001989][  T460]  el0_sync+0x148/0x180
>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  drivers/dma-buf/heaps/system_heap.c | 9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> index 29e49ac17251..33c25a5e06f9 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -40,7 +40,7 @@ struct dma_heap_attachment {
>         bool mapped;
>  };
>
> -#define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
> +#define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO \
>                                 | __GFP_NORETRY) & ~__GFP_RECLAIM) \
>                                 | __GFP_COMP)
>  #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
> @@ -315,6 +315,7 @@ static struct page *alloc_largest_available(unsigned long size,
>                                             unsigned int max_order)
>  {
>         struct page *page;
> +       unsigned long gfp_flags;
>         int i;
>
>         for (i = 0; i < NUM_ORDERS; i++) {
> @@ -323,7 +324,11 @@ static struct page *alloc_largest_available(unsigned long size,
>                 if (max_order < orders[i])
>                         continue;
>
> -               page = alloc_pages(order_flags[i], orders[i]);
> +               gfp_flags = order_flags[i];
> +               if (orders[i] > PAGE_ALLOC_COSTLY_ORDER)
> +                       gfp_flags |= __GFP_NOWARN;
> +
> +               page = alloc_pages(gfp_flags, orders[i]);

Would it be cleaner to just set up the flags properly in the
order_flags array? I'm not sure I understand why your patch does it
dynamically?

thanks
-john
