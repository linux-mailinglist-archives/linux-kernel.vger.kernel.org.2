Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3082837FA62
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhEMPPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:15:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:20476 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234727AbhEMPPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:15:18 -0400
IronPort-SDR: oyEa38QG+3EP7/9lMs2QQ7NxNKobmWjxkpLrpLl4XWYPqu6JfFzbRYJUbCGocvoypQ7FybiUeY
 3pxpZPBLeA3g==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="179561121"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="yaml'?scan'208";a="179561121"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 08:14:05 -0700
IronPort-SDR: gEJIjuVqCZXKNWnjPqJyASuTZcfCuhGj31e0Vj/d+H0HIzAvQ1iievyAyPxqL57PfOqtG7u/JA
 QIMt7JmSU9oA==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="yaml'?scan'208";a="431286574"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 08:13:59 -0700
Date:   Thu, 13 May 2021 23:30:51 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@intel.com
Subject: [block]  c76f48eb5c:  stress-ng.loop.ops_per_sec -99.9% regression
Message-ID: <20210513153051.GA23902@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Greeting,

FYI, we noticed a -99.9% regression of stress-ng.loop.ops_per_sec due to commit:


commit: c76f48eb5c084b1e15c931ae8cc1826cd771d70d ("block: take bd_mutex around delete_partitions in del_gendisk")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: stress-ng
on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
with following parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	class: os
	test: loop
	cpufreq_governor: performance
	ucode: 0x5003006


In addition to that, the commit also has significant impact on the following tests:

+------------------+--------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.loop.ops_per_sec -99.4% regression                        |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory |
| test parameters  | class=device                                                                   |
|                  | cpufreq_governor=performance                                                   |
|                  | disk=1HDD                                                                      |
|                  | nr_threads=100%                                                                |
|                  | test=loop                                                                      |
|                  | testtime=60s                                                                   |
|                  | ucode=0x5003006                                                                |
+------------------+--------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.loop.ops_per_sec -99.5% regression                        |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory |
| test parameters  | class=device                                                                   |
|                  | cpufreq_governor=performance                                                   |
|                  | disk=1HDD                                                                      |
|                  | nr_threads=100%                                                                |
|                  | testtime=60s                                                                   |
|                  | ucode=0x5003006                                                                |
+------------------+--------------------------------------------------------------------------------+


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
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
  os/gcc-9/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp5/loop/stress-ng/60s/0x5003006

commit: 
  d3c4a43d92 ("block: refactor blk_drop_partitions")
  c76f48eb5c ("block: take bd_mutex around delete_partitions in del_gendisk")

