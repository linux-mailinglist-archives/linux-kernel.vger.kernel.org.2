Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684AD34E2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhC3ISz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:18:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:42298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231359AbhC3ISm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:18:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617092321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wNw4nGVKh6SriT/z86f2SGzgVHpW0NorEGH4COOxJUo=;
        b=l8JS67PZkLeSBclyeYuVlbPnE6ocBl1TXDJ8G0G72ngoWy6FLGLhJWgfW8qEalAdsZ3RBN
        7hXMQp9JY8kb+azQhsW14wJNiUxZo+CnhlCTEL5DPM3xGjSZOzbuRgDQ13XtZBC8fTxzmR
        uny1PEiAX5U8jCXzvf3pkWrNedW59ks=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EAB04AEF5;
        Tue, 30 Mar 2021 08:18:40 +0000 (UTC)
Date:   Tue, 30 Mar 2021 10:18:39 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
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
Subject: Re: [External] Re: [PATCH v2 1/8] mm/cma: change cma mutex to irq
 safe spinlock
Message-ID: <YGLe31q/4kAoLmmr@dhcp22.suse.cz>
References: <20210329232402.575396-1-mike.kravetz@oracle.com>
 <20210329232402.575396-2-mike.kravetz@oracle.com>
 <YGLayMqYOrMMQ841@dhcp22.suse.cz>
 <CAMZfGtUv4O_+W5rHt0P4Xbw=WXJ-ZwHYMrg=iJa2CEkfxb91gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtUv4O_+W5rHt0P4Xbw=WXJ-ZwHYMrg=iJa2CEkfxb91gA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-03-21 16:08:36, Muchun Song wrote:
> On Tue, Mar 30, 2021 at 4:01 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 29-03-21 16:23:55, Mike Kravetz wrote:
> > > Ideally, cma_release could be called from any context.  However, that is
> > > not possible because a mutex is used to protect the per-area bitmap.
> > > Change the bitmap to an irq safe spinlock.
> >
> > I would phrase the changelog slightly differerent
> > "
> > cma_release is currently a sleepable operatation because the bitmap
> > manipulation is protected by cma->lock mutex. Hugetlb code which relies
> > on cma_release for CMA backed (giga) hugetlb pages, however, needs to be
> > irq safe.
> >
> > The lock doesn't protect any sleepable operation so it can be changed to
> > a (irq aware) spin lock. The bitmap processing should be quite fast in
> > typical case but if cma sizes grow to TB then we will likely need to
> > replace the lock by a more optimized bitmap implementation.
> > "
> >
> > it seems that you are overusing irqsave variants even from context which
> > are never called from the IRQ context so they do not need storing flags.
> >
> > [...]
> > > @@ -391,8 +391,9 @@ static void cma_debug_show_areas(struct cma *cma)
> > >       unsigned long start = 0;
> > >       unsigned long nr_part, nr_total = 0;
> > >       unsigned long nbits = cma_bitmap_maxno(cma);
> > > +     unsigned long flags;
> > >
> > > -     mutex_lock(&cma->lock);
> > > +     spin_lock_irqsave(&cma->lock, flags);
> >
> > spin_lock_irq should be sufficient. This is only called from the
> > allocation context and that is never called from IRQ context.
> 
> This makes me think more. I think that spin_lock should be
> sufficient. Right?

Nope. Think of the following scenario
	spin_lock(cma->lock);
	<IRQ>
	put_page
	  __free_huge_page
	    cma_release
	      spin_lock_irqsave() DEADLOCK
-- 
Michal Hocko
SUSE Labs
