Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D94C3666F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhDUI0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:26:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:52550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234532AbhDUI0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:26:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618993535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yNLpmnjZvLgvr5Vp7qHy21lL8CBq37TPhjd9iVUM/40=;
        b=XYCidtr17qgV1sCe55LfWvxlRgzQe1U/Cx3LPjFDKfuqEWPzul4cT8EdyLBpTHaAWSQyjC
        pitwDM/gJtkPX01GjKPb9QxzcVdw/Wp48G+BgxSa9mYCgBPkDy6L5nW+Lxi0WTA17/tM9H
        vttHXBO+oPkTRLtxiP16nc/4cyZvkpk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C94D6AE85;
        Wed, 21 Apr 2021 08:25:35 +0000 (UTC)
Date:   Wed, 21 Apr 2021 10:25:35 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [External] Re: [PATCH] mm: hugetlb: fix a race between
 memory-failure/soft_offline and gather_surplus_pages
Message-ID: <YH/hf/lfdERqwgRG@dhcp22.suse.cz>
References: <20210421060259.67554-1-songmuchun@bytedance.com>
 <YH/cVoUCTKu/UkqB@dhcp22.suse.cz>
 <CAMZfGtWh4tRiMrOTLvv5GHM1JUCt9b+UHf_DwLev32S=+iLW8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWh4tRiMrOTLvv5GHM1JUCt9b+UHf_DwLev32S=+iLW8g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-04-21 16:15:00, Muchun Song wrote:
> On Wed, Apr 21, 2021 at 4:03 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > [Cc Naoya]
> >
> > On Wed 21-04-21 14:02:59, Muchun Song wrote:
> > > The possible bad scenario:
> > >
> > > CPU0:                           CPU1:
> > >
> > >                                 gather_surplus_pages()
> > >                                   page = alloc_surplus_huge_page()
> > > memory_failure_hugetlb()
> > >   get_hwpoison_page(page)
> > >     __get_hwpoison_page(page)
> > >       get_page_unless_zero(page)
> > >                                   zero = put_page_testzero(page)
> > >                                   VM_BUG_ON_PAGE(!zero, page)
> > >                                   enqueue_huge_page(h, page)
> > >   put_page(page)
> > >
> > > The refcount can possibly be increased by memory-failure or soft_offline
> > > handlers, we can trigger VM_BUG_ON_PAGE and wrongly add the page to the
> > > hugetlb pool list.
> >
> > The hwpoison side of this looks really suspicious to me. It shouldn't
> > really touch the reference count of hugetlb pages without being very
> > careful (and having hugetlb_lock held). What would happen if the
> > reference count was increased after the page has been enqueed into the
> > pool? This can just blow up later.
> 
> If the page has been enqueued into the pool, then the page can be
> allocated to other users. The page reference count will be reset to
> 1 in the dequeue_huge_page_node_exact(). Then memory-failure
> will free the page because of put_page(). This is wrong. Because
> there is another user.

Yes that is one of the scenarios but I suspect there are more lurking
there. That was my point that this should be addressed at the hwpoison
side.

-- 
Michal Hocko
SUSE Labs
