Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593ED305349
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 07:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhA0Ge2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 01:34:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:13964 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233504AbhA0DJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:09:52 -0500
IronPort-SDR: jsltQ9y5Pph2BNxeCOSb9Dxn/7ZghEADvowJRjJ3EjNwk9YRbMf4zFmu5k0Pu5uTE8goOEh1t7
 jYM4x1CfvH9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="159176974"
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="yaml'?scan'208";a="159176974"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 18:01:00 -0800
IronPort-SDR: +IMeaEZiW9WEQDZXR+S5I9tiULb4jYa3pd/DrdhPrk+08lc+4JrkEC9o/EmW1H7/j02vErozpW
 YIok5PrcXLow==
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="yaml'?scan'208";a="362221295"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 18:00:55 -0800
Date:   Wed, 27 Jan 2021 10:16:51 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Imran Khan <imran.f.khan@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Koutn <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: [mm]  3de7d4f25a:  hackbench.throughput 45.2% improvement
Message-ID: <20210127021651.GA30690@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Greeting,

FYI, we noticed a 45.2% improvement of hackbench.throughput due to commit:


commit: 3de7d4f25a7438f09fef4e71ef111f1805cd8e7c ("mm: memcg/slab: optimize objcg stock draining")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: hackbench
on test machine: 144 threads Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory
with following parameters:

	nr_threads: 100%
	iterations: 4
	mode: threads
	ipc: socket
	cpufreq_governor: performance
	ucode: 0x700001e

test-description: Hackbench is both a benchmark and a stress test for the Linux kernel scheduler.
test-url: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/sched/cfs-scheduler/hackbench.c

In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.bad-altstack.ops_per_sec 14.8% improvement      |
| test machine     | 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory |
| test parameters  | class=memory                                                         |
|                  | cpufreq_governor=performance                                         |
|                  | disk=1HDD                                                            |
|                  | nr_threads=100%                                                      |
|                  | testtime=10s                                                         |
|                  | ucode=0x5003003                                                      |
+------------------+----------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.procfs.ops_per_sec 24.2% improvement            |
| test machine     | 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory |
| test parameters  | class=filesystem                                                     |
|                  | cpufreq_governor=performance                                         |
|                  | disk=1HDD                                                            |
|                  | fs=ext4                                                              |
|                  | nr_threads=10%                                                       |
|                  | testtime=30s                                                         |
|                  | ucode=0x5003003                                                      |
+------------------+----------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase/ucode:
  gcc-9/performance/socket/4/x86_64-rhel-8.3/threads/100%/debian-10.4-x86_64-20200603.cgz/lkp-cpl-4sp1/hackbench/0x700001e

commit: 
  d3921cb8be ("mm: fix initialization of struct page for holes in memory layout")
  3de7d4f25a ("mm: memcg/slab: optimize objcg stock draining")

