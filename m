Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A017B4023B4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 08:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbhIGG5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 02:57:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:50580 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234656AbhIGG5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 02:57:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="220145648"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="yaml'?scan'208";a="220145648"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 23:56:10 -0700
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="yaml'?scan'208";a="537802694"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 23:56:02 -0700
Date:   Tue, 7 Sep 2021 15:13:33 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com
Subject: [mm/memcg]  5387c90490:  will-it-scale.per_process_ops -21.3%
 regression
Message-ID: <20210907071333.GE7504@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="o0ZfoUVt4BxPQnbU"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Greeting,

FYI, we noticed a -21.3% regression of will-it-scale.per_process_ops due to commit:


commit: 5387c90490f7f42df3209154ca955a453ee01b41 ("mm/memcg: improve refill_obj_stock() performance")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: will-it-scale
on test machine: 144 threads 4 sockets Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory
with following parameters:

	nr_task: 50%
	mode: process
	test: unix1
	cpufreq_governor: performance
	ucode: 0x16

test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
test-url: https://github.com/antonblanchard/will-it-scale

In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------+
| testcase: change | hackbench: hackbench.throughput 63.3% improvement                    |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                         |
|                  | ipc=socket                                                           |
|                  | iterations=8                                                         |
|                  | mode=threads                                                         |
|                  | nr_threads=50%                                                       |
|                  | ucode=0x4003006                                                      |
+------------------+----------------------------------------------------------------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in this email
        bin/lkp split-job --compatible job.yaml  # generate the yaml file for lkp run
        bin/lkp run                    generated-yaml-file

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/process/50%/debian-10.4-x86_64-20200603.cgz/lkp-hsw-4ex1/unix1/will-it-scale/0x16

commit: 
  68ac5b3c8d ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")
  5387c90490 ("mm/memcg: improve refill_obj_stock() performance")

68ac5b3c8db2fda0 5387c90490f7f42df3209154ca9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  35506465           -21.3%   27928327 ±  7%  will-it-scale.72.processes
    493145           -21.3%     387892 ±  7%  will-it-scale.per_process_ops
  35506465           -21.3%   27928327 ±  7%  will-it-scale.workload
     12193 ±  2%      +5.7%      12883 ±  2%  proc-vmstat.nr_mapped
      1965            +9.2%       2146        vmstat.system.cs
    615.46            -3.6%     593.51        turbostat.PkgWatt
     44.99 ±  2%      +5.7%      47.56 ±  3%  turbostat.RAMWatt
      5276 ± 12%     +15.5%       6094 ± 15%  numa-meminfo.node3.KernelStack
    499829 ±  4%     +47.3%     736092 ± 29%  numa-meminfo.node3.MemUsed
     40145 ±  4%     +24.3%      49894 ±  8%  numa-meminfo.node3.SUnreclaim
     53547 ±  4%     +41.1%      75537 ± 19%  numa-meminfo.node3.Slab
      0.00       +1.3e+107%     133446 ± 99%  numa-meminfo.node3.Unevictable
      5275 ± 12%     +15.5%       6095 ± 14%  numa-vmstat.node3.nr_kernel_stack
      1419 ± 27%     +58.2%       2246 ± 21%  numa-vmstat.node3.nr_mapped
     10035 ±  4%     +24.3%      12473 ±  8%  numa-vmstat.node3.nr_slab_unreclaimable
      0.00       +3.3e+106%      33361 ± 99%  numa-vmstat.node3.nr_unevictable
      0.00       +3.3e+106%      33361 ± 99%  numa-vmstat.node3.nr_zone_unevictable
  10635401 ± 18%  +2.1e+07    32049944 ± 49%  syscalls.sys_close.noise.100%
  28951819 ±  6%    +2e+07    48750876 ± 29%  syscalls.sys_close.noise.2%
  27203005 ±  7%    +2e+07    46937922 ± 30%  syscalls.sys_close.noise.25%
  28880837 ±  6%    +2e+07    48687647 ± 29%  syscalls.sys_close.noise.5%
  21612952 ±  9%    +2e+07    41847414 ± 36%  syscalls.sys_close.noise.50%
  15672133 ± 13%  +2.1e+07    36660699 ± 42%  syscalls.sys_close.noise.75%
 2.586e+08 ± 20%  +1.5e+08   4.057e+08 ± 21%  syscalls.sys_mmap.noise.100%
 3.491e+08 ± 15%  +1.5e+08   4.977e+08 ± 19%  syscalls.sys_mmap.noise.2%
 3.252e+08 ± 16%  +1.5e+08   4.743e+08 ± 20%  syscalls.sys_mmap.noise.25%
 3.483e+08 ± 15%  +1.5e+08   4.968e+08 ± 19%  syscalls.sys_mmap.noise.5%
 2.875e+08 ± 18%  +1.5e+08    4.41e+08 ± 21%  syscalls.sys_mmap.noise.50%
 2.688e+08 ± 20%  +1.5e+08   4.217e+08 ± 21%  syscalls.sys_mmap.noise.75%
    968.00 ± 20%     -18.4%     790.33        interrupts.CPU100.CAL:Function_call_interrupts
     40.20 ± 63%    +161.2%     105.00 ± 48%  interrupts.CPU104.RES:Rescheduling_interrupts
     29.00 ± 77%    +429.9%     153.67 ± 49%  interrupts.CPU117.RES:Rescheduling_interrupts
     79.80 ± 57%     +80.7%     144.17 ± 34%  interrupts.CPU118.RES:Rescheduling_interrupts
      1016 ± 22%     -20.8%     804.50 ±  5%  interrupts.CPU125.CAL:Function_call_interrupts
    196.00 ±  6%     -52.6%      93.00 ± 54%  interrupts.CPU125.RES:Rescheduling_interrupts
     61.80 ± 69%    +141.4%     149.17 ± 46%  interrupts.CPU129.RES:Rescheduling_interrupts
      3842 ± 58%     +72.7%       6636 ± 23%  interrupts.CPU13.NMI:Non-maskable_interrupts
      3842 ± 58%     +72.7%       6636 ± 23%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    260.40 ± 12%     -34.5%     170.50 ± 39%  interrupts.CPU20.RES:Rescheduling_interrupts
      1515 ± 70%     -47.6%     794.17 ±  2%  interrupts.CPU21.CAL:Function_call_interrupts
      3382 ± 17%    +106.7%       6992 ± 22%  interrupts.CPU38.NMI:Non-maskable_interrupts
      3382 ± 17%    +106.7%       6992 ± 22%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    258.60 ± 10%     -51.3%     126.00 ± 64%  interrupts.CPU45.RES:Rescheduling_interrupts
    222.40 ± 15%     -55.2%      99.67 ± 56%  interrupts.CPU50.RES:Rescheduling_interrupts
      2136 ±107%     -63.0%     791.17        interrupts.CPU51.CAL:Function_call_interrupts
      3122 ± 23%    +116.1%       6746 ± 28%  interrupts.CPU60.NMI:Non-maskable_interrupts
      3122 ± 23%    +116.1%       6746 ± 28%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
    112.60 ± 70%     +85.9%     209.33 ± 23%  interrupts.CPU60.RES:Rescheduling_interrupts
    132.60 ± 23%     +46.1%     193.67 ± 17%  interrupts.CPU71.RES:Rescheduling_interrupts
    268.20 ±  8%     -25.1%     201.00 ± 19%  interrupts.CPU72.RES:Rescheduling_interrupts
    231.60 ± 11%     -32.5%     156.33 ± 39%  interrupts.CPU96.RES:Rescheduling_interrupts
      0.02 ± 25%     +75.8%       0.03 ±  9%  perf-sched.sch_delay.max.ms.__traceiter_sched_switch.__traceiter_sched_switch.wait_for_partner.fifo_open.do_dentry_open
     10683 ±  2%     +10.8%      11839 ±  3%  perf-sched.total_wait_and_delay.count.ms
      1.29           +27.6%       1.64 ± 14%  perf-sched.wait_and_delay.avg.ms.__traceiter_sched_switch.__traceiter_sched_switch.do_wait.kernel_wait4.__do_sys_wait4
      0.04 ±  2%    +874.9%       0.38 ±193%  perf-sched.wait_and_delay.avg.ms.__traceiter_sched_switch.__traceiter_sched_switch.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.04 ±  4%     +10.8%       0.05 ±  6%  perf-sched.wait_and_delay.avg.ms.__traceiter_sched_switch.__traceiter_sched_switch.preempt_schedule_common.__cond_resched.aa_sk_perm
      2931 ± 79%     -93.5%     190.88 ±223%  perf-sched.wait_and_delay.avg.ms.__traceiter_sched_switch.__traceiter_sched_switch.preempt_schedule_common.__cond_resched.generic_perform_write
    352.89 ± 19%     -30.7%     244.45 ± 20%  perf-sched.wait_and_delay.avg.ms.__traceiter_sched_switch.__traceiter_sched_switch.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop
     11.34 ±  3%     -52.2%       5.42 ± 18%  perf-sched.wait_and_delay.avg.ms.__traceiter_sched_switch.__traceiter_sched_switch.schedule_timeout.rcu_gp_kthread.kthread
    400.00 ±  6%     +16.0%     464.17 ±  6%  perf-sched.wait_and_delay.count.__traceiter_sched_switch.__traceiter_sched_switch.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    297.60 ±  3%     -15.9%     250.33 ±  9%  perf-sched.wait_and_delay.count.__traceiter_sched_switch.__traceiter_sched_switch.preempt_schedule_common.__cond_resched.aa_sk_perm
     89.00 ± 13%     +53.6%     136.67 ± 15%  perf-sched.wait_and_delay.count.__traceiter_sched_switch.__traceiter_sched_switch.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop
    865.80 ±  3%    +116.6%       1875 ± 16%  perf-sched.wait_and_delay.count.__traceiter_sched_switch.__traceiter_sched_switch.schedule_timeout.rcu_gp_kthread.kthread
      2015 ±  5%     -14.8%       1716 ±  7%  perf-sched.wait_and_delay.max.ms.__traceiter_sched_switch.__traceiter_sched_switch.devkmsg_read.vfs_read.ksys_read
      2015 ±  5%     -14.8%       1716 ±  7%  perf-sched.wait_and_delay.max.ms.__traceiter_sched_switch.__traceiter_sched_switch.do_syslog.part.0
      2019 ±  5%     -14.8%       1721 ±  7%  perf-sched.wait_and_delay.max.ms.__traceiter_sched_switch.__traceiter_sched_switch.pipe_read.new_sync_read.vfs_read
      4507 ± 68%     -95.4%     208.48 ±223%  perf-sched.wait_and_delay.max.ms.__traceiter_sched_switch.__traceiter_sched_switch.preempt_schedule_common.__cond_resched.generic_perform_write
    336.40 ±  6%     -39.8%     202.67 ± 38%  perf-sched.wait_and_delay.max.ms.__traceiter_sched_switch.__traceiter_sched_switch.schedule_timeout.rcu_gp_kthread.kthread
      0.02 ± 25%     +75.8%       0.03 ±  9%  perf-sched.wait_and_delay.max.ms.__traceiter_sched_switch.__traceiter_sched_switch.wait_for_partner.fifo_open.do_dentry_open
      1.28           +27.7%       1.64 ± 14%  perf-sched.wait_time.avg.ms.__traceiter_sched_switch.__traceiter_sched_switch.do_wait.kernel_wait4.__do_sys_wait4
      0.04 ±  4%     +10.8%       0.05 ±  6%  perf-sched.wait_time.avg.ms.__traceiter_sched_switch.__traceiter_sched_switch.preempt_schedule_common.__cond_resched.aa_sk_perm
      2931 ± 79%     -92.4%     221.94 ±187%  perf-sched.wait_time.avg.ms.__traceiter_sched_switch.__traceiter_sched_switch.preempt_schedule_common.__cond_resched.generic_perform_write
    352.89 ± 19%     -30.7%     244.45 ± 20%  perf-sched.wait_time.avg.ms.__traceiter_sched_switch.__traceiter_sched_switch.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop
     11.33 ±  3%     -52.2%       5.41 ± 18%  perf-sched.wait_time.avg.ms.__traceiter_sched_switch.__traceiter_sched_switch.schedule_timeout.rcu_gp_kthread.kthread
      2015 ±  5%     -14.8%       1716 ±  7%  perf-sched.wait_time.max.ms.__traceiter_sched_switch.__traceiter_sched_switch.devkmsg_read.vfs_read.ksys_read
      2015 ±  5%     -14.8%       1716 ±  7%  perf-sched.wait_time.max.ms.__traceiter_sched_switch.__traceiter_sched_switch.do_syslog.part.0
      2019 ±  5%     -14.8%       1721 ±  7%  perf-sched.wait_time.max.ms.__traceiter_sched_switch.__traceiter_sched_switch.pipe_read.new_sync_read.vfs_read
      4507 ± 68%     -90.4%     434.45 ±132%  perf-sched.wait_time.max.ms.__traceiter_sched_switch.__traceiter_sched_switch.preempt_schedule_common.__cond_resched.generic_perform_write
    336.39 ±  6%     -39.8%     202.66 ± 38%  perf-sched.wait_time.max.ms.__traceiter_sched_switch.__traceiter_sched_switch.schedule_timeout.rcu_gp_kthread.kthread
     4e+10           -20.5%  3.181e+10 ±  6%  perf-stat.i.branch-instructions
 5.393e+08           -20.6%  4.282e+08 ±  6%  perf-stat.i.branch-misses
      3.10 ±  3%     +47.7       50.79        perf-stat.i.cache-miss-rate%
    385998 ±  7%   +5787.2%   22724557 ±  2%  perf-stat.i.cache-misses
  12724208 ±  4%    +265.6%   46522988        perf-stat.i.cache-references
      1893            +8.5%       2053        perf-stat.i.context-switches
      1.03           +27.1%       1.31 ±  7%  perf-stat.i.cpi
    732924 ±  5%     -98.7%       9180 ±  2%  perf-stat.i.cycles-between-cache-misses
 5.984e+10           -20.6%   4.75e+10 ±  6%  perf-stat.i.dTLB-loads
  71166327           -21.0%   56203810 ±  6%  perf-stat.i.dTLB-store-misses
 4.195e+10           -20.7%  3.325e+10 ±  6%  perf-stat.i.dTLB-stores
     95.55            -2.2       93.36        perf-stat.i.iTLB-load-miss-rate%
 1.044e+08 ±  5%     -37.3%   65429401 ±  7%  perf-stat.i.iTLB-load-misses
 2.033e+11           -20.5%  1.616e+11 ±  6%  perf-stat.i.instructions
      1970 ±  4%     +25.8%       2478 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.97           -20.5%       0.77 ±  6%  perf-stat.i.ipc
    613.69           +46.3%     898.05 ±  3%  perf-stat.i.metric.K/sec
    984.60           -20.6%     781.43 ±  6%  perf-stat.i.metric.M/sec
     95.28            -1.2       94.09        perf-stat.i.node-load-miss-rate%
    227909 ±  7%   +3910.6%    9140524 ±  3%  perf-stat.i.node-load-misses
     29783 ± 19%   +1815.1%     570393 ±  8%  perf-stat.i.node-loads
     58.16           +38.4       96.54        perf-stat.i.node-store-miss-rate%
     62670 ±  5%  +20183.3%   12711692 ±  2%  perf-stat.i.node-store-misses
     61358 ±  5%    +622.9%     443579 ±  6%  perf-stat.i.node-stores
      0.06 ±  4%    +357.0%       0.29 ±  5%  perf-stat.overall.MPKI
      3.07 ±  4%     +45.6       48.63        perf-stat.overall.cache-miss-rate%
      1.03           +26.5%       1.30 ±  6%  perf-stat.overall.cpi
    528569 ±  7%     -98.3%       9180 ±  2%  perf-stat.overall.cycles-between-cache-misses
     95.69            -2.3       93.44        perf-stat.overall.iTLB-load-miss-rate%
      1953 ±  4%     +26.6%       2472 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.98           -20.6%       0.77 ±  6%  perf-stat.overall.ipc
     87.79 ±  2%      +6.3       94.09        perf-stat.overall.node-load-miss-rate%
     50.32           +46.3       96.62        perf-stat.overall.node-store-miss-rate%
   1732297            +0.8%    1745669        perf-stat.overall.path-length
 3.985e+10           -20.5%  3.169e+10 ±  6%  perf-stat.ps.branch-instructions
 5.376e+08           -20.6%  4.268e+08 ±  6%  perf-stat.ps.branch-misses
    395364 ±  7%   +5629.5%   22652576 ±  2%  perf-stat.ps.cache-misses
  12874423 ±  4%    +261.7%   46573149        perf-stat.ps.cache-references
      1882            +8.3%       2039        perf-stat.ps.context-switches
 5.963e+10           -20.6%  4.732e+10 ±  6%  perf-stat.ps.dTLB-loads
  70897603           -21.0%   55974505 ±  6%  perf-stat.ps.dTLB-store-misses
  4.18e+10           -20.8%  3.312e+10 ±  6%  perf-stat.ps.dTLB-stores
  1.04e+08 ±  5%     -37.3%   65157736 ±  7%  perf-stat.ps.iTLB-load-misses
 2.026e+11           -20.6%   1.61e+11 ±  6%  perf-stat.ps.instructions
    232283 ±  7%   +3823.3%    9113095 ±  3%  perf-stat.ps.node-load-misses
     32585 ± 22%   +1651.8%     570838 ±  8%  perf-stat.ps.node-loads
     63195 ±  5%  +19944.0%   12666959 ±  2%  perf-stat.ps.node-store-misses
     62383 ±  5%    +610.2%     443065 ±  6%  perf-stat.ps.node-stores
 6.151e+13           -20.7%  4.875e+13 ±  6%  perf-stat.total.instructions
      0.00            +1.6        1.57 ± 27%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.obj_cgroup_uncharge_pages.kmem_cache_free.unix_stream_read_generic
      1.07 ± 12%      +1.6        2.67 ± 16%  perf-profile.calltrace.cycles-pp.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.00            +1.7        1.74 ± 26%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.obj_cgroup_uncharge_pages.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
      0.00            +1.8        1.76 ± 25%  perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      1.81 ± 11%      +1.8        3.62 ± 16%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      0.00            +2.1        2.10 ± 30%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb
      0.00            +2.1        2.12 ± 29%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00            +2.2        2.24 ± 27%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      3.11 ± 12%      +2.8        5.92 ± 16%  perf-profile.calltrace.cycles-pp.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.00            +3.0        3.00 ± 35%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.obj_cgroup_uncharge_pages.kfree.consume_skb
     25.48 ± 13%      +3.1       28.55 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     25.20 ± 13%      +3.1       28.31 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.30 ± 11%      +3.1        4.43 ± 23%  perf-profile.calltrace.cycles-pp.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     12.84 ± 12%      +3.2       16.05 ± 11%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     12.23 ± 12%      +3.3       15.54 ± 11%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +3.3        3.31 ± 34%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.obj_cgroup_uncharge_pages.kfree.consume_skb.unix_stream_read_generic
      0.00            +3.3        3.34 ± 34%  perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
     32.01 ± 12%      +3.4       35.45 ± 10%  perf-profile.calltrace.cycles-pp.write
     10.77 ± 12%      +3.5       14.26 ± 11%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.44 ± 12%      +3.6       13.99 ± 11%  perf-profile.calltrace.cycles-pp.sock_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
      8.72 ± 12%      +3.8       12.52 ± 11%  perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read.ksys_read
      8.28 ± 12%      +3.9       12.14 ± 11%  perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read
      1.77 ± 12%      +4.1        5.91 ± 23%  perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      1.65 ± 12%      +4.2        5.81 ± 23%  perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     26.51 ± 12%      +4.2       30.74 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     26.25 ± 12%      +4.3       30.53 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     14.03 ± 12%      +4.3       18.34 ± 11%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     13.35 ± 12%      +4.4       17.74 ± 11%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +4.4        4.40 ± 34%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve
      0.00            +4.4        4.42 ± 34%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      0.00            +4.5        4.54 ± 33%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     12.01 ± 12%      +4.6       16.63 ± 11%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.75 ± 12%      +4.7       16.40 ± 11%  perf-profile.calltrace.cycles-pp.sock_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     10.98 ± 12%      +4.8       15.75 ± 11%  perf-profile.calltrace.cycles-pp.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write.ksys_write
      9.84 ± 12%      +5.0       14.79 ± 11%  perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write
      5.33 ± 12%      +5.7       11.00 ± 14%  perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      4.92 ± 12%      +5.7       10.65 ± 15%  perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      4.78 ± 12%      +5.7       10.53 ± 15%  perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
      0.95 ± 11%      -0.2        0.73 ± 19%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      1.09 ± 12%      +1.6        2.70 ± 16%  perf-profile.children.cycles-pp.kmem_cache_free
      0.00            +1.7        1.73 ± 33%  perf-profile.children.cycles-pp.propagate_protected_usage
      1.86 ± 11%      +1.8        3.67 ± 16%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      3.12 ± 11%      +2.8        5.93 ± 16%  perf-profile.children.cycles-pp.consume_skb
      1.32 ± 11%      +3.1        4.45 ± 23%  perf-profile.children.cycles-pp.kfree
     12.87 ± 12%      +3.2       16.08 ± 11%  perf-profile.children.cycles-pp.ksys_read
     12.26 ± 12%      +3.3       15.56 ± 11%  perf-profile.children.cycles-pp.vfs_read
     10.79 ± 12%      +3.5       14.28 ± 11%  perf-profile.children.cycles-pp.new_sync_read
     10.47 ± 12%      +3.5       14.02 ± 11%  perf-profile.children.cycles-pp.sock_read_iter
      8.74 ± 12%      +3.8       12.53 ± 11%  perf-profile.children.cycles-pp.unix_stream_recvmsg
      8.36 ± 12%      +3.8       12.20 ± 11%  perf-profile.children.cycles-pp.unix_stream_read_generic
      1.78 ± 12%      +4.1        5.92 ± 23%  perf-profile.children.cycles-pp.kmalloc_reserve
      1.72 ± 12%      +4.1        5.86 ± 23%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
     14.09 ± 12%      +4.3       18.40 ± 10%  perf-profile.children.cycles-pp.ksys_write
     13.42 ± 12%      +4.4       17.81 ± 11%  perf-profile.children.cycles-pp.vfs_write
      0.00            +4.6        4.57 ± 29%  perf-profile.children.cycles-pp.page_counter_cancel
     12.07 ± 12%      +4.6       16.70 ± 11%  perf-profile.children.cycles-pp.new_sync_write
     11.79 ± 12%      +4.6       16.43 ± 11%  perf-profile.children.cycles-pp.sock_write_iter
     11.00 ± 12%      +4.8       15.77 ± 11%  perf-profile.children.cycles-pp.sock_sendmsg
      9.91 ± 12%      +4.9       14.84 ± 11%  perf-profile.children.cycles-pp.unix_stream_sendmsg
      0.00            +5.1        5.06 ± 28%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.00            +5.1        5.10 ± 28%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      5.34 ± 12%      +5.7       11.00 ± 14%  perf-profile.children.cycles-pp.sock_alloc_send_pskb
      4.94 ± 12%      +5.7       10.66 ± 15%  perf-profile.children.cycles-pp.alloc_skb_with_frags
      4.79 ± 12%      +5.8       10.54 ± 15%  perf-profile.children.cycles-pp.__alloc_skb
      0.28 ± 14%      +6.5        6.79 ± 28%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.00            +6.5        6.52 ± 29%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.00            +6.6        6.55 ± 29%  perf-profile.children.cycles-pp.obj_cgroup_charge_pages
     52.11 ± 12%      +7.3       59.44 ± 10%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     51.60 ± 12%      +7.4       59.00 ± 10%  perf-profile.children.cycles-pp.do_syscall_64
      0.80 ± 10%      -0.2        0.64 ± 18%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.09 ± 14%      -0.0        0.06 ± 45%  perf-profile.self.cycles-pp.wait_for_unix_gc
      0.00            +1.7        1.72 ± 33%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.00            +4.5        4.53 ± 29%  perf-profile.self.cycles-pp.page_counter_cancel
      0.00            +5.2        5.21 ± 27%  perf-profile.self.cycles-pp.page_counter_try_charge
     12649 ±  3%     -16.2%      10604 ± 11%  softirqs.CPU0.RCU
     14469 ± 24%     -36.8%       9142 ± 18%  softirqs.CPU1.RCU
     14170 ± 14%     -36.8%       8959 ± 20%  softirqs.CPU10.RCU
     10547 ± 14%     -28.6%       7528 ± 25%  softirqs.CPU100.RCU
     10166 ± 13%     -30.1%       7102 ± 19%  softirqs.CPU101.RCU
     10483 ± 13%     -32.0%       7131 ± 21%  softirqs.CPU102.RCU
     10881 ± 19%     -35.6%       7010 ± 16%  softirqs.CPU105.RCU
     11342 ± 17%     -31.5%       7774 ± 19%  softirqs.CPU106.RCU
     11132 ± 15%     -30.6%       7731 ± 26%  softirqs.CPU107.RCU
      9921 ± 13%     -32.7%       6678 ± 25%  softirqs.CPU108.RCU
     10028 ± 12%     -34.4%       6582 ± 25%  softirqs.CPU109.RCU
     10083 ±  7%     -24.9%       7567 ± 19%  softirqs.CPU113.RCU
     10205 ± 11%     -28.9%       7260 ± 15%  softirqs.CPU114.RCU
      9276 ± 15%     -26.5%       6818 ± 12%  softirqs.CPU115.RCU
     10715 ± 18%     -33.4%       7135 ± 17%  softirqs.CPU119.RCU
     10875 ± 10%     -29.4%       7683 ± 16%  softirqs.CPU120.RCU
     30696 ± 11%     -45.7%      16666 ± 50%  softirqs.CPU122.SCHED
     11869 ± 21%     -36.3%       7560 ± 21%  softirqs.CPU123.RCU
     11458 ± 15%     -42.8%       6557 ± 14%  softirqs.CPU124.RCU
     11317 ±  6%     -38.9%       6913 ± 17%  softirqs.CPU125.RCU
      9390 ±  8%     -22.3%       7299 ± 16%  softirqs.CPU128.RCU
     12175 ± 16%     -33.0%       8156 ± 15%  softirqs.CPU13.RCU
     10938 ± 15%     -38.7%       6709 ± 14%  softirqs.CPU132.RCU
     11091 ±  6%     -33.2%       7408 ± 24%  softirqs.CPU134.RCU
      9173 ± 13%     -25.1%       6870 ± 15%  softirqs.CPU135.RCU
     10832 ±  9%     -34.7%       7068 ± 20%  softirqs.CPU136.RCU
     10703 ± 15%     -28.6%       7638 ± 23%  softirqs.CPU138.RCU
     11309 ± 14%     -34.8%       7371 ± 19%  softirqs.CPU139.RCU
     13122 ± 15%     -35.8%       8428 ± 12%  softirqs.CPU14.RCU
      9909 ± 18%     -26.9%       7240 ± 17%  softirqs.CPU140.RCU
     12178 ±  3%     -26.5%       8952 ± 17%  softirqs.CPU143.RCU
     12774 ± 13%     -31.0%       8812 ± 24%  softirqs.CPU18.RCU
     13854 ±  4%     -37.5%       8663 ± 26%  softirqs.CPU20.RCU
      8500 ± 40%    +121.7%      18844 ± 46%  softirqs.CPU20.SCHED
     12659 ± 16%     -34.8%       8258 ± 20%  softirqs.CPU21.RCU
     11476 ±  9%     -32.6%       7732 ± 12%  softirqs.CPU22.RCU
     10610 ± 14%     -25.9%       7859 ± 21%  softirqs.CPU23.RCU
     10263 ± 10%     -22.9%       7916 ± 20%  softirqs.CPU24.RCU
     11617 ± 11%     -29.3%       8211 ± 17%  softirqs.CPU28.RCU
     12193 ±  8%     -28.6%       8712 ± 20%  softirqs.CPU29.RCU
     11437 ±  9%     -22.1%       8904 ± 20%  softirqs.CPU3.RCU
     10756 ±  9%     -33.4%       7165 ± 15%  softirqs.CPU32.RCU
      9909 ± 36%     +81.6%      17997 ± 28%  softirqs.CPU32.SCHED
      9996 ± 10%     -28.5%       7149 ± 22%  softirqs.CPU33.RCU
      9395 ± 15%     -27.4%       6823 ± 18%  softirqs.CPU34.RCU
     11751 ± 20%     -30.1%       8216 ± 16%  softirqs.CPU36.RCU
     11418 ± 12%     -33.0%       7649 ± 19%  softirqs.CPU38.RCU
     11659 ± 19%     -35.1%       7572 ± 18%  softirqs.CPU39.RCU
     12900 ± 18%     -33.9%       8524 ± 17%  softirqs.CPU4.RCU
      9982 ± 10%     -24.2%       7570 ± 15%  softirqs.CPU40.RCU
     11088 ± 12%     -28.3%       7946 ± 21%  softirqs.CPU42.RCU
     11276 ± 11%     -34.1%       7433 ± 11%  softirqs.CPU44.RCU
     13013 ±  8%     -43.4%       7367 ± 13%  softirqs.CPU45.RCU
      7389 ± 25%    +214.0%      23200 ± 41%  softirqs.CPU45.SCHED
     12283 ± 12%     -37.1%       7729 ± 13%  softirqs.CPU46.RCU
     11657 ± 11%     -31.9%       7937 ± 18%  softirqs.CPU47.RCU
      9971 ±  6%     -30.4%       6938 ± 17%  softirqs.CPU48.RCU
      9779 ± 11%     -33.2%       6536 ± 16%  softirqs.CPU49.RCU
     10634 ±  4%     -41.4%       6230 ± 16%  softirqs.CPU50.RCU
     12624 ± 39%    +114.5%      27083 ± 25%  softirqs.CPU50.SCHED
      9330 ± 14%     -26.5%       6859 ± 12%  softirqs.CPU51.RCU
      9568 ±  8%     -20.3%       7625 ± 10%  softirqs.CPU52.RCU
      8987 ±  7%     -20.2%       7171 ± 15%  softirqs.CPU53.RCU
     11938 ± 11%     -30.1%       8344 ± 18%  softirqs.CPU54.RCU
     11141 ± 13%     -31.4%       7645 ± 19%  softirqs.CPU56.RCU
     11801 ± 13%     -33.8%       7815 ± 19%  softirqs.CPU57.RCU
     11149 ± 55%     +94.2%      21652 ± 36%  softirqs.CPU57.SCHED
     10751 ± 16%     -29.3%       7599 ± 21%  softirqs.CPU61.RCU
      9831 ± 16%     -21.1%       7753 ± 11%  softirqs.CPU62.RCU
     12342 ± 20%     -34.3%       8104 ± 16%  softirqs.CPU7.RCU
     10999 ± 13%     -31.1%       7582 ± 17%  softirqs.CPU70.RCU
     12180 ±  8%     -35.0%       7917 ± 19%  softirqs.CPU72.RCU
      6290 ± 16%    +124.5%      14119 ± 41%  softirqs.CPU72.SCHED
     10881 ± 16%     -29.6%       7655 ±  8%  softirqs.CPU80.RCU
     11332 ± 14%     -35.3%       7333 ± 15%  softirqs.CPU81.RCU
     13496 ± 30%     -42.6%       7747 ± 15%  softirqs.CPU84.RCU
     12794 ± 33%     -38.1%       7925 ± 19%  softirqs.CPU87.RCU
     12375 ± 22%     -40.0%       7419 ± 23%  softirqs.CPU88.RCU
      9373 ± 10%     -22.3%       7279 ± 20%  softirqs.CPU90.RCU
      9802 ± 11%     -28.4%       7018 ± 15%  softirqs.CPU91.RCU
     10415 ± 13%     -32.1%       7072 ± 21%  softirqs.CPU95.RCU
     11236 ± 10%     -33.3%       7490 ± 17%  softirqs.CPU96.RCU
     10720 ± 13%     -34.4%       7031 ± 20%  softirqs.CPU97.RCU
     10450 ±  7%     -36.7%       6616 ± 21%  softirqs.CPU98.RCU
      9844 ± 11%     -25.7%       7314 ± 13%  softirqs.CPU99.RCU
   1549584 ±  5%     -27.6%    1121604 ± 15%  softirqs.RCU
     29638 ±  2%     +46.0%      43283 ±  6%  softirqs.TIMER


                                                                                
                              will-it-scale.72.processes                        
                                                                                
    4e+07 +-----------------------------------------------------------------+   
          |                                                                 |   
  3.5e+07 |.++.+.++.+.++   +  ++.+    +.++.+.++.+.++.+.++.+.++.++.+  +.+    |   
    3e+07 |-+  O       :   :  :  :    :    O    O                 : O:      |   
          | O     O O O:   :  :  :  O : O     O    O O    O  O OO :  : O O  |   
  2.5e+07 |-+O   O      :O :  :   :O  :  O   O    O    OO          : :    O |   
          |            O: ::O: O  :  :                      O      : :      |   
    2e+07 |-+           : :: :    :  :                             : :      |   
          |             : : ::    :  :                             : :      |   
  1.5e+07 |-+           : : ::    :  :                             ::       |   
    1e+07 |-+           : : ::    :  :                             ::       |   
          |              :: ::     : :                              :       |   
    5e+06 |-+            :  :      ::                               :       |   
          |              :  :      ::                               :       |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            will-it-scale.per_process_ops                       
                                                                                
  500000 +------------------------------------------------------------------+   
  450000 |-+          :   :  :  :    +   +.+  +                   :  :      |   
         |    O       :   :  :  :    :     O    O                 : O:      |   
  400000 |-O     O O O:   :  :  :   O: O      O    O O    O  O OO :  : O O  |   
  350000 |-+O   O      :O:: :    :   :   O  O    O    O O          : :    O |   
         |            O: ::O:  O :O  :                     O       : :      |   
  300000 |-+           : :: :    :   :                             : :      |   
  250000 |-+           : : ::    :   :                             : :      |   
  200000 |-+           : : ::    :  :                              ::       |   
         |             : : ::    :  :                              ::       |   
  150000 |-+           : : ::    :  :                              ::       |   
  100000 |-+            :  :      : :                               :       |   
         |              :  :      : :                               :       |   
   50000 |-+            :  :      : :                               :       |   
       0 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                will-it-scale.workload                          
                                                                                
    4e+07 +-----------------------------------------------------------------+   
          |                                                                 |   
  3.5e+07 |.++.+.++.+.++   +  ++.+    +.++.+.++.+.++.+.++.+.++.++.+  +.+    |   
    3e+07 |-+  O       :   :  :  :    :    O    O                 : O:      |   
          | O     O O O:   :  :  :  O : O     O    O O    O  O OO :  : O O  |   
  2.5e+07 |-+O   O      :O :  :   :O  :  O   O    O    OO          : :    O |   
          |            O: ::O: O  :  :                      O      : :      |   
    2e+07 |-+           : :: :    :  :                             : :      |   
          |             : : ::    :  :                             : :      |   
  1.5e+07 |-+           : : ::    :  :                             ::       |   
    1e+07 |-+           : : ::    :  :                             ::       |   
          |              :: ::     : :                              :       |   
    5e+06 |-+            :  :      ::                               :       |   
          |              :  :      ::                               :       |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2sp4: 96 threads 2 sockets Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase/ucode:
  gcc-9/performance/socket/8/x86_64-rhel-8.3/threads/50%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp4/hackbench/0x4003006

