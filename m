Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2BC3E536F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 08:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbhHJGZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 02:25:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:4933 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234937AbhHJGZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:25:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="202023589"
X-IronPort-AV: E=Sophos;i="5.84,309,1620716400"; 
   d="yaml'?scan'208";a="202023589"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 23:24:45 -0700
X-IronPort-AV: E=Sophos;i="5.84,309,1620716400"; 
   d="yaml'?scan'208";a="506017913"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 23:24:40 -0700
Date:   Tue, 10 Aug 2021 14:42:39 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Martijn Coenen <maco@android.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com
Subject: [loop]  2112f5c133: fxmark.hdd_ext4_no_jnl_DWTL_1_directio.works/sec
 -49.6% regression
Message-ID: <20210810064239.GA22537@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Greeting,

FYI, we noticed a -49.6% regression of fxmark.hdd_ext4_no_jnl_DWTL_1_directio.works/sec due to commit:


commit: 2112f5c1330a671fa852051d85cb9eadc05d7eb7 ("loop: Select I/O scheduler 'none' from inside add_disk()")
https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-5.15/block


in testcase: fxmark
on test machine: 272 threads 2 sockets Intel(R) Xeon Phi(TM) CPU 7255 @ 1.10GHz with 112G memory
with following parameters:

	disk: 1HDD
	media: hdd
	test: DWTL
	fstype: ext4_no_jnl
	directio: directio
	cpufreq_governor: performance
	ucode: 0x11




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
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/directio/1HDD/ext4_no_jnl/x86_64-rhel-8.3/hdd/debian-10.4-x86_64-20200603.cgz/lkp-knm02/DWTL/fxmark/0x11

commit: 
  90b7198001 ("blk-mq: Introduce the BLK_MQ_F_NO_SCHED_BY_DEFAULT flag")
  2112f5c133 ("loop: Select I/O scheduler 'none' from inside add_disk()")

