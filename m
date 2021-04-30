Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB36B36F6F8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhD3IOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:14:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:35446 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhD3IOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:14:52 -0400
IronPort-SDR: 6IMK2J5w3kil8tCzz64+cGqzau/fTgu2NMNDL2RpkK0EFPATil4fyOuyLjcxhyBNvQNlgURdsv
 DCpc6YZTlHkw==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="261172218"
X-IronPort-AV: E=Sophos;i="5.82,262,1613462400"; 
   d="scan'208";a="261172218"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 01:14:04 -0700
IronPort-SDR: +bdN6GNT0E1QkWH5/hx+wo9ywdmUJdD8aJ2R+TKkIoHFu7wBSlLtNc03NP6t4FmBhY5rFi47di
 knie9ScJqfEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,262,1613462400"; 
   d="scan'208";a="459262030"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga002.fm.intel.com with ESMTP; 30 Apr 2021 01:14:00 -0700
Date:   Fri, 30 Apr 2021 16:13:59 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     kernel test robot <oliver.sang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [signal]  4bad58ebc8:  will-it-scale.per_thread_ops -3.3%
 regression
Message-ID: <20210430081359.GB79529@shbuild999.sh.intel.com>
References: <20210420030837.GB31773@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420030837.GB31773@xsang-OptiPlex-9020>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Apr 20, 2021 at 11:08:37AM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a -3.3% regression of will-it-scale.per_thread_ops due to commit:
> 
> 
> commit: 4bad58ebc8bc4f20d89cff95417c9b4674769709 ("signal: Allow tasks to cache one sigqueue struct")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
> 
> 
> in testcase: will-it-scale
> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> with following parameters:
> 
> 	nr_task: 100%
> 	mode: thread
> 	test: futex3
> 	cpufreq_governor: performance
> 	ucode: 0x5003006
> 
> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale
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
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
>   gcc-9/performance/x86_64-rhel-8.3/thread/100%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2ap2/futex3/will-it-scale/0x5003006
> 
> commit: 
>   69995ebbb9 ("signal: Hand SIGQUEUE_PREALLOC flag to __sigqueue_alloc()")
>   4bad58ebc8 ("signal: Allow tasks to cache one sigqueue struct")
> 
> 69995ebbb9d37173 4bad58ebc8bc4f20d89cff95417 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>  1.273e+09            -3.3%  1.231e+09        will-it-scale.192.threads
>    6630224            -3.3%    6409738        will-it-scale.per_thread_ops
>  1.273e+09            -3.3%  1.231e+09        will-it-scale.workload

We've double checked this, and it seems to be another case of
the code alignment change caused regression change, just like
the other case we debugged " [genirq]  cbe16f35be:
will-it-scale.per_thread_ops -5.2% regression" 

https://lore.kernel.org/lkml/20210428050758.GB52098@shbuild999.sh.intel.com/

With the same debug patch of forcing function address 64 bytes
aligned, then commit 4bad58ebc8 will bring no change on this case. 

commit 09c60546f04f "./Makefile: add debug option to enable function
aligned on 32 bytes" only forced 32 bytes align, with thinking 64B
align will occupy more code space, and affect iTLB more. Maybe we
should just extend it to 64B align, as it is for debug only anyway. 

Thanks,
Feng