commit: 
  68ac5b3c8d ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")
  5387c90490 ("mm/memcg: improve refill_obj_stock() performance")

68ac5b3c8db2fda0 5387c90490f7f42df3209154ca9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     85832 ±  2%     +63.3%     140156        hackbench.throughput
      1058 ±  2%     -38.7%     648.60        hackbench.time.elapsed_time
      1058 ±  2%     -38.7%     648.60        hackbench.time.elapsed_time.max
 1.481e+08 ±  5%     -54.7%   67055135 ± 11%  hackbench.time.involuntary_context_switches
      2743 ± 14%     -22.0%       2139 ± 14%  hackbench.time.major_page_faults
    660151           -24.9%     495452 ±  8%  hackbench.time.minor_page_faults
      9299            -1.1%       9193        hackbench.time.percent_of_cpu_this_job_got
     96400 ±  3%     -41.1%      56802        hackbench.time.system_time
      2045           +38.3%       2828        hackbench.time.user_time
 5.048e+08 ±  3%     -29.2%  3.574e+08 ±  4%  hackbench.time.voluntary_context_switches
      1096 ±  2%     -37.4%     686.41        uptime.boot
   5854506 ± 13%     +24.1%    7267519        vmstat.memory.cache
    725.00           -11.4%     642.33        vmstat.procs.r
    713449           +13.6%     810672 ±  3%  vmstat.system.cs
      6.84 ± 32%      +5.8       12.68 ±  2%  mpstat.cpu.all.idle%
      0.04 ±  3%      +0.0        0.05 ±  3%  mpstat.cpu.all.soft%
     90.26 ±  2%      -8.1       82.14        mpstat.cpu.all.sys%
      2.05 ±  3%      +2.3        4.31        mpstat.cpu.all.usr%
   1667229 ± 36%     -58.9%     685206 ±  7%  numa-numastat.node0.local_node
   1735244 ± 33%     -56.7%     751073 ±  8%  numa-numastat.node0.numa_hit
   1627453 ± 36%     +63.7%    2664519 ±  2%  numa-numastat.node1.local_node
   1646250 ± 35%     +63.1%    2685426 ±  2%  numa-numastat.node1.numa_hit
 5.473e+08 ±  7%     -44.9%  3.016e+08 ± 28%  cpuidle.C1E.time
   8801798 ±  5%     -38.4%    5418393 ±  7%  cpuidle.C1E.usage
  33788932 ± 57%    +550.2%  2.197e+08 ± 57%  cpuidle.C6.time
     47511 ± 43%    +468.8%     270226 ± 51%  cpuidle.C6.usage
  11602677 ±  2%     +72.1%   19972848 ±  6%  cpuidle.POLL.time
   1419906 ±  2%     +87.5%    2662436 ±  9%  cpuidle.POLL.usage
   2590099 ± 14%     +44.9%    3752923        meminfo.Active
   2589860 ± 14%     +44.9%    3752683        meminfo.Active(anon)
   5731493 ± 14%     +24.6%    7142768        meminfo.Cached
   3736163 ± 22%     +37.8%    5148079        meminfo.Committed_AS
  14417237 ±  3%     -28.9%   10244096 ± 23%  meminfo.DirectMap2M
   7123535 ± 12%     +20.6%    8588328        meminfo.Memused
   3368642 ± 24%     +41.9%    4779919        meminfo.Shmem
   7626039 ± 10%     +18.8%    9058324        meminfo.max_used_kB
      1.62 ±  3%      +0.8        2.44        turbostat.C1%
   8801276 ±  5%     -38.4%    5417869 ±  7%  turbostat.C1E
     35280 ± 56%    +632.2%     258306 ± 53%  turbostat.C6
      0.02 ± 80%      +0.3        0.34 ± 60%  turbostat.C6%
      2.08 ±  4%     +44.2%       3.00        turbostat.CPU%c1
      0.01          +700.0%       0.08 ± 73%  turbostat.CPU%c6
 3.455e+08 ±  2%     -37.8%  2.149e+08        turbostat.IRQ
    281.73            +9.4%     308.34        turbostat.PkgWatt
     55.52           +10.1%      61.10        turbostat.RAMWatt
      1210 ±  3%      -8.7%       1104 ±  2%  slabinfo.file_lock_cache.active_objs
      1210 ±  3%      -8.7%       1104 ±  2%  slabinfo.file_lock_cache.num_objs
      2183 ± 10%     -15.9%       1835 ±  9%  slabinfo.khugepaged_mm_slot.active_objs
      2183 ± 10%     -15.9%       1835 ±  9%  slabinfo.khugepaged_mm_slot.num_objs
    917.33 ± 11%     +14.8%       1053 ±  9%  slabinfo.mnt_cache.active_objs
    917.33 ± 11%     +14.8%       1053 ±  9%  slabinfo.mnt_cache.num_objs
      1400 ± 10%     +15.2%       1614 ±  4%  slabinfo.pool_workqueue.active_objs
      1400 ± 10%     +15.3%       1615 ±  4%  slabinfo.pool_workqueue.num_objs
      1280 ±  6%      +8.9%       1394 ±  3%  slabinfo.task_group.active_objs
      1280 ±  6%      +8.9%       1394 ±  3%  slabinfo.task_group.num_objs
    647077 ± 14%     +44.9%     937599        proc-vmstat.nr_active_anon
   3097147            -1.2%    3060593        proc-vmstat.nr_dirty_background_threshold
   6201868            -1.2%    6128670        proc-vmstat.nr_dirty_threshold
   1432801 ± 14%     +24.6%    1785471        proc-vmstat.nr_file_pages
  31171101            -1.2%   30805020        proc-vmstat.nr_free_pages
     46084            -2.1%      45132        proc-vmstat.nr_kernel_stack
    842088 ± 24%     +41.9%    1194758        proc-vmstat.nr_shmem
    647077 ± 14%     +44.9%     937599        proc-vmstat.nr_zone_active_anon
    833331 ±  6%     -20.4%     663134 ±  5%  proc-vmstat.numa_hint_faults
    702802 ±  5%     -26.5%     516314 ±  7%  proc-vmstat.numa_hint_faults_local
    930391 ± 24%     +31.2%    1220675 ±  2%  proc-vmstat.pgactivate
   4037177 ±  4%     +10.7%    4469838 ±  5%  proc-vmstat.pgalloc_normal
   3655571           -29.7%    2570082        proc-vmstat.pgfault
    172618           -36.9%     108978 ±  2%  proc-vmstat.pgreuse
    313159 ± 88%     -75.3%      77465 ± 52%  numa-vmstat.node0.nr_active_anon
     55894 ± 13%     -62.2%      21134 ± 75%  numa-vmstat.node0.nr_anon_pages
    933940 ± 32%     -66.3%     315121 ± 85%  numa-vmstat.node0.nr_file_pages
     39376           -52.3%      18792 ± 71%  numa-vmstat.node0.nr_kernel_stack
    456.67 ± 13%     -66.6%     152.33 ± 71%  numa-vmstat.node0.nr_mlock
    767.67 ±  8%     -39.1%     467.33 ± 41%  numa-vmstat.node0.nr_page_table_pages
    313159 ± 88%     -75.3%      77465 ± 52%  numa-vmstat.node0.nr_zone_active_anon
   2432212 ± 18%     -44.6%    1348351 ± 40%  numa-vmstat.node0.numa_hit
   2362626 ± 20%     -46.0%    1275532 ± 41%  numa-vmstat.node0.numa_local
    334019 ± 61%    +157.8%     860935 ±  4%  numa-vmstat.node1.nr_active_anon
     14549 ± 42%    +234.0%      48600 ± 32%  numa-vmstat.node1.nr_anon_pages
    498850 ± 72%    +194.8%    1470620 ± 18%  numa-vmstat.node1.nr_file_pages
      6710 ±  5%    +292.1%      26308 ± 52%  numa-vmstat.node1.nr_kernel_stack
    431.67 ± 66%     +93.4%     834.67 ± 26%  numa-vmstat.node1.nr_page_table_pages
    470148 ± 76%    +131.8%    1089875 ±  3%  numa-vmstat.node1.nr_shmem
      9641 ± 22%     +99.4%      19222 ± 34%  numa-vmstat.node1.nr_slab_reclaimable
    334018 ± 61%    +157.8%     860935 ±  4%  numa-vmstat.node1.nr_zone_active_anon
   1675492 ± 31%     +73.1%    2900221 ± 17%  numa-vmstat.node1.numa_hit
   1645063 ± 33%     +74.6%    2873065 ± 16%  numa-vmstat.node1.numa_local
   1253183 ± 88%     -75.3%     310060 ± 52%  numa-meminfo.node0.Active
   1252943 ± 88%     -75.3%     309980 ± 52%  numa-meminfo.node0.Active(anon)
    175290 ± 17%     -71.0%      50821 ± 99%  numa-meminfo.node0.AnonHugePages
    223550 ± 13%     -62.2%      84509 ± 74%  numa-meminfo.node0.AnonPages
    288934 ± 18%     -60.9%     112994 ± 67%  numa-meminfo.node0.AnonPages.max
   3735382 ± 32%     -66.3%    1260589 ± 85%  numa-meminfo.node0.FilePages
     39390           -52.4%      18756 ± 71%  numa-meminfo.node0.KernelStack
   4689183 ± 27%     -60.0%    1876258 ± 64%  numa-meminfo.node0.MemUsed
      1829 ± 13%     -66.6%     610.67 ± 71%  numa-meminfo.node0.Mlocked
      3071 ±  8%     -39.1%       1871 ± 41%  numa-meminfo.node0.PageTables
    257262 ±  5%     -27.2%     187219 ± 28%  numa-meminfo.node0.Slab
   1337025 ± 61%    +157.4%    3441839 ±  4%  numa-meminfo.node1.Active
   1337025 ± 61%    +157.4%    3441679 ±  4%  numa-meminfo.node1.Active(anon)
     36096 ± 71%    +317.6%     150736 ± 33%  numa-meminfo.node1.AnonHugePages
     58189 ± 42%    +234.3%     194550 ± 32%  numa-meminfo.node1.AnonPages
    132860 ± 44%    +103.5%     270328 ± 22%  numa-meminfo.node1.AnonPages.max
   1995953 ± 72%    +194.7%    5882894 ± 18%  numa-meminfo.node1.FilePages
     38570 ± 22%     +99.4%      76898 ± 34%  numa-meminfo.node1.KReclaimable
      6709 ±  5%    +292.2%      26311 ± 52%  numa-meminfo.node1.KernelStack
   2434224 ± 65%    +175.7%    6712368 ± 18%  numa-meminfo.node1.MemUsed
      1725 ± 66%     +94.1%       3349 ± 26%  numa-meminfo.node1.PageTables
     38570 ± 22%     +99.4%      76898 ± 34%  numa-meminfo.node1.SReclaimable
   1881144 ± 76%    +131.8%    4359915 ±  3%  numa-meminfo.node1.Shmem
    149238 ± 12%     +47.3%     219837 ± 25%  numa-meminfo.node1.Slab
     11.40            +3.0%      11.74 ±  3%  perf-stat.i.MPKI
  1.03e+10 ±  2%     +58.4%  1.632e+10        perf-stat.i.branch-instructions
      0.78            -0.1        0.73        perf-stat.i.branch-miss-rate%
  80385861 ±  2%     +47.2%  1.184e+08        perf-stat.i.branch-misses
      8.22 ±  3%      +1.1        9.32        perf-stat.i.cache-miss-rate%
  48620190 ±  4%     +85.4%   90134724 ±  3%  perf-stat.i.cache-misses
 5.926e+08           +63.9%  9.711e+08 ±  3%  perf-stat.i.cache-references
    711813           +14.2%     813230 ±  3%  perf-stat.i.context-switches
      5.60 ±  2%     -38.0%       3.47        perf-stat.i.cpi
    143097           +19.7%     171280 ±  4%  perf-stat.i.cpu-migrations
      6090 ±  4%     -47.1%       3224 ±  3%  perf-stat.i.cycles-between-cache-misses
   9617191 ±  9%     +64.9%   15856943 ± 23%  perf-stat.i.dTLB-load-misses
 1.499e+10 ±  2%     +58.5%  2.375e+10        perf-stat.i.dTLB-loads
   4836678 ±  9%     +55.0%    7497483 ± 18%  perf-stat.i.dTLB-store-misses
 9.308e+09 ±  2%     +58.1%  1.471e+10        perf-stat.i.dTLB-stores
  43238998 ±  2%     +49.9%   64800618 ±  2%  perf-stat.i.iTLB-load-misses
   2233157 ±  2%     +49.1%    3330045        perf-stat.i.iTLB-loads
 5.218e+10 ±  2%     +58.6%  8.278e+10        perf-stat.i.instructions
      1209            +6.0%       1281        perf-stat.i.instructions-per-iTLB-miss
      0.18 ±  2%     +60.3%       0.29        perf-stat.i.ipc
    383.58 ±  5%     +55.0%     594.52 ±  2%  perf-stat.i.metric.K/sec
    366.58 ±  2%     +58.4%     580.83        perf-stat.i.metric.M/sec
      3377 ±  2%     +14.3%       3858 ±  2%  perf-stat.i.minor-faults
   9070329 ±  3%     +55.8%   14135155 ±  3%  perf-stat.i.node-load-misses
   5342334 ± 16%     +65.6%    8848582 ±  6%  perf-stat.i.node-loads
     69.49            -4.3       65.21 ±  3%  perf-stat.i.node-store-miss-rate%
  10105591 ±  3%     +44.2%   14570861 ±  3%  perf-stat.i.node-store-misses
   4375529 ±  9%     +76.3%    7714770 ±  7%  perf-stat.i.node-stores
      3380 ±  2%     +14.3%       3862 ±  2%  perf-stat.i.page-faults
     11.35            +3.3%      11.73 ±  3%  perf-stat.overall.MPKI
      0.78            -0.1        0.72        perf-stat.overall.branch-miss-rate%
      8.20 ±  3%      +1.1        9.29        perf-stat.overall.cache-miss-rate%
      5.56 ±  2%     -37.6%       3.47        perf-stat.overall.cpi
      5981 ±  4%     -46.7%       3191 ±  3%  perf-stat.overall.cycles-between-cache-misses
      1206            +5.9%       1277        perf-stat.overall.instructions-per-iTLB-miss
      0.18 ±  2%     +60.2%       0.29        perf-stat.overall.ipc
     69.78            -4.5       65.25 ±  3%  perf-stat.overall.node-store-miss-rate%
  1.03e+10 ±  2%     +58.3%   1.63e+10        perf-stat.ps.branch-instructions
  80301401 ±  2%     +47.1%  1.182e+08        perf-stat.ps.branch-misses
  48556052 ±  4%     +85.4%   90029912 ±  3%  perf-stat.ps.cache-misses
 5.919e+08           +63.8%  9.694e+08 ±  3%  perf-stat.ps.cache-references
    710830           +14.1%     810704 ±  3%  perf-stat.ps.context-switches
 2.899e+11            -1.0%  2.869e+11        perf-stat.ps.cpu-cycles
    142960           +19.4%     170729 ±  4%  perf-stat.ps.cpu-migrations
   9604496 ±  9%     +64.8%   15830747 ± 23%  perf-stat.ps.dTLB-load-misses
 1.497e+10 ±  2%     +58.4%  2.372e+10        perf-stat.ps.dTLB-loads
   4828506 ±  9%     +55.0%    7482674 ± 18%  perf-stat.ps.dTLB-store-misses
   9.3e+09 ±  2%     +58.0%  1.469e+10        perf-stat.ps.dTLB-stores
  43197068 ±  2%     +49.8%   64702614 ±  2%  perf-stat.ps.iTLB-load-misses
   2223191 ±  2%     +49.0%    3313515        perf-stat.ps.iTLB-loads
 5.214e+10 ±  2%     +58.5%  8.266e+10        perf-stat.ps.instructions
      2.80 ± 15%     +29.0%       3.62 ± 15%  perf-stat.ps.major-faults
      3374 ±  2%     +14.2%       3855 ±  2%  perf-stat.ps.minor-faults
   9043371 ±  3%     +55.8%   14088071 ±  3%  perf-stat.ps.node-load-misses
   5348069 ± 16%     +65.9%    8870147 ±  6%  perf-stat.ps.node-loads
  10076406 ±  3%     +44.1%   14516809 ±  3%  perf-stat.ps.node-store-misses
   4377182 ±  9%     +76.6%    7731566 ±  7%  perf-stat.ps.node-stores
      3377 ±  2%     +14.3%       3858 ±  2%  perf-stat.ps.page-faults
 5.519e+13            -2.7%   5.37e+13        perf-stat.total.instructions
    106704 ±  9%     -25.7%      79283 ± 12%  softirqs.CPU0.RCU
     64259 ±  2%     -19.9%      51502        softirqs.CPU0.SCHED
    108011 ±  9%     -26.4%      79547 ± 12%  softirqs.CPU1.RCU
     64894 ±  2%     -23.0%      49994 ±  2%  softirqs.CPU1.SCHED
    107939 ± 10%     -26.6%      79250 ± 12%  softirqs.CPU10.RCU
     62388 ±  3%     -23.0%      48057        softirqs.CPU10.SCHED
    108213 ±  9%     -26.6%      79427 ± 12%  softirqs.CPU11.RCU
     61964 ±  3%     -22.4%      48055        softirqs.CPU11.SCHED
    107351 ± 10%     -26.5%      78853 ± 12%  softirqs.CPU12.RCU
     61645 ±  3%     -22.0%      48106        softirqs.CPU12.SCHED
    107288 ± 10%     -26.3%      79040 ± 12%  softirqs.CPU13.RCU
     61656 ±  3%     -21.9%      48137        softirqs.CPU13.SCHED
    107484 ± 10%     -26.5%      79037 ± 12%  softirqs.CPU14.RCU
     62102 ±  2%     -22.4%      48172        softirqs.CPU14.SCHED
    108703 ±  8%     -26.9%      79480 ± 12%  softirqs.CPU15.RCU
     62457 ±  3%     -21.7%      48894        softirqs.CPU15.SCHED
    114065 ±  9%     -23.4%      87326 ± 12%  softirqs.CPU16.RCU
     62420 ±  3%     -23.0%      48082        softirqs.CPU16.SCHED
     10393 ±141%    -100.0%       0.33 ±141%  softirqs.CPU17.NET_RX
    115421 ±  9%     -24.4%      87236 ± 12%  softirqs.CPU17.RCU
     62400 ±  3%     -23.5%      47747        softirqs.CPU17.SCHED
    115463 ± 10%     -23.4%      88488 ± 12%  softirqs.CPU18.RCU
     62315 ±  2%     -23.0%      47965        softirqs.CPU18.SCHED
    115560 ±  9%     -23.6%      88270 ± 11%  softirqs.CPU19.RCU
     62247 ±  3%     -22.7%      48092        softirqs.CPU19.SCHED
    107912 ±  9%     -26.5%      79292 ± 12%  softirqs.CPU2.RCU
     62637 ±  2%     -23.4%      47974        softirqs.CPU2.SCHED
    115434 ± 10%     -23.8%      87904 ± 12%  softirqs.CPU20.RCU
     62017 ±  2%     -22.5%      48094        softirqs.CPU20.SCHED
    114425 ±  9%     -23.3%      87728 ± 12%  softirqs.CPU21.RCU
     62499 ±  4%     -22.8%      48219        softirqs.CPU21.SCHED
    114555 ± 10%     -24.2%      86806 ± 12%  softirqs.CPU22.RCU
     62625 ±  2%     -22.9%      48262        softirqs.CPU22.SCHED
    114146 ± 10%     -24.1%      86673 ± 12%  softirqs.CPU23.RCU
     62389 ±  2%     -23.0%      48068        softirqs.CPU23.SCHED
    113853 ±  9%     -25.6%      84677 ± 13%  softirqs.CPU24.RCU
    113479 ±  8%     -25.4%      84659 ± 12%  softirqs.CPU25.RCU
    113574 ±  9%     -26.1%      83983 ± 12%  softirqs.CPU26.RCU
    112671 ±  9%     -25.6%      83830 ± 12%  softirqs.CPU27.RCU
    112010 ± 11%     -24.8%      84194 ± 12%  softirqs.CPU28.RCU
    112656 ±  9%     -25.5%      83900 ± 13%  softirqs.CPU29.RCU
    107810 ± 10%     -26.5%      79217 ± 12%  softirqs.CPU3.RCU
     61877 ±  3%     -21.3%      48709        softirqs.CPU3.SCHED
    113351 ±  9%     -25.7%      84204 ± 13%  softirqs.CPU30.RCU
    113431 ±  9%     -25.0%      85097 ± 13%  softirqs.CPU31.RCU
    107367 ±  8%     -24.2%      81383 ± 13%  softirqs.CPU32.RCU
    107084 ±  8%     -24.0%      81383 ± 13%  softirqs.CPU33.RCU
    107005 ±  7%     -24.7%      80625 ± 13%  softirqs.CPU34.RCU
    107186 ±  8%     -24.6%      80862 ± 13%  softirqs.CPU35.RCU
    107848 ±  8%     -24.2%      81791 ± 13%  softirqs.CPU36.RCU
    107903 ±  8%     -24.2%      81755 ± 13%  softirqs.CPU37.RCU
    107488 ±  8%     -23.5%      82194 ± 12%  softirqs.CPU38.RCU
    105435 ±  5%     -23.2%      80981 ± 13%  softirqs.CPU39.RCU
    108034 ±  9%     -25.9%      80034 ± 12%  softirqs.CPU4.RCU
     61751 ±  3%     -22.2%      48020        softirqs.CPU4.SCHED
    106734 ±  8%     -24.1%      80972 ± 13%  softirqs.CPU40.RCU
    106968 ±  8%     -24.2%      81096 ± 13%  softirqs.CPU41.RCU
    106004 ±  9%     -22.7%      81922 ± 13%  softirqs.CPU42.RCU
    107864 ±  8%     -24.1%      81843 ± 13%  softirqs.CPU43.RCU
    107438 ±  8%     -23.9%      81759 ± 12%  softirqs.CPU44.RCU
    106775 ±  8%     -24.2%      80962 ± 13%  softirqs.CPU45.RCU
    106937 ±  8%     -24.1%      81204 ± 13%  softirqs.CPU46.RCU
    106692 ±  8%     -23.9%      81160 ± 12%  softirqs.CPU47.RCU
    107158 ± 10%     -26.3%      79027 ± 12%  softirqs.CPU48.RCU
     61783 ±  3%     -22.9%      47654        softirqs.CPU48.SCHED
    108981 ± 12%     -26.6%      79984 ± 12%  softirqs.CPU49.RCU
     62592 ±  2%     -22.6%      48442        softirqs.CPU49.SCHED
    108385 ±  9%     -26.7%      79488 ± 12%  softirqs.CPU5.RCU
     61993 ±  3%     -22.5%      48029        softirqs.CPU5.SCHED
    107256 ± 10%     -26.3%      79076 ± 12%  softirqs.CPU50.RCU
     62241 ±  3%     -23.0%      47947        softirqs.CPU50.SCHED
    107264 ± 10%     -25.9%      79437 ± 12%  softirqs.CPU51.RCU
     61722 ±  3%     -22.1%      48074        softirqs.CPU51.SCHED
    108010 ± 10%     -25.3%      80714 ± 12%  softirqs.CPU52.RCU
     61915 ±  2%     -21.5%      48573        softirqs.CPU52.SCHED
    108636 ±  8%     -27.2%      79077 ± 12%  softirqs.CPU53.RCU
     62148 ±  3%     -23.1%      47775        softirqs.CPU53.SCHED
    107423 ± 10%     -25.9%      79587 ± 12%  softirqs.CPU54.RCU
     61936 ±  2%     -22.1%      48256        softirqs.CPU54.SCHED
    107587 ± 10%     -28.5%      76908 ± 11%  softirqs.CPU55.RCU
     62136 ±  2%     -19.9%      49790 ±  4%  softirqs.CPU55.SCHED
    106767 ± 10%     -27.1%      77870 ± 14%  softirqs.CPU56.RCU
     62526 ±  3%     -22.5%      48438        softirqs.CPU56.SCHED
    107500 ± 10%     -26.1%      79391 ± 12%  softirqs.CPU57.RCU
     62142 ±  3%     -22.1%      48393        softirqs.CPU57.SCHED
    107661 ± 10%     -26.2%      79421 ± 12%  softirqs.CPU58.RCU
     62377 ±  3%     -22.7%      48236        softirqs.CPU58.SCHED
    107440 ± 10%     -25.9%      79664 ± 11%  softirqs.CPU59.RCU
     62244 ±  4%     -22.7%      48102        softirqs.CPU59.SCHED
    107874 ± 10%     -26.6%      79172 ± 12%  softirqs.CPU6.RCU
     61549 ±  3%     -21.5%      48328        softirqs.CPU6.SCHED
    107796 ± 10%     -25.8%      79995 ± 11%  softirqs.CPU60.RCU
     62391 ±  2%     -22.6%      48281        softirqs.CPU60.SCHED
    107574 ± 10%     -26.0%      79652 ± 12%  softirqs.CPU61.RCU
     61965 ±  3%     -22.1%      48247        softirqs.CPU61.SCHED
    106922 ± 10%     -26.1%      79054 ± 12%  softirqs.CPU62.RCU
     62157 ±  2%     -21.7%      48654        softirqs.CPU62.SCHED
    107710 ±  9%     -25.8%      79874 ± 13%  softirqs.CPU63.RCU
     62240 ±  2%     -21.9%      48588        softirqs.CPU63.SCHED
    115857 ± 10%     -24.0%      88074 ± 12%  softirqs.CPU64.RCU
     62034 ±  3%     -21.9%      48444        softirqs.CPU64.SCHED
    115784 ± 10%     -23.2%      88930 ± 12%  softirqs.CPU65.RCU
     62241 ±  3%     -22.8%      48036        softirqs.CPU65.SCHED
    117310 ± 10%     -23.6%      89587 ± 12%  softirqs.CPU66.RCU
     62200 ±  3%     -22.6%      48136        softirqs.CPU66.SCHED
    116800 ± 10%     -24.0%      88721 ± 12%  softirqs.CPU67.RCU
     62287 ±  2%     -22.6%      48220        softirqs.CPU67.SCHED
    117016 ± 10%     -23.9%      89102 ± 12%  softirqs.CPU68.RCU
     62400 ±  3%     -22.6%      48327        softirqs.CPU68.SCHED
    116187 ± 10%     -23.5%      88902 ± 12%  softirqs.CPU69.RCU
     62598 ±  3%     -23.0%      48179        softirqs.CPU69.SCHED
    107620 ± 10%     -29.5%      75879 ± 11%  softirqs.CPU7.RCU
     62574 ±  3%     -22.9%      48218        softirqs.CPU7.SCHED
    116869 ± 10%     -24.6%      88169 ± 13%  softirqs.CPU70.RCU
     62466 ±  2%     -22.8%      48247        softirqs.CPU70.SCHED
    115673 ± 10%     -23.6%      88330 ± 12%  softirqs.CPU71.RCU
     62179 ±  2%     -22.4%      48267        softirqs.CPU71.SCHED
    114535 ± 10%     -24.6%      86338 ± 14%  softirqs.CPU72.RCU
    114016 ± 10%     -25.6%      84825 ± 13%  softirqs.CPU73.RCU
    113966 ± 10%     -25.5%      84865 ± 13%  softirqs.CPU74.RCU
    113792 ±  9%     -24.4%      86007 ± 15%  softirqs.CPU75.RCU
    112809 ± 10%     -24.9%      84688 ± 13%  softirqs.CPU76.RCU
    113134 ± 10%     -25.2%      84680 ± 12%  softirqs.CPU77.RCU
    114455 ±  9%     -25.8%      84942 ± 13%  softirqs.CPU78.RCU
    112932 ±  8%     -24.1%      85684 ± 14%  softirqs.CPU79.RCU
    108100 ± 10%     -28.8%      77016 ± 15%  softirqs.CPU8.RCU
     62010 ±  3%     -22.1%      48280        softirqs.CPU8.SCHED
    108992 ±  8%     -25.2%      81562 ± 13%  softirqs.CPU80.RCU
    108826 ±  9%     -24.8%      81792 ± 14%  softirqs.CPU81.RCU
    109238 ±  8%     -23.2%      83873 ± 11%  softirqs.CPU82.RCU
    109645 ±  8%     -24.9%      82327 ± 13%  softirqs.CPU83.RCU
    108129 ±  8%     -24.4%      81719 ± 13%  softirqs.CPU84.RCU
    108119 ±  8%     -24.6%      81524 ± 13%  softirqs.CPU85.RCU
    108440 ±  8%     -24.2%      82166 ± 13%  softirqs.CPU86.RCU
    107359 ±  6%     -23.3%      82337 ± 13%  softirqs.CPU87.RCU
    109438 ±  9%     -24.9%      82223 ± 12%  softirqs.CPU88.RCU
    109294 ±  8%     -24.8%      82219 ± 13%  softirqs.CPU89.RCU
    107583 ±  9%     -25.2%      80514 ± 11%  softirqs.CPU9.RCU
     62183 ±  3%     -22.1%      48417        softirqs.CPU9.SCHED
    106831 ±  9%     -23.5%      81710 ± 13%  softirqs.CPU90.RCU
    109190 ±  8%     -25.0%      81857 ± 13%  softirqs.CPU91.RCU
    108703 ±  8%     -24.1%      82555 ± 13%  softirqs.CPU92.RCU
    108890 ±  8%     -24.9%      81742 ± 13%  softirqs.CPU93.RCU
    109187 ±  8%     -24.5%      82413 ± 13%  softirqs.CPU94.RCU
    109222 ±  8%     -24.5%      82471 ± 13%  softirqs.CPU95.RCU
  10564212 ±  9%     -25.1%    7916521 ± 12%  softirqs.RCU
   5930750           -12.8%    5174428 ±  2%  softirqs.SCHED
    123828 ±  5%     -28.6%      88466 ±  8%  softirqs.TIMER
     33.81 ±138%     -99.2%       0.28 ± 65%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     11.10 ± 72%     -99.1%       0.11 ± 13%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     55.36 ±120%     -99.8%       0.13 ± 30%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      8.67 ± 79%     -89.2%       0.93 ±  6%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.25 ± 41%     +82.1%       0.46 ± 25%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      1.73 ± 20%     -38.4%       1.06        perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.32 ±141%    +604.2%       2.22 ± 25%  perf-sched.sch_delay.avg.ms.io_schedule.put_and_wait_on_page_locked.do_swap_page.__handle_mm_fault
     11.81 ± 64%     -99.5%       0.06 ±  9%  perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.09 ± 75%   +2166.9%       2.12 ± 80%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.wp_page_copy
      0.03 ±141%    +644.4%       0.20 ± 84%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc
      0.00 ±141%   +5383.3%       0.11 ±126%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc_node
      1.68 ± 66%     -88.6%       0.19 ±  6%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      2.26 ± 30%     -28.0%       1.63        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
      2.34 ± 76%     -92.4%       0.18 ±  6%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      0.00 ±141%  +10950.0%       0.37 ± 77%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.link_path_walk
      0.00 ±141%  +97300.0%       0.32 ± 68%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.shift_arg_pages
      0.95 ±137%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.begin_new_exec
      4.25 ± 76%     -98.0%       0.08 ± 12%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      2.90 ± 21%     -45.4%       1.58 ±  2%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
      1.23 ± 81%     -84.3%       0.19        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      2.23 ± 53%     -85.0%       0.34 ± 84%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault
     19.46 ±106%     -99.9%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    276.35 ± 71%     -99.8%       0.45 ±130%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     28.34 ±141%    -100.0%       0.01 ± 12%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io.blk_execute_rq
      8.25 ± 58%     -85.7%       1.18 ±  2%  perf-sched.sch_delay.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
      1.59 ± 35%     -49.6%       0.80 ±  2%  perf-sched.sch_delay.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
    149.04 ± 94%    -100.0%       0.02 ± 55%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
    694.71 ± 66%     -99.1%       6.24 ± 21%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      2990 ±117%     -99.9%       3.34 ± 30%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1112 ± 67%     -96.6%      38.12 ± 31%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1.52 ±141%    +279.5%       5.76 ± 74%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function.[unknown]
    532.39 ± 72%     -82.0%      95.74 ± 65%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      3667 ± 68%     -94.7%     193.92        perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.00 ±141%    +841.2%      18.78 ± 32%  perf-sched.sch_delay.max.ms.io_schedule.put_and_wait_on_page_locked.do_swap_page.__handle_mm_fault
      1459 ± 32%     -99.2%      11.28 ± 28%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.57 ±113%   +3702.4%      21.58 ± 81%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.wp_page_copy
      0.19 ±141%   +1324.8%       2.68 ± 85%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc
      0.01 ±141%   +1070.0%       0.12 ±114%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc_node
      3363 ± 74%     -96.6%     114.46 ± 43%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
    893.79 ± 84%     -88.0%     107.52 ± 56%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
      3303 ± 98%     -97.1%      94.82 ±  7%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
     55.17 ± 10%     -47.3%      29.08 ± 30%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.02 ±141%  +21726.7%       3.27 ± 86%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.link_path_walk
      0.00 ±141%  +1.5e+05%       2.04 ± 65%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.shift_arg_pages
      6.00 ±122%    -100.0%       0.00 ±141%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.begin_new_exec
      2387 ± 67%     -96.3%      88.32 ± 11%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      1390 ± 71%     -95.0%      69.35 ± 23%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
      1.08 ±141%    +347.4%       4.84 ± 82%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.task_numa_work.task_work_run.exit_to_user_mode_prepare
    683.45 ±117%     -96.9%      21.07 ± 57%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
     30.67 ± 51%     -78.4%       6.61 ± 94%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault
    931.01 ± 89%    -100.0%       0.08 ± 44%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      3414 ± 70%     -99.9%       3.94 ±111%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      3580 ± 67%     -91.8%     293.88 ± 11%  perf-sched.sch_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
      2695 ± 70%     -90.1%     266.67 ±  7%  perf-sched.sch_delay.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      5845 ± 59%     -99.8%      13.40 ±106%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      2.25 ± 35%     -54.0%       1.03 ±  2%  perf-sched.total_sch_delay.average.ms
      5896 ± 57%     -91.2%     519.37 ± 65%  perf-sched.total_sch_delay.max.ms
      8.53 ± 25%     -39.2%       5.19        perf-sched.total_wait_and_delay.average.ms
   3683656 ± 21%     +39.7%    5145208        perf-sched.total_wait_and_delay.count.ms
     14490 ± 28%     -40.8%       8573 ±  6%  perf-sched.total_wait_and_delay.max.ms
      6.28 ± 22%     -33.9%       4.15        perf-sched.total_wait_time.average.ms
      1422 ± 28%     -38.6%     872.88 ±  4%  perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    187.09 ± 45%     +52.4%     285.20        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     30.10 ± 51%     -70.8%       8.78 ± 23%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      2.67 ±141%    +296.3%      10.59 ±  8%  perf-sched.wait_and_delay.avg.ms.io_schedule.put_and_wait_on_page_locked.do_swap_page.__handle_mm_fault
      7.72 ± 37%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
     18.49 ± 50%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
     18.17 ± 35%     -53.5%       8.45 ±  3%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    455.38 ± 40%     -58.1%     190.88 ± 10%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    931.68 ± 39%     -49.1%     474.45 ±  8%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io.blk_execute_rq
    953.55 ± 49%     -49.7%     479.42        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     31.25 ± 46%     -74.7%       7.89        perf-sched.wait_and_delay.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
      5.36 ± 30%     -42.7%       3.07 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
    958.10 ± 22%     -47.5%     503.03 ±  6%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      1142 ± 25%     -36.1%     730.67        perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
    152.33 ± 54%     +75.1%     266.67 ±  3%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      7.00 ±141%    +695.2%      55.67 ± 78%  perf-sched.wait_and_delay.count.io_schedule.put_and_wait_on_page_locked.do_swap_page.__handle_mm_fault
     74387 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      9475 ± 37%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      1139 ±141%    +737.1%       9535        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
     43.67 ±139%    +522.1%     271.67 ± 20%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
    667.00 ± 42%     +69.0%       1127 ±  3%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
     18.33 ±141%    +700.0%     146.67 ± 42%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
     15.33 ± 27%    +102.2%      31.00 ± 38%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     44.67 ± 58%    +200.0%     134.00 ±  9%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    422364 ± 61%    +214.0%    1326343        perf-sched.wait_and_delay.count.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
   2409581 ± 20%     +29.0%    3108851        perf-sched.wait_and_delay.count.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
    963.33 ± 54%    +119.6%       2115 ±  8%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
    704.67 ± 50%     +71.7%       1209 ±  2%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      3334 ± 14%     -70.0%       1001        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2287 ± 66%     -83.0%     387.80 ±114%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      7489 ± 64%     -91.5%     637.52 ± 40%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6795 ± 73%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      5141 ± 68%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      1136 ±  8%     -11.7%       1002        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
     26.59 ±141%    +623.3%     192.33 ± 92%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      8681 ± 33%     -51.2%       4236 ± 26%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      5338 ± 27%     -38.4%       3287        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      2623 ± 47%     -62.6%     981.29 ± 30%  perf-sched.wait_and_delay.max.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io.blk_execute_rq
      4199 ± 91%     -88.0%     505.02        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      7532 ± 68%     -92.1%     593.82 ± 12%  perf-sched.wait_and_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
      5407 ± 71%     -89.8%     549.25 ±  7%  perf-sched.wait_and_delay.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     14250 ± 31%     -42.5%       8191        perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
      1388 ± 31%     -37.2%     872.60 ±  4%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    175.99 ± 50%     +62.0%     285.10        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     21.42 ± 40%     -63.4%       7.84 ± 25%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.45 ±141%    +235.8%       1.51 ± 40%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function.[unknown]
      5.50 ± 34%     -48.2%       2.84        perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      2.36 ±141%    +255.1%       8.37 ± 10%  perf-sched.wait_time.avg.ms.io_schedule.put_and_wait_on_page_locked.do_swap_page.__handle_mm_fault
      0.06 ± 26%     -67.4%       0.02 ± 24%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__pmd_alloc.__handle_mm_fault
      0.01 ± 78%   +5014.3%       0.72 ±101%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.do_anonymous_page
      1.25 ± 31%     -69.8%       0.38 ± 89%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__do_fault.do_fault.__handle_mm_fault
      0.04 ± 29%     -60.4%       0.01 ± 74%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_prepare_creds.prepare_creds
      0.90 ±140%    +652.4%       6.81 ± 37%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.__kmalloc_node_track_caller
      0.41 ±125%   +1185.4%       5.24 ± 43%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc_node
      6.04 ± 30%     -53.5%       2.81 ±  6%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      1.83 ±121%     -99.2%       0.02 ± 24%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__split_huge_pud.__handle_mm_fault.handle_mm_fault
      5.37 ± 27%     -32.1%       3.64        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
      7.16 ± 43%     -61.9%       2.73 ±  5%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      0.90 ± 33%    +232.8%       3.00 ± 44%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.33 ± 67%     -94.9%       0.02 ± 11%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.path_lookupat
      0.12 ± 93%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.__anon_vma_prepare.do_anonymous_page
      0.05 ± 66%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.__anon_vma_prepare.do_fault
      0.10 ± 91%    +405.1%       0.52 ± 16%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.__split_vma
      0.55 ± 80%     -99.0%       0.01 ±141%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.__split_vma
      0.47 ± 76%    +171.2%       1.27 ± 43%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      0.10 ± 57%    +828.7%       0.92 ±100%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary
      0.70 ± 74%     -84.3%       0.11 ± 83%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.04 ±141%   +2100.0%       0.92 ±111%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_lookupat
      2.74 ± 29%     -58.9%       1.13 ±  9%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.17 ± 68%    +579.3%       1.16 ± 25%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__alloc_file.alloc_empty_file
      0.25 ± 31%     -95.6%       0.01 ± 75%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_fault
      0.60 ± 80%    +177.1%       1.65 ± 61%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.71 ± 82%     -95.0%       0.04 ± 70%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma
     14.23 ± 42%     -64.7%       5.03 ±  2%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      6.14 ± 24%     -40.5%       3.65        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
      0.06 ± 82%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.remove_vma.__do_munmap.mmap_region
      0.01 ±141%   +8730.4%       0.68 ± 60%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
     18.16 ± 35%     -53.5%       8.45 ±  3%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.20 ±141%    +228.1%      13.77 ± 19%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      4.54 ± 25%     -36.4%       2.89 ±  6%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      0.64 ± 67%   +3519.8%      23.06 ± 67%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
     27.45 ± 96%     -91.8%       2.24 ±  7%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    455.23 ± 40%     -58.7%     188.20 ±  9%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      1.36 ± 72%   +2071.8%      29.61 ±113%  perf-sched.wait_time.avg.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
    903.34 ± 42%     -47.5%     474.44 ±  8%  perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io.blk_execute_rq
    953.54 ± 49%     -49.7%     479.41        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1.86 ± 71%    +100.5%       3.73 ± 13%  perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
     12.86 ± 41%     -57.9%       5.42 ± 37%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     23.00 ± 42%     -70.8%       6.72        perf-sched.wait_time.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
      3.77 ± 29%     -39.7%       2.27        perf-sched.wait_time.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00 ±141%    +227.3%       0.01 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.10 ±  2%     -26.2%       0.08 ± 25%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion_interruptible.usb_stor_control_thread.kthread
    958.06 ± 22%     -47.5%     503.02 ±  6%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      2.45 ± 28%     -37.8%       1.52 ± 15%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    993.60 ± 14%     -26.5%     730.65        perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      3000 ± 27%     -66.7%       1000        perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1181 ± 65%     -68.8%     368.37 ±124%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      4.42 ±141%    +297.0%      17.56 ± 10%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function.[unknown]
     49.31 ±  6%     -22.8%      38.05 ±  3%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      3927 ± 56%     -85.4%     572.35 ± 56%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.41 ±141%   +1307.5%      33.97 ± 49%  perf-sched.wait_time.max.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
      0.11 ± 14%     -59.7%       0.04 ± 23%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__pmd_alloc.__handle_mm_fault
     54.77 ± 25%     -41.6%      32.01 ± 17%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.shmem_alloc_page
     12.59 ± 27%     -76.2%       3.00 ± 23%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__do_fault.do_fault.__handle_mm_fault
      0.06 ± 30%     -71.9%       0.02 ± 80%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_prepare_creds.prepare_creds
      3.90 ±141%    +241.3%      13.32 ± 20%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.__kmalloc_node_track_caller
      1.82 ±137%    +427.1%       9.57 ± 65%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc_node
      3535 ± 69%     -93.9%     214.54 ± 56%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      3.63 ±122%     -99.2%       0.03 ± 66%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__split_huge_pud.__handle_mm_fault.handle_mm_fault
      1398 ± 64%     -91.7%     116.36 ± 47%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
      3754 ± 83%     -96.6%     125.96 ± 25%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      4.04 ±141%    +266.5%      14.80 ± 37%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.change_p4d_range.change_protection.change_prot_numa
     31.43 ± 65%   +1188.1%     404.82 ±108%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.07 ±138%    +365.3%       4.96 ± 86%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.link_path_walk
      1.60 ± 95%     -98.3%       0.03 ± 37%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.path_lookupat
      0.20 ± 95%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.__anon_vma_prepare.do_anonymous_page
      0.13 ± 77%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.__anon_vma_prepare.do_fault
      4.70 ±120%     -99.8%       0.01 ±141%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.__split_vma
      0.12 ±113%     -91.9%       0.01 ± 83%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.alloc_bprm.do_execveat_common
      0.35 ± 69%   +1761.3%       6.51 ±104%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary
      9.68 ± 44%   +3498.9%     348.31 ±132%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
     14.23 ± 70%     -92.7%       1.03 ± 71%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.04 ±141%   +2329.6%       1.01 ± 97%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_lookupat
      1610 ± 84%     -97.4%      42.63 ±  6%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      1.24 ±109%    +506.2%       7.52 ± 77%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__alloc_file.alloc_empty_file
      1.02 ± 74%     -98.7%       0.01 ± 82%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_fault
      1.92 ± 62%     -95.9%       0.08 ± 92%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma
      3042 ± 71%     -96.7%     101.00 ± 16%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.92 ±140%    +326.6%       3.94 ± 59%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.__fdget_pos.ksys_write
      1907 ± 85%     -95.1%      93.61 ± 34%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
      0.10 ±106%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.remove_vma.__do_munmap.mmap_region
     10.28 ±141%    +254.2%      36.41 ± 25%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.task_numa_work.task_work_run.exit_to_user_mode_prepare
      0.67 ±106%    +512.9%       4.08 ± 79%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.unmap_vmas.unmap_region.__do_munmap
      0.01 ±141%  +79165.2%       6.08 ± 32%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
      1135 ±  8%     -11.7%       1001        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
     17.32 ±141%    +934.2%     179.11 ±103%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      1080 ±112%     -95.2%      51.78 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
     16.44 ±103%   +3979.0%     670.44 ± 69%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
    965.66 ± 86%     -98.4%      15.36 ± 95%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      5338 ± 27%     -38.4%       3287        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      1.36 ± 72%   +2071.8%      29.61 ±113%  perf-sched.wait_time.max.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      2538 ± 52%     -61.3%     981.28 ± 30%  perf-sched.wait_time.max.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io.blk_execute_rq
      4199 ± 91%     -88.0%     505.00        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1.86 ± 71%    +100.5%       3.73 ± 13%  perf-sched.wait_time.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      1012 ± 74%     -82.0%     182.69 ± 36%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00 ±141%    +227.3%       0.01 ±  6%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
     51.37 ±  2%     -51.4        0.00        perf-profile.calltrace.cycles-pp.__libc_write
     50.84 ±  2%     -50.8        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write
     50.74 ±  2%     -50.7        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     49.58           -49.6        0.00        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     48.07 ±  2%     -48.1        0.00        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     46.06           -46.1        0.00        perf-profile.calltrace.cycles-pp.__libc_read
     45.43           -45.4        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read
     45.34 ±  2%     -45.3        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     44.80 ±  2%     -44.8        0.00        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     44.20 ±  2%     -44.2        0.00        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     10.28 ±  8%     -10.3        0.00        perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     17.51 ±  6%      -8.0        9.55        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      6.05 ± 71%      -6.0        0.00        perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event
      5.64 ± 71%      -5.6        0.00        perf-profile.calltrace.cycles-pp.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow
      5.61 ± 71%      -5.6        0.00        perf-profile.calltrace.cycles-pp.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
     32.34 ±  6%      -5.1       27.21        perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     32.40 ±  6%      -5.1       27.30        perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      5.01 ± 71%      -5.0        0.00        perf-profile.calltrace.cycles-pp.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
     14.13 ± 12%      -3.9       10.19        perf-profile.calltrace.cycles-pp.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
     16.16 ±  9%      -3.3       12.87        perf-profile.calltrace.cycles-pp.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     42.82 ±  2%      -2.4       40.42        perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read
     42.92 ±  2%      -2.4       40.55        perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read.ksys_read
      2.89 ± 56%      -2.3        0.60 ±  2%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      2.86 ± 56%      -2.3        0.59 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
     43.41 ±  2%      -2.0       41.39        perf-profile.calltrace.cycles-pp.sock_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
     43.56 ±  2%      -1.9       41.61        perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.43 ±  2%      -1.7       44.68        perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write
      0.80 ± 18%      +0.5        1.29        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.83 ± 18%      +0.5        1.35        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      0.00            +0.5        0.55        perf-profile.calltrace.cycles-pp.fput_many.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.11 ± 10%      +0.6        1.66 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_sendmsg
      0.00            +0.6        0.55 ±  3%  perf-profile.calltrace.cycles-pp.__build_skb_around.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      0.00            +0.6        0.56 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      0.00            +0.6        0.56 ±  3%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.57 ±  2%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.01 ±  8%      +0.6        1.59 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg
      0.00            +0.6        0.59 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg
      0.84 ±  4%      +0.6        1.44 ±  2%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      0.00            +0.6        0.60 ±  3%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
      0.00            +0.6        0.61 ±  3%  perf-profile.calltrace.cycles-pp.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      0.88 ± 10%      +0.6        1.49        perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      0.91 ±  9%      +0.6        1.53 ±  2%  perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      0.99 ± 14%      +0.6        1.61        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      0.00            +0.7        0.68 ±  4%  perf-profile.calltrace.cycles-pp.__fget_files.__fget_light.__fdget_pos.ksys_read.do_syscall_64
      0.00            +0.8        0.77 ±  6%  perf-profile.calltrace.cycles-pp.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.00            +0.8        0.77 ±  3%  perf-profile.calltrace.cycles-pp._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      0.00            +0.8        0.80 ±  4%  perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.82        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.unix_write_space
      0.95 ± 43%      +0.8        1.77        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +0.8        0.82 ±  4%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.83        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.unix_write_space.sock_wfree
      0.00            +0.8        0.83        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.unix_write_space.sock_wfree.unix_destruct_scm
      0.00            +0.8        0.84        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.unix_write_space.sock_wfree.unix_destruct_scm.skb_release_head_state
      0.99 ± 41%      +0.8        1.84        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.99 ± 42%      +0.9        1.84        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.9        0.86 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock.get_partial_node.___slab_alloc.__slab_alloc.__kmalloc_node_track_caller
      0.00            +0.9        0.89        perf-profile.calltrace.cycles-pp.mutex_unlock.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.63 ±  9%      +0.9        1.53        perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.00            +0.9        0.95 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.get_partial_node.___slab_alloc.__slab_alloc.kmem_cache_alloc_node
      0.00            +1.0        0.99        perf-profile.calltrace.cycles-pp.fput_many.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.20 ± 36%      +1.0        2.22        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.20 ± 36%      +1.0        2.23        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.20 ± 36%      +1.0        2.23        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      1.22 ± 36%      +1.0        2.25        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.00            +1.0        1.04 ±  5%  perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.__slab_alloc.__kmalloc_node_track_caller.kmalloc_reserve
      0.21 ±141%      +1.1        1.27        perf-profile.calltrace.cycles-pp.unix_write_space.sock_wfree.unix_destruct_scm.skb_release_head_state.skb_release_all
      0.00            +1.1        1.06 ± 11%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node
      0.22 ±141%      +1.1        1.30 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait.sock_alloc_send_pskb.unix_stream_sendmsg
      0.23 ±141%      +1.1        1.34        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
      0.00            +1.1        1.11 ±  8%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_uncharge.obj_cgroup_uncharge_pages.kfree.consume_skb
      0.00            +1.1        1.13 ±  4%  perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.__slab_alloc.kmem_cache_alloc_node.__alloc_skb
      0.23 ±141%      +1.1        1.38        perf-profile.calltrace.cycles-pp.prepare_to_wait.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      0.17 ±141%      +1.2        1.40 ±  3%  perf-profile.calltrace.cycles-pp.___slab_alloc.__slab_alloc.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      0.18 ±141%      +1.2        1.43 ±  4%  perf-profile.calltrace.cycles-pp.__slab_alloc.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      0.67 ± 19%      +1.3        1.93        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.skb_queue_tail.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      1.94 ± 12%      +1.3        3.21        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg
      1.96 ± 12%      +1.3        3.24        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      1.04 ± 20%      +1.3        2.32        perf-profile.calltrace.cycles-pp.__fget_files.__fget_light.__fdget_pos.ksys_write.do_syscall_64
      1.99 ± 11%      +1.3        3.27        perf-profile.calltrace.cycles-pp.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.69 ± 19%      +1.3        1.99        perf-profile.calltrace.cycles-pp.skb_queue_tail.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      1.13 ± 18%      +1.3        2.44        perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.17 ±141%      +1.3        1.51 ±  3%  perf-profile.calltrace.cycles-pp.__slab_alloc.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.18 ±141%      +1.4        1.53 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.skb_unlink.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.20 ±141%      +1.4        1.60 ±  2%  perf-profile.calltrace.cycles-pp.skb_unlink.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.00            +1.5        1.49 ±  3%  perf-profile.calltrace.cycles-pp.___slab_alloc.__slab_alloc.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00            +1.5        1.50        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.get_partial_node.___slab_alloc.__slab_alloc
      0.67 ± 16%      +1.6        2.25 ±  2%  perf-profile.calltrace.cycles-pp.skb_set_owner_w.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      0.89 ± 18%      +1.7        2.60        perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      0.00            +1.8        1.81        perf-profile.calltrace.cycles-pp.__slab_free.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.39 ± 72%      +1.9        2.26        perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      1.20 ± 21%      +1.9        3.15        perf-profile.calltrace.cycles-pp.sock_wfree.unix_destruct_scm.skb_release_head_state.skb_release_all.consume_skb
      1.25 ± 19%      +2.0        3.21        perf-profile.calltrace.cycles-pp.unix_destruct_scm.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic
      1.28 ± 19%      +2.0        3.25        perf-profile.calltrace.cycles-pp.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      1.29 ± 18%      +2.0        3.26        perf-profile.calltrace.cycles-pp.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00            +2.1        2.07 ± 12%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller
     14.02 ±  6%      +2.3       16.28        perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     14.09 ±  6%      +2.3       16.40        perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      0.00            +2.5        2.47        perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +5.1        5.08        perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.obj_cgroup_uncharge_pages.kmem_cache_free.unix_stream_read_generic
      0.00            +5.7        5.66        perf-profile.calltrace.cycles-pp.page_counter_uncharge.obj_cgroup_uncharge_pages.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
      0.65 ± 25%      +5.8        6.47        perf-profile.calltrace.cycles-pp.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb
      0.00            +5.8        5.83        perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.74 ± 22%      +5.9        6.69        perf-profile.calltrace.cycles-pp.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.80 ± 22%      +6.0        6.79        perf-profile.calltrace.cycles-pp.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.00           +10.0        9.98        perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.obj_cgroup_uncharge_pages.kfree.consume_skb
      0.00           +11.1       11.11        perf-profile.calltrace.cycles-pp.page_counter_uncharge.obj_cgroup_uncharge_pages.kfree.consume_skb.unix_stream_read_generic
      0.00           +11.5       11.46        perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      1.30 ± 27%     +11.5       12.80        perf-profile.calltrace.cycles-pp.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve
      1.64 ± 23%     +11.6       13.22        perf-profile.calltrace.cycles-pp.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      1.71 ± 23%     +11.6       13.35        perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      0.00           +42.6       42.61        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +44.1       44.07        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +47.0       46.99        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +50.6       50.56        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +95.5       95.50        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +95.7       95.74        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     51.50 ±  2%     -51.1        0.36 ± 11%  perf-profile.children.cycles-pp.__libc_write
     46.20           -46.2        0.00        perf-profile.children.cycles-pp.__libc_read
     14.85 ±  7%     -14.3        0.58 ±  2%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
     17.54 ±  6%      -8.0        9.59        perf-profile.children.cycles-pp.kmem_cache_alloc_node
      6.99 ± 13%      -7.0        0.00        perf-profile.children.cycles-pp.drain_obj_stock
      7.13 ± 13%      -7.0        0.17        perf-profile.children.cycles-pp.refill_obj_stock
     32.35 ±  6%      -5.1       27.23        perf-profile.children.cycles-pp.__alloc_skb
     32.40 ±  6%      -5.1       27.30        perf-profile.children.cycles-pp.alloc_skb_with_frags
     14.15 ± 12%      -3.9       10.21        perf-profile.children.cycles-pp.kmem_cache_free
      4.72 ±  6%      -3.7        1.05 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
     16.17 ±  9%      -3.3       12.88        perf-profile.children.cycles-pp.kfree
     42.85 ±  2%      -2.4       40.45        perf-profile.children.cycles-pp.unix_stream_read_generic
     42.92 ±  2%      -2.4       40.56        perf-profile.children.cycles-pp.unix_stream_recvmsg
     43.41 ±  2%      -2.0       41.39        perf-profile.children.cycles-pp.sock_read_iter
     43.58 ±  2%      -1.9       41.63        perf-profile.children.cycles-pp.new_sync_read
      2.11 ± 10%      -1.9        0.19 ±  2%  perf-profile.children.cycles-pp.get_mem_cgroup_from_objcg
     46.45 ±  2%      -1.7       44.72        perf-profile.children.cycles-pp.unix_stream_sendmsg
     44.21 ±  2%      -1.6       42.63        perf-profile.children.cycles-pp.vfs_read
      0.87 ± 39%      -0.6        0.31 ±  3%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.59 ± 40%      -0.4        0.20 ±  4%  perf-profile.children.cycles-pp.select_idle_sibling
      0.56 ± 43%      -0.4        0.18 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.38 ± 36%      -0.2        0.14 ±  3%  perf-profile.children.cycles-pp.select_idle_cpu
      0.32 ± 31%      -0.2        0.15 ±  3%  perf-profile.children.cycles-pp.update_cfs_group
      0.27 ± 37%      -0.2        0.10 ±  4%  perf-profile.children.cycles-pp.available_idle_cpu
      0.23 ± 40%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.update_rq_clock
      0.21 ± 37%      -0.1        0.08        perf-profile.children.cycles-pp.set_next_entity
      0.17 ± 41%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__switch_to_asm
      0.42 ±  5%      -0.1        0.33        perf-profile.children.cycles-pp.__entry_text_start
      0.07 ±  7%      +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.security_socket_getpeersec_dgram
      0.06 ± 23%      +0.0        0.09 ± 14%  perf-profile.children.cycles-pp.mem_cgroup_from_task
      0.06 ± 23%      +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.03 ± 70%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.finish_wait
      0.36 ±  2%      +0.0        0.40 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.13 ±  9%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.04 ± 70%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.check_stack_object
      0.07 ±  6%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.rcu_all_qs
      0.05            +0.0        0.09        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.33 ±  2%      +0.0        0.38 ±  2%  perf-profile.children.cycles-pp.task_tick_fair
      0.06            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.rw_verify_area
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.put_pid
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.apparmor_socket_recvmsg
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.kmalloc_slab
      0.02 ±141%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.42 ±  3%      +0.1        0.48        perf-profile.children.cycles-pp.tick_sched_timer
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.menu_select
      0.40 ±  3%      +0.1        0.46 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.41 ±  3%      +0.1        0.47 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
      0.05 ± 84%      +0.1        0.11 ± 14%  perf-profile.children.cycles-pp.queue_event
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.shmem_write_end
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.perf_output_put_handle
      0.57 ±  2%      +0.1        0.63        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.05 ± 84%      +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.ordered_events__queue
      0.46 ±  3%      +0.1        0.53        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.56 ±  2%      +0.1        0.63        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.02 ±141%      +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.perf_output_end
      0.08 ± 16%      +0.1        0.16 ± 10%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.15 ± 16%      +0.1        0.24        perf-profile.children.cycles-pp.schedule_idle
      0.12            +0.1        0.21 ±  4%  perf-profile.children.cycles-pp.wait_for_unix_gc
      0.14 ±  3%      +0.1        0.23 ±  4%  perf-profile.children.cycles-pp.__might_fault
      0.06 ± 83%      +0.1        0.15 ±  8%  perf-profile.children.cycles-pp.process_simple
      0.07 ± 86%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.record__finish_output
      0.07 ± 86%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.perf_session__process_events
      0.03 ±141%      +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.shmem_getpage_gfp
      0.69 ±  3%      +0.1        0.78        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.63 ±  3%      +0.1        0.73        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.03 ±141%      +0.1        0.13 ± 13%  perf-profile.children.cycles-pp.shmem_write_begin
      0.25 ±  5%      +0.1        0.35 ±  4%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.07 ± 86%      +0.1        0.17 ±  7%  perf-profile.children.cycles-pp.cmd_record
      0.17 ±  4%      +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.__ksize
      0.10 ± 43%      +0.1        0.23 ±  6%  perf-profile.children.cycles-pp.memcpy_erms
      0.17 ± 14%      +0.1        0.30 ±  3%  perf-profile.children.cycles-pp.aa_file_perm
      0.19 ±  4%      +0.1        0.33 ±  2%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.21 ±  2%      +0.1        0.34 ±  3%  perf-profile.children.cycles-pp.__might_sleep
      0.11 ± 46%      +0.1        0.24 ±  5%  perf-profile.children.cycles-pp.perf_output_copy
      0.19 ± 41%      +0.1        0.33 ± 11%  perf-profile.children.cycles-pp.generic_perform_write
      0.19 ± 41%      +0.1        0.33 ± 12%  perf-profile.children.cycles-pp.__generic_file_write_iter
      0.19 ± 41%      +0.1        0.33 ± 11%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.26            +0.2        0.41 ±  3%  perf-profile.children.cycles-pp.fsnotify
      0.13 ±  3%      +0.2        0.29 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.24            +0.2        0.43 ±  2%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.29 ±  5%      +0.2        0.49 ±  4%  perf-profile.children.cycles-pp.__check_heap_object
      0.37 ± 18%      +0.2        0.58 ±  6%  perf-profile.children.cycles-pp.copyin
      0.33 ±  3%      +0.2        0.54 ±  4%  perf-profile.children.cycles-pp.___might_sleep
      0.11 ± 15%      +0.2        0.32 ±  5%  perf-profile.children.cycles-pp.drain_stock
      0.29            +0.2        0.51 ±  2%  perf-profile.children.cycles-pp.sock_recvmsg
      0.38 ±  3%      +0.2        0.61 ±  3%  perf-profile.children.cycles-pp.aa_sk_perm
      0.20 ± 45%      +0.2        0.43 ±  4%  perf-profile.children.cycles-pp.perf_output_sample
      0.12 ± 16%      +0.2        0.36 ±  2%  perf-profile.children.cycles-pp.refill_stock
      0.32 ±  7%      +0.2        0.56 ±  3%  perf-profile.children.cycles-pp.__build_skb_around
      0.46 ±  5%      +0.3        0.78 ±  3%  perf-profile.children.cycles-pp._copy_from_iter
      0.44 ±  7%      +0.3        0.76        perf-profile.children.cycles-pp.common_file_perm
      0.21 ± 15%      +0.4        0.56 ±  5%  perf-profile.children.cycles-pp.unfreeze_partials
      0.46 ±  6%      +0.4        0.81 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.23 ± 14%      +0.4        0.59 ±  3%  perf-profile.children.cycles-pp.put_cpu_partial
      0.09 ± 19%      +0.4        0.45 ±  3%  perf-profile.children.cycles-pp.try_charge
      0.36 ±  6%      +0.4        0.78 ±  7%  perf-profile.children.cycles-pp.mutex_lock
      0.62 ±  4%      +0.5        1.10        perf-profile.children.cycles-pp.security_file_permission
      0.83 ± 18%      +0.5        1.35        perf-profile.children.cycles-pp.copyout
      0.85 ±  4%      +0.6        1.45 ±  2%  perf-profile.children.cycles-pp.skb_copy_datagram_from_iter
      0.91 ± 10%      +0.6        1.53        perf-profile.children.cycles-pp.simple_copy_to_iter
      0.99 ± 15%      +0.6        1.62        perf-profile.children.cycles-pp._copy_to_iter
      0.26 ± 15%      +0.6        0.90        perf-profile.children.cycles-pp.mutex_unlock
      1.18 ± 18%      +0.7        1.88        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.47 ± 26%      +0.8        1.27        perf-profile.children.cycles-pp.unix_write_space
      0.96 ± 42%      +0.8        1.79        perf-profile.children.cycles-pp.intel_idle
      1.23 ±  8%      +0.9        2.09 ±  2%  perf-profile.children.cycles-pp.__check_object_size
      1.01 ± 41%      +0.9        1.87        perf-profile.children.cycles-pp.cpuidle_enter
      1.01 ± 41%      +0.9        1.87        perf-profile.children.cycles-pp.cpuidle_enter_state
      0.61 ± 20%      +0.9        1.51        perf-profile.children.cycles-pp.prepare_to_wait
      1.20 ± 36%      +1.0        2.23        perf-profile.children.cycles-pp.start_secondary
      1.22 ± 36%      +1.0        2.25        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      1.22 ± 36%      +1.0        2.25        perf-profile.children.cycles-pp.cpu_startup_entry
      1.22 ± 36%      +1.0        2.25        perf-profile.children.cycles-pp.do_idle
      0.44 ± 20%      +1.1        1.54        perf-profile.children.cycles-pp.fput_many
      0.49 ± 16%      +1.1        1.61 ±  2%  perf-profile.children.cycles-pp.skb_unlink
      1.95 ± 12%      +1.3        3.21        perf-profile.children.cycles-pp.__skb_datagram_iter
      1.97 ± 11%      +1.3        3.25        perf-profile.children.cycles-pp.skb_copy_datagram_iter
      1.99 ± 11%      +1.3        3.27        perf-profile.children.cycles-pp.unix_stream_read_actor
      0.70 ± 18%      +1.3        1.99        perf-profile.children.cycles-pp.skb_queue_tail
     49.60            +1.3       50.92        perf-profile.children.cycles-pp.ksys_write
      0.67 ± 16%      +1.6        2.25 ±  2%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.57 ±  7%      +1.6        2.18        perf-profile.children.cycles-pp.get_partial_node
      1.34 ± 18%      +1.7        3.02        perf-profile.children.cycles-pp.__fget_files
      1.52 ± 16%      +1.8        3.27        perf-profile.children.cycles-pp.__fget_light
      1.54 ± 16%      +1.8        3.32        perf-profile.children.cycles-pp.__fdget_pos
      1.20 ± 21%      +1.9        3.15        perf-profile.children.cycles-pp.sock_wfree
      0.94 ±  5%      +1.9        2.89        perf-profile.children.cycles-pp.___slab_alloc
      1.26 ± 19%      +2.0        3.22        perf-profile.children.cycles-pp.unix_destruct_scm
      0.97 ±  4%      +2.0        2.94        perf-profile.children.cycles-pp.__slab_alloc
      1.29 ± 18%      +2.0        3.26        perf-profile.children.cycles-pp.skb_release_all
      1.28 ± 19%      +2.0        3.25        perf-profile.children.cycles-pp.skb_release_head_state
     14.06 ±  6%      +2.3       16.34        perf-profile.children.cycles-pp.__kmalloc_node_track_caller
     14.10 ±  6%      +2.3       16.41        perf-profile.children.cycles-pp.kmalloc_reserve
      2.86 ± 18%      +2.3        5.20        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.92 ± 14%      +3.2        4.08        perf-profile.children.cycles-pp.__slab_free
      3.25 ± 16%      +3.3        6.54        perf-profile.children.cycles-pp._raw_spin_lock
      2.85 ±  7%      +3.9        6.75        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.53 ± 22%      +4.8        5.32 ± 10%  perf-profile.children.cycles-pp.propagate_protected_usage
      1.52 ± 25%     +13.6       15.15        perf-profile.children.cycles-pp.page_counter_cancel
      3.58 ± 17%     +13.7       17.30        perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      1.76 ± 24%     +15.3       17.10        perf-profile.children.cycles-pp.page_counter_uncharge
      2.39 ± 23%     +17.5       19.93        perf-profile.children.cycles-pp.obj_cgroup_charge_pages
      2.51 ± 23%     +17.6       20.16        perf-profile.children.cycles-pp.obj_cgroup_charge
      2.02 ± 26%     +17.7       19.70        perf-profile.children.cycles-pp.page_counter_try_charge
     14.66 ±  7%     -14.2        0.46 ±  2%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      9.63 ±  9%      -8.6        1.00        perf-profile.self.cycles-pp.kfree
      8.53 ± 13%      -7.1        1.43        perf-profile.self.cycles-pp.kmem_cache_free
      6.78 ±  4%      -5.9        0.84 ±  2%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      5.57 ±  2%      -5.0        0.58 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      4.56 ±  7%      -3.8        0.75 ±  2%  perf-profile.self.cycles-pp.mod_objcg_state
      2.10 ± 10%      -1.9        0.18 ±  2%  perf-profile.self.cycles-pp.get_mem_cgroup_from_objcg
      0.32 ± 49%      -0.2        0.08 ±  5%  perf-profile.self.cycles-pp.update_curr
      0.27 ± 37%      -0.2        0.09 ±  5%  perf-profile.self.cycles-pp.available_idle_cpu
      0.32 ± 33%      -0.2        0.15 ±  3%  perf-profile.self.cycles-pp.update_cfs_group
      0.15 ± 35%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.select_idle_cpu
      0.17 ± 42%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.update_rq_clock
      0.17 ± 41%      -0.1        0.06        perf-profile.self.cycles-pp.__switch_to_asm
      0.07 ± 12%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.ksys_write
      0.11 ± 12%      +0.0        0.13        perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.08 ± 10%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.rcu_read_unlock_strict
      0.08 ± 16%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.sock_sendmsg
      0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.ksys_read
      0.06 ±  8%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.rcu_all_qs
      0.08 ±  6%      +0.0        0.11        perf-profile.self.cycles-pp.unix_stream_recvmsg
      0.03 ± 70%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.unix_destruct_scm
      0.04 ± 71%      +0.0        0.07        perf-profile.self.cycles-pp.check_stack_object
      0.04 ± 71%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.05            +0.0        0.09        perf-profile.self.cycles-pp.sock_recvmsg
      0.04 ± 73%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.mem_cgroup_from_task
      0.07 ±  7%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.06 ±  8%      +0.0        0.10        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.alloc_skb_with_frags
      0.02 ±141%      +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.__skb_datagram_iter
      0.05            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.skb_copy_datagram_from_iter
      0.02 ±141%      +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.skb_unlink
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.wait_for_unix_gc
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.security_socket_getpeersec_dgram
      0.02 ±141%      +0.1        0.07        perf-profile.self.cycles-pp.perf_output_copy
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.__fdget_pos
      0.22 ±  8%      +0.1        0.27        perf-profile.self.cycles-pp.vfs_read
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.security_socket_recvmsg
      0.18 ±  2%      +0.1        0.24        perf-profile.self.cycles-pp.__fget_light
      0.10 ±  8%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp._copy_to_iter
      0.11 ±  4%      +0.1        0.17        perf-profile.self.cycles-pp._copy_from_iter
      0.08 ±  5%      +0.1        0.15 ±  5%  perf-profile.self.cycles-pp.security_file_permission
      0.14 ±  8%      +0.1        0.21 ±  7%  perf-profile.self.cycles-pp.new_sync_read
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.kmalloc_reserve
      0.09 ±  5%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.refill_obj_stock
      0.03 ±141%      +0.1        0.11 ± 12%  perf-profile.self.cycles-pp.queue_event
      0.02 ±141%      +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      0.18 ±  7%      +0.1        0.25 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.05 ± 77%      +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.perf_output_sample
      0.09 ± 13%      +0.1        0.18 ±  5%  perf-profile.self.cycles-pp.sock_alloc_send_pskb
      0.07 ± 12%      +0.1        0.16 ± 10%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.00            +0.1        0.09 ±  9%  perf-profile.self.cycles-pp.obj_cgroup_charge_pages
      0.14 ±  3%      +0.1        0.24 ±  9%  perf-profile.self.cycles-pp.new_sync_write
      0.11 ± 11%      +0.1        0.20 ±  4%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.21 ±  3%      +0.1        0.31        perf-profile.self.cycles-pp.sock_read_iter
      0.17 ±  2%      +0.1        0.28 ±  2%  perf-profile.self.cycles-pp.__ksize
      0.10 ± 43%      +0.1        0.22 ±  8%  perf-profile.self.cycles-pp.memcpy_erms
      0.16 ± 15%      +0.1        0.28 ±  3%  perf-profile.self.cycles-pp.aa_file_perm
      0.19 ±  2%      +0.1        0.31 ±  2%  perf-profile.self.cycles-pp.__might_sleep
      0.21 ±  4%      +0.1        0.33 ±  2%  perf-profile.self.cycles-pp.sock_write_iter
      0.10 ±  8%      +0.1        0.23 ±  4%  perf-profile.self.cycles-pp.unfreeze_partials
      0.18 ±  4%      +0.1        0.32 ±  2%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.25            +0.1        0.39 ±  3%  perf-profile.self.cycles-pp.fsnotify
      0.19 ±  6%      +0.1        0.33        perf-profile.self.cycles-pp.__entry_text_start
      0.20 ±  4%      +0.2        0.35        perf-profile.self.cycles-pp.aa_sk_perm
      0.23 ±  7%      +0.2        0.41 ±  6%  perf-profile.self.cycles-pp.__build_skb_around
      0.27 ±  3%      +0.2        0.46        perf-profile.self.cycles-pp.common_file_perm
      0.28 ±  5%      +0.2        0.48 ±  5%  perf-profile.self.cycles-pp.__check_heap_object
      0.15 ±  3%      +0.2        0.34 ±  2%  perf-profile.self.cycles-pp.get_partial_node
      0.33 ±  2%      +0.2        0.53 ±  4%  perf-profile.self.cycles-pp.___might_sleep
      0.32 ±  5%      +0.2        0.53 ±  3%  perf-profile.self.cycles-pp.__alloc_skb
      0.37 ± 10%      +0.2        0.62        perf-profile.self.cycles-pp.vfs_write
      0.16 ±  5%      +0.3        0.43        perf-profile.self.cycles-pp.unix_write_space
      0.17 ±  7%      +0.3        0.45        perf-profile.self.cycles-pp.consume_skb
      0.37 ±  4%      +0.3        0.71        perf-profile.self.cycles-pp.___slab_alloc
      0.45 ±  5%      +0.3        0.79 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.25 ±  4%      +0.4        0.62 ±  9%  perf-profile.self.cycles-pp.mutex_lock
      0.73 ±  9%      +0.4        1.17 ±  2%  perf-profile.self.cycles-pp.unix_stream_sendmsg
      0.69 ± 14%      +0.5        1.20 ±  2%  perf-profile.self.cycles-pp.__check_object_size
      0.79 ±  6%      +0.6        1.42        perf-profile.self.cycles-pp.unix_stream_read_generic
      0.26 ± 15%      +0.6        0.89        perf-profile.self.cycles-pp.mutex_unlock
      1.16 ± 18%      +0.7        1.85        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.96 ± 42%      +0.8        1.79        perf-profile.self.cycles-pp.intel_idle
      0.43 ± 20%      +1.1        1.52        perf-profile.self.cycles-pp.fput_many
      0.72 ± 17%      +1.1        1.85 ±  2%  perf-profile.self.cycles-pp.sock_wfree
      0.59 ± 22%      +1.2        1.78        perf-profile.self.cycles-pp.sock_def_readable
      0.67 ± 17%      +1.6        2.23 ±  2%  perf-profile.self.cycles-pp.skb_set_owner_w
      1.32 ± 18%      +1.7        2.98        perf-profile.self.cycles-pp.__fget_files
      1.47 ±  3%      +2.3        3.80        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      2.86 ± 18%      +2.3        5.19        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.75 ±  8%      +2.5        4.25        perf-profile.self.cycles-pp._raw_spin_lock
      0.91 ± 13%      +3.1        4.04        perf-profile.self.cycles-pp.__slab_free
      0.53 ± 22%      +4.8        5.28 ± 10%  perf-profile.self.cycles-pp.propagate_protected_usage
      1.51 ± 25%     +13.5       15.03        perf-profile.self.cycles-pp.page_counter_cancel
      1.71 ± 26%     +14.5       16.17        perf-profile.self.cycles-pp.page_counter_try_charge
      1035 ±  2%     -38.7%     634.67        interrupts.293:PCI-MSI.327680-edge.xhci_hcd
      2061 ± 70%     -99.6%       7.33 ± 89%  interrupts.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
  34513597           -20.2%   27541947 ±  2%  interrupts.CAL:Function_call_interrupts
    368907 ±  2%     -26.7%     270378 ±  3%  interrupts.CPU0.CAL:Function_call_interrupts
   2119856 ±  2%     -38.6%    1301096        interrupts.CPU0.LOC:Local_timer_interrupts
    812218 ±  2%     -55.1%     364825 ±  3%  interrupts.CPU0.RES:Rescheduling_interrupts
    283775           -25.6%     211144 ±  8%  interrupts.CPU0.TLB:TLB_shootdowns
    367731 ±  3%     -27.1%     268163 ±  5%  interrupts.CPU1.CAL:Function_call_interrupts
   2119951 ±  2%     -38.6%    1301019        interrupts.CPU1.LOC:Local_timer_interrupts
    803406 ±  2%     -54.5%     365533 ±  3%  interrupts.CPU1.RES:Rescheduling_interrupts
    283930           -25.9%     210521 ±  8%  interrupts.CPU1.TLB:TLB_shootdowns
      1035 ±  2%     -38.7%     634.67        interrupts.CPU10.293:PCI-MSI.327680-edge.xhci_hcd
    359552           -26.2%     265312 ±  4%  interrupts.CPU10.CAL:Function_call_interrupts
   2119851 ±  2%     -38.6%    1300937        interrupts.CPU10.LOC:Local_timer_interrupts
    814814 ±  2%     -55.4%     363149 ±  4%  interrupts.CPU10.RES:Rescheduling_interrupts
    283873           -25.7%     210796 ±  8%  interrupts.CPU10.TLB:TLB_shootdowns
    356220           -25.3%     266202 ±  4%  interrupts.CPU11.CAL:Function_call_interrupts
   2119790 ±  2%     -38.6%    1301000        interrupts.CPU11.LOC:Local_timer_interrupts
    803621 ±  5%     -54.5%     365317 ±  4%  interrupts.CPU11.RES:Rescheduling_interrupts
    283231           -25.8%     210126 ±  7%  interrupts.CPU11.TLB:TLB_shootdowns
    355040           -24.2%     269225 ±  4%  interrupts.CPU12.CAL:Function_call_interrupts
   2119856 ±  2%     -38.6%    1300930        interrupts.CPU12.LOC:Local_timer_interrupts
      4336           +66.9%       7236 ± 28%  interrupts.CPU12.NMI:Non-maskable_interrupts
      4336           +66.9%       7236 ± 28%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
    797486 ±  4%     -54.7%     360915 ±  3%  interrupts.CPU12.RES:Rescheduling_interrupts
    281724           -24.7%     212031 ±  8%  interrupts.CPU12.TLB:TLB_shootdowns
    355443           -25.6%     264475 ±  4%  interrupts.CPU13.CAL:Function_call_interrupts
   2119919 ±  2%     -38.6%    1300988        interrupts.CPU13.LOC:Local_timer_interrupts
      4337           +99.9%       8669        interrupts.CPU13.NMI:Non-maskable_interrupts
      4337           +99.9%       8669        interrupts.CPU13.PMI:Performance_monitoring_interrupts
    811518 ±  4%     -55.8%     358818 ±  3%  interrupts.CPU13.RES:Rescheduling_interrupts
    281929           -25.5%     209995 ±  7%  interrupts.CPU13.TLB:TLB_shootdowns
    353684           -24.8%     266124 ±  4%  interrupts.CPU14.CAL:Function_call_interrupts
   2119942 ±  2%     -38.6%    1301027        interrupts.CPU14.LOC:Local_timer_interrupts
    805398 ±  2%     -55.2%     360840 ±  3%  interrupts.CPU14.RES:Rescheduling_interrupts
    282195           -25.2%     210959 ±  8%  interrupts.CPU14.TLB:TLB_shootdowns
    358831           -26.2%     264773 ±  4%  interrupts.CPU15.CAL:Function_call_interrupts
   2119901 ±  2%     -38.6%    1300980        interrupts.CPU15.LOC:Local_timer_interrupts
    809550 ±  3%     -54.1%     371481 ±  5%  interrupts.CPU15.RES:Rescheduling_interrupts
    282360           -26.0%     208905 ±  7%  interrupts.CPU15.TLB:TLB_shootdowns
    357218 ±  2%     -25.5%     266176 ±  5%  interrupts.CPU16.CAL:Function_call_interrupts
   2119840 ±  2%     -38.6%    1300868        interrupts.CPU16.LOC:Local_timer_interrupts
    807752 ±  4%     -55.6%     358709 ±  4%  interrupts.CPU16.RES:Rescheduling_interrupts
    282023           -25.1%     211191 ±  8%  interrupts.CPU16.TLB:TLB_shootdowns
    353491           -24.6%     266521 ±  5%  interrupts.CPU17.CAL:Function_call_interrupts
   2119889 ±  2%     -38.6%    1301353        interrupts.CPU17.LOC:Local_timer_interrupts
    803176 ±  4%     -54.9%     362121 ±  4%  interrupts.CPU17.RES:Rescheduling_interrupts
    283156           -25.6%     210804 ±  8%  interrupts.CPU17.TLB:TLB_shootdowns
    369223           -28.6%     263612 ±  5%  interrupts.CPU18.CAL:Function_call_interrupts
   2119849 ±  2%     -38.6%    1300973        interrupts.CPU18.LOC:Local_timer_interrupts
    820678 ±  2%     -56.1%     360476 ±  3%  interrupts.CPU18.RES:Rescheduling_interrupts
    282877           -26.0%     209452 ±  8%  interrupts.CPU18.TLB:TLB_shootdowns
    360224 ±  2%     -25.5%     268239 ±  5%  interrupts.CPU19.CAL:Function_call_interrupts
   2119893 ±  2%     -38.6%    1300994        interrupts.CPU19.LOC:Local_timer_interrupts
    812017 ±  3%     -55.6%     360262 ±  4%  interrupts.CPU19.RES:Rescheduling_interrupts
    281870           -25.2%     210898 ±  8%  interrupts.CPU19.TLB:TLB_shootdowns
    370625 ±  4%     -27.9%     267036 ±  4%  interrupts.CPU2.CAL:Function_call_interrupts
   2119969 ±  2%     -38.6%    1301015        interrupts.CPU2.LOC:Local_timer_interrupts
    809689 ±  4%     -55.1%     363170 ±  4%  interrupts.CPU2.RES:Rescheduling_interrupts
    283090           -25.8%     209936 ±  8%  interrupts.CPU2.TLB:TLB_shootdowns
    363794 ±  4%     -26.7%     266675 ±  5%  interrupts.CPU20.CAL:Function_call_interrupts
   2119879 ±  2%     -38.6%    1300983        interrupts.CPU20.LOC:Local_timer_interrupts
    825023 ±  4%     -56.1%     361999 ±  4%  interrupts.CPU20.RES:Rescheduling_interrupts
    283395           -25.3%     211775 ±  8%  interrupts.CPU20.TLB:TLB_shootdowns
    361556           -26.4%     266160 ±  4%  interrupts.CPU21.CAL:Function_call_interrupts
   2119908 ±  2%     -38.6%    1300940        interrupts.CPU21.LOC:Local_timer_interrupts
    814183 ±  2%     -55.6%     361282 ±  3%  interrupts.CPU21.RES:Rescheduling_interrupts
    282265           -25.1%     211288 ±  8%  interrupts.CPU21.TLB:TLB_shootdowns
    355653           -25.5%     264787 ±  4%  interrupts.CPU22.CAL:Function_call_interrupts
   2119941 ±  2%     -38.6%    1300980        interrupts.CPU22.LOC:Local_timer_interrupts
    816087 ±  4%     -55.7%     361817 ±  4%  interrupts.CPU22.RES:Rescheduling_interrupts
    282442           -25.5%     210351 ±  8%  interrupts.CPU22.TLB:TLB_shootdowns
    351805           -24.6%     265103 ±  4%  interrupts.CPU23.CAL:Function_call_interrupts
   2119801 ±  2%     -38.6%    1301003        interrupts.CPU23.LOC:Local_timer_interrupts
    814899 ±  4%     -55.5%     363012 ±  4%  interrupts.CPU23.RES:Rescheduling_interrupts
    282562           -25.7%     209819 ±  8%  interrupts.CPU23.TLB:TLB_shootdowns
    367069 ±  3%     -12.2%     322114 ±  5%  interrupts.CPU24.CAL:Function_call_interrupts
   2119886 ±  2%     -38.6%    1301077        interrupts.CPU24.LOC:Local_timer_interrupts
    835110 ±  9%     -42.5%     480170 ±  5%  interrupts.CPU24.RES:Rescheduling_interrupts
    282311           -25.7%     209822 ±  8%  interrupts.CPU24.TLB:TLB_shootdowns
    354801 ±  2%     -13.9%     305538 ±  3%  interrupts.CPU25.CAL:Function_call_interrupts
   2119830 ±  2%     -38.6%    1301028        interrupts.CPU25.LOC:Local_timer_interrupts
    825755 ±  8%     -41.6%     482630 ±  5%  interrupts.CPU25.RES:Rescheduling_interrupts
    282684           -26.4%     207993 ±  8%  interrupts.CPU25.TLB:TLB_shootdowns
    356396 ±  2%     -13.6%     307990 ±  2%  interrupts.CPU26.CAL:Function_call_interrupts
   2119870 ±  2%     -38.6%    1300993        interrupts.CPU26.LOC:Local_timer_interrupts
    823243 ±  9%     -41.7%     479552 ±  5%  interrupts.CPU26.RES:Rescheduling_interrupts
    282459           -26.2%     208574 ±  9%  interrupts.CPU26.TLB:TLB_shootdowns
    351046 ±  2%     -12.2%     308053 ±  2%  interrupts.CPU27.CAL:Function_call_interrupts
   2119824 ±  2%     -38.6%    1301033        interrupts.CPU27.LOC:Local_timer_interrupts
    827963 ±  8%     -41.9%     480986 ±  5%  interrupts.CPU27.RES:Rescheduling_interrupts
    282131           -27.7%     204108 ±  8%  interrupts.CPU27.TLB:TLB_shootdowns
    359618 ±  4%     -13.2%     312133 ±  3%  interrupts.CPU28.CAL:Function_call_interrupts
   2119793 ±  2%     -38.6%    1301032        interrupts.CPU28.LOC:Local_timer_interrupts
      8696           -33.5%       5784 ± 35%  interrupts.CPU28.NMI:Non-maskable_interrupts
      8696           -33.5%       5784 ± 35%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
    819538 ±  8%     -41.2%     481990 ±  5%  interrupts.CPU28.RES:Rescheduling_interrupts
    283227           -26.9%     206966 ±  8%  interrupts.CPU28.TLB:TLB_shootdowns
    360296 ±  4%     -15.9%     303086 ±  3%  interrupts.CPU29.CAL:Function_call_interrupts
   2119786 ±  2%     -38.6%    1300995        interrupts.CPU29.LOC:Local_timer_interrupts
    828226 ±  8%     -41.3%     485772 ±  4%  interrupts.CPU29.RES:Rescheduling_interrupts
    281734           -26.9%     206077 ±  9%  interrupts.CPU29.TLB:TLB_shootdowns
    365972 ±  2%     -27.5%     265304 ±  5%  interrupts.CPU3.CAL:Function_call_interrupts
   2119935 ±  2%     -38.6%    1300929        interrupts.CPU3.LOC:Local_timer_interrupts
    807232 ±  4%     -55.3%     360556 ±  4%  interrupts.CPU3.RES:Rescheduling_interrupts
    281844           -25.1%     211103 ±  8%  interrupts.CPU3.TLB:TLB_shootdowns
    362207 ±  3%     -15.3%     306933 ±  3%  interrupts.CPU30.CAL:Function_call_interrupts
   2119862 ±  2%     -38.6%    1301014        interrupts.CPU30.LOC:Local_timer_interrupts
    831773 ± 11%     -41.9%     483182 ±  5%  interrupts.CPU30.RES:Rescheduling_interrupts
    283263           -26.8%     207298 ±  9%  interrupts.CPU30.TLB:TLB_shootdowns
    354519 ±  3%     -13.8%     305505 ±  2%  interrupts.CPU31.CAL:Function_call_interrupts
   2119829 ±  2%     -38.6%    1300963        interrupts.CPU31.LOC:Local_timer_interrupts
    826965 ±  8%     -41.3%     485597 ±  5%  interrupts.CPU31.RES:Rescheduling_interrupts
    282101           -26.2%     208117 ±  8%  interrupts.CPU31.TLB:TLB_shootdowns
    352696 ±  2%     -12.9%     307084 ±  2%  interrupts.CPU32.CAL:Function_call_interrupts
   2119862 ±  2%     -38.6%    1300977        interrupts.CPU32.LOC:Local_timer_interrupts
    830140 ±  9%     -40.8%     491128 ±  8%  interrupts.CPU32.RES:Rescheduling_interrupts
    282170           -26.5%     207510 ±  9%  interrupts.CPU32.TLB:TLB_shootdowns
    350705 ±  3%     -12.4%     307282 ±  3%  interrupts.CPU33.CAL:Function_call_interrupts
   2119781 ±  2%     -38.6%    1300996        interrupts.CPU33.LOC:Local_timer_interrupts
      7248 ± 28%     -20.2%       5787 ± 35%  interrupts.CPU33.NMI:Non-maskable_interrupts
      7248 ± 28%     -20.2%       5787 ± 35%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
    799213 ±  8%     -39.4%     483989 ±  7%  interrupts.CPU33.RES:Rescheduling_interrupts
    282340           -26.3%     207986 ±  8%  interrupts.CPU33.TLB:TLB_shootdowns
    351990 ±  3%     -12.2%     308916 ±  2%  interrupts.CPU34.CAL:Function_call_interrupts
   2119839 ±  2%     -38.6%    1301012        interrupts.CPU34.LOC:Local_timer_interrupts
      8699           -33.5%       5785 ± 35%  interrupts.CPU34.NMI:Non-maskable_interrupts
      8699           -33.5%       5785 ± 35%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    819942 ±  7%     -40.7%     486547 ±  4%  interrupts.CPU34.RES:Rescheduling_interrupts
    281682           -26.3%     207623 ±  8%  interrupts.CPU34.TLB:TLB_shootdowns
    353078 ±  2%     -13.2%     306565 ±  3%  interrupts.CPU35.CAL:Function_call_interrupts
   2119891 ±  2%     -38.6%    1301004        interrupts.CPU35.LOC:Local_timer_interrupts
      8698           -33.5%       5787 ± 35%  interrupts.CPU35.NMI:Non-maskable_interrupts
      8698           -33.5%       5787 ± 35%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
    817431 ±  8%     -40.8%     483991 ±  5%  interrupts.CPU35.RES:Rescheduling_interrupts
    281829           -26.1%     208224 ±  8%  interrupts.CPU35.TLB:TLB_shootdowns
    361728           -15.5%     305716 ±  2%  interrupts.CPU36.CAL:Function_call_interrupts
   2119868 ±  2%     -38.6%    1300969        interrupts.CPU36.LOC:Local_timer_interrupts
    809352 ±  8%     -40.1%     484977 ±  6%  interrupts.CPU36.RES:Rescheduling_interrupts
    284457           -27.2%     207116 ±  9%  interrupts.CPU36.TLB:TLB_shootdowns
    366085 ±  2%     -14.8%     311826 ±  2%  interrupts.CPU37.CAL:Function_call_interrupts
   2119856 ±  2%     -38.6%    1301083        interrupts.CPU37.LOC:Local_timer_interrupts
    835957 ±  9%     -40.8%     494569 ±  6%  interrupts.CPU37.RES:Rescheduling_interrupts
    281493           -26.0%     208334 ±  8%  interrupts.CPU37.TLB:TLB_shootdowns
    359733 ±  3%     -15.4%     304308        interrupts.CPU38.CAL:Function_call_interrupts
   2119729 ±  2%     -38.6%    1300970        interrupts.CPU38.LOC:Local_timer_interrupts
    832813 ±  8%     -41.9%     483493 ±  3%  interrupts.CPU38.RES:Rescheduling_interrupts
    282618           -27.0%     206231 ±  8%  interrupts.CPU38.TLB:TLB_shootdowns
    355683 ±  2%     -14.8%     303093 ±  2%  interrupts.CPU39.CAL:Function_call_interrupts
   2119922 ±  2%     -38.6%    1300951        interrupts.CPU39.LOC:Local_timer_interrupts
    824329 ±  8%     -41.0%     486495 ±  4%  interrupts.CPU39.RES:Rescheduling_interrupts
    282567           -27.1%     205979 ±  8%  interrupts.CPU39.TLB:TLB_shootdowns
      2060 ± 70%     -99.7%       7.00 ± 95%  interrupts.CPU4.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
    361473           -26.2%     266725 ±  5%  interrupts.CPU4.CAL:Function_call_interrupts
   2119917 ±  2%     -38.6%    1300986        interrupts.CPU4.LOC:Local_timer_interrupts
    793250 ±  3%     -53.8%     366590 ±  5%  interrupts.CPU4.RES:Rescheduling_interrupts
    281957           -24.9%     211664 ±  8%  interrupts.CPU4.TLB:TLB_shootdowns
    355060           -14.4%     303790 ±  2%  interrupts.CPU40.CAL:Function_call_interrupts
   2119887 ±  2%     -38.6%    1300979        interrupts.CPU40.LOC:Local_timer_interrupts
      8701           -33.5%       5782 ± 35%  interrupts.CPU40.NMI:Non-maskable_interrupts
      8701           -33.5%       5782 ± 35%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    838720 ±  5%     -41.7%     489153 ±  6%  interrupts.CPU40.RES:Rescheduling_interrupts
    282183           -26.5%     207488 ±  8%  interrupts.CPU40.TLB:TLB_shootdowns
    358851 ±  3%     -16.1%     301031 ±  2%  interrupts.CPU41.CAL:Function_call_interrupts
   2119838 ±  2%     -38.6%    1301063        interrupts.CPU41.LOC:Local_timer_interrupts
      8706           -33.6%       5785 ± 35%  interrupts.CPU41.NMI:Non-maskable_interrupts
      8706           -33.6%       5785 ± 35%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    824491 ±  7%     -40.7%     488745 ±  5%  interrupts.CPU41.RES:Rescheduling_interrupts
    282520           -27.0%     206344 ±  8%  interrupts.CPU41.TLB:TLB_shootdowns
    356041 ±  2%     -12.7%     310979 ±  3%  interrupts.CPU42.CAL:Function_call_interrupts
   2119859 ±  2%     -38.6%    1300984        interrupts.CPU42.LOC:Local_timer_interrupts
    821458 ±  8%     -40.7%     486800 ±  4%  interrupts.CPU42.RES:Rescheduling_interrupts
    283442           -26.6%     208104 ±  8%  interrupts.CPU42.TLB:TLB_shootdowns
    354867           -13.2%     308097        interrupts.CPU43.CAL:Function_call_interrupts
   2119882 ±  2%     -38.6%    1300957        interrupts.CPU43.LOC:Local_timer_interrupts
      7247 ± 28%     -20.1%       5789 ± 35%  interrupts.CPU43.NMI:Non-maskable_interrupts
      7247 ± 28%     -20.1%       5789 ± 35%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
    827624 ±  7%     -40.9%     488757 ±  6%  interrupts.CPU43.RES:Rescheduling_interrupts
    282435           -26.6%     207171 ±  9%  interrupts.CPU43.TLB:TLB_shootdowns
    373041 ±  2%     -17.7%     307007 ±  3%  interrupts.CPU44.CAL:Function_call_interrupts
   2119885 ±  2%     -38.6%    1300981        interrupts.CPU44.LOC:Local_timer_interrupts
    830281 ±  7%     -41.7%     483990 ±  5%  interrupts.CPU44.RES:Rescheduling_interrupts
    283518           -26.7%     207742 ±  8%  interrupts.CPU44.TLB:TLB_shootdowns
    351747 ±  2%     -11.2%     312289 ±  3%  interrupts.CPU45.CAL:Function_call_interrupts
   2119834 ±  2%     -38.6%    1300916        interrupts.CPU45.LOC:Local_timer_interrupts
    815498 ±  6%     -40.7%     483675 ±  6%  interrupts.CPU45.RES:Rescheduling_interrupts
    282616           -26.3%     208400 ±  8%  interrupts.CPU45.TLB:TLB_shootdowns
    362954 ±  3%     -15.7%     305932 ±  2%  interrupts.CPU46.CAL:Function_call_interrupts
   2119937 ±  2%     -38.6%    1300973        interrupts.CPU46.LOC:Local_timer_interrupts
      7247 ± 28%     -20.1%       5787 ± 35%  interrupts.CPU46.NMI:Non-maskable_interrupts
      7247 ± 28%     -20.1%       5787 ± 35%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
    823684 ±  8%     -41.2%     484716 ±  6%  interrupts.CPU46.RES:Rescheduling_interrupts
    282220           -26.8%     206567 ±  8%  interrupts.CPU46.TLB:TLB_shootdowns
    366811 ±  5%     -14.0%     315291 ±  3%  interrupts.CPU47.CAL:Function_call_interrupts
   2119855 ±  2%     -38.6%    1300980        interrupts.CPU47.LOC:Local_timer_interrupts
    834351 ±  7%     -41.7%     486720 ±  6%  interrupts.CPU47.RES:Rescheduling_interrupts
    281754           -26.8%     206297 ±  8%  interrupts.CPU47.TLB:TLB_shootdowns
    371972 ±  2%     -27.8%     268510 ±  3%  interrupts.CPU48.CAL:Function_call_interrupts
   2120137 ±  2%     -38.6%    1300949        interrupts.CPU48.LOC:Local_timer_interrupts
    831543 ±  5%     -56.0%     365606 ±  3%  interrupts.CPU48.RES:Rescheduling_interrupts
    283642           -25.5%     211447 ±  8%  interrupts.CPU48.TLB:TLB_shootdowns
    365126 ±  2%     -27.1%     266018 ±  4%  interrupts.CPU49.CAL:Function_call_interrupts
   2119947 ±  2%     -38.6%    1300980        interrupts.CPU49.LOC:Local_timer_interrupts
    814887           -54.8%     368103 ±  4%  interrupts.CPU49.RES:Rescheduling_interrupts
    282397           -25.6%     210209 ±  8%  interrupts.CPU49.TLB:TLB_shootdowns
    362492           -26.9%     265013 ±  4%  interrupts.CPU5.CAL:Function_call_interrupts
   2119896 ±  2%     -38.6%    1301006        interrupts.CPU5.LOC:Local_timer_interrupts
    808080 ±  3%     -55.5%     359740 ±  3%  interrupts.CPU5.RES:Rescheduling_interrupts
    284391           -25.9%     210684 ±  7%  interrupts.CPU5.TLB:TLB_shootdowns
    372563 ±  4%     -28.7%     265793 ±  4%  interrupts.CPU50.CAL:Function_call_interrupts
   2119866 ±  2%     -38.6%    1301041        interrupts.CPU50.LOC:Local_timer_interrupts
    806873 ±  3%     -54.5%     366775 ±  4%  interrupts.CPU50.RES:Rescheduling_interrupts
    281229           -25.5%     209593 ±  8%  interrupts.CPU50.TLB:TLB_shootdowns
    359331           -25.3%     268482 ±  5%  interrupts.CPU51.CAL:Function_call_interrupts
   2119870 ±  2%     -38.6%    1300995        interrupts.CPU51.LOC:Local_timer_interrupts
    813446 ±  3%     -55.0%     365731 ±  4%  interrupts.CPU51.RES:Rescheduling_interrupts
    281624           -24.9%     211572 ±  9%  interrupts.CPU51.TLB:TLB_shootdowns
    361659           -26.6%     265453 ±  5%  interrupts.CPU52.CAL:Function_call_interrupts
   2119882 ±  2%     -38.6%    1301026        interrupts.CPU52.LOC:Local_timer_interrupts
    812992 ±  2%     -55.2%     363860 ±  5%  interrupts.CPU52.RES:Rescheduling_interrupts
    280855           -24.8%     211171 ±  8%  interrupts.CPU52.TLB:TLB_shootdowns
    365036 ±  3%     -27.3%     265284 ±  5%  interrupts.CPU53.CAL:Function_call_interrupts
   2119930 ±  2%     -38.6%    1300980        interrupts.CPU53.LOC:Local_timer_interrupts
    811759 ±  4%     -54.8%     366964 ±  3%  interrupts.CPU53.RES:Rescheduling_interrupts
    281353           -25.3%     210038 ±  8%  interrupts.CPU53.TLB:TLB_shootdowns
    361816           -26.4%     266348 ±  5%  interrupts.CPU54.CAL:Function_call_interrupts
   2119855 ±  2%     -38.6%    1300980        interrupts.CPU54.LOC:Local_timer_interrupts
    808810 ±  4%     -54.8%     365755 ±  5%  interrupts.CPU54.RES:Rescheduling_interrupts
    283099           -25.5%     210881 ±  8%  interrupts.CPU54.TLB:TLB_shootdowns
    361246 ±  2%     -26.2%     266588 ±  5%  interrupts.CPU55.CAL:Function_call_interrupts
   2119871 ±  2%     -38.6%    1300962        interrupts.CPU55.LOC:Local_timer_interrupts
      8689           -33.5%       5777 ± 35%  interrupts.CPU55.NMI:Non-maskable_interrupts
      8689           -33.5%       5777 ± 35%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
    806805           -54.7%     365382 ±  2%  interrupts.CPU55.RES:Rescheduling_interrupts
    281909           -25.3%     210697 ±  8%  interrupts.CPU55.TLB:TLB_shootdowns
    357802           -25.8%     265445 ±  5%  interrupts.CPU56.CAL:Function_call_interrupts
   2119920 ±  2%     -38.6%    1300878        interrupts.CPU56.LOC:Local_timer_interrupts
    806616 ±  4%     -54.7%     365515 ±  3%  interrupts.CPU56.RES:Rescheduling_interrupts
    282887           -25.8%     209842 ±  9%  interrupts.CPU56.TLB:TLB_shootdowns
    363924           -27.2%     265089 ±  4%  interrupts.CPU57.CAL:Function_call_interrupts
   2119867 ±  2%     -38.6%    1300963        interrupts.CPU57.LOC:Local_timer_interrupts
    825721 ±  2%     -55.7%     365657 ±  4%  interrupts.CPU57.RES:Rescheduling_interrupts
    283114           -26.1%     209195 ±  8%  interrupts.CPU57.TLB:TLB_shootdowns
    359218           -25.7%     266792 ±  4%  interrupts.CPU58.CAL:Function_call_interrupts
   2119900 ±  2%     -38.6%    1300974        interrupts.CPU58.LOC:Local_timer_interrupts
    814790 ±  2%     -55.2%     365024 ±  4%  interrupts.CPU58.RES:Rescheduling_interrupts
    284315           -25.8%     211103 ±  8%  interrupts.CPU58.TLB:TLB_shootdowns
    353017           -25.3%     263770 ±  4%  interrupts.CPU59.CAL:Function_call_interrupts
   2120229 ±  2%     -38.6%    1301036        interrupts.CPU59.LOC:Local_timer_interrupts
    826820 ±  3%     -55.7%     366452 ±  2%  interrupts.CPU59.RES:Rescheduling_interrupts
    282445           -26.1%     208807 ±  8%  interrupts.CPU59.TLB:TLB_shootdowns
    362620 ±  2%     -26.5%     266662 ±  5%  interrupts.CPU6.CAL:Function_call_interrupts
   2119893 ±  2%     -38.6%    1300993        interrupts.CPU6.LOC:Local_timer_interrupts
    818353 ±  2%     -55.3%     365437 ±  3%  interrupts.CPU6.RES:Rescheduling_interrupts
    282749           -25.5%     210705 ±  8%  interrupts.CPU6.TLB:TLB_shootdowns
    359979           -26.2%     265811 ±  4%  interrupts.CPU60.CAL:Function_call_interrupts
   2119911 ±  2%     -38.6%    1300985        interrupts.CPU60.LOC:Local_timer_interrupts
    812179           -55.4%     362609 ±  3%  interrupts.CPU60.RES:Rescheduling_interrupts
    279783           -25.1%     209643 ±  8%  interrupts.CPU60.TLB:TLB_shootdowns
    354979 ±  2%     -25.4%     264861 ±  4%  interrupts.CPU61.CAL:Function_call_interrupts
   2119902 ±  2%     -38.6%    1300997        interrupts.CPU61.LOC:Local_timer_interrupts
      7247 ± 28%     -20.3%       5779 ± 35%  interrupts.CPU61.NMI:Non-maskable_interrupts
      7247 ± 28%     -20.3%       5779 ± 35%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
    819685 ±  4%     -55.5%     364604 ±  4%  interrupts.CPU61.RES:Rescheduling_interrupts
    281822           -25.3%     210582 ±  7%  interrupts.CPU61.TLB:TLB_shootdowns
    359968 ±  2%     -26.6%     264076 ±  5%  interrupts.CPU62.CAL:Function_call_interrupts
   2119923 ±  2%     -38.6%    1301007        interrupts.CPU62.LOC:Local_timer_interrupts
    828254 ±  4%     -56.2%     362818 ±  2%  interrupts.CPU62.RES:Rescheduling_interrupts
    283352           -25.8%     210223 ±  8%  interrupts.CPU62.TLB:TLB_shootdowns
    359513           -25.4%     268366 ±  4%  interrupts.CPU63.CAL:Function_call_interrupts
   2119866 ±  2%     -38.6%    1300992        interrupts.CPU63.LOC:Local_timer_interrupts
    823114 ±  3%     -54.5%     374511 ±  4%  interrupts.CPU63.RES:Rescheduling_interrupts
    284346           -25.8%     211013 ±  8%  interrupts.CPU63.TLB:TLB_shootdowns
    355308           -24.4%     268553 ±  5%  interrupts.CPU64.CAL:Function_call_interrupts
   2119890 ±  2%     -38.6%    1300994        interrupts.CPU64.LOC:Local_timer_interrupts
    820093 ±  3%     -55.0%     369177 ±  3%  interrupts.CPU64.RES:Rescheduling_interrupts
    281798           -24.8%     211816 ±  8%  interrupts.CPU64.TLB:TLB_shootdowns
    353896           -24.6%     266987 ±  5%  interrupts.CPU65.CAL:Function_call_interrupts
   2120192 ±  2%     -38.6%    1300991        interrupts.CPU65.LOC:Local_timer_interrupts
    801381 ±  2%     -54.6%     363683 ±  4%  interrupts.CPU65.RES:Rescheduling_interrupts
    282158           -24.9%     211770 ±  8%  interrupts.CPU65.TLB:TLB_shootdowns
    366366 ±  2%     -27.7%     264707 ±  5%  interrupts.CPU66.CAL:Function_call_interrupts
   2119921 ±  2%     -38.6%    1301001        interrupts.CPU66.LOC:Local_timer_interrupts
    827378 ±  4%     -55.6%     367513 ±  3%  interrupts.CPU66.RES:Rescheduling_interrupts
    284318           -26.0%     210365 ±  8%  interrupts.CPU66.TLB:TLB_shootdowns
    359424 ±  2%     -26.2%     265353 ±  5%  interrupts.CPU67.CAL:Function_call_interrupts
   2119937 ±  2%     -38.6%    1300997        interrupts.CPU67.LOC:Local_timer_interrupts
    831078 ±  3%     -55.8%     367348 ±  3%  interrupts.CPU67.RES:Rescheduling_interrupts
    283433           -26.1%     209371 ±  8%  interrupts.CPU67.TLB:TLB_shootdowns
    367202 ±  4%     -27.4%     266612 ±  4%  interrupts.CPU68.CAL:Function_call_interrupts
   2119935 ±  2%     -38.6%    1301228        interrupts.CPU68.LOC:Local_timer_interrupts
    825675 ±  6%     -55.3%     369425 ±  4%  interrupts.CPU68.RES:Rescheduling_interrupts
    283359           -25.2%     212010 ±  8%  interrupts.CPU68.TLB:TLB_shootdowns
    359414           -25.6%     267404 ±  5%  interrupts.CPU69.CAL:Function_call_interrupts
   2119895 ±  2%     -38.6%    1300944        interrupts.CPU69.LOC:Local_timer_interrupts
    820401 ±  4%     -55.5%     365244 ±  4%  interrupts.CPU69.RES:Rescheduling_interrupts
    281400           -24.7%     211949 ±  8%  interrupts.CPU69.TLB:TLB_shootdowns
    356951           -25.3%     266527 ±  4%  interrupts.CPU7.CAL:Function_call_interrupts
   2119878 ±  2%     -38.6%    1300996        interrupts.CPU7.LOC:Local_timer_interrupts
    799545           -55.2%     358272 ±  3%  interrupts.CPU7.RES:Rescheduling_interrupts
    282123           -25.0%     211614 ±  7%  interrupts.CPU7.TLB:TLB_shootdowns
    357682           -26.0%     264598 ±  5%  interrupts.CPU70.CAL:Function_call_interrupts
   2119917 ±  2%     -38.6%    1301016        interrupts.CPU70.LOC:Local_timer_interrupts
    821840 ±  3%     -55.6%     364547 ±  5%  interrupts.CPU70.RES:Rescheduling_interrupts
    283191           -25.5%     210980 ±  8%  interrupts.CPU70.TLB:TLB_shootdowns
    352930           -24.8%     265466 ±  5%  interrupts.CPU71.CAL:Function_call_interrupts
   2119911 ±  2%     -38.6%    1301039        interrupts.CPU71.LOC:Local_timer_interrupts
    815992 ±  5%     -54.9%     368007 ±  4%  interrupts.CPU71.RES:Rescheduling_interrupts
    283086           -25.9%     209679 ±  8%  interrupts.CPU71.TLB:TLB_shootdowns
    364592 ±  3%     -15.5%     308066 ±  2%  interrupts.CPU72.CAL:Function_call_interrupts
   2119902 ±  2%     -38.6%    1300933        interrupts.CPU72.LOC:Local_timer_interrupts
    835551 ±  8%     -41.7%     486909 ±  6%  interrupts.CPU72.RES:Rescheduling_interrupts
    280133           -25.3%     209233 ±  8%  interrupts.CPU72.TLB:TLB_shootdowns
    351807           -13.0%     306170 ±  2%  interrupts.CPU73.CAL:Function_call_interrupts
   2119872 ±  2%     -38.6%    1300983        interrupts.CPU73.LOC:Local_timer_interrupts
    831527 ± 10%     -41.3%     488274 ±  4%  interrupts.CPU73.RES:Rescheduling_interrupts
    281603           -25.9%     208583 ±  8%  interrupts.CPU73.TLB:TLB_shootdowns
    354247 ±  2%     -13.9%     304924 ±  2%  interrupts.CPU74.CAL:Function_call_interrupts
   2119865 ±  2%     -38.6%    1301006        interrupts.CPU74.LOC:Local_timer_interrupts
    829757 ±  8%     -41.4%     486188 ±  6%  interrupts.CPU74.RES:Rescheduling_interrupts
    282369           -26.5%     207625 ±  8%  interrupts.CPU74.TLB:TLB_shootdowns
    350160 ±  2%     -12.4%     306807 ±  2%  interrupts.CPU75.CAL:Function_call_interrupts
   2119900 ±  2%     -38.6%    1301006        interrupts.CPU75.LOC:Local_timer_interrupts
    841206 ±  9%     -41.5%     491757 ±  4%  interrupts.CPU75.RES:Rescheduling_interrupts
    281358           -26.5%     206842 ±  8%  interrupts.CPU75.TLB:TLB_shootdowns
    356553 ±  4%     -10.6%     318664 ±  7%  interrupts.CPU76.CAL:Function_call_interrupts
   2119972 ±  2%     -38.6%    1301004        interrupts.CPU76.LOC:Local_timer_interrupts
    845781 ± 11%     -42.3%     487978 ±  5%  interrupts.CPU76.RES:Rescheduling_interrupts
    281205           -26.3%     207192 ±  8%  interrupts.CPU76.TLB:TLB_shootdowns
    364679 ±  3%     -16.6%     304285 ±  2%  interrupts.CPU77.CAL:Function_call_interrupts
   2119763 ±  2%     -38.6%    1301020        interrupts.CPU77.LOC:Local_timer_interrupts
    812355 ±  7%     -39.5%     491342 ±  5%  interrupts.CPU77.RES:Rescheduling_interrupts
    283855           -27.0%     207261 ±  8%  interrupts.CPU77.TLB:TLB_shootdowns
    359208 ±  2%     -14.0%     308972 ±  3%  interrupts.CPU78.CAL:Function_call_interrupts
   2119907 ±  2%     -38.6%    1300985        interrupts.CPU78.LOC:Local_timer_interrupts
    839350 ± 10%     -41.5%     491392 ±  5%  interrupts.CPU78.RES:Rescheduling_interrupts
    283511           -26.8%     207440 ± 10%  interrupts.CPU78.TLB:TLB_shootdowns
    357054 ±  4%     -14.1%     306776        interrupts.CPU79.CAL:Function_call_interrupts
   2119898 ±  2%     -38.6%    1300998        interrupts.CPU79.LOC:Local_timer_interrupts
    838045 ±  8%     -42.0%     486044 ±  5%  interrupts.CPU79.RES:Rescheduling_interrupts
    281820           -26.3%     207652 ±  8%  interrupts.CPU79.TLB:TLB_shootdowns
    357337           -25.2%     267166 ±  5%  interrupts.CPU8.CAL:Function_call_interrupts
   2119861 ±  2%     -38.6%    1300975        interrupts.CPU8.LOC:Local_timer_interrupts
    822142 ±  4%     -55.9%     362512 ±  4%  interrupts.CPU8.RES:Rescheduling_interrupts
    282367           -25.3%     210880 ±  9%  interrupts.CPU8.TLB:TLB_shootdowns
    353683 ±  2%     -12.9%     308146 ±  3%  interrupts.CPU80.CAL:Function_call_interrupts
   2119902 ±  2%     -38.6%    1300992        interrupts.CPU80.LOC:Local_timer_interrupts
    849161 ±  6%     -41.6%     495542 ±  6%  interrupts.CPU80.RES:Rescheduling_interrupts
    282788           -26.5%     207894 ±  9%  interrupts.CPU80.TLB:TLB_shootdowns
    351699           -12.1%     309301 ±  2%  interrupts.CPU81.CAL:Function_call_interrupts
   2119873 ±  2%     -38.6%    1300997        interrupts.CPU81.LOC:Local_timer_interrupts
    829162 ±  9%     -40.9%     489741 ±  5%  interrupts.CPU81.RES:Rescheduling_interrupts
    281028           -26.0%     208006 ±  8%  interrupts.CPU81.TLB:TLB_shootdowns
    355240 ±  2%     -11.5%     314426 ±  4%  interrupts.CPU82.CAL:Function_call_interrupts
   2119916 ±  2%     -38.6%    1300923        interrupts.CPU82.LOC:Local_timer_interrupts
    826386 ±  8%     -41.0%     487824 ±  6%  interrupts.CPU82.RES:Rescheduling_interrupts
    281032           -26.3%     207063 ±  9%  interrupts.CPU82.TLB:TLB_shootdowns
    353706 ±  2%     -13.3%     306818 ±  2%  interrupts.CPU83.CAL:Function_call_interrupts
   2119917 ±  2%     -38.6%    1301004        interrupts.CPU83.LOC:Local_timer_interrupts
    826758 ±  8%     -40.5%     491595 ±  5%  interrupts.CPU83.RES:Rescheduling_interrupts
    282199           -25.9%     209072 ±  8%  interrupts.CPU83.TLB:TLB_shootdowns
    363376 ±  2%     -17.3%     300658 ±  3%  interrupts.CPU84.CAL:Function_call_interrupts
   2119884 ±  2%     -38.6%    1300993        interrupts.CPU84.LOC:Local_timer_interrupts
    818489 ±  7%     -40.9%     484073 ±  5%  interrupts.CPU84.RES:Rescheduling_interrupts
    282037           -26.2%     208075 ±  8%  interrupts.CPU84.TLB:TLB_shootdowns
    361581 ±  2%     -14.4%     309541 ±  2%  interrupts.CPU85.CAL:Function_call_interrupts
   2119853 ±  2%     -38.6%    1300927        interrupts.CPU85.LOC:Local_timer_interrupts
    825059 ±  9%     -40.0%     495049 ±  6%  interrupts.CPU85.RES:Rescheduling_interrupts
    280009           -25.9%     207426 ±  8%  interrupts.CPU85.TLB:TLB_shootdowns
    360577 ±  2%     -15.7%     304023 ±  2%  interrupts.CPU86.CAL:Function_call_interrupts
   2119860 ±  2%     -38.6%    1301024        interrupts.CPU86.LOC:Local_timer_interrupts
    846687 ±  5%     -42.3%     488197 ±  4%  interrupts.CPU86.RES:Rescheduling_interrupts
    282430           -26.7%     206906 ±  8%  interrupts.CPU86.TLB:TLB_shootdowns
    355552 ±  3%     -14.8%     302975 ±  3%  interrupts.CPU87.CAL:Function_call_interrupts
   2119783 ±  2%     -38.6%    1301007        interrupts.CPU87.LOC:Local_timer_interrupts
    837108 ±  9%     -41.0%     493489 ±  6%  interrupts.CPU87.RES:Rescheduling_interrupts
    279982           -25.6%     208231 ±  8%  interrupts.CPU87.TLB:TLB_shootdowns
    357243           -14.6%     305251 ±  2%  interrupts.CPU88.CAL:Function_call_interrupts
   2119798 ±  2%     -38.6%    1300996        interrupts.CPU88.LOC:Local_timer_interrupts
    830698 ±  6%     -40.3%     496304 ±  5%  interrupts.CPU88.RES:Rescheduling_interrupts
    281515           -26.0%     208331 ±  8%  interrupts.CPU88.TLB:TLB_shootdowns
    357561 ±  2%     -14.2%     306895 ±  2%  interrupts.CPU89.CAL:Function_call_interrupts
   2119898 ±  2%     -38.6%    1300966        interrupts.CPU89.LOC:Local_timer_interrupts
    844079 ±  7%     -41.2%     495937 ±  6%  interrupts.CPU89.RES:Rescheduling_interrupts
    283569           -27.0%     206886 ±  8%  interrupts.CPU89.TLB:TLB_shootdowns
    363672           -26.6%     267079 ±  4%  interrupts.CPU9.CAL:Function_call_interrupts
   2119924 ±  2%     -38.6%    1301011        interrupts.CPU9.LOC:Local_timer_interrupts
    803331 ±  4%     -55.1%     360571 ±  4%  interrupts.CPU9.RES:Rescheduling_interrupts
    282194           -25.0%     211729 ±  8%  interrupts.CPU9.TLB:TLB_shootdowns
    357677 ±  2%     -14.4%     306269 ±  2%  interrupts.CPU90.CAL:Function_call_interrupts
   2119887 ±  2%     -38.6%    1300984        interrupts.CPU90.LOC:Local_timer_interrupts
    837795 ±  9%     -41.2%     492875 ±  6%  interrupts.CPU90.RES:Rescheduling_interrupts
    281825           -26.2%     207949 ±  8%  interrupts.CPU90.TLB:TLB_shootdowns
    359694 ±  2%     -14.8%     306597        interrupts.CPU91.CAL:Function_call_interrupts
   2119761 ±  2%     -38.6%    1300987        interrupts.CPU91.LOC:Local_timer_interrupts
    842202 ±  9%     -41.4%     493906 ±  6%  interrupts.CPU91.RES:Rescheduling_interrupts
    282106           -26.3%     207777 ±  8%  interrupts.CPU91.TLB:TLB_shootdowns
    375385 ±  2%     -19.3%     302982 ±  3%  interrupts.CPU92.CAL:Function_call_interrupts
   2119879 ±  2%     -38.6%    1300977        interrupts.CPU92.LOC:Local_timer_interrupts
    847516 ±  8%     -42.4%     488171 ±  5%  interrupts.CPU92.RES:Rescheduling_interrupts
    280812           -26.1%     207449 ±  9%  interrupts.CPU92.TLB:TLB_shootdowns
    353136           -11.6%     312278 ±  3%  interrupts.CPU93.CAL:Function_call_interrupts
   2119901 ±  2%     -38.6%    1300954        interrupts.CPU93.LOC:Local_timer_interrupts
    861749 ±  9%     -42.5%     495355 ±  6%  interrupts.CPU93.RES:Rescheduling_interrupts
    281193           -26.3%     207249 ±  8%  interrupts.CPU93.TLB:TLB_shootdowns
    368783 ±  6%     -18.1%     302055 ±  3%  interrupts.CPU94.CAL:Function_call_interrupts
   2119918 ±  2%     -38.6%    1300957        interrupts.CPU94.LOC:Local_timer_interrupts
    853109 ±  8%     -42.9%     486709 ±  5%  interrupts.CPU94.RES:Rescheduling_interrupts
    283366           -26.9%     207085 ±  8%  interrupts.CPU94.TLB:TLB_shootdowns
    364463 ±  4%     -15.3%     308673 ±  3%  interrupts.CPU95.CAL:Function_call_interrupts
   2119853 ±  2%     -38.6%    1300975        interrupts.CPU95.LOC:Local_timer_interrupts
    824354 ±  7%     -40.8%     488005 ±  4%  interrupts.CPU95.RES:Rescheduling_interrupts
    282090           -27.3%     205190 ±  9%  interrupts.CPU95.TLB:TLB_shootdowns
      1925 ± 21%     +47.4%       2838 ±  2%  interrupts.IWI:IRQ_work_interrupts
 2.035e+08 ±  2%     -38.6%  1.249e+08        interrupts.LOC:Local_timer_interrupts
    288.00           -33.3%     192.00        interrupts.MCP:Machine_check_polls
  78939352 ±  4%     -48.2%   40908024 ±  4%  interrupts.RES:Rescheduling_interrupts
  27108861           -26.0%   20070842 ±  8%  interrupts.TLB:TLB_shootdowns





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.13.0-g5387c90490f7"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.13.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23502
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23502
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_MPTCP_KUNIT_TEST=m
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# CONFIG_BT_VIRTIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_DRIVER_PE_KUNIT_TEST=y
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
# CONFIG_MT7921E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
# CONFIG_WWAN is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_INTEL_PMT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m
CONFIG_DVB_MXL692=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN_FRONTEND is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PLAYSTATION is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_I40IW is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_DTPM is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_KUNIT_TEST=y
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_LINEAR_RANGES=m
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
# CONFIG_KUNIT_TEST is not set
# CONFIG_KUNIT_EXAMPLE_TEST is not set
CONFIG_KUNIT_ALL_TESTS=m
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
CONFIG_BITFIELD_KUNIT=m
CONFIG_RESOURCE_KUNIT_TEST=m
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
CONFIG_LINEAR_RANGES_TEST=m
CONFIG_CMDLINE_KUNIT_TEST=m
CONFIG_BITS_TEST=m
CONFIG_SLUB_KUNIT_TEST=m
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='will-it-scale'
	export testcase='will-it-scale'
	export category='benchmark'
	export nr_task=72
	export job_origin='will-it-scale-part4.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-hsw-4ex1'
	export tbox_group='lkp-hsw-4ex1'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='61334b8f5d2484a440d2f92a'
	export job_file='/lkp/jobs/scheduled/lkp-hsw-4ex1/will-it-scale-performance-process-50%-unix1-ucode=0x16-debian-10.4-x86_64-20200603.cgz-5387c90490f7f42df3209154ca955a453ee01b41-20210904-42048-12f1137-3.yaml'
	export id='08fbf2f328b4f42302537e67315e0c53ce7f0ba3'
	export queuer_version='/lkp-src'
	export model='Haswell-EX'
	export nr_node=4
	export nr_cpu=144
	export memory='512G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=1
	export hdd_partitions='/dev/disk/by-id/wwn-0x5000c50067bdf9c3-part1'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL41710016800RGN-part1'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BA400G4_BTHV634503K3400NGN-part1'
	export brand='Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz'
	export commit='5387c90490f7f42df3209154ca955a453ee01b41'
	export ucode='0x16'
	export kernel_cmdline_hw='cma=0'
	export need_kconfig_hw='{"IXGBE"=>"y"}
