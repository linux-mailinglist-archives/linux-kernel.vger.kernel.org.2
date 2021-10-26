Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFD043B81D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbhJZR1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:27:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:26885 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232231AbhJZR1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:27:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="210052169"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="210052169"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 10:25:07 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="635331056"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.247.89])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 10:25:06 -0700
Message-ID: <7128695d64e9161637b67315b5beb51c4accdc82.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/5] Improve newidle lb cost tracking and early abort
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 26 Oct 2021 10:25:05 -0700
In-Reply-To: <20211019123537.17146-1-vincent.guittot@linaro.org>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-19 at 14:35 +0200, Vincent Guittot wrote:
> This patchset updates newidle lb cost tracking and early abort:
> 
> The time spent running update_blocked_averages is now accounted in
> the 1st
> sched_domain level. This time can be significant and move the cost of
> newidle lb above the avg_idle time.
> 
> The decay of max_newidle_lb_cost is modified to start only when the
> field
> has not been updated for a while. Recent update will not be decayed
> immediatlybut only after a while.
> 
> The condition of an avg_idle lower than sysctl_sched_migration_cost
> has
> been removed as the 500us value is quite large and prevent
> opportunity to
> pull task on the newly idle CPU for at least 1st domain levels.
> 
> Monitoring sd->max_newidle_lb_cost on cpu0 of a Arm64 system
> THX2 (2 nodes * 28 cores * 4 cpus) during the benchmarks gives the
> following results:
>        min    avg   max
> SMT:   1us   33us  273us - this one includes the update of blocked
> load
> MC:    7us   49us  398us
> NUMA: 10us   45us  158us
> 
> 
> Some results for hackbench -l $LOOPS -g $group :
> group      tip/sched/core     + this patchset
> 1           15.189(+/- 2%)       14.987(+/- 2%)  +1%
> 4            4.336(+/- 3%)        4.322(+/- 5%)  +0%
> 16           3.654(+/- 1%)        2.922(+/- 3%) +20%
> 32           3.209(+/- 1%)        2.919(+/- 3%)  +9%
> 64           2.965(+/- 1%)        2.826(+/- 1%)  +4%
> 128          2.954(+/- 1%)        2.993(+/- 8%)  -1%
> 256          2.951(+/- 1%)        2.894(+/- 1%)  +2%
> 
> tbench and reaim have not shown any difference
> 

Vincent,

Our benchmark team tested the patches for our OLTP benchmark
on a 2 socket Cascade Lake
with 28 cores/socket.  It is a smaller configuration
than the 2 socket Ice Lake we hae tested previously that has 40
cores/socket so the overhead on update_blocked_averages is smaller
(~4%).

Here's a summary of the results:
					Relative Performance 
					(higher better)
5.15 rc4 vanilla (cgroup disabled)	100%
5.15 rc4 vanilla (cgroup enabled)	96%
patch v2				96%
patch v3				96%

We didn't see much change in performance from the patch set.

Looking at the profile on update_blocked_averages a bit more,
the majority of the call to update_blocked_averages
happens in run_rebalance_domain.  And we are not
including that cost of update_blocked_averages for
run_rebalance_domains in our current patch set. I think
the patch set should account for that too.


      0.60%     0.00%             3  [kernel.vmlinux]    [k] run_rebalance_domains                                                                                                                                                  -      -            
            |          
             --0.59%--run_rebalance_domains
                       |          
                        --0.57%--update_blocked_averages

Thanks.

Tim