90b7198001f23ea3 2112f5c1330a671fa852051d85c 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      4.86 ±  7%     -14.8%       4.14 ±  2%  fxmark.hdd_ext4_no_jnl_DWTL_18_directio.idle_sec
      0.25 ±  9%     -41.3%       0.15 ±  3%  fxmark.hdd_ext4_no_jnl_DWTL_18_directio.irq_sec
      3.46 ±  3%     -31.2%       2.38 ±  3%  fxmark.hdd_ext4_no_jnl_DWTL_18_directio.irq_util
      0.40 ±  6%     -14.7%       0.34        fxmark.hdd_ext4_no_jnl_DWTL_18_directio.real_sec
      0.06 ±  6%     +68.6%       0.10 ± 15%  fxmark.hdd_ext4_no_jnl_DWTL_1_directio.irq_sec
      4.65 ±  5%     -13.7%       4.02 ±  4%  fxmark.hdd_ext4_no_jnl_DWTL_1_directio.irq_util
      1.25 ±  2%     +95.6%       2.45 ± 14%  fxmark.hdd_ext4_no_jnl_DWTL_1_directio.real_sec
      0.87 ±  3%    +100.3%       1.75 ±  9%  fxmark.hdd_ext4_no_jnl_DWTL_1_directio.secs
     72.74           -40.9%      42.98 ± 11%  fxmark.hdd_ext4_no_jnl_DWTL_1_directio.sys_util
      0.27 ±  3%    +371.3%       1.29 ± 20%  fxmark.hdd_ext4_no_jnl_DWTL_1_directio.user_sec
     21.81 ±  2%    +138.9%      52.10 ±  9%  fxmark.hdd_ext4_no_jnl_DWTL_1_directio.user_util
     27378 ±  3%     -49.6%      13786 ± 10%  fxmark.hdd_ext4_no_jnl_DWTL_1_directio.works/sec
      0.06 ±  8%    +105.9%       0.12 ± 18%  fxmark.hdd_ext4_no_jnl_DWTL_2_directio.irq_sec
      4.15 ±  9%     +57.7%       6.54 ±  7%  fxmark.hdd_ext4_no_jnl_DWTL_2_directio.irq_util
      0.68 ±  4%     +32.5%       0.90 ± 20%  fxmark.hdd_ext4_no_jnl_DWTL_2_directio.real_sec
      0.40 ±  4%     +52.8%       0.61 ± 54%  fxmark.hdd_ext4_no_jnl_DWTL_2_directio.secs
      0.82 ±  4%     +24.1%       1.02 ± 17%  fxmark.hdd_ext4_no_jnl_DWTL_2_directio.sys_sec
      0.29           +58.0%       0.46 ± 61%  fxmark.hdd_ext4_no_jnl_DWTL_2_directio.user_sec
      0.38 ± 11%     +67.0%       0.63 ± 21%  fxmark.hdd_ext4_no_jnl_DWTL_4_directio.idle_sec
     18.84 ±  9%     +61.4%      30.40 ± 17%  fxmark.hdd_ext4_no_jnl_DWTL_4_directio.idle_util
      3.50 ±  2%     +30.6%       4.57 ± 17%  fxmark.hdd_ext4_no_jnl_DWTL_4_directio.irq_util
      0.83           +11.6%       0.93 ±  4%  fxmark.hdd_ext4_no_jnl_DWTL_4_directio.sys_sec
      0.72           -44.9%       0.40 ± 14%  fxmark.hdd_ext4_no_jnl_DWTL_4_directio.user_sec
     35.80 ±  3%     -46.4%      19.18 ± 16%  fxmark.hdd_ext4_no_jnl_DWTL_4_directio.user_util
    202.25            -5.9%     190.41        fxmark.time.elapsed_time
    202.25            -5.9%     190.41        fxmark.time.elapsed_time.max
     24.67 ±  3%     -31.1%      17.00        fxmark.time.percent_of_cpu_this_job_got
     44.77 ±  2%     -40.1%      26.82        fxmark.time.system_time
     46090 ±  2%      +7.6%      49608        fxmark.time.voluntary_context_switches
      1301 ±  2%     +68.1%       2187 ± 46%  meminfo.Active(anon)
      1297 ±  2%     +67.3%       2170 ± 47%  numa-meminfo.node0.Active(anon)
    140.09            -2.2%     137.01        boot-time.boot
     35285            -2.5%      34396        boot-time.idle
    324.33 ±  3%     +65.5%     536.83 ± 47%  numa-vmstat.node0.nr_active_anon
    324.33 ±  3%     +65.5%     536.83 ± 47%  numa-vmstat.node0.nr_zone_active_anon
     18298 ±  8%     -11.7%      16165 ±  2%  softirqs.CPU1.SCHED
     62712           -11.9%      55253 ±  4%  softirqs.TIMER
     43.71            +8.1%      47.24        iostat.cpu.idle
     18.54 ±  4%     -39.9%      11.14 ±  3%  iostat.cpu.system
      4.05 ±  4%     +49.1%       6.04 ±  5%  iostat.cpu.user
      0.56 ±  7%      +0.2        0.81 ±  4%  mpstat.cpu.all.soft%
     18.13 ±  3%      -7.7       10.46 ±  2%  mpstat.cpu.all.sys%
      4.31 ±  4%      +2.1        6.37 ±  5%  mpstat.cpu.all.usr%
    245.33 ± 10%     +43.3%     351.50 ± 41%  vmstat.io.bi
     13969 ±  2%      +7.7%      15048 ±  2%  vmstat.io.bo
      5.50 ± 13%     -51.5%       2.67 ± 27%  vmstat.procs.r
      5398            +7.7%       5815        vmstat.system.cs
    176232 ± 11%      +8.6%     191382        vmstat.system.in
    466.17 ±  2%     -32.8%     313.33 ±  2%  slabinfo.ext4_allocation_context.active_objs
    637.67 ±  2%     -24.7%     480.33        slabinfo.ext4_allocation_context.num_objs
      1106 ±  8%     -26.2%     816.17 ±  7%  slabinfo.ext4_extent_status.active_objs
      1428 ±  5%     -19.8%       1146 ±  5%  slabinfo.ext4_extent_status.num_objs
    673.50 ±  2%     -50.0%     336.67 ± 10%  slabinfo.mbcache.active_objs
    887.50 ±  2%     -41.2%     521.83 ±  4%  slabinfo.mbcache.num_objs
      7695           +22.8%       9449 ± 14%  slabinfo.proc_inode_cache.active_objs
      8031           +21.2%       9736 ± 13%  slabinfo.proc_inode_cache.num_objs
    318.83           +70.8%     544.50 ± 47%  proc-vmstat.nr_active_anon
     28780            +5.1%      30244        proc-vmstat.nr_inactive_file
     11263            -4.7%      10733        proc-vmstat.nr_mapped
     35545            +2.2%      36324        proc-vmstat.nr_slab_reclaimable
     69562            +2.3%      71136        proc-vmstat.nr_slab_unreclaimable
    318.83           +70.8%     544.50 ± 47%  proc-vmstat.nr_zone_active_anon
     28780            +5.1%      30244        proc-vmstat.nr_zone_inactive_file
   1680638            -1.2%    1660900        proc-vmstat.numa_hit
   1680859            -1.2%    1660903        proc-vmstat.numa_local
   1694164            -1.2%    1674369        proc-vmstat.pgalloc_normal
    986109            -5.4%     932819        proc-vmstat.pgfault
   1679614            -1.2%    1659352        proc-vmstat.pgfree
     88729            -3.2%      85929        proc-vmstat.pgreuse
      2.52            +4.9%       2.65 ±  2%  perf-stat.i.MPKI
  70070899 ±  6%      +8.0%   75671172        perf-stat.i.branch-instructions
      0.68 ±  3%      +0.0        0.73        perf-stat.i.branch-miss-rate%
      1.39 ±  3%      +0.1        1.48        perf-stat.i.cache-miss-rate%
   1705485 ±  8%      +8.3%    1847096        perf-stat.i.cache-misses
  10121014 ±  5%      +7.6%   10890953        perf-stat.i.cache-references
      4037           +10.1%       4446        perf-stat.i.context-switches
      0.45 ±  6%      +7.2%       0.48        perf-stat.i.cpi
     85941            +3.3%      88775        perf-stat.i.cpu-clock
 1.778e+09 ± 11%      +9.5%  1.948e+09        perf-stat.i.cpu-cycles
    176.45           -26.0%     130.60        perf-stat.i.cpu-migrations
     88.54 ±  4%      +6.7%      94.50        perf-stat.i.cycles-between-cache-misses
      0.12 ±  7%      +0.0        0.13 ±  2%  perf-stat.i.iTLB-load-miss-rate%
   4737699 ± 12%     +10.7%    5242941        perf-stat.i.iTLB-load-misses
 3.377e+08 ±  6%      +8.0%  3.646e+08        perf-stat.i.iTLB-loads
  3.38e+08 ±  6%      +8.0%  3.651e+08        perf-stat.i.instructions
      0.01 ± 11%      +9.6%       0.01        perf-stat.i.metric.GHz
     38.70 ±  5%      +8.3%      41.89        perf-stat.i.metric.K/sec
      1.49 ±  6%      +8.0%       1.61        perf-stat.i.metric.M/sec
     85941            +3.3%      88775        perf-stat.i.task-clock
  69731811 ±  6%      +8.9%   75910537        perf-stat.ps.branch-instructions
   5670583 ±  9%     +10.3%    6252936        perf-stat.ps.branch-misses
   1699265 ±  7%      +9.2%    1854993 ±  2%  perf-stat.ps.cache-misses
  10086387 ±  5%      +8.5%   10939307        perf-stat.ps.cache-references
      4111            +7.2%       4405        perf-stat.ps.context-switches
     85596            +3.4%      88519        perf-stat.ps.cpu-clock
 1.772e+09 ± 11%     +10.5%  1.957e+09        perf-stat.ps.cpu-cycles
    179.07           -27.5%     129.88        perf-stat.ps.cpu-migrations
   4720160 ± 12%     +11.6%    5265696        perf-stat.ps.iTLB-load-misses
 3.361e+08 ±  6%      +8.8%  3.658e+08        perf-stat.ps.iTLB-loads
 3.364e+08 ±  6%      +8.9%  3.663e+08        perf-stat.ps.instructions
     85596            +3.4%      88519        perf-stat.ps.task-clock
      8494 ± 11%     -38.5%       5226 ± 20%  interrupts.CPU0.CAL:Function_call_interrupts
     13520 ± 11%     -41.6%       7891 ±  8%  interrupts.CPU1.CAL:Function_call_interrupts
      3424 ± 35%     -49.5%       1730 ± 31%  interrupts.CPU10.CAL:Function_call_interrupts
      1616 ± 38%    -100.0%       0.00        interrupts.CPU10.NMI:Non-maskable_interrupts
      1616 ± 38%    -100.0%       0.00        interrupts.CPU10.PMI:Performance_monitoring_interrupts
      1239 ± 26%    -100.0%       0.00        interrupts.CPU11.NMI:Non-maskable_interrupts
      1239 ± 26%    -100.0%       0.00        interrupts.CPU11.PMI:Performance_monitoring_interrupts
      3649 ± 22%     -48.6%       1876 ± 34%  interrupts.CPU12.CAL:Function_call_interrupts
      1639 ± 40%    -100.0%       0.00        interrupts.CPU12.NMI:Non-maskable_interrupts
      1639 ± 40%    -100.0%       0.00        interrupts.CPU12.PMI:Performance_monitoring_interrupts
      1479 ± 44%    -100.0%       0.00        interrupts.CPU13.NMI:Non-maskable_interrupts
      1479 ± 44%    -100.0%       0.00        interrupts.CPU13.PMI:Performance_monitoring_interrupts
      1680 ± 40%    -100.0%       0.00        interrupts.CPU14.NMI:Non-maskable_interrupts
      1680 ± 40%    -100.0%       0.00        interrupts.CPU14.PMI:Performance_monitoring_interrupts
      4349 ± 28%     -54.0%       2002 ± 31%  interrupts.CPU15.CAL:Function_call_interrupts
      1351 ± 52%    -100.0%       0.00        interrupts.CPU15.NMI:Non-maskable_interrupts
      1351 ± 52%    -100.0%       0.00        interrupts.CPU15.PMI:Performance_monitoring_interrupts
      3473 ± 23%     -47.1%       1839 ± 25%  interrupts.CPU16.CAL:Function_call_interrupts
      1476 ± 24%    -100.0%       0.00        interrupts.CPU16.NMI:Non-maskable_interrupts
      1476 ± 24%    -100.0%       0.00        interrupts.CPU16.PMI:Performance_monitoring_interrupts
      3924 ± 31%     -50.8%       1928 ± 31%  interrupts.CPU17.CAL:Function_call_interrupts
      1570 ± 51%    -100.0%       0.00        interrupts.CPU17.NMI:Non-maskable_interrupts
      1570 ± 51%    -100.0%       0.00        interrupts.CPU17.PMI:Performance_monitoring_interrupts
     10071 ± 12%     -50.8%       4952 ± 26%  interrupts.CPU2.CAL:Function_call_interrupts
      2300 ± 32%     -95.1%     112.83 ±223%  interrupts.CPU2.NMI:Non-maskable_interrupts
      2300 ± 32%     -95.1%     112.83 ±223%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
      1106 ± 41%     -57.3%     472.50 ± 40%  interrupts.CPU2.RES:Rescheduling_interrupts
      2871 ± 24%     -40.0%       1724 ± 30%  interrupts.CPU24.CAL:Function_call_interrupts
      8191 ± 11%     -43.2%       4651 ± 20%  interrupts.CPU3.CAL:Function_call_interrupts
      2376 ± 30%     -95.8%     100.33 ±223%  interrupts.CPU3.NMI:Non-maskable_interrupts
      2376 ± 30%     -95.8%     100.33 ±223%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    774.33 ± 12%     -25.0%     580.67 ± 18%  interrupts.CPU3.RES:Rescheduling_interrupts
      1494 ± 48%    -100.0%       0.00        interrupts.CPU4.NMI:Non-maskable_interrupts
      1494 ± 48%    -100.0%       0.00        interrupts.CPU4.PMI:Performance_monitoring_interrupts
     79.50 ± 33%     -74.0%      20.67 ± 32%  interrupts.CPU4.RES:Rescheduling_interrupts
      3652 ± 25%     -44.4%       2030 ± 25%  interrupts.CPU5.CAL:Function_call_interrupts
      1404 ± 28%    -100.0%       0.00        interrupts.CPU5.NMI:Non-maskable_interrupts
      1404 ± 28%    -100.0%       0.00        interrupts.CPU5.PMI:Performance_monitoring_interrupts
      3481 ± 24%     -45.6%       1894 ± 26%  interrupts.CPU6.CAL:Function_call_interrupts
      1655 ± 39%    -100.0%       0.00        interrupts.CPU6.NMI:Non-maskable_interrupts
      1655 ± 39%    -100.0%       0.00        interrupts.CPU6.PMI:Performance_monitoring_interrupts
    113.17 ± 74%     -82.3%      20.00 ± 35%  interrupts.CPU6.RES:Rescheduling_interrupts
      1670 ± 39%     -99.9%       1.17 ±223%  interrupts.CPU7.NMI:Non-maskable_interrupts
      1670 ± 39%     -99.9%       1.17 ±223%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
     38787 ± 11%     +14.2%      44280 ±  2%  interrupts.CPU72.LOC:Local_timer_interrupts
      1551 ± 56%    -100.0%       0.00        interrupts.CPU8.NMI:Non-maskable_interrupts
      1551 ± 56%    -100.0%       0.00        interrupts.CPU8.PMI:Performance_monitoring_interrupts
      3462 ± 22%     -48.3%       1790 ± 29%  interrupts.CPU9.CAL:Function_call_interrupts
      1528 ± 49%    -100.0%       0.00        interrupts.CPU9.NMI:Non-maskable_interrupts
      1528 ± 49%    -100.0%       0.00        interrupts.CPU9.PMI:Performance_monitoring_interrupts
     31739 ± 16%     -86.0%       4442 ± 15%  interrupts.NMI:Non-maskable_interrupts
     31739 ± 16%     -86.0%       4442 ± 15%  interrupts.PMI:Performance_monitoring_interrupts
      1.52 ± 55%    +634.6%      11.16 ± 66%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.31 ± 44%     -80.0%       0.06 ±137%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.01 ± 40%    +698.8%       0.11 ± 51%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.06 ± 15%     -90.8%       0.01 ±178%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.04 ± 11%    +150.0%       0.09 ± 52%  perf-sched.sch_delay.avg.ms.io_schedule.put_and_wait_on_page_locked.filemap_get_pages.filemap_read
      0.21 ± 65%    +236.3%       0.69 ± 55%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.wp_page_copy
      0.00 ±223%   +1768.8%       0.05 ±125%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.page_cache_ra_unbounded.filemap_get_pages
      0.03 ± 35%    +170.9%       0.08 ± 53%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__ext4_journal_get_write_access.ext4_ext_insert_extent.ext4_ext_map_blocks
      0.05 ± 76%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.__ext4_sb_bread_gfp.ext4_fill_super
      0.10 ±106%    +240.5%       0.36 ± 71%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.ext4_handle_inode_extension.ext4_dio_write_iter
      0.41 ±  7%     -87.8%       0.05 ± 21%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.02 ± 42%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_read_bh.__ext4_sb_bread_gfp.ext4_fill_super
      0.05 ± 43%     -92.0%       0.00 ±223%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_read_bh.ext4_read_inode_bitmap.__ext4_new_inode
      0.03 ± 18%     +85.4%       0.06 ± 29%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mempool_alloc.bio_alloc_bioset.iomap_dio_bio_actor
      1.27 ± 57%    +280.4%       4.82 ± 42%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.02 ± 14%    +102.4%       0.04 ± 17%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.submit_bio_checks.submit_bio_noacct.iomap_dio_submit_bio
      0.02 ± 55%   +1389.1%       0.34 ±187%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.17 ± 76%    +416.5%       0.87 ± 32%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.01 ± 40%    +794.5%       0.11 ± 73%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      0.23 ± 22%     -65.4%       0.08 ± 25%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.25 ± 55%    +193.9%       0.73 ± 44%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.13 ± 83%     -79.1%       0.03 ± 32%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io_timeout.submit_bio_wait
      0.30 ± 10%     -59.6%       0.12 ± 18%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.05 ± 18%     -48.1%       0.03 ± 70%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion.__flush_work.sync_rcu_exp_select_cpus
      0.03 ± 11%    +455.4%       0.16 ± 69%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion.__synchronize_srcu.part.0
      0.02 ± 15%     -73.8%       0.01 ±141%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion.kthread_stop.destroy_workqueue
      0.03 ± 17%     -75.8%       0.01 ±142%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
      0.16 ±  4%     -53.3%       0.07 ±  8%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.31 ± 59%    +175.0%       0.85 ± 45%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      0.22 ±  4%     -76.2%       0.05 ±  4%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      3.69 ± 52%    +656.7%      27.91 ± 48%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      1.60 ± 90%   +1184.8%      20.60 ± 84%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      3.49 ± 22%     -95.1%       0.17 ±197%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.20 ± 55%  +13022.6%      26.40 ±105%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.07 ± 30%    +117.4%       0.16 ± 73%  perf-sched.sch_delay.max.ms.jbd2_log_wait_commit.ext4_sync_file.loop_process_work.process_one_work
      1.51 ± 77%    +400.7%       7.56 ± 41%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.wp_page_copy
      0.01 ±223%   +6246.9%       0.34 ±112%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.page_cache_ra_unbounded.filemap_get_pages
      0.07 ± 98%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.__ext4_sb_bread_gfp.ext4_fill_super
      0.51 ± 33%    +390.0%       2.52 ± 62%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.ext4_read_block_bitmap_nowait.ext4_read_block_bitmap
      0.02 ±109%   +3500.0%       0.76 ±125%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_task_alloc.copy_process
      1.57 ± 54%    +489.0%       9.25 ± 35%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.copy_strings.isra.0
      4.31 ±123%    +390.3%      21.14 ± 51%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.43 ± 97%    +489.0%       2.53 ± 81%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.ext4_handle_inode_extension.ext4_dio_write_iter
      1.08 ±154%    +579.7%       7.37 ± 40%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      2.11 ±145%    +520.9%      13.10 ± 89%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_openat
      0.23 ± 30%     -77.7%       0.05 ±118%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_mb_regular_allocator.ext4_mb_new_blocks.ext4_ext_map_blocks
      0.02 ± 15%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_read_bh.__ext4_sb_bread_gfp.ext4_fill_super
      0.18 ±192%   +1446.4%       2.78 ±106%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__alloc_file.alloc_empty_file
      0.66 ±219%    +437.2%       3.57 ±101%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region
      0.62 ± 56%    +298.4%       2.49 ± 62%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mempool_alloc.bio_alloc_bioset.iomap_dio_bio_actor
      0.40 ±133%   +2056.0%       8.60 ± 58%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
      0.01 ±223%   +2655.3%       0.22 ±171%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.submit_bio_checks.submit_bio_noacct.ext4_io_submit
      0.43 ±138%   +1118.9%       5.20 ± 48%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.unmap_vmas.exit_mmap.mmput
      1.34 ± 67%    +955.4%      14.18 ± 56%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.08 ±136%   +8653.5%       7.19 ± 55%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      0.04 ± 14%     -82.9%       0.01 ±141%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      1.92 ± 72%     -90.8%       0.18 ± 58%  perf-sched.sch_delay.max.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io_timeout.submit_bio_wait
      0.05 ± 17%     -47.8%       0.03 ± 70%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion.__flush_work.sync_rcu_exp_select_cpus
      0.03 ± 21%    +765.9%       0.30 ± 74%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion.__synchronize_srcu.part.0
      0.02 ± 15%     -73.2%       0.01 ±141%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion.kthread_stop.destroy_workqueue
      0.05 ± 22%     -86.1%       0.01 ±142%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion_killable.__kthread_create_on_node.kthread_create_on_node
      0.14 ±  4%     -48.1%       0.07 ± 11%  perf-sched.total_sch_delay.average.ms
     24.72 ±  6%     -73.3%       6.61 ± 10%  perf-sched.total_wait_and_delay.average.ms
     44689 ±  4%     +92.5%      86019 ± 13%  perf-sched.total_wait_and_delay.count.ms
     24.58 ±  6%     -73.4%       6.53 ± 10%  perf-sched.total_wait_time.average.ms
    754.46 ±  9%     -51.8%     363.67 ± 16%  perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    612.74 ± 17%     -38.6%     376.52 ± 43%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    253.26 ±  8%     -27.9%     182.65 ± 11%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     40.41 ±  9%     +83.7%      74.23 ±  8%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     11.29 ± 21%     -54.1%       5.18 ± 31%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2253 ± 63%     -78.1%     493.54 ±223%  perf-sched.wait_and_delay.avg.ms.kthreadd.ret_from_fork
    292.41 ± 15%     -93.9%      17.77 ± 80%  perf-sched.wait_and_delay.avg.ms.percpu_rwsem_wait.__percpu_down_read.cpus_read_lock.rebuild_sched_domains
     76.88 ± 40%     -62.7%      28.65 ± 17%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.89 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_handle_inode_extension
    284.05 ± 47%     -98.7%       3.66 ±139%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
    303.25 ± 21%     -62.8%     112.82 ± 39%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.drm_gem_vunmap
     40.29 ± 10%    +735.1%     336.47 ± 25%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    249.10 ± 14%     -33.9%     164.76 ± 17%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      1.22 ± 12%     -74.5%       0.31 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.iomap_dio_rw
      6.27 ±  8%     -30.2%       4.38 ± 18%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     74.37 ± 10%     -96.5%       2.62 ± 17%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
     23.77 ±  7%     -84.7%       3.64 ± 16%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
     33.17 ± 13%     -53.8%      15.33 ± 19%  perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     32.33 ± 12%     -52.6%      15.33 ± 20%  perf-sched.wait_and_delay.count.do_syslog.part.0.kmsg_read.vfs_read
     16.33 ±159%  +19108.2%       3137 ± 32%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    609.83 ± 32%    +678.6%       4748 ± 24%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     78.33 ±  5%     -19.6%      63.00 ± 13%  perf-sched.wait_and_delay.count.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      1005 ± 19%     -52.9%     473.33 ± 40%  perf-sched.wait_and_delay.count.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      2.67 ± 27%     -87.5%       0.33 ±223%  perf-sched.wait_and_delay.count.kthreadd.ret_from_fork
     10.67 ± 33%     -90.6%       1.00 ±100%  perf-sched.wait_and_delay.count.percpu_rwsem_wait.__percpu_down_read.cpus_read_lock.rebuild_sched_domains
      2465 ± 30%     +98.1%       4882 ± 17%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
      0.50 ±223%   +1466.7%       7.83 ± 66%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__kmalloc.security_task_alloc.copy_process
      0.67 ±223%   +2250.0%      15.67 ± 41%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.copy_pte_range.copy_page_range.dup_mmap
    429.50 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_handle_inode_extension
      0.33 ±223%   +2550.0%       8.83 ± 15%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      2.00 ±141%  +86075.0%       1723 ± 98%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.loop_process_work.process_one_work.worker_thread
      4.67 ± 36%    +135.7%      11.00 ± 15%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.drm_gem_vunmap
     19.17 ± 70%   +1964.3%     395.67 ± 11%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.perf_poll.do_sys_poll
      1.17 ±223%   +5385.7%      64.00 ± 15%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
      0.50 ±100%    +566.7%       3.33 ± 37%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
    221.67 ± 16%     -89.8%      22.67 ± 32%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      7.50 ±122%   +1435.6%     115.17 ± 12%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
    315.00 ± 10%     -36.5%     200.00 ± 17%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     16274 ±  5%     +62.0%      26366 ± 18%  perf-sched.wait_and_delay.count.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.iomap_dio_rw
      1600 ±  9%     +32.8%       2124 ± 13%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     28.00 ± 27%     -80.4%       5.50 ± 70%  perf-sched.wait_and_delay.count.schedule_timeout.wait_for_completion.__wait_rcu_gp.synchronize_rcu
      3945 ±  6%    +305.0%      15978 ±  7%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
     12389 ±  4%     +31.1%      16246 ±  8%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      5957 ±  3%     -43.5%       3364 ± 51%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1008          +478.4%       5834 ± 16%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    333.84 ±141%    +213.1%       1045 ±  2%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      5774 ± 60%     -82.9%     987.07 ±223%  perf-sched.wait_and_delay.max.ms.kthreadd.ret_from_fork
    796.54 ± 13%     -97.6%      19.29 ± 74%  perf-sched.wait_and_delay.max.ms.percpu_rwsem_wait.__percpu_down_read.cpus_read_lock.rebuild_sched_domains
      5960 ±  3%     -53.3%       2782 ± 36%  perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
     55.75 ±223%    +647.1%     416.53 ±104%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_task_alloc.copy_process
     18.40 ± 52%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_handle_inode_extension
      3040 ± 44%     -86.5%     409.51 ±104%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
    166.68 ±223%    +500.1%       1000        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
      6154 ±  9%     -30.7%       4266 ± 39%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    671.45 ± 27%     -71.5%     191.60 ± 36%  perf-sched.wait_and_delay.max.ms.schedule_timeout.wait_for_completion.__wait_rcu_gp.synchronize_rcu
      2765 ±  5%     -35.9%       1772 ± 36%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
    754.23 ±  9%     -51.8%     363.30 ± 16%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      7.68 ± 14%     -41.3%       4.50 ± 54%  perf-sched.wait_time.avg.ms.blk_mq_freeze_queue_wait.lo_release.blkdev_put.blkdev_close
    612.42 ± 17%     -38.5%     376.46 ± 43%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    253.17 ±  8%     -27.9%     182.47 ± 11%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     40.21 ±  9%     +84.2%      74.07 ±  7%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     11.21 ± 21%     -54.1%       5.15 ± 31%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2252 ± 63%     -78.1%     493.53 ±223%  perf-sched.wait_time.avg.ms.kthreadd.ret_from_fork
    292.06 ± 15%     -93.5%      18.98 ± 65%  perf-sched.wait_time.avg.ms.percpu_rwsem_wait.__percpu_down_read.cpus_read_lock.rebuild_sched_domains
     76.81 ± 40%     -62.8%      28.59 ± 17%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.02 ±223%   +2140.4%       0.43 ± 41%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__pmd_alloc.__handle_mm_fault
    130.32 ±135%     -98.6%       1.84 ±108%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.shmem_alloc_page
      0.27 ± 91%   +7486.5%      20.55 ±132%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.wp_page_copy
      0.03 ±223%   +1184.5%       0.42 ± 56%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.page_cache_ra_unbounded.filemap_get_pages
      0.08 ±193%    +553.1%       0.54 ± 45%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      0.02 ±223%   +2297.2%       0.42 ± 93%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__anon_vma_prepare.do_fault.__handle_mm_fault
      0.02 ±104%   +5056.0%       1.21 ±101%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_free_blocks.ext4_remove_blocks
      0.31 ± 14%     -22.4%       0.24 ± 14%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_mb_mark_diskspace_used.ext4_mb_new_blocks
      0.51 ± 17%     -33.1%       0.34 ± 22%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc
      0.38 ± 20%     -33.5%       0.25 ± 16%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__getblk_gfp.ext4_read_block_bitmap_nowait.ext4_read_block_bitmap
      0.05 ±168%   +2659.9%       1.30 ±120%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__invalidate_mapping_pages.drop_pagecache_sb.iterate_supers
      0.48 ± 28%     -49.4%       0.24 ± 30%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.ext4_find_extent.ext4_ext_map_blocks
      0.02 ±143%   +3488.2%       0.66 ±167%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.filemap_read.blkdev_read_iter
      0.01 ±146%   +2977.0%       0.45 ±108%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.do_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.02 ±223%   +2993.0%       0.66 ± 77%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.__split_vma
      0.55 ±191%   +3156.2%      17.97 ± 98%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.unlink_anon_vmas.free_pgtables
      0.11 ± 87%  +67368.9%      73.88 ± 80%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.step_into.path_openat
     13.55 ± 81%     -64.5%       4.81 ±127%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_openat
      0.11 ±223%    +891.1%       1.12 ±131%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.walk_component.link_path_walk
      0.05 ±144%    +501.3%       0.31 ± 25%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.begin_new_exec
      0.12 ±172%  +53070.5%      61.86 ±103%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.do_exit
      0.47 ± 10%     -41.4%       0.28 ± 34%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dio_write_iter
      0.47 ±  6%     -30.6%       0.33 ± 19%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_iomap_begin
      0.32 ± 26%     -55.6%       0.14 ± 77%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.ext4_mb_regular_allocator.ext4_mb_new_blocks.ext4_ext_map_blocks
      0.19 ± 72%    +202.1%       0.58 ± 71%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.filemap_read.new_sync_read.vfs_read
    284.05 ± 47%     -98.0%       5.55 ± 74%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.02 ±108%  +7.5e+05%     169.09 ±220%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.dup_mm.copy_process
      0.10 ±131%    +548.8%       0.66 ± 77%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma
      0.00 ±223%   +4311.5%       0.19 ± 49%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mmput.begin_new_exec.load_elf_binary
      0.01 ±223%   +1388.1%       0.15 ±  8%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.__fdget_pos.ksys_write
      0.01 ±223%   +6190.0%       0.52 ± 89%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.__perf_event_read_value.perf_read
    299.44 ± 21%     -63.5%     109.18 ± 40%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.drm_gem_vunmap
      0.07 ±129%  +16966.2%      11.60 ±155%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
      0.07 ± 21%   +6160.4%       4.66 ±200%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.slub_cpu_dead.cpuhp_invoke_callback
      1.07 ±  8%   +1239.0%      14.36 ± 89%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.zone_pcp_update.page_alloc_cpu_dead
      0.02 ±223%   +9766.7%       2.47 ±142%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.shmem_getpage_gfp.shmem_write_begin
      0.16 ±128%    +171.4%       0.43 ± 34%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.remove_vma.__do_munmap.__vm_munmap
      0.89 ± 11%     -77.9%       0.20 ± 42%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.29 ±  8%     -22.1%       0.22 ±  8%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.submit_bio_checks.submit_bio_noacct.iomap_dio_submit_bio
     40.27 ± 10%    +734.7%     336.12 ± 24%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.15 ±  5%     -55.9%       1.83 ± 31%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    248.93 ± 14%     -33.9%     164.46 ± 17%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      1.16 ± 12%     -78.3%       0.25 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.iomap_dio_rw
      5.98 ±  8%     -28.7%       4.26 ± 19%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.44 ± 75%     -92.0%       0.04 ±115%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.__flush_work._cpu_down
     21.62 ± 23%     -66.9%       7.15 ± 85%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.cpuhp_kick_ap.cpuhp_kick_ap_work
      6.61 ± 11%     -29.0%       4.69 ± 20%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.devtmpfs_submit_req.devtmpfs_delete_node
      0.16 ± 16%     -64.1%       0.06 ±141%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.kthread_stop.destroy_workqueue
     74.21 ± 10%     -96.6%       2.55 ± 17%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
     23.55 ±  7%     -84.8%       3.59 ± 16%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      5957 ±  3%     -43.6%       3362 ± 51%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1008          +478.4%       5834 ± 16%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.89 ± 90%   +1187.8%      11.46 ± 43%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown]
    192.98 ±189%    +338.3%     845.79 ± 43%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    489.10 ± 86%    +113.7%       1045 ±  2%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     13.04 ±  6%     -65.5%       4.49 ±109%  perf-sched.wait_time.max.ms.io_schedule.__lock_page.truncate_inode_pages_range.blkdev_flush_mapping
      1.05 ± 30%     -91.2%       0.09 ±148%  perf-sched.wait_time.max.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
      5774 ± 60%     -82.9%     987.06 ±223%  perf-sched.wait_time.max.ms.kthreadd.ret_from_fork
    796.19 ± 13%     -97.5%      20.19 ± 60%  perf-sched.wait_time.max.ms.percpu_rwsem_wait.__percpu_down_read.cpus_read_lock.rebuild_sched_domains
      5960 ±  3%     -53.4%       2779 ± 36%  perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.12 ±135%  +1.4e+05%     167.33 ±223%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__get_free_pages.pgd_alloc
      0.04 ±223%   +1803.9%       0.72 ± 47%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.__pmd_alloc.__handle_mm_fault
      1.31 ± 94%  +28723.2%     376.91 ±119%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.wp_page_copy
      0.06 ±223%   +4565.0%       3.02 ±137%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.page_cache_ra_unbounded.filemap_get_pages
      0.13 ±196%   +1741.6%       2.42 ± 71%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      0.04 ±223%   +3487.7%       1.27 ±115%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__anon_vma_prepare.do_fault.__handle_mm_fault
      0.02 ±104%  +13173.8%       3.12 ± 77%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_handle_dirty_metadata.ext4_free_blocks.ext4_remove_blocks
      0.27 ± 83%     -84.9%       0.04 ±223%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__ext4_mark_inode_dirty.ext4_ext_insert_extent.ext4_ext_map_blocks
      0.15 ±172%   +3234.6%       5.16 ±105%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__invalidate_mapping_pages.drop_pagecache_sb.iterate_supers
      1.57 ±208%  +22486.7%     354.23 ±130%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_prepare_creds.prepare_creds
     57.49 ±215%    +623.7%     416.08 ±104%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_task_alloc.copy_process
      0.58 ±177%   +1283.8%       8.03 ± 38%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.change_p4d_range.change_protection.mprotect_fixup
      0.02 ±143%  +27957.3%       5.14 ±207%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.filemap_read.blkdev_read_iter
      0.02 ±148%  +13329.7%       2.04 ±129%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.do_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.05 ±223%   +1013.5%       0.54 ± 66%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_read_killable.create_elf_tables.isra
      0.37 ± 60%    +231.6%       1.23 ± 59%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.shift_arg_pages
      0.02 ±223%   +7813.3%       1.69 ± 86%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.__split_vma
      8.69 ±146%   +2648.3%     238.94 ±181%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.dup_mmap.dup_mm
      0.63 ±167%  +79960.2%     500.51 ± 99%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.unlink_anon_vmas.free_pgtables
     18.45 ±218%   +1476.9%     290.95 ±122%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      0.14 ±223%    +389.7%       0.71 ± 61%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_brk_flags.load_elf_binary
      0.70 ±113%    +276.2%       2.65 ± 44%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_map
      1.17 ±140%    +207.3%       3.58 ± 52%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
      0.24 ±118%  +2.8e+05%     668.00 ± 70%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.step_into.path_openat
      0.11 ±223%   +1250.7%       1.52 ± 97%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.walk_component.link_path_walk
      0.11 ±176%    +755.4%       0.95 ± 39%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.begin_new_exec
      0.14 ±153%  +3.7e+05%     500.23 ± 99%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.do_exit
      2.60 ± 35%     -62.7%       0.97 ± 69%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dio_write_iter
      0.31 ±142%    +496.3%       1.87 ±116%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_ext_remove_space
     16.02 ± 68%     -74.4%       4.10 ± 74%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_handle_inode_extension
      1.98 ± 19%     -90.2%       0.19 ± 95%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.ext4_mb_regular_allocator.ext4_mb_new_blocks.ext4_ext_map_blocks
      0.29 ± 79%    +529.9%       1.81 ± 79%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.filemap_read.new_sync_read.vfs_read
      3040 ± 44%     -76.9%     702.86 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      9.26 ±164%   +6517.0%     612.75 ± 58%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__alloc_file.alloc_empty_file
      0.24 ±201%    +880.9%       2.33 ±116%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__d_alloc.d_alloc
      0.02 ±108%  +7.6e+05%     172.87 ±214%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.dup_mm.copy_process
      7.98 ±203%   +3034.4%     250.17 ±142%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_flags.do_sys_openat2
      0.44 ±138%    +281.0%       1.67 ± 72%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_flags.user_path_at_empty
      0.27 ±150%   +2339.7%       6.58 ± 80%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma
      0.00 ±223%   +6596.2%       0.29 ± 52%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mmput.begin_new_exec.load_elf_binary
      0.10 ±223%   +1457.8%       1.48 ±148%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mnt_want_write.filename_create.do_mkdirat
      0.01 ±223%   +4871.2%       0.49 ± 60%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.__fdget_pos.ksys_write
      0.01 ±223%  +16114.0%       1.35 ±124%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.__perf_event_read_value.perf_read
      0.22 ±146%  +1.5e+05%     334.67 ±140%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
      2.66 ± 16%    +612.1%      18.93 ± 85%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.zone_pcp_update.page_alloc_cpu_dead
      0.02 ±223%  +1.4e+06%     341.22 ±136%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.shmem_getpage_gfp.shmem_write_begin
      0.24 ±138%    +673.7%       1.89 ± 45%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.remove_vma.__do_munmap.__vm_munmap
    179.86 ±204%    +456.1%       1000        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
      4.57 ± 27%     -68.0%       1.46 ± 47%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.40 ±188%   +2661.7%      11.02 ±159%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      6154 ±  9%     -30.7%       4266 ± 39%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      5.13 ± 85%     -99.0%       0.05 ±144%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.__flush_work._cpu_down
    671.12 ± 27%     -71.5%     191.20 ± 36%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.__wait_rcu_gp.synchronize_rcu
     47.93 ± 29%     -79.9%       9.62 ± 79%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.cpuhp_kick_ap.cpuhp_kick_ap_work
     25.76 ± 56%     -64.0%       9.28 ± 31%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.devtmpfs_submit_req.devtmpfs_delete_node
      2765 ±  6%     -35.9%       1772 ± 36%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
     72.36 ±  5%     -68.1        4.23 ± 10%  perf-profile.calltrace.cycles-pp.blk_mq_sched_insert_requests.blk_mq_flush_plug_list.blk_flush_plug_list.blk_finish_plug.__iomap_dio_rw
     72.38 ±  5%     -68.1        4.32 ±  9%  perf-profile.calltrace.cycles-pp.blk_mq_flush_plug_list.blk_flush_plug_list.blk_finish_plug.__iomap_dio_rw.iomap_dio_rw
     72.39 ±  5%     -68.0        4.36 ±  9%  perf-profile.calltrace.cycles-pp.blk_flush_plug_list.blk_finish_plug.__iomap_dio_rw.iomap_dio_rw.ext4_dio_write_iter
     72.40 ±  5%     -68.0        4.37 ±  9%  perf-profile.calltrace.cycles-pp.blk_finish_plug.__iomap_dio_rw.iomap_dio_rw.ext4_dio_write_iter.new_sync_write
     76.11 ±  5%     -58.2       17.92 ±  6%  perf-profile.calltrace.cycles-pp.iomap_dio_rw.ext4_dio_write_iter.new_sync_write.vfs_write.ksys_write
     76.11 ±  5%     -58.2       17.93 ±  6%  perf-profile.calltrace.cycles-pp.__iomap_dio_rw.iomap_dio_rw.ext4_dio_write_iter.new_sync_write.vfs_write
     76.68 ±  5%     -56.9       19.81 ±  5%  perf-profile.calltrace.cycles-pp.ext4_dio_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     52.61 ±  5%     -52.6        0.00        perf-profile.calltrace.cycles-pp.__blk_mq_delay_run_hw_queue.blk_mq_sched_insert_requests.blk_mq_flush_plug_list.blk_flush_plug_list.blk_finish_plug
     52.60 ±  5%     -52.6        0.00        perf-profile.calltrace.cycles-pp.__blk_mq_run_hw_queue.__blk_mq_delay_run_hw_queue.blk_mq_sched_insert_requests.blk_mq_flush_plug_list.blk_flush_plug_list
     52.60 ±  5%     -52.6        0.00        perf-profile.calltrace.cycles-pp.blk_mq_sched_dispatch_requests.__blk_mq_run_hw_queue.__blk_mq_delay_run_hw_queue.blk_mq_sched_insert_requests.blk_mq_flush_plug_list
     52.59 ±  5%     -52.6        0.00        perf-profile.calltrace.cycles-pp.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.__blk_mq_run_hw_queue.__blk_mq_delay_run_hw_queue.blk_mq_sched_insert_requests
     52.58 ±  5%     -52.6        0.00        perf-profile.calltrace.cycles-pp.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.__blk_mq_run_hw_queue.__blk_mq_delay_run_hw_queue
     51.92 ±  5%     -51.6        0.35 ±100%  perf-profile.calltrace.cycles-pp.dd_dispatch_request.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.__blk_mq_run_hw_queue
     78.17 ±  5%     -50.8       27.37 ±  2%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     44.70 ±  7%     -44.7        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.dd_dispatch_request.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests
     44.67 ±  7%     -44.7        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dd_dispatch_request.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests
     19.69 ±  6%     -19.7        0.00        perf-profile.calltrace.cycles-pp.dd_insert_requests.blk_mq_sched_insert_requests.blk_mq_flush_plug_list.blk_flush_plug_list.blk_finish_plug
     19.59 ±  6%     -19.6        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.dd_insert_requests.blk_mq_sched_insert_requests.blk_mq_flush_plug_list.blk_flush_plug_list
     19.58 ±  6%     -19.6        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dd_insert_requests.blk_mq_sched_insert_requests.blk_mq_flush_plug_list
      7.01 ± 20%      -6.7        0.32 ±100%  perf-profile.calltrace.cycles-pp.dd_queued.dd_dispatch_request.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests
      2.89 ±  8%      -2.4        0.50 ± 73%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.38 ± 16%      -2.0        0.35 ±102%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      3.05 ±  7%      -1.8        1.23 ± 63%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.05 ±  7%      -1.8        1.23 ± 63%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      3.04 ±  8%      -1.8        1.23 ± 63%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.42 ±  9%      -1.2        2.22 ± 33%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      1.59 ±  7%      -1.0        0.56 ± 77%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.54 ±  7%      -1.0        0.55 ± 78%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.6        0.62 ± 11%  perf-profile.calltrace.cycles-pp.proc_pid_status.proc_single_show.seq_read_iter.seq_read.vfs_read
      0.00            +0.6        0.63 ± 12%  perf-profile.calltrace.cycles-pp.proc_single_show.seq_read_iter.seq_read.vfs_read.ksys_read
      0.00            +0.7        0.68 ± 19%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.00            +0.7        0.71 ± 10%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write
      0.00            +0.7        0.73 ± 20%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.20 ±141%      +0.7        0.93 ± 32%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.20 ±141%      +0.7        0.94 ± 33%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.20 ±141%      +0.7        0.94 ± 33%  perf-profile.calltrace.cycles-pp.start_kernel.secondary_startup_64_no_verify
      0.00            +0.7        0.74 ± 17%  perf-profile.calltrace.cycles-pp.__ext4_mark_inode_dirty.ext4_handle_inode_extension.ext4_dio_write_iter.new_sync_write.vfs_write
      0.00            +0.8        0.77 ± 19%  perf-profile.calltrace.cycles-pp.read_counters.process_interval.dispatch_events.cmd_stat.run_builtin
      0.00            +0.8        0.79 ± 18%  perf-profile.calltrace.cycles-pp.process_interval.dispatch_events.cmd_stat.run_builtin.main
      0.00            +0.8        0.79 ± 17%  perf-profile.calltrace.cycles-pp.cmd_stat.run_builtin.main.__libc_start_main
      0.00            +0.8        0.79 ± 17%  perf-profile.calltrace.cycles-pp.dispatch_events.cmd_stat.run_builtin.main.__libc_start_main
      0.00            +0.8        0.79 ± 21%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.smpboot_thread_fn
      0.00            +0.8        0.80 ± 11%  perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00            +0.8        0.80 ± 11%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x64_sys_exit_group
      0.00            +0.8        0.80 ± 18%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.81 ± 18%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.82 ± 25%  perf-profile.calltrace.cycles-pp.xas_find.find_lock_entries.__invalidate_mapping_pages.drop_pagecache_sb.iterate_supers
      0.00            +0.8        0.83 ± 20%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.smpboot_thread_fn.kthread
      0.00            +0.8        0.84 ± 15%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.raise_softirq
      0.00            +0.8        0.85 ± 26%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.8        0.85 ± 26%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.9        0.85 ± 25%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.9        0.85 ± 25%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.9        0.87 ± 14%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.raise_softirq
      0.00            +0.9        0.87 ± 30%  perf-profile.calltrace.cycles-pp.rcu_gp_kthread.kthread.ret_from_fork
      0.00            +0.9        0.88 ± 24%  perf-profile.calltrace.cycles-pp.setlocale
      0.00            +0.9        0.89 ± 16%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.raise_softirq.blk_mq_complete_request_remote
      0.00            +0.9        0.91 ± 35%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.iomap_dio_bio_end_io
      0.00            +0.9        0.92 ± 20%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64
      0.00            +0.9        0.92 ± 11%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.raise_softirq.blk_mq_complete_request_remote
      0.00            +0.9        0.93 ± 16%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.raise_softirq.blk_mq_complete_request_remote.blk_mq_complete_request
      0.00            +0.9        0.95 ± 22%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.0        0.95 ± 33%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.iomap_dio_bio_end_io.blk_update_request
      0.00            +1.0        0.95 ± 41%  perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write.vfs_write
      0.00            +1.0        0.96 ±  9%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      0.00            +1.0        0.96 ± 12%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.raise_softirq.blk_mq_complete_request_remote.blk_mq_complete_request
      0.00            +1.0        0.97 ± 15%  perf-profile.calltrace.cycles-pp.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.do_iter_readv_writev.do_iter_write
      0.00            +1.0        0.97 ±  8%  perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.0        0.97 ± 15%  perf-profile.calltrace.cycles-pp.ext4_handle_inode_extension.ext4_dio_write_iter.new_sync_write.vfs_write.ksys_write
      0.00            +1.0        0.98 ± 30%  perf-profile.calltrace.cycles-pp.ext4_mb_mark_diskspace_used.ext4_mb_new_blocks.ext4_ext_map_blocks.ext4_map_blocks.ext4_iomap_begin
      0.00            +1.0        0.98 ± 33%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.iomap_dio_bio_end_io.blk_update_request.blk_mq_end_request
      0.00            +1.0        0.98 ± 39%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.new_sync_write.vfs_write.ksys_write
      0.46 ± 72%      +1.0        1.44 ± 46%  perf-profile.calltrace.cycles-pp.machines__deliver_event.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.process_simple
      0.00            +1.0        0.98 ± 26%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.worker_thread
      0.27 ±100%      +1.0        1.26 ± 35%  perf-profile.calltrace.cycles-pp.__dso__load_kallsyms.dso__load.map__load.thread__find_map.build_id__mark_dso_hit
      0.00            +1.0        0.99 ± 31%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.iomap_dio_bio_end_io.blk_update_request
      0.28 ±100%      +1.0        1.28 ± 36%  perf-profile.calltrace.cycles-pp.map__load.thread__find_map.build_id__mark_dso_hit.machines__deliver_event.perf_session__deliver_event
      0.28 ±100%      +1.0        1.27 ± 36%  perf-profile.calltrace.cycles-pp.dso__load.map__load.thread__find_map.build_id__mark_dso_hit.machines__deliver_event
      0.00            +1.0        1.00 ± 39%  perf-profile.calltrace.cycles-pp.generic_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.29 ±100%      +1.0        1.30 ± 37%  perf-profile.calltrace.cycles-pp.thread__find_map.build_id__mark_dso_hit.machines__deliver_event.perf_session__deliver_event.__ordered_events__flush
      0.00            +1.0        1.01 ± 21%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
      0.08 ±223%      +1.0        1.10 ± 37%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      0.00            +1.0        1.01 ± 31%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.iomap_dio_bio_end_io.blk_update_request.blk_mq_end_request
      0.00            +1.0        1.02 ± 23%  perf-profile.calltrace.cycles-pp.__libc_fork
      0.00            +1.0        1.02 ± 20%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write
      0.33 ±100%      +1.0        1.36 ± 41%  perf-profile.calltrace.cycles-pp.build_id__mark_dso_hit.machines__deliver_event.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event
      0.00            +1.0        1.03 ± 21%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
      0.00            +1.0        1.03 ± 20%  perf-profile.calltrace.cycles-pp.perf_poll.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.0        1.03 ± 27%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.worker_thread.kthread
      0.00            +1.1        1.06 ± 19%  perf-profile.calltrace.cycles-pp.kallsyms__parse.__dso__load_kallsyms.dso__load.map__load.thread__find_map
      0.26 ±100%      +1.1        1.33 ± 33%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      0.26 ±100%      +1.1        1.34 ± 32%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      0.00            +1.1        1.09 ± 33%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.enqueue_entity.enqueue_task_fair.ttwu_do_activate
      0.26 ±100%      +1.1        1.36 ± 32%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read
      0.26 ±100%      +1.1        1.36 ± 32%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      0.00            +1.1        1.09 ± 24%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write.ksys_write
      0.27 ±100%      +1.1        1.38 ± 30%  perf-profile.calltrace.cycles-pp.__libc_read
      0.00            +1.1        1.14 ±  7%  perf-profile.calltrace.cycles-pp.bio_iov_iter_get_pages.iomap_dio_bio_actor.iomap_apply.__iomap_dio_rw.iomap_dio_rw
      0.08 ±223%      +1.2        1.27 ± 42%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      0.00            +1.2        1.19 ± 10%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.2        1.19 ± 10%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.2        1.19 ± 10%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.2        1.20 ± 23%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.new_sync_read.vfs_read
      0.00            +1.2        1.21 ± 23%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.new_sync_read.vfs_read.ksys_read
      0.08 ±223%      +1.2        1.30 ± 43%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      0.08 ±223%      +1.2        1.31 ± 42%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write
      0.00            +1.2        1.24 ± 20%  perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      0.00            +1.2        1.24 ± 21%  perf-profile.calltrace.cycles-pp.pipe_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.00            +1.2        1.25 ± 33%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.proc_reg_read.vfs_read.ksys_read
      0.41 ± 70%      +1.3        1.66 ± 16%  perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.do_iter_readv_writev
      0.00            +1.3        1.25 ± 32%  perf-profile.calltrace.cycles-pp.seq_read.proc_reg_read.vfs_read.ksys_read.do_syscall_64
      0.00            +1.3        1.26 ± 33%  perf-profile.calltrace.cycles-pp.proc_reg_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.3        1.28 ± 20%  perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64.nsinfo__new
      0.00            +1.3        1.28 ± 26%  perf-profile.calltrace.cycles-pp.update_curr.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      0.09 ±223%      +1.3        1.39 ± 43%  perf-profile.calltrace.cycles-pp.__libc_write
      0.00            +1.3        1.32 ± 20%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64.nsinfo__new.thread__new
      0.00            +1.3        1.32 ± 20%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__xstat64.nsinfo__new.thread__new.____machine__findnew_thread
      0.88 ± 13%      +1.4        2.24 ± 16%  perf-profile.calltrace.cycles-pp.drm_fb_memcpy_dstclip.mgag200_simple_display_pipe_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail.commit_tail
      0.88 ± 13%      +1.4        2.24 ± 16%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_helper_dirtyfb.drm_fb_helper_damage_work
      0.88 ± 13%      +1.4        2.24 ± 16%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_helper_dirtyfb
      0.88 ± 13%      +1.4        2.24 ± 16%  perf-profile.calltrace.cycles-pp.mgag200_simple_display_pipe_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail.commit_tail.drm_atomic_helper_commit
      0.00            +1.4        1.36 ± 19%  perf-profile.calltrace.cycles-pp.__xstat64.nsinfo__new.thread__new.____machine__findnew_thread.machine__process_fork_event
      0.89 ± 13%      +1.4        2.25 ± 17%  perf-profile.calltrace.cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_helper_dirtyfb.drm_fb_helper_damage_work.process_one_work
      0.89 ± 13%      +1.4        2.26 ± 17%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_helper_dirtyfb.drm_fb_helper_damage_work.process_one_work.worker_thread
      0.00            +1.4        1.38 ± 17%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.90 ± 13%      +1.4        2.29 ± 17%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
      0.00            +1.4        1.40 ± 18%  perf-profile.calltrace.cycles-pp.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.93 ± 13%      +1.4        2.33 ± 17%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.10 ±223%      +1.5        1.55 ± 16%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +1.5        1.46 ± 22%  perf-profile.calltrace.cycles-pp.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64
      0.00            +1.5        1.47 ± 17%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00            +1.5        1.50 ± 30%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.__queue_work
      0.00            +1.5        1.50 ± 23%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule.schedule_timeout
      0.08 ±223%      +1.5        1.58 ±  8%  perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.do_iter_readv_writev
      0.00            +1.5        1.53 ± 20%  perf-profile.calltrace.cycles-pp.nsinfo__new.thread__new.____machine__findnew_thread.machine__process_fork_event.machines__deliver_event
      0.00            +1.5        1.54 ± 19%  perf-profile.calltrace.cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
      0.00            +1.5        1.54 ± 19%  perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
      0.00            +1.5        1.54 ± 18%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__poll
      0.00            +1.5        1.54 ± 18%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
      0.00            +1.5        1.55 ±  6%  perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.00            +1.6        1.55 ± 18%  perf-profile.calltrace.cycles-pp.__poll
      0.00            +1.6        1.57 ± 22%  perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule.schedule_timeout.io_schedule_timeout
      0.00            +1.6        1.57 ± 30%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.__queue_work.queue_work_on
      0.00            +1.6        1.60 ± 19%  perf-profile.calltrace.cycles-pp.thread__new.____machine__findnew_thread.machine__process_fork_event.machines__deliver_event.perf_session__deliver_event
      0.00            +1.6        1.60 ± 30%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.__queue_work.queue_work_on.loop_queue_rq
      0.00            +1.6        1.60 ± 17%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.6        1.64 ± 19%  perf-profile.calltrace.cycles-pp.____machine__findnew_thread.machine__process_fork_event.machines__deliver_event.perf_session__deliver_event.process_simple
      0.00            +1.7        1.68 ± 19%  perf-profile.calltrace.cycles-pp.machine__process_fork_event.machines__deliver_event.perf_session__deliver_event.process_simple.perf_session__process_events
      0.00            +1.7        1.70 ± 16%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +1.7        1.71 ± 16%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork
      0.10 ±223%      +1.7        1.84 ± 14%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.11 ±223%      +1.8        1.90 ± 15%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.00            +1.8        1.80 ± 55%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.cmd_record.cmd_sched.run_builtin
      0.00            +1.8        1.84 ± 18%  perf-profile.calltrace.cycles-pp.machines__deliver_event.perf_session__deliver_event.process_simple.perf_session__process_events.record__finish_output
      0.00            +1.9        1.86 ± 24%  perf-profile.calltrace.cycles-pp.find_lock_entries.__invalidate_mapping_pages.drop_pagecache_sb.iterate_supers.drop_caches_sysctl_handler
      0.00            +1.9        1.87 ± 19%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.9        1.87 ± 18%  perf-profile.calltrace.cycles-pp.perf_session__deliver_event.process_simple.perf_session__process_events.record__finish_output.cmd_record
      0.40 ± 71%      +1.9        2.32 ± 26%  perf-profile.calltrace.cycles-pp.ext4_free_blocks.ext4_remove_blocks.ext4_ext_rm_leaf.ext4_ext_remove_space.ext4_ext_truncate
      0.08 ±223%      +1.9        2.01 ± 16%  perf-profile.calltrace.cycles-pp.execve
      0.11 ±223%      +1.9        2.04 ± 14%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      0.72 ± 30%      +1.9        2.66 ± 13%  perf-profile.calltrace.cycles-pp.ext4_mb_new_blocks.ext4_ext_map_blocks.ext4_map_blocks.ext4_iomap_begin.iomap_apply
      0.00            +2.0        1.96 ± 38%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch
      0.00            +2.0        1.99 ± 15%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +2.0        2.00 ± 16%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      0.00            +2.0        2.00 ± 16%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +2.0        2.00 ± 16%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +2.0        2.00 ± 38%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch.__schedule.schedule
      0.00            +2.0        2.00 ± 38%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch.__schedule
      0.40 ± 71%      +2.0        2.42 ± 25%  perf-profile.calltrace.cycles-pp.ext4_remove_blocks.ext4_ext_rm_leaf.ext4_ext_remove_space.ext4_ext_truncate.ext4_truncate
      0.00            +2.1        2.06 ±  8%  perf-profile.calltrace.cycles-pp.try_to_wake_up.raise_softirq.blk_mq_complete_request_remote.blk_mq_complete_request.loop_process_work
      0.00            +2.1        2.11 ± 55%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.cmd_record.cmd_sched.run_builtin.main
      0.00            +2.1        2.13 ±  8%  perf-profile.calltrace.cycles-pp.raise_softirq.blk_mq_complete_request_remote.blk_mq_complete_request.loop_process_work.process_one_work
      0.08 ±223%      +2.2        2.28 ± 17%  perf-profile.calltrace.cycles-pp.__schedule.schedule.worker_thread.kthread.ret_from_fork
      0.00            +2.2        2.21 ±  7%  perf-profile.calltrace.cycles-pp.blk_mq_complete_request_remote.blk_mq_complete_request.loop_process_work.process_one_work.worker_thread
      0.00            +2.2        2.22 ±  7%  perf-profile.calltrace.cycles-pp.blk_mq_complete_request.loop_process_work.process_one_work.worker_thread.kthread
      0.00            +2.2        2.23 ± 31%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      0.08 ±223%      +2.3        2.34 ± 16%  perf-profile.calltrace.cycles-pp.schedule.worker_thread.kthread.ret_from_fork
      1.19 ± 51%      +2.3        3.47 ± 26%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.memcpy_toio.drm_fb_memcpy_dstclip.mgag200_simple_display_pipe_update.drm_atomic_helper_commit_planes
      0.54 ±  6%      +2.3        2.83 ± 10%  perf-profile.calltrace.cycles-pp.iomap_dio_bio_actor.iomap_apply.__iomap_dio_rw.iomap_dio_rw.ext4_dio_write_iter
      0.00            +2.4        2.36 ± 30%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.io_schedule_timeout
      1.36 ± 24%      +2.4        3.74 ± 24%  perf-profile.calltrace.cycles-pp.process_simple.perf_session__process_events.record__finish_output.cmd_record.cmd_sched
      1.50 ± 24%      +2.4        3.91 ± 28%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.cmd_record.cmd_sched.run_builtin
      1.52 ± 24%      +2.4        3.94 ± 28%  perf-profile.calltrace.cycles-pp.record__finish_output.cmd_record.cmd_sched.run_builtin.main
      0.47 ± 71%      +2.5        2.98 ± 24%  perf-profile.calltrace.cycles-pp.ext4_ext_rm_leaf.ext4_ext_remove_space.ext4_ext_truncate.ext4_truncate.ext4_setattr
      1.33 ± 24%      +2.5        3.85 ± 14%  perf-profile.calltrace.cycles-pp.ext4_ext_map_blocks.ext4_map_blocks.ext4_iomap_begin.iomap_apply.__iomap_dio_rw
      0.00            +2.5        2.54 ± 18%  perf-profile.calltrace.cycles-pp.try_to_wake_up.__queue_work.queue_work_on.loop_queue_rq.__blk_mq_try_issue_directly
      0.00            +2.6        2.58 ± 32%  perf-profile.calltrace.cycles-pp.try_to_wake_up.iomap_dio_bio_end_io.blk_update_request.blk_mq_end_request.blk_complete_reqs
      0.72 ± 18%      +2.7        3.38 ± 23%  perf-profile.calltrace.cycles-pp.ext4_ext_remove_space.ext4_ext_truncate.ext4_truncate.ext4_setattr.notify_change
      0.00            +2.7        2.67 ± 30%  perf-profile.calltrace.cycles-pp.iomap_dio_bio_end_io.blk_update_request.blk_mq_end_request.blk_complete_reqs.__softirqentry_text_start
      1.23 ± 24%      +2.7        3.96 ± 32%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime
      0.00            +2.8        2.75 ± 13%  perf-profile.calltrace.cycles-pp.__queue_work.queue_work_on.loop_queue_rq.__blk_mq_try_issue_directly.blk_mq_request_issue_directly
      0.00            +2.8        2.77 ± 13%  perf-profile.calltrace.cycles-pp.queue_work_on.loop_queue_rq.__blk_mq_try_issue_directly.blk_mq_request_issue_directly.blk_mq_try_issue_list_directly
      1.24 ± 24%      +2.8        4.04 ± 32%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr
      0.79 ± 15%      +2.9        3.74 ± 23%  perf-profile.calltrace.cycles-pp.__invalidate_mapping_pages.drop_pagecache_sb.iterate_supers.drop_caches_sysctl_handler.proc_sys_call_handler
      0.30 ±100%      +3.0        3.31 ± 15%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.84 ± 18%      +3.0        3.85 ± 21%  perf-profile.calltrace.cycles-pp.ext4_ext_truncate.ext4_truncate.ext4_setattr.notify_change.do_truncate
      1.06 ± 22%      +3.0        4.07 ± 12%  perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.do_iter_readv_writev.do_iter_write
      0.31 ±100%      +3.0        3.36 ± 15%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.48 ± 24%      +3.1        4.53 ± 15%  perf-profile.calltrace.cycles-pp.ext4_map_blocks.ext4_iomap_begin.iomap_apply.__iomap_dio_rw.iomap_dio_rw
      0.00            +3.1        3.06 ± 26%  perf-profile.calltrace.cycles-pp.blk_update_request.blk_mq_end_request.blk_complete_reqs.__softirqentry_text_start.run_ksoftirqd
      0.32 ±100%      +3.1        3.42 ± 16%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.32 ±100%      +3.1        3.43 ± 16%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      1.54 ± 23%      +3.2        4.75 ± 15%  perf-profile.calltrace.cycles-pp.ext4_iomap_begin.iomap_apply.__iomap_dio_rw.iomap_dio_rw.ext4_dio_write_iter
      0.00            +3.2        3.23 ± 29%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity
      0.00            +3.2        3.24 ± 25%  perf-profile.calltrace.cycles-pp.blk_mq_end_request.blk_complete_reqs.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn
      0.34 ±100%      +3.3        3.59 ± 16%  perf-profile.calltrace.cycles-pp.read
      0.00            +3.4        3.35 ± 29%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_wakeup_template
      0.37 ± 70%      +3.4        3.74 ± 56%  perf-profile.calltrace.cycles-pp.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
      0.00            +3.4        3.39 ± 29%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair
      0.00            +3.5        3.46 ± 24%  perf-profile.calltrace.cycles-pp.blk_complete_reqs.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread
      0.00            +3.5        3.49 ± 28%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up
      0.00            +3.5        3.52 ± 28%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair.__schedule
      1.00 ± 19%      +3.7        4.66 ± 22%  perf-profile.calltrace.cycles-pp.ext4_truncate.ext4_setattr.notify_change.do_truncate.do_sys_ftruncate
      1.04 ± 14%      +3.7        4.79 ± 24%  perf-profile.calltrace.cycles-pp.drop_pagecache_sb.iterate_supers.drop_caches_sysctl_handler.proc_sys_call_handler.new_sync_write
      1.04 ± 14%      +3.8        4.80 ± 24%  perf-profile.calltrace.cycles-pp.iterate_supers.drop_caches_sysctl_handler.proc_sys_call_handler.new_sync_write.vfs_write
      1.07 ± 12%      +3.8        4.92 ± 24%  perf-profile.calltrace.cycles-pp.drop_caches_sysctl_handler.proc_sys_call_handler.new_sync_write.vfs_write.ksys_write
      1.07 ± 12%      +3.8        4.92 ± 24%  perf-profile.calltrace.cycles-pp.proc_sys_call_handler.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.00            +3.9        3.88 ± 26%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.89 ± 10%      +3.9        4.77 ± 21%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.io_schedule_timeout.__iomap_dio_rw
      0.89 ± 10%      +3.9        4.80 ± 21%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.iomap_dio_rw
      0.00            +3.9        3.92 ± 21%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +3.9        3.95 ± 21%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +4.1        4.06 ± 11%  perf-profile.calltrace.cycles-pp.loop_queue_rq.__blk_mq_try_issue_directly.blk_mq_request_issue_directly.blk_mq_try_issue_list_directly.blk_mq_sched_insert_requests
      0.00            +4.1        4.13 ± 11%  perf-profile.calltrace.cycles-pp.__blk_mq_try_issue_directly.blk_mq_request_issue_directly.blk_mq_try_issue_list_directly.blk_mq_sched_insert_requests.blk_mq_flush_plug_list
      0.00            +4.2        4.16 ± 11%  perf-profile.calltrace.cycles-pp.blk_mq_request_issue_directly.blk_mq_try_issue_list_directly.blk_mq_sched_insert_requests.blk_mq_flush_plug_list.blk_flush_plug_list
      1.37 ± 22%      +4.2        5.56 ±  9%  perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.do_iter_readv_writev.do_iter_write.lo_write_bvec
      0.94 ± 10%      +4.2        5.13 ± 20%  perf-profile.calltrace.cycles-pp.schedule_timeout.io_schedule_timeout.__iomap_dio_rw.iomap_dio_rw.ext4_dio_write_iter
      0.00            +4.2        4.20 ± 11%  perf-profile.calltrace.cycles-pp.blk_mq_try_issue_list_directly.blk_mq_sched_insert_requests.blk_mq_flush_plug_list.blk_flush_plug_list.blk_finish_plug
      0.95 ± 10%      +4.2        5.16 ± 20%  perf-profile.calltrace.cycles-pp.io_schedule_timeout.__iomap_dio_rw.iomap_dio_rw.ext4_dio_write_iter.new_sync_write
      0.77 ± 24%      +4.5        5.27 ± 44%  perf-profile.calltrace.cycles-pp.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
      0.77 ± 24%      +4.5        5.30 ± 44%  perf-profile.calltrace.cycles-pp.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow
      1.63 ± 20%      +4.5        6.16 ± 36%  perf-profile.calltrace.cycles-pp.cmd_sched.run_builtin.main.__libc_start_main
      1.62 ± 20%      +4.5        6.16 ± 36%  perf-profile.calltrace.cycles-pp.cmd_record.cmd_sched.run_builtin.main.__libc_start_main
      1.57 ± 23%      +4.6        6.21 ±  7%  perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.do_iter_readv_writev.do_iter_write.lo_write_bvec.loop_process_work
      1.60 ± 23%      +4.7        6.27 ±  7%  perf-profile.calltrace.cycles-pp.do_iter_readv_writev.do_iter_write.lo_write_bvec.loop_process_work.process_one_work
      1.26 ± 18%      +4.7        6.00 ± 20%  perf-profile.calltrace.cycles-pp.ext4_setattr.notify_change.do_truncate.do_sys_ftruncate.do_syscall_64
      1.65 ± 23%      +4.8        6.44 ±  7%  perf-profile.calltrace.cycles-pp.do_iter_write.lo_write_bvec.loop_process_work.process_one_work.worker_thread
      1.30 ± 18%      +4.9        6.19 ± 21%  perf-profile.calltrace.cycles-pp.notify_change.do_truncate.do_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.68 ± 23%      +4.9        6.58 ±  7%  perf-profile.calltrace.cycles-pp.lo_write_bvec.loop_process_work.process_one_work.worker_thread.kthread
      0.74 ± 15%      +5.0        5.79 ± 16%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
      2.39 ± 23%      +5.4        7.80 ± 10%  perf-profile.calltrace.cycles-pp.iomap_apply.__iomap_dio_rw.iomap_dio_rw.ext4_dio_write_iter.new_sync_write
      1.09 ± 23%      +5.5        6.60 ± 38%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event
      1.80 ± 20%      +5.5        7.33 ± 30%  perf-profile.calltrace.cycles-pp.__libc_start_main
      1.80 ± 20%      +5.5        7.33 ± 30%  perf-profile.calltrace.cycles-pp.main.__libc_start_main
      1.80 ± 20%      +5.5        7.33 ± 30%  perf-profile.calltrace.cycles-pp.run_builtin.main.__libc_start_main
      2.09 ± 24%      +7.5        9.63 ±  4%  perf-profile.calltrace.cycles-pp.loop_process_work.process_one_work.worker_thread.kthread.ret_from_fork
      3.99 ± 22%      +9.7       13.65 ±  3%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      4.46 ± 21%     +11.7       16.16 ±  3%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      5.33 ± 20%     +17.6       22.95 ±  5%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      5.33 ± 20%     +17.6       22.96 ±  5%  perf-profile.calltrace.cycles-pp.ret_from_fork
     72.64 ±  5%     -68.1        4.57 ±  8%  perf-profile.children.cycles-pp.blk_mq_sched_insert_requests
     72.66 ±  5%     -68.0        4.68 ±  7%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
     72.67 ±  5%     -68.0        4.70 ±  8%  perf-profile.children.cycles-pp.blk_flush_plug_list
     72.43 ±  5%     -68.0        4.47 ±  9%  perf-profile.children.cycles-pp.blk_finish_plug
     64.68 ±  6%     -63.8        0.86 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock
     64.47 ±  6%     -63.7        0.75 ± 37%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     76.11 ±  5%     -58.2       17.93 ±  6%  perf-profile.children.cycles-pp.__iomap_dio_rw
     76.11 ±  5%     -58.2       17.94 ±  6%  perf-profile.children.cycles-pp.iomap_dio_rw
     76.68 ±  5%     -56.9       19.83 ±  5%  perf-profile.children.cycles-pp.ext4_dio_write_iter
     52.89 ±  5%     -52.6        0.29 ± 31%  perf-profile.children.cycles-pp.__blk_mq_delay_run_hw_queue
     53.18 ±  4%     -52.3        0.88 ± 34%  perf-profile.children.cycles-pp.__blk_mq_do_dispatch_sched
     53.20 ±  4%     -52.3        0.91 ± 31%  perf-profile.children.cycles-pp.__blk_mq_run_hw_queue
     53.20 ±  4%     -52.3        0.91 ± 31%  perf-profile.children.cycles-pp.blk_mq_sched_dispatch_requests
     53.19 ±  4%     -52.3        0.91 ± 31%  perf-profile.children.cycles-pp.__blk_mq_sched_dispatch_requests
     52.42 ±  5%     -51.7        0.70 ± 33%  perf-profile.children.cycles-pp.dd_dispatch_request
     78.58 ±  5%     -51.1       27.52 ±  2%  perf-profile.children.cycles-pp.new_sync_write
     78.70 ±  5%     -50.8       27.90 ±  2%  perf-profile.children.cycles-pp.vfs_write
     78.69 ±  5%     -50.6       28.04 ±  2%  perf-profile.children.cycles-pp.ksys_write
     84.60 ±  4%     -27.6       57.02 ±  5%  perf-profile.children.cycles-pp.do_syscall_64
     84.65 ±  4%     -27.4       57.20 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     19.69 ±  6%     -19.7        0.00        perf-profile.children.cycles-pp.dd_insert_requests
      7.55 ± 20%      -6.9        0.67 ± 33%  perf-profile.children.cycles-pp.dd_queued
      3.05 ±  7%      -1.8        1.28 ± 56%  perf-profile.children.cycles-pp.start_secondary
      3.42 ±  9%      -1.2        2.21 ± 32%  perf-profile.children.cycles-pp.do_idle
      3.42 ±  9%      -1.2        2.22 ± 33%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      3.42 ±  9%      -1.2        2.22 ± 33%  perf-profile.children.cycles-pp.cpu_startup_entry
      1.03 ± 19%      -0.9        0.14 ± 21%  perf-profile.children.cycles-pp.cpumask_next
      3.05 ±  7%      -0.8        2.25 ± 25%  perf-profile.children.cycles-pp.scheduler_tick
      1.78 ±  9%      -0.8        0.99 ± 38%  perf-profile.children.cycles-pp.cpuidle_enter
      1.77 ±  9%      -0.8        0.99 ± 38%  perf-profile.children.cycles-pp.cpuidle_enter_state
      2.74 ±  6%      -0.7        2.01 ± 25%  perf-profile.children.cycles-pp.task_tick_fair
      0.73 ± 18%      -0.5        0.20 ± 15%  perf-profile.children.cycles-pp._find_next_bit
      0.59 ± 13%      -0.4        0.20 ± 52%  perf-profile.children.cycles-pp.blk_mq_dispatch_rq_list
      0.50 ±  6%      -0.4        0.12 ± 34%  perf-profile.children.cycles-pp.load_balance
      0.40 ±  9%      -0.3        0.07 ± 57%  perf-profile.children.cycles-pp.newidle_balance
      0.25 ±  9%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.find_busiest_group
      0.24 ± 11%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.45 ± 13%      -0.2        0.30 ± 27%  perf-profile.children.cycles-pp.menu_select
      0.22 ± 41%      -0.1        0.07 ± 79%  perf-profile.children.cycles-pp.mntput_no_expire
      0.19 ± 52%      -0.1        0.05 ± 49%  perf-profile.children.cycles-pp.__block_write_full_page
      0.19 ± 52%      -0.1        0.05 ± 59%  perf-profile.children.cycles-pp.__writepage
      0.23 ± 13%      -0.1        0.10 ± 49%  perf-profile.children.cycles-pp.intel_idle
      0.20 ± 10%      -0.1        0.08 ± 80%  perf-profile.children.cycles-pp.rebalance_domains
      0.13 ± 13%      -0.1        0.06 ± 75%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.01 ±223%      +0.1        0.07 ± 22%  perf-profile.children.cycles-pp.bio_endio
      0.01 ±223%      +0.1        0.07 ± 30%  perf-profile.children.cycles-pp.blk_mq_rq_ctx_init
      0.15 ±  4%      +0.1        0.21 ± 23%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.02 ±142%      +0.1        0.08 ± 29%  perf-profile.children.cycles-pp.sbitmap_get
      0.05 ± 49%      +0.1        0.12 ± 21%  perf-profile.children.cycles-pp.update_cfs_group
      0.02 ±142%      +0.1        0.09 ± 32%  perf-profile.children.cycles-pp.ext4_mb_use_preallocated
      0.00            +0.1        0.07 ± 21%  perf-profile.children.cycles-pp.free_swap_cache
      0.00            +0.1        0.07 ± 43%  perf-profile.children.cycles-pp.PyParser_AddToken
      0.00            +0.1        0.07 ± 37%  perf-profile.children.cycles-pp.blkdev_read_iter
      0.00            +0.1        0.08 ± 35%  perf-profile.children.cycles-pp.page_add_new_anon_rmap
      0.00            +0.1        0.08 ± 27%  perf-profile.children.cycles-pp.__x64_sys_readlink
      0.03 ±100%      +0.1        0.10 ± 25%  perf-profile.children.cycles-pp.get_stack_info_noinstr
      0.00            +0.1        0.08 ± 36%  perf-profile.children.cycles-pp.unlink_file_vma
      0.00            +0.1        0.08 ± 35%  perf-profile.children.cycles-pp.show_stat
      0.01 ±223%      +0.1        0.09 ± 53%  perf-profile.children.cycles-pp.atime_needs_update
      0.02 ±141%      +0.1        0.10 ± 38%  perf-profile.children.cycles-pp.proc_pident_instantiate
      0.04 ± 71%      +0.1        0.12 ± 28%  perf-profile.children.cycles-pp.touch_atime
      0.00            +0.1        0.08 ± 21%  perf-profile.children.cycles-pp.page_cache_ra_unbounded
      0.00            +0.1        0.08 ± 31%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.00            +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.__netlink_dump_start
      0.00            +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.netlink_rcv_skb
      0.00            +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.rtnetlink_rcv_msg
      0.00            +0.1        0.08 ± 28%  perf-profile.children.cycles-pp.schedule_hrtimeout_range_clock
      0.00            +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.sendto
      0.01 ±223%      +0.1        0.09 ± 41%  perf-profile.children.cycles-pp.sync_regs
      0.00            +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.00            +0.1        0.09 ± 30%  perf-profile.children.cycles-pp.__xa_set_mark
      0.00            +0.1        0.09 ± 44%  perf-profile.children.cycles-pp.____sys_sendmsg
      0.00            +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.snmp_get_cpu_field
      0.06 ± 52%      +0.1        0.15 ± 40%  perf-profile.children.cycles-pp.rb_insert_color
      0.00            +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.netlink_unicast
      0.01 ±223%      +0.1        0.10 ± 34%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.01 ±223%      +0.1        0.10 ± 36%  perf-profile.children.cycles-pp.ext4_da_reserve_space
      0.00            +0.1        0.09 ± 52%  perf-profile.children.cycles-pp.___sys_sendmsg
      0.00            +0.1        0.09 ± 52%  perf-profile.children.cycles-pp.__sys_sendmsg
      0.00            +0.1        0.10 ± 31%  perf-profile.children.cycles-pp.alloc_bprm
      0.00            +0.1        0.10 ± 38%  perf-profile.children.cycles-pp.internal_add_timer
      0.01 ±223%      +0.1        0.11 ± 22%  perf-profile.children.cycles-pp.try_charge_memcg
      0.00            +0.1        0.10 ± 39%  perf-profile.children.cycles-pp.___slab_alloc
      0.00            +0.1        0.10 ± 37%  perf-profile.children.cycles-pp.bitmap_list_string
      0.01 ±223%      +0.1        0.11 ± 35%  perf-profile.children.cycles-pp.timestamp_truncate
      0.00            +0.1        0.10 ± 47%  perf-profile.children.cycles-pp.find_extend_vma
      0.02 ±141%      +0.1        0.12 ± 40%  perf-profile.children.cycles-pp.blk_mq_start_request
      0.00            +0.1        0.10 ± 36%  perf-profile.children.cycles-pp.__get_user_pages_remote
      0.03 ±100%      +0.1        0.13 ± 40%  perf-profile.children.cycles-pp.get_callchain_entry
      0.00            +0.1        0.10 ± 32%  perf-profile.children.cycles-pp.refill_obj_stock
      0.02 ±142%      +0.1        0.12 ± 37%  perf-profile.children.cycles-pp.cpuacct_charge
      0.01 ±223%      +0.1        0.11 ± 31%  perf-profile.children.cycles-pp.netlink_sendmsg
      0.00            +0.1        0.10 ± 39%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.1        0.10 ± 43%  perf-profile.children.cycles-pp.anon_vma_fork
      0.00            +0.1        0.10 ± 32%  perf-profile.children.cycles-pp.get_arg_page
      0.00            +0.1        0.11 ± 32%  perf-profile.children.cycles-pp.vmacache_find
      0.00            +0.1        0.11 ± 24%  perf-profile.children.cycles-pp.lock_page_memcg
      0.01 ±223%      +0.1        0.12 ± 37%  perf-profile.children.cycles-pp.perf_swevent_get_recursion_context
      0.00            +0.1        0.11 ± 32%  perf-profile.children.cycles-pp.d_path
      0.02 ±141%      +0.1        0.12 ± 40%  perf-profile.children.cycles-pp.do_open_execat
      0.00            +0.1        0.11 ± 49%  perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.02 ±141%      +0.1        0.13 ± 45%  perf-profile.children.cycles-pp.path_init
      0.10 ± 34%      +0.1        0.21 ± 28%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.11 ± 32%  perf-profile.children.cycles-pp.__slab_alloc
      0.00            +0.1        0.11 ± 15%  perf-profile.children.cycles-pp.__snmp6_fill_stats64
      0.01 ±223%      +0.1        0.12 ± 35%  perf-profile.children.cycles-pp.perf_output_end
      0.00            +0.1        0.11 ± 35%  perf-profile.children.cycles-pp.filp_close
      0.01 ±223%      +0.1        0.12 ± 46%  perf-profile.children.cycles-pp.proc_alloc_inode
      0.00            +0.1        0.12 ± 28%  perf-profile.children.cycles-pp.page_remove_rmap
      0.00            +0.1        0.12 ± 43%  perf-profile.children.cycles-pp.terminate_walk
      0.00            +0.1        0.12 ± 19%  perf-profile.children.cycles-pp.inet6_fill_link_af
      0.00            +0.1        0.12 ± 19%  perf-profile.children.cycles-pp.inet6_fill_ifla6_attrs
      0.03 ±100%      +0.1        0.14 ± 39%  perf-profile.children.cycles-pp.mpage_prepare_extent_to_map
      0.00            +0.1        0.12 ± 32%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.01 ±223%      +0.1        0.12 ± 44%  perf-profile.children.cycles-pp.security_path_truncate
      0.05 ± 75%      +0.1        0.16 ± 29%  perf-profile.children.cycles-pp.iomap_dio_complete
      0.03 ±100%      +0.1        0.14 ± 28%  perf-profile.children.cycles-pp.ext4_mb_release_context
      0.00            +0.1        0.12 ± 29%  perf-profile.children.cycles-pp.____sys_recvmsg
      0.00            +0.1        0.12 ± 20%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.01 ±223%      +0.1        0.13 ± 35%  perf-profile.children.cycles-pp.perf_tp_event_match
      0.04 ± 73%      +0.1        0.16 ± 24%  perf-profile.children.cycles-pp.blk_mq_get_tag
      0.05 ± 81%      +0.1        0.16 ± 45%  perf-profile.children.cycles-pp.__perf_sw_event
      0.00            +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.count_free
      0.02 ± 99%      +0.1        0.14 ± 28%  perf-profile.children.cycles-pp.rcu_all_qs
      0.02 ±142%      +0.1        0.14 ± 35%  perf-profile.children.cycles-pp.__might_fault
      0.01 ±223%      +0.1        0.13 ± 48%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.02 ±142%      +0.1        0.14 ± 36%  perf-profile.children.cycles-pp.ftrace_graph_ret_addr
      0.00            +0.1        0.12 ± 47%  perf-profile.children.cycles-pp.pte_alloc_one
      0.00            +0.1        0.12 ± 43%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.02 ±141%      +0.1        0.14 ± 35%  perf-profile.children.cycles-pp.blkdev_write_iter
      0.02 ±143%      +0.1        0.14 ± 33%  perf-profile.children.cycles-pp.__libc_pwrite
      0.03 ±102%      +0.1        0.15 ± 27%  perf-profile.children.cycles-pp.gup_pgd_range
      0.02 ±142%      +0.1        0.14 ± 33%  perf-profile.children.cycles-pp.ksys_pwrite64
      0.00            +0.1        0.12 ± 42%  perf-profile.children.cycles-pp.__delete_from_page_cache
      0.06 ± 47%      +0.1        0.19 ± 42%  perf-profile.children.cycles-pp.kallsyms_expand_symbol
      0.01 ±223%      +0.1        0.13 ± 39%  perf-profile.children.cycles-pp.ext4_es_can_be_merged
      0.01 ±223%      +0.1        0.13 ± 30%  perf-profile.children.cycles-pp.recvmsg
      0.02 ±142%      +0.1        0.14 ± 38%  perf-profile.children.cycles-pp.__get_free_pages
      0.01 ±223%      +0.1        0.13 ± 42%  perf-profile.children.cycles-pp.aa_file_perm
      0.01 ±223%      +0.1        0.14 ± 43%  perf-profile.children.cycles-pp.user_path_at_empty
      0.01 ±223%      +0.1        0.14 ± 15%  perf-profile.children.cycles-pp.__clear_user
      0.00            +0.1        0.13 ± 24%  perf-profile.children.cycles-pp.up_write
      0.04 ± 73%      +0.1        0.17 ± 37%  perf-profile.children.cycles-pp.alloc_buffer_head
      0.00            +0.1        0.13 ± 47%  perf-profile.children.cycles-pp.vm_area_alloc
      0.01 ±223%      +0.1        0.14 ± 32%  perf-profile.children.cycles-pp.__sys_recvmsg
      0.01 ±223%      +0.1        0.14 ± 55%  perf-profile.children.cycles-pp.common_perm_cond
      0.00            +0.1        0.13 ± 44%  perf-profile.children.cycles-pp.diskstats_show
      0.00            +0.1        0.13 ± 19%  perf-profile.children.cycles-pp.ext4_inode_block_valid
      0.03 ±100%      +0.1        0.16 ± 35%  perf-profile.children.cycles-pp.__calc_delta
      0.00            +0.1        0.13 ± 32%  perf-profile.children.cycles-pp.___sys_recvmsg
      0.01 ±223%      +0.1        0.14 ± 35%  perf-profile.children.cycles-pp.string_nocheck
      0.07 ± 52%      +0.1        0.21 ± 22%  perf-profile.children.cycles-pp.__blk_mq_alloc_request
      0.00            +0.1        0.14 ± 38%  perf-profile.children.cycles-pp.copyout
      0.05 ± 45%      +0.1        0.18 ± 46%  perf-profile.children.cycles-pp.ext4_mb_load_buddy_gfp
      0.06 ± 11%      +0.1        0.20 ± 24%  perf-profile.children.cycles-pp.lru_add_drain
      0.02 ±141%      +0.1        0.15 ± 33%  perf-profile.children.cycles-pp.crypto_shash_update
      0.00            +0.1        0.14 ± 27%  perf-profile.children.cycles-pp.__perf_event_account_interrupt
      0.00            +0.1        0.14 ± 42%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.01 ±223%      +0.1        0.15 ± 27%  perf-profile.children.cycles-pp.alloc_pages
      0.00            +0.1        0.14 ± 31%  perf-profile.children.cycles-pp.remove_wait_queue
      0.01 ±223%      +0.1        0.15 ± 34%  perf-profile.children.cycles-pp.obj_cgroup_charge_pages
      0.01 ±223%      +0.1        0.15 ± 15%  perf-profile.children.cycles-pp.reweight_entity
      0.00            +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.count_partial
      0.00            +0.1        0.14 ± 29%  perf-profile.children.cycles-pp._copy_to_user
      0.01 ±223%      +0.1        0.15 ± 29%  perf-profile.children.cycles-pp.map_id_range_down
      0.03 ±101%      +0.1        0.17 ± 35%  perf-profile.children.cycles-pp.shmem_alloc_page
      0.01 ±223%      +0.1        0.15 ± 46%  perf-profile.children.cycles-pp.del_timer_sync
      0.00            +0.1        0.14 ± 42%  perf-profile.children.cycles-pp.vm_area_dup
      0.01 ±223%      +0.1        0.15 ± 43%  perf-profile.children.cycles-pp.proc_pid_lookup
      0.02 ±144%      +0.1        0.16 ± 57%  perf-profile.children.cycles-pp.ext4_es_remove_extent
      0.00            +0.1        0.15 ± 46%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.00            +0.1        0.15 ± 57%  perf-profile.children.cycles-pp.io_serial_out
      0.00            +0.1        0.15 ± 34%  perf-profile.children.cycles-pp.rcu_gp_cleanup
      0.00            +0.1        0.15 ±115%  perf-profile.children.cycles-pp.__kernel_read
      0.01 ±223%      +0.1        0.16 ± 14%  perf-profile.children.cycles-pp.rtnl_dump_ifinfo
      0.01 ±223%      +0.1        0.16 ± 14%  perf-profile.children.cycles-pp.rtnl_fill_ifinfo
      0.15 ± 21%      +0.1        0.30 ± 23%  perf-profile.children.cycles-pp.native_sched_clock
      0.06 ± 45%      +0.1        0.21 ± 16%  perf-profile.children.cycles-pp.get_stack_info
      0.00            +0.1        0.15 ± 27%  perf-profile.children.cycles-pp.vfs_fstat
      0.00            +0.2        0.15 ± 36%  perf-profile.children.cycles-pp.__rblist__findnew
      0.00            +0.2        0.15 ± 12%  perf-profile.children.cycles-pp.get_slabinfo
      0.01 ±223%      +0.2        0.16 ± 38%  perf-profile.children.cycles-pp.proc_root_lookup
      0.05 ± 50%      +0.2        0.20 ± 45%  perf-profile.children.cycles-pp.free_unref_page_list
      0.01 ±223%      +0.2        0.16 ± 38%  perf-profile.children.cycles-pp.path_put
      0.03 ±102%      +0.2        0.18 ± 41%  perf-profile.children.cycles-pp.perf_read
      0.00            +0.2        0.15 ± 33%  perf-profile.children.cycles-pp.__x64_sys_sendto
      0.00            +0.2        0.15 ± 33%  perf-profile.children.cycles-pp.__sys_sendto
      0.00            +0.2        0.15 ± 19%  perf-profile.children.cycles-pp.fput_many
      0.00            +0.2        0.15 ± 44%  perf-profile.children.cycles-pp.task_state
      0.01 ±223%      +0.2        0.16 ± 16%  perf-profile.children.cycles-pp.netlink_dump
      0.03 ±100%      +0.2        0.18 ± 39%  perf-profile.children.cycles-pp.proc_pident_lookup
      0.05 ± 48%      +0.2        0.20 ± 23%  perf-profile.children.cycles-pp.__read_extent_tree_block
      0.01 ±223%      +0.2        0.16 ± 45%  perf-profile.children.cycles-pp.__vsnprintf_chk
      0.02 ±141%      +0.2        0.17 ± 41%  perf-profile.children.cycles-pp.map_id_up
      0.02 ±142%      +0.2        0.18 ± 33%  perf-profile.children.cycles-pp.new_inode
      0.01 ±223%      +0.2        0.16 ± 27%  perf-profile.children.cycles-pp.vma_link
      0.01 ±223%      +0.2        0.16 ± 31%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.05 ± 50%      +0.2        0.21 ± 37%  perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.01 ±223%      +0.2        0.17 ± 30%  perf-profile.children.cycles-pp.remove_mapping
      0.01 ±223%      +0.2        0.17 ± 30%  perf-profile.children.cycles-pp.__remove_mapping
      0.05 ± 81%      +0.2        0.20 ± 32%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.05 ± 81%      +0.2        0.20 ± 32%  perf-profile.children.cycles-pp.kernel_wait4
      0.00            +0.2        0.16 ± 34%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.01 ±223%      +0.2        0.17 ± 36%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.03 ±101%      +0.2        0.20 ± 48%  perf-profile.children.cycles-pp.ext4_fc_track_inode
      0.03 ±101%      +0.2        0.19 ± 34%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.07 ± 30%      +0.2        0.23 ± 31%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.01 ±223%      +0.2        0.17 ± 43%  perf-profile.children.cycles-pp.vfprintf
      0.01 ±223%      +0.2        0.17 ± 22%  perf-profile.children.cycles-pp.slab_show
      0.03 ±100%      +0.2        0.19 ± 20%  perf-profile.children.cycles-pp.getifaddrs
      0.01 ±223%      +0.2        0.17 ± 34%  perf-profile.children.cycles-pp.remove_vma
      0.00            +0.2        0.16 ± 31%  perf-profile.children.cycles-pp.__switch_to
      0.04 ± 75%      +0.2        0.20 ± 73%  perf-profile.children.cycles-pp.start_this_handle
      0.04 ± 72%      +0.2        0.20 ± 37%  perf-profile.children.cycles-pp.string
      0.06 ± 50%      +0.2        0.23 ± 34%  perf-profile.children.cycles-pp.alloc_page_buffers
      0.04 ±104%      +0.2        0.20 ± 32%  perf-profile.children.cycles-pp.do_wait
      0.05 ± 45%      +0.2        0.22 ± 15%  perf-profile.children.cycles-pp.xas_store
      0.05 ± 80%      +0.2        0.22 ± 40%  perf-profile.children.cycles-pp.do_set_pte
      0.01 ±223%      +0.2        0.18 ± 21%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.08 ± 24%      +0.2        0.24 ± 22%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.01 ±223%      +0.2        0.18 ± 31%  perf-profile.children.cycles-pp.down_read
      0.01 ±223%      +0.2        0.18 ± 41%  perf-profile.children.cycles-pp.__test_set_page_writeback
      0.04 ± 76%      +0.2        0.21 ± 42%  perf-profile.children.cycles-pp.strncpy_from_user
      0.23 ± 23%      +0.2        0.40 ± 22%  perf-profile.children.cycles-pp.update_rq_clock
      0.17 ± 20%      +0.2        0.34 ± 18%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.01 ±223%      +0.2        0.18 ± 15%  perf-profile.children.cycles-pp.make_kuid
      0.04 ± 72%      +0.2        0.21 ± 56%  perf-profile.children.cycles-pp.end_page_writeback
      0.01 ±223%      +0.2        0.18 ± 22%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.01 ±223%      +0.2        0.18 ± 13%  perf-profile.children.cycles-pp.mod_objcg_state
      0.07 ± 25%      +0.2        0.24 ± 39%  perf-profile.children.cycles-pp.ext4_es_insert_delayed_block
      0.06 ± 76%      +0.2        0.23 ± 38%  perf-profile.children.cycles-pp.current_time
      0.01 ±223%      +0.2        0.18 ± 39%  perf-profile.children.cycles-pp.clear_page_erms
      0.01 ±223%      +0.2        0.19 ± 42%  perf-profile.children.cycles-pp.unit_file_find_dropin_paths
      0.10 ± 33%      +0.2        0.28 ± 41%  perf-profile.children.cycles-pp.update_iter
      0.01 ±223%      +0.2        0.19 ± 41%  perf-profile.children.cycles-pp.kernel_init_free_pages
      0.14 ± 38%      +0.2        0.32 ± 45%  perf-profile.children.cycles-pp.wb_workfn
      0.14 ± 38%      +0.2        0.32 ± 45%  perf-profile.children.cycles-pp.wb_writeback
      0.05 ± 72%      +0.2        0.23 ± 37%  perf-profile.children.cycles-pp.ext4_group_desc_csum
      0.02 ±146%      +0.2        0.20 ± 51%  perf-profile.children.cycles-pp.copy_page_range
      0.12 ±  9%      +0.2        0.30 ± 34%  perf-profile.children.cycles-pp.bsearch
      0.04 ± 71%      +0.2        0.22 ± 28%  perf-profile.children.cycles-pp.inode_permission
      0.02 ±142%      +0.2        0.20 ± 63%  perf-profile.children.cycles-pp.__module_text_address
      0.04 ±102%      +0.2        0.22 ± 31%  perf-profile.children.cycles-pp.__check_object_size
      0.04 ± 75%      +0.2        0.23 ± 28%  perf-profile.children.cycles-pp.shmem_alloc_and_acct_page
      0.00            +0.2        0.19 ± 62%  perf-profile.children.cycles-pp.__module_address
      0.05 ± 80%      +0.2        0.24 ± 32%  perf-profile.children.cycles-pp.wait4
      0.04 ± 71%      +0.2        0.22 ± 19%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.02 ±141%      +0.2        0.21 ± 69%  perf-profile.children.cycles-pp.mempool_alloc
      0.05 ± 74%      +0.2        0.24 ± 32%  perf-profile.children.cycles-pp.kernel_fpu_begin_mask
      0.04 ± 80%      +0.2        0.23 ± 40%  perf-profile.children.cycles-pp.d_alloc
      0.01 ±223%      +0.2        0.20 ± 38%  perf-profile.children.cycles-pp.copy_strings
      0.06 ± 64%      +0.2        0.26 ± 37%  perf-profile.children.cycles-pp.ext4_io_submit
      0.05 ± 45%      +0.2        0.24 ± 55%  perf-profile.children.cycles-pp.is_module_text_address
      0.10 ± 36%      +0.2        0.30 ± 41%  perf-profile.children.cycles-pp.s_next
      0.07 ± 47%      +0.2        0.26 ± 28%  perf-profile.children.cycles-pp.common_file_perm
      0.01 ±223%      +0.2        0.21 ± 42%  perf-profile.children.cycles-pp.timekeeping_update
      0.01 ±223%      +0.2        0.21 ± 38%  perf-profile.children.cycles-pp.select_idle_cpu
      0.06 ± 53%      +0.2        0.25 ± 36%  perf-profile.children.cycles-pp.__es_insert_extent
      0.02 ±141%      +0.2        0.22 ± 35%  perf-profile.children.cycles-pp.proc_pid_make_inode
      0.07 ± 54%      +0.2        0.27 ± 31%  perf-profile.children.cycles-pp.create_empty_buffers
      0.05 ± 47%      +0.2        0.25 ± 27%  perf-profile.children.cycles-pp.do_dentry_open
      0.03 ±100%      +0.2        0.23 ± 43%  perf-profile.children.cycles-pp.deactivate_file_page
      0.02 ±141%      +0.2        0.22 ± 25%  perf-profile.children.cycles-pp.malloc
      0.06 ± 46%      +0.2        0.26 ± 14%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.02 ±142%      +0.2        0.22 ± 93%  perf-profile.children.cycles-pp.filemap_get_pages
      0.03 ±100%      +0.2        0.24 ± 25%  perf-profile.children.cycles-pp.perf_misc_flags
      0.04 ± 75%      +0.2        0.25 ± 47%  perf-profile.children.cycles-pp.unlock_page
      0.02 ±142%      +0.2        0.22 ± 30%  perf-profile.children.cycles-pp.stop_this_handle
      0.06 ± 19%      +0.2        0.27 ± 55%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.03 ±102%      +0.2        0.24 ± 31%  perf-profile.children.cycles-pp.sock_sendmsg
      0.04 ± 83%      +0.2        0.25 ± 22%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.01 ±223%      +0.2        0.22 ± 29%  perf-profile.children.cycles-pp.poll_freewait
      0.03 ±100%      +0.2        0.24 ± 27%  perf-profile.children.cycles-pp.proc_ns_get_link
      0.09 ± 28%      +0.2        0.30 ± 29%  perf-profile.children.cycles-pp.next_uptodate_page
      0.03 ±141%      +0.2        0.24 ± 33%  perf-profile.children.cycles-pp.new_inode_pseudo
      0.02 ±141%      +0.2        0.23 ± 13%  perf-profile.children.cycles-pp.__restore_fpregs_from_fpstate
      0.03 ±141%      +0.2        0.24 ± 33%  perf-profile.children.cycles-pp.alloc_inode
      0.06 ± 72%      +0.2        0.27 ± 41%  perf-profile.children.cycles-pp.ext4_group_desc_csum_set
      0.07 ± 20%      +0.2        0.29 ± 40%  perf-profile.children.cycles-pp.perf_output_begin_forward
      0.12 ±  7%      +0.2        0.34 ± 29%  perf-profile.children.cycles-pp.search_extable
      0.06 ± 51%      +0.2        0.28 ± 24%  perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.06 ± 46%      +0.2        0.28 ± 26%  perf-profile.children.cycles-pp.__vm_munmap
      0.01 ±223%      +0.2        0.23 ± 36%  perf-profile.children.cycles-pp.kvm_is_in_guest
      0.14 ± 10%      +0.2        0.36 ± 31%  perf-profile.children.cycles-pp.search_exception_tables
      0.10 ± 39%      +0.2        0.32 ± 28%  perf-profile.children.cycles-pp.___perf_sw_event
      0.01 ±223%      +0.2        0.24 ± 57%  perf-profile.children.cycles-pp.mb_free_blocks
      0.02 ±142%      +0.2        0.24 ± 33%  perf-profile.children.cycles-pp.prep_new_page
      0.06 ± 33%      +0.2        0.29 ± 39%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.04 ± 79%      +0.2        0.27 ± 19%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.04 ± 71%      +0.2        0.26 ± 39%  perf-profile.children.cycles-pp.mprotect_fixup
      0.12 ± 20%      +0.2        0.35 ± 22%  perf-profile.children.cycles-pp.error_entry
      0.04 ± 73%      +0.2        0.27 ± 86%  perf-profile.children.cycles-pp.kmem_cache_alloc_trace
      0.06 ± 47%      +0.2        0.29 ± 29%  perf-profile.children.cycles-pp.memset_erms
      0.02 ±142%      +0.2        0.25 ± 17%  perf-profile.children.cycles-pp.__fget_files
      0.08 ± 20%      +0.2        0.31 ± 18%  perf-profile.children.cycles-pp.unmap_region
      0.08 ± 25%      +0.2        0.31 ± 33%  perf-profile.children.cycles-pp.__entry_text_start
      0.06 ± 29%      +0.2        0.30 ± 46%  perf-profile.children.cycles-pp.ext4_es_insert_extent
      0.10 ± 29%      +0.2        0.33 ± 30%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.05 ± 72%      +0.2        0.29 ± 22%  perf-profile.children.cycles-pp.free_pgtables
      0.05 ± 57%      +0.2        0.29 ± 23%  perf-profile.children.cycles-pp.select_idle_sibling
      0.09 ± 27%      +0.2        0.33 ± 24%  perf-profile.children.cycles-pp.__pagevec_lru_add
      0.07 ± 28%      +0.2        0.30 ± 37%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.02 ±223%      +0.2        0.26 ± 34%  perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.06 ± 46%      +0.2        0.30 ± 26%  perf-profile.children.cycles-pp.__kmalloc
      0.04 ± 72%      +0.2        0.29 ± 20%  perf-profile.children.cycles-pp.switch_fpu_return
      0.03 ±111%      +0.2        0.28 ± 33%  perf-profile.children.cycles-pp.__d_alloc
      0.09 ± 31%      +0.2        0.33 ± 29%  perf-profile.children.cycles-pp.lru_cache_add
      0.04 ±102%      +0.2        0.28 ± 21%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.07 ± 18%      +0.2        0.32 ± 32%  perf-profile.children.cycles-pp.mark_page_accessed
      0.04 ±105%      +0.2        0.28 ± 16%  perf-profile.children.cycles-pp.__set_page_dirty
      0.19 ± 22%      +0.2        0.44 ± 20%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.03 ±103%      +0.2        0.28 ± 27%  perf-profile.children.cycles-pp.xas_start
      0.08 ± 51%      +0.2        0.33 ± 34%  perf-profile.children.cycles-pp.ext4_read_block_bitmap_nowait
      0.01 ±223%      +0.2        0.26 ± 37%  perf-profile.children.cycles-pp.__vma_adjust
      0.02 ±141%      +0.2        0.27 ± 26%  perf-profile.children.cycles-pp.__switch_to_asm
      0.28 ± 58%      +0.2        0.53 ± 31%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      0.11 ± 21%      +0.2        0.36 ± 24%  perf-profile.children.cycles-pp.ext4_find_extent
      0.28 ± 60%      +0.3        0.53 ± 30%  perf-profile.children.cycles-pp.file_write_and_wait_range
      0.05 ± 45%      +0.3        0.30 ± 36%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.05 ± 45%      +0.3        0.30 ± 36%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.03 ±100%      +0.3        0.28 ± 27%  perf-profile.children.cycles-pp.devkmsg_read
      0.01 ±223%      +0.3        0.26 ± 31%  perf-profile.children.cycles-pp.__do_sys_newfstat
      0.02 ±142%      +0.3        0.28 ± 62%  perf-profile.children.cycles-pp.do_faccessat
      0.03 ±103%      +0.3        0.29 ± 35%  perf-profile.children.cycles-pp.__split_vma
      0.04 ±105%      +0.3        0.29 ± 75%  perf-profile.children.cycles-pp.find_vma
      0.08 ± 23%      +0.3        0.34 ± 23%  perf-profile.children.cycles-pp.kfree
      0.04 ± 89%      +0.3        0.30 ± 43%  perf-profile.children.cycles-pp.timekeeping_advance
      0.06 ± 17%      +0.3        0.32 ± 37%  perf-profile.children.cycles-pp.page_mapping
      0.06 ± 87%      +0.3        0.33 ± 23%  perf-profile.children.cycles-pp.__close
      0.08 ± 21%      +0.3        0.35 ± 29%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.05 ± 83%      +0.3        0.32 ± 47%  perf-profile.children.cycles-pp.__es_remove_extent
      0.16 ±  7%      +0.3        0.43 ± 29%  perf-profile.children.cycles-pp.fixup_exception
      0.06 ± 52%      +0.3        0.33 ± 15%  perf-profile.children.cycles-pp.set_next_entity
      0.06 ± 50%      +0.3        0.33 ± 14%  perf-profile.children.cycles-pp.number
      0.07 ± 83%      +0.3        0.34 ± 28%  perf-profile.children.cycles-pp.symbol__is_idle
      0.09 ± 28%      +0.3        0.36 ± 37%  perf-profile.children.cycles-pp.perf_event_pid_type
      0.04 ±115%      +0.3        0.31 ± 31%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.06 ± 72%      +0.3        0.33 ± 33%  perf-profile.children.cycles-pp.format_decode
      0.10 ± 25%      +0.3        0.37 ± 23%  perf-profile.children.cycles-pp.ext4_journal_check_start
      0.08 ± 24%      +0.3        0.35 ± 20%  perf-profile.children.cycles-pp.jbd2_journal_stop
      0.07 ± 29%      +0.3        0.35 ± 24%  perf-profile.children.cycles-pp.__mmap
      0.09 ± 30%      +0.3        0.37 ± 20%  perf-profile.children.cycles-pp.getname_flags
      0.10 ± 25%      +0.3        0.38 ± 26%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.11 ± 34%      +0.3        0.40 ± 12%  perf-profile.children.cycles-pp.wp_page_copy
      0.10 ± 12%      +0.3        0.38 ± 26%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.12 ± 34%      +0.3        0.41 ± 28%  perf-profile.children.cycles-pp.generic_update_time
      0.08 ± 14%      +0.3        0.37 ± 33%  perf-profile.children.cycles-pp.__dentry_kill
      0.00            +0.3        0.29 ± 80%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.18 ± 12%      +0.3        0.47 ± 31%  perf-profile.children.cycles-pp.kernelmode_fixup_or_oops
      0.08 ± 25%      +0.3        0.38 ± 36%  perf-profile.children.cycles-pp.__alloc_file
      0.06 ± 77%      +0.3        0.35 ± 53%  perf-profile.children.cycles-pp.ext4_finish_bio
      0.10 ± 24%      +0.3        0.40 ± 36%  perf-profile.children.cycles-pp.ext4_read_block_bitmap
      0.05 ± 48%      +0.3        0.35 ± 23%  perf-profile.children.cycles-pp.__fxstat64
      0.04 ± 73%      +0.3        0.34 ± 10%  perf-profile.children.cycles-pp.elf_map
      0.08 ± 51%      +0.3        0.38 ± 16%  perf-profile.children.cycles-pp.rmqueue
      0.07 ± 49%      +0.3        0.38 ± 27%  perf-profile.children.cycles-pp.down_write
      0.10 ± 15%      +0.3        0.40 ± 33%  perf-profile.children.cycles-pp.submit_bio_checks
      0.09 ± 26%      +0.3        0.39 ± 17%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.07 ± 18%      +0.3        0.38 ± 23%  perf-profile.children.cycles-pp.tlb_flush_mmu
      0.05 ±101%      +0.3        0.35 ± 53%  perf-profile.children.cycles-pp.ext4_release_io_end
      0.12 ± 35%      +0.3        0.43 ± 27%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.07 ± 57%      +0.3        0.38 ± 51%  perf-profile.children.cycles-pp.ext4_end_io_rsv_work
      0.09 ± 27%      +0.3        0.40 ± 14%  perf-profile.children.cycles-pp.__ext4_journal_get_write_access
      0.02 ±141%      +0.3        0.33 ± 79%  perf-profile.children.cycles-pp.__fdget_pos
      0.08 ± 65%      +0.3        0.39 ± 42%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.10 ± 25%      +0.3        0.42 ± 38%  perf-profile.children.cycles-pp.alloc_empty_file
      0.09 ± 43%      +0.3        0.41 ± 31%  perf-profile.children.cycles-pp.ext4_bio_write_page
      0.11 ± 26%      +0.3        0.43 ± 23%  perf-profile.children.cycles-pp.security_file_permission
      0.05 ± 76%      +0.3        0.37 ± 28%  perf-profile.children.cycles-pp._PyEval_EvalFrameDefault
      0.08 ± 64%      +0.3        0.40 ± 44%  perf-profile.children.cycles-pp.sys_imageblit
      0.08 ± 64%      +0.3        0.40 ± 44%  perf-profile.children.cycles-pp.drm_fb_helper_sys_imageblit
      0.08 ± 18%      +0.3        0.40 ± 24%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.11 ± 25%      +0.3        0.44 ± 18%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.06 ± 50%      +0.3        0.39 ± 54%  perf-profile.children.cycles-pp.filemap_read
      0.08 ± 48%      +0.3        0.41 ± 34%  perf-profile.children.cycles-pp.ext4_extent_block_csum
      0.09 ± 51%      +0.3        0.42 ± 24%  perf-profile.children.cycles-pp.pick_link
      0.17 ± 22%      +0.3        0.50 ± 16%  perf-profile.children.cycles-pp.ext4_ext_insert_extent
      0.15 ± 19%      +0.3        0.48 ± 21%  perf-profile.children.cycles-pp.__find_get_block
      0.10 ± 31%      +0.3        0.43 ± 31%  perf-profile.children.cycles-pp.ext4_extent_block_csum_set
      0.05 ± 73%      +0.3        0.39 ± 16%  perf-profile.children.cycles-pp.__fget_light
      0.01 ±223%      +0.3        0.35 ± 26%  perf-profile.children.cycles-pp.check_preempt_wakeup
      0.11 ± 48%      +0.3        0.45 ± 23%  perf-profile.children.cycles-pp.mpage_submit_page
      0.11 ± 32%      +0.3        0.46 ± 31%  perf-profile.children.cycles-pp.__ext4_ext_dirty
      0.06 ± 52%      +0.3        0.40 ± 30%  perf-profile.children.cycles-pp.check_preempt_curr
      0.14 ± 26%      +0.4        0.50 ± 15%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      0.16 ± 32%      +0.4        0.52 ± 23%  perf-profile.children.cycles-pp.ext4_write_checks
      0.11 ± 34%      +0.4        0.47 ± 36%  perf-profile.children.cycles-pp.dput
      0.08 ± 29%      +0.4        0.45 ± 22%  perf-profile.children.cycles-pp.perf_event_mmap
      0.09 ± 22%      +0.4        0.46 ± 23%  perf-profile.children.cycles-pp.__ext4_journal_stop
      0.12 ± 20%      +0.4        0.48 ±  5%  perf-profile.children.cycles-pp.xas_load
      0.12 ± 50%      +0.4        0.49 ± 29%  perf-profile.children.cycles-pp.rcu_do_batch
      0.15 ± 24%      +0.4        0.53 ± 23%  perf-profile.children.cycles-pp.do_anonymous_page
      0.08 ±140%      +0.4        0.46 ± 35%  perf-profile.children.cycles-pp.ext4_sync_file
      0.12 ± 51%      +0.4        0.51 ± 21%  perf-profile.children.cycles-pp.mpage_map_and_submit_buffers
      0.12 ± 20%      +0.4        0.51 ± 40%  perf-profile.children.cycles-pp.__ext4_handle_dirty_metadata
      0.12 ± 33%      +0.4        0.52 ± 19%  perf-profile.children.cycles-pp.alloc_pages_vma
      0.00            +0.4        0.40 ± 48%  perf-profile.children.cycles-pp.perf_mmap__read_init
      0.06 ± 76%      +0.4        0.45 ± 23%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.09 ± 16%      +0.4        0.50 ± 25%  perf-profile.children.cycles-pp.do_open
      0.14 ± 14%      +0.4        0.55 ± 25%  perf-profile.children.cycles-pp.__pagevec_release
      0.10 ± 15%      +0.4        0.51 ± 31%  perf-profile.children.cycles-pp.dup_mmap
      0.10 ± 30%      +0.4        0.52 ±  7%  perf-profile.children.cycles-pp.__block_commit_write
      0.10 ± 20%      +0.4        0.52 ± 22%  perf-profile.children.cycles-pp.invalidate_inode_page
      0.06 ± 72%      +0.4        0.48 ± 36%  perf-profile.children.cycles-pp.openat64
      0.42 ± 34%      +0.4        0.84 ± 18%  perf-profile.children.cycles-pp.do_writepages
      0.09 ± 23%      +0.4        0.51 ± 23%  perf-profile.children.cycles-pp.__close_nocancel
      0.08 ± 48%      +0.4        0.50 ± 44%  perf-profile.children.cycles-pp.lookup_fast
      0.08 ± 84%      +0.4        0.51 ± 57%  perf-profile.children.cycles-pp.common_interrupt
      0.10 ± 28%      +0.4        0.53 ± 17%  perf-profile.children.cycles-pp.perf_evsel__read
      0.13 ± 20%      +0.4        0.56 ± 20%  perf-profile.children.cycles-pp.zap_pte_range
      0.10 ± 33%      +0.4        0.54 ± 33%  perf-profile.children.cycles-pp.jbd2__journal_start
      0.11 ± 17%      +0.4        0.55 ± 31%  perf-profile.children.cycles-pp.dup_mm
      0.18 ± 29%      +0.4        0.62 ± 13%  perf-profile.children.cycles-pp.ext4_da_map_blocks
      0.12 ± 41%      +0.4        0.56 ±  7%  perf-profile.children.cycles-pp.__fput
      0.10 ± 29%      +0.4        0.55 ± 15%  perf-profile.children.cycles-pp.mark_buffer_dirty
      0.11 ± 30%      +0.4        0.55 ± 11%  perf-profile.children.cycles-pp.block_write_end
      0.18 ± 36%      +0.4        0.62 ± 25%  perf-profile.children.cycles-pp.file_update_time
      0.08 ± 85%      +0.4        0.53 ± 55%  perf-profile.children.cycles-pp.asm_common_interrupt
      0.12 ± 15%      +0.4        0.57 ± 19%  perf-profile.children.cycles-pp.__do_munmap
      0.18 ± 27%      +0.5        0.64 ± 14%  perf-profile.children.cycles-pp.ext4_da_get_block_prep
      0.16 ± 43%      +0.5        0.62 ± 17%  perf-profile.children.cycles-pp.map__process_kallsym_symbol
      0.12 ± 26%      +0.5        0.57 ± 11%  perf-profile.children.cycles-pp.generic_write_end
      0.22 ± 34%      +0.5        0.68 ±  5%  perf-profile.children.cycles-pp.__get_user_pages
      0.13 ± 21%      +0.5        0.59 ± 27%  perf-profile.children.cycles-pp.__lookup_slow
      0.09 ± 28%      +0.5        0.56 ± 28%  perf-profile.children.cycles-pp.put_prev_entity
      0.18 ± 26%      +0.5        0.66 ± 27%  perf-profile.children.cycles-pp.shmem_write_begin
      0.19 ± 26%      +0.5        0.67 ± 29%  perf-profile.children.cycles-pp.shmem_getpage_gfp
      0.19 ± 17%      +0.5        0.68 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.15 ± 27%      +0.5        0.64 ± 22%  perf-profile.children.cycles-pp.ext4_inode_csum
      0.14 ± 17%      +0.5        0.64 ± 22%  perf-profile.children.cycles-pp.unmap_page_range
      0.22 ± 34%      +0.5        0.72 ± 11%  perf-profile.children.cycles-pp.get_user_pages_unlocked
      0.12 ± 33%      +0.5        0.62 ± 11%  perf-profile.children.cycles-pp.proc_pid_status
      0.13 ± 33%      +0.5        0.64 ± 12%  perf-profile.children.cycles-pp.proc_single_show
      0.17 ± 26%      +0.5        0.69 ± 19%  perf-profile.children.cycles-pp.ext4_inode_csum_set
      0.15 ± 34%      +0.5        0.67 ± 18%  perf-profile.children.cycles-pp.task_work_run
      0.01 ±223%      +0.5        0.54 ± 32%  perf-profile.children.cycles-pp.swake_up_locked
      0.19 ±  9%      +0.5        0.73 ± 12%  perf-profile.children.cycles-pp.stack_access_ok
      0.45 ± 18%      +0.5        1.00 ± 10%  perf-profile.children.cycles-pp.update_load_avg
      0.15 ± 16%      +0.5        0.70 ± 21%  perf-profile.children.cycles-pp.unmap_vmas
      0.21 ± 45%      +0.5        0.76 ± 21%  perf-profile.children.cycles-pp.ext4_writepages
      0.18 ± 23%      +0.6        0.73 ± 23%  perf-profile.children.cycles-pp.filemap_map_pages
      0.20 ± 21%      +0.6        0.76 ± 22%  perf-profile.children.cycles-pp.__getblk_gfp
      0.21 ± 36%      +0.6        0.77 ± 33%  perf-profile.children.cycles-pp.open64
      0.16 ± 15%      +0.6        0.72 ± 24%  perf-profile.children.cycles-pp.begin_new_exec
      0.18 ±  6%      +0.6        0.75 ± 23%  perf-profile.children.cycles-pp.release_pages
      0.01 ±223%      +0.6        0.57 ± 35%  perf-profile.children.cycles-pp.swake_up_one
      0.19 ± 24%      +0.6        0.75 ± 10%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      0.16 ± 25%      +0.6        0.72 ± 19%  perf-profile.children.cycles-pp.__might_sleep
      0.09 ± 15%      +0.6        0.66 ± 46%  perf-profile.children.cycles-pp.mutex_lock
      0.37 ± 45%      +0.6        0.94 ± 33%  perf-profile.children.cycles-pp.start_kernel
      0.18 ± 27%      +0.6        0.75 ± 11%  perf-profile.children.cycles-pp.ext4_block_bitmap_csum_set
      0.20 ± 14%      +0.6        0.77 ± 29%  perf-profile.children.cycles-pp.kmem_cache_free
      0.16 ± 18%      +0.6        0.75 ± 16%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.10 ± 26%      +0.6        0.68 ± 95%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.6        0.59 ± 54%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.17 ± 33%      +0.6        0.77 ± 22%  perf-profile.children.cycles-pp.step_into
      0.16 ± 22%      +0.6        0.77 ± 19%  perf-profile.children.cycles-pp.read_counters
      0.25 ± 14%      +0.6        0.86 ± 24%  perf-profile.children.cycles-pp.kernel_text_address
      0.15 ± 24%      +0.6        0.78 ± 16%  perf-profile.children.cycles-pp.__open64_nocancel
      0.16 ± 22%      +0.6        0.79 ± 18%  perf-profile.children.cycles-pp.process_interval
      0.25 ± 31%      +0.6        0.89 ± 34%  perf-profile.children.cycles-pp.s_show
      0.38 ± 25%      +0.6        1.02 ± 39%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.16 ± 22%      +0.6        0.79 ± 17%  perf-profile.children.cycles-pp.cmd_stat
      0.16 ± 22%      +0.6        0.79 ± 17%  perf-profile.children.cycles-pp.dispatch_events
      0.22 ± 20%      +0.6        0.87 ± 18%  perf-profile.children.cycles-pp.__ext4_get_inode_loc
      0.58 ± 19%      +0.7        1.24 ± 15%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      0.24 ± 20%      +0.7        0.92 ± 17%  perf-profile.children.cycles-pp.ext4_get_inode_loc
      0.18 ± 29%      +0.7        0.86 ± 23%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.09 ± 25%      +0.7        0.79 ± 28%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.26 ± 14%      +0.7        0.97 ± 20%  perf-profile.children.cycles-pp.memcpy_erms
      0.04 ±102%      +0.7        0.75 ± 48%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.19 ± 21%      +0.7        0.90 ± 26%  perf-profile.children.cycles-pp.copy_process
      0.16 ± 20%      +0.7        0.88 ± 24%  perf-profile.children.cycles-pp.setlocale
      0.41 ± 26%      +0.7        1.14 ± 34%  perf-profile.children.cycles-pp.__generic_file_write_iter
      0.18 ± 19%      +0.7        0.91 ± 21%  perf-profile.children.cycles-pp.xas_find
      0.28 ± 11%      +0.8        1.04 ± 24%  perf-profile.children.cycles-pp.__kernel_text_address
      0.30 ± 22%      +0.8        1.05 ± 19%  perf-profile.children.cycles-pp.do_fault
      0.34 ± 19%      +0.8        1.10 ± 15%  perf-profile.children.cycles-pp.iomap_dio_submit_bio
      0.23 ± 25%      +0.8        0.99 ± 20%  perf-profile.children.cycles-pp.__ext4_journal_start_sb
      0.22 ± 22%      +0.8        1.00 ± 25%  perf-profile.children.cycles-pp.__do_sys_clone
      0.22 ± 22%      +0.8        1.00 ± 25%  perf-profile.children.cycles-pp.kernel_clone
      0.25 ± 23%      +0.8        1.02 ± 23%  perf-profile.children.cycles-pp.__libc_fork
      0.10 ± 29%      +0.8        0.88 ± 29%  perf-profile.children.cycles-pp.rcu_gp_kthread
      0.20 ± 26%      +0.8        0.98 ± 14%  perf-profile.children.cycles-pp.ext4_da_write_end
      0.29 ± 27%      +0.8        1.08 ± 19%  perf-profile.children.cycles-pp.internal_get_user_pages_fast
      0.24 ± 10%      +0.8        1.02 ± 18%  perf-profile.children.cycles-pp.perf_output_copy
      0.15 ± 38%      +0.8        0.94 ± 32%  perf-profile.children.cycles-pp.delay_tsc
      0.27 ± 48%      +0.8        1.06 ± 19%  perf-profile.children.cycles-pp.kallsyms__parse
      0.47 ±  9%      +0.8        1.27 ± 23%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.32 ± 24%      +0.8        1.13 ± 18%  perf-profile.children.cycles-pp.iov_iter_get_pages
      0.61 ±  5%      +0.8        1.44 ± 11%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.37 ± 21%      +0.8        1.21 ± 15%  perf-profile.children.cycles-pp.ext4_handle_inode_extension
      0.38 ± 27%      +0.9        1.24 ± 14%  perf-profile.children.cycles-pp.ext4_mb_mark_diskspace_used
      0.49 ± 36%      +0.9        1.36 ± 41%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.39 ± 42%      +0.9        1.26 ± 35%  perf-profile.children.cycles-pp.__dso__load_kallsyms
      0.43 ± 39%      +0.9        1.30 ± 37%  perf-profile.children.cycles-pp.thread__find_map
      0.26 ± 15%      +0.9        1.14 ± 23%  perf-profile.children.cycles-pp.orc_find
      0.40 ± 41%      +0.9        1.28 ± 36%  perf-profile.children.cycles-pp.map__load
      0.16 ± 24%      +0.9        1.04 ± 20%  perf-profile.children.cycles-pp.perf_poll
      0.22 ± 32%      +0.9        1.10 ± 14%  perf-profile.children.cycles-pp.mmap_region
      0.39 ± 42%      +0.9        1.27 ± 36%  perf-profile.children.cycles-pp.dso__load
      0.33 ± 12%      +0.9        1.21 ± 21%  perf-profile.children.cycles-pp.unwind_get_return_address
      0.37 ± 30%      +0.9        1.26 ± 33%  perf-profile.children.cycles-pp.proc_reg_read
      0.23 ± 30%      +0.9        1.12 ± 18%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.29 ± 30%      +0.9        1.19 ± 25%  perf-profile.children.cycles-pp.seq_vprintf
      0.54 ±  9%      +0.9        1.44 ± 20%  perf-profile.children.cycles-pp.perf_callchain_user
      0.30 ± 30%      +0.9        1.21 ± 24%  perf-profile.children.cycles-pp.seq_printf
      0.36 ± 24%      +0.9        1.27 ± 16%  perf-profile.children.cycles-pp.bio_iov_iter_get_pages
      0.24 ± 24%      +0.9        1.16 ± 47%  perf-profile.children.cycles-pp.finish_task_switch
      0.26 ± 23%      +0.9        1.18 ± 18%  perf-profile.children.cycles-pp.__alloc_pages
      0.26 ± 29%      +1.0        1.22 ± 12%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.26 ± 29%      +1.0        1.22 ± 12%  perf-profile.children.cycles-pp.do_group_exit
      0.26 ± 29%      +1.0        1.22 ± 12%  perf-profile.children.cycles-pp.do_exit
      0.25 ± 29%      +1.0        1.23 ± 15%  perf-profile.children.cycles-pp.do_mmap
      0.31 ± 19%      +1.0        1.30 ± 14%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      0.16 ± 24%      +1.0        1.16 ± 37%  perf-profile.children.cycles-pp.preempt_schedule_common
      0.40 ± 26%      +1.0        1.40 ± 42%  perf-profile.children.cycles-pp.__libc_write
      0.26 ± 11%      +1.0        1.27 ±  4%  perf-profile.children.cycles-pp.___might_sleep
      0.15 ± 33%      +1.0        1.18 ± 21%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.32 ± 27%      +1.0        1.36 ± 24%  perf-profile.children.cycles-pp.vsnprintf
      0.70 ± 17%      +1.0        1.75 ± 17%  perf-profile.children.cycles-pp.submit_bio_noacct
      0.20 ± 23%      +1.1        1.28 ± 15%  perf-profile.children.cycles-pp.rcu_core
      0.27 ± 29%      +1.1        1.36 ± 15%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.29 ± 23%      +1.1        1.40 ± 15%  perf-profile.children.cycles-pp.exit_mmap
      0.32 ± 21%      +1.1        1.43 ± 11%  perf-profile.children.cycles-pp.link_path_walk
      0.54 ± 19%      +1.1        1.66 ± 16%  perf-profile.children.cycles-pp.ext4_block_write_begin
      0.13 ± 23%      +1.1        1.25 ± 20%  perf-profile.children.cycles-pp.pipe_write
      0.30 ± 23%      +1.1        1.42 ± 14%  perf-profile.children.cycles-pp.mmput
      0.18 ± 32%      +1.1        1.30 ± 20%  perf-profile.children.cycles-pp.__wake_up_common
      1.09 ± 13%      +1.2        2.25 ± 30%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.39 ± 27%      +1.2        1.63 ±  8%  perf-profile.children.cycles-pp.grab_cache_page_write_begin
      0.37 ± 26%      +1.2        1.61 ± 13%  perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      0.30 ± 23%      +1.3        1.56 ± 17%  perf-profile.children.cycles-pp.filename_lookup
      0.28 ± 29%      +1.3        1.55 ± 18%  perf-profile.children.cycles-pp.nsinfo__new
      0.25 ± 22%      +1.3        1.55 ± 19%  perf-profile.children.cycles-pp.__x64_sys_poll
      0.25 ± 22%      +1.3        1.56 ± 19%  perf-profile.children.cycles-pp.do_sys_poll
      0.21 ± 28%      +1.3        1.52 ± 23%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.25 ± 22%      +1.3        1.56 ± 18%  perf-profile.children.cycles-pp.__poll
      0.29 ± 28%      +1.3        1.62 ± 18%  perf-profile.children.cycles-pp.thread__new
      0.25 ± 21%      +1.3        1.58 ± 29%  perf-profile.children.cycles-pp.__cond_resched
      0.34 ± 11%      +1.3        1.66 ± 17%  perf-profile.children.cycles-pp.load_elf_binary
      0.15 ± 25%      +1.3        1.48 ± 24%  perf-profile.children.cycles-pp.pipe_read
      0.32 ± 25%      +1.3        1.65 ± 12%  perf-profile.children.cycles-pp.vfs_statx
      0.31 ± 20%      +1.4        1.66 ± 16%  perf-profile.children.cycles-pp.path_lookupat
      0.45 ± 24%      +1.4        1.80 ±  6%  perf-profile.children.cycles-pp.pagecache_get_page
      0.52 ± 28%      +1.4        1.88 ± 21%  perf-profile.children.cycles-pp.__libc_read
      0.88 ± 13%      +1.4        2.24 ± 16%  perf-profile.children.cycles-pp.memcpy_toio
      0.88 ± 13%      +1.4        2.24 ± 16%  perf-profile.children.cycles-pp.drm_fb_memcpy_dstclip
      0.88 ± 13%      +1.4        2.24 ± 16%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail
      0.88 ± 13%      +1.4        2.24 ± 16%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.88 ± 13%      +1.4        2.24 ± 16%  perf-profile.children.cycles-pp.mgag200_simple_display_pipe_update
      0.89 ± 13%      +1.4        2.25 ± 17%  perf-profile.children.cycles-pp.commit_tail
      0.89 ± 13%      +1.4        2.26 ± 17%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.30 ± 28%      +1.4        1.67 ± 19%  perf-profile.children.cycles-pp.____machine__findnew_thread
      0.33 ± 26%      +1.4        1.71 ± 12%  perf-profile.children.cycles-pp.__xstat64
      0.35 ± 11%      +1.4        1.73 ± 16%  perf-profile.children.cycles-pp.exec_binprm
      0.32 ± 20%      +1.4        1.71 ± 19%  perf-profile.children.cycles-pp.io_serial_in
      0.33 ± 26%      +1.4        1.72 ± 11%  perf-profile.children.cycles-pp.__do_sys_newstat
      0.90 ± 13%      +1.4        2.29 ± 17%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.30 ± 27%      +1.4        1.70 ± 18%  perf-profile.children.cycles-pp.machine__process_fork_event
      0.36 ± 21%      +1.4        1.76 ± 16%  perf-profile.children.cycles-pp.walk_component
      0.93 ± 13%      +1.4        2.33 ± 17%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.49 ± 23%      +1.4        1.92 ± 14%  perf-profile.children.cycles-pp.ext4_do_update_inode
      0.37 ± 20%      +1.4        1.81 ± 14%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.01 ±223%      +1.5        1.47 ± 55%  perf-profile.children.cycles-pp.perf_mmap__read_head
      0.46 ± 22%      +1.5        1.92 ± 12%  perf-profile.children.cycles-pp.ext4_dirty_inode
      0.40 ± 17%      +1.5        1.87 ± 24%  perf-profile.children.cycles-pp.find_lock_entries
      0.42 ± 10%      +1.5        1.89 ± 20%  perf-profile.children.cycles-pp.perf_output_sample
      0.39 ± 12%      +1.5        1.88 ± 17%  perf-profile.children.cycles-pp.bprm_execve
      0.41 ± 14%      +1.6        2.01 ± 16%  perf-profile.children.cycles-pp.execve
      0.58 ± 22%      +1.6        2.21 ± 16%  perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      0.66 ± 22%      +1.6        2.30 ± 15%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.30 ± 12%      +1.7        1.96 ± 14%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.51 ± 21%      +1.7        2.16 ± 12%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.56 ± 29%      +1.7        2.24 ± 20%  perf-profile.children.cycles-pp.seq_read
      0.96 ± 23%      +1.7        2.71 ± 12%  perf-profile.children.cycles-pp.ext4_mb_new_blocks
      0.27 ± 26%      +1.8        2.03 ± 19%  perf-profile.children.cycles-pp.new_sync_read
      0.74 ± 23%      +1.8        2.53 ± 13%  perf-profile.children.cycles-pp.handle_mm_fault
      6.65 ± 10%      +1.8        8.46 ± 17%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.52 ± 19%      +1.8        2.33 ± 26%  perf-profile.children.cycles-pp.ext4_free_blocks
      0.46 ± 13%      +1.8        2.28 ± 15%  perf-profile.children.cycles-pp.do_execveat_common
      0.46 ± 13%      +1.8        2.28 ± 15%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.50 ± 19%      +1.8        2.33 ± 24%  perf-profile.children.cycles-pp.path_openat
      0.51 ± 20%      +1.9        2.38 ± 23%  perf-profile.children.cycles-pp.do_filp_open
      0.62 ± 27%      +1.9        2.51 ± 17%  perf-profile.children.cycles-pp.seq_read_iter
      0.54 ± 20%      +1.9        2.43 ± 24%  perf-profile.children.cycles-pp.ext4_remove_blocks
      0.03 ±100%      +1.9        1.93 ± 52%  perf-profile.children.cycles-pp.perf_mmap__push
      0.43 ± 21%      +1.9        2.35 ± 20%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.58 ±  8%      +1.9        2.52 ± 14%  perf-profile.children.cycles-pp.__orc_find
      0.43 ± 22%      +2.0        2.38 ± 20%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.14 ± 32%      +2.0        2.14 ±  8%  perf-profile.children.cycles-pp.raise_softirq
      0.20 ± 28%      +2.0        2.22 ±  7%  perf-profile.children.cycles-pp.blk_mq_complete_request_remote
      0.20 ± 28%      +2.0        2.22 ±  7%  perf-profile.children.cycles-pp.blk_mq_complete_request
      0.84 ± 19%      +2.0        2.87 ± 10%  perf-profile.children.cycles-pp.iomap_dio_bio_actor
      0.44 ± 22%      +2.0        2.49 ± 19%  perf-profile.children.cycles-pp.uart_console_write
      0.45 ± 23%      +2.1        2.53 ± 20%  perf-profile.children.cycles-pp.serial8250_console_write
      0.58 ± 19%      +2.1        2.69 ± 22%  perf-profile.children.cycles-pp.do_sys_openat2
      0.59 ± 19%      +2.1        2.72 ± 22%  perf-profile.children.cycles-pp.do_sys_open
      0.31 ± 17%      +2.1        2.46 ± 12%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.04 ±100%      +2.2        2.24 ± 53%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.91 ± 24%      +2.2        3.16 ± 12%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.52 ± 15%      +2.3        2.77 ± 25%  perf-profile.children.cycles-pp.iomap_dio_bio_end_io
      0.63 ± 19%      +2.4        2.98 ± 24%  perf-profile.children.cycles-pp.ext4_ext_rm_leaf
      0.39 ± 23%      +2.4        2.78 ± 27%  perf-profile.children.cycles-pp.irq_work_run
      1.36 ± 25%      +2.4        3.74 ± 24%  perf-profile.children.cycles-pp.process_simple
      0.30 ± 25%      +2.4        2.69 ± 11%  perf-profile.children.cycles-pp.enqueue_entity
      0.55 ± 25%      +2.4        2.94 ± 23%  perf-profile.children.cycles-pp.printk
      0.41 ± 23%      +2.4        2.80 ± 28%  perf-profile.children.cycles-pp.irq_work_run_list
      0.39 ± 23%      +2.4        2.79 ± 28%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.39 ± 23%      +2.4        2.79 ± 28%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.40 ± 22%      +2.4        2.79 ± 28%  perf-profile.children.cycles-pp.irq_work_single
      0.39 ± 23%      +2.4        2.79 ± 28%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.88 ± 31%      +2.4        3.28 ± 13%  perf-profile.children.cycles-pp.machines__deliver_event
      1.52 ± 24%      +2.4        3.93 ± 29%  perf-profile.children.cycles-pp.perf_session__process_events
      1.52 ± 24%      +2.4        3.94 ± 28%  perf-profile.children.cycles-pp.record__finish_output
      0.40 ±  9%      +2.5        2.89 ± 12%  perf-profile.children.cycles-pp.queue_work_on
      1.02 ± 27%      +2.5        3.52 ± 19%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.56 ± 25%      +2.5        3.07 ± 23%  perf-profile.children.cycles-pp.console_unlock
      0.56 ± 25%      +2.5        3.08 ± 23%  perf-profile.children.cycles-pp.vprintk_emit
      1.38 ± 21%      +2.6        3.96 ± 12%  perf-profile.children.cycles-pp.ext4_ext_map_blocks
      0.49 ± 10%      +2.6        3.09 ± 14%  perf-profile.children.cycles-pp.__queue_work
      0.68 ± 17%      +2.6        3.28 ± 21%  perf-profile.children.cycles-pp.blk_update_request
      0.35 ± 26%      +2.6        2.96 ± 10%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.18 ± 19%      +2.7        3.85 ± 11%  perf-profile.children.cycles-pp.exc_page_fault
      0.68 ± 17%      +2.7        3.36 ± 19%  perf-profile.children.cycles-pp.blk_mq_end_request
      0.72 ± 18%      +2.7        3.41 ± 23%  perf-profile.children.cycles-pp.ext4_ext_remove_space
      0.35 ± 27%      +2.7        3.04 ± 10%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.93 ± 21%      +2.9        3.80 ± 13%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      0.90 ± 18%      +2.9        3.80 ± 20%  perf-profile.children.cycles-pp.blk_complete_reqs
      0.80 ± 15%      +3.0        3.81 ± 23%  perf-profile.children.cycles-pp.__invalidate_mapping_pages
      0.84 ± 18%      +3.0        3.85 ± 21%  perf-profile.children.cycles-pp.ext4_ext_truncate
      1.06 ± 22%      +3.0        4.08 ± 12%  perf-profile.children.cycles-pp.ext4_da_write_begin
      0.54 ± 27%      +3.1        3.60 ± 16%  perf-profile.children.cycles-pp.read
      1.53 ± 20%      +3.1        4.62 ± 13%  perf-profile.children.cycles-pp.ext4_map_blocks
      1.36 ± 17%      +3.1        4.47 ±  9%  perf-profile.children.cycles-pp.asm_exc_page_fault
      1.58 ± 20%      +3.2        4.82 ± 13%  perf-profile.children.cycles-pp.ext4_iomap_begin
      0.93 ±  7%      +3.4        4.29 ± 13%  perf-profile.children.cycles-pp.__unwind_start
      0.29 ± 21%      +3.7        3.95 ± 21%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.48 ±  8%      +3.7        4.15 ± 11%  perf-profile.children.cycles-pp.loop_queue_rq
      1.01 ± 19%      +3.7        4.67 ± 22%  perf-profile.children.cycles-pp.ext4_truncate
      1.04 ± 14%      +3.8        4.80 ± 24%  perf-profile.children.cycles-pp.drop_pagecache_sb
      1.05 ± 14%      +3.8        4.81 ± 24%  perf-profile.children.cycles-pp.iterate_supers
      1.07 ± 12%      +3.8        4.92 ± 24%  perf-profile.children.cycles-pp.drop_caches_sysctl_handler
      1.07 ± 12%      +3.9        4.92 ± 24%  perf-profile.children.cycles-pp.proc_sys_call_handler
      0.70 ± 11%      +3.9        4.63 ± 16%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.70 ±  8%      +4.1        4.76 ± 14%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      1.00 ± 26%      +4.1        5.06 ± 12%  perf-profile.children.cycles-pp.vfs_read
      1.16 ± 12%      +4.1        5.25 ± 18%  perf-profile.children.cycles-pp.io_schedule_timeout
      1.02 ± 26%      +4.2        5.20 ± 12%  perf-profile.children.cycles-pp.ksys_read
      0.00            +4.2        4.19 ± 11%  perf-profile.children.cycles-pp.__blk_mq_try_issue_directly
      0.00            +4.2        4.21 ± 11%  perf-profile.children.cycles-pp.blk_mq_request_issue_directly
      0.00            +4.2        4.25 ± 10%  perf-profile.children.cycles-pp.blk_mq_try_issue_list_directly
      0.75 ± 15%      +4.3        5.09 ± 17%  perf-profile.children.cycles-pp.dequeue_entity
      1.70 ± 11%      +4.4        6.08 ± 13%  perf-profile.children.cycles-pp.__softirqentry_text_start
      1.22 ± 12%      +4.4        5.66 ± 16%  perf-profile.children.cycles-pp.schedule_timeout
      1.63 ± 20%      +4.5        6.16 ± 36%  perf-profile.children.cycles-pp.cmd_sched
      0.79 ± 14%      +4.6        5.42 ± 16%  perf-profile.children.cycles-pp.dequeue_task_fair
      1.58 ± 23%      +4.6        6.21 ±  7%  perf-profile.children.cycles-pp.ext4_buffered_write_iter
      1.61 ± 23%      +4.7        6.33 ±  7%  perf-profile.children.cycles-pp.do_iter_readv_writev
      1.26 ± 18%      +4.8        6.02 ± 20%  perf-profile.children.cycles-pp.ext4_setattr
      1.65 ± 23%      +4.8        6.44 ±  7%  perf-profile.children.cycles-pp.do_iter_write
      1.79 ± 22%      +4.9        6.67 ± 10%  perf-profile.children.cycles-pp.generic_perform_write
      1.64 ± 20%      +4.9        6.53 ± 34%  perf-profile.children.cycles-pp.cmd_record
      1.30 ± 18%      +4.9        6.20 ± 21%  perf-profile.children.cycles-pp.notify_change
      1.68 ± 23%      +4.9        6.58 ±  7%  perf-profile.children.cycles-pp.lo_write_bvec
      1.32 ± 19%      +5.0        6.29 ± 20%  perf-profile.children.cycles-pp.do_truncate
      0.74 ± 15%      +5.0        5.79 ± 16%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.36 ± 18%      +5.2        6.52 ± 20%  perf-profile.children.cycles-pp.do_sys_ftruncate
      2.98 ±  6%      +5.2        8.14 ±  8%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      2.45 ± 20%      +5.3        7.79 ± 10%  perf-profile.children.cycles-pp.iomap_apply
      1.80 ± 20%      +5.5        7.33 ± 30%  perf-profile.children.cycles-pp.__libc_start_main
      1.80 ± 20%      +5.5        7.33 ± 30%  perf-profile.children.cycles-pp.main
      1.80 ± 20%      +5.5        7.33 ± 30%  perf-profile.children.cycles-pp.run_builtin
      3.24 ±  7%      +5.6        8.86 ±  8%  perf-profile.children.cycles-pp.update_curr
      1.85 ±  4%      +5.7        7.56 ± 13%  perf-profile.children.cycles-pp.unwind_next_frame
      2.49 ±  5%      +7.5       10.00 ± 12%  perf-profile.children.cycles-pp.perf_callchain_kernel
      2.09 ± 24%      +7.5        9.63 ±  4%  perf-profile.children.cycles-pp.loop_process_work
      1.33 ± 17%      +8.3        9.61 ± 12%  perf-profile.children.cycles-pp.try_to_wake_up
      3.12 ±  5%      +8.7       11.85 ± 12%  perf-profile.children.cycles-pp.get_perf_callchain
      3.15 ±  5%      +8.8       11.96 ± 12%  perf-profile.children.cycles-pp.perf_callchain
      3.99 ± 22%      +9.7       13.65 ±  3%  perf-profile.children.cycles-pp.process_one_work
      3.49 ±  6%      +9.9       13.41 ± 11%  perf-profile.children.cycles-pp.perf_prepare_sample
      2.02 ± 12%     +10.2       12.25 ±  9%  perf-profile.children.cycles-pp.schedule
      2.62 ± 12%     +11.4       14.01 ± 10%  perf-profile.children.cycles-pp.__schedule
      4.46 ± 21%     +11.7       16.16 ±  3%  perf-profile.children.cycles-pp.worker_thread
      4.04 ±  6%     +11.8       15.82 ± 12%  perf-profile.children.cycles-pp.perf_event_output_forward
      4.09 ±  6%     +12.0       16.11 ± 12%  perf-profile.children.cycles-pp.__perf_event_overflow
      4.11 ±  6%     +12.1       16.23 ± 12%  perf-profile.children.cycles-pp.perf_swevent_overflow
      4.29 ±  7%     +12.6       16.90 ± 12%  perf-profile.children.cycles-pp.perf_tp_event
      5.33 ± 20%     +17.6       22.95 ±  5%  perf-profile.children.cycles-pp.kthread
      5.35 ± 20%     +17.6       22.98 ±  5%  perf-profile.children.cycles-pp.ret_from_fork
     61.60 ±  7%     -60.9        0.75 ± 37%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      6.31 ± 21%      -5.7        0.58 ± 35%  perf-profile.self.cycles-pp.dd_queued
      0.67 ± 17%      -0.5        0.19 ± 17%  perf-profile.self.cycles-pp._find_next_bit
      0.32 ± 27%      -0.3        0.03 ±101%  perf-profile.self.cycles-pp.cpumask_next
      0.23 ± 13%      -0.1        0.10 ± 49%  perf-profile.self.cycles-pp.intel_idle
      0.21 ± 14%      -0.1        0.13 ± 34%  perf-profile.self.cycles-pp.menu_select
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.getname_flags
      0.05 ± 47%      +0.1        0.11 ± 22%  perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.1        0.07 ± 43%  perf-profile.self.cycles-pp.ext4_read_block_bitmap_nowait
      0.00            +0.1        0.07 ± 28%  perf-profile.self.cycles-pp.stop_this_handle
      0.00            +0.1        0.07 ± 18%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.00            +0.1        0.08 ± 41%  perf-profile.self.cycles-pp.kernel_fpu_begin_mask
      0.00            +0.1        0.08 ± 22%  perf-profile.self.cycles-pp.down_read
      0.02 ±144%      +0.1        0.10 ± 37%  perf-profile.self.cycles-pp.ext4_mark_iloc_dirty
      0.00            +0.1        0.08 ± 37%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.01 ±223%      +0.1        0.09 ± 18%  perf-profile.self.cycles-pp.blk_update_request
      0.01 ±223%      +0.1        0.09 ± 47%  perf-profile.self.cycles-pp.sync_regs
      0.00            +0.1        0.08 ± 26%  perf-profile.self.cycles-pp.try_charge_memcg
      0.00            +0.1        0.08 ± 50%  perf-profile.self.cycles-pp.start_this_handle
      0.01 ±223%      +0.1        0.09 ± 40%  perf-profile.self.cycles-pp.timestamp_truncate
      0.01 ±223%      +0.1        0.09 ± 23%  perf-profile.self.cycles-pp.find_vma
      0.00            +0.1        0.08 ± 35%  perf-profile.self.cycles-pp.__es_insert_extent
      0.02 ±142%      +0.1        0.10 ± 29%  perf-profile.self.cycles-pp.vfs_write
      0.00            +0.1        0.08 ± 30%  perf-profile.self.cycles-pp.snmp_get_cpu_field
      0.00            +0.1        0.09 ± 33%  perf-profile.self.cycles-pp.__ext4_journal_start_sb
      0.02 ±142%      +0.1        0.10 ± 16%  perf-profile.self.cycles-pp.mark_buffer_dirty
      0.00            +0.1        0.09 ± 35%  perf-profile.self.cycles-pp.refill_obj_stock
      0.00            +0.1        0.09 ± 32%  perf-profile.self.cycles-pp.reweight_entity
      0.00            +0.1        0.09 ± 24%  perf-profile.self.cycles-pp.perf_misc_flags
      0.00            +0.1        0.09 ± 32%  perf-profile.self.cycles-pp.vmacache_find
      0.03 ±102%      +0.1        0.12 ± 48%  perf-profile.self.cycles-pp.perf_callchain_user
      0.00            +0.1        0.09 ± 47%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.1        0.10 ± 19%  perf-profile.self.cycles-pp.ext4_reserve_inode_write
      0.05 ± 75%      +0.1        0.14 ± 43%  perf-profile.self.cycles-pp.rb_insert_color
      0.00            +0.1        0.10 ± 45%  perf-profile.self.cycles-pp.notify_change
      0.01 ±223%      +0.1        0.11 ± 41%  perf-profile.self.cycles-pp.ext4_mb_release_context
      0.00            +0.1        0.10 ± 34%  perf-profile.self.cycles-pp.ext4_setattr
      0.01 ±223%      +0.1        0.11 ± 35%  perf-profile.self.cycles-pp.perf_callchain
      0.00            +0.1        0.10 ± 27%  perf-profile.self.cycles-pp.lock_page_memcg
      0.00            +0.1        0.10 ± 37%  perf-profile.self.cycles-pp.generic_perform_write
      0.01 ±223%      +0.1        0.11 ± 32%  perf-profile.self.cycles-pp.perf_swevent_get_recursion_context
      0.03 ±100%      +0.1        0.13 ± 40%  perf-profile.self.cycles-pp.get_callchain_entry
      0.02 ±142%      +0.1        0.12 ± 37%  perf-profile.self.cycles-pp.cpuacct_charge
      0.00            +0.1        0.10 ± 52%  perf-profile.self.cycles-pp.io_serial_out
      0.00            +0.1        0.10 ± 51%  perf-profile.self.cycles-pp.blk_mq_flush_plug_list
      0.03 ±100%      +0.1        0.13 ± 31%  perf-profile.self.cycles-pp.gup_pgd_range
      0.00            +0.1        0.11 ± 39%  perf-profile.self.cycles-pp.select_idle_cpu
      0.06 ± 49%      +0.1        0.17 ± 45%  perf-profile.self.cycles-pp.kallsyms_expand_symbol
      0.01 ±223%      +0.1        0.12 ± 33%  perf-profile.self.cycles-pp.perf_tp_event_match
      0.03 ±101%      +0.1        0.14 ± 46%  perf-profile.self.cycles-pp.ext4_es_lookup_extent
      0.04 ±105%      +0.1        0.15 ± 45%  perf-profile.self.cycles-pp.loop_process_work
      0.03 ±100%      +0.1        0.14 ± 34%  perf-profile.self.cycles-pp.kmem_cache_alloc_trace
      0.07 ± 26%      +0.1        0.18 ± 22%  perf-profile.self.cycles-pp.pagecache_get_page
      0.00            +0.1        0.11 ± 30%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.01 ±223%      +0.1        0.12 ± 27%  perf-profile.self.cycles-pp.common_file_perm
      0.10 ± 34%      +0.1        0.21 ± 28%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.02 ±141%      +0.1        0.13 ± 41%  perf-profile.self.cycles-pp.ftrace_graph_ret_addr
      0.02 ±141%      +0.1        0.14 ± 34%  perf-profile.self.cycles-pp.finish_task_switch
      0.01 ±223%      +0.1        0.12 ± 47%  perf-profile.self.cycles-pp.aa_file_perm
      0.00            +0.1        0.12 ± 31%  perf-profile.self.cycles-pp.ext4_map_blocks
      0.00            +0.1        0.12 ± 20%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.14 ± 18%      +0.1        0.26 ± 21%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.1        0.12 ± 35%  perf-profile.self.cycles-pp.__rblist__findnew
      0.00            +0.1        0.12 ± 55%  perf-profile.self.cycles-pp.ext4_ext_remove_space
      0.02 ±142%      +0.1        0.14 ± 45%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.00            +0.1        0.12 ± 13%  perf-profile.self.cycles-pp.count_free
      0.01 ±223%      +0.1        0.13 ± 34%  perf-profile.self.cycles-pp.rcu_all_qs
      0.00            +0.1        0.12 ± 48%  perf-profile.self.cycles-pp.set_next_entity
      0.04 ± 75%      +0.1        0.17 ± 23%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.02 ±141%      +0.1        0.14 ± 30%  perf-profile.self.cycles-pp.__kmalloc
      0.01 ±223%      +0.1        0.14 ± 41%  perf-profile.self.cycles-pp.dequeue_entity
      0.00            +0.1        0.12 ± 32%  perf-profile.self.cycles-pp.perf_trace_buf_update
      0.03 ±103%      +0.1        0.16 ± 23%  perf-profile.self.cycles-pp.ext4_block_write_begin
      0.00            +0.1        0.13 ± 55%  perf-profile.self.cycles-pp.ext4_da_write_begin
      0.06 ± 17%      +0.1        0.19 ± 31%  perf-profile.self.cycles-pp.ext4_ext_map_blocks
      0.01 ±223%      +0.1        0.14 ± 35%  perf-profile.self.cycles-pp.map_id_range_down
      0.00            +0.1        0.13 ± 60%  perf-profile.self.cycles-pp.mb_free_blocks
      0.01 ±223%      +0.1        0.14 ± 38%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.03 ±100%      +0.1        0.16 ± 27%  perf-profile.self.cycles-pp.rcu_read_unlock_strict
      0.01 ±223%      +0.1        0.14 ± 36%  perf-profile.self.cycles-pp.string_nocheck
      0.00            +0.1        0.13 ± 39%  perf-profile.self.cycles-pp.ext4_es_can_be_merged
      0.00            +0.1        0.13 ± 17%  perf-profile.self.cycles-pp.xas_store
      0.03 ±100%      +0.1        0.16 ± 35%  perf-profile.self.cycles-pp.__calc_delta
      0.00            +0.1        0.13 ± 27%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.04 ±102%      +0.1        0.17 ± 26%  perf-profile.self.cycles-pp.map__process_kallsym_symbol
      0.02 ±141%      +0.1        0.16 ± 50%  perf-profile.self.cycles-pp.symbol__is_idle
      0.01 ±223%      +0.1        0.14 ± 22%  perf-profile.self.cycles-pp.invalidate_inode_page
      0.00            +0.1        0.14 ± 27%  perf-profile.self.cycles-pp.__perf_event_account_interrupt
      0.00            +0.1        0.14 ± 38%  perf-profile.self.cycles-pp.__fget_light
      0.01 ±223%      +0.1        0.15 ± 40%  perf-profile.self.cycles-pp.__pagevec_lru_add
      0.01 ±223%      +0.1        0.15 ± 23%  perf-profile.self.cycles-pp.rmqueue
      0.03 ±100%      +0.1        0.17 ± 15%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.14 ± 42%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.00            +0.1        0.14 ± 43%  perf-profile.self.cycles-pp.__ext4_mark_inode_dirty
      0.01 ±223%      +0.1        0.15 ± 45%  perf-profile.self.cycles-pp.ext4_free_blocks
      0.00            +0.1        0.14 ± 25%  perf-profile.self.cycles-pp.mod_objcg_state
      0.00            +0.1        0.14 ± 57%  perf-profile.self.cycles-pp.vfprintf
      0.01 ±223%      +0.1        0.15 ± 27%  perf-profile.self.cycles-pp.__alloc_pages
      0.03 ±144%      +0.1        0.18 ± 28%  perf-profile.self.cycles-pp.__get_user_pages
      0.00            +0.1        0.15 ± 14%  perf-profile.self.cycles-pp.filemap_map_pages
      0.00            +0.1        0.15 ± 61%  perf-profile.self.cycles-pp.__perf_event_overflow
      0.00            +0.1        0.15 ± 32%  perf-profile.self.cycles-pp.malloc
      0.07 ± 50%      +0.2        0.22 ± 12%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.03 ±111%      +0.2        0.18 ± 46%  perf-profile.self.cycles-pp.__es_remove_extent
      0.02 ±143%      +0.2        0.18 ± 21%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.01 ±223%      +0.2        0.16 ± 43%  perf-profile.self.cycles-pp.security_file_permission
      0.01 ±223%      +0.2        0.17 ± 42%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.01 ±223%      +0.2        0.16 ± 29%  perf-profile.self.cycles-pp.down_write
      0.02 ±144%      +0.2        0.18 ± 23%  perf-profile.self.cycles-pp.__ext4_journal_get_write_access
      0.03 ±100%      +0.2        0.18 ± 40%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.2        0.16 ± 32%  perf-profile.self.cycles-pp.clear_page_erms
      0.01 ±223%      +0.2        0.17 ± 25%  perf-profile.self.cycles-pp.unwind_get_return_address
      0.00            +0.2        0.16 ± 41%  perf-profile.self.cycles-pp.map_id_up
      0.00            +0.2        0.16 ± 33%  perf-profile.self.cycles-pp.__switch_to
      0.06 ± 55%      +0.2        0.22 ± 37%  perf-profile.self.cycles-pp.vsnprintf
      0.02 ±141%      +0.2        0.18 ± 30%  perf-profile.self.cycles-pp.__kernel_text_address
      0.16 ± 18%      +0.2        0.32 ± 19%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.00            +0.2        0.16 ± 50%  perf-profile.self.cycles-pp.ext4_ext_rm_leaf
      0.05 ± 72%      +0.2        0.22 ± 32%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.09 ± 20%      +0.2        0.26 ± 30%  perf-profile.self.cycles-pp.error_entry
      0.03 ±101%      +0.2        0.20 ± 38%  perf-profile.self.cycles-pp.__iomap_dio_rw
      0.08 ± 31%      +0.2        0.25 ± 21%  perf-profile.self.cycles-pp.next_uptodate_page
      0.04 ± 77%      +0.2        0.22 ± 42%  perf-profile.self.cycles-pp.___perf_sw_event
      0.03 ±100%      +0.2        0.20 ± 28%  perf-profile.self.cycles-pp.sys_imageblit
      0.11 ± 19%      +0.2        0.28 ± 17%  perf-profile.self.cycles-pp.__find_get_block
      0.06 ± 47%      +0.2        0.24 ± 27%  perf-profile.self.cycles-pp.xas_load
      0.02 ±223%      +0.2        0.19 ± 29%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.03 ±100%      +0.2        0.21 ± 41%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.00            +0.2        0.18 ± 26%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.00            +0.2        0.18 ± 66%  perf-profile.self.cycles-pp.__module_address
      0.01 ±223%      +0.2        0.19 ± 34%  perf-profile.self.cycles-pp.kvm_is_in_guest
      0.01 ±223%      +0.2        0.19 ± 40%  perf-profile.self.cycles-pp.__invalidate_mapping_pages
      0.03 ±103%      +0.2        0.22 ± 23%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.00            +0.2        0.19 ± 39%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.00            +0.2        0.20 ± 68%  perf-profile.self.cycles-pp.record__mmap_read_evlist
      0.00            +0.2        0.20 ± 39%  perf-profile.self.cycles-pp.__perf_event_header__init_id
      0.03 ±101%      +0.2        0.23 ± 26%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.13 ± 29%      +0.2        0.33 ± 28%  perf-profile.self.cycles-pp.update_curr
      0.06 ± 46%      +0.2        0.26 ± 25%  perf-profile.self.cycles-pp.memset_erms
      0.07 ± 17%      +0.2        0.27 ± 33%  perf-profile.self.cycles-pp.__entry_text_start
      0.04 ± 75%      +0.2        0.25 ± 36%  perf-profile.self.cycles-pp.try_to_wake_up
      0.04 ± 71%      +0.2        0.24 ± 31%  perf-profile.self.cycles-pp.__cond_resched
      0.02 ±142%      +0.2        0.23 ± 26%  perf-profile.self.cycles-pp.__fget_files
      0.07 ± 49%      +0.2        0.28 ± 27%  perf-profile.self.cycles-pp.kfree
      0.02 ±141%      +0.2        0.23 ± 13%  perf-profile.self.cycles-pp.__restore_fpregs_from_fpstate
      0.08 ± 31%      +0.2        0.30 ± 19%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.05 ± 45%      +0.2        0.26 ± 30%  perf-profile.self.cycles-pp.mark_page_accessed
      0.05 ± 46%      +0.2        0.27 ± 17%  perf-profile.self.cycles-pp.zap_pte_range
      0.07 ± 20%      +0.2        0.29 ± 40%  perf-profile.self.cycles-pp.perf_output_begin_forward
      0.06 ± 17%      +0.2        0.28 ± 46%  perf-profile.self.cycles-pp.page_mapping
      0.06 ± 48%      +0.2        0.28 ± 27%  perf-profile.self.cycles-pp.get_perf_callchain
      0.02 ±141%      +0.2        0.24 ± 33%  perf-profile.self.cycles-pp.xas_start
      0.08 ± 10%      +0.2        0.30 ± 18%  perf-profile.self.cycles-pp.perf_tp_event
      0.05 ± 49%      +0.2        0.28 ± 25%  perf-profile.self.cycles-pp.mutex_lock
      0.13 ± 17%      +0.2        0.36 ± 29%  perf-profile.self.cycles-pp.__get_user_nocheck_8
      0.01 ±223%      +0.2        0.24 ± 33%  perf-profile.self.cycles-pp.save_fpregs_to_fpstate
      0.09 ± 18%      +0.2        0.33 ± 18%  perf-profile.self.cycles-pp.kernel_text_address
      0.07 ± 50%      +0.2        0.31 ± 21%  perf-profile.self.cycles-pp.__ext4_get_inode_loc
      0.05 ± 74%      +0.2        0.30 ± 39%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.05 ± 74%      +0.2        0.30 ± 15%  perf-profile.self.cycles-pp.number
      0.02 ±141%      +0.2        0.27 ± 26%  perf-profile.self.cycles-pp.__switch_to_asm
      0.14 ± 25%      +0.3        0.39 ± 21%  perf-profile.self.cycles-pp.update_load_avg
      0.08 ± 22%      +0.3        0.34 ± 30%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.06 ± 71%      +0.3        0.32 ± 32%  perf-profile.self.cycles-pp.format_decode
      0.10 ± 24%      +0.3        0.37 ± 18%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.01 ±223%      +0.3        0.28 ± 29%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.10 ± 14%      +0.3        0.37 ± 28%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.00            +0.3        0.28 ± 45%  perf-profile.self.cycles-pp.perf_mmap__read_init
      0.11 ± 20%      +0.3        0.40 ± 34%  perf-profile.self.cycles-pp.perf_prepare_sample
      0.04 ± 74%      +0.3        0.34 ± 23%  perf-profile.self.cycles-pp._PyEval_EvalFrameDefault
      0.08 ± 17%      +0.3        0.39 ± 30%  perf-profile.self.cycles-pp.release_pages
      0.08 ± 77%      +0.3        0.40 ± 34%  perf-profile.self.cycles-pp.kallsyms__parse
      0.10 ± 19%      +0.3        0.41 ± 21%  perf-profile.self.cycles-pp.perf_output_copy
      0.09 ± 19%      +0.3        0.40 ± 22%  perf-profile.self.cycles-pp.__unwind_start
      0.12 ± 15%      +0.3        0.46 ± 37%  perf-profile.self.cycles-pp.kmem_cache_free
      0.08 ± 23%      +0.4        0.44 ± 14%  perf-profile.self.cycles-pp.perf_poll
      0.14 ± 14%      +0.4        0.55 ± 44%  perf-profile.self.cycles-pp.drop_pagecache_sb
      0.24 ± 12%      +0.4        0.66 ± 15%  perf-profile.self.cycles-pp._raw_spin_lock
      0.13 ± 29%      +0.4        0.56 ± 24%  perf-profile.self.cycles-pp.crc32c_pcl_intel_update
      0.18 ± 19%      +0.5        0.65 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.12 ± 33%      +0.5        0.62 ± 29%  perf-profile.self.cycles-pp.__schedule
      0.14 ± 29%      +0.5        0.64 ± 24%  perf-profile.self.cycles-pp.ext4_do_update_inode
      0.18 ± 18%      +0.5        0.70 ± 11%  perf-profile.self.cycles-pp.perf_callchain_kernel
      0.13 ± 28%      +0.5        0.65 ± 21%  perf-profile.self.cycles-pp.__might_sleep
      0.17 ± 10%      +0.5        0.70 ± 11%  perf-profile.self.cycles-pp.stack_access_ok
      0.16 ± 18%      +0.5        0.69 ± 22%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.14 ± 18%      +0.5        0.69 ± 27%  perf-profile.self.cycles-pp.xas_find
      0.14 ± 24%      +0.6        0.76 ± 23%  perf-profile.self.cycles-pp.perf_output_sample
      0.24 ± 13%      +0.7        0.93 ± 18%  perf-profile.self.cycles-pp.memcpy_erms
      0.22 ± 14%      +0.8        1.00 ± 29%  perf-profile.self.cycles-pp.find_lock_entries
      0.15 ± 38%      +0.8        0.94 ± 32%  perf-profile.self.cycles-pp.delay_tsc
      0.25 ± 16%      +0.8        1.04 ± 23%  perf-profile.self.cycles-pp.orc_find
      0.24 ± 11%      +0.9        1.16 ±  6%  perf-profile.self.cycles-pp.___might_sleep
      0.00            +1.1        1.08 ± 55%  perf-profile.self.cycles-pp.perf_mmap__read_head
      0.86 ± 15%      +1.2        2.07 ± 18%  perf-profile.self.cycles-pp.memcpy_toio
      0.32 ± 20%      +1.4        1.70 ± 19%  perf-profile.self.cycles-pp.io_serial_in
      0.58 ±  8%      +1.9        2.51 ± 14%  perf-profile.self.cycles-pp.__orc_find
      0.78 ±  9%      +2.3        3.06 ± 15%  perf-profile.self.cycles-pp.unwind_next_frame


                                                                                
                    fxmark.hdd_ext4_no_jnl_DWTL_1_directio.secs                 
                                                                                
  2.2 +---------------------------------------------------------------------+   
      | O O O     O     O OOO  OO    O                                      |   
    2 |O+        O                                                          |   
      |    O        O O               O      O                              |   
  1.8 |-+            O O           O   O  O O  O O O                        |   
      |      O OO            O   OO     O       O                           |   
  1.6 |-+                                                                   |   
      |                                                                     |   
  1.4 |-+                                  O      O                         |   
      |                                                                     |   
  1.2 |-+                                                     +             |   
      |                                                       ::            |   
    1 |-+                                                     ::            |   
      |++.++++.++++.+++++.++++.+++++. +++.++++.++++ .++++.+++:  ++++.++  .++|   
  0.8 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                  fxmark.hdd_ext4_no_jnl_DWTL_1_directio.works_sec              
                                                                                
  30000 +-------------------------------------------------------------------+   
  28000 |-+                           +             +        .+        ++.  |   
        |++.+++++.+ +++.++++++.+++++.+ +++.+++++.+++ :.++++++ : +++.  +   ++|   
  26000 |-+        +                                 +        : :   ++      |   
  24000 |-+                                                    ::           |   
        |                                                      :            |   
  22000 |-+                                                    :            |   
  20000 |-+                                                    +            |   
  18000 |-+                                                                 |   
        |                                   O      O                        |   
  16000 |-+                                                                 |   
  14000 |-+    OO O            O  OO     O       O                          |   
        |    O       OO OO           O OO  O OOO  O O                       |   
  12000 |OO O O    OO     OOOO  OO    O                                     |   
  10000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             fxmark.time.system_time                            
                                                                                
  55 +----------------------------------------------------------------------+   
     |                                                                      |   
  50 |-+                 +     +     +   +     +        +  +      +         |   
     | ::       ++       :     :     ::  :     ::       : ::      :         |   
     |: :       : +     : :   : :  +: : : :   : :  +   : :: :    : :.+   .++|   
  45 |++ ++++.++   + + .+ ++. + +.+ +  :+ +.+ +  ++ +. + +  +++.++ +  :++   |   
     |              + +      +         +     +        +               +     |   
  40 |-+                                                                    |   
     |                                                                      |   
  35 |-+                                                                    |   
     |                                                                      |   
     |                                                                      |   
  30 |-+                                                                    |   
     |OO OOOO OOOO OOOO OOOO OOOO OOOO OOOO OOOO OOO                        |   
  25 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                     fxmark.time.percent_of_cpu_this_job_got                    
                                                                                
  28 +----------------------------------------------------------------------+   
     |                               +                  +         +         |   
  26 |-+.       ++.      +     +     ::  +     +.       ::.+      ::        |   
     |+  ++ +.+ :  + +  + ++  + +.+++ : + +.+ +  ++++  + +  ++  ++ +.+ ++.++|   
     |:    ::  :    :::+    + :        ::    ::      : :      :+     : :    |   
  24 |-+   +   +    + +      +         +     +       ::       +       :     |   
     |                                                +               +     |   
  22 |-+                                                                    |   
     |                                                                      |   
  20 |-+                                                                    |   
     |                                                                      |   
     |                                                                      |   
  18 |-+                                                                    |   
     |OO OOOO OOOO OOOO OOOO OOOO OOOO OOOO OOOO OOO                        |   
  16 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             fxmark.time.elapsed_time                           
                                                                                
  215 +---------------------------------------------------------------------+   
      | :                 :     :         :     :                           |   
  210 |-::               ::     :        ::     :                           |   
      | ::               : :    ::    +  : :    ::      +  +      +         |   
      |: :  +            : :   : :    :  : :   : :    + :+ :      :         |   
  205 |:+ : :    ++     :  :   : :   : ::  :   : :    : : + :     ::  ++    |   
      |+  +: :   : +  + +  +  .+ + +.+ :+  +  .+ + +.: :    +    : +.+  :.++|   
  200 |-+  + +.++   ++ +    ++    +    +    ++    +  + +     ++.++      +   |   
      |                                                                     |   
  195 |-+                                                                   |   
      |                                    O      O                         |   
      |                     OO  OO O   O  O O  O O O                        |   
  190 |OO OOO       OOO O OO   O  O  OO      O                              |   
      |      O OOOO    O                O       O                           |   
  185 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                           fxmark.time.elapsed_time.max                         
                                                                                
  215 +---------------------------------------------------------------------+   
      | :                 :     :         :     :                           |   
  210 |-::               ::     :        ::     :                           |   
      | ::               : :    ::    +  : :    ::      +  +      +         |   
      |: :  +            : :   : :    :  : :   : :    + :+ :      :         |   
  205 |:+ : :    ++     :  :   : :   : ::  :   : :    : : + :     ::  ++    |   
      |+  +: :   : +  + +  +  .+ + +.+ :+  +  .+ + +.: :    +    : +.+  :.++|   
  200 |-+  + +.++   ++ +    ++    +    +    ++    +  + +     ++.++      +   |   
      |                                                                     |   
  195 |-+                                                                   |   
      |                                    O      O                         |   
      |                     OO  OO O   O  O O  O O O                        |   
  190 |OO OOO       OOO O OO   O  O  OO      O                              |   
      |      O OOOO    O                O       O                           |   
  185 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       perf-sched.total_sch_delay.average.ms                    
                                                                                
  0.24 +--------------------------------------------------------------------+   
       | :                :     :         :     :                           |   
  0.22 |-:                :     :         :     :                           |   
   0.2 |-::               ::    ::        :     :                           |   
       | ::               ::    ::        :     :                           |   
  0.18 |:+:              : :   : :       : :   : :       +                  |   
  0.16 |:+:              : :   : :       : :   : :       :        +         |   
       |:  : +    +      :  :  :  :   +  : :   : :      : :+      :+       +|   
  0.14 |++ :+ :   :+ .++ +  :+ +  :+++ + + :.+ + :.++++ : + :+. +:  ++++ .+ |   
  0.12 |-+ +  ++.+  +   +   + +   +     +  +  +  +     :    +  + +      +   |   
       |                                               +                    |   
   0.1 |-+                                                                  |   
  0.08 |O+ OOOOO OOO    OOO        O  O       O                             |   
       | O          O OO    OOOOO O OO  OO   O OO   O                       |   
  0.06 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
         perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork        
                                                                                
  45 +----------------------------------------------------------------------+   
     | :                 :     :         :     :                            |   
  40 |-:                 :     :         :     :        +                   |   
  35 |-::                :     :         :     ::       :  +                |   
     | ::  +             :     :     +   :     ::       :  :      +         |   
  30 |:+:  :            : :   : :    :  : :   : :     + ::: :     :         |   
  25 |:+:  :    +    +  : :   : :  + :: : :   : :  + ::: :: :     ::.+++  ++|   
     |:  :: :   :+   :  : :   : :  :: : : :   :  : ::: : +  +    : +    :+  |   
  20 |++ :+ :  +  + : :.+ :+. + :.+ +  :+ :.+ +  :+ +  :     : .+:      +   |   
  15 |-+ +  +.+    ++ +   +  +  +      +  +  +   +     +     ++  +          |   
     |                                                                      |   
  10 |-+                                                                    |   
   5 |-+                                                                    |   
     |OO OOOO OOOO OOOO OOOO OOOO OOOO OOOO OOOO OOO                        |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
          perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork       
                                                                                
   0.5 +--------------------------------------------------------------------+   
  0.45 |-+                +     +         +     +                           |   
       | :                :     :         :     :                           |   
   0.4 |-::               ::    ::        :     :                           |   
  0.35 |-::               ::    ::        :     :                           |   
       |: :              : :   : :       : :   : :                          |   
   0.3 |:+:              : :   : :       : :   : :       + +                |   
  0.25 |:+ : +           :  :  :  :   +. : :   : :  +   : :::     +.        |   
   0.2 |++ :+ ++.++++.++++  :+++  :+++  ++ :.+++ :.+ ++ : + ++.+++  +++++.++|   
       |   +                +     +        +     +     +                    |   
  0.15 |-+                                                                  |   
   0.1 |-+                                                                  |   
       | O  OO    O       O O OO  O  O  O  O   O   O                        |   
  0.05 |O+ O  OO O OO OOOO   O  O  OO O  OO  OO OO  O                       |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
      perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork      
                                                                                
  50 +----------------------------------------------------------------------+   
  45 |-+                 +     +         +     +                            |   
     | :                 :     :         :     :                            |   
  40 |-:                 :     :         :     :        +                   |   
  35 |-::                :     :         :     ::       :  +                |   
     |: :  +            ::    ::     +  ::    : :     + :  :      +         |   
  30 |:+:  :            : :   : :    :: : :   : :  + :: ::: :     :         |   
  25 |:+:  ::   +    +  : :   : :  + :: : :   : :  ::::: :: :     ::.+++ .++|   
  20 |++ :: :   :+.  ::.+ :   + :  ::  :+ :   +  :: +  : +  +   +: +    +   |   
     |   :+ +. +   +: +   :+.+  :.+ +  +  :.++   :+    :     + + +          |   
  15 |-+ +    +     +     +     +         +      +     +      +             |   
  10 |-+                                                                    |   
     |                                                                      |   
   5 |OO OOOO OOOO OOOO OOOO OOOO OOOO OOOO OOOO OOO                        |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork     
                                                                                
  0.22 +--------------------------------------------------------------------+   
       |+                +     +         +     +                            |   
   0.2 |:+               :     :         :     :                            |   
  0.18 |::               ::    ::        ::    ::                           |   
       |:+               :+    :+        :+    :+     +                     |   
  0.16 |-+:            +:  :  :  :      : :   : :     :   +          ++  .+ |   
       |  :  +    +    ::  :  :  :   +  :  :  :  :   : :  : +        : ++  +|   
  0.14 |-+ ++ + .+:    :+   +++   +++ +.+  +.++  +.+++ :.+ :::      +       |   
       |       +   :+.:                                +   : +.+++ +        |   
  0.12 |-+         +  +                                    +      +         |   
   0.1 |-+                                                                  |   
       |                                                                    |   
  0.08 |O+  O     OOO    O  O  O     O    O  O   O  O                       |   
       |   O OOO O    OO  O  OO O OOO O O  O  OO   O                        |   
  0.06 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
       perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork  
                                                                                
  18000 +-------------------------------------------------------------------+   
        |                                O       O                          |   
  16000 |-+ OOO O  O     OO  O O OOO OO O  O   O  O                         |   
  14000 |O+    O  O OOO O  OO   O      O     OO     O                       |   
        |                                                                   |   
  12000 |-+                                                                 |   
        |                                                                   |   
  10000 |-+                                                                 |   
        |                                                                   |   
   8000 |-+           +                                                     |   
   6000 |-+ +   +.    :: +  + .+  +     +   + +   +     +      + +          |   
        |: : + +  +  + : :: :+  : :+. + ::  :+ :  :+ +. ::   .+ :::         |   
   4000 |++:  +    ++   + +:    +:   + : +.:   +.:  +  + ++++   + +.+ +++.+ |   
        | +                +     +     +   +     +                   +     +|   
   2000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  0.6 +---------------------------------------------------------------------+   
      | +                 +     +     :   +     +       +  +      +         |   
  0.5 |-:        +       ::     :     :  ::     :       :: ::     :         |   
      |: :       :+.     ::    ::    ::  ::    ::       ::: +     ::        |   
      |+ :  + .+:   +   +  :   + : +.+ :+  :   + : +.   : +  :    :+.+   .++|   
  0.4 |:+: + +  +    :+ :  :+  : :+    ::  :+  : :+  + :     + .+:    + +   |   
      |:  ::         +: :  :: :  ::    ::  :: :  ::   +:      + ::     +    |   
  0.3 |-+ +            :   + ::  +     :   + ::  +     :         :          |   
      |                +     +         +     +         +         +          |   
  0.2 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
  0.1 |-+                                                                   |   
      |OO OOOO OOOO OOOOO OOOO OOOOO OOOO OOOO OOOOO                        |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  450 +---------------------------------------------------------------------+   
      | +                 +     +         +     +                           |   
  400 |-:                 :     :         :     :                           |   
  350 |-::               ::     :        ::     :                           |   
      | ::               ::     :     +  ::     :       +  +      +         |   
  300 |:+:  +     +      : :   : :    :  : :   : :      :+ :      :    +    |   
  250 |:+:  :    + :     : :   : :    :  : :   : :    + : + :     ::   :  + |   
      |:  :: :   : :    :  :   : : + : ::  :   : : +. ::    +    : :.+: :+ :|   
  200 |++ :+ +. +   : + +  :+ .+ :+ +: :+  :+ .+ :+  + :     : .+: +  + +  +|   
  150 |-+ +    +    ++ +   + +   +   + +   + +   +     +     ++  +          |   
      |                                                                     |   
  100 |-+                                                                   |   
   50 |-+                                                                   |   
      |   O O       OO    OO O O O O OOO  OOOO O OOO                        |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  800 +---------------------------------------------------------------------+   
      |       +:       +     +         +     +                   +          |   
  700 |-+.++ +  :   ++ :   ++ :  ++  + :   ++ :  ++    +     ++  :          |   
  600 |:+  : :  +  : : :: +   : + :  : :: +   : + :    :     : : ::         |   
      |::   ::  :  : : ::+     :: : : : :+     :: :    ::    : :: :         |   
  500 |++   :    :+   : +      +   :: : +      +   : + :+   :   + ++.   +   |   
      |     +    +    :            :  +            :+::  + +:        +  :+ +|   
  400 |-+             :            +               +  :   + +         ++  + |   
      |               +                               +                     |   
  300 |-+                                                                   |   
  200 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  12 +----------------------------------------------------------------------+   
     |                                                                      |   
  10 |-+                                                                    |   
     |                                                                      |   
     |                                                                      |   
   8 |-+                                                                    |   
     |                                                                      |   
   6 |-+                                                                    |   
     |                                                                      |   
   4 |-+                                                                    |   
     |                                                                      |   
     |                                                                      |   
   2 |-+.                +     +         +     +.    .+        .+           |   
     |+  ++++.++++.++++.+ ++.++ +.++++.++ +.+++  ++++  +++.++++  +++.++++.++|   
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


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.14.0-rc4-00039-g2112f5c1330a"

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

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='fxmark'
	export testcase='fxmark'
	export category='benchmark'
	export media='hdd'
	export job_origin='fxmark-lkp-knm-part2.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-knm02'
	export tbox_group='lkp-knm02'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='6110afc66c24473bccdd4fd5'
	export job_file='/lkp/jobs/scheduled/lkp-knm02/fxmark-performance-directio-1HDD-ext4_no_jnl-hdd-DWTL-ucode=0x11-debian-10.4-x86_64-20200603.cgz-2112f5c1330a671fa852051d85cb9ea-20210809-15308-p7kni6-3.yaml'
	export id='1b8b3747f988376a9a17892b70e6fa58bd768118'
	export queuer_version='/lkp-src'
	export model='Knights Mill'
	export nr_node=2
	export nr_cpu=272
	export memory='112G'
	export nr_hdd_partitions=1
	export nr_ssd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD1004FBYZ-01YCBB0_WD-WMC6M0D8D9PD-part1'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BG012T4_BTHC428201ZX1P2OGN-part2'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BG012T4_BTHC428201ZX1P2OGN-part1'
	export brand='Intel(R) Xeon Phi(TM) CPU 7255 @ 1.10GHz'
	export need_kconfig='BLK_DEV_SD
