Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3971C3F6911
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhHXS25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231956AbhHXS24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:28:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0548661357;
        Tue, 24 Aug 2021 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629829691;
        bh=qejIvxeKJm0/TqXoKGNLd7McXlorFN4Ly2FywuAeM9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gW+926tqq97MY1AfJ/rW64ngE8zXCk3TIGUdVRIUCHgRb/S2uzQiw8fQazz5hdg43
         5Bd5fWg4E5qwsHqrjZBH0my9FoADc9atxhEeD2FKnLoZw03JAnP0xtBmkR2bNMeYD/
         mVG+nVsbMc/W+8f9scHCgU/nimS1iWyrMZ/KAIm1PAJGO426/anRg/XDrEaaM6BkOr
         okRWQEQ8BGVnyjTSJ8P+CoRfkwrdGFbGQdvYzIZjD84crXLh4yu5/D8lEVCUx2v7HD
         1X4mp3EmkdV5Kmr7v8zjTkNFpc8NZoKFm15yuJh99dcwS6SvvA2bbxDt5A6OJ9eFos
         2iNnj6t6MHJOg==
Date:   Tue, 24 Aug 2021 21:28:05 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Alex Bee <knaerzche@gmail.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
Message-ID: <YSU6NVZ3j0XCurWC@kernel.org>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210824173741.GC623@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 06:37:41PM +0100, Catalin Marinas wrote:
> Hi Alex,
> 
> Thanks for the report.
> 
> On Tue, Aug 24, 2021 at 03:40:47PM +0200, Alex Bee wrote:
> > it seems there is a regression in arm64 memory mapping in 5.14, since it
> > fails on Rockchip RK3328 when the pl330 dmac tries to map with:
> > 
> > [    8.921909] ------------[ cut here ]------------
> > [    8.921940] WARNING: CPU: 2 PID: 373 at kernel/dma/mapping.c:235 dma_map_resource+0x68/0xc0
> > [    8.921973] Modules linked in: spi_rockchip(+) fuse
> > [    8.921996] CPU: 2 PID: 373 Comm: systemd-udevd Not tainted 5.14.0-rc7 #1
> > [    8.922004] Hardware name: Pine64 Rock64 (DT)
> > [    8.922011] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
> > [    8.922018] pc : dma_map_resource+0x68/0xc0
> > [    8.922026] lr : pl330_prep_slave_fifo+0x78/0xd0
> > [    8.922040] sp : ffff800012102ae0
> > [    8.922043] x29: ffff800012102ae0 x28: ffff000005c94800 x27: 0000000000000000
> > [    8.922056] x26: ffff000000566bd0 x25: 0000000000000001 x24: 0000000000000001
> > [    8.922067] x23: 0000000000000002 x22: ffff000000628c00 x21: 0000000000000001
> > [    8.922078] x20: ffff000000566bd0 x19: 0000000000000001 x18: 0000000000000000
> > [    8.922089] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > [    8.922100] x14: 0000000000000277 x13: 0000000000000001 x12: 0000000000000000
> > [    8.922111] x11: 0000000000000001 x10: 00000000000008e0 x9 : ffff800012102a80
> > [    8.922123] x8 : ffff000000d14b80 x7 : ffff0000fe7b12f0 x6 : ffff0000fe7b1100
> > [    8.922134] x5 : fffffc000000000f x4 : 0000000000000000 x3 : 0000000000000001
> > [    8.922145] x2 : 0000000000000001 x1 : 00000000ff190800 x0 : ffff000000628c00
> > [    8.922158] Call trace:
> > [    8.922163]  dma_map_resource+0x68/0xc0
> > [    8.922173]  pl330_prep_slave_sg+0x58/0x220
> > [    8.922181]  rockchip_spi_prepare_dma+0xd8/0x2c0 [spi_rockchip]
> > [    8.922208]  rockchip_spi_transfer_one+0x294/0x3d8 [spi_rockchip]
> [...]
> > Note: This does not relate to the spi driver - when disabling this device in
> > the device tree it fails for any other (i2s, for instance) which uses dma.
> > Commenting out the failing check at [1], however, helps and the mapping
> > works again.

> Do you know which address dma_map_resource() is trying to map (maybe
> add some printk())? It's not supposed to map RAM, hence the warning.
> Random guess, the address is 0xff190800 (based on the x1 above but the
> regs might as well be mangled).

