Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7146136C19D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 11:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhD0JVZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Apr 2021 05:21:25 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3534 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhD0JVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 05:21:19 -0400
Received: from dggeml765-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FTx531mlkzRgYl;
        Tue, 27 Apr 2021 17:18:15 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 dggeml765-chm.china.huawei.com (10.1.199.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 27 Apr 2021 17:20:31 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi759-chm.china.huawei.com (10.1.198.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 27 Apr 2021 17:20:31 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Tue, 27 Apr 2021 17:20:31 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     kernel test robot <oliver.sang@intel.com>
CC:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>
Subject: RE: [genirq]  cbe16f35be:  will-it-scale.per_thread_ops -5.2%
 regression
Thread-Topic: [genirq]  cbe16f35be:  will-it-scale.per_thread_ops -5.2%
 regression
Thread-Index: AQHXO0FhMjEcPgOF502NS90b4qVMhqrIFBXg
Date:   Tue, 27 Apr 2021 09:20:31 +0000
Message-ID: <de61a3b5b6b1467ea7d377377c443572@hisilicon.com>
References: <20210427090013.GG32408@xsang-OptiPlex-9020>
In-Reply-To: <20210427090013.GG32408@xsang-OptiPlex-9020>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.183]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: kernel test robot [mailto:oliver.sang@intel.com]
> Sent: Tuesday, April 27, 2021 9:00 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Ingo Molnar <mingo@kernel.org>; Thomas Gleixner <tglx@linutronix.de>; LKML
> <linux-kernel@vger.kernel.org>; lkp@lists.01.org; lkp@intel.com;
> ying.huang@intel.com; feng.tang@intel.com; zhengjun.xing@intel.com
> Subject: [genirq] cbe16f35be: will-it-scale.per_thread_ops -5.2% regression
> 
> 
> Greeting,
> 
> FYI, we noticed a -5.2% regression of will-it-scale.per_thread_ops due to
> commit:
> 
> 
> commit: cbe16f35bee6880becca6f20d2ebf6b457148552 ("genirq: Add IRQF_NO_AUTOEN
> for request_irq/nmi()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 

Might be relevant. Can't figure out the relation between getppid and
request_irq().

Thanks
Barry

> 
> in testcase: will-it-scale
> on test machine: 88 threads Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G
> memory
> with following parameters:
> 
> 	nr_task: 100%
> 	mode: thread
> 	test: getppid1
> 	cpufreq_governor: performance
> 	ucode: 0x5003006
> 
> test-description: Will It Scale takes a testcase and runs it from 1 through
> to n parallel copies to see if the testcase will scale. It builds both a process
> and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> Details are as below:
> --------------------------------------------------------------------------
> ------------------------>
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install                job.yaml  # job file is attached in this
> email
>         bin/lkp split-job --compatible job.yaml
>         bin/lkp run                    compatible-job.yaml
> 
> ==========================================================================
> ===============
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/test
> case/ucode:
> 
> gcc-9/performance/x86_64-rhel-8.3/thread/100%/debian-10.4-x86_64-20200603.
> cgz/lkp-csl-2sp9/getppid1/will-it-scale/0x5003006
> 
> commit:
>   v5.12-rc2
>   cbe16f35be ("genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()")
> 
>        v5.12-rc2 cbe16f35bee6880becca6f20d2e
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>  7.408e+08            -5.2%  7.021e+08        will-it-scale.88.threads
>    8417726            -5.2%    7978644        will-it-scale.per_thread_ops
>  7.408e+08            -5.2%  7.021e+08        will-it-scale.workload
>  3.851e+10            -5.2%   3.65e+10        perf-stat.i.branch-instructions
>  1.839e+08            -4.2%  1.763e+08        perf-stat.i.branch-misses
>       1.39            +5.3%       1.46        perf-stat.i.cpi
>  5.988e+10            -5.2%  5.674e+10        perf-stat.i.dTLB-loads
>  4.139e+10            -5.2%  3.922e+10        perf-stat.i.dTLB-stores
>  2.239e+08 ±  3%     -14.6%  1.913e+08 ±  4%  perf-stat.i.iTLB-load-misses
>  1.741e+11            -5.2%   1.65e+11        perf-stat.i.instructions
>     794.20 ±  2%     +10.7%     879.14 ±  4%
> perf-stat.i.instructions-per-iTLB-miss
>       0.72            -5.0%       0.68        perf-stat.i.ipc
>       1588            -5.2%       1505        perf-stat.i.metric.M/sec
>       1.39            +5.4%       1.47        perf-stat.overall.cpi
>       0.00            +0.0        0.00
> perf-stat.overall.dTLB-store-miss-rate%
>     778.31 ±  3%     +11.1%     864.35 ±  4%
> perf-stat.overall.instructions-per-iTLB-miss
>       0.72            -5.1%       0.68        perf-stat.overall.ipc
>  3.838e+10            -5.2%  3.638e+10        perf-stat.ps.branch-instructions
>  1.833e+08            -4.2%  1.757e+08        perf-stat.ps.branch-misses
>  5.968e+10            -5.2%  5.655e+10        perf-stat.ps.dTLB-loads
>  4.125e+10            -5.2%  3.909e+10        perf-stat.ps.dTLB-stores
>  2.231e+08 ±  3%     -14.6%  1.907e+08 ±  4%  perf-stat.ps.iTLB-load-misses
>  1.735e+11            -5.2%  1.645e+11        perf-stat.ps.instructions
>  5.243e+13            -5.2%  4.971e+13        perf-stat.total.instructions
>      43.20            -2.3       40.87
> perf-profile.calltrace.cycles-pp.__entry_text_start.getppid
>       9.09            -0.4        8.65 ±  2%
> perf-profile.calltrace.cycles-pp.testcase
>       8.01            -0.3        7.66
> perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.getppid
>       2.93            -0.2        2.73
> perf-profile.calltrace.cycles-pp.syscall_enter_from_user_mode.do_syscall_6
> 4.entry_SYSCALL_64_after_hwframe.getppid
>       3.02            -0.2        2.83
> perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.getppid
>       2.52 ±  3%      +0.7        3.23 ±  9%
> perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode_prepare.syscall
> _exit_to_user_mode.entry_SYSCALL_64_after_hwframe.getppid
>      18.24            +1.1       19.29
> perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwfr
> ame.getppid
>      13.33            +1.1       14.46 ±  2%
> perf-profile.calltrace.cycles-pp.__x64_sys_getppid.do_syscall_64.entry_SYS
> CALL_64_after_hwframe.getppid
>       1.94 ±  2%      +1.7        3.62 ±  3%
> perf-profile.calltrace.cycles-pp.rcu_nocb_flush_deferred_wakeup.exit_to_us
> er_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.g
> etppid
>       7.47 ±  2%      +1.8        9.25
> perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to
> _user_mode.entry_SYSCALL_64_after_hwframe.getppid
>      11.51 ±  2%      +2.3       13.81 ±  2%
> perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_6
> 4_after_hwframe.getppid
>      39.05            +3.1       42.17
> perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getppid
>      27.84            -1.5       26.36
> perf-profile.children.cycles-pp.__entry_text_start
>      23.40            -1.2       22.22
> perf-profile.children.cycles-pp.syscall_return_via_sysret
>       2.97            -0.2        2.76
> perf-profile.children.cycles-pp.syscall_enter_from_user_mode
>       3.23            -0.2        3.03
> perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
>       0.41 ±  2%      -0.0        0.37 ±  2%
> perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
>       2.56 ±  3%      +0.7        3.25 ±  7%
> perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
>      13.88            +1.2       15.05 ±  2%
> perf-profile.children.cycles-pp.__x64_sys_getppid
>       2.02 ±  2%      +1.6        3.67 ±  3%
> perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
>       7.86            +1.7        9.60
> perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>      12.71            +2.3       15.04 ±  2%
> perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>      39.65            +3.1       42.77
> perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      23.19            -1.2       22.01
> perf-profile.self.cycles-pp.syscall_return_via_sysret
>      19.57            -1.1       18.50        perf-profile.self.cycles-pp.getppid
>      12.47            -0.6       11.83
> perf-profile.self.cycles-pp.__entry_text_start
>       8.60            -0.2        8.36
> perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>       3.22            -0.2        3.02
> perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
>       2.52            -0.2        2.35
> perf-profile.self.cycles-pp.syscall_enter_from_user_mode
>       3.58            +0.4        3.95
> perf-profile.self.cycles-pp.__x64_sys_getppid
>       2.12 ±  3%      +0.6        2.74 ±  8%
> perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
>       1.72 ±  2%      +1.7        3.41 ±  3%
> perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
> 
> 
> 
>                              will-it-scale.per_thread_ops
> 
>   8.8e+06
> +-----------------------------------------------------------------+
>   8.7e+06 |-+        .+.                                                    |
>           |        .+   +                                                   |
>   8.6e+06 |.+.+.+.+      +  .+. .+.+. .+.+. .+.+.+.+.                       |
>   8.5e+06 |-+             ++   +     +     +         +.                     |
>           |                                            +.+.++.+.+.+.+.+.+.+.|
>   8.4e+06 |-+                                                               |
>   8.3e+06 |-O O O O O O   OO                                                |
>   8.2e+06 |-+           O    O                                              |
>           |                                                                 |
>   8.1e+06 |-+                                                               |
>     8e+06 |-+                  O O O O O O O O O O   O      O       O O     |
>           |                                        O          O O O         |
>   7.9e+06 |-+                                          O O O                |
>   7.8e+06
> +-----------------------------------------------------------------+
> 
> 
> [*] bisect-good sample
> [O] bisect-bad  sample
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel
> Corporation
> 
> Thanks,
> Oliver Sang

