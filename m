Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F72B367967
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 07:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbhDVFp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 01:45:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:42381 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhDVFp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 01:45:27 -0400
IronPort-SDR: IYklMEvFXfO2vutUziXWiZwutmkfqGae310mWkqDFvAPC7dLlQqz2I1TN8M8gm81qlyH53lMYr
 rUiyZ7PEPiog==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="193711316"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="193711316"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 22:44:53 -0700
IronPort-SDR: sL7ZQfA6xnmM746JsTVT+of1dUh2VWTTpKyrZF9U+R9qQNs/9HAK2WoNWqTT+gGjptLRMz5q39
 0e87yUyLFOrw==
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="617566122"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 22:44:50 -0700
Date:   Thu, 22 Apr 2021 14:02:13 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@intel.com
Subject: Re: [signal]  4bad58ebc8:  will-it-scale.per_thread_ops -3.3%
 regression
Message-ID: <20210422060213.GC31382@xsang-OptiPlex-9020>
References: <20210420030837.GB31773@xsang-OptiPlex-9020>
 <87bla8rehx.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bla8rehx.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Thomas Gleixner,

On Tue, Apr 20, 2021 at 08:35:06PM +0200, Thomas Gleixner wrote:
> On Tue, Apr 20 2021 at 11:08, kernel test robot wrote:
> > FYI, we noticed a -3.3% regression of will-it-scale.per_thread_ops due to commit:
> >
> > commit: 4bad58ebc8bc4f20d89cff95417c9b4674769709 ("signal: Allow tasks to cache one sigqueue struct")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
> >
> > in testcase: will-it-scale
> > on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> > with following parameters:
> >
> > 	nr_task: 100%
> > 	mode: thread
> > 	test: futex3
> > 	cpufreq_governor: performance
> > 	ucode: 0x5003006
> >
> > test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> > test-url: https://github.com/antonblanchard/will-it-scale
> > commit: 
> >   69995ebbb9 ("signal: Hand SIGQUEUE_PREALLOC flag to __sigqueue_alloc()")
> >   4bad58ebc8 ("signal: Allow tasks to cache one sigqueue struct")
> >
> > 69995ebbb9d37173 4bad58ebc8bc4f20d89cff95417 
> > ---------------- --------------------------- 
> >          %stddev     %change         %stddev
> >              \          |                \  
> >  1.273e+09            -3.3%  1.231e+09        will-it-scale.192.threads
> >    6630224            -3.3%    6409738        will-it-scale.per_thread_ops
> >  1.273e+09            -3.3%  1.231e+09        will-it-scale.workload
> >       1638 ±  3%      -7.8%       1510 ±  5%  sched_debug.cfs_rq:/.runnable_avg.max
> >     297.83 ± 68%   +1747.6%       5502 ±152%  interrupts.33:PCI-MSI.524291-edge.eth0-TxRx-2
> >     297.83 ± 68%   +1747.6%       5502 ±152%  interrupts.CPU12.33:PCI-MSI.524291-edge.eth0-TxRx-2
> 
> This change is definitely not causing more network traffic
> 
> >       8200           -33.4%       5459 ± 35%  interrupts.CPU27.NMI:Non-maskable_interrupts
> >       8200           -33.4%       5459 ± 35%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
> >       8199           -33.4%       5459 ± 35%  interrupts.CPU28.NMI:Non-maskable_interrupts
> >       8199           -33.4%       5459 ± 35%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
> >       6148 ± 33%     -11.2%       5459 ± 35%  interrupts.CPU29.NMI:Non-maskable_interrupts
> >       6148 ± 33%     -11.2%       5459 ± 35%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
> >       4287 ±  8%     +33.6%       5730 ± 15%  interrupts.CPU49.CAL:Function_call_interrupts
> >       6356 ± 19%     +49.6%       9509 ± 19%  interrupts.CPU97.CAL:Function_call_interrupts
> 
> Neither does it increase the number of function calls
> 
> >     407730 ±  8%     +37.5%     560565 ±  7%  perf-stat.i.dTLB-load-misses
> >     415959 ±  8%     +40.4%     583928 ±  7%  perf-stat.ps.dTLB-load-misses
> 
> And this massive increase does not make sense either.
> 
> Confused.

FYI.
we re-test this, and confirmed the regression persistent. still:

69995ebbb9d37173 4bad58ebc8bc4f20d89cff95417
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
 1.271e+09            -3.3%  1.229e+09        will-it-scale.192.threads
   6620228            -3.3%    6401749        will-it-scale.per_thread_ops
 1.271e+09            -3.3%  1.229e+09        will-it-scale.workload

both fbc and parent use identical config, as attached in original report.

data for 4bad58ebc8bc4f20d89cff95417:
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json:  "will-it-scale.per_thread_ops": [
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6404491,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6421116,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6402763,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6403483,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6412066,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6414511,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6395917,  <------ new 14 runs
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6396872,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6400830,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6408883,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6403844,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6405911,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6390766,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6394523,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6394594,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6399547,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6402487,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6394673,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6400717,
4bad58ebc8bc4f20d89cff95417c9b4674769709/matrix.json-    6386997

data for parent (69995ebbb9d37173):
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json:  "will-it-scale.per_thread_ops": [
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6640509,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6630326,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6633025,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6625355,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6623274,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6628858,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6614380,   <----- new 14 runs
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6607324,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6613340,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6610083,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6616290,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6616934,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6618978,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6627108,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6609973,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6618440,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6617191,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6615858,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6615761,
69995ebbb9d3717306a165db88a1292b63f77a37/matrix.json-    6621558

> 
> Thanks,
> 
>         tglx
