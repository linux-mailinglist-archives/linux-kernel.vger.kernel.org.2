Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A39367B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbhDVHbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:31:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:50372 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235004AbhDVHbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:31:17 -0400
IronPort-SDR: rYu82jOkdDVuCp1Lv9xfRqkQovZFq/+2GI+m0m+nEwFmDjiEXM1Az6bE+C9+qP3dCP3x2FQ6dh
 J96nO7YfeA9g==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="193722853"
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="193722853"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 00:30:25 -0700
IronPort-SDR: p6GrNSOyNWMCgqqMdkcghEblX/naH2R8VETcPdikPH7iibW1ICpRb/fr6j8UeTACzu328pilUN
 /T2YrQESTZpQ==
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="421275751"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 00:30:19 -0700
Date:   Thu, 22 Apr 2021 15:47:42 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     0day robot <lkp@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>, aubrey.li@linux.intel.com,
        yu.c.chen@intel.com
Subject: Re: [sched/fair]  38ac256d1c:  stress-ng.vm-segv.ops_per_sec -13.8%
 regression
Message-ID: <20210422074742.GE31382@xsang-OptiPlex-9020>
References: <20210414052151.GB21236@xsang-OptiPlex-9020>
 <87im4on5u5.mognet@arm.com>
 <20210421032022.GA13430@xsang-OptiPlex-9020>
 <87bla8ue3e.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bla8ue3e.mognet@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Valentin Schneider,

On Wed, Apr 21, 2021 at 11:27:49AM +0100, Valentin Schneider wrote:
> 
> Hi,
> 
> On 21/04/21 11:20, Oliver Sang wrote:
> > hi, Valentin Schneider,
> >
> > On Wed, Apr 14, 2021 at 06:17:38PM +0100, Valentin Schneider wrote:
> >> On 14/04/21 13:21, kernel test robot wrote:
> >> > Greeting,
> >> >
> >> > FYI, we noticed a -13.8% regression of stress-ng.vm-segv.ops_per_sec due to commit:
> >> >
> >> >
> >> > commit: 38ac256d1c3e6b5155071ed7ba87db50a40a4b58 ("[PATCH v5 1/3] sched/fair: Ignore percpu threads for imbalance pulls")
> >> > url: https://github.com/0day-ci/linux/commits/Valentin-Schneider/sched-fair-load-balance-vs-capacity-margins/20210408-060830
> >> > base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 0a2b65c03e9b47493e1442bf9c84badc60d9bffb
> >> >
> >> > in testcase: stress-ng
> >> > on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
> >> > with following parameters:
> >> >
> >> >       nr_threads: 10%
> >> >       disk: 1HDD
> >> >       testtime: 60s
> >> >       fs: ext4
> >> >       class: os
> >> >       test: vm-segv
> >> >       cpufreq_governor: performance
> >> >       ucode: 0x5003006
> >> >
> >> >
> >>
> >> That's almost exactly the same result as [1], which is somewhat annoying
> >> for me because I wasn't able to reproduce those results back then. Save
> >> from scrounging the exact same machine to try this out, I'm not sure what's
> >> the best way forward. I guess I can re-run the workload on whatever
> >> machines I have and try to spot any potentially problematic pattern in the
> >> trace...
> >
> > what's the machine model you used upon which the regression cannot be reproduced?
> > we could check if we have similar model then re-check on the our machine.
> >
> 
> I tested this on:
> o Ampere eMAG (arm64, 32 cores)
> o 2-socket Xeon E5-2690 (x86, 40 cores)
> 
> and found at worse a -0.3% regression and at best a 2% improvement. I know
> that x86 box is somewhat ancient, but it's been my go-to "have I broken
> x86?" test victim for a while :-)

we don't have exactly 2-socket Xeon E5-2690 model, but we have one:
Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (2-socket, 48 cores with 112G memory)
the test on it shows the regression is existing, too. but smaller (-5.3%)
hope it's helpful

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
  os/gcc-9/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-10.4-x86_64-20200603.cgz/lkp-ivb-2ep1/vm-segv/stress-ng/60s/0x42e

commit: 
  0a2b65c03e9b47493e1442bf9c84badc60d9bffb
  38ac256d1c3e6b5155071ed7ba87db50a40a4b58

