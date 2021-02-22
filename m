Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4B23211CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 09:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhBVIKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 03:10:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:48806 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230360AbhBVIKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 03:10:04 -0500
IronPort-SDR: 0QvWadBh7tJw+MRKaZ7TBOSoL9Vn9soMjg+li0tFOmMU2uzYMlsPRfx3sLERfSWjr5EPwWCnxw
 swj5YIeJy+fA==
X-IronPort-AV: E=McAfee;i="6000,8403,9902"; a="183647669"
X-IronPort-AV: E=Sophos;i="5.81,196,1610438400"; 
   d="yaml'?scan'208";a="183647669"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 00:09:15 -0800
IronPort-SDR: ztJRvEFLTKvJALV7UFbd53hGNxj9TlKUOf01ZklmTEvNAjRnRd422Hv7gTQbXOhP9CwNr8HwDs
 OK9e2zSvo7lA==
X-IronPort-AV: E=Sophos;i="5.81,196,1610438400"; 
   d="yaml'?scan'208";a="498398594"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 00:09:09 -0800
Date:   Mon, 22 Feb 2021 16:24:39 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peter Puhov <peter.puhov@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, aubrey.li@linux.intel.com,
        yu.c.chen@intel.com
Subject: [sched/fair]  3edecfef02:  vm-scalability.throughput -9.8% regression
Message-ID: <20210222082439.GB15880@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Greeting,

FYI, we noticed a -9.8% regression of vm-scalability.throughput due to commit:


commit: 3edecfef028536cb19a120ec8788bd8a11f93b9e ("sched/fair: update_pick_idlest() Select group with lowest group_util when idle_cpus are equal")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: vm-scalability
on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 256G memory
with following parameters:

	runtime: 300s
	size: 8T
	test: anon-w-seq-hugetlb
	cpufreq_governor: performance
	ucode: 0x5003003

test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/

In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.throughput -11.0% regression                     |
| test machine     | 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 256G memory            |
| test parameters  | cpufreq_governor=performance                                                    |
|                  | runtime=300s                                                                    |
|                  | size=512G                                                                       |
|                  | test=anon-w-rand-hugetlb                                                        |
|                  | ucode=0x5003003                                                                 |
+------------------+---------------------------------------------------------------------------------+
| testcase: change | phoronix-test-suite: phoronix-test-suite.build-apache.0.seconds 1.8% regression |
| test machine     | 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory            |
| test parameters  | cpufreq_governor=performance                                                    |
|                  | test=build-apache-1.4.0                                                         |
|                  | ucode=0x5002f01                                                                 |
+------------------+---------------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.throughput 7.3% improvement                      |
| test machine     | 104 threads Skylake with 192G memory                                            |
| test parameters  | cpufreq_governor=performance                                                    |
|                  | runtime=300s                                                                    |
|                  | size=8T                                                                         |
|                  | test=anon-w-seq-mt                                                              |
|                  | ucode=0x2006906                                                                 |
+------------------+---------------------------------------------------------------------------------+


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
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/8T/lkp-csl-2sp6/anon-w-seq-hugetlb/vm-scalability/0x5003003

commit: 
  46132e3ac5 ("sched: nohz: stop passing around unused "ticks" parameter.")
  3edecfef02 ("sched/fair: update_pick_idlest() Select group with lowest group_util when idle_cpus are equal")

46132e3ac58cb2ee 3edecfef028536cb19a120ec878 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          0:6            2%           0:6     perf-profile.children.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
    458990            -9.7%     414275        vm-scalability.median
  44358717            -9.8%   40017738        vm-scalability.throughput
   5525037 ±  2%      -9.9%    4977835        vm-scalability.time.minor_page_faults
      8546            -0.8%       8478        vm-scalability.time.percent_of_cpu_this_job_got
     24407 ±  2%      -7.5%      22583        vm-scalability.time.voluntary_context_switches
 1.167e+10 ±  2%     -10.0%  1.051e+10        vm-scalability.workload
   1169502 ± 52%     +45.5%    1701161 ± 25%  cpuidle.C6.usage
  28118772 ±  6%      -9.9%   25339276 ±  6%  meminfo.DirectMap2M
      6.60 ±  3%      +1.0        7.62        mpstat.cpu.all.idle%
   3229132 ±  3%     -11.1%    2871949 ±  7%  numa-numastat.node1.numa_hit
    232.11 ± 21%     +69.2%     392.79 ± 11%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    136950 ± 11%     +28.7%     176223 ±  7%  sched_debug.cpu.avg_idle.stddev
     35785 ± 17%     +49.4%      53474 ± 20%  sched_debug.cpu.max_idle_balance_cost.stddev
      2674 ±  7%     +23.0%       3288 ±  5%  slabinfo.PING.active_objs
      2674 ±  7%     +23.0%       3288 ±  5%  slabinfo.PING.num_objs
      1181 ± 15%     +25.4%       1481 ± 11%  slabinfo.khugepaged_mm_slot.active_objs
      1181 ± 15%     +25.4%       1481 ± 11%  slabinfo.khugepaged_mm_slot.num_objs
      1191 ± 10%     +20.7%       1438 ±  6%  slabinfo.pool_workqueue.active_objs
      4.23 ± 42%     -72.5%       1.17 ± 35%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.hugetlb_acct_memory
     16.19 ± 30%     -55.7%       7.18 ± 77%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.hugetlb_acct_memory
      1459 ±  5%     -12.1%       1283 ±  9%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
      0.94 ± 78%    +164.2%       2.47 ± 14%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.io_schedule.__lock_page_killable.filemap_fault
      0.14 ±174%   +1655.4%       2.54 ± 91%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.kmem_cache_alloc
      0.57 ±165%   +2060.2%      12.23 ± 98%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.kmem_cache_alloc
   5067392 ±  2%     -10.0%    4562800        proc-vmstat.htlb_buddy_alloc_success
     26718            +1.7%      27175        proc-vmstat.nr_slab_reclaimable
   6370475 ±  2%      -8.6%    5823183        proc-vmstat.numa_hit
   6283794 ±  2%      -8.7%    5736041        proc-vmstat.numa_local
 2.596e+09 ±  2%     -10.0%  2.337e+09        proc-vmstat.pgalloc_normal
   6485971 ±  2%      -8.5%    5933932        proc-vmstat.pgfault
 2.595e+09 ±  2%     -10.0%  2.336e+09        proc-vmstat.pgfree
    901.00 ± 17%     -42.7%     516.67 ± 41%  interrupts.CPU14.RES:Rescheduling_interrupts
      6646 ±  3%     -34.4%       4361 ± 36%  interrupts.CPU29.NMI:Non-maskable_interrupts
      6646 ±  3%     -34.4%       4361 ± 36%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
      6700 ±  4%     -36.2%       4272 ± 35%  interrupts.CPU31.NMI:Non-maskable_interrupts
      6700 ±  4%     -36.2%       4272 ± 35%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
      6682 ±  3%     -21.1%       5270 ± 27%  interrupts.CPU36.NMI:Non-maskable_interrupts
      6682 ±  3%     -21.1%       5270 ± 27%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
      6711 ±  3%     -27.5%       4865 ± 33%  interrupts.CPU38.NMI:Non-maskable_interrupts
      6711 ±  3%     -27.5%       4865 ± 33%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    600.50 ±  7%     +15.7%     694.50 ± 13%  interrupts.CPU56.CAL:Function_call_interrupts
    582.50 ±  7%     +80.9%       1054 ± 66%  interrupts.CPU69.CAL:Function_call_interrupts
      1242 ± 48%     -58.3%     518.67 ± 20%  interrupts.CPU7.RES:Rescheduling_interrupts
    148.33 ± 77%    +193.6%     435.50 ± 71%  interrupts.CPU79.RES:Rescheduling_interrupts
    171.33 ± 82%    +145.0%     419.83 ± 63%  interrupts.CPU83.RES:Rescheduling_interrupts
    162.67 ±100%    +151.6%     409.33 ± 48%  interrupts.CPU87.RES:Rescheduling_interrupts
 4.136e+10 ±  2%      -9.7%  3.736e+10        perf-stat.i.branch-instructions
      0.03 ±  2%      +0.0        0.03 ±  2%  perf-stat.i.branch-miss-rate%
   6151456            -6.0%    5779738 ±  4%  perf-stat.i.branch-misses
 4.562e+08 ±  2%      -9.9%  4.113e+08        perf-stat.i.cache-misses
 6.451e+08 ±  2%      -9.9%  5.811e+08        perf-stat.i.cache-references
      2.01 ±  4%     +15.2%       2.32        perf-stat.i.cpi
    232.45           -11.2%     206.42 ±  2%  perf-stat.i.cpu-migrations
    572.36 ±  4%     +14.8%     657.13        perf-stat.i.cycles-between-cache-misses
  3.25e+10 ±  2%      -9.8%  2.933e+10        perf-stat.i.dTLB-loads
    301519           -15.6%     254350 ± 15%  perf-stat.i.dTLB-store-misses
 9.324e+09 ±  2%      -9.6%  8.429e+09        perf-stat.i.dTLB-stores
   1.3e+11 ±  2%      -9.7%  1.174e+11        perf-stat.i.instructions
      0.55 ±  2%      -9.5%       0.50        perf-stat.i.ipc
    868.37 ±  2%      -9.6%     784.90        perf-stat.i.metric.M/sec
     21716            -8.6%      19839        perf-stat.i.minor-faults
     21.27 ± 22%      +8.0       29.24 ± 18%  perf-stat.i.node-load-miss-rate%
   1255035 ± 19%     +28.3%    1610117 ± 18%  perf-stat.i.node-load-misses
   6634872 ±  4%     -20.6%    5266347 ±  6%  perf-stat.i.node-loads
      8.84 ± 20%      +6.5       15.38 ±  5%  perf-stat.i.node-store-miss-rate%
   5327271 ± 18%     +67.2%    8907657 ±  6%  perf-stat.i.node-store-misses
  64286798 ±  3%     -11.1%   57150025 ±  2%  perf-stat.i.node-stores
     21715            -8.6%      19839        perf-stat.i.page-faults
      1.84 ±  2%     +10.7%       2.04        perf-stat.overall.cpi
    524.29 ±  2%     +10.8%     580.76        perf-stat.overall.cycles-between-cache-misses
      0.54 ±  2%      -9.7%       0.49        perf-stat.overall.ipc
     15.96 ± 20%      +7.1       23.10 ± 18%  perf-stat.overall.node-load-miss-rate%
      7.69 ± 19%      +5.7       13.43 ±  6%  perf-stat.overall.node-store-miss-rate%
 4.029e+10 ±  2%      -9.8%  3.633e+10        perf-stat.ps.branch-instructions
   5957957            -5.7%    5617140 ±  4%  perf-stat.ps.branch-misses
 4.449e+08 ±  2%      -9.9%  4.008e+08        perf-stat.ps.cache-misses
 6.291e+08 ±  2%      -9.9%  5.666e+08        perf-stat.ps.cache-references
    228.46           -11.1%     203.13 ±  2%  perf-stat.ps.cpu-migrations
 3.166e+10 ±  2%      -9.9%  2.853e+10        perf-stat.ps.dTLB-loads
    293736           -15.7%     247674 ± 15%  perf-stat.ps.dTLB-store-misses
 9.084e+09 ±  2%      -9.8%  8.198e+09        perf-stat.ps.dTLB-stores
 1.267e+11 ±  2%      -9.8%  1.142e+11        perf-stat.ps.instructions
     21187 ±  2%      -8.5%      19394        perf-stat.ps.minor-faults
   1239244 ± 19%     +30.6%    1618368 ± 18%  perf-stat.ps.node-load-misses
   6538174 ±  4%     -17.7%    5382104 ±  5%  perf-stat.ps.node-loads
   5198958 ± 18%     +65.4%    8600077 ±  5%  perf-stat.ps.node-store-misses
  62564031 ±  3%     -11.3%   55487648 ±  2%  perf-stat.ps.node-stores
     21187 ±  2%      -8.5%      19394        perf-stat.ps.page-faults
 3.844e+13 ±  2%      -9.9%  3.463e+13        perf-stat.total.instructions
     32299 ±  6%     -17.8%      26564 ±  4%  softirqs.CPU0.RCU
     27757 ±  4%     -12.6%      24249 ±  6%  softirqs.CPU10.RCU
     28495 ±  3%     -13.0%      24789 ±  7%  softirqs.CPU11.RCU
     27897 ±  3%     -11.8%      24618 ±  6%  softirqs.CPU12.RCU
     28373 ±  3%     -14.2%      24340 ±  6%  softirqs.CPU13.RCU
     27849 ±  3%     -12.6%      24349 ±  6%  softirqs.CPU14.RCU
     27734 ±  3%     -13.3%      24034 ±  6%  softirqs.CPU15.RCU
     27277 ±  4%     -13.2%      23673 ±  5%  softirqs.CPU17.RCU
     27160 ±  4%     -12.8%      23686 ±  6%  softirqs.CPU18.RCU
     27313 ±  5%     -14.0%      23495 ±  6%  softirqs.CPU19.RCU
     29155 ±  2%     -13.6%      25183 ±  7%  softirqs.CPU2.RCU
     27027 ±  5%     -12.9%      23528 ±  5%  softirqs.CPU20.RCU
     27046 ±  4%     -12.2%      23736 ±  7%  softirqs.CPU21.RCU
     27900 ±  5%     -13.0%      24261 ±  7%  softirqs.CPU23.RCU
     26879 ±  4%     -11.1%      23904 ±  6%  softirqs.CPU25.RCU
     25956 ±  5%     -10.4%      23255 ±  7%  softirqs.CPU27.RCU
     27445 ±  3%     -11.6%      24253 ±  8%  softirqs.CPU33.RCU
     27482 ±  4%     -11.6%      24286 ±  6%  softirqs.CPU34.RCU
     27108 ±  5%     -13.9%      23348 ±  6%  softirqs.CPU36.RCU
     27019 ±  4%     -10.9%      24085 ±  8%  softirqs.CPU37.RCU
     27504 ±  5%     -12.6%      24025 ±  7%  softirqs.CPU38.RCU
     27170 ±  4%     -11.2%      24138 ±  8%  softirqs.CPU39.RCU
     27287 ±  4%     -11.7%      24102 ±  7%  softirqs.CPU40.RCU
     27096 ±  4%     -11.2%      24056 ±  9%  softirqs.CPU43.RCU
     27009 ±  3%     -11.7%      23860 ±  8%  softirqs.CPU44.RCU
     27366 ±  4%     -13.9%      23569 ±  6%  softirqs.CPU45.RCU
     27323 ±  4%     -12.0%      24034 ±  7%  softirqs.CPU46.RCU
     27618 ±  3%     -12.8%      24087 ±  7%  softirqs.CPU47.RCU
     28356 ±  4%     -14.2%      24341 ±  7%  softirqs.CPU48.RCU
     26892 ±  4%      -9.4%      24354 ±  7%  softirqs.CPU49.RCU
     28403 ±  5%     -14.2%      24373 ±  7%  softirqs.CPU50.RCU
     28337 ±  5%     -15.6%      23910 ±  6%  softirqs.CPU53.RCU
     27952 ±  4%     -14.4%      23916 ±  6%  softirqs.CPU54.RCU
     28199 ±  4%     -15.4%      23857 ±  7%  softirqs.CPU55.RCU
      0.33 ±141%  +6.3e+05%       2093 ±223%  softirqs.CPU56.NET_RX
     28099 ±  4%     -13.8%      24224 ±  6%  softirqs.CPU56.RCU
     28113 ±  4%     -14.2%      24116 ±  7%  softirqs.CPU57.RCU
     27887 ±  4%     -13.5%      24124 ±  6%  softirqs.CPU58.RCU
     27956 ±  4%     -14.2%      23997 ±  7%  softirqs.CPU59.RCU
     28251 ±  4%     -13.4%      24471 ±  6%  softirqs.CPU6.RCU
     28020 ±  2%     -13.2%      24312 ±  7%  softirqs.CPU60.RCU
     27891 ±  3%     -12.9%      24280 ±  6%  softirqs.CPU61.RCU
     28095 ±  4%     -13.4%      24333 ±  8%  softirqs.CPU62.RCU
     28016 ±  4%     -14.1%      24058 ±  6%  softirqs.CPU63.RCU
     27348 ±  4%     -14.8%      23301 ±  6%  softirqs.CPU65.RCU
     27408 ±  4%     -14.5%      23427 ±  5%  softirqs.CPU66.RCU
     27249 ±  5%     -14.7%      23251 ±  5%  softirqs.CPU67.RCU
     27053 ±  4%     -13.8%      23315 ±  5%  softirqs.CPU68.RCU
     28186 ±  3%     -13.4%      24410 ±  6%  softirqs.CPU7.RCU
     27294 ±  3%     -14.7%      23281 ±  6%  softirqs.CPU71.RCU
     26266 ±  5%     -10.0%      23643 ±  5%  softirqs.CPU72.RCU
     26186 ±  5%     -12.1%      23027 ±  6%  softirqs.CPU73.RCU
     25744 ±  4%     -10.1%      23132 ±  5%  softirqs.CPU74.RCU
     25639 ±  5%     -12.3%      22473 ±  7%  softirqs.CPU75.RCU
     25588 ±  4%     -10.7%      22854 ±  7%  softirqs.CPU76.RCU
     25598 ±  4%      -9.4%      23183 ±  8%  softirqs.CPU77.RCU
     25639 ±  5%      -9.7%      23159 ±  8%  softirqs.CPU78.RCU
     25717 ±  5%     -11.0%      22881 ±  7%  softirqs.CPU79.RCU
     28004 ±  4%     -12.5%      24494 ±  6%  softirqs.CPU8.RCU
     26695 ±  4%     -11.7%      23561 ±  7%  softirqs.CPU80.RCU
     26830 ±  5%     -12.0%      23616 ±  6%  softirqs.CPU81.RCU
     26860 ±  4%     -11.9%      23673 ±  7%  softirqs.CPU82.RCU
     26629 ±  4%     -13.9%      22939 ±  8%  softirqs.CPU84.RCU
     26646 ±  4%     -11.7%      23524 ±  7%  softirqs.CPU85.RCU
     26604 ±  4%     -11.3%      23607 ±  7%  softirqs.CPU86.RCU
     26997 ±  3%     -12.8%      23554 ±  7%  softirqs.CPU87.RCU
     26914 ±  4%     -12.2%      23624 ±  7%  softirqs.CPU88.RCU
     27892 ±  3%     -13.0%      24257 ±  6%  softirqs.CPU9.RCU
     27074 ±  4%     -12.2%      23767 ±  6%  softirqs.CPU91.RCU
     26630 ±  4%     -11.4%      23605 ±  6%  softirqs.CPU92.RCU
     26610 ±  4%     -13.0%      23142 ±  4%  softirqs.CPU93.RCU
     26844 ±  4%     -12.0%      23615 ±  7%  softirqs.CPU94.RCU
     27037 ±  4%     -11.9%      23828 ±  7%  softirqs.CPU95.RCU
   2617482 ±  4%     -12.3%    2294936 ±  6%  softirqs.RCU


                                                                                
                                vm-scalability.median                           
                                                                                
  480000 +------------------------------------------------------------------+   
         |                                      +.                          |   
  470000 |-+ +.                                :  +.+   +         +.        |   
  460000 |-+ : +.                              :     + + +       +  +. .+.  |   
         |  :    +   +.       .+    .+. .+.+ .+       +   +. .+.+     +   + |   
  450000 |++:     + +  +    .+  + .+   +    +               +              +|   
         | +       +    + .+     +                                          |   
  440000 |-+             +                                                  |   
         |             O                                                    |   
  430000 |-+       O         O                                              |   
  420000 |-+   O     O         O       O   OO O O O O O                     |   
         |               O O     O O O   O                    O   O O       |   
  410000 |-+     O                                      O O O   O     O     |   
         | O O                                                              |   
  400000 +------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2sp6: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/512G/lkp-csl-2sp6/anon-w-rand-hugetlb/vm-scalability/0x5003003

commit: 
  46132e3ac5 ("sched: nohz: stop passing around unused "ticks" parameter.")
  3edecfef02 ("sched/fair: update_pick_idlest() Select group with lowest group_util when idle_cpus are equal")

