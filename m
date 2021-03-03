Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4284032C161
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838555AbhCCTAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:00:54 -0500
Received: from foss.arm.com ([217.140.110.172]:54028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1580795AbhCCSfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:35:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D2B031B;
        Wed,  3 Mar 2021 10:34:23 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A45643F7D7;
        Wed,  3 Mar 2021 10:34:20 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>, aubrey.li@linux.intel.com,
        yu.c.chen@intel.com
Subject: Re: [sched/fair]  b360fb5e59:  stress-ng.vm-segv.ops_per_sec -13.9% regression
In-Reply-To: <jhjim6jhsfp.mognet@arm.com>
References: <20210223023004.GB25487@xsang-OptiPlex-9020> <jhjim6jhsfp.mognet@arm.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 03 Mar 2021 18:34:13 +0000
Message-ID: <jhjy2f46q8q.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/21 12:36, Valentin Schneider wrote:
> On 23/02/21 10:30, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed a -13.9% regression of stress-ng.vm-segv.ops_per_sec due to commit:
>>
>>
>> commit: b360fb5e5954a8a440ef95bf11257e2e7ea90340 ("[PATCH v2 1/7] sched/fair: Ignore percpu threads for imbalance pulls")
>> url: https://github.com/0day-ci/linux/commits/Valentin-Schneider/sched-fair-misfit-task-load-balance-tweaks/20210219-211028
>> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git c5e6fc08feb2b88dc5dac2f3c817e1c2a4cafda4
>>
>> in testcase: stress-ng
>> on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory
>> with following parameters:
>>
>>      nr_threads: 10%
>>      disk: 1HDD
>>      testtime: 60s
>>      fs: ext4
>>      class: vm
>>      test: vm-segv
>>      cpufreq_governor: performance
>>      ucode: 0x5003003
>>

So I've been running this on my 32 CPU arm64 desktop with:
  nr_threads: 10%
  nr_threads: 50%
  (20 iterations each)

In the 50% case I see a ~2% improvement, in the 10% a -0.3%
regression (another batch showed -0.08%)... Still far off from the reported
-14%. If it's really required I can go find an x86 box to test this on, but
so far it looks like a fluke.
