Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A414315900
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 22:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhBIVyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 16:54:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:52424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233624AbhBITY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:24:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A1C0ADF0;
        Tue,  9 Feb 2021 19:03:34 +0000 (UTC)
Date:   Tue, 9 Feb 2021 20:03:32 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: remove lru_add_drain_all in alloc_contig_range
Message-ID: <20210209190332.GA3363@localhost.localdomain>
References: <20210209175048.361638-1-minchan@kernel.org>
 <accc057c-e639-7510-f722-4a4d166c80b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <accc057c-e639-7510-f722-4a4d166c80b6@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 07:17:59PM +0100, David Hildenbrand wrote:
> On 09.02.21 18:50, Minchan Kim wrote:
> > __alloc_contig_migrate_range already has lru_add_drain_all call
> > via migrate_prep. It's necessary to move LRU taget pages into
> > LRU list to be able to isolated. However, lru_add_drain_all call
> > after __alloc_contig_migrate_range is called is pointless.
> > 
> > This patch removes it.
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >   mm/page_alloc.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 6446778cbc6b..f8fbee73dd6d 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -8603,8 +8603,6 @@ int alloc_contig_range(unsigned long start, unsigned long end,
> >   	 * isolated thus they won't get removed from buddy.
> >   	 */
> > -	lru_add_drain_all();
> > -
> >   	order = 0;
> >   	outer_start = start;
> >   	while (!PageBuddy(pfn_to_page(outer_start))) {
> > 
> 
> I was expecting some magical reason why this is still required but I am not
> able to find a compelling one. Maybe this is really some historical
> artifact.
> 
> Let's see if other people know why this call here still exists.

I also stumbled upon this while working on adding hugetlb support for
alloc_acontig_range [1].
I have to confess I puzzled me a bit.

I saw it going back to when the function was first introduced by 

commit 041d3a8cdc18dc375a128d90bbb753949a81b1fb
Author: Michal Nazarewicz <mina86@mina86.com>
Date:   Thu Dec 29 13:09:50 2011 +0100

    mm: page_alloc: introduce alloc_contig_range()


It does not make much sense to me. At this point our pages are free, so
we do not care about LRU handling here.
But I might be missing something.

[1] https://lore.kernel.org/linux-mm/20210208103935.GA32103@linux/T/#md651fc6e73c656105179382f92f8b2d6073051d1


-- 
Oscar Salvador
SUSE L3
