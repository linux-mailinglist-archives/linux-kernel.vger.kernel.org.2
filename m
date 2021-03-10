Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416033344C4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhCJRFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:05:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:57834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233026AbhCJRFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:05:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615395907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oxRVGJsvmt7dqxKyl+MpB2xrjmX1Sge7XlOHbCjXxss=;
        b=DIDGktoo8TcsZBKYJO7KqeoyDFfd369JaxJlZfuiymiwaxTZXqkzKWjIKSWHliSvFsLsaj
        LeeAD2GlrgtQGoDzptqHyNXLfyJXZ96yxc9L3wQ0m4jluIZT1dCDj5F+fh85MLVJK/aW3b
        oov0qS2Lqd8EaOS5XptvEoDIRIF+mPw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4B7CABD7;
        Wed, 10 Mar 2021 17:05:07 +0000 (UTC)
Date:   Wed, 10 Mar 2021 18:05:07 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 0/3] hugetlb: add demote/split page functionality
Message-ID: <YEj8QwPAvZe5QhsC@dhcp22.suse.cz>
References: <20210309001855.142453-1-mike.kravetz@oracle.com>
 <YEjyS+xyeNlMcW/l@dhcp22.suse.cz>
 <298CE371-115E-4A78-A732-57D7B37DF74C@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <298CE371-115E-4A78-A732-57D7B37DF74C@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-03-21 11:46:57, Zi Yan wrote:
> On 10 Mar 2021, at 11:23, Michal Hocko wrote:
> 
> > On Mon 08-03-21 16:18:52, Mike Kravetz wrote:
> > [...]
> >> Converting larger to smaller hugetlb pages can be accomplished today by
> >> first freeing the larger page to the buddy allocator and then allocating
> >> the smaller pages.  However, there are two issues with this approach:
> >> 1) This process can take quite some time, especially if allocation of
> >>    the smaller pages is not immediate and requires migration/compaction.
> >> 2) There is no guarantee that the total size of smaller pages allocated
> >>    will match the size of the larger page which was freed.  This is
> >>    because the area freed by the larger page could quickly be
> >>    fragmented.
> >
> > I will likely not surprise to show some level of reservation. While your
> > concerns about reconfiguration by existing interfaces are quite real is
> > this really a problem in practice? How often do you need such a
> > reconfiguration?
> >
> > Is this all really worth the additional code to something as tricky as
> > hugetlb code base?
> >
> >>  include/linux/hugetlb.h |   8 ++
> >>  mm/hugetlb.c            | 199 +++++++++++++++++++++++++++++++++++++++-
> >>  2 files changed, 204 insertions(+), 3 deletions(-)
> >>
> >> -- 
> >> 2.29.2
> >>
> 
> The high level goal of this patchset seems to enable flexible huge page
> allocation from a single pool, when multiple huge page sizes are available
> to use. The limitation of existing mechanism is that user has to specify
> how many huge pages he/she wants and how many gigantic pages he/she wants
> before the actual use.

I believe I have understood this part. And I am not questioning that.
This seems useful. I am mostly asking whether we need such a
flexibility. Mostly because of the additional code and future
maintenance complexity which has turned to be a problem for a long time.
Each new feature tends to just add on top of the existing complexity.

> I just want to throw an idea here, please ignore if it is too crazy.
> Could we have a variant buddy allocator for huge page allocations,
> which only has available huge page orders in the free list? For example,
> if user wants 2MB and 1GB pages, the allocator will only have order-9 and
> order-19 pages; when order-9 pages run out, we can split order-19 pages;
> if possible, adjacent order-9 pages can be merged back to order-19 pages.

I assume you mean to remove those pages from the allocator when they
are reserved rather than really used, right? I am not really sure how
you want to deal with lower orders consuming/splitting too much from
higher orders which then makes those unusable for the use even though
they were preallocated for a specific workload. Another worry is that a
gap between 2MB and 1GB pages is just too big so a single 2MB request
from 1G pool will make the whole 1GB page unusable even when the smaller
pool needs few pages.
-- 
Michal Hocko
SUSE Labs
