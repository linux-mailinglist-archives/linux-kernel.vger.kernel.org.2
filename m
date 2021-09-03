Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2D73FFB3F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 09:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347439AbhICHok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 03:44:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:54329 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234804AbhICHoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 03:44:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="241639711"
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="241639711"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 00:43:40 -0700
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="533772890"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.90]) ([10.238.4.90])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 00:43:38 -0700
Subject: Re: [xfs] 2bf1ec0ff0: stress-ng.mknod.ops_per_sec -45.4% regression
To:     kernel test robot <oliver.sang@intel.com>,
        Dave Chinner <dchinner@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com
References: <20210804143800.GA21457@xsang-OptiPlex-9020>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <a149d14e-48e0-bad9-4283-e560f03a941f@linux.intel.com>
Date:   Fri, 3 Sep 2021 15:43:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210804143800.GA21457@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

    Do you have time to look at this? Thanks.

On 8/4/2021 10:38 PM, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a -45.4% regression of stress-ng.mknod.ops_per_sec due to commit:
> 
> 
> commit: 2bf1ec0ff067ff8f692d261b29c713f3583f7e2a ("xfs: log forces imply data device cache flushes")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: stress-ng
> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory
> with following parameters:
> 
> 	nr_threads: 10%
> 	disk: 1HDD
> 	testtime: 60s
> 	fs: xfs
> 	class: filesystem
> 	test: mknod
> 	cpufreq_governor: performance
> 	ucode: 0x5003006
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
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp install                job.yaml  # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml  # generate the yaml file for lkp run
>          bin/lkp run                    generated-yaml-file
> 
> =========================================================================================
> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
>    filesystem/gcc-9/performance/1HDD/xfs/x86_64-rhel-8.3/10%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp7/mknod/stress-ng/60s/0x5003006
> 
> commit:
>    45eddb4140 ("xfs: factor out forced iclog flushes")
>    2bf1ec0ff0 ("xfs: log forces imply data device cache flushes")
> 
> 45eddb414047c366 2bf1ec0ff067ff8f692d261b29c
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>       87135           -45.4%      47612        stress-ng.mknod.ops
>        1451           -45.4%     793.24        stress-ng.mknod.ops_per_sec
>       23.00 ±  7%     -51.4%      11.17 ± 12%  stress-ng.time.percent_of_cpu_this_job_got
>       13.80 ±  7%     -50.7%       6.80 ±  8%  stress-ng.time.system_time
>      211458 ±  2%     -62.4%      79605 ± 14%  stress-ng.time.voluntary_context_switches
>        0.30 ±  2%      -0.1        0.18        mpstat.cpu.all.sys%
>       13993 ±  2%     -38.1%       8659        softirqs.BLOCK
>       27747            -2.3%      27103        proc-vmstat.nr_slab_reclaimable
>       76223 ±  3%     -57.3%      32548 ±  5%  proc-vmstat.pgpgout
>        1170 ±  3%     -57.3%     500.17 ±  5%  vmstat.io.bo
>       10752           -47.7%       5624 ±  6%  vmstat.system.cs
>       32820           -34.5%      21499        slabinfo.kmalloc-rcl-64.active_objs
>      512.67           -34.6%     335.50        slabinfo.kmalloc-rcl-64.active_slabs
>       32836           -34.5%      21508        slabinfo.kmalloc-rcl-64.num_objs
>      512.67           -34.6%     335.50        slabinfo.kmalloc-rcl-64.num_slabs
>       24913 ±  2%     -42.8%      14251        interrupts.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
>       71844 ±  6%     -19.9%      57564 ±  3%  interrupts.CAL:Function_call_interrupts
>      206.50 ± 37%     -42.9%     118.00 ± 41%  interrupts.CPU1.NMI:Non-maskable_interrupts
>      206.50 ± 37%     -42.9%     118.00 ± 41%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
>      173.17 ± 26%     -31.7%     118.33 ± 38%  interrupts.CPU2.NMI:Non-maskable_interrupts
>      173.17 ± 26%     -31.7%     118.33 ± 38%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
>      189.83 ± 34%     -40.6%     112.83 ± 25%  interrupts.CPU49.NMI:Non-maskable_interrupts
>      189.83 ± 34%     -40.6%     112.83 ± 25%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
>      181.67 ± 25%     -38.3%     112.17 ± 24%  interrupts.CPU50.NMI:Non-maskable_interrupts
>      181.67 ± 25%     -38.3%     112.17 ± 24%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
>        1895 ± 16%     -32.8%       1274 ± 20%  interrupts.RES:Rescheduling_interrupts
>   3.127e+08 ±  5%     -12.2%  2.746e+08 ±  3%  perf-stat.i.branch-instructions
>       10683           -49.8%       5364 ±  6%  perf-stat.i.context-switches
>   3.866e+08 ±  4%     -14.2%  3.318e+08 ±  3%  perf-stat.i.dTLB-loads
>   1.949e+08 ±  3%     -14.7%  1.662e+08 ±  3%  perf-stat.i.dTLB-stores
>   1.538e+09 ±  5%     -12.4%  1.348e+09 ±  3%  perf-stat.i.instructions
>        9.31 ±  4%     -13.6%       8.04 ±  3%  perf-stat.i.metric.M/sec
>      127426 ± 14%     -32.6%      85864 ±  9%  perf-stat.i.node-load-misses
>   3.078e+08 ±  5%     -12.2%  2.702e+08 ±  3%  perf-stat.ps.branch-instructions
>       10512           -49.8%       5279 ±  6%  perf-stat.ps.context-switches
>   3.805e+08 ±  4%     -14.2%  3.265e+08 ±  3%  perf-stat.ps.dTLB-loads
>   1.918e+08 ±  3%     -14.7%  1.635e+08 ±  3%  perf-stat.ps.dTLB-stores
>   1.514e+09 ±  5%     -12.4%  1.327e+09 ±  3%  perf-stat.ps.instructions
>      125399 ± 14%     -32.6%      84480 ±  9%  perf-stat.ps.node-load-misses
>   9.563e+10 ±  6%     -12.3%  8.383e+10 ±  3%  perf-stat.total.instructions
>        8.31 ± 20%      -3.9        4.45 ± 25%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>        8.30 ± 20%      -3.9        4.45 ± 25%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        2.35 ± 19%      -1.6        0.75 ± 25%  perf-profile.calltrace.cycles-pp.__x64_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        2.35 ± 19%      -1.6        0.75 ± 25%  perf-profile.calltrace.cycles-pp.ksys_sync.__x64_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        2.08 ± 19%      -1.6        0.50 ± 72%  perf-profile.calltrace.cycles-pp.iterate_supers.ksys_sync.__x64_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        1.85 ± 25%      -0.7        1.14 ± 31%  perf-profile.calltrace.cycles-pp.do_mknodat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        1.04 ± 27%      -0.7        0.36 ±106%  perf-profile.calltrace.cycles-pp.xfs_inactive_ifree.xfs_inactive.xfs_fs_destroy_inode.destroy_inode.do_unlinkat
>        1.08 ± 27%      -0.6        0.46 ± 77%  perf-profile.calltrace.cycles-pp.destroy_inode.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        1.05 ± 27%      -0.6        0.45 ± 77%  perf-profile.calltrace.cycles-pp.xfs_fs_destroy_inode.destroy_inode.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        1.04 ± 27%      -0.6        0.44 ± 78%  perf-profile.calltrace.cycles-pp.xfs_inactive.xfs_fs_destroy_inode.destroy_inode.do_unlinkat.do_syscall_64
>        0.89 ± 17%      -0.3        0.58 ±  9%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
>        1.21 ±  8%      +0.2        1.45 ±  7%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
>        8.13 ±  9%      +2.0       10.16 ±  6%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>        2.35 ± 19%      -1.6        0.75 ± 25%  perf-profile.children.cycles-pp.__x64_sys_sync
>        2.35 ± 19%      -1.6        0.75 ± 25%  perf-profile.children.cycles-pp.ksys_sync
>        2.09 ± 19%      -1.4        0.65 ± 25%  perf-profile.children.cycles-pp.iterate_supers
>        2.25 ± 18%      -1.1        1.14 ± 26%  perf-profile.children.cycles-pp._raw_spin_lock
>        1.40 ± 25%      -1.1        0.31 ± 54%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>        1.85 ± 25%      -0.7        1.14 ± 31%  perf-profile.children.cycles-pp.do_mknodat
>        1.08 ± 27%      -0.5        0.55 ± 43%  perf-profile.children.cycles-pp.destroy_inode
>        1.05 ± 27%      -0.5        0.54 ± 42%  perf-profile.children.cycles-pp.xfs_fs_destroy_inode
>        1.04 ± 27%      -0.5        0.54 ± 43%  perf-profile.children.cycles-pp.xfs_inactive
>        1.04 ± 27%      -0.5        0.53 ± 44%  perf-profile.children.cycles-pp.xfs_inactive_ifree
>        0.93 ± 21%      -0.5        0.44 ± 24%  perf-profile.children.cycles-pp.__schedule
>        0.49 ± 25%      -0.4        0.11 ± 76%  perf-profile.children.cycles-pp.pick_next_task_fair
>        1.05 ± 20%      -0.4        0.69 ± 13%  perf-profile.children.cycles-pp.find_busiest_group
>        0.66 ± 19%      -0.3        0.32 ± 30%  perf-profile.children.cycles-pp.schedule
>        1.00 ± 20%      -0.3        0.65 ± 13%  perf-profile.children.cycles-pp.update_sd_lb_stats
>        0.60 ± 20%      -0.3        0.29 ± 31%  perf-profile.children.cycles-pp.xfs_ifree
>        0.89 ± 17%      -0.3        0.58 ±  9%  perf-profile.children.cycles-pp.worker_thread
>        0.44 ± 26%      -0.3        0.16 ± 45%  perf-profile.children.cycles-pp.newidle_balance
>        0.49 ± 39%      -0.3        0.22 ± 35%  perf-profile.children.cycles-pp.xfs_fs_sync_fs
>        0.40 ± 49%      -0.2        0.17 ± 29%  perf-profile.children.cycles-pp.xfs_log_force
>        0.31 ± 29%      -0.2        0.11 ± 56%  perf-profile.children.cycles-pp.schedule_timeout
>        0.24 ± 60%      -0.2        0.06 ± 50%  perf-profile.children.cycles-pp.xfs_inobt_get_rec
>        0.38 ± 19%      -0.2        0.21 ± 30%  perf-profile.children.cycles-pp.xfs_btree_lookup
>        0.42 ± 14%      -0.2        0.26 ± 35%  perf-profile.children.cycles-pp.xfs_check_agi_freecount
>        0.30 ± 27%      -0.2        0.14 ± 37%  perf-profile.children.cycles-pp.xfs_btree_lookup_get_block
>        0.25 ± 30%      -0.1        0.10 ± 39%  perf-profile.children.cycles-pp.iterate_bdevs
>        0.33 ± 28%      -0.1        0.19 ± 20%  perf-profile.children.cycles-pp.try_to_wake_up
>        0.26 ± 31%      -0.1        0.13 ± 23%  perf-profile.children.cycles-pp.schedule_idle
>        0.16 ± 36%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.__down
>        0.16 ± 35%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.xfs_buf_lock
>        0.16 ± 36%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.down
>        0.21 ± 39%      -0.1        0.09 ± 52%  perf-profile.children.cycles-pp.xfs_iunlink_remove
>        0.19 ± 28%      -0.1        0.08 ± 43%  perf-profile.children.cycles-pp.xfs_buf_item_release
>        0.21 ± 33%      -0.1        0.10 ± 35%  perf-profile.children.cycles-pp.xfs_difree_inobt
>        0.14 ± 16%      -0.1        0.04 ±104%  perf-profile.children.cycles-pp._xfs_trans_bjoin
>        0.18 ± 30%      -0.1        0.08 ± 80%  perf-profile.children.cycles-pp.wait_for_completion
>        0.15 ± 27%      -0.1        0.06 ± 53%  perf-profile.children.cycles-pp.up
>        0.15 ± 33%      -0.1        0.06 ± 81%  perf-profile.children.cycles-pp.xfs_difree_finobt
>        0.15 ± 27%      -0.1        0.08 ± 19%  perf-profile.children.cycles-pp.xfs_trans_alloc
>        0.10 ± 29%      -0.1        0.04 ± 72%  perf-profile.children.cycles-pp.xfs_log_reserve
>        0.04 ± 77%      +0.1        0.10 ± 34%  perf-profile.children.cycles-pp.balance_fair
>        0.05 ± 79%      +0.1        0.15 ± 31%  perf-profile.children.cycles-pp.smpboot_thread_fn
>        0.58 ± 16%      +0.1        0.72 ± 11%  perf-profile.children.cycles-pp.update_rq_clock
>        1.24 ±  8%      +0.3        1.52 ±  4%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
>        8.31 ±  9%      +2.1       10.40 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>        1.30 ± 18%      -1.0        0.30 ± 54%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>        0.75 ± 21%      -0.3        0.44 ± 20%  perf-profile.self.cycles-pp.__percpu_counter_sum
>        0.43 ± 25%      -0.3        0.16 ± 45%  perf-profile.self.cycles-pp.down_read
>        0.72 ± 13%      -0.2        0.47 ± 12%  perf-profile.self.cycles-pp.update_sd_lb_stats
>        0.35 ± 15%      +0.1        0.43 ± 13%  perf-profile.self.cycles-pp.irqtime_account_irq
>        0.08 ± 60%      +0.1        0.16 ± 18%  perf-profile.self.cycles-pp.timerqueue_del
> 
> 
>                                                                                  
>                             stress-ng.time.system_time
>                                                                                  
>    20 +----------------------------------------------------------------------+
>       |            +                                                         |
>    18 |-+     +   ::                                       .+                |
>       |      : :  ::                   +..               .+  :               |
>    16 |-+    : : :  :                 :       +.    +   +    :     +         |
>       |:    +   ::  :                 :   +  :  +  : : :      :  .. +        |
>    14 |:+  +    +   :         .+.   .+     + :   + : : :      +.+    +.   .+.|
>       | +.+         :  +.+.+.+   +.+        +     +   +                +.+   |
>    12 |-+           :  :                                                     |
>       |              ::                                                      |
>    10 |-+            ::                                                      |
>       |              +                                                       |
>     8 |-+                    O   O   O      O   O       O O                  |
>       | O O     O    O     O   O       O      O   O O       O                |
>     6 +----------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                     stress-ng.time.percent_of_cpu_this_job_got
>                                                                                  
>    35 +----------------------------------------------------------------------+
>       |                                                                      |
>       |       +    +                                        +                |
>    30 |-+     ::  ::                                       +:                |
>       |      : :  ::                   +..    +     +   +.+  :     +         |
>       |:     :  ::  :                 :      : +   : : :     :   .. :        |
>    25 |:+  .+   +   :                 :   +. :  +. : : :      :.+   :        |
>       | +.+         :  +.+.+.+.+.+.+.+      +     +   +       +      +.+.+.+.|
>    20 |-+           :  :                                                     |
>       |             : :                                                      |
>       |              ::                                                      |
>    15 |-+            :                                                       |
>       |              +       O   O   O      O   O       O O                  |
>       | O O O O O  O O O O O   O   O   O  O   O   O O       O                |
>    10 +----------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                        stress-ng.time.voluntary_context_switches
>                                                                                  
>    260000 +------------------------------------------------------------------+
>    240000 |-+     +                                                          |
>           |      + :  +.                  +                 .+. .+.          |
>    220000 |++.+.+  : +  +.   .+.         + + +.+. .+.+   +.+   +   +. .+. .+.|
>    200000 |-+       +     +.+   +. .+. .+   +    +    + +            +   +   |
>           |                       +   +                +                     |
>    180000 |-+                                                                |
>    160000 |-+                                                                |
>    140000 |-+                                                                |
>           |                                                                  |
>    120000 |-+           O                                                    |
>    100000 |-O   O         O O                          O                     |
>           |       O   O                   O    O   O       O   O             |
>     80000 |-+ O               O O O   O O   OO   O   O   O   O               |
>     60000 +------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                                   stress-ng.mknod.ops
>                                                                                  
>    95000 +-------------------------------------------------------------------+
>    90000 |-+    .+. .+.                                     .+. .+.          |
>          |.+.+.+   +   +.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+   +   +. .+.+.+.|
>    85000 |-+                                                         +       |
>    80000 |-+                                                                 |
>          |                                                                   |
>    75000 |-+                                                                 |
>    70000 |-+                                                                 |
>    65000 |-+                                                                 |
>          |                                                                   |
>    60000 |-+                                                                 |
>    55000 |-+                                                                 |
>          |                                                                   |
>    50000 |-O O O O O O O O O O O O O O O O O O O O O O O O O   O O           |
>    45000 +-------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                              stress-ng.mknod.ops_per_sec
>                                                                                  
>    1600 +--------------------------------------------------------------------+
>         |      .+.                                          .+. .+           |
>    1500 |.+.+.+   +.+.+.+.+.+. .+.+.+.+.+..+.+.+.+.+.+.+.+.+   +  +   .+.+.+.|
>    1400 |-+                   +                                    +.+       |
>         |                                                                    |
>    1300 |-+                                                                  |
>    1200 |-+                                                                  |
>         |                                                                    |
>    1100 |-+                                                                  |
>    1000 |-+                                                                  |
>         |                                                                    |
>     900 |-+                                                                  |
>     800 |-+   O O   O O O     O O       O      O O     O O O     O           |
>         | O O     O       O O     O O O    O O     O O       O O             |
>     700 +--------------------------------------------------------------------+
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
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 

-- 
Zhengjun Xing
