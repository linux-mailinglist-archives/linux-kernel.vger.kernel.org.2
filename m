Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78BD3C1FFF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 09:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhGIH2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 03:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhGIH2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 03:28:15 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD3DC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 00:25:32 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i125so8414660qke.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 00:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whFUneYINRIgyp8Pel0QMZvhhIk7uCGvvk56hecjsos=;
        b=TDjKIe5QOAn1zKQay0mscOVMXJczKUdKIBUyrz2/d9BHU6hpfp6DKYlgfH1hIr5XU5
         CQvUjkem9fIaRR9atRbvtKtokHArjX7H6SA0d+acKx1fSSW2qOOqYhXW9aHDRSSjoYlI
         yNcc3dA9bh17k3UDaQEgruEFezCrz4ScdOT48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whFUneYINRIgyp8Pel0QMZvhhIk7uCGvvk56hecjsos=;
        b=BtrOjYWDoIlAA8/UezVjoJzzI6N8K2WUtEDCGu/ABtgYM35uuu8YS0YfnxhYbUKjPC
         IMkRw2ttOu1qMJ10oFESoCl8L8y7UuCZVmOSUDg90jhuDhntURfMHv9bPzeR5oDyC8/m
         HVqkDonHXuSPWyrf6W8ETDQ0SqPIuYFyVRBv7is+tBUD4RrRFmYH2C2xMOhdyShzH7Ad
         Y6aEwKoGt5lV05QkVWz4J0Hwdt7Vy6W1yEaN6qfmhuNHGINGtXQdGxljoUG666H/dbxD
         cMW7KDk1uMN5a3Tot1BCYjz3UCBbf4970ZJE6MiYybMN/7eczIk7QwV7yHXcVwAC2TV/
         YCAQ==
X-Gm-Message-State: AOAM5302rPXuz7VEV7Q6Y1BAEwMETVXQ0KFYeoFIgF0qIhplbpm8/G07
        8uj7sqz77R7R2TXa2tRIWMhnHBRqRkldw4MMK5lWNg==
X-Google-Smtp-Source: ABdhPJxHq6W2C4bfcTfl1i4+C3i3IPLXY3z46Q0bCrW2+TLpl/S3gsCeYqNvWaOAioBXZs+O3EZ0lYfp3sZRtNs3f4o=
X-Received: by 2002:a37:644f:: with SMTP id y76mr12978776qkb.194.1625815531525;
 Fri, 09 Jul 2021 00:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210707075505.2896824-1-stevensd@google.com> <YObFbqEk1nGVuHLF@8bytes.org>
 <a20a8f33-a047-cd89-0a2b-85e4f19c8ffa@arm.com>
In-Reply-To: <a20a8f33-a047-cd89-0a2b-85e4f19c8ffa@arm.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Fri, 9 Jul 2021 16:25:20 +0900
Message-ID: <CAD=HUj43XgXR5MsNzuqdsxPML7wzMGm3XsgXsYSdNATcgDm8bA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add dynamic iommu backed bounce buffers
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>,
        David Stevens <stevensd@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 9, 2021 at 2:14 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-07-08 10:29, Joerg Roedel wrote:
> > Adding Robin too.
> >
> > On Wed, Jul 07, 2021 at 04:55:01PM +0900, David Stevens wrote:
> >> Add support for per-domain dynamic pools of iommu bounce buffers to the
> >> dma-iommu API. This allows iommu mappings to be reused while still
> >> maintaining strict iommu protection. Allocating buffers dynamically
> >> instead of using swiotlb carveouts makes per-domain pools more amenable
> >> on systems with large numbers of devices or where devices are unknown.
>
> But isn't that just as true for the currently-supported case? All you
> need is a large enough Thunderbolt enclosure and you could suddenly plug
> in a dozen untrusted GPUs all wanting to map hundreds of megabytes of
> memory. If there's a real concern worth addressing, surely it's worth
> addressing properly for everyone.

Bounce buffers consume memory, so there is always going to be some
limitation on how many devices are supported. This patch series limits
the memory consumption at a given point in time to approximately the
amount of active DMA transactions. There's really no way to improve
significantly on that. The 'approximately' qualification could be
removed by adding a shrinker, but that doesn't change things
materially.