d3c4a43d9291279c c76f48eb5c084b1e15c931ae8cc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1460 ±  3%     -99.2%      12.17 ± 28%  stress-ng.loop.ops
     24.28 ±  3%     -99.9%       0.03 ± 47%  stress-ng.loop.ops_per_sec
     62.31          +634.2%     457.48 ± 18%  stress-ng.time.elapsed_time
     62.31          +634.2%     457.48 ± 18%  stress-ng.time.elapsed_time.max
      3687 ±  4%     -99.0%      35.67 ± 21%  stress-ng.time.involuntary_context_switches
      9790            -1.4%       9650        stress-ng.time.minor_page_faults
     36.33 ±  4%    -100.0%       0.00        stress-ng.time.percent_of_cpu_this_job_got
     22.97 ±  4%     -98.9%       0.25 ± 26%  stress-ng.time.system_time
     54565 ± 14%     -98.1%       1048 ± 59%  stress-ng.time.voluntary_context_switches
      2.11 ±  3%     -16.6%       1.76 ±  2%  iostat.cpu.system
     15.50            -1.0%      15.34        boot-time.dhcp
      2249            -4.0%       2160 ±  2%  boot-time.idle
    179396 ± 17%    +228.3%     588985 ± 41%  numa-numastat.node0.local_node
    214097 ±  5%    +193.4%     628215 ± 39%  numa-numastat.node0.numa_hit
    106.77 ±  6%    +365.7%     497.26 ± 17%  uptime.boot
      9731 ±  6%    +378.1%      46529 ± 17%  uptime.idle
      0.58 ±  9%      -0.6        0.02 ± 10%  mpstat.cpu.all.iowait%
      1.30 ±  4%      +0.3        1.62 ±  2%  mpstat.cpu.all.irq%
      0.59 ±  5%      -0.6        0.03 ±  4%  mpstat.cpu.all.sys%
      0.08 ±  4%      -0.1        0.01 ± 11%  mpstat.cpu.all.usr%
      1571 ±  4%     -99.9%       1.83 ± 37%  vmstat.io.bi
      5186 ±  4%     -68.7%       1620 ±  3%  vmstat.memory.buff
      8151 ±  3%     -83.1%       1376        vmstat.system.cs
    189078            +1.4%     191737        vmstat.system.in
   5929338 ±  5%     -50.7%    2922966 ±  4%  cpuidle.C1.time
     67292 ±  6%     -29.7%      47309 ± 11%  cpuidle.C1.usage
 4.335e+09 ± 32%    +725.3%  3.578e+10 ± 25%  cpuidle.C1E.time
  10004764 ± 19%    +681.6%   78192921 ± 20%  cpuidle.C1E.usage
     41558 ±  2%    +181.5%     116998 ± 16%  cpuidle.POLL.usage
      1011 ± 35%     -76.9%     234.00 ± 58%  numa-vmstat.node0.nr_active_file
      9.17 ±223%   +1625.5%     158.17 ± 59%  numa-vmstat.node0.nr_mlock
     12430 ±  8%     -15.6%      10487 ±  5%  numa-vmstat.node0.nr_slab_reclaimable
     29413 ±  6%     -22.2%      22871 ±  6%  numa-vmstat.node0.nr_slab_unreclaimable
      1011 ± 35%     -76.9%     234.00 ± 58%  numa-vmstat.node0.nr_zone_active_file
    540.50 ± 10%    +266.8%       1982 ± 22%  numa-vmstat.node1.nr_active_anon
      8778 ±  4%     -11.8%       7745 ±  5%  numa-vmstat.node1.nr_kernel_stack
     12.67 ±223%    +923.7%     129.67 ± 49%  numa-vmstat.node1.nr_mlock
    540.50 ± 10%    +266.8%       1982 ± 22%  numa-vmstat.node1.nr_zone_active_anon
      4040 ± 35%     -76.8%     938.50 ± 58%  numa-meminfo.node0.Active(file)
     49724 ±  8%     -15.6%      41952 ±  5%  numa-meminfo.node0.KReclaimable
   1517822 ±  2%     -24.9%    1139967 ±  5%  numa-meminfo.node0.MemUsed
     39.67 ±206%   +1497.1%     633.50 ± 59%  numa-meminfo.node0.Mlocked
     49724 ±  8%     -15.6%      41952 ±  5%  numa-meminfo.node0.SReclaimable
    117651 ±  6%     -22.2%      91486 ±  6%  numa-meminfo.node0.SUnreclaim
    167376 ±  6%     -20.3%     133439 ±  4%  numa-meminfo.node0.Slab
      4333 ± 38%    +107.3%       8982 ± 19%  numa-meminfo.node1.Active
      2162 ± 10%    +266.9%       7935 ± 22%  numa-meminfo.node1.Active(anon)
      8787 ±  4%     -11.9%       7741 ±  5%  numa-meminfo.node1.KernelStack
     64.33 ±  4%     -30.3%      44.83 ± 12%  turbostat.Avg_MHz
      1639 ±  2%     -36.9%       1034        turbostat.Bzy_MHz
     62850 ±  4%     -38.4%      38729 ± 17%  turbostat.C1
      0.09 ±  7%      -0.1        0.01 ± 44%  turbostat.C1%
  10004024 ± 19%    +681.6%   78191627 ± 20%  turbostat.C1E
      0.82 ±173%     -96.7%       0.03 ± 17%  turbostat.CPU%c6
     46.67 ±  3%      -8.2%      42.83 ±  3%  turbostat.CoreTmp
  12568851 ±  2%    +602.3%   88274702 ± 18%  turbostat.IRQ
     48.00 ±  2%      -7.3%      44.50 ±  2%  turbostat.PkgTmp
    121.79           -30.8%      84.34 ±  5%  turbostat.PkgWatt
      9534 ±  3%     +40.2%      13369 ± 10%  meminfo.Active
      3329 ±  2%    +241.9%      11383 ± 11%  meminfo.Active(anon)
      6204 ±  3%     -68.0%       1986 ±  4%  meminfo.Active(file)
     94153 ± 11%     +86.3%     175387 ±  2%  meminfo.AnonHugePages
      5114 ±  4%     -68.3%       1619 ±  3%  meminfo.Buffers
    950.67 ±  6%     +41.6%       1345 ± 22%  meminfo.Inactive(file)
     18709           -11.4%      16572 ±  2%  meminfo.KernelStack
   2861608           -15.8%    2408092        meminfo.Memused
     93.50 ±207%   +1134.0%       1153 ± 54%  meminfo.Mlocked
      5593           -12.1%       4917        meminfo.PageTables
     23126           +36.2%      31510 ±  4%  meminfo.Shmem
    832.33 ±  2%    +241.9%       2845 ± 11%  proc-vmstat.nr_active_anon
      1553 ±  3%     -68.1%     496.17 ±  4%  proc-vmstat.nr_active_file
     65178            -7.5%      60279        proc-vmstat.nr_anon_pages
     73.67 ±  8%     +62.4%     119.67 ± 21%  proc-vmstat.nr_dirtied
     70173            -7.1%      65156        proc-vmstat.nr_inactive_anon
    240.67 ±  7%     +39.6%     336.00 ± 22%  proc-vmstat.nr_inactive_file
     18703           -11.4%      16574 ±  2%  proc-vmstat.nr_kernel_stack
     10130            -3.2%       9806        proc-vmstat.nr_mapped
     22.67 ±213%   +1171.3%     288.17 ± 54%  proc-vmstat.nr_mlock
      1396           -12.2%       1226        proc-vmstat.nr_page_table_pages
      5781           +36.2%       7877 ±  4%  proc-vmstat.nr_shmem
     24121            -6.2%      22619        proc-vmstat.nr_slab_reclaimable
     49566            -7.2%      45987        proc-vmstat.nr_slab_unreclaimable
     60.83           +85.2%     112.67 ± 27%  proc-vmstat.nr_written
    832.33 ±  2%    +241.9%       2845 ± 11%  proc-vmstat.nr_zone_active_anon
      1553 ±  3%     -68.1%     496.17 ±  4%  proc-vmstat.nr_zone_active_file
     70173            -7.1%      65156        proc-vmstat.nr_zone_inactive_anon
    240.67 ±  7%     +39.6%     336.00 ± 22%  proc-vmstat.nr_zone_inactive_file
    467764          +154.3%    1189540 ± 14%  proc-vmstat.numa_hit
    379011          +190.9%    1102732 ± 15%  proc-vmstat.numa_local
     88753            -2.2%      86808        proc-vmstat.numa_other
      7810 ±130%    +218.2%      24852 ± 86%  proc-vmstat.numa_pte_updates
      9485 ±  3%     -65.3%       3294 ± 10%  proc-vmstat.pgactivate
    562092          +123.2%    1254854 ± 13%  proc-vmstat.pgalloc_normal
    232165 ±  2%    +475.4%    1335901 ± 17%  proc-vmstat.pgfault
    424165          +192.7%    1241418 ± 13%  proc-vmstat.pgfree
    104618 ±  3%     -99.0%       1040 ± 27%  proc-vmstat.pgpgin
    465899 ± 15%    +562.5%    3086805 ± 28%  proc-vmstat.pgpgout
     15086 ±  2%    +490.4%      89066 ± 18%  proc-vmstat.pgreuse
     10368 ± 45%    +261.8%      37510 ± 19%  sched_debug.cfs_rq:/.load.avg
    437084 ± 53%     +76.5%     771654 ±  4%  sched_debug.cfs_rq:/.load.max
     55417 ± 46%    +158.9%     143481 ±  9%  sched_debug.cfs_rq:/.load.stddev
    423.26 ± 56%     -87.2%      53.98 ± 15%  sched_debug.cfs_rq:/.load_avg.avg
     20090 ± 66%     -92.4%       1536 ± 10%  sched_debug.cfs_rq:/.load_avg.max
      2552 ± 65%     -91.0%     230.91 ± 12%  sched_debug.cfs_rq:/.load_avg.stddev
    236.93 ± 32%     -68.3%      75.01 ± 15%  sched_debug.cfs_rq:/.runnable_avg.avg
      1063 ± 17%     -36.6%     673.90 ±  7%  sched_debug.cfs_rq:/.runnable_avg.max
    225.09 ± 23%     -41.2%     132.27 ±  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
    236.00 ± 32%     -68.3%      74.90 ± 15%  sched_debug.cfs_rq:/.util_avg.avg
      1063 ± 17%     -36.6%     673.50 ±  7%  sched_debug.cfs_rq:/.util_avg.max
    224.45 ± 23%     -41.1%     132.15 ±  8%  sched_debug.cfs_rq:/.util_avg.stddev
     18.88 ± 32%     -66.4%       6.34 ± 21%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    392.50 ± 17%     -64.3%     140.07 ± 22%  sched_debug.cfs_rq:/.util_est_enqueued.max
     74.78 ± 25%     -65.3%      25.92 ± 14%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    831245 ±  4%     +12.1%     931711        sched_debug.cpu.avg_idle.avg
   1368408 ± 11%     -21.6%    1072417 ±  2%  sched_debug.cpu.avg_idle.max
    235908 ± 17%     -38.0%     146247 ± 11%  sched_debug.cpu.avg_idle.stddev
     67132 ±  7%    +255.4%     238559 ± 15%  sched_debug.cpu.clock.avg
     67137 ±  7%    +255.3%     238562 ± 15%  sched_debug.cpu.clock.max
     67126 ±  7%    +255.4%     238555 ± 15%  sched_debug.cpu.clock.min
      3.23 ± 25%     -32.5%       2.18 ±  5%  sched_debug.cpu.clock.stddev
     66636 ±  6%    +252.6%     234974 ± 15%  sched_debug.cpu.clock_task.avg
     66777 ±  6%    +252.3%     235236 ± 15%  sched_debug.cpu.clock_task.max
     62002 ±  7%    +271.3%     230245 ± 15%  sched_debug.cpu.clock_task.min
    212.96 ± 19%     -35.4%     137.64 ±  9%  sched_debug.cpu.curr->pid.avg
      3577 ± 14%    +111.2%       7556 ± 12%  sched_debug.cpu.curr->pid.max
    712.24 ±  8%     +24.2%     884.78 ± 10%  sched_debug.cpu.curr->pid.stddev
    697232 ±  8%     -21.9%     544502        sched_debug.cpu.max_idle_balance_cost.max
     27525 ± 21%     -73.9%       7190 ± 30%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ± 20%     -44.7%       0.00 ±  3%  sched_debug.cpu.next_balance.stddev
      0.09 ± 21%     -57.9%       0.04 ±  9%  sched_debug.cpu.nr_running.avg
      0.27 ± 12%     -35.6%       0.17 ±  3%  sched_debug.cpu.nr_running.stddev
     15057 ± 24%    +329.0%      64594 ± 21%  sched_debug.cpu.nr_switches.max
      2284 ± 22%    +219.1%       7290 ± 19%  sched_debug.cpu.nr_switches.stddev
      0.07 ± 34%     +65.8%       0.12 ±  4%  sched_debug.cpu.nr_uninterruptible.avg
     67129 ±  7%    +255.4%     238555 ± 15%  sched_debug.cpu_clk
     66635 ±  7%    +257.3%     238060 ± 15%  sched_debug.ktime
     67490 ±  7%    +254.0%     238918 ± 15%  sched_debug.sched_clk
 3.418e+08 ±  3%     -48.7%  1.754e+08 ±  7%  perf-stat.i.branch-instructions
   5554030 ± 33%     -47.2%    2935198 ±  9%  perf-stat.i.branch-misses
  21039609 ± 33%     -42.6%   12083131 ±  8%  perf-stat.i.cache-references
      8238 ±  3%     -83.7%       1341        perf-stat.i.context-switches
      3.59 ±  3%     +28.8%       4.62 ± 10%  perf-stat.i.cpi
 5.649e+09 ±  6%     -32.4%  3.818e+09 ± 18%  perf-stat.i.cpu-cycles
    160.13           -38.7%      98.17        perf-stat.i.cpu-migrations
      1768 ± 15%     -23.5%       1352 ±  8%  perf-stat.i.cycles-between-cache-misses
 4.183e+08 ±  2%     -45.5%  2.282e+08 ±  4%  perf-stat.i.dTLB-loads
  2.07e+08 ±  2%     -40.7%  1.228e+08 ±  3%  perf-stat.i.dTLB-stores
 1.627e+09 ±  3%     -48.2%  8.418e+08 ±  7%  perf-stat.i.instructions
      1017 ±  9%     -47.8%     530.70 ±  7%  perf-stat.i.instructions-per-iTLB-miss
      0.29 ±  4%     -22.5%       0.22 ± 10%  perf-stat.i.ipc
     11.04 ±  3%     -80.2%       2.19 ± 17%  perf-stat.i.major-faults
      0.06 ±  6%     -32.4%       0.04 ± 18%  perf-stat.i.metric.GHz
    248.80 ± 29%     -40.4%     148.35 ±  7%  perf-stat.i.metric.K/sec
     10.07 ±  2%     -45.6%       5.48 ±  5%  perf-stat.i.metric.M/sec
      3169           -11.5%       2806        perf-stat.i.minor-faults
    491422 ±  7%     -51.9%     236374 ±  3%  perf-stat.i.node-load-misses
     85385 ±  7%     -48.8%      43677 ± 34%  perf-stat.i.node-loads
    270636 ±  7%     -87.0%      35097 ±  8%  perf-stat.i.node-store-misses
     65751 ± 18%     -90.4%       6330 ± 48%  perf-stat.i.node-stores
      3212           -12.6%       2808        perf-stat.i.page-faults
      3.47 ±  3%     +29.8%       4.51 ± 11%  perf-stat.overall.cpi
      1746 ± 14%     -22.7%       1349 ±  8%  perf-stat.overall.cycles-between-cache-misses
      1018 ± 10%     -47.8%     531.43 ±  7%  perf-stat.overall.instructions-per-iTLB-miss
      0.29 ±  4%     -22.2%       0.22 ± 10%  perf-stat.overall.ipc
 3.364e+08 ±  3%     -48.0%  1.751e+08 ±  7%  perf-stat.ps.branch-instructions
   5466172 ± 33%     -46.4%    2928478 ±  9%  perf-stat.ps.branch-misses
  20711633 ± 33%     -41.8%   12055873 ±  8%  perf-stat.ps.cache-references
      8111 ±  3%     -83.5%       1338        perf-stat.ps.context-switches
     94513            +1.3%      95782        perf-stat.ps.cpu-clock
 5.561e+09 ±  6%     -31.5%   3.81e+09 ± 18%  perf-stat.ps.cpu-cycles
    157.63           -37.9%      97.94        perf-stat.ps.cpu-migrations
 4.117e+08 ±  2%     -44.7%  2.276e+08 ±  4%  perf-stat.ps.dTLB-loads
 2.037e+08 ±  2%     -39.9%  1.225e+08 ±  3%  perf-stat.ps.dTLB-stores
 1.601e+09 ±  3%     -47.5%  8.399e+08 ±  7%  perf-stat.ps.instructions
     10.91 ±  3%     -79.9%       2.19 ± 18%  perf-stat.ps.major-faults
      3119           -10.3%       2800        perf-stat.ps.minor-faults
    483738 ±  7%     -51.2%     235839 ±  3%  perf-stat.ps.node-load-misses
     84032 ±  7%     -48.1%      43579 ± 34%  perf-stat.ps.node-loads
    266371 ±  7%     -86.9%      35018 ±  8%  perf-stat.ps.node-store-misses
     64694 ± 18%     -90.2%       6316 ± 48%  perf-stat.ps.node-stores
      3162           -11.4%       2802        perf-stat.ps.page-faults
     94513            +1.3%      95782        perf-stat.ps.task-clock
 1.033e+11 ±  3%    +275.1%  3.875e+11 ± 22%  perf-stat.total.instructions
      0.00 ±223%    +812.5%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ±223%    +622.2%       0.01 ± 30%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ±223%   +1240.0%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.00 ± 58%    +428.6%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00 ± 35%    +182.6%       0.01 ± 31%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 25%     +86.7%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.78 ± 52%     -98.4%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.00 ±223%   +1387.5%       0.02 ± 34%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ±223%   +1840.0%       0.02 ± 23%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.00 ± 49%    +507.4%       0.03 ± 10%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ± 25%    +204.4%       0.02 ± 13%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      2.86 ±  2%     -11.2%       2.54 ±  2%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.02 ± 70%     -77.5%       0.00 ±  7%  perf-sched.total_sch_delay.average.ms
      9.11 ± 68%     -72.1%       2.54 ±  2%  perf-sched.total_sch_delay.max.ms
      0.64 ± 22%  +35705.1%     229.93 ±  6%  perf-sched.total_wait_and_delay.average.ms
    607.17 ± 16%    +970.0%       6496 ±  6%  perf-sched.total_wait_and_delay.count.ms
     14.55 ± 16%  +68571.9%       9993        perf-sched.total_wait_and_delay.max.ms
      0.62 ± 22%  +36944.6%     229.92 ±  6%  perf-sched.total_wait_time.average.ms
     13.56 ± 15%  +73578.5%       9993        perf-sched.total_wait_time.max.ms
      0.10 ±113%  +2.8e+05%     265.78 ±  4%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.04 ± 12%  +1.8e+05%      75.77 ±  2%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.09 ± 62%  +19218.8%      18.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      2.92 ± 12%    +702.1%      23.39 ± 38%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      2.07 ± 24%  +34144.2%     709.14        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      1.58 ±121%  +28865.6%     456.79 ±  3%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
      5.33 ± 41%   +4475.0%     244.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    264.17 ± 28%    +704.0%       2123 ±  2%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
    158.17 ± 14%    +567.8%       1056        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.17 ± 25%  +13852.0%     581.33 ± 84%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    158.00 ± 14%    +691.0%       1249        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
      4.83 ± 49%  +12186.2%     593.83 ±  2%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      0.31 ±119%  +7.6e+05%       2368 ± 60%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.95 ±113%  +1.1e+05%       1006        perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      6.92 ± 72%  +1.4e+05%       9993        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.98         +6280.0%     317.66 ± 26%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     13.34 ± 18%  +16218.6%       2176 ±120%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      5.25 ±102%  +1.7e+05%       8791 ±  5%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.21 ±223%    +498.7%       1.27 ± 10%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.10 ±114%  +2.8e+05%     265.77 ±  4%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.04 ± 12%  +1.9e+05%      75.77 ±  2%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.09 ± 62%  +19218.6%      18.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.96 ± 51%  +13556.5%     131.06 ± 65%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      2.91 ± 12%    +703.1%      23.38 ± 38%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      2.06 ± 24%  +34407.7%     709.13        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.80 ±223%  +57092.1%     456.77 ±  3%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      0.42 ±223%    +498.5%       2.54 ± 10%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.31 ±120%  +7.6e+05%       2368 ± 60%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.88 ±106%  +1.1e+05%       1006        perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      6.92 ± 72%  +1.4e+05%       9993        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      2.63 ± 51%  +15737.4%     416.97 ± 28%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      4.97         +6285.5%     317.65 ± 26%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     13.33 ± 18%  +16224.4%       2176 ±120%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      2.40 ±223%  +3.7e+05%       8791 ±  5%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
      3620 ±  6%     -55.1%       1626 ± 10%  slabinfo.Acpi-Parse.active_objs
      3620 ±  6%     -55.1%       1626 ± 10%  slabinfo.Acpi-Parse.num_objs
      1563           -83.7%     255.17 ± 18%  slabinfo.bdev_cache.active_objs
      1563           -83.7%     255.17 ± 18%  slabinfo.bdev_cache.num_objs
      2509 ±  7%     -43.5%       1418 ±  3%  slabinfo.buffer_head.active_objs
      2526 ±  7%     -42.8%       1445 ±  3%  slabinfo.buffer_head.num_objs
    101957           +10.7%     112908        slabinfo.dentry.active_objs
      2455           +10.3%       2707        slabinfo.dentry.active_slabs
    103132           +10.3%     113736        slabinfo.dentry.num_objs
      2455           +10.3%       2707        slabinfo.dentry.num_slabs
      3687 ±  4%     -13.6%       3187 ±  2%  slabinfo.dmaengine-unmap-16.active_objs
      3695 ±  5%     -13.7%       3188 ±  2%  slabinfo.dmaengine-unmap-16.num_objs
      2479 ±  3%     -91.9%     200.83 ± 11%  slabinfo.dquot.active_objs
      2479 ±  3%     -91.9%     200.83 ± 11%  slabinfo.dquot.num_objs
      5044 ± 15%     -66.2%       1702 ±  7%  slabinfo.ext4_extent_status.active_objs
      5044 ± 15%     -66.2%       1702 ±  7%  slabinfo.ext4_extent_status.num_objs
      2280 ±  5%     -45.3%       1247 ±  8%  slabinfo.file_lock_cache.active_objs
      2280 ±  5%     -45.3%       1247 ±  8%  slabinfo.file_lock_cache.num_objs
      6722 ±  7%     -46.9%       3567 ±  8%  slabinfo.fsnotify_mark_connector.active_objs
      6722 ±  7%     -46.9%       3567 ±  8%  slabinfo.fsnotify_mark_connector.num_objs
     76665           -10.2%      68851        slabinfo.inode_cache.active_objs
      1427           -10.4%       1279        slabinfo.inode_cache.active_slabs
     77097           -10.4%      69104        slabinfo.inode_cache.num_objs
      1427           -10.4%       1279        slabinfo.inode_cache.num_slabs
     99282           -14.2%      85192        slabinfo.kernfs_node_cache.active_objs
      3106           -14.3%       2661        slabinfo.kernfs_node_cache.active_slabs
     99425           -14.3%      85192        slabinfo.kernfs_node_cache.num_objs
      3106           -14.3%       2661        slabinfo.kernfs_node_cache.num_slabs
     45597           -19.8%      36570 ±  2%  slabinfo.kmalloc-16.num_objs
      7111           -19.7%       5710 ±  2%  slabinfo.kmalloc-192.num_objs
      6524            -8.8%       5949        slabinfo.kmalloc-1k.active_objs
      7525 ±  2%     -19.4%       6064 ±  2%  slabinfo.kmalloc-1k.num_objs
      8074            -9.1%       7340        slabinfo.kmalloc-2k.num_objs
      2245           -13.9%       1934        slabinfo.kmalloc-4k.num_objs
      6161           +26.4%       7788 ±  2%  slabinfo.kmalloc-96.active_objs
      7117           +11.3%       7921 ±  2%  slabinfo.kmalloc-96.num_objs
      3261           -84.0%     522.50 ± 18%  slabinfo.kmalloc-rcl-192.active_objs
      3261           -83.8%     529.17 ± 17%  slabinfo.kmalloc-rcl-192.num_objs
      5425 ±  2%     -11.5%       4802        slabinfo.kmalloc-rcl-512.active_objs
      5432 ±  2%     -11.6%       4802        slabinfo.kmalloc-rcl-512.num_objs
      6594 ±  6%     -23.4%       5049 ±  4%  slabinfo.kmalloc-rcl-64.active_objs
      6594 ±  6%     -23.4%       5049 ±  4%  slabinfo.kmalloc-rcl-64.num_objs
      2679 ±  5%     -13.0%       2330 ±  4%  slabinfo.kmalloc-rcl-96.active_objs
      2679 ±  5%     -13.0%       2330 ±  4%  slabinfo.kmalloc-rcl-96.num_objs
      6254           -76.7%       1459 ± 19%  slabinfo.mbcache.active_objs
      6254           -76.7%       1459 ± 19%  slabinfo.mbcache.num_objs
      1847 ±  7%     -18.7%       1501 ±  7%  slabinfo.pool_workqueue.active_objs
      1847 ±  7%     -18.7%       1501 ±  7%  slabinfo.pool_workqueue.num_objs
     13669           +11.3%      15221        slabinfo.proc_inode_cache.active_objs
     13669           +11.4%      15229        slabinfo.proc_inode_cache.num_objs
      1241           -88.1%     147.83 ± 23%  slabinfo.request_queue.active_objs
      1241           -88.1%     147.83 ± 23%  slabinfo.request_queue.num_objs
    536.50 ±  8%     -38.7%     328.83 ±  6%  slabinfo.skbuff_fclone_cache.active_objs
    536.50 ±  8%     -38.7%     328.83 ±  6%  slabinfo.skbuff_fclone_cache.num_objs
      4376 ±  4%      -9.2%       3974 ±  5%  slabinfo.skbuff_head_cache.active_objs
      4380 ±  4%      -9.2%       3979 ±  5%  slabinfo.skbuff_head_cache.num_objs
      1417            -9.5%       1283 ±  2%  slabinfo.task_struct.active_objs
      1421            -9.3%       1289 ±  2%  slabinfo.task_struct.active_slabs
      1421            -9.3%       1289 ±  2%  slabinfo.task_struct.num_objs
      1421            -9.3%       1289 ±  2%  slabinfo.task_struct.num_slabs
      4881 ±  4%     -22.0%       3805 ±  2%  slabinfo.trace_event_file.active_objs
      4881 ±  4%     -22.0%       3805 ±  2%  slabinfo.trace_event_file.num_objs
     11001           +47.7%      16252 ±  2%  slabinfo.vmap_area.active_objs
     11013           +48.4%      16346 ±  2%  slabinfo.vmap_area.num_objs
    130.67 ±  2%    +603.3%     919.00 ± 18%  interrupts.9:IO-APIC.9-fasteoi.acpi
     63882           +19.8%      76523 ±  5%  interrupts.CAL:Function_call_interrupts
    130205 ±  2%    +605.2%     918262 ± 18%  interrupts.CPU0.LOC:Local_timer_interrupts
    130.67 ±  2%    +603.3%     919.00 ± 18%  interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
    129768 ±  2%    +607.6%     918227 ± 18%  interrupts.CPU1.LOC:Local_timer_interrupts
    129809 ±  2%    +607.4%     918306 ± 18%  interrupts.CPU10.LOC:Local_timer_interrupts
    231.50 ± 26%     -50.1%     115.50 ± 29%  interrupts.CPU10.NMI:Non-maskable_interrupts
    231.50 ± 26%     -50.1%     115.50 ± 29%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
    129961 ±  2%    +606.5%     918153 ± 18%  interrupts.CPU11.LOC:Local_timer_interrupts
    129679 ±  2%    +608.1%     918235 ± 18%  interrupts.CPU12.LOC:Local_timer_interrupts
    129750 ±  2%    +607.7%     918201 ± 18%  interrupts.CPU13.LOC:Local_timer_interrupts
    129813 ±  2%    +607.4%     918271 ± 18%  interrupts.CPU14.LOC:Local_timer_interrupts
    129839 ±  2%    +607.2%     918158 ± 18%  interrupts.CPU15.LOC:Local_timer_interrupts
    130107 ±  2%    +605.7%     918148 ± 18%  interrupts.CPU16.LOC:Local_timer_interrupts
    201.67 ± 37%     -44.3%     112.33 ± 28%  interrupts.CPU16.NMI:Non-maskable_interrupts
    201.67 ± 37%     -44.3%     112.33 ± 28%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
    129746 ±  2%    +607.6%     918150 ± 18%  interrupts.CPU17.LOC:Local_timer_interrupts
    180.83 ± 21%     -32.1%     122.83 ± 14%  interrupts.CPU17.NMI:Non-maskable_interrupts
    180.83 ± 21%     -32.1%     122.83 ± 14%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
    129807 ±  2%    +607.4%     918216 ± 18%  interrupts.CPU18.LOC:Local_timer_interrupts
    129658 ±  2%    +608.1%     918137 ± 18%  interrupts.CPU19.LOC:Local_timer_interrupts
    130039 ±  2%    +606.1%     918169 ± 18%  interrupts.CPU2.LOC:Local_timer_interrupts
    129817 ±  2%    +607.3%     918152 ± 18%  interrupts.CPU20.LOC:Local_timer_interrupts
    129833 ±  2%    +607.2%     918126 ± 18%  interrupts.CPU21.LOC:Local_timer_interrupts
    212.17 ± 22%     -41.7%     123.67 ± 14%  interrupts.CPU21.NMI:Non-maskable_interrupts
    212.17 ± 22%     -41.7%     123.67 ± 14%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
    130043 ±  2%    +606.0%     918137 ± 18%  interrupts.CPU22.LOC:Local_timer_interrupts
    129779 ±  2%    +607.5%     918243 ± 18%  interrupts.CPU23.LOC:Local_timer_interrupts
    129704 ±  2%    +608.0%     918300 ± 18%  interrupts.CPU24.LOC:Local_timer_interrupts
    129760 ±  2%    +607.6%     918160 ± 18%  interrupts.CPU25.LOC:Local_timer_interrupts
    129929 ±  2%    +606.7%     918147 ± 18%  interrupts.CPU26.LOC:Local_timer_interrupts
    130089 ±  2%    +606.1%     918569 ± 18%  interrupts.CPU27.LOC:Local_timer_interrupts
    129924 ±  2%    +606.7%     918215 ± 18%  interrupts.CPU28.LOC:Local_timer_interrupts
    208.83 ± 28%     -48.4%     107.83 ± 20%  interrupts.CPU28.NMI:Non-maskable_interrupts
    208.83 ± 28%     -48.4%     107.83 ± 20%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
    130113 ±  2%    +605.7%     918249 ± 18%  interrupts.CPU29.LOC:Local_timer_interrupts
    237.17 ± 17%     -54.1%     108.83 ± 21%  interrupts.CPU29.NMI:Non-maskable_interrupts
    237.17 ± 17%     -54.1%     108.83 ± 21%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
    129811 ±  2%    +607.3%     918200 ± 18%  interrupts.CPU3.LOC:Local_timer_interrupts
    179.50 ± 22%     -35.8%     115.17 ± 28%  interrupts.CPU3.NMI:Non-maskable_interrupts
    179.50 ± 22%     -35.8%     115.17 ± 28%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    129720 ±  2%    +607.7%     918076 ± 18%  interrupts.CPU30.LOC:Local_timer_interrupts
    129820 ±  2%    +607.2%     918141 ± 18%  interrupts.CPU31.LOC:Local_timer_interrupts
    211.00 ± 39%     -48.9%     107.83 ± 20%  interrupts.CPU31.NMI:Non-maskable_interrupts
    211.00 ± 39%     -48.9%     107.83 ± 20%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
    129818 ±  2%    +607.2%     918137 ± 18%  interrupts.CPU32.LOC:Local_timer_interrupts
    129630 ±  2%    +608.3%     918129 ± 18%  interrupts.CPU33.LOC:Local_timer_interrupts
    271.00 ± 37%     -55.3%     121.17 ± 19%  interrupts.CPU33.NMI:Non-maskable_interrupts
    271.00 ± 37%     -55.3%     121.17 ± 19%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
    129914 ±  2%    +606.7%     918104 ± 18%  interrupts.CPU34.LOC:Local_timer_interrupts
    215.83 ± 28%     -48.6%     110.83 ± 30%  interrupts.CPU34.NMI:Non-maskable_interrupts
    215.83 ± 28%     -48.6%     110.83 ± 30%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    129965 ±  2%    +606.5%     918175 ± 18%  interrupts.CPU35.LOC:Local_timer_interrupts
    248.50 ± 32%     -51.7%     120.00 ± 40%  interrupts.CPU35.NMI:Non-maskable_interrupts
    248.50 ± 32%     -51.7%     120.00 ± 40%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
    129653 ±  2%    +608.2%     918185 ± 18%  interrupts.CPU36.LOC:Local_timer_interrupts
    211.50 ± 51%     -43.9%     118.67 ± 17%  interrupts.CPU36.NMI:Non-maskable_interrupts
    211.50 ± 51%     -43.9%     118.67 ± 17%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
    129872 ±  2%    +606.9%     918073 ± 18%  interrupts.CPU37.LOC:Local_timer_interrupts
    130036 ±  2%    +606.0%     918109 ± 18%  interrupts.CPU38.LOC:Local_timer_interrupts
    129772 ±  2%    +607.5%     918121 ± 18%  interrupts.CPU39.LOC:Local_timer_interrupts
    229.50 ± 18%     -46.3%     123.33 ± 16%  interrupts.CPU39.NMI:Non-maskable_interrupts
    229.50 ± 18%     -46.3%     123.33 ± 16%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
    129712 ±  2%    +607.8%     918166 ± 18%  interrupts.CPU4.LOC:Local_timer_interrupts
    129642 ±  2%    +608.2%     918097 ± 18%  interrupts.CPU40.LOC:Local_timer_interrupts
    129853 ±  2%    +607.1%     918180 ± 18%  interrupts.CPU41.LOC:Local_timer_interrupts
    129809 ±  2%    +607.3%     918146 ± 18%  interrupts.CPU42.LOC:Local_timer_interrupts
    229.67 ± 18%     -46.4%     123.00 ± 15%  interrupts.CPU42.NMI:Non-maskable_interrupts
    229.67 ± 18%     -46.4%     123.00 ± 15%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
    129837 ±  2%    +607.1%     918143 ± 18%  interrupts.CPU43.LOC:Local_timer_interrupts
    129909 ±  2%    +606.7%     918129 ± 18%  interrupts.CPU44.LOC:Local_timer_interrupts
    129605 ±  2%    +608.4%     918084 ± 18%  interrupts.CPU45.LOC:Local_timer_interrupts
    129749 ±  2%    +607.6%     918143 ± 18%  interrupts.CPU46.LOC:Local_timer_interrupts
    129735 ±  2%    +607.8%     918262 ± 18%  interrupts.CPU47.LOC:Local_timer_interrupts
    192.00 ± 36%     -41.6%     112.17 ± 31%  interrupts.CPU47.NMI:Non-maskable_interrupts
    192.00 ± 36%     -41.6%     112.17 ± 31%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
    692.33 ± 14%     -17.9%     568.17 ± 12%  interrupts.CPU48.CAL:Function_call_interrupts
    130023 ±  2%    +606.1%     918092 ± 18%  interrupts.CPU48.LOC:Local_timer_interrupts
    129752 ±  2%    +607.6%     918126 ± 18%  interrupts.CPU49.LOC:Local_timer_interrupts
    129983 ±  2%    +606.4%     918178 ± 18%  interrupts.CPU5.LOC:Local_timer_interrupts
    129727 ±  2%    +607.8%     918247 ± 18%  interrupts.CPU50.LOC:Local_timer_interrupts
    712.33 ± 12%     -15.1%     604.50        interrupts.CPU51.CAL:Function_call_interrupts
    130043 ±  2%    +606.1%     918209 ± 18%  interrupts.CPU51.LOC:Local_timer_interrupts
    186.17 ± 19%     -44.2%     103.83 ± 36%  interrupts.CPU51.NMI:Non-maskable_interrupts
    186.17 ± 19%     -44.2%     103.83 ± 36%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
    129948 ±  2%    +606.6%     918175 ± 18%  interrupts.CPU52.LOC:Local_timer_interrupts
    129691 ±  2%    +608.0%     918219 ± 18%  interrupts.CPU53.LOC:Local_timer_interrupts
    129788 ±  2%    +607.4%     918157 ± 18%  interrupts.CPU54.LOC:Local_timer_interrupts
    129762 ±  2%    +607.6%     918216 ± 18%  interrupts.CPU55.LOC:Local_timer_interrupts
    129912 ±  2%    +606.8%     918157 ± 18%  interrupts.CPU56.LOC:Local_timer_interrupts
    198.33 ± 20%     -47.7%     103.67 ± 34%  interrupts.CPU56.NMI:Non-maskable_interrupts
    198.33 ± 20%     -47.7%     103.67 ± 34%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
    129876 ±  2%    +607.0%     918166 ± 18%  interrupts.CPU57.LOC:Local_timer_interrupts
    130047 ±  2%    +606.1%     918203 ± 18%  interrupts.CPU58.LOC:Local_timer_interrupts
    200.50 ± 28%     -43.1%     114.00 ± 27%  interrupts.CPU58.NMI:Non-maskable_interrupts
    200.50 ± 28%     -43.1%     114.00 ± 27%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
    129733 ±  2%    +607.8%     918265 ± 18%  interrupts.CPU59.LOC:Local_timer_interrupts
    227.67 ± 31%     -50.9%     111.83 ± 29%  interrupts.CPU59.NMI:Non-maskable_interrupts
    227.67 ± 31%     -50.9%     111.83 ± 29%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
    129820 ±  2%    +607.3%     918176 ± 18%  interrupts.CPU6.LOC:Local_timer_interrupts
    129865 ±  2%    +607.0%     918129 ± 18%  interrupts.CPU60.LOC:Local_timer_interrupts
    130055 ±  2%    +606.0%     918166 ± 18%  interrupts.CPU61.LOC:Local_timer_interrupts
    130068 ±  2%    +606.0%     918225 ± 18%  interrupts.CPU62.LOC:Local_timer_interrupts
    129969 ±  2%    +606.5%     918211 ± 18%  interrupts.CPU63.LOC:Local_timer_interrupts
    129777 ±  2%    +607.6%     918348 ± 18%  interrupts.CPU64.LOC:Local_timer_interrupts
    130112 ±  2%    +605.6%     918129 ± 18%  interrupts.CPU65.LOC:Local_timer_interrupts
    189.50 ± 18%     -52.5%      90.00 ± 37%  interrupts.CPU65.NMI:Non-maskable_interrupts
    189.50 ± 18%     -52.5%      90.00 ± 37%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
    691.17 ± 14%     -13.1%     600.33        interrupts.CPU66.CAL:Function_call_interrupts
    129784 ±  2%    +607.6%     918338 ± 18%  interrupts.CPU66.LOC:Local_timer_interrupts
    129998 ±  2%    +606.3%     918232 ± 18%  interrupts.CPU67.LOC:Local_timer_interrupts
    129843 ±  2%    +607.4%     918473 ± 18%  interrupts.CPU68.LOC:Local_timer_interrupts
    130013 ±  2%    +606.2%     918188 ± 18%  interrupts.CPU69.LOC:Local_timer_interrupts
    200.17 ± 30%     -50.8%      98.50 ± 43%  interrupts.CPU69.NMI:Non-maskable_interrupts
    200.17 ± 30%     -50.8%      98.50 ± 43%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
    129906 ±  2%    +606.8%     918171 ± 18%  interrupts.CPU7.LOC:Local_timer_interrupts
    129911 ±  2%    +606.9%     918285 ± 18%  interrupts.CPU70.LOC:Local_timer_interrupts
    130068 ±  2%    +605.9%     918182 ± 18%  interrupts.CPU71.LOC:Local_timer_interrupts
    191.33 ± 33%     -51.3%      93.17 ± 48%  interrupts.CPU71.NMI:Non-maskable_interrupts
    191.33 ± 33%     -51.3%      93.17 ± 48%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
    130115 ±  2%    +605.8%     918315 ± 18%  interrupts.CPU72.LOC:Local_timer_interrupts
    190.50 ± 33%     -55.4%      85.00 ± 45%  interrupts.CPU72.NMI:Non-maskable_interrupts
    190.50 ± 33%     -55.4%      85.00 ± 45%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
    129715 ±  2%    +607.8%     918137 ± 18%  interrupts.CPU73.LOC:Local_timer_interrupts
    191.33 ± 35%     -63.1%      70.67 ± 49%  interrupts.CPU73.NMI:Non-maskable_interrupts
    191.33 ± 35%     -63.1%      70.67 ± 49%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
    129851 ±  2%    +607.1%     918129 ± 18%  interrupts.CPU74.LOC:Local_timer_interrupts
    129791 ±  2%    +607.4%     918208 ± 18%  interrupts.CPU75.LOC:Local_timer_interrupts
    176.00 ± 43%     -51.5%      85.33 ± 50%  interrupts.CPU75.NMI:Non-maskable_interrupts
    176.00 ± 43%     -51.5%      85.33 ± 50%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
    129736 ±  2%    +607.7%     918200 ± 18%  interrupts.CPU76.LOC:Local_timer_interrupts
    231.00 ± 37%     -62.9%      85.67 ± 51%  interrupts.CPU76.NMI:Non-maskable_interrupts
    231.00 ± 37%     -62.9%      85.67 ± 51%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
    129718 ±  2%    +607.8%     918150 ± 18%  interrupts.CPU77.LOC:Local_timer_interrupts
    238.83 ± 19%     -60.0%      95.50 ± 47%  interrupts.CPU77.NMI:Non-maskable_interrupts
    238.83 ± 19%     -60.0%      95.50 ± 47%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
    129718 ±  2%    +607.9%     918239 ± 18%  interrupts.CPU78.LOC:Local_timer_interrupts
    196.00 ± 27%     -56.0%      86.33 ± 52%  interrupts.CPU78.NMI:Non-maskable_interrupts
    196.00 ± 27%     -56.0%      86.33 ± 52%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
    129804 ±  2%    +607.3%     918154 ± 18%  interrupts.CPU79.LOC:Local_timer_interrupts
    130013 ±  2%    +606.3%     918220 ± 18%  interrupts.CPU8.LOC:Local_timer_interrupts
    220.67 ±  7%     -38.8%     135.00 ± 25%  interrupts.CPU8.NMI:Non-maskable_interrupts
    220.67 ±  7%     -38.8%     135.00 ± 25%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    129665 ±  2%    +608.1%     918223 ± 18%  interrupts.CPU80.LOC:Local_timer_interrupts
    129836 ±  2%    +607.3%     918391 ± 18%  interrupts.CPU81.LOC:Local_timer_interrupts
    258.17 ± 38%     -62.2%      97.67 ± 51%  interrupts.CPU81.NMI:Non-maskable_interrupts
    258.17 ± 38%     -62.2%      97.67 ± 51%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
    129706 ±  2%    +607.9%     918130 ± 18%  interrupts.CPU82.LOC:Local_timer_interrupts
    129821 ±  2%    +607.4%     918412 ± 18%  interrupts.CPU83.LOC:Local_timer_interrupts
    248.00 ± 29%     -57.9%     104.50 ± 59%  interrupts.CPU83.NMI:Non-maskable_interrupts
    248.00 ± 29%     -57.9%     104.50 ± 59%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
    129799 ±  2%    +607.4%     918206 ± 18%  interrupts.CPU84.LOC:Local_timer_interrupts
    130074 ±  2%    +605.9%     918158 ± 18%  interrupts.CPU85.LOC:Local_timer_interrupts
    217.67 ± 32%     -58.3%      90.83 ± 36%  interrupts.CPU85.NMI:Non-maskable_interrupts
    217.67 ± 32%     -58.3%      90.83 ± 36%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
    130033 ±  2%    +606.2%     918269 ± 18%  interrupts.CPU86.LOC:Local_timer_interrupts
    129953 ±  2%    +606.6%     918233 ± 18%  interrupts.CPU87.LOC:Local_timer_interrupts
    207.00 ± 22%     -45.3%     113.17 ± 28%  interrupts.CPU87.NMI:Non-maskable_interrupts
    207.00 ± 22%     -45.3%     113.17 ± 28%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
    129884 ±  2%    +607.0%     918226 ± 18%  interrupts.CPU88.LOC:Local_timer_interrupts
    268.00 ± 29%     -60.8%     105.00 ± 40%  interrupts.CPU88.NMI:Non-maskable_interrupts
    268.00 ± 29%     -60.8%     105.00 ± 40%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
    129693 ±  2%    +607.9%     918113 ± 18%  interrupts.CPU89.LOC:Local_timer_interrupts
    129901 ±  2%    +606.9%     918318 ± 18%  interrupts.CPU9.LOC:Local_timer_interrupts
    229.67 ± 27%     -51.0%     112.50 ± 27%  interrupts.CPU9.NMI:Non-maskable_interrupts
    229.67 ± 27%     -51.0%     112.50 ± 27%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    129994 ±  2%    +606.4%     918251 ± 18%  interrupts.CPU90.LOC:Local_timer_interrupts
    129941 ±  2%    +606.5%     918072 ± 18%  interrupts.CPU91.LOC:Local_timer_interrupts
    129710 ±  2%    +607.8%     918131 ± 18%  interrupts.CPU92.LOC:Local_timer_interrupts
    668.33 ±  5%     -10.8%     596.17        interrupts.CPU93.CAL:Function_call_interrupts
    129951 ±  2%    +606.6%     918176 ± 18%  interrupts.CPU93.LOC:Local_timer_interrupts
    129873 ±  2%    +606.9%     918117 ± 18%  interrupts.CPU94.LOC:Local_timer_interrupts
    129755 ±  2%    +607.6%     918133 ± 18%  interrupts.CPU95.LOC:Local_timer_interrupts
    188.33 ± 31%     -53.5%      87.67 ± 57%  interrupts.CPU95.NMI:Non-maskable_interrupts
    188.33 ± 31%     -53.5%      87.67 ± 57%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
     20.83 ±  6%    +110.4%      43.83 ± 75%  interrupts.CPU95.TLB:TLB_shootdowns
  12466595 ±  2%    +607.1%   88146744 ± 18%  interrupts.LOC:Local_timer_interrupts
     18867 ±  3%     -44.1%      10549 ± 24%  interrupts.NMI:Non-maskable_interrupts
     18867 ±  3%     -44.1%      10549 ± 24%  interrupts.PMI:Performance_monitoring_interrupts
     19145 ±  3%     -70.7%       5607 ± 15%  softirqs.BLOCK
     11175 ± 14%    +104.8%      22886 ± 24%  softirqs.CPU0.RCU
     10931 ± 14%    +433.1%      58276 ± 16%  softirqs.CPU0.SCHED
      9814 ± 17%    +121.6%      21747 ± 24%  softirqs.CPU1.RCU
      9403 ±  5%    +511.5%      57504 ± 15%  softirqs.CPU1.SCHED
      8834 ±  4%    +130.4%      20353 ± 23%  softirqs.CPU10.RCU
      8184 ±  8%    +587.9%      56299 ± 18%  softirqs.CPU10.SCHED
      8683 ±  8%    +134.3%      20349 ± 22%  softirqs.CPU11.RCU
      9062 ±  6%    +485.5%      53058 ± 18%  softirqs.CPU11.SCHED
      8791 ± 10%    +131.7%      20369 ± 23%  softirqs.CPU12.RCU
      8415 ±  7%    +544.1%      54201 ± 18%  softirqs.CPU12.SCHED
      8447 ±  3%    +140.7%      20331 ± 22%  softirqs.CPU13.RCU
      8588 ±  6%    +546.8%      55556 ± 17%  softirqs.CPU13.SCHED
      8591 ±  4%    +137.0%      20360 ± 25%  softirqs.CPU14.RCU
      8106 ±  9%    +585.3%      55554 ± 18%  softirqs.CPU14.SCHED
      9257 ± 16%    +120.0%      20369 ± 23%  softirqs.CPU15.RCU
      8212 ± 10%    +581.9%      55998 ± 17%  softirqs.CPU15.SCHED
      8190 ±  2%    +150.9%      20545 ± 21%  softirqs.CPU16.RCU
      8988 ±  2%    +526.0%      56269 ± 17%  softirqs.CPU16.SCHED
      8548 ±  9%    +143.5%      20818 ± 20%  softirqs.CPU17.RCU
      8558 ±  7%    +517.1%      52817 ± 28%  softirqs.CPU17.SCHED
      9188 ± 17%    +111.0%      19391 ± 21%  softirqs.CPU18.RCU
      8898 ±  9%    +527.0%      55799 ± 17%  softirqs.CPU18.SCHED
      8336 ±  3%    +146.7%      20563 ± 21%  softirqs.CPU19.RCU
      8822 ±  9%    +532.3%      55785 ± 17%  softirqs.CPU19.SCHED
      8926 ±  7%    +131.7%      20684 ± 21%  softirqs.CPU2.RCU
      8473 ±  9%    +508.6%      51573 ± 22%  softirqs.CPU2.SCHED
      9135 ± 19%    +124.6%      20513 ± 21%  softirqs.CPU20.RCU
      8369 ± 14%    +566.8%      55802 ± 17%  softirqs.CPU20.SCHED
      8300 ±  2%    +152.7%      20977 ± 17%  softirqs.CPU21.RCU
      8736 ±  6%    +538.6%      55791 ± 17%  softirqs.CPU21.SCHED
      8330 ±  4%    +144.0%      20324 ± 20%  softirqs.CPU22.RCU
      8457 ± 12%    +562.6%      56038 ± 18%  softirqs.CPU22.SCHED
      8638 ±  3%    +140.3%      20761 ± 21%  softirqs.CPU23.RCU
      8214 ± 22%    +579.3%      55797 ± 17%  softirqs.CPU23.SCHED
      8514 ±  4%    +148.2%      21136 ± 22%  softirqs.CPU24.RCU
      8571 ± 10%    +552.1%      55898 ± 18%  softirqs.CPU24.SCHED
      8185 ±  3%    +148.1%      20310 ± 22%  softirqs.CPU25.RCU
      8150 ± 12%    +552.0%      53142 ± 17%  softirqs.CPU25.SCHED
      8319 ±  3%    +144.3%      20322 ± 22%  softirqs.CPU26.RCU
      8827 ± 11%    +527.1%      55356 ± 17%  softirqs.CPU26.SCHED
      8325 ±  4%    +145.5%      20438 ± 22%  softirqs.CPU27.RCU
      8135 ± 22%    +580.6%      55362 ± 17%  softirqs.CPU27.SCHED
      8278 ±  3%    +147.8%      20513 ± 21%  softirqs.CPU28.RCU
      8718 ±  7%    +546.5%      56363 ± 19%  softirqs.CPU28.SCHED
      8329 ±  3%    +147.8%      20643 ± 22%  softirqs.CPU29.RCU
      8940 ±  6%    +469.2%      50889 ± 23%  softirqs.CPU29.SCHED
      8607 ±  5%    +136.8%      20379 ± 23%  softirqs.CPU3.RCU
      8101 ± 18%    +588.5%      55771 ± 17%  softirqs.CPU3.SCHED
      8376 ±  5%    +143.4%      20383 ± 22%  softirqs.CPU30.RCU
      7887 ± 17%    +546.4%      50988 ± 22%  softirqs.CPU30.SCHED
      8460 ±  7%    +135.8%      19952 ± 22%  softirqs.CPU31.RCU
      8584 ±  6%    +542.7%      55169 ± 18%  softirqs.CPU31.SCHED
      8869 ±  9%    +134.6%      20807 ± 23%  softirqs.CPU32.RCU
      8582 ± 19%    +543.5%      55232 ± 18%  softirqs.CPU32.SCHED
      8928 ±  5%    +132.4%      20748 ± 22%  softirqs.CPU33.RCU
      8457 ±  5%    +553.0%      55232 ± 18%  softirqs.CPU33.SCHED
      9426 ± 10%    +122.5%      20972 ± 22%  softirqs.CPU34.RCU
      7906 ±  9%    +598.4%      55216 ± 17%  softirqs.CPU34.SCHED
      9106 ±  6%    +131.0%      21039 ± 23%  softirqs.CPU35.RCU
      8816 ±  6%    +525.0%      55101 ± 18%  softirqs.CPU35.SCHED
      8727 ±  5%    +138.0%      20774 ± 24%  softirqs.CPU36.RCU
      8171 ± 12%    +520.1%      50674 ± 23%  softirqs.CPU36.SCHED
      8639 ±  4%    +143.0%      20994 ± 23%  softirqs.CPU37.RCU
      8867 ±  3%    +469.6%      50508 ± 23%  softirqs.CPU37.SCHED
      8578 ±  5%    +142.5%      20806 ± 22%  softirqs.CPU38.RCU
      9056          +476.2%      52184 ± 28%  softirqs.CPU38.SCHED
      8737 ±  6%    +139.1%      20890 ± 22%  softirqs.CPU39.RCU
      9217 ±  2%    +476.9%      53172 ± 24%  softirqs.CPU39.SCHED
      8329 ±  9%    +137.7%      19798 ± 28%  softirqs.CPU4.RCU
      8510 ±  8%    +544.7%      54860 ± 20%  softirqs.CPU4.SCHED
      8974 ±  8%    +138.4%      21393 ± 21%  softirqs.CPU40.RCU
      7294 ± 18%    +659.8%      55422 ± 17%  softirqs.CPU40.SCHED
      8877 ±  8%    +137.3%      21064 ± 22%  softirqs.CPU41.RCU
      8739 ±  4%    +501.2%      52540 ± 28%  softirqs.CPU41.SCHED
      8672 ±  7%    +138.2%      20654 ± 21%  softirqs.CPU42.RCU
      7964 ± 10%    +591.8%      55101 ± 17%  softirqs.CPU42.SCHED
      8918 ±  8%    +134.6%      20923 ± 21%  softirqs.CPU43.RCU
      8468 ±  9%    +550.8%      55111 ± 17%  softirqs.CPU43.SCHED
      8606 ±  9%    +141.0%      20741 ± 21%  softirqs.CPU44.RCU
      8285 ± 13%    +565.0%      55094 ± 17%  softirqs.CPU44.SCHED
      8685 ±  8%    +141.2%      20946 ± 22%  softirqs.CPU45.RCU
      9083          +505.6%      55004 ± 17%  softirqs.CPU45.SCHED
      8732 ±  8%    +137.6%      20750 ± 22%  softirqs.CPU46.RCU
      8562 ±  8%    +545.8%      55296 ± 17%  softirqs.CPU46.SCHED
      8970 ±  7%    +145.0%      21978 ± 22%  softirqs.CPU47.RCU
      9064 ±  2%    +227.5%      29687 ± 61%  softirqs.CPU47.SCHED
      8288 ±  3%    +156.3%      21242 ± 26%  softirqs.CPU48.RCU
      7591 ± 24%    +382.2%      36604 ± 44%  softirqs.CPU48.SCHED
      8450 ±  6%    +137.9%      20104 ± 25%  softirqs.CPU49.RCU
      8107 ± 18%    +606.5%      57274 ± 17%  softirqs.CPU49.SCHED
      8474 ±  4%    +139.7%      20310 ± 22%  softirqs.CPU5.RCU
      8404 ± 15%    +568.5%      56185 ± 17%  softirqs.CPU5.SCHED
      8253 ±  6%    +141.7%      19947 ± 22%  softirqs.CPU50.RCU
      8581 ±  3%    +506.4%      52041 ± 22%  softirqs.CPU50.SCHED
      9540 ± 19%    +112.8%      20304 ± 23%  softirqs.CPU51.RCU
      7495 ± 21%    +663.3%      57211 ± 17%  softirqs.CPU51.SCHED
      8396 ±  7%    +145.1%      20577 ± 24%  softirqs.CPU52.RCU
      8705 ± 10%    +452.9%      48130 ± 24%  softirqs.CPU52.SCHED
      8294 ±  3%    +146.9%      20480 ± 22%  softirqs.CPU53.RCU
      9382 ±  4%    +439.0%      50573 ± 31%  softirqs.CPU53.SCHED
      8772 ±  7%    +135.4%      20653 ± 21%  softirqs.CPU54.RCU
      8818 ±  8%    +499.1%      52833 ± 22%  softirqs.CPU54.SCHED
      8658 ±  5%    +128.7%      19801 ± 23%  softirqs.CPU55.RCU
      7268 ± 18%    +681.8%      56826 ± 17%  softirqs.CPU55.SCHED
      8153 ±  5%    +145.6%      20027 ± 21%  softirqs.CPU56.RCU
      8284 ±  7%    +559.8%      54661 ± 25%  softirqs.CPU56.SCHED
      8338 ±  7%    +141.8%      20164 ± 22%  softirqs.CPU57.RCU
      9493 ±  5%    +503.8%      57318 ± 17%  softirqs.CPU57.SCHED
      8497 ±  6%    +137.9%      20210 ± 23%  softirqs.CPU58.RCU
      9041 ±  8%    +533.7%      57298 ± 17%  softirqs.CPU58.SCHED
      8451 ±  6%    +140.7%      20340 ± 23%  softirqs.CPU59.RCU
      8112 ± 12%    +610.3%      57622 ± 17%  softirqs.CPU59.SCHED
      8981 ±  6%    +121.6%      19900 ± 28%  softirqs.CPU6.RCU
      8239 ± 14%    +576.4%      55728 ± 17%  softirqs.CPU6.SCHED
      8278 ±  5%    +142.7%      20090 ± 23%  softirqs.CPU60.RCU
      8934 ± 10%    +540.1%      57190 ± 17%  softirqs.CPU60.SCHED
      8126 ±  5%    +144.2%      19843 ± 23%  softirqs.CPU61.RCU
      8236 ± 12%    +532.2%      52069 ± 23%  softirqs.CPU61.SCHED
      8127 ±  4%    +141.7%      19640 ± 23%  softirqs.CPU62.RCU
      8282 ± 13%    +582.6%      56541 ± 17%  softirqs.CPU62.SCHED
      8496 ±  5%    +134.4%      19918 ± 24%  softirqs.CPU63.RCU
      7647 ± 19%    +642.6%      56793 ± 18%  softirqs.CPU63.SCHED
      7950 ±  3%    +148.2%      19731 ± 25%  softirqs.CPU64.RCU
      8853 ±  9%    +560.7%      58491 ± 19%  softirqs.CPU64.SCHED
      8030 ±  6%    +162.1%      21044 ± 20%  softirqs.CPU65.RCU
      7387 ± 21%    +599.0%      51641 ± 26%  softirqs.CPU65.SCHED
      8410 ±  5%    +146.6%      20740 ± 21%  softirqs.CPU66.RCU
      7111 ± 25%    +708.2%      57476 ± 17%  softirqs.CPU66.SCHED
      8307 ±  6%    +130.6%      19157 ± 27%  softirqs.CPU67.RCU
      7607 ± 20%    +648.7%      56958 ± 17%  softirqs.CPU67.SCHED
      8596 ±  6%    +136.7%      20344 ± 21%  softirqs.CPU68.RCU
      7018 ± 18%    +721.4%      57646 ± 17%  softirqs.CPU68.SCHED
      7862 ±  4%    +161.6%      20571 ± 21%  softirqs.CPU69.RCU
      8966 ±  4%    +495.4%      53385 ± 24%  softirqs.CPU69.SCHED
      8841 ±  6%    +132.3%      20542 ± 21%  softirqs.CPU7.RCU
      8643 ±  5%    +547.3%      55948 ± 17%  softirqs.CPU7.SCHED
      8159 ±  2%    +154.4%      20758 ± 20%  softirqs.CPU70.RCU
      8672 ±  9%    +527.0%      54379 ± 33%  softirqs.CPU70.SCHED
      8174          +154.7%      20820 ± 22%  softirqs.CPU71.RCU
      7791 ± 17%    +575.7%      52641 ± 21%  softirqs.CPU71.SCHED
      8178 ±  3%    +161.3%      21368 ± 17%  softirqs.CPU72.RCU
      9215 ±  3%    +501.0%      55387 ± 24%  softirqs.CPU72.SCHED
      8152 ±  8%    +143.9%      19888 ± 22%  softirqs.CPU73.RCU
      8220 ±  5%    +535.5%      52236 ± 23%  softirqs.CPU73.SCHED
      7866 ±  3%    +155.3%      20084 ± 22%  softirqs.CPU74.RCU
      8635 ±  6%    +526.1%      54069 ± 28%  softirqs.CPU74.SCHED
      7902 ±  5%    +151.2%      19853 ± 18%  softirqs.CPU75.RCU
      8882 ±  8%    +544.6%      57255 ± 17%  softirqs.CPU75.SCHED
      7970 ±  4%    +148.9%      19837 ± 21%  softirqs.CPU76.RCU
      8922 ±  9%    +542.1%      57294 ± 17%  softirqs.CPU76.SCHED
      8052 ±  5%    +154.1%      20458 ± 22%  softirqs.CPU77.RCU
      8645 ±  5%    +565.2%      57506 ± 17%  softirqs.CPU77.SCHED
      8108 ±  5%    +150.9%      20346 ± 22%  softirqs.CPU78.RCU
      7930 ± 18%    +623.2%      57347 ± 17%  softirqs.CPU78.SCHED
      8107 ±  4%    +150.2%      20284 ± 23%  softirqs.CPU79.RCU
      7219 ± 16%    +688.6%      56928 ± 18%  softirqs.CPU79.SCHED
      8585 ±  4%    +136.0%      20264 ± 21%  softirqs.CPU8.RCU
      8973 ±  3%    +519.7%      55608 ± 17%  softirqs.CPU8.SCHED
      8426 ±  9%    +133.0%      19633 ± 23%  softirqs.CPU80.RCU
      8670 ± 11%    +558.0%      57051 ± 17%  softirqs.CPU80.SCHED
      8484 ±  7%    +135.2%      19957 ± 23%  softirqs.CPU81.RCU
      8310 ±  8%    +586.4%      57041 ± 17%  softirqs.CPU81.SCHED
      8504 ±  8%    +139.7%      20381 ± 21%  softirqs.CPU82.RCU
      8552 ± 11%    +567.8%      57112 ± 17%  softirqs.CPU82.SCHED
      8563 ±  7%    +135.4%      20153 ± 23%  softirqs.CPU83.RCU
      8273 ± 15%    +533.2%      52388 ± 23%  softirqs.CPU83.SCHED
      8629 ±  6%    +129.5%      19802 ± 23%  softirqs.CPU84.RCU
      7551 ± 22%    +663.9%      57682 ± 15%  softirqs.CPU84.SCHED
      8656 ±  6%    +130.1%      19913 ± 23%  softirqs.CPU85.RCU
      7092 ± 16%    +703.8%      57005 ± 17%  softirqs.CPU85.SCHED
      8408 ±  7%    +114.6%      18042 ± 26%  softirqs.CPU86.RCU
      7370 ± 24%    +675.5%      57157 ± 17%  softirqs.CPU86.SCHED
      8420 ±  6%    +133.0%      19617 ± 22%  softirqs.CPU87.RCU
      8399 ± 14%    +575.6%      56744 ± 17%  softirqs.CPU87.SCHED
      8655 ±  8%    +132.5%      20125 ± 23%  softirqs.CPU88.RCU
      8868 ±  5%    +502.5%      53433 ± 20%  softirqs.CPU88.SCHED
      8533 ±  6%    +128.2%      19477 ± 28%  softirqs.CPU89.RCU
      9111 ±  5%    +529.4%      57344 ± 17%  softirqs.CPU89.SCHED
      8711 ±  4%    +134.9%      20467 ± 22%  softirqs.CPU9.RCU
      7848 ± 19%    +609.3%      55666 ± 17%  softirqs.CPU9.SCHED
      8386 ±  7%    +130.9%      19363 ± 24%  softirqs.CPU90.RCU
      7657 ± 17%    +634.1%      56215 ± 18%  softirqs.CPU90.SCHED
      8616 ± 10%    +124.5%      19342 ± 28%  softirqs.CPU91.RCU
      8592 ± 10%    +562.5%      56928 ± 17%  softirqs.CPU91.SCHED
      8381 ±  7%    +129.5%      19231 ± 23%  softirqs.CPU92.RCU
      8386 ± 13%    +574.5%      56566 ± 18%  softirqs.CPU92.SCHED
      8362 ± 11%    +134.8%      19633 ± 23%  softirqs.CPU93.RCU
      8893 ±  9%    +540.7%      56981 ± 17%  softirqs.CPU93.SCHED
      8595 ±  6%    +133.0%      20026 ± 23%  softirqs.CPU94.RCU
      8231 ± 13%    +596.8%      57360 ± 17%  softirqs.CPU94.SCHED
      8974 ±  8%    +138.7%      21420 ± 22%  softirqs.CPU95.RCU
      8231 ±  9%    +408.0%      41821 ± 40%  softirqs.CPU95.SCHED
      1478 ± 64%    +914.6%      15001 ± 52%  softirqs.NET_RX
    821537 ±  4%    +138.2%    1956977 ± 22%  softirqs.RCU
    808773 ±  2%    +548.7%    5246138 ± 17%  softirqs.SCHED
     17352 ±  2%     +74.5%      30278 ± 17%  softirqs.TIMER
     18.64 ±  4%     -18.6        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     16.75 ±  5%     -16.7        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.99 ±  3%     -14.0        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.59 ±  8%     -11.6        0.00        perf-profile.calltrace.cycles-pp.ret_from_fork
     11.58 ±  8%     -11.6        0.00        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
     11.22 ±  8%     -11.2        0.00        perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
     11.17 ±  8%     -11.2        0.00        perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
     10.70 ±  8%     -10.7        0.00        perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
     10.34 ±  8%     -10.3        0.00        perf-profile.calltrace.cycles-pp.memcpy_toio.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
     10.30 ±  3%     -10.3        0.00        perf-profile.calltrace.cycles-pp.block_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.30 ±  3%     -10.3        0.00        perf-profile.calltrace.cycles-pp.blkdev_ioctl.block_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.26 ±  3%     -10.3        0.00        perf-profile.calltrace.cycles-pp.lo_ioctl.blkdev_ioctl.block_ioctl.__x64_sys_ioctl.do_syscall_64
      8.23 ±  6%      -8.2        0.00        perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.printk.set_capacity_and_notify.cold.loop_set_size
      7.66 ±  6%      -7.7        0.00        perf-profile.calltrace.cycles-pp.serial8250_console_write.console_unlock.vprintk_emit.printk.set_capacity_and_notify.cold
      7.29 ±  6%      -6.9        0.37 ± 70%  perf-profile.calltrace.cycles-pp.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit.printk
      6.78 ±  5%      -6.4        0.36 ± 71%  perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock
      6.78 ±  5%      -6.4        0.36 ± 71%  perf-profile.calltrace.cycles-pp.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit
      5.40 ±  5%      -5.3        0.09 ±223%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write
      5.17 ±  9%      -5.2        0.00        perf-profile.calltrace.cycles-pp.loop_configure.lo_ioctl.blkdev_ioctl.block_ioctl.__x64_sys_ioctl
      5.13 ±  9%      -5.1        0.00        perf-profile.calltrace.cycles-pp.printk.set_capacity_and_notify.cold.loop_set_size.loop_configure.lo_ioctl
      5.13 ±  9%      -5.1        0.00        perf-profile.calltrace.cycles-pp.vprintk_emit.printk.set_capacity_and_notify.cold.loop_set_size.loop_configure
      5.13 ±  9%      -5.1        0.00        perf-profile.calltrace.cycles-pp.loop_set_size.loop_configure.lo_ioctl.blkdev_ioctl.block_ioctl
      5.13 ±  9%      -5.1        0.00        perf-profile.calltrace.cycles-pp.set_capacity_and_notify.cold.loop_set_size.loop_configure.lo_ioctl.blkdev_ioctl
      0.76 ± 11%      +0.5        1.25 ± 15%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.70 ± 45%      +0.5        1.22 ±  4%  perf-profile.calltrace.cycles-pp.ktime_get.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.72 ± 45%      +0.5        1.25 ±  4%  perf-profile.calltrace.cycles-pp.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.79 ± 12%      +0.6        1.38 ± 11%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.69 ± 17%      +0.6        1.31 ± 15%  perf-profile.calltrace.cycles-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.17 ±141%      +0.7        0.82 ± 14%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.95 ± 18%      +0.7        1.63 ± 14%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.49 ± 81%      +0.7        1.18 ±  5%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.49 ± 81%      +0.7        1.18 ±  5%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.49 ± 81%      +0.7        1.18 ±  5%  perf-profile.calltrace.cycles-pp.start_kernel.secondary_startup_64_no_verify
      0.40 ± 71%      +0.7        1.11 ± 13%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.99 ± 16%      +0.7        1.71 ± 13%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.7        0.73 ± 18%  perf-profile.calltrace.cycles-pp.calc_global_load_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      1.75 ± 10%      +0.8        2.57 ± 14%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.07 ±  8%      +0.9        1.95 ±  9%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.72 ±  8%      +0.9        1.64 ± 17%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.24 ± 10%      +1.2        3.40 ± 13%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      2.09 ±  8%      +1.5        3.60 ± 10%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      2.16 ±  8%      +1.5        3.71 ±  9%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.86 ± 46%      +1.6        2.48 ± 13%  perf-profile.calltrace.cycles-pp.timekeeping_max_deferment.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle
      1.72 ± 11%      +1.9        3.59 ± 12%  perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      2.52 ±  7%      +2.0        4.50 ±  9%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.68 ± 12%      +2.3        3.96 ±  8%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      2.59 ±  9%      +2.5        5.08 ± 11%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.08 ±  9%      +2.5        4.62 ±  8%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      3.85 ±  6%      +2.9        6.77 ±  9%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      7.69 ±  4%      +6.3       14.01 ± 10%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      7.83 ±  4%      +6.4       14.22 ±  9%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
     12.42 ±  5%      +9.0       21.41 ± 10%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      5.56 ± 16%     +12.1       17.64 ±  5%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     57.43           +13.5       70.94 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     59.52 ±  2%     +18.1       77.59        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     18.30 ±  9%     +19.3       37.61 ± 13%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     66.15 ±  3%     +30.7       96.87        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     66.17 ±  3%     +30.7       96.92        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     66.17 ±  3%     +30.7       96.92        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     66.79 ±  2%     +31.3       98.10        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     20.85 ±  4%     -19.8        1.01 ± 14%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     18.54 ±  5%     -17.6        0.98 ± 13%  perf-profile.children.cycles-pp.do_syscall_64
     14.03 ±  3%     -14.0        0.00        perf-profile.children.cycles-pp.__x64_sys_ioctl
     11.60 ±  8%     -11.3        0.30 ± 11%  perf-profile.children.cycles-pp.ret_from_fork
     11.58 ±  8%     -11.3        0.30 ± 13%  perf-profile.children.cycles-pp.kthread
     11.22 ±  8%     -11.1        0.15 ±  7%  perf-profile.children.cycles-pp.worker_thread
     11.17 ±  8%     -11.0        0.14 ±  6%  perf-profile.children.cycles-pp.process_one_work
     10.70 ±  8%     -10.6        0.12 ±  7%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
     10.69 ±  8%     -10.6        0.12 ±  7%  perf-profile.children.cycles-pp.memcpy_toio
     10.34 ±  3%     -10.3        0.00        perf-profile.children.cycles-pp.block_ioctl
     10.34 ±  3%     -10.3        0.00        perf-profile.children.cycles-pp.blkdev_ioctl
     10.30 ±  3%     -10.3        0.00        perf-profile.children.cycles-pp.lo_ioctl
      9.73 ±  4%      -9.7        0.00        perf-profile.children.cycles-pp.loop_set_size
      9.73 ±  4%      -9.7        0.00        perf-profile.children.cycles-pp.set_capacity_and_notify.cold
     10.24 ±  4%      -9.7        0.58 ± 16%  perf-profile.children.cycles-pp.printk
     10.24 ±  4%      -9.7        0.58 ± 16%  perf-profile.children.cycles-pp.vprintk_emit
      8.72 ±  6%      -8.1        0.58 ± 16%  perf-profile.children.cycles-pp.console_unlock
      8.12 ±  6%      -7.6        0.54 ± 16%  perf-profile.children.cycles-pp.serial8250_console_write
      7.74 ±  6%      -7.2        0.53 ± 16%  perf-profile.children.cycles-pp.uart_console_write
      7.57 ±  5%      -7.0        0.53 ± 17%  perf-profile.children.cycles-pp.wait_for_xmitr
      7.21 ±  6%      -6.7        0.51 ± 17%  perf-profile.children.cycles-pp.serial8250_console_putchar
      6.69 ± 10%      -6.7        0.00        perf-profile.children.cycles-pp.__mutex_lock
      6.03 ±  6%      -5.6        0.44 ± 25%  perf-profile.children.cycles-pp.io_serial_in
      5.17 ±  9%      -5.2        0.00        perf-profile.children.cycles-pp.loop_configure
      3.15 ± 23%      -3.0        0.12 ± 43%  perf-profile.children.cycles-pp.do_sys_open
      3.15 ± 23%      -3.0        0.12 ± 43%  perf-profile.children.cycles-pp.do_sys_openat2
      3.00 ± 25%      -2.9        0.12 ± 37%  perf-profile.children.cycles-pp.do_filp_open
      2.99 ± 25%      -2.9        0.12 ± 37%  perf-profile.children.cycles-pp.path_openat
      1.52 ±  6%      -1.4        0.09 ± 80%  perf-profile.children.cycles-pp.delay_tsc
      0.45 ± 13%      -0.3        0.12 ± 26%  perf-profile.children.cycles-pp.rcu_core
      0.40 ± 12%      -0.3        0.10 ± 51%  perf-profile.children.cycles-pp.__schedule
      0.32 ± 37%      -0.3        0.06 ± 50%  perf-profile.children.cycles-pp.walk_component
      0.32 ± 10%      -0.3        0.07 ± 56%  perf-profile.children.cycles-pp.schedule
      0.28 ±  8%      -0.2        0.04 ± 75%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.25 ± 16%      -0.2        0.05 ± 78%  perf-profile.children.cycles-pp.link_path_walk
      0.21 ± 18%      -0.2        0.05 ± 74%  perf-profile.children.cycles-pp.newidle_balance
      0.20 ± 20%      -0.1        0.09 ± 31%  perf-profile.children.cycles-pp.note_gp_changes
      0.26 ± 14%      -0.1        0.16 ± 30%  perf-profile.children.cycles-pp.ksys_read
      0.25 ± 15%      -0.1        0.16 ± 30%  perf-profile.children.cycles-pp.vfs_read
      0.17 ± 16%      -0.1        0.08 ± 58%  perf-profile.children.cycles-pp.poll_idle
      0.09 ±  6%      +0.1        0.15 ± 18%  perf-profile.children.cycles-pp.exec_binprm
      0.09 ±  8%      +0.1        0.14 ± 17%  perf-profile.children.cycles-pp.load_elf_binary
      0.03 ±100%      +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.zap_pte_range
      0.11 ± 16%      +0.1        0.17 ± 15%  perf-profile.children.cycles-pp.trigger_load_balance
      0.07 ± 27%      +0.1        0.14 ± 47%  perf-profile.children.cycles-pp.rb_next
      0.10 ±  7%      +0.1        0.16 ± 17%  perf-profile.children.cycles-pp.bprm_execve
      0.03 ±100%      +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.unmap_page_range
      0.03 ±103%      +0.1        0.10 ± 29%  perf-profile.children.cycles-pp.__do_sys_clone
      0.03 ±101%      +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.tick_program_event
      0.09 ± 19%      +0.1        0.16 ± 26%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_enter
      0.13 ± 13%      +0.1        0.20 ± 20%  perf-profile.children.cycles-pp.execve
      0.13 ± 13%      +0.1        0.20 ± 20%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.13 ± 13%      +0.1        0.20 ± 20%  perf-profile.children.cycles-pp.do_execveat_common
      0.03 ±100%      +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.unmap_vmas
      0.07 ± 47%      +0.1        0.14 ± 20%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.16 ± 19%      +0.1        0.24 ± 19%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.16 ± 18%      +0.1        0.24 ± 20%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.05 ± 75%      +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.__libc_fork
      0.09 ± 20%      +0.1        0.18 ± 24%  perf-profile.children.cycles-pp.mmput
      0.09 ± 20%      +0.1        0.18 ± 24%  perf-profile.children.cycles-pp.exit_mmap
      0.12 ±  5%      +0.1        0.22 ± 24%  perf-profile.children.cycles-pp.__hrtimer_get_next_event
      0.19 ± 17%      +0.1        0.30 ± 16%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.14 ± 33%      +0.1        0.25 ± 10%  perf-profile.children.cycles-pp.timerqueue_add
      0.13 ± 29%      +0.1        0.24 ± 12%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.28 ± 19%      +0.1        0.40 ± 20%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.13 ± 27%      +0.1        0.26 ± 19%  perf-profile.children.cycles-pp.call_cpuidle
      0.26 ± 15%      +0.1        0.40 ± 15%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.16 ± 28%      +0.1        0.31 ±  7%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.27 ± 19%      +0.2        0.42 ± 18%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.11 ± 19%      +0.2        0.27 ± 54%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.11 ± 21%      +0.2        0.28 ± 55%  perf-profile.children.cycles-pp.handle_mm_fault
      0.13 ± 19%      +0.2        0.30 ± 48%  perf-profile.children.cycles-pp.exc_page_fault
      0.13 ± 19%      +0.2        0.30 ± 48%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.34 ± 14%      +0.2        0.52 ± 14%  perf-profile.children.cycles-pp.update_rq_clock
      0.14 ± 17%      +0.2        0.32 ± 47%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.28 ± 16%      +0.2        0.48 ± 23%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.28 ±  7%      +0.2        0.47 ± 12%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.32 ±  5%      +0.2        0.52 ± 13%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.29 ± 21%      +0.2        0.53 ± 11%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.62 ± 14%      +0.3        0.87 ± 16%  perf-profile.children.cycles-pp.load_balance
      0.46 ±  5%      +0.3        0.73 ± 15%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.21 ± 11%      +0.3        0.51 ± 21%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.21 ± 10%      +0.3        0.53 ± 21%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.54 ± 12%      +0.3        0.87 ± 15%  perf-profile.children.cycles-pp.native_sched_clock
      0.57 ± 11%      +0.4        0.94 ± 15%  perf-profile.children.cycles-pp.sched_clock
      0.30 ± 16%      +0.4        0.68 ± 21%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.33 ± 23%      +0.4        0.74 ± 18%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.66 ± 12%      +0.4        1.09 ± 16%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.81 ± 17%      +0.4        1.25 ±  4%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.79 ± 11%      +0.5        1.29 ± 15%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.66 ± 16%      +0.5        1.17 ± 18%  perf-profile.children.cycles-pp.read_tsc
      0.59 ± 10%      +0.5        1.13 ± 14%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.62 ± 43%      +0.6        1.18 ±  5%  perf-profile.children.cycles-pp.start_kernel
      0.80 ±  5%      +0.6        1.38 ± 12%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.83 ± 10%      +0.6        1.43 ± 11%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.70 ± 13%      +0.6        1.30 ± 15%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.98 ± 18%      +0.7        1.67 ± 13%  perf-profile.children.cycles-pp.tick_irq_enter
      1.01 ± 16%      +0.7        1.74 ± 13%  perf-profile.children.cycles-pp.irq_enter_rcu
      1.84 ± 11%      +0.8        2.62 ± 14%  perf-profile.children.cycles-pp.__softirqentry_text_start
      1.13 ±  7%      +0.9        2.00 ±  9%  perf-profile.children.cycles-pp.scheduler_tick
      0.74 ±  8%      +0.9        1.67 ± 17%  perf-profile.children.cycles-pp.rebalance_domains
      2.30 ±  9%      +1.2        3.49 ± 13%  perf-profile.children.cycles-pp.irq_exit_rcu
      2.18 ±  8%      +1.5        3.65 ± 10%  perf-profile.children.cycles-pp.update_process_times
      2.24 ±  8%      +1.5        3.75 ±  9%  perf-profile.children.cycles-pp.tick_sched_handle
      0.95 ± 24%      +1.6        2.52 ± 14%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      2.62 ±  7%      +1.9        4.54 ±  9%  perf-profile.children.cycles-pp.tick_sched_timer
      1.71 ± 11%      +2.3        4.03 ±  8%  perf-profile.children.cycles-pp.tick_nohz_next_event
      2.65 ±  9%      +2.5        5.16 ± 11%  perf-profile.children.cycles-pp.clockevents_program_event
      2.11 ±  9%      +2.6        4.69 ±  8%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      4.00 ±  6%      +2.9        6.88 ±  9%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      3.64 ±  6%      +3.3        6.98 ± 10%  perf-profile.children.cycles-pp.ktime_get
      7.90 ±  4%      +6.3       14.19 ± 10%  perf-profile.children.cycles-pp.hrtimer_interrupt
      8.04 ±  4%      +6.3       14.38 ± 10%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
     12.70 ±  5%      +9.0       21.70 ± 10%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      5.64 ± 16%     +12.2       17.88 ±  5%  perf-profile.children.cycles-pp.menu_select
     16.15 ±  6%     +13.9       30.08 ± 12%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     60.05           +18.5       78.52        perf-profile.children.cycles-pp.cpuidle_enter_state
     60.06           +18.5       78.56        perf-profile.children.cycles-pp.cpuidle_enter
     66.17 ±  3%     +30.7       96.92        perf-profile.children.cycles-pp.start_secondary
     66.79 ±  2%     +31.3       98.10        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     66.79 ±  2%     +31.3       98.10        perf-profile.children.cycles-pp.cpu_startup_entry
     66.79 ±  2%     +31.3       98.10        perf-profile.children.cycles-pp.do_idle
     10.60 ±  8%     -10.5        0.12 ±  7%  perf-profile.self.cycles-pp.memcpy_toio
      6.03 ±  6%      -5.6        0.44 ± 25%  perf-profile.self.cycles-pp.io_serial_in
      1.52 ±  6%      -1.4        0.09 ± 80%  perf-profile.self.cycles-pp.delay_tsc
      0.17 ± 15%      -0.1        0.07 ± 54%  perf-profile.self.cycles-pp.poll_idle
      0.04 ± 71%      +0.0        0.08 ± 29%  perf-profile.self.cycles-pp.tick_sched_timer
      0.06 ± 52%      +0.1        0.11 ± 10%  perf-profile.self.cycles-pp.scheduler_tick
      0.03 ±103%      +0.1        0.09 ± 11%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.01 ±223%      +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.update_ts_time_stats
      0.03 ±101%      +0.1        0.09 ± 13%  perf-profile.self.cycles-pp.tick_program_event
      0.08 ± 17%      +0.1        0.14 ± 23%  perf-profile.self.cycles-pp.__hrtimer_get_next_event
      0.09 ± 20%      +0.1        0.15 ± 25%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_enter
      0.07 ± 51%      +0.1        0.13 ± 18%  perf-profile.self.cycles-pp.load_balance
      0.08 ± 16%      +0.1        0.15 ± 28%  perf-profile.self.cycles-pp.tick_irq_enter
      0.08 ± 27%      +0.1        0.14 ± 35%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.08 ± 30%      +0.1        0.15 ± 17%  perf-profile.self.cycles-pp.timerqueue_add
      0.07 ± 30%      +0.1        0.14 ± 27%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.00            +0.1        0.08 ± 33%  perf-profile.self.cycles-pp.irq_enter_rcu
      0.15 ± 11%      +0.1        0.25 ± 16%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.09 ± 35%      +0.1        0.18 ± 31%  perf-profile.self.cycles-pp.rebalance_domains
      0.18 ± 20%      +0.1        0.28 ± 25%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.19 ± 18%      +0.1        0.30 ± 16%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.13 ± 27%      +0.1        0.25 ± 18%  perf-profile.self.cycles-pp.call_cpuidle
      0.14 ± 31%      +0.1        0.27 ± 13%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.28 ± 16%      +0.2        0.48 ± 23%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.28 ±  7%      +0.2        0.47 ± 12%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.32 ± 11%      +0.2        0.53 ±  8%  perf-profile.self.cycles-pp.do_idle
      0.44 ±  7%      +0.3        0.72 ± 16%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.20 ± 11%      +0.3        0.50 ± 20%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.51 ± 12%      +0.3        0.83 ± 14%  perf-profile.self.cycles-pp.native_sched_clock
      0.30 ± 16%      +0.4        0.68 ± 20%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.32 ± 22%      +0.4        0.73 ± 18%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.40 ± 19%      +0.4        0.83 ± 18%  perf-profile.self.cycles-pp.update_process_times
      0.38 ± 16%      +0.4        0.81 ± 13%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.48 ± 12%      +0.4        0.91 ± 15%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.41 ± 19%      +0.5        0.87 ± 15%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.64 ± 15%      +0.5        1.13 ± 18%  perf-profile.self.cycles-pp.read_tsc
      0.79 ±  5%      +0.6        1.38 ± 12%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.83 ± 11%      +0.6        1.42 ± 11%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.94 ± 24%      +1.6        2.52 ± 14%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      3.07 ±  6%      +3.0        6.02 ±  9%  perf-profile.self.cycles-pp.ktime_get
      3.32 ± 25%      +9.5       12.86 ±  9%  perf-profile.self.cycles-pp.menu_select
      5.01 ± 27%     +12.2       17.20 ± 12%  perf-profile.self.cycles-pp.cpuidle_enter_state


                                                                                
                          perf-sched.total_wait_time.max.ms                     
                                                                                
  10000 +-------------------------------------------------------------------+   
   9000 |-+                                                                 |   
        |                                                                   |   
   8000 |-+                                                                 |   
   7000 |-+                                                                 |   
        |                                                                   |   
   6000 |-+                                                                 |   
   5000 |-+                                                                 |   
   4000 |-+                                                                 |   
        |                                                                   |   
   3000 |-+                                                                 |   
   2000 |-+                                                                 |   
        |                                                                   |   
   1000 |-+                                                                 |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       perf-sched.total_wait_time.average.ms                    
                                                                                
  300 +---------------------------------------------------------------------+   
      |                                                                     |   
  250 |-+ O              O   O  O  OOOO                                     |   
      |  O OO O OO OO OO  O O OO OO    O   O                                |   
      |OO      O  O  O                                                      |   
  200 |-+               O               O O                                 |   
      |                                                                     |   
  150 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
   50 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     perf-sched.total_wait_and_delay.count.ms                   
                                                                                
  8000 +--------------------------------------------------------------------+   
       |                                 O                                  |   
  7000 |OO     O   O  OOO                                                   |   
  6000 |-+OOOOO  OO OO     OO OO  OO O OO  O                                |   
       |                  O  O  O   O O                                     |   
  5000 |-+                                                                  |   
       |                                                                    |   
  4000 |-+                                                                  |   
       |                                                                    |   
  3000 |-+                                                                  |   
  2000 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
       |+ +++ ++.+++   +++ ++++++.+++ +++ +++ +++ .++++ ++++++++  +.++++++++|   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       perf-sched.total_wait_and_delay.max.ms                   
                                                                                
  10000 +-------------------------------------------------------------------+   
   9000 |-+                                                                 |   
        |                                                                   |   
   8000 |-+                                                                 |   
   7000 |-+                                                                 |   
        |                                                                   |   
   6000 |-+                                                                 |   
   5000 |-+                                                                 |   
   4000 |-+                                                                 |   
        |                                                                   |   
   3000 |-+                                                                 |   
   2000 |-+                                                                 |   
        |                                                                   |   
   1000 |-+                                                                 |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    perf-sched.total_wait_and_delay.average.ms                  
                                                                                
  300 +---------------------------------------------------------------------+   
      |                                                                     |   
  250 |-+ O     O  O     O   O  O  OOOO                                     |   
      |  O OO O  O  O OO  O O OO OO    O   O                                |   
      |OO      O  O  O                                                      |   
  200 |-+               O               O O                                 |   
      |                                                                     |   
  150 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
   50 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
      perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read    
                                                                                
  1200 +--------------------------------------------------------------------+   
       |                                                                    |   
  1000 |OOOOOO OOOOOOOOOOOOO OOOOOOOOOOOO OOO                               |   
       |                                                                    |   
       |                                                                    |   
   800 |-+                                                                  |   
       |                                                                    |   
   600 |-+                                                                  |   
       |                                                                    |   
   400 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
   200 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
     perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read     
                                                                                
  90 +----------------------------------------------------------------------+   
     | O      OOOOOO   O O  O   O   O O                                     |   
  80 |-+             O    OO   O  O    O O O                                |   
  70 |-+   OO         O O    O   O        O                                 |   
     |                                                                      |   
  60 |-+                                                                    |   
  50 |-+                                                                    |   
     |                                                                      |   
  40 |-+                                                                    |   
  30 |-+                                                                    |   
     |                                                                      |   
  20 |-+                                                                    |   
  10 |-+                                                                    |   
     |                                                                      |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
    perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read  
                                                                                
  2500 +--------------------------------------------------------------------+   
       |    O          O O                                                  |   
       |     O        O    OO OO  OO    OOOO                                |   
  2000 |-O     O OOOOO  O    O  O    O                                      |   
       |O OO  O           O         O OO                                    |   
       |                                                                    |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
   500 |-+                                                                  |   
       |                     + +                    +++           +  ++     |   
       |  +++ ++.+++    +  ++ ::+.++  +++ ++  +++ .+   :+++ ++ +  :+ : + +++|   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
    perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read 
                                                                                
  1200 +--------------------------------------------------------------------+   
       |                                                                    |   
  1000 |OOOOOOOO OOOOOOOOOOOOOOOO OOOOOOOOOO                                |   
       |                                                                    |   
       |                                                                    |   
   800 |-+                                                                  |   
       |                                                                    |   
   600 |-+                                                                  |   
       |                                                                    |   
   400 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
   200 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
   perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read  
                                                                                
  90 +----------------------------------------------------------------------+   
     | O      OOOOOO  O  O  O  O    O O                                     |   
  80 |-+            O     OO  O  O     OO O                                 |   
  70 |-+  O O        O  O    O  O        O                                  |   
     |                                                                      |   
  60 |-+                                                                    |   
  50 |-+                                                                    |   
     |                                                                      |   
  40 |-+                                                                    |   
  30 |-+                                                                    |   
     |                                                                      |   
  20 |-+                                                                    |   
  10 |-+                                                                    |   
     |                                                                      |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
        perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork     
                                                                                
  6000 +--------------------------------------------------------------------+   
       |  O                                                                 |   
  5000 |-+                          O                                       |   
       |                                                                    |   
       |                                                                    |   
  4000 |-+                                                                  |   
       |                                O                                   |   
  3000 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
  1000 |OO OOO OOOOOOOOOOOOO OOOOOOO OOO  OOO                               |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork     
                                                                                
  800 +---------------------------------------------------------------------+   
      |OOOOO OOOOOOOO O OOOOOOOOOOO O OO OO                                 |   
  700 |-+            O               O  O  O                                |   
  600 |-+                                                                   |   
      |                                                                     |   
  500 |-+                                                                   |   
      |                                                                     |   
  400 |-+                                                                   |   
      |                                                                     |   
  300 |-+                                                                   |   
  200 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
      perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork   
                                                                                
  1400 +--------------------------------------------------------------------+   
       |OOOO  OO O OO OOOOO  O  O   OOOOO  O                                |   
  1200 |-+  OO    O  O     OO OO  OO     OO                                 |   
       |                                                                    |   
  1000 |-+                                                                  |   
       |                                                                    |   
   800 |-+                                                                  |   
       |                                                                    |   
   600 |-+                                                                  |   
       |                                                                    |   
   400 |-+                                                                  |   
       |                                                                    |   
   200 |-+                                            +                     |   
       |++++++++.++++++++++++++++.++++++++++++++++.+++ ++++++++++++.++++++++|   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
     perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork   
                                                                                
  6000 +--------------------------------------------------------------------+   
       |  O                                                                 |   
  5000 |-+                          O                                       |   
       |                                                                    |   
       |                                                                    |   
  4000 |-+                                                                  |   
       |                                O                                   |   
  3000 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
  1000 |OO OOOOO OOOOOOOOOOOOOOOO OO OOO OOO                                |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
     perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork   
                                                                                
  800 +---------------------------------------------------------------------+   
      |OOOOOO OOOOOOO OOOOO OOOOOOOO OO O O                                 |   
  700 |-+            O              O  O   O                                |   
  600 |-+                                                                   |   
      |                                                                     |   
  500 |-+                                                                   |   
      |                                                                     |   
  400 |-+                                                                   |   
      |                                                                     |   
  300 |-+                                                                   |   
  200 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  10000 +-------------------------------------------------------------------+   
   9000 |-+                                                                 |   
        |                                                                   |   
   8000 |-+                                                                 |   
   7000 |-+                                                                 |   
        |                                                                   |   
   6000 |-+                                                                 |   
   5000 |-+                                                                 |   
   4000 |-+                                                                 |   
        |                                                                   |   
   3000 |-+                                                                 |   
   2000 |-+                                                                 |   
        |                                                                   |   
   1000 |-+                                                                 |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  20 +----------------------------------------------------------------------+   
  18 |O+OOO O O OOO OOO OOO OOO OOO OOO OO OOO OOO O                        |   
     |                                                                      |   
  16 |-+                                                                    |   
  14 |-+                                                                    |   
     |                                                                      |   
  12 |-+                                                                    |   
  10 |-+                                                                    |   
   8 |-+                                                                    |   
     |                                                                      |   
   6 |-+                                                                    |   
   4 |-+                                                                    |   
     |                                                                      |   
   2 |-+                                                                    |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  1100 +--------------------------------------------------------------------+   
  1000 |OOOO  OO OOOOOOOOOO  O  O   OOOOO  O                                |   
       |    OO             OO OO  OO     OO                                 |   
   900 |-+                                                                  |   
   800 |-+                                                                  |   
   700 |-+                                                                  |   
   600 |-+                                                                  |   
       |                                                                    |   
   500 |-+                                                                  |   
   400 |-+                                                                  |   
   300 |-+                                                                  |   
   200 |-+                                                                  |   
       |                                                                    |   
   100 |++++++++.++++++++++++++++.++++++++++++++++.++++++++++++++++.++++++++|   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  10000 +-------------------------------------------------------------------+   
   9000 |-+                                                                 |   
        |                                                                   |   
   8000 |-+                                                                 |   
   7000 |-+                                                                 |   
        |                                                                   |   
   6000 |-+                                                                 |   
   5000 |-+                                                                 |   
   4000 |-+                                                                 |   
        |                                                                   |   
   3000 |-+                                                                 |   
   2000 |-+                                                                 |   
        |                                                                   |   
   1000 |-+                                                                 |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  20 +----------------------------------------------------------------------+   
  18 |O+OOO O O OOO OOO OOO OOO OOO OOO OO OOO OOO O                        |   
     |                                                                      |   
  16 |-+                                                                    |   
  14 |-+                                                                    |   
     |                                                                      |   
  12 |-+                                                                    |   
  10 |-+                                                                    |   
   8 |-+                                                                    |   
     |                                                                      |   
   6 |-+                                                                    |   
   4 |-+                                                                    |   
     |                                                                      |   
   2 |-+                                                                    |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
           perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork      
                                                                                
  10000 +-------------------------------------------------------------------+   
   9000 |O+  OOO        O              O O                                  |   
        |  OO   O O O OO OOOOOOOOOO OOO O  OO                               |   
   8000 |-O      O   O             O                                        |   
   7000 |-+                                                                 |   
        |                                                                   |   
   6000 |-+                                                                 |   
   5000 |-+                                                                 |   
   4000 |-+                                                                 |   
        |                                                                   |   
   3000 |-+                                                                 |   
   2000 |-+                                                                 |   
        |                                                                   |   
   1000 |-+                                                                 |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
          perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork       
                                                                                
  600 +---------------------------------------------------------------------+   
      |                                                                     |   
  500 |-+              O     O  O                                           |   
      | O O O   O  O  O  OO         O O O O                                 |   
      |O O O   O OO OO  O   O OO OOO O O                                    |   
  400 |-+     O                            O                                |   
      |                                                                     |   
  300 |-+                                                                   |   
      |                                                                     |   
  200 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork     
                                                                                
  700 +---------------------------------------------------------------------+   
      |                     O  O                                            |   
  600 |OOOOOO   OO OOOOOOOO  OO OOOOOOO O  O                                |   
      |       OO  O                    O  O                                 |   
  500 |-+                                                                   |   
      |                                                                     |   
  400 |-+                                                                   |   
      |                                                                     |   
  300 |-+                                                                   |   
      |                                                                     |   
  200 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
        perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork    
                                                                                
  10000 +-------------------------------------------------------------------+   
   9000 |O+  OOO        O              O O                                  |   
        |  OO   O O O OO OOOOOOOOOO OOO O  OO                               |   
   8000 |-O      O   O             O                                        |   
   7000 |-+                                                                 |   
        |                                                                   |   
   6000 |-+                                                                 |   
   5000 |-+                                                                 |   
   4000 |-+                                                                 |   
        |                                                                   |   
   3000 |-+                                                                 |   
   2000 |-+                                                                 |   
        |                                                                   |   
   1000 |-+                                                                 |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
       perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork     
                                                                                
  600 +---------------------------------------------------------------------+   
      |                                                                     |   
  500 |-+              O     O  O     O                                     |   
      | O O O   O  O  O  OO         O   O O                                 |   
      |O O O   O OO OO  O   O OO OOO O O                                    |   
  400 |-+     O                            O                                |   
      |                                                                     |   
  300 |-+                                                                   |   
      |                                                                     |   
  200 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  2500 +--------------------------------------------------------------------+   
       |                                                                    |   
       |                                  O                                 |   
  2000 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
  1500 |-+                                                                  |   
       | O                               O                                  |   
  1000 |-+               O                                                  |   
       |O                                                                   |   
       |  O    O   O    O                                                   |   
   500 |-+   O        OO                                                    |   
       |   OO O  OO OO    OOOOOOO OOOOOOO  O                                |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  300 +---------------------------------------------------------------------+   
      |O O     O  O  OOOO   O  O  OOOO O  OO                                |   
  250 |-O OOO O OO OO    OO  OO OO    O O                                   |   
      |                                                                     |   
      |                                                                     |   
  200 |-+                                                                   |   
      |                                                                     |   
  150 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
   50 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  250 +---------------------------------------------------------------------+   
      |                                                                     |   
      |                                                                     |   
  200 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
  150 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
   50 |-+                                                                   |   
      |                                                                     |   
      |  +            +       +   +  +     +  +                    +        |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  300 +---------------------------------------------------------------------+   
      |O O     O  O  OOOO   O  O  OOOO O  OO                                |   
  250 |-O OOO O OO OO    OO  OO OO    O O                                   |   
      |                                                                     |   
      |                                                                     |   
  200 |-+                                                                   |   
      |                                                                     |   
  150 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
   50 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64 
                                                                                
  16 +----------------------------------------------------------------------+   
     |         O  O                                                         |   
  14 |OOOOO   O OO OOOO OOOOO OO O  O OOO O                                 |   
  12 |-+    OO               O  O O  O   O                                  |   
     |                                                                      |   
  10 |-+                                                                    |   
     |                                                                      |   
   8 |-+                                                                    |   
     |                                                                      |   
   6 |-+                                                                    |   
   4 |-+                                                                    |   
     |                                                                      |   
   2 |-+                                                                    |   
     |                                                                      |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
   perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
                                                                                
  0.9 +---------------------------------------------------------------------+   
      | O O   OO OO OO   O   O  O  OOO                                      |   
  0.8 |O+O      O  O   O    O OO OO   OO   O                                |   
  0.7 |-+  OO         O O O             O O                                 |   
      |                                                                     |   
  0.6 |-+                                                                   |   
  0.5 |-+                                                                   |   
      |                                                                     |   
  0.4 |-+                                                                   |   
  0.3 |-+                                                                   |   
      |                                                                     |   
  0.2 |-+                                                                   |   
  0.1 |-+                                                                   |   
      |                  +    +                           +  +          +   |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_6
                                                                                
  250 +---------------------------------------------------------------------+   
      |O O     OOOOOO  O O            O                                     |   
      | O O   O              O  O  O O                                      |   
  200 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
  150 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
   50 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  16 +----------------------------------------------------------------------+   
     |         O  O                                                         |   
  14 |OOOOO   O OO OOOO OOOOO OO O  O OOO O                                 |   
  12 |-+    OO               O  O O  O   O                                  |   
     |                                                                      |   
  10 |-+                                                                    |   
     |                                                                      |   
   8 |-+                                                                    |   
     |                                                                      |   
   6 |-+                                                                    |   
   4 |-+                                                                    |   
     |                                                                      |   
   2 |-+                                                                    |   
     |                                                                      |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.9 +---------------------------------------------------------------------+   
      |OOO     O OO OO O O          O                                       |   
  0.8 |-+       O  O        O OO OO   OO   O                                |   
  0.7 |-+  OO         O O O             O O                                 |   
      |                                                                     |   
  0.6 |-+                                                                   |   
  0.5 |-+                                                                   |   
      |                                                                     |   
  0.4 |-+                                                                   |   
  0.3 |-+                                                                   |   
      |                                                                     |   
  0.2 |-+                                                                   |   
  0.1 |-+                                                                   |   
      |               +  +    +                           +  +          +   |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
    perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
                                                                                
   0.05 +-------------------------------------------------------------------+   
  0.045 |-+                   O   O                                         |   
        |                              O                                    |   
   0.04 |-+      O  O                                                       |   
  0.035 |-+    O           O                                                |   
        |                                                                   |   
   0.03 |-+                                                                 |   
  0.025 |OOOO     OO OO  O           O  O                                   |   
   0.02 |-+                         O O    O                                |   
        |              O                    O                               |   
  0.015 |-+  OO         O O OO OO  O     OO                                 |   
   0.01 |-+                                                                 |   
        |                                                                   |   
  0.005 |-+                                                                :|   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  40 +----------------------------------------------------------------------+   
     |         O  O        O   O  O       O                                 |   
  35 |-+                                                                    |   
  30 |-+                                                                    |   
     |                                                                      |   
  25 |-+                                                                    |   
     |                                                                      |   
  20 |-+                                                                    |   
     |                                                                      |   
  15 |-+                                                                    |   
  10 |-+                                                                    |   
     |                                                                      |   
   5 |-+                                                                    |   
     |                                                                      |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_for
                                                                                
  600 +---------------------------------------------------------------------+   
      |                                                                     |   
  500 |OOOOO OOOOOOOOOO OOOOOOOOOOO OOOOOOOO                                |   
      |                                                                     |   
      |                                                                     |   
  400 |-+                                                                   |   
      |                                                                     |   
  300 |-+                                                                   |   
      |                                                                     |   
  200 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_for
                                                                                
  500 +---------------------------------------------------------------------+   
  450 |OOOOO OOOOOOOOOO OOOOOOOOOOO OOOOOOOO                                |   
      |                                                                     |   
  400 |-+                                                                   |   
  350 |-+                                                                   |   
      |                                                                     |   
  300 |-+                                                                   |   
  250 |-+                                                                   |   
  200 |-+                                                                   |   
      |                                                                     |   
  150 |-+                                                                   |   
  100 |-+                                                                   |   
      |                                                                     |   
   50 |-+                                                                   |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  50 +----------------------------------------------------------------------+   
  45 |-+        O  O    O   O   O O O                                       |   
     |                                     O                                |   
  40 |-+   OO              O   O     O                                      |   
  35 |-+       O  O   O      O   O                                          |   
     |  OO   OO  O     O               O OO                                 |   
  30 |O+             O    O        O  O                                     |   
  25 |-+                                                                    |   
  20 |-O                 O                                                  |   
     |                                                                      |   
  15 |-+                                                                    |   
  10 |-+                                                                    |   
     |                                                                      |   
   5 |-+                                                                    |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  450 +---------------------------------------------------------------------+   
      |                   O                                                 |   
  400 |-+                                                                   |   
  350 |O+                  O                                                |   
      |  O    OO  O  O              O  OOOO                                 |   
  300 |-+ O     O  O    O     O  O                                          |   
  250 |-+  O O        O     O  O                                            |   
      |                  O   O  O O   O    O                                |   
  200 |-+        O  O                O                                      |   
  150 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
   50 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  450 +---------------------------------------------------------------------+   
      | O                                                                   |   
  400 |-+                 O                                                 |   
  350 |-+                                                                   |   
      |O             O     O        O  OO                                   |   
  300 |-+OO   OOO OO    O                OO                                 |   
  250 |-+  O O        O     O OO O                                          |   
      |                  O            O    O                                |   
  200 |-+        O  O        O  O O  O                                      |   
  150 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
   50 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  20 +----------------------------------------------------------------------+   
     |                                                                      |   
     |                                                                      |   
  15 |-+                                                                    |   
     |                                                                      |   
     |                                                                      |   
     |                                                                      |   
  10 |-+                                                                    |   
     |                                                                      |   
     |                                                                      |   
   5 |-+                                                                    |   
     |                                                                      |   
     |                                                                      |   
     |                                              .+.+                    |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  1000 +--------------------------------------------------------------------+   
   900 |-+                                                                  |   
       |                                                                    |   
   800 |-+                                                                  |   
   700 |-+                                                                  |   
       |                                                                    |   
   600 |-+                                                                  |   
   500 |-+                                                                  |   
   400 |-+                                                                  |   
       |                                                                    |   
   300 |-+                                                                  |   
   200 |-+                                                                  |   
       |                                                                    |   
   100 |-+                                                                  |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  900 +---------------------------------------------------------------------+   
      |                                                                     |   
  800 |-+                                                                   |   
  700 |-+                                                                   |   
      |                                                                     |   
  600 |-+                                                                   |   
  500 |-+                                                                   |   
      |                                                                     |   
  400 |-+                                                                   |   
  300 |-+                                                                   |   
      |                                                                     |   
  200 |-+                                                                   |   
  100 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  14 +----------------------------------------------------------------------+   
     |O                                                                     |   
  12 |-+ O   O      OO                                                      |   
     | OO O O OOOOOO  O OOOOOOOOOOO OOOOOOO                                 |   
  10 |-+                                                                    |   
     |                                                                      |   
   8 |-+                                                                    |   
     |                                                                      |   
   6 |-+                                                                    |   
     |                                                                      |   
   4 |-+                                                                    |   
     |                                                                      |   
   2 |-+                                                                    |   
     | +  +.    +                  .+  +    +   +        +.+ ++         ++  |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  1200 +--------------------------------------------------------------------+   
       |                                                                    |   
  1000 |OOOO OOOOOOOOO OOOOOOOOO OOOOOOOO OOOO                              |   
       |                                                                    |   
       |                                                                    |   
   800 |-+                                                                  |   
       |                                                                    |   
   600 |-+                                                                  |   
       |                                                                    |   
   400 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
   200 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  900 +---------------------------------------------------------------------+   
      | OO  OO OOOO OO  OOOO OOOOOOOO OOOOOOO                               |   
  800 |-+  O  O       OO                                                    |   
  700 |O+                                                                   |   
      |                                                                     |   
  600 |-+                                                                   |   
  500 |-+                                                                   |   
      |                                                                     |   
  400 |-+                                                                   |   
  300 |-+                                                                   |   
      |                                                                     |   
  200 |-+                                                                   |   
  100 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                           stress-ng.time.system_time                           
                                                                                
  30 +----------------------------------------------------------------------+   
     |                                                                      |   
  25 |-++    +        +    ++++ +    +   +   +    +   ++++   +              |   
     |  ::+.+ ++ +++++ + + :   :::   ::++ :  :+ ++ +++    + + :++++++ .++  +|   
     |++ +      +       + +    + ++.+ +   +++  +           +  +      +   ++ |   
  20 |-+                                                                    |   
     |                                                                      |   
  15 |-+                                                                    |   
     |                                                                      |   
  10 |-+                                                                    |   
     |                                                                      |   
     |                                                                      |   
   5 |-+                                                                    |   
     |                                                                      |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            stress-ng.time.elapsed_time                         
                                                                                
  900 +---------------------------------------------------------------------+   
      |                                                                     |   
  800 |-+                                                                   |   
  700 |-+O O   OOOOOO       O  O      O                                     |   
      |                                                                     |   
  600 |-+                                                                   |   
  500 |-O O O        O   O        O    OO OO                                |   
      |                                                                     |   
  400 |-+     O           O                                                 |   
  300 |O+              O           O                                        |   
      |                                                                     |   
  200 |-+                                                                   |   
  100 |-+                                                                   |   
      |++++++.+++++++++++++.+++++++++++++.+++++++++++++.+++++++++++++.++++++|   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                          stress-ng.time.elapsed_time.max                       
                                                                                
  900 +---------------------------------------------------------------------+   
      |                                                                     |   
  800 |-+                                                                   |   
  700 |-+O O   OOOOOO       O  O      O                                     |   
      |                                                                     |   
  600 |-+                                                                   |   
  500 |-O O O        O   O        O    OO OO                                |   
      |                                                                     |   
  400 |-+     O           O                                                 |   
  300 |O+              O           O                                        |   
      |                                                                     |   
  200 |-+                                                                   |   
  100 |-+                                                                   |   
      |++++++.+++++++++++++.+++++++++++++.+++++++++++++.+++++++++++++.++++++|   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      stress-ng.time.voluntary_context_switches                 
                                                                                
  90000 +-------------------------------------------------------------------+   
        |                      +                                            |   
  80000 |-+                    :+                    +                      |   
  70000 |+++       .+    +     : +  + +      + +     :: +          +    +  +|   
        |: :++    + :  + :    :   : : :++    : :++  : + ::  +  +  +:  + :: :|   
  60000 |-::  +   :  : :+ : ++:   +: ::  +. : ::  + +  : +  :: ::+  :+: :++ |   
  50000 |-:    ++:   ++   + : +    + :     ++ :    +   +  +: +: +   +  :    |   
        | +      +         +         +        +            +  +        +    |   
  40000 |-+                                                                 |   
  30000 |-+                                                                 |   
        |                                                                   |   
  20000 |-+                                                                 |   
  10000 |-+                                                                 |   
        |         O   O   O O                                               |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    stress-ng.time.involuntary_context_switches                 
                                                                                
  4500 +--------------------------------------------------------------------+   
       |  +   +       +++   + ++  +   +   +   +   .+   ++++  +              |   
  4000 |-+:: + +.  +++   :+ :+  :+ :  :: + :  :: +  :  :   :+ :++ +.    +  +|   
  3500 |++ ++    ++      + +    +  +++ ++  +++ ++   +++    +  +  +  ++++ ++ |   
       |                                                                    |   
  3000 |-+                                                                  |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                stress-ng.loop.ops                              
                                                                                
  1800 +--------------------------------------------------------------------+   
       |  +   +        ++   +     +   +   +   +   .+      +  +              |   
  1600 |-+:: + :   +  +  :+ :+++ + +  :: + +  :: +  : ++++ :+ :+  +.+     + |   
  1400 |++ ++  +.++ ++   + +    +   ++ ++   ++ ++   ++     +  + ++   +++++ +|   
       |                                                                    |   
  1200 |-+                                                                  |   
  1000 |-+                                                                  |   
       |                                                                    |   
   800 |-+                                                                  |   
   600 |-+                                                                  |   
       |                                                                    |   
   400 |-+                                                                  |   
   200 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                           stress-ng.loop.ops_per_sec                           
                                                                                
  30 +----------------------------------------------------------------------+   
     |  +    +       ++    +    +    +   +   +    +      +   +              |   
  25 |-+:: .+ :  +  +  +   :+++ ::   :: + :  :+  + : ++++ + + :+  ++      + |   
     |++ ++   +++ ++    +++    + ++.+ ++  +++  ++  ++      +  + ++  ++.+++ +|   
     |                                                                      |   
  20 |-+                                                                    |   
     |                                                                      |   
  15 |-+                                                                    |   
     |                                                                      |   
  10 |-+                                                                    |   
     |                                                                      |   
     |                                                                      |   
   5 |-+                                                                    |   
     |                                                                      |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                   stress-ng.time.percent_of_cpu_this_job_got                   
                                                                                
  42 +----------------------------------------------------------------------+   
     |                :                                                     |   
  41 |-++    +        :    +         +   +   +    +                         |   
  40 |-+:    :       : :   : ++ +    :   :   :    :   + ++   +              |   
     |  :    :       : :   :::: :    :   :   ::   :   ::::   :              |   
  39 |-+:   ::      ++ :   :+ : :    :  ::   ::  ::   :+ :  +: +  +         |   
     |  ::  : :     :  :   :  : :    :: ::   ::  : :  :   : :: :  :         |   
  38 |-: :  + :     :  :   :  : :   : : + : : :  + : :    : :: :: :         |   
     | : : :  :    :    : :    : :  : : : : :  : : : :    : :: ::: :        |   
  37 |-: : :  :  ++:    : :    : :  : ::  : :  ::  :+:    : : ::+: :    +  +|   
  36 |-+ ++   ++ : +    ++:    : :  + ++  : +  ++  + +    ::  :  + ++  +: + |   
     | :        :         :    : : +      : :             ::  :      :+  :: |   
  35 |++        +         +    + ++       ++               :  :      +   +  |   
     |                                                     :  :             |   
  34 +----------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2sp7: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
  device/gcc-9/performance/1HDD/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp7/loop/stress-ng/60s/0x5003006

