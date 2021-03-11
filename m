Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6966A336A39
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 03:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhCKCoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 21:44:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:24553 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhCKCne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 21:43:34 -0500
IronPort-SDR: FyJ2fRxKfoEpxZDhnAk5xF3mtgUN6Qid7HalevMel1ufheGct2YNbO3QGwoRWJC/aXfpfIbi3J
 BASZ7FbVtFow==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186224199"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="yaml'?scan'208";a="186224199"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 18:43:32 -0800
IronPort-SDR: CNbGizUkJY32nVp2ULtuqw9oKP/kKrJEhe+nRlb/R4J2YdelBsmeQbPcPRZLb/R7ktZW/NKm2w
 WVgZTkHsY7sQ==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="yaml'?scan'208";a="410444769"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 18:43:21 -0800
Date:   Thu, 11 Mar 2021 10:58:36 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     0day robot <lkp@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Jiang Biao <benbjiang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        mingo@redhat.com, mgorman@techsingularity.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com,
        Aubrey Li <aubrey.li@linux.intel.com>, yu.c.chen@intel.com
Subject: [sched/fair]  322b5a8117:  netperf.Throughput_tps -84.0% regression
Message-ID: <20210311025836.GB9906@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1615342342-50093-2-git-send-email-aubrey.li@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Greeting,

FYI, we noticed a -84.0% regression of netperf.Throughput_tps due to commit:


commit: 322b5a81171d432c59b5c6dcf0229d92acf0d9c2 ("[PATCH v9 2/2] sched/fair: Remove SIS_PROP")
url: https://github.com/0day-ci/linux/commits/Aubrey-Li/sched-fair-select-idle-cpu-from-idle-cpumask-for-task-wakeup/20210310-100644
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 4117cebf1a9fcbf35b9aabf0e37b6c5eea296798

in testcase: netperf
on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
with following parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 200%
	cluster: cs-localhost
	test: TCP_RR
	cpufreq_governor: performance
	ucode: 0x5003006

test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
test-url: http://www.netperf.org/netperf/



If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in this email
        bin/lkp split-job --compatible job.yaml
        bin/lkp run                    compatible-job.yaml

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase/ucode:
  cs-localhost/gcc-9/performance/ipv4/x86_64-rhel-8.3/200%/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap4/TCP_RR/netperf/0x5003006

commit: 
  ca52510778 ("sched/fair: select idle cpu from idle cpumask for task wakeup")
  322b5a8117 ("sched/fair: Remove SIS_PROP")

