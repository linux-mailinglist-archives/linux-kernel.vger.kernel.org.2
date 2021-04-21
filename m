Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93414366747
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbhDUIuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:50:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:41702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhDUIuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:50:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618994987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KTcOC/wq14K4jvcGjobMJQkY4UR5EvlZWWMMmYOurXw=;
        b=A1J/u8MPGeNdJ7k7m+Tii4ybAdkIzcqRn7pi9mD0uZ2cv7vc0fO3h2MyulXiUxWfGOAmfn
        nZlLefsjTz2mCYIMpVT2CPpu6DsHm/rx+973gpuEgmTSOI11RsPt03Ovk/QVwMviy5RcBh
        JSa+vzOfx/3QSSBQ7LvmO/hKjj8hj0c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52782B176;
        Wed, 21 Apr 2021 08:49:47 +0000 (UTC)
Date:   Wed, 21 Apr 2021 10:49:46 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/8] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YH/nKqrV2orwHeya@dhcp22.suse.cz>
References: <20210416112411.9826-1-osalvador@suse.de>
 <20210416112411.9826-5-osalvador@suse.de>
 <YH6zQ1Dty9kJFkuk@dhcp22.suse.cz>
 <20210421081546.GD22456@linux>
 <YH/ktDG/9o2OHNGj@dhcp22.suse.cz>
 <c248d75d-fe50-7d3f-69bc-6df3241f39ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c248d75d-fe50-7d3f-69bc-6df3241f39ac@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-04-21 10:44:38, David Hildenbrand wrote:
> On 21.04.21 10:39, Michal Hocko wrote:
> > On Wed 21-04-21 10:15:46, Oscar Salvador wrote:
> > > On Tue, Apr 20, 2021 at 12:56:03PM +0200, Michal Hocko wrote:
> > [...]
> > > > necessary. Using two different iteration styles is also hurting the code
> > > > readability. I would go with the following
> > > > 	for (pfn = start_pfn; pfn < end_pfn; ) {
> > > > 		unsigned long order = min(MAX_ORDER - 1UL, __ffs(pfn));
> > > > 
> > > > 		while (start + (1UL << order) > end_pfn)
> > > >                          order--;
> > > > 		(*online_page_callback)(pfn_to_page(pfn), pageblock_order);
> > > > 		pfn += 1 << order;
> > > > 	}
> > > > 
> > > > which is what __free_pages_memory does already.
> > > 
> > > this is kinda what I used to have in the early versions, but it was agreed
> > > with David to split it in two loops to make it explicit.
> > > I can go back to that if it is preferred.
> > 
> > Not that I would insist but I find it better to use common constructs
> > when it doesn't hurt readability. The order evaluation can be even done
> > in a trivial helper.
> > 
> > > > > +	if (memmap_on_memory) {
> > > > > +		nr_vmemmap_pages = walk_memory_blocks(start, size, NULL,
> > > > > +						      get_nr_vmemmap_pages_cb);
> > > > > +		if (nr_vmemmap_pages) {
> > > > > +			if (size != memory_block_size_bytes()) {
> > > > > +				pr_warn("Refuse to remove %#llx - %#llx,"
> > > > > +					"wrong granularity\n",
> > > > > +					start, start + size);
> > > > > +				return -EINVAL;
> > > > > +			}
> > > > > +
> > > > > +			/*
> > > > > +			 * Let remove_pmd_table->free_hugepage_table do the
> > > > > +			 * right thing if we used vmem_altmap when hot-adding
> > > > > +			 * the range.
> > > > > +			 */
> > > > > +			mhp_altmap.alloc = nr_vmemmap_pages;
> > > > > +			altmap = &mhp_altmap;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > >   	/* remove memmap entry */
> > > > >   	firmware_map_remove(start, start + size, "System RAM");
> > > > 
> > > > I have to say I still dislike this and I would just wrap it inside out
> > > > and do the operation from within walk_memory_blocks but I will not
> > > > insist.
> > > 
> > > I have to confess I forgot about the details of that dicussion, as we were
> > > quite focused on decoupling vmemmap pages from {online,offline} interface.
> > > Would you mind elaborating a bit more?
> > 
> > As I've said I will not insist and this can be done in the follow up.
> > You are iterating over memory blocks just to refuse to do an operation
> > which can be split to several memory blocks. See
> > http://lkml.kernel.org/r/YFtPxH0CT5QZsnR1@dhcp22.suse.cz and follow
> > walk_memory_blocks(start, size, NULL, remove_memory_block_cb)
> > 
> 
> We'll have to be careful in general when removing memory in different
> granularity than it was added, especially calling arch_remove_memory() in
> smaller granularity than it was added via arch_add_memory(). We might fail
> to tear down the direct map, imagine having mapped a 1GiB page but decide to
> remove individual 128 MiB chunks -- that won't work and the direct map would
> currently remain.

Agreed but I am not referring to arbitrary hotremove path. All I am
pointing at is to split up to memory blocks and do the same kind of work
on each separately. Partial failures might turn out to be more tricky
and as I've said I do not insist on doing that right now but it is a bit
weird to outright fail the operation even when in fact there are more
blocks to be hot removed in once.
-- 
Michal Hocko
SUSE Labs
