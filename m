Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F60039104B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhEZGF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:05:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:9508 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231185AbhEZGF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:05:56 -0400
IronPort-SDR: 7SNI+x1nLLjDXOqy2q7sOeplRm6ayhsdg9bTNJbCIF8K/5yECVDeTUGWo6Yp7bf+fWXNMvAbd8
 ywweYd/XvaZg==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="202426857"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="202426857"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 23:04:20 -0700
IronPort-SDR: buLIKocDMc5LlNexRjFiBGKoTguT3XQAEBnVAHOHq3QZv45ngZ1uZsGV11IjDzD5ITrf8HgmAm
 M4aq+7bBqR8Q==
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="547069514"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 23:04:16 -0700
Date:   Wed, 26 May 2021 14:20:56 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, yujie.liu@intel.com
Subject: Re: [entry]  47b8ff194c:  will-it-scale.per_process_ops -3.0%
 regression
Message-ID: <20210526062056.GA23957@xsang-OptiPlex-9020>
References: <20210428071653.GC13086@xsang-OptiPlex-9020>
 <YJzhCX/CqrMQDB+y@hirez.programming.kicks-ass.net>
 <20210513174636.GB975577@paulmck-ThinkPad-P17-Gen-1>
 <20210513231127.GA165500@lothringen>
 <YJ5NQtTdQm29dO9p@hirez.programming.kicks-ass.net>
 <20210519052700.GC29704@xsang-OptiPlex-9020>
 <20210523132639.GB173496@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210523132639.GB173496@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frederic,

On Sun, May 23, 2021 at 03:26:39PM +0200, Frederic Weisbecker wrote:
> On Wed, May 19, 2021 at 01:27:00PM +0800, Oliver Sang wrote:
> > hi, Peter Zijlstra,
> > 
> > On Fri, May 14, 2021 at 12:13:22PM +0200, Peter Zijlstra wrote:
> > > On Fri, May 14, 2021 at 01:11:27AM +0200, Frederic Weisbecker wrote:
> > > 
> > > > That sounds good, but two things:
> > > > 
> > > > 1) Even if context tracking is not running, we still need to handle
> > > >    deferred wakeups on idle. But all user/guest/idle currently use the
> > > >    same function.
> > > > 
> > > > 2) Context tracking may be running even when full nohz is not. But here only
> > > >    full nohz is concerned.
> > > > 
> > > > So the change should rather be as follows (completely untested!).
> > > > I rather put the static key check in tick.h in order not to involve
> > > > deep dependencies inside rcupdate.h (especially rcupdate.h -> tick.h -> sched.h)
> > > 
> > > Compiles and boots for me, 0day folks, could you please test this makes
> > > the reported regression go away?
> > 
> > sorry for late.
> > 
> > on which base should we apply below patch?
> > we tried to apply upon 4ae7dc97f726e ("entry/kvm: Explicitly flush pending rcuog
> > wakeup before last rescheduling point") and v5.12, but both build failed like below:
> > 
> > ERROR: modpost: "tick_nohz_full_mask" [arch/x86/kvm/kvm.ko] undefined!
> > 
> > or is there any particular kconfig need to enable?
> > (the kconfig which we used to build 47b8ff194c is in original report
> > which maybe you could help have a look what we may miss)
> 
> Ah indeed I need to export tick_nohz_full_mask. Too bad but that's the fate
> of many cpu masks anyway. Can you try the following patch instead? It boots
> and seem to behave:

we applied below patch upon v5.12, and got 1.8% improvement.
however, though the data is stable in multi runs for either v5.12 or the patched
kernel, please be noted that according to our experience the will-it-scale is
sensitive test suite that the data is easy to fructuate among different commits,
so we normally won't report a will-it-scale performance change if it's <3%.

e.g. we also tried to apply the patch to 4ae7dc97f726e ("entry/kvm: Explicitly flush
pending rcuog wakeup before last rescheduling point") (child of 47b8ff194c), then
we got -1.9 regression.

below is the detail comparison between v5.12 and patched kernel.

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/process/100%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2ap2/futex3/will-it-scale/0x5003006

commit: 
  v5.12
  7fbca1fc8281 (v5.12 + below patch)

           v5.12 7fbca1fc82818c12e55f6406110 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.201e+09            +1.8%  1.223e+09        will-it-scale.192.processes
      0.15 ±  3%      +0.8%       0.15 ±  3%  will-it-scale.192.processes_idle
   6256931            +1.8%    6369346        will-it-scale.per_process_ops
    301.59            +0.0%     301.61        will-it-scale.time.elapsed_time
    301.59            +0.0%     301.61        will-it-scale.time.elapsed_time.max
      1.54 ± 48%     +30.0%       2.00 ± 44%  will-it-scale.time.involuntary_context_switches
      0.46 ±161%     -13.3%       0.40 ±165%  will-it-scale.time.major_page_faults
      9680            +0.1%       9694        will-it-scale.time.maximum_resident_set_size
      6510            -0.2%       6495        will-it-scale.time.minor_page_faults
      4096            +0.0%       4096        will-it-scale.time.page_size
      0.03 ± 20%      -6.1%       0.03 ± 18%  will-it-scale.time.system_time
      0.03 ± 15%      -2.5%       0.03        will-it-scale.time.user_time
     85.54            +0.2%      85.70        will-it-scale.time.voluntary_context_switches
 1.201e+09            +1.8%  1.223e+09        will-it-scale.workload
    344.79            -0.7%     342.28        uptime.boot
      7101 ±  8%      -7.7%       6557 ±  6%  uptime.idle
     39.12 ±  3%      -3.2%      37.85 ±  5%  boot-time.boot
     26.45            -2.6%      25.77 ±  6%  boot-time.dhcp
      6014 ±  5%      -4.5%       5742 ±  6%  boot-time.idle
      1.72            +0.2%       1.73        boot-time.smp_boot
      6.89 ±  3%      +0.0        6.92 ±  5%  mpstat.cpu.all.idle%
      1.13 ±  6%      -0.1        1.06 ±  9%  mpstat.cpu.all.irq%
      0.01 ±  3%      +0.0        0.01 ±  6%  mpstat.cpu.all.soft%
     61.77            +1.8       63.59        mpstat.cpu.all.sys%
     30.21            -1.8       28.42        mpstat.cpu.all.usr%
   2537878 ± 80%     -20.0%    2030688 ± 39%  cpuidle.C1.time
     58450 ±159%     -21.9%      45633 ± 48%  cpuidle.C1.usage
 2.984e+08 ± 28%      +5.3%  3.141e+08 ± 69%  cpuidle.C1E.time
    627221 ± 28%     +20.1%     753509 ± 56%  cpuidle.C1E.usage
 1.099e+08 ± 77%     +31.9%  1.449e+08 ± 90%  cpuidle.C6.time
    243896 ± 58%     +28.4%     313191 ± 55%  cpuidle.C6.usage
     68908 ±171%     -72.0%      19272 ± 13%  cpuidle.POLL.time
      6363 ± 66%     -31.6%       4355 ± 15%  cpuidle.POLL.usage
      1.00            +0.0%       1.00        vmstat.cpu.id
     66.00            +2.9%      67.90        vmstat.cpu.sy
     31.15            -4.3%      29.80        vmstat.cpu.us
      0.00          -100.0%       0.00        vmstat.io.bi
   1764017            +0.3%    1768725        vmstat.memory.cache
 1.939e+08            -0.0%  1.938e+08        vmstat.memory.free
    190.00            -0.1%     189.80        vmstat.procs.r
      2082            +1.2%       2108        vmstat.system.cs
    392472            +0.2%     393138        vmstat.system.in
    301.59            +0.0%     301.61        time.elapsed_time
    301.59            +0.0%     301.61        time.elapsed_time.max
      1.54 ± 48%     +30.0%       2.00 ± 44%  time.involuntary_context_switches
      0.46 ±161%     -13.3%       0.40 ±165%  time.major_page_faults
      9680            +0.1%       9694        time.maximum_resident_set_size
      6510            -0.2%       6495        time.minor_page_faults
      4096            +0.0%       4096        time.page_size
      0.03 ± 20%      -6.1%       0.03 ± 18%  time.system_time
      0.03 ± 15%      -2.5%       0.03        time.user_time
     85.54            +0.2%      85.70        time.voluntary_context_switches
      0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
    221542 ± 12%     +10.1%     244013 ± 15%  numa-numastat.node0.local_node
    291480 ±  2%      +2.2%     297889 ±  3%  numa-numastat.node0.numa_hit
     69941 ± 30%     -22.9%      53895 ± 52%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
    244854 ± 18%      -5.9%     230514 ± 14%  numa-numastat.node1.local_node
    300092 ±  3%      -0.7%     297989 ±  3%  numa-numastat.node1.numa_hit
     55245 ± 61%     +22.1%      67479 ± 38%  numa-numastat.node1.other_node
      0.00          -100.0%       0.00        numa-numastat.node2.interleave_hit
    227179 ± 15%      +2.6%     232992 ± 14%  numa-numastat.node2.local_node
    290033 ±  3%      +1.0%     293075 ±  2%  numa-numastat.node2.numa_hit
     62857 ± 42%      -4.4%      60090 ± 43%  numa-numastat.node2.other_node
      0.00          -100.0%       0.00        numa-numastat.node3.interleave_hit
    405272 ±  8%      -1.7%     398305 ±  6%  numa-numastat.node3.local_node
    477171            -0.1%     476916        numa-numastat.node3.numa_hit
     71904 ± 37%      +9.3%      78614 ± 25%  numa-numastat.node3.other_node
    390492            +1.2%     395330        meminfo.Active
    390492            +1.2%     395330        meminfo.Active(anon)
    174793 ±  2%      +0.3%     175341        meminfo.AnonHugePages
    391553            +0.3%     392840        meminfo.AnonPages
   1629171            +0.4%    1635090        meminfo.Cached
    189912            +0.0%     189912        meminfo.CmaFree
    204800            +0.0%     204800        meminfo.CmaTotal
  98857488            -0.0%   98857484        meminfo.CommitLimit
  11744472            -0.1%   11738185        meminfo.Committed_AS
 1.881e+08            -0.0%   1.88e+08        meminfo.DirectMap1G
  13601398 ±  5%      +0.6%   13688627 ±  7%  meminfo.DirectMap2M
   1408295 ±  3%      +0.1%    1409792 ±  3%  meminfo.DirectMap4k
      2048            +0.0%       2048        meminfo.Hugepagesize
    451969            +0.2%     452884        meminfo.Inactive
    451969            +0.2%     452884        meminfo.Inactive(anon)
      0.00          -100.0%       0.00        meminfo.Inactive(file)
    133644            -0.7%     132741        meminfo.KReclaimable
     32470            +0.8%      32738        meminfo.KernelStack
    104517            -0.4%     104144 ±  2%  meminfo.Mapped
 1.932e+08            -0.0%  1.932e+08        meminfo.MemAvailable
 1.939e+08            -0.0%  1.938e+08        meminfo.MemFree
 1.977e+08            -0.0%  1.977e+08        meminfo.MemTotal
   3856511            +0.4%    3870202        meminfo.Memused
    533.92 ±150%     +62.3%     866.80 ±100%  meminfo.Mlocked
     30463            +0.0%      30470        meminfo.PageTables
    107096            +0.5%     107664        meminfo.Percpu
    133644            -0.7%     132741        meminfo.SReclaimable
    302192            -0.3%     301269        meminfo.SUnreclaim
    451244            +1.0%     455780        meminfo.Shmem
    435836            -0.4%     434011        meminfo.Slab
   1178004            +0.1%    1179435        meminfo.Unevictable
 3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
    315329            +0.3%     316149        meminfo.VmallocUsed
   4737681 ±  2%      +0.6%    4764300        meminfo.max_used_kB
      0.00          -100.0%       0.00        proc-vmstat.compact_isolated
     97650            +1.2%      98788        proc-vmstat.nr_active_anon
     97845            +0.4%      98203        proc-vmstat.nr_anon_pages
     84.85            +0.4%      85.20        proc-vmstat.nr_anon_transparent_hugepages
   4821126            -0.0%    4820765        proc-vmstat.nr_dirty_background_threshold
   9654041            -0.0%    9653318        proc-vmstat.nr_dirty_threshold
    407385            +0.4%     408818        proc-vmstat.nr_file_pages
     47478            +0.0%      47478        proc-vmstat.nr_free_cma
  48464773            -0.0%   48461156        proc-vmstat.nr_free_pages
    113008            +0.3%     113305        proc-vmstat.nr_inactive_anon
      0.00          -100.0%       0.00        proc-vmstat.nr_inactive_file
     32461            +0.8%      32735        proc-vmstat.nr_kernel_stack
     26121            +0.2%      26171 ±  2%  proc-vmstat.nr_mapped
    133.46 ±150%     +62.4%     216.70 ±100%  proc-vmstat.nr_mlock
      7606            +0.1%       7613        proc-vmstat.nr_page_table_pages
    112903            +1.0%     113991        proc-vmstat.nr_shmem
     33412            -0.7%      33186        proc-vmstat.nr_slab_reclaimable
     75545            -0.3%      75316        proc-vmstat.nr_slab_unreclaimable
    294500            +0.1%     294858        proc-vmstat.nr_unevictable
     97650            +1.2%      98788        proc-vmstat.nr_zone_active_anon
    113008            +0.3%     113305        proc-vmstat.nr_zone_inactive_anon
      0.00          -100.0%       0.00        proc-vmstat.nr_zone_inactive_file
    294500            +0.1%     294858        proc-vmstat.nr_zone_unevictable
     30310 ± 10%      +2.9%      31178 ± 10%  proc-vmstat.numa_hint_faults
     29058 ± 11%      -1.5%      28634 ±  5%  proc-vmstat.numa_hint_faults_local
   1398365            +0.2%    1401605        proc-vmstat.numa_hit
     91.23 ± 38%      -6.1%      85.70 ± 32%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00        proc-vmstat.numa_interleave
   1138401            +0.3%    1141513        proc-vmstat.numa_local
    259963            +0.0%     260092        proc-vmstat.numa_other
     11904 ± 65%     +50.8%      17953 ± 62%  proc-vmstat.numa_pages_migrated
    217937 ±  8%      +1.7%     221590 ± 10%  proc-vmstat.numa_pte_updates
    159869            +0.4%     160579        proc-vmstat.pgactivate
      0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma
      0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
   1485861            +0.9%    1499684        proc-vmstat.pgalloc_normal
   1379355            +0.3%    1383517        proc-vmstat.pgfault
   1394116 ±  4%      +1.8%    1419254 ±  4%  proc-vmstat.pgfree
     11904 ± 65%     +50.8%      17953 ± 62%  proc-vmstat.pgmigrate_success
      0.00          -100.0%       0.00        proc-vmstat.pgpgin
      0.00          -100.0%       0.00        proc-vmstat.pgpgout
     93249            +0.1%      93319        proc-vmstat.pgreuse
     98.69 ±  3%      -1.3%      97.40 ±  2%  proc-vmstat.thp_collapse_alloc
      0.00          -100.0%       0.00        proc-vmstat.thp_deferred_split_page
     30.23            -0.4%      30.10        proc-vmstat.thp_fault_alloc
      0.00          -100.0%       0.00        proc-vmstat.thp_split_pmd
      0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
     52.62 ± 75%     +31.0%      68.90 ± 62%  proc-vmstat.unevictable_pgs_culled
    180.31 ±149%     +62.5%     293.00 ±100%  proc-vmstat.unevictable_pgs_mlocked
      0.04 ± 28%     +12.4%       0.04 ± 63%  perf-stat.i.MPKI
 8.655e+10            -2.5%  8.437e+10        perf-stat.i.branch-instructions
      0.36            +0.0        0.37        perf-stat.i.branch-miss-rate%
 3.025e+08            +2.0%  3.086e+08        perf-stat.i.branch-misses
      9.61 ±  4%      +0.1        9.70 ±  4%  perf-stat.i.cache-miss-rate%
   1359065 ±  3%      +1.5%    1379432 ±  4%  perf-stat.i.cache-misses
  13120805 ±  2%      +0.3%   13161288        perf-stat.i.cache-references
      2037            +1.3%       2063 ±  2%  perf-stat.i.context-switches
      0.99            -0.3%       0.99        perf-stat.i.cpi
    192006            +0.0%     192010        perf-stat.i.cpu-clock
 5.558e+11            -0.2%  5.549e+11        perf-stat.i.cpu-cycles
    270.60            -0.0%     270.59        perf-stat.i.cpu-migrations
    552041 ±  3%      -0.6%     548577 ±  5%  perf-stat.i.cycles-between-cache-misses
      0.00 ± 36%      -0.0        0.00 ± 27%  perf-stat.i.dTLB-load-miss-rate%
    361879 ± 10%      -0.7%     359314 ± 11%  perf-stat.i.dTLB-load-misses
 1.464e+11            +0.0%  1.464e+11        perf-stat.i.dTLB-loads
      0.00 ± 19%      -0.0        0.00 ± 17%  perf-stat.i.dTLB-store-miss-rate%
    275417            -6.7%     256881        perf-stat.i.dTLB-store-misses
 1.103e+11            +0.6%   1.11e+11        perf-stat.i.dTLB-stores
     99.02            +0.8       99.84        perf-stat.i.iTLB-load-miss-rate%
 3.407e+08 ±  8%     +96.1%   6.68e+08 ± 29%  perf-stat.i.iTLB-load-misses
   2804754 ±  6%     -90.0%     279419 ±  9%  perf-stat.i.iTLB-loads
 5.621e+11            +0.4%  5.644e+11        perf-stat.i.instructions
      1696 ±  6%     -43.5%     958.17 ± 36%  perf-stat.i.instructions-per-iTLB-miss
      1.01            +0.5%       1.02        perf-stat.i.ipc
      1.36            -0.7%       1.35        perf-stat.i.major-faults
      2.89            -0.2%       2.89        perf-stat.i.metric.GHz
     66.81 ± 54%      +9.6%      73.23        perf-stat.i.metric.K/sec
      1787            -0.4%       1779        perf-stat.i.metric.M/sec
      4332            +0.5%       4354        perf-stat.i.minor-faults
     88.81            -0.0       88.81        perf-stat.i.node-load-miss-rate%
    260186            -0.4%     259219 ±  3%  perf-stat.i.node-load-misses
    218173 ±  6%      -1.1%     215853 ±  6%  perf-stat.i.node-loads
     93.30            -0.1       93.16        perf-stat.i.node-store-miss-rate%
     94315 ±  2%      -1.1%      93310 ±  3%  perf-stat.i.node-store-misses
     15315 ± 10%      -0.2%      15280 ±  8%  perf-stat.i.node-stores
      4333            +0.5%       4355        perf-stat.i.page-faults
    192006            +0.0%     192010        perf-stat.i.task-clock
      0.02 ±  2%      -0.2%       0.02        perf-stat.overall.MPKI
      0.35            +0.0        0.37        perf-stat.overall.branch-miss-rate%
     10.44 ±  3%      +0.1       10.55 ±  4%  perf-stat.overall.cache-miss-rate%
      0.99            -0.6%       0.98        perf-stat.overall.cpi
    401962 ±  3%      -1.3%     396708 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.00 ± 10%      -0.0        0.00 ± 11%  perf-stat.overall.dTLB-load-miss-rate%
      0.00            -0.0        0.00        perf-stat.overall.dTLB-store-miss-rate%
     99.17            +0.8       99.95        perf-stat.overall.iTLB-load-miss-rate%
      1663 ±  8%     -43.3%     943.36 ± 36%  perf-stat.overall.instructions-per-iTLB-miss
      1.01            +0.6%       1.02        perf-stat.overall.ipc
     51.94 ±  3%      +0.3       52.23 ±  2%  perf-stat.overall.node-load-miss-rate%
     85.93            -0.1       85.85        perf-stat.overall.node-store-miss-rate%
    141098            -1.3%     139251        perf-stat.overall.path-length
 8.626e+10            -2.5%  8.409e+10        perf-stat.ps.branch-instructions
 3.015e+08            +2.0%  3.076e+08        perf-stat.ps.branch-misses
   1379833 ±  3%      +1.3%    1397764 ±  4%  perf-stat.ps.cache-misses
  13219836 ±  2%      +0.2%   13251963        perf-stat.ps.cache-references
      2027            +1.3%       2053 ±  2%  perf-stat.ps.context-switches
    191365            +0.0%     191368        perf-stat.ps.cpu-clock
  5.54e+11            -0.2%  5.531e+11        perf-stat.ps.cpu-cycles
    269.29            -0.0%     269.26        perf-stat.ps.cpu-migrations
    393176 ± 10%      -0.5%     391132 ± 11%  perf-stat.ps.dTLB-load-misses
 1.459e+11            +0.0%  1.459e+11        perf-stat.ps.dTLB-loads
    274888            -6.8%     256273        perf-stat.ps.dTLB-store-misses
 1.099e+11            +0.6%  1.106e+11        perf-stat.ps.dTLB-stores
 3.393e+08 ±  8%     +96.3%  6.661e+08 ± 29%  perf-stat.ps.iTLB-load-misses
   2804478 ±  6%     -90.0%     280958 ±  9%  perf-stat.ps.iTLB-loads
 5.602e+11            +0.4%  5.625e+11        perf-stat.ps.instructions
      1.35            -0.7%       1.34        perf-stat.ps.major-faults
      4325            +0.4%       4344        perf-stat.ps.minor-faults
    259334            -0.4%     258269 ±  3%  perf-stat.ps.node-load-misses
    240460 ±  6%      -1.7%     236472 ±  5%  perf-stat.ps.node-loads
     93985 ±  2%      -1.1%      92946 ±  3%  perf-stat.ps.node-store-misses
     15388 ± 10%      -0.5%      15308 ±  8%  perf-stat.ps.node-stores
      4327            +0.4%       4346        perf-stat.ps.page-faults
    191365            +0.0%     191368        perf-stat.ps.task-clock
 1.695e+14            +0.5%  1.703e+14        perf-stat.total.instructions
      5722 ± 50%      +7.0%       6125 ± 47%  numa-meminfo.node0.Active
      5722 ± 50%      +7.0%       6125 ± 47%  numa-meminfo.node0.Active(anon)
     32877 ± 79%    +131.4%      76066 ± 71%  numa-meminfo.node0.AnonHugePages
     81551 ± 40%     +76.3%     143803 ± 49%  numa-meminfo.node0.AnonPages
    134758 ± 48%     +63.2%     219903 ± 60%  numa-meminfo.node0.AnonPages.max
    306949 ±  5%      +0.8%     309551 ±  7%  numa-meminfo.node0.FilePages
     87693 ± 40%     +68.3%     147552 ± 50%  numa-meminfo.node0.Inactive
     87693 ± 40%     +68.3%     147552 ± 50%  numa-meminfo.node0.Inactive(anon)
      0.00          -100.0%       0.00        numa-meminfo.node0.Inactive(file)
     32382 ± 21%     +23.4%      39949 ± 29%  numa-meminfo.node0.KReclaimable
      8680 ±  5%      +9.1%       9468 ±  6%  numa-meminfo.node0.KernelStack
     21282 ± 20%      -8.0%      19569 ± 16%  numa-meminfo.node0.Mapped
  48298222            -0.2%   48212545        numa-meminfo.node0.MemFree
  49156876            +0.0%   49156876        numa-meminfo.node0.MemTotal
    858652 ±  5%     +10.0%     944329 ± 11%  numa-meminfo.node0.MemUsed
    132.69 ±155%    +115.2%     285.50 ±102%  numa-meminfo.node0.Mlocked
      5341 ±  9%     +14.5%       6113 ± 18%  numa-meminfo.node0.PageTables
     32382 ± 21%     +23.4%      39949 ± 29%  numa-meminfo.node0.SReclaimable
     80364 ± 10%      +9.0%      87620 ± 10%  numa-meminfo.node0.SUnreclaim
     11952 ± 66%     -15.9%      10049 ± 74%  numa-meminfo.node0.Shmem
    112747 ± 11%     +13.1%     127570 ± 14%  numa-meminfo.node0.Slab
    295015 ±  5%      +1.6%     299601 ±  5%  numa-meminfo.node0.Unevictable
      6755 ± 57%      -4.5%       6448 ± 40%  numa-meminfo.node1.Active
      6755 ± 57%      -4.5%       6448 ± 40%  numa-meminfo.node1.Active(anon)
     38156 ±119%     -49.3%      19362 ± 81%  numa-meminfo.node1.AnonHugePages
     94536 ± 64%     -29.3%      66795 ± 37%  numa-meminfo.node1.AnonPages
    249062 ± 72%      -6.4%     233168 ± 73%  numa-meminfo.node1.AnonPages.max
    310195 ±  4%      -2.4%     302630 ±  4%  numa-meminfo.node1.FilePages
    100960 ± 60%     -27.8%      72892 ± 35%  numa-meminfo.node1.Inactive
    100960 ± 60%     -27.8%      72892 ± 35%  numa-meminfo.node1.Inactive(anon)
     34113 ± 26%     -17.2%      28243 ± 33%  numa-meminfo.node1.KReclaimable
      8588 ± 10%     -10.4%       7691 ±  8%  numa-meminfo.node1.KernelStack
     20305 ± 12%      +2.0%      20720 ± 11%  numa-meminfo.node1.Mapped
  48657079            +0.1%   48702771        numa-meminfo.node1.MemFree
  49534456            +0.0%   49534456        numa-meminfo.node1.MemTotal
    877375 ± 12%      -5.2%     831683 ± 10%  numa-meminfo.node1.MemUsed
    116.77 ±150%     +57.9%     184.40 ±100%  numa-meminfo.node1.Mlocked
      7277 ± 13%      -7.1%       6761 ± 12%  numa-meminfo.node1.PageTables
     34113 ± 26%     -17.2%      28243 ± 33%  numa-meminfo.node1.SReclaimable
     76116 ± 15%      -4.3%      72859 ± 19%  numa-meminfo.node1.SUnreclaim
     13231 ± 44%      -4.7%      12613 ± 36%  numa-meminfo.node1.Shmem
    110229 ± 17%      -8.3%     101103 ± 21%  numa-meminfo.node1.Slab
    296967 ±  4%      -2.3%     290016 ±  3%  numa-meminfo.node1.Unevictable
      5358 ± 50%     +15.1%       6169 ± 37%  numa-meminfo.node2.Active
      5358 ± 50%     +15.1%       6169 ± 37%  numa-meminfo.node2.Active(anon)
     51614 ± 99%     -30.5%      35865 ± 92%  numa-meminfo.node2.AnonHugePages
    103401 ± 58%     -18.8%      83916 ± 47%  numa-meminfo.node2.AnonPages
    163478 ± 64%      -9.9%     147235 ± 69%  numa-meminfo.node2.AnonPages.max
    310281 ±  5%      -2.5%     302468 ±  4%  numa-meminfo.node2.FilePages
    109098 ± 55%     -18.7%      88694 ± 43%  numa-meminfo.node2.Inactive
    109098 ± 55%     -18.7%      88694 ± 43%  numa-meminfo.node2.Inactive(anon)
     30670 ± 23%      -2.5%      29898 ± 40%  numa-meminfo.node2.KReclaimable
      7600 ±  9%      +2.4%       7784 ±  6%  numa-meminfo.node2.KernelStack
     21039 ± 11%      -5.0%      19994 ± 11%  numa-meminfo.node2.Mapped
  48684003            +0.1%   48721923        numa-meminfo.node2.MemFree
  49534460            +0.0%   49534460        numa-meminfo.node2.MemTotal
    850455 ± 10%      -4.5%     812535 ±  8%  numa-meminfo.node2.MemUsed
    151.08 ±156%     +37.5%     207.80 ±104%  numa-meminfo.node2.Mlocked
      8179 ±  8%      +0.1%       8190 ± 10%  numa-meminfo.node2.PageTables
     30670 ± 23%      -2.5%      29898 ± 40%  numa-meminfo.node2.SReclaimable
     70756 ± 16%      -5.4%      66922 ± 12%  numa-meminfo.node2.SUnreclaim
     11162 ± 42%      -1.1%      11041 ± 42%  numa-meminfo.node2.Shmem
    101427 ± 16%      -4.5%      96821 ± 19%  numa-meminfo.node2.Slab
    299155 ±  5%      -2.6%     291450 ±  4%  numa-meminfo.node2.Unevictable
    372215            +1.0%     375850        numa-meminfo.node3.Active
    372215            +1.0%     375850        numa-meminfo.node3.Active(anon)
     52125 ± 97%     -15.7%      43950 ± 96%  numa-meminfo.node3.AnonHugePages
    111722 ± 59%     -12.3%      98021 ± 51%  numa-meminfo.node3.AnonPages
    247515 ± 50%      +2.8%     254358 ± 59%  numa-meminfo.node3.AnonPages.max
    701625            +2.6%     719875        numa-meminfo.node3.FilePages
    154210 ± 43%      -6.9%     143611 ± 35%  numa-meminfo.node3.Inactive
    154210 ± 43%      -6.9%     143611 ± 35%  numa-meminfo.node3.Inactive(anon)
     36471 ± 21%      -5.0%      34647 ± 28%  numa-meminfo.node3.KReclaimable
      7589 ±  8%      +2.7%       7793 ±  8%  numa-meminfo.node3.KernelStack
     41527 ±  3%      +3.1%      42821 ±  8%  numa-meminfo.node3.Mapped
  48221530            -0.0%   48210036        numa-meminfo.node3.MemFree
  49489188            -0.0%   49489180        numa-meminfo.node3.MemTotal
   1267656 ±  8%      +0.9%    1279142 ±  6%  numa-meminfo.node3.MemUsed
    131.15 ±155%     +42.7%     187.10 ±100%  numa-meminfo.node3.Mlocked
      9636 ±  6%      -2.5%       9392 ±  6%  numa-meminfo.node3.PageTables
     36471 ± 21%      -5.0%      34647 ± 28%  numa-meminfo.node3.SReclaimable
     74934 ±  9%      -1.4%      73852 ± 14%  numa-meminfo.node3.SUnreclaim
    414777            +1.6%     421511 ±  2%  numa-meminfo.node3.Shmem
    111407 ± 10%      -2.6%     108500 ± 17%  numa-meminfo.node3.Slab
    286865 ±  2%      +4.0%     298365 ±  5%  numa-meminfo.node3.Unevictable
      1429 ± 50%      +7.1%       1530 ± 47%  numa-vmstat.node0.nr_active_anon
     20381 ± 40%     +76.4%      35961 ± 49%  numa-vmstat.node0.nr_anon_pages
     15.46 ± 83%    +137.4%      36.70 ± 72%  numa-vmstat.node0.nr_anon_transparent_hugepages
     76734 ±  5%      +0.8%      77385 ±  7%  numa-vmstat.node0.nr_file_pages
     47478            +0.0%      47478        numa-vmstat.node0.nr_free_cma
  12074419            -0.2%   12053010        numa-vmstat.node0.nr_free_pages
     21915 ± 40%     +68.4%      36898 ± 50%  numa-vmstat.node0.nr_inactive_anon
      0.00          -100.0%       0.00        numa-vmstat.node0.nr_inactive_file
      8684 ±  5%      +9.0%       9469 ±  6%  numa-vmstat.node0.nr_kernel_stack
      5430 ± 20%      -7.7%       5013 ± 16%  numa-vmstat.node0.nr_mapped
     33.08 ±155%    +115.6%      71.30 ±102%  numa-vmstat.node0.nr_mlock
      1337 ±  9%     +14.3%       1528 ± 18%  numa-vmstat.node0.nr_page_table_pages
      2985 ± 66%     -15.9%       2510 ± 74%  numa-vmstat.node0.nr_shmem
      8095 ± 21%     +23.4%       9987 ± 29%  numa-vmstat.node0.nr_slab_reclaimable
     20091 ± 10%      +9.0%      21905 ± 10%  numa-vmstat.node0.nr_slab_unreclaimable
     73753 ±  5%      +1.6%      74899 ±  5%  numa-vmstat.node0.nr_unevictable
      1429 ± 50%      +7.1%       1530 ± 47%  numa-vmstat.node0.nr_zone_active_anon
     21915 ± 40%     +68.4%      36898 ± 50%  numa-vmstat.node0.nr_zone_inactive_anon
      0.00          -100.0%       0.00        numa-vmstat.node0.nr_zone_inactive_file
     73753 ±  5%      +1.6%      74899 ±  5%  numa-vmstat.node0.nr_zone_unevictable
    634084 ± 10%     +11.5%     707033 ± 13%  numa-vmstat.node0.numa_hit
     88030            +0.2%      88172        numa-vmstat.node0.numa_interleave
    543602 ± 14%     +12.6%     612215 ± 20%  numa-vmstat.node0.numa_local
     90481 ± 33%      +4.8%      94817 ± 47%  numa-vmstat.node0.numa_other
      1687 ± 57%      -4.4%       1612 ± 40%  numa-vmstat.node1.nr_active_anon
     23640 ± 64%     -29.5%      16673 ± 36%  numa-vmstat.node1.nr_anon_pages
     18.15 ±121%     -49.9%       9.10 ± 85%  numa-vmstat.node1.nr_anon_transparent_hugepages
     77545 ±  4%      -2.4%      75656 ±  4%  numa-vmstat.node1.nr_file_pages
  12164118            +0.1%   12175593        numa-vmstat.node1.nr_free_pages
     25242 ± 60%     -27.9%      18196 ± 35%  numa-vmstat.node1.nr_inactive_anon
      8591 ± 10%     -10.5%       7692 ±  8%  numa-vmstat.node1.nr_kernel_stack
      5163 ± 12%      +2.7%       5302 ± 11%  numa-vmstat.node1.nr_mapped
     29.15 ±150%     +57.8%      46.00 ±100%  numa-vmstat.node1.nr_mlock
      1821 ± 13%      -7.1%       1691 ± 12%  numa-vmstat.node1.nr_page_table_pages
      3304 ± 44%      -4.6%       3151 ± 36%  numa-vmstat.node1.nr_shmem
      8527 ± 26%     -17.2%       7060 ± 33%  numa-vmstat.node1.nr_slab_reclaimable
     19029 ± 15%      -4.3%      18214 ± 19%  numa-vmstat.node1.nr_slab_unreclaimable
     74241 ±  4%      -2.3%      72503 ±  3%  numa-vmstat.node1.nr_unevictable
      1687 ± 57%      -4.4%       1612 ± 40%  numa-vmstat.node1.nr_zone_active_anon
     25242 ± 60%     -27.9%      18196 ± 35%  numa-vmstat.node1.nr_zone_inactive_anon
     74241 ±  4%      -2.3%      72503 ±  3%  numa-vmstat.node1.nr_zone_unevictable
    721222 ± 12%      -6.8%     671922 ± 14%  numa-vmstat.node1.numa_hit
     87980            +0.0%      88022        numa-vmstat.node1.numa_interleave
    569026 ± 18%      -9.6%     514448 ± 19%  numa-vmstat.node1.numa_local
    152195 ± 22%      +3.5%     157472 ± 18%  numa-vmstat.node1.numa_other
      1338 ± 50%     +15.2%       1542 ± 37%  numa-vmstat.node2.nr_active_anon
     25865 ± 58%     -18.8%      20995 ± 47%  numa-vmstat.node2.nr_anon_pages
     24.69 ±100%     -31.6%      16.90 ± 96%  numa-vmstat.node2.nr_anon_transparent_hugepages
     77568 ±  5%      -2.5%      75615 ±  4%  numa-vmstat.node2.nr_file_pages
  12170848            +0.1%   12180348        numa-vmstat.node2.nr_free_pages
     27289 ± 55%     -18.7%      22188 ± 43%  numa-vmstat.node2.nr_inactive_anon
      7603 ±  9%      +2.4%       7786 ±  6%  numa-vmstat.node2.nr_kernel_stack
      5355 ± 11%      -4.0%       5142 ± 11%  numa-vmstat.node2.nr_mapped
     37.69 ±156%     +37.7%      51.90 ±104%  numa-vmstat.node2.nr_mlock
      2046 ±  8%      +0.1%       2049 ± 10%  numa-vmstat.node2.nr_page_table_pages
      2788 ± 42%      -1.1%       2758 ± 42%  numa-vmstat.node2.nr_shmem
      7667 ± 23%      -2.5%       7474 ± 40%  numa-vmstat.node2.nr_slab_reclaimable
     17689 ± 16%      -5.4%      16730 ± 12%  numa-vmstat.node2.nr_slab_unreclaimable
     74788 ±  5%      -2.6%      72862 ±  4%  numa-vmstat.node2.nr_unevictable
      1338 ± 50%     +15.2%       1542 ± 37%  numa-vmstat.node2.nr_zone_active_anon
     27289 ± 55%     -18.7%      22188 ± 43%  numa-vmstat.node2.nr_zone_inactive_anon
     74788 ±  5%      -2.6%      72862 ±  4%  numa-vmstat.node2.nr_zone_unevictable
    688164 ± 16%      -6.7%     641941 ± 12%  numa-vmstat.node2.numa_hit
     88030            +0.1%      88159        numa-vmstat.node2.numa_interleave
    533664 ± 24%      -9.1%     485057 ± 21%  numa-vmstat.node2.numa_local
    154499 ± 20%      +1.5%     156883 ± 16%  numa-vmstat.node2.numa_other
     93120            +1.0%      94094        numa-vmstat.node3.nr_active_anon
     27937 ± 59%     -12.3%      24502 ± 51%  numa-vmstat.node3.nr_anon_pages
     25.00 ± 99%     -15.6%      21.10 ± 98%  numa-vmstat.node3.nr_anon_transparent_hugepages
    175407            +2.6%     180049        numa-vmstat.node3.nr_file_pages
  12055232            -0.0%   12052311        numa-vmstat.node3.nr_free_pages
     38493 ± 44%      -6.9%      35848 ± 35%  numa-vmstat.node3.nr_inactive_anon
      0.00          -100.0%       0.00        numa-vmstat.node3.nr_isolated_anon
      7592 ±  8%      +2.7%       7795 ±  8%  numa-vmstat.node3.nr_kernel_stack
     10264 ±  4%      +3.9%      10662 ±  7%  numa-vmstat.node3.nr_mapped
     32.77 ±155%     +42.8%      46.80 ±100%  numa-vmstat.node3.nr_mlock
      2411 ±  6%      -2.6%       2349 ±  6%  numa-vmstat.node3.nr_page_table_pages
    103695            +1.7%     105458 ±  2%  numa-vmstat.node3.nr_shmem
      9119 ± 21%      -5.0%       8663 ± 28%  numa-vmstat.node3.nr_slab_reclaimable
     18733 ±  9%      -1.4%      18462 ± 14%  numa-vmstat.node3.nr_slab_unreclaimable
     71716 ±  2%      +4.0%      74590 ±  5%  numa-vmstat.node3.nr_unevictable
     93120            +1.0%      94094        numa-vmstat.node3.nr_zone_active_anon
     38493 ± 44%      -6.9%      35848 ± 35%  numa-vmstat.node3.nr_zone_inactive_anon
     71716 ±  2%      +4.0%      74590 ±  5%  numa-vmstat.node3.nr_zone_unevictable
    760122 ± 10%      +6.8%     811965 ± 14%  numa-vmstat.node3.numa_hit
     87977            +0.0%      88007        numa-vmstat.node3.numa_interleave
    604518 ± 13%     +10.5%     667796 ± 18%  numa-vmstat.node3.numa_local
    155603 ± 20%      -7.3%     144168 ± 24%  numa-vmstat.node3.numa_other
      1.48            -1.5        0.00        perf-profile.calltrace.cycles-pp.rcu_nocb_flush_deferred_wakeup.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.syscall
      8.79            -1.4        7.35        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.syscall
      5.74            -1.3        4.47        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.syscall
      2.08            -0.1        1.96        perf-profile.calltrace.cycles-pp.testcase
     53.90            -0.0       53.85        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      5.88            +0.0        5.89        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.syscall
      2.16            +0.0        2.20        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.syscall
      2.06            +0.0        2.10        perf-profile.calltrace.cycles-pp.syscall_enter_from_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.88            +0.1        1.98        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.syscall
     97.75            +0.2       97.93        perf-profile.calltrace.cycles-pp.syscall
      8.97            +0.2        9.20        perf-profile.calltrace.cycles-pp.hash_futex.futex_wake.do_futex.__x64_sys_futex.do_syscall_64
     30.96            +0.4       31.32        perf-profile.calltrace.cycles-pp.__entry_text_start.syscall
      5.09            +0.7        5.80        perf-profile.calltrace.cycles-pp.get_futex_key.futex_wake.do_futex.__x64_sys_futex.do_syscall_64
     23.42            +0.8       24.20        perf-profile.calltrace.cycles-pp.futex_wake.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
     28.94            +1.0       29.98        perf-profile.calltrace.cycles-pp.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     34.20            +1.4       35.56        perf-profile.calltrace.cycles-pp.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     38.11            +1.5       39.57        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.55            -1.5        0.00        perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      6.02            -1.5        4.52        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      9.43            -1.4        8.00        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      2.25            -0.2        2.10        perf-profile.children.cycles-pp.testcase
      0.51 ±  2%      -0.1        0.45 ±  2%  perf-profile.children.cycles-pp.syscall@plt
      0.86 ±  4%      -0.0        0.81 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.80 ±  4%      -0.0        0.76 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     54.33            -0.0       54.28        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.74 ±  4%      -0.0        0.70 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.74 ±  4%      -0.0        0.70 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.12 ± 14%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.12 ± 26%      -0.0        0.10 ± 24%  perf-profile.children.cycles-pp.ktime_get
      0.04 ± 55%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.process_simple
      0.04 ± 55%      -0.0        0.03 ±101%  perf-profile.children.cycles-pp.cmd_sched
      0.05 ± 55%      -0.0        0.03 ± 83%  perf-profile.children.cycles-pp.__libc_start_main
      0.05 ± 55%      -0.0        0.03 ± 83%  perf-profile.children.cycles-pp.main
      0.05 ± 55%      -0.0        0.03 ± 83%  perf-profile.children.cycles-pp.run_builtin
      0.05 ± 56%      -0.0        0.04 ± 82%  perf-profile.children.cycles-pp.cmd_record
      0.03 ± 79%      -0.0        0.02 ±123%  perf-profile.children.cycles-pp.ordered_events__queue
      0.03 ± 79%      -0.0        0.02 ±123%  perf-profile.children.cycles-pp.queue_event
      0.05 ± 55%      -0.0        0.04 ± 82%  perf-profile.children.cycles-pp.record__finish_output
      0.05 ± 55%      -0.0        0.04 ± 82%  perf-profile.children.cycles-pp.perf_session__process_events
      0.51 ±  3%      -0.0        0.50 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.43 ±  3%      -0.0        0.43 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
      0.09 ±  8%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.clockevents_program_event
      0.06 ±  9%      -0.0        0.05 ± 34%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.16 ±  4%      -0.0        0.16        perf-profile.children.cycles-pp.perf_prepare_sample
      0.15 ±  4%      -0.0        0.15        perf-profile.children.cycles-pp.get_perf_callchain
      0.29 ±  3%      +0.0        0.29 ±  2%  perf-profile.children.cycles-pp.task_tick_fair
      0.31 ±  3%      +0.0        0.31        perf-profile.children.cycles-pp.scheduler_tick
      0.19 ±  4%      +0.0        0.19        perf-profile.children.cycles-pp.perf_swevent_overflow
      0.14 ±  4%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.perf_callchain_kernel
      0.15 ±  4%      +0.0        0.15        perf-profile.children.cycles-pp.perf_callchain
      0.19 ±  4%      +0.0        0.19        perf-profile.children.cycles-pp.__perf_event_overflow
      0.37 ±  5%      +0.0        0.38        perf-profile.children.cycles-pp.update_process_times
      0.21 ±  2%      +0.0        0.21        perf-profile.children.cycles-pp.update_curr
      0.20 ±  3%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.20 ±  3%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.perf_tp_event
      0.19 ±  4%      +0.0        0.19        perf-profile.children.cycles-pp.perf_event_output_forward
      0.38 ±  5%      +0.0        0.38        perf-profile.children.cycles-pp.tick_sched_handle
      0.05 ±  8%      +0.0        0.05 ±  9%  perf-profile.children.cycles-pp.__unwind_start
      0.11 ±  5%      +0.0        0.11 ±  2%  perf-profile.children.cycles-pp.unwind_next_frame
      0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.hrtimer_active
      0.27 ±  2%      +0.0        0.28        perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      2.08            +0.0        2.12        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      2.29            +0.0        2.33        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      1.92            +0.1        2.01        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
     98.04            +0.1       98.19        perf-profile.children.cycles-pp.syscall
     20.06            +0.2       20.24        perf-profile.children.cycles-pp.__entry_text_start
     16.93            +0.2       17.15        perf-profile.children.cycles-pp.syscall_return_via_sysret
      9.05            +0.2        9.28        perf-profile.children.cycles-pp.hash_futex
      5.23            +0.8        6.02        perf-profile.children.cycles-pp.get_futex_key
     24.09            +0.9       24.98        perf-profile.children.cycles-pp.futex_wake
     29.37            +1.1       30.45        perf-profile.children.cycles-pp.do_futex
     34.64            +1.4       36.04        perf-profile.children.cycles-pp.__x64_sys_futex
     38.28            +1.5       39.75        perf-profile.children.cycles-pp.do_syscall_64
      1.33            -1.3        0.00        perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      4.39            -0.2        4.23        perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      1.82            -0.1        1.68        perf-profile.self.cycles-pp.testcase
      6.74            -0.1        6.64        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
     10.01            -0.0        9.97        perf-profile.self.cycles-pp.futex_wake
      0.34 ±  4%      -0.0        0.31 ±  4%  perf-profile.self.cycles-pp.syscall@plt
      0.12 ± 14%      -0.0        0.09 ± 10%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.11 ± 28%      -0.0        0.09 ± 25%  perf-profile.self.cycles-pp.ktime_get
      9.15            -0.0        9.14        perf-profile.self.cycles-pp.__entry_text_start
      0.03 ± 79%      -0.0        0.02 ±122%  perf-profile.self.cycles-pp.queue_event
      1.84            -0.0        1.84        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.05 ± 28%      +0.0        0.05        perf-profile.self.cycles-pp.unwind_next_frame
     15.06            +0.0       15.07        perf-profile.self.cycles-pp.syscall
      0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.hrtimer_active
      0.23 ±  2%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      1.33            +0.0        1.37        perf-profile.self.cycles-pp.do_syscall_64
      1.77            +0.0        1.81        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      2.28            +0.0        2.33        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      1.80            +0.1        1.88        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      8.62            +0.2        8.78        perf-profile.self.cycles-pp.hash_futex
      5.36            +0.2        5.53        perf-profile.self.cycles-pp.do_futex
     16.79            +0.2       17.00        perf-profile.self.cycles-pp.syscall_return_via_sysret
      5.24            +0.3        5.57        perf-profile.self.cycles-pp.__x64_sys_futex
      4.89            +0.8        5.68        perf-profile.self.cycles-pp.get_futex_key
      8.59 ±204%     -53.9%       3.96 ±299%  sched_debug.cfs_rq:/.MIN_vruntime.avg
    937.90 ±196%     -26.9%     685.34 ±299%  sched_debug.cfs_rq:/.MIN_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.min
     88.81 ±198%     -41.5%      51.95 ±299%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
      4932 ±  6%      +0.3%       4949 ±  5%  sched_debug.cfs_rq:/.load.avg
     28586 ±156%     +17.1%      33473 ±149%  sched_debug.cfs_rq:/.load.max
      4485            -0.4%       4470        sched_debug.cfs_rq:/.load.min
      2603 ±139%     +12.3%       2923 ±123%  sched_debug.cfs_rq:/.load.stddev
      7.52 ± 16%      +5.7%       7.94 ± 19%  sched_debug.cfs_rq:/.load_avg.avg
    141.04 ± 19%     +24.3%     175.27 ± 31%  sched_debug.cfs_rq:/.load_avg.max
      4.15            +0.3%       4.17        sched_debug.cfs_rq:/.load_avg.min
     16.61 ± 30%     +19.3%      19.81 ± 32%  sched_debug.cfs_rq:/.load_avg.stddev
      8.59 ±204%     -53.9%       3.96 ±299%  sched_debug.cfs_rq:/.max_vruntime.avg
    937.90 ±196%     -26.9%     685.34 ±299%  sched_debug.cfs_rq:/.max_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.min
     88.81 ±198%     -41.5%      51.95 ±299%  sched_debug.cfs_rq:/.max_vruntime.stddev
  30128742            +0.1%   30152961        sched_debug.cfs_rq:/.min_vruntime.avg
  30251085            +0.1%   30272410        sched_debug.cfs_rq:/.min_vruntime.max
  28685289            -0.0%   28672656        sched_debug.cfs_rq:/.min_vruntime.min
    267234 ±  3%      +1.1%     270194 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.84            -0.1%       0.84        sched_debug.cfs_rq:/.nr_running.avg
      1.00            +0.0%       1.00        sched_debug.cfs_rq:/.nr_running.max
      0.83            -0.0%       0.83        sched_debug.cfs_rq:/.nr_running.min
      0.04 ± 16%      -2.7%       0.04 ± 14%  sched_debug.cfs_rq:/.nr_running.stddev
      0.58 ±168%     +68.9%       0.98 ±136%  sched_debug.cfs_rq:/.removed.load_avg.avg
     51.36 ±150%     +60.3%      82.32 ±100%  sched_debug.cfs_rq:/.removed.load_avg.max
      5.27 ±155%     +61.5%       8.50 ±108%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      0.25 ±195%     +38.8%       0.35 ±115%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     19.37 ±167%     +79.2%      34.72 ±103%  sched_debug.cfs_rq:/.removed.runnable_avg.max
      2.12 ±180%     +55.7%       3.30 ±106%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      0.25 ±195%     +38.8%       0.35 ±115%  sched_debug.cfs_rq:/.removed.util_avg.avg
     19.37 ±167%     +79.1%      34.70 ±103%  sched_debug.cfs_rq:/.removed.util_avg.max
      2.12 ±180%     +55.6%       3.30 ±106%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    886.24            -0.1%     885.72        sched_debug.cfs_rq:/.runnable_avg.avg
      1491 ±  6%      +2.3%       1524 ±  7%  sched_debug.cfs_rq:/.runnable_avg.max
    835.54            +0.8%     842.23        sched_debug.cfs_rq:/.runnable_avg.min
     78.71 ± 11%      +4.2%      82.03 ± 11%  sched_debug.cfs_rq:/.runnable_avg.stddev
    812632 ± 20%      -7.5%     751480 ±  5%  sched_debug.cfs_rq:/.spread0.avg
    931866 ± 18%      -6.9%     867643 ±  4%  sched_debug.cfs_rq:/.spread0.max
   -634707           +15.4%    -732744        sched_debug.cfs_rq:/.spread0.min
    267215 ±  3%      +1.1%     270208 ±  3%  sched_debug.cfs_rq:/.spread0.stddev
    881.97            -0.1%     881.10        sched_debug.cfs_rq:/.util_avg.avg
      1077 ±  2%      +0.9%       1086 ±  4%  sched_debug.cfs_rq:/.util_avg.max
    703.65 ± 11%      +3.4%     727.57 ±  5%  sched_debug.cfs_rq:/.util_avg.min
     54.59 ± 11%      +1.2%      55.24 ±  9%  sched_debug.cfs_rq:/.util_avg.stddev
    393.82            +0.1%     394.34        sched_debug.cfs_rq:/.util_est_enqueued.avg
    651.95 ±  6%      +2.8%     670.10 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.max
     86.79 ± 97%     +65.2%     143.40 ± 78%  sched_debug.cfs_rq:/.util_est_enqueued.min
     68.77 ±  6%      -2.6%      66.96 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    954731 ±  3%      +0.2%     956314 ±  2%  sched_debug.cpu.avg_idle.avg
   1831238 ± 21%     +11.6%    2043593 ± 35%  sched_debug.cpu.avg_idle.max
    606802 ±  5%      +1.0%     613105 ±  5%  sched_debug.cpu.avg_idle.min
    166314 ± 39%      +7.9%     179452 ± 36%  sched_debug.cpu.avg_idle.stddev
    192690            -1.5%     189889        sched_debug.cpu.clock.avg
    192727            -1.5%     189928        sched_debug.cpu.clock.max
    192652            -1.5%     189851        sched_debug.cpu.clock.min
     23.07 ±  4%      +3.7%      23.92 ±  4%  sched_debug.cpu.clock.stddev
    190808            -1.4%     188143        sched_debug.cpu.clock_task.avg
    191049            -1.4%     188357        sched_debug.cpu.clock_task.max
    182899            -1.2%     180755        sched_debug.cpu.clock_task.min
    710.35 ±  4%      -9.0%     646.39 ± 22%  sched_debug.cpu.clock_task.stddev
      3157            +0.4%       3171        sched_debug.cpu.curr->pid.avg
      7227 ±  7%      -4.1%       6930 ± 13%  sched_debug.cpu.curr->pid.max
      2963            +1.3%       3001        sched_debug.cpu.curr->pid.min
    376.60 ± 11%      -4.4%     360.07 ± 18%  sched_debug.cpu.curr->pid.stddev
    502858            +0.0%     502902        sched_debug.cpu.max_idle_balance_cost.avg
    587693 ±  9%      +3.9%     610743 ± 14%  sched_debug.cpu.max_idle_balance_cost.max
    500000            +0.0%     500000        sched_debug.cpu.max_idle_balance_cost.min
     11413 ± 68%     +16.8%      13327 ± 65%  sched_debug.cpu.max_idle_balance_cost.stddev
      4294            -0.0%       4294        sched_debug.cpu.next_balance.avg
      4294            -0.0%       4294        sched_debug.cpu.next_balance.max
      4294            -0.0%       4294        sched_debug.cpu.next_balance.min
      0.00 ±  5%      +3.2%       0.00 ±  3%  sched_debug.cpu.next_balance.stddev
      0.85            +0.2%       0.85        sched_debug.cpu.nr_running.avg
      1.73 ±  7%      +1.1%       1.75 ±  4%  sched_debug.cpu.nr_running.max
      0.83            -0.0%       0.83        sched_debug.cpu.nr_running.min
      0.10 ± 11%      +6.6%       0.11 ± 10%  sched_debug.cpu.nr_running.stddev
      3215            +0.7%       3239        sched_debug.cpu.nr_switches.avg
     26347 ±  9%      -1.6%      25915 ±  7%  sched_debug.cpu.nr_switches.max
      1278 ± 13%     +17.1%       1496 ±  8%  sched_debug.cpu.nr_switches.min
      3218 ±  3%      +0.7%       3239 ±  3%  sched_debug.cpu.nr_switches.stddev
      0.00 ± 45%     +22.8%       0.00 ± 26%  sched_debug.cpu.nr_uninterruptible.avg
    187.65 ±  2%      -2.3%     183.28        sched_debug.cpu.nr_uninterruptible.max
    -18.81            -2.5%     -18.33        sched_debug.cpu.nr_uninterruptible.min
     14.69 ±  3%      -2.8%      14.28        sched_debug.cpu.nr_uninterruptible.stddev
    192651            -1.5%     189850        sched_debug.cpu_clk
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.avg
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.max
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.min
 4.295e+09            -0.0%  4.295e+09        sched_debug.jiffies
    191780            -1.5%     188977        sched_debug.ktime
    950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.avg
    950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.max
    950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.min
      0.02 ±346%     -68.6%       0.01 ±300%  sched_debug.rt_rq:/.rt_time.avg
      4.42 ±346%     -67.6%       1.43 ±300%  sched_debug.rt_rq:/.rt_time.max
      0.00 ±346%    -100.0%       0.00        sched_debug.rt_rq:/.rt_time.min
      0.32 ±346%     -67.6%       0.10 ±300%  sched_debug.rt_rq:/.rt_time.stddev
    193039            -1.2%     190759        sched_debug.sched_clk
      1.00            +0.0%       1.00        sched_debug.sched_clock_stable()
   4140603            +0.0%    4140603        sched_debug.sysctl_sched.sysctl_sched_features
     24.00            +0.0%      24.00        sched_debug.sysctl_sched.sysctl_sched_latency
      3.00            +0.0%       3.00        sched_debug.sysctl_sched.sysctl_sched_min_granularity
      1.00            +0.0%       1.00        sched_debug.sysctl_sched.sysctl_sched_tunable_scaling
      4.00            +0.0%       4.00        sched_debug.sysctl_sched.sysctl_sched_wakeup_granularity
    382410            -0.0%     382401        slabinfo.Acpi-Operand.active_objs
      6830            -0.0%       6829        slabinfo.Acpi-Operand.active_slabs
    382524            -0.0%     382480        slabinfo.Acpi-Operand.num_objs
      6830            -0.0%       6829        slabinfo.Acpi-Operand.num_slabs
      1420 ±  5%      +0.7%       1430 ± 10%  slabinfo.Acpi-Parse.active_objs
     19.46 ±  5%      +0.7%      19.60 ± 10%  slabinfo.Acpi-Parse.active_slabs
      1420 ±  5%      +0.7%       1430 ± 10%  slabinfo.Acpi-Parse.num_objs
     19.46 ±  5%      +0.7%      19.60 ± 10%  slabinfo.Acpi-Parse.num_slabs
      9919            +0.4%       9955        slabinfo.Acpi-State.active_objs
    194.00            +0.4%     194.80        slabinfo.Acpi-State.active_slabs
      9919            +0.4%       9955        slabinfo.Acpi-State.num_objs
    194.00            +0.4%     194.80        slabinfo.Acpi-State.num_slabs
      2793 ±  5%      -0.1%       2791 ±  5%  slabinfo.PING.active_objs
     86.69 ±  6%      +0.2%      86.90 ±  5%  slabinfo.PING.active_slabs
      2793 ±  5%      -0.1%       2791 ±  5%  slabinfo.PING.num_objs
     86.69 ±  6%      +0.2%      86.90 ±  5%  slabinfo.PING.num_slabs
    384.00            +0.0%     384.00        slabinfo.RAW.active_objs
     12.00            +0.0%      12.00        slabinfo.RAW.active_slabs
    384.00            +0.0%     384.00        slabinfo.RAW.num_objs
     12.00            +0.0%      12.00        slabinfo.RAW.num_slabs
    214.00 ±  5%      -1.6%     210.60 ±  3%  slabinfo.RAWv6.active_objs
      8.23 ±  5%      -1.6%       8.10 ±  3%  slabinfo.RAWv6.active_slabs
    214.00 ±  5%      -1.6%     210.60 ±  3%  slabinfo.RAWv6.num_objs
      8.23 ±  5%      -1.6%       8.10 ±  3%  slabinfo.RAWv6.num_slabs
     54.92 ±  6%      +2.0%      56.00        slabinfo.TCP.active_objs
      3.92 ±  6%      +2.0%       4.00        slabinfo.TCP.active_slabs
     54.92 ±  6%      +2.0%      56.00        slabinfo.TCP.num_objs
      3.92 ±  6%      +2.0%       4.00        slabinfo.TCP.num_slabs
     39.00            -3.3%      37.70 ± 10%  slabinfo.TCPv6.active_objs
      3.00            -3.3%       2.90 ± 10%  slabinfo.TCPv6.active_slabs
     39.00            -3.3%      37.70 ± 10%  slabinfo.TCPv6.num_objs
      3.00            -3.3%       2.90 ± 10%  slabinfo.TCPv6.num_slabs
    149.15 ±  8%      +3.8%     154.80 ±  7%  slabinfo.UDPv6.active_objs
      5.46 ±  9%      +4.4%       5.70 ±  8%  slabinfo.UDPv6.active_slabs
    149.15 ±  8%      +3.8%     154.80 ±  7%  slabinfo.UDPv6.num_objs
      5.46 ±  9%      +4.4%       5.70 ±  8%  slabinfo.UDPv6.num_slabs
     37213 ±  3%      +0.4%      37349 ±  4%  slabinfo.anon_vma.active_objs
    808.54 ±  3%      +0.3%     811.30 ±  4%  slabinfo.anon_vma.active_slabs
     37213 ±  3%      +0.4%      37349 ±  4%  slabinfo.anon_vma.num_objs
    808.54 ±  3%      +0.3%     811.30 ±  4%  slabinfo.anon_vma.num_slabs
     80875 ±  2%      +0.2%      81051 ±  2%  slabinfo.anon_vma_chain.active_objs
      1263 ±  2%      +0.2%       1265 ±  2%  slabinfo.anon_vma_chain.active_slabs
     80899 ±  2%      +0.2%      81051 ±  2%  slabinfo.anon_vma_chain.num_objs
      1263 ±  2%      +0.2%       1265 ±  2%  slabinfo.anon_vma_chain.num_slabs
     41.54 ± 12%      +5.9%      44.00 ± 18%  slabinfo.bdev_cache.active_objs
      2.08 ± 12%      +5.9%       2.20 ± 18%  slabinfo.bdev_cache.active_slabs
     41.54 ± 12%      +5.9%      44.00 ± 18%  slabinfo.bdev_cache.num_objs
      2.08 ± 12%      +5.9%       2.20 ± 18%  slabinfo.bdev_cache.num_slabs
     25.85 ± 30%      -7.1%      24.00 ± 33%  slabinfo.biovec-128.active_objs
      1.62 ± 30%      -7.1%       1.50 ± 33%  slabinfo.biovec-128.active_slabs
     25.85 ± 30%      -7.1%      24.00 ± 33%  slabinfo.biovec-128.num_objs
      1.62 ± 30%      -7.1%       1.50 ± 33%  slabinfo.biovec-128.num_slabs
    258.46 ± 27%     +16.4%     300.80 ± 31%  slabinfo.biovec-64.active_objs
      8.08 ± 27%     +16.4%       9.40 ± 31%  slabinfo.biovec-64.active_slabs
    258.46 ± 27%     +16.4%     300.80 ± 31%  slabinfo.biovec-64.num_objs
      8.08 ± 27%     +16.4%       9.40 ± 31%  slabinfo.biovec-64.num_slabs
     64.00            +1.2%      64.80 ±  3%  slabinfo.biovec-max.active_objs
      8.00            +1.2%       8.10 ±  3%  slabinfo.biovec-max.active_slabs
     64.00            +1.2%      64.80 ±  3%  slabinfo.biovec-max.num_objs
      8.00            +1.2%       8.10 ±  3%  slabinfo.biovec-max.num_slabs
     81.00 ± 12%     +10.7%      89.70 ± 39%  slabinfo.buffer_head.active_objs
      2.08 ± 12%     +10.7%       2.30 ± 39%  slabinfo.buffer_head.active_slabs
     81.00 ± 12%     +10.7%      89.70 ± 39%  slabinfo.buffer_head.num_objs
      2.08 ± 12%     +10.7%       2.30 ± 39%  slabinfo.buffer_head.num_slabs
     10320            -0.0%      10315        slabinfo.cred_jar.active_objs
    244.92            -0.1%     244.80        slabinfo.cred_jar.active_slabs
     10320            -0.0%      10315        slabinfo.cred_jar.num_objs
    244.92            -0.1%     244.80        slabinfo.cred_jar.num_slabs
     42.00            +0.0%      42.00        slabinfo.dax_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.dax_cache.active_slabs
     42.00            +0.0%      42.00        slabinfo.dax_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.dax_cache.num_slabs
    171791            -2.8%     166977 ±  2%  slabinfo.dentry.active_objs
      4109            -2.7%       3997 ±  2%  slabinfo.dentry.active_slabs
    172610            -2.7%     167924 ±  2%  slabinfo.dentry.num_objs
      4109            -2.7%       3997 ±  2%  slabinfo.dentry.num_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.active_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.num_slabs
      1302 ± 24%      +8.7%       1415 ± 18%  slabinfo.dmaengine-unmap-16.active_objs
     30.46 ± 24%      +9.0%      33.20 ± 18%  slabinfo.dmaengine-unmap-16.active_slabs
      1302 ± 24%      +8.7%       1415 ± 18%  slabinfo.dmaengine-unmap-16.num_objs
     30.46 ± 24%      +9.0%      33.20 ± 18%  slabinfo.dmaengine-unmap-16.num_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.active_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.num_slabs
     32956 ± 17%      +3.7%      34176 ± 17%  slabinfo.ep_head.active_objs
    128.23 ± 17%      +3.8%     133.10 ± 17%  slabinfo.ep_head.active_slabs
     32956 ± 17%      +3.7%      34176 ± 17%  slabinfo.ep_head.num_objs
    128.23 ± 17%      +3.8%     133.10 ± 17%  slabinfo.ep_head.num_slabs
      1140 ± 12%      -0.6%       1134 ±  5%  slabinfo.file_lock_cache.active_objs
     30.54 ± 12%      -0.1%      30.50 ±  5%  slabinfo.file_lock_cache.active_slabs
      1140 ± 12%      -0.6%       1134 ±  5%  slabinfo.file_lock_cache.num_objs
     30.54 ± 12%      -0.1%      30.50 ±  5%  slabinfo.file_lock_cache.num_slabs
      9029 ±  6%      +2.5%       9256 ±  2%  slabinfo.files_cache.active_objs
    195.69 ±  6%      +2.6%     200.80 ±  2%  slabinfo.files_cache.active_slabs
      9029 ±  6%      +2.5%       9256 ±  2%  slabinfo.files_cache.num_objs
    195.69 ±  6%      +2.6%     200.80 ±  2%  slabinfo.files_cache.num_slabs
     77087 ±  4%      -5.0%      73237 ±  5%  slabinfo.filp.active_objs
      1209 ±  4%      -5.0%       1149 ±  5%  slabinfo.filp.active_slabs
     77448 ±  4%      -5.0%      73589 ±  5%  slabinfo.filp.num_objs
      1209 ±  4%      -5.0%       1149 ±  5%  slabinfo.filp.num_slabs
      2776 ±  6%      +3.7%       2880 ± 10%  slabinfo.fsnotify_mark_connector.active_objs
     21.69 ±  6%      +3.7%      22.50 ± 10%  slabinfo.fsnotify_mark_connector.active_slabs
      2776 ±  6%      +3.7%       2880 ± 10%  slabinfo.fsnotify_mark_connector.num_objs
     21.69 ±  6%      +3.7%      22.50 ± 10%  slabinfo.fsnotify_mark_connector.num_slabs
     50418            +0.1%      50464        slabinfo.ftrace_event_field.active_objs
    593.15            +0.1%     593.70        slabinfo.ftrace_event_field.active_slabs
     50418            +0.1%      50464        slabinfo.ftrace_event_field.num_objs
    593.15            +0.1%     593.70        slabinfo.ftrace_event_field.num_slabs
    104.00            +0.0%     104.00        slabinfo.hugetlbfs_inode_cache.active_objs
      2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.active_slabs
    104.00            +0.0%     104.00        slabinfo.hugetlbfs_inode_cache.num_objs
      2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.num_slabs
     96298            -0.2%      96098        slabinfo.inode_cache.active_objs
      1786            -0.2%       1783        slabinfo.inode_cache.active_slabs
     96492            -0.2%      96298        slabinfo.inode_cache.num_objs
      1786            -0.2%       1783        slabinfo.inode_cache.num_slabs
     44.00            +0.0%      44.00        slabinfo.ip6-frags.active_objs
      1.00            +0.0%       1.00        slabinfo.ip6-frags.active_slabs
     44.00            +0.0%      44.00        slabinfo.ip6-frags.num_objs
      1.00            +0.0%       1.00        slabinfo.ip6-frags.num_slabs
    131770            +0.1%     131916        slabinfo.kernfs_node_cache.active_objs
      2058            +0.1%       2060        slabinfo.kernfs_node_cache.active_slabs
    131770            +0.1%     131916        slabinfo.kernfs_node_cache.num_objs
      2058            +0.1%       2060        slabinfo.kernfs_node_cache.num_slabs
      6328 ± 14%      +7.0%       6772 ±  3%  slabinfo.khugepaged_mm_slot.active_objs
    175.54 ± 15%      +6.9%     187.70 ±  3%  slabinfo.khugepaged_mm_slot.active_slabs
      6328 ± 14%      +7.0%       6772 ±  3%  slabinfo.khugepaged_mm_slot.num_objs
    175.54 ± 15%      +6.9%     187.70 ±  3%  slabinfo.khugepaged_mm_slot.num_slabs
     15047            -0.2%      15012        slabinfo.kmalloc-128.active_objs
    237.38            -0.4%     236.50        slabinfo.kmalloc-128.active_slabs
     15228            -0.3%      15183        slabinfo.kmalloc-128.num_objs
    237.38            -0.4%     236.50        slabinfo.kmalloc-128.num_slabs
     61966            -0.1%      61887        slabinfo.kmalloc-16.active_objs
    242.54            -0.2%     242.10        slabinfo.kmalloc-16.active_slabs
     62089            -0.2%      61977        slabinfo.kmalloc-16.num_objs
    242.54            -0.2%     242.10        slabinfo.kmalloc-16.num_slabs
     10489            -0.1%      10483        slabinfo.kmalloc-192.active_objs
    255.77            -0.1%     255.60        slabinfo.kmalloc-192.active_slabs
     10751            -0.2%      10735        slabinfo.kmalloc-192.num_objs
    255.77            -0.1%     255.60        slabinfo.kmalloc-192.num_slabs
     10077 ±  2%      -2.0%       9875        slabinfo.kmalloc-1k.active_objs
    319.23 ±  2%      -1.6%     314.20        slabinfo.kmalloc-1k.active_slabs
     10230 ±  2%      -1.6%      10066        slabinfo.kmalloc-1k.num_objs
    319.23 ±  2%      -1.6%     314.20        slabinfo.kmalloc-1k.num_slabs
     16739            -0.1%      16722        slabinfo.kmalloc-256.active_objs
    267.08            +0.0%     267.20        slabinfo.kmalloc-256.active_slabs
     17126            +0.0%      17134        slabinfo.kmalloc-256.num_objs
    267.08            +0.0%     267.20        slabinfo.kmalloc-256.num_slabs
     12133 ±  2%      +0.3%      12171 ±  2%  slabinfo.kmalloc-2k.active_objs
    770.31 ±  2%      +0.2%     771.60 ±  2%  slabinfo.kmalloc-2k.active_slabs
     12330 ±  2%      +0.2%      12355 ±  2%  slabinfo.kmalloc-2k.num_objs
    770.31 ±  2%      +0.2%     771.60 ±  2%  slabinfo.kmalloc-2k.num_slabs
    137223            +0.8%     138284        slabinfo.kmalloc-32.active_objs
      1076            +0.7%       1084        slabinfo.kmalloc-32.active_slabs
    137835            +0.7%     138816        slabinfo.kmalloc-32.num_objs
      1076            +0.7%       1084        slabinfo.kmalloc-32.num_slabs
      3117            +0.2%       3122        slabinfo.kmalloc-4k.active_objs
    395.23            -0.0%     395.20        slabinfo.kmalloc-4k.active_slabs
      3165            -0.0%       3165        slabinfo.kmalloc-4k.num_objs
    395.23            -0.0%     395.20        slabinfo.kmalloc-4k.num_slabs
     27807 ±  2%      -1.7%      27326 ±  4%  slabinfo.kmalloc-512.active_objs
    440.23 ±  3%      -1.6%     433.30 ±  4%  slabinfo.kmalloc-512.active_slabs
     28206 ±  3%      -1.6%      27768 ±  4%  slabinfo.kmalloc-512.num_objs
    440.23 ±  3%      -1.6%     433.30 ±  4%  slabinfo.kmalloc-512.num_slabs
     88862            +0.2%      89014        slabinfo.kmalloc-64.active_objs
      1394            +0.1%       1396        slabinfo.kmalloc-64.active_slabs
     89268            +0.2%      89412        slabinfo.kmalloc-64.num_objs
      1394            +0.1%       1396        slabinfo.kmalloc-64.num_slabs
    105184            -0.1%     105062        slabinfo.kmalloc-8.active_objs
    212.31            -0.2%     211.90        slabinfo.kmalloc-8.active_slabs
    108972            -0.1%     108844        slabinfo.kmalloc-8.num_objs
    212.31            -0.2%     211.90        slabinfo.kmalloc-8.num_slabs
      1481            +0.1%       1483        slabinfo.kmalloc-8k.active_objs
    383.31            +0.1%     383.60        slabinfo.kmalloc-8k.active_slabs
      1535            +0.1%       1537        slabinfo.kmalloc-8k.num_objs
    383.31            +0.1%     383.60        slabinfo.kmalloc-8k.num_slabs
     15720 ±  2%      -0.6%      15625 ±  2%  slabinfo.kmalloc-96.active_objs
    377.15 ±  2%      -0.6%     374.80 ±  2%  slabinfo.kmalloc-96.active_slabs
     15856 ±  2%      -0.6%      15762 ±  2%  slabinfo.kmalloc-96.num_objs
    377.15 ±  2%      -0.6%     374.80 ±  2%  slabinfo.kmalloc-96.num_slabs
    625.23 ±  4%      -0.7%     620.80 ± 13%  slabinfo.kmalloc-rcl-128.active_objs
      9.77 ±  4%      -0.7%       9.70 ± 13%  slabinfo.kmalloc-rcl-128.active_slabs
    625.23 ±  4%      -0.7%     620.80 ± 13%  slabinfo.kmalloc-rcl-128.num_objs
      9.77 ±  4%      -0.7%       9.70 ± 13%  slabinfo.kmalloc-rcl-128.num_slabs
     87.23 ± 12%      +5.9%      92.40 ± 18%  slabinfo.kmalloc-rcl-192.active_objs
      2.08 ± 12%      +5.9%       2.20 ± 18%  slabinfo.kmalloc-rcl-192.active_slabs
     87.23 ± 12%      +5.9%      92.40 ± 18%  slabinfo.kmalloc-rcl-192.num_objs
      2.08 ± 12%      +5.9%       2.20 ± 18%  slabinfo.kmalloc-rcl-192.num_slabs
    192.00            +0.0%     192.00        slabinfo.kmalloc-rcl-256.active_objs
      3.00            +0.0%       3.00        slabinfo.kmalloc-rcl-256.active_slabs
    192.00            +0.0%     192.00        slabinfo.kmalloc-rcl-256.num_objs
      3.00            +0.0%       3.00        slabinfo.kmalloc-rcl-256.num_slabs
     14145            -0.1%      14135        slabinfo.kmalloc-rcl-512.active_objs
    220.62            -0.1%     220.30        slabinfo.kmalloc-rcl-512.active_slabs
     14150            -0.1%      14139        slabinfo.kmalloc-rcl-512.num_objs
    220.62            -0.1%     220.30        slabinfo.kmalloc-rcl-512.num_slabs
      7000 ±  4%      -0.9%       6937 ±  5%  slabinfo.kmalloc-rcl-64.active_objs
    108.54 ±  4%      -0.7%     107.80 ±  5%  slabinfo.kmalloc-rcl-64.active_slabs
      7000 ±  4%      -0.9%       6937 ±  5%  slabinfo.kmalloc-rcl-64.num_objs
    108.54 ±  4%      -0.7%     107.80 ±  5%  slabinfo.kmalloc-rcl-64.num_slabs
      2036 ±  6%      +1.5%       2067 ±  6%  slabinfo.kmalloc-rcl-96.active_objs
     48.31 ±  6%      +1.4%      49.00 ±  7%  slabinfo.kmalloc-rcl-96.active_slabs
      2036 ±  6%      +1.5%       2067 ±  6%  slabinfo.kmalloc-rcl-96.num_objs
     48.31 ±  6%      +1.4%      49.00 ±  7%  slabinfo.kmalloc-rcl-96.num_slabs
    713.85 ± 11%      -0.5%     710.40 ± 17%  slabinfo.kmem_cache.active_objs
     11.15 ± 11%      -0.5%      11.10 ± 17%  slabinfo.kmem_cache.active_slabs
    713.85 ± 11%      -0.5%     710.40 ± 17%  slabinfo.kmem_cache.num_objs
     11.15 ± 11%      -0.5%      11.10 ± 17%  slabinfo.kmem_cache.num_slabs
      1184 ±  6%      -0.3%       1181 ± 10%  slabinfo.kmem_cache_node.active_objs
     20.15 ±  6%      -0.3%      20.10 ±  9%  slabinfo.kmem_cache_node.active_slabs
      1289 ±  6%      -0.3%       1286 ±  9%  slabinfo.kmem_cache_node.num_objs
     20.15 ±  6%      -0.3%      20.10 ±  9%  slabinfo.kmem_cache_node.num_slabs
     36090            +0.1%      36144        slabinfo.lsm_file_cache.active_objs
    211.38            +0.1%     211.70        slabinfo.lsm_file_cache.active_slabs
     36090            +0.1%      36144        slabinfo.lsm_file_cache.num_objs
    211.38            +0.1%     211.70        slabinfo.lsm_file_cache.num_slabs
      6059 ±  2%      +0.8%       6111        slabinfo.mm_struct.active_objs
    201.23 ±  2%      +0.9%     203.00        slabinfo.mm_struct.active_slabs
      6059 ±  2%      +0.8%       6111        slabinfo.mm_struct.num_objs
    201.23 ±  2%      +0.9%     203.00        slabinfo.mm_struct.num_slabs
    897.38 ±  8%      +5.0%     942.60 ±  9%  slabinfo.mnt_cache.active_objs
     16.62 ±  9%      +5.9%      17.60 ±  9%  slabinfo.mnt_cache.active_slabs
    897.38 ±  8%      +5.0%     942.60 ±  9%  slabinfo.mnt_cache.num_objs
     16.62 ±  9%      +5.9%      17.60 ±  9%  slabinfo.mnt_cache.num_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.active_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.num_slabs
      1536            -0.0%       1536        slabinfo.names_cache.active_objs
    192.08            -0.0%     192.00        slabinfo.names_cache.active_slabs
      1536            -0.0%       1536        slabinfo.names_cache.num_objs
    192.08            -0.0%     192.00        slabinfo.names_cache.num_slabs
     36.00            +0.0%      36.00        slabinfo.nfs_read_data.active_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.active_slabs
     36.00            +0.0%      36.00        slabinfo.nfs_read_data.num_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.num_slabs
    310.00            +0.0%     310.00        slabinfo.numa_policy.active_objs
      5.00            +0.0%       5.00        slabinfo.numa_policy.active_slabs
    310.00            +0.0%     310.00        slabinfo.numa_policy.num_objs
      5.00            +0.0%       5.00        slabinfo.numa_policy.num_slabs
     14359 ±  6%      -8.5%      13135 ±  9%  slabinfo.pde_opener.active_objs
    140.31 ±  6%      -8.6%     128.20 ±  9%  slabinfo.pde_opener.active_slabs
     14359 ±  6%      -8.5%      13135 ±  9%  slabinfo.pde_opener.num_objs
    140.31 ±  6%      -8.6%     128.20 ±  9%  slabinfo.pde_opener.num_slabs
     13900 ±  2%      +0.9%      14028        slabinfo.pid.active_objs
    216.46 ±  2%      +0.9%     218.40        slabinfo.pid.active_slabs
     13900 ±  2%      +0.9%      14028        slabinfo.pid.num_objs
    216.46 ±  2%      +0.9%     218.40        slabinfo.pid.num_slabs
      3409 ±  6%      +0.3%       3419 ±  7%  slabinfo.pool_workqueue.active_objs
     56.15 ±  7%      +0.6%      56.50 ±  7%  slabinfo.pool_workqueue.active_slabs
      3606 ±  6%      +0.4%       3620 ±  7%  slabinfo.pool_workqueue.num_objs
     56.15 ±  7%      +0.6%      56.50 ±  7%  slabinfo.pool_workqueue.num_slabs
      2778 ±  2%      +0.4%       2788        slabinfo.proc_dir_entry.active_objs
     66.15 ±  2%      +0.4%      66.40        slabinfo.proc_dir_entry.active_slabs
      2778 ±  2%      +0.4%       2788        slabinfo.proc_dir_entry.num_objs
     66.15 ±  2%      +0.4%      66.40        slabinfo.proc_dir_entry.num_slabs
     22466            +0.1%      22480 ±  2%  slabinfo.proc_inode_cache.active_objs
    474.54 ±  2%      +0.3%     476.00 ±  2%  slabinfo.proc_inode_cache.active_slabs
     22801 ±  2%      +0.3%      22874 ±  2%  slabinfo.proc_inode_cache.num_objs
    474.54 ±  2%      +0.3%     476.00 ±  2%  slabinfo.proc_inode_cache.num_slabs
     28519            +0.1%      28539        slabinfo.radix_tree_node.active_objs
    508.77            +0.1%     509.20        slabinfo.radix_tree_node.active_slabs
     28519            +0.1%      28539        slabinfo.radix_tree_node.num_objs
    508.77            +0.1%     509.20        slabinfo.radix_tree_node.num_slabs
     22.15 ± 35%     +22.8%      27.20 ± 26%  slabinfo.request_queue.active_objs
      1.38 ± 35%     +22.8%       1.70 ± 26%  slabinfo.request_queue.active_slabs
     22.15 ± 35%     +22.8%      27.20 ± 26%  slabinfo.request_queue.num_objs
      1.38 ± 35%     +22.8%       1.70 ± 26%  slabinfo.request_queue.num_slabs
     51.00            +0.0%      51.00        slabinfo.rpc_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.active_slabs
     51.00            +0.0%      51.00        slabinfo.rpc_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.num_slabs
    320.00            +0.0%     320.00        slabinfo.scsi_sense_cache.active_objs
      5.00            +0.0%       5.00        slabinfo.scsi_sense_cache.active_slabs
    320.00            +0.0%     320.00        slabinfo.scsi_sense_cache.num_objs
      5.00            +0.0%       5.00        slabinfo.scsi_sense_cache.num_slabs
     13056            +0.0%      13056        slabinfo.seq_file.active_objs
    192.00            +0.0%     192.00        slabinfo.seq_file.active_slabs
     13056            +0.0%      13056        slabinfo.seq_file.num_objs
    192.00            +0.0%     192.00        slabinfo.seq_file.num_slabs
      8521 ±  6%      -0.3%       8492 ±  4%  slabinfo.shmem_inode_cache.active_objs
    184.62 ±  6%      -0.2%     184.30 ±  4%  slabinfo.shmem_inode_cache.active_slabs
      8521 ±  6%      -0.3%       8492 ±  4%  slabinfo.shmem_inode_cache.num_objs
    184.62 ±  6%      -0.2%     184.30 ±  4%  slabinfo.shmem_inode_cache.num_slabs
      4505 ±  4%      +1.8%       4586        slabinfo.sighand_cache.active_objs
    302.69 ±  4%      +2.1%     309.00        slabinfo.sighand_cache.active_slabs
      4551 ±  4%      +2.0%       4643        slabinfo.sighand_cache.num_objs
    302.69 ±  4%      +2.1%     309.00        slabinfo.sighand_cache.num_slabs
      7059 ±  4%      +1.0%       7127 ±  2%  slabinfo.signal_cache.active_objs
    254.23 ±  4%      +1.3%     257.50 ±  2%  slabinfo.signal_cache.active_slabs
      7133 ±  4%      +1.3%       7224 ±  2%  slabinfo.signal_cache.num_objs
    254.23 ±  4%      +1.3%     257.50 ±  2%  slabinfo.signal_cache.num_slabs
    128.00            +0.0%     128.00        slabinfo.skbuff_fclone_cache.active_objs
      2.00            +0.0%       2.00        slabinfo.skbuff_fclone_cache.active_slabs
    128.00            +0.0%     128.00        slabinfo.skbuff_fclone_cache.num_objs
      2.00            +0.0%       2.00        slabinfo.skbuff_fclone_cache.num_slabs
     13233 ±  2%      -0.4%      13177 ±  2%  slabinfo.skbuff_head_cache.active_objs
    207.15 ±  2%      -0.6%     205.90 ±  2%  slabinfo.skbuff_head_cache.active_slabs
     13257 ±  2%      -0.6%      13177 ±  2%  slabinfo.skbuff_head_cache.num_objs
    207.15 ±  2%      -0.6%     205.90 ±  2%  slabinfo.skbuff_head_cache.num_slabs
      4799 ±  4%      +1.1%       4853 ±  5%  slabinfo.sock_inode_cache.active_objs
    122.46 ±  4%      +1.4%     124.20 ±  5%  slabinfo.sock_inode_cache.active_slabs
      4799 ±  4%      +1.1%       4853 ±  5%  slabinfo.sock_inode_cache.num_objs
    122.46 ±  4%      +1.4%     124.20 ±  5%  slabinfo.sock_inode_cache.num_slabs
     11580 ±  5%      +2.1%      11820 ±  2%  slabinfo.task_delay_info.active_objs
    226.54 ±  5%      +2.1%     231.30 ±  2%  slabinfo.task_delay_info.active_slabs
     11580 ±  5%      +2.1%      11820 ±  2%  slabinfo.task_delay_info.num_objs
    226.54 ±  5%      +2.1%     231.30 ±  2%  slabinfo.task_delay_info.num_slabs
      1456 ±  5%      -3.8%       1401 ±  4%  slabinfo.task_group.active_objs
     31.38 ±  5%      -4.1%      30.10 ±  4%  slabinfo.task_group.active_slabs
      1456 ±  5%      -3.8%       1401 ±  4%  slabinfo.task_group.num_objs
     31.38 ±  5%      -4.1%      30.10 ±  4%  slabinfo.task_group.num_slabs
      2319            -0.3%       2312        slabinfo.task_struct.active_objs
      2333            -0.3%       2326        slabinfo.task_struct.active_slabs
      2333            -0.3%       2326        slabinfo.task_struct.num_objs
      2333            -0.3%       2326        slabinfo.task_struct.num_slabs
    145.00            +0.0%     145.00        slabinfo.taskstats.active_objs
      3.00            +0.0%       3.00        slabinfo.taskstats.active_slabs
    145.00            +0.0%     145.00        slabinfo.taskstats.num_objs
      3.00            +0.0%       3.00        slabinfo.taskstats.num_slabs
      3858            -0.1%       3853 ±  2%  slabinfo.trace_event_file.active_objs
     83.77            +0.0%      83.80 ±  2%  slabinfo.trace_event_file.active_slabs
      3858            +0.1%       3861 ±  2%  slabinfo.trace_event_file.num_objs
     83.77            +0.0%      83.80 ±  2%  slabinfo.trace_event_file.num_slabs
     66.00            +0.0%      66.00        slabinfo.tw_sock_TCP.active_objs
      1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.active_slabs
     66.00            +0.0%      66.00        slabinfo.tw_sock_TCP.num_objs
      1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.num_slabs
     92347 ±  3%      -0.9%      91497 ±  4%  slabinfo.vm_area_struct.active_objs
      2315 ±  3%      -0.9%       2294 ±  4%  slabinfo.vm_area_struct.active_slabs
     92640 ±  3%      -0.9%      91784 ±  4%  slabinfo.vm_area_struct.num_objs
      2315 ±  3%      -0.9%       2294 ±  4%  slabinfo.vm_area_struct.num_slabs
     22380            +0.2%      22428        slabinfo.vmap_area.active_objs
    349.46            +0.2%     350.20        slabinfo.vmap_area.active_slabs
     22392            +0.2%      22445        slabinfo.vmap_area.num_objs
    349.46            +0.2%     350.20        slabinfo.vmap_area.num_slabs
     42.00            +0.0%      42.00        slabinfo.xfrm_state.active_objs
      1.00            +0.0%       1.00        slabinfo.xfrm_state.active_slabs
     42.00            +0.0%      42.00        slabinfo.xfrm_state.num_objs
      1.00            +0.0%       1.00        slabinfo.xfrm_state.num_slabs
     63.69 ± 23%      -3.9%      61.20 ± 37%  slabinfo.xfs_btree_cur.active_objs
      1.77 ± 23%      -3.9%       1.70 ± 37%  slabinfo.xfs_btree_cur.active_slabs
     63.69 ± 23%      -3.9%      61.20 ± 37%  slabinfo.xfs_btree_cur.num_objs
      1.77 ± 23%      -3.9%       1.70 ± 37%  slabinfo.xfs_btree_cur.num_slabs
    193.85 ± 13%      -2.5%     189.00 ± 17%  slabinfo.xfs_buf.active_objs
      4.62 ± 13%      -2.5%       4.50 ± 17%  slabinfo.xfs_buf.active_slabs
    193.85 ± 13%      -2.5%     189.00 ± 17%  slabinfo.xfs_buf.num_objs
      4.62 ± 13%      -2.5%       4.50 ± 17%  slabinfo.xfs_buf.num_slabs
     38.00            +0.0%      38.00        slabinfo.xfs_efi_item.active_objs
      1.00            +0.0%       1.00        slabinfo.xfs_efi_item.active_slabs
     38.00            +0.0%      38.00        slabinfo.xfs_efi_item.num_objs
      1.00            +0.0%       1.00        slabinfo.xfs_efi_item.num_slabs
     96.00            +0.0%      96.00        slabinfo.xfs_inode.active_objs
      3.00            +0.0%       3.00        slabinfo.xfs_inode.active_slabs
     96.00            +0.0%      96.00        slabinfo.xfs_inode.num_objs
      3.00            +0.0%       3.00        slabinfo.xfs_inode.num_slabs
      0.01 ±  6%      -2.5%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.24 ±320%    +883.0%       2.32 ±171%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.21 ±249%    +204.4%       0.65 ±142%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      2.61 ± 28%      +7.0%       2.80 ± 97%  perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.02 ± 97%     +10.9%       0.02 ±172%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.02 ± 48%      +1.5%       0.02 ± 52%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.65 ±346%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.00 ±234%     +30.0%       0.00 ±200%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.00 ±143%      +8.3%       0.00 ± 89%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 19%     +12.4%       0.03 ± 26%  perf-sched.sch_delay.avg.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.29 ±258%     -49.5%       0.14 ±180%  perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00 ±234%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.__get_free_pages.__pud_alloc
      0.00 ±346%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.__get_free_pages.pgd_alloc
      0.00 ±182%     +22.6%       0.00 ±154%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.__pmd_alloc.copy_page_range
      0.65 ±346%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.wp_page_copy
      0.00 ±150%     -54.7%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.pte_alloc_one.__pte_alloc
      0.46 ±108%     -34.9%       0.30 ±152%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__flush_work.lru_add_drain_all.khugepaged
      0.00 ±346%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__fput.task_work_run.exit_to_user_mode_prepare
      0.00 ±234%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_prepare_creds.prepare_creds
      0.00 ±234%    +130.5%       0.00 ±152%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_task_alloc.copy_process
      0.00 ±182%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.__vmalloc_node_range.dup_task_struct
      0.00       +5.9e+101%       0.59 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__mutex_lock.isra.0
      0.00        +1.2e+99%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__vmalloc_node_range.dup_task_struct.copy_process
      0.00        +1.4e+99%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.cgroup_can_fork.copy_process.kernel_clone
      0.00 ±346%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.copy_page_from_iter.pipe_write.new_sync_write
      0.00 ±161%     +12.4%       0.01 ±124%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.copy_page_range.dup_mmap.dup_mm
      0.00          +1e+99%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      0.00 ±152%     +32.5%       0.01 ±122%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.00 ±204%  +22609.4%       0.28 ±298%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.01 ±108%      -5.6%       0.01 ±123%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00 ±234%    +104.3%       0.00 ±152%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_fork.dup_mmap
      0.00 ±150%    +105.1%       0.01 ± 83%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.dup_mmap.dup_mm
      0.16 ±230%    +348.3%       0.70 ± 65%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.khugepaged.kthread.ret_from_fork
      0.00 ±346%     +43.0%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process
      0.00 ±234%     -26.5%       0.00 ±299%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap
      0.00 ±234%     -32.2%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process
      0.00 ±346%     +30.0%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.copy_process.kernel_clone
      0.00 ±346%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.dup_mm.copy_process
      0.00 ±150%      -7.5%       0.00 ±152%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.00 ±151%     -60.2%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap
      0.00 ±346%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node_trace.__get_vm_area_node.__vmalloc_node_range
      9.36            -0.2%       9.34        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00        +1.3e+99%       0.00 ±299%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm
      0.00 ±346%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.01           +96.7%       0.02 ±148%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.05 ± 53%     -23.2%       0.03 ± 35%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.02 ± 36%      -3.0%       0.02 ± 41%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.00 ±148%     -59.1%       0.00 ± 27%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.00 ±346%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.pipe_read
      0.17 ±340%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      0.01 ±  3%      -1.7%       0.01        perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01            +6.7%       0.01 ± 18%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.38 ±126%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion.__flush_work.lru_add_drain_all
      0.01            -0.0%       0.01        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.05 ±153%    +118.0%       0.11 ±154%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      0.98 ±193%     -26.2%       0.73 ±292%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.01 ± 21%      -7.8%       0.01 ± 22%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.67 ±336%    +377.0%       3.20 ±154%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      4.56 ±265%    +211.9%      14.23 ±144%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      7.80 ± 28%     -20.3%       6.21 ± 68%  perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      4.60 ±112%     -13.5%       3.98 ±165%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.73 ±329%     +28.3%       0.93 ±285%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.65 ±346%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      1.07 ±234%     +30.0%       1.39 ±199%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      4.32 ± 94%     +21.9%       5.26 ± 86%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 19%     +16.3%       0.03 ± 22%  perf-sched.sch_delay.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
    167.93 ±223%     +29.6%     217.64 ±191%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00 ±234%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.__get_free_pages.__pud_alloc
      0.00 ±346%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.__get_free_pages.pgd_alloc
      0.00 ±182%     +22.6%       0.00 ±154%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.__pmd_alloc.copy_page_range
      0.65 ±346%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.wp_page_copy
      0.00 ±150%     -54.7%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.pte_alloc_one.__pte_alloc
      0.46 ±108%     -34.9%       0.30 ±152%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__flush_work.lru_add_drain_all.khugepaged
      0.00 ±346%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__fput.task_work_run.exit_to_user_mode_prepare
      0.00 ±234%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_prepare_creds.prepare_creds
      0.00 ±234%    +130.5%       0.00 ±152%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_task_alloc.copy_process
      0.00 ±182%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.__vmalloc_node_range.dup_task_struct
      0.00       +5.9e+101%       0.59 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__mutex_lock.isra.0
      0.00        +1.2e+99%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__vmalloc_node_range.dup_task_struct.copy_process
      0.00        +1.4e+99%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.cgroup_can_fork.copy_process.kernel_clone
      0.00 ±346%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.copy_page_from_iter.pipe_write.new_sync_write
      0.00 ±161%     +12.4%       0.01 ±124%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.copy_page_range.dup_mmap.dup_mm
      0.00          +1e+99%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      0.00 ±158%     +27.8%       0.01 ±122%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.00 ±184%  +29339.7%       0.84 ±298%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.01 ±108%      +1.5%       0.01 ±122%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00 ±234%    +104.3%       0.00 ±152%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_fork.dup_mmap
      0.00 ±150%    +113.8%       0.01 ± 85%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.dup_mmap.dup_mm
      0.16 ±230%    +348.3%       0.70 ± 65%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.khugepaged.kthread.ret_from_fork
      0.00 ±346%     +43.0%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process
      0.00 ±234%     -26.5%       0.00 ±299%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap
      0.00 ±234%     -32.2%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process
      0.00 ±346%     +18.2%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.copy_process.kernel_clone
      0.00 ±346%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.dup_mm.copy_process
      0.00 ±150%      -2.5%       0.00 ±153%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.00 ±152%     -62.5%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap
      0.00 ±346%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node_trace.__get_vm_area_node.__vmalloc_node_range
     20.59            -2.6%      20.05 ±  5%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00        +1.4e+99%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm
      0.58 ±315%     -88.7%       0.07 ± 58%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.02 ± 22%   +3906.8%       0.80 ±292%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.40 ± 98%     -50.1%       0.20 ± 11%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.03 ± 60%      -0.6%       0.03 ± 64%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.35 ±223%     -90.0%       0.03 ±148%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.00 ±346%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.pipe_read
      0.17 ±340%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      0.02 ± 38%      +9.2%       0.02 ± 24%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.03 ± 21%   +2452.0%       0.88 ±288%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.38 ±126%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion.__flush_work.lru_add_drain_all
      0.13 ± 71%     -31.6%       0.09 ± 59%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      3.20 ±152%     +70.5%       5.45 ±130%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    372.55 ±181%     -57.5%     158.39 ±290%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.20 ± 49%     -12.8%       0.18 ± 35%  perf-sched.total_sch_delay.average.ms
    467.93 ±145%     -18.1%     383.29 ±145%  perf-sched.total_sch_delay.max.ms
    144.60 ±  7%      -6.8%     134.74 ±  5%  perf-sched.total_wait_and_delay.average.ms
     17805 ±  7%      +8.0%      19227 ±  6%  perf-sched.total_wait_and_delay.count.ms
      7834 ± 10%      -1.6%       7705 ±  9%  perf-sched.total_wait_and_delay.max.ms
    144.40 ±  7%      -6.8%     134.57 ±  5%  perf-sched.total_wait_time.average.ms
      7832 ± 10%      -1.6%       7704 ±  9%  perf-sched.total_wait_time.max.ms
    899.41            +0.1%     900.33        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2345 ±  3%      +8.1%       2535 ± 20%  perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    815.32 ±  4%      -0.9%     808.24 ±  5%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      2350 ±  3%      +7.4%       2524 ± 16%  perf-sched.wait_and_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
    214.36 ±  4%      -1.2%     211.71 ±  4%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     87.04 ±  9%      +2.8%      89.47 ± 13%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.20 ± 17%      +0.2%       0.20 ± 18%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.17 ± 43%      -4.1%       0.16 ± 51%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.16 ±  7%      -5.5%       0.15 ±  2%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00       +4.1e+103%      40.82 ±300%  perf-sched.wait_and_delay.avg.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
    114.40 ± 32%     -33.0%      76.66 ± 27%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
    833.95 ±214%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
      1046 ±234%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__do_fault.do_fault.__handle_mm_fault
    509.48 ±346%     -59.4%     206.97 ±300%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
    357.89 ±114%    +117.1%     777.12 ± 52%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
     10.77 ±346%    +376.6%      51.34 ±200%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_poll.do_sys_poll
      9.36            -0.2%       9.35        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      4.87            -1.5%       4.80 ±  4%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.43 ±234%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    645.53 ± 20%      +3.2%     666.29 ± 18%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    121.62 ±  8%      -2.8%     118.20 ±  8%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     78.71 ±346%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.pipe_read
    478.55            +0.0%     478.60        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      6.47 ± 15%      -7.3%       5.99 ± 15%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    592.44            +0.3%     594.17        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
    529.47 ±  4%      -1.2%     523.24 ±  2%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
     10.00            +1.0%      10.10 ±  2%  perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      3.00            -6.7%       2.80 ± 14%  perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     22.15 ±  4%      +1.1%      22.40 ±  5%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      3.00            -6.7%       2.80 ± 14%  perf-sched.wait_and_delay.count.do_syslog.part.0.kmsg_read.vfs_read
    280.77            +0.8%     282.90        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    309.23            +1.5%     313.90 ±  2%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1405 ± 10%      +1.0%       1419 ± 10%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    460.62 ± 32%     +22.8%     565.70 ± 25%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      5652 ±  7%     +10.3%       6233 ±  6%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00         +4e+101%       0.40 ±300%  perf-sched.wait_and_delay.count.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      1263 ± 34%     +42.0%       1794 ± 23%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
      1.38 ±184%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
      0.15 ±234%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__do_fault.do_fault.__handle_mm_fault
      0.08 ±346%    +290.0%       0.30 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      4.38 ±117%     +87.0%       8.20 ± 49%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.08 ±346%    +160.0%       0.20 ±200%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.perf_poll.do_sys_poll
    280.15            +1.2%     283.40        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      2302            +0.7%       2319        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
     20.31 ±239%    -100.0%       0.00        perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork
     23.77 ± 42%     -15.0%      20.20 ± 50%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    202.08 ±  7%      +3.4%     209.00 ±  8%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.08 ±346%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.isra.0.pipe_read
     79.23            +0.2%      79.40        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      1547 ± 16%      +9.2%       1690 ± 18%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      3160            +0.6%       3180        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
    611.08 ±  3%      +2.4%     625.60 ±  3%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
    999.38            +0.0%     999.39        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      7034 ±  3%      -2.0%       6891 ±  3%  perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1009 ±  2%      +1.9%       1028 ±  3%  perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      7048 ±  3%      -2.1%       6897 ±  3%  perf-sched.wait_and_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      2707 ± 84%     -21.7%       2121 ± 81%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1021            +0.1%       1022        perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     19.55 ± 82%     -25.4%      14.59 ± 21%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     19.85 ±138%     +70.9%      33.93 ± 91%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     56.44 ± 43%      -3.5%      54.45 ± 53%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00       +1.6e+104%     162.95 ±300%  perf-sched.wait_and_delay.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      7037 ±  3%      -2.1%       6891 ±  3%  perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      2063 ±150%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
      1046 ±234%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__do_fault.do_fault.__handle_mm_fault
    509.48 ±346%     +21.5%     618.91 ±300%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      3078 ±108%     +92.7%       5931 ± 33%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
     10.77 ±346%    +376.6%      51.34 ±200%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_poll.do_sys_poll
     20.59            -2.6%      20.05 ±  5%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      2177            -4.5%       2080 ± 17%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.77 ±234%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      6690 ±  4%      -2.9%       6495 ±  4%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      5513            +0.3%       5532        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     78.71 ±346%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.pipe_read
    505.01            -0.0%     505.01        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    294.70 ± 36%      +1.2%     298.21 ± 48%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      5881 ± 26%     +19.1%       7003 ± 16%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      7414 ± 14%      -1.9%       7275 ±  9%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
    899.40            +0.1%     900.32        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.06 ±346%    -100.0%       0.00        perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      2345 ±  3%      +8.0%       2532 ± 20%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    815.11 ±  4%      -0.9%     807.60 ±  5%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      2348 ±  3%      +7.4%       2522 ± 16%  perf-sched.wait_time.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
    214.34 ±  4%      -1.2%     211.68 ±  4%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     87.02 ±  9%      +2.8%      89.46 ± 13%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.23 ±346%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown]
      1.00 ±206%     -10.7%       0.90 ±202%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.20 ± 17%      +0.1%       0.20 ± 18%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.17 ± 43%      -4.1%       0.16 ± 51%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.10 ±274%     -71.7%       0.03 ± 97%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_irq_work.[unknown]
      0.09 ±127%      -0.9%       0.09 ±141%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.16 ±  7%      -5.4%       0.15 ±  3%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00       +4.1e+103%      40.81 ±300%  perf-sched.wait_time.avg.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.12 ±234%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
    114.11 ± 32%     -33.0%      76.51 ± 27%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.92 ±100%     +42.6%       1.31 ± 96%  perf-sched.wait_time.avg.ms.pipe_write.new_sync_write.vfs_write.ksys_write
      0.01 ±234%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.__get_free_pages.__pud_alloc
      0.01 ±346%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.__get_free_pages.pgd_alloc
      0.02 ±182%   +3627.7%       0.71 ±292%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.__pmd_alloc.copy_page_range
    840.95 ±212%     -99.2%       6.84 ± 78%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
      0.06 ±346%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.wp_page_copy
      0.02 ±150%   +5506.7%       1.38 ±299%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.pte_alloc_one.__pte_alloc
      1049 ±233%     -99.4%       6.60 ± 88%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__do_fault.do_fault.__handle_mm_fault
      0.00       +1.5e+100%       0.02 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__fput.task_work_run.do_exit
      0.80 ±346%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__fput.task_work_run.exit_to_user_mode_prepare
      0.01 ±234%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_prepare_creds.prepare_creds
      0.01 ±234%    +120.2%       0.03 ±152%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_task_alloc.copy_process
      1.08 ±342%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.__vmalloc_node_range.dup_task_struct
      0.00       +1.2e+102%       1.23 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__mutex_lock.isra.0
      0.00        +3.9e+99%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.00       +6.9e+101%       0.69 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__vmalloc_node_range.dup_task_struct.copy_process
      0.00        +9.1e+99%       0.01 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.cgroup_can_fork.copy_process.kernel_clone
      0.52 ±326%     -95.1%       0.03 ±230%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.change_p4d_range.change_protection.change_prot_numa
      0.01 ±346%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.copy_page_from_iter.pipe_write.new_sync_write
      1.83 ±233%     +35.6%       2.48 ±200%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.copy_page_range.dup_mmap.dup_mm
      0.00        +1.2e+99%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      1.93 ±234%    +144.5%       4.72 ±151%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.copy_pte_range.copy_page_range.dup_mmap
    516.65 ±341%     -58.8%     212.90 ±290%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00       +7.8e+101%       0.78 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.__split_vma
      1.09 ±336%    +134.4%       2.55 ±173%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.01 ±234%    +101.2%       0.02 ±152%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_fork.dup_mmap
      0.02 ±150%   +5714.0%       1.42 ±290%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.dup_mmap.dup_mm
      0.83 ±346%     -88.9%       0.09 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      8.70 ± 46%      -7.4%       8.05 ± 59%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
    363.89 ±111%    +113.9%     778.42 ± 52%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.25 ±232%     -98.7%       0.00 ±158%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.khugepaged.kthread.ret_from_fork
      0.01 ±346%     +46.0%       0.01 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process
      0.54 ±342%     -98.3%       0.01 ±299%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap
      0.01 ±234%     -33.0%       0.01 ±299%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process
      0.01 ±346%     +18.6%       0.01 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.copy_process.kernel_clone
      0.01 ±346%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.dup_mm.copy_process
      0.00       +8.1e+100%       0.08 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_flags.do_sys_openat2
      0.03 ±150%   +4053.5%       1.09 ±294%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.00       +7.1e+100%       0.07 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.03 ±346%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma
      1.08 ±339%     +28.2%       1.38 ±299%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap
      1.06 ±346%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node_trace.__get_vm_area_node.__vmalloc_node_range
      0.00         +8e+100%       0.08 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mprotect_fixup
      0.00       +1.4e+101%       0.14 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mnt_want_write.filename_create.do_mkdirat
      0.06 ±346%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.futex_exec_release.exec_mm_release
      0.00 ±234%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
     12.59 ±294%    +318.8%      52.72 ±193%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_poll.do_sys_poll
      1.00 ±346%    +150.0%       2.50 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_write.new_sync_write
      0.46 ±346%    +146.9%       1.13 ±200%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.shmem_getpage_gfp.shmem_write_begin
      1.23 ±224%     -36.3%       0.78 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
      0.00 ±155%     +30.0%       0.01 ±250%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00       +2.8e+101%       0.28 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.22 ±346%     +30.4%       0.28 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.00       +5.5e+101%       0.55 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm
      4.87            -1.5%       4.80 ±  4%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      2.81 ±  5%      +2.3%       2.88 ±  8%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    645.49 ± 20%      +3.2%     666.25 ± 18%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    121.61 ±  8%      -2.8%     118.20 ±  8%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     78.70 ±346%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.pipe_read
      0.28 ±240%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
    478.54            +0.0%     478.59        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      3.57 ±  8%      -1.1%       3.53 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      6.46 ± 15%      -7.4%       5.98 ± 15%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.01 ± 37%     -23.3%       0.01 ± 50%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    592.43            +0.3%     594.17        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      2.37 ± 10%      -5.9%       2.23 ± 12%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    528.48 ±  4%      -1.1%     522.51 ±  2%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
    999.37            +0.0%     999.38        perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.06 ±346%    -100.0%       0.00        perf-sched.wait_time.max.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      7033 ±  3%      -2.1%       6888 ±  3%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1004            +1.0%       1014 ±  2%  perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      7040 ±  3%      -2.1%       6892 ±  3%  perf-sched.wait_time.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      2707 ± 84%     -21.7%       2121 ± 81%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1021            +0.1%       1022        perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.23 ±346%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_common_interrupt.[unknown]
      1.64 ±225%     -23.0%       1.26 ±218%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     18.51 ± 88%     -24.9%      13.90 ± 19%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     19.85 ±138%     +70.9%      33.93 ± 91%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.54 ±290%     -83.2%       0.09 ±143%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_irq_work.[unknown]
      0.21 ±111%     -15.5%       0.18 ±144%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     56.26 ± 43%      -6.1%      52.81 ± 58%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00       +1.6e+104%     162.95 ±300%  perf-sched.wait_time.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.12 ±234%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
      7037 ±  3%      -2.1%       6891 ±  3%  perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.92 ±100%     +42.6%       1.31 ± 96%  perf-sched.wait_time.max.ms.pipe_write.new_sync_write.vfs_write.ksys_write
      0.01 ±234%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.__get_free_pages.__pud_alloc
      0.01 ±346%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.__get_free_pages.pgd_alloc
      0.02 ±182%   +7195.8%       1.39 ±296%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.__pmd_alloc.copy_page_range
      2071 ±149%     -99.6%       9.20 ± 77%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
      0.06 ±346%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.wp_page_copy
      0.02 ±150%   +5506.7%       1.38 ±299%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.pte_alloc_one.__pte_alloc
      1050 ±233%     -99.3%       7.80 ± 81%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__do_fault.do_fault.__handle_mm_fault
      0.00       +1.5e+100%       0.02 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__fput.task_work_run.do_exit
      0.80 ±346%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__fput.task_work_run.exit_to_user_mode_prepare
      0.01 ±234%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_prepare_creds.prepare_creds
      0.01 ±234%    +124.3%       0.03 ±152%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc.security_task_alloc.copy_process
      1.08 ±342%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node.__vmalloc_node_range.dup_task_struct
      0.00       +1.2e+102%       1.23 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__mutex_lock.isra.0
      0.00        +3.9e+99%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.00       +1.4e+102%       1.38 ±299%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__vmalloc_node_range.dup_task_struct.copy_process
      0.00        +9.1e+99%       0.01 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.cgroup_can_fork.copy_process.kernel_clone
      0.53 ±321%     -95.2%       0.03 ±230%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.change_p4d_range.change_protection.change_prot_numa
      0.01 ±346%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.copy_page_from_iter.pipe_write.new_sync_write
      1.83 ±233%     +35.6%       2.48 ±200%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.copy_page_range.dup_mmap.dup_mm
      0.00        +1.2e+99%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      2.59 ±237%    +161.9%       6.78 ±132%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.copy_pte_range.copy_page_range.dup_mmap
    518.77 ±339%     +20.8%     626.68 ±295%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00       +7.8e+101%       0.78 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.__split_vma
      1.09 ±335%    +279.1%       4.13 ±152%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.01 ±234%    +101.2%       0.02 ±152%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_fork.dup_mmap
      0.02 ±150%   +5626.4%       1.42 ±290%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.dup_mmap.dup_mm
      0.83 ±346%     -88.9%       0.09 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
     11.97 ± 28%     -12.8%      10.44 ± 49%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      3087 ±107%     +92.2%       5932 ± 33%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.59 ±231%     -99.4%       0.00 ±158%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.khugepaged.kthread.ret_from_fork
      0.01 ±346%     +46.0%       0.01 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process
      1.07 ±344%     -99.1%       0.01 ±299%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap
      0.01 ±234%     -29.0%       0.01 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process
      0.01 ±346%     +17.2%       0.01 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.copy_process.kernel_clone
      0.01 ±346%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.dup_mm.copy_process
      0.00       +8.1e+100%       0.08 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_flags.do_sys_openat2
      0.03 ±150%   +3995.6%       1.09 ±294%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.00       +7.1e+100%       0.07 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.06 ±346%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma
      1.08 ±339%     +28.2%       1.38 ±299%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap
      1.06 ±346%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node_trace.__get_vm_area_node.__vmalloc_node_range
      0.00         +8e+100%       0.08 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mprotect_fixup
      0.00       +2.8e+101%       0.28 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mnt_want_write.filename_create.do_mkdirat
      0.06 ±346%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.futex_exec_release.exec_mm_release
      0.00 ±234%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
     12.76 ±289%    +320.7%      53.67 ±189%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_poll.do_sys_poll
      1.00 ±346%    +150.0%       2.50 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_write.new_sync_write
      0.46 ±346%    +146.9%       1.13 ±200%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.shmem_getpage_gfp.shmem_write_begin
      1.66 ±226%     -52.6%       0.78 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
      1.29 ±162%     +21.6%       1.57 ±248%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00       +2.8e+101%       0.28 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.22 ±346%     +75.8%       0.38 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.00       +1.1e+102%       1.09 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm
      2177            -4.5%       2080 ± 17%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      7.54 ±116%     +35.0%      10.17 ±134%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      6690 ±  4%      -2.9%       6495 ±  4%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      5513            +0.3%       5532        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     78.70 ±346%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.pipe_read
      0.28 ±240%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
    505.00            -0.0%     505.00        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      3.57 ±  8%      -1.1%       3.53 ±  6%  perf-sched.wait_time.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
    294.68 ± 36%      +1.2%     298.19 ± 48%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.01 ± 50%     -20.5%       0.01 ± 53%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      5881 ± 26%     +19.1%       7003 ± 16%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
     12.45 ±  5%      -0.4%      12.40 ±  6%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      7414 ± 14%      -1.9%       7275 ±  9%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
    261.00            +0.0%     261.00        softirqs.BLOCK
      1.00            +0.0%       1.00        softirqs.CPU0.HI
     24558 ± 11%      -2.7%      23894 ± 17%  softirqs.CPU0.RCU
      8170 ±  5%      +0.6%       8219 ±  8%  softirqs.CPU0.SCHED
    105.00            +0.2%     105.20        softirqs.CPU0.TASKLET
      2737 ± 19%      +1.0%       2765 ± 22%  softirqs.CPU0.TIMER
      0.00          -100.0%       0.00        softirqs.CPU1.NET_TX
     24492 ±  8%      +1.0%      24739 ± 12%  softirqs.CPU1.RCU
      5792 ± 13%      +1.9%       5901 ± 15%  softirqs.CPU1.SCHED
    722.00 ± 63%      -8.3%     662.40 ± 76%  softirqs.CPU1.TIMER
      3499 ±129%      +4.1%       3644 ±172%  softirqs.CPU10.NET_RX
      1.92 ± 51%      +9.2%       2.10 ± 25%  softirqs.CPU10.NET_TX
     23422 ±  7%      -0.4%      23331 ± 11%  softirqs.CPU10.RCU
      5280 ±  8%      -1.5%       5202 ± 11%  softirqs.CPU10.SCHED
      1.23 ±302%    -100.0%       0.00        softirqs.CPU10.TASKLET
    670.23 ± 70%     +15.7%     775.20 ±144%  softirqs.CPU10.TIMER
     23400 ±  8%      +1.1%      23654 ± 11%  softirqs.CPU100.RCU
      5078            -0.5%       5052 ±  9%  softirqs.CPU100.SCHED
      0.00         +7e+101%       0.70 ±300%  softirqs.CPU100.TASKLET
    113.54 ± 11%     +76.1%     199.90 ± 95%  softirqs.CPU100.TIMER
     23000 ±  8%      +0.9%      23200 ± 11%  softirqs.CPU101.RCU
      5075            -2.2%       4965 ±  8%  softirqs.CPU101.SCHED
    124.92 ± 18%     +53.1%     191.20 ± 48%  softirqs.CPU101.TIMER
     23029 ±  8%      +1.4%      23358 ± 11%  softirqs.CPU102.RCU
      5050            -0.4%       5031 ±  8%  softirqs.CPU102.SCHED
    129.23 ± 19%     +43.6%     185.60 ± 46%  softirqs.CPU102.TIMER
     23634 ±  8%      +0.2%      23674 ± 11%  softirqs.CPU103.RCU
      5100            -1.8%       5007 ±  8%  softirqs.CPU103.SCHED
    134.77 ± 17%     +26.7%     170.70 ± 40%  softirqs.CPU103.TIMER
     23665 ±  8%      -0.3%      23588 ± 11%  softirqs.CPU104.RCU
      5089 ±  2%      -2.3%       4974 ±  8%  softirqs.CPU104.SCHED
      0.54 ±296%    -100.0%       0.00        softirqs.CPU104.TASKLET
    180.85 ± 73%      -3.9%     173.80 ± 51%  softirqs.CPU104.TIMER
     23351 ±  8%      +0.6%      23481 ± 11%  softirqs.CPU105.RCU
      4992 ±  5%      -2.6%       4860 ± 10%  softirqs.CPU105.SCHED
      0.62 ±346%    -100.0%       0.00        softirqs.CPU105.TASKLET
    135.92 ± 17%      +7.8%     146.50 ± 15%  softirqs.CPU105.TIMER
     23390 ±  8%      +1.4%      23728 ± 12%  softirqs.CPU106.RCU
      4854 ±  9%      +3.1%       5005 ±  9%  softirqs.CPU106.SCHED
      0.08 ±346%    +160.0%       0.20 ±300%  softirqs.CPU106.TASKLET
    135.69 ± 40%     +55.9%     211.50 ± 60%  softirqs.CPU106.TIMER
     23720 ± 10%      -2.0%      23240 ± 10%  softirqs.CPU107.RCU
      5041 ±  7%      -4.0%       4837 ± 11%  softirqs.CPU107.SCHED
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU107.TASKLET
    316.77 ±118%     -35.9%     203.20 ± 90%  softirqs.CPU107.TIMER
      0.00          -100.0%       0.00        softirqs.CPU108.NET_TX
     23224 ±  7%      +1.3%      23516 ± 10%  softirqs.CPU108.RCU
      5098 ±  3%      -3.0%       4946 ±  8%  softirqs.CPU108.SCHED
    130.62 ± 20%     +30.8%     170.90 ± 40%  softirqs.CPU108.TIMER
     23678 ±  9%      -0.7%      23502 ± 11%  softirqs.CPU109.RCU
      5010 ±  6%      -0.8%       4969 ±  8%  softirqs.CPU109.SCHED
      0.08 ±346%    +810.0%       0.70 ±300%  softirqs.CPU109.TASKLET
    132.38 ± 17%     +14.8%     152.00 ± 24%  softirqs.CPU109.TIMER
      4202 ±123%     -79.8%     847.60 ± 96%  softirqs.CPU11.NET_RX
      1.54 ± 48%     +17.0%       1.80 ± 33%  softirqs.CPU11.NET_TX
     23555 ±  7%      +0.8%      23736 ± 12%  softirqs.CPU11.RCU
      5150 ± 12%      -2.3%       5033 ± 10%  softirqs.CPU11.SCHED
      1.62 ±328%     -93.8%       0.10 ±300%  softirqs.CPU11.TASKLET
      1023 ±131%     -60.4%     405.10 ± 60%  softirqs.CPU11.TIMER
     23669 ±  8%      -0.6%      23531 ± 11%  softirqs.CPU110.RCU
      4945 ±  9%      -5.6%       4667 ± 19%  softirqs.CPU110.SCHED
      0.15 ±234%    -100.0%       0.00        softirqs.CPU110.TASKLET
    146.38 ± 44%     -17.5%     120.70 ± 14%  softirqs.CPU110.TIMER
     24380 ± 14%      -3.4%      23559 ± 13%  softirqs.CPU111.RCU
      5094 ±  2%      +0.0%       5096 ±  3%  softirqs.CPU111.SCHED
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU111.TASKLET
    360.15 ±134%     -28.4%     257.90 ±143%  softirqs.CPU111.TIMER
     23851 ±  8%      -0.9%      23636 ± 11%  softirqs.CPU112.RCU
      5184 ±  5%      -3.7%       4992 ±  8%  softirqs.CPU112.SCHED
    260.77 ±145%     -48.2%     135.00 ± 23%  softirqs.CPU112.TIMER
     23677 ±  8%      -0.9%      23466 ± 11%  softirqs.CPU113.RCU
      5084 ±  2%      -1.5%       5008 ±  8%  softirqs.CPU113.SCHED
      0.00         +4e+101%       0.40 ±300%  softirqs.CPU113.TASKLET
    202.23 ± 94%     -27.8%     146.10 ± 32%  softirqs.CPU113.TIMER
     23613 ±  8%      -0.2%      23566 ± 11%  softirqs.CPU114.RCU
      5040            -2.9%       4892 ± 18%  softirqs.CPU114.SCHED
    139.85 ± 28%     +42.2%     198.90 ± 65%  softirqs.CPU114.TIMER
     23874 ±  8%      -0.7%      23696 ± 11%  softirqs.CPU115.RCU
      5062            -1.9%       4967 ±  9%  softirqs.CPU115.SCHED
      0.00         +2e+102%       2.00 ±300%  softirqs.CPU115.TASKLET
    132.69 ± 20%     +16.9%     155.10 ± 23%  softirqs.CPU115.TIMER
     23145 ± 12%      +1.4%      23474 ± 11%  softirqs.CPU116.RCU
      5092            -2.9%       4944 ±  9%  softirqs.CPU116.SCHED
    151.23 ± 69%     +12.7%     170.50 ± 57%  softirqs.CPU116.TIMER
     23560 ±  8%      +2.0%      24020 ± 13%  softirqs.CPU117.RCU
      5063            -1.8%       4971 ± 10%  softirqs.CPU117.SCHED
      0.00         +2e+101%       0.20 ±300%  softirqs.CPU117.TASKLET
    126.69 ± 13%    +129.6%     290.90 ±136%  softirqs.CPU117.TIMER
     23604 ±  8%      -0.6%      23452 ± 12%  softirqs.CPU118.RCU
      5083            -2.6%       4952 ±  8%  softirqs.CPU118.SCHED
    149.54 ± 36%     -12.7%     130.50 ± 13%  softirqs.CPU118.TIMER
     22410 ± 14%      +1.1%      22658 ± 10%  softirqs.CPU119.RCU
      5081 ±  2%      -2.5%       4955 ±  9%  softirqs.CPU119.SCHED
    172.15 ± 59%     -27.7%     124.50 ± 15%  softirqs.CPU119.TIMER
      2041 ±167%     +50.2%       3065 ±181%  softirqs.CPU12.NET_RX
      1.38 ± 45%     +15.6%       1.60 ± 41%  softirqs.CPU12.NET_TX
     23423 ±  8%      +0.4%      23527 ± 12%  softirqs.CPU12.RCU
      5240 ±  8%      +0.9%       5285 ± 18%  softirqs.CPU12.SCHED
    502.08 ± 65%     +77.7%     892.00 ±152%  softirqs.CPU12.TIMER
     30453 ±  8%      -0.1%      30419 ± 11%  softirqs.CPU120.RCU
      5143            -3.3%       4973 ±  9%  softirqs.CPU120.SCHED
    590.00 ± 15%      -6.8%     549.90 ± 21%  softirqs.CPU120.TIMER
     26712 ±  6%      +0.8%      26928 ±  9%  softirqs.CPU121.RCU
      5174            -2.8%       5030 ±  9%  softirqs.CPU121.SCHED
      0.23 ±346%    -100.0%       0.00        softirqs.CPU121.TASKLET
    454.85 ± 31%     +11.0%     505.10 ± 33%  softirqs.CPU121.TIMER
     24483 ±  7%      -0.4%      24391 ± 11%  softirqs.CPU122.RCU
      5119            -0.5%       5093 ± 11%  softirqs.CPU122.SCHED
    229.69 ± 37%     +34.5%     309.00 ± 45%  softirqs.CPU122.TIMER
     24060 ±  7%      -0.4%      23971 ± 11%  softirqs.CPU123.RCU
      5150            -2.8%       5006 ± 10%  softirqs.CPU123.SCHED
    199.00 ± 43%     -11.5%     176.10 ± 45%  softirqs.CPU123.TIMER
     23794 ±  7%      -0.2%      23744 ± 11%  softirqs.CPU124.RCU
      5207 ±  4%      -4.1%       4995 ±  9%  softirqs.CPU124.SCHED
    243.23 ±107%     -39.0%     148.40 ± 12%  softirqs.CPU124.TIMER
     23634 ±  7%      +0.3%      23697 ± 11%  softirqs.CPU125.RCU
      5148            -2.5%       5021 ±  9%  softirqs.CPU125.SCHED
    158.00 ± 38%      +2.9%     162.60 ± 28%  softirqs.CPU125.TIMER
     23373 ±  7%      +4.2%      24349 ± 11%  softirqs.CPU126.RCU
      5142            -2.3%       5023 ± 10%  softirqs.CPU126.SCHED
    209.62 ± 69%     +28.7%     269.70 ±150%  softirqs.CPU126.TIMER
     24026 ±  7%      -1.1%      23757 ± 11%  softirqs.CPU127.RCU
      5132            -3.2%       4969 ±  9%  softirqs.CPU127.SCHED
    208.85 ± 59%     -23.5%     159.80 ± 17%  softirqs.CPU127.TIMER
     23285 ±  7%      +2.4%      23853 ± 10%  softirqs.CPU128.RCU
      5165 ±  2%      -2.7%       5028 ± 10%  softirqs.CPU128.SCHED
    153.31 ± 80%      -6.5%     143.30 ± 20%  softirqs.CPU128.TIMER
     23057 ±  7%      +1.4%      23379 ± 11%  softirqs.CPU129.RCU
      5164 ±  3%      -4.2%       4949 ±  9%  softirqs.CPU129.SCHED
    176.15 ±107%     -24.1%     133.70 ± 16%  softirqs.CPU129.TIMER
      2311 ±122%    +112.2%       4904 ±111%  softirqs.CPU13.NET_RX
      2.15 ± 30%     -39.6%       1.30 ± 49%  softirqs.CPU13.NET_TX
     23290 ±  8%      +0.1%      23307 ± 12%  softirqs.CPU13.RCU
      5301 ±  6%      -4.0%       5090 ± 12%  softirqs.CPU13.SCHED
      0.08 ±346%     +30.0%       0.10 ±300%  softirqs.CPU13.TASKLET
    511.69 ± 57%      -5.1%     485.80 ± 77%  softirqs.CPU13.TIMER
     22980 ±  6%      +0.7%      23138 ± 11%  softirqs.CPU130.RCU
      5179 ±  3%      -3.1%       5020 ±  9%  softirqs.CPU130.SCHED
      0.54 ±346%    -100.0%       0.00        softirqs.CPU130.TASKLET
    138.00 ± 33%     +38.5%     191.10 ± 85%  softirqs.CPU130.TIMER
     22907 ±  7%      +1.1%      23154 ± 11%  softirqs.CPU131.RCU
      5124            -2.6%       4989 ±  9%  softirqs.CPU131.SCHED
    135.69 ± 24%     +39.7%     189.50 ± 66%  softirqs.CPU131.TIMER
     22264 ± 10%      +5.4%      23465 ± 11%  softirqs.CPU132.RCU
      5146 ±  2%      -0.6%       5117 ± 11%  softirqs.CPU132.SCHED
      1.15 ±346%    -100.0%       0.00        softirqs.CPU132.TASKLET
    178.23 ± 66%     +63.8%     292.00 ±108%  softirqs.CPU132.TIMER
     23376 ±  7%      +1.2%      23649 ± 11%  softirqs.CPU133.RCU
      5143            -2.8%       4997 ±  9%  softirqs.CPU133.SCHED
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU133.TASKLET
    185.00 ± 58%      -2.9%     179.60 ± 40%  softirqs.CPU133.TIMER
     23140 ±  8%      +1.7%      23526 ± 11%  softirqs.CPU134.RCU
      5016 ±  6%      +0.0%       5018 ±  9%  softirqs.CPU134.SCHED
    135.92 ± 15%     +17.9%     160.30 ± 29%  softirqs.CPU134.TIMER
     22549 ±  7%      -0.2%      22502 ± 10%  softirqs.CPU135.RCU
      5103            -2.5%       4973 ±  9%  softirqs.CPU135.SCHED
    131.31 ± 19%     +29.2%     169.70 ± 69%  softirqs.CPU135.TIMER
     23024 ±  6%      +1.8%      23435 ± 11%  softirqs.CPU136.RCU
      5189 ±  3%      -3.7%       4994 ±  9%  softirqs.CPU136.SCHED
      0.38 ±346%    -100.0%       0.00        softirqs.CPU136.TASKLET
    244.69 ±100%     -30.0%     171.40 ± 62%  softirqs.CPU136.TIMER
     22928 ±  6%      +0.7%      23088 ± 11%  softirqs.CPU137.RCU
      5127            -2.4%       5004 ±  9%  softirqs.CPU137.SCHED
    145.62 ± 40%      -5.0%     138.30 ± 29%  softirqs.CPU137.TIMER
     22949 ±  7%      +1.4%      23263 ± 11%  softirqs.CPU138.RCU
      5116            -3.3%       4948 ±  9%  softirqs.CPU138.SCHED
      1.08 ±346%    -100.0%       0.00        softirqs.CPU138.TASKLET
    129.00 ± 33%     +20.3%     155.20 ± 55%  softirqs.CPU138.TIMER
     23199 ±  6%      +1.6%      23569 ± 11%  softirqs.CPU139.RCU
      5109            -2.6%       4978 ±  9%  softirqs.CPU139.SCHED
      0.15 ±234%    -100.0%       0.00        softirqs.CPU139.TASKLET
    131.08 ± 24%      -5.8%     123.50 ± 25%  softirqs.CPU139.TIMER
     23978 ± 12%      -1.1%      23707 ± 11%  softirqs.CPU14.RCU
      5019 ±  8%      -6.3%       4700 ± 15%  softirqs.CPU14.SCHED
      0.00         +2e+101%       0.20 ±200%  softirqs.CPU14.TASKLET
    258.15 ±137%      -8.2%     236.90 ± 68%  softirqs.CPU14.TIMER
     23233 ±  7%      +0.7%      23399 ± 11%  softirqs.CPU140.RCU
      5042 ±  7%      -3.8%       4849 ± 12%  softirqs.CPU140.SCHED
    167.00 ± 84%     -18.1%     136.80 ± 21%  softirqs.CPU140.TIMER
     22956 ±  6%      +0.8%      23133 ± 11%  softirqs.CPU141.RCU
      5181 ±  4%      -4.2%       4963 ±  9%  softirqs.CPU141.SCHED
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU141.TASKLET
    192.38 ±114%     -28.4%     137.70 ± 17%  softirqs.CPU141.TIMER
      0.08 ±346%    -100.0%       0.00        softirqs.CPU142.NET_TX
     22820 ±  6%      +2.9%      23477 ± 11%  softirqs.CPU142.RCU
      5161 ±  3%      -3.3%       4990 ±  9%  softirqs.CPU142.SCHED
    170.92 ±105%     -33.9%     113.00 ± 22%  softirqs.CPU142.TIMER
     22785 ±  7%      +2.3%      23313 ± 11%  softirqs.CPU143.RCU
      5064 ±  7%      -0.6%       5032 ±  9%  softirqs.CPU143.SCHED
    159.62 ± 73%      -0.3%     159.10 ± 41%  softirqs.CPU143.TIMER
     30215 ±  6%      +1.1%      30536 ±  9%  softirqs.CPU144.RCU
      5094            -0.9%       5048 ± 10%  softirqs.CPU144.SCHED
    651.69 ± 10%      +6.8%     696.30 ± 39%  softirqs.CPU144.TIMER
     26799 ±  6%      +0.7%      26976 ± 10%  softirqs.CPU145.RCU
      5164 ±  2%      -2.6%       5031 ±  9%  softirqs.CPU145.SCHED
    496.31 ± 30%      +0.3%     497.60 ± 26%  softirqs.CPU145.TIMER
     24536 ±  7%      +1.0%      24779 ± 10%  softirqs.CPU146.RCU
      5061 ±  3%      -2.0%       4961 ±  9%  softirqs.CPU146.SCHED
    269.92 ± 58%     -22.2%     210.00 ± 10%  softirqs.CPU146.TIMER
     24003 ±  7%      +1.1%      24275 ± 10%  softirqs.CPU147.RCU
      5101            -2.1%       4994 ± 10%  softirqs.CPU147.SCHED
      0.08 ±346%    -100.0%       0.00        softirqs.CPU147.TASKLET
    138.23 ± 14%     +27.5%     176.20 ± 37%  softirqs.CPU147.TIMER
     23801 ±  8%      +2.4%      24368 ± 11%  softirqs.CPU148.RCU
      5083            -2.0%       4982 ±  9%  softirqs.CPU148.SCHED
      0.00         +2e+101%       0.20 ±300%  softirqs.CPU148.TASKLET
    148.85 ± 32%      -1.8%     146.20 ± 19%  softirqs.CPU148.TIMER
     23408 ± 11%      +3.5%      24218 ± 11%  softirqs.CPU149.RCU
      5084            -2.2%       4970 ±  9%  softirqs.CPU149.SCHED
    141.85 ± 36%      -3.6%     136.80 ± 25%  softirqs.CPU149.TIMER
      0.08 ±346%    -100.0%       0.00        softirqs.CPU15.NET_TX
     23380 ±  8%      +2.5%      23976 ± 11%  softirqs.CPU15.RCU
      5048            -1.3%       4982 ± 10%  softirqs.CPU15.SCHED
      2.00            +5.0%       2.10 ± 14%  softirqs.CPU15.TASKLET
    123.08 ± 10%    +151.5%     309.50 ±129%  softirqs.CPU15.TIMER
     23843 ±  7%      +2.2%      24356 ± 10%  softirqs.CPU150.RCU
      5100            -8.1%       4688 ± 14%  softirqs.CPU150.SCHED
    156.38 ± 62%      -1.4%     154.20 ± 31%  softirqs.CPU150.TIMER
     23737 ±  7%      +1.5%      24094 ± 11%  softirqs.CPU151.RCU
      5065            -0.4%       5045 ± 10%  softirqs.CPU151.SCHED
      0.00       +1.6e+102%       1.60 ±300%  softirqs.CPU151.TASKLET
    147.77 ± 32%      -0.4%     147.20 ±  9%  softirqs.CPU151.TIMER
     23685 ±  7%      +1.1%      23954 ± 11%  softirqs.CPU152.RCU
      5098            -2.4%       4973 ±  9%  softirqs.CPU152.SCHED
      0.08 ±346%    +160.0%       0.20 ±300%  softirqs.CPU152.TASKLET
    132.85 ± 12%     +18.0%     156.80 ± 26%  softirqs.CPU152.TIMER
     24238 ±  8%      -0.8%      24049 ± 10%  softirqs.CPU153.RCU
      5133 ±  2%      -2.9%       4985 ±  9%  softirqs.CPU153.SCHED
    235.77 ±157%     -33.3%     157.30 ± 40%  softirqs.CPU153.TIMER
     23903 ±  7%      +1.4%      24244 ± 11%  softirqs.CPU154.RCU
      5109            -1.8%       5016 ±  9%  softirqs.CPU154.SCHED
      0.08 ±346%   +2240.0%       1.80 ±300%  softirqs.CPU154.TASKLET
    156.54 ± 49%      -1.5%     154.20 ± 26%  softirqs.CPU154.TIMER
     23731 ±  7%      +2.7%      24379 ± 11%  softirqs.CPU155.RCU
      5096            -2.1%       4991 ±  9%  softirqs.CPU155.SCHED
      0.00         +3e+101%       0.30 ±300%  softirqs.CPU155.TASKLET
    131.77 ± 15%      +8.7%     143.20 ± 24%  softirqs.CPU155.TIMER
     23616 ±  7%      +1.7%      24009 ± 11%  softirqs.CPU156.RCU
      5120            -4.2%       4908 ± 12%  softirqs.CPU156.SCHED
    143.77 ± 49%    +131.2%     332.40 ± 79%  softirqs.CPU156.TIMER
     23674 ±  7%      +1.5%      24020 ± 11%  softirqs.CPU157.RCU
      5094            -2.4%       4972 ±  9%  softirqs.CPU157.SCHED
    135.38 ± 30%      +7.1%     145.00 ± 15%  softirqs.CPU157.TIMER
     23662 ±  7%      +1.8%      24086 ± 10%  softirqs.CPU158.RCU
      5137 ±  2%      -2.8%       4995 ±  9%  softirqs.CPU158.SCHED
    153.85 ± 59%      -3.9%     147.90 ± 38%  softirqs.CPU158.TIMER
     23730 ±  7%      +1.2%      24025 ± 11%  softirqs.CPU159.RCU
      5130 ±  4%      -3.3%       4960 ±  9%  softirqs.CPU159.SCHED
      0.08 ±346%    +420.0%       0.40 ±300%  softirqs.CPU159.TASKLET
    195.69 ±112%     -26.2%     144.40 ± 19%  softirqs.CPU159.TIMER
     24038 ±  9%      +1.4%      24382 ± 12%  softirqs.CPU16.RCU
      5060            -1.5%       4984 ±  9%  softirqs.CPU16.SCHED
      2.00            +0.0%       2.00        softirqs.CPU16.TASKLET
    146.31 ± 23%     +84.8%     270.40 ±145%  softirqs.CPU16.TIMER
     23888 ±  7%      +0.6%      24035 ± 11%  softirqs.CPU160.RCU
      5064            -2.0%       4961 ± 10%  softirqs.CPU160.SCHED
    123.15 ± 15%     +39.8%     172.20 ± 52%  softirqs.CPU160.TIMER
     23919 ±  8%      +1.0%      24164 ± 12%  softirqs.CPU161.RCU
      5107            -2.2%       4994 ±  6%  softirqs.CPU161.SCHED
    128.15 ± 10%     +69.1%     216.70 ±121%  softirqs.CPU161.TIMER
     23612 ±  7%      +0.3%      23689 ± 12%  softirqs.CPU162.RCU
      5096            -2.9%       4946 ±  9%  softirqs.CPU162.SCHED
    133.92 ± 30%      -8.0%     123.20 ± 22%  softirqs.CPU162.TIMER
     24283 ±  8%      -0.7%      24109 ± 13%  softirqs.CPU163.RCU
      5119 ±  3%      -2.6%       4988 ±  9%  softirqs.CPU163.SCHED
      1.54 ±346%     -93.5%       0.10 ±300%  softirqs.CPU163.TASKLET
    127.38 ± 13%     +33.5%     170.00 ± 63%  softirqs.CPU163.TIMER
     23654 ±  8%      +0.6%      23787 ± 12%  softirqs.CPU164.RCU
      5081            -2.2%       4970 ±  9%  softirqs.CPU164.SCHED
    150.23 ± 51%      -6.2%     140.90 ± 16%  softirqs.CPU164.TIMER
     23963 ±  8%      -0.9%      23750 ± 12%  softirqs.CPU165.RCU
      5097            -5.3%       4824 ± 18%  softirqs.CPU165.SCHED
    137.00 ± 20%      +1.4%     138.90 ± 24%  softirqs.CPU165.TIMER
     23955 ±  8%      +0.3%      24024 ± 11%  softirqs.CPU166.RCU
      5115            -2.0%       5014 ±  9%  softirqs.CPU166.SCHED
      1.15 ±346%     -65.3%       0.40 ±300%  softirqs.CPU166.TASKLET
    132.31 ± 22%     +22.4%     161.90 ± 60%  softirqs.CPU166.TIMER
     23770 ±  7%      +1.7%      24171 ± 11%  softirqs.CPU167.RCU
      5173 ±  4%      -4.5%       4941 ±  9%  softirqs.CPU167.SCHED
      0.08 ±346%     +30.0%       0.10 ±300%  softirqs.CPU167.TASKLET
    206.62 ±125%     -34.6%     135.10 ± 21%  softirqs.CPU167.TIMER
     28920 ±  6%      -1.3%      28537 ± 10%  softirqs.CPU168.RCU
      5142 ±  3%      +0.4%       5164 ± 12%  softirqs.CPU168.SCHED
    647.38 ± 58%     +49.6%     968.80 ± 89%  softirqs.CPU168.TIMER
     24689 ±  5%      -1.0%      24439 ± 10%  softirqs.CPU169.RCU
      5107            +0.2%       5117 ± 11%  softirqs.CPU169.SCHED
      1.54 ±346%     -67.5%       0.50 ±300%  softirqs.CPU169.TASKLET
    394.08 ± 27%     +28.4%     506.00 ± 74%  softirqs.CPU169.TIMER
     23671 ±  9%      -0.2%      23634 ± 11%  softirqs.CPU17.RCU
      4952 ±  7%      -0.3%       4937 ±  8%  softirqs.CPU17.SCHED
      2.00           -10.0%       1.80 ± 33%  softirqs.CPU17.TASKLET
    178.46 ± 54%     -22.7%     137.90 ± 15%  softirqs.CPU17.TIMER
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU170.NET_TX
     22473 ±  7%      -1.1%      22218 ± 11%  softirqs.CPU170.RCU
      5087            -0.0%       5086 ± 11%  softirqs.CPU170.SCHED
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU170.TASKLET
    201.54 ± 46%     +62.8%     328.20 ±113%  softirqs.CPU170.TIMER
     21968 ±  7%      +0.7%      22115 ± 12%  softirqs.CPU171.RCU
      5167 ±  3%      -3.7%       4976 ±  9%  softirqs.CPU171.SCHED
      0.08 ±346%    -100.0%       0.00        softirqs.CPU171.TASKLET
    225.08 ±164%     -41.5%     131.60 ± 22%  softirqs.CPU171.TIMER
     21864 ±  7%      -0.3%      21800 ± 11%  softirqs.CPU172.RCU
      5092            +0.7%       5128 ± 10%  softirqs.CPU172.SCHED
    143.38 ± 50%     +78.9%     256.50 ±149%  softirqs.CPU172.TIMER
     22411 ± 11%      -1.6%      22055 ± 11%  softirqs.CPU173.RCU
      5147 ±  2%      -0.8%       5104 ±  9%  softirqs.CPU173.SCHED
      0.00         +2e+102%       2.00 ±300%  softirqs.CPU173.TASKLET
    232.23 ±156%     -36.8%     146.80 ± 63%  softirqs.CPU173.TIMER
     21786 ±  7%      +3.3%      22507 ± 11%  softirqs.CPU174.RCU
      5136            -0.1%       5132 ± 10%  softirqs.CPU174.SCHED
    111.54 ± 70%    +259.4%     400.90 ±134%  softirqs.CPU174.TIMER
     21853 ±  7%      -1.7%      21488 ± 12%  softirqs.CPU175.RCU
      5117 ±  2%      -2.3%       4997 ±  9%  softirqs.CPU175.SCHED
    158.15 ± 78%     -10.2%     142.10 ± 27%  softirqs.CPU175.TIMER
     22017 ±  7%      +2.3%      22515 ± 18%  softirqs.CPU176.RCU
      5099            -1.5%       5022 ±  9%  softirqs.CPU176.SCHED
    108.15 ±  8%    +145.6%     265.60 ±148%  softirqs.CPU176.TIMER
     21719 ±  7%      +0.2%      21757 ± 11%  softirqs.CPU177.RCU
      5102            -1.7%       5016 ±  9%  softirqs.CPU177.SCHED
    114.15 ± 19%     +31.8%     150.50 ± 42%  softirqs.CPU177.TIMER
     21806 ±  8%      -0.4%      21724 ± 11%  softirqs.CPU178.RCU
      5099            -2.2%       4986 ±  9%  softirqs.CPU178.SCHED
      0.08 ±346%    -100.0%       0.00        softirqs.CPU178.TASKLET
    118.85 ± 23%      +9.5%     130.10 ± 27%  softirqs.CPU178.TIMER
     21944 ±  7%      -0.1%      21926 ± 11%  softirqs.CPU179.RCU
      5125            -2.9%       4977 ±  9%  softirqs.CPU179.SCHED
      0.00       +1.1e+102%       1.10 ±300%  softirqs.CPU179.TASKLET
    154.54 ± 99%      -8.6%     141.20 ± 19%  softirqs.CPU179.TIMER
      0.00       +2.6e+103%      26.10 ±300%  softirqs.CPU18.BLOCK
     23845 ±  9%      +0.7%      24012 ± 12%  softirqs.CPU18.RCU
      4983 ±  9%      -2.8%       4842 ± 17%  softirqs.CPU18.SCHED
      2.00           -10.0%       1.80 ± 33%  softirqs.CPU18.TASKLET
    133.00 ± 13%     +33.3%     177.30 ± 62%  softirqs.CPU18.TIMER
     21796 ±  7%      +1.1%      22025 ± 11%  softirqs.CPU180.RCU
      5113            -1.9%       5014 ±  9%  softirqs.CPU180.SCHED
    121.00 ± 30%      +3.7%     125.50 ± 27%  softirqs.CPU180.TIMER
     21701 ±  7%      +0.6%      21830 ± 11%  softirqs.CPU181.RCU
      5100            -1.7%       5014 ±  9%  softirqs.CPU181.SCHED
    124.92 ± 28%      +4.3%     130.30 ± 19%  softirqs.CPU181.TIMER
     21790 ±  7%      +0.3%      21862 ± 11%  softirqs.CPU182.RCU
      5111            -2.0%       5007 ±  9%  softirqs.CPU182.SCHED
    115.69 ± 20%     +65.3%     191.20 ± 59%  softirqs.CPU182.TIMER
     21490 ±  7%      -0.5%      21388 ± 12%  softirqs.CPU183.RCU
      5093            -1.8%       5000 ±  9%  softirqs.CPU183.SCHED
    126.23 ± 37%     -15.3%     106.90 ± 16%  softirqs.CPU183.TIMER
     21764 ±  7%      -0.3%      21699 ± 11%  softirqs.CPU184.RCU
      5098            -2.4%       4975 ±  9%  softirqs.CPU184.SCHED
    118.62 ± 17%      +2.1%     121.10 ± 23%  softirqs.CPU184.TIMER
     21870 ±  7%      +2.6%      22434 ± 12%  softirqs.CPU185.RCU
      5093            -1.3%       5028 ±  9%  softirqs.CPU185.SCHED
      0.31 ±346%    -100.0%       0.00        softirqs.CPU185.TASKLET
    108.15 ± 17%    +163.3%     284.80 ±140%  softirqs.CPU185.TIMER
     21940 ±  7%      -0.0%      21931 ± 11%  softirqs.CPU186.RCU
      5116            -2.9%       4969 ±  9%  softirqs.CPU186.SCHED
      1.23 ±346%    -100.0%       0.00        softirqs.CPU186.TASKLET
    122.69 ± 15%      -8.5%     112.30 ± 15%  softirqs.CPU186.TIMER
     22209 ±  6%      -1.0%      21977 ± 11%  softirqs.CPU187.RCU
      5139 ±  4%      -3.2%       4973 ±  9%  softirqs.CPU187.SCHED
    149.46 ±129%     -38.3%      92.20 ± 23%  softirqs.CPU187.TIMER
     21688 ±  7%      -0.2%      21646 ± 11%  softirqs.CPU188.RCU
      5123            -2.4%       5002 ±  9%  softirqs.CPU188.SCHED
    178.85 ± 97%     -33.3%     119.30 ± 18%  softirqs.CPU188.TIMER
     21817 ±  7%      -0.3%      21742 ± 11%  softirqs.CPU189.RCU
      5249 ±  7%      -5.2%       4974 ±  9%  softirqs.CPU189.SCHED
    309.62 ±211%     -51.2%     151.20 ± 67%  softirqs.CPU189.TIMER
      0.00         +3e+101%       0.30 ±300%  softirqs.CPU19.BLOCK
     24200 ±  8%      -0.6%      24061 ± 11%  softirqs.CPU19.RCU
      5093 ±  2%      -2.8%       4949 ±  9%  softirqs.CPU19.SCHED
      2.69 ± 89%     -25.7%       2.00        softirqs.CPU19.TASKLET
    213.54 ± 73%      -0.0%     213.50 ± 72%  softirqs.CPU19.TIMER
     21866 ±  7%      +0.4%      21961 ± 11%  softirqs.CPU190.RCU
      5218 ±  6%      -4.5%       4984 ±  9%  softirqs.CPU190.SCHED
    317.15 ±193%     -61.9%     120.80 ± 30%  softirqs.CPU190.TIMER
     22530 ±  6%      +1.3%      22822 ± 11%  softirqs.CPU191.RCU
      5096 ±  3%      -1.6%       5014 ±  8%  softirqs.CPU191.SCHED
    163.85 ± 14%      +5.3%     172.50 ± 12%  softirqs.CPU191.TIMER
     23855 ±  8%      +1.0%      24084 ± 13%  softirqs.CPU2.RCU
      5199            +0.4%       5218 ± 11%  softirqs.CPU2.SCHED
    220.69 ± 19%     +94.9%     430.10 ± 93%  softirqs.CPU2.TIMER
      0.00       +2.6e+103%      25.80 ±299%  softirqs.CPU20.BLOCK
     23994 ±  8%      +0.4%      24097 ± 10%  softirqs.CPU20.RCU
      5101            -5.8%       4807 ± 12%  softirqs.CPU20.SCHED
      1.92 ± 32%      -6.4%       1.80 ± 33%  softirqs.CPU20.TASKLET
    170.69 ± 77%      -2.3%     166.80 ± 38%  softirqs.CPU20.TIMER
     23880 ±  9%      +0.6%      24017 ± 11%  softirqs.CPU21.RCU
      4936 ±  8%      +1.4%       5003 ±  8%  softirqs.CPU21.SCHED
      2.00           -40.0%       1.20 ± 81%  softirqs.CPU21.TASKLET
    134.69 ± 21%    +109.4%     282.10 ± 66%  softirqs.CPU21.TIMER
      0.00       +2.6e+103%      26.10 ±300%  softirqs.CPU22.BLOCK
     23792 ±  9%      -0.7%      23625 ± 11%  softirqs.CPU22.RCU
      5044            -6.3%       4727 ± 18%  softirqs.CPU22.SCHED
      1.85 ± 28%     -13.3%       1.60 ± 50%  softirqs.CPU22.TASKLET
    129.31 ± 13%     +34.6%     174.10 ± 50%  softirqs.CPU22.TIMER
     40.15 ±234%     +95.0%      78.30 ±152%  softirqs.CPU23.BLOCK
     23804 ±  8%      +0.8%      23989 ± 11%  softirqs.CPU23.RCU
      4959 ±  8%      -1.7%       4872 ±  9%  softirqs.CPU23.SCHED
      0.38 ±191%    +108.0%       0.80 ±122%  softirqs.CPU23.TASKLET
    177.00 ± 41%     -13.2%     153.70 ± 19%  softirqs.CPU23.TIMER
     24053 ± 11%      +1.1%      24318 ± 11%  softirqs.CPU24.RCU
      5081            -2.3%       4963 ±  9%  softirqs.CPU24.SCHED
      2.00            +0.0%       2.00        softirqs.CPU24.TASKLET
    316.31 ± 11%      +1.9%     322.20 ±  6%  softirqs.CPU24.TIMER
     25382 ±  6%      +0.1%      25410 ± 11%  softirqs.CPU25.RCU
      5091 ±  2%      -2.3%       4973 ±  9%  softirqs.CPU25.SCHED
      2.08 ± 12%      -3.7%       2.00        softirqs.CPU25.TASKLET
    326.54 ± 20%      +8.7%     354.90 ± 29%  softirqs.CPU25.TIMER
     24641 ±  6%      -0.3%      24572 ± 11%  softirqs.CPU26.RCU
      5102            -3.2%       4937 ±  9%  softirqs.CPU26.SCHED
      2.00            +5.0%       2.10 ± 14%  softirqs.CPU26.TASKLET
    208.69 ±  6%     +19.3%     248.90 ± 41%  softirqs.CPU26.TIMER
     24538 ±  6%      -0.1%      24508 ± 11%  softirqs.CPU27.RCU
      5233 ±  5%      -5.1%       4964 ±  9%  softirqs.CPU27.SCHED
      2.08 ± 12%      -3.7%       2.00        softirqs.CPU27.TASKLET
    326.08 ±127%     -50.0%     163.00 ± 42%  softirqs.CPU27.TIMER
     24274 ±  6%      -0.1%      24251 ± 11%  softirqs.CPU28.RCU
      5099            -2.2%       4986 ± 10%  softirqs.CPU28.SCHED
      2.00            +0.0%       2.00        softirqs.CPU28.TASKLET
    149.23 ± 26%      -4.1%     143.10 ± 25%  softirqs.CPU28.TIMER
     24250 ±  6%      -0.4%      24155 ± 12%  softirqs.CPU29.RCU
      5058            -1.9%       4959 ± 10%  softirqs.CPU29.SCHED
      2.00            +0.0%       2.00        softirqs.CPU29.TASKLET
    149.00 ± 26%      -7.2%     138.30 ± 17%  softirqs.CPU29.TIMER
     24064 ±  9%      -1.7%      23665 ± 12%  softirqs.CPU3.RCU
      5028 ±  7%      -0.3%       5011 ±  8%  softirqs.CPU3.SCHED
    290.31 ±121%     -49.5%     146.60 ± 18%  softirqs.CPU3.TIMER
     23913 ±  6%      +0.5%      24025 ± 11%  softirqs.CPU30.RCU
      5040            -1.5%       4964 ±  9%  softirqs.CPU30.SCHED
      2.92 ±109%     -31.6%       2.00        softirqs.CPU30.TASKLET
    140.00 ± 20%      -9.3%     127.00 ± 21%  softirqs.CPU30.TIMER
     24411 ±  6%      -0.8%      24214 ± 11%  softirqs.CPU31.RCU
      5053            -1.5%       4976 ±  9%  softirqs.CPU31.SCHED
      2.00            -5.0%       1.90 ± 15%  softirqs.CPU31.TASKLET
    179.69 ± 49%     -18.2%     147.00 ± 15%  softirqs.CPU31.TIMER
     24604 ±  6%      +0.3%      24683 ± 10%  softirqs.CPU32.RCU
      5119 ±  4%      -2.5%       4989 ±  9%  softirqs.CPU32.SCHED
    151.62 ± 25%     +13.2%     171.70 ± 44%  softirqs.CPU32.TIMER
     24280 ±  6%      +1.0%      24522 ± 10%  softirqs.CPU33.RCU
      5063            -2.0%       4964 ±  9%  softirqs.CPU33.SCHED
    152.15 ± 37%      +3.4%     157.30 ± 29%  softirqs.CPU33.TIMER
     24192 ±  5%      -1.7%      23780 ± 15%  softirqs.CPU34.RCU
      5070            -2.1%       4962 ±  9%  softirqs.CPU34.SCHED
      0.15 ±346%    -100.0%       0.00        softirqs.CPU34.TASKLET
    138.69 ± 17%      -4.2%     132.80 ± 35%  softirqs.CPU34.TIMER
     24203 ±  6%      +0.8%      24386 ± 10%  softirqs.CPU35.RCU
      5094            -2.5%       4966 ±  9%  softirqs.CPU35.SCHED
      0.08 ±346%    -100.0%       0.00        softirqs.CPU35.TASKLET
    146.69 ± 42%      -2.0%     143.80 ± 12%  softirqs.CPU35.TIMER
     24098 ±  6%      +1.4%      24440 ± 10%  softirqs.CPU36.RCU
      5073            -2.0%       4970 ±  9%  softirqs.CPU36.SCHED
      0.31 ±346%    -100.0%       0.00        softirqs.CPU36.TASKLET
    156.00 ± 48%      +0.8%     157.30 ± 30%  softirqs.CPU36.TIMER
     24786 ±  8%      -1.0%      24533 ± 10%  softirqs.CPU37.RCU
      4983 ±  7%      -0.6%       4955 ±  9%  softirqs.CPU37.SCHED
    147.23 ± 12%      +9.0%     160.50 ± 20%  softirqs.CPU37.TIMER
     24052 ± 11%      +2.2%      24590 ± 10%  softirqs.CPU38.RCU
      5098            -5.5%       4817 ± 12%  softirqs.CPU38.SCHED
      0.46 ±346%    -100.0%       0.00        softirqs.CPU38.TASKLET
    145.23 ± 19%     +26.5%     183.70 ± 55%  softirqs.CPU38.TIMER
     24594 ±  6%      -0.5%      24480 ± 10%  softirqs.CPU39.RCU
      5215 ±  9%      -4.6%       4976 ±  9%  softirqs.CPU39.SCHED
    326.31 ±158%     -53.0%     153.40 ± 26%  softirqs.CPU39.TIMER
     23012 ± 11%      +3.0%      23701 ± 12%  softirqs.CPU4.RCU
      4989 ±  9%      -4.7%       4754 ± 19%  softirqs.CPU4.SCHED
      0.08 ±346%     +30.0%       0.10 ±300%  softirqs.CPU4.TASKLET
    151.54 ± 48%     +45.6%     220.60 ± 65%  softirqs.CPU4.TIMER
     24398 ±  6%      +0.5%      24517 ± 10%  softirqs.CPU40.RCU
      5085            -2.0%       4983 ±  9%  softirqs.CPU40.SCHED
    133.46 ± 20%      +8.1%     144.30 ± 21%  softirqs.CPU40.TIMER
     24289 ±  5%      +0.3%      24370 ± 10%  softirqs.CPU41.RCU
      4958 ±  6%      +0.3%       4973 ±  9%  softirqs.CPU41.SCHED
    166.08 ± 34%     -14.0%     142.80 ± 25%  softirqs.CPU41.TIMER
     24442 ±  6%      +0.2%      24491 ± 10%  softirqs.CPU42.RCU
      4973 ±  7%      -0.4%       4953 ±  9%  softirqs.CPU42.SCHED
    154.08 ± 28%      -8.5%     141.00 ± 24%  softirqs.CPU42.TIMER
     24742 ±  7%      +0.4%      24833 ± 10%  softirqs.CPU43.RCU
      5097            -2.8%       4953 ± 10%  softirqs.CPU43.SCHED
      0.15 ±234%    -100.0%       0.00        softirqs.CPU43.TASKLET
    136.31 ± 27%      +5.6%     143.90 ± 20%  softirqs.CPU43.TIMER
     24492 ±  6%      +0.4%      24596 ± 10%  softirqs.CPU44.RCU
      5102            -2.6%       4969 ±  9%  softirqs.CPU44.SCHED
    184.85 ± 58%     -22.3%     143.70 ± 24%  softirqs.CPU44.TIMER
      0.08 ±346%    -100.0%       0.00        softirqs.CPU45.NET_TX
     24324 ±  6%      +0.4%      24419 ± 10%  softirqs.CPU45.RCU
      5159 ±  2%      -3.9%       4956 ±  9%  softirqs.CPU45.SCHED
    221.69 ± 49%     -29.1%     157.10 ± 26%  softirqs.CPU45.TIMER
     24197 ±  5%      +0.9%      24406 ± 10%  softirqs.CPU46.RCU
      5178 ±  2%      -4.8%       4931 ±  9%  softirqs.CPU46.SCHED
      0.23 ±346%    -100.0%       0.00        softirqs.CPU46.TASKLET
    241.46 ± 73%     -49.8%     121.10 ± 20%  softirqs.CPU46.TIMER
     24169 ±  6%      +0.6%      24303 ± 10%  softirqs.CPU47.RCU
      5181 ±  5%      -3.7%       4987 ±  9%  softirqs.CPU47.SCHED
      0.08 ±346%    -100.0%       0.00        softirqs.CPU47.TASKLET
    257.31 ±119%     -15.9%     216.40 ± 74%  softirqs.CPU47.TIMER
     22815 ±  7%      +0.6%      22942 ± 10%  softirqs.CPU48.RCU
      5040            -1.6%       4958 ±  9%  softirqs.CPU48.SCHED
      2.08 ± 12%      -3.7%       2.00        softirqs.CPU48.TASKLET
    352.23 ±  7%      -1.9%     345.40 ± 10%  softirqs.CPU48.TIMER
     23776 ±  7%      -0.3%      23703 ± 10%  softirqs.CPU49.RCU
      5128            -2.9%       4982 ± 10%  softirqs.CPU49.SCHED
      2.00            +0.0%       2.00        softirqs.CPU49.TASKLET
    317.85 ± 12%      -2.1%     311.20 ± 10%  softirqs.CPU49.TIMER
     23571 ±  8%      +1.2%      23844 ± 11%  softirqs.CPU5.RCU
      5105 ±  2%      -1.6%       5021 ±  9%  softirqs.CPU5.SCHED
      0.08 ±346%    -100.0%       0.00        softirqs.CPU5.TASKLET
    162.69 ± 90%     +11.9%     182.10 ± 58%  softirqs.CPU5.TIMER
     23045 ±  7%      -0.2%      23006 ± 10%  softirqs.CPU50.RCU
      5095 ±  2%      -2.8%       4952 ±  9%  softirqs.CPU50.SCHED
      2.15 ± 24%      -7.1%       2.00        softirqs.CPU50.TASKLET
    211.69 ± 38%      -8.4%     193.90 ±  8%  softirqs.CPU50.TIMER
     23186 ±  7%      -1.1%      22938 ± 11%  softirqs.CPU51.RCU
      5069            -2.5%       4942 ±  9%  softirqs.CPU51.SCHED
      1.92 ± 13%      +4.0%       2.00        softirqs.CPU51.TASKLET
    121.38 ± 12%      +7.3%     130.20 ± 21%  softirqs.CPU51.TIMER
     22193 ± 11%      +3.4%      22954 ± 10%  softirqs.CPU52.RCU
      5067            -2.5%       4940 ±  9%  softirqs.CPU52.SCHED
      2.00           +10.0%       2.20 ± 18%  softirqs.CPU52.TASKLET
    127.92 ± 36%     +10.4%     141.20 ± 36%  softirqs.CPU52.TIMER
     22555 ±  7%      +0.9%      22755 ± 11%  softirqs.CPU53.RCU
      5082            -2.3%       4968 ±  9%  softirqs.CPU53.SCHED
      2.00            +5.0%       2.10 ± 14%  softirqs.CPU53.TASKLET
    199.46 ± 56%     -39.9%     119.90 ± 21%  softirqs.CPU53.TIMER
     22530 ±  7%      +1.7%      22909 ± 11%  softirqs.CPU54.RCU
      5078            -1.7%       4994 ±  9%  softirqs.CPU54.SCHED
      2.00           +55.0%       3.10 ±106%  softirqs.CPU54.TASKLET
    117.23 ± 29%      -2.1%     114.80 ± 13%  softirqs.CPU54.TIMER
     22903 ±  7%      -0.4%      22812 ± 11%  softirqs.CPU55.RCU
      5038            -1.7%       4954 ±  9%  softirqs.CPU55.SCHED
      2.00            +0.0%       2.00        softirqs.CPU55.TASKLET
    109.23 ± 10%     +34.3%     146.70 ± 40%  softirqs.CPU55.TIMER
     22784 ±  8%      -0.2%      22730 ± 11%  softirqs.CPU56.RCU
      5028            -1.7%       4945 ±  9%  softirqs.CPU56.SCHED
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU56.TASKLET
    115.85 ± 27%     +37.8%     159.60 ± 54%  softirqs.CPU56.TIMER
     22395 ±  7%      +1.5%      22730 ± 10%  softirqs.CPU57.RCU
      5068            +0.1%       5072 ± 11%  softirqs.CPU57.SCHED
      0.15 ±346%    -100.0%       0.00        softirqs.CPU57.TASKLET
    116.85 ± 15%     +92.5%     224.90 ±121%  softirqs.CPU57.TIMER
     22529 ±  7%      +0.8%      22717 ± 10%  softirqs.CPU58.RCU
      5060            -1.5%       4985 ± 10%  softirqs.CPU58.SCHED
    109.54 ± 19%     +22.7%     134.40 ± 29%  softirqs.CPU58.TIMER
     22334 ±  7%      +2.0%      22780 ± 10%  softirqs.CPU59.RCU
      5054            -1.6%       4972 ±  9%  softirqs.CPU59.SCHED
    117.62 ± 16%     +29.9%     152.80 ± 62%  softirqs.CPU59.TIMER
      1.00           +20.0%       1.20 ± 33%  softirqs.CPU6.HI
     23446 ±  7%      +1.4%      23777 ± 12%  softirqs.CPU6.RCU
      4971 ±  7%      -0.1%       4967 ±  8%  softirqs.CPU6.SCHED
     36.08            +0.3%      36.20        softirqs.CPU6.TASKLET
    171.31 ± 74%      +0.6%     172.30 ± 65%  softirqs.CPU6.TIMER
     22760 ±  7%      +0.7%      22914 ± 11%  softirqs.CPU60.RCU
      5051            -2.0%       4949 ±  9%  softirqs.CPU60.SCHED
      0.00       +1.6e+102%       1.60 ±300%  softirqs.CPU60.TASKLET
    135.08 ± 58%      -3.3%     130.60 ± 17%  softirqs.CPU60.TIMER
     22756 ±  7%      +1.3%      23046 ± 11%  softirqs.CPU61.RCU
      5059            -2.9%       4912 ± 18%  softirqs.CPU61.SCHED
      1.38 ±346%    -100.0%       0.00        softirqs.CPU61.TASKLET
    123.15 ± 41%     +42.3%     175.20 ± 93%  softirqs.CPU61.TIMER
     22421 ±  7%      +1.4%      22729 ± 11%  softirqs.CPU62.RCU
      5045            -1.5%       4970 ± 10%  softirqs.CPU62.SCHED
      0.15 ±346%     -35.0%       0.10 ±300%  softirqs.CPU62.TASKLET
    130.85 ± 67%     +13.1%     148.00 ± 60%  softirqs.CPU62.TIMER
     22251 ±  7%      +0.8%      22421 ± 11%  softirqs.CPU63.RCU
      4945 ±  7%      +0.2%       4955 ±  9%  softirqs.CPU63.SCHED
      0.08 ±346%    -100.0%       0.00        softirqs.CPU63.TASKLET
     98.62 ± 19%     +29.5%     127.70 ± 17%  softirqs.CPU63.TIMER
     24017 ±  8%      -0.1%      23998 ± 11%  softirqs.CPU64.RCU
      5085 ±  2%      -2.4%       4965 ±  9%  softirqs.CPU64.SCHED
    168.46 ± 53%     -20.8%     133.40 ± 17%  softirqs.CPU64.TIMER
     23942 ±  8%      +0.5%      24056 ± 12%  softirqs.CPU65.RCU
      5162 ±  6%      -4.3%       4940 ±  9%  softirqs.CPU65.SCHED
    234.15 ±144%     -45.2%     128.20 ± 14%  softirqs.CPU65.TIMER
     23725 ±  8%      +0.5%      23852 ± 11%  softirqs.CPU66.RCU
      5154 ±  6%      -1.8%       5060 ± 11%  softirqs.CPU66.SCHED
    216.23 ±140%     -35.1%     140.40 ± 25%  softirqs.CPU66.TIMER
     23870 ±  7%      -0.4%      23783 ± 12%  softirqs.CPU67.RCU
      5058            -2.1%       4951 ±  9%  softirqs.CPU67.SCHED
    140.31 ± 47%      +3.2%     144.80 ± 44%  softirqs.CPU67.TIMER
     23763 ±  8%      +0.2%      23809 ± 12%  softirqs.CPU68.RCU
      5101            -3.0%       4950 ±  9%  softirqs.CPU68.SCHED
      0.08 ±346%    -100.0%       0.00        softirqs.CPU68.TASKLET
    135.46 ± 28%      -4.0%     130.10 ± 21%  softirqs.CPU68.TIMER
     23832 ±  8%      -0.0%      23828 ± 11%  softirqs.CPU69.RCU
      5048            -1.6%       4966 ±  9%  softirqs.CPU69.SCHED
    227.31 ± 75%     -34.3%     149.30 ± 43%  softirqs.CPU69.TIMER
     23287 ±  8%      -0.6%      23155 ± 11%  softirqs.CPU7.RCU
      5064            -4.3%       4848 ± 17%  softirqs.CPU7.SCHED
      0.00         +3e+101%       0.30 ±300%  softirqs.CPU7.TASKLET
    119.23 ± 13%     +16.5%     138.90 ± 26%  softirqs.CPU7.TIMER
     23880 ±  7%      +1.2%      24162 ± 11%  softirqs.CPU70.RCU
      5070            -2.2%       4957 ±  9%  softirqs.CPU70.SCHED
    133.92 ± 28%     +10.3%     147.70 ± 31%  softirqs.CPU70.TIMER
     23784 ±  7%      +0.6%      23928 ± 12%  softirqs.CPU71.RCU
      5071 ±  2%      -1.9%       4972 ± 10%  softirqs.CPU71.SCHED
    125.77 ± 18%    +259.3%     451.90 ±176%  softirqs.CPU71.TIMER
     22336 ± 10%      -2.7%      21744 ± 11%  softirqs.CPU72.RCU
      5120            -3.4%       4948 ±  9%  softirqs.CPU72.SCHED
      2.08 ± 12%      -3.7%       2.00        softirqs.CPU72.TASKLET
    382.69 ± 93%     -27.6%     277.00 ±  8%  softirqs.CPU72.TIMER
     22813 ±  7%      -0.6%      22680 ± 11%  softirqs.CPU73.RCU
      5068 ±  2%      -1.9%       4974 ±  8%  softirqs.CPU73.SCHED
      2.00            +0.0%       2.00        softirqs.CPU73.TASKLET
    400.00 ± 40%     -14.3%     342.90 ± 41%  softirqs.CPU73.TIMER
     22239 ±  6%      -0.3%      22183 ± 11%  softirqs.CPU74.RCU
      5077            -5.5%       4795 ± 11%  softirqs.CPU74.SCHED
      2.00            +0.0%       2.00        softirqs.CPU74.TASKLET
    279.85 ± 50%      -4.4%     267.50 ± 47%  softirqs.CPU74.TIMER
     21988 ±  7%      -0.4%      21907 ± 12%  softirqs.CPU75.RCU
      5038            -2.2%       4926 ±  9%  softirqs.CPU75.SCHED
      2.00            +5.0%       2.10 ± 14%  softirqs.CPU75.TASKLET
    138.00 ± 54%      -8.7%     126.00 ± 26%  softirqs.CPU75.TIMER
     22046 ±  7%      +2.0%      22481 ± 13%  softirqs.CPU76.RCU
      5070            -2.9%       4924 ±  9%  softirqs.CPU76.SCHED
      2.00            +0.0%       2.00        softirqs.CPU76.TASKLET
    157.00 ± 56%     +70.9%     268.30 ±150%  softirqs.CPU76.TIMER
     22022 ±  7%      -0.5%      21919 ± 11%  softirqs.CPU77.RCU
      5157 ±  6%      -4.8%       4908 ±  9%  softirqs.CPU77.SCHED
      1.92 ± 13%      +4.0%       2.00        softirqs.CPU77.TASKLET
    297.92 ±221%     -60.7%     117.10 ± 24%  softirqs.CPU77.TIMER
     22033 ±  8%      -0.0%      22026 ± 11%  softirqs.CPU78.RCU
      5007 ±  7%      -1.2%       4948 ±  9%  softirqs.CPU78.SCHED
      2.00            +0.0%       2.00        softirqs.CPU78.TASKLET
    121.69 ±125%     +20.1%     146.10 ± 88%  softirqs.CPU78.TIMER
     21808 ±  7%      -1.0%      21591 ± 13%  softirqs.CPU79.RCU
      5045            -1.5%       4967 ± 11%  softirqs.CPU79.SCHED
      1.92 ± 13%      +4.0%       2.00        softirqs.CPU79.TASKLET
    179.38 ± 62%     +19.2%     213.80 ±114%  softirqs.CPU79.TIMER
     23335 ±  8%      +0.1%      23349 ± 12%  softirqs.CPU8.RCU
      5169 ±  7%      -7.2%       4800 ± 13%  softirqs.CPU8.SCHED
      1.23 ±323%     -91.9%       0.10 ±300%  softirqs.CPU8.TASKLET
    342.46 ±196%     -59.2%     139.70 ± 12%  softirqs.CPU8.TIMER
     22207 ±  8%      +0.2%      22253 ± 11%  softirqs.CPU80.RCU
      5043            -2.4%       4925 ± 10%  softirqs.CPU80.SCHED
    146.15 ± 64%     +13.0%     165.10 ± 67%  softirqs.CPU80.TIMER
     22287 ±  7%      +0.3%      22354 ± 11%  softirqs.CPU81.RCU
      5101 ±  4%      -1.1%       5045 ± 12%  softirqs.CPU81.SCHED
    221.62 ±159%     +10.2%     244.20 ±117%  softirqs.CPU81.TIMER
      0.08 ±346%    -100.0%       0.00        softirqs.CPU82.NET_TX
     22282 ±  7%      +0.2%      22328 ± 11%  softirqs.CPU82.RCU
      5062            -2.9%       4917 ±  9%  softirqs.CPU82.SCHED
    160.38 ± 68%     -17.8%     131.90 ± 35%  softirqs.CPU82.TIMER
     22522 ±  7%      +0.3%      22594 ± 11%  softirqs.CPU83.RCU
      5060            -3.8%       4868 ± 17%  softirqs.CPU83.SCHED
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU83.TASKLET
    125.77 ± 29%    +157.7%     324.10 ± 89%  softirqs.CPU83.TIMER
     22317 ±  7%      +1.0%      22541 ± 11%  softirqs.CPU84.RCU
      5040            -1.7%       4954 ±  9%  softirqs.CPU84.SCHED
    114.77 ± 14%     +14.8%     131.80 ± 35%  softirqs.CPU84.TIMER
     22096 ±  7%      -0.2%      22059 ± 11%  softirqs.CPU85.RCU
      5066 ±  3%      -3.3%       4901 ±  9%  softirqs.CPU85.SCHED
      0.00         +5e+101%       0.50 ±300%  softirqs.CPU85.TASKLET
    158.38 ±108%     -17.7%     130.30 ± 29%  softirqs.CPU85.TIMER
     21981 ±  7%      +1.5%      22320 ± 11%  softirqs.CPU86.RCU
      5037            -1.8%       4944 ±  9%  softirqs.CPU86.SCHED
    127.23 ± 22%     +16.2%     147.80 ± 44%  softirqs.CPU86.TIMER
     22117 ±  7%      +1.3%      22398 ± 11%  softirqs.CPU87.RCU
      5010            -1.4%       4939 ±  9%  softirqs.CPU87.SCHED
      0.00         +7e+101%       0.70 ±300%  softirqs.CPU87.TASKLET
    111.38 ± 12%     +24.4%     138.60 ± 38%  softirqs.CPU87.TIMER
     22402 ±  7%      -0.5%      22295 ± 11%  softirqs.CPU88.RCU
      5044            -2.1%       4937 ±  9%  softirqs.CPU88.SCHED
    114.54 ± 11%     +30.5%     149.50 ± 44%  softirqs.CPU88.TIMER
     22417 ±  7%      +0.5%      22529 ± 11%  softirqs.CPU89.RCU
      5044 ±  2%      -2.5%       4917 ±  9%  softirqs.CPU89.SCHED
      0.00         +1e+102%       1.00 ±300%  softirqs.CPU89.TASKLET
    160.62 ± 72%     -16.8%     133.60 ± 18%  softirqs.CPU89.TIMER
     29.46 ±  2%      -0.2%      29.40        softirqs.CPU9.NET_TX
     23930 ± 10%      -0.9%      23714 ± 11%  softirqs.CPU9.RCU
      4953 ±  7%      +0.6%       4985 ±  9%  softirqs.CPU9.SCHED
      0.46 ±289%     -78.3%       0.10 ±300%  softirqs.CPU9.TASKLET
    349.23 ±101%      -0.7%     346.80 ± 52%  softirqs.CPU9.TIMER
     22510 ±  7%      +0.7%      22664 ± 11%  softirqs.CPU90.RCU
      5042            -2.2%       4931 ±  9%  softirqs.CPU90.SCHED
    122.08 ± 16%      -0.7%     121.20 ± 23%  softirqs.CPU90.TIMER
     22486 ±  7%      -0.7%      22331 ± 11%  softirqs.CPU91.RCU
      5015            -2.2%       4905 ±  9%  softirqs.CPU91.SCHED
      0.08 ±346%     +30.0%       0.10 ±300%  softirqs.CPU91.TASKLET
     95.38 ± 15%      -3.9%      91.70 ± 19%  softirqs.CPU91.TIMER
     22030 ± 10%      +1.3%      22314 ± 11%  softirqs.CPU92.RCU
      5160 ±  7%      -4.3%       4940 ±  9%  softirqs.CPU92.SCHED
    306.46 ±227%     -57.4%     130.60 ± 22%  softirqs.CPU92.TIMER
     22235 ±  7%      +0.4%      22323 ± 11%  softirqs.CPU93.RCU
      5053            -2.8%       4910 ±  9%  softirqs.CPU93.SCHED
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU93.TASKLET
    112.38 ± 10%     +18.4%     133.10 ± 20%  softirqs.CPU93.TIMER
     22510 ±  7%      +0.1%      22525 ± 11%  softirqs.CPU94.RCU
      5053            -1.5%       4975 ± 10%  softirqs.CPU94.SCHED
    115.15 ± 29%     +88.9%     217.50 ±137%  softirqs.CPU94.TIMER
     22596 ±  9%      +2.3%      23107 ± 12%  softirqs.CPU95.RCU
      5083            -2.2%       4972 ± 12%  softirqs.CPU95.SCHED
    150.92 ± 23%    +152.6%     381.20 ±115%  softirqs.CPU95.TIMER
    160.62 ± 79%     -67.5%      52.20 ±200%  softirqs.CPU96.BLOCK
     29625 ±  7%      -2.1%      28994 ±  9%  softirqs.CPU96.RCU
      5075 ±  7%      -4.5%       4847 ±  9%  softirqs.CPU96.SCHED
      0.23 ±249%    +246.7%       0.80 ±122%  softirqs.CPU96.TASKLET
      1026 ± 72%     -29.2%     727.30 ± 28%  softirqs.CPU96.TIMER
     60.23 ±182%     -13.3%      52.20 ±200%  softirqs.CPU97.BLOCK
     26462 ± 10%      +2.3%      27071 ± 11%  softirqs.CPU97.RCU
      5062 ±  6%      -0.4%       5041 ±  8%  softirqs.CPU97.SCHED
      0.00       +1.6e+102%       1.60 ±261%  softirqs.CPU97.TASKLET
    527.15 ± 32%      -9.1%     479.40 ± 23%  softirqs.CPU97.TIMER
     24507 ±  8%      -4.2%      23472 ± 20%  softirqs.CPU98.RCU
      5094            -1.9%       5000 ±  9%  softirqs.CPU98.SCHED
    276.54 ± 34%      -5.9%     260.30 ± 36%  softirqs.CPU98.TIMER
     23691 ±  8%      +0.1%      23708 ± 11%  softirqs.CPU99.RCU
      5113            -2.5%       4987 ±  8%  softirqs.CPU99.SCHED
    171.08 ± 27%      -7.9%     157.50 ± 15%  softirqs.CPU99.TIMER
      2.00           +10.0%       2.20 ± 18%  softirqs.HI
     12055 ± 31%      +3.4%      12463 ± 71%  softirqs.NET_RX
     37.46 ±  3%      -1.2%      37.00        softirqs.NET_TX
   4503286 ±  7%      +0.5%    4523562 ± 11%  softirqs.RCU
    981291            -2.3%     958616 ±  9%  softirqs.SCHED
    226.85            +0.2%     227.20        softirqs.TASKLET
     41913 ±  4%      +2.3%      42895 ±  8%  softirqs.TIMER
      0.00          -100.0%       0.00        interrupts.0:IO-APIC.2-edge.timer
      0.00          -100.0%       0.00        interrupts.100:PCI-MSI.23592994-edge.nvme0q34
      0.00          -100.0%       0.00        interrupts.100:PCI-MSI.23592998-edge.nvme0q38
      0.00          -100.0%       0.00        interrupts.100:PCI-MSI.23593007-edge.nvme0q47
      0.00          -100.0%       0.00        interrupts.100:PCI-MSI.23593008-edge.nvme0q48
      0.00          -100.0%       0.00        interrupts.101:PCI-MSI.23593014-edge.nvme0q54
      0.00          -100.0%       0.00        interrupts.102:PCI-MSI.23592996-edge.nvme0q36
      0.00          -100.0%       0.00        interrupts.105:PCI-MSI.23592999-edge.nvme0q39
      0.00          -100.0%       0.00        interrupts.105:PCI-MSI.23593005-edge.nvme0q45
      0.00          -100.0%       0.00        interrupts.105:PCI-MSI.23593019-edge.nvme0q59
      0.00          -100.0%       0.00        interrupts.106:PCI-MSI.23593011-edge.nvme0q51
      0.00          -100.0%       0.00        interrupts.106:PCI-MSI.23593020-edge.nvme0q60
      0.00          -100.0%       0.00        interrupts.107:PCI-MSI.23592988-edge.nvme0q28
      0.00          -100.0%       0.00        interrupts.107:PCI-MSI.23593005-edge.nvme0q45
      0.00          -100.0%       0.00        interrupts.107:PCI-MSI.23593007-edge.nvme0q47
      0.00          -100.0%       0.00        interrupts.107:PCI-MSI.23593021-edge.nvme0q61
      0.00          -100.0%       0.00        interrupts.108:PCI-MSI.23592989-edge.nvme0q29
      0.00          -100.0%       0.00        interrupts.109:PCI-MSI.23592990-edge.nvme0q30
      0.00          -100.0%       0.00        interrupts.109:PCI-MSI.23593022-edge.nvme0q62
      0.00          -100.0%       0.00        interrupts.109:PCI-MSI.23593023-edge.nvme0q63
      0.00          -100.0%       0.00        interrupts.110:PCI-MSI.23592991-edge.nvme0q31
      0.00          -100.0%       0.00        interrupts.111:PCI-MSI.23593005-edge.nvme0q45
      0.00          -100.0%       0.00        interrupts.112:PCI-MSI.23593029-edge.nvme0q69
      0.00          -100.0%       0.00        interrupts.113:PCI-MSI.23593013-edge.nvme0q53
      0.00          -100.0%       0.00        interrupts.113:PCI-MSI.23593026-edge.nvme0q66
      0.00          -100.0%       0.00        interrupts.114:PCI-MSI.23593008-edge.nvme0q48
      0.00          -100.0%       0.00        interrupts.115:PCI-MSI.23593000-edge.nvme0q40
      0.00          -100.0%       0.00        interrupts.116:PCI-MSI.23592997-edge.nvme0q37
      0.00          -100.0%       0.00        interrupts.116:PCI-MSI.23593021-edge.nvme0q61
      0.00          -100.0%       0.00        interrupts.116:PCI-MSI.23593023-edge.nvme0q63
      0.00          -100.0%       0.00        interrupts.117:PCI-MSI.23593024-edge.nvme0q64
      0.00          -100.0%       0.00        interrupts.118:PCI-MSI.23593025-edge.nvme0q65
      0.00          -100.0%       0.00        interrupts.118:PCI-MSI.23593031-edge.nvme0q71
      0.00          -100.0%       0.00        interrupts.119:PCI-MSI.23593000-edge.nvme0q40
      0.00          -100.0%       0.00        interrupts.119:PCI-MSI.23593026-edge.nvme0q66
      0.00          -100.0%       0.00        interrupts.120:PCI-MSI.23593001-edge.nvme0q41
      0.00          -100.0%       0.00        interrupts.120:PCI-MSI.23593027-edge.nvme0q67
      0.00          -100.0%       0.00        interrupts.121:PCI-MSI.23593002-edge.nvme0q42
      0.00          -100.0%       0.00        interrupts.121:PCI-MSI.23593025-edge.nvme0q65
      0.00          -100.0%       0.00        interrupts.122:PCI-MSI.23593003-edge.nvme0q43
      0.00          -100.0%       0.00        interrupts.122:PCI-MSI.23593016-edge.nvme0q56
      0.00          -100.0%       0.00        interrupts.122:PCI-MSI.23593026-edge.nvme0q66
      0.00          -100.0%       0.00        interrupts.122:PCI-MSI.23593029-edge.nvme0q69
      0.00          -100.0%       0.00        interrupts.122:PCI-MSI.23593030-edge.nvme0q70
      0.00          -100.0%       0.00        interrupts.122:PCI-MSI.23593035-edge.nvme0q75
      0.00          -100.0%       0.00        interrupts.123:PCI-MSI.23593031-edge.nvme0q71
      0.00          -100.0%       0.00        interrupts.124:PCI-MSI.23593028-edge.nvme0q68
      0.00          -100.0%       0.00        interrupts.124:PCI-MSI.23593029-edge.nvme0q69
      0.00          -100.0%       0.00        interrupts.124:PCI-MSI.23593031-edge.nvme0q71
      0.00          -100.0%       0.00        interrupts.124:PCI-MSI.23593037-edge.nvme0q77
      0.00          -100.0%       0.00        interrupts.125:PCI-MSI.23593033-edge.nvme0q73
      0.00          -100.0%       0.00        interrupts.126:PCI-MSI.23593020-edge.nvme0q60
      0.00          -100.0%       0.00        interrupts.126:PCI-MSI.23593033-edge.nvme0q73
      0.00          -100.0%       0.00        interrupts.127:PCI-MSI.23593008-edge.nvme0q48
      0.00          -100.0%       0.00        interrupts.127:PCI-MSI.23593034-edge.nvme0q74
      0.00          -100.0%       0.00        interrupts.127:PCI-MSI.23593035-edge.nvme0q75
      0.00          -100.0%       0.00        interrupts.130:PCI-MSI.23593015-edge.nvme0q55
      0.00          -100.0%       0.00        interrupts.130:PCI-MSI.23593034-edge.nvme0q74
      0.00          -100.0%       0.00        interrupts.131:PCI-MSI.23593038-edge.nvme0q78
      0.00          -100.0%       0.00        interrupts.132:PCI-MSI.23593017-edge.nvme0q57
      0.00          -100.0%       0.00        interrupts.132:PCI-MSI.23593036-edge.nvme0q76
      0.00          -100.0%       0.00        interrupts.133:PCI-MSI.23593014-edge.nvme0q54
      0.00          -100.0%       0.00        interrupts.133:PCI-MSI.23593033-edge.nvme0q73
      0.00          -100.0%       0.00        interrupts.135:PCI-MSI.23593033-edge.nvme0q73
      0.00          -100.0%       0.00        interrupts.136:PCI-MSI.23593040-edge.nvme0q80
      0.00          -100.0%       0.00        interrupts.137:PCI-MSI.23593050-edge.nvme0q90
      0.00          -100.0%       0.00        interrupts.138:PCI-MSI.23593019-edge.nvme0q59
      0.00          -100.0%       0.00        interrupts.138:PCI-MSI.23593036-edge.nvme0q76
      0.00          -100.0%       0.00        interrupts.138:PCI-MSI.23593046-edge.nvme0q86
      0.00          -100.0%       0.00        interrupts.139:PCI-MSI.23593047-edge.nvme0q87
      0.00          -100.0%       0.00        interrupts.140:PCI-MSI.23593057-edge.nvme0q97
      0.00          -100.0%       0.00        interrupts.141:PCI-MSI.23593026-edge.nvme0q66
      0.00          -100.0%       0.00        interrupts.141:PCI-MSI.23593035-edge.nvme0q75
      0.00          -100.0%       0.00        interrupts.141:PCI-MSI.23593048-edge.nvme0q88
      0.00          -100.0%       0.00        interrupts.141:PCI-MSI.23593058-edge.nvme0q98
      0.00          -100.0%       0.00        interrupts.142:PCI-MSI.23593027-edge.nvme0q67
      0.00          -100.0%       0.00        interrupts.142:PCI-MSI.23593036-edge.nvme0q76
      0.00          -100.0%       0.00        interrupts.142:PCI-MSI.23593040-edge.nvme0q80
      0.00          -100.0%       0.00        interrupts.142:PCI-MSI.23593049-edge.nvme0q89
      0.00          -100.0%       0.00        interrupts.142:PCI-MSI.23593055-edge.nvme0q95
      0.00          -100.0%       0.00        interrupts.143:PCI-MSI.23593051-edge.nvme0q91
      0.00          -100.0%       0.00        interrupts.143:PCI-MSI.23593056-edge.nvme0q96
      0.00          -100.0%       0.00        interrupts.143:PCI-MSI.23593060-edge.nvme0q100
      0.00          -100.0%       0.00        interrupts.144:PCI-MSI.23593029-edge.nvme0q69
      0.00          -100.0%       0.00        interrupts.144:PCI-MSI.23593052-edge.nvme0q92
      0.00          -100.0%       0.00        interrupts.144:PCI-MSI.23593061-edge.nvme0q101
      0.00          -100.0%       0.00        interrupts.145:PCI-MSI.23593030-edge.nvme0q70
      0.00          -100.0%       0.00        interrupts.145:PCI-MSI.23593049-edge.nvme0q89
      0.00          -100.0%       0.00        interrupts.145:PCI-MSI.23593058-edge.nvme0q98
      0.00          -100.0%       0.00        interrupts.146:PCI-MSI.23593031-edge.nvme0q71
      0.00          -100.0%       0.00        interrupts.146:PCI-MSI.23593053-edge.nvme0q93
      0.00          -100.0%       0.00        interrupts.146:PCI-MSI.23593054-edge.nvme0q94
      0.00          -100.0%       0.00        interrupts.146:PCI-MSI.23593057-edge.nvme0q97
      0.00          -100.0%       0.00        interrupts.146:PCI-MSI.23593059-edge.nvme0q99
      0.00          -100.0%       0.00        interrupts.146:PCI-MSI.23593063-edge.nvme0q103
      0.00          -100.0%       0.00        interrupts.147:PCI-MSI.23593028-edge.nvme0q68
      0.00          -100.0%       0.00        interrupts.147:PCI-MSI.23593045-edge.nvme0q85
      0.00          -100.0%       0.00        interrupts.147:PCI-MSI.23593055-edge.nvme0q95
      0.00          -100.0%       0.00        interrupts.147:PCI-MSI.23593060-edge.nvme0q100
      0.00          -100.0%       0.00        interrupts.147:PCI-MSI.23593061-edge.nvme0q101
      0.00          -100.0%       0.00        interrupts.148:PCI-MSI.23593033-edge.nvme0q73
      0.00          -100.0%       0.00        interrupts.148:PCI-MSI.23593042-edge.nvme0q82
      0.00          -100.0%       0.00        interrupts.148:PCI-MSI.23593046-edge.nvme0q86
      0.00          -100.0%       0.00        interrupts.148:PCI-MSI.23593056-edge.nvme0q96
      0.00          -100.0%       0.00        interrupts.148:PCI-MSI.23593061-edge.nvme0q101
      0.00          -100.0%       0.00        interrupts.149:PCI-MSI.23593034-edge.nvme0q74
      0.00          -100.0%       0.00        interrupts.149:PCI-MSI.23593056-edge.nvme0q96
      0.00          -100.0%       0.00        interrupts.149:PCI-MSI.23593057-edge.nvme0q97
      0.00          -100.0%       0.00        interrupts.150:PCI-MSI.23593057-edge.nvme0q97
      0.00          -100.0%       0.00        interrupts.150:PCI-MSI.23593058-edge.nvme0q98
      0.00          -100.0%       0.00        interrupts.151:PCI-MSI.23593062-edge.nvme0q102
      0.00          -100.0%       0.00        interrupts.152:PCI-MSI.23593059-edge.nvme0q99
      0.00          -100.0%       0.00        interrupts.152:PCI-MSI.23593060-edge.nvme0q100
      0.00          -100.0%       0.00        interrupts.152:PCI-MSI.23593063-edge.nvme0q103
      0.00          -100.0%       0.00        interrupts.153:PCI-MSI.23593038-edge.nvme0q78
      0.00          -100.0%       0.00        interrupts.153:PCI-MSI.23593058-edge.nvme0q98
      0.00          -100.0%       0.00        interrupts.153:PCI-MSI.23593060-edge.nvme0q100
      0.00          -100.0%       0.00        interrupts.153:PCI-MSI.23593061-edge.nvme0q101
      0.00          -100.0%       0.00        interrupts.153:PCI-MSI.23593064-edge.nvme0q104
      0.00          -100.0%       0.00        interrupts.153:PCI-MSI.23593066-edge.nvme0q106
      0.00          -100.0%       0.00        interrupts.154:PCI-MSI.23593039-edge.nvme0q79
      0.00          -100.0%       0.00        interrupts.154:PCI-MSI.23593048-edge.nvme0q88
      0.00          -100.0%       0.00        interrupts.154:PCI-MSI.23593062-edge.nvme0q102
      0.00          -100.0%       0.00        interrupts.154:PCI-MSI.23593068-edge.nvme0q108
      0.00          -100.0%       0.00        interrupts.155:PCI-MSI.23593040-edge.nvme0q80
      0.00          -100.0%       0.00        interrupts.155:PCI-MSI.23593060-edge.nvme0q100
      0.00          -100.0%       0.00        interrupts.156:PCI-MSI.23593058-edge.nvme0q98
      0.00          -100.0%       0.00        interrupts.156:PCI-MSI.23593061-edge.nvme0q101
      0.00          -100.0%       0.00        interrupts.156:PCI-MSI.23593064-edge.nvme0q104
      0.00          -100.0%       0.00        interrupts.156:PCI-MSI.23593067-edge.nvme0q107
      0.00          -100.0%       0.00        interrupts.157:PCI-MSI.23593059-edge.nvme0q99
      0.00          -100.0%       0.00        interrupts.157:PCI-MSI.23593062-edge.nvme0q102
      0.00          -100.0%       0.00        interrupts.157:PCI-MSI.23593070-edge.nvme0q110
      0.00          -100.0%       0.00        interrupts.158:PCI-MSI.23593063-edge.nvme0q103
      0.00          -100.0%       0.00        interrupts.158:PCI-MSI.23593071-edge.nvme0q111
      0.00          -100.0%       0.00        interrupts.159:PCI-MSI.23593057-edge.nvme0q97
      0.00          -100.0%       0.00        interrupts.159:PCI-MSI.23593059-edge.nvme0q99
      0.00          -100.0%       0.00        interrupts.159:PCI-MSI.23593064-edge.nvme0q104
      0.00          -100.0%       0.00        interrupts.159:PCI-MSI.23593072-edge.nvme0q112
      0.00          -100.0%       0.00        interrupts.160:PCI-MSI.23593065-edge.nvme0q105
      0.00          -100.0%       0.00        interrupts.160:PCI-MSI.23593067-edge.nvme0q107
      0.00          -100.0%       0.00        interrupts.160:PCI-MSI.23593068-edge.nvme0q108
      0.00          -100.0%       0.00        interrupts.160:PCI-MSI.23593071-edge.nvme0q111
      0.00          -100.0%       0.00        interrupts.160:PCI-MSI.23593077-edge.nvme0q117
      0.00          -100.0%       0.00        interrupts.161:PCI-MSI.23593055-edge.nvme0q95
      0.00          -100.0%       0.00        interrupts.161:PCI-MSI.23593059-edge.nvme0q99
      0.00          -100.0%       0.00        interrupts.161:PCI-MSI.23593068-edge.nvme0q108
      0.00          -100.0%       0.00        interrupts.161:PCI-MSI.23593072-edge.nvme0q112
      0.00          -100.0%       0.00        interrupts.161:PCI-MSI.23593074-edge.nvme0q114
      0.00          -100.0%       0.00        interrupts.162:PCI-MSI.23593070-edge.nvme0q110
      0.00          -100.0%       0.00        interrupts.162:PCI-MSI.23593075-edge.nvme0q115
      0.00          -100.0%       0.00        interrupts.163:PCI-MSI.23593057-edge.nvme0q97
      0.00          -100.0%       0.00        interrupts.163:PCI-MSI.23593070-edge.nvme0q110
      0.00          -100.0%       0.00        interrupts.163:PCI-MSI.23593076-edge.nvme0q116
      0.00          -100.0%       0.00        interrupts.164:PCI-MSI.23593058-edge.nvme0q98
      0.00          -100.0%       0.00        interrupts.164:PCI-MSI.23593068-edge.nvme0q108
      0.00          -100.0%       0.00        interrupts.164:PCI-MSI.23593069-edge.nvme0q109
      0.00          -100.0%       0.00        interrupts.164:PCI-MSI.23593071-edge.nvme0q111
      0.00          -100.0%       0.00        interrupts.164:PCI-MSI.23593075-edge.nvme0q115
      0.00          -100.0%       0.00        interrupts.164:PCI-MSI.23593078-edge.nvme0q118
      0.00          -100.0%       0.00        interrupts.165:PCI-MSI.23593050-edge.nvme0q90
      0.00          -100.0%       0.00        interrupts.165:PCI-MSI.23593059-edge.nvme0q99
      0.00          -100.0%       0.00        interrupts.165:PCI-MSI.23593073-edge.nvme0q113
      0.00          -100.0%       0.00        interrupts.165:PCI-MSI.23593082-edge.nvme0q122
      0.00          -100.0%       0.00        interrupts.166:PCI-MSI.23593060-edge.nvme0q100
      0.00          -100.0%       0.00        interrupts.166:PCI-MSI.23593077-edge.nvme0q117
      0.00          -100.0%       0.00        interrupts.166:PCI-MSI.23593083-edge.nvme0q123
      0.00          -100.0%       0.00        interrupts.167:PCI-MSI.23593061-edge.nvme0q101
      0.00          -100.0%       0.00        interrupts.167:PCI-MSI.23593069-edge.nvme0q109
      0.00          -100.0%       0.00        interrupts.167:PCI-MSI.23593080-edge.nvme0q120
      0.00          -100.0%       0.00        interrupts.168:PCI-MSI.23593079-edge.nvme0q119
      0.00          -100.0%       0.00        interrupts.168:PCI-MSI.23593085-edge.nvme0q125
      0.00          -100.0%       0.00        interrupts.169:PCI-MSI.23593067-edge.nvme0q107
      0.00          -100.0%       0.00        interrupts.169:PCI-MSI.23593076-edge.nvme0q116
      0.00          -100.0%       0.00        interrupts.169:PCI-MSI.23593083-edge.nvme0q123
      0.00          -100.0%       0.00        interrupts.169:PCI-MSI.23593086-edge.nvme0q126
      0.00          -100.0%       0.00        interrupts.170:PCI-MSI.23593081-edge.nvme0q121
      0.00          -100.0%       0.00        interrupts.171:PCI-MSI.23593065-edge.nvme0q105
      0.00          -100.0%       0.00        interrupts.171:PCI-MSI.23593079-edge.nvme0q119
      0.00          -100.0%       0.00        interrupts.171:PCI-MSI.23593084-edge.nvme0q124
      0.00          -100.0%       0.00        interrupts.172:PCI-MSI.23593057-edge.nvme0q97
      0.00          -100.0%       0.00        interrupts.172:PCI-MSI.23593066-edge.nvme0q106
      0.00          -100.0%       0.00        interrupts.172:PCI-MSI.23593083-edge.nvme0q123
      0.00          -100.0%       0.00        interrupts.172:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.172:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.173:PCI-MSI.23593058-edge.nvme0q98
      0.00          -100.0%       0.00        interrupts.173:PCI-MSI.23593067-edge.nvme0q107
      0.00          -100.0%       0.00        interrupts.173:PCI-MSI.23593084-edge.nvme0q124
      0.00          -100.0%       0.00        interrupts.173:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.174:PCI-MSI.23593059-edge.nvme0q99
      0.00          -100.0%       0.00        interrupts.174:PCI-MSI.23593087-edge.nvme0q127
      0.00          -100.0%       0.00        interrupts.174:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.175:PCI-MSI.23593060-edge.nvme0q100
      0.00          -100.0%       0.00        interrupts.175:PCI-MSI.23593073-edge.nvme0q113
      0.00          -100.0%       0.00        interrupts.175:PCI-MSI.23593080-edge.nvme0q120
      0.00          -100.0%       0.00        interrupts.175:PCI-MSI.23593083-edge.nvme0q123
      0.00          -100.0%       0.00        interrupts.175:PCI-MSI.23593086-edge.nvme0q126
      0.00          -100.0%       0.00        interrupts.175:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.175:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.176:PCI-MSI.23593061-edge.nvme0q101
      0.00          -100.0%       0.00        interrupts.176:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.176:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.177:PCI-MSI.23593088-edge.nvme0q128
      0.00          -100.0%       0.00        interrupts.177:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.178:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.179:PCI-MSI.23593077-edge.nvme0q117
      0.00          -100.0%       0.00        interrupts.179:PCI-MSI.23593084-edge.nvme0q124
      0.00          -100.0%       0.00        interrupts.179:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.180:PCI-MSI.23593065-edge.nvme0q105
      0.00          -100.0%       0.00        interrupts.180:PCI-MSI.23593087-edge.nvme0q127
      0.00          -100.0%       0.00        interrupts.180:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.181:PCI-MSI.23593088-edge.nvme0q128
      0.00          -100.0%       0.00        interrupts.181:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.181:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.182:PCI-MSI.23593067-edge.nvme0q107
      0.00          -100.0%       0.00        interrupts.182:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.182:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.182:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.183:PCI-MSI.23593081-edge.nvme0q121
      0.00          -100.0%       0.00        interrupts.183:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.183:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.184:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.184:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.184:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.185:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.185:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.185:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.186:PCI-MSI.23593080-edge.nvme0q120
      0.00          -100.0%       0.00        interrupts.186:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.186:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.187:PCI-MSI.23593068-edge.nvme0q108
      0.00          -100.0%       0.00        interrupts.187:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.188:PCI-MSI.23593082-edge.nvme0q122
      0.00          -100.0%       0.00        interrupts.188:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.189:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.190:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.191:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.191:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.192:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.192:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.193:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.193:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.193:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.194:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.194:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.195:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.195:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.196:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.196:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.197:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.198:PCI-MSI.100728832-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.198:PCI-MSI.100737024-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.199:PCI-MSI.100728832-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.200:PCI-MSI.100730880-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.201:PCI-MSI.100730880-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.201:PCI-MSI.100732928-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.202:PCI-MSI.100732928-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.202:PCI-MSI.100734976-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.203:PCI-MSI.100734976-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.203:PCI-MSI.100737024-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.203:PCI-MSI.23593087-edge.nvme0q127
      0.00          -100.0%       0.00        interrupts.204:PCI-MSI.100737024-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.205:PCI-MSI.100739072-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.206:PCI-MSI.100741120-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.207:PCI-MSI.100743168-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.27:PCI-MSI.17825792-edge.PCIe.PME,pciehp
      0.00          -100.0%       0.00        interrupts.29:PCI-MSI.23068672-edge.PCIe.PME,pciehp
      0.00          -100.0%       0.00        interrupts.30:PCI-MSI.524288-edge.eth0
      6814 ±131%      -7.4%       6309 ±166%  interrupts.31:PCI-MSI.524289-edge.eth0-TxRx-0
      8223 ±123%     -80.6%       1592 ± 97%  interrupts.32:PCI-MSI.524290-edge.eth0-TxRx-1
      3382 ±164%     +72.1%       5822 ±181%  interrupts.33:PCI-MSI.524291-edge.eth0-TxRx-2
      3492 ±125%    +166.1%       9295 ±116%  interrupts.34:PCI-MSI.524292-edge.eth0-TxRx-3
      0.00          -100.0%       0.00        interrupts.35:PCI-MSI.327680-edge.xhci_hcd
      0.00          -100.0%       0.00        interrupts.37:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.39:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.40:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.40:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.41:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.41:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.42:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.42:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.42:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.43:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.43:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.43:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.43:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.44:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.44:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.44:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.45:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.45:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.45:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.45:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.46:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.46:PCI-MSI.23592963-edge.nvme0q3
      0.00          -100.0%       0.00        interrupts.46:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.46:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.47:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.47:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.47:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.48:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.48:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.49:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.49:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.49:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.4:IO-APIC.4-edge.ttyS0
      0.00          -100.0%       0.00        interrupts.50:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.50:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.50:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.51:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.51:PCI-MSI.23592964-edge.nvme0q4
      0.00          -100.0%       0.00        interrupts.51:PCI-MSI.23592968-edge.nvme0q8
      0.00          -100.0%       0.00        interrupts.51:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.51:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.51:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.51:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.52:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.52:PCI-MSI.23592963-edge.nvme0q3
      0.00          -100.0%       0.00        interrupts.52:PCI-MSI.23592969-edge.nvme0q9
      0.00          -100.0%       0.00        interrupts.52:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.52:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.52:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.52:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.53:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.53:PCI-MSI.23592964-edge.nvme0q4
      0.00          -100.0%       0.00        interrupts.53:PCI-MSI.23592970-edge.nvme0q10
      0.00          -100.0%       0.00        interrupts.53:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.53:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.53:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.53:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.54:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.54:PCI-MSI.23592961-edge.nvme0q1
      0.00          -100.0%       0.00        interrupts.54:PCI-MSI.23592965-edge.nvme0q5
      0.00          -100.0%       0.00        interrupts.54:PCI-MSI.23592971-edge.nvme0q11
      0.00          -100.0%       0.00        interrupts.54:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.54:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.54:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.55:PCI-MSI.23592962-edge.nvme0q2
      0.00          -100.0%       0.00        interrupts.55:PCI-MSI.23592966-edge.nvme0q6
      0.00          -100.0%       0.00        interrupts.55:PCI-MSI.23592972-edge.nvme0q12
      0.00          -100.0%       0.00        interrupts.55:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.55:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.55:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.55:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.56:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.56:PCI-MSI.23592973-edge.nvme0q13
      0.00          -100.0%       0.00        interrupts.56:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.56:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.56:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.57:PCI-MSI.23592961-edge.nvme0q1
      0.00          -100.0%       0.00        interrupts.57:PCI-MSI.23592964-edge.nvme0q4
      0.00          -100.0%       0.00        interrupts.57:PCI-MSI.23592974-edge.nvme0q14
      0.00          -100.0%       0.00        interrupts.57:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.57:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.57:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.58:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.58:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.58:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.59:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.59:PCI-MSI.23592963-edge.nvme0q3
      0.00          -100.0%       0.00        interrupts.59:PCI-MSI.23592966-edge.nvme0q6
      0.00          -100.0%       0.00        interrupts.59:PCI-MSI.23592972-edge.nvme0q12
      0.00          -100.0%       0.00        interrupts.59:PCI-MSI.23592976-edge.nvme0q16
      0.00          -100.0%       0.00        interrupts.59:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.60:PCI-MSI.23592964-edge.nvme0q4
      0.00          -100.0%       0.00        interrupts.60:PCI-MSI.23592967-edge.nvme0q7
      0.00          -100.0%       0.00        interrupts.60:PCI-MSI.23592968-edge.nvme0q8
      0.00          -100.0%       0.00        interrupts.60:PCI-MSI.23592973-edge.nvme0q13
      0.00          -100.0%       0.00        interrupts.60:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.60:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.61:PCI-MSI.23592965-edge.nvme0q5
      0.00          -100.0%       0.00        interrupts.61:PCI-MSI.23592969-edge.nvme0q9
      0.00          -100.0%       0.00        interrupts.61:PCI-MSI.23592972-edge.nvme0q12
      0.00          -100.0%       0.00        interrupts.61:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.61:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.62:PCI-MSI.23592970-edge.nvme0q10
      0.00          -100.0%       0.00        interrupts.62:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.62:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.62:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.63:PCI-MSI.23592961-edge.nvme0q1
      0.00          -100.0%       0.00        interrupts.63:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.63:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.64:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.64:PCI-MSI.23592971-edge.nvme0q11
      0.00          -100.0%       0.00        interrupts.64:PCI-MSI.23592981-edge.nvme0q21
      0.00          -100.0%       0.00        interrupts.64:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.64:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.64:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.65:PCI-MSI.23592963-edge.nvme0q3
      0.00          -100.0%       0.00        interrupts.65:PCI-MSI.23592972-edge.nvme0q12
      0.00          -100.0%       0.00        interrupts.65:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.65:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.65:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.66:PCI-MSI.23592974-edge.nvme0q14
      0.00          -100.0%       0.00        interrupts.66:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.66:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.67:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.68:PCI-MSI.23592970-edge.nvme0q10
      0.00          -100.0%       0.00        interrupts.68:PCI-MSI.23592976-edge.nvme0q16
      0.00          -100.0%       0.00        interrupts.69:PCI-MSI.100728832-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.69:PCI-MSI.23592963-edge.nvme0q3
      0.00          -100.0%       0.00        interrupts.69:PCI-MSI.23592980-edge.nvme0q20
      0.00          -100.0%       0.00        interrupts.70:PCI-MSI.23592968-edge.nvme0q8
      0.00          -100.0%       0.00        interrupts.70:PCI-MSI.23592977-edge.nvme0q17
      0.00          -100.0%       0.00        interrupts.70:PCI-MSI.23592987-edge.nvme0q27
      0.00          -100.0%       0.00        interrupts.71:PCI-MSI.100730880-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.71:PCI-MSI.23592982-edge.nvme0q22
      0.00          -100.0%       0.00        interrupts.71:PCI-MSI.23592984-edge.nvme0q24
      0.00          -100.0%       0.00        interrupts.72:PCI-MSI.100730880-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.72:PCI-MSI.100732928-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.72:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.72:PCI-MSI.23592970-edge.nvme0q10
      0.00          -100.0%       0.00        interrupts.73:PCI-MSI.100730880-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.73:PCI-MSI.100734976-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.73:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.73:PCI-MSI.23592971-edge.nvme0q11
      0.00          -100.0%       0.00        interrupts.73:PCI-MSI.23592975-edge.nvme0q15
      0.00          -100.0%       0.00        interrupts.74:PCI-MSI.100732928-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.74:PCI-MSI.100737024-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.74:PCI-MSI.23592976-edge.nvme0q16
      0.00          -100.0%       0.00        interrupts.74:PCI-MSI.23592991-edge.nvme0q31
      0.00          -100.0%       0.00        interrupts.75:PCI-MSI.100734976-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.75:PCI-MSI.100739072-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.75:PCI-MSI.23592977-edge.nvme0q17
      0.00          -100.0%       0.00        interrupts.77:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.77:PCI-MSI.23592975-edge.nvme0q15
      0.00          -100.0%       0.00        interrupts.78:PCI-MSI.100741120-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.79:PCI-MSI.100743168-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.79:PCI-MSI.23592981-edge.nvme0q21
      0.00          -100.0%       0.00        interrupts.79:PCI-MSI.23592986-edge.nvme0q26
      0.00          -100.0%       0.00        interrupts.80:PCI-MSI.23592982-edge.nvme0q22
      0.00          -100.0%       0.00        interrupts.80:PCI-MSI.23592984-edge.nvme0q24
      0.00          -100.0%       0.00        interrupts.80:PCI-MSI.23592987-edge.nvme0q27
      0.00          -100.0%       0.00        interrupts.81:PCI-MSI.23592962-edge.nvme0q2
      0.00          -100.0%       0.00        interrupts.81:PCI-MSI.23592988-edge.nvme0q28
      0.00          -100.0%       0.00        interrupts.84:PCI-MSI.23592991-edge.nvme0q31
      0.00          -100.0%       0.00        interrupts.85:PCI-MSI.23592966-edge.nvme0q6
      0.00          -100.0%       0.00        interrupts.85:PCI-MSI.23592992-edge.nvme0q32
      0.00          -100.0%       0.00        interrupts.85:PCI-MSI.23592998-edge.nvme0q38
      0.00          -100.0%       0.00        interrupts.86:PCI-MSI.23593000-edge.nvme0q40
      0.00          -100.0%       0.00        interrupts.87:PCI-MSI.23592985-edge.nvme0q25
      0.00          -100.0%       0.00        interrupts.88:PCI-MSI.23592995-edge.nvme0q35
      0.00          -100.0%       0.00        interrupts.89:PCI-MSI.23592991-edge.nvme0q31
      0.00          -100.0%       0.00        interrupts.89:PCI-MSI.23592996-edge.nvme0q36
      0.00          -100.0%       0.00        interrupts.89:PCI-MSI.23593006-edge.nvme0q46
      0.00          -100.0%       0.00        interrupts.8:IO-APIC.8-edge.rtc0
      0.00          -100.0%       0.00        interrupts.90:PCI-MSI.23592997-edge.nvme0q37
      0.00          -100.0%       0.00        interrupts.90:PCI-MSI.23593007-edge.nvme0q47
      0.00          -100.0%       0.00        interrupts.91:PCI-MSI.23592972-edge.nvme0q12
      0.00          -100.0%       0.00        interrupts.91:PCI-MSI.23592985-edge.nvme0q25
      0.00          -100.0%       0.00        interrupts.91:PCI-MSI.23592998-edge.nvme0q38
      0.00          -100.0%       0.00        interrupts.92:PCI-MSI.23592973-edge.nvme0q13
      0.00          -100.0%       0.00        interrupts.92:PCI-MSI.23592999-edge.nvme0q39
      0.00          -100.0%       0.00        interrupts.93:PCI-MSI.23592974-edge.nvme0q14
      0.00          -100.0%       0.00        interrupts.94:PCI-MSI.23592994-edge.nvme0q34
      0.00          -100.0%       0.00        interrupts.95:PCI-MSI.23592989-edge.nvme0q29
      0.00          -100.0%       0.00        interrupts.95:PCI-MSI.23593002-edge.nvme0q42
      0.00          -100.0%       0.00        interrupts.96:PCI-MSI.23592996-edge.nvme0q36
      0.00          -100.0%       0.00        interrupts.97:PCI-MSI.23592978-edge.nvme0q18
      0.00          -100.0%       0.00        interrupts.97:PCI-MSI.23592982-edge.nvme0q22
      0.00          -100.0%       0.00        interrupts.97:PCI-MSI.23592997-edge.nvme0q37
      0.00          -100.0%       0.00        interrupts.99:PCI-MSI.23592993-edge.nvme0q33
      0.00          -100.0%       0.00        interrupts.99:PCI-MSI.23592997-edge.nvme0q37
    606.62            +0.1%     607.20        interrupts.9:IO-APIC.9-fasteoi.acpi
    296713 ± 20%     +32.9%     394340 ± 19%  interrupts.CAL:Function_call_interrupts
      0.00          -100.0%       0.00        interrupts.CPU0.0:IO-APIC.2-edge.timer
      1384 ± 29%     +63.3%       2260 ± 19%  interrupts.CPU0.CAL:Function_call_interrupts
      1.69 ± 27%     +12.3%       1.90 ± 15%  interrupts.CPU0.IWI:IRQ_work_interrupts
    606181            +0.1%     606881        interrupts.CPU0.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU0.MCP:Machine_check_polls
      6947 ± 27%     +12.2%       7793 ± 15%  interrupts.CPU0.NMI:Non-maskable_interrupts
      6947 ± 27%     +12.2%       7793 ± 15%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    919.46            +0.8%     927.10        interrupts.CPU0.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00        interrupts.CPU0.RTR:APIC_ICR_read_retries
      5.08 ± 50%     -27.1%       3.70 ± 12%  interrupts.CPU0.TLB:TLB_shootdowns
    606.62            +0.1%     607.20        interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
      2968 ± 45%     +25.6%       3727 ± 39%  interrupts.CPU1.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU1.IWI:IRQ_work_interrupts
    606170            +0.1%     606807        interrupts.CPU1.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU1.MCP:Machine_check_polls
      7580 ± 19%      +2.8%       7793 ± 15%  interrupts.CPU1.NMI:Non-maskable_interrupts
      7580 ± 19%      +2.8%       7793 ± 15%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    399.69 ± 16%      +9.8%     438.90 ± 21%  interrupts.CPU1.RES:Rescheduling_interrupts
      4.46 ±172%     -35.0%       2.90 ±107%  interrupts.CPU1.TLB:TLB_shootdowns
      6814 ±131%      -7.4%       6309 ±166%  interrupts.CPU10.31:PCI-MSI.524289-edge.eth0-TxRx-0
      1158 ± 41%     +43.0%       1656 ± 25%  interrupts.CPU10.CAL:Function_call_interrupts
      1.85 ± 19%      +8.3%       2.00        interrupts.CPU10.IWI:IRQ_work_interrupts
    606113            +0.1%     606842        interrupts.CPU10.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU10.MCP:Machine_check_polls
      7580 ± 19%      +8.2%       8204        interrupts.CPU10.NMI:Non-maskable_interrupts
      7580 ± 19%      +8.2%       8204        interrupts.CPU10.PMI:Performance_monitoring_interrupts
    338.23 ±  8%      +0.8%     340.90 ±  9%  interrupts.CPU10.RES:Rescheduling_interrupts
      2.54 ± 29%     -29.1%       1.80 ± 54%  interrupts.CPU10.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU100.144:PCI-MSI.23593061-edge.nvme0q101
      0.00          -100.0%       0.00        interrupts.CPU100.147:PCI-MSI.23593061-edge.nvme0q101
      0.00          -100.0%       0.00        interrupts.CPU100.148:PCI-MSI.23593061-edge.nvme0q101
      0.00          -100.0%       0.00        interrupts.CPU100.153:PCI-MSI.23593061-edge.nvme0q101
      0.00          -100.0%       0.00        interrupts.CPU100.156:PCI-MSI.23593061-edge.nvme0q101
      0.00          -100.0%       0.00        interrupts.CPU100.167:PCI-MSI.23593061-edge.nvme0q101
      0.00          -100.0%       0.00        interrupts.CPU100.176:PCI-MSI.23593061-edge.nvme0q101
      1097 ± 29%    +112.1%       2328 ± 78%  interrupts.CPU100.CAL:Function_call_interrupts
      1.92 ± 13%      +4.0%       2.00        interrupts.CPU100.IWI:IRQ_work_interrupts
    606051            +0.1%     606726        interrupts.CPU100.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU100.MCP:Machine_check_polls
      7896 ± 13%      +3.9%       8203        interrupts.CPU100.NMI:Non-maskable_interrupts
      7896 ± 13%      +3.9%       8203        interrupts.CPU100.PMI:Performance_monitoring_interrupts
    310.92           +31.8%     409.80 ± 71%  interrupts.CPU100.RES:Rescheduling_interrupts
      2.38 ± 35%     -28.7%       1.70 ± 64%  interrupts.CPU100.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU101.151:PCI-MSI.23593062-edge.nvme0q102
      0.00          -100.0%       0.00        interrupts.CPU101.154:PCI-MSI.23593062-edge.nvme0q102
      0.00          -100.0%       0.00        interrupts.CPU101.157:PCI-MSI.23593062-edge.nvme0q102
      1260 ± 56%     +41.2%       1779 ± 35%  interrupts.CPU101.CAL:Function_call_interrupts
      1.92 ± 13%      +4.0%       2.00        interrupts.CPU101.IWI:IRQ_work_interrupts
    606021            +0.1%     606704        interrupts.CPU101.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU101.MCP:Machine_check_polls
      7897 ± 13%      +3.9%       8202        interrupts.CPU101.NMI:Non-maskable_interrupts
      7897 ± 13%      +3.9%       8202        interrupts.CPU101.PMI:Performance_monitoring_interrupts
    333.38 ± 22%      +8.6%     362.10 ± 33%  interrupts.CPU101.RES:Rescheduling_interrupts
      2.31 ± 46%     -17.7%       1.90 ± 54%  interrupts.CPU101.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU102.146:PCI-MSI.23593063-edge.nvme0q103
      0.00          -100.0%       0.00        interrupts.CPU102.152:PCI-MSI.23593063-edge.nvme0q103
      0.00          -100.0%       0.00        interrupts.CPU102.158:PCI-MSI.23593063-edge.nvme0q103
      1095 ± 29%     +65.6%       1815 ± 46%  interrupts.CPU102.CAL:Function_call_interrupts
      1.85 ± 19%      +8.3%       2.00        interrupts.CPU102.IWI:IRQ_work_interrupts
    606024            +0.1%     606726        interrupts.CPU102.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU102.MCP:Machine_check_polls
      7581 ± 19%      +8.2%       8203        interrupts.CPU102.NMI:Non-maskable_interrupts
      7581 ± 19%      +8.2%       8203        interrupts.CPU102.PMI:Performance_monitoring_interrupts
    311.69 ±  2%     +27.3%     396.80 ± 44%  interrupts.CPU102.RES:Rescheduling_interrupts
      2.46 ± 40%     -22.8%       1.90 ± 54%  interrupts.CPU102.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU103.153:PCI-MSI.23593064-edge.nvme0q104
      0.00          -100.0%       0.00        interrupts.CPU103.156:PCI-MSI.23593064-edge.nvme0q104
      0.00          -100.0%       0.00        interrupts.CPU103.159:PCI-MSI.23593064-edge.nvme0q104
      1106 ± 30%     +38.7%       1534 ± 29%  interrupts.CPU103.CAL:Function_call_interrupts
      1.77 ± 23%      +7.4%       1.90 ± 15%  interrupts.CPU103.IWI:IRQ_work_interrupts
    606003            +0.1%     606785        interrupts.CPU103.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU103.MCP:Machine_check_polls
      7265 ± 23%      +7.3%       7794 ± 15%  interrupts.CPU103.NMI:Non-maskable_interrupts
      7265 ± 23%      +7.3%       7794 ± 15%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
    318.15 ±  9%      -2.0%     311.80        interrupts.CPU103.RES:Rescheduling_interrupts
      2.38 ± 42%     -20.3%       1.90 ± 68%  interrupts.CPU103.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU104.160:PCI-MSI.23593065-edge.nvme0q105
      0.00          -100.0%       0.00        interrupts.CPU104.171:PCI-MSI.23593065-edge.nvme0q105
      0.00          -100.0%       0.00        interrupts.CPU104.180:PCI-MSI.23593065-edge.nvme0q105
      1625 ±124%      +2.2%       1660 ± 25%  interrupts.CPU104.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU104.IWI:IRQ_work_interrupts
    606031            +0.1%     606744        interrupts.CPU104.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU104.MCP:Machine_check_polls
      7582 ± 19%      +2.8%       7793 ± 15%  interrupts.CPU104.NMI:Non-maskable_interrupts
      7582 ± 19%      +2.8%       7793 ± 15%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
    401.31 ± 77%     -15.4%     339.40 ± 13%  interrupts.CPU104.RES:Rescheduling_interrupts
      2.38 ± 45%     -20.3%       1.90 ± 54%  interrupts.CPU104.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU105.153:PCI-MSI.23593066-edge.nvme0q106
      0.00          -100.0%       0.00        interrupts.CPU105.172:PCI-MSI.23593066-edge.nvme0q106
      1096 ± 29%     +46.8%       1609 ± 25%  interrupts.CPU105.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU105.IWI:IRQ_work_interrupts
    606001            +0.1%     606703        interrupts.CPU105.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU105.MCP:Machine_check_polls
      7581 ± 19%      +2.8%       7793 ± 15%  interrupts.CPU105.NMI:Non-maskable_interrupts
      7581 ± 19%      +2.8%       7793 ± 15%  interrupts.CPU105.PMI:Performance_monitoring_interrupts
    310.23            -0.2%     309.50        interrupts.CPU105.RES:Rescheduling_interrupts
      2.54 ± 39%     -25.2%       1.90 ± 49%  interrupts.CPU105.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU106.156:PCI-MSI.23593067-edge.nvme0q107
      0.00          -100.0%       0.00        interrupts.CPU106.160:PCI-MSI.23593067-edge.nvme0q107
      0.00          -100.0%       0.00        interrupts.CPU106.169:PCI-MSI.23593067-edge.nvme0q107
      0.00          -100.0%       0.00        interrupts.CPU106.173:PCI-MSI.23593067-edge.nvme0q107
      0.00          -100.0%       0.00        interrupts.CPU106.182:PCI-MSI.23593067-edge.nvme0q107
      1764 ±141%     -10.0%       1587 ± 36%  interrupts.CPU106.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU106.IWI:IRQ_work_interrupts
    606026            +0.1%     606767        interrupts.CPU106.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU106.MCP:Machine_check_polls
      7582 ± 19%      -2.6%       7382 ± 22%  interrupts.CPU106.NMI:Non-maskable_interrupts
      7582 ± 19%      -2.6%       7382 ± 22%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
    404.46 ± 82%      -7.3%     374.90 ± 39%  interrupts.CPU106.RES:Rescheduling_interrupts
      2.46 ± 43%     -22.8%       1.90 ± 54%  interrupts.CPU106.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU107.154:PCI-MSI.23593068-edge.nvme0q108
      0.00          -100.0%       0.00        interrupts.CPU107.160:PCI-MSI.23593068-edge.nvme0q108
      0.00          -100.0%       0.00        interrupts.CPU107.161:PCI-MSI.23593068-edge.nvme0q108
      0.00          -100.0%       0.00        interrupts.CPU107.164:PCI-MSI.23593068-edge.nvme0q108
      0.00          -100.0%       0.00        interrupts.CPU107.187:PCI-MSI.23593068-edge.nvme0q108
      1958 ±147%     -13.0%       1704 ± 30%  interrupts.CPU107.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU107.IWI:IRQ_work_interrupts
    606051            +0.1%     606789        interrupts.CPU107.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU107.MCP:Machine_check_polls
      7581 ± 19%      +2.8%       7793 ± 15%  interrupts.CPU107.NMI:Non-maskable_interrupts
      7581 ± 19%      +2.8%       7793 ± 15%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
    444.08 ± 94%     -25.8%     329.70 ± 15%  interrupts.CPU107.RES:Rescheduling_interrupts
      2.62 ± 38%     -27.4%       1.90 ± 64%  interrupts.CPU107.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU108.164:PCI-MSI.23593069-edge.nvme0q109
      0.00          -100.0%       0.00        interrupts.CPU108.167:PCI-MSI.23593069-edge.nvme0q109
      1104 ± 28%     +49.8%       1654 ± 26%  interrupts.CPU108.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU108.IWI:IRQ_work_interrupts
    606042            +0.1%     606734        interrupts.CPU108.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU108.MCP:Machine_check_polls
      7581 ± 19%      +2.8%       7792 ± 15%  interrupts.CPU108.NMI:Non-maskable_interrupts
      7581 ± 19%      +2.8%       7792 ± 15%  interrupts.CPU108.PMI:Performance_monitoring_interrupts
    308.46            +7.0%     329.90 ± 14%  interrupts.CPU108.RES:Rescheduling_interrupts
      2.69 ± 36%     -22.0%       2.10 ± 44%  interrupts.CPU108.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU109.157:PCI-MSI.23593070-edge.nvme0q110
      0.00          -100.0%       0.00        interrupts.CPU109.162:PCI-MSI.23593070-edge.nvme0q110
      0.00          -100.0%       0.00        interrupts.CPU109.163:PCI-MSI.23593070-edge.nvme0q110
      1095 ± 29%     +47.1%       1611 ± 25%  interrupts.CPU109.CAL:Function_call_interrupts
      1.92 ± 13%      +9.2%       2.10 ± 14%  interrupts.CPU109.IWI:IRQ_work_interrupts
    606046            +0.1%     606745        interrupts.CPU109.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU109.MCP:Machine_check_polls
      7898 ± 13%      +3.9%       8203        interrupts.CPU109.NMI:Non-maskable_interrupts
      7898 ± 13%      +3.9%       8203        interrupts.CPU109.PMI:Performance_monitoring_interrupts
    308.54            +0.7%     310.70        interrupts.CPU109.RES:Rescheduling_interrupts
      2.46 ± 34%     -22.8%       1.90 ± 54%  interrupts.CPU109.TLB:TLB_shootdowns
      8223 ±123%     -80.6%       1592 ± 97%  interrupts.CPU11.32:PCI-MSI.524290-edge.eth0-TxRx-1
      1556 ±110%     +15.8%       1802 ± 37%  interrupts.CPU11.CAL:Function_call_interrupts
      1.77 ± 23%     +13.0%       2.00        interrupts.CPU11.IWI:IRQ_work_interrupts
    606082            +0.1%     606775        interrupts.CPU11.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU11.MCP:Machine_check_polls
      7264 ± 23%     +12.9%       8204        interrupts.CPU11.NMI:Non-maskable_interrupts
      7264 ± 23%     +12.9%       8204        interrupts.CPU11.PMI:Performance_monitoring_interrupts
    398.54 ± 67%      -1.9%     391.10 ± 48%  interrupts.CPU11.RES:Rescheduling_interrupts
      2.38 ± 35%     -24.5%       1.80 ± 41%  interrupts.CPU11.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU110.158:PCI-MSI.23593071-edge.nvme0q111
      0.00          -100.0%       0.00        interrupts.CPU110.160:PCI-MSI.23593071-edge.nvme0q111
      0.00          -100.0%       0.00        interrupts.CPU110.164:PCI-MSI.23593071-edge.nvme0q111
      1095 ± 29%     +47.8%       1618 ± 26%  interrupts.CPU110.CAL:Function_call_interrupts
      1.92 ± 13%      -1.2%       1.90 ± 15%  interrupts.CPU110.IWI:IRQ_work_interrupts
    606074            +0.1%     606709        interrupts.CPU110.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU110.MCP:Machine_check_polls
      7898 ± 13%      -1.3%       7793 ± 15%  interrupts.CPU110.NMI:Non-maskable_interrupts
      7898 ± 13%      -1.3%       7793 ± 15%  interrupts.CPU110.PMI:Performance_monitoring_interrupts
    308.46            +2.9%     317.50 ±  8%  interrupts.CPU110.RES:Rescheduling_interrupts
      2.62 ± 31%     -27.4%       1.90 ± 68%  interrupts.CPU110.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU111.159:PCI-MSI.23593072-edge.nvme0q112
      0.00          -100.0%       0.00        interrupts.CPU111.161:PCI-MSI.23593072-edge.nvme0q112
      1095 ± 29%     +54.0%       1685 ± 34%  interrupts.CPU111.CAL:Function_call_interrupts
      1.77 ± 23%     +13.0%       2.00        interrupts.CPU111.IWI:IRQ_work_interrupts
    606053            +0.1%     606717        interrupts.CPU111.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU111.MCP:Machine_check_polls
      7265 ± 23%     +12.9%       8202        interrupts.CPU111.NMI:Non-maskable_interrupts
      7265 ± 23%     +12.9%       8202        interrupts.CPU111.PMI:Performance_monitoring_interrupts
    311.46 ±  2%      +8.4%     337.50 ± 20%  interrupts.CPU111.RES:Rescheduling_interrupts
      2.54 ± 33%     -25.2%       1.90 ± 54%  interrupts.CPU111.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU112.170:PCI-MSI.23593081-edge.nvme0q121
      0.00          -100.0%       0.00        interrupts.CPU112.183:PCI-MSI.23593081-edge.nvme0q121
      1095 ± 29%     +47.0%       1609 ± 25%  interrupts.CPU112.CAL:Function_call_interrupts
      1.62 ± 30%     +23.8%       2.00        interrupts.CPU112.IWI:IRQ_work_interrupts
    606052            +0.1%     606656        interrupts.CPU112.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU112.MCP:Machine_check_polls
      6633 ± 30%     +23.7%       8204        interrupts.CPU112.NMI:Non-maskable_interrupts
      6633 ± 30%     +23.7%       8204        interrupts.CPU112.PMI:Performance_monitoring_interrupts
    309.00            +0.6%     311.00        interrupts.CPU112.RES:Rescheduling_interrupts
      2.62 ± 31%     -27.4%       1.90 ± 54%  interrupts.CPU112.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU113.165:PCI-MSI.23593082-edge.nvme0q122
      0.00          -100.0%       0.00        interrupts.CPU113.188:PCI-MSI.23593082-edge.nvme0q122
      1037 ± 26%     +56.2%       1620 ± 25%  interrupts.CPU113.CAL:Function_call_interrupts
      1.69 ± 27%     +18.2%       2.00        interrupts.CPU113.IWI:IRQ_work_interrupts
    606040            +0.1%     606711        interrupts.CPU113.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU113.MCP:Machine_check_polls
      6949 ± 27%     +18.1%       8204        interrupts.CPU113.NMI:Non-maskable_interrupts
      6949 ± 27%     +18.1%       8204        interrupts.CPU113.PMI:Performance_monitoring_interrupts
    310.62            -0.1%     310.20        interrupts.CPU113.RES:Rescheduling_interrupts
      2.62 ± 28%     -27.4%       1.90 ± 43%  interrupts.CPU113.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU114.166:PCI-MSI.23593083-edge.nvme0q123
      0.00          -100.0%       0.00        interrupts.CPU114.169:PCI-MSI.23593083-edge.nvme0q123
      0.00          -100.0%       0.00        interrupts.CPU114.172:PCI-MSI.23593083-edge.nvme0q123
      0.00          -100.0%       0.00        interrupts.CPU114.175:PCI-MSI.23593083-edge.nvme0q123
      1204 ± 50%     +34.2%       1616 ± 25%  interrupts.CPU114.CAL:Function_call_interrupts
      1.69 ± 27%     +18.2%       2.00        interrupts.CPU114.IWI:IRQ_work_interrupts
    606026            +0.1%     606702        interrupts.CPU114.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU114.MCP:Machine_check_polls
      6949 ± 27%     +18.1%       8204        interrupts.CPU114.NMI:Non-maskable_interrupts
      6949 ± 27%     +18.1%       8204        interrupts.CPU114.PMI:Performance_monitoring_interrupts
    341.77 ± 31%      -7.0%     318.00 ±  7%  interrupts.CPU114.RES:Rescheduling_interrupts
      2.54 ± 29%     -29.1%       1.80 ± 64%  interrupts.CPU114.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU115.171:PCI-MSI.23593084-edge.nvme0q124
      0.00          -100.0%       0.00        interrupts.CPU115.173:PCI-MSI.23593084-edge.nvme0q124
      0.00          -100.0%       0.00        interrupts.CPU115.179:PCI-MSI.23593084-edge.nvme0q124
      1094 ± 29%     +47.2%       1611 ± 25%  interrupts.CPU115.CAL:Function_call_interrupts
      1.69 ± 27%     +18.2%       2.00        interrupts.CPU115.IWI:IRQ_work_interrupts
    606026            +0.1%     606723        interrupts.CPU115.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU115.MCP:Machine_check_polls
      6949 ± 27%     +18.0%       8204        interrupts.CPU115.NMI:Non-maskable_interrupts
      6949 ± 27%     +18.0%       8204        interrupts.CPU115.PMI:Performance_monitoring_interrupts
    308.23           +31.1%     404.00 ± 69%  interrupts.CPU115.RES:Rescheduling_interrupts
      2.62 ± 31%     -31.2%       1.80 ± 64%  interrupts.CPU115.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU116.168:PCI-MSI.23593085-edge.nvme0q125
      1067 ± 26%     +95.3%       2084 ± 71%  interrupts.CPU116.CAL:Function_call_interrupts
      1.77 ± 23%      +7.4%       1.90 ± 15%  interrupts.CPU116.IWI:IRQ_work_interrupts
    606012            +0.1%     606725        interrupts.CPU116.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU116.MCP:Machine_check_polls
      7265 ± 23%      +7.3%       7794 ± 15%  interrupts.CPU116.NMI:Non-maskable_interrupts
      7265 ± 23%      +7.3%       7794 ± 15%  interrupts.CPU116.PMI:Performance_monitoring_interrupts
    310.54           +19.4%     370.80 ± 48%  interrupts.CPU116.RES:Rescheduling_interrupts
      2.54 ± 33%     -29.1%       1.80 ± 64%  interrupts.CPU116.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU117.169:PCI-MSI.23593086-edge.nvme0q126
      0.00          -100.0%       0.00        interrupts.CPU117.175:PCI-MSI.23593086-edge.nvme0q126
      1166 ± 42%     +41.8%       1654 ± 26%  interrupts.CPU117.CAL:Function_call_interrupts
      1.77 ± 23%      +7.4%       1.90 ± 15%  interrupts.CPU117.IWI:IRQ_work_interrupts
    606060            +0.1%     606705        interrupts.CPU117.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU117.MCP:Machine_check_polls
      7265 ± 23%      +7.3%       7794 ± 15%  interrupts.CPU117.NMI:Non-maskable_interrupts
      7265 ± 23%      +7.3%       7794 ± 15%  interrupts.CPU117.PMI:Performance_monitoring_interrupts
    336.00 ± 28%      -2.9%     326.20 ± 15%  interrupts.CPU117.RES:Rescheduling_interrupts
      2.62 ± 31%     -27.4%       1.90 ± 54%  interrupts.CPU117.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU118.174:PCI-MSI.23593087-edge.nvme0q127
      0.00          -100.0%       0.00        interrupts.CPU118.180:PCI-MSI.23593087-edge.nvme0q127
      0.00          -100.0%       0.00        interrupts.CPU118.203:PCI-MSI.23593087-edge.nvme0q127
      1099 ± 29%     +47.0%       1615 ± 25%  interrupts.CPU118.CAL:Function_call_interrupts
      1.77 ± 23%      +1.7%       1.80 ± 22%  interrupts.CPU118.IWI:IRQ_work_interrupts
    606070            +0.1%     606697        interrupts.CPU118.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU118.MCP:Machine_check_polls
      7265 ± 23%      +1.6%       7384 ± 22%  interrupts.CPU118.NMI:Non-maskable_interrupts
      7265 ± 23%      +1.6%       7384 ± 22%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
    312.08 ±  3%      -0.7%     310.00        interrupts.CPU118.RES:Rescheduling_interrupts
      2.46 ± 34%     -18.8%       2.00 ± 50%  interrupts.CPU118.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU119.177:PCI-MSI.23593088-edge.nvme0q128
      0.00          -100.0%       0.00        interrupts.CPU119.181:PCI-MSI.23593088-edge.nvme0q128
      1112 ± 28%     +44.2%       1603 ± 25%  interrupts.CPU119.CAL:Function_call_interrupts
      1.77 ± 23%      +7.4%       1.90 ± 15%  interrupts.CPU119.IWI:IRQ_work_interrupts
    606012            +0.1%     606753        interrupts.CPU119.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU119.MCP:Machine_check_polls
      7265 ± 23%      +7.3%       7793 ± 15%  interrupts.CPU119.NMI:Non-maskable_interrupts
      7265 ± 23%      +7.3%       7793 ± 15%  interrupts.CPU119.PMI:Performance_monitoring_interrupts
    317.31 ±  5%      -2.5%     309.50        interrupts.CPU119.RES:Rescheduling_interrupts
      2.54 ± 33%    +108.8%       5.30 ±200%  interrupts.CPU119.TLB:TLB_shootdowns
      3382 ±164%     +72.1%       5822 ±181%  interrupts.CPU12.33:PCI-MSI.524291-edge.eth0-TxRx-2
      1098 ± 29%     +46.6%       1611 ± 25%  interrupts.CPU12.CAL:Function_call_interrupts
      1.69 ± 27%     +18.2%       2.00        interrupts.CPU12.IWI:IRQ_work_interrupts
    606084            +0.1%     606788        interrupts.CPU12.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU12.MCP:Machine_check_polls
      6949 ± 27%     +18.0%       8203        interrupts.CPU12.NMI:Non-maskable_interrupts
      6949 ± 27%     +18.0%       8203        interrupts.CPU12.PMI:Performance_monitoring_interrupts
    320.15 ±  3%      +1.1%     323.70 ±  3%  interrupts.CPU12.RES:Rescheduling_interrupts
      2.31 ± 31%     -17.7%       1.90 ± 49%  interrupts.CPU12.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU120.54:PCI-MSI.23592961-edge.nvme0q1
      0.00          -100.0%       0.00        interrupts.CPU120.57:PCI-MSI.23592961-edge.nvme0q1
      0.00          -100.0%       0.00        interrupts.CPU120.63:PCI-MSI.23592961-edge.nvme0q1
     13271 ± 30%      -4.3%      12696 ± 38%  interrupts.CPU120.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU120.IWI:IRQ_work_interrupts
    606355            +0.1%     606998        interrupts.CPU120.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU120.MCP:Machine_check_polls
      7560 ± 19%      +2.8%       7768 ± 15%  interrupts.CPU120.NMI:Non-maskable_interrupts
      7560 ± 19%      +2.8%       7768 ± 15%  interrupts.CPU120.PMI:Performance_monitoring_interrupts
    343.08 ±  8%      -3.8%     330.10 ±  4%  interrupts.CPU120.RES:Rescheduling_interrupts
     13.46 ±241%     -89.6%       1.40 ± 57%  interrupts.CPU120.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU121.55:PCI-MSI.23592962-edge.nvme0q2
      0.00          -100.0%       0.00        interrupts.CPU121.81:PCI-MSI.23592962-edge.nvme0q2
      3669 ± 46%      -2.3%       3584 ± 29%  interrupts.CPU121.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU121.IWI:IRQ_work_interrupts
    606172            +0.1%     606892        interrupts.CPU121.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU121.MCP:Machine_check_polls
      7561 ± 19%      +2.7%       7768 ± 15%  interrupts.CPU121.NMI:Non-maskable_interrupts
      7561 ± 19%      +2.7%       7768 ± 15%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
    364.15 ± 11%      +8.6%     395.60 ± 10%  interrupts.CPU121.RES:Rescheduling_interrupts
      2.15 ± 40%     -30.4%       1.50 ± 44%  interrupts.CPU121.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU122.46:PCI-MSI.23592963-edge.nvme0q3
      0.00          -100.0%       0.00        interrupts.CPU122.52:PCI-MSI.23592963-edge.nvme0q3
      0.00          -100.0%       0.00        interrupts.CPU122.59:PCI-MSI.23592963-edge.nvme0q3
      0.00          -100.0%       0.00        interrupts.CPU122.65:PCI-MSI.23592963-edge.nvme0q3
      0.00          -100.0%       0.00        interrupts.CPU122.69:PCI-MSI.23592963-edge.nvme0q3
      2116 ± 65%     +56.5%       3311 ± 47%  interrupts.CPU122.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU122.IWI:IRQ_work_interrupts
    606112            +0.1%     606710        interrupts.CPU122.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU122.MCP:Machine_check_polls
      7561 ± 19%      -2.6%       7361 ± 22%  interrupts.CPU122.NMI:Non-maskable_interrupts
      7561 ± 19%      -2.6%       7361 ± 22%  interrupts.CPU122.PMI:Performance_monitoring_interrupts
    426.62 ± 43%     +10.1%     469.60 ± 34%  interrupts.CPU122.RES:Rescheduling_interrupts
      4.92 ±172%     -71.6%       1.40 ± 57%  interrupts.CPU122.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU123.51:PCI-MSI.23592964-edge.nvme0q4
      0.00          -100.0%       0.00        interrupts.CPU123.53:PCI-MSI.23592964-edge.nvme0q4
      0.00          -100.0%       0.00        interrupts.CPU123.57:PCI-MSI.23592964-edge.nvme0q4
      0.00          -100.0%       0.00        interrupts.CPU123.60:PCI-MSI.23592964-edge.nvme0q4
      1473 ± 77%     +21.1%       1783 ± 28%  interrupts.CPU123.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU123.IWI:IRQ_work_interrupts
    606058            +0.1%     606791        interrupts.CPU123.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU123.MCP:Machine_check_polls
      7561 ± 19%      -2.7%       7360 ± 22%  interrupts.CPU123.NMI:Non-maskable_interrupts
      7561 ± 19%      -2.7%       7360 ± 22%  interrupts.CPU123.PMI:Performance_monitoring_interrupts
    364.85 ± 45%      -0.0%     364.80 ± 27%  interrupts.CPU123.RES:Rescheduling_interrupts
      2.77 ± 55%     -45.8%       1.50 ± 61%  interrupts.CPU123.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU124.54:PCI-MSI.23592965-edge.nvme0q5
      0.00          -100.0%       0.00        interrupts.CPU124.61:PCI-MSI.23592965-edge.nvme0q5
      2062 ±144%     -19.1%       1668 ± 26%  interrupts.CPU124.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU124.IWI:IRQ_work_interrupts
    606071            +0.1%     606749        interrupts.CPU124.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU124.MCP:Machine_check_polls
      7561 ± 19%      -2.7%       7360 ± 22%  interrupts.CPU124.NMI:Non-maskable_interrupts
      7561 ± 19%      -2.7%       7360 ± 22%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
    507.69 ±115%     -17.6%     418.10 ± 64%  interrupts.CPU124.RES:Rescheduling_interrupts
      2.08 ± 29%     -23.0%       1.60 ± 50%  interrupts.CPU124.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU125.55:PCI-MSI.23592966-edge.nvme0q6
      0.00          -100.0%       0.00        interrupts.CPU125.59:PCI-MSI.23592966-edge.nvme0q6
      0.00          -100.0%       0.00        interrupts.CPU125.85:PCI-MSI.23592966-edge.nvme0q6
      1104 ± 28%     +58.4%       1750 ± 42%  interrupts.CPU125.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU125.IWI:IRQ_work_interrupts
    606025            +0.1%     606751        interrupts.CPU125.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU125.MCP:Machine_check_polls
      7561 ± 19%      -2.7%       7360 ± 22%  interrupts.CPU125.NMI:Non-maskable_interrupts
      7561 ± 19%      -2.7%       7360 ± 22%  interrupts.CPU125.PMI:Performance_monitoring_interrupts
    317.15 ±  7%     +10.3%     349.80 ± 35%  interrupts.CPU125.RES:Rescheduling_interrupts
      2.46 ± 37%     -35.0%       1.60 ± 63%  interrupts.CPU125.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU126.60:PCI-MSI.23592967-edge.nvme0q7
      1254 ± 34%     +21.1%       1519 ± 21%  interrupts.CPU126.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU126.IWI:IRQ_work_interrupts
    606058            +0.1%     606765        interrupts.CPU126.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU126.MCP:Machine_check_polls
      7560 ± 19%      -2.6%       7360 ± 22%  interrupts.CPU126.NMI:Non-maskable_interrupts
      7560 ± 19%      -2.6%       7360 ± 22%  interrupts.CPU126.PMI:Performance_monitoring_interrupts
    391.54 ± 39%     -21.0%     309.50 ±  2%  interrupts.CPU126.RES:Rescheduling_interrupts
      2.15 ± 30%     +11.4%       2.40 ±102%  interrupts.CPU126.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU127.51:PCI-MSI.23592968-edge.nvme0q8
      0.00          -100.0%       0.00        interrupts.CPU127.60:PCI-MSI.23592968-edge.nvme0q8
      0.00          -100.0%       0.00        interrupts.CPU127.70:PCI-MSI.23592968-edge.nvme0q8
      1173 ± 30%     +38.4%       1623 ± 25%  interrupts.CPU127.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU127.IWI:IRQ_work_interrupts
    606082            +0.1%     606746        interrupts.CPU127.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU127.MCP:Machine_check_polls
      7560 ± 19%      +2.8%       7769 ± 15%  interrupts.CPU127.NMI:Non-maskable_interrupts
      7560 ± 19%      +2.8%       7769 ± 15%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
    352.00 ± 28%     -12.6%     307.60        interrupts.CPU127.RES:Rescheduling_interrupts
      2.31 ± 31%      -4.7%       2.20 ± 72%  interrupts.CPU127.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU128.52:PCI-MSI.23592969-edge.nvme0q9
      0.00          -100.0%       0.00        interrupts.CPU128.61:PCI-MSI.23592969-edge.nvme0q9
      1144 ± 27%     +41.8%       1622 ± 25%  interrupts.CPU128.CAL:Function_call_interrupts
      1.85 ± 19%      +8.3%       2.00        interrupts.CPU128.IWI:IRQ_work_interrupts
    605991            +0.1%     606731        interrupts.CPU128.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU128.MCP:Machine_check_polls
      7559 ± 19%      +8.2%       8178        interrupts.CPU128.NMI:Non-maskable_interrupts
      7559 ± 19%      +8.2%       8178        interrupts.CPU128.PMI:Performance_monitoring_interrupts
    326.23 ± 14%      -4.8%     310.70 ±  3%  interrupts.CPU128.RES:Rescheduling_interrupts
      2.46 ± 34%     -18.8%       2.00 ± 54%  interrupts.CPU128.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU129.53:PCI-MSI.23592970-edge.nvme0q10
      0.00          -100.0%       0.00        interrupts.CPU129.62:PCI-MSI.23592970-edge.nvme0q10
      0.00          -100.0%       0.00        interrupts.CPU129.68:PCI-MSI.23592970-edge.nvme0q10
      0.00          -100.0%       0.00        interrupts.CPU129.72:PCI-MSI.23592970-edge.nvme0q10
      1106 ± 28%     +45.2%       1607 ± 24%  interrupts.CPU129.CAL:Function_call_interrupts
      1.85 ± 19%      +8.3%       2.00        interrupts.CPU129.IWI:IRQ_work_interrupts
    606085            +0.1%     606738        interrupts.CPU129.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU129.MCP:Machine_check_polls
      7560 ± 19%      +8.2%       8178        interrupts.CPU129.NMI:Non-maskable_interrupts
      7560 ± 19%      +8.2%       8178        interrupts.CPU129.PMI:Performance_monitoring_interrupts
    312.38 ±  5%      -0.2%     311.80 ±  3%  interrupts.CPU129.RES:Rescheduling_interrupts
      2.62 ± 41%     -27.4%       1.90 ± 64%  interrupts.CPU129.TLB:TLB_shootdowns
      3492 ±125%    +166.1%       9295 ±116%  interrupts.CPU13.34:PCI-MSI.524292-edge.eth0-TxRx-3
      1095 ± 29%     +47.9%       1620 ± 25%  interrupts.CPU13.CAL:Function_call_interrupts
      1.77 ± 23%     +13.0%       2.00        interrupts.CPU13.IWI:IRQ_work_interrupts
    606061            +0.1%     606811        interrupts.CPU13.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU13.MCP:Machine_check_polls
      7265 ± 23%     +12.9%       8204        interrupts.CPU13.NMI:Non-maskable_interrupts
      7265 ± 23%     +12.9%       8204        interrupts.CPU13.PMI:Performance_monitoring_interrupts
    319.23 ±  3%     +34.4%     429.00 ± 65%  interrupts.CPU13.RES:Rescheduling_interrupts
      2.31 ± 35%     -13.3%       2.00 ± 54%  interrupts.CPU13.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU130.54:PCI-MSI.23592971-edge.nvme0q11
      0.00          -100.0%       0.00        interrupts.CPU130.64:PCI-MSI.23592971-edge.nvme0q11
      0.00          -100.0%       0.00        interrupts.CPU130.73:PCI-MSI.23592971-edge.nvme0q11
      1108 ± 28%     +45.5%       1613 ± 25%  interrupts.CPU130.CAL:Function_call_interrupts
      1.92 ± 13%      +4.0%       2.00        interrupts.CPU130.IWI:IRQ_work_interrupts
    606102            +0.1%     606738        interrupts.CPU130.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU130.MCP:Machine_check_polls
      7875 ± 13%      +3.8%       8178        interrupts.CPU130.NMI:Non-maskable_interrupts
      7875 ± 13%      +3.8%       8178        interrupts.CPU130.PMI:Performance_monitoring_interrupts
    307.69            +0.3%     308.70        interrupts.CPU130.RES:Rescheduling_interrupts
      2.31 ± 39%     -17.7%       1.90 ± 64%  interrupts.CPU130.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU131.55:PCI-MSI.23592972-edge.nvme0q12
      0.00          -100.0%       0.00        interrupts.CPU131.59:PCI-MSI.23592972-edge.nvme0q12
      0.00          -100.0%       0.00        interrupts.CPU131.61:PCI-MSI.23592972-edge.nvme0q12
      0.00          -100.0%       0.00        interrupts.CPU131.65:PCI-MSI.23592972-edge.nvme0q12
      0.00          -100.0%       0.00        interrupts.CPU131.91:PCI-MSI.23592972-edge.nvme0q12
      1206 ± 35%     +45.7%       1757 ± 34%  interrupts.CPU131.CAL:Function_call_interrupts
      1.92 ± 13%      +4.0%       2.00        interrupts.CPU131.IWI:IRQ_work_interrupts
    606017            +0.1%     606737        interrupts.CPU131.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU131.MCP:Machine_check_polls
      7876 ± 13%      +3.8%       8178        interrupts.CPU131.NMI:Non-maskable_interrupts
      7876 ± 13%      +3.8%       8178        interrupts.CPU131.PMI:Performance_monitoring_interrupts
    348.77 ± 35%      +1.2%     353.10 ± 35%  interrupts.CPU131.RES:Rescheduling_interrupts
      2.46 ± 34%     -26.9%       1.80 ± 59%  interrupts.CPU131.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU132.56:PCI-MSI.23592973-edge.nvme0q13
      0.00          -100.0%       0.00        interrupts.CPU132.60:PCI-MSI.23592973-edge.nvme0q13
      0.00          -100.0%       0.00        interrupts.CPU132.92:PCI-MSI.23592973-edge.nvme0q13
      1112 ± 29%     +44.9%       1612 ± 25%  interrupts.CPU132.CAL:Function_call_interrupts
      1.85 ± 19%      +8.3%       2.00        interrupts.CPU132.IWI:IRQ_work_interrupts
    606027            +0.1%     606731        interrupts.CPU132.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU132.MCP:Machine_check_polls
      7560 ± 19%      +8.2%       8178        interrupts.CPU132.NMI:Non-maskable_interrupts
      7560 ± 19%      +8.2%       8178        interrupts.CPU132.PMI:Performance_monitoring_interrupts
    377.00 ± 63%     -18.5%     307.20        interrupts.CPU132.RES:Rescheduling_interrupts
      6.85 ±154%     -72.2%       1.90 ± 59%  interrupts.CPU132.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU133.57:PCI-MSI.23592974-edge.nvme0q14
      0.00          -100.0%       0.00        interrupts.CPU133.66:PCI-MSI.23592974-edge.nvme0q14
      0.00          -100.0%       0.00        interrupts.CPU133.93:PCI-MSI.23592974-edge.nvme0q14
      1099 ± 29%     +46.6%       1611 ± 25%  interrupts.CPU133.CAL:Function_call_interrupts
      1.85 ± 19%      +8.3%       2.00        interrupts.CPU133.IWI:IRQ_work_interrupts
    606085            +0.1%     606733        interrupts.CPU133.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU133.MCP:Machine_check_polls
      7560 ± 19%      +8.2%       8178        interrupts.CPU133.NMI:Non-maskable_interrupts
      7560 ± 19%      +8.2%       8178        interrupts.CPU133.PMI:Performance_monitoring_interrupts
    307.92            -0.6%     306.10        interrupts.CPU133.RES:Rescheduling_interrupts
      2.69 ± 36%     -29.4%       1.90 ± 54%  interrupts.CPU133.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU134.73:PCI-MSI.23592975-edge.nvme0q15
      0.00          -100.0%       0.00        interrupts.CPU134.77:PCI-MSI.23592975-edge.nvme0q15
      1094 ± 29%     +46.7%       1606 ± 25%  interrupts.CPU134.CAL:Function_call_interrupts
      1.85 ± 19%      +8.3%       2.00        interrupts.CPU134.IWI:IRQ_work_interrupts
    606068            +0.1%     606740        interrupts.CPU134.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU134.MCP:Machine_check_polls
      7560 ± 19%      +8.2%       8178        interrupts.CPU134.NMI:Non-maskable_interrupts
      7560 ± 19%      +8.2%       8178        interrupts.CPU134.PMI:Performance_monitoring_interrupts
    307.77            -0.4%     306.50        interrupts.CPU134.RES:Rescheduling_interrupts
      4.92 ±177%     -57.3%       2.10 ± 58%  interrupts.CPU134.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU135.59:PCI-MSI.23592976-edge.nvme0q16
      0.00          -100.0%       0.00        interrupts.CPU135.68:PCI-MSI.23592976-edge.nvme0q16
      0.00          -100.0%       0.00        interrupts.CPU135.74:PCI-MSI.23592976-edge.nvme0q16
      1121 ± 28%     +44.8%       1624 ± 24%  interrupts.CPU135.CAL:Function_call_interrupts
      1.77 ± 23%      +7.4%       1.90 ± 15%  interrupts.CPU135.IWI:IRQ_work_interrupts
    606038            +0.1%     606782        interrupts.CPU135.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU135.MCP:Machine_check_polls
      7246 ± 23%      +7.2%       7769 ± 15%  interrupts.CPU135.NMI:Non-maskable_interrupts
      7246 ± 23%      +7.2%       7769 ± 15%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
    383.08 ± 68%     -19.9%     307.00        interrupts.CPU135.RES:Rescheduling_interrupts
      2.38 ± 38%     -24.5%       1.80 ± 64%  interrupts.CPU135.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU136.87:PCI-MSI.23592985-edge.nvme0q25
      0.00          -100.0%       0.00        interrupts.CPU136.91:PCI-MSI.23592985-edge.nvme0q25
      1069 ± 32%     +51.0%       1615 ± 25%  interrupts.CPU136.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU136.IWI:IRQ_work_interrupts
    606109            +0.1%     606724        interrupts.CPU136.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU136.MCP:Machine_check_polls
      7561 ± 19%      +2.7%       7768 ± 15%  interrupts.CPU136.NMI:Non-maskable_interrupts
      7561 ± 19%      +2.7%       7768 ± 15%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
    310.38 ±  2%      -1.3%     306.50        interrupts.CPU136.RES:Rescheduling_interrupts
      2.46 ± 40%     -22.8%       1.90 ± 76%  interrupts.CPU136.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU137.79:PCI-MSI.23592986-edge.nvme0q26
      1608 ±108%      +0.5%       1615 ± 26%  interrupts.CPU137.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU137.IWI:IRQ_work_interrupts
    606052            +0.1%     606736        interrupts.CPU137.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU137.MCP:Machine_check_polls
      7561 ± 19%      +2.8%       7769 ± 15%  interrupts.CPU137.NMI:Non-maskable_interrupts
      7561 ± 19%      +2.8%       7769 ± 15%  interrupts.CPU137.PMI:Performance_monitoring_interrupts
    413.46 ± 70%      -3.8%     397.60 ± 68%  interrupts.CPU137.RES:Rescheduling_interrupts
      2.38 ± 38%     -16.1%       2.00 ± 59%  interrupts.CPU137.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU138.70:PCI-MSI.23592987-edge.nvme0q27
      0.00          -100.0%       0.00        interrupts.CPU138.80:PCI-MSI.23592987-edge.nvme0q27
      1076 ± 34%     +46.3%       1574 ± 21%  interrupts.CPU138.CAL:Function_call_interrupts
      1.92 ± 13%      -6.4%       1.80 ± 22%  interrupts.CPU138.IWI:IRQ_work_interrupts
    606089            +0.1%     606769        interrupts.CPU138.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU138.MCP:Machine_check_polls
      7876 ± 13%      -6.5%       7361 ± 22%  interrupts.CPU138.NMI:Non-maskable_interrupts
      7876 ± 13%      -6.5%       7361 ± 22%  interrupts.CPU138.PMI:Performance_monitoring_interrupts
    308.31            -0.0%     308.20        interrupts.CPU138.RES:Rescheduling_interrupts
      2.38 ± 35%     -20.3%       1.90 ± 43%  interrupts.CPU138.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU139.107:PCI-MSI.23592988-edge.nvme0q28
      0.00          -100.0%       0.00        interrupts.CPU139.81:PCI-MSI.23592988-edge.nvme0q28
      1097 ± 29%     +47.2%       1615 ± 26%  interrupts.CPU139.CAL:Function_call_interrupts
      1.92 ± 13%      -6.4%       1.80 ± 22%  interrupts.CPU139.IWI:IRQ_work_interrupts
    606058            +0.1%     606732        interrupts.CPU139.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU139.MCP:Machine_check_polls
      7875 ± 13%      -6.5%       7360 ± 22%  interrupts.CPU139.NMI:Non-maskable_interrupts
      7875 ± 13%      -6.5%       7360 ± 22%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
    309.77 ±  2%      -0.8%     307.40        interrupts.CPU139.RES:Rescheduling_interrupts
      2.54 ± 33%     -33.0%       1.70 ± 64%  interrupts.CPU139.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU14.4:IO-APIC.4-edge.ttyS0
      1095 ± 29%     +47.0%       1610 ± 25%  interrupts.CPU14.CAL:Function_call_interrupts
      1.77 ± 23%      +7.4%       1.90 ± 15%  interrupts.CPU14.IWI:IRQ_work_interrupts
    606076            +0.1%     606764        interrupts.CPU14.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU14.MCP:Machine_check_polls
      7266 ± 23%      +7.2%       7793 ± 15%  interrupts.CPU14.NMI:Non-maskable_interrupts
      7266 ± 23%      +7.2%       7793 ± 15%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    310.31           +12.8%     350.00 ± 27%  interrupts.CPU14.RES:Rescheduling_interrupts
      2.46 ± 30%     -18.8%       2.00 ± 44%  interrupts.CPU14.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU140.108:PCI-MSI.23592989-edge.nvme0q29
      0.00          -100.0%       0.00        interrupts.CPU140.95:PCI-MSI.23592989-edge.nvme0q29
      1098 ± 29%     +49.5%       1641 ± 28%  interrupts.CPU140.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU140.IWI:IRQ_work_interrupts
    606059            +0.1%     606730        interrupts.CPU140.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU140.MCP:Machine_check_polls
      7560 ± 19%      -2.6%       7361 ± 22%  interrupts.CPU140.NMI:Non-maskable_interrupts
      7560 ± 19%      -2.6%       7361 ± 22%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
    307.77            +0.2%     308.50        interrupts.CPU140.RES:Rescheduling_interrupts
      2.54 ± 33%     -29.1%       1.80 ± 64%  interrupts.CPU140.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU141.109:PCI-MSI.23592990-edge.nvme0q30
      1401 ± 65%     +33.5%       1870 ± 57%  interrupts.CPU141.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU141.IWI:IRQ_work_interrupts
    606105            +0.1%     606715        interrupts.CPU141.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU141.MCP:Machine_check_polls
      7560 ± 19%      -2.6%       7360 ± 22%  interrupts.CPU141.NMI:Non-maskable_interrupts
      7560 ± 19%      -2.6%       7360 ± 22%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
    363.31 ± 43%      -1.8%     356.80 ± 38%  interrupts.CPU141.RES:Rescheduling_interrupts
      3.00 ± 73%     -40.0%       1.80 ± 54%  interrupts.CPU141.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU142.110:PCI-MSI.23592991-edge.nvme0q31
      0.00          -100.0%       0.00        interrupts.CPU142.74:PCI-MSI.23592991-edge.nvme0q31
      0.00          -100.0%       0.00        interrupts.CPU142.84:PCI-MSI.23592991-edge.nvme0q31
      0.00          -100.0%       0.00        interrupts.CPU142.89:PCI-MSI.23592991-edge.nvme0q31
      1101 ± 29%     +46.3%       1611 ± 25%  interrupts.CPU142.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU142.IWI:IRQ_work_interrupts
    606044            +0.1%     606759        interrupts.CPU142.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU142.MCP:Machine_check_polls
      7560 ± 19%      -2.6%       7361 ± 22%  interrupts.CPU142.NMI:Non-maskable_interrupts
      7560 ± 19%      -2.6%       7361 ± 22%  interrupts.CPU142.PMI:Performance_monitoring_interrupts
    307.62            +0.1%     307.80        interrupts.CPU142.RES:Rescheduling_interrupts
      2.77 ± 35%     -31.4%       1.90 ± 43%  interrupts.CPU142.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU143.85:PCI-MSI.23592992-edge.nvme0q32
      2123 ±113%     -23.8%       1618 ± 25%  interrupts.CPU143.CAL:Function_call_interrupts
      1.92 ± 13%      -6.4%       1.80 ± 22%  interrupts.CPU143.IWI:IRQ_work_interrupts
    606067            +0.1%     606732        interrupts.CPU143.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU143.MCP:Machine_check_polls
      7875 ± 13%      -6.5%       7361 ± 22%  interrupts.CPU143.NMI:Non-maskable_interrupts
      7875 ± 13%      -6.5%       7361 ± 22%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
    529.38 ± 95%     -42.0%     306.90        interrupts.CPU143.RES:Rescheduling_interrupts
      2.23 ± 39%     -10.3%       2.00 ± 74%  interrupts.CPU143.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU144.99:PCI-MSI.23592993-edge.nvme0q33
     11973 ± 25%     +15.2%      13798 ± 21%  interrupts.CPU144.CAL:Function_call_interrupts
      1.92 ± 13%      -6.4%       1.80 ± 22%  interrupts.CPU144.IWI:IRQ_work_interrupts
    606208            +0.1%     606990        interrupts.CPU144.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU144.MCP:Machine_check_polls
      8207 ± 13%      -6.5%       7670 ± 22%  interrupts.CPU144.NMI:Non-maskable_interrupts
      8207 ± 13%      -6.5%       7670 ± 22%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
    333.85 ±  6%      +0.0%     334.00 ±  6%  interrupts.CPU144.RES:Rescheduling_interrupts
      4.15 ±188%     -66.3%       1.40 ± 57%  interrupts.CPU144.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU145.100:PCI-MSI.23592994-edge.nvme0q34
      0.00          -100.0%       0.00        interrupts.CPU145.94:PCI-MSI.23592994-edge.nvme0q34
      3985 ± 43%     +20.1%       4785 ± 34%  interrupts.CPU145.CAL:Function_call_interrupts
      1.92 ± 13%      -6.4%       1.80 ± 22%  interrupts.CPU145.IWI:IRQ_work_interrupts
    606032            +0.1%     606825        interrupts.CPU145.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU145.MCP:Machine_check_polls
      8208 ± 13%      -6.5%       7672 ± 22%  interrupts.CPU145.NMI:Non-maskable_interrupts
      8208 ± 13%      -6.5%       7672 ± 22%  interrupts.CPU145.PMI:Performance_monitoring_interrupts
    374.62 ±  9%      +6.1%     397.50 ±  8%  interrupts.CPU145.RES:Rescheduling_interrupts
      2.08 ± 29%     -18.1%       1.70 ± 52%  interrupts.CPU145.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU146.88:PCI-MSI.23592995-edge.nvme0q35
      2371 ± 57%     +29.2%       3063 ± 44%  interrupts.CPU146.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU146.IWI:IRQ_work_interrupts
    605926            +0.1%     606672        interrupts.CPU146.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU146.MCP:Machine_check_polls
      7880 ± 19%      -8.0%       7246 ± 26%  interrupts.CPU146.NMI:Non-maskable_interrupts
      7880 ± 19%      -8.0%       7246 ± 26%  interrupts.CPU146.PMI:Performance_monitoring_interrupts
    441.08 ± 28%     -10.8%     393.60 ± 22%  interrupts.CPU146.RES:Rescheduling_interrupts
      2.00 ± 39%     -30.0%       1.40 ± 57%  interrupts.CPU146.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU147.102:PCI-MSI.23592996-edge.nvme0q36
      0.00          -100.0%       0.00        interrupts.CPU147.89:PCI-MSI.23592996-edge.nvme0q36
      0.00          -100.0%       0.00        interrupts.CPU147.96:PCI-MSI.23592996-edge.nvme0q36
      1675 ±117%      -3.4%       1619 ± 25%  interrupts.CPU147.CAL:Function_call_interrupts
      1.77 ± 23%      +1.7%       1.80 ± 22%  interrupts.CPU147.IWI:IRQ_work_interrupts
    605933            +0.1%     606685        interrupts.CPU147.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU147.MCP:Machine_check_polls
      7552 ± 23%      +1.6%       7672 ± 22%  interrupts.CPU147.NMI:Non-maskable_interrupts
      7552 ± 23%      +1.6%       7672 ± 22%  interrupts.CPU147.PMI:Performance_monitoring_interrupts
    394.08 ± 57%     -21.4%     309.80        interrupts.CPU147.RES:Rescheduling_interrupts
      2.15 ± 40%     -21.1%       1.70 ± 64%  interrupts.CPU147.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU148.116:PCI-MSI.23592997-edge.nvme0q37
      0.00          -100.0%       0.00        interrupts.CPU148.90:PCI-MSI.23592997-edge.nvme0q37
      0.00          -100.0%       0.00        interrupts.CPU148.97:PCI-MSI.23592997-edge.nvme0q37
      0.00          -100.0%       0.00        interrupts.CPU148.99:PCI-MSI.23592997-edge.nvme0q37
      1207 ± 36%     +30.4%       1575 ± 26%  interrupts.CPU148.CAL:Function_call_interrupts
      1.77 ± 23%      -3.9%       1.70 ± 26%  interrupts.CPU148.IWI:IRQ_work_interrupts
    605933            +0.1%     606652        interrupts.CPU148.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU148.MCP:Machine_check_polls
      7552 ± 23%      -4.1%       7246 ± 26%  interrupts.CPU148.NMI:Non-maskable_interrupts
      7552 ± 23%      -4.1%       7246 ± 26%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
    338.46 ± 22%      -8.9%     308.50        interrupts.CPU148.RES:Rescheduling_interrupts
      2.62 ± 64%     -31.2%       1.80 ± 64%  interrupts.CPU148.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU149.100:PCI-MSI.23592998-edge.nvme0q38
      0.00          -100.0%       0.00        interrupts.CPU149.85:PCI-MSI.23592998-edge.nvme0q38
      0.00          -100.0%       0.00        interrupts.CPU149.91:PCI-MSI.23592998-edge.nvme0q38
      1121 ± 32%     +44.0%       1614 ± 25%  interrupts.CPU149.CAL:Function_call_interrupts
      1.85 ± 19%      -7.9%       1.70 ± 26%  interrupts.CPU149.IWI:IRQ_work_interrupts
    605951            +0.1%     606652        interrupts.CPU149.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU149.MCP:Machine_check_polls
      7880 ± 19%      -8.1%       7245 ± 26%  interrupts.CPU149.NMI:Non-maskable_interrupts
      7880 ± 19%      -8.1%       7245 ± 26%  interrupts.CPU149.PMI:Performance_monitoring_interrupts
    311.54 ±  2%      -1.2%     307.80        interrupts.CPU149.RES:Rescheduling_interrupts
      2.23 ± 39%     -19.3%       1.80 ± 64%  interrupts.CPU149.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU15.37:PCI-MSI.65536-edge.ioat-msix
      1102 ± 29%     +48.6%       1638 ± 25%  interrupts.CPU15.CAL:Function_call_interrupts
      1.77 ± 23%     +13.0%       2.00        interrupts.CPU15.IWI:IRQ_work_interrupts
    606083            +0.1%     606752        interrupts.CPU15.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU15.MCP:Machine_check_polls
      7265 ± 23%     +12.9%       8204        interrupts.CPU15.NMI:Non-maskable_interrupts
      7265 ± 23%     +12.9%       8204        interrupts.CPU15.PMI:Performance_monitoring_interrupts
    316.69 ±  4%      +0.9%     319.40 ±  6%  interrupts.CPU15.RES:Rescheduling_interrupts
      2.62 ± 28%     -23.5%       2.00 ± 54%  interrupts.CPU15.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU150.105:PCI-MSI.23592999-edge.nvme0q39
      0.00          -100.0%       0.00        interrupts.CPU150.92:PCI-MSI.23592999-edge.nvme0q39
      1545 ±100%      +7.5%       1660 ± 26%  interrupts.CPU150.CAL:Function_call_interrupts
      1.77 ± 23%      -3.9%       1.70 ± 26%  interrupts.CPU150.IWI:IRQ_work_interrupts
    605948            +0.1%     606647        interrupts.CPU150.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU150.MCP:Machine_check_polls
      7551 ± 23%      -4.1%       7245 ± 26%  interrupts.CPU150.NMI:Non-maskable_interrupts
      7551 ± 23%      -4.1%       7245 ± 26%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
    378.92 ± 64%     -18.6%     308.50        interrupts.CPU150.RES:Rescheduling_interrupts
      4.85 ±164%     -62.9%       1.80 ± 64%  interrupts.CPU150.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU151.115:PCI-MSI.23593000-edge.nvme0q40
      0.00          -100.0%       0.00        interrupts.CPU151.119:PCI-MSI.23593000-edge.nvme0q40
      0.00          -100.0%       0.00        interrupts.CPU151.86:PCI-MSI.23593000-edge.nvme0q40
      1207 ± 36%     +48.9%       1798 ± 39%  interrupts.CPU151.CAL:Function_call_interrupts
      1.77 ± 23%      -3.9%       1.70 ± 26%  interrupts.CPU151.IWI:IRQ_work_interrupts
    605944            +0.1%     606667        interrupts.CPU151.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU151.MCP:Machine_check_polls
      7552 ± 23%      -4.1%       7245 ± 26%  interrupts.CPU151.NMI:Non-maskable_interrupts
      7552 ± 23%      -4.1%       7245 ± 26%  interrupts.CPU151.PMI:Performance_monitoring_interrupts
    346.00 ± 34%      +6.9%     369.90 ± 48%  interrupts.CPU151.RES:Rescheduling_interrupts
      2.31 ± 35%    +441.7%      12.50 ±257%  interrupts.CPU151.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU152.120:PCI-MSI.23593001-edge.nvme0q41
      1100 ± 29%     +46.8%       1614 ± 25%  interrupts.CPU152.CAL:Function_call_interrupts
      1.77 ± 23%      +1.7%       1.80 ± 22%  interrupts.CPU152.IWI:IRQ_work_interrupts
    605906            +0.1%     606661        interrupts.CPU152.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU152.MCP:Machine_check_polls
      7552 ± 23%      +1.6%       7672 ± 22%  interrupts.CPU152.NMI:Non-maskable_interrupts
      7552 ± 23%      +1.6%       7672 ± 22%  interrupts.CPU152.PMI:Performance_monitoring_interrupts
    377.77 ± 64%     -18.7%     307.10        interrupts.CPU152.RES:Rescheduling_interrupts
      2.54 ± 39%     -21.2%       2.00 ± 54%  interrupts.CPU152.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU153.121:PCI-MSI.23593002-edge.nvme0q42
      0.00          -100.0%       0.00        interrupts.CPU153.95:PCI-MSI.23593002-edge.nvme0q42
      1145 ± 48%     +40.8%       1612 ± 25%  interrupts.CPU153.CAL:Function_call_interrupts
      1.77 ± 23%      -3.9%       1.70 ± 26%  interrupts.CPU153.IWI:IRQ_work_interrupts
    605875            +0.1%     606631        interrupts.CPU153.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU153.MCP:Machine_check_polls
      7552 ± 23%      -4.1%       7245 ± 26%  interrupts.CPU153.NMI:Non-maskable_interrupts
      7552 ± 23%      -4.1%       7245 ± 26%  interrupts.CPU153.PMI:Performance_monitoring_interrupts
    334.77 ± 27%      -7.3%     310.20 ±  2%  interrupts.CPU153.RES:Rescheduling_interrupts
      4.85 ±162%     -56.7%       2.10 ± 49%  interrupts.CPU153.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU154.122:PCI-MSI.23593003-edge.nvme0q43
      1096 ± 29%     +51.8%       1664 ± 21%  interrupts.CPU154.CAL:Function_call_interrupts
      1.85 ± 19%      -7.9%       1.70 ± 26%  interrupts.CPU154.IWI:IRQ_work_interrupts
    605961            +0.1%     606643        interrupts.CPU154.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU154.MCP:Machine_check_polls
      7880 ± 19%      -8.1%       7245 ± 26%  interrupts.CPU154.NMI:Non-maskable_interrupts
      7880 ± 19%      -8.1%       7245 ± 26%  interrupts.CPU154.PMI:Performance_monitoring_interrupts
    306.92            +4.7%     321.20 ± 13%  interrupts.CPU154.RES:Rescheduling_interrupts
      2.46 ± 40%     -22.8%       1.90 ± 64%  interrupts.CPU154.TLB:TLB_shootdowns
      1104 ± 28%     +46.0%       1611 ± 25%  interrupts.CPU155.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU155.IWI:IRQ_work_interrupts
    605900            +0.1%     606633        interrupts.CPU155.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU155.MCP:Machine_check_polls
      7879 ± 19%      -2.7%       7671 ± 22%  interrupts.CPU155.NMI:Non-maskable_interrupts
      7879 ± 19%      -2.7%       7671 ± 22%  interrupts.CPU155.PMI:Performance_monitoring_interrupts
    306.85            +0.6%     308.60        interrupts.CPU155.RES:Rescheduling_interrupts
      2.62 ± 31%     -27.4%       1.90 ± 59%  interrupts.CPU155.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU156.105:PCI-MSI.23593005-edge.nvme0q45
      0.00          -100.0%       0.00        interrupts.CPU156.107:PCI-MSI.23593005-edge.nvme0q45
      0.00          -100.0%       0.00        interrupts.CPU156.111:PCI-MSI.23593005-edge.nvme0q45
      1096 ± 29%     +46.9%       1611 ± 25%  interrupts.CPU156.CAL:Function_call_interrupts
      1.85 ± 19%      -7.9%       1.70 ± 26%  interrupts.CPU156.IWI:IRQ_work_interrupts
    605934            +0.1%     606705        interrupts.CPU156.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU156.MCP:Machine_check_polls
      7880 ± 19%      -8.1%       7244 ± 26%  interrupts.CPU156.NMI:Non-maskable_interrupts
      7880 ± 19%      -8.1%       7244 ± 26%  interrupts.CPU156.PMI:Performance_monitoring_interrupts
    307.00            +0.6%     308.70        interrupts.CPU156.RES:Rescheduling_interrupts
      2.62 ± 35%    +117.9%       5.70 ±207%  interrupts.CPU156.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU157.89:PCI-MSI.23593006-edge.nvme0q46
      1096 ± 29%    +124.0%       2455 ±104%  interrupts.CPU157.CAL:Function_call_interrupts
      1.85 ± 19%      -7.9%       1.70 ± 26%  interrupts.CPU157.IWI:IRQ_work_interrupts
    605931            +0.1%     606643        interrupts.CPU157.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU157.MCP:Machine_check_polls
      7879 ± 19%      -8.1%       7245 ± 26%  interrupts.CPU157.NMI:Non-maskable_interrupts
      7879 ± 19%      -8.1%       7245 ± 26%  interrupts.CPU157.PMI:Performance_monitoring_interrupts
    307.38           +39.2%     428.00 ± 84%  interrupts.CPU157.RES:Rescheduling_interrupts
      2.38 ± 35%     -11.9%       2.10 ± 58%  interrupts.CPU157.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU158.100:PCI-MSI.23593007-edge.nvme0q47
      0.00          -100.0%       0.00        interrupts.CPU158.107:PCI-MSI.23593007-edge.nvme0q47
      0.00          -100.0%       0.00        interrupts.CPU158.90:PCI-MSI.23593007-edge.nvme0q47
      1091 ± 29%     +60.5%       1751 ± 35%  interrupts.CPU158.CAL:Function_call_interrupts
      1.77 ± 23%      -3.9%       1.70 ± 26%  interrupts.CPU158.IWI:IRQ_work_interrupts
    605916            +0.1%     606677        interrupts.CPU158.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU158.MCP:Machine_check_polls
      7551 ± 23%      -9.7%       6818 ± 30%  interrupts.CPU158.NMI:Non-maskable_interrupts
      7551 ± 23%      -9.7%       6818 ± 30%  interrupts.CPU158.PMI:Performance_monitoring_interrupts
    306.62           +13.7%     348.70 ± 34%  interrupts.CPU158.RES:Rescheduling_interrupts
      4.62 ±166%     -45.8%       2.50 ± 62%  interrupts.CPU158.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU159.100:PCI-MSI.23593008-edge.nvme0q48
      0.00          -100.0%       0.00        interrupts.CPU159.114:PCI-MSI.23593008-edge.nvme0q48
      0.00          -100.0%       0.00        interrupts.CPU159.127:PCI-MSI.23593008-edge.nvme0q48
      1096 ± 29%     +48.4%       1627 ± 25%  interrupts.CPU159.CAL:Function_call_interrupts
      1.85 ± 19%      -7.9%       1.70 ± 26%  interrupts.CPU159.IWI:IRQ_work_interrupts
    605915            +0.1%     606672        interrupts.CPU159.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU159.MCP:Machine_check_polls
      7879 ± 19%      -8.1%       7245 ± 26%  interrupts.CPU159.NMI:Non-maskable_interrupts
      7879 ± 19%      -8.1%       7245 ± 26%  interrupts.CPU159.PMI:Performance_monitoring_interrupts
    306.85           +29.8%     398.20 ± 68%  interrupts.CPU159.RES:Rescheduling_interrupts
      2.77 ± 49%     -31.4%       1.90 ± 59%  interrupts.CPU159.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU16.165:PCI-MSI.23593073-edge.nvme0q113
      0.00          -100.0%       0.00        interrupts.CPU16.175:PCI-MSI.23593073-edge.nvme0q113
      0.00          -100.0%       0.00        interrupts.CPU16.39:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU16.41:PCI-MSI.67584-edge.ioat-msix
      1146 ± 36%     +40.6%       1612 ± 25%  interrupts.CPU16.CAL:Function_call_interrupts
      1.69 ± 27%     +12.3%       1.90 ± 15%  interrupts.CPU16.IWI:IRQ_work_interrupts
    606066            +0.1%     606735        interrupts.CPU16.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU16.MCP:Machine_check_polls
      6949 ± 27%     +12.1%       7793 ± 15%  interrupts.CPU16.NMI:Non-maskable_interrupts
      6949 ± 27%     +12.1%       7793 ± 15%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
    323.38 ± 13%     +27.1%     411.00 ± 68%  interrupts.CPU16.RES:Rescheduling_interrupts
      2.54 ± 29%     -25.2%       1.90 ± 43%  interrupts.CPU16.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU160.132:PCI-MSI.23593017-edge.nvme0q57
      1176 ± 28%     +34.1%       1577 ± 26%  interrupts.CPU160.CAL:Function_call_interrupts
      1.85 ± 19%      -7.9%       1.70 ± 26%  interrupts.CPU160.IWI:IRQ_work_interrupts
    605897            +0.1%     606661        interrupts.CPU160.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU160.MCP:Machine_check_polls
      7879 ± 19%      -8.0%       7245 ± 26%  interrupts.CPU160.NMI:Non-maskable_interrupts
      7879 ± 19%      -8.0%       7245 ± 26%  interrupts.CPU160.PMI:Performance_monitoring_interrupts
    327.31 ± 13%      -4.7%     311.90 ±  3%  interrupts.CPU160.RES:Rescheduling_interrupts
      2.54 ± 36%     -25.2%       1.90 ± 59%  interrupts.CPU160.TLB:TLB_shootdowns
      1101 ± 29%     +46.3%       1611 ± 25%  interrupts.CPU161.CAL:Function_call_interrupts
      1.92 ± 13%     -11.6%       1.70 ± 26%  interrupts.CPU161.IWI:IRQ_work_interrupts
    605876            +0.1%     606649        interrupts.CPU161.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU161.MCP:Machine_check_polls
      8207 ± 13%     -11.7%       7244 ± 26%  interrupts.CPU161.NMI:Non-maskable_interrupts
      8207 ± 13%     -11.7%       7244 ± 26%  interrupts.CPU161.PMI:Performance_monitoring_interrupts
    307.54            +0.1%     307.80        interrupts.CPU161.RES:Rescheduling_interrupts
      2.46 ± 34%     -22.8%       1.90 ± 54%  interrupts.CPU161.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU162.105:PCI-MSI.23593019-edge.nvme0q59
      0.00          -100.0%       0.00        interrupts.CPU162.138:PCI-MSI.23593019-edge.nvme0q59
      1202 ± 36%     +27.8%       1537 ± 29%  interrupts.CPU162.CAL:Function_call_interrupts
      2.00           -10.0%       1.80 ± 22%  interrupts.CPU162.IWI:IRQ_work_interrupts
    605891            +0.1%     606674        interrupts.CPU162.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU162.MCP:Machine_check_polls
      8537           -10.1%       7671 ± 22%  interrupts.CPU162.NMI:Non-maskable_interrupts
      8537           -10.1%       7671 ± 22%  interrupts.CPU162.PMI:Performance_monitoring_interrupts
    339.46 ± 30%      -9.1%     308.50        interrupts.CPU162.RES:Rescheduling_interrupts
      2.46 ± 30%     -14.7%       2.10 ± 44%  interrupts.CPU162.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU163.106:PCI-MSI.23593020-edge.nvme0q60
      0.00          -100.0%       0.00        interrupts.CPU163.126:PCI-MSI.23593020-edge.nvme0q60
      1085 ± 31%     +48.7%       1614 ± 25%  interrupts.CPU163.CAL:Function_call_interrupts
      2.00            -5.0%       1.90 ± 15%  interrupts.CPU163.IWI:IRQ_work_interrupts
    605809            +0.1%     606644        interrupts.CPU163.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU163.MCP:Machine_check_polls
      8535            -5.1%       8096 ± 15%  interrupts.CPU163.NMI:Non-maskable_interrupts
      8535            -5.1%       8096 ± 15%  interrupts.CPU163.PMI:Performance_monitoring_interrupts
    308.15            -0.0%     308.10        interrupts.CPU163.RES:Rescheduling_interrupts
      2.46 ± 43%     -14.7%       2.10 ± 68%  interrupts.CPU163.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU164.107:PCI-MSI.23593021-edge.nvme0q61
      0.00          -100.0%       0.00        interrupts.CPU164.116:PCI-MSI.23593021-edge.nvme0q61
      1150 ± 27%     +40.4%       1614 ± 25%  interrupts.CPU164.CAL:Function_call_interrupts
      2.00           -10.0%       1.80 ± 22%  interrupts.CPU164.IWI:IRQ_work_interrupts
    605918            +0.1%     606641        interrupts.CPU164.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU164.MCP:Machine_check_polls
      8536           -10.1%       7671 ± 22%  interrupts.CPU164.NMI:Non-maskable_interrupts
      8536           -10.1%       7671 ± 22%  interrupts.CPU164.PMI:Performance_monitoring_interrupts
    319.46 ± 12%      -3.9%     307.00        interrupts.CPU164.RES:Rescheduling_interrupts
      2.38 ± 45%     -20.3%       1.90 ± 64%  interrupts.CPU164.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU165.109:PCI-MSI.23593022-edge.nvme0q62
      1099 ± 29%     +46.7%       1612 ± 25%  interrupts.CPU165.CAL:Function_call_interrupts
      2.00           -10.0%       1.80 ± 22%  interrupts.CPU165.IWI:IRQ_work_interrupts
    605884            +0.1%     606650        interrupts.CPU165.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU165.MCP:Machine_check_polls
      8536           -10.1%       7670 ± 22%  interrupts.CPU165.NMI:Non-maskable_interrupts
      8536           -10.1%       7670 ± 22%  interrupts.CPU165.PMI:Performance_monitoring_interrupts
    306.77           +10.0%     337.40 ± 26%  interrupts.CPU165.RES:Rescheduling_interrupts
      2.46 ± 40%     -26.9%       1.80 ± 64%  interrupts.CPU165.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU166.109:PCI-MSI.23593023-edge.nvme0q63
      0.00          -100.0%       0.00        interrupts.CPU166.116:PCI-MSI.23593023-edge.nvme0q63
      1196 ± 28%     +35.0%       1615 ± 25%  interrupts.CPU166.CAL:Function_call_interrupts
      2.00           -15.0%       1.70 ± 26%  interrupts.CPU166.IWI:IRQ_work_interrupts
    605842            +0.1%     606680        interrupts.CPU166.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU166.MCP:Machine_check_polls
      8535           -15.1%       7244 ± 26%  interrupts.CPU166.NMI:Non-maskable_interrupts
      8535           -15.1%       7244 ± 26%  interrupts.CPU166.PMI:Performance_monitoring_interrupts
    325.23 ± 18%      -5.0%     309.00        interrupts.CPU166.RES:Rescheduling_interrupts
      2.46 ± 37%     -18.8%       2.00 ± 50%  interrupts.CPU166.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU167.117:PCI-MSI.23593024-edge.nvme0q64
      1098 ± 29%     +54.0%       1691 ± 26%  interrupts.CPU167.CAL:Function_call_interrupts
      2.00           -20.0%       1.60 ± 30%  interrupts.CPU167.IWI:IRQ_work_interrupts
    605835            +0.1%     606642        interrupts.CPU167.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU167.MCP:Machine_check_polls
      8536           -20.1%       6818 ± 30%  interrupts.CPU167.NMI:Non-maskable_interrupts
      8536           -20.1%       6818 ± 30%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
    307.15           +38.5%     425.40 ± 70%  interrupts.CPU167.RES:Rescheduling_interrupts
      2.46 ± 40%     -22.8%       1.90 ± 59%  interrupts.CPU167.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU168.118:PCI-MSI.23593025-edge.nvme0q65
      0.00          -100.0%       0.00        interrupts.CPU168.121:PCI-MSI.23593025-edge.nvme0q65
     12795 ± 26%      -0.5%      12731 ± 26%  interrupts.CPU168.CAL:Function_call_interrupts
      1.77 ± 23%      +1.7%       1.80 ± 33%  interrupts.CPU168.IWI:IRQ_work_interrupts
    606063            +0.1%     606933        interrupts.CPU168.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU168.MCP:Machine_check_polls
      7134 ± 23%      -4.1%       6838 ± 26%  interrupts.CPU168.NMI:Non-maskable_interrupts
      7134 ± 23%      -4.1%       6838 ± 26%  interrupts.CPU168.PMI:Performance_monitoring_interrupts
    371.00 ± 34%      -5.7%     349.70 ±  8%  interrupts.CPU168.RES:Rescheduling_interrupts
      1.77 ± 39%     +47.0%       2.60 ±124%  interrupts.CPU168.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU169.113:PCI-MSI.23593026-edge.nvme0q66
      0.00          -100.0%       0.00        interrupts.CPU169.119:PCI-MSI.23593026-edge.nvme0q66
      0.00          -100.0%       0.00        interrupts.CPU169.122:PCI-MSI.23593026-edge.nvme0q66
      0.00          -100.0%       0.00        interrupts.CPU169.141:PCI-MSI.23593026-edge.nvme0q66
      3468 ± 49%     +22.3%       4241 ± 44%  interrupts.CPU169.CAL:Function_call_interrupts
      1.77 ± 23%      -3.9%       1.70 ± 26%  interrupts.CPU169.IWI:IRQ_work_interrupts
    605994            +0.1%     606869        interrupts.CPU169.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU169.MCP:Machine_check_polls
      7135 ± 23%      -4.1%       6840 ± 26%  interrupts.CPU169.NMI:Non-maskable_interrupts
      7135 ± 23%      -4.1%       6840 ± 26%  interrupts.CPU169.PMI:Performance_monitoring_interrupts
    374.77 ± 10%      +9.6%     410.60 ± 19%  interrupts.CPU169.RES:Rescheduling_interrupts
      2.15 ± 40%     -35.0%       1.40 ± 57%  interrupts.CPU169.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU17.161:PCI-MSI.23593074-edge.nvme0q114
      0.00          -100.0%       0.00        interrupts.CPU17.40:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU17.42:PCI-MSI.69632-edge.ioat-msix
      1095 ± 29%     +47.4%       1614 ± 25%  interrupts.CPU17.CAL:Function_call_interrupts
      1.69 ± 27%     +18.2%       2.00        interrupts.CPU17.IWI:IRQ_work_interrupts
    606041            +0.1%     606750        interrupts.CPU17.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU17.MCP:Machine_check_polls
      6949 ± 27%     +18.1%       8204        interrupts.CPU17.NMI:Non-maskable_interrupts
      6949 ± 27%     +18.1%       8204        interrupts.CPU17.PMI:Performance_monitoring_interrupts
    310.08            +0.6%     311.80        interrupts.CPU17.RES:Rescheduling_interrupts
      2.46 ± 30%     -14.7%       2.10 ± 44%  interrupts.CPU17.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU170.120:PCI-MSI.23593027-edge.nvme0q67
      0.00          -100.0%       0.00        interrupts.CPU170.142:PCI-MSI.23593027-edge.nvme0q67
      1869 ± 73%     +23.3%       2304 ± 27%  interrupts.CPU170.CAL:Function_call_interrupts
      1.69 ± 27%      +0.5%       1.70 ± 26%  interrupts.CPU170.IWI:IRQ_work_interrupts
    605868            +0.1%     606728        interrupts.CPU170.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU170.MCP:Machine_check_polls
      6824 ± 27%      +0.2%       6840 ± 26%  interrupts.CPU170.NMI:Non-maskable_interrupts
      6824 ± 27%      +0.2%       6840 ± 26%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
    374.31 ± 11%     +67.8%     628.00 ± 89%  interrupts.CPU170.RES:Rescheduling_interrupts
      2.31 ± 39%     -30.7%       1.60 ± 57%  interrupts.CPU170.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU171.124:PCI-MSI.23593028-edge.nvme0q68
      0.00          -100.0%       0.00        interrupts.CPU171.147:PCI-MSI.23593028-edge.nvme0q68
      1144 ± 29%     +41.4%       1618 ± 25%  interrupts.CPU171.CAL:Function_call_interrupts
      1.69 ± 27%      +0.5%       1.70 ± 26%  interrupts.CPU171.IWI:IRQ_work_interrupts
    605824            +0.1%     606701        interrupts.CPU171.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU171.MCP:Machine_check_polls
      6824 ± 27%      +0.2%       6840 ± 26%  interrupts.CPU171.NMI:Non-maskable_interrupts
      6824 ± 27%      +0.2%       6840 ± 26%  interrupts.CPU171.PMI:Performance_monitoring_interrupts
    398.54 ± 60%     -22.6%     308.40        interrupts.CPU171.RES:Rescheduling_interrupts
      2.15 ± 30%     -25.7%       1.60 ± 57%  interrupts.CPU171.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU172.112:PCI-MSI.23593029-edge.nvme0q69
      0.00          -100.0%       0.00        interrupts.CPU172.122:PCI-MSI.23593029-edge.nvme0q69
      0.00          -100.0%       0.00        interrupts.CPU172.124:PCI-MSI.23593029-edge.nvme0q69
      0.00          -100.0%       0.00        interrupts.CPU172.144:PCI-MSI.23593029-edge.nvme0q69
      1318 ± 54%     +20.2%       1585 ± 26%  interrupts.CPU172.CAL:Function_call_interrupts
      1.69 ± 27%      +0.5%       1.70 ± 26%  interrupts.CPU172.IWI:IRQ_work_interrupts
    605844            +0.1%     606708        interrupts.CPU172.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU172.MCP:Machine_check_polls
      6825 ± 27%      +0.2%       6839 ± 26%  interrupts.CPU172.NMI:Non-maskable_interrupts
      6825 ± 27%      +0.2%       6839 ± 26%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
    334.62 ± 27%      -5.5%     316.10 ±  3%  interrupts.CPU172.RES:Rescheduling_interrupts
      2.46 ± 30%     -30.9%       1.70 ± 59%  interrupts.CPU172.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU173.122:PCI-MSI.23593030-edge.nvme0q70
      0.00          -100.0%       0.00        interrupts.CPU173.145:PCI-MSI.23593030-edge.nvme0q70
      1104 ± 28%     +46.0%       1612 ± 25%  interrupts.CPU173.CAL:Function_call_interrupts
      1.69 ± 27%      +6.4%       1.80 ± 22%  interrupts.CPU173.IWI:IRQ_work_interrupts
    605832            +0.1%     606713        interrupts.CPU173.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU173.MCP:Machine_check_polls
      6824 ± 27%      +0.2%       6840 ± 26%  interrupts.CPU173.NMI:Non-maskable_interrupts
      6824 ± 27%      +0.2%       6840 ± 26%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
    314.23 ±  6%      -1.9%     308.20        interrupts.CPU173.RES:Rescheduling_interrupts
      2.23 ± 31%     -23.8%       1.70 ± 59%  interrupts.CPU173.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU174.118:PCI-MSI.23593031-edge.nvme0q71
      0.00          -100.0%       0.00        interrupts.CPU174.123:PCI-MSI.23593031-edge.nvme0q71
      0.00          -100.0%       0.00        interrupts.CPU174.124:PCI-MSI.23593031-edge.nvme0q71
      0.00          -100.0%       0.00        interrupts.CPU174.146:PCI-MSI.23593031-edge.nvme0q71
      1098 ± 29%     +48.1%       1626 ± 26%  interrupts.CPU174.CAL:Function_call_interrupts
      1.69 ± 27%     -11.4%       1.50 ± 33%  interrupts.CPU174.IWI:IRQ_work_interrupts
    605827            +0.1%     606641        interrupts.CPU174.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU174.MCP:Machine_check_polls
      6824 ± 27%     -11.6%       6034 ± 33%  interrupts.CPU174.NMI:Non-maskable_interrupts
      6824 ± 27%     -11.6%       6034 ± 33%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
    307.62            +2.6%     315.70 ±  4%  interrupts.CPU174.RES:Rescheduling_interrupts
      2.46 ± 34%     -22.8%       1.90 ± 59%  interrupts.CPU174.TLB:TLB_shootdowns
      1133 ± 28%     +42.5%       1615 ± 25%  interrupts.CPU175.CAL:Function_call_interrupts
      1.77 ± 23%      -3.9%       1.70 ± 26%  interrupts.CPU175.IWI:IRQ_work_interrupts
    605853            +0.1%     606756        interrupts.CPU175.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU175.MCP:Machine_check_polls
      7134 ± 23%      -4.1%       6840 ± 26%  interrupts.CPU175.NMI:Non-maskable_interrupts
      7134 ± 23%      -4.1%       6840 ± 26%  interrupts.CPU175.PMI:Performance_monitoring_interrupts
    318.69 ± 12%      +3.9%     331.20 ± 20%  interrupts.CPU175.RES:Rescheduling_interrupts
      2.46 ± 37%     -18.8%       2.00 ± 59%  interrupts.CPU175.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU176.125:PCI-MSI.23593033-edge.nvme0q73
      0.00          -100.0%       0.00        interrupts.CPU176.126:PCI-MSI.23593033-edge.nvme0q73
      0.00          -100.0%       0.00        interrupts.CPU176.133:PCI-MSI.23593033-edge.nvme0q73
      0.00          -100.0%       0.00        interrupts.CPU176.135:PCI-MSI.23593033-edge.nvme0q73
      0.00          -100.0%       0.00        interrupts.CPU176.148:PCI-MSI.23593033-edge.nvme0q73
      1096 ± 29%     +47.0%       1612 ± 25%  interrupts.CPU176.CAL:Function_call_interrupts
      1.92 ± 13%      -6.4%       1.80 ± 33%  interrupts.CPU176.IWI:IRQ_work_interrupts
    605843            +0.1%     606714        interrupts.CPU176.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU176.MCP:Machine_check_polls
      7755 ± 13%     -11.8%       6839 ± 26%  interrupts.CPU176.NMI:Non-maskable_interrupts
      7755 ± 13%     -11.8%       6839 ± 26%  interrupts.CPU176.PMI:Performance_monitoring_interrupts
    306.46            +0.5%     308.10        interrupts.CPU176.RES:Rescheduling_interrupts
      2.62 ± 35%     -23.5%       2.00 ± 59%  interrupts.CPU176.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU177.127:PCI-MSI.23593034-edge.nvme0q74
      0.00          -100.0%       0.00        interrupts.CPU177.130:PCI-MSI.23593034-edge.nvme0q74
      0.00          -100.0%       0.00        interrupts.CPU177.149:PCI-MSI.23593034-edge.nvme0q74
      1090 ± 30%     +60.0%       1744 ± 33%  interrupts.CPU177.CAL:Function_call_interrupts
      1.92 ± 13%     -11.6%       1.70 ± 26%  interrupts.CPU177.IWI:IRQ_work_interrupts
    605845            +0.1%     606713        interrupts.CPU177.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU177.MCP:Machine_check_polls
      7755 ± 13%     -11.8%       6839 ± 26%  interrupts.CPU177.NMI:Non-maskable_interrupts
      7755 ± 13%     -11.8%       6839 ± 26%  interrupts.CPU177.PMI:Performance_monitoring_interrupts
    307.54           +14.1%     351.00 ± 37%  interrupts.CPU177.RES:Rescheduling_interrupts
      4.77 ±153%     -58.1%       2.00 ± 59%  interrupts.CPU177.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU178.122:PCI-MSI.23593035-edge.nvme0q75
      0.00          -100.0%       0.00        interrupts.CPU178.127:PCI-MSI.23593035-edge.nvme0q75
      0.00          -100.0%       0.00        interrupts.CPU178.141:PCI-MSI.23593035-edge.nvme0q75
      1097 ± 29%     +47.2%       1614 ± 25%  interrupts.CPU178.CAL:Function_call_interrupts
      1.92 ± 13%     -16.8%       1.60 ± 30%  interrupts.CPU178.IWI:IRQ_work_interrupts
    605778            +0.2%     606694        interrupts.CPU178.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU178.MCP:Machine_check_polls
      7755 ± 13%     -17.0%       6436 ± 30%  interrupts.CPU178.NMI:Non-maskable_interrupts
      7755 ± 13%     -17.0%       6436 ± 30%  interrupts.CPU178.PMI:Performance_monitoring_interrupts
    306.85            +0.9%     309.70        interrupts.CPU178.RES:Rescheduling_interrupts
      2.77 ± 25%     -27.8%       2.00 ± 59%  interrupts.CPU178.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU179.132:PCI-MSI.23593036-edge.nvme0q76
      0.00          -100.0%       0.00        interrupts.CPU179.138:PCI-MSI.23593036-edge.nvme0q76
      0.00          -100.0%       0.00        interrupts.CPU179.142:PCI-MSI.23593036-edge.nvme0q76
      1100 ± 29%     +53.3%       1686 ± 28%  interrupts.CPU179.CAL:Function_call_interrupts
      1.77 ± 23%      -9.6%       1.60 ± 30%  interrupts.CPU179.IWI:IRQ_work_interrupts
    605857            +0.1%     606690        interrupts.CPU179.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU179.MCP:Machine_check_polls
      7133 ± 23%      -9.8%       6435 ± 30%  interrupts.CPU179.NMI:Non-maskable_interrupts
      7133 ± 23%      -9.8%       6435 ± 30%  interrupts.CPU179.PMI:Performance_monitoring_interrupts
    309.46 ±  2%      +6.9%     330.70 ± 20%  interrupts.CPU179.RES:Rescheduling_interrupts
      2.46 ± 34%     -18.8%       2.00 ± 59%  interrupts.CPU179.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU18.162:PCI-MSI.23593075-edge.nvme0q115
      0.00          -100.0%       0.00        interrupts.CPU18.164:PCI-MSI.23593075-edge.nvme0q115
      0.00          -100.0%       0.00        interrupts.CPU18.40:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU18.41:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU18.43:PCI-MSI.69632-edge.ioat-msix
      1098 ± 29%     +46.6%       1610 ± 25%  interrupts.CPU18.CAL:Function_call_interrupts
      1.77 ± 23%     +13.0%       2.00        interrupts.CPU18.IWI:IRQ_work_interrupts
    606066            +0.1%     606732        interrupts.CPU18.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU18.MCP:Machine_check_polls
      7265 ± 23%     +12.9%       8204        interrupts.CPU18.NMI:Non-maskable_interrupts
      7265 ± 23%     +12.9%       8204        interrupts.CPU18.PMI:Performance_monitoring_interrupts
    317.54 ±  8%      -1.2%     313.70        interrupts.CPU18.RES:Rescheduling_interrupts
      2.54 ± 29%     -21.2%       2.00 ± 44%  interrupts.CPU18.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU180.124:PCI-MSI.23593037-edge.nvme0q77
      1098 ± 29%     +46.8%       1612 ± 25%  interrupts.CPU180.CAL:Function_call_interrupts
      1.77 ± 23%      +1.7%       1.80 ± 22%  interrupts.CPU180.IWI:IRQ_work_interrupts
    605816            +0.1%     606709        interrupts.CPU180.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU180.MCP:Machine_check_polls
      7133 ± 23%      +1.5%       7241 ± 22%  interrupts.CPU180.NMI:Non-maskable_interrupts
      7133 ± 23%      +1.5%       7241 ± 22%  interrupts.CPU180.PMI:Performance_monitoring_interrupts
    307.15            +0.3%     308.00        interrupts.CPU180.RES:Rescheduling_interrupts
      2.54 ± 33%     -21.2%       2.00 ± 59%  interrupts.CPU180.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU181.131:PCI-MSI.23593038-edge.nvme0q78
      0.00          -100.0%       0.00        interrupts.CPU181.153:PCI-MSI.23593038-edge.nvme0q78
      1096 ± 29%     +46.9%       1610 ± 25%  interrupts.CPU181.CAL:Function_call_interrupts
      1.77 ± 23%      +1.7%       1.80 ± 22%  interrupts.CPU181.IWI:IRQ_work_interrupts
    605786            +0.1%     606684        interrupts.CPU181.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU181.MCP:Machine_check_polls
      7133 ± 23%      +1.5%       7243 ± 22%  interrupts.CPU181.NMI:Non-maskable_interrupts
      7133 ± 23%      +1.5%       7243 ± 22%  interrupts.CPU181.PMI:Performance_monitoring_interrupts
    309.31 ±  2%      -0.5%     307.80        interrupts.CPU181.RES:Rescheduling_interrupts
      2.46 ± 37%     -22.8%       1.90 ± 59%  interrupts.CPU181.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU182.154:PCI-MSI.23593039-edge.nvme0q79
      1096 ± 29%     +47.8%       1619 ± 25%  interrupts.CPU182.CAL:Function_call_interrupts
      1.69 ± 27%     +12.3%       1.90 ± 15%  interrupts.CPU182.IWI:IRQ_work_interrupts
    605844            +0.1%     606679        interrupts.CPU182.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU182.MCP:Machine_check_polls
      6823 ± 27%     +12.0%       7644 ± 15%  interrupts.CPU182.NMI:Non-maskable_interrupts
      6823 ± 27%     +12.0%       7644 ± 15%  interrupts.CPU182.PMI:Performance_monitoring_interrupts
    307.54            +2.2%     314.40 ±  4%  interrupts.CPU182.RES:Rescheduling_interrupts
      2.46 ± 40%     +13.7%       2.80 ±103%  interrupts.CPU182.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU183.136:PCI-MSI.23593040-edge.nvme0q80
      0.00          -100.0%       0.00        interrupts.CPU183.142:PCI-MSI.23593040-edge.nvme0q80
      0.00          -100.0%       0.00        interrupts.CPU183.155:PCI-MSI.23593040-edge.nvme0q80
      1278 ± 37%     +26.0%       1611 ± 25%  interrupts.CPU183.CAL:Function_call_interrupts
      1.77 ± 23%      -3.9%       1.70 ± 26%  interrupts.CPU183.IWI:IRQ_work_interrupts
    605805            +0.1%     606695        interrupts.CPU183.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU183.MCP:Machine_check_polls
      7133 ± 23%      -4.1%       6840 ± 26%  interrupts.CPU183.NMI:Non-maskable_interrupts
      7133 ± 23%      -4.1%       6840 ± 26%  interrupts.CPU183.PMI:Performance_monitoring_interrupts
    358.69 ± 36%     -14.4%     307.10        interrupts.CPU183.RES:Rescheduling_interrupts
      2.31 ± 42%     -13.3%       2.00 ± 59%  interrupts.CPU183.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU184.142:PCI-MSI.23593049-edge.nvme0q89
      0.00          -100.0%       0.00        interrupts.CPU184.145:PCI-MSI.23593049-edge.nvme0q89
      1103 ± 29%     +46.2%       1613 ± 25%  interrupts.CPU184.CAL:Function_call_interrupts
      1.85 ± 19%      -7.9%       1.70 ± 26%  interrupts.CPU184.IWI:IRQ_work_interrupts
    605803            +0.1%     606678        interrupts.CPU184.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU184.MCP:Machine_check_polls
      7444 ± 19%      -8.1%       6840 ± 26%  interrupts.CPU184.NMI:Non-maskable_interrupts
      7444 ± 19%      -8.1%       6840 ± 26%  interrupts.CPU184.PMI:Performance_monitoring_interrupts
    308.69 ±  2%      +0.5%     310.20 ±  2%  interrupts.CPU184.RES:Rescheduling_interrupts
      2.38 ± 38%     -16.1%       2.00 ± 54%  interrupts.CPU184.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU185.137:PCI-MSI.23593050-edge.nvme0q90
      0.00          -100.0%       0.00        interrupts.CPU185.165:PCI-MSI.23593050-edge.nvme0q90
      1097 ± 29%     +46.8%       1611 ± 25%  interrupts.CPU185.CAL:Function_call_interrupts
      1.77 ± 23%      -9.6%       1.60 ± 30%  interrupts.CPU185.IWI:IRQ_work_interrupts
    605804            +0.1%     606695        interrupts.CPU185.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU185.MCP:Machine_check_polls
      7132 ± 23%      -9.8%       6436 ± 30%  interrupts.CPU185.NMI:Non-maskable_interrupts
      7132 ± 23%      -9.8%       6436 ± 30%  interrupts.CPU185.PMI:Performance_monitoring_interrupts
    307.69            -0.2%     307.10        interrupts.CPU185.RES:Rescheduling_interrupts
      2.38 ± 38%     -20.3%       1.90 ± 64%  interrupts.CPU185.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU186.143:PCI-MSI.23593051-edge.nvme0q91
      1099 ± 29%     +46.9%       1614 ± 25%  interrupts.CPU186.CAL:Function_call_interrupts
      1.77 ± 23%      -9.6%       1.60 ± 30%  interrupts.CPU186.IWI:IRQ_work_interrupts
    605794            +0.1%     606695        interrupts.CPU186.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU186.MCP:Machine_check_polls
      7132 ± 23%      -9.8%       6436 ± 30%  interrupts.CPU186.NMI:Non-maskable_interrupts
      7132 ± 23%      -9.8%       6436 ± 30%  interrupts.CPU186.PMI:Performance_monitoring_interrupts
    307.54            +0.1%     307.70        interrupts.CPU186.RES:Rescheduling_interrupts
      2.54 ± 36%     -25.2%       1.90 ± 64%  interrupts.CPU186.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU187.144:PCI-MSI.23593052-edge.nvme0q92
      1098 ± 29%     +46.7%       1611 ± 25%  interrupts.CPU187.CAL:Function_call_interrupts
      1.77 ± 23%      +1.7%       1.80 ± 22%  interrupts.CPU187.IWI:IRQ_work_interrupts
    605780            +0.2%     606694        interrupts.CPU187.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU187.MCP:Machine_check_polls
      7132 ± 23%      +1.5%       7241 ± 22%  interrupts.CPU187.NMI:Non-maskable_interrupts
      7132 ± 23%      +1.5%       7241 ± 22%  interrupts.CPU187.PMI:Performance_monitoring_interrupts
    307.92            +0.3%     308.70        interrupts.CPU187.RES:Rescheduling_interrupts
      2.46 ± 34%     -22.8%       1.90 ± 64%  interrupts.CPU187.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU188.146:PCI-MSI.23593053-edge.nvme0q93
      1114 ± 30%     +44.4%       1610 ± 25%  interrupts.CPU188.CAL:Function_call_interrupts
      1.69 ± 27%      -5.5%       1.60 ± 30%  interrupts.CPU188.IWI:IRQ_work_interrupts
    605853            +0.1%     606701        interrupts.CPU188.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU188.MCP:Machine_check_polls
      6822 ± 27%      -5.7%       6436 ± 30%  interrupts.CPU188.NMI:Non-maskable_interrupts
      6822 ± 27%      -5.7%       6436 ± 30%  interrupts.CPU188.PMI:Performance_monitoring_interrupts
    378.77 ± 64%     -18.8%     307.60        interrupts.CPU188.RES:Rescheduling_interrupts
      3.08 ± 79%     -35.0%       2.00 ± 54%  interrupts.CPU188.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU189.146:PCI-MSI.23593054-edge.nvme0q94
      1144 ± 28%     +40.9%       1612 ± 25%  interrupts.CPU189.CAL:Function_call_interrupts
      1.69 ± 27%      -5.5%       1.60 ± 30%  interrupts.CPU189.IWI:IRQ_work_interrupts
    605784            +0.2%     606696        interrupts.CPU189.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU189.MCP:Machine_check_polls
      6822 ± 27%      -5.7%       6436 ± 30%  interrupts.CPU189.NMI:Non-maskable_interrupts
      6822 ± 27%      -5.7%       6436 ± 30%  interrupts.CPU189.PMI:Performance_monitoring_interrupts
    318.69 ± 11%      -1.1%     315.20 ±  6%  interrupts.CPU189.RES:Rescheduling_interrupts
      2.31 ± 35%     -17.7%       1.90 ± 64%  interrupts.CPU189.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU19.163:PCI-MSI.23593076-edge.nvme0q116
      0.00          -100.0%       0.00        interrupts.CPU19.169:PCI-MSI.23593076-edge.nvme0q116
      0.00          -100.0%       0.00        interrupts.CPU19.172:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU19.42:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU19.43:PCI-MSI.71680-edge.ioat-msix
      1095 ± 29%     +47.6%       1617 ± 24%  interrupts.CPU19.CAL:Function_call_interrupts
      1.77 ± 23%     +13.0%       2.00        interrupts.CPU19.IWI:IRQ_work_interrupts
    606075            +0.1%     606806        interrupts.CPU19.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU19.MCP:Machine_check_polls
      7264 ± 23%     +12.9%       8203        interrupts.CPU19.NMI:Non-maskable_interrupts
      7264 ± 23%     +12.9%       8203        interrupts.CPU19.PMI:Performance_monitoring_interrupts
    310.54            +2.7%     318.90 ±  4%  interrupts.CPU19.RES:Rescheduling_interrupts
      2.54 ± 29%     -21.2%       2.00 ± 50%  interrupts.CPU19.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU190.142:PCI-MSI.23593055-edge.nvme0q95
      0.00          -100.0%       0.00        interrupts.CPU190.147:PCI-MSI.23593055-edge.nvme0q95
      0.00          -100.0%       0.00        interrupts.CPU190.161:PCI-MSI.23593055-edge.nvme0q95
      1108 ± 28%     +45.4%       1610 ± 25%  interrupts.CPU190.CAL:Function_call_interrupts
      1.69 ± 27%      -5.5%       1.60 ± 30%  interrupts.CPU190.IWI:IRQ_work_interrupts
    605764            +0.2%     606689        interrupts.CPU190.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU190.MCP:Machine_check_polls
      6823 ± 27%      -5.7%       6436 ± 30%  interrupts.CPU190.NMI:Non-maskable_interrupts
      6823 ± 27%      -5.7%       6436 ± 30%  interrupts.CPU190.PMI:Performance_monitoring_interrupts
    309.85            -0.6%     308.10        interrupts.CPU190.RES:Rescheduling_interrupts
      2.46 ± 37%     -22.8%       1.90 ± 64%  interrupts.CPU190.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU191.143:PCI-MSI.23593056-edge.nvme0q96
      0.00          -100.0%       0.00        interrupts.CPU191.148:PCI-MSI.23593056-edge.nvme0q96
      0.00          -100.0%       0.00        interrupts.CPU191.149:PCI-MSI.23593056-edge.nvme0q96
      1172 ± 27%     +44.1%       1690 ± 24%  interrupts.CPU191.CAL:Function_call_interrupts
      2.08 ± 39%      +1.1%       2.10 ± 33%  interrupts.CPU191.IWI:IRQ_work_interrupts
    605885            +0.2%     606797        interrupts.CPU191.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU191.MCP:Machine_check_polls
      6515 ± 30%      -1.1%       6440 ± 30%  interrupts.CPU191.NMI:Non-maskable_interrupts
      6515 ± 30%      -1.1%       6440 ± 30%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
    344.23 ±  2%      +3.5%     356.20 ±  6%  interrupts.CPU191.RES:Rescheduling_interrupts
      4.69 ± 66%      +2.3%       4.80 ± 67%  interrupts.CPU191.TLB:TLB_shootdowns
      2331 ± 61%     +11.9%       2608 ± 39%  interrupts.CPU2.CAL:Function_call_interrupts
      1.77 ± 23%     +13.0%       2.00        interrupts.CPU2.IWI:IRQ_work_interrupts
    606041            +0.1%     606838        interrupts.CPU2.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU2.MCP:Machine_check_polls
      7263 ± 23%     +13.0%       8204        interrupts.CPU2.NMI:Non-maskable_interrupts
      7263 ± 23%     +13.0%       8204        interrupts.CPU2.PMI:Performance_monitoring_interrupts
    468.46 ± 25%      +4.1%     487.60 ± 31%  interrupts.CPU2.RES:Rescheduling_interrupts
      2.23 ± 31%     -41.7%       1.30 ± 60%  interrupts.CPU2.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU20.160:PCI-MSI.23593077-edge.nvme0q117
      0.00          -100.0%       0.00        interrupts.CPU20.166:PCI-MSI.23593077-edge.nvme0q117
      0.00          -100.0%       0.00        interrupts.CPU20.172:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU20.179:PCI-MSI.23593077-edge.nvme0q117
      0.00          -100.0%       0.00        interrupts.CPU20.42:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU20.43:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU20.43:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU20.45:PCI-MSI.75776-edge.ioat-msix
      1103 ± 28%     +46.3%       1615 ± 24%  interrupts.CPU20.CAL:Function_call_interrupts
      1.69 ± 27%     +18.2%       2.00        interrupts.CPU20.IWI:IRQ_work_interrupts
    606053            +0.1%     606769        interrupts.CPU20.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU20.MCP:Machine_check_polls
      6949 ± 27%     +18.1%       8203        interrupts.CPU20.NMI:Non-maskable_interrupts
      6949 ± 27%     +18.1%       8203        interrupts.CPU20.PMI:Performance_monitoring_interrupts
    315.23 ±  4%      +3.7%     326.80 ± 12%  interrupts.CPU20.RES:Rescheduling_interrupts
      2.46 ± 30%     -22.8%       1.90 ± 43%  interrupts.CPU20.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU21.164:PCI-MSI.23593078-edge.nvme0q118
      0.00          -100.0%       0.00        interrupts.CPU21.173:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU21.44:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU21.44:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU21.46:PCI-MSI.75776-edge.ioat-msix
      1096 ± 29%     +47.9%       1621 ± 25%  interrupts.CPU21.CAL:Function_call_interrupts
      1.85 ± 19%      +8.3%       2.00        interrupts.CPU21.IWI:IRQ_work_interrupts
    606096            +0.1%     606855        interrupts.CPU21.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU21.MCP:Machine_check_polls
      7581 ± 19%      +8.2%       8203        interrupts.CPU21.NMI:Non-maskable_interrupts
      7581 ± 19%      +8.2%       8203        interrupts.CPU21.PMI:Performance_monitoring_interrupts
    309.85            +2.0%     316.00 ±  3%  interrupts.CPU21.RES:Rescheduling_interrupts
      2.46 ± 30%     -22.8%       1.90 ± 43%  interrupts.CPU21.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU22.168:PCI-MSI.23593079-edge.nvme0q119
      0.00          -100.0%       0.00        interrupts.CPU22.171:PCI-MSI.23593079-edge.nvme0q119
      0.00          -100.0%       0.00        interrupts.CPU22.174:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU22.44:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU22.45:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU22.45:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU22.47:PCI-MSI.77824-edge.ioat-msix
      1098 ± 29%     +43.7%       1579 ± 26%  interrupts.CPU22.CAL:Function_call_interrupts
      1.92 ± 13%      +4.0%       2.00        interrupts.CPU22.IWI:IRQ_work_interrupts
    606136            +0.1%     606787        interrupts.CPU22.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU22.MCP:Machine_check_polls
      7897 ± 13%      +3.9%       8203        interrupts.CPU22.NMI:Non-maskable_interrupts
      7897 ± 13%      +3.9%       8203        interrupts.CPU22.PMI:Performance_monitoring_interrupts
    383.15 ± 65%     -14.2%     328.70 ± 15%  interrupts.CPU22.RES:Rescheduling_interrupts
      2.54 ± 29%      -5.5%       2.40 ± 42%  interrupts.CPU22.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU23.167:PCI-MSI.23593080-edge.nvme0q120
      0.00          -100.0%       0.00        interrupts.CPU23.175:PCI-MSI.23593080-edge.nvme0q120
      0.00          -100.0%       0.00        interrupts.CPU23.175:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU23.175:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU23.186:PCI-MSI.23593080-edge.nvme0q120
      0.00          -100.0%       0.00        interrupts.CPU23.45:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU23.46:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU23.46:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU23.47:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU23.50:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU23.52:PCI-MSI.23592960-edge.nvme0q0
      1067 ± 26%     +42.7%       1523 ± 28%  interrupts.CPU23.CAL:Function_call_interrupts
      1.85 ± 19%      +8.3%       2.00        interrupts.CPU23.IWI:IRQ_work_interrupts
    606071            +0.1%     606786        interrupts.CPU23.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU23.MCP:Machine_check_polls
      7580 ± 19%      +8.2%       8202        interrupts.CPU23.NMI:Non-maskable_interrupts
      7580 ± 19%      +8.2%       8202        interrupts.CPU23.PMI:Performance_monitoring_interrupts
    311.92            +0.1%     312.10        interrupts.CPU23.RES:Rescheduling_interrupts
      2.38 ± 35%      -7.7%       2.20 ± 48%  interrupts.CPU23.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU24.178:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU24.179:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU24.47:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU24.48:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU24.49:PCI-MSI.33619968-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU24.51:PCI-MSI.33619968-edge.ioat-msix
      1254 ± 23%     +43.1%       1795 ± 26%  interrupts.CPU24.CAL:Function_call_interrupts
      1.85 ± 19%      +8.3%       2.00        interrupts.CPU24.IWI:IRQ_work_interrupts
    606091            +0.1%     606783        interrupts.CPU24.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU24.MCP:Machine_check_polls
      7557 ± 19%      +8.2%       8176        interrupts.CPU24.NMI:Non-maskable_interrupts
      7557 ± 19%      +8.2%       8176        interrupts.CPU24.PMI:Performance_monitoring_interrupts
    349.08 ±  9%      -1.9%     342.60 ±  8%  interrupts.CPU24.RES:Rescheduling_interrupts
     35.08 ±324%     -94.9%       1.80 ± 54%  interrupts.CPU24.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU25.180:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU25.181:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU25.49:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU25.50:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU25.51:PCI-MSI.33622016-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU25.52:PCI-MSI.33622016-edge.ioat-msix
      2200 ± 39%     +43.2%       3150 ± 41%  interrupts.CPU25.CAL:Function_call_interrupts
      1.85 ± 19%      +8.3%       2.00        interrupts.CPU25.IWI:IRQ_work_interrupts
    606121            +0.1%     606826        interrupts.CPU25.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU25.MCP:Machine_check_polls
      7558 ± 19%      +8.2%       8177        interrupts.CPU25.NMI:Non-maskable_interrupts
      7558 ± 19%      +8.2%       8177        interrupts.CPU25.PMI:Performance_monitoring_interrupts
    386.54 ± 13%      +3.1%     398.50 ± 18%  interrupts.CPU25.RES:Rescheduling_interrupts
      1.77 ± 59%     -15.2%       1.50 ± 44%  interrupts.CPU25.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU26.181:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU26.182:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU26.50:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU26.51:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU26.52:PCI-MSI.33624064-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU26.53:PCI-MSI.33624064-edge.ioat-msix
      2124 ± 50%     +29.0%       2741 ± 31%  interrupts.CPU26.CAL:Function_call_interrupts
      1.92 ± 13%      +4.0%       2.00        interrupts.CPU26.IWI:IRQ_work_interrupts
    606101            +0.1%     606763        interrupts.CPU26.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU26.MCP:Machine_check_polls
      7873 ± 13%      +3.9%       8178        interrupts.CPU26.NMI:Non-maskable_interrupts
      7873 ± 13%      +3.9%       8178        interrupts.CPU26.PMI:Performance_monitoring_interrupts
    405.08 ± 28%     +15.7%     468.60 ± 24%  interrupts.CPU26.RES:Rescheduling_interrupts
      1.85 ± 41%      +2.9%       1.90 ± 54%  interrupts.CPU26.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU27.182:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU27.182:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU27.183:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU27.51:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU27.52:PCI-MSI.33626112-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU27.53:PCI-MSI.33626112-edge.ioat-msix
      1135 ± 28%     +49.2%       1694 ± 27%  interrupts.CPU27.CAL:Function_call_interrupts
      1.92 ± 13%      -1.2%       1.90 ± 15%  interrupts.CPU27.IWI:IRQ_work_interrupts
    606096            +0.1%     606742        interrupts.CPU27.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU27.MCP:Machine_check_polls
      7874 ± 13%      -1.3%       7769 ± 15%  interrupts.CPU27.NMI:Non-maskable_interrupts
      7874 ± 13%      -1.3%       7769 ± 15%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
    336.54 ± 23%      -4.1%     322.80 ± 11%  interrupts.CPU27.RES:Rescheduling_interrupts
      2.00 ± 43%      -5.0%       1.90 ± 54%  interrupts.CPU27.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU28.183:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU28.184:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU28.52:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU28.53:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU28.54:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU28.55:PCI-MSI.33628160-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU28.57:PCI-MSI.33626112-edge.ioat-msix
      1246 ± 40%     +60.0%       1994 ± 70%  interrupts.CPU28.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU28.IWI:IRQ_work_interrupts
    606119            +0.1%     606768        interrupts.CPU28.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU28.MCP:Machine_check_polls
      7559 ± 19%      +2.8%       7769 ± 15%  interrupts.CPU28.NMI:Non-maskable_interrupts
      7559 ± 19%      +2.8%       7769 ± 15%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
    361.62 ± 42%      +3.0%     372.60 ± 50%  interrupts.CPU28.RES:Rescheduling_interrupts
      2.15 ± 40%      -7.1%       2.00 ± 54%  interrupts.CPU28.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU29.184:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU29.185:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU29.53:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU29.54:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU29.55:PCI-MSI.33630208-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU29.56:PCI-MSI.33630208-edge.ioat-msix
      1094 ± 33%    +131.0%       2528 ± 82%  interrupts.CPU29.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU29.IWI:IRQ_work_interrupts
    606077            +0.1%     606789        interrupts.CPU29.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU29.MCP:Machine_check_polls
      7558 ± 19%      -2.6%       7360 ± 22%  interrupts.CPU29.NMI:Non-maskable_interrupts
      7558 ± 19%      -2.6%       7360 ± 22%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
    312.85 ±  2%     +53.5%     480.30 ± 75%  interrupts.CPU29.RES:Rescheduling_interrupts
      2.15 ± 35%      -7.1%       2.00 ± 54%  interrupts.CPU29.TLB:TLB_shootdowns
      1195 ± 43%     +56.6%       1872 ± 34%  interrupts.CPU3.CAL:Function_call_interrupts
      1.77 ± 23%      +7.4%       1.90 ± 15%  interrupts.CPU3.IWI:IRQ_work_interrupts
    606016            +0.1%     606725        interrupts.CPU3.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU3.MCP:Machine_check_polls
      7265 ± 23%      +7.3%       7796 ± 15%  interrupts.CPU3.NMI:Non-maskable_interrupts
      7265 ± 23%      +7.3%       7796 ± 15%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    347.54 ± 11%     +17.8%     409.40 ± 39%  interrupts.CPU3.RES:Rescheduling_interrupts
      2.31 ± 31%     -22.0%       1.80 ± 54%  interrupts.CPU3.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU30.184:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.185:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.186:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.54:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.55:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.56:PCI-MSI.33632256-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.57:PCI-MSI.33632256-edge.ioat-msix
      1203 ± 29%     +34.0%       1612 ± 25%  interrupts.CPU30.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU30.IWI:IRQ_work_interrupts
    606064            +0.1%     606770        interrupts.CPU30.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU30.MCP:Machine_check_polls
      7558 ± 19%      -2.6%       7360 ± 22%  interrupts.CPU30.NMI:Non-maskable_interrupts
      7558 ± 19%      -2.6%       7360 ± 22%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
    346.00 ± 25%     -10.7%     309.00        interrupts.CPU30.RES:Rescheduling_interrupts
      2.23 ± 35%     -14.8%       1.90 ± 43%  interrupts.CPU30.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU31.185:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.186:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.187:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.55:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.56:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.57:PCI-MSI.33634304-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.58:PCI-MSI.33634304-edge.ioat-msix
      1204 ± 37%     +36.9%       1649 ± 26%  interrupts.CPU31.CAL:Function_call_interrupts
      1.85 ± 28%      -2.5%       1.80 ± 22%  interrupts.CPU31.IWI:IRQ_work_interrupts
    606091            +0.1%     606766        interrupts.CPU31.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU31.MCP:Machine_check_polls
      7242 ± 23%      +1.6%       7360 ± 22%  interrupts.CPU31.NMI:Non-maskable_interrupts
      7242 ± 23%      +1.6%       7360 ± 22%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
    410.38 ± 62%     -15.1%     348.50 ± 26%  interrupts.CPU31.RES:Rescheduling_interrupts
      2.31 ± 35%     -17.7%       1.90 ± 54%  interrupts.CPU31.TLB:TLB_shootdowns
      1124 ± 29%     +43.4%       1612 ± 25%  interrupts.CPU32.CAL:Function_call_interrupts
      1.77 ± 23%      +1.7%       1.80 ± 22%  interrupts.CPU32.IWI:IRQ_work_interrupts
    606111            +0.1%     606773        interrupts.CPU32.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU32.MCP:Machine_check_polls
      7243 ± 23%      +1.6%       7360 ± 22%  interrupts.CPU32.NMI:Non-maskable_interrupts
      7243 ± 23%      +1.6%       7360 ± 22%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
    310.46            -0.5%     308.90        interrupts.CPU32.RES:Rescheduling_interrupts
      3.23 ± 67%     -31.9%       2.20 ± 48%  interrupts.CPU32.TLB:TLB_shootdowns
      1102 ± 29%     +63.2%       1798 ± 49%  interrupts.CPU33.CAL:Function_call_interrupts
      1.77 ± 23%      +1.7%       1.80 ± 22%  interrupts.CPU33.IWI:IRQ_work_interrupts
    606136            +0.1%     606802        interrupts.CPU33.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU33.MCP:Machine_check_polls
      7242 ± 23%      +1.6%       7360 ± 22%  interrupts.CPU33.NMI:Non-maskable_interrupts
      7242 ± 23%      +1.6%       7360 ± 22%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
    310.46 ±  2%     +14.0%     353.90 ± 38%  interrupts.CPU33.RES:Rescheduling_interrupts
      2.08 ± 35%    +169.6%       5.60 ±199%  interrupts.CPU33.TLB:TLB_shootdowns
      1116 ± 28%     +45.8%       1627 ± 25%  interrupts.CPU34.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU34.IWI:IRQ_work_interrupts
    606086            +0.1%     606757        interrupts.CPU34.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU34.MCP:Machine_check_polls
      7558 ± 19%      +2.8%       7769 ± 15%  interrupts.CPU34.NMI:Non-maskable_interrupts
      7558 ± 19%      +2.8%       7769 ± 15%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    319.15 ±  7%      -2.6%     310.70        interrupts.CPU34.RES:Rescheduling_interrupts
      2.31 ± 39%     -13.3%       2.00 ± 44%  interrupts.CPU34.TLB:TLB_shootdowns
      1116 ± 28%     +44.2%       1610 ± 25%  interrupts.CPU35.CAL:Function_call_interrupts
      1.69 ± 27%     +12.3%       1.90 ± 15%  interrupts.CPU35.IWI:IRQ_work_interrupts
    606054            +0.1%     606766        interrupts.CPU35.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU35.MCP:Machine_check_polls
      6927 ± 27%     +12.1%       7768 ± 15%  interrupts.CPU35.NMI:Non-maskable_interrupts
      6927 ± 27%     +12.1%       7768 ± 15%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
    310.15            +0.8%     312.50 ±  3%  interrupts.CPU35.RES:Rescheduling_interrupts
      2.15 ± 35%      -7.1%       2.00 ± 44%  interrupts.CPU35.TLB:TLB_shootdowns
      1134 ± 27%     +42.2%       1613 ± 25%  interrupts.CPU36.CAL:Function_call_interrupts
      1.92 ± 13%      -6.4%       1.80 ± 22%  interrupts.CPU36.IWI:IRQ_work_interrupts
    606129            +0.1%     606758        interrupts.CPU36.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU36.MCP:Machine_check_polls
      7873 ± 13%      -6.5%       7359 ± 22%  interrupts.CPU36.NMI:Non-maskable_interrupts
      7873 ± 13%      -6.5%       7359 ± 22%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
    388.23 ± 62%     -20.5%     308.50        interrupts.CPU36.RES:Rescheduling_interrupts
      2.62 ± 66%     -23.5%       2.00 ± 54%  interrupts.CPU36.TLB:TLB_shootdowns
      1097 ± 29%     +47.0%       1612 ± 25%  interrupts.CPU37.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU37.IWI:IRQ_work_interrupts
    606063            +0.1%     606759        interrupts.CPU37.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU37.MCP:Machine_check_polls
      7559 ± 19%      -2.6%       7359 ± 22%  interrupts.CPU37.NMI:Non-maskable_interrupts
      7559 ± 19%      -2.6%       7359 ± 22%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
    312.38 ±  2%      -0.9%     309.50        interrupts.CPU37.RES:Rescheduling_interrupts
      2.23 ± 35%     -14.8%       1.90 ± 54%  interrupts.CPU37.TLB:TLB_shootdowns
      1139 ± 28%     +39.3%       1587 ± 28%  interrupts.CPU38.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU38.IWI:IRQ_work_interrupts
    606115            +0.1%     606798        interrupts.CPU38.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU38.MCP:Machine_check_polls
      7558 ± 19%      -2.6%       7360 ± 22%  interrupts.CPU38.NMI:Non-maskable_interrupts
      7558 ± 19%      -2.6%       7360 ± 22%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    322.85 ± 13%      -1.8%     317.10 ±  6%  interrupts.CPU38.RES:Rescheduling_interrupts
      2.31 ± 35%     -17.7%       1.90 ± 43%  interrupts.CPU38.TLB:TLB_shootdowns
      1089 ± 31%     +41.0%       1535 ± 29%  interrupts.CPU39.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU39.IWI:IRQ_work_interrupts
    606117            +0.1%     606771        interrupts.CPU39.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU39.MCP:Machine_check_polls
      7558 ± 19%      -2.6%       7360 ± 22%  interrupts.CPU39.NMI:Non-maskable_interrupts
      7558 ± 19%      -2.6%       7360 ± 22%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
    309.46            -0.2%     308.80        interrupts.CPU39.RES:Rescheduling_interrupts
      2.62 ± 57%      -8.2%       2.40 ± 87%  interrupts.CPU39.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU4.27:PCI-MSI.17825792-edge.PCIe.PME,pciehp
      1220 ± 34%     +34.4%       1640 ± 23%  interrupts.CPU4.CAL:Function_call_interrupts
      1.69 ± 27%     +18.2%       2.00        interrupts.CPU4.IWI:IRQ_work_interrupts
    606081            +0.1%     606760        interrupts.CPU4.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU4.MCP:Machine_check_polls
      6949 ± 27%     +18.1%       8205        interrupts.CPU4.NMI:Non-maskable_interrupts
      6949 ± 27%     +18.1%       8205        interrupts.CPU4.PMI:Performance_monitoring_interrupts
    348.54 ± 36%     -10.4%     312.40        interrupts.CPU4.RES:Rescheduling_interrupts
      3.00 ± 62%     -33.3%       2.00 ± 44%  interrupts.CPU4.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU40.70:PCI-MSI.23592977-edge.nvme0q17
      0.00          -100.0%       0.00        interrupts.CPU40.75:PCI-MSI.23592977-edge.nvme0q17
      1476 ± 85%     +18.9%       1755 ± 35%  interrupts.CPU40.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU40.IWI:IRQ_work_interrupts
    606084            +0.1%     606758        interrupts.CPU40.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU40.MCP:Machine_check_polls
      7559 ± 19%      -2.6%       7360 ± 22%  interrupts.CPU40.NMI:Non-maskable_interrupts
      7559 ± 19%      -2.6%       7360 ± 22%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    380.15 ± 58%     -14.4%     325.30 ± 15%  interrupts.CPU40.RES:Rescheduling_interrupts
      2.23 ± 39%     -14.8%       1.90 ± 43%  interrupts.CPU40.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU41.97:PCI-MSI.23592978-edge.nvme0q18
      1106 ± 28%     +45.8%       1612 ± 25%  interrupts.CPU41.CAL:Function_call_interrupts
      1.92 ± 13%      -6.4%       1.80 ± 22%  interrupts.CPU41.IWI:IRQ_work_interrupts
    606108            +0.1%     606749        interrupts.CPU41.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU41.MCP:Machine_check_polls
      7873 ± 13%      -6.5%       7360 ± 22%  interrupts.CPU41.NMI:Non-maskable_interrupts
      7873 ± 13%      -6.5%       7360 ± 22%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    309.00            +0.3%     309.90        interrupts.CPU41.RES:Rescheduling_interrupts
      2.38 ± 38%     -20.3%       1.90 ± 54%  interrupts.CPU41.TLB:TLB_shootdowns
      1106 ± 28%     +45.6%       1611 ± 25%  interrupts.CPU42.CAL:Function_call_interrupts
      1.92 ± 13%     -11.6%       1.70 ± 26%  interrupts.CPU42.IWI:IRQ_work_interrupts
    606098            +0.1%     606747        interrupts.CPU42.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU42.MCP:Machine_check_polls
      7873 ± 13%     -11.7%       6950 ± 26%  interrupts.CPU42.NMI:Non-maskable_interrupts
      7873 ± 13%     -11.7%       6950 ± 26%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
    313.46 ±  3%      -1.6%     308.50        interrupts.CPU42.RES:Rescheduling_interrupts
      2.38 ± 35%     -20.3%       1.90 ± 54%  interrupts.CPU42.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU43.69:PCI-MSI.23592980-edge.nvme0q20
      1097 ± 29%     +50.5%       1652 ± 30%  interrupts.CPU43.CAL:Function_call_interrupts
      2.00           -10.0%       1.80 ± 22%  interrupts.CPU43.IWI:IRQ_work_interrupts
    606099            +0.1%     606745        interrupts.CPU43.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU43.MCP:Machine_check_polls
      8188           -10.1%       7359 ± 22%  interrupts.CPU43.NMI:Non-maskable_interrupts
      8188           -10.1%       7359 ± 22%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
    308.85            +4.7%     323.50 ± 13%  interrupts.CPU43.RES:Rescheduling_interrupts
      2.46 ± 34%     -22.8%       1.90 ± 54%  interrupts.CPU43.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU44.64:PCI-MSI.23592981-edge.nvme0q21
      0.00          -100.0%       0.00        interrupts.CPU44.79:PCI-MSI.23592981-edge.nvme0q21
      1107 ± 28%     +45.4%       1611 ± 25%  interrupts.CPU44.CAL:Function_call_interrupts
      2.00            -5.0%       1.90 ± 15%  interrupts.CPU44.IWI:IRQ_work_interrupts
    606165            +0.1%     606779        interrupts.CPU44.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU44.MCP:Machine_check_polls
      8188            -5.1%       7768 ± 15%  interrupts.CPU44.NMI:Non-maskable_interrupts
      8188            -5.1%       7768 ± 15%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
    308.54            -0.0%     308.50        interrupts.CPU44.RES:Rescheduling_interrupts
      2.23 ± 35%      -5.9%       2.10 ± 44%  interrupts.CPU44.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU45.71:PCI-MSI.23592982-edge.nvme0q22
      0.00          -100.0%       0.00        interrupts.CPU45.80:PCI-MSI.23592982-edge.nvme0q22
      0.00          -100.0%       0.00        interrupts.CPU45.97:PCI-MSI.23592982-edge.nvme0q22
      1100 ± 29%     +84.5%       2029 ± 76%  interrupts.CPU45.CAL:Function_call_interrupts
      2.00            -5.0%       1.90 ± 15%  interrupts.CPU45.IWI:IRQ_work_interrupts
    606128            +0.1%     606730        interrupts.CPU45.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU45.MCP:Machine_check_polls
      8188            -5.1%       7769 ± 15%  interrupts.CPU45.NMI:Non-maskable_interrupts
      8188            -5.1%       7769 ± 15%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
    315.62 ±  7%     +18.8%     375.10 ± 51%  interrupts.CPU45.RES:Rescheduling_interrupts
      2.23 ± 39%     +25.5%       2.80 ±102%  interrupts.CPU45.TLB:TLB_shootdowns
      1148 ± 28%     +40.5%       1613 ± 25%  interrupts.CPU46.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU46.IWI:IRQ_work_interrupts
    606125            +0.1%     606757        interrupts.CPU46.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU46.MCP:Machine_check_polls
      7558 ± 19%      +2.8%       7769 ± 15%  interrupts.CPU46.NMI:Non-maskable_interrupts
      7558 ± 19%      +2.8%       7769 ± 15%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
    459.92 ± 77%     -32.9%     308.70        interrupts.CPU46.RES:Rescheduling_interrupts
      2.23 ± 35%     -10.3%       2.00 ± 44%  interrupts.CPU46.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU47.71:PCI-MSI.23592984-edge.nvme0q24
      0.00          -100.0%       0.00        interrupts.CPU47.80:PCI-MSI.23592984-edge.nvme0q24
      1078 ± 32%     +64.7%       1775 ± 21%  interrupts.CPU47.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU47.IWI:IRQ_work_interrupts
    606073            +0.1%     606823        interrupts.CPU47.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU47.MCP:Machine_check_polls
      7558 ± 19%      +2.8%       7769 ± 15%  interrupts.CPU47.NMI:Non-maskable_interrupts
      7558 ± 19%      +2.8%       7769 ± 15%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
    309.00           +17.9%     364.30 ± 34%  interrupts.CPU47.RES:Rescheduling_interrupts
      2.62 ± 60%     -27.4%       1.90 ± 54%  interrupts.CPU47.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU48.188:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU48.189:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU48.58:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU48.59:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU48.60:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU48.64:PCI-MSI.67174400-edge.ioat-msix
      1241 ± 28%     +69.8%       2108 ± 33%  interrupts.CPU48.CAL:Function_call_interrupts
      1.85 ± 19%      +8.3%       2.00        interrupts.CPU48.IWI:IRQ_work_interrupts
    605901            +0.1%     606677        interrupts.CPU48.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU48.MCP:Machine_check_polls
      7877 ± 19%      +8.2%       8525        interrupts.CPU48.NMI:Non-maskable_interrupts
      7877 ± 19%      +8.2%       8525        interrupts.CPU48.PMI:Performance_monitoring_interrupts
    328.46 ±  6%      +6.3%     349.00 ± 14%  interrupts.CPU48.RES:Rescheduling_interrupts
      2.00 ± 58%      -5.0%       1.90 ± 64%  interrupts.CPU48.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU49.190:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU49.191:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU49.60:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU49.61:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU49.62:PCI-MSI.67176448-edge.ioat-msix
      2398 ± 49%      +0.2%       2403 ± 34%  interrupts.CPU49.CAL:Function_call_interrupts
      1.85 ± 19%      +8.3%       2.00        interrupts.CPU49.IWI:IRQ_work_interrupts
    605984            +0.1%     606714        interrupts.CPU49.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU49.MCP:Machine_check_polls
      7878 ± 19%      +8.2%       8526        interrupts.CPU49.NMI:Non-maskable_interrupts
      7878 ± 19%      +8.2%       8526        interrupts.CPU49.PMI:Performance_monitoring_interrupts
    366.15 ± 17%      +2.3%     374.40 ± 15%  interrupts.CPU49.RES:Rescheduling_interrupts
      2.00 ± 43%     -15.0%       1.70 ± 52%  interrupts.CPU49.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU5.29:PCI-MSI.23068672-edge.PCIe.PME,pciehp
      1289 ± 48%     +25.9%       1623 ± 25%  interrupts.CPU5.CAL:Function_call_interrupts
      1.77 ± 23%      +7.4%       1.90 ± 15%  interrupts.CPU5.IWI:IRQ_work_interrupts
    606098            +0.1%     606772        interrupts.CPU5.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU5.MCP:Machine_check_polls
      7264 ± 23%      +7.3%       7794 ± 15%  interrupts.CPU5.NMI:Non-maskable_interrupts
      7264 ± 23%      +7.3%       7794 ± 15%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
    348.31 ± 30%      -9.5%     315.30        interrupts.CPU5.RES:Rescheduling_interrupts
      4.77 ±171%     -58.1%       2.00 ± 44%  interrupts.CPU5.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU50.191:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU50.192:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU50.61:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU50.62:PCI-MSI.67178496-edge.ioat-msix
      1913 ± 81%     +20.8%       2311 ± 28%  interrupts.CPU50.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU50.IWI:IRQ_work_interrupts
    605935            +0.1%     606669        interrupts.CPU50.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU50.MCP:Machine_check_polls
      7878 ± 19%      +2.8%       8100 ± 15%  interrupts.CPU50.NMI:Non-maskable_interrupts
      7878 ± 19%      +2.8%       8100 ± 15%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
    367.77 ± 20%     +15.5%     424.60 ± 24%  interrupts.CPU50.RES:Rescheduling_interrupts
      2.15 ± 47%      -2.5%       2.10 ± 44%  interrupts.CPU50.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU51.192:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU51.193:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU51.62:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU51.63:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU51.65:PCI-MSI.67180544-edge.ioat-msix
      1116 ± 29%     +46.6%       1637 ± 24%  interrupts.CPU51.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU51.IWI:IRQ_work_interrupts
    605918            +0.1%     606666        interrupts.CPU51.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU51.MCP:Machine_check_polls
      7878 ± 19%      +2.8%       8100 ± 15%  interrupts.CPU51.NMI:Non-maskable_interrupts
      7878 ± 19%      +2.8%       8100 ± 15%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
    311.85            +0.3%     312.90 ±  2%  interrupts.CPU51.RES:Rescheduling_interrupts
      2.46 ± 56%     -18.8%       2.00 ± 44%  interrupts.CPU51.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU52.193:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU52.194:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU52.63:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU52.64:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU52.66:PCI-MSI.67182592-edge.ioat-msix
      1690 ±109%      -4.3%       1618 ± 25%  interrupts.CPU52.CAL:Function_call_interrupts
      1.77 ± 23%      +7.4%       1.90 ± 15%  interrupts.CPU52.IWI:IRQ_work_interrupts
    605937            +0.1%     606679        interrupts.CPU52.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU52.MCP:Machine_check_polls
      7552 ± 23%      +7.3%       8100 ± 15%  interrupts.CPU52.NMI:Non-maskable_interrupts
      7552 ± 23%      +7.3%       8100 ± 15%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
    409.77 ± 64%     -23.8%     312.10 ±  2%  interrupts.CPU52.RES:Rescheduling_interrupts
      2.08 ± 48%      -3.7%       2.00 ± 44%  interrupts.CPU52.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU53.193:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU53.194:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU53.195:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU53.64:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU53.65:PCI-MSI.67184640-edge.ioat-msix
      1196 ± 28%     +35.5%       1620 ± 25%  interrupts.CPU53.CAL:Function_call_interrupts
      1.77 ± 23%      +1.7%       1.80 ± 22%  interrupts.CPU53.IWI:IRQ_work_interrupts
    605968            +0.1%     606675        interrupts.CPU53.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU53.MCP:Machine_check_polls
      7551 ± 23%      +1.6%       7673 ± 22%  interrupts.CPU53.NMI:Non-maskable_interrupts
      7551 ± 23%      +1.6%       7673 ± 22%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
    328.85 ± 19%      -5.7%     310.20        interrupts.CPU53.RES:Rescheduling_interrupts
      3.23 ±109%     -38.1%       2.00 ± 44%  interrupts.CPU53.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU54.195:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU54.196:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU54.65:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU54.66:PCI-MSI.67186688-edge.ioat-msix
      1178 ± 32%     +37.8%       1623 ± 24%  interrupts.CPU54.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU54.IWI:IRQ_work_interrupts
    605991            +0.1%     606674        interrupts.CPU54.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU54.MCP:Machine_check_polls
      7879 ± 19%      -2.6%       7672 ± 22%  interrupts.CPU54.NMI:Non-maskable_interrupts
      7879 ± 19%      -2.6%       7672 ± 22%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
    317.31 ± 10%      -0.7%     315.20 ±  6%  interrupts.CPU54.RES:Rescheduling_interrupts
      2.38 ± 45%     -11.9%       2.10 ± 44%  interrupts.CPU54.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU55.196:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU55.197:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU55.67:PCI-MSI.67188736-edge.ioat-msix
      1096 ± 29%     +52.2%       1669 ± 26%  interrupts.CPU55.CAL:Function_call_interrupts
      1.92 ± 13%      -6.4%       1.80 ± 22%  interrupts.CPU55.IWI:IRQ_work_interrupts
    605969            +0.1%     606634        interrupts.CPU55.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU55.MCP:Machine_check_polls
      8208 ± 13%      -6.5%       7673 ± 22%  interrupts.CPU55.NMI:Non-maskable_interrupts
      8208 ± 13%      -6.5%       7673 ± 22%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
    307.92            +5.9%     326.20 ± 15%  interrupts.CPU55.RES:Rescheduling_interrupts
      2.23 ± 47%     +16.6%       2.60 ± 88%  interrupts.CPU55.TLB:TLB_shootdowns
      1096 ± 29%     +47.9%       1621 ± 24%  interrupts.CPU56.CAL:Function_call_interrupts
      1.92 ± 13%      -6.4%       1.80 ± 22%  interrupts.CPU56.IWI:IRQ_work_interrupts
    605951            +0.1%     606682        interrupts.CPU56.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU56.MCP:Machine_check_polls
      8208 ± 13%      -6.5%       7673 ± 22%  interrupts.CPU56.NMI:Non-maskable_interrupts
      8208 ± 13%      -6.5%       7673 ± 22%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
    307.77            +1.8%     313.40 ±  4%  interrupts.CPU56.RES:Rescheduling_interrupts
      2.46 ± 40%     -18.8%       2.00 ± 44%  interrupts.CPU56.TLB:TLB_shootdowns
      1193 ± 35%     +36.0%       1624 ± 25%  interrupts.CPU57.CAL:Function_call_interrupts
      1.92 ± 13%      -6.4%       1.80 ± 22%  interrupts.CPU57.IWI:IRQ_work_interrupts
    605901            +0.1%     606649        interrupts.CPU57.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU57.MCP:Machine_check_polls
      8208 ± 13%      -6.5%       7673 ± 22%  interrupts.CPU57.NMI:Non-maskable_interrupts
      8208 ± 13%      -6.5%       7673 ± 22%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
    343.15 ± 34%     -10.0%     308.80        interrupts.CPU57.RES:Rescheduling_interrupts
      2.46 ± 34%     -22.8%       1.90 ± 54%  interrupts.CPU57.TLB:TLB_shootdowns
      1101 ± 29%     +46.3%       1612 ± 25%  interrupts.CPU58.CAL:Function_call_interrupts
      1.92 ± 13%      -6.4%       1.80 ± 22%  interrupts.CPU58.IWI:IRQ_work_interrupts
    605987            +0.1%     606668        interrupts.CPU58.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU58.MCP:Machine_check_polls
      8208 ± 13%      -6.5%       7672 ± 22%  interrupts.CPU58.NMI:Non-maskable_interrupts
      8208 ± 13%      -6.5%       7672 ± 22%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
    308.31            +0.9%     311.10        interrupts.CPU58.RES:Rescheduling_interrupts
      2.31 ± 39%     -13.3%       2.00 ± 44%  interrupts.CPU58.TLB:TLB_shootdowns
      1097 ± 29%     +47.7%       1621 ± 24%  interrupts.CPU59.CAL:Function_call_interrupts
      1.92 ± 13%      -1.2%       1.90 ± 15%  interrupts.CPU59.IWI:IRQ_work_interrupts
    605923            +0.1%     606658        interrupts.CPU59.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU59.MCP:Machine_check_polls
      8208 ± 13%      -1.3%       8099 ± 15%  interrupts.CPU59.NMI:Non-maskable_interrupts
      8208 ± 13%      -1.3%       8099 ± 15%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
    330.85 ± 24%      -6.6%     309.00        interrupts.CPU59.RES:Rescheduling_interrupts
      2.23 ± 43%      -5.9%       2.10 ± 44%  interrupts.CPU59.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU6.35:PCI-MSI.327680-edge.xhci_hcd
      1482 ± 81%      +3.6%       1535 ± 27%  interrupts.CPU6.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU6.IWI:IRQ_work_interrupts
    606033            +0.1%     606763        interrupts.CPU6.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU6.MCP:Machine_check_polls
      7580 ± 19%      +2.8%       7794 ± 15%  interrupts.CPU6.NMI:Non-maskable_interrupts
      7580 ± 19%      +2.8%       7794 ± 15%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
    369.38 ± 53%     -12.8%     322.10 ±  7%  interrupts.CPU6.RES:Rescheduling_interrupts
      2.46 ± 30%     -22.8%       1.90 ± 43%  interrupts.CPU6.TLB:TLB_shootdowns
      1098 ± 29%     +45.9%       1602 ± 30%  interrupts.CPU60.CAL:Function_call_interrupts
      1.92 ± 13%      +4.0%       2.00        interrupts.CPU60.IWI:IRQ_work_interrupts
    605951            +0.1%     606694        interrupts.CPU60.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU60.MCP:Machine_check_polls
      8208 ± 13%      +3.9%       8526        interrupts.CPU60.NMI:Non-maskable_interrupts
      8208 ± 13%      +3.9%       8526        interrupts.CPU60.PMI:Performance_monitoring_interrupts
    308.62            +3.6%     319.80 ±  7%  interrupts.CPU60.RES:Rescheduling_interrupts
      2.46 ± 37%      +1.6%       2.50 ± 44%  interrupts.CPU60.TLB:TLB_shootdowns
      1066 ± 33%     +76.3%       1881 ± 48%  interrupts.CPU61.CAL:Function_call_interrupts
      2.00           -10.0%       1.80 ± 22%  interrupts.CPU61.IWI:IRQ_work_interrupts
    605954            +0.1%     606661        interrupts.CPU61.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU61.MCP:Machine_check_polls
      8536           -10.1%       7674 ± 22%  interrupts.CPU61.NMI:Non-maskable_interrupts
      8536           -10.1%       7674 ± 22%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
    308.31           +15.7%     356.60 ± 40%  interrupts.CPU61.RES:Rescheduling_interrupts
      3.23 ±103%     -38.1%       2.00 ± 44%  interrupts.CPU61.TLB:TLB_shootdowns
      1102 ± 28%     +50.5%       1659 ± 21%  interrupts.CPU62.CAL:Function_call_interrupts
      2.00           -10.0%       1.80 ± 22%  interrupts.CPU62.IWI:IRQ_work_interrupts
    605953            +0.1%     606656        interrupts.CPU62.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU62.MCP:Machine_check_polls
      8536           -10.1%       7673 ± 22%  interrupts.CPU62.NMI:Non-maskable_interrupts
      8536           -10.1%       7673 ± 22%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
    307.38            +5.0%     322.90 ± 13%  interrupts.CPU62.RES:Rescheduling_interrupts
      2.38 ± 38%      -7.7%       2.20 ± 48%  interrupts.CPU62.TLB:TLB_shootdowns
      1105 ± 28%     +46.1%       1615 ± 25%  interrupts.CPU63.CAL:Function_call_interrupts
      2.00           -10.0%       1.80 ± 22%  interrupts.CPU63.IWI:IRQ_work_interrupts
    605930            +0.1%     606653        interrupts.CPU63.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU63.MCP:Machine_check_polls
      8536           -10.1%       7673 ± 22%  interrupts.CPU63.NMI:Non-maskable_interrupts
      8536           -10.1%       7673 ± 22%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
    311.38 ±  4%     +28.3%     399.40 ± 68%  interrupts.CPU63.RES:Rescheduling_interrupts
      2.46 ± 46%     -10.6%       2.20 ± 34%  interrupts.CPU63.TLB:TLB_shootdowns
      1097 ± 29%     +54.3%       1692 ± 29%  interrupts.CPU64.CAL:Function_call_interrupts
      2.00           -10.0%       1.80 ± 22%  interrupts.CPU64.IWI:IRQ_work_interrupts
    605956            +0.1%     606657        interrupts.CPU64.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU64.MCP:Machine_check_polls
      8536           -10.1%       7673 ± 22%  interrupts.CPU64.NMI:Non-maskable_interrupts
      8536           -10.1%       7673 ± 22%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
    307.92            +6.7%     328.40 ± 18%  interrupts.CPU64.RES:Rescheduling_interrupts
      2.38 ± 42%     -11.9%       2.10 ± 39%  interrupts.CPU64.TLB:TLB_shootdowns
      1130 ± 28%    +141.9%       2735 ±119%  interrupts.CPU65.CAL:Function_call_interrupts
      2.00           -15.0%       1.70 ± 26%  interrupts.CPU65.IWI:IRQ_work_interrupts
    605895            +0.1%     606657        interrupts.CPU65.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU65.MCP:Machine_check_polls
      8535           -15.1%       7245 ± 26%  interrupts.CPU65.NMI:Non-maskable_interrupts
      8535           -15.1%       7245 ± 26%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
    317.31 ± 10%     +52.7%     484.40 ±100%  interrupts.CPU65.RES:Rescheduling_interrupts
      2.38 ± 48%      -7.7%       2.20 ± 39%  interrupts.CPU65.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU66.106:PCI-MSI.23593011-edge.nvme0q51
      1095 ± 29%     +48.6%       1627 ± 25%  interrupts.CPU66.CAL:Function_call_interrupts
      2.00           -15.0%       1.70 ± 26%  interrupts.CPU66.IWI:IRQ_work_interrupts
    605935            +0.1%     606665        interrupts.CPU66.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU66.MCP:Machine_check_polls
      8537           -15.1%       7245 ± 26%  interrupts.CPU66.NMI:Non-maskable_interrupts
      8537           -15.1%       7245 ± 26%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
    308.23            +9.9%     338.80 ± 26%  interrupts.CPU66.RES:Rescheduling_interrupts
      2.31 ± 35%      +8.3%       2.50 ± 80%  interrupts.CPU66.TLB:TLB_shootdowns
      1099 ± 29%     +46.7%       1612 ± 25%  interrupts.CPU67.CAL:Function_call_interrupts
      1.85 ± 19%     -13.3%       1.60 ± 30%  interrupts.CPU67.IWI:IRQ_work_interrupts
    605870            +0.1%     606691        interrupts.CPU67.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU67.MCP:Machine_check_polls
      7879 ± 19%     -13.5%       6818 ± 30%  interrupts.CPU67.NMI:Non-maskable_interrupts
      7879 ± 19%     -13.5%       6818 ± 30%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
    313.38 ±  5%      -1.3%     309.40        interrupts.CPU67.RES:Rescheduling_interrupts
      2.38 ± 42%     -16.1%       2.00 ± 44%  interrupts.CPU67.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU68.113:PCI-MSI.23593013-edge.nvme0q53
      1103 ± 29%     +46.0%       1612 ± 25%  interrupts.CPU68.CAL:Function_call_interrupts
      1.85 ± 19%      -2.5%       1.80 ± 22%  interrupts.CPU68.IWI:IRQ_work_interrupts
    605906            +0.1%     606664        interrupts.CPU68.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU68.MCP:Machine_check_polls
      7880 ± 19%      -2.6%       7672 ± 22%  interrupts.CPU68.NMI:Non-maskable_interrupts
      7880 ± 19%      -2.6%       7672 ± 22%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
    331.85 ± 24%      -6.3%     311.10 ±  3%  interrupts.CPU68.RES:Rescheduling_interrupts
      2.31 ± 39%     -13.3%       2.00 ± 44%  interrupts.CPU68.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU69.101:PCI-MSI.23593014-edge.nvme0q54
      0.00          -100.0%       0.00        interrupts.CPU69.133:PCI-MSI.23593014-edge.nvme0q54
      1100 ± 29%     +46.5%       1611 ± 25%  interrupts.CPU69.CAL:Function_call_interrupts
      1.77 ± 23%      +7.4%       1.90 ± 15%  interrupts.CPU69.IWI:IRQ_work_interrupts
    605955            +0.1%     606654        interrupts.CPU69.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU69.MCP:Machine_check_polls
      7552 ± 23%      +7.2%       8099 ± 15%  interrupts.CPU69.NMI:Non-maskable_interrupts
      7552 ± 23%      +7.2%       8099 ± 15%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
    377.69 ± 64%     -18.1%     309.30        interrupts.CPU69.RES:Rescheduling_interrupts
      2.38 ± 38%     -11.9%       2.10 ± 44%  interrupts.CPU69.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU7.8:IO-APIC.8-edge.rtc0
      1107 ± 29%     +45.9%       1616 ± 25%  interrupts.CPU7.CAL:Function_call_interrupts
      1.77 ± 23%      +7.4%       1.90 ± 15%  interrupts.CPU7.IWI:IRQ_work_interrupts
    606043            +0.1%     606756        interrupts.CPU7.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU7.MCP:Machine_check_polls
      7265 ± 23%      +7.3%       7796 ± 15%  interrupts.CPU7.NMI:Non-maskable_interrupts
      7265 ± 23%      +7.3%       7796 ± 15%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
    310.23           +31.7%     408.50 ± 68%  interrupts.CPU7.RES:Rescheduling_interrupts
      2.46 ± 30%     -18.8%       2.00 ± 44%  interrupts.CPU7.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU70.130:PCI-MSI.23593015-edge.nvme0q55
      1144 ± 29%     +52.4%       1744 ± 21%  interrupts.CPU70.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU70.IWI:IRQ_work_interrupts
    605860            +0.1%     606665        interrupts.CPU70.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU70.MCP:Machine_check_polls
      7880 ± 19%      +2.8%       8099 ± 15%  interrupts.CPU70.NMI:Non-maskable_interrupts
      7880 ± 19%      +2.8%       8099 ± 15%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
    327.08 ± 17%      +6.7%     349.10 ± 34%  interrupts.CPU70.RES:Rescheduling_interrupts
      2.31 ± 49%     -13.3%       2.00 ± 44%  interrupts.CPU70.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU71.122:PCI-MSI.23593016-edge.nvme0q56
      1106 ± 28%     +60.1%       1770 ± 23%  interrupts.CPU71.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU71.IWI:IRQ_work_interrupts
    605905            +0.1%     606694        interrupts.CPU71.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU71.MCP:Machine_check_polls
      7880 ± 19%      +2.8%       8100 ± 15%  interrupts.CPU71.NMI:Non-maskable_interrupts
      7880 ± 19%      +2.8%       8100 ± 15%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
    379.54 ± 63%     -12.7%     331.30 ± 19%  interrupts.CPU71.RES:Rescheduling_interrupts
      3.08 ±115%     -41.5%       1.80 ± 59%  interrupts.CPU71.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU72.198:PCI-MSI.100728832-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU72.199:PCI-MSI.100728832-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU72.69:PCI-MSI.100728832-edge.ioat-msix
      1338 ± 25%     +27.4%       1705 ± 29%  interrupts.CPU72.CAL:Function_call_interrupts
      1.77 ± 23%      +7.4%       1.90 ± 15%  interrupts.CPU72.IWI:IRQ_work_interrupts
    605877            +0.1%     606761        interrupts.CPU72.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU72.MCP:Machine_check_polls
      7133 ± 23%      +7.2%       7646 ± 15%  interrupts.CPU72.NMI:Non-maskable_interrupts
      7133 ± 23%      +7.2%       7646 ± 15%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
    373.54 ± 15%      -5.3%     353.80 ±  6%  interrupts.CPU72.RES:Rescheduling_interrupts
      2.08 ± 48%      +1.1%       2.10 ±115%  interrupts.CPU72.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU73.200:PCI-MSI.100730880-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU73.201:PCI-MSI.100730880-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU73.71:PCI-MSI.100730880-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU73.72:PCI-MSI.100730880-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU73.73:PCI-MSI.100730880-edge.ioat-msix
      2277 ± 53%     +16.3%       2648 ± 34%  interrupts.CPU73.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU73.IWI:IRQ_work_interrupts
    605907            +0.1%     606748        interrupts.CPU73.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU73.MCP:Machine_check_polls
      7444 ± 19%      +2.7%       7647 ± 15%  interrupts.CPU73.NMI:Non-maskable_interrupts
      7444 ± 19%      +2.7%       7647 ± 15%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
    382.23 ± 22%      +3.4%     395.10 ± 25%  interrupts.CPU73.RES:Rescheduling_interrupts
      2.08 ± 44%     -18.1%       1.70 ± 37%  interrupts.CPU73.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU74.201:PCI-MSI.100732928-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU74.202:PCI-MSI.100732928-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU74.72:PCI-MSI.100732928-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU74.74:PCI-MSI.100732928-edge.ioat-msix
      1843 ± 46%     +29.6%       2389 ± 42%  interrupts.CPU74.CAL:Function_call_interrupts
      2.00            -5.0%       1.90 ± 15%  interrupts.CPU74.IWI:IRQ_work_interrupts
    605917            +0.1%     606769        interrupts.CPU74.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU74.MCP:Machine_check_polls
      7755 ± 13%      -1.4%       7647 ± 15%  interrupts.CPU74.NMI:Non-maskable_interrupts
      7755 ± 13%      -1.4%       7647 ± 15%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
    397.77 ± 25%     +15.3%     458.80 ± 47%  interrupts.CPU74.RES:Rescheduling_interrupts
      2.31 ± 35%     -30.7%       1.60 ± 63%  interrupts.CPU74.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU75.202:PCI-MSI.100734976-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU75.203:PCI-MSI.100734976-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU75.73:PCI-MSI.100734976-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU75.75:PCI-MSI.100734976-edge.ioat-msix
      1313 ± 54%     +40.3%       1843 ± 31%  interrupts.CPU75.CAL:Function_call_interrupts
      1.92 ± 13%      -6.4%       1.80 ± 22%  interrupts.CPU75.IWI:IRQ_work_interrupts
    605891            +0.1%     606710        interrupts.CPU75.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU75.MCP:Machine_check_polls
      7755 ± 13%      -6.6%       7244 ± 22%  interrupts.CPU75.NMI:Non-maskable_interrupts
      7755 ± 13%      -6.6%       7244 ± 22%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
    344.46 ± 29%     +12.1%     386.30 ± 35%  interrupts.CPU75.RES:Rescheduling_interrupts
      2.31 ± 39%     -30.7%       1.60 ± 75%  interrupts.CPU75.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU76.198:PCI-MSI.100737024-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU76.203:PCI-MSI.100737024-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU76.204:PCI-MSI.100737024-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU76.74:PCI-MSI.100737024-edge.ioat-msix
      1105 ± 28%     +46.0%       1613 ± 25%  interrupts.CPU76.CAL:Function_call_interrupts
      2.00           -10.0%       1.80 ± 22%  interrupts.CPU76.IWI:IRQ_work_interrupts
    605935            +0.1%     606714        interrupts.CPU76.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU76.MCP:Machine_check_polls
      8065           -10.2%       7244 ± 22%  interrupts.CPU76.NMI:Non-maskable_interrupts
      8065           -10.2%       7244 ± 22%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
    308.85            +0.4%     310.20        interrupts.CPU76.RES:Rescheduling_interrupts
      2.31 ± 35%     -22.0%       1.80 ± 64%  interrupts.CPU76.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU77.205:PCI-MSI.100739072-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU77.75:PCI-MSI.100739072-edge.ioat-msix
      1098 ± 29%     +46.6%       1610 ± 25%  interrupts.CPU77.CAL:Function_call_interrupts
      1.69 ± 27%     +12.3%       1.90 ± 15%  interrupts.CPU77.IWI:IRQ_work_interrupts
    605879            +0.1%     606719        interrupts.CPU77.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU77.MCP:Machine_check_polls
      6824 ± 27%     +12.0%       7646 ± 15%  interrupts.CPU77.NMI:Non-maskable_interrupts
      6824 ± 27%     +12.0%       7646 ± 15%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
    332.77 ± 24%      -7.3%     308.60        interrupts.CPU77.RES:Rescheduling_interrupts
      2.38 ± 38%     -16.1%       2.00 ± 54%  interrupts.CPU77.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU78.206:PCI-MSI.100741120-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU78.78:PCI-MSI.100741120-edge.ioat-msix
      1107 ± 31%     +46.4%       1621 ± 25%  interrupts.CPU78.CAL:Function_call_interrupts
      1.69 ± 27%      +0.5%       1.70 ± 26%  interrupts.CPU78.IWI:IRQ_work_interrupts
    605877            +0.1%     606663        interrupts.CPU78.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU78.MCP:Machine_check_polls
      6824 ± 27%      +0.2%       6841 ± 26%  interrupts.CPU78.NMI:Non-maskable_interrupts
      6824 ± 27%      +0.2%       6841 ± 26%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
    308.08            +5.1%     323.90 ± 10%  interrupts.CPU78.RES:Rescheduling_interrupts
      2.54 ± 39%     -21.2%       2.00 ± 67%  interrupts.CPU78.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU79.207:PCI-MSI.100743168-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU79.79:PCI-MSI.100743168-edge.ioat-msix
      1102 ± 29%     +46.4%       1613 ± 25%  interrupts.CPU79.CAL:Function_call_interrupts
      1.69 ± 27%      +6.4%       1.80 ± 22%  interrupts.CPU79.IWI:IRQ_work_interrupts
    605882            +0.1%     606740        interrupts.CPU79.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU79.MCP:Machine_check_polls
      6824 ± 27%      +6.1%       7242 ± 22%  interrupts.CPU79.NMI:Non-maskable_interrupts
      6824 ± 27%      +6.1%       7242 ± 22%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
    309.92            +0.5%     311.60 ±  3%  interrupts.CPU79.RES:Rescheduling_interrupts
      2.46 ± 30%     -26.9%       1.80 ± 73%  interrupts.CPU79.TLB:TLB_shootdowns
      1095 ± 29%     +45.0%       1588 ± 32%  interrupts.CPU8.CAL:Function_call_interrupts
      1.85 ± 19%      +2.9%       1.90 ± 15%  interrupts.CPU8.IWI:IRQ_work_interrupts
    606049            +0.1%     606758        interrupts.CPU8.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU8.MCP:Machine_check_polls
      7581 ± 19%      +2.8%       7795 ± 15%  interrupts.CPU8.NMI:Non-maskable_interrupts
      7581 ± 19%      +2.8%       7795 ± 15%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    312.54 ±  2%      -0.1%     312.10        interrupts.CPU8.RES:Rescheduling_interrupts
      2.62 ± 28%     -19.7%       2.10 ± 39%  interrupts.CPU8.TLB:TLB_shootdowns
      1099 ± 29%     +46.5%       1611 ± 25%  interrupts.CPU80.CAL:Function_call_interrupts
      1.69 ± 27%     +12.3%       1.90 ± 15%  interrupts.CPU80.IWI:IRQ_work_interrupts
    605905            +0.1%     606711        interrupts.CPU80.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU80.MCP:Machine_check_polls
      6824 ± 27%     +12.0%       7645 ± 15%  interrupts.CPU80.NMI:Non-maskable_interrupts
      6824 ± 27%     +12.0%       7645 ± 15%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
    333.38 ± 24%      -7.3%     309.00        interrupts.CPU80.RES:Rescheduling_interrupts
      2.23 ± 35%     -19.3%       1.80 ± 73%  interrupts.CPU80.TLB:TLB_shootdowns
      1071 ± 33%     +50.3%       1611 ± 25%  interrupts.CPU81.CAL:Function_call_interrupts
      1.62 ± 30%     +17.6%       1.90 ± 15%  interrupts.CPU81.IWI:IRQ_work_interrupts
    605903            +0.1%     606710        interrupts.CPU81.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU81.MCP:Machine_check_polls
      6514 ± 30%     +17.4%       7645 ± 15%  interrupts.CPU81.NMI:Non-maskable_interrupts
      6514 ± 30%     +17.4%       7645 ± 15%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
    313.92 ±  5%      -1.5%     309.30        interrupts.CPU81.RES:Rescheduling_interrupts
      2.54 ± 39%     -29.1%       1.80 ± 73%  interrupts.CPU81.TLB:TLB_shootdowns
      1098 ± 29%     +42.4%       1563 ± 27%  interrupts.CPU82.CAL:Function_call_interrupts
      1.62 ± 30%     +17.6%       1.90 ± 15%  interrupts.CPU82.IWI:IRQ_work_interrupts
    605855            +0.1%     606742        interrupts.CPU82.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU82.MCP:Machine_check_polls
      6515 ± 30%     +17.4%       7645 ± 15%  interrupts.CPU82.NMI:Non-maskable_interrupts
      6515 ± 30%     +17.4%       7645 ± 15%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
    309.00            -0.1%     308.60        interrupts.CPU82.RES:Rescheduling_interrupts
      2.46 ± 43%     -10.6%       2.20 ± 48%  interrupts.CPU82.TLB:TLB_shootdowns
      1102 ± 29%     +46.8%       1617 ± 25%  interrupts.CPU83.CAL:Function_call_interrupts
      1.46 ± 34%     +30.0%       1.90 ± 15%  interrupts.CPU83.IWI:IRQ_work_interrupts
    605861            +0.1%     606709        interrupts.CPU83.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU83.MCP:Machine_check_polls
      5893 ± 34%     +29.7%       7645 ± 15%  interrupts.CPU83.NMI:Non-maskable_interrupts
      5893 ± 34%     +29.7%       7645 ± 15%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
    308.77            +1.0%     312.00 ±  3%  interrupts.CPU83.RES:Rescheduling_interrupts
      2.46 ± 46%     -22.8%       1.90 ± 64%  interrupts.CPU83.TLB:TLB_shootdowns
      1091 ± 28%     +40.6%       1534 ± 30%  interrupts.CPU84.CAL:Function_call_interrupts
      1.54 ± 32%     +23.5%       1.90 ± 15%  interrupts.CPU84.IWI:IRQ_work_interrupts
    605885            +0.1%     606725        interrupts.CPU84.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU84.MCP:Machine_check_polls
      6203 ± 32%     +23.2%       7644 ± 15%  interrupts.CPU84.NMI:Non-maskable_interrupts
      6203 ± 32%     +23.2%       7644 ± 15%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
    308.31            +0.3%     309.20        interrupts.CPU84.RES:Rescheduling_interrupts
      4.69 ±176%     -53.1%       2.20 ± 48%  interrupts.CPU84.TLB:TLB_shootdowns
      1098 ± 29%     +46.7%       1610 ± 25%  interrupts.CPU85.CAL:Function_call_interrupts
      1.54 ± 32%     +30.0%       2.00        interrupts.CPU85.IWI:IRQ_work_interrupts
    605837            +0.1%     606684        interrupts.CPU85.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU85.MCP:Machine_check_polls
      6204 ± 32%     +29.7%       8049        interrupts.CPU85.NMI:Non-maskable_interrupts
      6204 ± 32%     +29.7%       8049        interrupts.CPU85.PMI:Performance_monitoring_interrupts
    311.00 ±  2%      -0.6%     309.00        interrupts.CPU85.RES:Rescheduling_interrupts
      2.46 ± 43%     -26.9%       1.80 ± 64%  interrupts.CPU85.TLB:TLB_shootdowns
      1111 ± 31%     +44.9%       1610 ± 25%  interrupts.CPU86.CAL:Function_call_interrupts
      1.54 ± 32%     +30.0%       2.00        interrupts.CPU86.IWI:IRQ_work_interrupts
    605873            +0.1%     606699        interrupts.CPU86.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU86.MCP:Machine_check_polls
      6203 ± 32%     +29.8%       8049        interrupts.CPU86.NMI:Non-maskable_interrupts
      6203 ± 32%     +29.8%       8049        interrupts.CPU86.PMI:Performance_monitoring_interrupts
    314.77 ±  7%      -1.7%     309.30        interrupts.CPU86.RES:Rescheduling_interrupts
      2.46 ± 37%     -22.8%       1.90 ± 64%  interrupts.CPU86.TLB:TLB_shootdowns
      1297 ± 55%     +24.2%       1611 ± 25%  interrupts.CPU87.CAL:Function_call_interrupts
      1.77 ± 23%     +13.0%       2.00        interrupts.CPU87.IWI:IRQ_work_interrupts
    605817            +0.2%     606743        interrupts.CPU87.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU87.MCP:Machine_check_polls
      7136 ± 23%     +12.8%       8048        interrupts.CPU87.NMI:Non-maskable_interrupts
      7136 ± 23%     +12.8%       8048        interrupts.CPU87.PMI:Performance_monitoring_interrupts
    339.38 ± 31%      -9.0%     308.70        interrupts.CPU87.RES:Rescheduling_interrupts
      2.46 ± 43%     -30.9%       1.70 ± 74%  interrupts.CPU87.TLB:TLB_shootdowns
      1098 ± 29%     +47.2%       1617 ± 25%  interrupts.CPU88.CAL:Function_call_interrupts
      1.85 ± 19%      +8.3%       2.00        interrupts.CPU88.IWI:IRQ_work_interrupts
    605860            +0.1%     606718        interrupts.CPU88.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU88.MCP:Machine_check_polls
      7446 ± 19%      +8.1%       8048        interrupts.CPU88.NMI:Non-maskable_interrupts
      7446 ± 19%      +8.1%       8048        interrupts.CPU88.PMI:Performance_monitoring_interrupts
    308.69            +0.8%     311.30 ±  2%  interrupts.CPU88.RES:Rescheduling_interrupts
      2.46 ± 43%     -26.9%       1.80 ± 64%  interrupts.CPU88.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU89.148:PCI-MSI.23593042-edge.nvme0q82
      1230 ± 55%     +31.2%       1614 ± 25%  interrupts.CPU89.CAL:Function_call_interrupts
      1.77 ± 23%     +13.0%       2.00        interrupts.CPU89.IWI:IRQ_work_interrupts
    605848            +0.1%     606702        interrupts.CPU89.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU89.MCP:Machine_check_polls
      7135 ± 23%     +12.8%       8049        interrupts.CPU89.NMI:Non-maskable_interrupts
      7135 ± 23%     +12.8%       8049        interrupts.CPU89.PMI:Performance_monitoring_interrupts
    351.08 ± 42%      -3.3%     339.60 ± 27%  interrupts.CPU89.RES:Rescheduling_interrupts
      2.54 ± 36%     -21.2%       2.00 ± 54%  interrupts.CPU89.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU9.30:PCI-MSI.524288-edge.eth0
      1114 ± 31%     +45.9%       1626 ± 25%  interrupts.CPU9.CAL:Function_call_interrupts
      1.85 ± 19%      +8.3%       2.00        interrupts.CPU9.IWI:IRQ_work_interrupts
    606005            +0.1%     606787        interrupts.CPU9.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU9.MCP:Machine_check_polls
      7580 ± 19%      +8.2%       8204        interrupts.CPU9.NMI:Non-maskable_interrupts
      7580 ± 19%      +8.2%       8204        interrupts.CPU9.PMI:Performance_monitoring_interrupts
    314.38 ±  4%      -0.9%     311.60        interrupts.CPU9.RES:Rescheduling_interrupts
      2.62 ± 28%     -15.9%       2.20 ± 48%  interrupts.CPU9.TLB:TLB_shootdowns
      1104 ± 28%     +46.6%       1619 ± 25%  interrupts.CPU90.CAL:Function_call_interrupts
      1.69 ± 27%      +6.4%       1.80 ± 22%  interrupts.CPU90.IWI:IRQ_work_interrupts
    605816            +0.1%     606718        interrupts.CPU90.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU90.MCP:Machine_check_polls
      6824 ± 27%      +6.2%       7245 ± 22%  interrupts.CPU90.NMI:Non-maskable_interrupts
      6824 ± 27%      +6.2%       7245 ± 22%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
    331.54 ± 24%      -6.9%     308.70        interrupts.CPU90.RES:Rescheduling_interrupts
      2.38 ± 38%     -16.1%       2.00 ± 54%  interrupts.CPU90.TLB:TLB_shootdowns
      1479 ±102%      +9.0%       1612 ± 25%  interrupts.CPU91.CAL:Function_call_interrupts
      1.69 ± 27%      +6.4%       1.80 ± 22%  interrupts.CPU91.IWI:IRQ_work_interrupts
    605813            +0.1%     606701        interrupts.CPU91.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU91.MCP:Machine_check_polls
      6825 ± 27%      +6.1%       7245 ± 22%  interrupts.CPU91.NMI:Non-maskable_interrupts
      6825 ± 27%      +6.1%       7245 ± 22%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
    378.46 ± 64%     -18.5%     308.60        interrupts.CPU91.RES:Rescheduling_interrupts
      2.31 ± 46%     -13.3%       2.00 ± 54%  interrupts.CPU91.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU92.147:PCI-MSI.23593045-edge.nvme0q85
      1184 ± 33%     +36.1%       1612 ± 25%  interrupts.CPU92.CAL:Function_call_interrupts
      1.77 ± 23%      +1.7%       1.80 ± 22%  interrupts.CPU92.IWI:IRQ_work_interrupts
    605812            +0.1%     606720        interrupts.CPU92.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU92.MCP:Machine_check_polls
      7135 ± 23%      +1.6%       7246 ± 22%  interrupts.CPU92.NMI:Non-maskable_interrupts
      7135 ± 23%      +1.6%       7246 ± 22%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
    336.15 ± 28%      -8.1%     309.00        interrupts.CPU92.RES:Rescheduling_interrupts
      2.38 ± 38%     -16.1%       2.00 ± 54%  interrupts.CPU92.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU93.138:PCI-MSI.23593046-edge.nvme0q86
      0.00          -100.0%       0.00        interrupts.CPU93.148:PCI-MSI.23593046-edge.nvme0q86
      1229 ± 41%     +31.5%       1616 ± 25%  interrupts.CPU93.CAL:Function_call_interrupts
      1.77 ± 23%      +7.4%       1.90 ± 15%  interrupts.CPU93.IWI:IRQ_work_interrupts
    605818            +0.1%     606656        interrupts.CPU93.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU93.MCP:Machine_check_polls
      7135 ± 23%      +7.2%       7648 ± 15%  interrupts.CPU93.NMI:Non-maskable_interrupts
      7135 ± 23%      +7.2%       7648 ± 15%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
    356.15 ± 42%     -13.2%     309.30        interrupts.CPU93.RES:Rescheduling_interrupts
      2.46 ± 46%     -22.8%       1.90 ± 64%  interrupts.CPU93.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU94.139:PCI-MSI.23593047-edge.nvme0q87
      1098 ± 29%     +46.7%       1612 ± 25%  interrupts.CPU94.CAL:Function_call_interrupts
      1.77 ± 23%      +7.4%       1.90 ± 15%  interrupts.CPU94.IWI:IRQ_work_interrupts
    605811            +0.1%     606710        interrupts.CPU94.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU94.MCP:Machine_check_polls
      7136 ± 23%      +7.2%       7648 ± 15%  interrupts.CPU94.NMI:Non-maskable_interrupts
      7136 ± 23%      +7.2%       7648 ± 15%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
    312.15 ±  3%      -0.5%     310.70        interrupts.CPU94.RES:Rescheduling_interrupts
      2.46 ± 46%     -26.9%       1.80 ± 73%  interrupts.CPU94.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU95.141:PCI-MSI.23593048-edge.nvme0q88
      0.00          -100.0%       0.00        interrupts.CPU95.154:PCI-MSI.23593048-edge.nvme0q88
      1117 ± 28%     +53.3%       1713 ± 20%  interrupts.CPU95.CAL:Function_call_interrupts
      2.31 ± 26%      +8.3%       2.50 ± 20%  interrupts.CPU95.IWI:IRQ_work_interrupts
    605988            +0.1%     606859        interrupts.CPU95.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU95.MCP:Machine_check_polls
      7142 ± 23%     +12.8%       8053        interrupts.CPU95.NMI:Non-maskable_interrupts
      7142 ± 23%     +12.8%       8053        interrupts.CPU95.PMI:Performance_monitoring_interrupts
    317.54            +8.3%     343.80 ± 16%  interrupts.CPU95.RES:Rescheduling_interrupts
      3.23 ± 74%      +2.1%       3.30 ± 86%  interrupts.CPU95.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU96.140:PCI-MSI.23593057-edge.nvme0q97
      0.00          -100.0%       0.00        interrupts.CPU96.146:PCI-MSI.23593057-edge.nvme0q97
      0.00          -100.0%       0.00        interrupts.CPU96.149:PCI-MSI.23593057-edge.nvme0q97
      0.00          -100.0%       0.00        interrupts.CPU96.150:PCI-MSI.23593057-edge.nvme0q97
      0.00          -100.0%       0.00        interrupts.CPU96.159:PCI-MSI.23593057-edge.nvme0q97
      0.00          -100.0%       0.00        interrupts.CPU96.163:PCI-MSI.23593057-edge.nvme0q97
      0.00          -100.0%       0.00        interrupts.CPU96.172:PCI-MSI.23593057-edge.nvme0q97
      0.00          -100.0%       0.00        interrupts.CPU96.176:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU96.176:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU96.48:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU96.49:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU96.51:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU96.52:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU96.54:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU96.56:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU96.58:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU96.59:PCI-MSI.23592960-edge.nvme0q0
     12760 ± 31%     +18.2%      15078 ± 10%  interrupts.CPU96.CAL:Function_call_interrupts
      1.69 ± 27%     +18.2%       2.00        interrupts.CPU96.IWI:IRQ_work_interrupts
    606147            +0.1%     606939        interrupts.CPU96.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU96.MCP:Machine_check_polls
      6947 ± 27%     +18.1%       8201        interrupts.CPU96.NMI:Non-maskable_interrupts
      6947 ± 27%     +18.1%       8201        interrupts.CPU96.PMI:Performance_monitoring_interrupts
    344.46 ± 10%      +0.9%     347.60 ±  6%  interrupts.CPU96.RES:Rescheduling_interrupts
      2.38 ± 79%     -45.5%       1.30 ± 69%  interrupts.CPU96.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU97.141:PCI-MSI.23593058-edge.nvme0q98
      0.00          -100.0%       0.00        interrupts.CPU97.145:PCI-MSI.23593058-edge.nvme0q98
      0.00          -100.0%       0.00        interrupts.CPU97.150:PCI-MSI.23593058-edge.nvme0q98
      0.00          -100.0%       0.00        interrupts.CPU97.153:PCI-MSI.23593058-edge.nvme0q98
      0.00          -100.0%       0.00        interrupts.CPU97.156:PCI-MSI.23593058-edge.nvme0q98
      0.00          -100.0%       0.00        interrupts.CPU97.164:PCI-MSI.23593058-edge.nvme0q98
      0.00          -100.0%       0.00        interrupts.CPU97.173:PCI-MSI.23593058-edge.nvme0q98
      0.00          -100.0%       0.00        interrupts.CPU97.177:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU97.53:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU97.64:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU97.72:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU97.73:PCI-MSI.23592960-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU97.77:PCI-MSI.23592960-edge.nvme0q0
      4563 ± 50%     +42.8%       6516 ± 28%  interrupts.CPU97.CAL:Function_call_interrupts
      1.77 ± 23%     +13.0%       2.00 ± 22%  interrupts.CPU97.IWI:IRQ_work_interrupts
    606125            +0.1%     606850        interrupts.CPU97.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU97.MCP:Machine_check_polls
      7265 ± 23%      +7.3%       7792 ± 15%  interrupts.CPU97.NMI:Non-maskable_interrupts
      7265 ± 23%      +7.3%       7792 ± 15%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
    379.92 ± 12%      +3.2%     392.20 ± 10%  interrupts.CPU97.RES:Rescheduling_interrupts
      2.54 ± 81%     -48.8%       1.30 ± 69%  interrupts.CPU97.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU98.146:PCI-MSI.23593059-edge.nvme0q99
      0.00          -100.0%       0.00        interrupts.CPU98.152:PCI-MSI.23593059-edge.nvme0q99
      0.00          -100.0%       0.00        interrupts.CPU98.157:PCI-MSI.23593059-edge.nvme0q99
      0.00          -100.0%       0.00        interrupts.CPU98.159:PCI-MSI.23593059-edge.nvme0q99
      0.00          -100.0%       0.00        interrupts.CPU98.161:PCI-MSI.23593059-edge.nvme0q99
      0.00          -100.0%       0.00        interrupts.CPU98.165:PCI-MSI.23593059-edge.nvme0q99
      0.00          -100.0%       0.00        interrupts.CPU98.174:PCI-MSI.23593059-edge.nvme0q99
      2709 ± 44%      -9.6%       2449 ± 33%  interrupts.CPU98.CAL:Function_call_interrupts
      1.77 ± 23%     +13.0%       2.00        interrupts.CPU98.IWI:IRQ_work_interrupts
    606043            +0.1%     606837        interrupts.CPU98.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU98.MCP:Machine_check_polls
      7264 ± 23%     +12.9%       8202        interrupts.CPU98.NMI:Non-maskable_interrupts
      7264 ± 23%     +12.9%       8202        interrupts.CPU98.PMI:Performance_monitoring_interrupts
    465.92 ± 35%      -0.2%     465.20 ± 21%  interrupts.CPU98.RES:Rescheduling_interrupts
      2.31 ± 35%    +134.0%       5.40 ±203%  interrupts.CPU98.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU99.143:PCI-MSI.23593060-edge.nvme0q100
      0.00          -100.0%       0.00        interrupts.CPU99.147:PCI-MSI.23593060-edge.nvme0q100
      0.00          -100.0%       0.00        interrupts.CPU99.152:PCI-MSI.23593060-edge.nvme0q100
      0.00          -100.0%       0.00        interrupts.CPU99.153:PCI-MSI.23593060-edge.nvme0q100
      0.00          -100.0%       0.00        interrupts.CPU99.155:PCI-MSI.23593060-edge.nvme0q100
      0.00          -100.0%       0.00        interrupts.CPU99.166:PCI-MSI.23593060-edge.nvme0q100
      0.00          -100.0%       0.00        interrupts.CPU99.175:PCI-MSI.23593060-edge.nvme0q100
      1879 ± 97%      -1.7%       1847 ± 30%  interrupts.CPU99.CAL:Function_call_interrupts
      1.92 ± 13%      +4.0%       2.00        interrupts.CPU99.IWI:IRQ_work_interrupts
    606008            +0.1%     606716        interrupts.CPU99.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00        interrupts.CPU99.MCP:Machine_check_polls
      7897 ± 13%      +3.9%       8203        interrupts.CPU99.NMI:Non-maskable_interrupts
      7897 ± 13%      +3.9%       8203        interrupts.CPU99.PMI:Performance_monitoring_interrupts
    505.38 ± 70%     +21.9%     616.10 ±126%  interrupts.CPU99.RES:Rescheduling_interrupts
      2.15 ± 40%     -30.4%       1.50 ± 61%  interrupts.CPU99.TLB:TLB_shootdowns
    350.38 ±  4%      +1.7%     356.50 ±  4%  interrupts.IWI:IRQ_work_interrupts
 1.163e+08            +0.1%  1.165e+08        interrupts.LOC:Local_timer_interrupts
    192.00            +0.0%     192.00        interrupts.MCP:Machine_check_polls
   1441522 ±  4%      +1.4%    1461294 ±  4%  interrupts.NMI:Non-maskable_interrupts
   1441522 ±  4%      +1.4%    1461294 ±  4%  interrupts.PMI:Performance_monitoring_interrupts
     65638            +0.5%      65993        interrupts.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00        interrupts.RTR:APIC_ICR_read_retries
    541.62 ± 23%     -25.8%     401.70 ± 52%  interrupts.TLB:TLB_shootdowns


> 
> ---
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Sun, 23 May 2021 14:23:30 +0200
> Subject: [PATCH] tick/nohz: Only check for RCU deferred wakeup on user/guest
>  entry when needed
> 
> Checking for and processing RCU-nocb deferred wakeup upon user/guest
> entry is only relevant when nohz_full runs on the local CPU, otherwise
> the periodic tick should take care of it.
> 
> Make sure we don't needlessly pollute these fast-paths.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  include/linux/entry-kvm.h | 3 ++-
>  include/linux/tick.h      | 7 +++++++
>  kernel/entry/common.c     | 5 +++--
>  kernel/time/tick-sched.c  | 1 +
>  4 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
> index 8b2b1d68b954..136b8d97d8c0 100644
> --- a/include/linux/entry-kvm.h
> +++ b/include/linux/entry-kvm.h
> @@ -3,6 +3,7 @@
>  #define __LINUX_ENTRYKVM_H
>  
>  #include <linux/entry-common.h>
> +#include <linux/tick.h>
>  
>  /* Transfer to guest mode work */
>  #ifdef CONFIG_KVM_XFER_TO_GUEST_WORK
> @@ -57,7 +58,7 @@ int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu);
>  static inline void xfer_to_guest_mode_prepare(void)
>  {
>  	lockdep_assert_irqs_disabled();
> -	rcu_nocb_flush_deferred_wakeup();
> +	tick_nohz_user_enter_prepare();
>  }
>  
>  /**
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index 7340613c7eff..1a0ff88fa107 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -11,6 +11,7 @@
>  #include <linux/context_tracking_state.h>
>  #include <linux/cpumask.h>
>  #include <linux/sched.h>
> +#include <linux/rcupdate.h>
>  
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
>  extern void __init tick_init(void);
> @@ -300,4 +301,10 @@ static inline void tick_nohz_task_switch(void)
>  		__tick_nohz_task_switch();
>  }
>  
> +static inline void tick_nohz_user_enter_prepare(void)
> +{
> +	if (tick_nohz_full_cpu(smp_processor_id()))
> +		rcu_nocb_flush_deferred_wakeup();
> +}
> +
>  #endif
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index a0b3b04fb596..bf16395b9e13 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -5,6 +5,7 @@
>  #include <linux/highmem.h>
>  #include <linux/livepatch.h>
>  #include <linux/audit.h>
> +#include <linux/tick.h>
>  
>  #include "common.h"
>  
> @@ -186,7 +187,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>  		local_irq_disable_exit_to_user();
>  
>  		/* Check if any of the above work has queued a deferred wakeup */
> -		rcu_nocb_flush_deferred_wakeup();
> +		tick_nohz_user_enter_prepare();
>  
>  		ti_work = READ_ONCE(current_thread_info()->flags);
>  	}
> @@ -202,7 +203,7 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
>  	lockdep_assert_irqs_disabled();
>  
>  	/* Flush pending rcuog wakeup before the last need_resched() check */
> -	rcu_nocb_flush_deferred_wakeup();
> +	tick_nohz_user_enter_prepare();
>  
>  	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
>  		ti_work = exit_to_user_mode_loop(regs, ti_work);
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 828b091501ca..6784f27a3099 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -230,6 +230,7 @@ static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
>  
>  #ifdef CONFIG_NO_HZ_FULL
>  cpumask_var_t tick_nohz_full_mask;
> +EXPORT_SYMBOL_GPL(tick_nohz_full_mask);
>  bool tick_nohz_full_running;
>  EXPORT_SYMBOL_GPL(tick_nohz_full_running);
>  static atomic_t tick_dep_mask;
> -- 
> 2.25.1
> 
