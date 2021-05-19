Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3B2388EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353638AbhESN0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:26:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346776AbhESN0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:26:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5269460FDA;
        Wed, 19 May 2021 13:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621430713;
        bh=EVzzh57rehbOK39R2k9GukpiN4HMiF1r3EbBJxvEg3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eamEd3MBrSqKDC0vuk6Vdp4/tNPGkq3i4Y3ObKZl3uv35f4rF1LfNY1h11Aeph45O
         8HtTwpHiv0xX0od/gf8xL+Io19t9xlWZzG5q/9kh4XdZFAcL8XrvbzOBdKuGHwxWit
         xiF10XNATvffhIDuD6N1Is4k19sqZSXppf5q+TCtQq7sNGAHe5Uwq4aQ6vQeai30x4
         g8uyCdOQm6Dr3LVb63hb+q7d+Ke32hsjJlTmt5quBu1RerTzoH/fN67ZD//Iw25BW1
         VyiAfUTQhvdueyHtdwdU6MDY0kG781rxPQ7TJuwEwpf5Q5msQPeVTePLpT+DC/NrWi
         LXVntDoYnFSIw==
Date:   Wed, 19 May 2021 16:25:06 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] arm: extend pfn_valid to take into accound freed
 memory map alignment
Message-ID: <YKURsrhVEW0jsPrP@kernel.org>
References: <20210518090613.21519-1-rppt@kernel.org>
 <20210518090613.21519-4-rppt@kernel.org>
 <2d34f990-c609-88aa-1dc0-f8e9e9623fc3@huawei.com>
 <YKPi0eBWsHBDZCg/@kernel.org>
 <779d890b-6983-6138-4f74-eef7be0bbd4c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <779d890b-6983-6138-4f74-eef7be0bbd4c@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 09:50:46AM +0800, Kefeng Wang wrote:
> 
> On 2021/5/18 23:52, Mike Rapoport wrote:
> > On Tue, May 18, 2021 at 08:49:43PM +0800, Kefeng Wang wrote:
> > > 
> > > 
> > > On 2021/5/18 17:06, Mike Rapoport wrote:
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > 
> > > > When unused memory map is freed the preserved part of the memory map is
> > > > extended to match pageblock boundaries because lots of core mm
> > > > functionality relies on homogeneity of the memory map within pageblock
> > > > boundaries.
> > > > 
> > > > Since pfn_valid() is used to check whether there is a valid memory map
> > > > entry for a PFN, make it return true also for PFNs that have memory map
> > > > entries even if there is no actual memory populated there.
> > > > 
> > > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > > ---
> > > >    arch/arm/mm/init.c | 15 ++++++++++++++-
> > > >    1 file changed, 14 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> > > > index 9d4744a632c6..bb678c0ba143 100644
> > > > --- a/arch/arm/mm/init.c
> > > > +++ b/arch/arm/mm/init.c
> > > > @@ -125,11 +125,24 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
> > > >    int pfn_valid(unsigned long pfn)
> > > >    {
> > > >    	phys_addr_t addr = __pfn_to_phys(pfn);
> > > > +	unsigned long pageblock_size = PAGE_SIZE * pageblock_nr_pages;
> > > >    	if (__phys_to_pfn(addr) != pfn)
> > > >    		return 0;
> > > > -	return memblock_is_map_memory(addr);
> > > > +	if (memblock_is_map_memory(addr))
> > > > +		return 1;
> > > > +
> > > > +	/*
> > > > +	 * If address less than pageblock_size bytes away from a present
> > > > +	 * memory chunk there still will be a memory map entry for it
> > > > +	 * because we round freed memory map to the pageblock boundaries
> > > > +	 */
> > > > +	if (memblock_is_map_memory(ALIGN(addr + 1, pageblock_size)) ||
> > > > +	    memblock_is_map_memory(ALIGN_DOWN(addr, pageblock_size)))
> > > > +		return 1;
> > > 
> > > Hi Mike, with patch3, the system won't boot.
> > 
> > Hmm, apparently I've miscalculated the ranges...
> > 
> > Can you please check with the below patch on top of this series:
> 
> Yes, it works,
> 
> On node 0 totalpages: 311551
>   Normal zone: 1230 pages used for memmap
>   Normal zone: 0 pages reserved
>   Normal zone: 157440 pages, LIFO batch:31
>   Normal zone: 17152 pages in unavailable ranges
>   HighMem zone: 154111 pages, LIFO batch:31
>   HighMem zone: 513 pages in unavailable ranges
> 
> and the oom testcase could pass.
> 
> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> 
> There is memblock_is_region_reserved(check if a region intersects reserved
> memory), it also checks the size, should we add a similar func?

We already have memblock_is_region_memory() that checks if the entire
region is a subset of memory. :(
 
Let's deal with this mess afterwards.
 
> > 
> > diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> > index bb678c0ba143..2fafbbc8e73b 100644
> > --- a/arch/arm/mm/init.c
> > +++ b/arch/arm/mm/init.c
> > @@ -138,8 +138,9 @@ int pfn_valid(unsigned long pfn)
> >   	 * memory chunk there still will be a memory map entry for it
> >   	 * because we round freed memory map to the pageblock boundaries
> >   	 */
> > -	if (memblock_is_map_memory(ALIGN(addr + 1, pageblock_size)) ||
> > -	    memblock_is_map_memory(ALIGN_DOWN(addr, pageblock_size)))
> > +	if (memblock_overlaps_region(&memblock.memory,
> > +				     ALIGN_DOWN(addr, pageblock_size),
> > +				     pageblock_size);
> >   		return 1;
> >   	return 0;
> > 

-- 
Sincerely yours,
Mike.