commit: 
  d3c4a43d92 ("block: refactor blk_drop_partitions")
  c76f48eb5c ("block: take bd_mutex around delete_partitions in del_gendisk")

d3c4a43d9291279c c76f48eb5c084b1e15c931ae8cc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2558 ±  3%     -96.2%      96.60        stress-ng.loop.ops
     42.24 ±  4%     -99.4%       0.25 ± 24%  stress-ng.loop.ops_per_sec
     62.86          +573.1%     423.13 ± 35%  stress-ng.time.elapsed_time
     62.86          +573.1%     423.13 ± 35%  stress-ng.time.elapsed_time.max
      3605 ±  4%     -96.5%     126.20 ±  6%  stress-ng.time.involuntary_context_switches
     44.50 ±  5%    -100.0%       0.00        stress-ng.time.percent_of_cpu_this_job_got
     28.07 ±  5%     -96.5%       0.99 ±  4%  stress-ng.time.system_time
     32283 ±  6%     -84.4%       5030 ± 35%  stress-ng.time.voluntary_context_switches
   9162176 ± 38%    +605.4%   64629562 ± 61%  cpuidle.C1E.usage
     94.64          +382.6%     456.80 ± 32%  uptime.boot
      8430 ±  2%    +403.8%      42470 ± 33%  uptime.idle
      1.32 ±  9%      +0.7        2.06 ± 28%  mpstat.cpu.all.irq%
      0.62 ±  6%      -0.6        0.03 ±  8%  mpstat.cpu.all.sys%
      0.21 ±  3%      -0.2        0.04 ± 18%  mpstat.cpu.all.usr%
    170429 ± 28%    +244.2%     586547 ± 31%  numa-numastat.node0.local_node
    212256 ±  8%    +203.4%     644004 ± 25%  numa-numastat.node0.numa_hit
    178422 ± 28%    +150.6%     447123 ± 37%  numa-numastat.node1.local_node
      3.00        +16860.0%     508.80 ± 98%  numa-meminfo.node0.Mlocked
      2215 ± 15%    +298.7%       8834 ± 16%  numa-meminfo.node1.Active
      2156 ± 16%    +301.9%       8666 ± 15%  numa-meminfo.node1.Active(anon)
   1363818 ± 11%     -19.9%    1092837 ±  9%  numa-meminfo.node1.MemUsed
    775.83 ± 11%     -99.5%       4.00 ± 41%  vmstat.io.bi
      1.00          -100.0%       0.00        vmstat.procs.r
      6009 ±  3%     -76.5%       1414 ±  2%  vmstat.system.cs
    184272 ±  5%      +4.0%     191637        vmstat.system.in
      0.00       +1.3e+104%     126.60 ± 98%  numa-vmstat.node0.nr_mlock
    539.33 ± 16%    +301.4%       2164 ± 15%  numa-vmstat.node1.nr_active_anon
      0.00         +1e+104%     100.00 ± 89%  numa-vmstat.node1.nr_mlock
    539.33 ± 16%    +301.4%       2164 ± 15%  numa-vmstat.node1.nr_zone_active_anon
    782921 ± 11%     +22.3%     957479 ± 11%  numa-vmstat.node1.numa_hit
      3674 ±  3%    +208.7%      11342 ± 12%  meminfo.Active
      3399 ±  3%    +225.2%      11054 ± 12%  meminfo.Active(anon)
     66602 ±  8%    +157.0%     171153 ±  3%  meminfo.AnonHugePages
   2839586           -14.6%    2424400        meminfo.Memused
      7.00        +12894.3%     909.60 ± 94%  meminfo.Mlocked
     15230           +53.2%      23338 ±  6%  meminfo.Shmem
     72.50 ±  7%     -23.0%      55.80 ± 25%  turbostat.Avg_MHz
      1807           -42.0%       1048        turbostat.Bzy_MHz
   9161353 ± 38%    +605.5%   64628765 ± 61%  turbostat.C1E
     48.00 ±  2%     -12.5%      42.00 ±  3%  turbostat.CoreTmp
  12253447 ±  6%    +570.1%   82113222 ± 35%  turbostat.IRQ
     48.00           -13.3%      41.60 ±  2%  turbostat.PkgTmp
    129.19           -39.2%      78.56 ±  8%  turbostat.PkgWatt
    849.33 ±  3%    +225.5%       2764 ± 12%  proc-vmstat.nr_active_anon
     71723            -4.3%      68656        proc-vmstat.nr_anon_pages
     74766            -4.1%      71672        proc-vmstat.nr_inactive_anon
     20825            -8.6%      19039 ±  2%  proc-vmstat.nr_kernel_stack
      9294            -3.6%       8961        proc-vmstat.nr_mapped
      1.00        +22620.0%     227.20 ± 94%  proc-vmstat.nr_mlock
      3807           +53.2%       5834 ±  6%  proc-vmstat.nr_shmem
     51872            -6.3%      48590        proc-vmstat.nr_slab_unreclaimable
    849.33 ±  3%    +225.5%       2764 ± 12%  proc-vmstat.nr_zone_active_anon
     74766            -4.1%      71672        proc-vmstat.nr_zone_inactive_anon
    474012          +143.8%    1155675 ± 27%  proc-vmstat.numa_hit
    383845          +178.2%    1067930 ± 30%  proc-vmstat.numa_local
     90166            -2.7%      87745        proc-vmstat.numa_other
      7912 ±  3%     -59.8%       3178 ± 19%  proc-vmstat.pgactivate
    609137          +103.7%    1240840 ± 26%  proc-vmstat.pgalloc_normal
    253503 ±  2%    +402.0%    1272525 ± 33%  proc-vmstat.pgfault
    454866 ±  2%    +167.4%    1216354 ± 27%  proc-vmstat.pgfree
     51740 ± 12%     -96.6%       1734 ± 19%  proc-vmstat.pgpgin
     15883 ±  2%    +412.7%      81427 ± 32%  proc-vmstat.pgreuse
      7809 ±  9%     -93.0%     546.40 ± 14%  proc-vmstat.unevictable_pgs_culled
 4.497e+08 ±  2%     -57.9%  1.894e+08 ±  8%  perf-stat.i.branch-instructions
      5951 ±  3%     -77.2%       1358 ±  3%  perf-stat.i.context-switches
      3.58 ±  6%     +64.2%       5.88 ± 27%  perf-stat.i.cpi
 6.279e+09 ±  9%     -22.3%  4.877e+09 ± 29%  perf-stat.i.cpu-cycles
    179.19           -44.7%      99.04        perf-stat.i.cpu-migrations
 5.161e+08 ±  2%     -53.1%  2.421e+08 ±  4%  perf-stat.i.dTLB-loads
 2.389e+08           -46.9%  1.268e+08 ±  3%  perf-stat.i.dTLB-stores
 2.184e+09 ±  2%     -58.1%  9.142e+08 ±  8%  perf-stat.i.instructions
      1567 ±  6%     -53.7%     726.17 ± 26%  perf-stat.i.instructions-per-iTLB-miss
      0.32 ±  5%     -39.8%       0.19 ± 23%  perf-stat.i.ipc
     11.79 ±  3%     -81.1%       2.23 ± 14%  perf-stat.i.major-faults
      0.07 ±  9%     -22.3%       0.05 ± 29%  perf-stat.i.metric.GHz
     12.54 ±  2%     -53.6%       5.81 ±  5%  perf-stat.i.metric.M/sec
      3473 ±  2%     -17.4%       2867        perf-stat.i.minor-faults
     77.21 ±  2%     +11.7       88.91 ±  3%  perf-stat.i.node-load-miss-rate%
    543244 ±  3%     -68.4%     171439 ± 49%  perf-stat.i.node-load-misses
    161064 ±  8%     -83.6%      26449 ± 59%  perf-stat.i.node-loads
    347247 ±  2%     -90.5%      33066 ± 14%  perf-stat.i.node-store-misses
    140453 ± 19%     -88.3%      16414 ± 64%  perf-stat.i.node-stores
      3528 ±  2%     -18.7%       2869        perf-stat.i.page-faults
      2.87 ±  6%     +84.2%       5.29 ± 25%  perf-stat.overall.cpi
      1607 ±  7%     -53.7%     744.06 ± 28%  perf-stat.overall.instructions-per-iTLB-miss
      0.35 ±  6%     -42.3%       0.20 ± 24%  perf-stat.overall.ipc
     77.11 ±  2%      +9.6       86.71 ±  2%  perf-stat.overall.node-load-miss-rate%
 4.427e+08 ±  2%     -57.3%   1.89e+08 ±  8%  perf-stat.ps.branch-instructions
      5858 ±  3%     -76.9%       1355 ±  3%  perf-stat.ps.context-switches
     94511            +1.3%      95756        perf-stat.ps.cpu-clock
  6.18e+09 ±  9%     -21.3%  4.865e+09 ± 29%  perf-stat.ps.cpu-cycles
    176.39           -44.0%      98.79        perf-stat.ps.cpu-migrations
 5.081e+08 ±  2%     -52.4%  2.416e+08 ±  4%  perf-stat.ps.dTLB-loads
 2.351e+08           -46.2%  1.265e+08 ±  3%  perf-stat.ps.dTLB-stores
  2.15e+09 ±  2%     -57.6%  9.123e+08 ±  8%  perf-stat.ps.instructions
     11.74 ±  2%     -80.8%       2.25 ± 15%  perf-stat.ps.major-faults
      3421 ±  2%     -16.4%       2861        perf-stat.ps.minor-faults
    534662 ±  3%     -68.0%     171047 ± 49%  perf-stat.ps.node-load-misses
    158578 ±  8%     -83.4%      26391 ± 59%  perf-stat.ps.node-loads
    341702 ±  2%     -90.3%      32994 ± 14%  perf-stat.ps.node-store-misses
    138263 ± 19%     -88.2%      16380 ± 63%  perf-stat.ps.node-stores
      3475 ±  2%     -17.6%       2863        perf-stat.ps.page-faults
     94511            +1.3%      95756        perf-stat.ps.task-clock
 1.383e+11 ±  2%    +175.0%  3.803e+11 ± 26%  perf-stat.total.instructions
      0.00 ± 41%    +260.0%       0.01 ± 28%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.41 ± 19%     -96.3%       0.02 ± 16%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.01 ± 24%    +416.3%       0.04 ± 50%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00 ±223%   +1012.7%       0.02 ± 40%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.02 ± 70%     -57.1%       0.01 ± 32%  perf-sched.total_sch_delay.average.ms
      1.04 ± 30%  +21949.0%     230.30 ±  3%  perf-sched.total_wait_and_delay.average.ms
    568.17 ± 17%   +1022.3%       6376 ±  3%  perf-sched.total_wait_and_delay.count.ms
     16.79 ± 22%  +59410.6%       9991        perf-sched.total_wait_and_delay.max.ms
      1.03 ± 31%  +22284.1%     230.29 ±  3%  perf-sched.total_wait_time.average.ms
     16.53 ± 23%  +60361.8%       9991        perf-sched.total_wait_time.max.ms
      0.06 ± 51%  +4.4e+05%     262.65 ±  4%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.04 ±  7%  +1.7e+05%      73.20 ±  3%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.09 ± 70%  +20597.0%      18.01        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      3.09 ± 46%    +592.5%      21.38 ± 31%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      3.00 ± 21%  +23956.9%     721.95 ±  2%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.95 ± 95%  +47375.8%     450.31 ±  3%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
      7.50 ± 18%   +3161.3%     244.60        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    193.00 ± 39%   +1041.6%       2203 ±  3%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
    169.00 ± 12%    +524.9%       1056        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.67 ± 52%  +10322.9%     486.40 ± 32%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    169.50 ± 12%    +637.5%       1250        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
      7.33 ± 15%   +7443.6%     553.20        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      0.32 ± 50%  +5.8e+05%       1875 ± 85%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.42 ±108%  +2.4e+05%       1008        perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      6.68 ± 66%  +1.5e+05%       9991        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.17 ± 44%   +8959.9%     377.80 ± 17%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     16.26 ± 24%   +6103.2%       1008        perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      6.30 ±100%  +1.4e+05%       8622 ±  6%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.06 ± 53%  +4.6e+05%     262.64 ±  4%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.04 ±  7%    +2e+05%      73.19 ±  3%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.09 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      0.09 ± 70%  +20597.0%      18.01        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      1.79 ± 52%  +12214.2%     220.38 ± 66%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      2.86 ± 46%    +646.5%      21.36 ± 31%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      2.99 ± 21%  +24010.2%     721.94 ±  2%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.54 ±168%  +83831.5%     450.29 ±  3%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      0.32 ± 50%  +5.9e+05%       1875 ± 85%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.40 ±118%  +2.5e+05%       1008        perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.16 ± 14%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      6.68 ± 66%  +1.5e+05%       9991        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      8.40 ± 67%   +5505.3%     470.98 ± 10%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      4.16 ± 44%   +8971.3%     377.76 ± 17%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     16.25 ± 24%   +6104.9%       1008        perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      3.88 ±164%  +2.2e+05%       8622 ±  6%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
      8194 ± 47%    +304.4%      33140 ± 19%  sched_debug.cfs_rq:/.load.avg
    309373 ± 59%    +107.0%     640417 ± 10%  sched_debug.cfs_rq:/.load.max
     41911 ± 49%    +196.6%     124297 ± 13%  sched_debug.cfs_rq:/.load.stddev
    754.63 ± 94%     -94.9%      38.33 ± 17%  sched_debug.cfs_rq:/.load_avg.avg
     27363 ± 97%     -97.1%     799.68 ±  6%  sched_debug.cfs_rq:/.load_avg.max
      3768 ± 93%     -96.0%     152.02 ± 10%  sched_debug.cfs_rq:/.load_avg.stddev
    586.67 ± 30%     -74.3%     150.85 ± 21%  sched_debug.cfs_rq:/.removed.load_avg.max
     92.77 ± 46%     -69.8%      27.99 ± 30%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      6.34 ± 67%     -71.1%       1.83 ± 51%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    265.25 ± 43%     -73.1%      71.45 ± 29%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     36.13 ± 51%     -72.4%       9.97 ± 35%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      6.34 ± 67%     -71.1%       1.83 ± 51%  sched_debug.cfs_rq:/.removed.util_avg.avg
    265.25 ± 43%     -73.1%      71.45 ± 29%  sched_debug.cfs_rq:/.removed.util_avg.max
     36.13 ± 51%     -72.4%       9.97 ± 35%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    200.97 ± 27%     -63.8%      72.78 ± 14%  sched_debug.cfs_rq:/.runnable_avg.avg
    992.42 ± 14%     -32.4%     671.37 ±  5%  sched_debug.cfs_rq:/.runnable_avg.max
    225.51 ± 18%     -38.5%     138.66 ±  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
    200.33 ± 27%     -63.7%      72.67 ± 14%  sched_debug.cfs_rq:/.util_avg.avg
    992.25 ± 14%     -32.3%     671.30 ±  5%  sched_debug.cfs_rq:/.util_avg.max
    224.89 ± 18%     -38.4%     138.60 ±  6%  sched_debug.cfs_rq:/.util_avg.stddev
     27.88 ± 24%     -75.6%       6.80 ± 24%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    628.83 ± 29%     -71.6%     178.57 ± 22%  sched_debug.cfs_rq:/.util_est_enqueued.max
    102.27 ± 24%     -72.0%      28.59 ± 21%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    810654 ±  5%     +14.8%     930886        sched_debug.cpu.avg_idle.avg
    215092 ± 19%     -31.7%     146899 ±  4%  sched_debug.cpu.avg_idle.stddev
     54920 ± 20%    +293.5%     216119 ± 33%  sched_debug.cpu.clock.avg
     54925 ± 20%    +293.5%     216123 ± 33%  sched_debug.cpu.clock.max
     54913 ± 20%    +293.6%     216114 ± 33%  sched_debug.cpu.clock.min
     54407 ± 20%    +289.8%     212090 ± 33%  sched_debug.cpu.clock_task.avg
     54551 ± 20%    +289.3%     212373 ± 33%  sched_debug.cpu.clock_task.max
     49667 ± 22%    +317.2%     207221 ± 34%  sched_debug.cpu.clock_task.min
    239.19 ± 21%     -36.4%     152.14 ±  5%  sched_debug.cpu.curr->pid.avg
      3888 ± 15%     +92.2%       7474 ± 23%  sched_debug.cpu.curr->pid.max
    682415 ±  7%     -20.0%     545972 ±  2%  sched_debug.cpu.max_idle_balance_cost.max
     21948 ± 23%     -73.8%       5743 ± 36%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ± 17%     -50.1%       0.00 ±  7%  sched_debug.cpu.next_balance.stddev
      0.10 ± 26%     -57.9%       0.04 ± 14%  sched_debug.cpu.nr_running.avg
      0.28 ± 14%     -35.1%       0.18 ±  5%  sched_debug.cpu.nr_running.stddev
      3082 ± 22%     +38.0%       4252 ± 25%  sched_debug.cpu.nr_switches.avg
     14311 ± 20%    +407.3%      72606 ± 48%  sched_debug.cpu.nr_switches.max
      1904 ± 19%    +311.4%       7836 ± 44%  sched_debug.cpu.nr_switches.stddev
      0.55 ± 43%    +124.8%       1.23 ±  4%  sched_debug.cpu.nr_uninterruptible.avg
     54916 ± 20%    +293.5%     216115 ± 33%  sched_debug.cpu_clk
     54422 ± 20%    +296.2%     215601 ± 33%  sched_debug.ktime
     55284 ± 20%    +291.6%     216494 ± 33%  sched_debug.sched_clk
      4534 ±  6%     -37.0%       2857 ±  5%  slabinfo.Acpi-Parse.active_objs
      4534 ±  6%     -37.0%       2857 ±  5%  slabinfo.Acpi-Parse.num_objs
      1667           -62.0%     634.20 ± 10%  slabinfo.bdev_cache.active_objs
      1667           -62.0%     634.20 ± 10%  slabinfo.bdev_cache.num_objs
      2916 ±  6%     -32.9%       1957 ± 15%  slabinfo.dmaengine-unmap-16.active_objs
      2916 ±  6%     -32.9%       1957 ± 15%  slabinfo.dmaengine-unmap-16.num_objs
      2500 ±  4%     -31.9%       1701 ±  4%  slabinfo.file_lock_cache.active_objs
      2500 ±  4%     -31.9%       1701 ±  4%  slabinfo.file_lock_cache.num_objs
      8070 ±  6%     -42.9%       4611 ±  8%  slabinfo.fsnotify_mark_connector.active_objs
      8070 ±  6%     -42.9%       4611 ±  8%  slabinfo.fsnotify_mark_connector.num_objs
    109405           -12.6%      95625        slabinfo.kernfs_node_cache.active_objs
      3425           -12.8%       2987        slabinfo.kernfs_node_cache.active_slabs
    109641           -12.8%      95625        slabinfo.kernfs_node_cache.num_objs
      3425           -12.8%       2987        slabinfo.kernfs_node_cache.num_slabs
     46371           -16.0%      38934 ±  3%  slabinfo.kmalloc-16.num_objs
      7232           -16.6%       6034 ±  3%  slabinfo.kmalloc-192.num_objs
      7605 ±  2%     -14.9%       6472 ±  3%  slabinfo.kmalloc-1k.active_objs
      8567 ±  2%     -20.5%       6811 ±  3%  slabinfo.kmalloc-1k.num_objs
      9644 ±  2%      -9.5%       8724 ±  3%  slabinfo.kmalloc-256.active_objs
      9924           -11.0%       8829 ±  2%  slabinfo.kmalloc-256.num_objs
      8117 ±  3%      -9.8%       7321 ±  2%  slabinfo.kmalloc-2k.num_objs
      2235           -10.6%       1997 ±  3%  slabinfo.kmalloc-4k.num_objs
     71195 ±  2%     -17.5%      58702        slabinfo.kmalloc-8.active_objs
     71456 ±  2%     -17.1%      59235        slabinfo.kmalloc-8.num_objs
      5918           +21.1%       7170 ±  2%  slabinfo.kmalloc-96.active_objs
      6963 ±  2%     +14.0%       7937 ±  3%  slabinfo.kmalloc-96.num_objs
      3483           -61.8%       1332 ± 10%  slabinfo.kmalloc-rcl-192.active_objs
      3483           -61.8%       1332 ± 10%  slabinfo.kmalloc-rcl-192.num_objs
      7253           -17.7%       5968        slabinfo.kmalloc-rcl-512.active_objs
      7269           -17.9%       5968        slabinfo.kmalloc-rcl-512.num_objs
      7652 ±  9%     -20.9%       6049 ±  2%  slabinfo.kmalloc-rcl-64.active_objs
      7652 ±  9%     -20.9%       6049 ±  2%  slabinfo.kmalloc-rcl-64.num_objs
      2832 ± 11%     -23.0%       2181 ±  6%  slabinfo.kmalloc-rcl-96.active_objs
      2832 ± 11%     -23.0%       2181 ±  6%  slabinfo.kmalloc-rcl-96.num_objs
     13921           +11.2%      15477        slabinfo.proc_inode_cache.active_objs
     13928           +11.3%      15499        slabinfo.proc_inode_cache.num_objs
      1325           -64.6%     468.60 ±  8%  slabinfo.request_queue.active_objs
      1325           -64.6%     468.60 ±  8%  slabinfo.request_queue.num_objs
      6505           -19.6%       5227 ±  2%  slabinfo.shmem_inode_cache.active_objs
      6505           -19.6%       5227 ±  2%  slabinfo.shmem_inode_cache.num_objs
      4913 ±  2%     -14.8%       4188 ±  6%  slabinfo.skbuff_head_cache.active_objs
      4953 ±  2%     -14.9%       4216 ±  7%  slabinfo.skbuff_head_cache.num_objs
      5254 ±  2%     -14.1%       4514 ±  2%  slabinfo.trace_event_file.active_objs
      5254 ±  2%     -14.1%       4514 ±  2%  slabinfo.trace_event_file.num_objs
     11601           +53.1%      17762 ±  3%  slabinfo.vmap_area.active_objs
     11618           +53.3%      17808 ±  4%  slabinfo.vmap_area.num_objs
    130.67 ±  2%    +554.2%     854.80 ± 35%  interrupts.9:IO-APIC.9-fasteoi.acpi
     64335 ±  2%     +17.8%      75806 ±  8%  interrupts.CAL:Function_call_interrupts
    126231 ±  6%    +576.8%     854314 ± 35%  interrupts.CPU0.LOC:Local_timer_interrupts
     18.83 ± 29%    +235.6%      63.20 ± 76%  interrupts.CPU0.RES:Rescheduling_interrupts
    130.67 ±  2%    +554.2%     854.80 ± 35%  interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
    126143 ±  7%    +577.3%     854306 ± 35%  interrupts.CPU1.LOC:Local_timer_interrupts
    301.33 ± 26%     -51.7%     145.40 ± 27%  interrupts.CPU1.NMI:Non-maskable_interrupts
    301.33 ± 26%     -51.7%     145.40 ± 27%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    125919 ±  7%    +578.3%     854111 ± 35%  interrupts.CPU10.LOC:Local_timer_interrupts
    125968 ±  7%    +578.0%     854099 ± 35%  interrupts.CPU11.LOC:Local_timer_interrupts
    126177 ±  7%    +576.9%     854130 ± 35%  interrupts.CPU12.LOC:Local_timer_interrupts
    126017 ±  7%    +577.9%     854234 ± 35%  interrupts.CPU13.LOC:Local_timer_interrupts
    125936 ±  7%    +578.4%     854306 ± 35%  interrupts.CPU14.LOC:Local_timer_interrupts
    126056 ±  7%    +577.6%     854125 ± 35%  interrupts.CPU15.LOC:Local_timer_interrupts
    126016 ±  7%    +577.8%     854100 ± 35%  interrupts.CPU16.LOC:Local_timer_interrupts
    125975 ±  7%    +578.0%     854122 ± 35%  interrupts.CPU17.LOC:Local_timer_interrupts
    126066 ±  7%    +577.5%     854157 ± 35%  interrupts.CPU18.LOC:Local_timer_interrupts
    125915 ±  7%    +578.4%     854231 ± 35%  interrupts.CPU19.LOC:Local_timer_interrupts
    241.67 ± 20%     -41.1%     142.40 ± 42%  interrupts.CPU19.NMI:Non-maskable_interrupts
    241.67 ± 20%     -41.1%     142.40 ± 42%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
    126113 ±  7%    +577.3%     854158 ± 35%  interrupts.CPU2.LOC:Local_timer_interrupts
    126017 ±  7%    +577.8%     854132 ± 35%  interrupts.CPU20.LOC:Local_timer_interrupts
    194.33 ± 31%     -37.9%     120.60 ± 41%  interrupts.CPU20.NMI:Non-maskable_interrupts
    194.33 ± 31%     -37.9%     120.60 ± 41%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
    125982 ±  7%    +578.0%     854166 ± 35%  interrupts.CPU21.LOC:Local_timer_interrupts
    126030 ±  7%    +577.7%     854123 ± 35%  interrupts.CPU22.LOC:Local_timer_interrupts
    126070 ±  7%    +577.6%     854202 ± 35%  interrupts.CPU23.LOC:Local_timer_interrupts
    127041 ±  5%    +572.2%     853950 ± 35%  interrupts.CPU24.LOC:Local_timer_interrupts
    694.00 ± 12%     -16.1%     582.00 ±  5%  interrupts.CPU25.CAL:Function_call_interrupts
    126977 ±  5%    +572.7%     854144 ± 35%  interrupts.CPU25.LOC:Local_timer_interrupts
    127109 ±  5%    +572.0%     854131 ± 35%  interrupts.CPU26.LOC:Local_timer_interrupts
    127002 ±  5%    +572.5%     854109 ± 35%  interrupts.CPU27.LOC:Local_timer_interrupts
    126937 ±  5%    +572.8%     854088 ± 35%  interrupts.CPU28.LOC:Local_timer_interrupts
    225.00 ± 27%     -46.4%     120.60 ± 41%  interrupts.CPU28.NMI:Non-maskable_interrupts
    225.00 ± 27%     -46.4%     120.60 ± 41%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
    127021 ±  5%    +572.6%     854378 ± 35%  interrupts.CPU29.LOC:Local_timer_interrupts
    125901 ±  7%    +578.5%     854289 ± 35%  interrupts.CPU3.LOC:Local_timer_interrupts
    127027 ±  5%    +572.3%     854066 ± 35%  interrupts.CPU30.LOC:Local_timer_interrupts
    693.67 ±  5%     -11.7%     612.20 ±  2%  interrupts.CPU31.CAL:Function_call_interrupts
    127143 ±  5%    +571.8%     854089 ± 35%  interrupts.CPU31.LOC:Local_timer_interrupts
    127006 ±  5%    +572.4%     854043 ± 35%  interrupts.CPU32.LOC:Local_timer_interrupts
    127054 ±  5%    +572.2%     854086 ± 35%  interrupts.CPU33.LOC:Local_timer_interrupts
    127025 ±  5%    +572.5%     854227 ± 35%  interrupts.CPU34.LOC:Local_timer_interrupts
    126986 ±  5%    +572.7%     854252 ± 35%  interrupts.CPU35.LOC:Local_timer_interrupts
    127205 ±  5%    +571.4%     854089 ± 35%  interrupts.CPU36.LOC:Local_timer_interrupts
    127104 ±  5%    +572.0%     854113 ± 35%  interrupts.CPU37.LOC:Local_timer_interrupts
    127080 ±  5%    +572.1%     854115 ± 35%  interrupts.CPU38.LOC:Local_timer_interrupts
    127098 ±  5%    +572.0%     854142 ± 35%  interrupts.CPU39.LOC:Local_timer_interrupts
    125973 ±  7%    +578.1%     854277 ± 35%  interrupts.CPU4.LOC:Local_timer_interrupts
    127058 ±  5%    +572.2%     854041 ± 35%  interrupts.CPU40.LOC:Local_timer_interrupts
    126956 ±  5%    +572.7%     854066 ± 35%  interrupts.CPU41.LOC:Local_timer_interrupts
    237.50 ± 32%     -33.0%     159.20 ± 28%  interrupts.CPU41.NMI:Non-maskable_interrupts
    237.50 ± 32%     -33.0%     159.20 ± 28%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    127173 ±  5%    +571.6%     854048 ± 35%  interrupts.CPU42.LOC:Local_timer_interrupts
    127129 ±  5%    +571.8%     854074 ± 35%  interrupts.CPU43.LOC:Local_timer_interrupts
    255.00 ± 14%     -49.1%     129.80 ± 50%  interrupts.CPU43.NMI:Non-maskable_interrupts
    255.00 ± 14%     -49.1%     129.80 ± 50%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
    126971 ±  5%    +572.6%     854069 ± 35%  interrupts.CPU44.LOC:Local_timer_interrupts
    680.67 ±  7%     -16.4%     569.00 ±  5%  interrupts.CPU45.CAL:Function_call_interrupts
    126984 ±  5%    +572.6%     854054 ± 35%  interrupts.CPU45.LOC:Local_timer_interrupts
    126996 ±  5%    +572.5%     854065 ± 35%  interrupts.CPU46.LOC:Local_timer_interrupts
    127020 ±  5%    +572.5%     854151 ± 35%  interrupts.CPU47.LOC:Local_timer_interrupts
    126153 ±  7%    +577.1%     854165 ± 35%  interrupts.CPU48.LOC:Local_timer_interrupts
    126196 ±  7%    +576.9%     854204 ± 35%  interrupts.CPU49.LOC:Local_timer_interrupts
    126038 ±  7%    +577.7%     854208 ± 35%  interrupts.CPU5.LOC:Local_timer_interrupts
    188.33 ± 26%     -35.6%     121.20 ± 42%  interrupts.CPU5.NMI:Non-maskable_interrupts
    188.33 ± 26%     -35.6%     121.20 ± 42%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
    126052 ±  7%    +577.7%     854242 ± 35%  interrupts.CPU50.LOC:Local_timer_interrupts
    249.67 ± 24%     -45.1%     137.00 ± 30%  interrupts.CPU50.NMI:Non-maskable_interrupts
    249.67 ± 24%     -45.1%     137.00 ± 30%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
    126056 ±  7%    +577.6%     854210 ± 35%  interrupts.CPU51.LOC:Local_timer_interrupts
    126122 ±  7%    +577.3%     854190 ± 35%  interrupts.CPU52.LOC:Local_timer_interrupts
    126114 ±  7%    +577.2%     854071 ± 35%  interrupts.CPU53.LOC:Local_timer_interrupts
    126093 ±  7%    +577.4%     854189 ± 35%  interrupts.CPU54.LOC:Local_timer_interrupts
    126033 ±  7%    +577.7%     854160 ± 35%  interrupts.CPU55.LOC:Local_timer_interrupts
    126052 ±  7%    +577.6%     854149 ± 35%  interrupts.CPU56.LOC:Local_timer_interrupts
    126164 ±  7%    +577.0%     854160 ± 35%  interrupts.CPU57.LOC:Local_timer_interrupts
    126121 ±  7%    +577.3%     854235 ± 35%  interrupts.CPU58.LOC:Local_timer_interrupts
    126149 ±  7%    +577.1%     854139 ± 35%  interrupts.CPU59.LOC:Local_timer_interrupts
    126054 ±  7%    +577.6%     854153 ± 35%  interrupts.CPU6.LOC:Local_timer_interrupts
    126163 ±  7%    +577.0%     854155 ± 35%  interrupts.CPU60.LOC:Local_timer_interrupts
    126224 ±  7%    +576.7%     854173 ± 35%  interrupts.CPU61.LOC:Local_timer_interrupts
    237.67 ± 25%     -40.9%     140.40 ± 41%  interrupts.CPU61.NMI:Non-maskable_interrupts
    237.67 ± 25%     -40.9%     140.40 ± 41%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
    126076 ±  7%    +577.6%     854298 ± 35%  interrupts.CPU62.LOC:Local_timer_interrupts
    126133 ±  7%    +577.3%     854256 ± 35%  interrupts.CPU63.LOC:Local_timer_interrupts
    126027 ±  7%    +577.7%     854111 ± 35%  interrupts.CPU64.LOC:Local_timer_interrupts
    126134 ±  7%    +577.2%     854227 ± 35%  interrupts.CPU65.LOC:Local_timer_interrupts
    244.33 ± 24%     -36.8%     154.40 ± 26%  interrupts.CPU65.NMI:Non-maskable_interrupts
    244.33 ± 24%     -36.8%     154.40 ± 26%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
    126229 ±  7%    +576.7%     854235 ± 35%  interrupts.CPU66.LOC:Local_timer_interrupts
    126204 ±  7%    +576.9%     854258 ± 35%  interrupts.CPU67.LOC:Local_timer_interrupts
    213.00 ± 19%     -27.7%     154.00 ± 30%  interrupts.CPU67.NMI:Non-maskable_interrupts
    213.00 ± 19%     -27.7%     154.00 ± 30%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
    126118 ±  7%    +577.4%     854274 ± 35%  interrupts.CPU68.LOC:Local_timer_interrupts
    201.17 ± 21%     -33.5%     133.80 ± 27%  interrupts.CPU68.NMI:Non-maskable_interrupts
    201.17 ± 21%     -33.5%     133.80 ± 27%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
    126027 ±  7%    +578.0%     854480 ± 35%  interrupts.CPU69.LOC:Local_timer_interrupts
    126293 ±  7%    +576.3%     854077 ± 35%  interrupts.CPU7.LOC:Local_timer_interrupts
    126122 ±  7%    +577.3%     854218 ± 35%  interrupts.CPU70.LOC:Local_timer_interrupts
    192.00 ± 21%     -27.7%     138.80 ± 37%  interrupts.CPU70.NMI:Non-maskable_interrupts
    192.00 ± 21%     -27.7%     138.80 ± 37%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
    126046 ±  7%    +577.7%     854240 ± 35%  interrupts.CPU71.LOC:Local_timer_interrupts
    127174 ±  5%    +571.5%     853961 ± 35%  interrupts.CPU72.LOC:Local_timer_interrupts
    127044 ±  5%    +572.4%     854189 ± 35%  interrupts.CPU73.LOC:Local_timer_interrupts
    127124 ±  5%    +571.9%     854185 ± 35%  interrupts.CPU74.LOC:Local_timer_interrupts
    127077 ±  5%    +572.1%     854122 ± 35%  interrupts.CPU75.LOC:Local_timer_interrupts
    127146 ±  5%    +571.7%     854070 ± 35%  interrupts.CPU76.LOC:Local_timer_interrupts
    127110 ±  5%    +572.0%     854139 ± 35%  interrupts.CPU77.LOC:Local_timer_interrupts
    127083 ±  5%    +572.1%     854128 ± 35%  interrupts.CPU78.LOC:Local_timer_interrupts
    127160 ±  5%    +571.7%     854154 ± 35%  interrupts.CPU79.LOC:Local_timer_interrupts
    125986 ±  7%    +577.9%     854097 ± 35%  interrupts.CPU8.LOC:Local_timer_interrupts
    127148 ±  5%    +571.7%     854087 ± 35%  interrupts.CPU80.LOC:Local_timer_interrupts
    127217 ±  5%    +571.5%     854274 ± 35%  interrupts.CPU81.LOC:Local_timer_interrupts
    127216 ±  5%    +571.6%     854404 ± 35%  interrupts.CPU82.LOC:Local_timer_interrupts
    127167 ±  5%    +571.6%     854104 ± 35%  interrupts.CPU83.LOC:Local_timer_interrupts
    127120 ±  5%    +571.9%     854118 ± 35%  interrupts.CPU84.LOC:Local_timer_interrupts
    127230 ±  5%    +571.3%     854106 ± 35%  interrupts.CPU85.LOC:Local_timer_interrupts
    127365 ±  5%    +570.6%     854061 ± 35%  interrupts.CPU86.LOC:Local_timer_interrupts
    127209 ±  5%    +571.5%     854226 ± 35%  interrupts.CPU87.LOC:Local_timer_interrupts
    127209 ±  5%    +571.8%     854573 ± 35%  interrupts.CPU88.LOC:Local_timer_interrupts
    127360 ±  5%    +570.6%     854090 ± 35%  interrupts.CPU89.LOC:Local_timer_interrupts
    126109 ±  7%    +577.3%     854152 ± 35%  interrupts.CPU9.LOC:Local_timer_interrupts
    249.50 ± 37%     -44.0%     139.80 ± 39%  interrupts.CPU9.NMI:Non-maskable_interrupts
    249.50 ± 37%     -44.0%     139.80 ± 39%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    127390 ±  5%    +570.5%     854097 ± 35%  interrupts.CPU90.LOC:Local_timer_interrupts
    127226 ±  5%    +571.5%     854322 ± 35%  interrupts.CPU91.LOC:Local_timer_interrupts
    127152 ±  5%    +571.7%     854076 ± 35%  interrupts.CPU92.LOC:Local_timer_interrupts
    714.17 ± 17%     -17.2%     591.40 ±  2%  interrupts.CPU93.CAL:Function_call_interrupts
    127081 ±  5%    +572.1%     854072 ± 35%  interrupts.CPU93.LOC:Local_timer_interrupts
    127151 ±  5%    +571.8%     854146 ± 35%  interrupts.CPU94.LOC:Local_timer_interrupts
    229.50 ± 22%     -39.9%     138.00 ± 40%  interrupts.CPU94.NMI:Non-maskable_interrupts
    229.50 ± 22%     -39.9%     138.00 ± 40%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
    127115 ±  5%    +572.0%     854207 ± 35%  interrupts.CPU95.LOC:Local_timer_interrupts
    216.67 ± 25%     -36.2%     138.20 ± 39%  interrupts.CPU95.NMI:Non-maskable_interrupts
    216.67 ± 25%     -36.2%     138.20 ± 39%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
  12153208 ±  6%    +574.7%   81999844 ± 35%  interrupts.LOC:Local_timer_interrupts
      0.00       +1.2e+104%     115.20 ± 33%  interrupts.MCP:Machine_check_polls
     19276 ±  4%     -28.1%      13864 ± 29%  interrupts.NMI:Non-maskable_interrupts
     19276 ±  4%     -28.1%      13864 ± 29%  interrupts.PMI:Performance_monitoring_interrupts
     11990 ± 20%    +106.2%      24718 ± 24%  softirqs.CPU0.RCU
     11127 ±  8%    +368.5%      52128 ± 35%  softirqs.CPU0.SCHED
      9048 ±  8%    +164.2%      23907 ± 27%  softirqs.CPU1.RCU
      9713 ± 14%    +452.0%      53621 ± 30%  softirqs.CPU1.SCHED
      8948 ±  9%    +168.0%      23987 ± 29%  softirqs.CPU10.RCU
      9207 ± 10%    +475.0%      52939 ± 31%  softirqs.CPU10.SCHED
      8895 ±  9%    +168.0%      23841 ± 28%  softirqs.CPU11.RCU
      8900 ±  6%    +492.7%      52750 ± 31%  softirqs.CPU11.SCHED
      8276 ±  9%    +537.7%      52781 ± 31%  softirqs.CPU12.SCHED
      8685 ±  7%    +174.1%      23808 ± 27%  softirqs.CPU13.RCU
      9251 ±  4%    +469.9%      52726 ± 31%  softirqs.CPU13.SCHED
      9028 ± 10%    +165.2%      23940 ± 29%  softirqs.CPU14.RCU
      8380 ±  6%    +527.1%      52555 ± 31%  softirqs.CPU14.SCHED
      8989 ±  9%    +158.7%      23256 ± 29%  softirqs.CPU15.RCU
      8629 ±  6%    +468.9%      49097 ± 41%  softirqs.CPU15.SCHED
      8274 ±  6%    +172.6%      22552 ± 30%  softirqs.CPU16.RCU
      8886 ±  7%    +499.9%      53308 ± 31%  softirqs.CPU16.SCHED
      8146 ±  4%    +181.3%      22920 ± 28%  softirqs.CPU17.RCU
      9146 ±  4%    +478.6%      52923 ± 31%  softirqs.CPU17.SCHED
      7715 ±  3%    +150.1%      19297 ± 41%  softirqs.CPU18.RCU
      6730 ± 20%    +618.0%      48325 ± 40%  softirqs.CPU18.SCHED
      8009 ±  3%    +160.7%      20879 ± 35%  softirqs.CPU19.RCU
      8869 ± 10%    +495.7%      52840 ± 31%  softirqs.CPU19.SCHED
      8886 ± 18%    +499.3%      53256 ± 31%  softirqs.CPU2.SCHED
      8229 ±  5%    +174.1%      22554 ± 29%  softirqs.CPU20.RCU
      8380 ±  7%    +532.4%      52998 ± 31%  softirqs.CPU20.SCHED
      8158 ±  5%    +180.1%      22854 ± 31%  softirqs.CPU21.RCU
      8929 ±  7%    +410.7%      45606 ± 48%  softirqs.CPU21.SCHED
      9184 ± 14%    +149.4%      22905 ± 30%  softirqs.CPU22.RCU
      8740 ±  9%    +506.0%      52965 ± 31%  softirqs.CPU22.SCHED
      8322 ±  3%    +172.8%      22706 ± 32%  softirqs.CPU23.RCU
      7366 ± 13%    +620.3%      53058 ± 31%  softirqs.CPU23.SCHED
      8376 ±  5%    +156.5%      21482 ± 34%  softirqs.CPU24.RCU
      8021 ± 12%    +564.1%      53264 ± 31%  softirqs.CPU24.SCHED
      7646 ±  4%    +167.4%      20446 ± 36%  softirqs.CPU25.RCU
      8693 ±  8%    +506.9%      52759 ± 31%  softirqs.CPU25.SCHED
      7470 ±  6%    +172.6%      20364 ± 37%  softirqs.CPU26.RCU
      8881 ±  8%    +440.4%      47995 ± 40%  softirqs.CPU26.SCHED
      7941 ±  7%    +167.0%      21201 ± 31%  softirqs.CPU27.RCU
      8574 ± 10%    +517.0%      52902 ± 30%  softirqs.CPU27.SCHED
      8560 ±  5%    +151.1%      21493 ± 32%  softirqs.CPU28.RCU
      8786 ±  6%    +503.9%      53066 ± 31%  softirqs.CPU28.SCHED
      8010 ±  8%    +167.9%      21463 ± 33%  softirqs.CPU29.RCU
      7578 ± 20%    +543.7%      48781 ± 41%  softirqs.CPU29.SCHED
      9251 ±  8%    +163.6%      24386 ± 26%  softirqs.CPU3.RCU
      8600 ± 10%    +513.3%      52741 ± 31%  softirqs.CPU3.SCHED
      8057 ±  5%    +165.9%      21421 ± 34%  softirqs.CPU30.RCU
      6740 ± 34%    +690.7%      53294 ± 30%  softirqs.CPU30.SCHED
      7713 ±  8%    +173.1%      21066 ± 34%  softirqs.CPU31.RCU
      8424 ± 12%    +527.3%      52847 ± 31%  softirqs.CPU31.SCHED
      8584 ±  8%    +157.3%      22089 ± 30%  softirqs.CPU32.RCU
      8525 ± 11%    +529.0%      53628 ± 29%  softirqs.CPU32.SCHED
      8509 ±  6%    +157.4%      21901 ± 30%  softirqs.CPU33.RCU
      8787 ±  9%    +503.4%      53023 ± 30%  softirqs.CPU33.SCHED
      9203 ± 12%    +145.0%      22551 ± 28%  softirqs.CPU34.RCU
      7167 ± 28%    +638.7%      52945 ± 31%  softirqs.CPU34.SCHED
      8799 ±  7%    +156.0%      22524 ± 29%  softirqs.CPU35.RCU
      8926 ±  5%    +492.1%      52851 ± 30%  softirqs.CPU35.SCHED
      8629 ±  7%    +152.4%      21783 ± 31%  softirqs.CPU36.RCU
      9118 ±  6%    +480.3%      52908 ± 31%  softirqs.CPU36.SCHED
      8645 ±  8%    +152.9%      21865 ± 29%  softirqs.CPU37.RCU
      9224 ±  4%    +471.9%      52750 ± 31%  softirqs.CPU37.SCHED
      8586 ±  7%    +160.0%      22321 ± 29%  softirqs.CPU38.RCU
      8343 ± 17%    +490.1%      49238 ± 18%  softirqs.CPU38.SCHED
      8469 ±  5%    +142.9%      20576 ± 24%  softirqs.CPU39.RCU
      8647 ±  6%    +512.2%      52937 ± 31%  softirqs.CPU39.SCHED
      9134 ±  6%    +153.4%      23148 ± 23%  softirqs.CPU4.RCU
      8433 ± 17%    +527.5%      52919 ± 31%  softirqs.CPU4.SCHED
      8718 ±  8%    +158.8%      22559 ± 28%  softirqs.CPU40.RCU
      8368 ± 11%    +489.4%      49327 ± 40%  softirqs.CPU40.SCHED
      8960 ±  9%    +154.7%      22818 ± 29%  softirqs.CPU41.RCU
      8311 ± 12%    +536.4%      52892 ± 30%  softirqs.CPU41.SCHED
      8472 ±  8%    +143.7%      20649 ± 36%  softirqs.CPU42.RCU
      8410 ± 12%    +471.6%      48068 ± 41%  softirqs.CPU42.SCHED
      8826 ±  9%    +153.6%      22381 ± 29%  softirqs.CPU43.RCU
      8618 ± 14%    +513.0%      52831 ± 31%  softirqs.CPU43.SCHED
      8622 ± 11%    +159.1%      22338 ± 29%  softirqs.CPU44.RCU
      8792 ±  7%    +501.2%      52857 ± 31%  softirqs.CPU44.SCHED
      8618 ±  8%    +156.5%      22104 ± 29%  softirqs.CPU45.RCU
      8866 ±  8%    +495.6%      52802 ± 31%  softirqs.CPU45.SCHED
      8801 ± 10%    +158.8%      22776 ± 30%  softirqs.CPU46.RCU
      8485 ± 10%    +439.2%      45754 ±  5%  softirqs.CPU46.SCHED
      8926 ±  9%    +153.3%      22607 ± 30%  softirqs.CPU47.RCU
      8670 ± 16%    +431.0%      46039 ± 45%  softirqs.CPU47.SCHED
      8019 ±  4%    +159.2%      20788 ± 34%  softirqs.CPU48.RCU
      8097 ±  9%    +311.2%      33294 ± 32%  softirqs.CPU48.SCHED
      8364 ± 11%    +170.3%      22612 ± 26%  softirqs.CPU49.RCU
      8489 ±  7%    +527.0%      53230 ± 32%  softirqs.CPU49.SCHED
      9054 ± 10%    +166.5%      24130 ± 27%  softirqs.CPU5.RCU
      8790 ±  7%    +501.6%      52878 ± 31%  softirqs.CPU5.SCHED
      8376 ±  4%    +157.2%      21540 ± 27%  softirqs.CPU50.RCU
      8395 ± 19%    +489.1%      49462 ± 40%  softirqs.CPU50.SCHED
      8730 ±  6%    +174.7%      23986 ± 26%  softirqs.CPU51.RCU
      8108 ± 10%    +564.6%      53889 ± 33%  softirqs.CPU51.SCHED
      9222 ±  9%    +149.2%      22985 ± 24%  softirqs.CPU52.RCU
      7994 ± 10%    +595.0%      55563 ± 37%  softirqs.CPU52.SCHED
      9393 ±  8%    +150.7%      23543 ± 27%  softirqs.CPU53.RCU
      8616 ± 14%    +525.4%      53882 ± 32%  softirqs.CPU53.SCHED
      9025 ±  9%    +162.0%      23648 ± 28%  softirqs.CPU54.RCU
      8074 ± 14%    +566.0%      53775 ± 32%  softirqs.CPU54.SCHED
      8500 ±  8%    +170.4%      22980 ± 27%  softirqs.CPU55.RCU
      8812 ± 15%    +504.5%      53266 ± 32%  softirqs.CPU55.SCHED
      8646 ±  8%    +169.5%      23298 ± 27%  softirqs.CPU56.RCU
      8666 ± 11%    +521.5%      53863 ± 32%  softirqs.CPU56.SCHED
      8567 ±  7%    +167.1%      22885 ± 28%  softirqs.CPU57.RCU
      8606 ± 10%    +476.8%      49641 ± 42%  softirqs.CPU57.SCHED
      8937 ±  9%    +167.1%      23869 ± 27%  softirqs.CPU58.RCU
      7639 ± 15%    +612.4%      54421 ± 32%  softirqs.CPU58.SCHED
      8777 ±  9%    +169.7%      23673 ± 27%  softirqs.CPU59.RCU
      8513 ± 19%    +532.4%      53839 ± 32%  softirqs.CPU59.SCHED
      9439 ±  9%    +158.8%      24425 ± 26%  softirqs.CPU6.RCU
      7630 ±  9%    +548.1%      49453 ± 40%  softirqs.CPU6.SCHED
      8424 ±  7%    +166.7%      22464 ± 28%  softirqs.CPU60.RCU
      8370 ±  8%    +537.9%      53392 ± 32%  softirqs.CPU60.SCHED
      8895 ±  9%    +161.9%      23300 ± 27%  softirqs.CPU61.RCU
      8149 ± 11%    +527.3%      51121 ± 38%  softirqs.CPU61.SCHED
      8864 ± 12%    +163.0%      23312 ± 27%  softirqs.CPU62.RCU
      8360 ±  8%    +545.1%      53930 ± 32%  softirqs.CPU62.SCHED
      8590 ± 10%    +161.8%      22493 ± 30%  softirqs.CPU63.RCU
      8480 ±  7%    +484.2%      49544 ± 42%  softirqs.CPU63.SCHED
      7934 ±  6%    +183.8%      22517 ± 31%  softirqs.CPU64.RCU
      8260 ±  7%    +551.3%      53800 ± 32%  softirqs.CPU64.SCHED
      8135 ±  5%    +176.5%      22493 ± 29%  softirqs.CPU65.RCU
      8338 ±  8%    +500.2%      50044 ± 42%  softirqs.CPU65.SCHED
      7668 ±  5%    +162.3%      20111 ± 34%  softirqs.CPU66.RCU
      7824 ± 14%    +582.1%      53370 ± 31%  softirqs.CPU66.SCHED
      8484 ± 20%    +149.5%      21171 ± 31%  softirqs.CPU67.RCU
      8050 ± 13%    +562.9%      53367 ± 32%  softirqs.CPU67.SCHED
      7934 ±  4%    +184.2%      22546 ± 29%  softirqs.CPU68.RCU
      9050 ±  3%    +496.6%      53993 ± 32%  softirqs.CPU68.SCHED
      8041 ±  5%    +178.5%      22394 ± 29%  softirqs.CPU69.RCU
      8480 ± 11%    +468.6%      48222 ± 48%  softirqs.CPU69.SCHED
      8986 ±  8%    +163.9%      23719 ± 28%  softirqs.CPU7.RCU
      7811 ± 12%    +572.5%      52534 ± 31%  softirqs.CPU7.SCHED
      8318 ±  7%    +170.5%      22502 ± 28%  softirqs.CPU70.RCU
      8112 ± 10%    +565.0%      53944 ± 32%  softirqs.CPU70.SCHED
      7790 ±  7%    +182.2%      21983 ± 30%  softirqs.CPU71.RCU
      8174 ± 16%    +559.5%      53910 ± 32%  softirqs.CPU71.SCHED
      7782 ±  3%    +169.8%      20993 ± 34%  softirqs.CPU72.RCU
      8655 ±  8%    +489.4%      51020 ± 21%  softirqs.CPU72.SCHED
      7406 ±  5%    +163.5%      19515 ± 39%  softirqs.CPU73.RCU
      8499 ± 10%    +534.6%      53934 ± 31%  softirqs.CPU73.SCHED
      7316 ±  4%    +162.3%      19189 ± 31%  softirqs.CPU74.RCU
      9054 ±  4%    +493.2%      53711 ± 31%  softirqs.CPU74.SCHED
      7731 ±  6%    +151.5%      19446 ± 19%  softirqs.CPU75.RCU
      8411 ±  9%    +546.8%      54400 ± 31%  softirqs.CPU75.SCHED
      7757 ±  6%    +171.3%      21043 ± 33%  softirqs.CPU76.RCU
      8489 ±  6%    +539.1%      54258 ± 31%  softirqs.CPU76.SCHED
      8389 ± 14%    +147.7%      20783 ± 34%  softirqs.CPU77.RCU
      8741 ± 10%    +521.8%      54358 ± 31%  softirqs.CPU77.SCHED
      7971 ±  9%    +165.1%      21131 ± 31%  softirqs.CPU78.RCU
      8870 ±  8%    +511.7%      54263 ± 31%  softirqs.CPU78.SCHED
      7516 ±  7%    +176.3%      20770 ± 33%  softirqs.CPU79.RCU
      7985 ± 15%    +577.1%      54066 ± 31%  softirqs.CPU79.SCHED
      9233 ± 13%    +159.1%      23921 ± 28%  softirqs.CPU8.RCU
      8596 ± 17%    +513.7%      52756 ± 32%  softirqs.CPU8.SCHED
      8593 ±  7%    +148.1%      21319 ± 29%  softirqs.CPU80.RCU
      7578 ± 13%    +616.2%      54278 ± 31%  softirqs.CPU80.SCHED
      8351 ±  5%    +168.5%      22428 ± 26%  softirqs.CPU81.RCU
      8729 ±  7%    +520.6%      54173 ± 31%  softirqs.CPU81.SCHED
      8798 ± 10%    +151.6%      22139 ± 28%  softirqs.CPU82.RCU
      8022 ± 14%    +576.3%      54258 ± 31%  softirqs.CPU82.SCHED
      8546 ±  8%    +157.4%      22000 ± 28%  softirqs.CPU83.RCU
      8757 ±  7%    +518.3%      54146 ± 31%  softirqs.CPU83.SCHED
      8128 ± 10%    +156.9%      20879 ± 28%  softirqs.CPU84.RCU
      8284 ± 10%    +547.1%      53612 ± 31%  softirqs.CPU84.SCHED
      8323 ±  6%    +154.3%      21167 ± 27%  softirqs.CPU85.RCU
      8432 ± 17%    +538.0%      53800 ± 31%  softirqs.CPU85.SCHED
      8489 ± 10%    +156.5%      21772 ± 28%  softirqs.CPU86.RCU
      8023 ± 11%    +531.8%      50688 ± 40%  softirqs.CPU86.SCHED
      8539 ±  6%    +146.8%      21073 ± 30%  softirqs.CPU87.RCU
      8381 ± 10%    +556.2%      54993 ± 30%  softirqs.CPU87.SCHED
      8812 ± 10%    +153.0%      22295 ± 28%  softirqs.CPU88.RCU
      7901 ± 14%    +587.6%      54332 ± 31%  softirqs.CPU88.SCHED
      8992 ± 11%    +145.5%      22076 ± 25%  softirqs.CPU89.RCU
      8814 ± 10%    +518.4%      54509 ± 31%  softirqs.CPU89.SCHED
      8776 ±  7%    +168.3%      23549 ± 28%  softirqs.CPU9.RCU
      9385 ±  5%    +461.5%      52701 ± 31%  softirqs.CPU9.SCHED
      8012 ±  3%    +148.5%      19908 ± 31%  softirqs.CPU90.RCU
      8772 ±  8%    +472.6%      50233 ± 40%  softirqs.CPU90.SCHED
      8607 ±  9%    +153.9%      21857 ± 28%  softirqs.CPU91.RCU
      7992 ±  7%    +577.9%      54180 ± 31%  softirqs.CPU91.SCHED
      8214 ± 12%    +164.2%      21704 ± 28%  softirqs.CPU92.RCU
      7560 ± 18%    +618.0%      54281 ± 31%  softirqs.CPU92.SCHED
      8542 ± 10%    +152.6%      21577 ± 29%  softirqs.CPU93.RCU
      8209 ±  8%    +556.7%      53909 ± 31%  softirqs.CPU93.SCHED
      8954 ± 11%    +151.7%      22540 ± 34%  softirqs.CPU94.RCU
      8108 ± 19%    +568.6%      54216 ± 31%  softirqs.CPU94.SCHED
      8919 ±  7%    +158.4%      23047 ± 27%  softirqs.CPU95.RCU
      8338 ±  8%    +358.3%      38211 ± 65%  softirqs.CPU95.SCHED
    818847 ±  5%    +160.1%    2130203 ± 29%  softirqs.RCU
    811938 ±  2%    +516.6%    5006268 ± 32%  softirqs.SCHED
     20491           +30.3%      26707 ± 26%  softirqs.TIMER
     18.87 ± 10%     -18.9        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     18.28 ± 10%     -18.3        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.15 ±  7%     -16.2        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.59 ±  4%     -15.6        0.00        perf-profile.calltrace.cycles-pp.ret_from_fork
     15.58 ±  4%     -15.6        0.00        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
     15.29 ±  5%     -15.3        0.00        perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
     15.25 ±  5%     -15.2        0.00        perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
     14.39 ±  5%     -14.4        0.00        perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
     13.94 ±  5%     -13.9        0.00        perf-profile.calltrace.cycles-pp.memcpy_toio.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
     12.85 ±  6%     -12.8        0.00        perf-profile.calltrace.cycles-pp.block_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.85 ±  6%     -12.8        0.00        perf-profile.calltrace.cycles-pp.blkdev_ioctl.block_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.77 ±  6%     -12.8        0.00        perf-profile.calltrace.cycles-pp.lo_ioctl.blkdev_ioctl.block_ioctl.__x64_sys_ioctl.do_syscall_64
     10.30 ±  6%     -10.3        0.00        perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.printk.set_capacity_and_notify.cold.loop_set_size
      9.61 ±  6%      -9.6        0.00        perf-profile.calltrace.cycles-pp.serial8250_console_write.console_unlock.vprintk_emit.printk.set_capacity_and_notify.cold
      9.16 ±  6%      -8.8        0.34 ± 81%  perf-profile.calltrace.cycles-pp.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit.printk
      8.47 ±  6%      -8.1        0.33 ± 81%  perf-profile.calltrace.cycles-pp.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit
      8.47 ±  6%      -8.1        0.33 ± 81%  perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock
      6.83 ±  7%      -6.8        0.00        perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write
      6.41 ± 11%      -6.4        0.00        perf-profile.calltrace.cycles-pp.loop_set_size.lo_ioctl.blkdev_ioctl.block_ioctl.__x64_sys_ioctl
      6.41 ± 11%      -6.4        0.00        perf-profile.calltrace.cycles-pp.set_capacity_and_notify.cold.loop_set_size.lo_ioctl.blkdev_ioctl.block_ioctl
      6.41 ± 11%      -6.4        0.00        perf-profile.calltrace.cycles-pp.printk.set_capacity_and_notify.cold.loop_set_size.lo_ioctl.blkdev_ioctl
      6.41 ± 11%      -6.4        0.00        perf-profile.calltrace.cycles-pp.vprintk_emit.printk.set_capacity_and_notify.cold.loop_set_size.lo_ioctl
      6.30 ± 13%      -6.3        0.00        perf-profile.calltrace.cycles-pp.loop_configure.lo_ioctl.blkdev_ioctl.block_ioctl.__x64_sys_ioctl
      6.27 ± 13%      -6.3        0.00        perf-profile.calltrace.cycles-pp.printk.set_capacity_and_notify.cold.loop_set_size.loop_configure.lo_ioctl
      6.27 ± 13%      -6.3        0.00        perf-profile.calltrace.cycles-pp.vprintk_emit.printk.set_capacity_and_notify.cold.loop_set_size.loop_configure
      6.27 ± 13%      -6.3        0.00        perf-profile.calltrace.cycles-pp.loop_set_size.loop_configure.lo_ioctl.blkdev_ioctl.block_ioctl
      6.27 ± 13%      -6.3        0.00        perf-profile.calltrace.cycles-pp.set_capacity_and_notify.cold.loop_set_size.loop_configure.lo_ioctl.blkdev_ioctl
      0.61 ±  8%      +0.4        1.00 ± 15%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.77 ± 10%      +0.5        1.29 ± 14%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.71 ±  7%      +0.6        1.26 ± 28%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.68 ±  8%      +0.6        1.27 ±  9%  perf-profile.calltrace.cycles-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.82 ±  6%      +0.6        2.43 ± 12%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.69 ±  7%      +0.6        1.33 ± 12%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.7        0.69 ± 14%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.84 ± 26%      +0.7        1.53 ± 20%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel
      0.85 ± 26%      +0.7        1.58 ± 18%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.92 ± 24%      +0.8        1.77 ± 13%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.92 ± 24%      +0.8        1.77 ± 13%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.92 ± 24%      +0.8        1.77 ± 13%  perf-profile.calltrace.cycles-pp.start_kernel.secondary_startup_64_no_verify
      1.16 ±  5%      +0.9        2.06 ± 12%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      1.02 ± 10%      +0.9        1.92 ± 23%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.05 ±  9%      +0.9        1.99 ± 21%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      2.24 ±  5%      +0.9        3.19 ± 12%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      2.24 ±  5%      +1.7        3.91 ± 12%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      1.37 ± 21%      +1.9        3.24 ± 51%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      2.36 ±  8%      +1.9        4.25 ± 15%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      2.67 ±  7%      +2.2        4.85 ± 14%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.75 ± 16%      +2.2        3.95 ± 41%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      4.26 ±  9%      +3.3        7.57 ± 18%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      7.68 ±  3%      +5.6       13.32 ± 11%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      7.86 ±  3%      +5.8       13.66 ± 10%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
     12.33 ±  3%      +8.7       21.03 ± 10%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      4.23 ± 10%      +9.1       13.37 ± 42%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     16.39 ±  8%     +16.1       32.45 ± 21%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     56.29 ±  2%     +20.4       76.71 ± 10%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     57.55 ±  3%     +23.6       81.14 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     62.83 ±  3%     +33.6       96.47        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     62.88 ±  3%     +33.7       96.53        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     62.87 ±  3%     +33.7       96.53        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     63.79 ±  3%     +34.5       98.30        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     19.91 ±  9%     -19.0        0.89 ± 13%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     19.24 ±  9%     -18.4        0.84 ± 16%  perf-profile.children.cycles-pp.do_syscall_64
     16.15 ±  7%     -16.2        0.00        perf-profile.children.cycles-pp.__x64_sys_ioctl
     15.61 ±  4%     -15.2        0.38 ± 15%  perf-profile.children.cycles-pp.ret_from_fork
     15.58 ±  4%     -15.2        0.38 ± 15%  perf-profile.children.cycles-pp.kthread
     15.29 ±  5%     -15.1        0.22 ± 16%  perf-profile.children.cycles-pp.worker_thread
     15.25 ±  5%     -15.0        0.22 ± 17%  perf-profile.children.cycles-pp.process_one_work
     14.39 ±  5%     -14.2        0.20 ± 20%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
     14.37 ±  5%     -14.2        0.20 ± 20%  perf-profile.children.cycles-pp.memcpy_toio
     12.85 ±  6%     -12.8        0.00        perf-profile.children.cycles-pp.block_ioctl
     12.85 ±  6%     -12.8        0.00        perf-profile.children.cycles-pp.blkdev_ioctl
     12.77 ±  6%     -12.8        0.00        perf-profile.children.cycles-pp.lo_ioctl
     12.68 ±  6%     -12.7        0.00        perf-profile.children.cycles-pp.loop_set_size
     12.68 ±  6%     -12.7        0.00        perf-profile.children.cycles-pp.set_capacity_and_notify.cold
     13.18 ±  6%     -12.4        0.79 ± 22%  perf-profile.children.cycles-pp.printk
     13.18 ±  6%     -12.4        0.79 ± 22%  perf-profile.children.cycles-pp.vprintk_emit
     10.76 ±  6%     -10.0        0.79 ± 22%  perf-profile.children.cycles-pp.console_unlock
     10.04 ±  6%      -9.3        0.74 ± 23%  perf-profile.children.cycles-pp.serial8250_console_write
      9.58 ±  6%      -8.9        0.73 ± 23%  perf-profile.children.cycles-pp.uart_console_write
      9.29 ±  6%      -8.6        0.72 ± 23%  perf-profile.children.cycles-pp.wait_for_xmitr
      8.85 ±  6%      -8.2        0.70 ± 23%  perf-profile.children.cycles-pp.serial8250_console_putchar
      7.48 ±  7%      -6.9        0.55 ± 28%  perf-profile.children.cycles-pp.io_serial_in
      6.30 ± 13%      -6.3        0.00        perf-profile.children.cycles-pp.loop_configure
      1.80 ± 14%      -1.6        0.17 ± 36%  perf-profile.children.cycles-pp.delay_tsc
      1.72 ± 46%      -1.6        0.12 ± 28%  perf-profile.children.cycles-pp.do_sys_open
      1.71 ± 46%      -1.6        0.12 ± 28%  perf-profile.children.cycles-pp.do_sys_openat2
      1.60 ± 49%      -1.5        0.10 ± 27%  perf-profile.children.cycles-pp.do_filp_open
      1.59 ± 49%      -1.5        0.10 ± 27%  perf-profile.children.cycles-pp.path_openat
      0.70 ±  8%      -0.7        0.03 ± 82%  perf-profile.children.cycles-pp.vt_console_print
      0.67 ±  8%      -0.6        0.03 ± 82%  perf-profile.children.cycles-pp.lf
      0.67 ±  8%      -0.6        0.03 ± 82%  perf-profile.children.cycles-pp.con_scroll
      0.67 ±  8%      -0.6        0.03 ± 82%  perf-profile.children.cycles-pp.fbcon_scroll
      0.66 ±  9%      -0.6        0.03 ± 82%  perf-profile.children.cycles-pp.fbcon_redraw
      0.65 ± 10%      -0.6        0.03 ± 82%  perf-profile.children.cycles-pp.fbcon_putcs
      0.64 ± 11%      -0.6        0.03 ± 82%  perf-profile.children.cycles-pp.bit_putcs
      0.46 ± 11%      -0.3        0.16 ± 26%  perf-profile.children.cycles-pp.rcu_core
      0.44 ±  4%      -0.3        0.14 ± 32%  perf-profile.children.cycles-pp.__schedule
      0.37 ± 18%      -0.3        0.08 ± 22%  perf-profile.children.cycles-pp.link_path_walk
      0.33 ±  5%      -0.3        0.07 ± 45%  perf-profile.children.cycles-pp.schedule
      0.31 ±  9%      -0.2        0.07 ± 57%  perf-profile.children.cycles-pp.walk_component
      0.20 ± 12%      -0.1        0.10 ± 54%  perf-profile.children.cycles-pp._find_next_bit
      0.23 ± 14%      -0.1        0.16 ± 17%  perf-profile.children.cycles-pp.ksys_read
      0.23 ± 14%      -0.1        0.15 ± 16%  perf-profile.children.cycles-pp.vfs_read
      0.16 ± 18%      -0.0        0.11 ± 15%  perf-profile.children.cycles-pp.new_sync_read
      0.05 ± 45%      +0.0        0.09 ± 31%  perf-profile.children.cycles-pp.rcu_needs_cpu
      0.12 ± 20%      +0.1        0.17 ± 21%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.01 ±223%      +0.1        0.06 ± 23%  perf-profile.children.cycles-pp.unmap_page_range
      0.01 ±223%      +0.1        0.06 ± 23%  perf-profile.children.cycles-pp.unmap_vmas
      0.09 ± 14%      +0.1        0.14 ± 19%  perf-profile.children.cycles-pp.bprm_execve
      0.10 ± 18%      +0.1        0.18 ± 24%  perf-profile.children.cycles-pp.do_execveat_common
      0.10 ± 18%      +0.1        0.19 ± 24%  perf-profile.children.cycles-pp.execve
      0.10 ± 18%      +0.1        0.19 ± 24%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.10 ± 16%      +0.1        0.19 ± 28%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_exit
      0.01 ±223%      +0.1        0.12 ± 38%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.16 ± 10%      +0.1        0.27 ± 21%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.15 ± 48%      +0.1        0.27 ± 18%  perf-profile.children.cycles-pp.call_cpuidle
      0.14 ±  9%      +0.1        0.27 ± 24%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.20 ± 22%      +0.1        0.34 ± 26%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.14 ± 18%      +0.1        0.29 ± 38%  perf-profile.children.cycles-pp.__hrtimer_get_next_event
      0.29 ±  7%      +0.2        0.46 ± 28%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.27 ±  7%      +0.2        0.45 ± 12%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.35 ± 13%      +0.2        0.56 ± 25%  perf-profile.children.cycles-pp.update_rq_clock
      0.23 ± 17%      +0.2        0.46 ± 35%  perf-profile.children.cycles-pp.rcu_eqs_exit
      0.19 ± 17%      +0.2        0.43 ± 23%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.20 ± 17%      +0.3        0.45 ± 22%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.29 ± 12%      +0.3        0.56 ±  9%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.30 ± 25%      +0.3        0.61 ± 39%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.30 ± 10%      +0.3        0.62 ± 13%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.55 ±  5%      +0.3        0.87 ± 14%  perf-profile.children.cycles-pp.native_sched_clock
      0.58 ±  5%      +0.3        0.91 ± 13%  perf-profile.children.cycles-pp.sched_clock
      0.28 ± 18%      +0.3        0.62 ± 29%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.43 ± 49%      +0.4        0.79 ± 22%  perf-profile.children.cycles-pp.irq_work_single
      0.43 ± 49%      +0.4        0.79 ± 22%  perf-profile.children.cycles-pp.irq_work_run
      0.43 ± 49%      +0.4        0.79 ± 22%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.43 ± 49%      +0.4        0.79 ± 22%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.43 ± 49%      +0.4        0.79 ± 22%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.46 ± 45%      +0.4        0.83 ± 23%  perf-profile.children.cycles-pp.irq_work_run_list
      0.58 ±  7%      +0.4        0.97 ± 24%  perf-profile.children.cycles-pp.read_tsc
      0.63 ±  9%      +0.4        1.02 ± 15%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.67 ±  5%      +0.4        1.08 ± 12%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.75 ± 13%      +0.5        1.23 ± 25%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.80 ±  8%      +0.5        1.33 ± 14%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.74 ±  5%      +0.6        1.30 ± 28%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.70 ±  7%      +0.7        1.40 ± 11%  perf-profile.children.cycles-pp.rebalance_domains
      1.88 ±  5%      +0.7        2.62 ± 13%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.92 ± 24%      +0.8        1.77 ± 13%  perf-profile.children.cycles-pp.start_kernel
      1.22 ±  4%      +0.9        2.11 ± 12%  perf-profile.children.cycles-pp.scheduler_tick
      1.04 ±  9%      +0.9        1.96 ± 22%  perf-profile.children.cycles-pp.tick_irq_enter
      1.07 ±  8%      +0.9        2.01 ± 21%  perf-profile.children.cycles-pp.irq_enter_rcu
      2.31 ±  5%      +1.1        3.40 ± 13%  perf-profile.children.cycles-pp.irq_exit_rcu
      2.34 ±  5%      +1.7        4.01 ± 12%  perf-profile.children.cycles-pp.update_process_times
      2.44 ±  7%      +1.9        4.32 ± 15%  perf-profile.children.cycles-pp.tick_sched_handle
      1.41 ± 20%      +1.9        3.32 ± 50%  perf-profile.children.cycles-pp.tick_nohz_next_event
      2.78 ±  6%      +2.2        4.95 ± 14%  perf-profile.children.cycles-pp.tick_sched_timer
      1.78 ± 16%      +2.3        4.04 ± 40%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      4.41 ±  9%      +3.3        7.72 ± 18%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      7.92 ±  3%      +5.6       13.51 ± 11%  perf-profile.children.cycles-pp.hrtimer_interrupt
      8.08 ±  3%      +5.8       13.84 ± 11%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
     12.66 ±  3%      +8.6       21.21 ± 10%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      4.30 ± 10%      +9.3       13.56 ± 42%  perf-profile.children.cycles-pp.menu_select
     15.27 ±  4%     +11.9       27.18 ± 15%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     58.38 ±  3%     +24.3       82.69 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter_state
     58.40 ±  3%     +24.3       82.73 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter
     62.88 ±  3%     +33.7       96.53        perf-profile.children.cycles-pp.start_secondary
     63.79 ±  3%     +34.5       98.30        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     63.79 ±  3%     +34.5       98.30        perf-profile.children.cycles-pp.cpu_startup_entry
     63.79 ±  3%     +34.5       98.30        perf-profile.children.cycles-pp.do_idle
     14.29 ±  5%     -14.1        0.20 ± 20%  perf-profile.self.cycles-pp.memcpy_toio
      7.48 ±  7%      -6.9        0.55 ± 28%  perf-profile.self.cycles-pp.io_serial_in
      1.80 ± 14%      -1.6        0.17 ± 36%  perf-profile.self.cycles-pp.delay_tsc
      0.20 ± 13%      -0.1        0.10 ± 53%  perf-profile.self.cycles-pp._find_next_bit
      0.12 ± 17%      +0.1        0.17 ± 20%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.04 ± 71%      +0.1        0.09 ± 31%  perf-profile.self.cycles-pp.rcu_needs_cpu
      0.05 ± 45%      +0.1        0.11 ± 35%  perf-profile.self.cycles-pp.tick_sched_timer
      0.10 ± 11%      +0.1        0.16 ± 13%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.02 ±146%      +0.1        0.10 ± 31%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.08 ± 36%      +0.1        0.16 ± 42%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.07 ± 58%      +0.1        0.16 ± 33%  perf-profile.self.cycles-pp.rcu_idle_exit
      0.14 ± 24%      +0.1        0.24 ± 23%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.01 ±223%      +0.1        0.11 ± 42%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.11 ± 18%      +0.1        0.21 ± 42%  perf-profile.self.cycles-pp.rcu_eqs_exit
      0.15 ± 49%      +0.1        0.27 ± 20%  perf-profile.self.cycles-pp.call_cpuidle
      0.20 ± 22%      +0.1        0.34 ± 26%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.09 ± 21%      +0.2        0.24 ± 24%  perf-profile.self.cycles-pp.rebalance_domains
      0.18 ± 34%      +0.2        0.33 ± 33%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.29 ±  7%      +0.2        0.46 ± 28%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.27 ±  7%      +0.2        0.45 ± 12%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.26 ± 18%      +0.3        0.54 ± 30%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.29 ± 14%      +0.3        0.59 ± 17%  perf-profile.self.cycles-pp.do_idle
      0.53 ±  5%      +0.3        0.83 ± 16%  perf-profile.self.cycles-pp.native_sched_clock
      0.53 ±  8%      +0.4        0.88 ± 14%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.56 ±  7%      +0.4        0.93 ± 26%  perf-profile.self.cycles-pp.read_tsc
      0.39 ± 28%      +0.4        0.79 ± 20%  perf-profile.self.cycles-pp.update_process_times
      0.75 ± 12%      +0.5        1.23 ± 25%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.38 ± 23%      +0.5        0.88 ± 55%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.74 ±  5%      +0.6        1.30 ± 28%  perf-profile.self.cycles-pp.lapic_next_deadline
      2.25 ± 12%      +6.8        9.01 ± 49%  perf-profile.self.cycles-pp.menu_select



