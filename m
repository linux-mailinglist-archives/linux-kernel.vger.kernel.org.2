Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C563EF814
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 04:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbhHRCav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 22:30:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:28886 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235486AbhHRCao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 22:30:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="215967574"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="215967574"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 19:30:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="488263669"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2021 19:30:05 -0700
Date:   Wed, 18 Aug 2021 10:30:04 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Koutn?? <mkoutny@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        andi.kleen@intel.com
Subject: Re: [mm] 2d146aa3aa: vm-scalability.throughput -36.4% regression
Message-ID: <20210818023004.GA17956@shbuild999.sh.intel.com>
References: <20210811031734.GA5193@xsang-OptiPlex-9020>
 <CAHk-=wiSHHSuSQsCCLOxQA+cbcvjmEeMsTCMWPT1sFVngd9-ig@mail.gmail.com>
 <20210812031910.GA63920@shbuild999.sh.intel.com>
 <20210816032855.GB72770@shbuild999.sh.intel.com>
 <YRrbpRsvdDoom9iG@cmpxchg.org>
 <20210817024500.GC72770@shbuild999.sh.intel.com>
 <20210817164737.GA23342@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817164737.GA23342@blackbody.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Tue, Aug 17, 2021 at 06:47:37PM +0200, Michal Koutn?? wrote:
> On Tue, Aug 17, 2021 at 10:45:00AM +0800, Feng Tang <feng.tang@intel.com> wrote:
> > Initially from the perf-c2c data, the in-cacheline hotspots are only
> > 0x0, and 0x10, and if we extends to 2 cachelines, there is one more
> > offset 0x54 (css.flags), but still I can't figure out which member
> > inside the 128 bytes range is written frequenty.
> 
> Is it certain that perf-c2c reported offsets are the cacheline of the
> first bytes of struct cgroup_subsys_state? (Yeah, it looks to me so,
> given what code accesses those and your padding fixing it. I'm just
> raising it in case there was anything non-obvious.)

Thanks for checking.

Yes, they are. 'struct cgroup_subsys_state' is the first member of
'mem_cgoup' whose address are alwasy cacheline aligned (debug info
shows it's even 2KB or 4KB aligned)

> > 
> > /* pah info for cgroup_subsys_state */
> > struct cgroup_subsys_state {
> > 	struct cgroup *            cgroup;               /*     0     8 */
> > 	struct cgroup_subsys *     ss;                   /*     8     8 */
> > 	struct percpu_ref          refcnt;               /*    16    16 */
> > 	struct list_head           sibling;              /*    32    16 */
> > 	struct list_head           children;             /*    48    16 */
> > 	/* --- cacheline 1 boundary (64 bytes) --- */
> > 	struct list_head           rstat_css_node;       /*    64    16 */
> > 	int                        id;                   /*    80     4 */
> > 	unsigned int               flags;                /*    84     4 */
> > 	u64                        serial_nr;            /*    88     8 */
> > 	atomic_t                   online_cnt;           /*    96     4 */
> > 
> > 	/* XXX 4 bytes hole, try to pack */
> > 
> > 	struct work_struct         destroy_work;         /*   104    32 */
> > 	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
> > 
> > Since the test run implies this is cacheline related, and I'm not very
> > familiar with the mem_cgroup code, the original perf-c2c log is attached
> > which may give more hints.
> 
> As noted by Johannes, even in atomic mode, the refcnt would have the
> atomic part elsewhere. The other members shouldn't be written frequently
> unless there are some intense modifications of the cgroup tree in
> parallel.
> Does the benchmark create lots of memory cgroups in such a fashion?

As Shakeel also mentioned, this 0day's vm-scalability doesn't involve
any explicit mem_cgroup configurations. And it's running on a simplified
debian 10 rootfs which has some systemd boottime cgroup setup.

Thanks,
Feng

> Regards,
> Michal