SCSI
{"BLOCK"=>"y"}
SATA_AHCI
SATA_AHCI_PLATFORM
ATA
{"PCI"=>"y"}
{"F2FS_FS"=>"m"}'
	export commit='2112f5c1330a671fa852051d85cb9eadc05d7eb7'
	export netconsole_port=6684
	export need_kconfig_hw='{"IGB"=>"y"}
SATA_AHCI'
	export ucode='0x11'
	export bisect_dmesg=true
	export enqueue_time='2021-08-09 12:32:06 +0800'
	export _id='6110afc66c24473bccdd4fd5'
	export _rt='/result/fxmark/performance-directio-1HDD-ext4_no_jnl-hdd-DWTL-ucode=0x11/lkp-knm02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2112f5c1330a671fa852051d85cb9eadc05d7eb7'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='a34addbb05d85a15497310d77bfc5fb18cbd3677'
	export base_commit='c500bee1c5b2f1d59b1081ac879d73268ab0ff17'
	export branch='linux-next/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/fxmark/performance-directio-1HDD-ext4_no_jnl-hdd-DWTL-ucode=0x11/lkp-knm02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2112f5c1330a671fa852051d85cb9eadc05d7eb7/3'
	export scheduler_version='/lkp/lkp/.src-20210805-235047'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-knm02/fxmark-performance-directio-1HDD-ext4_no_jnl-hdd-DWTL-ucode=0x11-debian-10.4-x86_64-20200603.cgz-2112f5c1330a671fa852051d85cb9ea-20210809-15308-p7kni6-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-next/master
