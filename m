Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B203A3B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 07:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhFKFwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 01:52:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:37182 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230405AbhFKFwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 01:52:30 -0400
IronPort-SDR: nZGD9OhYjGyznpayMOsoiOiaqQBJFzPOvPgk0Wp+qbiiBG8AeiGcxDSQ0x7XgczAioTjULuWtr
 5An1cPeeUFGQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="192577266"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="192577266"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 22:50:31 -0700
IronPort-SDR: AwryA5z3xRJjkDVsodEGhrz0LRkUk02G3e9hS3WkCemBbsUlI0Wq+qYA4kCn2uaofxokmfBggW
 v9WMG7Lv4O6w==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="483143397"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 22:50:28 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com,
        rientjes@google.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de, weixugc@google.com
Subject: Re: [PATCH 00/10] [v7][RESEND] Migrate Pages in lieu of discard
References: <20210401183216.443C4443@viggo.jf.intel.com>
        <YHmEm/yHpaqO6khp@dhcp22.suse.cz>
        <9cd0dcde-f257-1b94-17d0-f2e24a3ce979@intel.com>
        <YHmm11fxEnxXAxas@dhcp22.suse.cz>
Date:   Fri, 11 Jun 2021 13:50:26 +0800
In-Reply-To: <YHmm11fxEnxXAxas@dhcp22.suse.cz> (Michal Hocko's message of
        "Fri, 16 Apr 2021 17:02:23 +0200")
Message-ID: <87k0n1ymot.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michal,

Sorry for late reply.

Michal Hocko <mhocko@suse.com> writes:

> On Fri 16-04-21 07:26:43, Dave Hansen wrote:
>> On 4/16/21 5:35 AM, Michal Hocko wrote:
>> >   I have to confess that I haven't grasped the initialization
>> >   completely. There is a nice comment explaining a 2 socket system with
>> >   3 different NUMA nodes attached to it with one node being terminal.
>> >   This is OK if the terminal node is PMEM but how that fits into usual
>> >   NUMA setups. E.g.
>> >   4 nodes each with its set of CPUs
>> >   node distances:
>> >   node   0   1   2   3
>> >   0:  10  20  20  20
>> >   1:  20  10  20  20
>> >   2:  20  20  10  20
>> >   3:  20  20  20  10
>> >   Do I get it right that Node 3 would be terminal?
>> 
>> Yes, I think Node 3 would end up being the terminal node in that setup.
>> 
>> That said, I'm not sure how much I expect folks to use this on
>> traditional, non-tiered setups.  It's also hard to argue what the
>> migration order *should* be when all the nodes are uniform.
>
> Well, they are not really uniform. The access latency differ and I can
> imagine that spreading page cache to a distant node might be just much
> better than an IO involved in the refault.

Sorry, I am confused.  In the above system,

  "4 nodes each with its set of CPUs"

so I think the demotion target (next_demotion_node[nid]) of the nodes
0-3 are all NUMA_NO_NODE, because there's no CPU-less NUMA node.  That
is, the patchset will not change the page reclaiming behavior in the
above system.  Did I misunderstand your words?

> On the other hand I do understand that restricting the feature to CPU
> less NUMA setups is quite sane to give us a better understanding of how
> this can be used and improve on top. Maybe we will learn that we want to
> have the demotion path admin controlable (on the system level or maybe
> even more fine grained on the memcg/cpuset).

Yes.  More features and interface can be built on top of the current
patchset.

> [...]
>> > - The demotion is implemented at shrink_page_list level which migrates
>> >   pages in the first round and then falls back to the regular reclaim
>> >   when migration fails. This means that the reclaim context
>> >   (PF_MEMALLOC) will allocate memory so it has access to full memory
>> >   reserves. Btw. I do not __GFP_NO_MEMALLOC anywhere in the allocation
>> >   mask which looks like a bug rather than an intention. Btw. using
>> >   GFP_NOWAIT in the allocation callback would make more things clear
>> >   IMO.
>> 
>> Yes, the lack of __GFP_NO_MEMALLOC is a bug.  I'll fix that up.
>> 
>> GFP_NOWAIT _seems_ like it will work.  I'll give it a shot.
>
> Let me clarify a bit. The slow path does involve __gfp_pfmemalloc_flags
> before bailing out for non sleeping allocation. So you would need both.
> Unless you want to involve reclaim on the target node while you are
> reclaiming the origin node.

Yes.  __GFP_NO_MEMALLOC should be added to the allocation flag.  And we
do want some kind of page reclaim on the target node.  So the cold DRAM
pages will be demoted to PMEM, and the coldest PMEM pages will be
reclaimed.  But the direct reclaiming on the target node may be not
appropriate.  So how about change the page allocation flag in
alloc_demote_page() as follows?

        (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_THISNODE  |
                __GFP_NOWARN | __GFP_NO_MEMALLOC | GFP_NOWAIT

>> > - Memcg reclaim is excluded from all this because it is not NUMA aware
>> >   which makes sense to me.
>> > - Anonymous pages are bit tricky because they can be demoted even when
>> >   they cannot be reclaimed due to no (or no available) swap storage.
>> >   Unless I have missed something the second round will try to reclaim
>> >   them even the later is true and I am not sure this is completely OK.
>> 
>> What we want is something like this:
>> 
>> Swap Space / Demotion OK  -> Can Reclaim
>> Swap Space / Demotion Off -> Can Reclaim
>> Swap Full  / Demotion OK  -> Can Reclaim
>> Swap Full  / Demotion Off -> No Reclaim
>> 
>> I *think* that's what can_reclaim_anon_pages() ends up doing.  Maybe I'm
>> misunderstanding what you are referring to, though.  By "second round"
>> did you mean when we do reclaim on a node which is a terminal node?
>
> No, I mean the migration failure case where you splice back to the page
> list to reclaim. In that round you do not demote and want to reclaim.
> But a lack of swap space will make that page unreclaimable. I suspect
> this would just work out fine but I am not sure from the top of my head.
>
>> > I am still trying to digest the whole thing but at least jamming
>> > node_reclaim logic into kswapd seems strange to me. Need to think more
>> > about that though.
>> 
>> I'm entirely open to other ways to do the opt-in.  It seemed sane at the
>> time, but I also understand the kswapd concern.

Yes.  It looks strange to make node_relcaim logic to impact kswapd and
direct reclaim behavior.  So, how about introduce another sysctl or
sysfs interface to control demotion behavior?  For example, add

        /sys/kernel/mm/numa/demotion

to enable/disable demotion between numa nodes for node reclaim, kswapd
reclaim and direct reclaim?

Best Regards,
Huang, Ying

[snip]