SCSI_MPT3SAS
SATA_AHCI'
	export bisect_dmesg=true
	export enqueue_time='2021-09-04 18:33:51 +0800'
	export _id='61334b8f5d2484a440d2f92a'
	export _rt='/result/will-it-scale/performance-process-50%-unix1-ucode=0x16/lkp-hsw-4ex1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='309efd7a1aa7b59de7df39a0ff0775fa99e5aea6'
	export base_commit='7d2a07b769330c34b4deabeed939325c77a7ec2f'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/will-it-scale/performance-process-50%-unix1-ucode=0x16/lkp-hsw-4ex1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/3'
	export scheduler_version='/lkp/lkp/.src-20210903-234613'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-hsw-4ex1/will-it-scale-performance-process-50%-unix1-ucode=0x16-debian-10.4-x86_64-20200603.cgz-5387c90490f7f42df3209154ca955a453ee01b41-20210904-42048-12f1137-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=5387c90490f7f42df3209154ca955a453ee01b41
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/vmlinuz-5.13.0-g5387c90490f7
cma=0
max_uptime=2100
RESULT_ROOT=/result/will-it-scale/performance-process-50%-unix1-ucode=0x16/lkp-hsw-4ex1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/3
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/will-it-scale_20210701.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/will-it-scale-x86_64-a34a85c-1_20210903.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20210621.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-3f5ad13cb012-1_20210828.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.14.0'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/vmlinuz-5.13.0-g5387c90490f7'
	export dequeue_time='2021-09-04 18:39:34 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-hsw-4ex1/will-it-scale-performance-process-50%-unix1-ucode=0x16-debian-10.4-x86_64-20200603.cgz-5387c90490f7f42df3209154ca955a453ee01b41-20210904-42048-12f1137-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor lite_mode=1 $LKP_SRC/monitors/wrapper perf-sched
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor lite_mode=1 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper syscalls
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test mode='process' test='unix1' $LKP_SRC/tests/wrapper will-it-scale
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env mode='process' test='unix1' $LKP_SRC/stats/wrapper will-it-scale
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	env lite_mode=1 $LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	env lite_mode=1 $LKP_SRC/stats/wrapper perf-profile
	$LKP_SRC/stats/wrapper syscalls

	$LKP_SRC/stats/wrapper time will-it-scale.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/will-it-scale-part4.yaml:
