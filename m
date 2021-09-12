Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D24407E02
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 17:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhILPg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 11:36:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:37173 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhILPgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 11:36:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10105"; a="307025789"
X-IronPort-AV: E=Sophos;i="5.85,287,1624345200"; 
   d="yaml'?scan'208";a="307025789"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2021 08:35:07 -0700
X-IronPort-AV: E=Sophos;i="5.85,287,1624345200"; 
   d="yaml'?scan'208";a="550847961"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2021 08:35:03 -0700
Date:   Sun, 12 Sep 2021 23:52:28 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com
Subject: [ext4]  cc883236b7:  aim7.jobs-per-min 69.4% improvement
Message-ID: <20210912155227.GH25450@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nOM8ykUjac0mNN89"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Greeting,

FYI, we noticed a 69.4% improvement of aim7.jobs-per-min due to commit:


commit: cc883236b79297f6266ca6f4e7f24f3fd3c736c1 ("ext4: drop unnecessary journal handle in delalloc write")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master


in testcase: aim7
on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
with following parameters:

	disk: 4BRD_12G
	md: RAID0
	fs: ext4
	test: disk_rw
	load: 3000
	cpufreq_governor: performance
	ucode: 0x5003006

test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/

In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min 83.1% improvement                                       |
| test machine     | 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                                    |
|                  | disk=4BRD_12G                                                                   |
|                  | fs=ext4                                                                         |
|                  | load=3000                                                                       |
|                  | md=RAID1                                                                        |
|                  | test=disk_rw                                                                    |
|                  | ucode=0x5003006                                                                 |
+------------------+---------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min 68.6% improvement                                       |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz with 256G memory |
| test parameters  | cpufreq_governor=performance                                                    |
|                  | disk=1BRD_48G                                                                   |
|                  | fs=ext4                                                                         |
|                  | load=3000                                                                       |
|                  | test=disk_rw                                                                    |
|                  | ucode=0xd000280                                                                 |
+------------------+---------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in this email
        bin/lkp split-job --compatible job.yaml  # generate the yaml file for lkp run
        bin/lkp run                    generated-yaml-file

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/4BRD_12G/ext4/x86_64-rhel-8.3/3000/RAID0/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp9/disk_rw/aim7/0x5003006

commit: 
  6984aef598 ("ext4: factor out write end code of inline file")
  cc883236b7 ("ext4: drop unnecessary journal handle in delalloc write")

