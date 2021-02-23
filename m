Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E26322AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhBWMhZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Feb 2021 07:37:25 -0500
Received: from foss.arm.com ([217.140.110.172]:47436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232700AbhBWMhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:37:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 837B531B;
        Tue, 23 Feb 2021 04:36:31 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34ADB3F70D;
        Tue, 23 Feb 2021 04:36:29 -0800 (PST)
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
In-Reply-To: <20210223023004.GB25487@xsang-OptiPlex-9020>
References: <20210223023004.GB25487@xsang-OptiPlex-9020>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 23 Feb 2021 12:36:26 +0000
Message-ID: <jhjim6jhsfp.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/21 10:30, kernel test robot wrote:
> Greeting,
>
> FYI, we noticed a -13.9% regression of stress-ng.vm-segv.ops_per_sec due to commit:
>
>
> commit: b360fb5e5954a8a440ef95bf11257e2e7ea90340 ("[PATCH v2 1/7] sched/fair: Ignore percpu threads for imbalance pulls")
> url: https://github.com/0day-ci/linux/commits/Valentin-Schneider/sched-fair-misfit-task-load-balance-tweaks/20210219-211028
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git c5e6fc08feb2b88dc5dac2f3c817e1c2a4cafda4
>
> in testcase: stress-ng
> on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory
> with following parameters:
>
> 	nr_threads: 10%
> 	disk: 1HDD
> 	testtime: 60s
> 	fs: ext4
> 	class: vm
> 	test: vm-segv
> 	cpufreq_governor: performance
> 	ucode: 0x5003003
>
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> Details are as below:
> -------------------------------------------------------------------------------------------------->
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install                job.yaml  # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml
>         bin/lkp run                    compatible-job.yaml
>
> =========================================================================================
> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
>   vm/gcc-9/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp7/vm-segv/stress-ng/60s/0x5003003
>
> commit: 
>   c5e6fc08fe ("sched,x86: Allow !PREEMPT_DYNAMIC")
>   b360fb5e59 ("sched/fair: Ignore percpu threads for imbalance pulls")
>
> c5e6fc08feb2b88d b360fb5e5954a8a440ef95bf112 
> ---------------- --------------------------- 
>        fail:runs  %reproduction    fail:runs
>            |             |             |    
>           1:6           -3%           1:6     perf-profile.children.cycles-pp.error_entry
>           0:6           -1%           0:6     perf-profile.self.cycles-pp.error_entry
>          %stddev     %change         %stddev
>              \          |                \  
>      11324 ï¿½  3%     -28.1%       8140 ï¿½  3%  stress-ng.time.involuntary_context_switches
>       6818 ï¿½ 15%    +315.2%      28311 ï¿½ 12%  stress-ng.time.major_page_faults
>   30952041           -12.8%   26988502        stress-ng.time.minor_page_faults

>     378.82            +5.3%     398.75        stress-ng.time.system_time
>     215.82           -10.0%     194.24        stress-ng.time.user_time
>   62102177           -13.9%   53448474        stress-ng.time.voluntary_context_switches
>     810348           -13.9%     698034        stress-ng.vm-segv.ops
>      13505           -13.9%      11633        stress-ng.vm-segv.ops_per_sec

My hunch was that this could be due to the balance interval no longer being
increased when load balance catches pcpu kworkers, but that's not the case:
we would still have LBF_ALL_PINNED, which will still double the balance
interval if no task was moved.

I'm not sure which stat to look at wrt softirqs; this seems to say there
weren't that many more:

>       1.11            -0.3        0.85        mpstat.cpu.all.irq%
>       0.18            -0.0        0.16        mpstat.cpu.all.soft%
>       0.40            -0.1        0.35        mpstat.cpu.all.usr%

But this does:

>      11501 ï¿½  5%      +9.6%      12610 ï¿½  6%  softirqs.CPU12.RCU
>      10678 ï¿½  5%     +16.0%      12383 ï¿½  2%  softirqs.CPU16.RCU
>      10871 ï¿½  4%     +13.1%      12294 ï¿½  2%  softirqs.CPU17.RCU
>      10724 ï¿½  2%     +13.8%      12205 ï¿½  3%  softirqs.CPU18.RCU
>      10810 ï¿½  4%     +16.2%      12560 ï¿½  3%  softirqs.CPU19.RCU
>      10647 ï¿½  6%     +16.2%      12372 ï¿½  6%  softirqs.CPU20.RCU
>      10863 ï¿½  3%     +14.7%      12461 ï¿½  3%  softirqs.CPU21.RCU
>      11231 ï¿½  5%     +14.6%      12873 ï¿½  6%  softirqs.CPU22.RCU
>      11141 ï¿½  6%     +21.0%      13480 ï¿½  8%  softirqs.CPU64.RCU
>      11209 ï¿½  6%     +20.8%      13545 ï¿½  2%  softirqs.CPU65.RCU
>      11108 ï¿½  3%     +20.0%      13334 ï¿½  6%  softirqs.CPU66.RCU
>      11414 ï¿½  9%     +16.9%      13345 ï¿½  6%  softirqs.CPU67.RCU
>      11162 ï¿½  4%     +16.2%      12968 ï¿½  9%  softirqs.CPU68.RCU
>      11035 ï¿½  5%     +13.6%      12533 ï¿½  4%  softirqs.CPU69.RCU
>      11003 ï¿½  5%     +18.9%      13078 ï¿½  8%  softirqs.CPU70.RCU
>      11097 ï¿½  4%     +14.9%      12756 ï¿½  5%  softirqs.CPU71.RCU
