Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D58E316D55
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhBJRv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbhBJRta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:49:30 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C8DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:48:49 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q72so1528969pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ghPdl7DJ/y2DuvY5DQeuVM9g0TBnNt0Q7r8A9v6wyPg=;
        b=pME/FEIgv90V8Uf3vBiShDtPsN4h2Awb7xu8azlEosMA4QAYAy1Hs0k3VtEQsUE1Ei
         +mcr3VlRvYRqz6ACmxNzLqS/MEXVOMmMi1Ew/7D4aju8I9HBy+FEfJDfL1n045YJrJKL
         6xW4Ezo5pDdEKMZS+9Ft8+eZ/LD77HbCsgXjG19h4BudJudogh7PyarXD5aS0M2XAbp5
         +Bg5/TaydDmo8vzXbFd6KTVwyEIvXLazvJJluqUO+gerAoXOSD9KN8R9lxe/ezLip6fC
         13IMRdclhWl+A3T5AnEujDwkLwotqnU25a81TI3o5AW+Sjux90G8a6D0Bnxzej2zOA/x
         f1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ghPdl7DJ/y2DuvY5DQeuVM9g0TBnNt0Q7r8A9v6wyPg=;
        b=KNRtIavTjhK8tbPIUnYuNHZMjs2p/dvPW8w0g0RTA1qE5SX1mEiwVfUnsmUGnLkdhH
         vptEVePT6hYSd81t5/tA4EUQngHdvEwp2RtYdVjcbutACyTFdw2rUHYz+2Wenn7d8XnL
         HQng4cm1cp/AIM06M4vuhb8uCCHfkIpTJCnJXUSh5UQyAeaiJVEMcPHhq8KSgN/sf/b1
         BBoo5COlG9m/IY92NbRcbcBfACMkjoKoUb1yDM8TneSs3/jqufwReaMHSM66wetsr4Dw
         0A2w+dBosQPymccl/hdRNXpNKVm64o3z+A8C0BojP1QlTFz197R8+iKIhMKBWmvSKR1d
         7uyw==
X-Gm-Message-State: AOAM531vhEEutGkhhzxVktBhQZRH3SRtdcBghPaB5lZPxu6Q//akSjoP
        //mUFWiUuGiLxzr3Et0ax/k=
X-Google-Smtp-Source: ABdhPJw13MAgmS9A+sk+d6zTcymXocSUNUSM96CZrhLUk+5gILZXVSL87SZ0bGYwkgcx3EI3UtdNAA==
X-Received: by 2002:a17:90a:ec05:: with SMTP id l5mr14211pjy.161.1612979328842;
        Wed, 10 Feb 2021 09:48:48 -0800 (PST)
Received: from google.com ([2620:15c:211:201:e5b0:be96:1dfb:a1f6])
        by smtp.gmail.com with ESMTPSA id o189sm2918466pfd.73.2021.02.10.09.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:48:47 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 10 Feb 2021 09:48:45 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] dma-buf: system_heap: do not warn for costly allocation
Message-ID: <YCQcfYRQ3eW+QiMz@google.com>
References: <20210210162632.3903128-1-minchan@kernel.org>
 <CALAqxLXzc3tfsr0hA6GS-zHjupWx++Bhcrs2pjbz00LNKeThOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLXzc3tfsr0hA6GS-zHjupWx++Bhcrs2pjbz00LNKeThOQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:32:09AM -0800, John Stultz wrote:
