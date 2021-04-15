Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A060D360490
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhDOIma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:42:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:48910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231536AbhDOIm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:42:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B96FEB1EC;
        Thu, 15 Apr 2021 08:42:05 +0000 (UTC)
Date:   Thu, 15 Apr 2021 10:42:03 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/7] mm,compaction: Let
 isolate_migratepages_{range,block} return error codes
Message-ID: <YHf8W9fWVIWFpG1K@localhost.localdomain>
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-3-osalvador@suse.de>
 <2628d20e-3304-1a0c-5246-cfc2320cce8b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2628d20e-3304-1a0c-5246-cfc2320cce8b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 01:54:17PM +0200, David Hildenbrand wrote:
> >    * Isolate all pages that can be migrated from the range specified by
> >    * [low_pfn, end_pfn). The range is expected to be within same pageblock.
> > - * Returns zero if there is a fatal signal pending, otherwise PFN of the
> > - * first page that was not scanned (which may be both less, equal to or more
> > - * than end_pfn).
> > + * Returns errno, like -EAGAIN or -EINTR in case e.g signal pending or congestion,
> > + * or 0.
> > + * cc->migrate_pfn will contain the next pfn to scan (which may be both less,
> > + * equal to or more that end_pfn).
> 
> I failed to parse the last sentence -- e.g., using "both" and then listing
> three options. Also, s/than/than/? Can we simplify to
> 
> "cc->migrate_pfn will contain the next pfn to scan"

Ok, will simplify

> >   /**
> > @@ -1139,15 +1144,15 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> >    * @start_pfn: The first PFN to start isolating.
> >    * @end_pfn:   The one-past-last PFN.
> >    *
> > - * Returns zero if isolation fails fatally due to e.g. pending signal.
> > - * Otherwise, function returns one-past-the-last PFN of isolated page
> > - * (which may be greater than end_pfn if end fell in a middle of a THP page).
> > + * Returns errno, like -EAGAIN or -EINTR in case e.g signal pending or congestion,
> 
> errno is usually positive.
> 
> > + * or 0.
> 
> I'd be more specific here. Something like
> 
> "
> Returns 0 if isolation succeeded. Returns -EINTR if a fatal signal is
> pending. Returns -EAGAIN when contended and the caller should retry.
> 
> In any case, cc->migrate_pfn is set to one-past-the-last PFN that has been
> isolated.
> "

I will try to reword it. Although note that 0 does not mean the
isolation succeeded.
Compaction tracks whether we could isolate pages by means of
cc->nr_migratepages.

The thing is that alloc_contig_range and compaction code need different
things.
Compaction wants to isolate and migrate as much as it needs to in order to
form a higher-order page (or in case
if it is trying to compact the whole zone, it goes through the zone).
alloc_contig_range() needs to isolate the whole range we specified in
order to be able to migrate it and make it free for whoever wants to use
it.

Let us say that the interface between alloc_contig_range() and
compaction still needs some more love that I plan to work on when this goes
in.


-- 
Oscar Salvador
SUSE L3