46132e3ac58cb2ee 3edecfef028536cb19a120ec878 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          6:6          -56%           3:6     perf-profile.children.cycles-pp.error_entry
          0:6           -3%           0:6     perf-profile.self.cycles-pp.error_entry
           :6           83%           5:6     stderr.[perf_record:Captured_and_wrote#MB/tmp/lkp/perf-sched.data(#samples)]
           :6           83%           5:6     stderr.[perf_record:Woken_up#times_to_write_data]
         %stddev     %change         %stddev
             \          |                \  
     79915           -13.3%      69267 ±  7%  vm-scalability.median
   7788072 ±  2%     -11.0%    6929383 ±  7%  vm-scalability.throughput
    168.93 ±  4%     +29.5%     218.77 ± 11%  vm-scalability.time.elapsed_time
    168.93 ±  4%     +29.5%     218.77 ± 11%  vm-scalability.time.elapsed_time.max
      8533            -8.3%       7821 ±  2%  vm-scalability.time.percent_of_cpu_this_job_got
      1201 ±  5%     +32.5%       1591 ± 16%  vm-scalability.time.system_time
     13208 ±  3%     +17.3%      15490 ±  9%  vm-scalability.time.user_time
   2286392 ± 51%     +94.9%    4457153 ± 12%  cpuidle.C1E.usage
    143476           +29.9%     186313 ± 13%  meminfo.Shmem
    579371 ±  7%     +15.1%     666919 ±  7%  numa-numastat.node1.numa_hit
    443.79            -3.8%     426.76        pmeter.Average_Active_Power
     16396 ± 15%     +44.8%      23740 ± 16%  numa-meminfo.node0.Mapped
     53031 ±113%    +140.2%     127393 ± 48%  numa-meminfo.node1.Shmem
      4165 ± 15%     +45.2%       6048 ± 15%  numa-vmstat.node0.nr_mapped
     13269 ±113%    +140.0%      31850 ± 49%  numa-vmstat.node1.nr_shmem
    198.65 ±  3%     +25.1%     248.61 ±  9%  uptime.boot
      3885 ±  6%     +53.4%       5958 ± 12%  uptime.idle
      8.94 ± 14%      +7.7       16.63 ± 13%  mpstat.cpu.all.idle%
      2.33 ±  3%      -0.4        1.91 ±  5%  mpstat.cpu.all.irq%
     81.13            -7.4       73.71 ±  3%  mpstat.cpu.all.usr%
      9.50 ± 14%     +77.2%      16.83 ± 12%  vmstat.cpu.id
     79.33            -8.6%      72.50 ±  3%  vmstat.cpu.us
     86.83            -8.8%      79.17 ±  2%  vmstat.procs.r
      2683 ±  7%     +21.4%       3258 ±  3%  slabinfo.PING.active_objs
      2683 ±  7%     +21.4%       3258 ±  3%  slabinfo.PING.num_objs
      1151 ± 12%     +24.5%       1432 ±  5%  slabinfo.khugepaged_mm_slot.active_objs
      1151 ± 12%     +24.5%       1432 ±  5%  slabinfo.khugepaged_mm_slot.num_objs
      4425 ±  4%     +11.8%       4946 ±  4%  slabinfo.kmem_cache_node.active_objs
      4470 ±  4%     +12.1%       5009 ±  4%  slabinfo.kmem_cache_node.num_objs
      1239 ±  7%     +20.0%       1487 ±  6%  slabinfo.pool_workqueue.active_objs
      1262 ±  7%     +20.5%       1522 ±  5%  slabinfo.pool_workqueue.num_objs
      4554 ±  3%     +16.0%       5281 ±  3%  slabinfo.sock_inode_cache.active_objs
      4554 ±  3%     +16.0%       5281 ±  3%  slabinfo.sock_inode_cache.num_objs
      1049 ±  9%     +18.9%       1248 ±  5%  slabinfo.task_group.active_objs
      1049 ±  9%     +18.9%       1248 ±  5%  slabinfo.task_group.num_objs
     28.39 ± 12%     -16.7%      23.64 ±  8%  sched_debug.cfs_rq:/.load_avg.avg
    620.26 ± 28%     -51.9%     298.11 ± 26%  sched_debug.cfs_rq:/.load_avg.max
     94.54 ± 22%     -36.8%      59.75 ± 23%  sched_debug.cfs_rq:/.load_avg.stddev
    127570 ± 45%    +179.0%     355860 ± 23%  sched_debug.cfs_rq:/.min_vruntime.stddev
    407113 ± 42%    +130.6%     938842 ± 24%  sched_debug.cfs_rq:/.spread0.max
    127615 ± 45%    +178.8%     355784 ± 23%  sched_debug.cfs_rq:/.spread0.stddev
      0.31 ± 79%   +4490.9%      14.03 ± 71%  sched_debug.cfs_rq:/.util_est_enqueued.min
      7.92 ± 35%     +83.2%      14.50 ± 42%  sched_debug.cpu.clock.stddev
     87255 ± 19%     +34.3%     117144 ± 20%  sched_debug.cpu.clock_task.max
     82473 ± 20%     +36.1%     112246 ± 21%  sched_debug.cpu.clock_task.min
    850.75 ± 97%    +254.7%       3017 ± 34%  sched_debug.cpu.curr->pid.min
     53.57 ± 12%     -29.5%      37.75 ± 17%  sched_debug.cpu.nr_uninterruptible.max
    -36.50           -57.8%     -15.40        sched_debug.cpu.nr_uninterruptible.min
     11.35 ± 10%     -33.9%       7.50 ± 10%  sched_debug.cpu.nr_uninterruptible.stddev
     64866            -1.3%      64033        proc-vmstat.nr_anon_pages
   3522603            +7.3%    3781144        proc-vmstat.nr_dirty_background_threshold
   7053819            +7.3%    7571535        proc-vmstat.nr_dirty_threshold
    282108            +3.8%     292946 ±  2%  proc-vmstat.nr_file_pages
  35562144            +7.3%   38151646        proc-vmstat.nr_free_pages
     33958            +8.3%      36786 ±  4%  proc-vmstat.nr_inactive_anon
      8890 ±  2%     +44.1%      12812 ± 21%  proc-vmstat.nr_mapped
      1173            -3.7%       1130        proc-vmstat.nr_page_table_pages
     35769           +30.3%      46606 ± 13%  proc-vmstat.nr_shmem
     25463            +2.6%      26116        proc-vmstat.nr_slab_reclaimable
     33958            +8.3%      36786 ±  4%  proc-vmstat.nr_zone_inactive_anon
   1161650           +13.3%    1316444 ±  5%  proc-vmstat.numa_hit
   1075137           +14.4%    1229766 ±  5%  proc-vmstat.numa_local
     19245 ± 67%     +89.9%      36545 ± 35%  proc-vmstat.numa_pages_migrated
    154360 ± 19%    +107.5%     320246 ± 11%  proc-vmstat.numa_pte_updates
   1080095 ±  2%     +19.1%    1285944 ±  7%  proc-vmstat.pgfault
     19245 ± 67%     +89.9%      36545 ± 35%  proc-vmstat.pgmigrate_success
 1.725e+10 ±  4%     -21.8%  1.349e+10 ± 11%  perf-stat.i.branch-instructions
      0.07            +0.0        0.07 ±  5%  perf-stat.i.branch-miss-rate%
 8.169e+08 ±  4%     -22.1%  6.367e+08 ± 11%  perf-stat.i.cache-misses
 8.391e+08 ±  4%     -22.1%  6.537e+08 ± 11%  perf-stat.i.cache-references
 2.426e+11            -8.6%  2.217e+11 ±  2%  perf-stat.i.cpu-cycles
    172.12 ±  2%      -9.5%     155.81 ±  3%  perf-stat.i.cpu-migrations
    404.33 ±  5%     +18.6%     479.58 ± 12%  perf-stat.i.cycles-between-cache-misses
 2.052e+10 ±  4%     -21.8%  1.604e+10 ± 11%  perf-stat.i.dTLB-loads
 7.416e+09 ±  4%     -21.7%  5.804e+09 ± 11%  perf-stat.i.dTLB-stores
     86.96 ±  2%     -11.0       75.99 ±  4%  perf-stat.i.iTLB-load-miss-rate%
    826335 ±  2%     +15.1%     950959 ±  5%  perf-stat.i.iTLB-load-misses
    255821 ± 20%    +105.4%     525564 ± 15%  perf-stat.i.iTLB-loads
 7.322e+10 ±  4%     -21.8%  5.728e+10 ± 11%  perf-stat.i.instructions
    141223 ±  5%     -29.8%      99153 ± 15%  perf-stat.i.instructions-per-iTLB-miss
      0.31 ±  2%      -9.7%       0.28 ±  7%  perf-stat.i.ipc
      2.52            -8.6%       2.31 ±  2%  perf-stat.i.metric.GHz
    487.25 ±  4%     -21.7%     381.56 ± 10%  perf-stat.i.metric.M/sec
     38.29 ±  3%      +7.8       46.08 ±  6%  perf-stat.i.node-load-miss-rate%
     13.62 ± 26%     +18.9       32.56 ± 21%  perf-stat.i.node-store-miss-rate%
  92357446 ± 17%     +99.0%  1.838e+08 ± 13%  perf-stat.i.node-store-misses
 7.197e+08 ±  7%     -37.6%  4.488e+08 ± 20%  perf-stat.i.node-stores
      0.03 ±  2%      +0.0        0.04 ±  9%  perf-stat.overall.branch-miss-rate%
      3.33 ±  3%     +18.1%       3.94 ± 10%  perf-stat.overall.cpi
    298.83 ±  3%     +18.6%     354.39 ± 10%  perf-stat.overall.cycles-between-cache-misses
     76.28 ±  4%     -11.6       64.65 ±  4%  perf-stat.overall.iTLB-load-miss-rate%
     86734 ±  5%     -30.6%      60222 ± 16%  perf-stat.overall.instructions-per-iTLB-miss
      0.30 ±  3%     -14.6%       0.26 ±  9%  perf-stat.overall.ipc
     26.76 ±  6%      +7.1       33.91 ±  8%  perf-stat.overall.node-load-miss-rate%
     11.69 ± 22%     +18.5       30.19 ± 21%  perf-stat.overall.node-store-miss-rate%
   1.7e+10 ±  4%     -21.5%  1.335e+10 ± 11%  perf-stat.ps.branch-instructions
 8.054e+08 ±  4%     -21.8%    6.3e+08 ± 11%  perf-stat.ps.cache-misses
 8.274e+08 ±  4%     -21.8%  6.469e+08 ± 11%  perf-stat.ps.cache-references
 2.403e+11            -8.1%  2.208e+11 ±  2%  perf-stat.ps.cpu-cycles
    170.38 ±  3%     -10.0%     153.39 ±  3%  perf-stat.ps.cpu-migrations
 2.023e+10 ±  4%     -21.5%  1.587e+10 ± 11%  perf-stat.ps.dTLB-loads
 7.311e+09 ±  4%     -21.4%  5.744e+09 ± 11%  perf-stat.ps.dTLB-stores
    833122 ±  2%     +13.8%     948353 ±  4%  perf-stat.ps.iTLB-load-misses
    261616 ± 18%    +100.2%     523767 ± 15%  perf-stat.ps.iTLB-loads
 7.219e+10 ±  4%     -21.5%  5.669e+10 ± 11%  perf-stat.ps.instructions
   1245235 ±  3%     -18.4%    1015496 ± 14%  perf-stat.ps.node-loads
  92708873 ± 17%     +99.0%  1.845e+08 ± 13%  perf-stat.ps.node-store-misses
 7.078e+08 ±  7%     -37.6%  4.415e+08 ± 21%  perf-stat.ps.node-stores
      0.00 ±223%   +1263.2%       0.04 ± 56%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00 ±149%    +560.7%       0.03 ± 65%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep
      0.14 ±218%    +456.5%       0.79 ± 64%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
      0.00 ±161%   +1627.3%       0.03 ± 54%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.do_wait.kernel_wait4.__do_sys_wait4
      0.00 ±223%  +4.3e+05%       2.85 ± 65%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.pipe_wait.wait_for_partner.fifo_open
      0.00 ±223%   +2015.4%       0.05 ± 51%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.rcu_gp_kthread.kthread.ret_from_fork
      0.01 ±223%    +935.1%       0.06 ± 48%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ±179%    +603.6%       0.07 ± 49%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep
      0.84 ±219%   +1573.8%      14.11 ± 49%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
      0.01 ±190%  +24300.0%       1.87 ±200%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.do_wait.kernel_wait4.__do_sys_wait4
      0.42 ±127%   +1571.1%       7.00 ± 84%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.pipe_read.new_sync_read.vfs_read
      0.00 ±223%  +7.9e+05%      15.89 ± 44%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.pipe_wait.wait_for_partner.fifo_open
      0.04 ±223%  +40511.0%      16.04 ± 45%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.stop_one_cpu
      0.01 ±223%   +1646.7%       0.09 ± 47%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.rcu_gp_kthread.kthread.ret_from_fork
      0.02 ± 80%  +16955.9%       3.87 ±215%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop
      0.04 ± 54%    +199.1%       0.11 ± 40%  perf-sched.total_sch_delay.average.ms
      1214 ±158%   +1006.6%      13433 ± 44%  perf-sched.total_wait_and_delay.count.ms
      1066 ±198%    +455.3%       5923 ± 38%  perf-sched.total_wait_and_delay.max.ms
      1066 ±198%    +455.6%       5923 ± 38%  perf-sched.total_wait_time.max.ms
     28.84 ±220%    +748.6%     244.76 ± 18%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
      4.34 ±222%   +1319.9%      61.56 ± 45%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.do_wait.kernel_wait4.__do_sys_wait4
     10.60 ±223%   +1433.3%     162.49 ± 73%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop
    103.54 ±223%    +536.5%     659.00 ± 14%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
     72.96 ±207%    +622.7%     527.29 ± 36%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
     35.83 ±221%    +562.3%     237.33 ± 35%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.do_wait.kernel_wait4.__do_sys_wait4
    235.33 ±133%   +1168.4%       2985 ± 61%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.pipe_read.new_sync_read.vfs_read
    192.67 ±112%    +380.9%     926.50 ± 36%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.stop_one_cpu
    157.00 ±175%    +705.5%       1264 ± 42%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
    213.33 ±122%    +461.1%       1197 ± 38%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
    112.83 ±194%    +375.5%     536.50 ± 36%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
    167.94 ±221%   +1311.4%       2370 ± 57%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
     46.34 ±202%    +516.1%     285.50 ± 37%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
    174.52 ±223%   +2432.1%       4419 ± 43%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
      1061 ±199%    +428.4%       5608 ± 41%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
      0.01 ±223%   +1716.3%       0.26 ± 40%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.__prepare_exit_to_usermode.prepare_exit_to_usermode.asm_sysvec_reschedule_ipi
     28.70 ±221%    +750.1%     243.98 ± 18%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
      4.33 ±222%   +1319.8%      61.53 ± 45%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.do_wait.kernel_wait4.__do_sys_wait4
      0.40 ±223%    +576.4%       2.70 ± 21%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.rcu_gp_kthread.kthread.ret_from_fork
     13.34 ±192%   +1372.4%     196.36 ± 91%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait
     10.58 ±223%   +1434.6%     162.42 ± 73%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop
    103.53 ±223%    +536.5%     658.98 ± 14%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
     72.51 ±208%    +627.0%     527.14 ± 36%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
      0.04 ±223%  +31752.0%      12.16 ± 49%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.__prepare_exit_to_usermode.prepare_exit_to_usermode.asm_sysvec_reschedule_ipi
    167.75 ±221%   +1313.1%       2370 ± 57%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
      0.83 ±223%    +478.6%       4.80 ±  7%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.rcu_gp_kthread.kthread.ret_from_fork
    130.49 ±208%   +1704.9%       2355 ±110%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait
     46.33 ±202%    +516.2%     285.46 ± 37%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
    174.50 ±223%   +2432.4%       4418 ± 43%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
      1059 ±200%    +429.5%       5608 ± 41%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
     65626 ±  2%     +28.5%      84315 ±  9%  softirqs.CPU1.TIMER
     19554 ±  6%     +20.5%      23569 ± 10%  softirqs.CPU10.RCU
     62870 ±  3%     +22.7%      77143 ±  9%  softirqs.CPU10.TIMER
     19436 ±  6%     +23.8%      24067 ± 10%  softirqs.CPU11.RCU
     19803 ±  7%     +20.9%      23944 ± 10%  softirqs.CPU12.RCU
     19779 ±  7%     +21.1%      23950 ± 11%  softirqs.CPU13.RCU
     20020 ±  5%     +18.0%      23618 ±  9%  softirqs.CPU14.RCU
     19605 ±  5%     +21.2%      23770 ± 12%  softirqs.CPU15.RCU
     62935 ±  3%     +23.3%      77620 ± 10%  softirqs.CPU15.TIMER
     21091 ±  9%     +18.5%      24997 ± 11%  softirqs.CPU17.RCU
     62600 ±  4%     +23.8%      77519 ±  8%  softirqs.CPU17.TIMER
     21645 ±  6%     +18.5%      25653 ±  8%  softirqs.CPU24.RCU
      4111 ± 18%     +48.6%       6108 ± 30%  softirqs.CPU24.SCHED
     20716 ±  9%     +19.7%      24799 ±  9%  softirqs.CPU25.RCU
     20482 ±  3%     +19.4%      24465 ±  9%  softirqs.CPU26.RCU
     20006 ±  6%     +23.5%      24709 ± 11%  softirqs.CPU27.RCU
     19976 ±  6%     +19.1%      23797 ± 10%  softirqs.CPU28.RCU
     20100 ±  6%     +17.6%      23644 ±  9%  softirqs.CPU29.RCU
     20524 ±  7%     +17.4%      24090 ± 10%  softirqs.CPU3.RCU
     19945 ±  6%     +18.1%      23564 ± 10%  softirqs.CPU30.RCU
     63771 ±  2%     +22.3%      77962 ± 10%  softirqs.CPU30.TIMER
     19917 ±  8%     +19.5%      23808 ±  9%  softirqs.CPU31.RCU
     19557 ±  6%     +20.0%      23479 ± 10%  softirqs.CPU32.RCU
      3852 ±  9%     +93.5%       7455 ± 21%  softirqs.CPU34.SCHED
     20202 ±  6%     +21.1%      24467 ± 10%  softirqs.CPU35.RCU
     19446 ±  5%     +21.8%      23679 ± 10%  softirqs.CPU36.RCU
     19717 ±  6%     +20.7%      23805 ± 11%  softirqs.CPU37.RCU
     19892 ±  6%     +20.9%      24041 ±  9%  softirqs.CPU4.RCU
     19835 ±  6%     +21.3%      24051 ± 10%  softirqs.CPU41.RCU
     63390 ±  2%     +23.3%      78189 ± 10%  softirqs.CPU41.TIMER
     19717 ±  7%     +21.5%      23948 ±  9%  softirqs.CPU42.RCU
     19858 ±  8%     +20.5%      23936 ± 10%  softirqs.CPU46.RCU
     62868 ±  2%     +24.8%      78447 ± 10%  softirqs.CPU46.TIMER
     19603 ±  7%     +22.3%      23970 ± 11%  softirqs.CPU47.RCU
     20557 ± 10%     +21.5%      24981 ±  9%  softirqs.CPU48.RCU
      4300 ± 21%     +74.5%       7504 ± 25%  softirqs.CPU48.SCHED
     63555 ±  3%     +23.9%      78714 ±  7%  softirqs.CPU49.TIMER
     20118 ±  6%     +18.5%      23848 ± 10%  softirqs.CPU5.RCU
     19767 ±  6%     +19.3%      23587 ± 10%  softirqs.CPU51.RCU
     19818 ±  6%     +21.6%      24095 ± 11%  softirqs.CPU52.RCU
     19648 ±  7%     +24.1%      24386 ± 11%  softirqs.CPU53.RCU
     19892 ±  9%     +22.8%      24436 ± 10%  softirqs.CPU54.RCU
     19783 ±  8%     +25.1%      24750 ± 10%  softirqs.CPU55.RCU
     63044 ±  3%     +22.0%      76910 ± 10%  softirqs.CPU55.TIMER
     20067 ± 10%     +22.9%      24656 ± 10%  softirqs.CPU56.RCU
     19618 ±  7%     +25.8%      24673 ± 10%  softirqs.CPU57.RCU
     19606 ±  8%     +24.6%      24435 ± 10%  softirqs.CPU58.RCU
     18847 ±  9%     +31.4%      24775 ± 11%  softirqs.CPU59.RCU
     20102 ±  6%     +19.9%      24098 ± 11%  softirqs.CPU6.RCU
     19547 ±  7%     +27.0%      24833 ± 11%  softirqs.CPU60.RCU
     19472 ±  8%     +28.8%      25083 ± 11%  softirqs.CPU61.RCU
     19562 ±  7%     +26.8%      24797 ± 11%  softirqs.CPU62.RCU
     19171 ±  7%     +28.4%      24623 ± 11%  softirqs.CPU63.RCU
     62091 ±  3%     +21.9%      75716 ±  9%  softirqs.CPU63.TIMER
     63260 ±  3%     +22.6%      77542 ±  9%  softirqs.CPU7.TIMER
     62533 ±  3%     +21.7%      76080 ±  7%  softirqs.CPU71.TIMER
      3900 ± 15%    +104.5%       7977 ± 20%  softirqs.CPU73.SCHED
     20119 ±  6%     +17.6%      23668 ± 10%  softirqs.CPU74.RCU
      4061 ± 18%    +103.7%       8272 ± 18%  softirqs.CPU74.SCHED
     19994 ±  6%     +15.1%      23018 ± 11%  softirqs.CPU75.RCU
      3830 ±  9%    +125.2%       8625 ± 19%  softirqs.CPU75.SCHED
      4206 ± 13%     +95.1%       8204 ± 27%  softirqs.CPU76.SCHED
     19954 ±  5%     +18.1%      23567 ± 10%  softirqs.CPU77.RCU
     19666 ±  9%     +19.9%      23589 ±  9%  softirqs.CPU79.RCU
     63515 ±  2%     +23.3%      78312 ± 10%  softirqs.CPU79.TIMER
     19985 ±  7%     +19.5%      23884 ± 11%  softirqs.CPU8.RCU
     18922 ±  6%     +23.1%      23291 ± 11%  softirqs.CPU80.RCU
      4015 ±  5%     +95.9%       7864 ± 24%  softirqs.CPU80.SCHED
     62536 ±  3%     +24.7%      77985 ± 10%  softirqs.CPU80.TIMER
     19059 ±  5%     +25.6%      23938 ±  9%  softirqs.CPU81.RCU
      4262 ± 23%     +83.0%       7801 ± 21%  softirqs.CPU81.SCHED
      4032 ± 10%     +86.2%       7507 ± 31%  softirqs.CPU82.SCHED
     19842 ±  6%     +20.8%      23968 ± 11%  softirqs.CPU83.RCU
      3667 ± 12%    +108.5%       7645 ± 26%  softirqs.CPU83.SCHED
     19061 ±  5%     +24.0%      23642 ± 11%  softirqs.CPU84.RCU
     19111 ±  7%     +23.6%      23617 ± 12%  softirqs.CPU85.RCU
      4056 ±  9%    +105.1%       8318 ± 23%  softirqs.CPU86.SCHED
     19320 ±  6%     +22.7%      23701 ± 12%  softirqs.CPU87.RCU
     19361 ±  5%     +23.0%      23820 ± 11%  softirqs.CPU89.RCU
     19486 ±  6%     +22.8%      23931 ± 11%  softirqs.CPU9.RCU
     62122 ±  3%     +24.4%      77267 ± 10%  softirqs.CPU9.TIMER
     63536 ±  4%     +22.8%      78029 ± 10%  softirqs.CPU90.TIMER
      3918 ± 15%     +88.7%       7392 ± 29%  softirqs.CPU92.SCHED
     62738 ±  2%     +25.1%      78506 ± 11%  softirqs.CPU92.TIMER
     19187 ±  5%     +21.4%      23301 ± 11%  softirqs.CPU93.RCU
      3853 ±  9%     +87.7%       7233 ± 27%  softirqs.CPU93.SCHED
     19058 ±  6%     +22.4%      23332 ± 10%  softirqs.CPU94.RCU
      4009 ± 13%     +93.6%       7762 ± 23%  softirqs.CPU94.SCHED
     62629 ±  3%     +24.5%      77993 ± 10%  softirqs.CPU94.TIMER
     19415 ±  5%     +22.4%      23757 ± 10%  softirqs.CPU95.RCU
   1928612 ±  6%     +20.3%    2320059 ± 10%  softirqs.RCU
    382010 ±  8%     +70.1%     649612 ± 14%  softirqs.SCHED
    341.67 ±  4%     +29.1%     441.00 ± 11%  interrupts.9:IO-APIC.9-fasteoi.acpi
     57582            +6.5%      61309 ±  3%  interrupts.CAL:Function_call_interrupts
    340131 ±  4%     +29.1%     439047 ± 11%  interrupts.CPU0.LOC:Local_timer_interrupts
    103.17 ± 76%     -73.7%      27.17 ± 83%  interrupts.CPU0.TLB:TLB_shootdowns
    341.67 ±  4%     +29.1%     441.00 ± 11%  interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
    339991 ±  4%     +29.3%     439771 ± 11%  interrupts.CPU1.LOC:Local_timer_interrupts
    498.00 ±  5%     +16.4%     579.50 ± 14%  interrupts.CPU10.CAL:Function_call_interrupts
    340281 ±  4%     +29.2%     439731 ± 11%  interrupts.CPU10.LOC:Local_timer_interrupts
    182.00 ±  8%     +21.2%     220.50 ± 11%  interrupts.CPU10.RES:Rescheduling_interrupts
    340509 ±  4%     +29.2%     439804 ± 11%  interrupts.CPU11.LOC:Local_timer_interrupts
    340289 ±  4%     +29.2%     439621 ± 11%  interrupts.CPU12.LOC:Local_timer_interrupts
    340465 ±  4%     +29.2%     439824 ± 11%  interrupts.CPU13.LOC:Local_timer_interrupts
    339838 ±  4%     +29.4%     439785 ± 11%  interrupts.CPU14.LOC:Local_timer_interrupts
    340379 ±  4%     +29.2%     439826 ± 11%  interrupts.CPU15.LOC:Local_timer_interrupts
    340095 ±  4%     +29.3%     439679 ± 11%  interrupts.CPU16.LOC:Local_timer_interrupts
    182.50 ±  9%     +21.4%     221.50 ±  9%  interrupts.CPU16.RES:Rescheduling_interrupts
    340031 ±  4%     +29.3%     439782 ± 11%  interrupts.CPU17.LOC:Local_timer_interrupts
    340439 ±  4%     +29.2%     439759 ± 11%  interrupts.CPU18.LOC:Local_timer_interrupts
    340357 ±  4%     +29.2%     439748 ± 11%  interrupts.CPU19.LOC:Local_timer_interrupts
    340412 ±  4%     +29.1%     439364 ± 11%  interrupts.CPU2.LOC:Local_timer_interrupts
    340418 ±  4%     +29.2%     439903 ± 11%  interrupts.CPU20.LOC:Local_timer_interrupts
    340280 ±  4%     +29.2%     439783 ± 11%  interrupts.CPU21.LOC:Local_timer_interrupts
    340310 ±  4%     +29.3%     439888 ± 11%  interrupts.CPU22.LOC:Local_timer_interrupts
    340236 ±  4%     +29.2%     439693 ± 11%  interrupts.CPU23.LOC:Local_timer_interrupts
    339882 ±  4%     +29.4%     439890 ± 11%  interrupts.CPU24.LOC:Local_timer_interrupts
    339759 ±  4%     +29.5%     440027 ± 11%  interrupts.CPU25.LOC:Local_timer_interrupts
      7299 ±  8%     -18.1%       5977 ± 25%  interrupts.CPU25.NMI:Non-maskable_interrupts
      7299 ±  8%     -18.1%       5977 ± 25%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
    339847 ±  4%     +29.5%     440016 ± 11%  interrupts.CPU26.LOC:Local_timer_interrupts
    616.83 ± 13%     +26.7%     781.33 ± 31%  interrupts.CPU27.CAL:Function_call_interrupts
    339261 ±  4%     +29.7%     439970 ± 11%  interrupts.CPU27.LOC:Local_timer_interrupts
    340015 ±  4%     +29.3%     439801 ± 11%  interrupts.CPU28.LOC:Local_timer_interrupts
    339855 ±  4%     +29.4%     439859 ± 11%  interrupts.CPU29.LOC:Local_timer_interrupts
    340361 ±  4%     +29.2%     439819 ± 11%  interrupts.CPU3.LOC:Local_timer_interrupts
    339860 ±  4%     +29.5%     439980 ± 11%  interrupts.CPU30.LOC:Local_timer_interrupts
    509.00 ±  6%     +15.5%     587.67 ±  8%  interrupts.CPU31.CAL:Function_call_interrupts
    339938 ±  4%     +29.4%     439861 ± 11%  interrupts.CPU31.LOC:Local_timer_interrupts
    339357 ±  4%     +29.6%     439716 ± 11%  interrupts.CPU32.LOC:Local_timer_interrupts
    499.00 ±  3%     +83.1%     913.83 ± 46%  interrupts.CPU33.CAL:Function_call_interrupts
    339849 ±  4%     +29.4%     439820 ± 11%  interrupts.CPU33.LOC:Local_timer_interrupts
    339868 ±  4%     +29.4%     439729 ± 11%  interrupts.CPU34.LOC:Local_timer_interrupts
    490.33 ±  3%     +29.3%     634.00 ± 20%  interrupts.CPU35.CAL:Function_call_interrupts
    339532 ±  4%     +29.5%     439758 ± 11%  interrupts.CPU35.LOC:Local_timer_interrupts
    496.17 ±  3%     +12.2%     556.50 ±  5%  interrupts.CPU36.CAL:Function_call_interrupts
    339718 ±  4%     +29.5%     439936 ± 11%  interrupts.CPU36.LOC:Local_timer_interrupts
    339869 ±  4%     +29.4%     439952 ± 11%  interrupts.CPU37.LOC:Local_timer_interrupts
    339888 ±  4%     +29.4%     439855 ± 11%  interrupts.CPU38.LOC:Local_timer_interrupts
    339940 ±  4%     +29.4%     439869 ± 11%  interrupts.CPU39.LOC:Local_timer_interrupts
    340135 ±  4%     +29.3%     439776 ± 11%  interrupts.CPU4.LOC:Local_timer_interrupts
    339932 ±  4%     +29.4%     439876 ± 11%  interrupts.CPU40.LOC:Local_timer_interrupts
    339713 ±  4%     +29.5%     439930 ± 11%  interrupts.CPU41.LOC:Local_timer_interrupts
    185.83 ± 15%     -21.5%     145.83 ± 14%  interrupts.CPU41.RES:Rescheduling_interrupts
    487.67           +10.2%     537.33 ±  4%  interrupts.CPU42.CAL:Function_call_interrupts
    339970 ±  4%     +29.4%     439827 ± 11%  interrupts.CPU42.LOC:Local_timer_interrupts
    458.17 ± 15%     +30.9%     599.67 ± 11%  interrupts.CPU43.CAL:Function_call_interrupts
    339686 ±  4%     +29.5%     439797 ± 11%  interrupts.CPU43.LOC:Local_timer_interrupts
    339957 ±  4%     +29.4%     439926 ± 11%  interrupts.CPU44.LOC:Local_timer_interrupts
    481.67 ±  2%     +73.1%     833.83 ± 69%  interrupts.CPU45.CAL:Function_call_interrupts
    339787 ±  4%     +29.5%     439868 ± 11%  interrupts.CPU45.LOC:Local_timer_interrupts
    493.83 ±  5%     +66.8%     823.67 ± 73%  interrupts.CPU46.CAL:Function_call_interrupts
    339874 ±  4%     +29.4%     439861 ± 11%  interrupts.CPU46.LOC:Local_timer_interrupts
    339758 ±  4%     +29.5%     439894 ± 11%  interrupts.CPU47.LOC:Local_timer_interrupts
    339804 ±  4%     +29.3%     439236 ± 11%  interrupts.CPU48.LOC:Local_timer_interrupts
    242.67 ± 15%     -17.0%     201.33 ±  7%  interrupts.CPU48.RES:Rescheduling_interrupts
    340200 ±  4%     +29.2%     439670 ± 11%  interrupts.CPU49.LOC:Local_timer_interrupts
    340322 ±  4%     +29.1%     439457 ± 11%  interrupts.CPU5.LOC:Local_timer_interrupts
    340041 ±  4%     +29.2%     439493 ± 11%  interrupts.CPU50.LOC:Local_timer_interrupts
    339801 ±  4%     +29.3%     439499 ± 11%  interrupts.CPU51.LOC:Local_timer_interrupts
    340202 ±  4%     +29.2%     439562 ± 11%  interrupts.CPU52.LOC:Local_timer_interrupts
    340102 ±  4%     +29.3%     439710 ± 11%  interrupts.CPU53.LOC:Local_timer_interrupts
    340363 ±  4%     +29.1%     439574 ± 11%  interrupts.CPU54.LOC:Local_timer_interrupts
    340203 ±  4%     +29.2%     439587 ± 11%  interrupts.CPU55.LOC:Local_timer_interrupts
    340396 ±  4%     +29.2%     439680 ± 11%  interrupts.CPU56.LOC:Local_timer_interrupts
    185.67 ± 26%     -29.2%     131.50 ± 15%  interrupts.CPU56.RES:Rescheduling_interrupts
    340301 ±  4%     +29.1%     439312 ± 11%  interrupts.CPU57.LOC:Local_timer_interrupts
    340195 ±  4%     +29.2%     439494 ± 11%  interrupts.CPU58.LOC:Local_timer_interrupts
    340372 ±  4%     +29.1%     439498 ± 11%  interrupts.CPU59.LOC:Local_timer_interrupts
    340433 ±  4%     +29.1%     439543 ± 11%  interrupts.CPU6.LOC:Local_timer_interrupts
    340431 ±  4%     +29.1%     439499 ± 11%  interrupts.CPU60.LOC:Local_timer_interrupts
    168.50 ± 16%     -26.0%     124.67 ± 17%  interrupts.CPU60.RES:Rescheduling_interrupts
    340384 ±  4%     +29.2%     439617 ± 11%  interrupts.CPU61.LOC:Local_timer_interrupts
    339850 ±  4%     +29.4%     439603 ± 11%  interrupts.CPU62.LOC:Local_timer_interrupts
    203.83 ± 37%     -40.6%     121.17 ± 20%  interrupts.CPU62.RES:Rescheduling_interrupts
    340481 ±  4%     +29.1%     439530 ± 11%  interrupts.CPU63.LOC:Local_timer_interrupts
    162.33 ± 11%     -34.0%     107.17 ± 24%  interrupts.CPU63.RES:Rescheduling_interrupts
    340265 ±  4%     +29.2%     439507 ± 11%  interrupts.CPU64.LOC:Local_timer_interrupts
    181.67 ± 15%     -37.2%     114.00 ± 25%  interrupts.CPU64.RES:Rescheduling_interrupts
    340241 ±  4%     +29.1%     439420 ± 11%  interrupts.CPU65.LOC:Local_timer_interrupts
    339987 ±  4%     +29.3%     439525 ± 11%  interrupts.CPU66.LOC:Local_timer_interrupts
    201.50 ± 29%     -40.3%     120.33 ± 20%  interrupts.CPU66.RES:Rescheduling_interrupts
    340318 ±  4%     +29.2%     439526 ± 11%  interrupts.CPU67.LOC:Local_timer_interrupts
    187.00 ± 27%     -38.0%     116.00 ± 23%  interrupts.CPU67.RES:Rescheduling_interrupts
    340390 ±  4%     +29.1%     439281 ± 11%  interrupts.CPU68.LOC:Local_timer_interrupts
    339729 ±  4%     +29.4%     439626 ± 11%  interrupts.CPU69.LOC:Local_timer_interrupts
    200.50 ± 20%     -46.7%     106.83 ± 25%  interrupts.CPU69.RES:Rescheduling_interrupts
    340337 ±  4%     +29.2%     439776 ± 11%  interrupts.CPU7.LOC:Local_timer_interrupts
    340020 ±  4%     +29.2%     439403 ± 11%  interrupts.CPU70.LOC:Local_timer_interrupts
    339815 ±  4%     +29.4%     439598 ± 11%  interrupts.CPU71.LOC:Local_timer_interrupts
    339751 ±  4%     +29.5%     440065 ± 11%  interrupts.CPU72.LOC:Local_timer_interrupts
      7152 ± 12%     -26.5%       5258 ± 36%  interrupts.CPU72.NMI:Non-maskable_interrupts
      7152 ± 12%     -26.5%       5258 ± 36%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
    340050 ±  4%     +29.3%     439820 ± 11%  interrupts.CPU73.LOC:Local_timer_interrupts
    339658 ±  4%     +29.5%     439755 ± 11%  interrupts.CPU74.LOC:Local_timer_interrupts
    186.17 ±  9%     -33.8%     123.33 ± 32%  interrupts.CPU74.RES:Rescheduling_interrupts
    339690 ±  4%     +29.4%     439718 ± 11%  interrupts.CPU75.LOC:Local_timer_interrupts
    339894 ±  4%     +29.4%     439684 ± 11%  interrupts.CPU76.LOC:Local_timer_interrupts
    339730 ±  4%     +29.5%     439909 ± 11%  interrupts.CPU77.LOC:Local_timer_interrupts
    196.33 ± 27%     -48.0%     102.00 ± 18%  interrupts.CPU77.RES:Rescheduling_interrupts
    339842 ±  4%     +29.4%     439770 ± 11%  interrupts.CPU78.LOC:Local_timer_interrupts
    170.00 ± 10%     -41.2%     100.00 ± 15%  interrupts.CPU78.RES:Rescheduling_interrupts
    339656 ±  4%     +29.5%     439774 ± 11%  interrupts.CPU79.LOC:Local_timer_interrupts
    182.67 ± 25%     -44.8%     100.83 ± 21%  interrupts.CPU79.RES:Rescheduling_interrupts
    340204 ±  4%     +29.2%     439604 ± 11%  interrupts.CPU8.LOC:Local_timer_interrupts
    512.17 ±  8%     +20.2%     615.67 ± 17%  interrupts.CPU80.CAL:Function_call_interrupts
    339513 ±  4%     +29.5%     439578 ± 11%  interrupts.CPU80.LOC:Local_timer_interrupts
    189.83 ±  9%     -38.6%     116.50 ± 13%  interrupts.CPU80.RES:Rescheduling_interrupts
    339817 ±  4%     +29.4%     439864 ± 11%  interrupts.CPU81.LOC:Local_timer_interrupts
    339810 ±  4%     +29.4%     439841 ± 11%  interrupts.CPU82.LOC:Local_timer_interrupts
    190.33 ± 17%     -41.0%     112.33 ± 26%  interrupts.CPU82.RES:Rescheduling_interrupts
    339918 ±  4%     +29.4%     439915 ± 11%  interrupts.CPU83.LOC:Local_timer_interrupts
    170.50 ± 25%     -40.2%     102.00 ± 24%  interrupts.CPU83.RES:Rescheduling_interrupts
    339936 ±  4%     +29.3%     439622 ± 11%  interrupts.CPU84.LOC:Local_timer_interrupts
    175.17 ± 18%     -33.9%     115.83 ± 25%  interrupts.CPU84.RES:Rescheduling_interrupts
    339819 ±  4%     +29.5%     440002 ± 11%  interrupts.CPU85.LOC:Local_timer_interrupts
    339972 ±  4%     +29.4%     439851 ± 11%  interrupts.CPU86.LOC:Local_timer_interrupts
    163.00 ± 10%     -44.9%      89.83 ± 21%  interrupts.CPU86.RES:Rescheduling_interrupts
    339821 ±  4%     +29.4%     439797 ± 11%  interrupts.CPU87.LOC:Local_timer_interrupts
    165.00 ± 21%     -42.6%      94.67 ± 28%  interrupts.CPU87.RES:Rescheduling_interrupts
    339442 ±  4%     +29.6%     439760 ± 11%  interrupts.CPU88.LOC:Local_timer_interrupts
    177.33 ± 28%     -43.4%     100.33 ± 20%  interrupts.CPU88.RES:Rescheduling_interrupts
    489.83 ±  4%      +9.7%     537.17 ±  4%  interrupts.CPU89.CAL:Function_call_interrupts
    339993 ±  4%     +29.4%     439881 ± 11%  interrupts.CPU89.LOC:Local_timer_interrupts
    142.17 ±  9%     -42.4%      81.83 ± 27%  interrupts.CPU89.RES:Rescheduling_interrupts
    340221 ±  4%     +29.3%     439787 ± 11%  interrupts.CPU9.LOC:Local_timer_interrupts
    340036 ±  4%     +29.3%     439661 ± 11%  interrupts.CPU90.LOC:Local_timer_interrupts
      6760 ± 20%     -39.7%       4074 ± 44%  interrupts.CPU90.NMI:Non-maskable_interrupts
      6760 ± 20%     -39.7%       4074 ± 44%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
    488.00 ±  3%     +11.0%     541.67 ±  5%  interrupts.CPU91.CAL:Function_call_interrupts
    339776 ±  4%     +29.4%     439757 ± 11%  interrupts.CPU91.LOC:Local_timer_interrupts
    146.83 ±  6%     -40.2%      87.83 ± 30%  interrupts.CPU91.RES:Rescheduling_interrupts
    485.83 ±  2%     +13.6%     551.83 ±  4%  interrupts.CPU92.CAL:Function_call_interrupts
    339958 ±  4%     +29.4%     439797 ± 11%  interrupts.CPU92.LOC:Local_timer_interrupts
    492.83 ±  3%     +15.7%     570.17 ±  8%  interrupts.CPU93.CAL:Function_call_interrupts
    339955 ±  4%     +29.3%     439696 ± 11%  interrupts.CPU93.LOC:Local_timer_interrupts
    339815 ±  4%     +29.4%     439689 ± 11%  interrupts.CPU94.LOC:Local_timer_interrupts
    156.33 ± 21%     -28.3%     112.17 ± 22%  interrupts.CPU94.RES:Rescheduling_interrupts
    339794 ±  4%     +29.4%     439829 ± 11%  interrupts.CPU95.LOC:Local_timer_interrupts
    183.17 ± 16%     -39.2%     111.33 ± 25%  interrupts.CPU95.RES:Rescheduling_interrupts
  32641163 ±  4%     +29.3%   42213313 ± 11%  interrupts.LOC:Local_timer_interrupts
     23461 ±  5%     -16.4%      19609 ±  7%  interrupts.RES:Rescheduling_interrupts



***************************************************************************************************
lkp-csl-2sp8: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/debian-x86_64-phoronix/lkp-csl-2sp8/build-apache-1.4.0/phoronix-test-suite/0x5002f01

commit: 
  46132e3ac5 ("sched: nohz: stop passing around unused "ticks" parameter.")
  3edecfef02 ("sched/fair: update_pick_idlest() Select group with lowest group_util when idle_cpus are equal")

46132e3ac58cb2ee 3edecfef028536cb19a120ec878 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     14.63            +1.8%      14.89        phoronix-test-suite.build-apache.0.seconds



***************************************************************************************************
lkp-skl-fpga01: 104 threads Skylake with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/8T/lkp-skl-fpga01/anon-w-seq-mt/vm-scalability/0x2006906

commit: 
  46132e3ac5 ("sched: nohz: stop passing around unused "ticks" parameter.")
  3edecfef02 ("sched/fair: update_pick_idlest() Select group with lowest group_util when idle_cpus are equal")

46132e3ac58cb2ee 3edecfef028536cb19a120ec878 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          0:4           -0%           0:4     perf-profile.children.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
      0.01            +8.0%       0.01 ±  4%  vm-scalability.free_time
      3.38 ± 12%      +5.3        8.66 ± 12%  vm-scalability.median_stddev%
      3.26 ± 15%      +7.1       10.34 ±  7%  vm-scalability.stddev%
  56210450            +7.3%   60334907        vm-scalability.throughput
    265111 ±  8%     -60.1%     105700 ±  8%  vm-scalability.time.involuntary_context_switches
  13438401            -5.5%   12695434        vm-scalability.time.minor_page_faults
      7915           -17.9%       6496 ±  2%  vm-scalability.time.percent_of_cpu_this_job_got
     10648           -17.2%       8821        vm-scalability.time.system_time
     13250           -18.3%      10831 ±  2%  vm-scalability.time.user_time
    642704 ±  2%     -19.1%     519971 ±  3%  vm-scalability.time.voluntary_context_switches
  1.45e+10            -5.5%  1.369e+10        vm-scalability.workload
  10522087 ±  4%     -10.9%    9377010 ±  8%  numa-numastat.node0.local_node
  10538954 ±  3%     -10.8%    9398858 ±  8%  numa-numastat.node0.numa_hit
   4254139 ±  5%     -25.5%    3168793 ±  7%  cpuidle.C1.time
    130285 ± 18%     +63.3%     212818 ±  7%  cpuidle.C1.usage
   9419337 ± 14%     +93.4%   18214338 ± 19%  cpuidle.C1E.usage
     44700 ± 32%     +89.7%      84794 ± 15%  cpuidle.POLL.usage
     19.70 ±  4%     +13.9       33.63 ±  4%  mpstat.cpu.all.idle%
      2.96            -0.5        2.51 ±  2%  mpstat.cpu.all.irq%
      0.10 ±  4%      -0.0        0.09 ±  4%  mpstat.cpu.all.soft%
     34.80            -5.7       29.09        mpstat.cpu.all.sys%
     42.44            -7.8       34.68 ±  2%  mpstat.cpu.all.usr%
     19.75 ±  5%     +70.9%      33.75 ±  4%  vmstat.cpu.id
     41.75           -19.2%      33.75 ±  2%  vmstat.cpu.us
     85.75 ±  2%     -20.4%      68.25 ±  3%  vmstat.procs.r
     11715           -29.6%       8243 ±  2%  vmstat.system.cs
    218962            -1.6%     215402        vmstat.system.in
  43452071           -23.2%   33387811 ±  3%  meminfo.Active
  43451815           -23.2%   33387560 ±  3%  meminfo.Active(anon)
  35423963           -22.8%   27358835 ±  2%  meminfo.AnonHugePages
  43350866           -23.2%   33286318 ±  3%  meminfo.AnonPages
  85460025           -17.7%   70295644 ±  2%  meminfo.Committed_AS
  45916525           -22.0%   35824530 ±  2%  meminfo.Memused
     79322           -22.4%      61551        meminfo.PageTables
  22195752           -28.8%   15805718 ± 13%  numa-meminfo.node0.Active
  22195602           -28.8%   15805578 ± 13%  numa-meminfo.node0.Active(anon)
  18149414 ±  2%     -28.8%   12930701 ± 13%  numa-meminfo.node0.AnonHugePages
  22167733           -28.9%   15766874 ± 13%  numa-meminfo.node0.AnonPages
  23410954           -27.2%   17036704 ± 12%  numa-meminfo.node0.MemUsed
     40344 ±  3%     -28.2%      28973 ± 11%  numa-meminfo.node0.PageTables
     39297 ±  6%     -17.5%      32428 ±  9%  numa-meminfo.node1.PageTables
      2983 ±  7%     +19.4%       3563 ±  3%  slabinfo.PING.active_objs
      2983 ±  7%     +19.4%       3563 ±  3%  slabinfo.PING.num_objs
     68005            +9.9%      74707 ±  4%  slabinfo.filp.active_objs
      2138            +9.8%       2347 ±  3%  slabinfo.filp.active_slabs
     68454            +9.8%      75141 ±  3%  slabinfo.filp.num_objs
      2138            +9.8%       2347 ±  3%  slabinfo.filp.num_slabs
      2163 ±  2%     +15.4%       2495 ±  4%  slabinfo.khugepaged_mm_slot.active_objs
      2163 ±  2%     +15.4%       2495 ±  4%  slabinfo.khugepaged_mm_slot.num_objs
   5580820 ±  2%     -29.5%    3935820 ± 12%  numa-vmstat.node0.nr_active_anon
   5573129 ±  2%     -29.6%    3925922 ± 12%  numa-vmstat.node0.nr_anon_pages
      8850 ±  2%     -29.1%       6274 ± 12%  numa-vmstat.node0.nr_anon_transparent_hugepages
     10055 ±  3%     -28.5%       7192 ±  9%  numa-vmstat.node0.nr_page_table_pages
   5578984 ±  2%     -29.5%    3934948 ± 12%  numa-vmstat.node0.nr_zone_active_anon
   5904903 ±  3%     -11.1%    5251633 ±  5%  numa-vmstat.node0.numa_hit
   5854019 ±  3%     -11.7%    5167325 ±  6%  numa-vmstat.node0.numa_local
   5410137 ±  4%     -19.7%    4344194 ± 13%  numa-vmstat.node1.nr_active_anon
   5392926 ±  4%     -19.7%    4327994 ± 13%  numa-vmstat.node1.nr_anon_pages
      8511 ±  5%     -18.8%       6909 ± 13%  numa-vmstat.node1.nr_anon_transparent_hugepages
      9838 ±  6%     -19.1%       7959 ± 10%  numa-vmstat.node1.nr_page_table_pages
   5408962 ±  4%     -19.7%    4343650 ± 13%  numa-vmstat.node1.nr_zone_active_anon
  10810272 ±  2%     -22.9%    8338377 ±  3%  proc-vmstat.nr_active_anon
  10785903 ±  2%     -23.0%    8307576 ±  3%  proc-vmstat.nr_anon_pages
     17152           -22.3%      13324 ±  3%  proc-vmstat.nr_anon_transparent_hugepages
    416.25           +19.1%     495.75        proc-vmstat.nr_dirtied
   3746495            +6.6%    3995298        proc-vmstat.nr_dirty_background_threshold
   7502150            +6.6%    8000365        proc-vmstat.nr_dirty_threshold
  37755991            +6.6%   40234900        proc-vmstat.nr_free_pages
     30461            +1.5%      30909        proc-vmstat.nr_inactive_anon
    498.50            +8.6%     541.25        proc-vmstat.nr_inactive_file
     19383            -1.6%      19063        proc-vmstat.nr_kernel_stack
     10889            +3.6%      11278        proc-vmstat.nr_mapped
     19703 ±  2%     -22.3%      15308 ±  3%  proc-vmstat.nr_page_table_pages
     27773            +2.1%      28351        proc-vmstat.nr_slab_reclaimable
    384.00           +19.1%     457.25        proc-vmstat.nr_written
  10810258 ±  2%     -22.9%    8338369 ±  3%  proc-vmstat.nr_zone_active_anon
     30461            +1.5%      30909        proc-vmstat.nr_zone_inactive_anon
    498.50            +8.6%     541.25        proc-vmstat.nr_zone_inactive_file
      4107 ± 53%    +150.0%      10266 ± 44%  proc-vmstat.numa_hint_faults
      1942 ± 30%    +168.4%       5213 ± 31%  proc-vmstat.numa_hint_faults_local
  20506304            -5.3%   19420736        proc-vmstat.numa_hit
     17544           -14.3%      15040 ±  3%  proc-vmstat.numa_huge_pte_updates
  20472400            -5.3%   19386859        proc-vmstat.numa_local
   9028959           -14.1%    7754371 ±  3%  proc-vmstat.numa_pte_updates
     15121 ±  3%     -17.1%      12528 ±  7%  proc-vmstat.pgactivate
 3.229e+09            -5.5%   3.05e+09        proc-vmstat.pgalloc_normal
  14292546            -5.0%   13576339        proc-vmstat.pgfault
 3.229e+09            -5.6%  3.047e+09        proc-vmstat.pgfree
   6278434            -5.5%    5930869        proc-vmstat.thp_fault_alloc
 4.985e+10            -5.3%   4.72e+10        perf-stat.i.branch-instructions
     74.25            -6.3       67.92        perf-stat.i.cache-miss-rate%
 5.939e+08           -12.5%  5.197e+08 ±  2%  perf-stat.i.cache-misses
 7.946e+08            -5.5%  7.507e+08        perf-stat.i.cache-references
     11837           -30.6%       8214        perf-stat.i.context-switches
      1.41           -12.3%       1.24        perf-stat.i.cpi
 2.208e+11           -16.2%  1.851e+11 ±  2%  perf-stat.i.cpu-cycles
    322.82 ±  2%     -13.5%     279.12        perf-stat.i.cpu-migrations
    376.88            -3.5%     363.72        perf-stat.i.cycles-between-cache-misses
    489941 ±  3%      -8.6%     448035 ±  4%  perf-stat.i.dTLB-load-misses
 3.923e+10            -5.4%  3.711e+10        perf-stat.i.dTLB-loads
      0.00            -0.0        0.00        perf-stat.i.dTLB-store-miss-rate%
    373101           -11.4%     330388 ±  2%  perf-stat.i.dTLB-store-misses
 1.142e+10            -5.4%   1.08e+10        perf-stat.i.dTLB-stores
     32.70 ±  2%     -13.3       19.39 ±  4%  perf-stat.i.iTLB-load-miss-rate%
    309009           -20.7%     245173 ±  2%  perf-stat.i.iTLB-load-misses
    769782           +61.3%    1241809 ±  2%  perf-stat.i.iTLB-loads
 1.562e+11            -5.2%  1.481e+11        perf-stat.i.instructions
    524937 ±  2%     +19.2%     625485        perf-stat.i.instructions-per-iTLB-miss
      0.71           +15.5%       0.82        perf-stat.i.ipc
      2.12           -16.6%       1.77 ±  2%  perf-stat.i.metric.GHz
      1.03            -5.5%       0.97        perf-stat.i.metric.K/sec
    972.02            -5.7%     916.33        perf-stat.i.metric.M/sec
     47339            -5.4%      44776        perf-stat.i.minor-faults
  78879346            -8.5%   72186653 ±  3%  perf-stat.i.node-stores
     47339            -5.4%      44776        perf-stat.i.page-faults
      0.02 ±  2%      +0.0        0.02        perf-stat.overall.branch-miss-rate%
     74.75            -5.6       69.19        perf-stat.overall.cache-miss-rate%
      1.41           -11.6%       1.25        perf-stat.overall.cpi
    371.74            -4.2%     356.07        perf-stat.overall.cycles-between-cache-misses
      0.00            -0.0        0.00        perf-stat.overall.dTLB-store-miss-rate%
     28.67           -12.2       16.49 ±  3%  perf-stat.overall.iTLB-load-miss-rate%
    506889 ±  2%     +19.0%     603033        perf-stat.overall.instructions-per-iTLB-miss
      0.71           +13.2%       0.80        perf-stat.overall.ipc
 4.952e+10            -5.4%  4.685e+10        perf-stat.ps.branch-instructions
 5.899e+08           -12.6%  5.157e+08 ±  2%  perf-stat.ps.cache-misses
 7.892e+08            -5.6%  7.453e+08        perf-stat.ps.cache-references
     11688           -29.9%       8197 ±  2%  perf-stat.ps.context-switches
 2.193e+11           -16.3%  1.836e+11 ±  2%  perf-stat.ps.cpu-cycles
    320.64 ±  2%     -13.7%     276.72        perf-stat.ps.cpu-migrations
    485051 ±  3%      -8.0%     446114 ±  4%  perf-stat.ps.dTLB-load-misses
 3.896e+10            -5.5%  3.683e+10        perf-stat.ps.dTLB-loads
    370445           -11.3%     328471 ±  2%  perf-stat.ps.dTLB-store-misses
 1.134e+10            -5.4%  1.072e+10        perf-stat.ps.dTLB-stores
    306250           -20.4%     243927 ±  2%  perf-stat.ps.iTLB-load-misses
    761977           +62.2%    1235784 ±  2%  perf-stat.ps.iTLB-loads
 1.552e+11            -5.3%   1.47e+11        perf-stat.ps.instructions
     47017            -5.3%      44532        perf-stat.ps.minor-faults
  78362383            -8.6%   71613722 ±  3%  perf-stat.ps.node-stores
     47017            -5.3%      44532        perf-stat.ps.page-faults
 4.689e+13            -4.9%  4.458e+13        perf-stat.total.instructions
     87937 ± 37%     -72.9%      23825 ± 65%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   8567806 ± 39%     -77.2%    1949852 ± 58%  sched_debug.cfs_rq:/.MIN_vruntime.max
    858434 ± 38%     -75.7%     209012 ± 58%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
    116114           -21.5%      91139 ± 10%  sched_debug.cfs_rq:/.exec_clock.avg
    112872           -31.3%      77511 ± 11%  sched_debug.cfs_rq:/.exec_clock.min
      1639 ± 36%    +431.1%       8707 ± 22%  sched_debug.cfs_rq:/.exec_clock.stddev
      6473 ± 30%     -73.5%       1713 ± 68%  sched_debug.cfs_rq:/.load.min
      6.17 ± 16%     -71.1%       1.78 ± 76%  sched_debug.cfs_rq:/.load_avg.min
     87.37 ± 11%     +21.7%     106.37 ±  5%  sched_debug.cfs_rq:/.load_avg.stddev
     87938 ± 37%     -72.9%      23825 ± 65%  sched_debug.cfs_rq:/.max_vruntime.avg
   8567868 ± 39%     -77.2%    1949852 ± 58%  sched_debug.cfs_rq:/.max_vruntime.max
    858441 ± 38%     -75.7%     209012 ± 58%  sched_debug.cfs_rq:/.max_vruntime.stddev
  12384969           -39.1%    7540410 ± 12%  sched_debug.cfs_rq:/.min_vruntime.avg
  12700396           -33.7%    8421155 ± 11%  sched_debug.cfs_rq:/.min_vruntime.max
  11776367           -44.9%    6487882 ± 13%  sched_debug.cfs_rq:/.min_vruntime.min
    192433 ± 19%    +224.6%     624659 ± 22%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.84 ±  3%     -39.5%       0.51 ±  4%  sched_debug.cfs_rq:/.nr_running.avg
      1.75 ± 10%     -27.1%       1.28 ± 14%  sched_debug.cfs_rq:/.nr_running.max
      0.67 ± 30%     -73.8%       0.17 ± 67%  sched_debug.cfs_rq:/.nr_running.min
     79.73 ±  3%     -76.0%      19.11 ± 28%  sched_debug.cfs_rq:/.nr_spread_over.avg
    461.38 ± 12%     -65.9%     157.42 ± 38%  sched_debug.cfs_rq:/.nr_spread_over.max
    109.97 ±  4%     -73.6%      29.00 ± 35%  sched_debug.cfs_rq:/.nr_spread_over.stddev
     80.00 ±  7%     +90.7%     152.53 ± 25%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     10.58 ± 21%     +73.0%      18.31 ± 26%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     80.00 ±  7%     +90.7%     152.53 ± 25%  sched_debug.cfs_rq:/.removed.util_avg.max
     10.58 ± 21%     +72.9%      18.30 ± 26%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    895.32           -45.1%     491.66 ±  9%  sched_debug.cfs_rq:/.runnable_avg.avg
      1932 ±  4%     -32.8%       1298 ± 13%  sched_debug.cfs_rq:/.runnable_avg.max
    692.46 ± 18%     -75.9%     166.95 ± 73%  sched_debug.cfs_rq:/.runnable_avg.min
    -98017          -464.3%     357113 ± 59%  sched_debug.cfs_rq:/.spread0.avg
    219601 ± 40%    +463.9%    1238325 ± 25%  sched_debug.cfs_rq:/.spread0.max
    192966 ± 19%    +223.7%     624595 ± 22%  sched_debug.cfs_rq:/.spread0.stddev
    870.55           -44.9%     479.80 ±  7%  sched_debug.cfs_rq:/.util_avg.avg
      1351 ±  6%     -18.0%       1108 ±  5%  sched_debug.cfs_rq:/.util_avg.max
    485.04 ± 23%     -75.7%     118.10 ± 80%  sched_debug.cfs_rq:/.util_avg.min
    117.61 ± 21%    +108.9%     245.68 ± 20%  sched_debug.cfs_rq:/.util_avg.stddev
    188.04 ± 32%     +42.6%     268.17 ± 16%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      1266 ±  4%     -26.0%     937.65 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.max
    194821 ±  6%     -23.5%     149100 ± 16%  sched_debug.cpu.avg_idle.stddev
     26.39 ± 10%     -63.4%       9.67 ± 36%  sched_debug.cpu.clock.stddev
    683.36 ±  2%     +13.8%     777.64 ±  7%  sched_debug.cpu.clock_task.stddev
     12549 ±  4%     -43.6%       7082 ±  6%  sched_debug.cpu.curr->pid.avg
    688.38 ± 32%     -77.3%     156.39 ± 62%  sched_debug.cpu.curr->pid.min
      0.00 ± 16%     -64.0%       0.00 ± 30%  sched_debug.cpu.next_balance.stddev
      0.86 ±  3%     -41.1%       0.50 ±  6%  sched_debug.cpu.nr_running.avg
      2.08 ±  3%     -30.4%       1.45 ± 16%  sched_debug.cpu.nr_running.max
      0.67 ± 30%     -73.8%       0.17 ± 67%  sched_debug.cpu.nr_running.min
     17246           -27.6%      12481 ±  9%  sched_debug.cpu.nr_switches.avg
      9381           -21.0%       7416 ± 12%  sched_debug.cpu.nr_switches.min
      8758 ±  7%     -20.8%       6938 ± 12%  sched_debug.cpu.nr_switches.stddev
    -66.08           -52.8%     -31.19        sched_debug.cpu.nr_uninterruptible.min
     27.79 ± 20%     -38.8%      17.00 ± 23%  sched_debug.cpu.nr_uninterruptible.stddev
     15920           -30.8%      11015 ± 10%  sched_debug.cpu.sched_count.avg
      8690 ±  2%     -22.4%       6743 ± 13%  sched_debug.cpu.sched_count.min
      8150 ±  7%     -20.4%       6489 ± 14%  sched_debug.cpu.sched_count.stddev
     10908 ± 12%     +78.3%      19451 ± 23%  sched_debug.cpu.sched_goidle.max
      1265 ±  8%    +115.7%       2730 ± 16%  sched_debug.cpu.sched_goidle.stddev
      7617           -31.0%       5258 ± 10%  sched_debug.cpu.ttwu_count.avg
      5158 ±  7%     -29.7%       3625 ±  7%  sched_debug.cpu.ttwu_count.stddev
      3145 ±  2%     -65.8%       1076 ± 15%  sched_debug.cpu.ttwu_local.avg
     20472 ±  7%     -32.5%      13814 ± 17%  sched_debug.cpu.ttwu_local.max
    511.29 ±  4%     -16.8%     425.39 ± 11%  sched_debug.cpu.ttwu_local.min
      3688 ±  7%     -54.8%       1666 ± 18%  sched_debug.cpu.ttwu_local.stddev
     79.71 ±  3%      -7.9       71.85        perf-profile.calltrace.cycles-pp.do_access
     44.86 ±  3%      -5.8       39.07 ±  2%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     44.74 ±  3%      -5.8       38.95 ±  2%  perf-profile.calltrace.cycles-pp.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     42.57 ±  3%      -5.5       37.03 ±  2%  perf-profile.calltrace.cycles-pp.clear_huge_page.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     37.92 ±  3%      -5.2       32.68 ±  2%  perf-profile.calltrace.cycles-pp.clear_page_erms.clear_subpage.clear_huge_page.do_huge_pmd_anonymous_page.__handle_mm_fault
     40.26 ±  3%      -5.2       35.06        perf-profile.calltrace.cycles-pp.clear_subpage.clear_huge_page.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
     38.77 ±  3%      -2.9       35.84 ±  2%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     39.00 ±  3%      -2.0       37.04 ±  2%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
     39.05 ±  3%      -2.0       37.09 ±  2%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
     38.98 ±  3%      -2.0       37.02 ±  2%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
      0.97 ±  5%      -0.1        0.85 ±  2%  perf-profile.calltrace.cycles-pp.___might_sleep.clear_huge_page.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.69 ±  3%      +0.3        1.03 ±  6%  perf-profile.calltrace.cycles-pp.write
      0.68 ±  3%      +0.3        1.03 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      0.68 ±  3%      +0.3        1.03 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.68 ±  3%      +0.3        1.03 ±  7%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.68 ±  3%      +0.3        1.03 ±  7%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.68 ±  3%      +0.3        1.03 ±  7%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.65 ±  3%      +0.3        1.00 ±  7%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold.new_sync_write
      0.66 ±  3%      +0.4        1.01 ±  7%  perf-profile.calltrace.cycles-pp.devkmsg_write.cold.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.65 ±  3%      +0.4        1.01 ±  7%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.cold.new_sync_write.vfs_write
      0.65 ±  3%      +0.4        1.01 ±  7%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.cold.new_sync_write.vfs_write.ksys_write
      0.76 ±  4%      +0.4        1.20 ±  7%  perf-profile.calltrace.cycles-pp.memcpy_erms.drm_fb_helper_dirty_work.process_one_work.worker_thread.kthread
      0.80 ±  4%      +0.4        1.25 ±  7%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.80 ±  4%      +0.4        1.25 ±  7%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.79 ±  5%      +0.4        1.23 ±  7%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.78 ±  4%      +0.4        1.23 ±  7%  perf-profile.calltrace.cycles-pp.drm_fb_helper_dirty_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.79 ±  5%      +0.4        1.23 ±  7%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.25 ±100%      +0.6        0.81 ±  8%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold
      0.00            +0.6        0.59 ±  7%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write
      0.00            +0.7        0.65 ±  7%  perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock
      0.00            +0.7        0.65 ±  7%  perf-profile.calltrace.cycles-pp.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit
      0.00            +0.7        0.74 ±  8%  perf-profile.calltrace.cycles-pp.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit.devkmsg_emit
      1.03 ±  7%      +7.2        8.23 ± 10%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      1.15 ±  7%      +7.3        8.47 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      1.16 ±  7%      +7.3        8.49 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      1.21 ±  7%      +7.4        8.58 ±  9%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
      1.21 ±  7%      +7.4        8.58 ±  9%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      1.21 ±  7%      +7.4        8.58 ±  9%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
      1.22 ±  7%      +7.5        8.70 ±  9%  perf-profile.calltrace.cycles-pp.secondary_startup_64
     44.91 ±  3%      -5.8       39.11 ±  2%  perf-profile.children.cycles-pp.handle_mm_fault
     44.87 ±  3%      -5.8       39.08 ±  2%  perf-profile.children.cycles-pp.__handle_mm_fault
     44.74 ±  3%      -5.8       38.95 ±  2%  perf-profile.children.cycles-pp.do_huge_pmd_anonymous_page
     43.20 ±  3%      -5.6       37.56 ±  2%  perf-profile.children.cycles-pp.clear_huge_page
     67.98 ±  3%      -5.6       62.41        perf-profile.children.cycles-pp.do_access
     38.34 ±  3%      -5.3       33.06 ±  2%  perf-profile.children.cycles-pp.clear_page_erms
     40.49 ±  3%      -5.2       35.26 ±  2%  perf-profile.children.cycles-pp.clear_subpage
     45.23 ±  3%      -4.9       40.38 ±  3%  perf-profile.children.cycles-pp.asm_exc_page_fault
     45.17 ±  3%      -4.8       40.32 ±  3%  perf-profile.children.cycles-pp.exc_page_fault
     45.13 ±  3%      -4.8       40.30 ±  3%  perf-profile.children.cycles-pp.do_user_addr_fault
     35.89 ±  2%      -2.4       33.45 ±  2%  perf-profile.children.cycles-pp.do_rw_once
      1.36 ±  8%      -0.3        1.10 ± 11%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.84 ±  7%      -0.3        1.59 ±  8%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.61 ±  8%      -0.2        1.38 ±  9%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.58 ±  8%      -0.2        1.35 ±  9%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.31 ±  5%      -0.2        1.08 ±  3%  perf-profile.children.cycles-pp.___might_sleep
      1.02 ± 10%      -0.2        0.80 ± 10%  perf-profile.children.cycles-pp.tick_sched_handle
      1.00 ± 10%      -0.2        0.79 ± 10%  perf-profile.children.cycles-pp.update_process_times
      1.08 ± 10%      -0.2        0.87 ± 11%  perf-profile.children.cycles-pp.tick_sched_timer
      0.66 ± 10%      -0.1        0.51 ±  9%  perf-profile.children.cycles-pp.scheduler_tick
      0.48 ± 11%      -0.1        0.37 ± 11%  perf-profile.children.cycles-pp.task_tick_fair
      0.95 ±  2%      -0.1        0.85 ±  3%  perf-profile.children.cycles-pp._cond_resched
      0.20 ± 10%      -0.0        0.16 ± 10%  perf-profile.children.cycles-pp.update_load_avg
      0.15 ±  4%      -0.0        0.11 ± 11%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.15 ±  2%      -0.0        0.11 ± 11%  perf-profile.children.cycles-pp.__softirqentry_text_start
      1.14            -0.0        1.10 ±  2%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.12 ±  3%      -0.0        0.09 ± 11%  perf-profile.children.cycles-pp.prepare_exit_to_usermode
      0.18 ±  4%      -0.0        0.15 ±  5%  perf-profile.children.cycles-pp.pte_alloc_one
      0.14 ±  3%      -0.0        0.11        perf-profile.children.cycles-pp.mem_cgroup_charge
      0.12 ±  3%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.11 ±  4%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.lru_cache_add
      0.10            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      0.08 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.__perf_sw_event
      0.08 ±  6%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.___perf_sw_event
      0.08 ±  5%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.page_add_new_anon_rmap
      0.07 ±  5%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.07 ±  5%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.09            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.try_charge
      0.11 ± 10%      +0.0        0.15 ±  6%  perf-profile.children.cycles-pp.ktime_get
      0.10 ±  8%      +0.1        0.17 ± 12%  perf-profile.children.cycles-pp.__free_pages_ok
      0.14 ±  8%      +0.1        0.22 ±  9%  perf-profile.children.cycles-pp.release_pages
      0.01 ±173%      +0.1        0.10 ± 17%  perf-profile.children.cycles-pp.io_serial_out
      0.13 ± 11%      +0.1        0.21 ± 10%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.13 ± 11%      +0.1        0.21 ± 10%  perf-profile.children.cycles-pp.tlb_flush_mmu
      0.12 ± 14%      +0.1        0.21 ± 15%  perf-profile.children.cycles-pp.__munmap
      0.15 ±  8%      +0.1        0.25 ± 11%  perf-profile.children.cycles-pp.unmap_region
      0.16 ±  7%      +0.1        0.26 ± 10%  perf-profile.children.cycles-pp.__vm_munmap
      0.16 ±  7%      +0.1        0.26 ± 10%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.16 ±  7%      +0.1        0.26 ± 10%  perf-profile.children.cycles-pp.__do_munmap
      0.27 ±  3%      +0.1        0.39 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.1        0.12 ± 39%  perf-profile.children.cycles-pp.start_kernel
      0.25 ±  4%      +0.1        0.37 ±  8%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.43 ±  3%      +0.2        0.67 ±  7%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.40 ±  3%      +0.3        0.67 ±  7%  perf-profile.children.cycles-pp.io_serial_in
      0.46 ±  4%      +0.3        0.73 ±  7%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.46 ±  3%      +0.3        0.76 ±  7%  perf-profile.children.cycles-pp.uart_console_write
      0.51 ±  4%      +0.3        0.82 ±  7%  perf-profile.children.cycles-pp.serial8250_console_write
      0.69 ±  3%      +0.3        1.03 ±  6%  perf-profile.children.cycles-pp.write
      0.68 ±  3%      +0.3        1.02 ±  7%  perf-profile.children.cycles-pp.console_unlock
      0.66 ±  3%      +0.4        1.01 ±  7%  perf-profile.children.cycles-pp.devkmsg_write.cold
      0.65 ±  3%      +0.4        1.01 ±  7%  perf-profile.children.cycles-pp.devkmsg_emit
      0.69 ±  3%      +0.4        1.05 ±  6%  perf-profile.children.cycles-pp.new_sync_write
      0.68 ±  3%      +0.4        1.04 ±  6%  perf-profile.children.cycles-pp.vprintk_emit
      0.69 ±  3%      +0.4        1.05 ±  6%  perf-profile.children.cycles-pp.ksys_write
      0.69 ±  3%      +0.4        1.05 ±  6%  perf-profile.children.cycles-pp.vfs_write
      1.01 ±  2%      +0.4        1.44 ±  5%  perf-profile.children.cycles-pp.do_syscall_64
      1.01 ±  2%      +0.4        1.44 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.80 ±  4%      +0.4        1.25 ±  7%  perf-profile.children.cycles-pp.ret_from_fork
      0.80 ±  4%      +0.4        1.25 ±  7%  perf-profile.children.cycles-pp.kthread
      0.79 ±  5%      +0.4        1.23 ±  7%  perf-profile.children.cycles-pp.worker_thread
      0.78 ±  4%      +0.4        1.23 ±  7%  perf-profile.children.cycles-pp.drm_fb_helper_dirty_work
      0.79 ±  5%      +0.4        1.23 ±  7%  perf-profile.children.cycles-pp.process_one_work
      0.78 ±  4%      +0.4        1.23 ±  7%  perf-profile.children.cycles-pp.memcpy_erms
      0.06 ±173%      +1.0        1.02 ±116%  perf-profile.children.cycles-pp.osq_lock
      0.06 ±173%      +1.0        1.07 ±115%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.06 ±173%      +1.0        1.09 ±112%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      1.04 ±  8%      +7.3        8.34 ± 10%  perf-profile.children.cycles-pp.intel_idle
      1.21 ±  7%      +7.4        8.58 ±  9%  perf-profile.children.cycles-pp.start_secondary
      1.17 ±  7%      +7.4        8.61 ±  9%  perf-profile.children.cycles-pp.cpuidle_enter
      1.17 ±  7%      +7.4        8.61 ±  9%  perf-profile.children.cycles-pp.cpuidle_enter_state
      1.22 ±  7%      +7.5        8.70 ±  9%  perf-profile.children.cycles-pp.secondary_startup_64
      1.22 ±  7%      +7.5        8.70 ±  9%  perf-profile.children.cycles-pp.cpu_startup_entry
      1.22 ±  7%      +7.5        8.70 ±  9%  perf-profile.children.cycles-pp.do_idle
     37.48 ±  3%      -5.1       32.36 ±  2%  perf-profile.self.cycles-pp.clear_page_erms
     34.69 ±  2%      -2.2       32.45 ±  2%  perf-profile.self.cycles-pp.do_rw_once
     15.76 ±  4%      -1.0       14.78 ±  3%  perf-profile.self.cycles-pp.do_access
      1.07 ±  5%      -0.2        0.89 ±  2%  perf-profile.self.cycles-pp.___might_sleep
      1.07 ±  3%      -0.2        0.91 ±  2%  perf-profile.self.cycles-pp.clear_huge_page
      0.56 ±  2%      -0.1        0.44 ±  6%  perf-profile.self.cycles-pp.rmqueue
      0.69 ±  3%      -0.1        0.60 ±  3%  perf-profile.self.cycles-pp._cond_resched
      0.12 ±  7%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.update_load_avg
      0.10 ±  4%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.prepare_exit_to_usermode
      0.07 ±  6%      -0.0        0.05        perf-profile.self.cycles-pp.page_counter_try_charge
      0.09            -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.10 ± 11%      +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.ktime_get
      0.10 ±  5%      +0.1        0.15 ± 11%  perf-profile.self.cycles-pp.__free_pages_ok
      0.01 ±173%      +0.1        0.10 ± 17%  perf-profile.self.cycles-pp.io_serial_out
      0.25 ±  3%      +0.1        0.37 ±  8%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.40 ±  3%      +0.3        0.67 ±  7%  perf-profile.self.cycles-pp.io_serial_in
      0.77 ±  4%      +0.5        1.22 ±  7%  perf-profile.self.cycles-pp.memcpy_erms
      0.06 ±173%      +1.0        1.02 ±116%  perf-profile.self.cycles-pp.osq_lock
      1.04 ±  8%      +7.3        8.34 ± 10%  perf-profile.self.cycles-pp.intel_idle
     39227 ±  3%     -51.1%      19191 ±  2%  softirqs.CPU0.RCU
     13738 ±  5%     +43.4%      19703 ±  6%  softirqs.CPU0.SCHED
     36668 ±  4%     -50.2%      18261 ±  8%  softirqs.CPU1.RCU
     12281 ±  7%     +46.8%      18031 ±  9%  softirqs.CPU1.SCHED
     35606 ±  5%     -51.6%      17236 ±  9%  softirqs.CPU10.RCU
     12099 ±  4%     +36.4%      16498 ±  4%  softirqs.CPU10.SCHED
     34167 ±  3%     -50.7%      16828 ±  8%  softirqs.CPU100.RCU
     11294 ±  4%     +49.4%      16874 ±  9%  softirqs.CPU100.SCHED
     34521 ±  3%     -52.8%      16294 ±  9%  softirqs.CPU101.RCU
     10894 ±  7%     +56.9%      17090 ± 14%  softirqs.CPU101.SCHED
     34503 ±  4%     -51.5%      16744 ±  7%  softirqs.CPU102.RCU
     11268 ±  8%     +51.2%      17036 ± 13%  softirqs.CPU102.SCHED
     34224 ±  3%     -50.0%      17098 ±  9%  softirqs.CPU103.RCU
     11616 ±  3%     +49.1%      17324 ± 15%  softirqs.CPU103.SCHED
     35595 ±  5%     -50.7%      17535 ±  9%  softirqs.CPU11.RCU
     12003 ±  6%     +43.7%      17246 ±  7%  softirqs.CPU11.SCHED
     35592 ±  5%     -50.9%      17478 ±  9%  softirqs.CPU12.RCU
     11978 ±  8%     +44.4%      17291 ± 10%  softirqs.CPU12.SCHED
     35998 ±  4%     -50.3%      17902 ± 13%  softirqs.CPU13.RCU
     11929 ±  6%     +44.6%      17251 ± 15%  softirqs.CPU13.SCHED
     35709 ±  4%     -51.2%      17426 ±  8%  softirqs.CPU14.RCU
     11729 ±  8%     +47.2%      17263 ±  9%  softirqs.CPU14.SCHED
     36781 ±  3%     -50.5%      18219 ± 10%  softirqs.CPU15.RCU
     12002 ±  5%     +49.2%      17903 ± 13%  softirqs.CPU15.SCHED
     37007 ±  3%     -52.4%      17625 ±  8%  softirqs.CPU16.RCU
     11820 ±  7%     +40.9%      16656 ±  7%  softirqs.CPU16.SCHED
     37314 ±  3%     -52.1%      17862 ±  9%  softirqs.CPU17.RCU
     11778 ±  8%     +53.3%      18057 ± 10%  softirqs.CPU17.SCHED
     36941 ±  3%     -51.0%      18098 ±  7%  softirqs.CPU18.RCU
     11864 ± 10%     +49.8%      17773 ±  9%  softirqs.CPU18.SCHED
     36746 ±  4%     -50.6%      18158 ±  9%  softirqs.CPU19.RCU
     12175 ±  6%     +39.8%      17026 ± 15%  softirqs.CPU19.SCHED
     36794 ±  5%     -50.7%      18134 ± 10%  softirqs.CPU2.RCU
     12205 ±  5%     +42.0%      17329 ± 10%  softirqs.CPU2.SCHED
     37148 ±  4%     -51.9%      17873 ±  8%  softirqs.CPU20.RCU
     11958 ±  6%     +39.8%      16719 ± 10%  softirqs.CPU20.SCHED
     36866 ±  4%     -51.7%      17812 ±  9%  softirqs.CPU21.RCU
     11868 ±  7%     +47.2%      17467 ±  7%  softirqs.CPU21.SCHED
     37145 ±  3%     -52.0%      17815 ±  9%  softirqs.CPU22.RCU
     11998 ±  6%     +45.1%      17411 ± 12%  softirqs.CPU22.SCHED
     37098 ±  2%     -52.2%      17725 ±  9%  softirqs.CPU23.RCU
     11968 ±  5%     +46.2%      17492 ± 11%  softirqs.CPU23.SCHED
     37384 ±  4%     -53.0%      17552 ±  8%  softirqs.CPU24.RCU
     12034 ±  5%     +50.5%      18115 ± 10%  softirqs.CPU24.SCHED
     37017 ±  4%     -51.9%      17796 ±  9%  softirqs.CPU25.RCU
     12047 ±  5%     +39.3%      16782 ±  8%  softirqs.CPU25.SCHED
     33985 ±  8%     -53.9%      15655 ±  9%  softirqs.CPU26.RCU
     12177 ±  8%     +44.6%      17610 ±  5%  softirqs.CPU26.SCHED
     32818 ±  2%     -49.4%      16610 ± 15%  softirqs.CPU27.RCU
     11954 ±  5%     +41.4%      16901 ± 13%  softirqs.CPU27.SCHED
     32299 ±  3%     -51.5%      15655 ±  6%  softirqs.CPU28.RCU
     11815 ±  2%     +41.1%      16674 ±  6%  softirqs.CPU28.SCHED
     32897           -52.4%      15668 ±  7%  softirqs.CPU29.RCU
     11284           +32.9%      15002 ±  4%  softirqs.CPU29.SCHED
     36752 ±  5%     -51.4%      17857 ±  9%  softirqs.CPU3.RCU
     12000 ±  7%     +37.8%      16533 ±  9%  softirqs.CPU3.SCHED
     35961 ±  3%     -49.2%      18284 ± 10%  softirqs.CPU30.RCU
     12131 ± 10%     +39.8%      16961 ±  7%  softirqs.CPU30.SCHED
     35619 ±  3%     -48.1%      18482 ±  7%  softirqs.CPU31.RCU
     11580 ±  2%     +57.8%      18278 ± 20%  softirqs.CPU31.SCHED
    196.50 ± 21%   +4220.9%       8490 ±123%  softirqs.CPU32.NET_RX
     36027 ±  3%     -49.4%      18245 ±  5%  softirqs.CPU32.RCU
     11683           +44.3%      16855 ± 14%  softirqs.CPU32.SCHED
     35767 ±  3%     -50.6%      17651 ±  8%  softirqs.CPU33.RCU
     12103 ±  3%     +34.6%      16291 ±  6%  softirqs.CPU33.SCHED
     35444 ±  4%     -50.6%      17508 ±  8%  softirqs.CPU34.RCU
     11685           +41.4%      16527 ±  7%  softirqs.CPU34.SCHED
     35593 ±  3%     -50.0%      17794 ±  7%  softirqs.CPU35.RCU
     11408 ±  4%     +49.3%      17029 ± 12%  softirqs.CPU35.SCHED
     35583 ±  2%     -50.4%      17645 ±  8%  softirqs.CPU36.RCU
     11734 ±  5%     +47.8%      17348 ± 14%  softirqs.CPU36.SCHED
     35440 ±  3%     -49.9%      17744 ±  8%  softirqs.CPU37.RCU
     11223 ±  3%     +51.6%      17012 ± 11%  softirqs.CPU37.SCHED
     35564 ±  3%     -49.4%      18007 ± 10%  softirqs.CPU38.RCU
     11687 ±  3%     +47.0%      17178 ± 14%  softirqs.CPU38.SCHED
     34580 ±  6%     -49.6%      17437 ±  7%  softirqs.CPU39.RCU
     11539           +44.0%      16620 ±  8%  softirqs.CPU39.SCHED
     36070 ±  5%     -50.8%      17749 ±  9%  softirqs.CPU4.RCU
     11876 ±  6%     +52.9%      18159 ± 11%  softirqs.CPU4.SCHED
     35037 ±  4%     -50.0%      17520 ±  8%  softirqs.CPU40.RCU
     11258 ±  3%     +51.9%      17106 ± 12%  softirqs.CPU40.SCHED
     35834 ±  4%     -51.3%      17444 ±  9%  softirqs.CPU41.RCU
     11722 ±  2%     +36.2%      15968 ±  5%  softirqs.CPU41.SCHED
     35410 ±  3%     -50.0%      17722 ±  8%  softirqs.CPU42.RCU
     11372 ±  2%     +41.8%      16124 ±  4%  softirqs.CPU42.SCHED
     33792 ±  6%     -47.2%      17856 ±  9%  softirqs.CPU43.RCU
     12027           +42.3%      17112 ± 12%  softirqs.CPU43.SCHED
     36039 ±  4%     -50.4%      17888 ±  9%  softirqs.CPU44.RCU
     11549 ±  3%     +39.6%      16121 ±  7%  softirqs.CPU44.SCHED
     34809 ±  4%     -51.5%      16880 ±  9%  softirqs.CPU45.RCU
     11669 ±  2%     +42.8%      16669 ±  8%  softirqs.CPU45.SCHED
     34511 ±  4%     -51.8%      16626 ±  9%  softirqs.CPU46.RCU
     11311 ±  3%     +49.4%      16901 ± 14%  softirqs.CPU46.SCHED
     34270 ±  3%     -50.6%      16913 ±  7%  softirqs.CPU47.RCU
     10710 ±  9%     +55.8%      16684 ± 10%  softirqs.CPU47.SCHED
     34114 ±  3%     -51.3%      16615 ±  8%  softirqs.CPU48.RCU
     11141 ±  3%     +51.2%      16843 ±  9%  softirqs.CPU48.SCHED
     34470 ±  3%     -53.0%      16211 ±  8%  softirqs.CPU49.RCU
     11108 ±  3%     +51.6%      16844 ±  9%  softirqs.CPU49.SCHED
     35577 ±  5%     -50.0%      17775 ±  8%  softirqs.CPU5.RCU
     11904 ±  6%     +39.1%      16560 ±  5%  softirqs.CPU5.SCHED
     34402 ±  4%     -50.8%      16939 ±  9%  softirqs.CPU50.RCU
     11404           +49.2%      17011 ± 11%  softirqs.CPU50.SCHED
     34352 ±  3%     -50.9%      16850 ±  9%  softirqs.CPU51.RCU
     11032 ±  3%     +53.3%      16915 ±  9%  softirqs.CPU51.SCHED
     35684 ±  3%     -49.4%      18067 ± 16%  softirqs.CPU52.RCU
     11165 ±  9%     +57.3%      17566 ± 11%  softirqs.CPU52.SCHED
     36218 ±  3%     -51.7%      17505 ± 11%  softirqs.CPU53.RCU
     11749 ±  6%     +48.6%      17458 ± 11%  softirqs.CPU53.SCHED
     36922 ±  4%     -52.9%      17392 ± 10%  softirqs.CPU54.RCU
     12183 ±  7%     +38.3%      16852 ±  6%  softirqs.CPU54.SCHED
     36680 ±  4%     -51.8%      17694 ± 10%  softirqs.CPU55.RCU
     11480 ± 13%     +48.3%      17028 ± 14%  softirqs.CPU55.SCHED
     36393 ±  3%     -52.4%      17329 ±  9%  softirqs.CPU56.RCU
     11875 ±  9%     +45.6%      17295 ±  8%  softirqs.CPU56.SCHED
     36292 ±  3%     -51.5%      17608 ±  8%  softirqs.CPU57.RCU
     11865 ±  7%     +38.6%      16446 ±  9%  softirqs.CPU57.SCHED
     36323 ±  3%     -51.7%      17551 ±  8%  softirqs.CPU58.RCU
     12063 ±  5%     +43.3%      17283 ± 12%  softirqs.CPU58.SCHED
     35731 ±  3%     -51.9%      17195 ±  8%  softirqs.CPU59.RCU
     11533 ±  9%     +39.5%      16085 ±  9%  softirqs.CPU59.SCHED
     35813 ±  6%     -50.1%      17873 ±  9%  softirqs.CPU6.RCU
     12499 ±  7%     +32.6%      16576 ±  5%  softirqs.CPU6.SCHED
     36012 ±  5%     -51.2%      17570 ±  9%  softirqs.CPU60.RCU
     11872 ±  7%     +49.1%      17700 ± 11%  softirqs.CPU60.SCHED
     35774 ±  5%     -51.0%      17525 ±  8%  softirqs.CPU61.RCU
     11789 ± 10%     +46.1%      17221 ±  8%  softirqs.CPU61.SCHED
     37150 ±  9%     -52.2%      17752 ±  5%  softirqs.CPU62.RCU
     12245 ±  6%     +42.9%      17498 ±  9%  softirqs.CPU62.SCHED
     35690 ±  5%     -49.8%      17901 ± 10%  softirqs.CPU63.RCU
     11659 ±  6%     +45.9%      17007 ±  8%  softirqs.CPU63.SCHED
     35822 ±  5%     -49.9%      17952 ± 10%  softirqs.CPU64.RCU
     11675 ± 10%     +39.4%      16271 ±  8%  softirqs.CPU64.SCHED
     35664 ±  5%     -51.9%      17146 ± 13%  softirqs.CPU65.RCU
     11942 ±  4%     +46.0%      17441 ± 11%  softirqs.CPU65.SCHED
     35869 ±  5%     -50.8%      17631 ± 10%  softirqs.CPU66.RCU
     11788 ±  9%     +37.1%      16166 ± 11%  softirqs.CPU66.SCHED
     35752 ±  5%     -48.5%      18400 ±  6%  softirqs.CPU67.RCU
     11832 ±  5%     +30.7%      15465 ± 14%  softirqs.CPU67.SCHED
     35874 ±  5%     -51.3%      17482 ±  8%  softirqs.CPU68.RCU
     11849 ±  7%     +50.9%      17878 ± 12%  softirqs.CPU68.SCHED
     35797 ±  5%     -50.7%      17630 ± 10%  softirqs.CPU69.RCU
     12010 ±  7%     +45.1%      17429 ±  9%  softirqs.CPU69.SCHED
     35884 ±  7%     -50.5%      17756 ±  9%  softirqs.CPU7.RCU
     12198 ±  3%     +36.3%      16625 ±  8%  softirqs.CPU7.SCHED
     35478 ±  5%     -50.9%      17414 ± 10%  softirqs.CPU70.RCU
     11914 ±  6%     +45.7%      17361 ± 12%  softirqs.CPU70.SCHED
     35000 ±  5%     -50.7%      17241 ±  9%  softirqs.CPU71.RCU
     11654 ±  7%     +50.8%      17570 ± 10%  softirqs.CPU71.SCHED
     35540 ±  5%     -50.8%      17484 ± 10%  softirqs.CPU72.RCU
     11494 ± 12%     +52.2%      17495 ± 11%  softirqs.CPU72.SCHED
     35555 ±  6%     -51.3%      17302 ±  9%  softirqs.CPU73.RCU
     11638 ±  7%     +44.0%      16763 ±  7%  softirqs.CPU73.SCHED
     36066 ±  5%     -51.6%      17463 ± 10%  softirqs.CPU74.RCU
     11875 ±  6%     +51.8%      18030 ±  9%  softirqs.CPU74.SCHED
     32220           -51.9%      15495 ±  9%  softirqs.CPU75.RCU
     11872 ±  7%     +46.7%      17414 ±  8%  softirqs.CPU75.SCHED
     32127           -53.2%      15032 ±  9%  softirqs.CPU76.RCU
     11818 ±  6%     +48.7%      17568 ±  6%  softirqs.CPU76.SCHED
     32399           -53.4%      15091 ±  9%  softirqs.CPU77.RCU
     11919 ±  6%     +42.1%      16941 ± 10%  softirqs.CPU77.SCHED
     36650 ±  5%     -51.5%      17761 ±  7%  softirqs.CPU78.RCU
     11474 ±  3%     +46.0%      16747 ±  7%  softirqs.CPU78.SCHED
     36130 ±  5%     -50.7%      17798 ±  9%  softirqs.CPU79.RCU
     11307 ±  5%     +50.8%      17046 ± 12%  softirqs.CPU79.SCHED
     35939 ±  5%     -51.2%      17537 ±  9%  softirqs.CPU8.RCU
     11966 ±  5%     +44.2%      17258 ±  9%  softirqs.CPU8.SCHED
     36917 ±  4%     -51.1%      18050 ±  9%  softirqs.CPU80.RCU
     11329 ±  4%     +48.7%      16845 ±  9%  softirqs.CPU80.SCHED
     36402 ±  4%     -51.0%      17820 ±  8%  softirqs.CPU81.RCU
     10966 ±  3%     +54.3%      16923 ± 11%  softirqs.CPU81.SCHED
     36364 ±  4%     -51.5%      17622 ±  8%  softirqs.CPU82.RCU
     11781 ± 11%     +38.8%      16350 ±  5%  softirqs.CPU82.SCHED
     36145 ±  3%     -51.6%      17510 ±  8%  softirqs.CPU83.RCU
     11730           +41.6%      16605 ± 12%  softirqs.CPU83.SCHED
     36770 ±  3%     -53.3%      17168 ±  8%  softirqs.CPU84.RCU
     11123 ±  4%     +35.6%      15081 ±  9%  softirqs.CPU84.SCHED
     36253 ±  4%     -51.3%      17637 ±  8%  softirqs.CPU85.RCU
     11699 ±  2%     +42.3%      16642 ± 11%  softirqs.CPU85.SCHED
     36639 ±  5%     -52.2%      17529 ±  9%  softirqs.CPU86.RCU
     11708 ±  3%     +42.9%      16734 ± 10%  softirqs.CPU86.SCHED
     36173 ±  4%     -51.6%      17497 ±  8%  softirqs.CPU87.RCU
     11109 ±  3%     +52.3%      16916 ± 12%  softirqs.CPU87.SCHED
     36310 ±  6%     -48.9%      18547 ± 13%  softirqs.CPU88.RCU
     11397 ±  3%     +50.2%      17120 ± 13%  softirqs.CPU88.SCHED
     36144 ±  4%     -51.6%      17480 ±  8%  softirqs.CPU89.RCU
     10892 ±  4%     +52.1%      16570 ±  5%  softirqs.CPU89.SCHED
     35787 ±  5%     -51.3%      17438 ±  9%  softirqs.CPU9.RCU
     11873 ±  6%     +38.4%      16436 ±  6%  softirqs.CPU9.SCHED
     34586 ±  3%     -51.0%      16953 ±  8%  softirqs.CPU90.RCU
     11694 ±  3%     +44.4%      16886 ± 11%  softirqs.CPU90.SCHED
     33764 ±  7%     -49.8%      16954 ±  8%  softirqs.CPU91.RCU
     11530 ±  4%     +39.1%      16036 ±  9%  softirqs.CPU91.SCHED
     34534 ±  4%     -50.8%      16978 ±  8%  softirqs.CPU92.RCU
     11508 ±  2%     +46.2%      16828 ± 12%  softirqs.CPU92.SCHED
     34811 ±  4%     -51.4%      16925 ±  8%  softirqs.CPU93.RCU
     11510 ±  4%     +47.0%      16925 ± 11%  softirqs.CPU93.SCHED
     35079 ±  5%     -51.0%      17196 ± 10%  softirqs.CPU94.RCU
     11124 ±  6%     +55.7%      17316 ± 12%  softirqs.CPU94.SCHED
     33354 ±  5%     -48.1%      17313 ±  6%  softirqs.CPU95.RCU
     11697 ±  3%     +40.2%      16394 ±  9%  softirqs.CPU95.SCHED
     34858 ±  3%     -50.8%      17146 ±  8%  softirqs.CPU96.RCU
     11062 ±  4%     +47.6%      16333 ± 16%  softirqs.CPU96.SCHED
     34951 ±  5%     -51.1%      17098 ±  8%  softirqs.CPU97.RCU
     11490 ±  6%     +45.8%      16749 ±  9%  softirqs.CPU97.SCHED
     34851 ±  4%     -49.4%      17640 ±  8%  softirqs.CPU98.RCU
     11637 ±  2%     +47.3%      17146 ± 13%  softirqs.CPU98.SCHED
     34497 ±  3%     -50.2%      17183 ±  8%  softirqs.CPU99.RCU
     11354 ±  3%     +51.5%      17202 ± 12%  softirqs.CPU99.SCHED
   3698768 ±  4%     -51.0%    1812217 ±  8%  softirqs.RCU
   1217108 ±  3%     +45.2%    1767755 ±  2%  softirqs.SCHED
    306.25 ± 28%   +5353.0%      16699 ±125%  interrupts.40:PCI-MSI.67633155-edge.eth0-TxRx-2
      2375 ± 49%     -67.6%     770.75 ±111%  interrupts.41:PCI-MSI.67633156-edge.eth0-TxRx-3
   2596291           -29.7%    1824254 ±  3%  interrupts.CAL:Function_call_interrupts
     26901 ±  6%     -39.0%      16422 ±  8%  interrupts.CPU0.CAL:Function_call_interrupts
      5955 ±  3%     -30.2%       4158 ± 28%  interrupts.CPU0.NMI:Non-maskable_interrupts
      5955 ±  3%     -30.2%       4158 ± 28%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
     25934 ±  7%     -40.3%      15480 ±  8%  interrupts.CPU0.TLB:TLB_shootdowns
     26458 ±  8%     -36.4%      16839 ±  7%  interrupts.CPU1.CAL:Function_call_interrupts
      5972 ±  3%     -23.4%       4577 ± 16%  interrupts.CPU1.NMI:Non-maskable_interrupts
      5972 ±  3%     -23.4%       4577 ± 16%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
     26095 ± 10%     -36.2%      16659 ±  7%  interrupts.CPU1.TLB:TLB_shootdowns
     26356 ±  5%     -35.1%      17107 ±  3%  interrupts.CPU10.CAL:Function_call_interrupts
     25802 ±  7%     -35.2%      16726 ±  2%  interrupts.CPU10.TLB:TLB_shootdowns
     23846 ± 10%     -21.0%      18838 ±  6%  interrupts.CPU100.CAL:Function_call_interrupts
     22672 ± 14%     -20.4%      18044 ±  6%  interrupts.CPU100.TLB:TLB_shootdowns
     23478 ±  8%     -22.1%      18299 ±  7%  interrupts.CPU101.CAL:Function_call_interrupts
     22711 ± 10%     -20.8%      17988 ±  7%  interrupts.CPU101.TLB:TLB_shootdowns
     23877 ± 10%     -23.6%      18243 ±  6%  interrupts.CPU102.CAL:Function_call_interrupts
     22739 ± 12%     -21.0%      17973 ±  7%  interrupts.CPU102.TLB:TLB_shootdowns
     23793 ± 10%     -24.9%      17877 ± 13%  interrupts.CPU103.CAL:Function_call_interrupts
     22947 ± 13%     -22.7%      17727 ± 13%  interrupts.CPU103.TLB:TLB_shootdowns
     26231 ±  6%     -33.0%      17569 ±  4%  interrupts.CPU11.CAL:Function_call_interrupts
      6037 ±  2%     -26.5%       4434 ± 27%  interrupts.CPU11.NMI:Non-maskable_interrupts
      6037 ±  2%     -26.5%       4434 ± 27%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
     25881 ±  8%     -32.8%      17387 ±  3%  interrupts.CPU11.TLB:TLB_shootdowns
     25992 ±  7%     -33.1%      17400        interrupts.CPU12.CAL:Function_call_interrupts
      6043           -21.0%       4773 ± 10%  interrupts.CPU12.NMI:Non-maskable_interrupts
      6043           -21.0%       4773 ± 10%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
     25944 ±  8%     -34.3%      17046        interrupts.CPU12.TLB:TLB_shootdowns
     26058 ±  7%     -32.8%      17505 ±  2%  interrupts.CPU13.CAL:Function_call_interrupts
      5913 ±  2%     -14.6%       5048 ±  7%  interrupts.CPU13.NMI:Non-maskable_interrupts
      5913 ±  2%     -14.6%       5048 ±  7%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
     25920 ±  8%     -34.4%      17012        interrupts.CPU13.TLB:TLB_shootdowns
     26093 ±  6%     -35.7%      16769 ±  2%  interrupts.CPU14.CAL:Function_call_interrupts
     25667 ±  9%     -35.4%      16576 ±  2%  interrupts.CPU14.TLB:TLB_shootdowns
     25946 ±  7%     -36.3%      16538 ±  3%  interrupts.CPU15.CAL:Function_call_interrupts
     25661 ±  8%     -36.2%      16380 ±  3%  interrupts.CPU15.TLB:TLB_shootdowns
     26417 ±  7%     -31.4%      18115 ±  6%  interrupts.CPU16.CAL:Function_call_interrupts
      5917 ±  2%     -27.5%       4287 ± 31%  interrupts.CPU16.NMI:Non-maskable_interrupts
      5917 ±  2%     -27.5%       4287 ± 31%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
     26211 ±  8%     -33.4%      17457 ±  6%  interrupts.CPU16.TLB:TLB_shootdowns
     26115 ±  7%     -35.0%      16980 ±  2%  interrupts.CPU17.CAL:Function_call_interrupts
     25888 ±  8%     -34.7%      16892 ±  2%  interrupts.CPU17.TLB:TLB_shootdowns
     26065 ±  5%     -36.7%      16489 ±  4%  interrupts.CPU18.CAL:Function_call_interrupts
     25810 ±  8%     -37.0%      16253 ±  4%  interrupts.CPU18.TLB:TLB_shootdowns
     26518 ±  8%     -35.8%      17017 ±  3%  interrupts.CPU19.CAL:Function_call_interrupts
     25993 ±  9%     -34.8%      16946 ±  2%  interrupts.CPU19.TLB:TLB_shootdowns
     26301 ±  8%     -34.6%      17209 ±  3%  interrupts.CPU2.CAL:Function_call_interrupts
     26073 ±  9%     -36.0%      16688 ±  3%  interrupts.CPU2.TLB:TLB_shootdowns
     26826 ±  7%     -35.7%      17254 ±  4%  interrupts.CPU20.CAL:Function_call_interrupts
     26443 ±  8%     -35.6%      17031 ±  3%  interrupts.CPU20.TLB:TLB_shootdowns
     26404 ±  4%     -34.9%      17184 ±  2%  interrupts.CPU21.CAL:Function_call_interrupts
     26155 ±  5%     -36.5%      16621 ±  3%  interrupts.CPU21.TLB:TLB_shootdowns
     26577 ±  4%     -34.8%      17339 ±  4%  interrupts.CPU22.CAL:Function_call_interrupts
     26035 ±  7%     -34.6%      17018 ±  5%  interrupts.CPU22.TLB:TLB_shootdowns
     26559 ±  5%     -34.1%      17502 ±  3%  interrupts.CPU23.CAL:Function_call_interrupts
     26098 ±  7%     -34.8%      17004 ±  2%  interrupts.CPU23.TLB:TLB_shootdowns
     26327 ±  9%     -36.0%      16844 ±  3%  interrupts.CPU24.CAL:Function_call_interrupts
     26090 ±  9%     -36.6%      16540 ±  4%  interrupts.CPU24.TLB:TLB_shootdowns
     26421 ±  9%     -27.6%      19128 ± 18%  interrupts.CPU25.CAL:Function_call_interrupts
      5927 ±  3%     -14.3%       5080 ± 11%  interrupts.CPU25.NMI:Non-maskable_interrupts
      5927 ±  3%     -14.3%       5080 ± 11%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
     26211 ± 10%     -35.7%      16855 ±  4%  interrupts.CPU25.TLB:TLB_shootdowns
     23299 ± 11%     -27.4%      16911 ±  7%  interrupts.CPU26.CAL:Function_call_interrupts
      2697 ± 82%     -82.8%     464.75 ± 36%  interrupts.CPU26.RES:Rescheduling_interrupts
     22275 ± 14%     -24.9%      16730 ±  7%  interrupts.CPU26.TLB:TLB_shootdowns
     23123 ± 12%     -25.3%      17283 ±  7%  interrupts.CPU27.CAL:Function_call_interrupts
      6348 ±  5%     -20.8%       5026 ± 25%  interrupts.CPU27.NMI:Non-maskable_interrupts
      6348 ±  5%     -20.8%       5026 ± 25%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
     22433 ± 15%     -24.2%      17010 ±  7%  interrupts.CPU27.TLB:TLB_shootdowns
     24043 ±  9%     -27.1%      17523 ±  3%  interrupts.CPU28.CAL:Function_call_interrupts
     22944 ± 11%     -26.1%      16960 ±  5%  interrupts.CPU28.TLB:TLB_shootdowns
     23364 ± 11%     -22.8%      18033 ±  4%  interrupts.CPU29.CAL:Function_call_interrupts
     22756 ± 13%     -24.0%      17295 ±  8%  interrupts.CPU29.TLB:TLB_shootdowns
     26600 ±  4%     -32.6%      17917 ±  2%  interrupts.CPU3.CAL:Function_call_interrupts
      5947           -14.3%       5096 ± 10%  interrupts.CPU3.NMI:Non-maskable_interrupts
      5947           -14.3%       5096 ± 10%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
     25848 ±  8%     -32.1%      17562 ±  2%  interrupts.CPU3.TLB:TLB_shootdowns
     23584 ± 10%     -23.4%      18065 ± 10%  interrupts.CPU30.CAL:Function_call_interrupts
      1233 ± 17%     -67.5%     400.25 ± 28%  interrupts.CPU30.RES:Rescheduling_interrupts
     22441 ± 12%     -21.1%      17703 ± 10%  interrupts.CPU30.TLB:TLB_shootdowns
     23389 ± 11%     -25.3%      17470 ±  9%  interrupts.CPU31.CAL:Function_call_interrupts
     22711 ± 12%     -25.4%      16942 ± 11%  interrupts.CPU31.TLB:TLB_shootdowns
    306.25 ± 28%   +5353.0%      16699 ±125%  interrupts.CPU32.40:PCI-MSI.67633155-edge.eth0-TxRx-2
     23232 ± 12%     -23.8%      17708 ±  9%  interrupts.CPU32.CAL:Function_call_interrupts
     22664 ± 14%     -23.1%      17424 ±  9%  interrupts.CPU32.TLB:TLB_shootdowns
      2375 ± 49%     -67.6%     770.75 ±111%  interrupts.CPU33.41:PCI-MSI.67633156-edge.eth0-TxRx-3
     23097 ± 10%     -23.5%      17661 ±  7%  interrupts.CPU33.CAL:Function_call_interrupts
    995.75 ± 41%     -62.5%     373.00 ± 19%  interrupts.CPU33.RES:Rescheduling_interrupts
     22364 ± 12%     -22.5%      17337 ±  7%  interrupts.CPU33.TLB:TLB_shootdowns
     23038 ± 10%     -23.5%      17632 ±  5%  interrupts.CPU34.CAL:Function_call_interrupts
    970.75 ± 45%     -65.4%     335.75 ±  6%  interrupts.CPU34.RES:Rescheduling_interrupts
     22573 ± 12%     -22.7%      17447 ±  7%  interrupts.CPU34.TLB:TLB_shootdowns
     23540 ±  9%     -24.7%      17735 ±  5%  interrupts.CPU35.CAL:Function_call_interrupts
     22564 ± 13%     -23.5%      17271 ±  7%  interrupts.CPU35.TLB:TLB_shootdowns
     24107 ± 11%     -28.4%      17267 ±  9%  interrupts.CPU36.CAL:Function_call_interrupts
     22590 ± 14%     -25.6%      16813 ± 11%  interrupts.CPU36.TLB:TLB_shootdowns
     23441 ± 10%     -25.3%      17502 ± 11%  interrupts.CPU37.CAL:Function_call_interrupts
      1031 ± 38%     -62.4%     387.75 ± 17%  interrupts.CPU37.RES:Rescheduling_interrupts
     22388 ± 12%     -25.4%      16705 ±  9%  interrupts.CPU37.TLB:TLB_shootdowns
     23398 ± 12%     -24.9%      17570 ± 12%  interrupts.CPU38.CAL:Function_call_interrupts
      6360 ±  5%     -30.4%       4426 ± 32%  interrupts.CPU38.NMI:Non-maskable_interrupts
      6360 ±  5%     -30.4%       4426 ± 32%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
     22726 ± 14%     -23.9%      17299 ± 12%  interrupts.CPU38.TLB:TLB_shootdowns
     23463 ± 10%     -24.1%      17817 ±  7%  interrupts.CPU39.CAL:Function_call_interrupts
     22600 ± 13%     -23.1%      17374 ±  7%  interrupts.CPU39.TLB:TLB_shootdowns
     27479 ± 13%     -36.8%      17366 ±  4%  interrupts.CPU4.CAL:Function_call_interrupts
      5893 ±  2%     -14.7%       5026 ± 10%  interrupts.CPU4.NMI:Non-maskable_interrupts
      5893 ±  2%     -14.7%       5026 ± 10%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
     25961 ±  7%     -34.9%      16888 ±  4%  interrupts.CPU4.TLB:TLB_shootdowns
     23574 ± 11%     -22.6%      18258 ±  3%  interrupts.CPU40.CAL:Function_call_interrupts
     22510 ± 13%     -21.9%      17588 ±  5%  interrupts.CPU40.TLB:TLB_shootdowns
     22991 ± 10%     -25.0%      17237 ±  7%  interrupts.CPU41.CAL:Function_call_interrupts
      1157 ± 36%     -66.5%     388.25 ± 16%  interrupts.CPU41.RES:Rescheduling_interrupts
     22090 ± 12%     -22.7%      17081 ±  6%  interrupts.CPU41.TLB:TLB_shootdowns
     22484 ± 11%     -22.9%      17338 ±  8%  interrupts.CPU42.CAL:Function_call_interrupts
     21831 ± 14%     -21.5%      17134 ±  9%  interrupts.CPU42.TLB:TLB_shootdowns
     23758 ± 11%     -26.4%      17475 ±  6%  interrupts.CPU43.CAL:Function_call_interrupts
     22690 ± 14%     -24.4%      17154 ±  7%  interrupts.CPU43.TLB:TLB_shootdowns
     23177 ± 11%     -24.9%      17402 ±  7%  interrupts.CPU44.CAL:Function_call_interrupts
     22680 ± 12%     -23.9%      17253 ±  6%  interrupts.CPU44.TLB:TLB_shootdowns
      6303 ±  4%     -28.5%       4506 ± 29%  interrupts.CPU45.NMI:Non-maskable_interrupts
      6303 ±  4%     -28.5%       4506 ± 29%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
     22021 ± 13%     -20.8%      17439 ±  6%  interrupts.CPU45.TLB:TLB_shootdowns
     22933 ±  9%     -17.5%      18928 ±  6%  interrupts.CPU46.CAL:Function_call_interrupts
     22048 ± 12%     -21.2%      17376 ±  6%  interrupts.CPU46.TLB:TLB_shootdowns
     23696 ± 11%     -24.2%      17972 ±  7%  interrupts.CPU47.CAL:Function_call_interrupts
    822.75 ± 35%     -55.9%     362.75 ± 13%  interrupts.CPU47.RES:Rescheduling_interrupts
     22394 ± 14%     -21.3%      17633 ±  6%  interrupts.CPU47.TLB:TLB_shootdowns
     24278 ± 10%     -29.7%      17073 ±  9%  interrupts.CPU48.CAL:Function_call_interrupts
     22670 ± 14%     -25.4%      16919 ±  8%  interrupts.CPU48.TLB:TLB_shootdowns
     23744 ±  8%     -23.5%      18171 ± 11%  interrupts.CPU49.CAL:Function_call_interrupts
     22246 ± 12%     -21.7%      17409 ±  8%  interrupts.CPU49.TLB:TLB_shootdowns
     26402 ±  4%     -35.5%      17034 ±  7%  interrupts.CPU5.CAL:Function_call_interrupts
     26131 ±  6%     -36.0%      16737 ±  6%  interrupts.CPU5.TLB:TLB_shootdowns
     22794 ± 10%     -21.8%      17815 ± 11%  interrupts.CPU50.CAL:Function_call_interrupts
    776.00 ± 37%     -56.5%     337.50 ± 15%  interrupts.CPU50.RES:Rescheduling_interrupts
     22030 ± 12%     -20.8%      17437 ± 10%  interrupts.CPU50.TLB:TLB_shootdowns
     24195 ±  9%     -24.2%      18332 ± 10%  interrupts.CPU51.CAL:Function_call_interrupts
      6343 ±  5%     -24.2%       4808 ± 24%  interrupts.CPU51.NMI:Non-maskable_interrupts
      6343 ±  5%     -24.2%       4808 ± 24%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
     22848 ± 13%     -23.3%      17513 ± 10%  interrupts.CPU51.TLB:TLB_shootdowns
     26296 ±  7%     -33.6%      17448        interrupts.CPU52.CAL:Function_call_interrupts
     25791 ± 10%     -35.0%      16771 ±  2%  interrupts.CPU52.TLB:TLB_shootdowns
     26438 ±  8%     -33.8%      17500 ±  4%  interrupts.CPU53.CAL:Function_call_interrupts
     26174 ± 10%     -33.5%      17415 ±  3%  interrupts.CPU53.TLB:TLB_shootdowns
     29497 ± 13%     -39.8%      17755 ±  2%  interrupts.CPU54.CAL:Function_call_interrupts
     26240 ±  9%     -34.1%      17300 ±  2%  interrupts.CPU54.TLB:TLB_shootdowns
     26667 ±  8%     -34.0%      17610 ±  2%  interrupts.CPU55.CAL:Function_call_interrupts
     26081 ±  8%     -34.1%      17184 ±  4%  interrupts.CPU55.TLB:TLB_shootdowns
     26006 ±  8%     -32.1%      17666 ±  2%  interrupts.CPU56.CAL:Function_call_interrupts
     25725 ±  9%     -33.6%      17070 ±  4%  interrupts.CPU56.TLB:TLB_shootdowns
     26790 ±  8%     -34.8%      17473 ±  4%  interrupts.CPU57.CAL:Function_call_interrupts
     26170 ±  7%     -34.6%      17123 ±  4%  interrupts.CPU57.TLB:TLB_shootdowns
     26756 ±  7%     -36.0%      17111 ±  4%  interrupts.CPU58.CAL:Function_call_interrupts
     26253 ±  8%     -35.4%      16972 ±  5%  interrupts.CPU58.TLB:TLB_shootdowns
     26404 ±  8%     -35.7%      16988 ±  4%  interrupts.CPU59.CAL:Function_call_interrupts
     26408 ±  7%     -36.4%      16783 ±  4%  interrupts.CPU59.TLB:TLB_shootdowns
     26344 ±  6%     -35.1%      17093 ±  3%  interrupts.CPU6.CAL:Function_call_interrupts
     26550 ±  7%     -36.1%      16952 ±  3%  interrupts.CPU6.TLB:TLB_shootdowns
     25912 ± 10%     -33.6%      17206        interrupts.CPU60.CAL:Function_call_interrupts
      5972 ±  2%     -28.8%       4254 ± 31%  interrupts.CPU60.NMI:Non-maskable_interrupts
      5972 ±  2%     -28.8%       4254 ± 31%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
     25837 ± 10%     -34.4%      16960 ±  2%  interrupts.CPU60.TLB:TLB_shootdowns
     26427 ±  9%     -34.7%      17251 ±  2%  interrupts.CPU61.CAL:Function_call_interrupts
     25174 ±  9%     -32.2%      17060 ±  3%  interrupts.CPU61.TLB:TLB_shootdowns
     25979 ±  8%     -32.1%      17646 ±  4%  interrupts.CPU62.CAL:Function_call_interrupts
      5874 ±  3%     -21.4%       4616 ± 29%  interrupts.CPU62.NMI:Non-maskable_interrupts
      5874 ±  3%     -21.4%       4616 ± 29%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
     25625 ±  9%     -32.0%      17420 ±  3%  interrupts.CPU62.TLB:TLB_shootdowns
     27245 ± 12%     -37.1%      17126 ±  6%  interrupts.CPU63.CAL:Function_call_interrupts
     26270 ± 10%     -36.9%      16572 ±  3%  interrupts.CPU63.TLB:TLB_shootdowns
     25949 ±  7%     -33.7%      17217 ±  4%  interrupts.CPU64.CAL:Function_call_interrupts
     25662 ±  9%     -33.8%      16979 ±  5%  interrupts.CPU64.TLB:TLB_shootdowns
     25744 ±  7%     -33.1%      17231 ±  3%  interrupts.CPU65.CAL:Function_call_interrupts
     25550 ±  8%     -33.3%      17030 ±  3%  interrupts.CPU65.TLB:TLB_shootdowns
     26475 ±  6%     -37.0%      16678 ±  2%  interrupts.CPU66.CAL:Function_call_interrupts
     26068 ±  7%     -36.9%      16460 ±  3%  interrupts.CPU66.TLB:TLB_shootdowns
     25969 ±  7%     -32.7%      17478 ±  3%  interrupts.CPU67.CAL:Function_call_interrupts
     25690 ±  9%     -32.7%      17291 ±  3%  interrupts.CPU67.TLB:TLB_shootdowns
     26047 ±  5%     -37.0%      16413 ±  4%  interrupts.CPU68.CAL:Function_call_interrupts
     25715 ±  6%     -36.9%      16215 ±  4%  interrupts.CPU68.TLB:TLB_shootdowns
     26268 ±  8%     -32.4%      17766 ±  3%  interrupts.CPU69.CAL:Function_call_interrupts
     25924 ±  8%     -32.8%      17414 ±  3%  interrupts.CPU69.TLB:TLB_shootdowns
     26458 ±  7%     -36.7%      16745 ±  3%  interrupts.CPU7.CAL:Function_call_interrupts
      5912 ±  2%     -24.9%       4440 ± 23%  interrupts.CPU7.NMI:Non-maskable_interrupts
      5912 ±  2%     -24.9%       4440 ± 23%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
     26221 ±  8%     -37.5%      16389 ±  3%  interrupts.CPU7.TLB:TLB_shootdowns
     26454 ±  8%     -33.9%      17491 ±  4%  interrupts.CPU70.CAL:Function_call_interrupts
      5936 ±  2%     -30.6%       4118 ± 26%  interrupts.CPU70.NMI:Non-maskable_interrupts
      5936 ±  2%     -30.6%       4118 ± 26%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
     25870 ±  8%     -34.5%      16941 ±  4%  interrupts.CPU70.TLB:TLB_shootdowns
     26897 ± 12%     -34.6%      17595 ±  2%  interrupts.CPU71.CAL:Function_call_interrupts
      5897 ±  2%     -27.3%       4289 ± 20%  interrupts.CPU71.NMI:Non-maskable_interrupts
      5897 ±  2%     -27.3%       4289 ± 20%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
     26199 ± 10%     -35.6%      16875 ±  2%  interrupts.CPU71.TLB:TLB_shootdowns
     28652 ± 17%     -41.6%      16739 ±  3%  interrupts.CPU72.CAL:Function_call_interrupts
      6007 ±  2%     -19.5%       4834 ± 13%  interrupts.CPU72.NMI:Non-maskable_interrupts
      6007 ±  2%     -19.5%       4834 ± 13%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
     26441 ± 10%     -37.5%      16538 ±  3%  interrupts.CPU72.TLB:TLB_shootdowns
     26463 ±  7%     -35.1%      17180        interrupts.CPU73.CAL:Function_call_interrupts
     26223 ±  8%     -35.7%      16857 ±  2%  interrupts.CPU73.TLB:TLB_shootdowns
     25734 ±  9%     -35.0%      16715        interrupts.CPU74.CAL:Function_call_interrupts
      5935 ±  3%     -17.2%       4914 ± 14%  interrupts.CPU74.NMI:Non-maskable_interrupts
      5935 ±  3%     -17.2%       4914 ± 14%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
     25506 ± 10%     -35.7%      16399        interrupts.CPU74.TLB:TLB_shootdowns
     26809 ± 10%     -37.0%      16878 ±  4%  interrupts.CPU75.CAL:Function_call_interrupts
     25727 ±  9%     -35.9%      16496 ±  3%  interrupts.CPU75.TLB:TLB_shootdowns
     26569 ±  6%     -32.8%      17849 ±  6%  interrupts.CPU76.CAL:Function_call_interrupts
     26155 ±  8%     -32.2%      17729 ±  5%  interrupts.CPU76.TLB:TLB_shootdowns
     26936 ± 12%     -34.4%      17679 ±  3%  interrupts.CPU77.CAL:Function_call_interrupts
     26474 ± 11%     -34.2%      17418 ±  3%  interrupts.CPU77.TLB:TLB_shootdowns
     23558 ± 10%     -26.4%      17350 ±  9%  interrupts.CPU78.CAL:Function_call_interrupts
      6292 ±  5%     -14.3%       5395 ± 13%  interrupts.CPU78.NMI:Non-maskable_interrupts
      6292 ±  5%     -14.3%       5395 ± 13%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
     22661 ± 12%     -25.1%      16965 ±  9%  interrupts.CPU78.TLB:TLB_shootdowns
     23900 ±  8%     -28.8%      17026 ± 10%  interrupts.CPU79.CAL:Function_call_interrupts
     22899 ± 11%     -28.3%      16408 ± 12%  interrupts.CPU79.TLB:TLB_shootdowns
     26589 ±  8%     -31.9%      18103 ±  6%  interrupts.CPU8.CAL:Function_call_interrupts
      5937           -15.9%       4996 ±  7%  interrupts.CPU8.NMI:Non-maskable_interrupts
      5937           -15.9%       4996 ±  7%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
     26109 ±  9%     -34.3%      17142 ±  3%  interrupts.CPU8.TLB:TLB_shootdowns
     23831 ± 10%     -24.0%      18112 ±  5%  interrupts.CPU80.CAL:Function_call_interrupts
      2139 ± 79%     -85.7%     305.00 ± 29%  interrupts.CPU80.RES:Rescheduling_interrupts
     22992 ± 11%     -23.4%      17621 ±  5%  interrupts.CPU80.TLB:TLB_shootdowns
     24073 ±  8%     -26.9%      17607 ±  3%  interrupts.CPU81.CAL:Function_call_interrupts
      6311 ±  5%     -21.5%       4957 ± 22%  interrupts.CPU81.NMI:Non-maskable_interrupts
      6311 ±  5%     -21.5%       4957 ± 22%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
      4107 ± 74%     -92.4%     310.75 ± 49%  interrupts.CPU81.RES:Rescheduling_interrupts
     22165 ± 10%     -22.3%      17232 ±  3%  interrupts.CPU81.TLB:TLB_shootdowns
     23394 ±  9%     -25.1%      17527 ±  9%  interrupts.CPU82.CAL:Function_call_interrupts
     22402 ± 10%     -23.0%      17248 ±  9%  interrupts.CPU82.TLB:TLB_shootdowns
     24784 ± 18%     -25.2%      18548 ±  4%  interrupts.CPU83.CAL:Function_call_interrupts
      2295 ± 77%     -87.2%     293.25 ± 33%  interrupts.CPU83.RES:Rescheduling_interrupts
     22683 ± 12%     -19.2%      18323 ±  4%  interrupts.CPU83.TLB:TLB_shootdowns
     23284 ± 10%     -24.9%      17481 ±  7%  interrupts.CPU84.CAL:Function_call_interrupts
     22610 ± 13%     -25.5%      16848 ± 11%  interrupts.CPU84.TLB:TLB_shootdowns
     23078 ± 11%     -21.0%      18228 ±  7%  interrupts.CPU85.CAL:Function_call_interrupts
      1414 ± 48%     -81.0%     269.00 ± 28%  interrupts.CPU85.RES:Rescheduling_interrupts
     22355 ± 11%     -23.4%      17113 ±  6%  interrupts.CPU85.TLB:TLB_shootdowns
     23054 ±  9%     -24.5%      17402 ±  7%  interrupts.CPU86.CAL:Function_call_interrupts
     22287 ± 10%     -24.4%      16850 ±  8%  interrupts.CPU86.TLB:TLB_shootdowns
     22985 ±  9%     -23.7%      17533 ±  7%  interrupts.CPU87.CAL:Function_call_interrupts
      6227 ±  5%     -25.2%       4657 ± 25%  interrupts.CPU87.NMI:Non-maskable_interrupts
      6227 ±  5%     -25.2%       4657 ± 25%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
     22113 ± 11%     -22.5%      17145 ±  8%  interrupts.CPU87.TLB:TLB_shootdowns
     23566 ± 10%     -26.4%      17336 ±  7%  interrupts.CPU88.CAL:Function_call_interrupts
      6211 ±  5%     -30.4%       4322 ± 38%  interrupts.CPU88.NMI:Non-maskable_interrupts
      6211 ±  5%     -30.4%       4322 ± 38%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
     22944 ± 12%     -25.6%      17063 ±  7%  interrupts.CPU88.TLB:TLB_shootdowns
     22953 ±  8%     -23.0%      17664 ±  7%  interrupts.CPU89.CAL:Function_call_interrupts
      6257 ±  4%     -25.6%       4657 ± 24%  interrupts.CPU89.NMI:Non-maskable_interrupts
      6257 ±  4%     -25.6%       4657 ± 24%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
     22312 ± 11%     -22.3%      17338 ±  7%  interrupts.CPU89.TLB:TLB_shootdowns
     25895 ±  8%     -37.5%      16178 ±  4%  interrupts.CPU9.CAL:Function_call_interrupts
      5927 ±  2%     -16.9%       4924 ± 13%  interrupts.CPU9.NMI:Non-maskable_interrupts
      5927 ±  2%     -16.9%       4924 ± 13%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
     25836 ±  9%     -38.2%      15954 ±  4%  interrupts.CPU9.TLB:TLB_shootdowns
     23307 ± 11%     -23.2%      17896 ±  4%  interrupts.CPU90.CAL:Function_call_interrupts
     22572 ± 13%     -23.0%      17390 ±  6%  interrupts.CPU90.TLB:TLB_shootdowns
     23119 ± 11%     -23.7%      17642 ±  8%  interrupts.CPU91.CAL:Function_call_interrupts
     22566 ± 12%     -23.1%      17359 ±  9%  interrupts.CPU91.TLB:TLB_shootdowns
     23060 ± 12%     -24.0%      17537 ± 10%  interrupts.CPU92.CAL:Function_call_interrupts
      1696 ± 33%     -84.7%     259.75 ± 37%  interrupts.CPU92.RES:Rescheduling_interrupts
     22200 ± 13%     -22.1%      17304 ± 11%  interrupts.CPU92.TLB:TLB_shootdowns
     22714 ± 12%     -25.0%      17040 ± 13%  interrupts.CPU93.CAL:Function_call_interrupts
    994.50 ± 14%     -72.0%     278.00 ± 48%  interrupts.CPU93.RES:Rescheduling_interrupts
     22186 ± 12%     -24.8%      16690 ± 13%  interrupts.CPU93.TLB:TLB_shootdowns
     23025 ± 11%     -22.0%      17960 ±  9%  interrupts.CPU94.CAL:Function_call_interrupts
     22298 ± 11%     -21.2%      17562 ±  9%  interrupts.CPU94.TLB:TLB_shootdowns
     23531 ± 10%     -19.8%      18871 ±  8%  interrupts.CPU95.CAL:Function_call_interrupts
     22568 ± 13%     -19.2%      18236 ±  5%  interrupts.CPU95.TLB:TLB_shootdowns
     23352 ± 10%     -23.9%      17771 ±  5%  interrupts.CPU96.CAL:Function_call_interrupts
     22819 ± 12%     -23.1%      17551 ±  4%  interrupts.CPU96.TLB:TLB_shootdowns
     23336 ± 16%     -25.0%      17498 ±  8%  interrupts.CPU97.CAL:Function_call_interrupts
      1713 ± 70%     -85.4%     250.00 ± 27%  interrupts.CPU97.RES:Rescheduling_interrupts
     22534 ± 14%     -24.0%      17136 ±  8%  interrupts.CPU97.TLB:TLB_shootdowns
     22961 ± 11%     -19.2%      18551 ±  7%  interrupts.CPU98.CAL:Function_call_interrupts
    770.25 ± 47%     -68.4%     243.25 ± 38%  interrupts.CPU98.RES:Rescheduling_interrupts
     22489 ± 13%     -18.7%      18274 ±  7%  interrupts.CPU98.TLB:TLB_shootdowns
     23336 ± 11%     -23.8%      17774 ±  8%  interrupts.CPU99.CAL:Function_call_interrupts
     22462 ± 13%     -23.1%      17272 ±  7%  interrupts.CPU99.TLB:TLB_shootdowns
    591378 ±  4%     -13.2%     513176 ±  8%  interrupts.NMI:Non-maskable_interrupts
    591378 ±  4%     -13.2%     513176 ±  8%  interrupts.PMI:Performance_monitoring_interrupts
    107989 ± 17%     -54.3%      49357 ±  5%  interrupts.RES:Rescheduling_interrupts
   2521833           -29.5%    1778413 ±  3%  interrupts.TLB:TLB_shootdowns





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Oliver Sang


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.8.0-rc6-00041-g3edecfef02853"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.8.0-rc6 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235000000
CONFIG_CLANG_VERSION=0
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
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
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
# CONFIG_SCHED_THERMAL_PRESSURE is not set
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
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
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
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
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
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
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
# CONFIG_ACPI_PROCFS_POWER is not set
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
CONFIG_DPTF_POWER=m
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
CONFIG_PMIC_OPREGION=y
# CONFIG_ACPI_CONFIGFS is not set
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
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
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
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
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
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
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
CONFIG_HAVE_COPY_THREAD_TLS=y
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
CONFIG_HAVE_MEMORY_PRESENT=y
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
CONFIG_CMA_AREAS=7
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
# CONFIG_ZSMALLOC_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
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
# CONFIG_WIMAX is not set
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

#
# Intel MIC & related support
#
# CONFIG_INTEL_MIC_BUS is not set
# CONFIG_SCIF_BUS is not set
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

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
# CONFIG_MSCC_OCELOT_SWITCH is not set
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
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set
# CONFIG_MDIO_XPCS is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_ADIN_PHY is not set
# CONFIG_AMD_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_FIXED_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_LXT_PHY is not set
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
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
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
# CONFIG_MT7915E is not set
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

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
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
CONFIG_INPUT_POLLDEV=m
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
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
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
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
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
CONFIG_PINCTRL_INTEL=m
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
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

# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
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
# CONFIG_CHARGER_BQ25890 is not set
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
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
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
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
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
CONFIG_PROC_THERMAL_MMIO_RAPL=y
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
# CONFIG_MFD_SMSC is not set
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
CONFIG_MEDIA_CEC_SUPPORT=y
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
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
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
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_SMIAPP is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
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
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
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
# CONFIG_BACKLIGHT_GENERIC is not set
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
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
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
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
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
# CONFIG_USB_SERIAL_XIRCOM is not set
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
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
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
# CONFIG_INFINIBAND_EXP_LEGACY_VERBS_NEW_UAPI is not set
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
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
# CONFIG_RTC_DRV_RX6110 is not set
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
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
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
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
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
# CONFIG_MFD_CROS_EC is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
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
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

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
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_EMMC is not set
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
CONFIG_QUOTACTL_COMPAT=y
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
CONFIG_CRYPTO_USER_API_AEAD=y
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
CONFIG_ZSTD_DECOMPRESS=m
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
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_DMA_VIRT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y

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
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
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
CONFIG_ENABLE_MUST_CHECK=y
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
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
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
CONFIG_KASAN_STACK=1
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
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
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
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
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
# CONFIG_TEST_BITFIELD is not set
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
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
# CONFIG_LINEAR_RANGES_TEST is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='vm-scalability'
	export testcase='vm-scalability'
	export category='benchmark'
	export runtime=300
	export size=8796093022208
	export job_origin='vm-scalability-hugetlb.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2sp6'
	export tbox_group='lkp-csl-2sp6'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='60329f7eefa0184f1f332500'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2sp6/vm-scalability-performance-300s-8T-anon-w-seq-hugetlb-ucode=0x5003003-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-3edecfef0-20210222-20255-fextjt-3.yaml'
	export id='8e04a482bcfe474ce4548011930c8c45d60562bd'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=2
	export nr_cpu=96
	export memory='256G'
	export nr_hdd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD10EZEX-75ZF5A0_WD-WCC1S1302268-part5'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204001B800RGN-part1'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/ata-WDC_WD10EZEX-75ZF5A0_WD-WCC1S1302268-part4'
	export brand='Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz'
	export need_kconfig='CONFIG_BLK_DEV_LOOP'
	export commit='3edecfef028536cb19a120ec8788bd8a11f93b9e'
	export ucode='0x5003003'
	export need_kconfig_hw='CONFIG_I40E=y
CONFIG_SATA_AHCI'
	export enqueue_time='2021-02-22 01:59:26 +0800'
	export _id='60329f7eefa0184f1f332500'
	export _rt='/result/vm-scalability/performance-300s-8T-anon-w-seq-hugetlb-ucode=0x5003003-monitor=70d6d718/lkp-csl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3edecfef028536cb19a120ec8788bd8a11f93b9e'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='350d083948cbc2ca7960260cdb22a453176817d1'
	export base_commit='f40ddce88593482919761f74910f42f4b84c004b'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='70d6d718'
	export result_root='/result/vm-scalability/performance-300s-8T-anon-w-seq-hugetlb-ucode=0x5003003-monitor=70d6d718/lkp-csl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3edecfef028536cb19a120ec8788bd8a11f93b9e/3'
	export scheduler_version='/lkp/lkp/.src-20210220-142532'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2sp6/vm-scalability-performance-300s-8T-anon-w-seq-hugetlb-ucode=0x5003003-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-3edecfef0-20210222-20255-fextjt-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=3edecfef028536cb19a120ec8788bd8a11f93b9e
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/3edecfef028536cb19a120ec8788bd8a11f93b9e/vmlinuz-5.8.0-rc6-00041-g3edecfef02853
max_uptime=2100
RESULT_ROOT=/result/vm-scalability/performance-300s-8T-anon-w-seq-hugetlb-ucode=0x5003003-monitor=70d6d718/lkp-csl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3edecfef028536cb19a120ec8788bd8a11f93b9e/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/3edecfef028536cb19a120ec8788bd8a11f93b9e/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-e71ba9452f0b-1_20210106.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/vm-scalability_20201110.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/vm-scalability-x86_64-1.0-0_20210122.cgz,/osimage/pkg/common/vm-scalability-x86_64.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.11.0'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/3edecfef028536cb19a120ec8788bd8a11f93b9e/vmlinuz-5.8.0-rc6-00041-g3edecfef02853'
	export dequeue_time='2021-02-22 02:02:27 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2sp6/vm-scalability-performance-300s-8T-anon-w-seq-hugetlb-ucode=0x5003003-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-3edecfef0-20210222-20255-fextjt-3.cgz'

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

	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
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
	run_monitor pmeter_server='lkp-wildcat' pmeter_device='yokogawa-wt310' $LKP_SRC/monitors/wrapper pmeter
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='anon-w-seq-hugetlb' $LKP_SRC/tests/wrapper vm-scalability
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper perf-profile
	env test='anon-w-seq-hugetlb' $LKP_SRC/stats/wrapper vm-scalability
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
	env pmeter_server='lkp-wildcat' pmeter_device='yokogawa-wt310' $LKP_SRC/stats/wrapper pmeter

	$LKP_SRC/stats/wrapper time vm-scalability.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/vm-scalability-hugetlb.yaml
suite: vm-scalability
testcase: vm-scalability
category: benchmark
perf-profile: 
runtime: 300s
size: 8T
vm-scalability:
  test: anon-w-seq-hugetlb
job_origin: vm-scalability-hugetlb.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2sp6
tbox_group: lkp-csl-2sp6
kconfig: x86_64-rhel-8.3
submit_id: 60328c2defa01846f0e67f78
job_file: "/lkp/jobs/scheduled/lkp-csl-2sp6/vm-scalability-performance-300s-8T-anon-w-seq-hugetlb-ucode=0x5003003-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-3edecfef0-20210222-18160-19i5eht-0.yaml"
id: a5514fd2995f610fa751a446e1881c222f682438
queuer_version: "/lkp-src"

#! hosts/lkp-csl-2sp6
model: Cascade Lake
nr_node: 2
nr_cpu: 96
memory: 256G
nr_hdd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD10EZEX-75ZF5A0_WD-WCC1S1302268-part5"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204001B800RGN-part1"
swap_partitions: 
rootfs_partition: "/dev/disk/by-id/ata-WDC_WD10EZEX-75ZF5A0_WD-WCC1S1302268-part4"
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

#! include/category/ALL
cpufreq_governor: performance

#! include/vm-scalability
need_kconfig: CONFIG_BLK_DEV_LOOP

#! include/queue/cyclic
commit: 3edecfef028536cb19a120ec8788bd8a11f93b9e

#! include/testbox/lkp-csl-2sp6
ucode: '0x5003003'
need_kconfig_hw:
- CONFIG_I40E=y
- CONFIG_SATA_AHCI
pmeter:
  pmeter_server: lkp-wildcat
  pmeter_device: yokogawa-wt310
enqueue_time: 2021-02-22 00:37:01.749889792 +08:00
_id: 60328c2defa01846f0e67f78
_rt: "/result/vm-scalability/performance-300s-8T-anon-w-seq-hugetlb-ucode=0x5003003-monitor=70d6d718/lkp-csl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3edecfef028536cb19a120ec8788bd8a11f93b9e"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 350d083948cbc2ca7960260cdb22a453176817d1
base_commit: f40ddce88593482919761f74910f42f4b84c004b
branch: linus/master
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 70d6d718
result_root: "/result/vm-scalability/performance-300s-8T-anon-w-seq-hugetlb-ucode=0x5003003-monitor=70d6d718/lkp-csl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3edecfef028536cb19a120ec8788bd8a11f93b9e/0"
scheduler_version: "/lkp/lkp/.src-20210220-142532"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2sp6/vm-scalability-performance-300s-8T-anon-w-seq-hugetlb-ucode=0x5003003-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-3edecfef0-20210222-18160-19i5eht-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linus/master
- commit=3edecfef028536cb19a120ec8788bd8a11f93b9e
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/3edecfef028536cb19a120ec8788bd8a11f93b9e/vmlinuz-5.8.0-rc6-00041-g3edecfef02853
- max_uptime=2100
- RESULT_ROOT=/result/vm-scalability/performance-300s-8T-anon-w-seq-hugetlb-ucode=0x5003003-monitor=70d6d718/lkp-csl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/3edecfef028536cb19a120ec8788bd8a11f93b9e/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/3edecfef028536cb19a120ec8788bd8a11f93b9e/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-e71ba9452f0b-1_20210106.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/vm-scalability_20201110.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/vm-scalability-x86_64-1.0-0_20210122.cgz,/osimage/pkg/common/vm-scalability-x86_64.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210210-104238/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.11.0-07463-g9621ab731e1f

#! /lkp/lkp/.src-20210220-142532/include/site/inn
repeat_to: 3

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/3edecfef028536cb19a120ec8788bd8a11f93b9e/vmlinuz-5.8.0-rc6-00041-g3edecfef02853"
dequeue_time: 2021-02-22 00:50:35.810606632 +08:00
job_state: finished
loadavg: 72.19 56.59 25.58 1/725 17312
start_time: '1613926282'
end_time: '1613926585'
version: "/lkp/lkp/.src-20210220-142605:7c6b06e6:ddb39f226"

--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

cd /lkp/benchmarks/vm-scalability
 mount -t tmpfs -o size=100% vm-scalability-tmp /tmp/vm-scalability-tmp
 truncate -s 270135230464 /tmp/vm-scalability-tmp/vm-scalability.img
 mkfs.xfs -q /tmp/vm-scalability-tmp/vm-scalability.img
 mount -o loop /tmp/vm-scalability-tmp/vm-scalability.img /tmp/vm-scalability-tmp/vm-scalability
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 ./case-anon-w-seq-hugetlb
 ./usemem --runtime 300 -n 96 -O -U 1406954325
 umount /tmp/vm-scalability-tmp/vm-scalability
 rm /tmp/vm-scalability-tmp/vm-scalability.img
 umount /tmp/vm-scalability-tmp

--vGgW1X5XWziG23Ko--
