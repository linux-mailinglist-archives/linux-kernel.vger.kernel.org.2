Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA2A35681B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350151AbhDGJdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:33:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:45636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233469AbhDGJd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:33:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617787999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TXLJV284jnANi9LMOnlggnq83BgKfiBMnl0i0DxmbPc=;
        b=cnPbl93icESGJk/GD4BbQ+qSoUDlJBevwmLuFJa8AeqdA1krL3QaqS5DZ3P9r5zEjVkK1i
        H2HvfldrszuSQDwk8GbL2ECDGZpOafCWL9N/vDJM7U+u62rfDTlWLHcWO0FBKI3/mpQ+gD
        IOvqjjRnMsUfZifXOaLVBYjNcCvEkP8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A72B0AF9E;
        Wed,  7 Apr 2021 09:33:19 +0000 (UTC)
Date:   Wed, 7 Apr 2021 11:33:18 +0200
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 7/8] hugetlb: make free_huge_page irq safe
Message-ID: <YG18Xtk3GVa+NY+B@dhcp22.suse.cz>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-8-mike.kravetz@oracle.com>
 <20210407091237.GC10058@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407091237.GC10058@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-04-21 11:12:37, Oscar Salvador wrote:
> On Mon, Apr 05, 2021 at 04:00:42PM -0700, Mike Kravetz wrote:
> > Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in
> > non-task context") was added to address the issue of free_huge_page
> > being called from irq context.  That commit hands off free_huge_page
> > processing to a workqueue if !in_task.  However, this doesn't cover
> > all the cases as pointed out by 0day bot lockdep report [1].
> > 
> > :  Possible interrupt unsafe locking scenario:
> > :
> > :        CPU0                    CPU1
> > :        ----                    ----
> > :   lock(hugetlb_lock);
> > :                                local_irq_disable();
> > :                                lock(slock-AF_INET);
> > :                                lock(hugetlb_lock);
> > :   <Interrupt>
> > :     lock(slock-AF_INET);
> > 
> > Shakeel has later explained that this is very likely TCP TX zerocopy
> > from hugetlb pages scenario when the networking code drops a last
> > reference to hugetlb page while having IRQ disabled. Hugetlb freeing
> > path doesn't disable IRQ while holding hugetlb_lock so a lock dependency
> > chain can lead to a deadlock.
> > 
> > This commit addresses the issue by doing the following:
> > - Make hugetlb_lock irq safe.  This is mostly a simple process of
> >   changing spin_*lock calls to spin_*lock_irq* calls.
> > - Make subpool lock irq safe in a similar manner.
> > - Revert the !in_task check and workqueue handoff.
> > 
> > [1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> 
> So, irq_lock_irqsave/spin_unlock_irqrestore is to be used in places
> that might have been called from an IRQ context?

Yes. spin_unlock_irq will enable interrupts unconditionally which is
certainly not what we want if the path is called with IRQ disabled by
the caller.
-- 
Michal Hocko
SUSE Labs
