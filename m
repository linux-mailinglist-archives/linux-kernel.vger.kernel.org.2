Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7836D375842
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbhEFQMl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 May 2021 12:12:41 -0400
Received: from foss.arm.com ([217.140.110.172]:37258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235616AbhEFQMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:12:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D67FC31B;
        Thu,  6 May 2021 09:11:30 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C21C3F718;
        Thu,  6 May 2021 09:11:27 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>, aubrey.li@linux.intel.com,
        yu.c.chen@intel.com, Mel Gorman <mgorman@suse.de>
Subject: Re: [sched/fair]  38ac256d1c:  stress-ng.vm-segv.ops_per_sec -13.8% regression
In-Reply-To: <87k0omxe6w.mognet@arm.com>
References: <20210414052151.GB21236@xsang-OptiPlex-9020> <87im4on5u5.mognet@arm.com> <20210421032022.GA13430@xsang-OptiPlex-9020> <87bla8ue3e.mognet@arm.com> <20210422074742.GE31382@xsang-OptiPlex-9020> <87wnsutzi9.mognet@arm.com> <87mttqt5jc.mognet@arm.com> <87k0omxe6w.mognet@arm.com>
Date:   Thu, 06 May 2021 17:11:20 +0100
Message-ID: <871rajkfkn.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/21 23:00, Valentin Schneider wrote:
> As far as I can tell, the culprit is the loss of LBF_SOME_PINNED. By some
> happy accident, the load balancer repeatedly iterates over PCPU kthreads,
> sets LBF_SOME_PINNED and causes a group to be classified as group_imbalanced
> in a later load-balance. This, in turn, forces a 1-task pull, and repeating
> this pattern ~25 times a sec ends up increasing CPU utilization by ~5% over the
> span of the benchmark.

So this is where I got to:

Because pcpu kthreads run periodically, they sometimes get iterated over by the
periodic load-balance and can cause LBF_SOME_PINNED. This can lead to setting

  env->sd->parent->sg->sgc->imbalance

which may cause later load balance attempts to classify the designated group
span as group_imbalanced. Note that this will affect periodic load balance
*and* fork/exec balance.


On a 2-node system with SMT, MC and NUMA topology levels, this means that
load-balance at MC level will periodically set LBF_SOME_PINNED, opening a
window where any subsequent fork() issued on that node will see
find_idlest_cpu() being biased towards the remote node (find_idlest_cpu()
tries to minimize group_type, and group_imbalanced is the second highest).
In the benchmark's case, the NUMA groups are only ever classified as
group_has_spare, making this a hard bias.

Digging down into find_idlest_cpu(), this periodic bias seems to act as an
override to allow_numa_imbalance(): the benchmark spawns 6 stressors which
AFAICT each spawn a child, so that's at most 12 total runnable tasks. In
this particular case, the 25% domain size threshold of
allow_numa_imbalance() maps to 16, so the condition is pretty much always
true (confirmed via tracing).

On this particular machine (dual-socket Xeon Gold 5120 @ 2.20GHz, 64 CPUs)
with this particular benchmark this seems to happen for ~1% of forks, but
causes a performance improvement between of 5% to 13%. I'm not exactly sure
on the why, but I suspect that the tasks having a very short runtime (avg
6µs) means fork-time balance is the only real opportunity for them to move
to a different NUMA node.

One could argue the benchmark itself gets what it deserves since forking ad
nauseam isn't such a great idea [1], and perhaps it should pin the
stressors to a single NUMA node. I did try to make allow_numa_imbalance()
"smarter", but couldn't find any winning formula. Adding to this the fact
that this regression isn't reproducible on a lot of systems (I got either
noise or improvements on all the arm64 systems I tried), so I'm somewhat
stumped TBH.

[1]: Unless you're trying to summon Slaanesh
