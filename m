Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70179317287
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhBJVlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhBJVk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:40:56 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECF6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:40:16 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f1so5153052lfu.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t3rOxORmTTCbIAKBE30ARmmobyqtgzrjYpNHhtkidOE=;
        b=z2RUQyCoEFbR6ar1QCQ4MrUppPpfYruz2FfwmwWxgDNDqVjz0v4pOeV7c9GtKfTSlh
         BkJmwRqO97qKTL6KiMTyNKBwROvtAbJcrR2wR+TKCsdqh2/ZcLuZK0X0LZgMP4yiKPHk
         nTM+LE3lxJk0mCTNbV6ea145CugmD1VjnpJTejkrHOhByohqzhxJ8su0rR38+L+vi4cy
         5WU6jHeeRL9L7E2opNwF/2UxBNnLuDY3HwylaoWFo88DtOhqMehztH0DmiyxFffTFxiW
         8Bi33TMxwPl7kJi9gG8Mga6t+BwB4im1t16MBUFLIzqGnzCTizrSCO84EYvaF1e7a6/f
         ezdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t3rOxORmTTCbIAKBE30ARmmobyqtgzrjYpNHhtkidOE=;
        b=WDVjuyYCd6azaMSR7o+pGowmNDC3kxZAOH+7+yCDfvJCOGbdsUmaUsxteGIU9yk8zP
         R/7Pa+3ySXA6+nVNRynrBtEiCx5qcveg8R0OYrlurZLZ2bhdY6nMF1SVKvPXnVNlZm96
         DdoBjy2e0aNpg+q6bfZSmxNFaDrblQB+9qOX5raHmjf0sCbyOWTFgza3LZ1HAxWs/vAH
         shOcSz8xdwCCQ71wogylywISm7/EHMkKBzudq8ccT12Ys35LtTL4ZzByOBZ8ZYwmFG1l
         BbLxQ0v5djdP1f0Fz0FNOsPCavc/mdI92r0ccFUNQ24dtu0wOMdhUbVoqfai/AXrq8dg
         w9tA==
X-Gm-Message-State: AOAM531YSbss/Prva6lcs8Vn8EIyx+nyEiqEIFahj7QVs0eO07yVIgBG
        pq/Gy/Dcc1L5ScU6k/CvcnQiNbacjqb0WXzkx47P9Rvcwhlp2g==
X-Google-Smtp-Source: ABdhPJxHKOlZvw1uNHBu1LiQCG7sqj6bBQIAgOsJ/ZeT5hM2cc4YoGFZFtU/UXFQlpAYtWMUstHwLqvdWVrmSF8AXjc=
X-Received: by 2002:a19:7603:: with SMTP id c3mr2683294lff.508.1612993214315;
 Wed, 10 Feb 2021 13:40:14 -0800 (PST)
MIME-Version: 1.0
References: <20210210162632.3903128-1-minchan@kernel.org> <CALAqxLXzc3tfsr0hA6GS-zHjupWx++Bhcrs2pjbz00LNKeThOQ@mail.gmail.com>
 <YCQcfYRQ3eW+QiMz@google.com>
In-Reply-To: <YCQcfYRQ3eW+QiMz@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 10 Feb 2021 13:40:02 -0800
Message-ID: <CALAqxLUaiOOrC6kWYSj1yg6qed32rQhfN4k99HNgn_=0kpFRJw@mail.gmail.com>
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

