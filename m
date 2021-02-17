Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3551D31DBE5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhBQPCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:02:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:40642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233743AbhBQPBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:01:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613574018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zNdiGqAoz3ZwhvlUdJkNCXpe7aX8eZygEhCr3tOEEWw=;
        b=eJ64cNAG041bxJF2KFRBBXXn727Q2vCB/jsaissiJL9tVdOl0408WcejPxq1wISIB11yAh
        3bcxpmrBpQw1RZhQoYnHQMY1Ry9pO6CUsa8UvPvyYli1ScXKJiU36gScBtZlW/SG6/cc8R
        H1IurCthlR+0+3ClJ0ZsyFhyLONGLnI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9AF0EB8FE;
        Wed, 17 Feb 2021 15:00:18 +0000 (UTC)
Date:   Wed, 17 Feb 2021 16:00:11 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Message-ID: <YC0ve4PP+VTrEEtw@dhcp22.suse.cz>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-2-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217100816.28860-2-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-02-21 11:08:15, Oscar Salvador wrote:
[...]
> +static bool alloc_and_dissolve_huge_page(struct hstate *h, struct page *page)
> +{
> +	gfp_t gfp_mask = htlb_alloc_mask(h);
> +	nodemask_t *nmask = &node_states[N_MEMORY];
> +	struct page *new_page;
> +	bool ret = false;
> +	int nid;
> +
> +	spin_lock(&hugetlb_lock);
> +	/*
> +	 * Check one more time to make race-window smaller.
> +	 */
> +	if (!PageHuge(page)) {
> +		/*
> +		 * Dissolved from under our feet.
> +		 */
> +		spin_unlock(&hugetlb_lock);
> +		return true;
> +	}

Is this really necessary? dissolve_free_huge_page will take care of this
and the race windown you are covering is really tiny.

> +
> +	nid = page_to_nid(page);
> +	spin_unlock(&hugetlb_lock);
> +
> +	/*
> +	 * Before dissolving the page, we need to allocate a new one,
> +	 * so the pool remains stable.
> +	 */
> +	new_page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);

wrt. fallback to other zones, I haven't realized that the primary
usecase is a form of memory offlining (from virt-mem). I am not yet sure
what the proper behavior is in that case but if breaking hugetlb pools,
similar to the normal hotplug operation, is viable then this needs a
special mode. We do not want a random alloc_contig_range user to do the
same. So for starter I would go with __GFP_THISNODE here.

> +	if (new_page) {
> +		/*
> +		 * Ok, we got a new free hugepage to replace this one. Try to
> +		 * dissolve the old page.
> +		 */
> +		if (!dissolve_free_huge_page(page)) {
> +			ret = true;
> +		} else if (dissolve_free_huge_page(new_page)) {
> +			/*
> +			 * Seems the old page could not be dissolved, so try to
> +			 * dissolve the freshly allocated page. If that fails
> +			 * too, let us count the new page as a surplus. Doing so
> +			 * allows the pool to be re-balanced when pages are freed
> +			 * instead of enqueued again.
> +			 */
> +			spin_lock(&hugetlb_lock);
> +			h->surplus_huge_pages++;
> +			h->surplus_huge_pages_node[nid]++;
> +			spin_unlock(&hugetlb_lock);
> +		}
> +		/*
> +		 * Free it into the hugepage allocator
> +		 */
> +		put_page(new_page);
> +	}
> +
> +	return ret;
> +}
> +
> +bool isolate_or_dissolve_huge_page(struct page *page)
> +{
> +	struct hstate *h = NULL;
> +	struct page *head;
> +	bool ret = false;
> +
> +	spin_lock(&hugetlb_lock);
> +	if (PageHuge(page)) {
> +		head = compound_head(page);
> +		h = page_hstate(head);
> +	}
> +	spin_unlock(&hugetlb_lock);
> +
> +	if (!h)
> +		/*
> +		 * The page might have been dissolved from under our feet.
> +		 * If that is the case, return success as if we dissolved it
> +		 * ourselves.
> +		 */
> +		return true;

nit I would put the comment above the conditin for both cases. It reads
more easily that way. At least without { }.

> +
> +	if (hstate_is_gigantic(h))
> +		/*
> +		 * Fence off gigantic pages as there is a cyclic dependency
> +		 * between alloc_contig_range and them.
> +		 */
> +		return ret;
> +
> +	if(!page_count(head) && alloc_and_dissolve_huge_page(h, head))
> +		ret = true;
> +
> +	return ret;
> +}
> +
>  struct page *alloc_huge_page(struct vm_area_struct *vma,
>  				    unsigned long addr, int avoid_reserve)
>  {

Other than that I haven't noticed any surprises.
-- 
Michal Hocko
SUSE Labs
