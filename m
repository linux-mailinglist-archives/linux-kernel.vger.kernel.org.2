Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECE640227B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 05:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhIGDbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 23:31:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:49992 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231880AbhIGDbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 23:31:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="207203958"
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; 
   d="scan'208";a="207203958"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 20:30:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; 
   d="scan'208";a="537666725"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Sep 2021 20:30:01 -0700
Date:   Tue, 7 Sep 2021 11:30:00 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        0day robot <lkp@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hillf Danton <hdanton@sina.com>,
        Huang Ying <ying.huang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Koutn?? <mkoutny@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [memcg] 45208c9105: aim7.jobs-per-min -14.0% regression
Message-ID: <20210907033000.GA88160@shbuild999.sh.intel.com>
References: <20210902215504.dSSfDKJZu%akpm@linux-foundation.org>
 <20210905124439.GA15026@xsang-OptiPlex-9020>
 <CALvZod77aP7qdwc5FkaZJf4FikeD0NwSuoJB4N94Uf0yqZFQpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod77aP7qdwc5FkaZJf4FikeD0NwSuoJB4N94Uf0yqZFQpQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shakeel, 

On Sun, Sep 05, 2021 at 03:15:46PM -0700, Shakeel Butt wrote:
> On Sun, Sep 5, 2021 at 5:27 AM kernel test robot <oliver.sang@intel.com> wrote:
[...]
> > =========================================================================================
> > compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
> >   gcc-9/performance/1BRD_48G/xfs/x86_64-rhel-8.3/3000/debian-10.4-x86_64-20200603.cgz/lkp-icl-2sp2/disk_rr/aim7/0xd000280
> >
> > commit:
> >   3c28c7680e ("memcg: switch lruvec stats to rstat")
> >   45208c9105 ("memcg: infrastructure to flush memcg stats")
> 
> I am looking into this. I was hoping we have resolution for [1] as
> these patches touch similar data structures.
> 
> [1] https://lore.kernel.org/all/20210811031734.GA5193@xsang-OptiPlex-9020/T/#u

I tried 2 debug methods for that 36.4% vm-scalability regression:

1. Disable the HW cache prefetcher, no effect on this case 
2. relayout and add padding to 'struct cgroup_subsys_state', reduce
   the regression to 3.1%

Thanks,
Feng

