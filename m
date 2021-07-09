Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EC43C1F35
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 08:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhGIGHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 02:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhGIGHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 02:07:42 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E4AC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 23:04:59 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q190so8298918qkd.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 23:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbF8puKkycWClRXOTMf8YBIUmvBH80QaLUrpTjvl4Wo=;
        b=Q9CN4y8kuYDyjjOinrLIbhrvsuG7oG8xznHByjxf7T6tNxNXedt3vo8/b+nOld6Z6E
         6X78DZQnUTwmloAZY3YTXydI4GW1oxTuzwDyPQqvnB9Q6Uxht1SC2jowH7Cmku/d5oMf
         eDhKDKwD4fZVhcVC75j2s0T1QKrQ4BHezUNas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbF8puKkycWClRXOTMf8YBIUmvBH80QaLUrpTjvl4Wo=;
        b=dWc1UZIh1srDUQ69r1YQN+D9ynqJnL8at5SiqX9mYhsj3k657YQYcypUXBPzcmmIDP
         4l7F43f25lZeMXp1UcAS/WKLsTGw7/mdt3WcpgwNP5tSTgijcqnh8QAD45Ehd/z18fM4
         AiZ4cjIVUlokkXQQEvSQ8nYk6HQvODDlFV66gU6+h7uKVe3yjH3fhyS3empGdCHqXoTf
         WrblDOKi6lEGh1ai8gyb1iVhsyE6RW+/SFDA/nAElQIQsB4eqDbZNtJXjRVGiiyaiep9
         xkGnjWljsgdnF0u/FUZMP2rFhL3B4w6uDAWy6aRvvwpIp0eTFwR+6aVfVB9dqQta8eyK
         CFOA==
X-Gm-Message-State: AOAM532gvHc3WtwC09BjBl8UbGoDE+dP4w1IrKszENcdwV7CtmBmzoHV
        gF1rm1xrdrM9jDMKbWf69f65gKZsoV4gFZODYWbNlQ==
X-Google-Smtp-Source: ABdhPJzYRtOtlgcYODkz4IVS1aZUXFd9F9pL1mZ0QQltwB0/i6BSAvKZrGbRNpALxP8Btapj/TMghujFB2eKQ2QcKHI=
X-Received: by 2002:a05:620a:208e:: with SMTP id e14mr13571848qka.328.1625810698435;
 Thu, 08 Jul 2021 23:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210707075505.2896824-1-stevensd@google.com> <f6541f4e-648e-d9a0-eda7-b2a117978ebb@linux.intel.com>
In-Reply-To: <f6541f4e-648e-d9a0-eda7-b2a117978ebb@linux.intel.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Fri, 9 Jul 2021 15:04:47 +0900
Message-ID: <CAD=HUj4_mtTPbXBqQke=Q+zK0EuJZEeWOiVkhphAUfvK-DMHVg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add dynamic iommu backed bounce buffers
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        iommu@lists.linux-foundation.org,
        David Stevens <stevensd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 8, 2021 at 10:38 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi David,
>
> I like this idea. Thanks for proposing this.
>
> On 2021/7/7 15:55, David Stevens wrote:
> > Add support for per-domain dynamic pools of iommu bounce buffers to the
> > dma-iommu API. This allows iommu mappings to be reused while still
> > maintaining strict iommu protection. Allocating buffers dynamically
> > instead of using swiotlb carveouts makes per-domain pools more amenable
> > on systems with large numbers of devices or where devices are unknown.
>
> Have you ever considered leveraging the per-device swiotlb memory pool
> added by below series?
>
> https://lore.kernel.org/linux-iommu/20210625123004.GA3170@willie-the-truck/

I'm not sure if that's a good fit. The swiotlb pools are allocated
during device initialization, so they require setting aside the
worst-case amount of memory. That's okay if you only use it with a
small number of devices where you know in advance approximately how
much memory they use. However, it doesn't work as well if you want to
use it with a large number of devices, or with unknown (i.e.
hotplugged) devices.

> >
> > When enabled, all non-direct streaming mappings below a configurable
> > size will go through bounce buffers. Note that this means drivers which
> > don't properly use the DMA API (e.g. i915) cannot use an iommu when this
> > feature is enabled. However, all drivers which work with swiotlb=force
> > should work.
>
> If so, why not making it more scalable by adding a callback into vendor
> iommu drivers? The vendor iommu drivers have enough information to tell
> whether the bounce buffer is feasible for a specific domain.

I'm not very familiar with the specifics of VT-d or restrictions with
the graphics hardware, but at least on the surface it looks like a
limitation of the i915 driver's implementation. The driver uses the
DMA_ATTR_SKIP_CPU_SYNC flag, but never calls the dma_sync functions,
since things are coherent on x86 hardware. However, bounce buffers
violate the driver's assumption that there's no need to sync the CPU
and device domain. I doubt there's an inherent limitation of the
hardware here, it's just how the driver is implemented. Given that, I
don't know if it's something the iommu driver needs to handle.

One potential way this could be addressed would be to add explicit
support to the DMA API for long-lived streaming mappings. Drivers can
get that behavior today via DMA_ATTR_SKIP_CPU_SYNC and dma_sync.
However, the DMA API doesn't really have enough information to treat
ephemeral and long-lived mappings differently. With a new DMA_ATTR
flag for long-lived streaming mappings, the DMA API could skip bounce
buffers. That flag could also be used as a performance optimization in
the various dma-buf implementations, since they seem to mostly fall
into the long-lived streaming category (the handful I checked do call
dma_sync, so there isn't a correctness issue).

-David

> >
> > Bounce buffers serve as an optimization in situations where interactions
> > with the iommu are very costly. For example, virtio-iommu operations in
>
> The simulated IOMMU does the same thing.
>
> It's also an optimization for bare metal in cases where the strict mode
> of cache invalidation is used. CPU moving data is faster than IOMMU
> cache invalidation if the buffer is small.
>
> Best regards,
> baolu