d3921cb8be29ce56 3de7d4f25a7438f09fef4e71ef1 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     51479           +45.2%      74753        hackbench.throughput
      1315           -29.2%     931.13        hackbench.time.elapsed_time
      1315           -29.2%     931.13        hackbench.time.elapsed_time.max
 5.546e+08 ± 11%    +609.0%  3.932e+09        hackbench.time.involuntary_context_switches
      2582 ± 17%     -26.1%       1907 ± 18%  hackbench.time.major_page_faults
    184500           -30.7%     127875        hackbench.time.system_time
      1816 ±  2%     +59.7%       2900        hackbench.time.user_time
 1.245e+09 ±  8%    +352.7%  5.638e+09        hackbench.time.voluntary_context_switches
      1356           -28.0%     976.42        uptime.boot
   1292957 ± 13%     +85.0%    2392608 ± 14%  numa-numastat.node3.local_node
   1329025 ± 13%     +83.9%    2443792 ± 13%  numa-numastat.node3.numa_hit
     98.00            -1.0%      97.00        vmstat.cpu.sy
   1404918 ±  7%    +631.6%   10277830 ±  2%  vmstat.system.cs
    510555          +178.1%    1419769 ±  2%  vmstat.system.in
      0.67 ±  4%      -0.1        0.59 ±  3%  mpstat.cpu.all.idle%
      0.91 ±  2%      +0.9        1.82 ±  3%  mpstat.cpu.all.irq%
      0.03 ±  6%      -0.0        0.03 ±  3%  mpstat.cpu.all.soft%
      0.98            +1.2        2.20        mpstat.cpu.all.usr%
 5.767e+08 ±  4%     -63.5%  2.106e+08 ± 12%  cpuidle.C1.time
  38987487 ±  2%     -54.7%   17648341 ±  7%  cpuidle.C1.usage
 6.814e+08 ±  5%     -25.4%  5.083e+08 ± 16%  cpuidle.C1E.time
   4627972 ±  6%     -47.1%    2445949 ± 11%  cpuidle.C1E.usage
  28364267 ± 49%    +402.5%  1.425e+08 ± 52%  cpuidle.C6.time
     94344 ± 20%    +226.6%     308127 ± 57%  cpuidle.C6.usage
   7116263 ±  4%     -16.8%    5920458 ± 10%  cpuidle.POLL.time
    875057 ±  5%     +57.2%    1375770 ± 16%  cpuidle.POLL.usage
    139169 ±  2%     -82.2%      24826 ±  3%  slabinfo.kmalloc-512.active_objs
     19526 ±  2%     -82.3%       3451 ±  2%  slabinfo.kmalloc-512.active_slabs
    156219 ±  2%     -82.3%      27615 ±  2%  slabinfo.kmalloc-512.num_objs
     19526 ±  2%     -82.3%       3451 ±  2%  slabinfo.kmalloc-512.num_slabs
    134115 ±  2%     -59.3%      54639        slabinfo.skbuff_head_cache.active_objs
      2659 ±  2%     -66.2%     898.25        slabinfo.skbuff_head_cache.active_slabs
    170199 ±  2%     -66.2%      57527        slabinfo.skbuff_head_cache.num_objs
      2659 ±  2%     -66.2%     898.25        slabinfo.skbuff_head_cache.num_slabs
   1238587           -21.0%     978955 ± 10%  meminfo.Active
   1238587           -21.0%     978955 ± 10%  meminfo.Active(anon)
    364097 ±  2%     +55.0%     564366 ± 19%  meminfo.Inactive
    364097 ±  2%     +55.0%     564366 ± 19%  meminfo.Inactive(anon)
    105342 ±  9%    +151.7%     265155 ± 44%  meminfo.Mapped
      4223           +11.5%       4709 ±  6%  meminfo.PageTables
    475353           -19.5%     382718        meminfo.SUnreclaim
    588608           -16.1%     493928        meminfo.Slab
      4524           +54.0%       6966 ±  4%  meminfo.max_used_kB
     13678 ±  7%    +197.3%      40667 ± 32%  numa-meminfo.node0.Mapped
     14341 ±141%     -97.5%     364.00 ±105%  numa-meminfo.node1.Active
     14341 ±141%     -97.5%     364.00 ±105%  numa-meminfo.node1.Active(anon)
     31149 ± 30%     -84.2%       4921 ±  6%  numa-meminfo.node1.KernelStack
     16598 ± 23%    +149.0%      41333 ± 26%  numa-meminfo.node1.Mapped
    121998 ± 11%     -45.4%      66637 ± 10%  numa-meminfo.node1.SUnreclaim
    144326 ±  7%     -42.0%      83773 ±  9%  numa-meminfo.node1.Slab
     21517 ± 46%    +133.7%      50287 ± 39%  numa-meminfo.node2.Mapped
    103232 ± 42%    +236.8%     347717 ± 40%  numa-meminfo.node3.Inactive
    103232 ± 42%    +236.8%     347717 ± 40%  numa-meminfo.node3.Inactive(anon)
     51111 ± 27%    +155.3%     130468 ± 54%  numa-meminfo.node3.Mapped
      3443 ±  8%    +193.2%      10094 ± 32%  numa-vmstat.node0.nr_mapped
    177.25 ± 11%     -28.2%     127.25 ±  9%  numa-vmstat.node0.nr_mlock
      3560 ±141%     -97.5%      90.75 ±105%  numa-vmstat.node1.nr_active_anon
     30917 ± 30%     -84.1%       4926 ±  6%  numa-vmstat.node1.nr_kernel_stack
      4110 ± 24%    +149.6%      10260 ± 27%  numa-vmstat.node1.nr_mapped
     30392 ± 11%     -45.2%      16659 ± 10%  numa-vmstat.node1.nr_slab_unreclaimable
      3560 ±141%     -97.5%      90.75 ±105%  numa-vmstat.node1.nr_zone_active_anon
      5274 ± 42%    +136.2%      12460 ± 39%  numa-vmstat.node2.nr_mapped
     25911 ± 43%    +233.2%      86346 ± 40%  numa-vmstat.node3.nr_inactive_anon
     12950 ± 31%    +151.1%      32518 ± 54%  numa-vmstat.node3.nr_mapped
     25911 ± 43%    +233.2%      86346 ± 40%  numa-vmstat.node3.nr_zone_inactive_anon
   1193785 ± 12%     +54.6%    1846002 ± 14%  numa-vmstat.node3.numa_hit
   1078977 ± 15%     +60.6%    1732973 ± 14%  numa-vmstat.node3.numa_local
    310546           -20.9%     245673 ± 10%  proc-vmstat.nr_active_anon
    571656            -3.2%     553385        proc-vmstat.nr_file_pages
     90935 ±  2%     +54.8%     140792 ± 19%  proc-vmstat.nr_inactive_anon
    106363            -3.9%     102168        proc-vmstat.nr_kernel_stack
     26325 ± 11%    +151.1%      66102 ± 43%  proc-vmstat.nr_mapped
      1053           +12.0%       1180 ±  6%  proc-vmstat.nr_page_table_pages
    329411            -5.5%     311140        proc-vmstat.nr_shmem
     28314            -1.8%      27797        proc-vmstat.nr_slab_reclaimable
    118822           -19.5%      95612        proc-vmstat.nr_slab_unreclaimable
    310546           -20.9%     245673 ± 10%  proc-vmstat.nr_zone_active_anon
     90935 ±  2%     +54.8%     140792 ± 19%  proc-vmstat.nr_zone_inactive_anon
   5496694           +20.5%    6621551 ±  3%  proc-vmstat.numa_hit
   5301424           +21.2%    6426191 ±  3%  proc-vmstat.numa_local
     70257 ± 27%     +41.1%      99155 ±  4%  proc-vmstat.numa_pages_migrated
    351223            -2.0%     344063        proc-vmstat.pgactivate
   6011943           +64.8%    9905622 ±  4%  proc-vmstat.pgalloc_normal
   4912356 ±  3%     -27.7%    3551827 ±  2%  proc-vmstat.pgfault
   5704926           +68.5%    9615410 ±  4%  proc-vmstat.pgfree
     70257 ± 27%     +41.1%      99155 ±  4%  proc-vmstat.pgmigrate_success
    209094           -32.5%     141143 ±  2%  proc-vmstat.pgreuse
    123449 ± 62%     -59.0%      50635 ±134%  sched_debug.cfs_rq:/.MIN_vruntime.avg
  13988272 ± 52%     -68.3%    4431193 ±115%  sched_debug.cfs_rq:/.MIN_vruntime.max
   1283183 ± 57%     -64.2%     459455 ±124%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
      8641 ±  5%     -15.9%       7264        sched_debug.cfs_rq:/.load.avg
     66297 ± 91%     -74.3%      17061 ± 17%  sched_debug.cfs_rq:/.load.max
      7145 ± 67%     -63.0%       2647 ± 22%  sched_debug.cfs_rq:/.load.stddev
      1.62 ±  5%     +43.6%       2.32 ± 12%  sched_debug.cfs_rq:/.load_avg.min
    123449 ± 62%     -59.0%      50635 ±134%  sched_debug.cfs_rq:/.max_vruntime.avg
  13988272 ± 52%     -68.3%    4431193 ±115%  sched_debug.cfs_rq:/.max_vruntime.max
   1283183 ± 57%     -64.2%     459455 ±124%  sched_debug.cfs_rq:/.max_vruntime.stddev
  95742524 ±  2%     -26.5%   70405887 ±  4%  sched_debug.cfs_rq:/.min_vruntime.avg
 1.052e+08 ±  4%     -19.5%   84632324 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
  87247166 ±  2%     -42.7%   49960558        sched_debug.cfs_rq:/.min_vruntime.min
   4722211 ± 22%    +128.4%   10787549 ± 12%  sched_debug.cfs_rq:/.min_vruntime.stddev
     19408 ±  2%      -6.9%      18075 ±  5%  sched_debug.cfs_rq:/.runnable_avg.avg
     34906 ±  3%     -15.4%      29523 ±  4%  sched_debug.cfs_rq:/.runnable_avg.max
      4281 ± 12%     +86.7%       7992 ± 11%  sched_debug.cfs_rq:/.runnable_avg.min
      6067 ±  3%     -28.9%       4314 ± 12%  sched_debug.cfs_rq:/.runnable_avg.stddev
   4709775 ± 22%    +125.9%   10640405 ± 12%  sched_debug.cfs_rq:/.spread0.stddev
      1605           -13.4%       1390 ±  3%  sched_debug.cfs_rq:/.util_avg.max
    479.64 ±  2%     +24.3%     596.13 ±  7%  sched_debug.cfs_rq:/.util_avg.min
    170.56 ±  3%     -19.7%     136.98 ±  7%  sched_debug.cfs_rq:/.util_avg.stddev
    959.94           -26.0%     710.39 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      2196           -31.0%       1516 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.max
     17.92 ± 36%   +1069.6%     209.55 ± 21%  sched_debug.cfs_rq:/.util_est_enqueued.min
    498.25 ±  2%     -54.5%     226.77 ±  8%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    360873 ±  5%     -18.2%     295164 ±  5%  sched_debug.cpu.avg_idle.avg
      4018 ±  5%     -42.4%       2313 ±  9%  sched_debug.cpu.avg_idle.min
    357106           -10.4%     320047 ±  5%  sched_debug.cpu.avg_idle.stddev
    677491 ±  2%     -27.6%     490674 ±  3%  sched_debug.cpu.clock.avg
    678424 ±  2%     -26.9%     495776 ±  3%  sched_debug.cpu.clock.max
    676540 ±  2%     -28.3%     485260 ±  3%  sched_debug.cpu.clock.min
    550.30 ± 23%    +453.0%       3043 ± 15%  sched_debug.cpu.clock.stddev
    671354 ±  2%     -28.1%     482587 ±  3%  sched_debug.cpu.clock_task.avg
    672474 ±  2%     -27.2%     489370 ±  3%  sched_debug.cpu.clock_task.max
    663609 ±  2%     -30.1%     463559 ±  2%  sched_debug.cpu.clock_task.min
      1024 ± 25%    +319.4%       4295 ± 12%  sched_debug.cpu.clock_task.stddev
     24423           -17.6%      20122        sched_debug.cpu.curr->pid.avg
     30114           -17.5%      24845        sched_debug.cpu.curr->pid.max
      0.00 ± 22%    +452.1%       0.00 ± 15%  sched_debug.cpu.next_balance.stddev
     18.98 ±  3%      -6.6%      17.74 ±  4%  sched_debug.cpu.nr_running.avg
     41.70 ±  3%     -23.3%      31.97 ±  4%  sched_debug.cpu.nr_running.max
      0.74 ± 10%    +630.5%       5.44 ± 15%  sched_debug.cpu.nr_running.min
     10.41 ±  3%     -52.6%       4.93 ± 12%  sched_debug.cpu.nr_running.stddev
   6229084 ±  8%    +412.1%   31899136        sched_debug.cpu.nr_switches.avg
   7584168 ± 10%    +486.3%   44466821 ±  4%  sched_debug.cpu.nr_switches.max
   5190559 ±  8%    +291.7%   20332558 ±  4%  sched_debug.cpu.nr_switches.min
    476341 ±  8%    +839.3%    4474464 ± 16%  sched_debug.cpu.nr_switches.stddev
    676515 ±  2%     -28.3%     485102 ±  3%  sched_debug.cpu_clk
    675769 ±  2%     -28.3%     484355 ±  3%  sched_debug.ktime
    678151 ±  2%     -28.4%     485464 ±  3%  sched_debug.sched_clk
     16.98 ±  2%     -17.2%      14.07        perf-stat.i.MPKI
 7.605e+09          +151.1%   1.91e+10        perf-stat.i.branch-instructions
      1.20            +0.2        1.37        perf-stat.i.branch-miss-rate%
  90406559          +178.8%   2.52e+08        perf-stat.i.branch-misses
     30.10 ±  2%     -15.8       14.29 ±  3%  perf-stat.i.cache-miss-rate%
 1.931e+08 ±  5%     -11.4%   1.71e+08 ±  3%  perf-stat.i.cache-misses
 6.418e+08 ±  2%     +97.6%  1.268e+09 ±  2%  perf-stat.i.cache-references
   1370491 ±  7%    +659.9%   10413883 ±  2%  perf-stat.i.context-switches
     12.40           -57.2%       5.31 ±  2%  perf-stat.i.cpi
    103561          +788.1%     919723 ±  4%  perf-stat.i.cpu-migrations
      2441 ±  5%     +25.2%       3057 ±  4%  perf-stat.i.cycles-between-cache-misses
      0.06 ±  5%      -0.0        0.02 ±  9%  perf-stat.i.dTLB-load-miss-rate%
   6599491 ±  5%     -44.4%    3668259 ±  7%  perf-stat.i.dTLB-load-misses
 1.092e+10          +139.7%  2.618e+10 ±  2%  perf-stat.i.dTLB-loads
      0.03 ±  2%      -0.0        0.00 ±  8%  perf-stat.i.dTLB-store-miss-rate%
   2188293 ±  3%     -75.8%     528948 ±  6%  perf-stat.i.dTLB-store-misses
 6.711e+09          +133.3%  1.566e+10        perf-stat.i.dTLB-stores
     96.13            +2.2       98.35        perf-stat.i.iTLB-load-miss-rate%
  46313820           +94.1%   89917841        perf-stat.i.iTLB-load-misses
   1862878 ±  9%     -25.2%    1393685 ±  7%  perf-stat.i.iTLB-loads
 3.826e+10          +143.7%  9.324e+10 ±  2%  perf-stat.i.instructions
    830.21           +23.3%       1023        perf-stat.i.instructions-per-iTLB-miss
      0.08          +141.3%       0.20 ±  2%  perf-stat.i.ipc
      0.51 ±  5%     -85.5%       0.07 ±  3%  perf-stat.i.metric.K/sec
    179.45          +141.2%     432.87        perf-stat.i.metric.M/sec
     82.77           +12.6       95.35        perf-stat.i.node-load-miss-rate%
  34027931 ±  3%    +141.1%   82055789 ±  4%  perf-stat.i.node-load-misses
   6688784 ±  4%     -40.8%    3963085 ±  3%  perf-stat.i.node-loads
     87.92           +10.3       98.23        perf-stat.i.node-store-miss-rate%
  27978556 ±  3%     +18.3%   33091342 ±  3%  perf-stat.i.node-store-misses
   3607145 ±  5%     -85.8%     512541 ±  4%  perf-stat.i.node-stores
     16.58 ±  2%     -18.1%      13.59        perf-stat.overall.MPKI
      1.18            +0.1        1.32        perf-stat.overall.branch-miss-rate%
     29.92 ±  2%     -16.4       13.51 ±  4%  perf-stat.overall.cache-miss-rate%
     12.20           -58.6%       5.05 ±  2%  perf-stat.overall.cpi
      2464 ±  4%     +11.7%       2754 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.06 ±  5%      -0.0        0.01 ± 10%  perf-stat.overall.dTLB-load-miss-rate%
      0.03 ±  3%      -0.0        0.00 ±  9%  perf-stat.overall.dTLB-store-miss-rate%
     96.94            +1.5       98.48        perf-stat.overall.iTLB-load-miss-rate%
    829.34           +24.7%       1034        perf-stat.overall.instructions-per-iTLB-miss
      0.08          +141.8%       0.20 ±  2%  perf-stat.overall.ipc
     81.73           +13.6       95.35        perf-stat.overall.node-load-miss-rate%
     87.05           +11.3       98.38        perf-stat.overall.node-store-miss-rate%
  7.65e+09          +147.5%  1.893e+10 ±  2%  perf-stat.ps.branch-instructions
  90421083          +176.5%    2.5e+08        perf-stat.ps.branch-misses
  1.91e+08 ±  5%     -11.2%  1.696e+08 ±  3%  perf-stat.ps.cache-misses
 6.379e+08 ±  2%     +96.9%  1.256e+09 ±  2%  perf-stat.ps.cache-references
   1399868 ±  7%    +635.2%   10291374 ±  2%  perf-stat.ps.context-switches
     90581 ±  3%    +894.8%     901133 ±  4%  perf-stat.ps.cpu-migrations
   6425070 ±  5%     -42.1%    3719389 ±  7%  perf-stat.ps.dTLB-load-misses
 1.098e+10          +136.5%  2.597e+10 ±  2%  perf-stat.ps.dTLB-loads
   2100206 ±  3%     -73.8%     549733 ±  7%  perf-stat.ps.dTLB-store-misses
 6.747e+09          +130.3%  1.554e+10 ±  2%  perf-stat.ps.dTLB-stores
  46396702           +92.7%   89397839        perf-stat.ps.iTLB-load-misses
 3.848e+10          +140.3%  9.245e+10 ±  2%  perf-stat.ps.instructions
  31880617 ±  3%    +154.3%   81059404 ±  4%  perf-stat.ps.node-load-misses
   7131897 ±  5%     -44.6%    3951501 ±  3%  perf-stat.ps.node-loads
  26285797 ±  2%     +25.0%   32847276 ±  3%  perf-stat.ps.node-store-misses
   3915250 ±  6%     -86.2%     538400 ±  4%  perf-stat.ps.node-stores
 5.065e+13           +70.1%  8.613e+13        perf-stat.total.instructions
    267.16 ± 61%    -100.0%       0.00 ± 80%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    167.08 ± 23%    -100.0%       0.02 ±173%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     13.40 ± 25%     -96.4%       0.48 ± 13%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      9.09 ± 63%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.allocate_slab.___slab_alloc
     33.47 ± 17%     -99.2%       0.27 ± 98%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__kmalloc_node_track_caller.__kmalloc_reserve.isra
     45.86 ± 30%    -100.0%       0.01 ± 62%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
     26.92 ± 40%     -99.9%       0.03 ±158%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
     66.58 ± 52%     -94.2%       3.89 ±173%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      2.71 ±102%     -99.9%       0.00 ±173%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.01 ± 21%     -52.5%       0.01 ± 58%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.29 ±167%     -97.6%       0.01        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.04 ± 73%    +326.7%       0.18 ± 47%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
    262.60 ±164%    -100.0%       0.01 ± 59%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      4444 ± 85%    -100.0%       0.01 ± 82%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      8007 ± 38%    -100.0%       0.59 ±172%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      8241 ± 23%     -71.6%       2342 ±173%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
     35.21 ± 44%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.allocate_slab.___slab_alloc
     14945 ± 33%     -64.5%       5311 ±101%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__kmalloc_node_track_caller.__kmalloc_reserve.isra
      9248 ± 12%     -99.9%      13.69 ± 71%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      5533 ± 28%     -99.8%      13.74 ±155%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      1599 ±161%     -98.2%      28.15 ± 85%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      6536 ± 49%     -89.2%     704.97 ±173%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      9.55 ±108%    -100.0%       0.00 ±173%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.02 ± 16%     -60.0%       0.01 ± 63%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     16049 ± 32%     -71.3%       4611 ±109%  perf-sched.sch_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     67.60 ±172%    -100.0%       0.02 ±  7%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
     15.93 ± 22%     -32.3%      10.78 ±  8%  perf-sched.total_sch_delay.average.ms
   1327113 ±  2%     +17.3%    1556514        perf-sched.total_wait_and_delay.count.ms
    781.56 ± 17%     -94.7%      41.26 ±105%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     55.19 ± 25%     -59.5%      22.38 ± 15%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
    140.67 ± 19%     -63.2%      51.83 ± 21%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.__kmalloc_node_track_caller.__kmalloc_reserve.isra
    210.24 ± 35%     -72.9%      57.03 ±101%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
    180.93 ± 43%     -71.9%      50.92 ±173%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
     97.48 ±100%    +761.5%     839.86 ± 34%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      1966 ± 53%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      2273 ± 52%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    125.44 ± 35%    +356.0%     571.96 ± 38%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      1671 ± 14%     -39.9%       1004 ± 11%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      2041 ± 13%     -70.8%     596.67 ± 63%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
    165.50 ±  7%     -92.4%      12.50 ±100%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    350168 ±  3%     +69.1%     592290        perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
     37758 ±  2%     -43.2%      21430 ±  7%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.__kmalloc_node_track_caller.__kmalloc_reserve.isra
      1470           -59.3%     598.25 ±100%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
    969.25           -70.4%     287.00 ±100%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
    209.50 ±  3%     -78.4%      45.25 ±173%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      3.50 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      6.75 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
    168.75 ± 21%     -76.0%      40.50 ± 30%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     28959 ± 13%     -99.4%     188.00 ± 51%  perf-sched.wait_and_delay.count.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
    260.75 ±  9%     -36.1%     166.50        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
    179.25 ±  8%     -86.6%      24.00 ± 71%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
     16646 ± 33%     -93.9%       1020 ±106%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     30036 ± 33%     -30.0%      21037 ± 10%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.__kmalloc_node_track_caller.__kmalloc_reserve.isra
     16333 ± 30%     -78.6%       3491 ±173%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
    856.76 ±143%    +704.7%       6893 ± 66%  perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      6765 ± 56%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     11087 ± 44%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     32157 ± 31%     -68.9%       9991 ± 94%  perf-sched.wait_and_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
    145.65 ±169%    -100.0%       0.03 ± 48%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    104.57 ± 92%    -100.0%       0.04 ±100%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    614.48 ± 20%     -92.7%      44.98 ± 88%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     32.52 ± 29%    +135.2%      76.50 ± 30%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     41.78 ± 25%     -47.6%      21.90 ± 15%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
    266.86 ±147%    -100.0%       0.00 ±173%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.allocate_slab.___slab_alloc
      0.18 ± 32%     -98.2%       0.00 ±173%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.pte_alloc_one.__pte_alloc
      0.51 ± 79%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__get_user_pages.__get_user_pages_remote.get_arg_page
    107.20 ± 20%     -51.9%      51.56 ± 21%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__kmalloc_node_track_caller.__kmalloc_reserve.isra
      0.19 ±132%     -93.2%       0.01 ±129%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__split_huge_pud.__handle_mm_fault.handle_mm_fault
    164.38 ± 38%     -56.3%      71.84 ± 60%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      0.15 ± 60%     -89.2%       0.02 ±119%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.__anon_vma_prepare.do_anonymous_page
      0.20 ± 57%     -98.4%       0.00 ±173%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.__anon_vma_prepare.do_fault
      0.22 ± 33%     -77.5%       0.05 ±139%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.vma_link.mmap_region
      0.79 ±104%     -98.4%       0.01 ±173%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_mmap_pgoff.elf_map
      0.09 ± 66%     -76.5%       0.02 ±173%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page
      2.41 ± 96%     -88.5%       0.28 ±169%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.11 ± 78%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping
      0.25 ± 70%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm
      1.96 ±101%     -97.1%       0.06 ± 80%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region
     56.24 ± 73%     -97.2%       1.60 ± 61%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.21 ± 87%     -76.3%       0.05 ± 99%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault
     71.97 ± 74%    +647.1%     537.69 ± 14%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      1963 ± 53%    -100.0%       0.04 ±103%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      2273 ± 52%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     67.55 ± 33%    +481.0%     392.45 ± 32%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      1671 ± 14%     -39.9%       1004 ± 11%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      2041 ± 13%     -70.7%     598.01 ± 62%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      2173 ±170%    -100.0%       0.05 ± 65%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1121 ± 96%    -100.0%       0.12 ±102%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     12538 ± 31%     -91.1%       1120 ± 88%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1543 ±156%    -100.0%       0.00 ±173%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.allocate_slab.___slab_alloc
      0.45 ± 56%     -99.3%       0.00 ±173%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.pte_alloc_one.__pte_alloc
      0.95 ± 68%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__get_user_pages.__get_user_pages_remote.get_arg_page
      0.33 ±149%     -96.1%       0.01 ±129%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__split_huge_pud.__handle_mm_fault.handle_mm_fault
      0.40 ± 96%     -92.5%       0.03 ±142%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.__anon_vma_prepare.do_anonymous_page
      0.32 ± 33%     -99.0%       0.00 ±173%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.__anon_vma_prepare.do_fault
      0.81 ± 38%     -76.5%       0.19 ±163%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.vma_link.mmap_region
      0.43 ± 24%     -70.5%       0.13 ±141%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write_killable.setup_arg_pages.load_elf_binary
      5.10 ±158%     -99.8%       0.01 ±173%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_mmap_pgoff.elf_map
    179.23 ± 24%     -82.3%      31.71 ±128%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.22 ± 83%     -75.4%       0.05 ±173%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page
     40.72 ±125%     -91.8%       3.35 ±172%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.11 ± 78%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping
      0.28 ± 58%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm
     11.44 ± 98%     -98.7%       0.15 ±112%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region
      4012 ± 63%     -99.3%      28.71 ± 83%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.70 ± 74%     -87.6%       0.09 ±106%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault
    640.25 ±106%    +521.6%       3979 ± 53%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      6765 ± 56%    -100.0%       0.09 ±100%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     11087 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     16209 ± 31%     -65.9%       5524 ± 79%  perf-sched.wait_time.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
    177132 ± 14%     -19.4%     142720 ±  5%  softirqs.CPU0.RCU
     28719 ± 11%     -44.4%      15962 ±  5%  softirqs.CPU0.SCHED
    179239 ± 14%     -19.1%     145006 ±  4%  softirqs.CPU1.RCU
     26049 ± 13%     -43.4%      14751 ± 12%  softirqs.CPU1.SCHED
    179205 ± 14%     -19.3%     144679 ±  4%  softirqs.CPU10.RCU
     26093 ± 12%     -45.9%      14129 ± 15%  softirqs.CPU10.SCHED
    185731 ± 14%     -17.7%     152796 ±  5%  softirqs.CPU100.RCU
     29921 ±  6%     -57.3%      12784 ± 20%  softirqs.CPU100.SCHED
    187257 ± 14%     -18.1%     153408 ±  4%  softirqs.CPU101.RCU
     29978 ±  4%     -58.2%      12538 ± 19%  softirqs.CPU101.SCHED
    187195 ± 14%     -17.7%     154083 ±  4%  softirqs.CPU102.RCU
     30458 ±  4%     -58.4%      12680 ± 19%  softirqs.CPU102.SCHED
    186955 ± 14%     -21.7%     146397 ± 11%  softirqs.CPU103.RCU
     30447 ±  4%     -57.7%      12870 ± 23%  softirqs.CPU103.SCHED
    185876 ± 14%     -18.3%     151804 ±  4%  softirqs.CPU104.RCU
     30604 ±  4%     -58.7%      12654 ± 19%  softirqs.CPU104.SCHED
    186935 ± 14%     -18.3%     152759 ±  4%  softirqs.CPU105.RCU
     30108 ±  6%     -57.7%      12727 ± 22%  softirqs.CPU105.SCHED
    187644 ± 14%     -17.5%     154734 ±  5%  softirqs.CPU106.RCU
     30453 ±  6%     -58.8%      12537 ± 18%  softirqs.CPU106.SCHED
    188233 ± 13%     -17.6%     155096 ±  5%  softirqs.CPU107.RCU
     29734 ±  5%     -58.6%      12317 ± 15%  softirqs.CPU107.SCHED
    170427 ± 14%     -18.6%     138703 ±  6%  softirqs.CPU108.RCU
     28367 ± 12%     -49.6%      14287 ±  5%  softirqs.CPU108.SCHED
    172104 ± 13%     -19.5%     138548 ±  6%  softirqs.CPU109.RCU
     28657 ± 11%     -46.9%      15225 ±  5%  softirqs.CPU109.SCHED
    180624 ± 14%     -18.6%     147079 ±  3%  softirqs.CPU11.RCU
     26035 ± 12%     -45.5%      14188 ± 12%  softirqs.CPU11.SCHED
    171891 ± 13%     -19.1%     139141 ±  6%  softirqs.CPU110.RCU
     29132 ± 12%     -47.2%      15393 ±  7%  softirqs.CPU110.SCHED
    172220 ± 13%     -19.0%     139503 ±  6%  softirqs.CPU111.RCU
     28568 ± 11%     -44.6%      15817 ±  3%  softirqs.CPU111.SCHED
    184054 ± 11%     -15.3%     155862 ±  6%  softirqs.CPU112.RCU
     28850 ± 11%     -47.3%      15197 ±  3%  softirqs.CPU112.SCHED
    185966 ± 11%     -13.9%     160107 ±  6%  softirqs.CPU113.RCU
     28961 ± 13%     -46.2%      15572 ±  5%  softirqs.CPU113.SCHED
    185695 ± 11%     -15.9%     156146 ±  7%  softirqs.CPU114.RCU
     29351 ± 15%     -48.2%      15198 ± 12%  softirqs.CPU114.SCHED
    185141 ± 11%     -14.7%     157862 ±  5%  softirqs.CPU115.RCU
     28897 ± 11%     -44.6%      16019 ± 10%  softirqs.CPU115.SCHED
    185476 ± 11%     -14.7%     158185 ±  6%  softirqs.CPU116.RCU
     29013 ± 11%     -47.3%      15296 ± 10%  softirqs.CPU116.SCHED
    186091 ± 11%     -14.3%     159414 ±  6%  softirqs.CPU117.RCU
     29035 ± 11%     -46.2%      15630 ±  5%  softirqs.CPU117.SCHED
     29187 ± 11%     -46.0%      15769 ±  7%  softirqs.CPU118.SCHED
    185601 ± 11%     -14.8%     158203 ±  5%  softirqs.CPU119.RCU
     28774 ± 12%     -48.3%      14882 ±  9%  softirqs.CPU119.SCHED
    176896 ± 11%     -17.7%     145584        softirqs.CPU12.RCU
     26941 ± 14%     -43.6%      15184 ± 17%  softirqs.CPU12.SCHED
      8300 ±120%     -87.1%       1074 ± 36%  softirqs.CPU12.TIMER
    185069 ± 11%     -15.0%     157391 ±  5%  softirqs.CPU120.RCU
     28586 ± 11%     -44.1%      15980 ±  4%  softirqs.CPU120.SCHED
    183879 ± 11%     -14.9%     156433 ±  5%  softirqs.CPU121.RCU
     28973 ± 11%     -44.2%      16171 ±  5%  softirqs.CPU121.SCHED
    185885 ± 11%     -14.7%     158619 ±  5%  softirqs.CPU122.RCU
     29016 ± 11%     -47.8%      15160 ±  6%  softirqs.CPU122.SCHED
    185820 ± 11%     -15.1%     157764 ±  5%  softirqs.CPU123.RCU
     29106 ± 10%     -49.3%      14755 ±  5%  softirqs.CPU123.SCHED
    185355 ± 11%     -14.9%     157656 ±  5%  softirqs.CPU124.RCU
     28433 ± 10%     -46.2%      15296 ±  6%  softirqs.CPU124.SCHED
    184495 ± 11%     -15.3%     156217 ±  5%  softirqs.CPU125.RCU
     29562 ± 10%     -47.7%      15454 ±  7%  softirqs.CPU125.SCHED
    162831 ± 14%     -22.6%     126036 ±  5%  softirqs.CPU126.RCU
     27983 ± 12%     -45.6%      15218 ±  3%  softirqs.CPU126.SCHED
    163641 ± 15%     -22.5%     126890 ±  4%  softirqs.CPU127.RCU
     28238 ± 11%     -41.6%      16490 ±  4%  softirqs.CPU127.SCHED
    175578 ± 16%     -18.2%     143625 ±  4%  softirqs.CPU128.RCU
     28422 ± 12%     -42.6%      16327 ±  2%  softirqs.CPU128.SCHED
    175330 ± 16%     -18.3%     143283 ±  5%  softirqs.CPU129.RCU
     28219 ± 11%     -43.4%      15964        softirqs.CPU129.SCHED
    181606 ± 14%     -17.5%     149780 ±  4%  softirqs.CPU13.RCU
     25966 ± 16%     -43.6%      14655 ± 15%  softirqs.CPU13.SCHED
    174309 ± 15%     -18.0%     142865 ±  4%  softirqs.CPU130.RCU
     27919 ± 13%     -39.4%      16926 ±  3%  softirqs.CPU130.SCHED
    175944 ± 16%     -18.0%     144359 ±  4%  softirqs.CPU131.RCU
     28807 ± 12%     -44.6%      15955 ±  8%  softirqs.CPU131.SCHED
    175957 ± 15%     -18.3%     143702 ±  4%  softirqs.CPU132.RCU
     27781 ± 12%     -40.4%      16566 ±  3%  softirqs.CPU132.SCHED
    175102 ± 15%     -18.1%     143330 ±  4%  softirqs.CPU133.RCU
     28551 ± 12%     -42.6%      16392 ±  5%  softirqs.CPU133.SCHED
    174439 ± 15%     -18.4%     142258 ±  5%  softirqs.CPU134.RCU
     27947 ± 13%     -41.7%      16293 ±  4%  softirqs.CPU134.SCHED
    175086 ± 16%     -17.4%     144665 ±  4%  softirqs.CPU135.RCU
     28336 ± 13%     -41.8%      16486 ±  4%  softirqs.CPU135.SCHED
    175640 ± 15%     -17.8%     144423 ±  4%  softirqs.CPU136.RCU
     28047 ± 12%     -40.2%      16761        softirqs.CPU136.SCHED
    175088 ± 15%     -18.2%     143220 ±  4%  softirqs.CPU137.RCU
     28025 ± 13%     -42.0%      16241 ±  9%  softirqs.CPU137.SCHED
    174745 ± 15%     -18.4%     142566 ±  4%  softirqs.CPU138.RCU
     28137 ± 12%     -38.7%      17238 ±  7%  softirqs.CPU138.SCHED
    175002 ± 15%     -17.4%     144527 ±  4%  softirqs.CPU139.RCU
     27781 ± 12%     -37.7%      17306 ±  7%  softirqs.CPU139.SCHED
    179978 ± 14%     -18.7%     146308 ±  4%  softirqs.CPU14.RCU
     25767 ± 12%     -43.4%      14574 ± 11%  softirqs.CPU14.SCHED
    176000 ± 15%     -17.8%     144716 ±  4%  softirqs.CPU140.RCU
     28013 ± 13%     -42.6%      16067 ±  4%  softirqs.CPU140.SCHED
    175311 ± 15%     -20.7%     139100 ±  9%  softirqs.CPU141.RCU
     28762 ± 10%     -41.6%      16796 ±  8%  softirqs.CPU141.SCHED
    174834 ± 15%     -18.3%     142791 ±  4%  softirqs.CPU142.RCU
     28189 ± 13%     -41.3%      16558 ±  4%  softirqs.CPU142.SCHED
    175073 ± 15%     -17.6%     144177 ±  5%  softirqs.CPU143.RCU
     28351 ± 13%     -36.0%      18135 ±  6%  softirqs.CPU143.SCHED
    180119 ± 14%     -18.7%     146416 ±  4%  softirqs.CPU15.RCU
     25693 ± 14%     -48.0%      13371 ± 10%  softirqs.CPU15.SCHED
    163622 ± 14%     -22.3%     127130 ±  4%  softirqs.CPU16.RCU
     25785 ± 11%     -45.1%      14167 ± 13%  softirqs.CPU16.SCHED
    163358 ± 14%     -22.3%     126921 ±  4%  softirqs.CPU17.RCU
     25737 ± 12%     -42.2%      14878 ± 16%  softirqs.CPU17.SCHED
    188067 ± 14%     -19.9%     150707 ±  5%  softirqs.CPU18.RCU
     29719 ±  5%     -58.3%      12378 ± 13%  softirqs.CPU18.SCHED
    186013 ± 13%     -19.5%     149832 ±  5%  softirqs.CPU19.RCU
     29958 ±  5%     -59.6%      12113 ± 12%  softirqs.CPU19.SCHED
    180540 ± 14%     -18.8%     146598 ±  4%  softirqs.CPU2.RCU
     26120 ± 13%     -47.4%      13745 ± 11%  softirqs.CPU2.SCHED
    185904 ± 14%     -19.4%     149825 ±  4%  softirqs.CPU20.RCU
     30088 ±  5%     -56.9%      12960 ± 24%  softirqs.CPU20.SCHED
    184534 ± 14%     -19.4%     148735 ±  5%  softirqs.CPU21.RCU
     29880 ±  6%     -57.9%      12592 ± 18%  softirqs.CPU21.SCHED
    185131 ± 14%     -20.0%     148055 ±  5%  softirqs.CPU22.RCU
     30088 ±  3%     -57.5%      12798 ± 20%  softirqs.CPU22.SCHED
    186267 ± 14%     -19.2%     150471 ±  4%  softirqs.CPU23.RCU
     29965 ±  6%     -58.4%      12466 ± 17%  softirqs.CPU23.SCHED
    185845 ± 14%     -19.3%     150035 ±  5%  softirqs.CPU24.RCU
     30104 ±  5%     -58.6%      12468 ± 17%  softirqs.CPU24.SCHED
    185365 ± 14%     -19.5%     149138 ±  4%  softirqs.CPU25.RCU
     29595 ±  2%     -57.1%      12689 ± 20%  softirqs.CPU25.SCHED
    180270 ± 10%     -17.8%     148219 ±  5%  softirqs.CPU26.RCU
     30090 ±  5%     -57.9%      12674 ± 19%  softirqs.CPU26.SCHED
    186037 ± 14%     -19.2%     150343 ±  5%  softirqs.CPU27.RCU
     30357 ±  3%     -59.8%      12193 ± 13%  softirqs.CPU27.SCHED
    185932 ± 14%     -19.3%     150046 ±  5%  softirqs.CPU28.RCU
     30387 ±  5%     -58.2%      12689 ± 19%  softirqs.CPU28.SCHED
    185591 ± 14%     -20.0%     148507 ±  5%  softirqs.CPU29.RCU
     29912 ±  5%     -57.5%      12709 ± 18%  softirqs.CPU29.SCHED
    180779 ± 14%     -18.3%     147750 ±  4%  softirqs.CPU3.RCU
     25411 ± 14%     -43.2%      14429 ± 12%  softirqs.CPU3.SCHED
    183707 ± 14%     -19.6%     147663 ±  4%  softirqs.CPU30.RCU
     30005 ±  6%     -57.8%      12647 ± 18%  softirqs.CPU30.SCHED
    184172 ± 13%     -21.4%     144846 ±  6%  softirqs.CPU31.RCU
     29903 ±  5%     -56.2%      13084 ± 25%  softirqs.CPU31.SCHED
    171778 ± 14%     -21.6%     134609 ±  5%  softirqs.CPU32.RCU
     30037 ±  5%     -57.9%      12643 ± 18%  softirqs.CPU32.SCHED
    171057 ± 14%     -21.7%     133968 ±  5%  softirqs.CPU33.RCU
     30219 ±  5%     -58.2%      12624 ± 20%  softirqs.CPU33.SCHED
    171389 ± 15%     -21.4%     134774 ±  6%  softirqs.CPU34.RCU
     30516 ±  5%     -59.2%      12457 ± 14%  softirqs.CPU34.SCHED
    171494 ± 14%     -21.1%     135250 ±  5%  softirqs.CPU35.RCU
     30023 ±  4%     -59.1%      12289 ± 16%  softirqs.CPU35.SCHED
    181290 ± 13%     -14.9%     154258 ±  5%  softirqs.CPU36.RCU
     29053 ± 11%     -51.6%      14058 ±  2%  softirqs.CPU36.SCHED
    181334 ± 12%     -14.2%     155511 ±  5%  softirqs.CPU37.RCU
     28250 ± 11%     -43.2%      16054 ±  6%  softirqs.CPU37.SCHED
    181030 ± 12%     -14.1%     155541 ±  5%  softirqs.CPU38.RCU
     28707 ± 11%     -45.7%      15599 ±  7%  softirqs.CPU38.SCHED
    180274 ± 12%     -14.8%     153606 ±  5%  softirqs.CPU39.RCU
     28787 ± 13%     -46.1%      15507        softirqs.CPU39.SCHED
    181956 ± 14%     -18.4%     148545 ±  4%  softirqs.CPU4.RCU
     25391 ± 15%     -44.3%      14130 ± 13%  softirqs.CPU4.SCHED
    180286 ± 12%     -14.9%     153441 ±  5%  softirqs.CPU40.RCU
     28735 ± 12%     -47.0%      15223 ±  4%  softirqs.CPU40.SCHED
    181233 ± 12%     -13.8%     156159 ±  5%  softirqs.CPU41.RCU
     28492 ± 13%     -45.8%      15443 ±  4%  softirqs.CPU41.SCHED
    181415 ± 12%     -19.0%     146945 ± 13%  softirqs.CPU42.RCU
     29239 ± 11%     -48.2%      15138 ±  3%  softirqs.CPU42.SCHED
    181162 ± 12%     -14.8%     154386 ±  5%  softirqs.CPU43.RCU
     28380 ± 14%     -43.7%      15973 ±  5%  softirqs.CPU43.SCHED
    180827 ± 12%     -14.6%     154401 ±  5%  softirqs.CPU44.RCU
     28768 ± 13%     -47.8%      15031 ±  9%  softirqs.CPU44.SCHED
    181654 ± 12%     -14.0%     156187 ±  5%  softirqs.CPU45.RCU
     28695 ± 11%     -44.3%      15969 ±  5%  softirqs.CPU45.SCHED
    179648 ± 13%     -13.8%     154805 ±  6%  softirqs.CPU46.RCU
     30075 ± 13%     -50.8%      14806 ±  7%  softirqs.CPU46.SCHED
    181072 ± 12%     -14.6%     154578 ±  5%  softirqs.CPU47.RCU
     28651 ± 12%     -45.2%      15697 ±  7%  softirqs.CPU47.SCHED
    177712 ± 12%     -17.1%     147242 ±  5%  softirqs.CPU48.RCU
     28855 ± 13%     -45.5%      15740 ±  5%  softirqs.CPU48.SCHED
    178280 ± 12%     -16.9%     148081 ±  5%  softirqs.CPU49.RCU
     28817 ± 10%     -47.5%      15140 ±  3%  softirqs.CPU49.SCHED
    180504 ± 15%     -18.2%     147679 ±  3%  softirqs.CPU5.RCU
     25244 ± 14%     -41.9%      14668 ± 14%  softirqs.CPU5.SCHED
    178681 ± 12%     -17.0%     148336 ±  5%  softirqs.CPU50.RCU
     29000 ± 12%     -49.2%      14743 ±  5%  softirqs.CPU50.SCHED
    178360 ± 12%     -16.8%     148318 ±  5%  softirqs.CPU51.RCU
     28759 ± 11%     -48.3%      14880 ±  7%  softirqs.CPU51.SCHED
    177584 ± 12%     -17.3%     146831 ±  5%  softirqs.CPU52.RCU
     28735 ± 12%     -44.8%      15865 ±  7%  softirqs.CPU52.SCHED
    177986 ± 12%     -17.0%     147807 ±  5%  softirqs.CPU53.RCU
     28925 ± 12%     -42.3%      16695 ± 17%  softirqs.CPU53.SCHED
    177577 ± 15%     -17.9%     145728 ±  4%  softirqs.CPU54.RCU
     28475 ± 12%     -46.1%      15358 ±  8%  softirqs.CPU54.SCHED
    178287 ± 15%     -17.8%     146612 ±  4%  softirqs.CPU55.RCU
     28305 ± 10%     -41.9%      16458 ±  6%  softirqs.CPU55.SCHED
    176670 ± 15%     -17.5%     145691 ±  4%  softirqs.CPU56.RCU
     27920 ± 12%     -41.8%      16243 ±  5%  softirqs.CPU56.SCHED
    177389 ± 15%     -17.5%     146407 ±  5%  softirqs.CPU57.RCU
     28222 ± 12%     -42.9%      16124        softirqs.CPU57.SCHED
    177331 ± 15%     -17.5%     146382 ±  5%  softirqs.CPU58.RCU
     28374 ± 12%     -42.3%      16382 ±  3%  softirqs.CPU58.SCHED
    177412 ± 15%     -17.5%     146355 ±  5%  softirqs.CPU59.RCU
     28230 ± 10%     -41.8%      16440 ±  8%  softirqs.CPU59.SCHED
    179682 ± 14%     -18.6%     146276 ±  4%  softirqs.CPU6.RCU
     26134 ± 13%     -46.5%      13973 ± 15%  softirqs.CPU6.SCHED
    177023 ± 15%     -17.5%     145977 ±  5%  softirqs.CPU60.RCU
     28521 ± 13%     -42.3%      16448 ±  3%  softirqs.CPU60.SCHED
    176681 ± 15%     -17.4%     145896 ±  5%  softirqs.CPU61.RCU
     27761 ± 11%     -42.8%      15891 ±  3%  softirqs.CPU61.SCHED
    176878 ± 15%     -17.5%     146004 ±  4%  softirqs.CPU62.RCU
     28559 ± 11%     -41.7%      16656 ±  5%  softirqs.CPU62.SCHED
    177058 ± 15%     -17.0%     146874 ±  5%  softirqs.CPU63.RCU
     28151 ± 11%     -42.4%      16212 ±  3%  softirqs.CPU63.SCHED
    174751 ± 15%     -17.2%     144699 ±  4%  softirqs.CPU64.RCU
     28262 ± 12%     -43.0%      16100 ±  4%  softirqs.CPU64.SCHED
    175144 ± 15%     -17.2%     145013 ±  4%  softirqs.CPU65.RCU
     28649 ± 12%     -44.8%      15808 ±  2%  softirqs.CPU65.SCHED
    175283 ± 15%     -17.2%     145072 ±  5%  softirqs.CPU66.RCU
     28249 ± 12%     -40.7%      16744 ±  4%  softirqs.CPU66.SCHED
    175245 ± 15%     -17.0%     145418 ±  4%  softirqs.CPU67.RCU
     28533 ± 13%     -41.5%      16691 ±  7%  softirqs.CPU67.SCHED
    174723 ± 15%     -17.2%     144749 ±  4%  softirqs.CPU68.RCU
     28528 ± 11%     -43.6%      16087        softirqs.CPU68.SCHED
    175212 ± 15%     -17.7%     144264 ±  5%  softirqs.CPU69.RCU
     28203 ± 13%     -42.4%      16247 ±  7%  softirqs.CPU69.SCHED
    180615 ± 14%     -18.5%     147211 ±  4%  softirqs.CPU7.RCU
     25771 ± 14%     -45.3%      14095 ± 13%  softirqs.CPU7.SCHED
    175210 ± 15%     -17.2%     145132 ±  4%  softirqs.CPU70.RCU
     27564 ± 11%     -41.4%      16154 ±  2%  softirqs.CPU70.SCHED
    175376 ± 15%     -17.0%     145643 ±  4%  softirqs.CPU71.RCU
     29266 ± 14%     -41.6%      17089 ±  9%  softirqs.CPU71.SCHED
    181207 ± 14%     -16.2%     151800 ±  4%  softirqs.CPU72.RCU
     25921 ± 14%     -47.6%      13592 ± 12%  softirqs.CPU72.SCHED
    183308 ± 13%     -16.2%     153694 ±  3%  softirqs.CPU73.RCU
     26080 ± 11%     -44.0%      14595 ± 14%  softirqs.CPU73.SCHED
    182677 ± 14%     -15.4%     154580 ±  4%  softirqs.CPU74.RCU
     25553 ± 12%     -42.2%      14760 ± 15%  softirqs.CPU74.SCHED
    183155 ± 14%     -15.4%     154904 ±  3%  softirqs.CPU75.RCU
     25521 ± 12%     -44.8%      14096 ± 13%  softirqs.CPU75.SCHED
    183730 ± 13%     -15.0%     156196 ±  3%  softirqs.CPU76.RCU
     26061 ± 11%     -43.6%      14692 ± 13%  softirqs.CPU76.SCHED
    182416 ± 14%     -15.6%     154006 ±  3%  softirqs.CPU77.RCU
     25393 ± 12%     -41.7%      14809 ± 15%  softirqs.CPU77.SCHED
    182222 ± 14%     -15.1%     154646 ±  3%  softirqs.CPU78.RCU
     25937 ± 13%     -44.4%      14419 ± 17%  softirqs.CPU78.SCHED
    183080 ± 14%     -15.3%     155092 ±  3%  softirqs.CPU79.RCU
     25554 ± 12%     -42.8%      14608 ± 15%  softirqs.CPU79.SCHED
    181316 ± 14%     -18.2%     148389 ±  4%  softirqs.CPU8.RCU
     25837 ± 10%     -46.0%      13958 ± 11%  softirqs.CPU8.SCHED
    185007 ± 14%     -15.5%     156261 ±  4%  softirqs.CPU80.RCU
     26157 ± 11%     -45.5%      14252 ± 13%  softirqs.CPU80.SCHED
    184321 ± 14%     -15.8%     155195 ±  4%  softirqs.CPU81.RCU
     25773 ± 14%     -44.2%      14380 ± 12%  softirqs.CPU81.SCHED
    184135 ± 15%     -15.6%     155363 ±  3%  softirqs.CPU82.RCU
     25906 ± 14%     -44.4%      14400 ± 13%  softirqs.CPU82.SCHED
    184376 ± 14%     -15.0%     156683 ±  3%  softirqs.CPU83.RCU
     25995 ± 13%     -44.2%      14496 ± 14%  softirqs.CPU83.SCHED
    185380 ± 14%     -19.7%     148785 ±  6%  softirqs.CPU84.RCU
     25964 ± 13%     -43.3%      14726 ±  9%  softirqs.CPU84.SCHED
    184936 ± 14%     -14.9%     157350 ±  4%  softirqs.CPU85.RCU
     25850 ± 11%     -41.8%      15043 ± 16%  softirqs.CPU85.SCHED
    184914 ± 14%     -15.8%     155667 ±  4%  softirqs.CPU86.RCU
     25454 ± 14%     -43.0%      14513 ± 14%  softirqs.CPU86.SCHED
    184043 ± 14%     -16.3%     153968 ±  4%  softirqs.CPU87.RCU
     25884 ± 11%     -45.9%      14015 ± 14%  softirqs.CPU87.SCHED
    183877 ± 14%     -15.6%     155109 ±  4%  softirqs.CPU88.RCU
     25795 ± 12%     -43.4%      14599 ± 14%  softirqs.CPU88.SCHED
    185255 ± 14%     -15.0%     157552 ±  4%  softirqs.CPU89.RCU
     26084 ± 15%     -41.7%      15199 ± 16%  softirqs.CPU89.SCHED
    179588 ± 14%     -18.6%     146226 ±  4%  softirqs.CPU9.RCU
     25509 ± 17%     -42.9%      14571 ± 11%  softirqs.CPU9.SCHED
    178631 ± 14%     -19.1%     144510 ±  5%  softirqs.CPU90.RCU
     29996 ±  4%     -58.8%      12357 ± 16%  softirqs.CPU90.SCHED
    178675 ± 14%     -19.2%     144375 ±  5%  softirqs.CPU91.RCU
     29809 ±  6%     -59.8%      11995 ± 11%  softirqs.CPU91.SCHED
    177752 ± 14%     -19.6%     142997 ±  5%  softirqs.CPU92.RCU
     30877 ±  5%     -57.4%      13148 ± 24%  softirqs.CPU92.SCHED
    178443 ± 14%     -19.0%     144569 ±  5%  softirqs.CPU93.RCU
     30033 ±  5%     -58.2%      12545 ± 19%  softirqs.CPU93.SCHED
    178791 ± 14%     -19.4%     144044 ±  5%  softirqs.CPU94.RCU
     30651 ±  6%     -57.9%      12895 ± 23%  softirqs.CPU94.SCHED
    178749 ± 14%     -19.1%     144575 ±  5%  softirqs.CPU95.RCU
     30319 ±  4%     -58.8%      12492 ± 18%  softirqs.CPU95.SCHED
    187353 ± 14%     -17.7%     154176 ±  5%  softirqs.CPU96.RCU
     29911 ±  5%     -59.3%      12171 ± 15%  softirqs.CPU96.SCHED
    187309 ± 14%     -17.9%     153842 ±  4%  softirqs.CPU97.RCU
     30350 ±  5%     -57.1%      13022 ± 24%  softirqs.CPU97.SCHED
    185522 ± 12%     -17.3%     153452 ±  5%  softirqs.CPU98.RCU
     29864 ±  3%     -57.6%      12661 ± 21%  softirqs.CPU98.SCHED
    185411 ± 13%     -18.0%     152065 ±  5%  softirqs.CPU99.RCU
     29872 ±  3%     -58.8%      12302 ± 13%  softirqs.CPU99.SCHED
  25926379 ± 14%     -17.5%   21381106 ±  4%  softirqs.RCU
   4074069 ±  2%     -48.0%    2119394        softirqs.SCHED
    252087 ±  8%     -31.4%     173043 ±  4%  softirqs.TIMER
     47.16            -7.1       40.04        perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read
     47.22            -7.1       40.14        perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read.ksys_read
     47.42            -6.9       40.53        perf-profile.calltrace.cycles-pp.sock_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
     47.51            -6.8       40.76        perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     17.75 ±  2%      -6.7       11.02 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
     47.80            -6.4       41.44        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     48.07            -6.2       41.91        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     48.12            -6.1       42.02        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      8.74 ±  5%      -5.8        2.98 ±  7%  perf-profile.calltrace.cycles-pp.refill_obj_stock.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
     48.48            -5.7       42.81        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read
     22.27 ±  2%      -5.6       16.70 ±  2%  perf-profile.calltrace.cycles-pp.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      5.55 ± 21%      -5.5        0.00        perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event
     20.96 ±  2%      -5.4       15.56 ±  2%  perf-profile.calltrace.cycles-pp.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     19.20 ±  2%      -5.2       13.98 ±  4%  perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     19.27 ±  2%      -5.2       14.06 ±  4%  perf-profile.calltrace.cycles-pp.__kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
     48.92            -5.1       43.78        perf-profile.calltrace.cycles-pp.__libc_read
      5.12 ± 21%      -5.1        0.00        perf-profile.calltrace.cycles-pp.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow
      5.10 ± 21%      -5.1        0.00        perf-profile.calltrace.cycles-pp.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
      7.18 ±  6%      -5.0        2.18 ±  6%  perf-profile.calltrace.cycles-pp.drain_obj_stock.refill_obj_stock.kfree.consume_skb.unix_stream_read_generic
      7.61 ±  5%      -4.7        2.90 ±  5%  perf-profile.calltrace.cycles-pp.refill_obj_stock.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     38.75            -4.6       34.12 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     39.28            -4.6       34.70 ±  2%  perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
     38.79            -4.6       34.20 ±  2%  perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      5.14 ±  9%      -4.4        0.70 ± 68%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.__memcg_kmem_uncharge.drain_obj_stock.refill_obj_stock
      5.96 ±  6%      -4.3        1.63 ±  7%  perf-profile.calltrace.cycles-pp.drain_obj_stock.refill_obj_stock.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
      3.04 ±  8%      -2.4        0.63 ± 10%  perf-profile.calltrace.cycles-pp.__memcg_kmem_uncharge.drain_obj_stock.refill_obj_stock.kfree.consume_skb
      2.92 ±  8%      -2.4        0.57 ± 10%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.__memcg_kmem_uncharge.drain_obj_stock.refill_obj_stock.kfree
      2.54 ±  9%      -2.3        0.28 ±100%  perf-profile.calltrace.cycles-pp.__memcg_kmem_uncharge.drain_obj_stock.refill_obj_stock.kmem_cache_free.unix_stream_read_generic
      2.48 ±  9%      -2.2        0.27 ±100%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.__memcg_kmem_uncharge.drain_obj_stock.refill_obj_stock.kmem_cache_free
      1.98 ± 16%      -1.2        0.79 ± 21%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      2.12 ±  8%      -1.0        1.12 ±  7%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      1.46 ± 16%      -1.0        0.47 ± 61%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.66 ±  9%      -1.0        0.69 ± 11%  perf-profile.calltrace.cycles-pp.__memcg_kmem_charge.obj_cgroup_charge.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb
      1.52 ± 10%      -0.9        0.66 ± 11%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.__memcg_kmem_charge.obj_cgroup_charge.__kmalloc_node_track_caller.__kmalloc_reserve
      4.83            -0.8        4.02 ±  2%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      2.14 ± 15%      -0.7        1.43 ± 13%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      0.89 ±  9%      -0.6        0.27 ±100%  perf-profile.calltrace.cycles-pp.__memcg_kmem_charge.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.82 ±  9%      -0.6        0.26 ±100%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.__memcg_kmem_charge.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb
      0.54 ±  3%      +0.1        0.64 ±  4%  perf-profile.calltrace.cycles-pp.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.53 ±  3%      +0.1        0.63 ±  4%  perf-profile.calltrace.cycles-pp.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      0.39 ± 57%      +0.2        0.61 ±  4%  perf-profile.calltrace.cycles-pp.unix_destruct_scm.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic
      0.77 ±  2%      +0.3        1.04        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg
      0.81            +0.3        1.09        perf-profile.calltrace.cycles-pp.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.79            +0.3        1.07        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     19.29            +0.5       19.77 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      0.00            +0.6        0.58 ±  2%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.schedule_timeout
      0.00            +0.6        0.59 ±  3%  perf-profile.calltrace.cycles-pp.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.__libc_read
      0.00            +0.6        0.59        perf-profile.calltrace.cycles-pp.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      2.52 ± 13%      +0.6        3.12 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.00            +0.6        0.60        perf-profile.calltrace.cycles-pp.check_preempt_curr.ttwu_do_wakeup.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.14 ±173%      +0.6        0.75 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      2.57 ± 13%      +0.6        3.19 ±  4%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      2.45 ± 12%      +0.6        3.07 ±  6%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp.ttwu_do_wakeup.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.00            +0.7        0.67 ±  3%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.__libc_read
      0.00            +0.7        0.71 ±  3%  perf-profile.calltrace.cycles-pp.refill_obj_stock.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00            +0.7        0.72 ±  3%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.__libc_read
      0.00            +0.7        0.72 ±  4%  perf-profile.calltrace.cycles-pp.prepare_to_wait.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.00            +0.8        0.75 ±  2%  perf-profile.calltrace.cycles-pp.reweight_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      0.00            +1.2        1.17 ±  2%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      0.00            +1.2        1.24 ±  3%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      1.07 ± 15%      +1.4        2.46 ±  5%  perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      1.11 ± 15%      +1.5        2.60 ±  5%  perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.__libc_write
     46.94            +1.7       48.64        perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write
      0.00            +1.7        1.73 ± 13%  perf-profile.calltrace.cycles-pp.available_idle_cpu.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function
      1.27 ± 14%      +1.8        3.05 ±  5%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.__libc_write
      1.30 ± 14%      +1.8        3.11 ±  5%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.__libc_write
      8.27            +1.9       10.13 ±  2%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     47.13            +1.9       49.03        perf-profile.calltrace.cycles-pp.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write.ksys_write
     47.24            +2.0       49.23        perf-profile.calltrace.cycles-pp.sock_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     47.46            +2.0       49.47        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     47.86            +2.3       50.16        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     48.33            +2.6       50.89        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     48.42            +2.6       51.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      4.47 ± 12%      +2.7        7.14 ±  6%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg
      0.59 ±  4%      +2.7        3.32 ± 11%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common
      4.52 ± 12%      +2.7        7.26 ±  6%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      4.61 ± 12%      +2.9        7.46 ±  6%  perf-profile.calltrace.cycles-pp.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.79 ±  5%      +3.3        4.11 ± 10%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
     49.78            +4.4       54.22        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write
      5.84 ± 12%      +4.7       10.57 ±  6%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable
      5.87 ± 12%      +4.8       10.67 ±  6%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg
      5.92 ± 12%      +4.9       10.80 ±  6%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_sendmsg
     50.20            +5.1       55.28        perf-profile.calltrace.cycles-pp.__libc_write
      6.15 ± 12%      +5.2       11.30 ±  6%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      6.37 ± 11%      +5.2       11.61 ±  6%  perf-profile.calltrace.cycles-pp.sock_def_readable.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
     16.66 ±  5%      -9.9        6.78 ±  5%  perf-profile.children.cycles-pp.refill_obj_stock
     13.46 ±  6%      -9.3        4.12 ±  6%  perf-profile.children.cycles-pp.drain_obj_stock
      9.50 ±  8%      -8.4        1.14 ± 10%  perf-profile.children.cycles-pp.page_counter_uncharge
      8.81 ±  8%      -7.7        1.13 ± 10%  perf-profile.children.cycles-pp.page_counter_cancel
     47.18            -7.1       40.06        perf-profile.children.cycles-pp.unix_stream_read_generic
     47.22            -7.1       40.14        perf-profile.children.cycles-pp.unix_stream_recvmsg
     47.43            -6.9       40.53        perf-profile.children.cycles-pp.sock_read_iter
     47.52            -6.7       40.77        perf-profile.children.cycles-pp.new_sync_read
     17.81 ±  2%      -6.7       11.07 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free
     47.82            -6.4       41.45        perf-profile.children.cycles-pp.vfs_read
     48.09            -6.1       41.94        perf-profile.children.cycles-pp.ksys_read
      6.73 ± 17%      -6.1        0.62 ±108%  perf-profile.children.cycles-pp.perf_tp_event
      6.48 ± 17%      -6.1        0.38 ±173%  perf-profile.children.cycles-pp.perf_swevent_overflow
      6.42 ± 17%      -6.0        0.38 ±173%  perf-profile.children.cycles-pp.__perf_event_overflow
      6.37 ± 17%      -6.0        0.38 ±173%  perf-profile.children.cycles-pp.perf_event_output_forward
      6.17 ± 17%      -5.8        0.37 ±173%  perf-profile.children.cycles-pp.perf_prepare_sample
     22.27 ±  2%      -5.6       16.70 ±  2%  perf-profile.children.cycles-pp.consume_skb
     21.02 ±  2%      -5.4       15.63 ±  2%  perf-profile.children.cycles-pp.kfree
      5.69 ± 17%      -5.3        0.34 ±173%  perf-profile.children.cycles-pp.perf_callchain
      5.66 ± 17%      -5.3        0.34 ±173%  perf-profile.children.cycles-pp.get_perf_callchain
     19.26 ±  2%      -5.2       14.05 ±  4%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
     19.27 ±  2%      -5.2       14.06 ±  4%  perf-profile.children.cycles-pp.__kmalloc_reserve
     48.98            -5.1       43.88        perf-profile.children.cycles-pp.__libc_read
      5.11 ± 17%      -4.8        0.31 ±173%  perf-profile.children.cycles-pp.perf_callchain_kernel
     38.75            -4.6       34.12 ±  2%  perf-profile.children.cycles-pp.__alloc_skb
     39.28            -4.6       34.70 ±  2%  perf-profile.children.cycles-pp.sock_alloc_send_pskb
     38.79            -4.6       34.20 ±  2%  perf-profile.children.cycles-pp.alloc_skb_with_frags
      5.64 ±  8%      -4.4        1.21 ±  9%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge
     96.60            -3.5       93.06        perf-profile.children.cycles-pp.do_syscall_64
      3.58 ± 16%      -3.2        0.38 ± 88%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      2.92 ±  9%      -2.5        0.47 ±  7%  perf-profile.children.cycles-pp.propagate_protected_usage
      4.01 ± 15%      -1.7        2.35 ± 15%  perf-profile.children.cycles-pp.update_curr
      1.89 ± 18%      -1.6        0.31 ± 69%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      2.55 ±  9%      -1.4        1.18 ± 10%  perf-profile.children.cycles-pp.__memcg_kmem_charge
      2.51 ±  9%      -1.3        1.17 ± 10%  perf-profile.children.cycles-pp.page_counter_try_charge
     98.33            -1.3       97.07        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      3.47 ±  7%      -0.9        2.52 ±  3%  perf-profile.children.cycles-pp.obj_cgroup_charge
      1.49 ± 16%      -0.9        0.58 ± 23%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      1.05 ±  7%      -0.9        0.16 ± 37%  perf-profile.children.cycles-pp.__slab_alloc
      1.01 ±  8%      -0.9        0.15 ± 35%  perf-profile.children.cycles-pp.___slab_alloc
      1.09 ±  3%      -0.8        0.33 ± 13%  perf-profile.children.cycles-pp.__mod_memcg_state
      1.16 ±  3%      -0.7        0.42 ±  9%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      2.18 ± 14%      -0.7        1.46 ± 13%  perf-profile.children.cycles-pp.dequeue_entity
      1.06            -0.5        0.56 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.94 ±  4%      -0.3        0.60 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.41 ± 10%      -0.3        0.09        perf-profile.children.cycles-pp.task_tick_fair
      0.56 ±  7%      -0.3        0.24 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.44 ±  9%      -0.3        0.13        perf-profile.children.cycles-pp.scheduler_tick
      0.48 ±  9%      -0.3        0.18        perf-profile.children.cycles-pp.tick_sched_handle
      0.50 ±  8%      -0.3        0.20        perf-profile.children.cycles-pp.tick_sched_timer
      0.47 ±  8%      -0.3        0.18 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.76 ±  6%      -0.3        0.51        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.70 ±  6%      -0.2        0.45        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.71 ±  6%      -0.2        0.46        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.40 ±  7%      -0.1        0.33 ±  3%  perf-profile.children.cycles-pp.__slab_free
      0.22 ±  8%      -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.mutex_unlock
      0.19 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.unix_write_space
      0.11 ±  7%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.skb_release_data
      0.06 ±  9%      +0.0        0.07        perf-profile.children.cycles-pp.__list_add_valid
      0.06 ± 11%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.start_thread
      0.07 ±  7%      +0.0        0.09        perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.14 ± 13%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.preempt_schedule_common
      0.10 ±  5%      +0.0        0.14 ±  6%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.42 ±  3%      +0.0        0.47 ±  3%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__ksize
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.place_entity
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.apparmor_socket_sendmsg
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.rb_next
      0.01 ±173%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.security_socket_getpeersec_dgram
      0.12 ±  3%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.copyin
      0.05            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.aa_file_perm
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.__x64_sys_write
      0.05 ±  8%      +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.clockevents_program_event
      0.45 ±  3%      +0.1        0.51 ±  6%  perf-profile.children.cycles-pp.sock_wfree
      0.10            +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.__might_sleep
      0.05 ±  9%      +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.ktime_get
      0.09 ±  7%      +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.rb_insert_color
      0.07 ±  7%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.__might_fault
      0.00            +0.1        0.07 ± 13%  perf-profile.children.cycles-pp.remove_entity_load_avg
      0.22 ±  5%      +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.fput_many
      0.19            +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.11 ±  6%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.33 ±  2%      +0.1        0.40 ±  4%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.mem_cgroup_from_task
      0.19 ±  2%      +0.1        0.27        perf-profile.children.cycles-pp.__entry_text_start
      0.12 ±  5%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.sock_recvmsg
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.wakeup_preempt_entity
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.cpumask_next
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.rcu_qs
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.10 ±  7%      +0.1        0.19 ±  6%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.00            +0.1        0.09 ± 12%  perf-profile.children.cycles-pp.get_xsave_addr
      0.12 ±  8%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.10 ±  7%      +0.1        0.19 ±  7%  perf-profile.children.cycles-pp.native_sched_clock
      0.11 ±  3%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.__check_heap_object
      0.06            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.rcu_all_qs
      0.52 ±  3%      +0.1        0.61 ±  5%  perf-profile.children.cycles-pp.unix_destruct_scm
      0.04 ± 58%      +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.06 ±  7%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.wait_for_unix_gc
      0.10 ±  8%      +0.1        0.20 ±  7%  perf-profile.children.cycles-pp.sched_clock
      0.53 ±  2%      +0.1        0.63 ±  5%  perf-profile.children.cycles-pp.skb_release_head_state
      0.12 ± 10%      +0.1        0.22 ±  6%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.54 ±  3%      +0.1        0.64 ±  5%  perf-profile.children.cycles-pp.skb_release_all
      0.20 ±  4%      +0.1        0.31 ±  2%  perf-profile.children.cycles-pp.aa_sk_perm
      0.35 ±  2%      +0.1        0.46        perf-profile.children.cycles-pp.simple_copy_to_iter
      0.34            +0.1        0.45 ±  2%  perf-profile.children.cycles-pp.__pthread_disable_asynccancel
      0.00            +0.1        0.12 ±  5%  perf-profile.children.cycles-pp.finish_wait
      0.04 ± 59%      +0.1        0.17 ± 22%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.41 ±  2%      +0.1        0.53 ±  3%  perf-profile.children.cycles-pp._copy_to_iter
      0.12 ± 14%      +0.1        0.25 ± 15%  perf-profile.children.cycles-pp.set_task_cpu
      0.18 ±  4%      +0.1        0.31        perf-profile.children.cycles-pp._copy_from_iter
      0.00            +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.23 ±  4%      +0.1        0.36 ±  7%  perf-profile.children.cycles-pp.skb_queue_tail
      0.16 ±  5%      +0.1        0.30        perf-profile.children.cycles-pp.fsnotify
      0.05            +0.1        0.19 ±  6%  perf-profile.children.cycles-pp._find_next_bit
      0.19 ± 16%      +0.1        0.34 ± 14%  perf-profile.children.cycles-pp.finish_task_switch
      0.20 ±  4%      +0.2        0.35 ±  3%  perf-profile.children.cycles-pp.common_file_perm
      0.00            +0.2        0.16 ±  5%  perf-profile.children.cycles-pp.resched_curr
      0.24 ±  7%      +0.2        0.40        perf-profile.children.cycles-pp._cond_resched
      0.00            +0.2        0.16 ± 21%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.00            +0.2        0.17 ±  3%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.04 ± 57%      +0.2        0.21 ±  8%  perf-profile.children.cycles-pp.set_next_buddy
      0.04 ± 58%      +0.2        0.22 ± 11%  perf-profile.children.cycles-pp.cpus_share_cache
      0.06 ±  9%      +0.2        0.24 ± 10%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.05 ±  8%      +0.2        0.24 ±  8%  perf-profile.children.cycles-pp.update_min_vruntime
      0.00            +0.2        0.19 ± 12%  perf-profile.children.cycles-pp.migrate_task_rq_fair
      0.15 ±  3%      +0.2        0.34 ±  3%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.00            +0.2        0.20 ±  2%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.08 ± 15%      +0.2        0.29 ±  3%  perf-profile.children.cycles-pp.copy_fpregs_to_fpstate
      0.15 ±  3%      +0.2        0.35 ±  5%  perf-profile.children.cycles-pp.mutex_lock
      0.08 ±  5%      +0.2        0.30 ±  9%  perf-profile.children.cycles-pp.cpumask_next_wrap
      0.31 ±  6%      +0.2        0.53 ±  4%  perf-profile.children.cycles-pp.__fget_files
      0.27 ±  5%      +0.2        0.49 ±  7%  perf-profile.children.cycles-pp.update_cfs_group
      0.12 ±  3%      +0.2        0.35 ±  6%  perf-profile.children.cycles-pp.cpuacct_charge
      0.18 ±  2%      +0.2        0.41 ±  6%  perf-profile.children.cycles-pp.___might_sleep
      0.47            +0.2        0.70        perf-profile.children.cycles-pp.__check_object_size
      0.30 ±  2%      +0.2        0.53 ±  2%  perf-profile.children.cycles-pp.security_file_permission
      0.00            +0.3        0.26        perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.33 ±  2%      +0.3        0.60        perf-profile.children.cycles-pp.skb_copy_datagram_from_iter
      0.10 ±  9%      +0.3        0.36        perf-profile.children.cycles-pp.__enqueue_entity
      0.78 ±  2%      +0.3        1.04        perf-profile.children.cycles-pp.__skb_datagram_iter
      0.82            +0.3        1.09        perf-profile.children.cycles-pp.unix_stream_read_actor
      0.00            +0.3        0.28 ±  5%  perf-profile.children.cycles-pp.clear_buddies
      0.79            +0.3        1.07        perf-profile.children.cycles-pp.skb_copy_datagram_iter
      0.80 ±  2%      +0.3        1.13 ± 15%  perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
      0.39 ±  4%      +0.3        0.71 ±  3%  perf-profile.children.cycles-pp.__fget_light
      0.08 ±  8%      +0.3        0.41 ±  2%  perf-profile.children.cycles-pp.rb_erase
      0.08 ±  6%      +0.3        0.41 ±  3%  perf-profile.children.cycles-pp.put_prev_entity
      0.41 ±  4%      +0.3        0.75 ±  3%  perf-profile.children.cycles-pp.__fdget_pos
      0.22 ±  4%      +0.3        0.56 ±  8%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.13 ±  3%      +0.3        0.48 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.13 ±  5%      +0.3        0.47 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.05 ± 62%      +0.3        0.39 ±  2%  perf-profile.children.cycles-pp.__calc_delta
      1.87            +0.4        2.23 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.00            +0.4        0.36 ±  6%  perf-profile.children.cycles-pp.___perf_sw_event
      0.14 ±  8%      +0.4        0.55 ±  2%  perf-profile.children.cycles-pp.check_preempt_wakeup
      0.31 ±  8%      +0.4        0.76 ±  3%  perf-profile.children.cycles-pp.__switch_to
      0.17 ±  8%      +0.5        0.63        perf-profile.children.cycles-pp.check_preempt_curr
      0.20 ±  9%      +0.5        0.67        perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.07 ±  7%      +0.5        0.54 ±  4%  perf-profile.children.cycles-pp.pick_next_entity
      0.10 ± 10%      +0.5        0.58 ±  6%  perf-profile.children.cycles-pp.__switch_to_asm
      0.00            +0.5        0.48 ± 29%  perf-profile.children.cycles-pp.sched_ttwu_pending
     19.34            +0.5       19.84 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.23 ±  5%      +0.5        0.73 ±  4%  perf-profile.children.cycles-pp.prepare_to_wait
      0.17 ±  7%      +0.5        0.67 ±  7%  perf-profile.children.cycles-pp.update_rq_clock
      2.50 ± 12%      +0.6        3.07 ±  6%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.00            +0.6        0.64 ± 29%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.00            +0.7        0.67 ± 29%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.25 ±  7%      +0.7        0.95 ±  4%  perf-profile.children.cycles-pp.switch_fpu_return
      0.00            +0.8        0.82 ± 28%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      2.57 ± 13%      +0.9        3.44 ±  6%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.21 ±  5%      +0.9        1.10 ±  2%  perf-profile.children.cycles-pp.set_next_entity
      0.71            +0.9        1.60 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.62 ± 13%      +0.9        3.52 ±  6%  perf-profile.children.cycles-pp.ttwu_do_activate
     13.18            +1.1       14.27 ±  2%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.20 ± 13%      +1.1        1.29 ±  4%  perf-profile.children.cycles-pp.reweight_entity
      0.48 ±  4%      +1.6        2.08 ±  6%  perf-profile.children.cycles-pp.update_load_avg
      0.26 ±  4%      +1.6        1.87 ± 13%  perf-profile.children.cycles-pp.available_idle_cpu
     46.95            +1.7       48.66        perf-profile.children.cycles-pp.unix_stream_sendmsg
     47.13            +1.9       49.03        perf-profile.children.cycles-pp.sock_sendmsg
     47.25            +2.0       49.24        perf-profile.children.cycles-pp.sock_write_iter
     47.46            +2.0       49.47        perf-profile.children.cycles-pp.new_sync_write
      0.49 ±  3%      +2.1        2.55 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.58 ± 12%      +2.1        3.73 ±  4%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      1.63 ± 12%      +2.2        3.84 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     47.87            +2.3       50.17        perf-profile.children.cycles-pp.vfs_write
     48.36            +2.5       50.89        perf-profile.children.cycles-pp.ksys_write
      0.60 ±  4%      +2.7        3.33 ± 11%  perf-profile.children.cycles-pp.select_idle_sibling
      4.70 ± 12%      +2.8        7.47 ±  6%  perf-profile.children.cycles-pp.schedule_timeout
      0.80 ±  5%      +3.3        4.11 ± 10%  perf-profile.children.cycles-pp.select_task_rq_fair
      5.94 ± 12%      +3.9        9.88 ±  5%  perf-profile.children.cycles-pp.__schedule
      5.87 ± 12%      +4.0        9.92 ±  5%  perf-profile.children.cycles-pp.schedule
      5.93 ± 12%      +4.7       10.59 ±  6%  perf-profile.children.cycles-pp.try_to_wake_up
      5.97 ± 12%      +4.7       10.67 ±  6%  perf-profile.children.cycles-pp.autoremove_wake_function
      6.03 ± 12%      +4.8       10.80 ±  6%  perf-profile.children.cycles-pp.__wake_up_common
      6.25 ± 12%      +5.1       11.31 ±  6%  perf-profile.children.cycles-pp.__wake_up_common_lock
     50.30            +5.1       55.41        perf-profile.children.cycles-pp.__libc_write
      6.37 ± 11%      +5.2       11.61 ±  6%  perf-profile.children.cycles-pp.sock_def_readable
      6.47 ±  8%      -5.6        0.85 ± 11%  perf-profile.self.cycles-pp.page_counter_cancel
     10.75            -2.5        8.30 ±  4%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      2.92 ±  9%      -2.4        0.47 ±  8%  perf-profile.self.cycles-pp.propagate_protected_usage
      9.63            -1.9        7.77 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      9.16            -1.2        7.94 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      3.96            -1.0        2.97 ±  5%  perf-profile.self.cycles-pp.drain_obj_stock
      1.91 ±  9%      -0.9        0.97 ± 10%  perf-profile.self.cycles-pp.page_counter_try_charge
      1.09 ±  3%      -0.8        0.33 ± 13%  perf-profile.self.cycles-pp.__mod_memcg_state
      3.05 ±  2%      -0.5        2.53 ±  4%  perf-profile.self.cycles-pp.refill_obj_stock
      1.06            -0.5        0.55 ±  3%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.42 ±  6%      -0.3        0.11 ± 25%  perf-profile.self.cycles-pp.___slab_alloc
      0.63 ±  3%      -0.2        0.44 ±  2%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.40 ±  6%      -0.1        0.32 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.22 ±  8%      -0.1        0.15 ±  3%  perf-profile.self.cycles-pp.mutex_unlock
      0.11 ±  6%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.skb_release_data
      0.07 ±  7%      +0.0        0.09        perf-profile.self.cycles-pp.unix_destruct_scm
      0.07 ±  6%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.10            +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__entry_text_start
      0.09 ±  4%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.03 ±100%      +0.0        0.06        perf-profile.self.cycles-pp.skb_unlink
      0.05            +0.0        0.09        perf-profile.self.cycles-pp.sock_alloc_send_pskb
      0.41 ±  4%      +0.0        0.46 ±  3%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.08 ± 10%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__libc_read
      0.01 ±173%      +0.0        0.06        perf-profile.self.cycles-pp.rcu_read_unlock_strict
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__skb_datagram_iter
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__ksize
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.rb_next
      0.14 ± 11%      +0.1        0.19 ±  8%  perf-profile.self.cycles-pp.perf_tp_event
      0.06 ± 11%      +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__might_fault
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__x64_sys_write
      0.22 ±  5%      +0.1        0.27 ±  2%  perf-profile.self.cycles-pp.__check_object_size
      0.14 ±  7%      +0.1        0.19 ±  2%  perf-profile.self.cycles-pp.new_sync_write
      0.11 ±  4%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.__alloc_skb
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.rcu_note_context_switch
      0.09            +0.1        0.15 ±  2%  perf-profile.self.cycles-pp.__might_sleep
      0.22 ±  5%      +0.1        0.28 ±  2%  perf-profile.self.cycles-pp.fput_many
      0.09            +0.1        0.15 ±  5%  perf-profile.self.cycles-pp.unix_write_space
      0.09 ±  7%      +0.1        0.15 ±  2%  perf-profile.self.cycles-pp.rb_insert_color
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.do_syscall_64
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp._copy_from_iter
      0.33 ±  2%      +0.1        0.40 ±  3%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.19 ±  2%      +0.1        0.26        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.01 ±173%      +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.security_file_permission
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.mem_cgroup_from_task
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp._cond_resched
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.09 ±  4%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.aa_sk_perm
      0.10 ±  4%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.unix_stream_recvmsg
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.wakeup_preempt_entity
      0.05 ±  8%      +0.1        0.13 ±  9%  perf-profile.self.cycles-pp.__wake_up_common
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.ksys_read
      0.03 ±100%      +0.1        0.11 ±  7%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.check_preempt_curr
      0.25 ±  3%      +0.1        0.33 ±  7%  perf-profile.self.cycles-pp.sock_wfree
      0.21 ±  6%      +0.1        0.30 ±  5%  perf-profile.self.cycles-pp.sock_def_readable
      0.11 ±  3%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.sock_write_iter
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.alloc_skb_with_frags
      0.00            +0.1        0.08 ± 19%  perf-profile.self.cycles-pp.rcu_qs
      0.00            +0.1        0.08 ± 17%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.security_socket_sendmsg
      0.06            +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.consume_skb
      0.10 ±  5%      +0.1        0.18 ±  7%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.00            +0.1        0.09 ± 12%  perf-profile.self.cycles-pp.get_xsave_addr
      0.11            +0.1        0.20        perf-profile.self.cycles-pp.__check_heap_object
      0.05            +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.rcu_all_qs
      0.10 ±  9%      +0.1        0.19 ±  7%  perf-profile.self.cycles-pp.native_sched_clock
      0.07 ±  7%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp._copy_to_iter
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.wait_for_unix_gc
      0.00            +0.1        0.10 ± 28%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.00            +0.1        0.10 ±  9%  perf-profile.self.cycles-pp.aa_file_perm
      0.15 ±  5%      +0.1        0.25 ±  2%  perf-profile.self.cycles-pp.common_file_perm
      0.07 ±  5%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.__fget_light
      0.09 ±  4%      +0.1        0.19 ±  2%  perf-profile.self.cycles-pp.sock_read_iter
      0.00            +0.1        0.10        perf-profile.self.cycles-pp.put_prev_entity
      0.05            +0.1        0.16 ±  7%  perf-profile.self.cycles-pp.dequeue_entity
      0.33 ±  2%      +0.1        0.44 ±  2%  perf-profile.self.cycles-pp.__pthread_disable_asynccancel
      0.00            +0.1        0.11 ± 11%  perf-profile.self.cycles-pp.migrate_task_rq_fair
      0.17 ±  4%      +0.1        0.29 ±  2%  perf-profile.self.cycles-pp.vfs_write
      0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.08 ± 13%      +0.1        0.21 ±  3%  perf-profile.self.cycles-pp.schedule
      0.08 ± 13%      +0.1        0.21 ±  6%  perf-profile.self.cycles-pp.schedule_timeout
      0.06 ± 11%      +0.1        0.18 ±  8%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.03 ±100%      +0.1        0.15 ±  8%  perf-profile.self.cycles-pp.cpumask_next_wrap
      0.00            +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.15 ±  5%      +0.1        0.29        perf-profile.self.cycles-pp.fsnotify
      0.22 ± 14%      +0.1        0.35 ±  5%  perf-profile.self.cycles-pp.enqueue_entity
      0.05            +0.1        0.19 ±  6%  perf-profile.self.cycles-pp._find_next_bit
      0.08 ±  6%      +0.1        0.22 ±  5%  perf-profile.self.cycles-pp.new_sync_read
      0.00            +0.2        0.16 ±  7%  perf-profile.self.cycles-pp.resched_curr
      0.04 ± 57%      +0.2        0.20 ±  9%  perf-profile.self.cycles-pp.set_next_buddy
      0.08 ±  6%      +0.2        0.23 ±  7%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.06 ±  9%      +0.2        0.21 ±  4%  perf-profile.self.cycles-pp.check_preempt_wakeup
      0.11 ±  4%      +0.2        0.27 ±  6%  perf-profile.self.cycles-pp.mutex_lock
      0.00            +0.2        0.17 ±  3%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.04 ± 57%      +0.2        0.22 ± 11%  perf-profile.self.cycles-pp.cpus_share_cache
      0.06 ±  9%      +0.2        0.24 ± 10%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.05 ±  8%      +0.2        0.24 ±  7%  perf-profile.self.cycles-pp.update_min_vruntime
      0.08 ± 15%      +0.2        0.29 ±  3%  perf-profile.self.cycles-pp.copy_fpregs_to_fpstate
      0.10 ±  5%      +0.2        0.30 ±  4%  perf-profile.self.cycles-pp.vfs_read
      0.14 ± 10%      +0.2        0.35 ±  7%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.31 ±  5%      +0.2        0.53 ±  4%  perf-profile.self.cycles-pp.__fget_files
      0.27 ±  5%      +0.2        0.48 ±  8%  perf-profile.self.cycles-pp.update_cfs_group
      0.18 ±  2%      +0.2        0.40 ±  5%  perf-profile.self.cycles-pp.___might_sleep
      0.07 ±  7%      +0.2        0.29 ±  8%  perf-profile.self.cycles-pp.try_to_wake_up
      0.12 ±  5%      +0.2        0.35 ±  6%  perf-profile.self.cycles-pp.cpuacct_charge
      0.00            +0.2        0.23 ±  4%  perf-profile.self.cycles-pp.pick_next_entity
      0.00            +0.2        0.23 ± 12%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.00            +0.2        0.23 ±  2%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.12 ±  7%      +0.2        0.36        perf-profile.self.cycles-pp.prepare_to_wait
      0.15 ±  2%      +0.3        0.41 ±  4%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.09 ± 11%      +0.3        0.36 ±  3%  perf-profile.self.cycles-pp.__enqueue_entity
      0.10 ±  7%      +0.3        0.37 ±  2%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.00            +0.3        0.27 ±  5%  perf-profile.self.cycles-pp.clear_buddies
      0.13 ± 10%      +0.3        0.40 ±  8%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.00            +0.3        0.31 ±  6%  perf-profile.self.cycles-pp.___perf_sw_event
      0.06            +0.3        0.38        perf-profile.self.cycles-pp.set_next_entity
      0.13 ±  6%      +0.3        0.45 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.08 ± 10%      +0.3        0.41 ±  2%  perf-profile.self.cycles-pp.rb_erase
      0.05 ± 62%      +0.3        0.39        perf-profile.self.cycles-pp.__calc_delta
      0.13 ±  5%      +0.3        0.47 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.29 ±  8%      +0.4        0.65 ±  2%  perf-profile.self.cycles-pp.__switch_to
      0.24 ±  2%      +0.4        0.62 ±  5%  perf-profile.self.cycles-pp.unix_stream_sendmsg
      0.11 ±  9%      +0.4        0.50 ±  9%  perf-profile.self.cycles-pp.update_rq_clock
      0.09 ±  9%      +0.5        0.54 ±  6%  perf-profile.self.cycles-pp.reweight_entity
     11.85            +0.5       12.32 ±  2%  perf-profile.self.cycles-pp.kfree
      0.10 ± 12%      +0.5        0.58 ±  6%  perf-profile.self.cycles-pp.__switch_to_asm
      0.16 ±  8%      +0.6        0.80 ±  5%  perf-profile.self.cycles-pp.update_curr
      0.25 ±  7%      +0.7        0.94 ±  4%  perf-profile.self.cycles-pp.switch_fpu_return
      0.46 ±  2%      +0.7        1.19 ±  4%  perf-profile.self.cycles-pp.unix_stream_read_generic
      0.20 ±  6%      +0.7        0.93 ± 11%  perf-profile.self.cycles-pp.select_idle_sibling
      0.21 ±  2%      +0.8        1.02 ±  9%  perf-profile.self.cycles-pp.update_load_avg
      0.89 ±  2%      +0.8        1.70 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.62            +0.9        1.54 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
     13.03            +1.0       14.04 ±  2%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.31 ±  3%      +1.2        1.53 ±  3%  perf-profile.self.cycles-pp.__schedule
      0.25 ±  5%      +1.6        1.86 ± 13%  perf-profile.self.cycles-pp.available_idle_cpu
  80845791 ± 15%    +593.4%  5.606e+08 ±  8%  interrupts.CAL:Function_call_interrupts
    554100 ± 12%   +1379.7%    8199171 ± 55%  interrupts.CPU0.CAL:Function_call_interrupts
   2633873           -29.2%    1865030        interrupts.CPU0.LOC:Local_timer_interrupts
   1482255 ± 11%     +64.5%    2439004 ± 16%  interrupts.CPU0.RES:Rescheduling_interrupts
    550298 ± 11%    +680.9%    4297484 ± 48%  interrupts.CPU1.CAL:Function_call_interrupts
   2633863           -29.2%    1865036        interrupts.CPU1.LOC:Local_timer_interrupts
   1412849 ± 12%    +130.8%    3261354 ±  8%  interrupts.CPU1.RES:Rescheduling_interrupts
    535367 ± 13%    +713.8%    4357060 ± 45%  interrupts.CPU10.CAL:Function_call_interrupts
   2633812           -29.2%    1865326        interrupts.CPU10.LOC:Local_timer_interrupts
   1398394 ± 14%    +142.1%    3386097 ± 15%  interrupts.CPU10.RES:Rescheduling_interrupts
    577438 ± 16%    +199.2%    1727584 ± 91%  interrupts.CPU100.CAL:Function_call_interrupts
   2633810           -29.2%    1865135        interrupts.CPU100.LOC:Local_timer_interrupts
   1410125 ±  3%    +110.5%    2968345 ± 20%  interrupts.CPU100.RES:Rescheduling_interrupts
    576842 ± 15%    +219.4%    1842591 ± 75%  interrupts.CPU101.CAL:Function_call_interrupts
   2633820           -29.2%    1864888        interrupts.CPU101.LOC:Local_timer_interrupts
   1449967 ±  9%    +105.9%    2985344 ± 22%  interrupts.CPU101.RES:Rescheduling_interrupts
    581564 ± 16%    +277.8%    2197241 ± 82%  interrupts.CPU102.CAL:Function_call_interrupts
   2633820           -29.2%    1865122        interrupts.CPU102.LOC:Local_timer_interrupts
   1450315 ±  6%    +118.0%    3161937 ± 16%  interrupts.CPU102.RES:Rescheduling_interrupts
    572128 ± 16%    +189.3%    1654974 ± 66%  interrupts.CPU103.CAL:Function_call_interrupts
   2633815           -29.2%    1865084        interrupts.CPU103.LOC:Local_timer_interrupts
   1485537 ±  7%    +101.5%    2993556 ± 19%  interrupts.CPU103.RES:Rescheduling_interrupts
    571702 ± 16%    +254.5%    2026666 ± 86%  interrupts.CPU104.CAL:Function_call_interrupts
   2633807           -29.2%    1865070        interrupts.CPU104.LOC:Local_timer_interrupts
   1505692 ±  7%    +121.3%    3332814 ± 15%  interrupts.CPU104.RES:Rescheduling_interrupts
    571646 ± 15%    +246.3%    1979757 ± 85%  interrupts.CPU105.CAL:Function_call_interrupts
   2633752           -29.2%    1865102        interrupts.CPU105.LOC:Local_timer_interrupts
   1476944 ±  5%    +126.3%    3342064 ± 16%  interrupts.CPU105.RES:Rescheduling_interrupts
    569567 ± 16%    +207.9%    1753774 ± 70%  interrupts.CPU106.CAL:Function_call_interrupts
   2633740           -29.2%    1865098        interrupts.CPU106.LOC:Local_timer_interrupts
   1458855 ±  5%    +112.9%    3105708 ± 11%  interrupts.CPU106.RES:Rescheduling_interrupts
    580876 ± 16%    +242.0%    1986529 ± 89%  interrupts.CPU107.CAL:Function_call_interrupts
   2633811           -29.2%    1865005        interrupts.CPU107.LOC:Local_timer_interrupts
   1418276 ±  8%    +121.3%    3139084 ± 18%  interrupts.CPU107.RES:Rescheduling_interrupts
    595179 ± 14%   +1293.0%    8291002 ± 26%  interrupts.CPU108.CAL:Function_call_interrupts
   2633789           -29.2%    1865051        interrupts.CPU108.LOC:Local_timer_interrupts
   1436203 ± 11%    +110.4%    3021112 ±  8%  interrupts.CPU108.RES:Rescheduling_interrupts
    576009 ± 16%    +562.3%    3815028 ± 12%  interrupts.CPU109.CAL:Function_call_interrupts
   2633796           -29.2%    1865119        interrupts.CPU109.LOC:Local_timer_interrupts
   1474371 ± 10%    +152.8%    3726667 ±  7%  interrupts.CPU109.RES:Rescheduling_interrupts
    537884 ± 12%    +604.1%    3787128 ± 45%  interrupts.CPU11.CAL:Function_call_interrupts
   2633889           -29.2%    1865183        interrupts.CPU11.LOC:Local_timer_interrupts
   1353579 ± 12%    +143.9%    3301148 ± 13%  interrupts.CPU11.RES:Rescheduling_interrupts
    579505 ± 15%    +602.3%    4069904 ± 25%  interrupts.CPU110.CAL:Function_call_interrupts
   2633866           -29.2%    1865154        interrupts.CPU110.LOC:Local_timer_interrupts
   1485870 ± 12%    +151.8%    3741307 ± 13%  interrupts.CPU110.RES:Rescheduling_interrupts
    574480 ± 15%    +726.8%    4750053 ± 23%  interrupts.CPU111.CAL:Function_call_interrupts
   2633731           -29.2%    1865194        interrupts.CPU111.LOC:Local_timer_interrupts
   1453539 ± 11%    +206.5%    4454917 ± 10%  interrupts.CPU111.RES:Rescheduling_interrupts
    574177 ± 16%    +583.1%    3922097 ± 28%  interrupts.CPU112.CAL:Function_call_interrupts
   2633698           -29.2%    1865157        interrupts.CPU112.LOC:Local_timer_interrupts
   1449339 ±  6%    +171.8%    3938937 ± 10%  interrupts.CPU112.RES:Rescheduling_interrupts
    572339 ± 16%    +623.2%    4139018 ±  2%  interrupts.CPU113.CAL:Function_call_interrupts
   2633574           -29.2%    1865169        interrupts.CPU113.LOC:Local_timer_interrupts
   1461578 ± 10%    +168.2%    3920285 ±  4%  interrupts.CPU113.RES:Rescheduling_interrupts
    581846 ± 15%    +747.3%    4930055 ± 24%  interrupts.CPU114.CAL:Function_call_interrupts
   2633735           -29.2%    1865175        interrupts.CPU114.LOC:Local_timer_interrupts
   1487035 ± 15%    +155.8%    3803822 ±  5%  interrupts.CPU114.RES:Rescheduling_interrupts
    568185 ± 16%    +590.8%    3924748 ± 18%  interrupts.CPU115.CAL:Function_call_interrupts
   2633765           -29.2%    1865158        interrupts.CPU115.LOC:Local_timer_interrupts
   1421770 ±  5%    +184.4%    4043182 ±  9%  interrupts.CPU115.RES:Rescheduling_interrupts
    574231 ± 15%    +601.3%    4027085 ± 16%  interrupts.CPU116.CAL:Function_call_interrupts
   2633606           -29.2%    1865145        interrupts.CPU116.LOC:Local_timer_interrupts
   1463960 ± 12%    +139.2%    3502130 ±  8%  interrupts.CPU116.RES:Rescheduling_interrupts
    567120 ± 15%    +607.9%    4014482 ± 29%  interrupts.CPU117.CAL:Function_call_interrupts
   2633557           -29.2%    1865129        interrupts.CPU117.LOC:Local_timer_interrupts
   1495359 ± 13%    +186.9%    4290630 ±  7%  interrupts.CPU117.RES:Rescheduling_interrupts
    578676 ± 16%    +550.9%    3766680 ± 16%  interrupts.CPU118.CAL:Function_call_interrupts
   2633683           -29.2%    1865186        interrupts.CPU118.LOC:Local_timer_interrupts
   1512609 ± 11%    +159.9%    3931438 ±  6%  interrupts.CPU118.RES:Rescheduling_interrupts
    566333 ± 17%    +595.5%    3938821 ±  6%  interrupts.CPU119.CAL:Function_call_interrupts
   2633592           -29.2%    1865154        interrupts.CPU119.LOC:Local_timer_interrupts
   1488137 ± 14%    +144.6%    3640022 ±  7%  interrupts.CPU119.RES:Rescheduling_interrupts
    538190 ± 13%    +569.6%    3603715 ± 48%  interrupts.CPU12.CAL:Function_call_interrupts
   2633798           -29.2%    1865228        interrupts.CPU12.LOC:Local_timer_interrupts
   1471083 ± 18%    +126.4%    3330734 ± 12%  interrupts.CPU12.RES:Rescheduling_interrupts
    574035 ± 14%    +686.0%    4511762 ± 25%  interrupts.CPU120.CAL:Function_call_interrupts
   2633804           -29.2%    1865123        interrupts.CPU120.LOC:Local_timer_interrupts
   1431892 ± 10%    +167.6%    3831695 ±  5%  interrupts.CPU120.RES:Rescheduling_interrupts
    566905 ± 16%    +781.2%    4995501 ± 24%  interrupts.CPU121.CAL:Function_call_interrupts
   2633711           -29.2%    1865103        interrupts.CPU121.LOC:Local_timer_interrupts
   1464668 ± 12%    +184.4%    4164954 ±  6%  interrupts.CPU121.RES:Rescheduling_interrupts
    574493 ± 16%    +767.3%    4982480 ± 21%  interrupts.CPU122.CAL:Function_call_interrupts
   2633766           -29.2%    1865160        interrupts.CPU122.LOC:Local_timer_interrupts
   1465207 ± 11%    +157.0%    3765515 ± 15%  interrupts.CPU122.RES:Rescheduling_interrupts
    574985 ± 15%    +578.3%    3899889 ± 39%  interrupts.CPU123.CAL:Function_call_interrupts
   2633799           -29.2%    1865115        interrupts.CPU123.LOC:Local_timer_interrupts
   1528615 ±  8%    +152.1%    3853358 ±  5%  interrupts.CPU123.RES:Rescheduling_interrupts
    573524 ± 15%    +603.1%    4032416 ± 23%  interrupts.CPU124.CAL:Function_call_interrupts
   2633643           -29.2%    1865025        interrupts.CPU124.LOC:Local_timer_interrupts
   1438497 ± 12%    +178.0%    3999107 ±  8%  interrupts.CPU124.RES:Rescheduling_interrupts
    572476 ± 16%    +743.8%    4830789 ± 26%  interrupts.CPU125.CAL:Function_call_interrupts
   2633770           -29.2%    1865163        interrupts.CPU125.LOC:Local_timer_interrupts
   1487222 ± 11%    +165.9%    3954967 ±  4%  interrupts.CPU125.RES:Rescheduling_interrupts
    571725 ± 16%   +1191.8%    7385638 ± 13%  interrupts.CPU126.CAL:Function_call_interrupts
   2633775           -29.2%    1865098        interrupts.CPU126.LOC:Local_timer_interrupts
   1401581 ±  3%    +105.1%    2874635 ± 12%  interrupts.CPU126.RES:Rescheduling_interrupts
    566626 ± 16%    +669.8%    4361710 ± 11%  interrupts.CPU127.CAL:Function_call_interrupts
   2633816           -29.2%    1864935        interrupts.CPU127.LOC:Local_timer_interrupts
   1419656          +190.3%    4121899 ±  3%  interrupts.CPU127.RES:Rescheduling_interrupts
    563855 ± 16%    +680.2%    4399187 ± 13%  interrupts.CPU128.CAL:Function_call_interrupts
   2633791           -29.2%    1865117        interrupts.CPU128.LOC:Local_timer_interrupts
   1437346 ±  4%    +174.2%    3941330 ±  7%  interrupts.CPU128.RES:Rescheduling_interrupts
    562917 ± 16%    +682.1%    4402639 ± 32%  interrupts.CPU129.CAL:Function_call_interrupts
   2633617           -29.2%    1865180        interrupts.CPU129.LOC:Local_timer_interrupts
   1404082 ±  4%    +178.4%    3909629 ±  2%  interrupts.CPU129.RES:Rescheduling_interrupts
    535349 ± 13%    +758.1%    4593651 ± 51%  interrupts.CPU13.CAL:Function_call_interrupts
   2633788           -29.2%    1865227        interrupts.CPU13.LOC:Local_timer_interrupts
   1410172 ± 17%    +132.2%    3274335 ± 18%  interrupts.CPU13.RES:Rescheduling_interrupts
    557248 ± 17%    +655.3%    4208639 ± 15%  interrupts.CPU130.CAL:Function_call_interrupts
   2633723           -29.2%    1865055        interrupts.CPU130.LOC:Local_timer_interrupts
   1392351 ±  2%    +187.2%    3998949 ±  6%  interrupts.CPU130.RES:Rescheduling_interrupts
    555534 ± 16%    +718.3%    4545984 ± 32%  interrupts.CPU131.CAL:Function_call_interrupts
   2633752           -29.2%    1865092        interrupts.CPU131.LOC:Local_timer_interrupts
   1489083 ±  8%    +178.4%    4145278 ±  3%  interrupts.CPU131.RES:Rescheduling_interrupts
    558117 ± 16%    +745.2%    4717120 ± 19%  interrupts.CPU132.CAL:Function_call_interrupts
   2633542           -29.2%    1865057        interrupts.CPU132.LOC:Local_timer_interrupts
   1377068 ±  5%    +181.2%    3872442 ±  4%  interrupts.CPU132.RES:Rescheduling_interrupts
    560564 ± 16%    +695.7%    4460292 ± 29%  interrupts.CPU133.CAL:Function_call_interrupts
   2633715           -29.2%    1865108        interrupts.CPU133.LOC:Local_timer_interrupts
   1458375          +152.0%    3674582 ±  8%  interrupts.CPU133.RES:Rescheduling_interrupts
    553770 ± 16%    +677.8%    4307149 ± 14%  interrupts.CPU134.CAL:Function_call_interrupts
   2633784           -29.2%    1865070        interrupts.CPU134.LOC:Local_timer_interrupts
   1386197 ±  3%    +173.3%    3788186 ± 10%  interrupts.CPU134.RES:Rescheduling_interrupts
    559795 ± 15%    +658.3%    4245180 ± 29%  interrupts.CPU135.CAL:Function_call_interrupts
   2633732           -29.2%    1865135        interrupts.CPU135.LOC:Local_timer_interrupts
   1437159          +201.7%    4336194 ±  6%  interrupts.CPU135.RES:Rescheduling_interrupts
    565365 ± 16%    +595.2%    3930650 ± 15%  interrupts.CPU136.CAL:Function_call_interrupts
   2633726           -29.2%    1864945        interrupts.CPU136.LOC:Local_timer_interrupts
   1366297 ±  4%    +188.7%    3943869 ±  3%  interrupts.CPU136.RES:Rescheduling_interrupts
    560228 ± 15%    +785.3%    4959766 ± 11%  interrupts.CPU137.CAL:Function_call_interrupts
   2633801           -29.2%    1865074        interrupts.CPU137.LOC:Local_timer_interrupts
   1378808 ±  3%    +178.5%    3839326 ±  5%  interrupts.CPU137.RES:Rescheduling_interrupts
    557473 ± 18%    +711.1%    4521407 ± 18%  interrupts.CPU138.CAL:Function_call_interrupts
   2633801           -29.2%    1865014        interrupts.CPU138.LOC:Local_timer_interrupts
   1382141          +186.2%    3955521 ±  5%  interrupts.CPU138.RES:Rescheduling_interrupts
    557471 ± 16%    +676.9%    4331168 ± 33%  interrupts.CPU139.CAL:Function_call_interrupts
   2633711           -29.2%    1864983        interrupts.CPU139.LOC:Local_timer_interrupts
   1351197          +178.0%    3756469 ± 11%  interrupts.CPU139.RES:Rescheduling_interrupts
    540897 ± 12%    +522.4%    3366732 ± 51%  interrupts.CPU14.CAL:Function_call_interrupts
   2633694           -29.2%    1865533        interrupts.CPU14.LOC:Local_timer_interrupts
   1428323 ± 12%    +127.1%    3244079 ± 19%  interrupts.CPU14.RES:Rescheduling_interrupts
    568254 ± 16%    +772.3%    4957094 ± 31%  interrupts.CPU140.CAL:Function_call_interrupts
   2633781           -29.2%    1864986        interrupts.CPU140.LOC:Local_timer_interrupts
   1384947 ±  4%    +185.1%    3948921 ±  6%  interrupts.CPU140.RES:Rescheduling_interrupts
    565567 ± 16%    +782.9%    4993387 ± 17%  interrupts.CPU141.CAL:Function_call_interrupts
   2633738           -29.2%    1864968        interrupts.CPU141.LOC:Local_timer_interrupts
   1480611 ±  2%    +168.4%    3973399 ±  5%  interrupts.CPU141.RES:Rescheduling_interrupts
    560572 ± 16%    +795.9%    5022300 ± 25%  interrupts.CPU142.CAL:Function_call_interrupts
   2633708           -29.2%    1865072        interrupts.CPU142.LOC:Local_timer_interrupts
   1421927 ±  2%    +161.2%    3713622 ± 12%  interrupts.CPU142.RES:Rescheduling_interrupts
    557943 ± 16%    +578.3%    3784321 ± 26%  interrupts.CPU143.CAL:Function_call_interrupts
   2633702           -29.2%    1865057        interrupts.CPU143.LOC:Local_timer_interrupts
   1360011 ±  4%    +183.5%    3856151 ±  3%  interrupts.CPU143.RES:Rescheduling_interrupts
    537700 ± 12%    +679.7%    4192322 ± 52%  interrupts.CPU15.CAL:Function_call_interrupts
   2633763           -29.2%    1865110        interrupts.CPU15.LOC:Local_timer_interrupts
   1408175 ± 17%    +141.5%    3400976 ±  2%  interrupts.CPU15.RES:Rescheduling_interrupts
    534343 ± 13%    +635.0%    3927692 ± 46%  interrupts.CPU16.CAL:Function_call_interrupts
   2633738           -29.2%    1865093        interrupts.CPU16.LOC:Local_timer_interrupts
   1406704 ± 11%    +158.0%    3628791 ±  5%  interrupts.CPU16.RES:Rescheduling_interrupts
    534677 ± 13%    +714.1%    4353035 ± 54%  interrupts.CPU17.CAL:Function_call_interrupts
   2633799           -29.2%    1865188        interrupts.CPU17.LOC:Local_timer_interrupts
   1375046 ± 10%    +142.3%    3331891 ± 11%  interrupts.CPU17.RES:Rescheduling_interrupts
    593706 ± 15%    +288.1%    2304241 ±103%  interrupts.CPU18.CAL:Function_call_interrupts
   2633800           -29.2%    1865119        interrupts.CPU18.LOC:Local_timer_interrupts
   1396394 ±  9%     +77.3%    2475349 ± 18%  interrupts.CPU18.RES:Rescheduling_interrupts
    584823 ± 14%    +196.2%    1732209 ± 70%  interrupts.CPU19.CAL:Function_call_interrupts
   2633760           -29.2%    1865138        interrupts.CPU19.LOC:Local_timer_interrupts
   1463821 ±  4%    +102.4%    2963448 ± 12%  interrupts.CPU19.RES:Rescheduling_interrupts
    537532 ± 14%    +659.5%    4082710 ± 49%  interrupts.CPU2.CAL:Function_call_interrupts
   2633695           -29.2%    1865040        interrupts.CPU2.LOC:Local_timer_interrupts
   1398069 ± 10%    +120.9%    3088668 ±  8%  interrupts.CPU2.RES:Rescheduling_interrupts
    577827 ± 16%    +165.3%    1533212 ± 72%  interrupts.CPU20.CAL:Function_call_interrupts
   2633830           -29.2%    1865061        interrupts.CPU20.LOC:Local_timer_interrupts
   1462963 ±  6%     +96.3%    2872097 ± 14%  interrupts.CPU20.RES:Rescheduling_interrupts
    568745 ± 17%    +156.5%    1458657 ± 63%  interrupts.CPU21.CAL:Function_call_interrupts
   2633790           -29.2%    1865125        interrupts.CPU21.LOC:Local_timer_interrupts
   1455888 ±  4%    +107.8%    3025217 ± 12%  interrupts.CPU21.RES:Rescheduling_interrupts
    569078 ± 17%    +242.1%    1946561 ± 90%  interrupts.CPU22.CAL:Function_call_interrupts
   2633826           -29.2%    1865145        interrupts.CPU22.LOC:Local_timer_interrupts
   1457448 ±  6%    +108.2%    3034926 ± 12%  interrupts.CPU22.RES:Rescheduling_interrupts
    566117 ± 15%    +194.9%    1669379 ± 84%  interrupts.CPU23.CAL:Function_call_interrupts
   2633849           -29.2%    1865132        interrupts.CPU23.LOC:Local_timer_interrupts
   1466517 ±  5%     +99.2%    2921450 ± 23%  interrupts.CPU23.RES:Rescheduling_interrupts
    567257 ± 17%    +236.8%    1910543 ± 94%  interrupts.CPU24.CAL:Function_call_interrupts
   2633857           -29.2%    1865114        interrupts.CPU24.LOC:Local_timer_interrupts
   1473726 ±  5%    +111.6%    3118669 ±  9%  interrupts.CPU24.RES:Rescheduling_interrupts
    571873 ± 17%    +207.7%    1759796 ± 81%  interrupts.CPU25.CAL:Function_call_interrupts
   2633844           -29.2%    1865127        interrupts.CPU25.LOC:Local_timer_interrupts
   1456649 ±  9%     +92.6%    2805286 ± 11%  interrupts.CPU25.RES:Rescheduling_interrupts
    578305 ± 18%    +185.9%    1653215 ± 76%  interrupts.CPU26.CAL:Function_call_interrupts
   2633838           -29.2%    1865119        interrupts.CPU26.LOC:Local_timer_interrupts
   1424045 ±  5%    +102.9%    2889535 ± 15%  interrupts.CPU26.RES:Rescheduling_interrupts
    562598 ± 17%    +236.8%    1894614 ± 83%  interrupts.CPU27.CAL:Function_call_interrupts
   2633855           -29.2%    1865066        interrupts.CPU27.LOC:Local_timer_interrupts
   1521521 ±  9%     +99.0%    3028018 ± 14%  interrupts.CPU27.RES:Rescheduling_interrupts
    573439 ± 17%    +169.9%    1547685 ± 77%  interrupts.CPU28.CAL:Function_call_interrupts
   2633841           -29.2%    1865133        interrupts.CPU28.LOC:Local_timer_interrupts
   1476417 ±  7%     +96.8%    2905945 ± 10%  interrupts.CPU28.RES:Rescheduling_interrupts
    569303 ± 16%    +219.8%    1820704 ± 74%  interrupts.CPU29.CAL:Function_call_interrupts
   2633840           -29.2%    1865144        interrupts.CPU29.LOC:Local_timer_interrupts
   1463402 ±  5%     +99.6%    2920924 ± 11%  interrupts.CPU29.RES:Rescheduling_interrupts
    540299 ± 13%    +572.8%    3635184 ± 46%  interrupts.CPU3.CAL:Function_call_interrupts
   2633834           -29.2%    1865068        interrupts.CPU3.LOC:Local_timer_interrupts
   1357363 ± 11%    +128.9%    3106456 ±  8%  interrupts.CPU3.RES:Rescheduling_interrupts
    566720 ± 17%    +249.9%    1983177 ± 90%  interrupts.CPU30.CAL:Function_call_interrupts
   2633849           -29.2%    1865111        interrupts.CPU30.LOC:Local_timer_interrupts
   1451386 ±  6%    +102.3%    2936684 ± 11%  interrupts.CPU30.RES:Rescheduling_interrupts
    572101 ± 17%    +207.0%    1756300 ± 81%  interrupts.CPU31.CAL:Function_call_interrupts
   2633872           -29.2%    1865173        interrupts.CPU31.LOC:Local_timer_interrupts
   1442117 ±  5%    +101.5%    2906320 ± 14%  interrupts.CPU31.RES:Rescheduling_interrupts
    566117 ± 16%    +221.8%    1821798 ± 79%  interrupts.CPU32.CAL:Function_call_interrupts
   2633836           -29.2%    1865082        interrupts.CPU32.LOC:Local_timer_interrupts
   1520018 ±  6%    +111.8%    3219552 ± 13%  interrupts.CPU32.RES:Rescheduling_interrupts
    572723 ± 17%    +219.3%    1828506 ± 87%  interrupts.CPU33.CAL:Function_call_interrupts
   2633890           -29.2%    1865098        interrupts.CPU33.LOC:Local_timer_interrupts
   1469532 ±  4%    +109.2%    3074482 ± 14%  interrupts.CPU33.RES:Rescheduling_interrupts
    562451 ± 16%    +198.3%    1677546 ± 86%  interrupts.CPU34.CAL:Function_call_interrupts
   2633860           -29.2%    1865114        interrupts.CPU34.LOC:Local_timer_interrupts
   1485260 ±  7%     +84.9%    2746634 ± 24%  interrupts.CPU34.RES:Rescheduling_interrupts
    574437 ± 17%    +192.2%    1678665 ± 84%  interrupts.CPU35.CAL:Function_call_interrupts
   2633873           -29.2%    1865198        interrupts.CPU35.LOC:Local_timer_interrupts
   1454846 ±  9%    +106.8%    3009342 ±  8%  interrupts.CPU35.RES:Rescheduling_interrupts
    603848 ± 16%   +1507.1%    9704505 ± 20%  interrupts.CPU36.CAL:Function_call_interrupts
   2633701           -29.2%    1864749        interrupts.CPU36.LOC:Local_timer_interrupts
   1484946 ±  9%     +72.6%    2562490 ±  7%  interrupts.CPU36.RES:Rescheduling_interrupts
    571784 ± 17%    +758.6%    4909125 ± 14%  interrupts.CPU37.CAL:Function_call_interrupts
   2633716           -29.2%    1865119        interrupts.CPU37.LOC:Local_timer_interrupts
   1483209 ± 10%    +150.6%    3716519 ± 14%  interrupts.CPU37.RES:Rescheduling_interrupts
    570497 ± 16%    +667.3%    4377236 ± 33%  interrupts.CPU38.CAL:Function_call_interrupts
   2633719           -29.2%    1865133        interrupts.CPU38.LOC:Local_timer_interrupts
   1511144 ± 11%    +125.5%    3408141 ±  9%  interrupts.CPU38.RES:Rescheduling_interrupts
    566973 ± 15%    +657.0%    4292058 ± 17%  interrupts.CPU39.CAL:Function_call_interrupts
   2633789           -29.2%    1865151        interrupts.CPU39.LOC:Local_timer_interrupts
   1495142 ± 11%    +134.1%    3499448 ±  6%  interrupts.CPU39.RES:Rescheduling_interrupts
    535647 ± 13%    +564.3%    3558480 ± 42%  interrupts.CPU4.CAL:Function_call_interrupts
   2633852           -29.2%    1865145        interrupts.CPU4.LOC:Local_timer_interrupts
   1390793 ± 14%    +145.7%    3416812 ±  4%  interrupts.CPU4.RES:Rescheduling_interrupts
    569331 ± 16%    +784.2%    5033925 ± 11%  interrupts.CPU40.CAL:Function_call_interrupts
   2633683           -29.2%    1865105        interrupts.CPU40.LOC:Local_timer_interrupts
   1444489 ± 13%    +128.6%    3302235 ±  7%  interrupts.CPU40.RES:Rescheduling_interrupts
    561437 ± 16%    +791.8%    5006730 ± 30%  interrupts.CPU41.CAL:Function_call_interrupts
   2633767           -29.2%    1865127        interrupts.CPU41.LOC:Local_timer_interrupts
   1482967 ± 12%    +140.4%    3565126 ±  3%  interrupts.CPU41.RES:Rescheduling_interrupts
    569466 ± 15%    +717.2%    4653562 ± 22%  interrupts.CPU42.CAL:Function_call_interrupts
   2633766           -29.2%    1865143        interrupts.CPU42.LOC:Local_timer_interrupts
   1557689 ± 10%    +133.7%    3640722 ± 10%  interrupts.CPU42.RES:Rescheduling_interrupts
    570194 ± 16%    +640.8%    4224074 ± 16%  interrupts.CPU43.CAL:Function_call_interrupts
   2633582           -29.2%    1865069        interrupts.CPU43.LOC:Local_timer_interrupts
   1427263 ± 10%    +139.6%    3420407 ± 12%  interrupts.CPU43.RES:Rescheduling_interrupts
    565434 ± 16%    +891.8%    5608254 ± 22%  interrupts.CPU44.CAL:Function_call_interrupts
   2633573           -29.2%    1865201        interrupts.CPU44.LOC:Local_timer_interrupts
   1481005 ± 14%    +117.4%    3219881 ±  4%  interrupts.CPU44.RES:Rescheduling_interrupts
    570693 ± 15%    +632.7%    4181757 ± 12%  interrupts.CPU45.CAL:Function_call_interrupts
   2633516           -29.2%    1865185        interrupts.CPU45.LOC:Local_timer_interrupts
   1497744 ± 15%    +137.6%    3557955 ±  2%  interrupts.CPU45.RES:Rescheduling_interrupts
    572207 ± 15%    +685.8%    4496592 ± 10%  interrupts.CPU46.CAL:Function_call_interrupts
   2633693           -29.2%    1865179        interrupts.CPU46.LOC:Local_timer_interrupts
   1533341 ± 13%    +128.5%    3503837 ±  6%  interrupts.CPU46.RES:Rescheduling_interrupts
    565721 ± 16%    +690.5%    4471782 ± 25%  interrupts.CPU47.CAL:Function_call_interrupts
   2633757           -29.2%    1865153        interrupts.CPU47.LOC:Local_timer_interrupts
   1490647 ± 10%    +150.6%    3735066 ± 16%  interrupts.CPU47.RES:Rescheduling_interrupts
    569497 ± 15%    +822.3%    5252711 ± 28%  interrupts.CPU48.CAL:Function_call_interrupts
   2633765           -29.2%    1865117        interrupts.CPU48.LOC:Local_timer_interrupts
   1520386 ± 10%    +140.1%    3650726 ±  9%  interrupts.CPU48.RES:Rescheduling_interrupts
    564031 ± 16%    +729.1%    4676576 ± 31%  interrupts.CPU49.CAL:Function_call_interrupts
   2633799           -29.2%    1865164        interrupts.CPU49.LOC:Local_timer_interrupts
   1490515 ±  8%    +134.5%    3495727 ±  5%  interrupts.CPU49.RES:Rescheduling_interrupts
    531201 ± 12%    +598.6%    3711227 ± 56%  interrupts.CPU5.CAL:Function_call_interrupts
   2633842           -29.2%    1865170        interrupts.CPU5.LOC:Local_timer_interrupts
   1343122 ± 15%    +145.9%    3303020 ± 11%  interrupts.CPU5.RES:Rescheduling_interrupts
    566959 ± 15%    +832.5%    5287164 ± 18%  interrupts.CPU50.CAL:Function_call_interrupts
   2633824           -29.2%    1865165        interrupts.CPU50.LOC:Local_timer_interrupts
   1503736 ± 11%    +141.6%    3632972 ±  7%  interrupts.CPU50.RES:Rescheduling_interrupts
    560012 ± 15%    +645.3%    4174036 ±  8%  interrupts.CPU51.CAL:Function_call_interrupts
   2633772           -29.2%    1865146        interrupts.CPU51.LOC:Local_timer_interrupts
   1504724 ± 13%    +149.6%    3756539 ±  5%  interrupts.CPU51.RES:Rescheduling_interrupts
    562790 ± 14%    +736.1%    4705640 ± 16%  interrupts.CPU52.CAL:Function_call_interrupts
   2633752           -29.2%    1865090        interrupts.CPU52.LOC:Local_timer_interrupts
   1491058 ±  8%    +150.3%    3732022 ± 10%  interrupts.CPU52.RES:Rescheduling_interrupts
    571396 ± 16%    +729.7%    4740766 ± 15%  interrupts.CPU53.CAL:Function_call_interrupts
   2633685           -29.2%    1865142        interrupts.CPU53.LOC:Local_timer_interrupts
   1468809 ± 13%    +128.9%    3361840 ±  7%  interrupts.CPU53.RES:Rescheduling_interrupts
    593346 ± 15%   +1289.7%    8245619 ± 11%  interrupts.CPU54.CAL:Function_call_interrupts
   2633797           -29.2%    1864977        interrupts.CPU54.LOC:Local_timer_interrupts
   1475562 ±  5%     +86.3%    2749109 ±  7%  interrupts.CPU54.RES:Rescheduling_interrupts
    564926 ± 16%    +813.2%    5158877 ± 21%  interrupts.CPU55.CAL:Function_call_interrupts
   2633823           -29.2%    1865088        interrupts.CPU55.LOC:Local_timer_interrupts
   1445269 ±  6%    +127.3%    3285587 ±  4%  interrupts.CPU55.RES:Rescheduling_interrupts
    563415 ± 17%    +679.2%    4390171 ± 13%  interrupts.CPU56.CAL:Function_call_interrupts
   2633811           -29.2%    1865068        interrupts.CPU56.LOC:Local_timer_interrupts
   1408960 ±  5%    +146.0%    3466532 ± 10%  interrupts.CPU56.RES:Rescheduling_interrupts
    563764 ± 15%    +742.7%    4750963 ± 26%  interrupts.CPU57.CAL:Function_call_interrupts
   2633736           -29.2%    1864961        interrupts.CPU57.LOC:Local_timer_interrupts
   1461158 ±  2%    +133.2%    3407830 ±  3%  interrupts.CPU57.RES:Rescheduling_interrupts
    553457 ± 16%    +810.1%    5037149 ± 22%  interrupts.CPU58.CAL:Function_call_interrupts
   2633812           -29.2%    1864999        interrupts.CPU58.LOC:Local_timer_interrupts
   1462890 ±  4%    +131.4%    3385299 ±  6%  interrupts.CPU58.RES:Rescheduling_interrupts
    554838 ± 15%    +771.7%    4836459 ± 19%  interrupts.CPU59.CAL:Function_call_interrupts
   2633675           -29.2%    1865147        interrupts.CPU59.LOC:Local_timer_interrupts
   1448096 ±  5%    +164.5%    3830835 ±  2%  interrupts.CPU59.RES:Rescheduling_interrupts
    536623 ± 13%    +634.3%    3940672 ± 49%  interrupts.CPU6.CAL:Function_call_interrupts
   2633823           -29.2%    1865043        interrupts.CPU6.LOC:Local_timer_interrupts
   1466299 ± 14%    +139.6%    3513370 ±  8%  interrupts.CPU6.RES:Rescheduling_interrupts
    557353 ± 16%    +906.0%    5607132 ± 18%  interrupts.CPU60.CAL:Function_call_interrupts
   2633707           -29.2%    1864994        interrupts.CPU60.LOC:Local_timer_interrupts
   1485961 ±  4%    +111.3%    3140077 ±  5%  interrupts.CPU60.RES:Rescheduling_interrupts
    555243 ± 16%    +768.6%    4822767 ± 32%  interrupts.CPU61.CAL:Function_call_interrupts
   2633799           -29.2%    1865079        interrupts.CPU61.LOC:Local_timer_interrupts
   1437825 ±  4%    +132.8%    3347200 ±  7%  interrupts.CPU61.RES:Rescheduling_interrupts
    551697 ± 16%    +727.8%    4566738 ± 20%  interrupts.CPU62.CAL:Function_call_interrupts
   2633795           -29.2%    1864957        interrupts.CPU62.LOC:Local_timer_interrupts
   1478294 ±  3%    +133.8%    3456670 ±  5%  interrupts.CPU62.RES:Rescheduling_interrupts
    552353 ± 17%    +709.9%    4473328 ± 22%  interrupts.CPU63.CAL:Function_call_interrupts
   2633799           -29.2%    1865043        interrupts.CPU63.LOC:Local_timer_interrupts
   1465237 ±  7%    +154.1%    3723197 ± 13%  interrupts.CPU63.RES:Rescheduling_interrupts
    558022 ± 15%    +689.9%    4407595 ± 26%  interrupts.CPU64.CAL:Function_call_interrupts
   2633709           -29.2%    1865086        interrupts.CPU64.LOC:Local_timer_interrupts
   1448988 ±  6%    +147.4%    3585414 ±  7%  interrupts.CPU64.RES:Rescheduling_interrupts
    553929 ± 16%    +761.2%    4770656 ± 20%  interrupts.CPU65.CAL:Function_call_interrupts
   2633780           -29.2%    1865052        interrupts.CPU65.LOC:Local_timer_interrupts
   1477139 ±  3%    +149.0%    3677909 ±  5%  interrupts.CPU65.RES:Rescheduling_interrupts
    552322 ± 17%    +838.0%    5180852 ± 18%  interrupts.CPU66.CAL:Function_call_interrupts
   2633753           -29.2%    1864927        interrupts.CPU66.LOC:Local_timer_interrupts
   1435174 ±  2%    +159.6%    3725669 ±  6%  interrupts.CPU66.RES:Rescheduling_interrupts
    553190 ± 16%    +768.5%    4804519 ± 13%  interrupts.CPU67.CAL:Function_call_interrupts
   2633697           -29.2%    1865007        interrupts.CPU67.LOC:Local_timer_interrupts
   1453325 ±  3%    +136.5%    3437075 ± 14%  interrupts.CPU67.RES:Rescheduling_interrupts
    552397 ± 16%    +764.3%    4774301 ± 26%  interrupts.CPU68.CAL:Function_call_interrupts
   2633789           -29.2%    1864964        interrupts.CPU68.LOC:Local_timer_interrupts
   1558186 ±  4%    +118.4%    3403031 ± 11%  interrupts.CPU68.RES:Rescheduling_interrupts
    554418 ± 16%    +961.7%    5886167 ±  8%  interrupts.CPU69.CAL:Function_call_interrupts
   2633764           -29.2%    1865051        interrupts.CPU69.LOC:Local_timer_interrupts
   1423294 ±  3%    +138.4%    3393400 ±  6%  interrupts.CPU69.RES:Rescheduling_interrupts
    541109 ± 11%    +668.2%    4156638 ± 44%  interrupts.CPU7.CAL:Function_call_interrupts
   2633836           -29.2%    1865155        interrupts.CPU7.LOC:Local_timer_interrupts
   1412135 ± 12%    +155.1%    3601951 ± 11%  interrupts.CPU7.RES:Rescheduling_interrupts
    550414 ± 16%    +834.5%    5143694 ± 13%  interrupts.CPU70.CAL:Function_call_interrupts
   2633653           -29.2%    1865092        interrupts.CPU70.LOC:Local_timer_interrupts
   1384755 ±  6%    +138.9%    3308775 ±  2%  interrupts.CPU70.RES:Rescheduling_interrupts
    559074 ± 16%    +653.3%    4211561 ± 13%  interrupts.CPU71.CAL:Function_call_interrupts
   2633748           -29.2%    1865021        interrupts.CPU71.LOC:Local_timer_interrupts
   1472210 ±  3%    +124.4%    3303060 ±  9%  interrupts.CPU71.RES:Rescheduling_interrupts
    542050 ± 11%   +1099.4%    6501414 ± 55%  interrupts.CPU72.CAL:Function_call_interrupts
   2633763           -29.2%    1865050        interrupts.CPU72.LOC:Local_timer_interrupts
   1367191 ± 16%     +80.6%    2469066 ±  9%  interrupts.CPU72.RES:Rescheduling_interrupts
    543872 ± 12%    +576.7%    3680170 ± 50%  interrupts.CPU73.CAL:Function_call_interrupts
   2633769           -29.2%    1865189        interrupts.CPU73.LOC:Local_timer_interrupts
   1409409 ± 12%    +150.9%    3536397 ± 10%  interrupts.CPU73.RES:Rescheduling_interrupts
    542479 ± 12%    +694.7%    4310839 ± 49%  interrupts.CPU74.CAL:Function_call_interrupts
   2633797           -29.2%    1865184        interrupts.CPU74.LOC:Local_timer_interrupts
   1345440 ±  8%    +148.6%    3345236 ± 13%  interrupts.CPU74.RES:Rescheduling_interrupts
    540242 ± 13%    +495.0%    3214652 ± 37%  interrupts.CPU75.CAL:Function_call_interrupts
   2633779           -29.2%    1865130        interrupts.CPU75.LOC:Local_timer_interrupts
   1341464 ± 11%    +177.8%    3726421 ± 18%  interrupts.CPU75.RES:Rescheduling_interrupts
    541422 ± 12%    +607.3%    3829357 ± 39%  interrupts.CPU76.CAL:Function_call_interrupts
   2633800           -29.2%    1865089        interrupts.CPU76.LOC:Local_timer_interrupts
   1366092 ± 12%    +155.4%    3489422 ± 19%  interrupts.CPU76.RES:Rescheduling_interrupts
    536776 ± 13%    +740.7%    4512417 ± 65%  interrupts.CPU77.CAL:Function_call_interrupts
   2633767           -29.2%    1865051        interrupts.CPU77.LOC:Local_timer_interrupts
   1368135 ± 11%    +150.2%    3423438 ± 11%  interrupts.CPU77.RES:Rescheduling_interrupts
    542490 ± 13%    +543.1%    3489024 ± 46%  interrupts.CPU78.CAL:Function_call_interrupts
   2633796           -29.2%    1865113        interrupts.CPU78.LOC:Local_timer_interrupts
   1398379 ± 15%    +158.6%    3615932 ± 13%  interrupts.CPU78.RES:Rescheduling_interrupts
    541330 ± 12%    +613.6%    3863188 ± 49%  interrupts.CPU79.CAL:Function_call_interrupts
   2633706           -29.2%    1865314        interrupts.CPU79.LOC:Local_timer_interrupts
   1345617 ± 11%    +166.4%    3584373 ± 16%  interrupts.CPU79.RES:Rescheduling_interrupts
    544923 ± 12%    +637.9%    4020972 ± 45%  interrupts.CPU8.CAL:Function_call_interrupts
   2633804           -29.2%    1865185        interrupts.CPU8.LOC:Local_timer_interrupts
   1458600 ± 12%    +144.6%    3567390 ± 10%  interrupts.CPU8.RES:Rescheduling_interrupts
    545648 ± 11%    +674.3%    4224816 ± 47%  interrupts.CPU80.CAL:Function_call_interrupts
   2633766           -29.2%    1864933        interrupts.CPU80.LOC:Local_timer_interrupts
   1378101 ± 12%    +169.8%    3718119 ±  6%  interrupts.CPU80.RES:Rescheduling_interrupts
    535168 ± 13%    +665.4%    4096010 ± 49%  interrupts.CPU81.CAL:Function_call_interrupts
   2633793           -29.2%    1865047        interrupts.CPU81.LOC:Local_timer_interrupts
   1368252 ± 13%    +163.1%    3599458 ± 10%  interrupts.CPU81.RES:Rescheduling_interrupts
    540163 ± 12%    +653.4%    4069365 ± 52%  interrupts.CPU82.CAL:Function_call_interrupts
   2633657           -29.2%    1865212        interrupts.CPU82.LOC:Local_timer_interrupts
   1401643 ± 13%    +176.1%    3869805 ± 11%  interrupts.CPU82.RES:Rescheduling_interrupts
    534505 ± 12%    +630.2%    3902850 ± 54%  interrupts.CPU83.CAL:Function_call_interrupts
   2633823           -29.2%    1865163        interrupts.CPU83.LOC:Local_timer_interrupts
   1384886 ± 14%    +167.7%    3707213 ± 17%  interrupts.CPU83.RES:Rescheduling_interrupts
    537983 ± 13%    +532.0%    3399977 ± 54%  interrupts.CPU84.CAL:Function_call_interrupts
   2633802           -29.2%    1865219        interrupts.CPU84.LOC:Local_timer_interrupts
   1396334 ± 15%    +167.1%    3729434 ± 25%  interrupts.CPU84.RES:Rescheduling_interrupts
    539715 ± 12%    +735.9%    4511522 ± 45%  interrupts.CPU85.CAL:Function_call_interrupts
   2633658           -29.2%    1865196        interrupts.CPU85.LOC:Local_timer_interrupts
   1351518 ± 12%    +152.8%    3416707 ±  8%  interrupts.CPU85.RES:Rescheduling_interrupts
    543234 ± 13%    +591.1%    3754561 ± 44%  interrupts.CPU86.CAL:Function_call_interrupts
   2633610           -29.2%    1865113        interrupts.CPU86.LOC:Local_timer_interrupts
   1362882 ± 15%    +170.3%    3684510 ± 13%  interrupts.CPU86.RES:Rescheduling_interrupts
    542751 ± 12%    +543.7%    3493567 ± 46%  interrupts.CPU87.CAL:Function_call_interrupts
   2633778           -29.2%    1865136        interrupts.CPU87.LOC:Local_timer_interrupts
   1363815 ± 13%    +157.8%    3515677 ± 21%  interrupts.CPU87.RES:Rescheduling_interrupts
    540758 ± 12%    +692.6%    4286070 ± 47%  interrupts.CPU88.CAL:Function_call_interrupts
   2633713           -29.2%    1865126        interrupts.CPU88.LOC:Local_timer_interrupts
   1386349 ± 15%    +154.7%    3531157 ± 18%  interrupts.CPU88.RES:Rescheduling_interrupts
    543290 ± 12%    +627.0%    3949703 ± 50%  interrupts.CPU89.CAL:Function_call_interrupts
   2633805           -29.2%    1864993        interrupts.CPU89.LOC:Local_timer_interrupts
   1391863 ± 16%    +161.4%    3638348 ±  9%  interrupts.CPU89.RES:Rescheduling_interrupts
    535660 ± 12%    +693.4%    4250141 ± 51%  interrupts.CPU9.CAL:Function_call_interrupts
   2633794           -29.2%    1865192        interrupts.CPU9.LOC:Local_timer_interrupts
   1430205 ± 18%    +138.5%    3411425 ± 13%  interrupts.CPU9.RES:Rescheduling_interrupts
    592065 ± 17%    +315.3%    2458617 ±103%  interrupts.CPU90.CAL:Function_call_interrupts
   2633796           -29.2%    1865066        interrupts.CPU90.LOC:Local_timer_interrupts
   1374748 ± 10%    +101.9%    2775876 ±  9%  interrupts.CPU90.RES:Rescheduling_interrupts
    583740 ± 15%    +195.1%    1722772 ± 71%  interrupts.CPU91.CAL:Function_call_interrupts
   2633827           -29.2%    1865115        interrupts.CPU91.LOC:Local_timer_interrupts
   1423080 ±  7%    +111.0%    3002050 ±  8%  interrupts.CPU91.RES:Rescheduling_interrupts
    578602 ± 17%    +178.2%    1609750 ± 63%  interrupts.CPU92.CAL:Function_call_interrupts
   2633804           -29.2%    1865110        interrupts.CPU92.LOC:Local_timer_interrupts
   1551851 ±  6%    +100.2%    3106189 ± 21%  interrupts.CPU92.RES:Rescheduling_interrupts
    577351 ± 17%    +190.8%    1678753 ± 53%  interrupts.CPU93.CAL:Function_call_interrupts
   2633846           -29.2%    1864789        interrupts.CPU93.LOC:Local_timer_interrupts
   1423206 ±  8%    +123.2%    3175923 ± 15%  interrupts.CPU93.RES:Rescheduling_interrupts
    570143 ± 17%    +244.0%    1961550 ± 91%  interrupts.CPU94.CAL:Function_call_interrupts
   2633853           -29.2%    1865127        interrupts.CPU94.LOC:Local_timer_interrupts
   1429404 ±  2%    +111.9%    3028819 ± 19%  interrupts.CPU94.RES:Rescheduling_interrupts
    572010 ± 15%    +212.9%    1789889 ± 88%  interrupts.CPU95.CAL:Function_call_interrupts
   2633753           -29.2%    1865079        interrupts.CPU95.LOC:Local_timer_interrupts
   1509973 ±  7%     +97.0%    2974377 ± 10%  interrupts.CPU95.RES:Rescheduling_interrupts
    574571 ± 17%    +244.6%    1979836 ± 96%  interrupts.CPU96.CAL:Function_call_interrupts
   2633812           -29.2%    1864939        interrupts.CPU96.LOC:Local_timer_interrupts
   1439328 ±  7%     +73.1%    2490884 ± 15%  interrupts.CPU96.RES:Rescheduling_interrupts
    575903 ± 15%    +211.7%    1794999 ± 62%  interrupts.CPU97.CAL:Function_call_interrupts
   2633783           -29.2%    1865089        interrupts.CPU97.LOC:Local_timer_interrupts
   1435933 ±  9%     +97.1%    2830079 ± 18%  interrupts.CPU97.RES:Rescheduling_interrupts
    576264 ± 16%    +242.8%    1975455 ± 67%  interrupts.CPU98.CAL:Function_call_interrupts
   2633879           -29.2%    1865106        interrupts.CPU98.LOC:Local_timer_interrupts
   1424628 ±  8%    +113.2%    3037568 ± 14%  interrupts.CPU98.RES:Rescheduling_interrupts
    566075 ± 17%    +271.2%    2101485 ± 88%  interrupts.CPU99.CAL:Function_call_interrupts
   2633879           -29.2%    1865196        interrupts.CPU99.LOC:Local_timer_interrupts
   1420395 ±  7%    +124.9%    3195087 ± 12%  interrupts.CPU99.RES:Rescheduling_interrupts
 3.793e+08           -29.2%  2.686e+08        interrupts.LOC:Local_timer_interrupts
    576.00           -43.8%     324.00 ± 19%  interrupts.MCP:Machine_check_polls
 2.074e+08 ±  6%    +138.3%  4.943e+08        interrupts.RES:Rescheduling_interrupts


                                                                                
                                hackbench.throughput                            
                                                                                
  85000 +-------------------------------------------------------------------+   
        |               O                                                   |   
  80000 |-+                                                                 |   
  75000 |-+O                         O O  O  O    O    O    O               |   
        |       O O  O    O  O  O O            O    O     O                 |   
  70000 |-+  O                                                              |   
        |                                                                   |   
  65000 |-+                                                                 |   
        |                                                                   |   
  60000 |-+                                                                 |   
  55000 |-+                                                                 |   
        |.. .+..            .+..            .+.  .+.     .+.          .+.   |   
  50000 |-++    +.+..+..+.+.    +.+..+.+..+.   +.   +..+.   +..+..+.+.   +..|   
        |                                                                   |   
  45000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  20 +----------------------------------------------------------------------+   
  18 |-+                                                            +       |   
     |                                                             : :      |   
  16 |-+                                                           : :      |   
  14 |..        +..           +                   .+              :   :     |   
     |  +.+..  +       .+.. .. :           +..   +  :       +    +    :     |   
  12 |-+      +    +.+.    +   :   +..+.. +    ..   :     .. + ..      +.+..|   
  10 |-+     +                  :..      +    +      :   +    +             |   
   8 |-+                        +                    : ..                   |   
     |                                                +                     |   
   6 |-+                                                                    |   
   4 |-+                                                                    |   
     |                                                                      |   
   2 |-+  O     O  O O  O          O     O       O                          |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  45 +----------------------------------------------------------------------+   
     |          +             +                                     +       |   
  40 |-+       : :           +:                   .+               + +      |   
  35 |..+.     :  :     +.. +  :           +     +  :       +.    +   +     |   
     |    +.. :   :   ..   +   :           ::   :   :      +  +..+     +.+..|   
  30 |-+      :    +.+          : .+..    :  :  :    :    +                 |   
  25 |-+     +                  +.    +.. :  : :     :  .+                  |   
     |                                   +    +       +.                    |   
  20 |-+                                                                    |   
  15 |-+                                                                    |   
     |                                                                      |   
  10 |-+                                                                    |   
   5 |-+                                                                    |   
     |          O  O O  O                     O  O                          |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  60000 +-------------------------------------------------------------------+   
        |                 +..+       +                 +                    |   
  55000 |-+  +    +       :   :     ::                 ::                   |   
  50000 |-+  ::   ::     :    :     : :               : :                   |   
        |   : :  : :     :     :   :  :               :  :                  |   
  45000 |-+ :  : :  :    :     :   :  :              :   :                  |   
  40000 |..:   ::   :   :       :.+    : .+.. .+..   :    :.+..             |   
        |  +    +    +..+       +      +.    +    +.+     +    +..+.+..+.+..|   
  35000 |-+                                                                 |   
  30000 |-+                                                                 |   
        |                                                                   |   
  25000 |-+O O    O       O  O       O    O            O                    |   
  20000 |-+     O    O            O    O     O O  O O     O                 |   
        |               O       O                           O               |   
  15000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  45000 +-------------------------------------------------------------------+   
        |                           ::                 +                    |   
  40000 |-+  +               +      : :               : :                   |   
  35000 |-+ : +            .. :    :  :               :  :             +    |   
        |.. :  +    .+..+.+    :   :   :             :   :     +     .. +   |   
  30000 |-++    +.+.           : .+    +..         .+     +. .. +   +    +..|   
  25000 |-+                     +         +..+.+..+         +    + +        |   
        |                                                         +         |   
  20000 |-+                                                                 |   
  15000 |-+                                                                 |   
        |                                                                   |   
  10000 |-+                                                                 |   
   5000 |-+                                                                 |   
        |                                                                   |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             hackbench.time.user_time                           
                                                                                
  3200 +--------------------------------------------------------------------+   
       |                                                                    |   
  3000 |-+  O     O         O                               O               |   
  2800 |-+O                    O  O    O    O  O    O  O O                  |   
       |            O  O  O         O     O      O                          |   
  2600 |-+                                                                  |   
       |                                                                    |   
  2400 |-+                                                                  |   
       |                                                                    |   
  2200 |-+    .+..+       +                                                 |   
  2000 |-+ .+.     +     + +  .+..+.+..+..+.  .+.                           |   
       |..+         +.. +   +.              +.   +..+..         .+..        |   
  1800 |-+             +                               +.+..+..+    +.. .+..|   
       |                                                               +    |   
  1600 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             hackbench.time.system_time                         
                                                                                
  200000 +------------------------------------------------------------------+   
         |                                                                  |   
  190000 |-+    .+.+..+.  .+..    .+.     .+.  .+.    .+..                 .|   
  180000 |..+.+.        +.    +.+.   +..+.   +.   +..+    +..+.+..+.+..+.+. |   
         |                                                                  |   
  170000 |-+                                                                |   
         |                                                                  |   
  160000 |-+                                                                |   
         |                                                                  |   
  150000 |-+                                                                |   
  140000 |-+                                                                |   
         |                                                                  |   
  130000 |-+  O  O O       O  O O  O            O    O                      |   
         |  O         O              O  O  O O    O    O  O  O              |   
  120000 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            hackbench.time.elapsed_time                         
                                                                                
  1400 +--------------------------------------------------------------------+   
  1350 |-+       .+.                                                       .|   
       | .+.  .+.   +..+..+.  .+..+.  .+..+.  .+.  .+..+.  .+..+.+..+.. .+. |   
  1300 |.+  +.              +.      +.      +.   +.      +.            +    |   
  1250 |-+                                                                  |   
  1200 |-+                                                                  |   
  1150 |-+                                                                  |   
       |                                                                    |   
  1100 |-+                                                                  |   
  1050 |-+                                                                  |   
  1000 |-+                                                                  |   
   950 |-+  O  O  O         O  O  O            O    O                       |   
       |  O         O     O         O     O      O     O O  O               |   
   900 |-+             O               O    O                               |   
   850 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                          hackbench.time.elapsed_time.max                       
                                                                                
  1400 +--------------------------------------------------------------------+   
  1350 |-+       .+.                                                       .|   
       | .+.  .+.   +..+..+.  .+..+.  .+..+.  .+.  .+..+.  .+..+.+..+.. .+. |   
  1300 |.+  +.              +.      +.      +.   +.      +.            +    |   
  1250 |-+                                                                  |   
  1200 |-+                                                                  |   
  1150 |-+                                                                  |   
       |                                                                    |   
  1100 |-+                                                                  |   
  1050 |-+                                                                  |   
  1000 |-+                                                                  |   
   950 |-+  O  O  O         O  O  O            O    O                       |   
       |  O         O     O         O     O      O     O O  O               |   
   900 |-+             O               O    O                               |   
   850 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       hackbench.time.voluntary_context_switches                
                                                                                
    6e+09 +-----------------------------------------------------------------+   
  5.5e+09 |-+       O    O       O O    O     O      O  O O  O              |   
          |  O O  O    O    O         O    O    O  O                        |   
    5e+09 |-+                                                               |   
  4.5e+09 |-+                                                               |   
          |                                                                 |   
    4e+09 |-+                                                               |   
  3.5e+09 |-+                                                               |   
    3e+09 |-+                                                               |   
          |                                                                 |   
  2.5e+09 |-+                                                               |   
    2e+09 |-+                                                               |   
          |                                                                 |   
  1.5e+09 |-+ .+..+.+..+.+..+.+..+.+..+.+..+..+.+..+.+..+.    .+..+.+.. .+..|   
    1e+09 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      hackbench.time.involuntary_context_switches               
                                                                                
  4.5e+09 +-----------------------------------------------------------------+   
          |              O    O    O                                        |   
    4e+09 |-+     O O  O         O      O     O      O  O O  O              |   
  3.5e+09 |-+O O            O         O    O    O  O                        |   
          |                                                                 |   
    3e+09 |-+                                                               |   
  2.5e+09 |-+                                                               |   
          |                                                                 |   
    2e+09 |-+                                                               |   
  1.5e+09 |-+                                                               |   
          |                                                                 |   
    1e+09 |-+                                                               |   
    5e+08 |..+.+..+.+..+.+..+.+..+.+..+.+..+..+.+..+.+..+.+..+.+..+.+..+.+..|   
          |                                                                 |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2sp5: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode:
  memory/gcc-9/performance/1HDD/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp5/stress-ng/10s/0x5003003