***************************************************************************************************
lkp-csl-2sp7: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode:
  device/gcc-9/performance/1HDD/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp7/stress-ng/60s/0x5003006

commit: 
  d3c4a43d92 ("block: refactor blk_drop_partitions")
  c76f48eb5c ("block: take bd_mutex around delete_partitions in del_gendisk")

d3c4a43d9291279c c76f48eb5c084b1e15c931ae8cc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2529 ±  4%     -96.2%      96.00        stress-ng.loop.ops
     41.73 ±  5%     -99.5%       0.20 ± 29%  stress-ng.loop.ops_per_sec
    363.20          +140.9%     875.00 ± 22%  stress-ng.time.elapsed_time
    363.20          +140.9%     875.00 ± 22%  stress-ng.time.elapsed_time.max
      6817           -56.5%       2968 ± 21%  stress-ng.time.percent_of_cpu_this_job_got
      1.13 ±  5%      +7.6%       1.22 ±  6%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      2.26 ±  5%      +7.6%       2.44 ±  6%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    394.07          +129.9%     905.77 ± 21%  uptime.boot
     11779          +408.6%      59917 ± 30%  uptime.idle
     27.48          +144.1%      67.10 ±  9%  iostat.cpu.idle
     70.73           -54.5%      32.18 ± 19%  iostat.cpu.system
      1.66 ±  7%     -59.9%       0.67 ± 20%  iostat.cpu.user
 5.435e+09 ± 57%    +615.3%  3.887e+10 ± 67%  cpuidle.C1E.time
  15572783 ± 25%    +512.4%   95371028 ± 46%  cpuidle.C1E.usage
   2101854 ±  3%     +21.9%    2562555 ±  5%  cpuidle.POLL.time
    150130 ±  4%    +103.6%     305659 ± 21%  cpuidle.POLL.usage
    268316 ±  2%     +26.2%     338533 ±  4%  meminfo.Active
    266431 ±  2%     +26.5%     336952 ±  4%  meminfo.Active(anon)
     47894           -14.3%      41032        meminfo.Mapped
    946.14 ± 81%     +86.1%       1760 ± 22%  meminfo.Mlocked
    286690 ±  2%     +23.2%     353170 ±  4%  meminfo.Shmem
     59208 ±  7%     +19.1%      70545 ±  7%  numa-meminfo.node0.KReclaimable
     59208 ±  7%     +19.1%      70545 ±  7%  numa-meminfo.node0.SReclaimable
    198077 ± 26%     +51.2%     299434 ± 16%  numa-meminfo.node1.Active
    197163 ± 27%     +51.5%     298631 ± 16%  numa-meminfo.node1.Active(anon)
    208761 ± 26%     +47.6%     308206 ± 16%  numa-meminfo.node1.Shmem
     27.00          +146.3%      66.50 ±  9%  vmstat.cpu.id
     70.14           -54.6%      31.83 ± 20%  vmstat.cpu.sy
      8363 ± 20%     -54.8%       3776 ± 27%  vmstat.io.bi
     75.71           -56.9%      32.67 ± 20%  vmstat.procs.r
     21166 ±  3%     -53.8%       9779 ± 19%  vmstat.system.cs
     28.87           +38.5       67.40 ±  9%  mpstat.cpu.all.idle%
      0.12 ± 11%      -0.1        0.06 ± 24%  mpstat.cpu.all.iowait%
      0.90 ±  2%      +0.6        1.49 ± 18%  mpstat.cpu.all.irq%
      0.77 ±  3%      -0.4        0.40 ± 15%  mpstat.cpu.all.soft%
     67.70           -37.7       29.99 ± 20%  mpstat.cpu.all.sys%
      1.64 ±  7%      -1.0        0.66 ± 20%  mpstat.cpu.all.usr%
     14804 ±  7%     +19.1%      17637 ±  7%  numa-vmstat.node0.nr_slab_reclaimable
  50776578 ±  2%     -23.4%   38912311 ±  4%  numa-vmstat.node0.numa_hit
  50580358 ±  2%     -23.4%   38750194 ±  4%  numa-vmstat.node0.numa_local
     49262 ± 27%     +51.5%      74630 ± 16%  numa-vmstat.node1.nr_active_anon
     52198 ± 26%     +47.6%      77069 ± 16%  numa-vmstat.node1.nr_shmem
     49262 ± 27%     +51.5%      74630 ± 16%  numa-vmstat.node1.nr_zone_active_anon
  54530015 ±  5%     -22.9%   42027883 ± 11%  numa-vmstat.node1.numa_hit
  54388335 ±  5%     -23.1%   41848232 ± 11%  numa-vmstat.node1.numa_local
     66623 ±  2%     +26.5%      84248 ±  4%  proc-vmstat.nr_active_anon
    317296            +5.2%     333673        proc-vmstat.nr_file_pages
     21141            -8.4%      19355 ±  2%  proc-vmstat.nr_kernel_stack
     12110           -14.0%      10411        proc-vmstat.nr_mapped
    235.71 ± 81%     +86.7%     440.00 ± 22%  proc-vmstat.nr_mlock
     71671 ±  2%     +23.2%      88300 ±  4%  proc-vmstat.nr_shmem
     30854 ±  2%      +9.5%      33788        proc-vmstat.nr_slab_reclaimable
     68656            -6.3%      64331        proc-vmstat.nr_slab_unreclaimable
     66623 ±  2%     +26.5%      84248 ±  4%  proc-vmstat.nr_zone_active_anon
      7780 ±  8%     -92.4%     590.50 ± 19%  proc-vmstat.unevictable_pgs_culled
      2039           -55.0%     917.67 ± 19%  turbostat.Avg_MHz
     73.33           -38.5       34.79 ± 18%  turbostat.Busy%
      2788            -5.5%       2635 ±  2%  turbostat.Bzy_MHz
      0.15 ± 14%      -0.1        0.06 ± 21%  turbostat.C1%
  15569558 ± 25%    +512.5%   95367656 ± 46%  turbostat.C1E
     15.52 ± 57%     +28.8       44.34 ± 53%  turbostat.C1E%
     25.80 ±  3%    +140.3%      62.00 ± 13%  turbostat.CPU%c1
  72387783          +136.1%  1.709e+08 ± 21%  turbostat.IRQ
    236.00           -38.5%     145.10 ±  9%  turbostat.PkgWatt
    150.82            -2.2%     147.55        turbostat.RAMWatt
      1.20 ± 35%      +1.5        2.70 ± 62%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.kernfs_dop_revalidate.lookup_fast.walk_component
      1.26 ± 32%      +1.5        2.78 ± 61%  perf-profile.calltrace.cycles-pp.__mutex_lock.kernfs_dop_revalidate.lookup_fast.walk_component.link_path_walk
      1.32 ± 31%      +1.5        2.86 ± 59%  perf-profile.calltrace.cycles-pp.kernfs_dop_revalidate.lookup_fast.walk_component.link_path_walk.path_openat
      1.39 ± 29%      +1.5        2.93 ± 58%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      1.69 ± 27%      +1.8        3.44 ± 56%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      1.76 ± 35%      +2.1        3.88 ± 62%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.kernfs_iop_permission.inode_permission.link_path_walk
      1.85 ± 33%      +2.1        3.98 ± 61%  perf-profile.calltrace.cycles-pp.__mutex_lock.kernfs_iop_permission.inode_permission.link_path_walk.path_openat
      1.94 ± 31%      +2.2        4.11 ± 60%  perf-profile.calltrace.cycles-pp.kernfs_iop_permission.inode_permission.link_path_walk.path_openat.do_filp_open
      2.01 ± 30%      +2.2        4.17 ± 59%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      3.75 ± 28%      +3.9        7.67 ± 57%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.31 ± 27%      -0.1        0.19 ± 17%  perf-profile.children.cycles-pp.start_kernel
      0.08 ± 36%      +0.0        0.12 ± 26%  perf-profile.children.cycles-pp.__vunmap
      0.03 ±116%      +0.1        0.09 ± 26%  perf-profile.children.cycles-pp.remove_vm_area
      0.04 ± 89%      +0.1        0.09 ± 45%  perf-profile.children.cycles-pp.__mutex_unlock_slowpath
      0.07 ± 76%      +0.1        0.15 ± 23%  perf-profile.children.cycles-pp.new_sync_read
      0.22 ± 29%      +0.2        0.43 ± 55%  perf-profile.children.cycles-pp.kernfs_iop_get_link
      0.23 ± 28%      +0.2        0.44 ± 54%  perf-profile.children.cycles-pp.pick_link
      0.48 ± 23%      +0.5        0.97 ± 59%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      0.47 ± 24%      +0.5        0.97 ± 59%  perf-profile.children.cycles-pp.iterate_dir
      0.43 ± 27%      +0.5        0.93 ± 61%  perf-profile.children.cycles-pp.kernfs_fop_readdir
      1.86 ± 23%      +1.6        3.48 ± 54%  perf-profile.children.cycles-pp.lookup_fast
      2.08 ± 22%      +1.6        3.71 ± 52%  perf-profile.children.cycles-pp.walk_component
      1.65 ± 27%      +1.7        3.31 ± 57%  perf-profile.children.cycles-pp.kernfs_dop_revalidate
      2.42 ± 26%      +2.3        4.71 ± 56%  perf-profile.children.cycles-pp.inode_permission
      2.27 ± 28%      +2.3        4.58 ± 58%  perf-profile.children.cycles-pp.kernfs_iop_permission
      4.26 ± 24%      +3.8        8.02 ± 55%  perf-profile.children.cycles-pp.link_path_walk
      3896 ±  4%     -26.1%       2881 ±  5%  slabinfo.Acpi-Parse.active_objs
      3896 ±  4%     -26.1%       2881 ±  5%  slabinfo.Acpi-Parse.num_objs
      2695 ± 13%     +17.5%       3166 ± 11%  slabinfo.buffer_head.active_objs
      2695 ± 13%     +17.5%       3166 ± 11%  slabinfo.buffer_head.num_objs
    121171           +12.7%     136550 ±  2%  slabinfo.dentry.active_objs
      2954           +11.5%       3293 ±  2%  slabinfo.dentry.active_slabs
    124128           +11.5%     138350 ±  2%  slabinfo.dentry.num_objs
      2954           +11.5%       3293 ±  2%  slabinfo.dentry.num_slabs
     65205 ±  2%     -32.1%      44268 ±  6%  slabinfo.filp.active_objs
      2069 ±  2%     -27.8%       1493 ±  6%  slabinfo.filp.active_slabs
     66223 ±  2%     -27.8%      47810 ±  6%  slabinfo.filp.num_objs
      2069 ±  2%     -27.8%       1493 ±  6%  slabinfo.filp.num_slabs
     87249           +16.1%     101301 ±  2%  slabinfo.inode_cache.active_objs
      1674           +12.8%       1888 ±  2%  slabinfo.inode_cache.active_slabs
     90457           +12.8%     102020 ±  2%  slabinfo.inode_cache.num_objs
      1674           +12.8%       1888 ±  2%  slabinfo.inode_cache.num_slabs
     44095           -16.5%      36822 ±  4%  slabinfo.kmalloc-16.num_objs
      6886           -17.4%       5685 ±  3%  slabinfo.kmalloc-192.num_objs
     73187           -18.6%      59605        slabinfo.kmalloc-8.active_objs
     73828           -17.3%      61093        slabinfo.kmalloc-8.num_objs
      6458           +18.4%       7647 ±  3%  slabinfo.kmalloc-96.active_objs
      7259            +9.8%       7974 ±  2%  slabinfo.kmalloc-96.num_objs
    995.29           -65.3%     345.33 ±  9%  slabinfo.request_queue.active_objs
    995.29           -65.3%     345.33 ±  9%  slabinfo.request_queue.num_objs
     31473 ±  3%     -43.8%      17678 ± 10%  slabinfo.shmem_inode_cache.active_objs
    690.00 ±  3%     -44.0%     386.67 ± 10%  slabinfo.shmem_inode_cache.active_slabs
     31769 ±  3%     -44.0%      17803 ± 10%  slabinfo.shmem_inode_cache.num_objs
    690.00 ±  3%     -44.0%     386.67 ± 10%  slabinfo.shmem_inode_cache.num_slabs
      1313 ±  5%     +13.3%       1487 ±  4%  slabinfo.task_group.active_objs
      1313 ±  5%     +13.3%       1487 ±  4%  slabinfo.task_group.num_objs
     17797 ± 10%     +25.3%      22297 ±  5%  slabinfo.vmap_area.active_objs
     18750 ±  7%     +23.7%      23198 ±  4%  slabinfo.vmap_area.num_objs
     16852 ± 17%     +76.0%      29667 ± 11%  sched_debug.cfs_rq:/.load.avg
    422015 ± 23%     +46.9%     620094 ±  8%  sched_debug.cfs_rq:/.load.max
      6078           -52.8%       2870 ± 19%  sched_debug.cfs_rq:/.load.min
     56970 ± 25%     +92.8%     109819 ±  9%  sched_debug.cfs_rq:/.load.stddev
      8.49 ± 27%     -57.5%       3.61 ± 32%  sched_debug.cfs_rq:/.load_avg.min
  10716828           -15.1%    9102611 ±  3%  sched_debug.cfs_rq:/.min_vruntime.avg
  10941313           -15.0%    9295274 ±  3%  sched_debug.cfs_rq:/.min_vruntime.max
  10319971           -15.0%    8767619 ±  3%  sched_debug.cfs_rq:/.min_vruntime.min
      0.61           -47.5%       0.32 ± 15%  sched_debug.cfs_rq:/.nr_running.avg
      0.57           -53.0%       0.27 ± 19%  sched_debug.cfs_rq:/.nr_running.min
      0.13 ± 11%     +41.8%       0.18 ±  9%  sched_debug.cfs_rq:/.nr_running.stddev
    652.07           -50.8%     320.85 ± 16%  sched_debug.cfs_rq:/.runnable_avg.avg
      1180 ±  4%     -27.8%     852.72 ±  8%  sched_debug.cfs_rq:/.runnable_avg.max
    587.84           -53.1%     275.81 ± 19%  sched_debug.cfs_rq:/.runnable_avg.min
    641.37           -50.7%     316.10 ± 17%  sched_debug.cfs_rq:/.util_avg.avg
    958.02 ±  3%     -19.0%     776.10 ±  8%  sched_debug.cfs_rq:/.util_avg.max
    570.18           -52.8%     269.25 ± 19%  sched_debug.cfs_rq:/.util_avg.min
     73.27 ±  5%     +21.9%      89.33 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
    287.72 ±  2%     -52.6%     136.32 ± 19%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    565.65 ± 14%     -42.8%     323.83 ± 22%  sched_debug.cfs_rq:/.util_est_enqueued.max
    138.49 ± 10%     -55.5%      61.65 ± 23%  sched_debug.cfs_rq:/.util_est_enqueued.min
     71.94 ± 14%     -44.3%      40.08 ± 21%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    801363 ±  2%     +10.5%     885168 ±  2%  sched_debug.cpu.avg_idle.avg
    209867          +121.5%     464779 ± 20%  sched_debug.cpu.clock.avg
    209880          +121.5%     464786 ± 20%  sched_debug.cpu.clock.max
    209856          +121.5%     464772 ± 20%  sched_debug.cpu.clock.min
      7.26 ±  7%     -41.7%       4.23 ± 15%  sched_debug.cpu.clock.stddev
    207703          +120.1%     457127 ± 20%  sched_debug.cpu.clock_task.avg
    207939          +120.0%     457508 ± 20%  sched_debug.cpu.clock_task.max
    202738          +123.0%     452135 ± 20%  sched_debug.cpu.clock_task.min
     15311 ±  2%     -37.4%       9584 ± 10%  sched_debug.cpu.curr->pid.avg
     23205 ±  2%     +32.1%      30656 ±  8%  sched_debug.cpu.curr->pid.max
     10827 ± 13%     -44.4%       6021 ± 39%  sched_debug.cpu.curr->pid.min
      1468 ± 13%     +79.3%       2634 ± 15%  sched_debug.cpu.curr->pid.stddev
      0.00 ±  4%     -60.0%       0.00 ± 10%  sched_debug.cpu.next_balance.stddev
      0.62           -51.3%       0.30 ± 18%  sched_debug.cpu.nr_running.avg
      1.65 ±  6%     -21.2%       1.30 ±  5%  sched_debug.cpu.nr_running.max
      0.57           -53.0%       0.27 ± 19%  sched_debug.cpu.nr_running.min
      0.19 ±  7%     -16.2%       0.16 ±  6%  sched_debug.cpu.nr_running.stddev
     65242 ±  4%     +12.0%      73099 ±  2%  sched_debug.cpu.nr_switches.avg
    142006 ±  8%     +69.7%     241000 ± 23%  sched_debug.cpu.nr_switches.max
      9433 ± 10%    +126.9%      21401 ± 26%  sched_debug.cpu.nr_switches.stddev
      0.77 ±  9%     +41.1%       1.08 ±  9%  sched_debug.cpu.nr_uninterruptible.avg
     75.72 ±  8%     +12.5%      85.20 ±  5%  sched_debug.cpu.nr_uninterruptible.stddev
    209854          +121.5%     464772 ± 20%  sched_debug.cpu_clk
    209359          +121.8%     464277 ± 20%  sched_debug.ktime
    210224          +121.3%     465139 ± 20%  sched_debug.sched_clk
     10.07 ± 14%    +145.3%      24.70 ± 72%  perf-stat.i.MPKI
 7.403e+09           -55.9%  3.267e+09 ± 20%  perf-stat.i.branch-instructions
      0.82 ± 19%      +1.9        2.73 ± 81%  perf-stat.i.branch-miss-rate%
  32971236 ±  3%     -45.9%   17833407 ± 28%  perf-stat.i.branch-misses
  62721218 ±  4%     -54.9%   28285991 ± 17%  perf-stat.i.cache-misses
 2.427e+08 ±  4%     -50.4%  1.203e+08 ± 22%  perf-stat.i.cache-references
     20953 ±  3%     -54.1%       9620 ± 19%  perf-stat.i.context-switches
 1.957e+11           -55.4%  8.718e+10 ± 20%  perf-stat.i.cpu-cycles
      1558 ±  3%     -52.5%     740.39 ± 21%  perf-stat.i.cpu-migrations
     98025 ±  3%     -55.7%      43407 ± 23%  perf-stat.i.cycles-between-cache-misses
   3089148 ±  5%     -38.6%    1897995 ± 38%  perf-stat.i.dTLB-load-misses
 7.857e+09           -55.4%  3.508e+09 ± 19%  perf-stat.i.dTLB-loads
   2948479 ± 16%     -54.4%    1344801 ± 24%  perf-stat.i.dTLB-store-misses
 2.368e+09 ±  2%     -54.7%  1.072e+09 ± 18%  perf-stat.i.dTLB-stores
     69.91           -14.0       55.89 ±  5%  perf-stat.i.iTLB-load-miss-rate%
  13760398 ±  2%     -52.4%    6546686 ± 16%  perf-stat.i.iTLB-load-misses
   6194204 ±  6%     -42.4%    3566092 ± 12%  perf-stat.i.iTLB-loads
 3.095e+10           -55.6%  1.375e+10 ± 20%  perf-stat.i.instructions
      4193 ±  4%     -49.1%       2135 ± 16%  perf-stat.i.instructions-per-iTLB-miss
      3.24           -54.5%       1.48 ± 17%  perf-stat.i.major-faults
      2.04           -55.4%       0.91 ± 20%  perf-stat.i.metric.GHz
    186.35           -55.4%      83.10 ± 19%  perf-stat.i.metric.M/sec
    587004 ±  4%     -57.5%     249485 ± 21%  perf-stat.i.minor-faults
     83.95            +4.5       88.41 ±  2%  perf-stat.i.node-load-miss-rate%
   9800429 ±  2%     -55.9%    4326887 ± 18%  perf-stat.i.node-load-misses
   1818557 ±  3%     -55.7%     805771 ± 19%  perf-stat.i.node-loads
   7074657 ±  2%     -57.3%    3022001 ± 20%  perf-stat.i.node-store-misses
   1170221           -56.4%     510653 ± 21%  perf-stat.i.node-stores
    587343 ±  4%     -57.5%     249623 ± 21%  perf-stat.i.page-faults
     69.07 ±  2%      -4.4       64.70 ±  2%  perf-stat.overall.iTLB-load-miss-rate%
 7.379e+09           -55.6%  3.277e+09 ± 19%  perf-stat.ps.branch-instructions
  32913748 ±  3%     -45.7%   17887460 ± 28%  perf-stat.ps.branch-misses
  62364281 ±  4%     -54.6%   28319563 ± 17%  perf-stat.ps.cache-misses
 2.413e+08 ±  4%     -50.1%  1.203e+08 ± 22%  perf-stat.ps.cache-references
     21227 ±  3%     -53.9%       9778 ± 19%  perf-stat.ps.context-switches
 1.945e+11           -55.2%  8.723e+10 ± 20%  perf-stat.ps.cpu-cycles
      1581 ±  3%     -52.3%     754.75 ± 21%  perf-stat.ps.cpu-migrations
   3068889 ±  5%     -38.2%    1896861 ± 38%  perf-stat.ps.dTLB-load-misses
 7.831e+09           -55.1%  3.518e+09 ± 19%  perf-stat.ps.dTLB-loads
   2919101 ± 16%     -54.1%    1341135 ± 24%  perf-stat.ps.dTLB-store-misses
 2.359e+09 ±  2%     -54.5%  1.075e+09 ± 18%  perf-stat.ps.dTLB-stores
  13732191 ±  2%     -52.1%    6573899 ± 16%  perf-stat.ps.iTLB-load-misses
   6153152 ±  6%     -42.1%    3562626 ± 12%  perf-stat.ps.iTLB-loads
 3.085e+10           -55.3%  1.379e+10 ± 19%  perf-stat.ps.instructions
      3.25           -54.1%       1.49 ± 17%  perf-stat.ps.major-faults
    581421 ±  4%     -57.2%     248941 ± 21%  perf-stat.ps.minor-faults
   9768625 ±  2%     -55.5%    4342219 ± 18%  perf-stat.ps.node-load-misses
   1814279 ±  3%     -55.4%     809363 ± 19%  perf-stat.ps.node-loads
   7049268 ±  3%     -57.0%    3032742 ± 20%  perf-stat.ps.node-store-misses
   1169828           -56.1%     514019 ± 21%  perf-stat.ps.node-stores
    581769 ±  4%     -57.2%     249084 ± 21%  perf-stat.ps.page-faults
 1.124e+13            +2.9%  1.156e+13        perf-stat.total.instructions
    729.71          +140.4%       1754 ± 22%  interrupts.9:IO-APIC.9-fasteoi.acpi
    729357          +140.6%    1754773 ± 21%  interrupts.CPU0.LOC:Local_timer_interrupts
    729.71          +140.4%       1754 ± 22%  interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
    729821          +140.4%    1754679 ± 21%  interrupts.CPU1.LOC:Local_timer_interrupts
    729386          +140.5%    1754509 ± 22%  interrupts.CPU10.LOC:Local_timer_interrupts
    729412          +140.5%    1754514 ± 21%  interrupts.CPU11.LOC:Local_timer_interrupts
    729031          +140.6%    1754160 ± 21%  interrupts.CPU12.LOC:Local_timer_interrupts
    729475          +140.5%    1754273 ± 21%  interrupts.CPU13.LOC:Local_timer_interrupts
    729102          +140.6%    1754493 ± 21%  interrupts.CPU14.LOC:Local_timer_interrupts
    729717          +140.5%    1754612 ± 21%  interrupts.CPU15.LOC:Local_timer_interrupts
    729627          +140.4%    1754285 ± 21%  interrupts.CPU16.LOC:Local_timer_interrupts
    729274          +140.7%    1755011 ± 21%  interrupts.CPU17.LOC:Local_timer_interrupts
    729806          +140.4%    1754723 ± 21%  interrupts.CPU18.LOC:Local_timer_interrupts
    729574          +140.5%    1754478 ± 21%  interrupts.CPU19.LOC:Local_timer_interrupts
    729426          +140.5%    1754493 ± 21%  interrupts.CPU2.LOC:Local_timer_interrupts
    729244          +140.5%    1754033 ± 21%  interrupts.CPU20.LOC:Local_timer_interrupts
    729711          +140.5%    1754632 ± 22%  interrupts.CPU21.LOC:Local_timer_interrupts
    729366          +140.5%    1754262 ± 21%  interrupts.CPU22.LOC:Local_timer_interrupts
    729480          +140.5%    1754577 ± 21%  interrupts.CPU23.LOC:Local_timer_interrupts
    729151          +140.7%    1754712 ± 21%  interrupts.CPU24.LOC:Local_timer_interrupts
      9912 ± 10%     -19.0%       8026 ±  4%  interrupts.CPU25.CAL:Function_call_interrupts
    729242          +140.6%    1754726 ± 21%  interrupts.CPU25.LOC:Local_timer_interrupts
    729368          +140.5%    1754187 ± 21%  interrupts.CPU26.LOC:Local_timer_interrupts
    729423          +140.5%    1754291 ± 21%  interrupts.CPU27.LOC:Local_timer_interrupts
    729379          +140.5%    1754139 ± 21%  interrupts.CPU28.LOC:Local_timer_interrupts
    729699          +140.4%    1754474 ± 21%  interrupts.CPU29.LOC:Local_timer_interrupts
    729552          +140.5%    1754499 ± 22%  interrupts.CPU3.LOC:Local_timer_interrupts
    729031          +140.6%    1754303 ± 21%  interrupts.CPU30.LOC:Local_timer_interrupts
    729307          +140.6%    1754496 ± 21%  interrupts.CPU31.LOC:Local_timer_interrupts
    729071          +140.7%    1754789 ± 21%  interrupts.CPU32.LOC:Local_timer_interrupts
    729226          +140.6%    1754795 ± 21%  interrupts.CPU33.LOC:Local_timer_interrupts
    728976          +140.6%    1754102 ± 21%  interrupts.CPU34.LOC:Local_timer_interrupts
    729691          +140.4%    1754505 ± 21%  interrupts.CPU35.LOC:Local_timer_interrupts
    729166          +140.6%    1754201 ± 21%  interrupts.CPU36.LOC:Local_timer_interrupts
    729342          +140.6%    1754462 ± 21%  interrupts.CPU37.LOC:Local_timer_interrupts
    729316          +140.5%    1754167 ± 21%  interrupts.CPU38.LOC:Local_timer_interrupts
    728849          +140.7%    1754698 ± 21%  interrupts.CPU39.LOC:Local_timer_interrupts
    729704          +140.5%    1754890 ± 21%  interrupts.CPU4.LOC:Local_timer_interrupts
    729240          +140.5%    1754038 ± 21%  interrupts.CPU40.LOC:Local_timer_interrupts
    729104          +140.6%    1754432 ± 21%  interrupts.CPU41.LOC:Local_timer_interrupts
    729329          +140.6%    1754621 ± 21%  interrupts.CPU42.LOC:Local_timer_interrupts
    729588          +140.5%    1754591 ± 22%  interrupts.CPU43.LOC:Local_timer_interrupts
    649.43 ±  2%    +209.9%       2012 ±128%  interrupts.CPU43.RES:Rescheduling_interrupts
    729351          +140.5%    1754314 ± 22%  interrupts.CPU44.LOC:Local_timer_interrupts
    729075          +140.7%    1754891 ± 22%  interrupts.CPU45.LOC:Local_timer_interrupts
    729366          +140.5%    1754386 ± 21%  interrupts.CPU46.LOC:Local_timer_interrupts
    728947          +140.7%    1754603 ± 22%  interrupts.CPU47.LOC:Local_timer_interrupts
    729443          +140.5%    1754092 ± 21%  interrupts.CPU48.LOC:Local_timer_interrupts
    729689          +140.5%    1754547 ± 21%  interrupts.CPU49.LOC:Local_timer_interrupts
    729492          +140.6%    1754896 ± 21%  interrupts.CPU5.LOC:Local_timer_interrupts
    729592          +140.4%    1754124 ± 22%  interrupts.CPU50.LOC:Local_timer_interrupts
    728964          +140.7%    1754460 ± 21%  interrupts.CPU51.LOC:Local_timer_interrupts
    729788          +140.4%    1754626 ± 21%  interrupts.CPU52.LOC:Local_timer_interrupts
    729841          +140.4%    1754643 ± 21%  interrupts.CPU53.LOC:Local_timer_interrupts
    729323          +140.6%    1754713 ± 22%  interrupts.CPU54.LOC:Local_timer_interrupts
    729344          +140.6%    1754682 ± 22%  interrupts.CPU55.LOC:Local_timer_interrupts
    729348          +140.6%    1755026 ± 22%  interrupts.CPU56.LOC:Local_timer_interrupts
    729338          +140.6%    1754492 ± 21%  interrupts.CPU57.LOC:Local_timer_interrupts
    729337          +140.6%    1754608 ± 21%  interrupts.CPU58.LOC:Local_timer_interrupts
    729804          +140.4%    1754565 ± 22%  interrupts.CPU59.LOC:Local_timer_interrupts
    729680          +140.5%    1755106 ± 22%  interrupts.CPU6.LOC:Local_timer_interrupts
    729475          +140.5%    1754650 ± 21%  interrupts.CPU60.LOC:Local_timer_interrupts
    729498          +140.5%    1754537 ± 21%  interrupts.CPU61.LOC:Local_timer_interrupts
    729337          +140.5%    1754304 ± 21%  interrupts.CPU62.LOC:Local_timer_interrupts
    729965          +140.4%    1754554 ± 22%  interrupts.CPU63.LOC:Local_timer_interrupts
    729696          +140.4%    1754455 ± 21%  interrupts.CPU64.LOC:Local_timer_interrupts
    729412          +140.5%    1754535 ± 21%  interrupts.CPU65.LOC:Local_timer_interrupts
    729532          +140.5%    1754692 ± 21%  interrupts.CPU66.LOC:Local_timer_interrupts
    729629          +140.5%    1754529 ± 21%  interrupts.CPU67.LOC:Local_timer_interrupts
    729573          +140.5%    1754492 ± 21%  interrupts.CPU68.LOC:Local_timer_interrupts
    729095          +140.7%    1754764 ± 21%  interrupts.CPU69.LOC:Local_timer_interrupts
    729350          +140.6%    1754840 ± 22%  interrupts.CPU7.LOC:Local_timer_interrupts
    729768          +140.4%    1754460 ± 21%  interrupts.CPU70.LOC:Local_timer_interrupts
    729482          +140.5%    1754368 ± 21%  interrupts.CPU71.LOC:Local_timer_interrupts
    729257          +140.6%    1754349 ± 21%  interrupts.CPU72.LOC:Local_timer_interrupts
    729577          +140.5%    1754329 ± 21%  interrupts.CPU73.LOC:Local_timer_interrupts
    729420          +140.5%    1754481 ± 22%  interrupts.CPU74.LOC:Local_timer_interrupts
    729164          +140.6%    1754477 ± 22%  interrupts.CPU75.LOC:Local_timer_interrupts
    729256          +140.6%    1754386 ± 21%  interrupts.CPU76.LOC:Local_timer_interrupts
    729258          +140.6%    1754817 ± 21%  interrupts.CPU77.LOC:Local_timer_interrupts
    729618          +140.4%    1754329 ± 21%  interrupts.CPU78.LOC:Local_timer_interrupts
    729195          +140.6%    1754203 ± 21%  interrupts.CPU79.LOC:Local_timer_interrupts
    729523          +140.5%    1754652 ± 21%  interrupts.CPU8.LOC:Local_timer_interrupts
    729515          +140.5%    1754515 ± 22%  interrupts.CPU80.LOC:Local_timer_interrupts
    729269          +140.5%    1754189 ± 21%  interrupts.CPU81.LOC:Local_timer_interrupts
    729281          +140.5%    1754169 ± 22%  interrupts.CPU82.LOC:Local_timer_interrupts
    729217          +140.6%    1754321 ± 21%  interrupts.CPU83.LOC:Local_timer_interrupts
    729641          +140.5%    1754553 ± 22%  interrupts.CPU84.LOC:Local_timer_interrupts
    728947          +140.7%    1754445 ± 22%  interrupts.CPU85.LOC:Local_timer_interrupts
    729242          +140.6%    1754268 ± 21%  interrupts.CPU86.LOC:Local_timer_interrupts
    742.00 ± 14%     -18.7%     603.00 ±  6%  interrupts.CPU86.RES:Rescheduling_interrupts
    729720          +140.4%    1754273 ± 21%  interrupts.CPU87.LOC:Local_timer_interrupts
    729673          +140.4%    1754450 ± 21%  interrupts.CPU88.LOC:Local_timer_interrupts
    729216          +140.6%    1754474 ± 21%  interrupts.CPU89.LOC:Local_timer_interrupts
    729263          +140.6%    1754418 ± 22%  interrupts.CPU9.LOC:Local_timer_interrupts
    729400          +140.5%    1754383 ± 21%  interrupts.CPU90.LOC:Local_timer_interrupts
    729249          +140.6%    1754544 ± 21%  interrupts.CPU91.LOC:Local_timer_interrupts
    728980          +140.7%    1754421 ± 22%  interrupts.CPU92.LOC:Local_timer_interrupts
    729036          +140.6%    1754104 ± 22%  interrupts.CPU93.LOC:Local_timer_interrupts
    729038          +140.6%    1754296 ± 21%  interrupts.CPU94.LOC:Local_timer_interrupts
    728704          +140.8%    1754436 ± 21%  interrupts.CPU95.LOC:Local_timer_interrupts
  70020802          +140.5%  1.684e+08 ± 21%  interrupts.LOC:Local_timer_interrupts
     96.00          +133.3%     224.00 ± 20%  interrupts.MCP:Machine_check_polls
     87063 ±  3%     +29.3%     112565 ± 10%  softirqs.CPU0.RCU
     19291 ±  4%    +319.2%      80871 ± 27%  softirqs.CPU0.SCHED
     84306 ±  2%     +33.0%     112095 ±  8%  softirqs.CPU1.RCU
     17098 ±  4%    +361.2%      78858 ± 28%  softirqs.CPU1.SCHED
     83314 ±  2%     +33.5%     111188 ±  7%  softirqs.CPU10.RCU
     16366 ±  5%    +305.9%      66436 ± 35%  softirqs.CPU10.SCHED
     82645 ±  3%     +34.1%     110839 ±  7%  softirqs.CPU11.RCU
     16820 ±  4%    +366.0%      78389 ± 28%  softirqs.CPU11.SCHED
     81897 ±  3%     +34.9%     110444 ±  7%  softirqs.CPU12.RCU
     16463 ±  5%    +373.9%      78020 ± 28%  softirqs.CPU12.SCHED
     82114           +33.9%     109972 ±  7%  softirqs.CPU13.RCU
     16319 ±  5%    +379.3%      78218 ± 28%  softirqs.CPU13.SCHED
     81428 ±  4%     +33.5%     108711 ±  9%  softirqs.CPU14.RCU
     16037 ± 10%    +387.7%      78222 ± 29%  softirqs.CPU14.SCHED
     81014 ±  3%     +36.2%     110327 ±  7%  softirqs.CPU15.RCU
     16132 ±  5%    +384.7%      78200 ± 29%  softirqs.CPU15.SCHED
     18325 ±114%    -100.0%       7.17 ± 66%  softirqs.CPU16.BLOCK
     83479 ±  3%     +31.8%     110030 ± 10%  softirqs.CPU16.RCU
     17442 ±  3%    +348.3%      78195 ± 29%  softirqs.CPU16.SCHED
     81902 ±  2%     +35.1%     110635 ±  8%  softirqs.CPU17.RCU
     15903 ± 10%    +395.5%      78796 ± 28%  softirqs.CPU17.SCHED
     80731 ±  3%     +34.3%     108404 ± 10%  softirqs.CPU18.RCU
     16741 ±  4%    +369.3%      78561 ± 28%  softirqs.CPU18.SCHED
     82414 ±  2%     +30.1%     107231 ±  7%  softirqs.CPU19.RCU
     16125 ±  4%    +385.7%      78330 ± 29%  softirqs.CPU19.SCHED
     82439 ±  2%     +34.5%     110902 ±  9%  softirqs.CPU2.RCU
     14985 ± 10%    +426.2%      78854 ± 28%  softirqs.CPU2.SCHED
     81327 ±  4%     +37.6%     111899 ±  8%  softirqs.CPU20.RCU
     16566 ±  7%    +361.9%      76527 ± 27%  softirqs.CPU20.SCHED
     81841 ±  4%     +33.6%     109362 ±  8%  softirqs.CPU21.RCU
     16005 ±  6%    +388.5%      78192 ± 29%  softirqs.CPU21.SCHED
     80566 ±  4%     +36.4%     109861 ±  8%  softirqs.CPU22.RCU
     15971 ±  6%    +391.2%      78454 ± 29%  softirqs.CPU22.SCHED
     81863 ±  2%     +32.4%     108376 ± 10%  softirqs.CPU23.RCU
     16727 ±  2%    +368.0%      78281 ± 29%  softirqs.CPU23.SCHED
     87993 ±  3%     +27.5%     112191 ± 10%  softirqs.CPU24.RCU
     15464 ± 11%    +427.7%      81612 ± 32%  softirqs.CPU24.SCHED
     85959 ±  3%     +30.9%     112555 ±  8%  softirqs.CPU25.RCU
     16429 ±  4%    +380.6%      78965 ± 28%  softirqs.CPU25.SCHED
     83219 ±  6%     +33.2%     110840 ±  8%  softirqs.CPU26.RCU
     15982 ±  5%    +394.5%      79039 ± 28%  softirqs.CPU26.SCHED
     82086 ±  5%     +35.2%     110947 ±  9%  softirqs.CPU27.RCU
     16031 ±  8%    +393.7%      79148 ± 28%  softirqs.CPU27.SCHED
     84842 ±  3%     +31.6%     111610 ±  8%  softirqs.CPU28.RCU
     15500 ± 11%    +415.0%      79828 ± 27%  softirqs.CPU28.SCHED
     85066 ±  3%     +31.2%     111577 ±  8%  softirqs.CPU29.RCU
     15856 ±  5%    +397.6%      78904 ± 28%  softirqs.CPU29.SCHED
     82344 ±  4%     +36.9%     112702 ±  8%  softirqs.CPU3.RCU
     15260 ±  8%    +403.2%      76794 ± 32%  softirqs.CPU3.SCHED
     83594 ±  5%     +31.3%     109800 ±  7%  softirqs.CPU30.RCU
     16551 ±  3%    +376.6%      78882 ± 28%  softirqs.CPU30.SCHED
     82947 ±  7%     +32.4%     109833 ± 10%  softirqs.CPU31.RCU
     16149 ±  7%    +387.1%      78673 ± 28%  softirqs.CPU31.SCHED
     84732 ±  3%     +34.8%     114256 ±  8%  softirqs.CPU32.RCU
     15988 ± 10%    +395.7%      79247 ± 28%  softirqs.CPU32.SCHED
     83430 ±  5%     +36.3%     113685 ±  8%  softirqs.CPU33.RCU
     15340 ±  8%    +413.8%      78821 ± 28%  softirqs.CPU33.SCHED
     85678 ±  3%     +34.3%     115060 ±  8%  softirqs.CPU34.RCU
     15503 ± 10%    +409.5%      78994 ± 28%  softirqs.CPU34.SCHED
     84635 ±  5%     +35.2%     114436 ±  8%  softirqs.CPU35.RCU
     16547 ±  3%    +377.2%      78974 ± 28%  softirqs.CPU35.SCHED
     85010 ±  3%     +29.4%     109964 ±  7%  softirqs.CPU36.RCU
     15756 ± 11%    +405.6%      79667 ± 28%  softirqs.CPU36.SCHED
     83869 ±  5%     +33.5%     111951 ±  7%  softirqs.CPU37.RCU
     15843 ±  4%    +396.9%      78720 ± 28%  softirqs.CPU37.SCHED
     83148 ±  6%     +33.5%     111005 ±  8%  softirqs.CPU38.RCU
     15656 ±  8%    +406.2%      79252 ± 29%  softirqs.CPU38.SCHED
     84300 ±  6%     +31.8%     111124 ±  8%  softirqs.CPU39.RCU
     15964 ±  3%    +396.7%      79287 ± 29%  softirqs.CPU39.SCHED
     82975 ±  2%     +32.9%     110261 ±  8%  softirqs.CPU4.RCU
     16608 ±  2%    +327.3%      70972 ± 22%  softirqs.CPU4.SCHED
     84792 ±  4%     +33.7%     113386 ± 10%  softirqs.CPU40.RCU
     16338 ±  5%    +382.5%      78834 ± 28%  softirqs.CPU40.SCHED
     86177 ±  3%     +33.8%     115303 ±  8%  softirqs.CPU41.RCU
     15868 ±  6%    +398.2%      79060 ± 28%  softirqs.CPU41.SCHED
     83097 ±  4%     +32.8%     110348 ± 11%  softirqs.CPU42.RCU
     16953 ±  6%    +363.6%      78603 ± 28%  softirqs.CPU42.SCHED
     81892 ±  6%     +38.4%     113349 ±  9%  softirqs.CPU43.RCU
     16027 ±  4%    +392.2%      78886 ± 28%  softirqs.CPU43.SCHED
     85013 ±  5%     +33.9%     113856 ±  8%  softirqs.CPU44.RCU
     16114 ±  3%    +369.7%      75691 ± 36%  softirqs.CPU44.SCHED
     85689 ±  3%     +33.9%     114751 ±  8%  softirqs.CPU45.RCU
     15457 ±  6%    +410.3%      78873 ± 28%  softirqs.CPU45.SCHED
     84736 ±  5%     +33.7%     113258 ±  7%  softirqs.CPU46.RCU
     15502 ±  8%    +409.0%      78901 ± 28%  softirqs.CPU46.SCHED
     84317 ±  6%     +34.1%     113053 ±  8%  softirqs.CPU47.RCU
     15752 ±  5%    +400.1%      78785 ± 28%  softirqs.CPU47.SCHED
     82686 ±  2%     +30.3%     107716 ±  8%  softirqs.CPU48.RCU
     15481 ±  6%    +407.8%      78607 ± 29%  softirqs.CPU48.SCHED
     84297 ±  2%     +33.9%     112856 ±  7%  softirqs.CPU49.RCU
     16254 ±  7%    +370.8%      76526 ± 24%  softirqs.CPU49.SCHED
     82208 ±  4%     +33.5%     109751 ±  9%  softirqs.CPU5.RCU
     15599 ± 11%    +401.8%      78281 ± 28%  softirqs.CPU5.SCHED
     82634           +33.1%     110003 ±  8%  softirqs.CPU50.RCU
     16018 ±  8%    +396.3%      79502 ± 28%  softirqs.CPU50.SCHED
     82336           +34.7%     110920 ±  9%  softirqs.CPU51.RCU
     15972 ± 11%    +395.5%      79147 ± 29%  softirqs.CPU51.SCHED
     82684 ±  2%     +33.9%     110738 ±  7%  softirqs.CPU52.RCU
     16511 ±  6%    +383.4%      79821 ± 29%  softirqs.CPU52.SCHED
     81199 ±  2%     +37.0%     111229 ±  8%  softirqs.CPU53.RCU
     15638 ±  9%    +411.4%      79970 ± 29%  softirqs.CPU53.SCHED
     81315 ±  5%     +37.3%     111643 ±  8%  softirqs.CPU54.RCU
     15661 ±  3%    +411.3%      80073 ± 29%  softirqs.CPU54.SCHED
     80028 ±  4%     +35.8%     108711 ±  7%  softirqs.CPU55.RCU
     15215 ±  6%    +419.3%      79017 ± 29%  softirqs.CPU55.SCHED
     82528 ±  2%     +33.1%     109875 ±  8%  softirqs.CPU56.RCU
     17018          +341.1%      75064 ± 35%  softirqs.CPU56.SCHED
     81572 ±  2%     +34.0%     109280 ±  8%  softirqs.CPU57.RCU
     16588 ±  2%    +380.4%      79689 ± 29%  softirqs.CPU57.SCHED
     81401 ±  5%     +35.9%     110657 ±  7%  softirqs.CPU58.RCU
     15302 ± 10%    +421.6%      79818 ± 29%  softirqs.CPU58.SCHED
     82077 ±  2%     +35.7%     111382 ±  7%  softirqs.CPU59.RCU
     16677 ±  3%    +378.4%      79782 ± 29%  softirqs.CPU59.SCHED
     83340 ±  3%     +32.8%     110671 ±  7%  softirqs.CPU6.RCU
     15960 ±  5%    +391.2%      78396 ± 28%  softirqs.CPU6.SCHED
     80697 ±  5%     +36.8%     110422 ±  7%  softirqs.CPU60.RCU
     16259 ±  4%    +387.5%      79262 ± 29%  softirqs.CPU60.SCHED
     82538           +34.9%     111338 ±  7%  softirqs.CPU61.RCU
     16199 ±  6%    +389.2%      79245 ± 29%  softirqs.CPU61.SCHED
     82543 ±  3%     +33.4%     110132 ±  7%  softirqs.CPU62.RCU
     16458 ±  5%    +382.5%      79413 ± 26%  softirqs.CPU62.SCHED
     82032 ±  3%     +31.5%     107864 ±  6%  softirqs.CPU63.RCU
     15885 ±  6%    +397.0%      78956 ± 28%  softirqs.CPU63.SCHED
     80600 ±  2%     +33.7%     107756 ±  9%  softirqs.CPU64.RCU
     16161 ±  4%    +393.9%      79827 ± 29%  softirqs.CPU64.SCHED
     81896           +36.0%     111401 ±  8%  softirqs.CPU65.RCU
     16678 ±  6%    +379.4%      79956 ± 29%  softirqs.CPU65.SCHED
     81249           +32.7%     107847 ± 11%  softirqs.CPU66.RCU
     16606 ±  4%    +378.5%      79459 ± 29%  softirqs.CPU66.SCHED
     81245           +34.4%     109209 ±  9%  softirqs.CPU67.RCU
     15815 ±  6%    +398.3%      78813 ± 28%  softirqs.CPU67.SCHED
     82868 ±  2%     +32.6%     109916 ± 10%  softirqs.CPU68.RCU
     16448 ±  5%    +385.7%      79887 ± 29%  softirqs.CPU68.SCHED
     82275 ±  2%     +31.6%     108287 ± 14%  softirqs.CPU69.RCU
     16462 ±  4%    +384.6%      79776 ± 28%  softirqs.CPU69.SCHED
     82833 ±  2%     +33.8%     110811 ±  7%  softirqs.CPU7.RCU
     16627 ±  4%    +370.5%      78234 ± 29%  softirqs.CPU7.SCHED
     81081 ±  3%     +34.1%     108765 ±  8%  softirqs.CPU70.RCU
     16056 ±  5%    +398.4%      80026 ± 29%  softirqs.CPU70.SCHED
     81280 ±  2%     +30.4%     105970 ± 10%  softirqs.CPU71.RCU
     15086 ± 10%    +404.2%      76060 ± 36%  softirqs.CPU71.SCHED
     86835 ±  3%     +27.3%     110583 ±  7%  softirqs.CPU72.RCU
     16615 ±  6%    +386.3%      80794 ± 29%  softirqs.CPU72.SCHED
     83217 ±  4%     +33.7%     111256 ±  7%  softirqs.CPU73.RCU
     16465 ±  4%    +358.8%      75551 ± 27%  softirqs.CPU73.SCHED
     83785 ±  3%     +29.5%     108513 ±  9%  softirqs.CPU74.RCU
     16285 ±  6%    +394.5%      80525 ± 28%  softirqs.CPU74.SCHED
     84189 ±  3%     +32.5%     111582 ±  8%  softirqs.CPU75.RCU
     16334 ±  3%    +393.5%      80617 ± 29%  softirqs.CPU75.SCHED
     83617 ±  4%     +32.3%     110632 ±  8%  softirqs.CPU76.RCU
     16102 ±  8%    +398.8%      80312 ± 28%  softirqs.CPU76.SCHED
     81501 ±  3%     +37.4%     111963 ±  8%  softirqs.CPU77.RCU
     16794 ±  2%    +380.6%      80720 ± 28%  softirqs.CPU77.SCHED
     83423 ±  4%     +31.9%     109996 ±  6%  softirqs.CPU78.RCU
     15669 ±  6%    +413.2%      80411 ± 29%  softirqs.CPU78.SCHED
     82996 ±  5%     +33.9%     111140 ±  8%  softirqs.CPU79.RCU
     15504 ±  7%    +414.3%      79737 ± 28%  softirqs.CPU79.SCHED
     82892 ±  2%     +34.4%     111392 ±  7%  softirqs.CPU8.RCU
     16163 ±  8%    +382.8%      78036 ± 28%  softirqs.CPU8.SCHED
     85019 ±  4%     +31.2%     111541 ±  8%  softirqs.CPU80.RCU
     16185 ±  5%    +399.0%      80763 ± 29%  softirqs.CPU80.SCHED
     84231 ±  5%     +32.9%     111927 ±  7%  softirqs.CPU81.RCU
     15720 ±  5%    +408.8%      79983 ± 29%  softirqs.CPU81.SCHED
     84979 ±  5%     +31.3%     111570 ±  9%  softirqs.CPU82.RCU
     15307 ±  8%    +424.5%      80284 ± 28%  softirqs.CPU82.SCHED
     85474 ±  4%     +31.5%     112430 ±  8%  softirqs.CPU83.RCU
     15885 ±  9%    +404.9%      80202 ± 28%  softirqs.CPU83.SCHED
     85221 ±  3%     +27.0%     108248 ±  9%  softirqs.CPU84.RCU
     15286 ±  8%    +418.6%      79265 ± 28%  softirqs.CPU84.SCHED
     84922 ±  4%     +31.4%     111599 ±  8%  softirqs.CPU85.RCU
     16013 ±  6%    +396.8%      79559 ± 28%  softirqs.CPU85.SCHED
     84635 ±  5%     +28.5%     108760 ±  9%  softirqs.CPU86.RCU
     15451 ±  6%    +423.5%      80888 ± 29%  softirqs.CPU86.SCHED
     83811 ±  5%     +33.0%     111434 ±  8%  softirqs.CPU87.RCU
     16446 ±  4%    +385.9%      79921 ± 28%  softirqs.CPU87.SCHED
     83285 ±  6%     +34.2%     111810 ±  9%  softirqs.CPU88.RCU
     16261 ±  5%    +392.7%      80122 ± 28%  softirqs.CPU88.SCHED
     84421 ±  5%     +33.1%     112339 ±  8%  softirqs.CPU89.RCU
     16499 ±  4%    +386.8%      80325 ± 28%  softirqs.CPU89.SCHED
     82076           +35.9%     111539 ±  8%  softirqs.CPU9.RCU
     16530 ±  5%    +374.2%      78396 ± 29%  softirqs.CPU9.SCHED
     84286 ±  3%     +27.8%     107732 ± 10%  softirqs.CPU90.RCU
     15897 ±  6%    +401.9%      79783 ± 28%  softirqs.CPU90.SCHED
     85201 ±  3%     +29.8%     110581 ± 11%  softirqs.CPU91.RCU
     16102 ±  5%    +399.4%      80420 ± 27%  softirqs.CPU91.SCHED
     85122 ±  3%     +32.6%     112838 ±  8%  softirqs.CPU92.RCU
     16271 ±  4%    +394.4%      80443 ± 29%  softirqs.CPU92.SCHED
     84908 ±  5%     +31.8%     111888 ±  7%  softirqs.CPU93.RCU
     15528 ±  8%    +415.1%      79984 ± 28%  softirqs.CPU93.SCHED
     84414 ±  4%     +34.4%     113461 ±  8%  softirqs.CPU94.RCU
     16174 ±  6%    +394.7%      80018 ± 29%  softirqs.CPU94.SCHED
     83695 ±  4%     +33.5%     111697 ±  7%  softirqs.CPU95.RCU
     15609 ±  9%    +413.2%      80111 ± 29%  softirqs.CPU95.SCHED
   7993548 ±  2%     +33.2%   10647607 ±  8%  softirqs.RCU
   1547228          +389.6%    7574654 ± 28%  softirqs.SCHED
    102796 ±  2%     +21.4%     124764 ±  7%  softirqs.TIMER





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.12.0-rc4-00024-gc76f48eb5c08"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.12.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
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
CONFIG_ACPI_APEI_ERST_DEBUG=y
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
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
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
CONFIG_SOCK_RX_QUEUE_MAPPING=y
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
# CONFIG_BCM_VK is not set
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
# CONFIG_NET_DSA_MV88E6XXX_PTP is not set
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
CONFIG_DRM_GMA600=y
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
# CONFIG_HID_PLAYSTATION is not set
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

