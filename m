Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38E13FD293
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 06:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241883AbhIAEvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 00:51:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:60750 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229731AbhIAEve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 00:51:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="198859348"
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="198859348"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 21:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="498543345"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga008.fm.intel.com with ESMTP; 31 Aug 2021 21:50:33 -0700
Date:   Wed, 1 Sep 2021 12:50:32 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Koutn?? <mkoutny@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        andi.kleen@intel.com, kernel test robot <oliver.sang@intel.com>,
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
Message-ID: <20210901045032.GA21937@shbuild999.sh.intel.com>
References: <CAHk-=wiSHHSuSQsCCLOxQA+cbcvjmEeMsTCMWPT1sFVngd9-ig@mail.gmail.com>
 <20210812031910.GA63920@shbuild999.sh.intel.com>
 <20210816032855.GB72770@shbuild999.sh.intel.com>
 <YRrbpRsvdDoom9iG@cmpxchg.org>
 <20210817024500.GC72770@shbuild999.sh.intel.com>
 <20210817164737.GA23342@blackbody.suse.cz>
 <20210818023004.GA17956@shbuild999.sh.intel.com>
 <YSzwWIeapkzNElwV@blackbook>
 <20210831063036.GA46357@shbuild999.sh.intel.com>
 <20210831092304.GA17119@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831092304.GA17119@blackbody.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 11:23:04AM +0200, Michal Koutn?? wrote:
> On Tue, Aug 31, 2021 at 02:30:36PM +0800, Feng Tang <feng.tang@intel.com> wrote:
> > Yes, I tried many re-arrangement of the members of cgroup_subsys_state,
> > and even close members of memcg, but there were no obvious changes.
> > What can recover the regresion is adding 128 bytes padding in the css,
> > no matter at the start, end or in the middle.
> 
> Do you mean the padding added outside the .cgroup--.refcnt members area
> also restores the benchmark results? (Or you refer to paddings that move
> .cgroup and .refcnt across a cacheline border ?) I'm asking to be sure
> we have correct understanding of what members are contended (what's the
> frequent writer).

Yes, the tests I did is no matter where the 128B padding is added, the
performance can be restored and even improved.

struct cgroup_subsys_state {
				   <----------------- padding
	struct cgroup *cgroup;
	struct cgroup_subsys *ss;
				   <----------------- padding
	struct percpu_ref refcnt;
	struct list_head sibling;
	struct list_head children;
	struct list_head rstat_css_node;
	int id;
	unsigned int flags;
	u64 serial_nr;
	atomic_t online_cnt;
	struct work_struct destroy_work;
	struct rcu_work destroy_rwork;
	struct cgroup_subsys_state *parent;
				   <----------------- padding
};

Other tries I did are moving the untouched members around,
to separate the serveral hottest members, but no much effect.

From the data from perf-tool, 3 members are frequently accessed
(read actually): 'cgroup', 'refcnt', 'flags'

I also used 'perf mem' command tryint to catch read/write to
the css, and haven't found any _write_ operation, nor can the
code reading.

That led me to go check the "HW cache prefetcher", as in my
laste email. And all these test results make me think it's
data access pattern caused HW prefetcher related performance
change.

Thanks,
Feng


> Thanks,
> Michal
