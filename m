Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD3935680B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350119AbhDGJ3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:29:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:42100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350117AbhDGJ3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:29:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617787733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5cX0jPVjLXn3h+yOfz/RDosBSJ4v4SvYZHT2Qf30u9Y=;
        b=W+hboP3M7H5GCsQkPXRHf7zSqbnwda6i3DukU0WuxQ9YJH5nj3Ck3hADGT0HhsAr0szc5E
        2srhEVla4/hx7Rc3OXfnJvTfdjrYjMv49VnnKU6UIWWCSsksuw7me5NQAOoDy8/jl/sZvR
        P+cw/cOHtHHi6d9IQhztpY3wbt3hJ+0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 264D0B03B;
        Wed,  7 Apr 2021 09:28:53 +0000 (UTC)
Date:   Wed, 7 Apr 2021 11:28:51 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
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
Subject: Re: [PATCH v4 5/8] hugetlb: call update_and_free_page without
 hugetlb_lock
Message-ID: <YG17U4PolKicoch8@dhcp22.suse.cz>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-6-mike.kravetz@oracle.com>
 <20210407082744.GA10058@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407082744.GA10058@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-04-21 10:27:49, Oscar Salvador wrote:
> On Mon, Apr 05, 2021 at 04:00:40PM -0700, Mike Kravetz wrote:
[...]
> > @@ -2671,22 +2682,34 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
> >  						nodemask_t *nodes_allowed)
> >  {
> >  	int i;
> > +	struct page *page, *next;
> > +	LIST_HEAD(page_list);
> >  
> >  	if (hstate_is_gigantic(h))
> >  		return;
> >  
> > +	/*
> > +	 * Collect pages to be freed on a list, and free after dropping lock
> > +	 */
> >  	for_each_node_mask(i, *nodes_allowed) {
> > -		struct page *page, *next;
> >  		struct list_head *freel = &h->hugepage_freelists[i];
> >  		list_for_each_entry_safe(page, next, freel, lru) {
> >  			if (count >= h->nr_huge_pages)
> > -				return;
> > +				goto out;
> >  			if (PageHighMem(page))
> >  				continue;
> >  			remove_hugetlb_page(h, page, false);
> > -			update_and_free_page(h, page);
> > +			list_add(&page->lru, &page_list);
> >  		}
> >  	}
> > +
> > +out:
> > +	spin_unlock(&hugetlb_lock);
> > +	list_for_each_entry_safe(page, next, &page_list, lru) {
> > +		update_and_free_page(h, page);
> > +		cond_resched();
> > +	}
> > +	spin_lock(&hugetlb_lock);
> 
> Can we get here with an empty list?

An emoty page_list? If yes then sure, this can happen but
list_for_each_entry_safe will simply not iterate. Or what do you mean?
-- 
Michal Hocko
SUSE Labs