#
# LED Blink
#
# CONFIG_LEDS_BLINK is not set
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
CONFIG_IOMMU_IO_PGTABLE=y
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
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
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
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
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

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='stress-ng'
	export testcase='stress-ng'
	export category='benchmark'
	export nr_threads=9
	export testtime=60
	export job_origin='stress-ng-class-os.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2sp5'
	export tbox_group='lkp-csl-2sp5'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='60761970a840bf77a82f0ab5'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2sp5/stress-ng-os-performance-1HDD-ext4-10%-loop-60s-ucode=0x5003006-monitor=be4712f7-debian-10.4-x86_64-20200603.cgz-c76f48eb5c084b1-20210414-30632-db2h9u-3.yaml'
	export id='f50a8c6d390a0a13617d8337e218f699a91cf19e'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=2
	export nr_cpu=96
	export memory='192G'
	export nr_hdd_partitions=1
	export nr_ssd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-ST1000NM0011_Z1N2QGYK-part5'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006P800RGN-part1'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/ata-ST1000NM0011_Z1N2QGYK-part3'
	export brand='Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz'
	export need_kconfig='CONFIG_BLK_DEV_SD
CONFIG_SCSI
CONFIG_BLOCK=y
CONFIG_SATA_AHCI
CONFIG_SATA_AHCI_PLATFORM
CONFIG_ATA
CONFIG_PCI=y
CONFIG_EXT4_FS
CONFIG_SECURITY_APPARMOR=y'
	export commit='c76f48eb5c084b1e15c931ae8cc1826cd771d70d'
	export need_kconfig_hw='CONFIG_I40E=y
