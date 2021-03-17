Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5A533F447
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 16:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhCQPsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 11:48:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:58596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232462AbhCQPsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615993185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8wlUJ/RSEBBLs0jF97vqwhJZJz4F8UMg58PVuSBoV4k=;
        b=ExuMOGyYPL+NdP9Y7Gd23dg31jwl7kJS8e5ImSI861odxTdXl2CZ0w0azjB30g+nybKoBV
        BXeRYI5TxF+SMQnBFl7N47vhCWC3melXe+qpUZkzK2G9ghiaxeejY44ub4hognNK4Rugf/
        Bp0vMW2XIN4jAO6vO3nVZBduq1NG85E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7ED3CAE37;
        Wed, 17 Mar 2021 14:59:45 +0000 (UTC)
Date:   Wed, 17 Mar 2021 15:59:34 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] mm,compaction: Let
 isolate_migratepages_{range,block} return error codes
Message-ID: <YFIZVvQllaZHDgzW@dhcp22.suse.cz>
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-3-osalvador@suse.de>
 <YFIOTTC7wgXHQRpy@dhcp22.suse.cz>
 <20210317143827.GA20965@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317143827.GA20965@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-03-21 15:38:35, Oscar Salvador wrote:
> On Wed, Mar 17, 2021 at 03:12:29PM +0100, Michal Hocko wrote:
> > > Since isolate_migratepages_block will stop returning the next pfn to be
> > > scanned, we reuse the cc->migrate_pfn field to keep track of that.
> > 
> > This looks hakish and I cannot really tell that users of cc->migrate_pfn
> > work as intended.
> 
> When discussing this with Vlastimil, I came up with the idea of adding a new
> field in compact_control struct, e.g: next_pfn_scan to keep track of the next
> pfn to be scanned.
> 
> But Vlastimil made me realize that since cc->migrate_pfn points to that aleady,
> so we do not need any extra field.

This deserves a big fat comment.

> > > @@ -810,6 +811,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> > >  	unsigned long next_skip_pfn = 0;
> > >  	bool skip_updated = false;
> > >  
> > > +	cc->migrate_pfn = low_pfn;
> > > +
> > >  	/*
> > >  	 * Ensure that there are not too many pages isolated from the LRU
> > >  	 * list by either parallel reclaimers or compaction. If there are,
> > > @@ -818,16 +821,16 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> > >  	while (unlikely(too_many_isolated(pgdat))) {
> > >  		/* stop isolation if there are still pages not migrated */
> > >  		if (cc->nr_migratepages)
> > > -			return 0;
> > > +			return -EINTR;
> > >  
> > >  		/* async migration should just abort */
> > >  		if (cc->mode == MIGRATE_ASYNC)
> > > -			return 0;
> > > +			return -EINTR;
> > 
> > EINTR for anything other than signal based bail out is really confusing.
> 
> When coding that, I thought about using -1 for the first two checks, and keep
> -EINTR for the signal check, but isolate_migratepages_block only has two users:

No, do not mix error reporting with different semantic. Either make it
errno or return -1 for all failures if you do not care which error that
is. You do care and hence this patch so make that errno and above two
should simply EAGAIN as this is a congestion situation.

> - isolate_migratepages: Does not care about the return code other than pfn != 0,
>   and it does not pass the error down the chain.
> - isolate_migratepages_range: The error is passed down the chain, and !pfn is being
>   treated as -EINTR:
> 
> static int __alloc_contig_migrate_range(struct compact_control *cc,
> 					unsigned long start, unsigned long end)
>  {
>   ...
>   ...
>   pfn = isolate_migratepages_range(cc, pfn, end);
>   if (!pfn) {
>           ret = -EINTR;
>           break;
>   }
>   ...
>  }
> 
> That is why I decided to stick with -EINTR.

I suspect this is only because there was not really a better way to tell
the failure so it went with EINTR which makes alloc_contig_range bail
out. The high level handling there is quite dubious as EAGAIN is already
possible from the page migration path and that shouldn't be a fatal
failure.
-- 
Michal Hocko
SUSE Labs