commit: 
  d3921cb8be ("mm: fix initialization of struct page for holes in memory layout")
  3de7d4f25a ("mm: memcg/slab: optimize objcg stock draining")

d3921cb8be29ce56 3de7d4f25a7438f09fef4e71ef1 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4            1%           1:4     perf-profile.children.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
    415967           +14.8%     477538        stress-ng.bad-altstack.ops
     41593           +14.8%      47751        stress-ng.bad-altstack.ops_per_sec
      1647            -2.3%       1609        boot-time.idle
      0.61 ±  2%      -0.2        0.45 ±  3%  mpstat.cpu.all.soft%
     73.25 ± 35%     -40.3%      43.75 ± 34%  numa-numastat.node0.interleave_hit
  25486494            +3.8%   26458177        proc-vmstat.pgactivate
     19886 ± 24%     +89.8%      37737 ± 26%  sched_debug.cpu.curr->pid.min
     32.22 ±  3%      -3.4%      31.13        perf-stat.i.MPKI
    208532            -8.0%     191893 ±  2%  perf-stat.i.cycles-between-cache-misses
     12514 ±  8%     -14.5%      10704 ±  6%  numa-meminfo.node0.KernelStack
     20560 ± 29%     -37.4%      12871 ± 17%  numa-meminfo.node0.PageTables
    654926 ±  5%     +11.3%     728915 ±  3%  numa-meminfo.node1.AnonHugePages
    723641 ±  8%     +16.8%     845066 ±  3%  numa-meminfo.node1.AnonPages
    745431 ±  7%     +15.6%     861404 ±  3%  numa-meminfo.node1.Inactive
    745431 ±  7%     +15.6%     861404 ±  3%  numa-meminfo.node1.Inactive(anon)
     10918 ±  7%     +15.1%      12569 ±  8%  numa-meminfo.node1.KernelStack
    120703 ±  3%      +9.4%     132082 ±  4%  slabinfo.kmalloc-32.active_objs
    944.25 ±  3%      +9.5%       1034 ±  4%  slabinfo.kmalloc-32.active_slabs
    120960 ±  3%      +9.5%     132447 ±  4%  slabinfo.kmalloc-32.num_objs
    944.25 ±  3%      +9.5%       1034 ±  4%  slabinfo.kmalloc-32.num_slabs
    166919 ±  4%     +13.1%     188713 ±  4%  slabinfo.kmalloc-8.active_objs
    167749 ±  3%     +13.4%     190188 ±  4%  slabinfo.kmalloc-8.num_objs
     48373 ±  4%      -7.1%      44932        slabinfo.lsm_file_cache.active_objs
     48373 ±  4%      -7.1%      44932        slabinfo.lsm_file_cache.num_objs
    206078 ±  6%     -15.2%     174793 ±  5%  numa-vmstat.node0.nr_anon_pages
    209130 ±  6%     -14.5%     178872 ±  5%  numa-vmstat.node0.nr_inactive_anon
    666.50 ±  5%     +15.3%     768.25 ± 11%  numa-vmstat.node0.nr_isolated_anon
     12516 ±  7%     -14.6%      10689 ±  6%  numa-vmstat.node0.nr_kernel_stack
      5136 ± 27%     -37.5%       3211 ± 17%  numa-vmstat.node0.nr_page_table_pages
    209124 ±  6%     -14.5%     178873 ±  5%  numa-vmstat.node0.nr_zone_inactive_anon
    186466 ±  7%     +13.4%     211536 ±  4%  numa-vmstat.node1.nr_anon_pages
    330.00 ±  6%      +8.5%     358.00 ±  3%  numa-vmstat.node1.nr_anon_transparent_hugepages
    191216 ±  6%     +12.7%     215422 ±  3%  numa-vmstat.node1.nr_inactive_anon
    191212 ±  6%     +12.7%     215425 ±  3%  numa-vmstat.node1.nr_zone_inactive_anon
      1.24 ±160%     -99.0%       0.01 ± 56%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.61 ±173%    +409.2%       3.11 ± 18%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.02 ± 15%     +30.2%       0.02 ± 19%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.04 ± 50%     -53.5%       0.02 ±  2%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      9.12 ± 64%     -94.1%       0.54 ± 80%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1.08 ±173%    +611.4%       7.68 ± 19%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     61.86 ±  5%     +16.4%      72.02 ±  7%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    475.75 ± 45%     -47.5%     250.00 ± 52%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
     61.77 ±  5%     +16.6%      72.01 ±  7%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.05 ± 12%     +26.2%       0.06 ± 10%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_irq_work.[unknown]
      0.03 ± 62%     -46.3%       0.02 ±108%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.12 ± 40%    +379.0%       0.55 ± 62%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_irq_work.[unknown]
      0.03 ± 62%     -46.3%       0.02 ±108%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
    103405 ± 25%     -19.2%      83544 ±  2%  interrupts.CPU1.CAL:Function_call_interrupts
      1027 ± 26%     -28.8%     731.50 ± 33%  interrupts.CPU21.TLB:TLB_shootdowns
    918.75 ± 32%     +49.1%       1370 ± 18%  interrupts.CPU24.TLB:TLB_shootdowns
      9601 ±  2%     -15.1%       8152 ±  9%  interrupts.CPU26.RES:Rescheduling_interrupts
    136411 ± 51%     -38.2%      84339 ±  4%  interrupts.CPU27.CAL:Function_call_interrupts
     92692 ±  3%      -9.2%      84205 ±  4%  interrupts.CPU30.CAL:Function_call_interrupts
      1291 ± 33%     -43.6%     727.75 ± 37%  interrupts.CPU31.TLB:TLB_shootdowns
     96125 ± 12%     -13.6%      83073        interrupts.CPU35.CAL:Function_call_interrupts
    101106 ± 17%     -15.5%      85423 ±  2%  interrupts.CPU47.CAL:Function_call_interrupts
     11054 ± 20%     -30.0%       7735 ± 17%  interrupts.CPU47.RES:Rescheduling_interrupts
     87756 ± 10%     +27.4%     111827 ± 24%  interrupts.CPU48.CAL:Function_call_interrupts
     10119 ±  6%     -17.0%       8402 ± 12%  interrupts.CPU50.RES:Rescheduling_interrupts
     86234 ±  7%     +39.2%     120069 ± 30%  interrupts.CPU66.CAL:Function_call_interrupts
    104978           -12.7%      91675 ±  3%  interrupts.CPU73.CAL:Function_call_interrupts
      9451 ±  5%     -16.4%       7904 ± 10%  interrupts.CPU75.RES:Rescheduling_interrupts
      4681 ± 35%     +42.0%       6646 ± 24%  interrupts.CPU82.NMI:Non-maskable_interrupts
      4681 ± 35%     +42.0%       6646 ± 24%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
    141092 ± 53%     -35.1%      91507        interrupts.CPU83.CAL:Function_call_interrupts
    932.25 ± 32%     -27.4%     676.75 ± 41%  interrupts.CPU85.TLB:TLB_shootdowns
    111069 ± 13%     -13.3%      96344 ±  7%  interrupts.CPU92.CAL:Function_call_interrupts
    110115 ± 12%     -15.7%      92791 ±  2%  interrupts.CPU93.CAL:Function_call_interrupts
      3.62            -1.2        2.40 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_free.remove_vma.exit_mmap.mmput.do_exit
      4.09            -1.2        2.88 ±  3%  perf-profile.calltrace.cycles-pp.remove_vma.exit_mmap.mmput.do_exit.do_group_exit
      3.62 ±  2%      -1.0        2.63 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_free.unlink_anon_vmas.free_pgtables.exit_mmap.mmput
      1.67            -0.9        0.75 ±  3%  perf-profile.calltrace.cycles-pp.refill_obj_stock.kmem_cache_free.remove_vma.exit_mmap.mmput
      3.79 ±  2%      -0.9        2.88 ±  5%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm.copy_process
      4.29 ±  2%      -0.8        3.47 ±  4%  perf-profile.calltrace.cycles-pp.vm_area_dup.dup_mmap.dup_mm.copy_process.kernel_clone
      2.69 ±  2%      -0.8        1.92 ±  6%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      2.45 ±  2%      -0.6        1.85 ±  5%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm.copy_process
      2.25 ± 10%      -0.4        1.81 ±  8%  perf-profile.calltrace.cycles-pp.ret_from_fork
      1.67 ±  3%      -0.4        1.26 ±  7%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
      1.33 ±  3%      -0.4        0.94 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_free.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      1.29 ±  3%      -0.4        0.92 ±  7%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc.anon_vma_clone.anon_vma_fork.dup_mmap
      1.03 ± 12%      -0.2        0.78 ± 10%  perf-profile.calltrace.cycles-pp.__memcg_kmem_charge.__memcg_kmem_charge_page.__alloc_pages_nodemask.pte_alloc_one.__pte_alloc
      1.10 ± 11%      -0.2        0.86 ±  9%  perf-profile.calltrace.cycles-pp.__memcg_kmem_charge_page.__alloc_pages_nodemask.pte_alloc_one.__pte_alloc.copy_pte_range
      0.90 ± 13%      -0.2        0.67 ± 11%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.__memcg_kmem_charge.__memcg_kmem_charge_page.__alloc_pages_nodemask.pte_alloc_one
      0.88 ±  4%      -0.2        0.66 ±  5%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
      1.27 ±  2%      -0.1        1.16 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_down_write_slowpath.anon_vma_clone.anon_vma_fork.dup_mmap
      1.18 ±  2%      -0.1        1.06 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      1.73 ±  3%      -0.1        1.62 ±  3%  perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.75 ±  3%      -0.1        1.64 ±  3%  perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.75 ±  3%      -0.1        1.65 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.68            +0.0        0.70 ±  2%  perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.52 ±  2%      +0.1        0.60 ±  5%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.tlb_flush_mmu.tlb_finish_mmu.exit_mmap.mmput
      0.61 ±  6%      +0.1        0.70 ±  3%  perf-profile.calltrace.cycles-pp.alloc_set_pte.filemap_map_pages.do_fault.__handle_mm_fault.handle_mm_fault
      0.60 ±  3%      +0.1        0.70 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_remove.unlink_anon_vmas.free_pgtables.exit_mmap.mmput
      0.63 ±  2%      +0.1        0.74        perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.98            +0.3        2.32 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      2.25            +0.4        2.60 ±  3%  perf-profile.calltrace.cycles-pp.release_pages.tlb_flush_mmu.tlb_finish_mmu.exit_mmap.mmput
      8.22            +0.4        8.66 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.anon_vma_fork.dup_mmap.dup_mm.copy_process
      2.80            +0.4        3.24 ±  3%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.mmput.do_exit.do_group_exit
      6.52 ±  2%      +0.4        6.96 ±  3%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.anon_vma_fork.dup_mmap.dup_mm
      2.79            +0.4        3.23 ±  3%  perf-profile.calltrace.cycles-pp.tlb_flush_mmu.tlb_finish_mmu.exit_mmap.mmput.do_exit
      7.79 ±  2%      +0.5        8.25 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap.mmput
      0.12 ±173%      +0.5        0.58        perf-profile.calltrace.cycles-pp.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64
      6.35 ±  3%      +0.5        6.89 ±  3%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
     10.69            +0.7       11.38        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     10.55            +0.7       11.25        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     10.55            +0.7       11.25        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     10.55            +0.7       11.25        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      9.32            +0.9       10.26        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      9.66            +1.0       10.66        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      9.66            +1.0       10.68        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     11.08            -3.3        7.78 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      4.26            -3.2        1.10 ±  2%  perf-profile.children.cycles-pp.page_counter_uncharge
      4.06            -3.0        1.09 ±  2%  perf-profile.children.cycles-pp.page_counter_cancel
      4.87            -2.5        2.34        perf-profile.children.cycles-pp.refill_obj_stock
     10.21            -2.5        7.69 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc
      3.82            -2.5        1.36        perf-profile.children.cycles-pp.drain_obj_stock
      2.42 ±  2%      -1.5        0.89 ±  3%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge
      4.11            -1.2        2.90 ±  3%  perf-profile.children.cycles-pp.remove_vma
      4.33 ±  3%      -1.1        3.26 ±  6%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      1.50 ±  6%      -1.0        0.54 ± 11%  perf-profile.children.cycles-pp.propagate_protected_usage
      4.29 ±  2%      -0.8        3.47 ±  4%  perf-profile.children.cycles-pp.vm_area_dup
      2.79 ±  8%      -0.8        1.98 ± 10%  perf-profile.children.cycles-pp.page_counter_try_charge
      2.93 ±  8%      -0.8        2.14 ±  9%  perf-profile.children.cycles-pp.__memcg_kmem_charge
      1.20            -0.6        0.55 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      0.89            -0.6        0.27 ±  4%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge_page
      2.12 ±  9%      -0.5        1.58 ± 10%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.76            -0.5        0.28 ±  4%  perf-profile.children.cycles-pp.put_task_stack
      1.56 ±  2%      -0.5        1.09 ±  4%  perf-profile.children.cycles-pp.obj_cgroup_charge
      2.40 ±  2%      -0.5        1.93 ±  4%  perf-profile.children.cycles-pp.rcu_core
      2.33            -0.5        1.86 ±  4%  perf-profile.children.cycles-pp.rcu_do_batch
      1.22 ±  2%      -0.5        0.77 ±  2%  perf-profile.children.cycles-pp.__schedule
      2.26 ± 10%      -0.4        1.82 ±  8%  perf-profile.children.cycles-pp.ret_from_fork
      2.64 ±  3%      -0.4        2.21 ±  3%  perf-profile.children.cycles-pp.__softirqentry_text_start
      2.46 ±  3%      -0.4        2.07 ±  4%  perf-profile.children.cycles-pp.do_softirq_own_stack
      2.50 ±  3%      -0.4        2.12 ±  4%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.75            -0.4        0.38 ±  4%  perf-profile.children.cycles-pp.schedule_idle
      4.36            -0.2        4.11        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.43 ±  3%      -0.2        0.22 ±  3%  perf-profile.children.cycles-pp.__kmalloc_node
      0.70            -0.2        0.49 ±  2%  perf-profile.children.cycles-pp.task_work_run
      0.48            -0.2        0.28 ±  3%  perf-profile.children.cycles-pp.proc_reg_release
      0.62            -0.2        0.42 ±  3%  perf-profile.children.cycles-pp.__fput
      0.46            -0.2        0.26 ±  4%  perf-profile.children.cycles-pp.close_pdeo
      0.71            -0.2        0.51 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.43            -0.2        0.23 ±  3%  perf-profile.children.cycles-pp.single_release
      0.59 ±  2%      -0.2        0.40 ±  2%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.54            -0.2        0.35 ±  3%  perf-profile.children.cycles-pp.kfree
      0.72 ±  2%      -0.2        0.53        perf-profile.children.cycles-pp.vfs_read
      0.73 ±  2%      -0.2        0.54        perf-profile.children.cycles-pp.ksys_read
      0.62 ±  2%      -0.2        0.44        perf-profile.children.cycles-pp.seq_read_iter
      0.63 ±  2%      -0.2        0.44 ±  2%  perf-profile.children.cycles-pp.new_sync_read
      0.42 ±  3%      -0.2        0.25 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.62 ±  2%      -0.2        0.46 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.35 ±  3%      -0.2        0.20 ±  2%  perf-profile.children.cycles-pp.uncharge_batch
      0.36 ±  4%      -0.1        0.21 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.57            -0.1        0.42 ±  2%  perf-profile.children.cycles-pp.schedule_tail
      0.36 ±  8%      -0.1        0.24 ± 28%  perf-profile.children.cycles-pp.__pud_alloc
      0.26 ±  4%      -0.1        0.15 ±  2%  perf-profile.children.cycles-pp.__mmdrop
      0.23 ±  3%      -0.1        0.13        perf-profile.children.cycles-pp.__free_pages_ok
      0.36 ±  4%      -0.1        0.26 ±  3%  perf-profile.children.cycles-pp.try_charge
      1.76 ±  3%      -0.1        1.66 ±  2%  perf-profile.children.cycles-pp.kernel_wait4
      1.73 ±  3%      -0.1        1.64 ±  3%  perf-profile.children.cycles-pp.do_wait
      1.76 ±  3%      -0.1        1.66 ±  3%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.37 ±  3%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.schedule
      0.32 ±  2%      -0.1        0.25 ±  2%  perf-profile.children.cycles-pp.__put_task_struct
      1.05 ±  2%      -0.1        0.98 ±  2%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
      0.21 ±  7%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.19 ±  5%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.24 ±  5%      -0.0        0.20 ±  7%  perf-profile.children.cycles-pp.prepare_creds
      0.32            -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.alloc_empty_file
      0.32            -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.__alloc_file
      0.16 ±  5%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.proc_reg_open
      0.21 ±  3%      -0.0        0.18 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.24 ±  6%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.lock_page_memcg
      0.11 ±  6%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__count_memcg_events
      0.15 ±  5%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.22 ±  5%      -0.0        0.19 ±  4%  perf-profile.children.cycles-pp.do_dentry_open
      0.30 ±  5%      -0.0        0.27 ±  2%  perf-profile.children.cycles-pp.__x64_sys_setpgid
      0.13 ±  5%      -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.copy_creds
      0.22            -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.15            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.proc_alloc_inode
      0.15 ±  7%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.15 ±  7%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.do_execveat_common
      0.15 ±  7%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.execve
      0.10 ±  7%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.exec_binprm
      0.16            -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__d_alloc
      0.12 ±  6%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.bprm_execve
      0.09 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.single_open
      0.19            -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.d_alloc
      0.23            -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.new_inode
      0.09 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.load_elf_binary
      0.21 ±  2%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.new_inode_pseudo
      0.19 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.alloc_inode
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__kmalloc
      0.10            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__libc_fork
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.seq_vprintf
      0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.select_idle_sibling
      0.07            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.vsnprintf
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp._find_next_bit
      0.18 ±  2%      +0.0        0.19        perf-profile.children.cycles-pp.___perf_sw_event
      0.10 ±  5%      +0.0        0.11        perf-profile.children.cycles-pp.alloc_pages_vma
      0.13            +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__might_sleep
      0.09 ±  4%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.nr_running
      0.07            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.08 ±  8%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.put_cpu_partial
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.perf_event_task
      0.06 ±  6%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.available_idle_cpu
      0.12 ±  3%      +0.0        0.14 ±  7%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.13 ±  3%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.sched_move_task
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.unlock_page_memcg
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.arch_dup_task_struct
      0.20 ±  2%      +0.0        0.22        perf-profile.children.cycles-pp.__put_user_nocheck_4
      0.15 ±  2%      +0.0        0.17        perf-profile.children.cycles-pp.loadavg_proc_show
      0.14            +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.07 ±  5%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.__list_add_valid
      0.13 ±  6%      +0.0        0.15 ±  6%  perf-profile.children.cycles-pp.__setup_rt_frame
      0.14            +0.0        0.17 ±  3%  perf-profile.children.cycles-pp.lookup_fast
      0.10            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.memcpy_erms
      0.11 ±  4%      +0.0        0.13 ± 16%  perf-profile.children.cycles-pp.update_rq_clock
      0.18 ±  6%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.free_unref_page_list
      0.15 ±  7%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.17 ±  5%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.unmap_single_vma
      0.14 ±  6%      +0.0        0.17 ±  6%  perf-profile.children.cycles-pp.allocate_slab
      0.06 ±  7%      +0.0        0.09 ± 20%  perf-profile.children.cycles-pp.menu_select
      0.76            +0.0        0.79        perf-profile.children.cycles-pp.wp_page_copy
      0.38 ±  4%      +0.0        0.41 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.38 ±  3%      +0.0        0.41 ±  2%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.21 ±  3%      +0.0        0.24        perf-profile.children.cycles-pp.__wake_up_common_lock
      0.25            +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.__rb_erase_color
      0.26            +0.0        0.29 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
      0.20 ±  4%      +0.0        0.23        perf-profile.children.cycles-pp.__wake_up_common
      0.24 ±  4%      +0.0        0.28 ±  5%  perf-profile.children.cycles-pp.update_load_avg
      0.29 ±  2%      +0.0        0.33        perf-profile.children.cycles-pp.___might_sleep
      0.53 ±  3%      +0.0        0.57 ±  3%  perf-profile.children.cycles-pp.__slab_free
      0.21 ±  2%      +0.0        0.25        perf-profile.children.cycles-pp.do_notify_parent
      0.17 ±  8%      +0.0        0.21 ±  4%  perf-profile.children.cycles-pp.vma_interval_tree_insert_after
      0.25 ±  7%      +0.0        0.30 ±  4%  perf-profile.children.cycles-pp.___slab_alloc
      0.22 ±  3%      +0.0        0.27 ± 13%  perf-profile.children.cycles-pp.getname_flags
      0.27 ±  5%      +0.0        0.31 ±  4%  perf-profile.children.cycles-pp.__slab_alloc
      0.01 ±173%      +0.0        0.06        perf-profile.children.cycles-pp.free_one_page
      0.21 ±  3%      +0.0        0.26 ± 15%  perf-profile.children.cycles-pp.strncpy_from_user
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.29 ±  4%      +0.1        0.34        perf-profile.children.cycles-pp.__rb_insert_augmented
      0.33            +0.1        0.38        perf-profile.children.cycles-pp.dup_userfaultfd
      0.45 ±  6%      +0.1        0.51 ±  3%  perf-profile.children.cycles-pp.osq_unlock
      0.15 ±  3%      +0.1        0.20 ±  6%  perf-profile.children.cycles-pp.lock_page_lruvec_irqsave
      0.24 ±  4%      +0.1        0.30 ± 13%  perf-profile.children.cycles-pp.copy_page
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.refill_stock
      0.38 ±  7%      +0.1        0.44        perf-profile.children.cycles-pp.page_add_file_rmap
      0.38 ±  2%      +0.1        0.45        perf-profile.children.cycles-pp.__list_del_entry_valid
      0.28 ±  4%      +0.1        0.35 ±  5%  perf-profile.children.cycles-pp.rmqueue
      0.51 ±  4%      +0.1        0.58 ±  5%  perf-profile.children.cycles-pp.clear_page_erms
      0.53 ±  3%      +0.1        0.61 ±  4%  perf-profile.children.cycles-pp.prep_new_page
      0.44            +0.1        0.52        perf-profile.children.cycles-pp.find_idlest_group
      0.53 ±  2%      +0.1        0.61 ±  5%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.38 ±  5%      +0.1        0.47 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.65 ±  5%      +0.1        0.75 ±  3%  perf-profile.children.cycles-pp.alloc_set_pte
      0.60 ±  3%      +0.1        0.71 ±  2%  perf-profile.children.cycles-pp.anon_vma_interval_tree_remove
      0.64            +0.1        0.75        perf-profile.children.cycles-pp.wake_up_new_task
      0.61            +0.1        0.73        perf-profile.children.cycles-pp.select_task_rq_fair
      1.12 ±  4%      +0.1        1.27 ±  4%  perf-profile.children.cycles-pp.up_write
      0.84 ±  3%      +0.2        1.00 ±  4%  perf-profile.children.cycles-pp.get_page_from_freelist
      1.59 ±  3%      +0.2        1.76 ±  2%  perf-profile.children.cycles-pp.down_write
      2.30            +0.4        2.66 ±  3%  perf-profile.children.cycles-pp.release_pages
      2.00            +0.4        2.35        perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      2.83            +0.4        3.27 ±  3%  perf-profile.children.cycles-pp.tlb_finish_mmu
      2.81            +0.4        3.25 ±  3%  perf-profile.children.cycles-pp.tlb_flush_mmu
     10.69            +0.7       11.38        perf-profile.children.cycles-pp.do_idle
     10.69            +0.7       11.38        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     10.69            +0.7       11.38        perf-profile.children.cycles-pp.cpu_startup_entry
     10.55            +0.7       11.25        perf-profile.children.cycles-pp.start_secondary
      9.44            +0.9       10.38        perf-profile.children.cycles-pp.intel_idle
      9.79            +1.0       10.80        perf-profile.children.cycles-pp.cpuidle_enter_state
      9.79            +1.0       10.80        perf-profile.children.cycles-pp.cpuidle_enter
     27.32            +1.8       29.12        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     21.75 ±  2%      +1.8       23.60        perf-profile.children.cycles-pp.osq_lock
      3.03            -2.2        0.83 ±  3%  perf-profile.self.cycles-pp.page_counter_cancel
      6.03 ±  2%      -1.2        4.85 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      4.13            -1.2        2.96 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc
      4.16 ±  3%      -1.0        3.13 ±  5%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      1.47 ±  6%      -0.9        0.52 ± 11%  perf-profile.self.cycles-pp.propagate_protected_usage
      2.23 ±  8%      -0.6        1.64 ±  8%  perf-profile.self.cycles-pp.page_counter_try_charge
      4.21            -0.2        3.98        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.41 ±  2%      -0.2        0.25 ±  4%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.75 ±  3%      -0.1        0.67 ±  3%  perf-profile.self.cycles-pp.drain_obj_stock
      0.11 ±  6%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__count_memcg_events
      0.05 ±  8%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.copy_process
      0.05 ±  8%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.08 ±  5%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.memset_erms
      0.06 ±  6%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__schedule
      0.15 ±  2%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.06            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp._find_next_bit
      0.09 ±  4%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.acct_collect
      0.07 ±  6%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.12 ±  7%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.update_load_avg
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.unlock_page_memcg
      0.13 ±  3%      +0.0        0.15 ±  5%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.07            +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.__list_add_valid
      0.06            +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.available_idle_cpu
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.memcpy_erms
      0.23 ±  4%      +0.0        0.26 ±  3%  perf-profile.self.cycles-pp.anon_vma_fork
      0.16 ±  5%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.unmap_single_vma
      0.15 ±  3%      +0.0        0.17 ±  6%  perf-profile.self.cycles-pp.copy_page_range
      0.38 ±  4%      +0.0        0.41 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.38 ±  2%      +0.0        0.40 ±  2%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.29 ±  5%      +0.0        0.32 ±  2%  perf-profile.self.cycles-pp.fput_many
      0.28 ±  2%      +0.0        0.31 ±  2%  perf-profile.self.cycles-pp.___might_sleep
      0.21            +0.0        0.24 ±  3%  perf-profile.self.cycles-pp.__rb_erase_color
      0.39 ±  2%      +0.0        0.43        perf-profile.self.cycles-pp.unlink_anon_vmas
      0.17 ±  9%      +0.0        0.21 ±  2%  perf-profile.self.cycles-pp.vma_interval_tree_insert_after
      0.51 ±  3%      +0.0        0.55 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.31 ±  2%      +0.1        0.36 ±  2%  perf-profile.self.cycles-pp.dup_userfaultfd
      0.28 ±  5%      +0.1        0.33        perf-profile.self.cycles-pp.__rb_insert_augmented
      0.29 ±  6%      +0.1        0.35 ±  3%  perf-profile.self.cycles-pp.page_add_file_rmap
      0.43 ±  6%      +0.1        0.49 ±  4%  perf-profile.self.cycles-pp.osq_unlock
      0.23 ±  2%      +0.1        0.30 ± 12%  perf-profile.self.cycles-pp.copy_page
      0.72 ±  2%      +0.1        0.79        perf-profile.self.cycles-pp._raw_spin_lock
      0.37 ±  3%      +0.1        0.44        perf-profile.self.cycles-pp.__list_del_entry_valid
      0.39            +0.1        0.46        perf-profile.self.cycles-pp.find_idlest_group
      0.48 ±  4%      +0.1        0.56 ±  5%  perf-profile.self.cycles-pp.clear_page_erms
      0.51 ±  2%      +0.1        0.58 ±  5%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.46 ±  3%      +0.1        0.55 ±  2%  perf-profile.self.cycles-pp.vm_area_dup
      0.59 ±  3%      +0.1        0.68 ±  2%  perf-profile.self.cycles-pp.anon_vma_interval_tree_remove
      0.68 ±  2%      +0.1        0.79 ±  3%  perf-profile.self.cycles-pp.dup_mmap
      0.47 ±  4%      +0.1        0.59 ±  4%  perf-profile.self.cycles-pp.anon_vma_clone
      1.09 ±  4%      +0.1        1.22 ±  4%  perf-profile.self.cycles-pp.up_write
      0.74 ±  7%      +0.1        0.88 ±  8%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      1.42 ±  3%      +0.2        1.57 ±  2%  perf-profile.self.cycles-pp.down_write
      1.22 ±  6%      +0.3        1.50 ± 10%  perf-profile.self.cycles-pp.copy_pte_range
      1.93            +0.3        2.26 ±  2%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      1.56 ±  2%      +0.4        1.96 ±  4%  perf-profile.self.cycles-pp.release_pages
      9.44            +0.9       10.38        perf-profile.self.cycles-pp.intel_idle
     21.21 ±  2%      +1.8       22.97        perf-profile.self.cycles-pp.osq_lock



