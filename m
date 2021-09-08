Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44416403263
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 03:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347024AbhIHBv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 21:51:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:20679 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346957AbhIHBvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 21:51:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="200564013"
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="200564013"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 18:50:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="538273350"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Sep 2021 18:50:14 -0700
Date:   Wed, 8 Sep 2021 09:50:14 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: detect allocation forbidden by cpuset and
 bail out early
Message-ID: <20210908015014.GA28091@shbuild999.sh.intel.com>
References: <1631003150-96935-1-git-send-email-feng.tang@intel.com>
 <YTcmcEUmtO++WeBk@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTcmcEUmtO++WeBk@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 10:44:32AM +0200, Michal Hocko wrote:
> On Tue 07-09-21 16:25:50, Feng Tang wrote:
> > There was report that starting an Ubuntu in docker while using cpuset
> > to bind it to movlabe nodes (a node only has movable zone, like a node
> 
> s@movlabe@movable@

will change.

> > for hotplug or a Persistent Memory  node in normal usage) will fail
> > due to memory allocation failure, and then OOM is involved and many
> > other innocent processes got killed. It can be reproduced with command:
> > $docker run -it --rm  --cpuset-mems 4 ubuntu:latest bash -c
> > "grep Mems_allowed /proc/self/status" (node 4 is a movable node)
> > 
> > The reason is, in the case, the target cpuset nodes only have movable
> > zone, while the creation of an OS in docker sometimes needs to allocate
> > memory in non-movable zones (dma/dma32/normal) like GFP_HIGHUSER, and
> > the cpuset limit forbids the allocation, then out-of-memory killing is
> > involved even when normal nodes and movable nodes both have many free
> > memory.
> 
> It would be great to add a oom report here as an example.
 
Ok, will add

> > The failure is reasonable, but still there is one problem, that when
> > the usage fails as it's an mission impossible due to the cpuset limit,
> > the allocation should just not trigger reclaim/compaction, and more
> > importantly, not get any innocent process oom-killed.
> 
> I would reformulate to something like:
> "
> The OOM killer cannot help to resolve the situation as there is no
> usable memory for the request in the cpuset scope. The only reasonable
> measure to take is to fail the allocation right away and have the caller
> to deal with it.
> "

thanks! will use this.

> > So add detection for cases like this in the slowpath of allocation,
> > and bail out early returning NULL for the allocation.
> > 
> > We've run some cases of malloc/mmap/page_fault/lru-shm/swap from
> > will-it-scale and vm-scalability, and didn't see obvious performance
> > change (all inside +/- 1%), test boxes are 2 socket Cascade Lake and
> > Icelake servers.
> > 
> > [thanks to Micho Hocko and David Rientjes for suggesting not handle
> >  it inside OOM code]
> 
> While this is a good fix from the functionality POV I believe you can go
> a step further. Please add a detection to the cpuset code and complain
> to the kernel log if somebody tries to configure movable only cpuset.
> Once you have that in place you can easily create a static branch for
> cpuset_insane_setup() and have zero overhead for all reasonable
> configuration. There shouldn't be any reason to pay a single cpu cycle
> to check for something that almost nobody does.
> 
> What do you think?

I thought about the implementation, IIUC, the static_branch_enable() is
easy, it could be done when cpuset.mems is set with movable only nodes,
but disable() is much complexer, as we may need a global reference
counter to track the set/unset, and the unset could be the time when
freeing the cpuset data structure, also one cpuset.mems could be changed
runtime, and system could have multiple cpuset dirs (user space usage
could be creative or crazy :)).

While checking cpuset code, I thought more about configuring cpuset with
movable only nodes, that we may still have normal usage: mallocing a big
trunk of memory and do some scientific calculation, or AI training. It
works with current code.

The usage of using docker to start an full OS is a much complexer case,
some of its memory allocations like GFP_HIGHUSER from pipe_write() or 
copy_process() are limited by the cpuset limit.

Thanks,
Feng

> -- 
> Michal Hocko
> SUSE Labs