ca52510778e4c6e5 322b5a81171d432c59b5c6dcf02 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  13817913           -84.0%    2208427 ±  3%  netperf.Throughput_total_tps
     35984           -84.0%       5751 ±  3%  netperf.Throughput_tps
 2.129e+09 ±  8%     -99.1%   20142981 ± 41%  netperf.time.involuntary_context_switches
    107905           +19.9%     129367        netperf.time.minor_page_faults
      6660           -54.6%       3023        netperf.time.percent_of_cpu_this_job_got
     18970 ±  2%     -53.4%       8849        netperf.time.system_time
      1306           -76.9%     301.26 ±  9%  netperf.time.user_time
 2.016e+09 ±  7%     -68.3%  6.394e+08 ±  2%  netperf.time.voluntary_context_switches
 4.145e+09           -84.0%  6.625e+08 ±  3%  netperf.workload
      7442 ±  5%     +74.6%      12995 ±  2%  uptime.idle
  1.91e+08 ± 26%   +3587.1%  7.042e+09        cpuidle.C1.time
  25239057 ± 16%   +1634.0%  4.376e+08 ±  2%  cpuidle.C1.usage
   1373740 ± 13%   +1123.6%   16808508 ± 12%  cpuidle.C1E.usage
  19356693 ± 18%    +186.0%   55355728 ± 30%  cpuidle.POLL.time
    206522 ±103%   +1248.1%    2784046 ± 23%  numa-numastat.node0.local_node
    283690 ± 76%    +899.8%    2836469 ± 23%  numa-numastat.node0.numa_hit
    699972 ± 15%     +78.4%    1248418 ± 49%  numa-numastat.node3.local_node
    755619 ± 15%     +74.8%    1320493 ± 45%  numa-numastat.node3.numa_hit
     17.59 ±  4%      +7.3       24.87        mpstat.cpu.all.idle%
      0.90            +0.5        1.37 ±  4%  mpstat.cpu.all.irq%
     23.95           +14.4       38.40        mpstat.cpu.all.soft%
     53.63           -19.7       33.94        mpstat.cpu.all.sys%
      3.93            -2.5        1.42 ±  7%  mpstat.cpu.all.usr%
      1.33 ± 35%    +950.0%      14.00        vmstat.cpu.id
     93.00            -9.7%      84.00        vmstat.cpu.sy
   3378802 ±  9%    +143.8%    8238004        vmstat.memory.cache
    477.50           -14.4%     408.83        vmstat.procs.r
  27106400           -78.2%    5898538 ±  3%  vmstat.system.cs
   3232783 ± 10%    +149.3%    8058169        meminfo.Cached
   3008249 ± 11%    +161.2%    7856377        meminfo.Committed_AS
   2213694 ± 23%    +232.2%    7354700        meminfo.Inactive
   2213694 ± 23%    +232.2%    7354700        meminfo.Inactive(anon)
    909222 ± 25%    +178.8%    2534646        meminfo.Mapped
   6034546 ±  6%     +80.9%   10914745        meminfo.Memused
   2263228 ± 14%    +213.2%    7088623        meminfo.Shmem
   6316722 ±  4%     +76.3%   11134561        meminfo.max_used_kB
    959.50 ±  8%     -17.7%     789.83 ±  6%  slabinfo.mnt_cache.active_objs
    959.50 ±  8%     -17.7%     789.83 ±  6%  slabinfo.mnt_cache.num_objs
     30561 ±  4%     +62.4%      49631        slabinfo.radix_tree_node.active_objs
    545.33 ±  4%     +62.4%     885.83        slabinfo.radix_tree_node.active_slabs
     30561 ±  4%     +62.4%      49631        slabinfo.radix_tree_node.num_objs
    545.33 ±  4%     +62.4%     885.83        slabinfo.radix_tree_node.num_slabs
      1525 ±  8%     -13.0%       1327 ±  8%  slabinfo.task_group.active_objs
      1525 ±  8%     -13.0%       1327 ±  8%  slabinfo.task_group.num_objs
      2193 ± 62%    +287.7%       8502 ± 29%  numa-meminfo.node0.Active
      2193 ± 62%    +287.7%       8502 ± 29%  numa-meminfo.node0.Active(anon)
    260184 ±  7%   +1476.3%    4101372 ± 21%  numa-meminfo.node0.FilePages
    155797 ± 49%   +2472.0%    4007098 ± 23%  numa-meminfo.node0.Inactive
    155797 ± 49%   +2472.0%    4007098 ± 23%  numa-meminfo.node0.Inactive(anon)
     78745 ± 16%   +1791.3%    1489348 ± 11%  numa-meminfo.node0.Mapped
   1037565 ±  7%    +374.3%    4921173 ± 20%  numa-meminfo.node0.MemUsed
      8462 ± 57%  +45383.3%    3848873 ± 22%  numa-meminfo.node0.Shmem
    887567 ±  6%    +107.4%    1840670 ± 31%  numa-meminfo.node3.FilePages
    490746 ± 23%    +208.5%    1513789 ± 38%  numa-meminfo.node3.Inactive
    490746 ± 23%    +208.5%    1513789 ± 38%  numa-meminfo.node3.Inactive(anon)
    316259 ± 17%    +141.6%     764021 ± 10%  numa-meminfo.node3.Mapped
   1557192 ±  6%     +60.9%    2506075 ± 23%  numa-meminfo.node3.MemUsed
    643128 ±  9%    +150.1%    1608493 ± 36%  numa-meminfo.node3.Shmem
    549.33 ± 63%    +287.3%       2127 ± 29%  numa-vmstat.node0.nr_active_anon
     65046 ±  7%   +1479.4%    1027316 ± 21%  numa-vmstat.node0.nr_file_pages
     38946 ± 49%   +2477.3%    1003758 ± 23%  numa-vmstat.node0.nr_inactive_anon
     19771 ± 16%   +1791.7%     374017 ± 11%  numa-vmstat.node0.nr_mapped
      2115 ± 57%  +45473.9%     964192 ± 22%  numa-vmstat.node0.nr_shmem
    549.33 ± 63%    +287.3%       2127 ± 29%  numa-vmstat.node0.nr_zone_active_anon
     38946 ± 49%   +2477.3%    1003757 ± 23%  numa-vmstat.node0.nr_zone_inactive_anon
    717998 ± 18%    +143.8%    1750758 ± 21%  numa-vmstat.node0.numa_hit
    616749 ± 22%    +173.4%    1686107 ± 22%  numa-vmstat.node0.numa_local
    221911 ±  6%    +107.7%     460942 ± 31%  numa-vmstat.node3.nr_file_pages
    122508 ± 23%    +209.5%     379175 ± 38%  numa-vmstat.node3.nr_inactive_anon
     78890 ± 17%    +142.6%     191411 ± 10%  numa-vmstat.node3.nr_mapped
    160801 ±  9%    +150.6%     402898 ± 36%  numa-vmstat.node3.nr_shmem
    122507 ± 23%    +209.5%     379174 ± 38%  numa-vmstat.node3.nr_zone_inactive_anon
    111333            +4.6%     116424        proc-vmstat.nr_anon_pages
   4766626            -2.6%    4644729        proc-vmstat.nr_dirty_background_threshold
   9544909            -2.6%    9300815        proc-vmstat.nr_dirty_threshold
    809456 ± 10%    +149.1%    2016338        proc-vmstat.nr_file_pages
  47919019            -2.5%   46698243        proc-vmstat.nr_free_pages
    554049 ± 23%    +232.2%    1840432        proc-vmstat.nr_inactive_anon
    227517 ± 25%    +179.5%     635910        proc-vmstat.nr_mapped
      8267 ±  3%     +10.8%       9162 ±  3%  proc-vmstat.nr_page_table_pages
    567067 ± 14%    +212.8%    1773952        proc-vmstat.nr_shmem
     33641            +7.9%      36304        proc-vmstat.nr_slab_reclaimable
    554049 ± 23%    +232.2%    1840432        proc-vmstat.nr_zone_inactive_anon
    316039 ± 12%    +215.1%     995881 ±  6%  proc-vmstat.numa_hint_faults
    148817 ± 15%    +361.5%     686842 ±  8%  proc-vmstat.numa_hint_faults_local
   2728417 ±  7%    +117.3%    5929219        proc-vmstat.numa_hit
   2468898 ±  8%    +129.6%    5669750        proc-vmstat.numa_local
    640372 ±  8%    +103.8%    1305080 ±  4%  proc-vmstat.numa_pte_updates
   2852513 ±  7%    +112.4%    6057608        proc-vmstat.pgalloc_normal
   1894166 ±  2%     +44.9%    2745142 ±  2%  proc-vmstat.pgfault
     71009            -6.2%      66609        proc-vmstat.pgreuse
   1669483 ±223%    +547.5%   10809999 ±  9%  sched_debug.cfs_rq:/.MIN_vruntime.max
      1033 ± 33%    -100.0%       0.00        sched_debug.cfs_rq:/.load.min
      1.31 ± 38%     -55.3%       0.58 ± 35%  sched_debug.cfs_rq:/.load_avg.min
   1669483 ±223%    +547.5%   10809999 ±  9%  sched_debug.cfs_rq:/.max_vruntime.max
  21407196           -56.9%    9226871        sched_debug.cfs_rq:/.min_vruntime.avg
  29210953 ±  3%     -40.8%   17282658 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
  15709396 ±  4%     -44.5%    8715788        sched_debug.cfs_rq:/.min_vruntime.min
   3823741 ± 22%     -78.3%     828290 ± 12%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.83 ±  2%     -10.8%       0.74        sched_debug.cfs_rq:/.nr_running.avg
      0.81 ±  7%    -100.0%       0.00        sched_debug.cfs_rq:/.nr_running.min
      0.05 ± 61%    +472.8%       0.31 ±  3%  sched_debug.cfs_rq:/.nr_running.stddev
      1955 ±  5%     -13.4%       1693        sched_debug.cfs_rq:/.runnable_avg.avg
      3248 ± 10%     +23.1%       3997 ±  3%  sched_debug.cfs_rq:/.runnable_avg.max
    930.19 ± 12%     -22.0%     725.50 ±  2%  sched_debug.cfs_rq:/.runnable_avg.min
   3821269 ± 22%     -78.3%     828506 ± 12%  sched_debug.cfs_rq:/.spread0.stddev
    851.17 ±  3%     -44.5%     472.16        sched_debug.cfs_rq:/.util_avg.avg
      1259 ±  8%     -22.2%     979.56        sched_debug.cfs_rq:/.util_avg.max
    579.78 ± 14%     -31.1%     399.75 ±  4%  sched_debug.cfs_rq:/.util_avg.min
    570.92 ±  3%     -96.0%      23.10 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      1310 ± 13%     -61.6%     503.33 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.max
    156.42 ± 22%    -100.0%       0.00        sched_debug.cfs_rq:/.util_est_enqueued.min
    184.06 ±  4%     -74.4%      47.15 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
      5060 ± 14%     +66.2%       8409 ±  2%  sched_debug.cpu.avg_idle.min
     82.09 ±  9%     -67.5%      26.69 ±  3%  sched_debug.cpu.clock.stddev
    146203           -18.0%     119880        sched_debug.cpu.clock_task.avg
    148209           -13.6%     128111        sched_debug.cpu.clock_task.max
    137947           -18.6%     112301        sched_debug.cpu.clock_task.min
    891.38 ±  4%     +72.6%       1538 ± 25%  sched_debug.cpu.clock_task.stddev
      3530           -21.3%       2777        sched_debug.cpu.curr->pid.avg
      2591 ± 20%    -100.0%       0.00        sched_debug.cpu.curr->pid.min
    602.41 ± 18%    +173.6%       1648        sched_debug.cpu.curr->pid.stddev
      5317 ± 61%    +202.3%      16071 ± 74%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ± 36%     -69.7%       0.00        sched_debug.cpu.next_balance.stddev
      2.09 ±  4%     -13.8%       1.80 ±  4%  sched_debug.cpu.nr_running.avg
      3.69 ±  9%    +151.1%       9.28 ±  4%  sched_debug.cpu.nr_running.max
      0.81 ±  7%    -100.0%       0.00        sched_debug.cpu.nr_running.min
      0.64 ±  6%    +153.7%       1.63 ±  4%  sched_debug.cpu.nr_running.stddev
  21529949           -77.9%    4767019 ±  4%  sched_debug.cpu.nr_switches.avg
  22891153           -75.9%    5506756 ± 10%  sched_debug.cpu.nr_switches.max
  19927966           -80.4%    3915549 ±  5%  sched_debug.cpu.nr_switches.min
   4140603           -50.0%    2070075        sched_debug.sysctl_sched.sysctl_sched_features
      2.22 ± 10%    +979.8%      23.94        perf-stat.i.MPKI
 8.071e+10           -74.8%  2.031e+10 ±  2%  perf-stat.i.branch-instructions
      1.49            +0.2        1.66        perf-stat.i.branch-miss-rate%
 1.186e+09           -72.8%  3.221e+08 ±  2%  perf-stat.i.branch-misses
     22.12 ±  9%     -20.5        1.58 ±  5%  perf-stat.i.cache-miss-rate%
 1.804e+08 ± 14%     -81.1%   34036288 ±  6%  perf-stat.i.cache-misses
 8.328e+08 ±  9%    +167.1%  2.225e+09        perf-stat.i.cache-references
  27354194           -78.4%    5919450 ±  3%  perf-stat.i.context-switches
      1.41          +298.3%       5.62 ±  2%  perf-stat.i.cpi
 5.572e+11            -6.3%  5.222e+11        perf-stat.i.cpu-cycles
     24621 ± 51%  +12292.4%    3051146 ±  2%  perf-stat.i.cpu-migrations
      3286 ± 12%    +397.7%      16355 ±  7%  perf-stat.i.cycles-between-cache-misses
      0.03 ± 22%      +0.2        0.26 ±  5%  perf-stat.i.dTLB-load-miss-rate%
  29759619 ± 21%    +134.0%   69633082 ±  5%  perf-stat.i.dTLB-load-misses
 1.193e+11           -76.6%  2.789e+10 ±  2%  perf-stat.i.dTLB-loads
      0.01 ± 22%      +0.1        0.08 ±  5%  perf-stat.i.dTLB-store-miss-rate%
   5015493 ± 21%    +104.6%   10261112 ±  4%  perf-stat.i.dTLB-store-misses
 6.778e+10           -78.9%  1.433e+10 ±  2%  perf-stat.i.dTLB-stores
     69.23            -6.7       62.58        perf-stat.i.iTLB-load-miss-rate%
 7.013e+08           -78.2%  1.526e+08 ±  3%  perf-stat.i.iTLB-load-misses
 3.103e+08           -70.9%   90260578 ±  2%  perf-stat.i.iTLB-loads
 4.001e+11           -75.4%  9.836e+10 ±  2%  perf-stat.i.instructions
    587.02           +10.6%     649.42        perf-stat.i.instructions-per-iTLB-miss
      0.72           -73.4%       0.19 ±  2%  perf-stat.i.ipc
      2.90            -6.3%       2.72        perf-stat.i.metric.GHz
      0.18 ± 12%     +77.0%       0.31 ± 13%  perf-stat.i.metric.K/sec
      1401           -75.9%     337.91 ±  2%  perf-stat.i.metric.M/sec
      6086 ±  2%     +45.2%       8834 ±  2%  perf-stat.i.minor-faults
  41400698 ± 15%     -74.0%   10763215 ±  6%  perf-stat.i.node-load-misses
   5852508 ±  8%     -69.1%    1808560 ±  4%  perf-stat.i.node-loads
     99.07            -5.1       94.00        perf-stat.i.node-store-miss-rate%
  14478209 ± 11%     -62.0%    5508812 ±  4%  perf-stat.i.node-store-misses
     88440 ± 30%    +579.5%     600931 ±  6%  perf-stat.i.node-stores
      6087 ±  2%     +45.1%       8835 ±  2%  perf-stat.i.page-faults
      2.09 ± 10%    +985.1%      22.63        perf-stat.overall.MPKI
      1.47            +0.1        1.59        perf-stat.overall.branch-miss-rate%
     21.62 ±  9%     -20.1        1.53 ±  6%  perf-stat.overall.cache-miss-rate%
      1.39          +281.5%       5.31 ±  2%  perf-stat.overall.cpi
      3148 ± 13%    +389.9%      15426 ±  6%  perf-stat.overall.cycles-between-cache-misses
      0.03 ± 22%      +0.2        0.25 ±  6%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ± 22%      +0.1        0.07 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
     69.32            -6.5       62.83        perf-stat.overall.iTLB-load-miss-rate%
    570.55           +13.0%     644.62        perf-stat.overall.instructions-per-iTLB-miss
      0.72           -73.8%       0.19 ±  2%  perf-stat.overall.ipc
     99.37            -9.2       90.19        perf-stat.overall.node-store-miss-rate%
     29341           +52.9%      44875        perf-stat.overall.path-length
 8.042e+10           -74.8%  2.023e+10 ±  2%  perf-stat.ps.branch-instructions
 1.181e+09           -72.8%  3.209e+08 ±  2%  perf-stat.ps.branch-misses
 1.797e+08 ± 14%     -81.1%   33893343 ±  6%  perf-stat.ps.cache-misses
 8.305e+08 ±  9%    +166.9%  2.217e+09        perf-stat.ps.cache-references
  27256541           -78.4%    5898690 ±  3%  perf-stat.ps.context-switches
 5.552e+11            -6.3%  5.204e+11        perf-stat.ps.cpu-cycles
     24729 ± 50%  +12196.4%    3040885 ±  2%  perf-stat.ps.cpu-migrations
  29676518 ± 21%    +133.9%   69414938 ±  5%  perf-stat.ps.dTLB-load-misses
 1.188e+11           -76.6%  2.779e+10 ±  2%  perf-stat.ps.dTLB-loads
   4995687 ± 21%    +104.7%   10225922 ±  4%  perf-stat.ps.dTLB-store-misses
 6.753e+10           -78.9%  1.428e+10 ±  2%  perf-stat.ps.dTLB-stores
 6.987e+08           -78.2%  1.521e+08 ±  3%  perf-stat.ps.iTLB-load-misses
 3.092e+08           -70.9%   89948944 ±  2%  perf-stat.ps.iTLB-loads
 3.987e+11           -75.4%  9.799e+10 ±  2%  perf-stat.ps.instructions
      6065 ±  2%     +44.7%       8777 ±  2%  perf-stat.ps.minor-faults
  41255334 ± 15%     -74.0%   10721928 ±  6%  perf-stat.ps.node-load-misses
   5829908 ±  8%     -69.2%    1793127 ±  4%  perf-stat.ps.node-loads
  14427293 ± 11%     -62.0%    5487905 ±  4%  perf-stat.ps.node-store-misses
     88224 ± 30%    +576.2%     596567 ±  6%  perf-stat.ps.node-stores
      6066 ±  2%     +44.7%       8779 ±  2%  perf-stat.ps.page-faults
 1.216e+14           -75.6%  2.972e+13 ±  2%  perf-stat.total.instructions
      4.05 ±129%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1.47 ±220%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
     10.60 ±213%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     24.92 ±156%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.03 ± 66%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
     25.48 ±124%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      4.68 ± 22%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
    191.29 ±117%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.02 ± 16%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.02 ± 19%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.01 ± 17%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     45.51 ± 45%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.40 ± 14%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      0.12 ± 87%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
    196.21 ±177%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      4.26 ±121%    -100.0%       0.00        perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1.47 ±220%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
    172.87 ±217%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    552.66 ±147%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      3900 ± 33%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      1268 ±114%    -100.0%       0.00        perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
     18.62 ± 30%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      1409 ± 77%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.02 ± 23%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.02 ± 21%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.01 ± 36%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1193 ± 43%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      6097 ± 19%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      1049 ± 91%    -100.0%       0.00        perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      1527 ±142%    -100.0%       0.00        perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.22 ± 16%    -100.0%       0.00        perf-sched.total_sch_delay.average.ms
      6208 ± 17%    -100.0%       0.00        perf-sched.total_sch_delay.max.ms
      1.67 ± 13%    -100.0%       0.00        perf-sched.total_wait_and_delay.average.ms
   5989381 ± 15%    -100.0%       0.00        perf-sched.total_wait_and_delay.count.ms
     12710 ± 16%    -100.0%       0.00        perf-sched.total_wait_and_delay.max.ms
      1.45 ± 13%    -100.0%       0.00        perf-sched.total_wait_time.average.ms
     10832 ±  7%    -100.0%       0.00        perf-sched.total_wait_time.max.ms
    104.43 ±113%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.95 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
    184.94 ± 63%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
     26.74 ± 63%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      4.69 ± 22%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
     38.80 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    440.54 ±101%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    131.85 ± 41%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      1.55 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    271.01 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
    604.50 ± 97%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
     16.17 ± 42%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
   2979948 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
    120.33 ± 66%    -100.0%       0.00        perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
     68.50 ±146%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
     11.00 ± 24%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
    265.83 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
     21.00 ± 54%    -100.0%       0.00        perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork
     76.50 ± 29%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
   2999846 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      8868 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
     33.83 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      1507 ±117%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      9360 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      5712 ± 31%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
    514.61 ±170%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
     18.62 ± 30%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      1021          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      3023 ± 66%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      2726 ± 41%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     12274 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     10832 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      6020 ± 61%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.52 ± 60%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     79.51 ±103%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.04 ± 12%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.93 ± 13%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
    159.46 ± 77%    -100.0%       0.00        perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
    149.83 ±124%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
     45.93 ±223%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      0.04 ± 31%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
      1.88 ± 24%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
     26.74 ± 63%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
     49.53 ±223%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.sk_stream_alloc_skb
     38.80 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    249.25 ± 90%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    150.13 ±221%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     86.34 ± 39%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      1.14 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    270.88 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.21 ± 47%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    408.29 ± 78%    -100.0%       0.00        perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      3.32 ± 94%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1310 ±121%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.09 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      6865 ± 27%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      5516 ± 38%    -100.0%       0.00        perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
    697.96 ±121%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
    183.54 ±223%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      0.07 ± 32%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
      2.46 ± 34%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
    514.61 ±170%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
    259.91 ±223%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.sk_stream_alloc_skb
      1021          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      1645 ± 56%    -100.0%       0.00        perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork
    598.67 ±222%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1720 ± 34%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      7531 ± 24%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     10832 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.36 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      5350 ± 80%    -100.0%       0.00        perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
      9807 ± 93%     -91.3%     851.33 ± 85%  interrupts.38:PCI-MSI.524289-edge.eth0-TxRx-0
    904091 ± 36%   +4206.1%   38931156        interrupts.CAL:Function_call_interrupts
      5173 ± 46%   +3806.8%     202126 ±  7%  interrupts.CPU0.CAL:Function_call_interrupts
      2548 ± 48%   +1720.3%      46390 ± 16%  interrupts.CPU0.RES:Rescheduling_interrupts
      3437 ± 38%   +6138.4%     214436 ±  5%  interrupts.CPU1.CAL:Function_call_interrupts
      2474 ± 49%   +1919.7%      49976 ± 13%  interrupts.CPU1.RES:Rescheduling_interrupts
      9807 ± 93%     -91.3%     851.33 ± 85%  interrupts.CPU10.38:PCI-MSI.524289-edge.eth0-TxRx-0
      4273 ± 51%   +4949.3%     215763 ±  5%  interrupts.CPU10.CAL:Function_call_interrupts
      2278 ± 39%   +2065.8%      49343 ± 12%  interrupts.CPU10.RES:Rescheduling_interrupts
      4627 ± 52%   +4584.7%     216786 ±  5%  interrupts.CPU100.CAL:Function_call_interrupts
      2163 ± 43%   +2121.7%      48055 ± 12%  interrupts.CPU100.RES:Rescheduling_interrupts
      4425 ± 53%   +4759.5%     215048 ±  6%  interrupts.CPU101.CAL:Function_call_interrupts
      2417 ± 60%   +1879.9%      47866 ± 12%  interrupts.CPU101.RES:Rescheduling_interrupts
      4448 ± 53%   +4608.1%     209441 ± 12%  interrupts.CPU102.CAL:Function_call_interrupts
      1532 ± 54%   +2864.2%      45411 ± 16%  interrupts.CPU102.RES:Rescheduling_interrupts
      4439 ± 55%   +4752.2%     215395 ±  6%  interrupts.CPU103.CAL:Function_call_interrupts
      1869 ± 49%   +2479.1%      48225 ± 12%  interrupts.CPU103.RES:Rescheduling_interrupts
      4324 ± 52%   +4805.6%     212125 ±  6%  interrupts.CPU104.CAL:Function_call_interrupts
      2479 ± 36%   +1843.9%      48199 ± 12%  interrupts.CPU104.RES:Rescheduling_interrupts
      4306 ± 50%   +4857.5%     213496 ±  6%  interrupts.CPU105.CAL:Function_call_interrupts
      2907 ± 53%   +1552.3%      48033 ± 12%  interrupts.CPU105.RES:Rescheduling_interrupts
      4384 ± 52%   +4802.3%     214951 ±  6%  interrupts.CPU106.CAL:Function_call_interrupts
      3612 ± 51%   +1229.8%      48033 ± 12%  interrupts.CPU106.RES:Rescheduling_interrupts
      4342 ± 50%   +4849.2%     214912 ±  6%  interrupts.CPU107.CAL:Function_call_interrupts
      2862 ± 38%   +1575.6%      47964 ± 13%  interrupts.CPU107.RES:Rescheduling_interrupts
      4322 ± 50%   +4816.8%     212535 ±  5%  interrupts.CPU108.CAL:Function_call_interrupts
      2011 ± 34%   +2277.0%      47810 ± 12%  interrupts.CPU108.RES:Rescheduling_interrupts
      4271 ± 52%   +4913.2%     214149 ±  6%  interrupts.CPU109.CAL:Function_call_interrupts
      2298 ± 54%   +1987.9%      47990 ± 12%  interrupts.CPU109.RES:Rescheduling_interrupts
      4264 ± 49%   +4936.9%     214807 ±  6%  interrupts.CPU11.CAL:Function_call_interrupts
      2407 ± 29%   +1970.7%      49842 ± 14%  interrupts.CPU11.RES:Rescheduling_interrupts
      4288 ± 54%   +4903.4%     214547 ±  6%  interrupts.CPU110.CAL:Function_call_interrupts
      2075 ± 30%   +2225.2%      48252 ± 12%  interrupts.CPU110.RES:Rescheduling_interrupts
      4342 ± 48%   +4845.1%     214749 ±  6%  interrupts.CPU111.CAL:Function_call_interrupts
      2311 ± 41%   +1981.0%      48108 ± 12%  interrupts.CPU111.RES:Rescheduling_interrupts
      4299 ± 52%   +4852.0%     212928 ±  6%  interrupts.CPU112.CAL:Function_call_interrupts
      2217 ± 48%   +2071.7%      48150 ± 12%  interrupts.CPU112.RES:Rescheduling_interrupts
      4442 ± 48%   +4668.2%     211836 ±  6%  interrupts.CPU113.CAL:Function_call_interrupts
      1801 ± 50%   +2549.2%      47733 ± 12%  interrupts.CPU113.RES:Rescheduling_interrupts
      4309 ± 52%   +4870.8%     214200 ±  6%  interrupts.CPU114.CAL:Function_call_interrupts
      2982 ± 48%   +1497.1%      47633 ± 13%  interrupts.CPU114.RES:Rescheduling_interrupts
      4480 ± 56%   +4709.7%     215506 ±  6%  interrupts.CPU115.CAL:Function_call_interrupts
      1757 ± 34%   +2631.7%      47996 ± 12%  interrupts.CPU115.RES:Rescheduling_interrupts
      4440 ± 54%   +4758.6%     215744 ±  6%  interrupts.CPU116.CAL:Function_call_interrupts
      3547 ± 57%   +1252.7%      47984 ± 12%  interrupts.CPU116.RES:Rescheduling_interrupts
      4219 ± 51%   +4930.2%     212222 ±  6%  interrupts.CPU117.CAL:Function_call_interrupts
      1659 ± 47%   +2779.5%      47784 ± 13%  interrupts.CPU117.RES:Rescheduling_interrupts
      4271 ± 51%   +4875.0%     212505 ±  7%  interrupts.CPU118.CAL:Function_call_interrupts
      2078 ± 59%   +2182.3%      47437 ± 12%  interrupts.CPU118.RES:Rescheduling_interrupts
      3896 ± 57%   +5360.0%     212730 ±  6%  interrupts.CPU119.CAL:Function_call_interrupts
      2811 ± 63%   +1596.2%      47695 ± 12%  interrupts.CPU119.RES:Rescheduling_interrupts
      4272 ± 53%   +4906.0%     213865 ±  5%  interrupts.CPU12.CAL:Function_call_interrupts
      2226 ± 42%   +2098.5%      48948 ± 12%  interrupts.CPU12.RES:Rescheduling_interrupts
      3892 ± 42%   +5007.4%     198788 ±  7%  interrupts.CPU120.CAL:Function_call_interrupts
      1874 ± 42%   +2492.3%      48584 ± 13%  interrupts.CPU120.RES:Rescheduling_interrupts
      3988 ± 41%   +4940.1%     201026 ±  6%  interrupts.CPU121.CAL:Function_call_interrupts
      2865 ± 35%   +1595.0%      48562 ± 13%  interrupts.CPU121.RES:Rescheduling_interrupts
      4099 ± 44%   +4768.3%     199585 ±  7%  interrupts.CPU122.CAL:Function_call_interrupts
      2896 ± 48%   +1574.6%      48497 ± 14%  interrupts.CPU122.RES:Rescheduling_interrupts
      4093 ± 44%   +4867.6%     203331 ±  6%  interrupts.CPU123.CAL:Function_call_interrupts
      1746 ± 33%   +2674.9%      48454 ± 13%  interrupts.CPU123.RES:Rescheduling_interrupts
      4069 ± 45%   +4884.4%     202850 ±  6%  interrupts.CPU124.CAL:Function_call_interrupts
      1908 ± 49%   +2428.3%      48239 ± 14%  interrupts.CPU124.RES:Rescheduling_interrupts
      3890 ± 45%   +5144.0%     204026 ±  5%  interrupts.CPU125.CAL:Function_call_interrupts
      1687 ± 40%   +2761.2%      48273 ± 13%  interrupts.CPU125.RES:Rescheduling_interrupts
      4088 ± 46%   +4860.3%     202784 ±  6%  interrupts.CPU126.CAL:Function_call_interrupts
      2081 ± 36%   +2210.1%      48072 ± 13%  interrupts.CPU126.RES:Rescheduling_interrupts
      4011 ± 45%   +4939.2%     202129 ±  6%  interrupts.CPU127.CAL:Function_call_interrupts
      2573 ± 49%   +1786.6%      48542 ± 13%  interrupts.CPU127.RES:Rescheduling_interrupts
      3825 ± 43%   +5137.6%     200345 ±  6%  interrupts.CPU128.CAL:Function_call_interrupts
      1565 ± 51%   +3005.8%      48631 ± 14%  interrupts.CPU128.RES:Rescheduling_interrupts
      3872 ± 43%   +5066.4%     200050 ±  7%  interrupts.CPU129.CAL:Function_call_interrupts
      2961 ± 46%   +1529.7%      48257 ± 14%  interrupts.CPU129.RES:Rescheduling_interrupts
      4269 ± 51%   +4894.4%     213235 ±  5%  interrupts.CPU13.CAL:Function_call_interrupts
      2426 ± 55%   +1937.6%      49439 ± 12%  interrupts.CPU13.RES:Rescheduling_interrupts
      4001 ± 46%   +4946.9%     201969 ±  6%  interrupts.CPU130.CAL:Function_call_interrupts
      2232 ± 38%   +2071.7%      48479 ± 14%  interrupts.CPU130.RES:Rescheduling_interrupts
      3906 ± 43%   +5029.0%     200382 ±  6%  interrupts.CPU131.CAL:Function_call_interrupts
      2150 ± 68%   +2139.5%      48167 ± 13%  interrupts.CPU131.RES:Rescheduling_interrupts
      3818 ± 45%   +5113.6%     199080 ±  6%  interrupts.CPU132.CAL:Function_call_interrupts
      1515 ± 52%   +3075.5%      48113 ± 14%  interrupts.CPU132.RES:Rescheduling_interrupts
      3813 ± 44%   +5113.5%     198815 ±  6%  interrupts.CPU133.CAL:Function_call_interrupts
      2258 ± 42%   +2046.2%      48464 ± 14%  interrupts.CPU133.RES:Rescheduling_interrupts
      3837 ± 43%   +5116.6%     200187 ±  6%  interrupts.CPU134.CAL:Function_call_interrupts
      1922 ± 42%   +2432.6%      48677 ± 14%  interrupts.CPU134.RES:Rescheduling_interrupts
      3907 ± 42%   +5033.3%     200602 ±  6%  interrupts.CPU135.CAL:Function_call_interrupts
      2667 ± 44%   +1714.2%      48394 ± 13%  interrupts.CPU135.RES:Rescheduling_interrupts
      3754 ± 43%   +5199.8%     198996 ±  7%  interrupts.CPU136.CAL:Function_call_interrupts
      1924 ± 59%   +2410.0%      48300 ± 13%  interrupts.CPU136.RES:Rescheduling_interrupts
      3853 ± 42%   +5070.9%     199261 ±  6%  interrupts.CPU137.CAL:Function_call_interrupts
      2830 ± 63%   +1602.9%      48195 ± 13%  interrupts.CPU137.RES:Rescheduling_interrupts
      3937 ± 46%   +4996.8%     200678 ±  6%  interrupts.CPU138.CAL:Function_call_interrupts
      1753 ± 41%   +2649.4%      48196 ± 13%  interrupts.CPU138.RES:Rescheduling_interrupts
      3807 ± 43%   +5193.6%     201572 ±  6%  interrupts.CPU139.CAL:Function_call_interrupts
      1365 ± 39%   +3462.0%      48651 ± 14%  interrupts.CPU139.RES:Rescheduling_interrupts
      4296 ± 51%   +4937.4%     216447 ±  5%  interrupts.CPU14.CAL:Function_call_interrupts
      2288 ± 51%   +2061.3%      49461 ± 13%  interrupts.CPU14.RES:Rescheduling_interrupts
      3937 ± 44%   +5023.7%     201754 ±  6%  interrupts.CPU140.CAL:Function_call_interrupts
      1704 ± 56%   +2752.1%      48623 ± 14%  interrupts.CPU140.RES:Rescheduling_interrupts
      3782 ± 45%   +5116.1%     197308 ±  6%  interrupts.CPU141.CAL:Function_call_interrupts
      1479 ± 28%   +3180.1%      48534 ± 14%  interrupts.CPU141.RES:Rescheduling_interrupts
      3818 ± 44%   +5085.1%     198011 ±  6%  interrupts.CPU142.CAL:Function_call_interrupts
      1522 ± 35%   +3050.8%      47965 ± 14%  interrupts.CPU142.RES:Rescheduling_interrupts
      3908 ± 40%   +4969.2%     198112 ±  7%  interrupts.CPU143.CAL:Function_call_interrupts
      2302 ± 42%   +1985.8%      48033 ± 13%  interrupts.CPU143.RES:Rescheduling_interrupts
      4198 ± 60%   +4728.9%     202725 ±  7%  interrupts.CPU144.CAL:Function_call_interrupts
      2144 ± 44%   +2075.5%      46646 ± 16%  interrupts.CPU144.RES:Rescheduling_interrupts
      4255 ± 59%   +4699.2%     204206 ±  7%  interrupts.CPU145.CAL:Function_call_interrupts
      1642 ± 43%   +2735.8%      46569 ± 16%  interrupts.CPU145.RES:Rescheduling_interrupts
      4283 ± 57%   +4650.5%     203470 ±  7%  interrupts.CPU146.CAL:Function_call_interrupts
      2927 ± 51%   +1485.1%      46394 ± 16%  interrupts.CPU146.RES:Rescheduling_interrupts
      4292 ± 59%   +4667.7%     204668 ±  7%  interrupts.CPU147.CAL:Function_call_interrupts
      2432 ± 39%   +1809.5%      46441 ± 16%  interrupts.CPU147.RES:Rescheduling_interrupts
      4268 ± 58%   +4662.4%     203291 ±  7%  interrupts.CPU148.CAL:Function_call_interrupts
      1587 ± 49%   +2815.5%      46293 ± 16%  interrupts.CPU148.RES:Rescheduling_interrupts
      4283 ± 58%   +4628.4%     202555 ±  7%  interrupts.CPU149.CAL:Function_call_interrupts
      2238 ± 37%   +1962.7%      46179 ± 16%  interrupts.CPU149.RES:Rescheduling_interrupts
      4342 ± 54%   +4878.5%     216208 ±  5%  interrupts.CPU15.CAL:Function_call_interrupts
      2941 ± 37%   +1579.8%      49415 ± 12%  interrupts.CPU15.RES:Rescheduling_interrupts
      4304 ± 58%   +4604.5%     202480 ±  7%  interrupts.CPU150.CAL:Function_call_interrupts
      2828 ± 63%   +1527.5%      46040 ± 16%  interrupts.CPU150.RES:Rescheduling_interrupts
      4385 ± 54%   +4513.1%     202284 ±  7%  interrupts.CPU151.CAL:Function_call_interrupts
      2372 ± 43%   +1854.2%      46363 ± 16%  interrupts.CPU151.RES:Rescheduling_interrupts
      4298 ± 58%   +4602.3%     202137 ±  7%  interrupts.CPU152.CAL:Function_call_interrupts
      2039 ± 50%   +2176.7%      46432 ± 15%  interrupts.CPU152.RES:Rescheduling_interrupts
      4270 ± 59%   +4644.4%     202594 ±  7%  interrupts.CPU153.CAL:Function_call_interrupts
      1962 ± 45%   +2253.4%      46181 ± 16%  interrupts.CPU153.RES:Rescheduling_interrupts
      4191 ± 59%   +4687.4%     200640 ±  8%  interrupts.CPU154.CAL:Function_call_interrupts
      1609 ± 46%   +2775.9%      46273 ± 16%  interrupts.CPU154.RES:Rescheduling_interrupts
      4140 ± 57%   +4800.0%     202885 ±  7%  interrupts.CPU155.CAL:Function_call_interrupts
      2165 ± 44%   +2030.1%      46133 ± 16%  interrupts.CPU155.RES:Rescheduling_interrupts
      4221 ± 59%   +4677.0%     201676 ±  7%  interrupts.CPU156.CAL:Function_call_interrupts
      2264 ± 76%   +1940.9%      46219 ± 16%  interrupts.CPU156.RES:Rescheduling_interrupts
      4276 ± 60%   +4594.6%     200757 ±  8%  interrupts.CPU157.CAL:Function_call_interrupts
      2595 ± 47%   +1687.2%      46378 ± 16%  interrupts.CPU157.RES:Rescheduling_interrupts
      4244 ± 59%   +4686.9%     203195 ±  7%  interrupts.CPU158.CAL:Function_call_interrupts
      2996 ± 51%   +1442.7%      46227 ± 16%  interrupts.CPU158.RES:Rescheduling_interrupts
      4309 ± 58%   +4605.3%     202774 ±  7%  interrupts.CPU159.CAL:Function_call_interrupts
      2074 ± 54%   +2139.7%      46465 ± 16%  interrupts.CPU159.RES:Rescheduling_interrupts
      4303 ± 51%   +4880.5%     214313 ±  6%  interrupts.CPU16.CAL:Function_call_interrupts
      2065 ± 48%   +2290.8%      49375 ± 12%  interrupts.CPU16.RES:Rescheduling_interrupts
      4459 ± 57%   +4455.5%     203129 ±  7%  interrupts.CPU160.CAL:Function_call_interrupts
      2967 ± 25%   +1462.5%      46371 ± 16%  interrupts.CPU160.RES:Rescheduling_interrupts
      4397 ± 56%   +4459.5%     200497 ±  7%  interrupts.CPU161.CAL:Function_call_interrupts
      2267 ± 53%   +1951.8%      46514 ± 18%  interrupts.CPU161.RES:Rescheduling_interrupts
      4330 ± 59%   +4554.4%     201543 ±  7%  interrupts.CPU162.CAL:Function_call_interrupts
      2667 ± 37%   +1641.9%      46460 ± 16%  interrupts.CPU162.RES:Rescheduling_interrupts
      4401 ± 55%   +4524.8%     203561 ±  7%  interrupts.CPU163.CAL:Function_call_interrupts
      3247 ± 44%   +1332.5%      46524 ± 16%  interrupts.CPU163.RES:Rescheduling_interrupts
      4187 ± 57%   +4706.3%     201246 ±  7%  interrupts.CPU164.CAL:Function_call_interrupts
      1821 ± 36%   +2442.8%      46317 ± 16%  interrupts.CPU164.RES:Rescheduling_interrupts
      4227 ± 52%   +4641.5%     200438 ±  7%  interrupts.CPU165.CAL:Function_call_interrupts
      2505 ± 38%   +1750.3%      46353 ± 16%  interrupts.CPU165.RES:Rescheduling_interrupts
      4266 ± 60%   +4654.7%     202859 ±  7%  interrupts.CPU166.CAL:Function_call_interrupts
      1935 ± 46%   +2293.6%      46316 ± 16%  interrupts.CPU166.RES:Rescheduling_interrupts
      4165 ± 56%   +4731.5%     201230 ±  7%  interrupts.CPU167.CAL:Function_call_interrupts
      2339 ± 37%   +1870.9%      46105 ± 16%  interrupts.CPU167.RES:Rescheduling_interrupts
      6514 ± 44%   +2873.2%     193677 ±  3%  interrupts.CPU168.CAL:Function_call_interrupts
      3170 ± 46%   +1436.3%      48704 ± 10%  interrupts.CPU168.RES:Rescheduling_interrupts
      6459 ± 44%   +2847.6%     190411 ±  9%  interrupts.CPU169.CAL:Function_call_interrupts
      2702 ± 27%   +1619.8%      46470 ± 10%  interrupts.CPU169.RES:Rescheduling_interrupts
      4276 ± 51%   +4910.0%     214269 ±  5%  interrupts.CPU17.CAL:Function_call_interrupts
      2058 ± 48%   +2281.8%      49030 ± 12%  interrupts.CPU17.RES:Rescheduling_interrupts
      6439 ± 43%   +2942.9%     195932 ±  4%  interrupts.CPU170.CAL:Function_call_interrupts
      3072 ± 23%   +1485.4%      48709 ± 10%  interrupts.CPU170.RES:Rescheduling_interrupts
      6423 ± 44%   +2980.6%     197881 ±  4%  interrupts.CPU171.CAL:Function_call_interrupts
      2570 ± 45%   +1779.0%      48307 ± 10%  interrupts.CPU171.RES:Rescheduling_interrupts
      6399 ± 42%   +2924.6%     193558 ±  4%  interrupts.CPU172.CAL:Function_call_interrupts
      3087 ± 24%   +1470.7%      48491 ± 10%  interrupts.CPU172.RES:Rescheduling_interrupts
      6293 ± 43%   +2967.2%     193037 ±  4%  interrupts.CPU173.CAL:Function_call_interrupts
      2488 ± 49%   +1827.3%      47968 ± 10%  interrupts.CPU173.RES:Rescheduling_interrupts
      6385 ± 43%   +2941.0%     194196 ±  4%  interrupts.CPU174.CAL:Function_call_interrupts
      2925 ± 56%   +1545.4%      48126 ± 10%  interrupts.CPU174.RES:Rescheduling_interrupts
      6382 ± 44%   +2917.9%     192611 ±  4%  interrupts.CPU175.CAL:Function_call_interrupts
      2941 ± 45%   +1552.6%      48608 ± 10%  interrupts.CPU175.RES:Rescheduling_interrupts
      6500 ± 43%   +2867.8%     192906 ±  4%  interrupts.CPU176.CAL:Function_call_interrupts
      2416 ± 45%   +1913.1%      48643 ± 10%  interrupts.CPU176.RES:Rescheduling_interrupts
      6466 ± 44%   +2900.9%     194049 ±  4%  interrupts.CPU177.CAL:Function_call_interrupts
      3317 ± 29%   +1363.4%      48542 ± 10%  interrupts.CPU177.RES:Rescheduling_interrupts
      6335 ± 43%   +2907.6%     190551 ±  4%  interrupts.CPU178.CAL:Function_call_interrupts
      2739 ± 50%   +1659.1%      48186 ± 10%  interrupts.CPU178.RES:Rescheduling_interrupts
      6440 ± 44%   +2905.8%     193583 ±  4%  interrupts.CPU179.CAL:Function_call_interrupts
      3212 ± 54%   +1400.2%      48189 ± 10%  interrupts.CPU179.RES:Rescheduling_interrupts
      4346 ± 52%   +4869.8%     216003 ±  5%  interrupts.CPU18.CAL:Function_call_interrupts
      2773 ± 23%   +1668.4%      49037 ± 12%  interrupts.CPU18.RES:Rescheduling_interrupts
      6207 ± 45%   +3007.1%     192868 ±  4%  interrupts.CPU180.CAL:Function_call_interrupts
      3346 ± 42%   +1345.2%      48361 ± 11%  interrupts.CPU180.RES:Rescheduling_interrupts
      6340 ± 44%   +2895.0%     189907 ±  4%  interrupts.CPU181.CAL:Function_call_interrupts
      2838 ± 56%   +1575.8%      47563 ± 11%  interrupts.CPU181.RES:Rescheduling_interrupts
      6365 ± 43%   +2934.2%     193143 ±  4%  interrupts.CPU182.CAL:Function_call_interrupts
      2646 ± 45%   +1745.8%      48853 ± 10%  interrupts.CPU182.RES:Rescheduling_interrupts
      6316 ± 44%   +2940.0%     192012 ±  4%  interrupts.CPU183.CAL:Function_call_interrupts
      3058 ± 38%   +1485.0%      48481 ± 10%  interrupts.CPU183.RES:Rescheduling_interrupts
      6472 ± 43%   +2888.3%     193422 ±  4%  interrupts.CPU184.CAL:Function_call_interrupts
      3005 ± 44%   +1508.6%      48348 ± 10%  interrupts.CPU184.RES:Rescheduling_interrupts
      6309 ± 43%   +2947.5%     192281 ±  4%  interrupts.CPU185.CAL:Function_call_interrupts
      2506 ± 48%   +1817.2%      48050 ± 10%  interrupts.CPU185.RES:Rescheduling_interrupts
      6266 ± 43%   +2954.5%     191418 ±  4%  interrupts.CPU186.CAL:Function_call_interrupts
      2559 ± 48%   +1791.2%      48396 ± 10%  interrupts.CPU186.RES:Rescheduling_interrupts
      6411 ± 42%   +2941.6%     195019 ±  4%  interrupts.CPU187.CAL:Function_call_interrupts
      3056 ± 44%   +1483.4%      48396 ± 10%  interrupts.CPU187.RES:Rescheduling_interrupts
      6412 ± 43%   +2920.5%     193697 ±  5%  interrupts.CPU188.CAL:Function_call_interrupts
      2539 ± 35%   +1803.0%      48329 ± 10%  interrupts.CPU188.RES:Rescheduling_interrupts
      6250 ± 43%   +2958.8%     191179 ±  4%  interrupts.CPU189.CAL:Function_call_interrupts
      2696 ± 37%   +1697.4%      48464 ± 10%  interrupts.CPU189.RES:Rescheduling_interrupts
      4352 ± 53%   +4888.8%     217146 ±  5%  interrupts.CPU19.CAL:Function_call_interrupts
      1970 ± 41%   +2394.5%      49161 ± 12%  interrupts.CPU19.RES:Rescheduling_interrupts
      6245 ± 44%   +2971.5%     191834 ±  4%  interrupts.CPU190.CAL:Function_call_interrupts
      2710 ± 37%   +1671.5%      48008 ± 10%  interrupts.CPU190.RES:Rescheduling_interrupts
      6404 ± 41%   +2777.1%     184260 ±  4%  interrupts.CPU191.CAL:Function_call_interrupts
      2449 ± 41%   +1799.2%      46510 ± 10%  interrupts.CPU191.RES:Rescheduling_interrupts
      4527 ± 57%   +4552.3%     210625 ±  6%  interrupts.CPU2.CAL:Function_call_interrupts
      1940 ± 39%   +2376.1%      48057 ± 18%  interrupts.CPU2.RES:Rescheduling_interrupts
      7.50 ±152%   +1506.7%     120.50 ± 70%  interrupts.CPU2.TLB:TLB_shootdowns
      4375 ± 52%   +4840.8%     216158 ±  5%  interrupts.CPU20.CAL:Function_call_interrupts
      2963 ± 32%   +1561.7%      49236 ± 12%  interrupts.CPU20.RES:Rescheduling_interrupts
      4404 ± 55%   +4774.1%     214678 ±  6%  interrupts.CPU21.CAL:Function_call_interrupts
      1918 ± 42%   +2460.1%      49124 ± 12%  interrupts.CPU21.RES:Rescheduling_interrupts
      4408 ± 54%   +4736.4%     213197 ±  6%  interrupts.CPU22.CAL:Function_call_interrupts
      2135 ± 45%   +2196.0%      49039 ± 12%  interrupts.CPU22.RES:Rescheduling_interrupts
      4298 ± 57%   +4878.8%     214013 ±  6%  interrupts.CPU23.CAL:Function_call_interrupts
      2044 ± 53%   +2288.2%      48823 ± 12%  interrupts.CPU23.RES:Rescheduling_interrupts
      3872 ± 40%   +5034.3%     198807 ±  6%  interrupts.CPU24.CAL:Function_call_interrupts
      2057 ± 50%   +2331.8%      50035 ± 14%  interrupts.CPU24.RES:Rescheduling_interrupts
      3623 ± 38%   +5365.7%     198067 ±  6%  interrupts.CPU25.CAL:Function_call_interrupts
      2720 ± 16%   +1730.8%      49803 ± 14%  interrupts.CPU25.RES:Rescheduling_interrupts
      3893 ± 40%   +4987.4%     198095 ±  6%  interrupts.CPU26.CAL:Function_call_interrupts
      2743 ± 36%   +1714.9%      49786 ± 13%  interrupts.CPU26.RES:Rescheduling_interrupts
      3171 ± 35%   +6270.5%     202007 ±  6%  interrupts.CPU27.CAL:Function_call_interrupts
      2258 ± 51%   +2108.3%      49881 ± 13%  interrupts.CPU27.RES:Rescheduling_interrupts
      3947 ± 44%   +5018.0%     202050 ±  6%  interrupts.CPU28.CAL:Function_call_interrupts
      1710 ± 43%   +2800.3%      49618 ± 13%  interrupts.CPU28.RES:Rescheduling_interrupts
      3893 ± 42%   +5058.8%     200875 ±  6%  interrupts.CPU29.CAL:Function_call_interrupts
      1890 ± 44%   +2513.3%      49395 ± 13%  interrupts.CPU29.RES:Rescheduling_interrupts
      4307 ± 52%   +4925.4%     216468 ±  5%  interrupts.CPU3.CAL:Function_call_interrupts
      2522 ± 39%   +1859.2%      49417 ± 12%  interrupts.CPU3.RES:Rescheduling_interrupts
      3946 ± 43%   +5013.8%     201790 ±  6%  interrupts.CPU30.CAL:Function_call_interrupts
      2078 ± 35%   +2280.1%      49473 ± 13%  interrupts.CPU30.RES:Rescheduling_interrupts
      3885 ± 44%   +5113.6%     202558 ±  5%  interrupts.CPU31.CAL:Function_call_interrupts
      2258 ± 37%   +2105.2%      49797 ± 13%  interrupts.CPU31.RES:Rescheduling_interrupts
      3808 ± 43%   +5188.3%     201388 ±  6%  interrupts.CPU32.CAL:Function_call_interrupts
      1944 ± 66%   +2460.9%      49784 ± 13%  interrupts.CPU32.RES:Rescheduling_interrupts
      3868 ± 40%   +5112.1%     201640 ±  6%  interrupts.CPU33.CAL:Function_call_interrupts
      2494 ± 35%   +1890.5%      49659 ± 14%  interrupts.CPU33.RES:Rescheduling_interrupts
      3937 ± 39%   +5056.1%     203021 ±  5%  interrupts.CPU34.CAL:Function_call_interrupts
      3325 ± 90%   +1395.7%      49743 ± 13%  interrupts.CPU34.RES:Rescheduling_interrupts
      3744 ± 41%   +5252.6%     200402 ±  6%  interrupts.CPU35.CAL:Function_call_interrupts
      1950 ± 46%   +2434.8%      49445 ± 13%  interrupts.CPU35.RES:Rescheduling_interrupts
      3819 ± 44%   +5167.9%     201217 ±  6%  interrupts.CPU36.CAL:Function_call_interrupts
      2487 ± 72%   +1886.2%      49398 ± 14%  interrupts.CPU36.RES:Rescheduling_interrupts
      3737 ± 42%   +5268.2%     200611 ±  6%  interrupts.CPU37.CAL:Function_call_interrupts
      2687 ± 51%   +1750.7%      49741 ± 14%  interrupts.CPU37.RES:Rescheduling_interrupts
      3844 ± 43%   +5162.3%     202325 ±  5%  interrupts.CPU38.CAL:Function_call_interrupts
      2550 ± 45%   +1849.5%      49724 ± 14%  interrupts.CPU38.RES:Rescheduling_interrupts
      3830 ± 41%   +5223.4%     203887 ±  6%  interrupts.CPU39.CAL:Function_call_interrupts
      2655 ± 60%   +1764.0%      49505 ± 14%  interrupts.CPU39.RES:Rescheduling_interrupts
      4259 ± 55%   +4997.8%     217159 ±  5%  interrupts.CPU4.CAL:Function_call_interrupts
      2189 ± 56%   +2159.5%      49480 ± 12%  interrupts.CPU4.RES:Rescheduling_interrupts
      3803 ± 41%   +5185.6%     201036 ±  6%  interrupts.CPU40.CAL:Function_call_interrupts
      1761 ± 31%   +2711.3%      49517 ± 14%  interrupts.CPU40.RES:Rescheduling_interrupts
      3911 ± 40%   +5034.2%     200833 ±  6%  interrupts.CPU41.CAL:Function_call_interrupts
      2847 ± 57%   +1629.9%      49259 ± 14%  interrupts.CPU41.RES:Rescheduling_interrupts
      3900 ± 42%   +5056.7%     201139 ±  6%  interrupts.CPU42.CAL:Function_call_interrupts
      2469 ± 58%   +1890.6%      49158 ± 13%  interrupts.CPU42.RES:Rescheduling_interrupts
      3866 ± 43%   +5149.0%     202933 ±  6%  interrupts.CPU43.CAL:Function_call_interrupts
      1781 ± 40%   +2682.9%      49572 ± 14%  interrupts.CPU43.RES:Rescheduling_interrupts
      3939 ± 44%   +5039.8%     202475 ±  6%  interrupts.CPU44.CAL:Function_call_interrupts
      2017 ± 67%   +2366.7%      49756 ± 13%  interrupts.CPU44.RES:Rescheduling_interrupts
      3964 ± 43%   +4940.1%     199824 ±  6%  interrupts.CPU45.CAL:Function_call_interrupts
      1626 ± 34%   +2957.4%      49713 ± 14%  interrupts.CPU45.RES:Rescheduling_interrupts
      3821 ± 43%   +5145.8%     200442 ±  6%  interrupts.CPU46.CAL:Function_call_interrupts
      1665 ± 46%   +2862.3%      49322 ± 13%  interrupts.CPU46.RES:Rescheduling_interrupts
      3889 ± 43%   +4990.6%     197974 ±  6%  interrupts.CPU47.CAL:Function_call_interrupts
      2447 ± 49%   +1914.5%      49300 ± 13%  interrupts.CPU47.RES:Rescheduling_interrupts
      4255 ± 59%   +4642.5%     201810 ±  6%  interrupts.CPU48.CAL:Function_call_interrupts
      2231 ± 40%   +2059.6%      48185 ± 15%  interrupts.CPU48.RES:Rescheduling_interrupts
      4322 ± 59%   +4576.0%     202110 ±  7%  interrupts.CPU49.CAL:Function_call_interrupts
      1896 ± 57%   +2425.7%      47904 ± 16%  interrupts.CPU49.RES:Rescheduling_interrupts
      4200 ± 50%   +5034.7%     215699 ±  5%  interrupts.CPU5.CAL:Function_call_interrupts
      2530 ± 61%   +1837.3%      49027 ± 12%  interrupts.CPU5.RES:Rescheduling_interrupts
      4224 ± 61%   +4714.4%     203377 ±  6%  interrupts.CPU50.CAL:Function_call_interrupts
      2272 ± 53%   +2009.7%      47951 ± 15%  interrupts.CPU50.RES:Rescheduling_interrupts
      4235 ± 58%   +4715.4%     203946 ±  7%  interrupts.CPU51.CAL:Function_call_interrupts
      2536 ± 42%   +1778.4%      47640 ± 16%  interrupts.CPU51.RES:Rescheduling_interrupts
      4161 ± 59%   +4766.0%     202504 ±  7%  interrupts.CPU52.CAL:Function_call_interrupts
      1890 ± 54%   +2429.5%      47816 ± 16%  interrupts.CPU52.RES:Rescheduling_interrupts
      4247 ± 58%   +4673.7%     202779 ±  6%  interrupts.CPU53.CAL:Function_call_interrupts
      2904 ± 50%   +1534.4%      47477 ± 16%  interrupts.CPU53.RES:Rescheduling_interrupts
      4295 ± 57%   +4595.2%     201683 ±  7%  interrupts.CPU54.CAL:Function_call_interrupts
      2110 ± 33%   +2145.2%      47378 ± 16%  interrupts.CPU54.RES:Rescheduling_interrupts
      4146 ± 59%   +4798.4%     203102 ±  7%  interrupts.CPU55.CAL:Function_call_interrupts
      2259 ± 34%   +2003.3%      47517 ± 16%  interrupts.CPU55.RES:Rescheduling_interrupts
      4204 ± 58%   +4734.8%     203285 ±  7%  interrupts.CPU56.CAL:Function_call_interrupts
      2229 ± 58%   +2045.6%      47824 ± 16%  interrupts.CPU56.RES:Rescheduling_interrupts
      4170 ± 59%   +4767.2%     203004 ±  7%  interrupts.CPU57.CAL:Function_call_interrupts
      2084 ± 56%   +2186.6%      47657 ± 16%  interrupts.CPU57.RES:Rescheduling_interrupts
      4210 ± 60%   +4741.1%     203817 ±  6%  interrupts.CPU58.CAL:Function_call_interrupts
      5631 ± 35%     +38.3%       7787 ± 20%  interrupts.CPU58.NMI:Non-maskable_interrupts
      5631 ± 35%     +38.3%       7787 ± 20%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
      1643 ± 46%   +2786.5%      47448 ± 16%  interrupts.CPU58.RES:Rescheduling_interrupts
      4255 ± 60%   +4711.1%     204752 ±  7%  interrupts.CPU59.CAL:Function_call_interrupts
      2161 ± 40%   +2085.4%      47241 ± 16%  interrupts.CPU59.RES:Rescheduling_interrupts
      4298 ± 51%   +4854.5%     212967 ±  7%  interrupts.CPU6.CAL:Function_call_interrupts
      2083 ± 38%   +2209.0%      48096 ± 13%  interrupts.CPU6.RES:Rescheduling_interrupts
      4238 ± 60%   +4670.6%     202218 ±  7%  interrupts.CPU60.CAL:Function_call_interrupts
      2266 ± 52%   +1999.6%      47595 ± 16%  interrupts.CPU60.RES:Rescheduling_interrupts
      4256 ± 61%   +4655.9%     202443 ±  7%  interrupts.CPU61.CAL:Function_call_interrupts
      2921 ± 43%   +1539.0%      47874 ± 15%  interrupts.CPU61.RES:Rescheduling_interrupts
      4284 ± 60%   +4646.8%     203361 ±  7%  interrupts.CPU62.CAL:Function_call_interrupts
      2737 ± 56%   +1631.0%      47383 ± 16%  interrupts.CPU62.RES:Rescheduling_interrupts
      4266 ± 58%   +4641.7%     202303 ±  7%  interrupts.CPU63.CAL:Function_call_interrupts
      2016 ± 52%   +2262.9%      47655 ± 16%  interrupts.CPU63.RES:Rescheduling_interrupts
      4453 ± 60%   +4479.7%     203941 ±  6%  interrupts.CPU64.CAL:Function_call_interrupts
      2809 ± 26%   +1602.9%      47843 ± 15%  interrupts.CPU64.RES:Rescheduling_interrupts
      4299 ± 59%   +4620.0%     202913 ±  6%  interrupts.CPU65.CAL:Function_call_interrupts
      2187 ± 32%   +2057.8%      47208 ± 16%  interrupts.CPU65.RES:Rescheduling_interrupts
      4406 ± 57%   +4493.2%     202378 ±  7%  interrupts.CPU66.CAL:Function_call_interrupts
      2637 ± 42%   +1706.3%      47633 ± 15%  interrupts.CPU66.RES:Rescheduling_interrupts
      4397 ± 56%   +4546.7%     204353 ±  7%  interrupts.CPU67.CAL:Function_call_interrupts
      3138 ± 36%   +1419.8%      47699 ± 16%  interrupts.CPU67.RES:Rescheduling_interrupts
      4261 ± 60%   +4641.1%     202035 ±  7%  interrupts.CPU68.CAL:Function_call_interrupts
      1874 ± 50%   +2436.6%      47549 ± 16%  interrupts.CPU68.RES:Rescheduling_interrupts
      4159 ± 58%   +4755.4%     201944 ±  6%  interrupts.CPU69.CAL:Function_call_interrupts
      3127 ± 29%   +1417.0%      47441 ± 16%  interrupts.CPU69.RES:Rescheduling_interrupts
      4232 ± 53%   +4973.7%     214759 ±  5%  interrupts.CPU7.CAL:Function_call_interrupts
      2427 ± 54%   +1932.2%      49331 ± 12%  interrupts.CPU7.RES:Rescheduling_interrupts
      4317 ± 58%   +4589.3%     202460 ±  7%  interrupts.CPU70.CAL:Function_call_interrupts
      2882 ± 68%   +1544.4%      47402 ± 16%  interrupts.CPU70.RES:Rescheduling_interrupts
      4206 ± 57%   +4690.5%     201521 ±  6%  interrupts.CPU71.CAL:Function_call_interrupts
      2059 ± 31%   +2192.6%      47220 ± 16%  interrupts.CPU71.RES:Rescheduling_interrupts
      5897 ± 49%   +3199.1%     194573 ±  4%  interrupts.CPU72.CAL:Function_call_interrupts
      3160 ± 35%   +1487.7%      50174 ± 10%  interrupts.CPU72.RES:Rescheduling_interrupts
      6303 ± 43%   +2959.1%     192823 ±  6%  interrupts.CPU73.CAL:Function_call_interrupts
      2707 ± 29%   +1706.9%      48916 ±  9%  interrupts.CPU73.RES:Rescheduling_interrupts
      6229 ± 42%   +3036.2%     195381 ±  4%  interrupts.CPU74.CAL:Function_call_interrupts
      2958 ± 29%   +1588.0%      49930 ± 10%  interrupts.CPU74.RES:Rescheduling_interrupts
      6316 ± 43%   +3028.5%     197612 ±  4%  interrupts.CPU75.CAL:Function_call_interrupts
      2711 ± 39%   +1734.6%      49734 ± 10%  interrupts.CPU75.RES:Rescheduling_interrupts
      6326 ± 44%   +2977.5%     194700 ±  4%  interrupts.CPU76.CAL:Function_call_interrupts
      3461 ± 25%   +1337.3%      49756 ± 10%  interrupts.CPU76.RES:Rescheduling_interrupts
      6321 ± 42%   +2973.2%     194282 ±  5%  interrupts.CPU77.CAL:Function_call_interrupts
      2726 ± 41%   +1714.9%      49482 ± 10%  interrupts.CPU77.RES:Rescheduling_interrupts
      6242 ± 43%   +3038.1%     195890 ±  5%  interrupts.CPU78.CAL:Function_call_interrupts
      2930 ± 47%   +1581.9%      49282 ± 10%  interrupts.CPU78.RES:Rescheduling_interrupts
      6299 ± 43%   +3005.7%     195630 ±  4%  interrupts.CPU79.CAL:Function_call_interrupts
      3306 ± 53%   +1401.3%      49644 ± 10%  interrupts.CPU79.RES:Rescheduling_interrupts
      4346 ± 49%   +4862.7%     215685 ±  5%  interrupts.CPU8.CAL:Function_call_interrupts
      2393 ± 32%   +1960.5%      49315 ± 12%  interrupts.CPU8.RES:Rescheduling_interrupts
      6357 ± 43%   +2978.7%     195728 ±  4%  interrupts.CPU80.CAL:Function_call_interrupts
      2917 ± 34%   +1602.5%      49665 ± 10%  interrupts.CPU80.RES:Rescheduling_interrupts
      6358 ± 43%   +2984.8%     196154 ±  4%  interrupts.CPU81.CAL:Function_call_interrupts
      3319 ± 29%   +1395.8%      49646 ± 10%  interrupts.CPU81.RES:Rescheduling_interrupts
      6258 ± 43%   +3019.1%     195203 ±  5%  interrupts.CPU82.CAL:Function_call_interrupts
      3142 ± 46%   +1478.9%      49612 ± 10%  interrupts.CPU82.RES:Rescheduling_interrupts
      6443 ± 44%   +2958.3%     197053 ±  4%  interrupts.CPU83.CAL:Function_call_interrupts
      2678 ± 51%   +1743.7%      49387 ± 10%  interrupts.CPU83.RES:Rescheduling_interrupts
      6273 ± 44%   +3004.0%     194737 ±  4%  interrupts.CPU84.CAL:Function_call_interrupts
      3205 ± 57%   +1448.1%      49625 ± 10%  interrupts.CPU84.RES:Rescheduling_interrupts
      6345 ± 44%   +2861.5%     187923 ±  9%  interrupts.CPU85.CAL:Function_call_interrupts
      2984 ± 48%   +1497.8%      47681 ± 14%  interrupts.CPU85.RES:Rescheduling_interrupts
      6227 ± 43%   +3050.2%     196160 ±  4%  interrupts.CPU86.CAL:Function_call_interrupts
      3442 ± 24%   +1342.2%      49643 ± 10%  interrupts.CPU86.RES:Rescheduling_interrupts
      6385 ± 44%   +2944.4%     194389 ±  4%  interrupts.CPU87.CAL:Function_call_interrupts
      3299 ± 36%   +1396.9%      49387 ± 10%  interrupts.CPU87.RES:Rescheduling_interrupts
      6432 ± 43%   +2969.7%     197465 ±  5%  interrupts.CPU88.CAL:Function_call_interrupts
      3578 ± 43%   +1284.0%      49527 ± 10%  interrupts.CPU88.RES:Rescheduling_interrupts
      6263 ± 44%   +3012.8%     194967 ±  4%  interrupts.CPU89.CAL:Function_call_interrupts
      2479 ± 49%   +1895.0%      49465 ± 10%  interrupts.CPU89.RES:Rescheduling_interrupts
      4242 ± 51%   +4946.7%     214099 ±  5%  interrupts.CPU9.CAL:Function_call_interrupts
      2584 ± 36%   +1814.6%      49484 ± 12%  interrupts.CPU9.RES:Rescheduling_interrupts
      6479 ± 43%   +2884.4%     193363 ±  4%  interrupts.CPU90.CAL:Function_call_interrupts
      3014 ± 44%   +1542.1%      49491 ± 10%  interrupts.CPU90.RES:Rescheduling_interrupts
      6406 ± 44%   +2968.7%     196586 ±  4%  interrupts.CPU91.CAL:Function_call_interrupts
      3035 ± 49%   +1534.7%      49614 ± 10%  interrupts.CPU91.RES:Rescheduling_interrupts
      6361 ± 43%   +2980.5%     195973 ±  5%  interrupts.CPU92.CAL:Function_call_interrupts
      2818 ± 42%   +1661.2%      49641 ± 10%  interrupts.CPU92.RES:Rescheduling_interrupts
      6369 ± 43%   +2947.5%     194095 ±  4%  interrupts.CPU93.CAL:Function_call_interrupts
      3916 ± 38%   +1164.0%      49499 ± 10%  interrupts.CPU93.RES:Rescheduling_interrupts
      6457 ± 44%   +2927.1%     195472 ±  4%  interrupts.CPU94.CAL:Function_call_interrupts
      2911 ± 33%   +1597.4%      49424 ± 10%  interrupts.CPU94.RES:Rescheduling_interrupts
      6452 ± 44%   +2898.0%     193430 ±  4%  interrupts.CPU95.CAL:Function_call_interrupts
      2949 ± 36%   +1567.0%      49161 ± 10%  interrupts.CPU95.RES:Rescheduling_interrupts
      4536 ± 58%   +4436.2%     205770 ±  5%  interrupts.CPU96.CAL:Function_call_interrupts
      3100 ± 52%   +1387.5%      46115 ± 15%  interrupts.CPU96.RES:Rescheduling_interrupts
      4475 ± 55%   +4697.3%     214709 ±  6%  interrupts.CPU97.CAL:Function_call_interrupts
      1921 ± 39%   +2399.4%      48013 ± 13%  interrupts.CPU97.RES:Rescheduling_interrupts
      4606 ± 55%   +4454.2%     209780 ±  8%  interrupts.CPU98.CAL:Function_call_interrupts
      2177 ± 41%   +2049.1%      46800 ± 18%  interrupts.CPU98.RES:Rescheduling_interrupts
      4457 ± 55%   +4744.4%     215945 ±  5%  interrupts.CPU99.CAL:Function_call_interrupts
      2576 ± 37%   +1767.7%      48126 ± 12%  interrupts.CPU99.RES:Rescheduling_interrupts
      2949 ± 14%    +213.1%       9236        interrupts.IWI:IRQ_work_interrupts
    471799 ± 22%   +1865.5%    9273438 ± 11%  interrupts.RES:Rescheduling_interrupts
     96.09           -18.5       77.54        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     87.16           -10.5       76.63        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     64.87            -8.9       55.99        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     64.62            -8.7       55.94        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     63.28            -7.7       55.54        perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.03            -7.3        0.76        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      7.45            -7.2        0.26 ±100%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
     62.18            -6.8       55.34        perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     60.69            -5.7       55.03        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      7.35            -5.3        2.00        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      5.15            -5.2        0.00        perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      5.38 ±  2%      -4.2        1.18        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb
      4.58            -3.1        1.43        perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      3.57            -2.7        0.83        perf-profile.calltrace.cycles-pp.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      3.19            -2.4        0.79        perf-profile.calltrace.cycles-pp.__alloc_skb.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      2.93 ±  5%      -2.2        0.73 ±  2%  perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit
      2.67            -1.9        0.75        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      2.51 ±  6%      -1.9        0.63 ±  2%  perf-profile.calltrace.cycles-pp.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_output
      2.54            -1.8        0.74        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      2.60 ±  2%      -1.7        0.87        perf-profile.calltrace.cycles-pp.__kfree_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      2.35 ±  2%      -1.6        0.77        perf-profile.calltrace.cycles-pp.skb_release_all.__kfree_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      2.28 ±  2%      -1.6        0.72 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_head_state.skb_release_all.__kfree_skb.tcp_recvmsg_locked.tcp_recvmsg
     21.76            -1.3       20.51        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.48            -1.0       20.46        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.28 ±  2%      -0.6        0.68        perf-profile.calltrace.cycles-pp.__kfree_skb.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv
      1.24            -0.5        0.69        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.wait_woken
      1.75            +0.1        1.88 ±  2%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable
     19.43            +0.4       19.87        perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule_idle.do_idle
      0.00            +0.6        0.60        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.00            +0.7        0.68        perf-profile.calltrace.cycles-pp.available_idle_cpu.select_idle_sibling.select_task_rq_fair.try_to_wake_up.__wake_up_common
     18.12            +1.4       19.57        perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      0.00            +1.5        1.45 ±  2%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.try_to_wake_up.__wake_up_common.__wake_up_common_lock
     50.97            +1.5       52.49        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
     50.63            +1.8       52.45        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      0.00            +2.4        2.38        perf-profile.calltrace.cycles-pp.update_cfs_group.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      0.00            +2.7        2.66        perf-profile.calltrace.cycles-pp.update_cfs_group.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.35 ± 70%      +3.9        4.20        perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.00            +4.1        4.07        perf-profile.calltrace.cycles-pp.update_cfs_group.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__wake_up_common
      0.00            +4.2        4.18        perf-profile.calltrace.cycles-pp.update_cfs_group.dequeue_task_fair.__schedule.schedule.schedule_timeout
     47.09            +4.7       51.79        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
      0.44 ± 44%      +5.5        5.91        perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      1.59            +5.8        7.36        perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
     10.49            +6.4       16.92        perf-profile.calltrace.cycles-pp.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      0.00            +6.6        6.60        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__schedule.schedule_idle.do_idle
      0.00            +6.7        6.66        perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.00            +6.8        6.80        perf-profile.calltrace.cycles-pp.set_task_cpu.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable
      1.95            +6.9        8.83        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__wake_up_common
      8.86            +7.0       15.86        perf-profile.calltrace.cycles-pp.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      8.45            +7.1       15.50        perf-profile.calltrace.cycles-pp.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      8.21            +7.2       15.38        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      7.95            +7.3       15.21        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.wait_woken.sk_wait_data
     42.82            +7.9       50.74        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
      0.00            +8.2        8.22        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00            +8.2        8.24        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.24 ±  2%      +8.7       11.97        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.wait_woken
      3.64            +9.7       13.38        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable
      3.56            +9.8       13.35        perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_common_lock
     40.32           +10.0       50.33        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
      0.00           +11.8       11.78        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     38.07           +11.9       49.97        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
      0.00           +12.3       12.28        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      0.00           +12.3       12.29        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     31.75           +16.9       48.60        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb
     31.43           +17.1       48.56        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit
      0.00           +17.5       17.49        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wake_up.__wake_up_common.__wake_up_common_lock
     30.92           +17.5       48.45        perf-profile.calltrace.cycles-pp.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output
      0.00           +17.7       17.71        perf-profile.calltrace.cycles-pp._raw_spin_lock.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable
     29.41           +18.6       48.06        perf-profile.calltrace.cycles-pp.net_rx_action.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_finish_output2
     28.60           +19.3       47.92        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__softirqentry_text_start.do_softirq.__local_bh_enable_ip
     28.40           +19.4       47.85        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__softirqentry_text_start.do_softirq
     27.30           +20.4       47.65        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__softirqentry_text_start
      0.00           +21.4       21.36        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00           +21.4       21.38        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00           +21.4       21.38        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     25.94           +21.5       47.45        perf-profile.calltrace.cycles-pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      0.00           +21.5       21.50        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     24.16           +23.0       47.18        perf-profile.calltrace.cycles-pp.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog.__napi_poll
     23.96           +23.2       47.16        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog
     23.82           +23.3       47.14        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core
     23.39           +23.7       47.07        perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv
     19.51           +26.1       45.65        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
     18.96           +26.6       45.57        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      7.91           +33.9       41.80        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv
      8.63           +34.0       42.61        perf-profile.calltrace.cycles-pp.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      7.61           +34.0       41.64        perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_rcv_established
      8.21           +34.2       42.41        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
     96.13           -18.5       77.59        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     87.19           -10.5       76.67        perf-profile.children.cycles-pp.do_syscall_64
     64.91            -8.9       56.00        perf-profile.children.cycles-pp.__x64_sys_sendto
     64.64            -8.7       55.95        perf-profile.children.cycles-pp.__sys_sendto
     63.32            -7.8       55.54        perf-profile.children.cycles-pp.sock_sendmsg
      8.07            -7.3        0.76        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      7.55            -7.0        0.52 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
     62.25            -6.9       55.35        perf-profile.children.cycles-pp.tcp_sendmsg
     60.76            -5.7       55.04        perf-profile.children.cycles-pp.tcp_sendmsg_locked
      7.45            -5.4        2.02        perf-profile.children.cycles-pp.tcp_ack
      5.39 ±  2%      -4.2        1.18        perf-profile.children.cycles-pp.__dev_queue_xmit
      4.67            -3.2        1.44        perf-profile.children.cycles-pp.tcp_clean_rtx_queue
      3.58            -2.7        0.84        perf-profile.children.cycles-pp.sk_stream_alloc_skb
      3.24            -2.4        0.80        perf-profile.children.cycles-pp.__alloc_skb
      3.89 ±  2%      -2.3        1.55        perf-profile.children.cycles-pp.__kfree_skb
      2.94 ±  5%      -2.2        0.73 ±  2%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      3.38            -2.1        1.32        perf-profile.children.cycles-pp.pick_next_task_fair
      2.68            -1.9        0.75        perf-profile.children.cycles-pp.skb_copy_datagram_iter
      2.52 ±  6%      -1.9        0.63 ±  2%  perf-profile.children.cycles-pp.loopback_xmit
      2.50            -1.9        0.62 ±  2%  perf-profile.children.cycles-pp.update_curr
      2.56            -1.8        0.74        perf-profile.children.cycles-pp.__skb_datagram_iter
      2.31            -1.8        0.55        perf-profile.children.cycles-pp.switch_mm_irqs_off
      2.57 ±  2%      -1.7        0.84        perf-profile.children.cycles-pp.skb_release_all
      2.48 ±  2%      -1.7        0.81        perf-profile.children.cycles-pp.skb_release_head_state
      1.89 ±  3%      -1.4        0.48        perf-profile.children.cycles-pp.dst_release
      1.81 ±  2%      -1.4        0.42 ±  4%  perf-profile.children.cycles-pp.ktime_get
      1.57            -1.4        0.21 ±  3%  perf-profile.children.cycles-pp.load_new_mm_cr3
      1.48 ±  4%      -1.3        0.19 ±  3%  perf-profile.children.cycles-pp.tcp_send_mss
     21.79            -1.3       20.51        perf-profile.children.cycles-pp.__x64_sys_recvfrom
      1.62            -1.2        0.40 ±  3%  perf-profile.children.cycles-pp.switch_fpu_return
      1.37 ±  5%      -1.2        0.17 ±  3%  perf-profile.children.cycles-pp.tcp_current_mss
      1.44            -1.1        0.34 ±  2%  perf-profile.children.cycles-pp.__cgroup_bpf_run_filter_skb
     21.51            -1.0       20.47        perf-profile.children.cycles-pp.__sys_recvfrom
      1.25            -1.0        0.23 ±  2%  perf-profile.children.cycles-pp.tcp_mstamp_refresh
      1.24            -1.0        0.22 ±  3%  perf-profile.children.cycles-pp.sk_filter_trim_cap
      1.21 ± 14%      -1.0        0.20 ±  3%  perf-profile.children.cycles-pp.netif_rx
      1.16 ± 14%      -1.0        0.19 ±  4%  perf-profile.children.cycles-pp.netif_rx_internal
      1.11 ±  7%      -1.0        0.14 ±  4%  perf-profile.children.cycles-pp.ip_rcv_finish
      1.22 ±  2%      -1.0        0.26 ±  2%  perf-profile.children.cycles-pp.kmalloc_reserve
      1.58            -1.0        0.62        perf-profile.children.cycles-pp.lock_sock_nested
      1.21 ±  2%      -0.9        0.30        perf-profile.children.cycles-pp.reweight_entity
      0.97 ±  7%      -0.9        0.07 ±  5%  perf-profile.children.cycles-pp.__sk_dst_check
      1.13            -0.9        0.24 ±  2%  perf-profile.children.cycles-pp.sched_clock_cpu
      1.20            -0.9        0.30        perf-profile.children.cycles-pp._copy_to_iter
      1.01            -0.9        0.14 ±  3%  perf-profile.children.cycles-pp.tcp_schedule_loss_probe
      0.93 ±  8%      -0.8        0.10 ±  5%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.97 ± 10%      -0.8        0.15 ±  3%  perf-profile.children.cycles-pp.__netif_receive_skb_core
      1.04 ±  3%      -0.8        0.22        perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      1.15            -0.8        0.34 ±  2%  perf-profile.children.cycles-pp.release_sock
      1.11            -0.8        0.33        perf-profile.children.cycles-pp.__check_object_size
      1.22            -0.8        0.46        perf-profile.children.cycles-pp.sockfd_lookup_light
      1.03 ±  2%      -0.8        0.27 ±  7%  perf-profile.children.cycles-pp._copy_from_iter_full
      0.93            -0.8        0.18 ±  4%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.92 ± 10%      -0.7        0.18 ±  2%  perf-profile.children.cycles-pp.read_tsc
      0.95            -0.7        0.20 ±  2%  perf-profile.children.cycles-pp.sched_clock
      0.89            -0.7        0.15 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.82 ± 12%      -0.7        0.09 ±  6%  perf-profile.children.cycles-pp.ipv4_dst_check
      0.80 ± 10%      -0.7        0.07 ± 11%  perf-profile.children.cycles-pp.ipv4_mtu
      1.33            -0.7        0.60        perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.91            -0.7        0.19 ±  3%  perf-profile.children.cycles-pp.native_sched_clock
      0.96 ±  2%      -0.7        0.26 ±  3%  perf-profile.children.cycles-pp.tcp_event_new_data_sent
      1.11            -0.7        0.42 ±  3%  perf-profile.children.cycles-pp.__switch_to_asm
      0.78            -0.7        0.10        perf-profile.children.cycles-pp.pick_next_entity
      0.80            -0.7        0.14 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.81            -0.7        0.15 ±  3%  perf-profile.children.cycles-pp.___might_sleep
      0.72            -0.6        0.08 ±  4%  perf-profile.children.cycles-pp.copy_fpregs_to_fpstate
      0.75            -0.6        0.12 ±  3%  perf-profile.children.cycles-pp.__might_sleep
      0.78 ±  2%      -0.6        0.17 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.82            -0.6        0.23        perf-profile.children.cycles-pp.ip_finish_output
      0.92 ±  2%      -0.6        0.34 ±  2%  perf-profile.children.cycles-pp.__fget_light
      0.77            -0.6        0.21 ±  2%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.58 ±  4%      -0.6        0.03 ± 99%  perf-profile.children.cycles-pp.__might_fault
      0.76            -0.5        0.23        perf-profile.children.cycles-pp.simple_copy_to_iter
      0.72            -0.5        0.20        perf-profile.children.cycles-pp.validate_xmit_skb
      0.60 ±  3%      -0.5        0.08        perf-profile.children.cycles-pp.tcp_ack_update_rtt
      0.65 ±  3%      -0.5        0.13 ±  3%  perf-profile.children.cycles-pp.enqueue_to_backlog
      0.83 ±  2%      -0.5        0.31 ±  2%  perf-profile.children.cycles-pp.aa_sk_perm
      0.71            -0.5        0.20        perf-profile.children.cycles-pp.check_preempt_curr
      0.73            -0.5        0.23 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.90 ±  2%      -0.5        0.41 ±  2%  perf-profile.children.cycles-pp.__inet_lookup_established
      0.77 ±  2%      -0.5        0.29        perf-profile.children.cycles-pp.tcp_rcv_space_adjust
      0.77            -0.5        0.28        perf-profile.children.cycles-pp.__switch_to
      0.61 ±  4%      -0.5        0.12 ±  3%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.54 ±  3%      -0.5        0.07 ±  6%  perf-profile.children.cycles-pp.__calc_delta
      0.53            -0.4        0.10 ±  3%  perf-profile.children.cycles-pp.ip_local_out
      0.53 ±  2%      -0.4        0.11 ±  3%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.82            -0.4        0.41        perf-profile.children.cycles-pp.skb_release_data
      0.58            -0.4        0.17 ±  5%  perf-profile.children.cycles-pp.__ksize
      0.55 ±  2%      -0.4        0.16 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      0.66 ±  2%      -0.4        0.29 ±  2%  perf-profile.children.cycles-pp.sk_reset_timer
      0.45            -0.4        0.08        perf-profile.children.cycles-pp.ip_rcv_core
      0.46            -0.4        0.09 ±  5%  perf-profile.children.cycles-pp.__ip_local_out
      0.45 ±  3%      -0.3        0.11 ±  4%  perf-profile.children.cycles-pp.kfree
      0.40            -0.3        0.07 ±  5%  perf-profile.children.cycles-pp.__entry_text_start
      0.48 ±  5%      -0.3        0.15 ±  5%  perf-profile.children.cycles-pp.copyin
      0.39            -0.3        0.06 ±  6%  perf-profile.children.cycles-pp.tcp_update_pacing_rate
      0.40            -0.3        0.08 ±  6%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.41 ±  2%      -0.3        0.08 ±  4%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.68            -0.3        0.36        perf-profile.children.cycles-pp.__skb_clone
      0.56            -0.3        0.24 ±  2%  perf-profile.children.cycles-pp.sock_recvmsg
      0.41 ±  2%      -0.3        0.10 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.53 ±  2%      -0.3        0.23 ±  3%  perf-profile.children.cycles-pp.skb_entail
      0.52            -0.3        0.23 ±  2%  perf-profile.children.cycles-pp.copyout
      0.51            -0.3        0.23 ±  2%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.53 ±  2%      -0.3        0.27 ±  3%  perf-profile.children.cycles-pp.mod_timer
      0.35 ±  3%      -0.3        0.09 ±  4%  perf-profile.children.cycles-pp.cpuacct_charge
      0.50            -0.3        0.23 ±  3%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
      0.33 ±  4%      -0.3        0.07        perf-profile.children.cycles-pp.migrate_enable
      0.49            -0.3        0.24 ±  3%  perf-profile.children.cycles-pp.tcp_wfree
      0.35 ±  5%      -0.2        0.10 ±  3%  perf-profile.children.cycles-pp.tcp_rearm_rto
      0.39 ±  4%      -0.2        0.15 ±  3%  perf-profile.children.cycles-pp.cpumask_next_wrap
      0.30            -0.2        0.07 ±  7%  perf-profile.children.cycles-pp.migrate_disable
      0.31            -0.2        0.08 ±  4%  perf-profile.children.cycles-pp.import_single_range
      0.34 ±  2%      -0.2        0.11 ±  3%  perf-profile.children.cycles-pp.update_min_vruntime
      0.30 ±  2%      -0.2        0.07 ±  7%  perf-profile.children.cycles-pp.tcp_update_skb_after_send
      0.28 ±  2%      -0.2        0.05 ±  7%  perf-profile.children.cycles-pp.skb_clone
      0.27 ±  2%      -0.2        0.05 ±  7%  perf-profile.children.cycles-pp.security_sock_rcv_skb
      0.27            -0.2        0.06        perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.53            -0.2        0.32 ±  3%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.26            -0.2        0.06        perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.31 ±  3%      -0.2        0.11 ±  5%  perf-profile.children.cycles-pp.netif_skb_features
      0.26 ±  2%      -0.2        0.06        perf-profile.children.cycles-pp.__tcp_select_window
      0.25 ±  2%      -0.2        0.05 ±  9%  perf-profile.children.cycles-pp.tcp_established_options
      0.30 ±  2%      -0.2        0.11 ±  3%  perf-profile.children.cycles-pp.tcp_event_data_recv
      0.37            -0.2        0.18 ±  2%  perf-profile.children.cycles-pp.tcp_queue_rcv
      0.23            -0.2        0.05        perf-profile.children.cycles-pp.bictcp_cwnd_event
      0.23 ±  2%      -0.2        0.06 ±  9%  perf-profile.children.cycles-pp.tcp_v4_fill_cb
      0.23 ±  2%      -0.2        0.05        perf-profile.children.cycles-pp.rb_insert_color
      0.27            -0.2        0.09 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.25            -0.2        0.08 ±  4%  perf-profile.children.cycles-pp.ip_send_check
      0.25 ±  3%      -0.2        0.08 ±  6%  perf-profile.children.cycles-pp.tcp_release_cb
      0.23 ±  2%      -0.2        0.06 ±  6%  perf-profile.children.cycles-pp.rcu_all_qs
      0.20 ±  7%      -0.2        0.05 ± 45%  perf-profile.children.cycles-pp.clockevents_program_event
      0.26            -0.2        0.11 ±  3%  perf-profile.children.cycles-pp.__copy_skb_header
      0.27            -0.2        0.12 ±  3%  perf-profile.children.cycles-pp.__enqueue_entity
      0.32 ±  3%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.sock_rfree
      0.59            -0.1        0.45 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
      0.40 ±  5%      -0.1        0.26 ±  2%  perf-profile.children.cycles-pp.sk_page_frag_refill
      0.23            -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.tcp_check_space
      0.27 ±  2%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.perf_tp_event
      0.19 ±  3%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.rb_next
      0.19 ±  5%      -0.1        0.06        perf-profile.children.cycles-pp.tcp_v4_inbound_md5_hash
      0.18 ±  3%      -0.1        0.06        perf-profile.children.cycles-pp.tcp_options_write
      0.20            -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.__build_skb_around
      0.27 ±  2%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.add_wait_queue
      0.27 ±  2%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp._find_next_bit
      0.15 ±  3%      -0.1        0.05 ±  9%  perf-profile.children.cycles-pp.__list_add_valid
      0.13 ±  2%      -0.1        0.05        perf-profile.children.cycles-pp.update_irq_load_avg
      0.15 ±  6%      -0.1        0.07        perf-profile.children.cycles-pp.sk_free
      0.21 ±  5%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.kfree_skbmem
      0.14 ±  2%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.woken_wake_function
      0.28 ±  7%      -0.1        0.21 ±  2%  perf-profile.children.cycles-pp.skb_page_frag_refill
      0.29 ±  5%      -0.1        0.23 ±  3%  perf-profile.children.cycles-pp.tcp_cleanup_rbuf
      0.33 ±  2%      -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      0.11            -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.tcp_rate_check_app_limited
      0.08 ± 17%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.cpus_share_cache
      0.10 ±  3%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.rb_first
      0.10 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__fdget
      0.25            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.remove_wait_queue
      0.08 ±  4%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.23 ±  2%      +0.0        0.26 ±  2%  perf-profile.children.cycles-pp.sock_put
      0.00            +0.0        0.05        perf-profile.children.cycles-pp.get_xsave_addr
      0.00            +0.0        0.05        perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__update_idle_core
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.set_next_task_idle
      0.00            +0.1        0.07 ±  8%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.00            +0.1        0.08 ± 36%  perf-profile.children.cycles-pp.poll_idle
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.attach_task
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.activate_task
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.attach_entity_load_avg
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.lock_timer_base
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.__task_rq_lock
      0.00            +0.1        0.11        perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.cpumask_next
      0.00            +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.start_kernel
      1.76            +0.1        1.88 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +0.2        0.16        perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +0.2        0.17 ±  3%  perf-profile.children.cycles-pp.remove_entity_load_avg
      0.00            +0.2        0.22        perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.24 ±  3%      +0.3        0.49 ±  6%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.66 ±  2%      +0.3        0.94 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.66 ±  3%      +0.3        0.94 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.59            +0.3        0.88        perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.3        0.29 ±  3%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.3        0.30 ±  7%  perf-profile.children.cycles-pp.load_balance
      0.00            +0.3        0.30 ±  3%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.00            +0.3        0.31 ±  3%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.00            +0.3        0.33 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.3        0.33 ±  4%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +0.3        0.34 ±  2%  perf-profile.children.cycles-pp.__slab_free
      0.00            +0.4        0.35        perf-profile.children.cycles-pp.migrate_task_rq_fair
      0.00            +0.4        0.37 ±  2%  perf-profile.children.cycles-pp.menu_select
      0.64            +0.4        1.01        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.08 ±  8%      +0.4        0.47 ±  3%  perf-profile.children.cycles-pp.task_tick_fair
     19.47            +0.4       19.88        perf-profile.children.cycles-pp.tcp_recvmsg
      0.00            +0.4        0.41 ±  4%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.29 ±  6%      +0.4        0.74 ±  4%  perf-profile.children.cycles-pp.tick_sched_timer
      0.35 ±  5%      +0.5        0.82 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.20 ±  6%      +0.5        0.72 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.20 ±  6%      +0.5        0.72 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.13 ±  7%      +0.5        0.67 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
      0.71 ±  2%      +0.7        1.37 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.76 ±  2%      +0.7        1.46 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.07 ±  8%      +0.7        0.78 ±  2%  perf-profile.children.cycles-pp.available_idle_cpu
     18.17            +1.4       19.58        perf-profile.children.cycles-pp.tcp_recvmsg_locked
      0.00            +1.5        1.47 ±  2%  perf-profile.children.cycles-pp.select_idle_sibling
     50.99            +1.5       52.49        perf-profile.children.cycles-pp.__tcp_push_pending_frames
     50.71            +1.7       52.46        perf-profile.children.cycles-pp.tcp_write_xmit
     13.38            +2.0       15.39        perf-profile.children.cycles-pp.schedule
     47.16            +4.6       51.80        perf-profile.children.cycles-pp.__tcp_transmit_skb
      1.63            +5.8        7.38        perf-profile.children.cycles-pp.dequeue_entity
     10.50            +6.4       16.92        perf-profile.children.cycles-pp.sk_wait_data
      0.00            +6.9        6.89        perf-profile.children.cycles-pp.set_task_cpu
      8.86            +7.0       15.86        perf-profile.children.cycles-pp.wait_woken
      8.46            +7.0       15.51        perf-profile.children.cycles-pp.schedule_timeout
      2.00            +7.1        9.12        perf-profile.children.cycles-pp.enqueue_entity
     42.89            +7.9       50.74        perf-profile.children.cycles-pp.__ip_queue_xmit
      0.00            +8.3        8.28        perf-profile.children.cycles-pp.schedule_idle
      3.25 ±  2%      +8.8       12.02        perf-profile.children.cycles-pp.dequeue_task_fair
      2.58            +8.9       11.44        perf-profile.children.cycles-pp.update_load_avg
     40.37           +10.0       50.34        perf-profile.children.cycles-pp.ip_output
      3.64           +10.0       13.65        perf-profile.children.cycles-pp.ttwu_do_activate
      3.57           +10.1       13.71        perf-profile.children.cycles-pp.enqueue_task_fair
     12.98           +10.5       23.50        perf-profile.children.cycles-pp.__schedule
      0.00           +11.8       11.85        perf-profile.children.cycles-pp.intel_idle
     38.10           +11.9       49.98        perf-profile.children.cycles-pp.ip_finish_output2
      0.00           +12.4       12.36        perf-profile.children.cycles-pp.cpuidle_enter_state
      0.00           +12.4       12.36        perf-profile.children.cycles-pp.cpuidle_enter
      0.62 ±  2%     +13.3       13.87        perf-profile.children.cycles-pp.update_cfs_group
     32.14           +16.5       48.66        perf-profile.children.cycles-pp.__local_bh_enable_ip
     31.46           +17.1       48.57        perf-profile.children.cycles-pp.do_softirq
     30.97           +17.9       48.85        perf-profile.children.cycles-pp.__softirqentry_text_start
     29.45           +18.6       48.07        perf-profile.children.cycles-pp.net_rx_action
     28.61           +19.3       47.93        perf-profile.children.cycles-pp.__napi_poll
     28.43           +19.4       47.86        perf-profile.children.cycles-pp.process_backlog
     27.33           +20.3       47.66        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      0.00           +21.4       21.38        perf-profile.children.cycles-pp.start_secondary
     25.98           +21.5       47.45        perf-profile.children.cycles-pp.ip_rcv
      0.00           +21.5       21.50        perf-profile.children.cycles-pp.do_idle
      0.00           +21.5       21.50        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.00           +21.5       21.50        perf-profile.children.cycles-pp.cpu_startup_entry
     24.18           +23.0       47.18        perf-profile.children.cycles-pp.ip_local_deliver
     23.98           +23.2       47.16        perf-profile.children.cycles-pp.ip_local_deliver_finish
     23.84           +23.3       47.15        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     23.44           +23.6       47.07        perf-profile.children.cycles-pp.tcp_v4_rcv
      1.15 ±  2%     +24.8       25.94        perf-profile.children.cycles-pp._raw_spin_lock
      0.00           +24.8       24.83        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     19.53           +26.1       45.66        perf-profile.children.cycles-pp.tcp_v4_do_rcv
     19.01           +26.6       45.58        perf-profile.children.cycles-pp.tcp_rcv_established
      7.91           +33.9       41.81        perf-profile.children.cycles-pp.__wake_up_common
      8.64           +34.0       42.61        perf-profile.children.cycles-pp.sock_def_readable
      7.62           +34.0       41.65        perf-profile.children.cycles-pp.try_to_wake_up
      8.21           +34.2       42.42        perf-profile.children.cycles-pp.__wake_up_common_lock
      1.86 ±  3%      -1.4        0.45 ±  2%  perf-profile.self.cycles-pp.dst_release
      1.99            -1.4        0.58        perf-profile.self.cycles-pp.tcp_sendmsg_locked
      1.57            -1.4        0.21 ±  3%  perf-profile.self.cycles-pp.load_new_mm_cr3
      1.67            -1.3        0.34 ±  2%  perf-profile.self.cycles-pp.__tcp_transmit_skb
      1.49 ±  4%      -1.3        0.21 ±  4%  perf-profile.self.cycles-pp.__dev_queue_xmit
      1.50            -1.3        0.23 ±  3%  perf-profile.self.cycles-pp.tcp_clean_rtx_queue
      1.55            -1.2        0.39 ±  3%  perf-profile.self.cycles-pp.switch_fpu_return
      1.39            -1.0        0.36 ±  2%  perf-profile.self.cycles-pp.tcp_ack
      1.18            -1.0        0.18 ±  3%  perf-profile.self.cycles-pp.tcp_write_xmit
      0.97 ±  2%      -0.8        0.16 ±  2%  perf-profile.self.cycles-pp.__ip_queue_xmit
      0.89 ±  8%      -0.8        0.09 ±  7%  perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.95 ±  2%      -0.8        0.18 ±  2%  perf-profile.self.cycles-pp.ip_finish_output2
      0.90 ± 10%      -0.7        0.16 ±  3%  perf-profile.self.cycles-pp.read_tsc
      1.28            -0.7        0.55        perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.88            -0.7        0.15 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.79 ± 10%      -0.7        0.07 ±  7%  perf-profile.self.cycles-pp.ipv4_mtu
      0.81 ± 12%      -0.7        0.09 ±  6%  perf-profile.self.cycles-pp.ipv4_dst_check
      0.88            -0.7        0.16 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.09 ±  3%      -0.7        0.38 ±  2%  perf-profile.self.cycles-pp.tcp_recvmsg_locked
      0.94 ±  2%      -0.7        0.23 ±  3%  perf-profile.self.cycles-pp.tcp_v4_rcv
      0.87            -0.7        0.18 ±  2%  perf-profile.self.cycles-pp.native_sched_clock
      0.93 ±  4%      -0.7        0.25 ±  6%  perf-profile.self.cycles-pp.ktime_get
      1.09            -0.7        0.42 ±  3%  perf-profile.self.cycles-pp.__switch_to_asm
      0.98 ±  4%      -0.7        0.32 ±  2%  perf-profile.self.cycles-pp.update_curr
      0.80 ±  3%      -0.6        0.15 ±  2%  perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.79            -0.6        0.15        perf-profile.self.cycles-pp.___might_sleep
      0.71            -0.6        0.08 ±  4%  perf-profile.self.cycles-pp.copy_fpregs_to_fpstate
      0.73            -0.6        0.12 ±  3%  perf-profile.self.cycles-pp.net_rx_action
      0.76 ±  2%      -0.6        0.17 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.91            -0.6        0.33 ±  3%  perf-profile.self.cycles-pp.__fget_light
      0.78 ±  2%      -0.6        0.20        perf-profile.self.cycles-pp.__cgroup_bpf_run_filter_skb
      0.65            -0.6        0.09 ±  5%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.66            -0.5        0.11 ±  4%  perf-profile.self.cycles-pp.process_backlog
      0.66            -0.5        0.11 ±  3%  perf-profile.self.cycles-pp.__might_sleep
      0.57 ±  2%      -0.5        0.06 ±  8%  perf-profile.self.cycles-pp.ip_output
      0.58            -0.5        0.08 ±  4%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.57 ±  6%      -0.5        0.07 ±  5%  perf-profile.self.cycles-pp.tcp_current_mss
      0.58            -0.5        0.09        perf-profile.self.cycles-pp.tcp_schedule_loss_probe
      0.57 ±  2%      -0.5        0.09        perf-profile.self.cycles-pp.__sys_sendto
      0.69            -0.5        0.23 ±  3%  perf-profile.self.cycles-pp.__switch_to
      0.57            -0.5        0.10 ±  7%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.53 ±  2%      -0.5        0.07 ±  6%  perf-profile.self.cycles-pp.__calc_delta
      0.54 ±  4%      -0.5        0.08 ±  4%  perf-profile.self.cycles-pp.tcp_ack_update_rtt
      0.58 ±  4%      -0.5        0.12 ±  3%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.68            -0.5        0.23 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      1.47            -0.4        1.02        perf-profile.self.cycles-pp.__schedule
      0.60 ±  2%      -0.4        0.18 ±  2%  perf-profile.self.cycles-pp.aa_sk_perm
      0.58 ±  4%      -0.4        0.16 ±  3%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.54 ±  3%      -0.4        0.12        perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      0.57            -0.4        0.16 ±  4%  perf-profile.self.cycles-pp.__alloc_skb
      0.81            -0.4        0.40        perf-profile.self.cycles-pp.skb_release_data
      0.55            -0.4        0.15 ±  3%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.57            -0.4        0.17 ±  5%  perf-profile.self.cycles-pp.__ksize
      0.67 ±  2%      -0.4        0.28        perf-profile.self.cycles-pp.tcp_rcv_established
      0.71            -0.4        0.34        perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.51 ±  2%      -0.4        0.14 ±  4%  perf-profile.self.cycles-pp.___perf_sw_event
      0.44            -0.4        0.08 ±  4%  perf-profile.self.cycles-pp.__sys_recvfrom
      0.43            -0.4        0.08 ±  4%  perf-profile.self.cycles-pp.ip_rcv_core
      0.42 ±  2%      -0.3        0.08 ±  4%  perf-profile.self.cycles-pp.loopback_xmit
      0.40            -0.3        0.06        perf-profile.self.cycles-pp.__netif_receive_skb_one_core
      0.40            -0.3        0.07 ±  5%  perf-profile.self.cycles-pp.tcp_event_new_data_sent
      0.40            -0.3        0.07 ±  5%  perf-profile.self.cycles-pp.__entry_text_start
      0.44 ±  2%      -0.3        0.11 ±  3%  perf-profile.self.cycles-pp.mod_timer
      0.37            -0.3        0.04 ± 44%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.44 ±  3%      -0.3        0.11 ±  4%  perf-profile.self.cycles-pp.kfree
      0.70 ±  3%      -0.3        0.38 ±  2%  perf-profile.self.cycles-pp.__inet_lookup_established
      0.38            -0.3        0.06        perf-profile.self.cycles-pp.tcp_update_pacing_rate
      0.41            -0.3        0.09        perf-profile.self.cycles-pp.dev_hard_start_xmit
      0.54 ±  3%      -0.3        0.23 ±  3%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.36 ±  2%      -0.3        0.06        perf-profile.self.cycles-pp.sock_sendmsg
      0.35            -0.3        0.05        perf-profile.self.cycles-pp.enqueue_to_backlog
      0.36            -0.3        0.07 ±  7%  perf-profile.self.cycles-pp.pick_next_entity
      0.34 ±  2%      -0.3        0.06        perf-profile.self.cycles-pp._copy_to_iter
      0.35 ±  3%      -0.3        0.07 ±  5%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.43            -0.3        0.17 ±  3%  perf-profile.self.cycles-pp.finish_task_switch
      0.35 ±  3%      -0.3        0.09 ±  4%  perf-profile.self.cycles-pp.cpuacct_charge
      0.29            -0.3        0.03 ± 99%  perf-profile.self.cycles-pp.__x64_sys_recvfrom
      0.43 ±  4%      -0.3        0.17 ±  2%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.33 ±  3%      -0.3        0.07 ±  5%  perf-profile.self.cycles-pp.validate_xmit_skb
      0.48            -0.2        0.23 ±  3%  perf-profile.self.cycles-pp.copy_user_generic_unrolled
      0.48            -0.2        0.23 ±  2%  perf-profile.self.cycles-pp.tcp_wfree
      0.33 ±  2%      -0.2        0.09 ±  5%  perf-profile.self.cycles-pp.dequeue_entity
      0.33            -0.2        0.08 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
      0.31 ±  3%      -0.2        0.07        perf-profile.self.cycles-pp.migrate_enable
      0.45 ±  3%      -0.2        0.21 ±  2%  perf-profile.self.cycles-pp.enqueue_entity
      0.30            -0.2        0.07 ±  7%  perf-profile.self.cycles-pp.import_single_range
      0.39            -0.2        0.16 ±  3%  perf-profile.self.cycles-pp.schedule
      0.42            -0.2        0.19 ±  2%  perf-profile.self.cycles-pp.__skb_datagram_iter
      0.29            -0.2        0.06        perf-profile.self.cycles-pp.migrate_disable
      0.42 ±  4%      -0.2        0.19 ±  3%  perf-profile.self.cycles-pp.__check_object_size
      0.33 ±  2%      -0.2        0.10 ±  4%  perf-profile.self.cycles-pp.update_min_vruntime
      0.27 ±  4%      -0.2        0.04 ± 44%  perf-profile.self.cycles-pp.ip_rcv
      0.28 ±  4%      -0.2        0.05 ±  7%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.30 ±  5%      -0.2        0.08 ±  6%  perf-profile.self.cycles-pp.tcp_rearm_rto
      0.27 ±  2%      -0.2        0.05        perf-profile.self.cycles-pp.skb_clone
      0.28            -0.2        0.07        perf-profile.self.cycles-pp.do_softirq
      0.33 ±  2%      -0.2        0.11 ±  4%  perf-profile.self.cycles-pp.kmem_cache_free
      0.27            -0.2        0.05 ±  7%  perf-profile.self.cycles-pp.__x64_sys_sendto
      0.41 ±  2%      -0.2        0.20 ±  2%  perf-profile.self.cycles-pp.skb_entail
      0.39            -0.2        0.18 ±  3%  perf-profile.self.cycles-pp.sock_def_readable
      0.27 ±  5%      -0.2        0.06        perf-profile.self.cycles-pp.inet_recvmsg
      0.25            -0.2        0.05        perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.23 ±  2%      -0.2        0.03 ± 70%  perf-profile.self.cycles-pp.sk_filter_trim_cap
      0.25            -0.2        0.05 ±  9%  perf-profile.self.cycles-pp.tcp_established_options
      0.23 ±  3%      -0.2        0.03 ± 70%  perf-profile.self.cycles-pp.rb_insert_color
      0.25 ±  2%      -0.2        0.06        perf-profile.self.cycles-pp.__tcp_select_window
      0.30 ±  2%      -0.2        0.11 ±  3%  perf-profile.self.cycles-pp.tcp_event_data_recv
      0.36            -0.2        0.18        perf-profile.self.cycles-pp.tcp_queue_rcv
      0.23 ±  2%      -0.2        0.05        perf-profile.self.cycles-pp.release_sock
      0.37 ±  2%      -0.2        0.19 ±  2%  perf-profile.self.cycles-pp.reweight_entity
      0.23 ±  2%      -0.2        0.05 ±  8%  perf-profile.self.cycles-pp.tcp_v4_fill_cb
      0.24            -0.2        0.07 ±  7%  perf-profile.self.cycles-pp.lock_sock_nested
      0.32            -0.2        0.15 ±  2%  perf-profile.self.cycles-pp.sk_wait_data
      0.42            -0.2        0.25        perf-profile.self.cycles-pp.__skb_clone
      0.25 ±  3%      -0.2        0.08 ±  4%  perf-profile.self.cycles-pp.ip_send_check
      0.21 ±  2%      -0.2        0.05        perf-profile.self.cycles-pp.bictcp_cwnd_event
      0.25            -0.2        0.09 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.23 ±  3%      -0.2        0.08 ±  6%  perf-profile.self.cycles-pp.tcp_release_cb
      0.26            -0.2        0.10 ±  4%  perf-profile.self.cycles-pp.__copy_skb_header
      0.21 ±  3%      -0.2        0.06 ±  6%  perf-profile.self.cycles-pp.sockfd_lookup_light
      0.22 ± 13%      -0.1        0.07        perf-profile.self.cycles-pp.tcp_recvmsg
      0.20 ±  6%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.netif_rx_internal
      0.32 ±  3%      -0.1        0.17 ±  4%  perf-profile.self.cycles-pp.sock_rfree
      0.19 ± 13%      -0.1        0.05        perf-profile.self.cycles-pp.ip_rcv_finish
      0.17 ±  2%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.25            -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.__enqueue_entity
      0.23 ±  2%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.tcp_check_space
      0.28            -0.1        0.15 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.18 ±  2%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.rcu_all_qs
      0.24 ±  5%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.schedule_timeout
      0.18 ±  4%      -0.1        0.06 ± 13%  perf-profile.self.cycles-pp.rb_next
      0.18 ±  6%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.netif_skb_features
      0.19            -0.1        0.08 ± 12%  perf-profile.self.cycles-pp._copy_from_iter_full
      0.26 ±  2%      -0.1        0.15 ±  2%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.17 ±  4%      -0.1        0.06        perf-profile.self.cycles-pp.tcp_options_write
      0.27 ±  2%      -0.1        0.17 ±  2%  perf-profile.self.cycles-pp._find_next_bit
      0.27 ±  5%      -0.1        0.17 ±  2%  perf-profile.self.cycles-pp.skb_release_head_state
      0.16 ±  4%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.__napi_poll
      0.14 ±  3%      -0.1        0.05 ±  7%  perf-profile.self.cycles-pp.__list_add_valid
      0.15 ±  3%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.__wake_up_common
      0.15 ±  5%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.sk_free
      0.13 ±  2%      -0.1        0.05        perf-profile.self.cycles-pp.update_irq_load_avg
      0.14            -0.1        0.07        perf-profile.self.cycles-pp.woken_wake_function
      0.18 ±  2%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.set_next_entity
      0.21 ±  5%      -0.1        0.14 ±  2%  perf-profile.self.cycles-pp.kfree_skbmem
      0.16 ±  3%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.perf_tp_event
      0.08 ± 17%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.cpus_share_cache
      0.10 ±  4%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.tcp_rate_check_app_limited
      0.40            -0.0        0.35 ±  2%  perf-profile.self.cycles-pp.wait_woken
      0.26 ±  8%      -0.0        0.21 ±  3%  perf-profile.self.cycles-pp.skb_page_frag_refill
      0.11 ±  9%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.cpumask_next_wrap
      0.09            -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.add_wait_queue
      0.09 ± 28%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.copyin
      0.08 ±  4%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__fdget
      0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.tcp_rcv_space_adjust
      0.09 ±  4%      +0.0        0.13        perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.21 ±  2%      +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.sock_put
      0.00            +0.0        0.05        perf-profile.self.cycles-pp.get_xsave_addr
      0.00            +0.0        0.05        perf-profile.self.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.attach_entity_load_avg
      0.22 ±  2%      +0.1        0.33 ±  2%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.menu_select
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      1.12 ±  2%      +0.1        1.24        perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.1        0.14 ±  2%  perf-profile.self.cycles-pp.migrate_task_rq_fair
      0.00            +0.2        0.17 ±  2%  perf-profile.self.cycles-pp.do_idle
      0.62            +0.3        0.92        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.3        0.33        perf-profile.self.cycles-pp.__slab_free
      0.00            +0.4        0.44 ±  3%  perf-profile.self.cycles-pp.select_idle_sibling
      0.32 ±  3%      +0.5        0.80        perf-profile.self.cycles-pp.try_to_wake_up
      0.07 ± 10%      +0.7        0.77 ±  2%  perf-profile.self.cycles-pp.available_idle_cpu
      0.00            +6.5        6.52        perf-profile.self.cycles-pp.set_task_cpu
      1.10 ±  3%      +9.4       10.51        perf-profile.self.cycles-pp.update_load_avg
      0.00           +11.8       11.85        perf-profile.self.cycles-pp.intel_idle
      0.59 ±  3%     +13.3       13.87        perf-profile.self.cycles-pp.update_cfs_group
      0.00           +24.8       24.83        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
  21089949           -85.8%    2989620 ± 12%  softirqs.CPU0.NET_RX
     43259 ±  4%     -38.2%      26722 ± 10%  softirqs.CPU0.RCU
      9128 ±  9%   +1186.2%     117403 ± 11%  softirqs.CPU0.SCHED
  21110414 ±  2%     -84.8%    3204968 ±  6%  softirqs.CPU1.NET_RX
     42310 ±  4%     -46.0%      22838 ± 11%  softirqs.CPU1.RCU
      7021 ± 13%   +1668.3%     124165 ±  2%  softirqs.CPU1.SCHED
  21143855           -84.7%    3243631 ±  6%  softirqs.CPU10.NET_RX
     42441 ±  5%     -47.3%      22379 ± 12%  softirqs.CPU10.RCU
      7111 ± 10%   +1637.1%     123534        softirqs.CPU10.SCHED
  21204884 ±  2%     -84.7%    3245701 ±  6%  softirqs.CPU100.NET_RX
     41490 ±  4%     -46.6%      22173 ± 12%  softirqs.CPU100.RCU
      6455 ± 10%   +1815.6%     123661        softirqs.CPU100.SCHED
  21232081           -84.8%    3231541 ±  6%  softirqs.CPU101.NET_RX
     41589 ±  4%     -46.8%      22111 ± 12%  softirqs.CPU101.RCU
      6425 ± 10%   +1824.0%     123623        softirqs.CPU101.SCHED
  21126545 ±  2%     -85.4%    3085512 ±  7%  softirqs.CPU102.NET_RX
     41763 ±  5%     -47.1%      22073 ± 12%  softirqs.CPU102.RCU
      6441 ± 10%   +1738.4%     118410 ±  9%  softirqs.CPU102.SCHED
  21127232 ±  2%     -84.7%    3229568 ±  6%  softirqs.CPU103.NET_RX
     41827 ±  5%     -46.2%      22497 ± 10%  softirqs.CPU103.RCU
      6478 ± 10%   +1806.9%     123534        softirqs.CPU103.SCHED
  21217326           -84.7%    3237447 ±  6%  softirqs.CPU104.NET_RX
     41828 ±  5%     -47.4%      22005 ± 12%  softirqs.CPU104.RCU
      6448 ± 10%   +1817.5%     123647        softirqs.CPU104.SCHED
  21091797           -84.6%    3258276 ±  6%  softirqs.CPU105.NET_RX
     41694 ±  5%     -47.2%      22007 ± 11%  softirqs.CPU105.RCU
      6300 ± 11%   +1861.0%     123559        softirqs.CPU105.SCHED
  21085207 ±  2%     -84.6%    3243105 ±  6%  softirqs.CPU106.NET_RX
     41857 ±  4%     -47.4%      22032 ± 11%  softirqs.CPU106.RCU
      6490 ±  9%   +1803.4%     123527        softirqs.CPU106.SCHED
  21289615           -84.8%    3242867 ±  6%  softirqs.CPU107.NET_RX
     41335 ±  5%     -46.9%      21947 ± 11%  softirqs.CPU107.RCU
      6393 ± 10%   +1831.8%     123517        softirqs.CPU107.SCHED
  21106732 ±  2%     -84.7%    3226990 ±  6%  softirqs.CPU108.NET_RX
     41558 ±  5%     -46.8%      22112 ± 11%  softirqs.CPU108.RCU
      6581 ± 13%   +1782.9%     123927        softirqs.CPU108.SCHED
  21080026 ±  2%     -84.7%    3223745 ±  7%  softirqs.CPU109.NET_RX
     41748 ±  5%     -47.3%      21983 ± 12%  softirqs.CPU109.RCU
      6565 ± 10%   +1782.6%     123600        softirqs.CPU109.SCHED
  21333326           -84.8%    3233409 ±  7%  softirqs.CPU11.NET_RX
     42155 ±  5%     -45.5%      22954 ± 13%  softirqs.CPU11.RCU
      6449 ± 11%   +1827.6%     124325        softirqs.CPU11.SCHED
  20809847           -84.5%    3233960 ±  6%  softirqs.CPU110.NET_RX
     41662 ±  5%     -47.0%      22062 ± 11%  softirqs.CPU110.RCU
      6394 ±  9%   +1832.2%     123548        softirqs.CPU110.SCHED
  21371230           -84.8%    3247104 ±  6%  softirqs.CPU111.NET_RX
     41795 ±  5%     -46.9%      22175 ± 11%  softirqs.CPU111.RCU
      6388 ±  9%   +1834.6%     123582        softirqs.CPU111.SCHED
  21506296           -84.9%    3245365 ±  6%  softirqs.CPU112.NET_RX
     42999 ±  5%     -48.7%      22077 ± 11%  softirqs.CPU112.RCU
      6429 ± 10%   +1820.6%     123494        softirqs.CPU112.SCHED
  21158589 ±  2%     -84.8%    3220539 ±  7%  softirqs.CPU113.NET_RX
     42935 ±  5%     -48.3%      22189 ± 11%  softirqs.CPU113.RCU
      6390 ±  8%   +1836.3%     123741        softirqs.CPU113.SCHED
  21251449 ±  2%     -84.9%    3210605 ±  6%  softirqs.CPU114.NET_RX
     42964 ±  5%     -48.9%      21946 ± 11%  softirqs.CPU114.RCU
      6418 ± 10%   +1817.2%     123053 ±  2%  softirqs.CPU114.SCHED
  21134317           -84.7%    3232097 ±  6%  softirqs.CPU115.NET_RX
     43081 ±  5%     -48.7%      22080 ± 11%  softirqs.CPU115.RCU
      6453 ± 10%   +1816.5%     123675        softirqs.CPU115.SCHED
  21085261 ±  2%     -84.6%    3240783 ±  6%  softirqs.CPU116.NET_RX
     43194 ±  5%     -49.1%      21983 ± 12%  softirqs.CPU116.RCU
      6490 ± 10%   +1804.2%     123587        softirqs.CPU116.SCHED
  21031757           -84.6%    3239936 ±  6%  softirqs.CPU117.NET_RX
     42936 ±  5%     -48.7%      22033 ± 12%  softirqs.CPU117.RCU
      6389 ± 11%   +1831.5%     123414 ±  2%  softirqs.CPU117.SCHED
  21328805           -84.8%    3234243 ±  6%  softirqs.CPU118.NET_RX
     42825 ±  5%     -48.7%      21962 ± 11%  softirqs.CPU118.RCU
      6262 ± 12%   +1870.7%     123418        softirqs.CPU118.SCHED
  20600211 ±  2%     -84.4%    3217341 ±  7%  softirqs.CPU119.NET_RX
     43424 ±  6%     -47.2%      22926 ± 19%  softirqs.CPU119.RCU
      6219 ± 12%   +1877.6%     122990        softirqs.CPU119.SCHED
  21190692 ±  3%     -84.8%    3218450 ±  6%  softirqs.CPU12.NET_RX
     42159 ±  5%     -45.5%      22994 ± 11%  softirqs.CPU12.RCU
      6552 ± 12%   +1790.5%     123884        softirqs.CPU12.SCHED
  21060301 ±  2%     -83.3%    3511051 ±  7%  softirqs.CPU120.NET_RX
     43878 ±  4%     -49.5%      22153 ± 12%  softirqs.CPU120.RCU
      6432 ±  7%   +1799.0%     122140 ±  3%  softirqs.CPU120.SCHED
  22076911 ±  2%     -84.0%    3538992 ±  7%  softirqs.CPU121.NET_RX
     44348 ±  4%     -50.2%      22102 ± 12%  softirqs.CPU121.RCU
      6479 ±  9%   +1782.8%     121988 ±  3%  softirqs.CPU121.SCHED
  21689652 ±  2%     -83.6%    3560830 ±  7%  softirqs.CPU122.NET_RX
     43443 ±  4%     -49.0%      22164 ± 12%  softirqs.CPU122.RCU
      6310 ±  5%   +1832.7%     121956 ±  3%  softirqs.CPU122.SCHED
  21434645 ±  5%     -83.5%    3545442 ±  7%  softirqs.CPU123.NET_RX
     42799 ±  4%     -48.1%      22193 ± 12%  softirqs.CPU123.RCU
      6367 ±  7%   +1814.9%     121932 ±  3%  softirqs.CPU123.SCHED
  22107036           -83.9%    3569405 ±  7%  softirqs.CPU124.NET_RX
     43573 ±  4%     -48.9%      22286 ± 13%  softirqs.CPU124.RCU
      6322 ±  6%   +1830.7%     122076 ±  3%  softirqs.CPU124.SCHED
  21971830 ±  2%     -83.9%    3537171 ±  7%  softirqs.CPU125.NET_RX
     43068 ±  4%     -48.6%      22141 ± 12%  softirqs.CPU125.RCU
      6312 ±  5%   +1831.2%     121912 ±  3%  softirqs.CPU125.SCHED
  21977420 ±  3%     -83.9%    3528263 ±  7%  softirqs.CPU126.NET_RX
     43650 ±  4%     -49.0%      22282 ± 13%  softirqs.CPU126.RCU
      6334 ±  5%   +1826.3%     122024 ±  3%  softirqs.CPU126.SCHED
  21741712 ±  2%     -83.7%    3535470 ±  7%  softirqs.CPU127.NET_RX
     43621 ±  4%     -49.5%      22022 ± 12%  softirqs.CPU127.RCU
      6285 ±  4%   +1839.7%     121921 ±  3%  softirqs.CPU127.SCHED
  22266837 ±  2%     -84.1%    3548256 ±  7%  softirqs.CPU128.NET_RX
     41978 ±  5%     -47.2%      22156 ± 12%  softirqs.CPU128.RCU
      6297 ±  5%   +1836.8%     121961 ±  3%  softirqs.CPU128.SCHED
  21798871 ±  2%     -83.6%    3567035 ±  7%  softirqs.CPU129.NET_RX
     41751 ±  5%     -46.4%      22399 ± 11%  softirqs.CPU129.RCU
      6309 ±  5%   +1828.5%     121681 ±  3%  softirqs.CPU129.SCHED
  21262849           -84.8%    3225261 ±  6%  softirqs.CPU13.NET_RX
     41455 ±  5%     -45.9%      22430 ± 11%  softirqs.CPU13.RCU
      6539 ± 12%   +1793.2%     123805        softirqs.CPU13.SCHED
  22112318 ±  3%     -83.9%    3550339 ±  7%  softirqs.CPU130.NET_RX
     42358 ±  4%     -47.0%      22458 ± 11%  softirqs.CPU130.RCU
      6421 ±  5%   +1797.9%     121866 ±  3%  softirqs.CPU130.SCHED
  22061337 ±  3%     -84.0%    3537435 ±  7%  softirqs.CPU131.NET_RX
     41498 ±  4%     -46.9%      22055 ± 12%  softirqs.CPU131.RCU
      6318 ±  6%   +1830.0%     121952 ±  3%  softirqs.CPU131.SCHED
  21719312 ±  3%     -83.7%    3539791 ±  7%  softirqs.CPU132.NET_RX
     41664 ±  4%     -46.7%      22188 ± 12%  softirqs.CPU132.RCU
      6329 ±  6%   +1828.0%     122030 ±  3%  softirqs.CPU132.SCHED
  22111882           -84.0%    3535728 ±  7%  softirqs.CPU133.NET_RX
     41790 ±  4%     -47.1%      22120 ± 12%  softirqs.CPU133.RCU
      6367 ±  5%   +1815.2%     121952 ±  3%  softirqs.CPU133.SCHED
  22070411 ±  3%     -83.9%    3543159 ±  7%  softirqs.CPU134.NET_RX
     41771 ±  4%     -46.9%      22177 ± 12%  softirqs.CPU134.RCU
      6132 ±  9%   +1888.2%     121926 ±  3%  softirqs.CPU134.SCHED
  21797645 ±  3%     -83.6%    3570452 ±  7%  softirqs.CPU135.NET_RX
     42425 ±  7%     -47.9%      22114 ± 12%  softirqs.CPU135.RCU
      6292 ±  5%   +1837.4%     121898 ±  3%  softirqs.CPU135.SCHED
  21861365           -83.7%    3553898 ±  7%  softirqs.CPU136.NET_RX
     41626 ±  4%     -46.7%      22201 ± 12%  softirqs.CPU136.RCU
      6250 ±  6%   +1850.8%     121936 ±  3%  softirqs.CPU136.SCHED
  22026263 ±  3%     -84.0%    3533248 ±  7%  softirqs.CPU137.NET_RX
     41601 ±  4%     -46.9%      22079 ± 13%  softirqs.CPU137.RCU
      6304 ±  6%   +1833.9%     121929 ±  3%  softirqs.CPU137.SCHED
  21738929 ±  2%     -83.7%    3543092 ±  7%  softirqs.CPU138.NET_RX
     41609 ±  4%     -46.0%      22480 ± 12%  softirqs.CPU138.RCU
      6301 ±  5%   +1833.0%     121813 ±  3%  softirqs.CPU138.SCHED
  21927693           -83.9%    3530203 ±  7%  softirqs.CPU139.NET_RX
     41803 ±  4%     -47.3%      22048 ± 12%  softirqs.CPU139.RCU
      6261 ±  5%   +1846.4%     121880 ±  3%  softirqs.CPU139.SCHED
  21004769           -84.6%    3230354 ±  6%  softirqs.CPU14.NET_RX
     41727 ±  5%     -44.6%      23129 ± 10%  softirqs.CPU14.RCU
      6482 ± 10%   +1802.2%     123305        softirqs.CPU14.SCHED
  22068737 ±  4%     -83.9%    3560636 ±  7%  softirqs.CPU140.NET_RX
     41639 ±  4%     -46.9%      22096 ± 12%  softirqs.CPU140.RCU
      6266 ±  6%   +1843.5%     121795 ±  3%  softirqs.CPU140.SCHED
  21903090 ±  3%     -83.8%    3556461 ±  7%  softirqs.CPU141.NET_RX
     41554 ±  5%     -47.1%      21962 ± 12%  softirqs.CPU141.RCU
      6248 ±  5%   +1849.0%     121791 ±  3%  softirqs.CPU141.SCHED
  22076631 ±  2%     -84.0%    3533559 ±  7%  softirqs.CPU142.NET_RX
     41287 ±  5%     -46.8%      21960 ± 12%  softirqs.CPU142.RCU
      6231 ±  5%   +1855.0%     121831 ±  3%  softirqs.CPU142.SCHED
  21676631 ±  2%     -83.7%    3536303 ±  7%  softirqs.CPU143.NET_RX
     41504 ±  5%     -46.9%      22019 ± 12%  softirqs.CPU143.RCU
      6281 ±  5%   +1842.7%     122026 ±  3%  softirqs.CPU143.SCHED
  21727456           -83.7%    3543613 ± 15%  softirqs.CPU144.NET_RX
     41239 ±  6%     -47.2%      21792 ± 13%  softirqs.CPU144.RCU
      6289 ±  7%   +1832.1%     121512 ±  3%  softirqs.CPU144.SCHED
  22306831 ±  2%     -83.8%    3603104 ± 15%  softirqs.CPU145.NET_RX
     41452 ±  7%     -47.2%      21906 ± 13%  softirqs.CPU145.RCU
      6366 ±  8%   +1807.4%     121434 ±  3%  softirqs.CPU145.SCHED
  21785130 ±  3%     -83.5%    3604421 ± 15%  softirqs.CPU146.NET_RX
     41349 ±  6%     -47.5%      21724 ± 12%  softirqs.CPU146.RCU
      6347 ±  7%   +1813.2%     121435 ±  3%  softirqs.CPU146.SCHED
  21232094 ±  3%     -83.1%    3598219 ± 15%  softirqs.CPU147.NET_RX
     40828 ±  6%     -46.5%      21824 ± 13%  softirqs.CPU147.RCU
      6293 ±  7%   +1828.1%     121336 ±  3%  softirqs.CPU147.SCHED
  22069243 ±  2%     -83.6%    3612608 ± 15%  softirqs.CPU148.NET_RX
     40473 ±  7%     -45.8%      21931 ± 14%  softirqs.CPU148.RCU
      6232 ±  8%   +1846.5%     121308 ±  3%  softirqs.CPU148.SCHED
  22177970           -83.7%    3609960 ± 15%  softirqs.CPU149.NET_RX
     41267 ±  6%     -46.9%      21903 ± 13%  softirqs.CPU149.RCU
      6332 ±  7%   +1818.1%     121455 ±  3%  softirqs.CPU149.SCHED
  21356834 ±  2%     -84.8%    3244899 ±  6%  softirqs.CPU15.NET_RX
     41941 ±  5%     -46.4%      22485 ± 11%  softirqs.CPU15.RCU
      6388 ±  9%   +1834.5%     123576        softirqs.CPU15.SCHED
  22054050 ±  2%     -83.8%    3576963 ± 15%  softirqs.CPU150.NET_RX
     41610 ±  6%     -47.6%      21822 ± 13%  softirqs.CPU150.RCU
      6511 ±  7%   +1764.7%     121418 ±  3%  softirqs.CPU150.SCHED
  22211176 ±  2%     -83.8%    3598883 ± 15%  softirqs.CPU151.NET_RX
     41070 ±  6%     -46.8%      21838 ± 13%  softirqs.CPU151.RCU
      6332 ±  7%   +1816.1%     121336 ±  3%  softirqs.CPU151.SCHED
  22064325 ±  2%     -83.6%    3611293 ± 15%  softirqs.CPU152.NET_RX
     40838 ±  6%     -46.7%      21774 ± 13%  softirqs.CPU152.RCU
      6325 ±  8%   +1818.5%     121352 ±  3%  softirqs.CPU152.SCHED
  22224794 ±  2%     -83.8%    3611086 ± 15%  softirqs.CPU153.NET_RX
     40704 ±  9%     -46.4%      21801 ± 13%  softirqs.CPU153.RCU
      6296 ±  7%   +1827.7%     121370 ±  3%  softirqs.CPU153.SCHED
  21838832 ±  2%     -83.6%    3581908 ± 15%  softirqs.CPU154.NET_RX
     41284 ±  6%     -47.1%      21842 ± 13%  softirqs.CPU154.RCU
      6288 ±  7%   +1830.9%     121415 ±  3%  softirqs.CPU154.SCHED
  22225475 ±  2%     -83.8%    3593379 ± 15%  softirqs.CPU155.NET_RX
     41248 ±  6%     -47.3%      21739 ± 13%  softirqs.CPU155.RCU
      6249 ±  8%   +1843.3%     121437 ±  3%  softirqs.CPU155.SCHED
  22275414 ±  2%     -83.9%    3590419 ± 15%  softirqs.CPU156.NET_RX
     40958 ±  6%     -46.8%      21790 ± 13%  softirqs.CPU156.RCU
      6356 ±  7%   +1811.1%     121472 ±  3%  softirqs.CPU156.SCHED
  22120237 ±  3%     -83.7%    3605416 ± 15%  softirqs.CPU157.NET_RX
     41206 ±  6%     -47.0%      21827 ± 13%  softirqs.CPU157.RCU
      6336 ±  7%   +1817.0%     121470 ±  3%  softirqs.CPU157.SCHED
  22218563 ±  2%     -83.8%    3606034 ± 16%  softirqs.CPU158.NET_RX
     40854 ±  6%     -45.9%      22086 ± 15%  softirqs.CPU158.RCU
      6268 ±  7%   +1834.4%     121258 ±  3%  softirqs.CPU158.SCHED
  22109688 ±  2%     -83.7%    3606683 ± 15%  softirqs.CPU159.NET_RX
     41084 ±  6%     -47.2%      21696 ± 13%  softirqs.CPU159.RCU
      6321 ±  8%   +1818.9%     121309 ±  3%  softirqs.CPU159.SCHED
  21339128 ±  2%     -84.8%    3240429 ±  6%  softirqs.CPU16.NET_RX
     43110 ±  5%     -47.6%      22599 ± 11%  softirqs.CPU16.RCU
      6382 ± 10%   +1836.8%     123604        softirqs.CPU16.SCHED
  22109619 ±  2%     -83.6%    3615340 ± 15%  softirqs.CPU160.NET_RX
     43313 ±  5%     -48.8%      22197 ± 15%  softirqs.CPU160.RCU
      6349 ±  7%   +1812.5%     121427 ±  3%  softirqs.CPU160.SCHED
  21821599 ±  2%     -83.5%    3609540 ± 16%  softirqs.CPU161.NET_RX
     43460 ±  5%     -49.6%      21906 ± 13%  softirqs.CPU161.RCU
      6301 ±  9%   +1832.8%     121794 ±  3%  softirqs.CPU161.SCHED
  22087548 ±  3%     -83.7%    3599251 ± 16%  softirqs.CPU162.NET_RX
     43164 ±  5%     -49.2%      21915 ± 13%  softirqs.CPU162.RCU
      6322 ±  7%   +1819.1%     121338 ±  3%  softirqs.CPU162.SCHED
  21861229 ±  2%     -83.6%    3588697 ± 15%  softirqs.CPU163.NET_RX
     42815 ±  5%     -48.8%      21942 ± 13%  softirqs.CPU163.RCU
      6296 ±  7%   +1828.3%     121407 ±  3%  softirqs.CPU163.SCHED
  21893539           -83.5%    3617073 ± 15%  softirqs.CPU164.NET_RX
     42932 ±  5%     -48.9%      21922 ± 13%  softirqs.CPU164.RCU
      6326 ±  8%   +1816.7%     121260 ±  3%  softirqs.CPU164.SCHED
  22155077 ±  3%     -83.7%    3616815 ± 16%  softirqs.CPU165.NET_RX
     43440 ±  6%     -49.6%      21881 ± 13%  softirqs.CPU165.RCU
      6357 ±  9%   +1808.5%     121340 ±  3%  softirqs.CPU165.SCHED
  22276929 ±  2%     -83.9%    3585606 ± 15%  softirqs.CPU166.NET_RX
     43511 ±  5%     -49.7%      21906 ± 13%  softirqs.CPU166.RCU
      6293 ±  8%   +1831.4%     121552 ±  3%  softirqs.CPU166.SCHED
  21917532 ±  3%     -83.7%    3581813 ± 15%  softirqs.CPU167.NET_RX
     43558 ±  5%     -49.5%      21982 ± 13%  softirqs.CPU167.RCU
      6583 ± 11%   +1744.8%     121441 ±  3%  softirqs.CPU167.SCHED
  21044980 ±  2%     -83.8%    3401343 ±  2%  softirqs.CPU168.NET_RX
     40641 ±  6%     -46.7%      21675 ± 12%  softirqs.CPU168.RCU
      7154 ±  8%   +1641.6%     124600        softirqs.CPU168.SCHED
  21419375           -84.4%    3334229 ±  7%  softirqs.CPU169.NET_RX
     40916 ±  5%     -46.8%      21747 ± 12%  softirqs.CPU169.RCU
      7037 ± 10%   +1601.5%     119743 ±  8%  softirqs.CPU169.SCHED
  21328933           -84.9%    3217840 ±  6%  softirqs.CPU17.NET_RX
     43234 ±  4%     -48.6%      22229 ± 11%  softirqs.CPU17.RCU
      6453 ± 10%   +1813.9%     123516        softirqs.CPU17.SCHED
  21258245           -83.7%    3468299 ±  2%  softirqs.CPU170.NET_RX
     41473 ±  5%     -47.8%      21651 ± 12%  softirqs.CPU170.RCU
      7023 ± 11%   +1671.1%     124393        softirqs.CPU170.SCHED
  21223382 ±  2%     -83.7%    3466301 ±  2%  softirqs.CPU171.NET_RX
     40893 ±  5%     -46.7%      21797 ± 12%  softirqs.CPU171.RCU
      7026 ± 11%   +1670.4%     124397        softirqs.CPU171.SCHED
  21126518           -83.5%    3481275 ±  2%  softirqs.CPU172.NET_RX
     41233 ±  5%     -47.2%      21765 ± 11%  softirqs.CPU172.RCU
      7087 ± 11%   +1655.5%     124426        softirqs.CPU172.SCHED
  21470783           -83.9%    3455627 ±  2%  softirqs.CPU173.NET_RX
     41193 ±  5%     -47.3%      21688 ± 12%  softirqs.CPU173.RCU
      6987 ± 10%   +1682.4%     124545        softirqs.CPU173.SCHED
  21412226 ±  2%     -83.9%    3452021 ±  2%  softirqs.CPU174.NET_RX
     41316 ±  5%     -47.6%      21636 ± 12%  softirqs.CPU174.RCU
      7020 ± 11%   +1673.3%     124490        softirqs.CPU174.SCHED
  21410841           -83.8%    3469881 ±  2%  softirqs.CPU175.NET_RX
     41129 ±  5%     -47.4%      21619 ± 12%  softirqs.CPU175.RCU
      7003 ± 12%   +1677.5%     124488        softirqs.CPU175.SCHED
  21356566           -83.7%    3482920 ±  2%  softirqs.CPU176.NET_RX
     42741 ±  5%     -49.2%      21732 ± 12%  softirqs.CPU176.RCU
      7028 ± 11%   +1668.6%     124306        softirqs.CPU176.SCHED
  21362620           -83.7%    3480149 ±  2%  softirqs.CPU177.NET_RX
     43210 ±  5%     -49.1%      21978 ± 11%  softirqs.CPU177.RCU
      6999 ± 11%   +1676.7%     124361        softirqs.CPU177.SCHED
  21365410           -83.8%    3459326 ±  2%  softirqs.CPU178.NET_RX
     43212 ±  5%     -48.9%      22069 ± 11%  softirqs.CPU178.RCU
      7034 ± 12%   +1670.3%     124532        softirqs.CPU178.SCHED
  21555250           -83.9%    3460099 ±  2%  softirqs.CPU179.NET_RX
     43065 ±  5%     -49.5%      21731 ± 12%  softirqs.CPU179.RCU
      7013 ± 11%   +1673.8%     124405        softirqs.CPU179.SCHED
  21261067           -84.8%    3234245 ±  6%  softirqs.CPU18.NET_RX
     43393 ±  5%     -48.9%      22173 ± 11%  softirqs.CPU18.RCU
      6462 ± 10%   +1811.8%     123541        softirqs.CPU18.SCHED
  21160181 ±  2%     -83.6%    3461692 ±  2%  softirqs.CPU180.NET_RX
     43049 ±  4%     -49.5%      21724 ± 12%  softirqs.CPU180.RCU
      6974 ± 11%   +1685.9%     124558        softirqs.CPU180.SCHED
  21297779           -83.9%    3429715 ±  4%  softirqs.CPU181.NET_RX
     42816 ±  5%     -49.4%      21656 ± 12%  softirqs.CPU181.RCU
      7005 ± 12%   +1644.0%     122176 ±  4%  softirqs.CPU181.SCHED
  21333411 ±  2%     -83.7%    3472238 ±  2%  softirqs.CPU182.NET_RX
     42723 ±  5%     -49.3%      21650 ± 12%  softirqs.CPU182.RCU
      6954 ± 12%   +1688.3%     124373        softirqs.CPU182.SCHED
  21262028           -83.7%    3469338 ±  2%  softirqs.CPU183.NET_RX
     42955 ±  5%     -49.6%      21667 ± 12%  softirqs.CPU183.RCU
      6954 ± 10%   +1686.5%     124237        softirqs.CPU183.SCHED
  21340897           -83.8%    3461830 ±  2%  softirqs.CPU184.NET_RX
     42800 ±  5%     -49.2%      21724 ± 12%  softirqs.CPU184.RCU
      6933 ± 11%   +1695.3%     124469        softirqs.CPU184.SCHED
  21185172           -83.7%    3457528 ±  2%  softirqs.CPU185.NET_RX
     43033 ±  5%     -49.7%      21653 ± 12%  softirqs.CPU185.RCU
      7119 ± 12%   +1649.5%     124548        softirqs.CPU185.SCHED
  21210384           -83.7%    3447509 ±  2%  softirqs.CPU186.NET_RX
     43046 ±  5%     -49.6%      21707 ± 12%  softirqs.CPU186.RCU
      7012 ± 11%   +1667.9%     123980        softirqs.CPU186.SCHED
  21402048 ±  2%     -83.9%    3451075 ±  2%  softirqs.CPU187.NET_RX
     42928 ±  5%     -49.2%      21804 ± 12%  softirqs.CPU187.RCU
      7005 ± 11%   +1675.6%     124394        softirqs.CPU187.SCHED
  21453931           -83.8%    3471605 ±  2%  softirqs.CPU188.NET_RX
     42653 ±  5%     -49.2%      21655 ± 12%  softirqs.CPU188.RCU
      7078 ± 11%   +1658.1%     124444        softirqs.CPU188.SCHED
  21529386           -83.8%    3477434 ±  2%  softirqs.CPU189.NET_RX
     42966 ±  5%     -49.6%      21661 ± 12%  softirqs.CPU189.RCU
      7097 ± 10%   +1652.2%     124362        softirqs.CPU189.SCHED
  21036465 ±  2%     -84.7%    3222377 ±  6%  softirqs.CPU19.NET_RX
     43445 ±  5%     -48.6%      22336 ± 11%  softirqs.CPU19.RCU
      6447 ± 10%   +1814.8%     123455        softirqs.CPU19.SCHED
  21376613           -83.9%    3451016 ±  2%  softirqs.CPU190.NET_RX
     43049 ±  5%     -49.5%      21756 ± 13%  softirqs.CPU190.RCU
      7010 ± 11%   +1676.2%     124523        softirqs.CPU190.SCHED
  20635117           -83.9%    3321052 ±  2%  softirqs.CPU191.NET_RX
     43481 ±  5%     -49.6%      21900 ± 12%  softirqs.CPU191.RCU
      7229 ± 16%   +1567.6%     120548        softirqs.CPU191.SCHED
  20797440 ±  3%     -84.8%    3157799 ± 11%  softirqs.CPU2.NET_RX
     41846 ±  5%     -45.9%      22642 ± 11%  softirqs.CPU2.RCU
      6888 ± 18%   +1643.1%     120078 ±  5%  softirqs.CPU2.SCHED
  21024095 ±  2%     -84.5%    3252088 ±  6%  softirqs.CPU20.NET_RX
     43269 ±  5%     -48.7%      22183 ± 11%  softirqs.CPU20.RCU
      6407 ± 10%   +1831.5%     123763        softirqs.CPU20.SCHED
  20926277 ±  2%     -84.5%    3242026 ±  6%  softirqs.CPU21.NET_RX
     43269 ±  4%     -48.8%      22139 ± 12%  softirqs.CPU21.RCU
      6274 ± 13%   +1870.4%     123640        softirqs.CPU21.SCHED
  21077431 ±  2%     -84.6%    3246240 ±  6%  softirqs.CPU22.NET_RX
     43234 ±  5%     -48.4%      22317 ± 12%  softirqs.CPU22.RCU
      6376 ± 11%   +1843.3%     123910        softirqs.CPU22.SCHED
  21029368 ±  3%     -84.7%    3220265 ±  6%  softirqs.CPU23.NET_RX
     43088 ±  4%     -48.6%      22135 ± 11%  softirqs.CPU23.RCU
      6219 ± 13%   +1887.1%     123588        softirqs.CPU23.SCHED
  21307111 ±  3%     -83.6%    3498024 ±  7%  softirqs.CPU24.NET_RX
     43128 ±  4%     -48.2%      22331 ± 12%  softirqs.CPU24.RCU
      6239 ±  5%   +1859.0%     122238 ±  3%  softirqs.CPU24.SCHED
  21868294 ±  2%     -83.8%    3535036 ±  7%  softirqs.CPU25.NET_RX
     43203 ±  4%     -46.5%      23128 ± 12%  softirqs.CPU25.RCU
      6222 ±  4%   +1862.4%     122108 ±  3%  softirqs.CPU25.SCHED
  21899068 ±  2%     -83.8%    3554637 ±  7%  softirqs.CPU26.NET_RX
     43326 ±  5%     -48.0%      22509 ± 11%  softirqs.CPU26.RCU
      6242 ±  5%   +1856.7%     122138 ±  3%  softirqs.CPU26.SCHED
  21745475 ±  3%     -83.7%    3545972 ±  7%  softirqs.CPU27.NET_RX
     42977 ±  4%     -47.0%      22776 ± 12%  softirqs.CPU27.RCU
      6099 ±  5%   +1899.4%     121954 ±  3%  softirqs.CPU27.SCHED
  21715337 ±  2%     -83.6%    3555366 ±  7%  softirqs.CPU28.NET_RX
     43381 ±  3%     -48.0%      22563 ± 12%  softirqs.CPU28.RCU
      6244 ±  6%   +1852.7%     121931 ±  3%  softirqs.CPU28.SCHED
  21739607           -83.7%    3547302 ±  7%  softirqs.CPU29.NET_RX
     43164 ±  4%     -48.1%      22419 ± 12%  softirqs.CPU29.RCU
      6244 ±  6%   +1854.2%     122019 ±  3%  softirqs.CPU29.SCHED
  21276568           -84.8%    3233261 ±  6%  softirqs.CPU3.NET_RX
     42043 ±  5%     -46.5%      22505 ± 12%  softirqs.CPU3.RCU
      6563 ±  8%   +1783.8%     123644        softirqs.CPU3.SCHED
  21780558 ±  3%     -83.8%    3529211 ±  7%  softirqs.CPU30.NET_RX
     43512 ±  3%     -48.1%      22601 ± 13%  softirqs.CPU30.RCU
      6242 ±  6%   +1855.7%     122075 ±  3%  softirqs.CPU30.SCHED
  21925350 ±  2%     -83.9%    3525576 ±  7%  softirqs.CPU31.NET_RX
     43589 ±  3%     -48.2%      22561 ± 11%  softirqs.CPU31.RCU
      6292 ±  6%   +1837.2%     121897 ±  3%  softirqs.CPU31.SCHED
  22178024 ±  2%     -84.0%    3551217 ±  7%  softirqs.CPU32.NET_RX
     42541 ±  5%     -47.3%      22437 ± 12%  softirqs.CPU32.RCU
      6532 ± 10%   +1767.8%     122014 ±  3%  softirqs.CPU32.SCHED
  21895952 ±  2%     -83.7%    3572427 ±  7%  softirqs.CPU33.NET_RX
     42539 ±  4%     -46.5%      22745 ± 11%  softirqs.CPU33.RCU
      6250 ±  6%   +1850.8%     121927 ±  3%  softirqs.CPU33.SCHED
  21741670 ±  4%     -83.7%    3554239 ±  7%  softirqs.CPU34.NET_RX
     42853 ±  5%     -47.4%      22531 ± 12%  softirqs.CPU34.RCU
      6268 ±  5%   +1845.5%     121955 ±  3%  softirqs.CPU34.SCHED
  21894414 ±  3%     -83.8%    3537215 ±  7%  softirqs.CPU35.NET_RX
     42731 ±  4%     -47.3%      22508 ± 12%  softirqs.CPU35.RCU
      6232 ±  5%   +1858.5%     122071 ±  3%  softirqs.CPU35.SCHED
  21881538 ±  3%     -83.9%    3526863 ±  7%  softirqs.CPU36.NET_RX
     42736 ±  4%     -47.4%      22478 ± 12%  softirqs.CPU36.RCU
      6250 ±  5%   +1851.9%     122010 ±  3%  softirqs.CPU36.SCHED
  22023460 ±  2%     -83.9%    3536194 ±  7%  softirqs.CPU37.NET_RX
     42264 ±  4%     -47.0%      22390 ± 12%  softirqs.CPU37.RCU
      6251 ±  6%   +1850.8%     121960 ±  3%  softirqs.CPU37.SCHED
  21989677 ±  3%     -83.9%    3548459 ±  7%  softirqs.CPU38.NET_RX
     42359 ±  4%     -46.9%      22489 ± 12%  softirqs.CPU38.RCU
      6075 ± 10%   +1905.1%     121824 ±  3%  softirqs.CPU38.SCHED
  21181146 ±  4%     -83.2%    3555781 ±  7%  softirqs.CPU39.NET_RX
     42381 ±  4%     -47.0%      22448 ± 12%  softirqs.CPU39.RCU
      6288 ±  5%   +1838.7%     121905 ±  3%  softirqs.CPU39.SCHED
  21234461 ±  3%     -84.8%    3232773 ±  6%  softirqs.CPU4.NET_RX
     41094 ±  5%     -45.6%      22375 ± 11%  softirqs.CPU4.RCU
      6400 ± 10%   +1829.9%     123516        softirqs.CPU4.SCHED
  21625431 ±  2%     -83.6%    3549473 ±  7%  softirqs.CPU40.NET_RX
     42390 ±  4%     -46.5%      22698 ± 12%  softirqs.CPU40.RCU
      6249 ±  5%   +1850.9%     121916 ±  3%  softirqs.CPU40.SCHED
  22033392 ±  2%     -84.0%    3524607 ±  7%  softirqs.CPU41.NET_RX
     42784 ±  4%     -47.4%      22517 ± 12%  softirqs.CPU41.RCU
      6271 ±  5%   +1844.2%     121920 ±  3%  softirqs.CPU41.SCHED
  21882934           -83.8%    3543685 ±  7%  softirqs.CPU42.NET_RX
     42866 ±  5%     -47.8%      22382 ± 12%  softirqs.CPU42.RCU
      6293 ±  5%   +1835.9%     121831 ±  3%  softirqs.CPU42.SCHED
  21812590 ±  2%     -83.8%    3540307 ±  7%  softirqs.CPU43.NET_RX
     42608 ±  4%     -47.1%      22523 ± 12%  softirqs.CPU43.RCU
      6295 ±  5%   +1838.9%     122059 ±  3%  softirqs.CPU43.SCHED
  22126669 ±  4%     -83.9%    3553763 ±  7%  softirqs.CPU44.NET_RX
     42511 ±  4%     -46.7%      22650 ± 12%  softirqs.CPU44.RCU
      6177 ±  6%   +1873.7%     121930 ±  3%  softirqs.CPU44.SCHED
  21879826 ±  3%     -83.7%    3555902 ±  7%  softirqs.CPU45.NET_RX
     42813 ±  4%     -47.6%      22438 ± 12%  softirqs.CPU45.RCU
      6279 ±  5%   +1840.8%     121875 ±  3%  softirqs.CPU45.SCHED
  21900318 ±  2%     -83.8%    3538750 ±  7%  softirqs.CPU46.NET_RX
     42820 ±  4%     -47.5%      22485 ± 12%  softirqs.CPU46.RCU
      6373 ±  5%   +1812.3%     121877 ±  3%  softirqs.CPU46.SCHED
  21967147 ±  2%     -83.9%    3535657 ±  7%  softirqs.CPU47.NET_RX
     42849 ±  4%     -47.2%      22609 ± 14%  softirqs.CPU47.RCU
      6273 ±  5%   +1846.6%     122122 ±  3%  softirqs.CPU47.SCHED
  21580165 ±  2%     -83.6%    3548529 ± 16%  softirqs.CPU48.NET_RX
     41466 ±  7%     -46.2%      22312 ± 14%  softirqs.CPU48.RCU
      6443 ±  6%   +1786.2%     121544 ±  3%  softirqs.CPU48.SCHED
  22278431 ±  3%     -83.9%    3593833 ± 16%  softirqs.CPU49.NET_RX
     41258 ±  6%     -45.5%      22496 ± 14%  softirqs.CPU49.RCU
      6345 ±  7%   +1810.5%     121228 ±  3%  softirqs.CPU49.SCHED
  21250066           -84.8%    3225282 ±  6%  softirqs.CPU5.NET_RX
     42368 ±  5%     -46.2%      22813 ± 11%  softirqs.CPU5.RCU
      6452 ± 10%   +1813.3%     123447        softirqs.CPU5.SCHED
  22119799           -83.8%    3590117 ± 16%  softirqs.CPU50.NET_RX
     40998 ±  6%     -45.6%      22285 ± 14%  softirqs.CPU50.RCU
      6331 ±  8%   +1814.3%     121197 ±  3%  softirqs.CPU50.SCHED
  22079153 ±  4%     -83.7%    3600591 ± 15%  softirqs.CPU51.NET_RX
     41134 ±  6%     -45.8%      22290 ± 12%  softirqs.CPU51.RCU
      6289 ±  8%   +1830.0%     121393 ±  3%  softirqs.CPU51.SCHED
  22196382 ±  2%     -83.7%    3609631 ± 15%  softirqs.CPU52.NET_RX
     40474 ±  8%     -45.2%      22187 ± 13%  softirqs.CPU52.RCU
      6311 ±  8%   +1824.4%     121447 ±  3%  softirqs.CPU52.SCHED
  22092811 ±  2%     -83.7%    3608982 ± 16%  softirqs.CPU53.NET_RX
     40984 ±  6%     -46.0%      22113 ± 13%  softirqs.CPU53.RCU
      6295 ±  7%   +1829.4%     121456 ±  3%  softirqs.CPU53.SCHED
  21971811 ±  2%     -83.7%    3577529 ± 15%  softirqs.CPU54.NET_RX
     41234 ±  6%     -46.1%      22243 ± 12%  softirqs.CPU54.RCU
      6359 ±  7%   +1808.7%     121379 ±  3%  softirqs.CPU54.SCHED
  22349548 ±  2%     -83.9%    3594167 ± 15%  softirqs.CPU55.NET_RX
     41318 ±  6%     -46.1%      22261 ± 13%  softirqs.CPU55.RCU
      6289 ±  7%   +1829.7%     121364 ±  3%  softirqs.CPU55.SCHED
  21867767 ±  2%     -83.5%    3605717 ± 15%  softirqs.CPU56.NET_RX
     40836 ±  6%     -46.0%      22043 ± 13%  softirqs.CPU56.RCU
      6366 ±  7%   +1805.6%     121326 ±  3%  softirqs.CPU56.SCHED
  22368570 ±  2%     -83.8%    3613885 ± 15%  softirqs.CPU57.NET_RX
     40641 ±  8%     -45.6%      22100 ± 13%  softirqs.CPU57.RCU
      6312 ±  8%   +1821.9%     121322 ±  3%  softirqs.CPU57.SCHED
  21968019 ±  2%     -83.7%    3582386 ± 15%  softirqs.CPU58.NET_RX
     41023 ±  6%     -46.2%      22088 ± 13%  softirqs.CPU58.RCU
      6281 ±  8%   +1832.7%     121392 ±  3%  softirqs.CPU58.SCHED
  21916818           -83.6%    3586085 ± 15%  softirqs.CPU59.NET_RX
     41053 ±  6%     -46.0%      22174 ± 13%  softirqs.CPU59.RCU
      6295 ±  8%   +1823.7%     121109 ±  4%  softirqs.CPU59.SCHED
  20991089 ±  2%     -84.8%    3188337 ±  5%  softirqs.CPU6.NET_RX
     42243 ±  5%     -47.2%      22315 ± 11%  softirqs.CPU6.RCU
      6471 ±  9%   +1774.2%     121279 ±  5%  softirqs.CPU6.SCHED
  22041840 ±  3%     -83.7%    3586383 ± 15%  softirqs.CPU60.NET_RX
     41099 ±  6%     -46.1%      22143 ± 13%  softirqs.CPU60.RCU
      6302 ±  8%   +1827.1%     121462 ±  3%  softirqs.CPU60.SCHED
  22130826 ±  3%     -83.8%    3594520 ± 15%  softirqs.CPU61.NET_RX
     41201 ±  6%     -46.4%      22097 ± 13%  softirqs.CPU61.RCU
      6314 ±  8%   +1821.3%     121313 ±  3%  softirqs.CPU61.SCHED
  22135635 ±  2%     -83.8%    3590768 ± 15%  softirqs.CPU62.NET_RX
     40926 ±  6%     -46.1%      22072 ± 13%  softirqs.CPU62.RCU
      6326 ±  8%   +1813.3%     121053 ±  3%  softirqs.CPU62.SCHED
  22006279 ±  2%     -83.6%    3613358 ± 15%  softirqs.CPU63.NET_RX
     40812 ±  6%     -46.0%      22052 ± 13%  softirqs.CPU63.RCU
      6289 ±  7%   +1830.4%     121403 ±  3%  softirqs.CPU63.SCHED
  22162502 ±  2%     -83.8%    3596046 ± 15%  softirqs.CPU64.NET_RX
     43354 ±  5%     -48.2%      22462 ± 14%  softirqs.CPU64.RCU
      6298 ±  7%   +1837.0%     122005 ±  3%  softirqs.CPU64.SCHED
  22015775           -83.8%    3575745 ± 15%  softirqs.CPU65.NET_RX
     43464 ±  5%     -49.2%      22086 ± 13%  softirqs.CPU65.RCU
      6270 ±  8%   +1831.5%     121113 ±  3%  softirqs.CPU65.SCHED
  21944987 ±  3%     -83.6%    3597759 ± 15%  softirqs.CPU66.NET_RX
     43140 ±  5%     -47.9%      22485 ± 15%  softirqs.CPU66.RCU
      6282 ±  8%   +1831.3%     121336 ±  3%  softirqs.CPU66.SCHED
  22129685           -83.8%    3577740 ± 15%  softirqs.CPU67.NET_RX
     43165 ±  5%     -48.7%      22158 ± 13%  softirqs.CPU67.RCU
      6445 ±  8%   +1782.4%     121326 ±  3%  softirqs.CPU67.SCHED
  22073607 ±  2%     -83.6%    3609775 ± 15%  softirqs.CPU68.NET_RX
     43285 ±  5%     -48.8%      22146 ± 13%  softirqs.CPU68.RCU
      6304 ±  8%   +1824.2%     121298 ±  3%  softirqs.CPU68.SCHED
  22033082 ±  3%     -83.6%    3614951 ± 15%  softirqs.CPU69.NET_RX
     43557 ±  5%     -49.1%      22170 ± 13%  softirqs.CPU69.RCU
      6300 ±  7%   +1825.1%     121285 ±  3%  softirqs.CPU69.SCHED
  21053089 ±  2%     -84.7%    3212883 ±  6%  softirqs.CPU7.NET_RX
     41729 ±  5%     -46.5%      22329 ± 11%  softirqs.CPU7.RCU
      6348 ±  9%   +1839.3%     123119 ±  2%  softirqs.CPU7.SCHED
  22178413 ±  2%     -83.9%    3577845 ± 15%  softirqs.CPU70.NET_RX
     43599 ±  5%     -49.4%      22076 ± 13%  softirqs.CPU70.RCU
      6317 ±  7%   +1821.0%     121357 ±  3%  softirqs.CPU70.SCHED
  21762871 ±  3%     -83.6%    3579764 ± 15%  softirqs.CPU71.NET_RX
     43364 ±  5%     -48.4%      22369 ± 11%  softirqs.CPU71.RCU
      6382 ±  8%   +1802.1%     121392 ±  3%  softirqs.CPU71.SCHED
  21023350           -83.8%    3409465 ±  2%  softirqs.CPU72.NET_RX
     41025 ±  5%     -46.3%      22023 ± 11%  softirqs.CPU72.RCU
      6814 ± 10%   +1728.9%     124623        softirqs.CPU72.SCHED
  21302700           -84.1%    3394421 ±  3%  softirqs.CPU73.NET_RX
     41214 ±  5%     -46.2%      22189 ± 13%  softirqs.CPU73.RCU
      7056 ± 11%   +1623.5%     121623 ±  5%  softirqs.CPU73.SCHED
  21291105 ±  2%     -83.8%    3456208 ±  2%  softirqs.CPU74.NET_RX
     41637 ±  4%     -47.3%      21930 ± 12%  softirqs.CPU74.RCU
      7027 ±  9%   +1670.0%     124391        softirqs.CPU74.SCHED
  21429155           -83.9%    3457976 ±  2%  softirqs.CPU75.NET_RX
     41568 ±  4%     -47.1%      21979 ± 12%  softirqs.CPU75.RCU
      7044 ± 11%   +1664.6%     124314        softirqs.CPU75.SCHED
  21534196           -83.9%    3473433 ±  2%  softirqs.CPU76.NET_RX
     41485 ±  5%     -47.0%      21999 ± 12%  softirqs.CPU76.RCU
      7002 ± 10%   +1677.6%     124484        softirqs.CPU76.SCHED
  21488531           -83.9%    3456520 ±  2%  softirqs.CPU77.NET_RX
     41562 ±  5%     -47.3%      21889 ± 12%  softirqs.CPU77.RCU
      7070 ± 11%   +1661.2%     124528        softirqs.CPU77.SCHED
  21287664 ±  2%     -83.8%    3440745 ±  2%  softirqs.CPU78.NET_RX
     41481 ±  5%     -46.3%      22274 ± 10%  softirqs.CPU78.RCU
      7055 ± 11%   +1663.8%     124437        softirqs.CPU78.SCHED
  21590981           -84.0%    3458262 ±  2%  softirqs.CPU79.NET_RX
     41251 ±  5%     -46.4%      22115 ± 11%  softirqs.CPU79.RCU
      6734 ± 19%   +1747.5%     124419        softirqs.CPU79.SCHED
  21204994 ±  2%     -84.7%    3235256 ±  6%  softirqs.CPU8.NET_RX
     41695 ±  5%     -46.2%      22415 ± 11%  softirqs.CPU8.RCU
      6459 ±  9%   +1809.6%     123346 ±  2%  softirqs.CPU8.SCHED
  21455564           -83.8%    3470203 ±  2%  softirqs.CPU80.NET_RX
     42032 ±  4%     -47.6%      22026 ± 12%  softirqs.CPU80.RCU
      7050 ± 10%   +1664.9%     124440        softirqs.CPU80.SCHED
  21494599           -83.9%    3461317 ±  2%  softirqs.CPU81.NET_RX
     41056 ±  6%     -46.1%      22136 ± 11%  softirqs.CPU81.RCU
      6993 ± 10%   +1678.7%     124400        softirqs.CPU81.SCHED
  21500966           -84.0%    3441797 ±  2%  softirqs.CPU82.NET_RX
     40872 ±  5%     -46.2%      21975 ± 12%  softirqs.CPU82.RCU
      6986 ± 10%   +1683.8%     124620        softirqs.CPU82.SCHED
  21415846           -83.9%    3443443 ±  2%  softirqs.CPU83.NET_RX
     41213 ±  5%     -46.8%      21944 ± 12%  softirqs.CPU83.RCU
      6971 ± 11%   +1684.8%     124431        softirqs.CPU83.SCHED
  21158286           -83.7%    3448499 ±  2%  softirqs.CPU84.NET_RX
     41129 ±  5%     -46.6%      21967 ± 12%  softirqs.CPU84.RCU
      6981 ± 11%   +1682.7%     124461        softirqs.CPU84.SCHED
  21275952           -84.4%    3327058 ±  9%  softirqs.CPU85.NET_RX
     41193 ±  5%     -46.5%      22035 ± 12%  softirqs.CPU85.RCU
      7038 ± 11%   +1593.4%     119196 ±  9%  softirqs.CPU85.SCHED
  21456851           -83.8%    3474753 ±  2%  softirqs.CPU86.NET_RX
     41007 ±  5%     -46.2%      22074 ± 12%  softirqs.CPU86.RCU
      7009 ± 11%   +1675.5%     124444        softirqs.CPU86.SCHED
  21294686           -83.7%    3465753 ±  2%  softirqs.CPU87.NET_RX
     41176 ±  5%     -46.6%      21995 ± 11%  softirqs.CPU87.RCU
      6978 ± 12%   +1682.5%     124390        softirqs.CPU87.SCHED
  21345812           -83.8%    3460006 ±  2%  softirqs.CPU88.NET_RX
     41353 ±  5%     -46.8%      22012 ± 11%  softirqs.CPU88.RCU
      7042 ± 11%   +1665.8%     124353        softirqs.CPU88.SCHED
  21158849           -83.6%    3462986 ±  2%  softirqs.CPU89.NET_RX
     40857 ±  5%     -45.6%      22224 ± 12%  softirqs.CPU89.RCU
      7006 ± 11%   +1676.5%     124461        softirqs.CPU89.SCHED
  21346273           -84.8%    3245033 ±  6%  softirqs.CPU9.NET_RX
     41949 ±  5%     -46.7%      22367 ± 12%  softirqs.CPU9.RCU
      6324 ± 11%   +1852.5%     123483        softirqs.CPU9.SCHED
  21316413           -83.9%    3424944 ±  2%  softirqs.CPU90.NET_RX
     41279 ±  5%     -46.8%      21944 ± 12%  softirqs.CPU90.RCU
      6992 ± 10%   +1666.1%     123502        softirqs.CPU90.SCHED
  21383881           -83.8%    3456891 ±  2%  softirqs.CPU91.NET_RX
     41176 ±  6%     -46.5%      22022 ± 11%  softirqs.CPU91.RCU
      7075 ±  9%   +1661.4%     124635        softirqs.CPU91.SCHED
  21450268           -83.8%    3471616 ±  2%  softirqs.CPU92.NET_RX
     41127 ±  5%     -46.7%      21927 ± 12%  softirqs.CPU92.RCU
      7017 ± 10%   +1672.8%     124406        softirqs.CPU92.SCHED
  21340125 ±  2%     -83.7%    3469370 ±  2%  softirqs.CPU93.NET_RX
     40908 ±  5%     -46.2%      22002 ± 12%  softirqs.CPU93.RCU
      6971 ± 11%   +1685.2%     124450        softirqs.CPU93.SCHED
  21331962           -83.8%    3446801 ±  2%  softirqs.CPU94.NET_RX
     40770 ±  5%     -46.2%      21950 ± 12%  softirqs.CPU94.RCU
      7047 ± 10%   +1663.5%     124287        softirqs.CPU94.SCHED
  21284890 ±  2%     -83.8%    3438859 ±  2%  softirqs.CPU95.NET_RX
     40912 ±  6%     -46.2%      22018 ± 11%  softirqs.CPU95.RCU
      6982 ± 11%   +1653.8%     122454        softirqs.CPU95.SCHED
  20868761 ±  2%     -85.3%    3065044 ± 10%  softirqs.CPU96.NET_RX
     41941 ±  6%     -47.7%      21950 ± 11%  softirqs.CPU96.RCU
      6293 ± 10%   +1753.4%     116642 ±  9%  softirqs.CPU96.SCHED
  21024160 ±  2%     -84.7%    3207450 ±  6%  softirqs.CPU97.NET_RX
     41240 ±  7%     -46.6%      22022 ± 11%  softirqs.CPU97.RCU
      6305 ±  4%   +1850.6%     122997 ±  2%  softirqs.CPU97.SCHED
  21004489 ±  2%     -85.0%    3153700 ± 12%  softirqs.CPU98.NET_RX
     41611 ±  5%     -46.7%      22165 ± 12%  softirqs.CPU98.RCU
      6416 ±  9%   +1758.5%     119241 ±  6%  softirqs.CPU98.SCHED
  20862992 ±  2%     -84.4%    3247430 ±  6%  softirqs.CPU99.NET_RX
     41777 ±  5%     -47.0%      22123 ± 12%  softirqs.CPU99.RCU
      6486 ±  8%   +1805.9%     123621        softirqs.CPU99.SCHED
 4.146e+09           -84.0%  6.626e+08 ±  3%  softirqs.NET_RX
   8087068 ±  5%     -47.4%    4255788 ± 12%  softirqs.RCU
   1254695 ±  6%   +1775.7%   23534258        softirqs.SCHED
    737871           -94.0%      44540 ± 11%  softirqs.TIMER


                                                                                
                               netperf.Throughput_tps                           
                                                                                
  40000 +-------------------------------------------------------------------+   
        |+      + +. ++ +  +            + .+       +                + +   ++|   
  35000 |-++++++ +  +  +: + ++++++++++++ +  +++++++ +++++++++++++.++ + +++  |   
  30000 |-+             : :                                                 |   
        |               : :                                                 |   
  25000 |-+             : :                                                 |   
        |               : :                                                 |   
  20000 |-+             : :                                                 |   
        |                ::                                                 |   
  15000 |-+              :                                                  |   
  10000 |-+              :                                                  |   
        |                :                                                  |   
   5000 |OOOOOOOOOO OOOOO:OOO                                               |   
        |                :                                                  |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             netperf.Throughput_total_tps                       
                                                                                
  1.6e+07 +-----------------------------------------------------------------+   
          |                                                                 |   
  1.4e+07 |+++++++++++++++ ++++++++++++++++.++++++++++++++++++++++++++++++++|   
  1.2e+07 |-+            : :                                                |   
          |              : :                                                |   
    1e+07 |-+            : :                                                |   
          |              : :                                                |   
    8e+06 |-+            : :                                                |   
          |               ::                                                |   
    6e+06 |-+             :                                                 |   
    4e+06 |-+             :                                                 |   
          |               :                                                 |   
    2e+06 |OOOOOOOOOOOOOOO:OOO                                              |   
          |               :                                                 |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                   netperf.workload                             
                                                                                
  4.5e+09 +-----------------------------------------------------------------+   
          |+++++++++++++++ ++++++++++++++++.++++++++++++++++++++ +++++++++++|   
    4e+09 |-+            : :                                    +           |   
  3.5e+09 |-+            : :                                                |   
          |              : :                                                |   
    3e+09 |-+            : :                                                |   
  2.5e+09 |-+            : :                                                |   
          |              : :                                                |   
    2e+09 |-+             :                                                 |   
  1.5e+09 |-+             :                                                 |   
          |               :                                                 |   
    1e+09 |-+             :                                                 |   
    5e+08 |OOOOOOOOOOOOOOO:OOO                                              |   
          |               :                                                 |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              netperf.time.user_time                            
                                                                                
  1400 +--------------------------------------------------------------------+   
       |++++++++.  +++++ + + +  +.+       +++++++ .+++++++++ ++ ++ .++++++++|   
  1200 |-+       ++    : :+ + ++   +++++++       +          +  +  +         |   
       |               : :                                                  |   
  1000 |-+             : :                                                  |   
       |               : :                                                  |   
   800 |-+             : :                                                  |   
       |               : :                                                  |   
   600 |-+              :                                                   |   
       |                :                                                   |   
   400 |-+           O  :  O                                                |   
       |OOOOOOOO OOOO OO:OO                                                 |   
   200 |-+              :                                                   |   
       |                :                                                   |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              netperf.time.system_time                          
                                                                                
  20000 +-------------------------------------------------------------------+   
  18000 |+++ ++++  .+++++ ++++++ +++ + + +.+++ +++++++ ++++ +++++.++++++ +++|   
        |   +    ++     : :     +   + + +     +       +                     |   
  16000 |-+             : :                                                 |   
  14000 |-+             : :                                                 |   
        |               : :                                                 |   
  12000 |-+             : :                                                 |   
  10000 |-+             : :                                                 |   
   8000 |OOOOOOOOOO OOOOO:OOO                                               |   
        |                :                                                  |   
   6000 |-+              :                                                  |   
   4000 |-+              :                                                  |   
        |                :                                                  |   
   2000 |-+              :                                                  |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     netperf.time.percent_of_cpu_this_job_got                   
                                                                                
  7000 +--------------------------------------------------------------------+   
       |+++ ++++.+ +++++ ++++++ +.++++ + ++++ ++++.+++ ++++ +++++++.++++ + +|   
  6000 |-+ +      +    : :     +      + +    +        +                     |   
       |               : :                                                  |   
  5000 |-+             : :                                                  |   
       |               : :                                                  |   
  4000 |-+             : :                                                  |   
       |               : :                                                  |   
  3000 |OOOOOOOO OOOOOOO:OOO                                                |   
       |                :                                                   |   
  2000 |-+              :                                                   |   
       |                :                                                   |   
  1000 |-+              :                                                   |   
       |                :                                                   |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                           netperf.time.minor_page_faults                       
                                                                                
  140000 +------------------------------------------------------------------+   
         |OOOOOOOOOOOOOOOO OOO                                              |   
  120000 |-+                                                                |   
         |+++++++++++++++  ++++++++++++++++++++++++++++++++.++++++++++++++++|   
  100000 |-+            :  :                                                |   
         |              :  :                                                |   
   80000 |-+            : :                                                 |   
         |              : :                                                 |   
   60000 |-+            : :                                                 |   
         |               ::                                                 |   
   40000 |-+             ::                                                 |   
         |               ::                                                 |   
   20000 |-+             :                                                  |   
         |               :                                                  |   
       0 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                        netperf.time.voluntary_context_switches                 
                                                                                
    3e+09 +-----------------------------------------------------------------+   
          |                                                                 |   
  2.5e+09 |-+ +                  +       +     +       +                    |   
          |   ::+  ++       +    ::+ + + :+.   ::+ +   ::+          +       |   
          |++: + :+  :++   + ++++ + + + :   ++: + ::++: + :+ +++   + +++ + +|   
    2e+09 |-++   +   +  ++ :            +     +   +   +   + ::  +++     ::+ |   
          |              : :                                +           +   |   
  1.5e+09 |-+            : :                                                |   
          |              : :                                                |   
    1e+09 |-+            : :                                                |   
          |               :                                                 |   
          |OOOOOOOOOOOOOOO:OOO                                              |   
    5e+08 |-+             :                                                 |   
          |               :                                                 |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       netperf.time.involuntary_context_switches                
                                                                                
  2.5e+09 +-----------------------------------------------------------------+   
          |                                                 +    +      + + |   
          |  +       ++ ++              +     +       +     ::   :+     : ::|   
    2e+09 |++: + ++  : + : +  +     + + :  .++: + + ++: + ++ ++++  + +++ : +|   
          |   ::+  +:    : :++ ++ ++ + : :+    ::+ +   ::+          +    +  |   
          |   +     +    : :     +     + ::    +       +                    |   
  1.5e+09 |-+            : :             +                                  |   
          |              : :                                                |   
    1e+09 |-+             ::                                                |   
          |               :                                                 |   
          |               :                                                 |   
    5e+08 |-+             :                                                 |   
          |               :                                                 |   
          |               :                                                 |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                          perf-sched.total_wait_time.max.ms                     
                                                                                
  14000 +-------------------------------------------------------------------+   
        |                                                                   |   
  12000 |-+               +                                    +        +  +|   
        |   ++       ++   :+  +    + + +      ++      ++  ++ ++ +.+   ++ : :|   
  10000 |+++  +++++.+  ++ : ++ ++++ + + ++.+++  ++++++  ++  +      +++   ++ |   
        |               : :                                                 |   
   8000 |-+             : :                                                 |   
        |               : :                                                 |   
   6000 |-+             : :                                                 |   
        |                :                                                  |   
   4000 |-+              :                                                  |   
        |                :                                                  |   
   2000 |-+              :                                                  |   
        |                :                                                  |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       perf-sched.total_wait_time.average.ms                    
                                                                                
    2 +---------------------------------------------------------------------+   
  1.8 |-+ + +                          +     + +     +  +   +               |   
      |   : ::    +   +           +    :     : :     :  :   :  ++       +   |   
  1.6 |-+ ::::   + : +: +       ++ : + ::    ::::    ::: :+ :: :: + +  + +  |   
  1.4 |-+: :  :+ : ++ : ::    + :  ++ : +. +: : :+ +: :: ::: ::  ::::+ :  + |   
      |+ + +  + +     : :++. + +      +   + + + + + + +  + + ++  + +  +    :|   
  1.2 |-+             : :   +                                              +|   
    1 |-+             : :                                                   |   
  0.8 |-+              ::                                                   |   
      |                :                                                    |   
  0.6 |-+              :                                                    |   
  0.4 |-+              :                                                    |   
      |                :                                                    |   
  0.2 |-+              :                                                    |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                          perf-sched.total_sch_delay.max.ms                     
                                                                                
  12000 +-------------------------------------------------------------------+   
        |    +                                 +       +                    |   
  10000 |-+  :                                 :       :   +          +     |   
        |    :            +         +          :       :   ::         :     |   
        |    ::           :         :+ +       ::      :: + +         :     |   
   8000 |-+ : :       +   :       + : + :     : :     : : : : +      : :++  |   
        |   : ++  +.+ :++ ::      ::    +     : ++    : ++  : : +.+  : :: : |   
   6000 |-+ +  : +   :  : ::     + +     +  + +   + + +      ::::  + + +  + |   
        | :+    ::   +  : :++  ++         : :+    : :+       : +    +      +|   
   4000 |:+     +       ::   : :          ::       :         +              |   
        |+               :   ++            +       +                        |   
        |                :                                                  |   
   2000 |-+              :                                                  |   
        |                :                                                  |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       perf-sched.total_sch_delay.average.ms                    
                                                                                
   0.3 +--------------------------------------------------------------------+   
       |     +                                 +        +                +  |   
  0.25 |-+ + :         +                +    + :      + :   +           +:  |   
       |   : ::   ++  +:         .++    ::   : ::     : ::+ :  +  +     : : |   
       |  : : :   : + :: +    + +   :++: +  : : :+.  : : ::: : :+ :: + +  : |   
   0.2 |+++ + ++.:   + : ::   :::   +  +  +++ + +  +++ + + + ::  : : :+   + |   
       |         +     : :++++ +                             ++  +  +      +|   
  0.15 |-+             : :                                                  |   
       |                ::                                                  |   
   0.1 |-+              ::                                                  |   
       |                :                                                   |   
       |                :                                                   |   
  0.05 |-+              :                                                   |   
       |                :                                                   |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      perf-sched.total_wait_and_delay.count.ms                  
                                                                                
  8e+06 +-------------------------------------------------------------------+   
        |                                                                  :|   
  7e+06 |-+  +             ++++ +      +       +       +   + ++   +   +   : |   
  6e+06 |+++ : + +   ++   +    +:   ++ :   +++ : + +++ : + : ::  :: + :   + |   
        |: : :::::   : :  :      :  : : : +  : ::::: : :::: :: : : ::: :  : |   
  5e+06 |-+ : : + : :  +  :      +++  + :+    : : +   : : + :  ++  + + +++  |   
        |   + +   +.+   + :             +     + +     + +   +               |   
  4e+06 |-+             : :                                                 |   
        |               : :                                                 |   
  3e+06 |-+             ::                                                  |   
  2e+06 |-+              :                                                  |   
        |                :                                                  |   
  1e+06 |-+              :                                                  |   
        |                :                                                  |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       perf-sched.total_wait_and_delay.max.ms                   
                                                                                
  25000 +-------------------------------------------------------------------+   
        |    +                                 +       +                    |   
        |    :                                 :       :                    |   
  20000 |-+  :                      +          :       :              +     |   
        |    ::       +             :          ::      :: +           :     |   
        |   : :       :           + :         : :     : : : +         ::++  |   
  15000 |-+ : :    .+ ::+         :: :  +     : :     : :: ::   +   +: :::  |   
        |   : +++ +  : +: +     ++ : :++ +.   : +++   : ++ : : + + + + +  : |   
  10000 |++++    +   +  : :+ +++   + +     ++++    ++++    + ++   +       ++|   
        |               : : +                                               |   
        |                ::                                                 |   
   5000 |-+              :                                                  |   
        |                :                                                  |   
        |                :                                                  |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    perf-sched.total_wait_and_delay.average.ms                  
                                                                                
  2.5 +---------------------------------------------------------------------+   
      |                                                                     |   
      |   + +                          +     + +     +  +   +               |   
    2 |-+ : ::    +   +           +    :     : :     :  :   :  ++ +     +   |   
      |   ::::   + : +: +       ++ : + ::    ::::    ::: :+ :: :: : +  + +  |   
      | +: :  ++ : ++ : ::    + :  ++ : +. +: : ++ +: :: + : ::  : ::+ :  + |   
  1.5 |+++ +    +     : :++.++ +      +   + + +   + + +    + ++  + +  +    +|   
      |               : :                                                   |   
    1 |-+             : :                                                   |   
      |                ::                                                   |   
      |                :                                                    |   
  0.5 |-+              :                                                    |   
      |                :                                                    |   
      |                :                                                    |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  10000 +-------------------------------------------------------------------+   
   9000 |-+                                               :             ::  |   
        |                                                 : +          : ++ |   
   8000 |-+         +  ++         + +                    : ::        + +  : |   
   7000 |-+ + +    + : ::      +  : :++ +     + +     + +: ::   +    : :  : |   
        |   :+ ++ +  + :: +   + ++ :   + +    :+ ++   :+ + + :  ::   :::   :|   
   6000 |:+:     ::   : : :   :    +      +  :     : :       : : : +: :    :|   
   5000 |+++     +    + : :: +             +++     +++       : +  + + +    :|   
   4000 |-+             : :++                                ++            +|   
        |                ::                                                 |   
   3000 |-+              :                                                  |   
   2000 |-+              :                                                  |   
        |                :                                                  |   
   1000 |-+              :                                                  |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  1.6 +---------------------------------------------------------------------+   
      |   + +                                + +     +  +                   |   
  1.4 |-+ : ::    +   +                +     : :     :  :   +           ++  |   
  1.2 |-+ ::::   + : +:           +  + ::    ::::    ::: :+ :  ++ +     ::  |   
      | +: :  :+ : + :: +     + ++ ++ : +. +: : :+ +: :: ::: : : :::+. +  : |   
    1 |+++ +  + +   + : ::   + ::     +   + + + + + + +  + + ::  + +  +   + |   
      |               : :++.+  +                             ++            +|   
  0.8 |-+             : :                                                   |   
      |                ::                                                   |   
  0.6 |-+              ::                                                   |   
  0.4 |-+              :                                                    |   
      |                :                                                    |   
  0.2 |-+              :                                                    |   
      |                :                                                    |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  9000 +--------------------------------------------------------------------+   
       |                          +                       + +               |   
  8000 |-+                        :                       : :           ++  |   
  7000 |-+         +   +         : :    +                 :::   +       ::  |   
       |    ++     :  +: +       : :+  +:     ++       ++ :: :  :    + :  : |   
  6000 |-+ + :    + : :: :      +  + :+  :   + :      + :: + :  ::+  : +  + |   
  5000 |-+ :  :  +  + :: ::    +     +   +   :  :+    :  :   : : + +: ::   :|   
       | ++   + +    : : ::   +          : ++   + : ++   +   +++    + :    +|   
  4000 |::     +     + : :+  +            ::      : :                 +     |   
  3000 |++              :: ++             +        +                        |   
       |                :                                                   |   
  2000 |-+              :                                                   |   
  1000 |-+              :                                                   |   
       |                :                                                   |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.6 +---------------------------------------------------------------------+   
      |                                                                     |   
  0.5 |-+ + +         +                +     + +     +  +   +               |   
      |   : ::    +   :           +    ::    : :     :  :   :  +  +     ++  |   
      |   ::::   + : +: +       ++ : + :+.   ::::+   ::: :+ :: :+ : +  +  : |   
  0.4 |++: :  ++ : ++ : ::    + :  ++ :   ++: : + ++: :: + : ::  : ::+ :  + |   
      |  + +    +     : :+ .++ +      +     + +     + +    + ++  + +  +    +|   
  0.3 |-+             : : +                                                 |   
      |                ::                                                   |   
  0.2 |-+              ::                                                   |   
      |                :                                                    |   
      |                :                                                    |   
  0.1 |-+              :                                                    |   
      |                :                                                    |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
    4e+06 +-----------------------------------------------------------------+   
          |                                                                :|   
  3.5e+06 |-+  +            ++++ +      +       +       +   + ++  +   +   : |   
    3e+06 |+++ : + +  ++   +    +:   ++ :   +++ : + +++ : + : ::  : + :   + |   
          |: : :::::  : :  :      :  : : : +  : ::::: : :::: :: :: ::: :  : |   
  2.5e+06 |-+ : : + ::  +  :      +++  + :+    : : +   : : + :  ++ + + +++  |   
          |   + +   ++   + :             +     + +     + +   +              |   
    2e+06 |-+            : :                                                |   
          |              : :                                                |   
  1.5e+06 |-+            ::                                                 |   
    1e+06 |-+             :                                                 |   
          |               :                                                 |   
   500000 |-+             :                                                 |   
          |               :                                                 |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  18000 +-------------------------------------------------------------------+   
        |                         +                       : +               |   
  16000 |-+             +         :                       : :           ++  |   
  14000 |-+         +   :         ::    +                 :::   +       ::  |   
        |    ++    +:  +: +      : :+  +:      ++      ++: : :  ::   + :  : |   
  12000 |-+ +  :  +  : :: :     ++ + ++  :    +  :    +  : + :  :: + : +  + |   
  10000 |-+ :  + +   + :: ::    :        +    :  ++   :  +   : :  + : ::   :|   
        | ++    ::    : : ::   +          : ++    : ++       +++    + :    +|   
   8000 |::     +     +  ::+  +           : :      ::                 +     |   
   6000 |++              :: ++             +       +                        |   
        |                :                                                  |   
   4000 |-+              :                                                  |   
   2000 |-+              :                                                  |   
        |                :                                                  |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  2.5 +---------------------------------------------------------------------+   
      |                                                                     |   
      |                                                                     |   
    2 |-+ + +         +                +     + +     +  +   +               |   
      |   : ::   ++  +:           +    ::    : :     : :: + :  ++ +     ++  |   
      |  : : :   : + :: +       ++ :++ :+.  : : :+  : :: ::: : :: : +  +  : |   
  1.5 |+++ +  +++   + : ::    + :  +  :   +++ + + +++ +  + + ::  : ::+ :  + |   
      |               : :++.++ +      +                      ++  + +  +    +|   
    1 |-+             : :                                                   |   
      |                ::                                                   |   
      |                :                                                    |   
  0.5 |-+              :                                                    |   
      |                :                                                    |   
      |                :                                                    |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  10000 +-------------------------------------------------------------------+   
   9000 |-+                                                             :   |   
        |         +.                                                    ::  |   
   8000 |-+       : +                                     +            : +  |   
   7000 |-+ + +   : :   +    +          ++    + + +   + + ::   ++    + +  : |   
        |   : : +:   : +:    :   ++ + + : :   : : :   : : :++  : : + : :  + |   
   6000 |:+ ::::::   :+ :    ::+ : + + :  :   :::: :  ::::  :  : : :: ::  : |   
   5000 |++: : + +   +  : + : + +      +   ++: : + ++: : +   ::   : + :    :|   
   4000 |-++ +          : :++                + +     + +     ::   +   +    :|   
        |                ::                                  ++            +|   
   3000 |-+              ::                                                 |   
   2000 |-+              :                                                  |   
        |                :                                                  |   
   1000 |-+              :                                                  |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  1.4 +---------------------------------------------------------------------+   
      |                                                                     |   
  1.2 |-+ + +         +                +     + +     +  +   +               |   
      |   : ::   ++   :           +    ::    : :     :  : + :  ++ +     +   |   
    1 |-+ ::::   : : +: +       ++ : + :+    ::::+   ::: :: :: :: ::+  + +  |   
      |:+: :  +++  ++ : ::    + :  ++ :  + +: : + :+: :: + : ::  : + + :  + |   
  0.8 |+++ +          : :++.++ +      +   + + +   + + +    + ++  +    +    :|   
      |               : :                                                  +|   
  0.6 |-+              ::                                                   |   
      |                ::                                                   |   
  0.4 |-+              :                                                    |   
      |                :                                                    |   
  0.2 |-+              :                                                    |   
      |                :                                                    |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  7000 +--------------------------------------------------------------------+   
       |     +                                 +        +                   |   
  6000 |-+   :        +           +            :        :                   |   
       |     :        :       +   :            :        :               +   |   
  5000 |-+ + :        ::      :  ::          + :      + :              + +  |   
       |   : ::      : +      :  : :         : ::     : ::+           +  :  |   
  4000 |-+ :: :    +++ :      ::+  :+        :: :     :: ::    +      :  :  |   
       | +: : :   +    : +   : ::  + + +   +: : :   +: : :::+  :+ +   :   : |   
  3000 |-:: : :+  :    : :   : +      ::+  :: : :   :: : : ::+ : + : :    :+|   
       | :+ + + : :    : ::+ +        +  : :+ + +   :+ + + +  :    : :    ::|   
  2000 |:+      ::      ::::::           +:      +.:          +     :+    + |   
       |+        +      : + +             +        +                +       |   
  1000 |-+              :                                                   |   
       |                :                                                   |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
    4e+06 +-----------------------------------------------------------------+   
          |                                                                :|   
  3.5e+06 |-+  +            ++++ +      +       +       +   + ++  +   +   : |   
    3e+06 |+++ : + +  ++   +    +:   ++ :   +++ : + +++ : + : ::  : + :   + |   
          |: : :::::  : :  :      :  : : : +  : ::::: : :::: :: :: ::: :  : |   
  2.5e+06 |-+ : : + ::  +  :      +++  + :+    : : +   : : + :  ++ + + +++  |   
          |   + +   ++   + :             +     + +     + +   +              |   
    2e+06 |-+            : :                                                |   
          |              : :                                                |   
  1.5e+06 |-+            ::                                                 |   
    1e+06 |-+             :                                                 |   
          |               :                                                 |   
   500000 |-+             :                                                 |   
          |               :                                                 |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  14000 +-------------------------------------------------------------------+   
        |     +                                 +       +                   |   
  12000 |-+   :        +          +             :       :                   |   
        |     :        :       +  :             :       :              +++  |   
  10000 |-+ + :        ::      :  ::          + :     + :              : :  |   
        |   : ::      : +      ::: :          : ::    : ::+     +     +   : |   
   8000 |-+ :: :  +.+++ :    + :++ ++         :: :    :: ::    + +    :   + |   
        | +: : :  :     : +  ::      + +++  +: : :+ +: : :::+  :  ++ +     :|   
   6000 |::+ : :+:      : : : :       +   + :+ : ::::+ : : + + :    ::     +|   
        |+   + + +      : ::+ +            +   + + +   + +    :     +       |   
   4000 |-+              ::+                                  +             |   
        |                :                                                  |   
   2000 |-+              :                                                  |   
        |                :                                                  |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  1.4 +---------------------------------------------------------------------+   
      |                                +                                    |   
  1.2 |-+ + +         +                :     + +     +  +   +           +   |   
      |   : ::   ++   :           +    ::    : :     :  : + :  ++ +     ::  |   
    1 |-+ ::::   : + +: +       ++ : +: +.   ::::+   ::: :: :: :: ::+  + ++ |   
      |++: :  +++   + : ::    + :  ++ :   ++: : + ++: :: + : ::  : + + :  : |   
  0.8 |-++ +          : :++.++ +      +     + +     + +    + ++  +    +    :|   
      |               : :                                                  +|   
  0.6 |-+              ::                                                   |   
      |                ::                                                   |   
  0.4 |-+              :                                                    |   
      |                :                                                    |   
  0.2 |-+              :                                                    |   
      |                :                                                    |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
         perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork    
                                                                                
  14000 +-------------------------------------------------------------------+   
        |                                                                   |   
  12000 |-+               +                                    +        +  +|   
        |   ++       ++   :+  +    + + +      ++      ++  ++ ++ +.+   ++ : :|   
  10000 |+++  +++++.+  ++ : ++ ++++ + + ++.+++  ++++++  ++  +      +++   ++ |   
        |               : :                                                 |   
   8000 |-+             : :                                                 |   
        |               : :                                                 |   
   6000 |-+             : :                                                 |   
        |                :                                                  |   
   4000 |-+              :                                                  |   
        |                :                                                  |   
   2000 |-+              :                                                  |   
        |                :                                                  |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork     
                                                                                
  350 +---------------------------------------------------------------------+   
      |                                                                     |   
  300 |-+ +           +           +          +       +      +           ++  |   
      |++ ::      +++ :       +  + :   +  ++ ::   ++ ::   + :   +   +.  : : |   
  250 |:++ +   +  :  +: +     ::+  + + ::+  + +   : + +   :: : + :++  ++  ++|   
      |     :.+ : :   : ::   + +    ::+ +      :++     + + + + : +          |   
  200 |-+   +   +:    : :++.+       +          +        +     +             |   
      |          +    : :                                                   |   
  150 |-+              ::                                                   |   
      |                ::                                                   |   
  100 |-+              :                                                    |   
      |                :                                                    |   
   50 |-+              :                                                    |   
      |                :                                                    |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
       perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork  
                                                                                
  14000 +-------------------------------------------------------------------+   
        |                                                     +             |   
  12000 |-+       +         ++       + +                   + +:   +         |   
        |    +   +:        +  + +    : :       +       +   : : : : :  +     |   
  10000 |-+  :++ : : +    +    :::  + : :      :++     :++: :: + : +  ::  ++|   
        | ++ :  :  : :++  :    + + +  + :+. ++ :  + ++ :  + :   +   ++ ++ : |   
   8000 |++ :   +   :   : :       +     +  +  :    +  :     +            :  |   
        |   +       +   + :                   +       +                  +  |   
   6000 |-+             : :                                                 |   
        |               : :                                                 |   
   4000 |-+             ::                                                  |   
        |                :                                                  |   
   2000 |-+              :                                                  |   
        |                :                                                  |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
      perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork  
                                                                                
  14000 +-------------------------------------------------------------------+   
        |                                                                   |   
  12000 |-+               +                                    +        +  +|   
        |   ++       ++   :+  +    + + +      ++      ++  ++ ++ +.+   ++ : :|   
  10000 |+++  +++++.+  ++ : ++ ++++ + + ++.+++  ++++++  ++  +      +++   ++ |   
        |               : :                                                 |   
   8000 |-+             : :                                                 |   
        |               : :                                                 |   
   6000 |-+             : :                                                 |   
        |                :                                                  |   
   4000 |-+              :                                                  |   
        |                :                                                  |   
   2000 |-+              :                                                  |   
        |                :                                                  |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
     perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork   
                                                                                
  350 +---------------------------------------------------------------------+   
      |                                                                     |   
  300 |-+ +           +           +          +       +      +           ++  |   
      |++ ::      +++ :       +  + :   +  ++ ::   ++ ::   + :   +   +.  : : |   
  250 |:++ +   +  :  +: +     ::+  + + ::+  + +   : + +   :: : + :++  ++  ++|   
      |     :.+ : :   : ::   + +    ::+ +      :++     + + + + : +          |   
  200 |-+   +   +:    : :++.+       +          +        +     +             |   
      |          +    : :                                                   |   
  150 |-+              ::                                                   |   
      |                ::                                                   |   
  100 |-+              :                                                    |   
      |                :                                                    |   
   50 |-+              :                                                    |   
      |                :                                                    |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  140 +---------------------------------------------------------------------+   
      |                                                       +             |   
  120 |-+       ++                                            :            +|   
      | +  +  + ::           +             +  + +  +  +  +    :  + +       :|   
  100 |-:  :  :: :          +: +           :  : :  :  :: ::   :: : :      ::|   
      | :  ::: +  :     +  : : :   ++      :  :::  :  :: :+  : : : :      + |   
   80 |:+:: ::    :     :+ :  ::   :: +   : :: : :: ::  :  : : :: : :     : |   
      |: :: +     + +   : +   : :  : ::   : :: + :: ::  +  + + ++ : :   + : |   
   60 |++:+        ::+  :     + :  : +:  .+ :+   :+ :+     : :    + +. + :  |   
      |  +         +  : :       + :    :+   +    +  +       :         +  +  |   
   40 |-+             +:         +:    ::                   +               |   
      |               ::          +    +                                    |   
   20 |-+              :                                                    |   
      |                :                                                    |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
          perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork       
                                                                                
  8000 +--------------------------------------------------------------------+   
       |                                                   +                |   
  7000 |-+                                                 :                |   
  6000 |-+                                                 :                |   
       |               +                                   :                |   
  5000 |-+             :             +                     :               +|   
       |               :             :                     :               :|   
  4000 |-+             :             :                     :             + :|   
       |               :             :                    : :            : :|   
  3000 |-+             ::     +      :                    : :         +  : :|   
  2000 |-+            : :     :     : :                   : :         :  :: |   
       |              : :     :     : :                   : :         : : : |   
  1000 |-+            : :    : :    : :+                  : :        : :: : |   
       |           +  : :    : :    : :::                 + :        : :: : |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
          perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork       
                                                                                
  1000 +--------------------------------------------------------------------+   
   900 |-+                                                                 +|   
       |                                                                   :|   
   800 |-+                                                                 :|   
   700 |-+                                                                 :|   
       |                                                                   :|   
   600 |-+                                                                 :|   
   500 |-+                                                                 :|   
   400 |-+                                                                : |   
       |                                                                  : |   
   300 |-+                                                 +              : |   
   200 |-+             +                                   :             +: |   
       |               :             +                     ::            :: |   
   100 |-+         +  : :     +      ::+                  : :         + : : |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
       perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork      
                                                                                
  60 +----------------------------------------------------------------------+   
     |         +           +          +                                     |   
  50 |-+       :           :          :                              +      |   
     |         :          ::  +       :                              ::     |   
     |         :          + : :  +    :                              ::    +|   
  40 |-+  +    ::        +  :+:  :   ::      +        +              : ++  :|   
     |   + :  : :+       :  :: :: :.+: :+   + :  +   +:       +     :   : : |   
  30 |++ : :  : ::  ++  +   +  :+ +  : ::+  : :  :+  : :  .+  :: + +:   : + |   
     | ++   + : +:  ::  :      ::    + :: ++   +:  ++  + + : : + :+ +    :: |   
  20 |-+     +:  : : : :       +       :        +       +   :+  +        :  |   
     |        +   :+ : :               +                    +            +  |   
     |            ::  ::                                                    |   
  10 |-+          ::  ::                                                    |   
     |            :   :                                                     |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  800 +---------------------------------------------------------------------+   
      |                                                      +              |   
  700 |-+                                                    :              |   
  600 |-+                                                    :              |   
      |                                                      :              |   
  500 |-+                                                    :              |   
      |                                                      :              |   
  400 |-+                                                    :              |   
      |                                                     : :             |   
  300 |-+                                                   : :             |   
  200 |-+                                                   : :             |   
      |                                                     : :             |   
  100 |-+                                                   : :             |   
      |     +.                                 +       .+   : :             |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  1600 +--------------------------------------------------------------------+   
       |                                                                  : |   
  1400 |-+                                                                : |   
  1200 |-+                                                                : |   
       |                                                                  : |   
  1000 |-+                                                                : |   
       |                                                                  : |   
   800 |-+                                                                ::|   
       |                             +                                   : :|   
   600 |-+                           :                                   : :|   
   400 |-+                           :                                   : :|   
       |                             ::                                  : :|   
   200 |-+                          : :                                  : :|   
       |                            : :                                  : :|   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  300 +---------------------------------------------------------------------+   
      |                                                                   : |   
  250 |-+                                                                 : |   
      |                                                                   : |   
      |                                                                   : |   
  200 |-+                                                                 : |   
      |                                                                   : |   
  150 |-+                           +                                     ::|   
      |                             :                                    : :|   
  100 |-+                           :                                    : :|   
      |                             :                                    : :|   
      |                            : :                                   : :|   
   50 |-+                          : :                                   : :|   
      |                            : :                                   : :|   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  18 +----------------------------------------------------------------------+   
     |                                                                      |   
  16 |-+                                                                    |   
  14 |-+                                                                    |   
     |                                                                      |   
  12 |-+                                                                    |   
  10 |-+                                                                    |   
     |                                                                      |   
   8 |-+                                                                   :|   
   6 |-+                                                                   :|   
     |                                                                     :|   
   4 |-+                                                                   :|   
   2 |-+                                                                   :|   
     |                                                                     :|   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.045 +-------------------------------------------------------------------+   
        |             +                                                     |   
   0.04 |-+     +     :                                      +              |   
  0.035 |-+     :    +:                                      :              |   
        |      ::    : :   ++                                :              |   
   0.03 |-+ + ++ :  :  :+  :: +      +  +   + + ++  + + ++ + :  +           |   
  0.025 |+++: :  :  +  ::  :: :+ +  +:  :  + +: :: + +: :: : :: :+ +        |   
        |:   :   +  :  +: :  :: + ++  : :  :   : : :   :  ::: :+  + + + + ++|   
   0.02 |:+  +   : :    : +  :        :: ::    +  ::   +  : : ::    : ::::: |   
  0.015 |-+       ::    : :  +        +: ::       :       + : :      : + +  |   
        |         +      ::            + +        +         + +      +      |   
   0.01 |-+              ::                                                 |   
  0.005 |-+              :                                                  |   
        |                :                                                  |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
   0.03 +-------------------------------------------------------------------+   
        |            :                                       :              |   
  0.025 |-+     +    ::                                      :              |   
        |       ::  : :                                    + :              |   
        | +   ++ +  : +       +             +   ++  +   ++ : ::    +        |   
   0.02 |-::+ :  :  + : +  ++ ::  + +   +   ::+ ::  ::+ :: :: :    ::      +|   
        |+ + :    ::   ::  :: :+ + ::+  :  + + :  :+ + :  : : : +.+ +      :|   
  0.015 |:+  +    ::   +: +  :  +  +  :: :+    +  ::   +  : : :+     :+ + + |   
        |         +     : :  +        ++ +        +       + + +      + + :: |   
   0.01 |-+             : :                                              +  |   
        |                ::                                                 |   
        |                :                                                  |   
  0.005 |-+              :                                                  |   
        |                :                                                  |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  12 +----------------------------------------------------------------------+   
     |                                  +        +         ++  +            |   
  10 |-+                                :        :         ::  :            |   
     |                                  :        :         ::  :            |   
     |                                  :        :         ::  :            |   
   8 |-+                                :        :        : :  :            |   
     |                                  :        :        : :  :            |   
   6 |-+                                :        :        : :  :            |   
     |:                                : :      : :       :  :: :           |   
   4 |:+                               : :      : :       :  :: :           |   
     |:                                : :      : :       :  :: :           |   
     |:                                : :      : :      :   :: :           |   
   2 |:+                               : :      : :      :   :: :           |   
     |:                                : :      : :      :   :: :           |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  6 +-----------------------------------------------------------------------+   
    |                                  +        +          +   +            |   
  5 |-+                                :        :          :   :            |   
    |                                  :        :          :   :            |   
    |                                  :        :          :   :            |   
  4 |-+                                ::       :          :   :            |   
    |                                  ::       :         ::   :            |   
  3 |-+                                ::       :         ::   :            |   
    |:                                : :      : :        : : : :           |   
  2 |:+                               : :      : :        + : : :           |   
    |:                                : :      : :        : : : :           |   
    |:                                :  :     : :        : : : :           |   
  1 |:+                               :  :     : :       :  : : :           |   
    |:                                :  :     : :       :  : : :           |   
  0 +-----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
    perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64   
                                                                                
  12 +----------------------------------------------------------------------+   
     |  ++                                 ++       ++       +      +  + +  |   
  10 |-+::    +                            ::       ::       :      :  : :  |   
     |  ::    :                     +      ::       ::       :      :  : :  |   
     | : :    : +                   :     : :      : :       :      :  : :  |   
   8 |-+ :    : :                   :     + :      + :       :      : :: :  |   
     | : :    : :                  ::     : :      : :       :      : : ::  |   
   6 |-: :    : :                  ::     : :      : :       :      : : ::  |   
     |:   :   :::                  ::    :   :    :   :     : :    : :: : : |   
   4 |:+  :  : :::                 : :   :   :    :   :     : :    : :: : : |   
     |+   :  : : :                 : :   +   :    +   :     : :    : :: : : |   
     |:   :  : : :                 : :   :   :    :   :     : :    : :  + : |   
   2 |:+  :  : : :                :  :   :   :    :   :     : :    : :    : |   
     |    :  : : :             +  :  :  :    :   :    :     : :    : :    : |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
    perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64   
                                                                                
  12 +----------------------------------------------------------------------+   
     |  ++                                 ++       ++       +      +  + +  |   
  10 |-+::    +                            ::       ::       :      :  : :  |   
     |  ::    :                     +      ::       ::       :      :  : :  |   
     | : :    : +                   :     : :      : :       :      :  : :  |   
   8 |-+ :    : :                   :     + :      + :       :      : :: :  |   
     | : :    : :                  ::     : :      : :       :      : :: :  |   
   6 |-: :    : :                  ::     : :      : :       :      : : ::  |   
     |:   :   :::                  ::    :   :    :   :     : :    : :: : : |   
   4 |:+  :  : :::                 : :   :   :    :   :     : :    : :: : : |   
     |+   :  : : :                 : :   +   :    +   :     : :    : :: : : |   
     |:   :  : : :                 : :   :   :    :   :     : :    : :  : : |   
   2 |:+  :  : : :                :  :   :   :    :   :     : :    : :  + : |   
     |    :  : : :                :  :  :    :   :    :     : :    : :    : |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
         perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read        
                                                                                
  14 +----------------------------------------------------------------------+   
     |                                +                                     |   
  12 |-+          +         +         :                          +          |   
     |            :         :        +:                          : +        |   
  10 |-+          :         :        ::                          : :        |   
     |            :         :        ::                          : :       +|   
   8 |-+          :         :        ::                          : :       :|   
     |            :         :        ::                          : :       :|   
   6 |-+          ::        ::       : :                         :::       :|   
     |           : :       : :      :  :                        : : :      :|   
   4 |-+         : :       : :      :  :                        : : :     : |   
     |           : : +     : :      :  :                        : : :     : |   
   2 |-+         : : :     : :      :  :                        : : :     : |   
     |           : :: :    : :      :  :                        : : :     : |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
         perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read        
                                                                                
  14 +----------------------------------------------------------------------+   
     |                                +                                     |   
  12 |-+          +         +         :                          +          |   
     |            :         :        +:                          : +        |   
  10 |-+          :         :        ::                          : :        |   
     |            :         :        ::                          : :       +|   
   8 |-+          :         :        ::                          : :       :|   
     |            :         :        ::                          : :       :|   
   6 |-+          ::        ::       : :                         :::       :|   
     |           : :       : :      :  :                        : : :      :|   
   4 |-+         : :       : :      :  :                        : : :     : |   
     |           : : +     : :      :  :                        : : :     : |   
   2 |-+         : : :     : :      :  :                        : : :     : |   
     |           : :: :    : :      :  :                        : : :     : |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.12.0-rc2-00030-g322b5a81171d"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.12.0-rc2 Kernel Configuration
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
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
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

