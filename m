Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BBF3168B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhBJOK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:10:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:52336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230061AbhBJOK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:10:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E021AC97;
        Wed, 10 Feb 2021 14:09:43 +0000 (UTC)
Date:   Wed, 10 Feb 2021 15:09:41 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mm,page_alloc: Make alloc_contig_range handle
 in-use hugetlb pages
Message-ID: <20210210140941.GA3636@localhost.localdomain>
References: <20210208103812.32056-1-osalvador@suse.de>
 <20210208103812.32056-2-osalvador@suse.de>
 <6aa21eb3-7bee-acff-8f3c-7c13737066ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aa21eb3-7bee-acff-8f3c-7c13737066ba@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:56:37AM +0100, David Hildenbrand wrote:
> On 08.02.21 11:38, Oscar Salvador wrote:
> > alloc_contig_range is not prepared to handle hugetlb pages and will
> > fail if it ever sees one, but since they can be migrated as any other
> > page (LRU and Movable), it makes sense to also handle them.
> > 
> > For now, do it only when coming from alloc_contig_range.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > ---
> >   mm/compaction.c | 17 +++++++++++++++++
> >   mm/vmscan.c     |  5 +++--
> >   2 files changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index e5acb9714436..89cd2e60da29 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -940,6 +940,22 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> >   			goto isolate_fail;
> >   		}
> > +		/*
> > +		 * Handle hugetlb pages only when coming from alloc_contig
> > +		 */
> > +		if (PageHuge(page) && cc->alloc_contig) {
> > +			if (page_count(page)) {
> 
> I wonder if we should care about races here. What if someone concurrently
> allocates/frees?
> 
> Note that PageHuge() succeeds on tail pages, isolate_huge_page() not, i
> assume we'll have to handle that as well.
> 
> I wonder if it would make sense to move some of the magic to hugetlb code
> and handle it there with less chances for races (isolate if used,
> alloc-and-dissolve if not).

Yes, it makes sense to keep the magic in hugetlb code.
Note, though, that removing all races might be tricky.

isolate_huge_page() checks for PageHuge under hugetlb_lock,
so there is a race between a call to PageHuge(x) and a subsequent
call to isolate_huge_page().
But we should be fine as isolate_huge_page will fail in case the page is
no longer HugeTLB.

Also, since isolate_migratepages_block() gets called with ranges
pageblock aligned, we should never be handling tail pages in the core
of the function. E.g: the same way we handle THP:

    /* The whole page is taken off the LRU; skip the tail pages. */
    if (PageCompound(page))
           low_pfn += compound_nr(page) - 1;

But all in all, the code has to be more bullet-proof. This RFC was more
like a PoC to see whether something crazy was done.
And as I said, moving the handling of hugetlb pages to hugetlb.c might
help towards a better error-race-handling.

Thanks for having a look ;-)

-- 
Oscar Salvador
SUSE L3