CONFIG_SATA_AHCI'
	export ucode='0x5003006'
	export bisect_dmesg=true
	export enqueue_time='2021-04-14 06:21:37 +0800'
	export _id='60761970a840bf77a82f0ab5'
	export _rt='/result/stress-ng/os-performance-1HDD-ext4-10%-loop-60s-ucode=0x5003006-monitor=be4712f7/lkp-csl-2sp5/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/c76f48eb5c084b1e15c931ae8cc1826cd771d70d'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='47df178f0291bdd95327e56295d0794e3b2d5598'
	export base_commit='e49d033bddf5b565044e2abe4241353959bc9120'
	export branch='block/for-5.13/block'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='be4712f7'
	export result_root='/result/stress-ng/os-performance-1HDD-ext4-10%-loop-60s-ucode=0x5003006-monitor=be4712f7/lkp-csl-2sp5/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/c76f48eb5c084b1e15c931ae8cc1826cd771d70d/3'
	export scheduler_version='/lkp/lkp/.src-20210413-183157'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2sp5/stress-ng-os-performance-1HDD-ext4-10%-loop-60s-ucode=0x5003006-monitor=be4712f7-debian-10.4-x86_64-20200603.cgz-c76f48eb5c084b1-20210414-30632-db2h9u-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=block/for-5.13/block
