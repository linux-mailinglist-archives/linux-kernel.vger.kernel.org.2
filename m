Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94372348DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhCYKKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:10:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:43958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230119AbhCYKKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:10:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616667030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o+O8DfigmD78cxzDLQFiEri2lafjyCUlwz+crQjIF+s=;
        b=WqScUkqiftCKLWBPs3UOhfC92i9LOcE0v5mjJQCiX6snpSfjtx+G/NO3zfzBzoyQL2C00x
        aboX26KjHcE4x0xTn2dSI/ar4d4ePMlQzNuwesqFZi+FPCDFIJJXpDC1eV2rNTP9NZ4jMC
        V9GpRzrxkZDymU+GPRsBMDqc73KglXo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9A7DAA55;
        Thu, 25 Mar 2021 10:10:30 +0000 (UTC)
Date:   Thu, 25 Mar 2021 11:10:27 +0100
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/8] mm: cma: introduce cma_release_nowait()
Message-ID: <YFxhk7ZRNzXopsJ6@dhcp22.suse.cz>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-2-mike.kravetz@oracle.com>
 <YFxbrn7pHN4TIHkR@dhcp22.suse.cz>
 <YFxdwr2+jLLMAII0@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFxdwr2+jLLMAII0@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-03-21 10:54:10, Oscar Salvador wrote:
> On Thu, Mar 25, 2021 at 10:45:18AM +0100, Michal Hocko wrote:
> > On Wed 24-03-21 17:28:28, Mike Kravetz wrote:
> > [...]
> > >  phys_addr_t cma_get_base(const struct cma *cma)
> > >  {
> > >  	return PFN_PHYS(cma->base_pfn);
> > > @@ -146,6 +155,10 @@ static int __init cma_init_reserved_areas(void)
> > >  	for (i = 0; i < cma_area_count; i++)
> > >  		cma_activate_area(&cma_areas[i]);
> > >  
> > > +	cma_release_wq = create_workqueue("cma_release");
> > 
> > Considering the workqueue is used to free up memory it should likely be
> > WQ_MEM_RECLAIM to prevent from long stalls when WQs are overloaded.
> 
> I might be missing something but the worqueue->func() seems to not be anything
> for memory related purposes.
> The worqueue calls cma_clear_bitmap_fn(), and the only think that does
> is freeing one page, and clearing the bitmap. 

No, it shouldn't realease a sing page. That is a bug which I have
overlooked as well. I should free up the whole count worth of pages.
But fundamentally the worker does all the heavy lifting and frees up the
memory.

-- 
Michal Hocko
SUSE Labs
