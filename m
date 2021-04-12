Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C58635BAE1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbhDLHe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:34:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:41590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236904AbhDLHeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:34:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74A46AEB9;
        Mon, 12 Apr 2021 07:33:12 +0000 (UTC)
Date:   Mon, 12 Apr 2021 09:33:07 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 4/8] hugetlb: create remove_hugetlb_page() to separate
 functionality
Message-ID: <20210412073307.GB27818@linux>
References: <20210409205254.242291-1-mike.kravetz@oracle.com>
 <20210409205254.242291-5-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409205254.242291-5-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 01:52:50PM -0700, Mike Kravetz wrote:
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
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

A "nit" below:

>  static void update_and_free_page(struct hstate *h, struct page *page)
>  {
>  	int i;
> @@ -1334,8 +1369,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)

After this, update_and_free_page()'s job is to reset subpage's flags and free
the page.
Maybe we want to rename that function at some point, or maybe not as "update" might
already imply that. Just speaking out loud.

-- 
Oscar Salvador
SUSE L3
