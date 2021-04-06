Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA07354DAB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 09:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244218AbhDFHSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 03:18:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:37472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232042AbhDFHSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 03:18:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C9768B0B6;
        Tue,  6 Apr 2021 07:18:28 +0000 (UTC)
Date:   Tue, 6 Apr 2021 09:18:24 +0200
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
Subject: Re: [PATCH v4 2/8] hugetlb: no need to drop hugetlb_lock to call
 cma_release
Message-ID: <YGwLQLse/uNGOjXM@localhost.localdomain>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405230043.182734-3-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 04:00:37PM -0700, Mike Kravetz wrote:
> Now that cma_release is non-blocking and irq safe, there is no need to
> drop hugetlb_lock before calling.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/hugetlb.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3c3e4baa4156..1d62f0492e7b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1353,14 +1353,8 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>  	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
>  	set_page_refcounted(page);
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
> -- 
> 2.30.2
> 

-- 
Oscar Salvador
SUSE L3
