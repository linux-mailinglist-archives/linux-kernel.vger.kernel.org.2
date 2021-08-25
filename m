Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2923F73E6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbhHYK7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:59:45 -0400
Received: from foss.arm.com ([217.140.110.172]:48838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240191AbhHYK7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:59:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8415C31B;
        Wed, 25 Aug 2021 03:58:58 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D502F3F766;
        Wed, 25 Aug 2021 03:58:56 -0700 (PDT)
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
To:     David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Alex Bee <knaerzche@gmail.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com> <YSU6NVZ3j0XCurWC@kernel.org>
 <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com>
 <60a11eba-2910-3b5f-ef96-97d4556c1596@redhat.com>
 <20210825102044.GA3420@arm.com>
 <b720e7c8-ca44-0a25-480b-05bf49d03c35@redhat.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c392a29d-3501-956e-d659-7585831c458f@arm.com>
Date:   Wed, 25 Aug 2021 11:58:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b720e7c8-ca44-0a25-480b-05bf49d03c35@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-25 11:38, David Hildenbrand wrote:
> On 25.08.21 12:20, Catalin Marinas wrote:
>> + hch
>>
>> On Tue, Aug 24, 2021 at 08:59:22PM +0200, David Hildenbrand wrote:
>>> On 24.08.21 20:46, Robin Murphy wrote:
>>>> On 2021-08-24 19:28, Mike Rapoport wrote:
>>>>> On Tue, Aug 24, 2021 at 06:37:41PM +0100, Catalin Marinas wrote:
>>>>>> On Tue, Aug 24, 2021 at 03:40:47PM +0200, Alex Bee wrote:
>>>>>>> it seems there is a regression in arm64 memory mapping in 5.14, 
>>>>>>> since it
>>>>>>> fails on Rockchip RK3328 when the pl330 dmac tries to map with:
>>>>>>>
>>>>>>>   ------------[ cut here ]------------
>>>>>>>   WARNING: CPU: 2 PID: 373 at kernel/dma/mapping.c:235 
>>>>>>> dma_map_resource+0x68/0xc0
>>>>>>>   Modules linked in: spi_rockchip(+) fuse
>>>>>>>   CPU: 2 PID: 373 Comm: systemd-udevd Not tainted 5.14.0-rc7 #1
>>>>>>>   Hardware name: Pine64 Rock64 (DT)
>>>>>>>   pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
>>>>>>>   pc : dma_map_resource+0x68/0xc0
>>>>>>>   lr : pl330_prep_slave_fifo+0x78/0xd0
>>>>>>>   sp : ffff800012102ae0
>>>>>>>   x29: ffff800012102ae0 x28: ffff000005c94800 x27: 0000000000000000
>>>>>>>   x26: ffff000000566bd0 x25: 0000000000000001 x24: 0000000000000001
>>>>>>>   x23: 0000000000000002 x22: ffff000000628c00 x21: 0000000000000001
>>>>>>>   x20: ffff000000566bd0 x19: 0000000000000001 x18: 0000000000000000
>>>>>>>   x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>>>>>>   x14: 0000000000000277 x13: 0000000000000001 x12: 0000000000000000
>>>>>>>   x11: 0000000000000001 x10: 00000000000008e0 x9 : ffff800012102a80
>>>>>>>   x8 : ffff000000d14b80 x7 : ffff0000fe7b12f0 x6 : ffff0000fe7b1100
>>>>>>>   x5 : fffffc000000000f x4 : 0000000000000000 x3 : 0000000000000001
>>>>>>>   x2 : 0000000000000001 x1 : 00000000ff190800 x0 : ffff000000628c00
>>>>>>>   Call trace:
>>>>>>>     dma_map_resource+0x68/0xc0
>>>>>>>     pl330_prep_slave_sg+0x58/0x220
>>>>>>>     rockchip_spi_prepare_dma+0xd8/0x2c0 [spi_rockchip]
>>>>>>>     rockchip_spi_transfer_one+0x294/0x3d8 [spi_rockchip]
>>>>>> [...]
>>>>>>> Note: This does not relate to the spi driver - when disabling 
>>>>>>> this device in
>>>>>>> the device tree it fails for any other (i2s, for instance) which 
>>>>>>> uses dma.
>>>>>>> Commenting out the failing check at [1], however, helps and the 
>>>>>>> mapping
>>>>>>> works again.
>>>>>
>>>>>> Do you know which address dma_map_resource() is trying to map (maybe
>>>>>> add some printk())? It's not supposed to map RAM, hence the warning.
>>>>>> Random guess, the address is 0xff190800 (based on the x1 above but 
>>>>>> the
>>>>>> regs might as well be mangled).
>>>>>
>>>>> 0xff190800 will cause this warning for sure. It has a memory map, 
>>>>> but it is
>>>>> not RAM so old version of pfn_valid() would return 0 and the new one
>>>>> returns 1.
>>>>
>>>> How does that happen, though? It's not a memory address, and it's not
>>>> even within the bounds of anywhere there should or could be memory. 
>>>> This
>>>> SoC has a simple memory map - everything from 0 to 0xfeffffff goes to
>>>> the DRAM controller (which may not all be populated, and may have 
>>>> pieces
>>>> carved out by secure firmware), while 0xff000000-0xffffffff is MMIO. 
>>>> Why
>>>> do we have pages (or at least the assumption of pages) for somewhere
>>>> which by all rights should not have them?
>>>
>>> Simple: we allocate the vmemmap for whole sections (e.g., 128 MiB) to 
>>> avoid
>>> any such hacks. If there is a memory hole, it gets a memmap as well.

Urgh, apologies for being slow. This case isn't a memory hole as such, 
but I failed to consider the *ends* of memory not being section-aligned 
and leading to an overlap anyway.

>>> Tricking pfn_valid() into returning "false" where we actually have a 
>>> memmap
>>> only makes it look like there is no memmap; but there is one, and
>>> it's PG_reserved.
>>
>> I can see the documentation for pfn_valid() does not claim anything more
>> than the presence of an memmap entry. But I wonder whether the confusion
>> is wider-spread than just the DMA code. At a quick grep, try_ram_remap()
>> assumes __va() can be used on pfn_valid(), though I suspect it relies on
>> the calling function to check that the resource was RAM. The arm64
>> kern_addr_valid() returns true based on pfn_valid() and kcore.c uses
>> standard memcpy on it, which wouldn't work for I/O (should we change
>> this check to pfn_is_map_memory() for arm64?).
>>
> 
> kern_addr_valid() checks that there is a direct map entry, and that the 
> mapped address has a valid mmap. (copied from x86-64)
> 
> Would you expect to have a direct map for memory holes and similar (IOW, 
> !System RAM)?

