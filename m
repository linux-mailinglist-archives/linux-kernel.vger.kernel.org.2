Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D27C355062
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhDFJ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:56:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:56976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233527AbhDFJ4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:56:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617702973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=656KuN9pjrhu4sCZqILrkK+S2NOZRWLCsVXRfCBqK70=;
        b=pV5WDB56i74o7vVmZdBJd8BuNa3HoBvkalqJOjTkBoFnGpVXqkNklgKin3mrj+C13lsptW
        vC4yPZ9or06QspUCvee4QAsrhrLFHTx7tXNxeLjsEgim30RN91GJ4jVlHimwFwYjio6aLg
        L5K+yNmU6JumYn7l4Mbqy9fyeAOnCCM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8B8DB137;
        Tue,  6 Apr 2021 09:56:12 +0000 (UTC)
Date:   Tue, 6 Apr 2021 11:56:11 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
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
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 4/8] hugetlb: create remove_hugetlb_page() to separate
 functionality
Message-ID: <YGwwO0galuKQsD0J@dhcp22.suse.cz>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-5-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405230043.182734-5-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-04-21 16:00:39, Mike Kravetz wrote:
> The new remove_hugetlb_page() routine is designed to remove a hugetlb
> page from hugetlbfs processing.  It will remove the page from the active
> or free list, update global counters and set the compound page
> destructor to NULL so that PageHuge() will return false for the 'page'.
> After this call, the 'page' can be treated as a normal compound page or
> a collection of base size pages.
> 
> update_and_free_page no longer decrements h->nr_huge_pages{_node} as
> this is performed in remove_hugetlb_page.  The only functionality
> performed by update_and_free_page is to free the base pages to the lower
> level allocators.
> 
> update_and_free_page is typically called after remove_hugetlb_page.
> 
> remove_hugetlb_page is to be called with the hugetlb_lock held.
> 
> Creating this routine and separating functionality is in preparation for
> restructuring code to reduce lock hold times.  This commit should not
> introduce any changes to functionality.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Btw. I would prefer to reverse the ordering of this and Oscar's
patchset. This one is a bug fix which might be interesting for stable
backports while Oscar's work can be looked as a general functionality
improvement.

> @@ -2298,6 +2312,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>  		/*
>  		 * Freed from under us. Drop new_page too.
>  		 */
> +		remove_hugetlb_page(h, new_page, false);
>  		update_and_free_page(h, new_page);
>  		goto unlock;
>  	} else if (page_count(old_page)) {
> @@ -2305,6 +2320,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>  		 * Someone has grabbed the page, try to isolate it here.
>  		 * Fail with -EBUSY if not possible.
>  		 */
> +		remove_hugetlb_page(h, new_page, false);
>  		update_and_free_page(h, new_page);
>  		spin_unlock(&hugetlb_lock);
>  		if (!isolate_huge_page(old_page, list))

the page is not enqued anywhere here so remove_hugetlb_page would blow
when linked list debugging is enabled.
-- 
Michal Hocko
SUSE Labs
