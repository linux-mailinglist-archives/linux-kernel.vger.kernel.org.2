Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F5E348DED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhCYKYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:24:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:49700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230189AbhCYKYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:24:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616667871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MY7sSmU90y5JQm0YzMx7OMqCkCu0pemuSB7/AZ6UPuk=;
        b=etQd2/pC+ndUlJPJsiLN9+jhei3Tq6e+9OLuoPH5S/zeB/Krh0/FCLmJ8xpx7l875ZD8/G
        KdQuppFRhlzu3GSrcqtII78AHv4OgGZsVDjqsV5CL+S96lcLHMvWCqLtJadaDZzslL1tk4
        nXjeSV5yrEh3uTANJAv0YPRVmJn8wfY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF7E6AA55;
        Thu, 25 Mar 2021 10:24:30 +0000 (UTC)
Date:   Thu, 25 Mar 2021 11:24:29 +0100
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
Message-ID: <YFxk3UPLHI8/6XOh@dhcp22.suse.cz>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-2-mike.kravetz@oracle.com>
 <YFxbrn7pHN4TIHkR@dhcp22.suse.cz>
 <YFxh5SgXnKsbiFgj@dhcp22.suse.cz>
 <YFxjPDRFfaUMPjmr@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFxjPDRFfaUMPjmr@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-03-21 11:17:32, Oscar Salvador wrote:
> On Thu, Mar 25, 2021 at 11:11:49AM +0100, Michal Hocko wrote:
> > I have overlooked that
> > +static void cma_clear_bitmap_fn(struct work_struct *work)
> > +{
> > +       struct cma_clear_bitmap_work *w;
> > +
> > +       w = container_of(work, struct cma_clear_bitmap_work, work);
> > +
> > +       cma_clear_bitmap(w->cma, w->pfn, w->count);
> > +
> > +       __free_page(pfn_to_page(w->pfn));
> > +}
> > 
> > should be doing free_contig_range with w->count target.
> 
> That is currently done in cma_release_nowait().
> You meant we should move that work there in the wq?

I have missed that part. My bad. But it seems this whole thing is moot
because we can make the lock a spinlock as pointed out by David.

-- 
Michal Hocko
SUSE Labs
