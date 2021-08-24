Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9604E3F68C5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhHXSGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:06:54 -0400
Received: from foss.arm.com ([217.140.110.172]:40012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230388AbhHXSGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:06:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEE71D6E;
        Tue, 24 Aug 2021 11:06:08 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D5BB3F766;
        Tue, 24 Aug 2021 11:06:07 -0700 (PDT)
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Alex Bee <knaerzche@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mike Rapoport <rppt@kernel.org>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <77eb6abd-4369-eb8f-e323-cf4e6f2ffce5@arm.com>
Date:   Tue, 24 Aug 2021 19:06:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210824173741.GC623@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-24 18:37, Catalin Marinas wrote:
> Hi Alex,
> 
> Thanks for the report.
> 
> On Tue, Aug 24, 2021 at 03:40:47PM +0200, Alex Bee wrote:
>> it seems there is a regression in arm64 memory mapping in 5.14, since it
>> fails on Rockchip RK3328 when the pl330 dmac tries to map with:
>>
>> [ï¿½ï¿½ï¿½ 8.921909] ------------[ cut here ]------------
>> [ï¿½ï¿½ï¿½ 8.921940] WARNING: CPU: 2 PID: 373 at kernel/dma/mapping.c:235 dma_map_resource+0x68/0xc0
>> [ï¿½ï¿½ï¿½ 8.921973] Modules linked in: spi_rockchip(+) fuse
>> [ï¿½ï¿½ï¿½ 8.921996] CPU: 2 PID: 373 Comm: systemd-udevd Not tainted 5.14.0-rc7 #1
>> [ï¿½ï¿½ï¿½ 8.922004] Hardware name: Pine64 Rock64 (DT)
>> [ï¿½ï¿½ï¿½ 8.922011] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
>> [ï¿½ï¿½ï¿½ 8.922018] pc : dma_map_resource+0x68/0xc0
>> [ï¿½ï¿½ï¿½ 8.922026] lr : pl330_prep_slave_fifo+0x78/0xd0
>> [ï¿½ï¿½ï¿½ 8.922040] sp : ffff800012102ae0
>> [ï¿½ï¿½ï¿½ 8.922043] x29: ffff800012102ae0 x28: ffff000005c94800 x27: 0000000000000000
>> [ï¿½ï¿½ï¿½ 8.922056] x26: ffff000000566bd0 x25: 0000000000000001 x24: 0000000000000001
>> [ï¿½ï¿½ï¿½ 8.922067] x23: 0000000000000002 x22: ffff000000628c00 x21: 0000000000000001
>> [ï¿½ï¿½ï¿½ 8.922078] x20: ffff000000566bd0 x19: 0000000000000001 x18: 0000000000000000
>> [ï¿½ï¿½ï¿½ 8.922089] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>> [ï¿½ï¿½ï¿½ 8.922100] x14: 0000000000000277 x13: 0000000000000001 x12: 0000000000000000
>> [ï¿½ï¿½ï¿½ 8.922111] x11: 0000000000000001 x10: 00000000000008e0 x9 : ffff800012102a80
>> [ï¿½ï¿½ï¿½ 8.922123] x8 : ffff000000d14b80 x7 : ffff0000fe7b12f0 x6 : ffff0000fe7b1100
>> [ï¿½ï¿½ï¿½ 8.922134] x5 : fffffc000000000f x4 : 0000000000000000 x3 : 0000000000000001
>> [ï¿½ï¿½ï¿½ 8.922145] x2 : 0000000000000001 x1 : 00000000ff190800 x0 : ffff000000628c00
>> [ï¿½ï¿½ï¿½ 8.922158] Call trace:
>> [ï¿½ï¿½ï¿½ 8.922163]ï¿½ dma_map_resource+0x68/0xc0
>> [ï¿½ï¿½ï¿½ 8.922173]ï¿½ pl330_prep_slave_sg+0x58/0x220
>> [ï¿½ï¿½ï¿½ 8.922181]ï¿½ rockchip_spi_prepare_dma+0xd8/0x2c0 [spi_rockchip]
>> [ï¿½ï¿½ï¿½ 8.922208]ï¿½ rockchip_spi_transfer_one+0x294/0x3d8 [spi_rockchip]
> [...]
>> Note: This does not relate to the spi driver - when disabling this device in
>> the device tree it fails for any other (i2s, for instance) which uses dma.
>> Commenting out the failing check at [1], however, helps and the mapping
>> works again.
> 
> Do you know which address dma_map_resource() is trying to map (maybe
> add some printk())? It's not supposed to map RAM, hence the warning.
> Random guess, the address is 0xff190800 (based on the x1 above but the
> regs might as well be mangled).

Yup, that fits the signature of dma_map_resource(), and would indeed be 
right in the middle of the SPI peripheral on RK3328.

FWIW the comment about RAM there is a little inaccurate, but the point 
remains that anything which *is* backed by a page should probably be 
handled by dma_map_page() if at all.

>> I tried to follow the recent changes for arm64 mm which could relate to the
>> check failing at [1] and reverting
>> ï¿½ commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID")
>> helps and makes it work again, but I'm 100% uncertain if that commit is
>> really the culprit.
>>
>> Note, that the firmware (legacy u-boot) injects memory configuration in the
>> device tree as follows:
>>
>> /memreserve/ï¿½ï¿½ï¿½ 0x00000000fcefc000 0x000000000000d000;
>> / {
>> ..
>> ï¿½ï¿½ï¿½ compatible = "pine64,rock64\0rockchip,rk3328";
>> ..
>> ï¿½ï¿½ï¿½ memory {
>> ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ reg = <0x00 0x200000 0x00 0xfee00000 0x00 0x00 0x00 0x00>;
>> ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ device_type = "memory";
>> ï¿½ï¿½ï¿½ };
>>
>> ..
>> }
> 
> Either pfn_valid() gets confused in 5.14 or something is wrong with the
> DT. I have a suspicion it's the former since reverting the above commit
> makes it disappear.
> 
>> So: there is a "hole" in the mappable memory and reading the commit message
>> of
>> ï¿½ commit a7d9f306ba70 ("arm64: drop pfn_valid_within() and simplify
>> pfn_valid()")
>> suggests, there was a change for that case recently.
> 
> I think the change from the arm64 pfn_valid() to the generic one is
> avoiding the call to memblock_is_memory(). I wonder whether pfn_valid()
> returns true just because we have a struct page available but the memory
> may have been reserved.

Either way I think something's gone pretty badly wrong if Linux ends up 
thinking that an MMIO region beyond the bounds of any possible RAM 
should be page-backed :/

Robin.

> 
> Cc'ing Mike R.
> 
>> I also noticed there is a diff in the kernel log regarding memory init up
>> until 5.13.12 it says
>>
>> [ï¿½ï¿½ï¿½ 0.000000] Zone ranges:
>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMAï¿½ï¿½ï¿½ï¿½ï¿½ [mem 0x0000000000200000-0x00000000feffffff]
>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMA32ï¿½ï¿½ï¿½ empty
>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ Normalï¿½ï¿½ empty
>> [ï¿½ï¿½ï¿½ 0.000000] Movable zone start for each node
>> [ï¿½ï¿½ï¿½ 0.000000] Early memory node ranges
>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ nodeï¿½ï¿½ 0: [mem 0x0000000000200000-0x00000000feffffff]
>> [ï¿½ï¿½ï¿½ 0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x00000000feffffff]
>> [ï¿½ï¿½ï¿½ 0.000000] On node 0 totalpages: 1043968
>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMA zone: 16312 pages used for memmap
>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMA zone: 0 pages reserved
>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMA zone: 1043968 pages, LIFO batch:63
>>
>> In contrary in 5.14-rc7 it says:
>>
>> [ï¿½ï¿½ï¿½ 0.000000] Zone ranges:
>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMAï¿½ï¿½ï¿½ï¿½ï¿½ [mem 0x0000000000200000-0x00000000feffffff]
>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMA32ï¿½ï¿½ï¿½ empty
>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ Normalï¿½ï¿½ empty
>> [ï¿½ï¿½ï¿½ 0.000000] Movable zone start for each node
>> [ï¿½ï¿½ï¿½ 0.000000] Early memory node ranges
>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ nodeï¿½ï¿½ 0: [mem 0x0000000000200000-0x00000000feffffff]
>> [ï¿½ï¿½ï¿½ 0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x00000000feffffff]
>> [ï¿½ï¿½ï¿½ 0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
>> [ï¿½ï¿½ï¿½ 0.000000] On node 0, zone DMA: 4096 pages in unavailable ranges
>>
>> (note the "unavailable ranges")
>> I'm uncertain again here, if that diff is expected behavior because of those
>> recent mm changes for arm64.
>>
>> After reverting
>> ï¿½ commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID")
>> the log changes to
>>
>> [ï¿½ï¿½ï¿½ 0.000000] Zone ranges:
>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMAï¿½ï¿½ï¿½ï¿½ï¿½ [mem 0x0000000000200000-0x00000000feffffff]
>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMA32ï¿½ï¿½ï¿½ empty
>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ Normalï¿½ï¿½ empty
>> [ï¿½ï¿½ï¿½ 0.000000] Movable zone start for each node
>> [ï¿½ï¿½ï¿½ 0.000000] Early memory node ranges
>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ nodeï¿½ï¿½ 0: [mem 0x0000000000200000-0x00000000feffffff]
>> [ï¿½ï¿½ï¿½ 0.000000] Initmem setup node 0 [mem
>> 0x0000000000200000-0x00000000feffffff]
>>
>> (no DMA zones here)
>>
>> As you might have noticed I have _zero_ clue about memory mapping and dma
>> subsystem - so let me know if there is any more information needed for that
>> and thanks for your help.
> 
> Adding Robin as well, he has a better clue than us on DMA ;).
> 
>> Alex
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/dma/mapping.c?id=e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93#n235
> 
