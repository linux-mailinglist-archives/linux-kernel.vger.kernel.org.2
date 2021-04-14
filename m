Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA4235F7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbhDNP2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:28:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233670AbhDNP20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:28:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 335F1611F2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 15:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618414085;
        bh=LwQCTRWb7Rq4DqiUTefKtvt2QC/nEsSrSyc5Ht5pJyk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jYLbWgtCHR/SP++hgXjyN7wsiKuNlKxfly5lcNNBft3+xf2v1jpLuQDj4Ner/KcK3
         mNm39W5OUHNihuDvVOIns3IeaihceBebDx5+mgrqVLKqCdAjbOrEfEuTmBfDB0ssj5
         /iU1bFA2VIoe4wz00BLTNtk1l+GImmY9ryyZvqVUimCHotaHD0qMAfWVbB3bzPxWUC
         oYHJTuuvl6t2Z4prUI0xsw61kA2tz0NDy1gCWPczMkEeReEimUb+HZU61tXDonHeIW
         pQDOcoHfaBagjhH6Ywvpip1iiWRUrzbXFhoO6j4NSsc3OaMnvI9RDB9zD9fKq8Y+Sj
         Z5DBaQ7cv8WvQ==
Received: by mail-oo1-f52.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so4686414oot.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:28:05 -0700 (PDT)
X-Gm-Message-State: AOAM530HYaTU+3BuMHKmv7g4uENY+8FW3D4uc5pGMsi/xevIJ00M3ksj
        58YZLYt1Y+5c1qb2ACQzquTIhsN9DyNEgpeHFY8=
X-Google-Smtp-Source: ABdhPJz+JSWz1Dqi1C/C62MRuoCEpRmSe86sqIrI/r3CxHcywLXtc82obRQrItgRzp6gBYbcXpltBvEt0/ghCzKR6Q8=
X-Received: by 2002:a4a:a588:: with SMTP id d8mr126051oom.45.1618414084358;
 Wed, 14 Apr 2021 08:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210407172607.8812-1-rppt@kernel.org> <20210407172607.8812-2-rppt@kernel.org>
 <0c48f98c-7454-1458-15a5-cc5a7e1fb7cd@redhat.com>
In-Reply-To: <0c48f98c-7454-1458-15a5-cc5a7e1fb7cd@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 14 Apr 2021 17:27:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGw97epyP2HdHjA8Yp6+VF1j5xmd0AgVBBv3k+h_B610w@mail.gmail.com>
Message-ID: <CAMj1kXGw97epyP2HdHjA8Yp6+VF1j5xmd0AgVBBv3k+h_B610w@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 1/3] memblock: update initialization of reserved pages
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 at 17:14, David Hildenbrand <david@redhat.com> wrote:
>
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
> I assume these pages are never given to the buddy, because we don't have
> a direct mapping. So to the kernel, it's essentially just like a memory
> hole with benefits.
>
> I can spot that we want to export such memory like any special memory
> thingy/hole in /proc/iomem -- "reserved", which makes sense.
>
> I would assume that MEMBLOCK_NOMAP is a special type of *reserved*
> memory. IOW, that for_each_reserved_mem_range() should already succeed
> on these as well -- we should mark anything that is MEMBLOCK_NOMAP
> implicitly as reserved. Or are there valid reasons not to do so? What
> can anyone do with that memory?
>
> I assume they are pretty much useless for the kernel, right? Like other
> reserved memory ranges.
>

On ARM, we need to know whether any physical regions that do not
contain system memory contain something with device semantics or not.
One of the examples is ACPI tables: these are in reserved memory, and
so they are not covered by the linear region. However, when the ACPI
core ioremap()s an arbitrary memory region, we don't know whether it
is mapping a memory region or a device region unless we keep track of
this in some way. (Device mappings require device attributes, but
firmware tables require memory attributes, as they might be accessed
using misaligned reads)


>
> >
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
> >       return end_pfn - start_pfn;
> >   }
> >
> > +static void __init memmap_init_reserved_pages(void)
> > +{
> > +     struct memblock_region *region;
> > +     phys_addr_t start, end;
> > +     u64 i;
> > +
> > +     /* initialize struct pages for the reserved regions */
> > +     for_each_reserved_mem_range(i, &start, &end)
> > +             reserve_bootmem_region(start, end);
> > +
> > +     /* and also treat struct pages for the NOMAP regions as PageReserved */
> > +     for_each_mem_region(region) {
> > +             if (memblock_is_nomap(region)) {
> > +                     start = region->base;
> > +                     end = start + region->size;
> > +                     reserve_bootmem_region(start, end);
> > +             }
> > +     }
> > +}
> > +
> >   static unsigned long __init free_low_memory_core_early(void)
> >   {
> >       unsigned long count = 0;
> > @@ -2010,8 +2030,7 @@ static unsigned long __init free_low_memory_core_early(void)
> >
> >       memblock_clear_hotplug(0, -1);
> >
> > -     for_each_reserved_mem_range(i, &start, &end)
> > -             reserve_bootmem_region(start, end);
> > +     memmap_init_reserved_pages();
> >
> >       /*
> >        * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
> >
>
>
> --
> Thanks,
>
> David / dhildenb
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
