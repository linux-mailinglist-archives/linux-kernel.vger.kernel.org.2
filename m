Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0BC31EC76
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 17:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhBRQpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 11:45:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:44422 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232198AbhBROAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 09:00:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613656781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lgTJXDtHZ7f4SQvSOSpC+i5e37PXzyHNAje7FYKp6bw=;
        b=JiMLA3jObClwxXa9KllaXZCzOxuB7TceARQau9wmKvnRrtqxycVGASVLWo3jg1tw324L/h
        uI7mfT14P8CM/KIV2KgJEbTo/jahFQ31xphpsKgRzq0IU50bHlVQppfD0vV7rg10WmvAK1
        vcxjoWKweF803EXgNPEs8mXfSS2WdhY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C929AF4C;
        Thu, 18 Feb 2021 13:59:41 +0000 (UTC)
Date:   Thu, 18 Feb 2021 14:59:40 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Message-ID: <YC5yzNB9xT76fkod@dhcp22.suse.cz>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-2-osalvador@suse.de>
 <YC0ve4PP+VTrEEtw@dhcp22.suse.cz>
 <20210218100917.GA4842@localhost.localdomain>
 <YC5jFrwegRVkMkBQ@dhcp22.suse.cz>
 <20210218133250.GA7983@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218133250.GA7983@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-02-21 14:32:50, Oscar Salvador wrote:
> On Thu, Feb 18, 2021 at 01:52:38PM +0100, Michal Hocko wrote:
> > > Ok, makes sense.
> > > __GFP_THISNODE will not allow fallback to other node's zones.
> > > Since we only allow the nid the page belongs to, nodemask should be
> > > NULL, right?
> > 
> > I would have to double check because hugetlb has a slightly different
> > expectations from nodemask than the page allocator. The later translates
> > that to all possible nodes but hugetlb API tries to dereference nodes.
> > Maybe THIS node special cases it somewhere.
> 
> Uhm, I do not quite follow here.
> AFAICS, alloc_fresh_huge_page->alloc_buddy_huge_page does nothing
> with the nodemask, bur rather with nodes_retry mask. That is done
> to not retry on a node we failed to allocate a page.
> 
> Now, alloc_buddy_huge_page calls __alloc_pages_nodemask directly.
> If my understanding is correct, it is ok to have a null nodemask
> as __next_zones_zonelist() will go through our own zonelist,
> since __GFP_THISNODE made us take ZONELIST_NOFALLBACK.

As I've said. Page allocator can cope with NULL nodemask just fine.
I have checked the code and now remember the tricky part. It is
alloc_gigantic_page which cannot work with NULL nodemask because it
relies on for_each_node_mask and that, unlike zonelist iterator, cannot
cope with NULL node mask. This is the case only for !GFP_THISNODE.

> Actually, I do not see how passing a non-null nodemask migth have
> helped there, unless we allow to specify more nodes.

No, nodemask is doesn't make any difference.
 
> > > I did. The 'put_page' call should be placed above, right after getting
> > > the page. Otherwise, refcount == 1 and we will fail to dissolve the
> > > new page if we need to (in case old page fails to be dissolved).
> > > I already fixed that locally.
> > 
> > I am not sure I follow. newly allocated pages is unreferenced
> > unconditionally and the old page is not referenced by this path.
> 
> Current code is:
> 
>  allocate_a_new_page (new_page's refcount = 1)
>  dissolve_old_page
>   : if fail
>      dissolve_new_page (we cannot dissolve it refcount != 0)
>  put_page(new_page);

OK, new_page would go to the pool rather than get freed as this is
neither a surplus nnor a temporary page.

> It should be:
> 
>  allocate_a_new_page (new_page's refcount = 1)
>  put_page(new_page); (new_page's refcount = 0)
>  dissolve_old_page
>   : if fail
>      dissolve_new_page (we can dissolve it as refcount == 0)
> 
> I hope this clarifies it .

OK, I see the problem now. And your above solution is not really
optimal either. Your put_page would add the page to the pool and so it
could be used by somebody. One way around it would be either directly
manipulating reference count which is fugly or you can make it a
temporal page (alloc_migrate_huge_page) or maybe even better not special
case this here but rather allow migrating free hugetlb pages in the
migrate_page path.
-- 
Michal Hocko
SUSE Labs
