Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1176731E91F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhBRLZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:25:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:43712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232566AbhBRKKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:10:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A42DEADE5;
        Thu, 18 Feb 2021 10:09:20 +0000 (UTC)
Date:   Thu, 18 Feb 2021 11:09:17 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Message-ID: <20210218100917.GA4842@localhost.localdomain>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-2-osalvador@suse.de>
 <YC0ve4PP+VTrEEtw@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC0ve4PP+VTrEEtw@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 04:00:11PM +0100, Michal Hocko wrote:
> Is this really necessary? dissolve_free_huge_page will take care of this
> and the race windown you are covering is really tiny.

Probably not, I was trying to shrink to race window as much as possible
but the call to dissolve_free_huge_page might be enough.

> > +	nid = page_to_nid(page);
> > +	spin_unlock(&hugetlb_lock);
> > +
> > +	/*
> > +	 * Before dissolving the page, we need to allocate a new one,
> > +	 * so the pool remains stable.
> > +	 */
> > +	new_page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
> 
> wrt. fallback to other zones, I haven't realized that the primary
> usecase is a form of memory offlining (from virt-mem). I am not yet sure
> what the proper behavior is in that case but if breaking hugetlb pools,
> similar to the normal hotplug operation, is viable then this needs a
> special mode. We do not want a random alloc_contig_range user to do the
> same. So for starter I would go with __GFP_THISNODE here.

Ok, makes sense.
__GFP_THISNODE will not allow fallback to other node's zones.
Since we only allow the nid the page belongs to, nodemask should be
NULL, right?

> > +	if (!h)
> > +		/*
> > +		 * The page might have been dissolved from under our feet.
> > +		 * If that is the case, return success as if we dissolved it
> > +		 * ourselves.
> > +		 */
> > +		return true;
> 
> nit I would put the comment above the conditin for both cases. It reads
> more easily that way. At least without { }.

Yes, makes sense.

> Other than that I haven't noticed any surprises.

I did. The 'put_page' call should be placed above, right after getting
the page. Otherwise, refcount == 1 and we will fail to dissolve the
new page if we need to (in case old page fails to be dissolved).
I already fixed that locally.

-- 
Oscar Salvador
SUSE L3