--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='netperf'
	export testcase='netperf'
	export category='benchmark'
	export disable_latency_stats=1
	export set_nic_irq_affinity=1
	export ip='ipv4'
	export runtime=300
	export nr_threads=384
	export cluster='cs-localhost'
	export job_origin='netperf-full-threads.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2ap4'
	export tbox_group='lkp-csl-2ap4'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='6049486471aa23e82ff5d16f'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap4/netperf-cs-localhost-performance-ipv4-200%-300s-TCP_RR-ucode=0x5003006-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-322b5a81-20210311-59439-t5jk38-5.yaml'
	export id='9378101ee89a7e774a204161496004ef69c4b85a'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=4
	export nr_cpu=192
	export memory='192G'
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF87091000G1P6IGN-*-part1'
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export kernel_cmdline_hw='acpi_rsdp=0x67f44014'
	export brand='Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz'
	export commit='322b5a81171d432c59b5c6dcf0229d92acf0d9c2'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_BLK_DEV_NVME'
	export ucode='0x5003006'
	export enqueue_time='2021-03-11 06:29:56 +0800'
	export _id='6049486871aa23e82ff5d171'
	export _rt='/result/netperf/cs-localhost-performance-ipv4-200%-300s-TCP_RR-ucode=0x5003006-monitor=70d6d718/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/322b5a81171d432c59b5c6dcf0229d92acf0d9c2'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='54461824e6410914d15f8aba37fa7fdd4f07f9eb'
	export base_commit='a38fd8748464831584a19438cbb3082b5a2dab15'
	export branch='linux-review/Aubrey-Li/sched-fair-select-idle-cpu-from-idle-cpumask-for-task-wakeup/20210310-100644'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='70d6d718'
	export result_root='/result/netperf/cs-localhost-performance-ipv4-200%-300s-TCP_RR-ucode=0x5003006-monitor=70d6d718/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/322b5a81171d432c59b5c6dcf0229d92acf0d9c2/3'
	export scheduler_version='/lkp/lkp/.src-20210310-183816'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2ap4/netperf-cs-localhost-performance-ipv4-200%-300s-TCP_RR-ucode=0x5003006-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-322b5a81-20210311-59439-t5jk38-5.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-review/Aubrey-Li/sched-fair-select-idle-cpu-from-idle-cpumask-for-task-wakeup/20210310-100644
