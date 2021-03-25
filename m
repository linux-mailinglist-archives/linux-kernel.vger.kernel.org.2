Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8EA348DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhCYKRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:17:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:47372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhCYKRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:17:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1EC11AC16;
        Thu, 25 Mar 2021 10:17:37 +0000 (UTC)
Date:   Thu, 25 Mar 2021 11:17:32 +0100
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
Message-ID: <YFxjPDRFfaUMPjmr@localhost.localdomain>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-2-mike.kravetz@oracle.com>
 <YFxbrn7pHN4TIHkR@dhcp22.suse.cz>
 <YFxh5SgXnKsbiFgj@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFxh5SgXnKsbiFgj@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 11:11:49AM +0100, Michal Hocko wrote:
> I have overlooked that
> +static void cma_clear_bitmap_fn(struct work_struct *work)
> +{
> +       struct cma_clear_bitmap_work *w;
> +
> +       w = container_of(work, struct cma_clear_bitmap_work, work);
> +
> +       cma_clear_bitmap(w->cma, w->pfn, w->count);
> +
> +       __free_page(pfn_to_page(w->pfn));
> +}
> 
> should be doing free_contig_range with w->count target.

That is currently done in cma_release_nowait().
You meant we should move that work there in the wq?

I thought the reason for creating a WQ in the first place was to have a
non-blocking cma_release() variant, as we might block down the chain
when clearing the bitmat, I do not think this was about freeing up
memory, or at least the changelog did not mention it.

Also, IIUC, we use the first page to store the workqueue information (we use it
as a storage for it, in cma_release_nowait()), that is why once we are done with
the workqueue work in cma_clear_bitmap_fn(), we can free that page.

-- 
Oscar Salvador
SUSE L3