suite: will-it-scale
testcase: will-it-scale
category: benchmark
nr_task: 50%
will-it-scale:
  mode: process
  test: unix1
job_origin: will-it-scale-part4.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-hsw-4ex1
tbox_group: lkp-hsw-4ex1
kconfig: x86_64-rhel-8.3
submit_id: 61333d505d2484a07b33e8cf
job_file: "/lkp/jobs/scheduled/lkp-hsw-4ex1/will-it-scale-performance-process-50%-unix1-ucode=0x16-debian-10.4-x86_64-20200603.cgz-5387c90490f7f42df3209154ca955a453ee01b41-20210904-41083-44adm5-1.yaml"
id: ef741f6233de88e53ac092372dd0612e7c47c663
queuer_version: "/lkp-src"
:#! hosts/lkp-hsw-4ex1:
model: Haswell-EX
nr_node: 4
nr_cpu: 144
memory: 512G
nr_ssd_partitions: 1
nr_hdd_partitions: 1
hdd_partitions: "/dev/disk/by-id/wwn-0x5000c50067bdf9c3-part1"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL41710016800RGN-part1"
swap_partitions:
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BA400G4_BTHV634503K3400NGN-part1"
brand: Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz
:#! include/category/benchmark:
kmsg:
boot-time:
uptime:
iostat:
heartbeat:
vmstat:
numa-numastat:
numa-vmstat:
numa-meminfo:
proc-vmstat:
proc-stat:
meminfo:
slabinfo:
interrupts:
lock_stat:
perf-sched:
  lite_mode: 1
