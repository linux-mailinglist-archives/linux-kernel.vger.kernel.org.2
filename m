Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569483ECD3D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 05:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhHPD3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 23:29:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:14281 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhHPD3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 23:29:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10077"; a="195372449"
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="195372449"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 20:28:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="519356755"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Aug 2021 20:28:56 -0700
Date:   Mon, 16 Aug 2021 11:28:55 +0800
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
Message-ID: <20210816032855.GB72770@shbuild999.sh.intel.com>
References: <20210811031734.GA5193@xsang-OptiPlex-9020>
 <CAHk-=wiSHHSuSQsCCLOxQA+cbcvjmEeMsTCMWPT1sFVngd9-ig@mail.gmail.com>
 <20210812031910.GA63920@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210812031910.GA63920@shbuild999.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 11:19:10AM +0800, Feng Tang wrote:
> On Tue, Aug 10, 2021 at 07:59:53PM -1000, Linus Torvalds wrote:
[SNIP]

> And seems there is some cache false sharing when accessing mem_cgroup
> member: 'struct cgroup_subsys_state', from the offset (0x0 and 0x10 here)
> and the calling sites, the cache false sharing could happen between:
> 
>     cgroup_rstat_updated (read memcg->css.cgroup, offset 0x0)
> and 
>     get_mem_cgroup_from_mm
> 	css_tryget(&memcg->css) (read/write memcg->css.refcnt, offset 0x10)
> 
> (This could be wrong as many of the functions are inlined, and the
> exact calling site isn't shown)
> 
> And to verify this, we did a test by adding padding between
> memcg->css.cgroup and memcg->css.refcnt to push them into 2
> different cache lines, and the performance are partly restored:
> 
> dc26532aed0ab25c 2d146aa3aa842d7f5065802556b 73371bf27a8a8ea68df2fbf456b 
> ---------------- --------------------------- --------------------------- 
>   65523232 ±  4%     -40.8%   38817332 ±  5%     -19.6%   52701654 ±  3%  vm-scalability.throughput
>
> We are still checking more, and will update if there is new data. 

Seems this is the second case to hit 'adjacent cacheline prefetch",
the first time we saw it is also related with mem_cgroup
https://lore.kernel.org/lkml/20201125062445.GA51005@shbuild999.sh.intel.com/

In previous debug patch, the 'css.cgroup' and 'css.refcnt' is
separated to 2 cache lines, which are still adjacent (2N and 2N+1)
cachelines. And with more padding (add 128 bytes padding in between),
the performance is restored, and even better (test run 3 times):

dc26532aed0ab25c 2d146aa3aa842d7f5065802556b 2e34d6daf5fbab0fb286dcdb3bc 
---------------- --------------------------- --------------------------- 
  65523232 ±  4%     -40.8%   38817332 ±  5%     +23.4%   80862243 ±  3%  vm-scalability.throughput

The debug patch is:
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -142,6 +142,8 @@ struct cgroup_subsys_state {
 	/* PI: the cgroup subsystem that this css is attached to */
 	struct cgroup_subsys *ss;
 
+	unsigned long pad[16];
+
 	/* reference count - access via css_[try]get() and css_put() */
 	struct percpu_ref refcnt;
 
Thanks,
Feng

> Btw, the test platform is a 2 sockets, 4 nodes, 96C/192T Cascadelake AP,
> and if run the same case on 2S/2Nodes/48C/96T Cascade Lake SP box, the
> regression is about -22.3%.
> 
> Thanks,
> Feng
>       
> > Anybody?
> > 
> >               Linus
