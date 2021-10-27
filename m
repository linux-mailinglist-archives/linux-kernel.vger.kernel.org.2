Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296C643D342
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 22:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244123AbhJ0U4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:56:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:4134 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244102AbhJ0U4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:56:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="293725206"
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="293725206"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 13:53:34 -0700
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="635879473"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.74.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 13:53:33 -0700
Message-ID: <720fd26424927dd27fea4e5719dafe8a0afaa8c4.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/5] Improve newidle lb cost tracking and early abort
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 27 Oct 2021 13:53:32 -0700
In-Reply-To: <CAKfTPtAv7vPGYAwUSmGL5wtbY=if8G+3geWMKpHu3vLGqthPfg@mail.gmail.com>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
         <7128695d64e9161637b67315b5beb51c4accdc82.camel@linux.intel.com>
         <CAKfTPtAv7vPGYAwUSmGL5wtbY=if8G+3geWMKpHu3vLGqthPfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-27 at 10:49 +0200, Vincent Guittot wrote:
> 
> > Looking at the profile on update_blocked_averages a bit more,
> > the majority of the call to update_blocked_averages
> > happens in run_rebalance_domain.  And we are not
> > including that cost of update_blocked_averages for
> > run_rebalance_domains in our current patch set. I think
> > the patch set should account for that too.
> 
> nohz_newidle_balance keeps using sysctl_sched_migration_cost to
> trigger a _nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK, CPU_IDLE);
> This would probably benefit to take into account the cost of
> update_blocked_averages instead
> 

For the case where

	this_rq->avg_idle < sysctl_sched_migration_cost

in newidle_balance(), we skip to the out: label

out:
        /* Move the next balance forward */
        if (time_after(this_rq->next_balance, next_balance))
                this_rq->next_balance = next_balance;

        if (pulled_task)
                this_rq->idle_stamp = 0;
        else
                nohz_newidle_balance(this_rq);

and we call nohz_newidle_balance as we don't have a pulled_task.

It seems to make sense to skip the call
to nohz_newidle_balance() for this case?  
We expect a very short idle and a task to wake shortly.  
So we do not have to pull a task
to this idle cpu and incur the migration cost.

Tim




