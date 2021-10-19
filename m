Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E274331D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhJSJLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:11:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38150 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJSJLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:11:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C42F121976;
        Tue, 19 Oct 2021 09:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634634571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v2mK8OZ+yRM2OEpf1l9qS6p8OCmAj7Hw+mSVREea+Dw=;
        b=JEjc4ZuvnGKdCs8jk9yK7uw23KKRKf7ZoMgjPB0VDUy+O/7rrywj4nWR+VeQoyzag8bKuC
        M7VHsak/qrBeZnIBid92M2zJl2ob1Hk2OOBv1Ie2EI/Tv569m2Gm05I8znHmW9wsv/ZHG6
        iRfDfgG4CCvUOaIJYNkxJXJaRxfaAV8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5D487A3B87;
        Tue, 19 Oct 2021 09:09:31 +0000 (UTC)
Date:   Tue, 19 Oct 2021 11:09:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: skip current when memcg reclaim
Message-ID: <YW6LSVK+NTiZ05+X@dhcp22.suse.cz>
References: <1634278529-16983-1-git-send-email-huangzhaoyang@gmail.com>
 <YW0u67o8wl3CGikP@dhcp22.suse.cz>
 <CAGWkznEO9SyNFEBqL8=JxewVTvaUhwFLPow69mi=R1MJ=XCpow@mail.gmail.com>
 <YW1rcv4bN1WWhzLD@dhcp22.suse.cz>
 <CAGWkznG65_FGx9jU7rjj5biEdyHZ=kcPwmXj6cGxxVmPy2rdKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznG65_FGx9jU7rjj5biEdyHZ=kcPwmXj6cGxxVmPy2rdKQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-10-21 15:11:30, Zhaoyang Huang wrote:
> On Mon, Oct 18, 2021 at 8:41 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 18-10-21 17:25:23, Zhaoyang Huang wrote:
> > > On Mon, Oct 18, 2021 at 4:23 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > > > I would be really curious about more specifics of the used hierarchy.
> > > What I am facing is a typical scenario on Android, that is a big
> > > memory consuming APP(camera etc) launched while background filled by
> > > other processes. The hierarchy is like what you describe above where B
> > > represents the APP and memory.low is set to help warm restart. Both of
> > > kswapd and direct reclaim work together to reclaim pages under this
> > > scenario, which can cause 20MB file page delete from LRU in several
> > > second. This change could help to have current process's page escape
> > > from being reclaimed and cause page thrashing. We observed the result
> > > via systrace which shows that the Uninterruptible sleep(block on page
> > > bit) and iowait get smaller than usual.
> >
> > I still have hard time to understand the exact setup and why the patch
> > helps you. If you want to protect B more than the low limit would allow
> > for by stealiong from C then the same thing can happen from anybody
> > reclaiming from C so in the end there is no protection. The same would
> > apply for any global direct memory reclaim done by a 3rd party. So I
> > suspect that your patch just happens to work by a luck.
> B and C compete fairly and superior than others. The idea based on
> assuming NOT all groups will trap into direct reclaim concurrently, so
> we want to have the groups steal pages from the processes under
> root(Non-memory sensitive) or other groups with lower thresholds(high
> memory tolerance) or the one totally sleeping(not busy for the time
> being, borrow some pages).

I am really confused now. The memcg reclaim cannot really reclaim
anything from outside of the reclaimed hierarchy. Protected memcgs are
only considered if the reclaim was not able to reclaim anything during
the first hierarchy walk. That would imply that the reclaimed hierarchy
has either all memcgs with memory protected or non-protected memcgs do
not have any memory to reclaim.

I think it would really help to provide much details about what is going
on here before we can move forward.

> > Why both B and C have low limit setup and they both cannot be reclaimed?
> > Isn't that a weird setup where A hard limit is too close to sum of low
> > limits of B and C?
> >
> > In other words could you share a more detailed configuration you are
> > using and some more details why both B and C have been skipped during
> > the first pass of the reclaim?
> My practical scenario is that important processes(vip APP etc) are
> placed into protected memcg and keep other processes just under root.
> Current introduces direct reclaim because of alloc_pages(DMA_ALLOC
> etc), in which the number of allocation would be much larger than low
> but would NOT be charged to LRU. Whereas, current also wants to keep
> the pages(.so files to exec) on LRU.

I am sorry but this description makes even less sense to me. If your
important process runs under a protected memcg and everything else is
running under root memcg then your memcg will get protected as long as
there is a reclaimable memory. There should ever be only global memory
reclaim happening, unless you specify a hard/high limit on your
important memcg. If you do so then there is no way to reclaim from
outside of that specific memcg.

I really fail how your patch can help with either of those situations.
-- 
Michal Hocko
SUSE Labs
