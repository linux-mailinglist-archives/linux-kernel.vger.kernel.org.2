Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F27349152
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhCYL5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:57:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:32854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhCYL5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:57:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 594BEAA55;
        Thu, 25 Mar 2021 11:57:24 +0000 (UTC)
Date:   Thu, 25 Mar 2021 11:57:21 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [RFC] mm: activate access-more-than-once page via NUMA balancing
Message-ID: <20210325115721.GS15768@suse.de>
References: <20210324083209.527427-1-ying.huang@intel.com>
 <20210324103104.GN15768@suse.de>
 <87a6qrj1hy.fsf@yhuang6-desk1.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87a6qrj1hy.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 12:33:45PM +0800, Huang, Ying wrote:
> > I caution against this patch.
> >
> > It's non-deterministic for a number of reasons. As it requires NUMA
> > balancing to be enabled, the pageout behaviour of a system changes when
> > NUMA balancing is active. If this led to pages being artificially and
> > inappropriately preserved, NUMA balancing could be disabled for the
> > wrong reasons.  It only applies to pages that have no target node so
> > memory policies affect which pages are activated differently. Similarly,
> > NUMA balancing does not scan all VMAs and some pages may never trap a
> > NUMA fault as a result. The timing of when an address space gets scanned
> > is driven by the locality of pages and so the timing of page activation
> > potentially becomes linked to whether pages are local or need to migrate
> > (although not right now for this patch as it only affects pages with a
> > target nid of NUMA_NO_NODE). In other words, changes in NUMA balancing
> > that affect migration potentially affect the aging rate.  Similarly,
> > the activate rate of a process with a single thread and multiple threads
> > potentially have different activation rates.
> >
> > Finally, the NUMA balancing scan algorithm is sub-optimal. It potentially
> > scans the entire address space even though only a small number of pages
> > are scanned. This is particularly problematic when a process has a lot
> > of threads because threads are redundantly scanning the same regions. If
> > NUMA balancing ever introduced range tracking of faulted pages to limit
> > how much scanning it has to do, it would inadvertently cause a change in
> > page activation rate.
> >
> > NUMA balancing is about page locality, it should not get conflated with
> > page aging.
> 
> I understand your concerns about binding the NUMA balancing and page
> reclaiming.  The requirement of the page locality and page aging is
> different, so the policies need to be different.  This is the wrong part
> of the patch.
> 
> From another point of view, it's still possible to share some underlying
> mechanisms (and code) between them.  That is, scanning the page tables
> to make pages unaccessible and capture the page accesses via the page
> fault. 

Potentially yes but not necessarily recommended for page aging. NUMA
balancing has to be careful about the rate it scans pages to avoid
excessive overhead so it's driven by locality. The scanning happens
within a tasks context so during that time, the task is not executing
its normal work and it incurs the overhead for faults. Generally, this
is not too much overhead because pages get migrated locally, the scan
rate drops and so does the overhead.

However, if you want to drive page aging, that is constant so the rate
could not be easily adapted in a way that would be deterministic.

> Now these page accessing information is used for the page
> locality.  Do you think it's a good idea to use these information for
> the page aging too (but with a different policy as you pointed out)?
> 

I'm not completely opposed to it but I think the overhead it would
introduce could be severe. Worse, if a workload fits in memory and there
is limited to no memory pressure, it's all overhead for no gain. Early
generations of NUMA balancing had to find a balance to sure the gains
from locality exceeded the cost of measuring locality and doing the same
for page aging in some ways is even more challenging.

> From yet another point of view :-), in current NUMA balancing
> implementation, it's assumed that the node private pages can fit in the
> accessing node.  But this may be not always true.  Is it a valid
> optimization to migrate the hot private pages first?
> 

I'm not sure how the hotness of pages could be ranked. At the time of a
hinting fault, the page is by definition active now because it was been
accessed. Prioritising what pages to migrate based on the number of faults
that have been trapped would have to be stored somewhere.

-- 
Mel Gorman
SUSE Labs