commit=322b5a81171d432c59b5c6dcf0229d92acf0d9c2
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/322b5a81171d432c59b5c6dcf0229d92acf0d9c2/vmlinuz-5.12.0-rc2-00030-g322b5a81171d
acpi_rsdp=0x67f44014
max_uptime=2100
RESULT_ROOT=/result/netperf/cs-localhost-performance-ipv4-200%-300s-TCP_RR-ucode=0x5003006-monitor=70d6d718/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/322b5a81171d432c59b5c6dcf0229d92acf0d9c2/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/322b5a81171d432c59b5c6dcf0229d92acf0d9c2/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/netperf_20210106.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/netperf-x86_64-2.7-0_20210106.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-e71ba9452f0b-1_20210106.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.12.0-rc2'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/322b5a81171d432c59b5c6dcf0229d92acf0d9c2/vmlinuz-5.12.0-rc2-00030-g322b5a81171d'
	export dequeue_time='2021-03-11 06:46:37 +0800'
	export node_roles='server client'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap4/netperf-cs-localhost-performance-ipv4-200%-300s-TCP_RR-ucode=0x5003006-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-322b5a81-20210311-59439-t5jk38-5.cgz'

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
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	if role server
	then
		start_daemon $LKP_SRC/daemon/netserver
	fi

	if role client
	then
		run_test test='TCP_RR' $LKP_SRC/tests/wrapper netperf
	fi
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='TCP_RR' $LKP_SRC/stats/wrapper netperf
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

	$LKP_SRC/stats/wrapper time netperf.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/netperf-full-threads.yaml