***************************************************************************************************
lkp-csl-2sp7: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode:
  filesystem/gcc-9/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp7/stress-ng/30s/0x5003003

commit: 
  d3921cb8be ("mm: fix initialization of struct page for holes in memory layout")
  3de7d4f25a ("mm: memcg/slab: optimize objcg stock draining")

d3921cb8be29ce56 3de7d4f25a7438f09fef4e71ef1 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4          -25%            :4     last_state.is_incomplete_run
         %stddev     %change         %stddev
             \          |                \  
    720028 ± 11%     +12.8%     812528 ±  8%  stress-ng.dir.ops
  10642917           +54.8%   16476318        stress-ng.eventfd.ops
    354761           +54.8%     549206        stress-ng.eventfd.ops_per_sec
      3797           +24.3%       4718 ± 17%  stress-ng.procfs.ops
    126.50           +24.2%     157.15 ± 17%  stress-ng.procfs.ops_per_sec
   1405697            +2.4%    1438971        stress-ng.time.involuntary_context_switches
   7720769 ±  2%      +4.8%    8092400 ±  3%  stress-ng.time.minor_page_faults
    579.27 ±  3%      +4.8%     606.97 ±  2%  stress-ng.time.user_time
  25871459           +46.0%   37766175        stress-ng.time.voluntary_context_switches
      0.26 ±  4%      -0.1        0.18 ±  5%  mpstat.cpu.all.soft%
      1072 ± 12%     +18.1%       1266        numa-meminfo.node0.Mlocked
     56223           +35.3%      76091        vmstat.system.cs
  15061939          +274.1%   56347492 ± 60%  cpuidle.C1.usage
  22928095          +163.3%   60363254 ± 55%  cpuidle.POLL.time
  10134542 ±  2%     +62.5%   16466628 ± 11%  cpuidle.POLL.usage
    267.33 ± 12%     +18.3%     316.25        numa-vmstat.node0.nr_mlock
     49203 ± 71%    +221.1%     158009 ± 35%  numa-vmstat.node0.numa_other
    207347 ± 17%     -52.4%      98738 ± 56%  numa-vmstat.node1.numa_other
     48870 ±  7%     +12.2%      54827 ±  6%  slabinfo.Acpi-Parse.active_objs
    670.67 ±  7%     +12.5%     754.50 ±  6%  slabinfo.Acpi-Parse.active_slabs
     48999 ±  7%     +12.5%      55103 ±  6%  slabinfo.Acpi-Parse.num_objs
    670.67 ±  7%     +12.5%     754.50 ±  6%  slabinfo.Acpi-Parse.num_slabs
  45113239            +4.8%   47271692        proc-vmstat.numa_hit
  45026191            +4.8%   47184765        proc-vmstat.numa_local
  61034072            +5.7%   64517404        proc-vmstat.pgalloc_normal
    271479 ±  2%      -5.2%     257449 ±  4%  proc-vmstat.pgdeactivate
  11329788            +2.7%   11638804 ±  2%  proc-vmstat.pgfault
  60815575            +5.7%   64301056        proc-vmstat.pgfree
    520143 ± 17%     +40.1%     728832 ±  9%  proc-vmstat.slabs_scanned
    167.77 ±  5%      +9.9%     184.37 ±  5%  sched_debug.cfs_rq:/.runnable_avg.avg
    166.98 ±  5%     +10.0%     183.72 ±  5%  sched_debug.cfs_rq:/.util_avg.avg
     79.75 ±  6%     +16.7%      93.08 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    159.54 ±  4%      +7.0%     170.73 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    242127 ± 17%     -38.5%     148844 ± 11%  sched_debug.cpu.avg_idle.min
    445675           +38.3%     616501        sched_debug.cpu.nr_switches.avg
   1116396 ±  3%     +37.8%    1538914 ±  3%  sched_debug.cpu.nr_switches.max
     87188 ±  9%     +22.3%     106625 ±  9%  sched_debug.cpu.nr_switches.min
    257102 ±  7%     +29.8%     333728 ± 13%  sched_debug.cpu.nr_switches.stddev
     56712           +35.6%      76878        perf-stat.i.context-switches
      0.10 ±115%      +0.1        0.20 ± 65%  perf-stat.i.dTLB-load-miss-rate%
      0.03 ±105%      +0.0        0.05 ± 62%  perf-stat.i.dTLB-store-miss-rate%
      0.73 ±  5%      +6.6%       0.77 ±  4%  perf-stat.i.metric.K/sec
      8929            +2.9%       9184 ±  2%  perf-stat.i.minor-faults
   4355263            -7.8%    4016493        perf-stat.i.node-store-misses
      8934            +2.9%       9189 ±  2%  perf-stat.i.page-faults
      2.26            -2.4%       2.21        perf-stat.overall.cpi
      0.44            +2.5%       0.45        perf-stat.overall.ipc
     56281           +35.4%      76201        perf-stat.ps.context-switches
      8895            +2.9%       9153 ±  2%  perf-stat.ps.minor-faults
   4356106            -7.7%    4021578        perf-stat.ps.node-store-misses
      8900            +2.9%       9157 ±  2%  perf-stat.ps.page-faults
      0.01 ± 32%     +36.0%       0.02 ± 10%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.01           +62.5%       0.01 ± 25%  perf-sched.sch_delay.max.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
      3525 ±  9%     +37.0%       4827 ± 18%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.chmod_common.__x64_sys_fchmod.do_syscall_64
      4394 ± 12%     +44.9%       6368 ± 19%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.chmod_common.do_fchmodat.__x64_sys_chmod
     32.67 ±  3%     +10.2%      36.00 ±  4%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      1035          +185.7%       2959 ± 65%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      1.76 ±  3%     -19.0%       1.42 ±  7%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1.77 ±  3%     -18.9%       1.43 ±  7%  perf-sched.wait_time.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      1.19 ± 70%    +152.1%       3.01 ± 26%  perf-sched.wait_time.avg.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      6.45 ±  6%     +34.7%       8.69 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
      3.51 ±  3%     -19.0%       2.85 ±  7%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      3.53 ±  3%     -19.0%       2.86 ±  7%  perf-sched.wait_time.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.00 ± 43%   +1584.6%       0.07 ±132%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      1.19 ± 70%    +152.1%       3.01 ± 26%  perf-sched.wait_time.max.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
     17.42 ± 14%     +98.7%      34.61 ± 12%  perf-sched.wait_time.max.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
      1035          +185.7%       2959 ± 65%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
    109028 ± 13%     -19.9%      87359 ±  7%  softirqs.CPU11.RCU
    108501 ± 10%     -20.0%      86855 ±  9%  softirqs.CPU12.RCU
    110305 ± 14%     -20.7%      87480 ± 10%  softirqs.CPU14.RCU
    108707 ±  9%     -22.3%      84483 ±  6%  softirqs.CPU15.RCU
    109869 ± 11%     -22.7%      84920 ±  5%  softirqs.CPU16.RCU
    109589 ± 10%     -20.3%      87352 ±  6%  softirqs.CPU19.RCU
    111095 ±  4%     -21.7%      87035 ±  6%  softirqs.CPU20.RCU
    112327 ±  5%     -12.3%      98484 ±  4%  softirqs.CPU26.RCU
    110285 ± 11%     -20.3%      87908 ±  6%  softirqs.CPU28.RCU
    116821 ± 11%     -19.8%      93714 ±  6%  softirqs.CPU29.RCU
    116416 ± 14%     -21.5%      91381 ± 13%  softirqs.CPU52.RCU
    112023 ± 14%     -22.0%      87433 ±  3%  softirqs.CPU55.RCU
    105612 ± 13%     -16.7%      87988 ±  8%  softirqs.CPU60.RCU
    110826 ±  8%     -21.2%      87282 ±  8%  softirqs.CPU61.RCU
    107047 ±  9%     -21.2%      84308 ±  8%  softirqs.CPU64.RCU
    107421 ±  7%     -19.8%      86135 ±  4%  softirqs.CPU67.RCU
    107038 ±  6%     -18.2%      87573 ± 10%  softirqs.CPU69.RCU
    109282 ± 16%     -17.7%      89900 ±  5%  softirqs.CPU7.RCU
    107866 ± 16%     -22.1%      84000 ± 12%  softirqs.CPU71.RCU
    116855 ± 12%     -18.2%      95536 ±  6%  softirqs.CPU76.RCU
      0.62 ±  6%      +0.1        0.77 ±  5%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt
      1.36 ±  3%      +0.3        1.64 ±  4%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.36 ±  3%      +0.3        1.64 ±  4%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.33 ±  3%      +0.3        1.61 ±  4%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.99 ±  7%      +0.4        3.35 ±  8%  perf-profile.calltrace.cycles-pp.apparmor_cred_prepare.security_prepare_creds.prepare_creds.do_faccessat.do_syscall_64
      0.17 ±141%      +0.4        0.59 ±  2%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt
      0.00            +0.6        0.55 ±  6%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      6.42 ±  8%      +0.6        7.03 ±  4%  perf-profile.calltrace.cycles-pp.refcount_dec_not_one.refcount_dec_and_lock_irqsave.free_uid.put_cred_rcu.do_faccessat
      6.45 ±  8%      +0.6        7.06 ±  4%  perf-profile.calltrace.cycles-pp.refcount_dec_and_lock_irqsave.free_uid.put_cred_rcu.do_faccessat.do_syscall_64
      6.48 ±  8%      +0.6        7.11 ±  4%  perf-profile.calltrace.cycles-pp.free_uid.put_cred_rcu.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.15 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.override_creds
      0.07 ± 17%      +0.0        0.09 ± 11%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.11 ±  7%      +0.0        0.14 ±  9%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.15 ±  3%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.23 ± 10%      +0.1        0.29 ± 10%  perf-profile.children.cycles-pp.scheduler_tick
      0.41 ± 13%      +0.1        0.54 ± 11%  perf-profile.children.cycles-pp.tick_sched_handle
      0.40 ± 13%      +0.1        0.53 ± 11%  perf-profile.children.cycles-pp.update_process_times
      0.54 ±  8%      +0.1        0.67 ±  4%  perf-profile.children.cycles-pp.tick_sched_timer
      0.77 ±  7%      +0.1        0.92 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.54 ± 13%      +0.1        0.69 ± 11%  perf-profile.children.cycles-pp.clockevents_program_event
      1.59 ±  5%      +0.3        1.87 ±  8%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.62 ±  5%      +0.3        1.90 ±  8%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.00 ±  7%      +0.3        2.29 ±  7%  perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
      2.99 ±  7%      +0.4        3.35 ±  8%  perf-profile.children.cycles-pp.apparmor_cred_prepare
      6.43 ±  8%      +0.6        7.04 ±  4%  perf-profile.children.cycles-pp.refcount_dec_not_one
      6.46 ±  8%      +0.6        7.07 ±  4%  perf-profile.children.cycles-pp.refcount_dec_and_lock_irqsave
      6.49 ±  8%      +0.6        7.11 ±  4%  perf-profile.children.cycles-pp.free_uid
      0.08 ± 14%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.07 ± 14%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.15 ±  3%      +0.0        0.18 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.11 ±  7%      +0.0        0.14 ±  9%  perf-profile.self.cycles-pp.lapic_next_deadline
      2.97 ±  7%      +0.4        3.33 ±  8%  perf-profile.self.cycles-pp.apparmor_cred_prepare
      5.19 ±  7%      +0.5        5.74 ±  5%  perf-profile.self.cycles-pp.put_cred_rcu
    986.67 ±124%     -99.9%       0.50 ±173%  interrupts.54:PCI-MSI.31981587-edge.i40e-eth0-TxRx-18
      6594 ±108%    -100.0%       0.00        interrupts.67:PCI-MSI.31981600-edge.i40e-eth0-TxRx-31
     15361 ±  8%     +12.6%      17290 ±  8%  interrupts.CPU0.CAL:Function_call_interrupts
     15411 ±  6%     +18.2%      18216 ± 11%  interrupts.CPU13.CAL:Function_call_interrupts
     21697 ±  9%     +11.2%      24133 ±  8%  interrupts.CPU13.TLB:TLB_shootdowns
      6242 ± 48%     -66.3%       2106 ± 42%  interrupts.CPU16.RES:Rescheduling_interrupts
     15155 ±  5%     +20.3%      18225 ±  9%  interrupts.CPU17.CAL:Function_call_interrupts
     21635 ±  8%     +11.4%      24100 ±  6%  interrupts.CPU17.TLB:TLB_shootdowns
    986.33 ±124%    -100.0%       0.25 ±173%  interrupts.CPU18.54:PCI-MSI.31981587-edge.i40e-eth0-TxRx-18
      7537 ± 75%     -76.7%       1756 ± 18%  interrupts.CPU18.RES:Rescheduling_interrupts
     19872 ±  4%     -10.8%      17734 ±  8%  interrupts.CPU21.CAL:Function_call_interrupts
      7630 ± 38%     -50.9%       3750 ± 41%  interrupts.CPU25.RES:Rescheduling_interrupts
     12745 ± 44%     -70.0%       3828 ± 33%  interrupts.CPU30.RES:Rescheduling_interrupts
      6594 ±108%    -100.0%       0.00        interrupts.CPU31.67:PCI-MSI.31981600-edge.i40e-eth0-TxRx-31
      2514 ± 34%    +161.7%       6579 ± 36%  interrupts.CPU31.RES:Rescheduling_interrupts
    151.67 ±  4%     -22.5%     117.50 ± 25%  interrupts.CPU32.NMI:Non-maskable_interrupts
    151.67 ±  4%     -22.5%     117.50 ± 25%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
      2186 ± 15%    +168.5%       5871 ± 47%  interrupts.CPU4.RES:Rescheduling_interrupts
     18838 ±  8%     +17.8%      22200 ± 13%  interrupts.CPU40.CAL:Function_call_interrupts
      1042 ±122%    +283.2%       3995 ± 96%  interrupts.CPU40.NMI:Non-maskable_interrupts
      1042 ±122%    +283.2%       3995 ± 96%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
      4994 ± 22%     -69.4%       1527 ± 91%  interrupts.CPU46.NMI:Non-maskable_interrupts
      4994 ± 22%     -69.4%       1527 ± 91%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
      1499 ±131%    +236.0%       5037 ± 59%  interrupts.CPU48.NMI:Non-maskable_interrupts
      1499 ±131%    +236.0%       5037 ± 59%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
     16663 ±  7%     +23.0%      20495 ± 11%  interrupts.CPU49.CAL:Function_call_interrupts
    114.67 ± 27%   +2932.0%       3476 ± 72%  interrupts.CPU49.NMI:Non-maskable_interrupts
    114.67 ± 27%   +2932.0%       3476 ± 72%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
     22069 ± 11%     +21.1%      26736 ± 12%  interrupts.CPU49.TLB:TLB_shootdowns
      2733 ±133%     -95.8%     114.00 ± 25%  interrupts.CPU5.NMI:Non-maskable_interrupts
      2733 ±133%     -95.8%     114.00 ± 25%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
      4574 ± 30%     -47.9%       2382 ± 44%  interrupts.CPU50.RES:Rescheduling_interrupts
     15867 ± 12%     +16.6%      18496 ±  8%  interrupts.CPU52.CAL:Function_call_interrupts
      1307 ±125%     -89.8%     133.50 ±  3%  interrupts.CPU58.NMI:Non-maskable_interrupts
      1307 ±125%     -89.8%     133.50 ±  3%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
      6139 ± 46%     -60.5%       2427 ± 76%  interrupts.CPU64.RES:Rescheduling_interrupts
      7489 ± 67%     -66.1%       2541 ± 43%  interrupts.CPU66.RES:Rescheduling_interrupts
     24235 ± 14%     +19.0%      28848 ± 11%  interrupts.CPU67.TLB:TLB_shootdowns
     16186 ± 10%     +19.0%      19269 ± 11%  interrupts.CPU69.CAL:Function_call_interrupts
     21972 ± 12%     +13.4%      24921 ±  9%  interrupts.CPU69.TLB:TLB_shootdowns
    172.33 ± 15%     -43.3%      97.75 ± 34%  interrupts.CPU7.NMI:Non-maskable_interrupts
    172.33 ± 15%     -43.3%      97.75 ± 34%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
      4791 ± 19%     -48.5%       2467 ± 23%  interrupts.CPU70.RES:Rescheduling_interrupts
      7892 ± 39%     -58.7%       3259 ± 46%  interrupts.CPU73.RES:Rescheduling_interrupts
     28136 ±  8%     -13.1%      24437 ±  8%  interrupts.CPU73.TLB:TLB_shootdowns
     12028 ± 42%     -60.8%       4715 ± 40%  interrupts.CPU78.RES:Rescheduling_interrupts
      2926 ± 30%    +126.8%       6636 ± 19%  interrupts.CPU79.RES:Rescheduling_interrupts
     21660 ±  3%     -12.3%      18992 ± 10%  interrupts.CPU82.CAL:Function_call_interrupts
     28681 ±  4%     -16.7%      23879 ±  4%  interrupts.CPU82.TLB:TLB_shootdowns
     22381 ± 11%     -21.6%      17554 ±  7%  interrupts.CPU83.CAL:Function_call_interrupts
     28764 ± 12%     -19.5%      23162 ±  4%  interrupts.CPU83.TLB:TLB_shootdowns
     27733 ± 10%     -13.2%      24069 ±  3%  interrupts.CPU86.TLB:TLB_shootdowns
     21889 ± 11%     -19.2%      17686 ±  6%  interrupts.CPU87.CAL:Function_call_interrupts
     29488 ±  9%     -19.8%      23643 ±  5%  interrupts.CPU87.TLB:TLB_shootdowns
     25340 ±  6%     -22.4%      19673 ±  6%  interrupts.CPU90.CAL:Function_call_interrupts
     29230 ± 12%     -15.7%      24646 ±  2%  interrupts.CPU90.TLB:TLB_shootdowns





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Oliver Sang


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.11.0-rc4-g3de7d4f25a74"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.11.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-20) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235010000
CONFIG_CLANG_VERSION=0
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
CONFIG_TASKS_RCU=y
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
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
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
CONFIG_BPF=y
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
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
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
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
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
CONFIG_DYNAMIC_PHYSICAL_MASK=y
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
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
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
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
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
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
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
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

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
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

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
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
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
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
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
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y

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
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
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
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
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
CONFIG_CMA_AREAS=19
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
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
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
# CONFIG_MPTCP is not set
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
CONFIG_NF_LOG_COMMON=m
CONFIG_NF_LOG_NETDEV=m
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
CONFIG_NF_LOG_BRIDGE=m
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
CONFIG_HAVE_NET_DSA=y
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
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
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
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

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
# CONFIG_PCIE_BW is not set
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
# CONFIG_PM_QOS_KUNIT_TEST is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_KUNIT_DRIVER_PE_TEST=y
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
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
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
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=y
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
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
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
# CONFIG_SCSI_GDTH is not set
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

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

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
# CONFIG_NET_VENDOR_AURORA is not set
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
# CONFIG_IGC is not set
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
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
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
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
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
# CONFIG_DEVKMEM is not set
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
# CONFIG_GPIO_XILINX is not set
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
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
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
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
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
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
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
# CONFIG_ABX500_CORE is not set
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
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
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
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
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
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
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
CONFIG_I2C_HID=m
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
# CONFIG_USB_CDNS3 is not set
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
# CONFIG_INFINIBAND_BNXT_RE is not set
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
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
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
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

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
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
# CONFIG_DELL_WMI_SYSMAN is not set
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_LED=m
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
# CONFIG_INTEL_PMT_CLASS is not set
# CONFIG_INTEL_PMT_TELEMETRY is not set
# CONFIG_INTEL_PMT_CRASHLOG is not set
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
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
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
# CONFIG_XILINX_VCU is not set
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
# CONFIG_F2FS_IO_TRACE is not set
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
CONFIG_PROC_CPU_RESCTRL=y
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
# CONFIG_9P_FS is not set
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
# CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
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
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
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
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

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
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
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
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
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
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
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
CONFIG_CRYPTO_SALSA20=m
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
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
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
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
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

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
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
CONFIG_DEBUG_INFO_DWARF4=y
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
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
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
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

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
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
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
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
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
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=m
CONFIG_KUNIT_EXAMPLE_TEST=m
# CONFIG_KUNIT_ALL_TESTS is not set
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
# CONFIG_BITFIELD_KUNIT is not set
# CONFIG_RESOURCE_KUNIT_TEST is not set
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
# CONFIG_LINEAR_RANGES_TEST is not set
# CONFIG_CMDLINE_KUNIT_TEST is not set
# CONFIG_BITS_TEST is not set
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
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='hackbench'
	export testcase='hackbench'
	export category='benchmark'
	export disable_latency_stats=1
	export nr_threads=144
	export iterations=4
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-cpl-4sp1/hackbench-100.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-cpl-4sp1'
	export tbox_group='lkp-cpl-4sp1'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='600fc213fee145290a04884b'
	export job_file='/lkp/jobs/scheduled/lkp-cpl-4sp1/hackbench-performance-socket-4-threads-100%-ucode=0x700001e-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-3de7d4f25a7438f09fe-20210126-10506-v0l4yj-2.yaml'
	export id='0ee65d5c0804a70ac0e95c3e7a210a95df17832f'
	export queuer_version='/lkp-src'
	export model='Cooper Lake'
	export nr_node=4
	export nr_cpu=144
	export memory='128G'
	export nr_hdd_partitions=
	export nr_ssd_partitions=2
	export hdd_partitions=
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part4
/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part5'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part3'
	export kernel_cmdline_hw='acpi_rsdp=0x695fd014'
	export brand='Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz'
	export commit='3de7d4f25a7438f09fef4e71ef111f1805cd8e7c'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_SATA_AHCI'
	export ucode='0x700001e'
	export enqueue_time='2021-01-26 15:17:39 +0800'
	export _id='600fc213fee145290a04884b'
	export _rt='/result/hackbench/performance-socket-4-threads-100%-ucode=0x700001e-monitor=70d6d718/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3de7d4f25a7438f09fef4e71ef111f1805cd8e7c'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='747457bafd224bdecbd3724f69a7c471f67e3cb6'
	export base_commit='6ee1d745b7c9fd573fba142a2efdad76a9f1cb04'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='70d6d718'
	export result_root='/result/hackbench/performance-socket-4-threads-100%-ucode=0x700001e-monitor=70d6d718/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3de7d4f25a7438f09fef4e71ef111f1805cd8e7c/3'
	export scheduler_version='/lkp/lkp/.src-20210126-115419'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-cpl-4sp1/hackbench-performance-socket-4-threads-100%-ucode=0x700001e-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-3de7d4f25a7438f09fe-20210126-10506-v0l4yj-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=3de7d4f25a7438f09fef4e71ef111f1805cd8e7c
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/3de7d4f25a7438f09fef4e71ef111f1805cd8e7c/vmlinuz-5.11.0-rc4-g3de7d4f25a74
acpi_rsdp=0x695fd014
max_uptime=2100
RESULT_ROOT=/result/hackbench/performance-socket-4-threads-100%-ucode=0x700001e-monitor=70d6d718/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3de7d4f25a7438f09fef4e71ef111f1805cd8e7c/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/3de7d4f25a7438f09fef4e71ef111f1805cd8e7c/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hackbench_20210105.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/hackbench-x86_64-1.10-1_20210105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-e71ba9452f0b-1_20210106.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.11.0-rc4-g19c329f68089'
	export repeat_to=4
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/3de7d4f25a7438f09fef4e71ef111f1805cd8e7c/vmlinuz-5.11.0-rc4-g3de7d4f25a74'
	export dequeue_time='2021-01-26 15:37:30 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-cpl-4sp1/hackbench-performance-socket-4-threads-100%-ucode=0x700001e-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-3de7d4f25a7438f09fe-20210126-10506-v0l4yj-2.cgz'

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
	run_monitor $LKP_SRC/monitors/wrapper perf-sched
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test mode='threads' ipc='socket' $LKP_SRC/tests/wrapper hackbench
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper hackbench
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
	$LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	$LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time hackbench.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/hackbench-100.yaml
