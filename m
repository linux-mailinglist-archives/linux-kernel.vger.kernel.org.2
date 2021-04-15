Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9351C360441
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhDOI2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:28:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:37574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231488AbhDOI2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:28:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 266A3B1B0;
        Thu, 15 Apr 2021 08:28:26 +0000 (UTC)
Date:   Thu, 15 Apr 2021 10:28:23 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/7] mm: Make alloc_contig_range handle free hugetlb
 pages
Message-ID: <YHf5J0YRtTAWCPAi@localhost.localdomain>
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-6-osalvador@suse.de>
 <71cce295-91d3-21d8-5075-04a2e828d0f2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71cce295-91d3-21d8-5075-04a2e828d0f2@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 02:26:21PM +0200, David Hildenbrand wrote:
> > +static inline int isolate_or_dissolve_huge_page(struct page *page)
> > +{
> > +	return -ENOMEM;
> 
> Without CONFIG_HUGETLB_PAGE, there is no way someone could possible pass in
> something valid. Although it doesn't matter too much, -EINVAL or similar
> sounds a bit better.

I guess we could, was just to make it consistent with the kind of error
we return when we have it enabled.

> > @@ -809,6 +809,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> >   	bool skip_on_failure = false;
> >   	unsigned long next_skip_pfn = 0;
> >   	bool skip_updated = false;
> > +	bool fatal_error = false;
> 
> Can't we use "ret == -ENOMEM" instead of fatal_error?

Yes, we can, I will see how it looks.

[...]

> > +	/*
> > +	 * Fence off gigantic pages as there is a cyclic dependency between
> > +	 * alloc_contig_range and them. Return -ENOME as this has the effect
> 
> s/-ENOME/-ENOMEM/

thanks, I missed that one.

> 
> > +	 * of bailing out right away without further retrying.
> > +	 */
> > +	if (hstate_is_gigantic(h))
> > +		return -ENOMEM;
> > +
> > +	return alloc_and_dissolve_huge_page(h, head);
> > +}
> > +
> >   struct page *alloc_huge_page(struct vm_area_struct *vma,
> >   				    unsigned long addr, int avoid_reserve)
> >   {
> > 
> 
> Complicated stuff, but looks good to me.

Thanks for having a look!

-- 
Oscar Salvador
SUSE L3
