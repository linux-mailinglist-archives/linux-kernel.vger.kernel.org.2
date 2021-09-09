Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D445440589C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241114AbhIIOIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:08:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:55089 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239687AbhIIOHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:07:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="220474996"
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="yaml'?scan'208";a="220474996"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 07:06:40 -0700
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="yaml'?scan'208";a="504448389"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 07:06:35 -0700
Date:   Thu, 9 Sep 2021 22:23:55 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com
Subject: [xfs]  ab23a77687:  aim7.jobs-per-min -18.5% regression
Message-ID: <20210909142355.GA6270@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Hi Dave Chinner,

we reported "[xfs]  6df693ed7b:  aim7.jobs-per-min -15.7% regression" as [1]
when this change is still on
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git xfs-5.15-merge

now this change is on mainline.
so we report again to highlight we still observe similar performance regression
on mainline.

previously we also tried to test by turning off RWSEM_SPIN_ON_OWNER per your
guidance, but still observed similar regression, though we are not sure if our
method to turn off RWSEM_SPIN_ON_OWNER is enough. the detail result is in [2]

[1] https://lore.kernel.org/all/20210809064248.GB5761@xsang-OptiPlex-9020/
[2] https://lore.kernel.org/all/20210818085248.GA28771@xsang-OptiPlex-9020/


below is the detail report based on mainline now.


Greeting,

FYI, we noticed a -18.5% regression of aim7.jobs-per-min due to commit:


commit: ab23a7768739a23d21d8a16ca37dff96b1ca957a ("xfs: per-cpu deferred inode inactivation queues")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: aim7
on test machine: 144 threads 4 sockets Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory
with following parameters:

	disk: 1BRD_48G
	fs: xfs
	test: disk_rr
	load: 3000
	cpufreq_governor: performance
	ucode: 0x700001e

test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/

In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min -15.8% regression                                        |
| test machine     | 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory  |
| test parameters  | cpufreq_governor=performance                                                     |
|                  | disk=4BRD_12G                                                                    |
|                  | fs=xfs                                                                           |
|                  | load=3000                                                                        |
|                  | md=RAID1                                                                         |
|                  | test=disk_wrt                                                                    |
|                  | ucode=0x5003006                                                                  |
+------------------+----------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min -17.3% regression                                        |
| test machine     | 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory  |
| test parameters  | cpufreq_governor=performance                                                     |
|                  | disk=4BRD_12G                                                                    |
|                  | fs=xfs                                                                           |
|                  | load=3000                                                                        |
|                  | md=RAID0                                                                         |
|                  | test=disk_rw                                                                     |
|                  | ucode=0x5003006                                                                  |
+------------------+----------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min -15.6% regression                                        |
| test machine     | 144 threads 4 sockets Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                                     |
|                  | disk=1BRD_48G                                                                    |
|                  | fs=xfs                                                                           |
|                  | load=3000                                                                        |
|                  | test=disk_wrt                                                                    |
|                  | ucode=0x700001e                                                                  |
+------------------+----------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min -16.4% regression                                        |
| test machine     | 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory  |
| test parameters  | cpufreq_governor=performance                                                     |
|                  | disk=4BRD_12G                                                                    |
|                  | fs=xfs                                                                           |
|                  | load=3000                                                                        |
|                  | md=RAID1                                                                         |
|                  | test=disk_rw                                                                     |
|                  | ucode=0x5003006                                                                  |
+------------------+----------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min -24.6% regression                                        |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz with 256G memory  |
| test parameters  | cpufreq_governor=performance                                                     |
|                  | disk=1BRD_48G                                                                    |
|                  | fs=xfs                                                                           |
|                  | load=3000                                                                        |
|                  | test=disk_cp                                                                     |
|                  | ucode=0xd000280                                                                  |
+------------------+----------------------------------------------------------------------------------+


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
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/1BRD_48G/xfs/x86_64-rhel-8.3/3000/debian-10.4-x86_64-20200603.cgz/lkp-cpl-4sp1/disk_rr/aim7/0x700001e

commit: 
  62af7d54a0 ("xfs: detach dquots from inode if we don't need to inactivate it")
  ab23a77687 ("xfs: per-cpu deferred inode inactivation queues")

62af7d54a0ec0b6f ab23a7768739a23d21d8a16ca37 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    505013           -18.5%     411775        aim7.jobs-per-min
     35.84           +22.5%      43.92        aim7.time.elapsed_time
     35.84           +22.5%      43.92        aim7.time.elapsed_time.max
      2309 ±  4%   +1096.5%      27638 ±  3%  aim7.time.involuntary_context_switches
    163221            +2.5%     167372        aim7.time.minor_page_faults
    764.54 ±  2%     +53.2%       1171 ±  2%  aim7.time.system_time
    933519           -30.7%     646507        aim7.time.voluntary_context_switches
 4.481e+09           +17.5%  5.266e+09 ±  2%  cpuidle..time
      0.00 ± 21%    +585.7%       0.02 ±152%  perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
     84.16            -4.1%      80.67        iostat.cpu.idle
     14.98 ±  2%     +24.4%      18.64 ±  3%  iostat.cpu.system
    393.00 ±  9%     +64.2%     645.50 ± 14%  vmstat.io.bo
     51007           -15.9%      42920        vmstat.system.cs
      0.14            -0.0        0.12        mpstat.cpu.all.soft%
     14.55 ±  2%      +3.7       18.26 ±  3%  mpstat.cpu.all.sys%
      0.88 ±  2%      -0.2        0.71 ±  2%  mpstat.cpu.all.usr%
     25708 ±  3%     +23.5%      31743 ±  5%  meminfo.Active
     18692 ±  4%     +42.8%      26690 ±  4%  meminfo.Active(anon)
      7014 ±  6%     -28.0%       5053 ± 12%  meminfo.Active(file)
     69043 ±  2%     +10.6%      76336        meminfo.AnonHugePages
     40686           +19.1%      48461 ±  2%  meminfo.Shmem
    543.83           +20.8%     656.83 ±  2%  turbostat.Avg_MHz
     17.15            +3.4       20.52 ±  2%  turbostat.Busy%
      3177            +1.0%       3208        turbostat.Bzy_MHz
      0.18 ±  8%      -0.1        0.10 ± 11%  turbostat.C1%
  11622077           +21.5%   14120607        turbostat.IRQ
     41.93            -5.2%      39.74        turbostat.RAMWatt
      2046 ± 17%     -31.2%       1408 ± 16%  numa-meminfo.node0.Active(file)
      1725 ±  8%     -28.0%       1242 ± 22%  numa-meminfo.node1.Active(file)
      1548 ± 10%     -31.4%       1062 ±  9%  numa-meminfo.node2.Active(file)
    738.67 ± 43%  +95832.6%     708622 ±141%  numa-meminfo.node2.Unevictable
     16244 ± 10%     +44.7%      23513 ±  9%  numa-meminfo.node3.Active
     14671 ± 12%     +51.9%      22284 ±  9%  numa-meminfo.node3.Active(anon)
     20509 ± 17%     +30.9%      26839 ± 11%  numa-meminfo.node3.Shmem
      7880 ±  3%     +11.7%       8799 ± 10%  softirqs.CPU106.SCHED
      7158 ±  7%     +17.2%       8389 ±  9%  softirqs.CPU143.SCHED
      8764 ±  6%     +16.7%      10225 ± 14%  softirqs.CPU2.SCHED
      7684 ±  2%     +13.0%       8681 ±  9%  softirqs.CPU36.SCHED
      5562 ±  7%     +33.7%       7439 ± 19%  softirqs.CPU38.RCU
      7499 ±  7%     +17.5%       8814 ± 11%  softirqs.CPU45.SCHED
    819019 ±  3%     +17.0%     958541        softirqs.RCU
      6951 ±  6%     +12.3%       7805 ±  6%  slabinfo.files_cache.active_objs
      6951 ±  6%     +12.3%       7805 ±  6%  slabinfo.files_cache.num_objs
      1265           +19.3%       1509        slabinfo.kmalloc-8k.active_objs
      1268           +20.1%       1523        slabinfo.kmalloc-8k.num_objs
      3558           +14.4%       4071 ±  2%  slabinfo.xfs_buf.active_objs
      3558           +14.4%       4071 ±  2%  slabinfo.xfs_buf.num_objs
      2115 ±  6%     +29.2%       2732 ±  6%  slabinfo.xfs_icr.active_objs
      2115 ±  6%     +29.2%       2732 ±  6%  slabinfo.xfs_icr.num_objs
      4205           +11.6%       4692        slabinfo.xfs_ili.active_objs
      4205           +11.6%       4692        slabinfo.xfs_ili.num_objs
      3489 ±  3%     +44.0%       5027 ±  3%  slabinfo.xfs_inode.active_objs
      3489 ±  3%     +45.1%       5063 ±  4%  slabinfo.xfs_inode.num_objs
    505.00 ± 12%     -33.3%     336.67 ± 14%  numa-vmstat.node0.nr_active_file
    493.67 ± 13%     -29.2%     349.50 ± 14%  numa-vmstat.node0.nr_zone_active_file
    445.33 ±  5%     -29.5%     314.00 ± 16%  numa-vmstat.node1.nr_active_file
    441.33 ±  5%     -32.3%     298.83 ± 15%  numa-vmstat.node1.nr_zone_active_file
    382.17 ± 15%     -24.9%     287.00 ± 12%  numa-vmstat.node2.nr_active_file
    183.50 ± 42%  +96442.4%     177155 ±141%  numa-vmstat.node2.nr_unevictable
    183.50 ± 42%  +96442.4%     177155 ±141%  numa-vmstat.node2.nr_zone_unevictable
      3621 ± 13%     +53.8%       5570 ±  9%  numa-vmstat.node3.nr_active_anon
   6483209 ±  9%     +16.2%    7531808 ±  3%  numa-vmstat.node3.nr_dirtied
      5083 ± 19%     +32.0%       6709 ± 11%  numa-vmstat.node3.nr_shmem
      3621 ± 13%     +53.8%       5570 ±  9%  numa-vmstat.node3.nr_zone_active_anon
   6926111 ± 10%     +17.3%    8125929 ±  5%  numa-vmstat.node3.numa_hit
   6875641 ± 10%     +17.4%    8068730 ±  5%  numa-vmstat.node3.numa_local
      4673 ±  4%     +42.8%       6672 ±  4%  proc-vmstat.nr_active_anon
      1777 ±  8%     -32.3%       1203 ± 13%  proc-vmstat.nr_active_file
     91534            +1.2%      92665        proc-vmstat.nr_anon_pages
    276860            -3.2%     268054        proc-vmstat.nr_dirty
     96965            +1.4%      98296        proc-vmstat.nr_inactive_anon
    276169            -3.1%     267626        proc-vmstat.nr_inactive_file
     10171           +19.1%      12115 ±  2%  proc-vmstat.nr_shmem
     38581            +3.8%      40066        proc-vmstat.nr_slab_reclaimable
    105136            +3.1%     108420        proc-vmstat.nr_slab_unreclaimable
      4673 ±  4%     +42.8%       6672 ±  4%  proc-vmstat.nr_zone_active_anon
      1778 ±  8%     -32.2%       1204 ± 13%  proc-vmstat.nr_zone_active_file
     96965            +1.4%      98296        proc-vmstat.nr_zone_inactive_anon
    276170            -3.1%     267626        proc-vmstat.nr_zone_inactive_file
    279764            -3.3%     270663        proc-vmstat.nr_zone_write_pending
    512494            +5.9%     542517        proc-vmstat.pgfault
     15416 ± 10%     +98.4%      30586 ± 15%  proc-vmstat.pgpgout
     18147           +12.6%      20432 ±  3%  proc-vmstat.pgreuse
 1.175e+10           -11.7%  1.038e+10        perf-stat.i.branch-instructions
      1.16 ± 15%      -0.2        0.93 ±  7%  perf-stat.i.branch-miss-rate%
  80750138 ±  3%     -18.0%   66250168        perf-stat.i.branch-misses
 1.356e+08           -19.3%  1.095e+08        perf-stat.i.cache-misses
 3.354e+08           -21.4%  2.638e+08        perf-stat.i.cache-references
     52485           -16.0%      44098        perf-stat.i.context-switches
 7.771e+10           +22.3%  9.501e+10 ±  2%  perf-stat.i.cpu-cycles
      1055 ±  5%     +11.8%       1180        perf-stat.i.cpu-migrations
 1.743e+10           -11.7%  1.539e+10        perf-stat.i.dTLB-loads
  9.57e+09           -15.8%  8.061e+09        perf-stat.i.dTLB-stores
     72.40            +2.8       75.18        perf-stat.i.iTLB-load-miss-rate%
  46720220 ±  2%     -15.4%   39536110 ±  5%  perf-stat.i.iTLB-load-misses
   6738955           -18.0%    5522897 ±  2%  perf-stat.i.iTLB-loads
 6.044e+10           -11.6%  5.343e+10        perf-stat.i.instructions
      0.68 ±  3%     -23.1%       0.52        perf-stat.i.ipc
      0.54           +22.2%       0.66 ±  2%  perf-stat.i.metric.GHz
    630.72 ±  2%     -19.1%     509.99        perf-stat.i.metric.K/sec
    271.68           -12.8%     236.90        perf-stat.i.metric.M/sec
     10774           -11.8%       9508        perf-stat.i.minor-faults
     41.74            -2.1       39.63        perf-stat.i.node-load-miss-rate%
  15191670           -13.5%   13146455 ±  2%  perf-stat.i.node-load-misses
  50114255           -21.2%   39495377        perf-stat.i.node-loads
   4444796           -11.5%    3935053        perf-stat.i.node-store-misses
   5412034           -15.0%    4598371        perf-stat.i.node-stores
     10824           -11.9%       9539        perf-stat.i.page-faults
      5.55 ±  2%     -11.1%       4.94 ±  2%  perf-stat.overall.MPKI
      0.69 ±  2%      -0.0        0.64        perf-stat.overall.branch-miss-rate%
      1.29 ±  2%     +38.4%       1.78 ±  2%  perf-stat.overall.cpi
    572.85 ±  2%     +51.7%     868.74        perf-stat.overall.cycles-between-cache-misses
      0.78 ±  2%     -27.7%       0.56 ±  2%  perf-stat.overall.ipc
     23.27            +1.7       24.99        perf-stat.overall.node-load-miss-rate%
     45.11            +1.0       46.11        perf-stat.overall.node-store-miss-rate%
 1.154e+10           -11.7%  1.019e+10        perf-stat.ps.branch-instructions
  79076596 ±  3%     -17.9%   64931951        perf-stat.ps.branch-misses
 1.333e+08           -19.4%  1.074e+08        perf-stat.ps.cache-misses
 3.295e+08           -21.4%   2.59e+08        perf-stat.ps.cache-references
     51522           -16.1%      43252        perf-stat.ps.context-switches
 7.633e+10           +22.3%  9.334e+10 ±  2%  perf-stat.ps.cpu-cycles
      1036 ±  5%     +11.8%       1159        perf-stat.ps.cpu-migrations
 1.712e+10           -11.8%   1.51e+10        perf-stat.ps.dTLB-loads
   9.4e+09           -15.8%  7.911e+09        perf-stat.ps.dTLB-stores
  45891763 ±  2%     -15.5%   38799996 ±  5%  perf-stat.ps.iTLB-load-misses
   6593312           -18.0%    5409466 ±  2%  perf-stat.ps.iTLB-loads
 5.935e+10           -11.6%  5.244e+10        perf-stat.ps.instructions
     10330           -10.7%       9228        perf-stat.ps.minor-faults
  14931378           -13.6%   12905275 ±  2%  perf-stat.ps.node-load-misses
  49243211           -21.3%   38734133        perf-stat.ps.node-loads
   4368742           -11.6%    3861796        perf-stat.ps.node-store-misses
   5316926           -15.1%    4513602        perf-stat.ps.node-stores
     10377           -10.8%       9258        perf-stat.ps.page-faults
 2.195e+12            +8.2%  2.375e+12        perf-stat.total.instructions
     74647           +22.6%      91483        interrupts.CPU0.LOC:Local_timer_interrupts
     35.67 ± 18%    +128.5%      81.50 ± 26%  interrupts.CPU0.RES:Rescheduling_interrupts
     74615           +22.8%      91659        interrupts.CPU1.LOC:Local_timer_interrupts
     74609           +22.8%      91615        interrupts.CPU10.LOC:Local_timer_interrupts
     31.50 ± 11%    +143.9%      76.83 ± 29%  interrupts.CPU10.RES:Rescheduling_interrupts
     74511           +22.9%      91567        interrupts.CPU100.LOC:Local_timer_interrupts
     15.83 ± 17%    +331.6%      68.33 ± 30%  interrupts.CPU100.RES:Rescheduling_interrupts
     74512           +22.9%      91600        interrupts.CPU101.LOC:Local_timer_interrupts
     74506           +22.9%      91555        interrupts.CPU102.LOC:Local_timer_interrupts
     74501           +22.9%      91533        interrupts.CPU103.LOC:Local_timer_interrupts
     14.50 ± 17%    +435.6%      77.67 ± 41%  interrupts.CPU103.RES:Rescheduling_interrupts
     74502           +22.9%      91557        interrupts.CPU104.LOC:Local_timer_interrupts
     74540           +22.8%      91556        interrupts.CPU105.LOC:Local_timer_interrupts
     74520           +22.9%      91569        interrupts.CPU106.LOC:Local_timer_interrupts
     74515           +22.9%      91557        interrupts.CPU107.LOC:Local_timer_interrupts
     74512           +22.9%      91570        interrupts.CPU108.LOC:Local_timer_interrupts
     74532           +22.9%      91597        interrupts.CPU109.LOC:Local_timer_interrupts
     74643           +22.7%      91553        interrupts.CPU11.LOC:Local_timer_interrupts
     31.33 ±  9%    +143.6%      76.33 ± 33%  interrupts.CPU11.RES:Rescheduling_interrupts
     74535           +22.8%      91546        interrupts.CPU110.LOC:Local_timer_interrupts
     74524           +22.8%      91537        interrupts.CPU111.LOC:Local_timer_interrupts
     74482           +22.9%      91570        interrupts.CPU112.LOC:Local_timer_interrupts
     74504           +22.9%      91574        interrupts.CPU113.LOC:Local_timer_interrupts
     74494           +22.9%      91577        interrupts.CPU114.LOC:Local_timer_interrupts
     74503           +22.9%      91581        interrupts.CPU115.LOC:Local_timer_interrupts
     74518           +22.8%      91508        interrupts.CPU116.LOC:Local_timer_interrupts
     74506           +23.0%      91621        interrupts.CPU117.LOC:Local_timer_interrupts
     74513           +22.9%      91572        interrupts.CPU118.LOC:Local_timer_interrupts
     15.17 ±  8%    +344.0%      67.33 ± 31%  interrupts.CPU118.RES:Rescheduling_interrupts
     74565           +22.8%      91573        interrupts.CPU119.LOC:Local_timer_interrupts
     74616           +22.8%      91651        interrupts.CPU12.LOC:Local_timer_interrupts
     74467           +22.9%      91540        interrupts.CPU120.LOC:Local_timer_interrupts
     74528           +22.8%      91529        interrupts.CPU121.LOC:Local_timer_interrupts
     74518           +22.8%      91530        interrupts.CPU122.LOC:Local_timer_interrupts
     12.33 ± 24%    +498.6%      73.83 ± 28%  interrupts.CPU122.RES:Rescheduling_interrupts
     74513           +22.9%      91541        interrupts.CPU123.LOC:Local_timer_interrupts
     74497           +22.9%      91559        interrupts.CPU124.LOC:Local_timer_interrupts
     74524           +22.8%      91531        interrupts.CPU125.LOC:Local_timer_interrupts
     74521           +22.8%      91548        interrupts.CPU126.LOC:Local_timer_interrupts
     74459           +23.0%      91549        interrupts.CPU127.LOC:Local_timer_interrupts
     13.83 ± 24%    +395.2%      68.50 ± 32%  interrupts.CPU127.RES:Rescheduling_interrupts
     74510           +22.9%      91537        interrupts.CPU128.LOC:Local_timer_interrupts
     74467           +22.9%      91543        interrupts.CPU129.LOC:Local_timer_interrupts
      2596 ±  7%     +13.8%       2954 ±  5%  interrupts.CPU129.NMI:Non-maskable_interrupts
      2596 ±  7%     +13.8%       2954 ±  5%  interrupts.CPU129.PMI:Performance_monitoring_interrupts
     74584           +22.8%      91625        interrupts.CPU13.LOC:Local_timer_interrupts
     27.33 ± 29%    +170.1%      73.83 ± 35%  interrupts.CPU13.RES:Rescheduling_interrupts
     74566           +22.8%      91580        interrupts.CPU130.LOC:Local_timer_interrupts
     74533           +22.8%      91539        interrupts.CPU131.LOC:Local_timer_interrupts
     74524           +22.8%      91538        interrupts.CPU132.LOC:Local_timer_interrupts
      2539 ±  7%     +19.0%       3020 ±  2%  interrupts.CPU132.NMI:Non-maskable_interrupts
      2539 ±  7%     +19.0%       3020 ±  2%  interrupts.CPU132.PMI:Performance_monitoring_interrupts
     74541           +22.8%      91537        interrupts.CPU133.LOC:Local_timer_interrupts
     74529           +22.8%      91544        interrupts.CPU134.LOC:Local_timer_interrupts
      2640 ±  6%     +13.4%       2994 ±  4%  interrupts.CPU134.NMI:Non-maskable_interrupts
      2640 ±  6%     +13.4%       2994 ±  4%  interrupts.CPU134.PMI:Performance_monitoring_interrupts
     74582           +22.7%      91534        interrupts.CPU135.LOC:Local_timer_interrupts
      2375 ± 19%     +24.2%       2951 ±  3%  interrupts.CPU135.NMI:Non-maskable_interrupts
      2375 ± 19%     +24.2%       2951 ±  3%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
     74546           +22.8%      91537        interrupts.CPU136.LOC:Local_timer_interrupts
     74527           +22.8%      91545        interrupts.CPU137.LOC:Local_timer_interrupts
     11.00 ± 22%    +537.9%      70.17 ± 39%  interrupts.CPU137.RES:Rescheduling_interrupts
     74497           +22.9%      91557        interrupts.CPU138.LOC:Local_timer_interrupts
     74503           +22.9%      91560        interrupts.CPU139.LOC:Local_timer_interrupts
     74457           +23.0%      91603        interrupts.CPU14.LOC:Local_timer_interrupts
     74514           +22.9%      91558        interrupts.CPU140.LOC:Local_timer_interrupts
     74503           +22.9%      91541        interrupts.CPU141.LOC:Local_timer_interrupts
     74520           +22.8%      91541        interrupts.CPU142.LOC:Local_timer_interrupts
     15.67 ± 44%    +383.0%      75.67 ± 31%  interrupts.CPU142.RES:Rescheduling_interrupts
     74515           +22.9%      91574        interrupts.CPU143.LOC:Local_timer_interrupts
     11.67 ± 38%    +465.7%      66.00 ± 32%  interrupts.CPU143.RES:Rescheduling_interrupts
     74614           +22.7%      91565        interrupts.CPU15.LOC:Local_timer_interrupts
     74566           +22.9%      91609        interrupts.CPU16.LOC:Local_timer_interrupts
     74607           +22.7%      91556        interrupts.CPU17.LOC:Local_timer_interrupts
     74616           +22.7%      91589        interrupts.CPU18.LOC:Local_timer_interrupts
     74562           +22.8%      91595        interrupts.CPU19.LOC:Local_timer_interrupts
     74642           +22.6%      91519        interrupts.CPU2.LOC:Local_timer_interrupts
     25.17 ± 17%    +264.9%      91.83 ± 16%  interrupts.CPU2.RES:Rescheduling_interrupts
     74562           +22.8%      91582        interrupts.CPU20.LOC:Local_timer_interrupts
     74536           +22.9%      91590        interrupts.CPU21.LOC:Local_timer_interrupts
     74578           +22.8%      91592        interrupts.CPU22.LOC:Local_timer_interrupts
     74565           +22.8%      91566        interrupts.CPU23.LOC:Local_timer_interrupts
     74577           +22.8%      91580        interrupts.CPU24.LOC:Local_timer_interrupts
     74538           +22.8%      91568        interrupts.CPU25.LOC:Local_timer_interrupts
     74544           +22.8%      91561        interrupts.CPU26.LOC:Local_timer_interrupts
     74560           +22.8%      91558        interrupts.CPU27.LOC:Local_timer_interrupts
     74545           +22.9%      91605        interrupts.CPU28.LOC:Local_timer_interrupts
     74567           +22.8%      91574        interrupts.CPU29.LOC:Local_timer_interrupts
     74621           +22.8%      91608        interrupts.CPU3.LOC:Local_timer_interrupts
     74576           +22.8%      91577        interrupts.CPU30.LOC:Local_timer_interrupts
     74540           +22.9%      91619        interrupts.CPU31.LOC:Local_timer_interrupts
     74537           +22.9%      91636        interrupts.CPU32.LOC:Local_timer_interrupts
     74538           +22.9%      91593        interrupts.CPU33.LOC:Local_timer_interrupts
     74603           +22.8%      91589        interrupts.CPU34.LOC:Local_timer_interrupts
     25.83 ± 15%    +195.5%      76.33 ± 21%  interrupts.CPU34.RES:Rescheduling_interrupts
     74593           +22.8%      91591        interrupts.CPU35.LOC:Local_timer_interrupts
     74536           +22.9%      91609        interrupts.CPU36.LOC:Local_timer_interrupts
     74592           +22.8%      91573        interrupts.CPU37.LOC:Local_timer_interrupts
     74580           +22.7%      91541        interrupts.CPU38.LOC:Local_timer_interrupts
     74582           +22.8%      91561        interrupts.CPU39.LOC:Local_timer_interrupts
     74497           +22.8%      91514        interrupts.CPU4.LOC:Local_timer_interrupts
     74570           +22.8%      91608        interrupts.CPU40.LOC:Local_timer_interrupts
     74564           +22.8%      91574        interrupts.CPU41.LOC:Local_timer_interrupts
     74543           +22.9%      91579        interrupts.CPU42.LOC:Local_timer_interrupts
     74517           +22.9%      91593        interrupts.CPU43.LOC:Local_timer_interrupts
     74516           +23.0%      91661        interrupts.CPU44.LOC:Local_timer_interrupts
     74561           +22.8%      91573        interrupts.CPU45.LOC:Local_timer_interrupts
     74543           +22.8%      91572        interrupts.CPU46.LOC:Local_timer_interrupts
     74532           +22.9%      91597        interrupts.CPU47.LOC:Local_timer_interrupts
     74535           +22.9%      91583        interrupts.CPU48.LOC:Local_timer_interrupts
      1820 ± 32%     +33.0%       2420 ± 27%  interrupts.CPU48.NMI:Non-maskable_interrupts
      1820 ± 32%     +33.0%       2420 ± 27%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
     74541           +22.8%      91531        interrupts.CPU49.LOC:Local_timer_interrupts
      1769 ± 36%     +40.6%       2488 ± 28%  interrupts.CPU49.NMI:Non-maskable_interrupts
      1769 ± 36%     +40.6%       2488 ± 28%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
     74632           +22.8%      91684        interrupts.CPU5.LOC:Local_timer_interrupts
     26.00 ± 24%    +161.5%      68.00 ± 34%  interrupts.CPU5.RES:Rescheduling_interrupts
     74536           +22.9%      91596        interrupts.CPU50.LOC:Local_timer_interrupts
      1769 ± 33%     +51.0%       2671 ± 20%  interrupts.CPU50.NMI:Non-maskable_interrupts
      1769 ± 33%     +51.0%       2671 ± 20%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
     74564           +22.8%      91573        interrupts.CPU51.LOC:Local_timer_interrupts
      1606 ± 28%     +84.9%       2970 ±  6%  interrupts.CPU51.NMI:Non-maskable_interrupts
      1606 ± 28%     +84.9%       2970 ±  6%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
     22.67 ± 12%    +243.4%      77.83 ± 24%  interrupts.CPU51.RES:Rescheduling_interrupts
     74567           +22.8%      91543        interrupts.CPU52.LOC:Local_timer_interrupts
      1789 ± 34%     +65.3%       2957 ±  8%  interrupts.CPU52.NMI:Non-maskable_interrupts
      1789 ± 34%     +65.3%       2957 ±  8%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
     74598           +22.9%      91646        interrupts.CPU53.LOC:Local_timer_interrupts
      1607 ± 27%     +63.7%       2631 ± 19%  interrupts.CPU53.NMI:Non-maskable_interrupts
      1607 ± 27%     +63.7%       2631 ± 19%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
     74602           +22.8%      91621        interrupts.CPU54.LOC:Local_timer_interrupts
      1743 ± 35%     +59.2%       2775 ± 18%  interrupts.CPU54.NMI:Non-maskable_interrupts
      1743 ± 35%     +59.2%       2775 ± 18%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
     21.00 ± 35%    +310.3%      86.17 ± 35%  interrupts.CPU54.RES:Rescheduling_interrupts
     74484           +23.0%      91593        interrupts.CPU55.LOC:Local_timer_interrupts
     74575           +22.9%      91619        interrupts.CPU56.LOC:Local_timer_interrupts
     74542           +22.7%      91478        interrupts.CPU57.LOC:Local_timer_interrupts
     74597           +22.8%      91594        interrupts.CPU58.LOC:Local_timer_interrupts
     74492           +22.9%      91576        interrupts.CPU59.LOC:Local_timer_interrupts
     74659           +22.6%      91511        interrupts.CPU6.LOC:Local_timer_interrupts
     74546           +22.8%      91578        interrupts.CPU60.LOC:Local_timer_interrupts
     74560           +22.8%      91570        interrupts.CPU61.LOC:Local_timer_interrupts
     74550           +22.8%      91573        interrupts.CPU62.LOC:Local_timer_interrupts
      2385 ± 19%     +23.6%       2949 ±  5%  interrupts.CPU62.NMI:Non-maskable_interrupts
      2385 ± 19%     +23.6%       2949 ±  5%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
     21.17 ± 16%    +274.8%      79.33 ± 22%  interrupts.CPU62.RES:Rescheduling_interrupts
     74540           +22.8%      91570        interrupts.CPU63.LOC:Local_timer_interrupts
     74551           +22.8%      91565        interrupts.CPU64.LOC:Local_timer_interrupts
      1964 ± 32%     +50.5%       2957 ±  5%  interrupts.CPU64.NMI:Non-maskable_interrupts
      1964 ± 32%     +50.5%       2957 ±  5%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
     74487           +22.9%      91561        interrupts.CPU65.LOC:Local_timer_interrupts
      2150 ± 30%     +38.5%       2978 ±  3%  interrupts.CPU65.NMI:Non-maskable_interrupts
      2150 ± 30%     +38.5%       2978 ±  3%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
     74442           +23.0%      91561        interrupts.CPU66.LOC:Local_timer_interrupts
      2157 ± 30%     +39.4%       3008 ±  4%  interrupts.CPU66.NMI:Non-maskable_interrupts
      2157 ± 30%     +39.4%       3008 ±  4%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
     74596           +22.8%      91571        interrupts.CPU67.LOC:Local_timer_interrupts
      2200 ± 31%     +35.8%       2988 ±  4%  interrupts.CPU67.NMI:Non-maskable_interrupts
      2200 ± 31%     +35.8%       2988 ±  4%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
     74615           +22.7%      91572        interrupts.CPU68.LOC:Local_timer_interrupts
      2187 ± 28%     +35.8%       2969 ±  5%  interrupts.CPU68.NMI:Non-maskable_interrupts
      2187 ± 28%     +35.8%       2969 ±  5%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
     74576           +22.8%      91608        interrupts.CPU69.LOC:Local_timer_interrupts
      2215 ± 31%     +37.0%       3034 ±  5%  interrupts.CPU69.NMI:Non-maskable_interrupts
      2215 ± 31%     +37.0%       3034 ±  5%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
     23.83 ± 20%    +260.1%      85.83 ± 15%  interrupts.CPU69.RES:Rescheduling_interrupts
     74622           +22.8%      91648        interrupts.CPU7.LOC:Local_timer_interrupts
     74487           +22.9%      91554        interrupts.CPU70.LOC:Local_timer_interrupts
      2198 ± 31%     +36.5%       3000 ±  4%  interrupts.CPU70.NMI:Non-maskable_interrupts
      2198 ± 31%     +36.5%       3000 ±  4%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
     74603           +22.8%      91614        interrupts.CPU71.LOC:Local_timer_interrupts
      2208 ± 30%     +36.4%       3012 ±  5%  interrupts.CPU71.NMI:Non-maskable_interrupts
      2208 ± 30%     +36.4%       3012 ±  5%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
     74574           +22.8%      91583        interrupts.CPU72.LOC:Local_timer_interrupts
     74515           +22.9%      91580        interrupts.CPU73.LOC:Local_timer_interrupts
      2520 ± 19%     +20.0%       3025 ±  4%  interrupts.CPU73.NMI:Non-maskable_interrupts
      2520 ± 19%     +20.0%       3025 ±  4%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
     74584           +22.7%      91540        interrupts.CPU74.LOC:Local_timer_interrupts
     17.83 ± 21%    +388.8%      87.17 ± 35%  interrupts.CPU74.RES:Rescheduling_interrupts
     74567           +22.9%      91616        interrupts.CPU75.LOC:Local_timer_interrupts
     74481           +23.0%      91646        interrupts.CPU76.LOC:Local_timer_interrupts
     74582           +22.9%      91662        interrupts.CPU77.LOC:Local_timer_interrupts
     74590           +22.8%      91615        interrupts.CPU78.LOC:Local_timer_interrupts
     74594           +22.8%      91601        interrupts.CPU79.LOC:Local_timer_interrupts
     74618           +22.8%      91653        interrupts.CPU8.LOC:Local_timer_interrupts
     74616           +22.7%      91576        interrupts.CPU80.LOC:Local_timer_interrupts
     74650           +22.8%      91634        interrupts.CPU81.LOC:Local_timer_interrupts
     17.83 ± 15%    +334.6%      77.50 ± 31%  interrupts.CPU81.RES:Rescheduling_interrupts
     74583           +22.8%      91623        interrupts.CPU82.LOC:Local_timer_interrupts
     22.00 ± 35%    +234.8%      73.67 ± 24%  interrupts.CPU82.RES:Rescheduling_interrupts
     74610           +22.7%      91520        interrupts.CPU83.LOC:Local_timer_interrupts
     74550           +22.9%      91591        interrupts.CPU84.LOC:Local_timer_interrupts
     74496           +23.0%      91597        interrupts.CPU85.LOC:Local_timer_interrupts
      2718 ±  4%      +8.6%       2952 ±  4%  interrupts.CPU85.NMI:Non-maskable_interrupts
      2718 ±  4%      +8.6%       2952 ±  4%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
     74617           +22.8%      91622        interrupts.CPU86.LOC:Local_timer_interrupts
     74587           +22.8%      91590        interrupts.CPU87.LOC:Local_timer_interrupts
     74618           +22.8%      91631        interrupts.CPU88.LOC:Local_timer_interrupts
     20.33 ± 27%    +301.6%      81.67 ± 36%  interrupts.CPU88.RES:Rescheduling_interrupts
     74570           +22.8%      91599        interrupts.CPU89.LOC:Local_timer_interrupts
     74597           +22.8%      91571        interrupts.CPU9.LOC:Local_timer_interrupts
     26.17 ±  9%    +245.9%      90.50 ± 17%  interrupts.CPU9.RES:Rescheduling_interrupts
     74566           +22.8%      91579        interrupts.CPU90.LOC:Local_timer_interrupts
     74558           +22.8%      91553        interrupts.CPU91.LOC:Local_timer_interrupts
     74540           +22.9%      91587        interrupts.CPU92.LOC:Local_timer_interrupts
     74574           +22.8%      91566        interrupts.CPU93.LOC:Local_timer_interrupts
     74558           +22.8%      91549        interrupts.CPU94.LOC:Local_timer_interrupts
     12.50 ± 20%    +512.0%      76.50 ± 42%  interrupts.CPU94.RES:Rescheduling_interrupts
     74536           +22.9%      91584        interrupts.CPU95.LOC:Local_timer_interrupts
     74540           +22.8%      91541        interrupts.CPU96.LOC:Local_timer_interrupts
     74518           +22.9%      91602        interrupts.CPU97.LOC:Local_timer_interrupts
     74514           +22.9%      91594        interrupts.CPU98.LOC:Local_timer_interrupts
     74539           +22.9%      91578        interrupts.CPU99.LOC:Local_timer_interrupts
     11.50 ± 16%    +559.4%      75.83 ± 25%  interrupts.CPU99.RES:Rescheduling_interrupts
  10735396           +22.8%   13187111        interrupts.LOC:Local_timer_interrupts
      2841 ±  3%    +245.2%       9810 ±  7%  interrupts.RES:Rescheduling_interrupts
     32.84 ±  4%     -11.3       21.54 ±  4%  perf-profile.calltrace.cycles-pp.write
     31.76 ±  4%     -11.0       20.80 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     31.53 ±  4%     -10.9       20.62 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     31.11 ±  4%     -10.8       20.34 ±  4%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     30.54 ±  4%     -10.6       19.95 ±  4%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     29.22 ±  4%     -10.2       19.02 ±  5%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     28.62 ±  4%     -10.0       18.60 ±  5%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
     25.94 ±  4%      -9.1       16.82 ±  5%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
     25.82 ±  4%      -9.1       16.73 ±  5%  perf-profile.calltrace.cycles-pp.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write.vfs_write
     22.57 ±  5%      -8.1       14.50 ±  5%  perf-profile.calltrace.cycles-pp.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
     33.14 ±  9%      -7.7       25.43 ± 11%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     32.91 ±  9%      -7.7       25.25 ± 11%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     32.91 ±  9%      -7.7       25.26 ± 11%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     32.91 ±  9%      -7.7       25.26 ± 11%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     32.48 ±  9%      -7.5       24.98 ± 11%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     32.41 ±  9%      -7.5       24.92 ± 11%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     18.63 ±  3%      -6.5       12.09 ±  4%  perf-profile.calltrace.cycles-pp.read
     17.26 ±  3%      -6.1       11.16 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     17.09 ±  3%      -6.0       11.04 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     16.69 ±  3%      -5.9       10.77 ±  4%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     16.16 ±  4%      -5.8       10.40 ±  4%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     14.97 ±  4%      -5.4        9.58 ±  4%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.70 ±  4%      -5.3        9.40 ±  4%  perf-profile.calltrace.cycles-pp.xfs_file_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
     14.29 ±  4%      -5.2        9.10 ±  4%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_read.xfs_file_read_iter.new_sync_read.vfs_read.ksys_read
     14.05 ±  5%      -5.1        8.91 ±  7%  perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
     13.30 ±  4%      -4.9        8.43 ±  5%  perf-profile.calltrace.cycles-pp.filemap_read.xfs_file_buffered_read.xfs_file_read_iter.new_sync_read.vfs_read
      9.87 ±  6%      -3.9        5.95 ±  9%  perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      9.76 ±  6%      -3.9        5.87 ±  9%  perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply
      7.12 ±  6%      -3.5        3.67 ±  8%  perf-profile.calltrace.cycles-pp.__close
      7.11 ±  6%      -3.4        3.66 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      7.11 ±  6%      -3.4        3.66 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      7.09 ±  6%      -3.4        3.65 ±  8%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      7.09 ±  6%      -3.4        3.65 ±  8%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      7.08 ±  6%      -3.4        3.65 ±  8%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.07 ±  6%      -3.4        3.64 ±  8%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      6.95 ±  6%      -3.4        3.56 ±  8%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      6.91 ±  6%      -3.4        3.54 ±  8%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_prepare
      7.55 ±  7%      -3.2        4.34 ± 11%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      6.10 ±  6%      -2.6        3.50 ±  9%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
      6.08 ±  6%      -2.6        3.48 ±  9%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.__dentry_kill.dput.__fput
      5.54 ±  6%      -2.3        3.19 ±  8%  perf-profile.calltrace.cycles-pp.mark_page_accessed.filemap_read.xfs_file_buffered_read.xfs_file_read_iter.new_sync_read
      5.43 ±  7%      -2.3        3.12 ± 11%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      5.56 ±  4%      -2.0        3.58 ±  5%  perf-profile.calltrace.cycles-pp.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      3.43 ±  9%      -1.5        1.90 ± 13%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      3.42 ±  7%      -1.5        1.90 ± 10%  perf-profile.calltrace.cycles-pp.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill.dput
      3.24 ±  7%      -1.4        1.79 ± 10%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill
      3.25 ±  5%      -1.3        1.97 ±  7%  perf-profile.calltrace.cycles-pp.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      3.77 ±  3%      -1.2        2.55 ±  4%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.xfs_file_buffered_read.xfs_file_read_iter.new_sync_read
      2.79 ±  9%      -1.2        1.59 ± 12%  perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.mark_page_accessed.filemap_read.xfs_file_buffered_read.xfs_file_read_iter
      3.19 ±  2%      -1.0        2.15 ±  4%  perf-profile.calltrace.cycles-pp.copyout.copy_page_to_iter.filemap_read.xfs_file_buffered_read.xfs_file_read_iter
      3.09 ±  2%      -1.0        2.08 ±  4%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout.copy_page_to_iter.filemap_read.xfs_file_buffered_read
      2.22 ±  4%      -1.0        1.22 ±  5%  perf-profile.calltrace.cycles-pp.workingset_activation.mark_page_accessed.filemap_read.xfs_file_buffered_read.xfs_file_read_iter
      2.40 ±  6%      -1.0        1.42 ±  8%  perf-profile.calltrace.cycles-pp.__set_page_dirty.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor.iomap_apply
      2.08 ±  9%      -0.9        1.19 ± 14%  perf-profile.calltrace.cycles-pp.lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      1.99 ±  9%      -0.9        1.13 ± 14%  perf-profile.calltrace.cycles-pp.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      2.55 ±  4%      -0.8        1.78 ±  4%  perf-profile.calltrace.cycles-pp.llseek
      2.47 ±  2%      -0.8        1.72 ±  4%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.62 ±  4%      -0.7        0.89 ±  6%  perf-profile.calltrace.cycles-pp.workingset_age_nonresident.workingset_activation.mark_page_accessed.filemap_read.xfs_file_buffered_read
      1.01 ± 15%      -0.7        0.30 ±102%  perf-profile.calltrace.cycles-pp.lock_page_lruvec_irqsave.pagevec_lru_move_fn.mark_page_accessed.filemap_read.xfs_file_buffered_read
      1.48 ±  9%      -0.7        0.78 ± 13%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      2.15 ±  3%      -0.7        1.46 ±  5%  perf-profile.calltrace.cycles-pp.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
      1.45 ±  7%      -0.6        0.81 ± 12%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.__set_page_dirty.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor
      1.98 ±  2%      -0.6        1.34 ±  3%  perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.xfs_file_buffered_read.xfs_file_read_iter.new_sync_read
      1.43 ±  9%      -0.6        0.83 ± 12%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      1.41 ±  7%      -0.6        0.82 ±  9%  perf-profile.calltrace.cycles-pp.truncate_cleanup_page.truncate_inode_pages_range.evict.__dentry_kill.dput
      1.38 ±  7%      -0.6        0.79 ± 10%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      1.77 ±  2%      -0.6        1.19 ±  3%  perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.xfs_file_buffered_read.xfs_file_read_iter
      0.94 ±  7%      -0.6        0.38 ± 72%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.__set_page_dirty.__set_page_dirty_nobuffers.iomap_write_end
      1.30 ±  8%      -0.6        0.74 ± 10%  perf-profile.calltrace.cycles-pp.__cancel_dirty_page.truncate_cleanup_page.truncate_inode_pages_range.evict.__dentry_kill
      1.73 ±  3%      -0.5        1.20 ±  3%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.52 ±  3%      -0.5        1.00 ±  7%  perf-profile.calltrace.cycles-pp.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
      1.08 ±  6%      -0.5        0.56 ±  7%  perf-profile.calltrace.cycles-pp.mem_cgroup_uncharge_list.release_pages.__pagevec_release.truncate_inode_pages_range.evict
      1.15 ±  8%      -0.5        0.65 ± 11%  perf-profile.calltrace.cycles-pp.account_page_cleaned.__cancel_dirty_page.truncate_cleanup_page.truncate_inode_pages_range.evict
      1.27 ±  6%      -0.5        0.77 ±  8%  perf-profile.calltrace.cycles-pp.__activate_page.pagevec_lru_move_fn.mark_page_accessed.filemap_read.xfs_file_buffered_read
      1.43 ±  4%      -0.4        1.01 ±  4%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      1.27 ±  5%      -0.4        0.89 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek
      0.92 ±  4%      -0.4        0.56 ±  6%  perf-profile.calltrace.cycles-pp.delete_from_page_cache_batch.truncate_inode_pages_range.evict.__dentry_kill.dput
      1.10 ±  5%      -0.3        0.78 ±  4%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.09 ±  6%      -0.3        0.77 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.91 ±  3%      -0.3        0.59 ±  6%  perf-profile.calltrace.cycles-pp.touch_atime.filemap_read.xfs_file_buffered_read.xfs_file_read_iter.new_sync_read
      1.18 ±  3%      -0.3        0.86 ±  3%  perf-profile.calltrace.cycles-pp.memset_erms.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.00 ±  5%      -0.3        0.71 ±  4%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply
      0.77 ±  2%      -0.2        0.55 ±  4%  perf-profile.calltrace.cycles-pp.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      0.73 ±  6%      -0.1        0.63 ±  3%  perf-profile.calltrace.cycles-pp.xfs_generic_create.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.72 ±  6%      -0.1        0.62 ±  3%  perf-profile.calltrace.cycles-pp.xfs_create.xfs_generic_create.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.6        0.61 ±  5%  perf-profile.calltrace.cycles-pp.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread
      0.00            +0.7        0.66 ±  5%  perf-profile.calltrace.cycles-pp.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread.kthread
      0.00            +0.7        0.67 ±  6%  perf-profile.calltrace.cycles-pp.xfs_inodegc_worker.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.7        0.68 ±  5%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.7        0.69 ±  6%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.00            +0.7        0.70 ±  6%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.00            +0.7        0.70 ±  6%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      2.26 ± 10%     +14.6       16.89 ±  2%  perf-profile.calltrace.cycles-pp.unlink
      2.24 ± 10%     +14.6       16.88 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      2.24 ± 10%     +14.6       16.88 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      2.23 ± 10%     +14.6       16.87 ±  2%  perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      1.57 ±  9%     +14.7       16.31 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.60 ±  7%     +14.9       15.49 ±  2%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.98 ±  9%     +14.9       16.88 ±  3%  perf-profile.calltrace.cycles-pp.creat64
      1.96 ±  9%     +14.9       16.87 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      1.96 ±  9%     +14.9       16.88 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      1.95 ±  9%     +14.9       16.87 ±  3%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      1.95 ±  9%     +14.9       16.87 ±  3%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      1.93 ±  9%     +14.9       16.85 ±  3%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      1.93 ±  9%     +14.9       16.85 ±  3%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.90 ± 11%     +15.1       16.01 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00           +15.2       15.17 ±  3%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
     33.21 ±  4%     -11.4       21.79 ±  4%  perf-profile.children.cycles-pp.write
     31.12 ±  4%     -10.8       20.35 ±  4%  perf-profile.children.cycles-pp.ksys_write
     30.56 ±  4%     -10.6       19.96 ±  4%  perf-profile.children.cycles-pp.vfs_write
     29.22 ±  4%     -10.2       19.03 ±  5%  perf-profile.children.cycles-pp.new_sync_write
     28.64 ±  4%     -10.0       18.62 ±  5%  perf-profile.children.cycles-pp.xfs_file_buffered_write
     25.94 ±  4%      -9.1       16.82 ±  5%  perf-profile.children.cycles-pp.iomap_file_buffered_write
     25.84 ±  4%      -9.1       16.74 ±  5%  perf-profile.children.cycles-pp.iomap_apply
     22.60 ±  5%      -8.1       14.53 ±  5%  perf-profile.children.cycles-pp.iomap_write_actor
     33.14 ±  9%      -7.7       25.43 ± 11%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     33.14 ±  9%      -7.7       25.43 ± 11%  perf-profile.children.cycles-pp.cpu_startup_entry
     33.14 ±  9%      -7.7       25.43 ± 11%  perf-profile.children.cycles-pp.do_idle
     32.91 ±  9%      -7.7       25.26 ± 11%  perf-profile.children.cycles-pp.start_secondary
     32.70 ±  9%      -7.6       25.15 ± 11%  perf-profile.children.cycles-pp.cpuidle_enter_state
     32.70 ±  9%      -7.5       25.15 ± 11%  perf-profile.children.cycles-pp.cpuidle_enter
     18.99 ±  3%      -6.6       12.34 ±  4%  perf-profile.children.cycles-pp.read
     16.70 ±  3%      -5.9       10.77 ±  4%  perf-profile.children.cycles-pp.ksys_read
     16.18 ±  4%      -5.8       10.42 ±  4%  perf-profile.children.cycles-pp.vfs_read
     14.99 ±  4%      -5.4        9.60 ±  4%  perf-profile.children.cycles-pp.new_sync_read
     14.71 ±  4%      -5.3        9.41 ±  4%  perf-profile.children.cycles-pp.xfs_file_read_iter
     14.31 ±  4%      -5.2        9.12 ±  4%  perf-profile.children.cycles-pp.xfs_file_buffered_read
     14.06 ±  5%      -5.1        8.91 ±  7%  perf-profile.children.cycles-pp.iomap_write_begin
     13.36 ±  4%      -4.9        8.46 ±  5%  perf-profile.children.cycles-pp.filemap_read
      9.90 ±  6%      -3.9        5.97 ±  9%  perf-profile.children.cycles-pp.grab_cache_page_write_begin
      9.81 ±  6%      -3.9        5.91 ±  9%  perf-profile.children.cycles-pp.pagecache_get_page
      7.78 ±  6%      -3.6        4.13 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      7.49 ±  6%      -3.6        3.92 ±  8%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      7.12 ±  6%      -3.5        3.67 ±  8%  perf-profile.children.cycles-pp.__close
      7.08 ±  6%      -3.4        3.65 ±  8%  perf-profile.children.cycles-pp.task_work_run
      7.08 ±  6%      -3.4        3.64 ±  8%  perf-profile.children.cycles-pp.__fput
      6.96 ±  6%      -3.4        3.57 ±  8%  perf-profile.children.cycles-pp.dput
      6.92 ±  6%      -3.4        3.54 ±  8%  perf-profile.children.cycles-pp.__dentry_kill
      7.55 ±  7%      -3.2        4.34 ± 11%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      6.10 ±  6%      -2.6        3.50 ±  9%  perf-profile.children.cycles-pp.evict
      6.08 ±  6%      -2.6        3.48 ±  9%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      5.55 ±  6%      -2.4        3.20 ±  8%  perf-profile.children.cycles-pp.mark_page_accessed
      5.44 ±  7%      -2.3        3.12 ± 11%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      5.58 ±  4%      -2.0        3.59 ±  5%  perf-profile.children.cycles-pp.iomap_write_end
      4.22 ±  7%      -1.9        2.32 ± 14%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      4.23 ±  7%      -1.9        2.37 ± 11%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      3.51 ±  8%      -1.6        1.88 ± 17%  perf-profile.children.cycles-pp.__mod_memcg_state
      3.26 ± 14%      -1.6        1.67 ± 19%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      3.44 ±  9%      -1.5        1.91 ± 13%  perf-profile.children.cycles-pp.mem_cgroup_charge
      3.42 ±  7%      -1.5        1.90 ± 10%  perf-profile.children.cycles-pp.__pagevec_release
      3.17 ± 14%      -1.5        1.64 ± 20%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      3.40 ±  6%      -1.5        1.90 ±  9%  perf-profile.children.cycles-pp.release_pages
      3.02 ± 15%      -1.5        1.52 ± 22%  perf-profile.children.cycles-pp.lock_page_lruvec_irqsave
      4.21 ±  3%      -1.3        2.87 ±  4%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      3.27 ±  6%      -1.3        1.98 ±  7%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      4.20 ±  2%      -1.3        2.92 ±  3%  perf-profile.children.cycles-pp.iomap_set_range_uptodate
      2.91 ±  9%      -1.3        1.65 ± 12%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      3.81 ±  2%      -1.2        2.57 ±  4%  perf-profile.children.cycles-pp.copy_page_to_iter
      3.19 ±  2%      -1.0        2.15 ±  4%  perf-profile.children.cycles-pp.copyout
      2.22 ±  4%      -1.0        1.22 ±  5%  perf-profile.children.cycles-pp.workingset_activation
      2.42 ±  6%      -1.0        1.43 ±  8%  perf-profile.children.cycles-pp.__set_page_dirty
      2.06 ±  9%      -0.9        1.17 ± 14%  perf-profile.children.cycles-pp.__pagevec_lru_add
      2.08 ±  9%      -0.9        1.19 ± 14%  perf-profile.children.cycles-pp.lru_cache_add
      2.90 ±  4%      -0.9        2.02 ±  4%  perf-profile.children.cycles-pp.llseek
      1.62 ±  4%      -0.7        0.90 ±  6%  perf-profile.children.cycles-pp.workingset_age_nonresident
      2.21 ±  3%      -0.7        1.50 ±  5%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      1.49 ±  9%      -0.7        0.79 ± 13%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      1.99 ±  2%      -0.6        1.35 ±  3%  perf-profile.children.cycles-pp.filemap_get_pages
      1.43 ±  9%      -0.6        0.83 ± 12%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.42 ±  7%      -0.6        0.82 ±  9%  perf-profile.children.cycles-pp.truncate_cleanup_page
      1.79 ±  2%      -0.6        1.21 ±  3%  perf-profile.children.cycles-pp.filemap_get_read_batch
      1.87 ±  3%      -0.6        1.29 ±  6%  perf-profile.children.cycles-pp.__entry_text_start
      1.30 ±  8%      -0.6        0.75 ± 10%  perf-profile.children.cycles-pp.__cancel_dirty_page
      1.55 ±  3%      -0.5        1.02 ±  7%  perf-profile.children.cycles-pp.xfs_file_write_checks
      1.08 ±  6%      -0.5        0.56 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      1.32 ±  6%      -0.5        0.80 ±  8%  perf-profile.children.cycles-pp.__activate_page
      1.57 ±  2%      -0.5        1.06 ±  4%  perf-profile.children.cycles-pp.xfs_ilock
      1.16 ±  8%      -0.5        0.65 ± 10%  perf-profile.children.cycles-pp.account_page_cleaned
      1.48 ±  2%      -0.5        1.02 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.44 ±  4%      -0.4        1.01 ±  4%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.85 ±  6%      -0.4        0.44 ±  7%  perf-profile.children.cycles-pp.uncharge_batch
      0.74 ±  7%      -0.4        0.38 ±  6%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.92 ±  4%      -0.4        0.57 ±  6%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      1.10 ±  3%      -0.3        0.76 ±  6%  perf-profile.children.cycles-pp.__fdget_pos
      1.20 ±  3%      -0.3        0.88 ±  3%  perf-profile.children.cycles-pp.memset_erms
      1.10 ±  5%      -0.3        0.78 ±  4%  perf-profile.children.cycles-pp.copyin
      0.92 ±  3%      -0.3        0.60 ±  6%  perf-profile.children.cycles-pp.touch_atime
      0.76 ±  7%      -0.3        0.45 ± 24%  perf-profile.children.cycles-pp.xfs_vn_update_time
      1.01 ±  4%      -0.3        0.71 ±  6%  perf-profile.children.cycles-pp.security_file_permission
      0.92 ±  3%      -0.3        0.61 ±  4%  perf-profile.children.cycles-pp.xfs_iunlock
      0.93 ±  3%      -0.3        0.63 ±  4%  perf-profile.children.cycles-pp.down_write
      0.94 ±  3%      -0.3        0.65 ±  4%  perf-profile.children.cycles-pp.xas_load
      0.93 ±  2%      -0.3        0.64 ±  6%  perf-profile.children.cycles-pp.__fget_light
      0.77 ±  5%      -0.3        0.49 ± 14%  perf-profile.children.cycles-pp.file_update_time
      0.82 ±  2%      -0.3        0.56 ±  3%  perf-profile.children.cycles-pp.___might_sleep
      0.54 ±  7%      -0.3        0.29 ±  5%  perf-profile.children.cycles-pp.page_counter_cancel
      1.27 ±  4%      -0.2        1.03 ±  8%  perf-profile.children.cycles-pp.__xfs_trans_commit
      1.26 ±  4%      -0.2        1.02 ±  8%  perf-profile.children.cycles-pp.xlog_cil_commit
      0.76 ±  4%      -0.2        0.53 ±  6%  perf-profile.children.cycles-pp.common_file_perm
      0.70 ±  3%      -0.2        0.48 ±  3%  perf-profile.children.cycles-pp.disk_rr
      0.52 ±  7%      -0.2        0.30 ±  9%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.62 ±  8%      -0.2        0.41 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock
      0.78 ±  2%      -0.2        0.56 ±  4%  perf-profile.children.cycles-pp.__alloc_pages
      0.71 ±  6%      -0.2        0.50 ±  4%  perf-profile.children.cycles-pp.ksys_lseek
      0.44 ±  7%      -0.2        0.26 ±  6%  perf-profile.children.cycles-pp.try_charge_memcg
      0.44 ± 10%      -0.2        0.26 ±  7%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.57 ±  2%      -0.2        0.39 ±  5%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.63 ±  3%      -0.2        0.46 ±  5%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.52 ±  3%      -0.2        0.36 ±  4%  perf-profile.children.cycles-pp.xfs_ilock_iocb
      0.49 ±  6%      -0.2        0.32 ±  6%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.54 ±  2%      -0.2        0.37 ±  4%  perf-profile.children.cycles-pp.atime_needs_update
      0.52 ±  5%      -0.2        0.36 ±  5%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.48 ±  3%      -0.2        0.32 ±  3%  perf-profile.children.cycles-pp.down_read
      0.54 ±  3%      -0.2        0.38 ±  6%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.47 ±  4%      -0.2        0.31 ±  6%  perf-profile.children.cycles-pp.xas_store
      0.39 ±  6%      -0.2        0.24 ±  8%  perf-profile.children.cycles-pp.lock_page_memcg
      0.44 ±  4%      -0.2        0.29 ±  7%  perf-profile.children.cycles-pp.up_write
      0.46 ±  3%      -0.2        0.31 ±  5%  perf-profile.children.cycles-pp.__cond_resched
      0.28 ±  8%      -0.1        0.13 ± 10%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.37 ±  7%      -0.1        0.22 ± 13%  perf-profile.children.cycles-pp.__count_memcg_events
      0.34 ±  7%      -0.1        0.19 ±  4%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.48 ±  3%      -0.1        0.33 ±  4%  perf-profile.children.cycles-pp.__might_sleep
      0.45 ± 10%      -0.1        0.31 ± 10%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      0.42 ±  3%      -0.1        0.29 ±  5%  perf-profile.children.cycles-pp.free_unref_page_list
      0.40 ±  6%      -0.1        0.27 ±  5%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.41 ±  2%      -0.1        0.29 ±  4%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.28 ±  8%      -0.1        0.15 ±  8%  perf-profile.children.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.24 ± 10%      -0.1        0.13 ±  8%  perf-profile.children.cycles-pp.xfs_trans_alloc
      0.36 ±  2%      -0.1        0.26 ±  3%  perf-profile.children.cycles-pp.current_time
      0.22 ± 11%      -0.1        0.11 ± 12%  perf-profile.children.cycles-pp.xfs_trans_reserve
      0.32 ±  8%      -0.1        0.21 ±  6%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.22 ± 10%      -0.1        0.12 ± 10%  perf-profile.children.cycles-pp.uncharge_page
      0.35 ±  3%      -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.xfs_break_layouts
      0.83 ±  6%      -0.1        0.73 ±  9%  perf-profile.children.cycles-pp.xlog_cil_insert_items
      0.21 ± 12%      -0.1        0.10 ±  9%  perf-profile.children.cycles-pp.xfs_log_reserve
      0.29 ±  3%      -0.1        0.18 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.73 ±  6%      -0.1        0.63 ±  3%  perf-profile.children.cycles-pp.xfs_generic_create
      0.39 ±  4%      -0.1        0.29 ±  5%  perf-profile.children.cycles-pp.rmqueue
      0.76 ±  4%      -0.1        0.66 ±  5%  perf-profile.children.cycles-pp.xfs_inactive
      0.32 ±  5%      -0.1        0.23 ±  6%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_end
      0.46 ±  4%      -0.1        0.36 ±  4%  perf-profile.children.cycles-pp.xfs_ifree
      0.30 ± 10%      -0.1        0.21 ± 11%  perf-profile.children.cycles-pp.xfs_buf_read_map
      0.28 ± 10%      -0.1        0.18 ± 12%  perf-profile.children.cycles-pp.xfs_buf_find
      0.13 ±  5%      -0.1        0.04 ± 44%  perf-profile.children.cycles-pp.xfs_inactive_truncate
      0.72 ±  6%      -0.1        0.62 ±  3%  perf-profile.children.cycles-pp.xfs_create
      0.29 ±  9%      -0.1        0.20 ± 12%  perf-profile.children.cycles-pp.xfs_buf_get_map
      0.29 ±  5%      -0.1        0.20 ±  5%  perf-profile.children.cycles-pp.xas_start
      0.25 ±  5%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.find_lock_entries
      0.27 ±  4%      -0.1        0.18 ±  4%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.18 ± 10%      -0.1        0.10 ± 18%  perf-profile.children.cycles-pp.lru_add_drain
      0.18 ±  9%      -0.1        0.10 ± 17%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.32 ±  5%      -0.1        0.23 ± 13%  perf-profile.children.cycles-pp.xfs_file_write_iter
      0.10 ±  4%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.xfs_itruncate_extents_flags
      0.22 ±  3%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.rcu_all_qs
      0.25 ±  5%      -0.1        0.17 ±  5%  perf-profile.children.cycles-pp.unlock_page
      0.12 ± 10%      -0.1        0.05 ± 47%  perf-profile.children.cycles-pp.xlog_grant_add_space
      0.22 ± 13%      -0.1        0.15 ± 12%  perf-profile.children.cycles-pp.xfs_dir_removename
      0.22 ± 12%      -0.1        0.15 ± 11%  perf-profile.children.cycles-pp.xfs_da3_node_lookup_int
      0.18 ±  5%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.xfs_bmbt_to_iomap
      0.19 ± 11%      -0.1        0.12 ± 14%  perf-profile.children.cycles-pp.xfs_read_agi
      0.24 ±  3%      -0.1        0.17 ±  7%  perf-profile.children.cycles-pp.xfs_iext_lookup_extent
      0.22 ±  6%      -0.1        0.15 ±  4%  perf-profile.children.cycles-pp.up_read
      0.20 ±  3%      -0.1        0.14 ±  7%  perf-profile.children.cycles-pp.aa_file_perm
      0.22 ±  3%      -0.1        0.15 ±  6%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.20 ±  2%      -0.1        0.13 ±  4%  perf-profile.children.cycles-pp.generic_write_checks
      0.21 ± 14%      -0.1        0.14 ±  9%  perf-profile.children.cycles-pp.xfs_dir2_node_removename
      0.20 ±  3%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.map_id_range_down
      0.20 ±  6%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.xfs_break_leased_layouts
      0.18 ±  9%      -0.1        0.12 ± 12%  perf-profile.children.cycles-pp.xfs_da_read_buf
      0.16 ± 13%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.16 ±  6%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.xfs_iunlink_remove
      0.14 ± 12%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.xfs_btree_lookup
      0.13 ±  3%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.__unlock_page_memcg
      0.13 ±  6%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.xfs_dir_createname
      0.16 ±  5%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.node_dirty_ok
      0.12 ±  4%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.xfs_dir2_node_addname
      0.08 ± 14%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.xfs_btree_read_buf_block
      0.15 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__might_fault
      0.14 ±  4%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.__free_one_page
      0.07 ±  5%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.generic_file_read_iter
      0.19 ±  4%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.xfs_errortag_test
      0.18 ±  7%      -0.0        0.14 ± 10%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.09 ± 11%      -0.0        0.04 ± 47%  perf-profile.children.cycles-pp.xfs_log_ticket_ungrant
      0.07            -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.10 ± 14%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.xfs_btree_lookup_get_block
      0.14 ±  5%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.timestamp_truncate
      0.13 ±  8%      -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.07 ±  5%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.file_remove_privs
      0.14 ±  5%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__list_add_valid
      0.13 ± 17%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp._xfs_trans_bjoin
      0.10 ± 13%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.__down
      0.12 ±  3%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.make_kgid
      0.07 ±  7%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.iov_iter_init
      0.11 ±  8%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.rw_verify_area
      0.11 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.11 ± 11%      -0.0        0.07 ± 16%  perf-profile.children.cycles-pp.xfs_buf_lock
      0.10 ± 13%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.down
      0.14 ±  4%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.10 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.file_modified
      0.10 ±  9%      -0.0        0.07 ± 16%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.14 ±  9%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.11 ±  6%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.xas_create
      0.10 ±  6%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.xas_init_marks
      0.06 ±  6%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.wake_up_q
      0.12 ±  7%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.12 ±  4%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.try_to_wake_up
      0.08 ±  6%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.balance_dirty_pages
      0.10 ±  6%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.xfs_bmapi_reserve_delalloc
      0.09 ± 14%      -0.0        0.06 ± 18%  perf-profile.children.cycles-pp.schedule_timeout
      0.12 ±  8%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.make_kuid
      0.11 ± 12%      -0.0        0.08 ± 14%  perf-profile.children.cycles-pp.xfs_da3_node_read
      0.28 ±  5%      -0.0        0.25 ±  5%  perf-profile.children.cycles-pp.xfs_difree
      0.11 ±  6%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.xfs_release
      0.09 ±  5%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.xfs_buf_unlock
      0.11 ±  8%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.09 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.xfs_buf_item_release
      0.09 ± 14%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.xfs_dir2_leafn_lookup_for_entry
      0.09 ± 12%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.xfs_dir3_data_check
      0.09 ± 12%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.__xfs_dir3_data_check
      0.11 ±  6%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.page_mapping
      0.10 ±  4%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.alloc_pages
      0.07 ± 10%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.write@plt
      0.10 ±  8%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__xa_set_mark
      0.07 ± 10%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.xas_find
      0.09 ±  7%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.rwsem_wake
      0.08 ±  8%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.up
      0.09 ±  4%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.xfs_free_eofblocks
      0.09            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.08 ±  8%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.xa_get_order
      0.08 ±  4%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.xas_clear_mark
      0.07 ±  7%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.iomap_page_create
      0.10 ±  3%      -0.0        0.08 ±  9%  perf-profile.children.cycles-pp.xfs_iread_extents
      0.08 ±  8%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.08 ±  9%      -0.0        0.05 ± 13%  perf-profile.children.cycles-pp.xfs_perag_get
      0.08 ± 10%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.open64
      0.10 ±  8%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.08 ±  6%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.07 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.07 ± 10%      +0.0        0.10 ± 21%  perf-profile.children.cycles-pp.update_cfs_group
      0.06 ±  9%      +0.0        0.09 ±  8%  perf-profile.children.cycles-pp.__xfs_btree_check_sblock
      0.10 ± 10%      +0.0        0.14 ± 20%  perf-profile.children.cycles-pp.update_load_avg
      0.08 ±  8%      +0.0        0.12 ±  7%  perf-profile.children.cycles-pp.xfs_btree_increment
      0.08 ±  4%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.xfs_btree_get_rec
      0.18 ± 10%      +0.0        0.23 ±  7%  perf-profile.children.cycles-pp.xfs_inobt_get_rec
      0.09 ±  5%      +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.xfs_btree_check_sblock
      0.02 ±142%      +0.1        0.10 ± 11%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.newidle_balance
      0.16 ±  5%      +0.1        0.25 ± 26%  perf-profile.children.cycles-pp.task_tick_fair
      0.15 ±  6%      +0.1        0.25 ±  4%  perf-profile.children.cycles-pp.memcpy_erms
      0.18 ±  4%      +0.1        0.29 ±  3%  perf-profile.children.cycles-pp.xfs_buf_item_format_segment
      0.18 ±  5%      +0.1        0.30 ±  3%  perf-profile.children.cycles-pp.xfs_buf_item_format
      0.00            +0.7        0.67 ±  6%  perf-profile.children.cycles-pp.xfs_inodegc_worker
      0.00            +0.7        0.68 ±  5%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.7        0.69 ±  6%  perf-profile.children.cycles-pp.worker_thread
      0.00            +0.7        0.70 ±  6%  perf-profile.children.cycles-pp.ret_from_fork
      0.00            +0.7        0.70 ±  6%  perf-profile.children.cycles-pp.kthread
     61.80 ±  4%      +8.6       70.42 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     61.22 ±  4%      +8.8       70.00 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
      2.26 ± 10%     +14.6       16.90 ±  2%  perf-profile.children.cycles-pp.unlink
      2.23 ± 10%     +14.6       16.87 ±  2%  perf-profile.children.cycles-pp.do_unlinkat
      2.03 ±  9%     +14.9       16.92 ±  3%  perf-profile.children.cycles-pp.do_sys_open
      2.03 ±  9%     +14.9       16.92 ±  3%  perf-profile.children.cycles-pp.do_sys_openat2
      1.98 ±  9%     +14.9       16.89 ±  3%  perf-profile.children.cycles-pp.path_openat
      1.99 ±  9%     +14.9       16.89 ±  3%  perf-profile.children.cycles-pp.do_filp_open
      1.98 ±  9%     +14.9       16.89 ±  3%  perf-profile.children.cycles-pp.creat64
      2.48 ± 10%     +29.8       32.32 ±  2%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.73 ±  6%     +29.9       30.67 ±  2%  perf-profile.children.cycles-pp.osq_lock
      3.50 ±  8%      -1.6        1.88 ± 17%  perf-profile.self.cycles-pp.__mod_memcg_state
      3.26 ± 14%      -1.6        1.67 ± 19%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      4.17 ±  3%      -1.3        2.85 ±  4%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      4.17 ±  2%      -1.3        2.90 ±  3%  perf-profile.self.cycles-pp.iomap_set_range_uptodate
      1.62 ±  4%      -0.7        0.89 ±  6%  perf-profile.self.cycles-pp.workingset_age_nonresident
      1.47 ± 10%      -0.7        0.78 ± 13%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      1.36 ±  9%      -0.6        0.76 ±  7%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      1.46 ±  2%      -0.5        1.00 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.36 ±  2%      -0.4        0.92 ±  3%  perf-profile.self.cycles-pp.filemap_get_read_batch
      0.78 ± 10%      -0.4        0.42 ± 20%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      1.19 ±  3%      -0.3        0.86 ±  3%  perf-profile.self.cycles-pp.memset_erms
      1.02 ±  2%      -0.3        0.70 ±  6%  perf-profile.self.cycles-pp.filemap_read
      0.89 ±  3%      -0.3        0.61 ±  6%  perf-profile.self.cycles-pp.__fget_light
      0.59 ±  8%      -0.3        0.32 ±  5%  perf-profile.self.cycles-pp.workingset_activation
      0.80 ±  3%      -0.3        0.54 ±  5%  perf-profile.self.cycles-pp.pagecache_get_page
      0.80 ±  2%      -0.3        0.54 ±  3%  perf-profile.self.cycles-pp.___might_sleep
      0.83 ±  3%      -0.3        0.58 ±  7%  perf-profile.self.cycles-pp.__entry_text_start
      0.54 ±  7%      -0.2        0.28 ±  5%  perf-profile.self.cycles-pp.page_counter_cancel
      0.62 ±  6%      -0.2        0.38 ±  4%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.52 ± 10%      -0.2        0.28 ± 18%  perf-profile.self.cycles-pp.mem_cgroup_charge
      0.70 ±  2%      -0.2        0.49 ±  4%  perf-profile.self.cycles-pp.iomap_apply
      0.67 ±  2%      -0.2        0.46 ±  4%  perf-profile.self.cycles-pp.xas_load
      0.63 ±  2%      -0.2        0.43 ±  4%  perf-profile.self.cycles-pp.disk_rr
      0.60 ±  4%      -0.2        0.42 ±  7%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_begin
      0.61 ±  3%      -0.2        0.43 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.56 ±  4%      -0.2        0.40 ±  7%  perf-profile.self.cycles-pp.common_file_perm
      0.50 ±  5%      -0.2        0.34 ±  4%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.54 ±  4%      -0.2        0.38 ±  5%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.50 ±  3%      -0.2        0.34 ±  5%  perf-profile.self.cycles-pp.write
      0.49 ±  4%      -0.2        0.33 ±  3%  perf-profile.self.cycles-pp.down_write
      0.36 ± 11%      -0.2        0.21 ±  9%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      0.38 ±  7%      -0.1        0.23 ±  7%  perf-profile.self.cycles-pp.lock_page_memcg
      0.37 ±  7%      -0.1        0.22 ± 13%  perf-profile.self.cycles-pp.__count_memcg_events
      0.28 ±  8%      -0.1        0.13 ± 10%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.48 ±  5%      -0.1        0.34 ±  4%  perf-profile.self.cycles-pp.read
      0.44 ±  3%      -0.1        0.30 ±  4%  perf-profile.self.cycles-pp.llseek
      0.50 ±  4%      -0.1        0.36 ±  5%  perf-profile.self.cycles-pp.mark_page_accessed
      0.42 ±  4%      -0.1        0.28 ±  6%  perf-profile.self.cycles-pp.up_write
      0.40 ±  5%      -0.1        0.26 ±  6%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.44 ±  6%      -0.1        0.30 ±  7%  perf-profile.self.cycles-pp.vfs_write
      0.38            -0.1        0.26 ±  5%  perf-profile.self.cycles-pp.release_pages
      0.40 ±  2%      -0.1        0.28 ±  5%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.43 ±  3%      -0.1        0.30 ±  4%  perf-profile.self.cycles-pp.__might_sleep
      0.37 ±  4%      -0.1        0.25 ±  5%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.39 ±  4%      -0.1        0.26 ±  3%  perf-profile.self.cycles-pp.iomap_write_end
      0.40 ±  4%      -0.1        0.28 ± 10%  perf-profile.self.cycles-pp.xfs_file_buffered_write
      0.34 ±  5%      -0.1        0.22 ±  5%  perf-profile.self.cycles-pp.__pagevec_lru_add
      0.41 ±  3%      -0.1        0.30 ±  4%  perf-profile.self.cycles-pp.iomap_write_begin
      0.27 ±  8%      -0.1        0.15 ±  9%  perf-profile.self.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.33 ±  4%      -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.40 ±  3%      -0.1        0.29 ± 16%  perf-profile.self.cycles-pp.xfs_file_read_iter
      0.26 ±  6%      -0.1        0.15 ±  4%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.21 ± 10%      -0.1        0.11 ± 13%  perf-profile.self.cycles-pp.uncharge_page
      0.30 ±  7%      -0.1        0.20 ±  6%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.29 ±  3%      -0.1        0.18 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.30 ±  6%      -0.1        0.20 ±  4%  perf-profile.self.cycles-pp.__activate_page
      0.33 ±  3%      -0.1        0.23 ±  4%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.32 ±  3%      -0.1        0.22 ±  6%  perf-profile.self.cycles-pp.iomap_write_actor
      0.29 ±  4%      -0.1        0.20 ±  4%  perf-profile.self.cycles-pp.down_read
      0.32 ±  6%      -0.1        0.22 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.27 ±  5%      -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.xfs_iunlock
      0.26 ±  6%      -0.1        0.18 ±  8%  perf-profile.self.cycles-pp.xas_start
      0.25 ±  6%      -0.1        0.17 ±  4%  perf-profile.self.cycles-pp.pagevec_lru_move_fn
      0.31 ±  4%      -0.1        0.23 ± 13%  perf-profile.self.cycles-pp.xfs_file_write_iter
      0.23 ±  5%      -0.1        0.15 ±  8%  perf-profile.self.cycles-pp.xfs_ilock
      0.23 ±  5%      -0.1        0.16 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
      0.24 ±  7%      -0.1        0.16 ±  6%  perf-profile.self.cycles-pp.new_sync_read
      0.12 ± 10%      -0.1        0.05 ± 47%  perf-profile.self.cycles-pp.xlog_grant_add_space
      0.23 ±  5%      -0.1        0.16 ±  5%  perf-profile.self.cycles-pp.__cond_resched
      0.24 ±  4%      -0.1        0.17 ±  4%  perf-profile.self.cycles-pp.unlock_page
      0.24 ±  7%      -0.1        0.17 ±  6%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_end
      0.24 ±  5%      -0.1        0.17 ±  6%  perf-profile.self.cycles-pp.vfs_read
      0.21 ±  5%      -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__set_page_dirty_nobuffers
      0.18 ±  5%      -0.1        0.11 ±  8%  perf-profile.self.cycles-pp.xfs_bmbt_to_iomap
      0.19 ±  5%      -0.1        0.12 ±  5%  perf-profile.self.cycles-pp.find_lock_entries
      0.23 ±  2%      -0.1        0.16 ±  7%  perf-profile.self.cycles-pp.xfs_iext_lookup_extent
      0.18 ±  4%      -0.1        0.12 ±  5%  perf-profile.self.cycles-pp.map_id_range_down
      0.19 ±  3%      -0.1        0.13 ±  6%  perf-profile.self.cycles-pp.new_sync_write
      0.21 ±  5%      -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.up_read
      0.18 ±  6%      -0.1        0.12 ±  6%  perf-profile.self.cycles-pp.xas_store
      0.19 ±  5%      -0.1        0.13 ±  8%  perf-profile.self.cycles-pp.security_file_permission
      0.09 ±  8%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.lock_page_lruvec_irqsave
      0.20 ±  5%      -0.1        0.14 ±  5%  perf-profile.self.cycles-pp.filemap_get_pages
      0.20 ±  3%      -0.1        0.14 ±  8%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.20 ±  5%      -0.1        0.14 ±  4%  perf-profile.self.cycles-pp.xfs_break_leased_layouts
      0.22 ±  8%      -0.1        0.17 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock
      0.18 ±  5%      -0.1        0.12 ±  8%  perf-profile.self.cycles-pp.__add_to_page_cache_locked
      0.17 ±  4%      -0.1        0.12 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.18 ±  4%      -0.1        0.13 ±  9%  perf-profile.self.cycles-pp.__fdget_pos
      0.16 ±  4%      -0.1        0.11 ±  6%  perf-profile.self.cycles-pp.aa_file_perm
      0.16 ±  4%      -0.1        0.10 ±  7%  perf-profile.self.cycles-pp.iov_iter_fault_in_readable
      0.15 ±  6%      -0.1        0.10 ± 11%  perf-profile.self.cycles-pp.atime_needs_update
      0.15 ±  5%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.rcu_all_qs
      0.14 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.xfs_file_write_checks
      0.14 ±  4%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.ksys_write
      0.13 ±  5%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.file_update_time
      0.11 ±  8%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__set_page_dirty
      0.14 ±  5%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__list_add_valid
      0.12 ±  4%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.__free_one_page
      0.12 ±  5%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.__unlock_page_memcg
      0.08 ±  8%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.xfs_log_ticket_ungrant
      0.13 ±  7%      -0.0        0.09 ±  6%  perf-profile.self.cycles-pp.ksys_lseek
      0.12 ±  9%      -0.0        0.08 ± 12%  perf-profile.self.cycles-pp.try_charge_memcg
      0.13 ±  6%      -0.0        0.09 ±  8%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.14 ±  7%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.ksys_read
      0.13 ±  6%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.timestamp_truncate
      0.13 ±  5%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.current_time
      0.10 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.generic_write_check_limits
      0.11 ±  8%      -0.0        0.07 ±  9%  perf-profile.self.cycles-pp.rw_verify_area
      0.06 ±  6%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.11 ±  5%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.node_dirty_ok
      0.16 ±  5%      -0.0        0.12 ±  8%  perf-profile.self.cycles-pp.xfs_errortag_test
      0.09 ±  7%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.07 ±  7%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.iomap_page_create
      0.11 ±  5%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.xfs_break_layouts
      0.10 ± 12%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.07 ±  6%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.xas_clear_mark
      0.11 ±  6%      -0.0        0.08        perf-profile.self.cycles-pp.iomap_file_buffered_write
      0.07 ± 10%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.xfs_file_buffered_read
      0.11 ±  6%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.page_mapping
      0.10 ±  9%      -0.0        0.07 ± 12%  perf-profile.self.cycles-pp.xlog_cil_commit
      0.09 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.__mod_lruvec_state
      0.07 ±  9%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.12 ± 11%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.10 ±  6%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.rmqueue
      0.10 ±  5%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.__alloc_pages
      0.09 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__cancel_dirty_page
      0.07 ±  5%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.lru_cache_add
      0.10 ±  3%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.xfs_iread_extents
      0.07 ±  8%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.xfs_perag_get
      0.09 ±  4%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.10 ±  8%      -0.0        0.07        perf-profile.self.cycles-pp.generic_write_checks
      0.07 ±  7%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.account_page_cleaned
      0.08 ±  7%      -0.0        0.06        perf-profile.self.cycles-pp.rcu_read_unlock_strict
      0.08 ±  5%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.07 ±  8%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.07 ±  9%      +0.0        0.10 ± 23%  perf-profile.self.cycles-pp.update_cfs_group
      0.04 ± 44%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.__xfs_btree_check_sblock
      0.06 ± 11%      +0.1        0.11 ± 20%  perf-profile.self.cycles-pp.update_load_avg
      0.15 ±  7%      +0.1        0.25 ±  4%  perf-profile.self.cycles-pp.memcpy_erms
      0.73 ±  6%     +29.7       30.44 ±  2%  perf-profile.self.cycles-pp.osq_lock


                                                                                
                                  aim7.jobs-per-min                             
                                                                                
  520000 +------------------------------------------------------------------+   
         |  .+. .+.+ .+.+.+. .+.+.+   +.+.  .+. .+.   .+. .+               .|   
  500000 |.+   +    +       +             ++   +   +.+   +  + .+.++.+.+.+.+ |   
         |                                                   +              |   
         |                                                                  |   
  480000 |-+                                                                |   
         |                                                                  |   
  460000 |-+                                                                |   
         |                                                                  |   
  440000 |-+                                                                |   
         |                                                                  |   
         |                                                                  |   
  420000 |-+   O O  O O   O   O O O   O    O     O O O                      |   
         | O O     O    O   O       O   O O  O O       O O O O O OO O       |   
  400000 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                               aim7.time.system_time                            
                                                                                
  1300 +--------------------------------------------------------------------+   
       |                                                                    |   
  1200 |-+                                        O   O   O   O             |   
       | O O             O O       O O O OO O O O   O   O   O   O O O       |   
  1100 |-+   O   O O O O     O O O                                          |   
       |       O                                                            |   
  1000 |-+                                                                  |   
       |                                                                    |   
   900 |-+                                                                  |   
       |                                                    +   +           |   
   800 |.+.       .+.                    ++.     .+.+.     + + + +   .+.+.  |   
       |   +.+.+.+   +                  +   +.+.+     +.+.+   +   +.+     +.|   
   700 |-+            + .+.+. .+.     .+                                    |   
       |               +     +   +.+.+                                      |   
   600 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             aim7.time.elapsed_time                             
                                                                                
  45 +----------------------------------------------------------------------+   
  44 |-O O     O     O O O     O O O O O  O O O         O O O O   O O       |   
     |     O O   O O       O O                  O O O O         O           |   
  43 |-+                                                                    |   
  42 |-+                                                                    |   
  41 |-+                                                                    |   
  40 |-+                                                                    |   
     |                                                                      |   
  39 |-+                                                                    |   
  38 |-+                                                                    |   
  37 |-+                                                                    |   
  36 |-+                                                   .+. .+. .+. .+.  |   
     |.+.+.+.+.+.+.+.+.+.+.+.+.+. .+.+.+..+.+.+.+.+.+.+.+.+   +   +   +   +.|   
  35 |-+                         +                                          |   
  34 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                           aim7.time.elapsed_time.max                           
                                                                                
  45 +----------------------------------------------------------------------+   
  44 |-O O     O     O O O     O O O O O  O O O         O O O O   O O       |   
     |     O O   O O       O O                  O O O O         O           |   
  43 |-+                                                                    |   
  42 |-+                                                                    |   
  41 |-+                                                                    |   
  40 |-+                                                                    |   
     |                                                                      |   
  39 |-+                                                                    |   
  38 |-+                                                                    |   
  37 |-+                                                                    |   
  36 |-+                                                   .+. .+. .+. .+.  |   
     |.+.+.+.+.+.+.+.+.+.+.+.+.+. .+.+.+..+.+.+.+.+.+.+.+.+   +   +   +   +.|   
  35 |-+                         +                                          |   
  34 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                        aim7.time.voluntary_context_switches                    
                                                                                
  950000 +------------------------------------------------------------------+   
         |.+.+.+.+.++.+   +   +       +   ++.+.+.+.+.+.+.+.+.+.+.++.+.+.+.+.|   
  900000 |-+                                                                |   
         |                                                                  |   
  850000 |-+                                                                |   
         |                                                                  |   
  800000 |-+                                                                |   
         |                                                                  |   
  750000 |-+                                                                |   
         |                                                                  |   
  700000 |-+                                                                |   
         |                                                                  |   
  650000 |-O O O O OO O O O O O O O   O O  O O O O O O O O O O O OO O       |   
         |                          O     O                                 |   
  600000 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       aim7.time.involuntary_context_switches                   
                                                                                
  30000 +-------------------------------------------------------------------+   
        | O   O   O   O OO O O O O O O O O O O O O     O O O  O O O         |   
  25000 |-+ O   O                                    O      O       O       |   
        |                                                                   |   
        |                                                                   |   
  20000 |-+                                                                 |   
        |                                                                   |   
  15000 |-+                                                                 |   
        |                                                                   |   
  10000 |-+                                                                 |   
        |                                                                   |   
        |                                                                   |   
   5000 |-+                                                                 |   
        |.+.+.+.+.+.+.+.++.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+.++.+.+.+.+.+.+.+.|   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2sp9: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/4BRD_12G/xfs/x86_64-rhel-8.3/3000/RAID1/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp9/disk_wrt/aim7/0x5003006

commit: 
  62af7d54a0 ("xfs: detach dquots from inode if we don't need to inactivate it")
  ab23a77687 ("xfs: per-cpu deferred inode inactivation queues")

62af7d54a0ec0b6f ab23a7768739a23d21d8a16ca37 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    539153           -15.8%     453764        aim7.jobs-per-min
     33.59           +18.7%      39.87        aim7.time.elapsed_time
     33.59           +18.7%      39.87        aim7.time.elapsed_time.max
      2095 ±  9%    +781.6%      18470 ±  2%  aim7.time.involuntary_context_switches
    677.33 ±  6%     +30.4%     883.40 ±  2%  aim7.time.system_time
    911794           -34.6%     596090        aim7.time.voluntary_context_switches
 2.374e+09 ±  2%     +12.4%  2.667e+09        cpuidle..time
     76.88            -3.5%      74.22        iostat.cpu.idle
     22.31 ±  5%     +12.3%      25.06 ±  2%  iostat.cpu.system
     22.21 ±  5%      +2.7       24.93 ±  2%  mpstat.cpu.all.sys%
      0.79 ±  4%      -0.1        0.69 ±  2%  mpstat.cpu.all.usr%
      2509 ± 20%    +125.0%       5645 ± 11%  vmstat.io.bo
     51900 ±  2%     -14.6%      44300        vmstat.system.cs
     13091 ± 15%     +27.3%      16663 ±  6%  numa-meminfo.node1.Active
     13027 ± 15%     +27.3%      16586 ±  7%  numa-meminfo.node1.Active(anon)
      4800 ±  6%     -23.1%       3689 ± 14%  numa-meminfo.node1.Dirty
    668.62 ±  4%     +11.6%     746.50 ±  2%  turbostat.Avg_MHz
     24.51 ±  4%      +2.8       27.36 ±  2%  turbostat.Busy%
     92348 ±  6%     +51.0%     139401 ± 25%  turbostat.C1
      1387 ± 16%     -26.2%       1024 ± 13%  numa-vmstat.node0.nr_dirty
      1213 ± 14%     -30.2%     847.17 ± 13%  numa-vmstat.node0.nr_zone_write_pending
      3257 ± 15%     +27.3%       4146 ±  7%  numa-vmstat.node1.nr_active_anon
      1264 ± 15%     -26.0%     935.75 ± 11%  numa-vmstat.node1.nr_dirty
      3257 ± 15%     +27.3%       4146 ±  7%  numa-vmstat.node1.nr_zone_active_anon
      1099 ± 18%     -29.7%     773.50 ± 13%  numa-vmstat.node1.nr_zone_write_pending
      2765 ±  9%     -25.3%       2065 ±  8%  proc-vmstat.nr_dirty
      2978 ±  8%     -22.6%       2303 ±  7%  proc-vmstat.nr_inactive_file
     33194            +4.1%      34569        proc-vmstat.nr_slab_reclaimable
     74080            +1.7%      75360        proc-vmstat.nr_slab_unreclaimable
      2977 ±  8%     -22.6%       2304 ±  7%  proc-vmstat.nr_zone_inactive_file
      2412 ±  9%     -27.2%       1756 ±  7%  proc-vmstat.nr_zone_write_pending
     92926 ± 20%    +161.7%     243145 ± 10%  proc-vmstat.pgpgout
      1883           +19.4%       2249 ±  2%  slabinfo.kmalloc-4k.active_objs
      1898           +19.9%       2275 ±  2%  slabinfo.kmalloc-4k.num_objs
     21977           +10.2%      24229        slabinfo.kmalloc-512.active_objs
    715.54 ±  2%     +14.1%     816.42        slabinfo.kmalloc-512.active_slabs
     22909 ±  2%     +14.1%      26145        slabinfo.kmalloc-512.num_objs
    715.54 ±  2%     +14.1%     816.42        slabinfo.kmalloc-512.num_slabs
     39566 ±  2%     +12.1%      44364        slabinfo.radix_tree_node.active_objs
     39622 ±  2%     +12.0%      44395        slabinfo.radix_tree_node.num_objs
      3102 ± 11%     +40.0%       4344 ±  8%  slabinfo.xfs_ili.active_objs
      3144 ± 12%     +42.3%       4474 ± 10%  slabinfo.xfs_ili.num_objs
      2801 ±  7%     +43.1%       4010 ±  7%  slabinfo.xfs_inode.active_objs
      2913 ±  7%     +39.4%       4062 ±  7%  slabinfo.xfs_inode.num_objs
  48494753 ±  8%     -15.0%   41219157 ±  4%  perf-stat.i.branch-misses
  45528191 ±  3%     -15.9%   38310053 ±  3%  perf-stat.i.cache-misses
 1.857e+08 ±  4%     -21.9%   1.45e+08 ±  6%  perf-stat.i.cache-references
     54185           -15.9%      45593        perf-stat.i.context-switches
 5.874e+10 ±  5%     +11.6%  6.554e+10 ±  2%  perf-stat.i.cpu-cycles
      2345 ±  9%     -21.9%       1830 ±  2%  perf-stat.i.cpu-migrations
 6.473e+09           -13.4%  5.604e+09        perf-stat.i.dTLB-stores
     71.33            +4.9       76.21 ±  4%  perf-stat.i.iTLB-load-miss-rate%
  25617640 ±  4%     -17.4%   21164719 ±  5%  perf-stat.i.iTLB-load-misses
   4983138 ±  2%     -22.0%    3887008 ±  6%  perf-stat.i.iTLB-loads
      0.66 ±  3%     -10.2%       0.59 ±  2%  perf-stat.i.ipc
      0.67 ±  5%     +11.6%       0.74 ±  2%  perf-stat.i.metric.GHz
      8765 ±  3%     -11.6%       7749 ±  3%  perf-stat.i.minor-faults
   8175500 ±  3%     -16.1%    6855494 ±  2%  perf-stat.i.node-load-misses
   2450822 ±  3%      -8.2%    2250687        perf-stat.i.node-loads
   2447961 ±  2%      -7.1%    2273384 ±  2%  perf-stat.i.node-store-misses
   3998752            -8.6%    3653532        perf-stat.i.node-stores
      8826 ±  2%     -11.7%       7789 ±  3%  perf-stat.i.page-faults
      4.46 ±  4%     -22.2%       3.47 ±  6%  perf-stat.overall.MPKI
      0.60 ±  8%      -0.1        0.51 ±  4%  perf-stat.overall.branch-miss-rate%
      1.41 ±  5%     +11.3%       1.57 ±  2%  perf-stat.overall.cpi
      1289 ±  4%     +32.7%       1712 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.00 ± 14%      +0.0        0.00 ± 12%  perf-stat.overall.dTLB-store-miss-rate%
      1629 ±  3%     +21.6%       1981 ±  5%  perf-stat.overall.instructions-per-iTLB-miss
      0.71 ±  5%     -10.3%       0.64 ±  2%  perf-stat.overall.ipc
  47147341 ±  8%     -14.7%   40218426 ±  4%  perf-stat.ps.branch-misses
  44325543 ±  3%     -15.6%   37421156 ±  3%  perf-stat.ps.cache-misses
 1.808e+08 ±  4%     -21.7%  1.416e+08 ±  6%  perf-stat.ps.cache-references
     52750           -15.6%      44536        perf-stat.ps.context-switches
 5.718e+10 ±  5%     +12.0%  6.404e+10 ±  2%  perf-stat.ps.cpu-cycles
      2283 ±  9%     -21.7%       1788 ±  2%  perf-stat.ps.cpu-migrations
 6.302e+09           -13.1%  5.475e+09        perf-stat.ps.dTLB-stores
  24940923 ±  4%     -17.1%   20678640 ±  5%  perf-stat.ps.iTLB-load-misses
   4847980 ±  2%     -21.7%    3795653 ±  6%  perf-stat.ps.iTLB-loads
      8463 ±  3%     -11.1%       7527 ±  3%  perf-stat.ps.minor-faults
   7959949 ±  3%     -15.9%    6696480 ±  2%  perf-stat.ps.node-load-misses
   2385673 ±  3%      -7.8%    2198682        perf-stat.ps.node-loads
   2383292 ±  2%      -6.8%    2220315 ±  2%  perf-stat.ps.node-store-misses
   3892876            -8.3%    3569550        perf-stat.ps.node-stores
      8521 ±  3%     -11.2%       7566 ±  3%  perf-stat.ps.page-faults
 1.413e+12 ±  2%     +17.6%  1.662e+12        perf-stat.total.instructions
     44.77 ± 25%    +209.9%     138.75 ± 15%  interrupts.CPU0.RES:Rescheduling_interrupts
     46.15 ± 19%    +170.5%     124.83 ± 15%  interrupts.CPU1.RES:Rescheduling_interrupts
     39.85 ± 16%    +183.8%     113.08 ± 21%  interrupts.CPU10.RES:Rescheduling_interrupts
     41.69 ± 13%    +191.2%     121.42 ± 18%  interrupts.CPU11.RES:Rescheduling_interrupts
     38.92 ± 12%    +195.7%     115.08 ± 20%  interrupts.CPU12.RES:Rescheduling_interrupts
     43.31 ± 26%    +166.1%     115.25 ± 18%  interrupts.CPU13.RES:Rescheduling_interrupts
     42.62 ± 14%    +204.9%     129.92 ± 21%  interrupts.CPU14.RES:Rescheduling_interrupts
     41.08 ± 23%    +181.6%     115.67 ± 16%  interrupts.CPU15.RES:Rescheduling_interrupts
     38.46 ± 14%    +188.2%     110.83 ± 14%  interrupts.CPU16.RES:Rescheduling_interrupts
     39.62 ± 16%    +215.5%     125.00 ± 16%  interrupts.CPU17.RES:Rescheduling_interrupts
     40.23 ± 17%    +202.6%     121.75 ± 22%  interrupts.CPU18.RES:Rescheduling_interrupts
     40.31 ± 15%    +193.8%     118.42 ± 20%  interrupts.CPU19.RES:Rescheduling_interrupts
     48.77 ± 34%    +138.0%     116.08 ± 21%  interrupts.CPU2.RES:Rescheduling_interrupts
     40.77 ± 32%    +173.9%     111.67 ± 14%  interrupts.CPU20.RES:Rescheduling_interrupts
     39.08 ± 18%    +228.6%     128.42 ± 17%  interrupts.CPU21.RES:Rescheduling_interrupts
     38.00 ± 15%    +202.9%     115.08 ± 12%  interrupts.CPU22.RES:Rescheduling_interrupts
     38.15 ± 20%    +225.9%     124.33 ± 17%  interrupts.CPU23.RES:Rescheduling_interrupts
     33.77 ± 13%    +214.9%     106.33 ± 15%  interrupts.CPU24.RES:Rescheduling_interrupts
     32.77 ± 19%    +229.1%     107.83 ± 13%  interrupts.CPU25.RES:Rescheduling_interrupts
     31.23 ± 19%    +256.5%     111.33 ± 13%  interrupts.CPU26.RES:Rescheduling_interrupts
     33.00 ± 19%    +226.5%     107.75 ± 17%  interrupts.CPU27.RES:Rescheduling_interrupts
     30.62 ± 21%    +266.9%     112.33 ± 11%  interrupts.CPU28.RES:Rescheduling_interrupts
     35.15 ± 13%    +195.1%     103.75 ± 14%  interrupts.CPU29.RES:Rescheduling_interrupts
     41.77 ± 29%    +183.3%     118.33 ± 15%  interrupts.CPU3.RES:Rescheduling_interrupts
     33.62 ± 15%    +230.5%     111.08 ± 19%  interrupts.CPU30.RES:Rescheduling_interrupts
     32.15 ± 20%    +228.6%     105.67 ± 22%  interrupts.CPU31.RES:Rescheduling_interrupts
     30.15 ± 19%    +254.8%     107.00 ± 20%  interrupts.CPU32.RES:Rescheduling_interrupts
     34.08 ± 17%    +225.2%     110.83 ± 17%  interrupts.CPU33.RES:Rescheduling_interrupts
     33.46 ± 11%    +216.8%     106.00 ± 19%  interrupts.CPU34.RES:Rescheduling_interrupts
     31.54 ± 16%    +256.7%     112.50 ± 16%  interrupts.CPU35.RES:Rescheduling_interrupts
     34.00 ± 10%    +278.7%     128.75 ± 18%  interrupts.CPU36.RES:Rescheduling_interrupts
     31.31 ± 18%    +270.0%     115.83 ± 23%  interrupts.CPU37.RES:Rescheduling_interrupts
     33.31 ± 12%    +242.0%     113.92 ± 19%  interrupts.CPU38.RES:Rescheduling_interrupts
     35.23 ± 19%    +221.9%     113.42 ± 18%  interrupts.CPU39.RES:Rescheduling_interrupts
     43.38 ± 41%    +167.2%     115.92 ± 13%  interrupts.CPU4.RES:Rescheduling_interrupts
     38.85 ± 25%    +201.8%     117.25 ± 16%  interrupts.CPU40.RES:Rescheduling_interrupts
     34.15 ± 20%    +221.8%     109.92 ± 14%  interrupts.CPU41.RES:Rescheduling_interrupts
     39.46 ± 31%    +178.3%     109.83 ± 15%  interrupts.CPU42.RES:Rescheduling_interrupts
     34.46 ± 19%    +241.4%     117.67 ± 18%  interrupts.CPU44.RES:Rescheduling_interrupts
     31.62 ± 15%    +254.8%     112.17 ± 22%  interrupts.CPU45.RES:Rescheduling_interrupts
     30.69 ± 16%    +278.5%     116.17 ± 16%  interrupts.CPU46.RES:Rescheduling_interrupts
     32.85 ± 18%    +251.4%     115.42 ± 12%  interrupts.CPU47.RES:Rescheduling_interrupts
     30.54 ± 17%    +274.7%     114.42 ± 13%  interrupts.CPU48.RES:Rescheduling_interrupts
     27.23 ± 21%    +297.8%     108.33 ± 12%  interrupts.CPU49.RES:Rescheduling_interrupts
     42.00 ± 19%    +168.7%     112.83 ± 17%  interrupts.CPU5.RES:Rescheduling_interrupts
     33.77 ± 25%    +247.7%     117.42 ± 21%  interrupts.CPU50.RES:Rescheduling_interrupts
     33.54 ± 22%    +239.4%     113.83 ± 18%  interrupts.CPU51.RES:Rescheduling_interrupts
     29.85 ± 21%    +316.6%     124.33 ± 20%  interrupts.CPU52.RES:Rescheduling_interrupts
     32.31 ± 40%    +254.9%     114.67 ± 16%  interrupts.CPU53.RES:Rescheduling_interrupts
     30.31 ± 14%    +272.8%     113.00 ± 12%  interrupts.CPU54.RES:Rescheduling_interrupts
     35.54 ± 18%    +213.0%     111.25 ± 12%  interrupts.CPU55.RES:Rescheduling_interrupts
     30.31 ± 16%    +260.5%     109.25 ± 21%  interrupts.CPU56.RES:Rescheduling_interrupts
     28.54 ± 17%    +300.9%     114.42 ± 18%  interrupts.CPU57.RES:Rescheduling_interrupts
     31.38 ± 28%    +242.5%     107.50 ± 13%  interrupts.CPU58.RES:Rescheduling_interrupts
     32.85 ± 43%    +274.5%     123.00 ± 20%  interrupts.CPU59.RES:Rescheduling_interrupts
     43.46 ± 24%    +189.7%     125.92 ± 18%  interrupts.CPU6.RES:Rescheduling_interrupts
     28.62 ± 15%    +308.9%     117.00 ± 17%  interrupts.CPU60.RES:Rescheduling_interrupts
     29.15 ± 22%    +324.5%     123.75 ± 18%  interrupts.CPU61.RES:Rescheduling_interrupts
     44.31 ± 36%    +171.2%     120.17 ± 19%  interrupts.CPU62.RES:Rescheduling_interrupts
     46.23 ± 32%    +177.6%     128.33 ± 28%  interrupts.CPU63.RES:Rescheduling_interrupts
     38.77 ± 30%    +236.2%     130.33 ± 16%  interrupts.CPU64.RES:Rescheduling_interrupts
     36.54 ± 30%    +254.9%     129.67 ± 17%  interrupts.CPU65.RES:Rescheduling_interrupts
     27.38 ± 29%    +336.1%     119.42 ± 22%  interrupts.CPU66.RES:Rescheduling_interrupts
     26.54 ± 19%    +334.9%     115.42 ± 23%  interrupts.CPU67.RES:Rescheduling_interrupts
     27.38 ± 20%    +291.3%     107.17 ± 14%  interrupts.CPU68.RES:Rescheduling_interrupts
     28.00 ± 18%    +300.6%     112.17 ± 25%  interrupts.CPU69.RES:Rescheduling_interrupts
     40.08 ± 15%    +189.2%     115.92 ± 19%  interrupts.CPU7.RES:Rescheduling_interrupts
     29.54 ± 16%    +263.1%     107.25 ± 23%  interrupts.CPU70.RES:Rescheduling_interrupts
     28.31 ± 20%    +291.8%     110.92 ± 14%  interrupts.CPU71.RES:Rescheduling_interrupts
     29.31 ± 17%    +256.3%     104.42 ± 20%  interrupts.CPU72.RES:Rescheduling_interrupts
     26.85 ± 22%    +325.0%     114.08 ± 22%  interrupts.CPU73.RES:Rescheduling_interrupts
     26.77 ± 29%    +303.8%     108.08 ± 17%  interrupts.CPU74.RES:Rescheduling_interrupts
     25.77 ± 22%    +323.0%     109.00 ± 13%  interrupts.CPU75.RES:Rescheduling_interrupts
     27.92 ± 24%    +275.1%     104.75 ± 24%  interrupts.CPU76.RES:Rescheduling_interrupts
     28.54 ± 20%    +306.8%     116.08 ± 17%  interrupts.CPU77.RES:Rescheduling_interrupts
     26.46 ± 35%    +341.8%     116.92 ± 21%  interrupts.CPU78.RES:Rescheduling_interrupts
     27.23 ± 35%    +264.2%      99.17 ± 24%  interrupts.CPU79.RES:Rescheduling_interrupts
     36.31 ± 15%    +241.8%     124.08 ± 21%  interrupts.CPU8.RES:Rescheduling_interrupts
     27.38 ± 29%    +278.3%     103.58 ± 21%  interrupts.CPU80.RES:Rescheduling_interrupts
     29.00 ± 28%    +272.1%     107.92 ± 26%  interrupts.CPU81.RES:Rescheduling_interrupts
     28.08 ± 31%    +292.1%     110.08 ± 21%  interrupts.CPU82.RES:Rescheduling_interrupts
     26.54 ± 29%    +285.6%     102.33 ± 29%  interrupts.CPU83.RES:Rescheduling_interrupts
     44.23 ± 26%    +151.5%     111.25 ± 18%  interrupts.CPU84.RES:Rescheduling_interrupts
     47.08 ± 29%    +159.2%     122.00 ± 17%  interrupts.CPU85.RES:Rescheduling_interrupts
     44.15 ± 46%    +166.7%     117.75 ± 25%  interrupts.CPU86.RES:Rescheduling_interrupts
     49.15 ± 39%    +133.6%     114.83 ± 12%  interrupts.CPU87.RES:Rescheduling_interrupts
     40.62 ± 23%    +187.2%     116.67 ± 10%  interrupts.CPU9.RES:Rescheduling_interrupts
      3083 ±  4%    +227.7%      10106        interrupts.RES:Rescheduling_interrupts
     51.63 ±  3%     -15.5       36.12 ±  3%  perf-profile.calltrace.cycles-pp.write
     49.57 ±  3%     -14.8       34.82 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     49.22 ±  3%     -14.7       34.51 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     48.56 ±  3%     -14.6       33.97 ±  3%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     47.73 ±  3%     -14.4       33.30 ±  3%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     45.73 ±  3%     -14.1       31.60 ±  3%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     44.86 ±  3%     -14.0       30.89 ±  3%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
     40.90 ±  3%     -13.1       27.79 ±  3%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
     40.72 ±  3%     -13.1       27.64 ±  3%  perf-profile.calltrace.cycles-pp.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write.vfs_write
     35.73 ±  3%     -12.1       23.66 ±  4%  perf-profile.calltrace.cycles-pp.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
     24.24 ±  5%      -9.2       15.02 ±  6%  perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
     19.52 ±  7%      -8.6       10.96 ±  9%  perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
     19.33 ±  7%      -8.5       10.80 ±  9%  perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply
     16.37 ±  9%      -8.0        8.36 ± 12%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
     28.41 ±  8%      -7.9       20.49 ± 10%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     14.95 ±  8%      -7.9        7.10 ± 12%  perf-profile.calltrace.cycles-pp.__close
     14.94 ±  8%      -7.8        7.09 ± 12%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     14.93 ±  8%      -7.8        7.08 ± 12%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     14.94 ±  8%      -7.8        7.09 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     14.93 ±  8%      -7.8        7.08 ± 12%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     14.92 ±  9%      -7.8        7.08 ± 12%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.91 ±  9%      -7.8        7.08 ± 12%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     14.90 ±  9%      -7.8        7.06 ± 12%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
     14.88 ±  9%      -7.8        7.05 ± 12%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_prepare
     28.05 ±  8%      -7.8       20.24 ± 10%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     28.05 ±  8%      -7.8       20.24 ± 10%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     28.04 ±  8%      -7.8       20.24 ± 10%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     27.72 ±  8%      -7.7       20.01 ± 10%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     27.67 ±  8%      -7.7       19.97 ± 10%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     26.84 ±  8%      -7.5       19.33 ± 10%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     13.92 ±  9%      -6.9        7.02 ± 12%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
     13.90 ±  9%      -6.9        7.00 ± 12%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.__dentry_kill.dput.__fput
      9.49 ± 14%      -5.5        3.98 ± 19%  perf-profile.calltrace.cycles-pp.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill.dput
      9.07 ± 14%      -5.2        3.84 ± 19%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill
      7.83 ± 16%      -4.6        3.26 ± 20%  perf-profile.calltrace.cycles-pp.lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      7.71 ± 16%      -4.5        3.17 ± 21%  perf-profile.calltrace.cycles-pp.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      6.39 ± 19%      -4.3        2.09 ± 32%  perf-profile.calltrace.cycles-pp.lock_page_lruvec_irqsave.release_pages.__pagevec_release.truncate_inode_pages_range.evict
      6.36 ± 20%      -4.3        2.07 ± 32%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.release_pages.__pagevec_release.truncate_inode_pages_range
      6.32 ± 20%      -4.3        2.04 ± 32%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.release_pages.__pagevec_release
      5.88 ± 20%      -3.9        1.96 ± 31%  perf-profile.calltrace.cycles-pp.lock_page_lruvec_irqsave.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru.pagecache_get_page
      5.84 ± 21%      -3.9        1.93 ± 31%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru
      5.80 ± 21%      -3.9        1.90 ± 32%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.__pagevec_lru_add.lru_cache_add
      8.49 ±  4%      -3.4        5.05 ±  7%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      5.34 ±  5%      -2.4        2.97 ± 10%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      7.31 ±  4%      -2.1        5.25 ±  3%  perf-profile.calltrace.cycles-pp.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      4.72 ±  3%      -1.6        3.14 ±  4%  perf-profile.calltrace.cycles-pp.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      3.39 ±  3%      -1.2        2.18 ±  5%  perf-profile.calltrace.cycles-pp.__set_page_dirty.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor.iomap_apply
      2.20 ±  5%      -1.0        1.22 ±  9%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      2.21 ±  4%      -0.9        1.29 ±  8%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.__set_page_dirty.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor
      2.23 ±  4%      -0.9        1.33 ±  7%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      2.12 ±  4%      -0.9        1.22 ±  9%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      2.25 ±  2%      -0.8        1.46 ±  5%  perf-profile.calltrace.cycles-pp.truncate_cleanup_page.truncate_inode_pages_range.evict.__dentry_kill.dput
      2.08 ±  3%      -0.8        1.33 ±  6%  perf-profile.calltrace.cycles-pp.__cancel_dirty_page.truncate_cleanup_page.truncate_inode_pages_range.evict.__dentry_kill
      1.86 ±  3%      -0.7        1.15 ±  7%  perf-profile.calltrace.cycles-pp.account_page_cleaned.__cancel_dirty_page.truncate_cleanup_page.truncate_inode_pages_range.evict
      3.26 ±  8%      -0.6        2.61 ±  3%  perf-profile.calltrace.cycles-pp.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
      1.57 ±  5%      -0.6        0.93 ±  8%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.account_page_cleaned.__cancel_dirty_page.truncate_cleanup_page.truncate_inode_pages_range
      1.41 ±  6%      -0.6        0.79 ± 10%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.__set_page_dirty.__set_page_dirty_nobuffers.iomap_write_end
      0.89 ±  7%      -0.6        0.27 ±100%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__mod_lruvec_page_state.account_page_cleaned.__cancel_dirty_page
      1.27 ±  6%      -0.6        0.70 ± 11%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__mod_lruvec_page_state.__set_page_dirty.__set_page_dirty_nobuffers
      1.30 ±  6%      -0.6        0.75 ± 10%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      0.92 ±  6%      -0.5        0.38 ± 71%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru.pagecache_get_page
      1.01 ±  7%      -0.5        0.48 ± 45%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.account_page_cleaned.__cancel_dirty_page.truncate_cleanup_page
      2.21 ±  9%      -0.5        1.69 ±  2%  perf-profile.calltrace.cycles-pp.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
      1.17 ±  6%      -0.5        0.65 ± 11%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__mod_lruvec_page_state.__add_to_page_cache_locked.add_to_page_cache_lru
      1.26 ±  3%      -0.5        0.76 ±  6%  perf-profile.calltrace.cycles-pp.mem_cgroup_uncharge_list.release_pages.__pagevec_release.truncate_inode_pages_range.evict
      1.67 ±  3%      -0.5        1.17 ±  4%  perf-profile.calltrace.cycles-pp.delete_from_page_cache_batch.truncate_inode_pages_range.evict.__dentry_kill.dput
      1.22 ± 28%      -0.5        0.77 ±  4%  perf-profile.calltrace.cycles-pp.__entry_text_start.write
      2.72 ±  7%      -0.4        2.32 ±  3%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.06 ±  4%      -0.4        0.67 ±  8%  perf-profile.calltrace.cycles-pp.unaccount_page_cache_page.delete_from_page_cache_batch.truncate_inode_pages_range.evict.__dentry_kill
      0.98 ±  5%      -0.4        0.60 ±  8%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.unaccount_page_cache_page.delete_from_page_cache_batch.truncate_inode_pages_range.evict
      2.06 ±  7%      -0.4        1.71 ±  3%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      0.61 ±  8%      -0.4        0.26 ±100%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.06 ± 13%      -0.3        0.73 ±  4%  perf-profile.calltrace.cycles-pp.file_update_time.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write
      1.75 ±  7%      -0.3        1.45 ±  3%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.58 ±  8%      -0.3        1.31 ±  3%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.43 ±  8%      -0.2        1.19 ±  3%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply
      0.85 ±  6%      -0.2        0.68 ±  4%  perf-profile.calltrace.cycles-pp.xfs_ilock.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      0.79 ±  7%      -0.2        0.64 ±  3%  perf-profile.calltrace.cycles-pp.iov_iter_fault_in_readable.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      0.90 ±  7%      -0.2        0.75 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      0.71 ±  6%      -0.1        0.58 ±  4%  perf-profile.calltrace.cycles-pp.down_write.xfs_ilock.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write
      0.70 ±  7%      -0.1        0.56 ±  4%  perf-profile.calltrace.cycles-pp.xfs_ilock.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
      1.20 ±  4%      -0.1        1.08 ±  3%  perf-profile.calltrace.cycles-pp.memset_erms.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.68 ±  7%      -0.1        0.56 ±  3%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      0.69 ±  5%      -0.1        0.60 ±  4%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.77 ±  5%  perf-profile.calltrace.cycles-pp.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread
      0.00            +0.8        0.84 ±  4%  perf-profile.calltrace.cycles-pp.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread.kthread
      0.00            +0.8        0.85 ±  4%  perf-profile.calltrace.cycles-pp.xfs_inodegc_worker.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.9        0.90 ±  5%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.9        0.90 ±  5%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.00            +0.9        0.94 ±  5%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.00            +0.9        0.94 ±  5%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.00           +14.8       14.80 ±  7%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      2.10 ± 11%     +14.8       16.92 ±  6%  perf-profile.calltrace.cycles-pp.creat64
      2.09 ± 11%     +14.8       16.90 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      2.09 ± 11%     +14.8       16.90 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      2.08 ± 11%     +14.8       16.90 ±  6%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      2.07 ± 11%     +14.8       16.90 ±  6%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      2.05 ± 11%     +14.8       16.88 ±  6%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.04 ± 11%     +14.8       16.87 ±  6%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.81 ±  9%     +14.9       15.70 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.59 ±  9%     +15.1       15.64 ±  5%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.54 ±  9%     +15.2       16.72 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      2.27 ± 11%     +15.2       17.51 ±  4%  perf-profile.calltrace.cycles-pp.unlink
      2.25 ± 11%     +15.2       17.49 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      2.24 ± 11%     +15.2       17.49 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      2.23 ± 11%     +15.2       17.47 ±  4%  perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
     51.75 ±  3%     -15.2       36.56 ±  3%  perf-profile.children.cycles-pp.write
     48.60 ±  3%     -14.6       34.00 ±  3%  perf-profile.children.cycles-pp.ksys_write
     47.78 ±  3%     -14.4       33.33 ±  3%  perf-profile.children.cycles-pp.vfs_write
     45.75 ±  3%     -14.1       31.61 ±  3%  perf-profile.children.cycles-pp.new_sync_write
     44.90 ±  3%     -14.0       30.92 ±  3%  perf-profile.children.cycles-pp.xfs_file_buffered_write
     40.91 ±  3%     -13.1       27.79 ±  3%  perf-profile.children.cycles-pp.iomap_file_buffered_write
     40.75 ±  3%     -13.1       27.66 ±  3%  perf-profile.children.cycles-pp.iomap_apply
     35.80 ±  3%     -12.1       23.71 ±  4%  perf-profile.children.cycles-pp.iomap_write_actor
     24.26 ±  5%      -9.2       15.04 ±  6%  perf-profile.children.cycles-pp.iomap_write_begin
     19.55 ±  7%      -8.6       10.98 ±  9%  perf-profile.children.cycles-pp.grab_cache_page_write_begin
     12.76 ± 20%      -8.6        4.20 ± 31%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     19.40 ±  7%      -8.5       10.86 ±  9%  perf-profile.children.cycles-pp.pagecache_get_page
     12.87 ± 19%      -8.5        4.35 ± 30%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     12.66 ± 20%      -8.5        4.17 ± 31%  perf-profile.children.cycles-pp.lock_page_lruvec_irqsave
     16.38 ±  9%      -8.0        8.36 ± 12%  perf-profile.children.cycles-pp.add_to_page_cache_lru
     15.33 ±  8%      -7.9        7.42 ± 11%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     28.41 ±  8%      -7.9       20.49 ± 10%  perf-profile.children.cycles-pp.do_idle
     28.41 ±  8%      -7.9       20.49 ± 10%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     28.41 ±  8%      -7.9       20.49 ± 10%  perf-profile.children.cycles-pp.cpu_startup_entry
     15.19 ±  8%      -7.9        7.30 ± 12%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
     14.95 ±  8%      -7.9        7.10 ± 12%  perf-profile.children.cycles-pp.__close
     14.92 ±  8%      -7.8        7.08 ± 12%  perf-profile.children.cycles-pp.dput
     14.92 ±  9%      -7.8        7.08 ± 12%  perf-profile.children.cycles-pp.task_work_run
     14.91 ±  9%      -7.8        7.08 ± 12%  perf-profile.children.cycles-pp.__fput
     14.88 ±  9%      -7.8        7.05 ± 12%  perf-profile.children.cycles-pp.__dentry_kill
     28.08 ±  8%      -7.8       20.25 ± 10%  perf-profile.children.cycles-pp.cpuidle_enter
     28.07 ±  8%      -7.8       20.24 ± 10%  perf-profile.children.cycles-pp.cpuidle_enter_state
     28.05 ±  8%      -7.8       20.24 ± 10%  perf-profile.children.cycles-pp.start_secondary
     27.18 ±  8%      -7.6       19.56 ± 10%  perf-profile.children.cycles-pp.intel_idle
     13.92 ±  9%      -6.9        7.02 ± 12%  perf-profile.children.cycles-pp.evict
     13.90 ±  9%      -6.9        7.00 ± 12%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      9.49 ± 14%      -5.5        3.98 ± 19%  perf-profile.children.cycles-pp.__pagevec_release
      9.20 ± 13%      -5.3        3.93 ± 18%  perf-profile.children.cycles-pp.release_pages
      8.13 ± 16%      -4.8        3.31 ± 21%  perf-profile.children.cycles-pp.__pagevec_lru_add
      7.83 ± 16%      -4.6        3.26 ± 20%  perf-profile.children.cycles-pp.lru_cache_add
      8.50 ±  4%      -3.4        5.06 ±  7%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      6.99 ±  4%      -2.8        4.16 ±  8%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      5.98 ±  6%      -2.6        3.43 ± 10%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      5.35 ±  5%      -2.4        2.98 ± 10%  perf-profile.children.cycles-pp.mem_cgroup_charge
      5.22 ±  6%      -2.3        2.90 ± 11%  perf-profile.children.cycles-pp.__mod_memcg_state
      7.34 ±  4%      -2.1        5.28 ±  3%  perf-profile.children.cycles-pp.iomap_write_end
      4.75 ±  3%      -1.6        3.16 ±  4%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      3.41 ±  3%      -1.2        2.19 ±  5%  perf-profile.children.cycles-pp.__set_page_dirty
      2.20 ±  5%      -1.0        1.23 ±  9%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      2.13 ±  5%      -0.9        1.23 ±  9%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      2.25 ±  2%      -0.8        1.46 ±  5%  perf-profile.children.cycles-pp.truncate_cleanup_page
      2.08 ±  3%      -0.7        1.33 ±  6%  perf-profile.children.cycles-pp.__cancel_dirty_page
      4.48 ±  7%      -0.7        3.77 ±  3%  perf-profile.children.cycles-pp.iomap_set_range_uptodate
      1.87 ±  3%      -0.7        1.16 ±  6%  perf-profile.children.cycles-pp.account_page_cleaned
      3.34 ±  8%      -0.7        2.68 ±  3%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      2.25 ±  9%      -0.5        1.72 ±  2%  perf-profile.children.cycles-pp.xfs_file_write_checks
      1.27 ±  3%      -0.5        0.76 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      1.67 ±  3%      -0.5        1.18 ±  4%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      1.06 ±  5%      -0.4        0.68 ±  7%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      2.08 ±  7%      -0.4        1.72 ±  3%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      1.08 ± 13%      -0.3        0.74 ±  4%  perf-profile.children.cycles-pp.file_update_time
      1.59 ±  6%      -0.3        1.28 ±  4%  perf-profile.children.cycles-pp.xfs_ilock
      0.78 ±  4%      -0.3        0.49 ±  5%  perf-profile.children.cycles-pp.uncharge_batch
      0.41 ± 19%      -0.3        0.14 ± 28%  perf-profile.children.cycles-pp.lru_add_drain
      0.41 ± 19%      -0.3        0.14 ± 28%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      1.59 ±  8%      -0.3        1.32 ±  2%  perf-profile.children.cycles-pp.copyin
      1.52 ±  7%      -0.3        1.27 ±  3%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      1.37 ±  6%      -0.3        1.12 ±  4%  perf-profile.children.cycles-pp.down_write
      0.57 ± 21%      -0.2        0.32 ± 11%  perf-profile.children.cycles-pp.xfs_vn_update_time
      0.61 ±  5%      -0.2        0.39 ±  4%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.64 ±  6%      -0.2        0.43 ±  9%  perf-profile.children.cycles-pp.lock_page_memcg
      0.47 ±  7%      -0.2        0.26 ± 11%  perf-profile.children.cycles-pp.uncharge_page
      0.91 ±  7%      -0.2        0.74 ±  3%  perf-profile.children.cycles-pp.xfs_iunlock
      0.82 ±  8%      -0.2        0.66 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.81 ±  7%      -0.2        0.66 ±  3%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.46 ±  5%      -0.2        0.30 ±  4%  perf-profile.children.cycles-pp.page_counter_cancel
      0.93 ±  8%      -0.2        0.77 ±  4%  perf-profile.children.cycles-pp.__entry_text_start
      0.91 ±  7%      -0.2        0.76 ±  2%  perf-profile.children.cycles-pp.__alloc_pages
      0.38 ±  6%      -0.1        0.23 ±  8%  perf-profile.children.cycles-pp.__count_memcg_events
      0.43 ± 16%      -0.1        0.29 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock
      0.36 ±  9%      -0.1        0.23 ± 10%  perf-profile.children.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      1.23 ±  4%      -0.1        1.10 ±  2%  perf-profile.children.cycles-pp.memset_erms
      0.54 ±  6%      -0.1        0.41 ±  5%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_end
      0.53 ±  7%      -0.1        0.40 ±  8%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.86 ±  6%      -0.1        0.74 ±  4%  perf-profile.children.cycles-pp.___might_sleep
      0.35 ±  5%      -0.1        0.22 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.61 ±  7%      -0.1        0.48 ±  3%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.40 ±  6%      -0.1        0.27 ±  5%  perf-profile.children.cycles-pp.try_charge_memcg
      0.76 ±  8%      -0.1        0.63 ±  5%  perf-profile.children.cycles-pp.xas_load
      0.64 ±  7%      -0.1        0.52 ±  4%  perf-profile.children.cycles-pp.up_write
      0.53 ±  7%      -0.1        0.41 ±  4%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.64 ±  8%      -0.1        0.52 ±  5%  perf-profile.children.cycles-pp.__fdget_pos
      0.36 ±  6%      -0.1        0.24 ± 22%  perf-profile.children.cycles-pp.start_kernel
      0.69 ±  7%      -0.1        0.57 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.69 ±  8%      -0.1        0.58 ±  3%  perf-profile.children.cycles-pp.xas_store
      0.56 ±  8%      -0.1        0.45 ±  5%  perf-profile.children.cycles-pp.__fget_light
      0.49 ±  5%      -0.1        0.39 ±  4%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.22 ± 18%      -0.1        0.12 ± 16%  perf-profile.children.cycles-pp.xfs_trans_alloc
      0.18 ± 37%      -0.1        0.09 ± 13%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.28 ±  5%      -0.1        0.19 ±  6%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.38 ±  6%      -0.1        0.30 ±  4%  perf-profile.children.cycles-pp.find_lock_entries
      0.20 ±  6%      -0.1        0.11 ±  9%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.51 ±  9%      -0.1        0.42 ±  4%  perf-profile.children.cycles-pp.xfs_break_layouts
      0.18 ± 21%      -0.1        0.10 ± 19%  perf-profile.children.cycles-pp.xfs_log_reserve
      0.69 ±  5%      -0.1        0.61 ±  4%  perf-profile.children.cycles-pp.security_file_permission
      0.19 ± 19%      -0.1        0.11 ± 17%  perf-profile.children.cycles-pp.xfs_trans_reserve
      0.14 ±  8%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.xfs_inactive_truncate
      0.43 ±  9%      -0.1        0.35 ±  6%  perf-profile.children.cycles-pp.__cond_resched
      0.39 ±  5%      -0.1        0.32 ±  4%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.46 ± 10%      -0.1        0.39 ±  6%  perf-profile.children.cycles-pp.xfs_file_write_iter
      0.55 ±  5%      -0.1        0.48 ±  4%  perf-profile.children.cycles-pp.common_file_perm
      0.36 ±  7%      -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.unlock_page
      0.10 ± 24%      -0.1        0.04 ± 87%  perf-profile.children.cycles-pp.xlog_grant_add_space
      0.46 ±  7%      -0.1        0.39 ±  2%  perf-profile.children.cycles-pp.__might_sleep
      0.22 ±  6%      -0.1        0.15 ±  7%  perf-profile.children.cycles-pp.__unlock_page_memcg
      0.09 ± 20%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.xfs_log_ticket_ungrant
      0.30 ±  9%      -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.xfs_break_leased_layouts
      0.19 ±  9%      -0.1        0.14 ± 11%  perf-profile.children.cycles-pp.xfs_read_agi
      0.30 ±  7%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.generic_write_checks
      0.25 ±  8%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.17 ±  7%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.xfs_iunlink_remove
      0.30 ±  7%      -0.0        0.25 ±  4%  perf-profile.children.cycles-pp.current_time
      0.17 ±  9%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.24 ±  7%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.node_dirty_ok
      0.07 ± 11%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.schedule_idle
      0.16 ±  9%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.15 ± 14%      -0.0        0.11 ± 10%  perf-profile.children.cycles-pp.try_to_wake_up
      0.16 ±  7%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.alloc_pages
      0.14 ± 10%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.15 ±  9%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.aa_file_perm
      0.10 ±  9%      -0.0        0.07 ± 13%  perf-profile.children.cycles-pp.__down
      0.10 ± 13%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.xfs_buf_unlock
      0.10 ±  8%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.xfs_buf_lock
      0.11 ± 13%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.xfs_buf_item_release
      0.10 ± 15%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.xfs_dir2_node_addname_int
      0.10 ±  8%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.down
      0.14 ±  6%      -0.0        0.11 ±  5%  perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.10 ± 14%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.up
      0.07 ±  7%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.xas_alloc
      0.09 ±  8%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.schedule_timeout
      0.12 ±  8%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.xas_create
      0.12 ±  7%      -0.0        0.09 ±  8%  perf-profile.children.cycles-pp.__list_add_valid
      0.07 ± 10%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.unlock_page_memcg
      0.10 ± 13%      +0.0        0.13 ±  9%  perf-profile.children.cycles-pp.__xfs_btree_check_sblock
      0.14 ±  8%      +0.0        0.18 ±  6%  perf-profile.children.cycles-pp.schedule
      0.14 ± 11%      +0.1        0.19 ±  9%  perf-profile.children.cycles-pp.xfs_btree_increment
      0.16 ± 12%      +0.1        0.22 ±  9%  perf-profile.children.cycles-pp.xfs_btree_check_sblock
      0.17 ± 12%      +0.1        0.23 ±  5%  perf-profile.children.cycles-pp.disk_wrt
      0.14 ± 13%      +0.1        0.20 ±  8%  perf-profile.children.cycles-pp.xfs_btree_get_rec
      0.04 ± 42%      +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.29 ± 13%      +0.1        0.37 ±  8%  perf-profile.children.cycles-pp.xfs_inobt_get_rec
      0.00            +0.1        0.10 ±  9%  perf-profile.children.cycles-pp.newidle_balance
      0.14 ± 17%      +0.1        0.25 ±  8%  perf-profile.children.cycles-pp.memcpy_erms
      0.17 ± 16%      +0.1        0.31 ±  8%  perf-profile.children.cycles-pp.xfs_buf_item_format_segment
      0.18 ± 16%      +0.1        0.32 ±  8%  perf-profile.children.cycles-pp.xfs_buf_item_format
      0.00            +0.8        0.85 ±  4%  perf-profile.children.cycles-pp.xfs_inodegc_worker
      0.00            +0.9        0.90 ±  5%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.9        0.90 ±  5%  perf-profile.children.cycles-pp.worker_thread
      0.00 ±346%      +0.9        0.94 ±  5%  perf-profile.children.cycles-pp.kthread
      0.00 ±346%      +0.9        0.94 ±  5%  perf-profile.children.cycles-pp.ret_from_fork
     68.98 ±  3%      +7.4       76.42 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     68.63 ±  3%      +7.5       76.11 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
      2.11 ± 11%     +14.8       16.93 ±  6%  perf-profile.children.cycles-pp.creat64
      2.08 ± 11%     +14.8       16.90 ±  6%  perf-profile.children.cycles-pp.do_sys_openat2
      2.08 ± 11%     +14.8       16.90 ±  6%  perf-profile.children.cycles-pp.do_sys_open
      2.05 ± 11%     +14.8       16.88 ±  6%  perf-profile.children.cycles-pp.do_filp_open
      2.05 ± 11%     +14.8       16.88 ±  6%  perf-profile.children.cycles-pp.path_openat
      2.28 ± 11%     +15.2       17.52 ±  4%  perf-profile.children.cycles-pp.unlink
      2.23 ± 11%     +15.2       17.47 ±  4%  perf-profile.children.cycles-pp.do_unlinkat
      0.64 ± 10%     +29.8       30.46 ±  6%  perf-profile.children.cycles-pp.osq_lock
      2.36 ±  8%     +30.1       32.42 ±  5%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     12.76 ± 20%      -8.6        4.20 ± 31%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
     27.18 ±  8%      -7.6       19.56 ± 10%  perf-profile.self.cycles-pp.intel_idle
      5.20 ±  6%      -2.3        2.88 ± 11%  perf-profile.self.cycles-pp.__mod_memcg_state
      2.17 ±  5%      -1.0        1.21 ±  9%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      2.25 ±  8%      -0.9        1.39 ±  8%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      4.43 ±  7%      -0.7        3.74 ±  3%  perf-profile.self.cycles-pp.iomap_set_range_uptodate
      1.34 ±  8%      -0.6        0.70 ± 13%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      1.01 ±  7%      -0.5        0.51 ± 14%  perf-profile.self.cycles-pp.mem_cgroup_charge
      1.51 ±  8%      -0.3        1.26 ±  3%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.95 ± 17%      -0.2        0.71 ±  5%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_begin
      1.06 ±  7%      -0.2        0.86 ±  3%  perf-profile.self.cycles-pp.iomap_apply
      0.46 ±  7%      -0.2        0.26 ± 11%  perf-profile.self.cycles-pp.uncharge_page
      0.62 ±  6%      -0.2        0.42 ±  9%  perf-profile.self.cycles-pp.lock_page_memcg
      1.14 ±  5%      -0.2        0.94 ±  3%  perf-profile.self.cycles-pp.pagecache_get_page
      0.63 ±  8%      -0.2        0.44 ±  8%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.81 ±  8%      -0.2        0.65 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.46 ±  5%      -0.2        0.30 ±  4%  perf-profile.self.cycles-pp.page_counter_cancel
      0.70 ±  7%      -0.2        0.54 ±  5%  perf-profile.self.cycles-pp.down_write
      0.38 ±  6%      -0.1        0.23 ±  8%  perf-profile.self.cycles-pp.__count_memcg_events
      0.74 ±  8%      -0.1        0.60 ±  5%  perf-profile.self.cycles-pp.write
      0.36 ±  9%      -0.1        0.22 ±  9%  perf-profile.self.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.51 ±  5%      -0.1        0.38 ±  7%  perf-profile.self.cycles-pp.__pagevec_lru_add
      1.21 ±  5%      -0.1        1.09 ±  3%  perf-profile.self.cycles-pp.memset_erms
      0.41 ±  7%      -0.1        0.29 ±  5%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_end
      0.84 ±  6%      -0.1        0.72 ±  4%  perf-profile.self.cycles-pp.___might_sleep
      0.67 ±  6%      -0.1        0.56 ±  5%  perf-profile.self.cycles-pp.vfs_write
      0.59 ±  8%      -0.1        0.47 ±  4%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.47 ±  7%      -0.1        0.36 ±  9%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      0.60 ±  7%      -0.1        0.49 ±  4%  perf-profile.self.cycles-pp.up_write
      0.54 ±  8%      -0.1        0.43 ±  5%  perf-profile.self.cycles-pp.iomap_write_end
      0.59 ±  7%      -0.1        0.49 ±  6%  perf-profile.self.cycles-pp.xfs_file_buffered_write
      0.43 ±  7%      -0.1        0.33 ±  3%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.53 ±  9%      -0.1        0.43 ±  6%  perf-profile.self.cycles-pp.__fget_light
      0.50 ±  8%      -0.1        0.40 ±  6%  perf-profile.self.cycles-pp.iomap_write_actor
      0.63 ±  7%      -0.1        0.53 ±  3%  perf-profile.self.cycles-pp.iomap_write_begin
      0.49 ±  8%      -0.1        0.40 ±  4%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.40 ±  7%      -0.1        0.32 ±  5%  perf-profile.self.cycles-pp.release_pages
      0.48 ±  7%      -0.1        0.40 ±  5%  perf-profile.self.cycles-pp.xas_load
      0.20 ±  6%      -0.1        0.11 ±  6%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.36 ±  9%      -0.1        0.28 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.36 ±  8%      -0.1        0.28 ±  3%  perf-profile.self.cycles-pp.unlock_page
      0.38 ±  4%      -0.1        0.31 ±  5%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.41 ±  8%      -0.1        0.34 ±  6%  perf-profile.self.cycles-pp.__entry_text_start
      0.45 ± 10%      -0.1        0.38 ±  6%  perf-profile.self.cycles-pp.xfs_file_write_iter
      0.10 ± 24%      -0.1        0.04 ± 87%  perf-profile.self.cycles-pp.xlog_grant_add_space
      0.22 ±  6%      -0.1        0.16 ±  5%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.31 ±  7%      -0.1        0.24 ±  3%  perf-profile.self.cycles-pp.find_lock_entries
      0.42 ±  7%      -0.1        0.35 ±  2%  perf-profile.self.cycles-pp.__might_sleep
      0.31 ±  7%      -0.1        0.25 ±  6%  perf-profile.self.cycles-pp.__set_page_dirty_nobuffers
      0.29 ±  9%      -0.1        0.23 ±  6%  perf-profile.self.cycles-pp.new_sync_write
      0.20 ±  8%      -0.1        0.14 ±  9%  perf-profile.self.cycles-pp.__unlock_page_memcg
      0.28 ±  7%      -0.1        0.22 ±  5%  perf-profile.self.cycles-pp.__add_to_page_cache_locked
      0.29 ±  8%      -0.1        0.23 ±  4%  perf-profile.self.cycles-pp.xfs_iunlock
      0.25 ± 12%      -0.1        0.19 ±  6%  perf-profile.self.cycles-pp.xfs_ilock
      0.29 ±  9%      -0.1        0.23 ±  4%  perf-profile.self.cycles-pp.xfs_break_leased_layouts
      0.17 ± 10%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.24 ±  8%      -0.0        0.19 ±  4%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.24 ±  9%      -0.0        0.20 ±  6%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.11 ±  9%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.uncharge_batch
      0.28 ±  9%      -0.0        0.24 ±  4%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.08 ± 11%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.lock_page_lruvec_irqsave
      0.19 ±  7%      -0.0        0.15 ±  6%  perf-profile.self.cycles-pp.ksys_write
      0.21 ± 11%      -0.0        0.18 ±  5%  perf-profile.self.cycles-pp.file_update_time
      0.22 ±  8%      -0.0        0.18 ±  6%  perf-profile.self.cycles-pp.__cond_resched
      0.21 ±  8%      -0.0        0.17 ±  5%  perf-profile.self.cycles-pp.iov_iter_fault_in_readable
      0.17 ±  9%      -0.0        0.13 ±  6%  perf-profile.self.cycles-pp.node_dirty_ok
      0.15 ±  6%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.__set_page_dirty
      0.14 ± 10%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.22 ±  7%      -0.0        0.18 ±  5%  perf-profile.self.cycles-pp.xfs_file_write_checks
      0.13 ± 10%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.try_charge_memcg
      0.10 ±  8%      -0.0        0.08        perf-profile.self.cycles-pp.__mod_lruvec_state
      0.15 ±  8%      -0.0        0.12 ±  8%  perf-profile.self.cycles-pp.__alloc_pages
      0.11 ±  8%      -0.0        0.09 ± 10%  perf-profile.self.cycles-pp.__list_add_valid
      0.12 ±  6%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.do_syscall_64
      0.15 ±  9%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.rmqueue
      0.10 ±  9%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.lru_cache_add
      0.10 ±  7%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.rcu_read_unlock_strict
      0.08 ±  9%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.08 ± 14%      +0.0        0.11 ± 10%  perf-profile.self.cycles-pp.__xfs_btree_check_sblock
      0.02 ±150%      +0.0        0.06 ± 12%  perf-profile.self.cycles-pp.xfs_btree_increment
      0.13 ± 13%      +0.1        0.19 ±  6%  perf-profile.self.cycles-pp.disk_wrt
      0.13 ± 17%      +0.1        0.25 ±  9%  perf-profile.self.cycles-pp.memcpy_erms
      0.63 ± 10%     +29.6       30.28 ±  6%  perf-profile.self.cycles-pp.osq_lock



***************************************************************************************************
lkp-csl-2sp9: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/4BRD_12G/xfs/x86_64-rhel-8.3/3000/RAID0/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp9/disk_rw/aim7/0x5003006

commit: 
  62af7d54a0 ("xfs: detach dquots from inode if we don't need to inactivate it")
  ab23a77687 ("xfs: per-cpu deferred inode inactivation queues")

62af7d54a0ec0b6f ab23a7768739a23d21d8a16ca37 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    526533           -17.3%     435198        aim7.jobs-per-min
     34.38           +20.9%      41.56        aim7.time.elapsed_time
     34.38           +20.9%      41.56        aim7.time.elapsed_time.max
      2403 ± 11%   +1237.6%      32144 ±  2%  aim7.time.involuntary_context_switches
    788.78           +37.3%       1082        aim7.time.system_time
    940029           -35.0%     610898        aim7.time.voluntary_context_switches
 2.283e+09           +15.4%  2.635e+09        cpuidle..time
   1685218 ± 66%     -50.0%     843115 ± 87%  numa-meminfo.node1.FilePages
    421246 ± 66%     -49.9%     211129 ± 87%  numa-vmstat.node1.nr_file_pages
     73.41           +10.5%      81.11        uptime.boot
     52582           -19.2%      42477        vmstat.system.cs
     25.36 ±  2%      +3.5       28.83 ±  2%  mpstat.cpu.all.sys%
      1.81            -0.3        1.47        mpstat.cpu.all.usr%
     73.33            -4.4%      70.12        iostat.cpu.idle
     24.91           +14.1%      28.44        iostat.cpu.system
      1.75           -17.9%       1.44        iostat.cpu.user
    777.83           +12.0%     870.86        turbostat.Avg_MHz
     28.07            +3.3       31.42        turbostat.Busy%
      0.51 ± 20%      -0.3        0.20 ±  6%  turbostat.C1%
      6154 ±  3%     +25.8%       7744 ± 15%  softirqs.CPU16.RCU
      6295 ±  6%     +26.7%       7975 ± 20%  softirqs.CPU2.RCU
      5899 ±  6%     +26.6%       7469 ± 15%  softirqs.CPU61.RCU
      5047 ±  3%     +32.7%       6696 ± 27%  softirqs.CPU85.RCU
    516638 ±  2%     +14.0%     589064 ±  2%  softirqs.RCU
    276205            -5.8%     260164        proc-vmstat.nr_dirty
    875981            -1.7%     861422        proc-vmstat.nr_file_pages
    276382            -5.8%     260338        proc-vmstat.nr_inactive_file
    276383            -5.8%     260338        proc-vmstat.nr_zone_inactive_file
    276775            -5.8%     260856        proc-vmstat.nr_zone_write_pending
     13739           +12.1%      15401        proc-vmstat.pgreuse
    888.17 ±  5%     +13.1%       1004 ±  4%  slabinfo.kmalloc-8k.active_objs
    893.33 ±  5%     +13.2%       1011 ±  4%  slabinfo.kmalloc-8k.num_objs
      2441           +10.4%       2695        slabinfo.xfs_buf.active_objs
      2441           +10.4%       2695        slabinfo.xfs_buf.num_objs
      1756 ±  4%     +15.5%       2029 ±  2%  slabinfo.xfs_icr.active_objs
      1756 ±  4%     +15.5%       2029 ±  2%  slabinfo.xfs_icr.num_objs
      2887 ± 10%     +47.5%       4258 ±  7%  slabinfo.xfs_ili.active_objs
      2892 ± 10%     +50.6%       4357 ±  9%  slabinfo.xfs_ili.num_objs
      2796 ±  4%     +47.1%       4113 ±  5%  slabinfo.xfs_inode.active_objs
      2915 ±  2%     +42.0%       4140 ±  5%  slabinfo.xfs_inode.num_objs
     65.17 ± 33%    +235.4%     218.57 ± 26%  interrupts.CPU0.RES:Rescheduling_interrupts
     63.83 ± 24%    +203.5%     193.71 ± 23%  interrupts.CPU1.RES:Rescheduling_interrupts
     47.33 ± 21%    +324.6%     201.00 ± 32%  interrupts.CPU10.RES:Rescheduling_interrupts
     49.33 ± 18%    +248.1%     171.71 ± 23%  interrupts.CPU11.RES:Rescheduling_interrupts
     48.67 ± 29%    +314.8%     201.86 ± 16%  interrupts.CPU12.RES:Rescheduling_interrupts
     51.67 ± 23%    +264.7%     188.43 ± 17%  interrupts.CPU13.RES:Rescheduling_interrupts
     49.83 ± 21%    +252.6%     175.71 ± 17%  interrupts.CPU14.RES:Rescheduling_interrupts
     44.67 ± 15%    +322.2%     188.57 ± 14%  interrupts.CPU15.RES:Rescheduling_interrupts
     52.33 ± 26%    +264.7%     190.86 ± 23%  interrupts.CPU16.RES:Rescheduling_interrupts
     48.33 ± 23%    +326.2%     206.00 ± 16%  interrupts.CPU17.RES:Rescheduling_interrupts
     46.00 ± 22%    +381.7%     221.57 ± 21%  interrupts.CPU18.RES:Rescheduling_interrupts
     46.00 ± 12%    +374.5%     218.29 ± 23%  interrupts.CPU19.RES:Rescheduling_interrupts
     49.33 ± 32%    +309.5%     202.00 ± 30%  interrupts.CPU2.RES:Rescheduling_interrupts
     47.83 ± 17%    +311.2%     196.71 ± 21%  interrupts.CPU20.RES:Rescheduling_interrupts
     48.33 ± 20%    +300.2%     193.43 ± 28%  interrupts.CPU21.RES:Rescheduling_interrupts
     44.17 ± 12%    +341.8%     195.14 ± 24%  interrupts.CPU22.RES:Rescheduling_interrupts
     40.33 ± 19%    +377.8%     192.71 ± 18%  interrupts.CPU23.RES:Rescheduling_interrupts
     41.33 ± 17%    +380.8%     198.71 ±  9%  interrupts.CPU24.RES:Rescheduling_interrupts
     43.83 ± 18%    +335.1%     190.71 ± 16%  interrupts.CPU25.RES:Rescheduling_interrupts
     39.67 ± 19%    +361.0%     182.86 ± 17%  interrupts.CPU26.RES:Rescheduling_interrupts
     38.17 ± 12%    +310.2%     156.57 ± 19%  interrupts.CPU27.RES:Rescheduling_interrupts
     43.67 ± 20%    +354.4%     198.43 ± 13%  interrupts.CPU28.RES:Rescheduling_interrupts
     42.33 ±  6%    +309.0%     173.14 ± 26%  interrupts.CPU29.RES:Rescheduling_interrupts
     61.50 ± 33%    +201.3%     185.29 ± 16%  interrupts.CPU3.RES:Rescheduling_interrupts
     45.00 ± 11%    +363.5%     208.57 ± 20%  interrupts.CPU30.RES:Rescheduling_interrupts
     41.50 ± 17%    +321.0%     174.71 ± 21%  interrupts.CPU31.RES:Rescheduling_interrupts
     37.83 ±  8%    +353.5%     171.57 ±  7%  interrupts.CPU32.RES:Rescheduling_interrupts
     41.17 ± 13%    +325.8%     175.29 ± 23%  interrupts.CPU33.RES:Rescheduling_interrupts
     44.33 ± 26%    +360.8%     204.29 ± 23%  interrupts.CPU34.RES:Rescheduling_interrupts
     38.50 ± 20%    +357.1%     176.00 ± 26%  interrupts.CPU35.RES:Rescheduling_interrupts
     42.00 ± 32%    +361.2%     193.71 ± 13%  interrupts.CPU36.RES:Rescheduling_interrupts
     38.33 ± 10%    +450.1%     210.86 ± 20%  interrupts.CPU37.RES:Rescheduling_interrupts
     51.33 ± 38%    +281.3%     195.71 ± 30%  interrupts.CPU38.RES:Rescheduling_interrupts
     45.83 ± 15%    +268.7%     169.00 ± 19%  interrupts.CPU39.RES:Rescheduling_interrupts
     49.83 ± 21%    +290.4%     194.57 ± 25%  interrupts.CPU4.RES:Rescheduling_interrupts
     46.17 ± 25%    +315.9%     192.00 ± 43%  interrupts.CPU40.RES:Rescheduling_interrupts
     44.17 ± 19%    +351.9%     199.57 ± 18%  interrupts.CPU41.RES:Rescheduling_interrupts
     41.00 ± 29%    +317.4%     171.14 ± 38%  interrupts.CPU42.RES:Rescheduling_interrupts
     58.00 ± 35%    +240.4%     197.43 ± 17%  interrupts.CPU43.RES:Rescheduling_interrupts
     27.67 ± 34%    +672.5%     213.71 ± 37%  interrupts.CPU44.RES:Rescheduling_interrupts
     27.50 ± 33%    +657.9%     208.43 ± 35%  interrupts.CPU45.RES:Rescheduling_interrupts
     27.83 ± 30%    +602.7%     195.57 ± 20%  interrupts.CPU46.RES:Rescheduling_interrupts
     28.50 ± 29%    +535.1%     181.00 ± 11%  interrupts.CPU47.RES:Rescheduling_interrupts
     24.67 ± 39%    +608.9%     174.86 ± 26%  interrupts.CPU48.RES:Rescheduling_interrupts
     24.50 ± 47%    +676.7%     190.29 ± 23%  interrupts.CPU49.RES:Rescheduling_interrupts
     48.67 ± 22%    +297.2%     193.29 ± 13%  interrupts.CPU5.RES:Rescheduling_interrupts
     28.83 ± 33%    +705.6%     232.29 ± 20%  interrupts.CPU50.RES:Rescheduling_interrupts
     30.33 ± 34%    +520.7%     188.29 ± 18%  interrupts.CPU51.RES:Rescheduling_interrupts
     25.50 ± 38%    +708.4%     206.14 ± 26%  interrupts.CPU52.RES:Rescheduling_interrupts
     29.83 ± 37%    +518.2%     184.43 ± 33%  interrupts.CPU53.RES:Rescheduling_interrupts
     27.67 ± 37%    +456.6%     154.00 ± 26%  interrupts.CPU54.RES:Rescheduling_interrupts
     32.67 ± 51%    +542.0%     209.71 ± 17%  interrupts.CPU55.RES:Rescheduling_interrupts
     28.50 ± 38%    +507.5%     173.14 ± 21%  interrupts.CPU56.RES:Rescheduling_interrupts
     26.33 ± 26%    +636.7%     194.00 ± 21%  interrupts.CPU57.RES:Rescheduling_interrupts
     26.00 ± 33%    +631.3%     190.14 ± 22%  interrupts.CPU58.RES:Rescheduling_interrupts
     27.33 ± 30%    +684.0%     214.29 ± 25%  interrupts.CPU59.RES:Rescheduling_interrupts
     53.67 ± 15%    +278.5%     203.14 ± 14%  interrupts.CPU6.RES:Rescheduling_interrupts
     27.00 ± 34%    +634.9%     198.43 ± 24%  interrupts.CPU60.RES:Rescheduling_interrupts
     28.50 ± 33%    +594.7%     198.00 ± 28%  interrupts.CPU61.RES:Rescheduling_interrupts
     35.67 ± 56%    +544.5%     229.86 ± 16%  interrupts.CPU62.RES:Rescheduling_interrupts
     33.33 ± 54%    +473.9%     191.29 ± 17%  interrupts.CPU63.RES:Rescheduling_interrupts
     32.33 ± 54%    +488.5%     190.29 ± 20%  interrupts.CPU64.RES:Rescheduling_interrupts
     28.50 ± 54%    +605.3%     201.00 ± 35%  interrupts.CPU65.RES:Rescheduling_interrupts
     26.33 ± 41%    +650.8%     197.71 ± 16%  interrupts.CPU66.RES:Rescheduling_interrupts
     29.00 ± 36%    +473.4%     166.29 ± 29%  interrupts.CPU67.RES:Rescheduling_interrupts
     24.83 ± 21%    +569.6%     166.29 ± 15%  interrupts.CPU68.RES:Rescheduling_interrupts
     21.17 ± 31%    +765.2%     183.14 ± 25%  interrupts.CPU69.RES:Rescheduling_interrupts
     54.67 ± 26%    +308.2%     223.14 ± 27%  interrupts.CPU7.RES:Rescheduling_interrupts
     22.83 ± 27%    +718.4%     186.86 ± 19%  interrupts.CPU70.RES:Rescheduling_interrupts
     21.67 ± 36%    +766.4%     187.71 ± 25%  interrupts.CPU71.RES:Rescheduling_interrupts
     22.00 ± 37%    +740.3%     184.86 ± 36%  interrupts.CPU72.RES:Rescheduling_interrupts
     24.00 ± 14%    +688.7%     189.29 ± 30%  interrupts.CPU73.RES:Rescheduling_interrupts
     23.17 ± 29%    +644.9%     172.57 ± 15%  interrupts.CPU74.RES:Rescheduling_interrupts
     17.17 ± 44%    +905.3%     172.57 ± 25%  interrupts.CPU75.RES:Rescheduling_interrupts
     21.00 ± 39%    +892.5%     208.43 ± 24%  interrupts.CPU76.RES:Rescheduling_interrupts
     24.00 ± 25%    +617.9%     172.29 ± 33%  interrupts.CPU77.RES:Rescheduling_interrupts
     26.67 ± 28%    +582.5%     182.00 ± 20%  interrupts.CPU78.RES:Rescheduling_interrupts
     16.17 ± 35%    +896.8%     161.14 ± 14%  interrupts.CPU79.RES:Rescheduling_interrupts
     44.50 ± 24%    +300.6%     178.29 ± 23%  interrupts.CPU8.RES:Rescheduling_interrupts
     19.67 ± 42%    +920.6%     200.71 ± 26%  interrupts.CPU80.RES:Rescheduling_interrupts
     17.67 ± 36%    +953.6%     186.14 ± 20%  interrupts.CPU81.RES:Rescheduling_interrupts
     20.67 ± 29%    +886.4%     203.86 ± 18%  interrupts.CPU82.RES:Rescheduling_interrupts
     23.17 ± 12%    +733.7%     193.14 ± 17%  interrupts.CPU83.RES:Rescheduling_interrupts
     53.83 ± 24%    +302.3%     216.57 ± 18%  interrupts.CPU84.RES:Rescheduling_interrupts
     62.83 ± 15%    +223.8%     203.43 ± 17%  interrupts.CPU85.RES:Rescheduling_interrupts
     44.17 ± 10%    +385.8%     214.57 ± 15%  interrupts.CPU86.RES:Rescheduling_interrupts
     61.83 ± 18%    +251.4%     217.29 ± 20%  interrupts.CPU87.RES:Rescheduling_interrupts
     49.17 ± 19%    +250.1%     172.14 ± 19%  interrupts.CPU9.RES:Rescheduling_interrupts
      3322 ± 15%    +409.7%      16932 ±  9%  interrupts.RES:Rescheduling_interrupts



***************************************************************************************************
lkp-cpl-4sp1: 144 threads 4 sockets Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/1BRD_48G/xfs/x86_64-rhel-8.3/3000/debian-10.4-x86_64-20200603.cgz/lkp-cpl-4sp1/disk_wrt/aim7/0x700001e

commit: 
  62af7d54a0 ("xfs: detach dquots from inode if we don't need to inactivate it")
  ab23a77687 ("xfs: per-cpu deferred inode inactivation queues")

62af7d54a0ec0b6f ab23a7768739a23d21d8a16ca37 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    504463           -15.6%     425763        aim7.jobs-per-min
     35.89           +18.4%      42.48        aim7.time.elapsed_time
     35.89           +18.4%      42.48        aim7.time.elapsed_time.max
      3105 ±  8%    +452.2%      17145        aim7.time.involuntary_context_switches
      1120 ±  7%     +12.9%       1265 ±  2%  aim7.time.system_time
    904053           -33.8%     598681        aim7.time.voluntary_context_switches
      8602 ± 16%     +19.0%      10240 ± 17%  softirqs.CPU18.SCHED
     49543           -14.5%      42345        vmstat.system.cs
 4.149e+09           +19.3%  4.952e+09        cpuidle..time
   8764843 ± 18%     +26.4%   11078329 ±  2%  cpuidle..usage
      0.13 ±  5%      -0.0        0.11 ±  2%  mpstat.cpu.all.soft%
      0.39 ±  2%      -0.0        0.34 ±  6%  mpstat.cpu.all.usr%
     22503 ±  9%     +16.3%      26165 ±  2%  meminfo.Active
     22503 ±  9%     +16.3%      26165 ±  2%  meminfo.Active(anon)
     19542 ±  6%     -39.6%      11797 ±  8%  meminfo.Dirty
     20205 ±  5%     -38.1%      12512 ±  7%  meminfo.Inactive(file)
     44147 ±  3%      -9.2%      40084        meminfo.Mapped
     70781 ± 16%    +242.5%     242394 ±135%  turbostat.C1
   5961409 ± 39%     +60.2%    9550276 ± 15%  turbostat.C1E
     38.50 ± 43%     -23.8       14.71 ±112%  turbostat.C6%
      3.42 ±121%     -93.5%       0.22 ± 31%  turbostat.CPU%c6
  10832639 ± 18%     +25.6%   13603195        turbostat.IRQ
    380.92            -2.0%     373.35        turbostat.PkgWatt
     37.21            -2.0%      36.48        turbostat.RAMWatt
      4606 ± 18%     -31.9%       3136 ± 14%  numa-meminfo.node0.Dirty
      4437 ± 15%     -35.7%       2855 ±  5%  numa-meminfo.node1.Dirty
      4328 ± 15%     -35.2%       2806 ±  5%  numa-meminfo.node1.Inactive(file)
     32067 ± 44%     -62.1%      12155 ± 63%  numa-meminfo.node2.AnonHugePages
    132519 ± 54%     -58.5%      55028 ± 82%  numa-meminfo.node2.AnonPages
      4559 ± 10%     -40.8%       2699 ±  9%  numa-meminfo.node2.Dirty
      4590 ±  9%     -36.5%       2917 ± 22%  numa-meminfo.node2.Inactive(file)
      4201 ± 10%     -36.6%       2663 ± 11%  numa-meminfo.node3.Dirty
      4466 ± 13%     -38.0%       2770 ± 20%  numa-meminfo.node3.Inactive(file)
     68767 ±125%     -93.6%       4428 ±211%  numa-meminfo.node3.Unevictable
      1302           +14.3%       1488        slabinfo.kmalloc-8k.active_objs
      1310           +14.6%       1501        slabinfo.kmalloc-8k.num_objs
     38628 ±  2%     +14.1%      44094        slabinfo.radix_tree_node.active_objs
    689.33 ±  2%     +14.2%     787.14        slabinfo.radix_tree_node.active_slabs
     38631 ±  2%     +14.1%      44095        slabinfo.radix_tree_node.num_objs
    689.33 ±  2%     +14.2%     787.14        slabinfo.radix_tree_node.num_slabs
      3592           +12.4%       4036        slabinfo.xfs_buf.active_objs
      3592           +12.4%       4036        slabinfo.xfs_buf.num_objs
      2506 ±  7%     +14.9%       2880 ±  4%  slabinfo.xfs_icr.active_objs
      2506 ±  7%     +14.9%       2880 ±  4%  slabinfo.xfs_icr.num_objs
      4212 ±  3%     +18.7%       4998 ±  7%  slabinfo.xfs_inode.active_objs
      4343 ±  6%     +16.9%       5078 ±  8%  slabinfo.xfs_inode.num_objs
      5625 ±  9%     +16.3%       6540 ±  2%  proc-vmstat.nr_active_anon
      4916 ±  8%     -41.6%       2870 ±  8%  proc-vmstat.nr_dirty
     98817            -0.9%      97926        proc-vmstat.nr_inactive_anon
      5076 ±  7%     -40.1%       3041 ±  8%  proc-vmstat.nr_inactive_file
     11040 ±  3%      -9.1%      10037        proc-vmstat.nr_mapped
     37312            +4.3%      38916        proc-vmstat.nr_slab_reclaimable
      5625 ±  9%     +16.3%       6540 ±  2%  proc-vmstat.nr_zone_active_anon
     98817            -0.9%      97926        proc-vmstat.nr_zone_inactive_anon
      5076 ±  7%     -40.1%       3040 ±  8%  proc-vmstat.nr_zone_inactive_file
      4294 ± 10%     -45.2%       2353 ±  7%  proc-vmstat.nr_zone_write_pending
    508816            +4.2%     530068        proc-vmstat.pgfault
     14003 ± 30%     +88.7%      26418 ± 27%  proc-vmstat.pgpgout
     18037            +8.9%      19646        proc-vmstat.pgreuse
      1084 ± 13%     -29.3%     767.14 ± 18%  numa-vmstat.node0.nr_dirty
    886.33 ± 13%     -31.3%     609.14 ± 21%  numa-vmstat.node0.nr_zone_write_pending
      1097 ± 11%     -40.2%     656.14 ± 10%  numa-vmstat.node1.nr_dirty
      1066 ± 11%     -39.7%     642.86 ± 10%  numa-vmstat.node1.nr_inactive_file
      1059 ± 11%     -38.7%     650.00 ± 11%  numa-vmstat.node1.nr_zone_inactive_file
    910.83 ± 10%     -44.7%     504.00 ± 16%  numa-vmstat.node1.nr_zone_write_pending
     33128 ± 54%     -58.5%      13751 ± 82%  numa-vmstat.node2.nr_anon_pages
      1104 ± 10%     -43.6%     622.86 ± 14%  numa-vmstat.node2.nr_dirty
      1130 ± 10%     -40.0%     678.43 ± 26%  numa-vmstat.node2.nr_inactive_file
      1136 ±  9%     -40.4%     676.86 ± 26%  numa-vmstat.node2.nr_zone_inactive_file
    930.00 ± 13%     -48.8%     476.43 ± 18%  numa-vmstat.node2.nr_zone_write_pending
      1047 ± 11%     -40.9%     618.71 ±  8%  numa-vmstat.node3.nr_dirty
      1106 ± 14%     -42.0%     642.00 ± 15%  numa-vmstat.node3.nr_inactive_file
     17191 ±125%     -93.6%       1106 ±211%  numa-vmstat.node3.nr_unevictable
      1109 ± 13%     -41.2%     651.86 ± 15%  numa-vmstat.node3.nr_zone_inactive_file
     17191 ±125%     -93.6%       1106 ±211%  numa-vmstat.node3.nr_zone_unevictable
    859.17 ± 15%     -43.2%     488.43 ±  8%  numa-vmstat.node3.nr_zone_write_pending
     13.40 ± 80%     -69.6%       4.08 ±  2%  perf-stat.i.MPKI
 7.379e+09            -5.2%  6.993e+09        perf-stat.i.branch-instructions
      1.81 ± 57%      -1.0        0.82 ±  6%  perf-stat.i.branch-miss-rate%
  47840499 ±  6%     -20.6%   37976368 ±  2%  perf-stat.i.branch-misses
     28.75 ±  5%      +5.9       34.66 ±  5%  perf-stat.i.cache-miss-rate%
  75129714           -22.6%   58139399        perf-stat.i.cache-misses
 2.146e+08 ±  6%     -32.5%  1.447e+08 ±  2%  perf-stat.i.cache-references
     50592           -14.5%      43260        perf-stat.i.context-switches
      2043 ±  7%     -27.6%       1480 ±  3%  perf-stat.i.cpu-migrations
 1.108e+10            -5.5%  1.047e+10        perf-stat.i.dTLB-loads
      0.03 ± 97%      -0.0        0.01 ±103%  perf-stat.i.dTLB-store-miss-rate%
 6.099e+09           -11.5%  5.398e+09        perf-stat.i.dTLB-stores
  22787604 ±  3%     -17.9%   18709081 ±  2%  perf-stat.i.iTLB-load-misses
 3.847e+10            -5.1%   3.65e+10        perf-stat.i.instructions
    356.37 ± 37%     -39.7%     214.75        perf-stat.i.metric.K/sec
    171.82            -7.0%     159.83        perf-stat.i.metric.M/sec
     11035           -12.1%       9698        perf-stat.i.minor-faults
  15033579           -17.3%   12435108 ±  2%  perf-stat.i.node-load-misses
   3934804           -12.5%    3442655        perf-stat.i.node-store-misses
   3397233           -13.0%    2954936        perf-stat.i.node-stores
     11067           -12.0%       9743        perf-stat.i.page-faults
      5.58 ±  7%     -28.8%       3.97 ±  2%  perf-stat.overall.MPKI
      0.64 ±  6%      -0.1        0.54 ±  2%  perf-stat.overall.branch-miss-rate%
     35.24 ±  6%      +4.9       40.19 ±  2%  perf-stat.overall.cache-miss-rate%
      1387 ±  3%     +27.3%       1767        perf-stat.overall.cycles-between-cache-misses
      1689 ±  4%     +15.5%       1952 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
     88.09            -1.3       86.83        perf-stat.overall.node-load-miss-rate%
 7.256e+09            -5.4%  6.866e+09        perf-stat.ps.branch-instructions
  46715829 ±  6%     -20.4%   37169356 ±  2%  perf-stat.ps.branch-misses
  74050309 ±  2%     -22.9%   57125611        perf-stat.ps.cache-misses
 2.109e+08 ±  6%     -32.6%  1.422e+08 ±  2%  perf-stat.ps.cache-references
     49763           -14.7%      42452        perf-stat.ps.context-switches
      2014 ±  7%     -27.9%       1452 ±  3%  perf-stat.ps.cpu-migrations
  1.09e+10            -5.7%  1.028e+10        perf-stat.ps.dTLB-loads
 6.001e+09           -11.7%  5.301e+09        perf-stat.ps.dTLB-stores
  22429603 ±  3%     -18.1%   18366533 ±  2%  perf-stat.ps.iTLB-load-misses
 3.784e+10            -5.3%  3.583e+10        perf-stat.ps.instructions
     10504           -10.7%       9383        perf-stat.ps.minor-faults
  14814080 ±  2%     -17.6%   12210531 ±  2%  perf-stat.ps.node-load-misses
   3874955           -12.8%    3379452        perf-stat.ps.node-store-misses
   3344531           -13.2%    2903674        perf-stat.ps.node-stores
     10534           -10.5%       9426        perf-stat.ps.page-faults
 1.388e+12           +12.3%  1.559e+12        perf-stat.total.instructions
     89.33 ± 85%    +532.9%     565.43 ±137%  interrupts.33:PCI-MSI.524291-edge.eth0-TxRx-2
     68616 ± 20%     +28.2%      87985        interrupts.CPU0.LOC:Local_timer_interrupts
     68549 ± 20%     +28.3%      87982        interrupts.CPU1.LOC:Local_timer_interrupts
     68545 ± 20%     +28.3%      87973        interrupts.CPU10.LOC:Local_timer_interrupts
     68482 ± 20%     +28.5%      87988        interrupts.CPU100.LOC:Local_timer_interrupts
     68443 ± 20%     +28.5%      87978        interrupts.CPU101.LOC:Local_timer_interrupts
     68437 ± 20%     +28.6%      87977        interrupts.CPU102.LOC:Local_timer_interrupts
     68435 ± 20%     +28.6%      87980        interrupts.CPU103.LOC:Local_timer_interrupts
     68437 ± 20%     +28.5%      87971        interrupts.CPU104.LOC:Local_timer_interrupts
     68460 ± 20%     +28.5%      87970        interrupts.CPU105.LOC:Local_timer_interrupts
     68433 ± 20%     +28.6%      87974        interrupts.CPU106.LOC:Local_timer_interrupts
     68437 ± 20%     +28.5%      87972        interrupts.CPU107.LOC:Local_timer_interrupts
     68463 ± 20%     +28.6%      88033        interrupts.CPU108.LOC:Local_timer_interrupts
     68416 ± 20%     +28.6%      87979        interrupts.CPU109.LOC:Local_timer_interrupts
     89.33 ± 85%    +532.9%     565.43 ±137%  interrupts.CPU11.33:PCI-MSI.524291-edge.eth0-TxRx-2
     68529 ± 20%     +28.4%      87973        interrupts.CPU11.LOC:Local_timer_interrupts
     68431 ± 20%     +28.6%      88000        interrupts.CPU110.LOC:Local_timer_interrupts
     68427 ± 20%     +28.6%      88010        interrupts.CPU111.LOC:Local_timer_interrupts
     68449 ± 20%     +28.6%      88009        interrupts.CPU112.LOC:Local_timer_interrupts
     68455 ± 20%     +28.6%      88013        interrupts.CPU113.LOC:Local_timer_interrupts
     68477 ± 20%     +28.5%      88003        interrupts.CPU114.LOC:Local_timer_interrupts
     68465 ± 20%     +28.6%      88040        interrupts.CPU115.LOC:Local_timer_interrupts
      3231 ±  5%     -20.6%       2564 ± 26%  interrupts.CPU115.NMI:Non-maskable_interrupts
      3231 ±  5%     -20.6%       2564 ± 26%  interrupts.CPU115.PMI:Performance_monitoring_interrupts
     68451 ± 20%     +28.6%      88016        interrupts.CPU116.LOC:Local_timer_interrupts
     68515 ± 20%     +28.5%      88020        interrupts.CPU117.LOC:Local_timer_interrupts
      3277 ±  4%     -20.4%       2610 ± 26%  interrupts.CPU117.NMI:Non-maskable_interrupts
      3277 ±  4%     -20.4%       2610 ± 26%  interrupts.CPU117.PMI:Performance_monitoring_interrupts
     68479 ± 20%     +28.5%      88005        interrupts.CPU118.LOC:Local_timer_interrupts
     68456 ± 20%     +28.6%      88008        interrupts.CPU119.LOC:Local_timer_interrupts
     68540 ± 20%     +28.4%      88027        interrupts.CPU12.LOC:Local_timer_interrupts
     68447 ± 20%     +28.6%      88035        interrupts.CPU120.LOC:Local_timer_interrupts
     68414 ± 20%     +28.6%      88007        interrupts.CPU121.LOC:Local_timer_interrupts
     68357 ± 20%     +28.8%      88010        interrupts.CPU122.LOC:Local_timer_interrupts
     68447 ± 20%     +28.6%      88013        interrupts.CPU123.LOC:Local_timer_interrupts
     68489 ± 20%     +28.5%      88024        interrupts.CPU124.LOC:Local_timer_interrupts
     68486 ± 20%     +28.5%      87998        interrupts.CPU125.LOC:Local_timer_interrupts
     68367 ± 20%     +28.7%      87963        interrupts.CPU126.LOC:Local_timer_interrupts
     68403 ± 20%     +28.6%      87956        interrupts.CPU127.LOC:Local_timer_interrupts
     68409 ± 20%     +28.6%      88003        interrupts.CPU128.LOC:Local_timer_interrupts
     68412 ± 20%     +28.6%      87962        interrupts.CPU129.LOC:Local_timer_interrupts
     68486 ± 20%     +28.5%      87994        interrupts.CPU13.LOC:Local_timer_interrupts
     68433 ± 20%     +28.6%      88026        interrupts.CPU130.LOC:Local_timer_interrupts
     68400 ± 20%     +28.6%      87992        interrupts.CPU131.LOC:Local_timer_interrupts
     68402 ± 20%     +28.6%      87979        interrupts.CPU132.LOC:Local_timer_interrupts
      3197 ±  5%     -21.0%       2524 ± 24%  interrupts.CPU132.NMI:Non-maskable_interrupts
      3197 ±  5%     -21.0%       2524 ± 24%  interrupts.CPU132.PMI:Performance_monitoring_interrupts
     68427 ± 20%     +28.6%      87996        interrupts.CPU133.LOC:Local_timer_interrupts
     68393 ± 20%     +28.6%      87976        interrupts.CPU134.LOC:Local_timer_interrupts
     68404 ± 20%     +28.6%      87997        interrupts.CPU135.LOC:Local_timer_interrupts
      3292 ±  6%     -30.1%       2299 ± 31%  interrupts.CPU135.NMI:Non-maskable_interrupts
      3292 ±  6%     -30.1%       2299 ± 31%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
     68414 ± 20%     +28.6%      87978        interrupts.CPU136.LOC:Local_timer_interrupts
      3154 ±  7%     -26.6%       2315 ± 30%  interrupts.CPU136.NMI:Non-maskable_interrupts
      3154 ±  7%     -26.6%       2315 ± 30%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
     68325 ± 20%     +28.7%      87962        interrupts.CPU137.LOC:Local_timer_interrupts
      3172 ±  6%     -27.8%       2290 ± 30%  interrupts.CPU137.NMI:Non-maskable_interrupts
      3172 ±  6%     -27.8%       2290 ± 30%  interrupts.CPU137.PMI:Performance_monitoring_interrupts
     68416 ± 20%     +28.6%      87953        interrupts.CPU138.LOC:Local_timer_interrupts
     68421 ± 20%     +28.6%      87979        interrupts.CPU139.LOC:Local_timer_interrupts
      3118 ±  6%     -27.0%       2275 ± 31%  interrupts.CPU139.NMI:Non-maskable_interrupts
      3118 ±  6%     -27.0%       2275 ± 31%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
     68470 ± 20%     +28.5%      87968        interrupts.CPU14.LOC:Local_timer_interrupts
     68420 ± 20%     +28.6%      87978        interrupts.CPU140.LOC:Local_timer_interrupts
      3173 ±  6%     -27.7%       2293 ± 30%  interrupts.CPU140.NMI:Non-maskable_interrupts
      3173 ±  6%     -27.7%       2293 ± 30%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
     68384 ± 20%     +28.6%      87973        interrupts.CPU141.LOC:Local_timer_interrupts
     68395 ± 20%     +28.6%      87957        interrupts.CPU142.LOC:Local_timer_interrupts
     68332 ± 20%     +28.8%      87985        interrupts.CPU143.LOC:Local_timer_interrupts
      3216 ±  6%     -20.5%       2555 ± 26%  interrupts.CPU143.NMI:Non-maskable_interrupts
      3216 ±  6%     -20.5%       2555 ± 26%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
     68529 ± 20%     +28.3%      87955        interrupts.CPU15.LOC:Local_timer_interrupts
     68492 ± 20%     +28.4%      87924        interrupts.CPU16.LOC:Local_timer_interrupts
     68498 ± 20%     +28.5%      88009        interrupts.CPU17.LOC:Local_timer_interrupts
     68389 ± 20%     +28.7%      88017        interrupts.CPU18.LOC:Local_timer_interrupts
     68458 ± 20%     +28.6%      88011        interrupts.CPU19.LOC:Local_timer_interrupts
     68511 ± 20%     +28.3%      87929        interrupts.CPU2.LOC:Local_timer_interrupts
     68440 ± 20%     +28.6%      87989        interrupts.CPU20.LOC:Local_timer_interrupts
     68476 ± 20%     +28.5%      88008        interrupts.CPU21.LOC:Local_timer_interrupts
     68518 ± 20%     +28.5%      88031        interrupts.CPU22.LOC:Local_timer_interrupts
     68461 ± 20%     +28.5%      87984        interrupts.CPU23.LOC:Local_timer_interrupts
     68487 ± 20%     +28.5%      87984        interrupts.CPU24.LOC:Local_timer_interrupts
     68504 ± 20%     +28.4%      87993        interrupts.CPU25.LOC:Local_timer_interrupts
     68469 ± 20%     +28.5%      87995        interrupts.CPU26.LOC:Local_timer_interrupts
     68458 ± 20%     +28.5%      87944        interrupts.CPU27.LOC:Local_timer_interrupts
     68536 ± 20%     +28.4%      87999        interrupts.CPU28.LOC:Local_timer_interrupts
     68489 ± 20%     +28.5%      88001        interrupts.CPU29.LOC:Local_timer_interrupts
     68515 ± 20%     +28.4%      87981        interrupts.CPU3.LOC:Local_timer_interrupts
     68477 ± 20%     +28.5%      88005        interrupts.CPU30.LOC:Local_timer_interrupts
     68461 ± 20%     +28.6%      88017        interrupts.CPU31.LOC:Local_timer_interrupts
     68487 ± 20%     +28.6%      88069        interrupts.CPU32.LOC:Local_timer_interrupts
     68499 ± 20%     +28.5%      88006        interrupts.CPU33.LOC:Local_timer_interrupts
     68507 ± 20%     +28.5%      88038        interrupts.CPU34.LOC:Local_timer_interrupts
     68529 ± 20%     +28.5%      88049        interrupts.CPU35.LOC:Local_timer_interrupts
     68511 ± 20%     +28.5%      88051        interrupts.CPU36.LOC:Local_timer_interrupts
     68527 ± 20%     +28.5%      88028        interrupts.CPU37.LOC:Local_timer_interrupts
     68508 ± 20%     +28.6%      88076        interrupts.CPU38.LOC:Local_timer_interrupts
     68439 ± 20%     +28.7%      88072        interrupts.CPU39.LOC:Local_timer_interrupts
     68490 ± 20%     +28.3%      87846        interrupts.CPU4.LOC:Local_timer_interrupts
     68413 ± 20%     +28.7%      88044        interrupts.CPU40.LOC:Local_timer_interrupts
     68472 ± 20%     +28.6%      88046        interrupts.CPU41.LOC:Local_timer_interrupts
     68454 ± 20%     +28.6%      88018        interrupts.CPU42.LOC:Local_timer_interrupts
     68486 ± 20%     +28.6%      88060        interrupts.CPU43.LOC:Local_timer_interrupts
     68410 ± 20%     +28.7%      88067        interrupts.CPU44.LOC:Local_timer_interrupts
     68466 ± 20%     +28.6%      88041        interrupts.CPU45.LOC:Local_timer_interrupts
     68471 ± 20%     +28.5%      88015        interrupts.CPU46.LOC:Local_timer_interrupts
     68454 ± 20%     +28.6%      88006        interrupts.CPU47.LOC:Local_timer_interrupts
     68461 ± 20%     +28.6%      88031        interrupts.CPU48.LOC:Local_timer_interrupts
     68422 ± 20%     +28.7%      88037        interrupts.CPU49.LOC:Local_timer_interrupts
     68556 ± 20%     +28.4%      88013        interrupts.CPU5.LOC:Local_timer_interrupts
     68426 ± 20%     +28.6%      87998        interrupts.CPU50.LOC:Local_timer_interrupts
     68462 ± 20%     +28.5%      88006        interrupts.CPU51.LOC:Local_timer_interrupts
     68450 ± 20%     +28.6%      88056        interrupts.CPU52.LOC:Local_timer_interrupts
     68486 ± 20%     +28.5%      88021        interrupts.CPU53.LOC:Local_timer_interrupts
     68408 ± 20%     +28.5%      87925        interrupts.CPU54.LOC:Local_timer_interrupts
     68413 ± 20%     +28.6%      87979        interrupts.CPU55.LOC:Local_timer_interrupts
     68473 ± 20%     +28.6%      88031        interrupts.CPU56.LOC:Local_timer_interrupts
     68461 ± 20%     +28.5%      87996        interrupts.CPU57.LOC:Local_timer_interrupts
      3286 ±  5%      -8.8%       2995 ±  6%  interrupts.CPU57.NMI:Non-maskable_interrupts
      3286 ±  5%      -8.8%       2995 ±  6%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
     68458 ± 20%     +28.6%      88046        interrupts.CPU58.LOC:Local_timer_interrupts
     68433 ± 20%     +28.6%      88019        interrupts.CPU59.LOC:Local_timer_interrupts
      3236 ±  4%     -14.0%       2783 ± 20%  interrupts.CPU59.NMI:Non-maskable_interrupts
      3236 ±  4%     -14.0%       2783 ± 20%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
     68510 ± 20%     +28.5%      88018        interrupts.CPU6.LOC:Local_timer_interrupts
     68435 ± 20%     +28.6%      87993        interrupts.CPU60.LOC:Local_timer_interrupts
     68395 ± 20%     +28.7%      88015        interrupts.CPU61.LOC:Local_timer_interrupts
     68422 ± 20%     +28.6%      88005        interrupts.CPU62.LOC:Local_timer_interrupts
     68438 ± 20%     +28.6%      88005        interrupts.CPU63.LOC:Local_timer_interrupts
     68426 ± 20%     +28.6%      88005        interrupts.CPU64.LOC:Local_timer_interrupts
     68413 ± 20%     +28.6%      88006        interrupts.CPU65.LOC:Local_timer_interrupts
     68437 ± 20%     +28.5%      87963        interrupts.CPU66.LOC:Local_timer_interrupts
     68439 ± 20%     +28.6%      87984        interrupts.CPU67.LOC:Local_timer_interrupts
     68398 ± 20%     +28.6%      87992        interrupts.CPU68.LOC:Local_timer_interrupts
     68386 ± 20%     +28.7%      88020        interrupts.CPU69.LOC:Local_timer_interrupts
     68491 ± 20%     +28.5%      87988        interrupts.CPU7.LOC:Local_timer_interrupts
     68432 ± 20%     +28.5%      87961        interrupts.CPU70.LOC:Local_timer_interrupts
     68433 ± 20%     +28.7%      88057        interrupts.CPU71.LOC:Local_timer_interrupts
     68483 ± 20%     +28.4%      87903        interrupts.CPU72.LOC:Local_timer_interrupts
     68474 ± 20%     +28.5%      87988        interrupts.CPU73.LOC:Local_timer_interrupts
     68540 ± 20%     +28.4%      87981        interrupts.CPU74.LOC:Local_timer_interrupts
     68464 ± 20%     +28.3%      87864        interrupts.CPU75.LOC:Local_timer_interrupts
     68522 ± 20%     +28.3%      87914        interrupts.CPU76.LOC:Local_timer_interrupts
     68527 ± 20%     +28.4%      87998        interrupts.CPU77.LOC:Local_timer_interrupts
     68521 ± 20%     +28.4%      87996        interrupts.CPU78.LOC:Local_timer_interrupts
     68515 ± 20%     +28.4%      87972        interrupts.CPU79.LOC:Local_timer_interrupts
     68529 ± 20%     +28.4%      87998        interrupts.CPU8.LOC:Local_timer_interrupts
     68575 ± 20%     +28.2%      87934        interrupts.CPU80.LOC:Local_timer_interrupts
     68534 ± 20%     +28.4%      87972        interrupts.CPU81.LOC:Local_timer_interrupts
     68516 ± 20%     +28.3%      87940        interrupts.CPU82.LOC:Local_timer_interrupts
     68503 ± 20%     +28.4%      87982        interrupts.CPU83.LOC:Local_timer_interrupts
     68482 ± 20%     +28.3%      87895        interrupts.CPU84.LOC:Local_timer_interrupts
     68446 ± 20%     +28.5%      87953        interrupts.CPU85.LOC:Local_timer_interrupts
     68528 ± 20%     +28.4%      87971        interrupts.CPU86.LOC:Local_timer_interrupts
     68530 ± 20%     +28.4%      87975        interrupts.CPU87.LOC:Local_timer_interrupts
     68547 ± 20%     +28.4%      88021        interrupts.CPU88.LOC:Local_timer_interrupts
     68553 ± 20%     +28.4%      88029        interrupts.CPU89.LOC:Local_timer_interrupts
     68507 ± 20%     +28.1%      87788        interrupts.CPU9.LOC:Local_timer_interrupts
     68435 ± 20%     +28.6%      87999        interrupts.CPU90.LOC:Local_timer_interrupts
     68449 ± 20%     +28.5%      87984        interrupts.CPU91.LOC:Local_timer_interrupts
     68409 ± 20%     +28.6%      87971        interrupts.CPU92.LOC:Local_timer_interrupts
     68521 ± 20%     +28.4%      87984        interrupts.CPU93.LOC:Local_timer_interrupts
     68482 ± 20%     +28.5%      87979        interrupts.CPU94.LOC:Local_timer_interrupts
     68505 ± 20%     +28.5%      88016        interrupts.CPU95.LOC:Local_timer_interrupts
     68508 ± 20%     +28.4%      87991        interrupts.CPU96.LOC:Local_timer_interrupts
     68458 ± 20%     +28.6%      88007        interrupts.CPU97.LOC:Local_timer_interrupts
     68478 ± 20%     +28.5%      87997        interrupts.CPU98.LOC:Local_timer_interrupts
     68485 ± 20%     +28.5%      88003        interrupts.CPU99.LOC:Local_timer_interrupts
    103.00 ± 36%     -96.1%       4.00 ±139%  interrupts.IWI:IRQ_work_interrupts
   9858923 ± 20%     +28.5%   12671097        interrupts.LOC:Local_timer_interrupts
      2739 ±  6%    +138.4%       6532 ±  2%  interrupts.RES:Rescheduling_interrupts
     53.63 ±  2%     -20.1       33.52 ±  4%  perf-profile.calltrace.cycles-pp.write
     52.70 ±  2%     -19.9       32.77 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     52.49 ±  2%     -19.9       32.60 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     52.12 ±  2%     -19.8       32.30 ±  4%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     51.63 ±  2%     -19.7       31.91 ±  4%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     50.46 ±  2%     -19.5       30.95 ±  4%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     49.95 ±  2%     -19.4       30.54 ±  5%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
     47.06 ±  2%     -18.5       28.57 ±  5%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
     46.95 ±  2%     -18.5       28.49 ±  5%  perf-profile.calltrace.cycles-pp.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write.vfs_write
     44.06 ±  2%     -17.9       26.15 ±  5%  perf-profile.calltrace.cycles-pp.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
     32.38 ±  3%     -14.1       18.28 ±  7%  perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
     28.98 ±  4%     -13.6       15.38 ±  8%  perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
     28.87 ±  4%     -13.6       15.30 ±  8%  perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply
     27.02 ±  4%     -13.3       13.76 ±  9%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
     19.56 ±  3%      -9.3       10.27 ±  6%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
     17.83 ±  5%      -9.2        8.61 ± 10%  perf-profile.calltrace.cycles-pp.__close
     17.82 ±  5%      -9.2        8.61 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     17.82 ±  5%      -9.2        8.61 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     17.81 ±  5%      -9.2        8.60 ± 10%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     17.81 ±  5%      -9.2        8.60 ± 10%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     17.81 ±  5%      -9.2        8.60 ± 10%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     17.81 ±  5%      -9.2        8.60 ± 10%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     17.80 ±  5%      -9.2        8.59 ± 10%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
     17.78 ±  5%      -9.2        8.58 ± 10%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_prepare
     17.07 ±  5%      -8.5        8.55 ± 10%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
     17.05 ±  5%      -8.5        8.54 ± 10%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.__dentry_kill.dput.__fput
     14.50 ±  3%      -7.1        7.40 ±  7%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
     10.43 ±  7%      -5.6        4.85 ± 14%  perf-profile.calltrace.cycles-pp.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill.dput
     10.08 ±  7%      -5.4        4.70 ± 14%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill
      7.42 ± 10%      -4.0        3.46 ± 17%  perf-profile.calltrace.cycles-pp.lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      7.35 ± 10%      -4.0        3.40 ± 18%  perf-profile.calltrace.cycles-pp.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      9.05 ±  3%      -3.3        5.76 ±  3%  perf-profile.calltrace.cycles-pp.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      5.06 ± 14%      -3.0        2.06 ± 26%  perf-profile.calltrace.cycles-pp.lock_page_lruvec_irqsave.release_pages.__pagevec_release.truncate_inode_pages_range.evict
      7.23 ±  3%      -3.0        4.25 ±  4%  perf-profile.calltrace.cycles-pp.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      5.00 ± 14%      -3.0        2.03 ± 26%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.release_pages.__pagevec_release.truncate_inode_pages_range
      4.98 ± 14%      -3.0        2.01 ± 26%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.release_pages.__pagevec_release
      4.90 ± 14%      -2.9        2.02 ± 26%  perf-profile.calltrace.cycles-pp.lock_page_lruvec_irqsave.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru.pagecache_get_page
      4.82 ± 14%      -2.8        1.97 ± 26%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru
      4.80 ± 14%      -2.8        1.96 ± 27%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.__pagevec_lru_add.lru_cache_add
      5.54 ±  3%      -2.7        2.89 ±  7%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      5.39 ±  3%      -2.6        2.76 ±  6%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      6.03 ±  3%      -2.6        3.42 ±  4%  perf-profile.calltrace.cycles-pp.__set_page_dirty.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor.iomap_apply
      4.65 ±  4%      -2.2        2.49 ±  6%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.__set_page_dirty.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor
      4.43 ±  4%      -2.0        2.39 ±  6%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      3.88 ±  2%      -1.8        2.10 ±  6%  perf-profile.calltrace.cycles-pp.truncate_cleanup_page.truncate_inode_pages_range.evict.__dentry_kill.dput
      3.73 ±  2%      -1.7        2.00 ±  6%  perf-profile.calltrace.cycles-pp.__cancel_dirty_page.truncate_cleanup_page.truncate_inode_pages_range.evict.__dentry_kill
      3.59 ±  3%      -1.7        1.89 ±  6%  perf-profile.calltrace.cycles-pp.account_page_cleaned.__cancel_dirty_page.truncate_cleanup_page.truncate_inode_pages_range.evict
      3.34 ±  2%      -1.7        1.67 ±  7%  perf-profile.calltrace.cycles-pp.mem_cgroup_uncharge_list.release_pages.__pagevec_release.truncate_inode_pages_range.evict
      3.35 ±  3%      -1.6        1.73 ±  7%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.account_page_cleaned.__cancel_dirty_page.truncate_cleanup_page.truncate_inode_pages_range
      3.34 ±  3%      -1.6        1.76 ±  6%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.__set_page_dirty.__set_page_dirty_nobuffers.iomap_write_end
      3.24 ±  3%      -1.5        1.69 ±  7%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__mod_lruvec_page_state.__set_page_dirty.__set_page_dirty_nobuffers
      3.00 ±  4%      -1.4        1.58 ±  7%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      2.89 ±  4%      -1.4        1.50 ±  7%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__mod_lruvec_page_state.__add_to_page_cache_locked.add_to_page_cache_lru
      2.46 ±  3%      -1.2        1.24 ±  7%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.account_page_cleaned.__cancel_dirty_page.truncate_cleanup_page
      2.36 ±  3%      -1.2        1.18 ±  8%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__mod_lruvec_page_state.account_page_cleaned.__cancel_dirty_page
      2.45 ±  4%      -1.1        1.36 ±  5%  perf-profile.calltrace.cycles-pp.delete_from_page_cache_batch.truncate_inode_pages_range.evict.__dentry_kill.dput
      2.12 ±  5%      -1.0        1.10 ±  6%  perf-profile.calltrace.cycles-pp.unaccount_page_cache_page.delete_from_page_cache_batch.truncate_inode_pages_range.evict.__dentry_kill
      2.08 ±  5%      -1.0        1.06 ±  7%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.unaccount_page_cache_page.delete_from_page_cache_batch.truncate_inode_pages_range.evict
      1.67 ±  4%      -0.9        0.75 ± 10%  perf-profile.calltrace.cycles-pp.uncharge_page.mem_cgroup_uncharge_list.release_pages.__pagevec_release.truncate_inode_pages_range
      1.89 ±  5%      -0.9        0.98 ±  8%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru.pagecache_get_page
      1.79 ±  5%      -0.9        0.92 ±  9%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru
      1.67 ±  3%      -0.8        0.91 ±  6%  perf-profile.calltrace.cycles-pp.uncharge_batch.mem_cgroup_uncharge_list.release_pages.__pagevec_release.truncate_inode_pages_range
      1.50 ±  5%      -0.7        0.75 ±  7%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.unaccount_page_cache_page.delete_from_page_cache_batch.truncate_inode_pages_range
      1.90 ±  9%      -0.7        1.18 ±  4%  perf-profile.calltrace.cycles-pp.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
      1.40 ±  5%      -0.7        0.69 ±  7%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__mod_lruvec_page_state.unaccount_page_cache_page.delete_from_page_cache_batch
      1.25 ±  3%      -0.6        0.64 ±  7%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.release_pages.__pagevec_release.truncate_inode_pages_range.evict
      1.24 ± 13%      -0.6        0.65 ±  6%  perf-profile.calltrace.cycles-pp.file_update_time.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write
      1.15 ±  3%      -0.6        0.58 ±  8%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.release_pages.__pagevec_release.truncate_inode_pages_range
      1.13 ±  4%      -0.5        0.64 ±  6%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.uncharge_batch.mem_cgroup_uncharge_list.release_pages.__pagevec_release
      1.91 ±  3%      -0.3        1.57 ±  5%  perf-profile.calltrace.cycles-pp.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
      2.06 ±  5%      -0.3        1.75 ±  4%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.61 ±  6%      -0.2        0.37 ± 63%  perf-profile.calltrace.cycles-pp.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      1.21 ±  5%      -0.2        0.99 ±  4%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      1.31 ±  6%      -0.2        1.10 ±  4%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.92 ±  5%      -0.2        0.76 ±  4%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.84 ±  5%      -0.1        0.69 ±  5%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply
      0.87 ±  5%      -0.1        0.75 ±  5%  perf-profile.calltrace.cycles-pp.memset_erms.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.00            +0.6        0.61 ±  4%  perf-profile.calltrace.cycles-pp.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread
      0.00            +0.7        0.67 ±  4%  perf-profile.calltrace.cycles-pp.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread.kthread
      0.00            +0.7        0.67 ±  4%  perf-profile.calltrace.cycles-pp.xfs_inodegc_worker.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.7        0.68 ±  4%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.7        0.69 ±  4%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.00            +0.7        0.70 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.00            +0.7        0.70 ±  4%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      1.56 ± 13%     +13.1       14.63 ±  4%  perf-profile.calltrace.cycles-pp.creat64
      1.55 ± 13%     +13.1       14.62 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      1.55 ± 13%     +13.1       14.62 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      1.55 ± 13%     +13.1       14.61 ±  4%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      1.54 ± 13%     +13.1       14.61 ±  4%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      1.53 ± 13%     +13.1       14.60 ±  4%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.52 ± 13%     +13.1       14.60 ±  4%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.00           +13.1       13.12 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      0.64 ± 11%     +13.2       13.81 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      1.78 ± 11%     +15.5       17.26 ±  4%  perf-profile.calltrace.cycles-pp.unlink
      1.76 ± 11%     +15.5       17.25 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      1.76 ± 11%     +15.5       17.25 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      1.75 ± 11%     +15.5       17.24 ±  4%  perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      1.23 ±  7%     +15.5       16.72 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.09 ±223%     +15.8       15.89 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     53.94 ±  2%     -20.2       33.77 ±  4%  perf-profile.children.cycles-pp.write
     52.16 ±  2%     -19.8       32.32 ±  4%  perf-profile.children.cycles-pp.ksys_write
     51.68 ±  2%     -19.7       31.93 ±  4%  perf-profile.children.cycles-pp.vfs_write
     50.49 ±  2%     -19.5       30.96 ±  4%  perf-profile.children.cycles-pp.new_sync_write
     49.97 ±  2%     -19.4       30.55 ±  5%  perf-profile.children.cycles-pp.xfs_file_buffered_write
     47.06 ±  2%     -18.5       28.58 ±  5%  perf-profile.children.cycles-pp.iomap_file_buffered_write
     46.96 ±  2%     -18.5       28.50 ±  5%  perf-profile.children.cycles-pp.iomap_apply
     44.09 ±  2%     -17.9       26.18 ±  5%  perf-profile.children.cycles-pp.iomap_write_actor
     32.39 ±  3%     -14.1       18.29 ±  7%  perf-profile.children.cycles-pp.iomap_write_begin
     29.00 ±  4%     -13.6       15.40 ±  8%  perf-profile.children.cycles-pp.grab_cache_page_write_begin
     28.92 ±  4%     -13.6       15.33 ±  8%  perf-profile.children.cycles-pp.pagecache_get_page
     27.02 ±  4%     -13.3       13.76 ±  9%  perf-profile.children.cycles-pp.add_to_page_cache_lru
     19.57 ±  3%      -9.3       10.27 ±  6%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
     18.04 ±  5%      -9.3        8.78 ±  9%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     17.96 ±  5%      -9.3        8.71 ± 10%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
     17.83 ±  5%      -9.2        8.61 ± 10%  perf-profile.children.cycles-pp.__close
     17.81 ±  5%      -9.2        8.60 ± 10%  perf-profile.children.cycles-pp.__fput
     17.81 ±  5%      -9.2        8.60 ± 10%  perf-profile.children.cycles-pp.dput
     17.81 ±  5%      -9.2        8.60 ± 10%  perf-profile.children.cycles-pp.task_work_run
     17.78 ±  5%      -9.2        8.58 ± 10%  perf-profile.children.cycles-pp.__dentry_kill
     17.07 ±  5%      -8.5        8.55 ± 10%  perf-profile.children.cycles-pp.evict
     17.05 ±  5%      -8.5        8.54 ± 10%  perf-profile.children.cycles-pp.truncate_inode_pages_range
     14.52 ±  3%      -7.1        7.41 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_charge
     14.53 ±  4%      -6.9        7.67 ±  6%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
     13.51 ±  3%      -6.5        6.99 ±  7%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
     12.88 ±  4%      -6.3        6.57 ±  7%  perf-profile.children.cycles-pp.__mod_memcg_state
     10.59 ± 13%      -6.3        4.32 ± 25%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     10.27 ± 14%      -6.1        4.21 ± 26%  perf-profile.children.cycles-pp.lock_page_lruvec_irqsave
     10.33 ± 14%      -6.0        4.29 ± 25%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     10.43 ±  7%      -5.6        4.85 ± 14%  perf-profile.children.cycles-pp.__pagevec_release
     10.17 ±  7%      -5.4        4.76 ± 13%  perf-profile.children.cycles-pp.release_pages
      7.70 ± 10%      -4.1        3.55 ± 18%  perf-profile.children.cycles-pp.__pagevec_lru_add
      7.43 ± 10%      -4.0        3.46 ± 17%  perf-profile.children.cycles-pp.lru_cache_add
      9.07 ±  3%      -3.3        5.77 ±  3%  perf-profile.children.cycles-pp.iomap_write_end
      7.25 ±  3%      -3.0        4.26 ±  4%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      5.56 ±  3%      -2.7        2.90 ±  7%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      5.40 ±  3%      -2.6        2.77 ±  6%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      6.04 ±  3%      -2.6        3.43 ±  4%  perf-profile.children.cycles-pp.__set_page_dirty
      3.88 ±  2%      -1.8        2.10 ±  6%  perf-profile.children.cycles-pp.truncate_cleanup_page
      3.73 ±  2%      -1.7        2.00 ±  6%  perf-profile.children.cycles-pp.__cancel_dirty_page
      3.60 ±  3%      -1.7        1.90 ±  6%  perf-profile.children.cycles-pp.account_page_cleaned
      3.35 ±  2%      -1.7        1.67 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      2.45 ±  4%      -1.1        1.36 ±  5%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      2.12 ±  5%      -1.0        1.10 ±  6%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      1.67 ±  4%      -0.9        0.76 ± 10%  perf-profile.children.cycles-pp.uncharge_page
      1.67 ±  3%      -0.8        0.91 ±  6%  perf-profile.children.cycles-pp.uncharge_batch
      1.92 ±  8%      -0.7        1.20 ±  4%  perf-profile.children.cycles-pp.xfs_file_write_checks
      1.25 ± 13%      -0.6        0.66 ±  6%  perf-profile.children.cycles-pp.file_update_time
      0.95 ± 17%      -0.5        0.43 ±  9%  perf-profile.children.cycles-pp.xfs_vn_update_time
      3.37 ±  5%      -0.5        2.85 ±  4%  perf-profile.children.cycles-pp.iomap_set_range_uptodate
      1.17 ±  4%      -0.5        0.67 ±  7%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.80 ±  4%      -0.4        0.43 ±  5%  perf-profile.children.cycles-pp.__count_memcg_events
      1.96 ±  3%      -0.3        1.62 ±  5%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      1.30 ± 11%      -0.3        0.96 ±  4%  perf-profile.children.cycles-pp.__xfs_trans_commit
      1.28 ± 11%      -0.3        0.95 ±  4%  perf-profile.children.cycles-pp.xlog_cil_commit
      0.73 ±  6%      -0.3        0.43 ±  5%  perf-profile.children.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.67 ± 15%      -0.3        0.37 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock
      0.75 ±  5%      -0.3        0.45 ±  7%  perf-profile.children.cycles-pp.page_counter_cancel
      0.65 ±  5%      -0.3        0.36 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.56 ±  3%      -0.3        0.30 ±  6%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.68 ±  5%      -0.2        0.45 ±  7%  perf-profile.children.cycles-pp.lock_page_memcg
      1.22 ±  5%      -0.2        1.00 ±  4%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.59 ±  4%      -0.2        0.37 ±  4%  perf-profile.children.cycles-pp.try_charge_memcg
      0.34 ± 13%      -0.2        0.15 ± 24%  perf-profile.children.cycles-pp.lru_add_drain
      0.34 ± 13%      -0.2        0.15 ± 24%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.88 ± 11%      -0.2        0.69 ±  5%  perf-profile.children.cycles-pp.xlog_cil_insert_items
      0.47 ±  3%      -0.2        0.29 ±  5%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.30 ± 22%      -0.2        0.12 ± 13%  perf-profile.children.cycles-pp.xfs_trans_alloc
      0.28 ± 22%      -0.2        0.10 ± 16%  perf-profile.children.cycles-pp.xfs_log_reserve
      0.93 ±  5%      -0.2        0.77 ±  4%  perf-profile.children.cycles-pp.copyin
      0.28 ± 22%      -0.2        0.11 ± 14%  perf-profile.children.cycles-pp.xfs_trans_reserve
      0.91 ±  3%      -0.2        0.75 ±  3%  perf-profile.children.cycles-pp.xfs_ilock
      0.90 ±  5%      -0.2        0.74 ±  4%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.79 ±  4%      -0.1        0.65 ±  2%  perf-profile.children.cycles-pp.down_write
      0.50 ±  4%      -0.1        0.37 ±  5%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.46 ±  4%      -0.1        0.34 ±  3%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.89 ±  5%      -0.1        0.77 ±  5%  perf-profile.children.cycles-pp.memset_erms
      0.18 ± 21%      -0.1        0.06 ± 20%  perf-profile.children.cycles-pp.xlog_grant_add_space
      0.53 ±  5%      -0.1        0.41 ±  5%  perf-profile.children.cycles-pp.xfs_iunlock
      0.20 ± 49%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.54 ±  5%      -0.1        0.44 ±  5%  perf-profile.children.cycles-pp.__entry_text_start
      0.62 ±  6%      -0.1        0.52 ±  4%  perf-profile.children.cycles-pp.__alloc_pages
      0.32 ±  2%      -0.1        0.22 ±  6%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_end
      0.50 ±  3%      -0.1        0.41 ±  4%  perf-profile.children.cycles-pp.___might_sleep
      0.37 ± 11%      -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      0.45 ±  6%      -0.1        0.36 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.38 ±  5%      -0.1        0.29 ±  5%  perf-profile.children.cycles-pp.up_write
      0.49 ±  4%      -0.1        0.40 ±  5%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.42 ±  5%      -0.1        0.34 ±  4%  perf-profile.children.cycles-pp.security_file_permission
      0.41 ±  3%      -0.1        0.33 ±  2%  perf-profile.children.cycles-pp.xas_store
      0.25 ±  6%      -0.1        0.17 ±  4%  perf-profile.children.cycles-pp.__unlock_page_memcg
      0.49 ±  7%      -0.1        0.41 ±  4%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.38 ±  5%      -0.1        0.30 ±  4%  perf-profile.children.cycles-pp.__fdget_pos
      0.12 ± 12%      -0.1        0.05        perf-profile.children.cycles-pp.xfs_inactive_truncate
      0.34 ±  5%      -0.1        0.27 ±  4%  perf-profile.children.cycles-pp.common_file_perm
      0.19 ±  7%      -0.1        0.12 ± 10%  perf-profile.children.cycles-pp.xfs_bmbt_to_iomap
      0.32 ±  5%      -0.1        0.26 ±  4%  perf-profile.children.cycles-pp.__fget_light
      0.22 ±  9%      -0.1        0.16 ±  5%  perf-profile.children.cycles-pp.xfs_buf_find
      0.35 ±  4%      -0.1        0.29 ±  6%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.25 ±  8%      -0.1        0.18 ±  4%  perf-profile.children.cycles-pp.xfs_buf_read_map
      0.24 ±  9%      -0.1        0.17 ±  4%  perf-profile.children.cycles-pp.xfs_buf_get_map
      0.30 ±  4%      -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.xfs_break_layouts
      0.29 ±  5%      -0.1        0.23 ±  4%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.16 ±  8%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.16 ± 10%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.xfs_read_agi
      0.28 ±  7%      -0.1        0.23 ± 10%  perf-profile.children.cycles-pp.xfs_file_write_iter
      0.14 ± 10%      -0.1        0.09 ± 10%  perf-profile.children.cycles-pp.rcu_core
      0.23 ±  2%      -0.1        0.18 ±  7%  perf-profile.children.cycles-pp.find_lock_entries
      0.27 ±  4%      -0.0        0.22 ±  5%  perf-profile.children.cycles-pp.__might_sleep
      0.11 ± 10%      -0.0        0.06 ± 12%  perf-profile.children.cycles-pp.rcu_do_batch
      0.24 ±  5%      -0.0        0.19 ±  4%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.25 ±  4%      -0.0        0.21 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.07 ±  9%      -0.0        0.03 ± 86%  perf-profile.children.cycles-pp.schedule_timeout
      0.10 ±  9%      -0.0        0.06 ± 10%  perf-profile.children.cycles-pp.kmem_cache_free
      0.18 ±  8%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.current_time
      0.22 ± 11%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.rmqueue
      0.22 ±  7%      -0.0        0.18 ±  6%  perf-profile.children.cycles-pp.unlock_page
      0.08 ± 10%      -0.0        0.04 ± 40%  perf-profile.children.cycles-pp.down
      0.08 ± 10%      -0.0        0.04 ± 40%  perf-profile.children.cycles-pp.__down
      0.12 ±  5%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.xas_create
      0.12 ± 22%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.xfs_dir2_node_addname
      0.12 ± 21%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.xfs_dir_createname
      0.14 ±  6%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.xfs_iunlink_remove
      0.06 ±  7%      -0.0        0.03 ± 86%  perf-profile.children.cycles-pp.file_remove_privs
      0.11 ±  3%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.09 ±  6%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.xas_alloc
      0.18 ±  5%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.xfs_break_leased_layouts
      0.14 ± 18%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.xfs_da_read_buf
      0.16 ±  4%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.generic_write_checks
      0.08 ±  8%      -0.0        0.05 ±  6%  perf-profile.children.cycles-pp.xfs_buf_lock
      0.11 ±  8%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.xfs_btree_lookup
      0.14 ±  5%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.node_dirty_ok
      0.10 ± 16%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.try_to_wake_up
      0.08 ±  8%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.xfs_btree_lookup_get_block
      0.19 ±  7%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.07 ±  9%      -0.0        0.04 ± 41%  perf-profile.children.cycles-pp.xfs_btree_read_buf_block
      0.07 ± 10%      -0.0        0.04 ± 41%  perf-profile.children.cycles-pp.balance_dirty_pages
      0.14 ±  9%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.12 ±  6%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.rcu_all_qs
      0.06 ± 11%      -0.0        0.04 ± 40%  perf-profile.children.cycles-pp.iomap_page_create
      0.09 ±  6%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.file_modified
      0.07 ± 20%      -0.0        0.05 ±  6%  perf-profile.children.cycles-pp.xfs_dir2_node_addname_int
      0.12 ±  7%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.free_unref_page_list
      0.07 ±  8%      -0.0        0.05        perf-profile.children.cycles-pp.up
      0.07 ± 12%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.xfs_buf_unlock
      0.08 ± 17%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.xfs_vn_lookup
      0.10 ±  5%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.page_mapping
      0.08 ±  9%      -0.0        0.06 ±  5%  perf-profile.children.cycles-pp.xfs_buf_item_release
      0.09 ±  7%      -0.0        0.07 ±  4%  perf-profile.children.cycles-pp.xfs_bmapi_reserve_delalloc
      0.09 ±  7%      -0.0        0.07 ±  4%  perf-profile.children.cycles-pp.aa_file_perm
      0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.07 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__list_add_valid
      0.08 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.07 ± 11%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.xa_get_order
      0.06 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.timestamp_truncate
      0.04 ± 47%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__xfs_btree_check_sblock
      0.04 ± 45%      +0.0        0.09 ±  8%  perf-profile.children.cycles-pp.load_balance
      0.07 ± 14%      +0.0        0.12 ±  7%  perf-profile.children.cycles-pp.xfs_btree_get_rec
      0.07 ± 14%      +0.1        0.13 ±  6%  perf-profile.children.cycles-pp.xfs_btree_increment
      0.08 ± 17%      +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.xfs_btree_check_sblock
      0.01 ±223%      +0.1        0.07 ±  9%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.16 ± 12%      +0.1        0.23 ±  5%  perf-profile.children.cycles-pp.xfs_inobt_get_rec
      0.01 ±223%      +0.1        0.08 ±  9%  perf-profile.children.cycles-pp.find_busiest_group
      0.01 ±223%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.newidle_balance
      0.15 ± 19%      +0.1        0.23 ±  4%  perf-profile.children.cycles-pp.memcpy_erms
      0.17 ± 20%      +0.1        0.28 ±  4%  perf-profile.children.cycles-pp.xfs_buf_item_format_segment
      0.18 ± 19%      +0.1        0.29 ±  4%  perf-profile.children.cycles-pp.xfs_buf_item_format
      0.31 ± 10%      +0.1        0.42 ±  5%  perf-profile.children.cycles-pp.xfs_check_agi_freecount
      0.00            +0.7        0.67 ±  4%  perf-profile.children.cycles-pp.xfs_inodegc_worker
      0.00            +0.7        0.68 ±  4%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.7        0.69 ±  4%  perf-profile.children.cycles-pp.worker_thread
      0.00            +0.7        0.70 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
      0.00            +0.7        0.70 ±  4%  perf-profile.children.cycles-pp.kthread
      1.55 ± 13%     +13.1       14.62 ±  4%  perf-profile.children.cycles-pp.do_sys_open
      1.57 ± 13%     +13.1       14.63 ±  4%  perf-profile.children.cycles-pp.creat64
      1.55 ± 13%     +13.1       14.62 ±  4%  perf-profile.children.cycles-pp.do_sys_openat2
      1.53 ± 13%     +13.1       14.60 ±  4%  perf-profile.children.cycles-pp.do_filp_open
      1.53 ± 13%     +13.1       14.60 ±  4%  perf-profile.children.cycles-pp.path_openat
      1.79 ± 11%     +15.5       17.27 ±  4%  perf-profile.children.cycles-pp.unlink
      1.75 ± 11%     +15.5       17.24 ±  4%  perf-profile.children.cycles-pp.do_unlinkat
      0.49 ±  7%     +28.5       29.02 ±  4%  perf-profile.children.cycles-pp.osq_lock
      1.87 ±  8%     +28.7       30.53 ±  4%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     12.87 ±  4%      -6.3        6.57 ±  7%  perf-profile.self.cycles-pp.__mod_memcg_state
     10.59 ± 13%      -6.3        4.32 ± 25%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      5.35 ±  3%      -2.6        2.74 ±  6%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      4.24 ±  4%      -2.1        2.12 ±  8%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      4.01 ±  6%      -1.8        2.16 ±  7%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      3.54 ±  3%      -1.8        1.73 ±  8%  perf-profile.self.cycles-pp.mem_cgroup_charge
      1.65 ±  4%      -0.9        0.75 ± 10%  perf-profile.self.cycles-pp.uncharge_page
      3.35 ±  5%      -0.5        2.84 ±  4%  perf-profile.self.cycles-pp.iomap_set_range_uptodate
      0.80 ±  4%      -0.4        0.43 ±  5%  perf-profile.self.cycles-pp.__count_memcg_events
      0.73 ±  6%      -0.3        0.42 ±  5%  perf-profile.self.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.74 ±  5%      -0.3        0.44 ±  8%  perf-profile.self.cycles-pp.page_counter_cancel
      0.56 ±  3%      -0.3        0.29 ±  6%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.67 ±  6%      -0.2        0.44 ±  7%  perf-profile.self.cycles-pp.lock_page_memcg
      0.54 ±  4%      -0.2        0.36 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.33 ±  4%      -0.2        0.16 ±  6%  perf-profile.self.cycles-pp.uncharge_batch
      0.89 ±  5%      -0.2        0.73 ±  4%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.71 ±  4%      -0.1        0.56 ±  5%  perf-profile.self.cycles-pp.pagecache_get_page
      0.33 ±  4%      -0.1        0.21 ±  6%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.54 ±  4%      -0.1        0.42 ±  5%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_begin
      0.88 ±  5%      -0.1        0.76 ±  5%  perf-profile.self.cycles-pp.memset_erms
      0.18 ± 21%      -0.1        0.06 ± 20%  perf-profile.self.cycles-pp.xlog_grant_add_space
      0.60 ±  5%      -0.1        0.49 ±  4%  perf-profile.self.cycles-pp.iomap_apply
      0.43 ±  4%      -0.1        0.32 ±  3%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.40 ±  5%      -0.1        0.29 ±  4%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      0.48 ±  2%      -0.1        0.40 ±  4%  perf-profile.self.cycles-pp.___might_sleep
      0.44 ±  6%      -0.1        0.35 ±  5%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.24 ±  3%      -0.1        0.16 ±  5%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_end
      0.31 ±  4%      -0.1        0.23 ±  6%  perf-profile.self.cycles-pp.__pagevec_lru_add
      0.42 ±  6%      -0.1        0.34 ±  2%  perf-profile.self.cycles-pp.down_write
      0.24 ±  5%      -0.1        0.16 ±  4%  perf-profile.self.cycles-pp.__unlock_page_memcg
      0.36 ±  5%      -0.1        0.28 ±  6%  perf-profile.self.cycles-pp.up_write
      0.42 ±  5%      -0.1        0.35 ±  6%  perf-profile.self.cycles-pp.write
      0.39 ±  8%      -0.1        0.31 ±  5%  perf-profile.self.cycles-pp.vfs_write
      0.33 ±  6%      -0.1        0.26 ± 10%  perf-profile.self.cycles-pp.xfs_file_buffered_write
      0.33 ±  5%      -0.1        0.26 ±  7%  perf-profile.self.cycles-pp.iomap_write_end
      0.14 ±  7%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.lock_page_lruvec_irqsave
      0.18 ±  8%      -0.1        0.12 ± 12%  perf-profile.self.cycles-pp.xfs_bmbt_to_iomap
      0.31 ±  6%      -0.1        0.24 ±  4%  perf-profile.self.cycles-pp.__fget_light
      0.34 ±  4%      -0.1        0.28 ±  5%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.37 ±  5%      -0.1        0.31 ±  6%  perf-profile.self.cycles-pp.iomap_write_begin
      0.30 ±  8%      -0.1        0.24 ±  5%  perf-profile.self.cycles-pp.iomap_write_actor
      0.23 ±  3%      -0.1        0.18 ±  6%  perf-profile.self.cycles-pp.release_pages
      0.28 ±  8%      -0.1        0.23 ± 10%  perf-profile.self.cycles-pp.xfs_file_write_iter
      0.26 ±  5%      -0.1        0.20 ±  5%  perf-profile.self.cycles-pp.common_file_perm
      0.28 ±  6%      -0.1        0.23 ±  4%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.25 ±  6%      -0.1        0.20 ±  8%  perf-profile.self.cycles-pp.__entry_text_start
      0.19 ±  3%      -0.0        0.15 ±  8%  perf-profile.self.cycles-pp.find_lock_entries
      0.24 ±  5%      -0.0        0.19 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.19 ±  6%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.__add_to_page_cache_locked
      0.23 ±  5%      -0.0        0.19 ±  4%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.27 ±  8%      -0.0        0.23 ±  6%  perf-profile.self.cycles-pp.xas_load
      0.14 ±  6%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.try_charge_memcg
      0.22 ±  7%      -0.0        0.18 ±  5%  perf-profile.self.cycles-pp.unlock_page
      0.16 ±  3%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.xfs_iunlock
      0.13 ±  8%      -0.0        0.09 ± 17%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.18 ±  6%      -0.0        0.15 ±  5%  perf-profile.self.cycles-pp.__set_page_dirty_nobuffers
      0.11 ±  3%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.24 ±  4%      -0.0        0.20 ±  5%  perf-profile.self.cycles-pp.__might_sleep
      0.13 ±  8%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.__set_page_dirty
      0.21 ±  6%      -0.0        0.18 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.17 ±  9%      -0.0        0.14 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock
      0.17 ±  4%      -0.0        0.14 ±  6%  perf-profile.self.cycles-pp.xfs_break_leased_layouts
      0.16 ±  5%      -0.0        0.13 ±  6%  perf-profile.self.cycles-pp.new_sync_write
      0.19 ±  8%      -0.0        0.16 ±  6%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.10 ± 18%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.xlog_cil_commit
      0.12 ±  6%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.file_update_time
      0.12 ±  5%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.xfs_file_write_checks
      0.13 ±  6%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.__cond_resched
      0.13 ±  3%      -0.0        0.11 ±  5%  perf-profile.self.cycles-pp.xfs_ilock
      0.06            -0.0        0.04 ± 63%  perf-profile.self.cycles-pp.lru_cache_add
      0.10 ±  3%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.node_dirty_ok
      0.15 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.xas_store
      0.12 ±  7%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.ksys_write
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__alloc_pages
      0.10 ±  6%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.iomap_file_buffered_write
      0.07 ±  8%      -0.0        0.05 ±  6%  perf-profile.self.cycles-pp.__list_add_valid
      0.10 ±  3%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.page_mapping
      0.08 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.generic_write_checks
      0.08 ±  4%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.rcu_all_qs
      0.08 ±  7%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.07 ±  6%      -0.0        0.06 ±  5%  perf-profile.self.cycles-pp.aa_file_perm
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__cancel_dirty_page
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.11 ±  9%      +0.0        0.15 ±  5%  perf-profile.self.cycles-pp.disk_wrt
      0.00            +0.1        0.05 ±  9%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.01 ±223%      +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.__xfs_btree_check_sblock
      0.14 ± 22%      +0.1        0.23 ±  4%  perf-profile.self.cycles-pp.memcpy_erms
      0.49 ±  6%     +28.3       28.82 ±  4%  perf-profile.self.cycles-pp.osq_lock



***************************************************************************************************
lkp-csl-2sp9: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/4BRD_12G/xfs/x86_64-rhel-8.3/3000/RAID1/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp9/disk_rw/aim7/0x5003006

commit: 
  62af7d54a0 ("xfs: detach dquots from inode if we don't need to inactivate it")
  ab23a77687 ("xfs: per-cpu deferred inode inactivation queues")

62af7d54a0ec0b6f ab23a7768739a23d21d8a16ca37 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    520213           -16.4%     434879        aim7.jobs-per-min
     34.81           +19.5%      41.59        aim7.time.elapsed_time
     34.81           +19.5%      41.59        aim7.time.elapsed_time.max
      2570         +1164.3%      32495 ±  2%  aim7.time.involuntary_context_switches
    784.33           +36.9%       1073        aim7.time.system_time
    940492           -35.1%     610759        aim7.time.voluntary_context_switches
 2.287e+09           +12.8%   2.58e+09        cpuidle..time
      3449 ± 37%    +291.5%      13505 ± 51%  vmstat.io.bo
     52228           -16.4%      43680        vmstat.system.cs
     73.11            -5.9%      68.84        iostat.cpu.idle
     25.02 ±  2%     +15.9%      28.99        iostat.cpu.system
      1.77           -13.2%       1.53 ±  2%  iostat.cpu.user
     15268 ±  6%     +42.2%      21710 ±  6%  meminfo.Active
     14936 ±  6%     +43.7%      21470 ±  6%  meminfo.Active(anon)
     27780 ±  5%     +23.2%      34238 ±  5%  meminfo.Shmem
     12727 ± 16%     +58.9%      20224 ±  7%  numa-meminfo.node1.Active
     12687 ± 16%     +59.4%      20224 ±  7%  numa-meminfo.node1.Active(anon)
     22324 ± 17%     +33.9%      29885 ± 11%  numa-meminfo.node1.Shmem
      0.07 ± 96%     -89.7%       0.01 ± 49%  perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      1.38 ±105%     -93.6%       0.09 ±173%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      2.95 ± 24%     -39.1%       1.80 ±  3%  perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      5879 ±  4%     +31.8%       7748 ± 24%  softirqs.CPU28.RCU
      5854 ±  5%     +31.5%       7695 ± 27%  softirqs.CPU74.RCU
    539818 ±  2%     +13.6%     613376 ±  3%  softirqs.RCU
      1.18 ±  9%      -0.1        1.07 ±  8%  mpstat.cpu.all.irq%
      0.14 ±  4%      -0.0        0.12 ±  2%  mpstat.cpu.all.soft%
     24.98 ±  2%      +4.0       28.96        mpstat.cpu.all.sys%
      1.81            -0.3        1.56 ±  2%  mpstat.cpu.all.usr%
      7705 ± 44%    +133.9%      18021 ± 30%  numa-vmstat.node0.nr_written
      3171 ± 16%     +59.4%       5056 ±  7%  numa-vmstat.node1.nr_active_anon
      5580 ± 17%     +33.9%       7471 ± 11%  numa-vmstat.node1.nr_shmem
      3171 ± 16%     +59.4%       5056 ±  7%  numa-vmstat.node1.nr_zone_active_anon
    784.00           +13.1%     886.83        turbostat.Avg_MHz
     28.74 ±  2%      +3.5       32.19        turbostat.Busy%
   6829051 ±  4%     +19.6%    8165424 ±  4%  turbostat.IRQ
     61.30            -2.0%      60.07        turbostat.RAMWatt
      1883           +18.9%       2238 ±  2%  slabinfo.kmalloc-4k.active_objs
      1897           +19.2%       2261 ±  2%  slabinfo.kmalloc-4k.num_objs
     23909           +12.7%      26935        slabinfo.kmalloc-512.num_objs
    960.50           +10.6%       1062        slabinfo.kmalloc-8k.num_objs
      2865 ±  8%     +47.4%       4224 ±  8%  slabinfo.xfs_ili.active_objs
      2865 ±  8%     +51.1%       4329 ± 11%  slabinfo.xfs_ili.num_objs
      2715 ±  8%     +44.7%       3928 ±  8%  slabinfo.xfs_inode.active_objs
      2894 ± 10%     +36.7%       3957 ±  8%  slabinfo.xfs_inode.num_objs
      3733 ±  6%     +43.8%       5367 ±  6%  proc-vmstat.nr_active_anon
    276678            -4.6%     263917        proc-vmstat.nr_dirty
    881833            -1.3%     870430        proc-vmstat.nr_file_pages
    277293            -4.7%     264132        proc-vmstat.nr_inactive_file
     59615            +1.9%      60718        proc-vmstat.nr_kernel_stack
      6944 ±  5%     +23.3%       8559 ±  5%  proc-vmstat.nr_shmem
     34298            +3.9%      35650        proc-vmstat.nr_slab_reclaimable
     74442            +2.7%      76415        proc-vmstat.nr_slab_unreclaimable
     26496 ± 47%    +300.1%     106015 ± 73%  proc-vmstat.nr_written
      3733 ±  6%     +43.8%       5367 ±  6%  proc-vmstat.nr_zone_active_anon
    277294            -4.7%     264131        proc-vmstat.nr_zone_inactive_file
    277453            -4.3%     265582        proc-vmstat.nr_zone_write_pending
    131091 ± 37%    +358.9%     601618 ± 51%  proc-vmstat.pgpgout
     13879           +12.0%      15551 ±  3%  proc-vmstat.pgreuse
 1.314e+10            -6.7%  1.226e+10        perf-stat.i.branch-instructions
  85812845 ±  2%     -16.0%   72078274        perf-stat.i.branch-misses
     24.04 ±  4%      +3.0       27.05 ±  6%  perf-stat.i.cache-miss-rate%
  48258145 ±  4%     -15.1%   40958577 ±  4%  perf-stat.i.cache-misses
 1.645e+08 ±  7%     -20.5%  1.308e+08 ±  6%  perf-stat.i.cache-references
     53786           -17.5%      44386        perf-stat.i.context-switches
 6.825e+10           +13.6%  7.754e+10        perf-stat.i.cpu-cycles
      2280 ±  3%     -12.4%       1999        perf-stat.i.cpu-migrations
   2024830 ±  7%     -16.9%    1682215 ±  9%  perf-stat.i.dTLB-load-misses
 1.992e+10            -7.6%  1.841e+10        perf-stat.i.dTLB-loads
    171136 ± 10%     -14.5%     146368 ±  9%  perf-stat.i.dTLB-store-misses
 1.117e+10           -14.7%  9.524e+09        perf-stat.i.dTLB-stores
  60910292 ±  4%     -16.5%   50875863 ±  2%  perf-stat.i.iTLB-load-misses
   5475198 ±  5%     -22.3%    4254172 ±  2%  perf-stat.i.iTLB-loads
 6.801e+10            -6.8%  6.336e+10        perf-stat.i.instructions
      0.84 ±  2%     -11.6%       0.75 ±  2%  perf-stat.i.ipc
      0.78           +13.5%       0.88        perf-stat.i.metric.GHz
    504.67            -9.2%     458.17        perf-stat.i.metric.M/sec
      8446           -10.6%       7554 ±  2%  perf-stat.i.minor-faults
   7536680 ±  6%     -15.6%    6360487 ±  5%  perf-stat.i.node-load-misses
   4811784 ±  2%     -15.5%    4067718        perf-stat.i.node-loads
   2729017           -10.8%    2432952 ±  3%  perf-stat.i.node-store-misses
  10498281           -16.2%    8794310        perf-stat.i.node-stores
      8500           -10.7%       7592 ±  2%  perf-stat.i.page-faults
      2.42 ±  7%     -14.7%       2.06 ±  5%  perf-stat.overall.MPKI
      0.65 ±  2%      -0.1        0.59        perf-stat.overall.branch-miss-rate%
      1.00           +21.9%       1.22        perf-stat.overall.cpi
      1415 ±  3%     +33.9%       1895 ±  3%  perf-stat.overall.cycles-between-cache-misses
      1118 ±  4%     +11.4%       1245 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      1.00           -18.0%       0.82        perf-stat.overall.ipc
 1.284e+10            -6.4%  1.202e+10        perf-stat.ps.branch-instructions
  83709853 ±  2%     -15.7%   70561580        perf-stat.ps.branch-misses
  47165844 ±  4%     -14.9%   40155367 ±  4%  perf-stat.ps.cache-misses
 1.607e+08 ±  7%     -20.2%  1.281e+08 ±  6%  perf-stat.ps.cache-references
     52559           -17.2%      43519        perf-stat.ps.context-switches
 6.669e+10           +14.0%    7.6e+10        perf-stat.ps.cpu-cycles
      2229 ±  3%     -12.1%       1958        perf-stat.ps.cpu-migrations
   1971432 ±  7%     -16.4%    1647518 ±  9%  perf-stat.ps.dTLB-load-misses
 1.947e+10            -7.3%  1.805e+10        perf-stat.ps.dTLB-loads
 1.091e+10           -14.4%  9.339e+09        perf-stat.ps.dTLB-stores
  59537767 ±  4%     -16.2%   49887667 ±  2%  perf-stat.ps.iTLB-load-misses
   5345874 ±  5%     -22.1%    4165474 ±  2%  perf-stat.ps.iTLB-loads
 6.646e+10            -6.5%  6.212e+10        perf-stat.ps.instructions
      8139           -10.2%       7309 ±  2%  perf-stat.ps.minor-faults
   7366380 ±  6%     -15.3%    6236141 ±  5%  perf-stat.ps.node-load-misses
   4701843 ±  2%     -15.2%    3988573        perf-stat.ps.node-loads
   2667116           -10.6%    2385642 ±  3%  perf-stat.ps.node-store-misses
  10262751           -16.0%    8623511        perf-stat.ps.node-stores
      8190           -10.3%       7345 ±  2%  perf-stat.ps.page-faults
 2.376e+12           +10.3%  2.621e+12        perf-stat.total.instructions
     60749            +4.5%      63477 ±  2%  interrupts.CAL:Function_call_interrupts
     70556 ±  3%     +20.3%      84852 ±  3%  interrupts.CPU0.LOC:Local_timer_interrupts
     54.00 ±  7%    +243.5%     185.50 ± 19%  interrupts.CPU0.RES:Rescheduling_interrupts
     70647 ±  3%     +20.0%      84782 ±  3%  interrupts.CPU1.LOC:Local_timer_interrupts
     53.00 ±  9%    +333.3%     229.67 ± 16%  interrupts.CPU1.RES:Rescheduling_interrupts
     70615 ±  3%     +20.2%      84854 ±  3%  interrupts.CPU10.LOC:Local_timer_interrupts
     56.00 ± 16%    +254.5%     198.50 ± 24%  interrupts.CPU10.RES:Rescheduling_interrupts
     70591 ±  3%     +20.1%      84761 ±  2%  interrupts.CPU11.LOC:Local_timer_interrupts
     51.67 ±  6%    +273.5%     193.00 ± 22%  interrupts.CPU11.RES:Rescheduling_interrupts
     70551 ±  3%     +20.3%      84846 ±  3%  interrupts.CPU12.LOC:Local_timer_interrupts
     54.33 ± 14%    +269.3%     200.67 ± 14%  interrupts.CPU12.RES:Rescheduling_interrupts
     70539 ±  3%     +20.3%      84828 ±  3%  interrupts.CPU13.LOC:Local_timer_interrupts
     48.17 ± 12%    +320.1%     202.33 ± 39%  interrupts.CPU13.RES:Rescheduling_interrupts
     70582 ±  3%     +20.1%      84770 ±  3%  interrupts.CPU14.LOC:Local_timer_interrupts
     51.00 ± 15%    +405.2%     257.67 ± 29%  interrupts.CPU14.RES:Rescheduling_interrupts
     70534 ±  3%     +20.2%      84768 ±  3%  interrupts.CPU15.LOC:Local_timer_interrupts
     56.33 ±  9%    +261.2%     203.50 ± 23%  interrupts.CPU15.RES:Rescheduling_interrupts
     70541 ±  3%     +20.2%      84776 ±  3%  interrupts.CPU16.LOC:Local_timer_interrupts
     51.67 ± 16%    +281.3%     197.00 ± 21%  interrupts.CPU16.RES:Rescheduling_interrupts
     70553 ±  3%     +20.3%      84864 ±  3%  interrupts.CPU17.LOC:Local_timer_interrupts
     52.00 ± 15%    +273.4%     194.17 ± 12%  interrupts.CPU17.RES:Rescheduling_interrupts
     70596 ±  3%     +20.1%      84809 ±  3%  interrupts.CPU18.LOC:Local_timer_interrupts
     50.33 ± 13%    +304.6%     203.67 ± 25%  interrupts.CPU18.RES:Rescheduling_interrupts
     70593 ±  3%     +20.2%      84866 ±  3%  interrupts.CPU19.LOC:Local_timer_interrupts
     50.33 ± 14%    +323.8%     213.33 ± 19%  interrupts.CPU19.RES:Rescheduling_interrupts
     70567 ±  3%     +20.2%      84835 ±  3%  interrupts.CPU2.LOC:Local_timer_interrupts
     52.67 ± 16%    +258.5%     188.83 ± 10%  interrupts.CPU2.RES:Rescheduling_interrupts
     70579 ±  3%     +20.2%      84830 ±  3%  interrupts.CPU20.LOC:Local_timer_interrupts
     49.67 ± 12%    +303.7%     200.50 ± 16%  interrupts.CPU20.RES:Rescheduling_interrupts
     70546 ±  3%     +20.2%      84826 ±  3%  interrupts.CPU21.LOC:Local_timer_interrupts
     52.83 ± 12%    +305.4%     214.17 ± 21%  interrupts.CPU21.RES:Rescheduling_interrupts
     69912 ±  5%     +20.4%      84168 ±  4%  interrupts.CPU22.LOC:Local_timer_interrupts
     52.17 ± 12%    +348.2%     233.83 ± 10%  interrupts.CPU22.RES:Rescheduling_interrupts
     69941 ±  5%     +20.4%      84188 ±  4%  interrupts.CPU23.LOC:Local_timer_interrupts
     48.33 ± 12%    +347.6%     216.33 ± 13%  interrupts.CPU23.RES:Rescheduling_interrupts
     69894 ±  5%     +20.4%      84160 ±  4%  interrupts.CPU24.LOC:Local_timer_interrupts
     43.00 ± 10%    +334.9%     187.00 ±  9%  interrupts.CPU24.RES:Rescheduling_interrupts
     69938 ±  5%     +20.3%      84141 ±  4%  interrupts.CPU25.LOC:Local_timer_interrupts
     47.33 ±  9%    +327.5%     202.33 ± 24%  interrupts.CPU25.RES:Rescheduling_interrupts
     69816 ±  5%     +21.1%      84544 ±  5%  interrupts.CPU26.LOC:Local_timer_interrupts
     44.50 ± 15%    +331.5%     192.00 ± 21%  interrupts.CPU26.RES:Rescheduling_interrupts
     69807 ±  5%     +20.7%      84244 ±  5%  interrupts.CPU27.LOC:Local_timer_interrupts
     51.17 ± 18%    +222.8%     165.17 ± 19%  interrupts.CPU27.RES:Rescheduling_interrupts
     69911 ±  5%     +20.4%      84170 ±  4%  interrupts.CPU28.LOC:Local_timer_interrupts
     41.83 ±  7%    +407.2%     212.17 ± 15%  interrupts.CPU28.RES:Rescheduling_interrupts
     69953 ±  5%     +20.3%      84130 ±  4%  interrupts.CPU29.LOC:Local_timer_interrupts
     44.67 ± 11%    +334.7%     194.17 ± 20%  interrupts.CPU29.RES:Rescheduling_interrupts
     70566 ±  3%     +20.2%      84829 ±  3%  interrupts.CPU3.LOC:Local_timer_interrupts
     47.67 ± 18%    +322.0%     201.17 ± 26%  interrupts.CPU3.RES:Rescheduling_interrupts
     69927 ±  5%     +20.3%      84142 ±  4%  interrupts.CPU30.LOC:Local_timer_interrupts
     49.17 ± 16%    +269.2%     181.50 ± 19%  interrupts.CPU30.RES:Rescheduling_interrupts
     69899 ±  5%     +20.4%      84169 ±  4%  interrupts.CPU31.LOC:Local_timer_interrupts
     54.17 ± 25%    +280.6%     206.17 ± 14%  interrupts.CPU31.RES:Rescheduling_interrupts
    623.67 ± 11%     +14.7%     715.17 ±  3%  interrupts.CPU32.CAL:Function_call_interrupts
     70068 ±  5%     +20.3%      84267 ±  5%  interrupts.CPU32.LOC:Local_timer_interrupts
     52.33 ± 20%    +271.3%     194.33 ± 25%  interrupts.CPU32.RES:Rescheduling_interrupts
     69883 ±  5%     +20.4%      84169 ±  4%  interrupts.CPU33.LOC:Local_timer_interrupts
     49.83 ± 18%    +309.0%     203.83 ± 17%  interrupts.CPU33.RES:Rescheduling_interrupts
     69924 ±  5%     +20.4%      84163 ±  4%  interrupts.CPU34.LOC:Local_timer_interrupts
     51.67 ± 13%    +261.6%     186.83 ± 20%  interrupts.CPU34.RES:Rescheduling_interrupts
     69870 ±  5%     +20.4%      84141 ±  4%  interrupts.CPU35.LOC:Local_timer_interrupts
     53.00 ± 16%    +283.0%     203.00 ± 26%  interrupts.CPU35.RES:Rescheduling_interrupts
     69882 ±  5%     +20.4%      84147 ±  4%  interrupts.CPU36.LOC:Local_timer_interrupts
     51.83 ± 13%    +298.1%     206.33 ± 25%  interrupts.CPU36.RES:Rescheduling_interrupts
     69829 ±  5%     +20.6%      84196 ±  4%  interrupts.CPU37.LOC:Local_timer_interrupts
     55.17 ± 18%    +285.8%     212.83 ± 27%  interrupts.CPU37.RES:Rescheduling_interrupts
     69923 ±  5%     +20.3%      84126 ±  4%  interrupts.CPU38.LOC:Local_timer_interrupts
     45.67 ± 12%    +359.9%     210.00 ± 33%  interrupts.CPU38.RES:Rescheduling_interrupts
     69900 ±  5%     +20.4%      84140 ±  4%  interrupts.CPU39.LOC:Local_timer_interrupts
     49.33 ± 13%    +294.6%     194.67 ± 18%  interrupts.CPU39.RES:Rescheduling_interrupts
     70574 ±  3%     +20.0%      84724 ±  3%  interrupts.CPU4.LOC:Local_timer_interrupts
     55.67 ± 16%    +269.2%     205.50 ± 18%  interrupts.CPU4.RES:Rescheduling_interrupts
     69891 ±  5%     +20.5%      84204 ±  4%  interrupts.CPU40.LOC:Local_timer_interrupts
     53.83 ±  7%    +270.0%     199.17 ± 13%  interrupts.CPU40.RES:Rescheduling_interrupts
    637.67 ±  4%     +11.3%     709.67 ±  3%  interrupts.CPU41.CAL:Function_call_interrupts
     69871 ±  5%     +20.5%      84170 ±  4%  interrupts.CPU41.LOC:Local_timer_interrupts
     50.50 ±  6%    +323.8%     214.00 ± 14%  interrupts.CPU41.RES:Rescheduling_interrupts
     69889 ±  5%     +20.3%      84096 ±  4%  interrupts.CPU42.LOC:Local_timer_interrupts
     46.67 ± 11%    +327.9%     199.67 ± 13%  interrupts.CPU42.RES:Rescheduling_interrupts
     69921 ±  5%     +20.4%      84168 ±  4%  interrupts.CPU43.LOC:Local_timer_interrupts
     54.33 ± 38%    +272.4%     202.33 ± 28%  interrupts.CPU43.RES:Rescheduling_interrupts
     70554 ±  3%     +20.2%      84786 ±  3%  interrupts.CPU44.LOC:Local_timer_interrupts
     32.83 ± 16%    +433.5%     175.17 ± 30%  interrupts.CPU44.RES:Rescheduling_interrupts
     70543 ±  3%     +20.1%      84695 ±  3%  interrupts.CPU45.LOC:Local_timer_interrupts
     30.83 ± 17%    +581.6%     210.17 ± 31%  interrupts.CPU45.RES:Rescheduling_interrupts
     70555 ±  3%     +20.2%      84790 ±  3%  interrupts.CPU46.LOC:Local_timer_interrupts
     38.00 ± 15%    +489.0%     223.83 ± 22%  interrupts.CPU46.RES:Rescheduling_interrupts
     70613 ±  3%     +20.1%      84798 ±  3%  interrupts.CPU47.LOC:Local_timer_interrupts
     31.83 ± 11%    +553.9%     208.17 ±  8%  interrupts.CPU47.RES:Rescheduling_interrupts
     70561 ±  3%     +20.1%      84759 ±  2%  interrupts.CPU48.LOC:Local_timer_interrupts
     31.50 ± 17%    +511.6%     192.67 ± 25%  interrupts.CPU48.RES:Rescheduling_interrupts
     70546 ±  3%     +20.2%      84805 ±  3%  interrupts.CPU49.LOC:Local_timer_interrupts
     32.50 ± 19%    +452.3%     179.50 ± 20%  interrupts.CPU49.RES:Rescheduling_interrupts
     70564 ±  3%     +20.2%      84809 ±  3%  interrupts.CPU5.LOC:Local_timer_interrupts
     50.83 ± 13%    +310.5%     208.67 ± 14%  interrupts.CPU5.RES:Rescheduling_interrupts
     70611 ±  3%     +20.4%      85001 ±  3%  interrupts.CPU50.LOC:Local_timer_interrupts
     33.50 ± 14%    +563.7%     222.33 ± 25%  interrupts.CPU50.RES:Rescheduling_interrupts
     70575 ±  3%     +20.2%      84817 ±  3%  interrupts.CPU51.LOC:Local_timer_interrupts
     32.50 ± 26%    +557.4%     213.67 ± 33%  interrupts.CPU51.RES:Rescheduling_interrupts
     70637 ±  3%     +20.0%      84787 ±  3%  interrupts.CPU52.LOC:Local_timer_interrupts
     33.17 ± 15%    +482.9%     193.33 ± 20%  interrupts.CPU52.RES:Rescheduling_interrupts
     70472 ±  3%     +20.4%      84838 ±  3%  interrupts.CPU53.LOC:Local_timer_interrupts
     35.00 ± 13%    +462.4%     196.83 ± 20%  interrupts.CPU53.RES:Rescheduling_interrupts
     70613 ±  3%     +20.2%      84851 ±  3%  interrupts.CPU54.LOC:Local_timer_interrupts
     33.17 ±  9%    +477.4%     191.50 ± 12%  interrupts.CPU54.RES:Rescheduling_interrupts
     70695 ±  3%     +20.0%      84833 ±  3%  interrupts.CPU55.LOC:Local_timer_interrupts
     32.00 ± 23%    +524.5%     199.83 ± 14%  interrupts.CPU55.RES:Rescheduling_interrupts
     70581 ±  3%     +20.2%      84816 ±  3%  interrupts.CPU56.LOC:Local_timer_interrupts
     33.67 ± 26%    +513.9%     206.67 ± 11%  interrupts.CPU56.RES:Rescheduling_interrupts
     70508 ±  3%     +20.1%      84697 ±  3%  interrupts.CPU57.LOC:Local_timer_interrupts
     42.33 ± 32%    +405.9%     214.17 ± 15%  interrupts.CPU57.RES:Rescheduling_interrupts
     70595 ±  3%     +20.2%      84851 ±  3%  interrupts.CPU58.LOC:Local_timer_interrupts
     34.50 ± 25%    +486.5%     202.33 ± 25%  interrupts.CPU58.RES:Rescheduling_interrupts
     70558 ±  3%     +20.2%      84816 ±  3%  interrupts.CPU59.LOC:Local_timer_interrupts
     32.67 ± 34%    +512.2%     200.00 ± 16%  interrupts.CPU59.RES:Rescheduling_interrupts
     70826 ±  4%     +19.8%      84827 ±  3%  interrupts.CPU6.LOC:Local_timer_interrupts
     50.17 ±  9%    +337.5%     219.50 ± 12%  interrupts.CPU6.RES:Rescheduling_interrupts
     70602 ±  3%     +20.1%      84822 ±  3%  interrupts.CPU60.LOC:Local_timer_interrupts
     29.00 ± 16%    +633.3%     212.67 ± 17%  interrupts.CPU60.RES:Rescheduling_interrupts
     70598 ±  3%     +20.2%      84851 ±  3%  interrupts.CPU61.LOC:Local_timer_interrupts
     34.67 ± 16%    +536.1%     220.50 ± 32%  interrupts.CPU61.RES:Rescheduling_interrupts
     70770 ±  3%     +19.9%      84821 ±  3%  interrupts.CPU62.LOC:Local_timer_interrupts
     43.50 ± 29%    +382.0%     209.67 ± 20%  interrupts.CPU62.RES:Rescheduling_interrupts
     70632 ±  3%     +20.1%      84823 ±  3%  interrupts.CPU63.LOC:Local_timer_interrupts
     42.33 ± 43%    +402.0%     212.50 ± 33%  interrupts.CPU63.RES:Rescheduling_interrupts
     70573 ±  3%     +20.1%      84744 ±  3%  interrupts.CPU64.LOC:Local_timer_interrupts
     37.17 ± 25%    +452.9%     205.50 ± 16%  interrupts.CPU64.RES:Rescheduling_interrupts
     70498 ±  3%     +20.3%      84822 ±  3%  interrupts.CPU65.LOC:Local_timer_interrupts
     44.33 ± 29%    +434.6%     237.00 ± 24%  interrupts.CPU65.RES:Rescheduling_interrupts
     69900 ±  5%     +20.4%      84131 ±  4%  interrupts.CPU66.LOC:Local_timer_interrupts
      2842 ± 33%     +41.1%       4010 ±  4%  interrupts.CPU66.NMI:Non-maskable_interrupts
      2842 ± 33%     +41.1%       4010 ±  4%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
     27.83 ±  8%    +566.5%     185.50 ± 15%  interrupts.CPU66.RES:Rescheduling_interrupts
     69899 ±  5%     +20.4%      84193 ±  4%  interrupts.CPU67.LOC:Local_timer_interrupts
      2542 ± 31%     +54.1%       3918 ±  4%  interrupts.CPU67.NMI:Non-maskable_interrupts
      2542 ± 31%     +54.1%       3918 ±  4%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
     26.67 ± 19%    +676.9%     207.17 ± 21%  interrupts.CPU67.RES:Rescheduling_interrupts
     69923 ±  5%     +20.4%      84183 ±  4%  interrupts.CPU68.LOC:Local_timer_interrupts
      2502 ± 32%     +59.5%       3990 ±  3%  interrupts.CPU68.NMI:Non-maskable_interrupts
      2502 ± 32%     +59.5%       3990 ±  3%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
     38.33 ± 35%    +436.1%     205.50 ± 22%  interrupts.CPU68.RES:Rescheduling_interrupts
     69857 ±  5%     +20.6%      84243 ±  4%  interrupts.CPU69.LOC:Local_timer_interrupts
     32.67 ± 25%    +504.1%     197.33 ± 25%  interrupts.CPU69.RES:Rescheduling_interrupts
     70576 ±  3%     +20.2%      84824 ±  3%  interrupts.CPU7.LOC:Local_timer_interrupts
      2624 ± 33%     +55.2%       4071 ±  2%  interrupts.CPU7.NMI:Non-maskable_interrupts
      2624 ± 33%     +55.2%       4071 ±  2%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
     49.00 ±  7%    +321.8%     206.67 ± 13%  interrupts.CPU7.RES:Rescheduling_interrupts
     69944 ±  5%     +20.3%      84176 ±  4%  interrupts.CPU70.LOC:Local_timer_interrupts
      2832 ± 30%     +39.8%       3959 ±  4%  interrupts.CPU70.NMI:Non-maskable_interrupts
      2832 ± 30%     +39.8%       3959 ±  4%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
     31.17 ± 28%    +468.4%     177.17 ± 17%  interrupts.CPU70.RES:Rescheduling_interrupts
     69914 ±  5%     +20.4%      84156 ±  4%  interrupts.CPU71.LOC:Local_timer_interrupts
     34.67 ± 50%    +477.9%     200.33 ± 13%  interrupts.CPU71.RES:Rescheduling_interrupts
     69927 ±  5%     +20.4%      84187 ±  4%  interrupts.CPU72.LOC:Local_timer_interrupts
      2584 ± 33%     +53.7%       3973 ±  3%  interrupts.CPU72.NMI:Non-maskable_interrupts
      2584 ± 33%     +53.7%       3973 ±  3%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
     30.17 ± 15%    +682.9%     236.17 ± 25%  interrupts.CPU72.RES:Rescheduling_interrupts
     69925 ±  5%     +20.4%      84157 ±  4%  interrupts.CPU73.LOC:Local_timer_interrupts
     33.83 ± 17%    +500.5%     203.17 ± 13%  interrupts.CPU73.RES:Rescheduling_interrupts
    648.83           +14.1%     740.17 ±  4%  interrupts.CPU74.CAL:Function_call_interrupts
     69896 ±  5%     +20.4%      84181 ±  4%  interrupts.CPU74.LOC:Local_timer_interrupts
      2830 ± 32%     +40.1%       3964 ±  3%  interrupts.CPU74.NMI:Non-maskable_interrupts
      2830 ± 32%     +40.1%       3964 ±  3%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
     29.83 ± 36%    +670.4%     229.83 ± 14%  interrupts.CPU74.RES:Rescheduling_interrupts
     69937 ±  5%     +20.4%      84218 ±  4%  interrupts.CPU75.LOC:Local_timer_interrupts
     30.33 ± 31%    +500.0%     182.00 ± 17%  interrupts.CPU75.RES:Rescheduling_interrupts
     69935 ±  5%     +20.3%      84160 ±  4%  interrupts.CPU76.LOC:Local_timer_interrupts
     35.67 ± 41%    +462.6%     200.67 ± 20%  interrupts.CPU76.RES:Rescheduling_interrupts
     69927 ±  5%     +20.3%      84148 ±  4%  interrupts.CPU77.LOC:Local_timer_interrupts
     34.67 ± 22%    +461.1%     194.50 ± 17%  interrupts.CPU77.RES:Rescheduling_interrupts
     69882 ±  5%     +20.4%      84164 ±  4%  interrupts.CPU78.LOC:Local_timer_interrupts
      3118 ± 25%     +27.0%       3960 ±  4%  interrupts.CPU78.NMI:Non-maskable_interrupts
      3118 ± 25%     +27.0%       3960 ±  4%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
     35.00 ± 32%    +411.0%     178.83 ± 12%  interrupts.CPU78.RES:Rescheduling_interrupts
     69905 ±  5%     +20.4%      84196 ±  4%  interrupts.CPU79.LOC:Local_timer_interrupts
     32.83 ± 41%    +458.4%     183.33 ± 15%  interrupts.CPU79.RES:Rescheduling_interrupts
     70520 ±  3%     +20.4%      84929 ±  2%  interrupts.CPU8.LOC:Local_timer_interrupts
      2654 ± 37%     +52.3%       4043 ±  3%  interrupts.CPU8.NMI:Non-maskable_interrupts
      2654 ± 37%     +52.3%       4043 ±  3%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
     53.17 ± 38%    +280.3%     202.17 ± 24%  interrupts.CPU8.RES:Rescheduling_interrupts
     69925 ±  5%     +20.4%      84198 ±  4%  interrupts.CPU80.LOC:Local_timer_interrupts
     32.50 ± 34%    +482.6%     189.33 ± 40%  interrupts.CPU80.RES:Rescheduling_interrupts
     69883 ±  5%     +20.4%      84150 ±  4%  interrupts.CPU81.LOC:Local_timer_interrupts
     33.00 ± 53%    +514.6%     202.83 ± 30%  interrupts.CPU81.RES:Rescheduling_interrupts
     69897 ±  5%     +20.4%      84167 ±  4%  interrupts.CPU82.LOC:Local_timer_interrupts
     38.83 ± 47%    +367.0%     181.33 ± 21%  interrupts.CPU82.RES:Rescheduling_interrupts
     69898 ±  5%     +20.4%      84156 ±  4%  interrupts.CPU83.LOC:Local_timer_interrupts
     34.50 ± 35%    +498.6%     206.50 ± 19%  interrupts.CPU83.RES:Rescheduling_interrupts
     69876 ±  5%     +20.4%      84161 ±  4%  interrupts.CPU84.LOC:Local_timer_interrupts
     40.17 ± 36%    +410.0%     204.83 ± 24%  interrupts.CPU84.RES:Rescheduling_interrupts
     70003 ±  5%     +20.2%      84169 ±  4%  interrupts.CPU85.LOC:Local_timer_interrupts
     39.17 ± 29%    +434.5%     209.33 ± 25%  interrupts.CPU85.RES:Rescheduling_interrupts
     69910 ±  5%     +20.4%      84146 ±  4%  interrupts.CPU86.LOC:Local_timer_interrupts
     36.67 ± 28%    +379.1%     175.67 ± 22%  interrupts.CPU86.RES:Rescheduling_interrupts
    626.50            +9.6%     686.83 ±  3%  interrupts.CPU87.CAL:Function_call_interrupts
     69927 ±  5%     +20.4%      84171 ±  4%  interrupts.CPU87.LOC:Local_timer_interrupts
     51.67 ± 17%    +297.7%     205.50 ± 22%  interrupts.CPU87.RES:Rescheduling_interrupts
     70561 ±  3%     +20.3%      84869 ±  3%  interrupts.CPU9.LOC:Local_timer_interrupts
     48.67 ±  9%    +318.8%     203.83 ± 12%  interrupts.CPU9.RES:Rescheduling_interrupts
   6181647 ±  4%     +20.3%    7435792 ±  4%  interrupts.LOC:Local_timer_interrupts
      3760 ±  3%    +374.2%      17832 ±  5%  interrupts.RES:Rescheduling_interrupts
     59.75 ±  3%     -14.2       45.52 ±  3%  perf-profile.calltrace.cycles-pp.write
     55.84 ±  4%     -13.3       42.54 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     55.32 ±  4%     -13.2       42.12 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     54.18 ±  4%     -12.9       41.26 ±  3%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     52.82 ±  4%     -12.6       40.26 ±  3%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     49.22 ±  4%     -11.7       37.48 ±  3%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     47.80 ±  4%     -11.4       36.38 ±  3%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
     41.20 ±  4%     -10.2       31.05 ±  3%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
     40.91 ±  4%     -10.1       30.80 ±  3%  perf-profile.calltrace.cycles-pp.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write.vfs_write
     32.78 ±  4%      -8.2       24.56 ±  3%  perf-profile.calltrace.cycles-pp.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
     25.77 ± 11%      -5.4       20.40 ± 12%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     26.84 ± 10%      -5.3       21.57 ± 11%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     26.51 ± 10%      -5.2       21.31 ± 11%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     26.51 ± 10%      -5.2       21.31 ± 11%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     26.51 ± 10%      -5.2       21.31 ± 11%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     26.25 ± 10%      -5.2       21.07 ± 11%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     26.28 ± 10%      -5.2       21.10 ± 11%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     14.91 ±  4%      -3.6       11.28 ±  3%  perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
     10.38 ±  4%      -2.9        7.46 ±  3%  perf-profile.calltrace.cycles-pp.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
     10.16 ±  6%      -2.7        7.48 ±  2%  perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      9.86 ±  6%      -2.6        7.24 ±  2%  perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply
      5.52 ±  7%      -2.0        3.52 ±  2%  perf-profile.calltrace.cycles-pp.__close
      5.50 ±  7%      -2.0        3.51 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      5.50 ±  7%      -2.0        3.51 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      5.49 ±  7%      -2.0        3.50 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      5.49 ±  7%      -2.0        3.50 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      5.48 ±  7%      -2.0        3.50 ±  2%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.48 ±  7%      -2.0        3.49 ±  2%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      5.35 ±  7%      -2.0        3.40 ±  2%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      5.32 ±  7%      -2.0        3.37 ±  2%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_prepare
      5.91 ±  3%      -1.7        4.23 ±  3%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      4.75 ± 10%      -1.4        3.39 ±  3%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      5.27 ±  4%      -1.2        4.07 ±  4%  perf-profile.calltrace.cycles-pp.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
      4.55 ±  8%      -1.2        3.34 ±  2%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
      4.53 ±  8%      -1.2        3.33 ±  2%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.__dentry_kill.dput.__fput
      3.13 ±  8%      -0.9        2.19 ±  4%  perf-profile.calltrace.cycles-pp.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      3.25 ± 11%      -0.9        2.33 ±  3%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      3.29 ±  4%      -0.8        2.45 ±  4%  perf-profile.calltrace.cycles-pp.llseek
      3.92 ±  4%      -0.8        3.11 ±  4%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      2.14 ±  9%      -0.6        1.52 ±  4%  perf-profile.calltrace.cycles-pp.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill.dput
      2.09 ±  9%      -0.6        1.48 ±  3%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill
      3.05 ±  3%      -0.6        2.45 ±  4%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      2.49 ±  3%      -0.5        1.95 ±  4%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      2.79 ±  3%      -0.5        2.26 ±  4%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply
      1.65 ± 11%      -0.5        1.14 ±  4%  perf-profile.calltrace.cycles-pp.__set_page_dirty.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor.iomap_apply
      1.64 ± 16%      -0.5        1.14 ±  2%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      1.68 ±  5%      -0.4        1.24 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek
      1.45 ±  9%      -0.4        1.02 ±  4%  perf-profile.calltrace.cycles-pp.lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      1.35 ± 10%      -0.4        0.95 ±  4%  perf-profile.calltrace.cycles-pp.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      1.45 ±  5%      -0.4        1.07 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.82 ± 14%      -0.4        0.45 ± 45%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.__set_page_dirty.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor
      1.50 ±  3%      -0.4        1.14 ±  3%  perf-profile.calltrace.cycles-pp.__entry_text_start.write
      1.43 ±  3%      -0.4        1.08 ±  5%  perf-profile.calltrace.cycles-pp.xfs_ilock.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      1.33 ±  3%      -0.3        1.00 ±  2%  perf-profile.calltrace.cycles-pp.iov_iter_fault_in_readable.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      1.22 ±  4%      -0.3        0.91 ±  3%  perf-profile.calltrace.cycles-pp.xfs_ilock.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
      0.74 ±  4%      -0.3        0.44 ± 44%  perf-profile.calltrace.cycles-pp.xfs_iunlock.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
      1.21 ±  3%      -0.3        0.91 ±  5%  perf-profile.calltrace.cycles-pp.down_write.xfs_ilock.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write
      1.08 ±  9%      -0.3        0.80 ±  2%  perf-profile.calltrace.cycles-pp.truncate_cleanup_page.truncate_inode_pages_range.evict.__dentry_kill.dput
      0.93 ±  5%      -0.3        0.66 ±  5%  perf-profile.calltrace.cycles-pp.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      1.27 ±  3%      -0.3        1.00 ±  2%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.86 ± 12%      -0.3        0.60 ±  5%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      1.03 ±  5%      -0.3        0.76 ±  3%  perf-profile.calltrace.cycles-pp.down_write.xfs_ilock.xfs_file_buffered_write.new_sync_write.vfs_write
      1.01 ±  3%      -0.3        0.75 ±  2%  perf-profile.calltrace.cycles-pp.xas_load.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      0.96 ± 10%      -0.3        0.71        perf-profile.calltrace.cycles-pp.__cancel_dirty_page.truncate_cleanup_page.truncate_inode_pages_range.evict.__dentry_kill
      0.80 ±  3%      -0.3        0.55 ±  7%  perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      0.80 ± 12%      -0.2        0.57 ±  2%  perf-profile.calltrace.cycles-pp.account_page_cleaned.__cancel_dirty_page.truncate_cleanup_page.truncate_inode_pages_range.evict
      0.84 ±  5%      -0.2        0.62 ±  3%  perf-profile.calltrace.cycles-pp.xfs_buffered_write_iomap_end.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
      0.88 ±  4%      -0.2        0.65 ±  2%  perf-profile.calltrace.cycles-pp.__get_user_nocheck_1.iov_iter_fault_in_readable.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.94 ±  7%      -0.2        0.73 ±  3%  perf-profile.calltrace.cycles-pp.delete_from_page_cache_batch.truncate_inode_pages_range.evict.__dentry_kill.dput
      0.96 ±  4%      -0.2        0.76 ±  4%  perf-profile.calltrace.cycles-pp.common_file_perm.security_file_permission.vfs_write.ksys_write.do_syscall_64
      0.92 ±  3%      -0.2        0.71        perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.92 ±  4%      -0.2        0.72 ±  4%  perf-profile.calltrace.cycles-pp.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      0.74 ± 12%      -0.2        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      1.18 ±  3%      -0.2        0.98 ±  3%  perf-profile.calltrace.cycles-pp.memset_erms.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.82 ±  4%      -0.2        0.64 ±  4%  perf-profile.calltrace.cycles-pp.xfs_break_layouts.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write
      0.76 ±  3%      -0.2        0.57 ±  4%  perf-profile.calltrace.cycles-pp.__entry_text_start.llseek
      0.78 ±  4%      -0.2        0.60 ±  4%  perf-profile.calltrace.cycles-pp.xfs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.82 ±  3%      -0.2        0.64 ±  2%  perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.72 ±  4%      -0.2        0.56 ±  4%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      0.69 ±  4%      -0.2        0.54 ±  5%  perf-profile.calltrace.cycles-pp.disk_rw
      0.72 ±  3%      -0.2        0.57 ±  4%  perf-profile.calltrace.cycles-pp.xfs_iunlock.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      0.77 ±  2%      -0.1        0.71 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.63 ±  2%      +0.1        0.70        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.6        0.64 ±  4%  perf-profile.calltrace.cycles-pp.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread
      0.00            +0.7        0.70 ±  4%  perf-profile.calltrace.cycles-pp.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread.kthread
      0.00            +0.7        0.70 ±  4%  perf-profile.calltrace.cycles-pp.xfs_inodegc_worker.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.8        0.75 ±  4%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.8        0.75 ±  4%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.00            +0.8        0.78 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.00            +0.8        0.78 ±  3%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      2.02 ±  3%     +10.6       12.65 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      2.03 ±  3%     +10.6       12.66 ±  4%  perf-profile.calltrace.cycles-pp.unlink
      2.01 ±  3%     +10.6       12.64 ±  4%  perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      2.02 ±  3%     +10.6       12.66 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      1.43 ±  4%     +10.6       12.06 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.59 ±  8%     +10.7       11.26 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.82 ±  4%     +11.1       12.93 ±  3%  perf-profile.calltrace.cycles-pp.creat64
      1.80 ±  4%     +11.1       12.92 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      1.80 ±  4%     +11.1       12.92 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      1.80 ±  4%     +11.1       12.91 ±  3%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      1.80 ±  4%     +11.1       12.91 ±  3%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      1.78 ±  4%     +11.1       12.89 ±  3%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.77 ±  4%     +11.1       12.89 ±  3%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.81 ±  5%     +11.2       12.00 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00           +11.2       11.21 ±  3%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
     59.79 ±  3%     -14.2       45.56 ±  3%  perf-profile.children.cycles-pp.write
     54.23 ±  4%     -12.9       41.30 ±  3%  perf-profile.children.cycles-pp.ksys_write
     52.90 ±  4%     -12.6       40.32 ±  3%  perf-profile.children.cycles-pp.vfs_write
     49.25 ±  4%     -11.7       37.50 ±  3%  perf-profile.children.cycles-pp.new_sync_write
     47.86 ±  4%     -11.4       36.42 ±  3%  perf-profile.children.cycles-pp.xfs_file_buffered_write
     41.22 ±  4%     -10.2       31.06 ±  3%  perf-profile.children.cycles-pp.iomap_file_buffered_write
     40.96 ±  4%     -10.1       30.85 ±  3%  perf-profile.children.cycles-pp.iomap_apply
     32.89 ±  4%      -8.2       24.64 ±  3%  perf-profile.children.cycles-pp.iomap_write_actor
     26.09 ± 11%      -5.4       20.64 ± 12%  perf-profile.children.cycles-pp.intel_idle
     26.84 ± 10%      -5.3       21.57 ± 11%  perf-profile.children.cycles-pp.do_idle
     26.84 ± 10%      -5.3       21.57 ± 11%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     26.84 ± 10%      -5.3       21.57 ± 11%  perf-profile.children.cycles-pp.cpu_startup_entry
     26.60 ± 10%      -5.2       21.36 ± 11%  perf-profile.children.cycles-pp.cpuidle_enter_state
     26.60 ± 10%      -5.2       21.36 ± 11%  perf-profile.children.cycles-pp.cpuidle_enter
     26.51 ± 10%      -5.2       21.31 ± 11%  perf-profile.children.cycles-pp.start_secondary
     14.94 ±  4%      -3.6       11.30 ±  3%  perf-profile.children.cycles-pp.iomap_write_begin
     10.45 ±  4%      -2.9        7.51 ±  3%  perf-profile.children.cycles-pp.iomap_write_end
     10.20 ±  6%      -2.7        7.52 ±  3%  perf-profile.children.cycles-pp.grab_cache_page_write_begin
      9.97 ±  6%      -2.6        7.33 ±  2%  perf-profile.children.cycles-pp.pagecache_get_page
      8.40 ±  3%      -2.2        6.18 ±  3%  perf-profile.children.cycles-pp.iomap_set_range_uptodate
      6.45 ±  6%      -2.2        4.24 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      6.05 ±  7%      -2.1        3.94 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      5.52 ±  7%      -2.0        3.52 ±  2%  perf-profile.children.cycles-pp.__close
      5.48 ±  7%      -2.0        3.50 ±  2%  perf-profile.children.cycles-pp.task_work_run
      5.48 ±  7%      -2.0        3.49 ±  2%  perf-profile.children.cycles-pp.__fput
      5.37 ±  7%      -2.0        3.41 ±  2%  perf-profile.children.cycles-pp.dput
      5.32 ±  7%      -2.0        3.37 ±  2%  perf-profile.children.cycles-pp.__dentry_kill
      4.75 ± 10%      -1.4        3.40 ±  3%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      5.42 ±  3%      -1.2        4.18 ±  3%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      4.55 ±  8%      -1.2        3.34 ±  2%  perf-profile.children.cycles-pp.evict
      4.53 ±  8%      -1.2        3.33 ±  2%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      3.74 ±  4%      -1.0        2.78 ±  4%  perf-profile.children.cycles-pp.llseek
      3.18 ±  8%      -0.9        2.23 ±  4%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      3.26 ± 11%      -0.9        2.34 ±  3%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      2.66 ± 13%      -0.8        1.82 ±  5%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      3.93 ±  4%      -0.8        3.12 ±  4%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      2.04 ± 16%      -0.7        1.36 ±  5%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      2.73 ±  3%      -0.7        2.06 ±  4%  perf-profile.children.cycles-pp.xfs_ilock
      2.19 ±  8%      -0.6        1.55 ±  3%  perf-profile.children.cycles-pp.release_pages
      2.14 ±  9%      -0.6        1.52 ±  4%  perf-profile.children.cycles-pp.__pagevec_release
      3.07 ±  3%      -0.6        2.47 ±  4%  perf-profile.children.cycles-pp.copyin
      2.97 ±  3%      -0.6        2.39 ±  4%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      2.35 ±  3%      -0.6        1.77 ±  4%  perf-profile.children.cycles-pp.down_write
      1.52 ± 20%      -0.6        0.97 ±  6%  perf-profile.children.cycles-pp.__mod_memcg_state
      2.26 ±  3%      -0.5        1.72 ±  3%  perf-profile.children.cycles-pp.__entry_text_start
      1.66 ± 11%      -0.5        1.15 ±  5%  perf-profile.children.cycles-pp.__set_page_dirty
      1.64 ± 15%      -0.5        1.15 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_charge
      1.91 ±  4%      -0.5        1.45 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.45 ±  9%      -0.4        1.02 ±  4%  perf-profile.children.cycles-pp.lru_cache_add
      1.39 ± 10%      -0.4        0.98 ±  5%  perf-profile.children.cycles-pp.__pagevec_lru_add
      1.54 ±  4%      -0.4        1.15 ±  4%  perf-profile.children.cycles-pp.xfs_iunlock
      1.10 ± 14%      -0.4        0.74 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.36 ±  3%      -0.3        1.03 ±  3%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.91 ± 17%      -0.3        0.59 ±  9%  perf-profile.children.cycles-pp.lock_page_lruvec_irqsave
      1.18 ± 16%      -0.3        0.87 ± 20%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.32 ±  3%      -0.3        1.01 ±  2%  perf-profile.children.cycles-pp.__fdget_pos
      1.24 ±  3%      -0.3        0.94 ±  2%  perf-profile.children.cycles-pp.xas_load
      1.46 ±  3%      -0.3        1.16 ±  4%  perf-profile.children.cycles-pp.___might_sleep
      0.95 ±  5%      -0.3        0.67 ±  5%  perf-profile.children.cycles-pp.ksys_lseek
      1.08 ±  4%      -0.3        0.80 ±  4%  perf-profile.children.cycles-pp.up_write
      1.09 ±  9%      -0.3        0.81        perf-profile.children.cycles-pp.truncate_cleanup_page
      1.28 ±  4%      -0.3        1.01 ±  3%  perf-profile.children.cycles-pp.security_file_permission
      0.97 ± 10%      -0.3        0.71        perf-profile.children.cycles-pp.__cancel_dirty_page
      1.11 ±  3%      -0.3        0.86 ±  2%  perf-profile.children.cycles-pp.__fget_light
      1.00 ±  3%      -0.3        0.75 ±  2%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.80 ±  4%      -0.2        0.56 ±  7%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.90 ±  6%      -0.2        0.66 ±  3%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_end
      0.70 ± 17%      -0.2        0.46 ±  4%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.80 ± 12%      -0.2        0.58 ±  2%  perf-profile.children.cycles-pp.account_page_cleaned
      0.94 ±  6%      -0.2        0.73 ±  3%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      1.00 ±  4%      -0.2        0.78 ±  4%  perf-profile.children.cycles-pp.common_file_perm
      0.66 ± 12%      -0.2        0.45 ±  6%  perf-profile.children.cycles-pp.lock_page_memcg
      0.93 ±  4%      -0.2        0.72 ±  4%  perf-profile.children.cycles-pp.__alloc_pages
      1.20 ±  3%      -0.2        1.00 ±  3%  perf-profile.children.cycles-pp.memset_erms
      0.74 ± 12%      -0.2        0.54        perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.79 ±  3%      -0.2        0.60 ±  4%  perf-profile.children.cycles-pp.xfs_file_write_iter
      0.57 ±  9%      -0.2        0.39 ±  5%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.85 ±  4%      -0.2        0.67 ±  4%  perf-profile.children.cycles-pp.xfs_break_layouts
      0.78 ±  4%      -0.2        0.61 ±  5%  perf-profile.children.cycles-pp.__might_sleep
      0.70 ±  3%      -0.2        0.53 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.75 ±  4%      -0.2        0.58 ±  4%  perf-profile.children.cycles-pp.disk_rw
      0.74 ±  4%      -0.2        0.57 ±  4%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.49 ±  5%      -0.2        0.34 ±  4%  perf-profile.children.cycles-pp.xfs_bmbt_to_iomap
      0.41 ±  7%      -0.1        0.27 ±  6%  perf-profile.children.cycles-pp.uncharge_batch
      0.49 ±  3%      -0.1        0.37 ±  5%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.45 ± 11%      -0.1        0.34 ±  5%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.51 ±  4%      -0.1        0.39 ±  2%  perf-profile.children.cycles-pp.unlock_page
      0.50 ±  4%      -0.1        0.39 ±  3%  perf-profile.children.cycles-pp.xfs_break_leased_layouts
      0.62 ±  5%      -0.1        0.51 ±  2%  perf-profile.children.cycles-pp.xfs_iext_lookup_extent
      0.34 ±  9%      -0.1        0.23 ±  9%  perf-profile.children.cycles-pp.xfs_file_llseek
      0.52 ±  3%      -0.1        0.41 ±  5%  perf-profile.children.cycles-pp.current_time
      0.44 ±  4%      -0.1        0.33 ±  2%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.42 ±  3%      -0.1        0.31 ±  3%  perf-profile.children.cycles-pp.free_unref_page_list
      0.40 ±  6%      -0.1        0.30 ±  2%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.44 ±  4%      -0.1        0.34 ±  3%  perf-profile.children.cycles-pp.rmqueue
      0.35 ±  6%      -0.1        0.25 ±  9%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.58 ±  4%      -0.1        0.48 ±  5%  perf-profile.children.cycles-pp.xas_store
      0.40 ±  4%      -0.1        0.31 ±  4%  perf-profile.children.cycles-pp.xas_start
      0.38 ±  5%      -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.48 ±  4%      -0.1        0.40 ± 10%  perf-profile.children.cycles-pp.generic_write_checks
      0.33 ±  4%      -0.1        0.25 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.46 ±  7%      -0.1        0.38 ±  7%  perf-profile.children.cycles-pp.xfs_errortag_test
      0.29 ±  5%      -0.1        0.21 ±  8%  perf-profile.children.cycles-pp.page_counter_cancel
      0.32 ±  3%      -0.1        0.24 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.30 ±  4%      -0.1        0.23 ±  3%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.18 ± 31%      -0.1        0.11 ± 16%  perf-profile.children.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.37 ±  4%      -0.1        0.30 ±  4%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      0.09 ±  7%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.xfs_itruncate_extents_flags
      0.26 ±  6%      -0.1        0.19 ±  6%  perf-profile.children.cycles-pp.try_charge_memcg
      0.26 ±  9%      -0.1        0.20 ±  4%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.22 ±  6%      -0.1        0.16 ±  3%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.08 ± 11%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.aim_rand
      0.11 ±  9%      -0.1        0.05 ±  7%  perf-profile.children.cycles-pp.xfs_inactive_truncate
      0.27 ±  3%      -0.1        0.21 ±  5%  perf-profile.children.cycles-pp.file_modified
      0.24 ±  4%      -0.1        0.18 ±  3%  perf-profile.children.cycles-pp.aa_file_perm
      0.27 ±  4%      -0.1        0.22 ±  4%  perf-profile.children.cycles-pp.find_lock_entries
      0.18 ±  8%      -0.1        0.13 ±  3%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.22 ±  6%      -0.1        0.16 ±  8%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.24 ±  5%      -0.0        0.19 ±  4%  perf-profile.children.cycles-pp.xfs_buf_get_map
      0.25 ±  7%      -0.0        0.20 ±  7%  perf-profile.children.cycles-pp.xfs_iread_extents
      0.20 ±  4%      -0.0        0.15 ± 11%  perf-profile.children.cycles-pp.node_dirty_ok
      0.25 ±  5%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.xfs_buf_read_map
      0.14 ± 14%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.uncharge_page
      0.25 ±  8%      -0.0        0.20 ± 12%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.16 ± 10%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.__unlock_page_memcg
      0.22 ±  4%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.xfs_buf_find
      0.19 ±  7%      -0.0        0.15 ± 10%  perf-profile.children.cycles-pp.timestamp_truncate
      0.21 ±  4%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.xfs_da3_node_lookup_int
      0.16 ±  5%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.xfs_read_agi
      0.22 ±  4%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.xfs_dir_removename
      0.17 ±  5%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.14 ±  7%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.14 ±  8%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.21 ±  5%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.xfs_dir2_node_removename
      0.18 ±  2%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.file_remove_privs
      0.14 ± 12%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.__count_memcg_events
      0.08 ± 24%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.13 ±  5%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.xfs_dir_createname
      0.14 ±  3%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.rw_verify_area
      0.15 ± 12%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.12 ±  7%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
      0.24 ±  4%      -0.0        0.21 ±  5%  perf-profile.children.cycles-pp.xfs_difree_inobt
      0.16 ±  4%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.xfs_da_read_buf
      0.08 ± 14%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.13 ±  8%      -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.xfs_iunlink_remove
      0.13 ±  8%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.alloc_pages
      0.10 ±  8%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.08 ±  8%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.xfs_buf_unlock
      0.12 ±  4%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.xfs_dir2_node_addname
      0.14 ±  4%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.xfs_get_extsz_hint
      0.08 ±  4%      -0.0        0.05        perf-profile.children.cycles-pp.up
      0.12 ±  4%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.xfs_bmapi_reserve_delalloc
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.down
      0.12 ±  7%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.xfs_btree_lookup
      0.11 ±  8%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__free_one_page
      0.09 ±  6%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.xfs_buf_item_release
      0.08 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__down
      0.08 ±  5%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.xfs_buf_lock
      0.10 ±  8%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.__list_add_valid
      0.13 ±  7%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.xas_init_marks
      0.14 ±  7%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.page_mapping
      0.13 ±  6%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__xa_set_mark
      0.10 ±  4%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.xfs_release
      0.13 ±  5%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.wait_for_stable_page
      0.09 ±  5%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.xfs_isilocked
      0.10 ±  6%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp._xfs_trans_bjoin
      0.11 ±  6%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.write@plt
      0.09 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.xfs_vn_lookup
      0.10 ± 10%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.iov_iter_init
      0.08 ±  8%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.xfs_btree_lookup_get_block
      0.09 ±  8%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.xfs_free_eofblocks
      0.07 ±  8%      -0.0        0.05        perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.09 ± 10%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.rwsem_wake
      0.10 ±  5%      -0.0        0.08 ±  9%  perf-profile.children.cycles-pp.unlock_page_memcg
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.xfs_lookup
      0.08 ±  6%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.xas_find_conflict
      0.08 ± 10%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.PageHuge
      0.08 ±  6%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.schedule_timeout
      0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.xfs_dir2_node_addname_int
      0.10 ±  7%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.xfs_da3_node_read
      0.09 ±  7%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.xfs_dir2_leafn_lookup_for_entry
      0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.open64
      0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.xfs_dir_lookup
      0.07 ± 11%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.workingset_update_node
      0.08 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.07 ± 11%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.generic_file_llseek_size
      0.07 ± 11%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.wake_up_q
      0.06 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.xfs_dir2_node_lookup
      0.06 ±  7%      +0.0        0.08 ± 14%  perf-profile.children.cycles-pp.xfs_difree_finobt
      0.12 ±  9%      +0.0        0.16 ±  6%  perf-profile.children.cycles-pp.xfs_btree_get_rec
      0.18            +0.0        0.22 ±  9%  perf-profile.children.cycles-pp.__schedule
      0.04 ± 45%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.xfs_iunlink
      0.13 ±  8%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.xfs_btree_check_sblock
      0.24 ±  5%      +0.0        0.28 ±  9%  perf-profile.children.cycles-pp.xfs_inobt_get_rec
      0.13 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.schedule
      0.11 ±  4%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.xfs_btree_increment
      0.29 ±  3%      +0.1        0.35 ±  5%  perf-profile.children.cycles-pp.xfs_dialloc
      0.03 ± 70%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.44 ±  4%      +0.1        0.52 ±  6%  perf-profile.children.cycles-pp.xfs_check_agi_freecount
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.find_busiest_group
      0.00            +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.newidle_balance
      0.10 ±  7%      +0.1        0.21 ±  4%  perf-profile.children.cycles-pp.memcpy_erms
      0.01 ±223%      +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.load_balance
      0.13 ±  5%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.xfs_buf_item_format_segment
      0.14 ±  5%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.xfs_buf_item_format
      0.00            +0.7        0.70 ±  4%  perf-profile.children.cycles-pp.xfs_inodegc_worker
      0.00            +0.8        0.75 ±  4%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.8        0.75 ±  4%  perf-profile.children.cycles-pp.worker_thread
      0.00            +0.8        0.78 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
      0.00            +0.8        0.78 ±  3%  perf-profile.children.cycles-pp.kthread
     67.06 ±  4%      +6.0       73.03 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     66.32 ±  4%      +6.1       72.46 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
      2.04 ±  3%     +10.6       12.67 ±  4%  perf-profile.children.cycles-pp.unlink
      2.01 ±  3%     +10.6       12.64 ±  4%  perf-profile.children.cycles-pp.do_unlinkat
      1.87 ±  4%     +11.1       12.97 ±  3%  perf-profile.children.cycles-pp.do_sys_openat2
      1.87 ±  4%     +11.1       12.97 ±  3%  perf-profile.children.cycles-pp.do_sys_open
      1.82 ±  4%     +11.1       12.93 ±  3%  perf-profile.children.cycles-pp.creat64
      1.84 ±  4%     +11.1       12.94 ±  3%  perf-profile.children.cycles-pp.do_filp_open
      1.83 ±  4%     +11.1       12.94 ±  3%  perf-profile.children.cycles-pp.path_openat
      0.71 ± 11%     +21.8       22.48 ±  4%  perf-profile.children.cycles-pp.osq_lock
      2.24 ±  4%     +21.8       24.06 ±  4%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     26.09 ± 11%      -5.4       20.64 ± 12%  perf-profile.self.cycles-pp.intel_idle
      8.31 ±  3%      -2.2        6.14 ±  3%  perf-profile.self.cycles-pp.iomap_set_range_uptodate
      2.60 ±  2%      -0.7        1.93 ±  2%  perf-profile.self.cycles-pp.pagecache_get_page
      2.93 ±  3%      -0.6        2.37 ±  4%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      1.51 ± 21%      -0.6        0.96 ±  6%  perf-profile.self.cycles-pp.__mod_memcg_state
      1.89 ±  4%      -0.5        1.43 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.75 ±  4%      -0.4        1.38 ±  4%  perf-profile.self.cycles-pp.iomap_apply
      1.50 ±  4%      -0.3        1.17 ±  5%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_begin
      1.18 ± 16%      -0.3        0.87 ± 20%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.16 ±  4%      -0.3        0.86 ±  2%  perf-profile.self.cycles-pp.down_write
      1.43 ±  3%      -0.3        1.13 ±  3%  perf-profile.self.cycles-pp.___might_sleep
      0.92 ± 15%      -0.3        0.63 ±  8%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      1.16 ±  3%      -0.3        0.88 ±  3%  perf-profile.self.cycles-pp.vfs_write
      1.26 ±  3%      -0.3        0.98 ±  5%  perf-profile.self.cycles-pp.write
      1.01 ±  3%      -0.3        0.75 ±  4%  perf-profile.self.cycles-pp.up_write
      0.97 ±  3%      -0.2        0.72 ±  2%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      1.06 ±  3%      -0.2        0.81 ±  2%  perf-profile.self.cycles-pp.__fget_light
      0.76 ±  3%      -0.2        0.52 ±  7%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      1.01 ±  6%      -0.2        0.78 ± 10%  perf-profile.self.cycles-pp.xfs_file_buffered_write
      0.68 ± 16%      -0.2        0.45 ±  4%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.97 ±  3%      -0.2        0.75 ±  3%  perf-profile.self.cycles-pp.__entry_text_start
      0.92 ±  3%      -0.2        0.70 ±  5%  perf-profile.self.cycles-pp.iomap_write_end
      0.86 ±  4%      -0.2        0.64 ±  3%  perf-profile.self.cycles-pp.xas_load
      0.68 ±  6%      -0.2        0.47 ±  8%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_end
      0.63 ± 12%      -0.2        0.43 ±  6%  perf-profile.self.cycles-pp.lock_page_memcg
      1.19 ±  3%      -0.2        0.99 ±  3%  perf-profile.self.cycles-pp.memset_erms
      0.85 ±  6%      -0.2        0.65 ±  3%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.77 ±  4%      -0.2        0.59 ±  4%  perf-profile.self.cycles-pp.xfs_file_write_iter
      0.94 ±  4%      -0.2        0.77 ±  5%  perf-profile.self.cycles-pp.iomap_write_actor
      0.74 ±  4%      -0.2        0.58 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.76 ±  5%      -0.2        0.60 ±  4%  perf-profile.self.cycles-pp.common_file_perm
      0.85 ±  3%      -0.2        0.69 ±  5%  perf-profile.self.cycles-pp.iomap_write_begin
      0.70 ±  4%      -0.2        0.54 ±  6%  perf-profile.self.cycles-pp.__might_sleep
      0.58 ±  4%      -0.2        0.42 ±  5%  perf-profile.self.cycles-pp.llseek
      0.67 ±  2%      -0.2        0.52 ±  4%  perf-profile.self.cycles-pp.disk_rw
      0.46 ±  5%      -0.1        0.32 ±  6%  perf-profile.self.cycles-pp.xfs_bmbt_to_iomap
      0.39 ±  6%      -0.1        0.26 ±  7%  perf-profile.self.cycles-pp.ksys_write
      0.50 ±  6%      -0.1        0.37 ±  5%  perf-profile.self.cycles-pp.xfs_iunlock
      0.52 ±  5%      -0.1        0.40 ±  5%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.50 ±  3%      -0.1        0.38 ±  2%  perf-profile.self.cycles-pp.__set_page_dirty_nobuffers
      0.48 ±  4%      -0.1        0.37 ±  4%  perf-profile.self.cycles-pp.xfs_break_leased_layouts
      0.46 ±  3%      -0.1        0.35 ±  5%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.49 ±  5%      -0.1        0.38        perf-profile.self.cycles-pp.unlock_page
      0.44 ±  4%      -0.1        0.32        perf-profile.self.cycles-pp.__list_del_entry_valid
      0.59 ±  5%      -0.1        0.48 ±  2%  perf-profile.self.cycles-pp.xfs_iext_lookup_extent
      0.48 ±  5%      -0.1        0.38 ±  4%  perf-profile.self.cycles-pp.new_sync_write
      0.42 ±  5%      -0.1        0.32 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.32 ±  9%      -0.1        0.22 ±  8%  perf-profile.self.cycles-pp.xfs_file_llseek
      0.31 ± 22%      -0.1        0.21 ±  6%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.37 ±  3%      -0.1        0.27 ±  7%  perf-profile.self.cycles-pp.__cond_resched
      0.36 ±  5%      -0.1        0.27 ±  4%  perf-profile.self.cycles-pp.__pagevec_lru_add
      0.41 ±  4%      -0.1        0.32 ±  5%  perf-profile.self.cycles-pp.xfs_ilock
      0.36 ±  3%      -0.1        0.28 ±  3%  perf-profile.self.cycles-pp.xas_start
      0.33 ±  4%      -0.1        0.25 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.28 ±  5%      -0.1        0.20 ±  9%  perf-profile.self.cycles-pp.page_counter_cancel
      0.36 ±  6%      -0.1        0.28 ±  7%  perf-profile.self.cycles-pp.file_update_time
      0.37 ±  3%      -0.1        0.29 ±  5%  perf-profile.self.cycles-pp.iov_iter_fault_in_readable
      0.18 ± 34%      -0.1        0.10 ± 16%  perf-profile.self.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.38 ±  3%      -0.1        0.30 ±  6%  perf-profile.self.cycles-pp.xfs_file_write_checks
      0.29 ±  3%      -0.1        0.22 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.32 ±  7%      -0.1        0.24 ±  3%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.30 ±  5%      -0.1        0.22 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
      0.29 ±  4%      -0.1        0.22 ±  4%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.31 ±  7%      -0.1        0.25 ±  3%  perf-profile.self.cycles-pp.release_pages
      0.23 ±  5%      -0.1        0.17 ±  5%  perf-profile.self.cycles-pp.__fdget_pos
      0.21 ±  5%      -0.1        0.16 ±  7%  perf-profile.self.cycles-pp.__add_to_page_cache_locked
      0.22 ±  6%      -0.1        0.17 ±  4%  perf-profile.self.cycles-pp.rcu_all_qs
      0.19 ±  6%      -0.1        0.14 ±  8%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.22 ±  5%      -0.0        0.16 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.16 ±  8%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.16 ± 10%      -0.0        0.12 ±  9%  perf-profile.self.cycles-pp.ksys_lseek
      0.27 ±  4%      -0.0        0.22 ±  7%  perf-profile.self.cycles-pp.iomap_file_buffered_write
      0.24 ±  7%      -0.0        0.20 ±  8%  perf-profile.self.cycles-pp.xfs_iread_extents
      0.20 ±  3%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.aa_file_perm
      0.25 ±  3%      -0.0        0.20 ± 10%  perf-profile.self.cycles-pp.generic_write_checks
      0.22 ±  5%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.21 ±  5%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.find_lock_entries
      0.14 ± 17%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.uncharge_page
      0.25 ±  5%      -0.0        0.21 ±  4%  perf-profile.self.cycles-pp.xas_store
      0.17 ±  6%      -0.0        0.13 ±  5%  perf-profile.self.cycles-pp.security_file_permission
      0.14 ±  9%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.__unlock_page_memcg
      0.17 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.file_remove_privs
      0.17 ±  8%      -0.0        0.13 ± 11%  perf-profile.self.cycles-pp.timestamp_truncate
      0.14 ± 12%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.__count_memcg_events
      0.23 ±  8%      -0.0        0.19 ± 11%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.14 ±  5%      -0.0        0.10 ± 15%  perf-profile.self.cycles-pp.node_dirty_ok
      0.20 ±  7%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.current_time
      0.14 ±  6%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.__alloc_pages
      0.10 ±  6%      -0.0        0.07 ±  9%  perf-profile.self.cycles-pp.copyin
      0.12 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.rw_verify_area
      0.10 ± 10%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.__free_one_page
      0.09 ±  9%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.08 ± 10%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.12 ±  4%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.rmqueue
      0.08 ±  8%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.lru_cache_add
      0.07 ± 11%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.generic_file_llseek_size
      0.12 ±  7%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.wait_for_stable_page
      0.12 ±  5%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.12 ±  4%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.xfs_get_extsz_hint
      0.10 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.06 ±  7%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.13 ±  6%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.page_mapping
      0.11 ±  3%      -0.0        0.09 ±  8%  perf-profile.self.cycles-pp.rcu_read_unlock_strict
      0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.account_page_cleaned
      0.08 ± 10%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.iov_iter_init
      0.09 ±  7%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.__list_add_valid
      0.10 ±  7%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.__cancel_dirty_page
      0.07 ±  6%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__xfs_btree_check_sblock
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.10 ±  5%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.memcpy_erms
      0.70 ± 11%     +21.6       22.32 ±  4%  perf-profile.self.cycles-pp.osq_lock



***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/1BRD_48G/xfs/x86_64-rhel-8.3/3000/debian-10.4-x86_64-20200603.cgz/lkp-icl-2sp2/disk_cp/aim7/0xd000280

commit: 
  62af7d54a0 ("xfs: detach dquots from inode if we don't need to inactivate it")
  ab23a77687 ("xfs: per-cpu deferred inode inactivation queues")

62af7d54a0ec0b6f ab23a7768739a23d21d8a16ca37 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    414394 ±  3%     -24.6%     312557 ±  6%  aim7.jobs-per-min
     43.66 ±  3%     +32.9%      58.01 ±  6%  aim7.time.elapsed_time
     43.66 ±  3%     +32.9%      58.01 ±  6%  aim7.time.elapsed_time.max
     10108 ± 28%    +670.8%      77910 ± 13%  aim7.time.involuntary_context_switches
    174298 ±  3%      +5.9%     184518        aim7.time.minor_page_faults
      2729 ±  9%     +69.5%       4627 ± 12%  aim7.time.system_time
    902968           -49.5%     455902 ±  2%  aim7.time.voluntary_context_switches
     98.66           +20.2%     118.58 ±  4%  uptime.boot
     50.97            +8.2%      55.16 ±  5%  boot-time.boot
      5791           +10.3%       6387 ±  5%  boot-time.idle
     52.87 ±  5%     -23.5%      40.46 ±  9%  iostat.cpu.idle
     46.37 ±  5%     +27.0%      58.89 ±  6%  iostat.cpu.system
      2.35 ± 81%     -92.3%       0.18 ±240%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      4.18 ± 20%     -26.9%       3.06 ± 41%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    580711 ±  6%     -22.0%     453131 ±  8%  softirqs.RCU
     23452 ±  2%     +20.4%      28241 ±  6%  softirqs.TIMER
     50.91 ±  5%     -12.4       38.55 ±  9%  mpstat.cpu.all.idle%
      0.06 ±  8%      -0.0        0.04 ±  6%  mpstat.cpu.all.soft%
     47.38 ±  5%     +12.5       59.89 ±  6%  mpstat.cpu.all.sys%
      1271 ±  5%     +25.4%       1594 ±  6%  turbostat.Avg_MHz
     48.98 ±  5%     +12.4       61.43 ±  6%  turbostat.Busy%
     51.73 ±  5%     -12.6       39.09 ±  9%  turbostat.C1%
  14646037 ±  3%     +26.9%   18580579 ±  5%  turbostat.IRQ
     52.50 ±  5%     -23.8%      40.00 ±  9%  vmstat.cpu.id
     59.00 ±  6%     +26.6%      74.71 ±  8%  vmstat.procs.r
     42150 ±  3%     -37.4%      26402 ±  7%  vmstat.system.cs
    312980            -4.5%     299033        vmstat.system.in
     65020 ± 10%     +49.8%      97428 ± 10%  meminfo.Active
     64281 ± 10%     +50.3%      96638 ± 10%  meminfo.Active(anon)
     76384           +15.3%      88085 ±  3%  meminfo.AnonHugePages
     27207 ±  9%     +56.8%      42667 ±  3%  meminfo.Dirty
     26529 ±  9%     +58.1%      41945 ±  3%  meminfo.Inactive(file)
    104687 ±  8%     +28.8%     134873 ±  8%  meminfo.Shmem
     13217 ±  9%     +64.7%      21767 ±  8%  numa-meminfo.node0.Dirty
     13011 ±  9%     +64.7%      21435 ±  7%  numa-meminfo.node0.Inactive(file)
     61487 ± 12%     +52.2%      93591 ± 11%  numa-meminfo.node1.Active
     61487 ± 12%     +52.2%      93591 ± 11%  numa-meminfo.node1.Active(anon)
     13568 ±  8%     +52.2%      20650 ±  7%  numa-meminfo.node1.Dirty
     13116 ±  8%     +53.6%      20149 ±  7%  numa-meminfo.node1.Inactive(file)
     88354 ± 13%     +32.3%     116854 ±  9%  numa-meminfo.node1.Shmem
      3385 ±  9%     +61.9%       5479 ±  8%  numa-vmstat.node0.nr_dirty
      3340 ±  9%     +61.5%       5394 ±  7%  numa-vmstat.node0.nr_inactive_file
      3340 ±  9%     +61.3%       5389 ±  7%  numa-vmstat.node0.nr_zone_inactive_file
      3382 ± 10%     +44.5%       4888 ±  7%  numa-vmstat.node0.nr_zone_write_pending
     15371 ± 12%     +52.2%      23398 ± 11%  numa-vmstat.node1.nr_active_anon
      3358 ±  9%     +53.6%       5158 ±  7%  numa-vmstat.node1.nr_dirty
      3254 ±  9%     +54.9%       5039 ±  7%  numa-vmstat.node1.nr_inactive_file
     22091 ± 13%     +32.2%      29213 ±  9%  numa-vmstat.node1.nr_shmem
     15371 ± 12%     +52.2%      23398 ± 11%  numa-vmstat.node1.nr_zone_active_anon
      3245 ±  9%     +55.5%       5046 ±  7%  numa-vmstat.node1.nr_zone_inactive_file
      3387 ±  9%     +32.5%       4488 ±  9%  numa-vmstat.node1.nr_zone_write_pending
     16070 ± 10%     +50.3%      24159 ± 10%  proc-vmstat.nr_active_anon
      6775 ±  8%     +56.4%      10597 ±  3%  proc-vmstat.nr_dirty
    630808            +1.8%     642013        proc-vmstat.nr_file_pages
      6595 ±  9%     +57.5%      10387 ±  3%  proc-vmstat.nr_inactive_file
     26172 ±  8%     +28.8%      33717 ±  8%  proc-vmstat.nr_shmem
     37294 ±  2%      +5.3%      39269        proc-vmstat.nr_slab_reclaimable
     16070 ± 10%     +50.3%      24159 ± 10%  proc-vmstat.nr_zone_active_anon
      6596 ±  9%     +57.5%      10387 ±  3%  proc-vmstat.nr_zone_inactive_file
      6822 ±  6%     +35.7%       9257 ±  4%  proc-vmstat.nr_zone_write_pending
      3402 ±150%    +323.2%      14398 ±  6%  proc-vmstat.numa_hint_faults
    198.00 ±140%    +425.1%       1039 ± 34%  proc-vmstat.numa_hint_faults_local
      3730 ±141%    +262.0%      13504 ±  5%  proc-vmstat.numa_pages_migrated
    447437 ±  2%     +10.9%     496339 ±  2%  proc-vmstat.pgfault
      3730 ±141%    +262.0%      13504 ±  5%  proc-vmstat.pgmigrate_success
     14620 ±  2%     +22.1%      17845 ±  5%  proc-vmstat.pgreuse
      6117           +13.7%       6958        slabinfo.Acpi-Parse.active_objs
      6117           +13.7%       6958        slabinfo.Acpi-Parse.num_objs
      2919           +16.8%       3410        slabinfo.btrfs_ordered_extent.active_objs
      2919           +16.8%       3410        slabinfo.btrfs_ordered_extent.num_objs
      2925           +11.5%       3261 ±  2%  slabinfo.kmalloc-4k.active_objs
      2955           +11.8%       3302 ±  2%  slabinfo.kmalloc-4k.num_objs
      1511           +13.2%       1710        slabinfo.kmalloc-8k.active_objs
      1517           +13.2%       1718        slabinfo.kmalloc-8k.num_objs
     40931 ±  8%     +20.4%      49279 ±  5%  slabinfo.radix_tree_node.active_objs
    730.50 ±  8%     +20.4%     879.71 ±  5%  slabinfo.radix_tree_node.active_slabs
     40931 ±  8%     +20.5%      49303 ±  5%  slabinfo.radix_tree_node.num_objs
    730.50 ±  8%     +20.4%     879.71 ±  5%  slabinfo.radix_tree_node.num_slabs
      3577 ±  3%     +16.0%       4149        slabinfo.xfs_buf.active_objs
      3577 ±  3%     +16.0%       4149        slabinfo.xfs_buf.num_objs
      2829           +17.0%       3309        slabinfo.xfs_efd_item.active_objs
      2829           +17.0%       3309        slabinfo.xfs_efd_item.num_objs
      4481 ± 12%     +20.4%       5394 ± 12%  slabinfo.xfs_ili.active_objs
      3883 ± 11%     +48.4%       5764 ±  7%  slabinfo.xfs_inode.active_objs
      4021 ± 15%     +49.1%       5997 ±  9%  slabinfo.xfs_inode.num_objs
 8.694e+09 ±  2%     -13.8%  7.495e+09 ±  5%  perf-stat.i.branch-instructions
      0.78            -0.0        0.74 ±  3%  perf-stat.i.branch-miss-rate%
  51039516            -6.9%   47531666 ±  3%  perf-stat.i.branch-misses
     16.37 ±  3%      +3.3       19.71 ±  6%  perf-stat.i.cache-miss-rate%
  70261979 ±  2%      -6.9%   65384288 ±  3%  perf-stat.i.cache-misses
 3.808e+08 ±  3%     -21.0%   3.01e+08 ±  4%  perf-stat.i.cache-references
     41653 ±  3%     -35.4%      26907 ±  8%  perf-stat.i.context-switches
      3.49 ±  7%     +45.9%       5.10 ± 11%  perf-stat.i.cpi
 1.547e+11 ±  5%     +31.4%  2.033e+11 ±  6%  perf-stat.i.cpu-cycles
      4790 ±  2%     -40.2%       2863 ±  3%  perf-stat.i.cpu-migrations
 1.279e+10 ±  2%     -14.5%  1.094e+10 ±  5%  perf-stat.i.dTLB-loads
      0.01 ±  4%      -0.0        0.00 ±  6%  perf-stat.i.dTLB-store-miss-rate%
    141188 ±  3%     -14.3%     121055 ±  3%  perf-stat.i.dTLB-store-misses
 6.953e+09 ±  3%     -20.0%  5.561e+09 ±  5%  perf-stat.i.dTLB-stores
 4.439e+10 ±  2%     -13.9%  3.822e+10 ±  5%  perf-stat.i.instructions
      0.33 ±  6%     -31.5%       0.22 ± 11%  perf-stat.i.ipc
      1.21 ±  5%     +31.6%       1.59 ±  6%  perf-stat.i.metric.GHz
    461.78           -11.7%     407.64 ±  3%  perf-stat.i.metric.K/sec
    224.60 ±  3%     -15.6%     189.66 ±  5%  perf-stat.i.metric.M/sec
      8342           -14.2%       7157 ±  3%  perf-stat.i.minor-faults
  43910194 ±  2%     -12.3%   38496847 ±  4%  perf-stat.i.node-stores
      8464           -14.6%       7231 ±  3%  perf-stat.i.page-faults
      8.61            -8.3%       7.90        perf-stat.overall.MPKI
      0.58 ±  2%      +0.1        0.63 ±  3%  perf-stat.overall.branch-miss-rate%
     18.49 ±  4%      +3.3       21.78 ±  6%  perf-stat.overall.cache-miss-rate%
      3.50 ±  8%     +52.9%       5.36 ± 11%  perf-stat.overall.cpi
      2197 ±  5%     +41.3%       3104 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.00 ±  3%      +0.0        0.00 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
      0.29 ±  7%     -34.2%       0.19 ± 11%  perf-stat.overall.ipc
 8.926e+09 ±  2%     -15.9%  7.506e+09 ±  5%  perf-stat.ps.branch-instructions
  51927639            -8.6%   47446006 ±  3%  perf-stat.ps.branch-misses
  72466852            -9.4%   65622883 ±  3%  perf-stat.ps.cache-misses
 3.923e+08 ±  3%     -23.0%  3.021e+08 ±  4%  perf-stat.ps.cache-references
     42458 ±  3%     -36.9%      26810 ±  8%  perf-stat.ps.context-switches
 1.592e+11 ±  5%     +27.9%  2.037e+11 ±  6%  perf-stat.ps.cpu-cycles
      4915 ±  2%     -41.8%       2861 ±  3%  perf-stat.ps.cpu-migrations
 1.315e+10 ±  2%     -16.6%  1.096e+10 ±  5%  perf-stat.ps.dTLB-loads
    141194 ±  3%     -14.5%     120674 ±  3%  perf-stat.ps.dTLB-store-misses
 7.151e+09 ±  3%     -22.1%  5.574e+09 ±  5%  perf-stat.ps.dTLB-stores
 4.558e+10 ±  3%     -16.0%  3.828e+10 ±  5%  perf-stat.ps.instructions
      7548           -10.0%       6796 ±  3%  perf-stat.ps.minor-faults
   1343685 ± 11%     -17.2%    1112057 ±  6%  perf-stat.ps.node-loads
  45344227 ±  2%     -14.7%   38662083 ±  4%  perf-stat.ps.node-stores
      7651           -10.3%       6862 ±  3%  perf-stat.ps.page-faults
 2.026e+12           +13.3%  2.296e+12        perf-stat.total.instructions
     90770 ±  3%     +34.7%     122307 ±  5%  interrupts.CPU0.LOC:Local_timer_interrupts
      4887 ± 34%     -37.6%       3048 ± 25%  interrupts.CPU0.RES:Rescheduling_interrupts
     90686 ±  3%     +33.2%     120774 ±  6%  interrupts.CPU1.LOC:Local_timer_interrupts
     90765 ±  3%     +32.8%     120556 ±  6%  interrupts.CPU10.LOC:Local_timer_interrupts
      4721 ± 32%     -38.2%       2920 ± 24%  interrupts.CPU10.RES:Rescheduling_interrupts
     90744 ±  3%     +33.1%     120776 ±  5%  interrupts.CPU100.LOC:Local_timer_interrupts
     90714 ±  3%     +33.1%     120708 ±  6%  interrupts.CPU101.LOC:Local_timer_interrupts
     90713 ±  3%     +33.1%     120779 ±  6%  interrupts.CPU102.LOC:Local_timer_interrupts
     90710 ±  3%     +33.2%     120784 ±  6%  interrupts.CPU103.LOC:Local_timer_interrupts
     90726 ±  3%     +33.2%     120806 ±  6%  interrupts.CPU104.LOC:Local_timer_interrupts
     90683 ±  3%     +33.1%     120727 ±  6%  interrupts.CPU105.LOC:Local_timer_interrupts
     90711 ±  3%     +33.1%     120760 ±  6%  interrupts.CPU106.LOC:Local_timer_interrupts
     90709 ±  3%     +33.1%     120744 ±  6%  interrupts.CPU107.LOC:Local_timer_interrupts
     90682 ±  3%     +33.1%     120696 ±  6%  interrupts.CPU108.LOC:Local_timer_interrupts
     90704 ±  3%     +33.1%     120762 ±  6%  interrupts.CPU109.LOC:Local_timer_interrupts
     90751 ±  3%     +33.3%     120966 ±  6%  interrupts.CPU11.LOC:Local_timer_interrupts
      5066 ± 32%     -42.6%       2905 ± 23%  interrupts.CPU11.RES:Rescheduling_interrupts
     90682 ±  3%     +33.2%     120774 ±  6%  interrupts.CPU110.LOC:Local_timer_interrupts
     90687 ±  3%     +33.2%     120788 ±  5%  interrupts.CPU111.LOC:Local_timer_interrupts
     90681 ±  3%     +33.2%     120746 ±  6%  interrupts.CPU112.LOC:Local_timer_interrupts
     90683 ±  3%     +33.1%     120666 ±  6%  interrupts.CPU113.LOC:Local_timer_interrupts
     90680 ±  3%     +33.1%     120740 ±  6%  interrupts.CPU114.LOC:Local_timer_interrupts
     90677 ±  3%     +33.2%     120761 ±  6%  interrupts.CPU115.LOC:Local_timer_interrupts
     90670 ±  3%     +33.2%     120747 ±  6%  interrupts.CPU116.LOC:Local_timer_interrupts
     90684 ±  3%     +33.1%     120742 ±  5%  interrupts.CPU117.LOC:Local_timer_interrupts
     90669 ±  3%     +33.3%     120843 ±  5%  interrupts.CPU118.LOC:Local_timer_interrupts
     90669 ±  3%     +33.3%     120841 ±  6%  interrupts.CPU119.LOC:Local_timer_interrupts
      3688 ±  6%     -19.2%       2981 ± 12%  interrupts.CPU12.CAL:Function_call_interrupts
     90638 ±  3%     +33.1%     120679 ±  5%  interrupts.CPU12.LOC:Local_timer_interrupts
      4636 ± 31%     -38.9%       2832 ± 21%  interrupts.CPU12.RES:Rescheduling_interrupts
     90668 ±  3%     +33.2%     120814 ±  6%  interrupts.CPU120.LOC:Local_timer_interrupts
     90666 ±  3%     +33.3%     120815 ±  6%  interrupts.CPU121.LOC:Local_timer_interrupts
     93604 ±  6%     +29.1%     120828 ±  6%  interrupts.CPU122.LOC:Local_timer_interrupts
     90687 ±  3%     +33.2%     120835 ±  6%  interrupts.CPU123.LOC:Local_timer_interrupts
     90700 ±  3%     +33.2%     120812 ±  6%  interrupts.CPU124.LOC:Local_timer_interrupts
     90705 ±  3%     +33.3%     120891 ±  6%  interrupts.CPU125.LOC:Local_timer_interrupts
     90695 ±  3%     +33.2%     120848 ±  6%  interrupts.CPU126.LOC:Local_timer_interrupts
     90700 ±  3%     +33.2%     120855 ±  6%  interrupts.CPU127.LOC:Local_timer_interrupts
     93428 ±  7%     +29.2%     120663 ±  6%  interrupts.CPU13.LOC:Local_timer_interrupts
     91277 ±  3%     +32.1%     120597 ±  5%  interrupts.CPU14.LOC:Local_timer_interrupts
     90745 ±  3%     +33.0%     120687 ±  6%  interrupts.CPU15.LOC:Local_timer_interrupts
      4789 ± 29%     -36.8%       3028 ± 13%  interrupts.CPU15.RES:Rescheduling_interrupts
      3730 ±  8%     -21.9%       2914 ± 10%  interrupts.CPU16.CAL:Function_call_interrupts
     90801 ±  3%     +32.9%     120666 ±  5%  interrupts.CPU16.LOC:Local_timer_interrupts
      4982 ± 31%     -45.6%       2708 ± 26%  interrupts.CPU16.RES:Rescheduling_interrupts
      3660 ±  7%     -18.9%       2967 ±  8%  interrupts.CPU17.CAL:Function_call_interrupts
     90538 ±  3%     +33.3%     120672 ±  6%  interrupts.CPU17.LOC:Local_timer_interrupts
      5053 ± 33%     -43.5%       2856 ± 25%  interrupts.CPU17.RES:Rescheduling_interrupts
      3741 ±  8%     -20.5%       2973 ±  8%  interrupts.CPU18.CAL:Function_call_interrupts
     90727 ±  3%     +32.9%     120620 ±  6%  interrupts.CPU18.LOC:Local_timer_interrupts
      5084 ± 32%     -39.6%       3069 ± 29%  interrupts.CPU18.RES:Rescheduling_interrupts
      3641 ±  7%     -19.1%       2945 ± 11%  interrupts.CPU19.CAL:Function_call_interrupts
     94120 ±  7%     +28.0%     120496 ±  6%  interrupts.CPU19.LOC:Local_timer_interrupts
      7793 ± 15%     +28.4%      10003 ±  4%  interrupts.CPU19.NMI:Non-maskable_interrupts
      7793 ± 15%     +28.4%      10003 ±  4%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
     90723 ±  3%     +33.1%     120755 ±  6%  interrupts.CPU2.LOC:Local_timer_interrupts
      4858 ± 34%     -41.4%       2848 ± 24%  interrupts.CPU2.RES:Rescheduling_interrupts
     90768 ±  3%     +33.0%     120736 ±  5%  interrupts.CPU20.LOC:Local_timer_interrupts
      7321 ± 20%     +36.4%       9987 ±  4%  interrupts.CPU20.NMI:Non-maskable_interrupts
      7321 ± 20%     +36.4%       9987 ±  4%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
      5006 ± 32%     -38.9%       3059 ± 27%  interrupts.CPU20.RES:Rescheduling_interrupts
      3785 ± 10%     -23.2%       2906 ±  8%  interrupts.CPU21.CAL:Function_call_interrupts
     90677 ±  3%     +33.2%     120796 ±  6%  interrupts.CPU21.LOC:Local_timer_interrupts
      7800 ± 14%     +28.4%      10019 ±  2%  interrupts.CPU21.NMI:Non-maskable_interrupts
      7800 ± 14%     +28.4%      10019 ±  2%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
      3678 ±  7%     -19.6%       2957 ±  8%  interrupts.CPU22.CAL:Function_call_interrupts
     90710 ±  3%     +33.1%     120741 ±  5%  interrupts.CPU22.LOC:Local_timer_interrupts
      4939 ± 32%     -42.5%       2841 ± 27%  interrupts.CPU22.RES:Rescheduling_interrupts
      3683 ±  7%     -18.9%       2985 ± 10%  interrupts.CPU23.CAL:Function_call_interrupts
     90714 ±  3%     +36.1%     123452 ±  8%  interrupts.CPU23.LOC:Local_timer_interrupts
      4727 ± 34%     -39.0%       2881 ± 25%  interrupts.CPU23.RES:Rescheduling_interrupts
      3722 ±  9%     -20.5%       2959 ±  9%  interrupts.CPU24.CAL:Function_call_interrupts
     90745 ±  3%     +32.9%     120644 ±  6%  interrupts.CPU24.LOC:Local_timer_interrupts
      5026 ± 29%     -43.2%       2856 ± 24%  interrupts.CPU24.RES:Rescheduling_interrupts
      3664 ±  4%     -17.0%       3042 ±  8%  interrupts.CPU25.CAL:Function_call_interrupts
     90765 ±  3%     +34.1%     121701 ±  6%  interrupts.CPU25.LOC:Local_timer_interrupts
      5087 ± 51%     -41.0%       3002 ± 22%  interrupts.CPU25.RES:Rescheduling_interrupts
     90736 ±  3%     +35.6%     123031 ±  7%  interrupts.CPU26.LOC:Local_timer_interrupts
      8179 ±  7%     +22.9%      10049 ±  3%  interrupts.CPU26.NMI:Non-maskable_interrupts
      8179 ±  7%     +22.9%      10049 ±  3%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
     90735 ±  3%     +33.0%     120693 ±  5%  interrupts.CPU27.LOC:Local_timer_interrupts
      4658 ± 34%     -38.5%       2865 ± 22%  interrupts.CPU27.RES:Rescheduling_interrupts
      3616 ±  8%     -18.6%       2943 ±  7%  interrupts.CPU28.CAL:Function_call_interrupts
     90697 ±  3%     +32.5%     120206 ±  5%  interrupts.CPU28.LOC:Local_timer_interrupts
      8270 ±  5%     +21.7%      10061 ±  4%  interrupts.CPU28.NMI:Non-maskable_interrupts
      8270 ±  5%     +21.7%      10061 ±  4%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
     90749 ±  3%     +33.2%     120904 ±  6%  interrupts.CPU29.LOC:Local_timer_interrupts
      8320 ±  5%     +20.1%       9989 ±  3%  interrupts.CPU29.NMI:Non-maskable_interrupts
      8320 ±  5%     +20.1%       9989 ±  3%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
     90756 ±  3%     +33.1%     120795 ±  6%  interrupts.CPU3.LOC:Local_timer_interrupts
      4556 ± 24%     -35.6%       2932 ± 23%  interrupts.CPU3.RES:Rescheduling_interrupts
     90744 ±  3%     +32.6%     120346 ±  6%  interrupts.CPU30.LOC:Local_timer_interrupts
      8300 ±  5%     +19.8%       9942 ±  3%  interrupts.CPU30.NMI:Non-maskable_interrupts
      8300 ±  5%     +19.8%       9942 ±  3%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
      4704 ± 37%     -40.8%       2783 ± 23%  interrupts.CPU30.RES:Rescheduling_interrupts
      3786 ±  7%     -19.2%       3060 ±  8%  interrupts.CPU31.CAL:Function_call_interrupts
     90752 ±  3%     +35.6%     123096 ±  6%  interrupts.CPU31.LOC:Local_timer_interrupts
      4868 ± 37%     -40.6%       2890 ± 21%  interrupts.CPU31.RES:Rescheduling_interrupts
     90680 ±  3%     +33.1%     120701 ±  5%  interrupts.CPU32.LOC:Local_timer_interrupts
     90725 ±  3%     +33.0%     120704 ±  6%  interrupts.CPU33.LOC:Local_timer_interrupts
     90603 ±  3%     +37.8%     124824 ±  7%  interrupts.CPU34.LOC:Local_timer_interrupts
     94148 ±  8%     +28.2%     120666 ±  5%  interrupts.CPU35.LOC:Local_timer_interrupts
     90693 ±  3%     +33.1%     120671 ±  5%  interrupts.CPU36.LOC:Local_timer_interrupts
     90686 ±  3%     +32.7%     120375 ±  6%  interrupts.CPU37.LOC:Local_timer_interrupts
     90694 ±  3%     +33.1%     120688 ±  6%  interrupts.CPU38.LOC:Local_timer_interrupts
     90732 ±  3%     +33.0%     120711 ±  5%  interrupts.CPU39.LOC:Local_timer_interrupts
     90665 ±  3%     +33.1%     120669 ±  6%  interrupts.CPU4.LOC:Local_timer_interrupts
      4717 ± 34%     -39.0%       2875 ± 26%  interrupts.CPU4.RES:Rescheduling_interrupts
     90723 ±  3%     +33.1%     120708 ±  6%  interrupts.CPU40.LOC:Local_timer_interrupts
     90544 ±  3%     +33.0%     120406 ±  6%  interrupts.CPU41.LOC:Local_timer_interrupts
     90704 ±  3%     +33.0%     120640 ±  6%  interrupts.CPU42.LOC:Local_timer_interrupts
     90703 ±  3%     +32.9%     120532 ±  6%  interrupts.CPU43.LOC:Local_timer_interrupts
     90682 ±  3%     +32.8%     120422 ±  6%  interrupts.CPU44.LOC:Local_timer_interrupts
     90844 ±  3%     +32.5%     120394 ±  6%  interrupts.CPU45.LOC:Local_timer_interrupts
      7869 ±  9%     +22.2%       9618 ±  7%  interrupts.CPU45.NMI:Non-maskable_interrupts
      7869 ±  9%     +22.2%       9618 ±  7%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
     90683 ±  3%     +32.9%     120477 ±  6%  interrupts.CPU46.LOC:Local_timer_interrupts
      7858 ± 11%     +22.2%       9600 ±  7%  interrupts.CPU46.NMI:Non-maskable_interrupts
      7858 ± 11%     +22.2%       9600 ±  7%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
     90683 ±  3%     +32.9%     120484 ±  6%  interrupts.CPU47.LOC:Local_timer_interrupts
      7720 ± 11%     +24.1%       9579 ±  6%  interrupts.CPU47.NMI:Non-maskable_interrupts
      7720 ± 11%     +24.1%       9579 ±  6%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
     90699 ±  3%     +33.1%     120710 ±  5%  interrupts.CPU48.LOC:Local_timer_interrupts
     90614 ±  3%     +33.2%     120700 ±  6%  interrupts.CPU49.LOC:Local_timer_interrupts
      7860 ± 15%     +22.6%       9636 ±  6%  interrupts.CPU49.NMI:Non-maskable_interrupts
      7860 ± 15%     +22.6%       9636 ±  6%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
     90706 ±  3%     +32.9%     120586 ±  6%  interrupts.CPU5.LOC:Local_timer_interrupts
     90736 ±  3%     +32.9%     120632 ±  6%  interrupts.CPU50.LOC:Local_timer_interrupts
     90702 ±  3%     +33.1%     120711 ±  5%  interrupts.CPU51.LOC:Local_timer_interrupts
     90765 ±  3%     +32.8%     120526 ±  6%  interrupts.CPU52.LOC:Local_timer_interrupts
     90697 ±  3%     +33.2%     120777 ±  6%  interrupts.CPU54.LOC:Local_timer_interrupts
     90689 ±  3%     +33.2%     120798 ±  6%  interrupts.CPU55.LOC:Local_timer_interrupts
     90664 ±  3%     +33.2%     120773 ±  6%  interrupts.CPU56.LOC:Local_timer_interrupts
      7377 ± 17%     +31.0%       9662 ±  6%  interrupts.CPU56.NMI:Non-maskable_interrupts
      7377 ± 17%     +31.0%       9662 ±  6%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
     90683 ±  3%     +33.2%     120782 ±  6%  interrupts.CPU57.LOC:Local_timer_interrupts
     90687 ±  3%     +33.1%     120745 ±  6%  interrupts.CPU58.LOC:Local_timer_interrupts
     90727 ±  3%     +33.2%     120829 ±  5%  interrupts.CPU59.LOC:Local_timer_interrupts
     90757 ±  3%     +32.8%     120555 ±  6%  interrupts.CPU6.LOC:Local_timer_interrupts
     90797 ±  3%     +33.1%     120832 ±  5%  interrupts.CPU60.LOC:Local_timer_interrupts
     90686 ±  3%     +33.2%     120788 ±  6%  interrupts.CPU61.LOC:Local_timer_interrupts
     90691 ±  3%     +33.2%     120792 ±  6%  interrupts.CPU62.LOC:Local_timer_interrupts
     90741 ±  3%     +33.1%     120772 ±  6%  interrupts.CPU63.LOC:Local_timer_interrupts
     90747 ±  3%     +33.1%     120742 ±  6%  interrupts.CPU64.LOC:Local_timer_interrupts
      3681 ±  7%     -20.9%       2912 ± 11%  interrupts.CPU65.CAL:Function_call_interrupts
     90744 ±  3%     +33.1%     120737 ±  6%  interrupts.CPU65.LOC:Local_timer_interrupts
      7812 ± 10%     +28.1%      10009 ±  4%  interrupts.CPU65.NMI:Non-maskable_interrupts
      7812 ± 10%     +28.1%      10009 ±  4%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
      4766 ± 39%     -43.6%       2687 ± 28%  interrupts.CPU65.RES:Rescheduling_interrupts
      3709 ±  7%     -18.1%       3037 ±  8%  interrupts.CPU66.CAL:Function_call_interrupts
     90765 ±  3%     +33.1%     120763 ±  6%  interrupts.CPU66.LOC:Local_timer_interrupts
      4684 ± 35%     -39.1%       2850 ± 23%  interrupts.CPU66.RES:Rescheduling_interrupts
     93921 ±  7%     +28.5%     120726 ±  6%  interrupts.CPU67.LOC:Local_timer_interrupts
      3667 ±  7%     -19.0%       2969 ± 12%  interrupts.CPU68.CAL:Function_call_interrupts
     90697 ±  3%     +33.0%     120652 ±  6%  interrupts.CPU68.LOC:Local_timer_interrupts
      4706 ± 35%     -37.1%       2959 ± 29%  interrupts.CPU68.RES:Rescheduling_interrupts
      3764 ±  6%     -23.0%       2900 ± 11%  interrupts.CPU69.CAL:Function_call_interrupts
     90697 ±  3%     +33.0%     120633 ±  6%  interrupts.CPU69.LOC:Local_timer_interrupts
      5217 ± 35%     -46.9%       2771 ± 26%  interrupts.CPU69.RES:Rescheduling_interrupts
      3988 ± 20%     -24.4%       3015 ±  9%  interrupts.CPU7.CAL:Function_call_interrupts
     90737 ±  3%     +32.7%     120413 ±  6%  interrupts.CPU7.LOC:Local_timer_interrupts
      5010 ± 32%     -42.5%       2882 ± 23%  interrupts.CPU7.RES:Rescheduling_interrupts
     90768 ±  3%     +33.0%     120690 ±  6%  interrupts.CPU70.LOC:Local_timer_interrupts
      3680 ±  7%     -17.6%       3033 ±  9%  interrupts.CPU71.CAL:Function_call_interrupts
     90933 ±  3%     +32.7%     120685 ±  6%  interrupts.CPU71.LOC:Local_timer_interrupts
      4709 ± 34%     -42.2%       2723 ± 25%  interrupts.CPU71.RES:Rescheduling_interrupts
      3697 ±  7%     -20.4%       2941 ±  9%  interrupts.CPU72.CAL:Function_call_interrupts
     90776 ±  3%     +32.8%     120539 ±  5%  interrupts.CPU72.LOC:Local_timer_interrupts
      5541 ± 34%     -49.6%       2793 ± 23%  interrupts.CPU72.RES:Rescheduling_interrupts
     90690 ±  3%     +32.9%     120550 ±  5%  interrupts.CPU73.LOC:Local_timer_interrupts
      3714 ±  6%     -20.6%       2949 ±  8%  interrupts.CPU74.CAL:Function_call_interrupts
     90753 ±  3%     +33.0%     120709 ±  6%  interrupts.CPU74.LOC:Local_timer_interrupts
      4755 ± 38%     -41.0%       2805 ± 20%  interrupts.CPU74.RES:Rescheduling_interrupts
      3713 ±  8%     -19.0%       3007 ±  6%  interrupts.CPU75.CAL:Function_call_interrupts
     90716 ±  3%     +35.1%     122556 ±  9%  interrupts.CPU75.LOC:Local_timer_interrupts
      4829 ± 32%     -40.4%       2879 ± 20%  interrupts.CPU75.RES:Rescheduling_interrupts
     90719 ±  3%     +33.0%     120673 ±  6%  interrupts.CPU76.LOC:Local_timer_interrupts
      4768 ± 31%     -38.2%       2946 ± 30%  interrupts.CPU76.RES:Rescheduling_interrupts
     90600 ±  3%     +33.2%     120665 ±  6%  interrupts.CPU77.LOC:Local_timer_interrupts
      4695 ± 39%     -39.8%       2825 ± 22%  interrupts.CPU77.RES:Rescheduling_interrupts
     90715 ±  3%     +33.0%     120685 ±  6%  interrupts.CPU78.LOC:Local_timer_interrupts
      5164 ± 29%     -44.9%       2845 ± 22%  interrupts.CPU78.RES:Rescheduling_interrupts
     90738 ±  3%     +32.9%     120625 ±  6%  interrupts.CPU79.LOC:Local_timer_interrupts
     90793 ±  3%     +32.9%     120701 ±  6%  interrupts.CPU8.LOC:Local_timer_interrupts
      4862 ± 32%     -32.8%       3267 ± 16%  interrupts.CPU8.RES:Rescheduling_interrupts
      3635 ±  7%     -20.0%       2908 ±  7%  interrupts.CPU80.CAL:Function_call_interrupts
     90731 ±  3%     +33.0%     120704 ±  6%  interrupts.CPU80.LOC:Local_timer_interrupts
     90685 ±  3%     +33.6%     121146 ±  6%  interrupts.CPU81.LOC:Local_timer_interrupts
     90772 ±  3%     +33.0%     120698 ±  6%  interrupts.CPU82.LOC:Local_timer_interrupts
      5130 ± 30%     -43.3%       2910 ± 25%  interrupts.CPU82.RES:Rescheduling_interrupts
     90734 ±  3%     +32.9%     120566 ±  6%  interrupts.CPU83.LOC:Local_timer_interrupts
      3763 ±  5%     -19.4%       3031 ±  9%  interrupts.CPU84.CAL:Function_call_interrupts
     90738 ±  3%     +33.0%     120700 ±  6%  interrupts.CPU84.LOC:Local_timer_interrupts
      4928 ± 38%     -41.2%       2898 ± 24%  interrupts.CPU84.RES:Rescheduling_interrupts
      3651 ±  9%     -19.8%       2929 ±  7%  interrupts.CPU85.CAL:Function_call_interrupts
     90721 ±  3%     +33.1%     120762 ±  6%  interrupts.CPU85.LOC:Local_timer_interrupts
      4958 ± 38%     -43.7%       2791 ± 24%  interrupts.CPU85.RES:Rescheduling_interrupts
     90635 ±  3%     +35.4%     122715 ±  7%  interrupts.CPU86.LOC:Local_timer_interrupts
      4715 ± 32%     -38.1%       2917 ± 23%  interrupts.CPU86.RES:Rescheduling_interrupts
      3718 ±  7%     -18.7%       3022 ± 10%  interrupts.CPU87.CAL:Function_call_interrupts
     90726 ±  3%     +34.2%     121716 ±  6%  interrupts.CPU87.LOC:Local_timer_interrupts
      5108 ± 31%     -41.6%       2986 ± 25%  interrupts.CPU87.RES:Rescheduling_interrupts
      3644 ±  7%     -17.6%       3003 ±  9%  interrupts.CPU88.CAL:Function_call_interrupts
     90733 ±  3%     +33.0%     120691 ±  6%  interrupts.CPU88.LOC:Local_timer_interrupts
      4669 ± 36%     -37.0%       2942 ± 18%  interrupts.CPU88.RES:Rescheduling_interrupts
     90758 ±  3%     +33.4%     121093 ±  5%  interrupts.CPU89.LOC:Local_timer_interrupts
     90679 ±  3%     +32.8%     120413 ±  6%  interrupts.CPU9.LOC:Local_timer_interrupts
      4719 ± 31%     -38.9%       2882 ± 25%  interrupts.CPU9.RES:Rescheduling_interrupts
     90713 ±  3%     +33.0%     120653 ±  6%  interrupts.CPU90.LOC:Local_timer_interrupts
      5089 ± 33%     -44.6%       2817 ± 21%  interrupts.CPU90.RES:Rescheduling_interrupts
     90721 ±  3%     +33.0%     120662 ±  6%  interrupts.CPU91.LOC:Local_timer_interrupts
      3621 ±  7%     -18.3%       2956 ±  9%  interrupts.CPU92.CAL:Function_call_interrupts
     91251 ±  3%     +32.3%     120760 ±  5%  interrupts.CPU92.LOC:Local_timer_interrupts
      4635 ± 35%     -38.9%       2834 ± 24%  interrupts.CPU92.RES:Rescheduling_interrupts
      3543 ±  8%     -14.4%       3032 ±  7%  interrupts.CPU93.CAL:Function_call_interrupts
     90762 ±  3%     +33.0%     120721 ±  5%  interrupts.CPU93.LOC:Local_timer_interrupts
      3714 ±  7%     -18.2%       3039 ±  8%  interrupts.CPU94.CAL:Function_call_interrupts
     90772 ±  3%     +34.4%     122039 ±  5%  interrupts.CPU94.LOC:Local_timer_interrupts
     91551 ±  3%     +31.9%     120755 ±  6%  interrupts.CPU95.LOC:Local_timer_interrupts
     90691 ±  3%     +33.1%     120751 ±  6%  interrupts.CPU96.LOC:Local_timer_interrupts
     90712 ±  3%     +33.1%     120750 ±  6%  interrupts.CPU97.LOC:Local_timer_interrupts
     90681 ±  3%     +33.2%     120773 ±  6%  interrupts.CPU98.LOC:Local_timer_interrupts
     90711 ±  3%     +33.1%     120781 ±  5%  interrupts.CPU99.LOC:Local_timer_interrupts
  11633559 ±  3%     +33.0%   15470185 ±  5%  interrupts.LOC:Local_timer_interrupts
    535019 ±  6%     -20.5%     425152 ±  6%  interrupts.RES:Rescheduling_interrupts
     67.62           -14.9       52.74 ±  3%  perf-profile.calltrace.cycles-pp.xfs_file_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
     67.42           -14.8       52.66 ±  3%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_read.xfs_file_read_iter.new_sync_read.vfs_read.ksys_read
     32.77            -9.4       23.36 ±  5%  perf-profile.calltrace.cycles-pp.xfs_ilock_iocb.xfs_file_buffered_read.xfs_file_read_iter.new_sync_read.vfs_read
     32.61            -9.4       23.21 ±  5%  perf-profile.calltrace.cycles-pp.down_read.xfs_ilock.xfs_ilock_iocb.xfs_file_buffered_read.xfs_file_read_iter
     32.74            -9.4       23.34 ±  5%  perf-profile.calltrace.cycles-pp.xfs_ilock.xfs_ilock_iocb.xfs_file_buffered_read.xfs_file_read_iter.new_sync_read
     25.37 ±  2%      -6.6       18.74 ±  2%  perf-profile.calltrace.cycles-pp.xfs_iunlock.xfs_file_buffered_read.xfs_file_read_iter.new_sync_read.vfs_read
     25.26 ±  2%      -6.6       18.64 ±  2%  perf-profile.calltrace.cycles-pp.up_read.xfs_iunlock.xfs_file_buffered_read.xfs_file_read_iter.new_sync_read
     22.95            -6.1       16.82 ±  2%  perf-profile.calltrace.cycles-pp.write
     22.29            -5.9       16.42        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     22.16            -5.8       16.33        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     21.94            -5.8       16.18        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     21.63            -5.6       16.00        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     20.89            -5.4       15.52        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.61            -5.3       15.33        perf-profile.calltrace.cycles-pp.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
     15.70            -5.3       10.43 ±  2%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
     15.62            -5.2       10.37 ±  2%  perf-profile.calltrace.cycles-pp.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write.vfs_write
     12.82            -4.7        8.11 ±  3%  perf-profile.calltrace.cycles-pp.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
      6.94            -2.3        4.68 ±  2%  perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      4.43            -2.0        2.44 ±  2%  perf-profile.calltrace.cycles-pp.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      5.08 ±  2%      -1.7        3.37        perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      4.98 ±  2%      -1.7        3.31 ±  2%  perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply
      2.77 ±  2%      -1.6        1.19 ±  6%  perf-profile.calltrace.cycles-pp.__close
      2.76 ±  2%      -1.6        1.18 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      2.76 ±  2%      -1.6        1.18 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.75 ±  2%      -1.6        1.18 ±  6%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.75 ±  2%      -1.6        1.18 ±  6%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.74 ±  2%      -1.6        1.18 ±  6%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.74 ±  2%      -1.6        1.17 ±  6%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2.70 ±  2%      -1.6        1.14 ±  7%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      2.69 ±  2%      -1.6        1.13 ±  6%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_prepare
      2.22 ±  2%      -1.1        1.12 ±  7%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
      2.20 ±  2%      -1.1        1.11 ±  6%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.__dentry_kill.dput.__fput
      2.70            -0.9        1.77 ±  2%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      1.69 ±  2%      -0.7        0.94        perf-profile.calltrace.cycles-pp.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.19            -0.6        0.57 ±  2%  perf-profile.calltrace.cycles-pp.lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      1.19 ±  2%      -0.5        0.72 ±  6%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.18 ±  6%      -0.4        0.78 ± 13%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.02 ±  7%      -0.4        0.65 ±  9%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.xfs_file_buffered_read.xfs_file_read_iter.new_sync_read
      1.47 ±  3%      -0.3        1.15 ±  4%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      2.18            -0.3        1.85 ±  3%  perf-profile.calltrace.cycles-pp.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
      0.74 ±  6%      -0.3        0.47 ± 41%  perf-profile.calltrace.cycles-pp.xfs_iunlock.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      2.91 ±  3%      +0.2        3.07 ±  2%  perf-profile.calltrace.cycles-pp.file_update_time.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write
      1.78 ±  4%      +0.2        1.96 ±  5%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_vn_update_time.file_update_time.xfs_file_write_checks.xfs_file_buffered_write
      2.70 ±  4%      +0.2        2.88 ±  3%  perf-profile.calltrace.cycles-pp.xfs_vn_update_time.file_update_time.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write
      3.67 ±  2%      +0.2        3.88 ±  2%  perf-profile.calltrace.cycles-pp.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
      0.26 ±100%      +0.4        0.64 ± 12%  perf-profile.calltrace.cycles-pp.xfs_break_layouts.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write
      0.00            +0.6        0.58 ± 13%  perf-profile.calltrace.cycles-pp.xfs_break_leased_layouts.xfs_break_layouts.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write
      4.89 ± 16%      +1.7        6.57 ±  3%  perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.xfs_file_buffered_read.xfs_file_read_iter.new_sync_read
      1.18 ±  4%      +2.1        3.24 ± 10%  perf-profile.calltrace.cycles-pp.creat64
      1.18 ±  4%      +2.1        3.23 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      1.18 ±  4%      +2.1        3.23 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      1.17 ±  3%      +2.1        3.23 ± 10%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      1.17 ±  3%      +2.1        3.23 ± 10%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      1.16 ±  4%      +2.1        3.22 ± 10%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.16 ±  4%      +2.1        3.22 ± 10%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      6.35 ± 15%      +2.2        8.52 ±  5%  perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.xfs_file_buffered_read.xfs_file_read_iter
      0.56 ±  4%      +2.2        2.74 ± 11%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +2.4        2.42 ± 11%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      1.41 ±  4%      +2.8        4.17 ± 15%  perf-profile.calltrace.cycles-pp.unlink
      1.40 ±  4%      +2.8        4.17 ± 15%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      1.40 ±  4%      +2.8        4.17 ± 15%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      1.39 ±  5%      +2.8        4.16 ± 15%  perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.96 ±  4%      +2.9        3.88 ± 16%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
     70.23            +3.1       73.32        perf-profile.calltrace.cycles-pp.read
     69.63            +3.3       72.94        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     69.52            +3.3       72.86        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     69.28            +3.4       72.70        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +3.5        3.50 ± 16%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     68.98            +3.5       72.50 ±  2%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     67.85            +4.0       71.83 ±  2%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     67.63           -14.9       52.75 ±  3%  perf-profile.children.cycles-pp.xfs_file_read_iter
     67.46           -14.8       52.68 ±  3%  perf-profile.children.cycles-pp.xfs_file_buffered_read
     32.78            -9.4       23.37 ±  5%  perf-profile.children.cycles-pp.xfs_ilock_iocb
     32.75            -9.4       23.35 ±  5%  perf-profile.children.cycles-pp.down_read
     34.01            -9.3       24.67 ±  5%  perf-profile.children.cycles-pp.xfs_ilock
     26.65 ±  2%      -7.1       19.56 ±  2%  perf-profile.children.cycles-pp.xfs_iunlock
     25.33 ±  2%      -6.6       18.72 ±  2%  perf-profile.children.cycles-pp.up_read
     23.13            -6.2       16.94 ±  2%  perf-profile.children.cycles-pp.write
     21.98            -5.8       16.22        perf-profile.children.cycles-pp.ksys_write
     21.69            -5.6       16.05        perf-profile.children.cycles-pp.vfs_write
     20.93            -5.4       15.56        perf-profile.children.cycles-pp.new_sync_write
     20.64            -5.3       15.35        perf-profile.children.cycles-pp.xfs_file_buffered_write
     15.71            -5.3       10.43 ±  2%  perf-profile.children.cycles-pp.iomap_file_buffered_write
     15.64            -5.3       10.38 ±  2%  perf-profile.children.cycles-pp.iomap_apply
     12.88            -4.7        8.14 ±  3%  perf-profile.children.cycles-pp.iomap_write_actor
      6.96            -2.3        4.70 ±  2%  perf-profile.children.cycles-pp.iomap_write_begin
      4.45            -2.0        2.46 ±  2%  perf-profile.children.cycles-pp.iomap_write_end
      5.11 ±  2%      -1.7        3.39        perf-profile.children.cycles-pp.grab_cache_page_write_begin
      5.03 ±  2%      -1.7        3.34        perf-profile.children.cycles-pp.pagecache_get_page
      3.02 ±  2%      -1.7        1.36 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      2.88 ±  2%      -1.6        1.27 ±  7%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      2.77 ±  2%      -1.6        1.19 ±  6%  perf-profile.children.cycles-pp.__close
      2.74 ±  2%      -1.6        1.18 ±  6%  perf-profile.children.cycles-pp.task_work_run
      2.74 ±  2%      -1.6        1.17 ±  6%  perf-profile.children.cycles-pp.__fput
      2.71 ±  2%      -1.6        1.15 ±  7%  perf-profile.children.cycles-pp.dput
      2.69 ±  2%      -1.6        1.13 ±  6%  perf-profile.children.cycles-pp.__dentry_kill
      2.22 ±  2%      -1.1        1.12 ±  7%  perf-profile.children.cycles-pp.evict
      2.21 ±  2%      -1.1        1.11 ±  7%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      2.71            -0.9        1.77 ±  2%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      2.39 ±  4%      -0.9        1.51 ± 10%  perf-profile.children.cycles-pp.iomap_set_range_uptodate
      1.71 ±  2%      -0.8        0.95        perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      1.11 ±  5%      -0.7        0.41 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.20            -0.6        0.58 ±  2%  perf-profile.children.cycles-pp.lru_cache_add
      1.03 ±  2%      -0.6        0.43 ±  5%  perf-profile.children.cycles-pp.__pagevec_lru_add
      1.03 ±  3%      -0.6        0.47 ±  6%  perf-profile.children.cycles-pp.release_pages
      0.96 ±  3%      -0.5        0.44 ±  6%  perf-profile.children.cycles-pp.__pagevec_release
      0.78 ±  9%      -0.5        0.26 ±  5%  perf-profile.children.cycles-pp.lock_page_lruvec_irqsave
      0.87 ±  2%      -0.4        0.44 ±  4%  perf-profile.children.cycles-pp.unlock_page
      1.15 ±  5%      -0.4        0.73 ±  4%  perf-profile.children.cycles-pp.up_write
      1.06 ±  6%      -0.4        0.67 ± 10%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      1.06 ±  7%      -0.4        0.68 ±  9%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.80 ±  9%      -0.4        0.44 ± 23%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.79 ±  9%      -0.4        0.43 ± 24%  perf-profile.children.cycles-pp.acpi_idle_do_entry
      2.08 ±  6%      -0.4        1.73 ±  6%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      2.23            -0.3        1.89 ±  2%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      1.49 ±  2%      -0.3        1.16 ±  4%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      0.60 ±  9%      -0.3        0.32 ± 17%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.87 ±  5%      -0.3        0.61 ±  9%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.68 ±  6%      -0.2        0.43 ±  9%  perf-profile.children.cycles-pp.copyout
      0.62 ±  4%      -0.2        0.39 ±  4%  perf-profile.children.cycles-pp.__set_page_dirty
      0.53 ±  3%      -0.2        0.29 ±  8%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.46 ±  4%      -0.2        0.23 ±  8%  perf-profile.children.cycles-pp.truncate_cleanup_page
      0.62 ±  6%      -0.2        0.40 ± 11%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.58 ±  7%      -0.2        0.37 ±  9%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.44 ±  4%      -0.2        0.24 ±  6%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.51 ±  7%      -0.2        0.33 ±  9%  perf-profile.children.cycles-pp.__entry_text_start
      0.54 ±  7%      -0.2        0.35 ±  7%  perf-profile.children.cycles-pp.security_file_permission
      0.76 ±  7%      -0.2        0.58 ±  9%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.45 ±  3%      -0.2        0.28 ±  6%  perf-profile.children.cycles-pp.xfs_inactive
      0.32 ±  3%      -0.2        0.15 ±  6%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.44 ±  6%      -0.2        0.27 ± 11%  perf-profile.children.cycles-pp.copyin
      0.33 ±  3%      -0.2        0.18 ±  8%  perf-profile.children.cycles-pp.__cancel_dirty_page
      0.31 ±  5%      -0.1        0.16 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.33 ±  3%      -0.1        0.18 ±  7%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.40 ±  8%      -0.1        0.25 ±  8%  perf-profile.children.cycles-pp.__fdget_pos
      0.57 ±  7%      -0.1        0.43 ±  6%  perf-profile.children.cycles-pp.___might_sleep
      0.33 ±  8%      -0.1        0.20 ±  9%  perf-profile.children.cycles-pp.__fget_light
      0.28 ±  4%      -0.1        0.16 ±  7%  perf-profile.children.cycles-pp.find_lock_entries
      0.30 ±  6%      -0.1        0.17 ±  4%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      0.23 ± 11%      -0.1        0.11 ± 16%  perf-profile.children.cycles-pp.rw_verify_area
      0.49 ± 10%      -0.1        0.37 ±  9%  perf-profile.children.cycles-pp.touch_atime
      0.43 ±  6%      -0.1        0.31 ± 12%  perf-profile.children.cycles-pp.xas_load
      0.38 ±  7%      -0.1        0.26 ±  8%  perf-profile.children.cycles-pp.common_file_perm
      0.36 ±  4%      -0.1        0.24 ±  7%  perf-profile.children.cycles-pp.xfs_inactive_ifree
      0.45 ± 10%      -0.1        0.34 ± 10%  perf-profile.children.cycles-pp.atime_needs_update
      0.35 ±  9%      -0.1        0.24 ±  6%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.33 ±  7%      -0.1        0.22 ± 10%  perf-profile.children.cycles-pp.__might_sleep
      0.29 ±  8%      -0.1        0.19 ± 10%  perf-profile.children.cycles-pp.__cond_resched
      0.34 ±  4%      -0.1        0.24 ±  6%  perf-profile.children.cycles-pp.vfs_unlink
      0.57 ±  7%      -0.1        0.47 ±  8%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.23 ±  6%      -0.1        0.13 ±  3%  perf-profile.children.cycles-pp.xfs_buf_get_map
      0.24 ±  7%      -0.1        0.13 ±  3%  perf-profile.children.cycles-pp.xfs_buf_read_map
      0.22 ±  7%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.xfs_buf_find
      0.54 ±  7%      -0.1        0.44 ±  9%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.33 ±  4%      -0.1        0.23 ±  7%  perf-profile.children.cycles-pp.xfs_remove
      0.33 ±  4%      -0.1        0.24 ±  8%  perf-profile.children.cycles-pp.xfs_vn_unlink
      0.19 ±  4%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.17 ±  8%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.26 ±  5%      -0.1        0.17 ±  7%  perf-profile.children.cycles-pp.xfs_ifree
      0.23 ±  6%      -0.1        0.15 ±  9%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.44 ±  5%      -0.1        0.36 ±  8%  perf-profile.children.cycles-pp.xfs_generic_create
      0.15 ±  9%      -0.1        0.07 ±  4%  perf-profile.children.cycles-pp.page_cache_free_page
      0.43 ±  5%      -0.1        0.35 ±  7%  perf-profile.children.cycles-pp.xfs_create
      0.18 ±  6%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.account_page_cleaned
      0.14 ± 10%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.uncharge_batch
      0.14 ± 10%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.21 ±  7%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.disk_cp
      0.45 ±  6%      -0.1        0.38 ±  7%  perf-profile.children.cycles-pp.__alloc_pages
      0.12 ±  8%      -0.1        0.05 ±  9%  perf-profile.children.cycles-pp.page_counter_cancel
      0.18 ±  4%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.__schedule
      0.10 ±  4%      -0.1        0.04 ± 40%  perf-profile.children.cycles-pp.xfs_iunlink_remove
      0.13 ±  5%      -0.1        0.07 ±  9%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.19 ±  9%      -0.1        0.13 ± 10%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.12 ±  9%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.xfs_read_agi
      0.14 ±  7%      -0.1        0.08 ± 13%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.16 ±  6%      -0.1        0.11 ± 11%  perf-profile.children.cycles-pp.aa_file_perm
      0.12 ±  8%      -0.1        0.06 ± 16%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.24 ± 11%      -0.1        0.19 ± 13%  perf-profile.children.cycles-pp.scheduler_tick
      0.13 ±  8%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.xfs_da_read_buf
      0.12 ±  6%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.14 ±  7%      -0.1        0.09 ±  9%  perf-profile.children.cycles-pp.map_id_range_down
      0.14 ±  9%      -0.0        0.09 ± 11%  perf-profile.children.cycles-pp.rcu_all_qs
      0.13 ±  6%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_end
      0.13 ±  5%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.xfs_dir_removename
      0.13 ±  7%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.xfs_dir2_node_removename
      0.13 ±  5%      -0.0        0.09 ±  3%  perf-profile.children.cycles-pp.schedule
      0.14 ±  9%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.xfs_da3_node_lookup_int
      0.22 ±  5%      -0.0        0.18 ± 10%  perf-profile.children.cycles-pp.memset_erms
      0.07 ±  7%      -0.0        0.03 ± 86%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.12 ±  8%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.15 ±  6%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.10 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.12 ±  4%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.generic_write_checks
      0.09 ±  9%      -0.0        0.06 ± 10%  perf-profile.children.cycles-pp.__might_fault
      0.09 ±  7%      -0.0        0.06 ± 10%  perf-profile.children.cycles-pp.make_kuid
      0.08 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.xfs_dir2_node_addname
      0.09 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.xfs_dir_createname
      0.09 ±  8%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.make_kgid
      0.10 ± 10%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.update_load_avg
      0.09 ±  6%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.timestamp_truncate
      0.08 ± 10%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.xfs_da3_node_read
      0.07 ±  8%      -0.0        0.04 ± 40%  perf-profile.children.cycles-pp.xfs_btree_lookup
      0.10 ±  8%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.xfs_bmbt_to_iomap
      0.10 ± 11%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.node_dirty_ok
      0.11 ±  8%      -0.0        0.09 ± 12%  perf-profile.children.cycles-pp.xfs_errortag_test
      0.08 ±  4%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.free_unref_page_list
      0.10 ±  5%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.xfs_difree_inobt
      0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.load_balance
      0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.find_busiest_group
      0.08 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.07            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.xfs_vn_lookup
      0.08 ±  5%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.page_mapping
      0.06 ±  7%      -0.0        0.05 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.07            -0.0        0.06 ±  5%  perf-profile.children.cycles-pp.newidle_balance
      0.26 ±  3%      +0.0        0.30 ±  2%  perf-profile.children.cycles-pp.xas_store
      0.52 ±  6%      +0.1        0.65 ± 11%  perf-profile.children.cycles-pp.xfs_break_layouts
      0.43 ±  8%      +0.2        0.59 ± 13%  perf-profile.children.cycles-pp.xfs_break_leased_layouts
      2.70 ±  4%      +0.2        2.88 ±  3%  perf-profile.children.cycles-pp.xfs_vn_update_time
      3.70 ±  2%      +0.2        3.90 ±  2%  perf-profile.children.cycles-pp.xfs_file_write_checks
      0.00            +0.3        0.28 ±  6%  perf-profile.children.cycles-pp.xfs_inodegc_worker
      0.00            +0.3        0.29 ±  6%  perf-profile.children.cycles-pp.worker_thread
      0.00            +0.3        0.29 ±  6%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.3        0.30 ±  5%  perf-profile.children.cycles-pp.kthread
      0.00            +0.3        0.30 ±  6%  perf-profile.children.cycles-pp.ret_from_fork
     97.43            +0.6       98.08        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     97.24            +0.7       97.94        perf-profile.children.cycles-pp.do_syscall_64
      5.54 ± 15%      +1.8        7.35 ±  4%  perf-profile.children.cycles-pp.filemap_get_read_batch
      5.75 ± 15%      +2.0        7.77 ±  4%  perf-profile.children.cycles-pp.filemap_get_pages
      1.23 ±  4%      +2.0        3.27 ± 10%  perf-profile.children.cycles-pp.do_sys_open
      1.23 ±  4%      +2.0        3.27 ± 10%  perf-profile.children.cycles-pp.do_sys_openat2
      1.21 ±  4%      +2.1        3.26 ± 10%  perf-profile.children.cycles-pp.path_openat
      1.21 ±  4%      +2.1        3.26 ± 10%  perf-profile.children.cycles-pp.do_filp_open
      1.18 ±  4%      +2.1        3.24 ± 10%  perf-profile.children.cycles-pp.creat64
      1.41 ±  4%      +2.8        4.17 ± 15%  perf-profile.children.cycles-pp.unlink
      1.39 ±  5%      +2.8        4.16 ± 15%  perf-profile.children.cycles-pp.do_unlinkat
     70.44            +3.0       73.45        perf-profile.children.cycles-pp.read
     69.30            +3.4       72.72        perf-profile.children.cycles-pp.ksys_read
     69.01            +3.5       72.52 ±  2%  perf-profile.children.cycles-pp.vfs_read
     67.87            +4.0       71.90 ±  2%  perf-profile.children.cycles-pp.new_sync_read
      1.52 ±  4%      +5.1        6.63 ± 13%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.54 ±  5%      +5.4        5.93 ± 14%  perf-profile.children.cycles-pp.osq_lock
     32.46            -9.3       23.16 ±  5%  perf-profile.self.cycles-pp.down_read
     25.18 ±  2%      -6.6       18.62 ±  2%  perf-profile.self.cycles-pp.up_read
      2.37 ±  4%      -0.9        1.50 ± 10%  perf-profile.self.cycles-pp.iomap_set_range_uptodate
      1.44 ±  6%      -0.6        0.89 ±  5%  perf-profile.self.cycles-pp.pagecache_get_page
      0.85 ±  2%      -0.4        0.44 ±  4%  perf-profile.self.cycles-pp.unlock_page
      1.12 ±  5%      -0.4        0.72 ±  4%  perf-profile.self.cycles-pp.up_write
      1.05 ±  6%      -0.4        0.66 ± 10%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.73 ±  2%      -0.4        0.36        perf-profile.self.cycles-pp.iomap_write_end
      2.08 ±  6%      -0.4        1.73 ±  6%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.64 ±  2%      -0.3        0.32 ±  3%  perf-profile.self.cycles-pp.__set_page_dirty_nobuffers
      0.58 ±  9%      -0.3        0.31 ± 17%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.86 ±  6%      -0.3        0.61 ±  9%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.57 ±  7%      -0.2        0.37 ± 10%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.74 ±  3%      -0.2        1.53 ±  2%  perf-profile.self.cycles-pp.filemap_read
      0.37 ±  4%      -0.2        0.17 ±  4%  perf-profile.self.cycles-pp.__pagevec_lru_add
      0.43 ±  9%      -0.2        0.23 ± 23%  perf-profile.self.cycles-pp.acpi_idle_do_entry
      0.37 ±  4%      -0.2        0.18        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.31 ±  5%      -0.2        0.14 ±  7%  perf-profile.self.cycles-pp.release_pages
      0.31 ±  4%      -0.2        0.14 ±  5%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.30 ±  6%      -0.1        0.16 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.40 ±  6%      -0.1        0.28 ±  8%  perf-profile.self.cycles-pp.iomap_apply
      0.22 ± 11%      -0.1        0.10 ± 18%  perf-profile.self.cycles-pp.rw_verify_area
      0.26 ±  6%      -0.1        0.14 ±  8%  perf-profile.self.cycles-pp.find_lock_entries
      0.32 ±  9%      -0.1        0.19 ±  8%  perf-profile.self.cycles-pp.__fget_light
      0.51 ±  7%      -0.1        0.40 ±  7%  perf-profile.self.cycles-pp.___might_sleep
      0.25 ±  3%      -0.1        0.14 ±  7%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.18 ± 32%      -0.1        0.08 ± 35%  perf-profile.self.cycles-pp.xfs_file_read_iter
      0.24 ±  6%      -0.1        0.14 ±  2%  perf-profile.self.cycles-pp.__add_to_page_cache_locked
      0.24 ±  8%      -0.1        0.15 ±  9%  perf-profile.self.cycles-pp.read
      0.29 ±  9%      -0.1        0.20 ±  9%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_begin
      0.39 ±  3%      -0.1        0.29 ±  3%  perf-profile.self.cycles-pp.iomap_write_begin
      0.26 ±  6%      -0.1        0.17 ± 13%  perf-profile.self.cycles-pp.vfs_write
      0.26 ±  6%      -0.1        0.17 ± 10%  perf-profile.self.cycles-pp.xas_load
      0.22 ±  9%      -0.1        0.14 ±  8%  perf-profile.self.cycles-pp.write
      0.22 ±  7%      -0.1        0.14 ± 10%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.27 ±  7%      -0.1        0.19 ± 11%  perf-profile.self.cycles-pp.__might_sleep
      0.19 ± 26%      -0.1        0.11 ± 19%  perf-profile.self.cycles-pp.vfs_read
      0.15 ±  9%      -0.1        0.07 ±  4%  perf-profile.self.cycles-pp.page_cache_free_page
      0.20 ±  8%      -0.1        0.13 ±  8%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.13 ±  2%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.__cancel_dirty_page
      0.20 ±  8%      -0.1        0.12 ±  7%  perf-profile.self.cycles-pp.xfs_iunlock
      0.12 ±  8%      -0.1        0.05 ±  9%  perf-profile.self.cycles-pp.page_counter_cancel
      0.11 ±  9%      -0.1        0.04 ± 40%  perf-profile.self.cycles-pp.truncate_cleanup_page
      0.22 ±  8%      -0.1        0.15 ±  8%  perf-profile.self.cycles-pp.common_file_perm
      0.21 ±  6%      -0.1        0.14 ± 10%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.22 ±  4%      -0.1        0.16 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.10 ±  3%      -0.1        0.04 ± 63%  perf-profile.self.cycles-pp.ksys_write
      0.14 ± 17%      -0.1        0.08 ± 13%  perf-profile.self.cycles-pp.security_file_permission
      0.19 ±  7%      -0.1        0.13 ± 11%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.12 ±  7%      -0.1        0.07 ±  6%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.18 ± 10%      -0.1        0.12 ±  9%  perf-profile.self.cycles-pp.disk_cp
      0.20 ±  7%      -0.1        0.15 ± 10%  perf-profile.self.cycles-pp.iomap_write_actor
      0.15 ±  9%      -0.1        0.10 ± 12%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.15 ±  8%      -0.1        0.09 ± 12%  perf-profile.self.cycles-pp.__cond_resched
      0.16 ±  6%      -0.1        0.11 ±  9%  perf-profile.self.cycles-pp.xfs_ilock
      0.14 ±  4%      -0.0        0.09 ± 11%  perf-profile.self.cycles-pp.do_syscall_64
      0.13 ±  8%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.new_sync_write
      0.18 ±  5%      -0.0        0.13 ± 11%  perf-profile.self.cycles-pp.lru_cache_add
      0.14 ±  7%      -0.0        0.09 ± 11%  perf-profile.self.cycles-pp.__entry_text_start
      0.16 ± 11%      -0.0        0.11 ± 10%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      0.13 ±  9%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.map_id_range_down
      0.14 ±  8%      -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.aa_file_perm
      0.07 ±  9%      -0.0        0.03 ± 86%  perf-profile.self.cycles-pp.xfs_break_layouts
      0.21 ±  5%      -0.0        0.17 ±  9%  perf-profile.self.cycles-pp.memset_erms
      0.08 ±  8%      -0.0        0.04 ± 41%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_end
      0.12 ±  6%      -0.0        0.08 ± 11%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.07 ±  9%      -0.0        0.04 ± 63%  perf-profile.self.cycles-pp.iomap_file_buffered_write
      0.09 ±  7%      -0.0        0.06 ± 12%  perf-profile.self.cycles-pp.rcu_all_qs
      0.09 ± 10%      -0.0        0.05 ±  9%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.10 ±  5%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.ksys_read
      0.08 ±  7%      -0.0        0.05 ± 40%  perf-profile.self.cycles-pp.xfs_file_buffered_read
      0.09 ±  7%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.xfs_file_write_checks
      0.10 ± 10%      -0.0        0.07 ±  9%  perf-profile.self.cycles-pp.xfs_file_write_iter
      0.10 ± 10%      -0.0        0.07 ±  9%  perf-profile.self.cycles-pp.xfs_bmbt_to_iomap
      0.08 ±  4%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.timestamp_truncate
      0.09 ±  7%      -0.0        0.07 ±  9%  perf-profile.self.cycles-pp.xfs_errortag_test
      0.13 ±  5%      +0.0        0.16 ±  7%  perf-profile.self.cycles-pp.xas_store
      0.01 ±223%      +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.mem_cgroup_charge
      0.42 ±  8%      +0.2        0.57 ± 13%  perf-profile.self.cycles-pp.xfs_break_leased_layouts
      0.91 ±  7%      +0.2        1.08 ±  6%  perf-profile.self.cycles-pp.down_write
      1.05 ± 16%      +0.6        1.62 ± 11%  perf-profile.self.cycles-pp.filemap_get_pages
      0.53 ±  5%      +5.4        5.90 ± 14%  perf-profile.self.cycles-pp.osq_lock
      0.21 ± 10%     +18.8       19.05 ±  3%  perf-profile.self.cycles-pp.new_sync_read





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.14.0-rc4-00009-gab23a7768739"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.14.0-rc4 Kernel Configuration
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
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
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
CONFIG_TIME_KUNIT_TEST=m

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
# CONFIG_SCHED_CORE is not set

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
CONFIG_ACPI_PRMT=y

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
CONFIG_HAVE_KVM_PM_NOTIFIER=y
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
CONFIG_ARCH_WANTS_NO_INSTR=y
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
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_FC_APPID is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
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
CONFIG_MQ_IOSCHED_DEADLINE_CGROUP=y
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
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
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
CONFIG_SECRETMEM=y
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
# CONFIG_NETFILTER_NETLINK_HOOK is not set
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
CONFIG_AUXILIARY_BUS=y
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
# CONFIG_SCSI_MPI3MR is not set
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
# CONFIG_SCSI_EFCT is not set
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
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
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
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
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
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
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

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

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
# CONFIG_XILLYUSB is not set
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
# CONFIG_BATTERY_RT5033 is not set
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
# CONFIG_SENSORS_DPS920AB is not set
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
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PIM4328 is not set
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
# CONFIG_SENSORS_SHT4x is not set
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
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

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
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
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
# CONFIG_VIDEO_IMX208 is not set
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
# CONFIG_DRM_SIMPLEDRM is not set
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
# CONFIG_DRM_HYPERV is not set
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
# CONFIG_FB_SSD1307 is not set
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
CONFIG_LEDS_LT3593=m
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
# CONFIG_WIRELESS_HOTKEY is not set
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
# CONFIG_THINKPAD_LMI is not set
CONFIG_X86_PLATFORM_DRIVERS_INTEL=y
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
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Clock driver for ARM Reference designs
#
# CONFIG_ICST is not set
# CONFIG_CLK_SP810 is not set
# end of Clock driver for ARM Reference designs

# CONFIG_LMK04832 is not set
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
# CONFIG_VIRTIO_IOMMU is not set

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
# CONFIG_PHY_CAN_TRANSCEIVER is not set
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
CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
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
CONFIG_CIFS_STATS2=y
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
# CONFIG_IMA_DISABLE_HTABLE is not set
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
# CONFIG_STACKTRACE_BUILD_ID is not set
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
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
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
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
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
CONFIG_RATIONAL_KUNIT_TEST=m
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
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='aim7'
	export testcase='aim7'
	export category='benchmark'
	export job_origin='aim7-fs-1brd.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-cpl-4sp1'
	export tbox_group='lkp-cpl-4sp1'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='6114f126b678c076499fa88a'
	export job_file='/lkp/jobs/scheduled/lkp-cpl-4sp1/aim7-performance-1BRD_48G-xfs-3000-disk_rr-ucode=0x700001e-debian-10.4-x86_64-20200603.cgz-ab23a7768739a23d21d8a16ca37dff96b1ca9-20210812-30281-zx7tv5-3.yaml'
	export id='67ae64f4e4b2f630217a98aceaef1b579b5fc762'
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
	export commit='ab23a7768739a23d21d8a16ca37dff96b1ca957a'
	export need_kconfig_hw='{"IGB"=>"y"}
SATA_AHCI'
	export ucode='0x700001e'
	export bisect_dmesg=true
	export need_kconfig='{"BLK_DEV_RAM"=>"m"}
{"BLK_DEV"=>"y"}
{"BLOCK"=>"y"}
XFS_FS'
	export enqueue_time='2021-08-12 18:00:07 +0800'
	export _id='6114f126b678c076499fa88a'
	export _rt='/result/aim7/performance-1BRD_48G-xfs-3000-disk_rr-ucode=0x700001e/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/ab23a7768739a23d21d8a16ca37dff96b1ca957a'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='bd75a11895b6f1ee44c37aa9511747b3c26419e2'
	export base_commit='36a21d51725af2ce0700c6ebcb6b9594aac658a6'
	export branch='linux-next/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/aim7/performance-1BRD_48G-xfs-3000-disk_rr-ucode=0x700001e/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/ab23a7768739a23d21d8a16ca37dff96b1ca957a/3'
	export scheduler_version='/lkp/lkp/.src-20210812-163246'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-cpl-4sp1/aim7-performance-1BRD_48G-xfs-3000-disk_rr-ucode=0x700001e-debian-10.4-x86_64-20200603.cgz-ab23a7768739a23d21d8a16ca37dff96b1ca9-20210812-30281-zx7tv5-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-next/master
commit=ab23a7768739a23d21d8a16ca37dff96b1ca957a
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/ab23a7768739a23d21d8a16ca37dff96b1ca957a/vmlinuz-5.14.0-rc4-00009-gab23a7768739
acpi_rsdp=0x695fd014
max_uptime=2100
RESULT_ROOT=/result/aim7/performance-1BRD_48G-xfs-3000-disk_rr-ucode=0x700001e/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/ab23a7768739a23d21d8a16ca37dff96b1ca957a/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/ab23a7768739a23d21d8a16ca37dff96b1ca957a/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20210621.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-85a90500f9a1-1_20210807.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/aim7-x86_64-1-1_20210701.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.14.0-rc4-00023-g46c4c9d1beb7'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/ab23a7768739a23d21d8a16ca37dff96b1ca957a/vmlinuz-5.14.0-rc4-00009-gab23a7768739'
	export dequeue_time='2021-08-12 18:01:58 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-cpl-4sp1/aim7-performance-1BRD_48G-xfs-3000-disk_rr-ucode=0x700001e-debian-10.4-x86_64-20200603.cgz-ab23a7768739a23d21d8a16ca37dff96b1ca9-20210812-30281-zx7tv5-3.cgz'

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

	run_setup nr_brd=1 ramdisk_size=51539607552 $LKP_SRC/setup/disk

	run_setup fs='xfs' $LKP_SRC/setup/fs

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor delay=15 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
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

	run_test test='disk_rr' load=3000 $LKP_SRC/tests/wrapper aim7
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env delay=15 $LKP_SRC/stats/wrapper perf-profile
	env test='disk_rr' load=3000 $LKP_SRC/stats/wrapper aim7
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

	$LKP_SRC/stats/wrapper time aim7.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/aim7-fs-1brd.yaml:
suite: aim7
testcase: aim7
category: benchmark
perf-profile:
  delay: 15
disk: 1BRD_48G
fs: xfs
aim7:
  test: disk_rr
  load: 3000
job_origin: aim7-fs-1brd.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-cpl-4sp1
tbox_group: lkp-cpl-4sp1
kconfig: x86_64-rhel-8.3
submit_id: 6114dafc2ed9ad34330b7aa9
job_file: "/lkp/jobs/scheduled/lkp-cpl-4sp1/aim7-performance-1BRD_48G-xfs-3000-disk_rr-ucode=0x700001e-debian-10.4-x86_64-20200603.cgz-ab23a7768739a23d21d8a16ca37dff96b1ca9-20210812-13363-1lxpna6-1.yaml"
id: beb65e6b03aa289b9908c09e52bb8a589ab290eb
queuer_version: "/lkp-src"
:#! hosts/lkp-cpl-4sp1:
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
:#! include/category/ALL:
cpufreq_governor: performance
:#! include/queue/cyclic:
commit: ab23a7768739a23d21d8a16ca37dff96b1ca957a
:#! include/testbox/lkp-cpl-4sp1:
need_kconfig_hw:
- IGB: y
- SATA_AHCI
ucode: '0x700001e'
bisect_dmesg: true
:#! include/disk/nr_brd:
need_kconfig:
- BLK_DEV_RAM: m
- BLK_DEV: y
- BLOCK: y
- XFS_FS
:#! include/fs/OTHERS:
enqueue_time: 2021-08-12 16:25:32.934377820 +08:00
_id: 6114e2622ed9ad34330b7aaa
_rt: "/result/aim7/performance-1BRD_48G-xfs-3000-disk_rr-ucode=0x700001e/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/ab23a7768739a23d21d8a16ca37dff96b1ca957a"
:#! schedule options:
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: bd75a11895b6f1ee44c37aa9511747b3c26419e2
base_commit: 36a21d51725af2ce0700c6ebcb6b9594aac658a6
branch: linux-devel/devel-hourly-20210812-020016
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/aim7/performance-1BRD_48G-xfs-3000-disk_rr-ucode=0x700001e/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/ab23a7768739a23d21d8a16ca37dff96b1ca957a/0"
scheduler_version: "/lkp/lkp/.src-20210812-163246"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-cpl-4sp1/aim7-performance-1BRD_48G-xfs-3000-disk_rr-ucode=0x700001e-debian-10.4-x86_64-20200603.cgz-ab23a7768739a23d21d8a16ca37dff96b1ca9-20210812-13363-1lxpna6-1.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210812-020016
- commit=ab23a7768739a23d21d8a16ca37dff96b1ca957a
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/ab23a7768739a23d21d8a16ca37dff96b1ca957a/vmlinuz-5.14.0-rc4-00009-gab23a7768739
- acpi_rsdp=0x695fd014
- max_uptime=2100
- RESULT_ROOT=/result/aim7/performance-1BRD_48G-xfs-3000-disk_rr-ucode=0x700001e/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/ab23a7768739a23d21d8a16ca37dff96b1ca957a/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/ab23a7768739a23d21d8a16ca37dff96b1ca957a/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20210621.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-85a90500f9a1-1_20210807.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/aim7-x86_64-1-1_20210701.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /lkp/lkp/.src-20210810-191416/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.14.0-rc5-intel-next-01008-g0edc5ac1bc19
repeat_to: 3
:#! user overrides:
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/ab23a7768739a23d21d8a16ca37dff96b1ca957a/vmlinuz-5.14.0-rc4-00009-gab23a7768739"
dequeue_time: 2021-08-12 17:02:08.736671775 +08:00
:#! /lkp/lkp/.src-20210812-163246/include/site/inn:
job_state: finished
loadavg: 910.61 270.42 93.13 2/1265 12891
start_time: '1628759010'
end_time: '1628759054'
version: "/lkp/lkp/.src-20210812-163321:e4a96d12:d323b4484"

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "modprobe" "-r" "brd"
 "modprobe" "brd" "rd_nr=1" "rd_size=50331648"
dmsetup remove_all
wipefs -a --force /dev/ram0
mkfs -t xfs -f /dev/ram0
mkdir -p /fs/ram0
mount -t xfs -o inode64 /dev/ram0 /fs/ram0

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

echo "500 32000 128 512" > /proc/sys/kernel/sem
cat > workfile <<EOF
FILESIZE: 1M
POOLSIZE: 10M
10 disk_rr
EOF
echo "/fs/ram0" > config

	(
		echo lkp-cpl-4sp1
		echo disk_rr

		echo 1
		echo 3000
		echo 2
		echo 3000
		echo 1
	) | ./multitask -t &

--ew6BAiZeqk4r7MaW--
