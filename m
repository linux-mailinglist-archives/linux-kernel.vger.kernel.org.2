Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D6A34590F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCWHsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:48:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:42840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhCWHsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:48:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616485699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BM8b0sFo80e7PXN1CbnuKE6PJHUsFqB8ezy1Qvjj0z4=;
        b=H8fRgPDl7snu6FtB2cTPcZNvTYoKt0MHn24yfZ1TUm5uycg6kiKzPFMr0uOVyB5Hae+UhW
        WXt3Hg7gV+eUtfX9JuhQFfi/R5s+3pMAufGqbO+RgWIp7naPUQ2BlTzmRHZKi+FzpgsaXQ
        tTZBOHNAXBCkhxEnalPTH4U/ay5mJMY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D1C4AC3E;
        Tue, 23 Mar 2021 07:48:19 +0000 (UTC)
Date:   Tue, 23 Mar 2021 08:48:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/8] hugetlb: add per-hstate mutex to synchronize
 user adjustments
Message-ID: <YFmdPMBKcc858fUg@dhcp22.suse.cz>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-2-mike.kravetz@oracle.com>
 <YFiipzEs0wuL/Qdl@dhcp22.suse.cz>
 <c88f14aa-cff1-a857-e969-fc5d491e8f2d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c88f14aa-cff1-a857-e969-fc5d491e8f2d@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-03-21 09:57:14, Mike Kravetz wrote:
> On 3/22/21 6:59 AM, Michal Hocko wrote:
> > On Fri 19-03-21 15:42:02, Mike Kravetz wrote:
> >> The number of hugetlb pages can be adjusted by writing to the
> >> sysps/proc files nr_hugepages, nr_hugepages_mempolicy or
> >> nr_overcommit_hugepages.  There is nothing to prevent two
> >> concurrent modifications via these files.  The underlying routine
> >> set_max_huge_pages() makes assumptions that only one occurrence is
> >> running at a time.  Specifically, alloc_pool_huge_page uses a
> >> hstate specific variable without any synchronization.
> > 
> > From the above it is not really clear whether the unsynchronized nature
> > of set_max_huge_pages is really a problem or a mere annoynce. I suspect
> > the later because counters are properly synchronized with the
> > hugetlb_lock. It would be great to clarify that.
> >  
> 
> It is a problem and an annoyance.
> 
> The problem is that alloc_pool_huge_page -> for_each_node_mask_to_alloc is
> called after dropping the hugetlb lock.  for_each_node_mask_to_alloc
> uses the helper hstate_next_node_to_alloc which uses and modifies
> h->next_nid_to_alloc.  Worst case would be two instances of set_max_huge_pages
> trying to allocate pages on different sets of nodes.  Pages could get
> allocated on the wrong nodes.

Yes, what I meant by the annoyance. On the other hand a parallel access
to a global knob mantaining a global resource should be expected to
have some side effects without an external synchronization unless it is
explicitly documented that such an access is synchronized internally.

> I really doubt this problem has ever been experienced in practice.
> However, when looking at the code in was a real annoyance. :)

IMHO it would be a bit of a stretch to consider it a real life problem.
 
> I'll update the commit message to be more clear.

Thanks! Clarification will definitely help.
-- 
Michal Hocko
SUSE Labs
