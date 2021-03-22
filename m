Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710163446F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCVOT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:19:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:57656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhCVOTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:19:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616422762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jksCq3DsJImfqIu/dbj3WTPcJZucfV77hGm3/23dYP8=;
        b=P1px/j7s0d7JUxJpidoKJBMtVLfBUebPS1Pa8E5I1sujL2yYYEs8USRcmWfUJobdAIYYY9
        1bCIx6I3uNQ0jcGBhykeI5NHgpBDkdGYgOAF/uXnUL6xmlz0d+J3oGHXXdPiVbFLnjITDd
        NlE6zO3jYoTkWl67gRmOPQDwCBPUqAw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7654CACA8;
        Mon, 22 Mar 2021 14:19:22 +0000 (UTC)
Date:   Mon, 22 Mar 2021 15:19:21 +0100
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
Subject: Re: [RFC PATCH 4/8] hugetlb: call update_and_free_page without
 hugetlb_lock
Message-ID: <YFinaZoTVR0MbYxo@dhcp22.suse.cz>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-5-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319224209.150047-5-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-03-21 15:42:05, Mike Kravetz wrote:
> With the introduction of remove_hugetlb_page(), there is no need for
> update_and_free_page to hold the hugetlb lock.  Change all callers to
> drop the lock before calling.
> 
> With additional code modifications, this will allow loops which decrease
> the huge page pool to drop the hugetlb_lock with each page to reduce
> long hold times.
> 
> The ugly unlock/lock cycle in free_pool_huge_page will be removed in
> a subsequent patch which restructures free_pool_huge_page.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Looks good to me. I will not ack it right now though. I am still
crawling through the series and want to get a full picture. So far it
looks promising ;).

> ---
>  mm/hugetlb.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ae185d3315e0..3028cf10d504 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1362,14 +1362,8 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>  				1 << PG_writeback);
>  	}
>  	if (hstate_is_gigantic(h)) {
> -		/*
> -		 * Temporarily drop the hugetlb_lock, because
> -		 * we might block in free_gigantic_page().
> -		 */
> -		spin_unlock(&hugetlb_lock);
>  		destroy_compound_gigantic_page(page, huge_page_order(h));
>  		free_gigantic_page(page, huge_page_order(h));
> -		spin_lock(&hugetlb_lock);
>  	} else {
>  		__free_pages(page, huge_page_order(h));
>  	}
> @@ -1435,16 +1429,18 @@ static void __free_huge_page(struct page *page)
>  
>  	if (HPageTemporary(page)) {
>  		remove_hugetlb_page(h, page, false);
> +		spin_unlock(&hugetlb_lock);
>  		update_and_free_page(h, page);
>  	} else if (h->surplus_huge_pages_node[nid]) {
>  		/* remove the page from active list */
>  		remove_hugetlb_page(h, page, true);
> +		spin_unlock(&hugetlb_lock);
>  		update_and_free_page(h, page);
>  	} else {
>  		arch_clear_hugepage_flags(page);
>  		enqueue_huge_page(h, page);
> +		spin_unlock(&hugetlb_lock);
>  	}
> -	spin_unlock(&hugetlb_lock);
>  }
>  
>  /*
> @@ -1725,7 +1721,13 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>  				list_entry(h->hugepage_freelists[node].next,
>  					  struct page, lru);
>  			remove_hugetlb_page(h, page, acct_surplus);
> +			/*
> +			 * unlock/lock around update_and_free_page is temporary
> +			 * and will be removed with subsequent patch.
> +			 */
> +			spin_unlock(&hugetlb_lock);
>  			update_and_free_page(h, page);
> +			spin_lock(&hugetlb_lock);
>  			ret = 1;
>  			break;
>  		}
> @@ -1794,8 +1796,9 @@ int dissolve_free_huge_page(struct page *page)
>  		}
>  		remove_hugetlb_page(h, page, false);
>  		h->max_huge_pages--;
> +		spin_unlock(&hugetlb_lock);
>  		update_and_free_page(h, head);
> -		rc = 0;
> +		return 0;
>  	}
>  out:
>  	spin_unlock(&hugetlb_lock);
> @@ -2572,7 +2575,9 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>  			remove_hugetlb_page(h, page, false);
>  			h->free_huge_pages--;
>  			h->free_huge_pages_node[page_to_nid(page)]--;
> +			spin_unlock(&hugetlb_lock);
>  			update_and_free_page(h, page);
> +			spin_lock(&hugetlb_lock);
>  
>  			/*
>  			 * update_and_free_page could have dropped lock so
> -- 
> 2.30.2
> 

-- 
Michal Hocko
SUSE Labs
