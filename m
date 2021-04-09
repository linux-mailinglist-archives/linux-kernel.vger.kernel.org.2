Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC94535A738
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 21:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbhDITir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 15:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234705AbhDITiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:38:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA2FE61165;
        Fri,  9 Apr 2021 19:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617997112;
        bh=AqqKRuGB+aYlSpd2XHtxaxortNgbyhw4JfrwsQxNLN4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CXwi9Dy+zfc80o7ZkIWXRhs9/ZKsvO31vSVYQYVnq6OvP5VeIuRcuhRudglZoQrQQ
         XI7tsH+VIwCw4CT/GnM0ZR5PZ3WRQlV38xh0JeEDw9VHzjDIvP+9nHId9Ptt3/kCzR
         FVppS1H7u4g5ES4XvCWAkfAIZq5W0YPmRb5at5f2GEFA6Jmd5EEwa+qZFj1DXJRmmw
         sbbUjDjd4yuWNHTnUXnSPTG3vvDp+NXA0HsQ/WZdOgBfMQ/LOtOFCivjxmL0lIb2J7
         w874TcijUzFj4URMPQq49VLnSCESPe5wYkuv2LFIrfTqsGYl4mp3Xw41AQDRyHnMFr
         3ALhcqp8DJlkQ==
Received: by mail-oi1-f172.google.com with SMTP id z15so6888343oic.8;
        Fri, 09 Apr 2021 12:38:32 -0700 (PDT)
X-Gm-Message-State: AOAM532ViE9M4ly940fuQ/Nxm05pPigM9LF2f5uusDLy/let8ePcKQ0c
        I/IZEp+pCMmlvjQ5a+7JQmMiLv87r4he4ah0LrE=
X-Google-Smtp-Source: ABdhPJwPRkeRcHq2LQ4abuG/9/wDbgW0Bv24YoYSOQZ4hFRrWtMj03Zbtndge10mz92YsjqjXfAUKkMC/mJSZ/pM/cI=
X-Received: by 2002:a05:6808:3d3:: with SMTP id o19mr1577825oie.4.1617997112043;
 Fri, 09 Apr 2021 12:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210328074009.95932-1-sven@svenpeter.dev> <20210328074009.95932-2-sven@svenpeter.dev>
 <20210407104425.GB15173@willie-the-truck> <e0d9af36-fc6c-4470-a87c-61b9161bdf8f@www.fastmail.com>
In-Reply-To: <e0d9af36-fc6c-4470-a87c-61b9161bdf8f@www.fastmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 9 Apr 2021 21:38:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a11O7JVDv+4rfky13C1pZFD7eE_B_54zRN8UQVpBrQJcA@mail.gmail.com>
Message-ID: <CAK8P3a11O7JVDv+4rfky13C1pZFD7eE_B_54zRN8UQVpBrQJcA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iommu: io-pgtable: add DART pagetable format
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Petr Mladek via iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 6:56 PM Sven Peter <sven@svenpeter.dev> wrote:
> On Wed, Apr 7, 2021, at 12:44, Will Deacon wrote:
> > On Sun, Mar 28, 2021 at 09:40:07AM +0200, Sven Peter wrote:
> >
> > > +   cfg->pgsize_bitmap &= SZ_16K;
> > > +   if (!cfg->pgsize_bitmap)
> > > +           return NULL;
> >
> > This is worrying (and again, I don't think this belongs here). How is this
> > thing supposed to work if the CPU is using 4k pages?
>
> This SoC is just full of fun surprises!
> I didn't even think about that case since I've always been using 16k pages so far.
>
> I've checked again and wasn't able to find any way to configure the pagesize
> of the IOMMU. There seem to be variants of this IP in older iPhones which
> support a 4k pagesize but to the best of my knowledge this is hard wired
> and not configurable in software.
>
> When booting with 4k pages I hit the BUG_ON in iova.c that ensures that the
> iommu pagesize has to be <= the cpu page size.
>
> I see two options here and I'm not sure I like either of them:
>
> 1) Just don't support 4k CPU pages together with IOMMU translations and only
>    allow full bypass mode there.
>    This would however mean that PCIe (i.e. ethernet, usb ports on the Mac
>    mini) and possibly Thunderbolt support would not be possible since these
>    devices don't seem to like iommu bypass mode at all.

It should be possible to do a fake bypass mode by just programming a
static page table for as much address space as you can, and then
use swiotlb to address any memory beyond that. This won't perform
well because it requires bounce buffers for any high memory, but it
can be a last resort if a dart instance cannot do normal bypass mode.

> 2) I've had a brief discussion on IRC with Arnd about this [1] and he pointed
>    out that the dma_map_sg API doesn't make any guarantees about the returned
>    iovas and that it might be possible to make this work at least for devices
>    that go through the normal DMA API.
>
>    I've then replaced the page size check with a WARN_ON in iova.c just to see
>    what happens. At least normal devices that go through the DMA API seem to
>    work with my configuration. iommu_dma_alloc took the iommu_dma_alloc_remap
>    path which was called with the cpu page size but then used
>    domain->pgsize_bitmap to increase that to 16k. So this kinda works out, but
>    there are other functions in dma-iommu.c that I believe rely on the fact that
>    the iommu can map single cpu pages. This feels very fragile right now and
>    would probably require some rather invasive changes.

The other second-to-last resort here would be to duplicate the code from
the dma-iommu code and implement the dma-mapping API directly on
top of the dart hardware instead of the iommu layer. This would probably
be much faster than the swiotlb on top of a bypass or a linear map,
but it's a really awful abstraction that would require adding special cases
into a lot of generic code.

>    Any driver that tries to use the iommu API directly could be trouble
>    as well if they make similar assumptions.

I think pretty much all drivers using the iommu API directly already
depends on having a matching page size.  I don't see any way to use
e.g. PCI device assignment using vfio, or a GPU driver with per-process
contexts when the iotlb page size is larger than the CPU's.

>    Is this something you would even want to support in the iommu subsytem
>    and is it even possible to do this in a sane way?

I don't know how hard it is to do adjust the dma-iommu implementation
to allow this, but as long as we can work out the DT binding to support
both normal dma-iommu mode with 16KB pages and some kind of
passthrough mode (emulated or not) with 4KB pages, it can be left
as a possible optimization for later.

        Arnd
