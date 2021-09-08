Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ADB4035EB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348025AbhIHIOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:14:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:37967 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234696AbhIHIOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:14:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="217253681"
X-IronPort-AV: E=Sophos;i="5.85,277,1624345200"; 
   d="scan'208";a="217253681"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 01:12:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,277,1624345200"; 
   d="scan'208";a="695421634"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Sep 2021 01:12:53 -0700
Date:   Wed, 8 Sep 2021 16:12:53 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: detect allocation forbidden by cpuset and
 bail out early
Message-ID: <20210908081253.GA37918@shbuild999.sh.intel.com>
References: <1631003150-96935-1-git-send-email-feng.tang@intel.com>
 <YTcmcEUmtO++WeBk@dhcp22.suse.cz>
 <20210908015014.GA28091@shbuild999.sh.intel.com>
 <YThg8Mp42b194k0/@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YThg8Mp42b194k0/@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 09:06:24AM +0200, Michal Hocko wrote:
> On Wed 08-09-21 09:50:14, Feng Tang wrote:
> > On Tue, Sep 07, 2021 at 10:44:32AM +0200, Michal Hocko wrote:
> [...]
> > > While this is a good fix from the functionality POV I believe you can go
> > > a step further. Please add a detection to the cpuset code and complain
> > > to the kernel log if somebody tries to configure movable only cpuset.
> > > Once you have that in place you can easily create a static branch for
> > > cpuset_insane_setup() and have zero overhead for all reasonable
> > > configuration. There shouldn't be any reason to pay a single cpu cycle
> > > to check for something that almost nobody does.
> > > 
> > > What do you think?
> > 
> > I thought about the implementation, IIUC, the static_branch_enable() is
> > easy, it could be done when cpuset.mems is set with movable only nodes,
> > but disable() is much complexer,
> 
> Do we care about disable at all? The point is to not have 99,999999%
> users pay overhead of the check which is irrelevant to them. Once
> somebody wants to use this "creative" setup then paying an extra check
> sounds perfectly sensible to me. If somebody cares enough then the
> disable logic could be implemented. But for now I believe we should be
> OK with only enable case.
 
Makes sense to me, thanks!

> > as we may need a global reference
> > counter to track the set/unset, and the unset could be the time when
> > freeing the cpuset data structure, also one cpuset.mems could be changed
> > runtime, and system could have multiple cpuset dirs (user space usage
> > could be creative or crazy :)).
> > 
> > While checking cpuset code, I thought more about configuring cpuset with
> > movable only nodes, that we may still have normal usage: mallocing a big
> > trunk of memory and do some scientific calculation, or AI training. It
> > works with current code.
> 
> It might work but it would be inherently subtle because a single
> non-movable allocation will throw the whole thing off the cliff.

Yes, this is a valid concern. 

Though I think when there is really usage reuqirement for cpuset
binding to HBM (High Bandwidth Memory) or PMEM, we may need to
reconsider to loose the limit for GFP_HIGHUSER, as the GFP_KERNEL
type of allocation is permitted.

Thanks,
Feng

> I do not think we want to even pretend we support such a setup.
> -- 
> Michal Hocko
> SUSE Labs
