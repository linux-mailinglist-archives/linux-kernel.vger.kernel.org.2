Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E387D4336F4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhJSN0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:26:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41182 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhJSN0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:26:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CDAE821A96;
        Tue, 19 Oct 2021 13:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634649840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pdUivR0fYcx0B5nCIdR+D+h3cayigAN77OaimmIC0Cs=;
        b=MXjv1Yn9KIuBvS2eUPQthhmu0YaLENf+V3gGaat9pSLmwvuO7o65gTsdqLB0V/NhLWpWOO
        MPmJundThvu/VyPXbqNk4WnAzSN48v7nDzkrHRHFHlFuiJPQMYZrdWsVVsypQDu/UvJ1FW
        NxivLhbKxaSULsjpn/g2AEkrg6UeL5k=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 48E67A3B83;
        Tue, 19 Oct 2021 13:24:00 +0000 (UTC)
Date:   Tue, 19 Oct 2021 15:23:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: skip current when memcg reclaim
Message-ID: <YW7G7znfHxd52b/T@dhcp22.suse.cz>
References: <1634278529-16983-1-git-send-email-huangzhaoyang@gmail.com>
 <YW0u67o8wl3CGikP@dhcp22.suse.cz>
 <CAGWkznEO9SyNFEBqL8=JxewVTvaUhwFLPow69mi=R1MJ=XCpow@mail.gmail.com>
 <YW1rcv4bN1WWhzLD@dhcp22.suse.cz>
 <CAGWkznG65_FGx9jU7rjj5biEdyHZ=kcPwmXj6cGxxVmPy2rdKQ@mail.gmail.com>
 <YW6LSVK+NTiZ05+X@dhcp22.suse.cz>
 <CAGWkznHSPAu572BjoE510Sm+G9vGetKg-v2TkjwtcmZGo8MPVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznHSPAu572BjoE510Sm+G9vGetKg-v2TkjwtcmZGo8MPVw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-10-21 20:17:16, Zhaoyang Huang wrote:
> On Tue, Oct 19, 2021 at 5:09 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 19-10-21 15:11:30, Zhaoyang Huang wrote:
> > > On Mon, Oct 18, 2021 at 8:41 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Mon 18-10-21 17:25:23, Zhaoyang Huang wrote:
> > > > > On Mon, Oct 18, 2021 at 4:23 PM Michal Hocko <mhocko@suse.com> wrote:
> > [...]
> > > > > > I would be really curious about more specifics of the used hierarchy.
> > > > > What I am facing is a typical scenario on Android, that is a big
> > > > > memory consuming APP(camera etc) launched while background filled by
> > > > > other processes. The hierarchy is like what you describe above where B
> > > > > represents the APP and memory.low is set to help warm restart. Both of
> > > > > kswapd and direct reclaim work together to reclaim pages under this
> > > > > scenario, which can cause 20MB file page delete from LRU in several
> > > > > second. This change could help to have current process's page escape
> > > > > from being reclaimed and cause page thrashing. We observed the result
> > > > > via systrace which shows that the Uninterruptible sleep(block on page
> > > > > bit) and iowait get smaller than usual.
> > > >
> > > > I still have hard time to understand the exact setup and why the patch
> > > > helps you. If you want to protect B more than the low limit would allow
> > > > for by stealiong from C then the same thing can happen from anybody
> > > > reclaiming from C so in the end there is no protection. The same would
> > > > apply for any global direct memory reclaim done by a 3rd party. So I
> > > > suspect that your patch just happens to work by a luck.
> > > B and C compete fairly and superior than others. The idea based on
> > > assuming NOT all groups will trap into direct reclaim concurrently, so
> > > we want to have the groups steal pages from the processes under
> > > root(Non-memory sensitive) or other groups with lower thresholds(high
> > > memory tolerance) or the one totally sleeping(not busy for the time
> > > being, borrow some pages).
> >
> > I am really confused now. The memcg reclaim cannot really reclaim
> > anything from outside of the reclaimed hierarchy. Protected memcgs are
> > only considered if the reclaim was not able to reclaim anything during
> > the first hierarchy walk. That would imply that the reclaimed hierarchy
> > has either all memcgs with memory protected or non-protected memcgs do
> > not have any memory to reclaim.
> >
> > I think it would really help to provide much details about what is going
> > on here before we can move forward.
> >
> > > > Why both B and C have low limit setup and they both cannot be reclaimed?
> > > > Isn't that a weird setup where A hard limit is too close to sum of low
> > > > limits of B and C?
> > > >
> > > > In other words could you share a more detailed configuration you are
> > > > using and some more details why both B and C have been skipped during
> > > > the first pass of the reclaim?
> > > My practical scenario is that important processes(vip APP etc) are
> > > placed into protected memcg and keep other processes just under root.
> > > Current introduces direct reclaim because of alloc_pages(DMA_ALLOC
> > > etc), in which the number of allocation would be much larger than low
> > > but would NOT be charged to LRU. Whereas, current also wants to keep
> > > the pages(.so files to exec) on LRU.
> >
> > I am sorry but this description makes even less sense to me. If your
> > important process runs under a protected memcg and everything else is
> > running under root memcg then your memcg will get protected as long as
> > there is a reclaimable memory. There should ever be only global memory
> > reclaim happening, unless you specify a hard/high limit on your
> > important memcg. If you do so then there is no way to reclaim from
> > outside of that specific memcg.
> >
> > I really fail how your patch can help with either of those situations.
> 
> please find cgv2 hierarchy on my sys[1], where uid_2000 is a cgroup
> under root and trace_printk info[3] from trace_printk embedded in
> shrink_node[2]. I don't why you say there should be no reclaim from
> groups under root which opposite to[3]