0a2b65c03e9b4749 38ac256d1c3e6b5155071ed7ba8 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     62.05            +0.0%      62.05        stress-ng.time.elapsed_time
     62.05            +0.0%      62.05        stress-ng.time.elapsed_time.max
      8.00            +0.0%       8.00        stress-ng.time.file_system_inputs
      5283 ± 21%     -25.8%       3919 ± 33%  stress-ng.time.involuntary_context_switches
    629.67           +18.1%     743.83 ±  2%  stress-ng.time.major_page_faults
      6278            +0.5%       6310        stress-ng.time.maximum_resident_set_size
  14171384 ±  4%      -3.2%   13713215        stress-ng.time.minor_page_faults
      4096            +0.0%       4096        stress-ng.time.page_size
    432.67            -0.5%     430.67        stress-ng.time.percent_of_cpu_this_job_got
    151.97            +3.0%     156.56        stress-ng.time.system_time
    116.88            -5.0%     111.02        stress-ng.time.user_time
  29097192            -5.5%   27510022 ±  2%  stress-ng.time.voluntary_context_switches
    374268            -5.3%     354278 ±  2%  stress-ng.vm-segv.ops
      6237            -5.3%       5904 ±  2%  stress-ng.vm-segv.ops_per_sec
    101.76            +0.2%     101.94        uptime.boot
      4340            +0.3%       4353        uptime.idle
     26.87            +1.1%      27.17        boot-time.boot
     13.21            -0.3%      13.17        boot-time.dhcp
      1058            -0.2%       1056        boot-time.idle
      0.46            +0.1%       0.46        boot-time.smp_boot
     89.72            +0.4%      90.07        iostat.cpu.idle
      0.06 ±  9%      -7.6%       0.06 ± 11%  iostat.cpu.iowait
      9.27            -3.2%       8.97        iostat.cpu.system
      0.95            -5.1%       0.90 ±  2%  iostat.cpu.user
     90.47            +0.3       90.80        mpstat.cpu.all.idle%
      0.06 ±  8%      -0.0        0.05 ± 16%  mpstat.cpu.all.iowait%
      1.88 ±  9%      -0.3        1.56 ±  5%  mpstat.cpu.all.irq%
      0.16 ±  9%      -0.0        0.15 ±  9%  mpstat.cpu.all.soft%
      6.52            +0.1        6.58        mpstat.cpu.all.sys%
      0.91            -0.0        0.86 ±  2%  mpstat.cpu.all.usr%
 1.882e+08 ± 12%      +8.7%  2.046e+08 ± 21%  cpuidle.C1.time
  18478182            -3.6%   17814141 ±  4%  cpuidle.C1.usage
 3.344e+08 ± 33%     +35.3%  4.524e+08 ± 59%  cpuidle.C1E.time
   1964577 ± 44%      +5.6%    2073723 ± 49%  cpuidle.C1E.usage
 2.112e+09 ±  4%      -5.5%  1.995e+09 ± 12%  cpuidle.C6.time
   3189061 ± 28%     -12.6%    2787854 ± 21%  cpuidle.C6.usage
  49416190            +1.6%   50186795 ±  2%  cpuidle.POLL.time
  11106396 ±  2%      -5.6%   10488472 ±  2%  cpuidle.POLL.usage
      0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
   6628786 ±  8%      +6.3%    7044731 ± 11%  numa-numastat.node0.local_node
   6660150 ±  8%      +6.1%    7066342 ± 11%  numa-numastat.node0.numa_hit
     31365 ± 28%     -31.1%      21611 ± 72%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
   6970839 ±  5%     -15.0%    5922294 ± 12%  numa-numastat.node1.local_node
   6982872 ±  5%     -14.9%    5944073 ± 12%  numa-numastat.node1.numa_hit
     12035 ± 74%     +81.0%      21782 ± 72%  numa-numastat.node1.other_node
     62.05            +0.0%      62.05        time.elapsed_time
     62.05            +0.0%      62.05        time.elapsed_time.max
      8.00            +0.0%       8.00        time.file_system_inputs
      5283 ± 21%     -25.8%       3919 ± 33%  time.involuntary_context_switches
    629.67           +18.1%     743.83 ±  2%  time.major_page_faults
      6278            +0.5%       6310        time.maximum_resident_set_size
  14171384 ±  4%      -3.2%   13713215        time.minor_page_faults
      4096            +0.0%       4096        time.page_size
    432.67            -0.5%     430.67        time.percent_of_cpu_this_job_got
    151.97            +3.0%     156.56        time.system_time
    116.88            -5.0%     111.02        time.user_time
  29097192            -5.5%   27510022 ±  2%  time.voluntary_context_switches
     89.17            +0.6%      89.67        vmstat.cpu.id
      8.83 ±  4%      -7.5%       8.17 ±  4%  vmstat.cpu.sy
      0.83 ± 44%     -40.0%       0.50 ±100%  vmstat.cpu.us
      0.00          -100.0%       0.00        vmstat.cpu.wa
      0.00          -100.0%       0.00        vmstat.io.bi
      4563 ±  5%     -11.2%       4052 ± 17%  vmstat.io.bo
      1101            -0.4%       1096        vmstat.memory.buff
   1143009            -0.2%    1141026        vmstat.memory.cache
 1.132e+08            +0.0%  1.133e+08        vmstat.memory.free
      0.00          -100.0%       0.00        vmstat.procs.b
      4.00            +0.0%       4.00        vmstat.procs.r
    906400            -5.4%     857143 ±  2%  vmstat.system.cs
    100868            -2.5%      98329 ±  3%  vmstat.system.in
    410.17            -0.7%     407.17        turbostat.Avg_MHz
     14.74            -0.8       13.92        turbostat.Busy%
      2790 ±  2%      +5.1%       2931        turbostat.Bzy_MHz
  18481081            -3.6%   17810424 ±  4%  turbostat.C1
      6.16 ± 13%      +0.5        6.69 ± 21%  turbostat.C1%
   1964406 ± 44%      +5.6%    2073470 ± 49%  turbostat.C1E
     10.92 ± 33%      +3.9       14.82 ± 59%  turbostat.C1E%
   3186765 ± 28%     -12.7%    2782513 ± 21%  turbostat.C6
     68.91 ±  4%      -3.8       65.13 ± 11%  turbostat.C6%
     55.35 ± 11%      +1.6%      56.25 ± 11%  turbostat.CPU%c1
     29.91 ± 21%      -0.3%      29.83 ± 22%  turbostat.CPU%c6
     93.17 ±  4%      +3.5%      96.44 ±  2%  turbostat.CorWatt
     69.83 ±  3%      -0.2%      69.67 ±  3%  turbostat.CoreTmp
   6549472            -2.6%    6381758 ±  3%  turbostat.IRQ
     12.12 ± 49%     -55.0%       5.45 ± 49%  turbostat.Pkg%pc2
      0.10 ± 68%     +17.5%       0.12 ± 66%  turbostat.Pkg%pc6
     69.83 ±  3%      -0.2%      69.67 ±  3%  turbostat.PkgTmp
    121.81 ±  3%      +2.8%     125.20        turbostat.PkgWatt
     20.10            +6.6%      21.42        turbostat.RAMWatt
      2693            -0.0%       2693        turbostat.TSC_MHz
      8390            -3.7%       8082        meminfo.Active
      7414            -4.1%       7110        meminfo.Active(anon)
    975.50            -0.4%     971.17        meminfo.Active(file)
     78147 ±  4%      -0.7%      77601 ±  7%  meminfo.AnonHugePages
    234699            -0.3%     233894        meminfo.AnonPages
      1100            -0.4%       1096        meminfo.Buffers
   1068202            +0.0%    1068277        meminfo.Cached
    199940            +0.0%     199940        meminfo.CmaFree
    204800            +0.0%     204800        meminfo.CmaTotal
  57688376            +0.0%   57688376        meminfo.CommitLimit
    667822            +0.1%     668198        meminfo.Committed_AS
 1.029e+08            +2.4%  1.054e+08        meminfo.DirectMap1G
  16092501 ± 10%     -15.0%   13679274 ±  3%  meminfo.DirectMap2M
    429876 ±  7%      -7.8%     396425 ±  4%  meminfo.DirectMap4k
      5.67 ± 16%      +8.8%       6.17 ± 11%  meminfo.Dirty
      2048            +0.0%       2048        meminfo.Hugepagesize
    248091            -0.0%     248010        meminfo.Inactive
    247968            -0.0%     247886        meminfo.Inactive(anon)
    122.33 ±  3%      +0.5%     123.00 ±  2%  meminfo.Inactive(file)
     74840            -2.8%      72725        meminfo.KReclaimable
     12721            -1.8%      12494        meminfo.KernelStack
     35493            +1.0%      35836        meminfo.Mapped
 1.127e+08            +0.0%  1.127e+08        meminfo.MemAvailable
 1.132e+08            +0.0%  1.133e+08        meminfo.MemFree
 1.154e+08            +0.0%  1.154e+08        meminfo.MemTotal
   2147410            -1.5%    2115780        meminfo.Memused
      7.00            +0.0%       7.00        meminfo.Mlocked
      7631 ±  7%      -5.0%       7249 ±  8%  meminfo.PageTables
     80842            -0.3%      80608        meminfo.Percpu
     74840            -2.8%      72725        meminfo.SReclaimable
    121123            -0.7%     120241        meminfo.SUnreclaim
     21831            +0.3%      21907        meminfo.Shmem
    195964            -1.5%     192968        meminfo.Slab
   1046372            -0.0%    1046371        meminfo.Unevictable
 3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
    184780            -0.0%     184761        meminfo.VmallocUsed
   2207891            -1.2%    2181160        meminfo.max_used_kB
      1122 ± 34%     +37.6%       1544 ± 24%  numa-meminfo.node0.Active
    906.50 ± 31%     +27.5%       1155 ± 15%  numa-meminfo.node0.Active(anon)
    215.33 ±129%     +80.2%     388.00 ±103%  numa-meminfo.node0.Active(file)
     31989 ±108%     +97.2%      63079 ± 40%  numa-meminfo.node0.AnonHugePages
    102899 ± 75%     +81.3%     186556 ± 36%  numa-meminfo.node0.AnonPages
    111493 ± 68%     +72.8%     192682 ± 35%  numa-meminfo.node0.AnonPages.max
      3.17 ±102%     +36.8%       4.33 ± 60%  numa-meminfo.node0.Dirty
    534079 ±  3%      +3.4%     552351 ±  2%  numa-meminfo.node0.FilePages
    108791 ± 71%     +83.8%     199931 ± 34%  numa-meminfo.node0.Inactive
    108771 ± 71%     +83.8%     199891 ± 34%  numa-meminfo.node0.Inactive(anon)
     19.83 ±221%    +102.5%      40.17 ±140%  numa-meminfo.node0.Inactive(file)
     38561 ± 17%     +14.3%      44083 ±  9%  numa-meminfo.node0.KReclaimable
      6616 ±  5%      +5.4%       6975 ±  5%  numa-meminfo.node0.KernelStack
     16116 ± 12%     +34.1%      21615        numa-meminfo.node0.Mapped
  60691696            -0.2%   60584020        numa-meminfo.node0.MemFree
  61766680            +0.0%   61766680        numa-meminfo.node0.MemTotal
   1074982 ±  8%     +10.0%    1182658 ±  7%  numa-meminfo.node0.MemUsed
      3.00            +0.0%       3.00        numa-meminfo.node0.Mlocked
      3385 ± 14%     +35.1%       4574 ± 11%  numa-meminfo.node0.PageTables
     38561 ± 17%     +14.3%      44083 ±  9%  numa-meminfo.node0.SReclaimable
     63531 ±  7%      +6.8%      67866 ±  5%  numa-meminfo.node0.SUnreclaim
      7325 ± 49%    +104.8%      15005        numa-meminfo.node0.Shmem
    102092 ± 10%      +9.7%     111951 ±  4%  numa-meminfo.node0.Slab
    526518 ±  3%      +2.0%     536917 ±  2%  numa-meminfo.node0.Unevictable
      7269 ±  4%     -10.1%       6538 ±  6%  numa-meminfo.node1.Active
      6509 ±  4%      -8.5%       5955 ±  3%  numa-meminfo.node1.Active(anon)
    759.67 ± 36%     -23.3%     582.67 ± 69%  numa-meminfo.node1.Active(file)
     46285 ± 70%     -68.4%      14606 ±189%  numa-meminfo.node1.AnonHugePages
    132013 ± 59%     -64.0%      47557 ±146%  numa-meminfo.node1.AnonPages
    181517 ± 44%     -49.3%      92036 ± 75%  numa-meminfo.node1.AnonPages.max
      2.50 ±100%     -33.3%       1.67 ±132%  numa-meminfo.node1.Dirty
    535266 ±  3%      -3.4%     517026 ±  2%  numa-meminfo.node1.FilePages
    139541 ± 56%     -65.4%      48338 ±146%  numa-meminfo.node1.Inactive
    139437 ± 56%     -65.4%      48255 ±146%  numa-meminfo.node1.Inactive(anon)
    103.67 ± 44%     -20.1%      82.83 ± 70%  numa-meminfo.node1.Inactive(file)
     36314 ± 19%     -21.1%      28647 ± 14%  numa-meminfo.node1.KReclaimable
      6095 ±  8%      -9.3%       5526 ±  9%  numa-meminfo.node1.KernelStack
     19513 ± 10%     -26.5%      14339        numa-meminfo.node1.Mapped
  52537439            +0.3%   52676940        numa-meminfo.node1.MemFree
  53610072            +0.0%   53610072        numa-meminfo.node1.MemTotal
   1072631 ±  8%     -13.0%     933130 ±  9%  numa-meminfo.node1.MemUsed
      3.00            +0.0%       3.00        numa-meminfo.node1.Mlocked
      4192 ± 12%     -32.5%       2828 ± 17%  numa-meminfo.node1.PageTables
     36314 ± 19%     -21.1%      28647 ± 14%  numa-meminfo.node1.SReclaimable
     57691 ±  8%      -8.9%      52551 ±  6%  numa-meminfo.node1.SUnreclaim
     14548 ± 25%     -52.5%       6905 ±  2%  numa-meminfo.node1.Shmem
     94005 ± 11%     -13.6%      81199 ±  8%  numa-meminfo.node1.Slab
    519853 ±  3%      -2.0%     509452 ±  2%  numa-meminfo.node1.Unevictable
      0.00          -100.0%       0.00        proc-vmstat.compact_isolated
      1853            -4.1%       1777        proc-vmstat.nr_active_anon
    243.50            -0.5%     242.33        proc-vmstat.nr_active_file
     58735            -0.4%      58523        proc-vmstat.nr_anon_pages
     37.67 ±  5%      -0.9%      37.33 ±  7%  proc-vmstat.nr_anon_transparent_hugepages
      4.83 ± 14%     -13.8%       4.17 ± 25%  proc-vmstat.nr_dirtied
      1.00            +0.0%       1.00        proc-vmstat.nr_dirty
   2812488            +0.0%    2813282        proc-vmstat.nr_dirty_background_threshold
   5631854            +0.0%    5633445        proc-vmstat.nr_dirty_threshold
    267336            +0.0%     267344        proc-vmstat.nr_file_pages
     49985            +0.0%      49985        proc-vmstat.nr_free_cma
  28307285            +0.0%   28315239        proc-vmstat.nr_free_pages
     62042            -0.0%      62021        proc-vmstat.nr_inactive_anon
     30.50 ±  3%      -0.5%      30.33 ±  3%  proc-vmstat.nr_inactive_file
     12717            -1.7%      12504        proc-vmstat.nr_kernel_stack
      9010            +0.9%       9090        proc-vmstat.nr_mapped
      1.00            +0.0%       1.00        proc-vmstat.nr_mlock
      1907 ±  7%      -2.9%       1851 ±  7%  proc-vmstat.nr_page_table_pages
      5468            +0.2%       5477        proc-vmstat.nr_shmem
     18721            -2.8%      18190        proc-vmstat.nr_slab_reclaimable
     30318            -0.6%      30123        proc-vmstat.nr_slab_unreclaimable
    261592            -0.0%     261592        proc-vmstat.nr_unevictable
      2.83 ± 24%      +0.0%       2.83 ± 31%  proc-vmstat.nr_written
      1853            -4.1%       1777        proc-vmstat.nr_zone_active_anon
    243.50            -0.5%     242.33        proc-vmstat.nr_zone_active_file
     62042            -0.0%      62021        proc-vmstat.nr_zone_inactive_anon
     30.50 ±  3%      -0.5%      30.33 ±  3%  proc-vmstat.nr_zone_inactive_file
    261592            -0.0%     261592        proc-vmstat.nr_zone_unevictable
      1.00            +0.0%       1.00        proc-vmstat.nr_zone_write_pending
    822.67 ±140%     -99.6%       3.67 ±100%  proc-vmstat.numa_hint_faults
    805.67 ±143%     -99.5%       3.67 ±100%  proc-vmstat.numa_hint_faults_local
  13602406 ±  3%      -4.6%   12971942        proc-vmstat.numa_hit
      3.50 ±147%     +85.7%       6.50 ±100%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00        proc-vmstat.numa_interleave
  13558992 ±  3%      -4.6%   12928533        proc-vmstat.numa_local
     43413            -0.0%      43409        proc-vmstat.numa_other
     95.17 ±222%    -100.0%       0.00        proc-vmstat.numa_pages_migrated
      1792 ±147%     +85.7%       3328 ±100%  proc-vmstat.numa_pte_updates
      4158            -8.1%       3821 ±  3%  proc-vmstat.pgactivate
      0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma
      0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
  14832387 ±  3%      -4.9%   14101230        proc-vmstat.pgalloc_normal
  14393998 ±  4%      -3.2%   13933130        proc-vmstat.pgfault
  14762236 ±  3%      -5.0%   14031110        proc-vmstat.pgfree
     95.17 ±222%    -100.0%       0.00        proc-vmstat.pgmigrate_success
      4.00            +0.0%       4.00        proc-vmstat.pgpgin
    293004 ±  5%     -11.2%     260224 ± 18%  proc-vmstat.pgpgout
    199070 ±  8%     -12.1%     175015 ±  4%  proc-vmstat.pgreuse
     48.00            +0.0%      48.00        proc-vmstat.thp_collapse_alloc
      0.00       +1.7e+101%       0.17 ±223%  proc-vmstat.thp_deferred_split_page
      3.50 ± 27%     +14.3%       4.00 ± 25%  proc-vmstat.thp_fault_alloc
      0.67 ± 70%      +0.0%       0.67 ± 70%  proc-vmstat.thp_split_pmd
      0.33 ±141%     +50.0%       0.50 ±100%  proc-vmstat.thp_zero_page_alloc
     12.67 ±  3%      -1.3%      12.50 ±  4%  proc-vmstat.unevictable_pgs_culled
      2.00            +0.0%       2.00        proc-vmstat.unevictable_pgs_mlocked
      2.00            +0.0%       2.00        proc-vmstat.unevictable_pgs_munlocked
      0.00          -100.0%       0.00        proc-vmstat.unevictable_pgs_rescued
    534400            -0.2%     533376        proc-vmstat.unevictable_pgs_scanned
    226.17 ± 31%     +27.6%     288.50 ± 14%  numa-vmstat.node0.nr_active_anon
     53.33 ±130%     +80.9%      96.50 ±104%  numa-vmstat.node0.nr_active_file
     25776 ± 74%     +81.1%      46673 ± 36%  numa-vmstat.node0.nr_anon_pages
     15.17 ±110%    +100.0%      30.33 ± 41%  numa-vmstat.node0.nr_anon_transparent_hugepages
    131870 ± 99%     +66.6%     219679 ± 44%  numa-vmstat.node0.nr_dirtied
      0.50 ±100%     +33.3%       0.67 ± 70%  numa-vmstat.node0.nr_dirty
    133520 ±  3%      +3.4%     138088 ±  2%  numa-vmstat.node0.nr_file_pages
     49985            +0.0%      49985        numa-vmstat.node0.nr_free_cma
  15172823            -0.2%   15145886        numa-vmstat.node0.nr_free_pages
     27219 ± 71%     +83.7%      50002 ± 34%  numa-vmstat.node0.nr_inactive_anon
      4.83 ±223%    +103.4%       9.83 ±141%  numa-vmstat.node0.nr_inactive_file
      6650 ±  5%      +5.6%       7022 ±  5%  numa-vmstat.node0.nr_kernel_stack
      4105 ± 11%     +34.2%       5510        numa-vmstat.node0.nr_mapped
      0.00          -100.0%       0.00        numa-vmstat.node0.nr_mlock
    883.17 ± 15%     +33.6%       1179 ± 11%  numa-vmstat.node0.nr_page_table_pages
      1832 ± 49%    +104.8%       3751        numa-vmstat.node0.nr_shmem
      9634 ± 17%     +14.3%      11011 ±  9%  numa-vmstat.node0.nr_slab_reclaimable
     15917 ±  7%      +7.0%      17025 ±  5%  numa-vmstat.node0.nr_slab_unreclaimable
    131629 ±  3%      +2.0%     134229 ±  2%  numa-vmstat.node0.nr_unevictable
    131869 ± 99%     +66.6%     219678 ± 44%  numa-vmstat.node0.nr_written
    226.17 ± 31%     +27.6%     288.50 ± 14%  numa-vmstat.node0.nr_zone_active_anon
     53.33 ±130%     +80.9%      96.50 ±104%  numa-vmstat.node0.nr_zone_active_file
     27219 ± 71%     +83.7%      50002 ± 34%  numa-vmstat.node0.nr_zone_inactive_anon
      4.83 ±223%    +103.4%       9.83 ±141%  numa-vmstat.node0.nr_zone_inactive_file
    131629 ±  3%      +2.0%     134229 ±  2%  numa-vmstat.node0.nr_zone_unevictable
      0.50 ±100%     +33.3%       0.67 ± 70%  numa-vmstat.node0.nr_zone_write_pending
   3743203 ± 14%     +13.6%    4252893 ± 13%  numa-vmstat.node0.numa_hit
    144537            +0.0%     144560        numa-vmstat.node0.numa_interleave
   3708684 ± 14%     +14.1%    4230751 ± 13%  numa-vmstat.node0.numa_local
     34520 ± 26%     -35.9%      22141 ± 67%  numa-vmstat.node0.numa_other
      1620 ±  4%      -8.5%       1482 ±  3%  numa-vmstat.node1.nr_active_anon
    189.67 ± 36%     -23.4%     145.33 ± 69%  numa-vmstat.node1.nr_active_file
     33030 ± 58%     -63.8%      11953 ±146%  numa-vmstat.node1.nr_anon_pages
     22.00 ± 72%     -69.7%       6.67 ±203%  numa-vmstat.node1.nr_anon_transparent_hugepages
    131825 ± 99%     -66.6%      44016 ±223%  numa-vmstat.node1.nr_dirtied
      0.50 ±100%     -66.7%       0.17 ±223%  numa-vmstat.node1.nr_dirty
    133826 ±  3%      -3.4%     129252 ±  2%  numa-vmstat.node1.nr_file_pages
  13134316            +0.3%   13169106        numa-vmstat.node1.nr_free_pages
     34913 ± 56%     -65.3%      12124 ±145%  numa-vmstat.node1.nr_inactive_anon
     25.67 ± 44%     -20.1%      20.50 ± 70%  numa-vmstat.node1.nr_inactive_file
      0.83 ±223%    -100.0%       0.00        numa-vmstat.node1.nr_isolated_anon
      6107 ±  8%      -9.0%       5555 ±  9%  numa-vmstat.node1.nr_kernel_stack
      4959 ± 10%     -27.1%       3614 ±  2%  numa-vmstat.node1.nr_mapped
      0.00          -100.0%       0.00        numa-vmstat.node1.nr_mlock
      1060 ±  9%     -28.9%     754.17 ± 17%  numa-vmstat.node1.nr_page_table_pages
      3646 ± 25%     -52.8%       1722 ±  2%  numa-vmstat.node1.nr_shmem
      9065 ± 18%     -20.9%       7172 ± 14%  numa-vmstat.node1.nr_slab_reclaimable
     14433 ±  8%      -8.7%      13183 ±  6%  numa-vmstat.node1.nr_slab_unreclaimable
    129963 ±  3%      -2.0%     127362 ±  2%  numa-vmstat.node1.nr_unevictable
    131825 ± 99%     -66.6%      44016 ±223%  numa-vmstat.node1.nr_written
      1620 ±  4%      -8.5%       1482 ±  3%  numa-vmstat.node1.nr_zone_active_anon
    189.67 ± 36%     -23.4%     145.33 ± 69%  numa-vmstat.node1.nr_zone_active_file
     34913 ± 56%     -65.3%      12124 ±145%  numa-vmstat.node1.nr_zone_inactive_anon
     25.67 ± 44%     -20.1%      20.50 ± 70%  numa-vmstat.node1.nr_zone_inactive_file
    129963 ±  3%      -2.0%     127362 ±  2%  numa-vmstat.node1.nr_zone_unevictable
      0.50 ±100%     -66.7%       0.17 ±223%  numa-vmstat.node1.nr_zone_write_pending
   4054243 ±  9%     -20.4%    3226026 ± 17%  numa-vmstat.node1.numa_hit
    144622            -0.0%     144594        numa-vmstat.node1.numa_interleave
   3888883 ±  9%     -21.6%    3048417 ± 18%  numa-vmstat.node1.numa_local
    165360 ±  5%      +7.4%     177609 ±  8%  numa-vmstat.node1.numa_other
     18.58 ±  3%      -0.8%      18.42 ±  2%  perf-stat.i.MPKI
  2.32e+09            -4.3%  2.221e+09        perf-stat.i.branch-instructions
      1.63 ±  4%      +0.0        1.63 ±  3%  perf-stat.i.branch-miss-rate%
  35511033 ±  3%      -4.7%   33858722 ±  2%  perf-stat.i.branch-misses
      5.24 ± 10%      +2.6        7.88 ±  5%  perf-stat.i.cache-miss-rate%
   8904631 ± 14%     +50.5%   13400160 ±  5%  perf-stat.i.cache-misses
 1.991e+08            -5.5%  1.881e+08        perf-stat.i.cache-references
    939422            -5.5%     887849 ±  2%  perf-stat.i.context-switches
      1.90 ±  2%      +3.1%       1.96 ±  2%  perf-stat.i.cpi
     47995            -0.0%      47992        perf-stat.i.cpu-clock
 2.003e+10            -1.9%  1.964e+10        perf-stat.i.cpu-cycles
    145.29 ±  9%     -15.4%     122.92 ± 10%  perf-stat.i.cpu-migrations
      2385 ± 12%     -27.4%       1732 ±  7%  perf-stat.i.cycles-between-cache-misses
      0.63 ±  5%      -0.0        0.58 ± 10%  perf-stat.i.dTLB-load-miss-rate%
  18831979 ±  5%     -11.6%   16655916 ±  9%  perf-stat.i.dTLB-load-misses
 2.987e+09            -4.8%  2.845e+09        perf-stat.i.dTLB-loads
      0.18 ±  3%      -0.0        0.17 ±  5%  perf-stat.i.dTLB-store-miss-rate%
   3200322 ±  3%      -8.0%    2945416 ±  5%  perf-stat.i.dTLB-store-misses
 1.815e+09            -5.6%  1.714e+09        perf-stat.i.dTLB-stores
     81.46            +1.0       82.45        perf-stat.i.iTLB-load-miss-rate%
   8356116            +0.3%    8381820        perf-stat.i.iTLB-load-misses
   1933319 ±  2%      -6.3%    1810679 ±  3%  perf-stat.i.iTLB-loads
 1.072e+10            -4.6%  1.022e+10        perf-stat.i.instructions
      1316 ±  2%      -4.9%       1251 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.53 ±  2%      -2.8%       0.52 ±  2%  perf-stat.i.ipc
     11.77 ±  4%     +10.8%      13.04 ±  3%  perf-stat.i.major-faults
      0.42            -2.0%       0.41        perf-stat.i.metric.GHz
      0.03 ± 43%     +51.1%       0.04 ± 32%  perf-stat.i.metric.K/sec
    152.77            -4.7%     145.62        perf-stat.i.metric.M/sec
    228577 ±  4%      -3.3%     221131        perf-stat.i.minor-faults
     42.81            +3.3       46.07        perf-stat.i.node-load-miss-rate%
   1275857 ± 16%    +325.6%    5429434 ±  9%  perf-stat.i.node-load-misses
   1545753 ± 14%    +270.0%    5718567 ±  9%  perf-stat.i.node-loads
     20.66 ±  4%      +9.8       30.50 ±  5%  perf-stat.i.node-store-miss-rate%
    533525 ± 12%    +188.3%    1537966 ±  9%  perf-stat.i.node-store-misses
   1838868 ±  7%     +53.5%    2823121 ±  7%  perf-stat.i.node-stores
    240497 ±  4%      -3.4%     232410        perf-stat.i.page-faults
     47995            -0.0%      47992        perf-stat.i.task-clock
     18.58 ±  3%      -0.9%      18.41 ±  2%  perf-stat.overall.MPKI
      1.53 ±  4%      -0.0        1.53 ±  3%  perf-stat.overall.branch-miss-rate%
      4.47 ± 12%      +2.7        7.12 ±  5%  perf-stat.overall.cache-miss-rate%
      1.87 ±  2%      +2.8%       1.92 ±  2%  perf-stat.overall.cpi
      2288 ± 12%     -35.8%       1469 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.63 ±  5%      -0.0        0.58 ± 10%  perf-stat.overall.dTLB-load-miss-rate%
      0.18 ±  3%      -0.0        0.17 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
     81.21            +1.0       82.24        perf-stat.overall.iTLB-load-miss-rate%
      1283 ±  2%      -4.9%       1220 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.54 ±  2%      -2.8%       0.52 ±  2%  perf-stat.overall.ipc
     45.11            +3.6       48.69        perf-stat.overall.node-load-miss-rate%
     22.44 ±  6%     +12.8       35.22        perf-stat.overall.node-store-miss-rate%
 2.282e+09            -4.3%  2.185e+09        perf-stat.ps.branch-instructions
  34944122 ±  3%      -4.7%   33317639 ±  2%  perf-stat.ps.branch-misses
   8764430 ± 14%     +50.4%   13182428 ±  5%  perf-stat.ps.cache-misses
 1.959e+08            -5.5%  1.851e+08        perf-stat.ps.cache-references
    924170            -5.5%     873484 ±  2%  perf-stat.ps.context-switches
     47234            -0.0%      47231        perf-stat.ps.cpu-clock
  1.97e+10            -1.9%  1.932e+10        perf-stat.ps.cpu-cycles
    142.98 ±  9%     -15.4%     121.00 ± 10%  perf-stat.ps.cpu-migrations
  18527288 ±  5%     -11.6%   16386779 ±  9%  perf-stat.ps.dTLB-load-misses
 2.939e+09            -4.8%  2.799e+09        perf-stat.ps.dTLB-loads
   3148614 ±  3%      -8.0%    2897904 ±  5%  perf-stat.ps.dTLB-store-misses
 1.785e+09            -5.6%  1.686e+09        perf-stat.ps.dTLB-stores
   8220925            +0.3%    8246585        perf-stat.ps.iTLB-load-misses
   1901979 ±  2%      -6.3%    1781451 ±  3%  perf-stat.ps.iTLB-loads
 1.055e+10            -4.6%  1.006e+10        perf-stat.ps.instructions
     11.63 ±  4%     +10.7%      12.87 ±  3%  perf-stat.ps.major-faults
    224870 ±  4%      -3.3%     217555        perf-stat.ps.minor-faults
   1255071 ± 16%    +325.3%    5337676 ±  9%  perf-stat.ps.node-load-misses
   1520686 ± 14%    +269.7%    5622239 ±  9%  perf-stat.ps.node-loads
    525246 ± 12%    +188.0%    1512617 ±  9%  perf-stat.ps.node-store-misses
   1809915 ±  7%     +53.4%    2777253 ±  7%  perf-stat.ps.node-stores
    236596 ±  4%      -3.4%     228651        perf-stat.ps.page-faults
     47234            -0.0%      47231        perf-stat.ps.task-clock
 6.672e+11            -4.6%  6.364e+11        perf-stat.total.instructions
    282.71 ±172%     -58.6%     117.09 ±118%  sched_debug.cfs_rq:/.MIN_vruntime.avg
     10305 ±159%     -60.0%       4125 ±102%  sched_debug.cfs_rq:/.MIN_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.min
      1586 ±163%     -57.5%     673.64 ±107%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
     32714 ± 26%      +2.4%      33502 ± 25%  sched_debug.cfs_rq:/.load.avg
    911174 ± 21%     +15.1%    1048576        sched_debug.cfs_rq:/.load.max
    143709 ± 24%     +10.7%     159042 ± 13%  sched_debug.cfs_rq:/.load.stddev
    333.97 ± 31%      +3.7%     346.18 ±  6%  sched_debug.cfs_rq:/.load_avg.avg
      8728 ± 28%     +24.5%      10866 ±  3%  sched_debug.cfs_rq:/.load_avg.max
      0.25 ±223%    -100.0%       0.00        sched_debug.cfs_rq:/.load_avg.min
      1298 ± 28%     +20.3%       1563 ±  3%  sched_debug.cfs_rq:/.load_avg.stddev
    282.71 ±172%     -58.6%     117.09 ±118%  sched_debug.cfs_rq:/.max_vruntime.avg
     10305 ±159%     -60.0%       4125 ±102%  sched_debug.cfs_rq:/.max_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.min
      1586 ±163%     -57.5%     673.64 ±107%  sched_debug.cfs_rq:/.max_vruntime.stddev
     17251 ± 42%     -27.3%      12548 ± 10%  sched_debug.cfs_rq:/.min_vruntime.avg
     37874 ± 19%     -13.1%      32923 ±  7%  sched_debug.cfs_rq:/.min_vruntime.max
     10742 ± 49%     -26.0%       7950 ± 19%  sched_debug.cfs_rq:/.min_vruntime.min
      5153 ± 16%     -12.8%       4493 ± 10%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.31 ± 16%     +15.3%       0.35 ±  8%  sched_debug.cfs_rq:/.nr_running.avg
      1.00            +0.0%       1.00        sched_debug.cfs_rq:/.nr_running.max
      0.45 ±  6%      +5.7%       0.48        sched_debug.cfs_rq:/.nr_running.stddev
     52.06 ± 55%     -19.8%      41.77 ± 50%  sched_debug.cfs_rq:/.removed.load_avg.avg
    849.33 ± 28%     +18.7%       1008 ±  2%  sched_debug.cfs_rq:/.removed.load_avg.max
    192.60 ± 34%      +0.6%     193.73 ± 24%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     16.20 ± 72%     -41.6%       9.45 ± 53%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    322.50 ± 50%      -3.8%     310.17 ± 39%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     61.50 ± 57%     -19.1%      49.74 ± 39%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     16.20 ± 72%     -41.6%       9.45 ± 53%  sched_debug.cfs_rq:/.removed.util_avg.avg
    322.50 ± 50%      -3.8%     310.17 ± 39%  sched_debug.cfs_rq:/.removed.util_avg.max
     61.50 ± 57%     -19.1%      49.74 ± 39%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    487.44 ± 19%     +18.0%     575.06 ±  7%  sched_debug.cfs_rq:/.runnable_avg.avg
      1454 ± 22%      +8.4%       1577 ± 18%  sched_debug.cfs_rq:/.runnable_avg.max
      1.25 ±162%     -73.3%       0.33 ±223%  sched_debug.cfs_rq:/.runnable_avg.min
    346.33 ± 16%      -1.7%     340.34 ±  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
     -3594            +9.1%      -3921        sched_debug.cfs_rq:/.spread0.avg
     17025 ± 56%      -3.2%      16476 ± 49%  sched_debug.cfs_rq:/.spread0.max
    -10071           -15.9%      -8470        sched_debug.cfs_rq:/.spread0.min
      5155 ± 16%     -12.9%       4489 ± 10%  sched_debug.cfs_rq:/.spread0.stddev
    486.60 ± 19%     +18.0%     574.35 ±  7%  sched_debug.cfs_rq:/.util_avg.avg
      1452 ± 22%      +8.5%       1576 ± 18%  sched_debug.cfs_rq:/.util_avg.max
      1.25 ±162%     -73.3%       0.33 ±223%  sched_debug.cfs_rq:/.util_avg.min
    345.79 ± 16%      -1.7%     340.06 ±  8%  sched_debug.cfs_rq:/.util_avg.stddev
     61.58 ± 12%     +30.0%      80.07 ± 13%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    815.50 ± 11%      +6.8%     871.33        sched_debug.cfs_rq:/.util_est_enqueued.max
    169.68 ±  5%     +10.0%     186.72 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    545271 ±  6%      -5.5%     515364 ±  5%  sched_debug.cpu.avg_idle.avg
   1037512 ±  5%      +1.8%    1055721 ± 16%  sched_debug.cpu.avg_idle.max
     10181 ±130%    +155.1%      25967 ±195%  sched_debug.cpu.avg_idle.min
    290615 ± 19%     -10.2%     260841 ± 12%  sched_debug.cpu.avg_idle.stddev
     48422 ± 28%     -20.2%      38663        sched_debug.cpu.clock.avg
     48424 ± 28%     -20.2%      38666        sched_debug.cpu.clock.max
     48419 ± 28%     -20.2%      38658        sched_debug.cpu.clock.min
      1.24 ± 10%     +41.4%       1.75 ± 54%  sched_debug.cpu.clock.stddev
     48007 ± 28%     -19.9%      38466        sched_debug.cpu.clock_task.avg
     48195 ± 28%     -19.8%      38646        sched_debug.cpu.clock_task.max
     44613 ± 30%     -21.3%      35116        sched_debug.cpu.clock_task.min
    585.12 ±  2%      +1.3%     592.74 ±  3%  sched_debug.cpu.clock_task.stddev
    645.68 ± 20%     -20.5%     513.57 ± 16%  sched_debug.cpu.curr->pid.avg
      3999 ± 75%     -52.8%       1888        sched_debug.cpu.curr->pid.max
      1262 ± 51%     -38.2%     780.58 ±  4%  sched_debug.cpu.curr->pid.stddev
    507674            +0.1%     507952 ±  2%  sched_debug.cpu.max_idle_balance_cost.avg
    715017 ±  9%      +5.1%     751380 ± 33%  sched_debug.cpu.max_idle_balance_cost.max
    500000            +0.0%     500000        sched_debug.cpu.max_idle_balance_cost.min
     37669 ± 38%      -0.1%      37644 ±106%  sched_debug.cpu.max_idle_balance_cost.stddev
      4294            -0.0%       4294        sched_debug.cpu.next_balance.avg
      4294            -0.0%       4294        sched_debug.cpu.next_balance.max
      4294            -0.0%       4294        sched_debug.cpu.next_balance.min
      0.00 ± 19%      -4.5%       0.00 ±  9%  sched_debug.cpu.next_balance.stddev
      0.31 ± 15%      +5.1%       0.32 ± 14%  sched_debug.cpu.nr_running.avg
      1.00            +0.0%       1.00        sched_debug.cpu.nr_running.max
      0.45 ±  6%      +2.6%       0.46 ±  3%  sched_debug.cpu.nr_running.stddev
    196001 ±139%     -98.9%       2100        sched_debug.cpu.nr_switches.avg
    295068 ±136%     -96.8%       9369 ± 16%  sched_debug.cpu.nr_switches.max
    103705 ±144%     -99.6%     465.33 ± 10%  sched_debug.cpu.nr_switches.min
     43939 ±137%     -95.4%       2016 ±  8%  sched_debug.cpu.nr_switches.stddev
      0.02 ± 41%      +7.7%       0.02 ± 31%  sched_debug.cpu.nr_uninterruptible.avg
     21.33 ± 19%      -5.5%      20.17 ± 21%  sched_debug.cpu.nr_uninterruptible.max
    -12.50           -10.7%     -11.17        sched_debug.cpu.nr_uninterruptible.min
      6.50 ± 13%      -9.5%       5.89 ± 11%  sched_debug.cpu.nr_uninterruptible.stddev
     48420 ± 28%     -20.2%      38661        sched_debug.cpu_clk
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.avg
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.max
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.min
 4.295e+09            -0.0%  4.295e+09        sched_debug.jiffies
     47940 ± 29%     -20.4%      38180        sched_debug.ktime
    950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.avg
    950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.max
    950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.min
     48889 ± 28%     -20.0%      39135        sched_debug.sched_clk
      1.00            +0.0%       1.00        sched_debug.sched_clock_stable()
   4140603            +0.0%    4140603        sched_debug.sysctl_sched.sysctl_sched_features
     24.00            +0.0%      24.00        sched_debug.sysctl_sched.sysctl_sched_latency
      3.00            +0.0%       3.00        sched_debug.sysctl_sched.sysctl_sched_min_granularity
      1.00            +0.0%       1.00        sched_debug.sysctl_sched.sysctl_sched_tunable_scaling
      4.00            +0.0%       4.00        sched_debug.sysctl_sched.sysctl_sched_wakeup_granularity
      0.01 ±112%     +13.6%       0.02 ± 76%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00        +6.7e+98%       0.00 ±223%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.02 ± 88%     +78.0%       0.03 ± 61%  perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.00 ± 57%     +52.0%       0.01 ± 37%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ± 20%     -10.6%       0.01 ± 37%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 62%     -18.4%       0.01 ± 13%  perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      2.22 ± 72%     -77.1%       0.51 ±223%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      0.01 ± 41%   +2422.6%       0.22 ±210%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 18%      -5.8%       0.01 ± 18%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.24 ±209%     -95.9%       0.01 ± 22%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.18 ± 85%     -61.6%       0.07 ±200%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.20 ±138%    +124.9%       0.45 ± 65%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.02 ±115%     +13.0%       0.02 ± 87%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00        +6.7e+98%       0.00 ±223%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.03 ± 96%     +93.0%       0.05 ± 69%  perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.02 ± 72%     +85.6%       0.03 ± 35%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ± 11%      -9.8%       0.01 ± 29%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.30 ±140%     -68.3%       0.10 ± 60%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      2.22 ± 72%     -77.1%       0.51 ±223%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      0.03 ± 47%   +5187.6%       1.50 ±217%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 18%      -5.8%       0.01 ± 18%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.69 ±214%     -97.7%       0.02 ± 44%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     12.69 ± 87%     -67.0%       4.19 ±221%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      1.26 ±143%     +99.5%       2.52 ± 44%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.08 ± 75%     -56.4%       0.03 ±104%  perf-sched.total_sch_delay.average.ms
     13.70 ± 73%     -44.2%       7.64 ±105%  perf-sched.total_sch_delay.max.ms
      0.93 ± 45%     -20.0%       0.75 ± 57%  perf-sched.total_wait_and_delay.average.ms
    296.50 ± 23%     +14.2%     338.67 ± 14%  perf-sched.total_wait_and_delay.count.ms
     25.18 ± 35%     -15.9%      21.19 ± 55%  perf-sched.total_wait_and_delay.max.ms
      0.86 ± 46%     -16.7%       0.71 ± 61%  perf-sched.total_wait_time.average.ms
     21.56 ± 51%     -14.9%      18.35 ± 67%  perf-sched.total_wait_time.max.ms
      0.77 ±100%     +42.2%       1.09 ± 45%  perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.05 ±223%     -98.6%       0.00 ±223%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1.00 ± 71%     +37.1%       1.37 ±  8%  perf-sched.wait_and_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      1.30 ±166%     -80.0%       0.26 ±172%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.06 ±136%   +2050.5%       1.38 ±223%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.06 ±191%     -90.9%       0.01 ± 61%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.06 ± 17%      +0.8%       0.06 ± 12%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.03 ±223%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      2.22 ± 72%     -77.1%       0.51 ±223%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      0.00        +1.7e+99%       0.00 ±223%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.22 ± 93%     +26.1%       0.28 ± 96%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      1.70 ± 46%      -9.7%       1.54 ± 46%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 18%     -24.6%       0.01 ± 49%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      3.53 ± 11%      -1.7%       3.47 ± 11%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      2.65 ± 52%     -13.9%       2.29 ± 69%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.28 ±143%     +70.0%       0.47 ± 62%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
      1.00 ±100%     +66.7%       1.67 ± 44%  perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.33 ±141%      +0.0%       0.33 ±141%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1.33 ± 70%     +50.0%       2.00        perf-sched.wait_and_delay.count.do_syslog.part.0.kmsg_read.vfs_read
      5.67 ± 26%     +23.5%       7.00 ± 27%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.83 ± 44%     -60.0%       0.33 ±141%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.00       +1.7e+101%       0.17 ±223%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.17 ±223%    +200.0%       0.50 ±152%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      1.17 ± 31%     -14.3%       1.00 ± 57%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
    117.33 ± 59%     +26.1%     148.00 ± 14%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00       +1.7e+101%       0.17 ±223%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__fput.task_work_run.exit_to_user_mode_prepare
      1.00            +0.0%       1.00 ± 57%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.17 ±223%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.dput.path_put.vfs_statx
      0.00       +1.7e+101%       0.17 ±223%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.17 ±223%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_lookupat
      0.17 ±223%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__alloc_file.alloc_empty_file
      0.17 ±223%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_flags.do_sys_openat2
      0.67 ± 70%     -75.0%       0.17 ±223%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      0.17 ±223%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      0.17 ±223%    +100.0%       0.33 ±141%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.17 ±223%      +0.0%       0.17 ±223%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
     73.17 ± 12%      +5.7%      77.33 ± 16%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      5.33 ± 25%     +21.9%       6.50 ± 14%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1.00           -16.7%       0.83 ± 44%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      7.17 ± 38%     -16.3%       6.00 ± 49%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     74.33 ± 11%      +4.9%      78.00 ± 17%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
      4.83 ± 36%     +27.6%       6.17 ± 27%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      1.53 ±100%     +42.0%       2.17 ± 45%  perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.05 ±223%     -98.6%       0.00 ±223%  perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1.98 ± 71%     +36.2%       2.70 ±  8%  perf-sched.wait_and_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      5.88 ±144%     -72.3%       1.63 ±191%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.06 ±136%   +2050.5%       1.38 ±223%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.11 ±206%     -94.5%       0.01 ± 56%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.58 ± 85%    +101.6%       1.17 ±149%  perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.03 ±223%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      2.22 ± 72%     -77.1%       0.51 ±223%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      0.00        +1.7e+99%       0.00 ±223%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
     10.58 ±103%      -3.7%      10.19 ± 71%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      5.73 ± 64%      -4.7%       5.47 ± 71%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 18%     -24.6%       0.01 ± 49%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      4.82 ±  7%      +3.9%       5.01        perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     25.18 ± 35%     -16.2%      21.12 ± 55%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      1.27 ±142%     +98.7%       2.52 ± 44%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.76 ±100%     +42.7%       1.08 ± 45%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.05 ±223%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.99 ± 71%     +36.4%       1.34 ±  8%  perf-sched.wait_time.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      1.29 ±166%     -80.4%       0.25 ±176%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.06 ±136%   +2050.5%       1.38 ±223%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.05 ±223%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.06 ± 15%      +2.9%       0.06 ± 14%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.03 ±223%     +32.9%       0.04 ±223%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.00        +1.7e+99%       0.00 ±223%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.22 ± 93%     +26.1%       0.28 ± 96%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      1.70 ± 46%     -22.4%       1.32 ± 38%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      3.30 ±  7%      +5.0%       3.46 ± 11%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      2.47 ± 55%     -10.4%       2.22 ± 73%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.08 ±219%     -72.3%       0.02 ±223%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      1.51 ±100%     +42.7%       2.16 ± 45%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.05 ±223%    -100.0%       0.00        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1.97 ± 71%     +36.4%       2.69 ±  8%  perf-sched.wait_time.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      5.88 ±144%     -72.3%       1.63 ±191%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.06 ±136%   +2050.5%       1.38 ±223%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.10 ±223%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.44 ± 92%    +156.8%       1.14 ±148%  perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.03 ±223%     +32.9%       0.04 ±223%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.00        +1.7e+99%       0.00 ±223%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
     10.58 ±103%      -3.7%      10.19 ± 71%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      5.73 ± 64%     -18.5%       4.67 ± 77%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      4.81 ±  7%      +3.9%       5.00        perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     19.66 ± 58%      -9.4%      17.82 ± 72%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.62 ±220%     -75.5%       0.15 ±223%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
      3228            -0.8%       3202        softirqs.BLOCK
      4.83 ±134%     -20.7%       3.83 ±223%  softirqs.CPU0.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU0.HI
      1.00            +0.0%       1.00        softirqs.CPU0.NET_RX
      0.00       +3.3e+101%       0.33 ±141%  softirqs.CPU0.NET_TX
     16126 ± 15%      +1.2%      16317 ± 18%  softirqs.CPU0.RCU
     13026 ±  4%      -4.8%      12404 ± 13%  softirqs.CPU0.SCHED
     48.33            +1.4%      49.00        softirqs.CPU0.TASKLET
      1371 ± 32%     -17.8%       1127 ± 38%  softirqs.CPU0.TIMER
      4.00 ±223%      +0.0%       4.00 ±223%  softirqs.CPU1.BLOCK
      1.00            +0.0%       1.00        softirqs.CPU1.NET_RX
      0.17 ±223%      +0.0%       0.17 ±223%  softirqs.CPU1.NET_TX
     13978 ± 14%      +0.5%      14052 ± 16%  softirqs.CPU1.RCU
     10998 ±  6%      +7.3%      11805 ±  8%  softirqs.CPU1.SCHED
      8.33 ±124%     -50.0%       4.17 ± 73%  softirqs.CPU1.TASKLET
    149.50 ± 76%     +77.1%     264.83 ± 54%  softirqs.CPU1.TIMER
      0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU10.BLOCK
     11811 ± 12%     +19.8%      14156 ± 12%  softirqs.CPU10.RCU
      7972 ± 35%     +11.7%       8904 ± 29%  softirqs.CPU10.SCHED
      0.67 ±111%    +650.0%       5.00 ±162%  softirqs.CPU10.TASKLET
    344.50 ± 61%     +17.9%     406.00 ±125%  softirqs.CPU10.TIMER
      8.00 ±141%     -25.0%       6.00 ±171%  softirqs.CPU11.BLOCK
      0.00       +1.8e+102%       1.83 ±223%  softirqs.CPU11.NET_TX
     11717 ± 13%     +14.0%      13358 ± 13%  softirqs.CPU11.RCU
      9856 ± 14%      -0.0%       9853 ± 23%  softirqs.CPU11.SCHED
      0.00       +1.2e+102%       1.17 ±187%  softirqs.CPU11.TASKLET
    389.00 ±116%     -44.0%     217.67 ± 50%  softirqs.CPU11.TIMER
     28.83 ±149%     -44.5%      16.00 ±141%  softirqs.CPU12.BLOCK
      1.83 ±223%    -100.0%       0.00        softirqs.CPU12.NET_TX
     11058 ± 10%     +16.0%      12832 ±  9%  softirqs.CPU12.RCU
     10225 ± 11%      +6.4%      10883 ±  3%  softirqs.CPU12.SCHED
      1.17 ±125%    -100.0%       0.00        softirqs.CPU12.TASKLET
    235.67 ± 33%     +72.6%     406.67 ±130%  softirqs.CPU12.TIMER
     22.83 ±118%     -35.0%      14.83 ±175%  softirqs.CPU13.BLOCK
     11592 ± 11%      +2.2%      11843 ± 22%  softirqs.CPU13.RCU
     11043 ±  2%      -3.1%      10704 ±  3%  softirqs.CPU13.SCHED
      0.50 ±223%    -100.0%       0.00        softirqs.CPU13.TASKLET
    437.17 ± 95%     -50.3%     217.33 ± 32%  softirqs.CPU13.TIMER
      0.33 ±223%   +6550.0%      22.17 ±106%  softirqs.CPU14.BLOCK
     12398 ± 11%      +7.1%      13275 ± 15%  softirqs.CPU14.RCU
     11042 ±  6%      +0.1%      11055 ±  4%  softirqs.CPU14.SCHED
      3.17 ± 69%     -36.8%       2.00        softirqs.CPU14.TASKLET
    426.83 ±105%     -61.4%     164.83 ± 86%  softirqs.CPU14.TIMER
     31.33 ± 99%     -55.9%      13.83 ±217%  softirqs.CPU15.BLOCK
      1.67 ±223%    -100.0%       0.00        softirqs.CPU15.NET_TX
     12171 ± 14%      +1.3%      12332 ± 10%  softirqs.CPU15.RCU
     11135 ±  4%      -2.4%      10873 ±  3%  softirqs.CPU15.SCHED
      2.00            +0.0%       2.00        softirqs.CPU15.TASKLET
    421.33 ± 53%     -54.9%     190.17 ± 41%  softirqs.CPU15.TIMER
      5.17 ±223%     -41.9%       3.00 ±223%  softirqs.CPU16.BLOCK
      1.67 ±197%    -100.0%       0.00        softirqs.CPU16.NET_TX
     13161 ± 17%      -6.0%      12376 ± 17%  softirqs.CPU16.RCU
     11077 ±  3%      -4.1%      10626 ±  2%  softirqs.CPU16.SCHED
      1.83 ± 20%     +18.2%       2.17 ± 17%  softirqs.CPU16.TASKLET
    410.50 ± 88%      -2.6%     400.00 ± 58%  softirqs.CPU16.TIMER
     13.00 ±144%      +9.0%      14.17 ±208%  softirqs.CPU17.BLOCK
      0.17 ±223%    -100.0%       0.00        softirqs.CPU17.NET_TX
     12908 ± 12%      +3.0%      13299 ± 18%  softirqs.CPU17.RCU
     10400 ± 11%      +4.2%      10840 ±  4%  softirqs.CPU17.SCHED
      2.00            +0.0%       2.00        softirqs.CPU17.TASKLET
    227.33 ± 60%    +113.0%     484.17 ± 96%  softirqs.CPU17.TIMER
     33.67 ± 44%     -50.5%      16.67 ±118%  softirqs.CPU18.BLOCK
     12945 ± 15%      +2.8%      13305 ± 13%  softirqs.CPU18.RCU
      9082 ± 25%     +16.8%      10607        softirqs.CPU18.SCHED
      2.17 ± 17%      -7.7%       2.00        softirqs.CPU18.TASKLET
    357.83 ± 75%     -67.8%     115.33 ± 47%  softirqs.CPU18.TIMER
     34.00 ± 92%     -77.5%       7.67 ±223%  softirqs.CPU19.BLOCK
     12801 ± 17%      +3.1%      13192 ± 17%  softirqs.CPU19.RCU
     10374 ± 17%      +3.8%      10764 ±  4%  softirqs.CPU19.SCHED
      2.17 ± 17%     +23.1%       2.67 ± 55%  softirqs.CPU19.TASKLET
    514.17 ±112%     -21.7%     402.67 ±153%  softirqs.CPU19.TIMER
     14.00 ± 78%     -35.7%       9.00 ±142%  softirqs.CPU2.BLOCK
      1.00            +0.0%       1.00        softirqs.CPU2.NET_RX
      0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU2.NET_TX
     13439 ± 14%     +10.9%      14900 ± 13%  softirqs.CPU2.RCU
     10472 ± 12%     +10.2%      11541 ±  6%  softirqs.CPU2.SCHED
      1.67 ± 44%    +190.0%       4.83 ±103%  softirqs.CPU2.TASKLET
    359.83 ± 40%     +28.1%     460.83 ± 76%  softirqs.CPU2.TIMER
     10.17 ±158%   +3593.4%     375.50 ±209%  softirqs.CPU20.BLOCK
     12471 ± 15%      +2.5%      12779 ± 10%  softirqs.CPU20.RCU
     10736            -1.9%      10527        softirqs.CPU20.SCHED
      2.00            +0.0%       2.00        softirqs.CPU20.TASKLET
    139.00 ± 49%      +4.1%     144.67 ± 48%  softirqs.CPU20.TIMER
      1.50 ±195%   +1488.9%      23.83 ±143%  softirqs.CPU21.BLOCK
     12549 ± 15%      +0.5%      12616 ± 14%  softirqs.CPU21.RCU
     11017 ±  4%      -4.7%      10503 ±  2%  softirqs.CPU21.SCHED
      2.00           +41.7%       2.83 ± 51%  softirqs.CPU21.TASKLET
    423.17 ±110%     -54.0%     194.50 ± 68%  softirqs.CPU21.TIMER
     17.50 ±134%     -75.2%       4.33 ±203%  softirqs.CPU22.BLOCK
     12495 ± 10%      -3.2%      12097 ± 13%  softirqs.CPU22.RCU
      9892 ± 23%      +7.3%      10612 ±  2%  softirqs.CPU22.SCHED
    260.33 ± 88%     +37.3%     357.33 ±126%  softirqs.CPU22.TIMER
     11.67 ±152%    +102.9%      23.67 ± 91%  softirqs.CPU23.BLOCK
     11744 ± 15%      +7.6%      12640 ± 22%  softirqs.CPU23.RCU
      8209 ±  5%      -4.7%       7819 ± 25%  softirqs.CPU23.SCHED
      4.33 ±177%    -100.0%       0.00        softirqs.CPU23.TASKLET
    204.17 ± 77%     -13.1%     177.50 ± 70%  softirqs.CPU23.TIMER
      0.00         +4e+102%       4.00 ±223%  softirqs.CPU24.BLOCK
     11513 ± 15%     +21.7%      14013 ± 18%  softirqs.CPU24.RCU
      7963 ± 32%     +26.2%      10052 ± 19%  softirqs.CPU24.SCHED
      4.50 ±223%     -66.7%       1.50 ±195%  softirqs.CPU24.TASKLET
    341.50 ± 64%     +38.3%     472.33 ± 62%  softirqs.CPU24.TIMER
      8.67 ±142%    -100.0%       0.00        softirqs.CPU25.BLOCK
     12053 ± 15%     +22.0%      14703 ± 21%  softirqs.CPU25.RCU
     10613 ±  2%     -16.4%       8871 ± 29%  softirqs.CPU25.SCHED
      1.00 ±223%    +316.7%       4.17 ±223%  softirqs.CPU25.TASKLET
    313.67 ± 52%      -8.8%     286.17 ± 97%  softirqs.CPU25.TIMER
      6.50 ±149%    -100.0%       0.00        softirqs.CPU26.BLOCK
    165.17 ± 41%     +84.5%     304.67 ±162%  softirqs.CPU26.NET_RX
      1.67 ± 28%    +220.0%       5.33 ± 95%  softirqs.CPU26.NET_TX
     12118 ± 17%     +20.7%      14623 ± 19%  softirqs.CPU26.RCU
      9437 ± 24%     +20.8%      11405 ± 10%  softirqs.CPU26.SCHED
      1.00 ±100%     -16.7%       0.83 ± 82%  softirqs.CPU26.TASKLET
    431.83 ± 34%     -48.4%     222.67 ± 76%  softirqs.CPU26.TIMER
      5.33 ±115%     -90.6%       0.50 ±223%  softirqs.CPU27.BLOCK
    528.33 ± 85%     +14.2%     603.33 ±183%  softirqs.CPU27.NET_RX
      2.83 ±146%      +0.0%       2.83 ±131%  softirqs.CPU27.NET_TX
     12574 ± 14%     +31.1%      16486 ± 19%  softirqs.CPU27.RCU
     10430 ±  9%      +9.9%      11465 ±  6%  softirqs.CPU27.SCHED
      0.00       +8.3e+101%       0.83 ±175%  softirqs.CPU27.TASKLET
    261.00 ± 75%     +12.9%     294.67 ±116%  softirqs.CPU27.TIMER
      2.67 ±223%    +168.8%       7.17 ± 95%  softirqs.CPU28.BLOCK
    171.67 ± 89%   +1305.2%       2412 ±147%  softirqs.CPU28.NET_RX
      2.17 ± 41%     -23.1%       1.67 ± 56%  softirqs.CPU28.NET_TX
     12389 ± 14%     +12.5%      13937 ± 18%  softirqs.CPU28.RCU
     10206 ± 13%      +6.5%      10867 ± 13%  softirqs.CPU28.SCHED
      7.33 ±168%     -79.5%       1.50 ±195%  softirqs.CPU28.TASKLET
    294.83 ± 59%     -13.3%     255.50 ±128%  softirqs.CPU28.TIMER
      1.50 ±195%    +488.9%       8.83 ±136%  softirqs.CPU29.BLOCK
    474.50 ±142%     +45.7%     691.50 ±193%  softirqs.CPU29.NET_RX
      0.50 ±100%    +100.0%       1.00 ±100%  softirqs.CPU29.NET_TX
     13356 ±  8%     +10.3%      14726 ± 19%  softirqs.CPU29.RCU
     10338 ± 16%      +7.0%      11062 ± 10%  softirqs.CPU29.SCHED
      0.17 ±223%    +700.0%       1.33 ±223%  softirqs.CPU29.TASKLET
    213.50 ± 83%     +17.1%     250.00 ± 97%  softirqs.CPU29.TIMER
      6.00 ±146%     +13.9%       6.83 ±139%  softirqs.CPU3.BLOCK
      1.00            +0.0%       1.00        softirqs.CPU3.NET_RX
      0.00       +1.5e+102%       1.50 ±223%  softirqs.CPU3.NET_TX
     13380 ± 11%      +5.6%      14135 ± 20%  softirqs.CPU3.RCU
     10839 ±  4%      -4.2%      10381 ± 19%  softirqs.CPU3.SCHED
      3.67 ±101%      +0.0%       3.67 ±114%  softirqs.CPU3.TASKLET
    230.67 ± 42%     +48.0%     341.33 ± 61%  softirqs.CPU3.TIMER
      0.17 ±223%   +1900.0%       3.33 ±145%  softirqs.CPU30.BLOCK
      1489 ±135%     -86.5%     201.00 ±107%  softirqs.CPU30.NET_RX
      1.67 ± 44%     +10.0%       1.83 ± 48%  softirqs.CPU30.NET_TX
     13069 ± 19%      +6.8%      13961 ± 20%  softirqs.CPU30.RCU
     11098 ±  3%      +4.7%      11617 ±  4%  softirqs.CPU30.SCHED
    390.33 ±102%      -2.4%     381.00 ±106%  softirqs.CPU30.TIMER
      7.00 ±152%     +57.1%      11.00 ±106%  softirqs.CPU31.BLOCK
      2616 ±163%     -93.1%     181.67 ± 86%  softirqs.CPU31.NET_RX
      0.83 ±107%     +20.0%       1.00 ± 57%  softirqs.CPU31.NET_TX
     12326 ±  8%     +15.4%      14224 ± 19%  softirqs.CPU31.RCU
      9520 ± 29%     +17.5%      11190 ± 12%  softirqs.CPU31.SCHED
      0.00       +3.5e+102%       3.50 ±211%  softirqs.CPU31.TASKLET
    161.83 ± 54%    +260.1%     582.83 ± 68%  softirqs.CPU31.TIMER
      4.67 ±141%     -57.1%       2.00 ±223%  softirqs.CPU32.BLOCK
    199.00 ±109%      -2.3%     194.33 ± 53%  softirqs.CPU32.NET_RX
      1.67 ± 28%     -20.0%       1.33 ± 35%  softirqs.CPU32.NET_TX
     10997 ±  8%     +24.3%      13672 ± 18%  softirqs.CPU32.RCU
     11101 ±  4%      -4.2%      10631 ± 17%  softirqs.CPU32.SCHED
      1.67 ±223%    -100.0%       0.00        softirqs.CPU32.TASKLET
    362.17 ± 67%     -30.6%     251.50 ±100%  softirqs.CPU32.TIMER
      3.83 ±223%     -26.1%       2.83 ±223%  softirqs.CPU33.BLOCK
    180.00 ±116%    +234.0%     601.17 ±139%  softirqs.CPU33.NET_RX
      1.17 ± 31%     +14.3%       1.33 ± 70%  softirqs.CPU33.NET_TX
     11241 ±  9%     +15.3%      12963 ± 18%  softirqs.CPU33.RCU
     10370 ± 13%     +11.2%      11530 ±  3%  softirqs.CPU33.SCHED
      2.33 ±223%     -85.7%       0.33 ±223%  softirqs.CPU33.TASKLET
    271.83 ± 55%     -31.0%     187.67 ± 82%  softirqs.CPU33.TIMER
      0.17 ±223%   +2100.0%       3.67 ±211%  softirqs.CPU34.BLOCK
      1.67 ±223%    -100.0%       0.00        softirqs.CPU34.NET_TX
     11565 ± 11%     +21.8%      14091 ± 20%  softirqs.CPU34.RCU
     11008            +6.2%      11686 ±  4%  softirqs.CPU34.SCHED
      2.17 ±136%    -100.0%       0.00        softirqs.CPU34.TASKLET
    363.33 ± 49%     -22.5%     281.67 ± 53%  softirqs.CPU34.TIMER
      2.50 ±206%    -100.0%       0.00        softirqs.CPU35.BLOCK
      1.00            +0.0%       1.00        softirqs.CPU35.NET_RX
      1.83 ±223%      +0.0%       1.83 ±223%  softirqs.CPU35.NET_TX
     10541 ± 14%     +30.3%      13733 ± 13%  softirqs.CPU35.RCU
     10778 ±  3%      -1.3%      10636 ± 15%  softirqs.CPU35.SCHED
      2.00           +83.3%       3.67 ±101%  softirqs.CPU35.TASKLET
    330.17 ± 72%     +77.7%     586.67 ± 91%  softirqs.CPU35.TIMER
     24.83 ± 99%     +10.1%      27.33 ± 84%  softirqs.CPU36.BLOCK
     13910 ± 17%      +3.1%      14344 ± 17%  softirqs.CPU36.RCU
     10932 ±  3%      +3.7%      11339 ±  7%  softirqs.CPU36.SCHED
      5.00 ±190%     -20.0%       4.00 ±212%  softirqs.CPU36.TASKLET
    264.50 ± 44%    +238.2%     894.67 ± 75%  softirqs.CPU36.TIMER
    374.33 ±215%     -87.9%      45.33 ±136%  softirqs.CPU37.BLOCK
      0.17 ±223%    -100.0%       0.00        softirqs.CPU37.NET_TX
     13768 ± 15%      -0.6%      13688 ± 18%  softirqs.CPU37.RCU
      9835 ± 24%     +13.3%      11143 ±  3%  softirqs.CPU37.SCHED
      0.17 ±223%    -100.0%       0.00        softirqs.CPU37.TASKLET
    191.83 ± 95%     +15.3%     221.17 ± 67%  softirqs.CPU37.TIMER
     61.33 ±169%     -60.3%      24.33 ±105%  softirqs.CPU38.BLOCK
     13829 ± 18%      -1.3%      13648 ± 19%  softirqs.CPU38.RCU
     10956 ±  5%      +2.2%      11198 ±  5%  softirqs.CPU38.SCHED
      0.50 ±223%    -100.0%       0.00        softirqs.CPU38.TASKLET
    216.00 ± 51%     +31.2%     283.33 ± 57%  softirqs.CPU38.TIMER
      7.00 ±135%     +33.3%       9.33 ±196%  softirqs.CPU39.BLOCK
     14537 ± 17%      -4.2%      13932 ± 19%  softirqs.CPU39.RCU
     10366 ± 11%      +6.0%      10985 ±  2%  softirqs.CPU39.SCHED
      2.00 ±152%    -100.0%       0.00        softirqs.CPU39.TASKLET
    127.67 ± 45%     +81.5%     231.67 ± 62%  softirqs.CPU39.TIMER
      1.00            +0.0%       1.00        softirqs.CPU4.NET_RX
     12843 ± 11%     +17.4%      15083 ± 26%  softirqs.CPU4.RCU
     10146 ±  9%      +9.4%      11104 ±  6%  softirqs.CPU4.SCHED
      3.33 ± 95%    +105.0%       6.83 ±133%  softirqs.CPU4.TASKLET
    526.33 ± 78%      +0.5%     528.83 ± 72%  softirqs.CPU4.TIMER
    378.33 ±213%     -84.5%      58.67 ±102%  softirqs.CPU40.BLOCK
     14784 ± 22%      +0.7%      14891 ± 18%  softirqs.CPU40.RCU
     11063 ±  4%      -3.5%      10674 ± 12%  softirqs.CPU40.SCHED
      0.83 ±223%    -100.0%       0.00        softirqs.CPU40.TASKLET
    120.17 ± 44%    +175.3%     330.83 ±144%  softirqs.CPU40.TIMER
    382.67 ±213%     -93.2%      26.00 ±100%  softirqs.CPU41.BLOCK
     13960 ± 19%      +4.2%      14542 ± 18%  softirqs.CPU41.RCU
     10367 ± 16%      -4.2%       9933 ± 29%  softirqs.CPU41.SCHED
      0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU41.TASKLET
    223.33 ± 73%     -45.4%     122.00 ± 65%  softirqs.CPU41.TIMER
      3.33 ±197%    +455.0%      18.50 ±155%  softirqs.CPU42.BLOCK
      0.17 ±223%    -100.0%       0.00        softirqs.CPU42.NET_TX
     14572 ± 15%      -0.3%      14526 ± 20%  softirqs.CPU42.RCU
     10616 ±  5%      -9.8%       9578 ± 28%  softirqs.CPU42.SCHED
      3.00 ±223%     +55.6%       4.67 ±141%  softirqs.CPU42.TASKLET
    249.17 ± 61%     -19.4%     200.83 ± 67%  softirqs.CPU42.TIMER
      9.00 ±109%     +96.3%      17.67 ±116%  softirqs.CPU43.BLOCK
     14197 ± 18%      +4.3%      14801 ± 16%  softirqs.CPU43.RCU
     10735 ± 13%      +1.6%      10911        softirqs.CPU43.SCHED
      1.67 ±157%    -100.0%       0.00        softirqs.CPU43.TASKLET
    422.67 ±112%     -54.5%     192.33 ± 75%  softirqs.CPU43.TIMER
     48.67 ±185%     -80.8%       9.33 ±141%  softirqs.CPU44.BLOCK
     13418 ± 15%      +3.0%      13815 ± 13%  softirqs.CPU44.RCU
     10443 ± 16%      +4.0%      10857        softirqs.CPU44.SCHED
      0.50 ±223%    -100.0%       0.00        softirqs.CPU44.TASKLET
    221.00 ± 34%     -23.7%     168.67 ± 52%  softirqs.CPU44.TIMER
     14.17 ±151%     +48.2%      21.00 ±219%  softirqs.CPU45.BLOCK
     13633 ± 18%      +4.7%      14273 ± 20%  softirqs.CPU45.RCU
      9909 ± 24%     +10.1%      10905        softirqs.CPU45.SCHED
      0.17 ±223%      +0.0%       0.17 ±223%  softirqs.CPU45.TASKLET
    159.33 ± 52%     +18.5%     188.83 ± 86%  softirqs.CPU45.TIMER
     17.50 ±141%     -72.4%       4.83 ±223%  softirqs.CPU46.BLOCK
     13005 ± 15%      +0.5%      13074 ± 18%  softirqs.CPU46.RCU
     10887 ±  3%      -0.2%      10864        softirqs.CPU46.SCHED
      0.33 ±223%    -100.0%       0.00        softirqs.CPU46.TASKLET
    345.00 ± 64%     -45.6%     187.67 ± 77%  softirqs.CPU46.TIMER
     19.00 ±122%    -100.0%       0.00        softirqs.CPU47.BLOCK
     13356 ± 18%      -5.5%      12627 ± 21%  softirqs.CPU47.RCU
     10376 ±  4%      -6.4%       9715 ± 15%  softirqs.CPU47.SCHED
      0.50 ±152%    -100.0%       0.00        softirqs.CPU47.TASKLET
    206.67 ± 70%     +16.2%     240.17 ± 86%  softirqs.CPU47.TIMER
      8.00 ±141%     -64.6%       2.83 ±223%  softirqs.CPU5.BLOCK
      1.00            +0.0%       1.00        softirqs.CPU5.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU5.NET_TX
     12761 ± 14%      +3.7%      13236 ± 22%  softirqs.CPU5.RCU
     10620 ±  2%      +1.4%      10764 ±  8%  softirqs.CPU5.SCHED
      2.00          +325.0%       8.50 ±110%  softirqs.CPU5.TASKLET
    214.50 ± 49%    +177.5%     595.33 ± 60%  softirqs.CPU5.TIMER
      0.17 ±223%   +1100.0%       2.00 ±223%  softirqs.CPU6.BLOCK
      1.00            +0.0%       1.00        softirqs.CPU6.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU6.NET_TX
     12007 ± 12%      +7.9%      12957 ± 18%  softirqs.CPU6.RCU
     10068 ±  9%      +7.8%      10850        softirqs.CPU6.SCHED
      2.33 ± 31%     +64.3%       3.83 ±106%  softirqs.CPU6.TASKLET
    299.33 ± 43%     -52.1%     143.33 ± 35%  softirqs.CPU6.TIMER
    884.83 ±142%     -95.2%      42.67 ±205%  softirqs.CPU7.BLOCK
      0.17 ±223%    -100.0%       0.00        softirqs.CPU7.NET_TX
     12243 ± 15%      +8.2%      13245 ± 18%  softirqs.CPU7.RCU
     10621 ±  2%      +6.1%      11267 ±  5%  softirqs.CPU7.SCHED
      1122 ±141%     -50.7%     553.50 ±223%  softirqs.CPU7.TASKLET
    462.83 ± 68%      +2.6%     474.83 ± 51%  softirqs.CPU7.TIMER
    703.67 ±150%    +224.4%       2282 ± 45%  softirqs.CPU8.BLOCK
     12176 ± 14%      +8.3%      13192 ± 13%  softirqs.CPU8.RCU
     10114 ±  9%      +8.7%      10996 ±  2%  softirqs.CPU8.SCHED
      2282 ± 70%     +23.9%       2826 ± 44%  softirqs.CPU8.TASKLET
    373.83 ± 85%     -14.7%     319.00 ± 67%  softirqs.CPU8.TIMER
      0.50 ±100%    -100.0%       0.00        softirqs.CPU9.BLOCK
      0.00       +1.7e+101%       0.17 ±223%  softirqs.CPU9.HI
     13374 ± 20%      +8.7%      14541 ± 19%  softirqs.CPU9.RCU
     10508 ±  2%      +6.2%      11157        softirqs.CPU9.SCHED
     83.83 ±  2%      -1.0%      83.00        softirqs.CPU9.TASKLET
    607.50 ± 68%     -20.4%     483.50 ± 57%  softirqs.CPU9.TIMER
      2.00            +8.3%       2.17 ± 17%  softirqs.HI
      5834 ± 57%     -10.9%       5200 ± 79%  softirqs.NET_RX
     23.00 ±  8%      +2.2%      23.50 ±  5%  softirqs.NET_TX
    614891 ± 13%      +7.5%     661084 ± 15%  softirqs.RCU
    498848 ±  2%      +3.4%     515988        softirqs.SCHED
      3619            -0.6%       3596        softirqs.TASKLET
     15881            +0.4%      15943 ±  2%  softirqs.TIMER
    133494            -0.0%     133479        slabinfo.Acpi-Operand.active_objs
      2385            -0.0%       2385        slabinfo.Acpi-Operand.active_slabs
    133606            -0.0%     133560        slabinfo.Acpi-Operand.num_objs
      2385            -0.0%       2385        slabinfo.Acpi-Operand.num_slabs
      1152 ±  9%      -4.3%       1103 ±  7%  slabinfo.Acpi-Parse.active_objs
     15.17 ± 11%      -5.5%      14.33 ±  7%  slabinfo.Acpi-Parse.active_slabs
      1152 ±  9%      -4.3%       1103 ±  7%  slabinfo.Acpi-Parse.num_objs
     15.17 ± 11%      -5.5%      14.33 ±  7%  slabinfo.Acpi-Parse.num_slabs
      2515            +0.3%       2523        slabinfo.Acpi-State.active_objs
     49.17            -0.3%      49.00        slabinfo.Acpi-State.active_slabs
      2515            +0.3%       2523        slabinfo.Acpi-State.num_objs
     49.17            -0.3%      49.00        slabinfo.Acpi-State.num_slabs
      1310 ±  5%     -25.1%     980.83 ± 18%  slabinfo.PING.active_objs
     40.50 ±  5%     -25.1%      30.33 ± 17%  slabinfo.PING.active_slabs
      1310 ±  5%     -25.1%     980.83 ± 18%  slabinfo.PING.num_objs
     40.50 ±  5%     -25.1%      30.33 ± 17%  slabinfo.PING.num_slabs
    352.00            +0.0%     352.00        slabinfo.RAW.active_objs
     11.00            +0.0%      11.00        slabinfo.RAW.active_slabs
    352.00            +0.0%     352.00        slabinfo.RAW.num_objs
     11.00            +0.0%      11.00        slabinfo.RAW.num_slabs
    182.00            +0.0%     182.00        slabinfo.RAWv6.active_objs
      7.00            +0.0%       7.00        slabinfo.RAWv6.active_slabs
    182.00            +0.0%     182.00        slabinfo.RAWv6.num_objs
      7.00            +0.0%       7.00        slabinfo.RAWv6.num_slabs
     56.00            -8.3%      51.33 ± 12%  slabinfo.TCP.active_objs
      4.00            -8.3%       3.67 ± 12%  slabinfo.TCP.active_slabs
     56.00            -8.3%      51.33 ± 12%  slabinfo.TCP.num_objs
      4.00            -8.3%       3.67 ± 12%  slabinfo.TCP.num_slabs
     39.00            -5.6%      36.83 ± 13%  slabinfo.TCPv6.active_objs
      3.00            -5.6%       2.83 ± 13%  slabinfo.TCPv6.active_slabs
     39.00            -5.6%      36.83 ± 13%  slabinfo.TCPv6.num_objs
      3.00            -5.6%       2.83 ± 13%  slabinfo.TCPv6.num_slabs
    124.67 ± 12%      +6.6%     132.83 ± 13%  slabinfo.UDPv6.active_objs
      5.17 ± 13%      +6.5%       5.50 ± 13%  slabinfo.UDPv6.active_slabs
    124.67 ± 12%      +6.6%     132.83 ± 13%  slabinfo.UDPv6.num_objs
      5.17 ± 13%      +6.5%       5.50 ± 13%  slabinfo.UDPv6.num_slabs
     14646 ±  2%      -3.5%      14136 ±  3%  slabinfo.anon_vma.active_objs
    318.00 ±  2%      -3.5%     306.83 ±  3%  slabinfo.anon_vma.active_slabs
     14646 ±  2%      -3.5%      14136 ±  3%  slabinfo.anon_vma.num_objs
    318.00 ±  2%      -3.5%     306.83 ±  3%  slabinfo.anon_vma.num_slabs
     38145           +16.5%      44457        slabinfo.anon_vma_chain.active_objs
    600.50           +16.0%     696.50        slabinfo.anon_vma_chain.active_slabs
     38466           +16.0%      44610        slabinfo.anon_vma_chain.num_objs
    600.50           +16.0%     696.50        slabinfo.anon_vma_chain.num_slabs
    116.67 ± 11%     +17.1%     136.67 ± 13%  slabinfo.bdev_cache.active_objs
      5.83 ± 11%     +17.1%       6.83 ± 13%  slabinfo.bdev_cache.active_slabs
    116.67 ± 11%     +17.1%     136.67 ± 13%  slabinfo.bdev_cache.num_objs
      5.83 ± 11%     +17.1%       6.83 ± 13%  slabinfo.bdev_cache.num_slabs
    162.67 ± 19%      +4.9%     170.67 ± 11%  slabinfo.biovec-128.active_objs
     10.17 ± 19%      +4.9%      10.67 ± 11%  slabinfo.biovec-128.active_slabs
    162.67 ± 19%      +4.9%     170.67 ± 11%  slabinfo.biovec-128.num_objs
     10.17 ± 19%      +4.9%      10.67 ± 11%  slabinfo.biovec-128.num_slabs
    426.67 ±  8%     -11.2%     378.67 ± 11%  slabinfo.biovec-64.active_objs
     13.33 ±  8%     -11.2%      11.83 ± 11%  slabinfo.biovec-64.active_slabs
    426.67 ±  8%     -11.2%     378.67 ± 11%  slabinfo.biovec-64.num_objs
     13.33 ±  8%     -11.2%      11.83 ± 11%  slabinfo.biovec-64.num_slabs
    122.83 ± 11%      +3.1%     126.67 ±  8%  slabinfo.biovec-max.active_objs
     15.83 ± 11%      +3.2%      16.33 ± 10%  slabinfo.biovec-max.active_slabs
    130.50 ± 12%      +3.1%     134.50 ± 10%  slabinfo.biovec-max.num_objs
     15.83 ± 11%      +3.2%      16.33 ± 10%  slabinfo.biovec-max.num_slabs
    438.50 ±  7%      -5.8%     413.17 ±  9%  slabinfo.buffer_head.active_objs
     13.17 ±  2%      -6.3%      12.33 ±  6%  slabinfo.buffer_head.active_slabs
    530.17 ±  4%      -6.5%     495.67 ±  7%  slabinfo.buffer_head.num_objs
     13.17 ±  2%      -6.3%      12.33 ±  6%  slabinfo.buffer_head.num_slabs
     18369 ±  2%      +0.1%      18382 ±  9%  slabinfo.cred_jar.active_objs
    437.50 ±  2%      +0.1%     438.00 ±  9%  slabinfo.cred_jar.active_slabs
     18407 ±  2%      +0.1%      18417 ±  9%  slabinfo.cred_jar.num_objs
    437.50 ±  2%      +0.1%     438.00 ±  9%  slabinfo.cred_jar.num_slabs
     42.00            +0.0%      42.00        slabinfo.dax_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.dax_cache.active_slabs
     42.00            +0.0%      42.00        slabinfo.dax_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.dax_cache.num_slabs
     79834            -2.9%      77489        slabinfo.dentry.active_objs
      1936            -1.4%       1910        slabinfo.dentry.active_slabs
     81364            -1.4%      80255        slabinfo.dentry.num_objs
      1936            -1.4%       1910        slabinfo.dentry.num_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.active_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.num_slabs
      2554 ±  7%      -7.2%       2369 ± 15%  slabinfo.dmaengine-unmap-16.active_objs
     60.50 ±  7%      -2.2%      59.17 ± 15%  slabinfo.dmaengine-unmap-16.active_slabs
      2560 ±  7%      -2.7%       2492 ± 15%  slabinfo.dmaengine-unmap-16.num_objs
     60.50 ±  7%      -2.2%      59.17 ± 15%  slabinfo.dmaengine-unmap-16.num_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.active_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.num_slabs
    110.83 ± 26%      -7.4%     102.67 ± 28%  slabinfo.dquot.active_objs
      2.83 ± 37%      +0.0%       2.83 ± 31%  slabinfo.dquot.active_slabs
    110.83 ± 26%      -7.4%     102.67 ± 28%  slabinfo.dquot.num_objs
      2.83 ± 37%      +0.0%       2.83 ± 31%  slabinfo.dquot.num_slabs
     11477 ±  2%      -1.5%      11306 ±  5%  slabinfo.ep_head.active_objs
     44.83 ±  2%      -1.5%      44.17 ±  5%  slabinfo.ep_head.active_slabs
     11477 ±  2%      -1.5%      11306 ±  5%  slabinfo.ep_head.num_objs
     44.83 ±  2%      -1.5%      44.17 ±  5%  slabinfo.ep_head.num_slabs
    200.00            +0.0%     200.00        slabinfo.ext4_extent_status.active_objs
      1.00            +0.0%       1.00        slabinfo.ext4_extent_status.active_slabs
    200.00            +0.0%     200.00        slabinfo.ext4_extent_status.num_objs
      1.00            +0.0%       1.00        slabinfo.ext4_extent_status.num_slabs
      1624            +0.0%       1624        slabinfo.ext4_groupinfo_4k.active_objs
     58.00            +0.0%      58.00        slabinfo.ext4_groupinfo_4k.active_slabs
      1624            +0.0%       1624        slabinfo.ext4_groupinfo_4k.num_objs
     58.00            +0.0%      58.00        slabinfo.ext4_groupinfo_4k.num_slabs
     27.00            +0.0%      27.00        slabinfo.ext4_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.ext4_inode_cache.active_slabs
     27.00            +0.0%      27.00        slabinfo.ext4_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.ext4_inode_cache.num_slabs
    204.00            +0.0%     204.00        slabinfo.ext4_system_zone.active_objs
      2.00            +0.0%       2.00        slabinfo.ext4_system_zone.active_slabs
    204.00            +0.0%     204.00        slabinfo.ext4_system_zone.num_objs
      2.00            +0.0%       2.00        slabinfo.ext4_system_zone.num_slabs
    861.67 ±  8%     -15.0%     732.33 ± 12%  slabinfo.file_lock_cache.active_objs
     22.83 ±  7%     -15.3%      19.33 ± 11%  slabinfo.file_lock_cache.active_slabs
    861.67 ±  8%     -15.0%     732.33 ± 12%  slabinfo.file_lock_cache.num_objs
     22.83 ±  7%     -15.3%      19.33 ± 11%  slabinfo.file_lock_cache.num_slabs
      2443            -1.8%       2398        slabinfo.files_cache.active_objs
     52.50            -1.3%      51.83        slabinfo.files_cache.active_slabs
      2443            -1.8%       2398        slabinfo.files_cache.num_objs
     52.50            -1.3%      51.83        slabinfo.files_cache.num_slabs
     16240 ±  2%      -1.3%      16032        slabinfo.filp.active_objs
    531.00 ±  2%      -3.2%     513.83        slabinfo.filp.active_slabs
     17011 ±  2%      -3.2%      16459        slabinfo.filp.num_objs
    531.00 ±  2%      -3.2%     513.83        slabinfo.filp.num_slabs
      2560 ±  7%      -5.8%       2410 ±  8%  slabinfo.fsnotify_mark_connector.active_objs
     20.00 ±  7%      -5.8%      18.83 ±  8%  slabinfo.fsnotify_mark_connector.active_slabs
      2560 ±  7%      -5.8%       2410 ±  8%  slabinfo.fsnotify_mark_connector.num_objs
     20.00 ±  7%      -5.8%      18.83 ±  8%  slabinfo.fsnotify_mark_connector.num_slabs
     19394            -0.2%      19351        slabinfo.ftrace_event_field.active_objs
    228.17            -0.2%     227.67        slabinfo.ftrace_event_field.active_slabs
     19394            -0.2%      19351        slabinfo.ftrace_event_field.num_objs
    228.17            -0.2%     227.67        slabinfo.ftrace_event_field.num_slabs
    104.00            +0.0%     104.00        slabinfo.hugetlbfs_inode_cache.active_objs
      2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.active_slabs
    104.00            +0.0%     104.00        slabinfo.hugetlbfs_inode_cache.num_objs
      2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.num_slabs
     63254            +0.1%      63305        slabinfo.inode_cache.active_objs
      1172            +0.1%       1173        slabinfo.inode_cache.active_slabs
     63348            +0.1%      63407        slabinfo.inode_cache.num_objs
      1172            +0.1%       1173        slabinfo.inode_cache.num_slabs
     44.00            +0.0%      44.00        slabinfo.ip6-frags.active_objs
      1.00            +0.0%       1.00        slabinfo.ip6-frags.active_slabs
     44.00            +0.0%      44.00        slabinfo.ip6-frags.num_objs
      1.00            +0.0%       1.00        slabinfo.ip6-frags.num_slabs
     55.17 ±  4%     -11.5%      48.83 ± 11%  slabinfo.jbd2_journal_head.active_objs
      1.00            +0.0%       1.00        slabinfo.jbd2_journal_head.active_slabs
     55.17 ±  4%     -11.5%      48.83 ± 11%  slabinfo.jbd2_journal_head.num_objs
      1.00            +0.0%       1.00        slabinfo.jbd2_journal_head.num_slabs
    256.00            +0.0%     256.00        slabinfo.jbd2_revoke_table_s.active_objs
      1.00            +0.0%       1.00        slabinfo.jbd2_revoke_table_s.active_slabs
    256.00            +0.0%     256.00        slabinfo.jbd2_revoke_table_s.num_objs
      1.00            +0.0%       1.00        slabinfo.jbd2_revoke_table_s.num_slabs
     55718            +0.1%      55776        slabinfo.kernfs_node_cache.active_objs
      1741            +0.1%       1743        slabinfo.kernfs_node_cache.active_slabs
     55718            +0.1%      55776        slabinfo.kernfs_node_cache.num_objs
      1741            +0.1%       1743        slabinfo.kernfs_node_cache.num_slabs
      1455 ± 19%     -19.1%       1177 ± 33%  slabinfo.khugepaged_mm_slot.active_objs
     39.67 ± 20%     -18.9%      32.17 ± 33%  slabinfo.khugepaged_mm_slot.active_slabs
      1455 ± 19%     -19.1%       1177 ± 33%  slabinfo.khugepaged_mm_slot.num_objs
     39.67 ± 20%     -18.9%      32.17 ± 33%  slabinfo.khugepaged_mm_slot.num_slabs
      2821            +0.9%       2847        slabinfo.kmalloc-128.active_objs
     88.67            +0.8%      89.33        slabinfo.kmalloc-128.active_slabs
      2841            +1.4%       2882        slabinfo.kmalloc-128.num_objs
     88.67            +0.8%      89.33        slabinfo.kmalloc-128.num_slabs
     18439            +0.4%      18504        slabinfo.kmalloc-16.active_objs
     72.17            +0.2%      72.33        slabinfo.kmalloc-16.active_slabs
     18474            +0.2%      18517        slabinfo.kmalloc-16.num_objs
     72.17            +0.2%      72.33        slabinfo.kmalloc-16.num_slabs
      2820            +0.5%       2833        slabinfo.kmalloc-192.active_objs
     70.33            +0.5%      70.67        slabinfo.kmalloc-192.active_slabs
      2960            +0.2%       2968        slabinfo.kmalloc-192.num_objs
     70.33            +0.5%      70.67        slabinfo.kmalloc-192.num_slabs
      3506 ±  2%      +0.0%       3507        slabinfo.kmalloc-1k.active_objs
    113.67 ±  2%      -1.9%     111.50        slabinfo.kmalloc-1k.active_slabs
      3658 ±  2%      -1.9%       3588        slabinfo.kmalloc-1k.num_objs
    113.67 ±  2%      -1.9%     111.50        slabinfo.kmalloc-1k.num_slabs
      5843 ±  4%      -5.5%       5522 ±  3%  slabinfo.kmalloc-256.active_objs
    183.17 ±  4%      -5.7%     172.67 ±  3%  slabinfo.kmalloc-256.active_slabs
      5883 ±  4%      -5.8%       5539 ±  3%  slabinfo.kmalloc-256.num_objs
    183.17 ±  4%      -5.7%     172.67 ±  3%  slabinfo.kmalloc-256.num_slabs
      4033 ±  2%      -2.7%       3926 ±  3%  slabinfo.kmalloc-2k.active_objs
    257.17 ±  2%      -3.3%     248.67 ±  3%  slabinfo.kmalloc-2k.active_slabs
      4117 ±  2%      -3.1%       3988 ±  3%  slabinfo.kmalloc-2k.num_objs
    257.17 ±  2%      -3.3%     248.67 ±  3%  slabinfo.kmalloc-2k.num_slabs
     56582            +0.2%      56687        slabinfo.kmalloc-32.active_objs
    442.33            +0.3%     443.50        slabinfo.kmalloc-32.active_slabs
     56688            +0.3%      56834        slabinfo.kmalloc-32.num_objs
    442.33            +0.3%     443.50        slabinfo.kmalloc-32.num_slabs
      1313            -0.3%       1309        slabinfo.kmalloc-4k.active_objs
    165.00            -0.4%     164.33        slabinfo.kmalloc-4k.active_slabs
      1325            -0.4%       1319        slabinfo.kmalloc-4k.num_objs
    165.00            -0.4%     164.33        slabinfo.kmalloc-4k.num_slabs
     14854            +9.0%      16186        slabinfo.kmalloc-512.active_objs
    494.00            +7.4%     530.67        slabinfo.kmalloc-512.active_slabs
     15826            +7.4%      16996        slabinfo.kmalloc-512.num_objs
    494.00            +7.4%     530.67        slabinfo.kmalloc-512.num_slabs
     35363            +0.2%      35424        slabinfo.kmalloc-64.active_objs
    554.83            +0.2%     555.67        slabinfo.kmalloc-64.active_slabs
     35518            +0.2%      35596        slabinfo.kmalloc-64.num_objs
    554.83            +0.2%     555.67        slabinfo.kmalloc-64.num_slabs
     29180            -0.1%      29159        slabinfo.kmalloc-8.active_objs
     56.50            +0.0%      56.50        slabinfo.kmalloc-8.active_slabs
     29180            -0.1%      29159        slabinfo.kmalloc-8.num_objs
     56.50            +0.0%      56.50        slabinfo.kmalloc-8.num_slabs
    441.67            +0.5%     443.67        slabinfo.kmalloc-8k.active_objs
    110.17            +0.5%     110.67        slabinfo.kmalloc-8k.active_slabs
    441.67            +0.5%     443.67        slabinfo.kmalloc-8k.num_objs
    110.17            +0.5%     110.67        slabinfo.kmalloc-8k.num_slabs
      7213 ±  4%     -12.2%       6335 ±  9%  slabinfo.kmalloc-96.active_objs
    171.50 ±  4%     -12.0%     151.00 ±  9%  slabinfo.kmalloc-96.active_slabs
      7233 ±  4%     -12.0%       6366 ±  9%  slabinfo.kmalloc-96.num_objs
    171.50 ±  4%     -12.0%     151.00 ±  9%  slabinfo.kmalloc-96.num_slabs
    501.33 ± 10%     -10.6%     448.00 ±  9%  slabinfo.kmalloc-rcl-128.active_objs
     15.67 ± 10%     -10.6%      14.00 ±  9%  slabinfo.kmalloc-rcl-128.active_slabs
    501.33 ± 10%     -10.6%     448.00 ±  9%  slabinfo.kmalloc-rcl-128.num_objs
     15.67 ± 10%     -10.6%      14.00 ±  9%  slabinfo.kmalloc-rcl-128.num_slabs
    623.00 ±  7%      +1.1%     630.00 ±  8%  slabinfo.kmalloc-rcl-192.active_objs
     14.83 ±  7%      +1.1%      15.00 ±  8%  slabinfo.kmalloc-rcl-192.active_slabs
    623.00 ±  7%      +1.1%     630.00 ±  8%  slabinfo.kmalloc-rcl-192.num_objs
     14.83 ±  7%      +1.1%      15.00 ±  8%  slabinfo.kmalloc-rcl-192.num_slabs
    256.00 ± 12%      -4.2%     245.33 ±  6%  slabinfo.kmalloc-rcl-256.active_objs
      8.00 ± 12%      -4.2%       7.67 ±  6%  slabinfo.kmalloc-rcl-256.active_slabs
    256.00 ± 12%      -4.2%     245.33 ±  6%  slabinfo.kmalloc-rcl-256.num_objs
      8.00 ± 12%      -4.2%       7.67 ±  6%  slabinfo.kmalloc-rcl-256.num_slabs
      3380 ±  2%      -6.7%       3154        slabinfo.kmalloc-rcl-512.active_objs
    107.17 ±  3%      -6.8%      99.83        slabinfo.kmalloc-rcl-512.active_slabs
      3442 ±  3%      -6.7%       3211        slabinfo.kmalloc-rcl-512.num_objs
    107.17 ±  3%      -6.8%      99.83        slabinfo.kmalloc-rcl-512.num_slabs
      3504 ±  5%     -11.4%       3106 ±  5%  slabinfo.kmalloc-rcl-64.active_objs
     53.83 ±  6%     -10.8%      48.00 ±  5%  slabinfo.kmalloc-rcl-64.active_slabs
      3504 ±  5%     -11.4%       3106 ±  5%  slabinfo.kmalloc-rcl-64.num_objs
     53.83 ±  6%     -10.8%      48.00 ±  5%  slabinfo.kmalloc-rcl-64.num_slabs
      2037 ±  8%      -9.3%       1848 ±  6%  slabinfo.kmalloc-rcl-96.active_objs
     48.50 ±  8%      -9.3%      44.00 ±  6%  slabinfo.kmalloc-rcl-96.active_slabs
      2037 ±  8%      -9.3%       1848 ±  6%  slabinfo.kmalloc-rcl-96.num_objs
     48.50 ±  8%      -9.3%      44.00 ±  6%  slabinfo.kmalloc-rcl-96.num_slabs
    442.67 ± 14%      -1.2%     437.33 ± 10%  slabinfo.kmem_cache.active_objs
     13.83 ± 14%      -1.2%      13.67 ± 10%  slabinfo.kmem_cache.active_slabs
    442.67 ± 14%      -1.2%     437.33 ± 10%  slabinfo.kmem_cache.num_objs
     13.83 ± 14%      -1.2%      13.67 ± 10%  slabinfo.kmem_cache.num_slabs
    937.67 ± 12%      +1.1%     948.33 ±  8%  slabinfo.kmem_cache_node.active_objs
     15.17 ± 12%      +1.1%      15.33 ±  8%  slabinfo.kmem_cache_node.active_slabs
    970.67 ± 12%      +1.1%     981.33 ±  8%  slabinfo.kmem_cache_node.num_objs
     15.17 ± 12%      +1.1%      15.33 ±  8%  slabinfo.kmem_cache_node.num_slabs
      9159            +0.7%       9221        slabinfo.lsm_file_cache.active_objs
     53.00            +0.6%      53.33        slabinfo.lsm_file_cache.active_slabs
      9159            +0.7%       9221        slabinfo.lsm_file_cache.num_objs
     53.00            +0.6%      53.33        slabinfo.lsm_file_cache.num_slabs
    351.00 ± 30%     -20.0%     280.83 ± 23%  slabinfo.mbcache.active_objs
      4.33 ± 31%     -19.2%       3.50 ± 31%  slabinfo.mbcache.active_slabs
    351.00 ± 30%     -20.0%     280.83 ± 23%  slabinfo.mbcache.num_objs
      4.33 ± 31%     -19.2%       3.50 ± 31%  slabinfo.mbcache.num_slabs
      1560            -1.3%       1540        slabinfo.mm_struct.active_objs
     52.00            -1.3%      51.33        slabinfo.mm_struct.active_slabs
      1560            -1.3%       1540        slabinfo.mm_struct.num_objs
     52.00            -1.3%      51.33        slabinfo.mm_struct.num_slabs
    830.83 ±  5%      -9.1%     755.33 ± 15%  slabinfo.mnt_cache.active_objs
     15.50 ±  6%      -9.7%      14.00 ± 15%  slabinfo.mnt_cache.active_slabs
    830.83 ±  5%      -9.1%     755.33 ± 15%  slabinfo.mnt_cache.num_objs
     15.50 ±  6%      -9.7%      14.00 ± 15%  slabinfo.mnt_cache.num_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.active_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.num_slabs
    386.67            -0.3%     385.33        slabinfo.names_cache.active_objs
     48.33            -0.3%      48.17        slabinfo.names_cache.active_slabs
    386.67            -0.3%     385.33        slabinfo.names_cache.num_objs
     48.33            -0.3%      48.17        slabinfo.names_cache.num_slabs
     36.00            +0.0%      36.00        slabinfo.nfs_read_data.active_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.active_slabs
     36.00            +0.0%      36.00        slabinfo.nfs_read_data.num_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.num_slabs
    211.83 ±  5%      +2.4%     217.00        slabinfo.numa_policy.active_objs
      6.83 ±  5%      +2.4%       7.00        slabinfo.numa_policy.active_slabs
    211.83 ±  5%      +2.4%     217.00        slabinfo.numa_policy.num_objs
      6.83 ±  5%      +2.4%       7.00        slabinfo.numa_policy.num_slabs
      4847            -1.4%       4777        slabinfo.pde_opener.active_objs
     46.83            -1.1%      46.33        slabinfo.pde_opener.active_slabs
      4847            -1.4%       4777        slabinfo.pde_opener.num_objs
     46.83            -1.1%      46.33        slabinfo.pde_opener.num_slabs
      4501 ±  2%      -6.3%       4216 ±  3%  slabinfo.pid.active_objs
    140.00 ±  2%      -6.2%     131.33 ±  3%  slabinfo.pid.active_slabs
      4501 ±  2%      -6.3%       4216 ±  3%  slabinfo.pid.num_objs
    140.00 ±  2%      -6.2%     131.33 ±  3%  slabinfo.pid.num_slabs
      1309 ±  5%     -11.9%       1154 ± 13%  slabinfo.pool_workqueue.active_objs
     40.67 ±  5%     -11.1%      36.17 ± 12%  slabinfo.pool_workqueue.active_slabs
      1320 ±  5%     -11.3%       1171 ± 11%  slabinfo.pool_workqueue.num_objs
     40.67 ±  5%     -11.1%      36.17 ± 12%  slabinfo.pool_workqueue.num_slabs
      1239 ±  2%      +0.0%       1239 ±  3%  slabinfo.proc_dir_entry.active_objs
     29.50 ±  2%      +0.0%      29.50 ±  3%  slabinfo.proc_dir_entry.active_slabs
      1239 ±  2%      +0.0%       1239 ±  3%  slabinfo.proc_dir_entry.num_objs
     29.50 ±  2%      +0.0%      29.50 ±  3%  slabinfo.proc_dir_entry.num_slabs
     13851           -18.1%      11349        slabinfo.proc_inode_cache.active_objs
    291.83           -17.8%     239.83        slabinfo.proc_inode_cache.active_slabs
     14016           -17.7%      11537        slabinfo.proc_inode_cache.num_objs
    291.83           -17.8%     239.83        slabinfo.proc_inode_cache.num_slabs
     13542            +1.4%      13732        slabinfo.radix_tree_node.active_objs
    483.67            +1.5%     490.83        slabinfo.radix_tree_node.active_slabs
     13558            +1.5%      13756        slabinfo.radix_tree_node.num_objs
    483.67            +1.5%     490.83        slabinfo.radix_tree_node.num_slabs
     37.33 ± 20%      +7.1%      40.00 ± 20%  slabinfo.request_queue.active_objs
      2.33 ± 20%      +7.1%       2.50 ± 20%  slabinfo.request_queue.active_slabs
     37.33 ± 20%      +7.1%      40.00 ± 20%  slabinfo.request_queue.num_objs
      2.33 ± 20%      +7.1%       2.50 ± 20%  slabinfo.request_queue.num_slabs
     51.00            +0.0%      51.00        slabinfo.rpc_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.active_slabs
     51.00            +0.0%      51.00        slabinfo.rpc_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.num_slabs
      1258            +0.4%       1264        slabinfo.scsi_sense_cache.active_objs
     39.33            +0.4%      39.50        slabinfo.scsi_sense_cache.active_slabs
      1258            +0.4%       1264        slabinfo.scsi_sense_cache.num_objs
     39.33            +0.4%      39.50        slabinfo.scsi_sense_cache.num_slabs
      1632            +0.0%       1632        slabinfo.seq_file.active_objs
     48.00            +0.0%      48.00        slabinfo.seq_file.active_slabs
      1632            +0.0%       1632        slabinfo.seq_file.num_objs
     48.00            +0.0%      48.00        slabinfo.seq_file.num_slabs
      3028 ±  3%      -0.3%       3018 ±  3%  slabinfo.shmem_inode_cache.active_objs
     65.67 ±  3%      -0.3%      65.50 ±  3%  slabinfo.shmem_inode_cache.active_slabs
      3028 ±  3%      -0.3%       3018 ±  3%  slabinfo.shmem_inode_cache.num_objs
     65.67 ±  3%      -0.3%      65.50 ±  3%  slabinfo.shmem_inode_cache.num_slabs
      1364            +0.4%       1370        slabinfo.sighand_cache.active_objs
     93.33            -1.2%      92.17        slabinfo.sighand_cache.active_slabs
      1407            -1.2%       1390        slabinfo.sighand_cache.num_objs
     93.33            -1.2%      92.17        slabinfo.sighand_cache.num_slabs
      4360 ±  3%      -9.1%       3961 ±  4%  slabinfo.signal_cache.active_objs
    155.67 ±  3%      -8.5%     142.50 ±  4%  slabinfo.signal_cache.active_slabs
      4373 ±  3%      -8.6%       3997 ±  4%  slabinfo.signal_cache.num_objs
    155.67 ±  3%      -8.5%     142.50 ±  4%  slabinfo.signal_cache.num_slabs
    373.33 ± 13%      +0.0%     373.33 ± 15%  slabinfo.skbuff_fclone_cache.active_objs
     11.67 ± 13%      +0.0%      11.67 ± 15%  slabinfo.skbuff_fclone_cache.active_slabs
    373.33 ± 13%      +0.0%     373.33 ± 15%  slabinfo.skbuff_fclone_cache.num_objs
     11.67 ± 13%      +0.0%      11.67 ± 15%  slabinfo.skbuff_fclone_cache.num_slabs
      2048 ± 13%      +0.8%       2064 ± 10%  slabinfo.skbuff_head_cache.active_objs
     65.50 ± 11%      -0.8%      65.00 ±  9%  slabinfo.skbuff_head_cache.active_slabs
      2096 ± 11%      -0.8%       2080 ±  9%  slabinfo.skbuff_head_cache.num_objs
     65.50 ± 11%      -0.8%      65.00 ±  9%  slabinfo.skbuff_head_cache.num_slabs
      2241 ±  3%     -13.9%       1930 ± 10%  slabinfo.sock_inode_cache.active_objs
     57.00 ±  3%     -13.5%      49.33 ± 10%  slabinfo.sock_inode_cache.active_slabs
      2241 ±  3%     -13.9%       1930 ± 10%  slabinfo.sock_inode_cache.num_objs
     57.00 ±  3%     -13.5%      49.33 ± 10%  slabinfo.sock_inode_cache.num_slabs
      5416 ±  4%     -11.4%       4796 ±  4%  slabinfo.task_delay_info.active_objs
    105.83 ±  4%     -11.3%      93.83 ±  4%  slabinfo.task_delay_info.active_slabs
      5416 ±  4%     -11.4%       4796 ±  4%  slabinfo.task_delay_info.num_objs
    105.83 ±  4%     -11.3%      93.83 ±  4%  slabinfo.task_delay_info.num_slabs
      1106 ± 12%     -17.6%     911.83 ± 20%  slabinfo.task_group.active_objs
     23.33 ± 12%     -17.1%      19.33 ± 20%  slabinfo.task_group.active_slabs
      1106 ± 12%     -17.6%     911.83 ± 20%  slabinfo.task_group.num_objs
     23.33 ± 12%     -17.1%      19.33 ± 20%  slabinfo.task_group.num_slabs
      1176            -2.0%       1152 ±  2%  slabinfo.task_struct.active_objs
    400.17            -2.4%     390.50 ±  2%  slabinfo.task_struct.active_slabs
      1202            -2.5%       1172 ±  2%  slabinfo.task_struct.num_objs
    400.17            -2.4%     390.50 ±  2%  slabinfo.task_struct.num_slabs
    104.17            -2.4%     101.67 ±  5%  slabinfo.taskstats.active_objs
      2.00            -8.3%       1.83 ± 20%  slabinfo.taskstats.active_slabs
    104.17            -2.4%     101.67 ±  5%  slabinfo.taskstats.num_objs
      2.00            -8.3%       1.83 ± 20%  slabinfo.taskstats.num_slabs
      3605 ±  3%      -1.2%       3562 ±  2%  slabinfo.trace_event_file.active_objs
     77.83 ±  3%      -1.3%      76.83 ±  2%  slabinfo.trace_event_file.active_slabs
      3605 ±  3%      -1.2%       3562 ±  2%  slabinfo.trace_event_file.num_objs
     77.83 ±  3%      -1.3%      76.83 ±  2%  slabinfo.trace_event_file.num_slabs
     33.00            +0.0%      33.00        slabinfo.tw_sock_TCP.active_objs
      1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.active_slabs
     33.00            +0.0%      33.00        slabinfo.tw_sock_TCP.num_objs
      1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.num_slabs
     26729           +13.7%      30380        slabinfo.vm_area_struct.active_objs
    671.50           +13.3%     760.83        slabinfo.vm_area_struct.active_slabs
     26880           +13.3%      30456        slabinfo.vm_area_struct.num_objs
    671.50           +13.3%     760.83        slabinfo.vm_area_struct.num_slabs
     14140 ±  2%     +17.5%      16609 ±  5%  slabinfo.vmap_area.active_objs
    248.83           +16.1%     288.83 ±  4%  slabinfo.vmap_area.active_slabs
     15956           +16.1%      18526 ±  4%  slabinfo.vmap_area.num_objs
    248.83           +16.1%     288.83 ±  4%  slabinfo.vmap_area.num_slabs
     42.00            +0.0%      42.00        slabinfo.xfrm_state.active_objs
      1.00            +0.0%       1.00        slabinfo.xfrm_state.active_slabs
     42.00            +0.0%      42.00        slabinfo.xfrm_state.num_objs
      1.00            +0.0%       1.00        slabinfo.xfrm_state.num_slabs
     36.00            +0.0%      36.00        slabinfo.xfs_btree_cur.active_objs
      1.00            +0.0%       1.00        slabinfo.xfs_btree_cur.active_slabs
     36.00            +0.0%      36.00        slabinfo.xfs_btree_cur.num_objs
      1.00            +0.0%       1.00        slabinfo.xfs_btree_cur.num_slabs
    161.00 ±  9%     -26.1%     119.00 ± 13%  slabinfo.xfs_buf.active_objs
      3.83 ±  9%     -26.1%       2.83 ± 13%  slabinfo.xfs_buf.active_slabs
    161.00 ±  9%     -26.1%     119.00 ± 13%  slabinfo.xfs_buf.num_objs
      3.83 ±  9%     -26.1%       2.83 ± 13%  slabinfo.xfs_buf.num_slabs
     38.00            +0.0%      38.00        slabinfo.xfs_efi_item.active_objs
      1.00            +0.0%       1.00        slabinfo.xfs_efi_item.active_slabs
     38.00            +0.0%      38.00        slabinfo.xfs_efi_item.num_objs
      1.00            +0.0%       1.00        slabinfo.xfs_efi_item.num_slabs
     96.00           -11.1%      85.33 ± 17%  slabinfo.xfs_inode.active_objs
      3.00           -11.1%       2.67 ± 17%  slabinfo.xfs_inode.active_slabs
     96.00           -11.1%      85.33 ± 17%  slabinfo.xfs_inode.num_objs
      3.00           -11.1%       2.67 ± 17%  slabinfo.xfs_inode.num_slabs
      0.00          -100.0%       0.00        interrupts.0:IO-APIC.2-edge.timer
      0.00          -100.0%       0.00        interrupts.20:IO-APIC.20-fasteoi.ehci_hcd:usb2
      0.00          -100.0%       0.00        interrupts.22:IO-APIC.22-fasteoi.ehci_hcd:usb1
    205.33 ± 55%     -50.7%     101.17 ± 41%  interrupts.35:PCI-MSI.2621441-edge.eth0-TxRx-0
    534.00 ± 89%      +3.9%     554.67 ±157%  interrupts.36:PCI-MSI.2621442-edge.eth0-TxRx-1
    238.50 ± 95%    +752.9%       2034 ±138%  interrupts.37:PCI-MSI.2621443-edge.eth0-TxRx-2
    628.33 ±126%    +110.7%       1324 ±199%  interrupts.38:PCI-MSI.2621444-edge.eth0-TxRx-3
      2011 ±161%     -82.8%     346.83 ±127%  interrupts.39:PCI-MSI.2621445-edge.eth0-TxRx-4
      5111 ±167%     -97.9%     109.00 ± 82%  interrupts.40:PCI-MSI.2621446-edge.eth0-TxRx-5
    224.83 ±132%     -18.8%     182.67 ± 54%  interrupts.41:PCI-MSI.2621447-edge.eth0-TxRx-6
    209.83 ±155%     +29.6%     272.00 ±120%  interrupts.42:PCI-MSI.2621448-edge.eth0-TxRx-7
      0.00          -100.0%       0.00        interrupts.44:PCI-MSI.2623489-edge
      0.00          -100.0%       0.00        interrupts.45:PCI-MSI.2623490-edge
      0.00          -100.0%       0.00        interrupts.46:PCI-MSI.2623491-edge
      0.00          -100.0%       0.00        interrupts.47:PCI-MSI.2623492-edge
      0.00          -100.0%       0.00        interrupts.48:PCI-MSI.2623493-edge
      0.00          -100.0%       0.00        interrupts.49:PCI-MSI.2623494-edge
      0.00          -100.0%       0.00        interrupts.4:IO-APIC.4-edge.ttyS0
      0.00          -100.0%       0.00        interrupts.50:PCI-MSI.2623495-edge
      0.00          -100.0%       0.00        interrupts.51:PCI-MSI.2623496-edge
      0.00          -100.0%       0.00        interrupts.53:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.55:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.56:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.56:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.57:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.57:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.58:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.58:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.59:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.59:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.60:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.60:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.61:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.61:PCI-MSI.79872-edge.ioat-msix
    207.50 ±141%     -56.9%      89.50 ±223%  interrupts.62:PCI-MSI.2097152-edge.isci-msix
      0.00          -100.0%       0.00        interrupts.62:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.63:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.64:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.64:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.65:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.66:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.66:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.66:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.67:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.67:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.68:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.68:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.68:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.69:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.69:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.69:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.70:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.70:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.70:PCI-MSI.67186688-edge.ioat-msix
    117.83 ±223%    -100.0%       0.00        interrupts.71:PCI-MSI.2097152-edge.isci-msix
      0.00          -100.0%       0.00        interrupts.71:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.71:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.71:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.72:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.72:PCI-MSI.67188736-edge.ioat-msix
    322.17 ±100%     +50.8%     485.83 ± 48%  interrupts.73:PCI-MSI.2097152-edge.isci-msix
      0.00          -100.0%       0.00        interrupts.73:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.74:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.8:IO-APIC.8-edge.rtc0
    217666 ± 14%     -22.9%     167723 ±  9%  interrupts.CAL:Function_call_interrupts
      0.00          -100.0%       0.00        interrupts.CPU0.0:IO-APIC.2-edge.timer
      0.00          -100.0%       0.00        interrupts.CPU0.45:PCI-MSI.2623490-edge
      0.00          -100.0%       0.00        interrupts.CPU0.55:PCI-MSI.67584-edge.ioat-msix
      2859 ± 30%     -37.1%       1799 ± 32%  interrupts.CPU0.CAL:Function_call_interrupts
      0.17 ±223%    +400.0%       0.83 ±223%  interrupts.CPU0.IWI:IRQ_work_interrupts
    127374            -1.1%     125939 ±  2%  interrupts.CPU0.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU0.MCP:Machine_check_polls
    998.67 ± 36%      -2.5%     974.00 ± 40%  interrupts.CPU0.NMI:Non-maskable_interrupts
    998.67 ± 36%      -2.5%     974.00 ± 40%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
      1368 ± 13%      +0.5%       1375 ± 22%  interrupts.CPU0.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00        interrupts.CPU0.RTR:APIC_ICR_read_retries
     42.50 ± 20%     -57.3%      18.17 ± 22%  interrupts.CPU0.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU1.46:PCI-MSI.2623491-edge
      0.00          -100.0%       0.00        interrupts.CPU1.56:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU1.56:PCI-MSI.69632-edge.ioat-msix
      5430 ± 30%     -48.1%       2817 ± 33%  interrupts.CPU1.CAL:Function_call_interrupts
      0.00       +6.7e+101%       0.67 ±165%  interrupts.CPU1.IWI:IRQ_work_interrupts
    127650            -1.3%     126000 ±  2%  interrupts.CPU1.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU1.MCP:Machine_check_polls
    984.50 ± 41%     +40.2%       1380 ± 43%  interrupts.CPU1.NMI:Non-maskable_interrupts
    984.50 ± 41%     +40.2%       1380 ± 43%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
      1591 ± 18%      -8.8%       1450 ± 20%  interrupts.CPU1.RES:Rescheduling_interrupts
     38.67 ± 23%     -84.1%       6.17 ± 30%  interrupts.CPU1.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU10.8:IO-APIC.8-edge.rtc0
      3601 ± 52%      +3.2%       3715 ± 37%  interrupts.CPU10.CAL:Function_call_interrupts
      0.00       +6.7e+101%       0.67 ±165%  interrupts.CPU10.IWI:IRQ_work_interrupts
    127444            -1.1%     126037 ±  2%  interrupts.CPU10.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU10.MCP:Machine_check_polls
      1027 ± 41%     +32.0%       1355 ± 45%  interrupts.CPU10.NMI:Non-maskable_interrupts
      1027 ± 41%     +32.0%       1355 ± 45%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
      1155 ± 40%     +34.9%       1558 ± 31%  interrupts.CPU10.RES:Rescheduling_interrupts
     20.17 ± 36%     -77.7%       4.50 ± 52%  interrupts.CPU10.TLB:TLB_shootdowns
      2810 ± 36%      -1.3%       2774 ± 38%  interrupts.CPU11.CAL:Function_call_interrupts
      0.00       +1.7e+101%       0.17 ±223%  interrupts.CPU11.IWI:IRQ_work_interrupts
    127455            -1.2%     125924 ±  2%  interrupts.CPU11.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU11.MCP:Machine_check_polls
      1034 ± 30%     +27.7%       1320 ± 52%  interrupts.CPU11.NMI:Non-maskable_interrupts
      1034 ± 30%     +27.7%       1320 ± 52%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
      1079 ± 15%     +15.2%       1243 ± 19%  interrupts.CPU11.RES:Rescheduling_interrupts
     22.50 ± 23%     -80.7%       4.33 ± 66%  interrupts.CPU11.TLB:TLB_shootdowns
      4368 ± 45%      -2.9%       4239 ± 47%  interrupts.CPU12.CAL:Function_call_interrupts
    127446            -1.9%     124996 ±  4%  interrupts.CPU12.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU12.MCP:Machine_check_polls
      1170 ± 26%      -4.4%       1118 ± 39%  interrupts.CPU12.NMI:Non-maskable_interrupts
      1170 ± 26%      -4.4%       1118 ± 39%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
      1796 ± 30%     -15.4%       1520 ± 25%  interrupts.CPU12.RES:Rescheduling_interrupts
     24.33 ± 38%     -79.5%       5.00 ± 62%  interrupts.CPU12.TLB:TLB_shootdowns
      5232 ± 40%     -35.0%       3399 ± 32%  interrupts.CPU13.CAL:Function_call_interrupts
    127442            -2.0%     124868 ±  4%  interrupts.CPU13.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU13.MCP:Machine_check_polls
      1263 ± 29%     -21.0%     999.00 ± 43%  interrupts.CPU13.NMI:Non-maskable_interrupts
      1263 ± 29%     -21.0%     999.00 ± 43%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
      1676 ± 29%     -12.3%       1471 ± 17%  interrupts.CPU13.RES:Rescheduling_interrupts
     27.33 ± 33%     -82.3%       4.83 ± 52%  interrupts.CPU13.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU14.63:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU14.64:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU14.66:PCI-MSI.67174400-edge.ioat-msix
      5207 ± 37%     -16.9%       4326 ± 42%  interrupts.CPU14.CAL:Function_call_interrupts
      0.17 ±223%    -100.0%       0.00        interrupts.CPU14.IWI:IRQ_work_interrupts
    127351            -2.1%     124706 ±  4%  interrupts.CPU14.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU14.MCP:Machine_check_polls
      1376 ± 29%     -50.7%     679.33 ± 47%  interrupts.CPU14.NMI:Non-maskable_interrupts
      1376 ± 29%     -50.7%     679.33 ± 47%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
      1802 ± 23%     -11.2%       1599 ± 22%  interrupts.CPU14.RES:Rescheduling_interrupts
     27.00 ± 32%     -79.6%       5.50 ± 60%  interrupts.CPU14.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU15.65:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU15.66:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU15.68:PCI-MSI.67176448-edge.ioat-msix
      5504 ± 34%     -44.6%       3050 ± 34%  interrupts.CPU15.CAL:Function_call_interrupts
      1.00 ±223%     -66.7%       0.33 ±223%  interrupts.CPU15.IWI:IRQ_work_interrupts
    127413            -2.2%     124585 ±  5%  interrupts.CPU15.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU15.MCP:Machine_check_polls
      1417 ± 32%     -43.8%     797.00 ± 65%  interrupts.CPU15.NMI:Non-maskable_interrupts
      1417 ± 32%     -43.8%     797.00 ± 65%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
      1662 ± 19%     -13.7%       1433 ± 31%  interrupts.CPU15.RES:Rescheduling_interrupts
     30.50 ± 18%     -78.7%       6.50 ± 66%  interrupts.CPU15.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU16.66:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU16.67:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU16.69:PCI-MSI.67178496-edge.ioat-msix
      5154 ± 50%     -21.6%       4042 ± 74%  interrupts.CPU16.CAL:Function_call_interrupts
      0.33 ±141%    -100.0%       0.00        interrupts.CPU16.IWI:IRQ_work_interrupts
    127429            -2.2%     124564 ±  5%  interrupts.CPU16.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU16.MCP:Machine_check_polls
      1594 ± 25%     -30.3%       1110 ± 48%  interrupts.CPU16.NMI:Non-maskable_interrupts
      1594 ± 25%     -30.3%       1110 ± 48%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
      2027 ± 24%     -23.3%       1554 ± 44%  interrupts.CPU16.RES:Rescheduling_interrupts
     23.50 ± 17%     -79.4%       4.83 ± 60%  interrupts.CPU16.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU17.67:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU17.68:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU17.70:PCI-MSI.67180544-edge.ioat-msix
      5501 ± 41%     -39.0%       3355 ± 55%  interrupts.CPU17.CAL:Function_call_interrupts
      0.83 ±223%    -100.0%       0.00        interrupts.CPU17.IWI:IRQ_work_interrupts
    127424            -2.2%     124569 ±  5%  interrupts.CPU17.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU17.MCP:Machine_check_polls
      1299 ± 43%     -10.9%       1157 ± 44%  interrupts.CPU17.NMI:Non-maskable_interrupts
      1299 ± 43%     -10.9%       1157 ± 44%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
      1975 ± 21%     -29.2%       1398 ± 30%  interrupts.CPU17.RES:Rescheduling_interrupts
     24.50 ± 43%     -84.4%       3.83 ± 43%  interrupts.CPU17.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU18.68:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU18.69:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU18.71:PCI-MSI.67182592-edge.ioat-msix
      4975 ± 35%     -32.6%       3351 ± 52%  interrupts.CPU18.CAL:Function_call_interrupts
    127424            -2.2%     124561 ±  5%  interrupts.CPU18.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU18.MCP:Machine_check_polls
      1376 ± 23%     -32.9%     924.50 ± 38%  interrupts.CPU18.NMI:Non-maskable_interrupts
      1376 ± 23%     -32.9%     924.50 ± 38%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
      1870 ± 15%     -23.3%       1435 ± 33%  interrupts.CPU18.RES:Rescheduling_interrupts
     25.33 ± 16%     -84.9%       3.83 ± 59%  interrupts.CPU18.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU19.69:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU19.70:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU19.72:PCI-MSI.67184640-edge.ioat-msix
      4145 ± 41%     -39.2%       2521 ± 18%  interrupts.CPU19.CAL:Function_call_interrupts
      0.50 ±152%    -100.0%       0.00        interrupts.CPU19.IWI:IRQ_work_interrupts
    127426            -2.3%     124549 ±  5%  interrupts.CPU19.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU19.MCP:Machine_check_polls
      1652 ± 35%     -44.7%     913.00 ± 33%  interrupts.CPU19.NMI:Non-maskable_interrupts
      1652 ± 35%     -44.7%     913.00 ± 33%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
      1455 ± 27%     -28.7%       1037 ± 27%  interrupts.CPU19.RES:Rescheduling_interrupts
     25.83 ± 29%     -80.6%       5.00 ± 40%  interrupts.CPU19.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU2.47:PCI-MSI.2623492-edge
      0.00          -100.0%       0.00        interrupts.CPU2.57:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU2.57:PCI-MSI.71680-edge.ioat-msix
      4950 ± 34%     -35.4%       3198 ± 27%  interrupts.CPU2.CAL:Function_call_interrupts
      0.00       +1.7e+101%       0.17 ±223%  interrupts.CPU2.IWI:IRQ_work_interrupts
    127409            -1.2%     125910 ±  2%  interrupts.CPU2.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU2.MCP:Machine_check_polls
    930.00 ± 20%     +57.5%       1465 ± 60%  interrupts.CPU2.NMI:Non-maskable_interrupts
    930.00 ± 20%     +57.5%       1465 ± 60%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
      1704 ± 16%      -6.7%       1589 ± 25%  interrupts.CPU2.RES:Rescheduling_interrupts
     31.33 ± 25%     -80.9%       6.00 ± 49%  interrupts.CPU2.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU20.70:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU20.71:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU20.73:PCI-MSI.67186688-edge.ioat-msix
      5351 ± 40%     -13.3%       4639 ± 57%  interrupts.CPU20.CAL:Function_call_interrupts
      0.00         +5e+101%       0.50 ±223%  interrupts.CPU20.IWI:IRQ_work_interrupts
    127413            -2.3%     124527 ±  5%  interrupts.CPU20.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU20.MCP:Machine_check_polls
      1564 ± 19%     -12.3%       1372 ± 93%  interrupts.CPU20.NMI:Non-maskable_interrupts
      1564 ± 19%     -12.3%       1372 ± 93%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
      1786 ± 25%      +2.8%       1836 ± 38%  interrupts.CPU20.RES:Rescheduling_interrupts
     26.00 ± 30%     -83.3%       4.33 ± 51%  interrupts.CPU20.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU21.71:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU21.72:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU21.74:PCI-MSI.67188736-edge.ioat-msix
      4081 ± 19%     -25.5%       3039 ± 49%  interrupts.CPU21.CAL:Function_call_interrupts
    127311            -2.2%     124517 ±  5%  interrupts.CPU21.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU21.MCP:Machine_check_polls
      1207 ± 29%      -8.2%       1108 ± 53%  interrupts.CPU21.NMI:Non-maskable_interrupts
      1207 ± 29%      -8.2%       1108 ± 53%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
      1452 ± 14%     -17.1%       1203 ± 37%  interrupts.CPU21.RES:Rescheduling_interrupts
     24.33 ± 38%     -80.8%       4.67 ± 57%  interrupts.CPU21.TLB:TLB_shootdowns
      4039 ± 40%     -31.8%       2756 ± 23%  interrupts.CPU22.CAL:Function_call_interrupts
      0.17 ±223%      +0.0%       0.17 ±223%  interrupts.CPU22.IWI:IRQ_work_interrupts
    127438            -2.2%     124571 ±  5%  interrupts.CPU22.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU22.MCP:Machine_check_polls
      1410 ± 22%     -22.5%       1093 ± 49%  interrupts.CPU22.NMI:Non-maskable_interrupts
      1410 ± 22%     -22.5%       1093 ± 49%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
      1278 ± 12%      -7.4%       1183 ± 21%  interrupts.CPU22.RES:Rescheduling_interrupts
     21.83 ± 54%     -70.2%       6.50 ± 23%  interrupts.CPU22.TLB:TLB_shootdowns
      2687 ± 15%     -16.2%       2252 ± 29%  interrupts.CPU23.CAL:Function_call_interrupts
    127416            -2.3%     124541 ±  5%  interrupts.CPU23.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU23.MCP:Machine_check_polls
      1201 ± 26%     -27.6%     870.00 ± 48%  interrupts.CPU23.NMI:Non-maskable_interrupts
      1201 ± 26%     -27.6%     870.00 ± 48%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
    984.50 ± 13%      -5.4%     931.33 ± 32%  interrupts.CPU23.RES:Rescheduling_interrupts
     20.00 ± 15%     -68.3%       6.33 ± 66%  interrupts.CPU23.TLB:TLB_shootdowns
      3659 ± 28%      +0.9%       3693 ± 35%  interrupts.CPU24.CAL:Function_call_interrupts
      0.00         +5e+101%       0.50 ±152%  interrupts.CPU24.IWI:IRQ_work_interrupts
    127536            -1.3%     125901 ±  2%  interrupts.CPU24.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU24.MCP:Machine_check_polls
      1082 ± 37%     +30.3%       1411 ± 29%  interrupts.CPU24.NMI:Non-maskable_interrupts
      1082 ± 37%     +30.3%       1411 ± 29%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
      1042 ± 19%     +41.6%       1476 ± 26%  interrupts.CPU24.RES:Rescheduling_interrupts
     24.00 ± 15%     -75.7%       5.83 ± 47%  interrupts.CPU24.TLB:TLB_shootdowns
      4805 ± 28%     -33.8%       3179 ± 43%  interrupts.CPU25.CAL:Function_call_interrupts
      0.17 ±223%    +100.0%       0.33 ±141%  interrupts.CPU25.IWI:IRQ_work_interrupts
    127443            -1.1%     126055 ±  2%  interrupts.CPU25.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU25.MCP:Machine_check_polls
      1458 ± 38%      +0.5%       1466 ± 30%  interrupts.CPU25.NMI:Non-maskable_interrupts
      1458 ± 38%      +0.5%       1466 ± 30%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
      1871 ± 19%     +17.8%       2204 ± 20%  interrupts.CPU25.RES:Rescheduling_interrupts
     26.83 ± 27%     -78.3%       5.83 ± 20%  interrupts.CPU25.TLB:TLB_shootdowns
    205.33 ± 55%     -50.7%     101.17 ± 41%  interrupts.CPU26.35:PCI-MSI.2621441-edge.eth0-TxRx-0
      4931 ± 34%     -37.5%       3080 ± 24%  interrupts.CPU26.CAL:Function_call_interrupts
      0.50 ±223%     -33.3%       0.33 ±141%  interrupts.CPU26.IWI:IRQ_work_interrupts
    127308            -1.1%     125955 ±  2%  interrupts.CPU26.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU26.MCP:Machine_check_polls
      1481 ± 29%     +17.0%       1733 ± 57%  interrupts.CPU26.NMI:Non-maskable_interrupts
      1481 ± 29%     +17.0%       1733 ± 57%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
      1926 ± 15%     +11.5%       2148 ± 23%  interrupts.CPU26.RES:Rescheduling_interrupts
     26.83 ± 19%     -73.3%       7.17 ± 37%  interrupts.CPU26.TLB:TLB_shootdowns
    534.00 ± 89%      +3.9%     554.67 ±157%  interrupts.CPU27.36:PCI-MSI.2621442-edge.eth0-TxRx-1
      4598 ± 24%     -12.7%       4014 ± 43%  interrupts.CPU27.CAL:Function_call_interrupts
      0.00         +5e+101%       0.50 ±100%  interrupts.CPU27.IWI:IRQ_work_interrupts
    127428            -1.2%     125950 ±  2%  interrupts.CPU27.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU27.MCP:Machine_check_polls
      1129 ± 16%     +56.1%       1763 ± 30%  interrupts.CPU27.NMI:Non-maskable_interrupts
      1129 ± 16%     +56.1%       1763 ± 30%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
      1969 ± 20%     +31.8%       2595 ± 19%  interrupts.CPU27.RES:Rescheduling_interrupts
     25.50 ± 13%     -71.2%       7.33 ± 31%  interrupts.CPU27.TLB:TLB_shootdowns
    238.50 ± 95%    +752.9%       2034 ±138%  interrupts.CPU28.37:PCI-MSI.2621443-edge.eth0-TxRx-2
      6256 ± 35%     -43.2%       3551 ± 44%  interrupts.CPU28.CAL:Function_call_interrupts
      1.33 ±111%     -37.5%       0.83 ±128%  interrupts.CPU28.IWI:IRQ_work_interrupts
    127617            -1.3%     125938 ±  2%  interrupts.CPU28.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU28.MCP:Machine_check_polls
      1275 ± 47%     +34.3%       1713 ± 59%  interrupts.CPU28.NMI:Non-maskable_interrupts
      1275 ± 47%     +34.3%       1713 ± 59%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
      2561 ± 15%      +4.2%       2669 ± 22%  interrupts.CPU28.RES:Rescheduling_interrupts
     28.83 ± 15%     -80.9%       5.50 ± 22%  interrupts.CPU28.TLB:TLB_shootdowns
    628.33 ±126%    +110.7%       1324 ±199%  interrupts.CPU29.38:PCI-MSI.2621444-edge.eth0-TxRx-3
      6917 ± 19%     -36.3%       4407 ± 52%  interrupts.CPU29.CAL:Function_call_interrupts
      0.33 ±141%    +250.0%       1.17 ±151%  interrupts.CPU29.IWI:IRQ_work_interrupts
    127446            -1.2%     125937 ±  2%  interrupts.CPU29.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU29.MCP:Machine_check_polls
      1458 ± 28%      +7.0%       1560 ± 38%  interrupts.CPU29.NMI:Non-maskable_interrupts
      1458 ± 28%      +7.0%       1560 ± 38%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
      2246 ± 15%     +11.1%       2496 ± 25%  interrupts.CPU29.RES:Rescheduling_interrupts
     28.33 ± 22%     -74.7%       7.17 ± 38%  interrupts.CPU29.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU3.48:PCI-MSI.2623493-edge
      0.00          -100.0%       0.00        interrupts.CPU3.58:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU3.58:PCI-MSI.73728-edge.ioat-msix
      4885 ± 19%     -42.0%       2832 ± 41%  interrupts.CPU3.CAL:Function_call_interrupts
      0.00       +8.3e+101%       0.83 ±223%  interrupts.CPU3.IWI:IRQ_work_interrupts
    127351            -1.1%     125904 ±  2%  interrupts.CPU3.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU3.MCP:Machine_check_polls
      1053 ± 12%     +22.4%       1289 ± 32%  interrupts.CPU3.NMI:Non-maskable_interrupts
      1053 ± 12%     +22.4%       1289 ± 32%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
      1461 ± 11%      -2.5%       1424 ± 28%  interrupts.CPU3.RES:Rescheduling_interrupts
     28.17 ± 20%     -80.5%       5.50 ± 50%  interrupts.CPU3.TLB:TLB_shootdowns
      2011 ±161%     -82.8%     346.83 ±127%  interrupts.CPU30.39:PCI-MSI.2621445-edge.eth0-TxRx-4
      4256 ± 50%     -24.7%       3206 ± 54%  interrupts.CPU30.CAL:Function_call_interrupts
      0.17 ±223%    +100.0%       0.33 ±141%  interrupts.CPU30.IWI:IRQ_work_interrupts
    127430            -1.3%     125805 ±  2%  interrupts.CPU30.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU30.MCP:Machine_check_polls
      1374 ± 32%      +5.9%       1455 ± 59%  interrupts.CPU30.NMI:Non-maskable_interrupts
      1374 ± 32%      +5.9%       1455 ± 59%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
      2286 ± 15%      -0.9%       2266 ± 39%  interrupts.CPU30.RES:Rescheduling_interrupts
     24.67 ± 32%     -80.4%       4.83 ± 30%  interrupts.CPU30.TLB:TLB_shootdowns
      5111 ±167%     -97.9%     109.00 ± 82%  interrupts.CPU31.40:PCI-MSI.2621446-edge.eth0-TxRx-5
      2656 ± 42%     +65.8%       4405 ± 32%  interrupts.CPU31.CAL:Function_call_interrupts
    127454            -1.2%     125956 ±  2%  interrupts.CPU31.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU31.MCP:Machine_check_polls
      1294 ± 22%     -22.2%       1007 ± 39%  interrupts.CPU31.NMI:Non-maskable_interrupts
      1294 ± 22%     -22.2%       1007 ± 39%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
      1577 ± 26%     +17.3%       1850 ± 27%  interrupts.CPU31.RES:Rescheduling_interrupts
     25.17 ± 40%     -74.2%       6.50 ± 19%  interrupts.CPU31.TLB:TLB_shootdowns
    224.83 ±132%     -18.8%     182.67 ± 54%  interrupts.CPU32.41:PCI-MSI.2621447-edge.eth0-TxRx-6
      5295 ± 32%     -15.9%       4452 ± 45%  interrupts.CPU32.CAL:Function_call_interrupts
      0.17 ±223%    +200.0%       0.50 ±100%  interrupts.CPU32.IWI:IRQ_work_interrupts
    127497            -1.3%     125866 ±  2%  interrupts.CPU32.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU32.MCP:Machine_check_polls
      1187 ± 30%     +18.8%       1410 ± 46%  interrupts.CPU32.NMI:Non-maskable_interrupts
      1187 ± 30%     +18.8%       1410 ± 46%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
      2167 ± 20%     +21.1%       2625 ±  5%  interrupts.CPU32.RES:Rescheduling_interrupts
     26.67 ± 47%     -76.9%       6.17 ± 25%  interrupts.CPU32.TLB:TLB_shootdowns
    209.83 ±155%     +29.6%     272.00 ±120%  interrupts.CPU33.42:PCI-MSI.2621448-edge.eth0-TxRx-7
      4981 ± 48%     -17.8%       4092 ± 64%  interrupts.CPU33.CAL:Function_call_interrupts
      0.17 ±223%      +0.0%       0.17 ±223%  interrupts.CPU33.IWI:IRQ_work_interrupts
    127480            -1.2%     125917 ±  2%  interrupts.CPU33.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU33.MCP:Machine_check_polls
      1493 ± 20%     -11.6%       1319 ± 46%  interrupts.CPU33.NMI:Non-maskable_interrupts
      1493 ± 20%     -11.6%       1319 ± 46%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
      2084 ± 23%     +16.8%       2435 ± 33%  interrupts.CPU33.RES:Rescheduling_interrupts
     29.00 ± 45%     -74.7%       7.33 ± 56%  interrupts.CPU33.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU34.4:IO-APIC.4-edge.ttyS0
      4062 ± 52%     +11.5%       4528 ± 47%  interrupts.CPU34.CAL:Function_call_interrupts
      0.50 ±152%     -66.7%       0.17 ±223%  interrupts.CPU34.IWI:IRQ_work_interrupts
    127471            -1.3%     125808 ±  2%  interrupts.CPU34.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU34.MCP:Machine_check_polls
      1416 ± 30%     -17.5%       1168 ± 29%  interrupts.CPU34.NMI:Non-maskable_interrupts
      1416 ± 30%     -17.5%       1168 ± 29%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
      1698 ± 21%     +39.2%       2364 ± 43%  interrupts.CPU34.RES:Rescheduling_interrupts
     31.00 ± 35%     -82.8%       5.33 ± 40%  interrupts.CPU34.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU35.44:PCI-MSI.2623489-edge
      0.00          -100.0%       0.00        interrupts.CPU35.53:PCI-MSI.65536-edge.ioat-msix
      3013 ± 39%      -2.8%       2929 ± 35%  interrupts.CPU35.CAL:Function_call_interrupts
      0.00       +3.3e+101%       0.33 ±141%  interrupts.CPU35.IWI:IRQ_work_interrupts
    127456            -1.2%     125902 ±  2%  interrupts.CPU35.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU35.MCP:Machine_check_polls
      1107 ± 40%     +35.3%       1498 ± 52%  interrupts.CPU35.NMI:Non-maskable_interrupts
      1107 ± 40%     +35.3%       1498 ± 52%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
      1402 ± 22%     +36.4%       1913 ± 14%  interrupts.CPU35.RES:Rescheduling_interrupts
     26.67 ± 23%     -74.4%       6.83 ± 37%  interrupts.CPU35.TLB:TLB_shootdowns
      4242 ± 34%      +0.4%       4260 ± 60%  interrupts.CPU36.CAL:Function_call_interrupts
      0.83 ±175%    -100.0%       0.00        interrupts.CPU36.IWI:IRQ_work_interrupts
    127548            -1.9%     125158 ±  4%  interrupts.CPU36.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU36.MCP:Machine_check_polls
      1367 ± 43%     -17.8%       1123 ± 46%  interrupts.CPU36.NMI:Non-maskable_interrupts
      1367 ± 43%     -17.8%       1123 ± 46%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
      2047 ± 22%      -2.6%       1993 ± 27%  interrupts.CPU36.RES:Rescheduling_interrupts
     19.67 ± 26%     -73.7%       5.17 ± 39%  interrupts.CPU36.TLB:TLB_shootdowns
      4808 ± 34%     -40.9%       2843 ± 27%  interrupts.CPU37.CAL:Function_call_interrupts
      0.33 ±223%    -100.0%       0.00        interrupts.CPU37.IWI:IRQ_work_interrupts
    127457            -2.0%     124883 ±  4%  interrupts.CPU37.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU37.MCP:Machine_check_polls
      1570 ± 33%     -40.3%     937.17 ± 33%  interrupts.CPU37.NMI:Non-maskable_interrupts
      1570 ± 33%     -40.3%     937.17 ± 33%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
      1784 ± 21%      +6.9%       1907 ± 26%  interrupts.CPU37.RES:Rescheduling_interrupts
     23.00 ± 24%     -79.7%       4.67 ± 72%  interrupts.CPU37.TLB:TLB_shootdowns
      5213 ± 43%     -32.7%       3506 ± 39%  interrupts.CPU38.CAL:Function_call_interrupts
      0.17 ±223%    +100.0%       0.33 ±223%  interrupts.CPU38.IWI:IRQ_work_interrupts
    127435            -2.1%     124711 ±  4%  interrupts.CPU38.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU38.MCP:Machine_check_polls
      1488 ± 41%     -28.1%       1069 ± 58%  interrupts.CPU38.NMI:Non-maskable_interrupts
      1488 ± 41%     -28.1%       1069 ± 58%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
      2142 ± 16%      -5.3%       2029 ± 17%  interrupts.CPU38.RES:Rescheduling_interrupts
     20.67 ± 15%     -73.4%       5.50 ± 52%  interrupts.CPU38.TLB:TLB_shootdowns
      4545 ± 34%     -32.0%       3090 ± 39%  interrupts.CPU39.CAL:Function_call_interrupts
      0.17 ±223%      +0.0%       0.17 ±223%  interrupts.CPU39.IWI:IRQ_work_interrupts
    127458            -2.2%     124596 ±  4%  interrupts.CPU39.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU39.MCP:Machine_check_polls
      1473 ± 31%     -24.7%       1108 ± 65%  interrupts.CPU39.NMI:Non-maskable_interrupts
      1473 ± 31%     -24.7%       1108 ± 65%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
      1949 ± 29%      -3.1%       1889 ± 21%  interrupts.CPU39.RES:Rescheduling_interrupts
     30.33 ± 20%     -81.3%       5.67 ± 28%  interrupts.CPU39.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU4.49:PCI-MSI.2623494-edge
      0.00          -100.0%       0.00        interrupts.CPU4.59:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU4.59:PCI-MSI.75776-edge.ioat-msix
      6142 ± 33%     -34.3%       4036 ± 46%  interrupts.CPU4.CAL:Function_call_interrupts
      0.00       +3.3e+101%       0.33 ±141%  interrupts.CPU4.IWI:IRQ_work_interrupts
    127425            -1.1%     126057 ±  2%  interrupts.CPU4.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU4.MCP:Machine_check_polls
      1186 ± 37%      +7.5%       1275 ± 50%  interrupts.CPU4.NMI:Non-maskable_interrupts
      1186 ± 37%      +7.5%       1275 ± 50%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
      2157 ± 17%     -15.0%       1832 ± 30%  interrupts.CPU4.RES:Rescheduling_interrupts
     24.33 ± 24%     -84.9%       3.67 ± 46%  interrupts.CPU4.TLB:TLB_shootdowns
      5004 ± 59%      +1.2%       5066 ± 69%  interrupts.CPU40.CAL:Function_call_interrupts
      0.17 ±223%    +100.0%       0.33 ±141%  interrupts.CPU40.IWI:IRQ_work_interrupts
    127356            -2.2%     124530 ±  5%  interrupts.CPU40.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU40.MCP:Machine_check_polls
      1529 ± 38%     -18.8%       1242 ± 55%  interrupts.CPU40.NMI:Non-maskable_interrupts
      1529 ± 38%     -18.8%       1242 ± 55%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
      2330 ± 21%      -0.4%       2321 ± 27%  interrupts.CPU40.RES:Rescheduling_interrupts
     24.50 ± 11%     -77.6%       5.50 ± 44%  interrupts.CPU40.TLB:TLB_shootdowns
      4611 ± 35%     -23.5%       3526 ± 40%  interrupts.CPU41.CAL:Function_call_interrupts
      0.50 ±152%     -66.7%       0.17 ±223%  interrupts.CPU41.IWI:IRQ_work_interrupts
    127428            -2.3%     124554 ±  5%  interrupts.CPU41.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU41.MCP:Machine_check_polls
      1620 ± 33%     -33.9%       1071 ± 64%  interrupts.CPU41.NMI:Non-maskable_interrupts
      1620 ± 33%     -33.9%       1071 ± 64%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
      2145 ± 18%      +4.1%       2233 ± 45%  interrupts.CPU41.RES:Rescheduling_interrupts
     26.83 ±  8%     -80.1%       5.33 ± 46%  interrupts.CPU41.TLB:TLB_shootdowns
      5388 ± 37%     -31.5%       3692 ± 48%  interrupts.CPU42.CAL:Function_call_interrupts
      0.50 ±152%     -66.7%       0.17 ±223%  interrupts.CPU42.IWI:IRQ_work_interrupts
    127435            -2.2%     124605 ±  5%  interrupts.CPU42.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU42.MCP:Machine_check_polls
      1445 ± 42%     -39.0%     881.33 ± 69%  interrupts.CPU42.NMI:Non-maskable_interrupts
      1445 ± 42%     -39.0%     881.33 ± 69%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
      2060 ± 23%      -6.3%       1930 ± 10%  interrupts.CPU42.RES:Rescheduling_interrupts
     29.33 ± 15%     -82.4%       5.17 ± 45%  interrupts.CPU42.TLB:TLB_shootdowns
      3946 ± 44%     -24.3%       2986 ± 32%  interrupts.CPU43.CAL:Function_call_interrupts
      0.00       +1.7e+101%       0.17 ±223%  interrupts.CPU43.IWI:IRQ_work_interrupts
    127527            -2.3%     124540 ±  5%  interrupts.CPU43.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU43.MCP:Machine_check_polls
      1226 ± 36%      +6.8%       1310 ± 62%  interrupts.CPU43.NMI:Non-maskable_interrupts
      1226 ± 36%      +6.8%       1310 ± 62%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
      1741 ± 16%     -10.5%       1558 ± 12%  interrupts.CPU43.RES:Rescheduling_interrupts
     25.83 ± 20%     -76.8%       6.00 ± 27%  interrupts.CPU43.TLB:TLB_shootdowns
      4955 ± 41%     -10.3%       4443 ± 59%  interrupts.CPU44.CAL:Function_call_interrupts
      0.00       +6.7e+101%       0.67 ±165%  interrupts.CPU44.IWI:IRQ_work_interrupts
    127480            -2.3%     124532 ±  5%  interrupts.CPU44.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU44.MCP:Machine_check_polls
      1032 ± 49%     +37.8%       1421 ± 40%  interrupts.CPU44.NMI:Non-maskable_interrupts
      1032 ± 49%     +37.8%       1421 ± 40%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
      2091 ± 20%     +14.5%       2395 ± 28%  interrupts.CPU44.RES:Rescheduling_interrupts
     21.33 ± 20%     -67.2%       7.00 ± 27%  interrupts.CPU44.TLB:TLB_shootdowns
      3885 ± 19%     -15.2%       3294 ± 29%  interrupts.CPU45.CAL:Function_call_interrupts
      0.00       +1.7e+101%       0.17 ±223%  interrupts.CPU45.IWI:IRQ_work_interrupts
    127427            -2.3%     124464 ±  5%  interrupts.CPU45.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU45.MCP:Machine_check_polls
      1774 ±  6%     -37.2%       1114 ± 47%  interrupts.CPU45.NMI:Non-maskable_interrupts
      1774 ±  6%     -37.2%       1114 ± 47%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
      1748 ± 18%      -1.7%       1717 ± 22%  interrupts.CPU45.RES:Rescheduling_interrupts
     24.50 ±  5%     -67.3%       8.00 ± 46%  interrupts.CPU45.TLB:TLB_shootdowns
      4259 ± 41%     -40.8%       2522 ± 29%  interrupts.CPU46.CAL:Function_call_interrupts
      0.00       +1.7e+101%       0.17 ±223%  interrupts.CPU46.IWI:IRQ_work_interrupts
    127459            -2.3%     124542 ±  5%  interrupts.CPU46.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU46.MCP:Machine_check_polls
      1055 ± 36%      +2.9%       1086 ± 59%  interrupts.CPU46.NMI:Non-maskable_interrupts
      1055 ± 36%      +2.9%       1086 ± 59%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
      1527 ± 20%      -2.5%       1489 ± 15%  interrupts.CPU46.RES:Rescheduling_interrupts
     25.83 ± 23%     -68.4%       8.17 ± 22%  interrupts.CPU46.TLB:TLB_shootdowns
      2788 ± 15%     -36.8%       1761 ± 56%  interrupts.CPU47.CAL:Function_call_interrupts
      0.17 ±223%    -100.0%       0.00        interrupts.CPU47.IWI:IRQ_work_interrupts
    127426            -2.3%     124538 ±  5%  interrupts.CPU47.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU47.MCP:Machine_check_polls
      1418 ± 38%     -56.1%     623.33 ± 28%  interrupts.CPU47.NMI:Non-maskable_interrupts
      1418 ± 38%     -56.1%     623.33 ± 28%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
      1241 ± 13%      -9.6%       1122 ± 23%  interrupts.CPU47.RES:Rescheduling_interrupts
     38.17 ±  9%     -49.8%      19.17 ± 20%  interrupts.CPU47.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU5.50:PCI-MSI.2623495-edge
      0.00          -100.0%       0.00        interrupts.CPU5.60:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU5.60:PCI-MSI.77824-edge.ioat-msix
      6219 ± 26%     -39.3%       3775 ± 53%  interrupts.CPU5.CAL:Function_call_interrupts
      0.00       +1.7e+101%       0.17 ±223%  interrupts.CPU5.IWI:IRQ_work_interrupts
    127475            -1.1%     126121 ±  2%  interrupts.CPU5.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU5.MCP:Machine_check_polls
      1160 ± 37%     +17.7%       1365 ± 45%  interrupts.CPU5.NMI:Non-maskable_interrupts
      1160 ± 37%     +17.7%       1365 ± 45%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
      1814 ± 23%     -12.2%       1593 ± 36%  interrupts.CPU5.RES:Rescheduling_interrupts
     25.17 ± 12%     -77.5%       5.67 ± 47%  interrupts.CPU5.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU6.51:PCI-MSI.2623496-edge
      0.00          -100.0%       0.00        interrupts.CPU6.61:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU6.61:PCI-MSI.79872-edge.ioat-msix
      4120 ± 54%     -21.1%       3251 ± 54%  interrupts.CPU6.CAL:Function_call_interrupts
    127445            -1.3%     125789 ±  2%  interrupts.CPU6.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU6.MCP:Machine_check_polls
    939.17 ± 34%     +25.1%       1175 ± 36%  interrupts.CPU6.NMI:Non-maskable_interrupts
    939.17 ± 34%     +25.1%       1175 ± 36%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
      1357 ± 34%      -3.8%       1305 ± 32%  interrupts.CPU6.RES:Rescheduling_interrupts
     23.33 ± 32%     -80.0%       4.67 ± 36%  interrupts.CPU6.TLB:TLB_shootdowns
    207.50 ±141%     -56.9%      89.50 ±223%  interrupts.CPU7.62:PCI-MSI.2097152-edge.isci-msix
      0.00          -100.0%       0.00        interrupts.CPU7.62:PCI-MSI.79872-edge.ioat-msix
      2453 ± 32%     +51.3%       3712 ± 30%  interrupts.CPU7.CAL:Function_call_interrupts
      0.17 ±223%      +0.0%       0.17 ±223%  interrupts.CPU7.IWI:IRQ_work_interrupts
    127440            -1.2%     125920 ±  2%  interrupts.CPU7.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU7.MCP:Machine_check_polls
      1123 ± 30%      -2.3%       1098 ± 15%  interrupts.CPU7.NMI:Non-maskable_interrupts
      1123 ± 30%      -2.3%       1098 ± 15%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
      1100 ± 15%     +45.3%       1598 ± 19%  interrupts.CPU7.RES:Rescheduling_interrupts
     24.67 ± 33%     -71.6%       7.00 ± 21%  interrupts.CPU7.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU8.22:IO-APIC.22-fasteoi.ehci_hcd:usb1
    117.83 ±223%    -100.0%       0.00        interrupts.CPU8.71:PCI-MSI.2097152-edge.isci-msix
    322.17 ±100%     +50.8%     485.83 ± 48%  interrupts.CPU8.73:PCI-MSI.2097152-edge.isci-msix
      4741 ± 20%     -12.3%       4156 ± 58%  interrupts.CPU8.CAL:Function_call_interrupts
      0.50 ±223%    -100.0%       0.00        interrupts.CPU8.IWI:IRQ_work_interrupts
    127379            -1.2%     125905 ±  2%  interrupts.CPU8.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU8.MCP:Machine_check_polls
      1261 ± 29%     -17.6%       1038 ± 29%  interrupts.CPU8.NMI:Non-maskable_interrupts
      1261 ± 29%     -17.6%       1038 ± 29%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
      1488 ± 13%     +21.2%       1803 ± 26%  interrupts.CPU8.RES:Rescheduling_interrupts
     21.83 ± 34%     -71.8%       6.17 ± 63%  interrupts.CPU8.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU9.20:IO-APIC.20-fasteoi.ehci_hcd:usb2
      0.00          -100.0%       0.00        interrupts.CPU9.64:PCI-MSI.79872-edge.ioat-msix
      4119 ± 41%      +0.6%       4143 ± 50%  interrupts.CPU9.CAL:Function_call_interrupts
      0.33 ±223%    -100.0%       0.00        interrupts.CPU9.IWI:IRQ_work_interrupts
    127484            -1.2%     125907 ±  2%  interrupts.CPU9.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU9.MCP:Machine_check_polls
      1159 ± 27%      -7.0%       1077 ± 26%  interrupts.CPU9.NMI:Non-maskable_interrupts
      1159 ± 27%      -7.0%       1077 ± 26%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
      1336 ± 27%     +46.4%       1956 ± 18%  interrupts.CPU9.RES:Rescheduling_interrupts
     21.00 ± 36%     -77.8%       4.67 ± 54%  interrupts.CPU9.TLB:TLB_shootdowns
     10.33 ± 22%     +21.0%      12.50 ± 19%  interrupts.IWI:IRQ_work_interrupts
   6117286            -1.7%    6013629 ±  3%  interrupts.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.MCP:Machine_check_polls
     62152 ±  3%      -7.6%      57456 ±  3%  interrupts.NMI:Non-maskable_interrupts
     62152 ±  3%      -7.6%      57456 ±  3%  interrupts.PMI:Performance_monitoring_interrupts
     83027 ±  7%      +2.3%      84967 ±  5%  interrupts.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00        interrupts.RTR:APIC_ICR_read_retries
      1257 ± 17%     -76.2%     298.83 ± 11%  interrupts.TLB:TLB_shootdowns
     57.56            -1.1       56.50 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     57.63            -1.1       56.57 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     57.62            -1.1       56.56 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     58.57            -0.9       57.62        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     39.13 ±  2%      -0.7       38.39 ±  3%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     50.68            -0.6       50.03 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     50.50            -0.6       49.87 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      3.19 ±  2%      -0.2        2.97 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      3.27 ±  2%      -0.2        3.05 ±  5%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      4.65 ±  2%      -0.2        4.44 ±  3%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      0.83 ±  6%      -0.2        0.63 ±  5%  perf-profile.calltrace.cycles-pp.__entry_text_start
      0.55 ±  5%      -0.2        0.36 ± 70%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      0.45 ± 45%      -0.2        0.28 ±100%  perf-profile.calltrace.cycles-pp.__pte_alloc.copy_pte_range.copy_page_range.dup_mmap.dup_mm
      2.89 ±  9%      -0.2        2.71 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.36 ± 70%      -0.2        0.18 ±141%  perf-profile.calltrace.cycles-pp.do_set_pte.filemap_map_pages.do_fault.__handle_mm_fault.handle_mm_fault
      0.26 ±100%      -0.2        0.09 ±223%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_common_lock.do_notify_parent_cldstop
      2.72 ±  9%      -0.2        2.55 ±  4%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      2.41 ±  3%      -0.2        2.24 ±  5%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.do_notify_parent_cldstop.ptrace_stop.ptrace_do_notify
      2.51 ±  4%      -0.2        2.34 ±  5%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.do_notify_parent_cldstop.ptrace_stop.ptrace_do_notify.ptrace_notify
      0.25 ±100%      -0.2        0.09 ±223%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_common_lock
      2.15 ±  4%      -0.1        2.00 ±  5%  perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.do_notify_parent_cldstop.ptrace_stop
      1.86 ±  4%      -0.1        1.73 ±  3%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.83 ±  4%      -0.1        2.71 ±  5%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      1.43 ±  3%      -0.1        1.31 ±  6%  perf-profile.calltrace.cycles-pp.do_notify_parent_cldstop.ptrace_stop.ptrace_do_notify.ptrace_notify.syscall_exit_to_user_mode_prepare
      1.06 ±  5%      -0.1        0.95 ±  7%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.06 ±  5%      -0.1        0.94 ±  7%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.80 ±  4%      -0.1        2.69 ±  5%  perf-profile.calltrace.cycles-pp.ptrace_notify.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      2.68 ±  4%      -0.1        2.57 ±  4%  perf-profile.calltrace.cycles-pp.ptrace_stop.ptrace_do_notify.ptrace_notify.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode
      2.78 ±  4%      -0.1        2.67 ±  5%  perf-profile.calltrace.cycles-pp.ptrace_do_notify.ptrace_notify.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      1.78 ±  9%      -0.1        1.67 ±  4%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.73 ± 12%      -0.1        0.63 ±  7%  perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.unmap_page_range.unmap_vmas.unmap_region
      0.95 ±  5%      -0.1        0.85 ±  7%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.94 ±  5%      -0.1        0.84 ±  7%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      1.41 ±  5%      -0.1        1.32 ±  5%  perf-profile.calltrace.cycles-pp.do_notify_parent_cldstop.ptrace_stop.ptrace_do_notify.ptrace_notify.syscall_trace_enter
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.17 ±141%      -0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.pte_alloc_one.__pte_alloc.copy_pte_range.copy_page_range
      0.17 ±141%      -0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.kmem_cache_free.remove_vma.__do_munmap.__vm_munmap.__x64_sys_munmap
      2.76 ±  3%      -0.1        2.68 ±  3%  perf-profile.calltrace.cycles-pp.syscall_trace_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.74 ±  3%      -0.1        2.66 ±  3%  perf-profile.calltrace.cycles-pp.ptrace_notify.syscall_trace_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.72 ±  3%      -0.1        2.63 ±  3%  perf-profile.calltrace.cycles-pp.ptrace_do_notify.ptrace_notify.syscall_trace_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.69 ± 10%      -0.1        1.61 ±  4%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.33 ±  4%      -0.1        1.24 ±  5%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup_entry
      2.62 ±  3%      -0.1        2.54 ±  3%  perf-profile.calltrace.cycles-pp.ptrace_stop.ptrace_do_notify.ptrace_notify.syscall_trace_enter.do_syscall_64
      1.57 ±  3%      -0.1        1.49 ±  5%  perf-profile.calltrace.cycles-pp.__schedule.schedule.ptrace_stop.ptrace_do_notify.ptrace_notify
      1.37 ±  3%      -0.1        1.30 ±  5%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.79 ±  4%      -0.1        0.74 ±  6%  perf-profile.calltrace.cycles-pp.schedule.ptrace_stop.ptrace_do_notify.ptrace_notify.syscall_trace_enter
      0.74 ±  5%      -0.1        0.69 ±  4%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
      0.99 ±  5%      -0.1        0.94 ±  5%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule_idle.do_idle
      1.24 ± 11%      -0.0        1.20 ±  4%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.70 ±  2%      -0.0        1.66 ±  5%  perf-profile.calltrace.cycles-pp.schedule.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.98 ±  3%      -0.0        0.94 ±  5%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.96 ±  4%      -0.0        0.92 ±  5%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.96 ±  4%      -0.0        0.92 ±  5%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      1.03 ±  4%      -0.0        0.99 ±  5%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.ptrace_resume.ptrace_request.arch_ptrace
      0.99 ±  5%      -0.0        0.95 ±  6%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.ptrace_resume.ptrace_request
      0.82 ±  5%      -0.0        0.78 ±  7%  perf-profile.calltrace.cycles-pp.schedule.ptrace_stop.ptrace_do_notify.ptrace_notify.syscall_exit_to_user_mode_prepare
      1.59 ±  2%      -0.0        1.56 ±  6%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_wait.kernel_wait4.__do_sys_wait4
      0.39 ± 71%      -0.0        0.36 ± 71%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.66 ±  3%      -0.0        0.64 ±  8%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm.copy_process
      1.05 ±  4%      -0.0        1.03 ±  7%  perf-profile.calltrace.cycles-pp.vm_area_dup.dup_mmap.dup_mm.copy_process.kernel_clone
      0.59 ±  3%      -0.0        0.57 ±  7%  perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.85 ±  3%      -0.0        0.84 ±  8%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.do_wait.kernel_wait4
      0.76 ±  6%      -0.0        0.74 ±  5%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare.irqentry_exit_to_user_mode
      0.78 ± 13%      -0.0        0.76 ±  5%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.75 ±  6%      -0.0        0.74 ±  5%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare
      0.70 ± 13%      -0.0        0.69 ±  5%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.67 ± 14%      -0.0        0.66 ±  5%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.76 ±  4%      -0.0        0.75 ±  8%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.do_wait
      0.76 ±  6%      -0.0        0.75 ±  6%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.ptrace_resume
      0.09 ±223%      -0.0        0.09 ±223%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.62 ±  9%      -0.0        0.62 ± 11%  perf-profile.calltrace.cycles-pp.dup_task_struct.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.27 ±100%      -0.0        0.27 ±100%  perf-profile.calltrace.cycles-pp.pte_alloc_one.__pte_alloc.copy_pte_range.copy_page_range.dup_mmap
      2.20 ±  4%      +0.0        2.21 ±  5%  perf-profile.calltrace.cycles-pp.ptrace_request.arch_ptrace.__x64_sys_ptrace.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.20 ±  4%      +0.0        2.21 ±  5%  perf-profile.calltrace.cycles-pp.arch_ptrace.__x64_sys_ptrace.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.01 ±  4%      +0.0        2.02 ±  5%  perf-profile.calltrace.cycles-pp.try_to_wake_up.ptrace_resume.ptrace_request.arch_ptrace.__x64_sys_ptrace
      2.18 ±  4%      +0.0        2.20 ±  5%  perf-profile.calltrace.cycles-pp.ptrace_resume.ptrace_request.arch_ptrace.__x64_sys_ptrace.do_syscall_64
      1.93 ±  8%      +0.0        1.95 ± 11%  perf-profile.calltrace.cycles-pp.copy_page_range.dup_mmap.dup_mm.copy_process.kernel_clone
      1.51 ±  9%      +0.0        1.53 ± 12%  perf-profile.calltrace.cycles-pp.copy_pte_range.copy_page_range.dup_mmap.dup_mm.copy_process
      0.59 ±  5%      +0.0        0.64 ±  6%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.61 ±  9%      +0.0        0.66 ±  5%  perf-profile.calltrace.cycles-pp.remove_vma.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      0.96 ±  2%      +0.1        1.02 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork
      2.98 ±  6%      +0.1        3.04 ±  9%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.__do_munmap.__vm_munmap
      2.72 ±  7%      +0.1        2.78 ±  9%  perf-profile.calltrace.cycles-pp.zap_pte_range.unmap_page_range.unmap_vmas.unmap_region.__do_munmap
      3.57 ±  2%      +0.1        3.64 ±  6%  perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.29            +0.1        3.36 ±  7%  perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.07 ±  6%      +0.1        3.15 ±  8%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
      3.61 ±  2%      +0.1        3.69 ±  6%  perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.96 ±  4%      +0.1        3.04 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_ptrace.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.__vmalloc_node_range.dup_task_struct.copy_process.kernel_clone.__do_sys_clone
      0.81 ±  4%      +0.1        0.89 ±  6%  perf-profile.calltrace.cycles-pp.release_pages.tlb_flush_mmu.tlb_finish_mmu.unmap_region.__do_munmap
      0.00            +0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_remove.unlink_anon_vmas.free_pgtables.unmap_region.__do_munmap
      5.38 ±  4%      +0.1        5.49 ±  4%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      0.94 ± 40%      +0.1        1.05 ± 37%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.94 ± 40%      +0.1        1.05 ± 37%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.94 ± 40%      +0.1        1.05 ± 37%  perf-profile.calltrace.cycles-pp.start_kernel.secondary_startup_64_no_verify
      0.63 ±  4%      +0.1        0.76 ±  5%  perf-profile.calltrace.cycles-pp.kmem_cache_free.unlink_anon_vmas.free_pgtables.unmap_region.__do_munmap
      1.15 ±  3%      +0.1        1.30 ±  4%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
      1.13 ±  3%      +0.2        1.28 ±  4%  perf-profile.calltrace.cycles-pp.tlb_flush_mmu.tlb_finish_mmu.unmap_region.__do_munmap.__vm_munmap
      3.44 ±  4%      +0.2        3.60 ±  5%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      3.30 ±  4%      +0.2        3.46 ±  5%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.48 ±  5%      +0.2        2.65 ±  6%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      4.03 ±  4%      +0.2        4.20 ±  5%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.00            +0.2        0.17 ±141%  perf-profile.calltrace.cycles-pp.ptrace_check_attach.__x64_sys_ptrace.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.36 ±  5%      +0.2        2.53 ±  5%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      3.96 ±  4%      +0.2        4.14 ±  5%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.2        0.19 ±141%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      0.26 ±100%      +0.2        0.46 ± 45%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      1.09 ±  4%      +0.2        1.31 ±  7%  perf-profile.calltrace.cycles-pp.next_uptodate_page.filemap_map_pages.do_fault.__handle_mm_fault.handle_mm_fault
      0.00            +0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.3        0.28 ±100%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      0.67 ± 78%      +0.3        0.96 ± 39%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.67 ± 79%      +0.3        0.96 ± 39%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel
      1.20 ±  3%      +0.4        1.55 ±  9%  perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
      1.83 ±  3%      +0.4        2.21 ±  7%  perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
      1.52 ±  3%      +0.4        1.91 ±  6%  perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.unmap_region.__do_munmap.__vm_munmap
      7.61 ±  4%      +0.4        8.01 ±  6%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.60 ±  4%      +0.4        8.01 ±  6%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.23 ±  4%      +0.4        7.67 ±  6%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.97 ±  4%      +0.5        6.42 ±  6%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      5.80 ±  4%      +0.5        6.27 ±  6%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      0.09 ±223%      +0.6        0.67 ±  5%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.unmap_region.__do_munmap.__vm_munmap
      2.25 ±  4%      +0.6        2.85 ±  5%  perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
      7.91            +0.7        8.64 ±  7%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      6.58 ±  4%      +0.8        7.39 ±  4%  perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      7.57 ±  4%      +1.0        8.55 ±  4%  perf-profile.calltrace.cycles-pp.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.64 ±  4%      +1.0        8.63 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.63 ±  4%      +1.0        8.62 ±  4%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.20 ±  2%      +1.1       32.34 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     26.38 ±  2%      +1.4       27.73 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     57.63            -1.1       56.57 ±  2%  perf-profile.children.cycles-pp.start_secondary
     58.53            -1.0       57.58        perf-profile.children.cycles-pp.do_idle
     58.57            -0.9       57.62        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     58.57            -0.9       57.62        perf-profile.children.cycles-pp.cpu_startup_entry
     39.33 ±  2%      -0.9       38.39 ±  3%  perf-profile.children.cycles-pp.intel_idle
     51.50            -0.5       51.00        perf-profile.children.cycles-pp.cpuidle_enter
     51.47            -0.5       50.97        perf-profile.children.cycles-pp.cpuidle_enter_state
      6.69            -0.4        6.33 ±  2%  perf-profile.children.cycles-pp.__schedule
      3.33 ±  2%      -0.2        3.10 ±  4%  perf-profile.children.cycles-pp.schedule_idle
      3.09 ±  3%      -0.2        2.86 ±  5%  perf-profile.children.cycles-pp.do_notify_parent_cldstop
      5.76 ±  3%      -0.2        5.54 ±  3%  perf-profile.children.cycles-pp.ptrace_stop
      4.69 ±  2%      -0.2        4.48 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      5.55 ±  3%      -0.2        5.35 ±  3%  perf-profile.children.cycles-pp.ptrace_notify
      5.50 ±  3%      -0.2        5.30 ±  3%  perf-profile.children.cycles-pp.ptrace_do_notify
      0.90 ±  6%      -0.2        0.71 ±  5%  perf-profile.children.cycles-pp.__entry_text_start
      2.83 ±  4%      -0.2        2.65 ±  5%  perf-profile.children.cycles-pp.__wake_up_common_lock
      2.71 ±  3%      -0.2        2.54 ±  5%  perf-profile.children.cycles-pp.__wake_up_common
      1.91 ±  4%      -0.1        1.77 ±  4%  perf-profile.children.cycles-pp.menu_select
      3.53 ±  2%      -0.1        3.39 ±  2%  perf-profile.children.cycles-pp.schedule
      4.54 ±  2%      -0.1        4.41 ±  4%  perf-profile.children.cycles-pp.try_to_wake_up
      2.83 ±  4%      -0.1        2.71 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      1.65 ±  2%      -0.1        1.53 ±  4%  perf-profile.children.cycles-pp.update_load_avg
      1.06 ±  5%      -0.1        0.95 ±  7%  perf-profile.children.cycles-pp.do_sys_openat2
      3.25 ±  9%      -0.1        3.13 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.07 ±  5%      -0.1        0.95 ±  7%  perf-profile.children.cycles-pp.do_sys_open
      3.46 ±  9%      -0.1        3.35 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.77 ± 13%      -0.1        0.66 ±  7%  perf-profile.children.cycles-pp.page_remove_rmap
      2.18 ±  3%      -0.1        2.08 ±  4%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.96 ±  5%      -0.1        0.86 ±  7%  perf-profile.children.cycles-pp.do_filp_open
      0.95 ±  5%      -0.1        0.85 ±  7%  perf-profile.children.cycles-pp.path_openat
      2.15 ±  3%      -0.1        2.06 ±  4%  perf-profile.children.cycles-pp.enqueue_task_fair
      2.09 ±  9%      -0.1        2.00 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.76 ±  3%      -0.1        2.68 ±  3%  perf-profile.children.cycles-pp.syscall_trace_enter
      2.00 ±  9%      -0.1        1.92 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.62 ±  3%      -0.1        1.55 ±  5%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.15 ±  5%      -0.1        1.08 ±  6%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      1.55            -0.1        1.48 ±  4%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      1.38 ±  3%      -0.1        1.31 ±  5%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.80 ±  6%      -0.1        0.73 ±  7%  perf-profile.children.cycles-pp.get_page_from_freelist
      1.29 ±  2%      -0.1        1.22 ±  4%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
      1.76 ±  2%      -0.1        1.71 ±  5%  perf-profile.children.cycles-pp.dequeue_task_fair
      1.28 ±  2%      -0.1        1.22 ±  4%  perf-profile.children.cycles-pp.get_signal
      0.82 ±  5%      -0.1        0.77 ±  5%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.02 ±  5%      -0.1        0.97 ±  5%  perf-profile.children.cycles-pp.set_next_entity
      1.72 ±  4%      -0.0        1.67 ±  4%  perf-profile.children.cycles-pp.enqueue_entity
      0.47 ± 11%      -0.0        0.42 ±  7%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      1.57 ±  3%      -0.0        1.53 ±  5%  perf-profile.children.cycles-pp.dequeue_entity
      0.37 ±  8%      -0.0        0.33 ± 16%  perf-profile.children.cycles-pp.page_add_file_rmap
      0.18 ±  6%      -0.0        0.13 ± 16%  perf-profile.children.cycles-pp.proc_pid_make_inode
      0.53 ±  8%      -0.0        0.48 ± 12%  perf-profile.children.cycles-pp.do_set_pte
      0.30 ± 14%      -0.0        0.26 ±  9%  perf-profile.children.cycles-pp.tick_nohz_next_event
      1.46 ± 11%      -0.0        1.42 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.15 ±  6%      -0.0        0.11 ± 19%  perf-profile.children.cycles-pp.new_inode
      0.15 ±  4%      -0.0        0.11 ± 18%  perf-profile.children.cycles-pp.new_inode_pseudo
      0.16 ± 18%      -0.0        0.12 ± 17%  perf-profile.children.cycles-pp.try_charge
      0.17 ± 18%      -0.0        0.13 ±  9%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.52 ± 10%      -0.0        0.48 ±  8%  perf-profile.children.cycles-pp.prep_new_page
      0.57 ±  7%      -0.0        0.53 ±  7%  perf-profile.children.cycles-pp.ktime_get
      0.47 ±  7%      -0.0        0.43 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.45 ±  8%      -0.0        0.41 ±  6%  perf-profile.children.cycles-pp.finish_task_switch
      0.36 ±  7%      -0.0        0.32 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      0.06 ± 15%      -0.0        0.02 ±144%  perf-profile.children.cycles-pp.__update_idle_core
      0.19 ± 38%      -0.0        0.16 ± 50%  perf-profile.children.cycles-pp.vm_normal_page
      0.04 ± 45%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.unfreeze_partials
      1.83 ±  3%      -0.0        1.79 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.74 ±  2%      -0.0        0.71 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.15 ±  8%      -0.0        0.12 ± 14%  perf-profile.children.cycles-pp.proc_pident_lookup
      0.49 ±  3%      -0.0        0.45 ±  6%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.50 ± 10%      -0.0        0.46 ±  9%  perf-profile.children.cycles-pp.clear_page_erms
      0.11 ±  9%      -0.0        0.08 ± 20%  perf-profile.children.cycles-pp.alloc_inode
      0.03 ±101%      -0.0        0.00        perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.53 ±  3%      -0.0        0.50 ±  5%  perf-profile.children.cycles-pp.__switch_to
      0.05 ± 45%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.04 ± 45%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.put_cpu_partial
      0.22 ± 12%      -0.0        0.19 ± 22%  perf-profile.children.cycles-pp.tick_irq_enter
      0.11 ±  8%      -0.0        0.08 ± 20%  perf-profile.children.cycles-pp.proc_pident_instantiate
      0.05 ± 45%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.04 ± 71%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.sprintf
      0.07 ± 16%      -0.0        0.04 ± 76%  perf-profile.children.cycles-pp.set_next_task_idle
      0.23 ± 10%      -0.0        0.21 ± 12%  perf-profile.children.cycles-pp.clockevents_program_event
      0.22 ± 11%      -0.0        0.20 ± 21%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.13 ± 20%      -0.0        0.11 ± 12%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.32 ±  9%      -0.0        0.29 ± 10%  perf-profile.children.cycles-pp.__memcg_kmem_charge
      0.23 ± 18%      -0.0        0.20 ± 11%  perf-profile.children.cycles-pp.__get_free_pages
      0.13 ± 14%      -0.0        0.10 ± 18%  perf-profile.children.cycles-pp.proc_pid_lookup
      0.05 ± 45%      -0.0        0.03 ±102%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.07 ± 26%      -0.0        0.04 ± 72%  perf-profile.children.cycles-pp.sched_fork
      0.06 ±  6%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.proc_alloc_inode
      0.45 ±  8%      -0.0        0.43 ± 14%  perf-profile.children.cycles-pp.link_path_walk
      0.33 ±  8%      -0.0        0.31 ± 12%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.23 ± 11%      -0.0        0.21 ± 10%  perf-profile.children.cycles-pp.pick_next_entity
      0.18 ± 10%      -0.0        0.15 ± 12%  perf-profile.children.cycles-pp.remove_wait_queue
      0.06 ±  6%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.send_signal
      0.10 ±  7%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.copy_fpregs_to_fpstate
      0.17 ±  7%      -0.0        0.15 ± 13%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.37 ±  7%      -0.0        0.35 ±  9%  perf-profile.children.cycles-pp.___slab_alloc
      0.40 ±  5%      -0.0        0.37 ±  9%  perf-profile.children.cycles-pp.__switch_to_asm
      0.13 ± 14%      -0.0        0.11 ± 18%  perf-profile.children.cycles-pp.proc_root_lookup
      0.10 ±  9%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.rb_erase
      0.10 ± 13%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.alloc_empty_file
      0.09 ± 11%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.__alloc_file
      0.03 ±100%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.inode_init_always
      0.05 ± 47%      -0.0        0.03 ± 99%  perf-profile.children.cycles-pp.__d_alloc
      0.07 ± 11%      -0.0        0.05 ± 45%  perf-profile.children.cycles-pp.proc_self_get_link
      0.10 ± 12%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.__dentry_kill
      1.05 ±  4%      -0.0        1.03 ±  7%  perf-profile.children.cycles-pp.vm_area_dup
      0.38 ±  7%      -0.0        0.35 ±  9%  perf-profile.children.cycles-pp.__slab_alloc
      0.33 ±  8%      -0.0        0.31 ±  8%  perf-profile.children.cycles-pp.unlock_page
      0.15 ± 11%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.d_invalidate
      0.14 ± 10%      -0.0        0.12 ±  9%  perf-profile.children.cycles-pp.shrink_dcache_parent
      0.07 ±  8%      -0.0        0.05 ± 46%  perf-profile.children.cycles-pp.group_send_sig_info
      0.04 ± 72%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.cgroup_post_fork
      0.02 ±144%      -0.0        0.00        perf-profile.children.cycles-pp.__unlock_page_memcg
      0.04 ± 45%      -0.0        0.03 ± 99%  perf-profile.children.cycles-pp.sync_mm_rss
      0.23 ±  4%      -0.0        0.21 ±  7%  perf-profile.children.cycles-pp.rmqueue
      0.42 ±  8%      -0.0        0.40 ± 10%  perf-profile.children.cycles-pp.resched_curr
      0.31 ±  7%      -0.0        0.29 ± 10%  perf-profile.children.cycles-pp.allocate_slab
      0.15 ±  8%      -0.0        0.13 ± 14%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.16 ±  9%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.menu_reflect
      0.10 ± 23%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.timerqueue_del
      0.16 ±  8%      -0.0        0.14 ± 17%  perf-profile.children.cycles-pp.perf_event_task
      0.12 ± 11%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.step_into
      0.04 ± 71%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.d_splice_alias
      0.06 ± 46%      -0.0        0.05 ± 45%  perf-profile.children.cycles-pp.rcu_needs_cpu
      0.07 ± 11%      -0.0        0.05 ± 72%  perf-profile.children.cycles-pp.timerqueue_add
      0.03 ±100%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.vsnprintf
      0.04 ± 71%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.__get_user_8
      0.11 ±  6%      -0.0        0.09 ± 12%  perf-profile.children.cycles-pp.perf_event_task_output
      0.04 ± 71%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.evict
      0.59 ±  8%      -0.0        0.57 ±  5%  perf-profile.children.cycles-pp.pte_alloc_one
      0.40 ±  8%      -0.0        0.38 ± 16%  perf-profile.children.cycles-pp.walk_component
      0.35 ±  4%      -0.0        0.33 ±  5%  perf-profile.children.cycles-pp.wake_up_new_task
      0.09 ± 14%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.pick_link
      0.73 ±  3%      -0.0        0.71 ±  7%  perf-profile.children.cycles-pp.wp_page_copy
      0.54 ±  5%      -0.0        0.52 ±  6%  perf-profile.children.cycles-pp.__pte_alloc
      0.13 ± 22%      -0.0        0.11 ± 10%  perf-profile.children.cycles-pp.mm_init
      0.12 ± 24%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.pgd_alloc
      0.08 ± 15%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.proc_pid_instantiate
      0.03 ± 99%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.security_task_kill
      0.04 ± 45%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp.__d_lookup_rcu
      0.34 ±  6%      -0.0        0.32 ±  9%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.24 ±  7%      -0.0        0.23 ±  5%  perf-profile.children.cycles-pp.perf_tp_event
      0.05 ± 99%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.PageHuge
      0.04 ± 45%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.put_files_struct
      0.11 ± 16%      -0.0        0.10 ± 18%  perf-profile.children.cycles-pp.__pagevec_lru_add
      0.09 ± 14%      -0.0        0.07 ± 18%  perf-profile.children.cycles-pp.exit_mm_release
      0.05 ± 91%      -0.0        0.04 ± 73%  perf-profile.children.cycles-pp.getname_flags
      0.10 ± 14%      -0.0        0.09 ± 15%  perf-profile.children.cycles-pp.shrink_dentry_list
      0.19 ± 20%      -0.0        0.18 ±  5%  perf-profile.children.cycles-pp.rebalance_domains
      0.31 ± 11%      -0.0        0.30 ± 11%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.28 ± 10%      -0.0        0.27 ± 12%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.14 ± 22%      -0.0        0.13 ± 18%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.10 ± 15%      -0.0        0.08 ± 14%  perf-profile.children.cycles-pp.lru_add_drain
      0.21 ± 11%      -0.0        0.19 ± 13%  perf-profile.children.cycles-pp.proc_invalidate_siblings_dcache
      0.15 ± 12%      -0.0        0.13 ± 19%  perf-profile.children.cycles-pp.free_unref_page_list
      0.08 ± 10%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.09 ± 15%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.03 ±102%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.03 ±101%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.native_apic_mem_write
      0.08 ± 13%      -0.0        0.07 ± 15%  perf-profile.children.cycles-pp.futex_exit_release
      0.09 ± 18%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.call_cpuidle
      0.92 ± 12%      -0.0        0.90 ±  4%  perf-profile.children.cycles-pp.tick_sched_timer
      0.18 ± 14%      -0.0        0.17 ± 25%  perf-profile.children.cycles-pp.__lookup_slow
      0.07 ± 19%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.11 ± 19%      -0.0        0.10 ± 12%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.09 ± 14%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.08 ± 16%      -0.0        0.07 ± 52%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.02 ±223%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.strncpy_from_user
      0.06 ± 45%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.filp_close
      0.23 ±  4%      -0.0        0.22 ±  8%  perf-profile.children.cycles-pp.find_idlest_group
      0.10 ±  7%      -0.0        0.09 ± 29%  perf-profile.children.cycles-pp.memcpy_erms
      0.07 ± 12%      -0.0        0.06 ± 19%  perf-profile.children.cycles-pp.perf_event_fork
      0.09 ±  9%      -0.0        0.08 ± 14%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.09 ± 11%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.__tlb_remove_page_size
      0.78 ±  5%      -0.0        0.77 ±  5%  perf-profile.children.cycles-pp.do_exit
      0.23 ±  6%      -0.0        0.22 ± 11%  perf-profile.children.cycles-pp.kill_pid_info
      0.13 ±  9%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__pmd_alloc
      0.47 ±  4%      -0.0        0.46 ±  7%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.32 ± 11%      -0.0        0.30 ± 11%  perf-profile.children.cycles-pp.serial8250_console_write
      0.31 ± 11%      -0.0        0.30 ± 12%  perf-profile.children.cycles-pp.uart_console_write
      0.31 ± 11%      -0.0        0.30 ± 11%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.21 ± 12%      -0.0        0.20 ±  4%  perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.14 ±  9%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.lock_page_memcg
      0.03 ±100%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.page_add_new_anon_rmap
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.vma_dup_policy
      0.02 ±142%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.mem_cgroup_from_task
      0.02 ±142%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.alloc_pages_current
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.sysvec_call_function_single
      0.05 ± 45%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.__free_pages_ok
      0.26 ±  6%      -0.0        0.25 ±  9%  perf-profile.children.cycles-pp.__x64_sys_kill
      0.16 ±  4%      -0.0        0.15 ±  7%  perf-profile.children.cycles-pp.child_wait_callback
      0.94 ±  6%      -0.0        0.94 ±  7%  perf-profile.children.cycles-pp.update_rq_clock
      0.78 ±  5%      -0.0        0.77 ±  5%  perf-profile.children.cycles-pp.do_group_exit
      0.46 ±  5%      -0.0        0.46 ±  7%  perf-profile.children.cycles-pp.check_preempt_curr
      0.36 ±  6%      -0.0        0.35 ±  7%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.24 ±  6%      -0.0        0.23 ± 13%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.07 ± 18%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.07 ± 11%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.futex_cleanup
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.idle_cpu
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.apparmor_task_kill
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.d_walk
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.asm_common_interrupt
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.common_interrupt
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.setup_object_debug
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.get_random_u32
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__napi_poll
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.do_task_dead
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.net_rx_action
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.igb_poll
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.cpumask_any_but
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.execve
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_execve
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.do_execveat_common
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.do_wp_page
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.inode_permission
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.from_kuid_munged
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.free_unref_page
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.force_sig_fault
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.force_sig_info_to_task
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.cpuidle_get_cpu_driver
      0.24 ±  7%      -0.0        0.24 ± 10%  perf-profile.children.cycles-pp.kill_something_info
      0.24 ±  8%      -0.0        0.23 ±  5%  perf-profile.children.cycles-pp.__x86_retpoline_rax
      0.15 ± 11%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.rcu_eqs_exit
      0.13 ±  9%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.available_idle_cpu
      0.08 ± 13%      -0.0        0.07 ± 18%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.06 ± 11%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.05 ± 45%      -0.0        0.04 ± 72%  perf-profile.children.cycles-pp.__hrtimer_get_next_event
      0.11 ± 13%      -0.0        0.11 ± 11%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.19 ±  7%      -0.0        0.19 ±  7%  perf-profile.children.cycles-pp.copy_page
      0.63 ±  9%      -0.0        0.62 ± 11%  perf-profile.children.cycles-pp.dup_task_struct
      0.27 ±  6%      -0.0        0.27 ±  9%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.25 ±  5%      -0.0        0.25 ±  6%  perf-profile.children.cycles-pp.__put_user_nocheck_4
      0.24 ± 10%      -0.0        0.23 ±  8%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.07 ± 12%      -0.0        0.07 ± 18%  perf-profile.children.cycles-pp.__bad_area_nosemaphore
      0.12 ± 10%      -0.0        0.11 ± 12%  perf-profile.children.cycles-pp.cpus_share_cache
      0.08 ± 11%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.07 ± 11%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.arch_dup_task_struct
      0.06 ± 11%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.07 ± 20%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.04 ± 71%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_exit
      0.04 ± 45%      -0.0        0.04 ± 72%  perf-profile.children.cycles-pp.can_stop_idle_tick
      0.14 ± 14%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.load_balance
      0.17 ± 10%      -0.0        0.16 ± 13%  perf-profile.children.cycles-pp.__cond_resched
      0.25 ±  8%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.16 ±  8%      -0.0        0.15 ±  6%  perf-profile.children.cycles-pp.alloc_pages_vma
      0.08 ±  8%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.05 ± 46%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.__queue_work
      0.06 ±  8%      -0.0        0.05 ± 52%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.11 ±  7%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.put_task_stack
      0.09 ± 21%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.flush_tlb_func_common
      0.12 ± 10%      -0.0        0.11 ± 18%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.18 ± 17%      -0.0        0.18 ±  7%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.72 ±  3%      -0.0        0.72 ±  8%  perf-profile.children.cycles-pp.update_curr
      0.32 ± 11%      -0.0        0.32 ±  9%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.32 ± 11%      -0.0        0.32 ±  9%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.32 ± 11%      -0.0        0.32 ±  9%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.32 ± 11%      -0.0        0.32 ±  9%  perf-profile.children.cycles-pp.irq_work_run
      0.32 ± 11%      -0.0        0.32 ±  9%  perf-profile.children.cycles-pp.irq_work_single
      0.32 ± 11%      -0.0        0.32 ±  9%  perf-profile.children.cycles-pp.printk
      0.32 ± 11%      -0.0        0.32 ±  9%  perf-profile.children.cycles-pp.vprintk_emit
      0.32 ± 11%      -0.0        0.32 ±  9%  perf-profile.children.cycles-pp.console_unlock
      0.33 ± 11%      -0.0        0.33 ±  9%  perf-profile.children.cycles-pp.irq_work_run_list
      0.06 ± 19%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.ptrace_traceme
      0.06 ± 11%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.dup_fd
      0.23 ±  8%      -0.0        0.23 ±  6%  perf-profile.children.cycles-pp.reweight_entity
      0.16 ±  6%      -0.0        0.16 ± 11%  perf-profile.children.cycles-pp.__perf_sw_event
      0.14 ±  8%      -0.0        0.14 ± 15%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.14 ±  7%      -0.0        0.14 ±  7%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.07 ± 18%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.vmacache_find
      0.06 ± 11%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.__might_fault
      0.82 ± 12%      -0.0        0.82 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.28 ±  6%      -0.0        0.28 ± 14%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.47 ± 18%      -0.0        0.47 ±  7%  perf-profile.children.cycles-pp.scheduler_tick
      0.35 ±  5%      -0.0        0.35 ±  6%  perf-profile.children.cycles-pp.schedule_tail
      0.24 ±  6%      -0.0        0.24 ±  7%  perf-profile.children.cycles-pp.__put_anon_vma
      0.21 ±  8%      -0.0        0.21 ±  8%  perf-profile.children.cycles-pp.find_get_task_by_vpid
      0.10 ± 18%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.find_busiest_group
      0.09 ± 11%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.task_work_run
      0.05 ± 46%      -0.0        0.05 ± 48%  perf-profile.children.cycles-pp.irqentry_enter
      0.02 ±142%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.unlock_page_memcg
      0.02 ±144%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge_page
      0.01 ±223%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.lru_cache_add
      0.08 ± 23%      -0.0        0.08 ± 11%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.10 ± 22%      -0.0        0.10 ± 22%  perf-profile.children.cycles-pp.xas_find
      0.09 ± 11%      -0.0        0.09 ± 47%  perf-profile.children.cycles-pp.d_alloc
      0.79 ± 13%      -0.0        0.79 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.35 ±  5%      -0.0        0.35 ±  6%  perf-profile.children.cycles-pp.read_tsc
      0.16 ±  8%      -0.0        0.15 ± 13%  perf-profile.children.cycles-pp.do_send_sig_info
      0.09 ± 21%      -0.0        0.09 ± 24%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.12 ± 12%      -0.0        0.12 ± 14%  perf-profile.children.cycles-pp.__calc_delta
      0.11 ± 10%      +0.0        0.11 ± 36%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.07 ± 27%      +0.0        0.07 ± 18%  perf-profile.children.cycles-pp.xas_load
      0.05 ± 46%      +0.0        0.05 ± 46%  perf-profile.children.cycles-pp.sync_regs
      0.02 ±141%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.irqentry_exit
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.kfree
      0.10 ± 14%      +0.0        0.10 ± 19%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.09 ± 15%      +0.0        0.09 ± 11%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.29 ± 10%      +0.0        0.29 ±  5%  perf-profile.children.cycles-pp.wait_task_inactive
      0.11 ± 21%      +0.0        0.11 ± 18%  perf-profile.children.cycles-pp.lookup_fast
      0.10 ±  9%      +0.0        0.10 ± 14%  perf-profile.children.cycles-pp.sched_move_task
      0.07 ± 10%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.exit_mmap
      0.07 ± 15%      +0.0        0.08 ± 12%  perf-profile.children.cycles-pp.put_pid
      0.06 ±  9%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.oom_score_adj_write
      0.03 ± 99%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.__vma_link_rb
      0.03 ±100%      +0.0        0.03 ±101%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.05 ± 46%      +0.0        0.05 ±  7%  perf-profile.children.cycles-pp.queue_work_on
      0.14 ±  4%      +0.0        0.14 ±  8%  perf-profile.children.cycles-pp.ksys_write
      0.13 ±  7%      +0.0        0.13 ± 11%  perf-profile.children.cycles-pp.vfs_write
      0.09 ± 13%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.rb_next
      0.07 ± 12%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.36 ±  3%      +0.0        0.36 ±  6%  perf-profile.children.cycles-pp.___might_sleep
      0.30 ±  5%      +0.0        0.30 ± 11%  perf-profile.children.cycles-pp.__send_signal
      0.21 ± 11%      +0.0        0.22 ±  4%  perf-profile.children.cycles-pp.place_entity
      0.09 ± 23%      +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.05 ± 47%      +0.0        0.06 ± 48%  perf-profile.children.cycles-pp.__x64_sys_prlimit64
      0.07 ± 19%      +0.0        0.07 ± 10%  perf-profile.children.cycles-pp.__fput
      0.07 ± 12%      +0.0        0.08 ± 17%  perf-profile.children.cycles-pp.mark_page_accessed
      0.06 ±  8%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.unmap_single_vma
      0.13 ± 16%      +0.0        0.14 ± 13%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.15 ±  9%      +0.0        0.15 ± 14%  perf-profile.children.cycles-pp.prepare_signal
      0.58 ±  3%      +0.0        0.58 ±  6%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.10 ± 12%      +0.0        0.10 ± 20%  perf-profile.children.cycles-pp.delay_tsc
      0.10 ± 10%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.11 ± 11%      +0.0        0.12 ± 11%  perf-profile.children.cycles-pp.vma_gap_callbacks_rotate
      0.08 ± 13%      +0.0        0.09 ± 17%  perf-profile.children.cycles-pp.rcu_all_qs
      0.03 ± 70%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.do_dentry_open
      0.05 ± 47%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.copy_creds
      0.04 ± 73%      +0.0        0.05 ± 47%  perf-profile.children.cycles-pp.prepare_creds
      0.02 ±141%      +0.0        0.02 ±146%  perf-profile.children.cycles-pp.__x64_sys_setpgid
      0.48 ±  5%      +0.0        0.49 ±  5%  perf-profile.children.cycles-pp.native_sched_clock
      0.27 ±  4%      +0.0        0.28 ±  4%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.14 ±  5%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.07 ± 14%      +0.0        0.08 ± 16%  perf-profile.children.cycles-pp.update_min_vruntime
      0.07 ± 16%      +0.0        0.07 ± 12%  perf-profile.children.cycles-pp.__mmdrop
      0.04 ± 73%      +0.0        0.05 ± 73%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.18 ± 13%      +0.0        0.18 ±  8%  perf-profile.children.cycles-pp.newidle_balance
      0.10 ± 14%      +0.0        0.10 ± 15%  perf-profile.children.cycles-pp.switch_fpu_return
      0.09 ± 11%      +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.free_vmap_area_noflush
      0.08 ± 12%      +0.0        0.08 ± 13%  perf-profile.children.cycles-pp.__list_add_valid
      0.11 ± 20%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp.ptep_clear_flush
      0.04 ± 73%      +0.0        0.04 ± 45%  perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.11 ± 10%      +0.0        0.12 ± 15%  perf-profile.children.cycles-pp.free_pgd_range
      0.02 ±142%      +0.0        0.03 ± 99%  perf-profile.children.cycles-pp.rb_insert_color
      0.23 ±  6%      +0.0        0.24 ±  5%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.11 ± 11%      +0.0        0.11 ± 14%  perf-profile.children.cycles-pp.mmput
      0.10 ±  9%      +0.0        0.11 ± 14%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.08 ±  8%      +0.0        0.09 ± 18%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.08 ±  8%      +0.0        0.09 ± 15%  perf-profile.children.cycles-pp.complete_signal
      0.11 ± 20%      +0.0        0.12 ± 17%  perf-profile.children.cycles-pp.__pud_alloc
      0.08 ± 34%      +0.0        0.09 ± 20%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
      0.38 ±  7%      +0.0        0.39 ±  9%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.41 ±  5%      +0.0        0.41 ±  5%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.26 ±  6%      +0.0        0.27 ± 13%  perf-profile.children.cycles-pp.update_cfs_group
      0.21 ± 13%      +0.0        0.22 ± 24%  perf-profile.children.cycles-pp.io_serial_in
      0.21 ±  7%      +0.0        0.22 ±  7%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.22 ±  7%      +0.0        0.23 ±  6%  perf-profile.children.cycles-pp.task_rq_lock
      0.21 ± 10%      +0.0        0.22 ±  5%  perf-profile.children.cycles-pp.free_work
      0.15 ±  9%      +0.0        0.16 ±  8%  perf-profile.children.cycles-pp.get_cpu_device
      0.13 ± 10%      +0.0        0.14 ±  9%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.13 ± 17%      +0.0        0.14 ± 14%  perf-profile.children.cycles-pp.find_get_pid
      0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.up_read
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.add_device_randomness
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.__sigqueue_alloc
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.rcu_nmi_enter
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.__count_memcg_events
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.call_rcu
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.drm_fb_helper_sys_imageblit
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.sys_imageblit
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp._raw_write_lock_irq
      0.30 ±  6%      +0.0        0.31 ± 10%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.27 ±  8%      +0.0        0.28 ±  6%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.14 ±  4%      +0.0        0.15 ±  6%  perf-profile.children.cycles-pp.__might_sleep
      0.09 ± 10%      +0.0        0.10 ± 21%  perf-profile.children.cycles-pp.dput
      0.07 ± 11%      +0.0        0.08 ± 14%  perf-profile.children.cycles-pp.signal_wake_up_state
      0.05 ± 45%      +0.0        0.06 ± 50%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_enter
      0.02 ±142%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.free_ldt_pgtables
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.task_change_group_fair
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.vt_console_print
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.lf
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.con_scroll
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.fbcon_scroll
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.fbcon_redraw
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.fbcon_putcs
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.bit_putcs
      0.05 ± 47%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.idr_find
      0.17 ± 16%      +0.0        0.18 ± 10%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.12 ± 10%      +0.0        0.14 ± 17%  perf-profile.children.cycles-pp.update_blocked_averages
      0.09 ±  8%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.do_open
      0.06 ±  7%      +0.0        0.07 ± 18%  perf-profile.children.cycles-pp.cgroup_enter_frozen
      2.20 ±  4%      +0.0        2.21 ±  5%  perf-profile.children.cycles-pp.arch_ptrace
      0.37 ±  4%      +0.0        0.38 ±  8%  perf-profile.children.cycles-pp.wait_consider_task
      0.21 ±  8%      +0.0        0.22 ±  7%  perf-profile.children.cycles-pp.__vunmap
      0.05 ± 45%      +0.0        0.06 ± 19%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.tick_nohz_idle_got_tick
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.__legitimize_path
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.try_to_unlazy
      0.10 ± 10%      +0.0        0.11 ± 10%  perf-profile.children.cycles-pp.do_notify_parent
      0.12 ± 10%      +0.0        0.13 ±  8%  perf-profile.children.cycles-pp.remove_vm_area
      2.20 ±  4%      +0.0        2.21 ±  5%  perf-profile.children.cycles-pp.ptrace_request
      2.18 ±  4%      +0.0        2.20 ±  5%  perf-profile.children.cycles-pp.ptrace_resume
      0.30 ±  5%      +0.0        0.32 ±  8%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.05 ± 48%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.user_disable_single_step
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.osq_lock
      0.12 ± 10%      +0.0        0.14 ± 19%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.06 ±  9%      +0.0        0.07 ± 24%  perf-profile.children.cycles-pp.cpuacct_charge
      0.10 ± 15%      +0.0        0.12 ± 14%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge
      0.01 ±223%      +0.0        0.03 ± 99%  perf-profile.children.cycles-pp.do_prlimit
      0.50 ±  4%      +0.0        0.51 ±  5%  perf-profile.children.cycles-pp.sched_clock
      1.94 ±  8%      +0.0        1.95 ± 10%  perf-profile.children.cycles-pp.copy_page_range
      1.14 ±  5%      +0.0        1.16 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock
      0.54 ±  2%      +0.0        0.55 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.19 ± 11%      +0.0        0.21 ±  9%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.00            +0.0        0.02 ±141%  perf-profile.children.cycles-pp.__put_task_struct
      0.01 ±223%      +0.0        0.03 ± 99%  perf-profile.children.cycles-pp.intel_pmu_disable_all
      0.74 ±  9%      +0.0        0.76 ±  3%  perf-profile.children.cycles-pp.irq_exit_rcu
      1.52 ±  9%      +0.0        1.54 ± 11%  perf-profile.children.cycles-pp.copy_pte_range
      0.06 ± 11%      +0.0        0.08 ± 16%  perf-profile.children.cycles-pp.put_prev_entity
      0.06 ± 13%      +0.0        0.07 ± 16%  perf-profile.children.cycles-pp.alloc_pid
      0.04 ± 71%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.02 ±141%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.trigger_load_balance
      0.02 ±141%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.___pte_free_tlb
      0.13 ± 10%      +0.0        0.15 ±  8%  perf-profile.children.cycles-pp.find_task_by_vpid
      0.01 ±223%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.note_gp_changes
      0.00            +0.0        0.02 ±144%  perf-profile.children.cycles-pp.uncharge_batch
      0.04 ± 71%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp._find_next_bit
      0.38 ±  6%      +0.0        0.40 ± 10%  perf-profile.children.cycles-pp.wait_task_zombie
      0.05 ± 45%      +0.0        0.07 ± 16%  perf-profile.children.cycles-pp.perf_swevent_get_recursion_context
      0.03 ±100%      +0.0        0.05 ± 46%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.09 ± 14%      +0.0        0.11 ± 12%  perf-profile.children.cycles-pp.fput_many
      0.05 ± 47%      +0.0        0.07 ± 24%  perf-profile.children.cycles-pp.add_wait_queue
      0.08 ± 14%      +0.0        0.10 ± 25%  perf-profile.children.cycles-pp.userfaultfd_unmap_prep
      0.27 ±  7%      +0.0        0.29 ±  5%  perf-profile.children.cycles-pp.find_vma
      0.18 ± 18%      +0.0        0.21 ± 23%  perf-profile.children.cycles-pp.memcpy_toio
      0.13 ± 12%      +0.0        0.15 ± 15%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.05 ± 48%      +0.0        0.07 ± 21%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.00            +0.0        0.03 ± 99%  perf-profile.children.cycles-pp.cpuidle_reflect
      0.00            +0.0        0.03 ± 99%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.12 ± 11%      +0.0        0.15 ± 17%  perf-profile.children.cycles-pp.page_counter_cancel
      0.40 ± 12%      +0.0        0.43 ± 14%  perf-profile.children.cycles-pp.__vmalloc_node_range
      0.00            +0.0        0.03 ±223%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.22 ±  5%      +0.0        0.25 ±  8%  perf-profile.children.cycles-pp.rcu_do_batch
      0.00            +0.0        0.03 ±223%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.35 ±  6%      +0.0        0.38 ± 13%  perf-profile.children.cycles-pp.release_task
      0.21 ± 18%      +0.0        0.24 ± 21%  perf-profile.children.cycles-pp.alloc_vmap_area
      0.25 ± 12%      +0.0        0.28 ±  3%  perf-profile.children.cycles-pp.queued_read_lock_slowpath
      0.23 ± 16%      +0.0        0.26 ± 21%  perf-profile.children.cycles-pp.__get_vm_area_node
      0.19 ± 18%      +0.0        0.22 ± 17%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.19 ± 18%      +0.0        0.22 ± 17%  perf-profile.children.cycles-pp.commit_tail
      0.19 ± 18%      +0.0        0.22 ± 17%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail
      0.18 ± 18%      +0.0        0.21 ± 18%  perf-profile.children.cycles-pp.drm_fb_memcpy_dstclip
      0.09 ± 18%      +0.0        0.12 ± 11%  perf-profile.children.cycles-pp.__vma_rb_erase
      0.04 ± 75%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.vma_interval_tree_insert_after
      0.19 ± 18%      +0.0        0.22 ± 16%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.19 ± 18%      +0.0        0.22 ± 17%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.19 ± 18%      +0.0        0.22 ± 17%  perf-profile.children.cycles-pp.mgag200_simple_display_pipe_update
      0.19 ± 18%      +0.0        0.22 ± 17%  perf-profile.children.cycles-pp.mgag200_handle_damage
      0.28 ±  3%      +0.0        0.31 ±  8%  perf-profile.children.cycles-pp.rcu_core
      0.68 ±  7%      +0.0        0.71 ±  4%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.20 ± 16%      +0.0        0.24 ± 16%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.01 ±223%      +0.0        0.05        perf-profile.children.cycles-pp.find_vmap_area
      0.14 ±  4%      +0.0        0.18 ± 15%  perf-profile.children.cycles-pp.drain_obj_stock
      0.59 ±  5%      +0.0        0.64 ±  6%  perf-profile.children.cycles-pp.kthread
      0.62 ±  9%      +0.0        0.66 ±  5%  perf-profile.children.cycles-pp.remove_vma
      0.50 ±  5%      +0.0        0.54 ±  7%  perf-profile.children.cycles-pp.worker_thread
      0.17 ±  4%      +0.0        0.22 ±  6%  perf-profile.children.cycles-pp.cgroup_leave_frozen
      0.44 ±  7%      +0.0        0.49 ±  8%  perf-profile.children.cycles-pp.process_one_work
      0.50 ±  3%      +0.0        0.55 ±  8%  perf-profile.children.cycles-pp.up_write
      0.84 ±  4%      +0.1        0.89 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.19 ± 12%      +0.1        0.24 ±  9%  perf-profile.children.cycles-pp.__rb_erase_color
      0.96 ±  2%      +0.1        1.02 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
      0.00            +0.1        0.06 ± 55%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      3.00 ±  6%      +0.1        3.06 ±  9%  perf-profile.children.cycles-pp.unmap_page_range
      3.58 ±  2%      +0.1        3.65 ±  6%  perf-profile.children.cycles-pp.kernel_wait4
      0.29 ±  5%      +0.1        0.35 ± 10%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.24 ± 24%      +0.1        0.30 ± 20%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      2.77 ±  7%      +0.1        2.84 ±  9%  perf-profile.children.cycles-pp.zap_pte_range
      3.08 ±  6%      +0.1        3.15 ±  8%  perf-profile.children.cycles-pp.unmap_vmas
      3.29            +0.1        3.37 ±  7%  perf-profile.children.cycles-pp.do_wait
      0.27 ±  6%      +0.1        0.34 ± 10%  perf-profile.children.cycles-pp.refill_obj_stock
      0.47 ±  7%      +0.1        0.55 ±  7%  perf-profile.children.cycles-pp.__slab_free
      0.16 ±  6%      +0.1        0.24 ± 15%  perf-profile.children.cycles-pp._raw_read_lock
      0.85 ±  5%      +0.1        0.93 ±  6%  perf-profile.children.cycles-pp.release_pages
      0.42 ±  8%      +0.1        0.49 ±  5%  perf-profile.children.cycles-pp.ptrace_check_attach
      3.62 ±  2%      +0.1        3.70 ±  6%  perf-profile.children.cycles-pp.__do_sys_wait4
      5.71 ±  3%      +0.1        5.80 ±  4%  perf-profile.children.cycles-pp.asm_exc_page_fault
      2.97 ±  4%      +0.1        3.05 ±  4%  perf-profile.children.cycles-pp.__x64_sys_ptrace
      0.94 ± 40%      +0.1        1.05 ± 37%  perf-profile.children.cycles-pp.start_kernel
      0.01 ±223%      +0.1        0.13 ± 43%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.45 ±  4%      +0.1        0.58 ±  9%  perf-profile.children.cycles-pp.down_write
      0.24 ± 12%      +0.1        0.38 ±  7%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      1.19 ±  3%      +0.1        1.34 ±  3%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.31 ±  4%      +0.2        0.46 ± 11%  perf-profile.children.cycles-pp.anon_vma_interval_tree_remove
      4.32 ±  4%      +0.2        4.47 ±  5%  perf-profile.children.cycles-pp.exc_page_fault
      3.65 ±  4%      +0.2        3.80 ±  5%  perf-profile.children.cycles-pp.handle_mm_fault
      1.17 ±  3%      +0.2        1.32 ±  3%  perf-profile.children.cycles-pp.tlb_flush_mmu
      3.49 ±  4%      +0.2        3.65 ±  5%  perf-profile.children.cycles-pp.__handle_mm_fault
      2.51 ±  5%      +0.2        2.66 ±  6%  perf-profile.children.cycles-pp.do_fault
      4.25 ±  4%      +0.2        4.41 ±  5%  perf-profile.children.cycles-pp.do_user_addr_fault
      2.40 ±  5%      +0.2        2.56 ±  5%  perf-profile.children.cycles-pp.filemap_map_pages
      1.53 ±  4%      +0.2        1.71 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free
      0.32 ±  5%      +0.2        0.51 ± 12%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.46 ±  9%      +0.2        0.67 ±  5%  perf-profile.children.cycles-pp.unlink_file_vma
      1.10 ±  4%      +0.2        1.32 ±  7%  perf-profile.children.cycles-pp.next_uptodate_page
      1.21 ±  3%      +0.4        1.57 ±  9%  perf-profile.children.cycles-pp.anon_vma_clone
      1.84 ±  3%      +0.4        2.22 ±  7%  perf-profile.children.cycles-pp.anon_vma_fork
      1.53 ±  3%      +0.4        1.92 ±  6%  perf-profile.children.cycles-pp.unlink_anon_vmas
      7.62 ±  4%      +0.4        8.03 ±  6%  perf-profile.children.cycles-pp.__do_sys_clone
      7.62 ±  4%      +0.4        8.03 ±  6%  perf-profile.children.cycles-pp.kernel_clone
      7.25 ±  4%      +0.4        7.68 ±  6%  perf-profile.children.cycles-pp.copy_process
      5.98 ±  4%      +0.5        6.43 ±  6%  perf-profile.children.cycles-pp.dup_mm
      5.83 ±  4%      +0.5        6.30 ±  6%  perf-profile.children.cycles-pp.dup_mmap
      2.26 ±  4%      +0.6        2.86 ±  5%  perf-profile.children.cycles-pp.free_pgtables
      8.06            +0.7        8.74 ±  7%  perf-profile.children.cycles-pp.poll_idle
      6.58 ±  4%      +0.8        7.39 ±  4%  perf-profile.children.cycles-pp.unmap_region
      7.65 ±  4%      +1.0        8.63 ±  4%  perf-profile.children.cycles-pp.__x64_sys_munmap
      7.63 ±  4%      +1.0        8.62 ±  4%  perf-profile.children.cycles-pp.__vm_munmap
      7.57 ±  4%      +1.0        8.56 ±  4%  perf-profile.children.cycles-pp.__do_munmap
     31.35 ±  2%      +1.1       32.48 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     26.52 ±  2%      +1.3       27.86 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     39.32 ±  2%      -0.9       38.38 ±  3%  perf-profile.self.cycles-pp.intel_idle
      0.90 ±  6%      -0.2        0.71 ±  5%  perf-profile.self.cycles-pp.__entry_text_start
      0.63 ± 13%      -0.1        0.54 ±  9%  perf-profile.self.cycles-pp.page_remove_rmap
      1.07 ±  5%      -0.1        0.99 ±  4%  perf-profile.self.cycles-pp.menu_select
      1.20 ±  4%      -0.1        1.12 ±  5%  perf-profile.self.cycles-pp.__schedule
      1.29 ±  4%      -0.1        1.23 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.82 ±  5%      -0.1        0.77 ±  5%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.03 ±  4%      -0.1        0.97 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.44 ±  3%      -0.0        0.39 ± 10%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.31 ±  9%      -0.0        0.26 ± 18%  perf-profile.self.cycles-pp.page_add_file_rmap
      0.06 ± 13%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.__update_idle_core
      0.29 ±  9%      -0.0        0.24 ±  6%  perf-profile.self.cycles-pp.try_to_wake_up
      0.73 ±  2%      -0.0        0.69 ±  8%  perf-profile.self.cycles-pp.update_load_avg
      0.43 ±  6%      -0.0        0.39 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.18 ± 41%      -0.0        0.14 ± 52%  perf-profile.self.cycles-pp.vm_normal_page
      0.05 ±  9%      -0.0        0.02 ±144%  perf-profile.self.cycles-pp.copy_process
      0.49 ± 10%      -0.0        0.46 ±  9%  perf-profile.self.cycles-pp.clear_page_erms
      0.47 ±  3%      -0.0        0.44 ±  7%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.29 ± 10%      -0.0        0.26 ±  8%  perf-profile.self.cycles-pp.___perf_sw_event
      0.32 ±  8%      -0.0        0.28 ± 10%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.03 ±101%      -0.0        0.00        perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.16 ±  8%      -0.0        0.13 ±  9%  perf-profile.self.cycles-pp.finish_task_switch
      0.46 ± 10%      -0.0        0.43 ±  5%  perf-profile.self.cycles-pp.do_idle
      0.21 ± 15%      -0.0        0.18 ± 15%  perf-profile.self.cycles-pp.ktime_get
      0.05 ± 45%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.04 ± 71%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.sync_mm_rss
      0.12 ± 12%      -0.0        0.10 ± 19%  perf-profile.self.cycles-pp.try_charge
      0.07 ±  6%      -0.0        0.05 ± 46%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
      0.03 ± 99%      -0.0        0.00        perf-profile.self.cycles-pp.__pagevec_lru_add
      0.05 ± 46%      -0.0        0.03 ± 99%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.40 ±  9%      -0.0        0.38 ±  7%  perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
      0.22 ± 11%      -0.0        0.20 ± 10%  perf-profile.self.cycles-pp.pick_next_entity
      0.09 ±  5%      -0.0        0.07 ±  9%  perf-profile.self.cycles-pp.copy_fpregs_to_fpstate
      0.38 ±  7%      -0.0        0.36 ± 10%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.39 ±  5%      -0.0        0.37 ±  9%  perf-profile.self.cycles-pp.__switch_to_asm
      0.05 ± 46%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.17 ±  6%      -0.0        0.15 ± 12%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.50 ±  3%      -0.0        0.48 ±  5%  perf-profile.self.cycles-pp.__switch_to
      0.32 ±  7%      -0.0        0.30 ±  7%  perf-profile.self.cycles-pp.unlock_page
      0.21 ±  9%      -0.0        0.19 ± 10%  perf-profile.self.cycles-pp.dequeue_entity
      0.10 ± 14%      -0.0        0.08 ± 18%  perf-profile.self.cycles-pp.menu_reflect
      0.02 ±144%      -0.0        0.00        perf-profile.self.cycles-pp.__unlock_page_memcg
      0.10 ±  8%      -0.0        0.08 ± 13%  perf-profile.self.cycles-pp.memcpy_erms
      0.20 ±  6%      -0.0        0.19 ± 11%  perf-profile.self.cycles-pp.find_idlest_group
      0.50 ±  6%      -0.0        0.48 ±  8%  perf-profile.self.cycles-pp.enqueue_entity
      0.41 ±  8%      -0.0        0.40 ±  9%  perf-profile.self.cycles-pp.resched_curr
      0.14 ± 12%      -0.0        0.12 ± 11%  perf-profile.self.cycles-pp.schedule
      0.08 ± 20%      -0.0        0.07 ± 52%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.09 ± 13%      -0.0        0.07 ± 16%  perf-profile.self.cycles-pp.find_get_task_by_vpid
      0.10 ± 11%      -0.0        0.08 ± 19%  perf-profile.self.cycles-pp.rb_erase
      0.12 ± 15%      -0.0        0.11 ± 12%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.02 ±141%      -0.0        0.00        perf-profile.self.cycles-pp.__d_lookup_rcu
      0.17 ± 16%      -0.0        0.15 ± 10%  perf-profile.self.cycles-pp.memcpy_toio
      0.34 ±  3%      -0.0        0.33 ±  9%  perf-profile.self.cycles-pp.update_curr
      0.15 ±  8%      -0.0        0.13 ± 10%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.05 ± 46%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.24 ±  7%      -0.0        0.23 ± 11%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.14 ±  6%      -0.0        0.12 ± 11%  perf-profile.self.cycles-pp.__wake_up_common
      0.11 ± 21%      -0.0        0.10 ± 15%  perf-profile.self.cycles-pp.rcu_read_unlock_strict
      0.06 ± 14%      -0.0        0.05 ± 47%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.11 ± 21%      -0.0        0.10 ± 16%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.09 ±  9%      -0.0        0.08 ± 11%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.47 ±  7%      -0.0        0.46 ±  8%  perf-profile.self.cycles-pp.set_next_entity
      0.13 ±  9%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.available_idle_cpu
      0.08 ±  8%      -0.0        0.07 ± 14%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.06 ± 46%      -0.0        0.05 ± 45%  perf-profile.self.cycles-pp.rcu_needs_cpu
      0.17 ±  9%      -0.0        0.16 ±  9%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.14 ± 10%      -0.0        0.13 ± 16%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.08 ± 14%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.09 ± 14%      -0.0        0.07 ± 16%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.06 ±  6%      -0.0        0.05 ± 49%  perf-profile.self.cycles-pp.free_pgd_range
      0.05 ± 51%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.free_pcppages_bulk
      0.02 ±142%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.rb_insert_color
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.mem_cgroup_from_task
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.rebalance_domains
      0.07 ± 16%      -0.0        0.06 ± 48%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.09 ± 14%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.call_cpuidle
      0.06 ± 11%      -0.0        0.05 ± 46%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.19 ±  7%      -0.0        0.19 ±  8%  perf-profile.self.cycles-pp.copy_page
      0.36 ±  6%      -0.0        0.35 ±  7%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.21 ± 13%      -0.0        0.20 ± 13%  perf-profile.self.cycles-pp.io_serial_in
      0.13 ±  8%      -0.0        0.12 ± 10%  perf-profile.self.cycles-pp.lock_page_memcg
      0.10 ± 11%      -0.0        0.09 ± 17%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.04 ± 71%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_exit
      0.04 ± 71%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.idle_cpu
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.sched_clock
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__remove_hrtimer
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.dup_fd
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.cpuidle_get_cpu_driver
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.do_wp_page
      0.24 ± 10%      -0.0        0.23 ±  7%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.15 ±  6%      -0.0        0.15 ±  6%  perf-profile.self.cycles-pp.child_wait_callback
      0.16 ±  8%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.__x86_retpoline_rax
      0.09 ± 11%      -0.0        0.08 ± 13%  perf-profile.self.cycles-pp.rcu_eqs_exit
      0.07 ± 18%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.vmacache_find
      0.07 ± 14%      -0.0        0.06 ± 46%  perf-profile.self.cycles-pp.schedule_idle
      0.68 ±  8%      -0.0        0.67 ±  8%  perf-profile.self.cycles-pp.update_rq_clock
      0.23 ±  6%      -0.0        0.23 ± 12%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.09 ± 11%      -0.0        0.08 ± 14%  perf-profile.self.cycles-pp.__cond_resched
      0.12 ± 10%      -0.0        0.11 ± 12%  perf-profile.self.cycles-pp.cpus_share_cache
      0.06 ± 11%      -0.0        0.06 ± 54%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.17 ±  8%      -0.0        0.16 ± 12%  perf-profile.self.cycles-pp.copy_page_range
      0.12 ± 10%      -0.0        0.11 ± 16%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.06 ± 21%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.06 ± 19%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.rmqueue
      0.26 ±  2%      -0.0        0.25 ±  7%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.16 ±  5%      -0.0        0.16 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.11 ± 13%      -0.0        0.10 ± 13%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.05 ± 45%      -0.0        0.04 ± 73%  perf-profile.self.cycles-pp.check_preempt_curr
      0.07 ± 21%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.put_pid
      0.01 ±223%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.xas_load
      0.13 ±  8%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.08 ± 14%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__alloc_pages_nodemask
      0.33 ±  6%      -0.0        0.33 ±  6%  perf-profile.self.cycles-pp.read_tsc
      0.05 ± 48%      -0.0        0.05 ± 45%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.02 ±144%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
      0.04 ± 71%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.__tlb_remove_page_size
      0.02 ±141%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.native_apic_mem_write
      0.23 ±  8%      -0.0        0.23 ±  6%  perf-profile.self.cycles-pp.reweight_entity
      0.19 ±  7%      -0.0        0.19 ± 10%  perf-profile.self.cycles-pp.allocate_slab
      0.08 ±  9%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.08 ± 16%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.do_syscall_64
      0.07 ±  7%      -0.0        0.06 ± 19%  perf-profile.self.cycles-pp.put_prev_task_fair
      0.12 ± 13%      -0.0        0.11 ± 12%  perf-profile.self.cycles-pp.anon_vma_fork
      0.35 ±  3%      -0.0        0.35 ±  6%  perf-profile.self.cycles-pp.___might_sleep
      0.15 ± 14%      -0.0        0.14 ± 11%  perf-profile.self.cycles-pp.newidle_balance
      0.02 ±142%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.unlock_page_memcg
      0.02 ±144%      -0.0        0.02 ±142%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.08 ± 23%      -0.0        0.08 ± 11%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.07 ± 14%      -0.0        0.07 ± 16%  perf-profile.self.cycles-pp.alloc_vmap_area
      0.08 ± 15%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.11 ± 10%      -0.0        0.11 ± 12%  perf-profile.self.cycles-pp.ptrace_resume
      0.74 ±  4%      +0.0        0.74 ±  5%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.15 ± 14%      +0.0        0.15 ± 15%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.05 ± 45%      +0.0        0.05 ±  8%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.07 ± 15%      +0.0        0.07 ± 21%  perf-profile.self.cycles-pp.mark_page_accessed
      0.02 ±141%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.02 ±141%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.scheduler_tick
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.exc_page_fault
      0.52 ±  3%      +0.0        0.52 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.37 ±  7%      +0.0        0.37 ± 10%  perf-profile.self.cycles-pp.vm_area_dup
      0.20 ± 11%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.place_entity
      0.07 ± 10%      +0.0        0.07 ± 20%  perf-profile.self.cycles-pp.update_min_vruntime
      0.11 ± 14%      +0.0        0.11 ± 10%  perf-profile.self.cycles-pp.__calc_delta
      0.07 ± 14%      +0.0        0.07 ±  9%  perf-profile.self.cycles-pp.rcu_eqs_enter
      0.05 ± 45%      +0.0        0.05 ± 47%  perf-profile.self.cycles-pp.sync_regs
      0.03 ± 99%      +0.0        0.03 ±100%  perf-profile.self.cycles-pp.__vma_link_rb
      0.04 ± 71%      +0.0        0.04 ± 73%  perf-profile.self.cycles-pp.___slab_alloc
      0.04 ± 71%      +0.0        0.04 ± 72%  perf-profile.self.cycles-pp.can_stop_idle_tick
      0.17 ±  7%      +0.0        0.17 ±  6%  perf-profile.self.cycles-pp.perf_tp_event
      0.06 ± 47%      +0.0        0.07 ± 52%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.07 ± 12%      +0.0        0.07 ± 14%  perf-profile.self.cycles-pp.__list_add_valid
      0.04 ± 45%      +0.0        0.05 ± 50%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.05 ± 45%      +0.0        0.06 ± 46%  perf-profile.self.cycles-pp.handle_mm_fault
      0.05 ± 45%      +0.0        0.05 ± 46%  perf-profile.self.cycles-pp.idr_find
      0.06 ± 47%      +0.0        0.07 ± 14%  perf-profile.self.cycles-pp.wait_task_inactive
      0.08 ± 13%      +0.0        0.09 ± 14%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.09 ± 10%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.rb_next
      0.16 ± 10%      +0.0        0.16 ± 12%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.10 ± 12%      +0.0        0.10 ± 20%  perf-profile.self.cycles-pp.delay_tsc
      0.09 ± 14%      +0.0        0.10 ± 12%  perf-profile.self.cycles-pp.switch_fpu_return
      0.11 ± 14%      +0.0        0.12 ±  9%  perf-profile.self.cycles-pp.do_set_pte
      0.06 ±  8%      +0.0        0.06 ± 11%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.02 ±144%      +0.0        0.03 ± 99%  perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.13 ±  5%      +0.0        0.13 ±  8%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.10 ± 10%      +0.0        0.11 ± 13%  perf-profile.self.cycles-pp.vma_gap_callbacks_rotate
      0.05 ± 47%      +0.0        0.05 ± 13%  perf-profile.self.cycles-pp.cpu_startup_entry
      0.14 ± 10%      +0.0        0.15 ± 14%  perf-profile.self.cycles-pp.prepare_signal
      0.26 ±  4%      +0.0        0.27 ±  4%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.03 ± 99%      +0.0        0.03 ± 70%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.15 ±  8%      +0.0        0.15 ±  8%  perf-profile.self.cycles-pp.get_cpu_device
      0.04 ± 45%      +0.0        0.05 ± 46%  perf-profile.self.cycles-pp.put_prev_entity
      0.01 ±223%      +0.0        0.02 ±142%  perf-profile.self.cycles-pp.perf_iterate_sb
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.__send_signal
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.do_notify_parent_cldstop
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.xas_find
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.wp_page_copy
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.unmap_vmas
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.clockevents_program_event
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.find_vmap_area
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.__count_memcg_events
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp._raw_write_lock_irq
      0.03 ±100%      +0.0        0.04 ± 71%  perf-profile.self.cycles-pp.update_process_times
      0.10 ± 15%      +0.0        0.11 ± 11%  perf-profile.self.cycles-pp.rcu_idle_exit
      0.05 ± 45%      +0.0        0.06 ± 50%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_enter
      0.06 ± 50%      +0.0        0.07 ± 14%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.02 ±141%      +0.0        0.03 ±100%  perf-profile.self.cycles-pp.__perf_sw_event
      0.02 ±141%      +0.0        0.03 ±100%  perf-profile.self.cycles-pp.perf_trace_buf_alloc
      0.06 ± 49%      +0.0        0.07 ±  9%  perf-profile.self.cycles-pp.__x64_sys_ptrace
      0.46 ±  6%      +0.0        0.47 ±  6%  perf-profile.self.cycles-pp.native_sched_clock
      0.07 ± 16%      +0.0        0.08 ± 20%  perf-profile.self.cycles-pp.queued_write_lock_slowpath
      0.30 ±  5%      +0.0        0.31 ±  9%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.15 ± 14%      +0.0        0.16 ±  8%  perf-profile.self.cycles-pp.unmap_page_range
      0.06 ±  9%      +0.0        0.07 ± 22%  perf-profile.self.cycles-pp.cpuacct_charge
      0.02 ±141%      +0.0        0.03 ±100%  perf-profile.self.cycles-pp.timerqueue_add
      0.01 ±223%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.ptrace_check_attach
      0.01 ±223%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.tick_nohz_idle_got_tick
      0.05 ± 47%      +0.0        0.06 ± 11%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.17 ± 15%      +0.0        0.18 ±  9%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.18 ± 11%      +0.0        0.19 ± 11%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.05 ± 48%      +0.0        0.07 ± 11%  perf-profile.self.cycles-pp.user_disable_single_step
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.osq_lock
      0.11 ±  6%      +0.0        0.13 ± 10%  perf-profile.self.cycles-pp.__might_sleep
      0.12 ±  7%      +0.0        0.13 ± 13%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.28 ±  6%      +0.0        0.29 ±  3%  perf-profile.self.cycles-pp.filemap_map_pages
      0.25 ±  6%      +0.0        0.27 ± 14%  perf-profile.self.cycles-pp.update_cfs_group
      0.05 ± 47%      +0.0        0.06 ± 13%  perf-profile.self.cycles-pp.rcu_all_qs
      0.03 ±100%      +0.0        0.04 ± 45%  perf-profile.self.cycles-pp.pm_qos_read_value
      0.23 ±  4%      +0.0        0.24 ± 10%  perf-profile.self.cycles-pp.wait_consider_task
      0.00            +0.0        0.02 ±141%  perf-profile.self.cycles-pp.cpuidle_reflect
      0.00            +0.0        0.02 ±141%  perf-profile.self.cycles-pp.up_read
      0.00            +0.0        0.02 ±141%  perf-profile.self.cycles-pp.PageHuge
      0.00            +0.0        0.02 ±141%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.01 ±223%      +0.0        0.03 ± 99%  perf-profile.self.cycles-pp.trigger_load_balance
      0.05 ± 45%      +0.0        0.07 ± 16%  perf-profile.self.cycles-pp.__do_munmap
      0.02 ±142%      +0.0        0.04 ± 71%  perf-profile.self.cycles-pp.remove_vma
      0.18 ±  8%      +0.0        0.20 ±  5%  perf-profile.self.cycles-pp.find_vma
      0.03 ± 99%      +0.0        0.04 ± 45%  perf-profile.self.cycles-pp.__do_sys_wait4
      0.02 ±141%      +0.0        0.04 ± 71%  perf-profile.self.cycles-pp.update_blocked_averages
      0.04 ± 45%      +0.0        0.06 ± 17%  perf-profile.self.cycles-pp.perf_swevent_get_recursion_context
      0.18 ±  8%      +0.0        0.20 ± 13%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.08 ± 13%      +0.0        0.10 ± 14%  perf-profile.self.cycles-pp.fput_many
      0.03 ± 99%      +0.0        0.05 ± 45%  perf-profile.self.cycles-pp.unmap_single_vma
      0.03 ± 99%      +0.0        0.05 ± 45%  perf-profile.self.cycles-pp.free_vmap_area_noflush
      0.15 ±  6%      +0.0        0.17 ±  3%  perf-profile.self.cycles-pp.queued_read_lock_slowpath
      0.11 ± 12%      +0.0        0.13 ± 14%  perf-profile.self.cycles-pp.page_counter_cancel
      0.34 ±  5%      +0.0        0.36 ± 14%  perf-profile.self.cycles-pp.dup_mmap
      0.00            +0.0        0.03 ± 99%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.03 ±100%      +0.0        0.06 ± 51%  perf-profile.self.cycles-pp.find_get_pid
      0.04 ± 45%      +0.0        0.07 ± 16%  perf-profile.self.cycles-pp.drain_obj_stock
      0.03 ±100%      +0.0        0.06 ± 13%  perf-profile.self.cycles-pp._find_next_bit
      0.09 ± 18%      +0.0        0.11 ± 10%  perf-profile.self.cycles-pp.__vma_rb_erase
      0.07 ± 18%      +0.0        0.10 ± 25%  perf-profile.self.cycles-pp.userfaultfd_unmap_prep
      0.13 ±  9%      +0.0        0.16 ±  9%  perf-profile.self.cycles-pp.refill_obj_stock
      0.04 ± 75%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.vma_interval_tree_insert_after
      0.12 ± 12%      +0.0        0.16 ±  8%  perf-profile.self.cycles-pp.__rb_erase_color
      0.82 ±  5%      +0.0        0.86 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.18 ±  7%      +0.0        0.23 ± 12%  perf-profile.self.cycles-pp.ptrace_stop
      0.83 ± 10%      +0.1        0.88 ± 13%  perf-profile.self.cycles-pp.copy_pte_range
      0.49 ±  3%      +0.1        0.54 ±  8%  perf-profile.self.cycles-pp.up_write
      0.39 ±  4%      +0.1        0.45 ± 14%  perf-profile.self.cycles-pp.do_wait
      0.00            +0.1        0.06 ± 56%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.24 ± 24%      +0.1        0.30 ± 20%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.61 ±  4%      +0.1        0.68 ±  4%  perf-profile.self.cycles-pp.kmem_cache_free
      0.28 ±  5%      +0.1        0.35 ±  9%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.45 ±  7%      +0.1        0.52 ±  7%  perf-profile.self.cycles-pp.__slab_free
      0.16 ±  7%      +0.1        0.23 ± 14%  perf-profile.self.cycles-pp._raw_read_lock
      0.21 ±  3%      +0.1        0.29 ±  8%  perf-profile.self.cycles-pp.anon_vma_clone
      0.61 ±  7%      +0.1        0.70 ±  7%  perf-profile.self.cycles-pp.release_pages
      0.34 ±  9%      +0.1        0.45 ±  9%  perf-profile.self.cycles-pp.down_write
      0.31 ±  4%      +0.1        0.45 ± 12%  perf-profile.self.cycles-pp.anon_vma_interval_tree_remove
      0.24 ± 11%      +0.1        0.38 ±  7%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.32 ±  4%      +0.2        0.49 ± 12%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      1.57 ± 12%      +0.2        1.78 ± 12%  perf-profile.self.cycles-pp.zap_pte_range
      1.08 ±  4%      +0.2        1.31 ±  7%  perf-profile.self.cycles-pp.next_uptodate_page
      7.81            +0.7        8.46 ±  7%  perf-profile.self.cycles-pp.poll_idle



> 
> > BTW, we supplied perf data in original report, not sure if they are helpful?
> > or do you have suggestion which kind of data will be more helpful to you?
> > we will continuously improve our report based on suggestions from community.
> > Thanks a lot!
> >
> 
> Staring at it some more, I notice a huge uptick in:
> 
> - major page faults (+315.2% and +270%)
> - cache misses (+125.2% and +131.0%)
> 
> I don't really get the page faults; the cache misses I could somewhat
> understand: this is adding p->flags and (p->set_child_tid)->flags accesses,
> which are in different cachelines than p->se and p->cpus_mask used in
> can_migrate_task().
> 
> I think I could dig some more into this with perf, but I'd need to be able
> to reproduce this locally first...
> 
> >>
> >> [1]: http://lore.kernel.org/r/20210223023004.GB25487@xsang-OptiPlex-9020
