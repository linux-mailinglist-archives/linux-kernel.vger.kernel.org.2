Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02C83F73BC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbhHYKxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240114AbhHYKxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:53:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02E7B610E5;
        Wed, 25 Aug 2021 10:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629888771;
        bh=wm/yb9SVVnMKeowdOVQ2W/ip4zg5t33mCRFwPPOzq7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iShINh3oJ8Rcc2cl2KJc5Jtsa7Dokhiz1B65W7jaL6cTLE7DjjRdMkt1Y+fJEBKZq
         6xupFeWAYzVpMXiyNOmOYJI/Zq/LnHXfP5az0zNR0Hn8o2SIljCOrsOccFkQnefCZL
         DxxJGJU5Uuj54cLKrNVpKFaQsX5iBTh34WilA8qBBrZ5OrVd/dxkqGSpBzOVw1ZKx3
         gVt3wzBy072e3D7QYdf6Ld6owwTctOS9ECgwupHWfuYExg6AYsGbfT+BpA0EVYPjwG
         wK8JQKLK7UWJlqKuOSac+OG+6vs2x7BIZv0dwmMU1TETXhmXmSex7EyeK7EoFeBPwU
         QM3Pwa3tjr3ZA==
Date:   Wed, 25 Aug 2021 13:52:45 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Bee <knaerzche@gmail.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
Message-ID: <YSYg/VmWlVh+rKp1@kernel.org>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com>
 <YSU6NVZ3j0XCurWC@kernel.org>
 <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com>
 <60a11eba-2910-3b5f-ef96-97d4556c1596@redhat.com>
 <20210825102044.GA3420@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825102044.GA3420@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 11:20:46AM +0100, Catalin Marinas wrote:
> + hch
> 
> On Tue, Aug 24, 2021 at 08:59:22PM +0200, David Hildenbrand wrote:
> > On 24.08.21 20:46, Robin Murphy wrote:
> > > On 2021-08-24 19:28, Mike Rapoport wrote:
> > > > On Tue, Aug 24, 2021 at 06:37:41PM +0100, Catalin Marinas wrote:
> > > > > On Tue, Aug 24, 2021 at 03:40:47PM +0200, Alex Bee wrote:
> > > > > > it seems there is a regression in arm64 memory mapping in 5.14, since it
> > > > > > fails on Rockchip RK3328 when the pl330 dmac tries to map with:
> > > > > > 
> > > > > >  ------------[ cut here ]------------
> > > > > >  WARNING: CPU: 2 PID: 373 at kernel/dma/mapping.c:235 dma_map_resource+0x68/0xc0
> > > > > >  Modules linked in: spi_rockchip(+) fuse
> > > > > >  CPU: 2 PID: 373 Comm: systemd-udevd Not tainted 5.14.0-rc7 #1
> > > > > >  Hardware name: Pine64 Rock64 (DT)
> > > > > >  pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
> > > > > >  pc : dma_map_resource+0x68/0xc0
> > > > > >  lr : pl330_prep_slave_fifo+0x78/0xd0
> > > > > >  sp : ffff800012102ae0
> > > > > >  x29: ffff800012102ae0 x28: ffff000005c94800 x27: 0000000000000000
> > > > > >  x26: ffff000000566bd0 x25: 0000000000000001 x24: 0000000000000001
> > > > > >  x23: 0000000000000002 x22: ffff000000628c00 x21: 0000000000000001
> > > > > >  x20: ffff000000566bd0 x19: 0000000000000001 x18: 0000000000000000
> > > > > >  x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > > > > >  x14: 0000000000000277 x13: 0000000000000001 x12: 0000000000000000
> > > > > >  x11: 0000000000000001 x10: 00000000000008e0 x9 : ffff800012102a80
> > > > > >  x8 : ffff000000d14b80 x7 : ffff0000fe7b12f0 x6 : ffff0000fe7b1100
> > > > > >  x5 : fffffc000000000f x4 : 0000000000000000 x3 : 0000000000000001
> > > > > >  x2 : 0000000000000001 x1 : 00000000ff190800 x0 : ffff000000628c00
> > > > > >  Call trace:
> > > > > >    dma_map_resource+0x68/0xc0
> > > > > >    pl330_prep_slave_sg+0x58/0x220
> > > > > >    rockchip_spi_prepare_dma+0xd8/0x2c0 [spi_rockchip]
> > > > > >    rockchip_spi_transfer_one+0x294/0x3d8 [spi_rockchip]
> > > > > [...]
> > > > > > Note: This does not relate to the spi driver - when disabling this device in
> > > > > > the device tree it fails for any other (i2s, for instance) which uses dma.
> > > > > > Commenting out the failing check at [1], however, helps and the mapping
> > > > > > works again.
> > > > 
> > > > > Do you know which address dma_map_resource() is trying to map (maybe
> > > > > add some printk())? It's not supposed to map RAM, hence the warning.
> > > > > Random guess, the address is 0xff190800 (based on the x1 above but the
> > > > > regs might as well be mangled).
> > > > 
> > > > 0xff190800 will cause this warning for sure. It has a memory map, but it is
> > > > not RAM so old version of pfn_valid() would return 0 and the new one
> > > > returns 1.
> > > 
> > > How does that happen, though? It's not a memory address, and it's not
> > > even within the bounds of anywhere there should or could be memory. This
> > > SoC has a simple memory map - everything from 0 to 0xfeffffff goes to
> > > the DRAM controller (which may not all be populated, and may have pieces
> > > carved out by secure firmware), while 0xff000000-0xffffffff is MMIO. Why
> > > do we have pages (or at least the assumption of pages) for somewhere
> > > which by all rights should not have them?
> > 
> > Simple: we allocate the vmemmap for whole sections (e.g., 128 MiB) to avoid
> > any such hacks. If there is a memory hole, it gets a memmap as well.
> > 
> > Tricking pfn_valid() into returning "false" where we actually have a memmap
> > only makes it look like there is no memmap; but there is one, and
> > it's PG_reserved.
> 
> I can see the documentation for pfn_valid() does not claim anything more
> than the presence of an memmap entry. But I wonder whether the confusion
> is wider-spread than just the DMA code. At a quick grep, try_ram_remap()
> assumes __va() can be used on pfn_valid(), though I suspect it relies on
> the calling function to check that the resource was RAM. The arm64
> kern_addr_valid() returns true based on pfn_valid() and kcore.c uses
> standard memcpy on it, which wouldn't work for I/O (should we change
> this check to pfn_is_map_memory() for arm64?).