6984aef59814fb5c cc883236b79297f6266ca6f4e7f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     84031           +69.4%     142324 ± 10%  aim7.jobs-per-min
    214.46           -40.2%     128.30 ± 11%  aim7.time.elapsed_time
    214.46           -40.2%     128.30 ± 11%  aim7.time.elapsed_time.max
   1745045 ±  3%     -56.9%     751261 ± 14%  aim7.time.involuntary_context_switches
    227826           -12.0%     200495 ±  2%  aim7.time.minor_page_faults
     17669           -42.4%      10174 ± 12%  aim7.time.system_time
    185912           -35.5%     119833 ± 12%  aim7.time.voluntary_context_switches
    253.24           -33.9%     167.34 ±  8%  uptime.boot
      6.27 ±  2%     +64.2%      10.29 ± 10%  iostat.cpu.idle
     93.31            -4.6%      89.05        iostat.cpu.system
      5.42 ±  2%      +3.6        8.98 ± 10%  mpstat.cpu.all.idle%
      0.03 ±  4%      +0.0        0.05 ±  9%  mpstat.cpu.all.soft%
      0.42 ±  2%      +0.2        0.65 ± 11%  mpstat.cpu.all.usr%
      5.28 ±  8%     +65.5%       8.74 ± 12%  turbostat.CPU%c1
  39514227           -38.5%   24314676 ± 11%  turbostat.IRQ
    209.72            +2.1%     214.03        turbostat.PkgWatt
     58.24            +4.1%      60.65 ±  2%  turbostat.RAMWatt
      6306 ±  2%     +32.9%       8378 ± 10%  vmstat.io.bo
    235.67 ±  3%     -26.2%     174.00 ±  5%  vmstat.procs.r
     10672           -20.9%       8447 ±  2%  vmstat.system.cs
    181822            +2.1%     185699        vmstat.system.in
     45728 ± 87%     -81.4%       8490 ±115%  numa-meminfo.node0.Active
     44135 ± 90%     -84.7%       6753 ±145%  numa-meminfo.node0.Active(anon)
    214827 ± 18%     -47.4%     112949 ± 23%  numa-meminfo.node1.Active
    214412 ± 18%     -47.4%     112749 ± 23%  numa-meminfo.node1.Active(anon)
    248902 ± 19%     -43.8%     139818 ± 28%  numa-meminfo.node1.Shmem
     11057 ± 90%     -84.9%       1673 ±145%  numa-vmstat.node0.nr_active_anon
     11057 ± 90%     -84.9%       1673 ±145%  numa-vmstat.node0.nr_zone_active_anon
     53560 ± 18%     -47.5%      28137 ± 23%  numa-vmstat.node1.nr_active_anon
     62229 ± 19%     -43.9%      34907 ± 28%  numa-vmstat.node1.nr_shmem
     44653 ± 54%     -68.4%      14127 ± 22%  numa-vmstat.node1.nr_written
     53560 ± 18%     -47.5%      28137 ± 23%  numa-vmstat.node1.nr_zone_active_anon
    365566           +17.6%     429985 ±  9%  slabinfo.buffer_head.active_objs
      9615           +17.0%      11250 ±  9%  slabinfo.buffer_head.active_slabs
    375022           +17.0%     438782 ±  9%  slabinfo.buffer_head.num_objs
      9615           +17.0%      11250 ±  9%  slabinfo.buffer_head.num_slabs
    832.17 ±  8%     +26.0%       1048 ± 10%  slabinfo.ext4_allocation_context.active_objs
    832.17 ±  8%     +26.0%       1048 ± 10%  slabinfo.ext4_allocation_context.num_objs
    260004 ±  2%     -53.1%     121893 ± 25%  meminfo.Active
    257996 ±  2%     -53.5%     119954 ± 25%  meminfo.Active(anon)
    158816           -20.4%     126416 ±  7%  meminfo.AnonHugePages
   1422103           +17.2%    1666680 ±  9%  meminfo.Dirty
   1829940           +13.8%    2082407 ±  7%  meminfo.Inactive
   1421940           +17.2%    1666440 ±  9%  meminfo.Inactive(file)
     80986 ±  3%     +15.1%      93190 ±  8%  meminfo.Mapped
    301698 ±  2%     -42.5%     173451 ± 19%  meminfo.Shmem
     64570 ±  2%     -53.5%      30001 ± 25%  proc-vmstat.nr_active_anon
    355378           +17.1%     416259 ±  9%  proc-vmstat.nr_dirty
    101865            +2.1%     103985        proc-vmstat.nr_inactive_anon
    355356           +17.1%     416206 ±  9%  proc-vmstat.nr_inactive_file
     60333            -1.8%      59275        proc-vmstat.nr_kernel_stack
     20124 ±  4%     +16.7%      23476 ±  7%  proc-vmstat.nr_mapped
     27011 ±  4%      -8.9%      24613 ±  4%  proc-vmstat.nr_page_table_pages
     75383 ±  2%     -42.5%      43365 ± 18%  proc-vmstat.nr_shmem
    141415 ±  6%     -49.3%      71729 ±  9%  proc-vmstat.nr_written
     64570 ±  2%     -53.5%      30001 ± 25%  proc-vmstat.nr_zone_active_anon
    101865            +2.1%     103985        proc-vmstat.nr_zone_inactive_anon
    355356           +17.1%     416206 ±  9%  proc-vmstat.nr_zone_inactive_file
    356750           +16.9%     417166 ±  9%  proc-vmstat.nr_zone_write_pending
     82578 ±  3%     -36.5%      52451 ± 19%  proc-vmstat.numa_hint_faults
     49387 ±  9%     -43.6%      27869 ± 33%  proc-vmstat.numa_hint_faults_local
     39256 ± 20%     -30.6%      27262 ± 23%  proc-vmstat.numa_pages_migrated
    232761 ±  6%     -27.1%     169589 ± 11%  proc-vmstat.numa_pte_updates
   1026316           -22.1%     799210 ±  4%  proc-vmstat.pgfault
     39256 ± 20%     -30.6%      27262 ± 23%  proc-vmstat.pgmigrate_success
   1371564 ±  2%     -20.8%    1086294 ±  2%  proc-vmstat.pgpgout
     53581 ±  2%     -33.5%      35634 ±  8%  proc-vmstat.pgreuse
     10524 ±  7%     -27.8%       7596 ±  5%  softirqs.CPU0.RCU
      8512 ±  9%     -28.7%       6072 ±  8%  softirqs.CPU10.RCU
      8964 ± 18%     -38.0%       5555 ± 12%  softirqs.CPU12.RCU
      6385 ± 26%     -27.6%       4622 ±  8%  softirqs.CPU18.SCHED
      9340 ± 16%     -42.5%       5372 ± 11%  softirqs.CPU20.RCU
      8995 ±  8%     -36.7%       5692 ±  7%  softirqs.CPU22.RCU
      8573 ±  9%     -39.4%       5195 ±  8%  softirqs.CPU26.RCU
      8932 ± 10%     -41.8%       5200 ±  9%  softirqs.CPU30.RCU
      8698 ± 10%     -40.0%       5222 ± 11%  softirqs.CPU32.RCU
      8598 ± 10%     -38.0%       5335 ± 12%  softirqs.CPU37.RCU
      8730 ± 13%     -38.4%       5376 ±  9%  softirqs.CPU39.RCU
      8861 ± 15%     -40.1%       5307 ± 10%  softirqs.CPU40.RCU
      8754 ± 12%     -32.5%       5908 ± 18%  softirqs.CPU57.RCU
      8620 ±  8%     -39.5%       5218 ±  9%  softirqs.CPU66.RCU
      9140 ± 20%     -41.4%       5353 ±  7%  softirqs.CPU7.RCU
      8521 ± 12%     -39.3%       5174 ± 13%  softirqs.CPU79.RCU
      8213 ± 12%     -39.8%       4945 ± 10%  softirqs.CPU85.RCU
      8471 ± 16%     -36.8%       5352 ±  6%  softirqs.CPU87.RCU
    747464 ±  6%     -34.9%     486676 ±  7%  softirqs.RCU
    490039           -16.0%     411771 ±  3%  softirqs.SCHED
     43647           -32.7%      29392 ±  8%  softirqs.TIMER
 3.105e+09           +48.0%  4.595e+09 ± 10%  perf-stat.i.branch-instructions
  21161802           +46.5%   30992355 ±  8%  perf-stat.i.branch-misses
  76855682           +39.9%  1.075e+08 ± 32%  perf-stat.i.cache-misses
 2.273e+08           +41.0%  3.206e+08 ± 30%  perf-stat.i.cache-references
     10701           -21.7%       8375 ±  2%  perf-stat.i.context-switches
     14.25           -35.5%       9.19 ± 12%  perf-stat.i.cpi
  2.32e+11            -4.0%  2.227e+11        perf-stat.i.cpu-cycles
 4.837e+09           +46.7%  7.094e+09 ± 10%  perf-stat.i.dTLB-loads
     53942 ±  6%     +25.8%      67839 ± 10%  perf-stat.i.dTLB-store-misses
 2.553e+09           +47.1%  3.757e+09 ± 10%  perf-stat.i.dTLB-stores
     96.08            -1.5       94.54        perf-stat.i.iTLB-load-miss-rate%
  17793060 ±  2%     +23.4%   21959165 ±  9%  perf-stat.i.iTLB-load-misses
 1.579e+10           +48.1%  2.339e+10 ± 10%  perf-stat.i.instructions
    998.65 ±  2%     +23.2%       1230 ±  5%  perf-stat.i.instructions-per-iTLB-miss
      0.09 ±  4%     +54.0%       0.14 ± 12%  perf-stat.i.ipc
      2.64            -3.9%       2.53        perf-stat.i.metric.GHz
    232.58 ±  4%     +41.5%     329.21 ± 18%  perf-stat.i.metric.K/sec
    121.77           +47.2%     179.19 ±  9%  perf-stat.i.metric.M/sec
      4377           +26.3%       5527 ±  5%  perf-stat.i.minor-faults
   7960108 ±  3%     +66.9%   13285764 ± 41%  perf-stat.i.node-load-misses
   2695393           +33.0%    3585635 ± 19%  perf-stat.i.node-loads
     66.20            -3.9       62.25 ±  2%  perf-stat.i.node-store-miss-rate%
   5733707           +11.2%    6373577        perf-stat.i.node-store-misses
   2794313           +29.4%    3615704 ±  5%  perf-stat.i.node-stores
      4380           +26.3%       5532 ±  5%  perf-stat.i.page-faults
     14.72           -34.4%       9.65 ± 12%  perf-stat.overall.cpi
      3024 ±  2%     -25.3%       2257 ± 25%  perf-stat.overall.cycles-between-cache-misses
      0.01 ±  9%      -0.0        0.01 ± 13%  perf-stat.overall.dTLB-load-miss-rate%
    887.77 ±  2%     +20.0%       1064        perf-stat.overall.instructions-per-iTLB-miss
      0.07           +54.6%       0.11 ± 11%  perf-stat.overall.ipc
     67.32            -3.5       63.85 ±  2%  perf-stat.overall.node-store-miss-rate%
 3.087e+09           +47.9%  4.565e+09 ± 10%  perf-stat.ps.branch-instructions
  20985417           +46.4%   30715739 ±  8%  perf-stat.ps.branch-misses
  76408104 ±  2%     +39.9%  1.069e+08 ± 32%  perf-stat.ps.cache-misses
 2.259e+08           +41.2%  3.189e+08 ± 30%  perf-stat.ps.cache-references
     10625           -21.7%       8317 ±  2%  perf-stat.ps.context-switches
 2.309e+11            -4.1%  2.215e+11        perf-stat.ps.cpu-cycles
 4.809e+09           +46.6%   7.05e+09 ± 10%  perf-stat.ps.dTLB-loads
     53845 ±  6%     +25.9%      67809 ± 10%  perf-stat.ps.dTLB-store-misses
 2.538e+09           +47.1%  3.733e+09 ± 10%  perf-stat.ps.dTLB-stores
  17689529 ±  2%     +23.4%   21821765 ±  9%  perf-stat.ps.iTLB-load-misses
  1.57e+10           +48.1%  2.324e+10 ± 10%  perf-stat.ps.instructions
      4321           +25.5%       5421 ±  5%  perf-stat.ps.minor-faults
   7920594 ±  3%     +66.8%   13213742 ± 41%  perf-stat.ps.node-load-misses
   2675733           +33.2%    3564890 ± 19%  perf-stat.ps.node-loads
   5723821           +10.8%    6341623        perf-stat.ps.node-store-misses
   2778550           +29.3%    3593821 ±  5%  perf-stat.ps.node-stores
      4324           +25.5%       5426 ±  5%  perf-stat.ps.page-faults
 3.382e+12           -12.6%  2.956e+12        perf-stat.total.instructions
      0.05 ± 68%    +305.6%       0.20 ± 26%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.10 ± 24%    +183.6%       0.27 ±108%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
      0.11 ±  7%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.11 ± 19%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
      0.10 ±  7%    +108.1%       0.20 ± 84%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      1.53 ± 27%     -52.2%       0.73 ± 38%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.19 ± 12%    +160.6%       0.50 ± 97%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      0.01 ±153%   +4997.8%       0.39 ±163%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__fdget_pos
      4.77 ± 91%    +717.0%      38.97 ± 69%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     12.93 ± 44%     -32.2%       8.76 ± 15%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     38.66 ±136%   +3457.9%       1375 ± 95%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
     57.56 ± 34%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
     28.25 ± 46%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
      7.94 ± 13%     +69.5%      13.47 ± 36%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers
     31.00 ± 28%     -69.0%       9.60 ± 52%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.ext4_orphan_del
      0.13 ±  6%     +60.4%       0.21 ± 39%  perf-sched.total_sch_delay.average.ms
    200.26 ±  6%     +18.2%     236.62 ±  8%  perf-sched.total_wait_and_delay.average.ms
    110701 ±  6%     -22.2%      86145 ±  3%  perf-sched.total_wait_and_delay.count.ms
    200.13 ±  6%     +18.1%     236.40 ±  8%  perf-sched.total_wait_time.average.ms
    199.49 ±  7%     +36.1%     271.57 ± 10%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
    171.08 ±  9%     +54.1%     263.72 ±  7%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
    153.91 ± 73%     +70.2%     261.99 ±  9%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc
     78.75 ±143%    +269.7%     291.10 ± 10%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.ext4_da_map_blocks.constprop
    216.05 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
    196.87 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
    207.27 ± 11%     +29.7%     268.74 ±  9%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode
    213.62 ±  7%     +15.2%     246.02 ±  7%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.ext4_buffered_write_iter.new_sync_write
    108.77 ±100%    +150.9%     272.90 ± 12%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers
    212.85 ± 10%     +34.7%     286.80 ± 10%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
     65.92 ±  9%    +391.0%     323.66 ± 23%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
    723.47           -28.0%     520.55 ± 24%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
    233.00 ±  3%    +245.2%     804.33 ± 47%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      2519 ± 12%     +66.2%       4187 ± 26%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
      1485 ± 17%   +1959.5%      30600 ± 14%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
    245.17 ± 71%    +430.3%       1300 ± 31%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc
    128.50 ±143%    +258.4%     460.50 ± 15%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.down_read.ext4_da_map_blocks.constprop
     51136 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1615 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
     20831 ±  4%     -43.4%      11791 ± 17%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.generic_perform_write.ext4_buffered_write_iter.new_sync_write
     81.67 ±101%   +1016.1%     911.50 ± 13%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers
      2605 ± 18%     -29.7%       1831 ± 23%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
     37.17 ± 20%     -63.7%      13.50 ± 53%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      3996 ±  3%     +43.0%       5716 ±  9%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1126 ±  2%     +48.1%       1668 ± 21%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      3977 ±  3%     -26.0%       2945 ± 11%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4002 ±  3%     -24.7%       3013 ± 12%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
      4036 ±  5%     -25.4%       3012 ± 11%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      3835 ±  4%     -70.3%       1139 ±141%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.ext4_buffered_write_iter.new_sync_write
      4044 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      3977 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
      3993 ±  3%     -24.1%       3031 ± 13%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode
      4049 ±  4%     -25.9%       3001 ± 11%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      3989 ±  3%     -25.4%       2975 ± 10%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
      3925 ±  4%     -24.6%       2961 ± 12%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      3728 ±  5%     -38.6%       2290 ± 46%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      3967 ±  4%     -26.3%       2923 ± 10%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      3987 ±  4%     -25.8%       2956 ± 10%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      3965 ±  4%     -25.3%       2964 ± 10%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3986 ±  3%     -25.0%       2990 ± 11%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
    147.97 ± 20%    +102.0%     298.85 ± 17%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin
    199.39 ±  7%     +36.1%     271.30 ± 10%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
    316.30 ±206%     -95.6%      13.77 ± 17%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_orphan_add.__ext4_unlink
    170.98 ±  9%     +54.1%     263.51 ±  7%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
    206.10 ± 22%     +27.1%     261.86 ±  9%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc
     24.03 ± 18%    +693.0%     190.60 ±112%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.block_invalidatepage.truncate_cleanup_page.truncate_inode_pages_range
    186.43 ± 24%     +56.1%     290.97 ± 10%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.ext4_da_map_blocks.constprop
     22.48 ± 30%     -39.0%      13.70 ± 29%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.vfs_unlink.do_unlinkat
    215.93 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
    196.76 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
    207.16 ± 11%     +29.6%     268.44 ±  9%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode
    213.52 ±  7%     +15.1%     245.82 ±  7%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.ext4_buffered_write_iter.new_sync_write
    186.06 ± 19%     +46.6%     272.76 ± 12%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers
    212.76 ± 10%     +34.7%     286.68 ± 10%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
     21.62 ± 21%   +1163.2%     273.08 ± 92%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict
     65.73 ± 10%    +391.6%     323.16 ± 23%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
     30.01 ± 60%    +756.1%     256.96 ± 20%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__fdget_pos
     18.37 ± 27%    +909.3%     185.43 ± 49%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.ext4_orphan_del
    723.45           -28.0%     520.53 ± 24%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      3865 ±  4%     -24.0%       2937 ± 11%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      3977 ±  3%     -26.0%       2943 ± 11%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3754 ±  5%     -21.4%       2951 ± 11%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin
      3999 ±  3%     -25.3%       2986 ± 11%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
      4008 ±  4%     -25.5%       2986 ± 10%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      3923 ±  4%     -24.5%       2960 ± 10%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc
      3974 ±  3%     -26.0%       2939 ± 11%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.ext4_da_map_blocks.constprop
      3834 ±  4%     -23.6%       2931 ± 11%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.ext4_buffered_write_iter.new_sync_write
      4038 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      3975 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
      3993 ±  3%     -25.0%       2993 ± 11%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode
      4039 ±  3%     -26.2%       2980 ± 10%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      3799 ±  6%     -22.5%       2945 ± 10%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers
      3988 ±  3%     -25.5%       2973 ± 10%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
      3924 ±  4%     -25.0%       2944 ± 12%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      3725 ±  5%     -23.7%       2844 ± 12%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      3964 ±  4%     -26.3%       2921 ± 10%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      3957 ±  4%     -25.9%       2934 ± 10%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
      3982 ±  4%     -26.0%       2948 ± 10%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      2.82 ±197%   +6434.8%     184.16 ±198%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      3958 ±  4%     -25.5%       2950 ± 10%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3980 ±  3%     -25.1%       2980 ± 11%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      3603 ±  3%     -35.9%       2310 ± 45%  perf-sched.wait_time.max.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
    431.67           -39.8%     260.00 ± 11%  interrupts.9:IO-APIC.9-fasteoi.acpi
    128222           -24.9%      96337 ±  8%  interrupts.CAL:Function_call_interrupts
    431875           -39.9%     259448 ± 11%  interrupts.CPU0.LOC:Local_timer_interrupts
      1603 ± 24%     -42.9%     915.67 ± 16%  interrupts.CPU0.RES:Rescheduling_interrupts
    431.67           -39.8%     260.00 ± 11%  interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
    431877           -40.0%     259291 ± 11%  interrupts.CPU1.LOC:Local_timer_interrupts
    988.50 ± 11%     -31.9%     673.33 ± 18%  interrupts.CPU1.RES:Rescheduling_interrupts
      1360 ±  5%     -25.5%       1013 ±  8%  interrupts.CPU10.CAL:Function_call_interrupts
    431881           -39.9%     259379 ± 11%  interrupts.CPU10.LOC:Local_timer_interrupts
      1382 ± 12%     -25.7%       1027 ± 11%  interrupts.CPU11.CAL:Function_call_interrupts
    431872           -39.9%     259376 ± 11%  interrupts.CPU11.LOC:Local_timer_interrupts
    431840           -39.9%     259335 ± 11%  interrupts.CPU12.LOC:Local_timer_interrupts
      1473 ± 15%     -30.8%       1020 ±  8%  interrupts.CPU13.CAL:Function_call_interrupts
    431756           -39.9%     259376 ± 11%  interrupts.CPU13.LOC:Local_timer_interrupts
      1220 ± 32%     -41.7%     711.83 ± 20%  interrupts.CPU13.RES:Rescheduling_interrupts
      1508 ± 11%     -27.0%       1101 ± 16%  interrupts.CPU14.CAL:Function_call_interrupts
    431818           -39.9%     259356 ± 11%  interrupts.CPU14.LOC:Local_timer_interrupts
    431770           -40.0%     259240 ± 11%  interrupts.CPU15.LOC:Local_timer_interrupts
      1114 ± 23%     -38.0%     690.50 ± 23%  interrupts.CPU15.RES:Rescheduling_interrupts
      1357 ±  6%     -25.7%       1009 ±  9%  interrupts.CPU16.CAL:Function_call_interrupts
    431775           -39.9%     259412 ± 11%  interrupts.CPU16.LOC:Local_timer_interrupts
    977.83 ± 10%     -23.7%     746.17 ± 24%  interrupts.CPU16.RES:Rescheduling_interrupts
    431836           -40.0%     259301 ± 11%  interrupts.CPU17.LOC:Local_timer_interrupts
      1565 ± 23%     -30.6%       1086 ± 14%  interrupts.CPU18.CAL:Function_call_interrupts
    431843           -39.9%     259337 ± 11%  interrupts.CPU18.LOC:Local_timer_interrupts
      1343 ±  7%     -23.3%       1030 ± 12%  interrupts.CPU19.CAL:Function_call_interrupts
    431744           -39.9%     259358 ± 11%  interrupts.CPU19.LOC:Local_timer_interrupts
    996.67 ± 11%     -25.7%     741.00 ± 16%  interrupts.CPU19.RES:Rescheduling_interrupts
    431763           -40.0%     259273 ± 11%  interrupts.CPU2.LOC:Local_timer_interrupts
      1363 ±  4%     -26.5%       1002 ±  7%  interrupts.CPU20.CAL:Function_call_interrupts
    431832           -39.9%     259387 ± 11%  interrupts.CPU20.LOC:Local_timer_interrupts
      1077 ± 24%     -36.3%     686.50 ± 20%  interrupts.CPU20.RES:Rescheduling_interrupts
      1387 ±  5%     -27.9%       1000 ±  7%  interrupts.CPU21.CAL:Function_call_interrupts
    431837           -39.9%     259348 ± 11%  interrupts.CPU21.LOC:Local_timer_interrupts
      1068 ± 13%     -34.8%     696.00 ± 16%  interrupts.CPU21.RES:Rescheduling_interrupts
      1505 ±  4%     -21.6%       1179 ± 11%  interrupts.CPU22.CAL:Function_call_interrupts
    432173           -40.0%     259359 ± 11%  interrupts.CPU22.LOC:Local_timer_interrupts
      1602 ± 17%     -43.0%     913.00 ± 16%  interrupts.CPU22.RES:Rescheduling_interrupts
      1899 ± 46%     -37.4%       1189 ± 10%  interrupts.CPU23.CAL:Function_call_interrupts
    431859           -39.9%     259338 ± 11%  interrupts.CPU23.LOC:Local_timer_interrupts
      1170 ± 10%     -43.4%     662.00 ± 19%  interrupts.CPU23.RES:Rescheduling_interrupts
      1587 ±  6%     -26.2%       1171 ± 10%  interrupts.CPU24.CAL:Function_call_interrupts
    431887           -39.9%     259354 ± 11%  interrupts.CPU24.LOC:Local_timer_interrupts
      1221 ± 18%     -44.8%     673.50 ± 20%  interrupts.CPU24.RES:Rescheduling_interrupts
      1605 ± 10%     -28.2%       1153 ± 10%  interrupts.CPU25.CAL:Function_call_interrupts
    431849           -39.9%     259350 ± 11%  interrupts.CPU25.LOC:Local_timer_interrupts
      1167 ± 12%     -43.1%     664.00 ± 14%  interrupts.CPU25.RES:Rescheduling_interrupts
    431842           -39.9%     259348 ± 11%  interrupts.CPU26.LOC:Local_timer_interrupts
      1108 ±  8%     -40.4%     660.83 ± 19%  interrupts.CPU26.RES:Rescheduling_interrupts
    431849           -40.0%     259296 ± 11%  interrupts.CPU27.LOC:Local_timer_interrupts
      1337 ± 41%     -49.9%     669.50 ± 24%  interrupts.CPU27.RES:Rescheduling_interrupts
      1489 ±  6%     -22.4%       1155 ± 12%  interrupts.CPU28.CAL:Function_call_interrupts
    431854           -40.0%     259292 ± 11%  interrupts.CPU28.LOC:Local_timer_interrupts
      1245 ±  7%     -48.1%     646.17 ± 21%  interrupts.CPU28.RES:Rescheduling_interrupts
    431842           -39.9%     259368 ± 11%  interrupts.CPU29.LOC:Local_timer_interrupts
      1126 ± 11%     -40.2%     673.83 ± 19%  interrupts.CPU29.RES:Rescheduling_interrupts
    431731           -39.9%     259367 ± 11%  interrupts.CPU3.LOC:Local_timer_interrupts
      1324 ± 29%     -42.3%     763.67 ± 19%  interrupts.CPU3.RES:Rescheduling_interrupts
      1542 ± 13%     -29.8%       1082 ± 10%  interrupts.CPU30.CAL:Function_call_interrupts
    431737           -39.9%     259318 ± 11%  interrupts.CPU30.LOC:Local_timer_interrupts
      1131 ±  8%     -36.3%     720.83 ± 27%  interrupts.CPU30.RES:Rescheduling_interrupts
      1475 ±  7%     -25.9%       1093 ±  8%  interrupts.CPU31.CAL:Function_call_interrupts
    431814           -39.9%     259336 ± 11%  interrupts.CPU31.LOC:Local_timer_interrupts
      1150 ± 10%     -44.9%     633.83 ± 20%  interrupts.CPU31.RES:Rescheduling_interrupts
      1490 ±  3%     -26.2%       1100 ± 12%  interrupts.CPU32.CAL:Function_call_interrupts
    431821           -39.9%     259334 ± 11%  interrupts.CPU32.LOC:Local_timer_interrupts
      1312 ± 22%     -47.6%     687.83 ± 26%  interrupts.CPU32.RES:Rescheduling_interrupts
      1566 ±  8%     -32.1%       1063 ± 11%  interrupts.CPU33.CAL:Function_call_interrupts
    431723           -39.9%     259333 ± 11%  interrupts.CPU33.LOC:Local_timer_interrupts
      1148 ±  5%     -44.0%     643.33 ± 18%  interrupts.CPU33.RES:Rescheduling_interrupts
      1457 ±  3%     -27.3%       1058 ± 11%  interrupts.CPU34.CAL:Function_call_interrupts
    431853           -39.9%     259378 ± 11%  interrupts.CPU34.LOC:Local_timer_interrupts
      1151 ±  7%     -45.0%     633.00 ± 19%  interrupts.CPU34.RES:Rescheduling_interrupts
      1523 ±  9%     -29.3%       1076 ±  9%  interrupts.CPU35.CAL:Function_call_interrupts
    431869           -39.9%     259449 ± 11%  interrupts.CPU35.LOC:Local_timer_interrupts
      1168 ±  8%     -45.5%     637.17 ± 19%  interrupts.CPU35.RES:Rescheduling_interrupts
      1433 ±  5%     -22.9%       1104 ± 11%  interrupts.CPU36.CAL:Function_call_interrupts
    431816           -39.9%     259307 ± 11%  interrupts.CPU36.LOC:Local_timer_interrupts
      1126 ±  7%     -40.6%     669.00 ± 17%  interrupts.CPU36.RES:Rescheduling_interrupts
      1437 ±  4%     -24.0%       1092 ±  9%  interrupts.CPU37.CAL:Function_call_interrupts
    431814           -40.0%     259223 ± 11%  interrupts.CPU37.LOC:Local_timer_interrupts
      1142 ±  9%     -40.9%     675.50 ± 21%  interrupts.CPU37.RES:Rescheduling_interrupts
      1425 ±  6%     -25.3%       1064 ± 10%  interrupts.CPU38.CAL:Function_call_interrupts
    431866           -39.9%     259339 ± 11%  interrupts.CPU38.LOC:Local_timer_interrupts
      1129 ±  8%     -42.6%     648.00 ± 18%  interrupts.CPU38.RES:Rescheduling_interrupts
      1454 ±  2%     -24.6%       1097 ± 10%  interrupts.CPU39.CAL:Function_call_interrupts
    431824           -39.9%     259327 ± 11%  interrupts.CPU39.LOC:Local_timer_interrupts
      1205 ±  9%     -42.1%     698.00 ± 17%  interrupts.CPU39.RES:Rescheduling_interrupts
      1386 ±  6%     -28.0%     998.83 ±  7%  interrupts.CPU4.CAL:Function_call_interrupts
    431867           -39.9%     259374 ± 11%  interrupts.CPU4.LOC:Local_timer_interrupts
    980.17 ± 10%     -27.3%     712.67 ± 22%  interrupts.CPU4.RES:Rescheduling_interrupts
      1428 ±  3%     -25.6%       1063 ±  7%  interrupts.CPU40.CAL:Function_call_interrupts
    431805           -39.9%     259456 ± 11%  interrupts.CPU40.LOC:Local_timer_interrupts
      1136 ±  9%     -40.7%     673.83 ± 17%  interrupts.CPU40.RES:Rescheduling_interrupts
      1414 ±  4%     -25.2%       1058 ±  8%  interrupts.CPU41.CAL:Function_call_interrupts
    431826           -40.0%     259293 ± 11%  interrupts.CPU41.LOC:Local_timer_interrupts
      1159 ± 12%     -44.5%     644.00 ± 20%  interrupts.CPU41.RES:Rescheduling_interrupts
      1430 ±  3%     -24.1%       1086 ±  9%  interrupts.CPU42.CAL:Function_call_interrupts
    431845           -40.0%     259276 ± 11%  interrupts.CPU42.LOC:Local_timer_interrupts
      1130 ±  8%     -40.2%     675.50 ± 19%  interrupts.CPU42.RES:Rescheduling_interrupts
      2631 ±  4%     -33.8%       1741 ± 11%  interrupts.CPU43.CAL:Function_call_interrupts
    431805           -39.9%     259337 ± 11%  interrupts.CPU43.LOC:Local_timer_interrupts
      2223 ±  5%     -44.2%       1240 ± 24%  interrupts.CPU43.RES:Rescheduling_interrupts
      1410 ±  4%     -26.8%       1032 ± 11%  interrupts.CPU44.CAL:Function_call_interrupts
    431828           -39.9%     259337 ± 11%  interrupts.CPU44.LOC:Local_timer_interrupts
      1358 ±  5%     -25.5%       1011 ±  9%  interrupts.CPU45.CAL:Function_call_interrupts
    431863           -40.0%     259256 ± 11%  interrupts.CPU45.LOC:Local_timer_interrupts
    978.50 ± 10%     -31.1%     674.67 ± 21%  interrupts.CPU45.RES:Rescheduling_interrupts
      1398 ±  7%     -27.3%       1017 ±  9%  interrupts.CPU46.CAL:Function_call_interrupts
    431875           -40.0%     259332 ± 11%  interrupts.CPU46.LOC:Local_timer_interrupts
      1312 ±  5%     -24.5%     990.50 ±  9%  interrupts.CPU47.CAL:Function_call_interrupts
    431979           -40.0%     259310 ± 11%  interrupts.CPU47.LOC:Local_timer_interrupts
      1360 ±  5%     -26.4%       1001 ±  7%  interrupts.CPU48.CAL:Function_call_interrupts
    431853           -40.0%     259302 ± 11%  interrupts.CPU48.LOC:Local_timer_interrupts
      1016 ± 12%     -32.8%     683.00 ± 18%  interrupts.CPU48.RES:Rescheduling_interrupts
      1333 ±  5%     -25.0%     999.67 ± 10%  interrupts.CPU49.CAL:Function_call_interrupts
    431862           -40.0%     259330 ± 11%  interrupts.CPU49.LOC:Local_timer_interrupts
      1699 ± 26%     -36.6%       1077 ± 13%  interrupts.CPU5.CAL:Function_call_interrupts
    431815           -39.9%     259381 ± 11%  interrupts.CPU5.LOC:Local_timer_interrupts
      1344 ±  6%     -27.0%     980.83 ±  6%  interrupts.CPU50.CAL:Function_call_interrupts
    431860           -40.0%     259272 ± 11%  interrupts.CPU50.LOC:Local_timer_interrupts
      1340 ±  4%     -23.9%       1020 ±  7%  interrupts.CPU51.CAL:Function_call_interrupts
    431865           -40.0%     259303 ± 11%  interrupts.CPU51.LOC:Local_timer_interrupts
      1336 ±  5%     -24.6%       1007 ±  8%  interrupts.CPU52.CAL:Function_call_interrupts
    431855           -40.0%     259321 ± 11%  interrupts.CPU52.LOC:Local_timer_interrupts
      1377 ±  5%     -23.5%       1053 ±  9%  interrupts.CPU53.CAL:Function_call_interrupts
    431866           -40.0%     259333 ± 11%  interrupts.CPU53.LOC:Local_timer_interrupts
      1332 ±  5%     -19.0%       1078 ± 13%  interrupts.CPU54.CAL:Function_call_interrupts
    431964           -40.0%     259367 ± 11%  interrupts.CPU54.LOC:Local_timer_interrupts
      1337 ±  5%     -23.3%       1025 ±  8%  interrupts.CPU55.CAL:Function_call_interrupts
    431840           -39.9%     259339 ± 11%  interrupts.CPU55.LOC:Local_timer_interrupts
      1368 ±  6%     -22.3%       1063 ± 12%  interrupts.CPU56.CAL:Function_call_interrupts
    431846           -39.9%     259338 ± 11%  interrupts.CPU56.LOC:Local_timer_interrupts
      1349 ±  5%     -22.8%       1041 ±  7%  interrupts.CPU57.CAL:Function_call_interrupts
    431936           -40.0%     259285 ± 11%  interrupts.CPU57.LOC:Local_timer_interrupts
      1359 ±  8%     -24.2%       1029 ± 10%  interrupts.CPU58.CAL:Function_call_interrupts
    431873           -39.9%     259371 ± 11%  interrupts.CPU58.LOC:Local_timer_interrupts
      1367 ±  4%     -26.4%       1006 ±  7%  interrupts.CPU59.CAL:Function_call_interrupts
    431796           -40.0%     259062 ± 11%  interrupts.CPU59.LOC:Local_timer_interrupts
    978.33 ± 12%     -29.9%     686.00 ± 19%  interrupts.CPU59.RES:Rescheduling_interrupts
      1365 ±  7%     -25.8%       1013 ±  7%  interrupts.CPU6.CAL:Function_call_interrupts
    431773           -39.9%     259370 ± 11%  interrupts.CPU6.LOC:Local_timer_interrupts
    431856           -39.9%     259475 ± 11%  interrupts.CPU60.LOC:Local_timer_interrupts
      1354 ±  4%     -21.1%       1068 ±  8%  interrupts.CPU61.CAL:Function_call_interrupts
    431874           -39.9%     259349 ± 11%  interrupts.CPU61.LOC:Local_timer_interrupts
      1378 ±  8%     -23.5%       1054 ± 11%  interrupts.CPU62.CAL:Function_call_interrupts
    431856           -39.9%     259409 ± 11%  interrupts.CPU62.LOC:Local_timer_interrupts
      1358 ±  7%     -23.9%       1034 ±  7%  interrupts.CPU63.CAL:Function_call_interrupts
    432006           -40.0%     259363 ± 11%  interrupts.CPU63.LOC:Local_timer_interrupts
      1322 ±  4%     -23.1%       1016 ± 10%  interrupts.CPU64.CAL:Function_call_interrupts
    431868           -39.9%     259390 ± 11%  interrupts.CPU64.LOC:Local_timer_interrupts
      1388 ± 12%     -26.8%       1016 ±  7%  interrupts.CPU65.CAL:Function_call_interrupts
    431870           -39.9%     259468 ± 11%  interrupts.CPU65.LOC:Local_timer_interrupts
      1409 ±  2%     -23.0%       1084 ± 10%  interrupts.CPU66.CAL:Function_call_interrupts
    431808           -39.9%     259395 ± 11%  interrupts.CPU66.LOC:Local_timer_interrupts
      1431 ±  6%     -27.6%       1035 ±  8%  interrupts.CPU67.CAL:Function_call_interrupts
    431834           -39.9%     259334 ± 11%  interrupts.CPU67.LOC:Local_timer_interrupts
      1212 ± 11%     -46.9%     644.17 ± 20%  interrupts.CPU67.RES:Rescheduling_interrupts
      1466 ±  6%     -26.8%       1073 ±  7%  interrupts.CPU68.CAL:Function_call_interrupts
    431862           -39.9%     259338 ± 11%  interrupts.CPU68.LOC:Local_timer_interrupts
      1161 ± 11%     -44.0%     650.17 ± 18%  interrupts.CPU68.RES:Rescheduling_interrupts
      1466 ±  4%     -26.3%       1081 ± 12%  interrupts.CPU69.CAL:Function_call_interrupts
    431845           -39.9%     259328 ± 11%  interrupts.CPU69.LOC:Local_timer_interrupts
      1447 ± 10%     -26.2%       1067 ±  9%  interrupts.CPU7.CAL:Function_call_interrupts
    431853           -40.0%     259295 ± 11%  interrupts.CPU7.LOC:Local_timer_interrupts
    999.67 ± 10%     -28.3%     716.67 ± 18%  interrupts.CPU7.RES:Rescheduling_interrupts
      1435 ±  3%     -25.7%       1066 ±  8%  interrupts.CPU70.CAL:Function_call_interrupts
    431854           -39.9%     259378 ± 11%  interrupts.CPU70.LOC:Local_timer_interrupts
      1099 ±  9%     -40.0%     659.50 ± 17%  interrupts.CPU70.RES:Rescheduling_interrupts
      1439 ±  5%     -26.8%       1054 ± 11%  interrupts.CPU71.CAL:Function_call_interrupts
    431844           -39.9%     259368 ± 11%  interrupts.CPU71.LOC:Local_timer_interrupts
      1287 ± 25%     -48.9%     658.17 ± 25%  interrupts.CPU71.RES:Rescheduling_interrupts
      1463 ±  7%     -26.2%       1079 ± 11%  interrupts.CPU72.CAL:Function_call_interrupts
    431901           -39.9%     259432 ± 11%  interrupts.CPU72.LOC:Local_timer_interrupts
      1501 ±  5%     -30.7%       1040 ±  9%  interrupts.CPU73.CAL:Function_call_interrupts
    431860           -39.9%     259391 ± 11%  interrupts.CPU73.LOC:Local_timer_interrupts
      1326 ± 30%     -51.3%     645.33 ± 21%  interrupts.CPU73.RES:Rescheduling_interrupts
      1417 ±  4%     -25.0%       1063 ±  9%  interrupts.CPU74.CAL:Function_call_interrupts
    431918           -40.0%     259366 ± 11%  interrupts.CPU74.LOC:Local_timer_interrupts
      1166 ±  2%     -45.5%     635.83 ± 19%  interrupts.CPU74.RES:Rescheduling_interrupts
      1435 ±  4%     -24.3%       1086 ±  8%  interrupts.CPU75.CAL:Function_call_interrupts
    431840           -39.9%     259375 ± 11%  interrupts.CPU75.LOC:Local_timer_interrupts
      1160 ± 10%     -42.3%     669.83 ± 16%  interrupts.CPU75.RES:Rescheduling_interrupts
      1439 ±  7%     -28.2%       1034 ± 14%  interrupts.CPU76.CAL:Function_call_interrupts
    431877           -39.9%     259429 ± 11%  interrupts.CPU76.LOC:Local_timer_interrupts
      1192 ± 17%     -44.4%     662.67 ± 24%  interrupts.CPU76.RES:Rescheduling_interrupts
      1390 ±  7%     -22.6%       1076 ±  8%  interrupts.CPU77.CAL:Function_call_interrupts
    431865           -39.9%     259384 ± 11%  interrupts.CPU77.LOC:Local_timer_interrupts
      1148 ± 14%     -41.6%     671.33 ± 15%  interrupts.CPU77.RES:Rescheduling_interrupts
      1433 ±  4%     -27.4%       1041 ±  9%  interrupts.CPU78.CAL:Function_call_interrupts
    431846           -39.9%     259379 ± 11%  interrupts.CPU78.LOC:Local_timer_interrupts
      1122 ±  7%     -42.9%     640.67 ± 19%  interrupts.CPU78.RES:Rescheduling_interrupts
      1466 ±  5%     -27.4%       1063 ±  9%  interrupts.CPU79.CAL:Function_call_interrupts
    431821           -39.9%     259374 ± 11%  interrupts.CPU79.LOC:Local_timer_interrupts
      1213 ± 11%     -47.7%     634.33 ± 20%  interrupts.CPU79.RES:Rescheduling_interrupts
      1884 ± 27%     -45.8%       1021 ± 10%  interrupts.CPU8.CAL:Function_call_interrupts
    431809           -39.9%     259341 ± 11%  interrupts.CPU8.LOC:Local_timer_interrupts
      1431 ±  7%     -24.3%       1083 ±  7%  interrupts.CPU80.CAL:Function_call_interrupts
    431854           -39.9%     259376 ± 11%  interrupts.CPU80.LOC:Local_timer_interrupts
      1148 ± 12%     -44.2%     641.00 ± 14%  interrupts.CPU80.RES:Rescheduling_interrupts
      1417 ±  5%     -25.6%       1054 ± 11%  interrupts.CPU81.CAL:Function_call_interrupts
    431830           -39.9%     259388 ± 11%  interrupts.CPU81.LOC:Local_timer_interrupts
      1098 ±  6%     -41.2%     645.67 ± 25%  interrupts.CPU81.RES:Rescheduling_interrupts
      1475 ± 10%     -28.4%       1056 ± 10%  interrupts.CPU82.CAL:Function_call_interrupts
    431878           -39.9%     259370 ± 11%  interrupts.CPU82.LOC:Local_timer_interrupts
      1272 ± 27%     -48.4%     656.33 ± 18%  interrupts.CPU82.RES:Rescheduling_interrupts
      1415 ±  4%     -23.4%       1084 ±  8%  interrupts.CPU83.CAL:Function_call_interrupts
    431859           -39.9%     259366 ± 11%  interrupts.CPU83.LOC:Local_timer_interrupts
      1122 ± 10%     -40.9%     663.50 ± 14%  interrupts.CPU83.RES:Rescheduling_interrupts
      1435 ±  5%     -26.1%       1060 ±  8%  interrupts.CPU84.CAL:Function_call_interrupts
    431839           -39.9%     259363 ± 11%  interrupts.CPU84.LOC:Local_timer_interrupts
      1227 ± 10%     -47.2%     647.50 ± 20%  interrupts.CPU84.RES:Rescheduling_interrupts
      1436 ±  4%     -25.3%       1073 ±  7%  interrupts.CPU85.CAL:Function_call_interrupts
    431832           -39.9%     259394 ± 11%  interrupts.CPU85.LOC:Local_timer_interrupts
      1135 ±  6%     -43.7%     639.50 ± 20%  interrupts.CPU85.RES:Rescheduling_interrupts
      1390 ±  5%     -24.9%       1044 ±  8%  interrupts.CPU86.CAL:Function_call_interrupts
    431862           -39.9%     259355 ± 11%  interrupts.CPU86.LOC:Local_timer_interrupts
      1117 ±  9%     -40.6%     663.50 ± 18%  interrupts.CPU86.RES:Rescheduling_interrupts
      1423 ±  5%     -20.9%       1126 ±  8%  interrupts.CPU87.CAL:Function_call_interrupts
    431895           -40.0%     259331 ± 11%  interrupts.CPU87.LOC:Local_timer_interrupts
      1142 ± 10%     -39.5%     691.00 ± 20%  interrupts.CPU87.RES:Rescheduling_interrupts
    431611           -39.9%     259371 ± 11%  interrupts.CPU9.LOC:Local_timer_interrupts
  38002501           -39.9%   22822684 ± 11%  interrupts.LOC:Local_timer_interrupts
     98629 ±  2%     -35.4%      63693 ± 13%  interrupts.RES:Rescheduling_interrupts
     58.38 ±  2%     -58.4        0.00        perf-profile.calltrace.cycles-pp.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
     63.54           -56.6        6.94 ± 35%  perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
     55.70 ±  2%     -55.7        0.00        perf-profile.calltrace.cycles-pp.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
     55.35 ±  2%     -55.4        0.00        perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write
     27.78           -27.8        0.00        perf-profile.calltrace.cycles-pp.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
     15.90 ±  3%     -15.9        0.00        perf-profile.calltrace.cycles-pp.__ext4_journal_stop.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
     15.52 ±  4%     -15.5        0.00        perf-profile.calltrace.cycles-pp.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
     11.69 ±  6%     -11.7        0.00        perf-profile.calltrace.cycles-pp.generic_write_end.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      9.64 ±  4%      -9.6        0.00        perf-profile.calltrace.cycles-pp.add_transaction_credits.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
      9.04            -9.0        0.00        perf-profile.calltrace.cycles-pp._raw_read_lock.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
      8.57 ±  5%      -8.6        0.00        perf-profile.calltrace.cycles-pp.stop_this_handle.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end.generic_perform_write
      8.31 ±  5%      -8.3        0.00        perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_write_end.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
      6.98 ±  5%      -7.0        0.00        perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.ext4_da_write_end.generic_perform_write
      5.56 ±  5%      -5.6        0.00        perf-profile.calltrace.cycles-pp.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.ext4_da_write_end
     92.55            -5.2       87.32 ±  6%  perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write
     97.14            -3.6       93.52 ±  2%  perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     97.26            -2.5       94.72        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     97.57            -1.7       95.88        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.66            -1.6       96.03        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.76            -1.6       96.19        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.82            -1.6       96.25        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     98.05            -1.4       96.64        perf-profile.calltrace.cycles-pp.write
      0.94 ± 32%      +0.4        1.32 ±  7%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
      0.79 ±  9%      +0.5        1.27 ±  4%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill.dput
      0.90 ± 10%      +0.5        1.43 ±  4%  perf-profile.calltrace.cycles-pp.ext4_evict_inode.evict.__dentry_kill.dput.__fput
      0.90 ± 10%      +0.5        1.44 ±  4%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
      0.91 ± 10%      +0.5        1.45 ±  4%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_prepare
      0.92 ± 10%      +0.5        1.46 ±  4%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.92 ± 10%      +0.5        1.46 ±  4%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.92 ± 10%      +0.5        1.46 ±  4%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.93 ± 11%      +0.5        1.47 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      0.93 ± 11%      +0.5        1.47 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.92 ± 10%      +0.5        1.47 ±  3%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.92 ± 10%      +0.5        1.46 ±  4%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.93 ± 11%      +0.5        1.47 ±  4%  perf-profile.calltrace.cycles-pp.__close
      0.00            +0.7        0.68 ± 15%  perf-profile.calltrace.cycles-pp.truncate_cleanup_page.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      2.20 ±  7%      +0.8        2.96 ±  8%  perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1.38 ±  7%      +0.8        2.18 ± 17%  perf-profile.calltrace.cycles-pp.jbd2_journal_dirty_metadata.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty
      1.53 ±  9%      +0.9        2.45 ± 18%  perf-profile.calltrace.cycles-pp.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode
      0.00            +0.9        0.94 ± 46%  perf-profile.calltrace.cycles-pp.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.00            +1.0        1.03 ± 53%  perf-profile.calltrace.cycles-pp.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.00            +1.1        1.06 ± 34%  perf-profile.calltrace.cycles-pp.__find_get_block.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      0.00            +1.1        1.11 ± 33%  perf-profile.calltrace.cycles-pp.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty
      1.61 ±  6%      +1.2        2.78 ± 20%  perf-profile.calltrace.cycles-pp.jbd2_journal_get_write_access.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
      0.00            +1.2        1.23 ± 10%  perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.generic_write_end.generic_perform_write
      1.37 ±  7%      +1.3        2.67 ± 13%  perf-profile.calltrace.cycles-pp.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      1.14 ± 18%      +1.5        2.69 ± 47%  perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      1.71 ±  6%      +1.6        3.32 ±  7%  perf-profile.calltrace.cycles-pp.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      2.22 ±  7%      +1.6        3.86 ± 25%  perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.27 ±100%      +1.7        2.00 ± 29%  perf-profile.calltrace.cycles-pp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
      0.27 ±100%      +1.7        2.02 ± 29%  perf-profile.calltrace.cycles-pp.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      2.82 ±  6%      +2.6        5.44 ±  8%  perf-profile.calltrace.cycles-pp.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      0.00            +2.9        2.90 ±  9%  perf-profile.calltrace.cycles-pp.block_write_end.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      2.20 ±  5%      +3.2        5.37 ± 13%  perf-profile.calltrace.cycles-pp.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      3.34 ±  5%      +3.4        6.69 ± 13%  perf-profile.calltrace.cycles-pp.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      0.00            +4.0        3.96 ±  9%  perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00            +5.7        5.68 ± 37%  perf-profile.calltrace.cycles-pp.stop_this_handle.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end
      0.00            +7.5        7.54 ± 19%  perf-profile.calltrace.cycles-pp.add_transaction_credits.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      0.00            +7.6        7.56 ± 18%  perf-profile.calltrace.cycles-pp._raw_read_lock.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      0.00           +10.8       10.81 ± 31%  perf-profile.calltrace.cycles-pp.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write
      0.00           +11.1       11.12 ± 30%  perf-profile.calltrace.cycles-pp.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00           +12.2       12.23 ± 13%  perf-profile.calltrace.cycles-pp.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write
      1.70 ±  5%     +45.8       47.46 ± 16%  perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      0.00           +46.1       46.14 ± 17%  perf-profile.calltrace.cycles-pp.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      0.00           +48.9       48.93 ± 15%  perf-profile.calltrace.cycles-pp.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write
      0.00           +61.3       61.29 ±  9%  perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00           +73.3       73.31 ± 12%  perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.00           +77.7       77.70 ± 11%  perf-profile.calltrace.cycles-pp.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
     63.56           -56.6        6.95 ± 35%  perf-profile.children.cycles-pp.ext4_da_write_begin
     27.79           -27.6        0.14 ± 13%  perf-profile.children.cycles-pp.ext4_da_write_end
     61.66 ±  2%     -10.8       50.81 ± 14%  perf-profile.children.cycles-pp.__ext4_journal_start_sb
     57.50 ±  2%      -9.6       47.93 ± 16%  perf-profile.children.cycles-pp.jbd2__journal_start
     57.18 ±  2%      -9.6       47.63 ± 16%  perf-profile.children.cycles-pp.start_this_handle
     17.61 ±  2%      -6.0       11.56 ± 29%  perf-profile.children.cycles-pp.__ext4_journal_stop
     17.04 ±  3%      -5.8       11.24 ± 30%  perf-profile.children.cycles-pp.jbd2_journal_stop
     92.60            -5.2       87.36 ±  6%  perf-profile.children.cycles-pp.generic_perform_write
     97.15            -3.6       93.53 ±  2%  perf-profile.children.cycles-pp.ext4_buffered_write_iter
      8.85 ±  5%      -2.9        5.90 ± 36%  perf-profile.children.cycles-pp.stop_this_handle
     97.29            -2.6       94.74        perf-profile.children.cycles-pp.new_sync_write
      9.97 ±  3%      -2.1        7.85 ± 18%  perf-profile.children.cycles-pp.add_transaction_credits
     97.61            -1.7       95.90        perf-profile.children.cycles-pp.vfs_write
     97.69            -1.6       96.05        perf-profile.children.cycles-pp.ksys_write
      9.39            -1.5        7.92 ± 18%  perf-profile.children.cycles-pp._raw_read_lock
     98.11            -1.4       96.76        perf-profile.children.cycles-pp.write
      4.12 ±  7%      -1.3        2.77 ± 13%  perf-profile.children.cycles-pp.ext4_journal_check_start
      1.10 ±  5%      -0.7        0.39 ± 24%  perf-profile.children.cycles-pp.up_write
     99.36            -0.3       99.01        perf-profile.children.cycles-pp.do_syscall_64
     99.43            -0.3       99.10        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.68 ±  2%      -0.2        0.44 ± 13%  perf-profile.children.cycles-pp.unlock_page
      0.34 ±  7%      -0.1        0.24 ± 18%  perf-profile.children.cycles-pp.queued_read_lock_slowpath
      0.55 ±  5%      -0.1        0.46 ±  4%  perf-profile.children.cycles-pp.down_write
      0.05 ±  7%      +0.0        0.08 ± 12%  perf-profile.children.cycles-pp.crypto_shash_update
      0.04 ± 44%      +0.0        0.07 ± 10%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.14 ±  4%      +0.0        0.17 ±  6%  perf-profile.children.cycles-pp.task_tick_fair
      0.28            +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.17 ±  2%      +0.0        0.20 ±  6%  perf-profile.children.cycles-pp.scheduler_tick
      0.08 ± 16%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.free_buffer_head
      0.21 ±  2%      +0.0        0.25 ±  3%  perf-profile.children.cycles-pp.tick_sched_handle
      0.06 ± 13%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.__ext4_unlink
      0.08 ±  8%      +0.0        0.12 ± 11%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.22 ±  2%      +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
      0.20 ±  2%      +0.0        0.24 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.10 ±  7%      +0.0        0.14 ±  9%  perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.07 ± 15%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__ext4_new_inode
      0.01 ±223%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.rcu_all_qs
      0.08 ± 10%      +0.0        0.12 ± 13%  perf-profile.children.cycles-pp.__fget_light
      0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.ext4_nonda_switch
      0.11 ±  7%      +0.1        0.16 ± 14%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.11 ±  6%      +0.1        0.16 ± 13%  perf-profile.children.cycles-pp.xas_load
      0.03 ±100%      +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.down_read
      0.07 ±  5%      +0.1        0.13 ± 12%  perf-profile.children.cycles-pp.disk_rw
      0.10 ±  8%      +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.ext4_unlink
      0.10 ± 10%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.vfs_unlink
      0.05 ± 77%      +0.1        0.11 ± 23%  perf-profile.children.cycles-pp.osq_lock
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.ext4_add_nondir
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.ext4_fc_track_inode
      0.09 ±  7%      +0.1        0.15 ± 12%  perf-profile.children.cycles-pp.__fdget_pos
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.03 ±100%      +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.account_page_cleaned
      0.00            +0.1        0.06 ± 32%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.11 ±  9%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.ext4_create
      0.10 ±  5%      +0.1        0.17 ± 14%  perf-profile.children.cycles-pp.common_file_perm
      0.09 ±  9%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.13 ±  8%      +0.1        0.22 ± 17%  perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      0.03 ± 70%      +0.1        0.12 ± 14%  perf-profile.children.cycles-pp.ext4_es_insert_delayed_block
      0.14 ± 12%      +0.1        0.23 ± 13%  perf-profile.children.cycles-pp.alloc_buffer_head
      0.06 ± 54%      +0.1        0.16 ±  5%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.15 ± 14%      +0.1        0.25 ± 13%  perf-profile.children.cycles-pp.alloc_page_buffers
      0.14 ±  5%      +0.1        0.25 ± 12%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.11 ±  4%      +0.1        0.22 ± 14%  perf-profile.children.cycles-pp.security_file_permission
      0.17 ±  5%      +0.1        0.28 ± 12%  perf-profile.children.cycles-pp.__entry_text_start
      0.18 ± 19%      +0.1        0.31 ±  9%  perf-profile.children.cycles-pp.do_unlinkat
      0.19 ± 17%      +0.1        0.32 ±  7%  perf-profile.children.cycles-pp.unlink
      0.06 ± 14%      +0.1        0.20 ± 61%  perf-profile.children.cycles-pp.__cancel_dirty_page
      0.14 ± 35%      +0.1        0.28 ± 13%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.06 ±  8%      +0.1        0.20 ± 80%  perf-profile.children.cycles-pp.current_time
      0.00            +0.2        0.16 ± 97%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.25 ± 22%      +0.2        0.42 ±  4%  perf-profile.children.cycles-pp.creat64
      0.27 ± 21%      +0.2        0.44 ±  5%  perf-profile.children.cycles-pp.path_openat
      0.27 ± 21%      +0.2        0.44 ±  5%  perf-profile.children.cycles-pp.do_filp_open
      0.28 ± 22%      +0.2        0.45 ±  5%  perf-profile.children.cycles-pp.do_sys_open
      0.28 ± 21%      +0.2        0.45 ±  5%  perf-profile.children.cycles-pp.do_sys_openat2
      0.22 ±  7%      +0.2        0.40 ±  4%  perf-profile.children.cycles-pp.ext4_inode_csum
      0.06 ±  6%      +0.2        0.24 ± 61%  perf-profile.children.cycles-pp.ext4_da_reserve_space
      0.20 ± 43%      +0.2        0.40 ± 19%  perf-profile.children.cycles-pp.__set_page_dirty
      0.21 ± 11%      +0.2        0.41 ± 30%  perf-profile.children.cycles-pp.try_to_free_buffers
      0.06 ±  9%      +0.2        0.26 ± 82%  perf-profile.children.cycles-pp.ext4_file_write_iter
      0.24 ±  5%      +0.2        0.46 ±  5%  perf-profile.children.cycles-pp.ext4_inode_csum_set
      0.44 ±  4%      +0.2        0.68 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock
      0.42 ±  9%      +0.3        0.68 ± 15%  perf-profile.children.cycles-pp.truncate_cleanup_page
      0.07 ±  5%      +0.4        0.45 ±106%  perf-profile.children.cycles-pp.ksys_lseek
      0.29 ±  2%      +0.4        0.69 ± 31%  perf-profile.children.cycles-pp.jbd2_write_access_granted
      0.79 ±  9%      +0.5        1.27 ±  4%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.26 ±  5%      +0.5        0.76 ± 58%  perf-profile.children.cycles-pp.llseek
      0.90 ± 10%      +0.5        1.43 ±  4%  perf-profile.children.cycles-pp.ext4_evict_inode
      0.90 ± 10%      +0.5        1.44 ±  4%  perf-profile.children.cycles-pp.evict
      0.91 ± 10%      +0.5        1.45 ±  4%  perf-profile.children.cycles-pp.__dentry_kill
      0.92 ± 10%      +0.5        1.46 ±  4%  perf-profile.children.cycles-pp.task_work_run
      0.92 ± 10%      +0.5        1.46 ±  4%  perf-profile.children.cycles-pp.__fput
      0.92 ± 10%      +0.5        1.46 ±  3%  perf-profile.children.cycles-pp.dput
      0.93 ± 11%      +0.5        1.48 ±  4%  perf-profile.children.cycles-pp.__close
      0.97 ± 10%      +0.6        1.53 ±  4%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      1.00 ±  9%      +0.6        1.58 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.07 ± 10%      +0.7        0.72 ±119%  perf-profile.children.cycles-pp.ext4_generic_write_checks
      0.30 ±  5%      +0.7        0.95 ± 45%  perf-profile.children.cycles-pp.ext4_da_map_blocks
      0.04 ± 71%      +0.7        0.70 ±123%  perf-profile.children.cycles-pp.generic_write_checks
      0.30 ±  5%      +0.7        1.03 ± 53%  perf-profile.children.cycles-pp.ext4_da_get_block_prep
      0.40 ± 13%      +0.8        1.16 ± 33%  perf-profile.children.cycles-pp.__find_get_block
      2.22 ±  7%      +0.8        3.00 ±  8%  perf-profile.children.cycles-pp.pagecache_get_page
      0.42 ± 13%      +0.8        1.20 ± 32%  perf-profile.children.cycles-pp.__getblk_gfp
      1.48 ±  7%      +0.8        2.29 ± 17%  perf-profile.children.cycles-pp.jbd2_journal_dirty_metadata
      0.05 ±  8%      +0.8        0.86 ±130%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      2.70 ± 19%      +0.8        3.52 ±  7%  perf-profile.children.cycles-pp.block_write_end
      1.64 ±  9%      +0.9        2.57 ± 17%  perf-profile.children.cycles-pp.__ext4_handle_dirty_metadata
      1.74 ±  6%      +1.2        2.92 ± 19%  perf-profile.children.cycles-pp.jbd2_journal_get_write_access
      1.92 ±  5%      +1.5        3.41 ±  6%  perf-profile.children.cycles-pp.__block_commit_write
      1.14 ± 18%      +1.6        2.69 ± 47%  perf-profile.children.cycles-pp.ext4_block_write_begin
      0.55 ± 13%      +1.6        2.11 ± 28%  perf-profile.children.cycles-pp.__ext4_get_inode_loc
      0.56 ± 12%      +1.6        2.12 ± 28%  perf-profile.children.cycles-pp.ext4_get_inode_loc
      1.85 ±  6%      +1.6        3.48 ±  7%  perf-profile.children.cycles-pp.__ext4_journal_get_write_access
      2.22 ±  7%      +1.6        3.87 ± 25%  perf-profile.children.cycles-pp.grab_cache_page_write_begin
      3.05 ±  6%      +2.6        5.70 ±  8%  perf-profile.children.cycles-pp.ext4_do_update_inode
      2.41 ±  5%      +3.2        5.61 ± 13%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      3.60 ±  5%      +3.4        7.00 ± 13%  perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      6.02 ±  4%      +6.7       12.74 ± 13%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      9.15 ±  4%     +54.3       63.42 ±  9%  perf-profile.children.cycles-pp.ext4_dirty_inode
     11.03 ±  4%     +64.9       75.93 ± 11%  perf-profile.children.cycles-pp.__mark_inode_dirty
     11.70 ±  6%     +66.0       77.72 ± 11%  perf-profile.children.cycles-pp.generic_write_end
     37.32 ±  2%      -5.8       31.49 ± 15%  perf-profile.self.cycles-pp.start_this_handle
      8.80 ±  5%      -2.9        5.87 ± 36%  perf-profile.self.cycles-pp.stop_this_handle
      8.06 ±  2%      -2.8        5.25 ± 24%  perf-profile.self.cycles-pp.jbd2_journal_stop
      9.91 ±  3%      -2.1        7.81 ± 18%  perf-profile.self.cycles-pp.add_transaction_credits
      9.33            -1.5        7.88 ± 18%  perf-profile.self.cycles-pp._raw_read_lock
      4.03 ±  7%      -1.3        2.72 ± 14%  perf-profile.self.cycles-pp.ext4_journal_check_start
      1.33 ±  5%      -1.0        0.31 ± 65%  perf-profile.self.cycles-pp.ext4_da_write_begin
      1.09 ±  5%      -0.7        0.38 ± 24%  perf-profile.self.cycles-pp.up_write
      0.68 ±  2%      -0.2        0.44 ± 12%  perf-profile.self.cycles-pp.unlock_page
      0.52 ±  6%      -0.1        0.40 ±  4%  perf-profile.self.cycles-pp.down_write
      0.08 ±  8%      +0.0        0.11 ± 12%  perf-profile.self.cycles-pp.xas_load
      0.04 ± 44%      +0.0        0.07 ± 10%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.10 ± 19%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.generic_perform_write
      0.07 ±  9%      +0.0        0.11 ± 12%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.self.cycles-pp.__cond_resched
      0.10 ±  3%      +0.0        0.15 ± 17%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.06 ±  7%      +0.0        0.11 ± 13%  perf-profile.self.cycles-pp.disk_rw
      0.07 ±  8%      +0.0        0.12 ± 11%  perf-profile.self.cycles-pp.__fget_light
      0.07 ± 14%      +0.0        0.12 ± 19%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.03 ±100%      +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.02 ± 99%      +0.1        0.08 ± 17%  perf-profile.self.cycles-pp.crypto_shash_update
      0.08 ±  4%      +0.1        0.14 ± 16%  perf-profile.self.cycles-pp.common_file_perm
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.ext4_nonda_switch
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.llseek
      0.08 ± 10%      +0.1        0.14 ± 12%  perf-profile.self.cycles-pp.__entry_text_start
      0.05 ± 77%      +0.1        0.11 ± 23%  perf-profile.self.cycles-pp.osq_lock
      0.08 ± 10%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.write
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.ext4_es_lookup_extent
      0.04 ± 71%      +0.1        0.12 ± 31%  perf-profile.self.cycles-pp.ext4_inode_csum
      0.12 ± 10%      +0.1        0.20 ± 16%  perf-profile.self.cycles-pp.crc32c_pcl_intel_update
      0.06 ± 54%      +0.1        0.16 ±  7%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.14 ±  5%      +0.1        0.24 ± 13%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.36 ±  4%      +0.1        0.48 ±  8%  perf-profile.self.cycles-pp.generic_write_end
      0.20 ± 37%      +0.2        0.38 ± 17%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.05 ±  8%      +0.2        0.26 ± 83%  perf-profile.self.cycles-pp.ext4_file_write_iter
      0.44 ±  4%      +0.2        0.67 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock
      0.05            +0.3        0.36 ± 78%  perf-profile.self.cycles-pp.ext4_da_map_blocks
      0.29 ±  2%      +0.4        0.68 ± 32%  perf-profile.self.cycles-pp.jbd2_write_access_granted
      0.03 ±100%      +0.5        0.48 ±123%  perf-profile.self.cycles-pp.__ext4_journal_get_write_access
      1.04 ±  3%      +0.5        1.56 ±  4%  perf-profile.self.cycles-pp.pagecache_get_page
      0.82 ±  4%      +0.7        1.48 ±  7%  perf-profile.self.cycles-pp.__block_commit_write
      0.15 ± 14%      +0.7        0.81 ± 99%  perf-profile.self.cycles-pp.ext4_block_write_begin
      0.11 ± 10%      +0.7        0.79 ±105%  perf-profile.self.cycles-pp.vfs_write
      0.51            +0.7        1.23 ± 44%  perf-profile.self.cycles-pp.ext4_mark_iloc_dirty
      0.10 ±  9%      +0.7        0.84 ±114%  perf-profile.self.cycles-pp.__ext4_get_inode_loc
      0.37 ± 14%      +0.7        1.11 ± 33%  perf-profile.self.cycles-pp.__find_get_block
      0.00            +0.7        0.74 ±135%  perf-profile.self.cycles-pp.ext4_buffered_write_iter
      0.20 ±  3%      +0.8        0.98 ± 26%  perf-profile.self.cycles-pp.__mark_inode_dirty
      1.44 ±  8%      +0.8        2.21 ± 17%  perf-profile.self.cycles-pp.jbd2_journal_get_write_access
      1.48 ±  7%      +0.8        2.28 ± 17%  perf-profile.self.cycles-pp.jbd2_journal_dirty_metadata
      0.04 ± 45%      +0.8        0.85 ±131%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      0.00            +0.8        0.81 ±133%  perf-profile.self.cycles-pp.file_update_time
      0.01 ±223%      +0.9        0.90 ±130%  perf-profile.self.cycles-pp.new_sync_write
      0.56 ±  5%      +1.2        1.71 ± 48%  perf-profile.self.cycles-pp.ext4_do_update_inode


                                                                                
                                  aim7.jobs-per-min                             
                                                                                
  160000 +------------------------------------------------------------------+   
         |O OOOO OOOO OOO  O OO OO  OO   O  O O OO OOO O O  OOO  O O        |   
  150000 |-+                          OO  OO   O                            |   
  140000 |-+                                                                |   
         |                                                                  |   
  130000 |-+                                                                |   
         |                                                                  |   
  120000 |-+             O        O                     O O    O  O         |   
         |                                                                  |   
  110000 |-+                                                                |   
  100000 |-+                                                                |   
         |                                                                  |   
   90000 |-+                                                                |   
         |+.++++.++++.++++.++++.+++.++++.++ +.++++.+++.++++.++++.++++.++ +.+|   
   80000 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  60000 +-------------------------------------------------------------------+   
        |O O        O     O        O                                        |   
  50000 |-+  OO OOO  OOO   O OOOO                                           |   
        |   O                       O                                       |   
        |                                                                   |   
  40000 |-+                       O                                         |   
        |                O            OOOO OOOO OOO OOO  O O OO O  O        |   
  30000 |-+                                                                 |   
        |                                              O       O            |   
  20000 |-+                                               O       O         |   
        |                                                                   |   
        |                                                                   |   
  10000 |-+                                                                 |   
        |      .+++.++++.++                                                 |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  3000 +--------------------------------------------------------------------+   
       |                                                                    |   
  2500 |-+                       O                                          |   
       |                                                                    |   
       |    O       O         O   O O                                       |   
  2000 |O+O   O OO O O OOO OOO  O                                           |   
       |   O   O                                                            |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                            O O OO  O           O       O         |   
       |                             O   O   O   OOO OOOO  OO OOO  O        |   
       |                                       O                            |   
   500 |-+                                                                  |   
       |+. ++.  + .+++.   .+ ++. +   + .++  .++ .++ .++++.  +.   .+  +.+    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                aim7.time.system_time                           
                                                                                
  19000 +-------------------------------------------------------------------+   
  18000 |+.                +.  +           ++ +.  +.          +         +   |   
        |  ++++.+++.++++.++  ++ +.+++.+++ +  +  ++  ++++.+++.+ ++.+++.++ +.+|   
  17000 |-+                              +                                  |   
  16000 |-+                                                                 |   
  15000 |-+                                                                 |   
  14000 |-+                                                                 |   
        |                                                                   |   
  13000 |-+                                                                 |   
  12000 |-+              O        O                    O  O    O  O         |   
  11000 |-+                                                                 |   
  10000 |-+                                                                 |   
        |  O  O        O      O       OOOO OOOO      O   O   O  O           |   
   9000 |O+ OO  OOO OOO   OO O OO  OO           OOO O O    O  O    O        |   
   8000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              aim7.time.elapsed_time                            
                                                                                
  220 +---------------------------------------------------------------------+   
      |  +++.+++.+++   ++  ++  ++.+++.++ +  +  ++  ++.+++.+++  +++.+++.+ +.+|   
  200 |-+                               +                                   |   
      |                                                                     |   
      |                                                                     |   
  180 |-+                                                                   |   
      |                                                                     |   
  160 |-+                                                                   |   
      |                O                               O  O    O O          |   
  140 |-+                       O                                           |   
      |                                                                     |   
      |                                                                     |   
  120 |O+OOO OOO OOO OO O OOO OO  OOO OOO OOO OOO OOO O O  OOO  O  O        |   
      |                                                                     |   
  100 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            aim7.time.elapsed_time.max                          
                                                                                
  220 +---------------------------------------------------------------------+   
      |  +++.+++.+++   ++  ++  ++.+++.++ +  +  ++  ++.+++.+++  +++.+++.+ +.+|   
  200 |-+                               +                                   |   
      |                                                                     |   
      |                                                                     |   
  180 |-+                                                                   |   
      |                                                                     |   
  160 |-+                                                                   |   
      |                O                               O  O    O O          |   
  140 |-+                       O                                           |   
      |                                                                     |   
      |                                                                     |   
  120 |O+OOO OOO OOO OO O OOO OO  OOO OOO OOO OOO OOO O O  OOO  O  O        |   
      |                                                                     |   
  100 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  5400 +--------------------------------------------------------------------+   
       |             +                                                      |   
  5200 |-+           :                                                      |   
  5000 |-+           ::                                                     |   
       |             ::                                                     |   
  4800 |-+          : :                                                     |   
       |            :  :+                                                   |   
  4600 |-+       +  +  +:                                                   |   
       |       + :+ :    :                                        +         |   
  4400 |-+++   ::  +     +           +                      +     :         |   
  4200 |-: :   :+        :  +   +    ::      + +   +    +   :+ + ::  +      |   
       | :  :  :          : ::  ::  : +     +: :+  :+   :+ :  + :: : ::    +|   
  4000 |++  + :           : :+ : ++.+  : +++  :: + : +++  ++    +  :+ : + + |   
       |     +:            :  ::       : :    :   :                +   + +  |   
  3800 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  260 +---------------------------------------------------------------------+   
      |                                                          +         +|   
  240 |-+   .+                     +   +    +              + +.++ +        :|   
  220 |-+ ++ :             ++. ++.+:   :+.  :+ ++. ++.+++.+: :     + +    : |   
      |+.+   :            +   +     : :   +:  +   +         :       + + + : |   
  200 |-+    :            :         +.+    +                +          + +  |   
      |      :            :                                                 |   
  180 |-+     :          :                                                  |   
      |       :          :                                                  |   
  160 |-+     :          :                                                  |   
  140 |-+     :          :                                                  |   
      |       :+.       :                                                   |   
  120 |-+     +  ++ .++++                                                   |   
      |            +                                                        |   
  100 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.35 +--------------------------------------------------------------------+   
       |                     :   :               :   :                      |   
   0.3 |++                   :   :               :   :                      |   
       |:                    :   :              ::  ::                      |   
       |::                   :   :              ::  ::                      |   
  0.25 |::                   ::  :              : : : :                     |   
       |::                  : : : :             : : : :                     |   
   0.2 |-:                  : : : :             : : : :                     |   
       |  :                 : : : :             : : : :                     |   
  0.15 |-++ +.+             : : : :            :  ::  :                     |   
       |   +  :            +: +.: :   +.++    +:  +:  + +      +            |   
       |       :           :+   + :.+ :   + .+ +   +   ::+ + .+ :.++++.+++. |   
   0.1 |-+     :      .++ :       +  +     +           +  + +   +          +|   
       |       +++.+++   ::                                                 |   
  0.05 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  85000 +-------------------------------------------------------------------+   
        |       +      +                                                    |   
  80000 |-+     ::+.+++ + +                                                 |   
  75000 |-+     :+       +:                                                 |   
        |      :          :                                                 |   
  70000 |-+    :          :                                                 |   
  65000 |-+    :           :                                                |   
        |      :           :                                                |   
  60000 |-+    :           :                                                |   
  55000 |-+   :            :                                           + +  |   
        |+    :            +.  +            + +.  +.  ++               :+ : |   
  50000 |-+   +              ++ +.+   +++ .+ :: ++  ++  :    +   .+ +.:   : |   
  45000 |-++++                     + +   +   +          : + + :++  +  +    :|   
        |                           +                    + +  +            +|   
  40000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  5400 +--------------------------------------------------------------------+   
       |             +                                                      |   
  5200 |-+           :                                                      |   
  5000 |-+           ::                                                     |   
       |             ::                                                     |   
  4800 |-+          : :                                                     |   
       |            :  :+                                                   |   
  4600 |-++      +  +  +:                                                   |   
       |  ::   + :+ :    :                                        +         |   
  4400 |-: +   ::  +     +           +       +              +     :  +      |   
  4200 |-: :   :+        :  +   +    ::     :: +   +    +   :+ + ::  ::     |   
       |:   :  :          : ::  ::  : +     :: :+  :+   :+ :  + :: :: :    +|   
  4000 |++  + :           : :+ : ++.+  + +++  :: + : +++  ++    +  :+  :+ + |   
       |     +:            :  ::        +     :   :                +   + +  |   
  3800 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  260 +---------------------------------------------------------------------+   
      |                                                          +         +|   
  240 |-+   .+                     +   +    +              + +.++ +        :|   
  220 |-+ ++ :             ++. ++.+:   :+.  :+ ++. ++.+++.+: :     + +    : |   
      |+.+   :            +   +     : :   +:  +   +         :       + + + : |   
  200 |-+    :            :         +.+    +                +          + +  |   
      |      :            :                                                 |   
  180 |-+     :          :                                                  |   
      |       :          :                                                  |   
  160 |-+     :          :                                                  |   
  140 |-+     :          :                                                  |   
      |       :+.       :                                                   |   
  120 |-+     +  ++ .++++                                                   |   
      |            +                                                        |   
  100 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  5400 +--------------------------------------------------------------------+   
       |                                                                    |   
  5200 |-+           +                                                      |   
  5000 |-+           ::                                                     |   
       |             ::                                                     |   
  4800 |-+          :  :                                                    |   
  4600 |-+       +  :  ++                                                   |   
       |         :+ +   :                                                   |   
  4400 |-+ +   +:  +     :           +                      +     +         |   
  4200 |-++ :  :+        +           ::      +              :: + ::  +      |   
       | +  +  :          : +   +   : +     +: +.  +.   +. : : ::: : ::     |   
  4000 |++   +:           : :+ + ++.+  : +++  :: + : ++ : ++  + +  :: :   .+|   
  3800 |-+    +            +  +        : :    +   +    +           ++  +++  |   
       |                                +                                   |   
  3600 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  3200 +--------------------------------------------------------------------+   
  3000 |-+     ++   ++.  +                                                  |   
       |       :       + :                                                  |   
  2800 |-+     :        +:                                                  |   
  2600 |-+     :          :                                                 |   
       |       :          :                                                 |   
  2400 |-+    :           :                                                 |   
  2200 |-+    :           :                                                 |   
  2000 |-+    :           :                                                 |   
       |      +            :                                      +         |   
  1800 |-+    :            :            +                        : :   ++   |   
  1600 |-+ + :             + ++. + .+  + :  .++ .++ .+++   + .+  : ++ +  +. |   
       |+.+ ::              +   + +  ++  +++   +   +    +.+ +  ++    +     +|   
  1400 |-+  +                                                               |   
  1200 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  5400 +--------------------------------------------------------------------+   
       |                                                                    |   
  5200 |-+           +                                                      |   
  5000 |-+           ::                                                     |   
       |             ::                                                     |   
  4800 |-+          :  :                                                    |   
  4600 |-+       +  :  ++                                                   |   
       |         :+ +   :                                                   |   
  4400 |-+ +   +:  +     :           +                      +     +         |   
  4200 |-++ :  :+        +           ::      +              :: + ::  +      |   
       | +  +  :          : +   +   : +     +: +.  +.   +. : : ::: : ::     |   
  4000 |++   +:           : :+ + ++.+  + +++  :: + : ++ : ++  + +  :: :   .+|   
  3800 |-+    +            +  +         +     +   +    +           ++  +++  |   
       |                                                                    |   
  3600 +--------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2sp9: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/4BRD_12G/ext4/x86_64-rhel-8.3/3000/RAID1/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp9/disk_rw/aim7/0x5003006

