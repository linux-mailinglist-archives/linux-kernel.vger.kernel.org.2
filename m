Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34BF336AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 05:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhCKEJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 23:09:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:39166 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231187AbhCKEJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 23:09:03 -0500
IronPort-SDR: nE+cyBP1X8SEy22Ifh1+nMzHjVzfIJtqi3mDqAJ0h9VY/FGjLVc80Rhk9Exp7flpUnl5u7LW4f
 FahBqVmAXBkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="168526293"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="168526293"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 20:09:02 -0800
IronPort-SDR: nVclgNVDqtgCdPhDilHSuzmFnrlhDYDbMr/oiOARmRY5c3Uo+R7fH8StY+qA8uwzsJNbdTKVHj
 qunZzhdnkCTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="431460199"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2021 20:08:54 -0800
Subject: Re: [sched/fair] 322b5a8117: netperf.Throughput_tps -84.0% regression
To:     kernel test robot <oliver.sang@intel.com>,
        Aubrey Li <aubrey.li@intel.com>
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
        rostedt@goodmis.org, bsegall@google.com, yu.c.chen@intel.com
References: <20210311025836.GB9906@xsang-OptiPlex-9020>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <bf4d38e2-7246-a88e-f19a-1d7d11baeca9@linux.intel.com>
Date:   Thu, 11 Mar 2021 12:08:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311025836.GB9906@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/11 10:58, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a -84.0% regression of netperf.Throughput_tps due to commit:
> 
> 
> commit: 322b5a81171d432c59b5c6dcf0229d92acf0d9c2 ("[PATCH v9 2/2] sched/fair: Remove SIS_PROP")
> url: https://github.com/0day-ci/linux/commits/Aubrey-Li/sched-fair-select-idle-cpu-from-idle-cpumask-for-task-wakeup/20210310-100644
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 4117cebf1a9fcbf35b9aabf0e37b6c5eea296798
> 
> in testcase: netperf
> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> with following parameters:
> 
> 	ip: ipv4
> 	runtime: 300s
> 	nr_threads: 200%

Thanks for the report, this patch removed time clock read and scan cost computation, especially
for 200% case, the task wakeup latency should be significantly reduced. Let me try to replicate
and understand.

Thanks,
-Aubrey 