commit=2112f5c1330a671fa852051d85cb9eadc05d7eb7
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/2112f5c1330a671fa852051d85cb9eadc05d7eb7/vmlinuz-5.14.0-rc4-00039-g2112f5c1330a
max_uptime=2100
RESULT_ROOT=/result/fxmark/performance-directio-1HDD-ext4_no_jnl-hdd-DWTL-ucode=0x11/lkp-knm02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2112f5c1330a671fa852051d85cb9eadc05d7eb7/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/2112f5c1330a671fa852051d85cb9eadc05d7eb7/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fxmark_20210701.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/fxmark-x86_64-0ce9491-1_20210701.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20210621.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-85a90500f9a1-1_20210807.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.14.0-rc4-00941-ga34addbb05d8'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/2112f5c1330a671fa852051d85cb9eadc05d7eb7/vmlinuz-5.14.0-rc4-00039-g2112f5c1330a'
	export dequeue_time='2021-08-09 12:34:37 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-knm02/fxmark-performance-directio-1HDD-ext4_no_jnl-hdd-DWTL-ucode=0x11-debian-10.4-x86_64-20200603.cgz-2112f5c1330a671fa852051d85cb9ea-20210809-15308-p7kni6-3.cgz'

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
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='DWTL' fstype='ext4_no_jnl' directio='directio' $LKP_SRC/tests/wrapper fxmark
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='DWTL' fstype='ext4_no_jnl' directio='directio' $LKP_SRC/stats/wrapper fxmark
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

	$LKP_SRC/stats/wrapper time fxmark.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/fxmark-lkp-knm-part2.yaml:
