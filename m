Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F049B345923
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhCWH6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:58:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:45384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhCWH5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:57:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616486273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m+xTnYW1KWqoinuxGp7EGKTcA3wA3snicXhoUVTBaLY=;
        b=gBI7u2txerAlccab8XBKnv33BbpVCouLB++S/f+B0QjRW5IiiVv71zU/PRXmDO98S/q+Ji
        0nL/hGlX1rc1pdUc4EAME83m79HAcLyE5NnE8M+f32cTcreLVwooL4ljboejCZxirnWUDx
        rlnb8xLk9dADwrdKE9+UHE1cLuzBLPc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 86F56AC1D;
        Tue, 23 Mar 2021 07:57:53 +0000 (UTC)
Date:   Tue, 23 Mar 2021 08:57:46 +0100
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
Subject: Re: [RFC PATCH 5/8] hugetlb: change free_pool_huge_page to
 remove_pool_huge_page
Message-ID: <YFmfegQjCKuY05jy@dhcp22.suse.cz>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-6-mike.kravetz@oracle.com>
 <YFiqJSGjMMG3diWp@dhcp22.suse.cz>
 <fd723ea8-da7c-bd59-8d8a-e506be1b3af5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd723ea8-da7c-bd59-8d8a-e506be1b3af5@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-03-21 16:28:07, Mike Kravetz wrote:
> On 3/22/21 7:31 AM, Michal Hocko wrote:
> > On Fri 19-03-21 15:42:06, Mike Kravetz wrote:
> > [...]
> >> @@ -2090,9 +2084,15 @@ static void return_unused_surplus_pages(struct hstate *h,
> >>  	while (nr_pages--) {
> >>  		h->resv_huge_pages--;
> >>  		unused_resv_pages--;
> >> -		if (!free_pool_huge_page(h, &node_states[N_MEMORY], 1))
> >> +		page = remove_pool_huge_page(h, &node_states[N_MEMORY], 1);
> >> +		if (!page)
> >>  			goto out;
> >> -		cond_resched_lock(&hugetlb_lock);
> >> +
> >> +		/* Drop lock and free page to buddy as it could sleep */
> >> +		spin_unlock(&hugetlb_lock);
> >> +		update_and_free_page(h, page);
> >> +		cond_resched();
> >> +		spin_lock(&hugetlb_lock);
> >>  	}
> >>  
> >>  out:
> > 
> > This is likely a matter of taste but the repeated pattern of unlock,
> > update_and_free_page, cond_resched and lock seems rather clumsy.
> > Would it be slightly better/nicer to remove_pool_huge_page into a
> > list_head under a single lock invocation and then free up the whole lot
> > after the lock is dropped?
> 
> Yes, we can certainly do that.
> One downside I see is that the list can contain a bunch of pages not
> accounted for in hugetlb and not free in buddy (or cma).  Ideally, we
> would want to keep those in sync if possible.  Also, the commit that
> added the cond_resched talked about freeing up 12 TB worth of huge pages
> and it holding the lock for 150 seconds.  The new code is not holding
> the lock while calling free to buddy, but I wonder how long it would
> take to remove 12 TB worth of huge pages and add them to a separate list?

Well, the remove_pool_huge_page is just a accounting part and that
should be pretty invisible even when the number of pages is large. The
lockless nature (from hugetlb POV) of the final page release is the
heavy weight operation and whether you do it in chunks or in a single go
(with cond_resched) should be visible either. We already do the same
thing when uncharging memcg pages (mem_cgroup_uncharge_list). 

So I would agree with you that this would be a much bigger problem if
both the hugetlb and freeing path were equally heavy weight and the
delay between first pages uncaccounted and freed would be noticeable.

But I do not want to push for this. I just hated the hugetlb_lock dances
as this is ugly and repetitive pattern.
-- 
Michal Hocko
SUSE Labs
