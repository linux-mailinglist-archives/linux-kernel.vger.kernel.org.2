Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD95F332605
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCINEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:04:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:47602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229815AbhCINDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:03:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615295016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XNqMJTZRcxP+so+/LPiiWfIm0sQR5ZAm8YLJEpNLBpA=;
        b=OZYlBwlFpHGak7XGxXHtK2D1CM1QdpWMKU+YjFdKmd2vkEIfXike8CPjufUuC/ROP9TLw8
        kCz/tSxJOnMFGLDVhjNJV1jBiL5XSR4McqP4z0GILECwOkUVSk/l4NKdiOdkOY0D86T2BZ
        q4rGTHLHfcQwtLdwa9jf8eTTzPbAj04=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73DEFAC17;
        Tue,  9 Mar 2021 13:03:36 +0000 (UTC)
Date:   Tue, 9 Mar 2021 14:03:35 +0100
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
Message-ID: <YEdyJ+ZK2l7tu0rw@dhcp22.suse.cz>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-3-zhouguanghui1@huawei.com>
 <20210308210225.GF3479805@casper.infradead.org>
 <YEc5iI+ZP7dWr2fC@dhcp22.suse.cz>
 <20210309123255.GI3479805@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309123255.GI3479805@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-03-21 12:32:55, Matthew Wilcox wrote:
> On Tue, Mar 09, 2021 at 10:02:00AM +0100, Michal Hocko wrote:
[...]
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 913c2b9e5c72..d44dea2b8d22 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -3135,8 +3135,21 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
> >  	if (memcg && !mem_cgroup_is_root(memcg)) {
> >  		ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
> >  		if (!ret) {
> > +			int nr_pages = 1 << order;
> >  			page->memcg_data = (unsigned long)memcg |
> >  				MEMCG_DATA_KMEM;
> > +			
> > +			/*
> > +			 * Compound pages are normally split or freed
> > +			 * via their head pages so memcg_data in in the
> > +			 * head page should be sufficient but there
> > +			 * are exceptions to the rule (see __free_pages).
> > +			 * Non compound pages would need to copy memcg anyway.
> > +			 */
> > +			for (i = 1; i < nr_pages; i++) {
> > +				struct page * p = page + i;
> > +				p->memcg_data = page->memcg_data
> > +			}
> >  			return 0;
> 
> I would condition this loop on if (!(gfp & __GFP_COMP)), but yes, something
> along these lines.  I might phrase the comment a little differently ...
> 
> 			/*
> 			 * Compound pages are treated as a single unit,
> 			 * but non-compound pages can be freed individually
> 			 * so each page needs to have its memcg set to get
> 			 * the accounting right.
> 			 */

OK, I must have misunderstood your __free_pages fix then. I thought this
was about compound pages. Btw. again I forgot about css ref counting so
here is an updated version.

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 913c2b9e5c72..ec2c705f38fa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3133,10 +3133,22 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 
 	memcg = get_mem_cgroup_from_current();
 	if (memcg && !mem_cgroup_is_root(memcg)) {
-		ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
+		int nr_pages = 1 << order;
+		ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
 		if (!ret) {
 			page->memcg_data = (unsigned long)memcg |
 				MEMCG_DATA_KMEM;
+			if (nr_pages > 1) {
+				/*
+				 * comment goes here
+				 */
+				for (i = 1; i < nr_pages; i++) {
+					struct page * p = page + i;
+					p->memcg_data = page->memcg_data
+				}
+				/* Head page reference from get_mem_cgroup_from_current */
+				css_get_many(&memcg->css, nr_pages - 1);
+			}
 			return 0;
 		}
 		css_put(&memcg->css);

-- 
Michal Hocko
SUSE Labs