softirqs:
bdi_dev_mapping:
diskstats:
nfsstat:
cpuidle:
cpufreq-stats:
turbostat:
sched_debug:
perf-stat:
mpstat:
perf-profile:
  lite_mode: 1
:#! include/category/ALL:
cpufreq_governor: performance
:#! include/queue/cyclic:
commit: 5387c90490f7f42df3209154ca955a453ee01b41
:#! include/testbox/lkp-hsw-4ex1:
syscalls:
ucode: '0x16'
kernel_cmdline_hw: cma=0
need_kconfig_hw:
- IXGBE: y
- SCSI_MPT3SAS
- SATA_AHCI
bisect_dmesg: true
enqueue_time: 2021-09-04 17:33:04.902311239 +08:00
_id: 613342cd5d2484a07b33e8d0
_rt: "/result/will-it-scale/performance-process-50%-unix1-ucode=0x16/lkp-hsw-4ex1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41"
:#! schedule options:
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 309efd7a1aa7b59de7df39a0ff0775fa99e5aea6
base_commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
branch: linux-devel/devel-hourly-20210831-101728
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/will-it-scale/performance-process-50%-unix1-ucode=0x16/lkp-hsw-4ex1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/0"
scheduler_version: "/lkp/lkp/.src-20210903-234613"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-hsw-4ex1/will-it-scale-performance-process-50%-unix1-ucode=0x16-debian-10.4-x86_64-20200603.cgz-5387c90490f7f42df3209154ca955a453ee01b41-20210904-41083-44adm5-1.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210831-101728
- commit=5387c90490f7f42df3209154ca955a453ee01b41
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/vmlinuz-5.13.0-g5387c90490f7
- cma=0
- max_uptime=2100
- RESULT_ROOT=/result/will-it-scale/performance-process-50%-unix1-ucode=0x16/lkp-hsw-4ex1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/will-it-scale_20210701.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/will-it-scale-x86_64-a34a85c-1_20210903.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20210621.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-3f5ad13cb012-1_20210828.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /lkp/lkp/.src-20210831-154338/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.14.0-wt-ath-07128-g29414d6e109d
repeat_to: 3
:#! /lkp/lkp/.src-20210901-162609/include/site/inn:
:#! user overrides:
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/vmlinuz-5.13.0-g5387c90490f7"
dequeue_time: 2021-09-04 18:00:48.471956741 +08:00
:#! /lkp/lkp/.src-20210903-234613/include/site/inn:
job_state: finished
loadavg: 17.16 34.76 18.64 1/1061 18782
start_time: '1630749743'
end_time: '1630750045'
version: "/lkp/lkp/.src-20210903-234710:9cfae862:2d6eafa30"

--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "/lkp/benchmarks/python3/bin/python3" "./runtest.py" "unix1" "295" "process" "72"

--o0ZfoUVt4BxPQnbU--
