Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4C032D096
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 11:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbhCDKUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 05:20:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:47392 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238392AbhCDKUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:20:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24362AAC5;
        Thu,  4 Mar 2021 10:19:39 +0000 (UTC)
Date:   Thu, 4 Mar 2021 11:19:36 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: Make alloc_contig_range handle free hugetlb
 pages
Message-ID: <YEC0ODM5gtEU+JqN@localhost.localdomain>
References: <20210222135137.25717-1-osalvador@suse.de>
 <20210222135137.25717-2-osalvador@suse.de>
 <3f071dd4-3181-f4e0-fd56-1a70f6ac72fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f071dd4-3181-f4e0-fd56-1a70f6ac72fe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 03:09:06PM +0100, David Hildenbrand wrote:
> On 22.02.21 14:51, Oscar Salvador wrote:
> > @@ -905,6 +905,18 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> >   			valid_page = page;
> >   		}
> > +		if (PageHuge(page) && cc->alloc_contig) {
> > +			if (!isolate_or_dissolve_huge_page(page))
> > +				goto isolate_fail;

Bleh, sorry for the lateness David, I was farly busy.

> So, the callchain is:
> 
> alloc_contig_range()->__alloc_contig_migrate_range()->isolate_migratepages_range()->isolate_migratepages_block()
> 
> The case I am thinking about is if we run out of memory and would return
> -ENOMEM from alloc_and_dissolve_huge_page(). We silently drop the real error
> (e.g., -ENOMEM vs. -EBUSY vs. e.g., -EAGAIN) we had in
> isolate_or_dissolve_huge_page().

Yes, that is true.

> I think we should not swallo such return values in
> isolate_or_dissolve_huge_page() and instead properly report esp. -ENOMEM
> properly up this callchain now. Otherwise we'll end up retrying / reporting
> -EBUSY, which is misleading.

I am not sure I follow you here.
So, atm, alloc_and_dissolve_huge_page can either generate -ENOMEM or
-EBUSY wrt. error codes.
-ENOMEM when we cannot allocate a page, and -EBUSY when we raced with
someone.
You mean to only report ENOMEM down the chain?

> From isolate_migratepages_range()/isolate_migratepages_block() we'll keep
> reporting "pfn > 0".
> 
> a) In isolate_migratepages_range() we'll keep iterating over pageblocks
> although we should just fail with -ENOMEM right away.
> 
> b) In __alloc_contig_migrate_range() we'll keep retrying up to 5 times
> although we should just fail with -ENOMEM. We end up returning "-EBUSY"
> after retrying.
> 
> c) In alloc_contig_range() we'll continue trying to isolate although we
> should just return -ENOMEM.

Yes, "fatal" errors get masked, and hence we treat everything as "things
are busy, let us try again", and this is rather unforunate.

> I think we have should start returning proper errors from
> isolate_migratepages_range()/isolate_migratepages_block() on critical issues
> (-EINTR, -ENOMEM) instead of going via "!pfn vs. pfn" and retrying on "pfn".
> 
> So we should then fail with -ENOMEM during isolate_migratepages_range()
> cleanly, just as we would do when we get -ENOMEM during migrate_pages().

I guess we could rework the interface and make isolate_migratepages_range and
isolate_migratepages_block to report the right thing.
I yet have to check that this does not mess up a lot with the compaction
interface.

But overall I agree with your point here, and I am willing to to tackle
this.

The question is whether we want to do this as part of this series, or
after this series gets picked up.
IMHO, we could do it after, as a follow-up, unless you feel strong about
it.

What do you think?


-- 
Oscar Salvador
SUSE L3
