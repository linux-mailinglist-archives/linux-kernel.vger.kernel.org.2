Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50A33446E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCVOQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:16:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:54324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230085AbhCVOPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:15:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616422544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=duDDEf2Xm5uPkuZN+qB6EpLuAaJtGoQSQbHz8dth7zA=;
        b=XNAfDnvmGf3UeHuucC72Nsq8TCB7iDCUBGB8qBvQyljEkitmgXtNfcuqpBMKSfNrfczCHH
        IfLDHoiOXncEK4w57k7cqUlbVqSQGeU2Oj63ZWZrk2Sadvm1XmL/mVJimUkq98i3QmWTIo
        NgD+mSAjDEqNFsWobtwHbZusVYd6864=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B508ACA8;
        Mon, 22 Mar 2021 14:15:44 +0000 (UTC)
Date:   Mon, 22 Mar 2021 15:15:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 3/8] hugetlb: create remove_hugetlb_page() to
 separate functionality
Message-ID: <YFimj4UGBat8Tp/C@dhcp22.suse.cz>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-4-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319224209.150047-4-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-03-21 15:42:04, Mike Kravetz wrote:
> The new remove_hugetlb_page() routine is designed to remove a hugetlb
> page from hugetlbfs processing.  It will remove the page from the active
> or free list, update global counters and set the compound page
> destructor to NULL so that PageHuge() will return false for the 'page'.
> After this call, the 'page' can be treated as a normal compound page or
> a collection of base size pages.
> 
> remove_hugetlb_page is to be called with the hugetlb_lock held.
> 
> Creating this routine and separating functionality is in preparation for
> restructuring code to reduce lock hold times.

I like this! Counters handling both in __free_huge_page and
update_and_free_page is really confusing.


> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 70 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 46 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c537274c2a38..ae185d3315e0 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1306,6 +1306,46 @@ static inline void destroy_compound_gigantic_page(struct page *page,
>  						unsigned int order) { }
>  #endif
>  
> +/*
> + * Remove hugetlb page from lists, and update dtor so that page appears
> + * as just a compound page.  A reference is held on the page.
> + * NOTE: hugetlb specific page flags stored in page->private are not
> + *	 automatically cleared.  These flags may be used in routines
> + *	 which operate on the resulting compound page.
> + *
> + * Must be called with hugetlb lock held.
> + */
> +static void remove_hugetlb_page(struct hstate *h, struct page *page,
> +							bool adjust_surplus)
> +{
> +	int nid = page_to_nid(page);
> +

I think we want lockdep_assert_held here. Lockdep asserts are not used
in this code but now that you are touching it then it is probably better
to start adding them. What do you think?

> +	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> +		return;
> +
> +	list_del(&page->lru);
> +
> +	if (HPageFreed(page)) {
> +		h->free_huge_pages--;
> +		h->free_huge_pages_node[nid]--;
> +		ClearHPageFreed(page);
> +	}
> +	if (adjust_surplus) {
> +		h->surplus_huge_pages--;
> +		h->surplus_huge_pages_node[nid]--;
> +	}
> +
> +	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> +	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> +
> +	ClearHPageTemporary(page);
> +	set_page_refcounted(page);
> +	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> +
> +	h->nr_huge_pages--;
> +	h->nr_huge_pages_node[nid]--;
> +}

-- 
Michal Hocko
SUSE Labs
