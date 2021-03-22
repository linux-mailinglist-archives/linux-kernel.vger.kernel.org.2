Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC4234465F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhCVN7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:59:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:42478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230461AbhCVN7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:59:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616421544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H1wE9M9DWXuluUKR8Qj2wGfHLDajLI5FXvrzLsmocR0=;
        b=d5MguF6wk6o+RmQvTzMCV8DXZNd3ndl+x98QktgeEcOPu8OgmuuCEowuvJ95nmBM74Bi2J
        TM/4NMENqSrBsPfykLIJhwJQriEIIlIRfbTQFEuFhXlQtr40VmePkuOdrKpqjAWPNRY3qI
        LfI2VVjPV3ScpGjlbhgH0bDTVCASRa8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7310EAD4A;
        Mon, 22 Mar 2021 13:59:04 +0000 (UTC)
Date:   Mon, 22 Mar 2021 14:59:03 +0100
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
Subject: Re: [RFC PATCH 1/8] hugetlb: add per-hstate mutex to synchronize
 user adjustments
Message-ID: <YFiipzEs0wuL/Qdl@dhcp22.suse.cz>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319224209.150047-2-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-03-21 15:42:02, Mike Kravetz wrote:
> The number of hugetlb pages can be adjusted by writing to the
> sysps/proc files nr_hugepages, nr_hugepages_mempolicy or
> nr_overcommit_hugepages.  There is nothing to prevent two
> concurrent modifications via these files.  The underlying routine
> set_max_huge_pages() makes assumptions that only one occurrence is
> running at a time.  Specifically, alloc_pool_huge_page uses a
> hstate specific variable without any synchronization.

From the above it is not really clear whether the unsynchronized nature
of set_max_huge_pages is really a problem or a mere annoynce. I suspect
the later because counters are properly synchronized with the
hugetlb_lock. It would be great to clarify that.
 
> Add a mutex to the hstate and use it to only allow one hugetlb
> page adjustment at a time.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  include/linux/hugetlb.h | 1 +
>  mm/hugetlb.c            | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index cccd1aab69dd..f42d44050548 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -555,6 +555,7 @@ HPAGEFLAG(Freed, freed)
>  #define HSTATE_NAME_LEN 32
>  /* Defines one hugetlb page size */
>  struct hstate {
> +	struct mutex mutex;
>  	int next_nid_to_alloc;
>  	int next_nid_to_free;
>  	unsigned int order;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5b1ab1f427c5..d5be25f910e8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2601,6 +2601,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	else
>  		return -ENOMEM;
>  
> +	/* mutex prevents concurrent adjustments for the same hstate */
> +	mutex_lock(&h->mutex);
>  	spin_lock(&hugetlb_lock);
>  
>  	/*
> @@ -2633,6 +2635,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
>  		if (count > persistent_huge_pages(h)) {
>  			spin_unlock(&hugetlb_lock);
> +			mutex_unlock(&h->mutex);
>  			NODEMASK_FREE(node_alloc_noretry);
>  			return -EINVAL;
>  		}
> @@ -2707,6 +2710,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  out:
>  	h->max_huge_pages = persistent_huge_pages(h);
>  	spin_unlock(&hugetlb_lock);
> +	mutex_unlock(&h->mutex);
>  
>  	NODEMASK_FREE(node_alloc_noretry);
>  
> @@ -3194,6 +3198,7 @@ void __init hugetlb_add_hstate(unsigned int order)
>  	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
>  	BUG_ON(order == 0);
>  	h = &hstates[hugetlb_max_hstate++];
> +	mutex_init(&h->mutex);
>  	h->order = order;
>  	h->mask = ~(huge_page_size(h) - 1);
>  	for (i = 0; i < MAX_NUMNODES; ++i)
> -- 
> 2.30.2
> 

-- 
Michal Hocko
SUSE Labs
