Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9056A43FA62
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 12:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhJ2KDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 06:03:40 -0400
Received: from foss.arm.com ([217.140.110.172]:36572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231564AbhJ2KDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 06:03:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 482081FB;
        Fri, 29 Oct 2021 03:01:10 -0700 (PDT)
Received: from [192.168.154.184] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C90E3F5A1;
        Fri, 29 Oct 2021 03:01:08 -0700 (PDT)
Subject: Re: [PATCH v3 0/5] Improve newidle lb cost tracking and early abort
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <7e60ab36-aecd-8912-0cda-72dba21268d2@arm.com>
Date:   Fri, 29 Oct 2021 12:01:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019123537.17146-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 14:35, Vincent Guittot wrote:
> This patchset updates newidle lb cost tracking and early abort:
> 
> The time spent running update_blocked_averages is now accounted in the 1st
> sched_domain level. This time can be significant and move the cost of
> newidle lb above the avg_idle time.
> 
> The decay of max_newidle_lb_cost is modified to start only when the field
> has not been updated for a while. Recent update will not be decayed
> immediatlybut only after a while.
> 
> The condition of an avg_idle lower than sysctl_sched_migration_cost has
> been removed as the 500us value is quite large and prevent opportunity to
> pull task on the newly idle CPU for at least 1st domain levels.
> 
> Monitoring sd->max_newidle_lb_cost on cpu0 of a Arm64 system
> THX2 (2 nodes * 28 cores * 4 cpus) during the benchmarks gives the
> following results:
>        min    avg   max
> SMT:   1us   33us  273us - this one includes the update of blocked load
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
> Change since v2:
> - Update and decay of sd->last_decay_max_lb_cost are gathered in
>   update_newidle_cost(). The behavior remains almost the same except that
>   the decay can happen during newidle_balance now.
> 
>   Tests results haven't shown any differences
>   
>   I haven't modified rq->max_idle_balance_cost. It acts as the max value
>   for avg_idle and prevents the latter to reach high value during long
>   idle phase. Moving on an IIR filter instead, could delay the convergence
>   of avg_idle to a reasonnable value that reflect current situation.
> 
> - Added a minor cleanup of newidle_balance
> 
> Change since v1:
> - account the time spent in update_blocked_averages() in the 1st domain
> 
> - reduce number of call of sched_clock_cpu() 
> 
> - change the way max_newidle_lb_cost is decayed. Peter suggested to use a
>   IIR but keeping a track of the current max value gave the best result
> 
> - removed the condition (this_rq->avg_idle < sysctl_sched_migration_cost)
>   as suggested by Peter
> 
> Vincent Guittot (5):
>   sched/fair: Account update_blocked_averages in newidle_balance cost
>   sched/fair: Skip update_blocked_averages if we are defering load
>     balance
>   sched/fair: Wait before decaying max_newidle_lb_cost
>   sched/fair: Remove sysctl_sched_migration_cost condition
>   sched/fair: cleanup newidle_balance
> 
>  include/linux/sched/topology.h |  2 +-
>  kernel/sched/fair.c            | 65 ++++++++++++++++++++++------------
>  kernel/sched/topology.c        |  2 +-
>  3 files changed, 45 insertions(+), 24 deletions(-)

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

LGTM, just a couple of questions in 3/5 and 4/5.



