Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0624311D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhJRIIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:08:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50964 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhJRIIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:08:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EE6821FD6D;
        Mon, 18 Oct 2021 08:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634544396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wjnYlqyFpwvyLi8dGiMLHrHOrOtOAEOnOWsvVUDLPZU=;
        b=yOWkZX1kU+PfHQGPYTok2ul0fV3rDBrKqcFpP/1uFvWwBaNZhldu29mzgMWEyY4xjaCLL3
        iBJLe8R2kMBd7WE39SC8DYxXKmsA6xK+zJsY/c7fIRv0uINRCluz5gDUvQbFHyCV7uDqBY
        Jx7dk9qov5uW7a+FrJpEqnI9g2QggT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634544396;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wjnYlqyFpwvyLi8dGiMLHrHOrOtOAEOnOWsvVUDLPZU=;
        b=zIP9M63nTTcTdRT632qPT6+rJBoWktufHHO8y2+UrUJiejjeyopoHg+qlAWo1qM7M9TQSO
        N1JzDKPcyffcbUDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 254EA13CC9;
        Mon, 18 Oct 2021 08:06:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MgS8BQwrbWEgIAAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 18 Oct 2021 08:06:36 +0000
Date:   Mon, 18 Oct 2021 10:06:34 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Nghia Le <nghialm78@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 5/5] hugetlb: add hugetlb demote page support
Message-ID: <20211018080634.GC11960@linux>
References: <20211007181918.136982-1-mike.kravetz@oracle.com>
 <20211007181918.136982-6-mike.kravetz@oracle.com>
 <6ca29b8e-527c-d6ec-900e-e6a43e4f8b73@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ca29b8e-527c-d6ec-900e-e6a43e4f8b73@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 01:57:48PM -0700, Mike Kravetz wrote:
