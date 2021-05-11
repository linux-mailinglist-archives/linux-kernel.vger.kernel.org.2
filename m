Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EBE37A17B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhEKIPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:15:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:18115 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230271AbhEKIPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:15:35 -0400
IronPort-SDR: vVCumKKgbhwTpiSKmMaojDSp9tejgf2IiZ7i77rVJp3mTZBRBVMr/taCt5+0szN/SbcADcvxYP
 y1TRwfb9c4Wg==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="197403378"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="yaml'?scan'208";a="197403378"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 01:14:25 -0700
IronPort-SDR: YXTtkmLPlV8SomfdawrL/g5wgV2yqJa4Uxel/F8Gft0Nn9ecHemSjQqWN+0Sm5qjinhbvJgZLj
 d/ae0t2xDhTw==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="yaml'?scan'208";a="624611586"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 01:14:18 -0700
Date:   Tue, 11 May 2021 16:31:20 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: [mm]  2d146aa3aa:  vm-scalability.throughput -2.8% regression
Message-ID: <20210511083119.GH8539@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Greeting,

FYI, we noticed a -2.8% regression of vm-scalability.throughput due to commit:


commit: 2d146aa3aa842d7f5065802556b4f9a2c6e8ef12 ("mm: memcontrol: switch to rstat")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: vm-scalability
on test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
with following parameters:

	runtime: 300s
	test: lru-file-mmap-read-rand
	cpufreq_governor: performance
	ucode: 0x5003006

test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/

In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------+
| testcase: change | reaim: reaim.jobs_per_min -2.7% regression                                          |
| test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                                        |
|                  | nr_task=100%                                                                        |
|                  | runtime=300s                                                                        |
|                  | test=aim9                                                                           |
|                  | ucode=0x5003006                                                                     |
+------------------+-------------------------------------------------------------------------------------+


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
compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap4/lru-file-mmap-read-rand/vm-scalability/0x5003006

commit: 
  dc26532aed ("cgroup: rstat: punt root-level optimization to individual controllers")
  2d146aa3aa ("mm: memcontrol: switch to rstat")

dc26532aed0ab25c 2d146aa3aa842d7f5065802556b 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      8798            -3.0%       8533        vm-scalability.median
   1696442            -2.8%    1648941        vm-scalability.throughput
    378.62            +2.8%     389.16        vm-scalability.time.elapsed_time
    378.62            +2.8%     389.16        vm-scalability.time.elapsed_time.max
  48931042            -1.2%   48355398        vm-scalability.time.major_page_faults
   3116506 ±  3%     -19.3%    2514494 ± 10%  vm-scalability.time.maximum_resident_set_size
    854811            -2.2%     835712        vm-scalability.time.minor_page_faults
     58258            +3.4%      60219        vm-scalability.time.system_time
     36.55 ±  5%     -25.4%      27.27 ±  5%  vm-scalability.time.user_time
    929.17 ± 53%    +874.8%       9057 ± 99%  softirqs.CPU12.NET_RX
      6700            -1.9%       6573        vmstat.system.cs
    362.61 ±  5%     -10.3%     325.09 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    359.35 ±  3%      -9.6%     324.98 ±  5%  perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1670 ± 48%    +956.2%      17638 ±103%  interrupts.40:PCI-MSI.524291-edge.eth0-TxRx-2
    185.83 ± 25%     -53.5%      86.33 ± 28%  interrupts.CPU116.RES:Rescheduling_interrupts
      1670 ± 48%    +956.2%      17638 ±103%  interrupts.CPU12.40:PCI-MSI.524291-edge.eth0-TxRx-2
     97.00 ± 13%     -27.5%      70.33 ± 20%  interrupts.CPU176.RES:Rescheduling_interrupts
    107.17 ± 21%     -33.9%      70.83 ± 18%  interrupts.CPU189.RES:Rescheduling_interrupts
    361.67 ±  6%     +11.1%     401.67 ±  3%  interrupts.CPU2.RES:Rescheduling_interrupts
    284.67 ±  5%     +43.1%     407.50 ± 23%  interrupts.CPU41.RES:Rescheduling_interrupts
    268.33 ±  9%     +15.7%     310.33 ± 12%  interrupts.CPU46.RES:Rescheduling_interrupts
    226.00 ±  7%     +18.4%     267.67 ±  6%  interrupts.CPU52.RES:Rescheduling_interrupts
    138.83 ± 10%     -17.5%     114.50 ± 14%  interrupts.CPU71.RES:Rescheduling_interrupts
    562317 ±  3%      -8.4%     515046 ±  6%  interrupts.CPU72.TLB:TLB_shootdowns
      3617 ± 11%     -29.9%       2535 ± 15%  proc-vmstat.allocstall_normal
      1016 ±  4%     -13.4%     879.83 ±  8%  proc-vmstat.kswapd_low_wmark_hit_quickly
      1131            -6.2%       1060 ±  2%  proc-vmstat.nr_isolated_file
   1684103            -1.3%    1662379        proc-vmstat.nr_page_table_pages
   1189118            -1.6%    1169561        proc-vmstat.nr_slab_reclaimable
  1.54e+09            -1.2%  1.522e+09        proc-vmstat.pgalloc_normal
 1.004e+08            -1.1%   99249683        proc-vmstat.pgfault
 1.557e+09            -1.1%  1.539e+09        proc-vmstat.pgfree
  48883247            -1.2%   48308956        proc-vmstat.pgmajfault
     99332            +2.6%     101937        proc-vmstat.pgreuse
 2.229e+09            -1.2%  2.201e+09        proc-vmstat.pgscan_file
 1.496e+09            -1.2%  1.478e+09        proc-vmstat.pgsteal_file
  17500257            -4.3%   16741696        proc-vmstat.workingset_nodereclaim
   4747501            -2.4%    4631656        proc-vmstat.workingset_nodes
 1.486e+08            -3.6%  1.433e+08        proc-vmstat.workingset_refault_file
     80.71 ±  5%     -25.4       55.30 ±  6%  perf-profile.calltrace.cycles-pp.do_access
     80.69 ±  5%     -25.4       55.28 ±  6%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
     80.66 ±  5%     -25.4       55.26 ±  6%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
     80.66 ±  5%     -25.4       55.26 ±  6%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     80.65 ±  5%     -25.4       55.25 ±  6%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
      0.67 ± 13%      -0.4        0.26 ±100%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_list.shrink_page_list.shrink_inactive_list.shrink_lruvec
     17.05 ± 28%     +25.2       42.25 ±  8%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     17.06 ± 28%     +25.2       42.26 ±  8%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     17.06 ± 28%     +25.2       42.26 ±  8%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
     17.06 ± 28%     +25.2       42.26 ±  8%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
     80.74 ±  5%     -25.4       55.31 ±  6%  perf-profile.children.cycles-pp.do_access
      0.14 ±  6%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__count_memcg_events
      0.27 ± 16%      -0.1        0.18 ±  6%  perf-profile.children.cycles-pp.try_charge
      0.09 ±  4%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.workingset_refault
      0.29 ±  3%      +0.1        0.34 ± 10%  perf-profile.children.cycles-pp.xfs_filemap_map_pages
      0.28 ±  3%      +0.1        0.34 ± 11%  perf-profile.children.cycles-pp.filemap_map_pages
      0.11 ±  6%      +0.1        0.18 ± 22%  perf-profile.children.cycles-pp.page_add_file_rmap
      0.12 ±  6%      +0.1        0.19 ± 19%  perf-profile.children.cycles-pp.do_set_pte
      0.54 ±  8%      +0.2        0.76 ± 18%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.14 ±  6%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.__count_memcg_events
      0.40 ± 38%      -0.1        0.28        perf-stat.i.branch-miss-rate%
  29502377 ±  5%      -8.9%   26877024        perf-stat.i.branch-misses
 1.102e+08            -8.6%  1.008e+08        perf-stat.i.cache-misses
 2.578e+08 ±  4%      -7.1%  2.395e+08 ±  2%  perf-stat.i.cache-references
      6587            -2.0%       6459        perf-stat.i.context-switches
      3923            +9.0%       4277        perf-stat.i.cycles-between-cache-misses
      0.12 ± 11%      -0.0        0.10 ± 11%  perf-stat.i.dTLB-load-miss-rate%
 1.494e+10            +1.3%  1.515e+10        perf-stat.i.dTLB-loads
      0.02 ± 14%      -0.0        0.02 ±  8%  perf-stat.i.dTLB-store-miss-rate%
   3782013 ±  2%      -8.2%    3470625 ±  2%  perf-stat.i.iTLB-load-misses
     14984            +7.6%      16129 ±  2%  perf-stat.i.instructions-per-iTLB-miss
    125639            -3.7%     120964        perf-stat.i.major-faults
    385.69 ±  9%     -12.7%     336.62 ±  2%  perf-stat.i.metric.K/sec
  24655193            -3.6%   23766292        perf-stat.i.node-load-misses
     62.43            -4.3       58.12        perf-stat.i.node-store-miss-rate%
  16903554           -18.7%   13745638        perf-stat.i.node-store-misses
    132189            -3.6%     127372        perf-stat.i.page-faults
      4.30 ±  3%      -6.7%       4.01 ±  2%  perf-stat.overall.MPKI
      0.22 ±  4%      -0.0        0.20        perf-stat.overall.branch-miss-rate%
      4354           +10.2%       4797        perf-stat.overall.cycles-between-cache-misses
     84.81            -2.2       82.63        perf-stat.overall.iTLB-load-miss-rate%
     15931            +8.8%      17329 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
     60.20            -4.1       56.14        perf-stat.overall.node-store-miss-rate%
     43107            +2.6%      44240        perf-stat.overall.path-length
  29668531 ±  4%      -8.2%   27224284        perf-stat.ps.branch-misses
 1.121e+08            -8.7%  1.024e+08        perf-stat.ps.cache-misses
 2.623e+08 ±  3%      -6.7%  2.446e+08 ±  2%  perf-stat.ps.cache-references
      6672            -2.0%       6538        perf-stat.ps.context-switches
 1.536e+10            +1.2%  1.555e+10        perf-stat.ps.dTLB-loads
   3828017            -8.0%    3520592 ±  2%  perf-stat.ps.iTLB-load-misses
    128812            -3.7%     124041        perf-stat.ps.major-faults
  25194762            -3.7%   24262604        perf-stat.ps.node-load-misses
  17325664           -18.8%   14075191        perf-stat.ps.node-store-misses
    135306            -3.6%     130410        perf-stat.ps.page-faults
 2.316e+13            +2.6%  2.377e+13        perf-stat.total.instructions


                                                                                
                               vm-scalability.median                            
                                                                                
  9000 +--------------------------------------------------------------------+   
       | +.   +    +     +      +.    +.  +   +     +  +    +    + .+      +|   
  8800 |++ +++ +. + +.+ + +.++  : + ++  ++ :.+ ++ .+ ++ +   :+.+ :+  +++ .+ |   
       |         +     +      ++   +       +     +       +++    +    O  +   |   
  8600 |-+     O    O     O   O   O      O                      O O         |   
       |O    OO  OOO  O OO          O O        O          OO O   O    O     |   
  8400 |-+                  OO OO       O    OO  O OOOOO O  O  O    O       |   
       |               O                  OO                                |   
  8200 |-+                                      O                           |   
       |                                                                    |   
  8000 |-+                                                                  |   
       | O O                       O O                                      |   
  7800 |-+  O                                                               |   
       |                                                                    |   
  7600 +--------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2ap3: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap3/aim9/reaim/0x5003006

commit: 
  dc26532aed ("cgroup: rstat: punt root-level optimization to individual controllers")
  2d146aa3aa ("mm: memcontrol: switch to rstat")

