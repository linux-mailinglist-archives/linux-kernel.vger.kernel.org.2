Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6667C3FEED6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345326AbhIBNkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:40:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:44394 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345306AbhIBNk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:40:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="206335089"
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; 
   d="scan'208";a="206335089"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 06:39:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; 
   d="scan'208";a="542702720"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga002.fm.intel.com with ESMTP; 02 Sep 2021 06:39:24 -0700
Date:   Thu, 2 Sep 2021 21:39:24 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Koutn?? <mkoutny@suse.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
Message-ID: <20210902133924.GA72811@shbuild999.sh.intel.com>
References: <20210818023004.GA17956@shbuild999.sh.intel.com>
 <YSzwWIeapkzNElwV@blackbook>
 <20210831063036.GA46357@shbuild999.sh.intel.com>
 <20210831092304.GA17119@blackbody.suse.cz>
 <20210901045032.GA21937@shbuild999.sh.intel.com>
 <877dg0wcrr.fsf@linux.intel.com>
 <20210902013558.GA97410@shbuild999.sh.intel.com>
 <e8d087a4-a286-3561-66ef-1e9cfb38605f@linux.intel.com>
 <20210902034628.GA76472@shbuild999.sh.intel.com>
 <20210902105306.GC17119@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902105306.GC17119@blackbody.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 12:53:06PM +0200, Michal Koutn?? wrote:
> Hi.
> 
> On Thu, Sep 02, 2021 at 11:46:28AM +0800, Feng Tang <feng.tang@intel.com> wrote:
> > > Narrowing it down to a single prefetcher seems good enough to me. The
> > > behavior of the prefetchers is fairly complicated and hard to predict, so I
> > > doubt you'll ever get a 100% step by step explanation.
>  
> My layman explanation with the available information is that the
> prefetcher somehow behaves as if it marked the offending cacheline as
> modified (even though reading only) therefore slowing down the remote reader.

But this can't explain the test that adding 128 bytes before css->cgroup
can restore/improve the performance.
 
> On Thu, Sep 02, 2021 at 09:35:58AM +0800, Feng Tang <feng.tang@intel.com> wrote:
> > @@ -139,10 +139,21 @@ struct cgroup_subsys_state {
> >       /* PI: the cgroup that this css is attached to */
> >       struct cgroup *cgroup;
> >
> > +     struct cgroup_subsys_state *parent;
> > +
> >       /* PI: the cgroup subsystem that this css is attached to */
> >       struct cgroup_subsys *ss;
> 
> Hm, an interesting move; be mindful of commit b8b1a2e5eca6 ("cgroup:
> move cgroup_subsys_state parent field for cache locality"). It might be
> a regression for systems with cpuacct root css present. (That is likely
> a big amount nowadays, that may be the reason why you don't see full
> recovery?  For future, we may at least guard cpuacct_charge() with
> cgroup_subsys_enabled() static branch.)

Goot catch! 

Acutally I also tested only moving 'destroy_work' and 'destroy_rwork'
('parent' is not touched with the cost of 8 bytes more padding), which
has simliar effect that restore to about 15% regression. 

> > [snip]
> > Yes, I'm afriad so, given that the policy/algorithm used by perfetcher
> > keeps changing from generation to generation.
> 
> Exactly. I'm afraid of relayouting the structure with each new
> generation. A robust solution is putting all frequently accessed members
> into individual cache-lines + separating them with one more cache line? :-/

Yes, this is hard. Even for my debug patch, we can only say it works
as restoring the regression partly, but not knowing the exact reason.

Thansk,
Feng

> 
> Michal