> From 25e4dac59f4d203f3a7e86d3591d70c1e956d11c Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Fri, 8 Oct 2021 13:21:21 -0700
> Subject: [PATCH v4 5/5] hugetlb: add hugetlb demote page support
> 
> Demote page functionality will split a huge page into a number of huge
> pages of a smaller size.  For example, on x86 a 1GB huge page can be
> demoted into 512 2M huge pages.  Demotion is done 'in place' by simply
> splitting the huge page.
> 
> Added '*_for_demote' wrappers for remove_hugetlb_page,
> destroy_compound_hugetlb_page and prep_compound_gigantic_page for use
> by demote code.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/hugetlb.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 92 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 794e0c4c1b3c..e1883510309a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1270,7 +1270,7 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
>  		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
>  		nr_nodes--)
>  
> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
> +/* used to demote non-gigantic_huge pages as well */
>  static void __destroy_compound_gigantic_page(struct page *page,
>  					unsigned int order, bool demote)
>  {
> @@ -1293,6 +1293,13 @@ static void __destroy_compound_gigantic_page(struct page *page,
>  	__ClearPageHead(page);
>  }
>  
> +static void destroy_compound_hugetlb_page_for_demote(struct page *page,
> +					unsigned int order)
> +{
> +	__destroy_compound_gigantic_page(page, order, true);
> +}
> +
> +#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>  static void destroy_compound_gigantic_page(struct page *page,
>  					unsigned int order)
>  {
> @@ -1438,6 +1445,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
>  	__remove_hugetlb_page(h, page, adjust_surplus, false);
>  }
>  
> +static void remove_hugetlb_page_for_demote(struct hstate *h, struct page *page,
> +							bool adjust_surplus)
> +{
> +	__remove_hugetlb_page(h, page, adjust_surplus, true);
> +}
> +
>  static void add_hugetlb_page(struct hstate *h, struct page *page,
>  			     bool adjust_surplus)
>  {
> @@ -1779,6 +1792,12 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
>  	return __prep_compound_gigantic_page(page, order, false);
>  }
>  
> +static bool prep_compound_gigantic_page_for_demote(struct page *page,
> +							unsigned int order)
> +{
> +	return __prep_compound_gigantic_page(page, order, true);
> +}
> +
>  /*
>   * PageHuge() only returns true for hugetlbfs pages, but not for normal or
>   * transparent huge pages.  See the PageTransHuge() documentation for more
> @@ -3304,9 +3323,72 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	return 0;
>  }
>  
> +static int demote_free_huge_page(struct hstate *h, struct page *page)
> +{
> +	int i, nid = page_to_nid(page);
> +	struct hstate *target_hstate;
> +	int rc = 0;
> +
> +	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
> +
> +	remove_hugetlb_page_for_demote(h, page, false);
> +	spin_unlock_irq(&hugetlb_lock);
> +
> +	rc = alloc_huge_page_vmemmap(h, page);
> +	if (rc) {
> +		/* Allocation of vmemmmap failed, we can not demote page */
> +		spin_lock_irq(&hugetlb_lock);
> +		set_page_refcounted(page);
> +		add_hugetlb_page(h, page, false);
> +		return rc;
> +	}
> +
> +	/*
> +	 * Use destroy_compound_hugetlb_page_for_demote for all huge page
> +	 * sizes as it will not ref count pages.
> +	 */
> +	destroy_compound_hugetlb_page_for_demote(page, huge_page_order(h));
> +
> +	/*
> +	 * Taking target hstate mutex synchronizes with set_max_huge_pages.
> +	 * Without the mutex, pages added to target hstate could be marked
> +	 * as surplus.
> +	 *
> +	 * Note that we already hold h->resize_lock.  To prevent deadlock,
> +	 * use the convention of always taking larger size hstate mutex first.
> +	 */
> +	mutex_lock(&target_hstate->resize_lock);
> +	for (i = 0; i < pages_per_huge_page(h);
> +				i += pages_per_huge_page(target_hstate)) {
> +		if (hstate_is_gigantic(target_hstate))
> +			prep_compound_gigantic_page_for_demote(page + i,
> +							target_hstate->order);
> +		else
> +			prep_compound_page(page + i, target_hstate->order);
> +		set_page_private(page + i, 0);
> +		set_page_refcounted(page + i);
> +		prep_new_huge_page(target_hstate, page + i, nid);
> +		put_page(page + i);
> +	}
> +	mutex_unlock(&target_hstate->resize_lock);
> +
> +	spin_lock_irq(&hugetlb_lock);
> +
> +	/*
> +	 * Not absolutely necessary, but for consistency update max_huge_pages
> +	 * based on pool changes for the demoted page.
> +	 */
> +	h->max_huge_pages--;
> +	target_hstate->max_huge_pages += pages_per_huge_page(h);
> +
> +	return rc;
> +}
> +
>  static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
>  	__must_hold(&hugetlb_lock)
>  {
> +	int nr_nodes, node;
> +	struct page *page;
>  	int rc = 0;
>  
>  	lockdep_assert_held(&hugetlb_lock);
> @@ -3317,9 +3399,15 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
>  		return -EINVAL;		/* internal error */
>  	}
>  
> -	/*
> -	 * TODO - demote fucntionality will be added in subsequent patch
> -	 */
> +	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
> +		if (!list_empty(&h->hugepage_freelists[node])) {
> +			page = list_entry(h->hugepage_freelists[node].next,
> +					struct page, lru);
> +			rc = demote_free_huge_page(h, page);
> +			break;
> +		}
> +	}
> +
>  	return rc;
>  }
>  
> @@ -3554,10 +3642,6 @@ static ssize_t demote_store(struct kobject *kobj,
>  		/*
>  		 * Check for available pages to demote each time thorough the
>  		 * loop as demote_pool_huge_page will drop hugetlb_lock.
> -		 *
> -		 * NOTE: demote_pool_huge_page does not yet drop hugetlb_lock
> -		 * but will when full demote functionality is added in a later
> -		 * patch.
>  		 */
>  		if (nid != NUMA_NO_NODE)
>  			nr_available = h->free_huge_pages_node[nid];
> -- 
> 2.31.1
> 
> 

-- 
Oscar Salvador
SUSE Labs
