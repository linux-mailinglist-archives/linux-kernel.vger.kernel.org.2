Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25153348D74
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCYJy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:54:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:56240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhCYJyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:54:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 041C6AA55;
        Thu, 25 Mar 2021 09:54:18 +0000 (UTC)
Date:   Thu, 25 Mar 2021 10:54:10 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <YFxdwr2+jLLMAII0@localhost.localdomain>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-2-mike.kravetz@oracle.com>
 <YFxbrn7pHN4TIHkR@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFxbrn7pHN4TIHkR@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 10:45:18AM +0100, Michal Hocko wrote:
> On Wed 24-03-21 17:28:28, Mike Kravetz wrote:
> [...]
> >  phys_addr_t cma_get_base(const struct cma *cma)
> >  {
> >  	return PFN_PHYS(cma->base_pfn);
> > @@ -146,6 +155,10 @@ static int __init cma_init_reserved_areas(void)
> >  	for (i = 0; i < cma_area_count; i++)
> >  		cma_activate_area(&cma_areas[i]);
> >  
> > +	cma_release_wq = create_workqueue("cma_release");
> 
> Considering the workqueue is used to free up memory it should likely be
> WQ_MEM_RECLAIM to prevent from long stalls when WQs are overloaded.

I might be missing something but the worqueue->func() seems to not be anything
for memory related purposes.

The worqueue calls cma_clear_bitmap_fn(), and the only think that does
is freeing one page, and clearing the bitmap. 
I might be reading the CMA code wrongly, but I cannot see any freeing up
of memory in cma_clear_bitmap()->__bitmap_clear() (or its siblings).

The actual freeing of memory seems to happen in cma_release_no_wait()
with: 

 if (count > 1)
       free_contig_range(pfn + 1, count - 1);

-- 
Oscar Salvador
SUSE L3
