Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5697936483C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbhDSQbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbhDSQbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:31:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF13260725;
        Mon, 19 Apr 2021 16:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618849869;
        bh=r57rCXyxCPcJzSgJbK/EEF1VhVnc4QXHwu8JTtJMs88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=juJG1rc0Djk8Uac2+xXnA9rjhcnPbennBQRS0sgwt0O4cn42x6t8A673Y0/IDbTEW
         rdR+HAIoPJbRioBCJJTc1sokDr8pETlxrA7xV5Gup67ED7Vrfny1SWIP7m6HjL52eQ
         ZdNALOniiVwiA0kPw+o/zuWuRu+iPnA9kJMgU4gA0qBEiakwAJ4C30LVAS4bc/sWzD
         Ha38EjYi02ttlcwFzZj4x55McTcIzuhqN+Q3yEW0UhNaDaYjnu3vulVfE+vxUDlBC+
         kdAj8a7Le000Qh8IMqQD0Z+i2t/bZ241qLwHQDLk5HieW+AasyD5rBMoHEVnuFHQ+b
         woDwRBOZD2e3w==
Date:   Mon, 19 Apr 2021 17:31:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Robin Murphy <robin.murphy@arm.com>,
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
Subject: Re: [PATCH v2 1/3] iommu: io-pgtable: add DART pagetable format
Message-ID: <20210419163102.GA31045@willie-the-truck>
References: <20210328074009.95932-1-sven@svenpeter.dev>
 <20210328074009.95932-2-sven@svenpeter.dev>
 <20210407104425.GB15173@willie-the-truck>
 <e0d9af36-fc6c-4470-a87c-61b9161bdf8f@www.fastmail.com>
 <CAK8P3a11O7JVDv+4rfky13C1pZFD7eE_B_54zRN8UQVpBrQJcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a11O7JVDv+4rfky13C1pZFD7eE_B_54zRN8UQVpBrQJcA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 09:38:15PM +0200, Arnd Bergmann wrote:
> On Fri, Apr 9, 2021 at 6:56 PM Sven Peter <sven@svenpeter.dev> wrote:
> > On Wed, Apr 7, 2021, at 12:44, Will Deacon wrote:
> > > On Sun, Mar 28, 2021 at 09:40:07AM +0200, Sven Peter wrote:
> > >
> > > > +   cfg->pgsize_bitmap &= SZ_16K;
> > > > +   if (!cfg->pgsize_bitmap)
> > > > +           return NULL;
> > >
> > > This is worrying (and again, I don't think this belongs here). How is this
> > > thing supposed to work if the CPU is using 4k pages?
> >
> > This SoC is just full of fun surprises!
> > I didn't even think about that case since I've always been using 16k pages so far.
> >
> > I've checked again and wasn't able to find any way to configure the pagesize
> > of the IOMMU. There seem to be variants of this IP in older iPhones which
> > support a 4k pagesize but to the best of my knowledge this is hard wired
> > and not configurable in software.
> >
> > When booting with 4k pages I hit the BUG_ON in iova.c that ensures that the
> > iommu pagesize has to be <= the cpu page size.
> >
> > I see two options here and I'm not sure I like either of them:
> >
> > 1) Just don't support 4k CPU pages together with IOMMU translations and only
> >    allow full bypass mode there.
> >    This would however mean that PCIe (i.e. ethernet, usb ports on the Mac
> >    mini) and possibly Thunderbolt support would not be possible since these
> >    devices don't seem to like iommu bypass mode at all.
> 
> It should be possible to do a fake bypass mode by just programming a
> static page table for as much address space as you can, and then
> use swiotlb to address any memory beyond that. This won't perform
> well because it requires bounce buffers for any high memory, but it
> can be a last resort if a dart instance cannot do normal bypass mode.
> 
> > 2) I've had a brief discussion on IRC with Arnd about this [1] and he pointed
> >    out that the dma_map_sg API doesn't make any guarantees about the returned
> >    iovas and that it might be possible to make this work at least for devices
> >    that go through the normal DMA API.
> >
> >    I've then replaced the page size check with a WARN_ON in iova.c just to see
> >    what happens. At least normal devices that go through the DMA API seem to
> >    work with my configuration. iommu_dma_alloc took the iommu_dma_alloc_remap
> >    path which was called with the cpu page size but then used
> >    domain->pgsize_bitmap to increase that to 16k. So this kinda works out, but
> >    there are other functions in dma-iommu.c that I believe rely on the fact that
> >    the iommu can map single cpu pages. This feels very fragile right now and
> >    would probably require some rather invasive changes.
> 
> The other second-to-last resort here would be to duplicate the code from
> the dma-iommu code and implement the dma-mapping API directly on
> top of the dart hardware instead of the iommu layer. This would probably
> be much faster than the swiotlb on top of a bypass or a linear map,
> but it's a really awful abstraction that would require adding special cases
> into a lot of generic code.
> 
> >    Any driver that tries to use the iommu API directly could be trouble
> >    as well if they make similar assumptions.
> 
> I think pretty much all drivers using the iommu API directly already
> depends on having a matching page size.  I don't see any way to use
> e.g. PCI device assignment using vfio, or a GPU driver with per-process
> contexts when the iotlb page size is larger than the CPU's.
> 
> >    Is this something you would even want to support in the iommu subsytem
> >    and is it even possible to do this in a sane way?
> 
> I don't know how hard it is to do adjust the dma-iommu implementation
> to allow this, but as long as we can work out the DT binding to support
> both normal dma-iommu mode with 16KB pages and some kind of
> passthrough mode (emulated or not) with 4KB pages, it can be left
> as a possible optimization for later.

I think one of the main things to modify is the IOVA allocator
(drivers/iommu/iova.c). Once that is happy with pages bigger than the CPU
page size, then you could probably fake everything else in the DMA layer by
offsetting the returned DMA addresses into the 16K page which got mapped.

Will
