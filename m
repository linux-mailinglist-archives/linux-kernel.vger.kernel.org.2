Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198D4332585
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCIMdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhCIMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:33:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC62C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 04:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xkCNI64hFClFy4A9TLVYq/KYOxo40opRSbt2HLqUIYI=; b=Se3SAc/ZLY0FrA6oLAdpuIW3+f
        V9P1eOmnPvp/uKVvPLAKKPF742Te8jOhuqQ+EuZ5f9JQ/h4MlVMV7vYecJLfbhYteFL5/MUhFfMdD
        ad5TuSkFbAGeTKiMsA0vPrdn6feG/YdiRgIs8T8GWZSzbbERJ2I83hks7QVqvrQW4MSD9Qe98KB4a
        uPGhy+A01HzP45BfE91NkC7FKMlgmXQwAL0FZL9xze9Pq2JlOM+lZ7kzkB7nHoW1ckQxHoCDWIJhJ
        887WmPbD7l4CZ5yYGrRTjLqg744yNTLssOyyE3/bkF2/JolFsiKT2zx5Hu6PnH1YmC95ibxc4NuqB
        9mk36XUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJbXj-000ZfQ-AC; Tue, 09 Mar 2021 12:32:55 +0000
Date:   Tue, 9 Mar 2021 12:32:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 2/2] mm/memcg: set memcg when split page
Message-ID: <20210309123255.GI3479805@casper.infradead.org>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-3-zhouguanghui1@huawei.com>
 <20210308210225.GF3479805@casper.infradead.org>
 <YEc5iI+ZP7dWr2fC@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEc5iI+ZP7dWr2fC@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 10:02:00AM +0100, Michal Hocko wrote:
> On Mon 08-03-21 21:02:25, Matthew Wilcox wrote:
> > On Thu, Mar 04, 2021 at 07:40:53AM +0000, Zhou Guanghui wrote:
> > > For example, when alloc_pages_exact is used to allocate 1MB continuous
> > > physical memory, 2MB is charged(kmemcg is enabled and __GFP_ACCOUNT is
> > > set). When make_alloc_exact free the unused 1MB and free_pages_exact
> > > free the applied 1MB, actually, only 4KB(one page) is uncharged.

> > @@ -5081,9 +5081,15 @@ void __free_pages(struct page *page, unsigned int order)
> >  {
> >         if (put_page_testzero(page))
> >                 free_the_page(page, order);
> > -       else if (!PageHead(page))
> > -               while (order-- > 0)
> > -                       free_the_page(page + (1 << order), order);
> > +       else if (!PageHead(page)) {
> > +               while (order-- > 0) {
> > +                       struct page *tail = page + (1 << order);
> > +#ifdef CONFIG_MEMCG
> > +                       tail->memcg_data = page->memcg_data;
> > +#endif
> > +                       free_the_page(tail, order);
> > +               }
> > +       }
> >  }
> >  EXPORT_SYMBOL(__free_pages);
> 
> Hmm, I was not aware of this code. This is really a tricky code.

Yes.  I only added it recently.  I don't see a better way to solve this
problem.  We could turn the non-compound page into a compound page at
this point, but I'm not sure that's really less tricky.

> > I wonder if we shouldn't initialise memcg_data on all subsequent pages
> > of non-compound allocations instead?  Because I'm not sure this is the
> > only place that needs to be fixed.
> 
> That would be safer for sure. Do you mean this as a replacement to the
> original patch?
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 913c2b9e5c72..d44dea2b8d22 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3135,8 +3135,21 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>  	if (memcg && !mem_cgroup_is_root(memcg)) {
>  		ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
>  		if (!ret) {
> +			int nr_pages = 1 << order;
>  			page->memcg_data = (unsigned long)memcg |
>  				MEMCG_DATA_KMEM;
> +			
> +			/*
> +			 * Compound pages are normally split or freed
> +			 * via their head pages so memcg_data in in the
> +			 * head page should be sufficient but there
> +			 * are exceptions to the rule (see __free_pages).
> +			 * Non compound pages would need to copy memcg anyway.
> +			 */
> +			for (i = 1; i < nr_pages; i++) {
> +				struct page * p = page + i;
> +				p->memcg_data = page->memcg_data
> +			}
>  			return 0;

I would condition this loop on if (!(gfp & __GFP_COMP)), but yes, something
along these lines.  I might phrase the comment a little differently ...

			/*
			 * Compound pages are treated as a single unit,
			 * but non-compound pages can be freed individually
			 * so each page needs to have its memcg set to get
			 * the accounting right.
			 */
