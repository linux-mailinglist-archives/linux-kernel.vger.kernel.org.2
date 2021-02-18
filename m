Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BFB31EC1A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 17:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhBRQPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 11:15:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:60774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231139AbhBRNd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 08:33:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A2CF4AF49;
        Thu, 18 Feb 2021 13:33:09 +0000 (UTC)
Date:   Thu, 18 Feb 2021 14:32:50 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Message-ID: <20210218133250.GA7983@localhost.localdomain>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-2-osalvador@suse.de>
 <YC0ve4PP+VTrEEtw@dhcp22.suse.cz>
 <20210218100917.GA4842@localhost.localdomain>
 <YC5jFrwegRVkMkBQ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC5jFrwegRVkMkBQ@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 01:52:38PM +0100, Michal Hocko wrote:
> > Ok, makes sense.
> > __GFP_THISNODE will not allow fallback to other node's zones.
> > Since we only allow the nid the page belongs to, nodemask should be
> > NULL, right?
> 
> I would have to double check because hugetlb has a slightly different
> expectations from nodemask than the page allocator. The later translates
> that to all possible nodes but hugetlb API tries to dereference nodes.
> Maybe THIS node special cases it somewhere.

Uhm, I do not quite follow here.
AFAICS, alloc_fresh_huge_page->alloc_buddy_huge_page does nothing
with the nodemask, bur rather with nodes_retry mask. That is done
to not retry on a node we failed to allocate a page.

Now, alloc_buddy_huge_page calls __alloc_pages_nodemask directly.
If my understanding is correct, it is ok to have a null nodemask
as __next_zones_zonelist() will go through our own zonelist,
since __GFP_THISNODE made us take ZONELIST_NOFALLBACK.

Actually, I do not see how passing a non-null nodemask migth have
helped there, unless we allow to specify more nodes.

> > I did. The 'put_page' call should be placed above, right after getting
> > the page. Otherwise, refcount == 1 and we will fail to dissolve the
> > new page if we need to (in case old page fails to be dissolved).
> > I already fixed that locally.
> 
> I am not sure I follow. newly allocated pages is unreferenced
> unconditionally and the old page is not referenced by this path.

Current code is:

 allocate_a_new_page (new_page's refcount = 1)
 dissolve_old_page
  : if fail
     dissolve_new_page (we cannot dissolve it refcount != 0)
 put_page(new_page);

It should be:

 allocate_a_new_page (new_page's refcount = 1)
 put_page(new_page); (new_page's refcount = 0)
 dissolve_old_page
  : if fail
     dissolve_new_page (we can dissolve it as refcount == 0)

I hope this clarifies it .

-- 
Oscar Salvador
SUSE L3
