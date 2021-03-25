Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B848D348DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhCYKMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:12:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:44838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhCYKLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:11:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616667110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EIkHbXDb/i6xPkCAyF4U442rC/hx9VdhrbGtj9pOovw=;
        b=bX08Ly5d3CTlSBvappvx3WnH2vIhXx8+VKqLDsXv0j11VvUQGi34G+YZZNdkUV0yDmiNDh
        dIWdD0DCloytTFa/bvdDYORvyd6Enc/pNsylxggNUa9xaFppbcmB3dWA2OCduG/W7zu/Gs
        apfdGtV8zGXGOM/A97NqQfeD7OjQjdM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1D42AC16;
        Thu, 25 Mar 2021 10:11:50 +0000 (UTC)
Date:   Thu, 25 Mar 2021 11:11:49 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
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
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/8] mm: cma: introduce cma_release_nowait()
Message-ID: <YFxh5SgXnKsbiFgj@dhcp22.suse.cz>
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

On Thu 25-03-21 10:45:19, Michal Hocko wrote:
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
> 
> I cannot judge the CMA parts from a very quick glance this looks
> reasonably.

I have overlooked that
+static void cma_clear_bitmap_fn(struct work_struct *work)
+{
+       struct cma_clear_bitmap_work *w;
+
+       w = container_of(work, struct cma_clear_bitmap_work, work);
+
+       cma_clear_bitmap(w->cma, w->pfn, w->count);
+
+       __free_page(pfn_to_page(w->pfn));
+}

should be doing free_contig_range with w->count target.
-- 
Michal Hocko
SUSE Labs
