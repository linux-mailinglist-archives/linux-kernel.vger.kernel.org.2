Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76ED6316C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhBJRZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhBJRZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:25:46 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA01C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:25:05 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id w4so2438333wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMfMjppoZfEVvtLv1UjCh52UgsLFnMc2zt65mnUeFkA=;
        b=e33T+RDsooAMSM3Jfaf8wNDOi/Z29x5VRUaQSBPLjtCvgOqA33QRZhOwEkULQwA/UM
         oha1KWgkY8ryGVjziEj6X9PK6i8S951Efy4q+plRGbSfwXNo1W5iE4Lz+RktCtahiM6n
         SfkjuulQsVL0mOWqVeB9c/68ei9DMOPmY7OBA3osT7B0eO8bJPKQHvRdumsGIKWiFAkx
         xlMhdrRrWkRC4iGW80Nz0j7DeUvwKgDGzTdZnmmvwa2/4AnOzG6lS1B2yh1gS/yKFKYp
         wPCiWYT+kT3UB3fD74eqabgplvtatx61YZk2xJmPUklZVRFe5QDwDUDk2A6SYwbnp8TO
         /1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMfMjppoZfEVvtLv1UjCh52UgsLFnMc2zt65mnUeFkA=;
        b=YUfcubkM50Qo9AlvDyBXasfid3IzrzL84C0MysvpCivTThHuPC1CWDlOMdH6J2A1Wy
         /Lr/fpFLbqGYNJTq0lY8bJULpF79IWkpG8LAlYrklk66gjUMb7hnP6BWVvA02zUeM6K0
         gV914fc+6emTEm+1iV6nFGXnfq1rdfjuuO8z+cktC/XLSxPCUOIqxn1jxaEnd96bbpHW
         +AwGJ4t7QxH95nE2b1MQgtK0BR2s7QqSgU3yYhQc/+COxb/CSvrEiO1N8qEuv9+j6bSa
         yEvdYAeN7CopIvO+PF4X8Gp2Zog4Rn5GQ9mLxcXOfv2OF7rlB/eMccBO/n/h5h+1iqqT
         FHVA==
X-Gm-Message-State: AOAM533PKBNg60D6wvWewopViqI4FEfYb1SCpRgMIE+SAwz9ZiCj7IBR
        EJ3LeuFg5hTA3J4TPjB7TFU1o88z2aGk2nAuEg1AFPWn5rv3ZA==
X-Google-Smtp-Source: ABdhPJxQ9zIAz+vs3dHMgAs0m9SIypMm+4RhH1L6cHXok5+VA8usBew7hNEaulYXL5xHpfJF3XZAwuZK2ZDGDuNWWOw=
X-Received: by 2002:a1c:acc9:: with SMTP id v192mr3781736wme.22.1612977904192;
 Wed, 10 Feb 2021 09:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20210210162632.3903128-1-minchan@kernel.org>
In-Reply-To: <20210210162632.3903128-1-minchan@kernel.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 10 Feb 2021 09:24:52 -0800
Message-ID: <CAJuCfpER=nbfY93CPf3Lz+bJcvAN8Vuqy6ZWZg12HnRGvznm+A@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: system_heap: do not warn for costly allocation
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        John Dias <joaodias@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code looks fine to me. Description needs a bit polishing :)

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

Suggestion:
Dmabuf system_heap allocation logic starts with the highest necessary
allocation order before falling back to lower orders. The requested
order can be higher than PAGE_ALLOC_COSTLY_ODER and failures to
allocate will flood dmesg with warnings. Such high-order allocations
are not unexpected and are handled by the system_heap's allocation
fallback mechanism.
Prevent these warnings when allocating higher than
PAGE_ALLOC_COSTLY_ODER pages using __GFP_NOWARN flag.

Below is ION warning example I got but dmabuf system heap is nothing different:

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
>                 if (!page)
>                         continue;
>                 return page;
> --
> 2.30.0.478.g8a0d178c01-goog
>
