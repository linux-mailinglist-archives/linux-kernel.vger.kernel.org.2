Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E501236F7AB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 11:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhD3JSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 05:18:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:55914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhD3JSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 05:18:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619774238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QmWxztDRuzCooffUpIa9THfvnnbzSBjm27Pz78Rv5MA=;
        b=WcBXrG79w3nn0Vkf6AQjbYkUFqRChCapx2DhVVF8ura/ZNz6ih9UWoFOdvDDer+Ywpf5/J
        Ru9MZOSAFgZDmhDVu2TnfF7q/FRjDWbfGmiARjrjJD+CbeaQl0jXP3hQrt9Ce2uBVHRww4
        QvQWBYnb3n0wILYaxkOYCkaeHheywss=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 66BCCAF52;
        Fri, 30 Apr 2021 09:17:18 +0000 (UTC)
Date:   Fri, 30 Apr 2021 11:17:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>, wfg@mail.ustc.edu.cn,
        Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by
 too_many_isolated()
Message-ID: <YIvLHX74rFrq0n9w@dhcp22.suse.cz>
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com>
 <YIGuvh70JbE1Cx4U@google.com>
 <YIlNKds8klSiOalo@dhcp22.suse.cz>
 <CAOUHufYXzYs__HSgXC2NfYJGHQzZEE6C+AZ78cvNbrZk_VyKxQ@mail.gmail.com>
 <YIqDv+dQL73KAqjm@dhcp22.suse.cz>
 <CAOUHufZEAVKYvLXQJsmYVmPkX1CDrMziq4Kd=GtauMW2G30g=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufZEAVKYvLXQJsmYVmPkX1CDrMziq4Kd=GtauMW2G30g=g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-04-21 02:34:28, Yu Zhao wrote:
> On Thu, Apr 29, 2021 at 4:00 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > Still, I do not think that the above heuristic will work properly.
> > Different reclaimers have a different reclaim target (e.g. lower zones
> > and/or numa node mask) and strength (e.g.  GFP_NOFS vs. GFP_KERNEL). A
> > simple count based throttling would be be prone to different sorts of
> > priority inversions.
> 
> I see where your concern is coming from. Let's look at it from
> multiple angles, and hopefully this will clear things up.
> 
> 1, looking into this approach:
> This approach limits the number of direct reclaimers without any bias.
> It doesn't favor or disfavor anybody. IOW, everyone has an equal
> chance to run, regardless of the reclaim parameters. So where does the
> inversion come from?

Say you have a flood of GFP_KERNEL allocations contending with *MOVABLE
allocations. The former will not be able to reclaim for any non-kernel
zones. Similar effect would be contention of a heavy GFP_NOFS workload
condending with others but not being able to release filesystem
metadata.

> 2, comparing it with the existing code:
> Both try to limit direct reclaims,: one by the number of isolated
> pages and the other by the number of concurrent direct reclaimers.
> Neither numbers are correlated with any parameters you mentioned above
> except the following:
> 
> too_many_isolated()
> {
> ...
>         /*
>          * GFP_NOIO/GFP_NOFS callers are allowed to isolate more pages, so they
>          * won't get blocked by normal direct-reclaimers, forming a circular
>          * deadlock.
>          */
>         if ((sc->gfp_mask & (__GFP_IO | __GFP_FS)) == (__GFP_IO | __GFP_FS))
>                 inactive >>= 3;
> ...
> }
> 
> Let's at the commit that added the above:
> 
> commit 3cf23841b4b7 ("mm/vmscan.c: avoid possible deadlock caused by
> too_many_isolated()"):
> Date:   Tue Dec 18 14:23:31 2012 -0800
> 
>     Neil found that if too_many_isolated() returns true while performing
>     direct reclaim we can end up waiting for other threads to complete their
>     direct reclaim.  If those threads are allowed to enter the FS or IO to
>     free memory, but this thread is not, then it is possible that those
>     threads will be waiting on this thread and so we get a circular deadlock.
> 
>     some task enters direct reclaim with GFP_KERNEL
>       => too_many_isolated() false
>         => vmscan and run into dirty pages
>           => pageout()
>             => take some FS lock
>               => fs/block code does GFP_NOIO allocation
>                 => enter direct reclaim again
>                   => too_many_isolated() true
>                     => waiting for others to progress, however the other
>                        tasks may be circular waiting for the FS lock..
> 
> Hmm, how could reclaim be recursive nowadays?

I do not think it is. And I doubt it was back then and I also think the
above is not suggesting a recursion really. I tries to avoid a situation
when fs/block layer cannot make a fwd progress because it is being
blocked.
 
> __alloc_pages_slowpath()
> {
> ...
> 
>         /* Avoid recursion of direct reclaim */
>         if (current->flags & PF_MEMALLOC)
>                 goto nopage;
> 
>         /* Try direct reclaim and then allocating */
>         page = __alloc_pages_direct_reclaim()
> ...
> }
> 
> Let's assume it still could, do you remember the following commit?
> 
> commit db73ee0d4637 ("mm, vmscan: do not loop on too_many_isolated for ever")
> Date:   Wed Sep 6 16:21:11 2017 -0700
> 
> If too_many_isolated() does loop forever anymore, how could the above
> deadlock happen? IOW, why would we need the first commit nowadays?

Whether the Neil's commit is still needed would require a deeper
analysis. Even back then we didn't perform pageout for fs dirty pages
from the direct reclaim IIRC.

> If you don't remember the second commit, let me jog your memory:

Yes i do remember that one and that was handling a dependency between
kswapd (which is allowed to perform pageout on diryt fs data) which
is blocked and it prevents direct reclaimers to make a fwd progress e.g.
by declaring OOM. This was mostly a band aid rather than a systematic
solution. And it clearly shows limits of the existing approach. Please
note that I am not trying to defend what we have now. I am just pointing
out that strict count based approach will hit other problems.

> Author: Michal Hocko <mhocko@suse.com>
> 
> 3, thinking abstractly
> A problem hard to solve in one domain can become a walk in the park in
> another domain. This problem is a perfect example: it's different to
> solve based on the number of isolated pages; but it becomes a lot
> easier based on the number of direct reclaimers.

This would be really true if all those reclaimers where equal in their
capabilities. But they are not due to reclaim constrains if nothing
else.

IMHO the best way forward would be removing the throttling from the
reclaim path altogether. The reclaim should be only throttled by the
work it does. Both allocator and memcg charging path implement some sort
of retry logic and I believe this would be much better suited to
implement any backoff.
-- 
Michal Hocko
SUSE Labs