dc26532aed0ab25c 2d146aa3aa842d7f5065802556b 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     84.10 ±  2%     +54.3%     129.73 ±  2%  reaim.child_systime
     98.64            -2.7%      96.02        reaim.child_utime
    123355            -2.7%     120037        reaim.jobs_per_min
    642.47            -2.7%     625.20        reaim.jobs_per_min_child
    124335            -2.5%     121192        reaim.max_jobs_per_min
     11.21            +2.8%      11.52        reaim.parent_time
      1.01 ±  4%     +87.3%       1.90 ±  2%  reaim.std_dev_percent
      0.11 ±  4%     +91.0%       0.21 ±  2%  reaim.std_dev_time
    304.73            +2.3%     311.86        reaim.time.elapsed_time
    304.73            +2.3%     311.86        reaim.time.elapsed_time.max
      1380           +20.7%       1666        reaim.time.percent_of_cpu_this_job_got
      1938 ±  2%     +54.2%       2988 ±  2%  reaim.time.system_time
      2270            -2.6%       2210        reaim.time.user_time
   3236827            -1.1%    3200863        reaim.time.voluntary_context_switches
      0.33 ±  4%      +0.1        0.39 ±  4%  mpstat.cpu.all.soft%
      3.55            +1.6        5.11        mpstat.cpu.all.sys%
    122697 ±  2%      -9.0%     111603 ±  3%  meminfo.Active
    122697 ±  2%      -9.0%     111603 ±  3%  meminfo.Active(anon)
    141299 ±  2%      -8.5%     129326 ±  3%  meminfo.Shmem
    139.33 ±  3%     +17.6%     163.83 ±  3%  turbostat.Avg_MHz
     10.90 ±  9%      +1.9       12.76 ±  8%  turbostat.Busy%
     91.46            +4.1%      95.19 ±  2%  turbostat.PkgWatt
     90.00            -1.7%      88.50        vmstat.cpu.id
     13.17 ±  2%     +25.3%      16.50 ±  4%  vmstat.procs.r
     30506            -1.8%      29962        vmstat.system.cs
     30622 ±  2%      -9.0%      27871 ±  3%  proc-vmstat.nr_active_anon
    279241            -1.1%     276304        proc-vmstat.nr_file_pages
     11132 ±  2%      -5.5%      10519        proc-vmstat.nr_mapped
     35312 ±  2%      -8.3%      32376 ±  2%  proc-vmstat.nr_shmem
     40363            -5.7%      38052        proc-vmstat.nr_slab_reclaimable
    110643            -3.7%     106541        proc-vmstat.nr_slab_unreclaimable
     30622 ±  2%      -9.0%      27871 ±  3%  proc-vmstat.nr_zone_active_anon
     27867 ±  4%     +13.4%      31609 ±  8%  softirqs.CPU102.RCU
     27291 ±  2%     +13.1%      30868 ±  6%  softirqs.CPU115.RCU
     27063 ±  4%     +10.6%      29942 ±  5%  softirqs.CPU168.RCU
     27214 ±  4%     +12.6%      30637 ±  8%  softirqs.CPU19.RCU
     26223 ±  5%     +12.4%      29479 ±  7%  softirqs.CPU20.RCU
     26918 ±  3%     +11.2%      29939 ±  5%  softirqs.CPU21.RCU
     27358 ±  3%     +12.8%      30859 ±  6%  softirqs.CPU72.RCU
     72679 ±  5%     -14.8%      61952        slabinfo.cred_jar.active_objs
      1732 ±  5%     -14.8%       1475        slabinfo.cred_jar.active_slabs
     72758 ±  5%     -14.8%      61977        slabinfo.cred_jar.num_objs
      1732 ±  5%     -14.8%       1475        slabinfo.cred_jar.num_slabs
    163390 ±  2%      -9.4%     148066        slabinfo.kmalloc-32.active_objs
      1276 ±  2%      -9.3%       1157        slabinfo.kmalloc-32.active_slabs
    163419 ±  2%      -9.3%     148174        slabinfo.kmalloc-32.num_objs
      1276 ±  2%      -9.3%       1157        slabinfo.kmalloc-32.num_slabs
     17365 ±  4%     -12.4%      15219        slabinfo.kmalloc-rcl-512.active_objs
     17851 ±  5%     -13.8%      15380        slabinfo.kmalloc-rcl-512.num_objs
     46066 ±  8%     -32.6%      31064        slabinfo.pid.active_objs
    719.33 ±  8%     -32.6%     485.17        slabinfo.pid.active_slabs
     46066 ±  8%     -32.6%      31064        slabinfo.pid.num_objs
    719.33 ±  8%     -32.6%     485.17        slabinfo.pid.num_slabs
     23819 ±  2%      -8.2%      21874 ±  3%  slabinfo.proc_inode_cache.num_objs
     50922 ±  4%     -18.8%      41342        slabinfo.radix_tree_node.active_objs
    908.83 ±  4%     -18.8%     737.83        slabinfo.radix_tree_node.active_slabs
     50932 ±  4%     -18.8%      41342        slabinfo.radix_tree_node.num_objs
    908.83 ±  4%     -18.8%     737.83        slabinfo.radix_tree_node.num_slabs
     26831 ±  2%     -13.0%      23354        slabinfo.shmem_inode_cache.active_objs
     26831 ±  2%     -13.0%      23354        slabinfo.shmem_inode_cache.num_objs
      9939 ±  6%     -14.2%       8531        slabinfo.sock_inode_cache.active_objs
      9939 ±  6%     -14.2%       8531        slabinfo.sock_inode_cache.num_objs
     58065 ±  6%     -21.1%      45815        slabinfo.task_delay_info.active_objs
      1138 ±  6%     -21.1%     898.00        slabinfo.task_delay_info.active_slabs
     58067 ±  6%     -21.1%      45815        slabinfo.task_delay_info.num_objs
      1138 ±  6%     -21.1%     898.00        slabinfo.task_delay_info.num_slabs
     31451 ±  2%     +12.7%      35438 ±  3%  slabinfo.vmap_area.active_objs
 4.963e+09            -4.1%  4.761e+09        perf-stat.i.branch-instructions
  41054171 ±  2%      +5.6%   43339523 ±  2%  perf-stat.i.cache-misses
     30475            -2.6%      29684        perf-stat.i.context-switches
 5.083e+10 ±  3%     +18.7%  6.036e+10 ±  3%  perf-stat.i.cpu-cycles
 8.482e+09            -3.5%  8.187e+09        perf-stat.i.dTLB-loads
 5.232e+09            -3.1%  5.072e+09        perf-stat.i.dTLB-stores
   8995832            +7.5%    9666624        perf-stat.i.iTLB-load-misses
 3.179e+10            -3.9%  3.056e+10        perf-stat.i.instructions
      0.26 ±  3%     +19.0%       0.32 ±  3%  perf-stat.i.metric.GHz
     98.17            -3.3%      94.94        perf-stat.i.metric.M/sec
    291539            -3.1%     282571        perf-stat.i.minor-faults
   4098219 ±  2%     -16.3%    3428560        perf-stat.i.node-store-misses
    291652            -3.1%     282684        perf-stat.i.page-faults
      6.08 ± 21%     +24.5%       7.56 ± 21%  perf-stat.overall.MPKI
      1.60 ±  3%     +23.8%       1.98 ±  3%  perf-stat.overall.cpi
      1236 ±  2%     +12.4%       1389        perf-stat.overall.cycles-between-cache-misses
     66.75 ±  4%      +6.5       73.24 ±  8%  perf-stat.overall.iTLB-load-miss-rate%
      3537           -10.5%       3164        perf-stat.overall.instructions-per-iTLB-miss
      0.63 ±  3%     -19.3%       0.51 ±  3%  perf-stat.overall.ipc
     68.80            -3.4       65.35        perf-stat.overall.node-store-miss-rate%
 4.991e+09            -3.3%  4.827e+09        perf-stat.ps.branch-instructions
  41348616 ±  2%      +6.8%   44155400 ±  2%  perf-stat.ps.cache-misses
     30650            -1.8%      30099        perf-stat.ps.context-switches
 5.113e+10 ±  3%     +20.0%  6.135e+10 ±  3%  perf-stat.ps.cpu-cycles
      2894            +2.2%       2958        perf-stat.ps.cpu-migrations
 8.531e+09            -2.7%    8.3e+09        perf-stat.ps.dTLB-loads
 5.261e+09            -2.3%  5.141e+09        perf-stat.ps.dTLB-stores
   9039686            +8.3%    9792543        perf-stat.ps.iTLB-load-misses
 3.198e+10            -3.1%  3.098e+10        perf-stat.ps.instructions
    293396            -2.2%     286854        perf-stat.ps.minor-faults
   4129671           -15.4%    3492596        perf-stat.ps.node-store-misses
    293509            -2.2%     286969        perf-stat.ps.page-faults
      0.15 ± 39%     -93.5%       0.01 ± 69%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ±  6%     -33.3%       0.01        perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.02 ± 11%     -69.6%       0.00 ± 10%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.02 ± 69%     -80.0%       0.00 ± 20%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.32 ± 62%     -98.8%       0.00 ± 27%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.01 ± 17%     -61.7%       0.01 ± 20%  perf-sched.sch_delay.avg.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
      0.00 ± 20%     -54.5%       0.00 ± 74%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.shift_arg_pages
      0.06 ±201%     -99.2%       0.00 ±223%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
      0.05 ± 94%     -88.8%       0.01 ± 34%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.02 ± 44%     -81.6%       0.00 ± 27%  perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.path_openat.do_filp_open.do_sys_openat2
      0.30 ± 13%     -99.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.walk_component.path_lookupat.isra.0
      0.10 ± 56%     -95.8%       0.00 ± 46%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.13 ± 84%     -97.6%       0.00 ± 66%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.filename_create.do_linkat.__x64_sys_link
      0.19 ± 69%     -98.1%       0.00 ± 21%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.filename_create.do_mknodat.do_syscall_64
      0.09 ± 50%     -96.1%       0.00 ± 64%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      0.03 ± 37%     -48.4%       0.01 ± 30%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      7.03 ± 24%     -99.6%       0.03 ± 40%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.94 ± 20%     -46.3%       3.19 ± 32%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      9.44 ± 25%     -70.2%       2.81 ± 22%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.03 ± 64%    +678.2%       0.23 ± 46%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      5.41 ± 53%     -94.2%       0.31 ±109%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      4.67 ± 65%     -99.7%       0.01 ±104%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      2.73 ± 59%     -94.8%       0.14 ±208%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      1.39 ±124%     -91.3%       0.12 ±113%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.27 ±215%     -98.1%       0.01 ± 36%  perf-sched.sch_delay.max.ms.io_schedule.__lock_page.pagecache_get_page.shmem_getpage_gfp
      1.25 ± 35%     -72.5%       0.34 ± 70%  perf-sched.sch_delay.max.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
      3.42 ± 22%     -45.5%       1.86 ± 44%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.12 ±208%     -95.8%       0.01 ± 37%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.__pmd_alloc.copy_page_range
      3.79 ± 36%     -59.5%       1.53 ± 20%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.01 ± 81%     -67.2%       0.00 ± 11%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.link_path_walk
      0.57 ±185%     -97.3%       0.02 ±107%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.dup_mmap.dup_mm
      0.07 ±184%     -99.3%       0.00 ±223%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
      4.87 ± 57%     -99.9%       0.01 ± 39%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.scan_positives.dcache_readdir
      2.55 ± 98%     -93.8%       0.16 ±165%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.24 ±200%     -96.6%       0.01 ± 16%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.shmem_getpage_gfp.shmem_write_begin
      0.04 ±105%     -85.9%       0.01 ± 73%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.20 ±120%     -94.9%       0.01 ±163%  perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.down_read_killable.iterate_dir.__x64_sys_getdents64
      0.58 ± 62%     -97.7%       0.01 ± 61%  perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.path_openat.do_filp_open.do_sys_openat2
      7.71 ± 16%     -99.8%       0.01 ± 25%  perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.walk_component.path_lookupat.isra.0
      6.08 ± 30%     -99.4%       0.04 ±170%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.84 ±102%     -96.2%       0.03 ±205%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process
      4.56 ± 87%     -99.8%       0.01 ± 49%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.filename_create.do_linkat.__x64_sys_link
      6.50 ± 49%     -99.8%       0.01 ±  5%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.filename_create.do_mknodat.do_syscall_64
      8.19 ± 20%     -99.2%       0.07 ±139%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      0.75 ± 61%     -94.5%       0.04 ±192%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap
      0.24 ±152%     -99.4%       0.00 ±152%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
      0.01 ± 79%    +359.3%       0.04 ±105%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      0.01 ±  3%     -52.6%       0.01 ±  9%  perf-sched.total_sch_delay.average.ms
     12.56 ± 26%     -35.1%       8.15 ± 35%  perf-sched.total_sch_delay.max.ms
     30.21          +109.9%      63.41 ±  3%  perf-sched.total_wait_and_delay.average.ms
    157346           -10.3%     141167 ±  2%  perf-sched.total_wait_and_delay.count.ms
     30.20          +109.9%      63.41 ±  3%  perf-sched.total_wait_time.average.ms
      1.83 ±  3%   +4426.0%      82.86 ±  4%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      3.48 ± 10%    +387.5%      16.97 ±  4%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      8.49 ± 75%   +2944.8%     258.38 ± 11%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    132.38 ± 26%    +371.3%     623.98 ± 45%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     94.13 ± 18%    +122.5%     209.45 ± 29%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.04 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
    431.12 ±  5%     +37.1%     590.85 ±  3%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
    208.00           -90.7%      19.33 ±155%  perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     41990           -10.8%      37469 ±  2%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     42011           -12.7%      36693 ±  2%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     29.67 ± 19%     -45.5%      16.17 ± 22%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
    889.50 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
    155.33 ± 33%     -65.6%      53.50 ± 21%  perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.walk_component.path_lookupat.isra.0
    982.50 ±  6%     +44.7%       1422 ± 34%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      5738 ±  5%     -15.3%       4862 ±  4%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
      1514 ± 41%    +230.5%       5006        perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1032          +384.9%       5007        perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    685.22 ± 70%    +630.6%       5006        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1023          +389.0%       5004        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      1014          +393.3%       5004        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      3.70 ± 59%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      1027          +387.0%       5004        perf-sched.wait_and_delay.max.ms.rwsem_down_read_slowpath.walk_component.path_lookupat.isra.0
    362.48 ± 10%     -37.3%     227.31 ± 30%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      3081 ±  9%    +100.1%       6166 ± 14%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.02 ± 55%     -79.6%       0.01 ± 98%  perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      1.82 ±  3%   +4445.6%      82.85 ±  4%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      3.47 ± 10%    +389.5%      16.96 ±  4%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      5.18 ± 92%   +1930.5%     105.14 ± 64%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     11.39 ± 43%   +2168.2%     258.38 ± 11%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    132.06 ± 26%    +372.5%     623.97 ± 45%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     94.06 ± 18%    +122.7%     209.45 ± 29%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.02 ± 57%     -90.4%       0.00 ±223%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork.[unknown]
      0.47 ± 61%    +118.1%       1.03 ± 39%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.__vmalloc_node_range.dup_task_struct
      1.51 ±100%  +20748.9%     315.17 ±106%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.__split_vma
      0.05 ± 50%     -98.7%       0.00 ±223%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.d_alloc_parallel.__lookup_slow
     36.86 ± 85%    +717.8%     301.47 ± 43%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      3.18 ± 14%   +3169.3%     104.10 ± 82%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.shmem_undo_range.shmem_truncate_range.shmem_evict_inode
      0.10 ± 43%     -88.9%       0.01 ± 73%  perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.path_openat.do_filp_open.do_sys_openat2
      0.11 ± 37%     -90.7%       0.01 ± 34%  perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.walk_component.link_path_walk.part.0
    431.09 ±  5%     +37.1%     590.84 ±  3%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.95 ± 28%     -81.9%       0.17 ±132%  perf-sched.wait_time.max.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      1514 ± 41%    +230.5%       5006        perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1024          +388.6%       5007        perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    506.35 ± 97%    +888.4%       5004        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    852.80 ± 44%    +487.0%       5006        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1019          +390.9%       5004        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      1011          +394.6%       5004        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.59 ± 42%     -92.5%       0.04 ±223%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork.[unknown]
      2.98 ± 85%  +83912.9%       2505 ± 99%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.__split_vma
      0.25 ± 64%     -99.5%       0.00 ±223%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.d_alloc_parallel.__lookup_slow
      4.39 ± 35%     -64.9%       1.54 ± 85%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      5.41 ± 48%  +61566.5%       3337 ± 70%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
      0.78 ±138%  +1.1e+05%     836.18 ±222%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault
      1.36 ± 78%     -89.9%       0.14 ± 96%  perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.path_openat.do_filp_open.do_sys_openat2
      3.77 ± 15%     -84.0%       0.60 ± 34%  perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.walk_component.link_path_walk.part.0
      1022          +389.7%       5004        perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.walk_component.path_lookupat.isra.0
    178.25 ±210%     -99.4%       1.10 ±124%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process
      1.92 ± 85%     -88.7%       0.22 ±223%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
    362.45 ± 10%     -37.3%     227.27 ± 30%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      3081 ±  9%    +100.1%       6166 ± 14%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      7.00 ± 64%      -7.0        0.00        perf-profile.calltrace.cycles-pp.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      7.19 ± 63%      -6.9        0.29 ±100%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.18 ± 63%      -6.9        0.28 ±100%  perf-profile.calltrace.cycles-pp.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.83 ± 65%      -6.8        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents64
      7.19 ± 63%      -6.8        0.37 ± 71%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.56 ± 67%      -6.6        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir
      2.90 ± 38%      -2.5        0.38 ± 70%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
      2.90 ± 38%      -2.5        0.38 ± 70%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      2.90 ± 38%      -2.5        0.38 ± 70%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      2.90 ± 38%      -2.5        0.38 ± 70%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      3.11 ± 36%      -2.5        0.62 ± 13%  perf-profile.calltrace.cycles-pp.__libc_fork
      1.23 ± 63%      -1.0        0.27 ±100%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.08 ± 18%      -0.5        0.58 ± 52%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      1.53 ± 20%      -0.5        1.04 ±  9%  perf-profile.calltrace.cycles-pp.execve
      1.53 ± 20%      -0.5        1.04 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      1.53 ± 20%      -0.5        1.04 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.53 ± 20%      -0.5        1.04 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.52 ± 20%      -0.5        1.04 ±  9%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.89 ± 15%      -0.3        0.62 ±  8%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.93 ± 15%      -0.3        0.67 ±  7%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      1.17 ± 10%      +0.3        1.51 ± 10%  perf-profile.calltrace.cycles-pp.zap_pte_range.unmap_page_range.unmap_vmas.exit_mmap.mmput
      1.21 ± 10%      +0.3        1.56 ± 10%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.do_exit
      1.26 ± 10%      +0.4        1.61 ±  9%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.do_exit.do_group_exit
      0.35 ± 70%      +0.4        0.71 ±  9%  perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.unmap_page_range.unmap_vmas.exit_mmap
      0.48 ± 45%      +0.4        0.89 ± 11%  perf-profile.calltrace.cycles-pp.shmem_file_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
      0.98 ±  9%      +0.4        1.41 ± 10%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.66 ± 14%      +0.4        1.08 ± 10%  perf-profile.calltrace.cycles-pp.copy_page_range.dup_mmap.dup_mm.copy_process.kernel_clone
      1.03 ±  8%      +0.5        1.49 ± 10%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.61 ±  8%      +0.5        1.11 ± 18%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.64 ± 14%      +0.5        1.15 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.73 ± 13%      +0.5        2.24 ±  7%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.65 ±  8%      +0.5        1.17 ± 17%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.55 ± 46%      +0.6        1.13 ±  6%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.41 ± 71%      +0.6        1.00 ± 16%  perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
      0.20 ±141%      +0.6        0.82 ± 10%  perf-profile.calltrace.cycles-pp.copy_pte_range.copy_page_range.dup_mmap.dup_mm.copy_process
      1.85 ± 13%      +0.7        2.54 ±  8%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.7        0.72 ± 22%  perf-profile.calltrace.cycles-pp.__do_munmap.__x64_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.18 ±141%      +0.7        0.92 ± 23%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.78 ± 27%  perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.58 ± 46%      +0.8        1.36 ± 36%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.9        0.85 ± 34%  perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_truncate_range.shmem_evict_inode.evict.do_unlinkat
      0.75 ± 11%      +0.9        1.60 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.86 ± 34%  perf-profile.calltrace.cycles-pp.shmem_truncate_range.shmem_evict_inode.evict.do_unlinkat.do_syscall_64
      0.00            +0.9        0.86 ± 34%  perf-profile.calltrace.cycles-pp.evict.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.86 ± 34%  perf-profile.calltrace.cycles-pp.shmem_evict_inode.evict.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.87 ± 25%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00            +0.9        0.90 ± 32%  perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.90 ± 33%  perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +1.0        0.96 ± 11%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.10 ±223%      +1.0        1.06 ± 37%  perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.43 ± 72%      +1.0        1.42 ± 34%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.73 ± 10%      +1.0        1.76 ± 11%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      2.22 ± 11%      +1.1        3.34 ± 11%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.75 ± 11%      +1.1        1.87 ±  8%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.05 ± 11%      +1.2        2.22 ± 25%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.80 ± 11%      +1.2        2.01 ±  8%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      2.32 ± 11%      +1.4        3.70 ± 13%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.55 ± 11%      +1.4        3.94 ± 24%  perf-profile.calltrace.cycles-pp.shmem_getpage_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      2.60 ± 11%      +1.4        3.99 ± 24%  perf-profile.calltrace.cycles-pp.shmem_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      2.56 ± 11%      +1.4        3.98 ± 12%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      2.55 ± 11%      +1.4        3.97 ± 12%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.60 ± 11%      +1.4        4.03 ± 11%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      3.33 ± 27%      +1.6        4.96 ± 10%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.33 ± 27%      +1.6        4.96 ± 10%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.09 ±223%      +1.9        1.94 ± 41%  perf-profile.calltrace.cycles-pp.shmem_add_to_page_cache.shmem_getpage_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter
      1.09 ± 17%      +1.9        3.03 ± 16%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.96 ± 12%      +3.1        5.10 ± 10%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.98 ± 13%      +3.2        5.19 ± 10%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      3.84 ± 10%      +3.7        7.54 ± 10%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.94 ± 10%      +3.8        7.72 ± 10%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.29 ± 13%      +4.6        8.93 ±  8%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      4.59 ± 12%      +5.5       10.06 ±  9%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     32.38 ± 10%     +14.5       46.86 ±  8%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     37.20 ±  8%     +20.0       57.16 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     37.47 ±  8%     +20.3       57.80 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     39.04 ±  8%     +21.9       60.91 ±  5%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     39.04 ±  8%     +21.9       60.94 ±  5%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     39.04 ±  8%     +21.9       60.94 ±  5%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     39.29 ±  8%     +22.0       61.29 ±  5%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     38.93 ±  6%      -7.9       31.04 ±  8%  perf-profile.children.cycles-pp.do_syscall_64
     39.07 ±  6%      -7.9       31.19 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      8.37 ± 53%      -7.2        1.22 ± 18%  perf-profile.children.cycles-pp._raw_spin_lock
      7.19 ± 63%      -6.7        0.48 ± 24%  perf-profile.children.cycles-pp.iterate_dir
      7.19 ± 63%      -6.7        0.48 ± 23%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      7.18 ± 63%      -6.7        0.48 ± 23%  perf-profile.children.cycles-pp.dcache_readdir
      7.00 ± 64%      -6.6        0.40 ± 25%  perf-profile.children.cycles-pp.scan_positives
      7.90 ± 56%      -6.6        1.33 ± 43%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      4.42 ± 79%      -3.8        0.63 ± 24%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      3.79 ± 90%      -3.5        0.25 ± 29%  perf-profile.children.cycles-pp.osq_lock
      3.12 ± 36%      -2.5        0.62 ± 12%  perf-profile.children.cycles-pp.__libc_fork
      1.92 ± 80%      -1.6        0.36 ±  5%  perf-profile.children.cycles-pp.unlink_file_vma
      0.84 ± 13%      -0.8        0.05 ± 46%  perf-profile.children.cycles-pp.read
      2.80 ± 13%      -0.7        2.06 ±  7%  perf-profile.children.cycles-pp.path_openat
      2.81 ± 13%      -0.7        2.06 ±  7%  perf-profile.children.cycles-pp.do_filp_open
      1.36 ± 57%      -0.7        0.62 ±  8%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      2.87 ± 13%      -0.7        2.15 ±  6%  perf-profile.children.cycles-pp.do_sys_openat2
      2.87 ± 12%      -0.7        2.15 ±  6%  perf-profile.children.cycles-pp.do_sys_open
      1.31 ± 13%      -0.7        0.60 ± 12%  perf-profile.children.cycles-pp.common_file_perm
      1.33 ± 13%      -0.7        0.63 ± 12%  perf-profile.children.cycles-pp.security_file_permission
      2.61 ± 15%      -0.7        1.95 ± 15%  perf-profile.children.cycles-pp.rcu_do_batch
      2.66 ± 15%      -0.6        2.05 ± 14%  perf-profile.children.cycles-pp.rcu_core
      1.55 ± 19%      -0.5        1.04 ±  9%  perf-profile.children.cycles-pp.execve
      1.12 ± 15%      -0.5        0.61 ± 11%  perf-profile.children.cycles-pp.refill_obj_stock
      0.84 ± 22%      -0.4        0.40 ± 49%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.87 ± 21%      -0.4        0.43 ± 46%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.08 ± 18%      -0.4        0.66 ± 28%  perf-profile.children.cycles-pp.kthread
      1.10 ± 17%      -0.4        0.68 ± 12%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.89 ± 48%      -0.4        0.48 ±  9%  perf-profile.children.cycles-pp.__vma_adjust
      1.23 ± 17%      -0.4        0.84 ± 23%  perf-profile.children.cycles-pp.ret_from_fork
      0.91 ± 16%      -0.4        0.53 ±  7%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.90 ± 16%      -0.4        0.53 ±  7%  perf-profile.children.cycles-pp.page_counter_cancel
      1.00 ± 17%      -0.4        0.63 ± 14%  perf-profile.children.cycles-pp.__memcg_kmem_charge
      0.74 ± 15%      -0.3        0.41 ± 11%  perf-profile.children.cycles-pp.drain_obj_stock
      0.54 ± 52%      -0.3        0.23 ±  9%  perf-profile.children.cycles-pp.vma_link
      0.57 ± 21%      -0.3        0.27 ± 12%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.59 ± 13%      -0.3        0.32 ± 16%  perf-profile.children.cycles-pp.do_open
      0.39 ± 18%      -0.2        0.14 ±  8%  perf-profile.children.cycles-pp.lockref_put_or_lock
      0.47 ± 17%      -0.2        0.26 ±  7%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge
      0.22 ± 18%      -0.2        0.06 ± 52%  perf-profile.children.cycles-pp.apparmor_task_getsecid
      0.22 ± 18%      -0.2        0.06 ± 52%  perf-profile.children.cycles-pp.security_task_getsecid_subj
      0.31 ± 14%      -0.2        0.16 ± 17%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.34 ± 14%      -0.1        0.19 ± 16%  perf-profile.children.cycles-pp.security_file_alloc
      0.20 ± 18%      -0.1        0.05 ± 51%  perf-profile.children.cycles-pp.ima_file_check
      0.43 ± 13%      -0.1        0.29 ±  9%  perf-profile.children.cycles-pp.workingset_age_nonresident
      0.25 ± 15%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.26 ± 15%      -0.1        0.13 ±  8%  perf-profile.children.cycles-pp.__legitimize_path
      0.48 ± 15%      -0.1        0.35 ± 14%  perf-profile.children.cycles-pp.uncharge_batch
      0.27 ± 15%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.try_to_unlazy
      0.35 ± 13%      -0.1        0.22 ± 12%  perf-profile.children.cycles-pp.step_into
      0.30 ± 10%      -0.1        0.18 ± 12%  perf-profile.children.cycles-pp.task_tick_fair
      0.18 ± 18%      -0.1        0.06 ± 47%  perf-profile.children.cycles-pp.aa_get_task_label
      0.26 ± 13%      -0.1        0.14 ± 14%  perf-profile.children.cycles-pp.do_dentry_open
      0.20 ± 13%      -0.1        0.09 ± 17%  perf-profile.children.cycles-pp.security_file_open
      0.20 ± 14%      -0.1        0.08 ± 16%  perf-profile.children.cycles-pp.apparmor_file_open
      0.22 ± 13%      -0.1        0.11 ± 16%  perf-profile.children.cycles-pp.security_file_free
      0.22 ± 13%      -0.1        0.11 ± 17%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.22 ± 13%      -0.1        0.11 ±  9%  perf-profile.children.cycles-pp.terminate_walk
      0.31 ± 13%      -0.1        0.21 ±  5%  perf-profile.children.cycles-pp.lookup_fast
      0.18 ±  7%      -0.1        0.09 ± 12%  perf-profile.children.cycles-pp.update_cfs_group
      0.18 ± 15%      -0.1        0.10 ± 21%  perf-profile.children.cycles-pp.__x64_sys_kill
      0.17 ± 14%      -0.1        0.09 ± 23%  perf-profile.children.cycles-pp.kill_something_info
      0.27 ±  7%      -0.1        0.19 ± 10%  perf-profile.children.cycles-pp.__entry_text_start
      0.16 ± 17%      -0.1        0.09 ± 19%  perf-profile.children.cycles-pp.kill_pid_info
      0.13 ± 16%      -0.1        0.05 ± 48%  perf-profile.children.cycles-pp.apparmor_task_kill
      0.13 ± 16%      -0.1        0.06 ± 18%  perf-profile.children.cycles-pp.security_task_kill
      0.13 ± 18%      -0.1        0.06 ± 17%  perf-profile.children.cycles-pp.group_send_sig_info
      0.08 ±  8%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.08 ± 13%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.lockref_put_return
      0.06 ± 11%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.create_elf_tables
      0.08 ±  8%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.flush_tlb_func
      0.11 ±  8%      +0.0        0.13 ±  8%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.cpumask_next_and
      0.00            +0.1        0.07 ± 19%  perf-profile.children.cycles-pp.call_cpuidle
      0.05 ± 47%      +0.1        0.11 ± 41%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.01 ±223%      +0.1        0.08 ± 30%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      0.01 ±223%      +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.trigger_load_balance
      0.24 ± 14%      +0.1        0.31 ± 11%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.01 ±223%      +0.1        0.09 ± 32%  perf-profile.children.cycles-pp.__hrtimer_get_next_event
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.07 ± 14%      +0.1        0.15 ± 20%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.04 ± 73%      +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.24 ± 14%      +0.1        0.33 ± 11%  perf-profile.children.cycles-pp.find_busiest_group
      0.02 ±141%      +0.1        0.11 ± 29%  perf-profile.children.cycles-pp.free_pgd_range
      0.04 ± 73%      +0.1        0.13 ± 20%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.04 ± 82%      +0.1        0.14 ± 32%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.06 ± 11%      +0.1        0.16 ± 10%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.09 ± 28%      +0.1        0.20 ± 29%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.10 ± 23%      +0.1        0.20 ± 27%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.01 ±223%      +0.1        0.12 ± 43%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.05 ± 52%      +0.1        0.16 ± 12%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.01 ±223%      +0.1        0.12 ± 49%  perf-profile.children.cycles-pp.timerqueue_add
      0.11 ± 10%      +0.1        0.23 ± 11%  perf-profile.children.cycles-pp.read_tsc
      0.01 ±223%      +0.1        0.13 ± 44%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.06 ± 53%      +0.1        0.18 ± 28%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.02 ±223%      +0.1        0.15 ± 51%  perf-profile.children.cycles-pp.timerqueue_del
      0.01 ±223%      +0.1        0.14 ± 37%  perf-profile.children.cycles-pp.rcu_eqs_exit
      0.04 ±109%      +0.1        0.17 ± 36%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.04 ±109%      +0.1        0.17 ± 36%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.04 ±109%      +0.1        0.17 ± 36%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.04 ±109%      +0.1        0.17 ± 36%  perf-profile.children.cycles-pp.irq_work_run
      0.04 ±109%      +0.1        0.17 ± 36%  perf-profile.children.cycles-pp.irq_work_single
      0.04 ±109%      +0.1        0.17 ± 36%  perf-profile.children.cycles-pp.printk
      0.13 ± 28%      +0.1        0.27 ± 21%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.11 ± 16%      +0.1        0.25 ± 17%  perf-profile.children.cycles-pp.update_rq_clock
      0.10 ± 20%      +0.1        0.24 ± 18%  perf-profile.children.cycles-pp.update_blocked_averages
      0.04 ±112%      +0.1        0.18 ± 36%  perf-profile.children.cycles-pp.irq_work_run_list
      0.28 ± 15%      +0.1        0.43 ± 14%  perf-profile.children.cycles-pp.load_balance
      0.12 ± 10%      +0.1        0.26 ±  8%  perf-profile.children.cycles-pp.native_sched_clock
      0.04 ±130%      +0.2        0.20 ± 52%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.10 ± 16%      +0.2        0.26 ± 54%  perf-profile.children.cycles-pp.lru_add_drain
      0.10 ± 12%      +0.2        0.26 ± 55%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.10 ± 24%      +0.2        0.26 ± 19%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.09 ± 19%      +0.2        0.25 ± 44%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.04 ±115%      +0.2        0.20 ± 39%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.18 ± 15%      +0.2        0.35 ± 27%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.14 ± 14%      +0.2        0.31 ±  8%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.05 ± 45%      +0.2        0.25 ± 41%  perf-profile.children.cycles-pp.page_add_new_anon_rmap
      0.04 ± 72%      +0.2        0.27 ± 53%  perf-profile.children.cycles-pp.uncharge_page
      0.22 ± 29%      +0.2        0.46 ± 43%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.22 ± 20%      +0.2        0.46 ± 35%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.12 ± 53%      +0.3        0.37 ± 54%  perf-profile.children.cycles-pp.tick_irq_enter
      0.12 ± 54%      +0.3        0.39 ± 51%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.44 ± 11%      +0.3        0.71 ± 17%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.60 ± 10%      +0.3        0.92 ±  9%  perf-profile.children.cycles-pp.page_remove_rmap
      0.28 ± 10%      +0.4        0.63 ± 11%  perf-profile.children.cycles-pp.rebalance_domains
      1.26 ± 10%      +0.4        1.62 ±  7%  perf-profile.children.cycles-pp.__x64_sys_brk
      0.16 ± 15%      +0.4        0.54 ± 51%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.35 ±  9%      +0.4        0.73 ± 42%  perf-profile.children.cycles-pp.lru_cache_add
      0.46 ±  9%      +0.4        0.84 ± 26%  perf-profile.children.cycles-pp.do_anonymous_page
      0.18 ± 18%      +0.4        0.56 ± 50%  perf-profile.children.cycles-pp.__count_memcg_events
      0.14 ± 10%      +0.4        0.54 ± 38%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.22 ±  8%      +0.4        0.65 ± 41%  perf-profile.children.cycles-pp.__delete_from_page_cache
      0.14 ± 11%      +0.4        0.57 ± 47%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.31 ±  8%      +0.4        0.75 ± 36%  perf-profile.children.cycles-pp.truncate_inode_page
      0.26 ±  9%      +0.4        0.70 ± 38%  perf-profile.children.cycles-pp.delete_from_page_cache
      1.40 ± 10%      +0.5        1.85 ±  9%  perf-profile.children.cycles-pp.zap_pte_range
      0.75 ±  7%      +0.5        1.20 ±  9%  perf-profile.children.cycles-pp.scheduler_tick
      1.46 ± 10%      +0.5        1.91 ±  8%  perf-profile.children.cycles-pp.unmap_page_range
      1.52 ± 10%      +0.5        1.99 ±  8%  perf-profile.children.cycles-pp.unmap_vmas
      0.47 ± 11%      +0.5        1.00 ± 32%  perf-profile.children.cycles-pp.wp_page_copy
      0.42 ± 10%      +0.5        0.94 ± 47%  perf-profile.children.cycles-pp.__pagevec_lru_add
      0.28 ± 17%      +0.5        0.82 ± 44%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      2.45 ± 12%      +0.6        3.07 ±  6%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.66 ± 17%      +0.7        1.37 ± 36%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.69 ± 15%      +0.9        1.55 ± 32%  perf-profile.children.cycles-pp.clockevents_program_event
      1.16 ±  7%      +0.9        2.06 ± 10%  perf-profile.children.cycles-pp.update_process_times
      3.16 ± 11%      +0.9        4.06 ± 10%  perf-profile.children.cycles-pp.__handle_mm_fault
      1.18 ±  7%      +1.0        2.17 ±  8%  perf-profile.children.cycles-pp.tick_sched_handle
      1.24 ±  7%      +1.1        2.32 ±  7%  perf-profile.children.cycles-pp.tick_sched_timer
      3.70 ± 11%      +1.1        4.85 ± 11%  perf-profile.children.cycles-pp.asm_exc_page_fault
      3.31 ± 11%      +1.2        4.48 ± 12%  perf-profile.children.cycles-pp.handle_mm_fault
      3.56 ± 11%      +1.2        4.74 ± 11%  perf-profile.children.cycles-pp.do_user_addr_fault
      3.57 ± 11%      +1.2        4.75 ± 11%  perf-profile.children.cycles-pp.exc_page_fault
      1.06 ± 11%      +1.2        2.24 ± 25%  perf-profile.children.cycles-pp.menu_select
      0.83 ± 19%      +1.2        2.01 ± 25%  perf-profile.children.cycles-pp.ktime_get
      0.73 ± 15%      +1.2        1.95 ± 41%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.71 ± 16%      +1.3        2.02 ± 42%  perf-profile.children.cycles-pp.mem_cgroup_charge
      2.87 ± 11%      +1.4        4.25 ± 22%  perf-profile.children.cycles-pp.shmem_getpage_gfp
      2.60 ± 11%      +1.4        4.00 ± 24%  perf-profile.children.cycles-pp.shmem_write_begin
      1.58 ± 11%      +1.8        3.39 ± 15%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      2.57 ±  9%      +3.0        5.61 ± 10%  perf-profile.children.cycles-pp.hrtimer_interrupt
      2.60 ± 10%      +3.1        5.70 ±  9%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.39 ± 15%      +3.6        3.95 ± 51%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.59 ± 12%      +3.6        4.20 ± 47%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      5.52 ± 11%      +4.5        9.99 ±  7%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      5.86 ± 11%      +4.9       10.72 ±  7%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     32.58 ± 10%     +14.5       47.10 ±  8%  perf-profile.children.cycles-pp.intel_idle
     37.70 ±  8%     +20.4       58.12 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter_state
     37.71 ±  8%     +20.4       58.13 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter
     39.04 ±  8%     +21.9       60.94 ±  5%  perf-profile.children.cycles-pp.start_secondary
     39.29 ±  8%     +22.0       61.29 ±  5%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     39.29 ±  8%     +22.0       61.29 ±  5%  perf-profile.children.cycles-pp.cpu_startup_entry
     39.29 ±  8%     +22.0       61.29 ±  5%  perf-profile.children.cycles-pp.do_idle
      7.81 ± 56%      -6.5        1.32 ± 43%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      3.73 ± 90%      -3.5        0.25 ± 30%  perf-profile.self.cycles-pp.osq_lock
      1.23 ± 13%      -0.7        0.54 ± 12%  perf-profile.self.cycles-pp.common_file_perm
      2.15 ± 15%      -0.6        1.56 ± 17%  perf-profile.self.cycles-pp.kmem_cache_free
      0.56 ± 20%      -0.3        0.26 ± 12%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.83 ± 15%      -0.3        0.56 ± 11%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.59 ± 14%      -0.2        0.38 ±  7%  perf-profile.self.cycles-pp.page_counter_cancel
      0.41 ± 15%      -0.2        0.20 ± 15%  perf-profile.self.cycles-pp.drain_obj_stock
      0.37 ± 14%      -0.2        0.19 ± 14%  perf-profile.self.cycles-pp.refill_obj_stock
      0.30 ± 13%      -0.2        0.15 ± 17%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.42 ± 13%      -0.1        0.29 ±  9%  perf-profile.self.cycles-pp.workingset_age_nonresident
      0.18 ± 18%      -0.1        0.06 ± 47%  perf-profile.self.cycles-pp.aa_get_task_label
      0.22 ± 13%      -0.1        0.11 ± 17%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.20 ± 14%      -0.1        0.08 ± 16%  perf-profile.self.cycles-pp.apparmor_file_open
      0.14 ± 33%      -0.1        0.05 ± 45%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.18 ±  7%      -0.1        0.09 ± 12%  perf-profile.self.cycles-pp.update_cfs_group
      0.16 ± 11%      -0.1        0.09 ± 11%  perf-profile.self.cycles-pp.lockref_put_or_lock
      0.13 ± 12%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.09 ± 14%      -0.0        0.04 ± 75%  perf-profile.self.cycles-pp.update_load_avg
      0.08 ±  8%      -0.0        0.05 ±  9%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.08 ± 13%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.lockref_put_return
      0.04 ± 72%      +0.0        0.08 ± 17%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.17 ± 14%      +0.1        0.23 ±  9%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.04 ± 73%      +0.1        0.09 ± 18%  perf-profile.self.cycles-pp.update_rq_clock
      0.04 ± 73%      +0.1        0.11 ± 19%  perf-profile.self.cycles-pp.update_blocked_averages
      0.00            +0.1        0.07 ± 21%  perf-profile.self.cycles-pp.trigger_load_balance
      0.00            +0.1        0.08 ± 13%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.07 ± 14%      +0.1        0.15 ± 20%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.04 ± 73%      +0.1        0.12 ± 22%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.02 ±142%      +0.1        0.11 ± 18%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.03 ±108%      +0.1        0.13 ± 31%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.06 ± 11%      +0.1        0.16 ± 10%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.18 ± 10%      +0.1        0.28 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.03 ± 99%      +0.1        0.13 ± 41%  perf-profile.self.cycles-pp.workingset_activation
      0.01 ±223%      +0.1        0.12 ± 46%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.13 ± 28%      +0.1        0.24 ± 17%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.11 ± 14%      +0.1        0.23 ± 11%  perf-profile.self.cycles-pp.read_tsc
      0.06 ± 60%      +0.1        0.19 ± 24%  perf-profile.self.cycles-pp.do_idle
      0.11 ±  9%      +0.1        0.24 ±  8%  perf-profile.self.cycles-pp.native_sched_clock
      0.06 ± 46%      +0.1        0.19 ± 38%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.18 ± 15%      +0.2        0.35 ± 27%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.17 ± 25%      +0.2        0.36 ± 44%  perf-profile.self.cycles-pp.update_process_times
      0.04 ± 72%      +0.2        0.26 ± 53%  perf-profile.self.cycles-pp.uncharge_page
      0.44 ± 11%      +0.3        0.71 ± 17%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.18 ± 17%      +0.4        0.56 ± 50%  perf-profile.self.cycles-pp.__count_memcg_events
      0.13 ± 11%      +0.4        0.54 ± 39%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.27 ± 18%      +0.5        0.81 ± 44%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.38 ± 16%      +0.6        0.96 ±  8%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.16 ± 23%      +0.8        0.93 ± 47%  perf-profile.self.cycles-pp.mem_cgroup_charge
      0.74 ± 20%      +1.1        1.82 ± 28%  perf-profile.self.cycles-pp.ktime_get
      0.39 ± 15%      +3.5        3.94 ± 51%  perf-profile.self.cycles-pp.__mod_memcg_state
     32.58 ± 10%     +14.5       47.10 ±  8%  perf-profile.self.cycles-pp.intel_idle
      1391 ± 20%     -58.2%     581.50 ± 27%  interrupts.CPU0.NMI:Non-maskable_interrupts
      1391 ± 20%     -58.2%     581.50 ± 27%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    336.00 ±  6%     +27.5%     428.33 ±  7%  interrupts.CPU0.RES:Rescheduling_interrupts
      1149 ± 15%     -43.6%     647.83 ± 36%  interrupts.CPU1.NMI:Non-maskable_interrupts
      1149 ± 15%     -43.6%     647.83 ± 36%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
      1196 ± 16%     -58.3%     498.67 ± 30%  interrupts.CPU10.NMI:Non-maskable_interrupts
      1196 ± 16%     -58.3%     498.67 ± 30%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
      1127 ± 15%     -64.2%     403.83 ± 51%  interrupts.CPU100.NMI:Non-maskable_interrupts
      1127 ± 15%     -64.2%     403.83 ± 51%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
    303.00 ±  6%     +19.1%     360.83 ±  6%  interrupts.CPU100.RES:Rescheduling_interrupts
      1206 ± 23%     -66.0%     409.83 ± 35%  interrupts.CPU101.NMI:Non-maskable_interrupts
      1206 ± 23%     -66.0%     409.83 ± 35%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
    292.17 ±  7%     +28.8%     376.17 ±  8%  interrupts.CPU101.RES:Rescheduling_interrupts
      1060 ± 17%     -55.8%     468.50 ± 43%  interrupts.CPU102.NMI:Non-maskable_interrupts
      1060 ± 17%     -55.8%     468.50 ± 43%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
    301.17 ±  5%     +26.2%     380.00 ±  7%  interrupts.CPU102.RES:Rescheduling_interrupts
      1163 ± 20%     -58.8%     478.67 ± 23%  interrupts.CPU103.NMI:Non-maskable_interrupts
      1163 ± 20%     -58.8%     478.67 ± 23%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
    313.67 ±  5%     +23.5%     387.50 ±  4%  interrupts.CPU103.RES:Rescheduling_interrupts
      1228 ± 26%     -50.6%     606.67 ± 30%  interrupts.CPU104.NMI:Non-maskable_interrupts
      1228 ± 26%     -50.6%     606.67 ± 30%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
      1209 ± 25%     -59.7%     487.67 ± 39%  interrupts.CPU105.NMI:Non-maskable_interrupts
      1209 ± 25%     -59.7%     487.67 ± 39%  interrupts.CPU105.PMI:Performance_monitoring_interrupts
    293.00 ±  6%     +28.5%     376.50 ±  6%  interrupts.CPU105.RES:Rescheduling_interrupts
      1030 ± 30%     -56.0%     453.00 ± 32%  interrupts.CPU106.NMI:Non-maskable_interrupts
      1030 ± 30%     -56.0%     453.00 ± 32%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
    310.50 ±  5%     +21.9%     378.50 ±  4%  interrupts.CPU106.RES:Rescheduling_interrupts
    325.67 ±  6%     +19.1%     388.00 ±  6%  interrupts.CPU108.RES:Rescheduling_interrupts
      1093 ± 37%     -59.4%     443.83 ± 31%  interrupts.CPU109.NMI:Non-maskable_interrupts
      1093 ± 37%     -59.4%     443.83 ± 31%  interrupts.CPU109.PMI:Performance_monitoring_interrupts
    321.17 ±  3%     +22.3%     392.67 ±  7%  interrupts.CPU109.RES:Rescheduling_interrupts
    248.17 ±  5%     +27.7%     317.00 ± 11%  interrupts.CPU11.RES:Rescheduling_interrupts
    315.17 ±  3%     +19.1%     375.50 ±  5%  interrupts.CPU110.RES:Rescheduling_interrupts
    320.67 ±  4%     +18.7%     380.50 ±  6%  interrupts.CPU111.RES:Rescheduling_interrupts
    312.33 ±  4%     +23.9%     387.00 ±  8%  interrupts.CPU112.RES:Rescheduling_interrupts
      1448 ±  6%     -14.9%       1232 ± 12%  interrupts.CPU113.CAL:Function_call_interrupts
    304.33 ±  7%     +20.1%     365.50 ±  7%  interrupts.CPU113.RES:Rescheduling_interrupts
      1192 ± 22%     -61.2%     463.17 ± 20%  interrupts.CPU114.NMI:Non-maskable_interrupts
      1192 ± 22%     -61.2%     463.17 ± 20%  interrupts.CPU114.PMI:Performance_monitoring_interrupts
      1207 ± 25%     -52.5%     573.17 ± 19%  interrupts.CPU116.NMI:Non-maskable_interrupts
      1207 ± 25%     -52.5%     573.17 ± 19%  interrupts.CPU116.PMI:Performance_monitoring_interrupts
    329.67 ±  6%     +20.8%     398.33 ±  5%  interrupts.CPU116.RES:Rescheduling_interrupts
    304.17 ±  4%     +26.0%     383.33 ±  8%  interrupts.CPU117.RES:Rescheduling_interrupts
      1146 ± 23%     -45.6%     624.00 ± 27%  interrupts.CPU118.NMI:Non-maskable_interrupts
      1146 ± 23%     -45.6%     624.00 ± 27%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
      1145 ± 21%     -51.5%     555.67 ± 19%  interrupts.CPU119.NMI:Non-maskable_interrupts
      1145 ± 21%     -51.5%     555.67 ± 19%  interrupts.CPU119.PMI:Performance_monitoring_interrupts
    282.67 ±  4%     +30.3%     368.33 ±  9%  interrupts.CPU119.RES:Rescheduling_interrupts
      1313 ± 17%     -54.6%     596.17 ± 32%  interrupts.CPU12.NMI:Non-maskable_interrupts
      1313 ± 17%     -54.6%     596.17 ± 32%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
    276.33 ±  6%     +21.8%     336.50 ±  9%  interrupts.CPU12.RES:Rescheduling_interrupts
    310.33 ±  3%     +26.9%     393.83 ±  9%  interrupts.CPU120.RES:Rescheduling_interrupts
    315.17 ±  6%     +23.1%     388.00 ±  4%  interrupts.CPU121.RES:Rescheduling_interrupts
    314.33 ±  4%     +22.9%     386.33 ±  7%  interrupts.CPU122.RES:Rescheduling_interrupts
    299.00 ±  6%     +25.4%     375.00 ±  6%  interrupts.CPU123.RES:Rescheduling_interrupts
    313.00 ±  6%     +18.8%     372.00 ±  2%  interrupts.CPU124.RES:Rescheduling_interrupts
    290.83 ±  6%     +26.6%     368.33 ±  8%  interrupts.CPU125.RES:Rescheduling_interrupts
    305.17 ±  8%     +21.4%     370.33 ±  6%  interrupts.CPU126.RES:Rescheduling_interrupts
    290.67 ±  7%     +31.1%     381.17 ±  5%  interrupts.CPU127.RES:Rescheduling_interrupts
    293.17 ±  8%     +28.9%     378.00 ±  8%  interrupts.CPU128.RES:Rescheduling_interrupts
    305.50 ±  6%     +18.5%     362.17 ±  7%  interrupts.CPU129.RES:Rescheduling_interrupts
      1268 ± 20%     -62.3%     478.33 ± 16%  interrupts.CPU13.NMI:Non-maskable_interrupts
      1268 ± 20%     -62.3%     478.33 ± 16%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    289.00 ±  6%     +10.5%     319.33 ±  8%  interrupts.CPU13.RES:Rescheduling_interrupts
    298.83 ±  8%     +23.8%     370.00 ±  7%  interrupts.CPU130.RES:Rescheduling_interrupts
    295.17 ±  6%     +24.5%     367.50 ±  7%  interrupts.CPU131.RES:Rescheduling_interrupts
    328.17 ±  5%     +19.1%     391.00 ±  4%  interrupts.CPU132.RES:Rescheduling_interrupts
    307.83 ±  8%     +26.5%     389.50 ±  6%  interrupts.CPU133.RES:Rescheduling_interrupts
    312.67 ±  9%     +22.2%     382.17 ±  7%  interrupts.CPU134.RES:Rescheduling_interrupts
    304.83 ±  4%     +21.2%     369.50 ±  5%  interrupts.CPU135.RES:Rescheduling_interrupts
    299.83 ±  6%     +24.9%     374.50 ±  7%  interrupts.CPU136.RES:Rescheduling_interrupts
    290.50 ±  4%     +26.5%     367.50 ±  4%  interrupts.CPU137.RES:Rescheduling_interrupts
    313.17 ±  6%     +25.0%     391.50 ±  8%  interrupts.CPU139.RES:Rescheduling_interrupts
      1338 ±  9%     -62.2%     505.50 ± 22%  interrupts.CPU14.NMI:Non-maskable_interrupts
      1338 ±  9%     -62.2%     505.50 ± 22%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    975.67 ± 32%     -45.9%     527.50 ± 28%  interrupts.CPU140.NMI:Non-maskable_interrupts
    975.67 ± 32%     -45.9%     527.50 ± 28%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
    296.50 ±  9%     +27.7%     378.67 ±  7%  interrupts.CPU140.RES:Rescheduling_interrupts
    301.17 ±  7%     +26.1%     379.67 ±  4%  interrupts.CPU141.RES:Rescheduling_interrupts
    295.83 ±  4%     +22.8%     363.17 ± 10%  interrupts.CPU142.RES:Rescheduling_interrupts
    303.00 ± 11%     +29.2%     391.50 ±  6%  interrupts.CPU143.RES:Rescheduling_interrupts
    314.33 ±  5%     +20.1%     377.50 ±  6%  interrupts.CPU144.RES:Rescheduling_interrupts
    311.83 ±  8%     +20.4%     375.50 ±  3%  interrupts.CPU145.RES:Rescheduling_interrupts
    310.00 ±  4%     +21.8%     377.67 ±  7%  interrupts.CPU146.RES:Rescheduling_interrupts
    292.33 ±  8%     +30.1%     380.33 ±  4%  interrupts.CPU147.RES:Rescheduling_interrupts
    294.50 ± 12%     +22.8%     361.67 ±  7%  interrupts.CPU148.RES:Rescheduling_interrupts
    289.50 ±  8%     +28.2%     371.00 ±  5%  interrupts.CPU149.RES:Rescheduling_interrupts
      1110 ± 21%     -56.0%     488.50 ± 45%  interrupts.CPU15.NMI:Non-maskable_interrupts
      1110 ± 21%     -56.0%     488.50 ± 45%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
    306.17 ±  6%     +23.1%     376.83 ±  6%  interrupts.CPU150.RES:Rescheduling_interrupts
    310.50 ±  5%     +24.5%     386.50 ±  6%  interrupts.CPU151.RES:Rescheduling_interrupts
      1097 ± 35%     -46.5%     586.83 ± 16%  interrupts.CPU152.NMI:Non-maskable_interrupts
      1097 ± 35%     -46.5%     586.83 ± 16%  interrupts.CPU152.PMI:Performance_monitoring_interrupts
    312.50 ±  5%     +26.6%     395.50 ±  3%  interrupts.CPU152.RES:Rescheduling_interrupts
    301.17 ± 10%     +21.0%     364.50 ±  6%  interrupts.CPU153.RES:Rescheduling_interrupts
    309.67 ±  4%     +25.9%     390.00 ±  5%  interrupts.CPU154.RES:Rescheduling_interrupts
    298.67 ±  9%     +25.1%     373.50 ±  7%  interrupts.CPU155.RES:Rescheduling_interrupts
    285.00 ±  9%     +35.5%     386.17 ±  2%  interrupts.CPU156.RES:Rescheduling_interrupts
    294.33 ±  7%     +34.5%     396.00 ± 10%  interrupts.CPU157.RES:Rescheduling_interrupts
    315.83 ±  4%     +21.8%     384.83        interrupts.CPU158.RES:Rescheduling_interrupts
    292.50 ±  7%     +21.6%     355.67 ±  6%  interrupts.CPU160.RES:Rescheduling_interrupts
    304.67 ±  9%     +24.7%     379.83 ±  3%  interrupts.CPU161.RES:Rescheduling_interrupts
    278.67 ± 10%     +31.4%     366.17 ±  7%  interrupts.CPU162.RES:Rescheduling_interrupts
    312.83 ±  9%     +19.2%     373.00 ±  5%  interrupts.CPU163.RES:Rescheduling_interrupts
    297.33 ±  3%     +24.3%     369.67 ±  7%  interrupts.CPU164.RES:Rescheduling_interrupts
      1022 ± 40%     -48.1%     530.83 ± 23%  interrupts.CPU166.NMI:Non-maskable_interrupts
      1022 ± 40%     -48.1%     530.83 ± 23%  interrupts.CPU166.PMI:Performance_monitoring_interrupts
    295.67 ±  9%     +23.2%     364.33 ±  3%  interrupts.CPU166.RES:Rescheduling_interrupts
    303.67 ±  8%     +24.1%     377.00 ± 10%  interrupts.CPU167.RES:Rescheduling_interrupts
    319.00 ±  7%     +20.4%     384.17 ±  5%  interrupts.CPU168.RES:Rescheduling_interrupts
    319.00 ± 10%     +18.1%     376.83 ±  6%  interrupts.CPU169.RES:Rescheduling_interrupts
      1067 ± 19%     -58.6%     442.17 ± 29%  interrupts.CPU17.NMI:Non-maskable_interrupts
      1067 ± 19%     -58.6%     442.17 ± 29%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
    293.17 ±  5%     +21.5%     356.33 ±  8%  interrupts.CPU170.RES:Rescheduling_interrupts
    301.33 ±  7%     +21.3%     365.50 ±  6%  interrupts.CPU171.RES:Rescheduling_interrupts
    962.17 ± 35%     -39.3%     584.50 ± 22%  interrupts.CPU172.NMI:Non-maskable_interrupts
    962.17 ± 35%     -39.3%     584.50 ± 22%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
    292.33 ±  8%     +29.2%     377.83 ±  6%  interrupts.CPU172.RES:Rescheduling_interrupts
    303.50 ±  9%     +19.7%     363.33 ±  4%  interrupts.CPU173.RES:Rescheduling_interrupts
    286.67 ±  7%     +22.5%     351.17 ±  4%  interrupts.CPU174.RES:Rescheduling_interrupts
      1050 ± 27%     -41.7%     612.00 ± 32%  interrupts.CPU175.NMI:Non-maskable_interrupts
      1050 ± 27%     -41.7%     612.00 ± 32%  interrupts.CPU175.PMI:Performance_monitoring_interrupts
    307.17 ±  5%     +19.4%     366.67 ±  5%  interrupts.CPU175.RES:Rescheduling_interrupts
    316.00 ±  7%     +13.6%     359.00 ±  3%  interrupts.CPU176.RES:Rescheduling_interrupts
      1088 ± 27%     -40.4%     648.33 ± 22%  interrupts.CPU178.NMI:Non-maskable_interrupts
      1088 ± 27%     -40.4%     648.33 ± 22%  interrupts.CPU178.PMI:Performance_monitoring_interrupts
    280.17 ±  3%     +25.8%     352.33 ±  8%  interrupts.CPU178.RES:Rescheduling_interrupts
    303.83 ±  5%     +18.0%     358.50 ±  5%  interrupts.CPU179.RES:Rescheduling_interrupts
      1153 ± 21%     -55.6%     512.00 ± 37%  interrupts.CPU18.NMI:Non-maskable_interrupts
      1153 ± 21%     -55.6%     512.00 ± 37%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
    294.33 ±  3%     +25.7%     369.83 ±  7%  interrupts.CPU183.RES:Rescheduling_interrupts
      1011 ± 42%     -46.9%     536.50 ± 17%  interrupts.CPU184.NMI:Non-maskable_interrupts
      1011 ± 42%     -46.9%     536.50 ± 17%  interrupts.CPU184.PMI:Performance_monitoring_interrupts
    293.50 ±  8%     +19.3%     350.17 ±  7%  interrupts.CPU184.RES:Rescheduling_interrupts
    303.67 ±  6%     +14.5%     347.67 ±  6%  interrupts.CPU185.RES:Rescheduling_interrupts
    322.33 ±  5%     +18.5%     382.00 ±  4%  interrupts.CPU186.RES:Rescheduling_interrupts
    304.00 ± 10%     +26.8%     385.50 ±  4%  interrupts.CPU187.RES:Rescheduling_interrupts
      1010 ± 37%     -44.2%     563.33 ± 15%  interrupts.CPU188.NMI:Non-maskable_interrupts
      1010 ± 37%     -44.2%     563.33 ± 15%  interrupts.CPU188.PMI:Performance_monitoring_interrupts
    291.00 ±  7%     +20.2%     349.83 ±  8%  interrupts.CPU188.RES:Rescheduling_interrupts
    273.50 ±  4%     +25.9%     344.33 ±  7%  interrupts.CPU189.RES:Rescheduling_interrupts
    293.83 ±  7%     +25.1%     367.50 ± 13%  interrupts.CPU190.RES:Rescheduling_interrupts
    283.17 ±  9%     +26.5%     358.33 ±  8%  interrupts.CPU191.RES:Rescheduling_interrupts
      1145 ± 35%     -53.1%     537.33 ± 47%  interrupts.CPU2.NMI:Non-maskable_interrupts
      1145 ± 35%     -53.1%     537.33 ± 47%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
      1146 ± 23%     -55.1%     514.33 ± 24%  interrupts.CPU20.NMI:Non-maskable_interrupts
      1146 ± 23%     -55.1%     514.33 ± 24%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
      1142 ± 17%     -54.0%     525.50 ± 35%  interrupts.CPU21.NMI:Non-maskable_interrupts
      1142 ± 17%     -54.0%     525.50 ± 35%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
      1166 ± 25%     -49.0%     594.67 ± 27%  interrupts.CPU22.NMI:Non-maskable_interrupts
      1166 ± 25%     -49.0%     594.67 ± 27%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
    256.17 ±  5%     +20.0%     307.33 ±  4%  interrupts.CPU22.RES:Rescheduling_interrupts
      1210 ± 24%     -55.7%     536.00 ± 45%  interrupts.CPU23.NMI:Non-maskable_interrupts
      1210 ± 24%     -55.7%     536.00 ± 45%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
    267.17 ±  6%     +24.8%     333.50 ±  7%  interrupts.CPU24.RES:Rescheduling_interrupts
    277.17 ±  4%     +12.4%     311.67 ±  4%  interrupts.CPU25.RES:Rescheduling_interrupts
    255.17 ± 10%     +26.6%     323.00 ±  4%  interrupts.CPU28.RES:Rescheduling_interrupts
    244.50 ±  8%     +21.1%     296.00 ±  8%  interrupts.CPU29.RES:Rescheduling_interrupts
      1088 ± 25%     -42.7%     624.00 ± 33%  interrupts.CPU3.NMI:Non-maskable_interrupts
      1088 ± 25%     -42.7%     624.00 ± 33%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    990.17 ± 20%     -45.7%     537.50 ± 48%  interrupts.CPU30.NMI:Non-maskable_interrupts
    990.17 ± 20%     -45.7%     537.50 ± 48%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
    971.67 ± 28%     -48.2%     503.67 ± 43%  interrupts.CPU31.NMI:Non-maskable_interrupts
    971.67 ± 28%     -48.2%     503.67 ± 43%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
      1109 ± 24%     -61.0%     433.00 ± 38%  interrupts.CPU32.NMI:Non-maskable_interrupts
      1109 ± 24%     -61.0%     433.00 ± 38%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
      1217 ± 10%     -58.3%     507.83 ± 47%  interrupts.CPU33.NMI:Non-maskable_interrupts
      1217 ± 10%     -58.3%     507.83 ± 47%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
    252.83 ±  7%     +22.1%     308.83 ±  9%  interrupts.CPU33.RES:Rescheduling_interrupts
      1046 ± 15%     -42.7%     599.50 ± 32%  interrupts.CPU34.NMI:Non-maskable_interrupts
      1046 ± 15%     -42.7%     599.50 ± 32%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
      1023 ± 18%     -52.4%     486.83 ± 43%  interrupts.CPU35.NMI:Non-maskable_interrupts
      1023 ± 18%     -52.4%     486.83 ± 43%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
    258.50 ±  4%     +17.3%     303.17 ±  5%  interrupts.CPU35.RES:Rescheduling_interrupts
    251.33 ± 11%     +23.7%     310.83 ±  5%  interrupts.CPU36.RES:Rescheduling_interrupts
    953.17 ± 18%     -49.3%     483.67 ± 27%  interrupts.CPU39.NMI:Non-maskable_interrupts
    953.17 ± 18%     -49.3%     483.67 ± 27%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
      1202 ±  8%     -56.8%     519.00 ± 25%  interrupts.CPU4.NMI:Non-maskable_interrupts
      1202 ±  8%     -56.8%     519.00 ± 25%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    860.33 ± 35%     -46.9%     456.50 ± 37%  interrupts.CPU41.NMI:Non-maskable_interrupts
    860.33 ± 35%     -46.9%     456.50 ± 37%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    268.67 ±  9%     +19.3%     320.50 ±  9%  interrupts.CPU42.RES:Rescheduling_interrupts
    978.67 ± 23%     -47.3%     515.67 ± 40%  interrupts.CPU43.NMI:Non-maskable_interrupts
    978.67 ± 23%     -47.3%     515.67 ± 40%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
    248.67 ±  7%     +20.4%     299.33 ±  6%  interrupts.CPU43.RES:Rescheduling_interrupts
    921.17 ± 29%     -50.5%     456.00 ± 35%  interrupts.CPU44.NMI:Non-maskable_interrupts
    921.17 ± 29%     -50.5%     456.00 ± 35%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
    937.33 ± 28%     -44.4%     521.17 ± 37%  interrupts.CPU45.NMI:Non-maskable_interrupts
    937.33 ± 28%     -44.4%     521.17 ± 37%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
    260.50 ±  4%     +15.8%     301.67 ±  7%  interrupts.CPU45.RES:Rescheduling_interrupts
    253.17 ±  9%     +17.9%     298.50 ±  6%  interrupts.CPU46.RES:Rescheduling_interrupts
    993.00 ± 27%     -47.8%     518.67 ± 19%  interrupts.CPU48.NMI:Non-maskable_interrupts
    993.00 ± 27%     -47.8%     518.67 ± 19%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
    300.17 ±  6%     +12.3%     337.17 ±  3%  interrupts.CPU48.RES:Rescheduling_interrupts
    272.67 ±  5%     +21.5%     331.33 ±  6%  interrupts.CPU49.RES:Rescheduling_interrupts
      1302 ± 15%     -57.8%     550.17 ± 54%  interrupts.CPU5.NMI:Non-maskable_interrupts
      1302 ± 15%     -57.8%     550.17 ± 54%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
      1154 ± 11%     -45.1%     634.00 ± 38%  interrupts.CPU50.NMI:Non-maskable_interrupts
      1154 ± 11%     -45.1%     634.00 ± 38%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
      1280 ± 17%     -53.0%     602.33 ± 32%  interrupts.CPU51.NMI:Non-maskable_interrupts
      1280 ± 17%     -53.0%     602.33 ± 32%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
      1248 ± 12%     -51.6%     603.67 ± 33%  interrupts.CPU52.NMI:Non-maskable_interrupts
      1248 ± 12%     -51.6%     603.67 ± 33%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
    254.00 ±  5%     +18.0%     299.83 ±  9%  interrupts.CPU52.RES:Rescheduling_interrupts
      1288 ± 19%     -60.9%     503.17 ± 31%  interrupts.CPU53.NMI:Non-maskable_interrupts
      1288 ± 19%     -60.9%     503.17 ± 31%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
    247.17 ±  6%     +16.5%     288.00 ±  5%  interrupts.CPU53.RES:Rescheduling_interrupts
      1201 ±  6%     -44.0%     672.83 ± 25%  interrupts.CPU54.NMI:Non-maskable_interrupts
      1201 ±  6%     -44.0%     672.83 ± 25%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
      1200 ± 20%     -53.3%     560.50 ± 49%  interrupts.CPU55.NMI:Non-maskable_interrupts
      1200 ± 20%     -53.3%     560.50 ± 49%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
    254.50 ±  8%     +16.0%     295.17 ± 11%  interrupts.CPU55.RES:Rescheduling_interrupts
      1116 ± 26%     -61.0%     435.67 ± 30%  interrupts.CPU56.NMI:Non-maskable_interrupts
      1116 ± 26%     -61.0%     435.67 ± 30%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
    264.33 ±  6%     +15.1%     304.17 ±  3%  interrupts.CPU56.RES:Rescheduling_interrupts
    249.67 ±  9%     +17.8%     294.17 ±  6%  interrupts.CPU57.RES:Rescheduling_interrupts
     89.00 ± 14%     -19.5%      71.67 ± 13%  interrupts.CPU58.TLB:TLB_shootdowns
      1059 ±  5%     -56.8%     457.67 ± 43%  interrupts.CPU59.NMI:Non-maskable_interrupts
      1059 ±  5%     -56.8%     457.67 ± 43%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
      1659 ± 18%     -25.2%       1242 ± 12%  interrupts.CPU6.CAL:Function_call_interrupts
      1172 ±  3%     -53.4%     546.33 ± 27%  interrupts.CPU6.NMI:Non-maskable_interrupts
      1172 ±  3%     -53.4%     546.33 ± 27%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
      1107 ± 17%     -46.9%     588.00 ± 31%  interrupts.CPU60.NMI:Non-maskable_interrupts
      1107 ± 17%     -46.9%     588.00 ± 31%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
    238.33 ±  6%     +22.7%     292.50 ±  9%  interrupts.CPU60.RES:Rescheduling_interrupts
      1075 ± 19%     -49.3%     545.00 ± 10%  interrupts.CPU61.NMI:Non-maskable_interrupts
      1075 ± 19%     -49.3%     545.00 ± 10%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
    257.83 ±  7%     +21.4%     313.00 ± 10%  interrupts.CPU61.RES:Rescheduling_interrupts
      1148 ± 14%     -58.6%     475.33 ± 47%  interrupts.CPU62.NMI:Non-maskable_interrupts
      1148 ± 14%     -58.6%     475.33 ± 47%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
      1113 ± 16%     -51.4%     541.00 ± 62%  interrupts.CPU63.NMI:Non-maskable_interrupts
      1113 ± 16%     -51.4%     541.00 ± 62%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
      1061 ± 15%     -48.1%     551.00 ± 35%  interrupts.CPU64.NMI:Non-maskable_interrupts
      1061 ± 15%     -48.1%     551.00 ± 35%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
    252.50 ±  5%     +19.5%     301.83 ±  5%  interrupts.CPU64.RES:Rescheduling_interrupts
    257.83 ±  9%     +14.5%     295.17 ±  4%  interrupts.CPU65.RES:Rescheduling_interrupts
    250.00 ±  5%     +19.5%     298.83 ±  5%  interrupts.CPU66.RES:Rescheduling_interrupts
      1171 ± 24%     -51.7%     565.67 ± 35%  interrupts.CPU67.NMI:Non-maskable_interrupts
      1171 ± 24%     -51.7%     565.67 ± 35%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
    238.83 ±  7%     +25.5%     299.83 ±  4%  interrupts.CPU67.RES:Rescheduling_interrupts
      1134 ± 19%     -52.2%     542.50 ± 33%  interrupts.CPU68.NMI:Non-maskable_interrupts
      1134 ± 19%     -52.2%     542.50 ± 33%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
      1180 ± 11%     -56.5%     513.67 ± 26%  interrupts.CPU69.NMI:Non-maskable_interrupts
      1180 ± 11%     -56.5%     513.67 ± 26%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
    235.67 ±  9%     +29.0%     304.00 ±  8%  interrupts.CPU69.RES:Rescheduling_interrupts
      1224 ± 21%     -63.3%     449.17 ± 23%  interrupts.CPU7.NMI:Non-maskable_interrupts
      1224 ± 21%     -63.3%     449.17 ± 23%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
    258.17 ±  6%     +29.7%     334.83 ± 12%  interrupts.CPU7.RES:Rescheduling_interrupts
      1201 ± 14%     -52.6%     569.67 ± 25%  interrupts.CPU70.NMI:Non-maskable_interrupts
      1201 ± 14%     -52.6%     569.67 ± 25%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
    252.83 ±  5%     +19.4%     302.00 ±  7%  interrupts.CPU70.RES:Rescheduling_interrupts
      1273 ± 20%     -60.5%     503.17 ± 35%  interrupts.CPU71.NMI:Non-maskable_interrupts
      1273 ± 20%     -60.5%     503.17 ± 35%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
      1347 ± 13%     -57.2%     577.00 ± 33%  interrupts.CPU72.NMI:Non-maskable_interrupts
      1347 ± 13%     -57.2%     577.00 ± 33%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
    283.00 ±  6%     +20.7%     341.67 ± 12%  interrupts.CPU72.RES:Rescheduling_interrupts
    276.83 ±  3%     +14.2%     316.17 ±  5%  interrupts.CPU73.RES:Rescheduling_interrupts
      1197 ± 18%     -55.4%     534.33 ± 25%  interrupts.CPU74.NMI:Non-maskable_interrupts
      1197 ± 18%     -55.4%     534.33 ± 25%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
    279.33 ±  5%     +13.2%     316.17 ±  5%  interrupts.CPU74.RES:Rescheduling_interrupts
      1075 ± 26%     -48.5%     553.67 ± 53%  interrupts.CPU76.NMI:Non-maskable_interrupts
      1075 ± 26%     -48.5%     553.67 ± 53%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
    997.17 ± 23%     -48.8%     510.67 ± 42%  interrupts.CPU77.NMI:Non-maskable_interrupts
    997.17 ± 23%     -48.8%     510.67 ± 42%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
      1259 ± 10%     -50.8%     620.00 ± 36%  interrupts.CPU78.NMI:Non-maskable_interrupts
      1259 ± 10%     -50.8%     620.00 ± 36%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
    243.50 ±  6%     +19.9%     292.00 ±  8%  interrupts.CPU78.RES:Rescheduling_interrupts
      1204 ± 13%     -59.0%     494.50 ± 33%  interrupts.CPU79.NMI:Non-maskable_interrupts
      1204 ± 13%     -59.0%     494.50 ± 33%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
    253.33 ±  6%     +17.1%     296.67 ±  6%  interrupts.CPU79.RES:Rescheduling_interrupts
      1211 ± 19%     -50.9%     595.33 ± 34%  interrupts.CPU8.NMI:Non-maskable_interrupts
      1211 ± 19%     -50.9%     595.33 ± 34%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    273.17 ±  4%     +17.6%     321.33 ±  5%  interrupts.CPU8.RES:Rescheduling_interrupts
      1152 ± 19%     -56.4%     501.83 ± 39%  interrupts.CPU80.NMI:Non-maskable_interrupts
      1152 ± 19%     -56.4%     501.83 ± 39%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
    261.67 ±  6%     +12.1%     293.33 ±  5%  interrupts.CPU80.RES:Rescheduling_interrupts
      1254 ±  7%     -58.2%     524.33 ± 37%  interrupts.CPU81.NMI:Non-maskable_interrupts
      1254 ±  7%     -58.2%     524.33 ± 37%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
      1302 ±  9%     -64.4%     463.83 ± 24%  interrupts.CPU82.NMI:Non-maskable_interrupts
      1302 ±  9%     -64.4%     463.83 ± 24%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
    246.00 ±  5%     +16.5%     286.50 ±  7%  interrupts.CPU82.RES:Rescheduling_interrupts
      1233 ± 15%     -53.8%     569.83 ± 34%  interrupts.CPU83.NMI:Non-maskable_interrupts
      1233 ± 15%     -53.8%     569.83 ± 34%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
      1246 ± 22%     -58.7%     514.83 ± 61%  interrupts.CPU84.NMI:Non-maskable_interrupts
      1246 ± 22%     -58.7%     514.83 ± 61%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
      1263 ± 21%     -53.2%     591.00 ± 27%  interrupts.CPU85.NMI:Non-maskable_interrupts
      1263 ± 21%     -53.2%     591.00 ± 27%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
      1297 ± 15%     -63.6%     471.83 ± 37%  interrupts.CPU86.NMI:Non-maskable_interrupts
      1297 ± 15%     -63.6%     471.83 ± 37%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
      1262 ± 12%     -63.1%     465.83 ± 40%  interrupts.CPU87.NMI:Non-maskable_interrupts
      1262 ± 12%     -63.1%     465.83 ± 40%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
      1251 ± 14%     -57.0%     537.33 ± 35%  interrupts.CPU88.NMI:Non-maskable_interrupts
      1251 ± 14%     -57.0%     537.33 ± 35%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
      1152 ± 17%     -54.5%     524.67 ± 44%  interrupts.CPU89.NMI:Non-maskable_interrupts
      1152 ± 17%     -54.5%     524.67 ± 44%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
      1335 ± 15%     -57.7%     564.83 ± 30%  interrupts.CPU9.NMI:Non-maskable_interrupts
      1335 ± 15%     -57.7%     564.83 ± 30%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
      1241 ± 19%     -51.2%     605.17 ± 46%  interrupts.CPU90.NMI:Non-maskable_interrupts
      1241 ± 19%     -51.2%     605.17 ± 46%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
      1226 ± 21%     -56.2%     537.33 ± 39%  interrupts.CPU91.NMI:Non-maskable_interrupts
      1226 ± 21%     -56.2%     537.33 ± 39%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
    245.33 ±  7%     +20.9%     296.50 ±  7%  interrupts.CPU91.RES:Rescheduling_interrupts
      1188 ± 11%     -50.0%     594.33 ± 37%  interrupts.CPU93.NMI:Non-maskable_interrupts
      1188 ± 11%     -50.0%     594.33 ± 37%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
      1177 ± 17%     -45.6%     640.17 ± 33%  interrupts.CPU94.NMI:Non-maskable_interrupts
      1177 ± 17%     -45.6%     640.17 ± 33%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
    236.50 ± 11%     +20.7%     285.50 ±  7%  interrupts.CPU94.RES:Rescheduling_interrupts
    241.67 ±  3%     +37.2%     331.67 ± 18%  interrupts.CPU95.RES:Rescheduling_interrupts
      1223 ± 25%     -60.3%     486.17 ± 26%  interrupts.CPU96.NMI:Non-maskable_interrupts
      1223 ± 25%     -60.3%     486.17 ± 26%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
    313.00 ±  6%     +28.7%     402.83 ±  7%  interrupts.CPU96.RES:Rescheduling_interrupts
      1155 ± 20%     -53.7%     535.17 ± 53%  interrupts.CPU97.NMI:Non-maskable_interrupts
      1155 ± 20%     -53.7%     535.17 ± 53%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
    313.50 ± 11%     +22.0%     382.50 ±  7%  interrupts.CPU97.RES:Rescheduling_interrupts
    299.17 ±  4%     +27.4%     381.00 ±  9%  interrupts.CPU98.RES:Rescheduling_interrupts
      1190 ± 19%     -61.6%     457.17 ± 32%  interrupts.CPU99.NMI:Non-maskable_interrupts
      1190 ± 19%     -61.6%     457.17 ± 32%  interrupts.CPU99.PMI:Performance_monitoring_interrupts
    303.50 ±  8%     +28.9%     391.33 ±  9%  interrupts.CPU99.RES:Rescheduling_interrupts
    204424 ±  8%     -45.2%     112016 ±  9%  interrupts.NMI:Non-maskable_interrupts
    204424 ±  8%     -45.2%     112016 ±  9%  interrupts.PMI:Performance_monitoring_interrupts
     54352           +20.3%      65372 ±  3%  interrupts.RES:Rescheduling_interrupts





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.12.0-11208-g2d146aa3aa84"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.12.0 Kernel Configuration
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
# CONFIG_DRIVER_PE_KUNIT_TEST is not set
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
# CONFIG_SPI_ALTERA_CORE is not set
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
CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS=y
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