Probably - we can have no-map regions for firmware-reserved RAM which I 
believe end up as PG_reserved if they're small enough, for the same 
reasoning as this case.

>>>>>> Either pfn_valid() gets confused in 5.14 or something is wrong 
>>>>>> with the
>>>>>> DT. I have a suspicion it's the former since reverting the above 
>>>>>> commit
>>>>>> makes it disappear.
>>>>>
>>>>> I think pfn_valid() actually behaves as expected but the caller is 
>>>>> wrong
>>>>> because pfn_valid != RAM (this applies btw to !arm64 as well).
>>>>>
>>>>>     /* Don't allow RAM to be mapped */
>>>>>     if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
>>>>>         return DMA_MAPPING_ERROR;
>>>>>
>>>>> Alex, can you please try this patch:
>>>>
>>>> That will certainly paper over the issue, but it's avoiding the 
>>>> question
>>>> of what went wrong with the memory map in the first place. The comment
>>>> is indeed a bit inaccurate, but ultimately dma_map_resource() exists 
>>>> for
>>>> addresses that would be wrong to pass to dma_map_page(), so I believe
>>>> pfn_valid() is still the correct check.
>>>
>>> If we want to check for RAM, pfn_valid() would be wrong. If we want 
>>> to check
>>> for "is there a memmap, for whatever lives or does not live there",
>>> pfn_valid() is the right check.
>>
>> So what should the DMA code use instead? Last time we needed something
>> similar, the recommendation was to use pfn_to_online_page(). Mike is
>> suggesting memblock_is_memory().
> 
> We use pfn_to_online_page() when we want to know if it's system RAM and 
> that the memmap actually contains something sane (-> memmap content has 
> a well defined state).
> 
> You can have offline memory blocks where pfn_to_online_page() would 
> return "false", memblock_is_memory() would return "true". IOW, there is 
> a memmap, it's System RAM, but the memmap is stale and not trustworthy.

That's fine - offline memory is doubly-invalid to map as an MMIO resource :)

> If you want to make sure no System RAM (online/offline/...) will get 
> mapped, memblock_is_memory() should be the right thing to use. I recall 
> that x86 traverse the resource tree instead to exclude system ram 
> regions similarly.

I'm thinking that "pfn_valid(pfn) && !PageReserved(pfn_to_page(pfn))" 
might be the closest thing to what I'd like to express - does that seem 
sensible at all? The one thing I'm not quite sure about is the 
interaction with P2P mappings of ZONE_DEVICE, but that's also true of 
the previous behaviour, and I'm not aware that the usage model has been 
fully nailed down yet, so I suspect we have some wiggle room. At worst, 
false negatives in certain situations wouldn't be the end of the world, 
since this is merely a sanity check for something which is expected to 
be a no-op the vast majority of the time, so being unobtrusive is more 
important than being exhaustive.

Thanks,
Robin.

>> Given how later we are in the -rc cycle, I suggest we revert Anshuman's
>> commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID") and try to
>> assess the implications in 5.15 (the patch doesn't seem to have the
>> arm64 maintainers' ack anyway ;)).
> 
