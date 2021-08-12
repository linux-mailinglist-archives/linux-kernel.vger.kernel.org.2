Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2874F3E9CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 05:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhHLDTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 23:19:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:62260 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhHLDTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 23:19:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="276305589"
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="scan'208";a="276305589"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 20:19:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="scan'208";a="676614165"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Aug 2021 20:19:10 -0700
Date:   Thu, 12 Aug 2021 11:19:10 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Koutn?? <mkoutny@suse.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: Re: [mm] 2d146aa3aa: vm-scalability.throughput -36.4% regression
Message-ID: <20210812031910.GA63920@shbuild999.sh.intel.com>
References: <20210811031734.GA5193@xsang-OptiPlex-9020>
 <CAHk-=wiSHHSuSQsCCLOxQA+cbcvjmEeMsTCMWPT1sFVngd9-ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiSHHSuSQsCCLOxQA+cbcvjmEeMsTCMWPT1sFVngd9-ig@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 07:59:53PM -1000, Linus Torvalds wrote:
> On Tue, Aug 10, 2021 at 4:59 PM kernel test robot <oliver.sang@intel.com> wrote:
> >
> > FYI, we noticed a -36.4% regression of vm-scalability.throughput due to commit:
> > 2d146aa3aa84 ("mm: memcontrol: switch to rstat")
> 
> Hmm. I guess some cost is to be expected, but that's a big regression.
> 
> I'm not sure what the code ends up doing, and how relevant this test
> is, but Johannes - could you please take a look?
> 
> I can't make heads nor tails of the profile. The profile kind of points at this:
> 
> >       2.77 ą 12%     +27.4       30.19 ą  8%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
> >       2.86 ą 12%     +27.4       30.29 ą  8%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
> >       2.77 ą 12%     +27.4       30.21 ą  8%  perf-profile.children.cycles-pp.lock_page_lruvec_irqsave
> >       4.26 ą 10%     +28.1       32.32 ą  7%  perf-profile.children.cycles-pp.lru_cache_add
> >       4.15 ą 10%     +28.2       32.33 ą  7%  perf-profile.children.cycles-pp.__pagevec_lru_add
> 
> and that seems to be from the chain __do_fault -> shmem_fault ->
> shmem_getpage_gfp -> lru_cache_add -> __pagevec_lru_add ->
> lock_page_lruvec_irqsave -> _raw_spin_lock_irqsave ->
> native_queued_spin_lock_slowpath.
> 
> That shmem_fault codepath being hot may make sense for sokme VM
> scalability test. But it seems to make little sense when I look at the
> commit that it bisected to.
> 
> We had another report of this commit causing a much more reasonable
> small slowdown (-2.8%) back in May.
> 
> I'm not sure what's up with this new report. Johannes, does this make
> sense to you?
> 
> Is it perhaps another "unlucky cache line placement" thing? Or has the
> statistics changes just changed the behavior of the test?

Yes, this is probably related with cache line.

We just used perf-c2c tool profile the data for 2d146aa3aa and its
parent commit. There is very few false sharing for the parent commit,
while there is some for 2d146aa3aa, one hottest spot is:

#
#        ----- HITM -----  -- Store Refs --  --------- Data address ---------                      ---------- cycles ----------    Total       cpu                                             Shared                             
#   Num  RmtHitm  LclHitm   L1 Hit  L1 Miss              Offset  Node  PA cnt        Code address  rmt hitm  lcl hitm      load  records       cnt                          Symbol             Object            Source:Line  Node
# .....  .......  .......  .......  .......  ..................  ....  ......  ..................  ........  ........  ........  .......  ........  ..............................  .................  .....................  ....
#
  -------------------------------------------------------------
      0        0     2036        0        0  0xffff8881c0642000
  -------------------------------------------------------------
           0.00%   45.58%    0.00%    0.00%                 0x0     0       1  0xffffffff8137071c         0      2877      3221     8969       191  [k] __mod_memcg_state           [kernel.kallsyms]  memcontrol.c:772        0  1  2  3
           0.00%   20.92%    0.00%    0.00%                 0x0     0       1  0xffffffff8137091c         0      3027      2841     6626       188  [k] __count_memcg_events        [kernel.kallsyms]  memcontrol.c:920        0  1  2  3
           0.00%   17.88%    0.00%    0.00%                0x10     0       1  0xffffffff8136d7ad         0      3047      3326     3820       187  [k] get_mem_cgroup_from_mm      [kernel.kallsyms]  percpu-refcount.h:174   0  1  2  3
           0.00%    8.94%    0.00%    0.00%                0x10     0       1  0xffffffff81375374         0      3192      3041     2067       187  [k] mem_cgroup_charge           [kernel.kallsyms]  percpu-refcount.h:174   0  1  2  3
 
