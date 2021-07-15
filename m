Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDFC3C98B0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 08:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240156AbhGOGNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 02:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhGOGN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:13:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3217F61358;
        Thu, 15 Jul 2021 06:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626329436;
        bh=NF9HPSYFdmTGIZ7fJoMVjM5ZOLU0Fy555wIvMVupgQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iXEULQyincIujtOinmEdo6s01AtI0/sRUdGrHO0Q2+2xhfXojuWVRKR0B4YA2d5/2
         RnZG/eA+pCFAYmfpGCmbBGtLeCMbg+/baYDPHYcT8R5klvPpS1bvCEGB6krq50d5h/
         Wkehc54w49Ixn0ES0fnV1TrIPaGNB7OE1mihlrwkhXd1VDhDVS6kiBmu8n6oU5YWWi
         aIm2yadS6dtuBT3KubOttjrxjO1ojaus3djtONyleS0j4Q4zTMRvhGE7xyB/fifJQi
         9LK/qRHu0szhRY4GJfoRp81YLWXH751o2pS3XJACokdNNKmwRLc/msSXwY/blPyDdt
         4Vls+y0KR0a+Q==
Date:   Thu, 15 Jul 2021 09:10:30 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/4] mm: introduce memmap_alloc() to unify memory map
 allocation
Message-ID: <YO/RVo7Kh2mIXZFp@kernel.org>
References: <20210714123739.16493-1-rppt@kernel.org>
 <20210714123739.16493-4-rppt@kernel.org>
 <20210714153208.ef96cfc7c6bac360598101ed@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714153208.ef96cfc7c6bac360598101ed@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 03:32:08PM -0700, Andrew Morton wrote:
> On Wed, 14 Jul 2021 15:37:38 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > There are several places that allocate memory for the memory map:
> > alloc_node_mem_map() for FLATMEM, sparse_buffer_init() and
> > __populate_section_memmap() for SPARSEMEM.
> > 
> > The memory allocated in the FLATMEM case is zeroed and it is never
> > poisoned, regardless of CONFIG_PAGE_POISON setting.
> > 
> > The memory allocated in the SPARSEMEM cases is not zeroed and it is
> > implicitly poisoned inside memblock if CONFIG_PAGE_POISON is set.
> > 
> > Introduce memmap_alloc() wrapper for memblock allocators that will be used
> > for both FLATMEM and SPARSEMEM cases and will makei memory map zeroing and
> > poisoning consistent for different memory models.
> > 
> > ...
> >
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6730,6 +6730,26 @@ static void __init memmap_init(void)
> >  		init_unavailable_range(hole_pfn, end_pfn, zone_id, nid);
> >  }
> >  
> > +void __init *memmap_alloc(phys_addr_t size, phys_addr_t align,
> > +			  phys_addr_t min_addr, int nid, bool exact_nid)
> > +{
> > +	void *ptr;
> > +
> > +	if (exact_nid)
> > +		ptr = memblock_alloc_exact_nid_raw(size, align, min_addr,
> > +						   MEMBLOCK_ALLOC_ACCESSIBLE,
> > +						   nid);
> > +	else
> > +		ptr = memblock_alloc_try_nid_raw(size, align, min_addr,
> > +						 MEMBLOCK_ALLOC_ACCESSIBLE,
> > +						 nid);
> > +
> > +	if (ptr && size > 0)
> > +		page_init_poison(ptr, size);
> > +
> > +	return ptr;
> > +}
> > +
> >  static int zone_batchsize(struct zone *zone)
> >  {
> >  #ifdef CONFIG_MMU
> > @@ -7501,8 +7521,8 @@ static void __ref alloc_node_mem_map(struct pglist_data *pgdat)
> >  		end = pgdat_end_pfn(pgdat);
> >  		end = ALIGN(end, MAX_ORDER_NR_PAGES);
> >  		size =  (end - start) * sizeof(struct page);
> > -		map = memblock_alloc_node(size, SMP_CACHE_BYTES,
> > -					  pgdat->node_id);
> > +		map = memmap_alloc(size, SMP_CACHE_BYTES, MEMBLOCK_LOW_LIMIT,
> > +				   pgdat->node_id, false);
> 
> Mostly offtopic, but...  Why is alloc_node_mem_map() marked __ref? 

Once free_area_init_node() was __meminit, I stopped digging at that point.

> afaict it can be __init?

Yes.

-- 
Sincerely yours,
Mike.
