Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C37E4239E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbhJFInL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:43:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41130 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhJFInK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:43:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B52791FE98;
        Wed,  6 Oct 2021 08:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633509677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8iu+sHBr3seFeFij8nLPdAVGaZLAx3fbH3tVLrNu7NQ=;
        b=TJDgMTMj6Wtd3SCKBoX+ex/PL+tUJK47pZ+vtJ45PEhdEPq4oHvYSXrv6Z2GHTPDjiNho9
        XnydJBvT8I4QsICqybfqcBnUg0d6KvBTFrDskXKeoAWT2T1xCGeDl63MX87QFgS1M79vBg
        REEWPGN6X9bYTFCohe5y3xFf/h9js6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633509677;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8iu+sHBr3seFeFij8nLPdAVGaZLAx3fbH3tVLrNu7NQ=;
        b=Zo7W2GBFP3SlKdEXqVO73V0CuoBRtXKMOGesej1y2h+HXcLlnPPOBsfbbQYraAs1WyyhGm
        qISsCRRiKXZV/lAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1AD8213E19;
        Wed,  6 Oct 2021 08:41:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ep0IAy1hXWEaNAAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 06 Oct 2021 08:41:17 +0000
Date:   Wed, 6 Oct 2021 10:41:15 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 5/5] hugetlb: add hugetlb demote page support
Message-ID: <20211006084112.GA12288@linux>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
 <20211001175210.45968-6-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001175210.45968-6-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 10:52:10AM -0700, Mike Kravetz wrote:
> Demote page functionality will split a huge page into a number of huge
> pages of a smaller size.  For example, on x86 a 1GB huge page can be
> demoted into 512 2M huge pages.  Demotion is done 'in place' by simply
> splitting the huge page.
> 
> Added '*_for_demote' wrappers for remove_hugetlb_page,
> destroy_compound_gigantic_page and prep_compound_gigantic_page for use
> by demote code.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 74 insertions(+), 8 deletions(-)
> 
...  
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

Question: You keep the original error code returned from alloc_huge_page_vmemmap()
here, but then you lose it on demote_pool_huge_page() when doing the
!demote_free_huge_page. Would not make more sense to keep it all the way down to 
demote_store() in case you want to return the actual error code?

> +
> +	/*
> +	 * Use destroy_compound_gigantic_page_for_demote for all huge page
> +	 * sizes as it will not ref count pages.
> +	 */
> +	destroy_compound_gigantic_page_for_demote(page, huge_page_order(h));

It seems that for now we only allow gigantic pages to be demoted, but
destroy_compound_gigantic_page_for_demote feels kind of wrong, even
if it is only a wrapper that ends up calling _*gigantic_ functions.

We want a routine that destroy a hugetlb to be demoted into smaller hugetlb
pages, so the name gigantic makes little sense to appear in my opinion.

>  static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
>  	__must_hold(&hugetlb_lock)
>  {
> +	int nr_nodes, node;
> +	struct page *page;
>  	int rc = 0;
>  
>  	lockdep_assert_held(&hugetlb_lock);
> @@ -3313,9 +3377,15 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
>  	if (!h->demote_order)
>  		return rc;
>  
> -	/*
> -	 * TODO - demote fucntionality will be added in subsequent patch
> -	 */
> +	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
> +		if (!list_empty(&h->hugepage_freelists[node])) {
> +			page = list_entry(h->hugepage_freelists[node].next,
> +					struct page, lru);
> +			rc = !demote_free_huge_page(h, page);

I kinda dislike this as I pointed out.


-- 
Oscar Salvador
SUSE Labs