CONFIG_ASN1_ENCODER=y

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
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='vm-scalability'
	export testcase='vm-scalability'
	export category='benchmark'
	export runtime=300
	export size=
	export job_origin='vm-scalability.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2ap4'
	export tbox_group='lkp-csl-2ap4'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='6097b949c97353c66230ca88'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap4/vm-scalability-performance-300s-lru-file-mmap-read-rand-ucode=0x5003006-monitor=6cca9a40-debian-10.4-x86_64-20200603.cgz-2d146aa-20210509-50786-4uq75e-5.yaml'
	export id='3f42a2c33d69603fac8a498ce1efc281c1d29e64'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=4
	export nr_cpu=192
	export memory='192G'
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF87091000G1P6IGN-*-part1'
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export kernel_cmdline_hw='acpi_rsdp=0x67f44014'
	export brand='Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz'
	export need_kconfig='CONFIG_BLK_DEV_LOOP'
	export commit='2d146aa3aa842d7f5065802556b4f9a2c6e8ef12'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_BLK_DEV_NVME'
	export ucode='0x5003006'
	export enqueue_time='2021-05-09 18:28:25 +0800'
	export _id='6097b94dc97353c66230ca8a'
	export _rt='/result/vm-scalability/performance-300s-lru-file-mmap-read-rand-ucode=0x5003006-monitor=6cca9a40/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2d146aa3aa842d7f5065802556b4f9a2c6e8ef12'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='90eb2bd1092e371996f15a7b88ac7b2029c3fd2b'
	export base_commit='9f4ad9e425a1d3b6a34617b8ea226d56a119a717'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='6cca9a40'
	export result_root='/result/vm-scalability/performance-300s-lru-file-mmap-read-rand-ucode=0x5003006-monitor=6cca9a40/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2d146aa3aa842d7f5065802556b4f9a2c6e8ef12/3'
	export scheduler_version='/lkp/lkp/.src-20210506-110429'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2ap4/vm-scalability-performance-300s-lru-file-mmap-read-rand-ucode=0x5003006-monitor=6cca9a40-debian-10.4-x86_64-20200603.cgz-2d146aa-20210509-50786-4uq75e-5.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=2d146aa3aa842d7f5065802556b4f9a2c6e8ef12
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/2d146aa3aa842d7f5065802556b4f9a2c6e8ef12/vmlinuz-5.12.0-11208-g2d146aa3aa84
acpi_rsdp=0x67f44014
max_uptime=2100
RESULT_ROOT=/result/vm-scalability/performance-300s-lru-file-mmap-read-rand-ucode=0x5003006-monitor=6cca9a40/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2d146aa3aa842d7f5065802556b4f9a2c6e8ef12/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/2d146aa3aa842d7f5065802556b4f9a2c6e8ef12/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-a48b0872e694-1_20210507.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/vm-scalability_20210507.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/vm-scalability-x86_64-1.0-0_20210507.cgz,/osimage/pkg/common/vm-scalability-x86_64.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.12.0'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/2d146aa3aa842d7f5065802556b4f9a2c6e8ef12/vmlinuz-5.12.0-11208-g2d146aa3aa84'
	export dequeue_time='2021-05-09 18:31:07 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap4/vm-scalability-performance-300s-lru-file-mmap-read-rand-ucode=0x5003006-monitor=6cca9a40-debian-10.4-x86_64-20200603.cgz-2d146aa-20210509-50786-4uq75e-5.cgz'

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
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='lru-file-mmap-read-rand' $LKP_SRC/tests/wrapper vm-scalability
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper perf-profile
	env test='lru-file-mmap-read-rand' $LKP_SRC/stats/wrapper vm-scalability
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

	$LKP_SRC/stats/wrapper time vm-scalability.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/vm-scalability.yaml
