Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60044357C45
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhDHGSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:18:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhDHGSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:18:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 111BD610E6;
        Thu,  8 Apr 2021 06:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617862686;
        bh=D25A47pHXo5M0XVHRMAlv9F2o8wUhKGIRqNCPd2GVIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f9WtSPzU8GfleqgMagOrPW6QHdltbXgThsO4oWjrX16rmkJYXoeZ1mboF/jEf9JBw
         z16CMkGV25K2UCjvOiAoHMKVIqmJ8DJ1zwPvQiPCAWaQC9dP2RIRqZxFfCfs08Gky0
         F65vrzVc3NOk7WNP2hvIwk/BGAmWoQ7yDYyxxzGOHA9GtgBk8MRMlg5LCIlB+x4oUV
         5klr0VJ9s/EX3Me2zaPK/3Jb0C1eIgWIcdhcpYjRoNJIU4pGj7Lyj8YmYswFisl0jx
         7Ohrbn8rDh1ExWdu1Y5HLNf4OaGcgcJ2Tn4XqLHdDuMNpPEov90n1P35u+Cv7EyuuW
         lr1G1VATC2HTw==
Date:   Thu, 8 Apr 2021 09:17:58 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC/RFT PATCH 3/3] arm64: drop pfn_valid_within() and simplify
 pfn_valid()
Message-ID: <YG6gFi5/3O2OsYYH@kernel.org>
References: <20210407172607.8812-1-rppt@kernel.org>
 <20210407172607.8812-4-rppt@kernel.org>
 <7bc09505-72f1-e297-40a9-639b3e9b1c61@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bc09505-72f1-e297-40a9-639b3e9b1c61@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 10:42:43AM +0530, Anshuman Khandual wrote:
> 
> On 4/7/21 10:56 PM, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The arm64's version of pfn_valid() differs from the generic because of two
> > reasons:
> > 
> > * Parts of the memory map are freed during boot. This makes it necessary to
> >   verify that there is actual physical memory that corresponds to a pfn
> >   which is done by querying memblock.
> > 
> > * There are NOMAP memory regions. These regions are not mapped in the
> >   linear map and until the previous commit the struct pages representing
> >   these areas had default values.
> > 
> > As the consequence of absence of the special treatment of NOMAP regions in
> > the memory map it was necessary to use memblock_is_map_memory() in
> > pfn_valid() and to have pfn_valid_within() aliased to pfn_valid() so that
> > generic mm functionality would not treat a NOMAP page as a normal page.
> > 
> > Since the NOMAP regions are now marked as PageReserved(), pfn walkers and
> > the rest of core mm will treat them as unusable memory and thus
> > pfn_valid_within() is no longer required at all and can be disabled by
> > removing CONFIG_HOLES_IN_ZONE on arm64.
> 
> But what about the memory map that are freed during boot (mentioned above).
> Would not they still cause CONFIG_HOLES_IN_ZONE to be applicable and hence
> pfn_valid_within() ?

The CONFIG_HOLES_IN_ZONE name is misleading as actually pfn_valid_within()
is only required for holes within a MAX_ORDER_NR_PAGES blocks (see comment
near pfn_valid_within() definition in mmzone.h). The freeing of the memory
map during boot avoids breaking MAX_ORDER blocks and the holes for which
memory map is freed are always aligned at MAX_ORDER.

AFAIU, the only case when there could be a hole in a MAX_ORDER block is
when EFI/ACPI reserves memory for its use and this memory becomes NOMAP in
the kernel. We still create struct pages for this memory, but they never
get values other than defaults, so core mm has no idea that this memory
should be touched, hence the need for pfn_valid_within() aliased to
pfn_valid() on arm64.
 
> > pfn_valid() can be slightly simplified by replacing
> > memblock_is_map_memory() with memblock_is_memory().
> 
> Just to understand this better, pfn_valid() will now return true for all
> MEMBLOCK_NOMAP based memory but that is okay as core MM would still ignore
> them as unusable memory for being PageReserved().

Right, pfn_valid() will return true for all memory, including
MEMBLOCK_NOMAP. Since core mm deals with PageResrved() for memory used by
the firmware, e.g. on x86, I don't see why it won't work on arm64.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/arm64/Kconfig   | 3 ---
> >  arch/arm64/mm/init.c | 4 ++--
> >  2 files changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index e4e1b6550115..58e439046d05 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1040,9 +1040,6 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
> >  	def_bool y
> >  	depends on NUMA
> >  
> > -config HOLES_IN_ZONE
> > -	def_bool y
> > -
> >  source "kernel/Kconfig.hz"
> >  
> >  config ARCH_SPARSEMEM_ENABLE
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 258b1905ed4a..bb6dd406b1f0 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -243,7 +243,7 @@ int pfn_valid(unsigned long pfn)
> >  
> >  	/*
> >  	 * ZONE_DEVICE memory does not have the memblock entries.
> > -	 * memblock_is_map_memory() check for ZONE_DEVICE based
> > +	 * memblock_is_memory() check for ZONE_DEVICE based
> >  	 * addresses will always fail. Even the normal hotplugged
> >  	 * memory will never have MEMBLOCK_NOMAP flag set in their
> >  	 * memblock entries. Skip memblock search for all non early
> > @@ -254,7 +254,7 @@ int pfn_valid(unsigned long pfn)
> >  		return pfn_section_valid(ms, pfn);
> >  }
> >  #endif
> > -	return memblock_is_map_memory(addr);
> > +	return memblock_is_memory(addr);
> >  }
> >  EXPORT_SYMBOL(pfn_valid);
> >  
> > 

-- 
Sincerely yours,
Mike.