> 	cluster: cs-localhost
> 	test: TCP_RR
> 	cpufreq_governor: performance
> 	ucode: 0x5003006
> 
> test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
> test-url: http://www.netperf.org/netperf/
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
> cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase/ucode:
>   cs-localhost/gcc-9/performance/ipv4/x86_64-rhel-8.3/200%/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap4/TCP_RR/netperf/0x5003006
> 
> commit: 
>   ca52510778 ("sched/fair: select idle cpu from idle cpumask for task wakeup")
>   322b5a8117 ("sched/fair: Remove SIS_PROP")
> 
> ca52510778e4c6e5 322b5a81171d432c59b5c6dcf02 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>   13817913           -84.0%    2208427 ±  3%  netperf.Throughput_total_tps
>      35984           -84.0%       5751 ±  3%  netperf.Throughput_tps
>  2.129e+09 ±  8%     -99.1%   20142981 ± 41%  netperf.time.involuntary_context_switches
>     107905           +19.9%     129367        netperf.time.minor_page_faults
>       6660           -54.6%       3023        netperf.time.percent_of_cpu_this_job_got
>      18970 ±  2%     -53.4%       8849        netperf.time.system_time
>       1306           -76.9%     301.26 ±  9%  netperf.time.user_time
>  2.016e+09 ±  7%     -68.3%  6.394e+08 ±  2%  netperf.time.voluntary_context_switches
>  4.145e+09           -84.0%  6.625e+08 ±  3%  netperf.workload
>       7442 ±  5%     +74.6%      12995 ±  2%  uptime.idle
>   1.91e+08 ± 26%   +3587.1%  7.042e+09        cpuidle.C1.time
>   25239057 ± 16%   +1634.0%  4.376e+08 ±  2%  cpuidle.C1.usage
>    1373740 ± 13%   +1123.6%   16808508 ± 12%  cpuidle.C1E.usage
>   19356693 ± 18%    +186.0%   55355728 ± 30%  cpuidle.POLL.time
>     206522 ±103%   +1248.1%    2784046 ± 23%  numa-numastat.node0.local_node
>     283690 ± 76%    +899.8%    2836469 ± 23%  numa-numastat.node0.numa_hit
>     699972 ± 15%     +78.4%    1248418 ± 49%  numa-numastat.node3.local_node
>     755619 ± 15%     +74.8%    1320493 ± 45%  numa-numastat.node3.numa_hit
>      17.59 ±  4%      +7.3       24.87        mpstat.cpu.all.idle%
>       0.90            +0.5        1.37 ±  4%  mpstat.cpu.all.irq%
>      23.95           +14.4       38.40        mpstat.cpu.all.soft%
>      53.63           -19.7       33.94        mpstat.cpu.all.sys%
>       3.93            -2.5        1.42 ±  7%  mpstat.cpu.all.usr%
>       1.33 ± 35%    +950.0%      14.00        vmstat.cpu.id
>      93.00            -9.7%      84.00        vmstat.cpu.sy
>    3378802 ±  9%    +143.8%    8238004        vmstat.memory.cache
>     477.50           -14.4%     408.83        vmstat.procs.r
>   27106400           -78.2%    5898538 ±  3%  vmstat.system.cs
>    3232783 ± 10%    +149.3%    8058169        meminfo.Cached
>    3008249 ± 11%    +161.2%    7856377        meminfo.Committed_AS
>    2213694 ± 23%    +232.2%    7354700        meminfo.Inactive
>    2213694 ± 23%    +232.2%    7354700        meminfo.Inactive(anon)
>     909222 ± 25%    +178.8%    2534646        meminfo.Mapped
>    6034546 ±  6%     +80.9%   10914745        meminfo.Memused
>    2263228 ± 14%    +213.2%    7088623        meminfo.Shmem
>    6316722 ±  4%     +76.3%   11134561        meminfo.max_used_kB
>     959.50 ±  8%     -17.7%     789.83 ±  6%  slabinfo.mnt_cache.active_objs
>     959.50 ±  8%     -17.7%     789.83 ±  6%  slabinfo.mnt_cache.num_objs
>      30561 ±  4%     +62.4%      49631        slabinfo.radix_tree_node.active_objs
>     545.33 ±  4%     +62.4%     885.83        slabinfo.radix_tree_node.active_slabs
>      30561 ±  4%     +62.4%      49631        slabinfo.radix_tree_node.num_objs
>     545.33 ±  4%     +62.4%     885.83        slabinfo.radix_tree_node.num_slabs
>       1525 ±  8%     -13.0%       1327 ±  8%  slabinfo.task_group.active_objs
>       1525 ±  8%     -13.0%       1327 ±  8%  slabinfo.task_group.num_objs
>       2193 ± 62%    +287.7%       8502 ± 29%  numa-meminfo.node0.Active
>       2193 ± 62%    +287.7%       8502 ± 29%  numa-meminfo.node0.Active(anon)
>     260184 ±  7%   +1476.3%    4101372 ± 21%  numa-meminfo.node0.FilePages
>     155797 ± 49%   +2472.0%    4007098 ± 23%  numa-meminfo.node0.Inactive
>     155797 ± 49%   +2472.0%    4007098 ± 23%  numa-meminfo.node0.Inactive(anon)
>      78745 ± 16%   +1791.3%    1489348 ± 11%  numa-meminfo.node0.Mapped
>    1037565 ±  7%    +374.3%    4921173 ± 20%  numa-meminfo.node0.MemUsed
>       8462 ± 57%  +45383.3%    3848873 ± 22%  numa-meminfo.node0.Shmem
>     887567 ±  6%    +107.4%    1840670 ± 31%  numa-meminfo.node3.FilePages
>     490746 ± 23%    +208.5%    1513789 ± 38%  numa-meminfo.node3.Inactive
>     490746 ± 23%    +208.5%    1513789 ± 38%  numa-meminfo.node3.Inactive(anon)
>     316259 ± 17%    +141.6%     764021 ± 10%  numa-meminfo.node3.Mapped
>    1557192 ±  6%     +60.9%    2506075 ± 23%  numa-meminfo.node3.MemUsed
>     643128 ±  9%    +150.1%    1608493 ± 36%  numa-meminfo.node3.Shmem
>     549.33 ± 63%    +287.3%       2127 ± 29%  numa-vmstat.node0.nr_active_anon
>      65046 ±  7%   +1479.4%    1027316 ± 21%  numa-vmstat.node0.nr_file_pages
>      38946 ± 49%   +2477.3%    1003758 ± 23%  numa-vmstat.node0.nr_inactive_anon
>      19771 ± 16%   +1791.7%     374017 ± 11%  numa-vmstat.node0.nr_mapped
>       2115 ± 57%  +45473.9%     964192 ± 22%  numa-vmstat.node0.nr_shmem
>     549.33 ± 63%    +287.3%       2127 ± 29%  numa-vmstat.node0.nr_zone_active_anon
>      38946 ± 49%   +2477.3%    1003757 ± 23%  numa-vmstat.node0.nr_zone_inactive_anon
>     717998 ± 18%    +143.8%    1750758 ± 21%  numa-vmstat.node0.numa_hit
>     616749 ± 22%    +173.4%    1686107 ± 22%  numa-vmstat.node0.numa_local
>     221911 ±  6%    +107.7%     460942 ± 31%  numa-vmstat.node3.nr_file_pages
>     122508 ± 23%    +209.5%     379175 ± 38%  numa-vmstat.node3.nr_inactive_anon
>      78890 ± 17%    +142.6%     191411 ± 10%  numa-vmstat.node3.nr_mapped
>     160801 ±  9%    +150.6%     402898 ± 36%  numa-vmstat.node3.nr_shmem
>     122507 ± 23%    +209.5%     379174 ± 38%  numa-vmstat.node3.nr_zone_inactive_anon
>     111333            +4.6%     116424        proc-vmstat.nr_anon_pages
>    4766626            -2.6%    4644729        proc-vmstat.nr_dirty_background_threshold
>    9544909            -2.6%    9300815        proc-vmstat.nr_dirty_threshold
>     809456 ± 10%    +149.1%    2016338        proc-vmstat.nr_file_pages
>   47919019            -2.5%   46698243        proc-vmstat.nr_free_pages
>     554049 ± 23%    +232.2%    1840432        proc-vmstat.nr_inactive_anon
>     227517 ± 25%    +179.5%     635910        proc-vmstat.nr_mapped
>       8267 ±  3%     +10.8%       9162 ±  3%  proc-vmstat.nr_page_table_pages
>     567067 ± 14%    +212.8%    1773952        proc-vmstat.nr_shmem
>      33641            +7.9%      36304        proc-vmstat.nr_slab_reclaimable
>     554049 ± 23%    +232.2%    1840432        proc-vmstat.nr_zone_inactive_anon
>     316039 ± 12%    +215.1%     995881 ±  6%  proc-vmstat.numa_hint_faults
>     148817 ± 15%    +361.5%     686842 ±  8%  proc-vmstat.numa_hint_faults_local
>    2728417 ±  7%    +117.3%    5929219        proc-vmstat.numa_hit
>    2468898 ±  8%    +129.6%    5669750        proc-vmstat.numa_local
>     640372 ±  8%    +103.8%    1305080 ±  4%  proc-vmstat.numa_pte_updates
>    2852513 ±  7%    +112.4%    6057608        proc-vmstat.pgalloc_normal
>    1894166 ±  2%     +44.9%    2745142 ±  2%  proc-vmstat.pgfault
>      71009            -6.2%      66609        proc-vmstat.pgreuse
>    1669483 ±223%    +547.5%   10809999 ±  9%  sched_debug.cfs_rq:/.MIN_vruntime.max
>       1033 ± 33%    -100.0%       0.00        sched_debug.cfs_rq:/.load.min
>       1.31 ± 38%     -55.3%       0.58 ± 35%  sched_debug.cfs_rq:/.load_avg.min
>    1669483 ±223%    +547.5%   10809999 ±  9%  sched_debug.cfs_rq:/.max_vruntime.max
>   21407196           -56.9%    9226871        sched_debug.cfs_rq:/.min_vruntime.avg
>   29210953 ±  3%     -40.8%   17282658 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
>   15709396 ±  4%     -44.5%    8715788        sched_debug.cfs_rq:/.min_vruntime.min
>    3823741 ± 22%     -78.3%     828290 ± 12%  sched_debug.cfs_rq:/.min_vruntime.stddev
>       0.83 ±  2%     -10.8%       0.74        sched_debug.cfs_rq:/.nr_running.avg
>       0.81 ±  7%    -100.0%       0.00        sched_debug.cfs_rq:/.nr_running.min
>       0.05 ± 61%    +472.8%       0.31 ±  3%  sched_debug.cfs_rq:/.nr_running.stddev
>       1955 ±  5%     -13.4%       1693        sched_debug.cfs_rq:/.runnable_avg.avg
>       3248 ± 10%     +23.1%       3997 ±  3%  sched_debug.cfs_rq:/.runnable_avg.max
>     930.19 ± 12%     -22.0%     725.50 ±  2%  sched_debug.cfs_rq:/.runnable_avg.min
>    3821269 ± 22%     -78.3%     828506 ± 12%  sched_debug.cfs_rq:/.spread0.stddev
>     851.17 ±  3%     -44.5%     472.16        sched_debug.cfs_rq:/.util_avg.avg
>       1259 ±  8%     -22.2%     979.56        sched_debug.cfs_rq:/.util_avg.max
>     579.78 ± 14%     -31.1%     399.75 ±  4%  sched_debug.cfs_rq:/.util_avg.min
>     570.92 ±  3%     -96.0%      23.10 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>       1310 ± 13%     -61.6%     503.33 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.max
>     156.42 ± 22%    -100.0%       0.00        sched_debug.cfs_rq:/.util_est_enqueued.min
>     184.06 ±  4%     -74.4%      47.15 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
>       5060 ± 14%     +66.2%       8409 ±  2%  sched_debug.cpu.avg_idle.min
>      82.09 ±  9%     -67.5%      26.69 ±  3%  sched_debug.cpu.clock.stddev
>     146203           -18.0%     119880        sched_debug.cpu.clock_task.avg
>     148209           -13.6%     128111        sched_debug.cpu.clock_task.max
>     137947           -18.6%     112301        sched_debug.cpu.clock_task.min
>     891.38 ±  4%     +72.6%       1538 ± 25%  sched_debug.cpu.clock_task.stddev
>       3530           -21.3%       2777        sched_debug.cpu.curr->pid.avg
>       2591 ± 20%    -100.0%       0.00        sched_debug.cpu.curr->pid.min
>     602.41 ± 18%    +173.6%       1648        sched_debug.cpu.curr->pid.stddev
>       5317 ± 61%    +202.3%      16071 ± 74%  sched_debug.cpu.max_idle_balance_cost.stddev
>       0.00 ± 36%     -69.7%       0.00        sched_debug.cpu.next_balance.stddev
>       2.09 ±  4%     -13.8%       1.80 ±  4%  sched_debug.cpu.nr_running.avg
>       3.69 ±  9%    +151.1%       9.28 ±  4%  sched_debug.cpu.nr_running.max
>       0.81 ±  7%    -100.0%       0.00        sched_debug.cpu.nr_running.min
>       0.64 ±  6%    +153.7%       1.63 ±  4%  sched_debug.cpu.nr_running.stddev
>   21529949           -77.9%    4767019 ±  4%  sched_debug.cpu.nr_switches.avg
>   22891153           -75.9%    5506756 ± 10%  sched_debug.cpu.nr_switches.max
>   19927966           -80.4%    3915549 ±  5%  sched_debug.cpu.nr_switches.min
>    4140603           -50.0%    2070075        sched_debug.sysctl_sched.sysctl_sched_features
>       2.22 ± 10%    +979.8%      23.94        perf-stat.i.MPKI
>  8.071e+10           -74.8%  2.031e+10 ±  2%  perf-stat.i.branch-instructions
>       1.49            +0.2        1.66        perf-stat.i.branch-miss-rate%
>  1.186e+09           -72.8%  3.221e+08 ±  2%  perf-stat.i.branch-misses
>      22.12 ±  9%     -20.5        1.58 ±  5%  perf-stat.i.cache-miss-rate%
>  1.804e+08 ± 14%     -81.1%   34036288 ±  6%  perf-stat.i.cache-misses
>  8.328e+08 ±  9%    +167.1%  2.225e+09        perf-stat.i.cache-references
>   27354194           -78.4%    5919450 ±  3%  perf-stat.i.context-switches
>       1.41          +298.3%       5.62 ±  2%  perf-stat.i.cpi
>  5.572e+11            -6.3%  5.222e+11        perf-stat.i.cpu-cycles
>      24621 ± 51%  +12292.4%    3051146 ±  2%  perf-stat.i.cpu-migrations
>       3286 ± 12%    +397.7%      16355 ±  7%  perf-stat.i.cycles-between-cache-misses
>       0.03 ± 22%      +0.2        0.26 ±  5%  perf-stat.i.dTLB-load-miss-rate%
>   29759619 ± 21%    +134.0%   69633082 ±  5%  perf-stat.i.dTLB-load-misses
>  1.193e+11           -76.6%  2.789e+10 ±  2%  perf-stat.i.dTLB-loads
>       0.01 ± 22%      +0.1        0.08 ±  5%  perf-stat.i.dTLB-store-miss-rate%
>    5015493 ± 21%    +104.6%   10261112 ±  4%  perf-stat.i.dTLB-store-misses
>  6.778e+10           -78.9%  1.433e+10 ±  2%  perf-stat.i.dTLB-stores
>      69.23            -6.7       62.58        perf-stat.i.iTLB-load-miss-rate%
>  7.013e+08           -78.2%  1.526e+08 ±  3%  perf-stat.i.iTLB-load-misses
>  3.103e+08           -70.9%   90260578 ±  2%  perf-stat.i.iTLB-loads
>  4.001e+11           -75.4%  9.836e+10 ±  2%  perf-stat.i.instructions
>     587.02           +10.6%     649.42        perf-stat.i.instructions-per-iTLB-miss
>       0.72           -73.4%       0.19 ±  2%  perf-stat.i.ipc
>       2.90            -6.3%       2.72        perf-stat.i.metric.GHz
>       0.18 ± 12%     +77.0%       0.31 ± 13%  perf-stat.i.metric.K/sec
>       1401           -75.9%     337.91 ±  2%  perf-stat.i.metric.M/sec
>       6086 ±  2%     +45.2%       8834 ±  2%  perf-stat.i.minor-faults
>   41400698 ± 15%     -74.0%   10763215 ±  6%  perf-stat.i.node-load-misses
>    5852508 ±  8%     -69.1%    1808560 ±  4%  perf-stat.i.node-loads
>      99.07            -5.1       94.00        perf-stat.i.node-store-miss-rate%
>   14478209 ± 11%     -62.0%    5508812 ±  4%  perf-stat.i.node-store-misses
>      88440 ± 30%    +579.5%     600931 ±  6%  perf-stat.i.node-stores
>       6087 ±  2%     +45.1%       8835 ±  2%  perf-stat.i.page-faults
>       2.09 ± 10%    +985.1%      22.63        perf-stat.overall.MPKI
>       1.47            +0.1        1.59        perf-stat.overall.branch-miss-rate%
>      21.62 ±  9%     -20.1        1.53 ±  6%  perf-stat.overall.cache-miss-rate%
>       1.39          +281.5%       5.31 ±  2%  perf-stat.overall.cpi
>       3148 ± 13%    +389.9%      15426 ±  6%  perf-stat.overall.cycles-between-cache-misses
>       0.03 ± 22%      +0.2        0.25 ±  6%  perf-stat.overall.dTLB-load-miss-rate%
>       0.01 ± 22%      +0.1        0.07 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
>      69.32            -6.5       62.83        perf-stat.overall.iTLB-load-miss-rate%
>     570.55           +13.0%     644.62        perf-stat.overall.instructions-per-iTLB-miss
>       0.72           -73.8%       0.19 ±  2%  perf-stat.overall.ipc
>      99.37            -9.2       90.19        perf-stat.overall.node-store-miss-rate%
>      29341           +52.9%      44875        perf-stat.overall.path-length
>  8.042e+10           -74.8%  2.023e+10 ±  2%  perf-stat.ps.branch-instructions
>  1.181e+09           -72.8%  3.209e+08 ±  2%  perf-stat.ps.branch-misses
>  1.797e+08 ± 14%     -81.1%   33893343 ±  6%  perf-stat.ps.cache-misses
>  8.305e+08 ±  9%    +166.9%  2.217e+09        perf-stat.ps.cache-references
>   27256541           -78.4%    5898690 ±  3%  perf-stat.ps.context-switches
>  5.552e+11            -6.3%  5.204e+11        perf-stat.ps.cpu-cycles
>      24729 ± 50%  +12196.4%    3040885 ±  2%  perf-stat.ps.cpu-migrations
>   29676518 ± 21%    +133.9%   69414938 ±  5%  perf-stat.ps.dTLB-load-misses
>  1.188e+11           -76.6%  2.779e+10 ±  2%  perf-stat.ps.dTLB-loads
>    4995687 ± 21%    +104.7%   10225922 ±  4%  perf-stat.ps.dTLB-store-misses
>  6.753e+10           -78.9%  1.428e+10 ±  2%  perf-stat.ps.dTLB-stores
>  6.987e+08           -78.2%  1.521e+08 ±  3%  perf-stat.ps.iTLB-load-misses
>  3.092e+08           -70.9%   89948944 ±  2%  perf-stat.ps.iTLB-loads
>  3.987e+11           -75.4%  9.799e+10 ±  2%  perf-stat.ps.instructions
>       6065 ±  2%     +44.7%       8777 ±  2%  perf-stat.ps.minor-faults
>   41255334 ± 15%     -74.0%   10721928 ±  6%  perf-stat.ps.node-load-misses
>    5829908 ±  8%     -69.2%    1793127 ±  4%  perf-stat.ps.node-loads
>   14427293 ± 11%     -62.0%    5487905 ±  4%  perf-stat.ps.node-store-misses
>      88224 ± 30%    +576.2%     596567 ±  6%  perf-stat.ps.node-stores
>       6066 ±  2%     +44.7%       8779 ±  2%  perf-stat.ps.page-faults
>  1.216e+14           -75.6%  2.972e+13 ±  2%  perf-stat.total.instructions
>       4.05 ±129%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>       1.47 ±220%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
>      10.60 ±213%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>      24.92 ±156%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.03 ± 66%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
>      25.48 ±124%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
>       4.68 ± 22%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
>     191.29 ±117%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
>       0.02 ± 16%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>       0.02 ± 19%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
>       0.01 ± 17%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
>      45.51 ± 45%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
>       0.40 ± 14%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
>       0.12 ± 87%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
>     196.21 ±177%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
>       4.26 ±121%    -100.0%       0.00        perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>       1.47 ±220%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
>     172.87 ±217%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>     552.66 ±147%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       3900 ± 33%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
>       1268 ±114%    -100.0%       0.00        perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
>      18.62 ± 30%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
>       1409 ± 77%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
>       0.02 ± 23%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>       0.02 ± 21%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
>       0.01 ± 36%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
>       1193 ± 43%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
>       6097 ± 19%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
>       1049 ± 91%    -100.0%       0.00        perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
>       1527 ±142%    -100.0%       0.00        perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
>       0.22 ± 16%    -100.0%       0.00        perf-sched.total_sch_delay.average.ms
>       6208 ± 17%    -100.0%       0.00        perf-sched.total_sch_delay.max.ms
>       1.67 ± 13%    -100.0%       0.00        perf-sched.total_wait_and_delay.average.ms
>    5989381 ± 15%    -100.0%       0.00        perf-sched.total_wait_and_delay.count.ms
>      12710 ± 16%    -100.0%       0.00        perf-sched.total_wait_and_delay.max.ms
>       1.45 ± 13%    -100.0%       0.00        perf-sched.total_wait_time.average.ms
>      10832 ±  7%    -100.0%       0.00        perf-sched.total_wait_time.max.ms
>     104.43 ±113%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.95 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
>     184.94 ± 63%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
>      26.74 ± 63%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
>       4.69 ± 22%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
>      38.80 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
>     440.54 ±101%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
>     131.85 ± 41%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
>       1.55 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
>     271.01 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
>     604.50 ± 97%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
>      16.17 ± 42%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>    2979948 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
>     120.33 ± 66%    -100.0%       0.00        perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
>      68.50 ±146%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
>      11.00 ± 24%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
>     265.83 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
>      21.00 ± 54%    -100.0%       0.00        perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork
>      76.50 ± 29%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
>    2999846 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
>       8868 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
>      33.83 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
>       1507 ±117%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       9360 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
>       5712 ± 31%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
>     514.61 ±170%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
>      18.62 ± 30%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
>       1021          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
>       3023 ± 66%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
>       2726 ± 41%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
>      12274 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
>      10832 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
>       6020 ± 61%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
>       0.52 ± 60%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>      79.51 ±103%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.04 ± 12%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
>       0.93 ± 13%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
>     159.46 ± 77%    -100.0%       0.00        perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
>     149.83 ±124%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
>      45.93 ±223%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
>       0.04 ± 31%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
>       1.88 ± 24%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
>      26.74 ± 63%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
>      49.53 ±223%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.sk_stream_alloc_skb
>      38.80 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
>     249.25 ± 90%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
>     150.13 ±221%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>      86.34 ± 39%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
>       1.14 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
>     270.88 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
>       0.21 ± 47%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
>     408.29 ± 78%    -100.0%       0.00        perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
>       3.32 ± 94%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       1310 ±121%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.09 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
>       6865 ± 27%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
>       5516 ± 38%    -100.0%       0.00        perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
>     697.96 ±121%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
>     183.54 ±223%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
>       0.07 ± 32%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
>       2.46 ± 34%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
>     514.61 ±170%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
>     259.91 ±223%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.sk_stream_alloc_skb
>       1021          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
>       1645 ± 56%    -100.0%       0.00        perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork
>     598.67 ±222%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>       1720 ± 34%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
>       7531 ± 24%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
>      10832 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
>       0.36 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
>       5350 ± 80%    -100.0%       0.00        perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
>       9807 ± 93%     -91.3%     851.33 ± 85%  interrupts.38:PCI-MSI.524289-edge.eth0-TxRx-0
>     904091 ± 36%   +4206.1%   38931156        interrupts.CAL:Function_call_interrupts
>       5173 ± 46%   +3806.8%     202126 ±  7%  interrupts.CPU0.CAL:Function_call_interrupts
>       2548 ± 48%   +1720.3%      46390 ± 16%  interrupts.CPU0.RES:Rescheduling_interrupts
>       3437 ± 38%   +6138.4%     214436 ±  5%  interrupts.CPU1.CAL:Function_call_interrupts
>       2474 ± 49%   +1919.7%      49976 ± 13%  interrupts.CPU1.RES:Rescheduling_interrupts
>       9807 ± 93%     -91.3%     851.33 ± 85%  interrupts.CPU10.38:PCI-MSI.524289-edge.eth0-TxRx-0
>       4273 ± 51%   +4949.3%     215763 ±  5%  interrupts.CPU10.CAL:Function_call_interrupts
>       2278 ± 39%   +2065.8%      49343 ± 12%  interrupts.CPU10.RES:Rescheduling_interrupts
>       4627 ± 52%   +4584.7%     216786 ±  5%  interrupts.CPU100.CAL:Function_call_interrupts
>       2163 ± 43%   +2121.7%      48055 ± 12%  interrupts.CPU100.RES:Rescheduling_interrupts
>       4425 ± 53%   +4759.5%     215048 ±  6%  interrupts.CPU101.CAL:Function_call_interrupts
>       2417 ± 60%   +1879.9%      47866 ± 12%  interrupts.CPU101.RES:Rescheduling_interrupts
>       4448 ± 53%   +4608.1%     209441 ± 12%  interrupts.CPU102.CAL:Function_call_interrupts
>       1532 ± 54%   +2864.2%      45411 ± 16%  interrupts.CPU102.RES:Rescheduling_interrupts
>       4439 ± 55%   +4752.2%     215395 ±  6%  interrupts.CPU103.CAL:Function_call_interrupts
>       1869 ± 49%   +2479.1%      48225 ± 12%  interrupts.CPU103.RES:Rescheduling_interrupts
>       4324 ± 52%   +4805.6%     212125 ±  6%  interrupts.CPU104.CAL:Function_call_interrupts
>       2479 ± 36%   +1843.9%      48199 ± 12%  interrupts.CPU104.RES:Rescheduling_interrupts
>       4306 ± 50%   +4857.5%     213496 ±  6%  interrupts.CPU105.CAL:Function_call_interrupts
>       2907 ± 53%   +1552.3%      48033 ± 12%  interrupts.CPU105.RES:Rescheduling_interrupts
>       4384 ± 52%   +4802.3%     214951 ±  6%  interrupts.CPU106.CAL:Function_call_interrupts
>       3612 ± 51%   +1229.8%      48033 ± 12%  interrupts.CPU106.RES:Rescheduling_interrupts
>       4342 ± 50%   +4849.2%     214912 ±  6%  interrupts.CPU107.CAL:Function_call_interrupts
>       2862 ± 38%   +1575.6%      47964 ± 13%  interrupts.CPU107.RES:Rescheduling_interrupts
>       4322 ± 50%   +4816.8%     212535 ±  5%  interrupts.CPU108.CAL:Function_call_interrupts
>       2011 ± 34%   +2277.0%      47810 ± 12%  interrupts.CPU108.RES:Rescheduling_interrupts
>       4271 ± 52%   +4913.2%     214149 ±  6%  interrupts.CPU109.CAL:Function_call_interrupts
>       2298 ± 54%   +1987.9%      47990 ± 12%  interrupts.CPU109.RES:Rescheduling_interrupts
>       4264 ± 49%   +4936.9%     214807 ±  6%  interrupts.CPU11.CAL:Function_call_interrupts
>       2407 ± 29%   +1970.7%      49842 ± 14%  interrupts.CPU11.RES:Rescheduling_interrupts
>       4288 ± 54%   +4903.4%     214547 ±  6%  interrupts.CPU110.CAL:Function_call_interrupts
>       2075 ± 30%   +2225.2%      48252 ± 12%  interrupts.CPU110.RES:Rescheduling_interrupts
>       4342 ± 48%   +4845.1%     214749 ±  6%  interrupts.CPU111.CAL:Function_call_interrupts
>       2311 ± 41%   +1981.0%      48108 ± 12%  interrupts.CPU111.RES:Rescheduling_interrupts
>       4299 ± 52%   +4852.0%     212928 ±  6%  interrupts.CPU112.CAL:Function_call_interrupts
>       2217 ± 48%   +2071.7%      48150 ± 12%  interrupts.CPU112.RES:Rescheduling_interrupts
>       4442 ± 48%   +4668.2%     211836 ±  6%  interrupts.CPU113.CAL:Function_call_interrupts
>       1801 ± 50%   +2549.2%      47733 ± 12%  interrupts.CPU113.RES:Rescheduling_interrupts
>       4309 ± 52%   +4870.8%     214200 ±  6%  interrupts.CPU114.CAL:Function_call_interrupts
>       2982 ± 48%   +1497.1%      47633 ± 13%  interrupts.CPU114.RES:Rescheduling_interrupts
>       4480 ± 56%   +4709.7%     215506 ±  6%  interrupts.CPU115.CAL:Function_call_interrupts
>       1757 ± 34%   +2631.7%      47996 ± 12%  interrupts.CPU115.RES:Rescheduling_interrupts
>       4440 ± 54%   +4758.6%     215744 ±  6%  interrupts.CPU116.CAL:Function_call_interrupts
>       3547 ± 57%   +1252.7%      47984 ± 12%  interrupts.CPU116.RES:Rescheduling_interrupts
>       4219 ± 51%   +4930.2%     212222 ±  6%  interrupts.CPU117.CAL:Function_call_interrupts
>       1659 ± 47%   +2779.5%      47784 ± 13%  interrupts.CPU117.RES:Rescheduling_interrupts
>       4271 ± 51%   +4875.0%     212505 ±  7%  interrupts.CPU118.CAL:Function_call_interrupts
>       2078 ± 59%   +2182.3%      47437 ± 12%  interrupts.CPU118.RES:Rescheduling_interrupts
>       3896 ± 57%   +5360.0%     212730 ±  6%  interrupts.CPU119.CAL:Function_call_interrupts
>       2811 ± 63%   +1596.2%      47695 ± 12%  interrupts.CPU119.RES:Rescheduling_interrupts
>       4272 ± 53%   +4906.0%     213865 ±  5%  interrupts.CPU12.CAL:Function_call_interrupts
>       2226 ± 42%   +2098.5%      48948 ± 12%  interrupts.CPU12.RES:Rescheduling_interrupts
>       3892 ± 42%   +5007.4%     198788 ±  7%  interrupts.CPU120.CAL:Function_call_interrupts
>       1874 ± 42%   +2492.3%      48584 ± 13%  interrupts.CPU120.RES:Rescheduling_interrupts
>       3988 ± 41%   +4940.1%     201026 ±  6%  interrupts.CPU121.CAL:Function_call_interrupts
>       2865 ± 35%   +1595.0%      48562 ± 13%  interrupts.CPU121.RES:Rescheduling_interrupts
>       4099 ± 44%   +4768.3%     199585 ±  7%  interrupts.CPU122.CAL:Function_call_interrupts
>       2896 ± 48%   +1574.6%      48497 ± 14%  interrupts.CPU122.RES:Rescheduling_interrupts
>       4093 ± 44%   +4867.6%     203331 ±  6%  interrupts.CPU123.CAL:Function_call_interrupts
>       1746 ± 33%   +2674.9%      48454 ± 13%  interrupts.CPU123.RES:Rescheduling_interrupts
>       4069 ± 45%   +4884.4%     202850 ±  6%  interrupts.CPU124.CAL:Function_call_interrupts
>       1908 ± 49%   +2428.3%      48239 ± 14%  interrupts.CPU124.RES:Rescheduling_interrupts
>       3890 ± 45%   +5144.0%     204026 ±  5%  interrupts.CPU125.CAL:Function_call_interrupts
>       1687 ± 40%   +2761.2%      48273 ± 13%  interrupts.CPU125.RES:Rescheduling_interrupts
>       4088 ± 46%   +4860.3%     202784 ±  6%  interrupts.CPU126.CAL:Function_call_interrupts
>       2081 ± 36%   +2210.1%      48072 ± 13%  interrupts.CPU126.RES:Rescheduling_interrupts
>       4011 ± 45%   +4939.2%     202129 ±  6%  interrupts.CPU127.CAL:Function_call_interrupts
>       2573 ± 49%   +1786.6%      48542 ± 13%  interrupts.CPU127.RES:Rescheduling_interrupts
>       3825 ± 43%   +5137.6%     200345 ±  6%  interrupts.CPU128.CAL:Function_call_interrupts
>       1565 ± 51%   +3005.8%      48631 ± 14%  interrupts.CPU128.RES:Rescheduling_interrupts
>       3872 ± 43%   +5066.4%     200050 ±  7%  interrupts.CPU129.CAL:Function_call_interrupts
>       2961 ± 46%   +1529.7%      48257 ± 14%  interrupts.CPU129.RES:Rescheduling_interrupts
>       4269 ± 51%   +4894.4%     213235 ±  5%  interrupts.CPU13.CAL:Function_call_interrupts
>       2426 ± 55%   +1937.6%      49439 ± 12%  interrupts.CPU13.RES:Rescheduling_interrupts
>       4001 ± 46%   +4946.9%     201969 ±  6%  interrupts.CPU130.CAL:Function_call_interrupts
>       2232 ± 38%   +2071.7%      48479 ± 14%  interrupts.CPU130.RES:Rescheduling_interrupts
>       3906 ± 43%   +5029.0%     200382 ±  6%  interrupts.CPU131.CAL:Function_call_interrupts
>       2150 ± 68%   +2139.5%      48167 ± 13%  interrupts.CPU131.RES:Rescheduling_interrupts
>       3818 ± 45%   +5113.6%     199080 ±  6%  interrupts.CPU132.CAL:Function_call_interrupts
>       1515 ± 52%   +3075.5%      48113 ± 14%  interrupts.CPU132.RES:Rescheduling_interrupts
>       3813 ± 44%   +5113.5%     198815 ±  6%  interrupts.CPU133.CAL:Function_call_interrupts
>       2258 ± 42%   +2046.2%      48464 ± 14%  interrupts.CPU133.RES:Rescheduling_interrupts
>       3837 ± 43%   +5116.6%     200187 ±  6%  interrupts.CPU134.CAL:Function_call_interrupts
>       1922 ± 42%   +2432.6%      48677 ± 14%  interrupts.CPU134.RES:Rescheduling_interrupts
>       3907 ± 42%   +5033.3%     200602 ±  6%  interrupts.CPU135.CAL:Function_call_interrupts
>       2667 ± 44%   +1714.2%      48394 ± 13%  interrupts.CPU135.RES:Rescheduling_interrupts
>       3754 ± 43%   +5199.8%     198996 ±  7%  interrupts.CPU136.CAL:Function_call_interrupts
>       1924 ± 59%   +2410.0%      48300 ± 13%  interrupts.CPU136.RES:Rescheduling_interrupts
>       3853 ± 42%   +5070.9%     199261 ±  6%  interrupts.CPU137.CAL:Function_call_interrupts
>       2830 ± 63%   +1602.9%      48195 ± 13%  interrupts.CPU137.RES:Rescheduling_interrupts
>       3937 ± 46%   +4996.8%     200678 ±  6%  interrupts.CPU138.CAL:Function_call_interrupts
>       1753 ± 41%   +2649.4%      48196 ± 13%  interrupts.CPU138.RES:Rescheduling_interrupts
>       3807 ± 43%   +5193.6%     201572 ±  6%  interrupts.CPU139.CAL:Function_call_interrupts
>       1365 ± 39%   +3462.0%      48651 ± 14%  interrupts.CPU139.RES:Rescheduling_interrupts
>       4296 ± 51%   +4937.4%     216447 ±  5%  interrupts.CPU14.CAL:Function_call_interrupts
>       2288 ± 51%   +2061.3%      49461 ± 13%  interrupts.CPU14.RES:Rescheduling_interrupts
>       3937 ± 44%   +5023.7%     201754 ±  6%  interrupts.CPU140.CAL:Function_call_interrupts
>       1704 ± 56%   +2752.1%      48623 ± 14%  interrupts.CPU140.RES:Rescheduling_interrupts
>       3782 ± 45%   +5116.1%     197308 ±  6%  interrupts.CPU141.CAL:Function_call_interrupts
>       1479 ± 28%   +3180.1%      48534 ± 14%  interrupts.CPU141.RES:Rescheduling_interrupts
>       3818 ± 44%   +5085.1%     198011 ±  6%  interrupts.CPU142.CAL:Function_call_interrupts
>       1522 ± 35%   +3050.8%      47965 ± 14%  interrupts.CPU142.RES:Rescheduling_interrupts
>       3908 ± 40%   +4969.2%     198112 ±  7%  interrupts.CPU143.CAL:Function_call_interrupts
>       2302 ± 42%   +1985.8%      48033 ± 13%  interrupts.CPU143.RES:Rescheduling_interrupts
>       4198 ± 60%   +4728.9%     202725 ±  7%  interrupts.CPU144.CAL:Function_call_interrupts
>       2144 ± 44%   +2075.5%      46646 ± 16%  interrupts.CPU144.RES:Rescheduling_interrupts
>       4255 ± 59%   +4699.2%     204206 ±  7%  interrupts.CPU145.CAL:Function_call_interrupts
>       1642 ± 43%   +2735.8%      46569 ± 16%  interrupts.CPU145.RES:Rescheduling_interrupts
>       4283 ± 57%   +4650.5%     203470 ±  7%  interrupts.CPU146.CAL:Function_call_interrupts
>       2927 ± 51%   +1485.1%      46394 ± 16%  interrupts.CPU146.RES:Rescheduling_interrupts
>       4292 ± 59%   +4667.7%     204668 ±  7%  interrupts.CPU147.CAL:Function_call_interrupts
>       2432 ± 39%   +1809.5%      46441 ± 16%  interrupts.CPU147.RES:Rescheduling_interrupts
>       4268 ± 58%   +4662.4%     203291 ±  7%  interrupts.CPU148.CAL:Function_call_interrupts
>       1587 ± 49%   +2815.5%      46293 ± 16%  interrupts.CPU148.RES:Rescheduling_interrupts
>       4283 ± 58%   +4628.4%     202555 ±  7%  interrupts.CPU149.CAL:Function_call_interrupts
>       2238 ± 37%   +1962.7%      46179 ± 16%  interrupts.CPU149.RES:Rescheduling_interrupts
>       4342 ± 54%   +4878.5%     216208 ±  5%  interrupts.CPU15.CAL:Function_call_interrupts
>       2941 ± 37%   +1579.8%      49415 ± 12%  interrupts.CPU15.RES:Rescheduling_interrupts
>       4304 ± 58%   +4604.5%     202480 ±  7%  interrupts.CPU150.CAL:Function_call_interrupts
>       2828 ± 63%   +1527.5%      46040 ± 16%  interrupts.CPU150.RES:Rescheduling_interrupts
>       4385 ± 54%   +4513.1%     202284 ±  7%  interrupts.CPU151.CAL:Function_call_interrupts
>       2372 ± 43%   +1854.2%      46363 ± 16%  interrupts.CPU151.RES:Rescheduling_interrupts
>       4298 ± 58%   +4602.3%     202137 ±  7%  interrupts.CPU152.CAL:Function_call_interrupts
>       2039 ± 50%   +2176.7%      46432 ± 15%  interrupts.CPU152.RES:Rescheduling_interrupts
>       4270 ± 59%   +4644.4%     202594 ±  7%  interrupts.CPU153.CAL:Function_call_interrupts
>       1962 ± 45%   +2253.4%      46181 ± 16%  interrupts.CPU153.RES:Rescheduling_interrupts
>       4191 ± 59%   +4687.4%     200640 ±  8%  interrupts.CPU154.CAL:Function_call_interrupts
>       1609 ± 46%   +2775.9%      46273 ± 16%  interrupts.CPU154.RES:Rescheduling_interrupts
>       4140 ± 57%   +4800.0%     202885 ±  7%  interrupts.CPU155.CAL:Function_call_interrupts
>       2165 ± 44%   +2030.1%      46133 ± 16%  interrupts.CPU155.RES:Rescheduling_interrupts
>       4221 ± 59%   +4677.0%     201676 ±  7%  interrupts.CPU156.CAL:Function_call_interrupts
>       2264 ± 76%   +1940.9%      46219 ± 16%  interrupts.CPU156.RES:Rescheduling_interrupts
>       4276 ± 60%   +4594.6%     200757 ±  8%  interrupts.CPU157.CAL:Function_call_interrupts
>       2595 ± 47%   +1687.2%      46378 ± 16%  interrupts.CPU157.RES:Rescheduling_interrupts
>       4244 ± 59%   +4686.9%     203195 ±  7%  interrupts.CPU158.CAL:Function_call_interrupts
>       2996 ± 51%   +1442.7%      46227 ± 16%  interrupts.CPU158.RES:Rescheduling_interrupts
>       4309 ± 58%   +4605.3%     202774 ±  7%  interrupts.CPU159.CAL:Function_call_interrupts
>       2074 ± 54%   +2139.7%      46465 ± 16%  interrupts.CPU159.RES:Rescheduling_interrupts
>       4303 ± 51%   +4880.5%     214313 ±  6%  interrupts.CPU16.CAL:Function_call_interrupts
>       2065 ± 48%   +2290.8%      49375 ± 12%  interrupts.CPU16.RES:Rescheduling_interrupts
>       4459 ± 57%   +4455.5%     203129 ±  7%  interrupts.CPU160.CAL:Function_call_interrupts
>       2967 ± 25%   +1462.5%      46371 ± 16%  interrupts.CPU160.RES:Rescheduling_interrupts
>       4397 ± 56%   +4459.5%     200497 ±  7%  interrupts.CPU161.CAL:Function_call_interrupts
>       2267 ± 53%   +1951.8%      46514 ± 18%  interrupts.CPU161.RES:Rescheduling_interrupts
>       4330 ± 59%   +4554.4%     201543 ±  7%  interrupts.CPU162.CAL:Function_call_interrupts
>       2667 ± 37%   +1641.9%      46460 ± 16%  interrupts.CPU162.RES:Rescheduling_interrupts
>       4401 ± 55%   +4524.8%     203561 ±  7%  interrupts.CPU163.CAL:Function_call_interrupts
>       3247 ± 44%   +1332.5%      46524 ± 16%  interrupts.CPU163.RES:Rescheduling_interrupts
>       4187 ± 57%   +4706.3%     201246 ±  7%  interrupts.CPU164.CAL:Function_call_interrupts
>       1821 ± 36%   +2442.8%      46317 ± 16%  interrupts.CPU164.RES:Rescheduling_interrupts
>       4227 ± 52%   +4641.5%     200438 ±  7%  interrupts.CPU165.CAL:Function_call_interrupts
>       2505 ± 38%   +1750.3%      46353 ± 16%  interrupts.CPU165.RES:Rescheduling_interrupts
>       4266 ± 60%   +4654.7%     202859 ±  7%  interrupts.CPU166.CAL:Function_call_interrupts
>       1935 ± 46%   +2293.6%      46316 ± 16%  interrupts.CPU166.RES:Rescheduling_interrupts
>       4165 ± 56%   +4731.5%     201230 ±  7%  interrupts.CPU167.CAL:Function_call_interrupts
>       2339 ± 37%   +1870.9%      46105 ± 16%  interrupts.CPU167.RES:Rescheduling_interrupts
>       6514 ± 44%   +2873.2%     193677 ±  3%  interrupts.CPU168.CAL:Function_call_interrupts
>       3170 ± 46%   +1436.3%      48704 ± 10%  interrupts.CPU168.RES:Rescheduling_interrupts
>       6459 ± 44%   +2847.6%     190411 ±  9%  interrupts.CPU169.CAL:Function_call_interrupts
>       2702 ± 27%   +1619.8%      46470 ± 10%  interrupts.CPU169.RES:Rescheduling_interrupts
>       4276 ± 51%   +4910.0%     214269 ±  5%  interrupts.CPU17.CAL:Function_call_interrupts
>       2058 ± 48%   +2281.8%      49030 ± 12%  interrupts.CPU17.RES:Rescheduling_interrupts
>       6439 ± 43%   +2942.9%     195932 ±  4%  interrupts.CPU170.CAL:Function_call_interrupts
>       3072 ± 23%   +1485.4%      48709 ± 10%  interrupts.CPU170.RES:Rescheduling_interrupts
>       6423 ± 44%   +2980.6%     197881 ±  4%  interrupts.CPU171.CAL:Function_call_interrupts
>       2570 ± 45%   +1779.0%      48307 ± 10%  interrupts.CPU171.RES:Rescheduling_interrupts
>       6399 ± 42%   +2924.6%     193558 ±  4%  interrupts.CPU172.CAL:Function_call_interrupts
>       3087 ± 24%   +1470.7%      48491 ± 10%  interrupts.CPU172.RES:Rescheduling_interrupts
>       6293 ± 43%   +2967.2%     193037 ±  4%  interrupts.CPU173.CAL:Function_call_interrupts
>       2488 ± 49%   +1827.3%      47968 ± 10%  interrupts.CPU173.RES:Rescheduling_interrupts
>       6385 ± 43%   +2941.0%     194196 ±  4%  interrupts.CPU174.CAL:Function_call_interrupts
>       2925 ± 56%   +1545.4%      48126 ± 10%  interrupts.CPU174.RES:Rescheduling_interrupts
>       6382 ± 44%   +2917.9%     192611 ±  4%  interrupts.CPU175.CAL:Function_call_interrupts
>       2941 ± 45%   +1552.6%      48608 ± 10%  interrupts.CPU175.RES:Rescheduling_interrupts
>       6500 ± 43%   +2867.8%     192906 ±  4%  interrupts.CPU176.CAL:Function_call_interrupts
>       2416 ± 45%   +1913.1%      48643 ± 10%  interrupts.CPU176.RES:Rescheduling_interrupts
>       6466 ± 44%   +2900.9%     194049 ±  4%  interrupts.CPU177.CAL:Function_call_interrupts
>       3317 ± 29%   +1363.4%      48542 ± 10%  interrupts.CPU177.RES:Rescheduling_interrupts
>       6335 ± 43%   +2907.6%     190551 ±  4%  interrupts.CPU178.CAL:Function_call_interrupts
>       2739 ± 50%   +1659.1%      48186 ± 10%  interrupts.CPU178.RES:Rescheduling_interrupts
>       6440 ± 44%   +2905.8%     193583 ±  4%  interrupts.CPU179.CAL:Function_call_interrupts
>       3212 ± 54%   +1400.2%      48189 ± 10%  interrupts.CPU179.RES:Rescheduling_interrupts
>       4346 ± 52%   +4869.8%     216003 ±  5%  interrupts.CPU18.CAL:Function_call_interrupts
>       2773 ± 23%   +1668.4%      49037 ± 12%  interrupts.CPU18.RES:Rescheduling_interrupts
>       6207 ± 45%   +3007.1%     192868 ±  4%  interrupts.CPU180.CAL:Function_call_interrupts
>       3346 ± 42%   +1345.2%      48361 ± 11%  interrupts.CPU180.RES:Rescheduling_interrupts
>       6340 ± 44%   +2895.0%     189907 ±  4%  interrupts.CPU181.CAL:Function_call_interrupts
>       2838 ± 56%   +1575.8%      47563 ± 11%  interrupts.CPU181.RES:Rescheduling_interrupts
>       6365 ± 43%   +2934.2%     193143 ±  4%  interrupts.CPU182.CAL:Function_call_interrupts
>       2646 ± 45%   +1745.8%      48853 ± 10%  interrupts.CPU182.RES:Rescheduling_interrupts
>       6316 ± 44%   +2940.0%     192012 ±  4%  interrupts.CPU183.CAL:Function_call_interrupts
>       3058 ± 38%   +1485.0%      48481 ± 10%  interrupts.CPU183.RES:Rescheduling_interrupts
>       6472 ± 43%   +2888.3%     193422 ±  4%  interrupts.CPU184.CAL:Function_call_interrupts
>       3005 ± 44%   +1508.6%      48348 ± 10%  interrupts.CPU184.RES:Rescheduling_interrupts
>       6309 ± 43%   +2947.5%     192281 ±  4%  interrupts.CPU185.CAL:Function_call_interrupts
>       2506 ± 48%   +1817.2%      48050 ± 10%  interrupts.CPU185.RES:Rescheduling_interrupts
>       6266 ± 43%   +2954.5%     191418 ±  4%  interrupts.CPU186.CAL:Function_call_interrupts
>       2559 ± 48%   +1791.2%      48396 ± 10%  interrupts.CPU186.RES:Rescheduling_interrupts
>       6411 ± 42%   +2941.6%     195019 ±  4%  interrupts.CPU187.CAL:Function_call_interrupts
>       3056 ± 44%   +1483.4%      48396 ± 10%  interrupts.CPU187.RES:Rescheduling_interrupts
>       6412 ± 43%   +2920.5%     193697 ±  5%  interrupts.CPU188.CAL:Function_call_interrupts
>       2539 ± 35%   +1803.0%      48329 ± 10%  interrupts.CPU188.RES:Rescheduling_interrupts
>       6250 ± 43%   +2958.8%     191179 ±  4%  interrupts.CPU189.CAL:Function_call_interrupts
>       2696 ± 37%   +1697.4%      48464 ± 10%  interrupts.CPU189.RES:Rescheduling_interrupts
>       4352 ± 53%   +4888.8%     217146 ±  5%  interrupts.CPU19.CAL:Function_call_interrupts
>       1970 ± 41%   +2394.5%      49161 ± 12%  interrupts.CPU19.RES:Rescheduling_interrupts
>       6245 ± 44%   +2971.5%     191834 ±  4%  interrupts.CPU190.CAL:Function_call_interrupts
>       2710 ± 37%   +1671.5%      48008 ± 10%  interrupts.CPU190.RES:Rescheduling_interrupts
>       6404 ± 41%   +2777.1%     184260 ±  4%  interrupts.CPU191.CAL:Function_call_interrupts
>       2449 ± 41%   +1799.2%      46510 ± 10%  interrupts.CPU191.RES:Rescheduling_interrupts
>       4527 ± 57%   +4552.3%     210625 ±  6%  interrupts.CPU2.CAL:Function_call_interrupts
>       1940 ± 39%   +2376.1%      48057 ± 18%  interrupts.CPU2.RES:Rescheduling_interrupts
>       7.50 ±152%   +1506.7%     120.50 ± 70%  interrupts.CPU2.TLB:TLB_shootdowns
>       4375 ± 52%   +4840.8%     216158 ±  5%  interrupts.CPU20.CAL:Function_call_interrupts
>       2963 ± 32%   +1561.7%      49236 ± 12%  interrupts.CPU20.RES:Rescheduling_interrupts
>       4404 ± 55%   +4774.1%     214678 ±  6%  interrupts.CPU21.CAL:Function_call_interrupts
>       1918 ± 42%   +2460.1%      49124 ± 12%  interrupts.CPU21.RES:Rescheduling_interrupts
>       4408 ± 54%   +4736.4%     213197 ±  6%  interrupts.CPU22.CAL:Function_call_interrupts
>       2135 ± 45%   +2196.0%      49039 ± 12%  interrupts.CPU22.RES:Rescheduling_interrupts
>       4298 ± 57%   +4878.8%     214013 ±  6%  interrupts.CPU23.CAL:Function_call_interrupts
>       2044 ± 53%   +2288.2%      48823 ± 12%  interrupts.CPU23.RES:Rescheduling_interrupts
>       3872 ± 40%   +5034.3%     198807 ±  6%  interrupts.CPU24.CAL:Function_call_interrupts
>       2057 ± 50%   +2331.8%      50035 ± 14%  interrupts.CPU24.RES:Rescheduling_interrupts
>       3623 ± 38%   +5365.7%     198067 ±  6%  interrupts.CPU25.CAL:Function_call_interrupts
>       2720 ± 16%   +1730.8%      49803 ± 14%  interrupts.CPU25.RES:Rescheduling_interrupts
>       3893 ± 40%   +4987.4%     198095 ±  6%  interrupts.CPU26.CAL:Function_call_interrupts
>       2743 ± 36%   +1714.9%      49786 ± 13%  interrupts.CPU26.RES:Rescheduling_interrupts
>       3171 ± 35%   +6270.5%     202007 ±  6%  interrupts.CPU27.CAL:Function_call_interrupts
>       2258 ± 51%   +2108.3%      49881 ± 13%  interrupts.CPU27.RES:Rescheduling_interrupts
>       3947 ± 44%   +5018.0%     202050 ±  6%  interrupts.CPU28.CAL:Function_call_interrupts
>       1710 ± 43%   +2800.3%      49618 ± 13%  interrupts.CPU28.RES:Rescheduling_interrupts
>       3893 ± 42%   +5058.8%     200875 ±  6%  interrupts.CPU29.CAL:Function_call_interrupts
>       1890 ± 44%   +2513.3%      49395 ± 13%  interrupts.CPU29.RES:Rescheduling_interrupts
>       4307 ± 52%   +4925.4%     216468 ±  5%  interrupts.CPU3.CAL:Function_call_interrupts
>       2522 ± 39%   +1859.2%      49417 ± 12%  interrupts.CPU3.RES:Rescheduling_interrupts
>       3946 ± 43%   +5013.8%     201790 ±  6%  interrupts.CPU30.CAL:Function_call_interrupts
>       2078 ± 35%   +2280.1%      49473 ± 13%  interrupts.CPU30.RES:Rescheduling_interrupts
>       3885 ± 44%   +5113.6%     202558 ±  5%  interrupts.CPU31.CAL:Function_call_interrupts
>       2258 ± 37%   +2105.2%      49797 ± 13%  interrupts.CPU31.RES:Rescheduling_interrupts
>       3808 ± 43%   +5188.3%     201388 ±  6%  interrupts.CPU32.CAL:Function_call_interrupts
>       1944 ± 66%   +2460.9%      49784 ± 13%  interrupts.CPU32.RES:Rescheduling_interrupts
>       3868 ± 40%   +5112.1%     201640 ±  6%  interrupts.CPU33.CAL:Function_call_interrupts
>       2494 ± 35%   +1890.5%      49659 ± 14%  interrupts.CPU33.RES:Rescheduling_interrupts
>       3937 ± 39%   +5056.1%     203021 ±  5%  interrupts.CPU34.CAL:Function_call_interrupts
>       3325 ± 90%   +1395.7%      49743 ± 13%  interrupts.CPU34.RES:Rescheduling_interrupts
>       3744 ± 41%   +5252.6%     200402 ±  6%  interrupts.CPU35.CAL:Function_call_interrupts
>       1950 ± 46%   +2434.8%      49445 ± 13%  interrupts.CPU35.RES:Rescheduling_interrupts
>       3819 ± 44%   +5167.9%     201217 ±  6%  interrupts.CPU36.CAL:Function_call_interrupts
>       2487 ± 72%   +1886.2%      49398 ± 14%  interrupts.CPU36.RES:Rescheduling_interrupts
>       3737 ± 42%   +5268.2%     200611 ±  6%  interrupts.CPU37.CAL:Function_call_interrupts
>       2687 ± 51%   +1750.7%      49741 ± 14%  interrupts.CPU37.RES:Rescheduling_interrupts
>       3844 ± 43%   +5162.3%     202325 ±  5%  interrupts.CPU38.CAL:Function_call_interrupts
>       2550 ± 45%   +1849.5%      49724 ± 14%  interrupts.CPU38.RES:Rescheduling_interrupts
>       3830 ± 41%   +5223.4%     203887 ±  6%  interrupts.CPU39.CAL:Function_call_interrupts
>       2655 ± 60%   +1764.0%      49505 ± 14%  interrupts.CPU39.RES:Rescheduling_interrupts
>       4259 ± 55%   +4997.8%     217159 ±  5%  interrupts.CPU4.CAL:Function_call_interrupts
>       2189 ± 56%   +2159.5%      49480 ± 12%  interrupts.CPU4.RES:Rescheduling_interrupts
>       3803 ± 41%   +5185.6%     201036 ±  6%  interrupts.CPU40.CAL:Function_call_interrupts
>       1761 ± 31%   +2711.3%      49517 ± 14%  interrupts.CPU40.RES:Rescheduling_interrupts
>       3911 ± 40%   +5034.2%     200833 ±  6%  interrupts.CPU41.CAL:Function_call_interrupts
>       2847 ± 57%   +1629.9%      49259 ± 14%  interrupts.CPU41.RES:Rescheduling_interrupts
>       3900 ± 42%   +5056.7%     201139 ±  6%  interrupts.CPU42.CAL:Function_call_interrupts
>       2469 ± 58%   +1890.6%      49158 ± 13%  interrupts.CPU42.RES:Rescheduling_interrupts
>       3866 ± 43%   +5149.0%     202933 ±  6%  interrupts.CPU43.CAL:Function_call_interrupts
>       1781 ± 40%   +2682.9%      49572 ± 14%  interrupts.CPU43.RES:Rescheduling_interrupts
>       3939 ± 44%   +5039.8%     202475 ±  6%  interrupts.CPU44.CAL:Function_call_interrupts
>       2017 ± 67%   +2366.7%      49756 ± 13%  interrupts.CPU44.RES:Rescheduling_interrupts
>       3964 ± 43%   +4940.1%     199824 ±  6%  interrupts.CPU45.CAL:Function_call_interrupts
>       1626 ± 34%   +2957.4%      49713 ± 14%  interrupts.CPU45.RES:Rescheduling_interrupts
>       3821 ± 43%   +5145.8%     200442 ±  6%  interrupts.CPU46.CAL:Function_call_interrupts
>       1665 ± 46%   +2862.3%      49322 ± 13%  interrupts.CPU46.RES:Rescheduling_interrupts
>       3889 ± 43%   +4990.6%     197974 ±  6%  interrupts.CPU47.CAL:Function_call_interrupts
>       2447 ± 49%   +1914.5%      49300 ± 13%  interrupts.CPU47.RES:Rescheduling_interrupts
>       4255 ± 59%   +4642.5%     201810 ±  6%  interrupts.CPU48.CAL:Function_call_interrupts
>       2231 ± 40%   +2059.6%      48185 ± 15%  interrupts.CPU48.RES:Rescheduling_interrupts
>       4322 ± 59%   +4576.0%     202110 ±  7%  interrupts.CPU49.CAL:Function_call_interrupts
>       1896 ± 57%   +2425.7%      47904 ± 16%  interrupts.CPU49.RES:Rescheduling_interrupts
>       4200 ± 50%   +5034.7%     215699 ±  5%  interrupts.CPU5.CAL:Function_call_interrupts
>       2530 ± 61%   +1837.3%      49027 ± 12%  interrupts.CPU5.RES:Rescheduling_interrupts
>       4224 ± 61%   +4714.4%     203377 ±  6%  interrupts.CPU50.CAL:Function_call_interrupts
>       2272 ± 53%   +2009.7%      47951 ± 15%  interrupts.CPU50.RES:Rescheduling_interrupts
>       4235 ± 58%   +4715.4%     203946 ±  7%  interrupts.CPU51.CAL:Function_call_interrupts
>       2536 ± 42%   +1778.4%      47640 ± 16%  interrupts.CPU51.RES:Rescheduling_interrupts
>       4161 ± 59%   +4766.0%     202504 ±  7%  interrupts.CPU52.CAL:Function_call_interrupts
>       1890 ± 54%   +2429.5%      47816 ± 16%  interrupts.CPU52.RES:Rescheduling_interrupts
>       4247 ± 58%   +4673.7%     202779 ±  6%  interrupts.CPU53.CAL:Function_call_interrupts
>       2904 ± 50%   +1534.4%      47477 ± 16%  interrupts.CPU53.RES:Rescheduling_interrupts
>       4295 ± 57%   +4595.2%     201683 ±  7%  interrupts.CPU54.CAL:Function_call_interrupts
>       2110 ± 33%   +2145.2%      47378 ± 16%  interrupts.CPU54.RES:Rescheduling_interrupts
>       4146 ± 59%   +4798.4%     203102 ±  7%  interrupts.CPU55.CAL:Function_call_interrupts
>       2259 ± 34%   +2003.3%      47517 ± 16%  interrupts.CPU55.RES:Rescheduling_interrupts
>       4204 ± 58%   +4734.8%     203285 ±  7%  interrupts.CPU56.CAL:Function_call_interrupts
>       2229 ± 58%   +2045.6%      47824 ± 16%  interrupts.CPU56.RES:Rescheduling_interrupts
>       4170 ± 59%   +4767.2%     203004 ±  7%  interrupts.CPU57.CAL:Function_call_interrupts
>       2084 ± 56%   +2186.6%      47657 ± 16%  interrupts.CPU57.RES:Rescheduling_interrupts
>       4210 ± 60%   +4741.1%     203817 ±  6%  interrupts.CPU58.CAL:Function_call_interrupts
>       5631 ± 35%     +38.3%       7787 ± 20%  interrupts.CPU58.NMI:Non-maskable_interrupts
>       5631 ± 35%     +38.3%       7787 ± 20%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
>       1643 ± 46%   +2786.5%      47448 ± 16%  interrupts.CPU58.RES:Rescheduling_interrupts
>       4255 ± 60%   +4711.1%     204752 ±  7%  interrupts.CPU59.CAL:Function_call_interrupts
>       2161 ± 40%   +2085.4%      47241 ± 16%  interrupts.CPU59.RES:Rescheduling_interrupts
>       4298 ± 51%   +4854.5%     212967 ±  7%  interrupts.CPU6.CAL:Function_call_interrupts
>       2083 ± 38%   +2209.0%      48096 ± 13%  interrupts.CPU6.RES:Rescheduling_interrupts
>       4238 ± 60%   +4670.6%     202218 ±  7%  interrupts.CPU60.CAL:Function_call_interrupts
>       2266 ± 52%   +1999.6%      47595 ± 16%  interrupts.CPU60.RES:Rescheduling_interrupts
>       4256 ± 61%   +4655.9%     202443 ±  7%  interrupts.CPU61.CAL:Function_call_interrupts
>       2921 ± 43%   +1539.0%      47874 ± 15%  interrupts.CPU61.RES:Rescheduling_interrupts
>       4284 ± 60%   +4646.8%     203361 ±  7%  interrupts.CPU62.CAL:Function_call_interrupts
>       2737 ± 56%   +1631.0%      47383 ± 16%  interrupts.CPU62.RES:Rescheduling_interrupts
>       4266 ± 58%   +4641.7%     202303 ±  7%  interrupts.CPU63.CAL:Function_call_interrupts
>       2016 ± 52%   +2262.9%      47655 ± 16%  interrupts.CPU63.RES:Rescheduling_interrupts
>       4453 ± 60%   +4479.7%     203941 ±  6%  interrupts.CPU64.CAL:Function_call_interrupts
>       2809 ± 26%   +1602.9%      47843 ± 15%  interrupts.CPU64.RES:Rescheduling_interrupts
>       4299 ± 59%   +4620.0%     202913 ±  6%  interrupts.CPU65.CAL:Function_call_interrupts
>       2187 ± 32%   +2057.8%      47208 ± 16%  interrupts.CPU65.RES:Rescheduling_interrupts
>       4406 ± 57%   +4493.2%     202378 ±  7%  interrupts.CPU66.CAL:Function_call_interrupts
>       2637 ± 42%   +1706.3%      47633 ± 15%  interrupts.CPU66.RES:Rescheduling_interrupts
>       4397 ± 56%   +4546.7%     204353 ±  7%  interrupts.CPU67.CAL:Function_call_interrupts
>       3138 ± 36%   +1419.8%      47699 ± 16%  interrupts.CPU67.RES:Rescheduling_interrupts
>       4261 ± 60%   +4641.1%     202035 ±  7%  interrupts.CPU68.CAL:Function_call_interrupts
>       1874 ± 50%   +2436.6%      47549 ± 16%  interrupts.CPU68.RES:Rescheduling_interrupts
>       4159 ± 58%   +4755.4%     201944 ±  6%  interrupts.CPU69.CAL:Function_call_interrupts
>       3127 ± 29%   +1417.0%      47441 ± 16%  interrupts.CPU69.RES:Rescheduling_interrupts
>       4232 ± 53%   +4973.7%     214759 ±  5%  interrupts.CPU7.CAL:Function_call_interrupts
>       2427 ± 54%   +1932.2%      49331 ± 12%  interrupts.CPU7.RES:Rescheduling_interrupts
>       4317 ± 58%   +4589.3%     202460 ±  7%  interrupts.CPU70.CAL:Function_call_interrupts
>       2882 ± 68%   +1544.4%      47402 ± 16%  interrupts.CPU70.RES:Rescheduling_interrupts
>       4206 ± 57%   +4690.5%     201521 ±  6%  interrupts.CPU71.CAL:Function_call_interrupts
>       2059 ± 31%   +2192.6%      47220 ± 16%  interrupts.CPU71.RES:Rescheduling_interrupts
>       5897 ± 49%   +3199.1%     194573 ±  4%  interrupts.CPU72.CAL:Function_call_interrupts
>       3160 ± 35%   +1487.7%      50174 ± 10%  interrupts.CPU72.RES:Rescheduling_interrupts
>       6303 ± 43%   +2959.1%     192823 ±  6%  interrupts.CPU73.CAL:Function_call_interrupts
>       2707 ± 29%   +1706.9%      48916 ±  9%  interrupts.CPU73.RES:Rescheduling_interrupts
>       6229 ± 42%   +3036.2%     195381 ±  4%  interrupts.CPU74.CAL:Function_call_interrupts
>       2958 ± 29%   +1588.0%      49930 ± 10%  interrupts.CPU74.RES:Rescheduling_interrupts
>       6316 ± 43%   +3028.5%     197612 ±  4%  interrupts.CPU75.CAL:Function_call_interrupts
>       2711 ± 39%   +1734.6%      49734 ± 10%  interrupts.CPU75.RES:Rescheduling_interrupts
>       6326 ± 44%   +2977.5%     194700 ±  4%  interrupts.CPU76.CAL:Function_call_interrupts
>       3461 ± 25%   +1337.3%      49756 ± 10%  interrupts.CPU76.RES:Rescheduling_interrupts
>       6321 ± 42%   +2973.2%     194282 ±  5%  interrupts.CPU77.CAL:Function_call_interrupts
>       2726 ± 41%   +1714.9%      49482 ± 10%  interrupts.CPU77.RES:Rescheduling_interrupts
>       6242 ± 43%   +3038.1%     195890 ±  5%  interrupts.CPU78.CAL:Function_call_interrupts
>       2930 ± 47%   +1581.9%      49282 ± 10%  interrupts.CPU78.RES:Rescheduling_interrupts
>       6299 ± 43%   +3005.7%     195630 ±  4%  interrupts.CPU79.CAL:Function_call_interrupts
>       3306 ± 53%   +1401.3%      49644 ± 10%  interrupts.CPU79.RES:Rescheduling_interrupts
>       4346 ± 49%   +4862.7%     215685 ±  5%  interrupts.CPU8.CAL:Function_call_interrupts
>       2393 ± 32%   +1960.5%      49315 ± 12%  interrupts.CPU8.RES:Rescheduling_interrupts
>       6357 ± 43%   +2978.7%     195728 ±  4%  interrupts.CPU80.CAL:Function_call_interrupts
>       2917 ± 34%   +1602.5%      49665 ± 10%  interrupts.CPU80.RES:Rescheduling_interrupts
>       6358 ± 43%   +2984.8%     196154 ±  4%  interrupts.CPU81.CAL:Function_call_interrupts
>       3319 ± 29%   +1395.8%      49646 ± 10%  interrupts.CPU81.RES:Rescheduling_interrupts
>       6258 ± 43%   +3019.1%     195203 ±  5%  interrupts.CPU82.CAL:Function_call_interrupts
>       3142 ± 46%   +1478.9%      49612 ± 10%  interrupts.CPU82.RES:Rescheduling_interrupts
>       6443 ± 44%   +2958.3%     197053 ±  4%  interrupts.CPU83.CAL:Function_call_interrupts
>       2678 ± 51%   +1743.7%      49387 ± 10%  interrupts.CPU83.RES:Rescheduling_interrupts
>       6273 ± 44%   +3004.0%     194737 ±  4%  interrupts.CPU84.CAL:Function_call_interrupts
>       3205 ± 57%   +1448.1%      49625 ± 10%  interrupts.CPU84.RES:Rescheduling_interrupts
>       6345 ± 44%   +2861.5%     187923 ±  9%  interrupts.CPU85.CAL:Function_call_interrupts
>       2984 ± 48%   +1497.8%      47681 ± 14%  interrupts.CPU85.RES:Rescheduling_interrupts
>       6227 ± 43%   +3050.2%     196160 ±  4%  interrupts.CPU86.CAL:Function_call_interrupts
>       3442 ± 24%   +1342.2%      49643 ± 10%  interrupts.CPU86.RES:Rescheduling_interrupts
>       6385 ± 44%   +2944.4%     194389 ±  4%  interrupts.CPU87.CAL:Function_call_interrupts
>       3299 ± 36%   +1396.9%      49387 ± 10%  interrupts.CPU87.RES:Rescheduling_interrupts
>       6432 ± 43%   +2969.7%     197465 ±  5%  interrupts.CPU88.CAL:Function_call_interrupts
>       3578 ± 43%   +1284.0%      49527 ± 10%  interrupts.CPU88.RES:Rescheduling_interrupts
>       6263 ± 44%   +3012.8%     194967 ±  4%  interrupts.CPU89.CAL:Function_call_interrupts
>       2479 ± 49%   +1895.0%      49465 ± 10%  interrupts.CPU89.RES:Rescheduling_interrupts
>       4242 ± 51%   +4946.7%     214099 ±  5%  interrupts.CPU9.CAL:Function_call_interrupts
>       2584 ± 36%   +1814.6%      49484 ± 12%  interrupts.CPU9.RES:Rescheduling_interrupts
>       6479 ± 43%   +2884.4%     193363 ±  4%  interrupts.CPU90.CAL:Function_call_interrupts
>       3014 ± 44%   +1542.1%      49491 ± 10%  interrupts.CPU90.RES:Rescheduling_interrupts
>       6406 ± 44%   +2968.7%     196586 ±  4%  interrupts.CPU91.CAL:Function_call_interrupts
>       3035 ± 49%   +1534.7%      49614 ± 10%  interrupts.CPU91.RES:Rescheduling_interrupts
>       6361 ± 43%   +2980.5%     195973 ±  5%  interrupts.CPU92.CAL:Function_call_interrupts
>       2818 ± 42%   +1661.2%      49641 ± 10%  interrupts.CPU92.RES:Rescheduling_interrupts
>       6369 ± 43%   +2947.5%     194095 ±  4%  interrupts.CPU93.CAL:Function_call_interrupts
>       3916 ± 38%   +1164.0%      49499 ± 10%  interrupts.CPU93.RES:Rescheduling_interrupts
>       6457 ± 44%   +2927.1%     195472 ±  4%  interrupts.CPU94.CAL:Function_call_interrupts
>       2911 ± 33%   +1597.4%      49424 ± 10%  interrupts.CPU94.RES:Rescheduling_interrupts
>       6452 ± 44%   +2898.0%     193430 ±  4%  interrupts.CPU95.CAL:Function_call_interrupts
>       2949 ± 36%   +1567.0%      49161 ± 10%  interrupts.CPU95.RES:Rescheduling_interrupts
>       4536 ± 58%   +4436.2%     205770 ±  5%  interrupts.CPU96.CAL:Function_call_interrupts
>       3100 ± 52%   +1387.5%      46115 ± 15%  interrupts.CPU96.RES:Rescheduling_interrupts
>       4475 ± 55%   +4697.3%     214709 ±  6%  interrupts.CPU97.CAL:Function_call_interrupts
>       1921 ± 39%   +2399.4%      48013 ± 13%  interrupts.CPU97.RES:Rescheduling_interrupts
>       4606 ± 55%   +4454.2%     209780 ±  8%  interrupts.CPU98.CAL:Function_call_interrupts
>       2177 ± 41%   +2049.1%      46800 ± 18%  interrupts.CPU98.RES:Rescheduling_interrupts
>       4457 ± 55%   +4744.4%     215945 ±  5%  interrupts.CPU99.CAL:Function_call_interrupts
>       2576 ± 37%   +1767.7%      48126 ± 12%  interrupts.CPU99.RES:Rescheduling_interrupts
>       2949 ± 14%    +213.1%       9236        interrupts.IWI:IRQ_work_interrupts
>     471799 ± 22%   +1865.5%    9273438 ± 11%  interrupts.RES:Rescheduling_interrupts
>      96.09           -18.5       77.54        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>      87.16           -10.5       76.63        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      64.87            -8.9       55.99        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      64.62            -8.7       55.94        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      63.28            -7.7       55.54        perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       8.03            -7.3        0.76        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>       7.45            -7.2        0.26 ±100%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>      62.18            -6.8       55.34        perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
>      60.69            -5.7       55.03        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
>       7.35            -5.3        2.00        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
>       5.15            -5.2        0.00        perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>       5.38 ±  2%      -4.2        1.18        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb
>       4.58            -3.1        1.43        perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
>       3.57            -2.7        0.83        perf-profile.calltrace.cycles-pp.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
>       3.19            -2.4        0.79        perf-profile.calltrace.cycles-pp.__alloc_skb.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
>       2.93 ±  5%      -2.2        0.73 ±  2%  perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit
>       2.67            -1.9        0.75        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
>       2.51 ±  6%      -1.9        0.63 ±  2%  perf-profile.calltrace.cycles-pp.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_output
>       2.54            -1.8        0.74        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
>       2.60 ±  2%      -1.7        0.87        perf-profile.calltrace.cycles-pp.__kfree_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
>       2.35 ±  2%      -1.6        0.77        perf-profile.calltrace.cycles-pp.skb_release_all.__kfree_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
>       2.28 ±  2%      -1.6        0.72 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_head_state.skb_release_all.__kfree_skb.tcp_recvmsg_locked.tcp_recvmsg
>      21.76            -1.3       20.51        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      21.48            -1.0       20.46        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.28 ±  2%      -0.6        0.68        perf-profile.calltrace.cycles-pp.__kfree_skb.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv
>       1.24            -0.5        0.69        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.wait_woken
>       1.75            +0.1        1.88 ±  2%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable
>      19.43            +0.4       19.87        perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
>       0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule_idle.do_idle
>       0.00            +0.6        0.60        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup_entry
>       0.00            +0.7        0.68        perf-profile.calltrace.cycles-pp.available_idle_cpu.select_idle_sibling.select_task_rq_fair.try_to_wake_up.__wake_up_common
>      18.12            +1.4       19.57        perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
>       0.00            +1.5        1.45 ±  2%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.try_to_wake_up.__wake_up_common.__wake_up_common_lock
>      50.97            +1.5       52.49        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
>      50.63            +1.8       52.45        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
>       0.00            +2.4        2.38        perf-profile.calltrace.cycles-pp.update_cfs_group.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
>       0.00            +2.7        2.66        perf-profile.calltrace.cycles-pp.update_cfs_group.dequeue_entity.dequeue_task_fair.__schedule.schedule
>       0.35 ± 70%      +3.9        4.20        perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.schedule
>       0.00            +4.1        4.07        perf-profile.calltrace.cycles-pp.update_cfs_group.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__wake_up_common
>       0.00            +4.2        4.18        perf-profile.calltrace.cycles-pp.update_cfs_group.dequeue_task_fair.__schedule.schedule.schedule_timeout
>      47.09            +4.7       51.79        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
>       0.44 ± 44%      +5.5        5.91        perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
>       1.59            +5.8        7.36        perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
>      10.49            +6.4       16.92        perf-profile.calltrace.cycles-pp.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
>       0.00            +6.6        6.60        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__schedule.schedule_idle.do_idle
>       0.00            +6.7        6.66        perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule_idle.do_idle.cpu_startup_entry
>       0.00            +6.8        6.80        perf-profile.calltrace.cycles-pp.set_task_cpu.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable
>       1.95            +6.9        8.83        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__wake_up_common
>       8.86            +7.0       15.86        perf-profile.calltrace.cycles-pp.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
>       8.45            +7.1       15.50        perf-profile.calltrace.cycles-pp.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
>       8.21            +7.2       15.38        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
>       7.95            +7.3       15.21        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.wait_woken.sk_wait_data
>      42.82            +7.9       50.74        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
>       0.00            +8.2        8.22        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
>       0.00            +8.2        8.24        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       3.24 ±  2%      +8.7       11.97        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.wait_woken
>       3.64            +9.7       13.38        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable
>       3.56            +9.8       13.35        perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_common_lock
>      40.32           +10.0       50.33        perf-profile.calltrace.cycles-pp.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
>       0.00           +11.8       11.78        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
>      38.07           +11.9       49.97        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
>       0.00           +12.3       12.28        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
>       0.00           +12.3       12.29        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>      31.75           +16.9       48.60        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit.__tcp_transmit_skb
>      31.43           +17.1       48.56        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit
>       0.00           +17.5       17.49        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wake_up.__wake_up_common.__wake_up_common_lock
>      30.92           +17.5       48.45        perf-profile.calltrace.cycles-pp.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output
>       0.00           +17.7       17.71        perf-profile.calltrace.cycles-pp._raw_spin_lock.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable
>      29.41           +18.6       48.06        perf-profile.calltrace.cycles-pp.net_rx_action.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_finish_output2
>      28.60           +19.3       47.92        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__softirqentry_text_start.do_softirq.__local_bh_enable_ip
>      28.40           +19.4       47.85        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__softirqentry_text_start.do_softirq
>      27.30           +20.4       47.65        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__softirqentry_text_start
>       0.00           +21.4       21.36        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       0.00           +21.4       21.38        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       0.00           +21.4       21.38        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>      25.94           +21.5       47.45        perf-profile.calltrace.cycles-pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
>       0.00           +21.5       21.50        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>      24.16           +23.0       47.18        perf-profile.calltrace.cycles-pp.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog.__napi_poll
>      23.96           +23.2       47.16        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog
>      23.82           +23.3       47.14        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core
>      23.39           +23.7       47.07        perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv
>      19.51           +26.1       45.65        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
>      18.96           +26.6       45.57        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
>       7.91           +33.9       41.80        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv
>       8.63           +34.0       42.61        perf-profile.calltrace.cycles-pp.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
>       7.61           +34.0       41.64        perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_rcv_established
>       8.21           +34.2       42.41        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
>      96.13           -18.5       77.59        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      87.19           -10.5       76.67        perf-profile.children.cycles-pp.do_syscall_64
>      64.91            -8.9       56.00        perf-profile.children.cycles-pp.__x64_sys_sendto
>      64.64            -8.7       55.95        perf-profile.children.cycles-pp.__sys_sendto
>      63.32            -7.8       55.54        perf-profile.children.cycles-pp.sock_sendmsg
>       8.07            -7.3        0.76        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>       7.55            -7.0        0.52 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>      62.25            -6.9       55.35        perf-profile.children.cycles-pp.tcp_sendmsg
>      60.76            -5.7       55.04        perf-profile.children.cycles-pp.tcp_sendmsg_locked
>       7.45            -5.4        2.02        perf-profile.children.cycles-pp.tcp_ack
>       5.39 ±  2%      -4.2        1.18        perf-profile.children.cycles-pp.__dev_queue_xmit
>       4.67            -3.2        1.44        perf-profile.children.cycles-pp.tcp_clean_rtx_queue
>       3.58            -2.7        0.84        perf-profile.children.cycles-pp.sk_stream_alloc_skb
>       3.24            -2.4        0.80        perf-profile.children.cycles-pp.__alloc_skb
>       3.89 ±  2%      -2.3        1.55        perf-profile.children.cycles-pp.__kfree_skb
>       2.94 ±  5%      -2.2        0.73 ±  2%  perf-profile.children.cycles-pp.dev_hard_start_xmit
>       3.38            -2.1        1.32        perf-profile.children.cycles-pp.pick_next_task_fair
>       2.68            -1.9        0.75        perf-profile.children.cycles-pp.skb_copy_datagram_iter
>       2.52 ±  6%      -1.9        0.63 ±  2%  perf-profile.children.cycles-pp.loopback_xmit
>       2.50            -1.9        0.62 ±  2%  perf-profile.children.cycles-pp.update_curr
>       2.56            -1.8        0.74        perf-profile.children.cycles-pp.__skb_datagram_iter
>       2.31            -1.8        0.55        perf-profile.children.cycles-pp.switch_mm_irqs_off
>       2.57 ±  2%      -1.7        0.84        perf-profile.children.cycles-pp.skb_release_all
>       2.48 ±  2%      -1.7        0.81        perf-profile.children.cycles-pp.skb_release_head_state
>       1.89 ±  3%      -1.4        0.48        perf-profile.children.cycles-pp.dst_release
>       1.81 ±  2%      -1.4        0.42 ±  4%  perf-profile.children.cycles-pp.ktime_get
>       1.57            -1.4        0.21 ±  3%  perf-profile.children.cycles-pp.load_new_mm_cr3
>       1.48 ±  4%      -1.3        0.19 ±  3%  perf-profile.children.cycles-pp.tcp_send_mss
>      21.79            -1.3       20.51        perf-profile.children.cycles-pp.__x64_sys_recvfrom
>       1.62            -1.2        0.40 ±  3%  perf-profile.children.cycles-pp.switch_fpu_return
>       1.37 ±  5%      -1.2        0.17 ±  3%  perf-profile.children.cycles-pp.tcp_current_mss
>       1.44            -1.1        0.34 ±  2%  perf-profile.children.cycles-pp.__cgroup_bpf_run_filter_skb
>      21.51            -1.0       20.47        perf-profile.children.cycles-pp.__sys_recvfrom
>       1.25            -1.0        0.23 ±  2%  perf-profile.children.cycles-pp.tcp_mstamp_refresh
>       1.24            -1.0        0.22 ±  3%  perf-profile.children.cycles-pp.sk_filter_trim_cap
>       1.21 ± 14%      -1.0        0.20 ±  3%  perf-profile.children.cycles-pp.netif_rx
>       1.16 ± 14%      -1.0        0.19 ±  4%  perf-profile.children.cycles-pp.netif_rx_internal
>       1.11 ±  7%      -1.0        0.14 ±  4%  perf-profile.children.cycles-pp.ip_rcv_finish
>       1.22 ±  2%      -1.0        0.26 ±  2%  perf-profile.children.cycles-pp.kmalloc_reserve
>       1.58            -1.0        0.62        perf-profile.children.cycles-pp.lock_sock_nested
>       1.21 ±  2%      -0.9        0.30        perf-profile.children.cycles-pp.reweight_entity
>       0.97 ±  7%      -0.9        0.07 ±  5%  perf-profile.children.cycles-pp.__sk_dst_check
>       1.13            -0.9        0.24 ±  2%  perf-profile.children.cycles-pp.sched_clock_cpu
>       1.20            -0.9        0.30        perf-profile.children.cycles-pp._copy_to_iter
>       1.01            -0.9        0.14 ±  3%  perf-profile.children.cycles-pp.tcp_schedule_loss_probe
>       0.93 ±  8%      -0.8        0.10 ±  5%  perf-profile.children.cycles-pp.ip_rcv_finish_core
>       0.97 ± 10%      -0.8        0.15 ±  3%  perf-profile.children.cycles-pp.__netif_receive_skb_core
>       1.04 ±  3%      -0.8        0.22        perf-profile.children.cycles-pp.__kmalloc_node_track_caller
>       1.15            -0.8        0.34 ±  2%  perf-profile.children.cycles-pp.release_sock
>       1.11            -0.8        0.33        perf-profile.children.cycles-pp.__check_object_size
>       1.22            -0.8        0.46        perf-profile.children.cycles-pp.sockfd_lookup_light
>       1.03 ±  2%      -0.8        0.27 ±  7%  perf-profile.children.cycles-pp._copy_from_iter_full
>       0.93            -0.8        0.18 ±  4%  perf-profile.children.cycles-pp.irqtime_account_irq
>       0.92 ± 10%      -0.7        0.18 ±  2%  perf-profile.children.cycles-pp.read_tsc
>       0.95            -0.7        0.20 ±  2%  perf-profile.children.cycles-pp.sched_clock
>       0.89            -0.7        0.15 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
>       0.82 ± 12%      -0.7        0.09 ±  6%  perf-profile.children.cycles-pp.ipv4_dst_check
>       0.80 ± 10%      -0.7        0.07 ± 11%  perf-profile.children.cycles-pp.ipv4_mtu
>       1.33            -0.7        0.60        perf-profile.children.cycles-pp._raw_spin_lock_bh
>       0.91            -0.7        0.19 ±  3%  perf-profile.children.cycles-pp.native_sched_clock
>       0.96 ±  2%      -0.7        0.26 ±  3%  perf-profile.children.cycles-pp.tcp_event_new_data_sent
>       1.11            -0.7        0.42 ±  3%  perf-profile.children.cycles-pp.__switch_to_asm
>       0.78            -0.7        0.10        perf-profile.children.cycles-pp.pick_next_entity
>       0.80            -0.7        0.14 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
>       0.81            -0.7        0.15 ±  3%  perf-profile.children.cycles-pp.___might_sleep
>       0.72            -0.6        0.08 ±  4%  perf-profile.children.cycles-pp.copy_fpregs_to_fpstate
>       0.75            -0.6        0.12 ±  3%  perf-profile.children.cycles-pp.__might_sleep
>       0.78 ±  2%      -0.6        0.17 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_se
>       0.82            -0.6        0.23        perf-profile.children.cycles-pp.ip_finish_output
>       0.92 ±  2%      -0.6        0.34 ±  2%  perf-profile.children.cycles-pp.__fget_light
>       0.77            -0.6        0.21 ±  2%  perf-profile.children.cycles-pp.ttwu_do_wakeup
>       0.58 ±  4%      -0.6        0.03 ± 99%  perf-profile.children.cycles-pp.__might_fault
>       0.76            -0.5        0.23        perf-profile.children.cycles-pp.simple_copy_to_iter
>       0.72            -0.5        0.20        perf-profile.children.cycles-pp.validate_xmit_skb
>       0.60 ±  3%      -0.5        0.08        perf-profile.children.cycles-pp.tcp_ack_update_rtt
>       0.65 ±  3%      -0.5        0.13 ±  3%  perf-profile.children.cycles-pp.enqueue_to_backlog
>       0.83 ±  2%      -0.5        0.31 ±  2%  perf-profile.children.cycles-pp.aa_sk_perm
>       0.71            -0.5        0.20        perf-profile.children.cycles-pp.check_preempt_curr
>       0.73            -0.5        0.23 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
>       0.90 ±  2%      -0.5        0.41 ±  2%  perf-profile.children.cycles-pp.__inet_lookup_established
>       0.77 ±  2%      -0.5        0.29        perf-profile.children.cycles-pp.tcp_rcv_space_adjust
>       0.77            -0.5        0.28        perf-profile.children.cycles-pp.__switch_to
>       0.61 ±  4%      -0.5        0.12 ±  3%  perf-profile.children.cycles-pp.__virt_addr_valid
>       0.54 ±  3%      -0.5        0.07 ±  6%  perf-profile.children.cycles-pp.__calc_delta
>       0.53            -0.4        0.10 ±  3%  perf-profile.children.cycles-pp.ip_local_out
>       0.53 ±  2%      -0.4        0.11 ±  3%  perf-profile.children.cycles-pp.security_socket_sendmsg
>       0.82            -0.4        0.41        perf-profile.children.cycles-pp.skb_release_data
>       0.58            -0.4        0.17 ±  5%  perf-profile.children.cycles-pp.__ksize
>       0.55 ±  2%      -0.4        0.16 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
>       0.66 ±  2%      -0.4        0.29 ±  2%  perf-profile.children.cycles-pp.sk_reset_timer
>       0.45            -0.4        0.08        perf-profile.children.cycles-pp.ip_rcv_core
>       0.46            -0.4        0.09 ±  5%  perf-profile.children.cycles-pp.__ip_local_out
>       0.45 ±  3%      -0.3        0.11 ±  4%  perf-profile.children.cycles-pp.kfree
>       0.40            -0.3        0.07 ±  5%  perf-profile.children.cycles-pp.__entry_text_start
>       0.48 ±  5%      -0.3        0.15 ±  5%  perf-profile.children.cycles-pp.copyin
>       0.39            -0.3        0.06 ±  6%  perf-profile.children.cycles-pp.tcp_update_pacing_rate
>       0.40            -0.3        0.08 ±  6%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>       0.41 ±  2%      -0.3        0.08 ±  4%  perf-profile.children.cycles-pp.__list_del_entry_valid
>       0.68            -0.3        0.36        perf-profile.children.cycles-pp.__skb_clone
>       0.56            -0.3        0.24 ±  2%  perf-profile.children.cycles-pp.sock_recvmsg
>       0.41 ±  2%      -0.3        0.10 ±  3%  perf-profile.children.cycles-pp.__cond_resched
>       0.53 ±  2%      -0.3        0.23 ±  3%  perf-profile.children.cycles-pp.skb_entail
>       0.52            -0.3        0.23 ±  2%  perf-profile.children.cycles-pp.copyout
>       0.51            -0.3        0.23 ±  2%  perf-profile.children.cycles-pp.security_socket_recvmsg
>       0.53 ±  2%      -0.3        0.27 ±  3%  perf-profile.children.cycles-pp.mod_timer
>       0.35 ±  3%      -0.3        0.09 ±  4%  perf-profile.children.cycles-pp.cpuacct_charge
>       0.50            -0.3        0.23 ±  3%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
>       0.33 ±  4%      -0.3        0.07        perf-profile.children.cycles-pp.migrate_enable
>       0.49            -0.3        0.24 ±  3%  perf-profile.children.cycles-pp.tcp_wfree
>       0.35 ±  5%      -0.2        0.10 ±  3%  perf-profile.children.cycles-pp.tcp_rearm_rto
>       0.39 ±  4%      -0.2        0.15 ±  3%  perf-profile.children.cycles-pp.cpumask_next_wrap
>       0.30            -0.2        0.07 ±  7%  perf-profile.children.cycles-pp.migrate_disable
>       0.31            -0.2        0.08 ±  4%  perf-profile.children.cycles-pp.import_single_range
>       0.34 ±  2%      -0.2        0.11 ±  3%  perf-profile.children.cycles-pp.update_min_vruntime
>       0.30 ±  2%      -0.2        0.07 ±  7%  perf-profile.children.cycles-pp.tcp_update_skb_after_send
>       0.28 ±  2%      -0.2        0.05 ±  7%  perf-profile.children.cycles-pp.skb_clone
>       0.27 ±  2%      -0.2        0.05 ±  7%  perf-profile.children.cycles-pp.security_sock_rcv_skb
>       0.27            -0.2        0.06        perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
>       0.53            -0.2        0.32 ±  3%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
>       0.26            -0.2        0.06        perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
>       0.31 ±  3%      -0.2        0.11 ±  5%  perf-profile.children.cycles-pp.netif_skb_features
>       0.26 ±  2%      -0.2        0.06        perf-profile.children.cycles-pp.__tcp_select_window
>       0.25 ±  2%      -0.2        0.05 ±  9%  perf-profile.children.cycles-pp.tcp_established_options
>       0.30 ±  2%      -0.2        0.11 ±  3%  perf-profile.children.cycles-pp.tcp_event_data_recv
>       0.37            -0.2        0.18 ±  2%  perf-profile.children.cycles-pp.tcp_queue_rcv
>       0.23            -0.2        0.05        perf-profile.children.cycles-pp.bictcp_cwnd_event
>       0.23 ±  2%      -0.2        0.06 ±  9%  perf-profile.children.cycles-pp.tcp_v4_fill_cb
>       0.23 ±  2%      -0.2        0.05        perf-profile.children.cycles-pp.rb_insert_color
>       0.27            -0.2        0.09 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
>       0.25            -0.2        0.08 ±  4%  perf-profile.children.cycles-pp.ip_send_check
>       0.25 ±  3%      -0.2        0.08 ±  6%  perf-profile.children.cycles-pp.tcp_release_cb
>       0.23 ±  2%      -0.2        0.06 ±  6%  perf-profile.children.cycles-pp.rcu_all_qs
>       0.20 ±  7%      -0.2        0.05 ± 45%  perf-profile.children.cycles-pp.clockevents_program_event
>       0.26            -0.2        0.11 ±  3%  perf-profile.children.cycles-pp.__copy_skb_header
>       0.27            -0.2        0.12 ±  3%  perf-profile.children.cycles-pp.__enqueue_entity
>       0.32 ±  3%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.sock_rfree
>       0.59            -0.1        0.45 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
>       0.40 ±  5%      -0.1        0.26 ±  2%  perf-profile.children.cycles-pp.sk_page_frag_refill
>       0.23            -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.tcp_check_space
>       0.27 ±  2%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.perf_tp_event
>       0.19 ±  3%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.rb_next
>       0.19 ±  5%      -0.1        0.06        perf-profile.children.cycles-pp.tcp_v4_inbound_md5_hash
>       0.18 ±  3%      -0.1        0.06        perf-profile.children.cycles-pp.tcp_options_write
>       0.20            -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.__build_skb_around
>       0.27 ±  2%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.add_wait_queue
>       0.27 ±  2%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp._find_next_bit
>       0.15 ±  3%      -0.1        0.05 ±  9%  perf-profile.children.cycles-pp.__list_add_valid
>       0.13 ±  2%      -0.1        0.05        perf-profile.children.cycles-pp.update_irq_load_avg
>       0.15 ±  6%      -0.1        0.07        perf-profile.children.cycles-pp.sk_free
>       0.21 ±  5%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.kfree_skbmem
>       0.14 ±  2%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.woken_wake_function
>       0.28 ±  7%      -0.1        0.21 ±  2%  perf-profile.children.cycles-pp.skb_page_frag_refill
>       0.29 ±  5%      -0.1        0.23 ±  3%  perf-profile.children.cycles-pp.tcp_cleanup_rbuf
>       0.33 ±  2%      -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
>       0.11            -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.tcp_rate_check_app_limited
>       0.08 ± 17%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.cpus_share_cache
>       0.10 ±  3%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.rb_first
>       0.10 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__fdget
>       0.25            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.remove_wait_queue
>       0.08 ±  4%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
>       0.23 ±  2%      +0.0        0.26 ±  2%  perf-profile.children.cycles-pp.sock_put
>       0.00            +0.0        0.05        perf-profile.children.cycles-pp.get_xsave_addr
>       0.00            +0.0        0.05        perf-profile.children.cycles-pp.nr_iowait_cpu
>       0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
>       0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__update_idle_core
>       0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.set_next_task_idle
>       0.00            +0.1        0.07 ±  8%  perf-profile.children.cycles-pp.pick_next_task_idle
>       0.00            +0.1        0.08 ± 36%  perf-profile.children.cycles-pp.poll_idle
>       0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.attach_task
>       0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.activate_task
>       0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.attach_entity_load_avg
>       0.00            +0.1        0.09        perf-profile.children.cycles-pp.tick_nohz_idle_exit
>       0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.lock_timer_base
>       0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.__task_rq_lock
>       0.00            +0.1        0.11        perf-profile.children.cycles-pp.get_next_timer_interrupt
>       0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
>       0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.cpumask_next
>       0.00            +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.update_blocked_averages
>       0.00            +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.run_rebalance_domains
>       0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.start_kernel
>       1.76            +0.1        1.88 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
>       0.00            +0.2        0.16        perf-profile.children.cycles-pp.tick_nohz_next_event
>       0.00            +0.2        0.17 ±  3%  perf-profile.children.cycles-pp.remove_entity_load_avg
>       0.00            +0.2        0.22        perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
>       0.24 ±  3%      +0.3        0.49 ±  6%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
>       0.66 ±  2%      +0.3        0.94 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
>       0.66 ±  3%      +0.3        0.94 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>       0.59            +0.3        0.88        perf-profile.children.cycles-pp.finish_task_switch
>       0.00            +0.3        0.29 ±  3%  perf-profile.children.cycles-pp.sched_ttwu_pending
>       0.00            +0.3        0.30 ±  7%  perf-profile.children.cycles-pp.load_balance
>       0.00            +0.3        0.30 ±  3%  perf-profile.children.cycles-pp.__sysvec_call_function_single
>       0.00            +0.3        0.31 ±  3%  perf-profile.children.cycles-pp.sysvec_call_function_single
>       0.00            +0.3        0.33 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
>       0.00            +0.3        0.33 ±  4%  perf-profile.children.cycles-pp.rebalance_domains
>       0.00            +0.3        0.34 ±  2%  perf-profile.children.cycles-pp.__slab_free
>       0.00            +0.4        0.35        perf-profile.children.cycles-pp.migrate_task_rq_fair
>       0.00            +0.4        0.37 ±  2%  perf-profile.children.cycles-pp.menu_select
>       0.64            +0.4        1.01        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.08 ±  8%      +0.4        0.47 ±  3%  perf-profile.children.cycles-pp.task_tick_fair
>      19.47            +0.4       19.88        perf-profile.children.cycles-pp.tcp_recvmsg
>       0.00            +0.4        0.41 ±  4%  perf-profile.children.cycles-pp.irq_exit_rcu
>       0.29 ±  6%      +0.4        0.74 ±  4%  perf-profile.children.cycles-pp.tick_sched_timer
>       0.35 ±  5%      +0.5        0.82 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>       0.20 ±  6%      +0.5        0.72 ±  5%  perf-profile.children.cycles-pp.update_process_times
>       0.20 ±  6%      +0.5        0.72 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
>       0.13 ±  7%      +0.5        0.67 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
>       0.71 ±  2%      +0.7        1.37 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>       0.76 ±  2%      +0.7        1.46 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>       0.07 ±  8%      +0.7        0.78 ±  2%  perf-profile.children.cycles-pp.available_idle_cpu
>      18.17            +1.4       19.58        perf-profile.children.cycles-pp.tcp_recvmsg_locked
>       0.00            +1.5        1.47 ±  2%  perf-profile.children.cycles-pp.select_idle_sibling
>      50.99            +1.5       52.49        perf-profile.children.cycles-pp.__tcp_push_pending_frames
>      50.71            +1.7       52.46        perf-profile.children.cycles-pp.tcp_write_xmit
>      13.38            +2.0       15.39        perf-profile.children.cycles-pp.schedule
>      47.16            +4.6       51.80        perf-profile.children.cycles-pp.__tcp_transmit_skb
>       1.63            +5.8        7.38        perf-profile.children.cycles-pp.dequeue_entity
>      10.50            +6.4       16.92        perf-profile.children.cycles-pp.sk_wait_data
>       0.00            +6.9        6.89        perf-profile.children.cycles-pp.set_task_cpu
>       8.86            +7.0       15.86        perf-profile.children.cycles-pp.wait_woken
>       8.46            +7.0       15.51        perf-profile.children.cycles-pp.schedule_timeout
>       2.00            +7.1        9.12        perf-profile.children.cycles-pp.enqueue_entity
>      42.89            +7.9       50.74        perf-profile.children.cycles-pp.__ip_queue_xmit
>       0.00            +8.3        8.28        perf-profile.children.cycles-pp.schedule_idle
>       3.25 ±  2%      +8.8       12.02        perf-profile.children.cycles-pp.dequeue_task_fair
>       2.58            +8.9       11.44        perf-profile.children.cycles-pp.update_load_avg
>      40.37           +10.0       50.34        perf-profile.children.cycles-pp.ip_output
>       3.64           +10.0       13.65        perf-profile.children.cycles-pp.ttwu_do_activate
>       3.57           +10.1       13.71        perf-profile.children.cycles-pp.enqueue_task_fair
>      12.98           +10.5       23.50        perf-profile.children.cycles-pp.__schedule
>       0.00           +11.8       11.85        perf-profile.children.cycles-pp.intel_idle
>      38.10           +11.9       49.98        perf-profile.children.cycles-pp.ip_finish_output2
>       0.00           +12.4       12.36        perf-profile.children.cycles-pp.cpuidle_enter_state
>       0.00           +12.4       12.36        perf-profile.children.cycles-pp.cpuidle_enter
>       0.62 ±  2%     +13.3       13.87        perf-profile.children.cycles-pp.update_cfs_group
>      32.14           +16.5       48.66        perf-profile.children.cycles-pp.__local_bh_enable_ip
>      31.46           +17.1       48.57        perf-profile.children.cycles-pp.do_softirq
>      30.97           +17.9       48.85        perf-profile.children.cycles-pp.__softirqentry_text_start
>      29.45           +18.6       48.07        perf-profile.children.cycles-pp.net_rx_action
>      28.61           +19.3       47.93        perf-profile.children.cycles-pp.__napi_poll
>      28.43           +19.4       47.86        perf-profile.children.cycles-pp.process_backlog
>      27.33           +20.3       47.66        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
>       0.00           +21.4       21.38        perf-profile.children.cycles-pp.start_secondary
>      25.98           +21.5       47.45        perf-profile.children.cycles-pp.ip_rcv
>       0.00           +21.5       21.50        perf-profile.children.cycles-pp.do_idle
>       0.00           +21.5       21.50        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>       0.00           +21.5       21.50        perf-profile.children.cycles-pp.cpu_startup_entry
>      24.18           +23.0       47.18        perf-profile.children.cycles-pp.ip_local_deliver
>      23.98           +23.2       47.16        perf-profile.children.cycles-pp.ip_local_deliver_finish
>      23.84           +23.3       47.15        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
>      23.44           +23.6       47.07        perf-profile.children.cycles-pp.tcp_v4_rcv
>       1.15 ±  2%     +24.8       25.94        perf-profile.children.cycles-pp._raw_spin_lock
>       0.00           +24.8       24.83        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>      19.53           +26.1       45.66        perf-profile.children.cycles-pp.tcp_v4_do_rcv
>      19.01           +26.6       45.58        perf-profile.children.cycles-pp.tcp_rcv_established
>       7.91           +33.9       41.81        perf-profile.children.cycles-pp.__wake_up_common
>       8.64           +34.0       42.61        perf-profile.children.cycles-pp.sock_def_readable
>       7.62           +34.0       41.65        perf-profile.children.cycles-pp.try_to_wake_up
>       8.21           +34.2       42.42        perf-profile.children.cycles-pp.__wake_up_common_lock
>       1.86 ±  3%      -1.4        0.45 ±  2%  perf-profile.self.cycles-pp.dst_release
>       1.99            -1.4        0.58        perf-profile.self.cycles-pp.tcp_sendmsg_locked
>       1.57            -1.4        0.21 ±  3%  perf-profile.self.cycles-pp.load_new_mm_cr3
>       1.67            -1.3        0.34 ±  2%  perf-profile.self.cycles-pp.__tcp_transmit_skb
>       1.49 ±  4%      -1.3        0.21 ±  4%  perf-profile.self.cycles-pp.__dev_queue_xmit
>       1.50            -1.3        0.23 ±  3%  perf-profile.self.cycles-pp.tcp_clean_rtx_queue
>       1.55            -1.2        0.39 ±  3%  perf-profile.self.cycles-pp.switch_fpu_return
>       1.39            -1.0        0.36 ±  2%  perf-profile.self.cycles-pp.tcp_ack
>       1.18            -1.0        0.18 ±  3%  perf-profile.self.cycles-pp.tcp_write_xmit
>       0.97 ±  2%      -0.8        0.16 ±  2%  perf-profile.self.cycles-pp.__ip_queue_xmit
>       0.89 ±  8%      -0.8        0.09 ±  7%  perf-profile.self.cycles-pp.ip_rcv_finish_core
>       0.95 ±  2%      -0.8        0.18 ±  2%  perf-profile.self.cycles-pp.ip_finish_output2
>       0.90 ± 10%      -0.7        0.16 ±  3%  perf-profile.self.cycles-pp.read_tsc
>       1.28            -0.7        0.55        perf-profile.self.cycles-pp._raw_spin_lock_bh
>       0.88            -0.7        0.15 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
>       0.79 ± 10%      -0.7        0.07 ±  7%  perf-profile.self.cycles-pp.ipv4_mtu
>       0.81 ± 12%      -0.7        0.09 ±  6%  perf-profile.self.cycles-pp.ipv4_dst_check
>       0.88            -0.7        0.16 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>       1.09 ±  3%      -0.7        0.38 ±  2%  perf-profile.self.cycles-pp.tcp_recvmsg_locked
>       0.94 ±  2%      -0.7        0.23 ±  3%  perf-profile.self.cycles-pp.tcp_v4_rcv
>       0.87            -0.7        0.18 ±  2%  perf-profile.self.cycles-pp.native_sched_clock
>       0.93 ±  4%      -0.7        0.25 ±  6%  perf-profile.self.cycles-pp.ktime_get
>       1.09            -0.7        0.42 ±  3%  perf-profile.self.cycles-pp.__switch_to_asm
>       0.98 ±  4%      -0.7        0.32 ±  2%  perf-profile.self.cycles-pp.update_curr
>       0.80 ±  3%      -0.6        0.15 ±  2%  perf-profile.self.cycles-pp.__netif_receive_skb_core
>       0.79            -0.6        0.15        perf-profile.self.cycles-pp.___might_sleep
>       0.71            -0.6        0.08 ±  4%  perf-profile.self.cycles-pp.copy_fpregs_to_fpstate
>       0.73            -0.6        0.12 ±  3%  perf-profile.self.cycles-pp.net_rx_action
>       0.76 ±  2%      -0.6        0.17 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_se
>       0.91            -0.6        0.33 ±  3%  perf-profile.self.cycles-pp.__fget_light
>       0.78 ±  2%      -0.6        0.20        perf-profile.self.cycles-pp.__cgroup_bpf_run_filter_skb
>       0.65            -0.6        0.09 ±  5%  perf-profile.self.cycles-pp.__local_bh_enable_ip
>       0.66            -0.5        0.11 ±  4%  perf-profile.self.cycles-pp.process_backlog
>       0.66            -0.5        0.11 ±  3%  perf-profile.self.cycles-pp.__might_sleep
>       0.57 ±  2%      -0.5        0.06 ±  8%  perf-profile.self.cycles-pp.ip_output
>       0.58            -0.5        0.08 ±  4%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
>       0.57 ±  6%      -0.5        0.07 ±  5%  perf-profile.self.cycles-pp.tcp_current_mss
>       0.58            -0.5        0.09        perf-profile.self.cycles-pp.tcp_schedule_loss_probe
>       0.57 ±  2%      -0.5        0.09        perf-profile.self.cycles-pp.__sys_sendto
>       0.69            -0.5        0.23 ±  3%  perf-profile.self.cycles-pp.__switch_to
>       0.57            -0.5        0.10 ±  7%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
>       0.53 ±  2%      -0.5        0.07 ±  6%  perf-profile.self.cycles-pp.__calc_delta
>       0.54 ±  4%      -0.5        0.08 ±  4%  perf-profile.self.cycles-pp.tcp_ack_update_rtt
>       0.58 ±  4%      -0.5        0.12 ±  3%  perf-profile.self.cycles-pp.__virt_addr_valid
>       0.68            -0.5        0.23 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
>       1.47            -0.4        1.02        perf-profile.self.cycles-pp.__schedule
>       0.60 ±  2%      -0.4        0.18 ±  2%  perf-profile.self.cycles-pp.aa_sk_perm
>       0.58 ±  4%      -0.4        0.16 ±  3%  perf-profile.self.cycles-pp.__softirqentry_text_start
>       0.54 ±  3%      -0.4        0.12        perf-profile.self.cycles-pp.__kmalloc_node_track_caller
>       0.57            -0.4        0.16 ±  4%  perf-profile.self.cycles-pp.__alloc_skb
>       0.81            -0.4        0.40        perf-profile.self.cycles-pp.skb_release_data
>       0.55            -0.4        0.15 ±  3%  perf-profile.self.cycles-pp.pick_next_task_fair
>       0.57            -0.4        0.17 ±  5%  perf-profile.self.cycles-pp.__ksize
>       0.67 ±  2%      -0.4        0.28        perf-profile.self.cycles-pp.tcp_rcv_established
>       0.71            -0.4        0.34        perf-profile.self.cycles-pp.switch_mm_irqs_off
>       0.51 ±  2%      -0.4        0.14 ±  4%  perf-profile.self.cycles-pp.___perf_sw_event
>       0.44            -0.4        0.08 ±  4%  perf-profile.self.cycles-pp.__sys_recvfrom
>       0.43            -0.4        0.08 ±  4%  perf-profile.self.cycles-pp.ip_rcv_core
>       0.42 ±  2%      -0.3        0.08 ±  4%  perf-profile.self.cycles-pp.loopback_xmit
>       0.40            -0.3        0.06        perf-profile.self.cycles-pp.__netif_receive_skb_one_core
>       0.40            -0.3        0.07 ±  5%  perf-profile.self.cycles-pp.tcp_event_new_data_sent
>       0.40            -0.3        0.07 ±  5%  perf-profile.self.cycles-pp.__entry_text_start
>       0.44 ±  2%      -0.3        0.11 ±  3%  perf-profile.self.cycles-pp.mod_timer
>       0.37            -0.3        0.04 ± 44%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
>       0.44 ±  3%      -0.3        0.11 ±  4%  perf-profile.self.cycles-pp.kfree
>       0.70 ±  3%      -0.3        0.38 ±  2%  perf-profile.self.cycles-pp.__inet_lookup_established
>       0.38            -0.3        0.06        perf-profile.self.cycles-pp.tcp_update_pacing_rate
>       0.41            -0.3        0.09        perf-profile.self.cycles-pp.dev_hard_start_xmit
>       0.54 ±  3%      -0.3        0.23 ±  3%  perf-profile.self.cycles-pp.select_task_rq_fair
>       0.36 ±  2%      -0.3        0.06        perf-profile.self.cycles-pp.sock_sendmsg
>       0.35            -0.3        0.05        perf-profile.self.cycles-pp.enqueue_to_backlog
>       0.36            -0.3        0.07 ±  7%  perf-profile.self.cycles-pp.pick_next_entity
>       0.34 ±  2%      -0.3        0.06        perf-profile.self.cycles-pp._copy_to_iter
>       0.35 ±  3%      -0.3        0.07 ±  5%  perf-profile.self.cycles-pp.__list_del_entry_valid
>       0.43            -0.3        0.17 ±  3%  perf-profile.self.cycles-pp.finish_task_switch
>       0.35 ±  3%      -0.3        0.09 ±  4%  perf-profile.self.cycles-pp.cpuacct_charge
>       0.29            -0.3        0.03 ± 99%  perf-profile.self.cycles-pp.__x64_sys_recvfrom
>       0.43 ±  4%      -0.3        0.17 ±  2%  perf-profile.self.cycles-pp.enqueue_task_fair
>       0.33 ±  3%      -0.3        0.07 ±  5%  perf-profile.self.cycles-pp.validate_xmit_skb
>       0.48            -0.2        0.23 ±  3%  perf-profile.self.cycles-pp.copy_user_generic_unrolled
>       0.48            -0.2        0.23 ±  2%  perf-profile.self.cycles-pp.tcp_wfree
>       0.33 ±  2%      -0.2        0.09 ±  5%  perf-profile.self.cycles-pp.dequeue_entity
>       0.33            -0.2        0.08 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
>       0.31 ±  3%      -0.2        0.07        perf-profile.self.cycles-pp.migrate_enable
>       0.45 ±  3%      -0.2        0.21 ±  2%  perf-profile.self.cycles-pp.enqueue_entity
>       0.30            -0.2        0.07 ±  7%  perf-profile.self.cycles-pp.import_single_range
>       0.39            -0.2        0.16 ±  3%  perf-profile.self.cycles-pp.schedule
>       0.42            -0.2        0.19 ±  2%  perf-profile.self.cycles-pp.__skb_datagram_iter
>       0.29            -0.2        0.06        perf-profile.self.cycles-pp.migrate_disable
>       0.42 ±  4%      -0.2        0.19 ±  3%  perf-profile.self.cycles-pp.__check_object_size
>       0.33 ±  2%      -0.2        0.10 ±  4%  perf-profile.self.cycles-pp.update_min_vruntime
>       0.27 ±  4%      -0.2        0.04 ± 44%  perf-profile.self.cycles-pp.ip_rcv
>       0.28 ±  4%      -0.2        0.05 ±  7%  perf-profile.self.cycles-pp.irqtime_account_irq
>       0.30 ±  5%      -0.2        0.08 ±  6%  perf-profile.self.cycles-pp.tcp_rearm_rto
>       0.27 ±  2%      -0.2        0.05        perf-profile.self.cycles-pp.skb_clone
>       0.28            -0.2        0.07        perf-profile.self.cycles-pp.do_softirq
>       0.33 ±  2%      -0.2        0.11 ±  4%  perf-profile.self.cycles-pp.kmem_cache_free
>       0.27            -0.2        0.05 ±  7%  perf-profile.self.cycles-pp.__x64_sys_sendto
>       0.41 ±  2%      -0.2        0.20 ±  2%  perf-profile.self.cycles-pp.skb_entail
>       0.39            -0.2        0.18 ±  3%  perf-profile.self.cycles-pp.sock_def_readable
>       0.27 ±  5%      -0.2        0.06        perf-profile.self.cycles-pp.inet_recvmsg
>       0.25            -0.2        0.05        perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
>       0.23 ±  2%      -0.2        0.03 ± 70%  perf-profile.self.cycles-pp.sk_filter_trim_cap
>       0.25            -0.2        0.05 ±  9%  perf-profile.self.cycles-pp.tcp_established_options
>       0.23 ±  3%      -0.2        0.03 ± 70%  perf-profile.self.cycles-pp.rb_insert_color
>       0.25 ±  2%      -0.2        0.06        perf-profile.self.cycles-pp.__tcp_select_window
>       0.30 ±  2%      -0.2        0.11 ±  3%  perf-profile.self.cycles-pp.tcp_event_data_recv
>       0.36            -0.2        0.18        perf-profile.self.cycles-pp.tcp_queue_rcv
>       0.23 ±  2%      -0.2        0.05        perf-profile.self.cycles-pp.release_sock
>       0.37 ±  2%      -0.2        0.19 ±  2%  perf-profile.self.cycles-pp.reweight_entity
>       0.23 ±  2%      -0.2        0.05 ±  8%  perf-profile.self.cycles-pp.tcp_v4_fill_cb
>       0.24            -0.2        0.07 ±  7%  perf-profile.self.cycles-pp.lock_sock_nested
>       0.32            -0.2        0.15 ±  2%  perf-profile.self.cycles-pp.sk_wait_data
>       0.42            -0.2        0.25        perf-profile.self.cycles-pp.__skb_clone
>       0.25 ±  3%      -0.2        0.08 ±  4%  perf-profile.self.cycles-pp.ip_send_check
>       0.21 ±  2%      -0.2        0.05        perf-profile.self.cycles-pp.bictcp_cwnd_event
>       0.25            -0.2        0.09 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
>       0.23 ±  3%      -0.2        0.08 ±  6%  perf-profile.self.cycles-pp.tcp_release_cb
>       0.26            -0.2        0.10 ±  4%  perf-profile.self.cycles-pp.__copy_skb_header
>       0.21 ±  3%      -0.2        0.06 ±  6%  perf-profile.self.cycles-pp.sockfd_lookup_light
>       0.22 ± 13%      -0.1        0.07        perf-profile.self.cycles-pp.tcp_recvmsg
>       0.20 ±  6%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.netif_rx_internal
>       0.32 ±  3%      -0.1        0.17 ±  4%  perf-profile.self.cycles-pp.sock_rfree
>       0.19 ± 13%      -0.1        0.05        perf-profile.self.cycles-pp.ip_rcv_finish
>       0.17 ±  2%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
>       0.25            -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.__enqueue_entity
>       0.23 ±  2%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.tcp_check_space
>       0.28            -0.1        0.15 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
>       0.18 ±  2%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.rcu_all_qs
>       0.24 ±  5%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.schedule_timeout
>       0.18 ±  4%      -0.1        0.06 ± 13%  perf-profile.self.cycles-pp.rb_next
>       0.18 ±  6%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.netif_skb_features
>       0.19            -0.1        0.08 ± 12%  perf-profile.self.cycles-pp._copy_from_iter_full
>       0.26 ±  2%      -0.1        0.15 ±  2%  perf-profile.self.cycles-pp.dequeue_task_fair
>       0.17 ±  4%      -0.1        0.06        perf-profile.self.cycles-pp.tcp_options_write
>       0.27 ±  2%      -0.1        0.17 ±  2%  perf-profile.self.cycles-pp._find_next_bit
>       0.27 ±  5%      -0.1        0.17 ±  2%  perf-profile.self.cycles-pp.skb_release_head_state
>       0.16 ±  4%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.__napi_poll
>       0.14 ±  3%      -0.1        0.05 ±  7%  perf-profile.self.cycles-pp.__list_add_valid
>       0.15 ±  3%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.__wake_up_common
>       0.15 ±  5%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.sk_free
>       0.13 ±  2%      -0.1        0.05        perf-profile.self.cycles-pp.update_irq_load_avg
>       0.14            -0.1        0.07        perf-profile.self.cycles-pp.woken_wake_function
>       0.18 ±  2%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.set_next_entity
>       0.21 ±  5%      -0.1        0.14 ±  2%  perf-profile.self.cycles-pp.kfree_skbmem
>       0.16 ±  3%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.perf_tp_event
>       0.08 ± 17%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.cpus_share_cache
>       0.10 ±  4%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.tcp_rate_check_app_limited
>       0.40            -0.0        0.35 ±  2%  perf-profile.self.cycles-pp.wait_woken
>       0.26 ±  8%      -0.0        0.21 ±  3%  perf-profile.self.cycles-pp.skb_page_frag_refill
>       0.11 ±  9%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.cpumask_next_wrap
>       0.09            -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.add_wait_queue
>       0.09 ± 28%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.copyin
>       0.08 ±  4%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__fdget
>       0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.tcp_rcv_space_adjust
>       0.09 ±  4%      +0.0        0.13        perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
>       0.21 ±  2%      +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.sock_put
>       0.00            +0.0        0.05        perf-profile.self.cycles-pp.get_xsave_addr
>       0.00            +0.0        0.05        perf-profile.self.cycles-pp.nr_iowait_cpu
>       0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.attach_entity_load_avg
>       0.22 ±  2%      +0.1        0.33 ±  2%  perf-profile.self.cycles-pp.update_rq_clock
>       0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.menu_select
>       0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
>       1.12 ±  2%      +0.1        1.24        perf-profile.self.cycles-pp._raw_spin_lock
>       0.00            +0.1        0.14 ±  2%  perf-profile.self.cycles-pp.migrate_task_rq_fair
>       0.00            +0.2        0.17 ±  2%  perf-profile.self.cycles-pp.do_idle
>       0.62            +0.3        0.92        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.00            +0.3        0.33        perf-profile.self.cycles-pp.__slab_free
>       0.00            +0.4        0.44 ±  3%  perf-profile.self.cycles-pp.select_idle_sibling
>       0.32 ±  3%      +0.5        0.80        perf-profile.self.cycles-pp.try_to_wake_up
>       0.07 ± 10%      +0.7        0.77 ±  2%  perf-profile.self.cycles-pp.available_idle_cpu
>       0.00            +6.5        6.52        perf-profile.self.cycles-pp.set_task_cpu
>       1.10 ±  3%      +9.4       10.51        perf-profile.self.cycles-pp.update_load_avg
>       0.00           +11.8       11.85        perf-profile.self.cycles-pp.intel_idle
>       0.59 ±  3%     +13.3       13.87        perf-profile.self.cycles-pp.update_cfs_group
>       0.00           +24.8       24.83        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>   21089949           -85.8%    2989620 ± 12%  softirqs.CPU0.NET_RX
>      43259 ±  4%     -38.2%      26722 ± 10%  softirqs.CPU0.RCU
>       9128 ±  9%   +1186.2%     117403 ± 11%  softirqs.CPU0.SCHED
>   21110414 ±  2%     -84.8%    3204968 ±  6%  softirqs.CPU1.NET_RX
>      42310 ±  4%     -46.0%      22838 ± 11%  softirqs.CPU1.RCU
>       7021 ± 13%   +1668.3%     124165 ±  2%  softirqs.CPU1.SCHED
>   21143855           -84.7%    3243631 ±  6%  softirqs.CPU10.NET_RX
>      42441 ±  5%     -47.3%      22379 ± 12%  softirqs.CPU10.RCU
>       7111 ± 10%   +1637.1%     123534        softirqs.CPU10.SCHED
>   21204884 ±  2%     -84.7%    3245701 ±  6%  softirqs.CPU100.NET_RX
>      41490 ±  4%     -46.6%      22173 ± 12%  softirqs.CPU100.RCU
>       6455 ± 10%   +1815.6%     123661        softirqs.CPU100.SCHED
>   21232081           -84.8%    3231541 ±  6%  softirqs.CPU101.NET_RX
>      41589 ±  4%     -46.8%      22111 ± 12%  softirqs.CPU101.RCU
>       6425 ± 10%   +1824.0%     123623        softirqs.CPU101.SCHED
>   21126545 ±  2%     -85.4%    3085512 ±  7%  softirqs.CPU102.NET_RX
>      41763 ±  5%     -47.1%      22073 ± 12%  softirqs.CPU102.RCU
>       6441 ± 10%   +1738.4%     118410 ±  9%  softirqs.CPU102.SCHED
>   21127232 ±  2%     -84.7%    3229568 ±  6%  softirqs.CPU103.NET_RX
>      41827 ±  5%     -46.2%      22497 ± 10%  softirqs.CPU103.RCU
>       6478 ± 10%   +1806.9%     123534        softirqs.CPU103.SCHED
>   21217326           -84.7%    3237447 ±  6%  softirqs.CPU104.NET_RX
>      41828 ±  5%     -47.4%      22005 ± 12%  softirqs.CPU104.RCU
>       6448 ± 10%   +1817.5%     123647        softirqs.CPU104.SCHED
>   21091797           -84.6%    3258276 ±  6%  softirqs.CPU105.NET_RX
>      41694 ±  5%     -47.2%      22007 ± 11%  softirqs.CPU105.RCU
>       6300 ± 11%   +1861.0%     123559        softirqs.CPU105.SCHED
>   21085207 ±  2%     -84.6%    3243105 ±  6%  softirqs.CPU106.NET_RX
>      41857 ±  4%     -47.4%      22032 ± 11%  softirqs.CPU106.RCU
>       6490 ±  9%   +1803.4%     123527        softirqs.CPU106.SCHED
>   21289615           -84.8%    3242867 ±  6%  softirqs.CPU107.NET_RX
>      41335 ±  5%     -46.9%      21947 ± 11%  softirqs.CPU107.RCU
>       6393 ± 10%   +1831.8%     123517        softirqs.CPU107.SCHED
>   21106732 ±  2%     -84.7%    3226990 ±  6%  softirqs.CPU108.NET_RX
>      41558 ±  5%     -46.8%      22112 ± 11%  softirqs.CPU108.RCU
>       6581 ± 13%   +1782.9%     123927        softirqs.CPU108.SCHED
>   21080026 ±  2%     -84.7%    3223745 ±  7%  softirqs.CPU109.NET_RX
>      41748 ±  5%     -47.3%      21983 ± 12%  softirqs.CPU109.RCU
>       6565 ± 10%   +1782.6%     123600        softirqs.CPU109.SCHED
>   21333326           -84.8%    3233409 ±  7%  softirqs.CPU11.NET_RX
>      42155 ±  5%     -45.5%      22954 ± 13%  softirqs.CPU11.RCU
>       6449 ± 11%   +1827.6%     124325        softirqs.CPU11.SCHED
>   20809847           -84.5%    3233960 ±  6%  softirqs.CPU110.NET_RX
>      41662 ±  5%     -47.0%      22062 ± 11%  softirqs.CPU110.RCU
>       6394 ±  9%   +1832.2%     123548        softirqs.CPU110.SCHED
>   21371230           -84.8%    3247104 ±  6%  softirqs.CPU111.NET_RX
>      41795 ±  5%     -46.9%      22175 ± 11%  softirqs.CPU111.RCU
>       6388 ±  9%   +1834.6%     123582        softirqs.CPU111.SCHED
>   21506296           -84.9%    3245365 ±  6%  softirqs.CPU112.NET_RX
>      42999 ±  5%     -48.7%      22077 ± 11%  softirqs.CPU112.RCU
>       6429 ± 10%   +1820.6%     123494        softirqs.CPU112.SCHED
>   21158589 ±  2%     -84.8%    3220539 ±  7%  softirqs.CPU113.NET_RX
>      42935 ±  5%     -48.3%      22189 ± 11%  softirqs.CPU113.RCU
>       6390 ±  8%   +1836.3%     123741        softirqs.CPU113.SCHED
>   21251449 ±  2%     -84.9%    3210605 ±  6%  softirqs.CPU114.NET_RX
>      42964 ±  5%     -48.9%      21946 ± 11%  softirqs.CPU114.RCU
>       6418 ± 10%   +1817.2%     123053 ±  2%  softirqs.CPU114.SCHED
>   21134317           -84.7%    3232097 ±  6%  softirqs.CPU115.NET_RX
>      43081 ±  5%     -48.7%      22080 ± 11%  softirqs.CPU115.RCU
>       6453 ± 10%   +1816.5%     123675        softirqs.CPU115.SCHED
>   21085261 ±  2%     -84.6%    3240783 ±  6%  softirqs.CPU116.NET_RX
>      43194 ±  5%     -49.1%      21983 ± 12%  softirqs.CPU116.RCU
>       6490 ± 10%   +1804.2%     123587        softirqs.CPU116.SCHED
>   21031757           -84.6%    3239936 ±  6%  softirqs.CPU117.NET_RX
>      42936 ±  5%     -48.7%      22033 ± 12%  softirqs.CPU117.RCU
>       6389 ± 11%   +1831.5%     123414 ±  2%  softirqs.CPU117.SCHED
>   21328805           -84.8%    3234243 ±  6%  softirqs.CPU118.NET_RX
>      42825 ±  5%     -48.7%      21962 ± 11%  softirqs.CPU118.RCU
>       6262 ± 12%   +1870.7%     123418        softirqs.CPU118.SCHED
>   20600211 ±  2%     -84.4%    3217341 ±  7%  softirqs.CPU119.NET_RX
>      43424 ±  6%     -47.2%      22926 ± 19%  softirqs.CPU119.RCU
>       6219 ± 12%   +1877.6%     122990        softirqs.CPU119.SCHED
>   21190692 ±  3%     -84.8%    3218450 ±  6%  softirqs.CPU12.NET_RX
>      42159 ±  5%     -45.5%      22994 ± 11%  softirqs.CPU12.RCU
>       6552 ± 12%   +1790.5%     123884        softirqs.CPU12.SCHED
>   21060301 ±  2%     -83.3%    3511051 ±  7%  softirqs.CPU120.NET_RX
>      43878 ±  4%     -49.5%      22153 ± 12%  softirqs.CPU120.RCU
>       6432 ±  7%   +1799.0%     122140 ±  3%  softirqs.CPU120.SCHED
>   22076911 ±  2%     -84.0%    3538992 ±  7%  softirqs.CPU121.NET_RX
>      44348 ±  4%     -50.2%      22102 ± 12%  softirqs.CPU121.RCU
>       6479 ±  9%   +1782.8%     121988 ±  3%  softirqs.CPU121.SCHED
>   21689652 ±  2%     -83.6%    3560830 ±  7%  softirqs.CPU122.NET_RX
>      43443 ±  4%     -49.0%      22164 ± 12%  softirqs.CPU122.RCU
>       6310 ±  5%   +1832.7%     121956 ±  3%  softirqs.CPU122.SCHED
>   21434645 ±  5%     -83.5%    3545442 ±  7%  softirqs.CPU123.NET_RX
>      42799 ±  4%     -48.1%      22193 ± 12%  softirqs.CPU123.RCU
>       6367 ±  7%   +1814.9%     121932 ±  3%  softirqs.CPU123.SCHED
>   22107036           -83.9%    3569405 ±  7%  softirqs.CPU124.NET_RX
>      43573 ±  4%     -48.9%      22286 ± 13%  softirqs.CPU124.RCU
>       6322 ±  6%   +1830.7%     122076 ±  3%  softirqs.CPU124.SCHED
>   21971830 ±  2%     -83.9%    3537171 ±  7%  softirqs.CPU125.NET_RX
>      43068 ±  4%     -48.6%      22141 ± 12%  softirqs.CPU125.RCU
>       6312 ±  5%   +1831.2%     121912 ±  3%  softirqs.CPU125.SCHED
>   21977420 ±  3%     -83.9%    3528263 ±  7%  softirqs.CPU126.NET_RX
>      43650 ±  4%     -49.0%      22282 ± 13%  softirqs.CPU126.RCU
>       6334 ±  5%   +1826.3%     122024 ±  3%  softirqs.CPU126.SCHED
>   21741712 ±  2%     -83.7%    3535470 ±  7%  softirqs.CPU127.NET_RX
>      43621 ±  4%     -49.5%      22022 ± 12%  softirqs.CPU127.RCU
>       6285 ±  4%   +1839.7%     121921 ±  3%  softirqs.CPU127.SCHED
>   22266837 ±  2%     -84.1%    3548256 ±  7%  softirqs.CPU128.NET_RX
>      41978 ±  5%     -47.2%      22156 ± 12%  softirqs.CPU128.RCU
>       6297 ±  5%   +1836.8%     121961 ±  3%  softirqs.CPU128.SCHED
>   21798871 ±  2%     -83.6%    3567035 ±  7%  softirqs.CPU129.NET_RX
>      41751 ±  5%     -46.4%      22399 ± 11%  softirqs.CPU129.RCU
>       6309 ±  5%   +1828.5%     121681 ±  3%  softirqs.CPU129.SCHED
>   21262849           -84.8%    3225261 ±  6%  softirqs.CPU13.NET_RX
>      41455 ±  5%     -45.9%      22430 ± 11%  softirqs.CPU13.RCU
>       6539 ± 12%   +1793.2%     123805        softirqs.CPU13.SCHED
>   22112318 ±  3%     -83.9%    3550339 ±  7%  softirqs.CPU130.NET_RX
>      42358 ±  4%     -47.0%      22458 ± 11%  softirqs.CPU130.RCU
>       6421 ±  5%   +1797.9%     121866 ±  3%  softirqs.CPU130.SCHED
>   22061337 ±  3%     -84.0%    3537435 ±  7%  softirqs.CPU131.NET_RX
>      41498 ±  4%     -46.9%      22055 ± 12%  softirqs.CPU131.RCU
>       6318 ±  6%   +1830.0%     121952 ±  3%  softirqs.CPU131.SCHED
>   21719312 ±  3%     -83.7%    3539791 ±  7%  softirqs.CPU132.NET_RX
>      41664 ±  4%     -46.7%      22188 ± 12%  softirqs.CPU132.RCU
>       6329 ±  6%   +1828.0%     122030 ±  3%  softirqs.CPU132.SCHED
>   22111882           -84.0%    3535728 ±  7%  softirqs.CPU133.NET_RX
>      41790 ±  4%     -47.1%      22120 ± 12%  softirqs.CPU133.RCU
>       6367 ±  5%   +1815.2%     121952 ±  3%  softirqs.CPU133.SCHED
>   22070411 ±  3%     -83.9%    3543159 ±  7%  softirqs.CPU134.NET_RX
>      41771 ±  4%     -46.9%      22177 ± 12%  softirqs.CPU134.RCU
>       6132 ±  9%   +1888.2%     121926 ±  3%  softirqs.CPU134.SCHED
>   21797645 ±  3%     -83.6%    3570452 ±  7%  softirqs.CPU135.NET_RX
>      42425 ±  7%     -47.9%      22114 ± 12%  softirqs.CPU135.RCU
>       6292 ±  5%   +1837.4%     121898 ±  3%  softirqs.CPU135.SCHED
>   21861365           -83.7%    3553898 ±  7%  softirqs.CPU136.NET_RX
>      41626 ±  4%     -46.7%      22201 ± 12%  softirqs.CPU136.RCU
>       6250 ±  6%   +1850.8%     121936 ±  3%  softirqs.CPU136.SCHED
>   22026263 ±  3%     -84.0%    3533248 ±  7%  softirqs.CPU137.NET_RX
>      41601 ±  4%     -46.9%      22079 ± 13%  softirqs.CPU137.RCU
>       6304 ±  6%   +1833.9%     121929 ±  3%  softirqs.CPU137.SCHED
>   21738929 ±  2%     -83.7%    3543092 ±  7%  softirqs.CPU138.NET_RX
>      41609 ±  4%     -46.0%      22480 ± 12%  softirqs.CPU138.RCU
>       6301 ±  5%   +1833.0%     121813 ±  3%  softirqs.CPU138.SCHED
>   21927693           -83.9%    3530203 ±  7%  softirqs.CPU139.NET_RX
>      41803 ±  4%     -47.3%      22048 ± 12%  softirqs.CPU139.RCU
>       6261 ±  5%   +1846.4%     121880 ±  3%  softirqs.CPU139.SCHED
>   21004769           -84.6%    3230354 ±  6%  softirqs.CPU14.NET_RX
>      41727 ±  5%     -44.6%      23129 ± 10%  softirqs.CPU14.RCU
>       6482 ± 10%   +1802.2%     123305        softirqs.CPU14.SCHED
>   22068737 ±  4%     -83.9%    3560636 ±  7%  softirqs.CPU140.NET_RX
>      41639 ±  4%     -46.9%      22096 ± 12%  softirqs.CPU140.RCU
>       6266 ±  6%   +1843.5%     121795 ±  3%  softirqs.CPU140.SCHED
>   21903090 ±  3%     -83.8%    3556461 ±  7%  softirqs.CPU141.NET_RX
>      41554 ±  5%     -47.1%      21962 ± 12%  softirqs.CPU141.RCU
>       6248 ±  5%   +1849.0%     121791 ±  3%  softirqs.CPU141.SCHED
>   22076631 ±  2%     -84.0%    3533559 ±  7%  softirqs.CPU142.NET_RX
>      41287 ±  5%     -46.8%      21960 ± 12%  softirqs.CPU142.RCU
>       6231 ±  5%   +1855.0%     121831 ±  3%  softirqs.CPU142.SCHED
>   21676631 ±  2%     -83.7%    3536303 ±  7%  softirqs.CPU143.NET_RX
>      41504 ±  5%     -46.9%      22019 ± 12%  softirqs.CPU143.RCU
>       6281 ±  5%   +1842.7%     122026 ±  3%  softirqs.CPU143.SCHED
>   21727456           -83.7%    3543613 ± 15%  softirqs.CPU144.NET_RX
>      41239 ±  6%     -47.2%      21792 ± 13%  softirqs.CPU144.RCU
>       6289 ±  7%   +1832.1%     121512 ±  3%  softirqs.CPU144.SCHED
>   22306831 ±  2%     -83.8%    3603104 ± 15%  softirqs.CPU145.NET_RX
>      41452 ±  7%     -47.2%      21906 ± 13%  softirqs.CPU145.RCU
>       6366 ±  8%   +1807.4%     121434 ±  3%  softirqs.CPU145.SCHED
>   21785130 ±  3%     -83.5%    3604421 ± 15%  softirqs.CPU146.NET_RX
>      41349 ±  6%     -47.5%      21724 ± 12%  softirqs.CPU146.RCU
>       6347 ±  7%   +1813.2%     121435 ±  3%  softirqs.CPU146.SCHED
>   21232094 ±  3%     -83.1%    3598219 ± 15%  softirqs.CPU147.NET_RX
>      40828 ±  6%     -46.5%      21824 ± 13%  softirqs.CPU147.RCU
>       6293 ±  7%   +1828.1%     121336 ±  3%  softirqs.CPU147.SCHED
>   22069243 ±  2%     -83.6%    3612608 ± 15%  softirqs.CPU148.NET_RX
>      40473 ±  7%     -45.8%      21931 ± 14%  softirqs.CPU148.RCU
>       6232 ±  8%   +1846.5%     121308 ±  3%  softirqs.CPU148.SCHED
>   22177970           -83.7%    3609960 ± 15%  softirqs.CPU149.NET_RX
>      41267 ±  6%     -46.9%      21903 ± 13%  softirqs.CPU149.RCU
>       6332 ±  7%   +1818.1%     121455 ±  3%  softirqs.CPU149.SCHED
>   21356834 ±  2%     -84.8%    3244899 ±  6%  softirqs.CPU15.NET_RX
>      41941 ±  5%     -46.4%      22485 ± 11%  softirqs.CPU15.RCU
>       6388 ±  9%   +1834.5%     123576        softirqs.CPU15.SCHED
>   22054050 ±  2%     -83.8%    3576963 ± 15%  softirqs.CPU150.NET_RX
>      41610 ±  6%     -47.6%      21822 ± 13%  softirqs.CPU150.RCU
>       6511 ±  7%   +1764.7%     121418 ±  3%  softirqs.CPU150.SCHED
>   22211176 ±  2%     -83.8%    3598883 ± 15%  softirqs.CPU151.NET_RX
>      41070 ±  6%     -46.8%      21838 ± 13%  softirqs.CPU151.RCU
>       6332 ±  7%   +1816.1%     121336 ±  3%  softirqs.CPU151.SCHED
>   22064325 ±  2%     -83.6%    3611293 ± 15%  softirqs.CPU152.NET_RX
>      40838 ±  6%     -46.7%      21774 ± 13%  softirqs.CPU152.RCU
>       6325 ±  8%   +1818.5%     121352 ±  3%  softirqs.CPU152.SCHED
>   22224794 ±  2%     -83.8%    3611086 ± 15%  softirqs.CPU153.NET_RX
>      40704 ±  9%     -46.4%      21801 ± 13%  softirqs.CPU153.RCU
>       6296 ±  7%   +1827.7%     121370 ±  3%  softirqs.CPU153.SCHED
>   21838832 ±  2%     -83.6%    3581908 ± 15%  softirqs.CPU154.NET_RX
>      41284 ±  6%     -47.1%      21842 ± 13%  softirqs.CPU154.RCU
>       6288 ±  7%   +1830.9%     121415 ±  3%  softirqs.CPU154.SCHED
>   22225475 ±  2%     -83.8%    3593379 ± 15%  softirqs.CPU155.NET_RX
>      41248 ±  6%     -47.3%      21739 ± 13%  softirqs.CPU155.RCU
>       6249 ±  8%   +1843.3%     121437 ±  3%  softirqs.CPU155.SCHED
>   22275414 ±  2%     -83.9%    3590419 ± 15%  softirqs.CPU156.NET_RX
>      40958 ±  6%     -46.8%      21790 ± 13%  softirqs.CPU156.RCU
>       6356 ±  7%   +1811.1%     121472 ±  3%  softirqs.CPU156.SCHED
>   22120237 ±  3%     -83.7%    3605416 ± 15%  softirqs.CPU157.NET_RX
>      41206 ±  6%     -47.0%      21827 ± 13%  softirqs.CPU157.RCU
>       6336 ±  7%   +1817.0%     121470 ±  3%  softirqs.CPU157.SCHED
>   22218563 ±  2%     -83.8%    3606034 ± 16%  softirqs.CPU158.NET_RX
>      40854 ±  6%     -45.9%      22086 ± 15%  softirqs.CPU158.RCU
>       6268 ±  7%   +1834.4%     121258 ±  3%  softirqs.CPU158.SCHED
>   22109688 ±  2%     -83.7%    3606683 ± 15%  softirqs.CPU159.NET_RX
>      41084 ±  6%     -47.2%      21696 ± 13%  softirqs.CPU159.RCU
>       6321 ±  8%   +1818.9%     121309 ±  3%  softirqs.CPU159.SCHED
>   21339128 ±  2%     -84.8%    3240429 ±  6%  softirqs.CPU16.NET_RX
>      43110 ±  5%     -47.6%      22599 ± 11%  softirqs.CPU16.RCU
>       6382 ± 10%   +1836.8%     123604        softirqs.CPU16.SCHED
>   22109619 ±  2%     -83.6%    3615340 ± 15%  softirqs.CPU160.NET_RX
>      43313 ±  5%     -48.8%      22197 ± 15%  softirqs.CPU160.RCU
>       6349 ±  7%   +1812.5%     121427 ±  3%  softirqs.CPU160.SCHED
>   21821599 ±  2%     -83.5%    3609540 ± 16%  softirqs.CPU161.NET_RX
>      43460 ±  5%     -49.6%      21906 ± 13%  softirqs.CPU161.RCU
>       6301 ±  9%   +1832.8%     121794 ±  3%  softirqs.CPU161.SCHED
>   22087548 ±  3%     -83.7%    3599251 ± 16%  softirqs.CPU162.NET_RX
>      43164 ±  5%     -49.2%      21915 ± 13%  softirqs.CPU162.RCU
>       6322 ±  7%   +1819.1%     121338 ±  3%  softirqs.CPU162.SCHED
>   21861229 ±  2%     -83.6%    3588697 ± 15%  softirqs.CPU163.NET_RX
>      42815 ±  5%     -48.8%      21942 ± 13%  softirqs.CPU163.RCU
>       6296 ±  7%   +1828.3%     121407 ±  3%  softirqs.CPU163.SCHED
>   21893539           -83.5%    3617073 ± 15%  softirqs.CPU164.NET_RX
>      42932 ±  5%     -48.9%      21922 ± 13%  softirqs.CPU164.RCU
>       6326 ±  8%   +1816.7%     121260 ±  3%  softirqs.CPU164.SCHED
>   22155077 ±  3%     -83.7%    3616815 ± 16%  softirqs.CPU165.NET_RX
>      43440 ±  6%     -49.6%      21881 ± 13%  softirqs.CPU165.RCU
>       6357 ±  9%   +1808.5%     121340 ±  3%  softirqs.CPU165.SCHED
>   22276929 ±  2%     -83.9%    3585606 ± 15%  softirqs.CPU166.NET_RX
>      43511 ±  5%     -49.7%      21906 ± 13%  softirqs.CPU166.RCU
>       6293 ±  8%   +1831.4%     121552 ±  3%  softirqs.CPU166.SCHED
>   21917532 ±  3%     -83.7%    3581813 ± 15%  softirqs.CPU167.NET_RX
>      43558 ±  5%     -49.5%      21982 ± 13%  softirqs.CPU167.RCU
>       6583 ± 11%   +1744.8%     121441 ±  3%  softirqs.CPU167.SCHED
>   21044980 ±  2%     -83.8%    3401343 ±  2%  softirqs.CPU168.NET_RX
>      40641 ±  6%     -46.7%      21675 ± 12%  softirqs.CPU168.RCU
>       7154 ±  8%   +1641.6%     124600        softirqs.CPU168.SCHED
>   21419375           -84.4%    3334229 ±  7%  softirqs.CPU169.NET_RX
>      40916 ±  5%     -46.8%      21747 ± 12%  softirqs.CPU169.RCU
>       7037 ± 10%   +1601.5%     119743 ±  8%  softirqs.CPU169.SCHED
>   21328933           -84.9%    3217840 ±  6%  softirqs.CPU17.NET_RX
>      43234 ±  4%     -48.6%      22229 ± 11%  softirqs.CPU17.RCU
>       6453 ± 10%   +1813.9%     123516        softirqs.CPU17.SCHED
>   21258245           -83.7%    3468299 ±  2%  softirqs.CPU170.NET_RX
>      41473 ±  5%     -47.8%      21651 ± 12%  softirqs.CPU170.RCU
>       7023 ± 11%   +1671.1%     124393        softirqs.CPU170.SCHED
>   21223382 ±  2%     -83.7%    3466301 ±  2%  softirqs.CPU171.NET_RX
>      40893 ±  5%     -46.7%      21797 ± 12%  softirqs.CPU171.RCU
>       7026 ± 11%   +1670.4%     124397        softirqs.CPU171.SCHED
>   21126518           -83.5%    3481275 ±  2%  softirqs.CPU172.NET_RX
>      41233 ±  5%     -47.2%      21765 ± 11%  softirqs.CPU172.RCU
>       7087 ± 11%   +1655.5%     124426        softirqs.CPU172.SCHED
>   21470783           -83.9%    3455627 ±  2%  softirqs.CPU173.NET_RX
>      41193 ±  5%     -47.3%      21688 ± 12%  softirqs.CPU173.RCU
>       6987 ± 10%   +1682.4%     124545        softirqs.CPU173.SCHED
>   21412226 ±  2%     -83.9%    3452021 ±  2%  softirqs.CPU174.NET_RX
>      41316 ±  5%     -47.6%      21636 ± 12%  softirqs.CPU174.RCU
>       7020 ± 11%   +1673.3%     124490        softirqs.CPU174.SCHED
>   21410841           -83.8%    3469881 ±  2%  softirqs.CPU175.NET_RX
>      41129 ±  5%     -47.4%      21619 ± 12%  softirqs.CPU175.RCU
>       7003 ± 12%   +1677.5%     124488        softirqs.CPU175.SCHED
>   21356566           -83.7%    3482920 ±  2%  softirqs.CPU176.NET_RX
>      42741 ±  5%     -49.2%      21732 ± 12%  softirqs.CPU176.RCU
>       7028 ± 11%   +1668.6%     124306        softirqs.CPU176.SCHED
>   21362620           -83.7%    3480149 ±  2%  softirqs.CPU177.NET_RX
>      43210 ±  5%     -49.1%      21978 ± 11%  softirqs.CPU177.RCU
>       6999 ± 11%   +1676.7%     124361        softirqs.CPU177.SCHED
>   21365410           -83.8%    3459326 ±  2%  softirqs.CPU178.NET_RX
>      43212 ±  5%     -48.9%      22069 ± 11%  softirqs.CPU178.RCU
>       7034 ± 12%   +1670.3%     124532        softirqs.CPU178.SCHED
>   21555250           -83.9%    3460099 ±  2%  softirqs.CPU179.NET_RX
>      43065 ±  5%     -49.5%      21731 ± 12%  softirqs.CPU179.RCU
>       7013 ± 11%   +1673.8%     124405        softirqs.CPU179.SCHED
>   21261067           -84.8%    3234245 ±  6%  softirqs.CPU18.NET_RX
>      43393 ±  5%     -48.9%      22173 ± 11%  softirqs.CPU18.RCU
>       6462 ± 10%   +1811.8%     123541        softirqs.CPU18.SCHED
>   21160181 ±  2%     -83.6%    3461692 ±  2%  softirqs.CPU180.NET_RX
>      43049 ±  4%     -49.5%      21724 ± 12%  softirqs.CPU180.RCU
>       6974 ± 11%   +1685.9%     124558        softirqs.CPU180.SCHED
>   21297779           -83.9%    3429715 ±  4%  softirqs.CPU181.NET_RX
>      42816 ±  5%     -49.4%      21656 ± 12%  softirqs.CPU181.RCU
>       7005 ± 12%   +1644.0%     122176 ±  4%  softirqs.CPU181.SCHED
>   21333411 ±  2%     -83.7%    3472238 ±  2%  softirqs.CPU182.NET_RX
>      42723 ±  5%     -49.3%      21650 ± 12%  softirqs.CPU182.RCU
>       6954 ± 12%   +1688.3%     124373        softirqs.CPU182.SCHED
>   21262028           -83.7%    3469338 ±  2%  softirqs.CPU183.NET_RX
>      42955 ±  5%     -49.6%      21667 ± 12%  softirqs.CPU183.RCU
>       6954 ± 10%   +1686.5%     124237        softirqs.CPU183.SCHED
>   21340897           -83.8%    3461830 ±  2%  softirqs.CPU184.NET_RX
>      42800 ±  5%     -49.2%      21724 ± 12%  softirqs.CPU184.RCU
>       6933 ± 11%   +1695.3%     124469        softirqs.CPU184.SCHED
>   21185172           -83.7%    3457528 ±  2%  softirqs.CPU185.NET_RX
>      43033 ±  5%     -49.7%      21653 ± 12%  softirqs.CPU185.RCU
>       7119 ± 12%   +1649.5%     124548        softirqs.CPU185.SCHED
>   21210384           -83.7%    3447509 ±  2%  softirqs.CPU186.NET_RX
>      43046 ±  5%     -49.6%      21707 ± 12%  softirqs.CPU186.RCU
>       7012 ± 11%   +1667.9%     123980        softirqs.CPU186.SCHED
>   21402048 ±  2%     -83.9%    3451075 ±  2%  softirqs.CPU187.NET_RX
>      42928 ±  5%     -49.2%      21804 ± 12%  softirqs.CPU187.RCU
>       7005 ± 11%   +1675.6%     124394        softirqs.CPU187.SCHED
>   21453931           -83.8%    3471605 ±  2%  softirqs.CPU188.NET_RX
>      42653 ±  5%     -49.2%      21655 ± 12%  softirqs.CPU188.RCU
>       7078 ± 11%   +1658.1%     124444        softirqs.CPU188.SCHED
>   21529386           -83.8%    3477434 ±  2%  softirqs.CPU189.NET_RX
>      42966 ±  5%     -49.6%      21661 ± 12%  softirqs.CPU189.RCU
>       7097 ± 10%   +1652.2%     124362        softirqs.CPU189.SCHED
>   21036465 ±  2%     -84.7%    3222377 ±  6%  softirqs.CPU19.NET_RX
>      43445 ±  5%     -48.6%      22336 ± 11%  softirqs.CPU19.RCU
>       6447 ± 10%   +1814.8%     123455        softirqs.CPU19.SCHED
>   21376613           -83.9%    3451016 ±  2%  softirqs.CPU190.NET_RX
>      43049 ±  5%     -49.5%      21756 ± 13%  softirqs.CPU190.RCU
>       7010 ± 11%   +1676.2%     124523        softirqs.CPU190.SCHED
>   20635117           -83.9%    3321052 ±  2%  softirqs.CPU191.NET_RX
>      43481 ±  5%     -49.6%      21900 ± 12%  softirqs.CPU191.RCU
>       7229 ± 16%   +1567.6%     120548        softirqs.CPU191.SCHED
>   20797440 ±  3%     -84.8%    3157799 ± 11%  softirqs.CPU2.NET_RX
>      41846 ±  5%     -45.9%      22642 ± 11%  softirqs.CPU2.RCU
>       6888 ± 18%   +1643.1%     120078 ±  5%  softirqs.CPU2.SCHED
>   21024095 ±  2%     -84.5%    3252088 ±  6%  softirqs.CPU20.NET_RX
>      43269 ±  5%     -48.7%      22183 ± 11%  softirqs.CPU20.RCU
>       6407 ± 10%   +1831.5%     123763        softirqs.CPU20.SCHED
>   20926277 ±  2%     -84.5%    3242026 ±  6%  softirqs.CPU21.NET_RX
>      43269 ±  4%     -48.8%      22139 ± 12%  softirqs.CPU21.RCU
>       6274 ± 13%   +1870.4%     123640        softirqs.CPU21.SCHED
>   21077431 ±  2%     -84.6%    3246240 ±  6%  softirqs.CPU22.NET_RX
>      43234 ±  5%     -48.4%      22317 ± 12%  softirqs.CPU22.RCU
>       6376 ± 11%   +1843.3%     123910        softirqs.CPU22.SCHED
>   21029368 ±  3%     -84.7%    3220265 ±  6%  softirqs.CPU23.NET_RX
>      43088 ±  4%     -48.6%      22135 ± 11%  softirqs.CPU23.RCU
>       6219 ± 13%   +1887.1%     123588        softirqs.CPU23.SCHED
>   21307111 ±  3%     -83.6%    3498024 ±  7%  softirqs.CPU24.NET_RX
>      43128 ±  4%     -48.2%      22331 ± 12%  softirqs.CPU24.RCU
>       6239 ±  5%   +1859.0%     122238 ±  3%  softirqs.CPU24.SCHED
>   21868294 ±  2%     -83.8%    3535036 ±  7%  softirqs.CPU25.NET_RX
>      43203 ±  4%     -46.5%      23128 ± 12%  softirqs.CPU25.RCU
>       6222 ±  4%   +1862.4%     122108 ±  3%  softirqs.CPU25.SCHED
>   21899068 ±  2%     -83.8%    3554637 ±  7%  softirqs.CPU26.NET_RX
>      43326 ±  5%     -48.0%      22509 ± 11%  softirqs.CPU26.RCU
>       6242 ±  5%   +1856.7%     122138 ±  3%  softirqs.CPU26.SCHED
>   21745475 ±  3%     -83.7%    3545972 ±  7%  softirqs.CPU27.NET_RX
>      42977 ±  4%     -47.0%      22776 ± 12%  softirqs.CPU27.RCU
>       6099 ±  5%   +1899.4%     121954 ±  3%  softirqs.CPU27.SCHED
>   21715337 ±  2%     -83.6%    3555366 ±  7%  softirqs.CPU28.NET_RX
>      43381 ±  3%     -48.0%      22563 ± 12%  softirqs.CPU28.RCU
>       6244 ±  6%   +1852.7%     121931 ±  3%  softirqs.CPU28.SCHED
>   21739607           -83.7%    3547302 ±  7%  softirqs.CPU29.NET_RX
>      43164 ±  4%     -48.1%      22419 ± 12%  softirqs.CPU29.RCU
>       6244 ±  6%   +1854.2%     122019 ±  3%  softirqs.CPU29.SCHED
>   21276568           -84.8%    3233261 ±  6%  softirqs.CPU3.NET_RX
>      42043 ±  5%     -46.5%      22505 ± 12%  softirqs.CPU3.RCU
>       6563 ±  8%   +1783.8%     123644        softirqs.CPU3.SCHED
>   21780558 ±  3%     -83.8%    3529211 ±  7%  softirqs.CPU30.NET_RX
>      43512 ±  3%     -48.1%      22601 ± 13%  softirqs.CPU30.RCU
>       6242 ±  6%   +1855.7%     122075 ±  3%  softirqs.CPU30.SCHED
>   21925350 ±  2%     -83.9%    3525576 ±  7%  softirqs.CPU31.NET_RX
>      43589 ±  3%     -48.2%      22561 ± 11%  softirqs.CPU31.RCU
>       6292 ±  6%   +1837.2%     121897 ±  3%  softirqs.CPU31.SCHED
>   22178024 ±  2%     -84.0%    3551217 ±  7%  softirqs.CPU32.NET_RX
>      42541 ±  5%     -47.3%      22437 ± 12%  softirqs.CPU32.RCU
>       6532 ± 10%   +1767.8%     122014 ±  3%  softirqs.CPU32.SCHED
>   21895952 ±  2%     -83.7%    3572427 ±  7%  softirqs.CPU33.NET_RX
>      42539 ±  4%     -46.5%      22745 ± 11%  softirqs.CPU33.RCU
>       6250 ±  6%   +1850.8%     121927 ±  3%  softirqs.CPU33.SCHED
>   21741670 ±  4%     -83.7%    3554239 ±  7%  softirqs.CPU34.NET_RX
>      42853 ±  5%     -47.4%      22531 ± 12%  softirqs.CPU34.RCU
>       6268 ±  5%   +1845.5%     121955 ±  3%  softirqs.CPU34.SCHED
>   21894414 ±  3%     -83.8%    3537215 ±  7%  softirqs.CPU35.NET_RX
>      42731 ±  4%     -47.3%      22508 ± 12%  softirqs.CPU35.RCU
>       6232 ±  5%   +1858.5%     122071 ±  3%  softirqs.CPU35.SCHED
>   21881538 ±  3%     -83.9%    3526863 ±  7%  softirqs.CPU36.NET_RX
>      42736 ±  4%     -47.4%      22478 ± 12%  softirqs.CPU36.RCU
>       6250 ±  5%   +1851.9%     122010 ±  3%  softirqs.CPU36.SCHED
>   22023460 ±  2%     -83.9%    3536194 ±  7%  softirqs.CPU37.NET_RX
>      42264 ±  4%     -47.0%      22390 ± 12%  softirqs.CPU37.RCU
>       6251 ±  6%   +1850.8%     121960 ±  3%  softirqs.CPU37.SCHED
>   21989677 ±  3%     -83.9%    3548459 ±  7%  softirqs.CPU38.NET_RX
>      42359 ±  4%     -46.9%      22489 ± 12%  softirqs.CPU38.RCU
>       6075 ± 10%   +1905.1%     121824 ±  3%  softirqs.CPU38.SCHED
>   21181146 ±  4%     -83.2%    3555781 ±  7%  softirqs.CPU39.NET_RX
>      42381 ±  4%     -47.0%      22448 ± 12%  softirqs.CPU39.RCU
>       6288 ±  5%   +1838.7%     121905 ±  3%  softirqs.CPU39.SCHED
>   21234461 ±  3%     -84.8%    3232773 ±  6%  softirqs.CPU4.NET_RX
>      41094 ±  5%     -45.6%      22375 ± 11%  softirqs.CPU4.RCU
>       6400 ± 10%   +1829.9%     123516        softirqs.CPU4.SCHED
>   21625431 ±  2%     -83.6%    3549473 ±  7%  softirqs.CPU40.NET_RX
>      42390 ±  4%     -46.5%      22698 ± 12%  softirqs.CPU40.RCU
>       6249 ±  5%   +1850.9%     121916 ±  3%  softirqs.CPU40.SCHED
>   22033392 ±  2%     -84.0%    3524607 ±  7%  softirqs.CPU41.NET_RX
>      42784 ±  4%     -47.4%      22517 ± 12%  softirqs.CPU41.RCU
>       6271 ±  5%   +1844.2%     121920 ±  3%  softirqs.CPU41.SCHED
>   21882934           -83.8%    3543685 ±  7%  softirqs.CPU42.NET_RX
>      42866 ±  5%     -47.8%      22382 ± 12%  softirqs.CPU42.RCU
>       6293 ±  5%   +1835.9%     121831 ±  3%  softirqs.CPU42.SCHED
>   21812590 ±  2%     -83.8%    3540307 ±  7%  softirqs.CPU43.NET_RX
>      42608 ±  4%     -47.1%      22523 ± 12%  softirqs.CPU43.RCU
>       6295 ±  5%   +1838.9%     122059 ±  3%  softirqs.CPU43.SCHED
>   22126669 ±  4%     -83.9%    3553763 ±  7%  softirqs.CPU44.NET_RX
>      42511 ±  4%     -46.7%      22650 ± 12%  softirqs.CPU44.RCU
>       6177 ±  6%   +1873.7%     121930 ±  3%  softirqs.CPU44.SCHED
>   21879826 ±  3%     -83.7%    3555902 ±  7%  softirqs.CPU45.NET_RX
>      42813 ±  4%     -47.6%      22438 ± 12%  softirqs.CPU45.RCU
>       6279 ±  5%   +1840.8%     121875 ±  3%  softirqs.CPU45.SCHED
>   21900318 ±  2%     -83.8%    3538750 ±  7%  softirqs.CPU46.NET_RX
>      42820 ±  4%     -47.5%      22485 ± 12%  softirqs.CPU46.RCU
>       6373 ±  5%   +1812.3%     121877 ±  3%  softirqs.CPU46.SCHED
>   21967147 ±  2%     -83.9%    3535657 ±  7%  softirqs.CPU47.NET_RX
>      42849 ±  4%     -47.2%      22609 ± 14%  softirqs.CPU47.RCU
>       6273 ±  5%   +1846.6%     122122 ±  3%  softirqs.CPU47.SCHED
>   21580165 ±  2%     -83.6%    3548529 ± 16%  softirqs.CPU48.NET_RX
>      41466 ±  7%     -46.2%      22312 ± 14%  softirqs.CPU48.RCU
>       6443 ±  6%   +1786.2%     121544 ±  3%  softirqs.CPU48.SCHED
>   22278431 ±  3%     -83.9%    3593833 ± 16%  softirqs.CPU49.NET_RX
>      41258 ±  6%     -45.5%      22496 ± 14%  softirqs.CPU49.RCU
>       6345 ±  7%   +1810.5%     121228 ±  3%  softirqs.CPU49.SCHED
>   21250066           -84.8%    3225282 ±  6%  softirqs.CPU5.NET_RX
>      42368 ±  5%     -46.2%      22813 ± 11%  softirqs.CPU5.RCU
>       6452 ± 10%   +1813.3%     123447        softirqs.CPU5.SCHED
>   22119799           -83.8%    3590117 ± 16%  softirqs.CPU50.NET_RX
>      40998 ±  6%     -45.6%      22285 ± 14%  softirqs.CPU50.RCU
>       6331 ±  8%   +1814.3%     121197 ±  3%  softirqs.CPU50.SCHED
>   22079153 ±  4%     -83.7%    3600591 ± 15%  softirqs.CPU51.NET_RX
>      41134 ±  6%     -45.8%      22290 ± 12%  softirqs.CPU51.RCU
>       6289 ±  8%   +1830.0%     121393 ±  3%  softirqs.CPU51.SCHED
>   22196382 ±  2%     -83.7%    3609631 ± 15%  softirqs.CPU52.NET_RX
>      40474 ±  8%     -45.2%      22187 ± 13%  softirqs.CPU52.RCU
>       6311 ±  8%   +1824.4%     121447 ±  3%  softirqs.CPU52.SCHED
>   22092811 ±  2%     -83.7%    3608982 ± 16%  softirqs.CPU53.NET_RX
>      40984 ±  6%     -46.0%      22113 ± 13%  softirqs.CPU53.RCU
>       6295 ±  7%   +1829.4%     121456 ±  3%  softirqs.CPU53.SCHED
>   21971811 ±  2%     -83.7%    3577529 ± 15%  softirqs.CPU54.NET_RX
>      41234 ±  6%     -46.1%      22243 ± 12%  softirqs.CPU54.RCU
>       6359 ±  7%   +1808.7%     121379 ±  3%  softirqs.CPU54.SCHED
>   22349548 ±  2%     -83.9%    3594167 ± 15%  softirqs.CPU55.NET_RX
>      41318 ±  6%     -46.1%      22261 ± 13%  softirqs.CPU55.RCU
>       6289 ±  7%   +1829.7%     121364 ±  3%  softirqs.CPU55.SCHED
>   21867767 ±  2%     -83.5%    3605717 ± 15%  softirqs.CPU56.NET_RX
>      40836 ±  6%     -46.0%      22043 ± 13%  softirqs.CPU56.RCU
>       6366 ±  7%   +1805.6%     121326 ±  3%  softirqs.CPU56.SCHED
>   22368570 ±  2%     -83.8%    3613885 ± 15%  softirqs.CPU57.NET_RX
>      40641 ±  8%     -45.6%      22100 ± 13%  softirqs.CPU57.RCU
>       6312 ±  8%   +1821.9%     121322 ±  3%  softirqs.CPU57.SCHED
>   21968019 ±  2%     -83.7%    3582386 ± 15%  softirqs.CPU58.NET_RX
>      41023 ±  6%     -46.2%      22088 ± 13%  softirqs.CPU58.RCU
>       6281 ±  8%   +1832.7%     121392 ±  3%  softirqs.CPU58.SCHED
>   21916818           -83.6%    3586085 ± 15%  softirqs.CPU59.NET_RX
>      41053 ±  6%     -46.0%      22174 ± 13%  softirqs.CPU59.RCU
>       6295 ±  8%   +1823.7%     121109 ±  4%  softirqs.CPU59.SCHED
>   20991089 ±  2%     -84.8%    3188337 ±  5%  softirqs.CPU6.NET_RX
>      42243 ±  5%     -47.2%      22315 ± 11%  softirqs.CPU6.RCU
>       6471 ±  9%   +1774.2%     121279 ±  5%  softirqs.CPU6.SCHED
>   22041840 ±  3%     -83.7%    3586383 ± 15%  softirqs.CPU60.NET_RX
>      41099 ±  6%     -46.1%      22143 ± 13%  softirqs.CPU60.RCU
>       6302 ±  8%   +1827.1%     121462 ±  3%  softirqs.CPU60.SCHED
>   22130826 ±  3%     -83.8%    3594520 ± 15%  softirqs.CPU61.NET_RX
>      41201 ±  6%     -46.4%      22097 ± 13%  softirqs.CPU61.RCU
>       6314 ±  8%   +1821.3%     121313 ±  3%  softirqs.CPU61.SCHED
>   22135635 ±  2%     -83.8%    3590768 ± 15%  softirqs.CPU62.NET_RX
>      40926 ±  6%     -46.1%      22072 ± 13%  softirqs.CPU62.RCU
>       6326 ±  8%   +1813.3%     121053 ±  3%  softirqs.CPU62.SCHED
>   22006279 ±  2%     -83.6%    3613358 ± 15%  softirqs.CPU63.NET_RX
>      40812 ±  6%     -46.0%      22052 ± 13%  softirqs.CPU63.RCU
>       6289 ±  7%   +1830.4%     121403 ±  3%  softirqs.CPU63.SCHED
>   22162502 ±  2%     -83.8%    3596046 ± 15%  softirqs.CPU64.NET_RX
>      43354 ±  5%     -48.2%      22462 ± 14%  softirqs.CPU64.RCU
>       6298 ±  7%   +1837.0%     122005 ±  3%  softirqs.CPU64.SCHED
>   22015775           -83.8%    3575745 ± 15%  softirqs.CPU65.NET_RX
>      43464 ±  5%     -49.2%      22086 ± 13%  softirqs.CPU65.RCU
>       6270 ±  8%   +1831.5%     121113 ±  3%  softirqs.CPU65.SCHED
>   21944987 ±  3%     -83.6%    3597759 ± 15%  softirqs.CPU66.NET_RX
>      43140 ±  5%     -47.9%      22485 ± 15%  softirqs.CPU66.RCU
>       6282 ±  8%   +1831.3%     121336 ±  3%  softirqs.CPU66.SCHED
>   22129685           -83.8%    3577740 ± 15%  softirqs.CPU67.NET_RX
>      43165 ±  5%     -48.7%      22158 ± 13%  softirqs.CPU67.RCU
>       6445 ±  8%   +1782.4%     121326 ±  3%  softirqs.CPU67.SCHED
>   22073607 ±  2%     -83.6%    3609775 ± 15%  softirqs.CPU68.NET_RX
>      43285 ±  5%     -48.8%      22146 ± 13%  softirqs.CPU68.RCU
>       6304 ±  8%   +1824.2%     121298 ±  3%  softirqs.CPU68.SCHED
>   22033082 ±  3%     -83.6%    3614951 ± 15%  softirqs.CPU69.NET_RX
>      43557 ±  5%     -49.1%      22170 ± 13%  softirqs.CPU69.RCU
>       6300 ±  7%   +1825.1%     121285 ±  3%  softirqs.CPU69.SCHED
>   21053089 ±  2%     -84.7%    3212883 ±  6%  softirqs.CPU7.NET_RX
>      41729 ±  5%     -46.5%      22329 ± 11%  softirqs.CPU7.RCU
>       6348 ±  9%   +1839.3%     123119 ±  2%  softirqs.CPU7.SCHED
>   22178413 ±  2%     -83.9%    3577845 ± 15%  softirqs.CPU70.NET_RX
>      43599 ±  5%     -49.4%      22076 ± 13%  softirqs.CPU70.RCU
>       6317 ±  7%   +1821.0%     121357 ±  3%  softirqs.CPU70.SCHED
>   21762871 ±  3%     -83.6%    3579764 ± 15%  softirqs.CPU71.NET_RX
>      43364 ±  5%     -48.4%      22369 ± 11%  softirqs.CPU71.RCU
>       6382 ±  8%   +1802.1%     121392 ±  3%  softirqs.CPU71.SCHED
>   21023350           -83.8%    3409465 ±  2%  softirqs.CPU72.NET_RX
>      41025 ±  5%     -46.3%      22023 ± 11%  softirqs.CPU72.RCU
>       6814 ± 10%   +1728.9%     124623        softirqs.CPU72.SCHED
>   21302700           -84.1%    3394421 ±  3%  softirqs.CPU73.NET_RX
>      41214 ±  5%     -46.2%      22189 ± 13%  softirqs.CPU73.RCU
>       7056 ± 11%   +1623.5%     121623 ±  5%  softirqs.CPU73.SCHED
>   21291105 ±  2%     -83.8%    3456208 ±  2%  softirqs.CPU74.NET_RX
>      41637 ±  4%     -47.3%      21930 ± 12%  softirqs.CPU74.RCU
>       7027 ±  9%   +1670.0%     124391        softirqs.CPU74.SCHED
>   21429155           -83.9%    3457976 ±  2%  softirqs.CPU75.NET_RX
>      41568 ±  4%     -47.1%      21979 ± 12%  softirqs.CPU75.RCU
>       7044 ± 11%   +1664.6%     124314        softirqs.CPU75.SCHED
>   21534196           -83.9%    3473433 ±  2%  softirqs.CPU76.NET_RX
>      41485 ±  5%     -47.0%      21999 ± 12%  softirqs.CPU76.RCU
>       7002 ± 10%   +1677.6%     124484        softirqs.CPU76.SCHED
>   21488531           -83.9%    3456520 ±  2%  softirqs.CPU77.NET_RX
>      41562 ±  5%     -47.3%      21889 ± 12%  softirqs.CPU77.RCU
>       7070 ± 11%   +1661.2%     124528        softirqs.CPU77.SCHED
>   21287664 ±  2%     -83.8%    3440745 ±  2%  softirqs.CPU78.NET_RX
>      41481 ±  5%     -46.3%      22274 ± 10%  softirqs.CPU78.RCU
>       7055 ± 11%   +1663.8%     124437        softirqs.CPU78.SCHED
>   21590981           -84.0%    3458262 ±  2%  softirqs.CPU79.NET_RX
>      41251 ±  5%     -46.4%      22115 ± 11%  softirqs.CPU79.RCU
>       6734 ± 19%   +1747.5%     124419        softirqs.CPU79.SCHED
>   21204994 ±  2%     -84.7%    3235256 ±  6%  softirqs.CPU8.NET_RX
>      41695 ±  5%     -46.2%      22415 ± 11%  softirqs.CPU8.RCU
>       6459 ±  9%   +1809.6%     123346 ±  2%  softirqs.CPU8.SCHED
>   21455564           -83.8%    3470203 ±  2%  softirqs.CPU80.NET_RX
>      42032 ±  4%     -47.6%      22026 ± 12%  softirqs.CPU80.RCU
>       7050 ± 10%   +1664.9%     124440        softirqs.CPU80.SCHED
>   21494599           -83.9%    3461317 ±  2%  softirqs.CPU81.NET_RX
>      41056 ±  6%     -46.1%      22136 ± 11%  softirqs.CPU81.RCU
>       6993 ± 10%   +1678.7%     124400        softirqs.CPU81.SCHED
>   21500966           -84.0%    3441797 ±  2%  softirqs.CPU82.NET_RX
>      40872 ±  5%     -46.2%      21975 ± 12%  softirqs.CPU82.RCU
>       6986 ± 10%   +1683.8%     124620        softirqs.CPU82.SCHED
>   21415846           -83.9%    3443443 ±  2%  softirqs.CPU83.NET_RX
>      41213 ±  5%     -46.8%      21944 ± 12%  softirqs.CPU83.RCU
>       6971 ± 11%   +1684.8%     124431        softirqs.CPU83.SCHED
>   21158286           -83.7%    3448499 ±  2%  softirqs.CPU84.NET_RX
>      41129 ±  5%     -46.6%      21967 ± 12%  softirqs.CPU84.RCU
>       6981 ± 11%   +1682.7%     124461        softirqs.CPU84.SCHED
>   21275952           -84.4%    3327058 ±  9%  softirqs.CPU85.NET_RX
>      41193 ±  5%     -46.5%      22035 ± 12%  softirqs.CPU85.RCU
>       7038 ± 11%   +1593.4%     119196 ±  9%  softirqs.CPU85.SCHED
>   21456851           -83.8%    3474753 ±  2%  softirqs.CPU86.NET_RX
>      41007 ±  5%     -46.2%      22074 ± 12%  softirqs.CPU86.RCU
>       7009 ± 11%   +1675.5%     124444        softirqs.CPU86.SCHED
>   21294686           -83.7%    3465753 ±  2%  softirqs.CPU87.NET_RX
>      41176 ±  5%     -46.6%      21995 ± 11%  softirqs.CPU87.RCU
>       6978 ± 12%   +1682.5%     124390        softirqs.CPU87.SCHED
>   21345812           -83.8%    3460006 ±  2%  softirqs.CPU88.NET_RX
>      41353 ±  5%     -46.8%      22012 ± 11%  softirqs.CPU88.RCU
>       7042 ± 11%   +1665.8%     124353        softirqs.CPU88.SCHED
>   21158849           -83.6%    3462986 ±  2%  softirqs.CPU89.NET_RX
>      40857 ±  5%     -45.6%      22224 ± 12%  softirqs.CPU89.RCU
>       7006 ± 11%   +1676.5%     124461        softirqs.CPU89.SCHED
>   21346273           -84.8%    3245033 ±  6%  softirqs.CPU9.NET_RX
>      41949 ±  5%     -46.7%      22367 ± 12%  softirqs.CPU9.RCU
>       6324 ± 11%   +1852.5%     123483        softirqs.CPU9.SCHED
>   21316413           -83.9%    3424944 ±  2%  softirqs.CPU90.NET_RX
>      41279 ±  5%     -46.8%      21944 ± 12%  softirqs.CPU90.RCU
>       6992 ± 10%   +1666.1%     123502        softirqs.CPU90.SCHED
>   21383881           -83.8%    3456891 ±  2%  softirqs.CPU91.NET_RX
>      41176 ±  6%     -46.5%      22022 ± 11%  softirqs.CPU91.RCU
>       7075 ±  9%   +1661.4%     124635        softirqs.CPU91.SCHED
>   21450268           -83.8%    3471616 ±  2%  softirqs.CPU92.NET_RX
>      41127 ±  5%     -46.7%      21927 ± 12%  softirqs.CPU92.RCU
>       7017 ± 10%   +1672.8%     124406        softirqs.CPU92.SCHED
>   21340125 ±  2%     -83.7%    3469370 ±  2%  softirqs.CPU93.NET_RX
>      40908 ±  5%     -46.2%      22002 ± 12%  softirqs.CPU93.RCU
>       6971 ± 11%   +1685.2%     124450        softirqs.CPU93.SCHED
>   21331962           -83.8%    3446801 ±  2%  softirqs.CPU94.NET_RX
>      40770 ±  5%     -46.2%      21950 ± 12%  softirqs.CPU94.RCU
>       7047 ± 10%   +1663.5%     124287        softirqs.CPU94.SCHED
>   21284890 ±  2%     -83.8%    3438859 ±  2%  softirqs.CPU95.NET_RX
>      40912 ±  6%     -46.2%      22018 ± 11%  softirqs.CPU95.RCU
>       6982 ± 11%   +1653.8%     122454        softirqs.CPU95.SCHED
>   20868761 ±  2%     -85.3%    3065044 ± 10%  softirqs.CPU96.NET_RX
>      41941 ±  6%     -47.7%      21950 ± 11%  softirqs.CPU96.RCU
>       6293 ± 10%   +1753.4%     116642 ±  9%  softirqs.CPU96.SCHED
>   21024160 ±  2%     -84.7%    3207450 ±  6%  softirqs.CPU97.NET_RX
>      41240 ±  7%     -46.6%      22022 ± 11%  softirqs.CPU97.RCU
>       6305 ±  4%   +1850.6%     122997 ±  2%  softirqs.CPU97.SCHED
>   21004489 ±  2%     -85.0%    3153700 ± 12%  softirqs.CPU98.NET_RX
>      41611 ±  5%     -46.7%      22165 ± 12%  softirqs.CPU98.RCU
>       6416 ±  9%   +1758.5%     119241 ±  6%  softirqs.CPU98.SCHED
>   20862992 ±  2%     -84.4%    3247430 ±  6%  softirqs.CPU99.NET_RX
>      41777 ±  5%     -47.0%      22123 ± 12%  softirqs.CPU99.RCU
>       6486 ±  8%   +1805.9%     123621        softirqs.CPU99.SCHED
>  4.146e+09           -84.0%  6.626e+08 ±  3%  softirqs.NET_RX
>    8087068 ±  5%     -47.4%    4255788 ± 12%  softirqs.RCU
>    1254695 ±  6%   +1775.7%   23534258        softirqs.SCHED
>     737871           -94.0%      44540 ± 11%  softirqs.TIMER
> 
> 
>                                                                                 
>                                netperf.Throughput_tps                           
>                                                                                 
>   40000 +-------------------------------------------------------------------+   
>         |+      + +. ++ +  +            + .+       +                + +   ++|   
>   35000 |-++++++ +  +  +: + ++++++++++++ +  +++++++ +++++++++++++.++ + +++  |   
>   30000 |-+             : :                                                 |   
>         |               : :                                                 |   
>   25000 |-+             : :                                                 |   
>         |               : :                                                 |   
>   20000 |-+             : :                                                 |   
>         |                ::                                                 |   
>   15000 |-+              :                                                  |   
>   10000 |-+              :                                                  |   
>         |                :                                                  |   
>    5000 |OOOOOOOOOO OOOOO:OOO                                               |   
>         |                :                                                  |   
>       0 +-------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                              netperf.Throughput_total_tps                       
>                                                                                 
>   1.6e+07 +-----------------------------------------------------------------+   
>           |                                                                 |   
>   1.4e+07 |+++++++++++++++ ++++++++++++++++.++++++++++++++++++++++++++++++++|   
>   1.2e+07 |-+            : :                                                |   
>           |              : :                                                |   
>     1e+07 |-+            : :                                                |   
>           |              : :                                                |   
>     8e+06 |-+            : :                                                |   
>           |               ::                                                |   
>     6e+06 |-+             :                                                 |   
>     4e+06 |-+             :                                                 |   
>           |               :                                                 |   
>     2e+06 |OOOOOOOOOOOOOOO:OOO                                              |   
>           |               :                                                 |   
>         0 +-----------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                    netperf.workload                             
>                                                                                 
>   4.5e+09 +-----------------------------------------------------------------+   
>           |+++++++++++++++ ++++++++++++++++.++++++++++++++++++++ +++++++++++|   
>     4e+09 |-+            : :                                    +           |   
>   3.5e+09 |-+            : :                                                |   
>           |              : :                                                |   
>     3e+09 |-+            : :                                                |   
>   2.5e+09 |-+            : :                                                |   
>           |              : :                                                |   
>     2e+09 |-+             :                                                 |   
>   1.5e+09 |-+             :                                                 |   
>           |               :                                                 |   
>     1e+09 |-+             :                                                 |   
>     5e+08 |OOOOOOOOOOOOOOO:OOO                                              |   
>           |               :                                                 |   
>         0 +-----------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                               netperf.time.user_time                            
>                                                                                 
>   1400 +--------------------------------------------------------------------+   
>        |++++++++.  +++++ + + +  +.+       +++++++ .+++++++++ ++ ++ .++++++++|   
>   1200 |-+       ++    : :+ + ++   +++++++       +          +  +  +         |   
>        |               : :                                                  |   
>   1000 |-+             : :                                                  |   
>        |               : :                                                  |   
>    800 |-+             : :                                                  |   
>        |               : :                                                  |   
>    600 |-+              :                                                   |   
>        |                :                                                   |   
>    400 |-+           O  :  O                                                |   
>        |OOOOOOOO OOOO OO:OO                                                 |   
>    200 |-+              :                                                   |   
>        |                :                                                   |   
>      0 +--------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                               netperf.time.system_time                          
>                                                                                 
>   20000 +-------------------------------------------------------------------+   
>   18000 |+++ ++++  .+++++ ++++++ +++ + + +.+++ +++++++ ++++ +++++.++++++ +++|   
>         |   +    ++     : :     +   + + +     +       +                     |   
>   16000 |-+             : :                                                 |   
>   14000 |-+             : :                                                 |   
>         |               : :                                                 |   
>   12000 |-+             : :                                                 |   
>   10000 |-+             : :                                                 |   
>    8000 |OOOOOOOOOO OOOOO:OOO                                               |   
>         |                :                                                  |   
>    6000 |-+              :                                                  |   
>    4000 |-+              :                                                  |   
>         |                :                                                  |   
>    2000 |-+              :                                                  |   
>       0 +-------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                      netperf.time.percent_of_cpu_this_job_got                   
>                                                                                 
>   7000 +--------------------------------------------------------------------+   
>        |+++ ++++.+ +++++ ++++++ +.++++ + ++++ ++++.+++ ++++ +++++++.++++ + +|   
>   6000 |-+ +      +    : :     +      + +    +        +                     |   
>        |               : :                                                  |   
>   5000 |-+             : :                                                  |   
>        |               : :                                                  |   
>   4000 |-+             : :                                                  |   
>        |               : :                                                  |   
>   3000 |OOOOOOOO OOOOOOO:OOO                                                |   
>        |                :                                                   |   
>   2000 |-+              :                                                   |   
>        |                :                                                   |   
>   1000 |-+              :                                                   |   
>        |                :                                                   |   
>      0 +--------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                            netperf.time.minor_page_faults                       
>                                                                                 
>   140000 +------------------------------------------------------------------+   
>          |OOOOOOOOOOOOOOOO OOO                                              |   
>   120000 |-+                                                                |   
>          |+++++++++++++++  ++++++++++++++++++++++++++++++++.++++++++++++++++|   
>   100000 |-+            :  :                                                |   
>          |              :  :                                                |   
>    80000 |-+            : :                                                 |   
>          |              : :                                                 |   
>    60000 |-+            : :                                                 |   
>          |               ::                                                 |   
>    40000 |-+             ::                                                 |   
>          |               ::                                                 |   
>    20000 |-+             :                                                  |   
>          |               :                                                  |   
>        0 +------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                         netperf.time.voluntary_context_switches                 
>                                                                                 
>     3e+09 +-----------------------------------------------------------------+   
>           |                                                                 |   
>   2.5e+09 |-+ +                  +       +     +       +                    |   
>           |   ::+  ++       +    ::+ + + :+.   ::+ +   ::+          +       |   
>           |++: + :+  :++   + ++++ + + + :   ++: + ::++: + :+ +++   + +++ + +|   
>     2e+09 |-++   +   +  ++ :            +     +   +   +   + ::  +++     ::+ |   
>           |              : :                                +           +   |   
>   1.5e+09 |-+            : :                                                |   
>           |              : :                                                |   
>     1e+09 |-+            : :                                                |   
>           |               :                                                 |   
>           |OOOOOOOOOOOOOOO:OOO                                              |   
>     5e+08 |-+             :                                                 |   
>           |               :                                                 |   
>         0 +-----------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                        netperf.time.involuntary_context_switches                
>                                                                                 
>   2.5e+09 +-----------------------------------------------------------------+   
>           |                                                 +    +      + + |   
>           |  +       ++ ++              +     +       +     ::   :+     : ::|   
>     2e+09 |++: + ++  : + : +  +     + + :  .++: + + ++: + ++ ++++  + +++ : +|   
>           |   ::+  +:    : :++ ++ ++ + : :+    ::+ +   ::+          +    +  |   
>           |   +     +    : :     +     + ::    +       +                    |   
>   1.5e+09 |-+            : :             +                                  |   
>           |              : :                                                |   
>     1e+09 |-+             ::                                                |   
>           |               :                                                 |   
>           |               :                                                 |   
>     5e+08 |-+             :                                                 |   
>           |               :                                                 |   
>           |               :                                                 |   
>         0 +-----------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                           perf-sched.total_wait_time.max.ms                     
>                                                                                 
>   14000 +-------------------------------------------------------------------+   
>         |                                                                   |   
>   12000 |-+               +                                    +        +  +|   
>         |   ++       ++   :+  +    + + +      ++      ++  ++ ++ +.+   ++ : :|   
>   10000 |+++  +++++.+  ++ : ++ ++++ + + ++.+++  ++++++  ++  +      +++   ++ |   
>         |               : :                                                 |   
>    8000 |-+             : :                                                 |   
>         |               : :                                                 |   
>    6000 |-+             : :                                                 |   
>         |                :                                                  |   
>    4000 |-+              :                                                  |   
>         |                :                                                  |   
>    2000 |-+              :                                                  |   
>         |                :                                                  |   
>       0 +-------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                        perf-sched.total_wait_time.average.ms                    
>                                                                                 
>     2 +---------------------------------------------------------------------+   
>   1.8 |-+ + +                          +     + +     +  +   +               |   
>       |   : ::    +   +           +    :     : :     :  :   :  ++       +   |   
>   1.6 |-+ ::::   + : +: +       ++ : + ::    ::::    ::: :+ :: :: + +  + +  |   
>   1.4 |-+: :  :+ : ++ : ::    + :  ++ : +. +: : :+ +: :: ::: ::  ::::+ :  + |   
>       |+ + +  + +     : :++. + +      +   + + + + + + +  + + ++  + +  +    :|   
>   1.2 |-+             : :   +                                              +|   
>     1 |-+             : :                                                   |   
>   0.8 |-+              ::                                                   |   
>       |                :                                                    |   
>   0.6 |-+              :                                                    |   
>   0.4 |-+              :                                                    |   
>       |                :                                                    |   
>   0.2 |-+              :                                                    |   
>     0 +---------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                           perf-sched.total_sch_delay.max.ms                     
>                                                                                 
>   12000 +-------------------------------------------------------------------+   
>         |    +                                 +       +                    |   
>   10000 |-+  :                                 :       :   +          +     |   
>         |    :            +         +          :       :   ::         :     |   
>         |    ::           :         :+ +       ::      :: + +         :     |   
>    8000 |-+ : :       +   :       + : + :     : :     : : : : +      : :++  |   
>         |   : ++  +.+ :++ ::      ::    +     : ++    : ++  : : +.+  : :: : |   
>    6000 |-+ +  : +   :  : ::     + +     +  + +   + + +      ::::  + + +  + |   
>         | :+    ::   +  : :++  ++         : :+    : :+       : +    +      +|   
>    4000 |:+     +       ::   : :          ::       :         +              |   
>         |+               :   ++            +       +                        |   
>         |                :                                                  |   
>    2000 |-+              :                                                  |   
>         |                :                                                  |   
>       0 +-------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                        perf-sched.total_sch_delay.average.ms                    
>                                                                                 
>    0.3 +--------------------------------------------------------------------+   
>        |     +                                 +        +                +  |   
>   0.25 |-+ + :         +                +    + :      + :   +           +:  |   
>        |   : ::   ++  +:         .++    ::   : ::     : ::+ :  +  +     : : |   
>        |  : : :   : + :: +    + +   :++: +  : : :+.  : : ::: : :+ :: + +  : |   
>    0.2 |+++ + ++.:   + : ::   :::   +  +  +++ + +  +++ + + + ::  : : :+   + |   
>        |         +     : :++++ +                             ++  +  +      +|   
>   0.15 |-+             : :                                                  |   
>        |                ::                                                  |   
>    0.1 |-+              ::                                                  |   
>        |                :                                                   |   
>        |                :                                                   |   
>   0.05 |-+              :                                                   |   
>        |                :                                                   |   
>      0 +--------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                       perf-sched.total_wait_and_delay.count.ms                  
>                                                                                 
>   8e+06 +-------------------------------------------------------------------+   
>         |                                                                  :|   
>   7e+06 |-+  +             ++++ +      +       +       +   + ++   +   +   : |   
>   6e+06 |+++ : + +   ++   +    +:   ++ :   +++ : + +++ : + : ::  :: + :   + |   
>         |: : :::::   : :  :      :  : : : +  : ::::: : :::: :: : : ::: :  : |   
>   5e+06 |-+ : : + : :  +  :      +++  + :+    : : +   : : + :  ++  + + +++  |   
>         |   + +   +.+   + :             +     + +     + +   +               |   
>   4e+06 |-+             : :                                                 |   
>         |               : :                                                 |   
>   3e+06 |-+             ::                                                  |   
>   2e+06 |-+              :                                                  |   
>         |                :                                                  |   
>   1e+06 |-+              :                                                  |   
>         |                :                                                  |   
>       0 +-------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                        perf-sched.total_wait_and_delay.max.ms                   
>                                                                                 
>   25000 +-------------------------------------------------------------------+   
>         |    +                                 +       +                    |   
>         |    :                                 :       :                    |   
>   20000 |-+  :                      +          :       :              +     |   
>         |    ::       +             :          ::      :: +           :     |   
>         |   : :       :           + :         : :     : : : +         ::++  |   
>   15000 |-+ : :    .+ ::+         :: :  +     : :     : :: ::   +   +: :::  |   
>         |   : +++ +  : +: +     ++ : :++ +.   : +++   : ++ : : + + + + +  : |   
>   10000 |++++    +   +  : :+ +++   + +     ++++    ++++    + ++   +       ++|   
>         |               : : +                                               |   
>         |                ::                                                 |   
>    5000 |-+              :                                                  |   
>         |                :                                                  |   
>         |                :                                                  |   
>       0 +-------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                     perf-sched.total_wait_and_delay.average.ms                  
>                                                                                 
>   2.5 +---------------------------------------------------------------------+   
>       |                                                                     |   
>       |   + +                          +     + +     +  +   +               |   
>     2 |-+ : ::    +   +           +    :     : :     :  :   :  ++ +     +   |   
>       |   ::::   + : +: +       ++ : + ::    ::::    ::: :+ :: :: : +  + +  |   
>       | +: :  ++ : ++ : ::    + :  ++ : +. +: : ++ +: :: + : ::  : ::+ :  + |   
>   1.5 |+++ +    +     : :++.++ +      +   + + +   + + +    + ++  + +  +    +|   
>       |               : :                                                   |   
>     1 |-+             : :                                                   |   
>       |                ::                                                   |   
>       |                :                                                    |   
>   0.5 |-+              :                                                    |   
>       |                :                                                    |   
>       |                :                                                    |   
>     0 +---------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   10000 +-------------------------------------------------------------------+   
>    9000 |-+                                               :             ::  |   
>         |                                                 : +          : ++ |   
>    8000 |-+         +  ++         + +                    : ::        + +  : |   
>    7000 |-+ + +    + : ::      +  : :++ +     + +     + +: ::   +    : :  : |   
>         |   :+ ++ +  + :: +   + ++ :   + +    :+ ++   :+ + + :  ::   :::   :|   
>    6000 |:+:     ::   : : :   :    +      +  :     : :       : : : +: :    :|   
>    5000 |+++     +    + : :: +             +++     +++       : +  + + +    :|   
>    4000 |-+             : :++                                ++            +|   
>         |                ::                                                 |   
>    3000 |-+              :                                                  |   
>    2000 |-+              :                                                  |   
>         |                :                                                  |   
>    1000 |-+              :                                                  |   
>       0 +-------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   1.6 +---------------------------------------------------------------------+   
>       |   + +                                + +     +  +                   |   
>   1.4 |-+ : ::    +   +                +     : :     :  :   +           ++  |   
>   1.2 |-+ ::::   + : +:           +  + ::    ::::    ::: :+ :  ++ +     ::  |   
>       | +: :  :+ : + :: +     + ++ ++ : +. +: : :+ +: :: ::: : : :::+. +  : |   
>     1 |+++ +  + +   + : ::   + ::     +   + + + + + + +  + + ::  + +  +   + |   
>       |               : :++.+  +                             ++            +|   
>   0.8 |-+             : :                                                   |   
>       |                ::                                                   |   
>   0.6 |-+              ::                                                   |   
>   0.4 |-+              :                                                    |   
>       |                :                                                    |   
>   0.2 |-+              :                                                    |   
>       |                :                                                    |   
>     0 +---------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   9000 +--------------------------------------------------------------------+   
>        |                          +                       + +               |   
>   8000 |-+                        :                       : :           ++  |   
>   7000 |-+         +   +         : :    +                 :::   +       ::  |   
>        |    ++     :  +: +       : :+  +:     ++       ++ :: :  :    + :  : |   
>   6000 |-+ + :    + : :: :      +  + :+  :   + :      + :: + :  ::+  : +  + |   
>   5000 |-+ :  :  +  + :: ::    +     +   +   :  :+    :  :   : : + +: ::   :|   
>        | ++   + +    : : ::   +          : ++   + : ++   +   +++    + :    +|   
>   4000 |::     +     + : :+  +            ::      : :                 +     |   
>   3000 |++              :: ++             +        +                        |   
>        |                :                                                   |   
>   2000 |-+              :                                                   |   
>   1000 |-+              :                                                   |   
>        |                :                                                   |   
>      0 +--------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   0.6 +---------------------------------------------------------------------+   
>       |                                                                     |   
>   0.5 |-+ + +         +                +     + +     +  +   +               |   
>       |   : ::    +   :           +    ::    : :     :  :   :  +  +     ++  |   
>       |   ::::   + : +: +       ++ : + :+.   ::::+   ::: :+ :: :+ : +  +  : |   
>   0.4 |++: :  ++ : ++ : ::    + :  ++ :   ++: : + ++: :: + : ::  : ::+ :  + |   
>       |  + +    +     : :+ .++ +      +     + +     + +    + ++  + +  +    +|   
>   0.3 |-+             : : +                                                 |   
>       |                ::                                                   |   
>   0.2 |-+              ::                                                   |   
>       |                :                                                    |   
>       |                :                                                    |   
>   0.1 |-+              :                                                    |   
>       |                :                                                    |   
>     0 +---------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>     4e+06 +-----------------------------------------------------------------+   
>           |                                                                :|   
>   3.5e+06 |-+  +            ++++ +      +       +       +   + ++  +   +   : |   
>     3e+06 |+++ : + +  ++   +    +:   ++ :   +++ : + +++ : + : ::  : + :   + |   
>           |: : :::::  : :  :      :  : : : +  : ::::: : :::: :: :: ::: :  : |   
>   2.5e+06 |-+ : : + ::  +  :      +++  + :+    : : +   : : + :  ++ + + +++  |   
>           |   + +   ++   + :             +     + +     + +   +              |   
>     2e+06 |-+            : :                                                |   
>           |              : :                                                |   
>   1.5e+06 |-+            ::                                                 |   
>     1e+06 |-+             :                                                 |   
>           |               :                                                 |   
>    500000 |-+             :                                                 |   
>           |               :                                                 |   
>         0 +-----------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   18000 +-------------------------------------------------------------------+   
>         |                         +                       : +               |   
>   16000 |-+             +         :                       : :           ++  |   
>   14000 |-+         +   :         ::    +                 :::   +       ::  |   
>         |    ++    +:  +: +      : :+  +:      ++      ++: : :  ::   + :  : |   
>   12000 |-+ +  :  +  : :: :     ++ + ++  :    +  :    +  : + :  :: + : +  + |   
>   10000 |-+ :  + +   + :: ::    :        +    :  ++   :  +   : :  + : ::   :|   
>         | ++    ::    : : ::   +          : ++    : ++       +++    + :    +|   
>    8000 |::     +     +  ::+  +           : :      ::                 +     |   
>    6000 |++              :: ++             +       +                        |   
>         |                :                                                  |   
>    4000 |-+              :                                                  |   
>    2000 |-+              :                                                  |   
>         |                :                                                  |   
>       0 +-------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   2.5 +---------------------------------------------------------------------+   
>       |                                                                     |   
>       |                                                                     |   
>     2 |-+ + +         +                +     + +     +  +   +               |   
>       |   : ::   ++  +:           +    ::    : :     : :: + :  ++ +     ++  |   
>       |  : : :   : + :: +       ++ :++ :+.  : : :+  : :: ::: : :: : +  +  : |   
>   1.5 |+++ +  +++   + : ::    + :  +  :   +++ + + +++ +  + + ::  : ::+ :  + |   
>       |               : :++.++ +      +                      ++  + +  +    +|   
>     1 |-+             : :                                                   |   
>       |                ::                                                   |   
>       |                :                                                    |   
>   0.5 |-+              :                                                    |   
>       |                :                                                    |   
>       |                :                                                    |   
>     0 +---------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   10000 +-------------------------------------------------------------------+   
>    9000 |-+                                                             :   |   
>         |         +.                                                    ::  |   
>    8000 |-+       : +                                     +            : +  |   
>    7000 |-+ + +   : :   +    +          ++    + + +   + + ::   ++    + +  : |   
>         |   : : +:   : +:    :   ++ + + : :   : : :   : : :++  : : + : :  + |   
>    6000 |:+ ::::::   :+ :    ::+ : + + :  :   :::: :  ::::  :  : : :: ::  : |   
>    5000 |++: : + +   +  : + : + +      +   ++: : + ++: : +   ::   : + :    :|   
>    4000 |-++ +          : :++                + +     + +     ::   +   +    :|   
>         |                ::                                  ++            +|   
>    3000 |-+              ::                                                 |   
>    2000 |-+              :                                                  |   
>         |                :                                                  |   
>    1000 |-+              :                                                  |   
>       0 +-------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   1.4 +---------------------------------------------------------------------+   
>       |                                                                     |   
>   1.2 |-+ + +         +                +     + +     +  +   +               |   
>       |   : ::   ++   :           +    ::    : :     :  : + :  ++ +     +   |   
>     1 |-+ ::::   : : +: +       ++ : + :+    ::::+   ::: :: :: :: ::+  + +  |   
>       |:+: :  +++  ++ : ::    + :  ++ :  + +: : + :+: :: + : ::  : + + :  + |   
>   0.8 |+++ +          : :++.++ +      +   + + +   + + +    + ++  +    +    :|   
>       |               : :                                                  +|   
>   0.6 |-+              ::                                                   |   
>       |                ::                                                   |   
>   0.4 |-+              :                                                    |   
>       |                :                                                    |   
>   0.2 |-+              :                                                    |   
>       |                :                                                    |   
>     0 +---------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   7000 +--------------------------------------------------------------------+   
>        |     +                                 +        +                   |   
>   6000 |-+   :        +           +            :        :                   |   
>        |     :        :       +   :            :        :               +   |   
>   5000 |-+ + :        ::      :  ::          + :      + :              + +  |   
>        |   : ::      : +      :  : :         : ::     : ::+           +  :  |   
>   4000 |-+ :: :    +++ :      ::+  :+        :: :     :: ::    +      :  :  |   
>        | +: : :   +    : +   : ::  + + +   +: : :   +: : :::+  :+ +   :   : |   
>   3000 |-:: : :+  :    : :   : +      ::+  :: : :   :: : : ::+ : + : :    :+|   
>        | :+ + + : :    : ::+ +        +  : :+ + +   :+ + + +  :    : :    ::|   
>   2000 |:+      ::      ::::::           +:      +.:          +     :+    + |   
>        |+        +      : + +             +        +                +       |   
>   1000 |-+              :                                                   |   
>        |                :                                                   |   
>      0 +--------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>     4e+06 +-----------------------------------------------------------------+   
>           |                                                                :|   
>   3.5e+06 |-+  +            ++++ +      +       +       +   + ++  +   +   : |   
>     3e+06 |+++ : + +  ++   +    +:   ++ :   +++ : + +++ : + : ::  : + :   + |   
>           |: : :::::  : :  :      :  : : : +  : ::::: : :::: :: :: ::: :  : |   
>   2.5e+06 |-+ : : + ::  +  :      +++  + :+    : : +   : : + :  ++ + + +++  |   
>           |   + +   ++   + :             +     + +     + +   +              |   
>     2e+06 |-+            : :                                                |   
>           |              : :                                                |   
>   1.5e+06 |-+            ::                                                 |   
>     1e+06 |-+             :                                                 |   
>           |               :                                                 |   
>    500000 |-+             :                                                 |   
>           |               :                                                 |   
>         0 +-----------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   14000 +-------------------------------------------------------------------+   
>         |     +                                 +       +                   |   
>   12000 |-+   :        +          +             :       :                   |   
>         |     :        :       +  :             :       :              +++  |   
>   10000 |-+ + :        ::      :  ::          + :     + :              : :  |   
>         |   : ::      : +      ::: :          : ::    : ::+     +     +   : |   
>    8000 |-+ :: :  +.+++ :    + :++ ++         :: :    :: ::    + +    :   + |   
>         | +: : :  :     : +  ::      + +++  +: : :+ +: : :::+  :  ++ +     :|   
>    6000 |::+ : :+:      : : : :       +   + :+ : ::::+ : : + + :    ::     +|   
>         |+   + + +      : ::+ +            +   + + +   + +    :     +       |   
>    4000 |-+              ::+                                  +             |   
>         |                :                                                  |   
>    2000 |-+              :                                                  |   
>         |                :                                                  |   
>       0 +-------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   1.4 +---------------------------------------------------------------------+   
>       |                                +                                    |   
>   1.2 |-+ + +         +                :     + +     +  +   +           +   |   
>       |   : ::   ++   :           +    ::    : :     :  : + :  ++ +     ::  |   
>     1 |-+ ::::   : + +: +       ++ : +: +.   ::::+   ::: :: :: :: ::+  + ++ |   
>       |++: :  +++   + : ::    + :  ++ :   ++: : + ++: :: + : ::  : + + :  : |   
>   0.8 |-++ +          : :++.++ +      +     + +     + +    + ++  +    +    :|   
>       |               : :                                                  +|   
>   0.6 |-+              ::                                                   |   
>       |                ::                                                   |   
>   0.4 |-+              :                                                    |   
>       |                :                                                    |   
>   0.2 |-+              :                                                    |   
>       |                :                                                    |   
>     0 +---------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>          perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork    
>                                                                                 
>   14000 +-------------------------------------------------------------------+   
>         |                                                                   |   
>   12000 |-+               +                                    +        +  +|   
>         |   ++       ++   :+  +    + + +      ++      ++  ++ ++ +.+   ++ : :|   
>   10000 |+++  +++++.+  ++ : ++ ++++ + + ++.+++  ++++++  ++  +      +++   ++ |   
>         |               : :                                                 |   
>    8000 |-+             : :                                                 |   
>         |               : :                                                 |   
>    6000 |-+             : :                                                 |   
>         |                :                                                  |   
>    4000 |-+              :                                                  |   
>         |                :                                                  |   
>    2000 |-+              :                                                  |   
>         |                :                                                  |   
>       0 +-------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>         perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork     
>                                                                                 
>   350 +---------------------------------------------------------------------+   
>       |                                                                     |   
>   300 |-+ +           +           +          +       +      +           ++  |   
>       |++ ::      +++ :       +  + :   +  ++ ::   ++ ::   + :   +   +.  : : |   
>   250 |:++ +   +  :  +: +     ::+  + + ::+  + +   : + +   :: : + :++  ++  ++|   
>       |     :.+ : :   : ::   + +    ::+ +      :++     + + + + : +          |   
>   200 |-+   +   +:    : :++.+       +          +        +     +             |   
>       |          +    : :                                                   |   
>   150 |-+              ::                                                   |   
>       |                ::                                                   |   
>   100 |-+              :                                                    |   
>       |                :                                                    |   
>    50 |-+              :                                                    |   
>       |                :                                                    |   
>     0 +---------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork  
>                                                                                 
>   14000 +-------------------------------------------------------------------+   
>         |                                                     +             |   
>   12000 |-+       +         ++       + +                   + +:   +         |   
>         |    +   +:        +  + +    : :       +       +   : : : : :  +     |   
>   10000 |-+  :++ : : +    +    :::  + : :      :++     :++: :: + : +  ::  ++|   
>         | ++ :  :  : :++  :    + + +  + :+. ++ :  + ++ :  + :   +   ++ ++ : |   
>    8000 |++ :   +   :   : :       +     +  +  :    +  :     +            :  |   
>         |   +       +   + :                   +       +                  +  |   
>    6000 |-+             : :                                                 |   
>         |               : :                                                 |   
>    4000 |-+             ::                                                  |   
>         |                :                                                  |   
>    2000 |-+              :                                                  |   
>         |                :                                                  |   
>       0 +-------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>       perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork  
>                                                                                 
>   14000 +-------------------------------------------------------------------+   
>         |                                                                   |   
>   12000 |-+               +                                    +        +  +|   
>         |   ++       ++   :+  +    + + +      ++      ++  ++ ++ +.+   ++ : :|   
>   10000 |+++  +++++.+  ++ : ++ ++++ + + ++.+++  ++++++  ++  +      +++   ++ |   
>         |               : :                                                 |   
>    8000 |-+             : :                                                 |   
>         |               : :                                                 |   
>    6000 |-+             : :                                                 |   
>         |                :                                                  |   
>    4000 |-+              :                                                  |   
>         |                :                                                  |   
>    2000 |-+              :                                                  |   
>         |                :                                                  |   
>       0 +-------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>      perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork   
>                                                                                 
>   350 +---------------------------------------------------------------------+   
>       |                                                                     |   
>   300 |-+ +           +           +          +       +      +           ++  |   
>       |++ ::      +++ :       +  + :   +  ++ ::   ++ ::   + :   +   +.  : : |   
>   250 |:++ +   +  :  +: +     ::+  + + ::+  + +   : + +   :: : + :++  ++  ++|   
>       |     :.+ : :   : ::   + +    ::+ +      :++     + + + + : +          |   
>   200 |-+   +   +:    : :++.+       +          +        +     +             |   
>       |          +    : :                                                   |   
>   150 |-+              ::                                                   |   
>       |                ::                                                   |   
>   100 |-+              :                                                    |   
>       |                :                                                    |   
>    50 |-+              :                                                    |   
>       |                :                                                    |   
>     0 +---------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   140 +---------------------------------------------------------------------+   
>       |                                                       +             |   
>   120 |-+       ++                                            :            +|   
>       | +  +  + ::           +             +  + +  +  +  +    :  + +       :|   
>   100 |-:  :  :: :          +: +           :  : :  :  :: ::   :: : :      ::|   
>       | :  ::: +  :     +  : : :   ++      :  :::  :  :: :+  : : : :      + |   
>    80 |:+:: ::    :     :+ :  ::   :: +   : :: : :: ::  :  : : :: : :     : |   
>       |: :: +     + +   : +   : :  : ::   : :: + :: ::  +  + + ++ : :   + : |   
>    60 |++:+        ::+  :     + :  : +:  .+ :+   :+ :+     : :    + +. + :  |   
>       |  +         +  : :       + :    :+   +    +  +       :         +  +  |   
>    40 |-+             +:         +:    ::                   +               |   
>       |               ::          +    +                                    |   
>    20 |-+              :                                                    |   
>       |                :                                                    |   
>     0 +---------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>           perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork       
>                                                                                 
>   8000 +--------------------------------------------------------------------+   
>        |                                                   +                |   
>   7000 |-+                                                 :                |   
>   6000 |-+                                                 :                |   
>        |               +                                   :                |   
>   5000 |-+             :             +                     :               +|   
>        |               :             :                     :               :|   
>   4000 |-+             :             :                     :             + :|   
>        |               :             :                    : :            : :|   
>   3000 |-+             ::     +      :                    : :         +  : :|   
>   2000 |-+            : :     :     : :                   : :         :  :: |   
>        |              : :     :     : :                   : :         : : : |   
>   1000 |-+            : :    : :    : :+                  : :        : :: : |   
>        |           +  : :    : :    : :::                 + :        : :: : |   
>      0 +--------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>           perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork       
>                                                                                 
>   1000 +--------------------------------------------------------------------+   
>    900 |-+                                                                 +|   
>        |                                                                   :|   
>    800 |-+                                                                 :|   
>    700 |-+                                                                 :|   
>        |                                                                   :|   
>    600 |-+                                                                 :|   
>    500 |-+                                                                 :|   
>    400 |-+                                                                : |   
>        |                                                                  : |   
>    300 |-+                                                 +              : |   
>    200 |-+             +                                   :             +: |   
>        |               :             +                     ::            :: |   
>    100 |-+         +  : :     +      ::+                  : :         + : : |   
>      0 +--------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork      
>                                                                                 
>   60 +----------------------------------------------------------------------+   
>      |         +           +          +                                     |   
>   50 |-+       :           :          :                              +      |   
>      |         :          ::  +       :                              ::     |   
>      |         :          + : :  +    :                              ::    +|   
>   40 |-+  +    ::        +  :+:  :   ::      +        +              : ++  :|   
>      |   + :  : :+       :  :: :: :.+: :+   + :  +   +:       +     :   : : |   
>   30 |++ : :  : ::  ++  +   +  :+ +  : ::+  : :  :+  : :  .+  :: + +:   : + |   
>      | ++   + : +:  ::  :      ::    + :: ++   +:  ++  + + : : + :+ +    :: |   
>   20 |-+     +:  : : : :       +       :        +       +   :+  +        :  |   
>      |        +   :+ : :               +                    +            +  |   
>      |            ::  ::                                                    |   
>   10 |-+          ::  ::                                                    |   
>      |            :   :                                                     |   
>    0 +----------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   800 +---------------------------------------------------------------------+   
>       |                                                      +              |   
>   700 |-+                                                    :              |   
>   600 |-+                                                    :              |   
>       |                                                      :              |   
>   500 |-+                                                    :              |   
>       |                                                      :              |   
>   400 |-+                                                    :              |   
>       |                                                     : :             |   
>   300 |-+                                                   : :             |   
>   200 |-+                                                   : :             |   
>       |                                                     : :             |   
>   100 |-+                                                   : :             |   
>       |     +.                                 +       .+   : :             |   
>     0 +---------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   1600 +--------------------------------------------------------------------+   
>        |                                                                  : |   
>   1400 |-+                                                                : |   
>   1200 |-+                                                                : |   
>        |                                                                  : |   
>   1000 |-+                                                                : |   
>        |                                                                  : |   
>    800 |-+                                                                ::|   
>        |                             +                                   : :|   
>    600 |-+                           :                                   : :|   
>    400 |-+                           :                                   : :|   
>        |                             ::                                  : :|   
>    200 |-+                          : :                                  : :|   
>        |                            : :                                  : :|   
>      0 +--------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   300 +---------------------------------------------------------------------+   
>       |                                                                   : |   
>   250 |-+                                                                 : |   
>       |                                                                   : |   
>       |                                                                   : |   
>   200 |-+                                                                 : |   
>       |                                                                   : |   
>   150 |-+                           +                                     ::|   
>       |                             :                                    : :|   
>   100 |-+                           :                                    : :|   
>       |                             :                                    : :|   
>       |                            : :                                   : :|   
>    50 |-+                          : :                                   : :|   
>       |                            : :                                   : :|   
>     0 +---------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   18 +----------------------------------------------------------------------+   
>      |                                                                      |   
>   16 |-+                                                                    |   
>   14 |-+                                                                    |   
>      |                                                                      |   
>   12 |-+                                                                    |   
>   10 |-+                                                                    |   
>      |                                                                      |   
>    8 |-+                                                                   :|   
>    6 |-+                                                                   :|   
>      |                                                                     :|   
>    4 |-+                                                                   :|   
>    2 |-+                                                                   :|   
>      |                                                                     :|   
>    0 +----------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   0.045 +-------------------------------------------------------------------+   
>         |             +                                                     |   
>    0.04 |-+     +     :                                      +              |   
>   0.035 |-+     :    +:                                      :              |   
>         |      ::    : :   ++                                :              |   
>    0.03 |-+ + ++ :  :  :+  :: +      +  +   + + ++  + + ++ + :  +           |   
>   0.025 |+++: :  :  +  ::  :: :+ +  +:  :  + +: :: + +: :: : :: :+ +        |   
>         |:   :   +  :  +: :  :: + ++  : :  :   : : :   :  ::: :+  + + + + ++|   
>    0.02 |:+  +   : :    : +  :        :: ::    +  ::   +  : : ::    : ::::: |   
>   0.015 |-+       ::    : :  +        +: ::       :       + : :      : + +  |   
>         |         +      ::            + +        +         + +      +      |   
>    0.01 |-+              ::                                                 |   
>   0.005 |-+              :                                                  |   
>         |                :                                                  |   
>       0 +-------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>    0.03 +-------------------------------------------------------------------+   
>         |            :                                       :              |   
>   0.025 |-+     +    ::                                      :              |   
>         |       ::  : :                                    + :              |   
>         | +   ++ +  : +       +             +   ++  +   ++ : ::    +        |   
>    0.02 |-::+ :  :  + : +  ++ ::  + +   +   ::+ ::  ::+ :: :: :    ::      +|   
>         |+ + :    ::   ::  :: :+ + ::+  :  + + :  :+ + :  : : : +.+ +      :|   
>   0.015 |:+  +    ::   +: +  :  +  +  :: :+    +  ::   +  : : :+     :+ + + |   
>         |         +     : :  +        ++ +        +       + + +      + + :: |   
>    0.01 |-+             : :                                              +  |   
>         |                ::                                                 |   
>         |                :                                                  |   
>   0.005 |-+              :                                                  |   
>         |                :                                                  |   
>       0 +-------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   12 +----------------------------------------------------------------------+   
>      |                                  +        +         ++  +            |   
>   10 |-+                                :        :         ::  :            |   
>      |                                  :        :         ::  :            |   
>      |                                  :        :         ::  :            |   
>    8 |-+                                :        :        : :  :            |   
>      |                                  :        :        : :  :            |   
>    6 |-+                                :        :        : :  :            |   
>      |:                                : :      : :       :  :: :           |   
>    4 |:+                               : :      : :       :  :: :           |   
>      |:                                : :      : :       :  :: :           |   
>      |:                                : :      : :      :   :: :           |   
>    2 |:+                               : :      : :      :   :: :           |   
>      |:                                : :      : :      :   :: :           |   
>    0 +----------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                                                                 
>                                                                                 
>   6 +-----------------------------------------------------------------------+   
>     |                                  +        +          +   +            |   
>   5 |-+                                :        :          :   :            |   
>     |                                  :        :          :   :            |   
>     |                                  :        :          :   :            |   
>   4 |-+                                ::       :          :   :            |   
>     |                                  ::       :         ::   :            |   
>   3 |-+                                ::       :         ::   :            |   
>     |:                                : :      : :        : : : :           |   
>   2 |:+                               : :      : :        + : : :           |   
>     |:                                : :      : :        : : : :           |   
>     |:                                :  :     : :        : : : :           |   
>   1 |:+                               :  :     : :       :  : : :           |   
>     |:                                :  :     : :       :  : : :           |   
>   0 +-----------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>     perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64   
>                                                                                 
>   12 +----------------------------------------------------------------------+   
>      |  ++                                 ++       ++       +      +  + +  |   
>   10 |-+::    +                            ::       ::       :      :  : :  |   
>      |  ::    :                     +      ::       ::       :      :  : :  |   
>      | : :    : +                   :     : :      : :       :      :  : :  |   
>    8 |-+ :    : :                   :     + :      + :       :      : :: :  |   
>      | : :    : :                  ::     : :      : :       :      : : ::  |   
>    6 |-: :    : :                  ::     : :      : :       :      : : ::  |   
>      |:   :   :::                  ::    :   :    :   :     : :    : :: : : |   
>    4 |:+  :  : :::                 : :   :   :    :   :     : :    : :: : : |   
>      |+   :  : : :                 : :   +   :    +   :     : :    : :: : : |   
>      |:   :  : : :                 : :   :   :    :   :     : :    : :  + : |   
>    2 |:+  :  : : :                :  :   :   :    :   :     : :    : :    : |   
>      |    :  : : :             +  :  :  :    :   :    :     : :    : :    : |   
>    0 +----------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>     perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64   
>                                                                                 
>   12 +----------------------------------------------------------------------+   
>      |  ++                                 ++       ++       +      +  + +  |   
>   10 |-+::    +                            ::       ::       :      :  : :  |   
>      |  ::    :                     +      ::       ::       :      :  : :  |   
>      | : :    : +                   :     : :      : :       :      :  : :  |   
>    8 |-+ :    : :                   :     + :      + :       :      : :: :  |   
>      | : :    : :                  ::     : :      : :       :      : :: :  |   
>    6 |-: :    : :                  ::     : :      : :       :      : : ::  |   
>      |:   :   :::                  ::    :   :    :   :     : :    : :: : : |   
>    4 |:+  :  : :::                 : :   :   :    :   :     : :    : :: : : |   
>      |+   :  : : :                 : :   +   :    +   :     : :    : :: : : |   
>      |:   :  : : :                 : :   :   :    :   :     : :    : :  : : |   
>    2 |:+  :  : : :                :  :   :   :    :   :     : :    : :  + : |   
>      |    :  : : :                :  :  :    :   :    :     : :    : :    : |   
>    0 +----------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>          perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read        
>                                                                                 
>   14 +----------------------------------------------------------------------+   
>      |                                +                                     |   
>   12 |-+          +         +         :                          +          |   
>      |            :         :        +:                          : +        |   
>   10 |-+          :         :        ::                          : :        |   
>      |            :         :        ::                          : :       +|   
>    8 |-+          :         :        ::                          : :       :|   
>      |            :         :        ::                          : :       :|   
>    6 |-+          ::        ::       : :                         :::       :|   
>      |           : :       : :      :  :                        : : :      :|   
>    4 |-+         : :       : :      :  :                        : : :     : |   
>      |           : : +     : :      :  :                        : : :     : |   
>    2 |-+         : : :     : :      :  :                        : : :     : |   
>      |           : :: :    : :      :  :                        : : :     : |   
>    0 +----------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>          perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read        
>                                                                                 
>   14 +----------------------------------------------------------------------+   
>      |                                +                                     |   
>   12 |-+          +         +         :                          +          |   
>      |            :         :        +:                          : +        |   
>   10 |-+          :         :        ::                          : :        |   
>      |            :         :        ::                          : :       +|   
>    8 |-+          :         :        ::                          : :       :|   
>      |            :         :        ::                          : :       :|   
>    6 |-+          ::        ::       : :                         :::       :|   
>      |           : :       : :      :  :                        : : :      :|   
>    4 |-+         : :       : :      :  :                        : : :     : |   
>      |           : : +     : :      :  :                        : : :     : |   
>    2 |-+         : : :     : :      :  :                        : : :     : |   
>      |           : :: :    : :      :  :                        : : :     : |   
>    0 +----------------------------------------------------------------------+   
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