That is not what I am saying. I am saying the protected (by low limit)
memcgs only get reclaimed if there is no reclaim progress from the
reclaimed hierarchy. In your case that would mean that there is no
reclaim from the root cgroup.

> [1]
> /sys/fs/cgroup # ls uid_2000
> cgroup.controllers  cgroup.max.depth        cgroup.stat
> cgroup.type   io.pressure     memory.events.local  memory.max
> memory.pressure      memory.swap.events
> cgroup.events       cgroup.max.descendants  cgroup.subtree_control
> cpu.pressure  memory.current  memory.high          memory.min
> memory.stat          memory.swap.max
> cgroup.freeze       cgroup.procs            cgroup.threads
> cpu.stat      memory.events   memory.low           memory.oom.group
> memory.swap.current  pid_275

This doesn't really help to make a better picture because it doesn't
tell the configuration. It would help to print all cgroups with memory
controller enabled and print memory.* values.

> [2]
> @@ -2962,6 +2962,7 @@ static bool shrink_node(pg_data_t *pgdat, struct
> scan_control *sc)
> 
>                         reclaimed = sc->nr_reclaimed;
>                         scanned = sc->nr_scanned;
> +                     trace_printk("root %x memcg %x reclaimed
> %ld\n",root_mem_cgroup,memcg,sc->nr_reclaimed);
>                         shrink_node_memcg(pgdat, memcg, sc, &lru_pages);
>                         node_lru_pages += lru_pages;
> 
> [3]
>  allocator@4.0-s-1034    [005] ....   442.077013: shrink_node: root
> ef022800 memcg ef027800 reclaimed 41
>    kworker/u16:3-931     [002] ....   442.077019: shrink_node: root
> ef022800 memcg c7e54000 reclaimed 17
>  allocator@4.0-s-1034    [005] ....   442.077019: shrink_node: root
> ef022800 memcg ef025000 reclaimed 41
>  allocator@4.0-s-1034    [005] ....   442.077024: shrink_node: root
> ef022800 memcg ef023000 reclaimed 41
>    kworker/u16:3-931     [002] ....   442.077026: shrink_node: root
> ef022800 memcg c7e57800 reclaimed 17
>  allocator@4.0-s-1034    [005] ....   442.077028: shrink_node: root
> ef022800 memcg ef026800 reclaimed 41

It is impossible to tell which memcgs those are. It also doesn't tell
anything whether low limit has been broken due to lack of progress.
-- 
Michal Hocko
SUSE Labs