This is compared to reusing swiotlb, where the amount of memory
consumed would be the largest amount of active DMA transactions you
want bounce buffers to handle. I see two concrete shortcomings here.
First, most of the time you're not doing heavy IO, especially for
consumer workloads. Second, it raises the problem of per-device
tuning, since you don't want to waste performance by having too few
bounce buffers but you also don't want to waste memory by
preallocating too many bounce buffers. This tuning becomes more
problematic once you start dealing with external devices.

Also, although this doesn't directly address the raised concern, the
bounce buffers are only used for relatively small DMA transactions. So
large allocations like framebuffers won't actually consume extra
memory via bounce buffers.

> >> When enabled, all non-direct streaming mappings below a configurable
> >> size will go through bounce buffers. Note that this means drivers which
> >> don't properly use the DMA API (e.g. i915) cannot use an iommu when this
> >> feature is enabled. However, all drivers which work with swiotlb=force
> >> should work.
> >>
> >> Bounce buffers serve as an optimization in situations where interactions
> >> with the iommu are very costly. For example, virtio-iommu operations in
> >> a guest on a linux host require a vmexit, involvement the VMM, and a
> >> VFIO syscall. For relatively small DMA operations, memcpy can be
> >> significantly faster.
>
> Yup, back when the bounce-buffering stuff first came up I know
> networking folks were interested in terms of latency for small packets -
> virtualised IOMMUs are indeed another interesting case I hadn't thought
> of. It's definitely been on the radar as another use-case we'd like to
> accommodate with the bounce-buffering scheme. However, that's the thing:
> bouncing is bouncing and however you look at it it still overlaps so
> much with the untrusted case - there's no reason that couldn't use
> pre-mapped bounce buffers too, for instance - that the only necessary
> difference is really the policy decision of when to bounce. iommu-dma
> has already grown complicated enough, and having *three* different ways
> of doing things internally just seems bonkers and untenable. Pre-map the
> bounce buffers? Absolutely. Dynamically grow them on demand? Yes please!
> Do it all as a special thing in its own NIH module and leave the
> existing mess to rot? Sorry, but no.

I do agree that iommu-dma is getting fairly complicated. Since a
virtualized IOMMU uses bounce buffers much more heavily than
sub-granule untrusted DMA, and for the reasons stated earlier in this
email, I don't think pre-allocated bounce buffers are viable for the
virtualized IOMMU case. I can look at migrating the sub-granule
untrusted DMA case to dynamic bounce buffers, if that's an acceptable
approach.

-David

> Thanks,
> Robin.
>
> >> As a performance comparison, on a device with an i5-10210U, I ran fio
> >> with a VFIO passthrough NVMe drive with '--direct=1 --rw=read
> >> --ioengine=libaio --iodepth=64' and block sizes 4k, 16k, 64k, and
> >> 128k. Test throughput increased by 2.8x, 4.7x, 3.6x, and 3.6x. Time
> >> spent in iommu_dma_unmap_(page|sg) per GB processed decreased by 97%,
> >> 94%, 90%, and 87%. Time spent in iommu_dma_map_(page|sg) decreased
> >> by >99%, as bounce buffers don't require syncing here in the read case.
> >> Running with multiple jobs doesn't serve as a useful performance
> >> comparison because virtio-iommu and vfio_iommu_type1 both have big
> >> locks that significantly limit mulithreaded DMA performance.
> >>
> >> This patch set is based on v5.13-rc7 plus the patches at [1].
> >>
> >> David Stevens (4):
> >>    dma-iommu: add kalloc gfp flag to alloc helper
> >>    dma-iommu: replace device arguments
> >>    dma-iommu: expose a few helper functions to module
> >>    dma-iommu: Add iommu bounce buffers to dma-iommu api
> >>
> >>   drivers/iommu/Kconfig          |  10 +
> >>   drivers/iommu/Makefile         |   1 +
> >>   drivers/iommu/dma-iommu.c      | 119 ++++--
> >>   drivers/iommu/io-buffer-pool.c | 656 +++++++++++++++++++++++++++++++++
> >>   drivers/iommu/io-buffer-pool.h |  91 +++++
> >>   include/linux/dma-iommu.h      |  12 +
> >>   6 files changed, 861 insertions(+), 28 deletions(-)
> >>   create mode 100644 drivers/iommu/io-buffer-pool.c
> >>   create mode 100644 drivers/iommu/io-buffer-pool.h
> >>
> >> --
> >> 2.32.0.93.g670b81a890-goog
