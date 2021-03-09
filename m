Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D994332181
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhCIJCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:02:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:50732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhCIJCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:02:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615280522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dce3cOdvnV2ClNKK9GPexH0rXQvpFnYmQS/x3knbop0=;
        b=TjE27we03nbMZ65GkVHR9bTmOSVDkiJqFD/+aoLCoYaYymNsPnJCbJS/NdDhMOwMYY1nCk
        iDQxQ7I4XMU+Q3EYPqWpmTb0z3Mqbk+G8OWHdvJukv/9ODODKAiwPqRXC5VAy8LyqV288E
        9YF2IncWtI/zPuCdvoIR/NFHDELMzP8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CD201AC1F;
        Tue,  9 Mar 2021 09:02:01 +0000 (UTC)
Date:   Tue, 9 Mar 2021 10:02:00 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zhou Guanghui <zhouguanghui1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 2/2] mm/memcg: set memcg when split page
Message-ID: <YEc5iI+ZP7dWr2fC@dhcp22.suse.cz>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-3-zhouguanghui1@huawei.com>
 <20210308210225.GF3479805@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308210225.GF3479805@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08-03-21 21:02:25, Matthew Wilcox wrote:
> On Thu, Mar 04, 2021 at 07:40:53AM +0000, Zhou Guanghui wrote:
> > As described in the split_page function comment, for the non-compound
> > high order page, the sub-pages must be freed individually. If the
> > memcg of the fisrt page is valid, the tail pages cannot be uncharged
> > when be freed.
> > 
> > For example, when alloc_pages_exact is used to allocate 1MB continuous
> > physical memory, 2MB is charged(kmemcg is enabled and __GFP_ACCOUNT is
> > set). When make_alloc_exact free the unused 1MB and free_pages_exact
> > free the applied 1MB, actually, only 4KB(one page) is uncharged.
> > 
> > Therefore, the memcg of the tail page needs to be set when split page.
> 
> There's another place we need to do this to ...
> 
> +++ b/mm/page_alloc.c
> @@ -5081,9 +5081,15 @@ void __free_pages(struct page *page, unsigned int order)
>  {
>         if (put_page_testzero(page))
>                 free_the_page(page, order);
> -       else if (!PageHead(page))
> -               while (order-- > 0)
> -                       free_the_page(page + (1 << order), order);
> +       else if (!PageHead(page)) {
> +               while (order-- > 0) {
> +                       struct page *tail = page + (1 << order);
> +#ifdef CONFIG_MEMCG
> +                       tail->memcg_data = page->memcg_data;
> +#endif
> +                       free_the_page(tail, order);
> +               }
> +       }
>  }
>  EXPORT_SYMBOL(__free_pages);

Hmm, I was not aware of this code. This is really a tricky code.

> I wonder if we shouldn't initialise memcg_data on all subsequent pages
> of non-compound allocations instead?  Because I'm not sure this is the
> only place that needs to be fixed.

That would be safer for sure. Do you mean this as a replacement to the
original patch?

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 913c2b9e5c72..d44dea2b8d22 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3135,8 +3135,21 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 	if (memcg && !mem_cgroup_is_root(memcg)) {
 		ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
 		if (!ret) {
+			int nr_pages = 1 << order;
 			page->memcg_data = (unsigned long)memcg |
 				MEMCG_DATA_KMEM;
+			
+			/*
+			 * Compound pages are normally split or freed
+			 * via their head pages so memcg_data in in the
+			 * head page should be sufficient but there
+			 * are exceptions to the rule (see __free_pages).
+			 * Non compound pages would need to copy memcg anyway.
+			 */
+			for (i = 1; i < nr_pages; i++) {
+				struct page * p = page + i;
+				p->memcg_data = page->memcg_data
+			}
 			return 0;
 		}
 		css_put(&memcg->css);
-- 
Michal Hocko
SUSE Labs
