Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B422236236F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245506AbhDPPDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:03:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:48018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245630AbhDPPC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:02:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618585350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WQvS/alwdw9rpYdgYhn+CPNSLFf5cTVqFmlsEiuYtZo=;
        b=r7pWIXuMCGmvkwxIpLwSd6uqxciD7nfKFEd5LPG0h3ph3bfLJDq7twJ+y0dzr74Obxo9N0
        4zmXmLFCc8ChZB88990UxgtTntXlc8qeT6NaWNwX5drBnVmbOhdN/t7XNiq+pyElSBVft1
        RU2mpODkfybQp0vSwdjN5al+sply//A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E916B137;
        Fri, 16 Apr 2021 15:02:30 +0000 (UTC)
Date:   Fri, 16 Apr 2021 17:02:23 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com,
        rientjes@google.com, ying.huang@intel.com,
        dan.j.williams@intel.com, david@redhat.com, osalvador@suse.de,
        weixugc@google.com
Subject: Re: [PATCH 00/10] [v7][RESEND] Migrate Pages in lieu of discard
Message-ID: <YHmm11fxEnxXAxas@dhcp22.suse.cz>
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <YHmEm/yHpaqO6khp@dhcp22.suse.cz>
 <9cd0dcde-f257-1b94-17d0-f2e24a3ce979@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cd0dcde-f257-1b94-17d0-f2e24a3ce979@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-04-21 07:26:43, Dave Hansen wrote:
> On 4/16/21 5:35 AM, Michal Hocko wrote:
> >   I have to confess that I haven't grasped the initialization
> >   completely. There is a nice comment explaining a 2 socket system with
> >   3 different NUMA nodes attached to it with one node being terminal.
> >   This is OK if the terminal node is PMEM but how that fits into usual
> >   NUMA setups. E.g.
> >   4 nodes each with its set of CPUs
> >   node distances:
> >   node   0   1   2   3
> >   0:  10  20  20  20
> >   1:  20  10  20  20
> >   2:  20  20  10  20
> >   3:  20  20  20  10
> >   Do I get it right that Node 3 would be terminal?
> 
> Yes, I think Node 3 would end up being the terminal node in that setup.
> 
> That said, I'm not sure how much I expect folks to use this on
> traditional, non-tiered setups.  It's also hard to argue what the
> migration order *should* be when all the nodes are uniform.

Well, they are not really uniform. The access latency differ and I can
imagine that spreading page cache to a distant node might be just much
better than an IO involved in the refault.

On the other hand I do understand that restricting the feature to CPU
less NUMA setups is quite sane to give us a better understanding of how
this can be used and improve on top. Maybe we will learn that we want to
have the demotion path admin controlable (on the system level or maybe
even more fine grained on the memcg/cpuset).

[...]
> > - The demotion is implemented at shrink_page_list level which migrates
> >   pages in the first round and then falls back to the regular reclaim
> >   when migration fails. This means that the reclaim context
> >   (PF_MEMALLOC) will allocate memory so it has access to full memory
> >   reserves. Btw. I do not __GFP_NO_MEMALLOC anywhere in the allocation
> >   mask which looks like a bug rather than an intention. Btw. using
> >   GFP_NOWAIT in the allocation callback would make more things clear
> >   IMO.
> 
> Yes, the lack of __GFP_NO_MEMALLOC is a bug.  I'll fix that up.
> 
> GFP_NOWAIT _seems_ like it will work.  I'll give it a shot.

Let me clarify a bit. The slow path does involve __gfp_pfmemalloc_flags
before bailing out for non sleeping allocation. So you would need both.
Unless you want to involve reclaim on the target node while you are
reclaiming the origin node.

> > - Memcg reclaim is excluded from all this because it is not NUMA aware
> >   which makes sense to me.
> > - Anonymous pages are bit tricky because they can be demoted even when
> >   they cannot be reclaimed due to no (or no available) swap storage.
> >   Unless I have missed something the second round will try to reclaim
> >   them even the later is true and I am not sure this is completely OK.
> 
> What we want is something like this:
> 
> Swap Space / Demotion OK  -> Can Reclaim
> Swap Space / Demotion Off -> Can Reclaim
> Swap Full  / Demotion OK  -> Can Reclaim
> Swap Full  / Demotion Off -> No Reclaim
> 
> I *think* that's what can_reclaim_anon_pages() ends up doing.  Maybe I'm
> misunderstanding what you are referring to, though.  By "second round"
> did you mean when we do reclaim on a node which is a terminal node?

No, I mean the migration failure case where you splice back to the page
list to reclaim. In that round you do not demote and want to reclaim.
But a lack of swap space will make that page unreclaimable. I suspect
this would just work out fine but I am not sure from the top of my head.

> > I am still trying to digest the whole thing but at least jamming
> > node_reclaim logic into kswapd seems strange to me. Need to think more
> > about that though.
> 
> I'm entirely open to other ways to do the opt-in.  It seemed sane at the
> time, but I also understand the kswapd concern.
> 
> > Btw. do you have any numbers from running this with some real work
> > workload?
> 
> Yes, quite a bit.  Do you have a specific scenario in mind?  Folks seem
> to come at this in two different ways:
> 
> Some want to know how much DRAM they can replace by buying some PMEM.
> They tend to care about how much adding the (cheaper) PMEM slows them
> down versus (expensive) DRAM.  They're making a cost-benefit call
> 
> Others want to repurpose some PMEM they already have.  They want to know
> how much using PMEM in this way will speed them up.  They will basically
> take any speedup they can get.
> 
> I ask because as a kernel developer with PMEM in my systems, I find the
> "I'll take what I can get" case more personally appealing.  But, the
> business folks are much more keen on the "DRAM replacement" use.  Do you
> have any thoughts on what you would like to see?

I was thinking about typical large in memory processing (e.g. in memory
databases) where the hot part of the working set is only a portion and
spilling over to a slower memory can be still benefitial because IO +
data preprocessing on cold data is much slower.
-- 
Michal Hocko
SUSE Labs