commit=c76f48eb5c084b1e15c931ae8cc1826cd771d70d
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/c76f48eb5c084b1e15c931ae8cc1826cd771d70d/vmlinuz-5.12.0-rc4-00024-gc76f48eb5c08
max_uptime=2100
RESULT_ROOT=/result/stress-ng/os-performance-1HDD-ext4-10%-loop-60s-ucode=0x5003006-monitor=be4712f7/lkp-csl-2sp5/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/c76f48eb5c084b1e15c931ae8cc1826cd771d70d/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/c76f48eb5c084b1e15c931ae8cc1826cd771d70d/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/stress-ng_20210401.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/stress-ng-x86_64-0.11-06_20210401.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-d19cc4bfbff1-1_20210401.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.12.0-rc6'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/c76f48eb5c084b1e15c931ae8cc1826cd771d70d/vmlinuz-5.12.0-rc4-00024-gc76f48eb5c08'
	export dequeue_time='2021-04-14 06:27:13 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2sp5/stress-ng-os-performance-1HDD-ext4-10%-loop-60s-ucode=0x5003006-monitor=be4712f7-debian-10.4-x86_64-20200603.cgz-c76f48eb5c084b1-20210414-30632-db2h9u-3.cgz'

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

	run_setup nr_hdd=1 $LKP_SRC/setup/disk

	run_setup fs='ext4' $LKP_SRC/setup/fs

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
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test class='os' test='loop' $LKP_SRC/tests/wrapper stress-ng
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env class='os' test='loop' $LKP_SRC/stats/wrapper stress-ng
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
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	$LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time stress-ng.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/stress-ng-class-os.yaml
suite: stress-ng
testcase: stress-ng
category: benchmark
nr_threads: 10%
disk: 1HDD
testtime: 60s
fs: ext4
stress-ng:
  class: os
  test: loop
