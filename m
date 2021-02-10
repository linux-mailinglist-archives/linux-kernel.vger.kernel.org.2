Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60ABE31617F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBJIuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:50:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:49084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhBJIuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:50:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612946959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EpdS3XVkl6KKFHjvSJ/AOpz/IvVTHjfZFI6Wya5CEKo=;
        b=aXCi9KJqlbKqtmMvGP7xPsCIfPKkIaj1xTHoJsM2OpDvYtbDA29UOVKjq0kPM5UQjHmcFH
        8lJbP2EqG42reDpb6yRnCdFFUZmOLAUSErUH3abmDZ6CuCWcvb37s8ANKISmHB+LRWd6vk
        GJ0gYRY42rXEIeyGTXajYrsvX0o3RoQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8EACAAFF7;
        Wed, 10 Feb 2021 08:49:19 +0000 (UTC)
Date:   Wed, 10 Feb 2021 09:49:18 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [init/console]  a91bd6223e:  unixbench.score -5.9% regression
Message-ID: <YCOeDrKC7dq9hz6M@alley>
References: <20210209054925.GB13872@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210209054925.GB13872@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

just for record.

On Tue 2021-02-09 13:49:25, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a -5.9% regression of unixbench.score due to commit:
> 
> 
> commit: a91bd6223ecd46addc71ee6fcd432206d39365d2 ("Revert "init/console: Use ttynull as a fallback when there is no console"")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: unixbench
> on test machine: 16 threads Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with 32G memory
> with following parameters:
> 
> 	runtime: 300s
> 	nr_task: 30%
> 	test: dhry2reg
> 	cpufreq_governor: performance
> 	ucode: 0xde
> 
> test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
> test-url: https://github.com/kdlucas/byte-unixbench
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
> compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
>   gcc-9/performance/x86_64-rhel-8.3/30%/debian-10.4-x86_64-20200603.cgz/300s/lkp-cfl-e1/dhry2reg/unixbench/0xde
> 
> commit: 
>   c4cc3b1de3 ("Merge tag 'gcc-plugins-v5.11-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux")
>   a91bd6223e ("Revert "init/console: Use ttynull as a fallback when there is no console"")
> 
> c4cc3b1de31b76f4 a91bd6223ecd46addc71ee6fcd4 
> ---------------- --------------------------- 
>        fail:runs  %reproduction    fail:runs
>            |             |             |    
>           0:4            2%           0:4     perf-profile.children.cycles-pp.error_entry
>          %stddev     %change         %stddev
>              \          |                \  
>      19487            -5.9%      18336        unixbench.score
>  8.875e+10            -5.9%  8.351e+10        unixbench.workload
>       0.50            +0.1        0.61 ±  3%  mpstat.cpu.all.irq%
>      44280 ±  4%     +15.9%      51322 ±  3%  softirqs.CPU0.SCHED
>      29624 ±  3%      +9.6%      32476        vmstat.system.in

>       2207 ±1927%   +3559.5%      80796 ± 18%  sched_debug.cfs_rq:/.spread0.avg
>     135343 ± 38%     +61.1%     218075 ± 16%  sched_debug.cfs_rq:/.spread0.max
>       0.01 ± 31%     +78.3%       0.01 ± 22%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
>       0.01 ±  7%     +22.8%       0.02 ±  2%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       0.02 ± 15%     +27.1%       0.02 ± 11%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.02 ± 44%    +113.3%       0.04 ± 12%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
>       0.02 ± 10%     +56.1%       0.03 ± 25%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
>       0.02 ± 44%    +113.3%       0.04 ± 12%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
>       0.01 ± 11%     +37.5%       0.01 ± 19%  perf-sched.total_sch_delay.average.ms
>       2001          +120.7%       4416 ± 33%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       0.05 ± 54%     +56.5%       0.08 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
>       2001          +120.7%       4416 ± 33%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       0.05 ± 54%     +56.5%       0.08 ±  7%  perf-sched.wait_time.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork

>       0.07 ±173%      +0.2        0.27 ± 21%  perf-profile.children.cycles-pp.io_serial_in
>       0.07 ±173%      +0.2        0.30 ± 21%  perf-profile.children.cycles-pp.serial8250_console_putchar
>       0.07 ±173%      +0.2        0.31 ± 20%  perf-profile.children.cycles-pp.wait_for_xmitr
>       0.08 ±173%      +0.2        0.32 ± 21%  perf-profile.children.cycles-pp.uart_console_write
>       0.08 ±173%      +0.2        0.33 ± 21%  perf-profile.children.cycles-pp.serial8250_console_write
>       0.09 ±173%      +0.2        0.33 ± 22%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
>       0.09 ±173%      +0.2        0.33 ± 22%  perf-profile.children.cycles-pp.sysvec_irq_work
>       0.09 ±173%      +0.2        0.33 ± 22%  perf-profile.children.cycles-pp.__sysvec_irq_work
>       0.09 ±173%      +0.2        0.33 ± 22%  perf-profile.children.cycles-pp.irq_work_run
>       0.09 ±173%      +0.2        0.33 ± 22%  perf-profile.children.cycles-pp.irq_work_single
>       0.09 ±173%      +0.2        0.33 ± 22%  perf-profile.children.cycles-pp.printk
>       0.09 ±173%      +0.2        0.33 ± 22%  perf-profile.children.cycles-pp.vprintk_emit
>       0.09 ±173%      +0.2        0.33 ± 22%  perf-profile.children.cycles-pp.console_unlock
>       0.09 ±173%      +0.3        0.34 ± 24%  perf-profile.children.cycles-pp.irq_work_run_list

The commit fixed regression in registration of console drivers.
A console was likely not registered before and saved some cycles.
But people want consoles ;-)

By other words, this regression is kind of expected.

Best Regards,
Petr