suite: hackbench
testcase: hackbench
category: benchmark
disable_latency_stats: 1
nr_threads: 100%
iterations: 4
hackbench:
  mode: threads
  ipc: socket
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-cpl-4sp1/hackbench-100.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-cpl-4sp1
tbox_group: lkp-cpl-4sp1
kconfig: x86_64-rhel-8.3
submit_id: 600f95cefee14520a10fe243
job_file: "/lkp/jobs/scheduled/lkp-cpl-4sp1/hackbench-performance-socket-4-threads-100%-ucode=0x700001e-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-3de7d4f25a7438f09fe-20210126-8353-1onqrte-1.yaml"
id: e65951d72d1c1ecdba055a4a85a76b726a7f0d06
queuer_version: "/lkp-src"

#! hosts/lkp-cpl-4sp1
model: Cooper Lake
nr_node: 4
nr_cpu: 144
memory: 128G
nr_hdd_partitions: 
nr_ssd_partitions: 2
hdd_partitions: 
ssd_partitions:
- "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part4"
- "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part5"
swap_partitions: 
rootfs_partition: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part3"
kernel_cmdline_hw: acpi_rsdp=0x695fd014
brand: Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz

#! include/category/benchmark
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
softirqs: 
bdi_dev_mapping: 
diskstats: 
nfsstat: 
cpuidle: 
cpufreq-stats: 
sched_debug: 
perf-stat: 
mpstat: 
perf-profile: 