suite: vm-scalability
testcase: vm-scalability
category: benchmark
perf-profile: 
runtime: 300s
size: 
vm-scalability:
  test: lru-file-mmap-read-rand
job_origin: vm-scalability.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2ap4
tbox_group: lkp-csl-2ap4
kconfig: x86_64-rhel-8.3
submit_id: 609796996c85a7d58ea50699
job_file: "/lkp/jobs/scheduled/lkp-csl-2ap4/vm-scalability-performance-300s-lru-file-mmap-read-rand-ucode=0x5003006-monitor=6cca9a40-debian-10.4-x86_64-20200603.cgz-2d146aa-20210509-54670-tw5fjr-2.yaml"
id: fcec8bc47d95a31cab4fabcc8c1d4345697f002e
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
turbostat: 
sched_debug: 
perf-stat: 
mpstat: 

#! include/category/ALL
cpufreq_governor: performance

#! include/vm-scalability
need_kconfig: CONFIG_BLK_DEV_LOOP

#! include/queue/cyclic
commit: 2d146aa3aa842d7f5065802556b4f9a2c6e8ef12

#! include/testbox/lkp-csl-2ap4
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_BLK_DEV_NVME
ucode: '0x5003006'
enqueue_time: 2021-05-09 16:00:25.300182700 +08:00
_id: 6097996c6c85a7d58ea5069b
_rt: "/result/vm-scalability/performance-300s-lru-file-mmap-read-rand-ucode=0x5003006-monitor=6cca9a40/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2d146aa3aa842d7f5065802556b4f9a2c6e8ef12"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 90eb2bd1092e371996f15a7b88ac7b2029c3fd2b
base_commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
branch: linux-devel/devel-hourly-20210509-000432
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 6cca9a40
result_root: "/result/vm-scalability/performance-300s-lru-file-mmap-read-rand-ucode=0x5003006-monitor=6cca9a40/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2d146aa3aa842d7f5065802556b4f9a2c6e8ef12/0"
scheduler_version: "/lkp/lkp/.src-20210506-110429"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2ap4/vm-scalability-performance-300s-lru-file-mmap-read-rand-ucode=0x5003006-monitor=6cca9a40-debian-10.4-x86_64-20200603.cgz-2d146aa-20210509-54670-tw5fjr-2.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210509-000432
- commit=2d146aa3aa842d7f5065802556b4f9a2c6e8ef12
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/2d146aa3aa842d7f5065802556b4f9a2c6e8ef12/vmlinuz-5.12.0-11208-g2d146aa3aa84
- acpi_rsdp=0x67f44014
- max_uptime=2100
- RESULT_ROOT=/result/vm-scalability/performance-300s-lru-file-mmap-read-rand-ucode=0x5003006-monitor=6cca9a40/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2d146aa3aa842d7f5065802556b4f9a2c6e8ef12/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/2d146aa3aa842d7f5065802556b4f9a2c6e8ef12/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-a48b0872e694-1_20210507.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/vm-scalability_20210507.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/vm-scalability-x86_64-1.0-0_20210507.cgz,/osimage/pkg/common/vm-scalability-x86_64.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210506-110429/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.12.0-AA-17417-gbc4ad03d6e04
repeat_to: 3

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/2d146aa3aa842d7f5065802556b4f9a2c6e8ef12/vmlinuz-5.12.0-11208-g2d146aa3aa84"
dequeue_time: 2021-05-09 16:12:58.829256062 +08:00
job_state: finished
loadavg: 33.95 90.89 51.53 1/1352 15700
start_time: '1620548046'
end_time: '1620548433'
version: "/lkp/lkp/.src-20210506-110504:c8d5f8a8:89926580f"

