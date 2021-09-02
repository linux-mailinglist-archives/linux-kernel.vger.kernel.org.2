Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFDA3FE735
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 03:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhIBBhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 21:37:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:44648 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhIBBhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 21:37:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="279935094"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="279935094"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 18:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="532561828"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Sep 2021 18:35:58 -0700
Date:   Thu, 2 Sep 2021 09:35:58 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Michal Koutn?? <mkoutny@suse.com>,
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
Message-ID: <20210902013558.GA97410@shbuild999.sh.intel.com>
References: <20210816032855.GB72770@shbuild999.sh.intel.com>
 <YRrbpRsvdDoom9iG@cmpxchg.org>
 <20210817024500.GC72770@shbuild999.sh.intel.com>
 <20210817164737.GA23342@blackbody.suse.cz>
 <20210818023004.GA17956@shbuild999.sh.intel.com>
 <YSzwWIeapkzNElwV@blackbook>
 <20210831063036.GA46357@shbuild999.sh.intel.com>
 <20210831092304.GA17119@blackbody.suse.cz>
 <20210901045032.GA21937@shbuild999.sh.intel.com>
 <877dg0wcrr.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dg0wcrr.fsf@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 08:12:24AM -0700, Andi Kleen wrote:
> Feng Tang <feng.tang@intel.com> writes:
> >
> > Yes, the tests I did is no matter where the 128B padding is added, the
> > performance can be restored and even improved.
> 
> I wonder if we can find some cold, rarely accessed, data to put into the
> padding to not waste it. Perhaps some name strings? Or the destroy
> support, which doesn't sound like its commonly used.

Yes, I tried to move 'destroy_work', 'destroy_rwork' and 'parent' over
before the 'refcnt' together with some padding, it restored the performance
to about 10~15% regression. (debug patch pasted below)

But I'm not sure if we should use it, before we can fully explain the
regression.

Thanks,
Feng

commit a308d90b0d1973eb75551540a7aa849cabc8b8af
Author: Feng Tang <feng.tang@intel.com>
Date:   Sat Aug 14 16:18:43 2021 +0800

    move the member around
    
    Signed-off-by: Feng Tang <feng.tang@intel.com>

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index f9fb7f0..255f668 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -139,10 +139,21 @@ struct cgroup_subsys_state {
 	/* PI: the cgroup that this css is attached to */
 	struct cgroup *cgroup;
 
+	struct cgroup_subsys_state *parent;
+
 	/* PI: the cgroup subsystem that this css is attached to */
 	struct cgroup_subsys *ss;
 
-	unsigned long pad[16];
+	/* percpu_ref killing and RCU release */
+	struct work_struct destroy_work;
+	struct rcu_work destroy_rwork;
+
+	unsigned long pad[2]; /* 128 bytes */
 
 	/* reference count - access via css_[try]get() and css_put() */
 	struct percpu_ref refcnt;
@@ -176,6 +187,7 @@ struct cgroup_subsys_state {
 	 */
 	atomic_t online_cnt;
 
+	#if 0
 	/* percpu_ref killing and RCU release */
 	struct work_struct destroy_work;
 	struct rcu_work destroy_rwork;
@@ -185,6 +197,7 @@ struct cgroup_subsys_state {
 	 * fields of the containing structure.
 	 */
 	struct cgroup_subsys_state *parent;
+	#endif
 };
 
 /*


> -Andi
