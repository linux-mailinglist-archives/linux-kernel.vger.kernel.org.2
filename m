Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD33A348D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhCYJjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:39:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:32782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhCYJjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:39:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4179EAD9F;
        Thu, 25 Mar 2021 09:39:34 +0000 (UTC)
Date:   Thu, 25 Mar 2021 10:39:24 +0100
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
Subject: Re: [PATCH 1/8] mm: cma: introduce cma_release_nowait()
Message-ID: <YFxaTO/17EitJ6eI@localhost.localdomain>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325002835.216118-2-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 05:28:28PM -0700, Mike Kravetz wrote:
> +struct cma_clear_bitmap_work {
> +	struct work_struct work;
> +	struct cma *cma;
> +	unsigned long pfn;
> +	unsigned int count;
> +};
> +
>  struct cma cma_areas[MAX_CMA_AREAS];
>  unsigned cma_area_count;
>  
> +struct workqueue_struct *cma_release_wq;

should this be static?

> +
>  phys_addr_t cma_get_base(const struct cma *cma)
>  {
>  	return PFN_PHYS(cma->base_pfn);
> @@ -146,6 +155,10 @@ static int __init cma_init_reserved_areas(void)
>  	for (i = 0; i < cma_area_count; i++)
>  		cma_activate_area(&cma_areas[i]);
>  
> +	cma_release_wq = create_workqueue("cma_release");
> +	if (!cma_release_wq)
> +		return -ENOMEM;
> +

I did not check the code that goes through the initcalls and maybe we
cannot really have this scneario, but what happens if we return -ENOMEM?
Because I can see that later in cma_release_nowait() you mess with
cma_release_wq. Can it be that at that stage cma_release_wq == NULL? due
to -ENOMEM, or are we guaranteed to never reach that point?

Also, should the cma_release_wq go before the cma_activate_area?

> +bool cma_release_nowait(struct cma *cma, const struct page *pages,
> +			unsigned int count)
> +{
> +	struct cma_clear_bitmap_work *work;
> +	unsigned long pfn;
> +
> +	if (!cma || !pages)
> +		return false;
> +
> +	pr_debug("%s(page %p)\n", __func__, (void *)pages);

cma_release() seems to have:

pr_debug("%s(page %p, count %u)\n", __func__, (void *)pages, count);

any reason to not have the same here?


> +
> +	pfn = page_to_pfn(pages);
> +
> +	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count)
> +		return false;
> +
> +	VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
> +
> +	/*
> +	 * Set CMA_DELAYED_RELEASE flag: subsequent cma_alloc()'s
> +	 * will wait for the async part of cma_release_nowait() to
> +	 * finish.
> +	 */
> +	if (unlikely(!test_bit(CMA_DELAYED_RELEASE, &cma->flags)))
> +		set_bit(CMA_DELAYED_RELEASE, &cma->flags);

It seems this cannot really happen? This is the only place we set the
bit, right?
Why not set the bit unconditionally? Against what this is guarding us?

> +
> +	/*
> +	 * To make cma_release_nowait() non-blocking, cma bitmap is cleared
> +	 * from a work context (see cma_clear_bitmap_fn()). The first page
> +	 * in the cma allocation is used to store the work structure,
> +	 * so it's released after the cma bitmap clearance. Other pages
> +	 * are released immediately as previously.
> +	 */
> +	if (count > 1)
> +		free_contig_range(pfn + 1, count - 1);
> +
> +	work = (struct cma_clear_bitmap_work *)page_to_virt(pages);
> +	INIT_WORK(&work->work, cma_clear_bitmap_fn);
> +	work->cma = cma;
> +	work->pfn = pfn;
> +	work->count = count;
> +	queue_work(cma_release_wq, &work->work);

As I said above, can cma_release_wq be NULL if we had -ENOMEM before?


-- 
Oscar Salvador
SUSE L3