commit: 
  6984aef598 ("ext4: factor out write end code of inline file")
  cc883236b7 ("ext4: drop unnecessary journal handle in delalloc write")

6984aef59814fb5c cc883236b79297f6266ca6f4e7f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     84600           +83.1%     154886        aim7.jobs-per-min
    212.99           -45.3%     116.42        aim7.time.elapsed_time
    212.99           -45.3%     116.42        aim7.time.elapsed_time.max
   1708241           -60.8%     669169        aim7.time.involuntary_context_switches
    231226 ±  3%     -13.6%     199736 ±  2%  aim7.time.minor_page_faults
     17528           -47.9%       9131        aim7.time.system_time
    185350           -39.9%     111355 ±  3%  aim7.time.voluntary_context_switches
    251.74           -38.4%     155.14        uptime.boot
      6.34 ±  3%     +75.4%      11.12 ±  2%  iostat.cpu.idle
     93.23            -5.4%      88.15        iostat.cpu.system
      5.50 ±  3%      +4.3        9.75        mpstat.cpu.all.idle%
      0.00 ± 55%      +0.0        0.02 ±126%  mpstat.cpu.all.iowait%
      0.03 ±  2%      +0.0        0.05 ±  2%  mpstat.cpu.all.soft%
      0.43            +0.3        0.70        mpstat.cpu.all.usr%
      6.00           +75.0%      10.50 ±  4%  vmstat.cpu.id
    229.83 ±  2%     -26.4%     169.17 ±  4%  vmstat.procs.r
     10561           -20.2%       8427        vmstat.system.cs
    182145            +1.9%     185587        vmstat.system.in
      4.68 ± 32%      +4.0        8.64 ± 20%  turbostat.C1E%
      5.40 ±  6%     +83.7%       9.93        turbostat.CPU%c1
  39279392           -43.7%   22113174        turbostat.IRQ
     63.50            +4.2%      66.17 ±  2%  turbostat.PkgTmp
     58.18            +2.8%      59.79        turbostat.RAMWatt
    688648 ±  7%     +45.1%     999133 ±  2%  numa-meminfo.node0.Dirty
    975068 ±  6%     +35.0%    1316241 ±  2%  numa-meminfo.node0.Inactive
    690144 ±  7%     +44.9%    1000205 ±  2%  numa-meminfo.node0.Inactive(file)
    208761 ± 23%     -57.1%      89548 ±  6%  numa-meminfo.node1.Active
    208233 ± 23%     -57.1%      89347 ±  6%  numa-meminfo.node1.Active(anon)
    165882 ± 36%     -49.1%      84415 ±  8%  numa-meminfo.node1.AnonPages.max
    259403 ±  2%     -63.8%      93925 ±  5%  meminfo.Active
    257363 ±  2%     -64.3%      91990 ±  5%  meminfo.Active(anon)
    160116           -24.3%     121151        meminfo.AnonHugePages
   1412636           +27.1%    1795816        meminfo.Dirty
   1830917           +20.7%    2210679        meminfo.Inactive
   1414858           +26.9%    1795828        meminfo.Inactive(file)
   9978648 ±  2%     -12.1%    8771043 ±  4%  meminfo.Memused
    302476 ±  2%     -53.6%     140382 ±  5%  meminfo.Shmem
  10173670 ±  2%     -11.8%    8973049 ±  4%  meminfo.max_used_kB
     10073 ±  4%     -22.3%       7827 ±  3%  softirqs.CPU0.RCU
      8998 ± 17%     -35.7%       5782 ± 11%  softirqs.CPU12.RCU
      9450 ± 17%     -44.9%       5209 ± 11%  softirqs.CPU24.RCU
      8663 ± 20%     -36.8%       5475 ± 12%  softirqs.CPU47.RCU
      8860 ± 13%     -35.8%       5690 ± 11%  softirqs.CPU51.RCU
      2482 ±219%    -100.0%       0.17 ±223%  softirqs.CPU6.NET_RX
    717061 ±  3%     -34.7%     468252 ±  5%  softirqs.RCU
    486616           -17.9%     399348        softirqs.SCHED
     43043           -36.0%      27540        softirqs.TIMER
    172542 ±  7%     +45.0%     250211 ±  2%  numa-vmstat.node0.nr_dirty
    172943 ±  7%     +44.8%     250408 ±  2%  numa-vmstat.node0.nr_inactive_file
    110635 ±  6%     -42.7%      63414 ± 24%  numa-vmstat.node0.nr_written
    172945 ±  7%     +44.8%     250401 ±  2%  numa-vmstat.node0.nr_zone_inactive_file
    173612 ±  7%     +44.6%     251008 ±  2%  numa-vmstat.node0.nr_zone_write_pending
     51917 ± 23%     -57.1%      22296 ±  6%  numa-vmstat.node1.nr_active_anon
  18838796 ±  6%     -14.9%   16025868 ±  2%  numa-vmstat.node1.nr_dirtied
    100477 ± 11%     -61.2%      39030 ± 34%  numa-vmstat.node1.nr_written
     51917 ± 23%     -57.1%      22296 ±  6%  numa-vmstat.node1.nr_zone_active_anon
  20267109 ±  7%     -15.8%   17058208 ±  3%  numa-vmstat.node1.numa_hit
  20240518 ±  7%     -15.8%   17038798 ±  3%  numa-vmstat.node1.numa_local
    363813           +27.0%     462061        slabinfo.buffer_head.active_objs
      9559           +26.4%      12080        slabinfo.buffer_head.active_slabs
    372834           +26.4%     471141        slabinfo.buffer_head.num_objs
      9559           +26.4%      12080        slabinfo.buffer_head.num_slabs
      2096 ±  3%     -17.8%       1722 ±  6%  slabinfo.dquot.active_objs
      2096 ±  3%     -17.8%       1722 ±  6%  slabinfo.dquot.num_objs
    980.17 ± 11%     +19.1%       1167 ±  8%  slabinfo.ext4_allocation_context.active_objs
    980.17 ± 11%     +19.1%       1167 ±  8%  slabinfo.ext4_allocation_context.num_objs
    845.00 ± 12%     -48.6%     434.67 ± 29%  slabinfo.ext4_io_end.active_objs
    845.00 ± 12%     -48.6%     434.67 ± 29%  slabinfo.ext4_io_end.num_objs
      8742 ±  8%     -11.3%       7756 ± 10%  slabinfo.kmalloc-192.active_objs
      8973 ±  8%     -11.4%       7954 ± 10%  slabinfo.kmalloc-192.num_objs
      9575 ± 13%     -32.5%       6462 ± 11%  slabinfo.skbuff_ext_cache.active_objs
      9679 ± 12%     -32.3%       6550 ± 11%  slabinfo.skbuff_ext_cache.num_objs
     64498 ±  2%     -64.4%      22943 ±  5%  proc-vmstat.nr_active_anon
    352903           +27.6%     450182        proc-vmstat.nr_dirty
   3057769            +1.3%    3097721        proc-vmstat.nr_dirty_background_threshold
   6123015            +1.3%    6203018        proc-vmstat.nr_dirty_threshold
   1026661            +5.5%    1082635        proc-vmstat.nr_file_pages
    353358           +27.4%     450331        proc-vmstat.nr_inactive_file
     60303            -1.6%      59362        proc-vmstat.nr_kernel_stack
     75676 ±  2%     -54.1%      34771 ±  5%  proc-vmstat.nr_shmem
     49822            +2.6%      51123        proc-vmstat.nr_slab_reclaimable
    414594 ±  3%     -47.7%     216914 ± 19%  proc-vmstat.nr_written
     64498 ±  2%     -64.4%      22943 ±  5%  proc-vmstat.nr_zone_active_anon
    353358           +27.4%     450331        proc-vmstat.nr_zone_inactive_file
    354810           +27.3%     451734        proc-vmstat.nr_zone_write_pending
     83413 ±  5%     -46.4%      44711 ±  5%  proc-vmstat.numa_hint_faults
     53456 ±  6%     -58.8%      22024 ±  9%  proc-vmstat.numa_hint_faults_local
  79778462            -1.3%   78769977        proc-vmstat.numa_hit
  79747345            -1.3%   78716097        proc-vmstat.numa_local
     34732 ± 23%     -38.6%      21329 ±  8%  proc-vmstat.numa_pages_migrated
    225095 ±  4%     -34.5%     147444 ±  4%  proc-vmstat.numa_pte_updates
    117820 ±  2%     -76.5%      27642 ±  6%  proc-vmstat.pgactivate
  79756439            -1.3%   78754282        proc-vmstat.pgalloc_normal
   1029426           -26.0%     761627        proc-vmstat.pgfault
     34732 ± 23%     -38.6%      21329 ±  8%  proc-vmstat.pgmigrate_success
   1874948 ±  2%     -42.5%    1077371 ± 15%  proc-vmstat.pgpgout
     53026           -38.5%      32598        proc-vmstat.pgreuse
     14.30 ±  5%     -32.4%       9.67        perf-stat.i.MPKI
 3.119e+09           +59.6%  4.979e+09        perf-stat.i.branch-instructions
  21092251           +58.2%   33366020        perf-stat.i.branch-misses
     32.67            -0.8       31.91 ±  2%  perf-stat.i.cache-miss-rate%
  76817174 ±  2%     +11.0%   85267837        perf-stat.i.cache-misses
 2.274e+08           +12.5%  2.559e+08        perf-stat.i.cache-references
     10543           -20.8%       8355        perf-stat.i.context-switches
     14.15           -41.8%       8.24        perf-stat.i.cpi
 2.316e+11            -4.7%  2.207e+11        perf-stat.i.cpu-cycles
      3171           -12.8%       2766 ±  5%  perf-stat.i.cycles-between-cache-misses
  4.86e+09           +58.3%  7.695e+09        perf-stat.i.dTLB-loads
 2.567e+09           +58.9%  4.078e+09        perf-stat.i.dTLB-stores
     95.92            -1.9       94.07        perf-stat.i.iTLB-load-miss-rate%
  17707577           +37.7%   24385448 ±  2%  perf-stat.i.iTLB-load-misses
 1.587e+10           +59.8%  2.536e+10        perf-stat.i.instructions
      1004           +19.7%       1202 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.09 ±  3%     +67.4%       0.15 ±  2%  perf-stat.i.ipc
      2.77 ± 17%    +109.3%       5.80 ± 23%  perf-stat.i.major-faults
      2.63            -4.7%       2.51        perf-stat.i.metric.GHz
    236.06 ±  3%     +17.5%     277.34 ±  2%  perf-stat.i.metric.K/sec
    122.43           +57.9%     193.26        perf-stat.i.metric.M/sec
      4411           +31.1%       5782        perf-stat.i.minor-faults
   8076958 ±  4%     +14.6%    9256531 ±  2%  perf-stat.i.node-load-misses
   2723819           +17.1%    3188737        perf-stat.i.node-loads
     67.00            -4.8       62.23        perf-stat.i.node-store-miss-rate%
   5761014           +10.6%    6371750        perf-stat.i.node-store-misses
   2828548           +36.3%    3855487        perf-stat.i.node-stores
      4413           +31.1%       5787        perf-stat.i.page-faults
     14.33           -29.5%      10.10        perf-stat.overall.MPKI
     14.61           -40.3%       8.72        perf-stat.overall.cpi
      3017 ±  2%     -14.2%       2588        perf-stat.overall.cycles-between-cache-misses
    896.10           +16.1%       1040 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.07           +67.6%       0.11        perf-stat.overall.ipc
     67.10            -4.8       62.35        perf-stat.overall.node-store-miss-rate%
 3.105e+09           +59.1%   4.94e+09        perf-stat.ps.branch-instructions
  20953296           +57.7%   33037336        perf-stat.ps.branch-misses
  76488805           +10.7%   84695011        perf-stat.ps.cache-misses
 2.264e+08           +12.2%  2.541e+08        perf-stat.ps.cache-references
     10499           -21.1%       8282        perf-stat.ps.context-switches
 2.307e+11            -5.0%  2.192e+11        perf-stat.ps.cpu-cycles
 4.839e+09           +57.8%  7.634e+09        perf-stat.ps.dTLB-loads
 2.556e+09           +58.3%  4.046e+09        perf-stat.ps.dTLB-stores
  17628213           +37.2%   24193118 ±  2%  perf-stat.ps.iTLB-load-misses
 1.579e+10           +59.3%  2.516e+10        perf-stat.ps.instructions
      2.71 ± 17%    +105.6%       5.56 ± 23%  perf-stat.ps.major-faults
      4354           +30.8%       5696        perf-stat.ps.minor-faults
   8048917 ±  4%     +14.2%    9195137 ±  2%  perf-stat.ps.node-load-misses
   2714561           +16.7%    3168786        perf-stat.ps.node-loads
   5750000           +10.3%    6342072        perf-stat.ps.node-store-misses
   2818690           +35.9%    3829644        perf-stat.ps.node-stores
      4356           +30.9%       5701        perf-stat.ps.page-faults
  3.38e+12           -12.9%  2.945e+12        perf-stat.total.instructions
      0.07 ± 41%    +174.4%       0.20 ± 17%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.25 ±111%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.11 ± 21%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
      0.19 ± 76%     -68.9%       0.06 ± 32%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      1.89 ± 23%     -67.0%       0.62 ± 24%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.19 ± 25%     +43.4%       0.28 ± 10%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      0.02 ±  5%     -13.7%       0.02 ±  6%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      7.72 ± 23%    +173.6%      21.13 ± 59%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1347 ±125%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
     30.76 ±111%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
      6.74 ± 15%     -70.0%       2.02 ±137%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
     26.46 ± 26%     -63.5%       9.65 ± 69%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.ext4_orphan_del
    106958 ±  5%     -19.9%      85726        perf-sched.total_wait_and_delay.count.ms
     82.94 ± 18%     -51.3%      40.40 ± 13%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
    209.23 ±  7%     +12.9%     236.20 ±  4%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
    178.80 ± 11%     +31.7%     235.45 ±  3%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
    228.64 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
    201.57 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
    210.64 ±  6%     +12.3%     236.64 ±  3%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode
    232.48 ± 15%     -42.7%     133.15 ± 10%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      1399 ±  9%     -58.9%     575.84 ± 25%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
     79.98 ± 17%    +271.7%     297.27 ±  9%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
    721.05           -46.2%     387.87 ±  5%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
    237.50 ±  3%    +388.1%       1159 ±  9%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      3996 ± 23%     -30.3%       2783 ±  7%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2429 ±  7%     +37.5%       3340 ±  7%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
      1396 ± 10%   +2230.4%      32532 ±  2%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
    237.00 ± 70%    +340.6%       1044 ±  3%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc
     48258 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1524 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
      2820 ±  8%     +23.7%       3489 ± 13%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode
     20416 ±  7%     -33.0%      13676 ±  5%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.generic_perform_write.ext4_buffered_write_iter.new_sync_write
     99.50 ± 71%    +813.1%     908.50 ± 13%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers
      2431 ± 10%     -31.9%       1656 ± 14%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
    104.17 ± 15%     +57.0%     163.50 ± 11%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
    268.67 ±  8%     -43.2%     152.50 ± 49%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      3947 ±  3%     +47.6%       5825 ±  2%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3850 ±  2%     -43.0%       2193 ±  5%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      1145           +85.4%       2124 ±  5%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      4099 ±  4%     -35.8%       2632 ±  6%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4117 ±  4%     -34.8%       2686 ±  7%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
      4080 ±  4%     -33.9%       2698 ±  7%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      4201 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      4045 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
      4093 ±  3%     -34.4%       2685 ±  6%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode
      4170 ±  4%     -35.3%       2697 ±  7%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      4090 ±  4%     -34.3%       2686 ±  7%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
      4037 ±  4%     -34.6%       2640 ±  7%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      4060 ±  4%     -35.0%       2637 ±  5%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      4036 ±  5%     -44.4%       2245 ± 45%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      4041 ±  3%     -33.6%       2683 ±  7%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4135 ±  5%     -35.3%       2677 ±  7%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
     62.72 ± 10%     -51.2%      30.63 ± 12%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    209.56 ± 18%     -28.5%     149.80 ± 16%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     82.72 ± 18%     -51.5%      40.15 ± 13%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
    209.10 ±  7%     +12.9%     236.05 ±  4%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
    178.32 ± 11%     +31.9%     235.29 ±  3%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
     19.24 ± 10%    +294.2%      75.83 ± 39%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.ext4_getblk.ext4_bread
     15.43 ± 15%    +739.2%     129.49 ±126%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.ext4_read_inode_bitmap.__ext4_new_inode
     20.48 ± 17%    +182.4%      57.83 ± 46%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.block_invalidatepage.truncate_cleanup_page.truncate_inode_pages_range
    228.39 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
    201.47 ±  8%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
    210.29 ±  6%     +12.5%     236.50 ±  3%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode
    232.29 ± 15%     -42.7%     133.09 ± 10%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
     16.48 ± 16%     -43.5%       9.31 ± 48%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.grab_cache_page_write_begin.simple_write_begin
      1397 ±  9%     -58.9%     575.21 ± 25%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
     18.82 ±  3%    +368.8%      88.22 ± 33%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict
    242.30 ± 15%     -31.2%     166.69 ± 21%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
      0.00 ±172%  +2.1e+06%      97.60 ±191%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
     79.78 ± 17%    +272.3%     297.00 ±  9%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
    146.53 ± 29%     -38.6%      89.93 ± 12%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     46.06 ±107%   +1040.3%     525.23 ± 31%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__fdget_pos
    721.03           -46.2%     387.85 ±  5%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      3928 ±  4%     -32.7%       2644 ±  6%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      4099 ±  4%     -35.8%       2632 ±  6%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3924 ±  5%     -33.3%       2617 ±  6%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin
      4112 ±  4%     -34.7%       2684 ±  7%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
     34.38 ± 34%     -48.6%      17.68 ± 50%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_handle_dirty_dirblock.add_dirent_to_buf
      4080 ±  4%     -33.9%       2696 ±  7%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      3985 ±  4%     -32.9%       2675 ±  7%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc
     56.80 ± 20%   +4099.0%       2385 ±  5%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.ext4_getblk.ext4_bread
      4013 ±  4%     -34.6%       2624 ±  6%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.ext4_da_map_blocks.constprop
      3952 ±  4%     -35.8%       2537 ±  7%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.ext4_buffered_write_iter.new_sync_write
      4158 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      4042 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
      4076 ±  3%     -34.1%       2684 ±  6%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode
      4147 ±  5%     -35.0%       2694 ±  7%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      3986 ±  6%     -33.4%       2654 ±  6%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers
      4089 ±  4%     -34.4%       2684 ±  7%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
      4037 ±  4%     -34.7%       2638 ±  7%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      4058 ±  4%     -35.0%       2636 ±  5%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
     70.32 ± 15%   +3471.0%       2511 ±  6%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict
      4002 ±  3%     -33.9%       2644 ±  6%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
      4030 ±  5%     -34.6%       2637 ±  7%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      0.00 ±172%  +6.8e+06%     319.00 ±206%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      4035 ±  3%     -33.6%       2680 ±  7%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4099 ±  5%     -34.8%       2672 ±  7%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      3698 ±  8%     -35.0%       2404 ±  4%  perf-sched.wait_time.max.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
    429.33           -45.0%     236.00        interrupts.9:IO-APIC.9-fasteoi.acpi
    129821           -28.0%      93421 ±  2%  interrupts.CAL:Function_call_interrupts
      1911 ± 38%     -36.5%       1212 ± 27%  interrupts.CPU0.CAL:Function_call_interrupts
    428821           -45.0%     235782        interrupts.CPU0.LOC:Local_timer_interrupts
      1768 ± 25%     -46.7%     943.17 ±  6%  interrupts.CPU0.RES:Rescheduling_interrupts
    429.33           -45.0%     236.00        interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
      1646 ± 12%     -39.0%       1004 ±  3%  interrupts.CPU1.CAL:Function_call_interrupts
    428892           -45.0%     235763        interrupts.CPU1.LOC:Local_timer_interrupts
    429001           -45.0%     235753        interrupts.CPU10.LOC:Local_timer_interrupts
      1404 ±  4%     -25.9%       1040 ±  9%  interrupts.CPU11.CAL:Function_call_interrupts
    428877           -45.1%     235521        interrupts.CPU11.LOC:Local_timer_interrupts
      1404 ±  5%     -25.9%       1040 ±  7%  interrupts.CPU12.CAL:Function_call_interrupts
    428996           -45.1%     235647        interrupts.CPU12.LOC:Local_timer_interrupts
      1151 ± 26%     -38.5%     707.83 ±  7%  interrupts.CPU12.RES:Rescheduling_interrupts
      1400 ±  2%     -29.5%     986.67 ±  5%  interrupts.CPU13.CAL:Function_call_interrupts
    428889           -45.0%     235714        interrupts.CPU13.LOC:Local_timer_interrupts
    428967           -45.1%     235671        interrupts.CPU14.LOC:Local_timer_interrupts
      1237 ± 28%     -41.9%     718.67 ±  6%  interrupts.CPU14.RES:Rescheduling_interrupts
    428734           -45.0%     235667        interrupts.CPU15.LOC:Local_timer_interrupts
      1052 ± 10%     -30.9%     727.17 ±  3%  interrupts.CPU15.RES:Rescheduling_interrupts
      1399 ±  5%     -32.0%     951.17 ±  4%  interrupts.CPU16.CAL:Function_call_interrupts
    429020           -45.1%     235695        interrupts.CPU16.LOC:Local_timer_interrupts
      1226 ± 27%     -39.6%     740.50 ± 16%  interrupts.CPU16.RES:Rescheduling_interrupts
      1441 ±  6%     -32.6%     971.67 ±  6%  interrupts.CPU17.CAL:Function_call_interrupts
    428969           -45.1%     235641        interrupts.CPU17.LOC:Local_timer_interrupts
      1138 ± 14%     -38.7%     697.17 ±  3%  interrupts.CPU17.RES:Rescheduling_interrupts
    428835           -45.0%     235658        interrupts.CPU18.LOC:Local_timer_interrupts
      1021 ± 11%     -27.7%     737.83 ±  4%  interrupts.CPU18.RES:Rescheduling_interrupts
      1472 ± 18%     -34.0%     971.00 ±  2%  interrupts.CPU19.CAL:Function_call_interrupts
    428785           -45.0%     235697        interrupts.CPU19.LOC:Local_timer_interrupts
      1021 ±  9%     -31.8%     697.00 ±  3%  interrupts.CPU19.RES:Rescheduling_interrupts
      1804 ± 23%     -34.8%       1175 ± 22%  interrupts.CPU2.CAL:Function_call_interrupts
    428899           -45.0%     235882        interrupts.CPU2.LOC:Local_timer_interrupts
      1278 ± 26%     -41.5%     748.00 ±  5%  interrupts.CPU2.RES:Rescheduling_interrupts
      1405 ±  4%     -28.3%       1007 ±  8%  interrupts.CPU20.CAL:Function_call_interrupts
    428890           -45.1%     235512        interrupts.CPU20.LOC:Local_timer_interrupts
      1342 ±  5%     -27.5%     973.33 ±  5%  interrupts.CPU21.CAL:Function_call_interrupts
    428824           -45.1%     235502        interrupts.CPU21.LOC:Local_timer_interrupts
      1029 ±  9%     -31.8%     701.50 ±  3%  interrupts.CPU21.RES:Rescheduling_interrupts
      1501 ±  6%     -21.2%       1183 ±  8%  interrupts.CPU22.CAL:Function_call_interrupts
    429005           -45.1%     235704        interrupts.CPU22.LOC:Local_timer_interrupts
      1812 ± 38%     -59.0%     743.83 ±  8%  interrupts.CPU22.RES:Rescheduling_interrupts
      1512 ±  5%     -23.2%       1161 ± 10%  interrupts.CPU23.CAL:Function_call_interrupts
    429017           -45.1%     235694        interrupts.CPU23.LOC:Local_timer_interrupts
      1149 ± 10%     -51.8%     554.17 ±  9%  interrupts.CPU23.RES:Rescheduling_interrupts
      1548 ±  3%     -28.8%       1103 ±  4%  interrupts.CPU24.CAL:Function_call_interrupts
    429050           -45.1%     235675        interrupts.CPU24.LOC:Local_timer_interrupts
      1100 ± 11%     -52.7%     520.67 ±  6%  interrupts.CPU24.RES:Rescheduling_interrupts
      1459 ±  8%     -23.2%       1120 ±  7%  interrupts.CPU25.CAL:Function_call_interrupts
    428844           -45.0%     235681        interrupts.CPU25.LOC:Local_timer_interrupts
      1083 ± 10%     -51.0%     530.83 ±  7%  interrupts.CPU25.RES:Rescheduling_interrupts
      1548 ±  4%     -29.4%       1092 ±  6%  interrupts.CPU26.CAL:Function_call_interrupts
    428877           -45.1%     235661        interrupts.CPU26.LOC:Local_timer_interrupts
      1248 ± 20%     -58.4%     519.33 ±  7%  interrupts.CPU26.RES:Rescheduling_interrupts
    428925           -45.1%     235668        interrupts.CPU27.LOC:Local_timer_interrupts
      1077 ± 10%     -51.3%     525.17 ±  8%  interrupts.CPU27.RES:Rescheduling_interrupts
    428859           -45.0%     235659        interrupts.CPU28.LOC:Local_timer_interrupts
      1063 ± 10%     -49.6%     536.00 ± 15%  interrupts.CPU28.RES:Rescheduling_interrupts
      1507 ±  3%     -30.7%       1043 ±  6%  interrupts.CPU29.CAL:Function_call_interrupts
    428884           -45.1%     235664        interrupts.CPU29.LOC:Local_timer_interrupts
      1165 ± 18%     -56.9%     502.50 ±  6%  interrupts.CPU29.RES:Rescheduling_interrupts
    428891           -45.0%     235780        interrupts.CPU3.LOC:Local_timer_interrupts
      1092 ±  9%     -35.7%     702.50 ±  4%  interrupts.CPU3.RES:Rescheduling_interrupts
      1467 ±  3%     -29.6%       1033 ±  3%  interrupts.CPU30.CAL:Function_call_interrupts
    428873           -45.0%     235684        interrupts.CPU30.LOC:Local_timer_interrupts
      1404 ± 49%     -64.6%     497.50 ±  5%  interrupts.CPU30.RES:Rescheduling_interrupts
      1594 ± 17%     -32.7%       1072 ±  7%  interrupts.CPU31.CAL:Function_call_interrupts
    428892           -45.0%     235691        interrupts.CPU31.LOC:Local_timer_interrupts
      1227 ±  8%     -54.7%     556.00 ±  9%  interrupts.CPU31.RES:Rescheduling_interrupts
      1454 ±  4%     -25.7%       1080 ± 14%  interrupts.CPU32.CAL:Function_call_interrupts
    428870           -45.0%     235665        interrupts.CPU32.LOC:Local_timer_interrupts
      1130 ±  6%     -55.5%     503.00 ±  4%  interrupts.CPU32.RES:Rescheduling_interrupts
      1455 ±  2%     -30.5%       1011 ±  5%  interrupts.CPU33.CAL:Function_call_interrupts
    428852           -45.0%     235668        interrupts.CPU33.LOC:Local_timer_interrupts
      1140 ±  7%     -54.7%     516.17 ±  6%  interrupts.CPU33.RES:Rescheduling_interrupts
      1405 ±  3%     -27.0%       1025 ±  8%  interrupts.CPU34.CAL:Function_call_interrupts
    428881           -45.1%     235661        interrupts.CPU34.LOC:Local_timer_interrupts
      1072 ±  9%     -49.7%     539.17 ± 10%  interrupts.CPU34.RES:Rescheduling_interrupts
    428906           -45.1%     235657        interrupts.CPU35.LOC:Local_timer_interrupts
      1093 ± 12%     -53.1%     512.83 ±  6%  interrupts.CPU35.RES:Rescheduling_interrupts
      1437 ±  4%     -29.8%       1009 ±  7%  interrupts.CPU36.CAL:Function_call_interrupts
    428877           -45.0%     235672        interrupts.CPU36.LOC:Local_timer_interrupts
      1149 ± 13%     -56.3%     502.83 ±  6%  interrupts.CPU36.RES:Rescheduling_interrupts
      1422 ±  2%     -22.4%       1103 ±  9%  interrupts.CPU37.CAL:Function_call_interrupts
    428933           -45.1%     235668        interrupts.CPU37.LOC:Local_timer_interrupts
      1142 ± 20%     -54.0%     525.17 ±  7%  interrupts.CPU37.RES:Rescheduling_interrupts
      1411 ±  2%     -27.4%       1024 ±  7%  interrupts.CPU38.CAL:Function_call_interrupts
    428865           -45.0%     235666        interrupts.CPU38.LOC:Local_timer_interrupts
      1222 ± 32%     -56.9%     527.50 ± 11%  interrupts.CPU38.RES:Rescheduling_interrupts
      1421 ±  3%     -26.1%       1050 ± 10%  interrupts.CPU39.CAL:Function_call_interrupts
    428886           -45.0%     235695        interrupts.CPU39.LOC:Local_timer_interrupts
      1056 ±  9%     -50.8%     519.50 ±  7%  interrupts.CPU39.RES:Rescheduling_interrupts
      1903 ± 31%     -42.7%       1089 ± 22%  interrupts.CPU4.CAL:Function_call_interrupts
    428856           -45.0%     235746        interrupts.CPU4.LOC:Local_timer_interrupts
      1012 ± 12%     -27.9%     730.50 ±  5%  interrupts.CPU4.RES:Rescheduling_interrupts
      1456 ±  4%     -33.4%     970.83 ±  8%  interrupts.CPU40.CAL:Function_call_interrupts
    428883           -45.0%     235681        interrupts.CPU40.LOC:Local_timer_interrupts
      1124 ±  8%     -55.1%     504.67 ±  5%  interrupts.CPU40.RES:Rescheduling_interrupts
      1471 ±  6%     -34.9%     957.67 ±  9%  interrupts.CPU41.CAL:Function_call_interrupts
    428837           -45.0%     235672        interrupts.CPU41.LOC:Local_timer_interrupts
      1284 ± 31%     -60.7%     504.33 ±  5%  interrupts.CPU41.RES:Rescheduling_interrupts
      1449 ±  6%     -30.4%       1009 ±  7%  interrupts.CPU42.CAL:Function_call_interrupts
    428857           -45.1%     235646        interrupts.CPU42.LOC:Local_timer_interrupts
      1210 ± 18%     -57.1%     519.17 ±  8%  interrupts.CPU42.RES:Rescheduling_interrupts
      2680 ±  3%     -40.8%       1586 ±  5%  interrupts.CPU43.CAL:Function_call_interrupts
    428889           -45.0%     235698        interrupts.CPU43.LOC:Local_timer_interrupts
      2287 ±  8%     -50.4%       1135 ± 27%  interrupts.CPU43.RES:Rescheduling_interrupts
    428798           -45.0%     235789        interrupts.CPU44.LOC:Local_timer_interrupts
      1362 ±  2%     -28.7%     971.67 ±  3%  interrupts.CPU45.CAL:Function_call_interrupts
    428709           -45.0%     235597        interrupts.CPU45.LOC:Local_timer_interrupts
      1018 ±  9%     -29.1%     722.33 ±  7%  interrupts.CPU45.RES:Rescheduling_interrupts
      1412 ±  3%     -28.3%       1012 ±  5%  interrupts.CPU46.CAL:Function_call_interrupts
    428808           -45.0%     235712        interrupts.CPU46.LOC:Local_timer_interrupts
      1207 ± 35%     -39.9%     726.00 ±  6%  interrupts.CPU46.RES:Rescheduling_interrupts
      1363 ±  3%     -26.6%       1000 ±  6%  interrupts.CPU47.CAL:Function_call_interrupts
    428901           -45.1%     235662        interrupts.CPU47.LOC:Local_timer_interrupts
      1018 ± 12%     -26.1%     753.00 ±  7%  interrupts.CPU47.RES:Rescheduling_interrupts
      1915 ± 64%     -50.2%     954.67 ±  2%  interrupts.CPU48.CAL:Function_call_interrupts
    428879           -45.0%     235734        interrupts.CPU48.LOC:Local_timer_interrupts
      1267 ± 44%     -44.6%     702.00 ±  5%  interrupts.CPU48.RES:Rescheduling_interrupts
      1376 ±  3%     -29.8%     966.33 ±  4%  interrupts.CPU49.CAL:Function_call_interrupts
    428924           -45.0%     235756        interrupts.CPU49.LOC:Local_timer_interrupts
      1146 ± 15%     -34.4%     752.83 ± 10%  interrupts.CPU49.RES:Rescheduling_interrupts
      1573 ± 10%     -24.4%       1189 ± 17%  interrupts.CPU5.CAL:Function_call_interrupts
    428851           -45.0%     235749        interrupts.CPU5.LOC:Local_timer_interrupts
      1201 ± 32%     -37.5%     750.83 ±  7%  interrupts.CPU5.RES:Rescheduling_interrupts
      1353 ±  5%     -30.1%     946.17 ±  3%  interrupts.CPU50.CAL:Function_call_interrupts
    428829           -45.0%     235705        interrupts.CPU50.LOC:Local_timer_interrupts
      1019 ± 10%     -31.9%     693.83 ±  3%  interrupts.CPU50.RES:Rescheduling_interrupts
      1333 ±  5%     -28.8%     949.50 ±  4%  interrupts.CPU51.CAL:Function_call_interrupts
    428880           -45.0%     235719        interrupts.CPU51.LOC:Local_timer_interrupts
      1104 ± 18%     -35.5%     712.67 ±  3%  interrupts.CPU51.RES:Rescheduling_interrupts
      1386 ±  2%     -30.0%     971.00 ±  5%  interrupts.CPU52.CAL:Function_call_interrupts
    428827           -45.0%     235716        interrupts.CPU52.LOC:Local_timer_interrupts
      1196 ± 23%     -40.6%     710.00 ±  9%  interrupts.CPU52.RES:Rescheduling_interrupts
      1385 ±  3%     -29.8%     972.33 ±  4%  interrupts.CPU53.CAL:Function_call_interrupts
    428856           -45.0%     235676        interrupts.CPU53.LOC:Local_timer_interrupts
      1026 ±  7%     -30.5%     713.33 ±  6%  interrupts.CPU53.RES:Rescheduling_interrupts
      1446 ±  7%     -34.5%     947.83 ±  3%  interrupts.CPU54.CAL:Function_call_interrupts
    428871           -45.0%     235748        interrupts.CPU54.LOC:Local_timer_interrupts
      1307 ± 21%     -43.4%     739.83 ±  8%  interrupts.CPU54.RES:Rescheduling_interrupts
      1408 ±  7%     -29.7%     990.33 ±  9%  interrupts.CPU55.CAL:Function_call_interrupts
    428878           -45.0%     235715        interrupts.CPU55.LOC:Local_timer_interrupts
      1071 ± 13%     -26.5%     787.67 ± 18%  interrupts.CPU55.RES:Rescheduling_interrupts
      1350 ±  3%     -25.0%       1012 ± 11%  interrupts.CPU56.CAL:Function_call_interrupts
    428937           -45.1%     235690        interrupts.CPU56.LOC:Local_timer_interrupts
      1361 ±  3%     -26.7%     997.83 ±  4%  interrupts.CPU57.CAL:Function_call_interrupts
    428893           -45.0%     235776        interrupts.CPU57.LOC:Local_timer_interrupts
      2040 ±104%     -62.9%     757.33 ±  9%  interrupts.CPU57.RES:Rescheduling_interrupts
      1340 ±  2%     -25.6%     997.00 ±  7%  interrupts.CPU58.CAL:Function_call_interrupts
    428899           -45.1%     235667        interrupts.CPU58.LOC:Local_timer_interrupts
      1379 ±  5%     -28.7%     983.33 ±  4%  interrupts.CPU59.CAL:Function_call_interrupts
    428820           -45.0%     235736        interrupts.CPU59.LOC:Local_timer_interrupts
      1302 ± 28%     -43.6%     735.00 ±  5%  interrupts.CPU59.RES:Rescheduling_interrupts
      1850 ± 33%     -46.7%     985.50 ±  3%  interrupts.CPU6.CAL:Function_call_interrupts
    428869           -45.0%     235687        interrupts.CPU6.LOC:Local_timer_interrupts
      1361 ±  2%     -28.1%     978.33 ±  8%  interrupts.CPU60.CAL:Function_call_interrupts
    428897           -45.0%     235841        interrupts.CPU60.LOC:Local_timer_interrupts
      1166 ± 28%     -38.0%     722.50 ±  6%  interrupts.CPU60.RES:Rescheduling_interrupts
      1430 ± 11%     -30.8%     989.83 ±  6%  interrupts.CPU61.CAL:Function_call_interrupts
    428893           -45.0%     235716        interrupts.CPU61.LOC:Local_timer_interrupts
      1143 ± 13%     -38.2%     707.00 ±  6%  interrupts.CPU61.RES:Rescheduling_interrupts
      1360 ±  4%     -27.1%     991.67 ±  3%  interrupts.CPU62.CAL:Function_call_interrupts
    428924           -45.1%     235676        interrupts.CPU62.LOC:Local_timer_interrupts
      1371 ±  4%     -28.7%     977.67 ±  2%  interrupts.CPU63.CAL:Function_call_interrupts
    428991           -45.1%     235705        interrupts.CPU63.LOC:Local_timer_interrupts
      1112 ± 23%     -35.2%     721.33 ±  8%  interrupts.CPU63.RES:Rescheduling_interrupts
      1436 ± 12%     -30.5%     999.00 ±  5%  interrupts.CPU64.CAL:Function_call_interrupts
    428917           -45.0%     235749        interrupts.CPU64.LOC:Local_timer_interrupts
      1367 ±  6%     -29.4%     965.67 ±  4%  interrupts.CPU65.CAL:Function_call_interrupts
    428882           -45.1%     235635        interrupts.CPU65.LOC:Local_timer_interrupts
      1048 ± 11%     -32.1%     711.67 ±  8%  interrupts.CPU65.RES:Rescheduling_interrupts
      1359 ±  2%     -27.3%     988.83 ±  8%  interrupts.CPU66.CAL:Function_call_interrupts
    428872           -45.0%     235677        interrupts.CPU66.LOC:Local_timer_interrupts
      1006 ± 10%     -50.5%     498.33 ±  7%  interrupts.CPU66.RES:Rescheduling_interrupts
      1693 ± 34%     -39.8%       1019 ±  6%  interrupts.CPU67.CAL:Function_call_interrupts
    428875           -45.0%     235694        interrupts.CPU67.LOC:Local_timer_interrupts
      1103 ± 18%     -53.2%     515.83 ±  4%  interrupts.CPU67.RES:Rescheduling_interrupts
      1444 ±  5%     -29.7%       1015 ±  4%  interrupts.CPU68.CAL:Function_call_interrupts
    428909           -45.0%     235709        interrupts.CPU68.LOC:Local_timer_interrupts
      1100 ± 16%     -53.9%     507.67 ±  6%  interrupts.CPU68.RES:Rescheduling_interrupts
      1420 ±  3%     -28.3%       1019 ±  6%  interrupts.CPU69.CAL:Function_call_interrupts
    428902           -45.0%     235753        interrupts.CPU69.LOC:Local_timer_interrupts
      1084 ± 10%     -52.0%     520.50 ±  6%  interrupts.CPU69.RES:Rescheduling_interrupts
      1587 ± 21%     -33.5%       1055 ± 10%  interrupts.CPU7.CAL:Function_call_interrupts
    429046           -45.1%     235630        interrupts.CPU7.LOC:Local_timer_interrupts
      1200 ± 26%     -39.7%     724.17 ±  4%  interrupts.CPU7.RES:Rescheduling_interrupts
      1432 ±  3%     -28.3%       1027 ±  7%  interrupts.CPU70.CAL:Function_call_interrupts
    428901           -45.0%     235718        interrupts.CPU70.LOC:Local_timer_interrupts
      1078 ±  8%     -50.9%     529.17 ± 11%  interrupts.CPU70.RES:Rescheduling_interrupts
      1427 ±  3%     -26.7%       1046 ±  6%  interrupts.CPU71.CAL:Function_call_interrupts
    428899           -45.0%     235732        interrupts.CPU71.LOC:Local_timer_interrupts
      1153 ± 20%     -52.7%     545.67 ±  8%  interrupts.CPU71.RES:Rescheduling_interrupts
      1446 ±  3%     -30.4%       1006 ±  6%  interrupts.CPU72.CAL:Function_call_interrupts
    428900           -45.0%     235702        interrupts.CPU72.LOC:Local_timer_interrupts
      1090 ± 12%     -53.1%     511.50 ±  2%  interrupts.CPU72.RES:Rescheduling_interrupts
      1390           -27.8%       1003 ±  6%  interrupts.CPU73.CAL:Function_call_interrupts
    428906           -45.0%     235701        interrupts.CPU73.LOC:Local_timer_interrupts
      1034 ±  9%     -50.7%     510.17 ± 10%  interrupts.CPU73.RES:Rescheduling_interrupts
      1439 ±  2%     -30.9%     994.33 ±  4%  interrupts.CPU74.CAL:Function_call_interrupts
    428923           -45.1%     235689        interrupts.CPU74.LOC:Local_timer_interrupts
      1184 ± 22%     -57.6%     502.17 ±  5%  interrupts.CPU74.RES:Rescheduling_interrupts
      1555 ± 24%     -34.7%       1015 ±  4%  interrupts.CPU75.CAL:Function_call_interrupts
    428909           -45.1%     235665        interrupts.CPU75.LOC:Local_timer_interrupts
      1121 ±  8%     -49.1%     571.00 ± 28%  interrupts.CPU75.RES:Rescheduling_interrupts
      1654 ± 31%     -40.1%     991.50 ±  5%  interrupts.CPU76.CAL:Function_call_interrupts
    428896           -45.0%     235723        interrupts.CPU76.LOC:Local_timer_interrupts
      1125 ±  9%     -57.1%     482.67 ±  7%  interrupts.CPU76.RES:Rescheduling_interrupts
      1413 ±  2%     -23.9%       1075 ± 13%  interrupts.CPU77.CAL:Function_call_interrupts
    428897           -45.0%     235686        interrupts.CPU77.LOC:Local_timer_interrupts
      1084 ±  8%     -54.3%     495.00 ±  5%  interrupts.CPU77.RES:Rescheduling_interrupts
      1401           -28.5%       1001 ±  9%  interrupts.CPU78.CAL:Function_call_interrupts
    428921           -45.0%     235699        interrupts.CPU78.LOC:Local_timer_interrupts
      1156 ± 26%     -56.3%     505.33 ±  6%  interrupts.CPU78.RES:Rescheduling_interrupts
      1468 ±  6%     -32.0%     999.50 ±  6%  interrupts.CPU79.CAL:Function_call_interrupts
    428942           -45.1%     235680        interrupts.CPU79.LOC:Local_timer_interrupts
      1101 ± 17%     -54.5%     501.83 ±  4%  interrupts.CPU79.RES:Rescheduling_interrupts
    428832           -45.0%     235717        interrupts.CPU8.LOC:Local_timer_interrupts
      1420 ±  2%     -27.7%       1026 ±  5%  interrupts.CPU80.CAL:Function_call_interrupts
    428875           -45.0%     235728        interrupts.CPU80.LOC:Local_timer_interrupts
      1082 ± 12%     -52.5%     514.17 ±  5%  interrupts.CPU80.RES:Rescheduling_interrupts
      1426 ±  4%     -26.2%       1052 ± 10%  interrupts.CPU81.CAL:Function_call_interrupts
    428905           -45.1%     235649        interrupts.CPU81.LOC:Local_timer_interrupts
      1141 ± 13%     -55.5%     508.33 ±  8%  interrupts.CPU81.RES:Rescheduling_interrupts
      1439           -27.7%       1040 ±  5%  interrupts.CPU82.CAL:Function_call_interrupts
    428885           -45.0%     235699        interrupts.CPU82.LOC:Local_timer_interrupts
      1299 ± 13%     -58.3%     542.17 ± 14%  interrupts.CPU82.RES:Rescheduling_interrupts
      1414 ±  2%     -29.0%       1004 ±  7%  interrupts.CPU83.CAL:Function_call_interrupts
    428915           -45.0%     235698        interrupts.CPU83.LOC:Local_timer_interrupts
      1068 ±  8%     -52.2%     510.67 ±  8%  interrupts.CPU83.RES:Rescheduling_interrupts
      1402 ±  7%     -29.3%     990.67 ±  5%  interrupts.CPU84.CAL:Function_call_interrupts
    428911           -45.0%     235703        interrupts.CPU84.LOC:Local_timer_interrupts
      1124 ±  8%     -55.1%     505.33 ±  9%  interrupts.CPU84.RES:Rescheduling_interrupts
      1437 ±  3%     -28.6%       1026 ±  7%  interrupts.CPU85.CAL:Function_call_interrupts
    428953           -45.1%     235677        interrupts.CPU85.LOC:Local_timer_interrupts
      1086 ± 10%     -52.3%     518.33 ±  6%  interrupts.CPU85.RES:Rescheduling_interrupts
    428908           -45.0%     235686        interrupts.CPU86.LOC:Local_timer_interrupts
      1034 ± 10%     -42.2%     598.50 ± 36%  interrupts.CPU86.RES:Rescheduling_interrupts
      1407 ±  5%     -26.4%       1036 ±  4%  interrupts.CPU87.CAL:Function_call_interrupts
    428896           -45.0%     235693        interrupts.CPU87.LOC:Local_timer_interrupts
      1143 ±  7%     -53.9%     527.33 ±  4%  interrupts.CPU87.RES:Rescheduling_interrupts
    428924           -45.0%     235714        interrupts.CPU9.LOC:Local_timer_interrupts
  37742579           -45.0%   20741077        interrupts.LOC:Local_timer_interrupts
    102143 ±  2%     -44.0%      57170        interrupts.RES:Rescheduling_interrupts
     59.38           -59.4        0.00        perf-profile.calltrace.cycles-pp.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
     64.18           -58.9        5.32 ±  8%  perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
     56.66           -56.7        0.00        perf-profile.calltrace.cycles-pp.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
     56.34           -56.3        0.00        perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write
     27.62 ±  2%     -27.6        0.00        perf-profile.calltrace.cycles-pp.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
     16.52 ±  6%     -16.5        0.00        perf-profile.calltrace.cycles-pp.__ext4_journal_stop.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
     16.30 ±  6%     -16.3        0.00        perf-profile.calltrace.cycles-pp.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
     10.96 ±  5%     -11.0        0.00        perf-profile.calltrace.cycles-pp.generic_write_end.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
     10.07 ±  4%     -10.1        0.00        perf-profile.calltrace.cycles-pp.add_transaction_credits.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
      9.14 ±  9%      -9.1        0.00        perf-profile.calltrace.cycles-pp.stop_this_handle.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end.generic_perform_write
      9.00 ±  2%      -9.0        0.00        perf-profile.calltrace.cycles-pp._raw_read_lock.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
      8.15 ±  6%      -8.2        0.00        perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_write_end.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
      6.88 ±  6%      -6.9        0.00        perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.ext4_da_write_end.generic_perform_write
      5.48 ±  5%      -5.5        0.00        perf-profile.calltrace.cycles-pp.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.ext4_da_write_end
     97.33            -2.2       95.10        perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     97.44            -2.1       95.33        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     97.76            -1.8       95.95        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.85            -1.7       96.12        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.95            -1.6       96.31        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     98.00            -1.6       96.38        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     92.72            -1.5       91.26        perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write
     98.24            -1.4       96.81        perf-profile.calltrace.cycles-pp.write
      2.59            -0.1        2.48 ±  2%  perf-profile.calltrace.cycles-pp.generic_update_time.file_update_time.ext4_write_checks.ext4_buffered_write_iter.new_sync_write
      2.59            -0.1        2.48 ±  2%  perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_update_time.file_update_time.ext4_write_checks.ext4_buffered_write_iter
      0.53 ±  2%      +0.2        0.76 ± 17%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      0.73 ±  2%      +0.4        1.13 ± 14%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write
      0.53 ±  3%      +0.5        0.99 ± 23%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.43 ± 44%      +0.5        0.92 ± 25%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter
      0.00            +0.6        0.55 ±  9%  perf-profile.calltrace.cycles-pp.create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.73 ±  3%      +0.6        1.30 ±  5%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill.dput
      0.00            +0.6        0.63 ±  6%  perf-profile.calltrace.cycles-pp.truncate_cleanup_page.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      0.83 ±  3%      +0.6        1.48 ±  6%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
      0.82 ±  3%      +0.6        1.47 ±  5%  perf-profile.calltrace.cycles-pp.ext4_evict_inode.evict.__dentry_kill.dput.__fput
      0.84 ±  3%      +0.7        1.49 ±  6%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_prepare
      0.84 ±  3%      +0.7        1.50 ±  6%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00            +0.7        0.66 ±  2%  perf-profile.calltrace.cycles-pp.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.84 ±  3%      +0.7        1.50 ±  6%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.84 ±  3%      +0.7        1.50 ±  6%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.84 ±  3%      +0.7        1.50 ±  6%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.84 ±  3%      +0.7        1.50 ±  6%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.85 ±  3%      +0.7        1.52 ±  6%  perf-profile.calltrace.cycles-pp.__close
      0.85 ±  3%      +0.7        1.51 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      0.85 ±  3%      +0.7        1.51 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +0.7        0.67 ±  2%  perf-profile.calltrace.cycles-pp.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.00            +0.8        0.80 ±  7%  perf-profile.calltrace.cycles-pp.jbd2_write_access_granted.jbd2_journal_get_write_access.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty
      0.66 ±  3%      +0.8        1.46 ± 20%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
      0.93 ±  3%      +0.9        1.85 ± 11%  perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      1.37 ± 10%      +1.0        2.38 ±  3%  perf-profile.calltrace.cycles-pp.jbd2_journal_dirty_metadata.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty
      1.36 ± 10%      +1.1        2.42 ±  3%  perf-profile.calltrace.cycles-pp.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      2.02            +1.1        3.17 ±  6%  perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      2.04            +1.2        3.22 ±  6%  perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      1.49 ± 12%      +1.2        2.68 ±  5%  perf-profile.calltrace.cycles-pp.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode
      0.00            +1.3        1.30 ±  2%  perf-profile.calltrace.cycles-pp.__find_get_block.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      0.00            +1.3        1.32 ±  4%  perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.generic_write_end.generic_perform_write
      0.00            +1.3        1.34 ±  2%  perf-profile.calltrace.cycles-pp.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty
      1.60 ±  8%      +1.5        3.09 ±  4%  perf-profile.calltrace.cycles-pp.jbd2_journal_get_write_access.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
      0.00            +1.6        1.58 ±  2%  perf-profile.calltrace.cycles-pp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
      1.68 ±  8%      +1.6        3.25 ±  3%  perf-profile.calltrace.cycles-pp.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      0.00            +1.6        1.59 ±  2%  perf-profile.calltrace.cycles-pp.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      2.81 ±  6%      +2.4        5.23 ±  4%  perf-profile.calltrace.cycles-pp.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      2.10 ±  6%      +2.8        4.87 ±  2%  perf-profile.calltrace.cycles-pp.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      3.34 ±  4%      +2.8        6.12 ±  3%  perf-profile.calltrace.cycles-pp.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      0.00            +3.1        3.08 ±  9%  perf-profile.calltrace.cycles-pp.block_write_end.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.00            +4.0        3.97 ± 24%  perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00            +7.0        7.00 ±  5%  perf-profile.calltrace.cycles-pp.stop_this_handle.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end
      0.00            +8.5        8.52 ±  2%  perf-profile.calltrace.cycles-pp.add_transaction_credits.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      0.00            +8.6        8.57 ±  3%  perf-profile.calltrace.cycles-pp._raw_read_lock.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      0.00           +11.1       11.09 ±  2%  perf-profile.calltrace.cycles-pp.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write
      0.00           +13.0       12.97 ±  4%  perf-profile.calltrace.cycles-pp.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write
      0.00           +13.3       13.30 ±  4%  perf-profile.calltrace.cycles-pp.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      1.64 ±  2%     +51.3       52.90 ±  2%  perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      0.00           +51.7       51.68 ±  2%  perf-profile.calltrace.cycles-pp.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      0.00           +54.1       54.13 ±  2%  perf-profile.calltrace.cycles-pp.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write
      0.00           +65.3       65.26 ±  2%  perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00           +79.3       79.25        perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.00           +83.9       83.87        perf-profile.calltrace.cycles-pp.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
     64.18           -58.9        5.33 ±  8%  perf-profile.children.cycles-pp.ext4_da_write_begin
     27.62 ±  2%     -27.5        0.14 ± 30%  perf-profile.children.cycles-pp.ext4_da_write_end
     62.58            -6.6       55.98 ±  2%  perf-profile.children.cycles-pp.__ext4_journal_start_sb
     58.12            -5.0       53.09 ±  2%  perf-profile.children.cycles-pp.start_this_handle
     58.41            -5.0       53.45 ±  2%  perf-profile.children.cycles-pp.jbd2__journal_start
     18.14 ±  5%      -4.4       13.77 ±  4%  perf-profile.children.cycles-pp.__ext4_journal_stop
     17.80 ±  5%      -4.4       13.44 ±  4%  perf-profile.children.cycles-pp.jbd2_journal_stop
     97.33            -2.2       95.11        perf-profile.children.cycles-pp.ext4_buffered_write_iter
      9.42 ±  9%      -2.2        7.25 ±  5%  perf-profile.children.cycles-pp.stop_this_handle
     97.46            -2.1       95.36        perf-profile.children.cycles-pp.new_sync_write
     97.78            -1.8       95.99        perf-profile.children.cycles-pp.vfs_write
     97.87            -1.7       96.14        perf-profile.children.cycles-pp.ksys_write
      4.14 ± 10%      -1.6        2.50 ±  3%  perf-profile.children.cycles-pp.ext4_journal_check_start
     10.38 ±  4%      -1.6        8.83        perf-profile.children.cycles-pp.add_transaction_credits
     92.76            -1.4       91.32        perf-profile.children.cycles-pp.generic_perform_write
     98.31            -1.4       96.93        perf-profile.children.cycles-pp.write
      1.18 ± 12%      -0.7        0.45 ±  6%  perf-profile.children.cycles-pp.up_write
     99.36            -0.5       98.90        perf-profile.children.cycles-pp.do_syscall_64
     99.43            -0.4       98.99        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      9.33 ±  2%      -0.4        8.93 ±  3%  perf-profile.children.cycles-pp._raw_read_lock
      0.66 ±  2%      -0.2        0.46 ±  4%  perf-profile.children.cycles-pp.unlock_page
      0.57 ±  5%      -0.1        0.45 ±  6%  perf-profile.children.cycles-pp.down_write
      2.59            -0.1        2.48 ±  2%  perf-profile.children.cycles-pp.generic_update_time
      0.08 ±  5%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.07 ±  7%      +0.0        0.09 ± 12%  perf-profile.children.cycles-pp.try_charge_memcg
      0.07 ±  5%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.find_lock_entries
      0.06 ±  8%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.current_time
      0.21 ±  2%      +0.0        0.24 ±  6%  perf-profile.children.cycles-pp.tick_sched_handle
      0.21 ±  2%      +0.0        0.24 ±  6%  perf-profile.children.cycles-pp.update_process_times
      0.23 ±  2%      +0.0        0.26 ±  6%  perf-profile.children.cycles-pp.tick_sched_timer
      0.05 ±  8%      +0.0        0.09 ±  8%  perf-profile.children.cycles-pp.generic_write_checks
      0.06 ±  9%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.xas_store
      0.45 ±  3%      +0.0        0.48 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.29 ±  3%      +0.0        0.33 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.11            +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.04 ± 44%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.07 ±  5%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.ext4_generic_write_checks
      0.05 ±  8%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.crypto_shash_update
      0.04 ± 47%      +0.0        0.09 ± 12%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.10 ±  9%      +0.0        0.15 ±  6%  perf-profile.children.cycles-pp.block_invalidatepage
      0.02 ±141%      +0.0        0.06        perf-profile.children.cycles-pp.rcu_all_qs
      0.06 ±  7%      +0.0        0.11 ±  5%  perf-profile.children.cycles-pp.__ext4_new_inode
      0.62 ±  3%      +0.0        0.66 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.07 ±  7%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.ksys_lseek
      0.13 ±  5%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__might_sleep
      0.05 ±  8%      +0.0        0.10 ± 13%  perf-profile.children.cycles-pp.rmqueue
      0.07 ±  5%      +0.0        0.12 ±  7%  perf-profile.children.cycles-pp.free_buffer_head
      0.08 ±  4%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__mod_node_page_state
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__dquot_alloc_space
      0.04 ± 44%      +0.1        0.10 ± 13%  perf-profile.children.cycles-pp.__ext4_unlink
      0.00            +0.1        0.05 ± 13%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.drop_buffers
      0.14 ±  3%      +0.1        0.19 ±  6%  perf-profile.children.cycles-pp.kmem_cache_free
      0.01 ±223%      +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.page_cache_free_page
      0.08            +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.__fget_light
      0.50 ±  3%      +0.1        0.56 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.ext4_add_nondir
      0.00            +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.__es_insert_extent
      0.00            +0.1        0.06 ± 23%  perf-profile.children.cycles-pp.errseq_check
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.ext4_fc_track_inode
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.xas_start
      0.05 ±  8%      +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.ext4_file_write_iter
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.down_read
      0.08 ±  6%      +0.1        0.14        perf-profile.children.cycles-pp.disk_rw
      0.09 ±  7%      +0.1        0.15 ± 11%  perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.11 ±  4%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.01 ±223%      +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.10 ±  5%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.__fdget_pos
      0.06 ±  9%      +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.__cancel_dirty_page
      0.03 ± 70%      +0.1        0.10 ±  9%  perf-profile.children.cycles-pp.page_counter_cancel
      0.00            +0.1        0.07 ± 27%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.07 ± 18%  perf-profile.children.cycles-pp.ext4_nonda_switch
      0.09 ±  5%      +0.1        0.16 ±  5%  perf-profile.children.cycles-pp.ext4_unlink
      0.10 ±  3%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.xas_load
      0.06 ±  6%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.ext4_da_reserve_space
      0.09            +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.vfs_unlink
      0.10 ±  4%      +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.ext4_create
      0.03 ± 70%      +0.1        0.11 ± 11%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.04 ± 71%      +0.1        0.12 ±  9%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.10 ±  4%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.00            +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.03 ± 70%      +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.ext4_es_insert_delayed_block
      0.10 ±  4%      +0.1        0.19 ± 13%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.02 ±141%      +0.1        0.10 ± 13%  perf-profile.children.cycles-pp.uncharge_batch
      0.03 ±102%      +0.1        0.12 ± 18%  perf-profile.children.cycles-pp.osq_lock
      0.00            +0.1        0.09 ± 13%  perf-profile.children.cycles-pp.account_page_cleaned
      0.00            +0.1        0.10 ± 34%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.02 ±141%      +0.1        0.12 ± 29%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.09 ±  6%      +0.1        0.19 ±  4%  perf-profile.children.cycles-pp.common_file_perm
      0.13 ±  5%      +0.1        0.24 ± 10%  perf-profile.children.cycles-pp.__alloc_pages
      0.15 ±  4%      +0.1        0.26 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.21 ±  3%      +0.1        0.32 ±  4%  perf-profile.children.cycles-pp.___might_sleep
      0.00            +0.1        0.12 ± 14%  perf-profile.children.cycles-pp.lock_page_lruvec_irqsave
      0.01 ±223%      +0.1        0.13 ± 35%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.09            +0.1        0.22 ± 22%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.23 ±  4%      +0.1        0.36 ± 22%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.14 ±  6%      +0.1        0.27 ± 11%  perf-profile.children.cycles-pp.__pagevec_lru_add
      0.11 ±  6%      +0.1        0.25 ±  3%  perf-profile.children.cycles-pp.security_file_permission
      0.02 ± 99%      +0.1        0.16 ± 11%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.17 ±  3%      +0.1        0.31 ±  2%  perf-profile.children.cycles-pp.__entry_text_start
      0.19 ±  3%      +0.1        0.34 ± 10%  perf-profile.children.cycles-pp.lru_cache_add
      0.12 ±  6%      +0.1        0.26 ± 12%  perf-profile.children.cycles-pp.alloc_buffer_head
      0.13 ± 10%      +0.1        0.27 ±  9%  perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      0.08 ±  8%      +0.2        0.23 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.18 ±  4%      +0.2        0.34 ±  8%  perf-profile.children.cycles-pp.try_to_free_buffers
      0.13 ±  5%      +0.2        0.29 ± 11%  perf-profile.children.cycles-pp.alloc_page_buffers
      0.27 ±  3%      +0.2        0.44 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.15 ±  9%      +0.2        0.32 ±  9%  perf-profile.children.cycles-pp.do_unlinkat
      0.15 ±  9%      +0.2        0.33 ±  9%  perf-profile.children.cycles-pp.unlink
      0.38 ±  7%      +0.2        0.57 ±  3%  perf-profile.children.cycles-pp.__brelse
      0.27            +0.2        0.46 ±  3%  perf-profile.children.cycles-pp.llseek
      0.17 ±  5%      +0.2        0.38 ± 10%  perf-profile.children.cycles-pp.__pagevec_release
      0.22 ±  7%      +0.2        0.43 ± 28%  perf-profile.children.cycles-pp.memset_erms
      0.10 ± 25%      +0.2        0.30 ± 15%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.18 ±  4%      +0.2        0.39 ± 10%  perf-profile.children.cycles-pp.release_pages
      0.15 ±  6%      +0.2        0.36 ± 25%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.34 ±  5%      +0.2        0.55 ±  9%  perf-profile.children.cycles-pp.create_empty_buffers
      0.22 ±  7%      +0.2        0.44 ±  7%  perf-profile.children.cycles-pp.ext4_inode_csum
      0.21 ±  7%      +0.2        0.44 ±  8%  perf-profile.children.cycles-pp.creat64
      0.12 ±  5%      +0.2        0.36 ± 21%  perf-profile.children.cycles-pp.__set_page_dirty
      0.53 ±  2%      +0.2        0.77 ± 16%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      0.47 ±  4%      +0.2        0.71 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.22 ±  7%      +0.2        0.46 ±  8%  perf-profile.children.cycles-pp.do_filp_open
      0.22 ±  7%      +0.2        0.46 ±  8%  perf-profile.children.cycles-pp.path_openat
      0.23 ±  6%      +0.2        0.48 ±  8%  perf-profile.children.cycles-pp.do_sys_open
      0.38 ±  4%      +0.2        0.63 ±  6%  perf-profile.children.cycles-pp.truncate_cleanup_page
      0.22 ±  6%      +0.3        0.48 ±  8%  perf-profile.children.cycles-pp.do_sys_openat2
      0.24 ±  6%      +0.3        0.50 ±  6%  perf-profile.children.cycles-pp.ext4_inode_csum_set
      1.00 ±  3%      +0.3        1.32 ±  4%  perf-profile.children.cycles-pp.mark_buffer_dirty
      0.29 ±  4%      +0.4        0.67 ±  2%  perf-profile.children.cycles-pp.ext4_da_get_block_prep
      0.28 ±  5%      +0.4        0.66 ±  2%  perf-profile.children.cycles-pp.ext4_da_map_blocks
      0.73 ±  2%      +0.4        1.13 ± 14%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      0.52 ±  2%      +0.4        0.94 ± 25%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.54 ±  2%      +0.5        1.01 ± 23%  perf-profile.children.cycles-pp.copyin
      0.29 ±  2%      +0.5        0.84 ±  7%  perf-profile.children.cycles-pp.jbd2_write_access_granted
      0.73 ±  3%      +0.6        1.30 ±  6%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.82 ±  3%      +0.6        1.47 ±  5%  perf-profile.children.cycles-pp.ext4_evict_inode
      0.83 ±  3%      +0.6        1.48 ±  5%  perf-profile.children.cycles-pp.evict
      0.84 ±  3%      +0.6        1.49 ±  6%  perf-profile.children.cycles-pp.__dentry_kill
      0.84 ±  3%      +0.7        1.50 ±  6%  perf-profile.children.cycles-pp.dput
      0.84 ±  3%      +0.7        1.50 ±  6%  perf-profile.children.cycles-pp.__fput
      0.84 ±  3%      +0.7        1.50 ±  6%  perf-profile.children.cycles-pp.task_work_run
      0.85 ±  3%      +0.7        1.52 ±  6%  perf-profile.children.cycles-pp.__close
      0.89 ±  3%      +0.7        1.58 ±  6%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.92 ±  3%      +0.7        1.65 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.66 ±  3%      +0.8        1.47 ± 20%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.93 ±  3%      +0.9        1.85 ± 11%  perf-profile.children.cycles-pp.ext4_block_write_begin
      1.46 ± 10%      +1.0        2.49 ±  3%  perf-profile.children.cycles-pp.jbd2_journal_dirty_metadata
      0.35 ±  4%      +1.0        1.39 ±  2%  perf-profile.children.cycles-pp.__find_get_block
      0.38 ±  3%      +1.1        1.44 ±  2%  perf-profile.children.cycles-pp.__getblk_gfp
      2.04            +1.2        3.21 ±  6%  perf-profile.children.cycles-pp.pagecache_get_page
      2.05            +1.2        3.22 ±  6%  perf-profile.children.cycles-pp.grab_cache_page_write_begin
      0.48 ±  4%      +1.2        1.66 ±  2%  perf-profile.children.cycles-pp.__ext4_get_inode_loc
      0.49 ±  3%      +1.2        1.67 ±  2%  perf-profile.children.cycles-pp.ext4_get_inode_loc
      1.60 ± 12%      +1.2        2.81 ±  5%  perf-profile.children.cycles-pp.__ext4_handle_dirty_metadata
      1.73 ±  8%      +1.5        3.24 ±  3%  perf-profile.children.cycles-pp.jbd2_journal_get_write_access
      2.17 ±  3%      +1.5        3.70 ± 15%  perf-profile.children.cycles-pp.block_write_end
      1.81 ±  8%      +1.6        3.41 ±  3%  perf-profile.children.cycles-pp.__ext4_journal_get_write_access
      1.81 ±  3%      +1.8        3.57 ± 14%  perf-profile.children.cycles-pp.__block_commit_write
      3.03 ±  5%      +2.4        5.46 ±  4%  perf-profile.children.cycles-pp.ext4_do_update_inode
      2.30 ±  6%      +2.8        5.09 ±  2%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      3.59 ±  4%      +2.8        6.38 ±  3%  perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      5.90 ±  5%      +5.6       11.54 ±  2%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      8.97 ±  5%     +58.3       67.29 ±  2%  perf-profile.children.cycles-pp.ext4_dirty_inode
     10.77 ±  5%     +71.0       81.81        perf-profile.children.cycles-pp.__mark_inode_dirty
     10.97 ±  5%     +72.9       83.90        perf-profile.children.cycles-pp.generic_write_end
     37.84 ±  2%      -3.0       34.89 ±  3%  perf-profile.self.cycles-pp.start_this_handle
      8.26 ±  2%      -2.2        6.09 ±  3%  perf-profile.self.cycles-pp.jbd2_journal_stop
      9.37 ±  9%      -2.2        7.20 ±  5%  perf-profile.self.cycles-pp.stop_this_handle
      4.06 ± 10%      -1.6        2.44 ±  3%  perf-profile.self.cycles-pp.ext4_journal_check_start
     10.32 ±  4%      -1.6        8.77        perf-profile.self.cycles-pp.add_transaction_credits
      1.36 ±  4%      -1.2        0.17 ±  8%  perf-profile.self.cycles-pp.ext4_da_write_begin
      1.17 ± 12%      -0.7        0.45 ±  5%  perf-profile.self.cycles-pp.up_write
      9.27 ±  2%      -0.4        8.87 ±  3%  perf-profile.self.cycles-pp._raw_read_lock
      0.65 ±  2%      -0.2        0.46 ±  4%  perf-profile.self.cycles-pp.unlock_page
      0.54 ±  6%      -0.2        0.38 ±  7%  perf-profile.self.cycles-pp.down_write
      0.08 ±  4%      +0.0        0.10 ±  6%  perf-profile.self.cycles-pp.kmem_cache_free
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__add_to_page_cache_locked
      0.08 ±  5%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.find_lock_entries
      0.07 ±  5%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.08 ±  7%      +0.0        0.11 ±  5%  perf-profile.self.cycles-pp.block_invalidatepage
      0.06 ±  9%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.truncate_cleanup_page
      0.04 ± 45%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      0.12 ±  5%      +0.0        0.16 ±  4%  perf-profile.self.cycles-pp.__might_sleep
      0.06 ±  9%      +0.0        0.10 ±  6%  perf-profile.self.cycles-pp.ext4_inode_csum
      0.03 ± 70%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.04 ± 44%      +0.0        0.09 ±  6%  perf-profile.self.cycles-pp.new_sync_write
      0.07 ±  8%      +0.0        0.12        perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.08 ±  6%      +0.1        0.13 ±  9%  perf-profile.self.cycles-pp.__pagevec_lru_add
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.xas_start
      0.08 ±  4%      +0.1        0.13 ±  4%  perf-profile.self.cycles-pp.xas_load
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.iov_iter_fault_in_readable
      0.06 ±  7%      +0.1        0.12 ±  6%  perf-profile.self.cycles-pp.release_pages
      0.06 ±  8%      +0.1        0.11 ± 13%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.drop_buffers
      0.07 ±  7%      +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.disk_rw
      0.01 ±223%      +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.page_cache_free_page
      0.08 ±  6%      +0.1        0.13 ±  2%  perf-profile.self.cycles-pp.__fget_light
      0.10 ±  4%      +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.create_empty_buffers
      0.00            +0.1        0.06 ± 25%  perf-profile.self.cycles-pp.errseq_check
      0.05 ±  7%      +0.1        0.11 ±  5%  perf-profile.self.cycles-pp.ext4_file_write_iter
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.file_update_time
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.ext4_buffered_write_iter
      0.08 ±  5%      +0.1        0.15 ± 11%  perf-profile.self.cycles-pp.generic_perform_write
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.llseek
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.__cond_resched
      0.03 ±100%      +0.1        0.09 ± 11%  perf-profile.self.cycles-pp.crypto_shash_update
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.ext4_es_lookup_extent
      0.08 ±  5%      +0.1        0.15 ±  4%  perf-profile.self.cycles-pp.__entry_text_start
      0.00            +0.1        0.07 ± 21%  perf-profile.self.cycles-pp.ext4_nonda_switch
      0.00            +0.1        0.07 ± 15%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.00            +0.1        0.07 ± 15%  perf-profile.self.cycles-pp.copyin
      0.03 ± 70%      +0.1        0.10 ±  9%  perf-profile.self.cycles-pp.page_counter_cancel
      0.00            +0.1        0.07 ± 27%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.08 ±  8%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.write
      0.10 ±  4%      +0.1        0.17 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__ext4_journal_get_write_access
      0.06 ±  9%      +0.1        0.14 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.09 ±  5%      +0.1        0.16 ±  4%  perf-profile.self.cycles-pp.__ext4_get_inode_loc
      0.00            +0.1        0.08 ± 17%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.08 ±  6%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.common_file_perm
      0.03 ±102%      +0.1        0.12 ± 16%  perf-profile.self.cycles-pp.osq_lock
      0.00            +0.1        0.09 ± 32%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.11 ±  6%      +0.1        0.20 ±  3%  perf-profile.self.cycles-pp.vfs_write
      0.00            +0.1        0.10 ± 35%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.06 ± 11%      +0.1        0.16 ± 34%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.20 ±  4%      +0.1        0.31 ±  3%  perf-profile.self.cycles-pp.___might_sleep
      0.14 ±  5%      +0.1        0.26 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.01 ±223%      +0.1        0.13 ± 35%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.05            +0.1        0.17 ±  7%  perf-profile.self.cycles-pp.ext4_da_map_blocks
      0.13 ±  3%      +0.1        0.25 ± 12%  perf-profile.self.cycles-pp.ext4_block_write_begin
      0.02 ± 99%      +0.1        0.16 ± 11%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.12 ±  9%      +0.1        0.25 ±  9%  perf-profile.self.cycles-pp.crc32c_pcl_intel_update
      0.11 ± 42%      +0.2        0.28 ± 29%  perf-profile.self.cycles-pp.__ext4_handle_dirty_metadata
      0.33 ±  4%      +0.2        0.51 ± 12%  perf-profile.self.cycles-pp.generic_write_end
      0.38 ±  7%      +0.2        0.56 ±  3%  perf-profile.self.cycles-pp.__brelse
      0.22 ±  5%      +0.2        0.42 ± 28%  perf-profile.self.cycles-pp.memset_erms
      0.47 ±  5%      +0.2        0.70 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.12 ±  6%      +0.3        0.46 ± 13%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.53 ±  7%      +0.3        0.86 ±  2%  perf-profile.self.cycles-pp.ext4_mark_iloc_dirty
      0.36 ± 12%      +0.4        0.74 ± 37%  perf-profile.self.cycles-pp.block_write_end
      0.52 ±  2%      +0.4        0.93 ± 25%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      1.03 ±  2%      +0.5        1.56 ±  2%  perf-profile.self.cycles-pp.pagecache_get_page
      0.28 ±  2%      +0.5        0.83 ±  7%  perf-profile.self.cycles-pp.jbd2_write_access_granted
      0.55 ±  4%      +0.6        1.12 ±  3%  perf-profile.self.cycles-pp.ext4_do_update_inode
      0.21 ±  7%      +0.6        0.78 ±  5%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.78 ±  4%      +0.8        1.54 ± 13%  perf-profile.self.cycles-pp.__block_commit_write
      1.44 ± 10%      +0.9        2.38 ±  4%  perf-profile.self.cycles-pp.jbd2_journal_get_write_access
      1.46 ± 10%      +1.0        2.47 ±  4%  perf-profile.self.cycles-pp.jbd2_journal_dirty_metadata
      0.33 ±  4%      +1.0        1.34 ±  2%  perf-profile.self.cycles-pp.__find_get_block