suite: fxmark
testcase: fxmark
category: benchmark
disk: 1HDD
media: hdd
fxmark:
  test: DWTL
  fstype: ext4_no_jnl
  directio: directio
job_origin: fxmark-lkp-knm-part2.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-knm02
tbox_group: lkp-knm02
kconfig: x86_64-rhel-8.3
submit_id: 61105cc36c244710ff673d7f
job_file: "/lkp/jobs/scheduled/lkp-knm02/fxmark-performance-directio-1HDD-ext4_no_jnl-hdd-DWTL-ucode=0x11-debian-10.4-x86_64-20200603.cgz-2112f5c1330a671fa852051d85cb9ea-20210809-4351-1x341bq-0.yaml"
id: d61ad4e8eb0970e432297a74f3bc1b35d784e3b0
queuer_version: "/lkp-src"
:#! hosts/lkp-knm02:
model: Knights Mill
nr_node: 2
nr_cpu: 272
memory: 112G
nr_hdd_partitions: 1
nr_ssd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD1004FBYZ-01YCBB0_WD-WMC6M0D8D9PD-part1"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BG012T4_BTHC428201ZX1P2OGN-part2"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BG012T4_BTHC428201ZX1P2OGN-part1"
brand: Intel(R) Xeon Phi(TM) CPU 7255 @ 1.10GHz
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
:#! include/disk/nr_hdd:
need_kconfig:
- BLK_DEV_SD
- SCSI
- BLOCK: y
- SATA_AHCI
- SATA_AHCI_PLATFORM
- ATA
- PCI: y
- F2FS_FS: m
:#! include/fxmark:
:#! include/queue/cyclic:
commit: 2112f5c1330a671fa852051d85cb9eadc05d7eb7
:#! include/testbox/lkp-knm02:
netconsole_port: 6684
need_kconfig_hw:
- IGB: y
- SATA_AHCI
ucode: '0x11'
bisect_dmesg: true
enqueue_time: 2021-08-09 06:37:55.428060956 +08:00
_id: 61105cc36c244710ff673d7f
_rt: "/result/fxmark/performance-directio-1HDD-ext4_no_jnl-hdd-DWTL-ucode=0x11/lkp-knm02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2112f5c1330a671fa852051d85cb9eadc05d7eb7"
:#! schedule options:
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: a34addbb05d85a15497310d77bfc5fb18cbd3677
base_commit: c500bee1c5b2f1d59b1081ac879d73268ab0ff17
branch: linux-devel/devel-hourly-20210808-180330
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/fxmark/performance-directio-1HDD-ext4_no_jnl-hdd-DWTL-ucode=0x11/lkp-knm02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2112f5c1330a671fa852051d85cb9eadc05d7eb7/0"
scheduler_version: "/lkp/lkp/.src-20210805-235047"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-knm02/fxmark-performance-directio-1HDD-ext4_no_jnl-hdd-DWTL-ucode=0x11-debian-10.4-x86_64-20200603.cgz-2112f5c1330a671fa852051d85cb9ea-20210809-4351-1x341bq-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210808-180330
- commit=2112f5c1330a671fa852051d85cb9eadc05d7eb7
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/2112f5c1330a671fa852051d85cb9eadc05d7eb7/vmlinuz-5.14.0-rc4-00039-g2112f5c1330a
- max_uptime=2100
- RESULT_ROOT=/result/fxmark/performance-directio-1HDD-ext4_no_jnl-hdd-DWTL-ucode=0x11/lkp-knm02/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2112f5c1330a671fa852051d85cb9eadc05d7eb7/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/2112f5c1330a671fa852051d85cb9eadc05d7eb7/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fxmark_20210701.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/fxmark-x86_64-0ce9491-1_20210701.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20210621.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-85a90500f9a1-1_20210807.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /lkp/lkp/.src-20210805-235047/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.14.0-rc4-00328-g305c807d4d8e
repeat_to: 3
:#! user overrides:
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/2112f5c1330a671fa852051d85cb9eadc05d7eb7/vmlinuz-5.14.0-rc4-00039-g2112f5c1330a"
dequeue_time: 2021-08-09 07:18:31.356610656 +08:00
job_state: finished
loadavg: 2.74 4.37 2.36 1/1970 16308
start_time: '1628464949'
end_time: '1628465138'
version: "/lkp/lkp/.src-20210805-235118:80117160:3ef0da8f0"

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done


--4Ckj6UjgE2iN1+kY--
