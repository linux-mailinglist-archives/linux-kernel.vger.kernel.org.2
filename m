Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA153262E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhBZMrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:47:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:56124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhBZMrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:47:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614343582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bdJY5RFMgsg1qZIGV+8We7dBBKJWSZLg3sOQFhNuLP8=;
        b=jABI7NJ4rsC5M3reB3V+ElmNWY5++2uJ1Czpgd4k+paqTQD7B3e2p3E6oTgyL93dWdKYjy
        RU8F9tDyXQN1xeZkOAYYPCGB8yPf7CCTbgx6PQxT1ZBMTjnUiHgsSbtqUohN0SKErrtupY
        bhto//iq/7vn8l3+rla0KfzXJhdY0ZM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DB503AF1E;
        Fri, 26 Feb 2021 12:46:21 +0000 (UTC)
Date:   Fri, 26 Feb 2021 13:46:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm: Make alloc_contig_range handle in-use hugetlb
 pages
Message-ID: <YDjtnWxYoysUtSKs@dhcp22.suse.cz>
References: <20210222135137.25717-1-osalvador@suse.de>
 <20210222135137.25717-3-osalvador@suse.de>
 <YDi1gSdDXErJ+SHK@dhcp22.suse.cz>
 <20210226102424.GA3557@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226102424.GA3557@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-02-21 11:24:29, Oscar Salvador wrote:
> On Fri, Feb 26, 2021 at 09:46:57AM +0100, Michal Hocko wrote:
> > On Mon 22-02-21 14:51:37, Oscar Salvador wrote:
> > [...]
> > > @@ -2394,9 +2397,19 @@ bool isolate_or_dissolve_huge_page(struct page *page)
> > >  	 */
> > >  	if (hstate_is_gigantic(h))
> > >  		return ret;
> > > -
> > > -	if (!page_count(head) && alloc_and_dissolve_huge_page(h, head))
> > > +retry:
> > > +	if (page_count(head) && isolate_huge_page(head, list)) {
> > >  		ret = true;
> > > +	} else if (!page_count(head)) {
> > 
> > This is rather head spinning. Do we need to test page_count in the else
> > branch? Do you want to optimize for a case where the page cannot be
> > isolated because of page_huge_active?
> 
> Well, I wanted to explictly call out both cases.
> We either 1) have an in-use page and we try to issolate it or 2) we have a free
> page (count == 0).
> 
> If the page could not be dissolved due to page_huge_active, this would either
> mean that page is about to be freed, or that someone has already issolated the
> page.
> Being the former case, one could say that falling-through alloc_and_dissolve is
> ok.
> 
> But no, I did not really want to optimize anything here, just wanted to be explicit
> about what we are checking and why.

Well, I will leave it to others. I do not feel strongly about this but
to me it makes the code harder to think about because the situation is
unstable and any of those condition can change as they are evaluated. So
an explicit checks makes the code harder in the end. I would simply got
with 
	if (isolate_huge_page(head, list) || !alloc_and_dissolve_huge_page())
		ret = true;

if either of the conditional needs a retry then it should be done
internally. Like alloc_and_dissolve_huge_page already does to stabilize
the PageFreed flag. An early bail out on non-free hugetlb page would
also better be done inside alloc_and_dissolve_huge_page.

-- 
Michal Hocko
SUSE Labs