And seems there is some cache false sharing when accessing mem_cgroup
member: 'struct cgroup_subsys_state', from the offset (0x0 and 0x10 here)
and the calling sites, the cache false sharing could happen between:

    cgroup_rstat_updated (read memcg->css.cgroup, offset 0x0)
and 
    get_mem_cgroup_from_mm
	css_tryget(&memcg->css) (read/write memcg->css.refcnt, offset 0x10)

(This could be wrong as many of the functions are inlined, and the
exact calling site isn't shown)

And to verify this, we did a test by adding padding between
memcg->css.cgroup and memcg->css.refcnt to push them into 2
different cache lines, and the performance are partly restored:

dc26532aed0ab25c 2d146aa3aa842d7f5065802556b 73371bf27a8a8ea68df2fbf456b 
---------------- --------------------------- --------------------------- 
  65523232 ±  4%     -40.8%   38817332 ±  5%     -19.6%   52701654 ±  3%  vm-scalability.throughput
 
 0.58 ±  2%      +3.1        3.63            +2.3        2.86 ±  4%  pp.bt.__count_memcg_events.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.15            +3.1        4.20            +2.5        3.68 ±  4%  pp.bt.page_add_file_rmap.do_set_pte.finish_fault.do_fault.__handle_mm_fault
      0.53 ±  2%      +3.1        3.62            +2.5        2.99 ±  2%  pp.bt.__mod_memcg_lruvec_state.page_add_file_rmap.do_set_pte.finish_fault.do_fault
      1.16            +3.3        4.50            +3.2        4.38 ±  3%  pp.bt.__mod_memcg_lruvec_state.shmem_add_to_page_cache.shmem_getpage_gfp.shmem_fault.__do_fault
      0.80            +3.5        4.29            +3.2        3.99 ±  3%  pp.bt.__mod_memcg_state.__mod_memcg_lruvec_state.shmem_add_to_page_cache.shmem_getpage_gfp.shmem_fault
      0.00            +3.5        3.50            +2.8        2.78 ±  2%  pp.bt.__mod_memcg_state.__mod_memcg_lruvec_state.page_add_file_rmap.do_set_pte.finish_fault
     52.02 ±  3%     +13.3       65.29 ±  2%      +4.3       56.34 ±  6%  pp.bt.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     51.98 ±  3%     +13.3       65.27 ±  2%      +4.3       56.31 ±  6%  pp.bt.shmem_fault.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault
     51.87 ±  3%     +13.3       65.21 ±  2%      +4.3       56.22 ±  6%  pp.bt.shmem_getpage_gfp.shmem_fault.__do_fault.do_fault.__handle_mm_fault
     56.75 ±  3%     +15.0       71.78 ±  2%      +6.3       63.09 ±  5%  pp.bt.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.97 ±  3%     +33.9       35.87 ±  5%     +19.8       21.79 ± 23%  pp.bt._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.__pagevec_lru_add.lru_cache_add.shmem_getpage_gfp
      1.98 ±  3%     +33.9       35.89 ±  5%     +19.8       21.80 ± 23%  pp.bt.lock_page_lruvec_irqsave.__pagevec_lru_add.lru_cache_add.shmem_getpage_gfp.shmem_fault

We are still checking more, and will update if there is new data. 

Btw, the test platform is a 2 sockets, 4 nodes, 96C/192T Cascadelake AP,
and if run the same case on 2S/2Nodes/48C/96T Cascade Lake SP box, the
regression is about -22.3%.

Thanks,
Feng
      
> Anybody?
> 
>               Linus
