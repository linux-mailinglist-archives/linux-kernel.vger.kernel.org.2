Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6955335FC4E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 22:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhDNUHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 16:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234803AbhDNUHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 16:07:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C300961154;
        Wed, 14 Apr 2021 20:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618430801;
        bh=MUyogixBd6zIDiaR0VtNwpReVA3q8yetd1FUh51s0mY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVDXufk2mGL1uurwUlE0uKYfGUCD/t4dulxRWu+0ZVD/Y0y1eVtNu69zMAHUO41OP
         mh760Of0rNXS9bxqsSMLBPa1WLFeVJyldHM7wX6MhoavPNsSNpM2jZqEYCYO8dfVsg
         b3GmAX4DMY/u9HG19F7urXJLTPs3GXiMuO5TWcv6/GEQwqdIE8He+jYu60ulNZihyT
         8jFHXJ1sUyZyKm9a9ITlIDmRgu+aBB1yDlgnjws89Omum+Eosc+Pv5A9npX92lBWal
         caFG9N9gAfrmPqdD6arq0PCOtSFtWWu/34fGD/Np9/8IltuT2PW6Abq/ok928hEM77
         9A8v8fK9P6xkw==
Date:   Wed, 14 Apr 2021 23:06:33 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC/RFT PATCH 1/3] memblock: update initialization of reserved
 pages
Message-ID: <YHdLSeYE3f5+v3n5@kernel.org>
References: <20210407172607.8812-1-rppt@kernel.org>
 <20210407172607.8812-2-rppt@kernel.org>
 <0c48f98c-7454-1458-15a5-cc5a7e1fb7cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c48f98c-7454-1458-15a5-cc5a7e1fb7cd@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 05:12:11PM +0200, David Hildenbrand wrote:
> On 07.04.21 19:26, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The struct pages representing a reserved memory region are initialized
> > using reserve_bootmem_range() function. This function is called for each
> > reserved region just before the memory is freed from memblock to the buddy
> > page allocator.
> > 
> > The struct pages for MEMBLOCK_NOMAP regions are kept with the default
> > values set by the memory map initialization which makes it necessary to
> > have a special treatment for such pages in pfn_valid() and
> > pfn_valid_within().
> 
> I assume these pages are never given to the buddy, because we don't have a
> direct mapping. So to the kernel, it's essentially just like a memory hole
> with benefits.

The pages should not be accessed as normal memory so they do not have a
direct (or in ARMish linear) mapping and are never given to buddy. 
After looking at ACPI standard I don't see a fundamental reason for this
but they've already made this mess and we need to cope with it.
 
> I can spot that we want to export such memory like any special memory
> thingy/hole in /proc/iomem -- "reserved", which makes sense.

It does, but let's wait with /proc/iomem changes. We don't really have a
100% consistent view of it on different architectures, so adding yet
another type there does not seem, well, urgent.
 
> I would assume that MEMBLOCK_NOMAP is a special type of *reserved* memory.
> IOW, that for_each_reserved_mem_range() should already succeed on these as
> well -- we should mark anything that is MEMBLOCK_NOMAP implicitly as
> reserved. Or are there valid reasons not to do so? What can anyone do with
> that memory?
> 
> I assume they are pretty much useless for the kernel, right? Like other
> reserved memory ranges.

I agree that there is a lot of commonality between NOMAP and reserved. The
problem is that even semantics for reserved is different between
architectures. Moreover, on the same architecture there could be
E820_TYPE_RESERVED and memblock.reserved with different properties.

I'd really prefer moving in baby steps here because any change in the boot
mm can bear several month of early hangs debugging ;-)

> > Split out initialization of the reserved pages to a function with a
> > meaningful name and treat the MEMBLOCK_NOMAP regions the same way as the
> > reserved regions and mark struct pages for the NOMAP regions as
> > PageReserved.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >   mm/memblock.c | 23 +++++++++++++++++++++--
> >   1 file changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index afaefa8fc6ab..6b7ea9d86310 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -2002,6 +2002,26 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
> >   	return end_pfn - start_pfn;
> >   }
> > +static void __init memmap_init_reserved_pages(void)
> > +{
> > +	struct memblock_region *region;
> > +	phys_addr_t start, end;
> > +	u64 i;
> > +
> > +	/* initialize struct pages for the reserved regions */
> > +	for_each_reserved_mem_range(i, &start, &end)
> > +		reserve_bootmem_region(start, end);
> > +
> > +	/* and also treat struct pages for the NOMAP regions as PageReserved */
> > +	for_each_mem_region(region) {
> > +		if (memblock_is_nomap(region)) {
> > +			start = region->base;
> > +			end = start + region->size;
> > +			reserve_bootmem_region(start, end);
> > +		}
> > +	}
> > +}
> > +
> >   static unsigned long __init free_low_memory_core_early(void)
> >   {
> >   	unsigned long count = 0;
> > @@ -2010,8 +2030,7 @@ static unsigned long __init free_low_memory_core_early(void)
> >   	memblock_clear_hotplug(0, -1);
> > -	for_each_reserved_mem_range(i, &start, &end)
> > -		reserve_bootmem_region(start, end);
> > +	memmap_init_reserved_pages();
> >   	/*
> >   	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id

-- 
Sincerely yours,
Mike.
