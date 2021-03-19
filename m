Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A978341371
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 04:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhCSDWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 23:22:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:32262 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhCSDVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 23:21:50 -0400
IronPort-SDR: ktWSNMYYODbyLuNA6PxjSUu38r+oXV1x5kQqIaOU3tObY5Krr0ihQCgI6Kgdo++XPvL1+B2sOM
 walwpaAqLJJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="274882206"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="274882206"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 20:21:49 -0700
IronPort-SDR: /LD887jK2NemYfIsDdE0D3B+/DqG89sNMOWxM7KkJ1xtzmNVs/jmVnTPvpe8IoMl8k2Q3nCxca
 1lJneLH42yNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="606446422"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2021 20:21:45 -0700
Date:   Fri, 19 Mar 2021 11:21:44 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>, zhengjun.xing@intel.com
Subject: Re: [mm] f3344adf38: fxmark.hdd_btrfs_DWAL_63_bufferedio.works/sec
 -52.4% regression
Message-ID: <20210319032144.GA69344@shbuild999.sh.intel.com>
References: <20210315062808.GA837@xsang-OptiPlex-9020>
 <CAHk-=wi1KcOZo4JeRDgJCU0gB5v16q6GJsFtF365MSfM8hH3zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi1KcOZo4JeRDgJCU0gB5v16q6GJsFtF365MSfM8hH3zA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Mar 15, 2021 at 01:42:50PM -0700, Linus Torvalds wrote:
> On Sun, Mar 14, 2021 at 11:30 PM kernel test robot
> <oliver.sang@intel.com> wrote:
> >
> > FYI, we noticed a -52.4% regression of fxmark.hdd_btrfs_DWAL_63_bufferedio.works/sec
> 
> That's quite the huge regression.
> 
> But:
> 
> > due to commit: f3344adf38bd ("mm: memcontrol: optimize per-lruvec stats counter memory usage")
> 
> That's _literally_ just changing a dynamically allocated per-cpu array
> of "long[]" to an array of "s32[]" and in the process shrinking it
> from 304 bytes to 152 bytes.
> 
> > in testcase: fxmark
> > on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
> 
> I think this must be some really random memory layout issue that
> causes some false sharing or similar.
> 
> And it's not even that some fundamental data structure gets a
> different layout, it literally is just either:
> 
>  (a) the (now smaller) array is allocated from a differently chunk,
> and that then causes random cache effects with something else
> 
>  (b) the (old, and bigger) array was more spread out, and as a result
> had different fields in different cachelines and less false sharing
> 
> Normally I'd say that (b) is the obvious case, except for the fact
> that this is a __percpu array.
> 
> So in the common case there shouldn't be any cache contention _within_
> the array itself. Any cache contention should be with something else
> very hot that the change now randomly makes be in the same cache way
> or whatever.
> 
> Afaik, only the flushing of the vmstats batches does access the percpu
> arrays from other CPUs, so (b) is not _entirely_ impossible if
> memcg_flush_percpu_vmstats() were to be very very very hot.
> 
> But the profile data doesn't show anything remotely like that.
> 
> In fact, the actual report seems to show things improving, ie things
> like elapsed time going down:
> 
> >       1361            -9.5%       1232        fxmark.time.elapsed_time
> >       1361            -9.5%       1232        fxmark.time.elapsed_time.max
> >      25.67            +9.1%      28.00        fxmark.time.percent_of_cpu_this_job_got
> >     343.68            -2.0%     336.76        fxmark.time.system_time
> >      23.66            +2.5       26.12        mpstat.cpu.all.sys%
> 
> but I don't know what the benchmark actually does, so maybe it just
> repeats things until it hits a certain confidence interval, and thus
> "elapsed time" is immaterial.

I just checked the benchmark, seems it benchmarks the filesystem's
scalability by doing file/inode opertions with different task numbers
(from 1 to nr_cpus).

The benchmark has preparation and cleanup steps before/after every
run, and for the 100 less seconds of 'fxmark.time.elapsed_time' you
found, it is due to the newer kernel spends 100 seconds more in the
cleanup step after run ( a point worth checking) 

> Honestly, normally if I were to get a report about "52% regression"
> for a commit that is supposed to optimize something, I'd just revert
> the commit as a case of "ok, that optimization clearly didn't work".
> 
> But there is absolutely no sign that this commit is actually the
> culprit, or explanation for why that should be, and what could be
> going on.
> 
> So I'm going to treat this as a "bisection failure, possibly due to
> random code or data layout changes". Particularly since this seems to
> be a 4-socket Xeon Phi machine, which I think is likely a very very
> fragile system if there is some odd cache layout issue.

Oliver retested it and made it run 12 times in total, and the data
is consistent. We tried some other test:
* run other sub cases of this 'fxmark' which sees no regression
* change 'btrfs' to 'ext4' of this case, and no regression
* test  on Cascadelake platform, no regression

So the bitsection seems to be stable, though can't be explained yet. 

We checked the System map of the 2 kernels, and didn't find obvious
code/data alignment change, which is expected, as the commit changes
data structure which is usually dynamically allocated. 

Anyway, we will keep checking this and report back when there is
new data.

> If somebody can actually figure out what happened there, that would be
> good, but for now it goes into my "archived as a random outlier"
> folder.

Agreed. We shouldn't take actions before this change is root caused. 

Thanks,
Feng

>                  Linus
