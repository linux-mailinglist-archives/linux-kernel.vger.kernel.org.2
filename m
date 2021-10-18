Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448534311B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 09:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhJRIBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:01:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50028 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhJRIBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:01:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C18461FD6D;
        Mon, 18 Oct 2021 07:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634543934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uNgX69E0dWc+93bcddHwiVjMEdBTIeLB3NxAJ7mr6T0=;
        b=ZIYy/RKe44wLR6SyLqd9xNki3zpzkHqCMtudcRZ/vcTS9ocrAC/BQIJhj0N4Lm+aHoSl/B
        RmQMiWu7NZqaHuN6QmCTCQ0m+UYpuAZZsSTVHRY0LM9GGhX5qBgKtBVbfM7oY0vUkAZ43n
        gcwXhqJnWHQWLNLXUYBjgIBI0IB/eJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634543934;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uNgX69E0dWc+93bcddHwiVjMEdBTIeLB3NxAJ7mr6T0=;
        b=jFSbw4Ug3ZNZAJ+/8ckuWENbH5cYcLTeNEsDMaAND7jKpipKdatrB7WUfgKbtoxhbqyAt8
        3btMSGmPZmHB+tDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F319713CC9;
        Mon, 18 Oct 2021 07:58:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EqW6Nz0pbWFyHAAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 18 Oct 2021 07:58:53 +0000
Date:   Mon, 18 Oct 2021 09:58:52 +0200
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
Subject: Re: [PATCH v4 4/5] hugetlb: add demote bool to gigantic page routines
Message-ID: <20211018075851.GB11960@linux>
References: <20211007181918.136982-1-mike.kravetz@oracle.com>
 <20211007181918.136982-5-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007181918.136982-5-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 11:19:17AM -0700, Mike Kravetz wrote:
> The routines remove_hugetlb_page and destroy_compound_gigantic_page
> will remove a gigantic page and make the set of base pages ready to be
> returned to a lower level allocator.  In the process of doing this, they
> make all base pages reference counted.
> 
> The routine prep_compound_gigantic_page creates a gigantic page from a
> set of base pages.  It assumes that all these base pages are reference
> counted.
> 
> During demotion, a gigantic page will be split into huge pages of a
> smaller size.  This logically involves use of the routines,
> remove_hugetlb_page, and destroy_compound_gigantic_page followed by
> prep_compound*_page for each smaller huge page.
> 
> When pages are reference counted (ref count >= 0), additional
> speculative ref counts could be taken.  This could result in errors

It would be great to learn about those cases involving speculative ref counts.

> while demoting a huge page.  Quite a bit of code would need to be
> created to handle all possible issues.
> 
> Instead of dealing with the possibility of speculative ref counts, avoid
> the possibility by keeping ref counts at zero during the demote process.
> Add a boolean 'demote' to the routines remove_hugetlb_page,
> destroy_compound_gigantic_page and prep_compound_gigantic_page.  If the
> boolean is set, the remove and destroy routines will not reference count
> pages and the prep routine will not expect reference counted pages.
> 
> '*_for_demote' wrappers of the routines will be added in a subsequent
> patch where this functionality is used.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/hugetlb.c | 54 +++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 563338f4dbc4..794e0c4c1b3c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1271,8 +1271,8 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
>  		nr_nodes--)
>  
>  #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
> -static void destroy_compound_gigantic_page(struct page *page,
> -					unsigned int order)
> +static void __destroy_compound_gigantic_page(struct page *page,
> +					unsigned int order, bool demote)
>  {
>  	int i;
>  	int nr_pages = 1 << order;
> @@ -1284,7 +1284,8 @@ static void destroy_compound_gigantic_page(struct page *page,
>  	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
>  		p->mapping = NULL;
>  		clear_compound_head(p);
> -		set_page_refcounted(p);
> +		if (!demote)
> +			set_page_refcounted(p);
>  	}
>  
>  	set_compound_order(page, 0);
> @@ -1292,6 +1293,12 @@ static void destroy_compound_gigantic_page(struct page *page,
>  	__ClearPageHead(page);
>  }
>  
> +static void destroy_compound_gigantic_page(struct page *page,
> +					unsigned int order)
> +{
> +	__destroy_compound_gigantic_page(page, order, false);
> +}
> +
>  static void free_gigantic_page(struct page *page, unsigned int order)
>  {
>  	/*
> @@ -1364,12 +1371,15 @@ static inline void destroy_compound_gigantic_page(struct page *page,
>  
>  /*
>   * Remove hugetlb page from lists, and update dtor so that page appears
> - * as just a compound page.  A reference is held on the page.
> + * as just a compound page.
> + *
> + * A reference is held on the page, except in the case of demote.
>   *
>   * Must be called with hugetlb lock held.
>   */
> -static void remove_hugetlb_page(struct hstate *h, struct page *page,
> -							bool adjust_surplus)
> +static void __remove_hugetlb_page(struct hstate *h, struct page *page,
> +							bool adjust_surplus,
> +							bool demote)
>  {
>  	int nid = page_to_nid(page);
>  
> @@ -1407,8 +1417,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
>  	 *
>  	 * This handles the case where more than one ref is held when and
>  	 * after update_and_free_page is called.
> +	 *
> +	 * In the case of demote we do not ref count the page as it will soon
> +	 * be turned into a page of smaller size.
>  	 */
> -	set_page_refcounted(page);
> +	if (!demote)
> +		set_page_refcounted(page);
>  	if (hstate_is_gigantic(h))
>  		set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
>  	else
> @@ -1418,6 +1432,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
>  	h->nr_huge_pages_node[nid]--;
>  }
>  
> +static void remove_hugetlb_page(struct hstate *h, struct page *page,
> +							bool adjust_surplus)
> +{
> +	__remove_hugetlb_page(h, page, adjust_surplus, false);
> +}
> +
>  static void add_hugetlb_page(struct hstate *h, struct page *page,
>  			     bool adjust_surplus)
>  {
> @@ -1681,7 +1701,8 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  	spin_unlock_irq(&hugetlb_lock);
>  }
>  
> -static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
> +static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
> +								bool demote)
>  {
>  	int i, j;
>  	int nr_pages = 1 << order;
> @@ -1719,10 +1740,16 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
>  		 * the set of pages can not be converted to a gigantic page.
>  		 * The caller who allocated the pages should then discard the
>  		 * pages using the appropriate free interface.
> +		 *
> +		 * In the case of demote, the ref count will be zero.
>  		 */
> -		if (!page_ref_freeze(p, 1)) {
> -			pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
> -			goto out_error;
> +		if (!demote) {
> +			if (!page_ref_freeze(p, 1)) {
> +				pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
> +				goto out_error;
> +			}
> +		} else {
> +			VM_BUG_ON_PAGE(page_count(p), p);
>  		}
>  		set_page_count(p, 0);
>  		set_compound_head(p, page);
> @@ -1747,6 +1774,11 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
>  	return false;
>  }
>  
> +static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
> +{
> +	return __prep_compound_gigantic_page(page, order, false);
> +}
> +
>  /*
>   * PageHuge() only returns true for hugetlbfs pages, but not for normal or
>   * transparent huge pages.  See the PageTransHuge() documentation for more
> -- 
> 2.31.1
> 

-- 
Oscar Salvador
SUSE Labs
