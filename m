Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96F9366933
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbhDUK2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:28:33 -0400
Received: from foss.arm.com ([217.140.110.172]:58844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239508AbhDUK21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:28:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58068113E;
        Wed, 21 Apr 2021 03:27:54 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 094033F73B;
        Wed, 21 Apr 2021 03:27:51 -0700 (PDT)
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
        yu.c.chen@intel.com
Subject: Re: [sched/fair]  38ac256d1c:  stress-ng.vm-segv.ops_per_sec -13.8% regression
In-Reply-To: <20210421032022.GA13430@xsang-OptiPlex-9020>
References: <20210414052151.GB21236@xsang-OptiPlex-9020> <87im4on5u5.mognet@arm.com> <20210421032022.GA13430@xsang-OptiPlex-9020>
Date:   Wed, 21 Apr 2021 11:27:49 +0100
Message-ID: <87bla8ue3e.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 21/04/21 11:20, Oliver Sang wrote:
> hi, Valentin Schneider,
>
> On Wed, Apr 14, 2021 at 06:17:38PM +0100, Valentin Schneider wrote:
>> On 14/04/21 13:21, kernel test robot wrote:
>> > Greeting,
>> >
>> > FYI, we noticed a -13.8% regression of stress-ng.vm-segv.ops_per_sec due to commit:
>> >
>> >
>> > commit: 38ac256d1c3e6b5155071ed7ba87db50a40a4b58 ("[PATCH v5 1/3] sched/fair: Ignore percpu threads for imbalance pulls")
>> > url: https://github.com/0day-ci/linux/commits/Valentin-Schneider/sched-fair-load-balance-vs-capacity-margins/20210408-060830
>> > base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 0a2b65c03e9b47493e1442bf9c84badc60d9bffb
>> >
>> > in testcase: stress-ng
>> > on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
>> > with following parameters:
>> >
>> >       nr_threads: 10%
>> >       disk: 1HDD
>> >       testtime: 60s
>> >       fs: ext4
>> >       class: os
>> >       test: vm-segv
>> >       cpufreq_governor: performance
>> >       ucode: 0x5003006
>> >
>> >
>>
>> That's almost exactly the same result as [1], which is somewhat annoying
>> for me because I wasn't able to reproduce those results back then. Save
>> from scrounging the exact same machine to try this out, I'm not sure what's
>> the best way forward. I guess I can re-run the workload on whatever
>> machines I have and try to spot any potentially problematic pattern in the
>> trace...
>
> what's the machine model you used upon which the regression cannot be reproduced?
> we could check if we have similar model then re-check on the our machine.
>

I tested this on:
o Ampere eMAG (arm64, 32 cores)
o 2-socket Xeon E5-2690 (x86, 40 cores)

and found at worse a -0.3% regression and at best a 2% improvement. I know
that x86 box is somewhat ancient, but it's been my go-to "have I broken
x86?" test victim for a while :-)

> BTW, we supplied perf data in original report, not sure if they are helpful?
> or do you have suggestion which kind of data will be more helpful to you?
> we will continuously improve our report based on suggestions from community.
> Thanks a lot!
>

Staring at it some more, I notice a huge uptick in:

- major page faults (+315.2% and +270%)
- cache misses (+125.2% and +131.0%)

I don't really get the page faults; the cache misses I could somewhat
understand: this is adding p->flags and (p->set_child_tid)->flags accesses,
which are in different cachelines than p->se and p->cpus_mask used in
can_migrate_task().

I think I could dig some more into this with perf, but I'd need to be able
to reproduce this locally first...

>>
>> [1]: http://lore.kernel.org/r/20210223023004.GB25487@xsang-OptiPlex-9020
