Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209F7357BF8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 07:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhDHFs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 01:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhDHFs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 01:48:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63B5461165;
        Thu,  8 Apr 2021 05:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617860897;
        bh=iZpN7cxy9VnxK2TYdrbMMImQTJ1fW4dq7xSpLQijeTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dl292MLISlbQZd/fFLYaxnwcrPK9C5UUE4DiOEK3BEuCVLuVqarJj/TeZbhkeuG0o
         tX8ByJYJ/reUWFukQgA4/twgCnCpe5oQZ4t5S7vLRkcnFYq5VH7e1ogQqxazlvV2Vz
         rDRkbKLjMh68QWEgYz+B7vI2IT2ySH2+nNWxw1WvYPcrVIGoeoJ6JdFZmnpG0eLnZR
         sLwegVrYVbWm8EYMRcC4MPpCLHUZi/u2VwXPTkE6lidEaruip9jDn+SZzYrJaBk0fi
         Mn2AcdPHB/2nFdFkVDvjwyj9Vtc4rjSByj0r74ulrzNXvq3YSjuGtS8oN6a/AJPtyO
         9v15iayUX+DrQ==
Date:   Thu, 8 Apr 2021 08:48:09 +0300
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
Subject: Re: [RFC/RFT PATCH 1/3] memblock: update initialization of reserved
 pages
Message-ID: <YG6ZGW1EtOe9pZV7@kernel.org>
References: <20210407172607.8812-1-rppt@kernel.org>
 <20210407172607.8812-2-rppt@kernel.org>
 <064dad68-ca9f-14d3-7859-5321001fbca4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <064dad68-ca9f-14d3-7859-5321001fbca4@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 10:46:18AM +0530, Anshuman Khandual wrote:
> 
> 
> On 4/7/21 10:56 PM, Mike Rapoport wrote:
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
> > 
> > Split out initialization of the reserved pages to a function with a
> > meaningful name and treat the MEMBLOCK_NOMAP regions the same way as the
> > reserved regions and mark struct pages for the NOMAP regions as
> > PageReserved.
> 
> This would definitely need updating the comment for MEMBLOCK_NOMAP definition
> in include/linux/memblock.h just to make the semantics is clear,

Sure

> though arm64 is currently the only user for MEMBLOCK_NOMAP.

> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  mm/memblock.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index afaefa8fc6ab..6b7ea9d86310 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -2002,6 +2002,26 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
> >  	return end_pfn - start_pfn;
> >  }
> >  
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
> >  static unsigned long __init free_low_memory_core_early(void)
> >  {
> >  	unsigned long count = 0;
> > @@ -2010,8 +2030,7 @@ static unsigned long __init free_low_memory_core_early(void)
> >  
> >  	memblock_clear_hotplug(0, -1);
> >  
> > -	for_each_reserved_mem_range(i, &start, &end)
> > -		reserve_bootmem_region(start, end);
> > +	memmap_init_reserved_pages();
> >  
> >  	/*
> >  	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
> > 

-- 
Sincerely yours,
Mike.
