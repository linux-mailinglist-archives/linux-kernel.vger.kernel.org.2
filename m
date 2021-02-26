Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B2E326133
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhBZKZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:25:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:44276 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhBZKZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:25:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8982AF33;
        Fri, 26 Feb 2021 10:24:31 +0000 (UTC)
Date:   Fri, 26 Feb 2021 11:24:29 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm: Make alloc_contig_range handle in-use hugetlb
 pages
Message-ID: <20210226102424.GA3557@linux>
References: <20210222135137.25717-1-osalvador@suse.de>
 <20210222135137.25717-3-osalvador@suse.de>
 <YDi1gSdDXErJ+SHK@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDi1gSdDXErJ+SHK@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 09:46:57AM +0100, Michal Hocko wrote:
> On Mon 22-02-21 14:51:37, Oscar Salvador wrote:
> [...]
> > @@ -2394,9 +2397,19 @@ bool isolate_or_dissolve_huge_page(struct page *page)
> >  	 */
> >  	if (hstate_is_gigantic(h))
> >  		return ret;
> > -
> > -	if (!page_count(head) && alloc_and_dissolve_huge_page(h, head))
> > +retry:
> > +	if (page_count(head) && isolate_huge_page(head, list)) {
> >  		ret = true;
> > +	} else if (!page_count(head)) {
> 
> This is rather head spinning. Do we need to test page_count in the else
> branch? Do you want to optimize for a case where the page cannot be
> isolated because of page_huge_active?

Well, I wanted to explictly call out both cases.
We either 1) have an in-use page and we try to issolate it or 2) we have a free
page (count == 0).

If the page could not be dissolved due to page_huge_active, this would either
mean that page is about to be freed, or that someone has already issolated the
page.
Being the former case, one could say that falling-through alloc_and_dissolve is
ok.

But no, I did not really want to optimize anything here, just wanted to be explicit
about what we are checking and why.

> > +
> > +		if (!err) {
> > +			ret = true;
> > +		} else if (err == -EBUSY && try_again) {
> > +			try_again = false;
> > +			goto retry;
> > +		}
> 
> Is this retry once logic really needed? Does it really give us any real
> benefit? alloc_and_dissolve_huge_page already retries when the page is
> being freed.

alloc_and_dissolve_huge_page retries when the page is about to be freed.
Here we retry in case alloc_and_dissolve_huge_page() noticed that someone grabbed
the page (refcount 0 -> 1), which would possibly mean userspace started using this
page. If that is the case, we give isolate_huge_page another chance to see if we
can succeed and we can migrate the page.

Chances this to happen? Honestly, as any race, quite low.
So, the answer to your question would be, no, it is not really needed, I just felt
we could play "clever" here.

-- 
Oscar Salvador
SUSE L3
