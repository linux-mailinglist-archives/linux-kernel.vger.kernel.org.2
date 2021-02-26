Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51017326067
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhBZJqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:46:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:46502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhBZJp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:45:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9F928AAAE;
        Fri, 26 Feb 2021 09:45:16 +0000 (UTC)
Date:   Fri, 26 Feb 2021 10:45:14 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: Make alloc_contig_range handle free hugetlb
 pages
Message-ID: <20210226094507.GA3240@linux>
References: <20210222135137.25717-1-osalvador@suse.de>
 <20210222135137.25717-2-osalvador@suse.de>
 <YDiyvQ2SCXxCjPJ2@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDiyvQ2SCXxCjPJ2@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 09:35:09AM +0100, Michal Hocko wrote:
> I think it would be helpful to call out that specific case explicitly
> here. I can see only one scenario (are there more?)
> __free_huge_page()		isolate_or_dissolve_huge_page
> 				  PageHuge() == T
> 				  alloc_and_dissolve_huge_page
> 				    alloc_fresh_huge_page()
> 				    spin_lock(hugetlb_lock)
> 				    // PageHuge() && !PageHugeFreed &&
> 				    // !PageCount()
> 				    spin_unlock(hugetlb_lock)
>   spin_lock(hugetlb_lock)
>   1) update_and_free_page
>        PageHuge() == F
>        __free_pages()
>   2) enqueue_huge_page
>        SetPageHugeFreed()
>   spin_unlock(&hugetlb_lock)

I do not think there are more scenarios. The thing is to find a !page_count &&
!PageHugeFreed.
AFAICS, this can only happen after:
put_page->put_page_test_zero->..->_free_huge_page gets called but __free_huge_page
has not reached enqueue_huge_page yet (as you just described above)

By calling out this case, you meant to describe it in the changelog?

> 
> > In this case we retry as the window race is quite small and we have high
> > chances to succeed next time.
> > 
> > With regard to the allocation, we restrict it to the node the page belongs
> > to with __GFP_THISNODE, meaning we do not fallback on other node's zones.
> > 
> > Note that gigantic hugetlb pages are fenced off since there is a cyclic
> > dependency between them and alloc_contig_range.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> 
> Thanks this looks much better than the initial version. One nit below.
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> > +bool isolate_or_dissolve_huge_page(struct page *page)
> > +{
> > +	struct hstate *h = NULL;
> > +	struct page *head;
> > +	bool ret = false;
> > +
> > +	spin_lock(&hugetlb_lock);
> > +	if (PageHuge(page)) {
> > +		head = compound_head(page);
> > +		h = page_hstate(head);
> > +	}
> > +	spin_unlock(&hugetlb_lock);
> > +
> > +	/*
> > +	 * The page might have been dissolved from under our feet.
> > +	 * If that is the case, return success as if we dissolved it ourselves.
> > +	 */
> > +	if (!h)
> > +		return true;
> 
> I am still fighting with this construct a bit. It is not really clear
> what the lock is protecting us from here. alloc_fresh_huge_page deals
> with all potential races and this looks like an optimistic check to save
> some work. But in fact the lock is really necessary for correctness
> because hstate might be completely bogus without the lock or us holding
> a reference on the poage. The following construct would be more
> explicit and compact. What do you think?
> 
> 	struct hstate *h;
> 
> 	/*
> 	 * The page might have been dissloved from under our feet
> 	 * so make sure to carefully check the state under the lock.
> 	 * Return success on when racing as if we dissloved the page
> 	 * ourselves.
> 	 */
> 	spin_lock(&hugetlb_lock);
> 	if (PageHuge(page)) {
> 		head = compound_head(page);
> 		h = page_hstate(head);
> 	} else {
> 		spin_unlock(&hugetlb_lock);
> 		return true;
> 	}
> 	spin_unlock(&hugetlb_lock);

Yes, I find this less eyesore.

I will fix it up in v4.

-- 
Oscar Salvador
SUSE L3
