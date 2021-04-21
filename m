Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45EF3663DE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 05:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhDUDHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 23:07:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:58265 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234023AbhDUDHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 23:07:53 -0400
IronPort-SDR: qaFgArJ1t7GyY0vuq6is91ig/CiYSU8J9qdywF+Ziw931PUVnEfOsJ8FEgGShrcVwh6LkTfNSu
 sWszzKVfxfTg==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="175737446"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="175737446"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 20:07:21 -0700
IronPort-SDR: ZKAOja78FcD0QDG4AxQWO21EnnlzsiNlXJyJam8kPhXAv52d6LRcPoVz6nJUa5aEVSb4wCylM8
 0QhyMRDv/pww==
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="420817390"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 20:07:16 -0700
Date:   Wed, 21 Apr 2021 11:20:22 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
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
Subject: Re: [sched/fair]  38ac256d1c:  stress-ng.vm-segv.ops_per_sec -13.8%
 regression
Message-ID: <20210421032022.GA13430@xsang-OptiPlex-9020>
References: <20210414052151.GB21236@xsang-OptiPlex-9020>
 <87im4on5u5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im4on5u5.mognet@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Valentin Schneider,

On Wed, Apr 14, 2021 at 06:17:38PM +0100, Valentin Schneider wrote:
> On 14/04/21 13:21, kernel test robot wrote:
> > Greeting,
> >
> > FYI, we noticed a -13.8% regression of stress-ng.vm-segv.ops_per_sec due to commit:
> >
> >
> > commit: 38ac256d1c3e6b5155071ed7ba87db50a40a4b58 ("[PATCH v5 1/3] sched/fair: Ignore percpu threads for imbalance pulls")
> > url: https://github.com/0day-ci/linux/commits/Valentin-Schneider/sched-fair-load-balance-vs-capacity-margins/20210408-060830
> > base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 0a2b65c03e9b47493e1442bf9c84badc60d9bffb
> >
> > in testcase: stress-ng
> > on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
> > with following parameters:
> >
> >       nr_threads: 10%
> >       disk: 1HDD
> >       testtime: 60s
> >       fs: ext4
> >       class: os
> >       test: vm-segv
> >       cpufreq_governor: performance
> >       ucode: 0x5003006
> >
> >
> 
> That's almost exactly the same result as [1], which is somewhat annoying
> for me because I wasn't able to reproduce those results back then. Save
> from scrounging the exact same machine to try this out, I'm not sure what's
> the best way forward. I guess I can re-run the workload on whatever
> machines I have and try to spot any potentially problematic pattern in the
> trace...

what's the machine model you used upon which the regression cannot be reproduced?
we could check if we have similar model then re-check on the our machine.

BTW, we supplied perf data in original report, not sure if they are helpful?
or do you have suggestion which kind of data will be more helpful to you?
we will continuously improve our report based on suggestions from community.
Thanks a lot!

> 
> [1]: http://lore.kernel.org/r/20210223023004.GB25487@xsang-OptiPlex-9020
