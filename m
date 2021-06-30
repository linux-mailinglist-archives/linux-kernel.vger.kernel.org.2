Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46F33B7E00
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbhF3H2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:28:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:32834 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232636AbhF3H2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:28:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="208343981"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="208343981"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 00:26:17 -0700
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="457112316"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 00:26:12 -0700
Date:   Wed, 30 Jun 2021 15:45:00 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [percpu] rerun aim9.sync_disk_rw.ops_per_sec request
Message-ID: <20210630074500.GB10248@xsang-OptiPlex-9020>
References: <YM0eY2uyQg51zx/a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YM0eY2uyQg51zx/a@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Dennis,

sorry for late.

On Fri, Jun 18, 2021 at 10:29:55PM +0000, Dennis Zhou wrote:
> Hi Oliver,
> 
> Thanks again for your help previously with running the tests in [1].
> There have been some other clean ups so I've rebased that patch [2] and
> created a separate branch in percpu#depop-batching [3]. Could you please
> run aim9.sync_disk_rw.ops_per_sec against percpu#depop-batching?
> 
> [1] https://lore.kernel.org/lkml/20210427073448.GD32408@xsang-OptiPlex-9020/
> [2] https://lore.kernel.org/lkml/20210419225047.3415425-5-dennis@kernel.org/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git/log/?h=depop-batching

we checked this branch, and found it's actully a child of the parent commit of
ace7e70901 we reported in [1]

$ git log --oneline --graph dennis-percpu/depop-batching
* 963278aca614f (dennis-percpu/depop-batching) percpu: use reclaim threshold instead of running for every page <--- new commit
* e4d777003a43f (dennis-percpu/for-5.14) percpu: optimize locking in pcpu_balance_workfn() <--- parent of new commit
* 4829c791b22f9 percpu: initialize best_upa variable
* faf65dde844af percpu: rework memcg accounting
* 4d5c8aedc8aa6 mm, memcg: introduce mem_cgroup_kmem_disabled()
* 0f0cace35fa65 mm, memcg: mark cgroup_memory_nosocket, nokmem and noswap as __ro_after_init
* 8d55ba5df39a2 percpu: make symbol 'pcpu_free_slot' static
* f183324133ea5 percpu: implement partial chunk depopulation <--- parent of previous ace7e70901
...

so we tested both e4d777003a43f and 963278aca614f.
what we found is, if comparing to f183324133ea5, the new commit
still has a 1.8% regression.
a little better than previous report [1]. but this seems due to
there is a small improvement from f183324133ea5 to new parent
e4d777003a43f (around 1%).
if directly compare 963278aca614f with its parent, it has about
2.7% regression (not in below detail table, but basically,
f183324133ea5 -> e4d777003a43f -> 963278aca614f
     |-----  +1.0% ---------  -2.7% --|
so:
     |-----------  -1.8%  ------------|
)

please be noted we only find this regression on Knights Landing
server. if you want us to test on other platforms, could you suggest
the model?

[1] https://lore.kernel.org/lkml/20210427073448.GD32408@xsang-OptiPlex-9020/

below is the detail comparison results.

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime/ucode:
  gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/lkp-knl-f1/sync_disk_rw/aim9/300s/0xffff0190

commit: 
  f183324133ea5 ("percpu: implement partial chunk depopulation")
  e4d777003a43f ("percpu: optimize locking in pcpu_balance_workfn()")
  963278aca614f ("percpu: use reclaim threshold instead of running for every page")

f183324133ea535d e4d777003a43feab2e000749163 963278aca614fbb434a1349bb78 
---------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \  
    103531            +1.0%     104524            -1.8%     101698        aim9.sync_disk_rw.ops_per_sec
    300.12            -0.0%     300.11            +0.0%     300.12        aim9.time.elapsed_time
    300.12            -0.0%     300.11            +0.0%     300.12        aim9.time.elapsed_time.max
    732.67            +2.2%     748.67 ±  2%      +1.0%     739.83        aim9.time.involuntary_context_switches
      2836 ±  2%      +0.3%       2844            +0.2%       2842        aim9.time.maximum_resident_set_size
      1187            +0.4%       1191            -0.2%       1184        aim9.time.minor_page_faults
      4096            +0.0%       4096            +0.0%       4096        aim9.time.page_size
     91.00            +0.0%      91.00            +0.0%      91.00        aim9.time.percent_of_cpu_this_job_got
    219.28            +1.3%     222.07 ±  2%      -0.0%     219.22        aim9.time.system_time
     55.21            -4.5%      52.72 ± 11%      +0.6%      55.54 ±  2%  aim9.time.user_time
     29.50 ±  6%      -6.8%      27.50 ±  9%      -6.8%      27.50 ±  4%  aim9.time.voluntary_context_switches
    380.82           +12.8%     429.48           +12.9%     429.95        uptime.boot
     91562           +13.4%     103823           +13.4%     103864        uptime.idle
     76.55 ±  2%     +63.5%     125.18 ±  2%     +64.7%     126.08        boot-time.boot
     27.14 ±  3%     +53.4%      41.64 ±  2%     +54.7%      41.99        boot-time.dhcp
     17296 ±  2%     +71.4%      29640 ±  3%     +72.7%      29873 ±  2%  boot-time.idle
      1.96            +1.8%       1.99 ±  2%      +1.4%       1.99        boot-time.smp_boot
 7.169e+10            -0.2%  7.155e+10            -0.2%  7.158e+10        cpuidle.C1.time
 1.553e+08            -1.8%  1.526e+08 ±  2%      -0.5%  1.545e+08        cpuidle.C1.usage
     95169 ±  6%  +45206.0%   43117495 ±141%  +16870.9%   16151118 ±221%  cpuidle.POLL.time
      2206 ± 24%  +28875.3%     639389 ±140%  +10935.5%     243515 ±221%  cpuidle.POLL.usage
     94.91            -0.1       94.85            -0.1       94.81        mpstat.cpu.all.idle%
      4.42            +0.1        4.49            +0.1        4.53        mpstat.cpu.all.irq%
      0.17 ±  3%      +0.0        0.18 ±  6%      +0.0        0.18 ±  2%  mpstat.cpu.all.soft%
      0.35            -0.0        0.35 ±  2%      -0.0        0.34        mpstat.cpu.all.sys%
      0.15            -0.0        0.13 ±  5%      -0.0        0.14        mpstat.cpu.all.usr%
      0.00          -100.0%       0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
   8862949            +0.8%    8938180            -1.5%    8727397        numa-numastat.node0.local_node
   8862894            +0.8%    8938101            -1.5%    8727352        numa-numastat.node0.numa_hit
      0.00          -100.0%       0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
      1.17 ± 76%     +57.1%       1.83 ± 73%    +128.6%       2.67 ± 93%  numa-numastat.node1.numa_hit
      1.17 ± 76%     +57.1%       1.83 ± 73%    +128.6%       2.67 ± 93%  numa-numastat.node1.other_node
    300.12            -0.0%     300.11            +0.0%     300.12        time.elapsed_time
    300.12            -0.0%     300.11            +0.0%     300.12        time.elapsed_time.max
    732.67            +2.2%     748.67 ±  2%      +1.0%     739.83        time.involuntary_context_switches
      2836 ±  2%      +0.3%       2844            +0.2%       2842        time.maximum_resident_set_size
      1187            +0.4%       1191            -0.2%       1184        time.minor_page_faults
      4096            +0.0%       4096            +0.0%       4096        time.page_size
     91.00            +0.0%      91.00            +0.0%      91.00        time.percent_of_cpu_this_job_got
    219.28            +1.3%     222.07 ±  2%      -0.0%     219.22        time.system_time
     55.21            -4.5%      52.72 ± 11%      +0.6%      55.54 ±  2%  time.user_time
     29.50 ±  6%      -6.8%      27.50 ±  9%      -6.8%      27.50 ±  4%  time.voluntary_context_switches
     94.00            +0.0%      94.00            +0.0%      94.00        vmstat.cpu.id
      5.00            +0.0%       5.00            -3.3%       4.83 ±  7%  vmstat.cpu.sy
      0.00          -100.0%       0.00          -100.0%       0.00        vmstat.cpu.us
      0.00          -100.0%       0.00          -100.0%       0.00        vmstat.io.bi
    544.67 ± 10%     +32.1%     719.33 ±  2%     +33.3%     726.00 ±  8%  vmstat.memory.buff
   1132342          +124.6%    2542993          +124.6%    2543227        vmstat.memory.cache
 1.041e+08            -1.4%  1.027e+08            -1.4%  1.027e+08        vmstat.memory.free
      0.00          -100.0%       0.00          -100.0%       0.00        vmstat.procs.b
      1.00            +0.0%       1.00            +0.0%       1.00        vmstat.procs.r
      2580            +6.5%       2749            +6.9%       2759        vmstat.system.cs
    511107            -0.6%     508106            -0.0%     510857        vmstat.system.in
    120.33            +1.0%     121.50            +0.4%     120.83        turbostat.Avg_MHz
      8.61            +0.1        8.69            +0.1        8.66        turbostat.Busy%
      1400            +0.0%       1400            +0.0%       1400        turbostat.Bzy_MHz
 1.552e+08            -1.7%  1.525e+08 ±  2%      -0.5%  1.544e+08        turbostat.C1
     92.77            -0.1       92.65            -0.1       92.68        turbostat.C1%
     91.39            -0.1%      91.31            -0.1%      91.34        turbostat.CPU%c1
     61.50            -0.3%      61.33            +2.7%      63.17        turbostat.CoreTmp
 1.546e+08            -0.6%  1.537e+08            -0.0%  1.546e+08        turbostat.IRQ
     66.00            +0.0%      66.00            +1.5%      67.00        turbostat.PkgTmp
    110.87            -0.1%     110.71            +0.5%     111.38        turbostat.PkgWatt
      2.39 ±  5%      -4.7%       2.28 ±  5%      +0.1%       2.39 ±  6%  turbostat.RAMWatt
      1297            +0.0%       1297            +0.0%       1297        turbostat.TSC_MHz
     26815            +1.5%      27216            +0.9%      27048        meminfo.Active
     26267            +0.9%      26492            +0.2%      26318        meminfo.Active(anon)
    548.67 ± 10%     +31.8%     723.33 ±  2%     +33.0%     729.83 ±  8%  meminfo.Active(file)
    191276           +12.7%     215550           +11.9%     214115        meminfo.AnonHugePages
    251007            +6.0%     266100            +5.9%     265700        meminfo.AnonPages
    544.67 ± 10%     +32.1%     719.33 ±  2%     +33.3%     726.00 ±  8%  meminfo.Buffers
   1006852          +137.7%    2392998          +137.6%    2392759        meminfo.Cached
    200520            +0.0%     200520            +0.0%     200520        meminfo.CmaFree
    204800            +0.0%     204800            +0.0%     204800        meminfo.CmaTotal
  53537336            +0.0%   53537336            +0.0%   53537336        meminfo.CommitLimit
    368947            +3.9%     383231            +3.8%     383082        meminfo.Committed_AS
 1.003e+08            -1.0%   99265194            -0.9%   99439957        meminfo.DirectMap1G
   9237504 ±  5%     +10.6%   10220544 ±  5%      +8.7%   10041685 ±  7%  meminfo.DirectMap2M
   1492529 ±  7%      +4.4%    1558065 ± 11%      +4.7%    1562161 ± 10%  meminfo.DirectMap4k
      0.00          -100.0%       0.00          -100.0%       0.00        meminfo.Dirty
      2048            +0.0%       2048            +0.0%       2048        meminfo.Hugepagesize
    264495            +5.9%     279968            +5.5%     279017        meminfo.Inactive
    264495            +5.9%     279968            +5.5%     279017        meminfo.Inactive(anon)
      0.00          -100.0%       0.00          -100.0%       0.00        meminfo.Inactive(file)
    125481           +19.5%     149986           +20.0%     150536        meminfo.KReclaimable
     34771            -1.0%      34409            -0.8%      34493        meminfo.KernelStack
     31799            +2.6%      32618            +2.2%      32488        meminfo.Mapped
 1.035e+08            -1.4%  1.021e+08            -1.4%  1.021e+08        meminfo.MemAvailable
 1.041e+08            -1.4%  1.027e+08            -1.4%  1.027e+08        meminfo.MemFree
 1.071e+08            +0.0%  1.071e+08            +0.0%  1.071e+08        meminfo.MemTotal
   2965112           +47.8%    4381521           +47.8%    4382501        meminfo.Memused
    685.67 ±129%     +40.1%     960.83 ± 92%     +40.1%     960.83 ± 92%  meminfo.Mlocked
      4233            -0.8%       4200            -0.5%       4211        meminfo.PageTables
    123600            -1.4%     121818            -1.4%     121833        meminfo.Percpu
    125481           +19.5%     149986           +20.0%     150536        meminfo.SReclaimable
    303579            +1.6%     308331            +2.0%     309591        meminfo.SUnreclaim
     40042            +0.5%      40256            +0.0%      40058        meminfo.Shmem
    429061            +6.8%     458318            +7.2%     460128        meminfo.Slab
    966908          +143.3%    2352882          +143.3%    2352839        meminfo.Unevictable
 3.436e+10            +0.0%  3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
    230733            +0.1%     230923            +0.2%     231095        meminfo.VmallocUsed
   3996086           +35.4%    5412320           +35.4%    5410966        meminfo.max_used_kB
     26858            +1.3%      27211            +0.7%      27051        numa-meminfo.node0.Active
     26309            +0.7%      26487            +0.0%      26321        numa-meminfo.node0.Active(anon)
    548.67 ± 10%     +31.8%     723.33 ±  2%     +33.0%     729.83 ±  8%  numa-meminfo.node0.Active(file)
    191320           +12.7%     215531           +11.9%     214125        numa-meminfo.node0.AnonHugePages
    251001            +6.0%     266097            +5.9%     265710        numa-meminfo.node0.AnonPages
    308912            +4.7%     323500            +4.4%     322372        numa-meminfo.node0.AnonPages.max
      0.00          -100.0%       0.00          -100.0%       0.00        numa-meminfo.node0.Dirty
    544628          +147.9%    1350099          +147.9%    1349880        numa-meminfo.node0.FilePages
    264479            +5.9%     279968            +5.5%     279009        numa-meminfo.node0.Inactive
    264479            +5.9%     279968            +5.5%     279009        numa-meminfo.node0.Inactive(anon)
      0.00          -100.0%       0.00          -100.0%       0.00        numa-meminfo.node0.Inactive(file)
    108211           +14.4%     123807           +14.9%     124283 ±  2%  numa-meminfo.node0.KReclaimable
     34759            -1.1%      34394            -0.8%      34482        numa-meminfo.node0.KernelStack
     19390            +3.8%      20121            +3.2%      20007        numa-meminfo.node0.Mapped
  96447669            -0.9%   95622519            -0.9%   95621754        numa-meminfo.node0.MemFree
  98862596            +0.0%   98862596            +0.0%   98862596        numa-meminfo.node0.MemTotal
   2414925           +34.2%    3240075           +34.2%    3240840        numa-meminfo.node0.MemUsed
    395.33 ±128%     +39.4%     551.17 ± 92%     +39.2%     550.33 ± 91%  numa-meminfo.node0.Mlocked
      4233            -0.8%       4198            -0.8%       4201        numa-meminfo.node0.PageTables
    108211           +14.4%     123807           +14.9%     124283 ±  2%  numa-meminfo.node0.SReclaimable
    292030            +1.8%     297188            +2.1%     298109        numa-meminfo.node0.SUnreclaim
     40066            +0.5%      40250            -0.0%      40049        numa-meminfo.node0.Shmem
    400242            +5.2%     420996            +5.5%     422392        numa-meminfo.node0.Slab
    504116          +159.7%    1309267          +159.7%    1309243        numa-meminfo.node0.Unevictable
    462792          +125.5%    1043615          +125.5%    1043596        numa-meminfo.node1.FilePages
     17280 ±  6%     +51.5%      26184 ±  6%     +52.0%      26259 ±  9%  numa-meminfo.node1.KReclaimable
     10.67 ± 70%     +25.0%      13.33 ± 44%     -50.0%       5.33 ±141%  numa-meminfo.node1.KernelStack
     12442            +0.4%      12496            +0.2%      12465        numa-meminfo.node1.Mapped
   7662516            -7.7%    7072940            -7.7%    7072524        numa-meminfo.node1.MemFree
   8212076            +0.0%    8212076            +0.0%    8212076        numa-meminfo.node1.MemTotal
    549558          +107.3%    1139134          +107.4%    1139550        numa-meminfo.node1.MemUsed
    294.67 ±129%     +39.4%     410.83 ± 92%     +39.6%     411.33 ± 92%  numa-meminfo.node1.Mlocked
      4.00            +0.0%       4.00            +0.0%       4.00        numa-meminfo.node1.PageTables
     17280 ±  6%     +51.5%      26184 ±  6%     +52.0%      26259 ±  9%  numa-meminfo.node1.SReclaimable
     11552 ±  7%      -3.6%      11138 ± 14%      -0.6%      11477 ± 12%  numa-meminfo.node1.SUnreclaim
     28832 ±  5%     +29.4%      37322 ±  5%     +30.9%      37736 ±  9%  numa-meminfo.node1.Slab
    462792          +125.5%    1043615          +125.5%    1043596        numa-meminfo.node1.Unevictable
      6580            +0.7%       6625            -0.1%       6577        numa-vmstat.node0.nr_active_anon
    137.17 ± 10%     +31.8%     180.83 ±  2%     +32.9%     182.33 ±  8%  numa-vmstat.node0.nr_active_file
     62768            +6.0%      66533            +5.9%      66440        numa-vmstat.node0.nr_anon_pages
     93.00           +12.4%     104.50           +11.8%     104.00        numa-vmstat.node0.nr_anon_transparent_hugepages
     18.00 ± 18%     +63.9%      29.50           +65.7%      29.83 ± 39%  numa-vmstat.node0.nr_dirtied
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node0.nr_dirty
    136167          +147.9%     337532          +147.8%     337472        numa-vmstat.node0.nr_file_pages
     50130            +0.0%      50130            +0.0%      50130        numa-vmstat.node0.nr_free_cma
  24111954            -0.9%   23905366            -0.9%   23905218        numa-vmstat.node0.nr_free_pages
     66141            +5.8%      70002            +5.5%      69770        numa-vmstat.node0.nr_inactive_anon
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node0.nr_inactive_file
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node0.nr_isolated_anon
     34756            -1.0%      34393            -0.8%      34485        numa-vmstat.node0.nr_kernel_stack
      4974            +3.6%       5154            +3.1%       5127        numa-vmstat.node0.nr_mapped
     97.83 ±130%     +39.9%     136.83 ± 93%     +40.0%     137.00 ± 92%  numa-vmstat.node0.nr_mlock
      1056            -0.9%       1046            -0.7%       1048        numa-vmstat.node0.nr_page_table_pages
     10026            +0.4%      10070            -0.1%      10014        numa-vmstat.node0.nr_shmem
     27051           +14.4%      30950           +14.9%      31069 ±  2%  numa-vmstat.node0.nr_slab_reclaimable
     73006            +1.8%      74297            +2.1%      74529        numa-vmstat.node0.nr_slab_unreclaimable
    126028          +159.7%     327316          +159.7%     327310        numa-vmstat.node0.nr_unevictable
     17.00 ± 19%     +67.6%      28.50           +69.6%      28.83 ± 40%  numa-vmstat.node0.nr_written
      6581            +0.7%       6626            -0.1%       6575        numa-vmstat.node0.nr_zone_active_anon
    137.17 ± 10%     +31.8%     180.83 ±  2%     +32.9%     182.33 ±  8%  numa-vmstat.node0.nr_zone_active_file
     66141            +5.8%      70002            +5.5%      69770        numa-vmstat.node0.nr_zone_inactive_anon
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node0.nr_zone_inactive_file
    126028          +159.7%     327316          +159.7%     327310        numa-vmstat.node0.nr_zone_unevictable
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node0.nr_zone_write_pending
   6428805            +7.7%    6925353            +6.2%    6830553        numa-vmstat.node0.numa_hit
    132774          +115.5%     286118          +115.5%     286177        numa-vmstat.node0.numa_interleave
   6428824            +7.7%    6925371            +6.2%    6830571        numa-vmstat.node0.numa_local
    115698          +125.5%     260903          +125.5%     260899        numa-vmstat.node1.nr_file_pages
   1915628            -7.7%    1768234            -7.7%    1768130        numa-vmstat.node1.nr_free_pages
     10.67 ± 70%     +25.0%      13.33 ± 44%     -50.0%       5.33 ±141%  numa-vmstat.node1.nr_kernel_stack
      3108            +0.5%       3122            +0.2%       3115        numa-vmstat.node1.nr_mapped
     73.00 ±130%     +39.5%     101.83 ± 93%     +40.0%     102.17 ± 92%  numa-vmstat.node1.nr_mlock
      1.00            +0.0%       1.00            +0.0%       1.00        numa-vmstat.node1.nr_page_table_pages
      4320 ±  6%     +51.5%       6546 ±  6%     +52.0%       6564 ±  9%  numa-vmstat.node1.nr_slab_reclaimable
      2887 ±  7%      -3.6%       2784 ± 14%      -0.7%       2868 ± 12%  numa-vmstat.node1.nr_slab_unreclaimable
    115698          +125.5%     260903          +125.5%     260899        numa-vmstat.node1.nr_unevictable
    115698          +125.5%     260903          +125.5%     260899        numa-vmstat.node1.nr_zone_unevictable
    132956          +115.2%     286182          +115.2%     286136        numa-vmstat.node1.numa_hit
    132912          +115.3%     286137          +115.2%     286081        numa-vmstat.node1.numa_interleave
    132956          +115.2%     286182          +115.2%     286136        numa-vmstat.node1.numa_other
     37.99 ±  2%      -8.6%      34.71 ±  2%      -5.8%      35.80 ±  3%  perf-stat.i.MPKI
   5.6e+08 ±  2%      +3.6%  5.804e+08 ±  2%      -0.1%  5.597e+08 ±  2%  perf-stat.i.branch-instructions
      7.63 ±  2%      +0.6        8.21            +0.5        8.16        perf-stat.i.branch-miss-rate%
  42664479 ±  4%     +11.4%   47528341 ±  2%      +6.7%   45540372 ±  4%  perf-stat.i.branch-misses
     16.71            +0.3       17.05            +0.4       17.13        perf-stat.i.cache-miss-rate%
  16470516            -3.3%   15918869            -3.2%   15935976        perf-stat.i.cache-misses
  98614944            -5.2%   93447964            -5.6%   93086889        perf-stat.i.cache-references
      2519            +5.4%       2654            +5.8%       2665        perf-stat.i.context-switches
      8.36            -5.7%       7.89 ±  2%      -2.8%       8.12 ±  2%  perf-stat.i.cpi
    255996            +0.0%     256044            +0.0%     256044        perf-stat.i.cpu-clock
 2.171e+10            -2.3%  2.121e+10            -2.8%   2.11e+10        perf-stat.i.cpu-cycles
    281.13            +0.1%     281.49            +0.2%     281.63        perf-stat.i.cpu-migrations
      1319 ±  2%      +1.1%       1334            +0.4%       1325        perf-stat.i.cycles-between-cache-misses
      2.11 ±  2%      -0.1        2.03 ±  2%      -0.0        2.09 ±  3%  perf-stat.i.iTLB-load-miss-rate%
  55721706            -0.5%   55456065            -0.7%   55319478        perf-stat.i.iTLB-load-misses
 2.654e+09 ±  2%      +3.0%  2.734e+09 ±  2%      -0.4%  2.644e+09 ±  2%  perf-stat.i.iTLB-loads
 2.651e+09 ±  2%      +3.2%  2.734e+09 ±  2%      -0.2%  2.645e+09 ±  2%  perf-stat.i.instructions
     47.53 ±  2%      +3.6%      49.26 ±  2%      +0.5%      47.77 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.12            +5.6%       0.13 ±  2%      +2.7%       0.12 ±  2%  perf-stat.i.ipc
      2.35 ± 34%     +22.9%       2.89 ± 39%     +64.5%       3.86 ± 12%  perf-stat.i.major-faults
      0.08            -2.3%       0.08            -2.8%       0.08        perf-stat.i.metric.GHz
      0.03        +1.1e+06%     364.94        +1.1e+06%     363.53        perf-stat.i.metric.K/sec
     12.94 ±  2%      +0.0%      12.94 ±  2%      -3.3%      12.51 ±  2%  perf-stat.i.metric.M/sec
      2793            +0.2%       2798            +0.0%       2794        perf-stat.i.minor-faults
      2796            +0.2%       2801            +0.1%       2798        perf-stat.i.page-faults
    255996            +0.0%     256044            +0.0%     256044        perf-stat.i.task-clock
     37.18 ±  2%      -8.0%      34.19 ±  2%      -5.3%      35.21 ±  3%  perf-stat.overall.MPKI
      7.61 ±  2%      +0.6        8.19            +0.5        8.13        perf-stat.overall.branch-miss-rate%
     16.70            +0.3       17.03            +0.4       17.12        perf-stat.overall.cache-miss-rate%
      8.18            -5.2%       7.76 ±  2%      -2.5%       7.98 ±  2%  perf-stat.overall.cpi
      1318 ±  2%      +1.0%       1332            +0.4%       1324        perf-stat.overall.cycles-between-cache-misses
      2.05 ±  2%      -0.1        1.99 ±  2%      -0.0        2.05 ±  3%  perf-stat.overall.iTLB-load-miss-rate%
     47.66 ±  2%      +3.5%      49.34 ±  2%      +0.4%      47.86 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.12            +5.5%       0.13 ±  2%      +2.6%       0.13 ±  2%  perf-stat.overall.ipc
 5.591e+08 ±  2%      +3.5%  5.787e+08 ±  2%      -0.2%   5.58e+08 ±  2%  perf-stat.ps.branch-instructions
  42584908 ±  4%     +11.3%   47380429 ±  2%      +6.6%   45402308 ±  4%  perf-stat.ps.branch-misses
  16419650            -3.4%   15866795            -3.3%   15883928        perf-stat.ps.cache-misses
  98323595            -5.3%   93149542            -5.6%   92791899        perf-stat.ps.cache-references
      2511            +5.3%       2645            +5.7%       2654        perf-stat.ps.context-switches
    255107            +0.0%     255155            +0.0%     255157        perf-stat.ps.cpu-clock
 2.165e+10            -2.4%  2.114e+10            -2.9%  2.103e+10        perf-stat.ps.cpu-cycles
    280.62            +0.1%     280.94            +0.2%     281.06        perf-stat.ps.cpu-migrations
  55529179            -0.5%   55263431            -0.7%   55127449        perf-stat.ps.iTLB-load-misses
  2.65e+09 ±  2%      +2.9%  2.726e+09 ±  2%      -0.5%  2.637e+09 ±  2%  perf-stat.ps.iTLB-loads
 2.646e+09 ±  2%      +3.0%  2.726e+09 ±  2%      -0.3%  2.638e+09 ±  2%  perf-stat.ps.instructions
      2.35 ± 34%     +22.8%       2.88 ± 39%     +64.1%       3.85 ± 12%  perf-stat.ps.major-faults
      2785            +0.1%       2789            +0.0%       2786        perf-stat.ps.minor-faults
      2788            +0.2%       2792            +0.1%       2790        perf-stat.ps.page-faults
    255107            +0.0%     255155            +0.0%     255157        perf-stat.ps.task-clock
 7.954e+11 ±  2%      +2.8%  8.176e+11 ±  2%      -0.5%  7.914e+11 ±  2%  perf-stat.total.instructions
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.compact_isolated
      6576            +0.7%       6623            +0.1%       6582        proc-vmstat.nr_active_anon
    137.17 ± 10%     +31.8%     180.83 ±  2%     +32.9%     182.33 ±  8%  proc-vmstat.nr_active_file
     62747            +6.0%      66516            +5.8%      66417        proc-vmstat.nr_anon_pages
     93.00           +12.4%     104.50           +11.8%     104.00        proc-vmstat.nr_anon_transparent_hugepages
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.nr_dirtied
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.nr_dirty
   2581622            -1.4%    2546315            -1.4%    2546291        proc-vmstat.nr_dirty_background_threshold
   5169558            -1.4%    5098856            -1.4%    5098810        proc-vmstat.nr_dirty_threshold
    251857          +137.6%     598432          +137.6%     598375        proc-vmstat.nr_file_pages
     50130            +0.0%      50130            +0.0%      50130        proc-vmstat.nr_free_cma
  26027500            -1.4%   25673576            -1.4%   25673341        proc-vmstat.nr_free_pages
     66118            +5.8%      69985            +5.5%      69746        proc-vmstat.nr_inactive_anon
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.nr_inactive_file
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.nr_isolated_anon
     34770            -1.1%      34404            -0.8%      34489        proc-vmstat.nr_kernel_stack
      8077            +2.5%       8280            +2.1%       8248        proc-vmstat.nr_mapped
    172.33 ±129%     +39.4%     240.17 ± 92%     +39.5%     240.33 ± 91%  proc-vmstat.nr_mlock
      1059            -1.0%       1048            -0.8%       1051        proc-vmstat.nr_page_table_pages
     10018            +0.5%      10066            -0.0%      10018        proc-vmstat.nr_shmem
     31371           +19.5%      37497           +20.0%      37634        proc-vmstat.nr_slab_reclaimable
     75895            +1.6%      77081            +2.0%      77397        proc-vmstat.nr_slab_unreclaimable
    241726          +143.3%     588220          +143.3%     588209        proc-vmstat.nr_unevictable
      1.00            +0.0%       1.00            +0.0%       1.00        proc-vmstat.nr_written
      6577            +0.7%       6623            +0.1%       6582        proc-vmstat.nr_zone_active_anon
    137.17 ± 10%     +31.8%     180.83 ±  2%     +32.9%     182.33 ±  8%  proc-vmstat.nr_zone_active_file
     66118            +5.8%      69985            +5.5%      69746        proc-vmstat.nr_zone_inactive_anon
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.nr_zone_inactive_file
    241726          +143.3%     588220          +143.3%     588209        proc-vmstat.nr_zone_unevictable
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.nr_zone_write_pending
      3823           -30.4%       2663 ± 14%     -27.9%       2758 ± 10%  proc-vmstat.numa_hint_faults
      3823           -30.4%       2663 ± 14%     -27.9%       2758 ± 10%  proc-vmstat.numa_hint_faults_local
   8878045            +0.9%    8955853            -1.5%    8740809        proc-vmstat.numa_hit
    112.00 ± 50%     -43.0%      63.83 ± 53%     -16.7%      93.33 ± 22%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.numa_interleave
   8878044            +0.9%    8955851            -1.5%    8740806        proc-vmstat.numa_local
      1.50 ± 74%     +66.7%       2.50 ± 44%     +88.9%       2.83 ± 98%  proc-vmstat.numa_other
     63282 ± 46%     -42.4%      36474 ± 47%     -18.5%      51570 ± 21%  proc-vmstat.numa_pte_updates
    515593            +0.9%     520430            -1.7%     506733        proc-vmstat.pgactivate
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
   8967593            +0.8%    9041179            -1.6%    8828129        proc-vmstat.pgalloc_normal
    878257            +0.4%     881378            +0.3%     880846        proc-vmstat.pgfault
   8941947            +0.9%    9018901            -1.5%    8806037        proc-vmstat.pgfree
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgpgin
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgpgout
     50552            -0.2%      50470            -0.8%      50142 ±  2%  proc-vmstat.pgreuse
     73.00 ±  3%     -33.1%      48.83 ±  3%     -34.2%      48.00 ±  2%  proc-vmstat.thp_collapse_alloc
      0.50 ±223%    +100.0%       1.00 ±152%     -33.3%       0.33 ±223%  proc-vmstat.thp_deferred_split_page
     42.33            +0.4%      42.50            -0.8%      42.00        proc-vmstat.thp_fault_alloc
      0.50 ±223%    +100.0%       1.00 ±152%     -33.3%       0.33 ±223%  proc-vmstat.thp_split_pmd
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
    105.83           +13.5%     120.17 ± 24%      +0.0%     105.83        proc-vmstat.unevictable_pgs_culled
    586.00            +0.0%     586.00            +0.0%     586.00        proc-vmstat.unevictable_pgs_mlocked
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.unevictable_pgs_rescued
   2629888            -9.9%    2370560           -10.2%    2362112        proc-vmstat.unevictable_pgs_scanned
      0.00        +4.7e+09%      47.23 ±223%  +1.3e+10%     127.77 ±142%  sched_debug.cfs_rq:/.MIN_vruntime.avg
      0.00        +1.1e+12%      11193 ±223%  +2.9e+12%      29311 ±142%  sched_debug.cfs_rq:/.MIN_vruntime.max
      0.00            +0.0%       0.00            +0.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.min
      0.00       +7.3e+104%     725.53 ±223% +1.9e+105%       1930 ±142%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
     18405 ± 12%      -7.8%      16967 ± 24%      -8.4%      16867 ±  4%  sched_debug.cfs_rq:/.load.avg
    418300 ± 11%      +0.1%     418687 ± 10%      +1.4%     423950 ± 19%  sched_debug.cfs_rq:/.load.max
     78910 ±  6%      -4.8%      75091 ± 12%      -4.6%      75259 ±  8%  sched_debug.cfs_rq:/.load.stddev
     16.06 ± 13%      -3.7%      15.47 ± 13%      -1.2%      15.86 ±  4%  sched_debug.cfs_rq:/.load_avg.avg
    421.91 ±  9%     +18.6%     500.33 ± 14%     +22.2%     515.63 ± 12%  sched_debug.cfs_rq:/.load_avg.max
     72.62 ±  5%      +2.2%      74.24 ±  8%      +5.8%      76.81 ±  6%  sched_debug.cfs_rq:/.load_avg.stddev
      0.00        +4.7e+09%      47.23 ±223%  +1.3e+10%     127.77 ±142%  sched_debug.cfs_rq:/.max_vruntime.avg
      0.00        +1.1e+12%      11193 ±223%  +2.9e+12%      29311 ±142%  sched_debug.cfs_rq:/.max_vruntime.max
      0.00            +0.0%       0.00            +0.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.min
      0.00       +7.3e+104%     725.53 ±223% +1.9e+105%       1930 ±142%  sched_debug.cfs_rq:/.max_vruntime.stddev
    358250 ± 10%      +4.8%     375490 ± 11%     +18.4%     424101 ± 18%  sched_debug.cfs_rq:/.min_vruntime.avg
    442576 ±  7%      +3.4%     457587 ±  7%     +16.2%     514412 ± 15%  sched_debug.cfs_rq:/.min_vruntime.max
    117912 ± 34%     +16.7%     137635 ± 33%     +33.4%     157268 ± 43%  sched_debug.cfs_rq:/.min_vruntime.min
     51761 ± 10%      -6.1%      48601 ±  7%     +11.2%      57576 ± 14%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.05 ±  9%      -8.4%       0.05 ± 22%      -5.7%       0.05 ±  7%  sched_debug.cfs_rq:/.nr_running.avg
      1.00            +0.0%       1.00            +3.3%       1.03 ±  7%  sched_debug.cfs_rq:/.nr_running.max
      0.22 ±  4%      -4.5%       0.21 ± 10%      -2.0%       0.21 ±  3%  sched_debug.cfs_rq:/.nr_running.stddev
      0.01 ±223%   +5014.9%       0.42 ±100%   +9715.4%       0.81 ± 91%  sched_debug.cfs_rq:/.removed.load_avg.avg
      0.86 ±223%  +11160.6%      96.97 ±100%  +15414.8%     133.60 ± 70%  sched_debug.cfs_rq:/.removed.load_avg.max
      0.08 ±223%   +7509.2%       6.39 ±100%  +11621.3%       9.85 ± 74%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      0.01 ±223%   +2265.8%       0.20 ±102%   +4528.7%       0.38 ± 95%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
      0.86 ±223%   +5106.5%      44.83 ±102%   +7165.8%      62.57 ± 72%  sched_debug.cfs_rq:/.removed.runnable_avg.max
      0.08 ±223%   +3418.8%       2.96 ±102%   +5366.0%       4.59 ± 76%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      0.01 ±223%   +2265.8%       0.20 ±102%   +4526.9%       0.38 ± 95%  sched_debug.cfs_rq:/.removed.util_avg.avg
      0.86 ±223%   +5106.5%      44.83 ±102%   +7165.8%      62.57 ± 72%  sched_debug.cfs_rq:/.removed.util_avg.max
      0.08 ±223%   +3418.8%       2.96 ±102%   +5364.8%       4.59 ± 76%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     45.86 ±  9%      -3.5%      44.27 ±  7%      -1.0%      45.41 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
      1024            +0.0%       1025            +0.2%       1027        sched_debug.cfs_rq:/.runnable_avg.max
    191.09 ±  4%      -2.1%     186.99 ±  3%      +0.1%     191.33        sched_debug.cfs_rq:/.runnable_avg.stddev
    127233 ± 58%     -27.6%      92111 ± 90%     -35.7%      81755 ± 59%  sched_debug.cfs_rq:/.spread0.avg
    211559 ± 35%     -17.6%     174222 ± 49%     -18.7%     172066 ± 30%  sched_debug.cfs_rq:/.spread0.max
   -113105           +28.9%    -145742           +63.6%    -185072        sched_debug.cfs_rq:/.spread0.min
     51761 ± 10%      -6.1%      48601 ±  7%     +11.2%      57576 ± 14%  sched_debug.cfs_rq:/.spread0.stddev
     45.79 ±  9%      -3.6%      44.16 ±  7%      -1.2%      45.26 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
      1023            -0.0%       1023            +0.0%       1023        sched_debug.cfs_rq:/.util_avg.max
    190.96 ±  4%      -2.2%     186.77 ±  3%      -0.1%     190.84        sched_debug.cfs_rq:/.util_avg.stddev
     13.16 ± 11%      -6.8%      12.27 ±  8%      +2.5%      13.49 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    712.63            -0.1%     712.27 ±  3%      +1.9%     726.07 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.max
     87.99 ±  5%      -1.6%      86.58 ±  2%      +3.0%      90.59 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
   1317111 ±  7%     -10.1%    1184228 ±  8%     -12.9%    1146695 ±  4%  sched_debug.cpu.avg_idle.avg
   4778622 ± 22%     -19.0%    3868379 ± 31%     -28.9%    3397758 ± 12%  sched_debug.cpu.avg_idle.max
    324439 ± 31%      -8.1%     298261 ± 66%     +11.3%     361169 ± 30%  sched_debug.cpu.avg_idle.min
    494330 ± 24%     -28.7%     352454 ± 29%     -33.1%     330797 ± 15%  sched_debug.cpu.avg_idle.stddev
    205657 ±  5%     +21.3%     249460           +21.5%     249925        sched_debug.cpu.clock.avg
    205845 ±  5%     +21.3%     249650           +21.5%     250116        sched_debug.cpu.clock.max
    205461 ±  5%     +21.3%     249262           +21.5%     249724        sched_debug.cpu.clock.min
    109.05            +1.4%     110.56 ±  2%      +2.5%     111.79 ±  3%  sched_debug.cpu.clock.stddev
    199388 ±  5%     +22.0%     243330           +22.2%     243741        sched_debug.cpu.clock_task.avg
    201330 ±  5%     +21.7%     245061           +22.0%     245566        sched_debug.cpu.clock_task.max
    194940 ±  6%     +22.0%     237844           +22.0%     237759        sched_debug.cpu.clock_task.min
    848.45 ±  7%      -8.0%     780.45 ±  7%      -2.2%     830.09 ±  5%  sched_debug.cpu.clock_task.stddev
     74.51 ±  8%     +23.4%      91.95 ± 17%     +27.5%      94.98 ± 10%  sched_debug.cpu.curr->pid.avg
      7080 ±  3%     +23.6%       8754           +23.8%       8766        sched_debug.cpu.curr->pid.max
    621.74 ±  5%     +27.3%     791.20 ±  8%     +28.0%     796.10 ±  4%  sched_debug.cpu.curr->pid.stddev
    687071 ±  7%     -10.4%     615614 ±  8%     -13.9%     591627 ±  5%  sched_debug.cpu.max_idle_balance_cost.avg
   2651195 ± 20%     -21.1%    2091699 ± 33%     -33.8%    1755456 ± 14%  sched_debug.cpu.max_idle_balance_cost.max
    501057            -0.2%     500000            -0.2%     500000        sched_debug.cpu.max_idle_balance_cost.min
    260536 ± 24%     -32.1%     176891 ± 32%     -39.6%     157480 ± 17%  sched_debug.cpu.max_idle_balance_cost.stddev
      4294            +0.0%       4294            +0.0%       4294        sched_debug.cpu.next_balance.avg
      4294            +0.0%       4294            +0.0%       4294        sched_debug.cpu.next_balance.max
      4294            +0.0%       4294            +0.0%       4294        sched_debug.cpu.next_balance.min
      0.00            +1.8%       0.00 ±  2%      +2.9%       0.00 ±  3%  sched_debug.cpu.next_balance.stddev
      0.02 ±  9%      -9.5%       0.01 ± 15%      -3.2%       0.02 ± 11%  sched_debug.cpu.nr_running.avg
      1.00            +3.3%       1.03 ±  7%      +3.3%       1.03 ±  7%  sched_debug.cpu.nr_running.max
      0.12 ±  3%      -3.4%       0.12 ±  8%      -1.1%       0.12 ±  5%  sched_debug.cpu.nr_running.stddev
      3029 ±  3%     +27.9%       3874           +27.7%       3869        sched_debug.cpu.nr_switches.avg
     37445 ± 12%     +18.8%      44495 ± 23%     +17.1%      43856 ± 18%  sched_debug.cpu.nr_switches.max
    925.22 ± 19%     +14.3%       1057 ±  9%     +10.0%       1017 ±  7%  sched_debug.cpu.nr_switches.min
      3504 ±  7%     +32.2%       4632 ± 10%     +35.3%       4740 ±  9%  sched_debug.cpu.nr_switches.stddev
      0.00 ± 55%     +30.4%       0.00 ± 89%     +43.5%       0.00 ± 37%  sched_debug.cpu.nr_uninterruptible.avg
    212.69            -1.8%     208.83 ±  3%      -0.3%     212.07 ±  2%  sched_debug.cpu.nr_uninterruptible.max
    -17.70           -11.5%     -15.67           -10.5%     -15.83        sched_debug.cpu.nr_uninterruptible.min
     13.81            -2.1%      13.52 ±  3%      +0.1%      13.83 ±  2%  sched_debug.cpu.nr_uninterruptible.stddev
    205460 ±  5%     +21.3%     249261           +21.5%     249723        sched_debug.cpu_clk
    996147            +0.0%     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.avg
    996147            +0.0%     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.max
    996147            +0.0%     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.min
 4.295e+09            +0.0%  4.295e+09            +0.0%  4.295e+09        sched_debug.jiffies
    204790 ±  5%     +21.4%     248604           +21.6%     249065        sched_debug.ktime
    950.00            +0.0%     950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.avg
    950.00            +0.0%     950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.max
    950.00            +0.0%     950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.min
    206248 ±  6%     +21.2%     250053           +21.3%     250139        sched_debug.sched_clk
      1.00            +0.0%       1.00            +0.0%       1.00        sched_debug.sched_clock_stable()
   4140603            +0.0%    4140603            +0.0%    4140603        sched_debug.sysctl_sched.sysctl_sched_features
     24.00            +0.0%      24.00            +0.0%      24.00        sched_debug.sysctl_sched.sysctl_sched_latency
      3.00            +0.0%       3.00            +0.0%       3.00        sched_debug.sysctl_sched.sysctl_sched_min_granularity
      1.00            +0.0%       1.00            +0.0%       1.00        sched_debug.sysctl_sched.sysctl_sched_tunable_scaling
      4.00            +0.0%       4.00            +0.0%       4.00        sched_debug.sysctl_sched.sysctl_sched_wakeup_granularity
      0.04 ±  4%      +4.3%       0.04 ±  5%     +14.6%       0.04 ± 13%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00        +6.5e+99%       0.01 ±223% +1.2e+100%       0.01 ±100%  perf-sched.sch_delay.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      0.00 ±223%    +142.3%       0.01 ±100%    +507.7%       0.03 ± 25%  perf-sched.sch_delay.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.isra
      0.01 ±110%    +100.0%       0.01 ± 79%    +203.0%       0.02 ± 46%  perf-sched.sch_delay.avg.ms.d_alloc_parallel.path_openat.do_filp_open.do_sys_openat2
      0.05 ± 14%     +35.2%       0.07 ± 43%     +15.0%       0.06 ± 10%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.04 ±  4%      +7.0%       0.04 ± 11%      -2.2%       0.04 ±  4%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.05 ± 14%     +19.9%       0.06 ± 32%     +30.9%       0.07 ± 22%  perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.03 ±  2%      +4.4%       0.03 ±  7%      -2.5%       0.03 ±  4%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.04 ±  2%      +1.2%       0.04 ±  4%      +0.4%       0.04 ±  2%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ±145%    -100.0%       0.00            -7.5%       0.01 ±142%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.01 ± 88%     +64.7%       0.01 ±124%     +35.3%       0.01 ± 96%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.00        +6.5e+99%       0.01 ±141%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.01 ± 27%     +40.7%       0.01 ± 56%     +18.6%       0.01 ± 42%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.08 ± 32%      -8.7%       0.07 ± 49%      -1.5%       0.08 ± 48%  perf-sched.sch_delay.avg.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.00 ±223%    -100.0%       0.00           +88.0%       0.01 ±223%  perf-sched.sch_delay.avg.ms.io_schedule.__lock_page.__do_fault.do_fault
      0.01 ± 85%     +27.0%       0.01 ± 78%    +103.2%       0.02 ± 15%  perf-sched.sch_delay.avg.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
      0.18 ±206%     -36.3%       0.12 ±196%     -37.9%       0.11 ±196%  perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.01 ±223%    -100.0%       0.00           -16.7%       0.01 ±223%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__flush_work.lru_add_drain_all.khugepaged
      0.00          -100.0%       0.00        +6.8e+99%       0.01 ±141%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.00 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.copy_page_from_iter.pipe_write.new_sync_write
      0.00        +6.7e+99%       0.01 ±141%  +3.3e+99%       0.00 ±223%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00        +4.8e+99%       0.00 ±223%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.acct_collect.do_exit
      0.00 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.link_path_walk
      0.00          -100.0%       0.00        +4.8e+99%       0.00 ±223%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.path_lookupat
      0.00        +4.3e+99%       0.00 ±223%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.shift_arg_pages
      0.00        +6.7e+99%       0.01 ±141%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.unlink_anon_vmas.free_pgtables
      0.00 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      0.00        +3.2e+99%       0.00 ±223%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.vma_link.mmap_region
      0.00        +3.3e+99%       0.00 ±223%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.begin_new_exec.load_elf_binary
      0.00 ±223%    +426.3%       0.02 ±223%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.00        +3.3e+99%       0.00 ±223%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.do_exit
      0.00 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.exit_signals.do_exit.do_group_exit
      0.00        +6.7e+99%       0.01 ±141%  +3.7e+99%       0.00 ±223%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.filemap_read.__kernel_read.exec_binprm
      0.00 ±223%     -13.0%       0.00 ±223%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.force_qs_rnp.rcu_gp_kthread.kthread
      0.00          -100.0%       0.00        +3.7e+99%       0.00 ±223%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.acpi_ut_create_generic_state.acpi_ds_result_push
      0.01 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process
      0.00         +6e+102%       5.96 ±223%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      0.01 ±223%     +24.3%       0.01 ±144%     -48.6%       0.00 ±223%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_write.new_sync_write
      0.01 ± 71%     -51.1%       0.01 ±141%     -54.5%       0.01 ±141%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
      0.01 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.02 ± 73%      +1.0%       0.02 ± 75%      -2.0%       0.02 ± 73%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.01 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.vmstat_shepherd.process_one_work.worker_thread
      0.01 ±142%     +10.9%       0.01 ±143%     +91.3%       0.01 ± 73%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      0.03 ± 16%     +59.4%       0.05 ± 53%     +12.0%       0.03 ± 47%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.04 ±  6%     +13.8%       0.04 ± 18%     +20.3%       0.05 ± 31%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.03 ± 13%     -12.4%       0.03 ±  6%      -6.9%       0.03 ±  6%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.03 ± 10%      -1.9%       0.03 ±  4%      -5.6%       0.03 ±  4%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.04 ±  3%     +17.9%       0.04 ± 31%     +18.3%       0.04 ± 35%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00 ±223%     +66.7%       0.01 ±223%     -12.5%       0.00 ±223%  perf-sched.sch_delay.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      0.04 ± 39%     +10.1%       0.04 ± 46%      -6.0%       0.03 ± 35%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.02 ±101%    +127.0%       0.04 ± 36%     +66.7%       0.03 ± 45%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion.__flush_work.lru_add_drain_all
      0.03 ± 10%     +15.5%       0.04 ± 25%      -3.9%       0.03 ±  7%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.02 ±  4%      -2.1%       0.02 ±  5%      -3.5%       0.02 ±  5%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      2.65 ±216%     -96.9%       0.08 ± 29%     -57.9%       1.11 ±204%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.06 ± 25%     +19.5%       0.08 ± 18%     +20.8%       0.08 ± 21%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00        +6.5e+99%       0.01 ±223% +1.2e+100%       0.01 ±100%  perf-sched.sch_delay.max.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      0.00 ±223%    +151.9%       0.01 ±100%    +525.9%       0.03 ± 38%  perf-sched.sch_delay.max.ms.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.isra
      0.01 ±103%     +98.6%       0.02 ±100%    +144.6%       0.03 ± 22%  perf-sched.sch_delay.max.ms.d_alloc_parallel.path_openat.do_filp_open.do_sys_openat2
      0.08 ± 25%    +153.0%       0.20 ± 85%     +25.1%       0.10 ± 22%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.07 ± 42%     +37.7%       0.10 ± 45%      -6.3%       0.07 ± 28%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.09 ± 16%     +46.5%       0.13 ± 51%    +119.2%       0.20 ± 74%  perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.09 ± 27%    +324.2%       0.37 ± 90%     +87.4%       0.16 ± 68%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.12 ± 12%     +69.6%       0.21 ± 80%     +20.7%       0.15 ± 47%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ±145%    -100.0%       0.00            +5.7%       0.01 ±146%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.02 ± 46%     +25.7%       0.02 ±104%     +19.5%       0.02 ±103%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.00        +6.5e+99%       0.01 ±141%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.05 ± 22%     -10.2%       0.05 ± 32%      -2.3%       0.05 ± 45%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.17 ± 53%      +7.4%       0.19 ± 44%      +5.8%       0.18 ± 70%  perf-sched.sch_delay.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.00 ±223%    -100.0%       0.00           +88.0%       0.01 ±223%  perf-sched.sch_delay.max.ms.io_schedule.__lock_page.__do_fault.do_fault
      0.02 ± 74%     +13.0%       0.02 ± 74%    +139.8%       0.04 ± 39%  perf-sched.sch_delay.max.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
    169.49 ±223%      -0.4%     168.82 ±223%      -0.1%     169.33 ±223%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.01 ±223%    -100.0%       0.00           -16.7%       0.01 ±223%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__flush_work.lru_add_drain_all.khugepaged
      0.00          -100.0%       0.00        +6.8e+99%       0.01 ±141%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.00 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.copy_page_from_iter.pipe_write.new_sync_write
      0.00        +6.7e+99%       0.01 ±141%  +3.3e+99%       0.00 ±223%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00        +4.8e+99%       0.00 ±223%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.acct_collect.do_exit
      0.00 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.link_path_walk
      0.00          -100.0%       0.00        +4.8e+99%       0.00 ±223%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.path_lookupat
      0.00        +4.3e+99%       0.00 ±223%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.shift_arg_pages
      0.00        +6.7e+99%       0.01 ±141%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.unlink_anon_vmas.free_pgtables
      0.00 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      0.00        +3.2e+99%       0.00 ±223%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.vma_link.mmap_region
      0.00        +3.3e+99%       0.00 ±223%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.begin_new_exec.load_elf_binary
      0.00 ±223%    +426.3%       0.02 ±223%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.00        +3.3e+99%       0.00 ±223%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.do_exit
      0.00 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.exit_signals.do_exit.do_group_exit
      0.00        +6.7e+99%       0.01 ±141%  +3.7e+99%       0.00 ±223%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.filemap_read.__kernel_read.exec_binprm
      0.00 ±223%     -13.0%       0.00 ±223%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.force_qs_rnp.rcu_gp_kthread.kthread
      0.00          -100.0%       0.00        +3.7e+99%       0.00 ±223%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.acpi_ut_create_generic_state.acpi_ds_result_push
      0.01 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process
      0.00         +6e+102%       5.96 ±223%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      0.01 ±223%     +24.3%       0.01 ±144%     -48.6%       0.00 ±223%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_write.new_sync_write
      0.02 ± 72%     -53.3%       0.01 ±141%     -55.4%       0.01 ±141%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
      0.01 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.02 ± 87%    +177.8%       0.06 ±144%      -3.0%       0.02 ± 93%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.01 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.vmstat_shepherd.process_one_work.worker_thread
      0.12 ± 12%     -19.1%       0.10 ± 23%      -2.5%       0.12 ± 19%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.01 ±143%      +4.1%       0.01 ±143%     +79.6%       0.01 ± 73%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      0.05 ± 14%   +5420.6%       2.91 ±216%     +13.0%       0.06 ± 29%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.07 ± 17%     +96.8%       0.13 ± 60%     +77.8%       0.12 ±100%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.05 ± 26%     -16.2%       0.04 ± 16%      -8.5%       0.04 ± 15%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.07 ± 32%     -18.9%       0.06 ± 12%     -18.6%       0.06 ± 11%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.05 ±  3%     +47.4%       0.07 ± 41%     +22.0%       0.06 ± 35%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00 ±223%     +66.7%       0.01 ±223%     -12.5%       0.00 ±223%  perf-sched.sch_delay.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
     11.57 ±222%     -23.6%       8.84 ±111%     -69.2%       3.56 ±149%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.02 ±101%    +127.0%       0.04 ± 36%     +66.7%       0.03 ± 45%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion.__flush_work.lru_add_drain_all
     21.44 ± 21%     +78.6%      38.29 ± 70%      +3.3%      22.16 ± 27%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.06 ±  8%     +60.7%       0.10 ± 62%      +4.2%       0.07 ± 19%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    323.67 ±202%     -89.8%      32.94 ± 41%     -12.5%     283.11 ±197%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.23 ±157%     -77.0%       0.05 ±111%     -49.0%       0.12 ±126%  perf-sched.total_sch_delay.average.ms
    488.61 ±140%     -57.0%     209.90 ±171%      -8.3%     447.93 ±134%  perf-sched.total_sch_delay.max.ms
    258.44            -5.4%     244.55 ±  2%      -5.0%     245.58        perf-sched.total_wait_and_delay.average.ms
     12954            +4.4%      13528            +4.6%      13556 ±  2%  perf-sched.total_wait_and_delay.count.ms
      9556 ±  2%      -1.2%       9439 ±  7%      +3.6%       9899        perf-sched.total_wait_and_delay.max.ms
    258.21            -5.3%     244.50 ±  2%      -4.9%     245.46        perf-sched.total_wait_time.average.ms
      9556 ±  2%      -1.2%       9439 ±  7%      +3.6%       9899        perf-sched.total_wait_time.max.ms
    895.86            +0.2%     897.71            +0.2%     897.61        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    397.38 ± 10%     -34.3%     261.14 ± 45%     +28.5%     510.59 ± 32%  perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    757.93 ±  8%      +2.6%     777.59 ±  7%      +0.4%     761.01 ± 10%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    397.42 ± 10%     -47.3%     209.52 ± 71%     +28.4%     510.38 ± 32%  perf-sched.wait_and_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
    276.84 ±  2%      -1.8%     271.76 ±  2%      +2.6%     284.08        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      5.55            +1.6%       5.63            +2.3%       5.67        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00       +6.3e+103%      63.01 ±223% +3.7e+104%     372.79 ±107%  perf-sched.wait_and_delay.avg.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
     52.73           -14.0%      45.34           -12.5%      46.14        perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00       +1.1e+104%     107.92 ±223%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      4.17 ± 37%     +17.8%       4.91 ± 32%     +40.7%       5.87 ± 23%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.46 ±  4%      +0.7%       4.49 ±  2%      +3.0%       4.60 ±  6%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    226.26 ± 70%     +32.8%     300.42 ± 46%     +76.7%     399.72 ± 23%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    813.83 ± 22%      -5.8%     766.57 ± 15%     -18.6%     662.17 ± 17%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    478.80            -0.0%     478.70            -0.1%     478.38        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      4.42 ±  2%      -1.2%       4.37            -0.0%       4.42 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    713.23            -2.6%     694.73            -2.6%     694.53        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.02 ±  3%     +21.6%       0.03 ± 32%      +0.0%       0.02        perf-sched.wait_and_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    743.24 ±  3%      -6.1%     697.61 ±  6%      -6.5%     694.83 ±  3%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
      9.83 ±  3%      +1.7%      10.00            +1.7%      10.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      7.83 ± 13%      +8.5%       8.50 ± 45%     +17.0%       9.17 ±  7%  perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     12.00 ±  9%      -2.8%      11.67 ±  8%      +0.0%      12.00 ± 11%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      7.83 ± 13%     -14.9%       6.67 ± 71%     +17.0%       9.17 ±  7%  perf-sched.wait_and_delay.count.do_syslog.part.0.kmsg_read.vfs_read
    243.50            -1.8%     239.00            -1.6%     239.67        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    241.00            -1.7%     237.00            -1.5%     237.50        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00       +1.5e+102%       1.50 ±223% +2.3e+102%       2.33 ±101%  perf-sched.wait_and_delay.count.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      2961           +14.0%       3376           +13.5%       3361        perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      2816            +1.5%       2859 ±  3%      +3.0%       2901 ±  4%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    352.50 ±  2%      -8.6%     322.33 ±  7%     -20.7%     279.67 ± 15%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork
     25.67 ± 71%      -3.2%      24.83 ± 52%      +1.9%      26.17 ± 38%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     33.17 ±  2%      +0.0%      33.17 ±  2%      -1.0%      32.83        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     40.00            -0.4%      39.83            -1.7%      39.33        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      1875 ±  3%      +2.6%       1923 ±  2%      +3.6%       1941 ±  4%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      3336            +1.4%       3383 ±  2%      +2.6%       3423 ±  3%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
     71.17            -2.1%      69.67            -1.6%      70.00        perf-sched.wait_and_delay.count.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    863.17 ±  3%      +5.3%     908.83 ±  4%      +3.1%     890.00 ±  2%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
    997.53            +0.0%     997.55            +0.0%     997.55        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2685           -16.1%       2254 ± 44%     +20.5%       3235 ± 24%  perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1000            +0.0%       1000            +0.0%       1000        perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      2685           -32.6%       1808 ± 70%     +20.5%       3235 ± 24%  perf-sched.wait_and_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      1904 ± 36%     +14.2%       2174 ± 11%      +5.1%       2001 ± 20%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    135.59           +22.1%     165.55           +23.8%     167.84 ±  3%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00       +4.5e+104%     445.50 ±223% +1.7e+105%       1662 ±116%  perf-sched.wait_and_delay.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      2690            +0.7%       2710           +20.5%       3242 ± 24%  perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00       +1.1e+104%     107.92 ±223%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      3970 ±105%     +41.7%       5625 ± 76%    +112.2%       8425 ± 39%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      5.99           +30.9%       7.84 ± 52%      -2.6%       5.84 ±  6%  perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      1547 ± 70%     +26.1%       1951 ± 44%     +90.2%       2943 ± 28%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      6587 ± 59%      +1.7%       6696 ± 41%     -35.5%       4251 ± 81%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    505.02            +0.0%     505.04            +0.0%     505.03        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     25.16 ± 97%     -37.9%      15.61 ± 47%     -61.6%       9.67 ± 20%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      1063            -0.0%       1063            -0.1%       1062        perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.06 ±  9%    +379.8%       0.31 ±154%     +12.7%       0.07 ±  5%  perf-sched.wait_and_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      8942 ±  5%     -17.6%       7371 ± 20%     -19.0%       7244 ± 22%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
    895.82            +0.2%     897.67            +0.2%     897.57        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ±106%      -7.5%       0.01 ± 86%      +7.5%       0.01 ±105%  perf-sched.wait_time.avg.ms.d_alloc_parallel.path_openat.do_filp_open.do_sys_openat2
    397.33 ± 10%     -23.8%     302.88 ±  9%     +28.5%     510.54 ± 32%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    757.89 ±  8%      +2.6%     777.55 ±  7%      +0.4%     760.97 ± 10%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    397.36 ± 10%     -34.0%     262.39 ± 35%     +28.4%     510.31 ± 32%  perf-sched.wait_time.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
    276.82 ±  2%      -1.8%     271.74 ±  2%      +2.6%     284.06        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      5.51            +1.5%       5.59            +2.3%       5.63        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.05 ± 77%    +160.5%       0.12 ± 49%    +148.6%       0.12 ± 71%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.00       +1.2e+101%       0.12 ±147%   +8e+100%       0.08 ±141%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.00       +4.9e+100%       0.05 ±223%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_irq_work.[unknown]
      0.00       +1.4e+100%       0.01 ±223% +2.3e+100%       0.02 ±223%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.27 ±127%     -36.9%       0.17 ±118%      +8.9%       0.29 ±102%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
     70.02 ± 83%     +51.0%     105.77 ±119%    +482.1%     407.60 ± 90%  perf-sched.wait_time.avg.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.01 ±153%     +23.5%       0.01 ±183%     -52.9%       0.01 ± 46%  perf-sched.wait_time.avg.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
     52.55           -13.9%      45.22           -12.4%      46.03        perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.08 ± 93%    +375.5%       0.40 ±177%    +189.8%       0.24 ±139%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
      0.04 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.apparmor_file_alloc_security.security_file_alloc.__alloc_file
      0.10 ± 95%     +90.3%       0.19 ±169%    +173.3%       0.27 ±200%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.generic_file_write_iter.new_sync_write
      0.00       +8.4e+101%       0.84 ±223%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.00          -100.0%       0.00        +4.3e+99%       0.00 ±223%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
      0.00          -100.0%       0.00        +5.3e+99%       0.01 ±223%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.path_put.free_fs_struct
      0.00          -100.0%       0.00        +6.5e+99%       0.01 ±223%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_openat
      0.79 ±223%      +4.6%       0.82 ±223%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.force_qs_rnp.rcu_gp_kthread.kthread
      0.30 ± 63%      -9.8%       0.27 ± 79%     +43.5%       0.44 ±124%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.00          -100.0%       0.00        +5.8e+99%       0.01 ±223%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.acpi_ut_create_generic_state.acpi_ds_result_push
      0.06 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process
      0.00          +7e+99%       0.01 ±223%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.__perf_event_read_value.perf_read
      0.00         +1e+104%     101.96 ±223%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      0.00        +7.7e+99%       0.01 ±223%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
      0.18 ± 68%     -29.2%       0.12 ± 92%      -4.5%       0.17 ± 27%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.shmem_getpage_gfp.shmem_write_begin
      0.10 ± 72%      -4.5%       0.10 ± 64%    +169.9%       0.28 ±130%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.shmem_undo_range.shmem_truncate_range.shmem_evict_inode
      2.52 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.00          +5e+98%       0.00 ±223%  +7.7e+99%       0.01 ±223%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.15 ± 30%    +252.4%       0.53 ±182%      +8.3%       0.16 ± 59%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
     34.69 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.vmstat_shepherd.process_one_work.worker_thread
      4.17 ± 37%     +17.8%       4.91 ± 32%     +40.7%       5.87 ± 23%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.43 ±  4%      +0.3%       4.45 ±  2%      +3.0%       4.56 ±  6%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    290.04 ± 24%     +16.9%     339.01 ± 18%     +37.8%     399.68 ± 23%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    813.80 ± 22%      -5.8%     766.54 ± 15%     -18.6%     662.14 ± 17%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    478.77            -0.0%     478.66            -0.1%     478.34        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.03 ± 84%     +70.3%       0.05 ± 86%      -5.2%       0.03 ± 50%  perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      4.39 ±  2%      -1.3%       4.33            +0.1%       4.39 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.62 ±198%     -91.0%       0.06 ± 46%     -93.3%       0.04 ± 72%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    713.19            -2.6%     694.69            -2.6%     694.50        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00 ± 82%    +680.0%       0.01 ±155%    +100.0%       0.00 ± 44%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    740.59 ±  3%      -5.8%     697.53 ±  6%      -6.3%     693.72 ±  3%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
    997.48            +0.0%     997.51            +0.0%     997.49        perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.03 ±107%     +58.3%       0.04 ± 92%     +23.7%       0.03 ± 81%  perf-sched.wait_time.max.ms.d_alloc_parallel.path_openat.do_filp_open.do_sys_openat2
      2685            +0.7%       2705           +20.5%       3235 ± 24%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1000            +0.0%       1000            +0.0%       1000        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      2685           -12.4%       2351 ± 34%     +20.5%       3235 ± 24%  perf-sched.wait_time.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      1904 ± 36%     +14.2%       2174 ± 11%      +5.1%       2001 ± 20%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    135.55           +22.1%     165.51           +23.8%     167.80 ±  3%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.11 ± 84%    +119.0%       0.25 ± 43%    +121.8%       0.25 ±  9%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.00       +1.4e+101%       0.14 ±136%   +8e+100%       0.08 ±141%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.00       +4.9e+100%       0.05 ±223%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_irq_work.[unknown]
      0.00       +1.4e+100%       0.01 ±223% +2.3e+100%       0.02 ±223%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      2.84 ±188%     -69.2%       0.88 ±136%     -22.7%       2.20 ±140%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
    279.94 ±122%    +116.7%     606.70 ±156%    +557.5%       1840 ± 97%  perf-sched.wait_time.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.03 ±121%    +148.1%       0.07 ±143%     +53.2%       0.04 ± 64%  perf-sched.wait_time.max.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
      2690            +0.7%       2710           +20.5%       3242 ± 24%  perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.11 ±105%    +454.4%       0.64 ±187%    +371.8%       0.54 ±171%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
      0.04 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.apparmor_file_alloc_security.security_file_alloc.__alloc_file
      0.10 ± 90%    +201.0%       0.31 ±175%    +181.6%       0.29 ±185%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.generic_file_write_iter.new_sync_write
      0.00       +8.4e+101%       0.84 ±223%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.00          -100.0%       0.00        +4.3e+99%       0.00 ±223%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
      0.00          -100.0%       0.00        +5.3e+99%       0.01 ±223%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.path_put.free_fs_struct
      0.00          -100.0%       0.00        +6.5e+99%       0.01 ±223%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_openat
      0.79 ±223%      +4.6%       0.82 ±223%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.force_qs_rnp.rcu_gp_kthread.kthread
      1.16 ±144%     +44.7%       1.69 ±110%     +55.8%       1.81 ±142%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.00          -100.0%       0.00        +5.8e+99%       0.01 ±223%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.acpi_ut_create_generic_state.acpi_ds_result_push
      0.06 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process
      0.00          +7e+99%       0.01 ±223%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.__perf_event_read_value.perf_read
      0.00         +1e+104%     101.96 ±223%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      0.00        +7.8e+99%       0.01 ±223%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
      0.38 ±103%     -39.7%       0.23 ± 91%     -32.8%       0.25 ±  8%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.shmem_getpage_gfp.shmem_write_begin
      0.15 ± 79%     +16.3%       0.17 ± 62%     +96.9%       0.29 ±124%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.shmem_undo_range.shmem_truncate_range.shmem_evict_inode
      2.52 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.00        +4.8e+99%       0.00 ±223%  +7.7e+99%       0.01 ±223%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.24 ±  9%    +260.5%       0.87 ±170%     +47.0%       0.35 ± 85%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
     34.69 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.vmstat_shepherd.process_one_work.worker_thread
      3970 ±105%     +41.7%       5625 ± 76%    +112.2%       8425 ± 39%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      5.96            +0.2%       5.97            -2.7%       5.80 ±  6%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      2293 ±  3%      +1.5%       2326 ±  3%     +28.3%       2943 ± 28%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      6587 ± 59%      +1.7%       6696 ± 41%     -35.5%       4251 ± 81%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    504.98            +0.0%     504.99            -0.0%     504.98        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.03 ± 84%     +70.3%       0.05 ± 86%      -5.2%       0.03 ± 50%  perf-sched.wait_time.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
     22.11 ± 89%     -42.2%      12.78 ± 52%     -61.0%       8.61 ±  5%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      2.30 ±214%     -97.5%       0.06 ± 45%     -97.9%       0.05 ± 73%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      1063            -0.0%       1063            -0.1%       1062        perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.04 ± 77%    +694.4%       0.29 ±170%     +61.1%       0.06 ± 25%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      8942 ±  5%     -17.6%       7371 ± 20%     -19.0%       7244 ± 22%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
     40521            +0.3%      40658            +0.2%      40599        slabinfo.Acpi-Operand.active_objs
    724.00            +0.4%     726.67            +0.3%     725.83        slabinfo.Acpi-Operand.active_slabs
     40575            +0.4%      40724            +0.2%      40674        slabinfo.Acpi-Operand.num_objs
    724.00            +0.4%     726.67            +0.3%     725.83        slabinfo.Acpi-Operand.num_slabs
      1301 ±  9%      +6.5%       1387 ± 12%      +1.9%       1326 ±  6%  slabinfo.Acpi-Parse.active_objs
     17.83 ±  9%      +6.5%      19.00 ± 12%      +1.9%      18.17 ±  6%  slabinfo.Acpi-Parse.active_slabs
      1301 ±  9%      +6.5%       1387 ± 12%      +1.9%       1326 ±  6%  slabinfo.Acpi-Parse.num_objs
     17.83 ±  9%      +6.5%      19.00 ± 12%      +1.9%      18.17 ±  6%  slabinfo.Acpi-Parse.num_slabs
     12959            +0.1%      12971            -1.1%      12820        slabinfo.Acpi-State.active_objs
    253.50            +0.2%     254.00            -1.1%     250.67        slabinfo.Acpi-State.active_slabs
     12959            +0.1%      12971            -1.1%      12820        slabinfo.Acpi-State.num_objs
    253.50            +0.2%     254.00            -1.1%     250.67        slabinfo.Acpi-State.num_slabs
      3351 ±  3%     +19.1%       3990 ±  4%     +27.3%       4264 ±  2%  slabinfo.PING.active_objs
    104.33 ±  3%     +19.0%     124.17 ±  4%     +27.3%     132.83 ±  2%  slabinfo.PING.active_slabs
      3351 ±  3%     +19.1%       3990 ±  4%     +27.3%       4264 ±  2%  slabinfo.PING.num_objs
    104.33 ±  3%     +19.0%     124.17 ±  4%     +27.3%     132.83 ±  2%  slabinfo.PING.num_slabs
    512.00            +0.0%     512.00            +0.0%     512.00        slabinfo.RAW.active_objs
     16.00            +0.0%      16.00            +0.0%      16.00        slabinfo.RAW.active_slabs
    512.00            +0.0%     512.00            +0.0%     512.00        slabinfo.RAW.num_objs
     16.00            +0.0%      16.00            +0.0%      16.00        slabinfo.RAW.num_slabs
    264.33 ±  3%      +0.0%     264.33 ±  3%      +0.0%     264.33 ±  3%  slabinfo.RAWv6.active_objs
     10.17 ±  3%      +0.0%      10.17 ±  3%      +0.0%      10.17 ±  3%  slabinfo.RAWv6.active_slabs
    264.33 ±  3%      +0.0%     264.33 ±  3%      +0.0%     264.33 ±  3%  slabinfo.RAWv6.num_objs
     10.17 ±  3%      +0.0%      10.17 ±  3%      +0.0%      10.17 ±  3%  slabinfo.RAWv6.num_slabs
     56.00            -4.2%      53.67 ±  9%      -4.2%      53.67 ±  9%  slabinfo.TCP.active_objs
      4.00            -4.2%       3.83 ±  9%      -4.2%       3.83 ±  9%  slabinfo.TCP.active_slabs
     56.00            -4.2%      53.67 ±  9%      -4.2%      53.67 ±  9%  slabinfo.TCP.num_objs
      4.00            -4.2%       3.83 ±  9%      -4.2%       3.83 ±  9%  slabinfo.TCP.num_slabs
     39.00            -5.6%      36.83 ± 13%      +0.0%      39.00        slabinfo.TCPv6.active_objs
      3.00            -5.6%       2.83 ± 13%      +0.0%       3.00        slabinfo.TCPv6.active_slabs
     39.00            -5.6%      36.83 ± 13%      +0.0%      39.00        slabinfo.TCPv6.num_objs
      3.00            -5.6%       2.83 ± 13%      +0.0%       3.00        slabinfo.TCPv6.num_slabs
    157.00            -3.8%     151.00 ± 12%      +1.3%     159.00 ±  5%  slabinfo.UDPv6.active_objs
      6.00            -8.3%       5.50 ± 13%      -2.8%       5.83 ±  6%  slabinfo.UDPv6.active_slabs
    157.00            -3.8%     151.00 ± 12%      +1.3%     159.00 ±  5%  slabinfo.UDPv6.num_objs
      6.00            -8.3%       5.50 ± 13%      -2.8%       5.83 ±  6%  slabinfo.UDPv6.num_slabs
     40958            +4.2%      42682 ±  2%      +5.9%      43372 ±  2%  slabinfo.anon_vma.active_objs
    889.83            +4.2%     927.50 ±  2%      +5.9%     942.33 ±  2%  slabinfo.anon_vma.active_slabs
     40958            +4.2%      42682 ±  2%      +5.9%      43372 ±  2%  slabinfo.anon_vma.num_objs
    889.83            +4.2%     927.50 ±  2%      +5.9%     942.33 ±  2%  slabinfo.anon_vma.num_slabs
     88795            +8.9%      96715 ±  2%     +11.0%      98562        slabinfo.anon_vma_chain.active_objs
      1387            +8.9%       1510 ±  2%     +11.0%       1539        slabinfo.anon_vma_chain.active_slabs
     88795            +8.9%      96715 ±  2%     +11.0%      98562        slabinfo.anon_vma_chain.num_objs
      1387            +8.9%       1510 ±  2%     +11.0%       1539        slabinfo.anon_vma_chain.num_slabs
    140.00 ±  8%      -9.5%     126.67 ± 14%      -7.1%     130.00 ±  7%  slabinfo.bdev_cache.active_objs
      7.00 ±  8%      -9.5%       6.33 ± 14%      -7.1%       6.50 ±  7%  slabinfo.bdev_cache.active_slabs
    140.00 ±  8%      -9.5%     126.67 ± 14%      -7.1%     130.00 ±  7%  slabinfo.bdev_cache.num_objs
      7.00 ±  8%      -9.5%       6.33 ± 14%      -7.1%       6.50 ±  7%  slabinfo.bdev_cache.num_slabs
    144.00 ±  6%     +11.1%     160.00 ±  5%      -1.9%     141.33 ± 17%  slabinfo.biovec-128.active_objs
      9.00 ±  6%     +11.1%      10.00 ±  5%      -1.9%       8.83 ± 17%  slabinfo.biovec-128.active_slabs
    144.00 ±  6%     +11.1%     160.00 ±  5%      -1.9%     141.33 ± 17%  slabinfo.biovec-128.num_objs
      9.00 ±  6%     +11.1%      10.00 ±  5%      -1.9%       8.83 ± 17%  slabinfo.biovec-128.num_slabs
    384.00 ±  4%      +2.8%     394.67 ± 10%      +0.0%     384.00 ±  8%  slabinfo.biovec-64.active_objs
     12.00 ±  4%      +2.8%      12.33 ± 10%      +0.0%      12.00 ±  8%  slabinfo.biovec-64.active_slabs
    384.00 ±  4%      +2.8%     394.67 ± 10%      +0.0%     384.00 ±  8%  slabinfo.biovec-64.num_objs
     12.00 ±  4%      +2.8%      12.33 ± 10%      +0.0%      12.00 ±  8%  slabinfo.biovec-64.num_slabs
     57.33 ±  5%      +0.0%      57.33 ±  5%      +2.3%      58.67 ±  6%  slabinfo.biovec-max.active_objs
      7.17 ±  5%      +0.0%       7.17 ±  5%      +2.3%       7.33 ±  6%  slabinfo.biovec-max.active_slabs
     57.33 ±  5%      +0.0%      57.33 ±  5%      +2.3%      58.67 ±  6%  slabinfo.biovec-max.num_objs
      7.17 ±  5%      +0.0%       7.17 ±  5%      +2.3%       7.33 ±  6%  slabinfo.biovec-max.num_slabs
    624.00 ±  7%      -2.1%     611.00 ±  4%      +0.0%     624.00        slabinfo.buffer_head.active_objs
      8.00 ±  7%      -2.1%       7.83 ±  4%      +0.0%       8.00        slabinfo.buffer_head.active_slabs
    624.00 ±  7%      -2.1%     611.00 ±  4%      +0.0%     624.00        slabinfo.buffer_head.num_objs
      8.00 ±  7%      -2.1%       7.83 ±  4%      +0.0%       8.00        slabinfo.buffer_head.num_slabs
     13228            -0.4%      13181            -0.5%      13160        slabinfo.cred_jar.active_objs
    314.17            -0.2%     313.50            -0.3%     313.17        slabinfo.cred_jar.active_slabs
     13228            -0.4%      13181            -0.5%      13160        slabinfo.cred_jar.num_objs
    314.17            -0.2%     313.50            -0.3%     313.17        slabinfo.cred_jar.num_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.dax_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dax_cache.active_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.dax_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dax_cache.num_slabs
    141406           +17.5%     166221           +17.0%     165504        slabinfo.dentry.active_objs
      3369           +17.6%       3961           +17.0%       3944        slabinfo.dentry.active_slabs
    141538           +17.6%     166421           +17.1%     165679        slabinfo.dentry.num_objs
      3369           +17.6%       3961           +17.0%       3944        slabinfo.dentry.num_slabs
     30.00            +0.0%      30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.active_slabs
     30.00            +0.0%      30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.num_slabs
      1600 ± 23%      -6.1%       1502 ±  6%      +5.2%       1683 ± 13%  slabinfo.dmaengine-unmap-16.active_objs
     37.67 ± 23%      -6.2%      35.33 ±  6%      +5.3%      39.67 ± 13%  slabinfo.dmaengine-unmap-16.active_slabs
      1600 ± 23%      -6.1%       1502 ±  6%      +5.2%       1683 ± 13%  slabinfo.dmaengine-unmap-16.num_objs
     37.67 ± 23%      -6.2%      35.33 ±  6%      +5.3%      39.67 ± 13%  slabinfo.dmaengine-unmap-16.num_slabs
     15.00            +0.0%      15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.active_slabs
     15.00            +0.0%      15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.num_slabs
     53326 ±  4%      -4.1%      51141 ±  3%      +0.7%      53675 ±  3%  slabinfo.ep_head.active_objs
    208.17 ±  4%      -4.2%     199.50 ±  3%      +0.6%     209.33 ±  3%  slabinfo.ep_head.active_slabs
     53326 ±  4%      -4.1%      51141 ±  3%      +0.7%      53675 ±  3%  slabinfo.ep_head.num_objs
    208.17 ±  4%      -4.2%     199.50 ±  3%      +0.6%     209.33 ±  3%  slabinfo.ep_head.num_slabs
    306.00            +0.0%     306.00            +0.0%     306.00        slabinfo.ext4_extent_status.active_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.ext4_extent_status.active_slabs
    306.00            +0.0%     306.00            +0.0%     306.00        slabinfo.ext4_extent_status.num_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.ext4_extent_status.num_slabs
    784.00            +0.0%     784.00            +0.0%     784.00        slabinfo.ext4_groupinfo_4k.active_objs
     14.00            +0.0%      14.00            +0.0%      14.00        slabinfo.ext4_groupinfo_4k.active_slabs
    784.00            +0.0%     784.00            +0.0%     784.00        slabinfo.ext4_groupinfo_4k.num_objs
     14.00            +0.0%      14.00            +0.0%      14.00        slabinfo.ext4_groupinfo_4k.num_slabs
     81.00            +0.0%      81.00            +0.0%      81.00        slabinfo.ext4_inode_cache.active_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.ext4_inode_cache.active_slabs
     81.00            +0.0%      81.00            +0.0%      81.00        slabinfo.ext4_inode_cache.num_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.ext4_inode_cache.num_slabs
    128.00            +0.0%     128.00            +0.0%     128.00        slabinfo.ext4_pending_reservation.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ext4_pending_reservation.active_slabs
    128.00            +0.0%     128.00            +0.0%     128.00        slabinfo.ext4_pending_reservation.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ext4_pending_reservation.num_slabs
    102.00            +0.0%     102.00            +0.0%     102.00        slabinfo.ext4_system_zone.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ext4_system_zone.active_slabs
    102.00            +0.0%     102.00            +0.0%     102.00        slabinfo.ext4_system_zone.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ext4_system_zone.num_slabs
      2778 ± 10%     +30.1%       3614 ±  3%     +25.1%       3474 ±  2%  slabinfo.file_lock_cache.active_objs
     36.67 ±  9%     +30.5%      47.83 ±  3%     +24.5%      45.67 ±  3%  slabinfo.file_lock_cache.active_slabs
      2778 ± 10%     +30.1%       3614 ±  3%     +25.1%       3474 ±  2%  slabinfo.file_lock_cache.num_objs
     36.67 ±  9%     +30.5%      47.83 ±  3%     +24.5%      45.67 ±  3%  slabinfo.file_lock_cache.num_slabs
     11920            +1.1%      12057            +0.0%      11922        slabinfo.files_cache.active_objs
    258.50            +1.2%     261.50            +0.1%     258.83        slabinfo.files_cache.active_slabs
     11920            +1.1%      12057            +0.0%      11922        slabinfo.files_cache.num_objs
    258.50            +1.2%     261.50            +0.1%     258.83        slabinfo.files_cache.num_slabs
     68085 ±  4%     +11.3%      75771 ±  2%     +11.2%      75702 ±  2%  slabinfo.filp.active_objs
      1064 ±  4%     +11.4%       1185 ±  2%     +11.4%       1185 ±  2%  slabinfo.filp.active_slabs
     68120 ±  4%     +11.4%      75874 ±  2%     +11.4%      75867 ±  2%  slabinfo.filp.num_objs
      1064 ±  4%     +11.4%       1185 ±  2%     +11.4%       1185 ±  2%  slabinfo.filp.num_slabs
      3555 ±  9%      -5.7%       3352 ±  8%      +5.2%       3740 ±  9%  slabinfo.fsnotify_mark_connector.active_objs
     27.50 ±  9%      -5.5%      26.00 ±  8%      +4.2%      28.67 ±  9%  slabinfo.fsnotify_mark_connector.active_slabs
      3555 ±  9%      -5.7%       3352 ±  8%      +5.2%       3740 ±  9%  slabinfo.fsnotify_mark_connector.num_objs
     27.50 ±  9%      -5.5%      26.00 ±  8%      +4.2%      28.67 ±  9%  slabinfo.fsnotify_mark_connector.num_slabs
     13812            +0.7%      13911            +0.8%      13925        slabinfo.ftrace_event_field.active_objs
    162.50            +0.7%     163.67            +0.8%     163.83        slabinfo.ftrace_event_field.active_slabs
     13812            +0.7%      13911            +0.8%      13925        slabinfo.ftrace_event_field.num_objs
    162.50            +0.7%     163.67            +0.8%     163.83        slabinfo.ftrace_event_field.num_slabs
    104.00            +0.0%     104.00            +0.0%     104.00        slabinfo.hugetlbfs_inode_cache.active_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.active_slabs
    104.00            +0.0%     104.00            +0.0%     104.00        slabinfo.hugetlbfs_inode_cache.num_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.num_slabs
     82023           +25.5%     102964           +25.7%     103077        slabinfo.inode_cache.active_objs
      1521           +25.6%       1911           +25.9%       1915        slabinfo.inode_cache.active_slabs
     82196           +25.6%     103260           +25.9%     103459        slabinfo.inode_cache.num_objs
      1521           +25.6%       1911           +25.9%       1915        slabinfo.inode_cache.num_slabs
    256.00            +0.0%     256.00            +0.0%     256.00        slabinfo.jbd2_revoke_table_s.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.jbd2_revoke_table_s.active_slabs
    256.00            +0.0%     256.00            +0.0%     256.00        slabinfo.jbd2_revoke_table_s.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.jbd2_revoke_table_s.num_slabs
    114193            +0.2%     114461            +0.3%     114536        slabinfo.kernfs_node_cache.active_objs
      1784            +0.2%       1788            +0.3%       1789        slabinfo.kernfs_node_cache.active_slabs
    114193            +0.2%     114461            +0.3%     114536        slabinfo.kernfs_node_cache.num_objs
      1784            +0.2%       1788            +0.3%       1789        slabinfo.kernfs_node_cache.num_slabs
      4706 ±  9%     +67.5%       7882 ±  5%     +73.9%       8186 ±  5%  slabinfo.khugepaged_mm_slot.active_objs
     63.67 ±  9%     +68.1%     107.00 ±  5%     +74.9%     111.33 ±  4%  slabinfo.khugepaged_mm_slot.active_slabs
      4706 ±  9%     +67.5%       7882 ±  5%     +73.9%       8186 ±  5%  slabinfo.khugepaged_mm_slot.num_objs
     63.67 ±  9%     +68.1%     107.00 ±  5%     +74.9%     111.33 ±  4%  slabinfo.khugepaged_mm_slot.num_slabs
     18844            -0.1%      18816            +0.2%      18881        slabinfo.kmalloc-128.active_objs
    295.83            -0.2%     295.17            +0.0%     295.83        slabinfo.kmalloc-128.active_slabs
     18935            -0.2%      18900            +0.0%      18943        slabinfo.kmalloc-128.num_objs
    295.83            -0.2%     295.17            +0.0%     295.83        slabinfo.kmalloc-128.num_slabs
     73896            +0.4%      74175            +0.9%      74536        slabinfo.kmalloc-16.active_objs
    288.67            +0.4%     289.83            +0.9%     291.17        slabinfo.kmalloc-16.active_slabs
     73898            +0.4%      74197            +0.9%      74538        slabinfo.kmalloc-16.num_objs
    288.67            +0.4%     289.83            +0.9%     291.17        slabinfo.kmalloc-16.num_slabs
     12240            -0.1%      12227            +0.0%      12242        slabinfo.kmalloc-192.active_objs
    295.00            -0.1%     294.67            -0.1%     294.83        slabinfo.kmalloc-192.active_slabs
     12390            -0.1%      12376            -0.1%      12383        slabinfo.kmalloc-192.num_objs
    295.00            -0.1%     294.67            -0.1%     294.83        slabinfo.kmalloc-192.num_slabs
     11273            +0.3%      11311            +0.4%      11313        slabinfo.kmalloc-1k.active_objs
    355.00            +0.3%     356.17            +0.1%     355.50        slabinfo.kmalloc-1k.active_slabs
     11370            +0.4%      11411            +0.1%      11386        slabinfo.kmalloc-1k.num_objs
    355.00            +0.3%     356.17            +0.1%     355.50        slabinfo.kmalloc-1k.num_slabs
     20671            +0.1%      20684            +0.1%      20691        slabinfo.kmalloc-256.active_objs
    328.17            -0.3%     327.33            +0.5%     329.83        slabinfo.kmalloc-256.active_slabs
     21017            -0.3%      20949            +0.5%      21123        slabinfo.kmalloc-256.num_objs
    328.17            -0.3%     327.33            +0.5%     329.83        slabinfo.kmalloc-256.num_slabs
     11373            -0.2%      11354            +0.4%      11413        slabinfo.kmalloc-2k.active_objs
    712.83            -0.1%     712.33            +0.3%     714.83        slabinfo.kmalloc-2k.active_slabs
     11410            -0.0%      11405            +0.3%      11447        slabinfo.kmalloc-2k.num_objs
    712.83            -0.1%     712.33            +0.3%     714.83        slabinfo.kmalloc-2k.num_slabs
     75291 ±  2%      -2.1%      73709            -2.1%      73706        slabinfo.kmalloc-32.active_objs
    588.67 ±  2%      -2.2%     576.00            -2.1%     576.33        slabinfo.kmalloc-32.active_slabs
     75376 ±  2%      -2.1%      73784            -2.0%      73857        slabinfo.kmalloc-32.num_objs
    588.67 ±  2%      -2.2%     576.00            -2.1%     576.33        slabinfo.kmalloc-32.num_slabs
      3326            +0.4%       3339            +0.8%       3352        slabinfo.kmalloc-4k.active_objs
    419.50            +0.6%     422.17            +0.9%     423.33        slabinfo.kmalloc-4k.active_slabs
      3358            +0.6%       3379            +0.9%       3388        slabinfo.kmalloc-4k.num_objs
    419.50            +0.6%     422.17            +0.9%     423.33        slabinfo.kmalloc-4k.num_slabs
     36407 ±  2%      -2.8%      35395            -1.3%      35945 ±  2%  slabinfo.kmalloc-512.active_objs
    572.00 ±  2%      -2.7%     556.33 ±  2%      -1.2%     565.17 ±  3%  slabinfo.kmalloc-512.active_slabs
     36644 ±  2%      -2.7%      35650            -1.2%      36215 ±  3%  slabinfo.kmalloc-512.num_objs
    572.00 ±  2%      -2.7%     556.33 ±  2%      -1.2%     565.17 ±  3%  slabinfo.kmalloc-512.num_slabs
     35497            +1.6%      36064            +2.7%      36454        slabinfo.kmalloc-64.active_objs
    557.67            +1.6%     566.50            +2.5%     571.83        slabinfo.kmalloc-64.active_slabs
     35700            +1.6%      36279            +2.6%      36618        slabinfo.kmalloc-64.num_objs
    557.67            +1.6%     566.50            +2.5%     571.83        slabinfo.kmalloc-64.num_slabs
    138700            -0.1%     138594            -0.3%     138330        slabinfo.kmalloc-8.active_objs
    271.33            +0.0%     271.33            -0.1%     271.17        slabinfo.kmalloc-8.active_slabs
    139005            +0.1%     139082            -0.1%     138849        slabinfo.kmalloc-8.num_objs
    271.33            +0.0%     271.33            -0.1%     271.17        slabinfo.kmalloc-8.num_slabs
      1445            -0.3%       1440            -0.1%       1444        slabinfo.kmalloc-8k.active_objs
    364.17            -0.3%     363.17            -0.1%     363.83        slabinfo.kmalloc-8k.active_slabs
      1459            -0.3%       1455            -0.1%       1458        slabinfo.kmalloc-8k.num_objs
    364.17            -0.3%     363.17            -0.1%     363.83        slabinfo.kmalloc-8k.num_slabs
     21358 ±  2%      -1.8%      20981 ±  3%      -1.3%      21081 ±  2%  slabinfo.kmalloc-96.active_objs
    508.50 ±  2%      -1.7%     499.83 ±  3%      -1.2%     502.33 ±  2%  slabinfo.kmalloc-96.active_slabs
     21383 ±  2%      -1.7%      21020 ±  3%      -1.2%      21117 ±  2%  slabinfo.kmalloc-96.num_objs
    508.50 ±  2%      -1.7%     499.83 ±  3%      -1.2%     502.33 ±  2%  slabinfo.kmalloc-96.num_slabs
    554.67 ± 14%      -7.7%     512.00 ± 19%      -1.9%     544.00 ±  5%  slabinfo.kmalloc-rcl-128.active_objs
      8.67 ± 14%      -7.7%       8.00 ± 19%      -1.9%       8.50 ±  5%  slabinfo.kmalloc-rcl-128.active_slabs
    554.67 ± 14%      -7.7%     512.00 ± 19%      -1.9%     544.00 ±  5%  slabinfo.kmalloc-rcl-128.num_objs
      8.67 ± 14%      -7.7%       8.00 ± 19%      -1.9%       8.50 ±  5%  slabinfo.kmalloc-rcl-128.num_slabs
    294.00 ±  8%      -9.5%     266.00 ± 14%      -9.5%     266.00 ±  7%  slabinfo.kmalloc-rcl-192.active_objs
      7.00 ±  8%      -9.5%       6.33 ± 14%      -9.5%       6.33 ±  7%  slabinfo.kmalloc-rcl-192.active_slabs
    294.00 ±  8%      -9.5%     266.00 ± 14%      -9.5%     266.00 ±  7%  slabinfo.kmalloc-rcl-192.num_objs
      7.00 ±  8%      -9.5%       6.33 ± 14%      -9.5%       6.33 ±  7%  slabinfo.kmalloc-rcl-192.num_slabs
    192.00            +0.0%     192.00            +0.0%     192.00        slabinfo.kmalloc-rcl-256.active_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.kmalloc-rcl-256.active_slabs
    192.00            +0.0%     192.00            +0.0%     192.00        slabinfo.kmalloc-rcl-256.num_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.kmalloc-rcl-256.num_slabs
     18025            +0.5%      18123            +0.6%      18133        slabinfo.kmalloc-rcl-512.active_objs
    281.17            +0.6%     282.83            +0.7%     283.17        slabinfo.kmalloc-rcl-512.active_slabs
     18025            +0.6%      18133            +0.7%      18156        slabinfo.kmalloc-rcl-512.num_objs
    281.17            +0.6%     282.83            +0.7%     283.17        slabinfo.kmalloc-rcl-512.num_slabs
      5600 ±  8%     +61.9%       9069           +69.4%       9485 ±  2%  slabinfo.kmalloc-rcl-64.active_objs
     87.00 ±  8%     +62.3%     141.17           +69.9%     147.83 ±  2%  slabinfo.kmalloc-rcl-64.active_slabs
      5600 ±  8%     +61.9%       9069           +69.4%       9485 ±  2%  slabinfo.kmalloc-rcl-64.num_objs
     87.00 ±  8%     +62.3%     141.17           +69.9%     147.83 ±  2%  slabinfo.kmalloc-rcl-64.num_slabs
      2132 ± 11%     +10.1%       2348 ±  6%     +21.6%       2593 ±  4%  slabinfo.kmalloc-rcl-96.active_objs
     50.50 ± 11%     +10.2%      55.67 ±  6%     +21.5%      61.33 ±  5%  slabinfo.kmalloc-rcl-96.active_slabs
      2132 ± 11%     +10.1%       2348 ±  6%     +21.6%       2593 ±  4%  slabinfo.kmalloc-rcl-96.num_objs
     50.50 ± 11%     +10.2%      55.67 ±  6%     +21.5%      61.33 ±  5%  slabinfo.kmalloc-rcl-96.num_slabs
    586.67 ±  9%     +18.2%     693.33 ±  9%     +14.5%     672.00 ± 11%  slabinfo.kmem_cache.active_objs
      9.17 ±  9%     +18.2%      10.83 ±  9%     +14.5%      10.50 ± 11%  slabinfo.kmem_cache.active_slabs
    586.67 ±  9%     +18.2%     693.33 ±  9%     +14.5%     672.00 ± 11%  slabinfo.kmem_cache.num_objs
      9.17 ±  9%     +18.2%      10.83 ±  9%     +14.5%      10.50 ± 11%  slabinfo.kmem_cache.num_slabs
    733.67 ±  7%     +14.5%     840.33 ±  8%     +11.6%     819.00 ±  9%  slabinfo.kmem_cache_node.active_objs
     12.17 ±  7%     +13.7%      13.83 ±  7%     +11.0%      13.50 ±  9%  slabinfo.kmem_cache_node.active_slabs
    778.67 ±  7%     +13.7%     885.33 ±  7%     +11.0%     864.00 ±  9%  slabinfo.kmem_cache_node.num_objs
     12.17 ±  7%     +13.7%      13.83 ±  7%     +11.0%      13.50 ±  9%  slabinfo.kmem_cache_node.num_slabs
     48159            -0.5%      47931            -0.1%      48118        slabinfo.lsm_file_cache.active_objs
    282.50            -0.5%     281.17            -0.1%     282.33        slabinfo.lsm_file_cache.active_slabs
     48159            -0.5%      47931            -0.1%      48118        slabinfo.lsm_file_cache.num_objs
    282.50            -0.5%     281.17            -0.1%     282.33        slabinfo.lsm_file_cache.num_slabs
      7934            +0.1%       7940            -0.4%       7904        slabinfo.mm_struct.active_objs
    263.83            +0.2%     264.33            -0.4%     262.83        slabinfo.mm_struct.active_slabs
      7934            +0.1%       7940            -0.4%       7904        slabinfo.mm_struct.num_objs
    263.83            +0.2%     264.33            -0.4%     262.83        slabinfo.mm_struct.num_slabs
    900.00 ± 10%     +11.4%       1002 ±  3%     +12.3%       1010 ±  4%  slabinfo.mnt_cache.active_objs
     16.67 ± 10%     +13.0%      18.83 ±  4%     +13.0%      18.83 ±  4%  slabinfo.mnt_cache.active_slabs
    900.00 ± 10%     +11.4%       1002 ±  3%     +12.3%       1010 ±  4%  slabinfo.mnt_cache.num_objs
     16.67 ± 10%     +13.0%      18.83 ±  4%     +13.0%      18.83 ±  4%  slabinfo.mnt_cache.num_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.active_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.num_slabs
      2048            +0.1%       2049            +0.3%       2054        slabinfo.names_cache.active_objs
    256.00            +0.1%     256.17            +0.3%     256.83        slabinfo.names_cache.active_slabs
      2048            +0.1%       2049            +0.3%       2054        slabinfo.names_cache.num_objs
    256.00            +0.1%     256.17            +0.3%     256.83        slabinfo.names_cache.num_slabs
     36.00            +0.0%      36.00            +0.0%      36.00        slabinfo.nfs_read_data.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.nfs_read_data.active_slabs
     36.00            +0.0%      36.00            +0.0%      36.00        slabinfo.nfs_read_data.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.nfs_read_data.num_slabs
    310.00            +0.0%     310.00            +0.0%     310.00        slabinfo.numa_policy.active_objs
      5.00            +0.0%       5.00            +0.0%       5.00        slabinfo.numa_policy.active_slabs
    310.00            +0.0%     310.00            +0.0%     310.00        slabinfo.numa_policy.num_objs
      5.00            +0.0%       5.00            +0.0%       5.00        slabinfo.numa_policy.num_slabs
     20515 ±  2%     +14.3%      23443           +13.5%      23283        slabinfo.pde_opener.active_objs
    200.67 ±  2%     +14.3%     229.33           +13.5%     227.83        slabinfo.pde_opener.active_slabs
     20515 ±  2%     +14.3%      23443           +13.5%      23283        slabinfo.pde_opener.num_objs
    200.67 ±  2%     +14.3%     229.33           +13.5%     227.83        slabinfo.pde_opener.num_slabs
     18362            +0.4%      18431            +0.6%      18477        slabinfo.pid.active_objs
    286.17            +0.5%     287.67            +0.8%     288.33        slabinfo.pid.active_slabs
     18362            +0.4%      18431            +0.6%      18477        slabinfo.pid.num_objs
    286.17            +0.5%     287.67            +0.8%     288.33        slabinfo.pid.num_slabs
      3360 ±  5%      -3.3%       3251 ±  5%      -2.7%       3271 ±  3%  slabinfo.pool_workqueue.active_objs
     52.50 ±  4%      -3.2%      50.83 ±  6%      -2.9%      51.00 ±  3%  slabinfo.pool_workqueue.active_slabs
      3381 ±  4%      -2.9%       3285 ±  6%      -2.5%       3297 ±  3%  slabinfo.pool_workqueue.num_objs
     52.50 ±  4%      -3.2%      50.83 ±  6%      -2.9%      51.00 ±  3%  slabinfo.pool_workqueue.num_slabs
      1022 ±  4%      +0.0%       1022 ±  3%      +0.7%       1029 ±  3%  slabinfo.proc_dir_entry.active_objs
     24.33 ±  4%      +0.0%      24.33 ±  3%      +0.7%      24.50 ±  3%  slabinfo.proc_dir_entry.active_slabs
      1022 ±  4%      +0.0%       1022 ±  3%      +0.7%       1029 ±  3%  slabinfo.proc_dir_entry.num_objs
     24.33 ±  4%      +0.0%      24.33 ±  3%      +0.7%      24.50 ±  3%  slabinfo.proc_dir_entry.num_slabs
     30217            -0.9%      29933            +0.2%      30278        slabinfo.proc_inode_cache.active_objs
    629.00            -0.9%     623.50            +0.2%     630.33        slabinfo.proc_inode_cache.active_slabs
     30221            -0.9%      29940            +0.2%      30282        slabinfo.proc_inode_cache.num_objs
    629.00            -0.9%     623.50            +0.2%     630.33        slabinfo.proc_inode_cache.num_slabs
     25478           +45.9%      37166           +46.0%      37192        slabinfo.radix_tree_node.active_objs
    454.67           +45.9%     663.17           +46.0%     663.67        slabinfo.radix_tree_node.active_slabs
     25478           +45.9%      37166           +46.0%      37192        slabinfo.radix_tree_node.num_objs
    454.67           +45.9%     663.17           +46.0%     663.67        slabinfo.radix_tree_node.num_slabs
     32.00            +0.0%      32.00            +0.0%      32.00        slabinfo.request_queue.active_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.request_queue.active_slabs
     32.00            +0.0%      32.00            +0.0%      32.00        slabinfo.request_queue.num_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.request_queue.num_slabs
     51.00            +0.0%      51.00            +0.0%      51.00        slabinfo.rpc_inode_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.active_slabs
     51.00            +0.0%      51.00            +0.0%      51.00        slabinfo.rpc_inode_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.num_slabs
    448.00            +0.0%     448.00            +0.0%     448.00        slabinfo.scsi_sense_cache.active_objs
      7.00            +0.0%       7.00            +0.0%       7.00        slabinfo.scsi_sense_cache.active_slabs
    448.00            +0.0%     448.00            +0.0%     448.00        slabinfo.scsi_sense_cache.num_objs
      7.00            +0.0%       7.00            +0.0%       7.00        slabinfo.scsi_sense_cache.num_slabs
     17408            +0.0%      17408            +0.0%      17408        slabinfo.seq_file.active_objs
    256.00            +0.0%     256.00            +0.0%     256.00        slabinfo.seq_file.active_slabs
     17408            +0.0%      17408            +0.0%      17408        slabinfo.seq_file.num_objs
    256.00            +0.0%     256.00            +0.0%     256.00        slabinfo.seq_file.num_slabs
     11297            -1.5%      11132            +1.0%      11414 ±  2%  slabinfo.shmem_inode_cache.active_objs
    245.00            -1.4%     241.50            +1.0%     247.50 ±  2%  slabinfo.shmem_inode_cache.active_slabs
     11297            -1.5%      11132            +1.0%      11414 ±  2%  slabinfo.shmem_inode_cache.num_objs
    245.00            -1.4%     241.50            +1.0%     247.50 ±  2%  slabinfo.shmem_inode_cache.num_slabs
      5827            +1.4%       5907            +0.8%       5872        slabinfo.sighand_cache.active_objs
    387.83            +1.4%     393.33            +0.9%     391.17        slabinfo.sighand_cache.active_slabs
      5827            +1.4%       5907            +0.8%       5872        slabinfo.sighand_cache.num_objs
    387.83            +1.4%     393.33            +0.9%     391.17        slabinfo.sighand_cache.num_slabs
      9236            +0.9%       9322            +0.0%       9239        slabinfo.signal_cache.active_objs
    329.17            +1.0%     332.50            +0.2%     329.67        slabinfo.signal_cache.active_slabs
      9236            +0.9%       9322            +0.0%       9239        slabinfo.signal_cache.num_objs
    329.17            +1.0%     332.50            +0.2%     329.67        slabinfo.signal_cache.num_slabs
    682.67 ± 12%      +4.7%     714.67 ± 13%      +0.0%     682.67 ±  8%  slabinfo.skbuff_fclone_cache.active_objs
     10.67 ± 12%      +4.7%      11.17 ± 13%      +0.0%      10.67 ±  8%  slabinfo.skbuff_fclone_cache.active_slabs
    682.67 ± 12%      +4.7%     714.67 ± 13%      +0.0%     682.67 ±  8%  slabinfo.skbuff_fclone_cache.num_objs
     10.67 ± 12%      +4.7%      11.17 ± 13%      +0.0%      10.67 ±  8%  slabinfo.skbuff_fclone_cache.num_slabs
     18066 ±  2%      +3.2%      18639 ±  2%      +0.4%      18133        slabinfo.skbuff_head_cache.active_objs
    281.83 ±  2%      +3.3%     291.17 ±  2%      +0.5%     283.33        slabinfo.skbuff_head_cache.active_slabs
     18066 ±  2%      +3.2%      18639 ±  2%      +0.4%      18133        slabinfo.skbuff_head_cache.num_objs
    281.83 ±  2%      +3.3%     291.17 ±  2%      +0.5%     283.33        slabinfo.skbuff_head_cache.num_slabs
      5847 ±  2%     +11.1%       6496 ±  2%     +16.6%       6816 ±  2%  slabinfo.sock_inode_cache.active_objs
    149.50 ±  3%     +10.9%     165.83 ±  2%     +16.5%     174.17 ±  2%  slabinfo.sock_inode_cache.active_slabs
      5847 ±  2%     +11.1%       6496 ±  2%     +16.6%       6816 ±  2%  slabinfo.sock_inode_cache.num_objs
    149.50 ±  3%     +10.9%     165.83 ±  2%     +16.5%     174.17 ±  2%  slabinfo.sock_inode_cache.num_slabs
     15147            +0.8%      15266            +0.4%      15213        slabinfo.task_delay_info.active_objs
    296.33            +0.8%     298.67            +0.6%     298.00        slabinfo.task_delay_info.active_slabs
     15147            +0.8%      15266            +0.4%      15213        slabinfo.task_delay_info.num_objs
    296.33            +0.8%     298.67            +0.6%     298.00        slabinfo.task_delay_info.num_slabs
      1540 ±  4%      -6.5%       1440 ±  9%      -4.3%       1474 ±  7%  slabinfo.task_group.active_objs
     33.17 ±  5%      -7.0%      30.83 ±  9%      -5.0%      31.50 ±  7%  slabinfo.task_group.active_slabs
      1540 ±  4%      -6.5%       1440 ±  9%      -4.3%       1474 ±  7%  slabinfo.task_group.num_objs
     33.17 ±  5%      -7.0%      30.83 ±  9%      -5.0%      31.50 ±  7%  slabinfo.task_group.num_slabs
      2845            +1.1%       2877            +1.0%       2873        slabinfo.task_struct.active_objs
      2846            +1.1%       2879            +1.0%       2875        slabinfo.task_struct.active_slabs
      2846            +1.1%       2879            +1.0%       2875        slabinfo.task_struct.num_objs
      2846            +1.1%       2879            +1.0%       2875        slabinfo.task_struct.num_slabs
    148.00           +86.3%     275.67 ±  4%     +92.6%     285.00        slabinfo.taskstats.active_objs
      3.00           +88.9%       5.67 ±  8%    +100.0%       6.00        slabinfo.taskstats.active_slabs
    148.00           +86.3%     275.67 ±  4%     +92.6%     285.00        slabinfo.taskstats.num_objs
      3.00           +88.9%       5.67 ±  8%    +100.0%       6.00        slabinfo.taskstats.num_slabs
     10240 ±  4%      +3.9%      10640 ±  4%      +1.5%      10398 ±  3%  slabinfo.trace_event_file.active_objs
    222.17 ±  4%      +4.0%     231.00 ±  4%      +1.6%     225.67 ±  3%  slabinfo.trace_event_file.active_slabs
     10240 ±  4%      +3.9%      10640 ±  4%      +1.5%      10398 ±  3%  slabinfo.trace_event_file.num_objs
    222.17 ±  4%      +4.0%     231.00 ±  4%      +1.6%     225.67 ±  3%  slabinfo.trace_event_file.num_slabs
     66.00            +0.0%      66.00            +0.0%      66.00        slabinfo.tw_sock_TCP.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.active_slabs
     66.00            +0.0%      66.00            +0.0%      66.00        slabinfo.tw_sock_TCP.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.num_slabs
     99306            +1.7%     101043 ±  2%      +4.5%     103805 ±  2%  slabinfo.vm_area_struct.active_objs
      2483            +1.8%       2526 ±  2%      +4.5%       2595 ±  2%  slabinfo.vm_area_struct.active_slabs
     99347            +1.7%     101084 ±  2%      +4.5%     103840 ±  2%  slabinfo.vm_area_struct.num_objs
      2483            +1.8%       2526 ±  2%      +4.5%       2595 ±  2%  slabinfo.vm_area_struct.num_slabs
     22454            -0.4%      22360            +0.1%      22481        slabinfo.vmap_area.active_objs
    355.50            -0.5%     353.83            +0.0%     355.50        slabinfo.vmap_area.active_slabs
     22765            -0.5%      22660            -0.0%      22761        slabinfo.vmap_area.num_objs
    355.50            -0.5%     353.83            +0.0%     355.50        slabinfo.vmap_area.num_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.xfrm_state.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfrm_state.active_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.xfrm_state.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfrm_state.num_slabs
     74.77 ±  2%      -1.8       72.97            -0.9       73.90        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     51.51 ±  2%      -1.8       49.74            -0.7       50.84        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     75.96 ±  2%      -1.7       74.23            -0.7       75.26        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     47.26 ±  3%      -1.7       45.53            -0.9       46.36        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
     30.02 ±  3%      -1.6       28.43            -0.9       29.12 ±  2%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
     31.50 ±  3%      -1.6       29.92            -0.9       30.62 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
     22.38 ±  2%      -1.2       21.21 ±  2%      -0.4       22.02 ±  2%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     13.18 ±  2%      -0.7       12.44 ±  5%      -0.1       13.08 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     90.32 ±  2%      -0.7       89.58            -0.3       90.06        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     90.07 ±  2%      -0.7       89.34            -0.4       89.66        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     90.07 ±  2%      -0.7       89.34            -0.4       89.66        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     89.91 ±  2%      -0.7       89.22            -0.4       89.53        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      7.60 ±  6%      -0.5        7.14 ± 13%      -0.1        7.47 ±  5%  perf-profile.calltrace.cycles-pp.rcu_idle_exit.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      7.33 ±  7%      -0.4        6.88 ± 13%      -0.1        7.20 ±  5%  perf-profile.calltrace.cycles-pp.rcu_eqs_exit.rcu_idle_exit.cpuidle_enter_state.cpuidle_enter.do_idle
     11.85 ±  7%      -0.4       11.42 ±  2%      +0.0       11.86 ±  3%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.60 ±  6%      -0.4        0.18 ±141%      -0.3        0.35 ± 70%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      5.73 ±  4%      -0.4        5.34 ±  5%      -0.4        5.36 ±  3%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
     10.32 ±  5%      -0.3        9.99 ±  3%      +0.1       10.47 ±  3%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      9.81 ±  6%      -0.3        9.53 ±  4%      +0.2        9.99 ±  3%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      4.41 ±  8%      -0.3        4.14 ±  4%      +0.0        4.42 ±  6%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      3.24 ±  8%      -0.3        2.98 ± 17%      -0.1        3.19 ±  9%  perf-profile.calltrace.cycles-pp.rcu_nmi_enter.irqentry_enter.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.42 ±  7%      -0.3        3.16 ± 16%      -0.0        3.37 ±  8%  perf-profile.calltrace.cycles-pp.irqentry_enter.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      3.43 ±  6%      -0.2        3.22 ±  3%      -0.2        3.20 ±  3%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      3.11 ±  6%      -0.2        2.90 ±  3%      -0.2        2.89 ±  4%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.47 ±  5%      -0.2        1.27 ±  7%      -0.2        1.29 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_next_event_without.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.56 ±  6%      -0.2        0.36 ± 70%      -0.0        0.55 ±  4%  perf-profile.calltrace.cycles-pp.arch_cpu_idle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.36 ± 14%      -0.2        1.18 ±  7%      -0.2        1.14 ±  6%  perf-profile.calltrace.cycles-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.89 ±  7%      -0.2        0.70 ± 10%      -0.2        0.73 ±  5%  perf-profile.calltrace.cycles-pp.__hrtimer_next_event_base.hrtimer_next_event_without.tick_nohz_get_sleep_length.menu_select.do_idle
      0.17 ±141%      -0.2        0.00            -0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.irqtime_account_process_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      3.56 ±  4%      -0.1        3.41 ±  8%      -0.2        3.40 ±  4%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      1.27 ±  5%      -0.1        1.13 ±  6%      -0.1        1.18 ±  2%  perf-profile.calltrace.cycles-pp.__remove_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.16 ± 19%      -0.1        1.03 ±  5%      -0.2        0.97 ± 10%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.63 ± 15%      -0.1        2.50 ±  9%      -0.2        2.45 ±  2%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.91 ±  4%      -0.1        0.78 ±  8%      -0.1        0.82 ±  3%  perf-profile.calltrace.cycles-pp.timerqueue_del.__remove_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.80 ± 26%      -0.1        0.70 ± 22%      -0.1        0.67 ± 18%  perf-profile.calltrace.cycles-pp.ktime_get.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.50 ± 27%      -0.1        1.40 ± 15%      -0.2        1.34 ±  4%  perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.91 ±  7%      -0.1        1.82 ±  4%      -0.1        1.83 ±  4%  perf-profile.calltrace.cycles-pp.get_next_timer_interrupt.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle
      4.72 ±  7%      -0.1        4.63 ±  8%      +0.3        5.02 ± 13%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.08 ±223%      -0.1        0.00            +0.0        0.09 ±223%  perf-profile.calltrace.cycles-pp.tick_check_broadcast_expired.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.98 ±  4%      -0.1        0.90 ±  4%      -0.1        0.90 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_update_next_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.18 ±141%      -0.1        0.10 ±223%      -0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.rcu_eqs_enter.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.95 ±  7%      -0.1        0.90 ± 21%      +0.0        0.98 ± 13%  perf-profile.calltrace.cycles-pp.rcu_dynticks_eqs_exit.rcu_eqs_exit.rcu_idle_exit.cpuidle_enter_state.cpuidle_enter
      0.84 ± 13%      -0.0        0.79 ±  7%      -0.1        0.78 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.get_next_timer_interrupt.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select
      0.59 ± 47%      -0.0        0.55 ± 47%      +0.0        0.61 ± 11%  perf-profile.calltrace.cycles-pp.rcu_nmi_exit.irqentry_exit.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.76 ± 17%      -0.0        0.72 ± 15%      -0.1        0.71 ±  8%  perf-profile.calltrace.cycles-pp.irqentry_exit.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.72 ±  8%      -0.0        0.68 ±  3%      -0.0        0.70 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_governor_latency_req.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.72 ±  5%      -0.0        0.68 ±  4%      -0.0        0.70 ±  4%  perf-profile.calltrace.cycles-pp.run_rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.04 ± 11%      -0.0        1.01 ± 14%      -0.1        0.99 ±  2%  perf-profile.calltrace.cycles-pp.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.60 ±  5%      -0.0        0.58 ±  2%      -0.0        0.59 ±  4%  perf-profile.calltrace.cycles-pp.update_blocked_averages.run_rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.72 ± 25%      -0.0        0.70 ± 26%      +0.0        0.74 ± 31%  perf-profile.calltrace.cycles-pp.cmd_record.cmd_sched.run_builtin.main.__libc_start_main
      0.72 ± 25%      -0.0        0.70 ± 26%      +0.0        0.74 ± 31%  perf-profile.calltrace.cycles-pp.cmd_sched.run_builtin.main.__libc_start_main
      0.80 ±  4%      -0.0        0.79 ±  3%      -0.0        0.78 ±  6%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.95 ± 17%      -0.0        0.94 ± 21%      +0.0        0.98 ± 25%  perf-profile.calltrace.cycles-pp.__libc_start_main
      0.95 ± 17%      -0.0        0.94 ± 21%      +0.0        0.98 ± 25%  perf-profile.calltrace.cycles-pp.main.__libc_start_main
      0.95 ± 17%      -0.0        0.94 ± 21%      +0.0        0.98 ± 25%  perf-profile.calltrace.cycles-pp.run_builtin.main.__libc_start_main
      0.62 ±  7%      -0.0        0.61 ±  3%      +0.0        0.62 ±  5%  perf-profile.calltrace.cycles-pp.hrtimer_get_next_event.get_next_timer_interrupt.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select
      1.07 ±  6%      -0.0        1.07 ±  4%      -0.1        0.99 ±  5%  perf-profile.calltrace.cycles-pp.enqueue_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.21 ±141%      -0.0        0.21 ±141%      +0.0        0.22 ±141%  perf-profile.calltrace.cycles-pp.process_simple.perf_session__process_events.record__finish_output.cmd_record.cmd_sched
      0.29 ±100%      +0.0        0.29 ±100%      +0.0        0.29 ±100%  perf-profile.calltrace.cycles-pp.pagecache_get_page.shmem_getpage_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter
      0.00            +0.0        0.00            +0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.00            +0.0        0.00            +0.1        0.11 ±223%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.00            +0.0        0.00            +0.1        0.11 ±223%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.00            +0.0        0.00            +0.1        0.11 ±223%  perf-profile.calltrace.cycles-pp.start_kernel.secondary_startup_64_no_verify
      0.00            +0.0        0.00            +0.2        0.21 ±141%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.88 ±  7%      +0.0        0.88 ±  5%      -0.1        0.80 ±  6%  perf-profile.calltrace.cycles-pp.timerqueue_add.enqueue_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.17 ±141%      +0.0        0.18 ±141%      -0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.iov_iter_copy_from_user_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      0.22 ±141%      +0.0        0.22 ±141%      +0.0        0.24 ±142%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.cmd_record.cmd_sched.run_builtin
      0.81 ± 12%      +0.0        0.81 ± 19%      -0.0        0.78 ±  5%  perf-profile.calltrace.cycles-pp.ktime_get.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.22 ±141%      +0.0        0.22 ±141%      +0.0        0.24 ±141%  perf-profile.calltrace.cycles-pp.record__finish_output.cmd_record.cmd_sched.run_builtin.main
      1.59 ±  6%      +0.0        1.60 ±  3%      -0.0        1.58 ±  2%  perf-profile.calltrace.cycles-pp.update_rq_clock.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      0.80 ±  5%      +0.0        0.81 ±  3%      -0.0        0.79 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.78            +0.0        0.80 ±  4%      +0.0        0.79 ±  5%  perf-profile.calltrace.cycles-pp.update_irq_load_avg.update_rq_clock.scheduler_tick.update_process_times.tick_sched_handle
      0.60 ± 11%      +0.0        0.63 ±  6%      +0.1        0.65 ± 11%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.60 ± 11%      +0.0        0.63 ±  6%      +0.1        0.65 ± 11%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.51 ± 46%      +0.0        0.55 ±  9%      -0.1        0.36 ± 71%  perf-profile.calltrace.cycles-pp.sched_clock.sched_clock_cpu.irqtime_account_irq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.52 ± 45%      +0.1        0.57 ±  9%      +0.1        0.57 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.20 ± 10%      +0.1        1.25 ±  3%      +0.0        1.22 ±  6%  perf-profile.calltrace.cycles-pp.irqtime_account_irq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.19 ±141%      +0.1        0.24 ±149%      -0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.timekeeping_max_deferment.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle
      0.53 ± 46%      +0.1        0.60 ±  6%      -0.1        0.42 ± 71%  perf-profile.calltrace.cycles-pp.native_sched_clock.sched_clock.sched_clock_cpu.irqtime_account_irq.irq_exit_rcu
      0.36 ± 70%      +0.1        0.43 ± 44%      +0.2        0.53 ±  2%  perf-profile.calltrace.cycles-pp.native_apic_msr_eoi_write.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +0.1        0.09 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.shmem_write_end.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      0.59 ±  4%      +0.1        0.68 ±  4%      +0.1        0.70 ±  4%  perf-profile.calltrace.cycles-pp.update_ts_time_stats.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.71 ± 15%      +0.1        0.81 ±  9%      +0.0        0.76 ±  3%  perf-profile.calltrace.cycles-pp.sched_clock_cpu.irqtime_account_irq.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.34 ±100%      +0.1        0.44 ± 72%      +0.1        0.45 ± 71%  perf-profile.calltrace.cycles-pp.llseek
      0.80 ±  7%      +0.1        0.91 ± 11%      +0.1        0.89 ± 10%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains.__softirqentry_text_start
      0.00            +0.1        0.11 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.poll_idle
      0.00            +0.1        0.12 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state
      0.88 ±  6%      +0.1        0.99 ± 11%      +0.1        0.98 ± 10%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__softirqentry_text_start.irq_exit_rcu
      1.40 ± 29%      +0.1        1.52 ± 18%      +0.0        1.40 ± 23%  perf-profile.calltrace.cycles-pp.shmem_getpage_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      3.06 ±  5%      +0.1        3.18 ± 13%      +0.2        3.26 ±  8%  perf-profile.calltrace.cycles-pp.rcu_sched_clock_irq.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      1.44 ± 29%      +0.1        1.57 ± 18%      +0.0        1.45 ± 23%  perf-profile.calltrace.cycles-pp.shmem_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      0.52 ± 46%      +0.1        0.65 ±  8%      +0.1        0.61 ±  2%  perf-profile.calltrace.cycles-pp.sched_clock.sched_clock_cpu.irqtime_account_irq.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.60 ± 45%      +0.1        0.74 ±  5%      +0.1        0.71 ± 10%  perf-profile.calltrace.cycles-pp.sched_clock_cpu.irqtime_account_irq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.15 ± 12%      +0.1        1.29 ±  5%      +0.1        1.24 ±  3%  perf-profile.calltrace.cycles-pp.irqtime_account_irq.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.22 ±  5%      +0.2        1.37 ± 11%      +0.1        1.35 ±  8%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt
      1.50 ±  5%      +0.2        1.66 ± 11%      +0.1        1.63 ±  7%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.54 ± 46%      +0.2        0.71 ±  8%      +0.1        0.67 ±  4%  perf-profile.calltrace.cycles-pp.native_sched_clock.sched_clock.sched_clock_cpu.irqtime_account_irq.sysvec_apic_timer_interrupt
      0.00            +0.2        0.20 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state.cpuidle_enter
      0.00            +0.2        0.20 ±223%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle
      3.40 ±  5%      +0.2        3.65 ±  9%      +0.2        3.64 ±  5%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      2.78 ± 29%      +0.2        3.02 ± 20%      -0.0        2.75 ± 24%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.new_sync_write.vfs_write.ksys_write
      2.52 ± 29%      +0.2        2.77 ± 20%      +0.0        2.52 ± 23%  perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write.vfs_write
      5.83 ±  6%      +0.3        6.14 ±  5%      +0.3        6.15        perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.26 ±100%      +0.3        0.59 ±  7%      +0.3        0.61 ±  8%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      3.08 ± 29%      +0.3        3.41 ± 21%      +0.0        3.10 ± 24%  perf-profile.calltrace.cycles-pp.generic_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
      3.22 ± 28%      +0.3        3.56 ± 21%      +0.0        3.26 ± 23%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.46 ± 17%      +0.3        1.80 ±  4%      +0.2        1.62 ±  9%  perf-profile.calltrace.cycles-pp.sched_clock.sched_clock_cpu.cpuidle_enter_state.cpuidle_enter.do_idle
      1.55 ± 16%      +0.3        1.90 ±  4%      +0.2        1.73 ±  8%  perf-profile.calltrace.cycles-pp.native_sched_clock.sched_clock.sched_clock_cpu.cpuidle_enter_state.cpuidle_enter
      1.77 ± 15%      +0.3        2.11 ±  4%      +0.2        1.97 ±  7%  perf-profile.calltrace.cycles-pp.sched_clock_cpu.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      3.92 ± 29%      +0.4        4.30 ± 21%      +0.0        3.94 ± 23%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.94 ± 75%      +0.4        1.32 ± 25%      +0.9        1.80 ± 47%  perf-profile.calltrace.cycles-pp.x86_pmu_disable.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      4.05 ± 29%      +0.4        4.47 ± 21%      +0.0        4.07 ± 23%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      4.17 ± 29%      +0.4        4.58 ± 21%      +0.0        4.19 ± 23%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      4.35 ± 29%      +0.4        4.77 ± 21%      +0.0        4.39 ± 23%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      5.18 ± 29%      +0.5        5.73 ± 21%      +0.0        5.23 ± 24%  perf-profile.calltrace.cycles-pp.write
      0.00            +0.8        0.84 ±167%      +0.2        0.15 ±223%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     10.31 ±  6%      +1.2       11.52 ±  6%      +0.5       10.77 ±  7%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     75.92 ±  2%      -1.8       74.15            -0.6       75.33        perf-profile.children.cycles-pp.cpuidle_enter_state
     76.17 ±  2%      -1.7       74.43            -0.6       75.58        perf-profile.children.cycles-pp.cpuidle_enter
     51.06 ±  2%      -1.3       49.72            -0.6       50.49        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     30.79 ±  2%      -1.3       29.46            -0.7       30.05 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
     48.27 ±  2%      -1.3       46.94            -0.7       47.58        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     32.22 ±  2%      -1.3       30.91            -0.7       31.51 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
     23.10 ±  2%      -1.0       22.12 ±  2%      -0.2       22.87 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
     13.26 ±  2%      -0.7       12.52 ±  5%      -0.1       13.18 ±  2%  perf-profile.children.cycles-pp.intel_idle
     90.32 ±  2%      -0.7       89.58            -0.3       90.06        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     90.32 ±  2%      -0.7       89.58            -0.3       90.06        perf-profile.children.cycles-pp.cpu_startup_entry
     90.32 ±  2%      -0.7       89.58            -0.3       90.06        perf-profile.children.cycles-pp.do_idle
     90.07 ±  2%      -0.7       89.34            -0.4       89.66        perf-profile.children.cycles-pp.start_secondary
      7.63 ±  6%      -0.5        7.18 ± 13%      -0.1        7.51 ±  5%  perf-profile.children.cycles-pp.rcu_idle_exit
      7.37 ±  7%      -0.4        6.92 ± 13%      -0.1        7.24 ±  5%  perf-profile.children.cycles-pp.rcu_eqs_exit
      5.78 ±  4%      -0.4        5.40 ±  5%      -0.4        5.42 ±  3%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      4.84 ± 12%      -0.4        4.48 ±  8%      -0.6        4.28 ±  5%  perf-profile.children.cycles-pp.ktime_get
     12.40 ±  6%      -0.3       12.07 ±  2%      +0.1       12.46 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
      3.25 ±  8%      -0.2        3.00 ± 16%      -0.0        3.21 ±  8%  perf-profile.children.cycles-pp.rcu_nmi_enter
      3.45 ±  7%      -0.2        3.22 ± 15%      -0.0        3.42 ±  8%  perf-profile.children.cycles-pp.irqentry_enter
      1.42 ±  3%      -0.2        1.20 ±  5%      -0.2        1.24 ±  2%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
     10.81 ±  5%      -0.2       10.59 ±  3%      +0.2       11.02 ±  3%  perf-profile.children.cycles-pp.tick_sched_handle
      4.85 ±  7%      -0.2        4.64 ±  4%      +0.1        4.91 ±  6%  perf-profile.children.cycles-pp.scheduler_tick
      1.52 ±  5%      -0.2        1.31 ±  7%      -0.2        1.33 ±  3%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      3.50 ±  5%      -0.2        3.31 ±  4%      -0.2        3.28 ±  3%  perf-profile.children.cycles-pp.irq_enter_rcu
     10.32 ±  5%      -0.2       10.13 ±  3%      +0.2       10.55 ±  3%  perf-profile.children.cycles-pp.update_process_times
      1.33 ±  5%      -0.2        1.15 ±  2%      -0.2        1.17 ±  4%  perf-profile.children.cycles-pp.read_tsc
      0.74 ±  9%      -0.2        0.57 ± 17%      -0.2        0.59 ±  2%  perf-profile.children.cycles-pp.rb_next
      3.17 ±  6%      -0.2        3.00 ±  4%      -0.2        2.96 ±  4%  perf-profile.children.cycles-pp.tick_irq_enter
      3.62 ±  4%      -0.2        3.46 ±  8%      -0.2        3.46 ±  4%  perf-profile.children.cycles-pp.tick_nohz_next_event
      1.20 ± 18%      -0.1        1.06 ±  6%      -0.2        1.01 ± 10%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      1.30 ±  4%      -0.1        1.18 ±  6%      -0.1        1.22        perf-profile.children.cycles-pp.__remove_hrtimer
      0.95 ±  4%      -0.1        0.84 ±  7%      -0.1        0.88 ±  2%  perf-profile.children.cycles-pp.timerqueue_del
      2.70 ± 15%      -0.1        2.58 ±  9%      -0.2        2.52 ±  2%  perf-profile.children.cycles-pp.clockevents_program_event
      0.61 ±  6%      -0.1        0.51 ±  8%      -0.1        0.52 ±  5%  perf-profile.children.cycles-pp.perf_event_task_tick
      1.94 ±  7%      -0.1        1.84 ±  4%      -0.1        1.86 ±  4%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      1.02 ±  4%      -0.1        0.94 ±  4%      -0.1        0.95 ±  4%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.56 ±  3%      -0.1        0.50 ±  4%      -0.0        0.52 ±  3%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.98 ±  7%      -0.1        0.92 ± 21%      +0.0        1.01 ± 13%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_exit
      0.47 ±  6%      -0.1        0.42 ±  9%      -0.0        0.45 ±  8%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      1.58 ±  9%      -0.1        1.52 ±  5%      -0.1        1.50 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      4.79 ±  7%      -0.1        4.74 ± 10%      +0.4        5.15 ± 14%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.10 ±  9%      -0.0        0.05 ±  8%      -0.0        0.07 ± 16%  perf-profile.children.cycles-pp.arch_cpu_idle_exit
      0.74 ±  7%      -0.0        0.70 ±  3%      -0.0        0.73 ±  6%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.20 ±  9%      -0.0        0.16 ±  8%      -0.1        0.14 ± 10%  perf-profile.children.cycles-pp.rcu_segcblist_ready_cbs
      0.67 ± 19%      -0.0        0.63 ± 16%      -0.1        0.62 ± 10%  perf-profile.children.cycles-pp.rcu_nmi_exit
      0.50 ±  5%      -0.0        0.46 ±  6%      -0.0        0.49 ±  5%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.58 ±  5%      -0.0        0.54 ±  5%      -0.0        0.57 ±  5%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.49 ±  5%      -0.0        0.45 ±  5%      -0.0        0.46 ±  5%  perf-profile.children.cycles-pp.__hrtimer_get_next_event
      0.25 ±  5%      -0.0        0.21 ±  9%      -0.0        0.22 ±  7%  perf-profile.children.cycles-pp.irq_work_needs_cpu
      0.46 ±  4%      -0.0        0.43 ±  3%      +0.0        0.46 ±  6%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      1.07 ± 11%      -0.0        1.03 ± 14%      -0.1        1.00 ±  3%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.80 ± 17%      -0.0        0.76 ± 13%      -0.1        0.74 ±  9%  perf-profile.children.cycles-pp.irqentry_exit
      0.17 ± 19%      -0.0        0.14 ± 19%      -0.0        0.15 ±  8%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.04 ± 72%      -0.0        0.01 ±223%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.cpu_latency_qos_limit
      0.07 ±  5%      -0.0        0.04 ± 44%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.timerqueue_iterate_next
      0.06 ± 19%      -0.0        0.03 ± 70%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.timer_clear_idle
      0.33 ±  7%      -0.0        0.31 ±  8%      +0.0        0.34 ± 10%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.15 ± 25%      -0.0        0.13 ± 14%      -0.0        0.13 ± 19%  perf-profile.children.cycles-pp.io_serial_in
      0.72 ±  4%      -0.0        0.70 ±  4%      -0.0        0.71 ±  4%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.64 ±  7%      -0.0        0.62 ±  2%      +0.0        0.64 ±  6%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.67 ±  4%      -0.0        0.65 ±  4%      -0.0        0.64 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.15 ±  4%      -0.0        0.13 ± 18%      -0.0        0.12 ±  9%  perf-profile.children.cycles-pp.tick_nohz_idle_got_tick
      0.09 ± 54%      -0.0        0.07 ± 21%      -0.0        0.08 ± 22%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.04 ± 71%      -0.0        0.02 ±141%      +0.0        0.05 ± 46%  perf-profile.children.cycles-pp.perf_pmu_disable
      0.05 ±  7%      -0.0        0.03 ± 70%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.rcu_irq_exit
      0.21 ± 13%      -0.0        0.19 ±  8%      -0.0        0.19 ±  7%  perf-profile.children.cycles-pp.sched_idle_set_state
      0.72 ± 25%      -0.0        0.71 ± 26%      +0.0        0.74 ± 31%  perf-profile.children.cycles-pp.cmd_record
      0.64 ± 11%      -0.0        0.62 ±  9%      -0.0        0.62 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.02 ±141%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.timestamp_truncate
      0.20 ±  7%      -0.0        0.19 ±  4%      +0.0        0.21 ± 12%  perf-profile.children.cycles-pp.sched_clock_idle_wakeup_event
      0.58 ± 22%      -0.0        0.57 ± 19%      +0.0        0.59 ± 20%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.22 ± 28%      -0.0        0.21 ± 17%      -0.0        0.18 ± 19%  perf-profile.children.cycles-pp.raise_softirq
      0.10 ± 14%      -0.0        0.08 ± 10%      -0.0        0.08 ±  9%  perf-profile.children.cycles-pp.hrtimer_run_queues
      0.06 ± 35%      -0.0        0.05 ± 78%      -0.0        0.06 ± 58%  perf-profile.children.cycles-pp.map__process_kallsym_symbol
      0.05 ± 83%      -0.0        0.04 ± 75%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.find_lock_entries
      0.13 ± 16%      -0.0        0.11 ±  8%      -0.0        0.12 ± 11%  perf-profile.children.cycles-pp.profile_tick
      0.18 ± 30%      -0.0        0.16 ± 27%      -0.0        0.14 ± 22%  perf-profile.children.cycles-pp.common_file_perm
      0.16 ± 31%      -0.0        0.14 ± 19%      -0.0        0.13 ± 22%  perf-profile.children.cycles-pp.xas_load
      0.14 ± 29%      -0.0        0.12 ± 29%      +0.0        0.15 ± 27%  perf-profile.children.cycles-pp.ordered_events__queue
      0.06 ±  9%      -0.0        0.04 ± 44%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.cpuidle_get_cpu_driver
      0.03 ±100%      -0.0        0.02 ±142%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.xas_start
      0.44 ± 32%      -0.0        0.42 ± 33%      -0.0        0.44 ± 37%  perf-profile.children.cycles-pp.process_simple
      0.72 ± 25%      -0.0        0.70 ± 26%      +0.0        0.74 ± 31%  perf-profile.children.cycles-pp.cmd_sched
      1.65 ±  3%      -0.0        1.63 ±  3%      -0.0        1.63 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.10 ± 25%      -0.0        0.09 ± 34%      -0.0        0.09 ± 30%  perf-profile.children.cycles-pp.path_lookupat
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.sys_imageblit
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.drm_fb_helper_sys_imageblit
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±223%  perf-profile.children.cycles-pp.bit_putcs
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±223%  perf-profile.children.cycles-pp.vt_console_print
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±223%  perf-profile.children.cycles-pp.fbcon_putcs
      0.03 ±100%      -0.0        0.02 ±141%      -0.0        0.02 ±144%  perf-profile.children.cycles-pp.proc_single_show
      0.03 ±100%      -0.0        0.02 ±141%      -0.0        0.02 ±144%  perf-profile.children.cycles-pp.proc_pid_status
      0.47 ± 10%      -0.0        0.46 ± 12%      -0.0        0.43 ± 14%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.29 ± 10%      -0.0        0.28 ± 14%      +0.0        0.29 ±  6%  perf-profile.children.cycles-pp.trigger_load_balance
      0.37 ±  2%      -0.0        0.36 ± 11%      -0.0        0.34 ±  3%  perf-profile.children.cycles-pp.menu_reflect
      0.28 ± 11%      -0.0        0.26 ±  9%      -0.0        0.26 ±  8%  perf-profile.children.cycles-pp.note_gp_changes
      0.17 ±  7%      -0.0        0.16 ± 17%      +0.0        0.18 ± 14%  perf-profile.children.cycles-pp._find_next_bit
      0.49 ± 19%      -0.0        0.48 ± 17%      +0.0        0.50 ± 18%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.19 ± 31%      -0.0        0.18 ± 32%      +0.0        0.21 ± 28%  perf-profile.children.cycles-pp.seq_read
      0.95 ± 17%      -0.0        0.94 ± 21%      +0.0        0.98 ± 25%  perf-profile.children.cycles-pp.__libc_start_main
      0.95 ± 17%      -0.0        0.94 ± 21%      +0.0        0.98 ± 25%  perf-profile.children.cycles-pp.main
      0.95 ± 17%      -0.0        0.94 ± 21%      +0.0        0.98 ± 25%  perf-profile.children.cycles-pp.run_builtin
      0.03 ±100%      -0.0        0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp.rw_verify_area
      0.06 ± 16%      -0.0        0.05 ± 48%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.mmap_region
      0.04 ± 77%      -0.0        0.04 ±104%      +0.0        0.06 ± 55%  perf-profile.children.cycles-pp.rb_free
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.account_system_index_time
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±223%  perf-profile.children.cycles-pp.symbol__is_idle
      0.12 ± 22%      -0.0        0.12 ± 28%      +0.0        0.13 ± 18%  perf-profile.children.cycles-pp.walk_component
      0.13 ± 30%      -0.0        0.12 ± 27%      +0.0        0.14 ± 29%  perf-profile.children.cycles-pp.queue_event
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.lru_add_drain
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.02 ±141%      -0.0        0.01 ±223%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.unmap_page_range
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.02 ±141%      -0.0        0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.unmap_vmas
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.perf_release
      0.01 ±223%      -0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.perf_event_release_kernel
      0.01 ±223%      -0.0        0.00            +0.0        0.02 ±141%  perf-profile.children.cycles-pp.__do_munmap
      0.01 ±223%      -0.0        0.00            +0.0        0.02 ±141%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.06 ± 87%      -0.0        0.05 ± 48%      -0.0        0.04 ±100%  perf-profile.children.cycles-pp.aa_file_perm
      0.05 ± 47%      -0.0        0.04 ± 72%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.evsel__read_counter
      0.04 ± 72%      -0.0        0.03 ±103%      +0.0        0.05 ± 53%  perf-profile.children.cycles-pp.step_into
      0.26 ± 29%      -0.0        0.25 ± 33%      +0.1        0.40 ± 35%  perf-profile.children.cycles-pp.start_kernel
      0.49 ±  9%      -0.0        0.48 ± 13%      -0.0        0.44 ±  9%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.12 ± 15%      -0.0        0.11 ± 11%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.local_touch_nmi
      0.07 ± 16%      -0.0        0.06 ± 17%      -0.0        0.07 ± 23%  perf-profile.children.cycles-pp.do_fault
      0.07 ± 14%      -0.0        0.06 ± 16%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.setlocale
      0.10 ± 25%      -0.0        0.09 ± 36%      -0.0        0.10 ± 29%  perf-profile.children.cycles-pp.filename_lookup
      0.07 ± 14%      -0.0        0.06 ± 24%      +0.0        0.07 ± 20%  perf-profile.children.cycles-pp.update_load_avg
      0.02 ±141%      -0.0        0.01 ±223%      +0.0        0.02 ±142%  perf-profile.children.cycles-pp.unlock_page
      0.02 ±141%      -0.0        0.01 ±223%      +0.0        0.02 ± 99%  perf-profile.children.cycles-pp.perf_evsel__read
      0.03 ±103%      -0.0        0.03 ±141%      +0.0        0.04 ± 77%  perf-profile.children.cycles-pp.free_unref_page
      0.05 ± 46%      -0.0        0.04 ± 45%      -0.0        0.04 ± 72%  perf-profile.children.cycles-pp.perf_callchain_user
      0.10 ± 20%      -0.0        0.10 ± 25%      +0.0        0.11 ± 19%  perf-profile.children.cycles-pp.rcu_do_batch
      0.83 ±  4%      -0.0        0.82 ±  3%      -0.0        0.82 ±  4%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.52 ±  7%      -0.0        0.51 ±  7%      -0.0        0.51 ±  6%  perf-profile.children.cycles-pp.idle_cpu
      0.06 ± 11%      -0.0        0.06 ± 18%      -0.0        0.05 ± 48%  perf-profile.children.cycles-pp.evlist__close
      0.07 ±  9%      -0.0        0.07 ± 18%      -0.0        0.06 ± 48%  perf-profile.children.cycles-pp.evlist__delete
      0.12 ± 24%      -0.0        0.11 ± 28%      -0.0        0.12 ± 34%  perf-profile.children.cycles-pp.__do_sys_newstat
      0.12 ± 25%      -0.0        0.11 ± 31%      -0.0        0.12 ± 32%  perf-profile.children.cycles-pp.vfs_statx
      0.12 ± 21%      -0.0        0.12 ± 20%      +0.0        0.13 ± 19%  perf-profile.children.cycles-pp.link_path_walk
      0.11 ± 35%      -0.0        0.11 ± 36%      +0.0        0.12 ± 31%  perf-profile.children.cycles-pp.seq_printf
      0.06 ± 14%      -0.0        0.06 ± 16%      +0.0        0.07 ±  9%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.25 ±  8%      -0.0        0.24 ±  5%      +0.0        0.26 ±  6%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.08 ± 19%      -0.0        0.08 ± 14%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.__x86_retpoline_rbx
      0.46 ± 29%      -0.0        0.46 ± 30%      +0.0        0.49 ± 34%  perf-profile.children.cycles-pp.perf_session__process_events
      0.46 ± 29%      -0.0        0.46 ± 30%      +0.0        0.49 ± 34%  perf-profile.children.cycles-pp.record__finish_output
      0.33 ±  9%      -0.0        0.32 ±  4%      -0.0        0.31 ±  5%  perf-profile.children.cycles-pp.rcu_needs_cpu
      0.15 ± 13%      -0.0        0.14 ±  6%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.printk
      0.14 ± 33%      -0.0        0.14 ± 28%      +0.0        0.15 ± 33%  perf-profile.children.cycles-pp.perf_session__write_header
      0.10 ±  8%      -0.0        0.09 ±  7%      -0.0        0.09 ± 12%  perf-profile.children.cycles-pp.task_tick_idle
      0.11 ± 10%      -0.0        0.10 ±  7%      +0.0        0.11 ± 13%  perf-profile.children.cycles-pp.__note_gp_changes
      0.11 ± 30%      -0.0        0.10 ± 34%      +0.0        0.11 ± 36%  perf-profile.children.cycles-pp.____machine__findnew_thread
      0.11 ± 15%      -0.0        0.11 ± 38%      +0.0        0.12 ± 24%  perf-profile.children.cycles-pp.schedule_idle
      0.11 ± 36%      -0.0        0.10 ± 32%      +0.0        0.12 ± 29%  perf-profile.children.cycles-pp.seq_vprintf
      0.08 ± 31%      -0.0        0.08 ± 26%      -0.0        0.06 ± 51%  perf-profile.children.cycles-pp.current_time
      0.09 ± 27%      -0.0        0.08 ± 27%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.__might_sleep
      0.09 ± 21%      -0.0        0.09 ± 21%      -0.0        0.08 ± 18%  perf-profile.children.cycles-pp.__pagevec_lru_add
      0.22 ± 11%      -0.0        0.22 ±  9%      +0.0        0.24 ±  9%  perf-profile.children.cycles-pp.call_cpuidle
      0.12 ± 25%      -0.0        0.11 ± 31%      +0.0        0.12 ± 35%  perf-profile.children.cycles-pp.machine__process_fork_event
      0.40 ± 18%      -0.0        0.40 ± 18%      +0.0        0.41 ± 20%  perf-profile.children.cycles-pp.task_work_run
      0.02 ±141%      -0.0        0.02 ±142%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.delay_tsc
      0.01 ±223%      -0.0        0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.number
      0.02 ±142%      -0.0        0.02 ±141%      +0.0        0.02 ± 99%  perf-profile.children.cycles-pp.__open64_nocancel
      0.08 ± 10%      -0.0        0.08 ± 10%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.10 ± 27%      -0.0        0.10 ± 30%      +0.0        0.11 ± 37%  perf-profile.children.cycles-pp.nsinfo__new
      0.10 ± 28%      -0.0        0.10 ± 32%      +0.0        0.11 ± 34%  perf-profile.children.cycles-pp.thread__new
      0.07 ±  8%      -0.0        0.07 ± 10%      +0.0        0.08 ±  9%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.07 ±  8%      -0.0        0.07 ± 10%      +0.0        0.08 ±  9%  perf-profile.children.cycles-pp.do_group_exit
      0.07 ±  8%      -0.0        0.07 ± 10%      +0.0        0.08 ±  9%  perf-profile.children.cycles-pp.do_exit
      0.12 ± 34%      -0.0        0.12 ± 28%      +0.0        0.13 ± 30%  perf-profile.children.cycles-pp.vsnprintf
      0.20 ±  2%      -0.0        0.20 ±  7%      -0.0        0.18 ± 11%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.15 ± 12%      -0.0        0.15 ±  7%      -0.0        0.14 ±  9%  perf-profile.children.cycles-pp.console_unlock
      0.07 ± 10%      -0.0        0.07 ± 20%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.12 ± 24%      -0.0        0.12 ± 29%      +0.0        0.12 ± 36%  perf-profile.children.cycles-pp.__xstat64
      0.02 ± 99%      +0.0        0.02 ± 99%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.kmem_cache_free
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.schedule_timeout
      0.02 ±141%      +0.0        0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.perf_read
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.try_charge
      0.10 ±  7%      +0.0        0.10 ± 13%      -0.0        0.10 ± 14%  perf-profile.children.cycles-pp.cpuidle_reflect
      0.15 ± 19%      +0.0        0.15 ± 17%      -0.0        0.14 ± 15%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.40 ±  7%      +0.0        0.40 ±  8%      -0.0        0.40 ±  7%  perf-profile.children.cycles-pp.hrtimer_forward
      0.15 ± 12%      +0.0        0.15 ±  6%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.vprintk_emit
      0.10 ± 11%      +0.0        0.10 ± 16%      +0.0        0.10 ± 12%  perf-profile.children.cycles-pp.ksoftirqd_running
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.rcu_dynticks_task_enter
      0.13 ±  9%      +0.0        0.13 ±  8%      +0.0        0.14 ±  8%  perf-profile.children.cycles-pp.restore_regs_and_return_to_kernel
      0.06 ± 20%      +0.0        0.06 ± 15%      +0.0        0.06 ± 23%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.12 ± 33%      +0.0        0.12 ± 26%      +0.0        0.12 ± 35%  perf-profile.children.cycles-pp.write_cache
      0.09 ± 42%      +0.0        0.09 ± 38%      +0.0        0.10 ± 35%  perf-profile.children.cycles-pp.s_show
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.shmem_pseudo_vma_init
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.do_dentry_open
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.lf
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.con_scroll
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.fbcon_scroll
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.fbcon_redraw
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.rcu_all_qs
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.dev_attr_show
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.update_iter
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.net_rx_action
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.__napi_poll
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.igb_poll
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.sysfs_kf_seq_show
      0.10 ± 32%      +0.0        0.10 ± 26%      +0.0        0.12 ± 31%  perf-profile.children.cycles-pp.cpu_cache_level__read
      0.00            +0.0        0.00            +0.0        0.02 ±223%  perf-profile.children.cycles-pp.common_interrupt
      0.00            +0.0        0.00            +0.0        0.02 ±223%  perf-profile.children.cycles-pp.asm_common_interrupt
      0.00            +0.0        0.00            +0.0        0.02 ±141%  perf-profile.children.cycles-pp.find_idlest_group
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ± 99%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.00            +0.0        0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.memcpy_erms
      0.00            +0.0        0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.s_next
      0.00            +0.0        0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.lseek@plt
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.04 ± 73%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.__intel_pmu_disable_all
      0.07 ± 16%      +0.0        0.07 ± 14%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.33 ±  6%      +0.0        0.33 ± 11%      -0.0        0.32 ±  8%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.12 ± 13%      +0.0        0.12 ± 12%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.bprm_execve
      0.15 ± 10%      +0.0        0.16 ±  9%      +0.0        0.16 ± 11%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.16 ± 10%      +0.0        0.17 ±  7%      +0.0        0.18 ± 11%  perf-profile.children.cycles-pp.handle_mm_fault
      0.26 ± 27%      +0.0        0.26 ± 24%      +0.0        0.29 ± 27%  perf-profile.children.cycles-pp.seq_read_iter
      0.11 ± 22%      +0.0        0.12 ± 23%      -0.0        0.11 ± 26%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.06 ± 14%      +0.0        0.06 ± 19%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.04 ± 71%      +0.0        0.04 ± 71%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.filemap_map_pages
      0.07 ± 54%      +0.0        0.07 ± 27%      +0.0        0.08 ± 29%  perf-profile.children.cycles-pp.sysfs__read_int
      0.08 ±  7%      +0.0        0.08 ±  4%      +0.0        0.09 ± 16%  perf-profile.children.cycles-pp.intel_pmu_disable_all
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.workingset_activation
      0.02 ±142%      +0.0        0.02 ±144%      +0.0        0.02 ±142%  perf-profile.children.cycles-pp.sysfs__read_str
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.__wake_up_common
      0.04 ±101%      +0.0        0.04 ± 72%      +0.0        0.04 ± 73%  perf-profile.children.cycles-pp.xas_store
      0.05 ± 51%      +0.0        0.05 ± 53%      +0.0        0.08 ± 31%  perf-profile.children.cycles-pp.dyntick_save_progress_counter
      0.14 ± 12%      +0.0        0.14 ± 14%      +0.0        0.15 ±  7%  perf-profile.children.cycles-pp.execve
      0.13 ± 37%      +0.0        0.13 ± 33%      +0.0        0.14 ± 32%  perf-profile.children.cycles-pp.proc_reg_read
      0.58 ±  6%      +0.0        0.58 ±  5%      +0.0        0.59 ±  4%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.14 ±  9%      +0.0        0.14 ±  6%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.14 ±  9%      +0.0        0.14 ±  6%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.14 ±  9%      +0.0        0.14 ±  6%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.14 ±  9%      +0.0        0.14 ±  6%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.irq_work_run
      0.14 ±  9%      +0.0        0.14 ±  6%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.irq_work_single
      0.62 ±  4%      +0.0        0.62 ±  8%      +0.0        0.63 ±  8%  perf-profile.children.cycles-pp.update_blocked_averages
      0.39 ± 19%      +0.0        0.39 ± 18%      +0.0        0.40 ± 20%  perf-profile.children.cycles-pp.__fput
      0.19 ± 10%      +0.0        0.20 ±  8%      +0.0        0.21 ± 18%  perf-profile.children.cycles-pp.rcu_is_cpu_rrupt_from_idle
      0.24 ±  7%      +0.0        0.24 ± 15%      -0.0        0.23 ± 10%  perf-profile.children.cycles-pp.balance_fair
      0.07 ± 14%      +0.0        0.08 ± 12%      +0.0        0.07 ± 18%  perf-profile.children.cycles-pp.check_tsc_unstable
      0.07 ± 10%      +0.0        0.07 ± 12%      +0.0        0.07 ± 14%  perf-profile.children.cycles-pp.update_group_capacity
      0.06 ± 13%      +0.0        0.06 ± 13%      +0.0        0.07 ± 17%  perf-profile.children.cycles-pp.cpuidle_select
      0.15 ±  7%      +0.0        0.15 ±  3%      +0.0        0.16 ±  9%  perf-profile.children.cycles-pp.irq_work_tick
      0.07 ± 29%      +0.0        0.07 ± 30%      +0.0        0.09 ± 35%  perf-profile.children.cycles-pp.force_qs_rnp
      0.06 ± 11%      +0.0        0.07 ± 19%      +0.0        0.06 ± 14%  perf-profile.children.cycles-pp.do_mmap
      0.12 ± 30%      +0.0        0.13 ± 11%      +0.0        0.13 ± 11%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.08 ± 29%      +0.0        0.08 ± 21%      +0.0        0.09 ± 30%  perf-profile.children.cycles-pp.__open64
      0.07 ± 10%      +0.0        0.08 ±  9%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.mmput
      0.40 ± 21%      +0.0        0.40 ± 17%      +0.0        0.41 ± 20%  perf-profile.children.cycles-pp.__close
      0.25 ±  8%      +0.0        0.25 ±  4%      -0.0        0.24 ±  6%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.04 ± 71%      +0.0        0.04 ± 44%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.03 ±100%      +0.0        0.03 ±100%      +0.0        0.05 ± 44%  perf-profile.children.cycles-pp.tick_nohz_idle_retain_tick
      0.18 ± 40%      +0.0        0.18 ± 41%      -0.0        0.17 ± 50%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.14 ±  9%      +0.0        0.15 ± 12%      -0.0        0.14 ± 13%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_enter
      0.10 ± 11%      +0.0        0.11 ± 15%      -0.0        0.10 ± 19%  perf-profile.children.cycles-pp.uart_console_write
      0.14 ± 12%      +0.0        0.15 ± 12%      +0.0        0.14 ±  8%  perf-profile.children.cycles-pp.do_execveat_common
      0.20 ±  5%      +0.0        0.21 ±  8%      +0.0        0.21 ± 11%  perf-profile.children.cycles-pp.rb_erase
      0.02 ±144%      +0.0        0.02 ± 99%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rbx
      0.14 ± 12%      +0.0        0.15 ± 12%      +0.0        0.15 ±  8%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.12 ± 10%      +0.0        0.12 ±  7%      +0.0        0.13 ±  7%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      0.07 ±  9%      +0.0        0.08 ±  9%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.exit_mmap
      0.12 ± 30%      +0.0        0.13 ± 25%      -0.0        0.12 ± 24%  perf-profile.children.cycles-pp.down_write
      1.10 ±  6%      +0.0        1.10 ±  4%      -0.1        1.02 ±  4%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.23 ±  7%      +0.0        0.23 ±  6%      +0.0        0.24 ±  8%  perf-profile.children.cycles-pp.exc_page_fault
      0.09 ± 17%      +0.0        0.10 ± 19%      -0.0        0.08 ± 21%  perf-profile.children.cycles-pp.lru_cache_add
      0.07 ± 23%      +0.0        0.08 ± 21%      -0.0        0.07 ± 46%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.11 ± 27%      +0.0        0.12 ± 29%      +0.0        0.14 ± 32%  perf-profile.children.cycles-pp.rcu_gp_kthread
      0.12 ± 31%      +0.0        0.13 ± 33%      -0.0        0.11 ± 37%  perf-profile.children.cycles-pp.file_update_time
      0.11 ± 12%      +0.0        0.12 ± 13%      -0.0        0.10 ± 16%  perf-profile.children.cycles-pp.serial8250_console_write
      0.08 ± 29%      +0.0        0.09 ± 22%      -0.0        0.08 ± 49%  perf-profile.children.cycles-pp.set_page_dirty
      0.08 ± 10%      +0.0        0.08 ±  8%      -0.0        0.07 ± 16%  perf-profile.children.cycles-pp.__do_sys_clone
      0.08 ± 10%      +0.0        0.08 ±  8%      -0.0        0.07 ± 16%  perf-profile.children.cycles-pp.kernel_clone
      0.08 ± 26%      +0.0        0.09 ± 18%      +0.0        0.09 ± 20%  perf-profile.children.cycles-pp.open64
      0.10 ± 31%      +0.0        0.11 ± 24%      +0.0        0.11 ± 23%  perf-profile.children.cycles-pp.mark_page_accessed
      0.10 ± 18%      +0.0        0.11 ± 19%      +0.0        0.11 ± 12%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.16 ±  9%      +0.0        0.17 ± 13%      +0.0        0.16 ± 12%  perf-profile.children.cycles-pp.rcu_dynticks_task_exit
      0.22 ± 10%      +0.0        0.23 ±  9%      +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.cmd_stat
      0.22 ± 10%      +0.0        0.23 ±  9%      +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.dispatch_events
      0.22 ± 10%      +0.0        0.23 ±  9%      +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.process_interval
      0.08 ±  5%      +0.0        0.09 ±  9%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.load_elf_binary
      0.25 ± 22%      +0.0        0.26 ± 25%      +0.0        0.27 ± 23%  perf-profile.children.cycles-pp.__libc_read
      0.26 ±  8%      +0.0        0.26 ±  5%      +0.0        0.26 ±  6%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.31 ± 24%      +0.0        0.32 ± 21%      +0.0        0.32 ± 25%  perf-profile.children.cycles-pp.evict
      0.10 ± 17%      +0.0        0.11 ± 14%      -0.0        0.10 ± 19%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.10 ± 13%      +0.0        0.11 ±  9%      +0.0        0.11 ±  9%  perf-profile.children.cycles-pp.update_dl_rq_load_avg
      0.10 ± 30%      +0.0        0.10 ± 29%      +0.0        0.10 ± 41%  perf-profile.children.cycles-pp.kallsyms__parse
      0.06 ± 46%      +0.0        0.06 ± 11%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.10 ±  6%      +0.0        0.11 ±  7%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
      0.22 ±  7%      +0.0        0.22 ±  6%      +0.0        0.23 ±  8%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.16 ± 32%      +0.0        0.16 ± 31%      +0.0        0.17 ± 42%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.getname_flags
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.__lookup_slow
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.01 ±223%      +0.0        0.02 ±141%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.mutex_lock
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.kernel_text_address
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.begin_new_exec
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.wait_for_completion
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.preempt_schedule_common
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.pick_link
      0.00            +0.0        0.01 ±223%      +0.0        0.02 ±142%  perf-profile.children.cycles-pp.do_anonymous_page
      0.10 ± 11%      +0.0        0.11 ± 18%      +0.0        0.10 ± 13%  perf-profile.children.cycles-pp.__cond_resched
      0.22 ± 10%      +0.0        0.23 ±  9%      +0.0        0.23 ±  4%  perf-profile.children.cycles-pp.read_counters
      0.10 ± 11%      +0.0        0.10 ±  9%      +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.rcu_idle_enter
      0.06 ± 24%      +0.0        0.08 ± 29%      +0.0        0.08 ± 22%  perf-profile.children.cycles-pp.page_mapping
      0.10 ± 29%      +0.0        0.12 ± 23%      +0.0        0.12 ± 39%  perf-profile.children.cycles-pp.__pagevec_release
      0.01 ±223%      +0.0        0.02 ±142%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.__kernel_text_address
      0.01 ±223%      +0.0        0.02 ±144%      +0.0        0.02 ±142%  perf-profile.children.cycles-pp.__libc_write
      0.03 ±105%      +0.0        0.04 ± 72%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.__set_page_dirty_no_writeback
      0.06 ±  6%      +0.0        0.07 ±  9%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.affine_move_task
      0.31 ± 28%      +0.0        0.32 ± 21%      -0.0        0.30 ± 27%  perf-profile.children.cycles-pp.sync_disk_rw
      0.10 ± 18%      +0.0        0.12 ± 13%      -0.0        0.10 ± 19%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.08 ± 26%      +0.0        0.09 ± 28%      +0.0        0.08 ± 26%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.06 ± 13%      +0.0        0.07 ± 23%      +0.0        0.06 ± 46%  perf-profile.children.cycles-pp.__orc_find
      0.08 ±  8%      +0.0        0.10 ± 10%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.exec_binprm
      0.07 ± 20%      +0.0        0.08 ± 17%      +0.0        0.08 ± 13%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.28 ± 27%      +0.0        0.30 ± 30%      +0.0        0.30 ± 39%  perf-profile.children.cycles-pp.machines__deliver_event
      0.10 ±  6%      +0.0        0.11 ± 16%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.account_process_tick
      0.10 ± 33%      +0.0        0.12 ± 22%      +0.0        0.13 ± 27%  perf-profile.children.cycles-pp.delete_from_page_cache
      0.30 ± 24%      +0.0        0.31 ± 21%      +0.0        0.32 ± 25%  perf-profile.children.cycles-pp.shmem_truncate_range
      0.30 ± 24%      +0.0        0.31 ± 21%      +0.0        0.32 ± 25%  perf-profile.children.cycles-pp.shmem_undo_range
      0.31 ± 28%      +0.0        0.32 ± 30%      +0.0        0.32 ± 37%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.14 ± 31%      +0.0        0.15 ± 28%      +0.0        0.15 ± 40%  perf-profile.children.cycles-pp.__dso__load_kallsyms
      0.14 ± 31%      +0.0        0.15 ± 29%      +0.0        0.16 ± 41%  perf-profile.children.cycles-pp.map__load
      0.03 ±100%      +0.0        0.04 ± 73%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.iov_iter_advance
      0.01 ±223%      +0.0        0.02 ±144%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.timekeeping_advance
      0.03 ±100%      +0.0        0.04 ± 72%      +0.0        0.04 ± 75%  perf-profile.children.cycles-pp.up_write
      0.12 ± 21%      +0.0        0.14 ± 25%      -0.0        0.12 ± 19%  perf-profile.children.cycles-pp.__unwind_start
      0.06 ± 14%      +0.0        0.08 ±  9%      +0.0        0.07 ± 16%  perf-profile.children.cycles-pp.tick_nohz_get_next_hrtimer
      0.10 ± 24%      +0.0        0.11 ± 22%      +0.0        0.13 ± 27%  perf-profile.children.cycles-pp.ksys_lseek
      0.14 ± 22%      +0.0        0.16 ± 22%      -0.0        0.13 ± 28%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.91 ±  7%      +0.0        0.92 ±  5%      -0.1        0.84 ±  5%  perf-profile.children.cycles-pp.timerqueue_add
      0.30 ± 24%      +0.0        0.32 ± 22%      +0.0        0.32 ± 25%  perf-profile.children.cycles-pp.shmem_evict_inode
      0.24 ± 13%      +0.0        0.25 ± 11%      +0.0        0.25 ± 13%  perf-profile.children.cycles-pp.do_sys_open
      0.14 ± 31%      +0.0        0.16 ± 29%      +0.0        0.16 ± 40%  perf-profile.children.cycles-pp.thread__find_map
      0.14 ± 33%      +0.0        0.15 ± 29%      +0.0        0.15 ± 40%  perf-profile.children.cycles-pp.dso__load
      0.32 ± 23%      +0.0        0.34 ± 21%      +0.0        0.34 ± 24%  perf-profile.children.cycles-pp.__dentry_kill
      0.07 ± 54%      +0.0        0.08 ± 19%      +0.0        0.08 ± 26%  perf-profile.children.cycles-pp.__delete_from_page_cache
      0.08 ± 14%      +0.0        0.09 ± 10%      +0.0        0.09 ± 14%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.02 ±142%      +0.0        0.04 ± 71%      +0.0        0.04 ± 72%  perf-profile.children.cycles-pp.lookup_fast
      0.23 ± 14%      +0.0        0.25 ± 11%      +0.0        0.25 ± 13%  perf-profile.children.cycles-pp.do_sys_openat2
      0.08 ± 17%      +0.0        0.09 ±  9%      +0.0        0.08 ± 14%  perf-profile.children.cycles-pp.dequeue_entity
      0.00            +0.0        0.02 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.call_timer_fn
      0.00            +0.0        0.02 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.run_timer_softirq
      0.04 ± 71%      +0.0        0.05 ± 49%      +0.0        0.07 ± 70%  perf-profile.children.cycles-pp.free_unref_page_list
      0.24 ± 28%      +0.0        0.25 ± 20%      -0.0        0.22 ± 17%  perf-profile.children.cycles-pp.alloc_pages_vma
      0.87            +0.0        0.88 ±  4%      +0.0        0.87 ±  5%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.20 ± 13%      +0.0        0.22 ±  8%      +0.0        0.21 ± 11%  perf-profile.children.cycles-pp.do_filp_open
      0.13 ± 19%      +0.0        0.14 ± 21%      +0.0        0.14 ± 32%  perf-profile.children.cycles-pp.release_pages
      0.33 ± 23%      +0.0        0.35 ± 19%      +0.0        0.35 ± 22%  perf-profile.children.cycles-pp.dput
      0.02 ± 99%      +0.0        0.04 ± 72%      +0.0        0.02 ± 99%  perf-profile.children.cycles-pp.__bitmap_and
      0.24 ± 30%      +0.0        0.26 ± 20%      -0.0        0.23 ± 18%  perf-profile.children.cycles-pp.shmem_alloc_page
      0.09 ± 13%      +0.0        0.10 ±  4%      +0.0        0.09 ± 14%  perf-profile.children.cycles-pp.__libc_fork
      0.27 ±  6%      +0.0        0.29 ± 20%      +0.0        0.27 ± 17%  perf-profile.children.cycles-pp.newidle_balance
      0.12 ± 32%      +0.0        0.14 ± 24%      +0.0        0.15 ± 26%  perf-profile.children.cycles-pp.truncate_inode_page
      0.02 ±144%      +0.0        0.04 ± 73%      +0.0        0.04 ± 72%  perf-profile.children.cycles-pp.pipe_write
      0.25 ± 12%      +0.0        0.26 ±  4%      +0.0        0.26 ±  5%  perf-profile.children.cycles-pp.sched_setaffinity
      0.01 ±223%      +0.0        0.03 ±100%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.shmem_file_llseek
      0.06 ± 17%      +0.0        0.08 ±  7%      +0.0        0.06 ± 17%  perf-profile.children.cycles-pp.sched_clock_tick
      0.20 ± 25%      +0.0        0.22 ± 19%      -0.0        0.19 ± 16%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.20 ± 12%      +0.0        0.22 ±  9%      +0.0        0.21 ± 11%  perf-profile.children.cycles-pp.path_openat
      0.40 ± 27%      +0.0        0.42 ± 22%      -0.0        0.39 ± 23%  perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      0.24 ± 30%      +0.0        0.26 ± 21%      -0.0        0.24 ± 22%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.19 ± 32%      +0.0        0.21 ± 30%      +0.0        0.22 ± 37%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.04 ± 71%      +0.0        0.06 ± 13%      +0.0        0.04 ± 44%  perf-profile.children.cycles-pp.copy_process
      0.02 ±141%      +0.0        0.04 ± 72%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.xas_create_range
      0.02 ±141%      +0.0        0.04 ± 72%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.86 ± 19%      +0.0        0.89 ± 17%      -0.1        0.80 ±  6%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.90 ±  3%      +0.0        0.93 ±  4%      +0.0        0.92 ±  5%  perf-profile.children.cycles-pp.__x86_retpoline_rax
      0.14 ± 23%      +0.0        0.16 ± 15%      -0.0        0.14 ± 16%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.31 ± 28%      +0.0        0.33 ± 22%      +0.0        0.31 ± 23%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.31 ± 32%      +0.0        0.33 ± 24%      +0.0        0.31 ± 24%  perf-profile.children.cycles-pp.security_file_permission
      0.35 ±  8%      +0.0        0.37 ±  6%      +0.0        0.36 ±  8%  perf-profile.children.cycles-pp.get_cpu_device
      0.04 ±101%      +0.0        0.06 ± 46%      +0.0        0.06 ± 47%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.11 ± 34%      +0.0        0.14 ± 25%      +0.0        0.11 ± 15%  perf-profile.children.cycles-pp.write@plt
      0.09 ± 29%      +0.0        0.12 ± 17%      +0.0        0.09 ± 17%  perf-profile.children.cycles-pp.rmqueue
      0.11 ± 12%      +0.0        0.13 ±  9%      +0.0        0.11 ± 12%  perf-profile.children.cycles-pp.update_rt_rq_load_avg
      0.10 ± 15%      +0.0        0.12 ± 20%      +0.0        0.12 ± 13%  perf-profile.children.cycles-pp.try_to_wake_up
      1.75 ±  6%      +0.0        1.77 ±  4%      -0.0        1.75 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.0        0.02 ±223%      +0.0        0.02 ±223%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.0        0.02 ±223%      +0.0        0.02 ±223%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.03 ±101%      +0.0        0.06 ±  9%      +0.0        0.04 ± 47%  perf-profile.children.cycles-pp.do_open
      0.06 ± 23%      +0.0        0.09 ± 21%      +0.0        0.07 ± 12%  perf-profile.children.cycles-pp.pipe_read
      0.27 ± 28%      +0.0        0.29 ± 21%      +0.0        0.27 ± 24%  perf-profile.children.cycles-pp.copyin
      0.53            +0.0        0.56 ±  7%      +0.0        0.54 ±  2%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.22 ± 11%      +0.0        0.24 ±  6%      +0.0        0.24 ±  5%  perf-profile.children.cycles-pp.irq_work_run_list
      0.22 ± 12%      +0.0        0.25 ±  5%      +0.0        0.25 ±  8%  perf-profile.children.cycles-pp.can_stop_idle_tick
      0.00            +0.0        0.03 ±100%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.orc_find
      0.00            +0.0        0.03 ±223%      +0.0        0.02 ±223%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.09 ± 25%      +0.0        0.12 ± 35%      +0.0        0.10 ± 43%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.01 ±223%      +0.0        0.04 ± 71%      +0.0        0.02 ± 99%  perf-profile.children.cycles-pp.unwind_get_return_address
      0.13 ± 29%      +0.0        0.16 ± 18%      +0.0        0.17 ± 20%  perf-profile.children.cycles-pp.process_one_work
      0.01 ±223%      +0.0        0.04 ± 71%      +0.0        0.04 ± 45%  perf-profile.children.cycles-pp.perf_output_sample
      0.20 ± 15%      +0.0        0.23 ± 25%      +0.0        0.21 ± 21%  perf-profile.children.cycles-pp.unwind_next_frame
      0.20 ±  5%      +0.0        0.23 ±  8%      +0.0        0.24 ± 10%  perf-profile.children.cycles-pp.read
      0.15 ± 24%      +0.0        0.18 ± 16%      +0.0        0.19 ± 18%  perf-profile.children.cycles-pp.worker_thread
      0.12 ± 27%      +0.0        0.15 ± 30%      +0.0        0.13 ± 37%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.39 ±  8%      +0.0        0.42 ± 12%      -0.0        0.38 ±  8%  perf-profile.children.cycles-pp.schedule
      0.54 ±  9%      +0.0        0.57 ± 16%      +0.0        0.54 ± 10%  perf-profile.children.cycles-pp.__schedule
      0.60 ± 11%      +0.0        0.63 ±  6%      +0.1        0.65 ± 11%  perf-profile.children.cycles-pp.kthread
      0.14 ±  9%      +0.0        0.18 ± 10%      +0.0        0.16 ± 17%  perf-profile.children.cycles-pp.new_sync_read
      0.03 ±100%      +0.0        0.06 ± 40%      +0.0        0.05 ± 56%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.11 ± 54%      +0.0        0.14 ± 18%      +0.0        0.15 ± 22%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.41 ± 15%      +0.0        0.44 ± 14%      +0.1        0.46 ± 17%  perf-profile.children.cycles-pp.vfs_read
      0.04 ±100%      +0.0        0.07 ± 26%      -0.0        0.03 ±101%  perf-profile.children.cycles-pp.aim_rand
      0.42 ± 15%      +0.0        0.46 ± 15%      +0.1        0.47 ± 17%  perf-profile.children.cycles-pp.ksys_read
      0.02 ±141%      +0.0        0.06 ±110%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.08 ± 61%      +0.0        0.12 ± 16%      +0.0        0.10 ± 25%  perf-profile.children.cycles-pp.memcpy_toio
      0.08 ± 61%      +0.0        0.12 ± 16%      +0.0        0.10 ± 25%  perf-profile.children.cycles-pp.drm_fb_memcpy_dstclip
      0.60 ± 12%      +0.0        0.64 ±  6%      +0.1        0.65 ± 12%  perf-profile.children.cycles-pp.ret_from_fork
      0.32 ± 31%      +0.0        0.36 ± 21%      +0.0        0.33 ± 20%  perf-profile.children.cycles-pp.shmem_alloc_and_acct_page
      0.43 ±  4%      +0.0        0.47 ±  5%      +0.0        0.44 ±  6%  perf-profile.children.cycles-pp.tick_program_event
      0.00            +0.0        0.04 ±223%      +0.0        0.03 ±223%  perf-profile.children.cycles-pp.update_nohz_stats
      0.48 ± 27%      +0.0        0.52 ± 16%      +0.0        0.50 ± 24%  perf-profile.children.cycles-pp.pagecache_get_page
      0.34 ± 21%      +0.0        0.38 ± 20%      +0.0        0.38 ± 30%  perf-profile.children.cycles-pp.task_tick_fair
      0.34 ± 14%      +0.0        0.38 ± 20%      +0.0        0.35 ± 19%  perf-profile.children.cycles-pp.get_perf_callchain
      0.34 ± 14%      +0.0        0.38 ± 19%      +0.0        0.36 ± 19%  perf-profile.children.cycles-pp.perf_callchain
      0.09 ± 60%      +0.0        0.13 ± 14%      +0.0        0.12 ± 22%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail
      0.09 ± 60%      +0.0        0.13 ± 14%      +0.0        0.12 ± 22%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.09 ± 60%      +0.0        0.13 ± 14%      +0.0        0.12 ± 22%  perf-profile.children.cycles-pp.mgag200_simple_display_pipe_update
      0.09 ± 60%      +0.0        0.13 ± 14%      +0.0        0.12 ± 22%  perf-profile.children.cycles-pp.mgag200_handle_damage
      0.09 ± 28%      +0.0        0.13 ± 35%      +0.0        0.10 ± 20%  perf-profile.children.cycles-pp.__fget_light
      0.34 ±  5%      +0.0        0.38 ±  5%      -0.0        0.32 ±  8%  perf-profile.children.cycles-pp.rb_insert_color
      0.37 ± 28%      +0.0        0.42 ± 19%      -0.0        0.37 ± 21%  perf-profile.children.cycles-pp.__entry_text_start
      0.31 ± 33%      +0.0        0.36 ± 31%      +0.0        0.33 ± 24%  perf-profile.children.cycles-pp.shmem_write_end
      0.37 ± 16%      +0.0        0.41 ± 18%      +0.0        0.40 ± 26%  perf-profile.children.cycles-pp.update_curr
      0.09 ± 60%      +0.0        0.14 ± 13%      +0.0        0.12 ± 22%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.09 ± 60%      +0.0        0.14 ± 13%      +0.0        0.12 ± 22%  perf-profile.children.cycles-pp.commit_tail
      0.27 ± 16%      +0.0        0.31 ± 22%      +0.0        0.29 ± 18%  perf-profile.children.cycles-pp.perf_callchain_kernel
      0.11 ± 31%      +0.0        0.15 ± 32%      +0.0        0.11 ± 23%  perf-profile.children.cycles-pp.__fdget_pos
      0.09 ± 60%      +0.0        0.14 ± 15%      +0.0        0.13 ± 21%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.39 ± 14%      +0.0        0.44 ± 17%      +0.0        0.42 ± 17%  perf-profile.children.cycles-pp.perf_prepare_sample
      0.33 ± 18%      +0.0        0.38 ± 19%      +0.0        0.35 ± 27%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.46 ± 11%      +0.1        0.51 ± 16%      +0.0        0.50 ± 18%  perf-profile.children.cycles-pp.perf_swevent_overflow
      0.20 ± 23%      +0.1        0.25 ± 12%      +0.0        0.20 ± 23%  perf-profile.children.cycles-pp.___might_sleep
      0.45 ± 11%      +0.1        0.50 ± 17%      +0.0        0.49 ± 18%  perf-profile.children.cycles-pp.perf_event_output_forward
      0.36 ± 25%      +0.1        0.42 ± 18%      +0.0        0.37 ± 23%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.45 ± 12%      +0.1        0.51 ± 16%      +0.0        0.49 ± 17%  perf-profile.children.cycles-pp.__perf_event_overflow
      0.48 ± 12%      +0.1        0.54 ± 16%      +0.0        0.52 ± 18%  perf-profile.children.cycles-pp.perf_tp_event
      0.05 ± 76%      +0.1        0.12 ± 42%      +0.0        0.08 ± 22%  perf-profile.children.cycles-pp.generic_write_checks
      0.60 ± 28%      +0.1        0.67 ± 19%      +0.1        0.67 ± 20%  perf-profile.children.cycles-pp.llseek
      0.38 ± 44%      +0.1        0.45 ± 54%      +0.0        0.42 ± 21%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.23 ± 11%      +0.1        0.31 ± 13%      +0.1        0.31 ±  8%  perf-profile.children.cycles-pp.cpumask_next_and
      0.35 ± 10%      +0.1        0.43 ±  9%      +0.1        0.47 ± 30%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.61 ±  4%      +0.1        0.70 ±  4%      +0.1        0.72 ±  4%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.54 ±  9%      +0.1        0.66 ±  9%      +0.1        0.67 ±  8%  perf-profile.children.cycles-pp.rcu_core
      1.43 ± 29%      +0.1        1.55 ± 18%      +0.0        1.45 ± 22%  perf-profile.children.cycles-pp.shmem_getpage_gfp
      1.46 ± 29%      +0.1        1.59 ± 18%      +0.0        1.46 ± 23%  perf-profile.children.cycles-pp.shmem_write_begin
      1.14 ±  6%      +0.1        1.28 ± 13%      +0.1        1.26 ± 11%  perf-profile.children.cycles-pp.find_busiest_group
      1.06 ±  7%      +0.1        1.21 ± 13%      +0.1        1.17 ± 12%  perf-profile.children.cycles-pp.update_sd_lb_stats
      3.11 ±  5%      +0.1        3.26 ± 12%      +0.2        3.31 ±  8%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      1.51 ±  6%      +0.2        1.70 ± 12%      +0.1        1.66 ±  8%  perf-profile.children.cycles-pp.rebalance_domains
      1.49 ±  6%      +0.2        1.68 ± 13%      +0.1        1.63 ±  9%  perf-profile.children.cycles-pp.load_balance
      2.64 ± 10%      +0.2        2.89 ±  4%      +0.1        2.79 ±  2%  perf-profile.children.cycles-pp.irqtime_account_irq
      2.81 ± 29%      +0.2        3.06 ± 20%      -0.0        2.79 ± 23%  perf-profile.children.cycles-pp.__generic_file_write_iter
      2.56 ± 29%      +0.3        2.82 ± 20%      +0.0        2.56 ± 23%  perf-profile.children.cycles-pp.generic_perform_write
      1.10 ± 49%      +0.3        1.35 ± 27%      +0.8        1.84 ± 48%  perf-profile.children.cycles-pp.x86_pmu_disable
      3.48 ±  4%      +0.3        3.80 ± 10%      +0.3        3.78 ±  6%  perf-profile.children.cycles-pp.__softirqentry_text_start
      3.12 ± 29%      +0.3        3.45 ± 20%      +0.0        3.14 ± 23%  perf-profile.children.cycles-pp.generic_file_write_iter
      3.26 ± 28%      +0.3        3.60 ± 20%      +0.0        3.30 ± 23%  perf-profile.children.cycles-pp.new_sync_write
      3.96 ± 29%      +0.4        4.34 ± 21%      +0.0        3.99 ± 23%  perf-profile.children.cycles-pp.vfs_write
      5.93 ±  5%      +0.4        6.35 ±  7%      +0.4        6.30 ±  2%  perf-profile.children.cycles-pp.irq_exit_rcu
      4.09 ± 29%      +0.4        4.51 ± 21%      +0.0        4.11 ± 23%  perf-profile.children.cycles-pp.ksys_write
      3.68 ± 14%      +0.5        4.14 ±  5%      +0.2        3.88 ±  5%  perf-profile.children.cycles-pp.native_sched_clock
      3.78 ± 14%      +0.5        4.29 ±  5%      +0.2        4.00 ±  4%  perf-profile.children.cycles-pp.sched_clock
      5.75 ± 23%      +0.5        6.26 ± 16%      +0.1        5.89 ± 16%  perf-profile.children.cycles-pp.do_syscall_64
      6.43 ± 23%      +0.5        6.94 ± 16%      +0.2        6.58 ± 16%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      4.25 ± 13%      +0.5        4.80 ±  5%      +0.3        4.52 ±  4%  perf-profile.children.cycles-pp.sched_clock_cpu
      5.32 ± 29%      +0.6        5.88 ± 21%      +0.0        5.36 ± 24%  perf-profile.children.cycles-pp.write
      0.00            +0.8        0.84 ±167%      +0.2        0.16 ±223%  perf-profile.children.cycles-pp.poll_idle
     10.41 ±  6%      +1.2       11.62 ±  6%      +0.5       10.90 ±  7%  perf-profile.children.cycles-pp.menu_select
     13.24 ±  2%      -0.7       12.50 ±  5%      -0.1       13.15 ±  2%  perf-profile.self.cycles-pp.intel_idle
      2.49 ±  8%      -0.5        1.99 ±  9%      -0.5        2.03 ±  5%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      6.24 ±  7%      -0.4        5.84 ± 12%      -0.2        6.08 ±  4%  perf-profile.self.cycles-pp.rcu_eqs_exit
      2.38 ± 13%      -0.3        2.06 ± 15%      -0.4        1.95 ± 17%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      3.23 ±  8%      -0.3        2.98 ± 17%      -0.0        3.19 ±  8%  perf-profile.self.cycles-pp.rcu_nmi_enter
      1.57 ± 19%      -0.2        1.35 ± 11%      +0.1        1.67 ± 17%  perf-profile.self.cycles-pp.scheduler_tick
      3.52 ± 17%      -0.2        3.32 ± 11%      -0.4        3.10 ±  7%  perf-profile.self.cycles-pp.ktime_get
      0.73 ±  9%      -0.2        0.55 ± 17%      -0.2        0.57 ±  3%  perf-profile.self.cycles-pp.rb_next
      1.24 ±  5%      -0.2        1.06 ±  3%      -0.2        1.08 ±  4%  perf-profile.self.cycles-pp.read_tsc
      0.77 ±  5%      -0.1        0.64 ±  6%      -0.1        0.66 ±  6%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.95 ± 22%      -0.1        0.83 ±  9%      -0.2        0.78 ± 12%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      1.06 ±  5%      -0.1        0.95 ±  3%      -0.1        0.99 ±  4%  perf-profile.self.cycles-pp.do_idle
      0.60 ±  6%      -0.1        0.50 ±  7%      -0.1        0.51 ±  5%  perf-profile.self.cycles-pp.perf_event_task_tick
      1.14 ± 20%      -0.1        1.04 ±  4%      -0.0        1.09 ± 11%  perf-profile.self.cycles-pp.update_process_times
      0.40 ± 10%      -0.1        0.31 ± 13%      -0.1        0.33 ±  8%  perf-profile.self.cycles-pp.timerqueue_del
      0.65 ±  5%      -0.1        0.57 ±  3%      -0.1        0.59 ±  4%  perf-profile.self.cycles-pp.tick_irq_enter
      2.41 ±  3%      -0.1        2.33 ±  5%      +0.1        2.49 ±  5%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.55 ±  4%      -0.1        0.48 ±  5%      -0.1        0.50 ±  3%  perf-profile.self.cycles-pp.nr_iowait_cpu
      1.35 ±  7%      -0.1        1.29 ±  5%      -0.1        1.30 ±  2%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.26 ±  8%      -0.1        0.20 ±  8%      -0.1        0.21 ± 11%  perf-profile.self.cycles-pp.tick_nohz_irq_exit
      1.55 ± 10%      -0.1        1.50 ±  5%      -0.1        1.48 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.96 ±  7%      -0.1        0.91 ± 22%      +0.0        1.00 ± 13%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_exit
      0.98 ±  4%      -0.1        0.92 ±  4%      -0.0        0.95 ±  4%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.47 ±  5%      -0.1        0.41 ±  9%      -0.0        0.45 ±  8%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.49 ±  5%      -0.0        0.45 ±  6%      -0.0        0.48 ±  5%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.06 ±  9%      -0.0        0.02 ±141%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.timerqueue_iterate_next
      0.19 ±  9%      -0.0        0.15 ±  7%      -0.0        0.14 ± 10%  perf-profile.self.cycles-pp.rcu_segcblist_ready_cbs
      0.64 ± 21%      -0.0        0.60 ± 17%      -0.1        0.59 ± 11%  perf-profile.self.cycles-pp.rcu_nmi_exit
      0.38 ±  5%      -0.0        0.35 ±  7%      -0.0        0.38 ±  6%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.60 ±  8%      -0.0        0.57 ±  5%      -0.1        0.54 ±  5%  perf-profile.self.cycles-pp.timerqueue_add
      0.44 ±  5%      -0.0        0.40 ±  6%      -0.0        0.39 ±  4%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.35 ±  3%      -0.0        0.32 ±  4%      -0.0        0.33 ±  4%  perf-profile.self.cycles-pp.clockevents_program_event
      0.66 ±  5%      -0.0        0.62 ±  6%      -0.0        0.64        perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.04 ± 71%      -0.0        0.01 ±223%      +0.0        0.04 ± 72%  perf-profile.self.cycles-pp.perf_pmu_disable
      0.16 ± 20%      -0.0        0.13 ± 19%      -0.0        0.14 ± 11%  perf-profile.self.cycles-pp.pm_qos_read_value
      0.14 ±  2%      -0.0        0.12 ± 11%      -0.0        0.11 ±  7%  perf-profile.self.cycles-pp.tick_nohz_idle_got_tick
      0.18 ± 12%      -0.0        0.16 ± 13%      -0.0        0.16 ±  6%  perf-profile.self.cycles-pp.hrtimer_update_next_event
      0.19 ± 13%      -0.0        0.17 ±  7%      -0.0        0.18 ±  7%  perf-profile.self.cycles-pp.sched_idle_set_state
      0.06 ± 13%      -0.0        0.03 ± 70%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.timer_clear_idle
      0.03 ±100%      -0.0        0.01 ±223%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.cpu_latency_qos_limit
      0.67 ±  4%      -0.0        0.64 ±  4%      -0.0        0.64 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.19 ±  8%      -0.0        0.16 ±  5%      +0.0        0.19 ±  9%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.33 ±  7%      -0.0        0.31 ±  8%      +0.0        0.34 ± 11%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.23 ±  6%      -0.0        0.21 ±  9%      -0.0        0.21 ±  5%  perf-profile.self.cycles-pp.irq_work_needs_cpu
      0.44 ± 10%      -0.0        0.42 ± 12%      -0.0        0.40 ± 13%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.19 ± 11%      -0.0        0.17 ±  6%      +0.0        0.20 ± 10%  perf-profile.self.cycles-pp.hrtimer_get_next_event
      0.18 ±  8%      -0.0        0.16 ±  4%      +0.0        0.18 ± 14%  perf-profile.self.cycles-pp.sched_clock_idle_wakeup_event
      0.03 ±100%      -0.0        0.01 ±223%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.xas_start
      0.11 ± 29%      -0.0        0.09 ± 40%      -0.0        0.09 ± 28%  perf-profile.self.cycles-pp.__generic_file_write_iter
      0.27 ±  7%      -0.0        0.25 ± 11%      -0.0        0.25 ±  9%  perf-profile.self.cycles-pp.tick_sched_timer
      0.45 ±  5%      -0.0        0.44 ±  5%      -0.0        0.44 ±  7%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.38 ± 11%      -0.0        0.36 ±  7%      -0.0        0.36 ± 10%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.22 ± 28%      -0.0        0.21 ± 17%      -0.0        0.18 ± 18%  perf-profile.self.cycles-pp.raise_softirq
      0.02 ± 99%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.rw_verify_area
      0.62 ± 11%      -0.0        0.60 ±  9%      -0.0        0.60 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.10 ± 14%      -0.0        0.08 ± 10%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.hrtimer_run_queues
      0.13 ± 16%      -0.0        0.11 ±  8%      -0.0        0.12 ± 10%  perf-profile.self.cycles-pp.profile_tick
      0.23 ± 17%      -0.0        0.22 ± 12%      +0.0        0.24 ±  5%  perf-profile.self.cycles-pp.trigger_load_balance
      0.32 ±  6%      -0.0        0.30 ±  5%      -0.0        0.30 ±  3%  perf-profile.self.cycles-pp.__hrtimer_get_next_event
      0.16 ± 10%      -0.0        0.14 ± 16%      -0.0        0.13 ± 13%  perf-profile.self.cycles-pp.tick_sched_handle
      0.15 ± 10%      -0.0        0.14 ±  8%      -0.0        0.15 ± 16%  perf-profile.self.cycles-pp.update_blocked_averages
      0.02 ±144%      -0.0        0.01 ±223%      +0.0        0.04 ± 71%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.34 ± 14%      -0.0        0.33 ± 19%      -0.0        0.30 ± 13%  perf-profile.self.cycles-pp.rcu_eqs_enter
      0.12 ±  8%      -0.0        0.11 ± 13%      -0.0        0.12 ±  9%  perf-profile.self.cycles-pp.arch_cpu_idle_enter
      0.17 ±  8%      -0.0        0.16 ± 12%      +0.0        0.18 ± 12%  perf-profile.self.cycles-pp._find_next_bit
      0.82 ±  4%      -0.0        0.81 ±  3%      -0.0        0.81 ±  5%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.07 ± 11%      -0.0        0.06 ±  9%      +0.0        0.07 ± 18%  perf-profile.self.cycles-pp.__note_gp_changes
      0.27 ±  6%      -0.0        0.26 ±  2%      +0.0        0.27 ±  9%  perf-profile.self.cycles-pp.rcu_idle_exit
      0.12 ± 29%      -0.0        0.11 ± 30%      +0.0        0.14 ± 30%  perf-profile.self.cycles-pp.queue_event
      0.02 ±142%      -0.0        0.01 ±223%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.13 ± 26%      -0.0        0.12 ± 25%      -0.0        0.11 ± 23%  perf-profile.self.cycles-pp.iov_iter_copy_from_user_atomic
      0.02 ±141%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__alloc_pages_nodemask
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.xas_store
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.timestamp_truncate
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.account_system_index_time
      0.02 ±141%      -0.0        0.01 ±223%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.unlock_page
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.arch_cpu_idle_exit
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.rcu_dynticks_task_enter
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.set_page_dirty
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.kmem_cache_alloc
      0.01 ±223%      -0.0        0.00            +0.0        0.02 ±141%  perf-profile.self.cycles-pp.number
      0.18 ±  6%      -0.0        0.18 ±  7%      -0.0        0.18 ±  7%  perf-profile.self.cycles-pp.enqueue_hrtimer
      0.21 ±  4%      -0.0        0.20 ± 10%      -0.0        0.21 ±  5%  perf-profile.self.cycles-pp.hrtimer_next_event_without
      0.36 ±  5%      -0.0        0.35 ±  3%      -0.0        0.35 ±  5%  perf-profile.self.cycles-pp.__remove_hrtimer
      0.06 ± 14%      -0.0        0.06 ± 11%      +0.0        0.07 ± 14%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.09 ± 10%      -0.0        0.08 ± 10%      -0.0        0.08 ± 13%  perf-profile.self.cycles-pp.task_tick_idle
      0.02 ±141%      -0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.find_lock_entries
      0.05 ± 78%      -0.0        0.04 ± 73%      +0.0        0.05 ± 45%  perf-profile.self.cycles-pp.ksys_write
      0.37 ±  5%      -0.0        0.36 ±  8%      -0.0        0.36 ±  5%  perf-profile.self.cycles-pp.irq_enter_rcu
      0.12 ± 15%      -0.0        0.11 ± 10%      -0.0        0.10 ± 11%  perf-profile.self.cycles-pp.local_touch_nmi
      0.12 ± 16%      -0.0        0.11 ±  9%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.io_serial_in
      0.44 ±  4%      -0.0        0.43 ±  3%      +0.0        0.44 ±  2%  perf-profile.self.cycles-pp.__x86_retpoline_rax
      0.48 ±  7%      -0.0        0.47 ±  4%      +0.0        0.48 ±  5%  perf-profile.self.cycles-pp.update_rq_clock
      0.12 ± 27%      -0.0        0.11 ± 25%      -0.0        0.10 ± 19%  perf-profile.self.cycles-pp.generic_perform_write
      1.62 ±  4%      -0.0        1.61 ±  3%      -0.0        1.59 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.07 ± 16%      -0.0        0.06 ±  7%      -0.0        0.06 ± 17%  perf-profile.self.cycles-pp.note_gp_changes
      0.10 ±  7%      -0.0        0.09 ± 14%      +0.0        0.10 ±  9%  perf-profile.self.cycles-pp.ksoftirqd_running
      0.39 ±  9%      -0.0        0.39 ±  9%      -0.0        0.38 ±  6%  perf-profile.self.cycles-pp.hrtimer_forward
      0.19 ±  2%      -0.0        0.19 ±  7%      -0.0        0.18 ± 10%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.51 ±  8%      -0.0        0.50 ±  6%      -0.0        0.50 ±  5%  perf-profile.self.cycles-pp.idle_cpu
      0.21 ± 12%      -0.0        0.21 ±  9%      +0.0        0.23 ±  8%  perf-profile.self.cycles-pp.call_cpuidle
      0.04 ± 45%      -0.0        0.04 ± 44%      +0.0        0.05 ± 46%  perf-profile.self.cycles-pp.run_rebalance_domains
      0.06 ± 54%      -0.0        0.06 ± 49%      +0.0        0.07 ± 23%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.04 ± 72%      -0.0        0.04 ± 71%      +0.0        0.05 ±  7%  perf-profile.self.cycles-pp.__x86_retpoline_rbx
      0.10 ± 17%      -0.0        0.10 ± 15%      -0.0        0.10 ± 10%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.07 ± 11%      -0.0        0.06 ±  7%      +0.0        0.08 ± 11%  perf-profile.self.cycles-pp.find_busiest_group
      0.07 ± 16%      -0.0        0.07 ± 15%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.17 ± 11%      -0.0        0.17 ±  9%      +0.0        0.19 ± 17%  perf-profile.self.cycles-pp.rcu_is_cpu_rrupt_from_idle
      0.03 ± 70%      +0.0        0.03 ± 70%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.cpuidle_get_cpu_driver
      0.02 ±142%      +0.0        0.02 ±142%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.shmem_write_begin
      0.01 ±223%      +0.0        0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.shmem_file_llseek
      0.03 ±100%      +0.0        0.03 ±100%      +0.0        0.03 ±100%  perf-profile.self.cycles-pp.aa_file_perm
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.copyin
      0.00            +0.0        0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.00            +0.0        0.00            +0.0        0.02 ±141%  perf-profile.self.cycles-pp.memcpy_erms
      0.00            +0.0        0.00            +0.0        0.02 ±141%  perf-profile.self.cycles-pp.find_idlest_group
      0.00            +0.0        0.00            +0.0        0.02 ±142%  perf-profile.self.cycles-pp.lseek@plt
      0.00            +0.0        0.00            +0.0        0.03 ± 70%  perf-profile.self.cycles-pp.__intel_pmu_disable_all
      0.32 ±  9%      +0.0        0.32 ±  5%      -0.0        0.31 ±  4%  perf-profile.self.cycles-pp.rcu_needs_cpu
      0.06 ± 15%      +0.0        0.06 ±  9%      +0.0        0.06 ± 11%  perf-profile.self.cycles-pp.update_group_capacity
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.03 ± 70%      +0.0        0.04 ± 71%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.intel_pmu_disable_all
      0.05 ± 51%      +0.0        0.05 ± 53%      +0.0        0.08 ± 31%  perf-profile.self.cycles-pp.dyntick_save_progress_counter
      0.21 ±  2%      +0.0        0.21 ±  5%      +0.0        0.21 ±  8%  perf-profile.self.cycles-pp.menu_reflect
      0.10 ± 25%      +0.0        0.10 ± 26%      -0.0        0.09 ± 17%  perf-profile.self.cycles-pp.common_file_perm
      0.13 ±  9%      +0.0        0.13 ±  7%      +0.0        0.13 ±  8%  perf-profile.self.cycles-pp.restore_regs_and_return_to_kernel
      0.06 ± 51%      +0.0        0.06 ± 51%      +0.0        0.06 ± 49%  perf-profile.self.cycles-pp.page_mapping
      0.12 ± 24%      +0.0        0.12 ± 25%      -0.0        0.10 ± 34%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.09 ±  5%      +0.0        0.09 ± 12%      -0.0        0.08 ± 16%  perf-profile.self.cycles-pp.cpuidle_reflect
      0.80 ±  6%      +0.0        0.81 ±  7%      +0.0        0.82 ±  6%  perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
      0.01 ±223%      +0.0        0.01 ±223%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.file_update_time
      0.15 ± 28%      +0.0        0.15 ± 24%      -0.0        0.14 ± 24%  perf-profile.self.cycles-pp.sync_disk_rw
      0.24 ±  9%      +0.0        0.25 ±  7%      +0.0        0.24 ±  7%  perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.12 ± 33%      +0.0        0.12 ± 11%      +0.0        0.12 ±  9%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.20 ±  6%      +0.0        0.20 ±  7%      +0.0        0.20 ±  9%  perf-profile.self.cycles-pp.rb_erase
      0.14 ±  8%      +0.0        0.14 ±  5%      +0.0        0.16 ± 12%  perf-profile.self.cycles-pp.irq_work_tick
      0.28 ±  5%      +0.0        0.28 ± 10%      +0.0        0.30 ±  4%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.07 ± 23%      +0.0        0.08 ± 21%      -0.0        0.06 ± 45%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.14 ±  9%      +0.0        0.14 ± 11%      -0.0        0.14 ± 10%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_enter
      0.10 ±  3%      +0.0        0.10 ± 16%      +0.0        0.12 ± 11%  perf-profile.self.cycles-pp.account_process_tick
      0.01 ±223%      +0.0        0.02 ±142%      +0.0        0.03 ±100%  perf-profile.self.cycles-pp.__set_page_dirty_no_writeback
      0.06 ± 17%      +0.0        0.07 ± 14%      +0.0        0.06 ± 19%  perf-profile.self.cycles-pp.tick_nohz_get_next_hrtimer
      0.12 ± 18%      +0.0        0.13 ±  6%      +0.0        0.12 ± 15%  perf-profile.self.cycles-pp.irqentry_exit
      0.15 ±  7%      +0.0        0.15 ± 12%      +0.0        0.15 ± 14%  perf-profile.self.cycles-pp.rcu_dynticks_task_exit
      0.02 ±142%      +0.0        0.03 ±100%      -0.0        0.02 ±142%  perf-profile.self.cycles-pp.do_syscall_64
      0.06 ± 23%      +0.0        0.07 ± 24%      -0.0        0.06 ± 51%  perf-profile.self.cycles-pp.new_sync_write
      0.06 ± 11%      +0.0        0.07 ±  9%      +0.0        0.07 ± 16%  perf-profile.self.cycles-pp.check_tsc_unstable
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.timekeeping_advance
      0.00            +0.0        0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.__pagevec_lru_add
      0.00            +0.0        0.01 ±223%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.generic_write_checks
      0.00            +0.0        0.01 ±223%      +0.0        0.04 ± 71%  perf-profile.self.cycles-pp.tick_nohz_idle_retain_tick
      0.02 ±142%      +0.0        0.03 ±100%      +0.0        0.03 ±100%  perf-profile.self.cycles-pp.free_pcppages_bulk
      0.06 ± 47%      +0.0        0.06 ± 11%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.19 ±  3%      +0.0        0.20 ±  8%      +0.0        0.20 ±  9%  perf-profile.self.cycles-pp.irqentry_enter
      0.10 ± 27%      +0.0        0.10 ± 16%      -0.0        0.09 ± 22%  perf-profile.self.cycles-pp.xas_load
      0.10 ± 14%      +0.0        0.11 ±  9%      +0.0        0.11 ± 12%  perf-profile.self.cycles-pp.update_dl_rq_load_avg
      0.03 ±100%      +0.0        0.04 ± 75%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.iov_iter_advance
      0.07 ± 24%      +0.0        0.08 ± 28%      -0.0        0.07 ± 14%  perf-profile.self.cycles-pp.__might_sleep
      0.02 ±141%      +0.0        0.03 ±101%      +0.0        0.03 ±100%  perf-profile.self.cycles-pp.down_write
      0.00            +0.0        0.01 ±223%      +0.0        0.00        perf-profile.self.cycles-pp.__cond_resched
      0.00            +0.0        0.01 ±223%      +0.0        0.02 ±144%  perf-profile.self.cycles-pp.kallsyms__parse
      0.02 ±141%      +0.0        0.03 ±100%      +0.0        0.02 ±142%  perf-profile.self.cycles-pp.up_write
      0.08 ± 22%      +0.0        0.09 ± 30%      +0.0        0.08 ± 23%  perf-profile.self.cycles-pp.unwind_next_frame
      0.06 ± 13%      +0.0        0.07 ± 23%      +0.0        0.06 ± 48%  perf-profile.self.cycles-pp.__orc_find
      0.04 ±100%      +0.0        0.05 ± 50%      +0.0        0.05 ± 47%  perf-profile.self.cycles-pp.mark_page_accessed
      0.56 ±  5%      +0.0        0.57 ±  4%      +0.0        0.58 ±  4%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.15 ± 33%      +0.0        0.16 ± 30%      -0.0        0.14 ± 26%  perf-profile.self.cycles-pp.shmem_write_end
      0.11 ± 34%      +0.0        0.12 ± 15%      +0.0        0.11 ± 25%  perf-profile.self.cycles-pp.llseek
      0.04 ± 71%      +0.0        0.05 ± 47%      +0.0        0.06 ± 19%  perf-profile.self.cycles-pp.cpuidle_select
      0.04 ±101%      +0.0        0.05 ± 53%      +0.0        0.06 ± 51%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.08 ± 12%      +0.0        0.09 ± 11%      +0.0        0.09 ± 12%  perf-profile.self.cycles-pp.rcu_idle_enter
      0.06 ± 52%      +0.0        0.08 ± 14%      -0.0        0.06 ± 48%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.00            +0.0        0.02 ±223%      +0.0        0.02 ±223%  perf-profile.self.cycles-pp.update_nohz_stats
      0.00            +0.0        0.02 ±141%      +0.0        0.02 ±142%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.01 ±223%      +0.0        0.02 ± 99%      -0.0        0.00        perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      0.01 ±223%      +0.0        0.02 ± 99%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.mem_cgroup_charge
      0.07 ± 51%      +0.0        0.08 ± 21%      +0.0        0.08 ± 24%  perf-profile.self.cycles-pp.__fget_light
      0.25 ±  9%      +0.0        0.27 ±  7%      +0.0        0.25 ±  7%  perf-profile.self.cycles-pp.rebalance_domains
      0.85            +0.0        0.87 ±  3%      +0.0        0.85 ±  5%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.27 ± 29%      +0.0        0.29 ± 26%      -0.0        0.26 ± 31%  perf-profile.self.cycles-pp.write
      0.00            +0.0        0.02 ±142%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.orc_find
      0.10 ± 28%      +0.0        0.12 ± 25%      +0.0        0.11 ± 27%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.21 ±  6%      +0.0        0.23 ± 12%      +0.0        0.22 ±  4%  perf-profile.self.cycles-pp.load_balance
      0.08 ± 13%      +0.0        0.10 ± 13%      +0.0        0.10 ± 11%  perf-profile.self.cycles-pp.irq_work_run_list
      0.80 ± 21%      +0.0        0.82 ± 16%      -0.1        0.74 ±  7%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.22 ± 31%      +0.0        0.24 ± 21%      -0.0        0.21 ± 24%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.21 ±  8%      +0.0        0.23 ±  5%      +0.0        0.22 ±  7%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
      0.18 ± 16%      +0.0        0.20 ± 11%      -0.0        0.18 ± 14%  perf-profile.self.cycles-pp.cpuidle_enter
      0.02 ±141%      +0.0        0.04 ± 72%      +0.0        0.02 ± 99%  perf-profile.self.cycles-pp.__bitmap_and
      0.10 ± 34%      +0.0        0.13 ± 17%      +0.0        0.12 ± 24%  perf-profile.self.cycles-pp.shmem_getpage_gfp
      0.19 ± 36%      +0.0        0.22 ± 21%      +0.0        0.22 ± 18%  perf-profile.self.cycles-pp.vfs_write
      0.06 ± 74%      +0.0        0.08 ± 23%      +0.0        0.07 ± 50%  perf-profile.self.cycles-pp.generic_file_write_iter
      0.05 ± 47%      +0.0        0.07 ±  8%      +0.0        0.05 ± 46%  perf-profile.self.cycles-pp.sched_clock_tick
      0.46 ±  3%      +0.0        0.48 ±  8%      -0.0        0.46 ±  2%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.24 ± 34%      +0.0        0.26 ± 25%      +0.0        0.25 ± 26%  perf-profile.self.cycles-pp.pagecache_get_page
      0.21 ± 10%      +0.0        0.24 ±  5%      +0.0        0.24 ±  9%  perf-profile.self.cycles-pp.can_stop_idle_tick
      0.00            +0.0        0.02 ± 99%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.release_pages
      0.11 ± 11%      +0.0        0.13 ±  9%      +0.0        0.11 ± 12%  perf-profile.self.cycles-pp.update_rt_rq_load_avg
      0.10 ± 39%      +0.0        0.13 ± 25%      +0.0        0.12 ± 29%  perf-profile.self.cycles-pp.security_file_permission
      0.30 ± 30%      +0.0        0.33 ± 19%      -0.0        0.30 ± 21%  perf-profile.self.cycles-pp.__entry_text_start
      0.69 ± 10%      +0.0        0.71 ±  5%      +0.0        0.69 ±  6%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.03 ±100%      +0.0        0.06 ± 50%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.aim_rand
      0.34 ±  8%      +0.0        0.37 ±  6%      +0.0        0.35 ±  9%  perf-profile.self.cycles-pp.get_cpu_device
      0.10 ± 36%      +0.0        0.13 ± 26%      +0.0        0.11 ± 15%  perf-profile.self.cycles-pp.write@plt
      0.06 ± 54%      +0.0        0.10 ± 13%      +0.0        0.08 ± 21%  perf-profile.self.cycles-pp.memcpy_toio
      0.18 ± 25%      +0.0        0.21 ± 16%      +0.0        0.19 ± 23%  perf-profile.self.cycles-pp.___might_sleep
      0.32 ±  5%      +0.0        0.36 ±  6%      -0.0        0.30 ±  7%  perf-profile.self.cycles-pp.rb_insert_color
      0.01 ±223%      +0.0        0.05 ±108%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.42 ±  3%      +0.0        0.46 ±  6%      +0.0        0.44 ±  5%  perf-profile.self.cycles-pp.tick_program_event
      0.69 ± 11%      +0.1        0.75 ±  3%      +0.1        0.78 ±  8%  perf-profile.self.cycles-pp.irq_exit_rcu
      0.50 ±  5%      +0.1        0.56 ±  7%      +0.1        0.55 ±  4%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.36 ± 25%      +0.1        0.41 ± 18%      +0.0        0.37 ± 23%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.05 ±  5%      +0.1        1.12 ±  3%      +0.1        1.11 ±  4%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.37 ± 45%      +0.1        0.44 ± 56%      +0.0        0.41 ± 21%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.06 ± 47%      +0.1        0.13 ±  9%      +0.1        0.12 ±  7%  perf-profile.self.cycles-pp.cpumask_next_and
      0.35 ± 10%      +0.1        0.43 ±  9%      +0.1        0.47 ± 30%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.35 ±  5%      +0.1        0.48 ±  9%      +0.1        0.48 ± 12%  perf-profile.self.cycles-pp.sched_clock
      0.14 ±  9%      +0.1        0.26 ±  5%      +0.1        0.27 ± 10%  perf-profile.self.cycles-pp.rcu_core
      0.31 ±  7%      +0.1        0.44 ±  6%      +0.1        0.45 ±  7%  perf-profile.self.cycles-pp.update_ts_time_stats
      2.57 ±  8%      +0.2        2.78 ± 14%      +0.3        2.84 ±  8%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      1.08 ± 50%      +0.3        1.34 ± 27%      +0.7        1.83 ± 48%  perf-profile.self.cycles-pp.x86_pmu_disable
      3.38 ± 15%      +0.4        3.75 ±  6%      +0.1        3.47 ±  5%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.6        0.57 ±165%      +0.1        0.10 ±223%  perf-profile.self.cycles-pp.poll_idle
      3.46 ± 21%      +1.7        5.12 ± 10%      +0.9        4.34 ± 17%  perf-profile.self.cycles-pp.menu_select
    434.50 ±  2%      +8.6%     472.00            +9.7%     476.50        softirqs.BLOCK
      9.00 ±223%     -13.0%       7.83 ±107%      -7.4%       8.33 ±173%  softirqs.CPU0.BLOCK
      5.00            +0.0%       5.00            +0.0%       5.00        softirqs.CPU0.HI
      0.67 ± 70%     -75.0%       0.17 ±223%     -75.0%       0.17 ±223%  softirqs.CPU0.NET_TX
     35776 ±  9%      -3.2%      34620 ± 10%      -1.4%      35269 ± 10%  softirqs.CPU0.RCU
     29141 ±  6%      -9.4%      26390 ± 25%      +2.8%      29959 ±  2%  softirqs.CPU0.SCHED
    147.00 ±  6%      -2.3%     143.67            -2.7%     143.00        softirqs.CPU0.TASKLET
      6844 ± 38%     -52.1%       3278 ± 53%     -49.4%       3463 ± 48%  softirqs.CPU0.TIMER
      3.00 ±152%    -100.0%       0.00            +0.0%       3.00 ±152%  softirqs.CPU1.BLOCK
      0.00       +1.7e+101%       0.17 ±223% +1.7e+101%       0.17 ±223%  softirqs.CPU1.NET_TX
     35084 ± 11%      -2.9%      34068 ±  7%      +0.4%      35220 ± 13%  softirqs.CPU1.RCU
     23986 ± 17%     +19.6%      28683 ±  4%      +6.9%      25648 ± 15%  softirqs.CPU1.SCHED
      0.17 ±223%      +0.0%       0.17 ±223%    -100.0%       0.00        softirqs.CPU1.TASKLET
      1027 ±130%     +66.6%       1711 ±173%     +59.4%       1638 ±158%  softirqs.CPU1.TIMER
      0.17 ±223%   +3400.0%       5.83 ±223%    -100.0%       0.00        softirqs.CPU10.BLOCK
     34948 ±  4%     -14.2%      30000 ± 10%      -9.1%      31762 ± 10%  softirqs.CPU10.RCU
     25984 ±  3%     -11.4%      23033 ± 21%      -0.8%      25765 ±  2%  softirqs.CPU10.SCHED
      2.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU10.TASKLET
     77.50 ± 11%     +32.3%     102.50 ± 57%     -13.3%      67.17 ± 16%  softirqs.CPU10.TIMER
      3.67 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU100.BLOCK
     28392            -8.7%      25917 ±  7%      -5.4%      26869 ± 10%  softirqs.CPU100.RCU
     26738            +0.0%      26749           -20.9%      21146 ± 34%  softirqs.CPU100.SCHED
    146.00 ±136%     -82.5%      25.50 ±  9%     -75.7%      35.50 ± 34%  softirqs.CPU100.TIMER
     28160            -7.7%      25999 ±  7%      -5.8%      26538 ± 10%  softirqs.CPU101.RCU
     26689            +0.6%      26852            -9.6%      24128 ± 25%  softirqs.CPU101.SCHED
     43.33 ± 89%     -33.8%      28.67 ± 17%     -20.4%      34.50 ± 33%  softirqs.CPU101.TIMER
      2.50 ±206%     +20.0%       3.00 ±223%    +306.7%      10.17 ±223%  softirqs.CPU102.BLOCK
     28592 ±  3%      -6.1%      26860 ± 11%      -5.5%      27031 ± 11%  softirqs.CPU102.RCU
     25946 ±  5%      -5.9%      24427 ± 14%      +3.0%      26732        softirqs.CPU102.SCHED
    150.83 ±165%     -67.4%      49.17 ± 56%     +26.9%     191.33 ±179%  softirqs.CPU102.TIMER
      6.83 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU103.BLOCK
     29325 ±  8%      -8.4%      26854 ±  9%      -9.0%      26675 ±  9%  softirqs.CPU103.RCU
     26751            -0.0%      26748            -0.5%      26617        softirqs.CPU103.SCHED
     83.17 ±129%     -53.3%      38.83 ± 37%     -61.7%      31.83 ± 21%  softirqs.CPU103.TIMER
      2.17 ±223%    -100.0%       0.00           -84.6%       0.33 ±223%  softirqs.CPU104.BLOCK
     29079           -13.3%      25221 ± 10%      -2.4%      28370 ± 16%  softirqs.CPU104.RCU
     23130 ± 25%      +3.4%      23910 ± 23%     +12.0%      25905 ±  4%  softirqs.CPU104.SCHED
     27.83 ± 23%   +3231.7%     927.33 ±210%    +125.1%      62.67 ± 89%  softirqs.CPU104.TIMER
      0.00       +6.2e+102%       6.17 ±141%    -100.0%       0.00        softirqs.CPU105.BLOCK
     28935 ±  2%      -9.1%      26301 ±  4%      -5.7%      27295 ± 12%  softirqs.CPU105.RCU
     25044 ± 16%      +6.2%      26607            +2.9%      25775 ±  6%  softirqs.CPU105.SCHED
     25.00 ± 29%   +2926.0%     756.50 ±153%     +29.3%      32.33 ± 26%  softirqs.CPU105.TIMER
      0.00          -100.0%       0.00       +1.7e+102%       1.67 ±223%  softirqs.CPU106.BLOCK
     29505 ±  6%     -12.2%      25918 ±  7%      -8.9%      26874 ± 11%  softirqs.CPU106.RCU
     23598 ± 18%     +13.1%      26699            +8.1%      25515 ±  8%  softirqs.CPU106.SCHED
     36.00 ± 36%     -13.9%      31.00 ± 20%      +6.0%      38.17 ± 12%  softirqs.CPU106.TIMER
      0.00          -100.0%       0.00       +1.3e+102%       1.33 ±192%  softirqs.CPU107.BLOCK
     28333            -8.8%      25850 ±  7%      -5.4%      26802 ± 11%  softirqs.CPU107.RCU
     26729            +0.2%      26785            +1.6%      27148 ±  4%  softirqs.CPU107.SCHED
     24.00 ± 15%     +91.0%      45.83 ± 74%     +97.2%      47.33 ± 88%  softirqs.CPU107.TIMER
      0.00          -100.0%       0.00       +7.5e+102%       7.50 ±223%  softirqs.CPU108.BLOCK
     30095 ±  7%     -12.2%      26433 ±  9%      -8.9%      27413 ±  9%  softirqs.CPU108.RCU
     24013 ± 23%     +10.3%      26495            +9.3%      26237        softirqs.CPU108.SCHED
      0.00          -100.0%       0.00       +9.7e+102%       9.67 ±223%  softirqs.CPU108.TASKLET
     35.33 ± 30%     +90.6%      67.33 ± 77%      -5.2%      33.50 ± 20%  softirqs.CPU108.TIMER
     28970            -8.2%      26601 ±  9%      -4.7%      27600 ± 10%  softirqs.CPU109.RCU
     24795 ± 15%      +7.2%      26581            -2.3%      24228 ± 23%  softirqs.CPU109.SCHED
     22.83 ± 10%    +138.7%      54.50 ±112%   +1581.0%     383.83 ±205%  softirqs.CPU109.TIMER
      4.67 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU11.BLOCK
     36.33           +17.0%      42.50           +16.1%      42.17        softirqs.CPU11.NET_TX
     34319 ±  6%     -13.0%      29855 ± 10%      -6.8%      31989 ± 10%  softirqs.CPU11.RCU
     24651 ± 18%      +6.4%      26218 ±  7%      +6.8%      26332 ±  2%  softirqs.CPU11.SCHED
      1.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU11.TASKLET
    328.67 ± 65%      -9.9%     296.00 ± 49%     +44.9%     476.33 ±122%  softirqs.CPU11.TIMER
      0.00       +1.3e+102%       1.33 ±223%    -100.0%       0.00        softirqs.CPU110.BLOCK
     28820 ±  2%      -9.0%      26237 ±  8%      -6.1%      27074 ± 11%  softirqs.CPU110.RCU
     24364 ± 20%      -1.6%      23964 ± 24%      +9.6%      26714        softirqs.CPU110.SCHED
     41.17 ± 55%     +40.9%      58.00 ± 88%    +475.3%     236.83 ±163%  softirqs.CPU110.TIMER
     29062 ±  3%      -8.6%      26556 ±  7%      -6.8%      27091 ± 11%  softirqs.CPU111.RCU
     26453 ±  2%      -6.2%      24815 ± 16%      -6.7%      24674 ± 17%  softirqs.CPU111.SCHED
     62.83 ±132%     -39.5%      38.00 ± 38%    +310.1%     257.67 ± 82%  softirqs.CPU111.TIMER
      0.00       +6.3e+102%       6.33 ±154% +3.3e+101%       0.33 ±223%  softirqs.CPU112.BLOCK
     29277 ±  3%      -7.2%      27165 ±  8%      -4.3%      28007 ± 13%  softirqs.CPU112.RCU
     26153 ±  4%      -1.0%      25880 ±  7%      -3.3%      25278 ± 11%  softirqs.CPU112.SCHED
     68.00 ± 84%     -11.0%      60.50 ±104%    +337.3%     297.33 ±195%  softirqs.CPU112.TIMER
      0.33 ±223%      +0.0%       0.33 ±223%    -100.0%       0.00        softirqs.CPU113.BLOCK
     28773            -6.3%      26956 ± 11%      -7.1%      26717 ± 10%  softirqs.CPU113.RCU
     26580            +1.1%      26879            -0.2%      26522        softirqs.CPU113.SCHED
     33.17 ± 48%      -4.5%      31.67 ± 37%     +17.6%      39.00 ±100%  softirqs.CPU113.TIMER
      0.00         +3e+102%       3.00 ±142% +8.3e+101%       0.83 ±223%  softirqs.CPU114.BLOCK
     28732            -8.8%      26191 ±  7%      -3.0%      27881 ±  4%  softirqs.CPU114.RCU
     26709            -0.7%      26527            -0.6%      26559        softirqs.CPU114.SCHED
    248.83 ±134%     -85.1%      37.00 ± 34%     -86.3%      34.00 ± 26%  softirqs.CPU114.TIMER
      0.00       +2.5e+102%       2.50 ±141%    -100.0%       0.00        softirqs.CPU115.BLOCK
     28054 ± 11%      -5.5%      26501 ± 10%      -3.8%      26977 ± 10%  softirqs.CPU115.RCU
     26096 ±  4%      -5.8%      24583 ± 17%      +1.8%      26565        softirqs.CPU115.SCHED
      2323 ±219%     -98.9%      26.33 ± 20%     -98.2%      42.67 ± 92%  softirqs.CPU115.TIMER
     28487            -8.9%      25937 ±  8%      -8.2%      26149 ±  9%  softirqs.CPU116.RCU
     23078 ± 23%      +5.0%      24243 ± 23%     +15.4%      26629        softirqs.CPU116.SCHED
      0.00       +3.3e+101%       0.33 ±223%    -100.0%       0.00        softirqs.CPU116.TASKLET
     25.33 ± 29%     +25.7%      31.83 ± 33%   +3900.0%       1013 ±208%  softirqs.CPU116.TIMER
      0.00       +2.8e+102%       2.83 ±141%    -100.0%       0.00        softirqs.CPU117.BLOCK
     28733 ±  2%      -4.0%      27596 ± 13%      -8.0%      26445 ±  9%  softirqs.CPU117.RCU
     26783 ±  2%      +0.2%      26835            -0.7%      26596        softirqs.CPU117.SCHED
     25.33 ± 26%    +247.4%      88.00 ±106%   +1948.7%     519.00 ±200%  softirqs.CPU117.TIMER
      0.00       +2.7e+102%       2.67 ±223% +1.3e+102%       1.33 ±223%  softirqs.CPU118.BLOCK
     28515 ±  2%      -9.5%      25811 ±  8%      -5.3%      27011 ±  9%  softirqs.CPU118.RCU
     26886           -14.0%      23130 ± 25%      -0.9%      26632        softirqs.CPU118.SCHED
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU118.TASKLET
     91.67 ±152%     -67.5%      29.83 ± 15%     -36.9%      57.83 ±116%  softirqs.CPU118.TIMER
      0.00          -100.0%       0.00         +2e+102%       2.00 ±223%  softirqs.CPU119.BLOCK
     28638            -8.9%      26089 ±  7%      -6.3%      26820 ±  9%  softirqs.CPU119.RCU
     24315 ± 24%      +9.9%      26722            +9.8%      26689        softirqs.CPU119.SCHED
     27.67 ± 51%      +2.4%      28.33 ± 35%      -1.8%      27.17 ± 16%  softirqs.CPU119.TIMER
      0.83 ±223%    -100.0%       0.00           +60.0%       1.33 ±223%  softirqs.CPU12.BLOCK
    870.50 ± 87%    +212.6%       2720 ±106%    +223.6%       2817 ±118%  softirqs.CPU12.NET_RX
      1.83 ± 58%     +45.5%       2.67 ± 27%     +36.4%       2.50 ± 50%  softirqs.CPU12.NET_TX
     30950 ±  3%      -7.3%      28686 ±  8%      -3.1%      29982 ±  9%  softirqs.CPU12.RCU
     24174 ± 20%      +3.8%      25087 ± 19%     +14.5%      27690 ±  4%  softirqs.CPU12.SCHED
    143.83 ± 95%    +106.1%     296.50 ±142%    +537.7%     917.17 ±195%  softirqs.CPU12.TIMER
      0.33 ±223%    -100.0%       0.00         +1450.0%       5.17 ±223%  softirqs.CPU120.BLOCK
     28462 ±  3%      -3.0%      27598 ± 14%      -5.2%      26975 ± 10%  softirqs.CPU120.RCU
     23950 ± 24%      +3.6%      24819 ± 12%     +11.2%      26644        softirqs.CPU120.SCHED
      1281 ±218%     -90.4%     123.67 ±126%     -97.6%      31.17 ± 29%  softirqs.CPU120.TIMER
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU121.BLOCK
     28771            -9.3%      26096 ±  8%      -6.4%      26938 ± 10%  softirqs.CPU121.RCU
     23976 ± 25%      +1.2%      24254 ± 22%     +10.3%      26447        softirqs.CPU121.SCHED
    168.33 ±190%     -18.0%     138.00 ± 87%     -79.8%      34.00 ± 30%  softirqs.CPU121.TIMER
     28825 ±  2%      -8.4%      26397 ±  7%      -6.2%      27034 ±  9%  softirqs.CPU122.RCU
     26524            -0.1%      26503            +0.1%      26544        softirqs.CPU122.SCHED
     39.67 ± 55%     -13.9%      34.17 ± 39%      -6.3%      37.17 ± 48%  softirqs.CPU122.TIMER
     28915 ±  2%     -10.0%      26021 ±  7%      -6.3%      27080 ± 10%  softirqs.CPU123.RCU
     26752            -1.0%      26493            -1.0%      26493        softirqs.CPU123.SCHED
    221.67 ±198%     -85.9%      31.17 ± 30%     -84.3%      34.83 ± 55%  softirqs.CPU123.TIMER
      1.17 ±223%      +0.0%       1.17 ±223%    -100.0%       0.00        softirqs.CPU124.BLOCK
     28583 ±  2%     -10.1%      25709 ±  8%      -5.9%      26894 ± 10%  softirqs.CPU124.RCU
     24184 ± 22%     -11.7%      21352 ± 34%     +10.2%      26661        softirqs.CPU124.SCHED
     26.17 ± 11%     +36.3%      35.67 ± 63%   +1858.6%     512.50 ±197%  softirqs.CPU124.TIMER
      4.17 ±142%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU125.BLOCK
     29849 ±  8%     -13.0%      25970 ±  7%     -10.8%      26614 ± 10%  softirqs.CPU125.RCU
     24034 ± 25%      +0.7%      24191 ± 23%      +2.6%      24656 ± 21%  softirqs.CPU125.SCHED
      0.00         +1e+103%      10.00 ±223%    -100.0%       0.00        softirqs.CPU125.TASKLET
     40.83 ± 80%     -23.7%      31.17 ± 29%   +1953.1%     838.33 ±213%  softirqs.CPU125.TIMER
     10.17 ±116%    -100.0%       0.00           -80.3%       2.00 ±223%  softirqs.CPU126.BLOCK
     28622 ±  3%      -9.5%      25909 ±  7%      -6.5%      26771 ± 10%  softirqs.CPU126.RCU
     26568            +0.5%      26694            -2.1%      26012 ±  5%  softirqs.CPU126.SCHED
      8.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU126.TASKLET
     47.67 ± 60%      -4.5%      45.50 ± 47%      +6.3%      50.67 ± 63%  softirqs.CPU126.TIMER
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU127.BLOCK
     28787            -9.2%      26131 ±  7%      -5.4%      27221 ± 10%  softirqs.CPU127.RCU
     13716 ± 17%     -17.4%      11336 ±  6%      +3.2%      14152 ± 19%  softirqs.CPU127.SCHED
     23.67 ±  9%     +34.5%      31.83 ± 47%    +257.0%      84.50 ±148%  softirqs.CPU127.TIMER
     27779            -7.4%      25710 ±  8%      -3.9%      26685 ± 10%  softirqs.CPU128.RCU
     24576 ± 20%      +4.9%      25789 ±  7%      +2.5%      25186 ±  7%  softirqs.CPU128.SCHED
      0.00       +6.3e+102%       6.33 ±223%    -100.0%       0.00        softirqs.CPU128.TASKLET
    257.00 ±206%     -82.2%      45.67 ± 89%     -90.1%      25.50 ± 70%  softirqs.CPU128.TIMER
      4.50 ±223%    -100.0%       0.00           +18.5%       5.33 ±223%  softirqs.CPU129.BLOCK
     27926 ±  2%      -7.9%      25719 ±  5%      -3.4%      26963 ±  8%  softirqs.CPU129.RCU
     21859 ± 29%     +18.7%      25937 ±  6%     +11.2%      24299 ± 16%  softirqs.CPU129.SCHED
      1.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU129.TASKLET
    204.00 ±162%     -86.9%      26.67 ± 65%     +85.9%     379.17 ±115%  softirqs.CPU129.TIMER
      0.33 ±223%   +3850.0%      13.17 ±100%    -100.0%       0.00        softirqs.CPU13.BLOCK
    862.50 ±111%    +416.2%       4451 ±123%    +490.8%       5095 ±108%  softirqs.CPU13.NET_RX
      2.33 ± 47%      -7.1%       2.17 ± 41%      +7.1%       2.50 ± 20%  softirqs.CPU13.NET_TX
     33493 ±  7%      -6.0%      31475 ± 17%      -9.7%      30247 ±  9%  softirqs.CPU13.RCU
     25892 ±  3%      +1.2%      26195 ± 29%      +4.0%      26920 ±  2%  softirqs.CPU13.SCHED
      0.00       +8.7e+102%       8.67 ±223%    -100.0%       0.00        softirqs.CPU13.TASKLET
     62.83 ± 33%   +1753.1%       1164 ±212%     -24.4%      47.50 ± 15%  softirqs.CPU13.TIMER
      3.00 ±195%    +238.9%      10.17 ±214%     -16.7%       2.50 ±223%  softirqs.CPU130.BLOCK
     28378            -9.7%      25631 ± 10%      -6.8%      26449 ± 10%  softirqs.CPU130.RCU
     20311 ± 33%     +29.8%      26358 ±  2%     +32.0%      26805        softirqs.CPU130.SCHED
     27.83 ± 43%      +5.4%      29.33 ± 23%   +3467.1%     992.83 ±198%  softirqs.CPU130.TIMER
      0.67 ±165%    -100.0%       0.00          +250.0%       2.33 ±172%  softirqs.CPU131.BLOCK
     28315            -9.2%      25708 ±  7%      -4.3%      27094 ± 10%  softirqs.CPU131.RCU
     22518 ± 28%     +18.8%      26754           +13.8%      25620 ±  6%  softirqs.CPU131.SCHED
     20.67 ± 10%     +90.3%      39.33 ± 41%    +635.5%     152.00 ±135%  softirqs.CPU131.TIMER
      8.50 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU132.BLOCK
     28669           -12.8%      25011 ±  9%      -6.3%      26859 ± 10%  softirqs.CPU132.RCU
     26526 ±  2%      +0.7%      26718            +0.8%      26740        softirqs.CPU132.SCHED
     30.00 ± 54%   +3674.4%       1132 ±218%     -23.9%      22.83 ± 20%  softirqs.CPU132.TIMER
      5.17 ±223%    -100.0%       0.00           -45.2%       2.83 ±208%  softirqs.CPU133.BLOCK
     28608 ±  2%      -9.7%      25840 ±  7%      -6.4%      26781 ± 10%  softirqs.CPU133.RCU
     24843 ± 18%      +7.3%      26648 ±  4%      +7.2%      26640        softirqs.CPU133.SCHED
     17.33 ± 19%   +2673.1%     480.67 ±214%     +26.0%      21.83 ± 21%  softirqs.CPU133.TIMER
      7.00 ±182%     -71.4%       2.00 ±223%    -100.0%       0.00        softirqs.CPU134.BLOCK
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU134.NET_TX
     29319           -10.6%      26212 ± 10%      -4.8%      27915 ± 12%  softirqs.CPU134.RCU
     26695            +0.2%      26751 ±  2%      +0.3%      26777 ±  6%  softirqs.CPU134.SCHED
      0.00       +1.7e+102%       1.67 ±223%    -100.0%       0.00        softirqs.CPU134.TASKLET
     23.33 ± 20%   +5310.0%       1262 ±219%   +4470.0%       1066 ±218%  softirqs.CPU134.TIMER
      5.67 ±186%     -76.5%       1.33 ±223%    -100.0%       0.00        softirqs.CPU135.BLOCK
     29430           -11.1%      26164 ±  9%      -7.5%      27211 ±  9%  softirqs.CPU135.RCU
     24054 ± 23%      +2.9%      24745 ± 15%      +9.7%      26397        softirqs.CPU135.SCHED
     26.33 ± 35%     -18.4%      21.50 ± 20%    +462.0%     148.00 ±190%  softirqs.CPU135.TIMER
      0.00       +1.3e+102%       1.33 ±223%    -100.0%       0.00        softirqs.CPU136.BLOCK
     28614 ±  2%      -8.2%      26262 ±  9%      -6.7%      26702 ± 10%  softirqs.CPU136.RCU
     26676            -0.1%      26656            -1.5%      26281        softirqs.CPU136.SCHED
      1.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU136.TASKLET
    369.50 ±209%     -92.7%      27.00 ± 43%     -62.8%     137.33 ±191%  softirqs.CPU136.TIMER
     28647 ±  2%      -4.6%      27334 ± 12%      -4.0%      27498 ±  8%  softirqs.CPU137.RCU
     26581            +0.4%      26695            -4.4%      25423 ±  6%  softirqs.CPU137.SCHED
      2.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU137.TASKLET
    156.67 ±188%     -83.4%      26.00 ± 27%    +132.4%     364.17 ±207%  softirqs.CPU137.TIMER
      0.00       +3.2e+103%      32.33 ±158%    -100.0%       0.00        softirqs.CPU138.BLOCK
     28618            -8.5%      26183 ±  6%      -6.2%      26839 ± 10%  softirqs.CPU138.RCU
     26608           -16.7%      22170 ± 26%      +1.5%      27015 ±  3%  softirqs.CPU138.SCHED
      4.83 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU138.TASKLET
     24.83 ± 40%    +366.4%     115.83 ±114%    +651.7%     186.67 ±142%  softirqs.CPU138.TIMER
      0.17 ±223%    +100.0%       0.33 ±223%    +300.0%       0.67 ±223%  softirqs.CPU139.BLOCK
     28519 ±  2%      -8.4%      26116 ±  7%      -6.4%      26701 ± 10%  softirqs.CPU139.RCU
     23908 ± 24%     +11.5%      26660           +10.9%      26504        softirqs.CPU139.SCHED
     34.00 ± 64%      -1.5%      33.50 ± 26%      -8.8%      31.00 ± 33%  softirqs.CPU139.TIMER
      0.00         +1e+102%       1.00 ±182% +9.7e+102%       9.67 ±141%  softirqs.CPU14.BLOCK
    710.83 ± 32%    +378.9%       3404 ± 73%    +680.4%       5547 ± 87%  softirqs.CPU14.NET_RX
      2.17 ± 31%     -23.1%       1.67 ± 28%      -7.7%       2.00 ± 28%  softirqs.CPU14.NET_TX
     31345 ±  4%     -10.3%      28130 ± 10%      -5.2%      29707 ± 11%  softirqs.CPU14.RCU
     26087 ±  4%      +4.6%      27290 ±  5%      +2.6%      26771 ±  3%  softirqs.CPU14.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU14.TASKLET
    123.00 ± 40%    +408.3%     625.17 ±192%   +1010.0%       1365 ±192%  softirqs.CPU14.TIMER
      0.00       +4.3e+102%       4.33 ±223%    -100.0%       0.00        softirqs.CPU140.BLOCK
     28289            -8.9%      25765 ±  7%      -5.8%      26651 ±  9%  softirqs.CPU140.RCU
     22786 ± 24%      +4.9%      23909 ± 24%      -1.3%      22497 ± 28%  softirqs.CPU140.SCHED
      0.00          -100.0%       0.00       +4.2e+102%       4.17 ±223%  softirqs.CPU140.TASKLET
     27.83 ± 64%      +6.6%      29.67 ± 70%      +2.4%      28.50 ± 61%  softirqs.CPU140.TIMER
      0.00         +5e+101%       0.50 ±223%    -100.0%       0.00        softirqs.CPU141.BLOCK
     28345 ±  2%      -9.9%      25533 ±  8%      -5.6%      26748 ± 10%  softirqs.CPU141.RCU
     26712           -18.0%      21910 ± 30%      -0.2%      26654        softirqs.CPU141.SCHED
      0.00       +8.3e+101%       0.83 ±223%    -100.0%       0.00        softirqs.CPU141.TASKLET
     31.50 ± 44%     -23.3%      24.17 ± 33%      -7.9%      29.00 ± 22%  softirqs.CPU141.TIMER
      0.00          -100.0%       0.00         +1e+102%       1.00 ±141%  softirqs.CPU142.BLOCK
     28085 ±  2%      -9.1%      25530 ±  7%      -6.0%      26395 ± 10%  softirqs.CPU142.RCU
     26623            +0.5%      26759            -0.4%      26521        softirqs.CPU142.SCHED
     42.67 ±129%    +414.8%     219.67 ±198%     -32.0%      29.00 ± 48%  softirqs.CPU142.TIMER
      0.00          -100.0%       0.00       +2.5e+103%      25.00 ±196%  softirqs.CPU143.BLOCK
     27934 ±  2%      -8.8%      25468 ±  7%      -4.8%      26606 ± 10%  softirqs.CPU143.RCU
     24145 ± 24%      -0.3%      24073 ± 24%     +11.7%      26961 ±  3%  softirqs.CPU143.SCHED
     32.33 ± 75%    +520.1%     200.50 ±196%     -11.3%      28.67 ± 29%  softirqs.CPU143.TIMER
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU144.BLOCK
     27740            -8.7%      25339 ±  8%      -5.7%      26149 ± 10%  softirqs.CPU144.RCU
     26860            -7.6%      24808 ± 17%      -1.0%      26603        softirqs.CPU144.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU144.TASKLET
     42.67 ± 84%     +90.2%      81.17 ±113%     -39.5%      25.83 ± 19%  softirqs.CPU144.TIMER
      0.17 ±223%    -100.0%       0.00         +5400.0%       9.17 ±213%  softirqs.CPU145.BLOCK
     27902            -6.4%      26126 ±  7%      -5.2%      26440 ±  8%  softirqs.CPU145.RCU
     24054 ± 24%     +12.0%      26935           +12.1%      26962        softirqs.CPU145.SCHED
     27.67 ± 14%    +107.2%      57.33 ± 76%     +47.6%      40.83 ± 69%  softirqs.CPU145.TIMER
      0.67 ±223%      +0.0%       0.67 ±223%    -100.0%       0.00        softirqs.CPU146.BLOCK
     31208 ±  2%     -11.6%      27603 ±  9%      -9.5%      28232 ±  9%  softirqs.CPU146.RCU
     23929 ± 24%     +10.8%      26524            +9.7%      26255        softirqs.CPU146.SCHED
      0.00       +2.8e+102%       2.83 ±223%    -100.0%       0.00        softirqs.CPU146.TASKLET
     19.00 ±  9%   +1101.8%     228.33 ±202%     +16.7%      22.17 ± 27%  softirqs.CPU146.TIMER
     15.00 ±223%    -100.0%       0.00           -93.3%       1.00 ±223%  softirqs.CPU147.BLOCK
     30472           -11.4%      26995 ±  7%      -8.2%      27964 ± 10%  softirqs.CPU147.RCU
     24290 ± 21%      -0.9%      24062 ± 22%      +8.3%      26304        softirqs.CPU147.SCHED
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU147.TASKLET
     24.00 ± 23%     +11.1%      26.67 ± 21%     +13.9%      27.33 ± 24%  softirqs.CPU147.TIMER
     28235 ±  3%      -7.8%      26037 ±  7%      -4.8%      26891 ± 10%  softirqs.CPU148.RCU
     26355 ±  3%      -1.8%      25890 ±  7%      +0.9%      26600        softirqs.CPU148.SCHED
     19.33 ± 21%     +22.4%      23.67 ± 10%     +25.0%      24.17 ± 15%  softirqs.CPU148.TIMER
      0.00       +6.7e+102%       6.67 ±223%    -100.0%       0.00        softirqs.CPU149.BLOCK
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU149.NET_TX
     28404 ±  2%      -6.7%      26510 ± 12%      -5.5%      26838 ±  9%  softirqs.CPU149.RCU
     26577            -4.0%      25515 ± 12%      -8.0%      24458 ± 21%  softirqs.CPU149.SCHED
     20.33 ± 23%    +121.3%      45.00 ± 56%    +152.5%      51.33 ±126%  softirqs.CPU149.TIMER
      0.00       +6.7e+102%       6.67 ±223%    -100.0%       0.00        softirqs.CPU15.BLOCK
      3247 ± 78%     -28.2%       2332 ±130%     +19.6%       3884 ±121%  softirqs.CPU15.NET_RX
      2.17 ± 41%      -7.7%       2.00 ± 40%     -38.5%       1.33 ± 35%  softirqs.CPU15.NET_TX
     34207 ±  5%     -16.6%      28523 ±  8%      -8.8%      31205 ± 11%  softirqs.CPU15.RCU
     26524 ±  3%      +3.1%      27347 ±  2%      -5.6%      25045 ± 18%  softirqs.CPU15.SCHED
    311.17 ±182%    +104.4%     636.17 ±207%     -82.2%      55.50 ± 12%  softirqs.CPU15.TIMER
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU150.BLOCK
     30570 ±  2%     -11.9%      26926 ±  8%      -9.1%      27793 ± 10%  softirqs.CPU150.RCU
     25510 ±  6%      +5.3%      26859            -4.7%      24321 ± 18%  softirqs.CPU150.SCHED
     26.67 ± 52%   +1208.8%     349.00 ±209%    +108.8%      55.67 ±129%  softirqs.CPU150.TIMER
      1.00 ±223%     -50.0%       0.50 ±223%    +866.7%       9.67 ±223%  softirqs.CPU151.BLOCK
      0.00       +3.3e+101%       0.33 ±223%    -100.0%       0.00        softirqs.CPU151.NET_TX
     29982           -11.1%      26651 ±  9%      -6.6%      28000 ±  9%  softirqs.CPU151.RCU
     26588            -0.3%      26521            +0.2%      26640        softirqs.CPU151.SCHED
     28.17 ± 60%      +7.1%      30.17 ± 33%    +200.6%      84.67 ± 74%  softirqs.CPU151.TIMER
      0.00       +3.3e+101%       0.33 ±223%    -100.0%       0.00        softirqs.CPU152.BLOCK
     30636           -12.1%      26937 ± 10%      -8.4%      28051 ± 10%  softirqs.CPU152.RCU
     24088 ± 23%      -0.5%      23978 ± 23%      +8.7%      26171        softirqs.CPU152.SCHED
     18.50 ± 12%     +96.4%      36.33 ±108%     +34.2%      24.83 ± 20%  softirqs.CPU152.TIMER
      0.00       +2.1e+103%      21.00 ±223%    -100.0%       0.00        softirqs.CPU153.BLOCK
     30641           -11.0%      27272 ±  9%      -7.6%      28310 ±  9%  softirqs.CPU153.RCU
     26581            +0.1%      26603            -4.9%      25279 ±  7%  softirqs.CPU153.SCHED
     21.17 ± 24%    +307.9%      86.33 ±100%     +27.6%      27.00 ± 40%  softirqs.CPU153.TIMER
      0.00       +2.8e+102%       2.83 ±223% +1.3e+102%       1.33 ±223%  softirqs.CPU154.BLOCK
     27441            -9.4%      24855 ±  8%      -0.4%      27336 ± 11%  softirqs.CPU154.RCU
     26804            -0.4%      26695           -21.4%      21073 ± 34%  softirqs.CPU154.SCHED
     17.83 ± 16%   +1853.3%     348.33 ±211%    +125.2%      40.17 ± 43%  softirqs.CPU154.TIMER
      0.00       +4.3e+102%       4.33 ±136% +3.3e+102%       3.33 ±223%  softirqs.CPU155.BLOCK
     27704            -5.5%      26170 ±  8%      -6.1%      26025 ± 10%  softirqs.CPU155.RCU
     26752            -3.4%      25831 ±  9%      +0.5%      26881        softirqs.CPU155.SCHED
     22.67 ± 12%     +70.6%      38.67 ± 72%    +277.9%      85.67 ±111%  softirqs.CPU155.TIMER
      0.00       +7.2e+102%       7.17 ±223%    -100.0%       0.00        softirqs.CPU156.BLOCK
     28990 ±  2%      -9.7%      26167 ±  7%      -5.9%      27277 ±  9%  softirqs.CPU156.RCU
     26751            +0.6%      26919 ±  2%      -0.1%      26719        softirqs.CPU156.SCHED
      1.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU156.TASKLET
     24.50 ± 51%   +1857.1%     479.50 ±213%    +163.3%      64.50 ±121%  softirqs.CPU156.TIMER
      0.00         +4e+102%       4.00 ±223% +1.3e+102%       1.33 ±223%  softirqs.CPU157.BLOCK
     29153 ±  2%     -11.9%      25684 ±  9%      -7.1%      27093 ± 10%  softirqs.CPU157.RCU
     26527            +0.6%      26676            +0.3%      26609        softirqs.CPU157.SCHED
      2.83 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU157.TASKLET
     27.00 ± 35%    +467.3%     153.17 ±187%      +1.9%      27.50 ± 30%  softirqs.CPU157.TIMER
      0.50 ±223%    -100.0%       0.00           -33.3%       0.33 ±223%  softirqs.CPU158.BLOCK
     28301 ±  2%      -8.0%      26025 ±  7%      -5.7%      26693 ± 10%  softirqs.CPU158.RCU
     26721            -8.1%      24567 ± 18%      -1.1%      26415        softirqs.CPU158.SCHED
      0.00          -100.0%       0.00       +3.7e+102%       3.67 ±223%  softirqs.CPU158.TASKLET
    115.50 ±180%     -77.6%      25.83 ± 24%     -78.9%      24.33 ± 33%  softirqs.CPU158.TIMER
      0.00          -100.0%       0.00       +8.3e+101%       0.83 ±223%  softirqs.CPU159.BLOCK
     27743 ±  6%      -8.3%      25431 ±  8%      -4.5%      26492 ± 10%  softirqs.CPU159.RCU
     24149 ± 24%     +10.5%      26691           +10.8%      26751        softirqs.CPU159.SCHED
      1352 ±219%     -95.8%      57.33 ±127%     -97.6%      32.67 ± 37%  softirqs.CPU159.TIMER
      1.50 ±195%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU16.BLOCK
     35643 ±  4%     -13.2%      30956 ± 11%     -11.2%      31651 ± 10%  softirqs.CPU16.RCU
     23139 ± 22%     +16.8%      27024 ±  3%     +11.4%      25765 ±  4%  softirqs.CPU16.SCHED
    162.67 ± 67%    +229.7%     536.33 ±176%     -29.3%     115.00 ± 15%  softirqs.CPU16.TIMER
      2.50 ±223%     -73.3%       0.67 ±223%    -100.0%       0.00        softirqs.CPU160.BLOCK
     28608            -9.3%      25943 ±  8%      -3.6%      27565 ± 10%  softirqs.CPU160.RCU
     26660            +1.7%      27124 ±  4%      -3.7%      25662 ±  5%  softirqs.CPU160.SCHED
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU160.TASKLET
     20.67 ± 11%    +104.0%      42.17 ± 83%    +155.6%      52.83 ± 96%  softirqs.CPU160.TIMER
      9.83 ±223%    -100.0%       0.00           -96.6%       0.33 ±223%  softirqs.CPU161.BLOCK
     28560 ±  2%      -8.9%      26014 ±  7%      -6.3%      26756 ± 10%  softirqs.CPU161.RCU
     26822            -9.4%      24306 ± 22%      -1.1%      26526        softirqs.CPU161.SCHED
     29.33 ± 41%     +79.5%      52.67 ±101%     -10.8%      26.17 ± 17%  softirqs.CPU161.TIMER
      0.00       +3.3e+101%       0.33 ±223%    -100.0%       0.00        softirqs.CPU162.BLOCK
     28832            -7.9%      26559 ±  3%      -7.5%      26678 ± 10%  softirqs.CPU162.RCU
     23758 ± 25%      -3.1%      23025 ± 25%      -8.8%      21659 ± 31%  softirqs.CPU162.SCHED
     41.83 ±117%     +21.1%      50.67 ± 79%     -45.0%      23.00 ± 19%  softirqs.CPU162.TIMER
      0.00          -100.0%       0.00       +2.2e+103%      22.00 ±223%  softirqs.CPU163.BLOCK
     28745 ±  2%      -9.2%      26101 ±  6%      -7.0%      26730 ± 10%  softirqs.CPU163.RCU
     26466 ±  2%      -5.1%      25104 ± 14%      -0.1%      26447        softirqs.CPU163.SCHED
      0.00       +1.8e+102%       1.83 ±223%    -100.0%       0.00        softirqs.CPU163.TASKLET
     27.83 ± 28%    +224.6%      90.33 ± 98%      -1.2%      27.50 ± 23%  softirqs.CPU163.TIMER
      5.83 ±223%     -85.7%       0.83 ±223%     -91.4%       0.50 ±152%  softirqs.CPU164.BLOCK
     28429 ±  3%      -9.9%      25625 ±  7%      -7.3%      26362 ± 10%  softirqs.CPU164.RCU
     26900 ±  2%     -10.2%      24155 ± 23%      -1.3%      26549        softirqs.CPU164.SCHED
    404.00 ±199%     -93.9%      24.83 ± 20%     -75.9%      97.33 ±152%  softirqs.CPU164.TIMER
      0.00       +3.8e+102%       3.83 ±223%    -100.0%       0.00        softirqs.CPU165.BLOCK
     28226 ±  3%     -10.6%      25234 ±  8%      -6.4%      26429 ±  9%  softirqs.CPU165.RCU
     27029            -1.5%      26622            -1.0%      26747        softirqs.CPU165.SCHED
    364.00 ±164%     -92.6%      26.83 ± 32%     -90.3%      35.17 ± 61%  softirqs.CPU165.TIMER
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU166.BLOCK
     28637 ±  4%      -8.0%      26337 ± 11%      -6.9%      26650 ± 10%  softirqs.CPU166.RCU
     25817 ±  6%      -4.4%      24685 ± 12%      -6.5%      24144 ± 23%  softirqs.CPU166.SCHED
     74.00 ±143%     -59.0%      30.33 ± 40%     -46.6%      39.50 ± 66%  softirqs.CPU166.TIMER
      0.17 ±223%    +700.0%       1.33 ±223%    -100.0%       0.00        softirqs.CPU167.BLOCK
     27467 ±  5%      -7.5%      25394 ±  7%      -3.3%      26560 ±  9%  softirqs.CPU167.RCU
     23984 ± 25%     +11.2%      26682           +11.6%      26765        softirqs.CPU167.SCHED
      1301 ±217%     -97.8%      28.33 ± 32%     -97.8%      28.17 ± 16%  softirqs.CPU167.TIMER
      0.33 ±223%    -100.0%       0.00            +0.0%       0.33 ±223%  softirqs.CPU168.BLOCK
     30267 ±  3%     -13.1%      26307 ±  8%      -7.0%      28156 ± 11%  softirqs.CPU168.RCU
     26161 ±  4%      +0.6%      26321            -1.5%      25764 ±  4%  softirqs.CPU168.SCHED
      0.00          -100.0%       0.00       +8.2e+102%       8.17 ±223%  softirqs.CPU168.TASKLET
     21.33 ± 32%   +5963.3%       1293 ±177%     +18.8%      25.33 ± 19%  softirqs.CPU168.TIMER
      4.33 ±223%     -57.7%       1.83 ±179%    -100.0%       0.00        softirqs.CPU169.BLOCK
     29677           -10.8%      26461 ±  8%      -5.9%      27916 ± 11%  softirqs.CPU169.RCU
     26439            +2.1%      26993 ±  3%      -2.1%      25896 ±  2%  softirqs.CPU169.SCHED
     19.33 ± 26%   +1955.2%     397.33 ±176%     +46.6%      28.33 ± 27%  softirqs.CPU169.TIMER
      4.83 ±137%     -93.1%       0.33 ±223%     -69.0%       1.50 ±195%  softirqs.CPU17.BLOCK
      7.00 ± 14%     -11.9%       6.17 ± 21%      -9.5%       6.33 ± 19%  softirqs.CPU17.NET_RX
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU17.NET_TX
     35148 ±  3%     -10.1%      31613 ± 13%      -9.9%      31675 ± 10%  softirqs.CPU17.RCU
     26015 ±  2%      -0.7%      25833 ±  5%      -7.8%      23983 ± 17%  softirqs.CPU17.SCHED
     55.67 ± 22%    +310.5%     228.50 ±166%     +62.9%      90.67 ± 70%  softirqs.CPU17.TIMER
      0.00          -100.0%       0.00       +8.8e+102%       8.83 ±186%  softirqs.CPU170.BLOCK
     28608 ±  4%     -10.5%      25613 ±  7%      -6.4%      26765 ± 11%  softirqs.CPU170.RCU
     22513 ± 21%      +6.6%      23996 ± 24%      +6.8%      24049 ± 18%  softirqs.CPU170.SCHED
      0.00          -100.0%       0.00       +1.5e+102%       1.50 ±223%  softirqs.CPU170.TASKLET
     24.00 ± 30%     +22.9%      29.50 ± 43%      +0.7%      24.17 ± 21%  softirqs.CPU170.TIMER
      0.00          -100.0%       0.00       +1.5e+102%       1.50 ±223%  softirqs.CPU171.BLOCK
     27805            -7.3%      25780 ±  7%      -5.8%      26184 ± 10%  softirqs.CPU171.RCU
     25228 ± 16%      -0.3%      25145 ± 13%     -10.0%      22702 ± 26%  softirqs.CPU171.SCHED
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU171.TASKLET
     34.17 ± 56%     -28.8%      24.33 ± 17%     -31.2%      23.50 ±  6%  softirqs.CPU171.TIMER
      1.67 ±175%    -100.0%       0.00           -20.0%       1.33 ±223%  softirqs.CPU172.BLOCK
     29215            -8.3%      26776 ±  8%      -6.2%      27408 ±  9%  softirqs.CPU172.RCU
     26554            -0.3%      26462            -0.2%      26510        softirqs.CPU172.SCHED
     55.33 ±125%     -28.6%      39.50 ± 82%     -53.0%      26.00 ± 22%  softirqs.CPU172.TIMER
      0.00       +1.3e+102%       1.33 ±223% +3.3e+101%       0.33 ±223%  softirqs.CPU173.BLOCK
     29038            -8.7%      26498 ±  8%      -5.4%      27456 ± 10%  softirqs.CPU173.RCU
     24825 ± 15%      +7.1%      26600            +6.0%      26311        softirqs.CPU173.SCHED
     19.17 ± 10%     +41.7%      27.17 ± 22%     +55.7%      29.83 ± 23%  softirqs.CPU173.TIMER
      0.00       +5.8e+102%       5.83 ±181%    -100.0%       0.00        softirqs.CPU174.BLOCK
     28268            -7.4%      26162 ±  7%      -3.9%      27173 ± 15%  softirqs.CPU174.RCU
     24159 ± 23%     +10.7%      26735            +2.0%      24632 ± 24%  softirqs.CPU174.SCHED
     29.83 ± 44%     -16.8%      24.83 ± 41%   +4677.1%       1425 ±135%  softirqs.CPU174.TIMER
     28615 ±  5%     -10.0%      25758 ±  7%      -6.6%      26730 ± 10%  softirqs.CPU175.RCU
     26110 ±  5%      +2.6%      26782            -4.1%      25034 ± 25%  softirqs.CPU175.SCHED
     26.17 ± 38%      +0.6%      26.33 ± 18%  +14575.2%       3840 ±211%  softirqs.CPU175.TIMER
      7.17 ±223%     -72.1%       2.00 ±223%    -100.0%       0.00        softirqs.CPU176.BLOCK
     28514 ±  3%      -5.3%      27011 ± 12%      -4.2%      27304 ± 14%  softirqs.CPU176.RCU
     26142 ±  4%      -2.9%      25386 ± 10%      -3.9%      25131 ± 12%  softirqs.CPU176.SCHED
     24.67 ± 28%     +63.5%      40.33 ± 59%   +1522.3%     400.17 ±205%  softirqs.CPU176.TIMER
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU177.BLOCK
     28374            -8.1%      26069 ±  6%      -4.5%      27091 ± 11%  softirqs.CPU177.RCU
     26391            +1.5%      26800            -1.0%      26117 ±  4%  softirqs.CPU177.SCHED
     20.83 ± 15%     +36.0%      28.33 ± 16%    +115.2%      44.83 ±111%  softirqs.CPU177.TIMER
      0.33 ±223%    -100.0%       0.00          +250.0%       1.17 ±159%  softirqs.CPU178.BLOCK
     28301 ±  2%      -8.3%      25941 ±  7%      -6.5%      26457 ± 10%  softirqs.CPU178.RCU
     26570            +0.5%      26693            -2.9%      25809 ±  4%  softirqs.CPU178.SCHED
     39.83 ± 66%     -48.1%      20.67 ± 14%     -34.3%      26.17 ± 30%  softirqs.CPU178.TIMER
      0.00       +1.3e+102%       1.33 ±223%    -100.0%       0.00        softirqs.CPU179.BLOCK
     29396 ±  8%     -11.4%      26043 ±  7%      -9.0%      26742 ± 10%  softirqs.CPU179.RCU
     25617 ±  9%      +4.0%      26653            +3.9%      26604        softirqs.CPU179.SCHED
     29.00 ± 58%     -15.5%      24.50 ± 21%      +8.6%      31.50 ± 37%  softirqs.CPU179.TIMER
      4.00 ±192%    +158.3%      10.33 ±223%     +83.3%       7.33 ±217%  softirqs.CPU18.BLOCK
      7.00 ± 14%     -11.9%       6.17 ± 21%      -9.5%       6.33 ± 19%  softirqs.CPU18.NET_RX
     33335 ±  6%     -11.7%      29437 ± 14%     -10.7%      29771 ± 11%  softirqs.CPU18.RCU
     25579 ±  3%      +6.8%      27323 ±  3%      +3.0%      26337        softirqs.CPU18.SCHED
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU18.TASKLET
    112.17 ± 51%    +358.4%     514.17 ±184%     -17.2%      92.83 ± 45%  softirqs.CPU18.TIMER
      0.00       +3.3e+101%       0.33 ±223%   +1e+102%       1.00 ±223%  softirqs.CPU180.BLOCK
     28366 ±  2%      -7.3%      26295 ±  8%      -7.0%      26385 ±  9%  softirqs.CPU180.RCU
     22329 ± 29%     +12.3%      25083 ± 15%      +7.1%      23914 ± 28%  softirqs.CPU180.SCHED
     19.83 ± 10%    +321.8%      83.67 ± 68%   +4342.9%     881.17 ±204%  softirqs.CPU180.TIMER
      0.00       +1.7e+101%       0.17 ±223% +3.3e+101%       0.33 ±223%  softirqs.CPU181.BLOCK
     28416            -7.6%      26261 ±  8%      -6.0%      26713 ± 10%  softirqs.CPU181.RCU
     26555 ±  2%      -3.9%      25515 ±  9%      +0.3%      26625        softirqs.CPU181.SCHED
     23.67 ± 13%     +77.5%      42.00 ± 49%   +1572.5%     395.83 ±134%  softirqs.CPU181.TIMER
      0.33 ±223%    +500.0%       2.00 ±223%    +200.0%       1.00 ±223%  softirqs.CPU182.BLOCK
     28200            -8.4%      25833 ±  7%      -5.6%      26632 ± 10%  softirqs.CPU182.RCU
     24373 ± 23%      -1.4%      24037 ± 24%      +9.5%      26692        softirqs.CPU182.SCHED
     22.83 ± 16%     +83.2%      41.83 ±108%     +44.5%      33.00 ± 60%  softirqs.CPU182.TIMER
      0.00          -100.0%       0.00       +6.3e+102%       6.33 ±223%  softirqs.CPU183.BLOCK
     28278            -8.0%      26004 ±  8%      -5.6%      26708 ± 10%  softirqs.CPU183.RCU
     24345 ± 23%      +7.9%      26265 ±  3%      +9.3%      26607        softirqs.CPU183.SCHED
     26.83 ± 58%      +1.2%      27.17 ± 16%     +91.3%      51.33 ±102%  softirqs.CPU183.TIMER
      0.00          -100.0%       0.00       +3.3e+101%       0.33 ±223%  softirqs.CPU184.BLOCK
     28269 ±  2%      -5.7%      26652 ± 12%      -5.6%      26687 ± 10%  softirqs.CPU184.RCU
     24038 ± 24%      +6.8%      25681 ±  6%      -0.5%      23908 ± 23%  softirqs.CPU184.SCHED
    225.83 ±187%     -64.9%      79.17 ±110%     -87.9%      27.33 ± 25%  softirqs.CPU184.TIMER
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU185.BLOCK
     27856 ±  3%      -6.0%      26198 ±  8%      -3.8%      26797 ± 10%  softirqs.CPU185.RCU
     26577            -7.3%      24641 ± 21%      +0.0%      26590        softirqs.CPU185.SCHED
    923.67 ±218%     -54.4%     420.83 ±132%     -97.1%      27.17 ± 19%  softirqs.CPU185.TIMER
      0.00       +6.7e+101%       0.67 ±141%    -100.0%       0.00        softirqs.CPU186.BLOCK
     28420 ±  2%      -8.3%      26067 ±  7%      -6.5%      26583 ±  9%  softirqs.CPU186.RCU
     24239 ± 24%      +9.5%      26537            +1.9%      24691 ± 17%  softirqs.CPU186.SCHED
     53.17 ±133%     -37.9%      33.00 ± 59%     +41.1%      75.00 ±164%  softirqs.CPU186.TIMER
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU187.BLOCK
     28336            -8.2%      26006 ±  7%      -5.3%      26822 ± 10%  softirqs.CPU187.RCU
     24833 ± 17%      +7.3%      26655            +6.2%      26383 ±  2%  softirqs.CPU187.SCHED
     37.83 ± 96%     -14.5%      32.33 ± 65%     -15.0%      32.17 ± 52%  softirqs.CPU187.TIMER
      8.83 ±175%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU188.BLOCK
     28368 ±  2%      -8.5%      25952 ±  7%      -6.3%      26593 ± 10%  softirqs.CPU188.RCU
     26817            -0.4%      26714            +2.1%      27383 ±  3%  softirqs.CPU188.SCHED
     34.00 ± 92%     -28.9%      24.17 ± 26%    +895.6%     338.50 ±208%  softirqs.CPU188.TIMER
      6.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU189.BLOCK
     28228 ±  2%      -8.3%      25871 ±  8%      -5.7%      26621 ± 10%  softirqs.CPU189.RCU
     26724            -0.0%      26721            -7.2%      24812 ± 16%  softirqs.CPU189.SCHED
     19.33 ± 33%    +312.1%      79.67 ±152%    +799.1%     173.83 ±191%  softirqs.CPU189.TIMER
      0.33 ±223%   +6700.0%      22.67 ±223%    +200.0%       1.00 ±223%  softirqs.CPU19.BLOCK
      7.00 ± 14%     -11.9%       6.17 ± 21%      -9.5%       6.33 ± 19%  softirqs.CPU19.NET_RX
     31168 ±  3%     -11.7%      27523 ±  8%      -6.9%      29022 ± 11%  softirqs.CPU19.RCU
     26602            +2.4%      27236 ± 11%      -9.8%      24002 ± 18%  softirqs.CPU19.SCHED
      0.00       +6.8e+102%       6.83 ±223%    -100.0%       0.00        softirqs.CPU19.TASKLET
     83.83 ±100%     +11.1%      93.17 ± 55%     -32.4%      56.67 ± 51%  softirqs.CPU19.TIMER
      5.83 ±145%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU190.BLOCK
     28077 ±  2%      -7.5%      25959 ±  7%      -5.8%      26435 ± 10%  softirqs.CPU190.RCU
     21805 ± 32%     +22.9%      26792           +21.8%      26549        softirqs.CPU190.SCHED
     21.00 ± 21%      +6.3%      22.33 ± 14%     +93.7%      40.67 ±109%  softirqs.CPU190.TIMER
      0.00       +4.7e+102%       4.67 ±223% +2.2e+102%       2.17 ±223%  softirqs.CPU191.BLOCK
     28414 ±  2%      -8.2%      26083 ±  8%      -5.4%      26870 ± 10%  softirqs.CPU191.RCU
     12812 ± 17%     -13.7%      11061 ±  5%      +5.3%      13489 ± 17%  softirqs.CPU191.SCHED
     21.50 ± 20%     +21.7%      26.17 ± 28%    +305.4%      87.17 ±142%  softirqs.CPU191.TIMER
      7.00 ±223%     -47.6%       3.67 ±223%     -31.0%       4.83 ±223%  softirqs.CPU192.BLOCK
     26774 ±  9%      -4.0%      25703 ±  8%      +0.1%      26808 ± 11%  softirqs.CPU192.RCU
     24520 ± 19%      -3.9%      23568 ± 19%      -6.1%      23014 ± 25%  softirqs.CPU192.SCHED
      2.67 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU192.TASKLET
      2331 ±220%     -97.5%      59.17 ± 96%     -99.1%      20.67 ± 53%  softirqs.CPU192.TIMER
     27833 ±  2%      -8.6%      25426 ±  5%      -4.5%      26583 ± 11%  softirqs.CPU193.RCU
     24306 ± 18%      -2.7%      23656 ± 24%      -3.7%      23402 ± 24%  softirqs.CPU193.SCHED
      0.17 ±223%    +500.0%       1.00 ±223%      +0.0%       0.17 ±223%  softirqs.CPU193.TASKLET
     41.33 ± 49%     +16.5%      48.17 ± 62%    +250.4%     144.83 ±180%  softirqs.CPU193.TIMER
      2.83 ±223%     +52.9%       4.33 ±142%     +58.8%       4.50 ±223%  softirqs.CPU194.BLOCK
     29178           -11.0%      25977 ± 10%      -7.9%      26874 ± 10%  softirqs.CPU194.RCU
     26513            -0.9%      26277            -1.2%      26190        softirqs.CPU194.SCHED
     51.33 ±105%     -12.7%      44.83 ± 86%     -45.5%      28.00 ± 56%  softirqs.CPU194.TIMER
     11.83 ±223%    -100.0%       0.00           -64.8%       4.17 ±109%  softirqs.CPU195.BLOCK
     29756           -10.4%      26671 ±  8%      -7.6%      27479 ±  9%  softirqs.CPU195.RCU
     26491            -6.6%      24731 ± 15%      -1.0%      26235        softirqs.CPU195.SCHED
    109.83 ± 22%      +7.4%     118.00 ± 12%      +2.1%     112.17 ± 34%  softirqs.CPU195.TIMER
      2.50 ±223%     -40.0%       1.50 ±171%    -100.0%       0.00        softirqs.CPU196.BLOCK
     28956 ±  3%     -10.4%      25945 ±  7%      -7.9%      26678 ±  9%  softirqs.CPU196.RCU
     26758            -0.3%      26687           -10.1%      24060 ± 24%  softirqs.CPU196.SCHED
     23.50 ± 45%      +9.2%      25.67 ± 58%     -22.0%      18.33 ±  7%  softirqs.CPU196.TIMER
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU197.BLOCK
     28516 ±  2%      -8.8%      26002 ±  8%      -4.6%      27216 ±  9%  softirqs.CPU197.RCU
     26418            +1.3%      26765            +1.2%      26739        softirqs.CPU197.SCHED
     98.00 ±  6%     -17.3%      81.00 ± 37%      +8.0%     105.83 ±  3%  softirqs.CPU197.TIMER
      1.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU198.BLOCK
     28824 ±  2%      -8.9%      26253 ±  7%      -5.7%      27174 ± 11%  softirqs.CPU198.RCU
     26882           -10.7%      23995 ± 23%     -14.3%      23033 ± 23%  softirqs.CPU198.SCHED
     41.67 ± 83%     +90.8%      79.50 ±108%     +87.6%      78.17 ±155%  softirqs.CPU198.TIMER
      2.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU199.BLOCK
     28826 ±  3%      -8.4%      26405 ±  7%      -4.3%      27585 ± 10%  softirqs.CPU199.RCU
     26494            +0.7%      26672            +1.1%      26784        softirqs.CPU199.SCHED
     92.00 ± 27%     +27.0%     116.83 ± 41%     +27.2%     117.00 ± 21%  softirqs.CPU199.TIMER
      2.83 ±193%    -100.0%       0.00          +647.1%      21.17 ±140%  softirqs.CPU2.BLOCK
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU2.NET_TX
     39675 ±  7%     -14.0%      34119 ±  8%     -14.4%      33957 ±  9%  softirqs.CPU2.RCU
     21463 ± 29%     +25.1%      26844 ±  6%     +22.4%      26270 ±  5%  softirqs.CPU2.SCHED
      0.00       +1.7e+101%       0.17 ±223% +8.3e+101%       0.83 ±175%  softirqs.CPU2.TASKLET
    502.17 ±177%    +195.8%       1485 ±132%     +10.7%     555.67 ±185%  softirqs.CPU2.TIMER
      4.33 ±223%     -57.7%       1.83 ±223%     -92.3%       0.33 ±223%  softirqs.CPU20.BLOCK
      7.00 ± 14%     -11.9%       6.17 ± 21%      -9.5%       6.33 ± 19%  softirqs.CPU20.NET_RX
     34517 ±  4%     -14.9%      29363 ± 13%      -8.5%      31586 ± 10%  softirqs.CPU20.RCU
     24308 ± 16%      +7.6%      26147 ±  3%      +3.1%      25067 ±  3%  softirqs.CPU20.SCHED
     84.50 ± 16%     +32.9%     112.33 ± 62%      -0.4%      84.17 ± 12%  softirqs.CPU20.TIMER
      0.00       +3.3e+101%       0.33 ±223%    -100.0%       0.00        softirqs.CPU200.BLOCK
     28777            -9.6%      26002 ±  6%      -6.2%      26985 ±  9%  softirqs.CPU200.RCU
     26783            -6.6%      25014 ± 13%      -2.8%      26029 ±  4%  softirqs.CPU200.SCHED
      5.50 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU200.TASKLET
    231.33 ±205%     -83.9%      37.33 ± 86%    +266.1%     847.00 ±189%  softirqs.CPU200.TIMER
      0.00       +3.3e+101%       0.33 ±223%    -100.0%       0.00        softirqs.CPU201.BLOCK
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU201.NET_TX
     29402 ±  6%     -11.0%      26156 ±  7%      -7.5%      27208 ±  9%  softirqs.CPU201.RCU
     26507            +1.0%      26778            -0.8%      26306 ±  2%  softirqs.CPU201.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU201.TASKLET
    110.33 ± 43%      -2.9%     107.17 ±  7%     -19.9%      88.33 ± 30%  softirqs.CPU201.TIMER
      1.33 ±223%     -75.0%       0.33 ±223%     -87.5%       0.17 ±223%  softirqs.CPU202.BLOCK
     28530 ±  2%      -7.3%      26451 ±  6%      -6.2%      26751 ± 10%  softirqs.CPU202.RCU
     26691            +0.4%      26793            -0.4%      26593        softirqs.CPU202.SCHED
      0.83 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU202.TASKLET
     25.50 ± 36%    +637.9%     188.17 ±101%     +87.6%      47.83 ±117%  softirqs.CPU202.TIMER
      0.00       +1.2e+102%       1.17 ±223%    -100.0%       0.00        softirqs.CPU203.BLOCK
     28761 ±  2%      -8.2%      26414 ±  6%      -6.2%      26982 ± 10%  softirqs.CPU203.RCU
     23861 ± 24%     +12.2%      26780            +0.1%      23886 ± 24%  softirqs.CPU203.SCHED
      0.83 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU203.TASKLET
    100.83 ± 12%      -6.4%      94.33 ± 18%      -6.4%      94.33 ± 21%  softirqs.CPU203.TIMER
      0.00       +4.5e+102%       4.50 ±204%    -100.0%       0.00        softirqs.CPU204.BLOCK
     28691            -8.6%      26237 ±  5%      -5.9%      27007 ± 10%  softirqs.CPU204.RCU
     22172 ± 29%     +10.0%      24382 ± 21%      +7.5%      23827 ± 24%  softirqs.CPU204.SCHED
     46.50 ±128%    +158.8%     120.33 ±180%    +135.1%     109.33 ±129%  softirqs.CPU204.TIMER
      0.33 ±223%   +2200.0%       7.67 ±212%    -100.0%       0.00        softirqs.CPU205.BLOCK
     28557            -7.7%      26370 ±  7%      -3.0%      27699 ± 12%  softirqs.CPU205.RCU
     26578            +0.3%      26655            -0.2%      26525        softirqs.CPU205.SCHED
    600.83 ±188%     -78.3%     130.33 ± 38%     -83.2%     101.00 ± 22%  softirqs.CPU205.TIMER
      0.00       +8.3e+101%       0.83 ±223% +1.7e+102%       1.67 ±223%  softirqs.CPU206.BLOCK
     28913 ±  2%     -10.9%      25761 ±  8%      -7.8%      26665 ± 10%  softirqs.CPU206.RCU
     24561 ± 24%      +8.9%      26748            -3.2%      23768 ± 24%  softirqs.CPU206.SCHED
      0.67 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU206.TASKLET
    500.17 ±204%     -94.3%      28.33 ± 46%     -95.8%      21.00 ± 19%  softirqs.CPU206.TIMER
     21.17 ±217%     -87.4%       2.67 ±223%     -71.7%       6.00 ±223%  softirqs.CPU207.BLOCK
     28626 ±  2%      -7.8%      26386 ±  7%      -5.0%      27203 ± 10%  softirqs.CPU207.RCU
     26408            +1.8%      26872            -9.1%      24018 ± 23%  softirqs.CPU207.SCHED
      1.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU207.TASKLET
    128.00 ± 64%    +191.5%     373.17 ±158%      -8.1%     117.67 ± 25%  softirqs.CPU207.TIMER
      1.00 ±223%    -100.0%       0.00          +350.0%       4.50 ±223%  softirqs.CPU208.BLOCK
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU208.NET_TX
     29941           -10.5%      26794 ±  8%      -7.3%      27765 ± 10%  softirqs.CPU208.RCU
     25194 ± 16%     -12.6%      22030 ± 29%      +4.6%      26360        softirqs.CPU208.SCHED
      1200 ±212%     -96.4%      43.00 ± 91%     -97.0%      36.50 ± 56%  softirqs.CPU208.TIMER
      1.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU209.BLOCK
     29999            -7.6%      27732 ±  7%      -6.9%      27932 ± 10%  softirqs.CPU209.RCU
     22122 ± 27%     +19.6%      26458           +19.1%      26339        softirqs.CPU209.SCHED
     94.50 ± 14%     +41.3%     133.50 ± 25%     +17.8%     111.33 ± 21%  softirqs.CPU209.TIMER
      0.00       +3.8e+102%       3.83 ±223% +1.7e+101%       0.17 ±223%  softirqs.CPU21.BLOCK
     36226 ±  5%     -18.2%      29619 ± 13%     -10.4%      32446 ± 11%  softirqs.CPU21.RCU
     25280 ± 11%      +2.7%      25952 ±  6%      -1.2%      24975 ± 15%  softirqs.CPU21.SCHED
     51.33 ± 26%      -0.6%      51.00 ± 31%      +8.4%      55.67 ± 15%  softirqs.CPU21.TIMER
     28551 ±  2%      -9.1%      25956 ±  6%      -6.6%      26654 ±  9%  softirqs.CPU210.RCU
     26585            -0.1%      26547            -0.6%      26433        softirqs.CPU210.SCHED
     43.67 ± 70%     -46.6%      23.33 ± 24%     +24.0%      54.17 ± 90%  softirqs.CPU210.TIMER
      0.00       +2.2e+103%      22.33 ±221%    -100.0%       0.00        softirqs.CPU211.BLOCK
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU211.NET_TX
     28613            -8.7%      26126 ±  7%      -5.3%      27106 ± 10%  softirqs.CPU211.RCU
     24135 ± 21%      +0.9%      24345 ± 23%     +11.5%      26900        softirqs.CPU211.SCHED
      0.00       +3.3e+101%       0.33 ±223%    -100.0%       0.00        softirqs.CPU211.TASKLET
    104.67 ± 21%      +3.3%     108.17 ±  9%     +38.9%     145.33 ± 40%  softirqs.CPU211.TIMER
      0.00       +2.7e+102%       2.67 ±223% +8.3e+101%       0.83 ±223%  softirqs.CPU212.BLOCK
     28275 ±  3%      -9.4%      25613 ±  6%      -5.3%      26768 ± 10%  softirqs.CPU212.RCU
     24521 ± 20%      +6.7%      26152 ±  9%      -1.8%      24087 ± 24%  softirqs.CPU212.SCHED
     31.17 ± 53%   +1780.2%     586.00 ±199%    +107.5%      64.67 ± 92%  softirqs.CPU212.TIMER
      0.00       +1.1e+103%      10.83 ±223%    -100.0%       0.00        softirqs.CPU213.BLOCK
     29496 ±  2%      -9.8%      26600 ±  8%      -6.1%      27708 ±  8%  softirqs.CPU213.RCU
     26357            -3.8%      25351 ± 11%      +1.0%      26610        softirqs.CPU213.SCHED
    113.33 ± 38%     +49.9%     169.83 ± 76%      +3.2%     117.00 ± 11%  softirqs.CPU213.TIMER
     29736 ±  7%     -13.2%      25812 ±  7%      -6.6%      27783 ± 10%  softirqs.CPU214.RCU
     24976 ± 12%      +7.2%      26778            -2.0%      24486 ± 22%  softirqs.CPU214.SCHED
     33.67 ± 66%     +54.5%      52.00 ±124%   +1002.5%     371.17 ±159%  softirqs.CPU214.TIMER
     28679 ±  2%      -9.1%      26073 ±  7%      -6.0%      26963 ± 10%  softirqs.CPU215.RCU
     23916 ± 25%     +12.1%      26811           +11.7%      26715        softirqs.CPU215.SCHED
    163.83 ± 81%     -31.7%     111.83 ±  8%     -37.6%     102.17 ± 10%  softirqs.CPU215.TIMER
      1.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU216.BLOCK
     28337 ±  2%      -9.7%      25587 ±  8%      -5.3%      26826 ± 10%  softirqs.CPU216.RCU
     26654            -9.6%      24096 ± 24%      -0.3%      26575        softirqs.CPU216.SCHED
     33.67 ± 83%      -4.5%      32.17 ± 66%     -44.1%      18.83 ± 27%  softirqs.CPU216.TIMER
      0.00       +1.7e+102%       1.67 ±175%   +5e+101%       0.50 ±152%  softirqs.CPU217.BLOCK
     28821 ±  2%      -7.9%      26531 ± 13%      -2.8%      28018 ± 11%  softirqs.CPU217.RCU
     23938 ± 23%     +12.2%      26869           +11.1%      26589 ±  2%  softirqs.CPU217.SCHED
    444.50 ±171%     +16.0%     515.50 ±169%     -74.2%     114.83 ±  7%  softirqs.CPU217.TIMER
     29874            -9.9%      26904 ±  8%      -7.5%      27621 ±  9%  softirqs.CPU218.RCU
     26587           -14.8%      22658 ± 22%     -20.4%      21164 ± 31%  softirqs.CPU218.SCHED
      0.33 ±223%    -100.0%       0.00           +50.0%       0.50 ±223%  softirqs.CPU218.TASKLET
     20.17 ± 17%      +3.3%      20.83 ± 26%     +85.1%      37.33 ± 82%  softirqs.CPU218.TIMER
      0.33 ±223%    -100.0%       0.00         +6350.0%      21.50 ±223%  softirqs.CPU219.BLOCK
     30282            -9.7%      27340 ±  7%      -6.8%      28227 ± 11%  softirqs.CPU219.RCU
     26455            -9.6%      23906 ± 23%      +0.2%      26496        softirqs.CPU219.SCHED
      0.17 ±223%      +0.0%       0.17 ±223%   +2900.0%       5.00 ±223%  softirqs.CPU219.TASKLET
     99.83 ±  3%      +1.5%     101.33 ± 27%     +37.4%     137.17 ± 44%  softirqs.CPU219.TIMER
      2.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU22.BLOCK
     34636 ±  5%     -10.3%      31081 ± 16%      -9.9%      31200 ±  9%  softirqs.CPU22.RCU
     24893 ±  7%      +7.1%      26668 ±  2%      +4.9%      26104 ±  2%  softirqs.CPU22.SCHED
    111.17 ± 42%    +569.0%     743.67 ±187%    +145.0%     272.33 ±160%  softirqs.CPU22.TIMER
      0.33 ±223%    -100.0%       0.00            +0.0%       0.33 ±223%  softirqs.CPU220.BLOCK
     28574 ±  2%     -10.1%      25699 ±  6%      -7.1%      26535 ± 10%  softirqs.CPU220.RCU
     23967 ± 24%     +12.6%      26998 ±  2%     +11.0%      26614        softirqs.CPU220.SCHED
      4.33 ±223%     -96.2%       0.17 ±223%    -100.0%       0.00        softirqs.CPU220.TASKLET
     68.67 ±150%    +817.5%     630.00 ±215%     +27.2%      87.33 ±169%  softirqs.CPU220.TIMER
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU221.BLOCK
     28661 ±  2%      -5.0%      27225 ± 13%      -4.9%      27247 ±  9%  softirqs.CPU221.RCU
     26659            -5.8%      25107 ± 16%      +0.6%      26828        softirqs.CPU221.SCHED
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU221.TASKLET
    130.00 ± 56%    +389.5%     636.33 ±131%     -14.9%     110.67 ±  7%  softirqs.CPU221.TIMER
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU222.BLOCK
     28689 ±  2%     -10.2%      25753 ±  7%      -7.0%      26683 ±  9%  softirqs.CPU222.RCU
     26794            -8.5%      24522 ± 18%      -1.1%      26511        softirqs.CPU222.SCHED
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU222.TASKLET
     95.83 ±144%     -65.9%      32.67 ± 88%     -67.8%      30.83 ± 54%  softirqs.CPU222.TIMER
     27287 ±  5%      -6.3%      25558 ±  9%      -2.7%      26556 ±  9%  softirqs.CPU223.RCU
     23826 ± 24%      +1.7%      24225 ± 23%     +12.9%      26892        softirqs.CPU223.SCHED
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU223.TASKLET
      1282 ±201%     -87.3%     163.50 ± 67%     -89.2%     139.00 ± 37%  softirqs.CPU223.TIMER
      0.00          -100.0%       0.00       +1.2e+102%       1.17 ±223%  softirqs.CPU224.BLOCK
     28542 ±  2%      -8.5%      26114 ±  8%      -4.5%      27268 ± 10%  softirqs.CPU224.RCU
     26662            +0.4%      26761            -2.9%      25891 ±  4%  softirqs.CPU224.SCHED
     19.67 ± 28%    +566.9%     131.17 ±186%    +179.7%      55.00 ± 95%  softirqs.CPU224.TIMER
     17.67 ±179%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU225.BLOCK
     29123            -6.9%      27102 ± 12%      -7.0%      27081 ±  9%  softirqs.CPU225.RCU
     26487            +1.7%      26943            +1.6%      26906        softirqs.CPU225.SCHED
    110.33 ±  3%      +9.7%     121.00 ± 59%      +0.5%     110.83 ± 28%  softirqs.CPU225.TIMER
      0.00         +2e+102%       2.00 ±223%    -100.0%       0.00        softirqs.CPU226.BLOCK
     28496 ±  2%      -4.4%      27250 ±  7%      -7.2%      26448 ± 10%  softirqs.CPU226.RCU
     26198 ±  6%     -10.1%      23545 ± 24%      +1.8%      26680        softirqs.CPU226.SCHED
     24.33 ± 28%   +1312.3%     343.67 ±139%      -8.2%      22.33 ± 20%  softirqs.CPU226.TIMER
      1.67 ±175%    +420.0%       8.67 ±142%    -100.0%       0.00        softirqs.CPU227.BLOCK
     28597            -9.3%      25949 ±  7%      -5.5%      27035 ± 10%  softirqs.CPU227.RCU
     26349 ±  2%      +2.3%      26952            +1.7%      26797        softirqs.CPU227.SCHED
    102.67 ± 39%    +106.8%     212.33 ±125%     +27.8%     131.17 ± 37%  softirqs.CPU227.TIMER
      0.00          -100.0%       0.00       +1.8e+102%       1.83 ±142%  softirqs.CPU228.BLOCK
     28848 ±  2%      -9.5%      26105 ±  7%      -4.9%      27439 ± 11%  softirqs.CPU228.RCU
     24034 ± 24%     +10.5%      26559           +11.1%      26706        softirqs.CPU228.SCHED
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU228.TASKLET
     62.50 ± 97%     -60.5%      24.67 ± 24%     -24.5%      47.17 ± 72%  softirqs.CPU228.TIMER
      2.50 ±190%    +320.0%      10.50 ±223%     -46.7%       1.33 ±223%  softirqs.CPU229.BLOCK
     29169            -8.8%      26609 ±  7%      -5.6%      27543 ±  9%  softirqs.CPU229.RCU
     26535            -5.2%      25160 ± 14%      -8.2%      24359 ± 24%  softirqs.CPU229.SCHED
    147.67 ± 52%     -23.5%     113.00 ±  9%      +3.8%     153.33 ± 50%  softirqs.CPU229.TIMER
      0.33 ±223%    +250.0%       1.17 ±223%    -100.0%       0.00        softirqs.CPU23.BLOCK
     34421 ±  7%     -14.7%      29367 ± 11%      -8.9%      31363 ±  9%  softirqs.CPU23.RCU
     25965 ±  2%      -0.5%      25846 ±  5%      +1.0%      26237        softirqs.CPU23.SCHED
    121.83 ±124%    +140.8%     293.33 ±184%      +8.8%     132.50 ±139%  softirqs.CPU23.TIMER
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU230.BLOCK
     29954 ± 14%     -12.4%      26241 ± 11%     -12.1%      26343 ± 10%  softirqs.CPU230.RCU
     24746 ± 19%      +4.4%      25838 ±  6%      -2.9%      24029 ± 24%  softirqs.CPU230.SCHED
      1220 ±216%     -97.9%      25.83 ± 54%     -97.8%      27.00 ± 42%  softirqs.CPU230.TIMER
      4.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU231.BLOCK
     28823 ±  2%      -8.1%      26475 ±  8%      -5.7%      27174 ±  9%  softirqs.CPU231.RCU
     26824            -0.4%      26708            -0.5%      26700        softirqs.CPU231.SCHED
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU231.TASKLET
    769.67 ±195%     -87.2%      98.17 ± 31%     -83.8%     124.83 ± 46%  softirqs.CPU231.TIMER
      2.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU232.BLOCK
     30943           -15.0%      26293 ± 11%      -9.1%      28117 ± 11%  softirqs.CPU232.RCU
     23471 ± 24%     +12.1%      26304 ±  2%     +10.0%      25809 ±  3%  softirqs.CPU232.SCHED
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU232.TASKLET
     70.83 ±149%    +386.8%     344.83 ±212%     -66.4%      23.83 ± 23%  softirqs.CPU232.TIMER
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU233.BLOCK
     31311 ±  3%     -14.2%      26870 ±  9%      -7.2%      29057 ±  3%  softirqs.CPU233.RCU
     24714 ± 16%      +9.0%      26930            +6.0%      26206 ±  3%  softirqs.CPU233.SCHED
      0.00          -100.0%       0.00       +1.8e+102%       1.83 ±223%  softirqs.CPU233.TASKLET
     95.50 ± 42%     +79.2%     171.17 ± 88%      +7.9%     103.00 ± 34%  softirqs.CPU233.TIMER
      0.00          -100.0%       0.00       +2.5e+102%       2.50 ±190%  softirqs.CPU234.BLOCK
     32047           -12.5%      28027 ±  9%      -9.2%      29102 ± 10%  softirqs.CPU234.RCU
     24661 ± 16%     -15.1%      20939 ± 27%     -13.4%      21362 ± 32%  softirqs.CPU234.SCHED
      0.00          -100.0%       0.00       +8.2e+102%       8.17 ±223%  softirqs.CPU234.TASKLET
     26.67 ± 69%     -20.6%      21.17 ± 17%      -4.4%      25.50 ± 23%  softirqs.CPU234.TIMER
      0.50 ±223%   +4366.7%      22.33 ±223%   +4533.3%      23.17 ±212%  softirqs.CPU235.BLOCK
     32133 ±  2%      -9.3%      29151 ± 12%      -6.5%      30037 ± 10%  softirqs.CPU235.RCU
     24729 ± 16%      +7.5%      26596            +6.9%      26427        softirqs.CPU235.SCHED
      0.00          -100.0%       0.00         +5e+101%       0.50 ±223%  softirqs.CPU235.TASKLET
     89.17 ± 20%     +47.1%     131.17 ± 27%     +50.5%     134.17 ± 44%  softirqs.CPU235.TIMER
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU236.BLOCK
     31517 ±  3%     -13.6%      27240 ± 10%      -6.9%      29327 ± 10%  softirqs.CPU236.RCU
     23909 ± 23%      -0.1%      23891 ± 23%      +0.2%      23948 ± 23%  softirqs.CPU236.SCHED
     30.17 ±108%     -14.4%      25.83 ± 26%     -21.0%      23.83 ± 29%  softirqs.CPU236.TIMER
     14.83 ±223%     -92.1%       1.17 ±223%     -97.8%       0.33 ±223%  softirqs.CPU237.BLOCK
     31451 ±  4%     -11.0%      27987 ±  9%      -5.5%      29709 ± 10%  softirqs.CPU237.RCU
     26202 ±  2%      +2.6%      26892            +1.5%      26584        softirqs.CPU237.SCHED
    100.67 ±  3%     +12.7%     113.50 ±  7%     +22.8%     123.67 ± 14%  softirqs.CPU237.TIMER
     28738 ±  2%     -11.6%      25415 ±  9%      -7.2%      26665 ± 10%  softirqs.CPU238.RCU
     26758           -10.7%      23894 ± 23%     -10.7%      23886 ± 24%  softirqs.CPU238.SCHED
     23.83 ± 39%     -16.1%      20.00 ± 19%    +130.8%      55.00 ± 99%  softirqs.CPU238.TIMER
     16.33 ±205%    -100.0%       0.00           +63.3%      26.67 ±221%  softirqs.CPU239.BLOCK
     32326 ±  7%     -15.8%      27231 ±  8%     -11.5%      28623 ± 11%  softirqs.CPU239.RCU
     26062 ±  2%      +2.2%      26635            +0.9%      26304        softirqs.CPU239.SCHED
    106.83 ±  8%      -3.9%     102.67 ± 15%     +44.8%     154.67 ± 58%  softirqs.CPU239.TIMER
      0.33 ±223%    +800.0%       3.00 ±152%    -100.0%       0.00        softirqs.CPU24.BLOCK
     32334 ±  9%     -12.7%      28237 ±  8%      -7.1%      30037 ± 11%  softirqs.CPU24.RCU
     26503 ±  2%      +6.2%      28140 ± 13%      -0.5%      26382 ±  2%  softirqs.CPU24.SCHED
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU24.TASKLET
      1021 ±203%     -86.2%     141.33 ± 46%     -91.2%      90.17 ± 12%  softirqs.CPU24.TIMER
     32521 ±  5%     -12.3%      28534 ±  9%      -8.1%      29889 ± 11%  softirqs.CPU240.RCU
     26533            -3.6%      25587 ±  7%      -4.4%      25370 ±  6%  softirqs.CPU240.SCHED
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU240.TASKLET
     19.50 ± 31%     +23.1%      24.00 ± 19%     +28.2%      25.00 ± 39%  softirqs.CPU240.TIMER
      0.33 ±223%    +150.0%       0.83 ±145%      +0.0%       0.33 ±223%  softirqs.CPU241.BLOCK
     34134 ±  6%     -14.2%      29280 ± 10%      -6.9%      31787 ± 15%  softirqs.CPU241.RCU
     23647 ± 25%     +12.4%      26583           +11.9%      26457 ±  2%  softirqs.CPU241.SCHED
     84.00 ± 28%     +16.9%      98.17 ± 27%    +749.0%     713.17 ±200%  softirqs.CPU241.TIMER
      0.00          -100.0%       0.00       +6.7e+101%       0.67 ±223%  softirqs.CPU242.BLOCK
     32444 ±  7%     -15.3%      27491 ±  9%      -6.6%      30309 ± 11%  softirqs.CPU242.RCU
     26579            -9.2%      24143 ± 17%      -1.5%      26186        softirqs.CPU242.SCHED
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU242.TASKLET
    113.83 ±135%     -82.0%      20.50 ± 20%     -78.8%      24.17 ± 20%  softirqs.CPU242.TIMER
      0.00          -100.0%       0.00       +2.2e+102%       2.17 ±223%  softirqs.CPU243.BLOCK
     34940 ±  8%     -18.2%      28586 ±  9%     -10.0%      31456 ±  8%  softirqs.CPU243.RCU
     25821 ±  4%      +3.1%      26623            +2.3%      26425        softirqs.CPU243.SCHED
     91.00 ± 47%     +33.9%     121.83 ± 20%     +27.8%     116.33 ± 21%  softirqs.CPU243.TIMER
      2.83 ±223%     -94.1%       0.17 ±223%     -41.2%       1.67 ±223%  softirqs.CPU244.BLOCK
     32122 ±  5%     -16.1%      26965 ±  8%     -11.6%      28382 ± 10%  softirqs.CPU244.RCU
     23796 ± 24%     +11.4%      26507            +2.6%      24412 ± 18%  softirqs.CPU244.SCHED
     33.67 ± 54%    +143.6%      82.00 ±128%     +87.1%      63.00 ±100%  softirqs.CPU244.TIMER
      0.00       +1.2e+102%       1.17 ±159%    -100.0%       0.00        softirqs.CPU245.BLOCK
     30878 ±  4%     -12.1%      27128 ± 10%      -5.7%      29122 ± 13%  softirqs.CPU245.RCU
     26254            +1.5%      26647            +2.2%      26821        softirqs.CPU245.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU245.TASKLET
    103.83 ± 11%      +2.4%     106.33 ± 36%     +50.6%     156.33 ± 63%  softirqs.CPU245.TIMER
      0.00          -100.0%       0.00       +1.3e+102%       1.33 ±223%  softirqs.CPU246.BLOCK
     32283 ±  6%     -15.8%      27172 ±  9%     -10.3%      28964 ± 10%  softirqs.CPU246.RCU
     26633            -8.1%      24470 ± 18%      -1.4%      26256        softirqs.CPU246.SCHED
     31.33 ± 88%     -27.1%      22.83 ± 27%      -5.3%      29.67 ± 47%  softirqs.CPU246.TIMER
      0.00       +2.1e+103%      21.00 ±223%    -100.0%       0.00        softirqs.CPU247.BLOCK
     30689 ±  3%     -10.9%      27331 ± 10%      -7.7%      28336 ± 11%  softirqs.CPU247.RCU
     23862 ± 24%     +12.0%      26734           +11.9%      26712        softirqs.CPU247.SCHED
     94.17 ± 20%     +39.1%     131.00 ± 43%     +12.0%     105.50 ± 16%  softirqs.CPU247.TIMER
      0.00          -100.0%       0.00       +4.5e+102%       4.50 ±223%  softirqs.CPU248.BLOCK
     32421 ±  6%     -10.0%      29174 ± 14%      -6.4%      30338 ± 11%  softirqs.CPU248.RCU
     23808 ± 24%     +10.6%      26343            +0.5%      23923 ± 21%  softirqs.CPU248.SCHED
    660.67 ±212%    +112.6%       1404 ±214%     -96.0%      26.17 ± 34%  softirqs.CPU248.TIMER
     14.67 ±223%    -100.0%       0.00           -69.3%       4.50 ±223%  softirqs.CPU249.BLOCK
     34348 ±  8%     -19.1%      27800 ±  9%     -10.3%      30795 ± 11%  softirqs.CPU249.RCU
     26489            -8.2%      24317 ± 21%      -0.2%      26435        softirqs.CPU249.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU249.TASKLET
    140.00 ± 49%     -11.3%     124.17 ± 16%      +5.8%     148.17 ± 41%  softirqs.CPU249.TIMER
      3.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU25.BLOCK
     30898 ±  3%     -11.1%      27460 ± 12%      -3.2%      29913 ± 10%  softirqs.CPU25.RCU
     27081 ±  2%      -9.5%      24518 ± 17%      -5.4%      25615 ±  9%  softirqs.CPU25.SCHED
      1339 ±215%     +37.5%       1842 ±217%     -94.2%      77.17 ± 61%  softirqs.CPU25.TIMER
     32936 ±  6%     -13.9%      28344 ± 11%      -7.0%      30643 ± 12%  softirqs.CPU250.RCU
     24237 ± 22%      +9.0%      26421            +0.1%      24265 ± 17%  softirqs.CPU250.SCHED
     17.33 ± 27%     +47.1%      25.50 ± 47%     +66.3%      28.83 ± 49%  softirqs.CPU250.TIMER
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU251.BLOCK
     33972 ±  5%     -14.6%      29018 ±  9%      -8.7%      31014 ± 11%  softirqs.CPU251.RCU
     24453 ± 17%      +8.0%      26420            +8.5%      26529        softirqs.CPU251.SCHED
    140.33 ± 49%      -3.8%     135.00 ± 43%     -10.3%     125.83 ± 25%  softirqs.CPU251.TIMER
      4.67 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU252.BLOCK
     33360 ±  3%     -18.5%      27180 ±  9%     -13.6%      28837 ± 10%  softirqs.CPU252.RCU
     19327 ± 38%     +37.3%      26545           +35.4%      26173        softirqs.CPU252.SCHED
    422.33 ±210%     -88.8%      47.50 ±112%     -95.9%      17.50 ±  7%  softirqs.CPU252.TIMER
      2.50 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU253.BLOCK
     31043 ±  4%     -12.7%      27102 ±  9%      -5.5%      29327 ± 11%  softirqs.CPU253.RCU
     26599           -10.0%      23949 ± 23%      -6.2%      24943 ± 23%  softirqs.CPU253.SCHED
    102.83 ± 10%      +1.8%     104.67 ± 25%   +1218.8%       1356 ±201%  softirqs.CPU253.TIMER
      1.67 ±197%     -80.0%       0.33 ±223%    -100.0%       0.00        softirqs.CPU254.BLOCK
     32196 ±  5%     -15.8%      27111 ±  9%      -8.0%      29633 ± 13%  softirqs.CPU254.RCU
     24038 ± 23%     +10.0%      26450            +9.1%      26216        softirqs.CPU254.SCHED
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU254.TASKLET
     19.50 ±  7%     +10.3%      21.50 ± 19%    +124.8%      43.83 ± 74%  softirqs.CPU254.TIMER
      7.33 ±223%     -95.5%       0.33 ±223%     -68.2%       2.33 ±223%  softirqs.CPU255.BLOCK
     31907 ±  4%     -11.6%      28197 ±  9%      -7.7%      29456 ± 11%  softirqs.CPU255.RCU
     13225 ± 27%     -14.4%      11315 ±  8%     +29.0%      17057 ± 39%  softirqs.CPU255.SCHED
     51.17 ±  9%     +11.4%      57.00 ± 12%     +40.7%      72.00 ± 38%  softirqs.CPU255.TIMER
      0.33 ±223%    -100.0%       0.00          +250.0%       1.17 ±223%  softirqs.CPU26.BLOCK
     33518 ±  6%     -12.9%      29207 ± 13%     -10.8%      29907 ±  7%  softirqs.CPU26.RCU
     25700 ±  4%      +5.1%      27009            -7.4%      23797 ± 20%  softirqs.CPU26.SCHED
      0.00          -100.0%       0.00       +3.8e+102%       3.83 ±223%  softirqs.CPU26.TASKLET
     82.83 ±  5%    +400.4%     414.50 ±163%     +18.1%      97.83 ± 26%  softirqs.CPU26.TIMER
      0.00          -100.0%       0.00       +1.4e+103%      14.33 ±205%  softirqs.CPU27.BLOCK
     32484 ±  9%     -13.2%      28196 ±  7%     -10.8%      28976 ±  9%  softirqs.CPU27.RCU
     26478 ±  2%      -1.8%      25990 ±  6%      +4.7%      27731 ±  6%  softirqs.CPU27.SCHED
     56.00 ± 27%      +3.3%      57.83 ± 28%    +187.8%     161.17 ± 95%  softirqs.CPU27.TIMER
      0.00       +4.7e+102%       4.67 ±136% +1.2e+102%       1.17 ±159%  softirqs.CPU28.BLOCK
     33734 ±  6%     -12.7%      29448 ±  9%      -6.9%      31416 ± 10%  softirqs.CPU28.RCU
     23843 ± 20%     +10.2%      26278 ±  4%      -1.6%      23460 ± 18%  softirqs.CPU28.SCHED
      0.67 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU28.TASKLET
     76.67 ±  8%    +115.0%     164.83 ± 89%     +14.3%      87.67 ± 19%  softirqs.CPU28.TIMER
      0.00       +8.7e+102%       8.67 ±177% +3.3e+101%       0.33 ±223%  softirqs.CPU29.BLOCK
     34727 ±  4%     -16.0%      29178 ± 11%      -9.0%      31585 ± 11%  softirqs.CPU29.RCU
     25220 ±  9%      -0.5%      25096 ± 15%      +0.2%      25266 ± 11%  softirqs.CPU29.SCHED
     45.00 ± 18%    +336.7%     196.50 ±122%     +14.1%      51.33 ± 19%  softirqs.CPU29.TIMER
      5.00 ±206%      +6.7%       5.33 ±223%     -36.7%       3.17 ±148%  softirqs.CPU3.BLOCK
     38314 ±  4%     -14.2%      32882 ±  7%     -12.7%      33432 ± 10%  softirqs.CPU3.RCU
     26179 ±  4%      +7.8%      28210 ±  3%      +3.0%      26962        softirqs.CPU3.SCHED
      0.00          -100.0%       0.00       +1.7e+102%       1.67 ±197%  softirqs.CPU3.TASKLET
     70.50 ± 45%   +1021.0%     790.33 ±170%    +681.8%     551.17 ±194%  softirqs.CPU3.TIMER
      0.00         +4e+102%       4.00 ±202%    -100.0%       0.00        softirqs.CPU30.BLOCK
     35115 ±  4%     -12.1%      30850 ± 10%     -10.4%      31471 ± 10%  softirqs.CPU30.RCU
     23995 ± 23%      -2.0%      23514 ± 25%      +5.0%      25190 ±  5%  softirqs.CPU30.SCHED
     65.17 ± 29%     +67.5%     109.17 ± 42%     +40.2%      91.33 ± 11%  softirqs.CPU30.TIMER
      0.00       +7.3e+102%       7.33 ±223%    -100.0%       0.00        softirqs.CPU31.BLOCK
     34540 ±  6%     -12.6%      30200 ± 10%      -9.6%      31236 ± 10%  softirqs.CPU31.RCU
     26592            -0.1%      26558 ±  2%      -0.7%      26395 ±  2%  softirqs.CPU31.SCHED
    963.50 ±213%     -90.2%      94.50 ± 68%     -92.8%      69.83 ± 51%  softirqs.CPU31.TIMER
      2.50 ±206%    -100.0%       0.00           -66.7%       0.83 ±223%  softirqs.CPU32.BLOCK
     32803 ±  3%     -11.1%      29164 ±  9%      -6.8%      30579 ± 10%  softirqs.CPU32.RCU
     25875 ±  4%      -0.4%      25760 ±  4%      -3.3%      25017 ±  4%  softirqs.CPU32.SCHED
    103.50 ± 37%     -22.1%      80.67 ± 39%      +4.0%     107.67 ± 49%  softirqs.CPU32.TIMER
      1.00 ±223%     +16.7%       1.17 ±223%    -100.0%       0.00        softirqs.CPU33.BLOCK
     32304 ±  4%     -13.5%      27958 ± 10%      -7.9%      29737 ± 10%  softirqs.CPU33.RCU
     25868 ±  4%      -2.3%      25263 ±  5%      -1.0%      25620 ±  3%  softirqs.CPU33.SCHED
     44.83 ±  4%   +1363.9%     656.33 ±198%      -4.8%      42.67 ± 13%  softirqs.CPU33.TIMER
      0.00       +1.2e+102%       1.17 ±223% +6.7e+101%       0.67 ±223%  softirqs.CPU34.BLOCK
     33099 ±  3%     -14.7%      28246 ± 10%     -10.1%      29744 ± 10%  softirqs.CPU34.RCU
     26097 ±  4%      -1.5%      25700 ±  4%      -4.3%      24978 ±  7%  softirqs.CPU34.SCHED
    123.50 ± 91%     +84.8%     228.17 ± 90%     -29.0%      87.67 ±  9%  softirqs.CPU34.TIMER
     32634 ±  4%     -14.3%      27966 ± 12%      -9.2%      29636 ± 11%  softirqs.CPU35.RCU
     25549 ±  7%      +2.2%      26104 ±  5%      +1.9%      26027 ±  2%  softirqs.CPU35.SCHED
      0.00       +8.2e+102%       8.17 ±223%    -100.0%       0.00        softirqs.CPU35.TASKLET
     70.67 ± 59%    +438.4%     380.50 ±162%     -24.5%      53.33 ± 15%  softirqs.CPU35.TIMER
      1.00 ±223%     +50.0%       1.50 ±223%    -100.0%       0.00        softirqs.CPU36.BLOCK
     30939 ±  3%     -11.3%      27434 ± 10%      -8.2%      28417 ± 10%  softirqs.CPU36.RCU
     26315 ±  5%      +0.9%      26541 ±  3%      -9.3%      23878 ± 19%  softirqs.CPU36.SCHED
    399.00 ±133%     -77.8%      88.50 ± 14%     -80.3%      78.67 ± 22%  softirqs.CPU36.TIMER
      0.00          -100.0%       0.00       +1.3e+102%       1.33 ±223%  softirqs.CPU37.BLOCK
     31784 ±  4%     -13.7%      27446 ±  9%      -9.9%      28650 ±  8%  softirqs.CPU37.RCU
     25656 ±  8%      +3.0%      26424 ±  3%      +2.8%      26363 ±  2%  softirqs.CPU37.SCHED
    179.33 ±104%     -72.3%      49.67 ± 13%     -54.9%      80.83 ± 76%  softirqs.CPU37.TIMER
      0.17 ±223%    -100.0%       0.00         +2900.0%       5.00 ±223%  softirqs.CPU38.BLOCK
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU38.NET_TX
     31271 ±  5%     -11.7%      27620 ± 10%     -10.6%      27963 ± 10%  softirqs.CPU38.RCU
     25301 ±  6%      +2.4%      25900 ±  3%      +5.9%      26794 ±  2%  softirqs.CPU38.SCHED
    105.50 ± 45%     +42.3%     150.17 ±105%   +1898.1%       2108 ±140%  softirqs.CPU38.TIMER
      4.67 ±223%    -100.0%       0.00          +350.0%      21.00 ±223%  softirqs.CPU39.BLOCK
     30702 ±  8%     -11.6%      27150 ±  9%      -4.6%      29291 ± 12%  softirqs.CPU39.RCU
     24667 ± 18%      +2.5%      25289 ± 11%      +0.8%      24874 ±  6%  softirqs.CPU39.SCHED
      1132 ±214%     -94.2%      65.67 ± 40%     -89.0%     124.83 ±116%  softirqs.CPU39.TIMER
      8.83 ±141%     -94.3%       0.50 ±223%     -64.2%       3.17 ±169%  softirqs.CPU4.BLOCK
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU4.NET_TX
     39017 ±  4%     -18.3%      31881 ± 14%     -12.7%      34043 ± 11%  softirqs.CPU4.RCU
     22124 ± 25%     +19.8%      26501 ±  4%     +17.9%      26086 ±  2%  softirqs.CPU4.SCHED
     82.67 ±  6%   +2280.4%       1967 ±214%      +6.5%      88.00 ±  3%  softirqs.CPU4.TIMER
      4.83 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU40.BLOCK
     29568 ±  6%     -12.7%      25808 ±  8%      -3.5%      28543 ± 15%  softirqs.CPU40.RCU
     24690 ± 12%      +5.8%      26133 ±  3%      -1.7%      24262 ± 11%  softirqs.CPU40.SCHED
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU40.TASKLET
    115.50 ± 59%     -33.9%      76.33 ± 30%     -20.3%      92.00 ± 10%  softirqs.CPU40.TIMER
      0.00         +2e+102%       2.00 ±223%    -100.0%       0.00        softirqs.CPU41.BLOCK
     29153            -7.5%      26968 ± 14%      -7.1%      27097 ±  9%  softirqs.CPU41.RCU
     24384 ± 16%      +0.1%      24411 ±  9%      +5.8%      25788 ±  4%  softirqs.CPU41.SCHED
     50.33 ±  9%   +2735.8%       1427 ±136%      -2.3%      49.17 ± 11%  softirqs.CPU41.TIMER
      0.00          -100.0%       0.00       +3.5e+102%       3.50 ±129%  softirqs.CPU42.BLOCK
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU42.NET_TX
     30786           -10.0%      27718 ±  9%      -0.7%      30585 ± 11%  softirqs.CPU42.RCU
     21625 ± 24%      +5.9%      22897 ± 26%      +7.2%      23185 ± 18%  softirqs.CPU42.SCHED
     74.33 ±  7%   +1112.3%     901.17 ±199%    +868.6%     720.00 ±194%  softirqs.CPU42.TIMER
      0.00          -100.0%       0.00         +2e+102%       2.00 ±223%  softirqs.CPU43.BLOCK
     30661            -9.0%      27892 ±  8%      -6.7%      28600 ±  8%  softirqs.CPU43.RCU
     24432 ± 17%      -2.1%      23912 ± 10%      +0.4%      24521 ± 17%  softirqs.CPU43.SCHED
     61.17 ± 49%      -0.3%      61.00 ± 19%      -7.1%      56.83 ±  6%  softirqs.CPU43.TIMER
     28548 ±  3%      -7.3%      26451 ±  6%      -5.1%      27101 ±  9%  softirqs.CPU44.RCU
     25586 ±  6%      +3.8%      26552 ±  2%      +5.4%      26955        softirqs.CPU44.SCHED
     85.83 ±  3%     +41.0%     121.00 ± 40%      +1.0%      86.67 ±  9%  softirqs.CPU44.TIMER
      0.00         +2e+102%       2.00 ±223% +1.3e+102%       1.33 ±223%  softirqs.CPU45.BLOCK
     28837 ±  3%      -8.6%      26350 ±  7%      -6.4%      27001 ± 10%  softirqs.CPU45.RCU
     25251 ±  8%      +6.1%      26792            +2.5%      25885 ±  3%  softirqs.CPU45.SCHED
      0.00          -100.0%       0.00         +5e+101%       0.50 ±223%  softirqs.CPU45.TASKLET
    203.67 ±161%     -61.9%      77.67 ± 58%     -74.3%      52.33 ±  8%  softirqs.CPU45.TIMER
      0.00          -100.0%       0.00       +8.3e+101%       0.83 ±223%  softirqs.CPU46.BLOCK
     31807            -9.8%      28694 ±  7%      -6.2%      29836 ±  6%  softirqs.CPU46.RCU
     23587 ± 22%      -9.1%      21451 ± 29%     +15.2%      27172 ±  8%  softirqs.CPU46.SCHED
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU46.TASKLET
    138.83 ± 97%     -37.6%      86.67 ±  8%     +37.7%     191.17 ± 56%  softirqs.CPU46.TIMER
      0.33 ±223%   +1250.0%       4.50 ±223%      +0.0%       0.33 ±223%  softirqs.CPU47.BLOCK
     31938           -10.5%      28584 ±  8%      -8.7%      29155 ± 14%  softirqs.CPU47.RCU
     26132 ±  3%      -4.2%      25047 ±  6%      +1.2%      26458        softirqs.CPU47.SCHED
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU47.TASKLET
     51.00 ± 11%     +19.9%      61.17 ± 28%   +3672.9%       1924 ±135%  softirqs.CPU47.TIMER
      0.50 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU48.BLOCK
     29140            -1.4%      28744 ± 12%      -4.9%      27721 ± 15%  softirqs.CPU48.RCU
     26061 ±  4%      -4.4%      24915 ± 15%      +0.0%      26072 ± 14%  softirqs.CPU48.SCHED
     74.17 ± 16%     +28.3%      95.17 ±  8%   +6172.8%       4652 ±219%  softirqs.CPU48.TIMER
      0.33 ±223%    +100.0%       0.67 ±223%    -100.0%       0.00        softirqs.CPU49.BLOCK
     28983 ±  2%      -8.1%      26642 ±  9%      -5.5%      27388 ± 10%  softirqs.CPU49.RCU
     23876 ± 22%     +11.4%      26606 ±  2%     +13.7%      27141 ±  3%  softirqs.CPU49.SCHED
     52.17 ± 52%      -2.2%      51.00 ± 32%    +172.5%     142.17 ±150%  softirqs.CPU49.TIMER
      4.67 ±223%    -100.0%       0.00           -92.9%       0.33 ±223%  softirqs.CPU5.BLOCK
     37913 ±  4%     -18.8%      30791 ± 15%     -11.1%      33706 ± 11%  softirqs.CPU5.RCU
     24940 ± 18%      +3.2%      25733 ±  4%      +3.4%      25786 ±  6%  softirqs.CPU5.SCHED
     48.33 ± 11%   +4654.5%       2298 ±218%      +8.3%      52.33 ± 18%  softirqs.CPU5.TIMER
      1.83 ±223%     -54.5%       0.83 ±223%    +145.5%       4.50 ±223%  softirqs.CPU50.BLOCK
     28665            -6.9%      26682 ±  6%      -3.9%      27556 ± 10%  softirqs.CPU50.RCU
     26580            -3.0%      25778 ± 11%      -2.8%      25839 ±  4%  softirqs.CPU50.SCHED
    105.33 ±111%     -14.9%      89.67 ± 10%      -6.5%      98.50 ± 24%  softirqs.CPU50.TIMER
      1.67 ±175%     -80.0%       0.33 ±223%    +360.0%       7.67 ±223%  softirqs.CPU51.BLOCK
     28837 ±  9%      -8.4%      26401 ±  7%      -5.2%      27339 ± 10%  softirqs.CPU51.RCU
     25861 ±  5%      -4.0%      24823 ± 18%      -1.1%      25579 ±  5%  softirqs.CPU51.SCHED
      1266 ±208%     -95.9%      51.33 ±  5%     -93.0%      88.50 ± 74%  softirqs.CPU51.TIMER
      0.00          -100.0%       0.00       +4.2e+102%       4.17 ±223%  softirqs.CPU52.BLOCK
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU52.NET_TX
     29028            -8.6%      26546 ±  7%      -6.3%      27196 ± 10%  softirqs.CPU52.RCU
     22246 ± 24%     +19.6%      26599 ±  2%     +13.0%      25145 ±  6%  softirqs.CPU52.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU52.TASKLET
     83.67 ± 16%     -11.0%      74.50 ± 34%    +102.6%     169.50 ± 74%  softirqs.CPU52.TIMER
      0.00       +1.8e+102%       1.83 ±179%   +1e+102%       1.00 ±223%  softirqs.CPU53.BLOCK
     30570 ±  7%     -13.0%      26589 ±  6%     -10.7%      27303 ± 12%  softirqs.CPU53.RCU
     25184 ±  6%      +2.7%      25854 ±  6%      -2.4%      24578 ± 19%  softirqs.CPU53.SCHED
      0.17 ±223%    -100.0%       0.00          +100.0%       0.33 ±223%  softirqs.CPU53.TASKLET
    439.67 ±205%     -81.4%      81.67 ±130%    +205.8%       1344 ±205%  softirqs.CPU53.TIMER
     12.00 ±223%     -97.2%       0.33 ±223%     -91.7%       1.00 ±223%  softirqs.CPU54.BLOCK
     28893            -5.2%      27394 ±  9%      -5.2%      27392 ±  9%  softirqs.CPU54.RCU
     25488 ±  3%      +3.2%      26306 ±  4%      +1.9%      25984 ±  3%  softirqs.CPU54.SCHED
     85.17 ± 24%      +3.9%      88.50 ± 12%      +0.2%      85.33 ± 25%  softirqs.CPU54.TIMER
      0.00       +4.7e+102%       4.67 ±223%    -100.0%       0.00        softirqs.CPU55.BLOCK
     28939            -8.6%      26452 ±  7%      -5.6%      27304 ± 10%  softirqs.CPU55.RCU
     26747            -1.7%      26299 ±  4%      -1.4%      26369 ±  3%  softirqs.CPU55.SCHED
     74.00 ± 71%     -34.2%      48.67 ± 10%      -3.4%      71.50 ± 78%  softirqs.CPU55.TIMER
      7.17 ±223%     -88.4%       0.83 ±223%    -100.0%       0.00        softirqs.CPU56.BLOCK
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU56.NET_TX
     29840 ±  6%      -6.7%      27826 ± 11%      -3.7%      28733 ±  9%  softirqs.CPU56.RCU
     23436 ± 23%      +7.8%      25264 ± 10%      +6.5%      24953 ±  5%  softirqs.CPU56.SCHED
    538.50 ±162%    +146.6%       1328 ±204%     -83.8%      87.50 ± 14%  softirqs.CPU56.TIMER
     28677 ±  2%      -6.6%      26789 ±  8%      -5.2%      27198 ± 10%  softirqs.CPU57.RCU
     25797 ±  4%      +3.6%      26735 ±  3%      -0.3%      25712 ±  3%  softirqs.CPU57.SCHED
    726.17 ±200%     +10.9%     805.17 ±188%     -93.2%      49.33 ± 26%  softirqs.CPU57.TIMER
     29377 ±  3%      -9.9%      26468 ±  6%      -3.9%      28222 ± 12%  softirqs.CPU58.RCU
     24827 ± 19%      +4.7%      26002 ±  3%      +1.9%      25303 ±  7%  softirqs.CPU58.SCHED
    425.50 ±181%     -25.2%     318.17 ±159%     -72.1%     118.67 ± 58%  softirqs.CPU58.TIMER
     29145 ±  2%      -9.6%      26349 ±  7%      -6.0%      27390 ± 10%  softirqs.CPU59.RCU
     24214 ± 20%      +8.5%      26277 ±  3%      +8.9%      26380 ±  4%  softirqs.CPU59.SCHED
    138.67 ±112%     -53.0%      65.17 ± 47%     -49.2%      70.50 ± 65%  softirqs.CPU59.TIMER
      0.00       +2.5e+102%       2.50 ±190% +5.8e+102%       5.83 ±172%  softirqs.CPU6.BLOCK
     39432 ±  5%     -15.1%      33488 ± 10%     -13.4%      34131 ± 10%  softirqs.CPU6.RCU
     23495 ± 23%     +10.2%      25903 ±  4%      +3.0%      24191 ± 16%  softirqs.CPU6.SCHED
      0.00          -100.0%       0.00         +5e+101%       0.50 ±223%  softirqs.CPU6.TASKLET
    150.50 ± 95%     -37.5%      94.00 ± 38%     -28.2%     108.00 ± 36%  softirqs.CPU6.TIMER
      0.17 ±223%    +500.0%       1.00 ±223%    -100.0%       0.00        softirqs.CPU60.BLOCK
     28801            -6.7%      26875 ±  7%      -0.8%      28566 ± 13%  softirqs.CPU60.RCU
     23994 ± 18%      -0.4%      23888 ± 20%     +10.9%      26601 ±  7%  softirqs.CPU60.SCHED
     88.00 ± 19%     +44.7%     127.33 ± 60%    +311.7%     362.33 ±165%  softirqs.CPU60.TIMER
      7.17 ±142%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU61.BLOCK
      0.00       +3.3e+101%       0.33 ±223%    -100.0%       0.00        softirqs.CPU61.NET_TX
     28837            -8.3%      26457 ±  7%      -8.1%      26488 ± 11%  softirqs.CPU61.RCU
     23746 ± 22%      +9.2%      25935 ±  3%      +9.8%      26071 ±  3%  softirqs.CPU61.SCHED
     47.83 ± 30%     +43.2%      68.50 ± 63%   +4989.9%       2434 ±218%  softirqs.CPU61.TIMER
      9.17 ±107%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU62.BLOCK
     29049            -6.0%      27320 ±  8%      -2.5%      28315 ± 11%  softirqs.CPU62.RCU
     20935 ± 20%      +8.7%      22755 ±  5%     +10.1%      23056 ±  9%  softirqs.CPU62.SCHED
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU62.TASKLET
    104.50 ±  8%      -8.0%      96.17 ± 21%    +169.9%     282.00 ±140%  softirqs.CPU62.TIMER
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU63.BLOCK
     29210            -9.4%      26478 ±  7%      -5.2%      27691 ±  7%  softirqs.CPU63.RCU
     13323 ± 24%      -9.5%      12054 ± 26%     +13.8%      15167 ± 16%  softirqs.CPU63.SCHED
      2.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU63.TASKLET
     66.33 ± 10%     -11.1%      59.00 ± 22%     +87.9%     124.67 ±106%  softirqs.CPU63.TIMER
      1.00 ±223%     -16.7%       0.83 ±223%      +0.0%       1.00 ±223%  softirqs.CPU64.BLOCK
     28533 ±  2%      -2.8%      27743 ± 10%      -3.1%      27642 ± 12%  softirqs.CPU64.RCU
     22362 ± 20%      +8.0%      24145 ± 19%      +6.5%      23807 ± 15%  softirqs.CPU64.SCHED
      2.17 ±203%    -100.0%       0.00           -92.3%       0.17 ±223%  softirqs.CPU64.TASKLET
     36.17 ± 41%   +2057.1%     780.17 ±137%     +53.5%      55.50 ± 73%  softirqs.CPU64.TIMER
      0.00       +3.3e+101%       0.33 ±223%    -100.0%       0.00        softirqs.CPU65.BLOCK
     30282 ±  5%      -5.2%      28708 ± 15%      +6.5%      32257 ± 11%  softirqs.CPU65.RCU
     23375 ± 23%     +16.9%      27325 ±  6%      +8.8%      25427 ± 24%  softirqs.CPU65.SCHED
      2072 ± 45%      +9.5%       2268 ± 86%     +52.0%       3150 ± 48%  softirqs.CPU65.TIMER
      0.83 ±223%    +560.0%       5.50 ±192%    +580.0%       5.67 ±185%  softirqs.CPU66.BLOCK
     28611            -8.0%      26319 ± 10%      -2.0%      28030 ± 18%  softirqs.CPU66.RCU
     24092 ± 24%     +10.9%      26724 ±  3%     +11.7%      26901        softirqs.CPU66.SCHED
     35.50 ± 29%     +75.1%      62.17 ± 53%   +5705.2%       2060 ±152%  softirqs.CPU66.TIMER
      4.33 ±134%     -34.6%       2.83 ±193%    +188.5%      12.50 ±122%  softirqs.CPU67.BLOCK
     28820            -7.7%      26586 ±  6%      -6.5%      26950 ±  9%  softirqs.CPU67.RCU
     24346 ± 24%      -6.8%      22690 ± 26%      +9.4%      26645        softirqs.CPU67.SCHED
     34.17 ± 32%     +74.6%      59.67 ± 78%   +2762.0%     977.83 ±214%  softirqs.CPU67.TIMER
      1.33 ±223%      +0.0%       1.33 ±223%      +0.0%       1.33 ±223%  softirqs.CPU68.BLOCK
     29503           -11.7%      26057 ± 10%      -6.9%      27468 ±  9%  softirqs.CPU68.RCU
     26599           -10.6%      23789 ± 23%      -9.0%      24217 ± 22%  softirqs.CPU68.SCHED
     46.33 ± 90%     +19.1%      55.17 ± 94%     -18.0%      38.00 ± 23%  softirqs.CPU68.TIMER
      4.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU69.BLOCK
     29950 ±  5%     -12.9%      26081 ±  9%      -9.0%      27270 ±  9%  softirqs.CPU69.RCU
     24829 ± 18%      +7.0%      26556            +7.0%      26565        softirqs.CPU69.SCHED
     42.67 ± 70%    +100.8%      85.67 ± 82%     -19.9%      34.17 ± 18%  softirqs.CPU69.TIMER
      0.33 ±223%    -100.0%       0.00          +300.0%       1.33 ±223%  softirqs.CPU7.BLOCK
     39128 ±  4%     -15.5%      33079 ± 10%     -12.0%      34433 ± 12%  softirqs.CPU7.RCU
     26425 ±  3%      -2.7%      25708 ±  3%      -0.3%      26344 ±  3%  softirqs.CPU7.SCHED
     69.83 ± 61%    +178.0%     194.17 ± 99%   +1012.2%     776.67 ±205%  softirqs.CPU7.TIMER
      0.00         +2e+102%       2.00 ±223% +4.8e+102%       4.83 ±223%  softirqs.CPU70.BLOCK
     28755            -8.8%      26214 ±  7%      -5.6%      27146 ±  9%  softirqs.CPU70.RCU
     26790            +0.3%      26877            -3.6%      25824 ±  7%  softirqs.CPU70.SCHED
      0.00         +5e+101%       0.50 ±223%    -100.0%       0.00        softirqs.CPU70.TASKLET
     28.83 ± 12%    +162.4%      75.67 ±106%     +19.7%      34.50 ± 17%  softirqs.CPU70.TIMER
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU71.BLOCK
     28704            -9.3%      26047 ±  8%      -5.5%      27116 ± 10%  softirqs.CPU71.RCU
     26715            +0.4%      26831            -9.4%      24205 ± 22%  softirqs.CPU71.SCHED
     29.83 ± 24%     +13.4%      33.83 ± 34%      +6.1%      31.67 ± 22%  softirqs.CPU71.TIMER
     29286 ±  3%     -10.4%      26227 ±  6%      -7.2%      27180 ± 10%  softirqs.CPU72.RCU
     26844 ±  2%      +0.1%      26868            -3.1%      26020 ±  4%  softirqs.CPU72.SCHED
    386.33 ±206%     -84.9%      58.17 ± 83%     -53.5%     179.83 ±149%  softirqs.CPU72.TIMER
     28790 ±  3%      -6.1%      27030 ± 11%      -4.7%      27446 ±  8%  softirqs.CPU73.RCU
     24311 ± 25%     +10.0%      26746            -3.5%      23458 ± 21%  softirqs.CPU73.SCHED
      0.33 ±223%    +350.0%       1.50 ±223%    -100.0%       0.00        softirqs.CPU73.TASKLET
    307.50 ±201%     -89.2%      33.33 ± 14%     -85.5%      44.50 ± 65%  softirqs.CPU73.TIMER
      1.00 ±223%    -100.0%       0.00           -66.7%       0.33 ±223%  softirqs.CPU74.BLOCK
     28713            -4.7%      27371 ±  9%      -5.8%      27059 ± 10%  softirqs.CPU74.RCU
     26786           -11.1%      23811 ± 24%      +1.2%      27104 ±  2%  softirqs.CPU74.SCHED
     50.00 ± 31%     +96.0%      98.00 ± 78%     +65.7%      82.83 ± 91%  softirqs.CPU74.TIMER
     28368 ±  2%      -7.2%      26328 ±  8%      -5.7%      26752 ±  9%  softirqs.CPU75.RCU
     26769            +1.2%      27099            +0.1%      26800        softirqs.CPU75.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU75.TASKLET
     45.50 ± 47%    +571.4%     305.50 ±193%   +1828.2%     877.33 ±214%  softirqs.CPU75.TIMER
      0.00       +1.2e+102%       1.17 ±159%    -100.0%       0.00        softirqs.CPU76.BLOCK
     28636            -7.5%      26479 ±  8%      -6.4%      26812 ±  9%  softirqs.CPU76.RCU
     24784 ± 18%      +6.7%      26445 ±  6%      +6.8%      26465        softirqs.CPU76.SCHED
      0.00          -100.0%       0.00         +1e+102%       1.00 ±223%  softirqs.CPU76.TASKLET
     52.67 ± 58%     +16.5%      61.33 ± 81%     -37.3%      33.00 ± 42%  softirqs.CPU76.TIMER
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU77.BLOCK
     28126            -6.3%      26359 ±  9%      -4.7%      26804 ± 10%  softirqs.CPU77.RCU
     21735 ± 32%     +13.6%      24699 ± 18%     +14.6%      24912 ± 15%  softirqs.CPU77.SCHED
      0.00       +6.7e+101%       0.67 ±223% +2.7e+102%       2.67 ±223%  softirqs.CPU77.TASKLET
     52.33 ± 82%     +14.0%      59.67 ± 72%    +103.8%     106.67 ±161%  softirqs.CPU77.TIMER
      0.00          -100.0%       0.00         +9e+102%       9.00 ±142%  softirqs.CPU78.BLOCK
     28363            -7.9%      26117 ±  7%      -4.7%      27030 ± 10%  softirqs.CPU78.RCU
     26746            +0.2%      26797            +0.1%      26770        softirqs.CPU78.SCHED
      1.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU78.TASKLET
     59.83 ± 72%     -49.9%      30.00 ± 19%     -38.2%      37.00 ± 30%  softirqs.CPU78.TIMER
      0.00          -100.0%       0.00       +1.2e+102%       1.17 ±223%  softirqs.CPU79.BLOCK
     27819            -7.3%      25783 ±  7%      -4.1%      26667 ± 10%  softirqs.CPU79.RCU
     26698            -2.0%      26152 ±  6%      -9.9%      24048 ± 23%  softirqs.CPU79.SCHED
     50.50 ±105%   +1322.1%     718.17 ±213%    +129.0%     115.67 ±173%  softirqs.CPU79.TIMER
      2.17 ±223%    -100.0%       0.00          +215.4%       6.83 ±223%  softirqs.CPU8.BLOCK
     36617 ±  5%     -19.6%      29423 ± 10%     -10.2%      32867 ±  8%  softirqs.CPU8.RCU
     24534 ±  4%      +5.1%      25781 ±  5%     +14.6%      28111 ± 22%  softirqs.CPU8.SCHED
     46.67 ±  3%      +4.3%      48.67 ± 12%      -6.1%      43.83 ±  2%  softirqs.CPU8.TASKLET
    139.17 ± 55%     -25.7%     103.33 ± 33%    +828.9%       1292 ±207%  softirqs.CPU8.TIMER
      4.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU80.BLOCK
     28194 ±  2%      -2.5%      27501 ± 13%      -6.3%      26429 ± 10%  softirqs.CPU80.RCU
     26767           -13.5%      23158 ± 22%      -0.9%      26530        softirqs.CPU80.SCHED
     64.17 ±126%   +2326.8%       1557 ±138%     -42.9%      36.67 ± 17%  softirqs.CPU80.TIMER
      0.17 ±223%    -100.0%       0.00            +0.0%       0.17 ±223%  softirqs.CPU81.BLOCK
     28840 ±  2%      -8.6%      26372 ±  8%      -5.1%      27380 ± 12%  softirqs.CPU81.RCU
     24017 ± 24%      +8.4%      26027 ± 10%      +1.4%      24363 ± 25%  softirqs.CPU81.SCHED
     29.17 ± 41%   +1968.6%     603.33 ±206%   +2210.9%     674.00 ±210%  softirqs.CPU81.TIMER
      0.00          -100.0%       0.00       +3.3e+101%       0.33 ±223%  softirqs.CPU82.BLOCK
     29319           -11.8%      25870 ±  8%      -3.7%      28232 ± 11%  softirqs.CPU82.RCU
     26424            +0.4%      26536           -13.0%      22994 ± 23%  softirqs.CPU82.SCHED
     61.67 ±123%     -34.6%      40.33 ± 53%     +67.8%     103.50 ±159%  softirqs.CPU82.TIMER
      0.00       +4.5e+102%       4.50 ±223%    -100.0%       0.00        softirqs.CPU83.BLOCK
     28437 ±  2%      -8.5%      26019 ±  7%      -5.2%      26965 ±  9%  softirqs.CPU83.RCU
     24864 ± 17%      -2.4%      24256 ± 23%      +8.4%      26952        softirqs.CPU83.SCHED
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU83.TASKLET
     34.00 ± 47%     +71.1%      58.17 ± 75%      +1.5%      34.50 ± 68%  softirqs.CPU83.TIMER
      0.00       +4.8e+102%       4.83 ±223% +6.7e+101%       0.67 ±223%  softirqs.CPU84.BLOCK
     30751 ± 11%     -13.1%      26720 ±  3%     -13.1%      26737 ±  9%  softirqs.CPU84.RCU
     26658            -1.2%      26349 ±  7%      -0.6%      26505 ±  2%  softirqs.CPU84.SCHED
     30.83 ± 41%   +1984.3%     642.67 ±207%     +76.8%      54.50 ± 74%  softirqs.CPU84.TIMER
      0.00       +1.2e+102%       1.17 ±223%    -100.0%       0.00        softirqs.CPU85.BLOCK
     28726            -6.0%      27007 ±  9%      -5.5%      27153 ± 10%  softirqs.CPU85.RCU
     26584            -9.4%      24081 ± 24%      -8.8%      24257 ± 22%  softirqs.CPU85.SCHED
     38.50 ± 71%      -9.1%      35.00 ± 46%     -27.3%      28.00 ± 29%  softirqs.CPU85.TIMER
     30567 ±  6%     -12.7%      26675 ±  9%      -9.8%      27558 ±  9%  softirqs.CPU86.RCU
     25630 ±  7%      +3.5%      26533            -7.1%      23812 ± 23%  softirqs.CPU86.SCHED
     33.83 ± 33%    +103.4%      68.83 ±132%     -12.3%      29.67 ± 22%  softirqs.CPU86.TIMER
      0.33 ±223%    +800.0%       3.00 ±223%    -100.0%       0.00        softirqs.CPU87.BLOCK
     29742           -10.0%      26764 ±  8%      -6.9%      27693 ±  9%  softirqs.CPU87.RCU
     26538            +0.6%      26707            -0.2%      26483        softirqs.CPU87.SCHED
     54.67 ±136%     -10.7%      48.83 ± 80%     +99.1%     108.83 ±172%  softirqs.CPU87.TIMER
      0.00       +4.3e+102%       4.33 ±113%    -100.0%       0.00        softirqs.CPU88.BLOCK
     27728 ±  4%      -8.7%      25320 ±  7%      -4.2%      26567 ± 10%  softirqs.CPU88.RCU
     24298 ± 24%      -0.6%      24154 ± 24%      +0.3%      24365 ± 23%  softirqs.CPU88.SCHED
    913.67 ±217%     -95.6%      40.50 ± 72%     -96.2%      34.33 ± 14%  softirqs.CPU88.TIMER
      0.67 ±223%    +200.0%       2.00 ±223%    -100.0%       0.00        softirqs.CPU89.BLOCK
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU89.NET_TX
     28232 ±  2%      -8.7%      25788 ±  8%      -3.8%      27161 ± 10%  softirqs.CPU89.RCU
     26759            +0.7%      26953            -0.1%      26738        softirqs.CPU89.SCHED
    682.83 ±215%     -10.7%     609.50 ±213%     -93.6%      43.50 ± 69%  softirqs.CPU89.TIMER
      0.00          -100.0%       0.00       +3.3e+101%       0.33 ±223%  softirqs.CPU9.BLOCK
     34251 ±  7%      -9.6%      30978 ± 12%      -8.4%      31390 ± 11%  softirqs.CPU9.RCU
     26463 ±  2%      -0.9%      26238 ±  5%      -9.6%      23920 ± 16%  softirqs.CPU9.SCHED
     39.50 ±  2%     +13.5%      44.83 ± 29%      -1.3%      39.00        softirqs.CPU9.TASKLET
     77.67 ± 76%     -32.6%      52.33 ± 20%     -10.5%      69.50 ± 59%  softirqs.CPU9.TIMER
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU90.BLOCK
     27923 ±  2%      -5.1%      26510 ± 11%      -2.1%      27337 ±  3%  softirqs.CPU90.RCU
     26851            -0.4%      26746            -4.7%      25598 ± 10%  softirqs.CPU90.SCHED
     32.00 ± 32%     +70.3%      54.50 ± 96%     +62.0%      51.83 ± 71%  softirqs.CPU90.TIMER
      0.00          -100.0%       0.00       +8.5e+102%       8.50 ±168%  softirqs.CPU91.BLOCK
     28519            -6.9%      26561 ±  8%      -5.4%      26991 ± 10%  softirqs.CPU91.RCU
     26824            -9.9%      24167 ± 17%      +0.1%      26854        softirqs.CPU91.SCHED
     36.50 ± 79%    +726.5%     301.67 ±199%    +781.7%     321.83 ±204%  softirqs.CPU91.TIMER
     29597           -11.8%      26115 ± 11%      -6.8%      27594 ±  9%  softirqs.CPU92.RCU
     26635            -0.6%      26484            -0.9%      26392        softirqs.CPU92.SCHED
      0.50 ±223%     -66.7%       0.17 ±223%    -100.0%       0.00        softirqs.CPU92.TASKLET
     32.00 ± 30%   +2512.5%     836.00 ±216%     -17.2%      26.50 ± 25%  softirqs.CPU92.TIMER
      4.67 ±223%     -42.9%       2.67 ±165%     -89.3%       0.50 ±152%  softirqs.CPU93.BLOCK
     29962 ±  2%     -10.5%      26827 ± 11%      -7.9%      27591 ±  9%  softirqs.CPU93.RCU
     26661            -6.8%      24836 ± 17%      -1.0%      26399        softirqs.CPU93.SCHED
     44.83 ± 82%    +475.8%     258.17 ±195%     -35.7%      28.83 ± 22%  softirqs.CPU93.TIMER
      0.00       +3.5e+102%       3.50 ±147%    -100.0%       0.00        softirqs.CPU94.BLOCK
     28276 ±  2%      -8.4%      25894 ±  8%      -5.2%      26818 ± 10%  softirqs.CPU94.RCU
     26718            -0.5%      26584            +0.3%      26805        softirqs.CPU94.SCHED
     31.83 ± 42%    +141.4%      76.83 ±132%    +262.3%     115.33 ±157%  softirqs.CPU94.TIMER
      0.00       +6.2e+102%       6.17 ±172% +1.3e+102%       1.33 ±223%  softirqs.CPU95.BLOCK
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU95.NET_TX
     28449            -7.5%      26310 ±  8%      -6.1%      26716 ± 10%  softirqs.CPU95.RCU
     26716            +1.2%      27036            -0.2%      26650        softirqs.CPU95.SCHED
      0.00          -100.0%       0.00       +6.3e+102%       6.33 ±223%  softirqs.CPU95.TASKLET
     34.33 ± 48%    +662.6%     261.83 ±195%      -3.9%      33.00 ± 41%  softirqs.CPU95.TIMER
      0.67 ±223%     -50.0%       0.33 ±223%     -50.0%       0.33 ±223%  softirqs.CPU96.BLOCK
     28571            -8.5%      26152 ±  6%      -0.7%      28377 ± 13%  softirqs.CPU96.RCU
     26659            +0.4%      26759           -15.7%      22463 ± 24%  softirqs.CPU96.SCHED
     38.67 ± 61%   +1423.3%     589.00 ±199%     +23.3%      47.67 ± 51%  softirqs.CPU96.TIMER
      5.33 ±207%     -93.8%       0.33 ±223%     +25.0%       6.67 ±157%  softirqs.CPU97.BLOCK
     28413 ±  2%     -11.8%      25070 ± 10%      -5.0%      26984 ± 10%  softirqs.CPU97.RCU
     26610            +0.4%      26720            +2.2%      27186 ±  2%  softirqs.CPU97.SCHED
     24.00 ± 35%  +11428.5%       2766 ±220%     +13.2%      27.17 ± 28%  softirqs.CPU97.TIMER
      0.00         +5e+101%       0.50 ±223% +3.7e+102%       3.67 ±200%  softirqs.CPU98.BLOCK
     29489 ±  6%     -10.9%      26263 ±  8%      -8.8%      26905 ±  9%  softirqs.CPU98.RCU
     22673 ± 24%     +13.8%      25793 ±  8%      -1.6%      22317 ± 28%  softirqs.CPU98.SCHED
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU98.TASKLET
     30.67 ± 43%   +4000.0%       1257 ±210%      +1.1%      31.00 ± 16%  softirqs.CPU98.TIMER
     28764 ±  2%      -9.2%      26128 ±  8%      -6.8%      26799 ± 10%  softirqs.CPU99.RCU
     26541 ±  3%      -8.7%      24229 ± 23%      -0.1%      26517        softirqs.CPU99.SCHED
      7.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU99.TASKLET
     51.50 ±109%    +404.9%     260.00 ±108%     -41.4%      30.17 ± 38%  softirqs.CPU99.TIMER
      5.00            +0.0%       5.00            +0.0%       5.00        softirqs.HI
      5719 ± 31%    +126.2%      12934 ± 44%    +203.7%      17370 ± 23%  softirqs.NET_RX
     47.50 ±  2%     +13.3%      53.83 ±  3%      +8.8%      51.67 ±  2%  softirqs.NET_TX
   7687317 ±  2%     -10.0%    6919148 ±  7%      -6.6%    7180474 ± 10%  softirqs.RCU
   6434341            +1.5%    6529867            +1.6%    6535091        softirqs.SCHED
    291.67            -0.2%     291.00            -1.0%     288.67        softirqs.TASKLET
     53620 ±  2%     +21.9%      65345 ±  3%     +20.9%      64827        softirqs.TIMER
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.0:IR-IO-APIC.2-edge.timer
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.18:IR-IO-APIC.18-fasteoi.ehci_hcd:usb1,ehci_hcd:usb2,i801_smbus
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.31:IR-PCI-MSI.2621440-edge.eth0
      1577 ± 96%    +169.0%       4242 ±130%    +179.4%       4406 ±133%  interrupts.32:IR-PCI-MSI.2621441-edge.eth0-TxRx-0
      1397 ±130%    +146.6%       3446 ±104%    +564.9%       9292 ±113%  interrupts.33:IR-PCI-MSI.2621442-edge.eth0-TxRx-1
      1193 ± 41%    +408.2%       6067 ± 79%    +712.8%       9703 ± 93%  interrupts.34:IR-PCI-MSI.2621443-edge.eth0-TxRx-2
      2739 ± 77%     +51.8%       4158 ±146%     +63.4%       4476 ± 99%  interrupts.35:IR-PCI-MSI.2621444-edge.eth0-TxRx-3
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.37:IR-PCI-MSI.3145729-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.38:IR-PCI-MSI.3145730-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.39:IR-PCI-MSI.3145731-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.3:IR-IO-APIC.3-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.40:IR-PCI-MSI.3145732-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.41:IR-PCI-MSI.327680-edge.xhci_hcd
      3.00            +0.0%       3.00            +0.0%       3.00        interrupts.42:IR-PCI-MSI.512000-edge.ahci[0000:00:1f.2]
     40.67 ±  4%      +0.0%      40.67 ±  4%      +0.0%      40.67 ±  4%  interrupts.4:IR-IO-APIC.4-edge.ttyS0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.8:IR-IO-APIC.8-edge.rtc0
      0.00       +6.7e+104%     670.33       +6.7e+104%     670.00        interrupts.9:IR-IO-APIC.9-fasteoi.acpi
    353302          +107.6%     733618 ± 21%     +94.0%     685435 ± 13%  interrupts.CAL:Function_call_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.0:IR-IO-APIC.2-edge.timer
    938.00 ± 21%    +168.4%       2517 ± 10%    +159.9%       2437 ± 10%  interrupts.CPU0.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  interrupts.CPU0.IWI:IRQ_work_interrupts
    602641            -0.3%     600805            -0.2%     601425        interrupts.CPU0.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU0.MCP:Machine_check_polls
    210.00 ± 26%      -4.8%     200.00 ± 32%     +72.9%     363.00 ± 49%  interrupts.CPU0.NMI:Non-maskable_interrupts
    210.00 ± 26%      -4.8%     200.00 ± 32%     +72.9%     363.00 ± 49%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
      8.83 ± 34%    +330.2%      38.00 ± 12%    +345.3%      39.33 ± 32%  interrupts.CPU0.RES:Rescheduling_interrupts
     14.17 ± 17%      +7.1%      15.17 ± 19%     +15.3%      16.33 ± 23%  interrupts.CPU0.TLB:TLB_shootdowns
      0.00       +6.7e+104%     670.33       +6.7e+104%     670.00        interrupts.CPU1.9:IR-IO-APIC.9-fasteoi.acpi
      1371 ±  5%    +197.3%       4078 ± 43%    +141.3%       3310 ± 28%  interrupts.CPU1.CAL:Function_call_interrupts
      0.50 ±223%    -100.0%       0.00           +33.3%       0.67 ±223%  interrupts.CPU1.IWI:IRQ_work_interrupts
    602267            -0.4%     600142            -0.1%     601413        interrupts.CPU1.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU1.MCP:Machine_check_polls
    994.33 ±172%     -81.2%     187.17 ± 33%     -76.9%     229.83 ± 34%  interrupts.CPU1.NMI:Non-maskable_interrupts
    994.33 ±172%     -81.2%     187.17 ± 33%     -76.9%     229.83 ± 34%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
     20.17 ± 36%     +90.9%      38.50 ±111%    +205.0%      61.50 ±162%  interrupts.CPU1.RES:Rescheduling_interrupts
    103.00 ±160%     -77.0%      23.67 ± 23%     -74.4%      26.33 ± 36%  interrupts.CPU1.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.8:IR-IO-APIC.8-edge.rtc0
      1651 ±  8%     +98.0%       3269 ± 31%     +81.0%       2990 ± 14%  interrupts.CPU10.CAL:Function_call_interrupts
    602439            -0.8%     597445            -0.2%     601189        interrupts.CPU10.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU10.MCP:Machine_check_polls
    264.83 ± 33%      +4.4%     276.50 ± 40%     -13.8%     228.33 ± 34%  interrupts.CPU10.NMI:Non-maskable_interrupts
    264.83 ± 33%      +4.4%     276.50 ± 40%     -13.8%     228.33 ± 34%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
     58.33 ± 17%     -14.9%      49.67 ± 33%     +22.0%      71.17 ± 25%  interrupts.CPU10.RES:Rescheduling_interrupts
     69.17 ± 10%     -33.7%      45.83 ± 32%     -10.1%      62.17 ± 13%  interrupts.CPU10.TLB:TLB_shootdowns
      1286 ±  3%    +101.4%       2591 ± 18%    +113.1%       2741 ± 16%  interrupts.CPU100.CAL:Function_call_interrupts
    602219            -1.2%     594692            -0.3%     600403        interrupts.CPU100.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU100.MCP:Machine_check_polls
    276.17 ± 33%     +21.8%     336.33 ± 28%     -12.8%     240.83 ± 31%  interrupts.CPU100.NMI:Non-maskable_interrupts
    276.17 ± 33%     +21.8%     336.33 ± 28%     -12.8%     240.83 ± 31%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
     17.83 ± 26%     -54.2%       8.17 ± 27%    +345.8%      79.50 ±175%  interrupts.CPU100.RES:Rescheduling_interrupts
     16.17 ± 22%      -5.2%      15.33 ± 30%      -9.3%      14.67 ± 43%  interrupts.CPU100.TLB:TLB_shootdowns
      1225          +125.6%       2764 ± 18%    +105.1%       2513 ± 13%  interrupts.CPU101.CAL:Function_call_interrupts
    602064            -1.6%     592347 ±  2%      -0.3%     600089        interrupts.CPU101.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU101.MCP:Machine_check_polls
    323.67 ± 30%     -23.3%     248.17 ± 28%     -22.6%     250.67 ± 34%  interrupts.CPU101.NMI:Non-maskable_interrupts
    323.67 ± 30%     -23.3%     248.17 ± 28%     -22.6%     250.67 ± 34%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
     10.83 ± 30%      -7.7%      10.00 ± 35%    +241.5%      37.00 ±119%  interrupts.CPU101.RES:Rescheduling_interrupts
     10.83 ± 11%     +18.5%      12.83 ± 47%     +13.8%      12.33 ± 37%  interrupts.CPU101.TLB:TLB_shootdowns
      1249 ±  3%    +161.5%       3268 ± 40%     +99.5%       2493 ± 15%  interrupts.CPU102.CAL:Function_call_interrupts
    602248            -0.9%     596763            -0.3%     600591        interrupts.CPU102.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU102.MCP:Machine_check_polls
    281.50 ± 33%     +34.3%     378.17 ± 35%     -14.0%     242.17 ± 32%  interrupts.CPU102.NMI:Non-maskable_interrupts
    281.50 ± 33%     +34.3%     378.17 ± 35%     -14.0%     242.17 ± 32%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
     13.83 ± 68%    +502.4%      83.33 ±181%    +160.2%      36.00 ±158%  interrupts.CPU102.RES:Rescheduling_interrupts
     14.17 ± 47%     +25.9%      17.83 ± 31%     +21.2%      17.17 ± 26%  interrupts.CPU102.TLB:TLB_shootdowns
      1235 ±  2%    +131.1%       2855 ± 22%    +119.0%       2707 ± 20%  interrupts.CPU103.CAL:Function_call_interrupts
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU103.IWI:IRQ_work_interrupts
    602220            -1.5%     593043            -0.4%     599962        interrupts.CPU103.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU103.MCP:Machine_check_polls
    580.33 ±126%     -36.8%     366.83 ± 29%     -51.8%     279.50 ± 35%  interrupts.CPU103.NMI:Non-maskable_interrupts
    580.33 ±126%     -36.8%     366.83 ± 29%     -51.8%     279.50 ± 35%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
      8.17 ± 58%    +449.0%      44.83 ±175%    +728.6%      67.67 ±129%  interrupts.CPU103.RES:Rescheduling_interrupts
     10.33 ± 22%      +1.6%      10.50 ± 25%     +27.4%      13.17 ± 47%  interrupts.CPU103.TLB:TLB_shootdowns
      1292 ±  3%    +117.4%       2810 ± 13%     +89.9%       2455 ± 15%  interrupts.CPU104.CAL:Function_call_interrupts
    602286            -0.4%     599612            -0.2%     600991        interrupts.CPU104.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU104.MCP:Machine_check_polls
    279.17 ± 25%      -4.1%     267.67 ± 31%     -31.5%     191.33 ± 18%  interrupts.CPU104.NMI:Non-maskable_interrupts
    279.17 ± 25%      -4.1%     267.67 ± 31%     -31.5%     191.33 ± 18%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
     17.67 ± 25%     +82.1%      32.17 ±113%     -26.4%      13.00 ± 41%  interrupts.CPU104.RES:Rescheduling_interrupts
     18.17 ± 16%     +11.0%      20.17 ± 38%     -24.8%      13.67 ± 32%  interrupts.CPU104.TLB:TLB_shootdowns
      1285 ±  9%    +105.2%       2638 ± 18%     +94.4%       2499 ± 15%  interrupts.CPU105.CAL:Function_call_interrupts
    602223            -1.0%     596470            -0.3%     600368        interrupts.CPU105.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU105.MCP:Machine_check_polls
    275.83 ± 32%     +12.4%     310.17 ± 32%     -10.5%     247.00 ± 40%  interrupts.CPU105.NMI:Non-maskable_interrupts
    275.83 ± 32%     +12.4%     310.17 ± 32%     -10.5%     247.00 ± 40%  interrupts.CPU105.PMI:Performance_monitoring_interrupts
     10.00 ± 21%     +38.3%      13.83 ± 48%    +171.7%      27.17 ±128%  interrupts.CPU105.RES:Rescheduling_interrupts
      9.33 ± 24%      +0.0%       9.33 ± 13%      +7.1%      10.00 ± 24%  interrupts.CPU105.TLB:TLB_shootdowns
      1200 ± 17%    +152.3%       3027 ± 28%    +106.8%       2481 ± 14%  interrupts.CPU106.CAL:Function_call_interrupts
    602107            -0.9%     596479            -0.3%     600582        interrupts.CPU106.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU106.MCP:Machine_check_polls
    275.17 ± 32%      -0.7%     273.33 ± 38%     -22.0%     214.67 ± 11%  interrupts.CPU106.NMI:Non-maskable_interrupts
    275.17 ± 32%      -0.7%     273.33 ± 38%     -22.0%     214.67 ± 11%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
     16.17 ± 40%    +161.9%      42.33 ±164%      +6.2%      17.17 ± 65%  interrupts.CPU106.RES:Rescheduling_interrupts
     20.17 ± 45%     -23.1%      15.50 ± 23%      -5.8%      19.00 ± 17%  interrupts.CPU106.TLB:TLB_shootdowns
      1238          +123.7%       2771 ± 15%    +175.7%       3415 ± 57%  interrupts.CPU107.CAL:Function_call_interrupts
    601964            -1.1%     595548            -0.3%     600074        interrupts.CPU107.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU107.MCP:Machine_check_polls
    243.83 ± 29%     +12.8%     275.00 ± 33%      -2.6%     237.50 ± 30%  interrupts.CPU107.NMI:Non-maskable_interrupts
    243.83 ± 29%     +12.8%     275.00 ± 33%      -2.6%     237.50 ± 30%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
     11.67 ± 45%    +121.4%      25.83 ±149%      +7.1%      12.50 ± 31%  interrupts.CPU107.RES:Rescheduling_interrupts
     12.00 ± 35%     -18.1%       9.83 ± 25%     -11.1%      10.67 ± 16%  interrupts.CPU107.TLB:TLB_shootdowns
      1254 ±  2%    +117.4%       2727 ± 17%    +100.2%       2511 ± 13%  interrupts.CPU108.CAL:Function_call_interrupts
    602052            -0.3%     599946            -0.2%     601007        interrupts.CPU108.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU108.MCP:Machine_check_polls
    200.83 ± 28%     +25.1%     251.33 ± 35%      -1.0%     198.83 ± 36%  interrupts.CPU108.NMI:Non-maskable_interrupts
    200.83 ± 28%     +25.1%     251.33 ± 35%      -1.0%     198.83 ± 36%  interrupts.CPU108.PMI:Performance_monitoring_interrupts
     11.33 ± 26%     +47.1%      16.67 ± 33%     +26.5%      14.33 ± 34%  interrupts.CPU108.RES:Rescheduling_interrupts
     18.17 ± 11%      -6.4%      17.00 ±  6%      -6.4%      17.00 ± 14%  interrupts.CPU108.TLB:TLB_shootdowns
      1244          +114.4%       2666 ± 17%    +100.5%       2494 ± 19%  interrupts.CPU109.CAL:Function_call_interrupts
    602090            -0.4%     599503            -0.2%     601008        interrupts.CPU109.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU109.MCP:Machine_check_polls
    228.33 ± 33%     +21.9%     278.33 ± 27%     -14.5%     195.33 ± 32%  interrupts.CPU109.NMI:Non-maskable_interrupts
    228.33 ± 33%     +21.9%     278.33 ± 27%     -14.5%     195.33 ± 32%  interrupts.CPU109.PMI:Performance_monitoring_interrupts
      9.50 ± 52%      +5.3%      10.00 ± 29%     +54.4%      14.67 ± 28%  interrupts.CPU109.RES:Rescheduling_interrupts
     10.33 ± 26%      +0.0%      10.33 ± 22%     +17.7%      12.17 ± 29%  interrupts.CPU109.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.31:IR-PCI-MSI.2621440-edge.eth0
      1320 ±  3%    +121.2%       2920 ± 36%     +84.5%       2436 ± 19%  interrupts.CPU11.CAL:Function_call_interrupts
      0.00       +6.7e+101%       0.67 ±223%    -100.0%       0.00        interrupts.CPU11.IWI:IRQ_work_interrupts
    602345            -0.4%     600054            -0.2%     601273        interrupts.CPU11.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU11.MCP:Machine_check_polls
    180.33 ±  2%     +40.2%     252.83 ± 46%     +38.9%     250.50 ± 33%  interrupts.CPU11.NMI:Non-maskable_interrupts
    180.33 ±  2%     +40.2%     252.83 ± 46%     +38.9%     250.50 ± 33%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
     21.67 ± 18%     -44.6%      12.00 ± 36%     -12.3%      19.00 ± 40%  interrupts.CPU11.RES:Rescheduling_interrupts
     14.83 ± 15%      +3.4%      15.33 ± 44%      -2.2%      14.50 ± 13%  interrupts.CPU11.TLB:TLB_shootdowns
      1281 ±  3%    +124.6%       2877 ± 30%     +93.4%       2477 ± 15%  interrupts.CPU110.CAL:Function_call_interrupts
    602273            -0.9%     596993            -0.3%     600187        interrupts.CPU110.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU110.MCP:Machine_check_polls
    294.83 ± 32%      -0.6%     293.17 ± 32%     -12.9%     256.67 ± 34%  interrupts.CPU110.NMI:Non-maskable_interrupts
    294.83 ± 32%      -0.6%     293.17 ± 32%     -12.9%     256.67 ± 34%  interrupts.CPU110.PMI:Performance_monitoring_interrupts
     18.83 ± 29%    +156.6%      48.33 ±133%     -35.4%      12.17 ± 64%  interrupts.CPU110.RES:Rescheduling_interrupts
     17.83 ±  7%     -15.0%      15.17 ± 27%     -22.4%      13.83 ± 30%  interrupts.CPU110.TLB:TLB_shootdowns
      1283 ±  5%    +115.0%       2758 ± 25%     +82.8%       2345 ± 19%  interrupts.CPU111.CAL:Function_call_interrupts
    602123            -1.0%     595805            -0.3%     600279        interrupts.CPU111.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU111.MCP:Machine_check_polls
    292.67 ± 30%      -2.7%     284.83 ± 31%     -12.5%     256.17 ± 33%  interrupts.CPU111.NMI:Non-maskable_interrupts
    292.67 ± 30%      -2.7%     284.83 ± 31%     -12.5%     256.17 ± 33%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
     11.33 ± 25%    +102.9%      23.00 ± 85%     -16.2%       9.50 ± 72%  interrupts.CPU111.RES:Rescheduling_interrupts
      9.17 ± 17%     +81.8%      16.67 ± 71%     +10.9%      10.17 ± 18%  interrupts.CPU111.TLB:TLB_shootdowns
      1251 ±  4%    +114.5%       2685 ± 17%    +100.8%       2513 ± 18%  interrupts.CPU112.CAL:Function_call_interrupts
      0.50 ±223%     +33.3%       0.67 ±223%     -66.7%       0.17 ±223%  interrupts.CPU112.IWI:IRQ_work_interrupts
    602238            -1.1%     595719            -0.4%     600121        interrupts.CPU112.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU112.MCP:Machine_check_polls
    286.17 ± 40%     -10.0%     257.67 ± 33%      +9.6%     313.50 ± 50%  interrupts.CPU112.NMI:Non-maskable_interrupts
    286.17 ± 40%     -10.0%     257.67 ± 33%      +9.6%     313.50 ± 50%  interrupts.CPU112.PMI:Performance_monitoring_interrupts
     16.00 ± 52%     -31.2%      11.00 ± 33%      +1.0%      16.17 ± 49%  interrupts.CPU112.RES:Rescheduling_interrupts
     14.00 ± 36%      +6.0%      14.83 ± 30%     +10.7%      15.50 ± 46%  interrupts.CPU112.TLB:TLB_shootdowns
      1304 ±  8%    +121.1%       2883 ± 23%     +85.9%       2424 ± 15%  interrupts.CPU113.CAL:Function_call_interrupts
    602251            -0.8%     597687            -0.4%     600019        interrupts.CPU113.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU113.MCP:Machine_check_polls
    260.50 ± 34%     -11.5%     230.67 ± 30%      +0.6%     262.00 ± 37%  interrupts.CPU113.NMI:Non-maskable_interrupts
    260.50 ± 34%     -11.5%     230.67 ± 30%      +0.6%     262.00 ± 37%  interrupts.CPU113.PMI:Performance_monitoring_interrupts
     20.83 ± 66%     -60.8%       8.17 ± 19%     -48.8%      10.67 ± 41%  interrupts.CPU113.RES:Rescheduling_interrupts
     16.17 ± 56%     -39.2%       9.83 ± 25%     -50.5%       8.00 ± 25%  interrupts.CPU113.TLB:TLB_shootdowns
      1312 ± 10%    +109.2%       2745 ± 26%     +86.2%       2443 ± 15%  interrupts.CPU114.CAL:Function_call_interrupts
    602415            -1.1%     595598            -0.3%     600657        interrupts.CPU114.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU114.MCP:Machine_check_polls
    308.33 ± 35%      -2.8%     299.67 ± 34%     -16.9%     256.17 ± 33%  interrupts.CPU114.NMI:Non-maskable_interrupts
    308.33 ± 35%      -2.8%     299.67 ± 34%     -16.9%     256.17 ± 33%  interrupts.CPU114.PMI:Performance_monitoring_interrupts
     19.17 ± 72%      -2.6%      18.67 ± 80%     -39.1%      11.67 ± 40%  interrupts.CPU114.RES:Rescheduling_interrupts
     12.00 ± 45%     +34.7%      16.17 ± 35%     +41.7%      17.00 ± 27%  interrupts.CPU114.TLB:TLB_shootdowns
      1280 ±  6%     +97.4%       2526 ± 22%     +91.5%       2451 ± 14%  interrupts.CPU115.CAL:Function_call_interrupts
    602230            -0.9%     596574            -0.3%     600304        interrupts.CPU115.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU115.MCP:Machine_check_polls
    285.67 ± 35%      +0.5%     287.00 ± 30%     -10.0%     257.17 ± 35%  interrupts.CPU115.NMI:Non-maskable_interrupts
    285.67 ± 35%      +0.5%     287.00 ± 30%     -10.0%     257.17 ± 35%  interrupts.CPU115.PMI:Performance_monitoring_interrupts
     12.50 ± 25%      -8.0%      11.50 ± 51%     -22.7%       9.67 ± 35%  interrupts.CPU115.RES:Rescheduling_interrupts
     12.50 ± 51%      -6.7%      11.67 ± 51%     -21.3%       9.83 ± 19%  interrupts.CPU115.TLB:TLB_shootdowns
      1411 ± 26%     +88.5%       2659 ± 18%     +81.3%       2558 ± 14%  interrupts.CPU116.CAL:Function_call_interrupts
    602260            -1.2%     594920            -0.3%     600159        interrupts.CPU116.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU116.MCP:Machine_check_polls
    246.67 ± 30%     +27.4%     314.33 ± 33%      -3.4%     238.17 ± 33%  interrupts.CPU116.NMI:Non-maskable_interrupts
    246.67 ± 30%     +27.4%     314.33 ± 33%      -3.4%     238.17 ± 33%  interrupts.CPU116.PMI:Performance_monitoring_interrupts
     12.50 ± 31%     +41.3%      17.67 ± 89%     -28.0%       9.00 ± 43%  interrupts.CPU116.RES:Rescheduling_interrupts
     15.33 ± 55%     -17.4%      12.67 ± 53%     -15.2%      13.00 ± 32%  interrupts.CPU116.TLB:TLB_shootdowns
      1230 ±  2%    +114.7%       2640 ± 17%     +97.9%       2435 ± 15%  interrupts.CPU117.CAL:Function_call_interrupts
    602274            -1.2%     594890            -0.4%     600073        interrupts.CPU117.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU117.MCP:Machine_check_polls
    284.00 ± 34%     +16.6%     331.17 ± 40%      -4.8%     270.50 ± 54%  interrupts.CPU117.NMI:Non-maskable_interrupts
    284.00 ± 34%     +16.6%     331.17 ± 40%      -4.8%     270.50 ± 54%  interrupts.CPU117.PMI:Performance_monitoring_interrupts
      8.67 ± 59%     +73.1%      15.00 ± 71%     -15.4%       7.33 ± 24%  interrupts.CPU117.RES:Rescheduling_interrupts
     10.83 ± 30%     +10.8%      12.00 ± 36%     -13.8%       9.33 ±  5%  interrupts.CPU117.TLB:TLB_shootdowns
      1289 ±  4%    +104.9%       2641 ± 19%     +91.6%       2470 ± 14%  interrupts.CPU118.CAL:Function_call_interrupts
    602267            -1.0%     596003            -0.3%     600513        interrupts.CPU118.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU118.MCP:Machine_check_polls
    324.17 ± 34%     -36.3%     206.33 ±  3%     -17.9%     266.17 ± 36%  interrupts.CPU118.NMI:Non-maskable_interrupts
    324.17 ± 34%     -36.3%     206.33 ±  3%     -17.9%     266.17 ± 36%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
     13.00 ± 40%     +46.2%      19.00 ± 31%     +14.1%      14.83 ± 67%  interrupts.CPU118.RES:Rescheduling_interrupts
     16.67 ± 29%      +2.0%      17.00 ± 24%     -13.0%      14.50 ± 45%  interrupts.CPU118.TLB:TLB_shootdowns
      1272 ±  8%     +97.4%       2512 ± 22%     +90.9%       2429 ± 15%  interrupts.CPU119.CAL:Function_call_interrupts
    602271            -0.9%     596644            -0.3%     600635        interrupts.CPU119.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU119.MCP:Machine_check_polls
    311.83 ± 33%     -23.9%     237.33 ± 35%     -13.8%     268.67 ± 35%  interrupts.CPU119.NMI:Non-maskable_interrupts
    311.83 ± 33%     -23.9%     237.33 ± 35%     -13.8%     268.67 ± 35%  interrupts.CPU119.PMI:Performance_monitoring_interrupts
     14.67 ± 71%     -31.8%      10.00 ± 44%     -34.1%       9.67 ± 63%  interrupts.CPU119.RES:Rescheduling_interrupts
     16.17 ± 91%     -37.1%      10.17 ± 26%     -42.3%       9.33 ± 27%  interrupts.CPU119.TLB:TLB_shootdowns
      1577 ± 96%    +169.0%       4242 ±130%    +179.4%       4406 ±133%  interrupts.CPU12.32:IR-PCI-MSI.2621441-edge.eth0-TxRx-0
      1654 ± 10%    +124.7%       3717 ± 55%     +84.9%       3058 ± 36%  interrupts.CPU12.CAL:Function_call_interrupts
    602141            -0.3%     600305            -0.1%     601317        interrupts.CPU12.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU12.MCP:Machine_check_polls
    252.33 ± 34%     -14.8%     215.00 ± 27%     +23.2%     311.00 ± 70%  interrupts.CPU12.NMI:Non-maskable_interrupts
    252.33 ± 34%     -14.8%     215.00 ± 27%     +23.2%     311.00 ± 70%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
     47.50 ± 45%      +1.1%      48.00 ± 47%    +108.8%      99.17 ± 88%  interrupts.CPU12.RES:Rescheduling_interrupts
     59.67 ± 28%      +6.4%      63.50 ± 24%      +7.0%      63.83 ± 29%  interrupts.CPU12.TLB:TLB_shootdowns
      1340 ±  3%     +95.4%       2620 ± 18%     +89.5%       2540 ± 16%  interrupts.CPU120.CAL:Function_call_interrupts
      0.00       +1.3e+102%       1.33 ±223%    -100.0%       0.00        interrupts.CPU120.IWI:IRQ_work_interrupts
    602140            -1.0%     595916            -0.3%     600607        interrupts.CPU120.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU120.MCP:Machine_check_polls
    263.17 ± 32%    +197.2%     782.00 ±166%      -1.4%     259.50 ± 33%  interrupts.CPU120.NMI:Non-maskable_interrupts
    263.17 ± 32%    +197.2%     782.00 ±166%      -1.4%     259.50 ± 33%  interrupts.CPU120.PMI:Performance_monitoring_interrupts
     23.33 ± 31%     -47.9%      12.17 ± 38%     -28.6%      16.67 ± 55%  interrupts.CPU120.RES:Rescheduling_interrupts
     15.17 ± 29%     -20.9%      12.00 ± 31%     +47.3%      22.33 ± 80%  interrupts.CPU120.TLB:TLB_shootdowns
      1224          +112.0%       2595 ± 18%     +99.1%       2436 ± 15%  interrupts.CPU121.CAL:Function_call_interrupts
    602087            -0.7%     597889            -0.3%     600421        interrupts.CPU121.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU121.MCP:Machine_check_polls
    231.00 ± 27%     +24.7%     288.00 ± 35%     +23.7%     285.83 ± 31%  interrupts.CPU121.NMI:Non-maskable_interrupts
    231.00 ± 27%     +24.7%     288.00 ± 35%     +23.7%     285.83 ± 31%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
     10.50 ± 41%      -9.5%       9.50 ± 27%     +36.5%      14.33 ± 43%  interrupts.CPU121.RES:Rescheduling_interrupts
      9.67 ± 28%      +3.4%      10.00 ± 16%     +20.7%      11.67 ± 33%  interrupts.CPU121.TLB:TLB_shootdowns
      1311 ±  3%     +98.9%       2608 ± 18%     +86.6%       2447 ± 15%  interrupts.CPU122.CAL:Function_call_interrupts
    602143            -1.3%     594041            -0.3%     600167        interrupts.CPU122.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU122.MCP:Machine_check_polls
    266.00 ± 33%     -13.7%     229.67 ± 26%     +19.6%     318.17 ± 43%  interrupts.CPU122.NMI:Non-maskable_interrupts
    266.00 ± 33%     -13.7%     229.67 ± 26%     +19.6%     318.17 ± 43%  interrupts.CPU122.PMI:Performance_monitoring_interrupts
     18.67 ± 27%     -40.2%      11.17 ± 27%     -46.4%      10.00 ± 28%  interrupts.CPU122.RES:Rescheduling_interrupts
     19.33 ± 44%     -32.8%      13.00 ± 24%     -15.5%      16.33 ± 17%  interrupts.CPU122.TLB:TLB_shootdowns
      1255 ±  3%    +107.0%       2597 ± 18%     +93.2%       2425 ± 15%  interrupts.CPU123.CAL:Function_call_interrupts
    602119            -0.9%     596838            -0.3%     600512        interrupts.CPU123.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU123.MCP:Machine_check_polls
    233.00 ± 33%      -2.4%     227.50 ± 29%      -3.7%     224.33 ± 32%  interrupts.CPU123.NMI:Non-maskable_interrupts
    233.00 ± 33%      -2.4%     227.50 ± 29%      -3.7%     224.33 ± 32%  interrupts.CPU123.PMI:Performance_monitoring_interrupts
     16.00 ± 39%     -49.0%       8.17 ± 63%     -44.8%       8.83 ± 27%  interrupts.CPU123.RES:Rescheduling_interrupts
     11.83 ± 26%      +0.0%      11.83 ± 41%     -23.9%       9.00 ± 21%  interrupts.CPU123.TLB:TLB_shootdowns
      1268 ±  2%    +105.4%       2604 ± 18%     +97.6%       2505 ± 16%  interrupts.CPU124.CAL:Function_call_interrupts
    602066            -1.0%     596345            -0.3%     600380        interrupts.CPU124.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU124.MCP:Machine_check_polls
    278.00 ± 33%     -12.6%     243.00 ± 30%      +0.1%     278.17 ± 37%  interrupts.CPU124.NMI:Non-maskable_interrupts
    278.00 ± 33%     -12.6%     243.00 ± 30%      +0.1%     278.17 ± 37%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
     16.50 ± 30%     -33.3%      11.00 ± 52%     +19.2%      19.67 ± 55%  interrupts.CPU124.RES:Rescheduling_interrupts
     16.00 ± 20%     -11.5%      14.17 ± 32%      +2.1%      16.33 ± 42%  interrupts.CPU124.TLB:TLB_shootdowns
      1335 ± 19%     +94.5%       2597 ± 18%    +123.2%       2981 ± 23%  interrupts.CPU125.CAL:Function_call_interrupts
    602254            -1.0%     596355            -0.3%     600443        interrupts.CPU125.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU125.MCP:Machine_check_polls
    272.00 ± 35%      +0.7%     274.00 ± 35%     +17.6%     320.00 ± 28%  interrupts.CPU125.NMI:Non-maskable_interrupts
    272.00 ± 35%      +0.7%     274.00 ± 35%     +17.6%     320.00 ± 28%  interrupts.CPU125.PMI:Performance_monitoring_interrupts
      7.83 ± 46%     +42.6%      11.17 ± 50%    +129.8%      18.00 ± 81%  interrupts.CPU125.RES:Rescheduling_interrupts
      9.50 ± 15%     +19.3%      11.33 ± 14%     +36.8%      13.00 ± 32%  interrupts.CPU125.TLB:TLB_shootdowns
      1353 ±  3%     +95.4%       2645 ± 18%     +84.6%       2498 ± 15%  interrupts.CPU126.CAL:Function_call_interrupts
    602483            -1.1%     595872            -0.4%     600192        interrupts.CPU126.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU126.MCP:Machine_check_polls
    285.67 ± 35%     -13.9%     246.00 ± 32%     +20.3%     343.67 ± 27%  interrupts.CPU126.NMI:Non-maskable_interrupts
    285.67 ± 35%     -13.9%     246.00 ± 32%     +20.3%     343.67 ± 27%  interrupts.CPU126.PMI:Performance_monitoring_interrupts
     26.83 ± 34%     -32.9%      18.00 ± 32%     -27.3%      19.50 ± 40%  interrupts.CPU126.RES:Rescheduling_interrupts
     24.00 ± 19%     -31.2%      16.50 ± 44%      -6.2%      22.50 ± 23%  interrupts.CPU126.TLB:TLB_shootdowns
      1237          +125.5%       2790 ± 25%     +96.5%       2431 ± 15%  interrupts.CPU127.CAL:Function_call_interrupts
    602183            -1.1%     595655            -0.3%     600605        interrupts.CPU127.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU127.MCP:Machine_check_polls
    327.50 ± 34%     -25.2%     245.00 ± 26%     +67.2%     547.50 ± 87%  interrupts.CPU127.NMI:Non-maskable_interrupts
    327.50 ± 34%     -25.2%     245.00 ± 26%     +67.2%     547.50 ± 87%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
     13.33 ± 31%     +32.5%      17.67 ± 95%     -32.5%       9.00 ± 30%  interrupts.CPU127.RES:Rescheduling_interrupts
     10.50 ± 15%     +92.1%      20.17 ± 47%    +581.0%      71.50 ±192%  interrupts.CPU127.TLB:TLB_shootdowns
      1452 ± 36%    +114.6%       3116 ± 36%     +66.2%       2413 ± 15%  interrupts.CPU128.CAL:Function_call_interrupts
    602002            -0.8%     597011            -0.3%     600279        interrupts.CPU128.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU128.MCP:Machine_check_polls
    257.50 ± 30%     +13.1%     291.17 ± 31%      -3.3%     249.00 ± 32%  interrupts.CPU128.NMI:Non-maskable_interrupts
    257.50 ± 30%     +13.1%     291.17 ± 31%      -3.3%     249.00 ± 32%  interrupts.CPU128.PMI:Performance_monitoring_interrupts
      9.50 ± 24%     -26.3%       7.00 ± 55%     -33.3%       6.33 ± 33%  interrupts.CPU128.RES:Rescheduling_interrupts
      7.33 ± 17%      +9.1%       8.00 ± 33%      -6.8%       6.83 ± 13%  interrupts.CPU128.TLB:TLB_shootdowns
      1219          +124.3%       2734 ± 18%    +106.9%       2522 ± 22%  interrupts.CPU129.CAL:Function_call_interrupts
      0.00         +5e+101%       0.50 ±223% +3.3e+101%       0.33 ±223%  interrupts.CPU129.IWI:IRQ_work_interrupts
    601757            -2.0%     589560 ±  3%      -0.3%     600193        interrupts.CPU129.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU129.MCP:Machine_check_polls
    519.83 ±117%     -52.2%     248.33 ± 31%     -46.1%     280.17 ± 34%  interrupts.CPU129.NMI:Non-maskable_interrupts
    519.83 ±117%     -52.2%     248.33 ± 31%     -46.1%     280.17 ± 34%  interrupts.CPU129.PMI:Performance_monitoring_interrupts
      7.67 ± 25%      +0.0%       7.67 ± 30%      +6.5%       8.17 ± 34%  interrupts.CPU129.RES:Rescheduling_interrupts
      9.83 ± 69%     -20.3%       7.83 ± 48%     -18.6%       8.00 ± 40%  interrupts.CPU129.TLB:TLB_shootdowns
      1397 ±130%    +146.6%       3446 ±104%    +564.9%       9292 ±113%  interrupts.CPU13.33:IR-PCI-MSI.2621442-edge.eth0-TxRx-1
      1370 ±  6%    +101.9%       2767 ± 23%    +110.9%       2891 ± 34%  interrupts.CPU13.CAL:Function_call_interrupts
    602371            -0.2%     601117            -0.2%     601189        interrupts.CPU13.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU13.MCP:Machine_check_polls
    269.67 ± 35%      -1.9%     264.67 ± 32%     -17.9%     221.50 ± 42%  interrupts.CPU13.NMI:Non-maskable_interrupts
    269.67 ± 35%      -1.9%     264.67 ± 32%     -17.9%     221.50 ± 42%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
     32.00 ± 51%     -16.1%      26.83 ± 39%     +44.3%      46.17 ± 86%  interrupts.CPU13.RES:Rescheduling_interrupts
     22.50 ± 60%     -14.1%      19.33 ± 28%      -0.7%      22.33 ± 22%  interrupts.CPU13.TLB:TLB_shootdowns
      1232          +116.3%       2665 ± 16%    +101.1%       2477 ± 17%  interrupts.CPU130.CAL:Function_call_interrupts
      0.00       +8.3e+101%       0.83 ±223%    -100.0%       0.00        interrupts.CPU130.IWI:IRQ_work_interrupts
    602189            -0.7%     598113            -0.3%     600496        interrupts.CPU130.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU130.MCP:Machine_check_polls
    233.50 ± 35%      +7.3%     250.50 ± 31%     +34.0%     312.83 ± 36%  interrupts.CPU130.NMI:Non-maskable_interrupts
    233.50 ± 35%      +7.3%     250.50 ± 31%     +34.0%     312.83 ± 36%  interrupts.CPU130.PMI:Performance_monitoring_interrupts
      9.33 ± 34%      +8.9%      10.17 ± 49%    +205.4%      28.50 ±148%  interrupts.CPU130.RES:Rescheduling_interrupts
      9.67 ± 22%      -3.4%       9.33 ± 15%      -5.2%       9.17 ± 33%  interrupts.CPU130.TLB:TLB_shootdowns
      1215          +122.0%       2697 ± 24%    +114.6%       2608 ± 27%  interrupts.CPU131.CAL:Function_call_interrupts
    602190            -0.6%     598365            -0.2%     600784        interrupts.CPU131.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU131.MCP:Machine_check_polls
    224.33 ± 29%      -1.7%     220.50 ± 33%     +12.6%     252.50 ± 33%  interrupts.CPU131.NMI:Non-maskable_interrupts
    224.33 ± 29%      -1.7%     220.50 ± 33%     +12.6%     252.50 ± 33%  interrupts.CPU131.PMI:Performance_monitoring_interrupts
     10.00 ± 51%     -31.7%       6.83 ± 41%     +48.3%      14.83 ±100%  interrupts.CPU131.RES:Rescheduling_interrupts
      8.67 ± 10%     +21.2%      10.50 ± 20%     +28.8%      11.17 ± 58%  interrupts.CPU131.TLB:TLB_shootdowns
      1227          +115.6%       2646 ± 16%    +104.5%       2508 ± 14%  interrupts.CPU132.CAL:Function_call_interrupts
    601945            -0.7%     597785            -0.2%     600719        interrupts.CPU132.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU132.MCP:Machine_check_polls
    290.50 ± 32%     -32.6%     195.67 ±  3%      +9.8%     319.00 ± 29%  interrupts.CPU132.NMI:Non-maskable_interrupts
    290.50 ± 32%     -32.6%     195.67 ±  3%      +9.8%     319.00 ± 29%  interrupts.CPU132.PMI:Performance_monitoring_interrupts
     10.83 ± 66%      +7.7%      11.67 ± 77%     +15.4%      12.50 ± 50%  interrupts.CPU132.RES:Rescheduling_interrupts
      9.50 ± 20%     +36.8%      13.00 ± 54%     +26.3%      12.00 ± 15%  interrupts.CPU132.TLB:TLB_shootdowns
      1230 ±  2%    +170.6%       3328 ± 46%    +102.5%       2490 ± 15%  interrupts.CPU133.CAL:Function_call_interrupts
    601988            -0.7%     597533            -0.3%     600333        interrupts.CPU133.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU133.MCP:Machine_check_polls
    259.50 ± 33%     -21.0%     205.00 ± 13%      -4.1%     248.83 ± 32%  interrupts.CPU133.NMI:Non-maskable_interrupts
    259.50 ± 33%     -21.0%     205.00 ± 13%      -4.1%     248.83 ± 32%  interrupts.CPU133.PMI:Performance_monitoring_interrupts
      7.17 ± 56%     +30.2%       9.33 ± 34%     +65.1%      11.83 ± 26%  interrupts.CPU133.RES:Rescheduling_interrupts
      9.83 ± 19%     -16.9%       8.17 ± 28%     -11.9%       8.67 ± 23%  interrupts.CPU133.TLB:TLB_shootdowns
      1223          +112.6%       2599 ± 18%     +99.4%       2438 ± 16%  interrupts.CPU134.CAL:Function_call_interrupts
    602217            -0.3%     600281            -0.3%     600576        interrupts.CPU134.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU134.MCP:Machine_check_polls
    228.83 ± 35%     -26.1%     169.17 ±  2%      -1.0%     226.50 ± 28%  interrupts.CPU134.NMI:Non-maskable_interrupts
    228.83 ± 35%     -26.1%     169.17 ±  2%      -1.0%     226.50 ± 28%  interrupts.CPU134.PMI:Performance_monitoring_interrupts
      8.00 ± 47%     +31.2%      10.50 ± 26%     +16.7%       9.33 ± 73%  interrupts.CPU134.RES:Rescheduling_interrupts
      9.83 ± 30%     +23.7%      12.17 ± 30%      +3.4%      10.17 ± 29%  interrupts.CPU134.TLB:TLB_shootdowns
      1237 ±  3%    +110.1%       2599 ± 18%     +97.2%       2440 ± 15%  interrupts.CPU135.CAL:Function_call_interrupts
    602202            -0.4%     599605            -0.2%     600712        interrupts.CPU135.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU135.MCP:Machine_check_polls
    203.50 ± 33%      -3.3%     196.83 ± 33%      -6.4%     190.50 ± 30%  interrupts.CPU135.NMI:Non-maskable_interrupts
    203.50 ± 33%      -3.3%     196.83 ± 33%      -6.4%     190.50 ± 30%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
     13.67 ± 37%     -23.2%      10.50 ± 49%     -12.2%      12.00 ± 64%  interrupts.CPU135.RES:Rescheduling_interrupts
     11.17 ± 53%      -4.5%      10.67 ± 34%     -35.8%       7.17 ±  9%  interrupts.CPU135.TLB:TLB_shootdowns
      1251 ±  4%    +108.7%       2611 ± 18%     +94.2%       2428 ± 15%  interrupts.CPU136.CAL:Function_call_interrupts
    602075            -0.8%     597304            -0.3%     600194        interrupts.CPU136.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU136.MCP:Machine_check_polls
    226.50 ± 29%     +19.9%     271.50 ± 43%     +30.5%     295.50 ± 28%  interrupts.CPU136.NMI:Non-maskable_interrupts
    226.50 ± 29%     +19.9%     271.50 ± 43%     +30.5%     295.50 ± 28%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
     12.83 ± 47%      +2.6%      13.17 ± 27%     -37.7%       8.00 ± 28%  interrupts.CPU136.RES:Rescheduling_interrupts
     11.00 ± 65%      -4.5%      10.50 ± 18%     -18.2%       9.00 ± 40%  interrupts.CPU136.TLB:TLB_shootdowns
      1256 ±  4%    +106.0%       2588 ± 18%     +93.5%       2431 ± 15%  interrupts.CPU137.CAL:Function_call_interrupts
      0.00          -100.0%       0.00         +1e+102%       1.00 ±152%  interrupts.CPU137.IWI:IRQ_work_interrupts
    601958            -1.1%     595229            -0.6%     598285        interrupts.CPU137.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU137.MCP:Machine_check_polls
    324.67 ± 26%     -39.9%     195.17 ±  3%      -6.4%     303.83 ± 29%  interrupts.CPU137.NMI:Non-maskable_interrupts
    324.67 ± 26%     -39.9%     195.17 ±  3%      -6.4%     303.83 ± 29%  interrupts.CPU137.PMI:Performance_monitoring_interrupts
     12.50 ± 85%     -37.3%       7.83 ± 28%      +4.0%      13.00 ± 89%  interrupts.CPU137.RES:Rescheduling_interrupts
     22.17 ±153%     -57.1%       9.50 ± 20%     -64.7%       7.83 ± 24%  interrupts.CPU137.TLB:TLB_shootdowns
      1227          +118.9%       2685 ± 14%    +106.5%       2533 ± 17%  interrupts.CPU138.CAL:Function_call_interrupts
      0.00         +5e+101%       0.50 ±223%    -100.0%       0.00        interrupts.CPU138.IWI:IRQ_work_interrupts
    602361            -1.6%     592439 ±  2%      -0.3%     600582        interrupts.CPU138.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU138.MCP:Machine_check_polls
    264.67 ± 35%     -21.2%     208.67 ± 10%     +24.2%     328.67 ± 29%  interrupts.CPU138.NMI:Non-maskable_interrupts
    264.67 ± 35%     -21.2%     208.67 ± 10%     +24.2%     328.67 ± 29%  interrupts.CPU138.PMI:Performance_monitoring_interrupts
      9.17 ± 22%     +89.1%      17.33 ±104%     +56.4%      14.33 ± 76%  interrupts.CPU138.RES:Rescheduling_interrupts
     11.33 ± 25%     +32.4%      15.00 ± 75%      +7.4%      12.17 ± 36%  interrupts.CPU138.TLB:TLB_shootdowns
      1234          +118.7%       2699 ± 15%     +96.7%       2427 ± 15%  interrupts.CPU139.CAL:Function_call_interrupts
    602047            -2.3%     588028 ±  3%      -0.3%     600018        interrupts.CPU139.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU139.MCP:Machine_check_polls
    237.83 ± 30%     -15.8%     200.17 ±  4%      +9.6%     260.67 ± 33%  interrupts.CPU139.NMI:Non-maskable_interrupts
    237.83 ± 30%     -15.8%     200.17 ±  4%      +9.6%     260.67 ± 33%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
     12.83 ± 51%      +9.1%      14.00 ±112%     -19.5%      10.33 ± 49%  interrupts.CPU139.RES:Rescheduling_interrupts
      7.67 ±  6%    +115.2%      16.50 ±102%     +37.0%      10.50 ± 32%  interrupts.CPU139.TLB:TLB_shootdowns
      1193 ± 41%    +408.2%       6067 ± 79%    +712.8%       9703 ± 93%  interrupts.CPU14.34:IR-PCI-MSI.2621443-edge.eth0-TxRx-2
      2165 ± 70%     +67.2%       3621 ± 47%     +41.8%       3070 ± 19%  interrupts.CPU14.CAL:Function_call_interrupts
    602237            -0.3%     600705            -0.2%     601245        interrupts.CPU14.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU14.MCP:Machine_check_polls
    261.67 ± 30%      -2.3%     255.67 ± 30%     -15.2%     221.83 ± 33%  interrupts.CPU14.NMI:Non-maskable_interrupts
    261.67 ± 30%      -2.3%     255.67 ± 30%     -15.2%     221.83 ± 33%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    115.33 ±125%     -25.1%      86.33 ± 30%     -17.2%      95.50 ± 46%  interrupts.CPU14.RES:Rescheduling_interrupts
     62.00 ± 25%      +6.2%      65.83 ± 32%     +16.9%      72.50 ± 14%  interrupts.CPU14.TLB:TLB_shootdowns
      1275 ±  9%    +105.5%       2620 ± 17%    +148.8%       3173 ± 60%  interrupts.CPU140.CAL:Function_call_interrupts
    602203            -1.1%     595829            -0.2%     600792        interrupts.CPU140.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU140.MCP:Machine_check_polls
    282.17 ± 36%     -27.0%     206.00 ±  4%     -24.9%     211.83 ±  6%  interrupts.CPU140.NMI:Non-maskable_interrupts
    282.17 ± 36%     -27.0%     206.00 ±  4%     -24.9%     211.83 ±  6%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
     13.67 ± 67%     -35.4%       8.83 ±110%    +535.4%      86.83 ±199%  interrupts.CPU140.RES:Rescheduling_interrupts
     15.33 ± 75%     -12.0%      13.50 ± 74%      +4.3%      16.00 ±120%  interrupts.CPU140.TLB:TLB_shootdowns
      1241 ±  3%    +110.4%       2612 ± 18%    +104.1%       2533 ± 23%  interrupts.CPU141.CAL:Function_call_interrupts
    601885            -1.1%     595478            -0.3%     600321        interrupts.CPU141.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU141.MCP:Machine_check_polls
    312.50 ± 31%     -21.8%     244.50 ± 34%     -12.7%     272.83 ± 35%  interrupts.CPU141.NMI:Non-maskable_interrupts
    312.50 ± 31%     -21.8%     244.50 ± 34%     -12.7%     272.83 ± 35%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
     12.33 ± 43%      -1.4%      12.17 ± 69%     +14.9%      14.17 ±129%  interrupts.CPU141.RES:Rescheduling_interrupts
      8.67 ± 28%     +17.3%      10.17 ± 37%      +0.0%       8.67 ± 23%  interrupts.CPU141.TLB:TLB_shootdowns
      1267 ±  7%    +106.7%       2619 ± 17%     +91.9%       2431 ± 15%  interrupts.CPU142.CAL:Function_call_interrupts
    602153            -1.0%     596379            -0.3%     600122        interrupts.CPU142.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU142.MCP:Machine_check_polls
    245.50 ± 31%      -0.7%     243.67 ± 34%     +12.6%     276.33 ± 35%  interrupts.CPU142.NMI:Non-maskable_interrupts
    245.50 ± 31%      -0.7%     243.67 ± 34%     +12.6%     276.33 ± 35%  interrupts.CPU142.PMI:Performance_monitoring_interrupts
     14.00 ± 67%      +3.6%      14.50 ± 87%     -27.4%      10.17 ± 33%  interrupts.CPU142.RES:Rescheduling_interrupts
      9.17 ± 23%     +49.1%      13.67 ± 33%     +30.9%      12.00 ± 32%  interrupts.CPU142.TLB:TLB_shootdowns
      1251 ±  7%    +110.5%       2634 ± 17%     +94.1%       2429 ± 15%  interrupts.CPU143.CAL:Function_call_interrupts
    602168            -1.1%     595682            -0.3%     600237        interrupts.CPU143.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU143.MCP:Machine_check_polls
    328.83 ± 36%     -25.9%     243.67 ± 32%      -6.4%     307.83 ± 32%  interrupts.CPU143.NMI:Non-maskable_interrupts
    328.83 ± 36%     -25.9%     243.67 ± 32%      -6.4%     307.83 ± 32%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
     10.67 ±123%     +53.1%      16.33 ± 33%     -18.8%       8.67 ± 45%  interrupts.CPU143.RES:Rescheduling_interrupts
      8.00 ± 16%     +18.8%       9.50 ± 31%     +29.2%      10.33 ± 24%  interrupts.CPU143.TLB:TLB_shootdowns
      1228          +113.7%       2624 ± 18%     +98.7%       2440 ± 15%  interrupts.CPU144.CAL:Function_call_interrupts
    602191            -1.0%     595897            -0.3%     600147        interrupts.CPU144.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU144.MCP:Machine_check_polls
    247.83 ± 33%     -15.9%     208.50 ±  4%     +10.5%     273.83 ± 36%  interrupts.CPU144.NMI:Non-maskable_interrupts
    247.83 ± 33%     -15.9%     208.50 ±  4%     +10.5%     273.83 ± 36%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
      9.67 ± 33%     +43.1%      13.83 ± 49%     +39.7%      13.50 ± 45%  interrupts.CPU144.RES:Rescheduling_interrupts
     11.17 ± 23%     +35.8%      15.17 ± 47%     +14.9%      12.83 ± 43%  interrupts.CPU144.TLB:TLB_shootdowns
      1218          +115.8%       2630 ± 19%     +98.4%       2417 ± 15%  interrupts.CPU145.CAL:Function_call_interrupts
    602106            -1.1%     595475            -0.3%     600386        interrupts.CPU145.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU145.MCP:Machine_check_polls
    253.67 ± 37%      -6.0%     238.33 ± 33%      +6.1%     269.17 ± 32%  interrupts.CPU145.NMI:Non-maskable_interrupts
    253.67 ± 37%      -6.0%     238.33 ± 33%      +6.1%     269.17 ± 32%  interrupts.CPU145.PMI:Performance_monitoring_interrupts
     11.50 ± 56%     +46.4%      16.83 ± 61%      -2.9%      11.17 ± 57%  interrupts.CPU145.RES:Rescheduling_interrupts
      9.83 ± 19%      +1.7%      10.00 ± 47%      -8.5%       9.00 ± 11%  interrupts.CPU145.TLB:TLB_shootdowns
      1344 ± 15%     +87.8%       2525 ± 22%     +80.6%       2427 ± 15%  interrupts.CPU146.CAL:Function_call_interrupts
    602131            -0.5%     599070            -0.2%     600910        interrupts.CPU146.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU146.MCP:Machine_check_polls
    201.67 ± 30%     -16.9%     167.67 ±  3%      +9.7%     221.17 ± 32%  interrupts.CPU146.NMI:Non-maskable_interrupts
    201.67 ± 30%     -16.9%     167.67 ±  3%      +9.7%     221.17 ± 32%  interrupts.CPU146.PMI:Performance_monitoring_interrupts
      6.00 ± 38%     +75.0%      10.50 ± 63%     +52.8%       9.17 ± 46%  interrupts.CPU146.RES:Rescheduling_interrupts
      9.67 ± 22%     +19.0%      11.50 ± 26%     +25.9%      12.17 ± 40%  interrupts.CPU146.TLB:TLB_shootdowns
      1228 ±  2%    +110.8%       2589 ± 18%     +99.2%       2445 ± 15%  interrupts.CPU147.CAL:Function_call_interrupts
    602053            -0.5%     599004            -0.2%     601120        interrupts.CPU147.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU147.MCP:Machine_check_polls
    199.33 ± 33%     -16.5%     166.50 ±  3%     +12.9%     225.00 ± 33%  interrupts.CPU147.NMI:Non-maskable_interrupts
    199.33 ± 33%     -16.5%     166.50 ±  3%     +12.9%     225.00 ± 33%  interrupts.CPU147.PMI:Performance_monitoring_interrupts
      8.50 ± 74%     -15.7%       7.17 ± 37%      -9.8%       7.67 ± 43%  interrupts.CPU147.RES:Rescheduling_interrupts
      9.00 ± 19%      -3.7%       8.67 ± 17%      +3.7%       9.33 ± 35%  interrupts.CPU147.TLB:TLB_shootdowns
      1226 ±  2%    +111.1%       2589 ± 18%    +103.0%       2489 ± 15%  interrupts.CPU148.CAL:Function_call_interrupts
    601616            -1.3%     594055            -0.2%     600443        interrupts.CPU148.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU148.MCP:Machine_check_polls
    297.67 ± 32%     -21.2%     234.50 ± 32%      -1.3%     293.67 ± 35%  interrupts.CPU148.NMI:Non-maskable_interrupts
    297.67 ± 32%     -21.2%     234.50 ± 32%      -1.3%     293.67 ± 35%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
     12.50 ± 64%     -50.7%       6.17 ± 32%     -22.7%       9.67 ± 41%  interrupts.CPU148.RES:Rescheduling_interrupts
     10.83 ± 24%     -15.4%       9.17 ± 18%     -12.3%       9.50 ± 16%  interrupts.CPU148.TLB:TLB_shootdowns
      1230          +128.9%       2816 ± 20%     +96.6%       2418 ± 15%  interrupts.CPU149.CAL:Function_call_interrupts
    602249            -0.8%     597632            -0.3%     600625        interrupts.CPU149.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU149.MCP:Machine_check_polls
    264.17 ± 36%     +26.6%     334.33 ± 90%      -3.3%     255.33 ± 34%  interrupts.CPU149.NMI:Non-maskable_interrupts
    264.17 ± 36%     +26.6%     334.33 ± 90%      -3.3%     255.33 ± 34%  interrupts.CPU149.PMI:Performance_monitoring_interrupts
      9.00 ± 41%     -11.1%       8.00 ± 53%     -14.8%       7.67 ± 47%  interrupts.CPU149.RES:Rescheduling_interrupts
      9.17 ± 37%     +20.0%      11.00 ± 86%      +0.0%       9.17 ± 26%  interrupts.CPU149.TLB:TLB_shootdowns
      2739 ± 77%     +51.8%       4158 ±146%     +63.4%       4476 ± 99%  interrupts.CPU15.35:IR-PCI-MSI.2621444-edge.eth0-TxRx-3
      1591 ± 33%     +89.2%       3011 ± 32%     +91.9%       3054 ± 35%  interrupts.CPU15.CAL:Function_call_interrupts
    602448            -0.3%     600853            -0.2%     601476        interrupts.CPU15.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU15.MCP:Machine_check_polls
    299.67 ± 29%     -21.0%     236.83 ± 33%     -21.7%     234.67 ± 31%  interrupts.CPU15.NMI:Non-maskable_interrupts
    299.67 ± 29%     -21.0%     236.83 ± 33%     -21.7%     234.67 ± 31%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
     46.67 ±118%     -48.6%      24.00 ± 43%     -31.1%      32.17 ± 30%  interrupts.CPU15.RES:Rescheduling_interrupts
     23.17 ± 25%      -7.2%      21.50 ± 26%     +10.8%      25.67 ± 15%  interrupts.CPU15.TLB:TLB_shootdowns
      1251 ±  4%    +106.6%       2585 ± 18%     +97.6%       2472 ± 15%  interrupts.CPU150.CAL:Function_call_interrupts
    601947            -0.5%     598885            -0.3%     600357        interrupts.CPU150.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU150.MCP:Machine_check_polls
    242.33 ± 31%      -1.2%     239.33 ± 35%      -6.0%     227.83 ± 36%  interrupts.CPU150.NMI:Non-maskable_interrupts
    242.33 ± 31%      -1.2%     239.33 ± 35%      -6.0%     227.83 ± 36%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
     13.33 ± 87%     -51.2%       6.50 ± 52%      +2.5%      13.67 ±107%  interrupts.CPU150.RES:Rescheduling_interrupts
     12.33 ± 46%      -8.1%      11.33 ± 32%     +50.0%      18.50 ±115%  interrupts.CPU150.TLB:TLB_shootdowns
      1213          +114.0%       2596 ± 18%    +100.2%       2430 ± 16%  interrupts.CPU151.CAL:Function_call_interrupts
    602060            -0.5%     599168            -0.2%     600863        interrupts.CPU151.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU151.MCP:Machine_check_polls
    277.33 ± 28%     -25.8%     205.83 ± 35%     -25.6%     206.33 ± 32%  interrupts.CPU151.NMI:Non-maskable_interrupts
    277.33 ± 28%     -25.8%     205.83 ± 35%     -25.6%     206.33 ± 32%  interrupts.CPU151.PMI:Performance_monitoring_interrupts
      7.00 ± 26%     +69.0%      11.83 ± 39%     +71.4%      12.00 ± 44%  interrupts.CPU151.RES:Rescheduling_interrupts
      8.17 ± 16%     +12.2%       9.17 ± 21%      -4.1%       7.83 ± 22%  interrupts.CPU151.TLB:TLB_shootdowns
      1263 ±  7%    +104.5%       2584 ± 18%     +92.6%       2433 ± 15%  interrupts.CPU152.CAL:Function_call_interrupts
    602267            -0.4%     599848            -0.3%     600498        interrupts.CPU152.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU152.MCP:Machine_check_polls
    230.00 ± 36%     -25.4%     171.50 ±  2%      -1.9%     225.67 ± 34%  interrupts.CPU152.NMI:Non-maskable_interrupts
    230.00 ± 36%     -25.4%     171.50 ±  2%      -1.9%     225.67 ± 34%  interrupts.CPU152.PMI:Performance_monitoring_interrupts
     13.00 ± 70%     -42.3%       7.50 ± 30%     -30.8%       9.00 ± 65%  interrupts.CPU152.RES:Rescheduling_interrupts
     10.00 ± 19%      -6.7%       9.33 ± 24%     +16.7%      11.67 ± 27%  interrupts.CPU152.TLB:TLB_shootdowns
      1222          +112.6%       2598 ± 18%     +99.0%       2431 ± 15%  interrupts.CPU153.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +6.7e+101%       0.67 ±223%  interrupts.CPU153.IWI:IRQ_work_interrupts
    602137            -0.3%     600629            -0.2%     600732        interrupts.CPU153.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU153.MCP:Machine_check_polls
    257.83 ± 32%     -24.2%     195.50 ± 32%      -7.6%     238.17 ± 31%  interrupts.CPU153.NMI:Non-maskable_interrupts
    257.83 ± 32%     -24.2%     195.50 ± 32%      -7.6%     238.17 ± 31%  interrupts.CPU153.PMI:Performance_monitoring_interrupts
     10.33 ± 33%      +6.5%      11.00 ± 27%      +4.8%      10.83 ± 28%  interrupts.CPU153.RES:Rescheduling_interrupts
      9.50 ± 25%      -7.0%       8.83 ± 23%     -17.5%       7.83 ± 13%  interrupts.CPU153.TLB:TLB_shootdowns
      1223          +112.3%       2597 ± 19%     +98.2%       2425 ± 16%  interrupts.CPU154.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +3.3e+101%       0.33 ±223%  interrupts.CPU154.IWI:IRQ_work_interrupts
    602185            -1.5%     593208            -0.6%     598838        interrupts.CPU154.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU154.MCP:Machine_check_polls
    248.50 ± 31%     +14.9%     285.50 ± 29%     +54.7%     384.33 ± 40%  interrupts.CPU154.NMI:Non-maskable_interrupts
    248.50 ± 31%     +14.9%     285.50 ± 29%     +54.7%     384.33 ± 40%  interrupts.CPU154.PMI:Performance_monitoring_interrupts
      7.00 ± 39%    +107.1%      14.50 ± 86%     +71.4%      12.00 ± 63%  interrupts.CPU154.RES:Rescheduling_interrupts
      9.17 ± 31%      +3.6%       9.50 ± 27%      -1.8%       9.00 ± 19%  interrupts.CPU154.TLB:TLB_shootdowns
      1210          +124.7%       2720 ± 15%    +119.4%       2655 ± 20%  interrupts.CPU155.CAL:Function_call_interrupts
    602074            -2.1%     589704 ±  3%      -0.3%     600164        interrupts.CPU155.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU155.MCP:Machine_check_polls
    276.17 ± 36%     +22.0%     337.00 ± 44%      +0.0%     276.17 ± 35%  interrupts.CPU155.NMI:Non-maskable_interrupts
    276.17 ± 36%     +22.0%     337.00 ± 44%      +0.0%     276.17 ± 35%  interrupts.CPU155.PMI:Performance_monitoring_interrupts
      7.50 ± 22%     +40.0%      10.50 ± 68%     +48.9%      11.17 ± 93%  interrupts.CPU155.RES:Rescheduling_interrupts
      8.33 ± 17%      +4.0%       8.67 ± 12%     +80.0%      15.00 ± 64%  interrupts.CPU155.TLB:TLB_shootdowns
      1237          +110.0%       2599 ± 18%     +87.3%       2317 ± 20%  interrupts.CPU156.CAL:Function_call_interrupts
    602205            -0.6%     598617            -0.2%     601024        interrupts.CPU156.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU156.MCP:Machine_check_polls
    252.50 ± 35%      -1.3%     249.33 ± 37%     -26.7%     185.17 ±  3%  interrupts.CPU156.NMI:Non-maskable_interrupts
    252.50 ± 35%      -1.3%     249.33 ± 37%     -26.7%     185.17 ±  3%  interrupts.CPU156.PMI:Performance_monitoring_interrupts
      9.83 ± 25%     -18.6%       8.00 ± 59%     -22.0%       7.67 ± 24%  interrupts.CPU156.RES:Rescheduling_interrupts
     11.50 ± 16%      -7.2%      10.67 ± 20%      +8.7%      12.50 ± 37%  interrupts.CPU156.TLB:TLB_shootdowns
      1218          +112.2%       2585 ± 18%    +102.4%       2465 ± 16%  interrupts.CPU157.CAL:Function_call_interrupts
    602232            -0.6%     598766            -0.2%     600865        interrupts.CPU157.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU157.MCP:Machine_check_polls
    246.50 ± 34%     -12.6%     215.50 ± 31%      +0.0%     246.50 ± 33%  interrupts.CPU157.NMI:Non-maskable_interrupts
    246.50 ± 34%     -12.6%     215.50 ± 31%      +0.0%     246.50 ± 33%  interrupts.CPU157.PMI:Performance_monitoring_interrupts
     11.83 ± 23%     -14.1%      10.17 ± 80%     +45.1%      17.17 ± 30%  interrupts.CPU157.RES:Rescheduling_interrupts
      9.33 ± 19%      -5.4%       8.83 ± 18%     +46.4%      13.67 ± 55%  interrupts.CPU157.TLB:TLB_shootdowns
      1301 ±  9%     +98.8%       2587 ± 18%     +92.9%       2511 ± 14%  interrupts.CPU158.CAL:Function_call_interrupts
    602076            -1.0%     595910            -0.3%     600428        interrupts.CPU158.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU158.MCP:Machine_check_polls
    265.50 ± 33%     -14.9%     226.00 ± 32%      -1.4%     261.67 ± 37%  interrupts.CPU158.NMI:Non-maskable_interrupts
    265.50 ± 33%     -14.9%     226.00 ± 32%      -1.4%     261.67 ± 37%  interrupts.CPU158.PMI:Performance_monitoring_interrupts
     10.83 ± 52%     -40.0%       6.50 ± 52%     +92.3%      20.83 ±102%  interrupts.CPU158.RES:Rescheduling_interrupts
     11.33 ± 41%     +11.8%      12.67 ± 29%      +4.4%      11.83 ± 34%  interrupts.CPU158.TLB:TLB_shootdowns
      1349 ± 13%     +92.3%       2594 ± 18%     +86.1%       2511 ± 15%  interrupts.CPU159.CAL:Function_call_interrupts
    602047            -0.8%     597003            -0.3%     600350        interrupts.CPU159.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU159.MCP:Machine_check_polls
    235.67 ± 31%      -1.4%     232.33 ± 32%      -2.3%     230.33 ± 31%  interrupts.CPU159.NMI:Non-maskable_interrupts
    235.67 ± 31%      -1.4%     232.33 ± 32%      -2.3%     230.33 ± 31%  interrupts.CPU159.PMI:Performance_monitoring_interrupts
     20.00 ± 99%     -52.5%       9.50 ± 46%     -14.2%      17.17 ±126%  interrupts.CPU159.RES:Rescheduling_interrupts
     10.00 ± 19%      -8.3%       9.17 ± 26%     -15.0%       8.50 ± 25%  interrupts.CPU159.TLB:TLB_shootdowns
     40.67 ±  4%      +0.0%      40.67 ±  4%      +0.0%      40.67 ±  4%  interrupts.CPU16.4:IR-IO-APIC.4-edge.ttyS0
      1732 ± 27%    +169.9%       4675 ± 63%     +61.8%       2803 ± 18%  interrupts.CPU16.CAL:Function_call_interrupts
    602232            -0.3%     600552            -0.2%     601233        interrupts.CPU16.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU16.MCP:Machine_check_polls
    198.50 ± 32%     +27.1%     252.33 ± 33%     +27.6%     253.33 ± 32%  interrupts.CPU16.NMI:Non-maskable_interrupts
    198.50 ± 32%     +27.1%     252.33 ± 33%     +27.6%     253.33 ± 32%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
     61.50 ± 83%    +245.0%     212.17 ±165%      +3.3%      63.50 ± 41%  interrupts.CPU16.RES:Rescheduling_interrupts
     64.33 ± 18%     +10.6%      71.17 ± 17%      -2.6%      62.67 ± 25%  interrupts.CPU16.TLB:TLB_shootdowns
      1340 ± 14%     +86.6%       2501 ± 23%     +80.7%       2422 ± 15%  interrupts.CPU160.CAL:Function_call_interrupts
    602075            -0.9%     596749            -0.3%     600310        interrupts.CPU160.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU160.MCP:Machine_check_polls
    295.00 ± 34%      -0.7%     292.83 ± 35%      -8.9%     268.67 ± 31%  interrupts.CPU160.NMI:Non-maskable_interrupts
    295.00 ± 34%      -0.7%     292.83 ± 35%      -8.9%     268.67 ± 31%  interrupts.CPU160.PMI:Performance_monitoring_interrupts
     21.33 ± 94%     -43.0%      12.17 ± 49%     -76.6%       5.00 ± 54%  interrupts.CPU160.RES:Rescheduling_interrupts
     11.00 ± 22%     +18.2%      13.00 ± 37%     -15.2%       9.33 ± 24%  interrupts.CPU160.TLB:TLB_shootdowns
      1227          +111.4%       2593 ± 18%     +98.5%       2436 ± 17%  interrupts.CPU161.CAL:Function_call_interrupts
    601995            -1.2%     594874            -0.3%     599892        interrupts.CPU161.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU161.MCP:Machine_check_polls
    266.00 ± 35%     +22.7%     326.50 ± 28%      -0.2%     265.50 ± 37%  interrupts.CPU161.NMI:Non-maskable_interrupts
    266.00 ± 35%     +22.7%     326.50 ± 28%      -0.2%     265.50 ± 37%  interrupts.CPU161.PMI:Performance_monitoring_interrupts
      9.83 ± 18%     -10.2%       8.83 ± 49%     +18.6%      11.67 ± 45%  interrupts.CPU161.RES:Rescheduling_interrupts
      9.50 ± 19%     -12.3%       8.33 ± 21%     -10.5%       8.50 ± 22%  interrupts.CPU161.TLB:TLB_shootdowns
      1229          +112.0%       2605 ± 18%    +102.0%       2482 ± 15%  interrupts.CPU162.CAL:Function_call_interrupts
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        interrupts.CPU162.IWI:IRQ_work_interrupts
    602010            -1.9%     590357 ±  3%      -0.3%     600313        interrupts.CPU162.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU162.MCP:Machine_check_polls
    285.33 ± 45%      +5.8%     302.00 ± 36%     -23.1%     219.50 ± 29%  interrupts.CPU162.NMI:Non-maskable_interrupts
    285.33 ± 45%      +5.8%     302.00 ± 36%     -23.1%     219.50 ± 29%  interrupts.CPU162.PMI:Performance_monitoring_interrupts
     13.83 ± 45%     -33.7%       9.17 ± 78%     -36.1%       8.83 ± 26%  interrupts.CPU162.RES:Rescheduling_interrupts
     12.83 ± 34%     -22.1%      10.00 ± 28%     -14.3%      11.00 ± 29%  interrupts.CPU162.TLB:TLB_shootdowns
      1221          +112.0%       2589 ± 18%     +98.5%       2424 ± 16%  interrupts.CPU163.CAL:Function_call_interrupts
    601889            -0.9%     596531            -0.3%     600153        interrupts.CPU163.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU163.MCP:Machine_check_polls
    272.50 ± 32%     -27.3%     198.00 ±  3%      -8.1%     250.33 ± 36%  interrupts.CPU163.NMI:Non-maskable_interrupts
    272.50 ± 32%     -27.3%     198.00 ±  3%      -8.1%     250.33 ± 36%  interrupts.CPU163.PMI:Performance_monitoring_interrupts
      7.67 ± 41%     +37.0%      10.50 ± 43%     +19.6%       9.17 ± 43%  interrupts.CPU163.RES:Rescheduling_interrupts
     10.67 ± 56%     -21.9%       8.33 ± 20%      -7.8%       9.83 ± 29%  interrupts.CPU163.TLB:TLB_shootdowns
      1221          +112.4%       2594 ± 18%    +101.1%       2456 ± 19%  interrupts.CPU164.CAL:Function_call_interrupts
    602205            -1.1%     595400            -0.4%     599912        interrupts.CPU164.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU164.MCP:Machine_check_polls
    243.00 ± 30%      -1.7%     238.83 ± 35%     +27.0%     308.50 ± 34%  interrupts.CPU164.NMI:Non-maskable_interrupts
    243.00 ± 30%      -1.7%     238.83 ± 35%     +27.0%     308.50 ± 34%  interrupts.CPU164.PMI:Performance_monitoring_interrupts
      9.00 ± 39%      -5.6%       8.50 ± 47%     +55.6%      14.00 ± 65%  interrupts.CPU164.RES:Rescheduling_interrupts
     11.83 ± 26%      -5.6%      11.17 ± 26%     +45.1%      17.17 ± 41%  interrupts.CPU164.TLB:TLB_shootdowns
      1231 ±  2%    +111.9%       2608 ± 18%    +112.8%       2619 ± 16%  interrupts.CPU165.CAL:Function_call_interrupts
    602126            -1.1%     595486            -0.4%     599977        interrupts.CPU165.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU165.MCP:Machine_check_polls
    288.17 ± 35%      -3.5%     278.00 ± 35%      -4.4%     275.50 ± 35%  interrupts.CPU165.NMI:Non-maskable_interrupts
    288.17 ± 35%      -3.5%     278.00 ± 35%      -4.4%     275.50 ± 35%  interrupts.CPU165.PMI:Performance_monitoring_interrupts
      9.83 ± 48%     +33.9%      13.17 ± 53%     +76.3%      17.33 ±105%  interrupts.CPU165.RES:Rescheduling_interrupts
      9.33 ± 33%      +7.1%      10.00 ± 17%     +85.7%      17.33 ±125%  interrupts.CPU165.TLB:TLB_shootdowns
      1223          +118.9%       2678 ± 16%    +102.9%       2483 ± 14%  interrupts.CPU166.CAL:Function_call_interrupts
    602272            -0.9%     596950            -0.3%     600439        interrupts.CPU166.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU166.MCP:Machine_check_polls
    285.33 ± 41%     +31.4%     374.83 ± 60%      -4.4%     272.67 ± 37%  interrupts.CPU166.NMI:Non-maskable_interrupts
    285.33 ± 41%     +31.4%     374.83 ± 60%      -4.4%     272.67 ± 37%  interrupts.CPU166.PMI:Performance_monitoring_interrupts
      7.50 ± 29%    +255.6%      26.67 ±130%    +417.8%      38.83 ±147%  interrupts.CPU166.RES:Rescheduling_interrupts
     11.00 ± 46%     +18.2%      13.00 ± 52%      +1.5%      11.17 ± 33%  interrupts.CPU166.TLB:TLB_shootdowns
      1245 ±  5%    +108.6%       2598 ± 18%     +95.3%       2432 ± 15%  interrupts.CPU167.CAL:Function_call_interrupts
    602331            -0.8%     597240            -0.3%     600339        interrupts.CPU167.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU167.MCP:Machine_check_polls
    298.17 ± 42%     +30.0%     387.50 ± 22%     -33.1%     199.33 ±  4%  interrupts.CPU167.NMI:Non-maskable_interrupts
    298.17 ± 42%     +30.0%     387.50 ± 22%     -33.1%     199.33 ±  4%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
      9.33 ± 41%      -7.1%       8.67 ± 48%      +1.8%       9.50 ± 19%  interrupts.CPU167.RES:Rescheduling_interrupts
      7.83 ± 15%     +21.3%       9.50 ± 32%     +25.5%       9.83 ± 17%  interrupts.CPU167.TLB:TLB_shootdowns
      1214          +113.4%       2591 ± 18%    +100.4%       2434 ± 15%  interrupts.CPU168.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +3.3e+101%       0.33 ±223%  interrupts.CPU168.IWI:IRQ_work_interrupts
    602126            -0.6%     598806            -0.1%     601314        interrupts.CPU168.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU168.MCP:Machine_check_polls
    256.17 ± 51%     -24.3%     194.00 ± 32%    +266.5%     938.83 ±169%  interrupts.CPU168.NMI:Non-maskable_interrupts
    256.17 ± 51%     -24.3%     194.00 ± 32%    +266.5%     938.83 ±169%  interrupts.CPU168.PMI:Performance_monitoring_interrupts
      7.67 ± 27%     -19.6%       6.17 ± 25%     +30.4%      10.00 ± 50%  interrupts.CPU168.RES:Rescheduling_interrupts
     11.50 ± 53%     -23.2%       8.83 ± 17%     -18.8%       9.33 ± 23%  interrupts.CPU168.TLB:TLB_shootdowns
      1231 ±  2%    +110.3%       2588 ± 18%     +96.7%       2421 ± 15%  interrupts.CPU169.CAL:Function_call_interrupts
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU169.IWI:IRQ_work_interrupts
    601947            -0.5%     599033            -0.2%     600831        interrupts.CPU169.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU169.MCP:Machine_check_polls
    214.17 ± 43%     +23.2%     263.83 ± 33%     +25.4%     268.67 ± 38%  interrupts.CPU169.NMI:Non-maskable_interrupts
    214.17 ± 43%     +23.2%     263.83 ± 33%     +25.4%     268.67 ± 38%  interrupts.CPU169.PMI:Performance_monitoring_interrupts
     11.50 ± 57%     -50.7%       5.67 ± 34%     -33.3%       7.67 ± 32%  interrupts.CPU169.RES:Rescheduling_interrupts
      8.17 ± 21%      -4.1%       7.83 ± 11%     +61.2%      13.17 ± 81%  interrupts.CPU169.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.37:IR-PCI-MSI.3145729-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.3:IR-IO-APIC.3-edge
      2.50 ± 44%      +0.0%       2.50 ± 44%     -60.0%       1.00 ±141%  interrupts.CPU17.42:IR-PCI-MSI.512000-edge.ahci[0000:00:1f.2]
      1679 ± 20%     +98.8%       3338 ± 34%     +51.2%       2538 ± 15%  interrupts.CPU17.CAL:Function_call_interrupts
    602147            -0.3%     600239            -0.2%     601203        interrupts.CPU17.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU17.MCP:Machine_check_polls
    254.67 ± 34%     -18.7%     207.00 ± 28%     -23.6%     194.67 ± 29%  interrupts.CPU17.NMI:Non-maskable_interrupts
    254.67 ± 34%     -18.7%     207.00 ± 28%     -23.6%     194.67 ± 29%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
     54.67 ± 54%     -14.3%      46.83 ±142%     -51.8%      26.33 ± 39%  interrupts.CPU17.RES:Rescheduling_interrupts
     29.17 ± 47%     -12.6%      25.50 ± 27%     -24.6%      22.00 ± 36%  interrupts.CPU17.TLB:TLB_shootdowns
      1230          +119.1%       2696 ± 16%     +98.3%       2440 ± 15%  interrupts.CPU170.CAL:Function_call_interrupts
    602073            -0.9%     596424            -0.3%     600464        interrupts.CPU170.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU170.MCP:Machine_check_polls
    350.17 ± 28%     -23.8%     266.83 ± 33%      -3.3%     338.50 ± 28%  interrupts.CPU170.NMI:Non-maskable_interrupts
    350.17 ± 28%     -23.8%     266.83 ± 33%      -3.3%     338.50 ± 28%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
     13.67 ± 31%     +86.6%      25.50 ±137%      -8.5%      12.50 ± 52%  interrupts.CPU170.RES:Rescheduling_interrupts
      9.50 ± 13%     +17.5%      11.17 ± 23%     +35.1%      12.83 ± 37%  interrupts.CPU170.TLB:TLB_shootdowns
      1221          +121.5%       2704 ± 16%    +102.4%       2471 ± 15%  interrupts.CPU171.CAL:Function_call_interrupts
    601980            -1.4%     593418            -0.3%     599934        interrupts.CPU171.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU171.MCP:Machine_check_polls
    288.67 ± 34%    +110.4%     607.33 ± 66%     +12.2%     324.00 ± 34%  interrupts.CPU171.NMI:Non-maskable_interrupts
    288.67 ± 34%    +110.4%     607.33 ± 66%     +12.2%     324.00 ± 34%  interrupts.CPU171.PMI:Performance_monitoring_interrupts
      8.33 ± 52%    +150.0%      20.83 ± 91%      -4.0%       8.00 ± 51%  interrupts.CPU171.RES:Rescheduling_interrupts
      9.50 ± 14%    +521.1%      59.00 ±193%     -15.8%       8.00 ± 17%  interrupts.CPU171.TLB:TLB_shootdowns
      1216          +115.7%       2625 ± 17%    +127.1%       2764 ± 20%  interrupts.CPU172.CAL:Function_call_interrupts
    602073            -0.7%     597999            -0.2%     600753        interrupts.CPU172.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU172.MCP:Machine_check_polls
    263.00 ± 32%     +12.5%     295.83 ± 28%     -10.7%     234.83 ± 34%  interrupts.CPU172.NMI:Non-maskable_interrupts
    263.00 ± 32%     +12.5%     295.83 ± 28%     -10.7%     234.83 ± 34%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
      7.83 ± 37%     +66.0%      13.00 ± 44%     +72.3%      13.50 ± 42%  interrupts.CPU172.RES:Rescheduling_interrupts
      9.17 ± 26%     +29.1%      11.83 ± 15%     +20.0%      11.00 ± 21%  interrupts.CPU172.TLB:TLB_shootdowns
      1211          +113.2%       2583 ± 18%    +100.6%       2430 ± 15%  interrupts.CPU173.CAL:Function_call_interrupts
    602024            -0.5%     598850            -0.2%     600580        interrupts.CPU173.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU173.MCP:Machine_check_polls
    238.83 ± 34%      -0.3%     238.17 ± 36%      -1.7%     234.83 ± 36%  interrupts.CPU173.NMI:Non-maskable_interrupts
    238.83 ± 34%      -0.3%     238.17 ± 36%      -1.7%     234.83 ± 36%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
      7.50 ± 39%      +6.7%       8.00 ± 57%     +28.9%       9.67 ± 79%  interrupts.CPU173.RES:Rescheduling_interrupts
      7.50 ± 12%     +17.8%       8.83 ± 27%     +11.1%       8.33 ± 21%  interrupts.CPU173.TLB:TLB_shootdowns
      1227          +112.5%       2609 ± 18%    +104.1%       2506 ± 15%  interrupts.CPU174.CAL:Function_call_interrupts
    602074            -1.4%     593729 ±  2%      -0.3%     600359        interrupts.CPU174.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU174.MCP:Machine_check_polls
    312.67 ± 36%     -15.5%     264.33 ± 34%     -14.8%     266.50 ± 34%  interrupts.CPU174.NMI:Non-maskable_interrupts
    312.67 ± 36%     -15.5%     264.33 ± 34%     -14.8%     266.50 ± 34%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
      9.33 ± 47%      -8.9%       8.50 ± 53%     +17.9%      11.00 ± 32%  interrupts.CPU174.RES:Rescheduling_interrupts
     59.50 ±184%     -82.4%      10.50 ± 18%     -82.6%      10.33 ± 32%  interrupts.CPU174.TLB:TLB_shootdowns
      1221          +119.9%       2686 ± 24%    +127.5%       2779 ± 28%  interrupts.CPU175.CAL:Function_call_interrupts
    602043            -1.0%     595730            -0.3%     600413        interrupts.CPU175.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU175.MCP:Machine_check_polls
    318.67 ± 35%     -16.0%     267.67 ± 36%     -16.5%     266.00 ± 35%  interrupts.CPU175.NMI:Non-maskable_interrupts
    318.67 ± 35%     -16.0%     267.67 ± 36%     -16.5%     266.00 ± 35%  interrupts.CPU175.PMI:Performance_monitoring_interrupts
     10.83 ± 44%     +21.5%      13.17 ± 89%      -6.2%      10.17 ± 44%  interrupts.CPU175.RES:Rescheduling_interrupts
     10.33 ± 45%      -9.7%       9.33 ± 37%      -1.6%      10.17 ± 13%  interrupts.CPU175.TLB:TLB_shootdowns
      1251 ±  4%    +107.4%       2595 ± 18%    +101.3%       2518 ± 15%  interrupts.CPU176.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +6.7e+101%       0.67 ±223%  interrupts.CPU176.IWI:IRQ_work_interrupts
    602126            -1.2%     594849            -0.4%     600017        interrupts.CPU176.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU176.MCP:Machine_check_polls
    286.33 ± 31%     +86.1%     532.83 ± 72%     +53.3%     439.00 ± 63%  interrupts.CPU176.NMI:Non-maskable_interrupts
    286.33 ± 31%     +86.1%     532.83 ± 72%     +53.3%     439.00 ± 63%  interrupts.CPU176.PMI:Performance_monitoring_interrupts
     10.83 ± 46%     -30.8%       7.50 ± 44%     -16.9%       9.00 ± 27%  interrupts.CPU176.RES:Rescheduling_interrupts
     12.67 ± 50%      -7.9%      11.67 ± 27%     -39.5%       7.67 ± 26%  interrupts.CPU176.TLB:TLB_shootdowns
      1226          +126.0%       2772 ± 24%     +97.6%       2423 ± 15%  interrupts.CPU177.CAL:Function_call_interrupts
    602013            -1.1%     595149            -0.3%     600316        interrupts.CPU177.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU177.MCP:Machine_check_polls
    272.17 ± 33%     +36.6%     371.83 ± 22%      +0.7%     274.17 ± 36%  interrupts.CPU177.NMI:Non-maskable_interrupts
    272.17 ± 33%     +36.6%     371.83 ± 22%      +0.7%     274.17 ± 36%  interrupts.CPU177.PMI:Performance_monitoring_interrupts
      9.83 ± 30%     +81.4%      17.83 ± 98%     -11.9%       8.67 ± 30%  interrupts.CPU177.RES:Rescheduling_interrupts
      8.50 ± 11%     +43.1%      12.17 ± 42%      -2.0%       8.33 ± 16%  interrupts.CPU177.TLB:TLB_shootdowns
      1225 ±  2%    +116.1%       2647 ± 17%     +85.8%       2276 ± 24%  interrupts.CPU178.CAL:Function_call_interrupts
    602102            -0.9%     596536            -0.3%     600136        interrupts.CPU178.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU178.MCP:Machine_check_polls
    285.50 ± 38%     -19.7%     229.17 ± 31%     -21.2%     224.83 ± 33%  interrupts.CPU178.NMI:Non-maskable_interrupts
    285.50 ± 38%     -19.7%     229.17 ± 31%     -21.2%     224.83 ± 33%  interrupts.CPU178.PMI:Performance_monitoring_interrupts
     10.67 ± 46%     -34.4%       7.00 ± 42%      +4.7%      11.17 ± 57%  interrupts.CPU178.RES:Rescheduling_interrupts
     12.83 ± 49%     -23.4%       9.83 ± 19%      +7.8%      13.83 ± 31%  interrupts.CPU178.TLB:TLB_shootdowns
      1235          +109.6%       2590 ± 18%     +97.5%       2441 ± 15%  interrupts.CPU179.CAL:Function_call_interrupts
    602028            -1.2%     594739            -0.3%     600115        interrupts.CPU179.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU179.MCP:Machine_check_polls
    282.67 ± 32%     -29.1%     200.33 ±  4%      -4.7%     269.50 ± 35%  interrupts.CPU179.NMI:Non-maskable_interrupts
    282.67 ± 32%     -29.1%     200.33 ±  4%      -4.7%     269.50 ± 35%  interrupts.CPU179.PMI:Performance_monitoring_interrupts
      7.17 ±104%     +39.5%      10.00 ± 40%     +62.8%      11.67 ± 35%  interrupts.CPU179.RES:Rescheduling_interrupts
      8.50 ± 21%     +31.4%      11.17 ± 22%     +21.6%      10.33 ± 18%  interrupts.CPU179.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU18.38:IR-PCI-MSI.3145730-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU18.3:IR-IO-APIC.3-edge
      0.50 ±223%      +0.0%       0.50 ±223%    +300.0%       2.00 ± 70%  interrupts.CPU18.42:IR-PCI-MSI.512000-edge.ahci[0000:00:1f.2]
      1741 ± 19%    +132.4%       4047 ± 57%     +65.2%       2877 ± 13%  interrupts.CPU18.CAL:Function_call_interrupts
    602321            -0.3%     600278            -0.2%     601162        interrupts.CPU18.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU18.MCP:Machine_check_polls
    309.00 ± 31%     -14.2%     265.17 ± 31%     -42.0%     179.17 ±  3%  interrupts.CPU18.NMI:Non-maskable_interrupts
    309.00 ± 31%     -14.2%     265.17 ± 31%     -42.0%     179.17 ±  3%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
     79.17 ± 55%     +12.4%      89.00 ± 67%     -21.9%      61.83 ± 42%  interrupts.CPU18.RES:Rescheduling_interrupts
     71.00 ± 27%      -3.3%      68.67 ± 11%      -9.9%      64.00 ± 23%  interrupts.CPU18.TLB:TLB_shootdowns
      1246 ±  2%    +136.4%       2947 ± 23%    +238.7%       4222 ±105%  interrupts.CPU180.CAL:Function_call_interrupts
    602092            -1.6%     592208 ±  2%      -0.3%     600254        interrupts.CPU180.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU180.MCP:Machine_check_polls
    284.50 ± 34%      +9.0%     310.17 ± 45%     -12.3%     249.50 ± 28%  interrupts.CPU180.NMI:Non-maskable_interrupts
    284.50 ± 34%      +9.0%     310.17 ± 45%     -12.3%     249.50 ± 28%  interrupts.CPU180.PMI:Performance_monitoring_interrupts
      9.00 ± 47%    +583.3%      61.50 ±165%      +5.6%       9.50 ± 51%  interrupts.CPU180.RES:Rescheduling_interrupts
     12.50 ± 31%     +22.7%      15.33 ± 61%     -14.7%      10.67 ± 27%  interrupts.CPU180.TLB:TLB_shootdowns
      1219          +141.7%       2946 ± 24%     +99.9%       2436 ± 15%  interrupts.CPU181.CAL:Function_call_interrupts
    602091            -1.6%     592326 ±  2%      -0.3%     600150        interrupts.CPU181.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU181.MCP:Machine_check_polls
    494.00 ± 93%     -38.0%     306.33 ± 34%     -50.8%     242.83 ± 32%  interrupts.CPU181.NMI:Non-maskable_interrupts
    494.00 ± 93%     -38.0%     306.33 ± 34%     -50.8%     242.83 ± 32%  interrupts.CPU181.PMI:Performance_monitoring_interrupts
      7.50 ± 41%    +482.2%      43.67 ±124%     +24.4%       9.33 ± 29%  interrupts.CPU181.RES:Rescheduling_interrupts
      9.50 ± 36%     +63.2%      15.50 ± 48%     +78.9%      17.00 ±115%  interrupts.CPU181.TLB:TLB_shootdowns
      1243 ±  3%    +107.5%       2579 ± 18%    +105.6%       2556 ± 15%  interrupts.CPU182.CAL:Function_call_interrupts
    602102            -1.3%     594002            -0.3%     600376        interrupts.CPU182.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU182.MCP:Machine_check_polls
    256.33 ± 35%     +42.3%     364.67 ± 28%     +24.2%     318.33 ± 31%  interrupts.CPU182.NMI:Non-maskable_interrupts
    256.33 ± 35%     +42.3%     364.67 ± 28%     +24.2%     318.33 ± 31%  interrupts.CPU182.PMI:Performance_monitoring_interrupts
     11.00 ± 54%     -48.5%       5.67 ± 71%    +183.3%      31.17 ±128%  interrupts.CPU182.RES:Rescheduling_interrupts
     12.00 ± 30%     -18.1%       9.83 ± 25%      -5.6%      11.33 ± 27%  interrupts.CPU182.TLB:TLB_shootdowns
      1233          +111.9%       2613 ± 19%     +96.2%       2420 ± 15%  interrupts.CPU183.CAL:Function_call_interrupts
    602080            -1.0%     596321            -0.3%     600487        interrupts.CPU183.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU183.MCP:Machine_check_polls
    246.50 ± 31%     +39.9%     344.83 ± 30%      -0.6%     245.00 ± 33%  interrupts.CPU183.NMI:Non-maskable_interrupts
    246.50 ± 31%     +39.9%     344.83 ± 30%      -0.6%     245.00 ± 33%  interrupts.CPU183.PMI:Performance_monitoring_interrupts
     11.50 ± 39%      -5.8%      10.83 ± 71%     -13.0%      10.00 ± 27%  interrupts.CPU183.RES:Rescheduling_interrupts
      8.00 ± 22%     +37.5%      11.00 ± 50%     +27.1%      10.17 ± 17%  interrupts.CPU183.TLB:TLB_shootdowns
      1231          +114.1%       2637 ± 17%     +97.7%       2435 ± 15%  interrupts.CPU184.CAL:Function_call_interrupts
    601990            -1.0%     596116            -0.3%     600099        interrupts.CPU184.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU184.MCP:Machine_check_polls
    326.00 ± 31%      +2.6%     334.33 ± 68%     -28.5%     233.17 ± 33%  interrupts.CPU184.NMI:Non-maskable_interrupts
    326.00 ± 31%      +2.6%     334.33 ± 68%     -28.5%     233.17 ± 33%  interrupts.CPU184.PMI:Performance_monitoring_interrupts
      7.33 ± 44%      -4.5%       7.00 ± 48%     +59.1%      11.67 ± 31%  interrupts.CPU184.RES:Rescheduling_interrupts
      9.17 ± 23%      +7.3%       9.83 ± 31%     +50.9%      13.83 ± 31%  interrupts.CPU184.TLB:TLB_shootdowns
      1247 ±  5%    +108.1%       2595 ± 18%     +95.0%       2432 ± 15%  interrupts.CPU185.CAL:Function_call_interrupts
    602165            -1.1%     595836            -0.3%     600126        interrupts.CPU185.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU185.MCP:Machine_check_polls
    270.00 ± 35%     -12.0%     237.67 ± 37%     -12.0%     237.67 ± 33%  interrupts.CPU185.NMI:Non-maskable_interrupts
    270.00 ± 35%     -12.0%     237.67 ± 37%     -12.0%     237.67 ± 33%  interrupts.CPU185.PMI:Performance_monitoring_interrupts
      6.50 ± 42%     +25.6%       8.17 ± 35%     +30.8%       8.50 ± 56%  interrupts.CPU185.RES:Rescheduling_interrupts
      7.67 ± 12%      +8.7%       8.33 ± 23%     +21.7%       9.33 ± 17%  interrupts.CPU185.TLB:TLB_shootdowns
      1237 ±  2%    +110.6%       2606 ± 19%     +95.9%       2425 ± 15%  interrupts.CPU186.CAL:Function_call_interrupts
    602047            -1.1%     595224            -0.3%     600263        interrupts.CPU186.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU186.MCP:Machine_check_polls
    279.50 ± 35%      -5.4%     264.33 ± 37%     -18.2%     228.50 ± 30%  interrupts.CPU186.NMI:Non-maskable_interrupts
    279.50 ± 35%      -5.4%     264.33 ± 37%     -18.2%     228.50 ± 30%  interrupts.CPU186.PMI:Performance_monitoring_interrupts
      9.67 ± 40%     +19.0%      11.50 ± 49%     -15.5%       8.17 ± 79%  interrupts.CPU186.RES:Rescheduling_interrupts
     10.17 ± 20%     +27.9%      13.00 ± 58%      -8.2%       9.33 ± 20%  interrupts.CPU186.TLB:TLB_shootdowns
      1225          +111.0%       2585 ± 18%     +89.9%       2326 ±  6%  interrupts.CPU187.CAL:Function_call_interrupts
    602052            -1.1%     595197            -0.2%     600631        interrupts.CPU187.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU187.MCP:Machine_check_polls
    273.00 ± 33%     +10.1%     300.50 ± 34%     +11.8%     305.33 ± 33%  interrupts.CPU187.NMI:Non-maskable_interrupts
    273.00 ± 33%     +10.1%     300.50 ± 34%     +11.8%     305.33 ± 33%  interrupts.CPU187.PMI:Performance_monitoring_interrupts
     11.83 ± 48%     -35.2%       7.67 ± 48%     -29.6%       8.33 ± 44%  interrupts.CPU187.RES:Rescheduling_interrupts
      8.33 ± 11%      +2.0%       8.50 ± 20%     +28.0%      10.67 ± 29%  interrupts.CPU187.TLB:TLB_shootdowns
      1232          +110.9%       2598 ± 18%    +175.5%       3394 ± 63%  interrupts.CPU188.CAL:Function_call_interrupts
    602285            -1.5%     593040 ±  2%      -0.4%     600158        interrupts.CPU188.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU188.MCP:Machine_check_polls
    315.17 ± 35%      +1.3%     319.17 ± 33%      -1.3%     311.17 ± 31%  interrupts.CPU188.NMI:Non-maskable_interrupts
    315.17 ± 35%      +1.3%     319.17 ± 33%      -1.3%     311.17 ± 31%  interrupts.CPU188.PMI:Performance_monitoring_interrupts
      9.50 ± 58%     +17.5%      11.17 ± 38%     -26.3%       7.00 ± 42%  interrupts.CPU188.RES:Rescheduling_interrupts
     11.00 ± 30%     +12.1%      12.33 ± 15%     +15.2%      12.67 ± 26%  interrupts.CPU188.TLB:TLB_shootdowns
      1224          +110.7%       2580 ± 18%    +103.4%       2491 ± 15%  interrupts.CPU189.CAL:Function_call_interrupts
    602219            -0.9%     596887            -0.3%     600628        interrupts.CPU189.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU189.MCP:Machine_check_polls
    306.83 ± 33%     -11.0%     273.17 ± 32%     -22.8%     236.83 ± 32%  interrupts.CPU189.NMI:Non-maskable_interrupts
    306.83 ± 33%     -11.0%     273.17 ± 32%     -22.8%     236.83 ± 32%  interrupts.CPU189.PMI:Performance_monitoring_interrupts
      7.00 ± 31%     +50.0%      10.50 ± 28%     +33.3%       9.33 ± 51%  interrupts.CPU189.RES:Rescheduling_interrupts
      7.67 ± 20%     +21.7%       9.33 ± 26%     +26.1%       9.67 ± 36%  interrupts.CPU189.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.39:IR-PCI-MSI.3145731-edge
      1380 ±  8%    +258.5%       4948 ±104%     +91.1%       2638 ± 13%  interrupts.CPU19.CAL:Function_call_interrupts
    602197            -0.3%     600536            -0.2%     600832        interrupts.CPU19.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU19.MCP:Machine_check_polls
    242.33 ± 32%      +9.4%     265.17 ± 33%     -25.3%     181.00 ±  2%  interrupts.CPU19.NMI:Non-maskable_interrupts
    242.33 ± 32%      +9.4%     265.17 ± 33%     -25.3%     181.00 ±  2%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
     19.83 ± 43%     +26.1%      25.00 ± 30%     +15.1%      22.83 ± 48%  interrupts.CPU19.RES:Rescheduling_interrupts
     21.17 ± 43%      +0.0%      21.17 ± 19%      +9.4%      23.17 ± 26%  interrupts.CPU19.TLB:TLB_shootdowns
      1235          +113.4%       2636 ± 18%     +96.2%       2422 ± 15%  interrupts.CPU190.CAL:Function_call_interrupts
    602238            -1.6%     592798            -0.3%     600162        interrupts.CPU190.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU190.MCP:Machine_check_polls
    327.67 ± 33%     -23.1%     252.00 ± 29%     -11.6%     289.67 ± 36%  interrupts.CPU190.NMI:Non-maskable_interrupts
    327.67 ± 33%     -23.1%     252.00 ± 29%     -11.6%     289.67 ± 36%  interrupts.CPU190.PMI:Performance_monitoring_interrupts
      6.50 ± 49%    +128.2%      14.83 ± 44%     +10.3%       7.17 ± 12%  interrupts.CPU190.RES:Rescheduling_interrupts
     11.67 ± 26%     +87.1%      21.83 ±115%      -8.6%      10.67 ± 12%  interrupts.CPU190.TLB:TLB_shootdowns
      1238 ±  3%    +108.5%       2582 ± 18%     +95.9%       2426 ± 15%  interrupts.CPU191.CAL:Function_call_interrupts
    602265            -1.1%     595446            -0.3%     600411        interrupts.CPU191.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU191.MCP:Machine_check_polls
    450.67 ± 95%     -28.1%     324.17 ± 36%     -36.8%     284.83 ± 35%  interrupts.CPU191.NMI:Non-maskable_interrupts
    450.67 ± 95%     -28.1%     324.17 ± 36%     -36.8%     284.83 ± 35%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
     10.67 ± 52%     -31.2%       7.33 ± 42%     -20.3%       8.50 ± 43%  interrupts.CPU191.RES:Rescheduling_interrupts
     20.67 ±122%     -44.4%      11.50 ± 41%     -60.5%       8.17 ± 14%  interrupts.CPU191.TLB:TLB_shootdowns
      1272 ± 10%    +102.6%       2578 ± 18%     +89.4%       2411 ± 15%  interrupts.CPU192.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  interrupts.CPU192.IWI:IRQ_work_interrupts
    602071            -0.9%     596537            -0.3%     600521        interrupts.CPU192.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU192.MCP:Machine_check_polls
    244.33 ± 28%      +8.3%     264.50 ± 37%    +210.7%     759.17 ±132%  interrupts.CPU192.NMI:Non-maskable_interrupts
    244.33 ± 28%      +8.3%     264.50 ± 37%    +210.7%     759.17 ±132%  interrupts.CPU192.PMI:Performance_monitoring_interrupts
     14.17 ± 95%     -54.1%       6.50 ± 49%     -55.3%       6.33 ± 64%  interrupts.CPU192.RES:Rescheduling_interrupts
      6.83 ±  5%      +4.9%       7.17 ± 14%      +2.4%       7.00 ±  8%  interrupts.CPU192.TLB:TLB_shootdowns
      1211          +113.0%       2580 ± 18%    +108.8%       2529 ± 16%  interrupts.CPU193.CAL:Function_call_interrupts
    601474            -2.1%     588698 ±  3%      -0.3%     599667        interrupts.CPU193.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU193.MCP:Machine_check_polls
    341.00 ± 40%      +5.1%     358.33 ± 27%      +6.9%     364.67 ± 29%  interrupts.CPU193.NMI:Non-maskable_interrupts
    341.00 ± 40%      +5.1%     358.33 ± 27%      +6.9%     364.67 ± 29%  interrupts.CPU193.PMI:Performance_monitoring_interrupts
      5.83 ± 26%     +68.6%       9.83 ± 38%     +71.4%      10.00 ± 50%  interrupts.CPU193.RES:Rescheduling_interrupts
      7.33 ± 35%      +0.0%       7.33 ± 15%      -6.8%       6.83 ±  5%  interrupts.CPU193.TLB:TLB_shootdowns
      1215          +118.1%       2650 ± 22%     +94.8%       2368 ± 17%  interrupts.CPU194.CAL:Function_call_interrupts
    601981            -0.5%     599210            -0.2%     600633        interrupts.CPU194.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU194.MCP:Machine_check_polls
    223.50 ± 37%      -1.5%     220.17 ± 33%      -1.5%     220.17 ± 34%  interrupts.CPU194.NMI:Non-maskable_interrupts
    223.50 ± 37%      -1.5%     220.17 ± 33%      -1.5%     220.17 ± 34%  interrupts.CPU194.PMI:Performance_monitoring_interrupts
      7.00 ± 56%    +250.0%      24.50 ±176%    +107.1%      14.50 ± 92%  interrupts.CPU194.RES:Rescheduling_interrupts
     10.33 ± 33%      -3.2%      10.00 ± 31%     +38.7%      14.33 ± 90%  interrupts.CPU194.TLB:TLB_shootdowns
      1238 ±  2%    +109.2%       2589 ± 18%     +95.6%       2421 ± 15%  interrupts.CPU195.CAL:Function_call_interrupts
    602105            -0.4%     599512            -0.2%     601097        interrupts.CPU195.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU195.MCP:Machine_check_polls
    267.67 ± 33%     -17.4%     221.00 ± 31%     -21.2%     211.00 ± 29%  interrupts.CPU195.NMI:Non-maskable_interrupts
    267.67 ± 33%     -17.4%     221.00 ± 31%     -21.2%     211.00 ± 29%  interrupts.CPU195.PMI:Performance_monitoring_interrupts
     20.83 ± 34%     -33.6%      13.83 ± 17%     -44.8%      11.50 ± 33%  interrupts.CPU195.RES:Rescheduling_interrupts
      8.17 ± 16%     +30.6%      10.67 ± 31%    +189.8%      23.67 ±120%  interrupts.CPU195.TLB:TLB_shootdowns
      1221          +111.9%       2587 ± 18%     +98.1%       2419 ± 15%  interrupts.CPU196.CAL:Function_call_interrupts
    601792            -0.8%     596722            -0.2%     600487        interrupts.CPU196.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU196.MCP:Machine_check_polls
    303.00 ± 33%     -18.6%     246.50 ± 31%     -13.4%     262.33 ± 35%  interrupts.CPU196.NMI:Non-maskable_interrupts
    303.00 ± 33%     -18.6%     246.50 ± 31%     -13.4%     262.33 ± 35%  interrupts.CPU196.PMI:Performance_monitoring_interrupts
      9.83 ± 36%      -6.8%       9.17 ± 47%     -27.1%       7.17 ± 42%  interrupts.CPU196.RES:Rescheduling_interrupts
     16.33 ±114%     -44.9%       9.00 ± 35%     -43.9%       9.17 ± 15%  interrupts.CPU196.TLB:TLB_shootdowns
      1268 ±  8%    +104.8%       2598 ± 19%     +91.9%       2434 ± 15%  interrupts.CPU197.CAL:Function_call_interrupts
    601986            -0.7%     597514            -0.3%     600369        interrupts.CPU197.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU197.MCP:Machine_check_polls
    250.50 ± 29%     +10.9%     277.83 ± 38%     +21.9%     305.33 ± 32%  interrupts.CPU197.NMI:Non-maskable_interrupts
    250.50 ± 29%     +10.9%     277.83 ± 38%     +21.9%     305.33 ± 32%  interrupts.CPU197.PMI:Performance_monitoring_interrupts
     21.00 ± 80%     -31.0%      14.50 ± 43%     -22.2%      16.33 ± 28%  interrupts.CPU197.RES:Rescheduling_interrupts
      6.83 ± 15%     +68.3%      11.50 ± 55%     +43.9%       9.83 ± 23%  interrupts.CPU197.TLB:TLB_shootdowns
      1240 ±  2%    +108.4%       2586 ± 18%     +95.1%       2421 ± 15%  interrupts.CPU198.CAL:Function_call_interrupts
    602072            -0.9%     596665            -0.3%     600286        interrupts.CPU198.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU198.MCP:Machine_check_polls
    292.33 ± 33%      +6.2%     310.33 ± 28%      -2.9%     283.83 ± 32%  interrupts.CPU198.NMI:Non-maskable_interrupts
    292.33 ± 33%      +6.2%     310.33 ± 28%      -2.9%     283.83 ± 32%  interrupts.CPU198.PMI:Performance_monitoring_interrupts
      9.00 ± 36%     -38.9%       5.50 ± 38%     -44.4%       5.00 ± 50%  interrupts.CPU198.RES:Rescheduling_interrupts
     11.00 ± 21%     -12.1%       9.67 ± 37%     -15.2%       9.33 ± 34%  interrupts.CPU198.TLB:TLB_shootdowns
      1226          +111.3%       2590 ± 18%     +98.3%       2431 ± 15%  interrupts.CPU199.CAL:Function_call_interrupts
    602135            -0.7%     597775            -0.3%     600532        interrupts.CPU199.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU199.MCP:Machine_check_polls
    316.67 ± 35%      -5.7%     298.50 ± 31%      -2.7%     308.17 ± 38%  interrupts.CPU199.NMI:Non-maskable_interrupts
    316.67 ± 35%      -5.7%     298.50 ± 31%      -2.7%     308.17 ± 38%  interrupts.CPU199.PMI:Performance_monitoring_interrupts
     14.00 ± 20%      +4.8%      14.67 ± 38%      +6.0%      14.83 ± 42%  interrupts.CPU199.RES:Rescheduling_interrupts
      9.17 ± 31%     +18.2%      10.83 ± 36%     +12.7%      10.33 ± 26%  interrupts.CPU199.TLB:TLB_shootdowns
      1765 ±  6%    +139.9%       4235 ± 66%    +106.2%       3639 ± 51%  interrupts.CPU2.CAL:Function_call_interrupts
    602297            -0.2%     601318            -0.2%     601355        interrupts.CPU2.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU2.MCP:Machine_check_polls
    160.00 ±  4%      +7.2%     171.50 ± 10%     +30.1%     208.17 ± 35%  interrupts.CPU2.NMI:Non-maskable_interrupts
    160.00 ±  4%      +7.2%     171.50 ± 10%     +30.1%     208.17 ± 35%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
     48.17 ± 19%    +232.9%     160.33 ±140%    +275.8%     181.00 ±148%  interrupts.CPU2.RES:Rescheduling_interrupts
     72.83 ± 16%     -14.9%      62.00 ± 24%     -32.5%      49.17 ± 47%  interrupts.CPU2.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.40:IR-PCI-MSI.3145732-edge
      1700 ± 13%     +88.7%       3208 ± 20%     +70.2%       2893 ± 10%  interrupts.CPU20.CAL:Function_call_interrupts
    601458            -0.2%     600233            -0.1%     601040        interrupts.CPU20.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU20.MCP:Machine_check_polls
    258.83 ± 34%      -0.6%     257.17 ± 32%     -35.5%     167.00 ±  3%  interrupts.CPU20.NMI:Non-maskable_interrupts
    258.83 ± 34%      -0.6%     257.17 ± 32%     -35.5%     167.00 ±  3%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
     50.50 ± 23%     +46.2%      73.83 ± 76%     +56.1%      78.83 ± 27%  interrupts.CPU20.RES:Rescheduling_interrupts
     67.50 ± 13%      -0.7%      67.00 ± 30%      -0.2%      67.33 ± 21%  interrupts.CPU20.TLB:TLB_shootdowns
      1230 ±  2%    +110.1%       2586 ± 18%    +102.3%       2489 ± 14%  interrupts.CPU200.CAL:Function_call_interrupts
    602215            -1.2%     595195            -0.3%     600230        interrupts.CPU200.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU200.MCP:Machine_check_polls
    308.33 ± 34%     -14.8%     262.67 ± 32%      -8.1%     283.50 ± 31%  interrupts.CPU200.NMI:Non-maskable_interrupts
    308.33 ± 34%     -14.8%     262.67 ± 32%      -8.1%     283.50 ± 31%  interrupts.CPU200.PMI:Performance_monitoring_interrupts
      9.67 ± 70%      -5.2%       9.17 ± 47%      +6.9%      10.33 ± 41%  interrupts.CPU200.RES:Rescheduling_interrupts
      8.67 ± 23%     +30.8%      11.33 ± 15%      +3.8%       9.00 ± 21%  interrupts.CPU200.TLB:TLB_shootdowns
      1225          +111.9%       2595 ± 18%     +97.9%       2424 ± 15%  interrupts.CPU201.CAL:Function_call_interrupts
    601974            -0.9%     596558            -0.4%     599351        interrupts.CPU201.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU201.MCP:Machine_check_polls
    247.33 ± 32%      -2.8%     240.50 ± 33%     +13.7%     281.17 ± 36%  interrupts.CPU201.NMI:Non-maskable_interrupts
    247.33 ± 32%      -2.8%     240.50 ± 33%     +13.7%     281.17 ± 36%  interrupts.CPU201.PMI:Performance_monitoring_interrupts
     20.17 ± 27%     -32.2%      13.67 ± 12%     -43.0%      11.50 ± 30%  interrupts.CPU201.RES:Rescheduling_interrupts
      7.33 ± 15%     +47.7%      10.83 ± 20%     +13.6%       8.33 ± 35%  interrupts.CPU201.TLB:TLB_shootdowns
      1229          +111.8%       2604 ± 18%    +102.9%       2494 ± 15%  interrupts.CPU202.CAL:Function_call_interrupts
    602116            -2.5%     587315 ±  4%      -0.3%     600468        interrupts.CPU202.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU202.MCP:Machine_check_polls
    237.67 ± 32%      +8.9%     258.83 ± 30%      -5.5%     224.67 ± 29%  interrupts.CPU202.NMI:Non-maskable_interrupts
    237.67 ± 32%      +8.9%     258.83 ± 30%      -5.5%     224.67 ± 29%  interrupts.CPU202.PMI:Performance_monitoring_interrupts
      7.17 ± 28%     +48.8%      10.67 ± 52%    +151.2%      18.00 ±120%  interrupts.CPU202.RES:Rescheduling_interrupts
      9.17 ± 31%     +29.1%      11.83 ± 26%     +12.7%      10.33 ± 19%  interrupts.CPU202.TLB:TLB_shootdowns
      1227          +114.8%       2635 ± 18%     +97.6%       2424 ± 15%  interrupts.CPU203.CAL:Function_call_interrupts
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        interrupts.CPU203.IWI:IRQ_work_interrupts
    602210            -1.6%     592338 ±  2%      -0.3%     600501        interrupts.CPU203.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU203.MCP:Machine_check_polls
    246.67 ± 30%      +9.7%     270.50 ± 33%     +22.4%     301.83 ± 35%  interrupts.CPU203.NMI:Non-maskable_interrupts
    246.67 ± 30%      +9.7%     270.50 ± 33%     +22.4%     301.83 ± 35%  interrupts.CPU203.PMI:Performance_monitoring_interrupts
     17.17 ± 24%     +26.2%      21.67 ± 40%      -1.0%      17.00 ± 12%  interrupts.CPU203.RES:Rescheduling_interrupts
      7.00 ±  8%    +150.0%      17.50 ± 55%     +64.3%      11.50 ± 35%  interrupts.CPU203.TLB:TLB_shootdowns
      1218           +99.4%       2429 ± 28%     +99.8%       2434 ± 15%  interrupts.CPU204.CAL:Function_call_interrupts
    602131            -0.7%     597877            -0.2%     600643        interrupts.CPU204.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU204.MCP:Machine_check_polls
    271.00 ± 36%     +22.1%     331.00 ± 27%     +16.0%     314.33 ± 37%  interrupts.CPU204.NMI:Non-maskable_interrupts
    271.00 ± 36%     +22.1%     331.00 ± 27%     +16.0%     314.33 ± 37%  interrupts.CPU204.PMI:Performance_monitoring_interrupts
      7.67 ± 28%     +41.3%      10.83 ± 51%      +8.7%       8.33 ± 44%  interrupts.CPU204.RES:Rescheduling_interrupts
     28.00 ±152%     -55.4%      12.50 ± 32%     -68.5%       8.83 ± 32%  interrupts.CPU204.TLB:TLB_shootdowns
      1213          +118.4%       2650 ± 21%    +105.6%       2495 ± 14%  interrupts.CPU205.CAL:Function_call_interrupts
    601996            -1.4%     593841            -0.3%     600431        interrupts.CPU205.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU205.MCP:Machine_check_polls
    279.83 ± 36%     +12.9%     316.00 ± 30%      -3.0%     271.33 ± 32%  interrupts.CPU205.NMI:Non-maskable_interrupts
    279.83 ± 36%     +12.9%     316.00 ± 30%      -3.0%     271.33 ± 32%  interrupts.CPU205.PMI:Performance_monitoring_interrupts
     17.00 ± 32%     +45.1%      24.67 ± 40%     +19.6%      20.33 ± 83%  interrupts.CPU205.RES:Rescheduling_interrupts
      8.67 ± 30%     +86.5%      16.17 ±106%     +94.2%      16.83 ±100%  interrupts.CPU205.TLB:TLB_shootdowns
      1216          +113.6%       2598 ± 18%    +100.5%       2438 ± 15%  interrupts.CPU206.CAL:Function_call_interrupts
    602130            -1.0%     596400            -0.3%     600055        interrupts.CPU206.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU206.MCP:Machine_check_polls
    308.00 ± 33%     -12.4%     269.67 ± 35%      -3.1%     298.50 ± 30%  interrupts.CPU206.NMI:Non-maskable_interrupts
    308.00 ± 33%     -12.4%     269.67 ± 35%      -3.1%     298.50 ± 30%  interrupts.CPU206.PMI:Performance_monitoring_interrupts
      7.17 ± 45%      +4.7%       7.50 ± 58%     +30.2%       9.33 ± 41%  interrupts.CPU206.RES:Rescheduling_interrupts
      8.83 ± 17%      +1.9%       9.00 ± 16%     +32.1%      11.67 ± 26%  interrupts.CPU206.TLB:TLB_shootdowns
      1222 ±  3%    +115.3%       2632 ± 17%     +98.4%       2426 ± 15%  interrupts.CPU207.CAL:Function_call_interrupts
    602160            -1.3%     594410            -0.3%     600307        interrupts.CPU207.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU207.MCP:Machine_check_polls
    285.17 ± 28%     +10.9%     316.17 ± 30%     +22.8%     350.17 ± 27%  interrupts.CPU207.NMI:Non-maskable_interrupts
    285.17 ± 28%     +10.9%     316.17 ± 30%     +22.8%     350.17 ± 27%  interrupts.CPU207.PMI:Performance_monitoring_interrupts
     17.00 ± 34%     +33.3%      22.67 ± 41%     -11.8%      15.00 ± 26%  interrupts.CPU207.RES:Rescheduling_interrupts
     10.33 ± 36%      -9.7%       9.33 ± 38%      -3.2%      10.00 ± 23%  interrupts.CPU207.TLB:TLB_shootdowns
      1392 ± 27%     +87.3%       2607 ± 18%     +76.3%       2453 ± 15%  interrupts.CPU208.CAL:Function_call_interrupts
    602015            -0.7%     597562            -0.2%     600689        interrupts.CPU208.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU208.MCP:Machine_check_polls
    352.33 ± 70%     -26.8%     257.83 ± 31%     -34.4%     231.17 ± 32%  interrupts.CPU208.NMI:Non-maskable_interrupts
    352.33 ± 70%     -26.8%     257.83 ± 31%     -34.4%     231.17 ± 32%  interrupts.CPU208.PMI:Performance_monitoring_interrupts
     23.67 ±151%     -55.6%      10.50 ± 23%     -43.7%      13.33 ± 74%  interrupts.CPU208.RES:Rescheduling_interrupts
     11.00 ± 18%      +9.1%      12.00 ± 30%     +39.4%      15.33 ± 73%  interrupts.CPU208.TLB:TLB_shootdowns
      1431 ± 28%     +81.4%       2596 ± 18%     +70.0%       2432 ± 15%  interrupts.CPU209.CAL:Function_call_interrupts
    602024            -0.5%     599227            -0.2%     600566        interrupts.CPU209.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU209.MCP:Machine_check_polls
    218.83 ± 32%     +23.7%     270.67 ± 32%     +14.0%     249.50 ± 33%  interrupts.CPU209.NMI:Non-maskable_interrupts
    218.83 ± 32%     +23.7%     270.67 ± 32%     +14.0%     249.50 ± 33%  interrupts.CPU209.PMI:Performance_monitoring_interrupts
     36.17 ±125%     -53.0%      17.00 ± 15%     -63.6%      13.17 ± 27%  interrupts.CPU209.RES:Rescheduling_interrupts
     11.83 ± 44%      +1.4%      12.00 ± 39%     -31.0%       8.17 ± 19%  interrupts.CPU209.TLB:TLB_shootdowns
      1375 ± 10%     +97.2%       2712 ± 21%     +85.8%       2555 ± 17%  interrupts.CPU21.CAL:Function_call_interrupts
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        interrupts.CPU21.IWI:IRQ_work_interrupts
    602186            -0.2%     600707            -0.2%     600873        interrupts.CPU21.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU21.MCP:Machine_check_polls
    197.33 ± 31%     +78.0%     351.17 ± 14%     +18.6%     234.00 ± 33%  interrupts.CPU21.NMI:Non-maskable_interrupts
    197.33 ± 31%     +78.0%     351.17 ± 14%     +18.6%     234.00 ± 33%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
     31.33 ± 30%     -21.3%      24.67 ± 50%     +70.7%      53.50 ± 90%  interrupts.CPU21.RES:Rescheduling_interrupts
     23.00 ± 25%      +0.0%      23.00 ± 44%      -1.4%      22.67 ± 21%  interrupts.CPU21.TLB:TLB_shootdowns
      1299 ± 14%    +100.1%       2601 ± 19%     +86.5%       2424 ± 15%  interrupts.CPU210.CAL:Function_call_interrupts
    601969            -1.0%     596022            -0.3%     600366        interrupts.CPU210.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU210.MCP:Machine_check_polls
    266.67 ± 33%      -0.1%     266.50 ± 35%      -4.5%     254.67 ± 31%  interrupts.CPU210.NMI:Non-maskable_interrupts
    266.67 ± 33%      -0.1%     266.50 ± 35%      -4.5%     254.67 ± 31%  interrupts.CPU210.PMI:Performance_monitoring_interrupts
     17.67 ±146%     -42.5%      10.17 ± 31%     -33.0%      11.83 ± 42%  interrupts.CPU210.RES:Rescheduling_interrupts
     10.67 ± 17%      -1.6%      10.50 ± 17%      +0.0%      10.67 ± 26%  interrupts.CPU210.TLB:TLB_shootdowns
      1227          +112.6%       2609 ± 19%     +99.3%       2446 ± 15%  interrupts.CPU211.CAL:Function_call_interrupts
    602088            -0.7%     597926            -0.3%     600582        interrupts.CPU211.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU211.MCP:Machine_check_polls
    287.00 ± 31%      -3.3%     277.50 ± 36%      +8.1%     310.17 ± 31%  interrupts.CPU211.NMI:Non-maskable_interrupts
    287.00 ± 31%      -3.3%     277.50 ± 36%      +8.1%     310.17 ± 31%  interrupts.CPU211.PMI:Performance_monitoring_interrupts
     17.17 ± 41%      -2.9%      16.67 ± 24%      +6.8%      18.33 ± 42%  interrupts.CPU211.RES:Rescheduling_interrupts
     10.00 ± 36%     +20.0%      12.00 ± 61%     +45.0%      14.50 ± 73%  interrupts.CPU211.TLB:TLB_shootdowns
      1213          +113.3%       2587 ± 18%    +101.0%       2438 ± 15%  interrupts.CPU212.CAL:Function_call_interrupts
    601428            -0.8%     596638            -0.2%     600421        interrupts.CPU212.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU212.MCP:Machine_check_polls
    308.33 ± 35%     -21.6%     241.83 ± 38%      -1.2%     304.67 ± 32%  interrupts.CPU212.NMI:Non-maskable_interrupts
    308.33 ± 35%     -21.6%     241.83 ± 38%      -1.2%     304.67 ± 32%  interrupts.CPU212.PMI:Performance_monitoring_interrupts
     11.33 ± 45%     -30.9%       7.83 ± 35%     +16.2%      13.17 ± 51%  interrupts.CPU212.RES:Rescheduling_interrupts
      8.17 ± 42%     +26.5%      10.33 ± 25%     +20.4%       9.83 ± 23%  interrupts.CPU212.TLB:TLB_shootdowns
      1285 ±  7%    +104.9%       2634 ± 19%     +92.9%       2480 ± 18%  interrupts.CPU213.CAL:Function_call_interrupts
      0.00       +3.3e+101%       0.33 ±223%    -100.0%       0.00        interrupts.CPU213.IWI:IRQ_work_interrupts
    602136            -0.5%     599077            -0.3%     600620        interrupts.CPU213.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU213.MCP:Machine_check_polls
    287.00 ± 31%    +224.9%     932.33 ±169%      -5.5%     271.33 ± 31%  interrupts.CPU213.NMI:Non-maskable_interrupts
    287.00 ± 31%    +224.9%     932.33 ±169%      -5.5%     271.33 ± 31%  interrupts.CPU213.PMI:Performance_monitoring_interrupts
     23.00 ± 33%      +2.2%      23.50 ± 46%      -8.0%      21.17 ± 63%  interrupts.CPU213.RES:Rescheduling_interrupts
     13.00 ± 29%     -10.3%      11.67 ± 46%      +7.7%      14.00 ± 44%  interrupts.CPU213.TLB:TLB_shootdowns
      1228          +111.0%       2591 ± 18%     +97.2%       2422 ± 15%  interrupts.CPU214.CAL:Function_call_interrupts
      0.67 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU214.IWI:IRQ_work_interrupts
    602089            -0.7%     597967            -0.3%     600476        interrupts.CPU214.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU214.MCP:Machine_check_polls
    246.67 ± 27%      +6.1%     261.67 ± 35%     +19.9%     295.83 ± 33%  interrupts.CPU214.NMI:Non-maskable_interrupts
    246.67 ± 27%      +6.1%     261.67 ± 35%     +19.9%     295.83 ± 33%  interrupts.CPU214.PMI:Performance_monitoring_interrupts
      7.17 ± 23%     +23.3%       8.83 ± 17%     +53.5%      11.00 ± 46%  interrupts.CPU214.RES:Rescheduling_interrupts
     61.50 ±176%     -80.5%      12.00 ± 24%     -73.7%      16.17 ± 33%  interrupts.CPU214.TLB:TLB_shootdowns
      1219          +112.9%       2595 ± 18%    +107.4%       2528 ± 14%  interrupts.CPU215.CAL:Function_call_interrupts
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU215.IWI:IRQ_work_interrupts
    602064            -0.6%     598292            -0.3%     600402        interrupts.CPU215.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU215.MCP:Machine_check_polls
    295.17 ± 42%      -9.7%     266.67 ± 34%     -11.2%     262.17 ± 32%  interrupts.CPU215.NMI:Non-maskable_interrupts
    295.17 ± 42%      -9.7%     266.67 ± 34%     -11.2%     262.17 ± 32%  interrupts.CPU215.PMI:Performance_monitoring_interrupts
     10.83 ± 31%     +44.6%      15.67 ± 40%    +203.1%      32.83 ± 62%  interrupts.CPU215.RES:Rescheduling_interrupts
     11.17 ± 40%      -3.0%      10.83 ± 25%    +125.4%      25.17 ± 79%  interrupts.CPU215.TLB:TLB_shootdowns
      1258 ±  7%    +105.9%       2590 ± 18%     +92.0%       2415 ± 15%  interrupts.CPU216.CAL:Function_call_interrupts
    602081            -1.0%     595993            -0.3%     600305        interrupts.CPU216.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU216.MCP:Machine_check_polls
    330.67 ± 26%     -18.4%     269.67 ± 35%     -20.4%     263.33 ± 33%  interrupts.CPU216.NMI:Non-maskable_interrupts
    330.67 ± 26%     -18.4%     269.67 ± 35%     -20.4%     263.33 ± 33%  interrupts.CPU216.PMI:Performance_monitoring_interrupts
     11.17 ± 87%     -16.4%       9.33 ± 28%     -49.3%       5.67 ± 76%  interrupts.CPU216.RES:Rescheduling_interrupts
     10.00 ± 22%     +36.7%      13.67 ± 29%     -13.3%       8.67 ± 24%  interrupts.CPU216.TLB:TLB_shootdowns
      1447 ± 34%     +63.1%       2361 ± 17%     +68.5%       2439 ± 16%  interrupts.CPU217.CAL:Function_call_interrupts
    602179            -0.5%     599459            -0.3%     600489        interrupts.CPU217.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU217.MCP:Machine_check_polls
    322.33 ± 30%     -13.9%     277.67 ± 32%     -13.5%     278.83 ± 34%  interrupts.CPU217.NMI:Non-maskable_interrupts
    322.33 ± 30%     -13.9%     277.67 ± 32%     -13.5%     278.83 ± 34%  interrupts.CPU217.PMI:Performance_monitoring_interrupts
     15.83 ± 33%      -1.1%      15.67 ± 21%      +4.2%      16.50 ± 43%  interrupts.CPU217.RES:Rescheduling_interrupts
      9.33 ± 14%     +35.7%      12.67 ± 12%     +21.4%      11.33 ± 53%  interrupts.CPU217.TLB:TLB_shootdowns
      1242 ±  2%    +109.1%       2598 ± 18%     +95.2%       2425 ± 15%  interrupts.CPU218.CAL:Function_call_interrupts
    602035            -0.8%     597255            -0.4%     599799        interrupts.CPU218.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU218.MCP:Machine_check_polls
    264.33 ± 32%     -10.5%     236.67 ± 31%      +9.5%     289.50 ± 66%  interrupts.CPU218.NMI:Non-maskable_interrupts
    264.33 ± 32%     -10.5%     236.67 ± 31%      +9.5%     289.50 ± 66%  interrupts.CPU218.PMI:Performance_monitoring_interrupts
     11.00 ± 61%     -18.2%       9.00 ± 51%     -31.8%       7.50 ± 47%  interrupts.CPU218.RES:Rescheduling_interrupts
     10.83 ± 26%      -1.5%      10.67 ± 24%     +12.3%      12.17 ± 34%  interrupts.CPU218.TLB:TLB_shootdowns
      1217          +112.3%       2584 ± 18%     +99.5%       2428 ± 15%  interrupts.CPU219.CAL:Function_call_interrupts
    601775            -1.2%     594621            -0.2%     600438        interrupts.CPU219.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU219.MCP:Machine_check_polls
    245.00 ± 32%      +1.2%     247.83 ± 30%     +25.7%     308.00 ± 26%  interrupts.CPU219.NMI:Non-maskable_interrupts
    245.00 ± 32%      +1.2%     247.83 ± 30%     +25.7%     308.00 ± 26%  interrupts.CPU219.PMI:Performance_monitoring_interrupts
     14.33 ± 26%     -17.4%      11.83 ± 35%     +14.0%      16.33 ± 19%  interrupts.CPU219.RES:Rescheduling_interrupts
      9.67 ± 22%     -10.3%       8.67 ± 22%     +15.5%      11.17 ± 18%  interrupts.CPU219.TLB:TLB_shootdowns
      1667 ± 12%     +96.2%       3271 ± 26%     +62.1%       2703 ± 16%  interrupts.CPU22.CAL:Function_call_interrupts
    602206            -0.3%     600688            -0.2%     601069        interrupts.CPU22.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU22.MCP:Machine_check_polls
    339.83 ± 44%     -34.1%     224.00 ± 33%     -44.2%     189.67 ± 28%  interrupts.CPU22.NMI:Non-maskable_interrupts
    339.83 ± 44%     -34.1%     224.00 ± 33%     -44.2%     189.67 ± 28%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
     61.50 ± 47%     +47.4%      90.67 ± 18%      -9.8%      55.50 ± 23%  interrupts.CPU22.RES:Rescheduling_interrupts
     54.17 ± 41%     +30.8%      70.83 ± 15%      +6.2%      57.50 ± 31%  interrupts.CPU22.TLB:TLB_shootdowns
      1302 ± 11%     +99.8%       2602 ± 18%     +87.5%       2441 ± 15%  interrupts.CPU220.CAL:Function_call_interrupts
    602219            -0.5%     599396            -0.3%     600456        interrupts.CPU220.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU220.MCP:Machine_check_polls
    231.67 ± 29%     +11.9%     259.17 ± 32%     +12.2%     259.83 ± 33%  interrupts.CPU220.NMI:Non-maskable_interrupts
    231.67 ± 29%     +11.9%     259.17 ± 32%     +12.2%     259.83 ± 33%  interrupts.CPU220.PMI:Performance_monitoring_interrupts
      9.50 ± 17%      +3.5%       9.83 ± 21%     +10.5%      10.50 ± 25%  interrupts.CPU220.RES:Rescheduling_interrupts
     12.17 ± 23%      -6.8%      11.33 ± 37%      -2.7%      11.83 ± 25%  interrupts.CPU220.TLB:TLB_shootdowns
      1283 ±  9%    +102.1%       2593 ± 18%     +99.0%       2553 ± 18%  interrupts.CPU221.CAL:Function_call_interrupts
    602169            -0.5%     598950            -0.2%     600830        interrupts.CPU221.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU221.MCP:Machine_check_polls
    350.00 ± 27%     -12.0%     307.83 ± 33%     -22.0%     273.00 ± 36%  interrupts.CPU221.NMI:Non-maskable_interrupts
    350.00 ± 27%     -12.0%     307.83 ± 33%     -22.0%     273.00 ± 36%  interrupts.CPU221.PMI:Performance_monitoring_interrupts
     25.00 ± 39%     -41.3%      14.67 ± 40%     +25.3%      31.33 ± 68%  interrupts.CPU221.RES:Rescheduling_interrupts
     13.67 ± 69%     -24.4%      10.33 ± 30%     +20.7%      16.50 ± 97%  interrupts.CPU221.TLB:TLB_shootdowns
      1313 ± 14%     +98.5%       2608 ± 18%     +85.1%       2431 ± 15%  interrupts.CPU222.CAL:Function_call_interrupts
    602010            -0.7%     597964            -0.3%     600362        interrupts.CPU222.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU222.MCP:Machine_check_polls
    291.50 ± 30%      -4.8%     277.50 ± 31%     -34.1%     192.17 ±  3%  interrupts.CPU222.NMI:Non-maskable_interrupts
    291.50 ± 30%      -4.8%     277.50 ± 31%     -34.1%     192.17 ±  3%  interrupts.CPU222.PMI:Performance_monitoring_interrupts
     22.67 ±105%     -61.8%       8.67 ± 73%     -61.8%       8.67 ± 25%  interrupts.CPU222.RES:Rescheduling_interrupts
     11.00 ± 31%      +3.0%      11.33 ± 19%      -3.0%      10.67 ± 20%  interrupts.CPU222.TLB:TLB_shootdowns
      1316 ± 10%     +98.7%       2615 ± 18%     +99.4%       2624 ± 20%  interrupts.CPU223.CAL:Function_call_interrupts
    601882            -0.9%     596611            -0.3%     599929        interrupts.CPU223.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU223.MCP:Machine_check_polls
    289.50 ± 33%      -4.0%     278.00 ± 35%     -15.6%     244.33 ± 30%  interrupts.CPU223.NMI:Non-maskable_interrupts
    289.50 ± 33%      -4.0%     278.00 ± 35%     -15.6%     244.33 ± 30%  interrupts.CPU223.PMI:Performance_monitoring_interrupts
     21.50 ± 60%     -17.8%      17.67 ±  8%     +55.0%      33.33 ±139%  interrupts.CPU223.RES:Rescheduling_interrupts
     15.33 ± 99%     -41.3%       9.00 ± 15%     -12.0%      13.50 ± 32%  interrupts.CPU223.TLB:TLB_shootdowns
      1255 ±  7%    +105.7%       2581 ± 18%     +94.2%       2437 ± 16%  interrupts.CPU224.CAL:Function_call_interrupts
    602080            -0.8%     597410            -0.2%     600647        interrupts.CPU224.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU224.MCP:Machine_check_polls
    267.50 ± 32%      +9.7%     293.33 ± 32%      +3.1%     275.67 ± 32%  interrupts.CPU224.NMI:Non-maskable_interrupts
    267.50 ± 32%      +9.7%     293.33 ± 32%      +3.1%     275.67 ± 32%  interrupts.CPU224.PMI:Performance_monitoring_interrupts
      9.83 ±110%     -13.6%       8.50 ± 14%      +8.5%      10.67 ± 71%  interrupts.CPU224.RES:Rescheduling_interrupts
      9.83 ± 23%      +0.0%       9.83 ± 33%     +11.9%      11.00 ± 28%  interrupts.CPU224.TLB:TLB_shootdowns
      1235 ±  2%    +109.9%       2593 ± 18%     +97.3%       2436 ± 16%  interrupts.CPU225.CAL:Function_call_interrupts
    602112            -0.8%     597536            -0.2%     600684        interrupts.CPU225.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU225.MCP:Machine_check_polls
    315.00 ± 31%      -1.6%     310.00 ± 33%      -0.6%     313.00 ± 34%  interrupts.CPU225.NMI:Non-maskable_interrupts
    315.00 ± 31%      -1.6%     310.00 ± 33%      -0.6%     313.00 ± 34%  interrupts.CPU225.PMI:Performance_monitoring_interrupts
     20.00 ± 37%     -40.8%      11.83 ± 31%      -0.8%      19.83 ± 21%  interrupts.CPU225.RES:Rescheduling_interrupts
      9.67 ± 41%      -1.7%       9.50 ± 18%     +10.3%      10.67 ± 34%  interrupts.CPU225.TLB:TLB_shootdowns
      1240 ±  2%    +112.0%       2630 ± 17%     +97.3%       2447 ± 15%  interrupts.CPU226.CAL:Function_call_interrupts
    602034            -1.9%     590719 ±  2%      -0.3%     600232        interrupts.CPU226.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU226.MCP:Machine_check_polls
    396.17 ± 23%     -30.5%     275.17 ± 40%     -18.9%     321.17 ± 43%  interrupts.CPU226.NMI:Non-maskable_interrupts
    396.17 ± 23%     -30.5%     275.17 ± 40%     -18.9%     321.17 ± 43%  interrupts.CPU226.PMI:Performance_monitoring_interrupts
     10.33 ± 36%     +35.5%      14.00 ± 64%      -9.7%       9.33 ± 42%  interrupts.CPU226.RES:Rescheduling_interrupts
     11.83 ± 46%      +0.0%      11.83 ± 22%      -2.8%      11.50 ± 25%  interrupts.CPU226.TLB:TLB_shootdowns
      1137 ± 17%    +129.1%       2605 ± 18%    +114.6%       2440 ± 15%  interrupts.CPU227.CAL:Function_call_interrupts
    602142            -0.7%     597908            -0.3%     600538        interrupts.CPU227.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU227.MCP:Machine_check_polls
    322.50 ± 31%     -25.1%     241.50 ± 31%     -25.6%     239.83 ± 33%  interrupts.CPU227.NMI:Non-maskable_interrupts
    322.50 ± 31%     -25.1%     241.50 ± 31%     -25.6%     239.83 ± 33%  interrupts.CPU227.PMI:Performance_monitoring_interrupts
     15.17 ± 38%      +7.7%      16.33 ± 43%     +35.2%      20.50 ± 35%  interrupts.CPU227.RES:Rescheduling_interrupts
     12.33 ± 65%     -13.5%      10.67 ± 28%     -27.0%       9.00 ± 15%  interrupts.CPU227.TLB:TLB_shootdowns
      1264 ±  2%    +105.4%       2596 ± 18%     +96.7%       2486 ± 14%  interrupts.CPU228.CAL:Function_call_interrupts
    602191            -1.0%     595882            -0.3%     600359        interrupts.CPU228.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU228.MCP:Machine_check_polls
    295.67 ± 30%     -11.7%     261.17 ± 36%     -11.7%     261.00 ± 35%  interrupts.CPU228.NMI:Non-maskable_interrupts
    295.67 ± 30%     -11.7%     261.17 ± 36%     -11.7%     261.00 ± 35%  interrupts.CPU228.PMI:Performance_monitoring_interrupts
     11.67 ± 54%     -25.7%       8.67 ± 29%    +128.6%      26.67 ±123%  interrupts.CPU228.RES:Rescheduling_interrupts
     10.83 ± 15%     +21.5%      13.17 ± 47%      +7.7%      11.67 ± 23%  interrupts.CPU228.TLB:TLB_shootdowns
      1244 ±  2%    +109.2%       2601 ± 18%     +96.2%       2441 ± 15%  interrupts.CPU229.CAL:Function_call_interrupts
    602164            -1.2%     595212            -0.3%     600521        interrupts.CPU229.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU229.MCP:Machine_check_polls
    319.50 ± 33%     -12.3%     280.33 ± 37%     -11.3%     283.50 ± 33%  interrupts.CPU229.NMI:Non-maskable_interrupts
    319.50 ± 33%     -12.3%     280.33 ± 37%     -11.3%     283.50 ± 33%  interrupts.CPU229.PMI:Performance_monitoring_interrupts
     18.67 ± 11%      -4.5%      17.83 ± 20%      +2.7%      19.17 ± 47%  interrupts.CPU229.RES:Rescheduling_interrupts
      8.67 ± 29%     +34.6%      11.67 ± 25%     +19.2%      10.33 ± 30%  interrupts.CPU229.TLB:TLB_shootdowns
      1365 ±  7%    +111.6%       2887 ± 27%     +87.5%       2559 ± 14%  interrupts.CPU23.CAL:Function_call_interrupts
      0.67 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.IWI:IRQ_work_interrupts
    602187            -0.3%     600534            -0.1%     601286        interrupts.CPU23.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU23.MCP:Machine_check_polls
      1203 ±165%     -81.8%     219.00 ± 34%     -86.0%     168.17 ±  4%  interrupts.CPU23.NMI:Non-maskable_interrupts
      1203 ±165%     -81.8%     219.00 ± 34%     -86.0%     168.17 ±  4%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
     25.67 ± 46%     -22.1%      20.00 ± 51%     -34.4%      16.83 ± 66%  interrupts.CPU23.RES:Rescheduling_interrupts
     19.33 ± 48%     +46.6%      28.33 ± 19%      +2.6%      19.83 ± 46%  interrupts.CPU23.TLB:TLB_shootdowns
      1461 ± 26%     +83.9%       2688 ± 16%     +69.6%       2479 ± 14%  interrupts.CPU230.CAL:Function_call_interrupts
      1.00 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU230.IWI:IRQ_work_interrupts
    602175            -1.0%     596231            -0.3%     600274        interrupts.CPU230.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU230.MCP:Machine_check_polls
    342.17 ± 39%    +101.2%     688.50 ±133%     -21.7%     267.83 ± 36%  interrupts.CPU230.NMI:Non-maskable_interrupts
    342.17 ± 39%    +101.2%     688.50 ±133%     -21.7%     267.83 ± 36%  interrupts.CPU230.PMI:Performance_monitoring_interrupts
     13.50 ± 46%     -11.1%      12.00 ±149%    +119.8%      29.67 ±133%  interrupts.CPU230.RES:Rescheduling_interrupts
     11.17 ± 40%      -3.0%      10.83 ± 25%      -4.5%      10.67 ± 23%  interrupts.CPU230.TLB:TLB_shootdowns
      1245 ±  2%    +109.0%       2603 ± 18%     +96.3%       2444 ± 16%  interrupts.CPU231.CAL:Function_call_interrupts
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU231.IWI:IRQ_work_interrupts
    602177            -1.4%     593694            -0.3%     600161        interrupts.CPU231.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU231.MCP:Machine_check_polls
    368.17 ± 32%     -13.2%     319.50 ± 34%     -32.9%     247.00 ± 32%  interrupts.CPU231.NMI:Non-maskable_interrupts
    368.17 ± 32%     -13.2%     319.50 ± 34%     -32.9%     247.00 ± 32%  interrupts.CPU231.PMI:Performance_monitoring_interrupts
     15.00 ± 56%     -14.4%      12.83 ± 28%      +2.2%      15.33 ± 25%  interrupts.CPU231.RES:Rescheduling_interrupts
     13.67 ± 61%     -24.4%      10.33 ± 26%     -30.5%       9.50 ± 51%  interrupts.CPU231.TLB:TLB_shootdowns
      1242 ±  2%    +117.1%       2696 ± 16%    +105.1%       2547 ± 16%  interrupts.CPU232.CAL:Function_call_interrupts
    602054            -0.8%     597460            -0.3%     600466        interrupts.CPU232.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU232.MCP:Machine_check_polls
    278.00 ± 28%     -37.8%     172.83 ±  4%     -23.9%     211.67 ± 33%  interrupts.CPU232.NMI:Non-maskable_interrupts
    278.00 ± 28%     -37.8%     172.83 ±  4%     -23.9%     211.67 ± 33%  interrupts.CPU232.PMI:Performance_monitoring_interrupts
      9.33 ± 36%     -12.5%       8.17 ± 39%    +294.6%      36.83 ±189%  interrupts.CPU232.RES:Rescheduling_interrupts
      9.83 ± 34%      -5.1%       9.33 ± 20%     +11.9%      11.00 ± 28%  interrupts.CPU232.TLB:TLB_shootdowns
      1277 ±  8%    +105.2%       2620 ± 18%     +90.6%       2435 ± 15%  interrupts.CPU233.CAL:Function_call_interrupts
      0.50 ±223%    -100.0%       0.00          +100.0%       1.00 ±223%  interrupts.CPU233.IWI:IRQ_work_interrupts
    602031            -0.3%     600038            -0.2%     600684        interrupts.CPU233.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU233.MCP:Machine_check_polls
    281.17 ± 28%     -13.3%     243.67 ± 39%      +5.7%     297.33 ± 51%  interrupts.CPU233.NMI:Non-maskable_interrupts
    281.17 ± 28%     -13.3%     243.67 ± 39%      +5.7%     297.33 ± 51%  interrupts.CPU233.PMI:Performance_monitoring_interrupts
     18.33 ± 67%      -7.3%      17.00 ± 62%     -22.7%      14.17 ± 26%  interrupts.CPU233.RES:Rescheduling_interrupts
     13.17 ±101%     -15.2%      11.17 ± 39%     -16.5%      11.00 ± 27%  interrupts.CPU233.TLB:TLB_shootdowns
      1226          +110.8%       2586 ± 18%     +97.1%       2417 ± 15%  interrupts.CPU234.CAL:Function_call_interrupts
    602000            -0.3%     600034            -0.2%     601072        interrupts.CPU234.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU234.MCP:Machine_check_polls
    197.83 ± 33%      -2.6%     192.67 ± 34%      +8.7%     215.00 ± 35%  interrupts.CPU234.NMI:Non-maskable_interrupts
    197.83 ± 33%      -2.6%     192.67 ± 34%      +8.7%     215.00 ± 35%  interrupts.CPU234.PMI:Performance_monitoring_interrupts
     10.17 ± 30%     -11.5%       9.00 ± 45%      -9.8%       9.17 ± 42%  interrupts.CPU234.RES:Rescheduling_interrupts
     10.83 ± 28%     -12.3%       9.50 ± 19%      +3.1%      11.17 ± 12%  interrupts.CPU234.TLB:TLB_shootdowns
      1228          +113.9%       2626 ± 18%     +98.7%       2440 ± 15%  interrupts.CPU235.CAL:Function_call_interrupts
    602209            -0.3%     600521            -0.2%     600999        interrupts.CPU235.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU235.MCP:Machine_check_polls
    286.00 ± 27%     -29.3%     202.17 ± 34%     -30.4%     199.00 ± 31%  interrupts.CPU235.NMI:Non-maskable_interrupts
    286.00 ± 27%     -29.3%     202.17 ± 34%     -30.4%     199.00 ± 31%  interrupts.CPU235.PMI:Performance_monitoring_interrupts
     12.00 ± 19%     +65.3%      19.83 ± 58%     +12.5%      13.50 ± 34%  interrupts.CPU235.RES:Rescheduling_interrupts
     11.17 ± 52%     -13.4%       9.67 ± 22%     -17.9%       9.17 ± 23%  interrupts.CPU235.TLB:TLB_shootdowns
      1230          +109.6%       2579 ± 18%     +98.3%       2441 ± 15%  interrupts.CPU236.CAL:Function_call_interrupts
    601971            -0.3%     600009            -0.2%     600959        interrupts.CPU236.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU236.MCP:Machine_check_polls
    247.50 ± 31%     -24.0%     188.00 ± 23%     -23.8%     188.67 ± 31%  interrupts.CPU236.NMI:Non-maskable_interrupts
    247.50 ± 31%     -24.0%     188.00 ± 23%     -23.8%     188.67 ± 31%  interrupts.CPU236.PMI:Performance_monitoring_interrupts
      7.00 ± 45%     +21.4%       8.50 ± 37%     +23.8%       8.67 ± 19%  interrupts.CPU236.RES:Rescheduling_interrupts
      8.83 ± 12%     +18.9%      10.50 ± 22%     +47.2%      13.00 ± 25%  interrupts.CPU236.TLB:TLB_shootdowns
      1217          +113.1%       2595 ± 18%    +100.0%       2435 ± 15%  interrupts.CPU237.CAL:Function_call_interrupts
    602160            -0.3%     600330            -0.2%     600900        interrupts.CPU237.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU237.MCP:Machine_check_polls
    235.33 ± 35%     -25.5%     175.33 ±  3%     -25.1%     176.33 ±  2%  interrupts.CPU237.NMI:Non-maskable_interrupts
    235.33 ± 35%     -25.5%     175.33 ±  3%     -25.1%     176.33 ±  2%  interrupts.CPU237.PMI:Performance_monitoring_interrupts
     14.67 ± 31%     +12.5%      16.50 ± 26%      +2.3%      15.00 ± 20%  interrupts.CPU237.RES:Rescheduling_interrupts
      8.67 ± 22%     +34.6%      11.67 ± 25%     +32.7%      11.50 ± 14%  interrupts.CPU237.TLB:TLB_shootdowns
      1237          +121.1%       2735 ± 25%     +96.6%       2432 ± 15%  interrupts.CPU238.CAL:Function_call_interrupts
    602017            -0.7%     597656            -0.2%     600658        interrupts.CPU238.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU238.MCP:Machine_check_polls
    327.83 ± 27%     -41.8%     190.83 ±  5%     -21.8%     256.50 ± 37%  interrupts.CPU238.NMI:Non-maskable_interrupts
    327.83 ± 27%     -41.8%     190.83 ±  5%     -21.8%     256.50 ± 37%  interrupts.CPU238.PMI:Performance_monitoring_interrupts
      9.67 ± 57%     +96.6%      19.00 ± 97%      +3.4%      10.00 ± 47%  interrupts.CPU238.RES:Rescheduling_interrupts
      9.00 ± 11%     +16.7%      10.50 ± 42%      +5.6%       9.50 ± 16%  interrupts.CPU238.TLB:TLB_shootdowns
      1220          +112.4%       2591 ± 18%    +103.8%       2487 ± 15%  interrupts.CPU239.CAL:Function_call_interrupts
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU239.IWI:IRQ_work_interrupts
    601910            -0.2%     600486            -0.2%     600713        interrupts.CPU239.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU239.MCP:Machine_check_polls
    234.67 ± 37%     -15.5%     198.33 ± 32%      -4.7%     223.67 ± 36%  interrupts.CPU239.NMI:Non-maskable_interrupts
    234.67 ± 37%     -15.5%     198.33 ± 32%      -4.7%     223.67 ± 36%  interrupts.CPU239.PMI:Performance_monitoring_interrupts
     12.67 ± 32%      -5.3%      12.00 ± 52%      +7.9%      13.67 ± 60%  interrupts.CPU239.RES:Rescheduling_interrupts
      7.17 ± 14%     +44.2%      10.33 ± 22%     +23.3%       8.83 ± 27%  interrupts.CPU239.TLB:TLB_shootdowns
      2238 ± 63%    +182.6%       6327 ±121%     +51.9%       3400 ± 23%  interrupts.CPU24.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +3.3e+101%       0.33 ±223%  interrupts.CPU24.IWI:IRQ_work_interrupts
    602190            -0.3%     600144            -0.2%     600886        interrupts.CPU24.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU24.MCP:Machine_check_polls
    248.83 ± 34%     +34.3%     334.17 ± 20%     -22.3%     193.33 ± 14%  interrupts.CPU24.NMI:Non-maskable_interrupts
    248.83 ± 34%     +34.3%     334.17 ± 20%     -22.3%     193.33 ± 14%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
    115.00 ±119%     -46.7%      61.33 ± 36%     -42.8%      65.83 ± 32%  interrupts.CPU24.RES:Rescheduling_interrupts
     59.17 ± 40%     +12.7%      66.67 ± 29%      +9.6%      64.83 ± 18%  interrupts.CPU24.TLB:TLB_shootdowns
      1244 ±  2%    +109.1%       2602 ± 18%     +94.1%       2415 ± 15%  interrupts.CPU240.CAL:Function_call_interrupts
      0.17 ±223%    +700.0%       1.33 ±223%    +100.0%       0.33 ±223%  interrupts.CPU240.IWI:IRQ_work_interrupts
    602047            -0.3%     600169            -0.2%     600954        interrupts.CPU240.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU240.MCP:Machine_check_polls
    261.67 ± 31%    +289.7%       1019 ±187%     -12.4%     229.33 ± 41%  interrupts.CPU240.NMI:Non-maskable_interrupts
    261.67 ± 31%    +289.7%       1019 ±187%     -12.4%     229.33 ± 41%  interrupts.CPU240.PMI:Performance_monitoring_interrupts
     10.67 ± 30%      +3.1%      11.00 ± 43%     -39.1%       6.50 ± 51%  interrupts.CPU240.RES:Rescheduling_interrupts
      9.00 ± 20%     +48.1%      13.33 ± 21%     +25.9%      11.33 ± 40%  interrupts.CPU240.TLB:TLB_shootdowns
      1218          +112.2%       2585 ± 18%     +99.7%       2434 ± 15%  interrupts.CPU241.CAL:Function_call_interrupts
    602128            -0.3%     600160            -0.2%     601173        interrupts.CPU241.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU241.MCP:Machine_check_polls
    262.00 ± 31%      +8.5%     284.33 ± 31%     -17.2%     217.00 ± 40%  interrupts.CPU241.NMI:Non-maskable_interrupts
    262.00 ± 31%      +8.5%     284.33 ± 31%     -17.2%     217.00 ± 40%  interrupts.CPU241.PMI:Performance_monitoring_interrupts
     11.50 ± 25%     +15.9%      13.33 ± 31%      -2.9%      11.17 ± 28%  interrupts.CPU241.RES:Rescheduling_interrupts
      8.33 ± 22%     +44.0%      12.00 ± 59%      +2.0%       8.50 ± 31%  interrupts.CPU241.TLB:TLB_shootdowns
      1223          +112.1%       2593 ± 19%     +99.6%       2441 ± 15%  interrupts.CPU242.CAL:Function_call_interrupts
    602015            -0.3%     600163            -0.2%     600915        interrupts.CPU242.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU242.MCP:Machine_check_polls
    266.50 ± 27%      -7.0%     247.83 ± 31%     -29.6%     187.67 ± 33%  interrupts.CPU242.NMI:Non-maskable_interrupts
    266.50 ± 27%      -7.0%     247.83 ± 31%     -29.6%     187.67 ± 33%  interrupts.CPU242.PMI:Performance_monitoring_interrupts
      8.33 ± 34%     +34.0%      11.17 ± 39%     +42.0%      11.83 ± 24%  interrupts.CPU242.RES:Rescheduling_interrupts
      8.33 ± 21%     +72.0%      14.33 ± 43%     +68.0%      14.00 ± 26%  interrupts.CPU242.TLB:TLB_shootdowns
      1258 ±  7%    +105.8%       2590 ± 18%     +93.6%       2437 ± 15%  interrupts.CPU243.CAL:Function_call_interrupts
    602040            -0.4%     599899            -0.2%     600983        interrupts.CPU243.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU243.MCP:Machine_check_polls
    284.33 ± 29%     -14.4%     243.33 ± 36%     -18.1%     233.00 ± 34%  interrupts.CPU243.NMI:Non-maskable_interrupts
    284.33 ± 29%     -14.4%     243.33 ± 36%     -18.1%     233.00 ± 34%  interrupts.CPU243.PMI:Performance_monitoring_interrupts
     19.83 ± 84%     -38.7%      12.17 ± 52%     -33.6%      13.17 ± 18%  interrupts.CPU243.RES:Rescheduling_interrupts
     16.00 ±106%     -44.8%       8.83 ± 18%     -38.5%       9.83 ± 23%  interrupts.CPU243.TLB:TLB_shootdowns
      1258 ±  2%    +107.6%       2612 ± 19%     +96.1%       2467 ± 16%  interrupts.CPU244.CAL:Function_call_interrupts
    601973            -0.3%     600173            -0.2%     600755        interrupts.CPU244.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU244.MCP:Machine_check_polls
    234.33 ± 34%     -10.8%     209.00 ± 34%      +9.6%     256.83 ± 33%  interrupts.CPU244.NMI:Non-maskable_interrupts
    234.33 ± 34%     -10.8%     209.00 ± 34%      +9.6%     256.83 ± 33%  interrupts.CPU244.PMI:Performance_monitoring_interrupts
     13.83 ± 88%      -7.2%      12.83 ± 66%     -28.9%       9.83 ± 37%  interrupts.CPU244.RES:Rescheduling_interrupts
     13.17 ± 15%    +107.6%      27.33 ±102%     -20.3%      10.50 ± 31%  interrupts.CPU244.TLB:TLB_shootdowns
      1253 ±  4%    +117.5%       2725 ± 17%     +88.2%       2358 ± 21%  interrupts.CPU245.CAL:Function_call_interrupts
    601916            -0.5%     599166            -0.2%     600968        interrupts.CPU245.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU245.MCP:Machine_check_polls
    262.33 ± 34%     -19.1%     212.33 ± 32%      -5.8%     247.17 ± 33%  interrupts.CPU245.NMI:Non-maskable_interrupts
    262.33 ± 34%     -19.1%     212.33 ± 32%      -5.8%     247.17 ± 33%  interrupts.CPU245.PMI:Performance_monitoring_interrupts
     17.67 ± 45%     +63.2%      28.83 ± 64%      +2.8%      18.17 ± 50%  interrupts.CPU245.RES:Rescheduling_interrupts
     12.67 ± 52%     +22.4%      15.50 ± 43%     +19.7%      15.17 ± 46%  interrupts.CPU245.TLB:TLB_shootdowns
      1262 ±  4%    +106.1%       2601 ± 19%     +93.2%       2438 ± 15%  interrupts.CPU246.CAL:Function_call_interrupts
    602062            -0.2%     600580            -0.3%     600545        interrupts.CPU246.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU246.MCP:Machine_check_polls
    231.50 ± 37%      -0.1%     231.33 ± 35%      -2.4%     226.00 ± 34%  interrupts.CPU246.NMI:Non-maskable_interrupts
    231.50 ± 37%      -0.1%     231.33 ± 35%      -2.4%     226.00 ± 34%  interrupts.CPU246.PMI:Performance_monitoring_interrupts
     12.67 ± 58%     -22.4%       9.83 ± 31%     -15.8%      10.67 ± 83%  interrupts.CPU246.RES:Rescheduling_interrupts
     11.67 ± 31%      +7.1%      12.50 ± 22%     +28.6%      15.00 ± 49%  interrupts.CPU246.TLB:TLB_shootdowns
      1153 ± 17%    +126.5%       2611 ± 17%    +112.5%       2449 ± 15%  interrupts.CPU247.CAL:Function_call_interrupts
    602054            -0.3%     600069            -0.2%     600651        interrupts.CPU247.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU247.MCP:Machine_check_polls
    322.50 ± 27%      -2.8%     313.33 ± 26%     -23.3%     247.50 ± 37%  interrupts.CPU247.NMI:Non-maskable_interrupts
    322.50 ± 27%      -2.8%     313.33 ± 26%     -23.3%     247.50 ± 37%  interrupts.CPU247.PMI:Performance_monitoring_interrupts
     19.50 ± 18%      -6.8%      18.17 ± 35%      -4.3%      18.67 ± 27%  interrupts.CPU247.RES:Rescheduling_interrupts
      8.50 ± 20%     +41.2%      12.00 ± 56%     +43.1%      12.17 ± 61%  interrupts.CPU247.TLB:TLB_shootdowns
      1237          +109.8%       2595 ± 18%     +95.9%       2423 ± 15%  interrupts.CPU248.CAL:Function_call_interrupts
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        interrupts.CPU248.IWI:IRQ_work_interrupts
    602017            -0.3%     599952            -0.2%     600708        interrupts.CPU248.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU248.MCP:Machine_check_polls
    229.33 ± 32%      -2.8%     222.83 ± 38%      -6.5%     214.33 ± 33%  interrupts.CPU248.NMI:Non-maskable_interrupts
    229.33 ± 32%      -2.8%     222.83 ± 38%      -6.5%     214.33 ± 33%  interrupts.CPU248.PMI:Performance_monitoring_interrupts
      7.33 ± 52%      +0.0%       7.33 ± 58%     +13.6%       8.33 ± 32%  interrupts.CPU248.RES:Rescheduling_interrupts
      9.67 ± 25%      -5.2%       9.17 ± 23%     +27.6%      12.33 ± 42%  interrupts.CPU248.TLB:TLB_shootdowns
      1216          +112.2%       2582 ± 18%    +100.3%       2437 ± 15%  interrupts.CPU249.CAL:Function_call_interrupts
    602092            -0.3%     600116            -0.2%     601089        interrupts.CPU249.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU249.MCP:Machine_check_polls
    232.67 ± 33%      -9.4%     210.83 ± 30%      -2.5%     226.83 ± 39%  interrupts.CPU249.NMI:Non-maskable_interrupts
    232.67 ± 33%      -9.4%     210.83 ± 30%      -2.5%     226.83 ± 39%  interrupts.CPU249.PMI:Performance_monitoring_interrupts
     14.33 ± 28%      -8.1%      13.17 ±  9%      +8.1%      15.50 ± 30%  interrupts.CPU249.RES:Rescheduling_interrupts
      8.50 ± 20%     +11.8%       9.50 ± 15%     +17.6%      10.00 ± 21%  interrupts.CPU249.TLB:TLB_shootdowns
      1527 ± 23%     +83.6%       2804 ± 23%     +65.2%       2522 ± 15%  interrupts.CPU25.CAL:Function_call_interrupts
    602317            -0.3%     600740            -0.2%     601006        interrupts.CPU25.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU25.MCP:Machine_check_polls
    226.33 ± 39%     +14.8%     259.83 ± 34%      +9.2%     247.17 ± 43%  interrupts.CPU25.NMI:Non-maskable_interrupts
    226.33 ± 39%     +14.8%     259.83 ± 34%      +9.2%     247.17 ± 43%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
     46.83 ± 81%     -49.1%      23.83 ± 32%     -49.1%      23.83 ± 40%  interrupts.CPU25.RES:Rescheduling_interrupts
     20.67 ± 30%     +26.6%      26.17 ± 25%      +9.7%      22.67 ± 17%  interrupts.CPU25.TLB:TLB_shootdowns
      1224          +112.5%       2601 ± 18%     +99.4%       2440 ± 15%  interrupts.CPU250.CAL:Function_call_interrupts
    601980            -0.3%     600274            -0.2%     600670        interrupts.CPU250.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU250.MCP:Machine_check_polls
    173.17 ±  2%     +12.7%     195.17 ± 34%     +24.0%     214.67 ± 37%  interrupts.CPU250.NMI:Non-maskable_interrupts
    173.17 ±  2%     +12.7%     195.17 ± 34%     +24.0%     214.67 ± 37%  interrupts.CPU250.PMI:Performance_monitoring_interrupts
      7.00 ± 11%     +73.8%      12.17 ± 43%     +54.8%      10.83 ± 36%  interrupts.CPU250.RES:Rescheduling_interrupts
     10.50 ± 36%     +11.1%      11.67 ± 23%      +7.9%      11.33 ± 29%  interrupts.CPU250.TLB:TLB_shootdowns
      1221          +115.2%       2628 ± 17%     +98.8%       2428 ± 16%  interrupts.CPU251.CAL:Function_call_interrupts
    601952            -0.3%     599886            -0.2%     600808        interrupts.CPU251.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU251.MCP:Machine_check_polls
    272.50 ± 34%      -2.4%     265.83 ± 35%     -15.0%     231.50 ± 38%  interrupts.CPU251.NMI:Non-maskable_interrupts
    272.50 ± 34%      -2.4%     265.83 ± 35%     -15.0%     231.50 ± 38%  interrupts.CPU251.PMI:Performance_monitoring_interrupts
     14.83 ± 23%     +33.7%      19.83 ± 46%      +1.1%      15.00 ± 21%  interrupts.CPU251.RES:Rescheduling_interrupts
     12.00 ± 65%      -2.8%      11.67 ± 33%     -11.1%      10.67 ± 24%  interrupts.CPU251.TLB:TLB_shootdowns
      1220          +117.3%       2652 ± 18%     +98.0%       2417 ± 15%  interrupts.CPU252.CAL:Function_call_interrupts
    602062            -0.3%     600305            -0.2%     600663        interrupts.CPU252.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU252.MCP:Machine_check_polls
    285.83 ± 30%      -8.7%     261.00 ± 31%     -19.5%     230.17 ± 37%  interrupts.CPU252.NMI:Non-maskable_interrupts
    285.83 ± 30%      -8.7%     261.00 ± 31%     -19.5%     230.17 ± 37%  interrupts.CPU252.PMI:Performance_monitoring_interrupts
     11.33 ± 63%     +36.8%      15.50 ± 67%     -29.4%       8.00 ± 17%  interrupts.CPU252.RES:Rescheduling_interrupts
      7.67 ± 16%     +93.5%      14.83 ± 69%     +43.5%      11.00 ± 34%  interrupts.CPU252.TLB:TLB_shootdowns
      1252 ±  5%    +107.2%       2594 ± 18%     +93.4%       2422 ± 15%  interrupts.CPU253.CAL:Function_call_interrupts
    602075            -0.3%     599980            -0.3%     600562        interrupts.CPU253.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU253.MCP:Machine_check_polls
    262.00 ± 34%     -16.3%     219.17 ± 30%      -6.9%     244.00 ± 34%  interrupts.CPU253.NMI:Non-maskable_interrupts
    262.00 ± 34%     -16.3%     219.17 ± 30%      -6.9%     244.00 ± 34%  interrupts.CPU253.PMI:Performance_monitoring_interrupts
     15.83 ± 33%      -9.5%      14.33 ± 33%     -11.6%      14.00 ± 32%  interrupts.CPU253.RES:Rescheduling_interrupts
     12.33 ± 50%     -20.3%       9.83 ± 20%     -13.5%      10.67 ± 32%  interrupts.CPU253.TLB:TLB_shootdowns
      1221          +113.0%       2600 ± 18%     +99.6%       2437 ± 15%  interrupts.CPU254.CAL:Function_call_interrupts
    602098            -0.3%     600407            -0.2%     600768        interrupts.CPU254.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU254.MCP:Machine_check_polls
    235.50 ± 35%     -13.2%     204.33 ± 31%      +0.6%     237.00 ± 35%  interrupts.CPU254.NMI:Non-maskable_interrupts
    235.50 ± 35%     -13.2%     204.33 ± 31%      +0.6%     237.00 ± 35%  interrupts.CPU254.PMI:Performance_monitoring_interrupts
     10.50 ± 45%     +17.5%      12.33 ± 40%      +1.6%      10.67 ± 28%  interrupts.CPU254.RES:Rescheduling_interrupts
      9.67 ± 19%     +17.2%      11.33 ± 33%     +22.4%      11.83 ± 32%  interrupts.CPU254.TLB:TLB_shootdowns
      1191          +114.5%       2555 ± 18%    +102.5%       2413 ± 15%  interrupts.CPU255.CAL:Function_call_interrupts
    602105            -0.4%     599710            -0.2%     600884        interrupts.CPU255.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU255.MCP:Machine_check_polls
    619.33 ± 30%     +36.0%     842.33 ± 40%     +38.5%     858.00 ± 39%  interrupts.CPU255.NMI:Non-maskable_interrupts
    619.33 ± 30%     +36.0%     842.33 ± 40%     +38.5%     858.00 ± 39%  interrupts.CPU255.PMI:Performance_monitoring_interrupts
     11.50 ± 28%     -14.5%       9.83 ± 23%     +36.2%      15.67 ± 68%  interrupts.CPU255.RES:Rescheduling_interrupts
    146.00 ± 84%     +87.3%     273.50 ± 40%     +88.9%     275.83 ± 41%  interrupts.CPU255.TLB:TLB_shootdowns
      1794 ± 11%     +76.3%       3163 ± 18%     +58.8%       2848 ± 14%  interrupts.CPU26.CAL:Function_call_interrupts
    602211            -0.5%     599486            -0.4%     599694        interrupts.CPU26.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU26.MCP:Machine_check_polls
    238.50 ± 36%      +4.8%     249.83 ± 37%     -10.2%     214.17 ± 31%  interrupts.CPU26.NMI:Non-maskable_interrupts
    238.50 ± 36%      +4.8%     249.83 ± 37%     -10.2%     214.17 ± 31%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
     74.83 ± 42%     -21.8%      58.50 ± 28%     -18.5%      61.00 ± 26%  interrupts.CPU26.RES:Rescheduling_interrupts
     69.67 ±  8%     -17.0%      57.83 ± 25%     -17.9%      57.17 ± 27%  interrupts.CPU26.TLB:TLB_shootdowns
      1351 ±  4%    +178.1%       3759 ± 68%    +249.7%       4727 ± 93%  interrupts.CPU27.CAL:Function_call_interrupts
    602331            -1.3%     594391            -0.2%     600867        interrupts.CPU27.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU27.MCP:Machine_check_polls
    285.67 ± 34%     +74.3%     498.00 ± 99%     -24.4%     215.83 ± 31%  interrupts.CPU27.NMI:Non-maskable_interrupts
    285.67 ± 34%     +74.3%     498.00 ± 99%     -24.4%     215.83 ± 31%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
     24.33 ± 32%     -11.0%      21.67 ± 39%      +2.1%      24.83 ± 46%  interrupts.CPU27.RES:Rescheduling_interrupts
     21.83 ± 26%     +10.7%      24.17 ± 33%      -6.1%      20.50 ± 38%  interrupts.CPU27.TLB:TLB_shootdowns
      1668 ±  7%     +79.9%       3002 ± 17%    +115.2%       3590 ± 53%  interrupts.CPU28.CAL:Function_call_interrupts
    602236            -0.3%     600570            -0.2%     600992        interrupts.CPU28.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU28.MCP:Machine_check_polls
    258.50 ± 32%     +22.6%     316.83 ± 19%     -24.4%     195.33 ± 32%  interrupts.CPU28.NMI:Non-maskable_interrupts
    258.50 ± 32%     +22.6%     316.83 ± 19%     -24.4%     195.33 ± 32%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
     66.67 ± 24%     +11.2%      74.17 ± 10%    +123.2%     148.83 ±123%  interrupts.CPU28.RES:Rescheduling_interrupts
     67.00 ±  5%      +3.5%      69.33 ± 21%      +1.5%      68.00 ± 19%  interrupts.CPU28.TLB:TLB_shootdowns
      1367 ±  8%    +158.9%       3541 ± 47%    +114.1%       2928 ± 25%  interrupts.CPU29.CAL:Function_call_interrupts
    602257            -0.3%     600197            -0.2%     600954        interrupts.CPU29.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU29.MCP:Machine_check_polls
    224.00 ± 35%     +11.4%     249.50 ± 30%     -24.3%     169.50 ± 11%  interrupts.CPU29.NMI:Non-maskable_interrupts
    224.00 ± 35%     +11.4%     249.50 ± 30%     -24.3%     169.50 ± 11%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
     30.50 ± 38%      +9.3%      33.33 ± 26%    +406.0%     154.33 ±176%  interrupts.CPU29.RES:Rescheduling_interrupts
     23.50 ± 26%     +25.5%      29.50 ± 22%      -8.5%      21.50 ± 20%  interrupts.CPU29.TLB:TLB_shootdowns
      1358 ±  3%    +170.7%       3677 ± 46%    +123.2%       3032 ± 30%  interrupts.CPU3.CAL:Function_call_interrupts
      0.00         +5e+101%       0.50 ±223%    -100.0%       0.00        interrupts.CPU3.IWI:IRQ_work_interrupts
    602355            -0.2%     601130            -0.2%     601372        interrupts.CPU3.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU3.MCP:Machine_check_polls
    185.17 ± 29%      -8.7%     169.00 ±  8%     +14.7%     212.33 ± 34%  interrupts.CPU3.NMI:Non-maskable_interrupts
    185.17 ± 29%      -8.7%     169.00 ±  8%     +14.7%     212.33 ± 34%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
     35.17 ± 33%      +5.7%      37.17 ±112%     +72.0%      60.50 ±165%  interrupts.CPU3.RES:Rescheduling_interrupts
     23.33 ± 11%      -0.7%      23.17 ± 37%      -8.6%      21.33 ± 53%  interrupts.CPU3.TLB:TLB_shootdowns
      2017 ± 59%     +53.6%       3098 ± 20%     +88.8%       3808 ± 56%  interrupts.CPU30.CAL:Function_call_interrupts
    602283            -0.3%     600671            -0.2%     601055        interrupts.CPU30.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU30.MCP:Machine_check_polls
    258.33 ± 27%     +17.9%     304.67 ± 21%     -14.2%     221.67 ± 35%  interrupts.CPU30.NMI:Non-maskable_interrupts
    258.33 ± 27%     +17.9%     304.67 ± 21%     -14.2%     221.67 ± 35%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
     91.50 ±118%     -20.2%      73.00 ± 14%    +172.7%     249.50 ±142%  interrupts.CPU30.RES:Rescheduling_interrupts
     54.83 ± 45%     +19.1%      65.33 ±  3%     +18.8%      65.17 ± 26%  interrupts.CPU30.TLB:TLB_shootdowns
      1560 ± 34%     +79.8%       2805 ± 16%     +80.2%       2812 ± 22%  interrupts.CPU31.CAL:Function_call_interrupts
    602439            -0.3%     600625            -0.2%     601077        interrupts.CPU31.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU31.MCP:Machine_check_polls
    266.83 ± 30%      -6.9%     248.33 ± 33%      -2.2%     261.00 ± 40%  interrupts.CPU31.NMI:Non-maskable_interrupts
    266.83 ± 30%      -6.9%     248.33 ± 33%      -2.2%     261.00 ± 40%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
     39.17 ±102%     -22.6%      30.33 ± 36%    +104.7%      80.17 ±163%  interrupts.CPU31.RES:Rescheduling_interrupts
     18.50 ± 37%     +48.6%      27.50 ± 17%     +22.5%      22.67 ± 26%  interrupts.CPU31.TLB:TLB_shootdowns
      2385 ± 41%     +34.0%       3196 ± 31%     +23.1%       2937 ± 19%  interrupts.CPU32.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +3.3e+101%       0.33 ±223%  interrupts.CPU32.IWI:IRQ_work_interrupts
    602327            -0.3%     600413            -0.3%     600814        interrupts.CPU32.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU32.MCP:Machine_check_polls
    263.17 ± 30%      -0.8%     261.00 ± 32%    +131.6%     609.50 ±122%  interrupts.CPU32.NMI:Non-maskable_interrupts
    263.17 ± 30%      -0.8%     261.00 ± 32%    +131.6%     609.50 ±122%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
    146.17 ± 73%     -57.2%      62.50 ± 57%     -41.5%      85.50 ± 46%  interrupts.CPU32.RES:Rescheduling_interrupts
     73.17 ±  9%     -18.5%      59.67 ± 49%     -14.1%      62.83 ± 32%  interrupts.CPU32.TLB:TLB_shootdowns
      2081 ± 49%     +27.9%       2663 ± 19%     +25.0%       2602 ± 15%  interrupts.CPU33.CAL:Function_call_interrupts
    602520            -0.3%     600446            -0.2%     601312        interrupts.CPU33.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU33.MCP:Machine_check_polls
    314.33 ± 27%     -17.7%     258.83 ± 33%     -26.5%     231.17 ± 35%  interrupts.CPU33.NMI:Non-maskable_interrupts
    314.33 ± 27%     -17.7%     258.83 ± 33%     -26.5%     231.17 ± 35%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
     92.33 ± 85%     -78.9%      19.50 ± 43%     -72.9%      25.00 ± 40%  interrupts.CPU33.RES:Rescheduling_interrupts
     21.33 ± 19%     +12.5%      24.00 ± 35%      -3.9%      20.50 ± 18%  interrupts.CPU33.TLB:TLB_shootdowns
      2664 ± 73%     +14.8%       3057 ± 12%     +11.7%       2976 ± 14%  interrupts.CPU34.CAL:Function_call_interrupts
      0.17 ±223%    +200.0%       0.50 ±223%    -100.0%       0.00        interrupts.CPU34.IWI:IRQ_work_interrupts
    602049            -0.8%     596974            -0.1%     601228        interrupts.CPU34.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU34.MCP:Machine_check_polls
    405.50 ± 92%     -29.1%     287.67 ± 27%     -27.1%     295.50 ± 73%  interrupts.CPU34.NMI:Non-maskable_interrupts
    405.50 ± 92%     -29.1%     287.67 ± 27%     -27.1%     295.50 ± 73%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
     73.17 ± 44%     -13.7%      63.17 ± 42%     +15.5%      84.50 ± 28%  interrupts.CPU34.RES:Rescheduling_interrupts
     55.17 ± 47%     +22.7%      67.67 ± 43%     +21.1%      66.83 ±  6%  interrupts.CPU34.TLB:TLB_shootdowns
      1464 ± 15%    +122.7%       3260 ± 48%     +60.0%       2342        interrupts.CPU35.CAL:Function_call_interrupts
    602331            -0.3%     600579            -0.2%     601267        interrupts.CPU35.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU35.MCP:Machine_check_polls
    271.17 ± 29%      +4.3%     282.83 ± 27%     -29.7%     190.67 ± 31%  interrupts.CPU35.NMI:Non-maskable_interrupts
    271.17 ± 29%      +4.3%     282.83 ± 27%     -29.7%     190.67 ± 31%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
     32.33 ± 39%     -15.5%      27.33 ± 34%     -14.9%      27.50 ± 32%  interrupts.CPU35.RES:Rescheduling_interrupts
     21.67 ± 27%     +10.8%      24.00 ± 37%     +14.6%      24.83 ± 12%  interrupts.CPU35.TLB:TLB_shootdowns
      1686 ±  7%    +116.3%       3649 ± 47%    +116.6%       3654 ± 64%  interrupts.CPU36.CAL:Function_call_interrupts
    602170            -0.4%     599657            -0.3%     600625        interrupts.CPU36.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU36.MCP:Machine_check_polls
    252.67 ± 36%      +9.0%     275.33 ± 32%     +13.3%     286.33 ± 30%  interrupts.CPU36.NMI:Non-maskable_interrupts
    252.67 ± 36%      +9.0%     275.33 ± 32%     +13.3%     286.33 ± 30%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
     65.67 ± 21%     +10.7%      72.67 ± 15%    +253.3%     232.00 ±177%  interrupts.CPU36.RES:Rescheduling_interrupts
     69.17 ±  9%      -1.4%      68.17 ± 17%     -19.5%      55.67 ± 28%  interrupts.CPU36.TLB:TLB_shootdowns
      1367 ±  5%    +105.1%       2803 ± 17%    +147.9%       3388 ± 43%  interrupts.CPU37.CAL:Function_call_interrupts
    602248            -0.3%     600366            -0.2%     601176        interrupts.CPU37.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU37.MCP:Machine_check_polls
    265.33 ± 35%      -2.7%     258.17 ± 31%     +10.1%     292.17 ± 27%  interrupts.CPU37.NMI:Non-maskable_interrupts
    265.33 ± 35%      -2.7%     258.17 ± 31%     +10.1%     292.17 ± 27%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
     29.50 ± 35%      -5.1%      28.00 ± 26%    +183.6%      83.67 ±157%  interrupts.CPU37.RES:Rescheduling_interrupts
     20.17 ± 10%     +35.5%      27.33 ± 17%      -3.3%      19.50 ± 41%  interrupts.CPU37.TLB:TLB_shootdowns
      1539 ± 16%    +142.2%       3727 ± 46%    +112.2%       3265 ± 28%  interrupts.CPU38.CAL:Function_call_interrupts
    602376            -0.4%     599821            -0.2%     600887        interrupts.CPU38.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU38.MCP:Machine_check_polls
    364.67 ± 66%     +10.0%     401.00 ± 65%     -27.6%     264.17 ± 29%  interrupts.CPU38.NMI:Non-maskable_interrupts
    364.67 ± 66%     +10.0%     401.00 ± 65%     -27.6%     264.17 ± 29%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
     49.17 ± 64%    +119.0%     107.67 ±116%    +200.7%     147.83 ± 98%  interrupts.CPU38.RES:Rescheduling_interrupts
     43.00 ± 64%     +25.6%      54.00 ± 30%     +43.8%      61.83 ± 18%  interrupts.CPU38.TLB:TLB_shootdowns
      1286 ±  4%    +126.9%       2919 ± 32%    +116.9%       2790 ± 15%  interrupts.CPU39.CAL:Function_call_interrupts
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU39.IWI:IRQ_work_interrupts
    602260            -0.3%     600186            -0.2%     601132        interrupts.CPU39.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU39.MCP:Machine_check_polls
    242.33 ± 62%      -7.3%     224.67 ± 29%     -16.0%     203.50 ± 29%  interrupts.CPU39.NMI:Non-maskable_interrupts
    242.33 ± 62%      -7.3%     224.67 ± 29%     -16.0%     203.50 ± 29%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
     14.33 ± 52%    +246.5%      49.67 ± 95%    +233.7%      47.83 ± 84%  interrupts.CPU39.RES:Rescheduling_interrupts
     19.67 ± 52%     +35.6%      26.67 ± 48%     +25.4%      24.67 ± 24%  interrupts.CPU39.TLB:TLB_shootdowns
      1616 ±  3%     +97.5%       3192 ± 31%     +86.3%       3011 ± 12%  interrupts.CPU4.CAL:Function_call_interrupts
    601721            -0.1%     601265            -0.1%     601328        interrupts.CPU4.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU4.MCP:Machine_check_polls
    218.67 ± 36%     -10.6%     195.50 ± 42%      +9.5%     239.33 ± 34%  interrupts.CPU4.NMI:Non-maskable_interrupts
    218.67 ± 36%     -10.6%     195.50 ± 42%      +9.5%     239.33 ± 34%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
     46.67 ± 10%     +36.1%      63.50 ± 59%     +56.8%      73.17 ± 35%  interrupts.CPU4.RES:Rescheduling_interrupts
     70.83 ±  8%     -32.9%      47.50 ± 47%      +1.6%      72.00 ± 12%  interrupts.CPU4.TLB:TLB_shootdowns
      1544 ± 12%    +118.9%       3381 ± 26%    +114.4%       3312 ± 27%  interrupts.CPU40.CAL:Function_call_interrupts
      0.33 ±223%    -100.0%       0.00           -50.0%       0.17 ±223%  interrupts.CPU40.IWI:IRQ_work_interrupts
    602231            -0.7%     597843            -0.3%     600430        interrupts.CPU40.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU40.MCP:Machine_check_polls
      1286 ±175%     -81.2%     241.50 ± 33%     -68.3%     407.67 ± 86%  interrupts.CPU40.NMI:Non-maskable_interrupts
      1286 ±175%     -81.2%     241.50 ± 33%     -68.3%     407.67 ± 86%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
     54.17 ± 25%     +66.5%      90.17 ± 56%    +244.9%     186.83 ±134%  interrupts.CPU40.RES:Rescheduling_interrupts
     53.33 ± 51%     +14.4%      61.00 ± 40%      +7.5%      57.33 ± 42%  interrupts.CPU40.TLB:TLB_shootdowns
      1342 ±  3%    +126.6%       3042 ± 35%    +124.1%       3009 ± 27%  interrupts.CPU41.CAL:Function_call_interrupts
    602454            -1.3%     594876            -0.3%     600726        interrupts.CPU41.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU41.MCP:Machine_check_polls
    309.83 ± 35%      -2.6%     301.67 ± 37%      +0.1%     310.17 ± 36%  interrupts.CPU41.NMI:Non-maskable_interrupts
    309.83 ± 35%      -2.6%     301.67 ± 37%      +0.1%     310.17 ± 36%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
     27.17 ± 44%     -27.6%      19.67 ± 62%    +135.6%      64.00 ±116%  interrupts.CPU41.RES:Rescheduling_interrupts
     23.50 ± 41%     -19.1%      19.00 ± 41%      +6.4%      25.00 ± 20%  interrupts.CPU41.TLB:TLB_shootdowns
      1689 ± 14%    +169.9%       4560 ± 57%     +73.8%       2937 ± 15%  interrupts.CPU42.CAL:Function_call_interrupts
    601775            -0.4%     599323            -0.2%     600648        interrupts.CPU42.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU42.MCP:Machine_check_polls
    312.33 ± 28%     -30.4%     217.50 ± 31%     -10.5%     279.50 ± 32%  interrupts.CPU42.NMI:Non-maskable_interrupts
    312.33 ± 28%     -30.4%     217.50 ± 31%     -10.5%     279.50 ± 32%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
     50.00 ± 43%    +333.3%     216.67 ±131%     +36.3%      68.17 ± 27%  interrupts.CPU42.RES:Rescheduling_interrupts
     55.83 ± 24%     +29.9%      72.50 ± 10%     +23.0%      68.67 ±  9%  interrupts.CPU42.TLB:TLB_shootdowns
      1399 ± 16%     +95.8%       2739 ± 18%    +107.7%       2906 ± 16%  interrupts.CPU43.CAL:Function_call_interrupts
    601999            -0.6%     598143            -0.2%     600687        interrupts.CPU43.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU43.MCP:Machine_check_polls
    244.17 ± 35%      -9.3%     221.50 ± 33%     -14.5%     208.83 ± 27%  interrupts.CPU43.NMI:Non-maskable_interrupts
    244.17 ± 35%      -9.3%     221.50 ± 33%     -14.5%     208.83 ± 27%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
     23.50 ± 20%     +61.0%      37.83 ± 37%     +69.5%      39.83 ± 69%  interrupts.CPU43.RES:Rescheduling_interrupts
     23.50 ± 21%     +10.6%      26.00 ± 14%      +2.1%      24.00 ± 10%  interrupts.CPU43.TLB:TLB_shootdowns
      1621 ±  3%     +98.1%       3210 ± 21%     +73.2%       2807 ± 14%  interrupts.CPU44.CAL:Function_call_interrupts
    601444            -0.6%     597927            -0.1%     600847        interrupts.CPU44.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU44.MCP:Machine_check_polls
    241.67 ± 32%      -2.8%     235.00 ± 34%      -3.7%     232.83 ± 32%  interrupts.CPU44.NMI:Non-maskable_interrupts
    241.67 ± 32%      -2.8%     235.00 ± 34%      -3.7%     232.83 ± 32%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
     59.50 ± 18%     +43.1%      85.17 ± 25%     +18.8%      70.67 ± 10%  interrupts.CPU44.RES:Rescheduling_interrupts
     72.33 ±  6%      -0.7%      71.83 ±  5%      -4.8%      68.83 ± 13%  interrupts.CPU44.TLB:TLB_shootdowns
      1453 ± 11%     +96.3%       2853 ± 17%     +73.3%       2518 ± 14%  interrupts.CPU45.CAL:Function_call_interrupts
    602015            -0.5%     599221            -0.2%     600975        interrupts.CPU45.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU45.MCP:Machine_check_polls
    230.17 ± 32%      -0.1%     229.83 ± 34%      -1.0%     227.83 ± 34%  interrupts.CPU45.NMI:Non-maskable_interrupts
    230.17 ± 32%      -0.1%     229.83 ± 34%      -1.0%     227.83 ± 34%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
     26.83 ± 30%     +62.1%      43.50 ± 59%     +18.6%      31.83 ± 28%  interrupts.CPU45.RES:Rescheduling_interrupts
     21.33 ± 20%     +20.3%      25.67 ± 21%     +15.6%      24.67 ± 22%  interrupts.CPU45.TLB:TLB_shootdowns
      1631 ±  5%    +131.9%       3784 ± 70%    +212.4%       5097 ±101%  interrupts.CPU46.CAL:Function_call_interrupts
    602383            -0.6%     598968            -0.2%     600900        interrupts.CPU46.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU46.MCP:Machine_check_polls
    238.00 ± 34%     -11.0%     211.83 ± 30%      -4.4%     227.50 ± 34%  interrupts.CPU46.NMI:Non-maskable_interrupts
    238.00 ± 34%     -11.0%     211.83 ± 30%      -4.4%     227.50 ± 34%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
     62.17 ± 17%    +172.9%     169.67 ±145%      -3.8%      59.83 ± 46%  interrupts.CPU46.RES:Rescheduling_interrupts
     63.83 ± 19%      +3.9%      66.33 ± 24%     -12.8%      55.67 ± 41%  interrupts.CPU46.TLB:TLB_shootdowns
      1353 ±  7%    +176.6%       3743 ± 63%     +97.4%       2671 ± 16%  interrupts.CPU47.CAL:Function_call_interrupts
      0.50 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU47.IWI:IRQ_work_interrupts
    602381            -0.5%     599456            -0.2%     600992        interrupts.CPU47.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU47.MCP:Machine_check_polls
    236.00 ± 31%     +13.1%     266.83 ± 37%     +16.7%     275.33 ± 41%  interrupts.CPU47.NMI:Non-maskable_interrupts
    236.00 ± 31%     +13.1%     266.83 ± 37%     +16.7%     275.33 ± 41%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
     28.50 ± 34%    +238.0%      96.33 ±149%      +4.7%      29.83 ± 51%  interrupts.CPU47.RES:Rescheduling_interrupts
     23.17 ± 36%      -2.2%      22.67 ± 21%      +2.2%      23.67 ± 33%  interrupts.CPU47.TLB:TLB_shootdowns
      1689 ± 17%     +89.1%       3194 ± 18%     +75.9%       2972 ± 18%  interrupts.CPU48.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +3.3e+101%       0.33 ±223%  interrupts.CPU48.IWI:IRQ_work_interrupts
    602354            -0.8%     597758            -0.3%     600597        interrupts.CPU48.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU48.MCP:Machine_check_polls
    211.83 ±  5%      +9.5%     232.00 ± 21%    +350.4%     954.17 ±166%  interrupts.CPU48.NMI:Non-maskable_interrupts
    211.83 ±  5%      +9.5%     232.00 ± 21%    +350.4%     954.17 ±166%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
     55.83 ± 38%     +54.3%      86.17 ± 46%     -25.4%      41.67 ± 54%  interrupts.CPU48.RES:Rescheduling_interrupts
     57.33 ± 27%      +0.0%      57.33 ± 42%     -16.3%      48.00 ± 61%  interrupts.CPU48.TLB:TLB_shootdowns
      1365 ±  9%    +119.1%       2991 ± 35%    +139.1%       3264 ± 45%  interrupts.CPU49.CAL:Function_call_interrupts
    602392            -0.8%     597715            -0.3%     600794        interrupts.CPU49.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU49.MCP:Machine_check_polls
    236.67 ± 30%      +0.8%     238.50 ± 32%      -0.6%     235.33 ± 29%  interrupts.CPU49.NMI:Non-maskable_interrupts
    236.67 ± 30%      +0.8%     238.50 ± 32%      -0.6%     235.33 ± 29%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
     27.33 ± 52%      +0.0%      27.33 ± 83%     -23.8%      20.83 ± 51%  interrupts.CPU49.RES:Rescheduling_interrupts
     20.17 ± 23%     +20.7%      24.33 ± 34%      +0.8%      20.33 ± 48%  interrupts.CPU49.TLB:TLB_shootdowns
      1536 ± 16%     +84.0%       2827 ± 26%     +69.1%       2598 ± 12%  interrupts.CPU5.CAL:Function_call_interrupts
    602515            -0.3%     600842            -0.2%     601129        interrupts.CPU5.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU5.MCP:Machine_check_polls
    217.33 ± 36%     -12.9%     189.33 ± 32%      +8.4%     235.67 ± 32%  interrupts.CPU5.NMI:Non-maskable_interrupts
    217.33 ± 36%     -12.9%     189.33 ± 32%      +8.4%     235.67 ± 32%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
     19.17 ± 32%     -33.9%      12.67 ± 57%     +42.6%      27.33 ± 28%  interrupts.CPU5.RES:Rescheduling_interrupts
     21.17 ± 26%     -20.5%      16.83 ± 59%     +19.7%      25.33 ± 24%  interrupts.CPU5.TLB:TLB_shootdowns
      1482 ± 11%    +127.9%       3378 ± 23%     +87.1%       2774 ± 15%  interrupts.CPU50.CAL:Function_call_interrupts
    602308            -0.8%     597270            -0.3%     600701        interrupts.CPU50.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU50.MCP:Machine_check_polls
    246.00 ± 31%      -3.3%     238.00 ± 32%      +6.6%     262.17 ± 33%  interrupts.CPU50.NMI:Non-maskable_interrupts
    246.00 ± 31%      -3.3%     238.00 ± 32%      +6.6%     262.17 ± 33%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
     40.33 ± 43%    +105.4%      82.83 ± 22%     +64.0%      66.17 ± 19%  interrupts.CPU50.RES:Rescheduling_interrupts
     47.67 ± 50%     +52.8%      72.83 ±  8%     +55.2%      74.00 ±  9%  interrupts.CPU50.TLB:TLB_shootdowns
      1343 ±  6%    +137.6%       3192 ± 42%    +104.4%       2746 ± 17%  interrupts.CPU51.CAL:Function_call_interrupts
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU51.IWI:IRQ_work_interrupts
    602450            -1.0%     596399            -0.3%     600511        interrupts.CPU51.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU51.MCP:Machine_check_polls
    819.33 ±127%     -67.4%     266.83 ± 33%     -64.3%     292.50 ± 33%  interrupts.CPU51.NMI:Non-maskable_interrupts
    819.33 ±127%     -67.4%     266.83 ± 33%     -64.3%     292.50 ± 33%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
     25.67 ± 69%     +62.3%      41.67 ± 72%     +22.7%      31.50 ± 20%  interrupts.CPU51.RES:Rescheduling_interrupts
     17.00 ± 27%     +34.3%      22.83 ± 14%     +53.9%      26.17 ± 16%  interrupts.CPU51.TLB:TLB_shootdowns
      1599 ±  7%    +174.2%       4386 ± 58%     +67.3%       2676 ± 19%  interrupts.CPU52.CAL:Function_call_interrupts
    602112            -1.4%     593845            -0.3%     600162        interrupts.CPU52.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU52.MCP:Machine_check_polls
    274.83 ± 36%     -13.0%     239.17 ± 31%      -3.9%     264.00 ± 34%  interrupts.CPU52.NMI:Non-maskable_interrupts
    274.83 ± 36%     -13.0%     239.17 ± 31%      -3.9%     264.00 ± 34%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
     55.83 ± 24%    +199.4%     167.17 ±142%     +15.2%      64.33 ± 40%  interrupts.CPU52.RES:Rescheduling_interrupts
     66.83 ± 14%     -22.7%      51.67 ± 32%      -3.7%      64.33 ± 41%  interrupts.CPU52.TLB:TLB_shootdowns
      1332 ±  3%    +145.5%       3271 ± 31%     +98.3%       2642 ± 12%  interrupts.CPU53.CAL:Function_call_interrupts
    602197            -0.8%     597143            -0.2%     600924        interrupts.CPU53.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU53.MCP:Machine_check_polls
    279.17 ± 40%     -16.0%     234.50 ± 36%      -7.1%     259.33 ± 32%  interrupts.CPU53.NMI:Non-maskable_interrupts
    279.17 ± 40%     -16.0%     234.50 ± 36%      -7.1%     259.33 ± 32%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
     22.50 ± 16%     +95.6%      44.00 ±125%     +20.0%      27.00 ± 59%  interrupts.CPU53.RES:Rescheduling_interrupts
     22.33 ± 19%     -14.2%      19.17 ± 36%     -20.1%      17.83 ± 30%  interrupts.CPU53.TLB:TLB_shootdowns
      1571 ±  7%    +107.5%       3260 ± 15%     +79.5%       2820 ± 17%  interrupts.CPU54.CAL:Function_call_interrupts
    602229            -1.4%     593760            -0.3%     600537        interrupts.CPU54.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU54.MCP:Machine_check_polls
    244.50 ± 30%      +0.8%     246.50 ± 36%     +24.3%     303.83 ± 33%  interrupts.CPU54.NMI:Non-maskable_interrupts
    244.50 ± 30%      +0.8%     246.50 ± 36%     +24.3%     303.83 ± 33%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
     58.33 ± 40%     +79.1%     104.50 ± 66%      +0.9%      58.83 ± 48%  interrupts.CPU54.RES:Rescheduling_interrupts
     67.00 ± 24%      -3.5%      64.67 ± 21%      -3.7%      64.50 ± 36%  interrupts.CPU54.TLB:TLB_shootdowns
      1356 ±  3%     +96.9%       2670 ± 26%     +89.0%       2562 ± 15%  interrupts.CPU55.CAL:Function_call_interrupts
    602237            -0.8%     597549            -0.2%     600832        interrupts.CPU55.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU55.MCP:Machine_check_polls
    309.17 ± 32%     -23.3%     237.00 ± 34%     -23.7%     236.00 ± 33%  interrupts.CPU55.NMI:Non-maskable_interrupts
    309.17 ± 32%     -23.3%     237.00 ± 34%     -23.7%     236.00 ± 33%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
     28.33 ± 29%     +32.9%      37.67 ±101%      +7.6%      30.50 ± 35%  interrupts.CPU55.RES:Rescheduling_interrupts
     20.50 ± 15%     +23.6%      25.33 ± 15%      +8.9%      22.33 ± 30%  interrupts.CPU55.TLB:TLB_shootdowns
      1510 ±  8%     +94.5%       2937 ± 19%     +91.1%       2886 ± 16%  interrupts.CPU56.CAL:Function_call_interrupts
    602347            -1.2%     595396            -0.3%     600798        interrupts.CPU56.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU56.MCP:Machine_check_polls
    282.33 ± 38%     +28.7%     363.50 ± 77%     -17.1%     234.00 ± 32%  interrupts.CPU56.NMI:Non-maskable_interrupts
    282.33 ± 38%     +28.7%     363.50 ± 77%     -17.1%     234.00 ± 32%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
     48.00 ± 34%     +21.2%      58.17 ± 40%     +56.6%      75.17 ± 21%  interrupts.CPU56.RES:Rescheduling_interrupts
    112.33 ±105%     -44.7%      62.17 ± 36%     -41.4%      65.83 ± 19%  interrupts.CPU56.TLB:TLB_shootdowns
      1406 ±  2%    +105.0%       2884 ± 21%     +78.6%       2512 ± 14%  interrupts.CPU57.CAL:Function_call_interrupts
    602359            -0.8%     597382            -0.3%     600495        interrupts.CPU57.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU57.MCP:Machine_check_polls
    311.83 ± 34%     -25.0%     233.83 ± 32%     -26.1%     230.50 ± 30%  interrupts.CPU57.NMI:Non-maskable_interrupts
    311.83 ± 34%     -25.0%     233.83 ± 32%     -26.1%     230.50 ± 30%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
     24.50 ± 39%     +57.1%      38.50 ± 76%      +8.2%      26.50 ± 33%  interrupts.CPU57.RES:Rescheduling_interrupts
     20.50 ± 30%      +8.1%      22.17 ± 35%     +10.6%      22.67 ±  9%  interrupts.CPU57.TLB:TLB_shootdowns
      1587 ±  5%     +87.2%       2971 ± 13%     +73.4%       2751 ± 18%  interrupts.CPU58.CAL:Function_call_interrupts
    602046            -0.7%     598051            -0.2%     600750        interrupts.CPU58.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU58.MCP:Machine_check_polls
    244.00 ± 32%      -4.1%     234.00 ± 31%     +30.1%     317.50 ± 63%  interrupts.CPU58.NMI:Non-maskable_interrupts
    244.00 ± 32%      -4.1%     234.00 ± 31%     +30.1%     317.50 ± 63%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
     54.33 ± 24%     +33.7%      72.67 ± 36%     +29.8%      70.50 ± 14%  interrupts.CPU58.RES:Rescheduling_interrupts
     67.17 ± 17%      +7.7%      72.33 ± 13%      -4.7%      64.00 ± 16%  interrupts.CPU58.TLB:TLB_shootdowns
      1357 ±  4%    +109.4%       2843 ± 22%     +86.2%       2528 ± 13%  interrupts.CPU59.CAL:Function_call_interrupts
    602317            -0.8%     597756            -0.3%     600671        interrupts.CPU59.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU59.MCP:Machine_check_polls
    207.83 ±  4%     +12.3%     233.33 ± 30%      +8.7%     225.83 ± 32%  interrupts.CPU59.NMI:Non-maskable_interrupts
    207.83 ±  4%     +12.3%     233.33 ± 30%      +8.7%     225.83 ± 32%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
     33.33 ± 11%      -5.0%      31.67 ± 35%      -4.5%      31.83 ± 24%  interrupts.CPU59.RES:Rescheduling_interrupts
     22.17 ± 36%     +15.0%      25.50 ± 29%     +27.1%      28.17 ± 28%  interrupts.CPU59.TLB:TLB_shootdowns
      1733 ± 16%     +85.0%       3207 ± 26%     +77.0%       3068 ± 16%  interrupts.CPU6.CAL:Function_call_interrupts
    602206            -0.2%     601106            -0.2%     601106        interrupts.CPU6.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU6.MCP:Machine_check_polls
    252.00 ± 33%     -25.3%     188.33 ± 34%     -22.8%     194.67 ± 32%  interrupts.CPU6.NMI:Non-maskable_interrupts
    252.00 ± 33%     -25.3%     188.33 ± 34%     -22.8%     194.67 ± 32%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
     59.67 ± 37%     +29.6%      77.33 ± 50%     +51.7%      90.50 ± 20%  interrupts.CPU6.RES:Rescheduling_interrupts
     62.17 ± 27%      -0.8%      61.67 ± 28%     +45.6%      90.50 ± 24%  interrupts.CPU6.TLB:TLB_shootdowns
      1635 ±  7%     +90.7%       3119 ± 22%    +185.7%       4673 ± 88%  interrupts.CPU60.CAL:Function_call_interrupts
    602170            -1.3%     594532            -0.3%     600571        interrupts.CPU60.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU60.MCP:Machine_check_polls
    272.33 ± 34%      +2.1%     278.17 ± 37%     -12.5%     238.17 ± 32%  interrupts.CPU60.NMI:Non-maskable_interrupts
    272.33 ± 34%      +2.1%     278.17 ± 37%     -12.5%     238.17 ± 32%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
     55.50 ± 16%     +29.4%      71.83 ± 56%     +18.0%      65.50 ± 43%  interrupts.CPU60.RES:Rescheduling_interrupts
     69.00 ±  9%      -6.0%      64.83 ± 25%     -22.7%      53.33 ± 43%  interrupts.CPU60.TLB:TLB_shootdowns
      1377 ±  7%    +103.8%       2806 ± 23%     +98.3%       2731 ± 20%  interrupts.CPU61.CAL:Function_call_interrupts
    602158            -0.9%     596914            -0.3%     600334        interrupts.CPU61.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU61.MCP:Machine_check_polls
    300.50 ± 33%     -21.0%     237.50 ± 29%     -21.9%     234.67 ± 30%  interrupts.CPU61.NMI:Non-maskable_interrupts
    300.50 ± 33%     -21.0%     237.50 ± 29%     -21.9%     234.67 ± 30%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
     22.33 ± 20%     +40.3%      31.33 ± 26%      -1.5%      22.00 ± 42%  interrupts.CPU61.RES:Rescheduling_interrupts
     20.67 ± 24%     +25.8%      26.00 ± 26%      +9.7%      22.67 ± 32%  interrupts.CPU61.TLB:TLB_shootdowns
      1354 ±  2%    +121.5%       2998 ± 35%     +98.4%       2686 ± 15%  interrupts.CPU62.CAL:Function_call_interrupts
    602197            -1.1%     595430            -0.3%     600437        interrupts.CPU62.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU62.MCP:Machine_check_polls
    282.83 ± 35%     -26.6%     207.50 ±  2%      +8.4%     306.50 ± 32%  interrupts.CPU62.NMI:Non-maskable_interrupts
    282.83 ± 35%     -26.6%     207.50 ±  2%      +8.4%     306.50 ± 32%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
     35.17 ± 26%     -16.1%      29.50 ± 38%      +0.9%      35.50 ± 19%  interrupts.CPU62.RES:Rescheduling_interrupts
     27.83 ± 25%      +7.8%      30.00 ± 30%      +6.0%      29.50 ± 15%  interrupts.CPU62.TLB:TLB_shootdowns
     11991           +10.1%      13197 ±  3%      +9.6%      13141 ±  3%  interrupts.CPU63.CAL:Function_call_interrupts
    602466            -0.9%     597001            -0.3%     600711        interrupts.CPU63.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU63.MCP:Machine_check_polls
    412.33 ± 41%     -41.6%     240.67 ± 34%     -27.5%     298.83 ± 31%  interrupts.CPU63.NMI:Non-maskable_interrupts
    412.33 ± 41%     -41.6%     240.67 ± 34%     -27.5%     298.83 ± 31%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
     44.83 ± 32%     -12.3%      39.33 ± 36%      +8.6%      48.67 ± 31%  interrupts.CPU63.RES:Rescheduling_interrupts
     52.67 ± 44%     -33.2%      35.17 ± 30%     -32.0%      35.83 ± 22%  interrupts.CPU63.TLB:TLB_shootdowns
      1222          +119.8%       2688 ± 23%     +97.9%       2420 ± 15%  interrupts.CPU64.CAL:Function_call_interrupts
    602097            -0.7%     597603            -0.3%     600470        interrupts.CPU64.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU64.MCP:Machine_check_polls
    226.50 ± 28%     +38.6%     314.00 ± 31%      +1.6%     230.17 ± 28%  interrupts.CPU64.NMI:Non-maskable_interrupts
    226.50 ± 28%     +38.6%     314.00 ± 31%      +1.6%     230.17 ± 28%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
     15.00 ± 45%     -35.6%       9.67 ± 48%     -34.4%       9.83 ± 51%  interrupts.CPU64.RES:Rescheduling_interrupts
      7.33 ± 23%     +43.2%      10.50 ± 70%      +6.8%       7.83 ±  8%  interrupts.CPU64.TLB:TLB_shootdowns
      1274 ±  7%    +117.1%       2765 ± 29%     +93.7%       2468 ± 14%  interrupts.CPU65.CAL:Function_call_interrupts
    601382            -1.0%     595563            -0.1%     600506        interrupts.CPU65.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU65.MCP:Machine_check_polls
    220.33 ± 25%     +33.9%     295.00 ± 31%      +6.0%     233.50 ± 30%  interrupts.CPU65.NMI:Non-maskable_interrupts
    220.33 ± 25%     +33.9%     295.00 ± 31%      +6.0%     233.50 ± 30%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
      7.83 ± 35%     +25.5%       9.83 ± 32%     +17.0%       9.17 ± 28%  interrupts.CPU65.RES:Rescheduling_interrupts
      8.33 ± 36%     -16.0%       7.00 ± 11%     +14.0%       9.50 ± 68%  interrupts.CPU65.TLB:TLB_shootdowns
      1266 ±  3%    +139.5%       3034 ± 35%    +114.1%       2712 ± 18%  interrupts.CPU66.CAL:Function_call_interrupts
    602349            -0.8%     597737            -0.3%     600583        interrupts.CPU66.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU66.MCP:Machine_check_polls
    262.50 ± 33%      +0.3%     263.17 ± 33%     +13.1%     296.83 ± 33%  interrupts.CPU66.NMI:Non-maskable_interrupts
    262.50 ± 33%      +0.3%     263.17 ± 33%     +13.1%     296.83 ± 33%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
     15.83 ± 40%    +140.0%      38.00 ±106%     +44.2%      22.83 ±101%  interrupts.CPU66.RES:Rescheduling_interrupts
     14.00 ± 20%     +17.9%      16.50 ± 41%     +29.8%      18.17 ± 62%  interrupts.CPU66.TLB:TLB_shootdowns
      1402 ± 25%     +95.5%       2741 ± 18%     +81.5%       2544 ± 17%  interrupts.CPU67.CAL:Function_call_interrupts
    602218            -1.0%     596400            -0.2%     600928        interrupts.CPU67.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU67.MCP:Machine_check_polls
    260.83 ± 36%      -2.0%     255.50 ± 33%     -10.5%     233.33 ± 32%  interrupts.CPU67.NMI:Non-maskable_interrupts
    260.83 ± 36%      -2.0%     255.50 ± 33%     -10.5%     233.33 ± 32%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
     13.83 ± 46%      +7.2%      14.83 ± 36%      -3.6%      13.33 ± 28%  interrupts.CPU67.RES:Rescheduling_interrupts
     12.33 ± 26%      +4.1%      12.83 ± 23%      +6.8%      13.17 ± 43%  interrupts.CPU67.TLB:TLB_shootdowns
      1294 ±  2%    +129.5%       2970 ± 39%     +92.9%       2497 ± 14%  interrupts.CPU68.CAL:Function_call_interrupts
    602213            -0.6%     598646            -0.2%     601118        interrupts.CPU68.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU68.MCP:Machine_check_polls
    261.33 ± 35%     -21.4%     205.33 ± 37%     -14.4%     223.67 ± 36%  interrupts.CPU68.NMI:Non-maskable_interrupts
    261.33 ± 35%     -21.4%     205.33 ± 37%     -14.4%     223.67 ± 36%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
     18.00 ± 28%     -45.4%       9.83 ± 38%      +2.8%      18.50 ± 30%  interrupts.CPU68.RES:Rescheduling_interrupts
     27.33 ± 82%     -54.9%      12.33 ± 30%     -40.9%      16.17 ± 18%  interrupts.CPU68.TLB:TLB_shootdowns
      1267 ±  4%    +111.0%       2673 ± 21%     +92.2%       2436 ± 16%  interrupts.CPU69.CAL:Function_call_interrupts
    602232            -0.4%     599893            -0.2%     600969        interrupts.CPU69.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU69.MCP:Machine_check_polls
    230.00 ± 36%      -4.6%     219.50 ± 32%     -16.3%     192.50 ± 29%  interrupts.CPU69.NMI:Non-maskable_interrupts
    230.00 ± 36%      -4.6%     219.50 ± 32%     -16.3%     192.50 ± 29%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
     16.67 ± 44%     +65.0%      27.50 ±136%     -27.0%      12.17 ± 50%  interrupts.CPU69.RES:Rescheduling_interrupts
     11.33 ± 14%     +11.8%      12.67 ± 31%     +14.7%      13.00 ± 25%  interrupts.CPU69.TLB:TLB_shootdowns
      1473 ± 15%    +111.8%       3120 ± 35%     +80.7%       2661 ± 12%  interrupts.CPU7.CAL:Function_call_interrupts
    602413            -0.2%     601028            -0.2%     600986        interrupts.CPU7.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU7.MCP:Machine_check_polls
    185.67 ± 32%     -13.4%     160.83 ±  2%      -2.8%     180.50 ± 29%  interrupts.CPU7.NMI:Non-maskable_interrupts
    185.67 ± 32%     -13.4%     160.83 ±  2%      -2.8%     180.50 ± 29%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
     40.83 ± 53%     +10.2%      45.00 ± 69%     +26.9%      51.83 ± 72%  interrupts.CPU7.RES:Rescheduling_interrupts
     31.67 ± 57%     -42.1%      18.33 ± 44%     -23.7%      24.17 ± 15%  interrupts.CPU7.TLB:TLB_shootdowns
      1256 ±  3%    +114.5%       2695 ± 16%     +99.6%       2508 ± 15%  interrupts.CPU70.CAL:Function_call_interrupts
    602307            -0.5%     599049            -0.3%     600604        interrupts.CPU70.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU70.MCP:Machine_check_polls
    234.33 ± 30%     +39.3%     326.33 ± 29%     +28.1%     300.17 ± 79%  interrupts.CPU70.NMI:Non-maskable_interrupts
    234.33 ± 30%     +39.3%     326.33 ± 29%     +28.1%     300.17 ± 79%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
     14.17 ± 48%     +54.1%      21.83 ±102%      +1.2%      14.33 ± 35%  interrupts.CPU70.RES:Rescheduling_interrupts
     13.50 ± 34%    +103.7%      27.50 ± 78%      +6.2%      14.33 ± 26%  interrupts.CPU70.TLB:TLB_shootdowns
      1242 ±  2%    +109.1%       2597 ± 18%     +94.8%       2420 ± 16%  interrupts.CPU71.CAL:Function_call_interrupts
    602322            -0.5%     599562            -0.3%     600675        interrupts.CPU71.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU71.MCP:Machine_check_polls
    301.00 ± 36%     -14.0%     259.00 ± 35%     -14.7%     256.67 ± 33%  interrupts.CPU71.NMI:Non-maskable_interrupts
    301.00 ± 36%     -14.0%     259.00 ± 35%     -14.7%     256.67 ± 33%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
     15.00 ± 17%     -30.0%      10.50 ± 39%     -42.2%       8.67 ± 65%  interrupts.CPU71.RES:Rescheduling_interrupts
     11.00 ± 27%      +6.1%      11.67 ±  9%      -4.5%      10.50 ± 14%  interrupts.CPU71.TLB:TLB_shootdowns
      1247 ±  2%    +123.8%       2791 ± 28%     +96.1%       2446 ± 15%  interrupts.CPU72.CAL:Function_call_interrupts
    602179            -1.2%     594913            -0.3%     600458        interrupts.CPU72.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU72.MCP:Machine_check_polls
    310.00 ± 33%      -2.9%     301.00 ± 34%    +145.3%     760.33 ±153%  interrupts.CPU72.NMI:Non-maskable_interrupts
    310.00 ± 33%      -2.9%     301.00 ± 34%    +145.3%     760.33 ±153%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
     13.50 ± 22%      +3.7%      14.00 ± 38%     +11.1%      15.00 ± 45%  interrupts.CPU72.RES:Rescheduling_interrupts
     13.00 ± 34%     +34.6%      17.50 ± 13%      -3.8%      12.50 ± 41%  interrupts.CPU72.TLB:TLB_shootdowns
      1201 ±  2%    +118.7%       2627 ± 18%    +101.9%       2424 ± 15%  interrupts.CPU73.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +3.3e+101%       0.33 ±223%  interrupts.CPU73.IWI:IRQ_work_interrupts
    602472            -1.0%     596690            -0.6%     598752        interrupts.CPU73.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU73.MCP:Machine_check_polls
    287.17 ± 36%      -5.7%     270.67 ± 35%      -1.5%     283.00 ± 40%  interrupts.CPU73.NMI:Non-maskable_interrupts
    287.17 ± 36%      -5.7%     270.67 ± 35%      -1.5%     283.00 ± 40%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
      7.00 ± 40%    +104.8%      14.33 ± 41%    +107.1%      14.50 ± 67%  interrupts.CPU73.RES:Rescheduling_interrupts
     11.83 ± 72%      -9.9%      10.67 ± 10%     -14.1%      10.17 ± 25%  interrupts.CPU73.TLB:TLB_shootdowns
      1324 ±  5%    +115.3%       2850 ± 17%     +93.3%       2560 ± 15%  interrupts.CPU74.CAL:Function_call_interrupts
    602204            -2.6%     586671 ±  4%      -0.3%     600373        interrupts.CPU74.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU74.MCP:Machine_check_polls
    243.67 ± 31%      -3.1%     236.00 ± 32%     +26.4%     308.00 ± 34%  interrupts.CPU74.NMI:Non-maskable_interrupts
    243.67 ± 31%      -3.1%     236.00 ± 32%     +26.4%     308.00 ± 34%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
     23.67 ± 55%      -4.2%      22.67 ± 53%      -7.0%      22.00 ± 48%  interrupts.CPU74.RES:Rescheduling_interrupts
     25.83 ± 29%     -18.7%      21.00 ± 36%      +3.9%      26.83 ± 25%  interrupts.CPU74.TLB:TLB_shootdowns
      1246          +128.9%       2853 ± 30%     +98.3%       2471 ± 14%  interrupts.CPU75.CAL:Function_call_interrupts
    602217            -1.5%     593482 ±  2%      -0.3%     600634        interrupts.CPU75.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU75.MCP:Machine_check_polls
    280.67 ± 33%      -4.2%     268.83 ± 35%      -5.6%     264.83 ± 34%  interrupts.CPU75.NMI:Non-maskable_interrupts
    280.67 ± 33%      -4.2%     268.83 ± 35%      -5.6%     264.83 ± 34%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
     14.67 ± 49%     +26.1%      18.50 ± 38%     -20.5%      11.67 ± 23%  interrupts.CPU75.RES:Rescheduling_interrupts
     13.33 ± 28%      +0.0%      13.33 ± 37%     +20.0%      16.00 ± 20%  interrupts.CPU75.TLB:TLB_shootdowns
      1282 ±  3%    +105.8%       2639 ± 17%    +102.2%       2592 ± 24%  interrupts.CPU76.CAL:Function_call_interrupts
    602290            -1.4%     594006            -0.3%     600457        interrupts.CPU76.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU76.MCP:Machine_check_polls
    314.50 ± 34%      -3.4%     303.83 ± 32%     -14.0%     270.33 ± 35%  interrupts.CPU76.NMI:Non-maskable_interrupts
    314.50 ± 34%      -3.4%     303.83 ± 32%     -14.0%     270.33 ± 35%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
     16.50 ± 51%     +15.2%      19.00 ± 55%    +654.5%     124.50 ±193%  interrupts.CPU76.RES:Rescheduling_interrupts
     13.33 ± 24%      -5.0%      12.67 ± 30%     +22.5%      16.33 ± 29%  interrupts.CPU76.TLB:TLB_shootdowns
      1250 ±  3%    +117.1%       2715 ± 17%     +94.3%       2429 ± 15%  interrupts.CPU77.CAL:Function_call_interrupts
    602138            -1.8%     591565 ±  2%      -0.3%     600386        interrupts.CPU77.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU77.MCP:Machine_check_polls
    283.67 ± 37%     +10.2%     312.67 ± 29%     -10.0%     255.33 ± 32%  interrupts.CPU77.NMI:Non-maskable_interrupts
    283.67 ± 37%     +10.2%     312.67 ± 29%     -10.0%     255.33 ± 32%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
     11.83 ± 46%      +9.9%      13.00 ± 40%      -8.5%      10.83 ± 24%  interrupts.CPU77.RES:Rescheduling_interrupts
     13.00 ± 35%     -14.1%      11.17 ± 20%     -23.1%      10.00 ± 20%  interrupts.CPU77.TLB:TLB_shootdowns
      1336 ± 14%     +83.5%       2452 ± 28%     +91.0%       2553 ± 20%  interrupts.CPU78.CAL:Function_call_interrupts
    602118            -1.0%     596094            -0.2%     600638        interrupts.CPU78.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU78.MCP:Machine_check_polls
    315.67 ± 32%      +6.1%     335.00 ± 25%     -12.2%     277.17 ± 34%  interrupts.CPU78.NMI:Non-maskable_interrupts
    315.67 ± 32%      +6.1%     335.00 ± 25%     -12.2%     277.17 ± 34%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
     29.00 ± 87%     -48.9%      14.83 ± 52%      -3.4%      28.00 ± 88%  interrupts.CPU78.RES:Rescheduling_interrupts
     15.50 ± 17%      -2.2%      15.17 ± 19%      +3.2%      16.00 ± 21%  interrupts.CPU78.TLB:TLB_shootdowns
      1289 ±  4%    +103.9%       2629 ± 17%     +89.5%       2443 ± 15%  interrupts.CPU79.CAL:Function_call_interrupts
    602079            -1.8%     591213 ±  2%      -0.3%     599981        interrupts.CPU79.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU79.MCP:Machine_check_polls
    327.33 ± 32%      +0.2%     327.83 ± 33%     -11.3%     290.33 ± 34%  interrupts.CPU79.NMI:Non-maskable_interrupts
    327.33 ± 32%      +0.2%     327.83 ± 33%     -11.3%     290.33 ± 34%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
     18.50 ± 38%    +108.1%      38.50 ±176%     -41.4%      10.83 ± 44%  interrupts.CPU79.RES:Rescheduling_interrupts
     13.33 ± 34%     -16.2%      11.17 ± 22%      -3.8%      12.83 ± 30%  interrupts.CPU79.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.18:IR-IO-APIC.18-fasteoi.ehci_hcd:usb1,ehci_hcd:usb2,i801_smbus
      1692 ± 17%    +118.2%       3691 ± 45%    +399.8%       8458 ±131%  interrupts.CPU8.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  interrupts.CPU8.IWI:IRQ_work_interrupts
    602202            -0.3%     600673            -0.2%     601148        interrupts.CPU8.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU8.MCP:Machine_check_polls
    212.00 ± 34%     -15.3%     179.67 ±  3%    +258.6%     760.33 ±152%  interrupts.CPU8.NMI:Non-maskable_interrupts
    212.00 ± 34%     -15.3%     179.67 ±  3%    +258.6%     760.33 ±152%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
     40.00 ± 32%    +101.2%      80.50 ± 25%     +48.3%      59.33 ± 49%  interrupts.CPU8.RES:Rescheduling_interrupts
     67.83 ± 22%      +5.4%      71.50 ±  7%     -27.0%      49.50 ± 57%  interrupts.CPU8.TLB:TLB_shootdowns
      1208 ± 14%    +140.2%       2902 ± 23%    +105.3%       2480 ± 15%  interrupts.CPU80.CAL:Function_call_interrupts
    602122            -1.5%     592870            -0.3%     600021        interrupts.CPU80.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU80.MCP:Machine_check_polls
    282.17 ± 34%      -7.4%     261.33 ± 29%      +0.8%     284.50 ± 36%  interrupts.CPU80.NMI:Non-maskable_interrupts
    282.17 ± 34%      -7.4%     261.33 ± 29%      +0.8%     284.50 ± 36%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
     19.33 ± 38%    +105.2%      39.67 ±160%     -19.8%      15.50 ± 29%  interrupts.CPU80.RES:Rescheduling_interrupts
     12.17 ± 32%     +34.2%      16.33 ± 19%     +39.7%      17.00 ± 10%  interrupts.CPU80.TLB:TLB_shootdowns
      1278 ±  9%    +132.0%       2966 ± 19%    +101.4%       2576 ± 21%  interrupts.CPU81.CAL:Function_call_interrupts
    602228            -0.9%     596509            -0.3%     600441        interrupts.CPU81.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU81.MCP:Machine_check_polls
    310.50 ± 32%     +11.7%     346.83 ± 29%     -24.1%     235.67 ± 33%  interrupts.CPU81.NMI:Non-maskable_interrupts
    310.50 ± 32%     +11.7%     346.83 ± 29%     -24.1%     235.67 ± 33%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
     11.83 ± 93%     +26.8%      15.00 ± 87%    +136.6%      28.00 ± 70%  interrupts.CPU81.RES:Rescheduling_interrupts
      7.83 ± 20%     +48.9%      11.67 ± 18%     +66.0%      13.00 ± 27%  interrupts.CPU81.TLB:TLB_shootdowns
      1380 ±  9%     +98.8%       2744 ± 16%     +78.8%       2468 ± 14%  interrupts.CPU82.CAL:Function_call_interrupts
    602316            -0.8%     597548            -0.3%     600803        interrupts.CPU82.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU82.MCP:Machine_check_polls
    317.00 ± 33%      +3.6%     328.33 ± 20%     -43.3%     179.67 ±  2%  interrupts.CPU82.NMI:Non-maskable_interrupts
    317.00 ± 33%      +3.6%     328.33 ± 20%     -43.3%     179.67 ±  2%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
     19.83 ± 50%     -29.4%      14.00 ± 52%     -37.8%      12.33 ± 30%  interrupts.CPU82.RES:Rescheduling_interrupts
     17.83 ± 41%      +5.6%      18.83 ± 30%     -20.6%      14.17 ± 16%  interrupts.CPU82.TLB:TLB_shootdowns
      1276 ±  8%    +105.1%       2617 ± 17%    +110.9%       2691 ± 22%  interrupts.CPU83.CAL:Function_call_interrupts
    602154            -0.9%     596951            -0.3%     600559        interrupts.CPU83.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU83.MCP:Machine_check_polls
    241.83 ± 30%     +39.5%     337.33 ± 26%     -16.1%     202.83 ±  3%  interrupts.CPU83.NMI:Non-maskable_interrupts
    241.83 ± 30%     +39.5%     337.33 ± 26%     -16.1%     202.83 ±  3%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
     15.67 ± 71%     -25.5%      11.67 ± 73%     +41.5%      22.17 ± 80%  interrupts.CPU83.RES:Rescheduling_interrupts
     13.33 ± 67%      +1.2%      13.50 ± 39%     +46.2%      19.50 ± 95%  interrupts.CPU83.TLB:TLB_shootdowns
      1274 ±  2%    +114.1%       2727 ± 23%     +94.5%       2478 ± 14%  interrupts.CPU84.CAL:Function_call_interrupts
      0.00       +1.2e+102%       1.17 ±223%    -100.0%       0.00        interrupts.CPU84.IWI:IRQ_work_interrupts
    601433            -1.1%     594890            -0.2%     600215        interrupts.CPU84.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU84.MCP:Machine_check_polls
    280.67 ± 33%     +25.8%     353.17 ± 33%      -3.7%     270.33 ± 35%  interrupts.CPU84.NMI:Non-maskable_interrupts
    280.67 ± 33%     +25.8%     353.17 ± 33%      -3.7%     270.33 ± 35%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
     15.67 ± 37%      +2.1%      16.00 ± 25%     +11.7%      17.50 ± 32%  interrupts.CPU84.RES:Rescheduling_interrupts
     14.83 ± 31%      -3.4%      14.33 ± 16%      -2.2%      14.50 ± 10%  interrupts.CPU84.TLB:TLB_shootdowns
      1288 ±  6%    +101.5%       2596 ± 17%     +88.3%       2426 ± 15%  interrupts.CPU85.CAL:Function_call_interrupts
    602121            -1.2%     595075            -0.3%     600429        interrupts.CPU85.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU85.MCP:Machine_check_polls
    270.83 ± 34%      +7.3%     290.67 ± 46%      +9.0%     295.33 ± 36%  interrupts.CPU85.NMI:Non-maskable_interrupts
    270.83 ± 34%      +7.3%     290.67 ± 46%      +9.0%     295.33 ± 36%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
     18.00 ± 68%     -42.6%      10.33 ± 21%     -34.3%      11.83 ± 24%  interrupts.CPU85.RES:Rescheduling_interrupts
     16.50 ±105%     -36.4%      10.50 ± 25%     -42.4%       9.50 ± 23%  interrupts.CPU85.TLB:TLB_shootdowns
      1212 ± 17%    +129.2%       2778 ± 18%    +100.5%       2429 ± 16%  interrupts.CPU86.CAL:Function_call_interrupts
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU86.IWI:IRQ_work_interrupts
    602087            -0.5%     599338            -0.2%     600809        interrupts.CPU86.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU86.MCP:Machine_check_polls
    310.33 ± 30%      -6.1%     291.50 ± 29%     -26.4%     228.50 ± 37%  interrupts.CPU86.NMI:Non-maskable_interrupts
    310.33 ± 30%      -6.1%     291.50 ± 29%     -26.4%     228.50 ± 37%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
     18.00 ± 64%     +13.0%      20.33 ± 18%     -62.0%       6.83 ± 62%  interrupts.CPU86.RES:Rescheduling_interrupts
     16.83 ± 34%      +5.0%      17.67 ± 28%     -17.8%      13.83 ± 51%  interrupts.CPU86.TLB:TLB_shootdowns
      1242 ±  2%    +111.6%       2628 ± 17%    +106.1%       2560 ± 17%  interrupts.CPU87.CAL:Function_call_interrupts
    601988            -0.4%     599704            -0.2%     600859        interrupts.CPU87.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU87.MCP:Machine_check_polls
    273.83 ± 26%      +3.5%     283.50 ± 29%     -37.1%     172.17 ±  2%  interrupts.CPU87.NMI:Non-maskable_interrupts
    273.83 ± 26%      +3.5%     283.50 ± 29%     -37.1%     172.17 ±  2%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
     10.17 ± 38%     -16.4%       8.50 ± 21%     -18.0%       8.33 ± 49%  interrupts.CPU87.RES:Rescheduling_interrupts
     10.67 ± 21%      +6.3%      11.33 ± 14%     -15.6%       9.00 ± 21%  interrupts.CPU87.TLB:TLB_shootdowns
      1379 ± 11%     +82.8%       2520 ± 22%     +79.3%       2472 ± 15%  interrupts.CPU88.CAL:Function_call_interrupts
    602188            -0.9%     596539            -0.3%     600101        interrupts.CPU88.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU88.MCP:Machine_check_polls
    287.50 ± 31%     +22.8%     353.00 ± 26%     -22.8%     221.83 ± 13%  interrupts.CPU88.NMI:Non-maskable_interrupts
    287.50 ± 31%     +22.8%     353.00 ± 26%     -22.8%     221.83 ± 13%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
     30.17 ± 99%     -59.7%      12.17 ± 35%     -48.1%      15.67 ± 25%  interrupts.CPU88.RES:Rescheduling_interrupts
     12.50 ± 31%      +5.3%      13.17 ± 24%     +37.3%      17.17 ± 32%  interrupts.CPU88.TLB:TLB_shootdowns
      1309 ± 10%    +102.4%       2650 ± 20%     +86.7%       2444 ± 15%  interrupts.CPU89.CAL:Function_call_interrupts
    602215            -0.6%     598750            -0.2%     600994        interrupts.CPU89.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU89.MCP:Machine_check_polls
    266.67 ± 35%      +5.4%     281.00 ± 31%     -26.3%     196.50 ±  3%  interrupts.CPU89.NMI:Non-maskable_interrupts
    266.67 ± 35%      +5.4%     281.00 ± 31%     -26.3%     196.50 ±  3%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
     14.50 ± 27%     -26.4%      10.67 ± 21%     -23.0%      11.17 ± 38%  interrupts.CPU89.RES:Rescheduling_interrupts
      9.00 ± 16%     +11.1%      10.00 ± 23%     +16.7%      10.50 ± 21%  interrupts.CPU89.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU9.41:IR-PCI-MSI.327680-edge.xhci_hcd
      1389 ±  4%    +171.8%       3776 ± 68%     +87.8%       2608 ± 13%  interrupts.CPU9.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +3.3e+101%       0.33 ±223%  interrupts.CPU9.IWI:IRQ_work_interrupts
    602250            -0.2%     600823            -0.4%     600081        interrupts.CPU9.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU9.MCP:Machine_check_polls
    235.67 ± 35%      -3.7%     226.83 ± 34%     +16.5%     274.67 ± 35%  interrupts.CPU9.NMI:Non-maskable_interrupts
    235.67 ± 35%      -3.7%     226.83 ± 34%     +16.5%     274.67 ± 35%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
     27.67 ± 38%     -28.9%      19.67 ± 35%      -2.4%      27.00 ± 45%  interrupts.CPU9.RES:Rescheduling_interrupts
     23.67 ± 28%     -14.1%      20.33 ± 25%     +21.8%      28.83 ± 85%  interrupts.CPU9.TLB:TLB_shootdowns
      1328 ±  7%     +98.4%       2636 ± 19%     +83.8%       2442 ± 15%  interrupts.CPU90.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+101%       0.17 ±223%  interrupts.CPU90.IWI:IRQ_work_interrupts
    602308            -2.6%     586910 ±  3%      -1.6%     592905 ±  3%  interrupts.CPU90.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU90.MCP:Machine_check_polls
    320.83 ± 32%      +8.1%     346.83 ± 27%    +115.7%     692.00 ±127%  interrupts.CPU90.NMI:Non-maskable_interrupts
    320.83 ± 32%      +8.1%     346.83 ± 27%    +115.7%     692.00 ±127%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
     24.83 ± 54%     -30.9%      17.17 ± 53%     -67.1%       8.17 ± 28%  interrupts.CPU90.RES:Rescheduling_interrupts
     17.33 ± 29%     -22.1%      13.50 ± 36%     -26.0%      12.83 ± 33%  interrupts.CPU90.TLB:TLB_shootdowns
      1229          +112.9%       2618 ± 18%     +98.1%       2436 ± 16%  interrupts.CPU91.CAL:Function_call_interrupts
      0.00       +3.3e+101%       0.33 ±223%    -100.0%       0.00        interrupts.CPU91.IWI:IRQ_work_interrupts
    602232            -2.8%     585581 ±  4%      -0.3%     600479        interrupts.CPU91.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU91.MCP:Machine_check_polls
    285.67 ± 37%    +169.7%     770.33 ±102%      -1.7%     280.83 ± 35%  interrupts.CPU91.NMI:Non-maskable_interrupts
    285.67 ± 37%    +169.7%     770.33 ±102%      -1.7%     280.83 ± 35%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
     11.67 ± 44%     -28.6%       8.33 ± 60%     -34.3%       7.67 ± 63%  interrupts.CPU91.RES:Rescheduling_interrupts
     10.50 ± 18%      +7.9%      11.33 ± 68%      -9.5%       9.50 ± 28%  interrupts.CPU91.TLB:TLB_shootdowns
      1291 ±  8%    +112.3%       2742 ± 16%    +116.9%       2801 ± 27%  interrupts.CPU92.CAL:Function_call_interrupts
    602168            -0.3%     600170            -0.3%     600591        interrupts.CPU92.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU92.MCP:Machine_check_polls
    206.67 ± 29%     +40.5%     290.33 ± 30%     +16.8%     241.33 ± 44%  interrupts.CPU92.NMI:Non-maskable_interrupts
    206.67 ± 29%     +40.5%     290.33 ± 30%     +16.8%     241.33 ± 44%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
     12.00 ± 41%     +26.4%      15.17 ± 49%    +354.2%      54.50 ±152%  interrupts.CPU92.RES:Rescheduling_interrupts
     14.67 ± 17%      +9.1%      16.00 ± 31%      +1.1%      14.83 ± 32%  interrupts.CPU92.TLB:TLB_shootdowns
      1267 ±  7%    +105.6%       2606 ± 17%     +92.7%       2442 ± 15%  interrupts.CPU93.CAL:Function_call_interrupts
    602111            -0.4%     599916            -0.2%     601113        interrupts.CPU93.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU93.MCP:Machine_check_polls
    227.00 ± 35%     +36.0%     308.67 ± 21%     -25.6%     168.83 ±  2%  interrupts.CPU93.NMI:Non-maskable_interrupts
    227.00 ± 35%     +36.0%     308.67 ± 21%     -25.6%     168.83 ±  2%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
     19.00 ± 70%     -49.1%       9.67 ± 53%      +8.8%      20.67 ±117%  interrupts.CPU93.RES:Rescheduling_interrupts
     11.67 ± 17%     -12.9%      10.17 ± 28%      -2.9%      11.33 ± 24%  interrupts.CPU93.TLB:TLB_shootdowns
      1281 ±  8%    +105.5%       2631 ± 17%    +118.7%       2802 ± 29%  interrupts.CPU94.CAL:Function_call_interrupts
    602120            -1.0%     596196            -0.3%     600392        interrupts.CPU94.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU94.MCP:Machine_check_polls
    282.33 ± 32%     +20.5%     340.17 ± 29%     -24.6%     212.83 ±  8%  interrupts.CPU94.NMI:Non-maskable_interrupts
    282.33 ± 32%     +20.5%     340.17 ± 29%     -24.6%     212.83 ±  8%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
     21.00 ±112%     -41.3%      12.33 ± 60%    +134.1%      49.17 ±157%  interrupts.CPU94.RES:Rescheduling_interrupts
     11.17 ± 37%     +34.3%      15.00 ± 22%     +43.3%      16.00 ± 30%  interrupts.CPU94.TLB:TLB_shootdowns
      1335 ± 11%     +93.6%       2585 ± 18%     +89.2%       2526 ± 14%  interrupts.CPU95.CAL:Function_call_interrupts
    602146            -1.3%     594414            -0.3%     600328        interrupts.CPU95.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU95.MCP:Machine_check_polls
    305.67 ± 32%     -13.8%     263.50 ± 31%     -22.6%     236.50 ± 32%  interrupts.CPU95.NMI:Non-maskable_interrupts
    305.67 ± 32%     -13.8%     263.50 ± 31%     -22.6%     236.50 ± 32%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
     27.17 ± 85%     -65.0%       9.50 ± 52%      +1.8%      27.67 ± 96%  interrupts.CPU95.RES:Rescheduling_interrupts
     10.33 ± 44%     +22.6%      12.67 ± 31%     +83.9%      19.00 ± 96%  interrupts.CPU95.TLB:TLB_shootdowns
      1615 ± 36%     +64.7%       2660 ± 27%     +58.6%       2562 ± 15%  interrupts.CPU96.CAL:Function_call_interrupts
    602309            -1.3%     594273            -0.3%     600606        interrupts.CPU96.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU96.MCP:Machine_check_polls
    315.67 ± 36%      -2.9%     306.67 ± 33%     +25.1%     395.00 ± 66%  interrupts.CPU96.NMI:Non-maskable_interrupts
    315.67 ± 36%      -2.9%     306.67 ± 33%     +25.1%     395.00 ± 66%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
     60.17 ±102%     -80.1%      12.00 ± 32%     -72.3%      16.67 ± 60%  interrupts.CPU96.RES:Rescheduling_interrupts
     15.67 ± 28%     -21.3%      12.33 ± 34%      -2.1%      15.33 ± 24%  interrupts.CPU96.TLB:TLB_shootdowns
      1565 ± 31%     +73.9%       2721 ± 15%     +55.3%       2431 ± 15%  interrupts.CPU97.CAL:Function_call_interrupts
    602145            -1.2%     594737            -0.3%     600312        interrupts.CPU97.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU97.MCP:Machine_check_polls
    279.50 ± 31%     +17.8%     329.17 ± 42%      -2.7%     271.83 ± 34%  interrupts.CPU97.NMI:Non-maskable_interrupts
    279.50 ± 31%     +17.8%     329.17 ± 42%      -2.7%     271.83 ± 34%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
     48.00 ±116%     -67.4%      15.67 ± 73%     -80.6%       9.33 ± 62%  interrupts.CPU97.RES:Rescheduling_interrupts
     10.17 ± 23%    +149.2%      25.33 ±132%      +6.6%      10.83 ± 15%  interrupts.CPU97.TLB:TLB_shootdowns
      1283 ±  2%    +110.9%       2705 ± 22%     +99.4%       2557 ± 15%  interrupts.CPU98.CAL:Function_call_interrupts
      0.17 ±223%    +100.0%       0.33 ±223%    -100.0%       0.00        interrupts.CPU98.IWI:IRQ_work_interrupts
    602235            -2.0%     590349 ±  2%      -0.3%     600554        interrupts.CPU98.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU98.MCP:Machine_check_polls
    608.83 ±118%    +108.6%       1270 ±160%     -61.6%     233.50 ± 32%  interrupts.CPU98.NMI:Non-maskable_interrupts
    608.83 ±118%    +108.6%       1270 ±160%     -61.6%     233.50 ± 32%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
     15.67 ± 28%     -22.3%      12.17 ± 28%      +3.2%      16.17 ± 43%  interrupts.CPU98.RES:Rescheduling_interrupts
     12.17 ± 34%     +12.3%      13.67 ± 45%     +37.0%      16.67 ± 36%  interrupts.CPU98.TLB:TLB_shootdowns
      1373 ± 23%     +91.6%       2631 ± 20%     +76.9%       2429 ± 15%  interrupts.CPU99.CAL:Function_call_interrupts
      1.00 ±223%     -66.7%       0.33 ±223%    -100.0%       0.00        interrupts.CPU99.IWI:IRQ_work_interrupts
    602442            -0.8%     597578            -0.3%     600444        interrupts.CPU99.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU99.MCP:Machine_check_polls
    297.67 ± 42%     +16.0%     345.33 ± 32%     -35.4%     192.17 ±  2%  interrupts.CPU99.NMI:Non-maskable_interrupts
    297.67 ± 42%     +16.0%     345.33 ± 32%     -35.4%     192.17 ±  2%  interrupts.CPU99.PMI:Performance_monitoring_interrupts
      8.67 ± 32%      -7.7%       8.00 ± 46%      -1.9%       8.50 ± 48%  interrupts.CPU99.RES:Rescheduling_interrupts
     11.33 ± 32%     -22.1%       8.83 ± 35%     -11.8%      10.00 ± 36%  interrupts.CPU99.TLB:TLB_shootdowns
      8.00 ± 22%     +25.0%      10.00 ± 12%      +0.0%       8.00 ± 10%  interrupts.IWI:IRQ_work_interrupts
 1.541e+08            -0.8%  1.529e+08            -0.3%  1.537e+08        interrupts.LOC:Local_timer_interrupts
    256.00            +0.0%     256.00            +0.0%     256.00        interrupts.MCP:Machine_check_polls
     74199 ±  3%      -2.5%      72330 ±  3%      -6.0%      69782 ±  4%  interrupts.NMI:Non-maskable_interrupts
     74199 ±  3%      -2.5%      72330 ±  3%      -6.0%      69782 ±  4%  interrupts.PMI:Performance_monitoring_interrupts
      5638 ±  2%     +19.0%       6712 ±  4%     +28.4%       7238 ±  4%  interrupts.RES:Rescheduling_interrupts
      5247 ±  4%      +1.9%       5345 ±  2%      +1.5%       5326 ±  2%  interrupts.TLB:TLB_shootdowns


> 
> Thanks,
> Dennis