***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/1BRD_48G/ext4/x86_64-rhel-8.3/3000/debian-10.4-x86_64-20200603.cgz/lkp-icl-2sp2/disk_rw/aim7/0xd000280

commit: 
  6984aef598 ("ext4: factor out write end code of inline file")
  cc883236b7 ("ext4: drop unnecessary journal handle in delalloc write")

6984aef59814fb5c cc883236b79297f6266ca6f4e7f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    151790           +68.6%     255987 ±  2%  aim7.jobs-per-min
    118.77           -40.6%      70.53 ±  2%  aim7.time.elapsed_time
    118.77           -40.6%      70.53 ±  2%  aim7.time.elapsed_time.max
    868735 ±  2%     -55.3%     388069 ±  3%  aim7.time.involuntary_context_switches
    219053            -9.8%     197584        aim7.time.minor_page_faults
     13359           -44.2%       7459 ±  2%  aim7.time.system_time
     64.40            -9.5%      58.29        aim7.time.user_time
    134967 ±  2%     -39.6%      81532 ±  2%  aim7.time.voluntary_context_switches
    175.29           -26.1%     129.57 ±  3%  uptime.boot
 1.803e+09 ±  2%     -11.0%  1.605e+09        cpuidle..time
   3711800 ±  2%     -19.2%    2999096 ± 15%  cpuidle..usage
     12.91 ±  3%     +48.2%      19.13 ±  3%  iostat.cpu.idle
     86.54            -7.4%      80.12        iostat.cpu.system
     11.49 ±  3%      +5.5       16.94 ±  3%  mpstat.cpu.all.idle%
      0.03 ±  7%      +0.0        0.04 ±  4%  mpstat.cpu.all.soft%
      0.54 ±  4%      +0.2        0.75 ±  3%  mpstat.cpu.all.usr%
      7324 ± 43%     -50.4%       3630 ±  9%  softirqs.CPU11.RCU
    707884 ± 16%     -35.2%     458881 ±  3%  softirqs.RCU
    646318           -16.0%     542591        softirqs.SCHED
     39269 ±  4%     -23.2%      30160 ±  5%  softirqs.TIMER
   3699232 ±  2%     -25.3%    2764757 ± 28%  turbostat.C1
     11.73 ±  2%      +5.5       17.25 ±  2%  turbostat.C1%
  33948074           -42.6%   19487840 ± 16%  turbostat.IRQ
     72.67            -3.2%      70.33        turbostat.PkgTmp
     12.33 ±  3%     +48.6%      18.33 ±  2%  vmstat.cpu.id
      7957 ±  7%     +57.5%      12531        vmstat.io.bo
    225.00           -24.3%     170.33 ±  3%  vmstat.procs.r
     10778           -13.9%       9283        vmstat.system.cs
    187616 ±  3%     -19.9%     150277 ±  4%  meminfo.Active
    186694 ±  3%     -20.0%     149403 ±  4%  meminfo.Active(anon)
    129742           -27.2%      94422 ±  2%  meminfo.AnonHugePages
   1335222           +14.8%    1532476 ±  2%  meminfo.Dirty
   1334695           +14.8%    1531712 ±  2%  meminfo.Inactive(file)
    139750 ± 10%     -43.0%      79641 ±  3%  meminfo.Mapped
    284982 ±  2%     -27.0%     208020 ±  2%  meminfo.Shmem
      4338 ± 19%     -51.8%       2091 ±  4%  numa-meminfo.node0.Active
      3584 ± 23%     -59.5%       1450 ± 11%  numa-meminfo.node0.Active(anon)
    125913           -55.7%      55835 ± 55%  numa-meminfo.node0.AnonHugePages
    711344 ±  8%     +22.9%     874446 ±  7%  numa-meminfo.node0.Dirty
    372289           -29.3%     263302 ± 26%  numa-meminfo.node0.Inactive(anon)
    711408 ±  8%     +22.9%     874418 ±  7%  numa-meminfo.node0.Inactive(file)
     85598           -42.8%      48994 ±  2%  numa-meminfo.node0.Mapped
     64916           -70.1%      19387        numa-meminfo.node0.Shmem
    182640 ±  2%     -19.2%     147659 ±  4%  numa-meminfo.node1.Active
    182473 ±  2%     -19.2%     147426 ±  4%  numa-meminfo.node1.Active(anon)
      3830 ± 10%    +912.6%      38789 ± 76%  numa-meminfo.node1.AnonHugePages
     62782 ±  4%     +91.2%     120069 ± 57%  numa-meminfo.node1.AnonPages
     94909 ±  3%     +68.2%     159602 ± 43%  numa-meminfo.node1.AnonPages.max
     54555 ± 23%     -42.7%      31233 ±  4%  numa-meminfo.node1.Mapped
    943.67 ± 15%     +28.3%       1210 ± 10%  numa-meminfo.node1.PageTables
    219838 ±  3%     -14.1%     188859 ±  2%  numa-meminfo.node1.Shmem
    896.00 ± 23%     -59.6%     362.00 ± 11%  numa-vmstat.node0.nr_active_anon
    177806 ±  8%     +23.0%     218683 ±  7%  numa-vmstat.node0.nr_dirty
     93179           -29.3%      65837 ± 26%  numa-vmstat.node0.nr_inactive_anon
    177847 ±  8%     +23.0%     218682 ±  7%  numa-vmstat.node0.nr_inactive_file
     21446           -42.9%      12249 ±  2%  numa-vmstat.node0.nr_mapped
     16339           -70.3%       4846        numa-vmstat.node0.nr_shmem
    896.00 ± 23%     -59.6%     362.00 ± 11%  numa-vmstat.node0.nr_zone_active_anon
     93179           -29.3%      65837 ± 26%  numa-vmstat.node0.nr_zone_inactive_anon
    177850 ±  8%     +23.0%     218677 ±  7%  numa-vmstat.node0.nr_zone_inactive_file
    178506 ±  8%     +22.7%     219083 ±  7%  numa-vmstat.node0.nr_zone_write_pending
     45719 ±  2%     -19.4%      36859 ±  4%  numa-vmstat.node1.nr_active_anon
     15680 ±  3%     +91.4%      30007 ± 57%  numa-vmstat.node1.nr_anon_pages
     13550 ± 21%     -42.2%       7825 ±  4%  numa-vmstat.node1.nr_mapped
    235.00 ± 15%     +28.5%     302.00 ± 10%  numa-vmstat.node1.nr_page_table_pages
     54985 ±  3%     -14.2%      47179 ±  2%  numa-vmstat.node1.nr_shmem
     45719 ±  2%     -19.4%      36859 ±  4%  numa-vmstat.node1.nr_zone_active_anon
     46724 ±  3%     -19.7%      37511 ±  4%  proc-vmstat.nr_active_anon
     93421            -2.1%      91433        proc-vmstat.nr_anon_pages
    333755           +14.1%     380964 ±  2%  proc-vmstat.nr_dirty
   1001846            +2.8%    1029557        proc-vmstat.nr_file_pages
    118434 ±  3%     -10.3%     106261        proc-vmstat.nr_inactive_anon
    333610           +14.1%     380766 ±  2%  proc-vmstat.nr_inactive_file
     64339            -2.0%      63068        proc-vmstat.nr_kernel_stack
     35075 ±  8%     -43.5%      19832 ±  3%  proc-vmstat.nr_mapped
     71442 ±  2%     -27.1%      52074 ±  2%  proc-vmstat.nr_shmem
     92247            -1.7%      90635        proc-vmstat.nr_slab_unreclaimable
     46724 ±  3%     -19.7%      37511 ±  4%  proc-vmstat.nr_zone_active_anon
    118434 ±  3%     -10.3%     106261        proc-vmstat.nr_zone_inactive_anon
    333610           +14.1%     380766 ±  2%  proc-vmstat.nr_zone_inactive_file
    335279           +13.8%     381599 ±  2%  proc-vmstat.nr_zone_write_pending
     65733 ±  3%     -55.8%      29049 ±  2%  proc-vmstat.numa_hint_faults
     34127 ±  2%     -69.6%      10388 ±  4%  proc-vmstat.numa_hint_faults_local
     30107           -38.0%      18660 ±  2%  proc-vmstat.numa_pages_migrated
    211132 ±  2%     -82.4%      37200 ± 26%  proc-vmstat.numa_pte_updates
     57404 ±  3%     +10.9%      63635        proc-vmstat.pgactivate
    823452           -35.6%     530237        proc-vmstat.pgfault
     30107           -38.0%      18660 ±  2%  proc-vmstat.pgmigrate_success
     31193           -30.9%      21556 ±  3%  proc-vmstat.pgreuse
    354174           +14.6%     405892 ±  2%  slabinfo.buffer_head.active_objs
      9168           +14.4%      10488 ±  2%  slabinfo.buffer_head.active_slabs
    357584           +14.4%     409080 ±  2%  slabinfo.buffer_head.num_objs
      9168           +14.4%      10488 ±  2%  slabinfo.buffer_head.num_slabs
     21769 ± 15%     +24.7%      27137 ± 14%  slabinfo.ep_head.active_objs
     21769 ± 15%     +24.7%      27137 ± 14%  slabinfo.ep_head.num_objs
    778.00 ±  2%     +22.9%     956.33 ±  7%  slabinfo.ext4_allocation_context.active_objs
    778.00 ±  2%     +22.9%     956.33 ±  7%  slabinfo.ext4_allocation_context.num_objs
     12685 ±  4%     -13.6%      10962        slabinfo.ext4_extent_status.active_objs
     12685 ±  4%     -13.6%      10962        slabinfo.ext4_extent_status.num_objs
      7220 ±  3%     +16.2%       8390 ±  4%  slabinfo.ext4_inode_cache.active_objs
      7220 ±  3%     +16.5%       8411 ±  4%  slabinfo.ext4_inode_cache.num_objs
      3962 ±  3%     +19.5%       4736 ±  2%  slabinfo.jbd2_journal_head.active_objs
      3962 ±  3%     +19.5%       4736 ±  2%  slabinfo.jbd2_journal_head.num_objs
      1206 ±  8%     -12.7%       1053 ±  8%  slabinfo.mnt_cache.active_objs
      1206 ±  8%     -12.7%       1053 ±  8%  slabinfo.mnt_cache.num_objs
     11761 ±  4%      -7.1%      10928 ±  7%  slabinfo.pde_opener.active_objs
     11761 ±  4%      -7.1%      10928 ±  7%  slabinfo.pde_opener.num_objs
      6044 ±  6%     -10.0%       5442 ±  6%  slabinfo.shmem_inode_cache.active_objs
      6044 ±  6%     -10.0%       5442 ±  6%  slabinfo.shmem_inode_cache.num_objs
      1373 ±  4%     -10.4%       1231 ±  4%  slabinfo.task_group.active_objs
      1373 ±  4%     -10.4%       1231 ±  4%  slabinfo.task_group.num_objs
 5.438e+09           +46.5%  7.966e+09 ±  2%  perf-stat.i.branch-instructions
      0.71            -0.1        0.59 ±  7%  perf-stat.i.branch-miss-rate%
  35015003           +11.7%   39128509 ±  4%  perf-stat.i.branch-misses
     34.69 ±  3%      -3.2       31.51 ±  6%  perf-stat.i.cache-miss-rate%
  79939395 ±  9%     +43.1%  1.144e+08 ±  6%  perf-stat.i.cache-misses
  2.18e+08 ± 12%     +52.9%  3.334e+08 ± 14%  perf-stat.i.cache-references
     10874           -15.6%       9179        perf-stat.i.context-switches
      9.88           -36.6%       6.27 ±  2%  perf-stat.i.cpi
 2.895e+11            -6.9%  2.696e+11        perf-stat.i.cpu-cycles
      1135            -4.8%       1080        perf-stat.i.cpu-migrations
      0.01 ±  6%      -0.0        0.01 ±  5%  perf-stat.i.dTLB-load-miss-rate%
  8.49e+09           +44.9%   1.23e+10 ±  2%  perf-stat.i.dTLB-loads
      0.00            +0.0        0.00        perf-stat.i.dTLB-store-miss-rate%
     88757           +18.4%     105076 ±  4%  perf-stat.i.dTLB-store-misses
 4.494e+09           +44.8%  6.508e+09 ±  2%  perf-stat.i.dTLB-stores
 2.766e+10           +46.6%  4.055e+10 ±  2%  perf-stat.i.instructions
      0.13           +44.5%       0.19 ±  3%  perf-stat.i.ipc
     15.88 ± 17%     +95.3%      31.01 ± 39%  perf-stat.i.major-faults
      2.26            -6.7%       2.11        perf-stat.i.metric.GHz
    496.90           +31.8%     654.87        perf-stat.i.metric.K/sec
    145.34           +45.8%     211.87 ±  2%  perf-stat.i.metric.M/sec
      6367            +3.4%       6581        perf-stat.i.minor-faults
     65.34 ±  2%      +4.7       70.03        perf-stat.i.node-load-miss-rate%
   3494508 ± 11%     +32.7%    4635677 ± 12%  perf-stat.i.node-load-misses
   1969890 ±  3%     +11.2%    2189560 ±  7%  perf-stat.i.node-loads
   4449677 ±  3%     +15.3%    5129917 ±  3%  perf-stat.i.node-store-misses
  51880034           +31.5%   68199894        perf-stat.i.node-stores
      6383            +3.6%       6612        perf-stat.i.page-faults
      0.64            -0.2        0.49 ±  6%  perf-stat.overall.branch-miss-rate%
     10.49           -36.4%       6.67 ±  2%  perf-stat.overall.cpi
      3666 ±  8%     -35.6%       2361 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.01 ±  6%      -0.0        0.01 ±  6%  perf-stat.overall.dTLB-load-miss-rate%
      0.00            -0.0        0.00 ±  6%  perf-stat.overall.dTLB-store-miss-rate%
      0.10           +57.3%       0.15 ±  2%  perf-stat.overall.ipc
     63.85 ±  3%      +4.0       67.86        perf-stat.overall.node-load-miss-rate%
      7.93 ±  3%      -0.8        7.11 ±  3%  perf-stat.overall.node-store-miss-rate%
 5.441e+09           +46.6%  7.975e+09 ±  2%  perf-stat.ps.branch-instructions
  34846549           +11.8%   38953154 ±  4%  perf-stat.ps.branch-misses
  79850423 ±  9%     +44.0%   1.15e+08 ±  5%  perf-stat.ps.cache-misses
 2.186e+08 ± 12%     +53.1%  3.347e+08 ± 13%  perf-stat.ps.cache-references
     10703           -15.3%       9061        perf-stat.ps.context-switches
 2.903e+11            -6.8%  2.707e+11        perf-stat.ps.cpu-cycles
      1127            -4.7%       1074        perf-stat.ps.cpu-migrations
    944131 ±  6%     +16.3%    1097975 ±  5%  perf-stat.ps.dTLB-load-misses
   8.5e+09           +45.0%  1.233e+10 ±  2%  perf-stat.ps.dTLB-loads
     88955           +20.2%     106924 ±  4%  perf-stat.ps.dTLB-store-misses
 4.499e+09           +44.9%  6.521e+09 ±  2%  perf-stat.ps.dTLB-stores
 2.768e+10           +46.7%   4.06e+10 ±  2%  perf-stat.ps.instructions
     13.61 ± 17%     +98.5%      27.01 ± 38%  perf-stat.ps.major-faults
      6116            +1.1%       6185        perf-stat.ps.minor-faults
   3494431 ± 11%     +34.2%    4688298 ± 11%  perf-stat.ps.node-load-misses
   1964278 ±  3%     +12.5%    2209716 ±  6%  perf-stat.ps.node-loads
   4463884 ±  3%     +17.1%    5228830 ±  2%  perf-stat.ps.node-store-misses
  51830328           +31.9%   68369241        perf-stat.ps.node-stores
      6130            +1.3%       6212        perf-stat.ps.page-faults
 3.306e+12           -12.9%   2.88e+12        perf-stat.total.instructions
     51.37 ±  2%     -51.4        0.00        perf-profile.calltrace.cycles-pp.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
     51.23 ±  2%     -51.2        0.00        perf-profile.calltrace.cycles-pp.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
     50.70 ±  2%     -50.7        0.00        perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write
     56.83 ±  2%     -50.2        6.67 ±  8%  perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
     33.21 ±  2%     -33.2        0.00        perf-profile.calltrace.cycles-pp.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
     27.91 ±  4%     -27.9        0.00        perf-profile.calltrace.cycles-pp.__ext4_journal_stop.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
     27.71 ±  4%     -27.7        0.00        perf-profile.calltrace.cycles-pp.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
     15.69 ±  6%     -15.7        0.00        perf-profile.calltrace.cycles-pp.add_transaction_credits.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
     14.27 ±  8%     -14.3        0.00        perf-profile.calltrace.cycles-pp.stop_this_handle.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end.generic_perform_write
      5.23 ±  8%      -5.2        0.00        perf-profile.calltrace.cycles-pp.generic_write_end.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
     96.49            -2.5       94.03        perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     96.64            -2.3       94.33        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     91.14            -2.0       89.11        perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write
     97.01            -2.0       95.06        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.12            -1.8       95.31        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.24            -1.7       95.50        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.31            -1.7       95.58        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     97.59            -1.5       96.06        perf-profile.calltrace.cycles-pp.write
      1.81 ±  5%      -1.3        0.46 ± 70%  perf-profile.calltrace.cycles-pp.up_write.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write
      0.53 ±  3%      +0.2        0.70 ±  3%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      0.58 ±  3%      +0.2        0.82 ±  8%  perf-profile.calltrace.cycles-pp.truncate_cleanup_page.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      0.93 ±  3%      +0.4        1.31 ±  7%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write
      1.08 ±  7%      +0.5        1.61 ±  6%  perf-profile.calltrace.cycles-pp.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      1.14 ±  3%      +0.6        1.77 ± 10%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill.dput
      0.00            +0.6        0.64 ±  8%  perf-profile.calltrace.cycles-pp.down_write.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write
      0.00            +0.7        0.67 ± 19%  perf-profile.calltrace.cycles-pp.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      1.23 ±  2%      +0.7        1.91 ±  9%  perf-profile.calltrace.cycles-pp.ext4_evict_inode.evict.__dentry_kill.dput.__fput
      1.24 ±  2%      +0.7        1.93 ±  9%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_prepare
      1.23 ±  2%      +0.7        1.92 ±  9%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
      1.25 ±  2%      +0.7        1.94 ±  9%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1.25 ±  3%      +0.7        1.94 ±  9%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      1.26 ±  2%      +0.7        1.95 ±  9%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.26 ±  2%      +0.7        1.95 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      1.26 ±  2%      +0.7        1.95 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.26 ±  2%      +0.7        1.96 ±  9%  perf-profile.calltrace.cycles-pp.__close
      1.26 ±  2%      +0.7        1.95 ±  9%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.26 ±  2%      +0.7        1.95 ±  9%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.53 ±  6%      +0.7        2.23 ±  7%  perf-profile.calltrace.cycles-pp.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      0.00            +0.8        0.76 ± 12%  perf-profile.calltrace.cycles-pp.create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.00            +0.9        0.90 ± 13%  perf-profile.calltrace.cycles-pp.unlock_page.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.00            +1.2        1.16 ± 14%  perf-profile.calltrace.cycles-pp.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.00            +1.2        1.19 ± 13%  perf-profile.calltrace.cycles-pp.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.00            +1.2        1.23 ±  6%  perf-profile.calltrace.cycles-pp.__find_get_block.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      0.00            +1.3        1.34 ±  5%  perf-profile.calltrace.cycles-pp.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty
      0.00            +1.4        1.41 ±  6%  perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.generic_write_end.generic_perform_write
      0.83 ±  2%      +1.5        2.33 ± 10%  perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.00            +1.5        1.50 ±  3%  perf-profile.calltrace.cycles-pp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
      0.00            +1.5        1.52 ±  3%  perf-profile.calltrace.cycles-pp.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      2.49 ±  4%      +1.6        4.07 ±  9%  perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.62 ±  5%      +1.6        2.24 ±  4%  perf-profile.calltrace.cycles-pp.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      2.53 ±  4%      +1.6        4.15 ±  8%  perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.00            +1.9        1.91 ± 78%  perf-profile.calltrace.cycles-pp._raw_read_lock.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      0.00            +3.3        3.26 ±  6%  perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00            +3.6        3.59 ±  5%  perf-profile.calltrace.cycles-pp.block_write_end.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.00            +4.6        4.62 ±  6%  perf-profile.calltrace.cycles-pp.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write
      0.00           +12.8       12.82 ± 18%  perf-profile.calltrace.cycles-pp.stop_this_handle.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end
      0.18 ±141%     +13.2       13.41 ±  8%  perf-profile.calltrace.cycles-pp.add_transaction_credits.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      0.00           +24.0       23.99 ± 16%  perf-profile.calltrace.cycles-pp.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write
      0.00           +24.2       24.20 ± 16%  perf-profile.calltrace.cycles-pp.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      1.56 ± 18%     +44.9       46.43 ± 10%  perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      0.00           +45.2       45.24 ± 10%  perf-profile.calltrace.cycles-pp.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      0.00           +45.4       45.44 ± 10%  perf-profile.calltrace.cycles-pp.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write
      0.00           +50.1       50.10 ± 10%  perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00           +75.6       75.61        perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.00           +80.6       80.57        perf-profile.calltrace.cycles-pp.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
     56.87 ±  2%     -50.2        6.70 ±  8%  perf-profile.children.cycles-pp.ext4_da_write_begin
     33.22 ±  2%     -33.1        0.08        perf-profile.children.cycles-pp.ext4_da_write_end
     96.51            -2.4       94.07        perf-profile.children.cycles-pp.ext4_buffered_write_iter
     16.25 ±  6%      -2.4       13.84 ±  8%  perf-profile.children.cycles-pp.add_transaction_credits
     96.70            -2.3       94.40        perf-profile.children.cycles-pp.new_sync_write
     91.23            -2.0       89.21        perf-profile.children.cycles-pp.generic_perform_write
     97.08            -1.9       95.14        perf-profile.children.cycles-pp.vfs_write
     97.18            -1.8       95.37        perf-profile.children.cycles-pp.ksys_write
     97.68            -1.5       96.23        perf-profile.children.cycles-pp.write
      1.82 ±  5%      -1.2        0.63 ± 16%  perf-profile.children.cycles-pp.up_write
     99.28            -0.5       98.83        perf-profile.children.cycles-pp.do_syscall_64
     99.35            -0.4       98.91        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.24 ± 13%      -0.1        0.17 ±  5%  perf-profile.children.cycles-pp.queued_read_lock_slowpath
      0.08 ±  6%      +0.0        0.09        perf-profile.children.cycles-pp.try_charge_memcg
      0.05 ±  8%      +0.0        0.07 ± 12%  perf-profile.children.cycles-pp.__slab_free
      0.06 ±  8%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.drop_buffers
      0.06 ±  8%      +0.0        0.08        perf-profile.children.cycles-pp.__mod_lruvec_state
      0.08 ±  6%      +0.0        0.10        perf-profile.children.cycles-pp.rcu_all_qs
      0.06 ±  8%      +0.0        0.08 ± 11%  perf-profile.children.cycles-pp.page_counter_cancel
      0.06 ±  7%      +0.0        0.09 ± 15%  perf-profile.children.cycles-pp.page_cache_free_page
      0.06 ±  7%      +0.0        0.09        perf-profile.children.cycles-pp.__ext4_new_inode
      0.06 ±  8%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.16 ±  5%      +0.0        0.19 ±  6%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.08 ±  5%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.05 ±  8%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.rmqueue
      0.03 ± 70%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.jbd2_journal_grab_journal_head
      0.11 ±  7%      +0.0        0.14 ± 11%  perf-profile.children.cycles-pp.find_lock_entries
      0.06 ± 13%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.19 ±  6%      +0.0        0.23 ±  4%  perf-profile.children.cycles-pp.kmem_cache_free
      0.07 ±  6%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.xas_store
      0.07 ± 12%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.crypto_shash_update
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__ext4_find_entry
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.ext4_dx_find_entry
      0.05            +0.0        0.09        perf-profile.children.cycles-pp.__fsnotify_parent
      0.03 ± 70%      +0.0        0.07 ± 12%  perf-profile.children.cycles-pp.uncharge_batch
      0.03 ± 70%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.account_page_cleaned
      0.03 ± 70%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.jbd2_journal_try_to_free_buffers
      0.03 ± 70%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.ext4_fc_track_inode
      0.09 ±  5%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.ext4_unlink
      0.08 ±  6%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__cancel_dirty_page
      0.09 ±  5%      +0.0        0.14        perf-profile.children.cycles-pp.vfs_unlink
      0.06 ± 13%      +0.0        0.11 ± 15%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.05 ±  8%      +0.0        0.10 ± 12%  perf-profile.children.cycles-pp.ext4_file_write_iter
      0.05 ±  8%      +0.0        0.10 ± 12%  perf-profile.children.cycles-pp.handle_mm_fault
      0.05 ±  8%      +0.0        0.10 ± 12%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.11 ±  7%      +0.1        0.16 ±  5%  perf-profile.children.cycles-pp.ext4_create
      0.02 ±141%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__ext4_unlink
      0.06 ±  8%      +0.1        0.11 ± 15%  perf-profile.children.cycles-pp.exc_page_fault
      0.06 ±  8%      +0.1        0.11 ± 15%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.free_unref_page_list
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.file_remove_privs
      0.17 ±  5%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.10 ±  4%      +0.1        0.15 ±  6%  perf-profile.children.cycles-pp.free_buffer_head
      0.11 ± 11%      +0.1        0.17 ±  5%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.08 ± 10%      +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.current_time
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.02 ±141%      +0.1        0.07        perf-profile.children.cycles-pp.file_modified
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.11 ±  4%      +0.1        0.17 ±  9%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.18 ±  2%      +0.1        0.24 ± 12%  perf-profile.children.cycles-pp.block_invalidatepage
      0.18 ±  9%      +0.1        0.24 ±  7%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.xa_get_order
      0.00            +0.1        0.06 ± 23%  perf-profile.children.cycles-pp.jbd2_journal_dirty_metadata
      0.08 ±  5%      +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.__fget_light
      0.07 ±  6%      +0.1        0.14 ± 12%  perf-profile.children.cycles-pp.ksys_lseek
      0.00            +0.1        0.06 ± 19%  perf-profile.children.cycles-pp.page_vma_mapped_walk
      0.12 ±  6%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.00            +0.1        0.07 ± 18%  perf-profile.children.cycles-pp.__es_insert_extent
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.19 ±  5%      +0.1        0.25 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.aa_file_perm
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.02 ±141%      +0.1        0.09 ± 19%  perf-profile.children.cycles-pp.migrate_misplaced_page
      0.02 ±141%      +0.1        0.09 ± 19%  perf-profile.children.cycles-pp.migrate_pages
      0.00            +0.1        0.07 ± 40%  perf-profile.children.cycles-pp.wait_for_stable_page
      0.17 ±  8%      +0.1        0.24 ±  5%  perf-profile.children.cycles-pp.__might_sleep
      0.07 ±  6%      +0.1        0.15 ± 35%  perf-profile.children.cycles-pp.generic_write_checks
      0.14 ±  5%      +0.1        0.21 ±  5%  perf-profile.children.cycles-pp.__alloc_pages
      0.05 ± 72%      +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.PageHuge
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp._raw_write_lock
      0.07 ±  7%      +0.1        0.14 ± 15%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.map_id_up
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.xas_start
      0.02 ±141%      +0.1        0.09 ± 18%  perf-profile.children.cycles-pp.do_numa_page
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.write@plt
      0.10 ±  4%      +0.1        0.18        perf-profile.children.cycles-pp.common_file_perm
      0.12 ±  4%      +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.xas_load
      0.19 ±  8%      +0.1        0.27 ±  3%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.10 ±  8%      +0.1        0.18        perf-profile.children.cycles-pp.__fdget_pos
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.08 ± 56%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.10 ±  4%      +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.disk_rw
      0.07            +0.1        0.16 ±  6%  perf-profile.children.cycles-pp.__ext4_handle_dirty_metadata
      0.09 ±  9%      +0.1        0.18 ± 29%  perf-profile.children.cycles-pp.ext4_generic_write_checks
      0.14 ±  3%      +0.1        0.22 ±  7%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.00            +0.1        0.09 ± 19%  perf-profile.children.cycles-pp.rmap_walk_anon
      0.14 ±  3%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.security_file_permission
      0.00            +0.1        0.09 ±  9%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.00            +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.up_read
      0.09 ± 28%      +0.1        0.20 ±  7%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.17 ±  8%      +0.1        0.30        perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      0.20 ±  7%      +0.1        0.33 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.18 ±  9%      +0.1        0.32        perf-profile.children.cycles-pp.__entry_text_start
      0.27 ±  6%      +0.1        0.41 ±  4%  perf-profile.children.cycles-pp.try_to_free_buffers
      0.36 ±  6%      +0.1        0.50 ±  7%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.00            +0.1        0.14 ± 21%  perf-profile.children.cycles-pp.down_read
      0.06 ±  8%      +0.2        0.21 ±  9%  perf-profile.children.cycles-pp.ext4_da_reserve_space
      0.05 ±  8%      +0.2        0.21 ± 18%  perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.54 ±  2%      +0.2        0.72 ±  2%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      0.31 ± 11%      +0.2        0.48        perf-profile.children.cycles-pp.ext4_inode_csum
      0.78 ±  3%      +0.2        0.95 ± 13%  perf-profile.children.cycles-pp.unlock_page
      0.19 ± 11%      +0.2        0.37 ±  2%  perf-profile.children.cycles-pp.__set_page_dirty
      0.36 ±  7%      +0.2        0.54 ± 18%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.10 ±  8%      +0.2        0.29 ± 12%  perf-profile.children.cycles-pp.alloc_buffer_head
      0.33 ± 10%      +0.2        0.52        perf-profile.children.cycles-pp.ext4_inode_csum_set
      0.31 ±  3%      +0.2        0.51 ± 16%  perf-profile.children.cycles-pp.__pagevec_lru_add
      0.33 ± 11%      +0.2        0.53 ±  9%  perf-profile.children.cycles-pp.___might_sleep
      0.45 ±  9%      +0.2        0.65 ±  8%  perf-profile.children.cycles-pp.down_write
      0.03 ± 70%      +0.2        0.24 ± 17%  perf-profile.children.cycles-pp.ext4_es_insert_delayed_block
      0.38 ±  3%      +0.2        0.59 ± 15%  perf-profile.children.cycles-pp.lru_cache_add
      0.12 ±  4%      +0.2        0.33 ± 12%  perf-profile.children.cycles-pp.alloc_page_buffers
      0.21 ± 18%      +0.2        0.44        perf-profile.children.cycles-pp.unlink
      0.21 ± 20%      +0.2        0.44        perf-profile.children.cycles-pp.do_unlinkat
      0.31 ±  8%      +0.2        0.54 ±  3%  perf-profile.children.cycles-pp.llseek
      0.58 ±  3%      +0.2        0.82 ±  8%  perf-profile.children.cycles-pp.truncate_cleanup_page
      0.14 ±  5%      +0.2        0.39 ± 23%  perf-profile.children.cycles-pp.lock_page_lruvec_irqsave
      0.29 ± 17%      +0.3        0.54 ±  5%  perf-profile.children.cycles-pp.creat64
      0.09 ± 28%      +0.3        0.35 ±  3%  perf-profile.children.cycles-pp.osq_lock
      0.31 ± 18%      +0.3        0.57 ±  5%  perf-profile.children.cycles-pp.path_openat
      0.32 ± 17%      +0.3        0.58 ±  6%  perf-profile.children.cycles-pp.do_sys_open
      0.32 ± 17%      +0.3        0.58 ±  6%  perf-profile.children.cycles-pp.do_sys_openat2
      0.31 ± 18%      +0.3        0.57 ±  6%  perf-profile.children.cycles-pp.do_filp_open
      0.28            +0.3        0.54 ± 14%  perf-profile.children.cycles-pp.__pagevec_release
      0.37 ±  2%      +0.3        0.63 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock
      0.29            +0.3        0.56 ± 14%  perf-profile.children.cycles-pp.release_pages
      0.21 ±  2%      +0.3        0.52 ± 19%  perf-profile.children.cycles-pp.jbd2_write_access_granted
      0.24            +0.3        0.57 ± 20%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.22 ±  4%      +0.3        0.56 ± 21%  perf-profile.children.cycles-pp.jbd2_journal_get_write_access
      0.21 ± 26%      +0.4        0.56 ±  5%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.93 ±  3%      +0.4        1.31 ±  7%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      0.31 ±  6%      +0.4        0.73 ± 18%  perf-profile.children.cycles-pp.__ext4_journal_get_write_access
      0.25 ±  6%      +0.5        0.77 ± 12%  perf-profile.children.cycles-pp.create_empty_buffers
      1.17 ±  6%      +0.6        1.73 ±  6%  perf-profile.children.cycles-pp.ext4_do_update_inode
      0.81 ± 11%      +0.6        1.42 ±  6%  perf-profile.children.cycles-pp.mark_buffer_dirty
      1.14 ±  3%      +0.6        1.77 ± 10%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      1.23 ±  2%      +0.7        1.91 ±  9%  perf-profile.children.cycles-pp.ext4_evict_inode
      1.25 ±  2%      +0.7        1.94 ±  9%  perf-profile.children.cycles-pp.dput
      1.24 ±  2%      +0.7        1.93 ±  9%  perf-profile.children.cycles-pp.__dentry_kill
      1.23 ±  2%      +0.7        1.92 ±  9%  perf-profile.children.cycles-pp.evict
      1.25 ±  2%      +0.7        1.94 ±  9%  perf-profile.children.cycles-pp.__fput
      1.26 ±  2%      +0.7        1.96 ±  9%  perf-profile.children.cycles-pp.__close
      1.26 ±  2%      +0.7        1.95 ±  9%  perf-profile.children.cycles-pp.task_work_run
      1.30 ±  2%      +0.7        2.02 ±  9%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      1.64 ±  6%      +0.7        2.37 ±  7%  perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      1.35 ±  2%      +0.8        2.10 ±  8%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.28 ±  5%      +0.9        1.18 ± 14%  perf-profile.children.cycles-pp.ext4_da_map_blocks
      0.28 ±  5%      +0.9        1.19 ± 13%  perf-profile.children.cycles-pp.ext4_da_get_block_prep
      0.29            +1.1        1.35 ±  6%  perf-profile.children.cycles-pp.__find_get_block
      0.32            +1.1        1.46 ±  5%  perf-profile.children.cycles-pp.__getblk_gfp
      0.41 ±  4%      +1.2        1.60 ±  3%  perf-profile.children.cycles-pp.__ext4_get_inode_loc
      0.42 ±  4%      +1.2        1.62 ±  3%  perf-profile.children.cycles-pp.ext4_get_inode_loc
      2.00 ± 18%      +1.3        3.29 ±  6%  perf-profile.children.cycles-pp.__block_commit_write
      0.83 ±  2%      +1.5        2.33 ± 10%  perf-profile.children.cycles-pp.ext4_block_write_begin
      2.04 ± 18%      +1.6        3.60 ±  6%  perf-profile.children.cycles-pp.block_write_end
      2.52 ±  3%      +1.6        4.12 ±  9%  perf-profile.children.cycles-pp.pagecache_get_page
      0.75 ±  4%      +1.6        2.38 ±  3%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      2.54 ±  4%      +1.6        4.17 ±  8%  perf-profile.children.cycles-pp.grab_cache_page_write_begin
      2.42 ±  3%      +2.4        4.87 ±  6%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      4.05 ±  7%     +48.0       52.02 ± 10%  perf-profile.children.cycles-pp.ext4_dirty_inode
      5.28 ± 11%     +73.5       78.74        perf-profile.children.cycles-pp.__mark_inode_dirty
      5.25 ±  8%     +75.5       80.76        perf-profile.children.cycles-pp.generic_write_end
     16.17 ±  6%      -2.4       13.77 ±  8%  perf-profile.self.cycles-pp.add_transaction_credits
      1.52 ±  2%      -1.4        0.15 ±  9%  perf-profile.self.cycles-pp.ext4_da_write_begin
      1.81 ±  5%      -1.2        0.62 ± 16%  perf-profile.self.cycles-pp.up_write
      0.06            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.ext4_da_write_end
      0.08 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.05 ±  8%      +0.0        0.07 ± 12%  perf-profile.self.cycles-pp.__slab_free
      0.06 ±  8%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.drop_buffers
      0.06            +0.0        0.08 ± 11%  perf-profile.self.cycles-pp.truncate_cleanup_page
      0.05            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.do_syscall_64
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.06 ±  8%      +0.0        0.08 ± 11%  perf-profile.self.cycles-pp.page_counter_cancel
      0.06 ±  7%      +0.0        0.09 ± 15%  perf-profile.self.cycles-pp.page_cache_free_page
      0.08 ±  5%      +0.0        0.11 ± 14%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.03 ± 70%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.jbd2_journal_grab_journal_head
      0.06 ±  8%      +0.0        0.09 ± 10%  perf-profile.self.cycles-pp.crypto_shash_update
      0.03 ± 70%      +0.0        0.07        perf-profile.self.cycles-pp.rcu_all_qs
      0.06 ± 13%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.ext4_buffered_write_iter
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.14 ±  3%      +0.0        0.18 ± 12%  perf-profile.self.cycles-pp.block_invalidatepage
      0.06 ±  8%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__entry_text_start
      0.08 ± 10%      +0.0        0.12 ±  7%  perf-profile.self.cycles-pp.__add_to_page_cache_locked
      0.09 ±  5%      +0.0        0.13 ± 12%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.05            +0.0        0.10 ± 17%  perf-profile.self.cycles-pp.ext4_file_write_iter
      0.06 ±  7%      +0.0        0.11        perf-profile.self.cycles-pp.common_file_perm
      0.06 ±  8%      +0.0        0.10 ± 25%  perf-profile.self.cycles-pp.__ext4_get_inode_loc
      0.03 ± 70%      +0.0        0.08        perf-profile.self.cycles-pp.llseek
      0.03 ± 70%      +0.0        0.08        perf-profile.self.cycles-pp.__fsnotify_parent
      0.14 ±  6%      +0.0        0.19 ±  2%  perf-profile.self.cycles-pp.generic_perform_write
      0.08 ±  5%      +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.xas_load
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.xas_store
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.rmqueue
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.02 ±141%      +0.1        0.07 ± 20%  perf-profile.self.cycles-pp.__ext4_journal_get_write_access
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.aa_file_perm
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.14 ±  9%      +0.1        0.19 ±  2%  perf-profile.self.cycles-pp.__might_sleep
      0.11 ±  4%      +0.1        0.17 ± 11%  perf-profile.self.cycles-pp.release_pages
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.xas_start
      0.00            +0.1        0.06 ± 23%  perf-profile.self.cycles-pp.jbd2_journal_dirty_metadata
      0.08 ±  6%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__fget_light
      0.04 ± 71%      +0.1        0.10 ±  8%  perf-profile.self.cycles-pp.file_update_time
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.generic_write_checks
      0.11 ±  4%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.06            +0.1        0.13 ± 19%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.map_id_up
      0.08 ±  5%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.disk_rw
      0.00            +0.1        0.07 ± 12%  perf-profile.self.cycles-pp._raw_write_lock
      0.04 ± 73%      +0.1        0.12 ± 14%  perf-profile.self.cycles-pp.PageHuge
      0.08 ±  6%      +0.1        0.16 ± 24%  perf-profile.self.cycles-pp.new_sync_write
      0.12 ±  3%      +0.1        0.20 ± 12%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.11 ± 11%      +0.1        0.19 ±  4%  perf-profile.self.cycles-pp.write
      0.00            +0.1        0.09 ± 10%  perf-profile.self.cycles-pp.up_read
      0.00            +0.1        0.10 ± 31%  perf-profile.self.cycles-pp.ksys_write
      0.00            +0.1        0.10 ± 16%  perf-profile.self.cycles-pp.ext4_es_lookup_extent
      0.09 ± 28%      +0.1        0.20 ±  7%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.00            +0.1        0.12 ± 22%  perf-profile.self.cycles-pp.down_read
      0.15 ± 11%      +0.1        0.27        perf-profile.self.cycles-pp.crc32c_pcl_intel_update
      0.20 ±  6%      +0.1        0.33 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.43 ±  4%      +0.1        0.57 ± 10%  perf-profile.self.cycles-pp.ext4_mark_iloc_dirty
      0.00            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.block_write_end
      0.77 ±  3%      +0.2        0.94 ± 13%  perf-profile.self.cycles-pp.unlock_page
      0.40 ± 10%      +0.2        0.57 ±  9%  perf-profile.self.cycles-pp.down_write
      0.36 ±  6%      +0.2        0.54 ± 18%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.14 ±  3%      +0.2        0.32 ± 38%  perf-profile.self.cycles-pp.vfs_write
      0.41 ±  6%      +0.2        0.60 ± 12%  perf-profile.self.cycles-pp.ext4_do_update_inode
      0.30 ± 13%      +0.2        0.49 ±  9%  perf-profile.self.cycles-pp.___might_sleep
      0.06            +0.2        0.29 ± 14%  perf-profile.self.cycles-pp.create_empty_buffers
      0.07 ± 12%      +0.2        0.31 ± 13%  perf-profile.self.cycles-pp.ext4_da_map_blocks
      0.09 ± 28%      +0.2        0.34 ±  4%  perf-profile.self.cycles-pp.osq_lock
      0.36 ±  3%      +0.3        0.62 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock
      0.20 ±  2%      +0.3        0.51 ± 18%  perf-profile.self.cycles-pp.jbd2_write_access_granted
      0.44 ± 12%      +0.4        0.81 ±  5%  perf-profile.self.cycles-pp.generic_write_end
      0.60 ± 13%      +0.4        0.97 ± 10%  perf-profile.self.cycles-pp.mark_buffer_dirty
      1.12 ± 23%      +0.6        1.73 ±  6%  perf-profile.self.cycles-pp.__block_commit_write
      1.19 ±  4%      +0.9        2.10 ± 13%  perf-profile.self.cycles-pp.pagecache_get_page
      0.25 ±  3%      +1.0        1.29 ±  6%  perf-profile.self.cycles-pp.__find_get_block
      0.23 ±  2%      +1.2        1.48 ± 11%  perf-profile.self.cycles-pp.__mark_inode_dirty
     69.67 ± 10%    +771.8%     607.33 ± 80%  interrupts.153:IR-PCI-MSI.25690116-edge.eth0-TxRx-4
    155.00 ± 45%     -54.0%      71.33 ± 56%  interrupts.163:IR-PCI-MSI.25690126-edge.eth0-TxRx-14
    240.67           -40.4%     143.33 ±  2%  interrupts.9:IR-IO-APIC.9-fasteoi.acpi
    132897           -12.9%     115807        interrupts.CAL:Function_call_interrupts
    239938           -47.4%     126219 ± 21%  interrupts.CPU0.LOC:Local_timer_interrupts
     12582           -22.1%       9805 ± 20%  interrupts.CPU0.NMI:Non-maskable_interrupts
     12582           -22.1%       9805 ± 20%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
      1117 ± 11%     -31.4%     766.33 ± 19%  interrupts.CPU0.RES:Rescheduling_interrupts
    240.67           -40.4%     143.33 ±  2%  interrupts.CPU1.9:IR-IO-APIC.9-fasteoi.acpi
    239990           -46.0%     129647 ± 17%  interrupts.CPU1.LOC:Local_timer_interrupts
    891.67 ± 15%     -42.6%     512.00 ± 13%  interrupts.CPU1.RES:Rescheduling_interrupts
    240045           -46.8%     127594 ± 19%  interrupts.CPU10.LOC:Local_timer_interrupts
      1651 ± 53%     -61.0%     644.67 ± 42%  interrupts.CPU10.RES:Rescheduling_interrupts
      1003           -13.9%     864.00        interrupts.CPU100.CAL:Function_call_interrupts
    240046           -46.3%     128839 ± 18%  interrupts.CPU100.LOC:Local_timer_interrupts
    599.67 ± 18%     -45.4%     327.67 ± 24%  interrupts.CPU100.RES:Rescheduling_interrupts
    987.33           -12.2%     867.00        interrupts.CPU101.CAL:Function_call_interrupts
    240021           -46.4%     128542 ± 18%  interrupts.CPU101.LOC:Local_timer_interrupts
    624.33 ± 20%     -50.5%     309.00 ± 17%  interrupts.CPU101.RES:Rescheduling_interrupts
      1003           -12.1%     882.00        interrupts.CPU102.CAL:Function_call_interrupts
    240027           -46.4%     128723 ± 18%  interrupts.CPU102.LOC:Local_timer_interrupts
    642.33 ± 11%     -41.3%     377.00 ± 35%  interrupts.CPU102.RES:Rescheduling_interrupts
    983.67           -11.3%     872.33 ±  3%  interrupts.CPU103.CAL:Function_call_interrupts
    240067           -46.4%     128570 ± 18%  interrupts.CPU103.LOC:Local_timer_interrupts
    567.67 ± 10%     -44.9%     313.00        interrupts.CPU103.RES:Rescheduling_interrupts
    992.33           -11.1%     882.67 ±  3%  interrupts.CPU104.CAL:Function_call_interrupts
    240063           -46.4%     128768 ± 18%  interrupts.CPU104.LOC:Local_timer_interrupts
    647.67 ± 13%     -33.9%     428.00 ± 37%  interrupts.CPU104.RES:Rescheduling_interrupts
    996.67 ±  3%     -10.9%     888.33 ±  4%  interrupts.CPU105.CAL:Function_call_interrupts
    240027           -46.4%     128670 ± 18%  interrupts.CPU105.LOC:Local_timer_interrupts
      1021 ±  5%     -17.5%     843.00 ±  8%  interrupts.CPU106.CAL:Function_call_interrupts
    239978           -46.4%     128720 ± 18%  interrupts.CPU106.LOC:Local_timer_interrupts
    838.67 ± 42%     -67.7%     270.67 ±  8%  interrupts.CPU106.RES:Rescheduling_interrupts
    992.33 ±  2%     -10.6%     887.33 ±  3%  interrupts.CPU107.CAL:Function_call_interrupts
    240041           -46.5%     128475 ± 18%  interrupts.CPU107.LOC:Local_timer_interrupts
    574.33 ± 13%     -44.9%     316.67 ± 16%  interrupts.CPU107.RES:Rescheduling_interrupts
    981.67            -9.8%     885.33        interrupts.CPU108.CAL:Function_call_interrupts
    240049           -46.6%     128273 ± 19%  interrupts.CPU108.LOC:Local_timer_interrupts
    659.00 ±  8%     -49.6%     332.00 ± 21%  interrupts.CPU108.RES:Rescheduling_interrupts
    997.67           -13.8%     860.33 ±  2%  interrupts.CPU109.CAL:Function_call_interrupts
    240066           -46.4%     128761 ± 18%  interrupts.CPU109.LOC:Local_timer_interrupts
    585.00 ± 17%     -48.9%     298.67 ± 22%  interrupts.CPU109.RES:Rescheduling_interrupts
      1020 ±  4%     -12.7%     891.00 ±  4%  interrupts.CPU11.CAL:Function_call_interrupts
    239990           -47.6%     125674 ± 22%  interrupts.CPU11.LOC:Local_timer_interrupts
      1004           -13.7%     867.00        interrupts.CPU110.CAL:Function_call_interrupts
    240202           -46.3%     128904 ± 18%  interrupts.CPU110.LOC:Local_timer_interrupts
    643.33 ± 18%     -51.2%     314.00 ± 16%  interrupts.CPU110.RES:Rescheduling_interrupts
      1006           -12.7%     878.33        interrupts.CPU111.CAL:Function_call_interrupts
    240177           -46.3%     128994 ± 18%  interrupts.CPU111.LOC:Local_timer_interrupts
    625.33 ± 14%     -48.2%     323.67 ± 19%  interrupts.CPU111.RES:Rescheduling_interrupts
    969.33 ±  6%     -10.3%     869.67 ±  3%  interrupts.CPU112.CAL:Function_call_interrupts
    240091           -46.3%     128824 ± 18%  interrupts.CPU112.LOC:Local_timer_interrupts
    632.00 ± 20%     -49.0%     322.33 ± 15%  interrupts.CPU112.RES:Rescheduling_interrupts
      1011 ±  2%     -11.1%     898.33 ±  3%  interrupts.CPU113.CAL:Function_call_interrupts
    240073           -44.9%     132389 ± 20%  interrupts.CPU113.LOC:Local_timer_interrupts
    619.00 ± 13%     -47.9%     322.33 ± 21%  interrupts.CPU113.RES:Rescheduling_interrupts
      1009 ±  4%     -13.7%     871.67 ±  2%  interrupts.CPU114.CAL:Function_call_interrupts
    240110           -46.4%     128636 ± 18%  interrupts.CPU114.LOC:Local_timer_interrupts
    845.00 ± 45%     -61.7%     323.33 ± 16%  interrupts.CPU114.RES:Rescheduling_interrupts
    973.33 ±  3%     -11.3%     863.67        interrupts.CPU115.CAL:Function_call_interrupts
    240071           -46.4%     128755 ± 18%  interrupts.CPU115.LOC:Local_timer_interrupts
    644.33 ± 31%     -54.8%     291.33 ± 11%  interrupts.CPU115.RES:Rescheduling_interrupts
    986.00            -9.9%     888.00 ±  2%  interrupts.CPU116.CAL:Function_call_interrupts
    240079           -46.4%     128631 ± 18%  interrupts.CPU116.LOC:Local_timer_interrupts
    619.67 ± 19%     -48.1%     321.33 ± 12%  interrupts.CPU116.RES:Rescheduling_interrupts
      1017 ±  3%     -10.5%     910.33 ±  4%  interrupts.CPU117.CAL:Function_call_interrupts
    240115           -43.8%     135057 ± 20%  interrupts.CPU117.LOC:Local_timer_interrupts
    616.00 ± 11%     -47.2%     325.00 ± 20%  interrupts.CPU117.RES:Rescheduling_interrupts
    240100           -46.4%     128586 ± 18%  interrupts.CPU118.LOC:Local_timer_interrupts
    663.00 ±  5%     -56.3%     289.67 ± 14%  interrupts.CPU118.RES:Rescheduling_interrupts
      1015 ±  2%     -14.4%     869.00        interrupts.CPU119.CAL:Function_call_interrupts
    240094           -46.3%     128849 ± 18%  interrupts.CPU119.LOC:Local_timer_interrupts
    723.33 ± 22%     -61.8%     276.33 ±  9%  interrupts.CPU119.RES:Rescheduling_interrupts
      1021           -15.3%     864.67 ±  2%  interrupts.CPU12.CAL:Function_call_interrupts
    240034           -47.6%     125794 ± 22%  interrupts.CPU12.LOC:Local_timer_interrupts
    888.67 ± 19%     -40.3%     530.33 ± 17%  interrupts.CPU12.RES:Rescheduling_interrupts
    996.00           -14.3%     853.67        interrupts.CPU120.CAL:Function_call_interrupts
    240057           -46.4%     128595 ± 18%  interrupts.CPU120.LOC:Local_timer_interrupts
    577.00 ± 15%     -51.2%     281.67 ± 19%  interrupts.CPU120.RES:Rescheduling_interrupts
    978.67           -11.6%     865.00 ±  3%  interrupts.CPU121.CAL:Function_call_interrupts
    240050           -46.4%     128752 ± 18%  interrupts.CPU121.LOC:Local_timer_interrupts
    606.33 ± 16%     -54.1%     278.33 ± 11%  interrupts.CPU121.RES:Rescheduling_interrupts
    240104           -46.4%     128776 ± 18%  interrupts.CPU122.LOC:Local_timer_interrupts
    598.00 ± 19%     -46.0%     322.67 ± 16%  interrupts.CPU122.RES:Rescheduling_interrupts
    991.33           -13.0%     862.67        interrupts.CPU123.CAL:Function_call_interrupts
    240114           -46.3%     128909 ± 18%  interrupts.CPU123.LOC:Local_timer_interrupts
    605.67 ± 18%     -54.5%     275.33 ± 10%  interrupts.CPU123.RES:Rescheduling_interrupts
    240133           -45.8%     130064 ± 19%  interrupts.CPU124.LOC:Local_timer_interrupts
    625.67 ± 20%     -57.3%     267.00 ± 13%  interrupts.CPU124.RES:Rescheduling_interrupts
      1006           -11.5%     890.00        interrupts.CPU125.CAL:Function_call_interrupts
    240148           -46.4%     128815 ± 18%  interrupts.CPU125.LOC:Local_timer_interrupts
    592.33 ± 18%     -50.4%     294.00 ±  2%  interrupts.CPU125.RES:Rescheduling_interrupts
    240159           -46.4%     128732 ± 18%  interrupts.CPU126.LOC:Local_timer_interrupts
      1067           -15.1%     905.67 ±  3%  interrupts.CPU127.CAL:Function_call_interrupts
    240164           -46.1%     129508 ± 17%  interrupts.CPU127.LOC:Local_timer_interrupts
    672.67 ± 16%     -56.8%     290.67 ±  8%  interrupts.CPU127.RES:Rescheduling_interrupts
      1027 ±  3%     -15.8%     865.00        interrupts.CPU13.CAL:Function_call_interrupts
    239984           -46.9%     127380 ± 20%  interrupts.CPU13.LOC:Local_timer_interrupts
     12539           -32.5%       8462        interrupts.CPU13.NMI:Non-maskable_interrupts
     12539           -32.5%       8462        interrupts.CPU13.PMI:Performance_monitoring_interrupts
    958.00 ± 25%     -42.4%     552.00 ± 13%  interrupts.CPU13.RES:Rescheduling_interrupts
    155.00 ± 45%     -54.0%      71.33 ± 56%  interrupts.CPU14.163:IR-PCI-MSI.25690126-edge.eth0-TxRx-14
      1084 ±  9%     -19.0%     877.67 ±  3%  interrupts.CPU14.CAL:Function_call_interrupts
    239844           -47.1%     126810 ± 20%  interrupts.CPU14.LOC:Local_timer_interrupts
     12579           -32.8%       8451        interrupts.CPU14.NMI:Non-maskable_interrupts
     12579           -32.8%       8451        interrupts.CPU14.PMI:Performance_monitoring_interrupts
      2237 ± 47%     -75.5%     547.00 ±  7%  interrupts.CPU14.RES:Rescheduling_interrupts
      1013 ±  4%     -12.6%     885.67        interrupts.CPU15.CAL:Function_call_interrupts
    240154           -47.6%     125757 ± 21%  interrupts.CPU15.LOC:Local_timer_interrupts
    975.00 ± 19%     -48.4%     502.67 ±  8%  interrupts.CPU15.RES:Rescheduling_interrupts
    239531           -47.5%     125838 ± 22%  interrupts.CPU16.LOC:Local_timer_interrupts
      1033 ± 33%     -42.8%     590.67 ±  5%  interrupts.CPU16.RES:Rescheduling_interrupts
      1083 ±  8%     -14.7%     924.33 ±  9%  interrupts.CPU17.CAL:Function_call_interrupts
    239788           -47.2%     126653 ± 21%  interrupts.CPU17.LOC:Local_timer_interrupts
      1568 ± 68%     -63.2%     577.33 ±  2%  interrupts.CPU17.RES:Rescheduling_interrupts
    243526 ±  2%     -48.4%     125762 ± 22%  interrupts.CPU18.LOC:Local_timer_interrupts
      1020 ±  4%     -16.6%     850.67        interrupts.CPU19.CAL:Function_call_interrupts
    240014           -49.7%     120806 ± 28%  interrupts.CPU19.LOC:Local_timer_interrupts
      8368           +34.7%      11270 ± 17%  interrupts.CPU19.NMI:Non-maskable_interrupts
      8368           +34.7%      11270 ± 17%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
    869.67 ± 27%     -36.0%     556.33 ±  5%  interrupts.CPU19.RES:Rescheduling_interrupts
    240076           -47.5%     125940 ± 21%  interrupts.CPU2.LOC:Local_timer_interrupts
    915.67 ±  2%     -39.1%     558.00 ± 18%  interrupts.CPU2.RES:Rescheduling_interrupts
    239883           -47.6%     125721 ± 22%  interrupts.CPU20.LOC:Local_timer_interrupts
      1095 ± 15%     -21.8%     857.00        interrupts.CPU21.CAL:Function_call_interrupts
    240006           -47.7%     125561 ± 22%  interrupts.CPU21.LOC:Local_timer_interrupts
    913.33 ± 15%     -43.5%     516.00 ± 17%  interrupts.CPU21.RES:Rescheduling_interrupts
    987.00 ±  3%     -12.1%     867.67        interrupts.CPU22.CAL:Function_call_interrupts
    239946           -47.4%     126149 ± 21%  interrupts.CPU22.LOC:Local_timer_interrupts
    831.00 ± 16%     -34.7%     542.67 ± 26%  interrupts.CPU22.RES:Rescheduling_interrupts
      1015 ±  5%     -12.5%     888.00 ±  5%  interrupts.CPU23.CAL:Function_call_interrupts
    239997           -47.7%     125485 ± 22%  interrupts.CPU23.LOC:Local_timer_interrupts
      1217 ± 57%     -51.8%     586.67 ±  3%  interrupts.CPU23.RES:Rescheduling_interrupts
    239993           -47.6%     125809 ± 22%  interrupts.CPU24.LOC:Local_timer_interrupts
    986.67           -11.4%     874.33 ±  6%  interrupts.CPU25.CAL:Function_call_interrupts
    239960           -47.6%     125845 ± 22%  interrupts.CPU25.LOC:Local_timer_interrupts
    785.33 ± 10%     -25.0%     589.00 ± 17%  interrupts.CPU25.RES:Rescheduling_interrupts
      1031 ±  7%     -18.4%     842.00 ±  2%  interrupts.CPU26.CAL:Function_call_interrupts
    240006           -47.7%     125546 ± 22%  interrupts.CPU26.LOC:Local_timer_interrupts
    766.33 ± 13%     -30.0%     536.33 ± 20%  interrupts.CPU26.RES:Rescheduling_interrupts
      1000 ±  7%     -11.9%     880.67 ±  6%  interrupts.CPU27.CAL:Function_call_interrupts
    240002           -47.6%     125857 ± 22%  interrupts.CPU27.LOC:Local_timer_interrupts
    736.67 ± 10%     -23.5%     563.33 ± 15%  interrupts.CPU27.RES:Rescheduling_interrupts
      1010           -13.0%     879.67 ±  2%  interrupts.CPU28.CAL:Function_call_interrupts
    240101           -47.5%     126025 ± 21%  interrupts.CPU28.LOC:Local_timer_interrupts
    792.00 ± 12%     -43.2%     450.00 ± 13%  interrupts.CPU28.RES:Rescheduling_interrupts
    240044           -47.6%     125718 ± 22%  interrupts.CPU29.LOC:Local_timer_interrupts
      1745 ± 51%     -48.0%     908.33 ±  4%  interrupts.CPU3.CAL:Function_call_interrupts
    246138 ±  2%     -48.6%     126403 ± 21%  interrupts.CPU3.LOC:Local_timer_interrupts
    799.00 ± 13%     -27.2%     581.67 ± 14%  interrupts.CPU3.RES:Rescheduling_interrupts
      1038 ±  4%     -16.1%     870.67 ±  2%  interrupts.CPU30.CAL:Function_call_interrupts
    240200           -47.6%     125886 ± 22%  interrupts.CPU30.LOC:Local_timer_interrupts
    827.00 ± 17%     -41.0%     488.00 ±  8%  interrupts.CPU30.RES:Rescheduling_interrupts
    997.33 ±  3%     -12.4%     873.33 ±  2%  interrupts.CPU31.CAL:Function_call_interrupts
    240099           -47.6%     125763 ± 22%  interrupts.CPU31.LOC:Local_timer_interrupts
    801.33 ± 18%     -36.1%     511.67 ±  7%  interrupts.CPU31.RES:Rescheduling_interrupts
      1137 ±  4%     -16.6%     948.00        interrupts.CPU32.CAL:Function_call_interrupts
    240090           -47.2%     126702 ± 21%  interrupts.CPU32.LOC:Local_timer_interrupts
    999.67 ±  6%     -54.7%     453.33 ±  6%  interrupts.CPU32.RES:Rescheduling_interrupts
      1147 ±  2%     -12.9%     999.00 ±  6%  interrupts.CPU33.CAL:Function_call_interrupts
    240058           -47.6%     125750 ± 22%  interrupts.CPU33.LOC:Local_timer_interrupts
    833.00 ± 19%     -42.5%     478.67 ± 34%  interrupts.CPU33.RES:Rescheduling_interrupts
      1111           -15.5%     938.33 ±  2%  interrupts.CPU34.CAL:Function_call_interrupts
    240067           -47.1%     126931 ± 20%  interrupts.CPU34.LOC:Local_timer_interrupts
      1049           -13.2%     911.33 ±  2%  interrupts.CPU35.CAL:Function_call_interrupts
    240020           -47.4%     126258 ± 21%  interrupts.CPU35.LOC:Local_timer_interrupts
    653.00 ± 16%     -53.0%     307.00 ±  7%  interrupts.CPU35.RES:Rescheduling_interrupts
      1039 ±  2%     -17.0%     863.00 ±  2%  interrupts.CPU36.CAL:Function_call_interrupts
    240081           -47.2%     126663 ± 21%  interrupts.CPU36.LOC:Local_timer_interrupts
    610.67 ± 16%     -47.5%     320.67 ± 24%  interrupts.CPU36.RES:Rescheduling_interrupts
      1089 ±  3%     -17.7%     896.33        interrupts.CPU37.CAL:Function_call_interrupts
    240045           -47.3%     126550 ± 21%  interrupts.CPU37.LOC:Local_timer_interrupts
     12576           -23.3%       9651 ± 20%  interrupts.CPU37.NMI:Non-maskable_interrupts
     12576           -23.3%       9651 ± 20%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
    641.67 ± 10%     -55.5%     285.33 ± 11%  interrupts.CPU37.RES:Rescheduling_interrupts
      1023 ±  2%     -12.2%     898.67        interrupts.CPU38.CAL:Function_call_interrupts
    240070           -47.8%     125294 ± 22%  interrupts.CPU38.LOC:Local_timer_interrupts
    628.00 ± 11%     -48.0%     326.33 ± 25%  interrupts.CPU38.RES:Rescheduling_interrupts
      1015           -12.2%     891.67        interrupts.CPU39.CAL:Function_call_interrupts
    240076           -47.8%     125246 ± 22%  interrupts.CPU39.LOC:Local_timer_interrupts
    632.33 ± 14%     -48.9%     323.33 ± 12%  interrupts.CPU39.RES:Rescheduling_interrupts
     69.67 ± 10%    +771.8%     607.33 ± 80%  interrupts.CPU4.153:IR-PCI-MSI.25690116-edge.eth0-TxRx-4
      1061 ±  6%     -18.1%     868.67        interrupts.CPU4.CAL:Function_call_interrupts
    240010           -46.8%     127721 ± 19%  interrupts.CPU4.LOC:Local_timer_interrupts
      1020 ±  2%     -15.5%     862.00        interrupts.CPU40.CAL:Function_call_interrupts
    240083           -47.4%     126373 ± 21%  interrupts.CPU40.LOC:Local_timer_interrupts
     12480           -22.6%       9662 ± 19%  interrupts.CPU40.NMI:Non-maskable_interrupts
     12480           -22.6%       9662 ± 19%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    630.33 ± 14%     -55.0%     283.67 ± 10%  interrupts.CPU40.RES:Rescheduling_interrupts
      1029           -14.7%     878.33        interrupts.CPU41.CAL:Function_call_interrupts
    240077           -47.5%     126094 ± 21%  interrupts.CPU41.LOC:Local_timer_interrupts
    657.33 ± 14%     -54.2%     301.00 ± 12%  interrupts.CPU41.RES:Rescheduling_interrupts
      1014           -11.8%     895.00 ±  4%  interrupts.CPU42.CAL:Function_call_interrupts
    240023           -47.8%     125345 ± 22%  interrupts.CPU42.LOC:Local_timer_interrupts
    638.00 ± 14%     -49.6%     321.33 ± 14%  interrupts.CPU42.RES:Rescheduling_interrupts
    240039           -47.8%     125350 ± 22%  interrupts.CPU43.LOC:Local_timer_interrupts
    608.67 ± 13%     -37.6%     379.67 ± 27%  interrupts.CPU43.RES:Rescheduling_interrupts
      1019           -15.9%     857.33        interrupts.CPU44.CAL:Function_call_interrupts
    240068           -47.8%     125415 ± 22%  interrupts.CPU44.LOC:Local_timer_interrupts
    641.00 ± 12%     -49.3%     324.67 ± 22%  interrupts.CPU44.RES:Rescheduling_interrupts
      1014 ±  2%     -15.0%     862.33        interrupts.CPU45.CAL:Function_call_interrupts
    240035           -47.9%     125086 ± 23%  interrupts.CPU45.LOC:Local_timer_interrupts
    695.00 ± 16%     -53.1%     325.67 ± 22%  interrupts.CPU45.RES:Rescheduling_interrupts
      1068 ±  4%     -20.3%     852.00 ±  2%  interrupts.CPU46.CAL:Function_call_interrupts
    240143           -47.7%     125647 ± 22%  interrupts.CPU46.LOC:Local_timer_interrupts
    914.33 ± 35%     -65.8%     312.33 ± 15%  interrupts.CPU46.RES:Rescheduling_interrupts
      1034           -15.2%     877.33        interrupts.CPU47.CAL:Function_call_interrupts
    240127           -47.8%     125444 ± 22%  interrupts.CPU47.LOC:Local_timer_interrupts
    643.33 ± 14%     -50.0%     321.67 ± 17%  interrupts.CPU47.RES:Rescheduling_interrupts
      1000           -14.4%     856.33        interrupts.CPU48.CAL:Function_call_interrupts
    240104           -47.4%     126375 ± 21%  interrupts.CPU48.LOC:Local_timer_interrupts
    635.33 ± 11%     -49.2%     323.00 ± 21%  interrupts.CPU48.RES:Rescheduling_interrupts
    978.00           -12.2%     858.33 ±  3%  interrupts.CPU49.CAL:Function_call_interrupts
    240050           -47.8%     125329 ± 22%  interrupts.CPU49.LOC:Local_timer_interrupts
    619.33 ± 13%     -52.9%     291.67 ± 15%  interrupts.CPU49.RES:Rescheduling_interrupts
    240037           -46.7%     128059 ± 19%  interrupts.CPU5.LOC:Local_timer_interrupts
    961.67 ± 10%     -45.8%     521.33 ±  4%  interrupts.CPU5.RES:Rescheduling_interrupts
    993.00 ±  2%     -13.4%     859.67        interrupts.CPU50.CAL:Function_call_interrupts
    240071           -47.9%     125191 ± 22%  interrupts.CPU50.LOC:Local_timer_interrupts
    633.00 ± 13%     -54.3%     289.33 ± 12%  interrupts.CPU50.RES:Rescheduling_interrupts
    986.67           -18.7%     802.33 ± 13%  interrupts.CPU51.CAL:Function_call_interrupts
    240065           -47.8%     125304 ± 22%  interrupts.CPU51.LOC:Local_timer_interrupts
    654.00 ±  7%     -50.1%     326.67 ± 18%  interrupts.CPU51.RES:Rescheduling_interrupts
    240060           -47.9%     125162 ± 22%  interrupts.CPU52.LOC:Local_timer_interrupts
    629.33 ± 17%     -49.6%     317.00 ±  5%  interrupts.CPU52.RES:Rescheduling_interrupts
    975.33           -12.4%     854.00        interrupts.CPU53.CAL:Function_call_interrupts
    240047           -47.8%     125194 ± 22%  interrupts.CPU53.LOC:Local_timer_interrupts
    613.33 ± 12%     -50.5%     303.67 ± 13%  interrupts.CPU53.RES:Rescheduling_interrupts
      1020 ±  4%     -15.0%     867.33        interrupts.CPU54.CAL:Function_call_interrupts
    246849 ±  3%     -49.3%     125175 ± 22%  interrupts.CPU54.LOC:Local_timer_interrupts
    621.33 ± 14%     -51.5%     301.33 ± 13%  interrupts.CPU54.RES:Rescheduling_interrupts
    986.00 ±  2%     -14.0%     847.67 ±  3%  interrupts.CPU55.CAL:Function_call_interrupts
    240063           -47.5%     126036 ± 21%  interrupts.CPU55.LOC:Local_timer_interrupts
    627.67 ± 12%     -53.5%     292.00 ± 16%  interrupts.CPU55.RES:Rescheduling_interrupts
    993.67 ±  2%     -14.6%     848.67        interrupts.CPU56.CAL:Function_call_interrupts
    240063           -47.8%     125234 ± 22%  interrupts.CPU56.LOC:Local_timer_interrupts
    607.33 ± 15%     -54.0%     279.33 ± 10%  interrupts.CPU56.RES:Rescheduling_interrupts
    982.33 ±  3%     -13.2%     853.00        interrupts.CPU57.CAL:Function_call_interrupts
    240058           -47.9%     125167 ± 22%  interrupts.CPU57.LOC:Local_timer_interrupts
    703.33 ± 12%     -58.3%     293.33 ± 11%  interrupts.CPU57.RES:Rescheduling_interrupts
      1016 ±  2%     -15.7%     857.33 ±  3%  interrupts.CPU58.CAL:Function_call_interrupts
    240123           -47.9%     125196 ± 23%  interrupts.CPU58.LOC:Local_timer_interrupts
    722.67 ± 15%     -59.4%     293.67 ± 10%  interrupts.CPU58.RES:Rescheduling_interrupts
    964.33           -11.7%     851.33 ±  2%  interrupts.CPU59.CAL:Function_call_interrupts
    240099           -47.9%     125123 ± 22%  interrupts.CPU59.LOC:Local_timer_interrupts
    613.67 ±  9%     -51.0%     300.67 ± 12%  interrupts.CPU59.RES:Rescheduling_interrupts
    239807           -47.5%     125935 ± 21%  interrupts.CPU6.LOC:Local_timer_interrupts
      1732 ± 63%     -71.0%     502.67 ± 11%  interrupts.CPU6.RES:Rescheduling_interrupts
    988.67           -13.4%     856.33 ±  2%  interrupts.CPU60.CAL:Function_call_interrupts
    240111           -47.8%     125221 ± 22%  interrupts.CPU60.LOC:Local_timer_interrupts
    634.67 ± 12%     -52.0%     304.33 ± 16%  interrupts.CPU60.RES:Rescheduling_interrupts
    986.00 ±  2%     -11.5%     872.67        interrupts.CPU61.CAL:Function_call_interrupts
    240135           -47.9%     125035 ± 23%  interrupts.CPU61.LOC:Local_timer_interrupts
    674.33 ± 13%     -51.6%     326.33 ± 23%  interrupts.CPU61.RES:Rescheduling_interrupts
    977.67           -11.3%     867.67 ±  2%  interrupts.CPU62.CAL:Function_call_interrupts
    240159           -47.8%     125341 ± 22%  interrupts.CPU62.LOC:Local_timer_interrupts
    676.67 ± 11%     -53.6%     313.67 ± 20%  interrupts.CPU62.RES:Rescheduling_interrupts
      1006 ±  3%     -12.9%     876.33        interrupts.CPU63.CAL:Function_call_interrupts
    240185           -47.8%     125262 ± 22%  interrupts.CPU63.LOC:Local_timer_interrupts
    661.00 ± 11%     -46.3%     355.00 ± 22%  interrupts.CPU63.RES:Rescheduling_interrupts
    240024           -46.0%     129523 ± 17%  interrupts.CPU64.LOC:Local_timer_interrupts
    239968           -45.8%     130033 ± 16%  interrupts.CPU65.LOC:Local_timer_interrupts
      9764 ± 20%     +29.7%      12667        interrupts.CPU65.NMI:Non-maskable_interrupts
      9764 ± 20%     +29.7%      12667        interrupts.CPU65.PMI:Performance_monitoring_interrupts
    773.00 ± 11%     -22.3%     601.00 ±  9%  interrupts.CPU65.RES:Rescheduling_interrupts
    239986           -46.1%     129299 ± 17%  interrupts.CPU66.LOC:Local_timer_interrupts
      1007 ±  5%     -12.6%     880.33 ±  5%  interrupts.CPU67.CAL:Function_call_interrupts
    239950           -46.1%     129295 ± 17%  interrupts.CPU67.LOC:Local_timer_interrupts
    832.67 ±  6%     -35.6%     536.00 ± 14%  interrupts.CPU67.RES:Rescheduling_interrupts
      1021 ±  4%     -15.3%     865.33 ±  2%  interrupts.CPU68.CAL:Function_call_interrupts
    240004           -46.1%     129269 ± 17%  interrupts.CPU68.LOC:Local_timer_interrupts
      9764 ± 20%     +29.8%      12677        interrupts.CPU68.NMI:Non-maskable_interrupts
      9764 ± 20%     +29.8%      12677        interrupts.CPU68.PMI:Performance_monitoring_interrupts
      1075 ± 24%     -54.4%     490.00 ± 16%  interrupts.CPU68.RES:Rescheduling_interrupts
    239958           -45.9%     129793 ± 17%  interrupts.CPU69.LOC:Local_timer_interrupts
    239993           -46.8%     127626 ± 19%  interrupts.CPU7.LOC:Local_timer_interrupts
      2021 ± 42%     -64.6%     716.00 ± 42%  interrupts.CPU7.RES:Rescheduling_interrupts
      1071 ± 11%     -20.9%     846.67        interrupts.CPU70.CAL:Function_call_interrupts
    239964           -46.1%     129309 ± 17%  interrupts.CPU70.LOC:Local_timer_interrupts
      9779 ± 20%     +29.3%      12648        interrupts.CPU70.NMI:Non-maskable_interrupts
      9779 ± 20%     +29.3%      12648        interrupts.CPU70.PMI:Performance_monitoring_interrupts
      1520 ± 66%     -67.4%     495.00 ± 24%  interrupts.CPU70.RES:Rescheduling_interrupts
      1050 ±  7%     -15.1%     892.33 ±  5%  interrupts.CPU71.CAL:Function_call_interrupts
    240046           -46.1%     129443 ± 17%  interrupts.CPU71.LOC:Local_timer_interrupts
    239974           -46.2%     129217 ± 17%  interrupts.CPU72.LOC:Local_timer_interrupts
      8357           +51.3%      12641        interrupts.CPU72.NMI:Non-maskable_interrupts
      8357           +51.3%      12641        interrupts.CPU72.PMI:Performance_monitoring_interrupts
    972.00 ±  2%      -9.6%     878.67 ±  5%  interrupts.CPU73.CAL:Function_call_interrupts
    239980           -46.2%     129101 ± 17%  interrupts.CPU73.LOC:Local_timer_interrupts
      8352           +51.7%      12668        interrupts.CPU73.NMI:Non-maskable_interrupts
      8352           +51.7%      12668        interrupts.CPU73.PMI:Performance_monitoring_interrupts
    840.33 ±  6%     -29.7%     590.67 ±  7%  interrupts.CPU73.RES:Rescheduling_interrupts
    981.00 ±  3%      -6.7%     915.00 ±  3%  interrupts.CPU74.CAL:Function_call_interrupts
    239985           -46.1%     129294 ± 17%  interrupts.CPU74.LOC:Local_timer_interrupts
      8361           +51.1%      12635        interrupts.CPU74.NMI:Non-maskable_interrupts
      8361           +51.1%      12635        interrupts.CPU74.PMI:Performance_monitoring_interrupts
    240829           -46.3%     129241 ± 17%  interrupts.CPU75.LOC:Local_timer_interrupts
      8354           +51.3%      12639        interrupts.CPU75.NMI:Non-maskable_interrupts
      8354           +51.3%      12639        interrupts.CPU75.PMI:Performance_monitoring_interrupts
      1215 ± 24%     -29.0%     862.67        interrupts.CPU76.CAL:Function_call_interrupts
    239936           -46.1%     129378 ± 17%  interrupts.CPU76.LOC:Local_timer_interrupts
      8356           +51.9%      12689        interrupts.CPU76.NMI:Non-maskable_interrupts
      8356           +51.9%      12689        interrupts.CPU76.PMI:Performance_monitoring_interrupts
      1190 ± 53%     -53.9%     548.67 ± 26%  interrupts.CPU76.RES:Rescheduling_interrupts
    240024           -46.1%     129392 ± 17%  interrupts.CPU77.LOC:Local_timer_interrupts
      9761 ± 20%     +29.9%      12678        interrupts.CPU77.NMI:Non-maskable_interrupts
      9761 ± 20%     +29.9%      12678        interrupts.CPU77.PMI:Performance_monitoring_interrupts
    887.33 ±  7%     -29.0%     629.67 ± 20%  interrupts.CPU77.RES:Rescheduling_interrupts
    979.00 ±  2%     -12.7%     854.33        interrupts.CPU78.CAL:Function_call_interrupts
    240014           -46.2%     129202 ± 17%  interrupts.CPU78.LOC:Local_timer_interrupts
    898.33 ± 17%     -34.6%     587.33 ± 19%  interrupts.CPU78.RES:Rescheduling_interrupts
    240108           -46.1%     129498 ± 17%  interrupts.CPU79.LOC:Local_timer_interrupts
      1026 ±  4%     -16.1%     860.67        interrupts.CPU8.CAL:Function_call_interrupts
    239982           -47.6%     125787 ± 22%  interrupts.CPU8.LOC:Local_timer_interrupts
    956.67 ± 11%     -42.2%     552.67 ± 23%  interrupts.CPU8.RES:Rescheduling_interrupts
    239946           -46.1%     129308 ± 17%  interrupts.CPU80.LOC:Local_timer_interrupts
      9778 ± 20%     +29.7%      12680        interrupts.CPU80.NMI:Non-maskable_interrupts
      9778 ± 20%     +29.7%      12680        interrupts.CPU80.PMI:Performance_monitoring_interrupts
      1061 ± 11%     -18.8%     862.33        interrupts.CPU81.CAL:Function_call_interrupts
    240044           -46.1%     129361 ± 17%  interrupts.CPU81.LOC:Local_timer_interrupts
      1570 ± 59%     -70.9%     457.00 ± 13%  interrupts.CPU81.RES:Rescheduling_interrupts
    241709           -46.5%     129399 ± 17%  interrupts.CPU82.LOC:Local_timer_interrupts
    240054           -46.3%     129000 ± 18%  interrupts.CPU83.LOC:Local_timer_interrupts
    239873           -46.2%     129076 ± 18%  interrupts.CPU84.LOC:Local_timer_interrupts
    239952           -46.1%     129352 ± 17%  interrupts.CPU85.LOC:Local_timer_interrupts
      9742 ± 20%     +15.6%      11260 ± 17%  interrupts.CPU85.NMI:Non-maskable_interrupts
      9742 ± 20%     +15.6%      11260 ± 17%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
    838.00 ± 11%     -26.7%     614.67 ± 25%  interrupts.CPU85.RES:Rescheduling_interrupts
    963.33            -8.8%     878.67 ±  6%  interrupts.CPU86.CAL:Function_call_interrupts
    239964           -46.1%     129240 ± 17%  interrupts.CPU86.LOC:Local_timer_interrupts
    787.00 ± 15%     -34.7%     514.00 ± 11%  interrupts.CPU86.RES:Rescheduling_interrupts
    987.33 ±  5%     -10.1%     888.00 ±  3%  interrupts.CPU87.CAL:Function_call_interrupts
    240019           -46.1%     129379 ± 17%  interrupts.CPU87.LOC:Local_timer_interrupts
    917.33 ±  9%     -41.1%     540.33 ± 21%  interrupts.CPU87.RES:Rescheduling_interrupts
    984.00           -13.0%     856.00 ±  2%  interrupts.CPU88.CAL:Function_call_interrupts
    240005           -46.2%     129206 ± 17%  interrupts.CPU88.LOC:Local_timer_interrupts
    847.00 ±  8%     -42.6%     486.33 ±  7%  interrupts.CPU88.RES:Rescheduling_interrupts
      1119 ±  8%     -19.9%     896.67 ±  4%  interrupts.CPU89.CAL:Function_call_interrupts
    240000           -46.2%     129181 ± 17%  interrupts.CPU89.LOC:Local_timer_interrupts
      1235 ± 44%     -60.6%     487.33 ±  7%  interrupts.CPU89.RES:Rescheduling_interrupts
      1566 ± 47%     -45.4%     855.00        interrupts.CPU9.CAL:Function_call_interrupts
    240007           -47.5%     125898 ± 22%  interrupts.CPU9.LOC:Local_timer_interrupts
    802.33 ± 19%     -41.1%     472.33 ± 15%  interrupts.CPU9.RES:Rescheduling_interrupts
      1014 ±  3%     -15.2%     859.67 ±  3%  interrupts.CPU90.CAL:Function_call_interrupts
    239988           -46.1%     129330 ± 17%  interrupts.CPU90.LOC:Local_timer_interrupts
    890.33 ± 10%     -25.3%     665.33 ± 22%  interrupts.CPU90.RES:Rescheduling_interrupts
      1052 ±  9%     -15.4%     890.00 ±  4%  interrupts.CPU91.CAL:Function_call_interrupts
    241075           -46.4%     129286 ± 17%  interrupts.CPU91.LOC:Local_timer_interrupts
      1250 ± 46%     -49.0%     638.33 ± 29%  interrupts.CPU91.RES:Rescheduling_interrupts
    240154           -46.1%     129491 ± 17%  interrupts.CPU92.LOC:Local_timer_interrupts
    997.00 ±  3%     -12.2%     875.67        interrupts.CPU93.CAL:Function_call_interrupts
    240100           -46.1%     129501 ± 17%  interrupts.CPU93.LOC:Local_timer_interrupts
    903.00 ± 13%     -42.4%     520.33 ± 28%  interrupts.CPU93.RES:Rescheduling_interrupts
    240113           -46.1%     129354 ± 17%  interrupts.CPU94.LOC:Local_timer_interrupts
      1059 ±  5%     -13.5%     915.67 ±  3%  interrupts.CPU95.CAL:Function_call_interrupts
    240211           -46.2%     129305 ± 17%  interrupts.CPU95.LOC:Local_timer_interrupts
      1038 ± 33%     -38.2%     641.67 ± 11%  interrupts.CPU95.RES:Rescheduling_interrupts
    987.33           -11.0%     878.67        interrupts.CPU96.CAL:Function_call_interrupts
    240040           -46.6%     128285 ± 18%  interrupts.CPU96.LOC:Local_timer_interrupts
    617.33 ±  7%     -44.7%     341.67 ± 12%  interrupts.CPU96.RES:Rescheduling_interrupts
    976.00           -11.3%     865.33        interrupts.CPU97.CAL:Function_call_interrupts
    240035           -46.4%     128578 ± 18%  interrupts.CPU97.LOC:Local_timer_interrupts
    597.33 ± 14%     -48.8%     306.00 ± 10%  interrupts.CPU97.RES:Rescheduling_interrupts
      1018 ±  2%     -13.7%     879.33        interrupts.CPU98.CAL:Function_call_interrupts
    240047           -46.3%     128809 ± 18%  interrupts.CPU98.LOC:Local_timer_interrupts
    603.67 ± 11%     -49.9%     302.67 ± 18%  interrupts.CPU98.RES:Rescheduling_interrupts
      1032 ±  6%     -17.0%     857.00        interrupts.CPU99.CAL:Function_call_interrupts
    240007           -46.2%     129045 ± 18%  interrupts.CPU99.LOC:Local_timer_interrupts
      1148 ± 74%     -72.2%     319.00 ± 15%  interrupts.CPU99.RES:Rescheduling_interrupts
    641.67 ±  6%     -27.0%     468.67        interrupts.IWI:IRQ_work_interrupts
  30745024           -46.9%   16326093 ± 20%  interrupts.LOC:Local_timer_interrupts
    107610           -39.5%      65129 ±  4%  interrupts.RES:Rescheduling_interrupts
      0.24 ±124%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.12 ±116%     -97.0%       0.00 ±141%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.02 ±  9%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      6.95 ± 78%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.48 ± 10%     -95.1%       0.02 ±135%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.48 ± 76%     -99.9%       0.00 ±141%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.13 ± 28%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.00 ± 56%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.19 ±  4%     -97.4%       0.01 ± 28%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.93 ± 34%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      3.69 ±  3%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.ipmi_thread.kthread.ret_from_fork
      0.03 ± 51%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      0.01 ± 17%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.kjournald2.kthread.ret_from_fork
      0.92 ±137%     -99.6%       0.00 ± 12%  perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.12 ± 56%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin
      1.41 ± 66%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
      0.00 ± 40%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.__ext4_new_inode.ext4_create
      0.10 ±118%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty
      0.13 ± 38%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      1.02          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__flush_work.lru_add_drain_all.khugepaged
      0.10 ± 40%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc
      0.11 ± 71%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.ext4_getblk.ext4_bread
      2.85 ± 71%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.07 ± 58%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.block_invalidatepage.truncate_cleanup_page.truncate_inode_pages_range
      2.98 ± 44%    -100.0%       0.00 ±141%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.13 ± 74%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.ext4_da_map_blocks.constprop
      2.28 ± 33%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.rmap_walk_anon.remove_migration_ptes
      0.07 ± 13%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.ext4_buffered_write_iter.new_sync_write
      0.04 ± 54%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
      0.15 ±137%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.fscrypt_file_open.ext4_file_open
      0.06 ±136%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
      0.34 ± 65%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.18 ± 20%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
      0.13 ± 21%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode
      0.41 ± 51%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.08 ± 40%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers
      0.26 ± 67%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
      0.11 ± 36%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      0.32 ±138%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      0.19 ±139%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.try_to_migrate.migrate_pages
      2.85 ±127%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
     11.17 ± 10%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.05 ± 83%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict
      0.20 ± 16%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
      2.96 ±115%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      0.18 ±103%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_migrate
      0.74 ± 68%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      1.18 ± 68%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.87 ± 47%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.35 ± 63%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      0.58 ± 21%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      0.10 ± 30%     -98.0%       0.00 ±141%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.02 ± 22%     -62.3%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.01 ± 91%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      1.78 ± 64%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.usleep_range.ipmi_thread.kthread
      0.16 ± 48%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__fdget_pos
      0.67 ± 72%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.ext4_orphan_add
      1.26 ± 46%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.ext4_orphan_del
      0.27 ±125%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      0.03 ± 15%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      2.78 ± 11%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      0.90 ±133%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
      0.02 ± 10%    +448.6%       0.14 ± 46%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      2.12 ±135%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.23 ±124%     -98.1%       0.00 ±141%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.04 ± 27%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      6.95 ± 78%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
     56.52 ± 76%     -99.4%       0.34 ±137%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     13.44 ±  8%     -81.8%       2.44 ± 87%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      9.29 ± 75%    -100.0%       0.00 ±141%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     10.92 ± 18%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.02 ± 19%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     77.93 ± 64%    -100.0%       0.01 ±  8%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.67 ± 37%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      3.79          -100.0%       0.00        perf-sched.sch_delay.max.ms.ipmi_thread.kthread.ret_from_fork
      0.04 ± 62%    -100.0%       0.00        perf-sched.sch_delay.max.ms.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      0.01 ± 18%    -100.0%       0.00        perf-sched.sch_delay.max.ms.kjournald2.kthread.ret_from_fork
      3366 ±141%    -100.0%       0.01 ±  7%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      5.32 ± 41%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin
      1470 ± 72%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
      0.02 ± 11%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.__ext4_new_inode.ext4_create
      2.83 ±128%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty
     18.81 ± 63%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      1.02          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__flush_work.lru_add_drain_all.khugepaged
      8.60          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc
      5.02 ± 73%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.ext4_getblk.ext4_bread
      8.80 ± 71%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
     25.14 ± 83%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.block_invalidatepage.truncate_cleanup_page.truncate_inode_pages_range
     19.87 ± 72%    -100.0%       0.00 ±141%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     10.45 ± 41%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.ext4_da_map_blocks.constprop
     15.33 ± 37%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.rmap_walk_anon.remove_migration_ptes
      7.51 ± 24%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.ext4_buffered_write_iter.new_sync_write
      3.65 ± 57%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
      2.90 ±140%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.fscrypt_file_open.ext4_file_open
      7.96 ±140%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
      1615 ± 64%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
    104.61 ± 66%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
     26.17 ± 35%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode
      1533 ± 67%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      6.52 ± 26%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers
     19.24 ± 80%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
     11.48 ± 16%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      5.32 ±136%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      2.35 ±138%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.try_to_migrate.migrate_pages
    690.56 ±137%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
     47.22 ± 18%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
     10.00 ± 88%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict
     14.49 ± 38%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
      1.91 ±137%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    796.40 ±139%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      6.86 ± 76%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_migrate
      7.65 ± 70%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
     14.12 ± 65%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      1695 ± 64%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
    900.56 ±129%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
     26.32 ± 45%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      1.38 ± 32%     -99.9%       0.00 ±141%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.04 ± 45%     -79.8%       0.01 ±  6%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.04 ± 36%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      3.81          -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.usleep_range.ipmi_thread.kthread
     40.23 ± 61%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__fdget_pos
      4.60 ± 70%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.ext4_orphan_add
     67.63 ±103%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.ext4_orphan_del
      0.27 ±125%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      0.14 ± 39%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     82.51 ± 59%     -90.8%       7.57 ± 70%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
     18.45 ± 22%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
     66.81 ±114%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
      4.81 ±  5%     -31.9%       3.28        perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.40 ± 42%     -91.9%       0.03 ± 37%  perf-sched.total_sch_delay.average.ms
      5037 ± 70%     -99.8%       9.29 ± 31%  perf-sched.total_sch_delay.max.ms
    206.03           -99.7%       0.70 ± 71%  perf-sched.total_wait_and_delay.average.ms
    110407 ±  3%     -99.5%     521.67 ± 10%  perf-sched.total_wait_and_delay.count.ms
     10052           -99.9%      12.56 ± 13%  perf-sched.total_wait_and_delay.max.ms
    205.63           -99.7%       0.67 ± 76%  perf-sched.total_wait_time.average.ms
     10033           -99.9%       9.83 ± 48%  perf-sched.total_wait_time.max.ms
    902.58          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    795.52 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    150.01 ± 10%     -99.8%       0.36 ± 41%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     42.99 ± 14%     -98.9%       0.46 ± 32%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    266.43 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    133.36 ± 19%    -100.0%       0.00 ±141%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3039 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
     70.92 ± 27%     -99.2%       0.53 ± 22%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
    243.86 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
    367.46 ± 31%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty
    258.01 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc
    265.27 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.ext4_da_map_blocks.constprop
    262.92 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.ext4_buffered_write_iter.new_sync_write
    210.81 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
    231.92 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
    234.58 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode
    197.19 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.ext4_buffered_write_iter.new_sync_write
    292.50 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
    207.67 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
    428.40 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
    269.54 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
      7.84 ±  5%     -99.5%       0.04 ± 54%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    261.70 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
    126.62 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
    154.50 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
    318.40 ±  6%     -99.7%       0.90 ± 73%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    479.59          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    628.90 ±  6%     -99.8%       1.41 ± 83%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
    529.05 ±  4%     -99.9%       0.64 ± 27%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
     20.67 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     11.33 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1011 ±  6%     -97.7%      23.67 ± 26%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1027 ±  6%     -97.8%      22.67 ± 50%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    310.33 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      4219 ± 12%    -100.0%       0.67 ±141%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.67 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.count.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      2393 ± 40%     -99.3%      17.00 ± 51%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
      1084 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
     29.67 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty
    297.00 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc
    223.33 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.down_read.ext4_da_map_blocks.constprop
    167.67 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.down_write.ext4_buffered_write_iter.new_sync_write
     41730 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1786 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
      2816 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode
     27473 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.generic_perform_write.ext4_buffered_write_iter.new_sync_write
    134.67 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
    999.33 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
    415.00 ± 38%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
    345.67 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
      1234 ±  4%     -83.2%     207.67 ±  4%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    324.67 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      5216 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4789 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
     33.00 ±  7%     -91.9%       2.67 ± 93%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     41.33 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      2355          -100.0%       1.00 ± 81%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      3443 ±  4%     -94.0%     207.67 ±  4%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
      2351 ±  2%     -98.7%      31.67 ± 48%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      1003          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1000          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
     10000          -100.0%       1.69 ± 39%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      7020 ± 60%    -100.0%       2.64 ± 72%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      2563 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      2639 ±  6%    -100.0%       0.00 ±141%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4975          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      7160 ± 57%    -100.0%       1.48 ±  6%  perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      2647 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
      2300 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty
      2563 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc
      2503 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.ext4_da_map_blocks.constprop
      2576 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.ext4_buffered_write_iter.new_sync_write
      2709 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      2666 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
      2643 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode
      3086 ± 18%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      2560 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
      2620 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      2643 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      2578 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
      1024 ±  3%     -99.5%       4.83 ± 81%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      2511 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      2651 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2669 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
    499.96           -99.4%       2.80 ± 77%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    505.02          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     68.77 ±116%     -95.2%       3.32 ± 70%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      8992 ±  4%     -99.9%      12.56 ± 13%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      5086           -99.9%       5.83 ± 62%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
    902.34          -100.0%       0.00        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.86 ± 16%     -73.9%       0.49 ±141%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    795.50 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    149.53 ± 10%     -99.8%       0.34 ± 53%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     42.83 ± 14%     -99.2%       0.33 ±  3%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     98.52 ±127%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    266.30 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    144.10 ± 69%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      5.96 ± 40%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    133.17 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     44.95 ±120%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      3.88 ±  3%    -100.0%       0.00        perf-sched.wait_time.avg.ms.ipmi_thread.kthread.ret_from_fork
      3039 ± 12%    -100.0%       0.00        perf-sched.wait_time.avg.ms.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      0.23 ± 23%    -100.0%       0.00        perf-sched.wait_time.avg.ms.kjournald2.kthread.ret_from_fork
     69.99 ± 29%     -99.2%       0.53 ± 22%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
    127.82 ±129%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.shmem_alloc_page
    253.61 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin
      8.90 ± 38%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__do_fault.do_fault.__handle_mm_fault
     14.23 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.__ext4_new_inode.ext4_create
    242.45 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
    201.67 ±135%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_free_inode.ext4_evict_inode
    262.06 ±131%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_handle_dirty_dirblock.add_dirent_to_buf
    302.18 ± 95%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_handle_dirty_dirblock.ext4_delete_entry
     10.34 ± 25%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_orphan_add.__ext4_unlink
    224.37 ± 77%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.__ext4_new_inode.ext4_create
     12.84 ± 68%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.add_dirent_to_buf.ext4_dx_add_entry
    372.22 ± 69%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.ext4_delete_entry.__ext4_unlink
     13.51 ± 43%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.ext4_orphan_add.__ext4_unlink
    367.37 ± 31%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty
    439.50 ±136%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.__ext4_new_inode.ext4_create
    123.74 ± 13%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
    165.27 ± 71%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_evict_inode.evict
    257.91 ± 12%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc
    266.36 ± 22%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.ext4_getblk.ext4_bread
     77.25 ±114%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.ext4_read_inode_bitmap.__ext4_new_inode
    277.65 ± 66%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.ext4_read_inode_bitmap.ext4_free_inode
    339.27 ±131%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc
     12.21 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
    183.13 ± 28%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.block_invalidatepage.truncate_cleanup_page.truncate_inode_pages_range
      5.61 ± 47%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
    265.14 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.ext4_da_map_blocks.constprop
     10.53 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_read.rmap_walk_anon.remove_migration_ptes
    262.85 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.ext4_buffered_write_iter.new_sync_write
     10.13 ± 74%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.generic_file_write_iter.new_sync_write
    210.89 ± 83%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.vfs_unlink.do_unlinkat
     30.01 ± 51%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
    143.03 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
    307.59 ± 38%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.fscrypt_file_open.ext4_file_open
    155.05 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
    210.47 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
    231.74 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
    234.45 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode
    178.71 ± 38%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
    196.79 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      2.52 ± 66%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.khugepaged.kthread.ret_from_fork
     14.36 ± 28%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__alloc_file.alloc_empty_file
    212.33 ± 70%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__d_alloc.d_alloc
    211.77 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers
    105.94 ±122%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.ext4_alloc_inode.alloc_inode
    266.06 ±131%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_flags.do_sys_openat2
    292.24 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
    296.48 ±133%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
     15.99 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.migrate_pages.migrate_misplaced_page.do_numa_page
    344.60 ± 72%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mnt_want_write.path_openat.do_filp_open
      9.27 ± 66%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_poll.do_sys_poll
    207.56 ± 10%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
     14.98 ± 32%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.grab_cache_page_write_begin.simple_write_begin
     13.78 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
    127.70 ± 30%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
    127.95 ± 64%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.try_to_migrate.migrate_pages
    425.55 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
     13.82 ± 34%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
    211.48 ± 37%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict
    269.34 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
      7.84 ±  5%     -99.5%       0.04 ± 54%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    258.74 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
    213.96 ± 74%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
    146.96 ± 39%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_migrate
     35.98 ± 95%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
     12.67 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
    125.75 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
    154.14 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
     86.69 ± 45%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
    318.30 ±  6%     -99.7%       0.90 ± 73%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     15.12 ± 53%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
    234.15 ± 61%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      1.91 ± 60%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.usleep_range.ipmi_thread.kthread
     60.64 ±  2%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__fdget_pos
    337.57 ± 92%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.ext4_orphan_add
     75.43 ± 81%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.ext4_orphan_del
      0.76 ± 70%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
    479.56          -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      3.38 ± 76%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      4.38           -81.1%       0.83 ±141%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.02 ± 13%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.10 ± 71%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.stop_two_cpus.migrate_swap
    628.85 ±  6%     -99.8%       1.37 ± 88%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.94 ± 14%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
     91.71 ± 80%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
    529.02 ±  4%     -99.9%       0.51 ± 46%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      1001          -100.0%       0.00        perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      3.72 ± 16%     -73.9%       0.97 ±141%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1000          -100.0%       0.00        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
     10000          -100.0%       1.52 ± 56%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      7020 ± 60%    -100.0%       0.61 ±  5%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    841.98 ±135%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      2560 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1337 ± 69%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     23.85 ± 31%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      2639 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
    713.05 ±138%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      3.98          -100.0%       0.00        perf-sched.wait_time.max.ms.ipmi_thread.kthread.ret_from_fork
      4975          -100.0%       0.00        perf-sched.wait_time.max.ms.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      0.27 ± 17%    -100.0%       0.00        perf-sched.wait_time.max.ms.kjournald2.kthread.ret_from_fork
      4287 ± 95%    -100.0%       1.47 ±  6%  perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      1312 ±138%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.shmem_alloc_page
      2427 ±  2%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin
     27.92 ± 40%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__do_fault.do_fault.__handle_mm_fault
     16.00 ± 31%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.__ext4_new_inode.ext4_create
      2644 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty
    761.73 ±139%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_free_inode.ext4_evict_inode
    755.84 ±135%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_handle_dirty_dirblock.add_dirent_to_buf
      1493 ± 70%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_handle_dirty_dirblock.ext4_delete_entry
     13.33 ± 27%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_orphan_add.__ext4_unlink
      2079 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.__ext4_new_inode.ext4_create
     17.53 ± 70%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.add_dirent_to_buf.ext4_dx_add_entry
      1601 ± 69%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.ext4_delete_entry.__ext4_unlink
     15.67 ± 23%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.ext4_orphan_add.__ext4_unlink
      2300 ±  2%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty
    860.88 ±137%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.__ext4_new_inode.ext4_create
      2552 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      1455 ± 69%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_evict_inode.evict
      2560 ±  2%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc
      2423 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.ext4_getblk.ext4_bread
    769.55 ±137%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.ext4_read_inode_bitmap.__ext4_new_inode
      1324 ± 69%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.ext4_read_inode_bitmap.ext4_free_inode
    661.53 ±135%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc
     31.53 ± 57%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
      2569          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.block_invalidatepage.truncate_cleanup_page.truncate_inode_pages_range
     19.34 ± 24%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2503 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.ext4_da_map_blocks.constprop
     26.65 ± 16%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read.rmap_walk_anon.remove_migration_ptes
      2576 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.ext4_buffered_write_iter.new_sync_write
     10.13 ± 74%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.generic_file_write_iter.new_sync_write
      1423 ± 69%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.vfs_unlink.do_unlinkat
      1395 ± 68%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      2412 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.do_unlinkat.do_syscall_64
      2313 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.fscrypt_file_open.ext4_file_open
      2483 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
      2686 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      2666 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_da_write_begin
      2643 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode
      4113 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      2677 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      2.54 ± 67%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.khugepaged.kthread.ret_from_fork
     30.70 ± 40%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__alloc_file.alloc_empty_file
      1470 ± 70%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__d_alloc.d_alloc
      2500 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers
    774.86 ±133%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.ext4_alloc_inode.alloc_inode
    769.52 ±136%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_flags.do_sys_openat2
      2560 ±  2%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
    860.95 ±136%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
     15.99 ± 26%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.migrate_pages.migrate_misplaced_page.do_numa_page
      1499 ± 69%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mnt_want_write.path_openat.do_filp_open
     12.77 ± 33%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_poll.do_sys_poll
      2620 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
     21.84 ± 24%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.grab_cache_page_write_begin.simple_write_begin
     18.89 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
      2170 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      1604 ± 69%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.rmap_walk_anon.try_to_migrate.migrate_pages
      2643 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      6.79 ± 77%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
     26.31 ± 45%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      2586 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict
      2578 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
      1024 ±  3%     -99.5%       4.83 ± 81%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      2509 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      1314 ± 69%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      2365 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_migrate
    907.69 ±134%    -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
     40.85 ± 24%    -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      2642 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2667 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      2246          -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
    499.94           -99.4%       2.80 ± 77%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     57.24 ± 38%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      1000          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      4.01          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.usleep_range.ipmi_thread.kthread
      2411 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.__fdget_pos
      1407 ± 70%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.ext4_orphan_add
      2178 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.ext4_orphan_del
      0.76 ± 70%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
    504.99          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      3.38 ± 76%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
     39.08 ± 98%     -95.8%       1.66 ±141%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.02 ± 23%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      2.67 ±131%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.stop_two_cpus.migrate_swap
      8992 ±  4%     -99.9%       7.46 ± 71%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
     12.73 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      1982 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
      5086           -99.9%       4.83 ± 89%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.14.0-rc2-00021-gcc883236b792"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.14.0-rc2 Kernel Configuration
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
# CONFIG_XEN is not set
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
# CONFIG_HYPERV_STORAGE is not set
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
# CONFIG_NET_VENDOR_3COM is not set
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
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
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
# CONFIG_DRM_I915_GVT is not set
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
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
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

