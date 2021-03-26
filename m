Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9D534A334
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 09:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCZIfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 04:35:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:51730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhCZIfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 04:35:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616747704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZ+o2ownkaSUuaR0SmiLIhcsIXTvEP71LgGgtalVwO8=;
        b=RPqHjStzLNBr+XCCQ7s7ctMkEkMjVlP3dRwMkE2JcQDluj2U0TeJODyPCL5awHo8xGnz+y
        c0vFXQ6O5G/rBhJP9R+y5+EIqO5cvC34NjUojpKeTYycUQtvbhtYhpliercl57RHIvIUrH
        AUVL0n1VtTwszS1VPJ1COPqA7F36mrI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC6E2AB8A;
        Fri, 26 Mar 2021 08:35:03 +0000 (UTC)
Date:   Fri, 26 Mar 2021 09:35:03 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YF2ct/UZUBG1GcM3@dhcp22.suse.cz>
References: <YFyfdDAoWON6IoPL@dhcp22.suse.cz>
 <31c3e6f7-f631-7b00-2c33-518b0f24a75f@redhat.com>
 <YFyoU/rkEPK3VPlN@dhcp22.suse.cz>
 <40fac999-2d28-9205-23f0-516fa9342bbe@redhat.com>
 <YFyt3UfoPkt7BbDZ@dhcp22.suse.cz>
 <YFy1J+mCyGmnwuHJ@dhcp22.suse.cz>
 <92fe19d0-56ac-e929-a9c1-d6a4e0da39d1@redhat.com>
 <YFy8ARml4R7/snVs@dhcp22.suse.cz>
 <YFy+olsdS4iwrovN@dhcp22.suse.cz>
 <YF0JerCFXzcmMKzp@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YF0JerCFXzcmMKzp@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-03-21 23:06:50, Oscar Salvador wrote:
> On Thu, Mar 25, 2021 at 05:47:30PM +0100, Michal Hocko wrote:
> > On Thu 25-03-21 17:36:22, Michal Hocko wrote:
> > > If all it takes is to make pfn_to_online_page work (and my
> > > previous attempt is incorrect because it should consult block rather
> > > than section pfn range)
> > 
> > This should work.
> 
> Sorry, but while this solves some of the issues with that approach, I really
> think that overcomplicates things and buys us not so much in return.
> To me it seems that we are just patching things to make it work that
> way.

I do agree that special casing vmemmap areas is something I do not
really like but we are in that schrödinger situation when this memory is
not onlineable unless it shares memory section with an onlineable
memory. There are two ways around that, either special case it on
pfn_to_online_page or mark the vmemmap section online even though it is
not really.

> To be honest, I dislike this, and I guess we can only agree to disagree
> here.

No problem there. I will not insist on my approach unless I can convince
you that it is a better solution. It seems I have failed and I can live
with that.

> I find the following much easier, cleaner, and less risky to encounter
> pitfalls in the future:
> 
> (!!!It is untested and incomplete, and I would be surprised if it even
> compiles, but it is enough as a PoC !!!)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 5ea2b3fbce02..799d14fc2f9b 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -169,6 +169,60 @@ int memory_notify(unsigned long val, void *v)
>  	return blocking_notifier_call_chain(&memory_chain, val, v);
>  }
> 
> +static int memory_block_online(unsigned long start_pfn, unsigned long nr_pages,
> +			       unsigned long nr_vmemmap_pages, int online_type,
> +			       int nid)
> +{
> +	int ret;
> +	/*
> +	 * Despite vmemmap pages having a different lifecycle than the pages
> +	 * they describe, initialiating and accounting vmemmap pages at the
> +	 * online/offline stage eases things a lot.

This requires quite some explaining.

> +	 * We do it out of {online,offline}_pages, so those routines only have
> +	 * to deal with pages that are actual usable memory.
> +	 */
> +	if (nr_vmemmap_pages) {
> +		struct zone *z;
> +
> +		z = zone_for_pfn_range(online_type, nid, start_pfn, nr_pages);
> +		move_pfn_range_to_zone(z, start_pfn, nr_vmemmap_pages, NULL,
> +				       MIGRATE_UNMOVABLE);
> +		/*
> +		 * The below could go to a helper to make it less bulky here,
> +		 * so {online,offline}_pages could also use it.
> +		 */
> +		z->present_pages += nr_pages;
> +		pgdat_resize_lock(z->zone_pgdat, &flags);
> +		z->zone_pgdat->node_present_pages += nr_pages;
> +		pgdat_resize_unlock(z->zone_pgdat, &flags);
> +	}
> +
> +	ret = online_pages(start_pfn + nr_vmemmap_pages, nr_pages - nr_vmemmap_pages,
> +			   online_type);
> +
> +	/*
> +	 * In case online_pages() failed for some reason, we should cleanup vmemmap
> +	 * accounting as well.
> +	 */
> +	return ret;
> +}

Yes this is much better! Just a minor suggestion would be to push
memory_block all the way to memory_block_online (it oline a memory
block). I would also slightly prefer to provide 2 helpers that would make
it clear that this is to reserve/cleanup the vmemamp space (defined in
the memory_hotplug proper).

Thanks!
-- 
Michal Hocko
SUSE Labs
