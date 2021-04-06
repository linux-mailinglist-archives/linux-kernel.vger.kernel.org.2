Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6467C35556D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344605AbhDFNlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:41:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:46748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238827AbhDFNlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:41:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 811DAB1AD;
        Tue,  6 Apr 2021 13:41:13 +0000 (UTC)
Date:   Tue, 6 Apr 2021 15:41:07 +0200
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
Subject: Re: [PATCH v4 4/8] hugetlb: create remove_hugetlb_page() to separate
 functionality
Message-ID: <YGxk85nXJD+NxzYX@localhost.localdomain>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-5-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405230043.182734-5-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 04:00:39PM -0700, Mike Kravetz wrote:
> +static void remove_hugetlb_page(struct hstate *h, struct page *page,
> +							bool adjust_surplus)
> +{
> +	int nid = page_to_nid(page);
> +
> +	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> +		return;
> +
> +	list_del(&page->lru);
> +
> +	if (HPageFreed(page)) {
> +		h->free_huge_pages--;
> +		h->free_huge_pages_node[nid]--;
> +		ClearHPageFreed(page);
> +	}
> +	if (adjust_surplus) {
> +		h->surplus_huge_pages--;
> +		h->surplus_huge_pages_node[nid]--;
> +	}
> +
> +	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> +	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);

These checks feel a bit odd here.
I would move them above, before we start messing with the counters?

> +
> +	ClearHPageTemporary(page);

Why clearing it unconditionally? I guess we do not really care, but
someone might wonder why when reading the core.
So I would either do as we used to do and only clear it in case of
HPageTemporary(), or drop a comment.

> +	set_page_refcounted(page);
> +	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> +
> +	h->nr_huge_pages--;
> +	h->nr_huge_pages_node[nid]--;
> +}

As Michal pointed out, remove_hugetlb_page() from
alloc_and_dissolve_huge_page() might be problematic in some cases because
the new_page has not been enqueued yet.

Now, I guess this might be easily fixed with checking list_empty()
before going ahead with list_del() call, or with another bool parameter
'delete', with a fat comment explaining why we can get to call remove_huge_page()
on a page that is not in any list.

Another solution that comes to my mind is to split remove_huge_page() functionality in
1) delete from list + unaccount free and surplus pages and 2) reset page's state + unaccount
nr_huge_pages

But that might be just biased as would fit for my usecase.
So maybe a list_empty() or the bool parameter might just do.
 

-- 
Oscar Salvador
SUSE L3