--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='aim7'
	export testcase='aim7'
	export category='benchmark'
	export job_origin='aim7-fs-raid.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2sp9'
	export tbox_group='lkp-csl-2sp9'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='613de2249bb05032a59e198b'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2sp9/aim7-performance-4BRD_12G-ext4-3000-RAID0-disk_rw-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-cc883236b79297f6266ca6f4e7f24f-20210912-12965-nypnts-3.yaml'
	export id='cfd40aa4930ad67f73869e34e03a12e9905c0968'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=2
	export nr_cpu=88
	export memory='128G'
	export nr_hdd_partitions=4
	export nr_ssd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC13Q1RD-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part1'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part2'
	export brand='Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz'
	export commit='cc883236b79297f6266ca6f4e7f24f3fd3c736c1'
	export ucode='0x5003006'
	export need_kconfig_hw='{"I40E"=>"y"}
SATA_AHCI'
	export need_kconfig='{"BLK_DEV_RAM"=>"m"}
{"BLK_DEV"=>"y"}
{"BLOCK"=>"y"}
MD_RAID0
EXT4_FS'
	export enqueue_time='2021-09-12 19:19:00 +0800'
	export _id='613de2249bb05032a59e198b'
	export _rt='/result/aim7/performance-4BRD_12G-ext4-3000-RAID0-disk_rw-ucode=0x5003006/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/cc883236b79297f6266ca6f4e7f24f3fd3c736c1'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='99070d47efb65fa0b9848f59b93359a90b7a330b'
	export base_commit='7d2a07b769330c34b4deabeed939325c77a7ec2f'
	export branch='linux-next/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/aim7/performance-4BRD_12G-ext4-3000-RAID0-disk_rw-ucode=0x5003006/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/cc883236b79297f6266ca6f4e7f24f3fd3c736c1/3'
	export scheduler_version='/lkp/lkp/.src-20210910-192256'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2sp9/aim7-performance-4BRD_12G-ext4-3000-RAID0-disk_rw-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-cc883236b79297f6266ca6f4e7f24f-20210912-12965-nypnts-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-next/master
