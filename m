Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABBE40A325
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbhINCOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:14:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:46166 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233111AbhINCOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:14:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="221900198"
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="221900198"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 19:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="543584748"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Sep 2021 19:13:23 -0700
Date:   Tue, 14 Sep 2021 10:13:22 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [memcg] 45208c9105: aim7.jobs-per-min -14.0% regression
Message-ID: <20210914021322.GE56674@shbuild999.sh.intel.com>
References: <20210907033000.GA88160@shbuild999.sh.intel.com>
 <CALvZod6M_sySPM1KaWzb=tkLxXJksVDrSheckXaiBpMC3cNeqw@mail.gmail.com>
 <20210912111756.4158-1-hdanton@sina.com>
 <20210912132914.GA56674@shbuild999.sh.intel.com>
 <CALvZod4VbdSux5RaQuhqbC7ENm39UbdkJF8LhYedbFwHKyJgfw@mail.gmail.com>
 <CALvZod7Oa7q=P0gzfA3F26bHPrNz+F-d6G9qKpSiHy9g=msM_w@mail.gmail.com>
 <YT+ptg1Lf1kGLyUX@slm.duckdns.org>
 <CALvZod7mBLbkqZJzZz=XNGTDB4mxCd6dwM40aCv6t8fWbdUJdw@mail.gmail.com>
 <YT+wKFZg0OS0YFrF@slm.duckdns.org>
 <CALvZod7BFZ1M4KWYWEhRHdZCeLV8Km=NqpkCZ=k67mBNSgX0cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvZod7BFZ1M4KWYWEhRHdZCeLV8Km=NqpkCZ=k67mBNSgX0cQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shakeel,

On Mon, Sep 13, 2021 at 01:13:57PM -0700, Shakeel Butt wrote:
> On Mon, Sep 13, 2021 at 1:10 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Mon, Sep 13, 2021 at 01:09:11PM -0700, Shakeel Butt wrote:
> > > Thanks a lot for the explanation. Are there any concerns to call
> > > cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup) in system_wq?
> > > This will be called every 2 seconds, so, we can assume the updated
> > > tree would be small most of the time.
> >
> > I can't think of a reason why this would be problematic.
> >
> 
> Thanks again.
> 
> Feng, is it possible to re-run these benchmarks with
> queue_work(system_wq) instead of queue_work(system_unbound_wq)?

I just run the patch twice, and there was no obvious change, the
hotspot is still the spinlock.

Thanks,
Feng

$git-diff aa48e47e
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4d8c9af..fa9cae9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -683,7 +683,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
        /* Update lruvec */
        __this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
        if (!(__this_cpu_inc_return(stats_flush_threshold) % MEMCG_CHARGE_BATCH))
-               queue_work(system_unbound_wq, &stats_flush_work);
+               queue_work(system_wq, &stats_flush_work);
 }


7e1c0d6f58207e7e aa48e47e3906c332eaf1e5d7b58 1638eee6432c1a5175685a7945a 
---------------- --------------------------- --------------------------- 
             \          |                \          |                \  
    648.62          +243.0%       2224 ±  3%    +246.1%       2244        aim7.cpu
    588139           -13.4%     509421           -13.5%     508738        aim7.jobs-per-min
    196.05           -13.4%     169.81           -13.5%     169.58        aim7.jobs-per-min-per-task
      3.93 ±  3%     +62.8       66.70           +63.4       67.37        pp.child.native_queued_spin_lock_slowpath
      3.96 ±  4%     +62.8       66.76           +63.5       67.46        pp.child._raw_spin_lock_irqsave
      3.66 ±  5%     +62.9       66.54           +63.6       67.22        pp.child.lock_page_lruvec_irqsave
      0.00            +0.1        0.10 ±  5%      +0.1        0.09        pp.self.queue_work_on
      0.00            +0.2        0.18 ±  5%      +0.2        0.22        pp.self.cgroup_rstat_flush_locked
      0.00            +0.6        0.60 ±  7%      +0.7        0.72 ±  3%  pp.self.mem_cgroup_css_rstat_flush
      0.19            +0.7        0.86 ±  5%      +0.7        0.84 ±  4%  pp.self.cgroup_rstat_updated
      3.92 ±  3%     +62.8       66.70           +63.4       67.37        pp.self.native_queued_spin_lock_slowpath