#! include/category/ALL
cpufreq_governor: performance

#! include/queue/cyclic
commit: 3de7d4f25a7438f09fef4e71ef111f1805cd8e7c

#! include/testbox/lkp-cpl-4sp1
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_SATA_AHCI
ucode: '0x700001e'
enqueue_time: 2021-01-26 12:08:46.753379265 +08:00
_id: 600f9707fee14520a10fe244
_rt: "/result/hackbench/performance-socket-4-threads-100%-ucode=0x700001e-monitor=70d6d718/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3de7d4f25a7438f09fef4e71ef111f1805cd8e7c"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 747457bafd224bdecbd3724f69a7c471f67e3cb6
base_commit: 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04
branch: linux-devel/devel-hourly-20210125-085352
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 70d6d718
result_root: "/result/hackbench/performance-socket-4-threads-100%-ucode=0x700001e-monitor=70d6d718/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3de7d4f25a7438f09fef4e71ef111f1805cd8e7c/0"
scheduler_version: "/lkp/lkp/.src-20210126-115419"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-cpl-4sp1/hackbench-performance-socket-4-threads-100%-ucode=0x700001e-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-3de7d4f25a7438f09fe-20210126-8353-1onqrte-1.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210125-085352
- commit=3de7d4f25a7438f09fef4e71ef111f1805cd8e7c
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/3de7d4f25a7438f09fef4e71ef111f1805cd8e7c/vmlinuz-5.11.0-rc4-g3de7d4f25a74
- acpi_rsdp=0x695fd014
- max_uptime=2100
- RESULT_ROOT=/result/hackbench/performance-socket-4-threads-100%-ucode=0x700001e-monitor=70d6d718/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3de7d4f25a7438f09fef4e71ef111f1805cd8e7c/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/3de7d4f25a7438f09fef4e71ef111f1805cd8e7c/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hackbench_20210105.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/hackbench-x86_64-1.10-1_20210105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-e71ba9452f0b-1_20210106.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210122-145149/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.11.0-rc5
repeat_to: 2

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/3de7d4f25a7438f09fef4e71ef111f1805cd8e7c/vmlinuz-5.11.0-rc4-g3de7d4f25a74"
dequeue_time: 2021-01-26 12:16:30.126855772 +08:00

#! /lkp/lkp/.src-20210126-115419/include/site/inn
job_state: finished
loadavg: 1094.37 2232.95 1690.52 1/1133 45255
start_time: '1550139125'
end_time: '1550140084'
version: "/lkp/lkp/.src-20210126-115449:b8bd33f2-dirty:ceea82073"

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "/usr/bin/hackbench" "-g" "144" "--threads" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "144" "--threads" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "144" "--threads" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "144" "--threads" "-l" "30000" "-s" "100"

--FL5UXtIhxfXey3p5--