suite: netperf
testcase: netperf
category: benchmark

# upto 90% CPU cycles may be used by latency stats
disable_latency_stats: 1
set_nic_irq_affinity: 1
ip: ipv4
runtime: 300s
nr_threads: 200%
cluster: cs-localhost
if role server:
  netserver: 
if role client:
  netperf:
    test: TCP_RR
job_origin: netperf-full-threads.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2ap4
tbox_group: lkp-csl-2ap4
kconfig: x86_64-rhel-8.3
submit_id: 6048f91471aa23d5aecf0106
job_file: "/lkp/jobs/scheduled/lkp-csl-2ap4/netperf-cs-localhost-performance-ipv4-200%-300s-TCP_RR-ucode=0x5003006-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-322b5a81-20210311-54702-ifnq0a-0.yaml"
id: bcd12d559b173ae3ff7fd58eb722a84eff9b5646
queuer_version: "/lkp-src"

#! hosts/lkp-csl-2ap4
model: Cascade Lake
nr_node: 4
nr_cpu: 192
memory: 192G
ssd_partitions: "/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF87091000G1P6IGN-*-part1"
rootfs_partition: LABEL=LKP-ROOTFS
kernel_cmdline_hw: acpi_rsdp=0x67f44014
brand: Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz

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

#! include/queue/cyclic
commit: 322b5a81171d432c59b5c6dcf0229d92acf0d9c2

