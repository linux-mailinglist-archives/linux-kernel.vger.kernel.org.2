Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B858032DA3C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhCDTRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbhCDTRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:17:22 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F622C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 11:16:42 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f1so45112713lfu.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 11:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tEYLAkWXfIgfP7fN6enyTQ7KNootMuXnuOlaJWRoUXA=;
        b=fw5AHhTB8itnkvy4Aiuz4loWvAWlmpJISRhGT+ghjKbEtKJZXm8YMUxeRMtbstlbwE
         DeoeOI1Ktif8vGcdJn6SHavKP3yQKdt28xEl3PPPt6Mqb89FDZ79DFMbLl/tNVC7n3Ms
         2kJdpf7FOtKEQPIfZFVbQs84WJnWC0mdQkTieHoW/sVZdUIv+1RUTE5v4i+FqM6yDiGJ
         y360W4AVqnwEJUwTeSY9N7TG8cAySxyPinYNcn8pL+JdgG6YN9p6NGa0Pu5cdvgogiB1
         bgS9X0nHI7BVYZFZ+STxgBa5Bv1MTiQEj201CG/mTClJ6KzP5p1ZWoi80MWX6mcCB59W
         dVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tEYLAkWXfIgfP7fN6enyTQ7KNootMuXnuOlaJWRoUXA=;
        b=i3Pm31998CJ44aAY43A3VLpkS2RYDrMXx805+uEy6gjpyP5YYHMxeAEL77/HYGCg5A
         fphelCu5uGrsly0qSXb/wLcA3/GnYYIqaY2VYKHzwLweRdqtcAYMdYMfmGbq8G5BMLBk
         oFellIPzLviwIxHBDgut+WYbnX29ztZXxfD1BQ9rCByslv23JTATCjQT1l49cL1ltZ35
         j7k1CEcOv1oFXeoY2JJfVbolkCfvS4s0u5alR4aOTcmNzPxVMKAmpkR6BrsN8sFQCCx2
         eFvQZJBbrCvqsUUGTUxJdwVcCKIzQx8TLru4bMMDNltfDOC1hxvnCbqNFbmIkUywcQd4
         L9/Q==
X-Gm-Message-State: AOAM531MpL1pQv/JOxw+1JFOflg/7ttYsqXAbO0mvN7Qy1DlfaAclrhw
        J86tbI+SCtkX8WNiiDYNTF3E7SCUZRV60Hnzjtkvgg==
X-Google-Smtp-Source: ABdhPJwafySaTxpVVmraTNMlT31arSMhfCTtnApPjOPWQxgFm/aeI3IuzlZ+f+2JO8XPnMABoHPLrlh3E0KzoXIB3KY=
X-Received: by 2002:a05:6512:547:: with SMTP id h7mr3170339lfl.529.1614885401016;
 Thu, 04 Mar 2021 11:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20210211023324.2331377-1-minchan@kernel.org>
In-Reply-To: <20210211023324.2331377-1-minchan@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 4 Mar 2021 11:16:29 -0800
Message-ID: <CALAqxLXHv3hxxDsAeJHJJnfCTmUNKDzAqLkwt7UkYN4qPuk1BA@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: system_heap: do not warn for costly allocation
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

On Wed, Feb 10, 2021 at 6:33 PM Minchan Kim <minchan@kernel.org> wrote:
>
> Dmabuf system_heap allocation logic starts with the highest necessary
> allocation order before falling back to lower orders. The requested
> order can be higher than PAGE_ALLOC_COSTLY_ODER and failures to
> allocate will flood dmesg with warnings. Such high-order allocations
> are not unexpected and are handled by the system_heap's allocation
> fallback mechanism.
> Prevent these warnings when allocating higher than
> PAGE_ALLOC_COSTLY_ODER pages using __GFP_NOWARN flag.
>
> Below is ION warning example I got but dmabuf system heap is nothing different:
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
> * from v1 - https://lore.kernel.org/lkml/20210210162632.3903128-1-minchan@kernel.org/
>  * better description - surenb
>  * use mid_order_gfp - john.stultz
>
>  drivers/dma-buf/heaps/system_heap.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> index 29e49ac17251..e5f545ada587 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -40,11 +40,16 @@ struct dma_heap_attachment {
>         bool mapped;
>  };
>
> +#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
> +/*
> + * Avoid warning on order-4 allocation failures as we'll fall back to
> + * order-0 in that case.
> + */
> +#define MID_ORDER_GFP (LOW_ORDER_GFP | __GFP_NOWARN)
>  #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
>                                 | __GFP_NORETRY) & ~__GFP_RECLAIM) \
>                                 | __GFP_COMP)
> -#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
> -static gfp_t order_flags[] = {HIGH_ORDER_GFP, LOW_ORDER_GFP, LOW_ORDER_GFP};
> +static gfp_t order_flags[] = {HIGH_ORDER_GFP, MID_ORDER_GFP, LOW_ORDER_GFP};
>  /*
>   * The selection of the orders used for allocation (1MB, 64K, 4K) is designed
>   * to match with the sizes often found in IOMMUs. Using order 4 pages instead

This looks good to me! Thanks for sending this and apologies for the
slow reply, the patch slipped by me!

Reviewed-by: John Stultz <john.stultz@linaro.org>

thanks again!
-john
