Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0237A3F6E80
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 06:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhHYEjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 00:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49733 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhHYEjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 00:39:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9564761246;
        Wed, 25 Aug 2021 04:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629866346;
        bh=DyJlqtTO+nFr0UnDA22UPSMLbTJ+DzvuMl9//OXkwzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPEay1hYiUr55ZMZUrxsSndXmclPRr9OIYk4pCIV24HBrV0SgRNe8QBlZ6yKyfnyN
         L5dT0c9rHRIEHLS29zCHtSti+dzEcrBncirZiitQofLip9UDhzN8tDcrL1KzJ7T4P0
         EW9FkMJr44oatqBJJ8QrDEOxAcAvB1hdmGMt2Yx3mKMD6xCvG/zK1AKBkzqPRjwca0
         XuTj4wwcckO5axQG9XVj0Ftv5H+hwMQVTy/+KdZ095uuGf5UE5m+tbh0uAjglMPIY+
         vgnCloEWZX1T2HJKlhGcZ2Gx/G5EUPvEZ7O1dGgeUemqWQtLbjlP0FSI48ArNgoyz+
         D4AihaLgGRUnA==
Date:   Wed, 25 Aug 2021 07:39:00 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
Message-ID: <YSXJZBKeka5U7VN+@kernel.org>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com>
 <YSU6NVZ3j0XCurWC@kernel.org>
 <b37fc109-06d3-0c86-a3c8-e5d7f21f296b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b37fc109-06d3-0c86-a3c8-e5d7f21f296b@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:14:01PM +0200, Alex Bee wrote:
> Hi Mike,
> 
> thanks for your reply
> 
> Am 24.08.21 um 20:28 schrieb Mike Rapoport:
> > On Tue, Aug 24, 2021 at 06:37:41PM +0100, Catalin Marinas wrote:
> > > Hi Alex,
> > > 
> > > Thanks for the report.
> > > 
> > > On Tue, Aug 24, 2021 at 03:40:47PM +0200, Alex Bee wrote:
> > > > it seems there is a regression in arm64 memory mapping in 5.14, since it
> > > > fails on Rockchip RK3328 when the pl330 dmac tries to map with:
> > > > 
> > > > [    8.921909] ------------[ cut here ]------------
> > > > [    8.921940] WARNING: CPU: 2 PID: 373 at kernel/dma/mapping.c:235 dma_map_resource+0x68/0xc0
> > > > [    8.921973] Modules linked in: spi_rockchip(+) fuse
> > > > [    8.921996] CPU: 2 PID: 373 Comm: systemd-udevd Not tainted 5.14.0-rc7 #1
> > > > [    8.922004] Hardware name: Pine64 Rock64 (DT)
> > > > [    8.922011] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
> > > > [    8.922018] pc : dma_map_resource+0x68/0xc0
> > > > [    8.922026] lr : pl330_prep_slave_fifo+0x78/0xd0
> > > > [    8.922040] sp : ffff800012102ae0
> > > > [    8.922043] x29: ffff800012102ae0 x28: ffff000005c94800 x27: 0000000000000000
> > > > [    8.922056] x26: ffff000000566bd0 x25: 0000000000000001 x24: 0000000000000001
> > > > [    8.922067] x23: 0000000000000002 x22: ffff000000628c00 x21: 0000000000000001
> > > > [    8.922078] x20: ffff000000566bd0 x19: 0000000000000001 x18: 0000000000000000
> > > > [    8.922089] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > > > [    8.922100] x14: 0000000000000277 x13: 0000000000000001 x12: 0000000000000000
> > > > [    8.922111] x11: 0000000000000001 x10: 00000000000008e0 x9 : ffff800012102a80
> > > > [    8.922123] x8 : ffff000000d14b80 x7 : ffff0000fe7b12f0 x6 : ffff0000fe7b1100
> > > > [    8.922134] x5 : fffffc000000000f x4 : 0000000000000000 x3 : 0000000000000001
> > > > [    8.922145] x2 : 0000000000000001 x1 : 00000000ff190800 x0 : ffff000000628c00
> > > > [    8.922158] Call trace:
> > > > [    8.922163]  dma_map_resource+0x68/0xc0
> > > > [    8.922173]  pl330_prep_slave_sg+0x58/0x220
> > > > [    8.922181]  rockchip_spi_prepare_dma+0xd8/0x2c0 [spi_rockchip]
> > > > [    8.922208]  rockchip_spi_transfer_one+0x294/0x3d8 [spi_rockchip]
> > > [...]
> > > > Note: This does not relate to the spi driver - when disabling this device in
> > > > the device tree it fails for any other (i2s, for instance) which uses dma.
> > > > Commenting out the failing check at [1], however, helps and the mapping
> > > > works again.
> > > Do you know which address dma_map_resource() is trying to map (maybe
> > > add some printk())? It's not supposed to map RAM, hence the warning.
> > > Random guess, the address is 0xff190800 (based on the x1 above but the
> > > regs might as well be mangled).
> > 0xff190800 will cause this warning for sure. It has a memory map, but it is
> > not RAM so old version of pfn_valid() would return 0 and the new one
> > returns 1.
> > > > I tried to follow the recent changes for arm64 mm which could relate to the
> > > > check failing at [1] and reverting
> > > >    commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID")
> > > > helps and makes it work again, but I'm 100% uncertain if that commit is
> > > > really the culprit.
> > > > 
> > > > Note, that the firmware (legacy u-boot) injects memory configuration in the
> > > > device tree as follows:
> > > > 
> > > > /memreserve/    0x00000000fcefc000 0x000000000000d000;
> > > > / {
> > > > ..
> > > >      compatible = "pine64,rock64\0rockchip,rk3328";
> > > > ..
> > > >      memory {
> > > >          reg = <0x00 0x200000 0x00 0xfee00000 0x00 0x00 0x00 0x00>;
> > > >          device_type = "memory";
> > > >      };
> > > > 
> > > > ..
> > > > }
> > > Either pfn_valid() gets confused in 5.14 or something is wrong with the
> > > DT. I have a suspicion it's the former since reverting the above commit
> > > makes it disappear.
> > I think pfn_valid() actually behaves as expected but the caller is wrong
> > because pfn_valid != RAM (this applies btw to !arm64 as well).
> > 
> > 	/* Don't allow RAM to be mapped */
> > 	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
> > 		return DMA_MAPPING_ERROR;
> > 
> > Alex, can you please try this patch:
> > 
> > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > index 2b06a809d0b9..4715e9641a29 100644
> > --- a/kernel/dma/mapping.c
> > +++ b/kernel/dma/mapping.c
> > @@ -232,7 +232,7 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
> >   		return DMA_MAPPING_ERROR;
> >   	/* Don't allow RAM to be mapped */
> > -	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
> > +	if (WARN_ON_ONCE(!memblock_is_memory(phys_addr)))
> >   		return DMA_MAPPING_ERROR;
> >   	if (dma_map_direct(dev, ops))
> 
> Nope, doesn't help:
> 
> [    8.353879] dma_map_resource Failed to map address 0xff190800
> [    8.353886] dma_map_resource pfn_valid(PHYS_PFN(0xff190800)): 1
> [    8.353892] dma_map_resource memblock_is_memory(0xff190800): 0
> 
> If understand the comment for that check correct, that we _don't_ want RAM
> to be mapped - shoudn't that be:
> 
> +	if (WARN_ON_ONCE(memblock_is_memory(phys_addr)))
> 
> ?

Right, we don't want RAM to be mapped, the negation was wrong and it should
be 

	if (WARN_ON_ONCE(memblock_is_memory(phys_addr)))
 
-- 
Sincerely yours,
Mike.