#! include/testbox/lkp-csl-2ap4
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_BLK_DEV_NVME
ucode: '0x5003006'
enqueue_time: 2021-03-11 00:51:32.319891943 +08:00
_id: 6048f91471aa23d5aecf0106
_rt: "/result/netperf/cs-localhost-performance-ipv4-200%-300s-TCP_RR-ucode=0x5003006-monitor=70d6d718/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/322b5a81171d432c59b5c6dcf0229d92acf0d9c2"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 54461824e6410914d15f8aba37fa7fdd4f07f9eb
base_commit: a38fd8748464831584a19438cbb3082b5a2dab15
branch: linux-devel/devel-hourly-20210310-085912
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 70d6d718
result_root: "/result/netperf/cs-localhost-performance-ipv4-200%-300s-TCP_RR-ucode=0x5003006-monitor=70d6d718/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/322b5a81171d432c59b5c6dcf0229d92acf0d9c2/0"
scheduler_version: "/lkp/lkp/.src-20210310-183816"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2ap4/netperf-cs-localhost-performance-ipv4-200%-300s-TCP_RR-ucode=0x5003006-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-322b5a81-20210311-54702-ifnq0a-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210310-085912
- commit=322b5a81171d432c59b5c6dcf0229d92acf0d9c2
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/322b5a81171d432c59b5c6dcf0229d92acf0d9c2/vmlinuz-5.12.0-rc2-00030-g322b5a81171d
- acpi_rsdp=0x67f44014
- max_uptime=2100
- RESULT_ROOT=/result/netperf/cs-localhost-performance-ipv4-200%-300s-TCP_RR-ucode=0x5003006-monitor=70d6d718/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/322b5a81171d432c59b5c6dcf0229d92acf0d9c2/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/322b5a81171d432c59b5c6dcf0229d92acf0d9c2/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/netperf_20210106.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/netperf-x86_64-2.7-0_20210106.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-e71ba9452f0b-1_20210106.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210310-104123/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.11.0
repeat_to: 3

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/322b5a81171d432c59b5c6dcf0229d92acf0d9c2/vmlinuz-5.12.0-rc2-00030-g322b5a81171d"
dequeue_time: 2021-03-11 01:32:58.751248791 +08:00

#! /lkp/lkp/.src-20210310-183816/include/site/inn
job_state: finished
loadavg: 184.49 250.43 124.32 1/1371 14183
start_time: '1615397647'
end_time: '1615397950'
version: "/lkp/lkp/.src-20210310-183848:07f24f70:f5b09a2fb"

--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

netserver -4 -D
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t TCP_RR -c -C -l 300  &
wait

--cmJC7u66zC7hs+87--
