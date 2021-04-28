Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0453C36E154
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 00:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhD1WBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 18:01:04 -0400
Received: from foss.arm.com ([217.140.110.172]:57180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhD1WBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:01:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC4E7ED1;
        Wed, 28 Apr 2021 15:00:16 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ACC63F694;
        Wed, 28 Apr 2021 15:00:14 -0700 (PDT)
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
In-Reply-To: <87mttqt5jc.mognet@arm.com>
References: <20210414052151.GB21236@xsang-OptiPlex-9020> <87im4on5u5.mognet@arm.com> <20210421032022.GA13430@xsang-OptiPlex-9020> <87bla8ue3e.mognet@arm.com> <20210422074742.GE31382@xsang-OptiPlex-9020> <87wnsutzi9.mognet@arm.com> <87mttqt5jc.mognet@arm.com>
Date:   Wed, 28 Apr 2021 23:00:07 +0100
Message-ID: <87k0omxe6w.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 21:42, Valentin Schneider wrote:
> On 22/04/21 10:55, Valentin Schneider wrote:
>> I'll go find myself some other x86 box and dig into it;
>> I'd rather not leave this hanging for too long.
>
> So I found myself a dual-socket Xeon Gold 5120 @ 2.20GHz (64 CPUs) and
> *there* I get a somewhat consistent ~-6% regression. As I'm suspecting
> cacheline shenanigans, I also ran that with Peter's recent
> kthread_is_per_cpu() change, and that brings it down to ~-3%
>

Ha ha ho ho, so that was a red herring. My statistical paranoia somewhat
paid off, and the kthread_is_per_cpu() thing doesn't really change anything
when you stare at 20+ iterations of that vm-segv thing.

As far as I can tell, the culprit is the loss of LBF_SOME_PINNED. By some
happy accident, the load balancer repeatedly iterates over PCPU kthreads,
sets LBF_SOME_PINNED and causes a group to be classified as group_imbalanced
in a later load-balance. This, in turn, forces a 1-task pull, and repeating
this pattern ~25 times a sec ends up increasing CPU utilization by ~5% over the
span of the benchmark.

schedstats are somewhat noisy but seem to indicate the baseline had many
more migrations at the NUMA level (test machine has SMT, MC, NUMA). Because
of that I suspected

  b396f52326de ("sched/fair: Allow a small load imbalance between low utilisation SD_NUMA domains")

but reverting that actually makes things worse. I'm still digging, though
I'm slowly heading towards:

  https://www.youtube.com/watch?v=3L6i5AwVAbs
