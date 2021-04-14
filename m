Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F0835FC62
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 22:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbhDNUMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 16:12:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232967AbhDNUMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 16:12:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B343461177;
        Wed, 14 Apr 2021 20:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618431106;
        bh=sV4UNsutnMtYuaS2+nk74hUsFkm1slC1eZ4FtbZ6jo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asFVTglc/UE2ixV1HtH1d7/BBlvWoJYaUneXRwap3OZ6xQ9hZH/oFtbH4rHDsONdS
         tN3HJ5qayGSWguapJn3MqInCuYDVI4BT07/q57eBE8TDLvQ/fXb8+v5OjAHp+nmZ6w
         cVhANE/H/76i3uz5D1kU/ydwiYERhped/NnSFOoy/FtmipjzZR+FraDR6hl18bz+eE
         aufPXkShAuNZ5OLZo9KcMS53z1uTko0YBEonTS7j1uD8BmyCpyBM0gxHPa+zWgiO9+
         P4WKLHRIQD4j1aL/hq8mlGPfSLBM3/sJlbH+N4eSWTkc14bHLhDKVyq/fe16U/OX8U
         es47AYGW2sdwA==
Date:   Wed, 14 Apr 2021 23:11:38 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [RFC/RFT PATCH 1/3] memblock: update initialization of reserved
 pages
Message-ID: <YHdMeqroH0enGiE3@kernel.org>
References: <20210407172607.8812-1-rppt@kernel.org>
 <20210407172607.8812-2-rppt@kernel.org>
 <0c48f98c-7454-1458-15a5-cc5a7e1fb7cd@redhat.com>
 <CAMj1kXGw97epyP2HdHjA8Yp6+VF1j5xmd0AgVBBv3k+h_B610w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGw97epyP2HdHjA8Yp6+VF1j5xmd0AgVBBv3k+h_B610w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 05:27:53PM +0200, Ard Biesheuvel wrote:
> On Wed, 14 Apr 2021 at 17:14, David Hildenbrand <david@redhat.com> wrote:
> >
> > On 07.04.21 19:26, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > >
> > > The struct pages representing a reserved memory region are initialized
> > > using reserve_bootmem_range() function. This function is called for each
> > > reserved region just before the memory is freed from memblock to the buddy
> > > page allocator.
> > >
> > > The struct pages for MEMBLOCK_NOMAP regions are kept with the default
> > > values set by the memory map initialization which makes it necessary to
> > > have a special treatment for such pages in pfn_valid() and
> > > pfn_valid_within().
> >
> > I assume these pages are never given to the buddy, because we don't have
> > a direct mapping. So to the kernel, it's essentially just like a memory
> > hole with benefits.
> >
> > I can spot that we want to export such memory like any special memory
> > thingy/hole in /proc/iomem -- "reserved", which makes sense.
> >
> > I would assume that MEMBLOCK_NOMAP is a special type of *reserved*
> > memory. IOW, that for_each_reserved_mem_range() should already succeed
> > on these as well -- we should mark anything that is MEMBLOCK_NOMAP
> > implicitly as reserved. Or are there valid reasons not to do so? What
> > can anyone do with that memory?
> >
> > I assume they are pretty much useless for the kernel, right? Like other
> > reserved memory ranges.
> >
> 
> On ARM, we need to know whether any physical regions that do not
> contain system memory contain something with device semantics or not.
> One of the examples is ACPI tables: these are in reserved memory, and
> so they are not covered by the linear region. However, when the ACPI
> core ioremap()s an arbitrary memory region, we don't know whether it
> is mapping a memory region or a device region unless we keep track of
> this in some way. (Device mappings require device attributes, but
> firmware tables require memory attributes, as they might be accessed
> using misaligned reads)

I mostly agree, but my understanding is that regions of *physical* memory
that are occupied by various pieces of EFI/ACPI information require special
treatment because it was defined this way in the APCI spec.
And since ARM cannot tolerate aliased mappings with different caching mode
the whole bunch of firmware memory should be ioremap()ed to access it.

> > > Split out initialization of the reserved pages to a function with a
> > > meaningful name and treat the MEMBLOCK_NOMAP regions the same way as the
> > > reserved regions and mark struct pages for the NOMAP regions as
> > > PageReserved.
> > >
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > ---
> > >   mm/memblock.c | 23 +++++++++++++++++++++--
> > >   1 file changed, 21 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > index afaefa8fc6ab..6b7ea9d86310 100644
> > > --- a/mm/memblock.c
> > > +++ b/mm/memblock.c
> > > @@ -2002,6 +2002,26 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
> > >       return end_pfn - start_pfn;
> > >   }
> > >
> > > +static void __init memmap_init_reserved_pages(void)
> > > +{
> > > +     struct memblock_region *region;
> > > +     phys_addr_t start, end;
> > > +     u64 i;
> > > +
> > > +     /* initialize struct pages for the reserved regions */
> > > +     for_each_reserved_mem_range(i, &start, &end)
> > > +             reserve_bootmem_region(start, end);
> > > +
> > > +     /* and also treat struct pages for the NOMAP regions as PageReserved */
> > > +     for_each_mem_region(region) {
> > > +             if (memblock_is_nomap(region)) {
> > > +                     start = region->base;
> > > +                     end = start + region->size;
> > > +                     reserve_bootmem_region(start, end);
> > > +             }
> > > +     }
> > > +}
> > > +
> > >   static unsigned long __init free_low_memory_core_early(void)
> > >   {
> > >       unsigned long count = 0;
> > > @@ -2010,8 +2030,7 @@ static unsigned long __init free_low_memory_core_early(void)
> > >
> > >       memblock_clear_hotplug(0, -1);
> > >
> > > -     for_each_reserved_mem_range(i, &start, &end)
> > > -             reserve_bootmem_region(start, end);
> > > +     memmap_init_reserved_pages();
> > >
> > >       /*
> > >        * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
> > >
> >
> >
> > --
> > Thanks,
> >
> > David / dhildenb
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Sincerely yours,
Mike.
