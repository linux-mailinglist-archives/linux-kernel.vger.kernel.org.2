Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3300F453CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhKPXvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 18:51:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:14843 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhKPXvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 18:51:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="297271832"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="297271832"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 15:48:40 -0800
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="506668644"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.94.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 15:48:40 -0800
Message-ID: <41d0d7cbd3e292eb89b12d27d9beb576be3531bf.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] avoid spurious blocked load update
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org
Date:   Tue, 16 Nov 2021 15:48:40 -0800
In-Reply-To: <20211112095857.7016-1-vincent.guittot@linaro.org>
References: <20211112095857.7016-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-11-12 at 10:58 +0100, Vincent Guittot wrote:
> This patchset is a follow up of : 
> https://lore.kernel.org/lkml/20211019123537.17146-1-vincent.guittot@linaro.org/
> 
> It ensures that newly idle load balance will not kick the update of
> blocked load if it skips the load balance because avg_idle is too
> short.
> It also makes sure that rq->next_balance doesn't go in the past when
> updated.
> 
> Tim Chen (1):
>   sched: sched: Fix rq->next_balance time updated to earlier than
>     current time
> 
> Vincent Guittot (1):
>   sched/fair: skip newidle update stats
> 
>  kernel/sched/fair.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 

Vincent,

Got some data back from the benchmark team.
To my surprise, the skip_new_idle_update_stats patch
actually makes things a little worse.

                                        Relative Performance 
                                        (higher better)
5.15 rc4 vanilla (cgroup disabled)      100%
5.15 rc4 vanilla (cgroup enabled)       96%
patch v2                                96%
patch v3                                96%
patch v3
	+skip_new_idle_update_stats	93.7%
patch v3
	+skip_new_idle_update_stats
	+Fix rq->next_balance_time	93.7%	

The cpu utilization actually is the similar compared with
having just the v3 patch. In both cases they are
81% user
12% kernel
2%  idle
5%  waiting for IO


Profile on key functions
in load balancing shows a little more cpu utilization,
which is unexpected as we are cutting short
the newidle_balance.

patch v3
     0.56%          [k] __update_load_avg_cfs_rq  
     0.51%          [k] update_load_avg    
     0.39%          [k] update_blocked_averages
     0.36%          [k] __update_load_avg_se  
     0.05%	    [k] newidle_balance

patch v3 + skip_new_idle_update_stats
     0.58%          [k] __update_load_avg_cfs_rq  
     0.53%          [k] update_load_avg    
     0.40%          [k] update_blocked_averages
     0.37%          [k] __update_load_avg_se  
     0.06%	    [k] newidle_balance

Context switch frequency is lower by 4% with the skip_new_idle_update_stats
patch.  

Thanks.

Tim

