Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AA23FC2CA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhHaGbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 02:31:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:39350 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232885AbhHaGbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:31:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="218420123"
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="218420123"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 23:30:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="530969458"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Aug 2021 23:30:36 -0700
Date:   Tue, 31 Aug 2021 14:30:36 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Koutn?? <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        andi.kleen@intel.com
Cc:     kernel test robot <oliver.sang@intel.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: Re: [mm] 2d146aa3aa: vm-scalability.throughput -36.4% regression
Message-ID: <20210831063036.GA46357@shbuild999.sh.intel.com>
References: <20210811031734.GA5193@xsang-OptiPlex-9020>
 <CAHk-=wiSHHSuSQsCCLOxQA+cbcvjmEeMsTCMWPT1sFVngd9-ig@mail.gmail.com>
 <20210812031910.GA63920@shbuild999.sh.intel.com>
 <20210816032855.GB72770@shbuild999.sh.intel.com>
 <YRrbpRsvdDoom9iG@cmpxchg.org>
 <20210817024500.GC72770@shbuild999.sh.intel.com>
 <20210817164737.GA23342@blackbody.suse.cz>
 <20210818023004.GA17956@shbuild999.sh.intel.com>
 <YSzwWIeapkzNElwV@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YSzwWIeapkzNElwV@blackbook>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Mon, Aug 30, 2021 at 04:51:04PM +0200, Michal Koutn?? wrote:
> Hello Feng.
> 
> On Wed, Aug 18, 2021 at 10:30:04AM +0800, Feng Tang <feng.tang@intel.com> wrote:
> > As Shakeel also mentioned, this 0day's vm-scalability doesn't involve
> > any explicit mem_cgroup configurations.
> 
> If it all happens inside root memcg, there should be no accesses to the
> 0x10 offset since the root memcg is excluded from refcounting. (Unless
> the modified cacheline is a μarch artifact. Actually, for the lack of
> other ideas, I was thinking about similar cause even for non-root memcgs
> since the percpu refcounting is implemented via a segment register.)

Thought I haven't checked the exact memcg that the perf-c2c hot spots
pointed to, I don't think it's the root memcg. From debug, in the test
run, the OS has created about 50 memcgs before vm-scalability test run,
mostly by systemd-servces, and during the test there is no more new
memcg created.

> Is this still relevant? (You refer to it as 0day's vm-scalability
> issue.)
> 
> By some rough estimates there could be ~10 cgroup_subsys_sets per 10 MiB
> of workload, so the 128B padding gives 1e-4 relative overhead (but
> presumably less in most cases). I also think it acceptable (size-wise).
> 
> Out of curiosity, have you measured impact of reshuffling the refcnt
> member into the middle of the cgroup_subsys_state (keeping it distant
> both from .cgroup and .parent)?

Yes, I tried many re-arrangement of the members of cgroup_subsys_state,
and even close members of memcg, but there were no obvious changes.
What can recover the regresion is adding 128 bytes padding in the css,
no matter at the start, end or in the middle.


Some finding is, this could be related with HW cache prefetcher.

From this article 
https://software.intel.com/content/www/us/en/develop/articles/disclosure-of-hw-prefetcher-control-on-some-intel-processors.html

There are four bits controlling different types of prefetcher, on the
testbox (CascadeLake AP platform), they are all enabled by default. 
When we disable the "L2 hardware prefetcher" (bit 0), the permance
for commit 2d146aa3aa8 is almost the same as its parent commit.

So it seems to be affected about HW cache prefechter's policy, the
test's access pattern changes the HW prefetcher policy, which in
turn affect the performance.

Also the test shows the regression is platform dependent, that regression
could be seen on Cascade Lake AP (36%) and SP (20%), but not on a
Icelake SP 2S platform.

Thanks,
Feng
