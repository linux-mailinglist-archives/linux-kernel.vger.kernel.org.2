Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C257635F9A9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhDNRSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:18:11 -0400
Received: from foss.arm.com ([217.140.110.172]:59278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233753AbhDNRSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:18:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CF5811B3;
        Wed, 14 Apr 2021 10:17:45 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E0033F73B;
        Wed, 14 Apr 2021 10:17:43 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     kernel test robot <oliver.sang@intel.com>
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
In-Reply-To: <20210414052151.GB21236@xsang-OptiPlex-9020>
References: <20210414052151.GB21236@xsang-OptiPlex-9020>
Date:   Wed, 14 Apr 2021 18:17:38 +0100
Message-ID: <87im4on5u5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/21 13:21, kernel test robot wrote:
> Greeting,
>
> FYI, we noticed a -13.8% regression of stress-ng.vm-segv.ops_per_sec due to commit:
>
>
> commit: 38ac256d1c3e6b5155071ed7ba87db50a40a4b58 ("[PATCH v5 1/3] sched/fair: Ignore percpu threads for imbalance pulls")
> url: https://github.com/0day-ci/linux/commits/Valentin-Schneider/sched-fair-load-balance-vs-capacity-margins/20210408-060830
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 0a2b65c03e9b47493e1442bf9c84badc60d9bffb
>
> in testcase: stress-ng
> on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
> with following parameters:
>
>       nr_threads: 10%
>       disk: 1HDD
>       testtime: 60s
>       fs: ext4
>       class: os
>       test: vm-segv
>       cpufreq_governor: performance
>       ucode: 0x5003006
>
>

That's almost exactly the same result as [1], which is somewhat annoying
for me because I wasn't able to reproduce those results back then. Save
from scrounging the exact same machine to try this out, I'm not sure what's
the best way forward. I guess I can re-run the workload on whatever
machines I have and try to spot any potentially problematic pattern in the
trace...

[1]: http://lore.kernel.org/r/20210223023004.GB25487@xsang-OptiPlex-9020
