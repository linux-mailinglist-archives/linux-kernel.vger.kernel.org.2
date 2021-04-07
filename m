Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F284B356796
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349891AbhDGJDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:03:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:47560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239586AbhDGJDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:03:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3E30AFC1;
        Wed,  7 Apr 2021 08:44:42 +0000 (UTC)
Date:   Wed, 7 Apr 2021 10:44:38 +0200
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 6/8] hugetlb: change free_pool_huge_page to
 remove_pool_huge_page
Message-ID: <20210407084438.GB10058@linux>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-7-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405230043.182734-7-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 04:00:41PM -0700, Mike Kravetz wrote:
> free_pool_huge_page was called with hugetlb_lock held.  It would remove
> a hugetlb page, and then free the corresponding pages to the lower level
> allocators such as buddy.  free_pool_huge_page was called in a loop to
> remove hugetlb pages and these loops could hold the hugetlb_lock for a
> considerable time.
> 
> Create new routine remove_pool_huge_page to replace free_pool_huge_page.
> remove_pool_huge_page will remove the hugetlb page, and it must be
> called with the hugetlb_lock held.  It will return the removed page and
> it is the responsibility of the caller to free the page to the lower
> level allocators.  The hugetlb_lock is dropped before freeing to these
> allocators which results in shorter lock hold times.
> 
> Add new helper routine to call update_and_free_page for a list of pages.
> 
> Note: Some changes to the routine return_unused_surplus_pages are in
> need of explanation.  Commit e5bbc8a6c992 ("mm/hugetlb.c: fix reservation
> race when freeing surplus pages") modified this routine to address a
> race which could occur when dropping the hugetlb_lock in the loop that
> removes pool pages.  Accounting changes introduced in that commit were
> subtle and took some thought to understand.  This commit removes the
> cond_resched_lock() and the potential race.  Therefore, remove the
> subtle code and restore the more straight forward accounting effectively
> reverting the commit.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

It crossed my mind that we could use update_and_free_pages_bulk() from
dissolve_free_huge_pages() <-> dissolve_free_huge_page() but the latter
looks too hairy already and it is probably not worth it.


-- 
Oscar Salvador
SUSE L3
