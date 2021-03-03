Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7940632BEAA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574682AbhCCReC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:34:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:53110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243858AbhCCODf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:03:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614780168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xlwkb0P4zfdTZjpS7NnMK7XBu4IbpFu9H1wZ+MKhYAs=;
        b=fjLn15Wq5YFyUxD1plKgETCpgFt7Kqr4xEr7onlWMkd6yESW8qv7rqVqDotJUFa+5G7IzU
        pr3xdqf1Cqb5DQBHEFa5bD8MdqiEziXlkASBtbsAkboGlqMMSzsTda1+dz/gFuih5ZB95F
        VCErgwAUmpkkLj6hFqUPb6iwFTCacH0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2AE4AE1F;
        Wed,  3 Mar 2021 14:02:47 +0000 (UTC)
Date:   Wed, 3 Mar 2021 15:02:47 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [External] Re: [PATCH v2] mm: memcontrol: fix kernel stack
 account
Message-ID: <YD+XB6LVUhwL6qm+@dhcp22.suse.cz>
References: <20210303093956.72318-1-songmuchun@bytedance.com>
 <YD9kCLlckn9evWuw@dhcp22.suse.cz>
 <CAMZfGtVdU9KWD8U_0CbctMpYo5SbzJEW2pSa1Qdr9tFcwaWcoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVdU9KWD8U_0CbctMpYo5SbzJEW2pSa1Qdr9tFcwaWcoQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-03-21 21:27:24, Muchun Song wrote:
> On Wed, Mar 3, 2021 at 6:25 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 03-03-21 17:39:56, Muchun Song wrote:
> > > For simplification 991e7673859e ("mm: memcontrol: account kernel stack
> > > per node") has changed the per zone vmalloc backed stack pages
> > > accounting to per node. By doing that we have lost a certain precision
> > > because those pages might live in different NUMA nodes. In the end
> > > NR_KERNEL_STACK_KB exported to the userspace might be over estimated on
> > > some nodes while underestimated on others.
> > >
> > > This doesn't impose any real problem to correctnes of the kernel
> > > behavior as the counter is not used for any internal processing but it
> > > can cause some confusion to the userspace.
> >
> > You have skipped over one part of the changelog I have proposed and that
> > is to provide an actual data.
> 
> Because this is a problem I found by looking at the code, not a real world
> problem. I do not have any actual data. :-(

As I've mentioned several times already, this is all fine but it should
be made explicit in the changelog. There might be people spending their
time to evaluate this code to find out whether this is something that
somebody depend on.

[...]
> > > -     /* All stack pages are in the same node. */
> > > -     if (vm)
> > > -             mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_KB,
> > > -                                   account * (THREAD_SIZE / 1024));
> > > -     else
> > > +             BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
> >
> > I do not think we need this BUG_ON. What kind of purpose does it serve?
> 
> vm->nr_pages should be always equal to THREAD_SIZE / PAGE_SIZE
> if the system is not corrupted.

BUG_ON is not an annotation for "this shouldn't happen". Even if the
system was corrupted and nr_pages wouldn't match then this is not a
reason to crash the kernel right away.

In general there should be a very _strong_ reason to add a BUG_ON.

-- 
Michal Hocko
SUSE Labs