0xff190800 will cause this warning for sure. It has a memory map, but it is
not RAM so old version of pfn_valid() would return 0 and the new one
returns 1.
 
> > I tried to follow the recent changes for arm64 mm which could relate to the
> > check failing at [1] and reverting
> >   commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID")
> > helps and makes it work again, but I'm 100% uncertain if that commit is
> > really the culprit.
> > 
> > Note, that the firmware (legacy u-boot) injects memory configuration in the
> > device tree as follows:
> > 
> > /memreserve/    0x00000000fcefc000 0x000000000000d000;
> > / {
> > ..
> >     compatible = "pine64,rock64\0rockchip,rk3328";
> > ..
> >     memory {
> >         reg = <0x00 0x200000 0x00 0xfee00000 0x00 0x00 0x00 0x00>;
> >         device_type = "memory";
> >     };
> > 
> > ..
> > }
> 
> Either pfn_valid() gets confused in 5.14 or something is wrong with the
> DT. I have a suspicion it's the former since reverting the above commit
> makes it disappear.

I think pfn_valid() actually behaves as expected but the caller is wrong
because pfn_valid != RAM (this applies btw to !arm64 as well).

	/* Don't allow RAM to be mapped */
	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
		return DMA_MAPPING_ERROR;

Alex, can you please try this patch:

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 2b06a809d0b9..4715e9641a29 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -232,7 +232,7 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
 		return DMA_MAPPING_ERROR;
 
 	/* Don't allow RAM to be mapped */
-	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
+	if (WARN_ON_ONCE(!memblock_is_memory(phys_addr)))
 		return DMA_MAPPING_ERROR;
 
 	if (dma_map_direct(dev, ops))
 
> > So: there is a "hole" in the mappable memory and reading the commit message
> > of
> >   commit a7d9f306ba70 ("arm64: drop pfn_valid_within() and simplify
> > pfn_valid()")
> > suggests, there was a change for that case recently.
> 
> I think the change from the arm64 pfn_valid() to the generic one is
> avoiding the call to memblock_is_memory(). I wonder whether pfn_valid()
> returns true just because we have a struct page available but the memory
> may have been reserved.
> 
> Cc'ing Mike R.
> 
> > I also noticed there is a diff in the kernel log regarding memory init up
> > until 5.13.12 it says
> > 
> > [    0.000000] Zone ranges:
> > [    0.000000]   DMA      [mem 0x0000000000200000-0x00000000feffffff]
> > [    0.000000]   DMA32    empty
> > [    0.000000]   Normal   empty
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000feffffff]
> > [    0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x00000000feffffff]
> > [    0.000000] On node 0 totalpages: 1043968
> > [    0.000000]   DMA zone: 16312 pages used for memmap
> > [    0.000000]   DMA zone: 0 pages reserved
> > [    0.000000]   DMA zone: 1043968 pages, LIFO batch:63
> > 
> > In contrary in 5.14-rc7 it says:
> > 
> > [    0.000000] Zone ranges:
> > [    0.000000]   DMA      [mem 0x0000000000200000-0x00000000feffffff]
> > [    0.000000]   DMA32    empty
> > [    0.000000]   Normal   empty
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000feffffff]
> > [    0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x00000000feffffff]
> > [    0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
> > [    0.000000] On node 0, zone DMA: 4096 pages in unavailable ranges
> > 
> > (note the "unavailable ranges")
> > I'm uncertain again here, if that diff is expected behavior because of those
> > recent mm changes for arm64.
> > 
> > After reverting
> >   commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID")
> > the log changes to
> > 
> > [    0.000000] Zone ranges:
> > [    0.000000]   DMA      [mem 0x0000000000200000-0x00000000feffffff]
> > [    0.000000]   DMA32    empty
> > [    0.000000]   Normal   empty
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000feffffff]
> > [    0.000000] Initmem setup node 0 [mem
> > 0x0000000000200000-0x00000000feffffff]
> > 
> > (no DMA zones here)
> > 
> > As you might have noticed I have _zero_ clue about memory mapping and dma
> > subsystem - so let me know if there is any more information needed for that
> > and thanks for your help.
> 
> Adding Robin as well, he has a better clue than us on DMA ;).
> 
> > Alex
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/dma/mapping.c?id=e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93#n235
> 
> -- 
> Catalin

-- 
Sincerely yours,
Mike.