> On Wed, Feb 10, 2021 at 8:26 AM Minchan Kim <minchan@kernel.org> wrote:
> >
> > Linux VM is not hard to support PAGE_ALLOC_COSTLY_ODER allocation
> > so normally expects driver passes __GFP_NOWARN in that case
> > if they has fallback options.
> >
> > system_heap in dmabuf is the case so do not flood into demsg
> > with the warning for recording more precious information logs.
> > (below is ION warning example I got but dmabuf system heap is
> > nothing different).
> >
> > [ 1233.911533][  T460] warn_alloc: 11 callbacks suppressed
> > [ 1233.911539][  T460] allocator@2.0-s: page allocation failure: order:4, mode:0x140dc2(GFP_HIGHUSER|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
> > [ 1233.926235][  T460] Call trace:
> > [ 1233.929370][  T460]  dump_backtrace+0x0/0x1d8
> > [ 1233.933704][  T460]  show_stack+0x18/0x24
> > [ 1233.937701][  T460]  dump_stack+0xc0/0x140
> > [ 1233.941783][  T460]  warn_alloc+0xf4/0x148
> > [ 1233.945862][  T460]  __alloc_pages_slowpath+0x9fc/0xa10
> > [ 1233.951101][  T460]  __alloc_pages_nodemask+0x278/0x2c0
> > [ 1233.956285][  T460]  ion_page_pool_alloc+0xd8/0x100
> > [ 1233.961144][  T460]  ion_system_heap_allocate+0xbc/0x2f0
> > [ 1233.966440][  T460]  ion_buffer_create+0x68/0x274
> > [ 1233.971130][  T460]  ion_buffer_alloc+0x8c/0x110
> > [ 1233.975733][  T460]  ion_dmabuf_alloc+0x44/0xe8
> > [ 1233.980248][  T460]  ion_ioctl+0x100/0x320
> > [ 1233.984332][  T460]  __arm64_sys_ioctl+0x90/0xc8
> > [ 1233.988934][  T460]  el0_svc_common+0x9c/0x168
> > [ 1233.993360][  T460]  do_el0_svc+0x1c/0x28
> > [ 1233.997358][  T460]  el0_sync_handler+0xd8/0x250
> > [ 1234.001989][  T460]  el0_sync+0x148/0x180
> >
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  drivers/dma-buf/heaps/system_heap.c | 9 +++++++--
> >  1 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> > index 29e49ac17251..33c25a5e06f9 100644
> > --- a/drivers/dma-buf/heaps/system_heap.c
> > +++ b/drivers/dma-buf/heaps/system_heap.c
> > @@ -40,7 +40,7 @@ struct dma_heap_attachment {
> >         bool mapped;
> >  };
> >
> > -#define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
> > +#define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO \
> >                                 | __GFP_NORETRY) & ~__GFP_RECLAIM) \
> >                                 | __GFP_COMP)
> >  #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
> > @@ -315,6 +315,7 @@ static struct page *alloc_largest_available(unsigned long size,
> >                                             unsigned int max_order)
> >  {
> >         struct page *page;
> > +       unsigned long gfp_flags;
> >         int i;
> >
> >         for (i = 0; i < NUM_ORDERS; i++) {
> > @@ -323,7 +324,11 @@ static struct page *alloc_largest_available(unsigned long size,
> >                 if (max_order < orders[i])
> >                         continue;
> >
> > -               page = alloc_pages(order_flags[i], orders[i]);
> > +               gfp_flags = order_flags[i];
> > +               if (orders[i] > PAGE_ALLOC_COSTLY_ORDER)
> > +                       gfp_flags |= __GFP_NOWARN;
> > +
> > +               page = alloc_pages(gfp_flags, orders[i]);
> 
> Would it be cleaner to just set up the flags properly in the
> order_flags array? I'm not sure I understand why your patch does it
> dynamically?

That's exactly I had in my branch for aosp fix but I wanted to
hear it explicitly from dmabuf maintainer since I was worried
chaninging order-4 allocation behavior, especially,
__GFP_NORETRY and &~__GFP_RECLAIM.
(It will make allocation failure easier than old and that's not
thing my patch is addressing).

If you want this, I am happy to change it. Shall I?

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 29e49ac17251..865ec847013d 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -44,7 +44,7 @@ struct dma_heap_attachment {
                                | __GFP_NORETRY) & ~__GFP_RECLAIM) \
                                | __GFP_COMP)
 #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO | __GFP_COMP)
-static gfp_t order_flags[] = {HIGH_ORDER_GFP, LOW_ORDER_GFP, LOW_ORDER_GFP};
+static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_ORDER_GFP};
 /*
  * The selection of the orders used for allocation (1MB, 64K, 4K) is designed
  * to match with the sizes often found in IOMMUs. Using order 4 pages instead

