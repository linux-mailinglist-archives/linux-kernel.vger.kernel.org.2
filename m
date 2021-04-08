Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B7C357D0B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhDHHLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:11:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:33560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhDHHLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:11:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8BA04AFC1;
        Thu,  8 Apr 2021 07:11:35 +0000 (UTC)
Date:   Thu, 8 Apr 2021 09:11:30 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 0/8] make hugetlb put_page safe for all calling
 contexts
Message-ID: <YG6soiwXQJ6EEA+N@localhost.localdomain>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <01d8785f-efeb-553d-f075-6501c621ae20@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01d8785f-efeb-553d-f075-6501c621ae20@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 05:56:55PM -0700, Mike Kravetz wrote:
> Hello Andrew,
> 
> It has been suggested that this series be included before Oscar Salvador's
> series "Make alloc_contig_range handle Hugetlb pages".  At a logical
> level, here is what I think needs to happen.  However, I am not sure how
> you do tree management and I am open to anything you suggest.  Please do
> not start until we get an Ack from Oscar as he will need to participate.

As I said, this is fine by me.
I think it is the most straightforward way to proceed with this series
as this is a problem that has been bugging us fore quite some time now.

See below:

 
> Remove patches for the series "Make alloc_contig_range handle Hugetlb pages"
> from Oscar Salvador.
> - mm,page_alloc: drop unnecessary checks from pfn_range_valid_contig
> - mm: make alloc_contig_range handle in-use hugetlb pages
> - mm: make alloc_contig_range handle free hugetlb pages

Yes, those need to be removed

>   /*
>    * Technically, the following patches do not need to be removed as
>    * they do not interact with Mike's changes.  Again, they do
>    * contain 'cover letter comments' in the commit messages which may
>    * not make sense out of context.
>    */
> - mmcompaction-let-isolate_migratepages_rangeblock-return-error-codes-fix
> - mm,compaction: let isolate_migratepages_{range,block} return error codes

Those could stay as well, but they mention a change in
alloc_contig_range() and without the context of the whole patchset might
be misleading, so I would pull those out as well.

> - mm,page_alloc: bail out earlier on -ENOMEM in alloc_contig_migrate_range

I think this one can stay.

But if It is going to be easier for Andrew, just pull them all out and I
will resend the whole series once this work goes in.

Thanks!

-- 
Oscar Salvador
SUSE L3