Since for the most cases pfn_valid() would actually mean RAM, the confusion
is really widespread :(

Using pfn_is_map_memory() in kern_addr_valid() seems to me a better choice
that pfn_valid().

> > > > > Either pfn_valid() gets confused in 5.14 or something is wrong with the
> > > > > DT. I have a suspicion it's the former since reverting the above commit
> > > > > makes it disappear.
> > > > 
> > > > I think pfn_valid() actually behaves as expected but the caller is wrong
> > > > because pfn_valid != RAM (this applies btw to !arm64 as well).
> > > > 
> > > > 	/* Don't allow RAM to be mapped */
> > > > 	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
> > > > 		return DMA_MAPPING_ERROR;
> > > > 
> > > > Alex, can you please try this patch:
> > > 
> > > That will certainly paper over the issue, but it's avoiding the question
> > > of what went wrong with the memory map in the first place. The comment
> > > is indeed a bit inaccurate, but ultimately dma_map_resource() exists for
> > > addresses that would be wrong to pass to dma_map_page(), so I believe
> > > pfn_valid() is still the correct check.
> > 
> > If we want to check for RAM, pfn_valid() would be wrong. If we want to check
> > for "is there a memmap, for whatever lives or does not live there",
> > pfn_valid() is the right check.
> 
> So what should the DMA code use instead? Last time we needed something
> similar, the recommendation was to use pfn_to_online_page(). Mike is
> suggesting memblock_is_memory().

This was a for testing purposes :)
I considered some ugly fix for v5.14 with a __weak check in dma/mapping.c for
backward compatibility and an override in arm64 and then a proper audit for
v5.15.

But as Will went for revert this is not really relevant.
 
> Given how later we are in the -rc cycle, I suggest we revert Anshuman's
> commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID") and try to
> assess the implications in 5.15 (the patch doesn't seem to have the
> arm64 maintainers' ack anyway ;)).
> 
> Thanks.
> 
> -- 
> Catalin

-- 
Sincerely yours,
Mike.
