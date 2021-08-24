Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE793F6935
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhHXSrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:47:36 -0400
Received: from foss.arm.com ([217.140.110.172]:40232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhHXSrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:47:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B19FD6E;
        Tue, 24 Aug 2021 11:46:50 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33FD53F766;
        Tue, 24 Aug 2021 11:46:49 -0700 (PDT)
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
To:     Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Alex Bee <knaerzche@gmail.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com> <YSU6NVZ3j0XCurWC@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com>
Date:   Tue, 24 Aug 2021 19:46:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSU6NVZ3j0XCurWC@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-24 19:28, Mike Rapoport wrote:
> On Tue, Aug 24, 2021 at 06:37:41PM +0100, Catalin Marinas wrote:
>> Hi Alex,
>>
>> Thanks for the report.
>>
>> On Tue, Aug 24, 2021 at 03:40:47PM +0200, Alex Bee wrote:
>>> it seems there is a regression in arm64 memory mapping in 5.14, since it
>>> fails on Rockchip RK3328 when the pl330 dmac tries to map with:
>>>
>>> [ï¿½ï¿½ï¿½ 8.921909] ------------[ cut here ]------------
>>> [ï¿½ï¿½ï¿½ 8.921940] WARNING: CPU: 2 PID: 373 at kernel/dma/mapping.c:235 dma_map_resource+0x68/0xc0
>>> [ï¿½ï¿½ï¿½ 8.921973] Modules linked in: spi_rockchip(+) fuse
>>> [ï¿½ï¿½ï¿½ 8.921996] CPU: 2 PID: 373 Comm: systemd-udevd Not tainted 5.14.0-rc7 #1
>>> [ï¿½ï¿½ï¿½ 8.922004] Hardware name: Pine64 Rock64 (DT)
>>> [ï¿½ï¿½ï¿½ 8.922011] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
>>> [ï¿½ï¿½ï¿½ 8.922018] pc : dma_map_resource+0x68/0xc0
>>> [ï¿½ï¿½ï¿½ 8.922026] lr : pl330_prep_slave_fifo+0x78/0xd0
>>> [ï¿½ï¿½ï¿½ 8.922040] sp : ffff800012102ae0
>>> [ï¿½ï¿½ï¿½ 8.922043] x29: ffff800012102ae0 x28: ffff000005c94800 x27: 0000000000000000
>>> [ï¿½ï¿½ï¿½ 8.922056] x26: ffff000000566bd0 x25: 0000000000000001 x24: 0000000000000001
>>> [ï¿½ï¿½ï¿½ 8.922067] x23: 0000000000000002 x22: ffff000000628c00 x21: 0000000000000001
>>> [ï¿½ï¿½ï¿½ 8.922078] x20: ffff000000566bd0 x19: 0000000000000001 x18: 0000000000000000
>>> [ï¿½ï¿½ï¿½ 8.922089] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>> [ï¿½ï¿½ï¿½ 8.922100] x14: 0000000000000277 x13: 0000000000000001 x12: 0000000000000000
>>> [ï¿½ï¿½ï¿½ 8.922111] x11: 0000000000000001 x10: 00000000000008e0 x9 : ffff800012102a80
>>> [ï¿½ï¿½ï¿½ 8.922123] x8 : ffff000000d14b80 x7 : ffff0000fe7b12f0 x6 : ffff0000fe7b1100
>>> [ï¿½ï¿½ï¿½ 8.922134] x5 : fffffc000000000f x4 : 0000000000000000 x3 : 0000000000000001
>>> [ï¿½ï¿½ï¿½ 8.922145] x2 : 0000000000000001 x1 : 00000000ff190800 x0 : ffff000000628c00
>>> [ï¿½ï¿½ï¿½ 8.922158] Call trace:
>>> [ï¿½ï¿½ï¿½ 8.922163]ï¿½ dma_map_resource+0x68/0xc0
>>> [ï¿½ï¿½ï¿½ 8.922173]ï¿½ pl330_prep_slave_sg+0x58/0x220
>>> [ï¿½ï¿½ï¿½ 8.922181]ï¿½ rockchip_spi_prepare_dma+0xd8/0x2c0 [spi_rockchip]
>>> [ï¿½ï¿½ï¿½ 8.922208]ï¿½ rockchip_spi_transfer_one+0x294/0x3d8 [spi_rockchip]
>> [...]
>>> Note: This does not relate to the spi driver - when disabling this device in
>>> the device tree it fails for any other (i2s, for instance) which uses dma.
>>> Commenting out the failing check at [1], however, helps and the mapping
>>> works again.
> 
>> Do you know which address dma_map_resource() is trying to map (maybe
>> add some printk())? It's not supposed to map RAM, hence the warning.
>> Random guess, the address is 0xff190800 (based on the x1 above but the
>> regs might as well be mangled).
> 
> 0xff190800 will cause this warning for sure. It has a memory map, but it is
> not RAM so old version of pfn_valid() would return 0 and the new one
> returns 1.

How does that happen, though? It's not a memory address, and it's not 
even within the bounds of anywhere there should or could be memory. This 
SoC has a simple memory map - everything from 0 to 0xfeffffff goes to 
the DRAM controller (which may not all be populated, and may have pieces 
carved out by secure firmware), while 0xff000000-0xffffffff is MMIO. Why 
do we have pages (or at least the assumption of pages) for somewhere 
which by all rights should not have them?

>>> I tried to follow the recent changes for arm64 mm which could relate to the
>>> check failing at [1] and reverting
>>> ï¿½ commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID")
>>> helps and makes it work again, but I'm 100% uncertain if that commit is
>>> really the culprit.
>>>
>>> Note, that the firmware (legacy u-boot) injects memory configuration in the
>>> device tree as follows:
>>>
>>> /memreserve/ï¿½ï¿½ï¿½ 0x00000000fcefc000 0x000000000000d000;
>>> / {
>>> ..
>>> ï¿½ï¿½ï¿½ compatible = "pine64,rock64\0rockchip,rk3328";
>>> ..
>>> ï¿½ï¿½ï¿½ memory {
>>> ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ reg = <0x00 0x200000 0x00 0xfee00000 0x00 0x00 0x00 0x00>;
>>> ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ device_type = "memory";
>>> ï¿½ï¿½ï¿½ };
>>>
>>> ..
>>> }
>>
>> Either pfn_valid() gets confused in 5.14 or something is wrong with the
>> DT. I have a suspicion it's the former since reverting the above commit
>> makes it disappear.
> 
> I think pfn_valid() actually behaves as expected but the caller is wrong
> because pfn_valid != RAM (this applies btw to !arm64 as well).
> 
> 	/* Don't allow RAM to be mapped */
> 	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
> 		return DMA_MAPPING_ERROR;
> 
> Alex, can you please try this patch:

That will certainly paper over the issue, but it's avoiding the question 
of what went wrong with the memory map in the first place. The comment 
is indeed a bit inaccurate, but ultimately dma_map_resource() exists for 
addresses that would be wrong to pass to dma_map_page(), so I believe 
pfn_valid() is still the correct check.

Robin.

> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 2b06a809d0b9..4715e9641a29 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -232,7 +232,7 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
>   		return DMA_MAPPING_ERROR;
>   
>   	/* Don't allow RAM to be mapped */
> -	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
> +	if (WARN_ON_ONCE(!memblock_is_memory(phys_addr)))
>   		return DMA_MAPPING_ERROR;
>   
>   	if (dma_map_direct(dev, ops))
>   
>>> So: there is a "hole" in the mappable memory and reading the commit message
>>> of
>>> ï¿½ commit a7d9f306ba70 ("arm64: drop pfn_valid_within() and simplify
>>> pfn_valid()")
>>> suggests, there was a change for that case recently.
>>
>> I think the change from the arm64 pfn_valid() to the generic one is
>> avoiding the call to memblock_is_memory(). I wonder whether pfn_valid()
>> returns true just because we have a struct page available but the memory
>> may have been reserved.
>>
>> Cc'ing Mike R.
>>
>>> I also noticed there is a diff in the kernel log regarding memory init up
>>> until 5.13.12 it says
>>>
>>> [ï¿½ï¿½ï¿½ 0.000000] Zone ranges:
>>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMAï¿½ï¿½ï¿½ï¿½ï¿½ [mem 0x0000000000200000-0x00000000feffffff]
>>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMA32ï¿½ï¿½ï¿½ empty
>>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ Normalï¿½ï¿½ empty
>>> [ï¿½ï¿½ï¿½ 0.000000] Movable zone start for each node
>>> [ï¿½ï¿½ï¿½ 0.000000] Early memory node ranges
>>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ nodeï¿½ï¿½ 0: [mem 0x0000000000200000-0x00000000feffffff]
>>> [ï¿½ï¿½ï¿½ 0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x00000000feffffff]
>>> [ï¿½ï¿½ï¿½ 0.000000] On node 0 totalpages: 1043968
>>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMA zone: 16312 pages used for memmap
>>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMA zone: 0 pages reserved
>>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMA zone: 1043968 pages, LIFO batch:63
>>>
>>> In contrary in 5.14-rc7 it says:
>>>
>>> [ï¿½ï¿½ï¿½ 0.000000] Zone ranges:
>>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMAï¿½ï¿½ï¿½ï¿½ï¿½ [mem 0x0000000000200000-0x00000000feffffff]
>>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMA32ï¿½ï¿½ï¿½ empty
>>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ Normalï¿½ï¿½ empty
>>> [ï¿½ï¿½ï¿½ 0.000000] Movable zone start for each node
>>> [ï¿½ï¿½ï¿½ 0.000000] Early memory node ranges
>>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ nodeï¿½ï¿½ 0: [mem 0x0000000000200000-0x00000000feffffff]
>>> [ï¿½ï¿½ï¿½ 0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x00000000feffffff]
>>> [ï¿½ï¿½ï¿½ 0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
>>> [ï¿½ï¿½ï¿½ 0.000000] On node 0, zone DMA: 4096 pages in unavailable ranges
>>>
>>> (note the "unavailable ranges")
>>> I'm uncertain again here, if that diff is expected behavior because of those
>>> recent mm changes for arm64.
>>>
>>> After reverting
>>> ï¿½ commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID")
>>> the log changes to
>>>
>>> [ï¿½ï¿½ï¿½ 0.000000] Zone ranges:
>>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMAï¿½ï¿½ï¿½ï¿½ï¿½ [mem 0x0000000000200000-0x00000000feffffff]
>>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ DMA32ï¿½ï¿½ï¿½ empty
>>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ Normalï¿½ï¿½ empty
>>> [ï¿½ï¿½ï¿½ 0.000000] Movable zone start for each node
>>> [ï¿½ï¿½ï¿½ 0.000000] Early memory node ranges
>>> [ï¿½ï¿½ï¿½ 0.000000]ï¿½ï¿½ nodeï¿½ï¿½ 0: [mem 0x0000000000200000-0x00000000feffffff]
>>> [ï¿½ï¿½ï¿½ 0.000000] Initmem setup node 0 [mem
>>> 0x0000000000200000-0x00000000feffffff]
>>>
>>> (no DMA zones here)
>>>
>>> As you might have noticed I have _zero_ clue about memory mapping and dma
>>> subsystem - so let me know if there is any more information needed for that
>>> and thanks for your help.
>>
>> Adding Robin as well, he has a better clue than us on DMA ;).
>>
>>> Alex
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/dma/mapping.c?id=e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93#n235
>>
>> -- 
>> Catalin
> 