--XuV1QlJbYrcVoo+x
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
 truncate -s 202460282880 /tmp/vm-scalability-tmp/vm-scalability.img
 mkfs.xfs -q /tmp/vm-scalability-tmp/vm-scalability.img
 mount -o loop /tmp/vm-scalability-tmp/vm-scalability.img /tmp/vm-scalability-tmp/vm-scalability
 ./case-lru-file-mmap-read-rand
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-1 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-1 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-2 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-2 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-3 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-3 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-4 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-4 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-5 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-5 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-6 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-6 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-7 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-7 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-8 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-8 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-9 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-9 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-10 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-10 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-11 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-11 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-12 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-12 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-13 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-13 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-14 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-14 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-15 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-15 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-16 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-16 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-17 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-17 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-18 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-18 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-19 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-19 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-20 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-20 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-21 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-21 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-22 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-22 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-23 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-23 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-24 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-24 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-25 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-25 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-26 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-26 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-27 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-28 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-27 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-28 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-29 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-29 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-30 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-30 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-31 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-31 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-32 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-32 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-33 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-34 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-33 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-34 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-35 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-36 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-35 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-37 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-36 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-37 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-38 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-38 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-39 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-39 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-40 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-41 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-40 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-41 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-42 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-42 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-43 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-43 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-44 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-44 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-45 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-46 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-45 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-46 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-47 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-47 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-48 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-49 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-48 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-50 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-49 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-51 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-50 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-51 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-52 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-52 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-53 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-53 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-54 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-54 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-55 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-55 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-56 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-56 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-57 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-57 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-58 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-58 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-59 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-59 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-60 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-60 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-61 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-61 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-62 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-62 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-63 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-63 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-64 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-65 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-64 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-65 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-66 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-67 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-66 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-67 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-68 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-69 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-68 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-70 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-69 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-71 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-71 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-70 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-72 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-73 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-72 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-73 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-74 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-74 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-75 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-75 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-76 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-77 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-76 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-77 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-78 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-79 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-78 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-80 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-79 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-80 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-81 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-82 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-81 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-82 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-83 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-83 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-84 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-84 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-85 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-85 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-86 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-86 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-87 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-88 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-87 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-89 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-88 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-89 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-90 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-90 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-91 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-91 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-92 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-92 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-93 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-93 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-94 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-95 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-94 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-95 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-96 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-96 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-97 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-97 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-98 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-98 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-99 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-99 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-100 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-100 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-101 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-101 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-102 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-102 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-103 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-103 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-104 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-104 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-105 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-105 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-106 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-106 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-107 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-107 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-108 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-108 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-109 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-109 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-110 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-110 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-111 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-111 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-112 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-112 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-113 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-113 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-114 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-114 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-115 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-115 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-116 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-116 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-117 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-117 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-118 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-118 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-119 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-119 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-120 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-121 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-120 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-121 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-122 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-123 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-122 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-123 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-124 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-124 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-125 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-125 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-126 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-126 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-127 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-127 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-128 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-128 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-129 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-129 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-130 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-130 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-131 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-131 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-132 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-132 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-133 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-133 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-134 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-134 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-135 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-135 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-136 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-136 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-137 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-137 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-138 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-138 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-139 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-139 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-140 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-140 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-141 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-142 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-141 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-143 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-142 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-144 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-143 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-145 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-144 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-145 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-146 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-146 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-147 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-147 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-148 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-148 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-149 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-149 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-150 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-150 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-151 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-151 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-152 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-152 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-153 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-153 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-154 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-154 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-155 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-156 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-155 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-156 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-157 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-157 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-158 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-158 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-159 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-159 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-160 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-160 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-161 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-161 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-162 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-162 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-163 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-163 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-164 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-164 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-165 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-165 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-166 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-166 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-167 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-167 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-168 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-168 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-169 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-170 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-169 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-170 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-171 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-172 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-171 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-172 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-173 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-173 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-174 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-174 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-175 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-175 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-176 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-176 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-177 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-177 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-178 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-178 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-179 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-179 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-180 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-180 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-181 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-182 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-181 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-182 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-183 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-184 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-183 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-184 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-185 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-185 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-186 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-187 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-186 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-188 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-187 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-188 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-189 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-189 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-190 -s 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-191 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-190 --readonly --random 22906492245
 truncate /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-192 -s 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-191 --readonly --random 22906492245
 ./usemem --runtime 300 -f /tmp/vm-scalability-tmp/vm-scalability/sparse-lru-file-mmap-read-rand-192 --readonly --random 22906492245
 umount /tmp/vm-scalability-tmp/vm-scalability
 rm /tmp/vm-scalability-tmp/vm-scalability.img
 umount /tmp/vm-scalability-tmp

--XuV1QlJbYrcVoo+x--