commit=cc883236b79297f6266ca6f4e7f24f3fd3c736c1
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/cc883236b79297f6266ca6f4e7f24f3fd3c736c1/vmlinuz-5.14.0-rc2-00021-gcc883236b792
max_uptime=2100
RESULT_ROOT=/result/aim7/performance-4BRD_12G-ext4-3000-RAID0-disk_rw-ucode=0x5003006/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/cc883236b79297f6266ca6f4e7f24f3fd3c736c1/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/cc883236b79297f6266ca6f4e7f24f3fd3c736c1/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20210906.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-ac08b1c68d1b-1_20210908.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/md_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/aim7-x86_64-1-1_20210907.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.14.0-wt-ath-14536-g99070d47efb6'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/cc883236b79297f6266ca6f4e7f24f3fd3c736c1/vmlinuz-5.14.0-rc2-00021-gcc883236b792'
	export dequeue_time='2021-09-12 19:19:54 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2sp9/aim7-performance-4BRD_12G-ext4-3000-RAID0-disk_rw-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-cc883236b79297f6266ca6f4e7f24f-20210912-12965-nypnts-3.cgz'

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

	run_setup nr_brd=4 ramdisk_size=12884901888 $LKP_SRC/setup/disk

	run_setup raid_level='raid0' $LKP_SRC/setup/md

	run_setup fs='ext4' $LKP_SRC/setup/fs

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

	run_test test='disk_rw' load=3000 $LKP_SRC/tests/wrapper aim7
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env delay=15 $LKP_SRC/stats/wrapper perf-profile
	env test='disk_rw' load=3000 $LKP_SRC/stats/wrapper aim7
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