On Wed, Feb 10, 2021 at 9:48 AM Minchan Kim <minchan@kernel.org> wrote:
>
> On Wed, Feb 10, 2021 at 09:32:09AM -0800, John Stultz wrote:
> > On Wed, Feb 10, 2021 at 8:26 AM Minchan Kim <minchan@kernel.org> wrote:
> > >
> > > Linux VM is not hard to support PAGE_ALLOC_COSTLY_ODER allocation
> > > so normally expects driver passes __GFP_NOWARN in that case
> > > if they has fallback options.
> > >
> > > system_heap in dmabuf is the case so do not flood into demsg
> > > with the warning for recording more precious information logs.
> > > (below is ION warning example I got but dmabuf system heap is
> > > nothing different).
> > >
> > > [ 1233.911533][  T460] warn_alloc: 11 callbacks suppressed
> > > [ 1233.911539][  T460] allocator@2.0-s: page allocation failure: order:4, mode:0x140dc2(GFP_HIGHUSER|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
> > > [ 1233.926235][  T460] Call trace:
> > > [ 1233.929370][  T460]  dump_backtrace+0x0/0x1d8
> > > [ 1233.933704][  T460]  show_stack+0x18/0x24
> > > [ 1233.937701][  T460]  dump_stack+0xc0/0x140
> > > [ 1233.941783][  T460]  warn_alloc+0xf4/0x148
> > > [ 1233.945862][  T460]  __alloc_pages_slowpath+0x9fc/0xa10
> > > [ 1233.951101][  T460]  __alloc_pages_nodemask+0x278/0x2c0
> > > [ 1233.956285][  T460]  ion_page_pool_alloc+0xd8/0x100
> > > [ 1233.961144][  T460]  ion_system_heap_allocate+0xbc/0x2f0
> > > [ 1233.966440][  T460]  ion_buffer_create+0x68/0x274
> > > [ 1233.971130][  T460]  ion_buffer_alloc+0x8c/0x110
> > > [ 1233.975733][  T460]  ion_dmabuf_alloc+0x44/0xe8
> > > [ 1233.980248][  T460]  ion_ioctl+0x100/0x320
> > > [ 1233.984332][  T460]  __arm64_sys_ioctl+0x90/0xc8
> > > [ 1233.988934][  T460]  el0_svc_common+0x9c/0x168
> > > [ 1233.993360][  T460]  do_el0_svc+0x1c/0x28
> > > [ 1233.997358][  T460]  el0_sync_handler+0xd8/0x250
> > > [ 1234.001989][  T460]  el0_sync+0x148/0x180
> > >
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > ---
> > >  drivers/dma-buf/heaps/system_heap.c | 9 +++++++--
> > >  1 files changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> > > index 29e49ac17251..33c25a5e06f9 100644
> > > --- a/drivers/dma-buf/heaps/system_heap.c
> > > +++ b/drivers/dma-buf/heaps/system_heap.c
> > > @@ -40,7 +40,7 @@ struct dma_heap_attachment {
> > >         bool mapped;
> > >  };
> > >
> > > -#define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
> > > +#define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO \
> > >                                 | __GFP_NORETRY) & ~__GFP_RECLAIM) \
> > >                                 | __GFP_COMP)
> > >  #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
> > > @@ -315,6 +315,7 @@ static struct page *alloc_largest_available(unsigned long size,
> > >                                             unsigned int max_order)
> > >  {
> > >         struct page *page;
> > > +       unsigned long gfp_flags;
> > >         int i;
> > >
> > >         for (i = 0; i < NUM_ORDERS; i++) {
> > > @@ -323,7 +324,11 @@ static struct page *alloc_largest_available(unsigned long size,
> > >                 if (max_order < orders[i])
> > >                         continue;
> > >
> > > -               page = alloc_pages(order_flags[i], orders[i]);
> > > +               gfp_flags = order_flags[i];
> > > +               if (orders[i] > PAGE_ALLOC_COSTLY_ORDER)
> > > +                       gfp_flags |= __GFP_NOWARN;
> > > +
> > > +               page = alloc_pages(gfp_flags, orders[i]);
> >
> > Would it be cleaner to just set up the flags properly in the
> > order_flags array? I'm not sure I understand why your patch does it
> > dynamically?
>
> That's exactly I had in my branch for aosp fix but I wanted to
> hear it explicitly from dmabuf maintainer since I was worried
> chaninging order-4 allocation behavior, especially,
> __GFP_NORETRY and &~__GFP_RECLAIM.
> (It will make allocation failure easier than old and that's not
> thing my patch is addressing).

Yea. I might stick to changing just the __GFP_NOWARN.

> If you want this, I am happy to change it. Shall I?
>
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> index 29e49ac17251..865ec847013d 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -44,7 +44,7 @@ struct dma_heap_attachment {
>                                 | __GFP_NORETRY) & ~__GFP_RECLAIM) \
>                                 | __GFP_COMP)
>  #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
> -static gfp_t order_flags[] = {HIGH_ORDER_GFP, LOW_ORDER_GFP, LOW_ORDER_GFP};
> +static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_ORDER_GFP};

Maybe can you define a MID_ORDER_GFP as LOW_ORDER | __GFP_NOWARN
(along with a comment in the code as to why) instead ?

That avoids introducing any subtle behavioral change unintentionally.

thanks
-john