job_origin: stress-ng-class-os.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2sp5
tbox_group: lkp-csl-2sp5
kconfig: x86_64-rhel-8.3
submit_id: 6075f83fa840bf6dfe0f5e17
job_file: "/lkp/jobs/scheduled/lkp-csl-2sp5/stress-ng-os-performance-1HDD-ext4-10%-loop-60s-ucode=0x5003006-monitor=be4712f7-debian-10.4-x86_64-20200603.cgz-c76f48eb5c084b1-20210414-28158-e0et1t-0.yaml"
id: b07b35ec926cbdc2ffe5f4772f8a97c61932bf08
queuer_version: "/lkp-src"

#! hosts/lkp-csl-2sp5
model: Cascade Lake
nr_node: 2
nr_cpu: 96
memory: 192G
nr_hdd_partitions: 1
nr_ssd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-ST1000NM0011_Z1N2QGYK-part5"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006P800RGN-part1"
swap_partitions: 
rootfs_partition: "/dev/disk/by-id/ata-ST1000NM0011_Z1N2QGYK-part3"
brand: Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz

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
  lite_mode: 1
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

#! include/disk/nr_hdd
need_kconfig:
- CONFIG_BLK_DEV_SD
- CONFIG_SCSI
- CONFIG_BLOCK=y
- CONFIG_SATA_AHCI
- CONFIG_SATA_AHCI_PLATFORM
- CONFIG_ATA
- CONFIG_PCI=y
- CONFIG_EXT4_FS
- CONFIG_SECURITY_APPARMOR=y

#! include/fs/OTHERS

#! include/stress-ng

#! include/queue/cyclic
commit: c76f48eb5c084b1e15c931ae8cc1826cd771d70d

#! include/testbox/lkp-csl-2sp5
need_kconfig_hw:
- CONFIG_I40E=y
- CONFIG_SATA_AHCI
ucode: '0x5003006'
bisect_dmesg: true
enqueue_time: 2021-04-14 03:59:59.599183779 +08:00
_id: 6075f83fa840bf6dfe0f5e17
_rt: "/result/stress-ng/os-performance-1HDD-ext4-10%-loop-60s-ucode=0x5003006-monitor=be4712f7/lkp-csl-2sp5/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/c76f48eb5c084b1e15c931ae8cc1826cd771d70d"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 47df178f0291bdd95327e56295d0794e3b2d5598
base_commit: e49d033bddf5b565044e2abe4241353959bc9120
branch: linux-devel/devel-hourly-20210409-210115
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: be4712f7
result_root: "/result/stress-ng/os-performance-1HDD-ext4-10%-loop-60s-ucode=0x5003006-monitor=be4712f7/lkp-csl-2sp5/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/c76f48eb5c084b1e15c931ae8cc1826cd771d70d/0"
scheduler_version: "/lkp/lkp/.src-20210413-183157"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2sp5/stress-ng-os-performance-1HDD-ext4-10%-loop-60s-ucode=0x5003006-monitor=be4712f7-debian-10.4-x86_64-20200603.cgz-c76f48eb5c084b1-20210414-28158-e0et1t-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210409-210115
- commit=c76f48eb5c084b1e15c931ae8cc1826cd771d70d
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/c76f48eb5c084b1e15c931ae8cc1826cd771d70d/vmlinuz-5.12.0-rc4-00024-gc76f48eb5c08
- max_uptime=2100
- RESULT_ROOT=/result/stress-ng/os-performance-1HDD-ext4-10%-loop-60s-ucode=0x5003006-monitor=be4712f7/lkp-csl-2sp5/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/c76f48eb5c084b1e15c931ae8cc1826cd771d70d/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/c76f48eb5c084b1e15c931ae8cc1826cd771d70d/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/stress-ng_20210401.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/stress-ng-x86_64-0.11-06_20210401.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-d19cc4bfbff1-1_20210401.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210409-171539/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.12.0-rc7
repeat_to: 3

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/c76f48eb5c084b1e15c931ae8cc1826cd771d70d/vmlinuz-5.12.0-rc4-00024-gc76f48eb5c08"
dequeue_time: 2021-04-14 04:32:43.325020652 +08:00

#! /lkp/lkp/.src-20210413-183157/include/site/inn
job_state: soft_timeout
loadavg: 10.16 10.05 9.30 1/792 54614
start_time: '1618346021'
end_time: '1618348131'
version: "/lkp/lkp/.src-20210413-183228:ee2d2b49:09503863c"

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

dmsetup remove_all
wipefs -a --force /dev/sda5
mkfs -t ext4 -q -F /dev/sda5
mkdir -p /fs/sda5
mount -t ext4 /dev/sda5 /fs/sda5

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "mkdir" "-p" "/mnt/stress-ng"
 "mount" "/dev/sda5" "/mnt/stress-ng"
 "stress-ng" "--timeout" "60" "--times" "--verify" "--metrics-brief" "--loop" "9"

--Dxnq1zWXvFF0Q93v--