--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/aim7-fs-raid.yaml:
suite: aim7
testcase: aim7
category: benchmark
perf-profile:
  delay: 15
disk: 4BRD_12G
md: RAID0
fs: ext4
aim7:
  test: disk_rw
  load: 3000
job_origin: aim7-fs-raid.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2sp9
tbox_group: lkp-csl-2sp9
kconfig: x86_64-rhel-8.3
submit_id: 613d9f359bb0505ff3665f45
job_file: "/lkp/jobs/scheduled/lkp-csl-2sp9/aim7-performance-4BRD_12G-ext4-3000-RAID0-disk_rw-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-cc883236b79297f6266ca6f4e7f24f-20210912-90099-18z5x3h-0.yaml"
id: 76de2db9178296a28043175823c23cc95787886f
queuer_version: "/lkp-src"
:#! hosts/lkp-csl-2sp9:
model: Cascade Lake
nr_node: 2
nr_cpu: 88
memory: 128G
nr_hdd_partitions: 4
nr_ssd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC13Q1RD-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part1"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part2"
brand: Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz
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
commit: cc883236b79297f6266ca6f4e7f24f3fd3c736c1
:#! include/testbox/lkp-csl-2sp9:
ucode: '0x5003006'
need_kconfig_hw:
- I40E: y
- SATA_AHCI
:#! include/disk/nr_brd:
need_kconfig:
- BLK_DEV_RAM: m
- BLK_DEV: y
- BLOCK: y
- MD_RAID0
- EXT4_FS
:#! include/md/raid_level:
:#! include/fs/OTHERS:
enqueue_time: 2021-09-12 14:33:25.513977609 +08:00
_id: 613d9f359bb0505ff3665f45
_rt: "/result/aim7/performance-4BRD_12G-ext4-3000-RAID0-disk_rw-ucode=0x5003006/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/cc883236b79297f6266ca6f4e7f24f3fd3c736c1"
:#! schedule options:
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 99070d47efb65fa0b9848f59b93359a90b7a330b
base_commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
branch: linux-devel/devel-hourly-20210911-180134
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/aim7/performance-4BRD_12G-ext4-3000-RAID0-disk_rw-ucode=0x5003006/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/cc883236b79297f6266ca6f4e7f24f3fd3c736c1/0"
scheduler_version: "/lkp/lkp/.src-20210910-192256"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2sp9/aim7-performance-4BRD_12G-ext4-3000-RAID0-disk_rw-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-cc883236b79297f6266ca6f4e7f24f-20210912-90099-18z5x3h-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210911-180134
- commit=cc883236b79297f6266ca6f4e7f24f3fd3c736c1
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/cc883236b79297f6266ca6f4e7f24f3fd3c736c1/vmlinuz-5.14.0-rc2-00021-gcc883236b792
- max_uptime=2100
- RESULT_ROOT=/result/aim7/performance-4BRD_12G-ext4-3000-RAID0-disk_rw-ucode=0x5003006/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/cc883236b79297f6266ca6f4e7f24f3fd3c736c1/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/cc883236b79297f6266ca6f4e7f24f3fd3c736c1/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20210906.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-ac08b1c68d1b-1_20210908.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/md_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/aim7-x86_64-1-1_20210907.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /lkp/lkp/.src-20210910-192256/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.14.0-11153-g15be4837a42f
repeat_to: 3
:#! user overrides:
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/cc883236b79297f6266ca6f4e7f24f3fd3c736c1/vmlinuz-5.14.0-rc2-00021-gcc883236b792"
dequeue_time: 2021-09-12 15:04:12.726431723 +08:00
job_state: finished
loadavg: 1533.84 760.60 289.59 1/836 12569
start_time: '1631430319'
end_time: '1631430438'
version: "/lkp/lkp/.src-20210910-192329:1703be68:7a67a768b"

--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "modprobe" "-r" "brd"
 "modprobe" "brd" "rd_nr=4" "rd_size=12582912"
 "dmsetup" "remove_all"
 "wipefs" "-a" "--force" "/dev/ram0"
 "wipefs" "-a" "--force" "/dev/ram1"
 "wipefs" "-a" "--force" "/dev/ram2"
 "wipefs" "-a" "--force" "/dev/ram3"
 "mdadm" "-q" "--create" "/dev/md0" "--chunk=256" "--level=raid0" "--raid-devices=4" "--force" "--assume-clean" "/dev/ram0" "/dev/ram1" "/dev/ram2" "/dev/ram3"
wipefs -a --force /dev/md0
mkfs -t ext4 -q -F /dev/md0
mkdir -p /fs/md0
mount -t ext4 /dev/md0 /fs/md0

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
10 disk_rw
EOF
echo "/fs/md0" > config

	(
		echo lkp-csl-2sp9
		echo disk_rw

		echo 1
		echo 3000
		echo 2
		echo 3000
		echo 1
	) | ./multitask -t &

--nOM8ykUjac0mNN89--
