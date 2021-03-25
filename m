Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7C9349209
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhCYMaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:30:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:49290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230208AbhCYM3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:29:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B21FAC16;
        Thu, 25 Mar 2021 12:29:45 +0000 (UTC)
Date:   Thu, 25 Mar 2021 13:29:40 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
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
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/8] hugetlb: add per-hstate mutex to synchronize user
 adjustments
Message-ID: <YFyCNAGYivmKQLR6@localhost.localdomain>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-4-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325002835.216118-4-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 05:28:30PM -0700, Mike Kravetz wrote:
> The helper routine hstate_next_node_to_alloc accesses and modifies the
> hstate variable next_nid_to_alloc.  The helper is used by the routines
> alloc_pool_huge_page and adjust_pool_surplus.  adjust_pool_surplus is
> called with hugetlb_lock held.  However, alloc_pool_huge_page can not
> be called with the hugetlb lock held as it will call the page allocator.
> Two instances of alloc_pool_huge_page could be run in parallel or
> alloc_pool_huge_page could run in parallel with adjust_pool_surplus
> which may result in the variable next_nid_to_alloc becoming invalid
> for the caller and pages being allocated on the wrong node.

Is this something you have seen happening? If so, it is easier to
trigger? I doubt so as I have not seen any bug report, but just
wondering whether a Fixes tag is needed, or probably not worth, right?

> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -566,6 +566,7 @@ HPAGEFLAG(Freed, freed)
>  #define HSTATE_NAME_LEN 32
>  /* Defines one hugetlb page size */
>  struct hstate {
> +	struct mutex mutex;

I am also with Michal here, renaming the mutex to something closer to
its function might be better to understand it without diving too much in
the code.

>  	int next_nid_to_alloc;
>  	int next_nid_to_free;
>  	unsigned int order;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f9ba63fc1747..404b0b1c5258 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2616,6 +2616,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	else
>  		return -ENOMEM;
>  
> +	/* mutex prevents concurrent adjustments for the same hstate */
> +	mutex_lock(&h->mutex);
>  	spin_lock(&hugetlb_lock);

I find above comment a bit misleading.
AFAIK, hugetlb_lock also protects from concurrent adjustments for the
same hstate (hugepage_activelist, free_huge_pages, surplus_huge_pages,
etc...).
Would it be more apropiate saying that mutex_lock() only prevents from
simultaneously sysfs/proc operations?

Reviewed-by: Oscar Salvador <osalvador@suse.e>


-- 
Oscar Salvador
SUSE L3
