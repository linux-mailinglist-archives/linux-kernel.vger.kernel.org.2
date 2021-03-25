Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F9A348DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCYKWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:22:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:49180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230041AbhCYKWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:22:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616667742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NUhM+pMq44irMHX7DfDb0Q+0VoT1g5waQrN7iM9goSQ=;
        b=F97ID0JccJbAI37lYP6SnwfQT6vA2jUoU5aupa5HvrAU5AerC3FqyrVFRbjk1bI6ULJHpM
        N7a+qeoToCGtnrz1cUUmZiwYoDp51hnQa4WxT1WIGM+a/qedaAmJT8cdtd9aLcI1K0VTSR
        IvCmVMe9lwOY2Xtz1p2ya0rUKztVezQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 313F2AA55;
        Thu, 25 Mar 2021 10:22:22 +0000 (UTC)
Date:   Thu, 25 Mar 2021 11:22:20 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
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
Message-ID: <YFxkXEXMpcMM/KWd@dhcp22.suse.cz>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-2-mike.kravetz@oracle.com>
 <aba43427-0f51-7eb9-fa73-6e55237c8ddb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aba43427-0f51-7eb9-fa73-6e55237c8ddb@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-03-21 10:56:38, David Hildenbrand wrote:
> On 25.03.21 01:28, Mike Kravetz wrote:
> > From: Roman Gushchin <guro@fb.com>
> > 
> > cma_release() has to lock the cma_lock mutex to clear the cma bitmap.
> > It makes it a blocking function, which complicates its usage from
> > non-blocking contexts. For instance, hugetlbfs code is temporarily
> > dropping the hugetlb_lock spinlock to call cma_release().
> > 
> > This patch introduces a non-blocking cma_release_nowait(), which
> > postpones the cma bitmap clearance. It's done later from a work
> > context. The first page in the cma allocation is used to store
> > the work struct. Because CMA allocations and de-allocations are
> > usually not that frequent, a single global workqueue is used.
> > 
> > To make sure that subsequent cma_alloc() call will pass, cma_alloc()
> > flushes the cma_release_wq workqueue. To avoid a performance
> > regression in the case when only cma_release() is used, gate it
> > by a per-cma area flag, which is set by the first call
> > of cma_release_nowait().
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > [mike.kravetz@oracle.com: rebased to v5.12-rc3-mmotm-2021-03-17-22-24]
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> 
> 
> 1. Is there a real reason this is a mutex and not a spin lock? It seems to
> only protect the bitmap. Are bitmaps that huge that we spend a significant
> amount of time in there?

Good question. Looking at the code it doesn't seem that there is any
blockable operation or any heavy lifting done under the lock.
7ee793a62fa8 ("cma: Remove potential deadlock situation") has introduced
the lock and there was a simple bitmat protection back then. I suspect
the patch just followed the cma_mutex lead and used the same type of the
lock. cma_mutex used to protect alloc_contig_range which is sleepable.

This all suggests that there is no real reason to use a sleepable lock
at all and we do not need all this heavy lifting.

Thanks!
-- 
Michal Hocko
SUSE Labs
