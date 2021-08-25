Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB6A3F7123
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 10:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhHYIeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 04:34:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:63928 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231697AbhHYIeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 04:34:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="278494298"
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="scan'208";a="278494298"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 01:33:18 -0700
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="scan'208";a="494141081"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 01:33:13 -0700
Date:   Wed, 25 Aug 2021 16:50:59 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Sandeep Patil <sspatil@android.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: Re: [pipe] 3b844826b6: stress-ng.sigio.ops_per_sec -99.3% regression
Message-ID: <20210825085059.GC5358@xsang-OptiPlex-9020>
References: <20210824151337.GC27667@xsang-OptiPlex-9020>
 <CAHk-=wjEdeNW8bPNhwRCkMu6zLKjE2vQ=WL_6bQtc9YnaKt0bw@mail.gmail.com>
 <CAHk-=wiKAg5QtrQOtvKNwkRUn0b2xufO54GPhUoTWxBgDzXWNA@mail.gmail.com>
 <CAHk-=wgrSmiwUfSGt1RPy5KJ_TLBTP5DB0-vT=PCxQY4C7uANA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgrSmiwUfSGt1RPy5KJ_TLBTP5DB0-vT=PCxQY4C7uANA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Aug 24, 2021 at 10:39:25AM -0700, Linus Torvalds wrote:
> On Tue, Aug 24, 2021 at 10:32 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > We could do the same ugly thing for FASYNC that we do for EPOLLET -
> > make it always fasync on new data, exactly because the previous SIGIO
> > might not have emptied the buffer completely.
> 
> The patch would be something like the attached (UNTESTED!)
> 
>                   Linus

we made a quick test upon this patch, and confirmed it could recover
stress-ng.sigio performance.
BTW, we didn't use the latest stress-ng where Colin King pushed his
fix.


=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
  interrupt/gcc-9/performance/1HDD/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp7/sigio/stress-ng/60s/0x5003006

commit: 
  614cb2751d ("Merge tag 'trace-v5.14-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace")
  3b844826b6 ("pipe: avoid unnecessary EPOLLET wakeups under normal loads")
  2f048251de ("fix for 3b844826b6 from Linus")

614cb2751d315085 3b844826b6c6affa80755254da3 2f048251de14f6225773b3ede04 
---------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \  
 5.253e+08           -99.3%    3459947 ± 14%      -0.6%   5.22e+08        stress-ng.sigio.ops
   8754883           -99.3%      57665 ± 14%      -0.6%    8700647        stress-ng.sigio.ops_per_sec
     62.22            +0.2%      62.35            -0.0%      62.21        stress-ng.time.elapsed_time
     62.22            +0.2%      62.35            -0.0%      62.21        stress-ng.time.elapsed_time.max
      3500 ± 22%   +1377.4%      51720            -7.9%       3225 ±  3%  stress-ng.time.file_system_inputs
     85.33 ±169%    -100.0%       0.00           -74.7%      21.60 ± 16%  stress-ng.time.file_system_outputs
 1.035e+09          -100.0%      35652 ± 80%      -1.0%  1.025e+09        stress-ng.time.involuntary_context_switches
    654.00            -0.1%     653.67            -0.2%     652.60        stress-ng.time.major_page_faults
      6755            +0.0%       6756            -0.6%       6713        stress-ng.time.maximum_resident_set_size
     21237            -3.6%      20482            +0.4%      21327        stress-ng.time.minor_page_faults
      4096            +0.0%       4096            +0.0%       4096        stress-ng.time.page_size
      9210           -99.4%      51.17 ± 16%      -0.5%       9160        stress-ng.time.percent_of_cpu_this_job_got
      5222           -99.4%      29.88 ± 16%      -0.6%       5189        stress-ng.time.system_time
    508.33           -99.5%       2.36 ± 14%      +0.3%     509.89        stress-ng.time.user_time
   4493592 ± 18%     -86.5%     608367 ± 19%      +6.9%    4803912 ± 23%  stress-ng.time.voluntary_context_switches
    460.83           -68.6%     144.72 ±  8%      -0.1%     460.54        pmeter.Average_Active_Power
 3.504e+08         +1637.4%  6.088e+09            +6.3%  3.724e+08 ± 24%  cpuidle..time
    471193 ± 15%     -14.3%     403852 ± 11%    +173.1%    1286636 ± 19%  cpuidle..usage
    102.18            +0.1%     102.33            +0.5%     102.73        uptime.boot
      3491          +164.3%       9227            +2.0%       3559 ±  3%  uptime.idle
     37.82            -0.1%      37.78            -0.5%      37.64        boot-time.boot
     18.35            -0.2%      18.32            +0.4%      18.42        boot-time.dhcp
      3001            -0.1%       2999            -0.1%       2999        boot-time.idle
      1.00            +0.0%       1.00            +0.0%       1.00        boot-time.smp_boot
      7.57         +1211.5%      99.27            +5.6%       7.99 ± 19%  iostat.cpu.idle
      0.00 ±129%     -67.9%       0.00 ± 56%     +21.8%       0.00 ±109%  iostat.cpu.iowait
     84.16           -99.3%       0.59 ± 12%      -0.5%      83.70        iostat.cpu.system
      8.26           -98.3%       0.14 ±  5%      +0.4%       8.30        iostat.cpu.user
      5.03           +94.3       99.32            +0.4        5.47 ± 28%  mpstat.cpu.all.idle%
      0.00 ±140%      -0.0        0.00 ± 72%      +0.0        0.00 ±123%  mpstat.cpu.all.iowait%
      0.34 ±  6%      -0.3        0.01 ± 14%      +0.5        0.87 ±  2%  mpstat.cpu.all.irq%
      0.01 ± 16%      -0.0        0.01 ± 47%      +0.0        0.02 ±  4%  mpstat.cpu.all.soft%
     86.12           -85.6        0.53 ± 14%      -1.0       85.13        mpstat.cpu.all.sys%
      8.48            -8.4        0.13 ±  5%      +0.0        8.51        mpstat.cpu.all.usr%
      0.00          -100.0%       0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
    376983 ± 27%     -69.4%     115385 ± 11%     +50.1%     565820 ± 17%  numa-numastat.node0.local_node
    377025 ± 27%     -69.4%     115420 ± 11%     +64.6%     620747 ± 16%  numa-numastat.node0.numa_hit
     42.83 ± 45%      -6.6%      40.00 ± 66%  +1.3e+05%      55015 ± 53%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
    476092 ± 42%     -68.4%     150588 ± 10%      +6.9%     508983 ± 18%  numa-numastat.node1.local_node
    476118 ± 42%     -68.4%     150603 ± 10%     +13.6%     540636 ± 15%  numa-numastat.node1.numa_hit
      7.83 ± 13%    +127.7%      17.83 ±111%    +4e+05%      31650 ± 93%  numa-numastat.node1.other_node
     62.22            +0.2%      62.35            -0.0%      62.21        time.elapsed_time
     62.22            +0.2%      62.35            -0.0%      62.21        time.elapsed_time.max
      3500 ± 22%   +1377.4%      51720            -7.9%       3225 ±  3%  time.file_system_inputs
     85.33 ±169%    -100.0%       0.00           -74.7%      21.60 ± 16%  time.file_system_outputs
 1.035e+09          -100.0%      35652 ± 80%      -1.0%  1.025e+09        time.involuntary_context_switches
    654.00            -0.1%     653.67            -0.2%     652.60        time.major_page_faults
      6755            +0.0%       6756            -0.6%       6713        time.maximum_resident_set_size
     21237            -3.6%      20482            +0.4%      21327        time.minor_page_faults
      4096            +0.0%       4096            +0.0%       4096        time.page_size
      9210           -99.4%      51.17 ± 16%      -0.5%       9160        time.percent_of_cpu_this_job_got
      5222           -99.4%      29.88 ± 16%      -0.6%       5189        time.system_time
    508.33           -99.5%       2.36 ± 14%      +0.3%     509.89        time.user_time
   4493592 ± 18%     -86.5%     608367 ± 19%      +6.9%    4803912 ± 23%  time.voluntary_context_switches
      7.00         +1314.3%      99.00            +7.1%       7.50 ± 20%  vmstat.cpu.id
     83.83          -100.0%       0.00            -0.4%      83.50        vmstat.cpu.sy
      8.00          -100.0%       0.00            -1.2%       7.90 ±  3%  vmstat.cpu.us
      0.00          -100.0%       0.00          -100.0%       0.00        vmstat.cpu.wa
     42.00 ± 13%    +842.9%     396.00            -6.2%      39.40 ±  2%  vmstat.io.bi
    668.83 ±  4%    -100.0%       0.00            -4.8%     636.90 ±  6%  vmstat.io.bo
      1785 ± 22%     -99.2%      15.00           -10.4%       1599 ±  4%  vmstat.memory.buff
   2495353            +0.7%    2512055            +2.2%    2551078        vmstat.memory.cache
 5.238e+08            -0.0%  5.236e+08            -0.1%  5.232e+08        vmstat.memory.free
      0.00          -100.0%       0.00          -100.0%       0.00        vmstat.procs.b
    176.50          -100.0%       0.00            -0.5%     175.70        vmstat.procs.r
  16009506           -99.9%      20670 ± 16%      -1.6%   15757388        vmstat.system.cs
    736835 ± 17%     -96.2%      27683 ± 11%     +17.0%     862131 ± 17%  vmstat.system.in
      2589           -99.2%      21.00 ± 11%      -0.9%       2565        turbostat.Avg_MHz
     94.24           -93.5        0.72 ± 11%      -0.5       93.73        turbostat.Busy%
      2753            +5.9%       2916            -0.4%       2742        turbostat.Bzy_MHz
    273602 ± 17%     -95.1%      13315 ± 54%      +1.0%     276353 ± 29%  turbostat.C1
      0.03 ± 11%      -0.0        0.01            +0.0        0.05 ± 16%  turbostat.C1%
      5730 ± 21%    +507.5%      34814 ±114%  +11133.4%     643732 ± 36%  turbostat.C1E
      0.03 ± 27%      +0.1        0.18 ±128%      +4.7        4.70 ± 43%  turbostat.C1E%
     17066 ±  6%    +567.6%     113932 ± 12%    +622.6%     123316 ±111%  turbostat.C6
      5.56           +93.6       99.12            -4.3        1.29 ±100%  turbostat.C6%
      0.62 ±  8%    +284.8%       2.40 ± 23%    +876.0%       6.08 ± 22%  turbostat.CPU%c1
      5.14         +1785.4%      96.88           -96.5%       0.18 ± 44%  turbostat.CPU%c6
     67.17           -37.0%      42.33 ±  2%      -0.5%      66.80 ±  2%  turbostat.CoreTmp
  47874023 ± 17%     -96.3%    1782191 ± 11%     +17.6%   56322040 ± 17%  turbostat.IRQ
      2.19 ±  6%    +886.7%      21.59 ± 30%     -99.7%       0.01 ±300%  turbostat.Pkg%pc2
      0.34 ± 21%  +15100.5%      52.19 ± 32%    -100.0%       0.00        turbostat.Pkg%pc6
     66.83           -36.9%      42.17            -0.0%      66.80 ±  2%  turbostat.PkgTmp
    286.61           -83.7%      46.85 ± 12%      +1.0%     289.45        turbostat.PkgWatt
    145.97           -39.9%      87.72 ± 22%      +0.3%     146.39        turbostat.RAMWatt
      2095            -0.0%       2095            -0.0%       2095        turbostat.TSC_MHz
      4372 ±  9%    +369.6%      20531          +673.3%      33810 ±  7%  meminfo.Active
      2345            -4.8%       2232         +1263.6%      31975 ±  7%  meminfo.Active(anon)
      2026 ± 20%    +802.9%      18298            -9.5%       1834 ±  4%  meminfo.Active(file)
     68420            +0.4%      68711           +21.3%      82989 ±  3%  meminfo.AnonHugePages
    418729            +0.1%     419055            +9.0%     456394        meminfo.AnonPages
      1782 ± 22%     -99.2%      15.00           -10.5%       1596 ±  4%  meminfo.Buffers
   2396061            +0.7%    2413436            +2.0%    2445168        meminfo.Cached
  2.64e+08            +0.0%   2.64e+08            +0.0%   2.64e+08        meminfo.CommitLimit
   2275514            +0.1%    2277751            +4.1%    2368478        meminfo.Committed_AS
 5.145e+08            +0.3%  5.162e+08            -0.5%  5.121e+08        meminfo.DirectMap1G
  23388501 ± 31%      -7.5%   21636788 ± 32%     +10.2%   25785344 ± 28%  meminfo.DirectMap2M
    754116 ±  9%      +0.5%     758202 ±  4%      -2.7%     734045 ±  4%  meminfo.DirectMap4k
      2.17 ± 17%    -100.0%       0.00           +10.8%       2.40 ± 20%  meminfo.Dirty
      2048            +0.0%       2048            +0.0%       2048        meminfo.Hugepagesize
    430285            +0.2%     431111           +10.5%     475278        meminfo.Inactive
    429894            +0.2%     430913           +10.5%     474892        meminfo.Inactive(anon)
    390.50           -49.4%     197.67            -1.2%     385.80 ±  2%  meminfo.Inactive(file)
     99274            -0.7%      98618            +5.8%     105037        meminfo.KReclaimable
     19761            -0.1%      19735            +0.3%      19827        meminfo.KernelStack
     29110            -0.8%      28863           +65.1%      48068        meminfo.Mapped
 5.217e+08            -0.0%  5.215e+08            -0.1%   5.21e+08        meminfo.MemAvailable
 5.238e+08            -0.0%  5.236e+08            -0.1%  5.232e+08        meminfo.MemFree
  5.28e+08            +0.0%   5.28e+08            +0.0%   5.28e+08        meminfo.MemTotal
   4232011            +5.2%    4451421           +14.9%    4860968        meminfo.Memused
     11.00            -1.5%      10.83 ±  3%      -0.9%      10.90 ±  2%  meminfo.Mlocked
     15817 ±  2%      -0.9%      15670 ±  5%      +2.9%      16273 ±  2%  meminfo.PageTables
     46144            -0.7%      45824            +1.1%      46661        meminfo.Percpu
     99274            -0.7%      98618            +5.8%     105037        meminfo.SReclaimable
    198986            +0.8%     200618            +3.0%     204991        meminfo.SUnreclaim
     13679            +0.2%      13705          +267.7%      50297 ±  5%  meminfo.Shmem
    298261            +0.3%     299236            +3.9%     310029        meminfo.Slab
   2381742            -0.0%    2381249            +0.5%    2394243        meminfo.Unevictable
 3.436e+10            +0.0%  3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
    275141           +20.7%     331981            +0.0%     275217        meminfo.VmallocUsed
      0.00          -100.0%       0.00          -100.0%       0.00        meminfo.Writeback
   4339025            +3.8%    4502372           +14.8%    4980620        meminfo.max_used_kB
      3446 ± 11%    +467.8%      19571           -25.3%       2574 ± 17%  numa-meminfo.node0.Active
      1772 ± 11%     -28.2%       1272 ± 19%     -10.1%       1592 ± 26%  numa-meminfo.node0.Active(anon)
      1673 ± 24%    +993.3%      18298           -41.4%     981.50 ± 28%  numa-meminfo.node0.Active(file)
     68835           -22.4%      53388 ± 47%     -21.6%      53989 ± 53%  numa-meminfo.node0.AnonHugePages
    338248 ±  4%     -12.6%     295578 ± 17%     -18.5%     275711 ± 44%  numa-meminfo.node0.AnonPages
    350493 ±  4%     -11.8%     309008 ± 17%     -17.5%     289001 ± 42%  numa-meminfo.node0.AnonPages.max
      2.17 ± 17%    -100.0%       0.00           -21.5%       1.70 ± 69%  numa-meminfo.node0.Dirty
   1333118 ± 79%     -27.4%     968496 ± 98%      +9.0%    1452520 ± 74%  numa-meminfo.node0.FilePages
    340684 ±  4%     -12.2%     299212 ± 17%     -17.8%     279974 ± 44%  numa-meminfo.node0.Inactive
    340374 ±  4%     -12.2%     299014 ± 17%     -17.8%     279776 ± 44%  numa-meminfo.node0.Inactive(anon)
    310.00 ± 36%     -36.2%     197.67           -36.3%     197.40 ± 35%  numa-meminfo.node0.Inactive(file)
     54606 ± 34%     -16.2%      45749 ± 41%      +3.0%      56220 ± 43%  numa-meminfo.node0.KReclaimable
     11881 ±  2%      -5.7%      11202 ±  2%     -11.8%      10481 ± 15%  numa-meminfo.node0.KernelStack
     14229 ± 66%     -21.5%      11165 ± 89%     +77.8%      25300 ± 61%  numa-meminfo.node0.Mapped
 2.614e+08            +0.1%  2.617e+08            -0.1%  2.611e+08        numa-meminfo.node0.MemFree
 2.638e+08            +0.0%  2.638e+08            +0.0%  2.638e+08        numa-meminfo.node0.MemTotal
   2411458 ± 44%     -12.0%    2123217 ± 50%     +15.8%    2793600 ± 45%  numa-meminfo.node0.MemUsed
      5.50 ±100%     -36.4%       3.50 ±141%     +18.2%       6.50 ± 81%  numa-meminfo.node0.Mlocked
     12294 ±  2%      -6.1%      11545 ±  8%     -20.8%       9741 ± 42%  numa-meminfo.node0.PageTables
     54606 ± 34%     -16.2%      45749 ± 41%      +3.0%      56220 ± 43%  numa-meminfo.node0.SReclaimable
    101947 ±  2%      +0.4%     102336 ±  7%      +2.6%     104555 ± 15%  numa-meminfo.node0.SUnreclaim
      3902 ±  5%     +24.6%       4863 ± 74%     +47.0%       5737 ± 85%  numa-meminfo.node0.Shmem
    156553 ± 12%      -5.4%     148086 ± 17%      +2.7%     160775 ± 24%  numa-meminfo.node0.Slab
   1327230 ± 79%     -28.8%     945135 ±100%      +8.9%    1445600 ± 74%  numa-meminfo.node0.Unevictable
      0.00          -100.0%       0.00          -100.0%       0.00        numa-meminfo.node0.Writeback
    927.50 ± 48%      +3.8%     962.83 ± 25%   +3305.1%      31582 ±  8%  numa-meminfo.node1.Active
    573.33 ± 31%     +67.9%     962.83 ± 25%   +5259.7%      30729 ±  8%  numa-meminfo.node1.Active(anon)
    354.00 ±141%    -100.0%       0.00          +141.0%     853.10 ± 36%  numa-meminfo.node1.Active(file)
      0.00       +1.5e+106%      15322 ±163% +2.9e+106%      29081 ±100%  numa-meminfo.node1.AnonHugePages
     81000 ± 18%     +52.5%     123499 ± 41%    +122.8%     180443 ± 67%  numa-meminfo.node1.AnonPages
     86089 ± 17%     +52.7%     131489 ± 40%    +148.1%     213556 ± 57%  numa-meminfo.node1.AnonPages.max
      0.00          -100.0%       0.00         +7e+101%       0.70 ±157%  numa-meminfo.node1.Dirty
   1064732 ± 98%     +35.7%    1444969 ± 66%      -6.6%     994199 ±108%  numa-meminfo.node1.FilePages
     90153 ± 16%     +46.4%     131939 ± 39%    +116.0%     194686 ± 64%  numa-meminfo.node1.Inactive
     90072 ± 16%     +46.5%     131939 ± 39%    +115.9%     194499 ± 64%  numa-meminfo.node1.Inactive(anon)
     80.17 ±141%    -100.0%       0.00          +133.4%     187.10 ± 39%  numa-meminfo.node1.Inactive(file)
     44666 ± 44%     +18.4%      52867 ± 34%      +9.3%      48816 ± 49%  numa-meminfo.node1.KReclaimable
      7878 ±  4%      +8.4%       8538 ±  4%     +18.6%       9341 ± 16%  numa-meminfo.node1.KernelStack
     14938 ± 62%     +18.8%      17747 ± 55%     +47.2%      21995 ± 70%  numa-meminfo.node1.Mapped
 2.624e+08            -0.2%  2.619e+08            -0.1%  2.621e+08        numa-meminfo.node1.MemFree
 2.642e+08            +0.0%  2.642e+08            +0.0%  2.642e+08        numa-meminfo.node1.MemTotal
   1821060 ± 59%     +27.8%    2327936 ± 45%     +13.5%    2066695 ± 60%  numa-meminfo.node1.MemUsed
      5.50 ±100%     +33.3%       7.33 ± 70%     -20.0%       4.40 ±122%  numa-meminfo.node1.Mlocked
      3525 ±  8%     +17.4%       4138 ± 11%     +84.7%       6510 ± 62%  numa-meminfo.node1.PageTables
     44666 ± 44%     +18.4%      52867 ± 34%      +9.3%      48816 ± 49%  numa-meminfo.node1.SReclaimable
     97041 ±  2%      +1.3%      98279 ±  7%      +3.5%     100432 ± 17%  numa-meminfo.node1.SUnreclaim
      9784 ±  2%      -9.5%       8856 ± 40%    +354.9%      44514 ± 10%  numa-meminfo.node1.Shmem
    141708 ± 14%      +6.7%     151146 ± 15%      +5.3%     149249 ± 26%  numa-meminfo.node1.Slab
   1054512 ± 99%     +36.2%    1436113 ± 66%     -10.0%     948642 ±113%  numa-meminfo.node1.Unevictable
    350.50 ±  9%      +0.3%     351.67 ±  4%      -2.8%     340.70 ±  4%  proc-vmstat.direct_map_level2_splits
     19.33 ± 36%      -8.6%      17.67 ± 38%     +11.7%      21.60 ± 31%  proc-vmstat.direct_map_level3_splits
    586.00            -4.7%     558.67         +1255.9%       7945 ±  7%  proc-vmstat.nr_active_anon
    506.50 ± 20%    +803.1%       4574            -9.6%     458.10 ±  4%  proc-vmstat.nr_active_file
    104766            -0.0%     104765            +9.1%     114248        proc-vmstat.nr_anon_pages
     33.17            +0.0%      33.17           +20.3%      39.90 ±  3%  proc-vmstat.nr_anon_transparent_hugepages
     18.00 ±101%    -100.0%       0.00           -41.7%      10.50 ± 10%  proc-vmstat.nr_dirtied
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.nr_dirty
  13021455            -0.0%   13016400            -0.1%   13005744        proc-vmstat.nr_dirty_background_threshold
  26074750            -0.0%   26064626            -0.1%   26043289        proc-vmstat.nr_dirty_threshold
    599462            +0.7%     603366            +2.0%     611651        proc-vmstat.nr_file_pages
  1.31e+08            -0.0%  1.309e+08            -0.1%  1.308e+08        proc-vmstat.nr_free_pages
    107561            +0.2%     107735           +10.5%     118887        proc-vmstat.nr_inactive_anon
     97.33           -49.7%      49.00            -1.3%      96.10 ±  2%  proc-vmstat.nr_inactive_file
      0.67 ±223%     +25.0%       0.83 ±223%    -100.0%       0.00        proc-vmstat.nr_isolated_anon
     19763            -0.1%      19737            +0.3%      19829        proc-vmstat.nr_kernel_stack
      7526            -1.0%       7448           +60.2%      12054        proc-vmstat.nr_mapped
      2.00            +0.0%       2.00            +0.0%       2.00        proc-vmstat.nr_mlock
      3955 ±  2%      -0.9%       3919 ±  5%      +2.9%       4069 ±  2%  proc-vmstat.nr_page_table_pages
      3421            +0.2%       3429          +266.4%      12534 ±  5%  proc-vmstat.nr_shmem
     24817            -0.7%      24654            +5.8%      26256        proc-vmstat.nr_slab_reclaimable
     49746            +0.8%      50153            +3.0%      51247        proc-vmstat.nr_slab_unreclaimable
    595435            -0.0%     595311            +0.5%     598560        proc-vmstat.nr_unevictable
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.nr_writeback
     17.33 ±104%    -100.0%       0.00           -43.5%       9.80 ± 11%  proc-vmstat.nr_written
    586.00            -4.7%     558.67         +1255.9%       7945 ±  7%  proc-vmstat.nr_zone_active_anon
    506.50 ± 20%    +803.1%       4574            -9.6%     458.10 ±  4%  proc-vmstat.nr_zone_active_file
    107561            +0.2%     107735           +10.5%     118886        proc-vmstat.nr_zone_inactive_anon
     97.33           -49.7%      49.00            -1.3%      96.10 ±  2%  proc-vmstat.nr_zone_inactive_file
    595435            -0.0%     595311            +0.5%     598560        proc-vmstat.nr_zone_unevictable
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.nr_zone_write_pending
      1827 ±139%     +75.1%       3198 ±144%      +0.6%       1838 ±115%  proc-vmstat.numa_hint_faults
    281.50 ± 43%    +261.3%       1017 ±191%    +287.4%       1090 ±188%  proc-vmstat.numa_hint_faults_local
    854050 ± 15%     -68.7%     267735           +36.1%    1162734 ±  7%  proc-vmstat.numa_hit
      8.17 ± 90%     +46.9%      12.00 ± 80%    +104.5%      16.70 ± 61%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.numa_interleave
    853991 ± 15%     -68.7%     267685           +26.0%    1076154 ±  8%  proc-vmstat.numa_local
     50.67 ± 37%     +14.1%      57.83 ± 26%  +1.7e+05%      86665        proc-vmstat.numa_other
      1441 ±174%     +83.0%       2638 ±147%     -45.3%     788.50 ±112%  proc-vmstat.numa_pages_migrated
      8806 ±128%     +81.3%      15965 ± 85%     +79.4%      15799 ± 70%  proc-vmstat.numa_pte_updates
    683.00 ± 12%    +885.7%       6732         +2989.4%      21100 ±  6%  proc-vmstat.pgactivate
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
    854034 ± 15%     -68.6%     267802           +36.5%    1165653 ±  7%  proc-vmstat.pgalloc_normal
    327631            +1.9%     333769            +9.3%     358214        proc-vmstat.pgfault
    871818 ± 15%     -69.4%     266460           +19.4%    1041041 ±  8%  proc-vmstat.pgfree
      1441 ±174%     +83.0%       2638 ±147%     -45.3%     788.50 ±112%  proc-vmstat.pgmigrate_success
      2760 ± 13%    +836.8%      25860            -5.2%       2616 ±  2%  proc-vmstat.pgpgin
     42476 ±  4%    -100.0%       0.00            -3.3%      41082 ±  6%  proc-vmstat.pgpgout
     18879            -3.7%      18176 ±  2%      +4.2%      19668 ±  2%  proc-vmstat.pgreuse
     56.00            +0.0%      56.00            -1.4%      55.20 ±  4%  proc-vmstat.thp_collapse_alloc
     96.00            +0.3%      96.33            +0.2%      96.20        proc-vmstat.thp_deferred_split_page
     96.00            +0.3%      96.33           +12.7%     108.20        proc-vmstat.thp_fault_alloc
      0.00       +1.5e+102%       1.50 ±223%   +4e+101%       0.40 ±300%  proc-vmstat.thp_migration_success
    192.33            +0.2%     192.67            +0.0%     192.40        proc-vmstat.thp_split_pmd
      0.33 ±141%      +0.0%       0.33 ±141%    -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
      1.17 ± 31%     -14.3%       1.00         +1288.6%      16.20 ±  2%  proc-vmstat.unevictable_pgs_culled
      3.00            +0.0%       3.00            +0.0%       3.00        proc-vmstat.unevictable_pgs_mlocked
      0.00         +5e+101%       0.50 ±223%   +3e+101%       0.30 ±300%  proc-vmstat.unevictable_pgs_munlocked
    443.00 ± 11%     -28.1%     318.33 ± 20%     -10.2%     398.00 ± 26%  numa-vmstat.node0.nr_active_anon
    418.00 ± 24%    +994.2%       4573           -41.4%     244.80 ± 28%  numa-vmstat.node0.nr_active_file
     84388 ±  4%     -12.3%      73975 ± 17%     -18.4%      68827 ± 44%  numa-vmstat.node0.nr_anon_pages
     33.17           -22.6%      25.67 ± 48%     -22.2%      25.80 ± 54%  numa-vmstat.node0.nr_anon_transparent_hugepages
     13.33 ±133%    -100.0%       0.00           -70.8%       3.90 ± 68%  numa-vmstat.node0.nr_dirtied
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node0.nr_dirty
    333276 ± 79%     -27.4%     242124 ± 98%      +9.0%     363129 ± 74%  numa-vmstat.node0.nr_file_pages
  65358187            +0.1%   65430065            -0.1%   65262691        numa-vmstat.node0.nr_free_pages
     84912 ±  4%     -11.9%      74831 ± 17%     -17.7%      69841 ± 44%  numa-vmstat.node0.nr_inactive_anon
     77.00 ± 36%     -36.4%      49.00           -36.5%      48.90 ± 36%  numa-vmstat.node0.nr_inactive_file
      0.00       +1.7e+101%       0.17 ±223%   +2e+101%       0.20 ±300%  numa-vmstat.node0.nr_isolated_anon
     11879 ±  2%      -5.7%      11206 ±  2%     -11.8%      10483 ± 15%  numa-vmstat.node0.nr_kernel_stack
      3736 ± 64%     -21.4%       2938 ± 85%     +68.1%       6280 ± 61%  numa-vmstat.node0.nr_mapped
      1.00 ±100%     -33.3%       0.67 ±141%     +20.0%       1.20 ± 81%  numa-vmstat.node0.nr_mlock
      3070            -5.9%       2890 ±  8%     -20.6%       2437 ± 42%  numa-vmstat.node0.nr_page_table_pages
    972.00 ±  6%     +25.2%       1216 ± 74%     +47.5%       1434 ± 85%  numa-vmstat.node0.nr_shmem
     13651 ± 34%     -16.2%      11436 ± 41%      +3.0%      14054 ± 43%  numa-vmstat.node0.nr_slab_reclaimable
     25485 ±  2%      +0.4%      25585 ±  7%      +2.6%      26138 ± 15%  numa-vmstat.node0.nr_slab_unreclaimable
    331807 ± 79%     -28.8%     236283 ±100%      +8.9%     361399 ± 74%  numa-vmstat.node0.nr_unevictable
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node0.nr_writeback
     12.50 ±141%    -100.0%       0.00           -72.0%       3.50 ± 66%  numa-vmstat.node0.nr_written
    443.00 ± 11%     -28.1%     318.33 ± 20%     -10.2%     398.00 ± 26%  numa-vmstat.node0.nr_zone_active_anon
    418.00 ± 24%    +994.2%       4573           -41.4%     244.80 ± 28%  numa-vmstat.node0.nr_zone_active_file
     84912 ±  4%     -11.9%      74831 ± 17%     -17.7%      69841 ± 44%  numa-vmstat.node0.nr_zone_inactive_anon
     77.00 ± 36%     -36.4%      49.00           -36.5%      48.90 ± 36%  numa-vmstat.node0.nr_zone_inactive_file
    331807 ± 79%     -28.8%     236283 ±100%      +8.9%     361399 ± 74%  numa-vmstat.node0.nr_zone_unevictable
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node0.nr_zone_write_pending
   1420363 ± 20%     -18.1%    1163862 ± 20%      +3.7%    1472898 ± 28%  numa-vmstat.node0.numa_hit
      4098 ±  6%      -4.4%       3915 ±  6%      -4.0%       3934 ±  6%  numa-vmstat.node0.numa_interleave
   1413276 ± 20%     -18.1%    1156993 ± 20%      +0.0%    1413290 ± 28%  numa-vmstat.node0.numa_local
      7087 ± 23%      -3.1%       6871 ± 44%    +742.0%      59676 ± 48%  numa-vmstat.node0.numa_other
    143.00 ± 31%     +68.8%     241.33 ± 25%   +5337.6%       7775 ±  7%  numa-vmstat.node1.nr_active_anon
     88.33 ±141%    -100.0%       0.00          +141.0%     212.90 ± 36%  numa-vmstat.node1.nr_active_file
     20168 ± 18%     +53.3%      30921 ± 41%    +123.1%      44987 ± 67%  numa-vmstat.node1.nr_anon_pages
      0.00       +7.3e+102%       7.33 ±165% +1.4e+103%      13.60 ±105%  numa-vmstat.node1.nr_anon_transparent_hugepages
      0.00          -100.0%       0.00       +1.7e+102%       1.70 ±153%  numa-vmstat.node1.nr_dirtied
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node1.nr_dirty
    266182 ± 98%     +35.7%     361242 ± 66%      -6.6%     248569 ±108%  numa-vmstat.node1.nr_file_pages
  65593348            -0.2%   65466566            -0.1%   65532062        numa-vmstat.node1.nr_free_pages
     22434 ± 16%     +47.2%      33025 ± 39%    +115.8%      48423 ± 64%  numa-vmstat.node1.nr_inactive_anon
     20.00 ±141%    -100.0%       0.00          +132.5%      46.50 ± 39%  numa-vmstat.node1.nr_inactive_file
      7880 ±  4%      +8.4%       8542 ±  4%     +18.6%       9342 ± 16%  numa-vmstat.node1.nr_kernel_stack
      3791 ± 63%     +19.5%       4532 ± 54%     +41.8%       5376 ± 72%  numa-vmstat.node1.nr_mapped
      1.00 ±100%     +33.3%       1.33 ± 70%     -20.0%       0.80 ±122%  numa-vmstat.node1.nr_mlock
    881.83 ±  8%     +17.2%       1033 ± 11%     +84.6%       1628 ± 62%  numa-vmstat.node1.nr_page_table_pages
      2445 ±  2%      -9.5%       2214 ± 40%    +355.8%      11147 ± 10%  numa-vmstat.node1.nr_shmem
     11166 ± 44%     +18.4%      13216 ± 34%      +9.3%      12205 ± 49%  numa-vmstat.node1.nr_slab_reclaimable
     24260 ±  2%      +1.3%      24569 ±  7%      +3.5%      25107 ± 17%  numa-vmstat.node1.nr_slab_unreclaimable
    263628 ± 99%     +36.2%     359028 ± 66%     -10.0%     237159 ±113%  numa-vmstat.node1.nr_unevictable
      0.00          -100.0%       0.00       +1.4e+102%       1.40 ±153%  numa-vmstat.node1.nr_written
    143.00 ± 31%     +68.8%     241.33 ± 25%   +5337.6%       7775 ±  7%  numa-vmstat.node1.nr_zone_active_anon
     88.33 ±141%    -100.0%       0.00          +141.0%     212.90 ± 36%  numa-vmstat.node1.nr_zone_active_file
     22434 ± 16%     +47.2%      33025 ± 39%    +115.8%      48422 ± 64%  numa-vmstat.node1.nr_zone_inactive_anon
     20.00 ±141%    -100.0%       0.00          +132.5%      46.50 ± 39%  numa-vmstat.node1.nr_zone_inactive_file
    263628 ± 99%     +36.2%     359028 ± 66%     -10.0%     237159 ±113%  numa-vmstat.node1.nr_zone_unevictable
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node1.nr_zone_write_pending
   1033498 ± 26%      -3.8%     994168 ± 23%     +15.1%    1189223 ± 34%  numa-vmstat.node1.numa_hit
      3956 ±  6%      +3.9%       4112 ±  5%      +3.6%       4099 ±  6%  numa-vmstat.node1.numa_interleave
   1026957 ± 26%      -3.9%     987362 ± 23%     +12.0%    1150325 ± 34%  numa-vmstat.node1.numa_local
      6538 ± 25%      +4.1%       6806 ± 44%    +494.8%      38894 ± 73%  numa-vmstat.node1.numa_other
      0.00          -100.0%       0.00       +1.4e+102%       1.44 ± 20%  perf-stat.i.MPKI
      0.00          -100.0%       0.00       +2.3e+112%  2.297e+10        perf-stat.i.branch-instructions
      0.00            +0.0        0.00            +1.0        1.03 ±  2%  perf-stat.i.branch-miss-rate%
      0.00          -100.0%       0.00       +2.1e+110%  2.138e+08        perf-stat.i.branch-misses
      0.00            +0.0        0.00           +14.3       14.28 ± 25%  perf-stat.i.cache-miss-rate%
      0.00          -100.0%       0.00       +1.9e+109%   18662679 ± 19%  perf-stat.i.cache-misses
      0.00          -100.0%       0.00       +1.5e+110%  1.465e+08 ± 24%  perf-stat.i.cache-references
      0.00          -100.0%       0.00       +1.6e+109%   16294613        perf-stat.i.context-switches
      0.00          -100.0%       0.00       +2.2e+102%       2.19        perf-stat.i.cpi
      0.00          -100.0%       0.00       +9.6e+106%      96016        perf-stat.i.cpu-clock
      0.00          -100.0%       0.00       +2.5e+113%  2.482e+11        perf-stat.i.cpu-cycles
      0.00          -100.0%       0.00       +3.2e+104%     319.45 ± 12%  perf-stat.i.cpu-migrations
      0.00          -100.0%       0.00       +1.5e+106%      14859 ± 19%  perf-stat.i.cycles-between-cache-misses
      0.00            +0.0        0.00            +0.0        0.00 ± 34%  perf-stat.i.dTLB-load-miss-rate%
      0.00          -100.0%       0.00       +6.6e+107%     662655 ± 32%  perf-stat.i.dTLB-load-misses
      0.00          -100.0%       0.00       +3.3e+112%  3.348e+10        perf-stat.i.dTLB-loads
      0.00            +0.0        0.00            +0.0        0.01 ± 14%  perf-stat.i.dTLB-store-miss-rate%
      0.00          -100.0%       0.00         +1e+108%    1015581 ± 17%  perf-stat.i.dTLB-store-misses
      0.00          -100.0%       0.00       +2.1e+112%  2.133e+10        perf-stat.i.dTLB-stores
      0.00            +0.0        0.00           +59.6       59.56        perf-stat.i.iTLB-load-miss-rate%
      0.00          -100.0%       0.00       +1.2e+110%  1.162e+08 ±  2%  perf-stat.i.iTLB-load-misses
      0.00          -100.0%       0.00       +7.7e+109%   77223996        perf-stat.i.iTLB-loads
      0.00          -100.0%       0.00       +1.1e+113%  1.116e+11        perf-stat.i.instructions
      0.00          -100.0%       0.00       +1.1e+105%       1145 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.00          -100.0%       0.00       +4.7e+101%       0.47        perf-stat.i.ipc
      0.00          -100.0%       0.00       +1.2e+103%      12.18        perf-stat.i.major-faults
      0.00          -100.0%       0.00       +2.6e+102%       2.59        perf-stat.i.metric.GHz
      0.00          -100.0%       0.00       +1.2e+105%       1195 ± 13%  perf-stat.i.metric.K/sec
      0.00          -100.0%       0.00       +8.1e+104%     811.58        perf-stat.i.metric.M/sec
      0.00          -100.0%       0.00       +4.1e+105%       4145        perf-stat.i.minor-faults
      0.00            +0.0        0.00           +91.8       91.80        perf-stat.i.node-load-miss-rate%
      0.00          -100.0%       0.00       +2.6e+108%    2564340 ± 39%  perf-stat.i.node-load-misses
      0.00          -100.0%       0.00         +2e+107%     199295 ± 33%  perf-stat.i.node-loads
      0.00            +0.0        0.00           +96.8       96.78        perf-stat.i.node-store-miss-rate%
      0.00          -100.0%       0.00         +4e+108%    4044206 ± 10%  perf-stat.i.node-store-misses
      0.00          -100.0%       0.00       +6.8e+106%      67946 ± 13%  perf-stat.i.node-stores
      0.00          -100.0%       0.00       +4.2e+105%       4157        perf-stat.i.page-faults
      0.00          -100.0%       0.00       +9.6e+106%      96016        perf-stat.i.task-clock
      0.00          -100.0%       0.00       +1.3e+102%       1.31 ± 24%  perf-stat.overall.MPKI
      0.00            +0.0        0.00            +0.9        0.93        perf-stat.overall.branch-miss-rate%
      0.00            +0.0        0.00           +13.4       13.35 ± 27%  perf-stat.overall.cache-miss-rate%
      0.00          -100.0%       0.00       +2.2e+102%       2.22        perf-stat.overall.cpi
      0.00          -100.0%       0.00       +1.4e+106%      13860 ± 22%  perf-stat.overall.cycles-between-cache-misses
      0.00            +0.0        0.00            +0.0        0.00 ± 31%  perf-stat.overall.dTLB-load-miss-rate%
      0.00            +0.0        0.00            +0.0        0.00 ± 17%  perf-stat.overall.dTLB-store-miss-rate%
      0.00            +0.0        0.00           +60.1       60.06        perf-stat.overall.iTLB-load-miss-rate%
      0.00          -100.0%       0.00       +9.6e+104%     961.32 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.00          -100.0%       0.00       +4.5e+101%       0.45        perf-stat.overall.ipc
      0.00            +0.0        0.00           +92.3       92.31        perf-stat.overall.node-load-miss-rate%
      0.00            +0.0        0.00           +98.3       98.33        perf-stat.overall.node-store-miss-rate%
      0.00          -100.0%       0.00       +2.3e+112%  2.261e+10        perf-stat.ps.branch-instructions
      0.00          -100.0%       0.00       +2.1e+110%  2.104e+08        perf-stat.ps.branch-misses
      0.00          -100.0%       0.00       +1.8e+109%   18404867 ± 19%  perf-stat.ps.cache-misses
      0.00          -100.0%       0.00       +1.4e+110%  1.441e+08 ± 24%  perf-stat.ps.cache-references
      0.00          -100.0%       0.00       +1.6e+109%   16039489        perf-stat.ps.context-switches
      0.00          -100.0%       0.00       +9.4e+106%      94483        perf-stat.ps.cpu-clock
      0.00          -100.0%       0.00       +2.4e+113%  2.443e+11        perf-stat.ps.cpu-cycles
      0.00          -100.0%       0.00       +3.2e+104%     316.14 ± 13%  perf-stat.ps.cpu-migrations
      0.00          -100.0%       0.00       +6.7e+107%     666546 ± 31%  perf-stat.ps.dTLB-load-misses
      0.00          -100.0%       0.00       +3.3e+112%  3.295e+10        perf-stat.ps.dTLB-loads
      0.00          -100.0%       0.00         +1e+108%     998219 ± 17%  perf-stat.ps.dTLB-store-misses
      0.00          -100.0%       0.00       +2.1e+112%  2.099e+10        perf-stat.ps.dTLB-stores
      0.00          -100.0%       0.00       +1.1e+110%  1.144e+08 ±  2%  perf-stat.ps.iTLB-load-misses
      0.00          -100.0%       0.00       +7.6e+109%   76012244        perf-stat.ps.iTLB-loads
      0.00          -100.0%       0.00       +1.1e+113%  1.099e+11        perf-stat.ps.instructions
      0.00          -100.0%       0.00       +1.2e+103%      12.02        perf-stat.ps.major-faults
      0.00          -100.0%       0.00       +4.1e+105%       4077        perf-stat.ps.minor-faults
      0.00          -100.0%       0.00       +2.5e+108%    2531563 ± 39%  perf-stat.ps.node-load-misses
      0.00          -100.0%       0.00         +2e+107%     198756 ± 33%  perf-stat.ps.node-loads
      0.00          -100.0%       0.00         +4e+108%    3983809 ± 10%  perf-stat.ps.node-store-misses
      0.00          -100.0%       0.00       +6.7e+106%      66879 ± 13%  perf-stat.ps.node-stores
      0.00          -100.0%       0.00       +4.1e+105%       4089        perf-stat.ps.page-faults
      0.00          -100.0%       0.00       +9.4e+106%      94483        perf-stat.ps.task-clock
      0.00          -100.0%       0.00       +6.9e+114%  6.919e+12        perf-stat.total.instructions
      0.00          -100.0%       0.00        +6.4e+99%       0.01 ± 68%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00          -100.0%       0.00        +5.2e+99%       0.01 ±105%  perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.00          -100.0%       0.00        +4.7e+99%       0.00 ±159%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00          -100.0%       0.00       +5.6e+100%       0.06 ±154%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00          -100.0%       0.00          +1e+99%       0.00 ±154%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.00          -100.0%       0.00          +3e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.00          -100.0%       0.00        +5.2e+99%       0.01 ± 37%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00       +3.5e+100%       0.04 ±174%  perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00          -100.0%       0.00          +5e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.00          -100.0%       0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00       +1.3e+100%       0.01 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary
      0.00          -100.0%       0.00          +6e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00          -100.0%       0.00          +3e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.begin_new_exec
      0.00          -100.0%       0.00        +1.9e+99%       0.00 ±101%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00          -100.0%       0.00       +3.1e+101%       0.31 ±296%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00          -100.0%       0.00         +1e+100%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.00          -100.0%       0.00       +5.2e+101%       0.52 ±231%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00          -100.0%       0.00       +2.2e+100%       0.02 ±112%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00          -100.0%       0.00       +1.5e+101%       0.15 ± 61%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.00          -100.0%       0.00        +7.5e+99%       0.01 ± 69%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00          -100.0%       0.00        +6.5e+99%       0.01 ±104%  perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.00          -100.0%       0.00       +5.2e+100%       0.05 ±236%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00          -100.0%       0.00       +1.8e+102%       1.83 ±158%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00          -100.0%       0.00          +1e+99%       0.00 ±154%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.00          -100.0%       0.00          +3e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.00          -100.0%       0.00        +7.6e+99%       0.01 ± 13%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00         +7e+101%       0.70 ±195%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00          -100.0%       0.00          +5e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.00          -100.0%       0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00       +1.3e+100%       0.01 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary
      0.00          -100.0%       0.00          +6e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00          -100.0%       0.00          +3e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.begin_new_exec
      0.00          -100.0%       0.00          +2e+99%       0.00 ±102%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00          -100.0%       0.00       +1.9e+102%       1.87 ±298%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00          -100.0%       0.00         +1e+100%       0.01 ± 14%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.00          -100.0%       0.00         +1e+102%       1.01 ±203%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00          -100.0%       0.00       +2.9e+102%       2.89 ±149%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00          -100.0%       0.00       +3.9e+102%       3.92 ±  5%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.00          -100.0%       0.00       +2.7e+100%       0.03 ± 46%  perf-sched.total_sch_delay.average.ms
      0.00          -100.0%       0.00       +7.5e+102%       7.46 ± 64%  perf-sched.total_sch_delay.max.ms
      0.00          -100.0%       0.00       +1.1e+102%       1.10 ± 39%  perf-sched.total_wait_and_delay.average.ms
      0.00          -100.0%       0.00       +4.9e+104%     487.20 ± 18%  perf-sched.total_wait_and_delay.count.ms
      0.00          -100.0%       0.00       +1.6e+103%      15.87 ± 31%  perf-sched.total_wait_and_delay.max.ms
      0.00          -100.0%       0.00       +1.1e+102%       1.07 ± 39%  perf-sched.total_wait_time.average.ms
      0.00          -100.0%       0.00       +1.6e+103%      15.58 ± 30%  perf-sched.total_wait_time.max.ms
      0.00          -100.0%       0.00         +9e+101%       0.90 ±100%  perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00          -100.0%       0.00       +7.5e+101%       0.75 ±122%  perf-sched.wait_and_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.00          -100.0%       0.00       +4.3e+101%       0.43 ± 53%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00          -100.0%       0.00       +9.8e+101%       0.98 ±129%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.00          -100.0%       0.00       +4.4e+101%       0.44 ± 22%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00          -100.0%       0.00          +3e+98%       0.00 ±300%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.00          -100.0%       0.00       +1.1e+100%       0.01 ±299%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.00          -100.0%       0.00        +3.3e+99%       0.00 ± 92%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00       +6.6e+101%       0.66 ± 27%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00          -100.0%       0.00        +3.5e+99%       0.00 ±300%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      0.00          -100.0%       0.00        +1.2e+99%       0.00 ±152%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00          -100.0%       0.00       +7.1e+100%       0.07 ± 48%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.00          -100.0%       0.00       +1.7e+102%       1.69 ± 68%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00          -100.0%       0.00          +2e+99%       0.00 ±204%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.00          -100.0%       0.00       +2.9e+102%       2.86 ± 41%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00          -100.0%       0.00       +2.4e+102%       2.41 ± 52%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00          -100.0%       0.00       +1.4e+102%       1.37 ± 36%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.00          -100.0%       0.00         +1e+102%       1.00 ±100%  perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00          -100.0%       0.00         +8e+101%       0.80 ±122%  perf-sched.wait_and_delay.count.do_syslog.part.0.kmsg_read.vfs_read
      0.00          -100.0%       0.00       +3.5e+103%      35.00 ± 40%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00          -100.0%       0.00         +7e+101%       0.70 ±111%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.00          -100.0%       0.00       +2.8e+103%      28.40 ± 43%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00          -100.0%       0.00         +3e+101%       0.30 ±213%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.00          -100.0%       0.00         +2e+101%       0.20 ±200%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.00          -100.0%       0.00       +1.2e+102%       1.20 ± 89%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00       +2.7e+103%      27.00 ± 59%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__fput.task_work_run.do_exit
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00         +3e+101%       0.30 ±213%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      0.00          -100.0%       0.00         +6e+101%       0.60 ±169%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00          -100.0%       0.00       +1.7e+104%     169.10 ±  9%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.00          -100.0%       0.00       +7.3e+102%       7.30 ± 40%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00          -100.0%       0.00         +2e+101%       0.20 ±200%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.00          -100.0%       0.00       +3.8e+102%       3.80 ± 49%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00          -100.0%       0.00       +1.7e+104%     170.70 ±  9%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
      0.00          -100.0%       0.00       +3.5e+103%      35.30 ± 44%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      0.00          -100.0%       0.00       +1.8e+102%       1.80 ±100%  perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00          -100.0%       0.00       +1.5e+102%       1.49 ±122%  perf-sched.wait_and_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.00          -100.0%       0.00       +3.5e+102%       3.53 ± 62%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00          -100.0%       0.00       +1.1e+102%       1.13 ±114%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.00          -100.0%       0.00       +2.3e+102%       2.32 ±113%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00          -100.0%       0.00          +3e+98%       0.00 ±300%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.00          -100.0%       0.00       +1.1e+100%       0.01 ±299%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.00          -100.0%       0.00        +4.7e+99%       0.00 ± 83%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00       +2.3e+102%       2.33 ± 33%  perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00          -100.0%       0.00        +6.9e+99%       0.01 ±300%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      0.00          -100.0%       0.00        +1.3e+99%       0.00 ±154%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00          -100.0%       0.00       +6.7e+102%       6.65 ± 68%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.00          -100.0%       0.00       +7.7e+102%       7.69 ± 76%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00          -100.0%       0.00          +2e+99%       0.00 ±204%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.00          -100.0%       0.00       +4.3e+102%       4.27 ± 36%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00          -100.0%       0.00       +1.4e+103%      14.21 ± 30%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00          -100.0%       0.00       +1.1e+103%      11.39 ± 52%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.00          -100.0%       0.00       +1.2e+102%       1.22 ± 66%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00          -100.0%       0.00       +9.1e+101%       0.91 ±100%  perf-sched.wait_time.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.00          -100.0%       0.00       +4.3e+101%       0.43 ± 52%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00          -100.0%       0.00         +1e+102%       1.03 ±120%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.00          -100.0%       0.00       +3.8e+101%       0.38 ±  8%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00          -100.0%       0.00       +1.1e+100%       0.01 ±299%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.00          -100.0%       0.00          +4e+98%       0.00 ±300%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00       +6.3e+101%       0.63 ± 23%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00          -100.0%       0.00        +3.6e+99%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.00          -100.0%       0.00          +9e+99%       0.01 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mmput.do_exit.do_group_exit
      0.00          -100.0%       0.00        +3.5e+99%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      0.00          -100.0%       0.00       +1.6e+100%       0.02 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.swevent_hlist_put_cpu.sw_perf_event_destroy
      0.00          -100.0%       0.00       +7.1e+100%       0.07 ± 48%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.00          -100.0%       0.00       +1.4e+102%       1.37 ± 49%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00          -100.0%       0.00       +2.3e+102%       2.34 ± 53%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00          -100.0%       0.00          +7e+98%       0.00 ±300%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.00          -100.0%       0.00       +2.4e+102%       2.39 ± 52%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00          -100.0%       0.00       +1.2e+102%       1.21 ± 47%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      0.00          -100.0%       0.00       +2.4e+102%       2.44 ± 66%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00          -100.0%       0.00       +1.8e+102%       1.81 ±100%  perf-sched.wait_time.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.00          -100.0%       0.00       +3.5e+102%       3.53 ± 62%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00          -100.0%       0.00       +1.2e+102%       1.21 ±102%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.00          -100.0%       0.00       +8.8e+101%       0.88 ± 23%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00          -100.0%       0.00       +1.1e+100%       0.01 ±299%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.00          -100.0%       0.00          +7e+98%       0.00 ±299%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00         +2e+102%       2.05 ± 27%  perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00          -100.0%       0.00        +3.6e+99%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.00          -100.0%       0.00          +9e+99%       0.01 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mmput.do_exit.do_group_exit
      0.00          -100.0%       0.00        +6.9e+99%       0.01 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      0.00          -100.0%       0.00       +1.6e+100%       0.02 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.swevent_hlist_put_cpu.sw_perf_event_destroy
      0.00          -100.0%       0.00       +6.7e+102%       6.65 ± 68%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.00          -100.0%       0.00       +6.3e+102%       6.31 ± 73%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00          -100.0%       0.00       +3.8e+102%       3.77 ± 51%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00          -100.0%       0.00          +7e+98%       0.00 ±300%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.00          -100.0%       0.00       +1.4e+103%      13.85 ± 29%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00          -100.0%       0.00       +1.1e+103%      10.89 ± 61%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
    194162            -0.0%     194101            -0.0%     194097        slabinfo.Acpi-Operand.active_objs
      3467            -0.0%       3466            -0.0%       3466        slabinfo.Acpi-Operand.active_slabs
    194180            -0.0%     194105            -0.0%     194103        slabinfo.Acpi-Operand.num_objs
      3467            -0.0%       3466            -0.0%       3466        slabinfo.Acpi-Operand.num_slabs
      1345 ±  5%      +8.0%       1452 ±  4%      -5.4%       1273 ±  7%  slabinfo.Acpi-Parse.active_objs
     17.50 ±  5%      +8.6%      19.00 ±  5%      -4.6%      16.70 ±  6%  slabinfo.Acpi-Parse.active_slabs
      1345 ±  5%      +8.0%       1452 ±  4%      -5.4%       1273 ±  7%  slabinfo.Acpi-Parse.num_objs
     17.50 ±  5%      +8.6%      19.00 ±  5%      -4.6%      16.70 ±  6%  slabinfo.Acpi-Parse.num_slabs
      4941            -0.4%       4919            +0.1%       4946        slabinfo.Acpi-State.active_objs
     96.33            -0.3%      96.00            +0.2%      96.50        slabinfo.Acpi-State.active_slabs
      4941            -0.4%       4919            +0.1%       4946        slabinfo.Acpi-State.num_objs
     96.33            -0.3%      96.00            +0.2%      96.50        slabinfo.Acpi-State.num_slabs
    192.00            +0.0%     192.00            +0.0%     192.00        slabinfo.RAW.active_objs
      6.00            +0.0%       6.00            +0.0%       6.00        slabinfo.RAW.active_slabs
    192.00            +0.0%     192.00            +0.0%     192.00        slabinfo.RAW.num_objs
      6.00            +0.0%       6.00            +0.0%       6.00        slabinfo.RAW.num_slabs
    104.00            +0.0%     104.00            +0.0%     104.00        slabinfo.RAWv6.active_objs
      4.00            +0.0%       4.00            +0.0%       4.00        slabinfo.RAWv6.active_slabs
    104.00            +0.0%     104.00            +0.0%     104.00        slabinfo.RAWv6.num_objs
      4.00            +0.0%       4.00            +0.0%       4.00        slabinfo.RAWv6.num_slabs
     63.67 ±  8%      +3.7%      66.00            +2.3%      65.10 ±  4%  slabinfo.TCP.active_objs
      3.83 ±  9%      +4.3%       4.00            +4.3%       4.00        slabinfo.TCP.active_slabs
     63.67 ±  8%      +3.7%      66.00            +2.3%      65.10 ±  4%  slabinfo.TCP.num_objs
      3.83 ±  9%      +4.3%       4.00            +4.3%       4.00        slabinfo.TCP.num_slabs
     39.00            -5.6%      36.83 ± 13%      +0.0%      39.00        slabinfo.TCPv6.active_objs
      3.00            -5.6%       2.83 ± 13%      +0.0%       3.00        slabinfo.TCPv6.active_slabs
     39.00            -5.6%      36.83 ± 13%      +0.0%      39.00        slabinfo.TCPv6.num_objs
      3.00            -5.6%       2.83 ± 13%      +0.0%       3.00        slabinfo.TCPv6.num_slabs
    120.00 ± 11%     +20.0%     144.00            +4.0%     124.80 ± 11%  slabinfo.UDPv6.active_objs
      5.00 ± 11%     +20.0%       6.00            +4.0%       5.20 ± 11%  slabinfo.UDPv6.active_slabs
    120.00 ± 11%     +20.0%     144.00            +4.0%     124.80 ± 11%  slabinfo.UDPv6.num_objs
      5.00 ± 11%     +20.0%       6.00            +4.0%       5.20 ± 11%  slabinfo.UDPv6.num_slabs
      2057 ±  7%      +2.3%       2104 ±  7%      -4.8%       1958 ± 16%  slabinfo.UNIX.active_objs
     68.00 ±  7%      +2.2%      69.50 ±  7%      -4.3%      65.10 ± 16%  slabinfo.UNIX.active_slabs
      2057 ±  7%      +2.3%       2104 ±  7%      -4.8%       1958 ± 16%  slabinfo.UNIX.num_objs
     68.00 ±  7%      +2.2%      69.50 ±  7%      -4.3%      65.10 ± 16%  slabinfo.UNIX.num_slabs
     29264 ±  2%      +2.7%      30040 ±  2%      +1.6%      29727 ±  4%  slabinfo.anon_vma.active_objs
    635.50 ±  2%      +2.7%     652.50 ±  2%      +1.6%     645.80 ±  4%  slabinfo.anon_vma.active_slabs
     29264 ±  2%      +2.7%      30043 ±  2%      +1.6%      29729 ±  4%  slabinfo.anon_vma.num_objs
    635.50 ±  2%      +2.7%     652.50 ±  2%      +1.6%     645.80 ±  4%  slabinfo.anon_vma.num_slabs
     67046 ±  4%      -0.6%      66630 ±  3%      +3.7%      69534 ±  9%  slabinfo.anon_vma_chain.active_objs
      1047 ±  4%      -0.7%       1040 ±  3%      +3.7%       1087 ±  9%  slabinfo.anon_vma_chain.active_slabs
     67081 ±  4%      -0.7%      66645 ±  3%      +3.8%      69598 ±  9%  slabinfo.anon_vma_chain.num_objs
      1047 ±  4%      -0.7%       1040 ±  3%      +3.7%       1087 ±  9%  slabinfo.anon_vma_chain.num_slabs
    119.00 ± 13%     +11.8%     133.00 ± 11%      +2.4%     121.80 ± 10%  slabinfo.bdev_cache.active_objs
      5.67 ± 13%     +11.8%       6.33 ± 11%      +2.4%       5.80 ± 10%  slabinfo.bdev_cache.active_slabs
    119.00 ± 13%     +11.8%     133.00 ± 11%      +2.4%     121.80 ± 10%  slabinfo.bdev_cache.num_objs
      5.67 ± 13%     +11.8%       6.33 ± 11%      +2.4%       5.80 ± 10%  slabinfo.bdev_cache.num_slabs
    114.33 ± 19%     -19.2%      92.33 ± 18%     -15.8%      96.30 ± 20%  slabinfo.biovec-128.active_objs
      6.33 ± 23%     -23.7%       4.83 ± 22%     -17.9%       5.20 ± 24%  slabinfo.biovec-128.active_slabs
    114.33 ± 19%     -19.2%      92.33 ± 18%     -15.8%      96.30 ± 20%  slabinfo.biovec-128.num_objs
      6.33 ± 23%     -23.7%       4.83 ± 22%     -17.9%       5.20 ± 24%  slabinfo.biovec-128.num_slabs
    258.67 ±  8%      +0.6%     260.33 ± 11%      +9.2%     282.40 ± 12%  slabinfo.biovec-64.active_objs
      7.17 ±  9%      +0.0%       7.17 ± 12%     +10.2%       7.90 ± 14%  slabinfo.biovec-64.active_slabs
    258.67 ±  8%      +0.6%     260.33 ± 11%      +9.2%     282.40 ± 12%  slabinfo.biovec-64.num_objs
      7.17 ±  9%      +0.0%       7.17 ± 12%     +10.2%       7.90 ± 14%  slabinfo.biovec-64.num_slabs
     85.00 ±  5%      -0.8%      84.33 ±  4%      -6.7%      79.30 ±  8%  slabinfo.biovec-max.active_objs
      9.83 ±  6%      -1.7%       9.67 ±  4%      -7.5%       9.10 ± 10%  slabinfo.biovec-max.active_slabs
     85.00 ±  5%      -0.8%      84.33 ±  4%      -6.7%      79.30 ±  8%  slabinfo.biovec-max.num_objs
      9.83 ±  6%      -1.7%       9.67 ±  4%      -7.5%       9.10 ± 10%  slabinfo.biovec-max.num_slabs
     56.00            +0.0%      56.00            +0.0%      56.00        slabinfo.btrfs_extent_map.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.btrfs_extent_map.active_slabs
     56.00            +0.0%      56.00            +0.0%      56.00        slabinfo.btrfs_extent_map.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.btrfs_extent_map.num_slabs
    107.33 ±  9%     -13.0%      93.33 ± 22%      -3.5%     103.60 ± 12%  slabinfo.btrfs_inode.active_objs
      3.83 ±  9%     -13.0%       3.33 ± 22%      -3.5%       3.70 ± 12%  slabinfo.btrfs_inode.active_slabs
    107.33 ±  9%     -13.0%      93.33 ± 22%      -3.5%     103.60 ± 12%  slabinfo.btrfs_inode.num_objs
      3.83 ±  9%     -13.0%       3.33 ± 22%      -3.5%       3.70 ± 12%  slabinfo.btrfs_inode.num_slabs
    720.33 ± 13%     -74.1%     186.50 ±  7%      -6.2%     675.80 ±  3%  slabinfo.buffer_head.active_objs
     18.00 ± 12%     -78.7%       3.83 ±  9%      -6.7%      16.80 ±  4%  slabinfo.buffer_head.active_slabs
    720.33 ± 13%     -74.1%     186.50 ±  7%      -6.2%     675.80 ±  3%  slabinfo.buffer_head.num_objs
     18.00 ± 12%     -78.7%       3.83 ±  9%      -6.7%      16.80 ±  4%  slabinfo.buffer_head.num_slabs
      6613 ±  4%      +4.0%       6877 ±  3%      +4.9%       6935 ±  4%  slabinfo.cred_jar.active_objs
    156.83 ±  4%      +4.0%     163.17 ±  3%      +5.0%     164.70 ±  4%  slabinfo.cred_jar.active_slabs
      6613 ±  4%      +4.0%       6877 ±  3%      +4.9%       6935 ±  4%  slabinfo.cred_jar.num_objs
    156.83 ±  4%      +4.0%     163.17 ±  3%      +5.0%     164.70 ±  4%  slabinfo.cred_jar.num_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.dax_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dax_cache.active_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.dax_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dax_cache.num_slabs
    123596 ±  2%      +0.3%     123967            +8.4%     133929 ±  4%  slabinfo.dentry.active_objs
      2944 ±  2%      +0.7%       2964            +8.8%       3204 ±  4%  slabinfo.dentry.active_slabs
    123706 ±  2%      +0.7%     124539            +8.8%     134618 ±  4%  slabinfo.dentry.num_objs
      2944 ±  2%      +0.7%       2964            +8.8%       3204 ±  4%  slabinfo.dentry.num_slabs
     30.00            +0.0%      30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.active_slabs
     30.00            +0.0%      30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.num_slabs
     15.00            +0.0%      15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.active_slabs
     15.00            +0.0%      15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.num_slabs
     50.50 ± 32%    -100.0%       0.00           -28.3%      36.20 ± 30%  slabinfo.dquot.active_objs
      0.83 ± 82%    -100.0%       0.00           -64.0%       0.30 ±152%  slabinfo.dquot.active_slabs
     50.50 ± 32%    -100.0%       0.00           -28.3%      36.20 ± 30%  slabinfo.dquot.num_objs
      0.83 ± 82%    -100.0%       0.00           -64.0%       0.30 ±152%  slabinfo.dquot.num_slabs
     21888 ±  5%      +0.2%      21930 ± 10%      -1.1%      21657 ± 10%  slabinfo.ep_head.active_objs
     85.50 ±  5%      +0.2%      85.67 ± 10%      -1.1%      84.60 ± 10%  slabinfo.ep_head.active_slabs
     21888 ±  5%      +0.2%      21930 ± 10%      -1.1%      21657 ± 10%  slabinfo.ep_head.num_objs
     85.50 ±  5%      +0.2%      85.67 ± 10%      -1.1%      84.60 ± 10%  slabinfo.ep_head.num_slabs
    197.00          -100.0%       0.00            +0.0%     197.00        slabinfo.ext4_extent_status.active_objs
      1.00          -100.0%       0.00            +0.0%       1.00        slabinfo.ext4_extent_status.active_slabs
    197.00          -100.0%       0.00            +0.0%     197.00        slabinfo.ext4_extent_status.num_objs
      1.00          -100.0%       0.00            +0.0%       1.00        slabinfo.ext4_extent_status.num_slabs
      3904          -100.0%       0.00            +0.0%       3904        slabinfo.ext4_groupinfo_4k.active_objs
     92.17          -100.0%       0.00            -0.1%      92.10        slabinfo.ext4_groupinfo_4k.active_slabs
      3904          -100.0%       0.00            +0.0%       3904        slabinfo.ext4_groupinfo_4k.num_objs
     92.17          -100.0%       0.00            -0.1%      92.10        slabinfo.ext4_groupinfo_4k.num_slabs
     27.00          -100.0%       0.00            +0.0%      27.00        slabinfo.ext4_inode_cache.active_objs
      0.00          -100.0%       0.00          -100.0%       0.00        slabinfo.ext4_inode_cache.active_slabs
     27.00          -100.0%       0.00            +0.0%      27.00        slabinfo.ext4_inode_cache.num_objs
      0.00          -100.0%       0.00          -100.0%       0.00        slabinfo.ext4_inode_cache.num_slabs
     20.50 ±223%    +504.9%     124.00          -100.0%       0.00        slabinfo.ext4_pending_reservation.active_objs
      0.00          -100.0%       0.00          -100.0%       0.00        slabinfo.ext4_pending_reservation.active_slabs
     20.50 ±223%    +504.9%     124.00          -100.0%       0.00        slabinfo.ext4_pending_reservation.num_objs
      0.00          -100.0%       0.00          -100.0%       0.00        slabinfo.ext4_pending_reservation.num_slabs
    296.00          -100.0%       0.00            +0.0%     296.00        slabinfo.ext4_system_zone.active_objs
      2.00          -100.0%       0.00            +0.0%       2.00        slabinfo.ext4_system_zone.active_slabs
    296.00          -100.0%       0.00            +0.0%     296.00        slabinfo.ext4_system_zone.num_objs
      2.00          -100.0%       0.00            +0.0%       2.00        slabinfo.ext4_system_zone.num_slabs
      0.00       +3.6e+105%       3623          -100.0%       0.00        slabinfo.f2fs_free_nid.active_objs
      0.00       +2.1e+103%      21.00          -100.0%       0.00        slabinfo.f2fs_free_nid.active_slabs
      0.00       +3.6e+105%       3623          -100.0%       0.00        slabinfo.f2fs_free_nid.num_objs
      0.00       +2.1e+103%      21.00          -100.0%       0.00        slabinfo.f2fs_free_nid.num_slabs
      0.00       +2.7e+103%      27.00          -100.0%       0.00        slabinfo.f2fs_inode_cache.active_objs
      0.00          -100.0%       0.00          -100.0%       0.00        slabinfo.f2fs_inode_cache.active_slabs
      0.00       +2.7e+103%      27.00          -100.0%       0.00        slabinfo.f2fs_inode_cache.num_objs
      0.00          -100.0%       0.00          -100.0%       0.00        slabinfo.f2fs_inode_cache.num_slabs
    936.33 ±  7%      -5.9%     881.50 ±  6%      +5.3%     985.50 ± 11%  slabinfo.file_lock_cache.active_objs
     25.00 ±  9%      -6.7%      23.33 ±  7%      +3.6%      25.90 ± 12%  slabinfo.file_lock_cache.active_slabs
    936.33 ±  7%      -5.9%     881.50 ±  6%      +5.3%     985.50 ± 11%  slabinfo.file_lock_cache.num_objs
     25.00 ±  9%      -6.7%      23.33 ±  7%      +3.6%      25.90 ± 12%  slabinfo.file_lock_cache.num_slabs
      4524            -3.1%       4385 ±  3%      +1.2%       4579 ±  2%  slabinfo.files_cache.active_objs
     97.67            -2.7%      95.00 ±  3%      +1.4%      99.00 ±  2%  slabinfo.files_cache.active_slabs
      4524            -3.1%       4385 ±  3%      +1.2%       4579 ±  2%  slabinfo.files_cache.num_objs
     97.67            -2.7%      95.00 ±  3%      +1.4%      99.00 ±  2%  slabinfo.files_cache.num_slabs
     28568 ±  2%      +0.7%      28772 ±  5%      +0.4%      28674 ±  4%  slabinfo.filp.active_objs
    896.33 ±  2%      +1.4%     908.50 ±  5%      +1.2%     907.20 ±  4%  slabinfo.filp.active_slabs
     28694 ±  2%      +1.4%      29082 ±  5%      +1.2%      29042 ±  4%  slabinfo.filp.num_objs
    896.33 ±  2%      +1.4%     908.50 ±  5%      +1.2%     907.20 ±  4%  slabinfo.filp.num_slabs
      2709 ±  6%      +0.8%       2730 ±  9%     -12.1%       2380 ± 13%  slabinfo.fsnotify_mark_connector.active_objs
     21.17 ±  6%      +0.8%      21.33 ±  9%     -12.1%      18.60 ± 13%  slabinfo.fsnotify_mark_connector.active_slabs
      2709 ±  6%      +0.8%       2730 ±  9%     -12.1%       2380 ± 13%  slabinfo.fsnotify_mark_connector.num_objs
     21.17 ±  6%      +0.8%      21.33 ±  9%     -12.1%      18.60 ± 13%  slabinfo.fsnotify_mark_connector.num_slabs
     35895            +0.4%      36028            +0.3%      36005        slabinfo.ftrace_event_field.active_objs
    421.83            +0.4%     423.50            +0.3%     423.20        slabinfo.ftrace_event_field.active_slabs
     35895            +0.4%      36028            +0.3%      36005        slabinfo.ftrace_event_field.num_objs
    421.83            +0.4%     423.50            +0.3%     423.20        slabinfo.ftrace_event_field.num_slabs
    106.00            -8.3%      97.17 ± 20%      -5.0%     100.70 ± 15%  slabinfo.hugetlbfs_inode_cache.active_objs
      2.00            -8.3%       1.83 ± 20%      -5.0%       1.90 ± 15%  slabinfo.hugetlbfs_inode_cache.active_slabs
    106.00            -8.3%      97.17 ± 20%      -5.0%     100.70 ± 15%  slabinfo.hugetlbfs_inode_cache.num_objs
      2.00            -8.3%       1.83 ± 20%      -5.0%       1.90 ± 15%  slabinfo.hugetlbfs_inode_cache.num_slabs
     82984            +0.2%      83190            +2.0%      84625        slabinfo.inode_cache.active_objs
      1508            +0.3%       1512            +2.1%       1540        slabinfo.inode_cache.active_slabs
     82985            +0.2%      83191            +2.1%      84739        slabinfo.inode_cache.num_objs
      1508            +0.3%       1512            +2.1%       1540        slabinfo.inode_cache.num_slabs
     33.00 ± 10%    -100.0%       0.00            -1.2%      32.60 ± 18%  slabinfo.jbd2_journal_head.active_objs
      0.17 ±223%    -100.0%       0.00           -40.0%       0.10 ±300%  slabinfo.jbd2_journal_head.active_slabs
     33.00 ± 10%    -100.0%       0.00            -1.2%      32.60 ± 18%  slabinfo.jbd2_journal_head.num_objs
      0.17 ±223%    -100.0%       0.00           -40.0%       0.10 ±300%  slabinfo.jbd2_journal_head.num_slabs
    247.17          -100.0%       0.00            -0.0%     247.10        slabinfo.jbd2_revoke_table_s.active_objs
      0.00          -100.0%       0.00          -100.0%       0.00        slabinfo.jbd2_revoke_table_s.active_slabs
    247.17          -100.0%       0.00            -0.0%     247.10        slabinfo.jbd2_revoke_table_s.num_objs
      0.00          -100.0%       0.00          -100.0%       0.00        slabinfo.jbd2_revoke_table_s.num_slabs
     87955            +0.4%      88296            +0.0%      87975        slabinfo.kernfs_node_cache.active_objs
      2747            +0.4%       2758            +0.0%       2748        slabinfo.kernfs_node_cache.active_slabs
     87955            +0.4%      88296            +0.0%      87975        slabinfo.kernfs_node_cache.num_objs
      2747            +0.4%       2758            +0.0%       2748        slabinfo.kernfs_node_cache.num_slabs
      2585 ±  2%      +5.3%       2721 ±  4%      +6.2%       2746 ±  4%  slabinfo.khugepaged_mm_slot.active_objs
     71.33 ±  2%      +5.4%      75.17 ±  4%      +6.4%      75.90 ±  4%  slabinfo.khugepaged_mm_slot.active_slabs
      2585 ±  2%      +5.3%       2721 ±  4%      +6.2%       2746 ±  4%  slabinfo.khugepaged_mm_slot.num_objs
     71.33 ±  2%      +5.4%      75.17 ±  4%      +6.4%      75.90 ±  4%  slabinfo.khugepaged_mm_slot.num_slabs
      5302            -0.0%       5302            +0.5%       5331        slabinfo.kmalloc-128.active_objs
    165.83            +0.6%     166.83            +0.7%     167.00        slabinfo.kmalloc-128.active_slabs
      5320            +0.4%       5338            +0.7%       5355        slabinfo.kmalloc-128.num_objs
    165.83            +0.6%     166.83            +0.7%     167.00        slabinfo.kmalloc-128.num_slabs
     36541            -0.7%      36296            -0.1%      36514        slabinfo.kmalloc-16.active_objs
    141.83            +0.0%     141.83            -0.1%     141.70        slabinfo.kmalloc-16.active_slabs
     36556            -0.7%      36309            -0.1%      36521        slabinfo.kmalloc-16.num_objs
    141.83            +0.0%     141.83            -0.1%     141.70        slabinfo.kmalloc-16.num_slabs
      5458            +0.0%       5460            +0.5%       5488        slabinfo.kmalloc-192.active_objs
    133.17            -0.3%     132.83            +0.0%     133.20        slabinfo.kmalloc-192.active_slabs
      5593            -0.3%       5579            +0.0%       5594        slabinfo.kmalloc-192.num_objs
    133.17            -0.3%     132.83            +0.0%     133.20        slabinfo.kmalloc-192.num_slabs
      5422 ±  2%      -0.9%       5371 ±  2%      -0.6%       5392        slabinfo.kmalloc-1k.active_objs
    169.83 ±  2%      -1.2%     167.83 ±  2%      -0.6%     168.80        slabinfo.kmalloc-1k.active_slabs
      5441 ±  3%      -1.1%       5381            -0.6%       5410        slabinfo.kmalloc-1k.num_objs
    169.83 ±  2%      -1.2%     167.83 ±  2%      -0.6%     168.80        slabinfo.kmalloc-1k.num_slabs
      9422 ±  4%      +4.9%       9886 ±  4%      +5.1%       9904 ±  6%  slabinfo.kmalloc-256.active_objs
    294.33 ±  4%      +4.8%     308.33 ±  4%      +5.1%     309.40 ±  6%  slabinfo.kmalloc-256.active_slabs
      9429 ±  4%      +4.9%       9887 ±  4%      +5.1%       9912 ±  6%  slabinfo.kmalloc-256.num_objs
    294.33 ±  4%      +4.8%     308.33 ±  4%      +5.1%     309.40 ±  6%  slabinfo.kmalloc-256.num_slabs
      5257 ±  2%      -1.9%       5158 ±  3%      +0.2%       5268 ±  4%  slabinfo.kmalloc-2k.active_objs
    329.00 ±  2%      -1.9%     322.67 ±  3%      +0.7%     331.20 ±  4%  slabinfo.kmalloc-2k.active_slabs
      5275 ±  2%      -2.0%       5171 ±  3%      +0.5%       5304 ±  4%  slabinfo.kmalloc-2k.num_objs
    329.00 ±  2%      -1.9%     322.67 ±  3%      +0.7%     331.20 ±  4%  slabinfo.kmalloc-2k.num_slabs
     70964            +1.3%      71893            +1.2%      71847        slabinfo.kmalloc-32.active_objs
    555.00            +1.2%     561.83            +1.2%     561.40        slabinfo.kmalloc-32.active_slabs
     71138            +1.2%      72017            +1.1%      71948        slabinfo.kmalloc-32.num_objs
    555.00            +1.2%     561.83            +1.2%     561.40        slabinfo.kmalloc-32.num_slabs
      1753            +0.8%       1767            +9.0%       1911        slabinfo.kmalloc-4k.active_objs
    220.33            +0.3%     221.00            +9.6%     241.50        slabinfo.kmalloc-4k.active_slabs
      1762            +0.7%       1775            +9.8%       1935        slabinfo.kmalloc-4k.num_objs
    220.33            +0.3%     221.00            +9.6%     241.50        slabinfo.kmalloc-4k.num_slabs
     15439 ±  2%      +1.9%      15733 ±  4%      +5.2%      16247 ±  3%  slabinfo.kmalloc-512.active_objs
    482.67 ±  2%      +2.0%     492.50 ±  4%      +5.2%     507.80 ±  3%  slabinfo.kmalloc-512.active_slabs
     15459 ±  2%      +2.1%      15783 ±  4%      +5.2%      16263 ±  3%  slabinfo.kmalloc-512.num_objs
    482.67 ±  2%      +2.0%     492.50 ±  4%      +5.2%     507.80 ±  3%  slabinfo.kmalloc-512.num_slabs
     49505           +50.6%      74578            +0.6%      49811        slabinfo.kmalloc-64.active_objs
    777.17           +50.4%       1169            +0.5%     780.70        slabinfo.kmalloc-64.active_slabs
     49774           +50.4%      74856            +0.5%      50006        slabinfo.kmalloc-64.num_objs
    777.17           +50.4%       1169            +0.5%     780.70        slabinfo.kmalloc-64.num_slabs
     53803            -0.3%      53661            -0.5%      53516        slabinfo.kmalloc-8.active_objs
    108.00            -0.2%     107.83            -0.3%     107.70        slabinfo.kmalloc-8.active_slabs
     55517            -0.6%      55210            -0.6%      55201        slabinfo.kmalloc-8.num_objs
    108.00            -0.2%     107.83            -0.3%     107.70        slabinfo.kmalloc-8.num_slabs
    718.00            +0.5%     721.33           +13.9%     817.50        slabinfo.kmalloc-8k.active_objs
    179.50            +0.5%     180.33           +13.7%     204.10        slabinfo.kmalloc-8k.active_slabs
    718.00            +0.5%     721.33           +14.0%     818.40        slabinfo.kmalloc-8k.num_objs
    179.50            +0.5%     180.33           +13.7%     204.10        slabinfo.kmalloc-8k.num_slabs
      7834            -0.3%       7809 ±  4%      -0.6%       7785 ±  3%  slabinfo.kmalloc-96.active_objs
    188.17 ±  2%      -0.5%     187.17 ±  4%      -0.7%     186.90 ±  3%  slabinfo.kmalloc-96.active_slabs
      7936 ±  2%      -0.7%       7883 ±  4%      -0.8%       7873 ±  3%  slabinfo.kmalloc-96.num_objs
    188.17 ±  2%      -0.5%     187.17 ±  4%      -0.7%     186.90 ±  3%  slabinfo.kmalloc-96.num_slabs
    292.50 ± 27%      +4.6%     306.00 ± 36%      -4.2%     280.30 ± 21%  slabinfo.kmalloc-cg-16.active_objs
      1.00           +16.7%       1.17 ± 31%      +0.0%       1.00        slabinfo.kmalloc-cg-16.active_slabs
    292.50 ± 27%      +4.6%     306.00 ± 36%      -4.2%     280.30 ± 21%  slabinfo.kmalloc-cg-16.num_objs
      1.00           +16.7%       1.17 ± 31%      +0.0%       1.00        slabinfo.kmalloc-cg-16.num_slabs
      3734            -4.0%       3585 ±  3%      +1.4%       3787 ±  4%  slabinfo.kmalloc-cg-192.active_objs
     88.33            -3.8%      85.00 ±  3%      +1.5%      89.70 ±  4%  slabinfo.kmalloc-cg-192.active_slabs
      3734            -4.0%       3585 ±  3%      +1.4%       3787 ±  4%  slabinfo.kmalloc-cg-192.num_objs
     88.33            -3.8%      85.00 ±  3%      +1.5%      89.70 ±  4%  slabinfo.kmalloc-cg-192.num_slabs
      3654 ±  6%      -5.8%       3442 ±  3%      -4.1%       3504 ±  3%  slabinfo.kmalloc-cg-1k.active_objs
    113.67 ±  6%      -5.6%     107.33 ±  3%      -4.0%     109.10 ±  3%  slabinfo.kmalloc-cg-1k.active_slabs
      3654 ±  6%      -5.8%       3442 ±  3%      -4.1%       3504 ±  3%  slabinfo.kmalloc-cg-1k.num_objs
    113.67 ±  6%      -5.6%     107.33 ±  3%      -4.0%     109.10 ±  3%  slabinfo.kmalloc-cg-1k.num_slabs
    432.00 ±  3%      +3.7%     448.00 ±  4%     +20.8%     521.80 ± 11%  slabinfo.kmalloc-cg-256.active_objs
     13.50 ±  3%      +3.7%      14.00 ±  4%     +15.6%      15.60 ± 12%  slabinfo.kmalloc-cg-256.active_slabs
    432.00 ±  3%      +3.7%     448.00 ±  4%     +20.8%     521.80 ± 11%  slabinfo.kmalloc-cg-256.num_objs
     13.50 ±  3%      +3.7%      14.00 ±  4%     +15.6%      15.60 ± 12%  slabinfo.kmalloc-cg-256.num_slabs
    314.83 ± 12%      -3.8%     303.00 ± 11%      -3.6%     303.60 ±  6%  slabinfo.kmalloc-cg-2k.active_objs
     19.00 ± 13%      -4.4%      18.17 ± 12%      -2.6%      18.50 ±  6%  slabinfo.kmalloc-cg-2k.active_slabs
    314.83 ± 12%      -3.8%     303.00 ± 11%      -3.6%     303.60 ±  6%  slabinfo.kmalloc-cg-2k.num_objs
     19.00 ± 13%      -4.4%      18.17 ± 12%      -2.6%      18.50 ±  6%  slabinfo.kmalloc-cg-2k.num_slabs
     11104 ±  2%      +4.3%      11578 ±  2%      +3.2%      11460 ±  5%  slabinfo.kmalloc-cg-32.active_objs
     86.33 ±  2%      +4.2%      90.00 ±  2%      +3.2%      89.10 ±  5%  slabinfo.kmalloc-cg-32.active_slabs
     11104 ±  2%      +4.3%      11578 ±  2%      +3.2%      11460 ±  5%  slabinfo.kmalloc-cg-32.num_objs
     86.33 ±  2%      +4.2%      90.00 ±  2%      +3.2%      89.10 ±  5%  slabinfo.kmalloc-cg-32.num_slabs
    768.00            +0.0%     768.00            +0.0%     768.00        slabinfo.kmalloc-cg-4k.active_objs
     96.00            +0.0%      96.00            +0.0%      96.00        slabinfo.kmalloc-cg-4k.active_slabs
    768.00            +0.0%     768.00            +0.0%     768.00        slabinfo.kmalloc-cg-4k.num_objs
     96.00            +0.0%      96.00            +0.0%      96.00        slabinfo.kmalloc-cg-4k.num_slabs
      3061            +0.2%       3066            +0.1%       3065        slabinfo.kmalloc-cg-512.active_objs
     95.67            +0.2%      95.83            +0.0%      95.70        slabinfo.kmalloc-cg-512.active_slabs
      3061            +0.2%       3066            +0.1%       3065        slabinfo.kmalloc-cg-512.num_objs
     95.67            +0.2%      95.83            +0.0%      95.70        slabinfo.kmalloc-cg-512.num_slabs
      3248 ± 13%     -19.4%       2618 ±  5%     -40.4%       1936 ± 10%  slabinfo.kmalloc-cg-64.active_objs
     50.33 ± 13%     -19.5%      40.50 ±  4%     -41.2%      29.60 ± 10%  slabinfo.kmalloc-cg-64.active_slabs
      3248 ± 13%     -19.4%       2618 ±  5%     -40.4%       1936 ± 10%  slabinfo.kmalloc-cg-64.num_objs
     50.33 ± 13%     -19.5%      40.50 ±  4%     -41.2%      29.60 ± 10%  slabinfo.kmalloc-cg-64.num_slabs
     49658            +0.0%      49664            +0.0%      49659        slabinfo.kmalloc-cg-8.active_objs
     96.83            +0.2%      97.00            +0.1%      96.90        slabinfo.kmalloc-cg-8.active_slabs
     49658            +0.0%      49664            +0.0%      49659        slabinfo.kmalloc-cg-8.num_objs
     96.83            +0.2%      97.00            +0.1%      96.90        slabinfo.kmalloc-cg-8.num_slabs
     27.00            +0.0%      27.00           +28.1%      34.60 ±  3%  slabinfo.kmalloc-cg-8k.active_objs
      6.00            +0.0%       6.00           +31.7%       7.90 ±  3%  slabinfo.kmalloc-cg-8k.active_slabs
     27.00            +0.0%      27.00           +28.1%      34.60 ±  3%  slabinfo.kmalloc-cg-8k.num_objs
      6.00            +0.0%       6.00           +31.7%       7.90 ±  3%  slabinfo.kmalloc-cg-8k.num_slabs
    555.17 ±  6%      -1.7%     545.50 ± 11%      -8.8%     506.10 ±  9%  slabinfo.kmalloc-cg-96.active_objs
     12.50 ±  6%      -2.7%      12.17 ± 12%      -8.8%      11.40 ±  9%  slabinfo.kmalloc-cg-96.active_slabs
    555.17 ±  6%      -1.7%     545.50 ± 11%      -8.8%     506.10 ±  9%  slabinfo.kmalloc-cg-96.num_objs
     12.50 ±  6%      -2.7%      12.17 ± 12%      -8.8%      11.40 ±  9%  slabinfo.kmalloc-cg-96.num_slabs
    496.00 ± 15%     +22.6%     608.00 ±  5%     +10.3%     547.20 ± 11%  slabinfo.kmalloc-rcl-128.active_objs
     15.50 ± 15%     +22.6%      19.00 ±  5%     +10.3%      17.10 ± 11%  slabinfo.kmalloc-rcl-128.active_slabs
    496.00 ± 15%     +22.6%     608.00 ±  5%     +10.3%     547.20 ± 11%  slabinfo.kmalloc-rcl-128.num_objs
     15.50 ± 15%     +22.6%      19.00 ±  5%     +10.3%      17.10 ± 11%  slabinfo.kmalloc-rcl-128.num_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.kmalloc-rcl-192.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-rcl-192.active_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.kmalloc-rcl-192.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.kmalloc-rcl-192.num_slabs
      7210 ±  5%      +3.9%       7494 ±  2%      +2.6%       7397 ±  4%  slabinfo.kmalloc-rcl-64.active_objs
    113.33 ±  5%      +3.4%     117.17 ±  3%      +2.1%     115.70 ±  4%  slabinfo.kmalloc-rcl-64.active_slabs
      7253 ±  5%      +3.7%       7519 ±  2%      +2.6%       7441 ±  4%  slabinfo.kmalloc-rcl-64.num_objs
    113.33 ±  5%      +3.4%     117.17 ±  3%      +2.1%     115.70 ±  4%  slabinfo.kmalloc-rcl-64.num_slabs
      2296 ±  6%      +3.4%       2373 ±  5%      +7.0%       2457 ±  5%  slabinfo.kmalloc-rcl-96.active_objs
     54.67 ±  6%      +3.4%      56.50 ±  5%      +7.0%      58.50 ±  5%  slabinfo.kmalloc-rcl-96.active_slabs
      2296 ±  6%      +3.4%       2373 ±  5%      +7.0%       2457 ±  5%  slabinfo.kmalloc-rcl-96.num_objs
     54.67 ±  6%      +3.4%      56.50 ±  5%      +7.0%      58.50 ±  5%  slabinfo.kmalloc-rcl-96.num_slabs
    446.17 ±  4%      -1.2%     440.83 ±  2%      -9.3%     404.80 ±  7%  slabinfo.kmem_cache.active_objs
     13.00 ±  4%      -1.3%      12.83 ±  2%      -8.5%      11.90 ±  7%  slabinfo.kmem_cache.active_slabs
    446.17 ±  4%      -1.2%     440.83 ±  2%      -9.3%     404.80 ±  7%  slabinfo.kmem_cache.num_objs
     13.00 ±  4%      -1.3%      12.83 ±  2%      -8.5%      11.90 ±  7%  slabinfo.kmem_cache.num_slabs
    884.00 ±  6%      -0.3%     881.00 ±  2%      -6.8%     823.60 ±  8%  slabinfo.kmem_cache_node.active_objs
     13.33 ±  7%      -1.3%      13.17 ±  2%      -6.3%      12.50 ±  8%  slabinfo.kmem_cache_node.active_slabs
    914.50 ±  6%      -1.3%     903.00 ±  2%      -7.2%     848.80 ±  8%  slabinfo.kmem_cache_node.num_objs
     13.33 ±  7%      -1.3%      13.17 ±  2%      -6.3%      12.50 ±  8%  slabinfo.kmem_cache_node.num_slabs
     17198            -0.2%      17170 ±  2%      +8.5%      18661        slabinfo.lsm_file_cache.active_objs
    101.17            -0.2%     101.00 ±  2%      +7.7%     109.00        slabinfo.lsm_file_cache.active_slabs
     17198            -0.2%      17170 ±  2%      +8.5%      18661        slabinfo.lsm_file_cache.num_objs
    101.17            -0.2%     101.00 ±  2%      +7.7%     109.00        slabinfo.lsm_file_cache.num_slabs
    120.50 ± 35%    -100.0%       0.00           -24.9%      90.50 ± 42%  slabinfo.mbcache.active_objs
      0.83 ± 82%    -100.0%       0.00           -52.0%       0.40 ±165%  slabinfo.mbcache.active_slabs
    120.50 ± 35%    -100.0%       0.00           -24.9%      90.50 ± 42%  slabinfo.mbcache.num_objs
      0.83 ± 82%    -100.0%       0.00           -52.0%       0.40 ±165%  slabinfo.mbcache.num_slabs
      3103            +0.0%       3103            -0.1%       3100 ±  2%  slabinfo.mm_struct.active_objs
    103.17            -0.3%     102.83            -0.4%     102.80 ±  2%  slabinfo.mm_struct.active_slabs
      3103            +0.0%       3103            -0.1%       3100 ±  2%  slabinfo.mm_struct.num_objs
    103.17            -0.3%     102.83            -0.4%     102.80 ±  2%  slabinfo.mm_struct.num_slabs
      1002 ±  5%      +1.7%       1019 ±  5%      +3.6%       1037 ±  8%  slabinfo.mnt_cache.active_objs
     19.17 ±  4%      +2.6%      19.67 ±  6%      +1.2%      19.40 ±  8%  slabinfo.mnt_cache.active_slabs
      1002 ±  5%      +1.7%       1019 ±  5%      +3.6%       1037 ±  8%  slabinfo.mnt_cache.num_objs
     19.17 ±  4%      +2.6%      19.67 ±  6%      +1.2%      19.40 ±  8%  slabinfo.mnt_cache.num_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.active_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.num_slabs
    768.00            +0.0%     768.00            +0.0%     768.00        slabinfo.names_cache.active_objs
     96.00            +0.0%      96.00            +0.0%      96.00        slabinfo.names_cache.active_slabs
    768.00            +0.0%     768.00            +0.0%     768.00        slabinfo.names_cache.num_objs
     96.00            +0.0%      96.00            +0.0%      96.00        slabinfo.names_cache.num_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.nfs_read_data.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.nfs_read_data.active_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.nfs_read_data.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.nfs_read_data.num_slabs
    124.00            +0.0%     124.00            +0.0%     124.00        slabinfo.numa_policy.active_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.numa_policy.active_slabs
    124.00            +0.0%     124.00            +0.0%     124.00        slabinfo.numa_policy.num_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.numa_policy.num_slabs
      9019            +2.0%       9197 ±  2%      +1.2%       9124 ±  4%  slabinfo.pde_opener.active_objs
     88.00            +2.1%      89.83 ±  2%      +1.2%      89.10 ±  4%  slabinfo.pde_opener.active_slabs
      9019            +2.0%       9197 ±  2%      +1.2%       9124 ±  4%  slabinfo.pde_opener.num_objs
     88.00            +2.1%      89.83 ±  2%      +1.2%      89.10 ±  4%  slabinfo.pde_opener.num_slabs
      2592            +0.0%       2592           +61.5%       4186        slabinfo.perf_event.active_objs
     96.00            +0.0%      96.00           +61.2%     154.80        slabinfo.perf_event.active_slabs
      2592            +0.0%       2592           +62.1%       4202        slabinfo.perf_event.num_objs
     96.00            +0.0%      96.00           +61.2%     154.80        slabinfo.perf_event.num_slabs
      4701 ±  4%      +2.4%       4816 ±  3%      +5.8%       4976 ±  3%  slabinfo.pid.active_objs
    146.33 ±  4%      +2.4%     149.83 ±  3%      +6.0%     155.10 ±  3%  slabinfo.pid.active_slabs
      4701 ±  4%      +2.4%       4816 ±  3%      +5.8%       4976 ±  3%  slabinfo.pid.num_objs
    146.33 ±  4%      +2.4%     149.83 ±  3%      +6.0%     155.10 ±  3%  slabinfo.pid.num_slabs
      1540 ±  4%      -1.7%       1514 ±  3%      -8.5%       1409 ±  8%  slabinfo.pool_workqueue.active_objs
     47.67 ±  3%      -1.7%      46.83 ±  4%      -9.0%      43.40 ±  8%  slabinfo.pool_workqueue.active_slabs
      1540 ±  4%      -1.7%       1514 ±  3%      -8.1%       1416 ±  8%  slabinfo.pool_workqueue.num_objs
     47.67 ±  3%      -1.7%      46.83 ±  4%      -9.0%      43.40 ±  8%  slabinfo.pool_workqueue.num_slabs
      2875 ±  2%      +2.2%       2937            +0.6%       2892 ±  2%  slabinfo.proc_dir_entry.active_objs
     67.50 ±  2%      +2.2%      69.00            +0.7%      68.00 ±  2%  slabinfo.proc_dir_entry.active_slabs
      2875 ±  2%      +2.2%       2937            +0.6%       2892 ±  2%  slabinfo.proc_dir_entry.num_objs
     67.50 ±  2%      +2.2%      69.00            +0.7%      68.00 ±  2%  slabinfo.proc_dir_entry.num_slabs
      9828            +1.0%       9930           +42.4%      13994        slabinfo.proc_inode_cache.active_objs
    200.17            +1.1%     202.33           +42.5%     285.20        slabinfo.proc_inode_cache.active_slabs
      9828            +1.0%       9930           +42.4%      13994        slabinfo.proc_inode_cache.num_objs
    200.17            +1.1%     202.33           +42.5%     285.20        slabinfo.proc_inode_cache.num_slabs
     28410            -2.3%      27757            +0.5%      28552        slabinfo.radix_tree_node.active_objs
    507.33            -2.4%     495.00            +0.4%     509.60        slabinfo.radix_tree_node.active_slabs
     28433            -2.4%      27762            +0.4%      28553        slabinfo.radix_tree_node.num_objs
    507.33            -2.4%     495.00            +0.4%     509.60        slabinfo.radix_tree_node.num_slabs
     30.00            +0.0%      30.00            +0.0%      30.00        slabinfo.request_queue.active_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.request_queue.active_slabs
     30.00            +0.0%      30.00            +0.0%      30.00        slabinfo.request_queue.num_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.request_queue.num_slabs
     51.00            +0.0%      51.00            +0.0%      51.00        slabinfo.rpc_inode_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.active_slabs
     51.00            +0.0%      51.00            +0.0%      51.00        slabinfo.rpc_inode_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.num_slabs
    640.00            +0.0%     640.00            +0.0%     640.00        slabinfo.scsi_sense_cache.active_objs
     20.00            +0.0%      20.00            +0.0%      20.00        slabinfo.scsi_sense_cache.active_slabs
    640.00            +0.0%     640.00            +0.0%     640.00        slabinfo.scsi_sense_cache.num_objs
     20.00            +0.0%      20.00            +0.0%      20.00        slabinfo.scsi_sense_cache.num_slabs
      3264            +0.0%       3264            +0.0%       3264        slabinfo.seq_file.active_objs
     96.00            +0.0%      96.00            +0.0%      96.00        slabinfo.seq_file.active_slabs
      3264            +0.0%       3264            +0.0%       3264        slabinfo.seq_file.num_objs
     96.00            +0.0%      96.00            +0.0%      96.00        slabinfo.seq_file.num_slabs
      5075 ±  3%      +1.2%       5136 ±  2%      -4.2%       4861 ±  7%  slabinfo.shmem_inode_cache.active_objs
    110.17 ±  3%      +1.2%     111.50 ±  2%      -4.7%     105.00 ±  7%  slabinfo.shmem_inode_cache.active_slabs
      5075 ±  3%      +1.2%       5136 ±  2%      -4.2%       4861 ±  7%  slabinfo.shmem_inode_cache.num_objs
    110.17 ±  3%      +1.2%     111.50 ±  2%      -4.7%     105.00 ±  7%  slabinfo.shmem_inode_cache.num_slabs
      2419 ±  2%      -3.2%       2342 ±  2%      -1.0%       2394        slabinfo.sighand_cache.active_objs
    161.00 ±  2%      -3.2%     155.83 ±  2%      -1.0%     159.40        slabinfo.sighand_cache.active_slabs
      2419 ±  2%      -3.2%       2342 ±  2%      -1.0%       2395        slabinfo.sighand_cache.num_objs
    161.00 ±  2%      -3.2%     155.83 ±  2%      -1.0%     159.40        slabinfo.sighand_cache.num_slabs
      4430 ±  2%      +2.3%       4532 ±  3%      +5.5%       4674 ±  5%  slabinfo.signal_cache.active_objs
    157.83 ±  2%      +2.3%     161.50 ±  3%      +5.5%     166.50 ±  5%  slabinfo.signal_cache.active_slabs
      4431 ±  2%      +2.3%       4532 ±  3%      +5.5%       4675 ±  5%  slabinfo.signal_cache.num_objs
    157.83 ±  2%      +2.3%     161.50 ±  3%      +5.5%     166.50 ±  5%  slabinfo.signal_cache.num_slabs
      1868 ± 18%     +19.7%       2236 ±  4%      -5.1%       1772 ± 15%  slabinfo.skbuff_ext_cache.active_objs
     44.00 ± 18%     +19.7%      52.67 ±  4%      -5.2%      41.70 ± 15%  slabinfo.skbuff_ext_cache.active_slabs
      1868 ± 18%     +19.7%       2236 ±  4%      -5.1%       1772 ± 15%  slabinfo.skbuff_ext_cache.num_objs
     44.00 ± 18%     +19.7%      52.67 ±  4%      -5.2%      41.70 ± 15%  slabinfo.skbuff_ext_cache.num_slabs
    309.83 ± 10%      -6.0%     291.17 ±  8%      -5.2%     293.80 ± 12%  slabinfo.skbuff_fclone_cache.active_objs
      9.17 ± 11%      -9.1%       8.33 ±  8%      -6.2%       8.60 ± 13%  slabinfo.skbuff_fclone_cache.active_slabs
    309.83 ± 10%      -6.0%     291.17 ±  8%      -5.2%     293.80 ± 12%  slabinfo.skbuff_fclone_cache.num_objs
      9.17 ± 11%      -9.1%       8.33 ±  8%      -6.2%       8.60 ± 13%  slabinfo.skbuff_fclone_cache.num_slabs
      4469 ±  3%      -1.4%       4405 ±  5%      -6.6%       4172 ±  5%  slabinfo.skbuff_head_cache.active_objs
    139.67 ±  3%      -1.3%     137.83 ±  4%      -6.6%     130.40 ±  5%  slabinfo.skbuff_head_cache.active_slabs
      4469 ±  3%      -1.3%       4410 ±  4%      -6.6%       4172 ±  5%  slabinfo.skbuff_head_cache.num_objs
    139.67 ±  3%      -1.3%     137.83 ±  4%      -6.6%     130.40 ±  5%  slabinfo.skbuff_head_cache.num_slabs
      3397 ±  8%      +2.7%       3489 ±  4%      -5.3%       3217 ± 12%  slabinfo.sock_inode_cache.active_objs
     86.33 ±  8%      +3.1%      89.00 ±  4%      -5.0%      82.00 ± 12%  slabinfo.sock_inode_cache.active_slabs
      3397 ±  8%      +2.7%       3489 ±  4%      -5.3%       3217 ± 12%  slabinfo.sock_inode_cache.num_objs
     86.33 ±  8%      +3.1%      89.00 ±  4%      -5.0%      82.00 ± 12%  slabinfo.sock_inode_cache.num_slabs
      1394 ±  2%      +1.2%       1411 ±  6%      -8.5%       1275 ±  8%  slabinfo.task_delay_info.active_objs
     27.33 ±  2%      +1.2%      27.67 ±  6%      -8.5%      25.00 ±  8%  slabinfo.task_delay_info.active_slabs
      1394 ±  2%      +1.2%       1411 ±  6%      -8.5%       1275 ±  8%  slabinfo.task_delay_info.num_objs
     27.33 ±  2%      +1.2%      27.67 ±  6%      -8.5%      25.00 ±  8%  slabinfo.task_delay_info.num_slabs
      1386 ±  4%      -2.7%       1350 ±  6%      -7.5%       1282 ± 10%  slabinfo.task_group.active_objs
     29.33 ±  5%      -1.7%      28.83 ±  6%      -6.9%      27.30 ± 10%  slabinfo.task_group.active_slabs
      1386 ±  4%      -2.7%       1350 ±  6%      -7.5%       1282 ± 10%  slabinfo.task_group.num_objs
     29.33 ±  5%      -1.7%      28.83 ±  6%      -6.9%      27.30 ± 10%  slabinfo.task_group.num_slabs
      1459            -3.5%       1408            +0.1%       1461        slabinfo.task_struct.active_objs
      1464            -3.4%       1414            +0.1%       1465        slabinfo.task_struct.active_slabs
      1464            -3.4%       1414            +0.1%       1465        slabinfo.task_struct.num_objs
      1464            -3.4%       1414            +0.1%       1465        slabinfo.task_struct.num_slabs
    198.33 ± 17%      -3.9%     190.67 ±  8%     +27.9%     253.60 ±  8%  slabinfo.taskstats.active_objs
      3.33 ± 22%      -5.0%       3.17 ± 11%     +56.0%       5.20 ± 11%  slabinfo.taskstats.active_slabs
    198.33 ± 17%      -3.9%     190.67 ±  8%     +27.9%     253.60 ±  8%  slabinfo.taskstats.num_objs
      3.33 ± 22%      -5.0%       3.17 ± 11%     +56.0%       5.20 ± 11%  slabinfo.taskstats.num_slabs
      3074            -0.2%       3069 ±  4%      -1.6%       3025 ±  2%  slabinfo.trace_event_file.active_objs
     66.00            -0.3%      65.83 ±  4%      -1.7%      64.90 ±  2%  slabinfo.trace_event_file.active_slabs
      3074            -0.2%       3069 ±  4%      -1.6%       3025 ±  2%  slabinfo.trace_event_file.num_objs
     66.00            -0.3%      65.83 ±  4%      -1.7%      64.90 ±  2%  slabinfo.trace_event_file.num_slabs
     33.00            +0.0%      33.00            +0.0%      33.00        slabinfo.tw_sock_TCP.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.active_slabs
     33.00            +0.0%      33.00            +0.0%      33.00        slabinfo.tw_sock_TCP.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.num_slabs
     60720 ±  2%      +1.0%      61311 ±  6%      +2.8%      62439 ±  5%  slabinfo.vm_area_struct.active_objs
      1518 ±  2%      +1.0%       1532 ±  6%      +2.9%       1562 ±  5%  slabinfo.vm_area_struct.active_slabs
     60750 ±  2%      +0.9%      61322 ±  6%      +2.9%      62501 ±  5%  slabinfo.vm_area_struct.num_objs
      1518 ±  2%      +1.0%       1532 ±  6%      +2.9%       1562 ±  5%  slabinfo.vm_area_struct.num_slabs
     13265            -4.4%      12686            +0.6%      13348        slabinfo.vmap_area.active_objs
    207.67            -1.6%     204.33            +0.4%     208.50        slabinfo.vmap_area.active_slabs
     13323            -1.7%      13101            +0.3%      13365        slabinfo.vmap_area.num_objs
    207.67            -1.6%     204.33            +0.4%     208.50        slabinfo.vmap_area.num_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.xfrm_state.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfrm_state.active_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.xfrm_state.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfrm_state.num_slabs
      0.00            +0.0        0.00            +0.1        0.05 ±299%  perf-profile.calltrace.cycles-pp.copyout.copy_page_to_iter.pipe_read.new_sync_read.vfs_read
      0.00            +0.0        0.00            +0.1        0.10 ±200%  perf-profile.calltrace.cycles-pp.cpuacct_charge.update_curr.yield_task_fair.do_sched_yield.__x64_sys_sched_yield
      0.00            +0.0        0.00            +0.1        0.10 ±200%  perf-profile.calltrace.cycles-pp.__switch_to.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      0.00            +0.0        0.00            +0.1        0.12 ±201%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.__set_current_blocked.signal_setup_done.arch_do_signal_or_restart
      0.00            +0.0        0.00            +0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.new_sync_read.vfs_read
      0.00            +0.0        0.00            +0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.file_update_time.pipe_write.new_sync_write.vfs_write.ksys_write
      0.00            +0.0        0.00            +0.4        0.37 ± 65%  perf-profile.calltrace.cycles-pp.sched_clock_cpu.update_rq_clock.yield_task_fair.do_sched_yield.__x64_sys_sched_yield
      0.00            +0.0        0.00            +0.4        0.42 ± 50%  perf-profile.calltrace.cycles-pp.___perf_sw_event.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      0.00            +0.0        0.00            +0.5        0.48 ± 33%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00            +0.0        0.00            +0.5        0.49 ± 33%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
      0.00            +0.0        0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.syscall_enter_from_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.5        0.55 ±  2%  perf-profile.calltrace.cycles-pp.fpregs_mark_activate.fpu__clear_user_states.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00            +0.0        0.00            +0.6        0.55 ±  4%  perf-profile.calltrace.cycles-pp.common_file_perm.security_file_permission.vfs_write.ksys_write.do_syscall_64
      0.00            +0.0        0.00            +0.6        0.57 ±  2%  perf-profile.calltrace.cycles-pp.__switch_to
      0.00            +0.0        0.00            +0.6        0.58 ±  2%  perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00            +0.0        0.00            +0.6        0.61 ±  5%  perf-profile.calltrace.cycles-pp._raw_read_lock_irqsave.send_sigio.kill_fasync.pipe_write.new_sync_write
      0.00            +0.0        0.00            +0.7        0.65 ±  3%  perf-profile.calltrace.cycles-pp.update_load_avg.set_next_entity.pick_next_task_fair.__schedule.schedule
      0.00            +0.0        0.00            +0.7        0.66 ±  4%  perf-profile.calltrace.cycles-pp.recalc_sigpending_tsk.recalc_sigpending.__set_task_blocked.__set_current_blocked.__x64_sys_rt_sigreturn
      0.00            +0.0        0.00            +0.7        0.66 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.7        0.67 ±  4%  perf-profile.calltrace.cycles-pp.recalc_sigpending.__set_task_blocked.__set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64
      0.00            +0.0        0.00            +0.7        0.68 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00            +0.0        0.00            +0.7        0.69 ±  3%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write.ksys_write
      0.00            +0.0        0.00            +0.7        0.70 ±  4%  perf-profile.calltrace.cycles-pp.__set_task_blocked.__set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.7        0.74 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00            +0.0        0.00            +0.8        0.76        perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.8        0.76 ±  2%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
      0.00            +0.0        0.00            +0.8        0.77 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.pipe_write.new_sync_write.vfs_write.ksys_write
      0.00            +0.0        0.00            +0.8        0.77 ±  8%  perf-profile.calltrace.cycles-pp.recalc_sigpending.dequeue_signal.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare
      0.00            +0.0        0.00            +0.8        0.77 ±  3%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter.pipe_write.new_sync_write
      0.00            +0.0        0.00            +0.8        0.80 ± 19%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__lock_task_sighand.do_send_sig_info.send_sigio_to_task.send_sigio
      0.00            +0.0        0.00            +0.8        0.81 ±  3%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.8        0.81 ±  2%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00            +0.0        0.00            +0.8        0.82 ±  3%  perf-profile.calltrace.cycles-pp.__entry_text_start
      0.00            +0.0        0.00            +0.8        0.83        perf-profile.calltrace.cycles-pp.pick_next_entity.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield
      0.00            +0.0        0.00            +0.8        0.84 ±  6%  perf-profile.calltrace.cycles-pp._raw_read_lock.kill_fasync.pipe_write.new_sync_write.vfs_write
      0.00            +0.0        0.00            +0.9        0.85 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.9        0.90 ±  4%  perf-profile.calltrace.cycles-pp.update_load_avg.put_prev_entity.pick_next_task_fair.__schedule.schedule
      0.00            +0.0        0.00            +0.9        0.91 ±  3%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter.pipe_write.new_sync_write.vfs_write
      0.00            +0.0        0.00            +0.9        0.92 ±  2%  perf-profile.calltrace.cycles-pp.save_fpregs_to_fpstate
      0.00            +0.0        0.00            +0.9        0.92 ±  4%  perf-profile.calltrace.cycles-pp.update_rq_clock.yield_task_fair.do_sched_yield.__x64_sys_sched_yield.do_syscall_64
      0.00            +0.0        0.00            +0.9        0.94 ± 18%  perf-profile.calltrace.cycles-pp.__lock_task_sighand.do_send_sig_info.send_sigio_to_task.send_sigio.kill_fasync
      0.00            +0.0        0.00            +1.0        1.03 ± 12%  perf-profile.calltrace.cycles-pp._raw_read_unlock_irqrestore.kill_fasync.pipe_write.new_sync_write.vfs_write
      0.00            +0.0        0.00            +1.0        1.04 ±  6%  perf-profile.calltrace.cycles-pp.update_curr.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield
      0.00            +0.0        0.00            +1.1        1.08 ±  3%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield
      0.00            +0.0        0.00            +1.1        1.08 ±  2%  perf-profile.calltrace.cycles-pp.__restore_fpregs_from_fpstate.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00            +0.0        0.00            +1.2        1.21        perf-profile.calltrace.cycles-pp.fpu__clear_user_states.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00            +0.0        0.00            +1.2        1.22 ±  2%  perf-profile.calltrace.cycles-pp.__switch_to_asm
      0.00            +0.0        0.00            +1.2        1.23 ±  6%  perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_write.new_sync_write.vfs_write.ksys_write
      0.00            +0.0        0.00            +1.4        1.42 ±  3%  perf-profile.calltrace.cycles-pp.__set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +1.5        1.45 ±  3%  perf-profile.calltrace.cycles-pp.put_prev_entity.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield
      0.00            +0.0        0.00            +1.5        1.53 ±  3%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.new_sync_write.vfs_write.ksys_write
      0.00            +0.0        0.00            +1.6        1.59 ±  2%  perf-profile.calltrace.cycles-pp.load_new_mm_cr3.switch_mm_irqs_off.__schedule.schedule.__x64_sys_sched_yield
      0.00            +0.0        0.00            +1.7        1.70 ±  3%  perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.new_sync_write.vfs_write.ksys_write
      0.00            +0.0        0.00            +1.8        1.82 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__set_current_blocked.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_prepare
      0.00            +0.0        0.00            +1.9        1.90 ±  4%  perf-profile.calltrace.cycles-pp.update_curr.yield_task_fair.do_sched_yield.__x64_sys_sched_yield.do_syscall_64
      0.00            +0.0        0.00            +2.2        2.19 ±  7%  perf-profile.calltrace.cycles-pp.__set_current_blocked.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00            +0.0        0.00            +2.2        2.24 ±  2%  perf-profile.calltrace.cycles-pp.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +2.3        2.26 ±  8%  perf-profile.calltrace.cycles-pp.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00            +0.0        0.00            +2.3        2.27        perf-profile.calltrace.cycles-pp.__fpu_restore_sig.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64
      0.00            +0.0        0.00            +2.3        2.31        perf-profile.calltrace.cycles-pp.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +2.3        2.34 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      0.00            +0.0        0.00            +2.5        2.48        perf-profile.calltrace.cycles-pp.copy_fpstate_to_sigframe.__setup_rt_frame.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00            +0.0        0.00            +2.9        2.94        perf-profile.calltrace.cycles-pp.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +3.1        3.12        perf-profile.calltrace.cycles-pp.__setup_rt_frame.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00            +0.0        0.00            +3.3        3.29        perf-profile.calltrace.cycles-pp.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64
      0.00            +0.0        0.00            +3.5        3.48 ±  4%  perf-profile.calltrace.cycles-pp.yield_task_fair.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +3.5        3.53        perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +4.3        4.31 ±  2%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      0.00            +0.0        0.00            +4.7        4.72        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +4.7        4.72 ±  2%  perf-profile.calltrace.cycles-pp.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +5.0        5.05        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +5.5        5.45        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      0.00            +0.0        0.00            +5.5        5.47        perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00           +13.8       13.78 ±  2%  perf-profile.calltrace.cycles-pp.inc_rlimit_ucounts.__sigqueue_alloc.__send_signal.do_send_sig_info.send_sigio_to_task
      0.00            +0.0        0.00           +13.9       13.89 ±  2%  perf-profile.calltrace.cycles-pp.dec_rlimit_ucounts.__sigqueue_free.__dequeue_signal.dequeue_signal.get_signal
      0.00            +0.0        0.00           +13.9       13.92 ±  2%  perf-profile.calltrace.cycles-pp.__sigqueue_free.__dequeue_signal.dequeue_signal.get_signal.arch_do_signal_or_restart
      0.00            +0.0        0.00           +14.1       14.09 ±  2%  perf-profile.calltrace.cycles-pp.__sigqueue_alloc.__send_signal.do_send_sig_info.send_sigio_to_task.send_sigio
      0.00            +0.0        0.00           +14.4       14.38 ±  2%  perf-profile.calltrace.cycles-pp.__dequeue_signal.dequeue_signal.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare
      0.00            +0.0        0.00           +14.9       14.94        perf-profile.calltrace.cycles-pp.__send_signal.do_send_sig_info.send_sigio_to_task.send_sigio.kill_fasync
      0.00            +0.0        0.00           +15.2       15.25 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_signal.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00            +0.0        0.00           +16.3       16.26        perf-profile.calltrace.cycles-pp.do_send_sig_info.send_sigio_to_task.send_sigio.kill_fasync.pipe_write
      0.00            +0.0        0.00           +16.5       16.51 ±  2%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00            +0.0        0.00           +16.5       16.53        perf-profile.calltrace.cycles-pp.send_sigio_to_task.send_sigio.kill_fasync.pipe_write.new_sync_write
      0.00            +0.0        0.00           +16.6       16.59        perf-profile.calltrace.cycles-pp.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00           +17.0       16.98        perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00           +17.4       17.41        perf-profile.calltrace.cycles-pp.send_sigio.kill_fasync.pipe_write.new_sync_write.vfs_write
      0.00            +0.0        0.00           +20.0       20.02        perf-profile.calltrace.cycles-pp.kill_fasync.pipe_write.new_sync_write.vfs_write.ksys_write
      0.00            +0.0        0.00           +22.0       22.03        perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00           +23.3       23.34        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00           +26.0       26.04        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00           +26.5       26.49        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00           +27.4       27.42        perf-profile.calltrace.cycles-pp.pipe_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.00            +0.0        0.00           +27.9       27.86        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00           +29.7       29.70        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00           +30.3       30.34        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00           +90.8       90.83        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00           +91.9       91.88        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.kick_process
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.intel_idle
      0.00            +0.0        0.00            +0.0        0.01 ±200%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.00            +0.0        0.00            +0.0        0.01 ±200%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.0        0.00            +0.0        0.02 ±152%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.00            +0.0        0.00            +0.0        0.02 ±153%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.00            +0.0        0.00            +0.0        0.02 ±154%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.00            +0.0        0.00            +0.0        0.02 ±156%  perf-profile.children.cycles-pp.sync_regs
      0.00            +0.0        0.00            +0.0        0.02 ±122%  perf-profile.children.cycles-pp.__wake_up_common
      0.00            +0.0        0.00            +0.0        0.02 ±100%  perf-profile.children.cycles-pp.perf_exclude_event
      0.00            +0.0        0.00            +0.0        0.02 ±100%  perf-profile.children.cycles-pp.rcu_qs
      0.00            +0.0        0.00            +0.0        0.03 ±127%  perf-profile.children.cycles-pp.cpuidle_enter
      0.00            +0.0        0.00            +0.0        0.03 ±127%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.00            +0.0        0.00            +0.0        0.03 ± 82%  perf-profile.children.cycles-pp.security_file_send_sigiotask
      0.00            +0.0        0.00            +0.0        0.04 ±126%  perf-profile.children.cycles-pp.start_secondary
      0.00            +0.0        0.00            +0.0        0.04 ±106%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.00            +0.0        0.00            +0.0        0.04 ±106%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.00            +0.0        0.00            +0.0        0.04 ±106%  perf-profile.children.cycles-pp.do_idle
      0.00            +0.0        0.00            +0.0        0.04 ± 69%  perf-profile.children.cycles-pp.__slab_free
      0.00            +0.0        0.00            +0.0        0.05 ± 33%  perf-profile.children.cycles-pp.__x64_sys_read
      0.00            +0.0        0.00            +0.0        0.05 ± 70%  perf-profile.children.cycles-pp.error_entry
      0.00            +0.0        0.00            +0.0        0.05 ± 92%  perf-profile.children.cycles-pp.__mutex_lock
      0.00            +0.0        0.00            +0.1        0.05 ± 93%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.00            +0.0        0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.rw_verify_area
      0.00            +0.0        0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.rb_next
      0.00            +0.0        0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.00            +0.0        0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.uprobe_deny_signal
      0.00            +0.0        0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.00            +0.0        0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.complete_signal
      0.00            +0.0        0.00            +0.1        0.08 ±  7%  perf-profile.children.cycles-pp.send_signal
      0.00            +0.0        0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.iov_iter_init
      0.00            +0.0        0.00            +0.1        0.08 ±  7%  perf-profile.children.cycles-pp.make_kuid
      0.00            +0.0        0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.0        0.00            +0.1        0.09 ±  6%  perf-profile.children.cycles-pp.rb_insert_color
      0.00            +0.0        0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.switch_ldt
      0.00            +0.0        0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.make_kgid
      0.00            +0.0        0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.wakeup_preempt_entity
      0.00            +0.0        0.00            +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.00            +0.0        0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      0.00            +0.0        0.00            +0.1        0.12 ± 49%  perf-profile.children.cycles-pp.try_to_wake_up
      0.00            +0.0        0.00            +0.1        0.12 ± 51%  perf-profile.children.cycles-pp.schedule_hrtimeout_range_clock
      0.00            +0.0        0.00            +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +0.0        0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.rb_erase
      0.00            +0.0        0.00            +0.1        0.13 ± 51%  perf-profile.children.cycles-pp.poll_schedule_timeout
      0.00            +0.0        0.00            +0.1        0.13 ± 49%  perf-profile.children.cycles-pp.signal_wake_up_state
      0.00            +0.0        0.00            +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.__list_add_valid
      0.00            +0.0        0.00            +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.00            +0.0        0.00            +0.1        0.13 ±  4%  perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.00            +0.0        0.00            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.00            +0.0        0.00            +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.__x64_sys_write
      0.00            +0.0        0.00            +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.anon_pipe_buf_release
      0.00            +0.0        0.00            +0.1        0.14 ± 44%  perf-profile.children.cycles-pp.do_select
      0.00            +0.0        0.00            +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.aa_file_perm
      0.00            +0.0        0.00            +0.2        0.15 ±  4%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.0        0.00            +0.2        0.16 ±  4%  perf-profile.children.cycles-pp.map_id_range_down
      0.00            +0.0        0.00            +0.2        0.16 ± 12%  perf-profile.children.cycles-pp.ktime_get
      0.00            +0.0        0.00            +0.2        0.16 ± 44%  perf-profile.children.cycles-pp.core_sys_select
      0.00            +0.0        0.00            +0.2        0.16 ±  3%  perf-profile.children.cycles-pp.check_cfs_rq_runtime
      0.00            +0.0        0.00            +0.2        0.16 ±  7%  perf-profile.children.cycles-pp.timestamp_truncate
      0.00            +0.0        0.00            +0.2        0.17 ±  4%  perf-profile.children.cycles-pp.rcu_all_qs
      0.00            +0.0        0.00            +0.2        0.17 ± 11%  perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +0.0        0.00            +0.2        0.17 ± 10%  perf-profile.children.cycles-pp.kmem_cache_free
      0.00            +0.0        0.00            +0.2        0.17 ±  7%  perf-profile.children.cycles-pp.update_process_times
      0.00            +0.0        0.00            +0.2        0.17 ±  7%  perf-profile.children.cycles-pp.tick_sched_handle
      0.00            +0.0        0.00            +0.2        0.18 ±  4%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.00            +0.0        0.00            +0.2        0.18 ± 43%  perf-profile.children.cycles-pp.kern_select
      0.00            +0.0        0.00            +0.2        0.18 ± 42%  perf-profile.children.cycles-pp.__x64_sys_select
      0.00            +0.0        0.00            +0.2        0.18 ±  4%  perf-profile.children.cycles-pp.__enqueue_entity
      0.00            +0.0        0.00            +0.2        0.19 ±  4%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.00            +0.0        0.00            +0.2        0.19 ±  8%  perf-profile.children.cycles-pp.tick_sched_timer
      0.00            +0.0        0.00            +0.2        0.21 ±  5%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.00            +0.0        0.00            +0.2        0.24 ±  8%  perf-profile.children.cycles-pp.prepare_signal
      0.00            +0.0        0.00            +0.2        0.24 ±  7%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +0.0        0.00            +0.2        0.24 ±  9%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.00            +0.0        0.00            +0.3        0.26 ± 14%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.00            +0.0        0.00            +0.3        0.26 ±  4%  perf-profile.children.cycles-pp.__clear_user
      0.00            +0.0        0.00            +0.3        0.27 ±  4%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.0        0.00            +0.3        0.28 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.0        0.00            +0.3        0.28 ±  2%  perf-profile.children.cycles-pp.__put_user_nocheck_4
      0.00            +0.0        0.00            +0.3        0.29 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.0        0.00            +0.3        0.29 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.00            +0.0        0.00            +0.3        0.30 ± 11%  perf-profile.children.cycles-pp.clear_buddies
      0.00            +0.0        0.00            +0.3        0.31 ±  2%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.00            +0.0        0.00            +0.3        0.35 ±  6%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.00            +0.0        0.00            +0.4        0.37 ±  3%  perf-profile.children.cycles-pp.__calc_delta
      0.00            +0.0        0.00            +0.4        0.38 ±  3%  perf-profile.children.cycles-pp.__get_user_nocheck_4
      0.00            +0.0        0.00            +0.4        0.43 ±  2%  perf-profile.children.cycles-pp.restore_altstack
      0.00            +0.0        0.00            +0.5        0.46 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.0        0.00            +0.5        0.46 ±  3%  perf-profile.children.cycles-pp.update_min_vruntime
      0.00            +0.0        0.00            +0.5        0.46 ±  7%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.00            +0.0        0.00            +0.5        0.46 ±  2%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
      0.00            +0.0        0.00            +0.5        0.47 ±  7%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.00            +0.0        0.00            +0.5        0.48 ±  3%  perf-profile.children.cycles-pp.copyout
      0.00            +0.0        0.00            +0.5        0.49 ±  7%  perf-profile.children.cycles-pp.cpuacct_charge
      0.00            +0.0        0.00            +0.5        0.50 ±  2%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.00            +0.0        0.00            +0.5        0.51 ±  8%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.00            +0.0        0.00            +0.5        0.52 ±  5%  perf-profile.children.cycles-pp.file_update_time
      0.00            +0.0        0.00            +0.5        0.52 ±  3%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.0        0.00            +0.5        0.53 ±  3%  perf-profile.children.cycles-pp.atime_needs_update
      0.00            +0.0        0.00            +0.5        0.53 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
      0.00            +0.0        0.00            +0.6        0.56 ±  7%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00            +0.6        0.56 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.0        0.00            +0.6        0.56 ±  2%  perf-profile.children.cycles-pp.current_time
      0.00            +0.0        0.00            +0.6        0.56        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.00            +0.0        0.00            +0.6        0.57 ±  2%  perf-profile.children.cycles-pp.__might_sleep
      0.00            +0.0        0.00            +0.6        0.58 ±  3%  perf-profile.children.cycles-pp.touch_atime
      0.00            +0.0        0.00            +0.6        0.59 ±  3%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.0        0.00            +0.6        0.61 ± 47%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.00            +0.0        0.00            +0.6        0.61 ±  5%  perf-profile.children.cycles-pp._raw_read_lock_irqsave
      0.00            +0.0        0.00            +0.6        0.62 ±  3%  perf-profile.children.cycles-pp.__fget_light
      0.00            +0.0        0.00            +0.7        0.70 ±  2%  perf-profile.children.cycles-pp.__fdget_pos
      0.00            +0.0        0.00            +0.7        0.70 ±  3%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.00            +0.0        0.00            +0.7        0.73 ±  3%  perf-profile.children.cycles-pp.recalc_sigpending_tsk
      0.00            +0.0        0.00            +0.8        0.80        perf-profile.children.cycles-pp.fsnotify
      0.00            +0.0        0.00            +0.8        0.81        perf-profile.children.cycles-pp.__might_fault
      0.00            +0.0        0.00            +0.8        0.83        perf-profile.children.cycles-pp._copy_from_user
      0.00            +0.0        0.00            +0.8        0.83 ±  3%  perf-profile.children.cycles-pp.__entry_text_start
      0.00            +0.0        0.00            +0.8        0.83 ±  2%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.00            +0.0        0.00            +0.8        0.85 ±  6%  perf-profile.children.cycles-pp._raw_read_lock
      0.00            +0.0        0.00            +0.9        0.86 ±  3%  perf-profile.children.cycles-pp.common_file_perm
      0.00            +0.0        0.00            +0.9        0.86        perf-profile.children.cycles-pp.___might_sleep
      0.00            +0.0        0.00            +0.9        0.88        perf-profile.children.cycles-pp.pick_next_entity
      0.00            +0.0        0.00            +0.9        0.92 ±  2%  perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.00            +0.0        0.00            +0.9        0.93 ±  3%  perf-profile.children.cycles-pp.copyin
      0.00            +0.0        0.00            +0.9        0.95 ± 18%  perf-profile.children.cycles-pp.__lock_task_sighand
      0.00            +0.0        0.00            +1.0        0.98        perf-profile.children.cycles-pp.fpregs_mark_activate
      0.00            +0.0        0.00            +1.0        1.01 ±  3%  perf-profile.children.cycles-pp.__set_task_blocked
      0.00            +0.0        0.00            +1.0        1.04 ±  3%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.0        0.00            +1.0        1.05 ± 12%  perf-profile.children.cycles-pp._raw_read_unlock_irqrestore
      0.00            +0.0        0.00            +1.1        1.08 ±  2%  perf-profile.children.cycles-pp.__switch_to
      0.00            +0.0        0.00            +1.1        1.10 ±  2%  perf-profile.children.cycles-pp.__restore_fpregs_from_fpstate
      0.00            +0.0        0.00            +1.1        1.15 ±  3%  perf-profile.children.cycles-pp.set_next_entity
      0.00            +0.0        0.00            +1.2        1.25        perf-profile.children.cycles-pp.fpu__clear_user_states
      0.00            +0.0        0.00            +1.3        1.33 ±  2%  perf-profile.children.cycles-pp.__switch_to_asm
      0.00            +0.0        0.00            +1.4        1.39 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.0        0.00            +1.5        1.47 ±  6%  perf-profile.children.cycles-pp.mutex_unlock
      0.00            +0.0        0.00            +1.5        1.53 ±  3%  perf-profile.children.cycles-pp.put_prev_entity
      0.00            +0.0        0.00            +1.6        1.58        perf-profile.children.cycles-pp.security_file_permission
      0.00            +0.0        0.00            +1.6        1.62 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +0.0        0.00            +1.6        1.65 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.0        0.00            +1.7        1.72 ±  4%  perf-profile.children.cycles-pp.recalc_sigpending
      0.00            +0.0        0.00            +1.8        1.75 ±  3%  perf-profile.children.cycles-pp.copy_page_from_iter
      0.00            +0.0        0.00            +1.9        1.86 ±  2%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.00            +0.0        0.00            +1.9        1.89        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.0        0.00            +2.0        2.04 ±  2%  perf-profile.children.cycles-pp.load_new_mm_cr3
      0.00            +0.0        0.00            +2.1        2.10 ±  2%  perf-profile.children.cycles-pp.mutex_lock
      0.00            +0.0        0.00            +2.3        2.25 ±  2%  perf-profile.children.cycles-pp.switch_fpu_return
      0.00            +0.0        0.00            +2.3        2.26 ±  8%  perf-profile.children.cycles-pp.signal_setup_done
      0.00            +0.0        0.00            +2.3        2.28        perf-profile.children.cycles-pp.__fpu_restore_sig
      0.00            +0.0        0.00            +2.3        2.31        perf-profile.children.cycles-pp.fpu__restore_sig
      0.00            +0.0        0.00            +2.5        2.51        perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.00            +0.0        0.00            +2.9        2.94        perf-profile.children.cycles-pp.restore_sigcontext
      0.00            +0.0        0.00            +3.1        3.13        perf-profile.children.cycles-pp.__setup_rt_frame
      0.00            +0.0        0.00            +3.2        3.17 ±  2%  perf-profile.children.cycles-pp.update_curr
      0.00            +0.0        0.00            +3.2        3.24 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.00            +0.0        0.00            +3.3        3.32        perf-profile.children.cycles-pp.pipe_read
      0.00            +0.0        0.00            +3.5        3.50 ±  4%  perf-profile.children.cycles-pp.yield_task_fair
      0.00            +0.0        0.00            +3.5        3.54        perf-profile.children.cycles-pp.new_sync_read
      0.00            +0.0        0.00            +3.7        3.66 ±  4%  perf-profile.children.cycles-pp.__set_current_blocked
      0.00            +0.0        0.00            +4.3        4.35 ±  2%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.00            +0.0        0.00            +4.7        4.69        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.0        0.00            +4.7        4.73 ±  2%  perf-profile.children.cycles-pp.do_sched_yield
      0.00            +0.0        0.00            +4.7        4.73        perf-profile.children.cycles-pp.vfs_read
      0.00            +0.0        0.00            +5.1        5.06        perf-profile.children.cycles-pp.ksys_read
      0.00            +0.0        0.00            +5.5        5.48        perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
      0.00            +0.0        0.00            +5.7        5.70        perf-profile.children.cycles-pp.pick_next_task_fair
      0.00            +0.0        0.00           +13.8       13.78 ±  2%  perf-profile.children.cycles-pp.inc_rlimit_ucounts
      0.00            +0.0        0.00           +13.9       13.89 ±  2%  perf-profile.children.cycles-pp.dec_rlimit_ucounts
      0.00            +0.0        0.00           +13.9       13.93 ±  2%  perf-profile.children.cycles-pp.__sigqueue_free
      0.00            +0.0        0.00           +14.1       14.10 ±  2%  perf-profile.children.cycles-pp.__sigqueue_alloc
      0.00            +0.0        0.00           +14.4       14.39 ±  2%  perf-profile.children.cycles-pp.__dequeue_signal
      0.00            +0.0        0.00           +15.0       15.00        perf-profile.children.cycles-pp.__send_signal
      0.00            +0.0        0.00           +15.3       15.26 ±  2%  perf-profile.children.cycles-pp.dequeue_signal
      0.00            +0.0        0.00           +16.3       16.29        perf-profile.children.cycles-pp.do_send_sig_info
      0.00            +0.0        0.00           +16.5       16.54 ±  2%  perf-profile.children.cycles-pp.get_signal
      0.00            +0.0        0.00           +16.6       16.55        perf-profile.children.cycles-pp.send_sigio_to_task
      0.00            +0.0        0.00           +16.8       16.79        perf-profile.children.cycles-pp.__schedule
      0.00            +0.0        0.00           +17.1       17.10        perf-profile.children.cycles-pp.schedule
      0.00            +0.0        0.00           +17.4       17.42        perf-profile.children.cycles-pp.send_sigio
      0.00            +0.0        0.00           +20.0       20.04        perf-profile.children.cycles-pp.kill_fasync
      0.00            +0.0        0.00           +22.1       22.06        perf-profile.children.cycles-pp.__x64_sys_sched_yield
      0.00            +0.0        0.00           +23.4       23.35        perf-profile.children.cycles-pp.arch_do_signal_or_restart
      0.00            +0.0        0.00           +26.1       26.10        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.00            +0.0        0.00           +26.6       26.58        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.0        0.00           +27.5       27.46        perf-profile.children.cycles-pp.pipe_write
      0.00            +0.0        0.00           +27.9       27.90        perf-profile.children.cycles-pp.new_sync_write
      0.00            +0.0        0.00           +29.8       29.75        perf-profile.children.cycles-pp.vfs_write
      0.00            +0.0        0.00           +30.4       30.36        perf-profile.children.cycles-pp.ksys_write
      0.00            +0.0        0.00           +91.0       90.97        perf-profile.children.cycles-pp.do_syscall_64
      0.00            +0.0        0.00           +92.0       91.96        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.__sigqueue_free
      0.00            +0.0        0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.intel_idle
      0.00            +0.0        0.00            +0.0        0.01 ±200%  perf-profile.self.cycles-pp.security_file_send_sigiotask
      0.00            +0.0        0.00            +0.0        0.01 ±200%  perf-profile.self.cycles-pp.touch_atime
      0.00            +0.0        0.00            +0.0        0.01 ±200%  perf-profile.self.cycles-pp.__wake_up_common
      0.00            +0.0        0.00            +0.0        0.01 ±202%  perf-profile.self.cycles-pp.sync_regs
      0.00            +0.0        0.00            +0.0        0.02 ±154%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.00            +0.0        0.00            +0.0        0.03 ±100%  perf-profile.self.cycles-pp.__x64_sys_read
      0.00            +0.0        0.00            +0.0        0.04 ± 67%  perf-profile.self.cycles-pp.__set_task_blocked
      0.00            +0.0        0.00            +0.0        0.04 ± 69%  perf-profile.self.cycles-pp.__slab_free
      0.00            +0.0        0.00            +0.1        0.05 ± 34%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.00            +0.0        0.00            +0.1        0.05 ±  5%  perf-profile.self.cycles-pp.rw_verify_area
      0.00            +0.0        0.00            +0.1        0.05 ± 12%  perf-profile.self.cycles-pp.complete_signal
      0.00            +0.0        0.00            +0.1        0.05 ±  9%  perf-profile.self.cycles-pp.rb_next
      0.00            +0.0        0.00            +0.1        0.06 ± 10%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.00            +0.0        0.00            +0.1        0.06 ±  5%  perf-profile.self.cycles-pp.restore_altstack
      0.00            +0.0        0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.uprobe_deny_signal
      0.00            +0.0        0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.rcu_note_context_switch
      0.00            +0.0        0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.00            +0.0        0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.send_signal
      0.00            +0.0        0.00            +0.1        0.07        perf-profile.self.cycles-pp.ksys_read
      0.00            +0.0        0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.iov_iter_init
      0.00            +0.0        0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp._copy_from_user
      0.00            +0.0        0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.wakeup_preempt_entity
      0.00            +0.0        0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.copyin
      0.00            +0.0        0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.check_cfs_rq_runtime
      0.00            +0.0        0.00            +0.1        0.08 ±  7%  perf-profile.self.cycles-pp.rb_insert_color
      0.00            +0.0        0.00            +0.1        0.09 ±  6%  perf-profile.self.cycles-pp.__fdget_pos
      0.00            +0.0        0.00            +0.1        0.09 ±  9%  perf-profile.self.cycles-pp.__wake_up_common_lock
      0.00            +0.0        0.00            +0.1        0.09 ±  6%  perf-profile.self.cycles-pp.switch_ldt
      0.00            +0.0        0.00            +0.1        0.10        perf-profile.self.cycles-pp.rb_erase
      0.00            +0.0        0.00            +0.1        0.10 ±  6%  perf-profile.self.cycles-pp.dequeue_signal
      0.00            +0.0        0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.00            +0.0        0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.rcu_read_unlock_strict
      0.00            +0.0        0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.00            +0.0        0.00            +0.1        0.12 ±  7%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.0        0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.00            +0.0        0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.aa_file_perm
      0.00            +0.0        0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.__list_add_valid
      0.00            +0.0        0.00            +0.1        0.13 ±  9%  perf-profile.self.cycles-pp.__x64_sys_write
      0.00            +0.0        0.00            +0.1        0.13        perf-profile.self.cycles-pp.__irqentry_text_end
      0.00            +0.0        0.00            +0.1        0.13 ±  4%  perf-profile.self.cycles-pp.restore_sigcontext
      0.00            +0.0        0.00            +0.1        0.13 ± 18%  perf-profile.self.cycles-pp.__set_current_blocked
      0.00            +0.0        0.00            +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.atime_needs_update
      0.00            +0.0        0.00            +0.1        0.14 ±  4%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.0        0.00            +0.1        0.14 ±  6%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.00            +0.0        0.00            +0.1        0.14 ± 12%  perf-profile.self.cycles-pp.__lock_task_sighand
      0.00            +0.0        0.00            +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.00            +0.0        0.00            +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.rcu_all_qs
      0.00            +0.0        0.00            +0.1        0.15 ± 13%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.0        0.00            +0.1        0.15 ±  4%  perf-profile.self.cycles-pp.map_id_range_down
      0.00            +0.0        0.00            +0.1        0.15 ±  8%  perf-profile.self.cycles-pp.timestamp_truncate
      0.00            +0.0        0.00            +0.2        0.16 ±  5%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.00            +0.0        0.00            +0.2        0.16 ±  4%  perf-profile.self.cycles-pp.__enqueue_entity
      0.00            +0.0        0.00            +0.2        0.16 ±  4%  perf-profile.self.cycles-pp.arch_do_signal_or_restart
      0.00            +0.0        0.00            +0.2        0.17 ±  3%  perf-profile.self.cycles-pp.ksys_write
      0.00            +0.0        0.00            +0.2        0.17 ±  2%  perf-profile.self.cycles-pp.__sigqueue_alloc
      0.00            +0.0        0.00            +0.2        0.17 ±  5%  perf-profile.self.cycles-pp.finish_task_switch
      0.00            +0.0        0.00            +0.2        0.18 ±  4%  perf-profile.self.cycles-pp.do_send_sig_info
      0.00            +0.0        0.00            +0.2        0.18 ±  3%  perf-profile.self.cycles-pp.__x64_sys_rt_sigreturn
      0.00            +0.0        0.00            +0.2        0.18 ±  6%  perf-profile.self.cycles-pp.__might_fault
      0.00            +0.0        0.00            +0.2        0.18 ±  3%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.00            +0.0        0.00            +0.2        0.19 ±  6%  perf-profile.self.cycles-pp.file_update_time
      0.00            +0.0        0.00            +0.2        0.20 ±  4%  perf-profile.self.cycles-pp.current_time
      0.00            +0.0        0.00            +0.2        0.20 ±  6%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.00            +0.0        0.00            +0.2        0.20 ±  3%  perf-profile.self.cycles-pp.new_sync_read
      0.00            +0.0        0.00            +0.2        0.20 ±  3%  perf-profile.self.cycles-pp.send_sigio
      0.00            +0.0        0.00            +0.2        0.20 ± 20%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.00            +0.0        0.00            +0.2        0.21 ±  2%  perf-profile.self.cycles-pp.get_signal
      0.00            +0.0        0.00            +0.2        0.21 ±  5%  perf-profile.self.cycles-pp.put_prev_entity
      0.00            +0.0        0.00            +0.2        0.21 ±  5%  perf-profile.self.cycles-pp.send_sigio_to_task
      0.00            +0.0        0.00            +0.2        0.22 ±  9%  perf-profile.self.cycles-pp.prepare_signal
      0.00            +0.0        0.00            +0.2        0.22 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.0        0.00            +0.2        0.23 ±  3%  perf-profile.self.cycles-pp.__clear_user
      0.00            +0.0        0.00            +0.2        0.24 ±  8%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.00            +0.0        0.00            +0.3        0.25 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.0        0.00            +0.3        0.25 ±  2%  perf-profile.self.cycles-pp.vfs_read
      0.00            +0.0        0.00            +0.3        0.26 ±  5%  perf-profile.self.cycles-pp.__dequeue_signal
      0.00            +0.0        0.00            +0.3        0.26 ±  7%  perf-profile.self.cycles-pp.set_next_entity
      0.00            +0.0        0.00            +0.3        0.28 ±  2%  perf-profile.self.cycles-pp.__put_user_nocheck_4
      0.00            +0.0        0.00            +0.3        0.28 ±  2%  perf-profile.self.cycles-pp.pipe_read
      0.00            +0.0        0.00            +0.3        0.28 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.0        0.00            +0.3        0.28 ± 13%  perf-profile.self.cycles-pp.clear_buddies
      0.00            +0.0        0.00            +0.3        0.31 ±  2%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.00            +0.0        0.00            +0.3        0.32 ±  5%  perf-profile.self.cycles-pp.copy_page_from_iter
      0.00            +0.0        0.00            +0.3        0.32 ±  2%  perf-profile.self.cycles-pp.schedule
      0.00            +0.0        0.00            +0.3        0.33 ±  3%  perf-profile.self.cycles-pp.__x64_sys_sched_yield
      0.00            +0.0        0.00            +0.3        0.33 ±  5%  perf-profile.self.cycles-pp.do_sched_yield
      0.00            +0.0        0.00            +0.3        0.34 ±  7%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.00            +0.0        0.00            +0.4        0.36 ±  3%  perf-profile.self.cycles-pp.__calc_delta
      0.00            +0.0        0.00            +0.4        0.37 ±  3%  perf-profile.self.cycles-pp.__get_user_nocheck_4
      0.00            +0.0        0.00            +0.4        0.37 ±  4%  perf-profile.self.cycles-pp.new_sync_write
      0.00            +0.0        0.00            +0.4        0.42 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.0        0.00            +0.4        0.42 ± 10%  perf-profile.self.cycles-pp.yield_task_fair
      0.00            +0.0        0.00            +0.4        0.44 ±  2%  perf-profile.self.cycles-pp.copy_user_generic_unrolled
      0.00            +0.0        0.00            +0.4        0.44 ±  3%  perf-profile.self.cycles-pp.update_min_vruntime
      0.00            +0.0        0.00            +0.4        0.45 ±  4%  perf-profile.self.cycles-pp.__send_signal
      0.00            +0.0        0.00            +0.4        0.45 ±  5%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.0        0.00            +0.5        0.46 ±  4%  perf-profile.self.cycles-pp.___perf_sw_event
      0.00            +0.0        0.00            +0.5        0.48 ±  3%  perf-profile.self.cycles-pp.security_file_permission
      0.00            +0.0        0.00            +0.5        0.48 ±  2%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.00            +0.0        0.00            +0.5        0.48 ±  7%  perf-profile.self.cycles-pp.cpuacct_charge
      0.00            +0.0        0.00            +0.5        0.49 ±  2%  perf-profile.self.cycles-pp.__get_user_nocheck_8
      0.00            +0.0        0.00            +0.5        0.50 ±  2%  perf-profile.self.cycles-pp.__might_sleep
      0.00            +0.0        0.00            +0.5        0.51 ±  3%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.0        0.00            +0.5        0.52        perf-profile.self.cycles-pp.do_syscall_64
      0.00            +0.0        0.00            +0.5        0.54        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.00            +0.0        0.00            +0.5        0.55 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.00            +0.0        0.00            +0.6        0.60 ±  2%  perf-profile.self.cycles-pp.__setup_rt_frame
      0.00            +0.0        0.00            +0.6        0.60 ±  3%  perf-profile.self.cycles-pp.__fget_light
      0.00            +0.0        0.00            +0.6        0.60 ±  2%  perf-profile.self.cycles-pp.vfs_write
      0.00            +0.0        0.00            +0.6        0.61 ± 47%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.00            +0.0        0.00            +0.6        0.61 ±  5%  perf-profile.self.cycles-pp._raw_read_lock_irqsave
      0.00            +0.0        0.00            +0.7        0.65 ±  6%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.0        0.00            +0.7        0.71 ±  3%  perf-profile.self.cycles-pp.common_file_perm
      0.00            +0.0        0.00            +0.7        0.72 ±  3%  perf-profile.self.cycles-pp.recalc_sigpending_tsk
      0.00            +0.0        0.00            +0.7        0.73 ±  2%  perf-profile.self.cycles-pp.pick_next_entity
      0.00            +0.0        0.00            +0.7        0.73 ±  2%  perf-profile.self.cycles-pp.fpu__clear_user_states
      0.00            +0.0        0.00            +0.7        0.73 ±  6%  perf-profile.self.cycles-pp.kill_fasync
      0.00            +0.0        0.00            +0.8        0.76        perf-profile.self.cycles-pp.fsnotify
      0.00            +0.0        0.00            +0.8        0.83 ±  3%  perf-profile.self.cycles-pp.__entry_text_start
      0.00            +0.0        0.00            +0.8        0.84 ±  2%  perf-profile.self.cycles-pp.pipe_write
      0.00            +0.0        0.00            +0.8        0.84 ±  6%  perf-profile.self.cycles-pp._raw_read_lock
      0.00            +0.0        0.00            +0.8        0.85        perf-profile.self.cycles-pp.___might_sleep
      0.00            +0.0        0.00            +0.9        0.92 ±  2%  perf-profile.self.cycles-pp.save_fpregs_to_fpstate
      0.00            +0.0        0.00            +0.9        0.92 ±  3%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.00            +0.0        0.00            +0.9        0.93        perf-profile.self.cycles-pp.fpregs_mark_activate
      0.00            +0.0        0.00            +0.9        0.94 ± 13%  perf-profile.self.cycles-pp._raw_read_unlock_irqrestore
      0.00            +0.0        0.00            +1.0        1.00        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +1.0        1.00 ±  6%  perf-profile.self.cycles-pp.recalc_sigpending
      0.00            +0.0        0.00            +1.0        1.04 ±  2%  perf-profile.self.cycles-pp.__switch_to
      0.00            +0.0        0.00            +1.1        1.09 ±  2%  perf-profile.self.cycles-pp.__restore_fpregs_from_fpstate
      0.00            +0.0        0.00            +1.1        1.14 ±  2%  perf-profile.self.cycles-pp.switch_fpu_return
      0.00            +0.0        0.00            +1.2        1.17 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.0        0.00            +1.2        1.23 ±  4%  perf-profile.self.cycles-pp.update_curr
      0.00            +0.0        0.00            +1.3        1.27        perf-profile.self.cycles-pp.__fpu_restore_sig
      0.00            +0.0        0.00            +1.3        1.29 ±  2%  perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +0.0        0.00            +1.4        1.43        perf-profile.self.cycles-pp.copy_fpstate_to_sigframe
      0.00            +0.0        0.00            +1.4        1.45 ±  6%  perf-profile.self.cycles-pp.mutex_unlock
      0.00            +0.0        0.00            +1.6        1.59 ±  3%  perf-profile.self.cycles-pp.mutex_lock
      0.00            +0.0        0.00            +1.6        1.62 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.0        0.00            +1.8        1.82 ±  2%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.00            +0.0        0.00            +1.9        1.88        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00            +0.0        0.00            +2.0        2.03 ±  2%  perf-profile.self.cycles-pp.load_new_mm_cr3
      0.00            +0.0        0.00            +2.3        2.29 ±  2%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.00            +0.0        0.00            +2.5        2.46 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.00            +0.0        0.00            +3.2        3.23 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.0        0.00            +4.3        4.28 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.0        0.00           +13.8       13.78 ±  2%  perf-profile.self.cycles-pp.inc_rlimit_ucounts
      0.00            +0.0        0.00           +13.9       13.88 ±  2%  perf-profile.self.cycles-pp.dec_rlimit_ucounts
    629.83 ±  7%     -37.1%     396.33            -3.6%     607.40 ±  2%  softirqs.BLOCK
     13.33 ± 68%     -48.8%       6.83 ± 87%     -65.5%       4.60 ±142%  softirqs.CPU0.BLOCK
      1.00            +0.0%       1.00            +0.0%       1.00        softirqs.CPU0.HI
      0.33 ±141%      +0.0%       0.33 ±141%    +980.0%       3.60 ±162%  softirqs.CPU0.NET_RX
      0.17 ±223%    -100.0%       0.00          +500.0%       1.00 ±268%  softirqs.CPU0.NET_TX
      8456 ± 12%     -53.8%       3910 ± 23%      -5.5%       7991 ±  9%  softirqs.CPU0.RCU
      7124 ± 11%     -13.0%       6197 ± 12%      +9.8%       7820 ± 12%  softirqs.CPU0.SCHED
    105.00            +5.4%     110.67 ± 11%      +0.8%     105.80        softirqs.CPU0.TASKLET
    551.67 ±  9%     -10.6%     493.00 ± 10%     +31.6%     726.00 ± 48%  softirqs.CPU0.TIMER
      8.67 ±143%     +73.1%      15.00 ±128%      -0.8%       8.60 ±153%  softirqs.CPU1.BLOCK
      2.50 ±172%     +60.0%       4.00 ±201%     -56.0%       1.10 ±131%  softirqs.CPU1.NET_RX
      0.50 ±152%    -100.0%       0.00           -60.0%       0.20 ±200%  softirqs.CPU1.NET_TX
      7835 ± 17%     -63.2%       2883 ± 22%     -15.3%       6637 ± 11%  softirqs.CPU1.RCU
      5643 ± 10%     -29.9%       3957 ± 27%     -11.2%       5010 ± 21%  softirqs.CPU1.SCHED
      0.00       +1.7e+101%       0.17 ±223%   +8e+101%       0.80 ±229%  softirqs.CPU1.TASKLET
    166.50 ± 85%     -77.3%      37.83 ± 43%     +58.0%     263.00 ±190%  softirqs.CPU1.TIMER
      2.50 ±130%     -20.0%       2.00 ±223%     -68.0%       0.80 ±300%  softirqs.CPU10.BLOCK
      1.17 ± 31%      +0.0%       1.17 ± 31%     +11.4%       1.30 ± 35%  softirqs.CPU10.HI
      1.00 ±223%    +100.0%       2.00 ±160%     -10.0%       0.90 ±182%  softirqs.CPU10.NET_RX
      0.00       +1.7e+101%       0.17 ±223%   +1e+101%       0.10 ±300%  softirqs.CPU10.NET_TX
      6951 ± 17%     -78.7%       1479 ± 41%     -12.3%       6096 ± 12%  softirqs.CPU10.RCU
      2989 ± 22%     -31.3%       2053 ±  7%      -3.3%       2892 ±  8%  softirqs.CPU10.SCHED
     36.50 ±  2%      -0.9%      36.17            +5.2%      38.40 ± 16%  softirqs.CPU10.TASKLET
    453.83 ±157%     -70.6%     133.50 ±159%     -79.1%      95.00 ± 87%  softirqs.CPU10.TIMER
      0.17 ±223%    -100.0%       0.00           -40.0%       0.10 ±300%  softirqs.CPU11.BLOCK
      4.33 ±194%     -76.9%       1.00 ±182%    +352.3%      19.60 ±291%  softirqs.CPU11.NET_RX
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU11.NET_TX
      6593 ± 20%     -87.4%     828.17 ± 26%      -8.9%       6007 ± 10%  softirqs.CPU11.RCU
      2745 ± 20%     -33.6%       1823 ±  4%      -0.7%       2725 ±  9%  softirqs.CPU11.SCHED
      2.00            +0.0%       2.00            +0.0%       2.00        softirqs.CPU11.TASKLET
     77.50 ± 64%     -69.0%      24.00 ± 59%     -32.4%      52.40 ± 63%  softirqs.CPU11.TIMER
      1.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU12.BLOCK
      0.50 ±100%   +2133.3%      11.17 ±223%   +4540.0%      23.20 ±287%  softirqs.CPU12.NET_RX
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU12.NET_TX
      6240 ± 27%     -85.8%     885.00 ± 19%      -2.4%       6091 ± 10%  softirqs.CPU12.RCU
      2455 ± 14%     -21.2%       1935 ± 11%     +28.6%       3156 ± 17%  softirqs.CPU12.SCHED
      3.67 ±101%     -54.5%       1.67 ± 44%     +25.5%       4.60 ±169%  softirqs.CPU12.TASKLET
     68.50 ± 53%     -38.0%      42.50 ±109%     +42.8%      97.80 ± 42%  softirqs.CPU12.TIMER
     59.00 ±223%     -96.6%       2.00 ±202%     -99.0%       0.60 ±300%  softirqs.CPU13.BLOCK
      2.50 ±152%     -66.7%       0.83 ±128%    +592.0%      17.30 ±290%  softirqs.CPU13.NET_RX
      0.00       +1.7e+101%       0.17 ±223%   +3e+101%       0.30 ±152%  softirqs.CPU13.NET_TX
      6500 ± 15%     -82.5%       1139 ± 62%      -7.2%       6032 ± 12%  softirqs.CPU13.RCU
      3092 ± 15%     -38.3%       1907 ± 14%      +8.1%       3342 ± 28%  softirqs.CPU13.SCHED
      1.33 ± 70%     +25.0%       1.67 ± 44%     +50.0%       2.00        softirqs.CPU13.TASKLET
    411.33 ±159%     -94.5%      22.67 ± 20%     -16.5%     343.30 ±181%  softirqs.CPU13.TIMER
      0.00       +3.1e+103%      31.17 ±223%   +3e+101%       0.30 ±213%  softirqs.CPU14.BLOCK
    869.67 ±144%     -98.5%      12.67 ±195%     -99.7%       2.80 ±209%  softirqs.CPU14.NET_RX
      0.00          -100.0%       0.00         +4e+101%       0.40 ±165%  softirqs.CPU14.NET_TX
      6317 ± 16%     -72.2%       1757 ± 67%      -6.4%       5914 ±  8%  softirqs.CPU14.RCU
      2717 ± 11%     -30.4%       1890 ± 10%      +5.6%       2870 ± 13%  softirqs.CPU14.SCHED
      1.33 ± 70%     +25.0%       1.67 ± 44%     +65.0%       2.20 ± 53%  softirqs.CPU14.TASKLET
    194.67 ±100%      -9.8%     175.50 ±188%     -73.6%      51.40 ± 43%  softirqs.CPU14.TIMER
      0.17 ±223%  +24200.0%      40.50 ±223%    +560.0%       1.10 ±216%  softirqs.CPU15.BLOCK
     12.83 ±206%     -79.2%       2.67 ±107%     -93.0%       0.90 ±135%  softirqs.CPU15.NET_RX
      0.00       +3.3e+101%       0.33 ±141%   +1e+101%       0.10 ±300%  softirqs.CPU15.NET_TX
      6167 ± 18%     -78.1%       1352 ± 45%      -3.2%       5970 ±  9%  softirqs.CPU15.RCU
      2865 ± 17%     -17.6%       2361 ± 25%      -4.1%       2746 ± 13%  softirqs.CPU15.SCHED
      1.33 ± 70%      +0.0%       1.33 ± 70%     +35.0%       1.80 ± 33%  softirqs.CPU15.TASKLET
    558.83 ±124%     -34.4%     366.33 ±200%     -85.1%      83.40 ±147%  softirqs.CPU15.TIMER
     36.17 ±223%     -99.1%       0.33 ±223%     +29.4%      46.80 ±285%  softirqs.CPU16.BLOCK
      1.50 ±113%     -55.6%       0.67 ±141%     +66.7%       2.50 ±180%  softirqs.CPU16.NET_RX
      1.00 ± 81%     -83.3%       0.17 ±223%     -70.0%       0.30 ±152%  softirqs.CPU16.NET_TX
      6968 ± 14%     -79.4%       1432 ± 24%      -5.5%       6586 ± 11%  softirqs.CPU16.RCU
      2401 ±  7%     -14.4%       2056 ± 27%     +22.6%       2943 ± 17%  softirqs.CPU16.SCHED
      1.33 ± 70%     -50.0%       0.67 ±141%     -25.0%       1.00 ±100%  softirqs.CPU16.TASKLET
     75.00 ± 15%    +283.1%     287.33 ±203%     +15.9%      86.90 ± 41%  softirqs.CPU16.TIMER
      0.00         +6e+103%      60.33 ±151% +7.2e+103%      71.80 ±158%  softirqs.CPU17.BLOCK
    620.17 ±223%     -99.0%       6.00 ±208%     -99.7%       1.60 ±134%  softirqs.CPU17.NET_RX
      0.33 ±141%    -100.0%       0.00           -10.0%       0.30 ±213%  softirqs.CPU17.NET_TX
      7048 ± 22%     -81.4%       1310 ± 40%      -7.5%       6518 ± 10%  softirqs.CPU17.RCU
      2285 ± 15%     -15.4%       1932 ± 10%     +27.9%       2921 ± 13%  softirqs.CPU17.SCHED
      0.67 ±141%    -100.0%       0.00          +110.0%       1.40 ±277%  softirqs.CPU17.TASKLET
     77.83 ± 27%     -63.0%      28.83 ± 56%     +21.7%      94.70 ± 51%  softirqs.CPU17.TIMER
    125.00 ±137%     -47.5%      65.67 ±136%     +39.2%     174.00 ± 87%  softirqs.CPU18.BLOCK
      5.33 ±139%     -71.9%       1.50 ±142%     -88.8%       0.60 ±133%  softirqs.CPU18.NET_RX
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU18.NET_TX
      6767 ± 19%     -82.5%       1182 ± 46%      -4.5%       6464 ± 10%  softirqs.CPU18.RCU
      2352 ±  8%      -7.7%       2170 ± 26%     +32.2%       3110 ± 15%  softirqs.CPU18.SCHED
      0.00       +3.3e+101%       0.33 ±223%    -100.0%       0.00        softirqs.CPU18.TASKLET
    100.17 ± 73%    +218.6%     319.17 ±205%     +48.3%     148.50 ± 92%  softirqs.CPU18.TIMER
    120.33 ±141%    -100.0%       0.00           -99.1%       1.10 ±224%  softirqs.CPU19.BLOCK
      0.33 ±141%    +450.0%       1.83 ±155%  +3.7e+05%       1245 ±218%  softirqs.CPU19.NET_RX
      0.17 ±223%    +200.0%       0.50 ±100%     +20.0%       0.20 ±200%  softirqs.CPU19.NET_TX
      6639 ± 18%     -78.2%       1445 ± 58%      +2.6%       6808 ± 14%  softirqs.CPU19.RCU
      2519 ± 11%     -29.7%       1771 ±  9%     +45.0%       3654 ± 28%  softirqs.CPU19.SCHED
      3.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU19.TASKLET
    154.83 ± 65%     -81.8%      28.17 ± 54%    +187.1%     444.50 ±174%  softirqs.CPU19.TIMER
      3.33 ±145%     +35.0%       4.50 ±223%     +50.0%       5.00 ±163%  softirqs.CPU2.BLOCK
     20.33 ±221%     -22.1%      15.83 ±217%     -96.6%       0.70 ±111%  softirqs.CPU2.NET_RX
      0.00       +1.7e+101%       0.17 ±223% +1.2e+102%       1.20 ±273%  softirqs.CPU2.NET_TX
      6941 ± 20%     -73.6%       1831 ± 20%      +4.6%       7258 ± 27%  softirqs.CPU2.RCU
      3238 ±  5%     -10.6%       2894 ±  9%     +20.2%       3893 ± 21%  softirqs.CPU2.SCHED
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU2.TASKLET
     71.00 ± 43%    +286.9%     274.67 ±120%    +569.2%     475.10 ±131%  softirqs.CPU2.TIMER
      0.00       +1.3e+102%       1.33 ±223%   +6e+101%       0.60 ±300%  softirqs.CPU20.BLOCK
     15.00 ±138%     -80.0%       3.00 ±180%     -54.0%       6.90 ±170%  softirqs.CPU20.NET_RX
      0.83 ± 82%     -80.0%       0.17 ±223%     +44.0%       1.20 ±229%  softirqs.CPU20.NET_TX
      6882 ± 18%     -84.0%       1098 ± 26%      +3.3%       7109 ± 15%  softirqs.CPU20.RCU
      2466 ±  5%     -23.8%       1879 ± 12%     +25.6%       3097 ± 16%  softirqs.CPU20.SCHED
      5.17 ±223%    -100.0%       0.00           -92.3%       0.40 ±300%  softirqs.CPU20.TASKLET
     87.33 ± 51%     -38.2%      54.00 ± 59%     +58.2%     138.20 ±102%  softirqs.CPU20.TIMER
      0.00         +3e+102%       3.00 ±152%    -100.0%       0.00        softirqs.CPU21.BLOCK
      0.50 ±100%   +1466.7%       7.83 ±212%   +4040.0%      20.70 ±269%  softirqs.CPU21.NET_RX
      0.17 ±223%    +100.0%       0.33 ±223%    +140.0%       0.40 ±165%  softirqs.CPU21.NET_TX
      6947 ± 16%     -85.1%       1036 ± 20%      -8.3%       6371 ± 10%  softirqs.CPU21.RCU
      2526 ±  7%     -27.4%       1834 ±  8%     +10.6%       2794 ± 10%  softirqs.CPU21.SCHED
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU21.TASKLET
     60.17 ± 34%     -59.8%      24.17 ± 33%     +25.3%      75.40 ± 53%  softirqs.CPU21.TIMER
      0.00       +1.3e+102%       1.33 ±223%   +9e+101%       0.90 ±265%  softirqs.CPU22.BLOCK
      1.33 ±223%  +10775.0%     145.00 ±222%    +755.0%      11.40 ±196%  softirqs.CPU22.NET_RX
      0.17 ±223%    +100.0%       0.33 ±223%     +20.0%       0.20 ±200%  softirqs.CPU22.NET_TX
      6841 ± 17%     -81.2%       1285 ± 67%      +3.3%       7065 ± 19%  softirqs.CPU22.RCU
      2390 ±  8%     -10.2%       2147 ± 27%     +22.6%       2930 ± 14%  softirqs.CPU22.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU22.TASKLET
     57.83 ± 31%     -64.8%      20.33 ± 58%    +238.0%     195.50 ±177%  softirqs.CPU22.TIMER
      0.00       +1.3e+102%       1.33 ±223% +1.6e+102%       1.60 ±200%  softirqs.CPU23.BLOCK
      0.50 ±100%    +166.7%       1.33 ±192%    +300.0%       2.00 ±139%  softirqs.CPU23.NET_RX
      0.17 ±223%    -100.0%       0.00           -40.0%       0.10 ±300%  softirqs.CPU23.NET_TX
      6960 ± 21%     -78.9%       1467 ± 43%      -6.0%       6540 ±  8%  softirqs.CPU23.RCU
      2670 ± 17%      -5.8%       2515 ± 32%     +10.2%       2941 ±  9%  softirqs.CPU23.SCHED
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU23.TASKLET
    116.33 ± 55%    +332.1%     502.67 ±209%     -38.6%      71.40 ± 37%  softirqs.CPU23.TIMER
      7.17 ±223%     -93.0%       0.50 ±152%    -100.0%       0.00        softirqs.CPU24.BLOCK
     45.17 ±162%     -75.6%      11.00 ± 13%     -72.3%      12.50 ± 60%  softirqs.CPU24.NET_RX
      9.33 ± 31%     -57.1%       4.00 ±106%     -38.9%       5.70 ± 83%  softirqs.CPU24.NET_TX
      5969 ± 16%     -82.0%       1073 ± 55%      -2.5%       5821 ± 15%  softirqs.CPU24.RCU
      2548 ± 12%     -26.5%       1874 ± 28%     +16.7%       2974 ± 15%  softirqs.CPU24.SCHED
      0.00          -100.0%       0.00         +3e+101%       0.30 ±213%  softirqs.CPU24.TASKLET
    100.83 ± 41%    +191.7%     294.17 ±197%     -10.8%      89.90 ± 59%  softirqs.CPU24.TIMER
      4.67 ±223%    -100.0%       0.00            +0.7%       4.70 ±299%  softirqs.CPU25.BLOCK
      0.50 ±152%    +533.3%       3.17 ±223%   +8600.0%      43.50 ±281%  softirqs.CPU25.NET_RX
      1.50 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU25.NET_TX
      5815 ± 18%     -88.4%     677.50 ± 21%      +2.6%       5965 ± 13%  softirqs.CPU25.RCU
      2230 ± 16%     -26.3%       1644 ±  7%     +30.4%       2908 ±  9%  softirqs.CPU25.SCHED
      0.00       +1.7e+101%       0.17 ±223%   +6e+101%       0.60 ±249%  softirqs.CPU25.TASKLET
     64.33 ± 67%     -63.5%      23.50 ± 41%     +53.3%      98.60 ± 93%  softirqs.CPU25.TIMER
      0.00          -100.0%       0.00       +1.8e+103%      18.20 ±300%  softirqs.CPU26.BLOCK
     27.17 ±223%     -94.5%       1.50 ±223%     -64.7%       9.60 ±286%  softirqs.CPU26.NET_RX
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU26.NET_TX
      6318 ± 21%     -89.7%     648.00 ± 13%      -8.5%       5778 ± 16%  softirqs.CPU26.RCU
      2369 ± 17%     -31.4%       1624 ±  6%     +24.9%       2960 ± 22%  softirqs.CPU26.SCHED
      2.00            +0.0%       2.00            +0.0%       2.00        softirqs.CPU26.TASKLET
    222.17 ±143%     -90.9%      20.17 ± 68%      +3.5%     229.90 ±214%  softirqs.CPU26.TIMER
      0.33 ±223%   +2000.0%       7.00 ±156%    -100.0%       0.00        softirqs.CPU27.BLOCK
      1.83 ±223%      +0.0%       1.83 ±149%    +210.9%       5.70 ±222%  softirqs.CPU27.NET_RX
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU27.NET_TX
      5825 ± 17%     -86.6%     781.17 ± 24%      +0.1%       5831 ± 17%  softirqs.CPU27.RCU
      2642 ± 36%     -29.3%       1868 ± 36%     +11.3%       2940 ± 18%  softirqs.CPU27.SCHED
      2.00           -16.7%       1.67 ± 28%     -10.0%       1.80 ± 33%  softirqs.CPU27.TASKLET
     50.33 ± 29%    +616.6%     360.67 ±212%     +61.3%      81.20 ±116%  softirqs.CPU27.TIMER
      6.00 ±209%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU28.BLOCK
      0.50 ±223%    -100.0%       0.00           -80.0%       0.10 ±300%  softirqs.CPU28.NET_RX
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU28.NET_TX
      5784 ± 18%     -84.4%     902.00 ± 46%      -2.9%       5618 ± 11%  softirqs.CPU28.RCU
      2510 ± 38%     -27.1%       1829 ± 28%      +9.7%       2754 ±  5%  softirqs.CPU28.SCHED
      2.00          +275.0%       7.50 ±104%      +0.0%       2.00 ± 22%  softirqs.CPU28.TASKLET
    186.50 ±170%     +86.2%     347.33 ±166%     -72.3%      51.60 ± 64%  softirqs.CPU28.TIMER
     14.00 ±152%     -73.8%       3.67 ±223%    -100.0%       0.00        softirqs.CPU29.BLOCK
      0.00         +1e+102%       1.00 ±182% +1.1e+103%      10.90 ±275%  softirqs.CPU29.NET_RX
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU29.NET_TX
      5784 ± 17%     -65.3%       2006 ± 99%      +2.9%       5952 ± 20%  softirqs.CPU29.RCU
      2134 ±  5%     -24.2%       1618 ±  5%     +22.6%       2617 ± 14%  softirqs.CPU29.SCHED
      2.83 ± 65%     -29.4%       2.00           -29.4%       2.00        softirqs.CPU29.TASKLET
     49.50 ± 25%    +522.9%     308.33 ±163%     +67.7%      83.00 ±163%  softirqs.CPU29.TIMER
      6.17 ± 80%     -54.1%       2.83 ±180%     -82.2%       1.10 ±245%  softirqs.CPU3.BLOCK
      0.33 ±141%    +850.0%       3.17 ±131%   +9620.0%      32.40 ±263%  softirqs.CPU3.NET_RX
      0.17 ±223%      +0.0%       0.17 ±223%     +20.0%       0.20 ±200%  softirqs.CPU3.NET_TX
      6718 ± 22%     -77.2%       1534 ± 31%      -5.7%       6338 ± 12%  softirqs.CPU3.RCU
      2899 ± 12%     -14.0%       2494 ± 31%     +15.7%       3354 ± 20%  softirqs.CPU3.SCHED
      0.00       +1.3e+102%       1.33 ±223%    -100.0%       0.00        softirqs.CPU3.TASKLET
    167.00 ±137%    +116.6%     361.67 ±198%     +30.4%     217.70 ±198%  softirqs.CPU3.TIMER
     21.33 ±223%    -100.0%       0.00           -99.5%       0.10 ±300%  softirqs.CPU30.BLOCK
      0.17 ±223%    +400.0%       0.83 ±128%    +620.0%       1.20 ±157%  softirqs.CPU30.NET_RX
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU30.NET_TX
      5648 ± 22%     -88.5%     649.33 ±  9%      +2.1%       5769 ± 14%  softirqs.CPU30.RCU
      2359 ± 12%     -29.9%       1654 ± 12%     +17.5%       2772 ± 11%  softirqs.CPU30.SCHED
      7.00 ±166%     -57.1%       3.00 ± 94%     -72.9%       1.90 ± 15%  softirqs.CPU30.TASKLET
     42.00 ± 21%     -12.7%      36.67 ±103%    +237.6%     141.80 ±218%  softirqs.CPU30.TIMER
      0.50 ±223%  +21800.0%     109.50 ±223%   +2940.0%      15.20 ±282%  softirqs.CPU31.NET_RX
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU31.NET_TX
      5756 ± 18%     -72.5%       1581 ±132%      +1.0%       5816 ± 18%  softirqs.CPU31.RCU
      2394 ± 10%      +8.4%       2594 ± 83%     +14.1%       2732 ± 10%  softirqs.CPU31.SCHED
      2.00          +141.7%       4.83 ± 92%    +160.0%       5.20 ±184%  softirqs.CPU31.TASKLET
     49.83 ± 22%   +1915.7%       1004 ±219%    +300.5%     199.60 ±162%  softirqs.CPU31.TIMER
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU32.BLOCK
      1.00 ±223%    -100.0%       0.00           -40.0%       0.60 ±200%  softirqs.CPU32.NET_RX
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU32.NET_TX
      5655 ± 20%     -87.3%     716.67 ± 13%      -1.4%       5577 ± 10%  softirqs.CPU32.RCU
      1928 ± 13%      -8.4%       1766 ±  9%     +37.2%       2645 ± 14%  softirqs.CPU32.SCHED
      2.00            +8.3%       2.17 ± 41%      -5.0%       1.90 ± 15%  softirqs.CPU32.TASKLET
     33.00 ± 21%     +39.9%      46.17 ±103%    +464.8%     186.40 ±249%  softirqs.CPU32.TIMER
      0.00       +4.3e+102%       4.33 ±223%   +2e+101%       0.20 ±300%  softirqs.CPU33.BLOCK
      6.17 ±209%     -91.9%       0.50 ±223%     -69.2%       1.90 ±216%  softirqs.CPU33.NET_RX
      5582 ± 19%     -87.3%     708.83 ± 42%      -0.9%       5530 ± 12%  softirqs.CPU33.RCU
      1998 ±  2%     -15.2%       1695 ± 13%     +34.9%       2695 ±  9%  softirqs.CPU33.SCHED
      5.17 ±137%     -61.3%       2.00           -18.7%       4.20 ±149%  softirqs.CPU33.TASKLET
     35.17 ± 47%     -53.1%      16.50 ± 64%     +43.3%      50.40 ±120%  softirqs.CPU33.TIMER
     11.83 ±146%    -100.0%       0.00           -98.3%       0.20 ±300%  softirqs.CPU34.BLOCK
      2.17 ±223%    -100.0%       0.00           +47.7%       3.20 ±182%  softirqs.CPU34.NET_RX
      0.00          -100.0%       0.00         +2e+101%       0.20 ±300%  softirqs.CPU34.NET_TX
      5600 ± 20%     -84.6%     863.50 ± 65%      -2.2%       5474 ± 10%  softirqs.CPU34.RCU
      2210 ± 15%     -23.2%       1697 ± 32%     +15.5%       2553 ± 13%  softirqs.CPU34.SCHED
      0.17 ±223%    +800.0%       1.50 ±120%     +20.0%       0.20 ±300%  softirqs.CPU34.TASKLET
     43.50 ± 54%     -66.7%      14.50 ± 37%     -25.7%      32.30 ± 36%  softirqs.CPU34.TIMER
      0.00       +3.3e+101%       0.33 ±223% +9.8e+102%       9.80 ±300%  softirqs.CPU35.BLOCK
      1879 ±223%    -100.0%       0.00           -99.6%       7.30 ±221%  softirqs.CPU35.NET_RX
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU35.NET_TX
      5938 ± 21%     -87.9%     721.50 ± 22%      -6.0%       5580 ± 14%  softirqs.CPU35.RCU
      2538 ± 38%     -34.5%       1662 ± 12%      +3.2%       2619 ±  6%  softirqs.CPU35.SCHED
    175.33 ±167%     -93.4%      11.50 ± 19%     -71.0%      50.80 ± 76%  softirqs.CPU35.TIMER
      1.50 ±195%    +411.1%       7.67 ±161%    +900.0%      15.00 ±238%  softirqs.CPU36.NET_RX
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU36.NET_TX
      5940 ± 21%     -87.6%     737.83 ± 30%      -6.4%       5559 ± 13%  softirqs.CPU36.RCU
      2511 ± 34%     -33.4%       1672 ±  8%      -0.4%       2501 ± 13%  softirqs.CPU36.SCHED
      0.00          -100.0%       0.00         +9e+101%       0.90 ±213%  softirqs.CPU36.TASKLET
    614.83 ±188%     -97.7%      14.17 ± 27%     -93.7%      38.70 ± 46%  softirqs.CPU36.TIMER
      1.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU37.BLOCK
      5.83 ±142%    -100.0%       0.00           -17.7%       4.80 ±176%  softirqs.CPU37.NET_RX
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU37.NET_TX
      5684 ± 20%     -85.8%     805.67 ± 36%      -3.0%       5514 ± 11%  softirqs.CPU37.RCU
      1981 ± 14%      -8.9%       1805 ± 17%     +30.5%       2586 ±  6%  softirqs.CPU37.SCHED
      0.00          -100.0%       0.00       +1.6e+102%       1.60 ±279%  softirqs.CPU37.TASKLET
     61.17 ± 98%     -61.6%      23.50 ± 72%     -38.0%      37.90 ± 44%  softirqs.CPU37.TIMER
      0.00       +1.5e+103%      14.83 ±223%    -100.0%       0.00        softirqs.CPU38.BLOCK
      1.33 ±192%     -87.5%       0.17 ±223%   +3485.0%      47.80 ±275%  softirqs.CPU38.NET_RX
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU38.NET_TX
      5600 ± 20%     -86.6%     751.67 ± 23%      -2.0%       5490 ± 10%  softirqs.CPU38.RCU
      2198 ± 17%     -25.3%       1643 ± 10%     +23.0%       2703 ± 14%  softirqs.CPU38.SCHED
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU38.TASKLET
     70.50 ± 77%     -61.5%      27.17 ± 47%    +128.8%     161.30 ±248%  softirqs.CPU38.TIMER
      0.00       +9.3e+102%       9.33 ±223% +9.5e+102%       9.50 ±220%  softirqs.CPU39.BLOCK
     31.00 ±202%    -100.0%       0.00           -91.6%       2.60 ±150%  softirqs.CPU39.NET_RX
      0.00       +1.5e+102%       1.50 ±223%    -100.0%       0.00        softirqs.CPU39.NET_TX
      5594 ± 19%     -78.4%       1210 ± 54%      -0.6%       5558 ± 14%  softirqs.CPU39.RCU
      2251 ± 12%     -13.2%       1953 ± 19%     +14.1%       2568 ±  5%  softirqs.CPU39.SCHED
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU39.TASKLET
    106.33 ±139%    +239.0%     360.50 ±196%     -72.0%      29.80 ± 25%  softirqs.CPU39.TIMER
      1.50 ±195%     -77.8%       0.33 ±223%     -13.3%       1.30 ±300%  softirqs.CPU4.BLOCK
     32.33 ±210%     -99.0%       0.33 ±141%    +486.4%     189.60 ±253%  softirqs.CPU4.NET_RX
      0.50 ±152%    -100.0%       0.00           +20.0%       0.60 ±133%  softirqs.CPU4.NET_TX
      6945 ± 16%     -79.2%       1443 ± 21%      -9.6%       6279 ±  9%  softirqs.CPU4.RCU
      3296 ± 12%     -30.7%       2283 ±  9%      +6.2%       3501 ± 24%  softirqs.CPU4.SCHED
      0.33 ±223%    +200.0%       1.00 ±223%    -100.0%       0.00        softirqs.CPU4.TASKLET
    135.50 ± 42%     -34.4%      88.83 ±131%      -3.6%     130.60 ± 64%  softirqs.CPU4.TIMER
      0.00       +9.5e+102%       9.50 ±223% +6.9e+102%       6.90 ±300%  softirqs.CPU40.BLOCK
      3.33 ±223%     -95.0%       0.17 ±223%    +503.0%      20.10 ±261%  softirqs.CPU40.NET_RX
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU40.NET_TX
      5707 ± 19%     -88.6%     650.83 ±  7%      -3.7%       5496 ± 11%  softirqs.CPU40.RCU
      2582 ± 29%     -33.9%       1706 ± 10%      +3.9%       2684 ± 11%  softirqs.CPU40.SCHED
      0.00          -100.0%       0.00         +6e+101%       0.60 ±300%  softirqs.CPU40.TASKLET
    360.83 ±200%     -96.0%      14.33 ± 22%     -88.6%      41.00 ± 79%  softirqs.CPU40.TIMER
      0.00       +1.7e+101%       0.17 ±223% +6.2e+102%       6.20 ±208%  softirqs.CPU41.BLOCK
      1.00 ±141%     -50.0%       0.50 ±223%     +50.0%       1.50 ±300%  softirqs.CPU41.NET_RX
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU41.NET_TX
      5594 ± 20%     -87.4%     706.17 ± 26%      -0.5%       5565 ± 10%  softirqs.CPU41.RCU
      2167 ±  6%     -24.8%       1630 ±  9%     +20.4%       2609 ±  7%  softirqs.CPU41.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU41.TASKLET
     40.83 ± 64%     -53.1%      19.17 ± 79%      -8.2%      37.50 ± 83%  softirqs.CPU41.TIMER
      9.83 ±214%    -100.0%       0.00           -65.4%       3.40 ±299%  softirqs.CPU42.BLOCK
      0.00       +1.7e+102%       1.67 ±223%    -100.0%       0.00        softirqs.CPU42.NET_RX
      5337 ± 23%     -78.6%       1140 ± 95%      +1.7%       5429 ± 11%  softirqs.CPU42.RCU
      2106 ±  8%     -20.4%       1676 ± 10%     +20.7%       2542 ± 10%  softirqs.CPU42.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU42.TASKLET
     36.00 ± 50%    +388.0%     175.67 ±207%     +45.3%      52.30 ±135%  softirqs.CPU42.TIMER
      0.00          -100.0%       0.00         +2e+101%       0.20 ±300%  softirqs.CPU43.BLOCK
      1.67 ± 28%   +6260.0%     106.00 ±219%     +68.0%       2.80 ±146%  softirqs.CPU43.NET_RX
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU43.NET_TX
      5642 ± 20%     -87.6%     700.50 ± 23%      +5.1%       5929 ± 21%  softirqs.CPU43.RCU
      2188 ±  8%     -23.6%       1671 ±  8%     +19.0%       2604 ±  8%  softirqs.CPU43.SCHED
      0.00          -100.0%       0.00       +3.5e+102%       3.50 ±290%  softirqs.CPU43.TASKLET
     30.00 ± 22%     -50.0%      15.00 ± 46%     +19.3%      35.80 ± 60%  softirqs.CPU43.TIMER
      0.17 ±223%   +4500.0%       7.67 ±223%  +11240.0%      18.90 ±291%  softirqs.CPU44.BLOCK
      0.17 ±223%  +1.9e+05%     312.00 ±223%   +2600.0%       4.50 ±223%  softirqs.CPU44.NET_RX
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU44.NET_TX
      5847 ± 19%     -83.2%     982.50 ± 30%      -3.2%       5658 ± 22%  softirqs.CPU44.RCU
      2206 ±  9%     -20.2%       1760 ±  9%     +26.2%       2784 ± 22%  softirqs.CPU44.SCHED
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU44.TASKLET
     34.83 ± 35%     -52.2%      16.67 ± 27%    +476.5%     200.80 ±254%  softirqs.CPU44.TIMER
      8.50 ±223%     -74.5%       2.17 ±223%     -20.0%       6.80 ±299%  softirqs.CPU45.BLOCK
      0.00       +1.7e+101%       0.17 ±223%   +3e+101%       0.30 ±152%  softirqs.CPU45.NET_RX
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU45.NET_TX
      6510 ± 35%     -89.7%     672.17 ± 18%     -14.9%       5542 ± 13%  softirqs.CPU45.RCU
      2163 ±  9%     -21.9%       1690 ± 11%     +24.8%       2700 ±  9%  softirqs.CPU45.SCHED
      0.67 ±141%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU45.TASKLET
    265.00 ±196%     -78.2%      57.83 ±165%     -80.5%      51.80 ± 84%  softirqs.CPU45.TIMER
     10.67 ±223%    -100.0%       0.00           -60.6%       4.20 ±216%  softirqs.CPU46.BLOCK
      0.00       +2.2e+102%       2.17 ±146%   +1e+101%       0.10 ±300%  softirqs.CPU46.NET_RX
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU46.NET_TX
      5589 ± 19%     -88.0%     669.67 ± 23%      +3.8%       5802 ± 17%  softirqs.CPU46.RCU
      2039 ±  4%     -15.7%       1719 ± 10%     +39.6%       2846 ± 11%  softirqs.CPU46.SCHED
      0.00       +1.7e+101%       0.17 ±223% +1.2e+102%       1.20 ±273%  softirqs.CPU46.TASKLET
     26.50 ± 27%    +264.8%      96.67 ±167%     +49.8%      39.70 ± 31%  softirqs.CPU46.TIMER
      0.00       +3.3e+101%       0.33 ±223%   +3e+102%       3.00 ±278%  softirqs.CPU47.BLOCK
      0.33 ±141%    -100.0%       0.00         +2720.0%       9.40 ±299%  softirqs.CPU47.NET_RX
      0.00       +2.2e+102%       2.17 ±183%   +2e+101%       0.20 ±300%  softirqs.CPU47.NET_TX
      5577 ± 19%     -80.4%       1094 ± 83%      +1.7%       5670 ± 14%  softirqs.CPU47.RCU
      2197 ±  9%     -14.0%       1888 ± 21%     +25.6%       2760 ± 12%  softirqs.CPU47.SCHED
     36.00 ± 42%    +206.9%     110.50 ±137%    +188.3%     103.80 ± 47%  softirqs.CPU47.TIMER
      0.00          -100.0%       0.00         +2e+102%       2.00 ±219%  softirqs.CPU48.BLOCK
     69.50 ±222%     -97.8%       1.50 ±166%     -98.1%       1.30 ±150%  softirqs.CPU48.NET_RX
      0.17 ±223%    +800.0%       1.50 ±223%     -40.0%       0.10 ±300%  softirqs.CPU48.NET_TX
      6409 ± 17%     -78.6%       1369 ± 53%      -0.4%       6383 ±  9%  softirqs.CPU48.RCU
      3309 ± 18%     -47.5%       1737 ±  7%      +6.9%       3537 ± 16%  softirqs.CPU48.SCHED
      0.00       +3.3e+101%       0.33 ±223%    -100.0%       0.00        softirqs.CPU48.TASKLET
    137.83 ± 22%     -65.9%      47.00 ± 57%    +103.6%     280.60 ±126%  softirqs.CPU48.TIMER
      1.00 ±223%    -100.0%       0.00          +200.0%       3.00 ±300%  softirqs.CPU49.BLOCK
      0.33 ±141%      +0.0%       0.33 ±141%   +2810.0%       9.70 ±171%  softirqs.CPU49.NET_RX
      0.00       +1.7e+101%       0.17 ±223%   +4e+101%       0.40 ±122%  softirqs.CPU49.NET_TX
      6879 ± 16%     -88.4%     797.67 ± 28%      -9.2%       6248 ± 10%  softirqs.CPU49.RCU
      2709 ± 17%     -34.4%       1776 ±  3%     +25.6%       3401 ± 25%  softirqs.CPU49.SCHED
      0.00          -100.0%       0.00         +3e+101%       0.30 ±300%  softirqs.CPU49.TASKLET
    324.67 ±159%     -85.8%      46.17 ± 83%     +26.4%     410.30 ±162%  softirqs.CPU49.TIMER
      1.00 ±223%     -83.3%       0.17 ±223%    +200.0%       3.00 ±240%  softirqs.CPU5.BLOCK
     12.67 ±161%   +4436.8%     574.67 ±223%    +368.2%      59.30 ±296%  softirqs.CPU5.NET_RX
      0.33 ±141%     -50.0%       0.17 ±223%     -40.0%       0.20 ±200%  softirqs.CPU5.NET_TX
      6083 ± 10%     -57.6%       2576 ±127%      -0.6%       6048 ±  8%  softirqs.CPU5.RCU
      2897 ±  9%     +22.8%       3557 ± 88%     +32.5%       3839 ± 17%  softirqs.CPU5.SCHED
      0.00          -100.0%       0.00         +5e+101%       0.50 ±161%  softirqs.CPU5.TASKLET
     63.33 ± 42%    +669.5%     487.33 ±205%    +626.6%     460.20 ±168%  softirqs.CPU5.TIMER
      4.00 ±152%     -66.7%       1.33 ±223%     -35.0%       2.60 ±299%  softirqs.CPU50.BLOCK
      1.50 ±142%     -11.1%       1.33 ±134%     -60.0%       0.60 ±169%  softirqs.CPU50.NET_RX
      0.67 ±165%     -50.0%       0.33 ±141%     -85.0%       0.10 ±300%  softirqs.CPU50.NET_TX
      6666 ± 18%     -83.8%       1078 ± 46%      -8.9%       6074 ± 11%  softirqs.CPU50.RCU
      2344 ± 40%     -12.7%       2045 ± 40%     +37.2%       3216 ± 29%  softirqs.CPU50.SCHED
      0.17 ±223%      +0.0%       0.17 ±223%    +440.0%       0.90 ±213%  softirqs.CPU50.TASKLET
    381.67 ±177%     +27.7%     487.50 ±156%     -12.1%     335.50 ±174%  softirqs.CPU50.TIMER
      7.33 ±177%     -72.7%       2.00 ±141%     -72.7%       2.00 ±204%  softirqs.CPU51.BLOCK
      4.17 ± 88%    +196.0%      12.33 ±212%    +108.8%       8.70 ±251%  softirqs.CPU51.NET_RX
      0.33 ±223%      +0.0%       0.33 ±141%     -10.0%       0.30 ±152%  softirqs.CPU51.NET_TX
      6581 ± 18%     -84.0%       1051 ± 39%     -10.3%       5901 ± 13%  softirqs.CPU51.RCU
      2500 ±  9%     -28.9%       1776 ± 26%      +4.9%       2622 ± 22%  softirqs.CPU51.SCHED
      0.00         +1e+102%       1.00 ±182% +3.8e+102%       3.80 ±200%  softirqs.CPU51.TASKLET
     99.67 ± 59%      +8.9%     108.50 ±138%     +25.2%     124.80 ±101%  softirqs.CPU51.TIMER
      2.00 ±182%     +33.3%       2.67 ±223%     -45.0%       1.10 ±300%  softirqs.CPU52.BLOCK
      0.33 ±223%  +40300.0%     134.67 ±219%   +2810.0%       9.70 ±269%  softirqs.CPU52.NET_RX
      0.00         +5e+101%       0.50 ±152%   +2e+101%       0.20 ±200%  softirqs.CPU52.NET_TX
      6859 ± 13%     -73.6%       1808 ± 38%     -12.8%       5979 ± 13%  softirqs.CPU52.RCU
      2864 ± 12%     -10.9%       2551 ± 31%      +7.3%       3074 ± 22%  softirqs.CPU52.SCHED
      0.00       +3.3e+101%       0.33 ±223%   +2e+101%       0.20 ±300%  softirqs.CPU52.TASKLET
    113.67 ± 44%    +110.0%     238.67 ±190%     +53.3%     174.30 ±157%  softirqs.CPU52.TIMER
      1.50 ±223%     +55.6%       2.33 ±223%     -46.7%       0.80 ±229%  softirqs.CPU53.BLOCK
      1.17 ±115%     +28.6%       1.50 ±223%     -74.3%       0.30 ±152%  softirqs.CPU53.NET_RX
      0.17 ±223%      +0.0%       0.17 ±223%     -40.0%       0.10 ±300%  softirqs.CPU53.NET_TX
      6390 ± 13%     -85.1%     950.17 ± 34%      -6.7%       5959 ±  9%  softirqs.CPU53.RCU
      2708 ± 19%     -32.2%       1836 ± 10%     +18.5%       3208 ± 20%  softirqs.CPU53.SCHED
      0.67 ±111%    +100.0%       1.33 ±223%    -100.0%       0.00        softirqs.CPU53.TASKLET
     67.50 ± 63%     -43.2%      38.33 ±116%      +6.2%      71.70 ± 77%  softirqs.CPU53.TIMER
      6.00 ±223%     +11.1%       6.67 ±197%     -66.7%       2.00 ±204%  softirqs.CPU54.BLOCK
      1.00 ±100%    +216.7%       3.17 ±196%     -10.0%       0.90 ±135%  softirqs.CPU54.NET_RX
      0.33 ±141%      +0.0%       0.33 ±141%     +50.0%       0.50 ±134%  softirqs.CPU54.NET_TX
      6828 ± 15%     -86.4%     927.17 ± 33%     -10.6%       6103 ±  9%  softirqs.CPU54.RCU
      2590 ± 10%     -25.4%       1933 ±  7%     +16.7%       3022 ± 13%  softirqs.CPU54.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU54.TASKLET
     79.33 ± 38%     -57.8%      33.50 ± 39%    +265.8%     290.20 ±129%  softirqs.CPU54.TIMER
      0.00          -100.0%       0.00         +6e+101%       0.60 ±300%  softirqs.CPU55.BLOCK
      1.50 ±137%    +155.6%       3.83 ±188%     -13.3%       1.30 ±133%  softirqs.CPU55.NET_RX
      0.17 ±223%    -100.0%       0.00           +80.0%       0.30 ±152%  softirqs.CPU55.NET_TX
      6384 ± 19%     -83.5%       1055 ± 43%      +1.0%       6448 ± 16%  softirqs.CPU55.RCU
      2617 ± 17%     -25.1%       1960 ± 12%     +18.1%       3090 ± 16%  softirqs.CPU55.SCHED
      0.00          -100.0%       0.00       +2.3e+102%       2.30 ±285%  softirqs.CPU55.TASKLET
     77.17 ± 56%     -69.1%      23.83 ± 11%    +187.7%     222.00 ±144%  softirqs.CPU55.TIMER
      3.33 ±157%     -95.0%       0.17 ±223%    -100.0%       0.00        softirqs.CPU56.BLOCK
      1.83 ±138%     -81.8%       0.33 ±141%    +996.4%      20.10 ±230%  softirqs.CPU56.NET_RX
      0.17 ±223%      +0.0%       0.17 ±223%     +20.0%       0.20 ±200%  softirqs.CPU56.NET_TX
      6950 ± 25%     -82.5%       1218 ± 34%     -14.2%       5960 ±  9%  softirqs.CPU56.RCU
      2478 ± 10%     -20.5%       1970 ± 10%     +23.1%       3051 ±  9%  softirqs.CPU56.SCHED
      1.00 ±223%    +333.3%       4.33 ±223%     -20.0%       0.80 ±229%  softirqs.CPU56.TASKLET
    250.50 ±179%     -85.9%      35.33 ± 65%     -54.2%     114.80 ± 73%  softirqs.CPU56.TIMER
      2.67 ±141%     -43.8%       1.50 ±195%      +5.0%       2.80 ±147%  softirqs.CPU57.BLOCK
      0.67 ± 70%     -50.0%       0.33 ±141%     -55.0%       0.30 ±152%  softirqs.CPU57.NET_RX
      0.17 ±223%    -100.0%       0.00           +20.0%       0.20 ±200%  softirqs.CPU57.NET_TX
      6786 ± 23%     -80.4%       1331 ± 35%     -10.6%       6066 ± 11%  softirqs.CPU57.RCU
      2655 ± 27%     -19.5%       2137 ± 16%     +17.2%       3111 ± 11%  softirqs.CPU57.SCHED
      0.00       +3.3e+101%       0.33 ±223%    -100.0%       0.00        softirqs.CPU57.TASKLET
    419.17 ±189%     -66.9%     138.83 ±182%     -40.6%     249.10 ±151%  softirqs.CPU57.TIMER
      2.00 ±141%     -33.3%       1.33 ±223%     -55.0%       0.90 ±265%  softirqs.CPU58.BLOCK
      0.50 ±100%     +33.3%       0.67 ±111%   +5400.0%      27.50 ±292%  softirqs.CPU58.NET_RX
      0.33 ±141%     -50.0%       0.17 ±223%     -40.0%       0.20 ±200%  softirqs.CPU58.NET_TX
      7103 ± 35%     -84.6%       1095 ± 41%     -11.7%       6275 ±  9%  softirqs.CPU58.RCU
      2593 ± 12%     -29.2%       1835 ± 14%     +22.4%       3175 ± 18%  softirqs.CPU58.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU58.TASKLET
    342.67 ±131%     -87.4%      43.33 ±102%     -27.2%     249.50 ±142%  softirqs.CPU58.TIMER
      1.33 ±223%    +100.0%       2.67 ±223%     -47.5%       0.70 ±255%  softirqs.CPU59.BLOCK
      0.33 ±141%    +4e+06%      13240 ±223%   +1520.0%       5.40 ±269%  softirqs.CPU59.NET_RX
      0.33 ±223%    -100.0%       0.00           -70.0%       0.10 ±300%  softirqs.CPU59.NET_TX
      6691 ± 15%     -57.4%       2850 ±114%      -6.8%       6234 ± 10%  softirqs.CPU59.RCU
      2591 ±  7%     +52.5%       3950 ±103%     +14.3%       2961 ±  7%  softirqs.CPU59.SCHED
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU59.TASKLET
    122.17 ± 95%     -52.5%      58.00 ± 88%     -48.4%      63.00 ± 27%  softirqs.CPU59.TIMER
      1.50 ±223%    +588.9%      10.33 ±145%     +13.3%       1.70 ±280%  softirqs.CPU6.BLOCK
     25.50 ±220%     -91.5%       2.17 ±144%     -92.2%       2.00 ±139%  softirqs.CPU6.NET_RX
      0.17 ±223%    +100.0%       0.33 ±141%     +80.0%       0.30 ±152%  softirqs.CPU6.NET_TX
      6368 ± 22%     -74.6%       1614 ± 40%      -3.3%       6160 ±  7%  softirqs.CPU6.RCU
      2735 ± 13%     -25.3%       2042 ± 14%     +12.0%       3063 ± 11%  softirqs.CPU6.SCHED
      0.17 ±223%    -100.0%       0.00           +20.0%       0.20 ±300%  softirqs.CPU6.TASKLET
     78.00 ± 22%     -60.3%      31.00 ± 30%      -2.2%      76.30 ± 97%  softirqs.CPU6.TIMER
      0.00       +1.8e+102%       1.83 ±223% +4.6e+102%       4.60 ±226%  softirqs.CPU60.BLOCK
     11.33 ±188%   +2685.3%     315.67 ±222%     -87.6%       1.40 ± 34%  softirqs.CPU60.NET_RX
      1.17 ± 31%      +0.0%       1.17 ± 31%     +11.4%       1.30 ± 35%  softirqs.CPU60.NET_TX
      7069 ± 12%     -79.8%       1426 ± 36%      -8.1%       6498 ± 13%  softirqs.CPU60.RCU
      2538 ± 11%     -15.4%       2148 ± 16%     +29.5%       3286 ± 26%  softirqs.CPU60.SCHED
      2.00           -66.7%       0.67 ±141%     +15.0%       2.30 ±188%  softirqs.CPU60.TASKLET
    279.17 ±149%     -71.3%      80.17 ± 87%     +23.3%     344.20 ±175%  softirqs.CPU60.TIMER
      0.00       +1.5e+102%       1.50 ±152% +2.9e+102%       2.90 ±244%  softirqs.CPU61.BLOCK
      1.50 ± 33%     -33.3%       1.00        +25640.0%     386.10 ±298%  softirqs.CPU61.NET_RX
      1.00            +0.0%       1.00           +10.0%       1.10 ± 27%  softirqs.CPU61.NET_TX
      6763 ± 12%     -76.6%       1580 ± 56%      -9.6%       6112 ± 13%  softirqs.CPU61.RCU
      2890 ± 11%     -31.7%       1975 ± 22%      +4.4%       3018 ±  7%  softirqs.CPU61.SCHED
      2.17 ± 17%      -7.7%       2.00           -16.9%       1.80 ± 33%  softirqs.CPU61.TASKLET
    124.33 ±108%     -59.1%      50.83 ± 82%     -36.5%      78.90 ± 53%  softirqs.CPU61.TIMER
      2.67 ±141%    -100.0%       0.00           -28.8%       1.90 ±200%  softirqs.CPU62.BLOCK
     19.00 ±158%     -93.0%       1.33 ±160%     -95.8%       0.80 ± 50%  softirqs.CPU62.NET_RX
      0.33 ±141%     -50.0%       0.17 ±223%     -40.0%       0.20 ±200%  softirqs.CPU62.NET_TX
      6555 ± 14%     -81.7%       1199 ± 46%      -7.1%       6089 ± 10%  softirqs.CPU62.RCU
      2434 ± 12%     -18.3%       1988 ± 19%     +17.6%       2862 ± 13%  softirqs.CPU62.SCHED
      0.17 ±223%    +100.0%       0.33 ±223%   +1700.0%       3.00 ±278%  softirqs.CPU62.TASKLET
     53.83 ± 30%     -44.6%      29.83 ± 47%     +10.2%      59.30 ± 45%  softirqs.CPU62.TIMER
     98.17 ±144%     -45.2%      53.83 ±212%     -99.6%       0.40 ±165%  softirqs.CPU63.NET_RX
      0.00       +1.7e+101%       0.17 ±223%   +2e+101%       0.20 ±200%  softirqs.CPU63.NET_TX
      7036 ± 16%     -69.8%       2127 ± 70%     -12.4%       6163 ± 12%  softirqs.CPU63.RCU
      2819 ± 15%     -21.5%       2212 ±  8%      -2.4%       2752 ±  8%  softirqs.CPU63.SCHED
      0.00          -100.0%       0.00         +2e+101%       0.20 ±300%  softirqs.CPU63.TASKLET
     86.00 ± 65%    +174.4%     236.00 ±178%     -20.0%      68.80 ± 72%  softirqs.CPU63.TIMER
      0.00          -100.0%       0.00       +5.5e+102%       5.50 ±119%  softirqs.CPU64.BLOCK
      4.83 ±196%     -89.7%       0.50 ±152%     -69.0%       1.50 ±171%  softirqs.CPU64.NET_RX
      0.17 ±223%      +0.0%       0.17 ±223%     +80.0%       0.30 ±213%  softirqs.CPU64.NET_TX
      7132 ± 17%     -82.3%       1259 ± 54%      -9.3%       6466 ±  8%  softirqs.CPU64.RCU
      2493 ± 12%     -16.0%       2094 ± 16%     +18.3%       2949 ±  8%  softirqs.CPU64.SCHED
      5.50 ±223%     -93.9%       0.33 ±223%     -94.5%       0.30 ±213%  softirqs.CPU64.TASKLET
     82.83 ± 42%     -75.7%      20.17 ± 42%     +27.4%     105.50 ±111%  softirqs.CPU64.TIMER
      0.00         +5e+102%       5.00 ±223% +5.1e+102%       5.10 ±217%  softirqs.CPU65.BLOCK
      1.83 ±200%     -54.5%       0.83 ±128%     -72.7%       0.50 ±134%  softirqs.CPU65.NET_RX
      0.33 ±141%     -50.0%       0.17 ±223%     -70.0%       0.10 ±300%  softirqs.CPU65.NET_TX
      7052 ± 16%     -75.9%       1697 ± 21%      -7.8%       6500 ±  9%  softirqs.CPU65.RCU
      2516 ± 16%      -4.1%       2413 ± 11%     +17.8%       2963 ± 10%  softirqs.CPU65.SCHED
      0.00          -100.0%       0.00       +1.3e+102%       1.30 ±228%  softirqs.CPU65.TASKLET
    195.67 ±154%      +6.0%     207.33 ±155%     -63.0%      72.30 ± 47%  softirqs.CPU65.TIMER
      2.67 ±223%     -50.0%       1.33 ±223%    -100.0%       0.00        softirqs.CPU66.BLOCK
      4.83 ±145%    +775.9%      42.33 ±219%    +404.8%      24.40 ±224%  softirqs.CPU66.NET_RX
      0.00       +3.3e+101%       0.33 ±141%   +3e+101%       0.30 ±213%  softirqs.CPU66.NET_TX
      7034 ± 16%     -81.8%       1282 ± 19%      -1.8%       6906 ± 28%  softirqs.CPU66.RCU
      2777 ±  3%     -28.4%       1989 ± 11%      +8.9%       3024 ± 14%  softirqs.CPU66.SCHED
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU66.TASKLET
    423.67 ± 95%     -94.3%      24.00 ± 35%     -49.3%     214.90 ±159%  softirqs.CPU66.TIMER
      0.00          -100.0%       0.00       +4.7e+102%       4.70 ±199%  softirqs.CPU67.BLOCK
     16.50 ±215%     -91.9%       1.33 ±103%     -85.5%       2.40 ±245%  softirqs.CPU67.NET_RX
      0.00         +5e+101%       0.50 ±100%    -100.0%       0.00        softirqs.CPU67.NET_TX
      6798 ± 16%     -75.8%       1646 ± 55%      -1.5%       6694 ±  5%  softirqs.CPU67.RCU
      2490 ±  9%      -4.2%       2386 ± 34%     +14.5%       2850 ± 13%  softirqs.CPU67.SCHED
      0.00         +5e+101%       0.50 ±152%    -100.0%       0.00        softirqs.CPU67.TASKLET
    257.33 ±133%     +46.0%     375.83 ±199%     -65.6%      88.60 ± 45%  softirqs.CPU67.TIMER
      0.33 ±223%      +0.0%       0.33 ±141%     +80.0%       0.60 ±300%  softirqs.CPU68.BLOCK
      1.00 ± 57%     -16.7%       0.83 ±107%    +490.0%       5.90 ±244%  softirqs.CPU68.NET_RX
      0.17 ±223%    -100.0%       0.00           +20.0%       0.20 ±200%  softirqs.CPU68.NET_TX
      6768 ± 20%     -83.2%       1138 ± 31%      +2.4%       6930 ± 17%  softirqs.CPU68.RCU
      2411 ±  7%     -11.3%       2139 ± 15%     +22.6%       2957 ± 15%  softirqs.CPU68.SCHED
      1.00 ±100%     -50.0%       0.50 ±152%    -100.0%       0.00        softirqs.CPU68.TASKLET
     95.50 ± 48%     -13.4%      82.67 ±125%     +82.3%     174.10 ±170%  softirqs.CPU68.TIMER
      0.00          -100.0%       0.00       +1.2e+102%       1.20 ±300%  softirqs.CPU69.BLOCK
      0.67 ±165%   +3575.0%      24.50 ±219%     -55.0%       0.30 ±152%  softirqs.CPU69.NET_RX
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU69.NET_TX
      6789 ± 17%     -80.2%       1345 ± 37%      -6.6%       6339 ±  9%  softirqs.CPU69.RCU
      2466 ± 13%     -14.2%       2115 ± 12%     +14.7%       2830 ± 12%  softirqs.CPU69.SCHED
      0.17 ±223%    +100.0%       0.33 ±223%    -100.0%       0.00        softirqs.CPU69.TASKLET
     90.17 ± 40%     -68.8%      28.17 ± 31%     +70.1%     153.40 ±120%  softirqs.CPU69.TIMER
      0.00       +2.3e+102%       2.33 ±187% +3.2e+102%       3.20 ±177%  softirqs.CPU7.BLOCK
      0.67 ±111%    +125.0%       1.50 ± 83%     -85.0%       0.10 ±300%  softirqs.CPU7.NET_RX
      0.00       +3.3e+101%       0.33 ±141%    -100.0%       0.00        softirqs.CPU7.NET_TX
      6756 ± 17%     -81.7%       1236 ± 16%      -8.0%       6216 ±  9%  softirqs.CPU7.RCU
      3105 ± 25%     -27.2%       2259 ± 11%      +4.6%       3246 ± 17%  softirqs.CPU7.SCHED
      0.00       +3.3e+101%       0.33 ±223%   +9e+101%       0.90 ±300%  softirqs.CPU7.TASKLET
    329.17 ±121%     -77.1%      75.50 ±127%      -3.1%     318.90 ±183%  softirqs.CPU7.TIMER
      4.33 ±223%    -100.0%       0.00           -67.7%       1.40 ±300%  softirqs.CPU70.BLOCK
      6.83 ±204%     -92.7%       0.50 ±100%     -86.8%       0.90 ±168%  softirqs.CPU70.NET_RX
      0.17 ±223%    +100.0%       0.33 ±141%     +80.0%       0.30 ±213%  softirqs.CPU70.NET_TX
      6868 ± 17%     -80.5%       1338 ± 29%      -5.2%       6511 ± 10%  softirqs.CPU70.RCU
      2544 ± 11%     -12.9%       2215 ± 10%     +17.2%       2982 ±  9%  softirqs.CPU70.SCHED
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU70.TASKLET
    236.17 ±166%     -86.1%      32.83 ± 36%     -64.9%      83.00 ± 67%  softirqs.CPU70.TIMER
      2.67 ±223%      +6.3%       2.83 ±141%     -96.2%       0.10 ±300%  softirqs.CPU71.BLOCK
     10.50 ±185%     -85.7%       1.50 ± 33%    +243.8%      36.10 ±258%  softirqs.CPU71.NET_RX
      0.50 ±100%     -66.7%       0.17 ±223%     -20.0%       0.40 ±122%  softirqs.CPU71.NET_TX
      6862 ± 18%     -79.0%       1440 ± 28%      -5.1%       6511 ±  7%  softirqs.CPU71.RCU
      2777 ± 11%     -28.8%       1978 ±  9%      +3.6%       2876 ±  8%  softirqs.CPU71.SCHED
      2.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU71.TASKLET
    197.67 ±140%     -86.4%      26.83 ± 19%     -68.0%      63.20 ± 33%  softirqs.CPU71.TIMER
      0.00         +5e+101%       0.50 ±223% +2.0e+103%      20.50 ±242%  softirqs.CPU72.BLOCK
      3.83 ±190%    -100.0%       0.00          +233.9%      12.80 ±300%  softirqs.CPU72.NET_RX
      0.17 ±223%    +900.0%       1.67 ±223%    -100.0%       0.00        softirqs.CPU72.NET_TX
      5754 ± 18%     -87.3%     730.67 ± 24%      -1.4%       5673 ± 13%  softirqs.CPU72.RCU
      2272 ± 11%     -26.7%       1664 ±  6%     +34.6%       3058 ± 13%  softirqs.CPU72.SCHED
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU72.TASKLET
     83.83 ± 67%     -40.0%      50.33 ±111%      +0.9%      84.60 ± 60%  softirqs.CPU72.TIMER
      0.33 ±223%   +1250.0%       4.50 ±223%   +6110.0%      20.70 ±253%  softirqs.CPU73.BLOCK
      0.00       +1.2e+102%       1.17 ±143% +9.1e+102%       9.10 ±180%  softirqs.CPU73.NET_RX
      0.00       +3.3e+101%       0.33 ±141%   +1e+101%       0.10 ±300%  softirqs.CPU73.NET_TX
      5655 ± 19%     -81.0%       1075 ± 66%      +0.0%       5655 ± 15%  softirqs.CPU73.RCU
      2333 ± 13%     +14.8%       2679 ± 55%     +30.8%       3052 ± 15%  softirqs.CPU73.SCHED
      2.00 ±223%    -100.0%       0.00           +15.0%       2.30 ±300%  softirqs.CPU73.TASKLET
     57.83 ± 43%   +1895.7%       1154 ±160%     +82.9%     105.80 ±115%  softirqs.CPU73.TIMER
      0.00          -100.0%       0.00         +4e+101%       0.40 ±300%  softirqs.CPU74.BLOCK
      3.33 ±223%    +395.0%      16.50 ±223%    -100.0%       0.00        softirqs.CPU74.NET_RX
      5732 ± 18%     -84.5%     888.50 ± 17%      +1.6%       5822 ± 14%  softirqs.CPU74.RCU
      2131 ±  5%     -16.2%       1786 ±  9%     +43.6%       3060 ± 11%  softirqs.CPU74.SCHED
      2.50 ±190%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU74.TASKLET
     72.83 ± 96%     -12.1%      64.00 ± 72%     +42.5%     103.80 ±120%  softirqs.CPU74.TIMER
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU75.BLOCK
      3.33 ±165%    -100.0%       0.00           -97.0%       0.10 ±300%  softirqs.CPU75.NET_RX
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU75.NET_TX
      5793 ± 18%     -86.7%     773.33 ± 21%      -3.5%       5589 ± 12%  softirqs.CPU75.RCU
      2177 ±  9%      +0.2%       2182 ± 31%     +38.7%       3020 ± 20%  softirqs.CPU75.SCHED
      1.00 ±223%     -33.3%       0.67 ±141%     -90.0%       0.10 ±300%  softirqs.CPU75.TASKLET
     44.33 ± 20%    +234.6%     148.33 ±157%     +12.8%      50.00 ± 71%  softirqs.CPU75.TIMER
     29.17 ±223%     -78.3%       6.33 ±223%     -99.3%       0.20 ±300%  softirqs.CPU76.BLOCK
      0.00         +5e+101%       0.50 ±223% +8.2e+103%      81.60 ±170%  softirqs.CPU76.NET_RX
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU76.NET_TX
      5788 ± 18%     -87.1%     749.17 ± 33%      +7.0%       6194 ± 33%  softirqs.CPU76.RCU
      2458 ± 19%     -37.2%       1543 ± 21%     +18.1%       2903 ±  7%  softirqs.CPU76.SCHED
      0.17 ±223%    +100.0%       0.33 ±141%    -100.0%       0.00        softirqs.CPU76.TASKLET
     89.00 ± 57%     -58.4%      37.00 ±135%    +114.0%     190.50 ±216%  softirqs.CPU76.TIMER
      8.67 ±223%     -13.5%       7.50 ±211%     -97.7%       0.20 ±300%  softirqs.CPU77.BLOCK
      0.33 ±223%   +1900.0%       6.67 ±216%    -100.0%       0.00        softirqs.CPU77.NET_RX
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU77.NET_TX
      5751 ± 19%     -74.8%       1448 ± 71%      +7.4%       6177 ± 25%  softirqs.CPU77.RCU
      2166 ±  6%     -12.6%       1893 ± 34%     +29.7%       2808 ± 12%  softirqs.CPU77.SCHED
      0.00       +3.3e+101%       0.33 ±141%   +7e+101%       0.70 ±255%  softirqs.CPU77.TASKLET
     66.00 ± 55%    +557.3%     433.83 ±138%    +107.7%     137.10 ±200%  softirqs.CPU77.TIMER
      0.67 ±165%    +175.0%       1.83 ±161%    +890.0%       6.60 ±191%  softirqs.CPU78.NET_RX
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        softirqs.CPU78.NET_TX
      5707 ± 21%     -69.0%       1770 ±113%      +3.2%       5892 ± 18%  softirqs.CPU78.RCU
      2308 ± 10%     -29.2%       1633 ± 23%     +21.2%       2797 ± 16%  softirqs.CPU78.SCHED
      1.00 ±141%    +450.0%       5.50 ±215%     +30.0%       1.30 ±300%  softirqs.CPU78.TASKLET
     50.17 ± 38%    +417.6%     259.67 ±196%     +12.4%      56.40 ± 68%  softirqs.CPU78.TIMER
      5.17 ±206%     -93.5%       0.33 ±223%    -100.0%       0.00        softirqs.CPU79.BLOCK
     77.33 ±112%    +766.6%     670.17 ±190%     -89.4%       8.20 ±300%  softirqs.CPU79.NET_RX
      0.50 ±152%    -100.0%       0.00           -80.0%       0.10 ±300%  softirqs.CPU79.NET_TX
      5797 ± 18%     -62.3%       2185 ±138%      +1.7%       5896 ± 16%  softirqs.CPU79.RCU
      2456 ±  8%     +37.0%       3364 ± 82%      +8.6%       2668 ± 13%  softirqs.CPU79.SCHED
      3.17 ±223%      +0.0%       3.17 ±223%     +42.1%       4.50 ±223%  softirqs.CPU79.TASKLET
     64.33 ± 58%     +19.2%      76.67 ±162%     +27.0%      81.70 ±120%  softirqs.CPU79.TIMER
      3.00 ±223%     -66.7%       1.00 ±223%     -86.7%       0.40 ±200%  softirqs.CPU8.BLOCK
      1.83 ±101%    +372.7%       8.67 ±192%     -18.2%       1.50 ± 44%  softirqs.CPU8.NET_RX
      1.17 ± 31%      +0.0%       1.17 ± 31%      -5.7%       1.10 ± 27%  softirqs.CPU8.NET_TX
      6612 ± 16%     -81.2%       1241 ± 28%      -9.9%       5957 ± 10%  softirqs.CPU8.RCU
      2701 ± 10%     -18.6%       2199 ± 12%     +11.3%       3008 ±  7%  softirqs.CPU8.SCHED
      1.50 ±195%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU8.TASKLET
     70.83 ± 59%    +132.7%     164.83 ±147%     +62.8%     115.30 ±112%  softirqs.CPU8.TIMER
      0.00          -100.0%       0.00       +7.4e+102%       7.40 ±196%  softirqs.CPU80.BLOCK
      0.00       +3.1e+103%      31.17 ±216%    -100.0%       0.00        softirqs.CPU80.NET_RX
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU80.NET_TX
      5602 ± 20%     -79.8%       1129 ± 72%      +6.0%       5937 ± 17%  softirqs.CPU80.RCU
      2001 ± 16%     +15.6%       2313 ± 43%     +40.1%       2803 ± 10%  softirqs.CPU80.SCHED
      1.00 ±182%    +483.3%       5.83 ±223%     -90.0%       0.10 ±300%  softirqs.CPU80.TASKLET
     45.83 ± 28%     -40.0%      27.50 ± 98%     +38.1%      63.30 ± 68%  softirqs.CPU80.TIMER
     14.17 ±147%     -92.9%       1.00 ±152%    -100.0%       0.00        softirqs.CPU81.BLOCK
      0.17 ±223%  +1.4e+06%       2378 ±223%   +2720.0%       4.70 ±220%  softirqs.CPU81.NET_RX
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU81.NET_TX
      5621 ± 19%     -85.8%     799.67 ± 39%      +1.7%       5719 ± 13%  softirqs.CPU81.RCU
      2086 ±  3%     -12.8%       1820 ± 16%     +28.3%       2678 ± 13%  softirqs.CPU81.SCHED
      0.17 ±223%    -100.0%       0.00           -40.0%       0.10 ±300%  softirqs.CPU81.TASKLET
     48.50 ± 70%     -70.1%      14.50 ± 19%      -0.6%      48.20 ± 61%  softirqs.CPU81.TIMER
     29.00 ±144%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU82.BLOCK
      1.83 ±138%    -100.0%       0.00          +194.5%       5.40 ±299%  softirqs.CPU82.NET_RX
      5930 ± 24%     -84.0%     946.67 ± 46%      +0.5%       5961 ± 19%  softirqs.CPU82.RCU
      2242 ±  5%     -20.2%       1789 ±  5%     +23.9%       2778 ±  9%  softirqs.CPU82.SCHED
      0.00       +1.7e+101%       0.17 ±223% +2.9e+102%       2.90 ±206%  softirqs.CPU82.TASKLET
     37.17 ± 14%    +124.7%      83.50 ± 99%     +32.4%      49.20 ± 58%  softirqs.CPU82.TIMER
      0.00         +5e+101%       0.50 ±223%    -100.0%       0.00        softirqs.CPU83.BLOCK
      0.00       +1.7e+101%       0.17 ±223% +7.6e+104%     757.50 ±299%  softirqs.CPU83.NET_RX
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU83.NET_TX
      5781 ± 22%     -85.6%     834.50 ± 27%      +9.7%       6339 ± 27%  softirqs.CPU83.RCU
      2323 ± 19%     -20.3%       1853 ± 10%     +29.8%       3015 ± 27%  softirqs.CPU83.SCHED
      0.00       +8.8e+102%       8.83 ±218%    -100.0%       0.00        softirqs.CPU83.TASKLET
     56.00 ± 73%     -45.5%      30.50 ± 67%    +303.9%     226.20 ±181%  softirqs.CPU83.TIMER
      0.00          -100.0%       0.00       +2.4e+103%      24.20 ±227%  softirqs.CPU84.BLOCK
      0.83 ±175%    +220.0%       2.67 ±155%     -76.0%       0.20 ±200%  softirqs.CPU84.NET_RX
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU84.NET_TX
      5728 ± 18%     -80.2%       1133 ± 41%      +2.1%       5846 ± 19%  softirqs.CPU84.RCU
      2201 ±  7%      -8.5%       2014 ± 19%     +22.9%       2705 ± 12%  softirqs.CPU84.SCHED
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU84.TASKLET
     55.50 ± 78%    +256.5%     197.83 ±196%    +215.9%     175.30 ±188%  softirqs.CPU84.TIMER
      0.67 ±223%     +25.0%       0.83 ±223%     +35.0%       0.90 ±300%  softirqs.CPU85.NET_RX
      0.00          -100.0%       0.00         +2e+101%       0.20 ±200%  softirqs.CPU85.NET_TX
      5894 ± 20%     -84.2%     930.00 ± 67%      -0.0%       5894 ± 14%  softirqs.CPU85.RCU
      2221 ±  9%      -9.5%       2010 ± 30%     +37.5%       3055 ± 20%  softirqs.CPU85.SCHED
      0.17 ±223%      +0.0%       0.17 ±223%    -100.0%       0.00        softirqs.CPU85.TASKLET
     91.17 ±129%    +234.4%     304.83 ±203%    +133.0%     212.40 ±233%  softirqs.CPU85.TIMER
      0.00          -100.0%       0.00       +3.2e+102%       3.20 ±300%  softirqs.CPU86.BLOCK
      0.00       +3.3e+102%       3.33 ±223% +3.2e+103%      32.40 ±300%  softirqs.CPU86.NET_RX
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU86.NET_TX
      5585 ± 19%     -85.3%     818.50 ± 58%      +1.3%       5657 ± 15%  softirqs.CPU86.RCU
      2234 ± 16%     -17.5%       1843 ±  9%     +25.2%       2798 ±  8%  softirqs.CPU86.SCHED
     63.17 ± 79%     -45.1%      34.67 ±117%     -19.6%      50.80 ± 78%  softirqs.CPU86.TIMER
      0.00       +6.3e+102%       6.33 ±223%   +1e+101%       0.10 ±300%  softirqs.CPU87.BLOCK
      1.17 ±223%    +471.4%       6.67 ±161%     -31.4%       0.80 ±300%  softirqs.CPU87.NET_RX
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU87.NET_TX
      6646 ± 31%     -90.7%     620.83 ± 30%     -13.7%       5733 ± 18%  softirqs.CPU87.RCU
      2303 ± 10%     -23.9%       1752 ±  7%     +24.2%       2861 ± 13%  softirqs.CPU87.SCHED
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU87.TASKLET
    272.17 ±188%     -92.1%      21.50 ± 55%     -78.1%      59.50 ± 67%  softirqs.CPU87.TIMER
      0.00       +4.5e+102%       4.50 ±223% +2.8e+102%       2.80 ±300%  softirqs.CPU88.BLOCK
      4.83 ±161%    -100.0%       0.00          +206.2%      14.80 ±300%  softirqs.CPU88.NET_RX
      0.17 ±223%    -100.0%       0.00           -40.0%       0.10 ±300%  softirqs.CPU88.NET_TX
      5822 ± 17%     -84.3%     916.50 ± 53%      +2.9%       5989 ± 19%  softirqs.CPU88.RCU
      2169 ±  9%     -16.5%       1811 ± 12%     +34.2%       2911 ± 13%  softirqs.CPU88.SCHED
      5.50 ±223%    -100.0%       0.00           -98.2%       0.10 ±300%  softirqs.CPU88.TASKLET
     61.50 ± 79%     -58.3%      25.67 ± 94%     +31.2%      80.70 ±129%  softirqs.CPU88.TIMER
      4.17 ±223%     -80.0%       0.83 ±223%     -30.4%       2.90 ±299%  softirqs.CPU89.BLOCK
     27.17 ±223%     -65.0%       9.50 ±223%     -94.1%       1.60 ±168%  softirqs.CPU89.NET_RX
      0.00          -100.0%       0.00         +2e+101%       0.20 ±200%  softirqs.CPU89.NET_TX
      5763 ± 18%     -90.3%     556.83 ± 16%      -1.1%       5699 ± 21%  softirqs.CPU89.RCU
      2510 ± 20%     -32.6%       1692 ± 10%      +8.4%       2722 ± 11%  softirqs.CPU89.SCHED
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU89.TASKLET
    344.33 ±197%     -96.5%      12.17 ± 19%     -87.1%      44.30 ± 79%  softirqs.CPU89.TIMER
      0.00         +2e+102%       2.00 ±223% +6.8e+102%       6.80 ±193%  softirqs.CPU9.BLOCK
     16.00 ±218%     -95.8%       0.67 ±111%     +29.4%      20.70 ±280%  softirqs.CPU9.NET_RX
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU9.NET_TX
      6500 ± 14%     -84.1%       1035 ± 32%      -8.5%       5948 ± 10%  softirqs.CPU9.RCU
      2549 ±  9%     -19.3%       2056 ± 15%     +21.7%       3102 ±  9%  softirqs.CPU9.SCHED
      5.83 ±208%     -88.6%       0.67 ±141%    -100.0%       0.00        softirqs.CPU9.TASKLET
     99.50 ± 38%     -74.9%      25.00 ± 28%     +66.9%     166.10 ±165%  softirqs.CPU9.TIMER
      0.00          -100.0%       0.00       +1.1e+103%      10.60 ±179%  softirqs.CPU90.BLOCK
      1.67 ±197%    +110.0%       3.50 ±211%     -52.0%       0.80 ±175%  softirqs.CPU90.NET_RX
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  softirqs.CPU90.NET_TX
      5533 ± 21%     -88.5%     636.83 ± 33%      +7.1%       5927 ± 15%  softirqs.CPU90.RCU
      2202 ±  8%     -24.7%       1658 ±  9%     +35.4%       2982 ± 22%  softirqs.CPU90.SCHED
     79.83 ±122%     -73.1%      21.50 ± 85%     -56.3%      34.90 ± 40%  softirqs.CPU90.TIMER
      7.50 ±223%    +111.1%      15.83 ±142%    -100.0%       0.00        softirqs.CPU91.BLOCK
      0.00       +1.3e+102%       1.33 ±223% +2.3e+102%       2.30 ±193%  softirqs.CPU91.NET_RX
      0.00       +1.7e+101%       0.17 ±223%   +2e+101%       0.20 ±200%  softirqs.CPU91.NET_TX
      5892 ± 16%     -90.8%     543.83 ± 13%      -5.8%       5552 ± 12%  softirqs.CPU91.RCU
      2438 ± 15%     -31.8%       1662 ±  6%      +7.3%       2615 ±  8%  softirqs.CPU91.SCHED
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU91.TASKLET
     45.33 ± 41%     -71.3%      13.00 ± 21%     +76.2%      79.90 ±105%  softirqs.CPU91.TIMER
      3.00 ±223%     -94.4%       0.17 ±223%      +6.7%       3.20 ±289%  softirqs.CPU92.BLOCK
     49.50 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU92.NET_RX
      5572 ± 18%     -84.6%     860.83 ± 39%      +1.3%       5646 ± 19%  softirqs.CPU92.RCU
      2158 ± 12%     -20.8%       1708 ± 11%     +29.4%       2793 ± 10%  softirqs.CPU92.SCHED
      0.00       +3.2e+102%       3.17 ±223%    -100.0%       0.00        softirqs.CPU92.TASKLET
     72.00 ±123%     -75.7%      17.50 ± 36%     -54.2%      33.00 ± 37%  softirqs.CPU92.TIMER
      5.67 ±208%     -94.1%       0.33 ±223%    +438.2%      30.50 ±269%  softirqs.CPU93.BLOCK
      0.33 ±223%   +1050.0%       3.83 ±190%     -70.0%       0.10 ±300%  softirqs.CPU93.NET_RX
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU93.NET_TX
      5551 ± 20%     -86.3%     759.83 ± 42%      +6.7%       5923 ± 19%  softirqs.CPU93.RCU
      2322 ± 21%     -25.1%       1739 ±  6%     +15.9%       2691 ±  8%  softirqs.CPU93.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU93.TASKLET
    264.33 ±191%     -92.9%      18.83 ± 54%     -80.1%      52.50 ± 78%  softirqs.CPU93.TIMER
      0.00          -100.0%       0.00         +2e+101%       0.20 ±200%  softirqs.CPU94.NET_TX
      5531 ± 21%     -88.7%     624.83 ± 18%      +0.4%       5555 ± 14%  softirqs.CPU94.RCU
      2027 ±  2%     -14.7%       1729 ±  8%     +38.1%       2800 ±  7%  softirqs.CPU94.SCHED
      0.00          -100.0%       0.00       +3.1e+102%       3.10 ±300%  softirqs.CPU94.TASKLET
     31.67 ± 24%     -41.1%      18.67 ± 61%     +36.1%      43.10 ± 41%  softirqs.CPU94.TIMER
      0.00          -100.0%       0.00       +5.5e+102%       5.50 ±288%  softirqs.CPU95.BLOCK
      0.67 ± 70%     -75.0%       0.17 ±223%    +200.0%       2.00 ±176%  softirqs.CPU95.NET_TX
      6013 ± 22%     -89.1%     655.83 ± 33%      +3.4%       6220 ± 15%  softirqs.CPU95.RCU
      2366 ±  6%     -28.9%       1681 ±  4%     +25.6%       2972 ± 21%  softirqs.CPU95.SCHED
      0.00       +3.3e+101%       0.33 ±141% +1.9e+102%       1.90 ±300%  softirqs.CPU95.TASKLET
     53.83 ± 34%     -67.8%      17.33 ± 22%    +341.4%     237.60 ±198%  softirqs.CPU95.TIMER
      2.17 ± 17%      +0.0%       2.17 ± 17%      +6.2%       2.30 ± 19%  softirqs.HI
      4103 ±120%    +347.4%      18361 ±155%     -17.5%       3383 ±116%  softirqs.NET_RX
     31.83 ±  7%      -8.4%      29.17 ±  2%      +0.8%      32.10 ±  8%  softirqs.NET_TX
    603089 ± 17%     -81.1%     113890 ±  9%      -3.5%     582237 ± 10%  softirqs.RCU
    244389           -19.2%     197587 ±  4%     +18.0%     288443 ±  3%  softirqs.SCHED
    229.33            -0.3%     228.67            -0.0%     229.30        softirqs.TASKLET
     13676 ±  5%      -4.3%      13086 ± 16%      -1.5%      13471 ±  3%  softirqs.TIMER
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.0:IO-APIC.2-edge.timer
      6.00 ±194%     -83.3%       1.00 ±182%     -76.7%       1.40 ±253%  interrupts.100:PCI-MSI.31981633-edge.i40e-eth0-TxRx-64
      1.17 ±115%     -71.4%       0.33 ±223%     -74.3%       0.30 ±213%  interrupts.101:PCI-MSI.31981634-edge.i40e-eth0-TxRx-65
      6.17 ±157%    +775.7%      54.00 ±223%    +459.5%      34.50 ±217%  interrupts.102:PCI-MSI.31981635-edge.i40e-eth0-TxRx-66
     25.50 ±221%     -93.5%       1.67 ±145%     -89.0%       2.80 ±276%  interrupts.103:PCI-MSI.31981636-edge.i40e-eth0-TxRx-67
      0.17 ±223%      +0.0%       0.17 ±223%   +4760.0%       8.10 ±265%  interrupts.104:PCI-MSI.31981637-edge.i40e-eth0-TxRx-68
      0.50 ±152%   +6366.7%      32.33 ±220%    -100.0%       0.00        interrupts.105:PCI-MSI.31981638-edge.i40e-eth0-TxRx-69
     13.00 ±220%    -100.0%       0.00           -98.5%       0.20 ±200%  interrupts.106:PCI-MSI.31981639-edge.i40e-eth0-TxRx-70
      2.50 ±223%     -86.7%       0.33 ±141%    +212.0%       7.80 ±177%  interrupts.107:PCI-MSI.31981640-edge.i40e-eth0-TxRx-71
      4.50 ±213%     -96.3%       0.17 ±223%    +242.2%      15.40 ±300%  interrupts.108:PCI-MSI.31981641-edge.i40e-eth0-TxRx-72
      0.17 ±223%   +1000.0%       1.83 ±200%   +9080.0%      15.30 ±200%  interrupts.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
      4.33 ±223%    -100.0%       0.00           -88.5%       0.50 ±100%  interrupts.110:PCI-MSI.31981643-edge.i40e-eth0-TxRx-74
      4.33 ±134%    -100.0%       0.00           -93.1%       0.30 ±213%  interrupts.111:PCI-MSI.31981644-edge.i40e-eth0-TxRx-75
      0.17 ±223%      +0.0%       0.17 ±223%  +67940.0%     113.40 ±195%  interrupts.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
      0.50 ±223%   +1800.0%       9.50 ±209%     -20.0%       0.40 ±200%  interrupts.113:PCI-MSI.31981646-edge.i40e-eth0-TxRx-77
      0.00       +1.7e+101%       0.17 ±223%   +8e+102%       8.00 ±169%  interrupts.114:PCI-MSI.31981647-edge.i40e-eth0-TxRx-78
     38.17 ±121%   +2192.1%     874.83 ±174%     -67.0%      12.60 ±300%  interrupts.115:PCI-MSI.31981648-edge.i40e-eth0-TxRx-79
      0.83 ±107%   +4920.0%      41.83 ±212%     -64.0%       0.30 ±152%  interrupts.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
      0.50 ±223%  +9.4e+05%       4722 ±223%    +620.0%       3.60 ±290%  interrupts.117:PCI-MSI.31981650-edge.i40e-eth0-TxRx-81
      1.00 ±223%     -33.3%       0.67 ±111%    +970.0%      10.70 ±296%  interrupts.118:PCI-MSI.31981651-edge.i40e-eth0-TxRx-82
      0.33 ±223%    -100.0%       0.00        +1.3e+05%     430.30 ±298%  interrupts.119:PCI-MSI.31981652-edge.i40e-eth0-TxRx-83
      1.50 ±223%    +211.1%       4.67 ±129%     -86.7%       0.20 ±200%  interrupts.120:PCI-MSI.31981653-edge.i40e-eth0-TxRx-84
      1.50 ±223%     -33.3%       1.00 ±223%     -86.7%       0.20 ±300%  interrupts.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
      0.17 ±223%   +2600.0%       4.50 ±213%  +24260.0%      40.60 ±297%  interrupts.122:PCI-MSI.31981655-edge.i40e-eth0-TxRx-86
      1.00 ±223%    +600.0%       7.00 ±159%     -70.0%       0.30 ±152%  interrupts.123:PCI-MSI.31981656-edge.i40e-eth0-TxRx-87
      4.67 ±214%    -100.0%       0.00          +515.0%      28.70 ±298%  interrupts.124:PCI-MSI.31981657-edge.i40e-eth0-TxRx-88
      9.17 ±223%     +69.1%      15.50 ±223%     -85.8%       1.30 ±250%  interrupts.125:PCI-MSI.31981658-edge.i40e-eth0-TxRx-89
      2.83 ±223%     +64.7%       4.67 ±205%     -43.5%       1.60 ±181%  interrupts.126:PCI-MSI.31981659-edge.i40e-eth0-TxRx-90
      0.00          -100.0%       0.00       +3.7e+102%       3.70 ±176%  interrupts.127:PCI-MSI.31981660-edge.i40e-eth0-TxRx-91
     97.00 ±223%    -100.0%       0.00           -99.7%       0.30 ±213%  interrupts.128:PCI-MSI.31981661-edge.i40e-eth0-TxRx-92
      0.33 ±223%   +1200.0%       4.33 ±223%    -100.0%       0.00        interrupts.129:PCI-MSI.31981662-edge.i40e-eth0-TxRx-93
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.293:PCI-MSI.327680-edge.xhci_hcd
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.298:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.299:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.300:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.301:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.302:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.303:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.303:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.304:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.305:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.306:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.307:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.308:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.308:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.309:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.309:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.310:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.310:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.311:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.311:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.312:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.312:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.313:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.313:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.314:PCI-MSI.67188736-edge.ioat-msix
    552.33 ± 16%     -82.6%      96.00            -6.5%     516.40 ±  3%  interrupts.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.50 ±152%    -100.0%       0.00          +560.0%       3.30 ±235%  interrupts.36:PCI-MSI.31981569-edge.i40e-eth0-TxRx-0
      0.17 ±223%   +2800.0%       4.83 ±196%    +620.0%       1.20 ±152%  interrupts.37:PCI-MSI.31981570-edge.i40e-eth0-TxRx-1
     40.00 ±223%     -37.5%      25.00 ±223%    -100.0%       0.00        interrupts.38:PCI-MSI.31981571-edge.i40e-eth0-TxRx-2
      0.00       +3.5e+102%       3.50 ±223% +6.1e+103%      60.90 ±282%  interrupts.39:PCI-MSI.31981572-edge.i40e-eth0-TxRx-3
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.3:IO-APIC.3-edge
     58.33 ±221%     -99.7%       0.17 ±223%     +43.1%      83.50 ±163%  interrupts.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
     20.83 ±160%   +3176.0%     682.50 ±223%    +465.4%     117.80 ±298%  interrupts.41:PCI-MSI.31981574-edge.i40e-eth0-TxRx-5
     50.33 ±223%     -93.4%       3.33 ±175%     -95.6%       2.20 ±182%  interrupts.42:PCI-MSI.31981575-edge.i40e-eth0-TxRx-6
      0.33 ±223%    +300.0%       1.33 ±165%     -10.0%       0.30 ±300%  interrupts.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
      1.67 ±223%    +530.0%      10.50 ±215%     -94.0%       0.10 ±300%  interrupts.44:PCI-MSI.31981577-edge.i40e-eth0-TxRx-8
     31.17 ±223%     -97.3%       0.83 ±128%     +30.3%      40.60 ±287%  interrupts.45:PCI-MSI.31981578-edge.i40e-eth0-TxRx-9
      1.17 ±187%    +142.9%       2.83 ±193%     -14.3%       1.00 ±204%  interrupts.46:PCI-MSI.31981579-edge.i40e-eth0-TxRx-10
      7.83 ±223%     -83.0%       1.33 ±165%    +171.9%      21.30 ±289%  interrupts.47:PCI-MSI.31981580-edge.i40e-eth0-TxRx-11
      0.33 ±223%   +5100.0%      17.33 ±223%   +3020.0%      10.40 ±231%  interrupts.48:PCI-MSI.31981581-edge.i40e-eth0-TxRx-12
      2.00 ±223%     -91.7%       0.17 ±223%   +1585.0%      33.70 ±299%  interrupts.49:PCI-MSI.31981582-edge.i40e-eth0-TxRx-13
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.4:IO-APIC.4-edge.ttyS0
    699.83 ±197%     -99.7%       1.83 ±223%     -99.6%       2.80 ±276%  interrupts.50:PCI-MSI.31981583-edge.i40e-eth0-TxRx-14
     25.33 ±209%     -89.5%       2.67 ±147%     -96.8%       0.80 ±134%  interrupts.51:PCI-MSI.31981584-edge.i40e-eth0-TxRx-15
      1.83 ±200%     -36.4%       1.17 ±125%     +69.1%       3.10 ±191%  interrupts.52:PCI-MSI.31981585-edge.i40e-eth0-TxRx-16
     18.50 ±211%     -37.8%      11.50 ±223%     -96.2%       0.70 ±255%  interrupts.53:PCI-MSI.31981586-edge.i40e-eth0-TxRx-17
      7.00 ±141%     -69.0%       2.17 ±185%     -95.7%       0.30 ±213%  interrupts.54:PCI-MSI.31981587-edge.i40e-eth0-TxRx-18
      0.17 ±223%    +100.0%       0.33 ±223%    +3e+05%     495.70 ±292%  interrupts.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
     20.83 ±139%     -80.8%       4.00 ±223%     -42.4%      12.00 ±184%  interrupts.56:PCI-MSI.31981589-edge.i40e-eth0-TxRx-20
      0.17 ±223%   +5300.0%       9.00 ±223%  +23420.0%      39.20 ±288%  interrupts.57:PCI-MSI.31981590-edge.i40e-eth0-TxRx-21
      1.00 ±223%  +28833.3%     289.33 ±223%   +2080.0%      21.80 ±209%  interrupts.58:PCI-MSI.31981591-edge.i40e-eth0-TxRx-22
      0.50 ±152%    +300.0%       2.00 ±182%     +80.0%       0.90 ±201%  interrupts.59:PCI-MSI.31981592-edge.i40e-eth0-TxRx-23
     69.50 ±213%     -96.9%       2.17 ± 17%     -95.4%       3.20 ± 92%  interrupts.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
      0.67 ±111%    +525.0%       4.17 ±223%   +1760.0%      12.40 ±206%  interrupts.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
     54.83 ±222%     -97.0%       1.67 ±197%     -96.5%       1.90 ±300%  interrupts.62:PCI-MSI.31981595-edge.i40e-eth0-TxRx-26
      0.83 ±175%    +200.0%       2.50 ±130%   +1124.0%      10.20 ±256%  interrupts.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
      0.00       +3.3e+101%       0.33 ±223%   +3e+101%       0.30 ±300%  interrupts.64:PCI-MSI.31981597-edge.i40e-eth0-TxRx-28
      0.33 ±223%    +350.0%       1.50 ±152%   +6440.0%      21.80 ±277%  interrupts.65:PCI-MSI.31981598-edge.i40e-eth0-TxRx-29
      0.50 ±223%    -100.0%       0.00          +380.0%       2.40 ±161%  interrupts.66:PCI-MSI.31981599-edge.i40e-eth0-TxRx-30
      0.50 ±100%  +41833.3%     209.67 ±222%   +3760.0%      19.30 ±294%  interrupts.67:PCI-MSI.31981600-edge.i40e-eth0-TxRx-31
      1.83 ±223%     -90.9%       0.17 ±223%     -23.6%       1.40 ±189%  interrupts.68:PCI-MSI.31981601-edge.i40e-eth0-TxRx-32
     12.50 ±212%     -98.7%       0.17 ±223%     -74.4%       3.20 ±219%  interrupts.69:PCI-MSI.31981602-edge.i40e-eth0-TxRx-33
      1.67 ±223%     -60.0%       0.67 ±141%     +86.0%       3.10 ±205%  interrupts.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
      3530 ±223%    -100.0%       0.33 ±223%     -99.9%       3.30 ±253%  interrupts.71:PCI-MSI.31981604-edge.i40e-eth0-TxRx-35
      0.33 ±223%   +4000.0%      13.67 ±160%   +8270.0%      27.90 ±259%  interrupts.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
      7.83 ±135%     -97.9%       0.17 ±223%     -19.6%       6.30 ±164%  interrupts.73:PCI-MSI.31981606-edge.i40e-eth0-TxRx-37
      1.67 ±223%     -40.0%       1.00 ±152%   +2528.0%      43.80 ±287%  interrupts.74:PCI-MSI.31981607-edge.i40e-eth0-TxRx-38
     61.67 ±205%     -99.7%       0.17 ±223%     -95.8%       2.60 ±205%  interrupts.75:PCI-MSI.31981608-edge.i40e-eth0-TxRx-39
      4.50 ±213%     -96.3%       0.17 ±223%    +751.1%      38.30 ±275%  interrupts.76:PCI-MSI.31981609-edge.i40e-eth0-TxRx-40
      1.67 ±223%     -60.0%       0.67 ±141%     -88.0%       0.20 ±200%  interrupts.77:PCI-MSI.31981610-edge.i40e-eth0-TxRx-41
      0.33 ±141%    +700.0%       2.67 ±190%    -100.0%       0.00        interrupts.78:PCI-MSI.31981611-edge.i40e-eth0-TxRx-42
      2.17 ± 41%   +9607.7%     210.33 ±221%     +15.4%       2.50 ±128%  interrupts.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
      0.17 ±223%  +3.7e+05%     623.67 ±223%   +5360.0%       9.10 ±227%  interrupts.80:PCI-MSI.31981613-edge.i40e-eth0-TxRx-44
      0.00          -100.0%       0.00         +6e+101%       0.60 ±169%  interrupts.81:PCI-MSI.31981614-edge.i40e-eth0-TxRx-45
      0.00         +2e+102%       2.00 ±202%   +4e+101%       0.40 ±300%  interrupts.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
      0.33 ±223%     -50.0%       0.17 ±223%     -70.0%       0.10 ±300%  interrupts.83:PCI-MSI.31981616-edge.i40e-eth0-TxRx-47
    107.50 ±222%     -98.9%       1.17 ±187%     -99.3%       0.80 ±222%  interrupts.84:PCI-MSI.31981617-edge.i40e-eth0-TxRx-48
      0.00       +1.7e+101%       0.17 ±223% +1.7e+103%      16.80 ±201%  interrupts.85:PCI-MSI.31981618-edge.i40e-eth0-TxRx-49
      2.17 ±203%     -23.1%       1.67 ±223%     -76.9%       0.50 ±300%  interrupts.86:PCI-MSI.31981619-edge.i40e-eth0-TxRx-50
      2.00 ±202%    +566.7%      13.33 ±223%    +615.0%      14.30 ±286%  interrupts.87:PCI-MSI.31981620-edge.i40e-eth0-TxRx-51
      0.00       +4.8e+103%      48.17 ±210% +2.1e+102%       2.10 ±188%  interrupts.88:PCI-MSI.31981621-edge.i40e-eth0-TxRx-52
      0.50 ±223%    +500.0%       3.00 ±209%     -80.0%       0.10 ±300%  interrupts.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.8:IO-APIC.8-edge.rtc0
      0.83 ±175%    +400.0%       4.17 ±184%     -52.0%       0.40 ±165%  interrupts.90:PCI-MSI.31981623-edge.i40e-eth0-TxRx-54
      1.33 ±160%    +212.5%       4.17 ±223%      +5.0%       1.40 ±232%  interrupts.91:PCI-MSI.31981624-edge.i40e-eth0-TxRx-55
      2.67 ±155%     -93.8%       0.17 ±223%    +556.2%      17.50 ±198%  interrupts.92:PCI-MSI.31981625-edge.i40e-eth0-TxRx-56
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.93:PCI-MSI.31981626-edge.i40e-eth0-TxRx-57
      0.33 ±223%     -50.0%       0.17 ±223%  +16250.0%      54.50 ±296%  interrupts.94:PCI-MSI.31981627-edge.i40e-eth0-TxRx-58
      0.00       +1.4e+106%      14483 ±223%   +3e+102%       3.00 ±267%  interrupts.95:PCI-MSI.31981628-edge.i40e-eth0-TxRx-59
     19.33 ±223%   +3151.7%     628.67 ±223%     -99.0%       0.20 ±300%  interrupts.96:PCI-MSI.31981629-edge.i40e-eth0-TxRx-60
      0.17 ±223%    -100.0%       0.00        +33800.0%      56.50 ±298%  interrupts.97:PCI-MSI.31981630-edge.i40e-eth0-TxRx-61
     37.33 ±161%     -94.2%       2.17 ±183%    -100.0%       0.00        interrupts.98:PCI-MSI.31981631-edge.i40e-eth0-TxRx-62
     82.33 ±215%     -80.0%      16.50 ±176%     -99.9%       0.10 ±300%  interrupts.99:PCI-MSI.31981632-edge.i40e-eth0-TxRx-63
      0.00          -100.0%       0.00       +1.3e+104%     128.20        interrupts.9:IO-APIC.9-fasteoi.acpi
    816631 ± 31%     -49.8%     410137 ± 14%      +7.9%     881157 ± 31%  interrupts.CAL:Function_call_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.0:IO-APIC.2-edge.timer
      0.17 ±223%    -100.0%       0.00           +20.0%       0.20 ±200%  interrupts.CPU0.119:PCI-MSI.31981652-edge.i40e-eth0-TxRx-83
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.297:PCI-MSI.67584-edge.ioat-msix
      0.17 ±223%    -100.0%       0.00         +1760.0%       3.10 ±250%  interrupts.CPU0.36:PCI-MSI.31981569-edge.i40e-eth0-TxRx-0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.3:IO-APIC.3-edge
      0.00       +1.7e+101%       0.17 ±223%    -100.0%       0.00        interrupts.CPU0.71:PCI-MSI.31981604-edge.i40e-eth0-TxRx-35
     81896 ± 52%     -94.6%       4446 ± 59%     -13.4%      70912 ± 66%  interrupts.CPU0.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.6e+102%       1.60 ± 30%  interrupts.CPU0.IWI:IRQ_work_interrupts
     60654           -95.4%       2775 ± 19%    +110.6%     127744        interrupts.CPU0.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7126 ± 15%  interrupts.CPU0.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7126 ± 15%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
   1679755 ± 39%     -99.1%      14302 ±174%     -38.2%    1037705 ± 43%  interrupts.CPU0.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.RTR:APIC_ICR_read_retries
      0.67 ± 70%    +125.0%       1.50 ±195%    +185.0%       1.90 ±113%  interrupts.CPU0.TLB:TLB_shootdowns
      0.17 ±223%    +100.0%       0.33 ±141%    -100.0%       0.00        interrupts.CPU1.120:PCI-MSI.31981653-edge.i40e-eth0-TxRx-84
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU1.298:PCI-MSI.69632-edge.ioat-msix
      0.00       +4.5e+102%       4.50 ±213%   +9e+101%       0.90 ±195%  interrupts.CPU1.37:PCI-MSI.31981570-edge.i40e-eth0-TxRx-1
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU1.3:IO-APIC.3-edge
      0.17 ±223%      +0.0%       0.17 ±223%     +80.0%       0.30 ±152%  interrupts.CPU1.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
      0.00          -100.0%       0.00       +1.3e+104%     128.20        interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
     40195 ± 60%     -98.3%     679.00 ± 26%      -6.7%      37488 ± 82%  interrupts.CPU1.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.4e+102%       1.40 ± 47%  interrupts.CPU1.IWI:IRQ_work_interrupts
     61525           -94.5%       3389 ± 36%    +107.8%     127825        interrupts.CPU1.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU1.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7126 ± 15%  interrupts.CPU1.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7126 ± 15%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    692538 ± 48%     -99.9%       1023 ±223%     +42.1%     984075 ± 54%  interrupts.CPU1.RES:Rescheduling_interrupts
      0.33 ±141%    -100.0%       0.00          +110.0%       0.70 ±111%  interrupts.CPU1.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.129:PCI-MSI.31981662-edge.i40e-eth0-TxRx-93
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.293:PCI-MSI.327680-edge.xhci_hcd
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.299:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.3:IO-APIC.3-edge
      1.00 ±223%    +166.7%       2.67 ±207%      +0.0%       1.00 ±204%  interrupts.CPU10.46:PCI-MSI.31981579-edge.i40e-eth0-TxRx-10
      0.00          -100.0%       0.00         +2e+101%       0.20 ±200%  interrupts.CPU10.81:PCI-MSI.31981614-edge.i40e-eth0-TxRx-45
      3726 ± 83%     -11.9%       3281 ± 90%    +153.2%       9435 ± 90%  interrupts.CPU10.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.3e+102%       1.30 ± 49%  interrupts.CPU10.IWI:IRQ_work_interrupts
     60388           -97.7%       1391 ± 51%    +111.5%     127750        interrupts.CPU10.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7129 ± 15%  interrupts.CPU10.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7129 ± 15%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
    470192 ± 77%     -96.8%      15256 ±133%     +42.3%     668854 ± 85%  interrupts.CPU10.RES:Rescheduling_interrupts
      1.33 ±223%    -100.0%       0.00           -32.5%       0.90 ± 77%  interrupts.CPU10.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.298:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.299:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.300:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.301:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.302:PCI-MSI.77824-edge.ioat-msix
      7.67 ±223%     -84.8%       1.17 ±187%    +176.5%      21.20 ±290%  interrupts.CPU11.47:PCI-MSI.31981580-edge.i40e-eth0-TxRx-11
      0.00       +3.3e+101%       0.33 ±141%   +1e+101%       0.10 ±300%  interrupts.CPU11.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.8:IO-APIC.8-edge.rtc0
      9134 ± 55%     -45.6%       4965 ± 86%     -38.9%       5581 ±104%  interrupts.CPU11.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.2e+102%       1.20 ± 50%  interrupts.CPU11.IWI:IRQ_work_interrupts
     60412           -98.5%     898.17 ± 35%    +111.4%     127713        interrupts.CPU11.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.8e+105%       6753 ± 22%  interrupts.CPU11.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.8e+105%       6753 ± 22%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
   1035474 ±108%     -97.0%      31216 ±167%     -51.2%     505055 ±102%  interrupts.CPU11.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +500.0%       1.00 ± 63%  interrupts.CPU11.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.299:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.300:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.301:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.302:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.303:PCI-MSI.79872-edge.ioat-msix
      0.17 ±223%  +10300.0%      17.33 ±223%   +5900.0%      10.00 ±241%  interrupts.CPU12.48:PCI-MSI.31981581-edge.i40e-eth0-TxRx-12
      0.00       +1.7e+101%       0.17 ±223%   +1e+101%       0.10 ±300%  interrupts.CPU12.83:PCI-MSI.31981616-edge.i40e-eth0-TxRx-47
     12601 ±198%     -39.9%       7573 ± 53%     -22.7%       9746 ±162%  interrupts.CPU12.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.4e+102%       1.40 ± 47%  interrupts.CPU12.IWI:IRQ_work_interrupts
     60272           -98.4%     954.17 ± 30%    +112.0%     127792        interrupts.CPU12.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7129 ± 15%  interrupts.CPU12.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7129 ± 15%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
    455627 ±107%     -95.5%      20374 ± 84%     +38.7%     631908 ± 99%  interrupts.CPU12.RES:Rescheduling_interrupts
      0.00       +1.7e+101%       0.17 ±223% +1.3e+102%       1.30 ± 69%  interrupts.CPU12.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.300:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.301:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.302:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.303:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.303:PCI-MSI.79872-edge.ioat-msix
     84.00 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.33 ±141%    -100.0%       0.00           -40.0%       0.20 ±200%  interrupts.CPU13.36:PCI-MSI.31981569-edge.i40e-eth0-TxRx-0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.3:IO-APIC.3-edge
      2.00 ±223%    -100.0%       0.00         +1580.0%      33.60 ±300%  interrupts.CPU13.49:PCI-MSI.31981582-edge.i40e-eth0-TxRx-13
      0.17 ±223%    -100.0%       0.00           +20.0%       0.20 ±200%  interrupts.CPU13.84:PCI-MSI.31981617-edge.i40e-eth0-TxRx-48
     12768 ± 72%     -44.4%       7099 ±134%     -60.0%       5102 ±110%  interrupts.CPU13.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.3e+102%       1.30 ± 49%  interrupts.CPU13.IWI:IRQ_work_interrupts
     60286           -98.9%     667.33 ± 45%    +111.8%     127686        interrupts.CPU13.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7127 ± 15%  interrupts.CPU13.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7127 ± 15%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    638087 ±103%     -97.3%      16919 ±147%     -43.9%     357970 ±121%  interrupts.CPU13.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +440.0%       0.90 ± 92%  interrupts.CPU13.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.301:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.302:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.303:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.304:PCI-MSI.79872-edge.ioat-msix
      0.00       +1.6e+103%      16.00 ±223%    -100.0%       0.00        interrupts.CPU14.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.17 ±223%    +100.0%       0.33 ±141%     +80.0%       0.30 ±152%  interrupts.CPU14.37:PCI-MSI.31981570-edge.i40e-eth0-TxRx-1
    699.83 ±197%     -99.8%       1.67 ±223%     -99.6%       2.60 ±300%  interrupts.CPU14.50:PCI-MSI.31981583-edge.i40e-eth0-TxRx-14
      0.00       +1.7e+101%       0.17 ±223%   +1e+101%       0.10 ±300%  interrupts.CPU14.85:PCI-MSI.31981618-edge.i40e-eth0-TxRx-49
      5627 ±153%     -71.0%       1633 ±101%     -35.1%       3649 ±122%  interrupts.CPU14.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.1e+102%       1.10 ± 48%  interrupts.CPU14.IWI:IRQ_work_interrupts
     60263           -98.0%       1185 ± 55%    +112.0%     127735        interrupts.CPU14.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7128 ± 15%  interrupts.CPU14.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7128 ± 15%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    238973 ± 84%     -93.2%      16299 ±117%    +163.3%     629192 ±123%  interrupts.CPU14.RES:Rescheduling_interrupts
      0.17 ±223%      +0.0%       0.17 ±223%    +560.0%       1.10 ± 75%  interrupts.CPU14.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.301:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.302:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.303:PCI-MSI.79872-edge.ioat-msix
      0.00       +1.6e+103%      16.00 ±223%    -100.0%       0.00        interrupts.CPU15.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.38:PCI-MSI.31981571-edge.i40e-eth0-TxRx-2
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.3:IO-APIC.3-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.4:IO-APIC.4-edge.ttyS0
     25.00 ±211%     -89.3%       2.67 ±147%     -98.4%       0.40 ±165%  interrupts.CPU15.51:PCI-MSI.31981584-edge.i40e-eth0-TxRx-15
      0.33 ±141%     -50.0%       0.17 ±223%    -100.0%       0.00        interrupts.CPU15.86:PCI-MSI.31981619-edge.i40e-eth0-TxRx-50
      6750 ±142%     -57.4%       2876 ±112%     -63.5%       2461 ± 94%  interrupts.CPU15.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.2e+102%       1.20 ± 62%  interrupts.CPU15.IWI:IRQ_work_interrupts
     60287           -98.3%       1040 ± 40%    +111.8%     127706        interrupts.CPU15.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.8e+105%       6751 ± 22%  interrupts.CPU15.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.8e+105%       6751 ± 22%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
    456818 ± 98%     -94.0%      27605 ±168%     -29.5%     322059 ±118%  interrupts.CPU15.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +560.0%       1.10 ± 63%  interrupts.CPU15.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.302:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.303:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.303:PCI-MSI.79872-edge.ioat-msix
     85.67 ±223%    -100.0%       0.00           -41.5%      50.10 ±299%  interrupts.CPU16.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00       +1.7e+101%       0.17 ±223%   +2e+101%       0.20 ±200%  interrupts.CPU16.39:PCI-MSI.31981572-edge.i40e-eth0-TxRx-3
      1.50 ±223%     -44.4%       0.83 ±128%     +93.3%       2.90 ±201%  interrupts.CPU16.52:PCI-MSI.31981585-edge.i40e-eth0-TxRx-16
      0.00          -100.0%       0.00         +2e+101%       0.20 ±200%  interrupts.CPU16.87:PCI-MSI.31981620-edge.i40e-eth0-TxRx-51
      1750 ±101%    +153.6%       4438 ± 76%    +342.1%       7736 ±166%  interrupts.CPU16.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.1e+102%       1.10 ± 63%  interrupts.CPU16.IWI:IRQ_work_interrupts
     60339           -98.7%     796.50 ± 39%    +111.6%     127695        interrupts.CPU16.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.MCP:Machine_check_polls
      0.00          -100.0%       0.00         +6e+105%       6001 ± 30%  interrupts.CPU16.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00         +6e+105%       6001 ± 30%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
    151816 ±151%     -95.6%       6694 ± 94%    +320.4%     638290 ±120%  interrupts.CPU16.RES:Rescheduling_interrupts
      0.33 ±141%     -50.0%       0.17 ±223%    +290.0%       1.30 ± 60%  interrupts.CPU16.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.303:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.304:PCI-MSI.79872-edge.ioat-msix
      0.00       +3.2e+103%      32.00 ±141% +1.5e+104%     151.70 ±152%  interrupts.CPU17.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.17 ±223%      +0.0%       0.17 ±223%     +20.0%       0.20 ±200%  interrupts.CPU17.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.4:IO-APIC.4-edge.ttyS0
     18.17 ±216%     -37.6%      11.33 ±223%     -96.7%       0.60 ±300%  interrupts.CPU17.53:PCI-MSI.31981586-edge.i40e-eth0-TxRx-17
      0.00       +3.3e+101%       0.33 ±141%   +2e+101%       0.20 ±200%  interrupts.CPU17.88:PCI-MSI.31981621-edge.i40e-eth0-TxRx-52
      2649 ±105%    +177.1%       7342 ±146%      -6.6%       2474 ± 60%  interrupts.CPU17.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.1e+102%       1.10 ± 48%  interrupts.CPU17.IWI:IRQ_work_interrupts
     60240           -98.6%     817.00 ± 44%    +111.9%     127677        interrupts.CPU17.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.8e+105%       6750 ± 22%  interrupts.CPU17.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.8e+105%       6750 ± 22%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
    201857 ±149%     -92.9%      14342 ±165%     +76.0%     355309 ± 92%  interrupts.CPU17.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +620.0%       1.20 ± 62%  interrupts.CPU17.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU18.295:PCI-MSI.65536-edge.ioat-msix
    212.83 ±145%     -85.0%      32.00 ±141%     +47.8%     314.60 ± 81%  interrupts.CPU18.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.17 ±223%    -100.0%       0.00           +20.0%       0.20 ±200%  interrupts.CPU18.41:PCI-MSI.31981574-edge.i40e-eth0-TxRx-5
      6.83 ±146%     -73.2%       1.83 ±200%     -97.1%       0.20 ±200%  interrupts.CPU18.54:PCI-MSI.31981587-edge.i40e-eth0-TxRx-18
      0.17 ±223%    +100.0%       0.33 ±141%     -40.0%       0.10 ±300%  interrupts.CPU18.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
     18249 ±174%     -78.7%       3895 ± 92%     -68.6%       5725 ±123%  interrupts.CPU18.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.1e+102%       1.10 ± 48%  interrupts.CPU18.IWI:IRQ_work_interrupts
     60211           -98.7%     801.00 ± 29%    +112.1%     127707        interrupts.CPU18.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU18.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.4e+105%       6374 ± 26%  interrupts.CPU18.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.4e+105%       6374 ± 26%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
    389931 ± 90%     -97.7%       8846 ±133%     +47.1%     573752 ± 92%  interrupts.CPU18.RES:Rescheduling_interrupts
      0.33 ±141%    -100.0%       0.00          +290.0%       1.30 ± 60%  interrupts.CPU18.TLB:TLB_shootdowns
    169.83 ±141%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.3:IO-APIC.3-edge
      0.17 ±223%      +0.0%       0.17 ±223%     +20.0%       0.20 ±200%  interrupts.CPU19.42:PCI-MSI.31981575-edge.i40e-eth0-TxRx-6
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.4:IO-APIC.4-edge.ttyS0
      0.00       +1.7e+101%       0.17 ±223%   +5e+104%     495.60 ±292%  interrupts.CPU19.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
      0.17 ±223%      +0.0%       0.17 ±223%     -40.0%       0.10 ±300%  interrupts.CPU19.90:PCI-MSI.31981623-edge.i40e-eth0-TxRx-54
      3214 ± 66%      +3.4%       3324 ± 89%    +104.1%       6561 ±118%  interrupts.CPU19.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.1e+102%       1.10 ± 48%  interrupts.CPU19.IWI:IRQ_work_interrupts
     60283           -98.1%       1164 ± 75%    +111.9%     127715        interrupts.CPU19.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.MCP:Machine_check_polls
      0.00       +1.7e+101%       0.17 ±223% +7.1e+105%       7127 ± 15%  interrupts.CPU19.NMI:Non-maskable_interrupts
      0.00       +1.7e+101%       0.17 ±223% +7.1e+105%       7127 ± 15%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
    315114 ± 71%     -86.2%      43617 ±192%     +72.1%     542358 ±104%  interrupts.CPU19.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +560.0%       1.10 ± 63%  interrupts.CPU19.TLB:TLB_shootdowns
      0.17 ±223%    -100.0%       0.00           -40.0%       0.10 ±300%  interrupts.CPU2.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
     39.83 ±223%     -37.2%      25.00 ±223%    -100.0%       0.00        interrupts.CPU2.38:PCI-MSI.31981571-edge.i40e-eth0-TxRx-2
      0.17 ±223%      +0.0%       0.17 ±223%     -40.0%       0.10 ±300%  interrupts.CPU2.73:PCI-MSI.31981606-edge.i40e-eth0-TxRx-37
     10401 ± 88%     -58.7%       4300 ±121%    +125.1%      23411 ± 74%  interrupts.CPU2.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.2e+102%       1.20 ± 50%  interrupts.CPU2.IWI:IRQ_work_interrupts
     60512           -97.1%       1745 ± 66%    +111.1%     127761        interrupts.CPU2.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU2.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7127 ± 15%  interrupts.CPU2.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7127 ± 15%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    473515 ± 61%     -99.3%       3508 ±142%    +120.1%    1042212 ± 49%  interrupts.CPU2.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +560.0%       1.10 ± 94%  interrupts.CPU2.TLB:TLB_shootdowns
      0.00       +1.7e+101%       0.17 ±223%   +1e+101%       0.10 ±300%  interrupts.CPU20.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
     20.67 ±141%     -80.6%       4.00 ±223%     -43.4%      11.70 ±187%  interrupts.CPU20.56:PCI-MSI.31981589-edge.i40e-eth0-TxRx-20
      0.33 ±141%    -100.0%       0.00           -40.0%       0.20 ±200%  interrupts.CPU20.91:PCI-MSI.31981624-edge.i40e-eth0-TxRx-55
      3460 ± 79%     -62.1%       1312 ±135%    +133.3%       8072 ±110%  interrupts.CPU20.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.1e+102%       1.10 ± 63%  interrupts.CPU20.IWI:IRQ_work_interrupts
     60323           -97.7%       1397 ± 59%    +111.7%     127683        interrupts.CPU20.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.8e+105%       6750 ± 22%  interrupts.CPU20.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.8e+105%       6750 ± 22%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
    291369 ±117%     -98.8%       3589 ±221%     +71.4%     499540 ± 86%  interrupts.CPU20.RES:Rescheduling_interrupts
      0.33 ±223%     -50.0%       0.17 ±223%    +170.0%       0.90 ± 92%  interrupts.CPU20.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.3:IO-APIC.3-edge
      0.00       +3.3e+101%       0.33 ±141%   +1e+101%       0.10 ±300%  interrupts.CPU21.44:PCI-MSI.31981577-edge.i40e-eth0-TxRx-8
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.4:IO-APIC.4-edge.ttyS0
      0.00         +9e+102%       9.00 ±223% +3.9e+103%      39.00 ±289%  interrupts.CPU21.57:PCI-MSI.31981590-edge.i40e-eth0-TxRx-21
      0.17 ±223%      +0.0%       0.17 ±223%    -100.0%       0.00        interrupts.CPU21.92:PCI-MSI.31981625-edge.i40e-eth0-TxRx-56
      1620 ±138%     +44.5%       2341 ±101%    +188.2%       4670 ±113%  interrupts.CPU21.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.1e+102%       1.10 ± 63%  interrupts.CPU21.IWI:IRQ_work_interrupts
     60239           -97.6%       1461 ± 51%    +112.0%     127729        interrupts.CPU21.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.8e+105%       6751 ± 22%  interrupts.CPU21.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.8e+105%       6751 ± 22%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
    172556 ± 87%     -96.5%       6014 ±120%     +32.1%     227902 ± 87%  interrupts.CPU21.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +500.0%       1.00 ± 63%  interrupts.CPU21.TLB:TLB_shootdowns
      0.17 ±223%    +200.0%       0.50 ±100%     +80.0%       0.30 ±152%  interrupts.CPU22.45:PCI-MSI.31981578-edge.i40e-eth0-TxRx-9
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.4:IO-APIC.4-edge.ttyS0
      1.00 ±223%  +28816.7%     289.17 ±223%   +2060.0%      21.60 ±209%  interrupts.CPU22.58:PCI-MSI.31981591-edge.i40e-eth0-TxRx-22
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.93:PCI-MSI.31981626-edge.i40e-eth0-TxRx-57
      2371 ± 88%     +74.0%       4125 ±126%    +282.8%       9075 ±125%  interrupts.CPU22.CAL:Function_call_interrupts
      0.00          -100.0%       0.00         +1e+102%       1.00 ± 44%  interrupts.CPU22.IWI:IRQ_work_interrupts
     60199           -95.4%       2756 ±151%    +112.2%     127733        interrupts.CPU22.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.4e+105%       6375 ± 27%  interrupts.CPU22.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.4e+105%       6375 ± 27%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
    188482 ±116%     -95.5%       8570 ±141%     +82.3%     343589 ±117%  interrupts.CPU22.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +500.0%       1.00 ± 77%  interrupts.CPU22.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.3:IO-APIC.3-edge
      0.17 ±223%      +0.0%       0.17 ±223%    -100.0%       0.00        interrupts.CPU23.46:PCI-MSI.31981579-edge.i40e-eth0-TxRx-10
      0.17 ±223%   +1000.0%       1.83 ±200%    +320.0%       0.70 ±255%  interrupts.CPU23.59:PCI-MSI.31981592-edge.i40e-eth0-TxRx-23
      0.17 ±223%      +0.0%       0.17 ±223%     +80.0%       0.30 ±152%  interrupts.CPU23.94:PCI-MSI.31981627-edge.i40e-eth0-TxRx-58
      7996 ±178%     -30.9%       5525 ± 90%     -23.9%       6084 ±109%  interrupts.CPU23.CAL:Function_call_interrupts
      0.00          -100.0%       0.00         +1e+102%       1.00 ± 44%  interrupts.CPU23.IWI:IRQ_work_interrupts
     60308           -97.6%       1464 ± 64%    +111.7%     127673        interrupts.CPU23.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6748 ± 22%  interrupts.CPU23.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6748 ± 22%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
    395904 ±192%     -92.2%      30749 ±136%      +4.5%     413787 ± 96%  interrupts.CPU23.RES:Rescheduling_interrupts
      0.17 ±223%    +700.0%       1.33 ±223%    +500.0%       1.00 ± 77%  interrupts.CPU23.TLB:TLB_shootdowns
     69.50 ±213%     -96.9%       2.17 ± 17%     -95.4%       3.20 ± 92%  interrupts.CPU24.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
     12156 ± 62%     -79.9%       2445 ±151%     +36.1%      16546 ± 67%  interrupts.CPU24.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.8e+102%       1.80 ± 33%  interrupts.CPU24.IWI:IRQ_work_interrupts
     60178           -98.5%     897.00 ± 49%    +112.2%     127699        interrupts.CPU24.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU24.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6672 ± 26%  interrupts.CPU24.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6672 ± 26%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
    482812 ± 45%     -99.7%       1387 ±150%     -13.6%     416960 ± 73%  interrupts.CPU24.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +560.0%       1.10 ± 63%  interrupts.CPU24.TLB:TLB_shootdowns
      0.50 ±152%    +733.3%       4.17 ±223%   +2360.0%      12.30 ±208%  interrupts.CPU25.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
     10461 ±109%     -74.3%       2691 ±139%     +13.5%      11873 ± 69%  interrupts.CPU25.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +2.1e+102%       2.10 ± 49%  interrupts.CPU25.IWI:IRQ_work_interrupts
     60179           -98.3%       1011 ± 76%    +112.3%     127736        interrupts.CPU25.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU25.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6679 ± 26%  interrupts.CPU25.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6679 ± 26%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
    292815 ± 81%     -98.3%       5028 ±159%    +100.2%     586289 ± 64%  interrupts.CPU25.RES:Rescheduling_interrupts
      0.33 ±141%    -100.0%       0.00          +290.0%       1.30 ± 60%  interrupts.CPU25.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU26.305:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU26.306:PCI-MSI.67174400-edge.ioat-msix
     54.50 ±223%     -97.2%       1.50 ±223%     -96.5%       1.90 ±300%  interrupts.CPU26.62:PCI-MSI.31981595-edge.i40e-eth0-TxRx-26
      8098 ± 85%     -60.9%       3163 ± 79%     +27.4%      10314 ±108%  interrupts.CPU26.CAL:Function_call_interrupts
      0.00          -100.0%       0.00         +2e+102%       2.00 ± 31%  interrupts.CPU26.IWI:IRQ_work_interrupts
     60335           -98.9%     648.50 ± 25%    +111.7%     127718        interrupts.CPU26.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU26.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7067 ± 22%  interrupts.CPU26.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7067 ± 22%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
    199173 ± 64%     -96.2%       7584 ±124%     +72.2%     342913 ± 57%  interrupts.CPU26.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +500.0%       1.00 ± 77%  interrupts.CPU26.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU27.307:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU27.308:PCI-MSI.67176448-edge.ioat-msix
      0.67 ±223%    +225.0%       2.17 ±136%   +1415.0%      10.10 ±256%  interrupts.CPU27.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
      9303 ±102%     -85.4%       1354 ± 77%     +14.1%      10611 ± 78%  interrupts.CPU27.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+102%       1.70 ± 26%  interrupts.CPU27.IWI:IRQ_work_interrupts
     60219           -98.1%       1140 ±139%    +112.0%     127682        interrupts.CPU27.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU27.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6669 ± 26%  interrupts.CPU27.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6669 ± 26%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
    493009 ± 92%     -99.7%       1286 ±134%     -10.8%     440000 ±127%  interrupts.CPU27.RES:Rescheduling_interrupts
      0.33 ±141%    +300.0%       1.33 ±223%    +200.0%       1.00 ± 63%  interrupts.CPU27.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.307:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.308:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.308:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.309:PCI-MSI.67178496-edge.ioat-msix
      0.00       +1.7e+101%       0.17 ±223%   +2e+101%       0.20 ±300%  interrupts.CPU28.64:PCI-MSI.31981597-edge.i40e-eth0-TxRx-28
      3543 ± 78%     +86.5%       6609 ±130%    +152.9%       8963 ±137%  interrupts.CPU28.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.8e+102%       1.80 ± 22%  interrupts.CPU28.IWI:IRQ_work_interrupts
     60184           -98.5%     892.83 ± 84%    +112.2%     127681        interrupts.CPU28.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6672 ± 26%  interrupts.CPU28.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6672 ± 26%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
    469018 ±105%     -97.5%      11551 ±139%     -28.1%     337349 ± 82%  interrupts.CPU28.RES:Rescheduling_interrupts
      0.17 ±223%      +0.0%       0.17 ±223%    +500.0%       1.00 ± 77%  interrupts.CPU28.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.308:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.309:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.309:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.310:PCI-MSI.67180544-edge.ioat-msix
      0.17 ±223%    +700.0%       1.33 ±165%  +12740.0%      21.40 ±281%  interrupts.CPU29.65:PCI-MSI.31981598-edge.i40e-eth0-TxRx-29
      3686 ± 65%     -29.9%       2582 ± 92%    +189.7%      10680 ±124%  interrupts.CPU29.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.8e+102%       1.80 ± 33%  interrupts.CPU29.IWI:IRQ_work_interrupts
     60142           -98.9%     668.83 ± 36%    +112.3%     127705        interrupts.CPU29.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6672 ± 26%  interrupts.CPU29.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6672 ± 26%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
    281133 ± 62%     -97.4%       7412 ±138%     -29.8%     197454 ± 93%  interrupts.CPU29.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +440.0%       0.90 ± 77%  interrupts.CPU29.TLB:TLB_shootdowns
      0.17 ±223%      +0.0%       0.17 ±223%     +20.0%       0.20 ±200%  interrupts.CPU3.122:PCI-MSI.31981655-edge.i40e-eth0-TxRx-86
      0.00       +3.3e+102%       3.33 ±223% +6.1e+103%      60.70 ±282%  interrupts.CPU3.39:PCI-MSI.31981572-edge.i40e-eth0-TxRx-3
      0.00       +3.3e+101%       0.33 ±141%   +2e+101%       0.20 ±200%  interrupts.CPU3.74:PCI-MSI.31981607-edge.i40e-eth0-TxRx-38
      6606 ± 75%     -48.7%       3389 ± 84%    +261.9%      23908 ± 87%  interrupts.CPU3.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.4e+102%       1.40 ± 34%  interrupts.CPU3.IWI:IRQ_work_interrupts
     60410           -98.0%       1205 ± 61%    +111.4%     127734        interrupts.CPU3.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU3.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.5e+105%       7503        interrupts.CPU3.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.5e+105%       7503        interrupts.CPU3.PMI:Performance_monitoring_interrupts
    285041 ± 86%     -91.4%      24381 ±136%     +99.3%     568091 ± 77%  interrupts.CPU3.RES:Rescheduling_interrupts
      1.33 ±223%     -87.5%       0.17 ±223%     +42.5%       1.90 ±131%  interrupts.CPU3.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU30.309:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU30.310:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU30.310:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU30.311:PCI-MSI.67182592-edge.ioat-msix
      0.33 ±223%    -100.0%       0.00          +470.0%       1.90 ±188%  interrupts.CPU30.66:PCI-MSI.31981599-edge.i40e-eth0-TxRx-30
      7356 ± 76%     -52.1%       3520 ±121%     -31.9%       5007 ±108%  interrupts.CPU30.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+102%       1.70 ± 26%  interrupts.CPU30.IWI:IRQ_work_interrupts
     60180           -98.8%     716.00 ± 41%    +112.2%     127681        interrupts.CPU30.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU30.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6669 ± 26%  interrupts.CPU30.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6669 ± 26%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
    537090 ± 70%     -99.4%       3478 ±162%     -52.9%     252921 ±120%  interrupts.CPU30.RES:Rescheduling_interrupts
      0.17 ±223%      +0.0%       0.17 ±223%    +440.0%       0.90 ± 77%  interrupts.CPU30.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.310:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.311:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.311:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.312:PCI-MSI.67184640-edge.ioat-msix
      0.00       +2.1e+104%     209.33 ±223% +1.9e+103%      19.10 ±298%  interrupts.CPU31.67:PCI-MSI.31981600-edge.i40e-eth0-TxRx-31
      8608 ± 75%     -37.2%       5407 ±159%     -45.2%       4720 ±107%  interrupts.CPU31.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.9e+102%       1.90 ± 15%  interrupts.CPU31.IWI:IRQ_work_interrupts
     60152           -95.5%       2725 ±154%    +112.4%     127758        interrupts.CPU31.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7063 ± 22%  interrupts.CPU31.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7063 ± 22%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
    513819 ± 70%     -98.8%       6234 ±156%     -59.6%     207497 ±139%  interrupts.CPU31.RES:Rescheduling_interrupts
      0.00       +1.7e+101%       0.17 ±223% +1.2e+102%       1.20 ± 50%  interrupts.CPU31.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.311:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.312:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.312:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.313:PCI-MSI.67186688-edge.ioat-msix
      1.83 ±223%    -100.0%       0.00           -45.5%       1.00 ±236%  interrupts.CPU32.68:PCI-MSI.31981601-edge.i40e-eth0-TxRx-32
      6924 ± 87%     -39.1%       4215 ±103%     -52.8%       3270 ±106%  interrupts.CPU32.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+102%       1.70 ± 26%  interrupts.CPU32.IWI:IRQ_work_interrupts
     60133           -98.3%       1016 ± 58%    +112.3%     127666        interrupts.CPU32.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6669 ± 26%  interrupts.CPU32.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6669 ± 26%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
    385091 ± 91%     -97.6%       9348 ±134%     -32.8%     258960 ± 87%  interrupts.CPU32.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00         +9e+101%       0.90 ± 77%  interrupts.CPU32.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.312:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.313:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.313:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.314:PCI-MSI.67188736-edge.ioat-msix
     12.17 ±216%     -98.6%       0.17 ±223%     -74.5%       3.10 ±227%  interrupts.CPU33.69:PCI-MSI.31981602-edge.i40e-eth0-TxRx-33
    998.83 ± 54%    +752.7%       8516 ±126%    +208.1%       3077 ± 81%  interrupts.CPU33.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.8e+102%       1.80 ± 22%  interrupts.CPU33.IWI:IRQ_work_interrupts
     60238           -98.4%     967.33 ± 98%    +112.1%     127739        interrupts.CPU33.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7062 ± 22%  interrupts.CPU33.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7062 ± 22%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
    131516 ± 89%     -93.4%       8686 ±139%     +12.5%     147925 ± 86%  interrupts.CPU33.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +500.0%       1.00 ± 89%  interrupts.CPU33.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU34.313:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU34.314:PCI-MSI.67188736-edge.ioat-msix
      1.67 ±223%     -80.0%       0.33 ±141%     +86.0%       3.10 ±205%  interrupts.CPU34.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
      4822 ±109%     +64.4%       7926 ± 96%      +0.3%       4835 ±115%  interrupts.CPU34.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.9e+102%       1.90 ± 43%  interrupts.CPU34.IWI:IRQ_work_interrupts
     60126           -98.6%     830.50 ± 29%    +112.4%     127708        interrupts.CPU34.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU34.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6674 ± 26%  interrupts.CPU34.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6674 ± 26%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    429677 ±154%     -98.4%       6925 ±141%     -16.5%     358939 ± 81%  interrupts.CPU34.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00       +1.1e+102%       1.10 ± 48%  interrupts.CPU34.TLB:TLB_shootdowns
      3530 ±223%    -100.0%       0.17 ±223%     -99.9%       3.30 ±253%  interrupts.CPU35.71:PCI-MSI.31981604-edge.i40e-eth0-TxRx-35
      1690 ± 73%    +147.5%       4184 ±125%    +128.8%       3867 ±140%  interrupts.CPU35.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.6e+102%       1.60 ± 30%  interrupts.CPU35.IWI:IRQ_work_interrupts
     60234           -99.1%     518.17 ± 42%    +112.0%     127688        interrupts.CPU35.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU35.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.3e+105%       6277 ± 30%  interrupts.CPU35.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.3e+105%       6277 ± 30%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
    371287 ± 96%     -98.5%       5682 ±149%     -51.3%     180990 ± 88%  interrupts.CPU35.RES:Rescheduling_interrupts
      0.00       +1.7e+101%       0.17 ±223% +1.2e+102%       1.20 ± 62%  interrupts.CPU35.TLB:TLB_shootdowns
      0.17 ±223%   +8000.0%      13.50 ±162%  +16460.0%      27.60 ±261%  interrupts.CPU36.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
      2224 ± 90%    +148.0%       5517 ±125%     +39.8%       3110 ±109%  interrupts.CPU36.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+102%       1.70 ± 37%  interrupts.CPU36.IWI:IRQ_work_interrupts
     60188           -99.0%     602.17 ± 60%    +112.1%     127670        interrupts.CPU36.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU36.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.3e+105%       6279 ± 30%  interrupts.CPU36.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.3e+105%       6279 ± 30%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
    388845 ±119%     -97.9%       8081 ±165%     -65.2%     135193 ± 86%  interrupts.CPU36.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00       +1.1e+102%       1.10 ± 48%  interrupts.CPU36.TLB:TLB_shootdowns
      7.67 ±139%    -100.0%       0.00           -19.1%       6.20 ±166%  interrupts.CPU37.73:PCI-MSI.31981606-edge.i40e-eth0-TxRx-37
      5491 ± 67%     -42.9%       3135 ±118%     -10.0%       4943 ±159%  interrupts.CPU37.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+102%       1.70 ± 26%  interrupts.CPU37.IWI:IRQ_work_interrupts
     60201           -98.2%       1077 ± 62%    +112.1%     127696        interrupts.CPU37.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU37.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6670 ± 26%  interrupts.CPU37.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6670 ± 26%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
    307663 ±124%     -98.8%       3727 ±155%     -62.7%     114717 ±137%  interrupts.CPU37.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +620.0%       1.20 ± 50%  interrupts.CPU37.TLB:TLB_shootdowns
      1.67 ±223%     -60.0%       0.67 ±165%   +2516.0%      43.60 ±288%  interrupts.CPU38.74:PCI-MSI.31981607-edge.i40e-eth0-TxRx-38
      3704 ±124%     -74.6%     939.33 ± 92%     +36.0%       5037 ±151%  interrupts.CPU38.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.8e+102%       1.80 ± 22%  interrupts.CPU38.IWI:IRQ_work_interrupts
     60182           -98.6%     851.17 ± 83%    +112.2%     127720        interrupts.CPU38.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU38.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7063 ± 22%  interrupts.CPU38.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7063 ± 22%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    451487 ±108%     -99.9%     399.17 ±177%     -58.0%     189656 ± 83%  interrupts.CPU38.RES:Rescheduling_interrupts
      0.33 ±141%    -100.0%       0.00          +230.0%       1.10 ± 48%  interrupts.CPU38.TLB:TLB_shootdowns
     61.33 ±205%    -100.0%       0.00           -95.9%       2.50 ±215%  interrupts.CPU39.75:PCI-MSI.31981608-edge.i40e-eth0-TxRx-39
      5826 ±157%     -86.0%     816.00 ± 79%     -45.2%       3194 ±115%  interrupts.CPU39.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.8e+102%       1.80 ± 22%  interrupts.CPU39.IWI:IRQ_work_interrupts
     60283           -98.5%     930.50 ± 59%    +111.8%     127686        interrupts.CPU39.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU39.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7062 ± 22%  interrupts.CPU39.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7062 ± 22%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
    617036 ±139%     -99.7%       1594 ±216%     -72.9%     167255 ± 98%  interrupts.CPU39.RES:Rescheduling_interrupts
      0.17 ±223%      +0.0%       0.17 ±223%    +620.0%       1.20 ± 50%  interrupts.CPU39.TLB:TLB_shootdowns
      0.00          -100.0%       0.00         +3e+101%       0.30 ±152%  interrupts.CPU4.123:PCI-MSI.31981656-edge.i40e-eth0-TxRx-87
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU4.298:PCI-MSI.69632-edge.ioat-msix
     58.17 ±222%    -100.0%       0.00           +43.2%      83.30 ±163%  interrupts.CPU4.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
      0.33 ±141%     -50.0%       0.17 ±223%     -70.0%       0.10 ±300%  interrupts.CPU4.75:PCI-MSI.31981608-edge.i40e-eth0-TxRx-39
     21333 ± 92%     -65.6%       7339 ± 49%     -24.5%      16103 ±122%  interrupts.CPU4.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.2e+102%       1.20 ± 33%  interrupts.CPU4.IWI:IRQ_work_interrupts
     60682           -97.4%       1562 ± 62%    +110.5%     127741        interrupts.CPU4.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU4.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7127 ± 15%  interrupts.CPU4.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7127 ± 15%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
   1208419 ± 78%     -98.0%      23662 ± 79%     -40.9%     714733 ±105%  interrupts.CPU4.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00       +1.9e+102%       1.90 ±116%  interrupts.CPU4.TLB:TLB_shootdowns
      4.33 ±223%    -100.0%       0.00          +779.2%      38.10 ±276%  interrupts.CPU40.76:PCI-MSI.31981609-edge.i40e-eth0-TxRx-40
      3750 ±102%    +131.1%       8667 ± 78%     -39.7%       2261 ± 65%  interrupts.CPU40.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.8e+102%       1.80 ± 22%  interrupts.CPU40.IWI:IRQ_work_interrupts
     60247           -98.6%     873.00 ± 38%    +111.9%     127670        interrupts.CPU40.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU40.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7061 ± 22%  interrupts.CPU40.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7061 ± 22%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    504612 ± 87%     -97.1%      14691 ±148%     -34.8%     328814 ±110%  interrupts.CPU40.RES:Rescheduling_interrupts
      0.17 ±223%      +0.0%       0.17 ±223%    +620.0%       1.20 ± 50%  interrupts.CPU40.TLB:TLB_shootdowns
      1.50 ±223%     -77.8%       0.33 ±141%    -100.0%       0.00        interrupts.CPU41.77:PCI-MSI.31981610-edge.i40e-eth0-TxRx-41
      3767 ± 90%     -16.0%       3166 ±182%     -15.4%       3188 ± 89%  interrupts.CPU41.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.9e+102%       1.90 ± 28%  interrupts.CPU41.IWI:IRQ_work_interrupts
     60189           -98.9%     679.83 ± 77%    +112.2%     127720        interrupts.CPU41.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU41.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7063 ± 22%  interrupts.CPU41.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7063 ± 22%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    221441 ±118%     -96.2%       8401 ±220%      -0.6%     220119 ±154%  interrupts.CPU41.RES:Rescheduling_interrupts
      0.33 ±141%    -100.0%       0.00          +320.0%       1.40 ± 57%  interrupts.CPU41.TLB:TLB_shootdowns
      0.00       +2.3e+102%       2.33 ±223%    -100.0%       0.00        interrupts.CPU42.78:PCI-MSI.31981611-edge.i40e-eth0-TxRx-42
      1585 ± 57%    +381.9%       7638 ± 99%    +103.3%       3222 ± 95%  interrupts.CPU42.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.8e+102%       1.80 ± 22%  interrupts.CPU42.IWI:IRQ_work_interrupts
     60120           -98.9%     689.83 ± 32%    +112.3%     127652        interrupts.CPU42.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU42.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7061 ± 22%  interrupts.CPU42.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7061 ± 22%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
    453029 ±115%     -95.6%      20117 ±162%     -43.4%     256567 ± 84%  interrupts.CPU42.RES:Rescheduling_interrupts
      0.33 ±141%    -100.0%       0.00          +230.0%       1.10 ± 48%  interrupts.CPU42.TLB:TLB_shootdowns
      2.17 ± 41%   +9607.7%     210.33 ±221%     +15.4%       2.50 ±128%  interrupts.CPU43.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
      6036 ±121%     -39.2%       3669 ±103%     -75.8%       1463 ± 76%  interrupts.CPU43.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.9e+102%       1.90 ± 15%  interrupts.CPU43.IWI:IRQ_work_interrupts
     60176           -98.7%     777.83 ± 78%    +112.2%     127707        interrupts.CPU43.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU43.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7064 ± 22%  interrupts.CPU43.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7064 ± 22%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
    384869 ±102%     -99.1%       3568 ±116%     -64.2%     137733 ±200%  interrupts.CPU43.RES:Rescheduling_interrupts
      0.17 ±223%    +100.0%       0.33 ±141%    +680.0%       1.30 ± 49%  interrupts.CPU43.TLB:TLB_shootdowns
      0.17 ±223%  +3.7e+05%     623.50 ±223%   +5180.0%       8.80 ±231%  interrupts.CPU44.80:PCI-MSI.31981613-edge.i40e-eth0-TxRx-44
      3373 ± 78%     +81.8%       6133 ±141%     -38.4%       2078 ± 82%  interrupts.CPU44.CAL:Function_call_interrupts
      0.00          -100.0%       0.00         +2e+102%       2.00        interrupts.CPU44.IWI:IRQ_work_interrupts
     60121           -97.7%       1371 ±103%    +112.4%     127720        interrupts.CPU44.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU44.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.8e+105%       7848        interrupts.CPU44.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.8e+105%       7848        interrupts.CPU44.PMI:Performance_monitoring_interrupts
    348448 ± 69%     -96.4%      12641 ±145%     -45.9%     188589 ±128%  interrupts.CPU44.RES:Rescheduling_interrupts
      0.33 ±141%     +50.0%       0.50 ±100%    +290.0%       1.30 ± 60%  interrupts.CPU44.TLB:TLB_shootdowns
      0.00          -100.0%       0.00         +4e+101%       0.40 ±200%  interrupts.CPU45.81:PCI-MSI.31981614-edge.i40e-eth0-TxRx-45
      2046 ±166%     -13.5%       1770 ±124%     +29.5%       2649 ± 75%  interrupts.CPU45.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +2.1e+102%       2.10 ± 14%  interrupts.CPU45.IWI:IRQ_work_interrupts
     60203           -98.5%     905.17 ± 76%    +112.2%     127729        interrupts.CPU45.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU45.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.5e+105%       7459 ± 15%  interrupts.CPU45.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.5e+105%       7459 ± 15%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
    241934 ±112%     -99.3%       1802 ±139%     +34.7%     325961 ± 77%  interrupts.CPU45.RES:Rescheduling_interrupts
      0.67 ± 70%     -50.0%       0.33 ±141%    +155.0%       1.70 ± 45%  interrupts.CPU45.TLB:TLB_shootdowns
      0.00       +1.7e+102%       1.67 ±223%   +3e+101%       0.30 ±300%  interrupts.CPU46.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
      1101 ± 83%    +455.1%       6115 ±101%    +431.0%       5849 ± 79%  interrupts.CPU46.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +2.1e+102%       2.10 ± 14%  interrupts.CPU46.IWI:IRQ_work_interrupts
     60150           -98.6%     819.17 ±103%    +112.3%     127715        interrupts.CPU46.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU46.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.8e+105%       7850        interrupts.CPU46.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.8e+105%       7850        interrupts.CPU46.PMI:Performance_monitoring_interrupts
    186289 ±140%     -97.1%       5492 ±109%    +104.1%     380220 ± 71%  interrupts.CPU46.RES:Rescheduling_interrupts
      0.67 ± 70%     -25.0%       0.50 ±100%    +275.0%       2.50 ± 91%  interrupts.CPU46.TLB:TLB_shootdowns
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU47.83:PCI-MSI.31981616-edge.i40e-eth0-TxRx-47
      5280 ± 84%      +0.4%       5300 ±101%     -32.5%       3561 ± 71%  interrupts.CPU47.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.9e+102%       1.90 ± 28%  interrupts.CPU47.IWI:IRQ_work_interrupts
     60201           -98.9%     671.00 ± 16%    +112.1%     127692        interrupts.CPU47.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU47.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7063 ± 22%  interrupts.CPU47.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7063 ± 22%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
    362342 ± 70%     -97.8%       8136 ± 91%     +18.4%     428868 ± 67%  interrupts.CPU47.RES:Rescheduling_interrupts
      0.67 ± 70%     -50.0%       0.33 ±141%    +170.0%       1.80 ± 33%  interrupts.CPU47.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU48.295:PCI-MSI.65536-edge.ioat-msix
      0.17 ±223%      +0.0%       0.17 ±223%     -40.0%       0.10 ±300%  interrupts.CPU48.47:PCI-MSI.31981580-edge.i40e-eth0-TxRx-11
    107.33 ±223%     -98.9%       1.17 ±187%     -99.4%       0.60 ±300%  interrupts.CPU48.84:PCI-MSI.31981617-edge.i40e-eth0-TxRx-48
      0.00       +1.7e+101%       0.17 ±223%   +2e+101%       0.20 ±200%  interrupts.CPU48.95:PCI-MSI.31981628-edge.i40e-eth0-TxRx-59
     72094 ± 72%     -91.9%       5820 ± 96%     -24.9%      54165 ± 75%  interrupts.CPU48.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.4e+102%       1.40 ± 34%  interrupts.CPU48.IWI:IRQ_work_interrupts
     60657           -98.1%       1172 ± 22%    +110.5%     127709        interrupts.CPU48.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU48.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7113 ± 15%  interrupts.CPU48.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7113 ± 15%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
   1480231 ± 26%     -99.2%      11850 ± 99%     -32.3%    1001397 ± 50%  interrupts.CPU48.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00         +1220.0%       2.20 ±109%  interrupts.CPU48.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU49.3:IO-APIC.3-edge
      0.17 ±223%    -100.0%       0.00          +140.0%       0.40 ±122%  interrupts.CPU49.48:PCI-MSI.31981581-edge.i40e-eth0-TxRx-12
      0.00          -100.0%       0.00       +1.7e+103%      16.70 ±201%  interrupts.CPU49.85:PCI-MSI.31981618-edge.i40e-eth0-TxRx-49
      0.17 ±223%      +0.0%       0.17 ±223%     -40.0%       0.10 ±300%  interrupts.CPU49.96:PCI-MSI.31981629-edge.i40e-eth0-TxRx-60
     22343 ± 64%     -81.3%       4181 ±113%     +44.7%      32340 ± 97%  interrupts.CPU49.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.3e+102%       1.30 ± 60%  interrupts.CPU49.IWI:IRQ_work_interrupts
     60283           -98.1%       1139 ± 48%    +112.0%     127776        interrupts.CPU49.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU49.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6740 ± 22%  interrupts.CPU49.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6740 ± 22%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
    972258 ± 71%     -96.7%      32533 ±136%      -4.8%     925393 ± 30%  interrupts.CPU49.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00       +1.5e+102%       1.50 ± 44%  interrupts.CPU49.TLB:TLB_shootdowns
      0.17 ±223%    -100.0%       0.00           -40.0%       0.10 ±300%  interrupts.CPU5.124:PCI-MSI.31981657-edge.i40e-eth0-TxRx-88
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU5.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU5.298:PCI-MSI.69632-edge.ioat-msix
     20.67 ±161%   +3202.4%     682.50 ±223%    +469.0%     117.60 ±298%  interrupts.CPU5.41:PCI-MSI.31981574-edge.i40e-eth0-TxRx-5
      0.17 ±223%      +0.0%       0.17 ±223%     +20.0%       0.20 ±200%  interrupts.CPU5.76:PCI-MSI.31981609-edge.i40e-eth0-TxRx-40
     11749 ±108%     -55.4%       5240 ±110%     +57.7%      18527 ±108%  interrupts.CPU5.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.2e+102%       1.20 ± 62%  interrupts.CPU5.IWI:IRQ_work_interrupts
     60301           -89.0%       6626 ±173%    +111.9%     127755        interrupts.CPU5.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU5.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.4e+105%       6380 ± 27%  interrupts.CPU5.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.4e+105%       6380 ± 27%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
    499333 ±105%     -95.9%      20683 ±132%     +27.2%     635066 ± 95%  interrupts.CPU5.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +620.0%       1.20 ± 50%  interrupts.CPU5.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU50.295:PCI-MSI.65536-edge.ioat-msix
      0.00       +1.7e+101%       0.17 ±223%   +1e+101%       0.10 ±300%  interrupts.CPU50.49:PCI-MSI.31981582-edge.i40e-eth0-TxRx-13
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU50.4:IO-APIC.4-edge.ttyS0
      1.83 ±223%     -18.2%       1.50 ±223%     -72.7%       0.50 ±300%  interrupts.CPU50.86:PCI-MSI.31981619-edge.i40e-eth0-TxRx-50
      0.17 ±223%    -100.0%       0.00           +20.0%       0.20 ±200%  interrupts.CPU50.97:PCI-MSI.31981630-edge.i40e-eth0-TxRx-61
     12828 ±129%     -44.7%       7094 ±128%     +97.4%      25322 ± 86%  interrupts.CPU50.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.5e+102%       1.50 ± 33%  interrupts.CPU50.IWI:IRQ_work_interrupts
     60301           -97.9%       1247 ± 42%    +111.8%     127725        interrupts.CPU50.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU50.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7115 ± 15%  interrupts.CPU50.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7115 ± 15%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
    594153 ± 76%     -95.2%      28647 ±110%     +13.7%     675773 ± 52%  interrupts.CPU50.RES:Rescheduling_interrupts
      0.17 ±223%      +0.0%       0.17 ±223%    +800.0%       1.50 ± 53%  interrupts.CPU50.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU51.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU51.4:IO-APIC.4-edge.ttyS0
      0.00       +1.7e+101%       0.17 ±223%   +2e+101%       0.20 ±200%  interrupts.CPU51.50:PCI-MSI.31981583-edge.i40e-eth0-TxRx-14
      2.00 ±202%    +566.7%      13.33 ±223%    +605.0%      14.10 ±290%  interrupts.CPU51.87:PCI-MSI.31981620-edge.i40e-eth0-TxRx-51
      0.33 ±141%     +50.0%       0.50 ±100%    -100.0%       0.00        interrupts.CPU51.98:PCI-MSI.31981631-edge.i40e-eth0-TxRx-62
      6959 ± 82%      -0.4%       6930 ± 87%     +90.3%      13243 ±108%  interrupts.CPU51.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.1e+102%       1.10 ± 27%  interrupts.CPU51.IWI:IRQ_work_interrupts
     60363           -98.2%       1103 ± 49%    +111.6%     127752        interrupts.CPU51.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU51.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7116 ± 15%  interrupts.CPU51.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7116 ± 15%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
    565296 ±120%     -94.9%      28596 ±110%      +8.0%     610312 ± 90%  interrupts.CPU51.RES:Rescheduling_interrupts
      1.33 ±223%     -87.5%       0.17 ±223%     +35.0%       1.80 ± 48%  interrupts.CPU51.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU52.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU52.3:IO-APIC.3-edge
      0.33 ±141%    -100.0%       0.00           +20.0%       0.40 ±122%  interrupts.CPU52.51:PCI-MSI.31981584-edge.i40e-eth0-TxRx-15
      0.00       +4.8e+103%      47.83 ±212% +1.9e+102%       1.90 ±200%  interrupts.CPU52.88:PCI-MSI.31981621-edge.i40e-eth0-TxRx-52
      0.17 ±223%      +0.0%       0.17 ±223%     -40.0%       0.10 ±300%  interrupts.CPU52.99:PCI-MSI.31981632-edge.i40e-eth0-TxRx-63
     20767 ± 97%     -73.0%       5603 ± 74%     -16.7%      17300 ±130%  interrupts.CPU52.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.3e+102%       1.30 ± 49%  interrupts.CPU52.IWI:IRQ_work_interrupts
     60334           -97.4%       1567 ± 66%    +111.8%     127761        interrupts.CPU52.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU52.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6741 ± 22%  interrupts.CPU52.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6741 ± 22%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
    907891 ± 77%     -98.4%      14749 ±109%      -8.4%     831312 ± 87%  interrupts.CPU52.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +740.0%       1.40 ± 34%  interrupts.CPU52.TLB:TLB_shootdowns
      0.50 ±100%     -33.3%       0.33 ±141%     -80.0%       0.10 ±300%  interrupts.CPU53.100:PCI-MSI.31981633-edge.i40e-eth0-TxRx-64
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU53.3:IO-APIC.3-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU53.4:IO-APIC.4-edge.ttyS0
      0.33 ±141%      +0.0%       0.33 ±141%     -40.0%       0.20 ±200%  interrupts.CPU53.52:PCI-MSI.31981585-edge.i40e-eth0-TxRx-16
      0.33 ±223%    +700.0%       2.67 ±223%    -100.0%       0.00        interrupts.CPU53.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
      7554 ±135%     -64.0%       2716 ±108%    +160.3%      19660 ±116%  interrupts.CPU53.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.2e+102%       1.20 ± 62%  interrupts.CPU53.IWI:IRQ_work_interrupts
     60300           -98.5%     881.83 ± 54%    +111.8%     127697        interrupts.CPU53.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU53.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.4e+105%       6366 ± 26%  interrupts.CPU53.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.4e+105%       6366 ± 26%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
    358259 ±153%     -80.8%      68715 ±184%    +134.5%     839998 ± 87%  interrupts.CPU53.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +860.0%       1.60 ± 41%  interrupts.CPU53.TLB:TLB_shootdowns
      0.50 ±100%    -100.0%       0.00           -60.0%       0.20 ±200%  interrupts.CPU54.101:PCI-MSI.31981634-edge.i40e-eth0-TxRx-65
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU54.3:IO-APIC.3-edge
      0.33 ±141%     -50.0%       0.17 ±223%     -70.0%       0.10 ±300%  interrupts.CPU54.53:PCI-MSI.31981586-edge.i40e-eth0-TxRx-17
      0.67 ±165%    +500.0%       4.00 ±192%     -55.0%       0.30 ±213%  interrupts.CPU54.90:PCI-MSI.31981623-edge.i40e-eth0-TxRx-54
      6216 ± 92%     -35.8%       3989 ±146%     -35.7%       3994 ±114%  interrupts.CPU54.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.1e+102%       1.10 ± 48%  interrupts.CPU54.IWI:IRQ_work_interrupts
     60308           -97.9%       1262 ± 46%    +111.8%     127755        interrupts.CPU54.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU54.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.4e+105%       6366 ± 26%  interrupts.CPU54.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.4e+105%       6366 ± 26%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
    711419 ± 66%     -94.0%      42360 ±203%      -9.7%     642222 ± 81%  interrupts.CPU54.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00       +1.5e+102%       1.50 ± 33%  interrupts.CPU54.TLB:TLB_shootdowns
      0.17 ±223%    -100.0%       0.00           -40.0%       0.10 ±300%  interrupts.CPU55.102:PCI-MSI.31981635-edge.i40e-eth0-TxRx-66
      0.17 ±223%    +100.0%       0.33 ±141%     -40.0%       0.10 ±300%  interrupts.CPU55.54:PCI-MSI.31981587-edge.i40e-eth0-TxRx-18
      1.00 ±223%    +316.7%       4.17 ±223%     +20.0%       1.20 ±249%  interrupts.CPU55.91:PCI-MSI.31981624-edge.i40e-eth0-TxRx-55
     10162 ± 95%     -52.8%       4798 ±126%     -21.8%       7949 ±112%  interrupts.CPU55.CAL:Function_call_interrupts
      0.00          -100.0%       0.00         +9e+101%       0.90 ± 33%  interrupts.CPU55.IWI:IRQ_work_interrupts
     60320           -97.8%       1312 ± 37%    +111.8%     127764        interrupts.CPU55.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU55.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.4e+105%       6367 ± 26%  interrupts.CPU55.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.4e+105%       6367 ± 26%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
    417556 ± 89%     -94.1%      24502 ±172%     +39.1%     580835 ± 93%  interrupts.CPU55.RES:Rescheduling_interrupts
      0.00       +3.3e+101%       0.33 ±141% +1.3e+102%       1.30 ± 35%  interrupts.CPU55.TLB:TLB_shootdowns
      0.17 ±223%    +100.0%       0.33 ±141%     -40.0%       0.10 ±300%  interrupts.CPU56.103:PCI-MSI.31981636-edge.i40e-eth0-TxRx-67
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU56.299:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU56.3:IO-APIC.3-edge
      0.17 ±223%      +0.0%       0.17 ±223%     -40.0%       0.10 ±300%  interrupts.CPU56.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
      2.50 ±162%    -100.0%       0.00          +600.0%      17.50 ±198%  interrupts.CPU56.92:PCI-MSI.31981625-edge.i40e-eth0-TxRx-56
     12238 ±100%     -38.7%       7502 ± 79%      +8.5%      13282 ± 86%  interrupts.CPU56.CAL:Function_call_interrupts
      0.00          -100.0%       0.00         +9e+101%       0.90 ± 59%  interrupts.CPU56.IWI:IRQ_work_interrupts
     60296           -98.1%       1166 ± 55%    +111.8%     127717        interrupts.CPU56.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU56.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.4e+105%       6367 ± 26%  interrupts.CPU56.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.4e+105%       6367 ± 26%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
    304719 ± 92%     -94.7%      16036 ± 73%    +165.2%     808235 ± 64%  interrupts.CPU56.RES:Rescheduling_interrupts
      0.00       +1.7e+101%       0.17 ±223% +1.4e+102%       1.40 ± 34%  interrupts.CPU56.TLB:TLB_shootdowns
      0.17 ±223%      +0.0%       0.17 ±223%     -40.0%       0.10 ±300%  interrupts.CPU57.104:PCI-MSI.31981637-edge.i40e-eth0-TxRx-68
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU57.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU57.4:IO-APIC.4-edge.ttyS0
      0.17 ±223%    -100.0%       0.00           +80.0%       0.30 ±152%  interrupts.CPU57.56:PCI-MSI.31981589-edge.i40e-eth0-TxRx-20
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU57.93:PCI-MSI.31981626-edge.i40e-eth0-TxRx-57
      3434 ±114%     +21.6%       4177 ± 95%    +135.6%       8090 ± 66%  interrupts.CPU57.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.2e+102%       1.20 ± 62%  interrupts.CPU57.IWI:IRQ_work_interrupts
     60249           -96.1%       2322 ± 65%    +112.0%     127757        interrupts.CPU57.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU57.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6744 ± 22%  interrupts.CPU57.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6744 ± 22%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
    412362 ± 70%     -96.4%      14970 ±125%     +81.7%     749207 ± 84%  interrupts.CPU57.RES:Rescheduling_interrupts
      0.00       +1.7e+101%       0.17 ±223% +1.5e+102%       1.50 ± 44%  interrupts.CPU57.TLB:TLB_shootdowns
      0.17 ±223%      +0.0%       0.17 ±223%    -100.0%       0.00        interrupts.CPU58.105:PCI-MSI.31981638-edge.i40e-eth0-TxRx-69
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU58.3:IO-APIC.3-edge
      0.17 ±223%    -100.0%       0.00           +20.0%       0.20 ±200%  interrupts.CPU58.57:PCI-MSI.31981590-edge.i40e-eth0-TxRx-21
      0.17 ±223%    -100.0%       0.00        +32420.0%      54.20 ±297%  interrupts.CPU58.94:PCI-MSI.31981627-edge.i40e-eth0-TxRx-58
      3941 ±126%     -33.0%       2641 ±124%    +240.8%      13432 ±130%  interrupts.CPU58.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.2e+102%       1.20 ± 62%  interrupts.CPU58.IWI:IRQ_work_interrupts
     60303           -97.5%       1494 ± 48%    +111.8%     127741        interrupts.CPU58.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU58.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6745 ± 22%  interrupts.CPU58.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6745 ± 22%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
    409161 ±106%     -99.1%       3873 ±138%     +53.2%     626897 ± 84%  interrupts.CPU58.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +860.0%       1.60 ± 41%  interrupts.CPU58.TLB:TLB_shootdowns
      0.33 ±141%    -100.0%       0.00           -40.0%       0.20 ±200%  interrupts.CPU59.106:PCI-MSI.31981639-edge.i40e-eth0-TxRx-70
      0.00       +1.7e+101%       0.17 ±223%   +2e+101%       0.20 ±200%  interrupts.CPU59.58:PCI-MSI.31981591-edge.i40e-eth0-TxRx-22
      0.00       +1.4e+106%      14483 ±223% +2.8e+102%       2.80 ±288%  interrupts.CPU59.95:PCI-MSI.31981628-edge.i40e-eth0-TxRx-59
      9523 ± 46%     -13.7%       8218 ± 75%      -9.4%       8628 ± 92%  interrupts.CPU59.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.2e+102%       1.20 ± 50%  interrupts.CPU59.IWI:IRQ_work_interrupts
     60351           -83.9%       9746 ±180%    +111.7%     127764        interrupts.CPU59.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU59.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7119 ± 15%  interrupts.CPU59.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7119 ± 15%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
    553347 ± 86%     -97.4%      14470 ± 74%     +17.2%     648302 ± 77%  interrupts.CPU59.RES:Rescheduling_interrupts
      0.17 ±223%    +900.0%       1.67 ±175%    +620.0%       1.20 ± 33%  interrupts.CPU59.TLB:TLB_shootdowns
      0.00          -100.0%       0.00         +2e+101%       0.20 ±200%  interrupts.CPU6.125:PCI-MSI.31981658-edge.i40e-eth0-TxRx-89
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU6.300:PCI-MSI.73728-edge.ioat-msix
     50.17 ±223%     -93.7%       3.17 ±184%     -96.0%       2.00 ±203%  interrupts.CPU6.42:PCI-MSI.31981575-edge.i40e-eth0-TxRx-6
      0.17 ±223%    +100.0%       0.33 ±141%     +20.0%       0.20 ±200%  interrupts.CPU6.77:PCI-MSI.31981610-edge.i40e-eth0-TxRx-41
      8584 ± 63%     -59.2%       3503 ±180%     -43.3%       4864 ± 70%  interrupts.CPU6.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.2e+102%       1.20 ± 50%  interrupts.CPU6.IWI:IRQ_work_interrupts
     60471           -97.7%       1402 ± 61%    +111.2%     127741        interrupts.CPU6.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU6.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.8e+105%       6753 ± 22%  interrupts.CPU6.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.8e+105%       6753 ± 22%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
    728478 ± 39%     -99.3%       4794 ±188%      -4.9%     693015 ± 64%  interrupts.CPU6.RES:Rescheduling_interrupts
      1.33 ±223%    -100.0%       0.00           -32.5%       0.90 ± 77%  interrupts.CPU6.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU60.107:PCI-MSI.31981640-edge.i40e-eth0-TxRx-71
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU60.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU60.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU60.298:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU60.3:IO-APIC.3-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU60.4:IO-APIC.4-edge.ttyS0
      0.33 ±141%     -50.0%       0.17 ±223%     -40.0%       0.20 ±200%  interrupts.CPU60.59:PCI-MSI.31981592-edge.i40e-eth0-TxRx-23
     19.17 ±223%   +3179.1%     628.50 ±223%     -99.5%       0.10 ±300%  interrupts.CPU60.96:PCI-MSI.31981629-edge.i40e-eth0-TxRx-60
     18937 ±208%     -80.2%       3747 ± 90%     -62.1%       7178 ±108%  interrupts.CPU60.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.2e+102%       1.20 ± 50%  interrupts.CPU60.IWI:IRQ_work_interrupts
     60352           -96.7%       1988 ± 84%    +111.7%     127790        interrupts.CPU60.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU60.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6744 ± 22%  interrupts.CPU60.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6744 ± 22%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
    472502 ± 89%     -97.9%       9851 ±112%     +18.6%     560450 ± 91%  interrupts.CPU60.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00       +2.2e+102%       2.20 ±107%  interrupts.CPU60.TLB:TLB_shootdowns
      0.17 ±223%      +0.0%       0.17 ±223%    -100.0%       0.00        interrupts.CPU61.108:PCI-MSI.31981641-edge.i40e-eth0-TxRx-72
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU61.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU61.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU61.298:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU61.299:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU61.3:IO-APIC.3-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU61.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
      0.00          -100.0%       0.00       +5.6e+103%      56.30 ±299%  interrupts.CPU61.97:PCI-MSI.31981630-edge.i40e-eth0-TxRx-61
     11394 ± 94%     -86.6%       1522 ± 87%     -34.5%       7458 ±108%  interrupts.CPU61.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.2e+102%       1.20 ± 50%  interrupts.CPU61.IWI:IRQ_work_interrupts
     60386           -98.2%       1089 ± 27%    +111.6%     127779        interrupts.CPU61.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU61.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7118 ± 15%  interrupts.CPU61.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7118 ± 15%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
    589897 ± 85%     -94.3%      33616 ±201%     -18.3%     482124 ±112%  interrupts.CPU61.RES:Rescheduling_interrupts
      0.33 ±141%    -100.0%       0.00          +530.0%       2.10 ±126%  interrupts.CPU61.TLB:TLB_shootdowns
      0.00       +3.3e+101%       0.33 ±141%    -100.0%       0.00        interrupts.CPU62.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU62.298:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU62.299:PCI-MSI.71680-edge.ioat-msix
      0.17 ±223%    -100.0%       0.00           -40.0%       0.10 ±300%  interrupts.CPU62.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
     37.00 ±162%     -95.5%       1.67 ±223%    -100.0%       0.00        interrupts.CPU62.98:PCI-MSI.31981631-edge.i40e-eth0-TxRx-62
     11003 ±150%     -94.1%     647.33 ± 30%     -54.8%       4975 ±160%  interrupts.CPU62.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.4e+102%       1.40 ± 34%  interrupts.CPU62.IWI:IRQ_work_interrupts
     60323           -98.6%     817.67 ± 45%    +112.0%     127859        interrupts.CPU62.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU62.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.5e+105%       7493        interrupts.CPU62.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.5e+105%       7493        interrupts.CPU62.PMI:Performance_monitoring_interrupts
    174644 ±177%     -99.8%     365.33 ±188%    +108.3%     363773 ±122%  interrupts.CPU62.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +800.0%       1.50 ± 44%  interrupts.CPU62.TLB:TLB_shootdowns
      0.00          -100.0%       0.00         +5e+101%       0.50 ±100%  interrupts.CPU63.110:PCI-MSI.31981643-edge.i40e-eth0-TxRx-74
      0.33 ±141%     -50.0%       0.17 ±223%    -100.0%       0.00        interrupts.CPU63.62:PCI-MSI.31981595-edge.i40e-eth0-TxRx-26
     82.17 ±215%     -80.1%      16.33 ±178%    -100.0%       0.00        interrupts.CPU63.99:PCI-MSI.31981632-edge.i40e-eth0-TxRx-63
     17034 ±167%     -66.9%       5639 ± 69%     -76.6%       3990 ±133%  interrupts.CPU63.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.3e+102%       1.30 ± 35%  interrupts.CPU63.IWI:IRQ_work_interrupts
     60348           -97.9%       1240 ± 42%    +111.7%     127757        interrupts.CPU63.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU63.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.5e+105%       7492        interrupts.CPU63.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.5e+105%       7492        interrupts.CPU63.PMI:Performance_monitoring_interrupts
    555092 ± 91%     -96.4%      20004 ± 70%     -21.1%     438068 ±140%  interrupts.CPU63.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +620.0%       1.20 ± 50%  interrupts.CPU63.TLB:TLB_shootdowns
      5.50 ±215%     -87.9%       0.67 ±223%     -76.4%       1.30 ±275%  interrupts.CPU64.100:PCI-MSI.31981633-edge.i40e-eth0-TxRx-64
      0.33 ±141%    -100.0%       0.00           -40.0%       0.20 ±200%  interrupts.CPU64.111:PCI-MSI.31981644-edge.i40e-eth0-TxRx-75
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU64.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU64.300:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU64.3:IO-APIC.3-edge
      0.17 ±223%    +100.0%       0.33 ±141%     -40.0%       0.10 ±300%  interrupts.CPU64.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
      2901 ±173%    +171.7%       7881 ± 44%     +41.7%       4112 ± 89%  interrupts.CPU64.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.3e+102%       1.30 ± 35%  interrupts.CPU64.IWI:IRQ_work_interrupts
     60447           -98.2%       1069 ± 32%    +111.4%     127789        interrupts.CPU64.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU64.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7117 ± 15%  interrupts.CPU64.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7117 ± 15%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
    128532 ±107%     -74.9%      32309 ± 77%    +258.1%     460224 ±119%  interrupts.CPU64.RES:Rescheduling_interrupts
      0.17 ±223%      +0.0%       0.17 ±223%    +740.0%       1.40 ± 34%  interrupts.CPU64.TLB:TLB_shootdowns
      0.67 ±223%     -50.0%       0.33 ±223%     -85.0%       0.10 ±300%  interrupts.CPU65.101:PCI-MSI.31981634-edge.i40e-eth0-TxRx-65
      0.17 ±223%    -100.0%       0.00           -40.0%       0.10 ±300%  interrupts.CPU65.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU65.298:PCI-MSI.69632-edge.ioat-msix
      0.00       +1.7e+101%       0.17 ±223%   +1e+101%       0.10 ±300%  interrupts.CPU65.64:PCI-MSI.31981597-edge.i40e-eth0-TxRx-28
      2696 ± 57%     +37.1%       3695 ±145%     +49.9%       4040 ±145%  interrupts.CPU65.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.1e+102%       1.10 ± 27%  interrupts.CPU65.IWI:IRQ_work_interrupts
     60375           -97.3%       1611 ± 50%    +111.6%     127742        interrupts.CPU65.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU65.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.5e+105%       7491        interrupts.CPU65.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.5e+105%       7491        interrupts.CPU65.PMI:Performance_monitoring_interrupts
    269531 ±116%     -95.1%      13162 ±207%     +56.3%     421272 ±101%  interrupts.CPU65.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +680.0%       1.30 ± 35%  interrupts.CPU65.TLB:TLB_shootdowns
      6.00 ±161%    +800.0%      54.00 ±223%    +473.3%      34.40 ±218%  interrupts.CPU66.102:PCI-MSI.31981635-edge.i40e-eth0-TxRx-66
      0.00          -100.0%       0.00         +2e+101%       0.20 ±200%  interrupts.CPU66.113:PCI-MSI.31981646-edge.i40e-eth0-TxRx-77
      0.17 ±223%      +0.0%       0.17 ±223%    +140.0%       0.40 ±122%  interrupts.CPU66.65:PCI-MSI.31981598-edge.i40e-eth0-TxRx-29
     18067 ±181%     -85.1%       2697 ±175%     -35.0%      11741 ±188%  interrupts.CPU66.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.1e+102%       1.10 ± 48%  interrupts.CPU66.IWI:IRQ_work_interrupts
     60396           -98.1%       1141 ± 47%    +111.5%     127760        interrupts.CPU66.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU66.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6741 ± 22%  interrupts.CPU66.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6741 ± 22%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
    372632 ±111%     -97.4%       9601 ±214%     +26.8%     472568 ±122%  interrupts.CPU66.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +860.0%       1.60 ± 41%  interrupts.CPU66.TLB:TLB_shootdowns
     25.33 ±223%     -94.7%       1.33 ±147%     -89.3%       2.70 ±287%  interrupts.CPU67.103:PCI-MSI.31981636-edge.i40e-eth0-TxRx-67
      0.00       +1.7e+101%       0.17 ±223%   +2e+101%       0.20 ±200%  interrupts.CPU67.114:PCI-MSI.31981647-edge.i40e-eth0-TxRx-78
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU67.299:PCI-MSI.71680-edge.ioat-msix
      0.17 ±223%    -100.0%       0.00          +200.0%       0.50 ±100%  interrupts.CPU67.66:PCI-MSI.31981599-edge.i40e-eth0-TxRx-30
      1879 ± 73%    +194.3%       5532 ±180%    +338.4%       8241 ±145%  interrupts.CPU67.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.2e+102%       1.20 ± 33%  interrupts.CPU67.IWI:IRQ_work_interrupts
     60729           -98.3%       1019 ± 42%    +110.4%     127798        interrupts.CPU67.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU67.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7113 ± 15%  interrupts.CPU67.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7113 ± 15%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
    588614 ±128%     -93.1%      40600 ±184%     -44.0%     329562 ±112%  interrupts.CPU67.RES:Rescheduling_interrupts
      0.33 ±141%    +350.0%       1.50 ±195%    +380.0%       1.60 ± 57%  interrupts.CPU67.TLB:TLB_shootdowns
      0.00          -100.0%       0.00         +8e+102%       8.00 ±268%  interrupts.CPU68.104:PCI-MSI.31981637-edge.i40e-eth0-TxRx-68
      0.17 ±223%      +0.0%       0.17 ±223%    -100.0%       0.00        interrupts.CPU68.115:PCI-MSI.31981648-edge.i40e-eth0-TxRx-79
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU68.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU68.298:PCI-MSI.69632-edge.ioat-msix
      0.50 ±100%     -33.3%       0.33 ±141%     -60.0%       0.20 ±200%  interrupts.CPU68.67:PCI-MSI.31981600-edge.i40e-eth0-TxRx-31
      3018 ± 60%     +97.4%       5958 ± 70%    +183.5%       8557 ±153%  interrupts.CPU68.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.2e+102%       1.20 ± 50%  interrupts.CPU68.IWI:IRQ_work_interrupts
     60344           -98.7%     807.00 ± 31%    +111.7%     127753        interrupts.CPU68.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU68.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6739 ± 22%  interrupts.CPU68.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6739 ± 22%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
    155749 ± 95%     -83.3%      25947 ±145%    +402.3%     782270 ±125%  interrupts.CPU68.RES:Rescheduling_interrupts
      0.33 ±223%     -50.0%       0.17 ±223%    +320.0%       1.40 ± 34%  interrupts.CPU68.TLB:TLB_shootdowns
      0.33 ±223%   +9550.0%      32.17 ±222%    -100.0%       0.00        interrupts.CPU69.105:PCI-MSI.31981638-edge.i40e-eth0-TxRx-69
      0.50 ±100%     -66.7%       0.17 ±223%     -40.0%       0.30 ±152%  interrupts.CPU69.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU69.300:PCI-MSI.73728-edge.ioat-msix
      0.00       +1.7e+101%       0.17 ±223%   +4e+101%       0.40 ±122%  interrupts.CPU69.68:PCI-MSI.31981601-edge.i40e-eth0-TxRx-32
      4982 ±137%     -81.9%     900.67 ± 72%    +149.5%      12429 ±157%  interrupts.CPU69.CAL:Function_call_interrupts
      0.00          -100.0%       0.00         +1e+102%       1.00        interrupts.CPU69.IWI:IRQ_work_interrupts
     60373           -98.4%     980.33 ± 34%    +111.7%     127801        interrupts.CPU69.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU69.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7113 ± 15%  interrupts.CPU69.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7113 ± 15%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
    335179 ±146%     -99.9%     386.17 ±156%     +13.9%     381691 ±104%  interrupts.CPU69.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +740.0%       1.40 ± 34%  interrupts.CPU69.TLB:TLB_shootdowns
      0.00       +1.7e+101%       0.17 ±223%   +1e+101%       0.10 ±300%  interrupts.CPU7.126:PCI-MSI.31981659-edge.i40e-eth0-TxRx-90
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU7.297:PCI-MSI.67584-edge.ioat-msix
      0.33 ±223%    +250.0%       1.17 ±159%     -40.0%       0.20 ±300%  interrupts.CPU7.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
      0.33 ±141%      +0.0%       0.33 ±141%    -100.0%       0.00        interrupts.CPU7.78:PCI-MSI.31981611-edge.i40e-eth0-TxRx-42
     10913 ± 94%     -49.8%       5483 ± 90%     +30.0%      14187 ±158%  interrupts.CPU7.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.4e+102%       1.40 ± 47%  interrupts.CPU7.IWI:IRQ_work_interrupts
     60329           -97.8%       1354 ± 54%    +111.7%     127746        interrupts.CPU7.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU7.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7128 ± 15%  interrupts.CPU7.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7128 ± 15%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
    318802 ± 99%     -92.6%      23440 ±119%    +110.9%     672288 ±113%  interrupts.CPU7.RES:Rescheduling_interrupts
      0.17 ±223%      +0.0%       0.17 ±223%    +440.0%       0.90 ± 77%  interrupts.CPU7.TLB:TLB_shootdowns
     12.67 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU70.106:PCI-MSI.31981639-edge.i40e-eth0-TxRx-70
      0.17 ±223%      +0.0%       0.17 ±223%     -40.0%       0.10 ±300%  interrupts.CPU70.117:PCI-MSI.31981650-edge.i40e-eth0-TxRx-81
      0.33 ±141%    -100.0%       0.00           -70.0%       0.10 ±300%  interrupts.CPU70.69:PCI-MSI.31981602-edge.i40e-eth0-TxRx-33
      1785 ± 93%     +88.6%       3366 ± 79%    +406.7%       9044 ±137%  interrupts.CPU70.CAL:Function_call_interrupts
      0.00          -100.0%       0.00         +9e+101%       0.90 ± 33%  interrupts.CPU70.IWI:IRQ_work_interrupts
     60385           -97.0%       1821 ± 52%    +111.6%     127752        interrupts.CPU70.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU70.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7114 ± 15%  interrupts.CPU70.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7114 ± 15%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
     54658 ±105%     -79.9%      10961 ± 87%    +651.0%     410459 ±124%  interrupts.CPU70.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00       +1.5e+102%       1.50 ± 44%  interrupts.CPU70.TLB:TLB_shootdowns
      2.50 ±223%     -86.7%       0.33 ±141%    +212.0%       7.80 ±177%  interrupts.CPU71.107:PCI-MSI.31981640-edge.i40e-eth0-TxRx-71
      0.00         +5e+101%       0.50 ±100%   +1e+101%       0.10 ±300%  interrupts.CPU71.118:PCI-MSI.31981651-edge.i40e-eth0-TxRx-82
      0.00       +3.3e+101%       0.33 ±141%    -100.0%       0.00        interrupts.CPU71.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
      5926 ±118%     -29.6%       4174 ±150%      -8.3%       5436 ±103%  interrupts.CPU71.CAL:Function_call_interrupts
      0.00          -100.0%       0.00         +1e+102%       1.00        interrupts.CPU71.IWI:IRQ_work_interrupts
     60434           -98.1%       1123 ± 33%    +111.4%     127750        interrupts.CPU71.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU71.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7114 ± 15%  interrupts.CPU71.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7114 ± 15%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
    507707 ±109%     -98.4%       7873 ±135%     -53.0%     238608 ±102%  interrupts.CPU71.RES:Rescheduling_interrupts
      0.00       +1.7e+101%       0.17 ±223% +1.6e+102%       1.60 ± 57%  interrupts.CPU71.TLB:TLB_shootdowns
      4.33 ±223%    -100.0%       0.00          +255.4%      15.40 ±300%  interrupts.CPU72.108:PCI-MSI.31981641-edge.i40e-eth0-TxRx-72
     11035 ± 60%     -83.6%       1806 ±135%     -13.4%       9560 ± 61%  interrupts.CPU72.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.9e+102%       1.90 ± 28%  interrupts.CPU72.IWI:IRQ_work_interrupts
     60333           -98.9%     660.50 ± 37%    +111.7%     127735        interrupts.CPU72.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU72.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7062 ± 22%  interrupts.CPU72.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7062 ± 22%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
    258639 ± 88%     -98.7%       3233 ±210%     +55.5%     402137 ± 56%  interrupts.CPU72.RES:Rescheduling_interrupts
      0.50 ±100%    -100.0%       0.00          +160.0%       1.30 ± 35%  interrupts.CPU72.TLB:TLB_shootdowns
      0.17 ±223%    +800.0%       1.50 ±223%   +9080.0%      15.30 ±200%  interrupts.CPU73.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
      9560 ±104%     -53.4%       4453 ±111%      +7.6%      10285 ± 82%  interrupts.CPU73.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +2.2e+102%       2.20 ± 27%  interrupts.CPU73.IWI:IRQ_work_interrupts
     60284           -98.4%     991.67 ± 32%    +112.0%     127804        interrupts.CPU73.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU73.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.5e+105%       7459 ± 15%  interrupts.CPU73.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.5e+105%       7459 ± 15%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
    288831 ± 76%     -95.7%      12327 ±162%     +70.1%     491219 ± 60%  interrupts.CPU73.RES:Rescheduling_interrupts
      0.33 ±223%    -100.0%       0.00          +380.0%       1.60 ± 41%  interrupts.CPU73.TLB:TLB_shootdowns
      4.33 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU74.110:PCI-MSI.31981643-edge.i40e-eth0-TxRx-74
      6498 ±111%     -63.7%       2356 ±173%     +26.2%       8198 ± 92%  interrupts.CPU74.CAL:Function_call_interrupts
      0.00          -100.0%       0.00         +2e+102%       2.00 ± 22%  interrupts.CPU74.IWI:IRQ_work_interrupts
     60239           -98.1%       1148 ± 68%    +112.0%     127715        interrupts.CPU74.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU74.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.5e+105%       7457 ± 15%  interrupts.CPU74.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.5e+105%       7457 ± 15%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
    433997 ±103%     -99.5%       2368 ±216%      +5.8%     458984 ± 45%  interrupts.CPU74.RES:Rescheduling_interrupts
      0.50 ±100%     -33.3%       0.33 ±223%    +200.0%       1.50 ± 33%  interrupts.CPU74.TLB:TLB_shootdowns
      4.00 ±144%    -100.0%       0.00           -97.5%       0.10 ±300%  interrupts.CPU75.111:PCI-MSI.31981644-edge.i40e-eth0-TxRx-75
      8525 ±125%      -8.7%       7781 ± 82%     +43.1%      12200 ± 77%  interrupts.CPU75.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.6e+102%       1.60 ± 30%  interrupts.CPU75.IWI:IRQ_work_interrupts
     60310           -98.1%       1164 ± 44%    +111.7%     127705        interrupts.CPU75.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU75.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.3e+105%       6276 ± 30%  interrupts.CPU75.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.3e+105%       6276 ± 30%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
    482166 ± 65%     -98.5%       7259 ± 97%     -12.4%     422436 ±121%  interrupts.CPU75.RES:Rescheduling_interrupts
      0.83 ± 44%     -40.0%       0.50 ±100%     +92.0%       1.60 ± 30%  interrupts.CPU75.TLB:TLB_shootdowns
      0.00       +1.7e+101%       0.17 ±223% +1.1e+104%     113.30 ±196%  interrupts.CPU76.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
      5111 ± 72%     -10.9%       4555 ±142%     +71.6%       8769 ±181%  interrupts.CPU76.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.8e+102%       1.80 ± 33%  interrupts.CPU76.IWI:IRQ_work_interrupts
     60295           -98.5%     884.83 ± 33%    +111.8%     127705        interrupts.CPU76.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU76.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6670 ± 26%  interrupts.CPU76.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6670 ± 26%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
    600012 ± 99%     -99.5%       3234 ±147%     -67.1%     197154 ± 90%  interrupts.CPU76.RES:Rescheduling_interrupts
      0.50 ±152%     -66.7%       0.17 ±223%    +220.0%       1.60 ± 41%  interrupts.CPU76.TLB:TLB_shootdowns
      0.50 ±223%   +1800.0%       9.50 ±209%     -60.0%       0.20 ±200%  interrupts.CPU77.113:PCI-MSI.31981646-edge.i40e-eth0-TxRx-77
      3897 ± 94%     -84.5%     605.17 ± 22%    +199.7%      11679 ±164%  interrupts.CPU77.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.6e+102%       1.60 ± 30%  interrupts.CPU77.IWI:IRQ_work_interrupts
     60324           -96.9%       1892 ± 86%    +111.8%     127769        interrupts.CPU77.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU77.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.3e+105%       6275 ± 30%  interrupts.CPU77.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.3e+105%       6275 ± 30%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
    241911 ± 80%     -99.9%     189.83 ±132%     +19.8%     289713 ± 71%  interrupts.CPU77.RES:Rescheduling_interrupts
      0.33 ±141%     +50.0%       0.50 ±100%    +320.0%       1.40 ± 34%  interrupts.CPU77.TLB:TLB_shootdowns
      0.00          -100.0%       0.00       +7.8e+102%       7.80 ±173%  interrupts.CPU78.114:PCI-MSI.31981647-edge.i40e-eth0-TxRx-78
      9485 ± 99%     -59.8%       3814 ±133%     -46.0%       5122 ±161%  interrupts.CPU78.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+102%       1.70 ± 37%  interrupts.CPU78.IWI:IRQ_work_interrupts
     60343           -97.5%       1503 ± 47%    +111.7%     127736        interrupts.CPU78.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU78.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.3e+105%       6278 ± 30%  interrupts.CPU78.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.3e+105%       6278 ± 30%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
    406309 ± 49%     -98.7%       5159 ±147%     -25.7%     301978 ±131%  interrupts.CPU78.RES:Rescheduling_interrupts
      0.33 ±141%    -100.0%       0.00          +440.0%       1.80 ± 64%  interrupts.CPU78.TLB:TLB_shootdowns
     38.00 ±122%   +2201.8%     874.67 ±174%     -66.8%      12.60 ±300%  interrupts.CPU79.115:PCI-MSI.31981648-edge.i40e-eth0-TxRx-79
      3494 ± 61%     +49.9%       5237 ±144%     +28.6%       4492 ±185%  interrupts.CPU79.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+102%       1.70 ± 26%  interrupts.CPU79.IWI:IRQ_work_interrupts
     60312           -89.3%       6482 ±154%    +111.9%     127782        interrupts.CPU79.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU79.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6666 ± 26%  interrupts.CPU79.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6666 ± 26%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
    411599 ± 52%     -97.7%       9532 ±188%     -41.5%     240972 ±147%  interrupts.CPU79.RES:Rescheduling_interrupts
      0.17 ±223%      +0.0%       0.17 ±223%    +980.0%       1.80 ± 41%  interrupts.CPU79.TLB:TLB_shootdowns
      0.00          -100.0%       0.00         +1e+101%       0.10 ±300%  interrupts.CPU8.127:PCI-MSI.31981660-edge.i40e-eth0-TxRx-91
      1.67 ±223%    +510.0%      10.17 ±223%    -100.0%       0.00        interrupts.CPU8.44:PCI-MSI.31981577-edge.i40e-eth0-TxRx-8
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
      6358 ±101%      +0.7%       6400 ± 71%     +69.7%      10792 ±125%  interrupts.CPU8.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.5e+102%       1.50 ± 33%  interrupts.CPU8.IWI:IRQ_work_interrupts
     60343           -97.6%       1428 ± 69%    +111.8%     127779        interrupts.CPU8.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.8e+105%       6754 ± 22%  interrupts.CPU8.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.8e+105%       6754 ± 22%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    330226 ± 71%     -93.6%      21080 ±105%     +25.1%     413255 ± 58%  interrupts.CPU8.RES:Rescheduling_interrupts
      0.00       +1.7e+101%       0.17 ±223% +1.1e+102%       1.10 ± 85%  interrupts.CPU8.TLB:TLB_shootdowns
      0.33 ±141%  +12400.0%      41.67 ±213%    -100.0%       0.00        interrupts.CPU80.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
      3613 ± 77%     -83.3%     602.33 ± 27%     +32.0%       4768 ± 93%  interrupts.CPU80.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+102%       1.70 ± 26%  interrupts.CPU80.IWI:IRQ_work_interrupts
     60257           -98.1%       1125 ± 49%    +111.9%     127680        interrupts.CPU80.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU80.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6669 ± 26%  interrupts.CPU80.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6669 ± 26%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
    416160 ±101%     -99.9%     216.50 ±140%      +7.0%     445211 ± 89%  interrupts.CPU80.RES:Rescheduling_interrupts
      0.00       +1.7e+101%       0.17 ±223% +1.6e+102%       1.60 ± 41%  interrupts.CPU80.TLB:TLB_shootdowns
      0.33 ±223%  +1.4e+06%       4722 ±223%    +950.0%       3.50 ±300%  interrupts.CPU81.117:PCI-MSI.31981650-edge.i40e-eth0-TxRx-81
    510.83 ± 65%    +191.1%       1487 ±114%    +759.1%       4388 ±167%  interrupts.CPU81.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.6e+102%       1.60 ± 30%  interrupts.CPU81.IWI:IRQ_work_interrupts
     60298           -97.2%       1702 ±115%    +111.8%     127711        interrupts.CPU81.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU81.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.3e+105%       6277 ± 30%  interrupts.CPU81.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.3e+105%       6277 ± 30%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
     59743 ±115%     -98.4%     946.83 ±159%    +218.1%     190043 ± 92%  interrupts.CPU81.RES:Rescheduling_interrupts
      0.00       +1.7e+101%       0.17 ±223% +1.6e+102%       1.60 ± 30%  interrupts.CPU81.TLB:TLB_shootdowns
      1.00 ±223%     -83.3%       0.17 ±223%    +960.0%      10.60 ±300%  interrupts.CPU82.118:PCI-MSI.31981651-edge.i40e-eth0-TxRx-82
      5267 ± 82%     -52.3%       2514 ±112%     -26.2%       3886 ± 85%  interrupts.CPU82.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.6e+102%       1.60 ± 30%  interrupts.CPU82.IWI:IRQ_work_interrupts
     60273           -97.4%       1576 ± 62%    +112.0%     127753        interrupts.CPU82.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU82.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.3e+105%       6277 ± 30%  interrupts.CPU82.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.3e+105%       6277 ± 30%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
    379387 ± 97%     -99.4%       2458 ±142%     -55.0%     170583 ± 63%  interrupts.CPU82.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +860.0%       1.60 ± 30%  interrupts.CPU82.TLB:TLB_shootdowns
      0.17 ±223%    -100.0%       0.00        +2.6e+05%     430.10 ±298%  interrupts.CPU83.119:PCI-MSI.31981652-edge.i40e-eth0-TxRx-83
      2431 ±118%    +178.4%       6768 ±130%     +79.2%       4356 ±115%  interrupts.CPU83.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+102%       1.70 ± 37%  interrupts.CPU83.IWI:IRQ_work_interrupts
     60251           -97.2%       1660 ± 67%    +112.0%     127722        interrupts.CPU83.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU83.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.3e+105%       6278 ± 30%  interrupts.CPU83.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.3e+105%       6278 ± 30%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
    196406 ± 92%     -92.4%      14917 ±166%      +5.5%     207287 ±102%  interrupts.CPU83.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +920.0%       1.70 ± 26%  interrupts.CPU83.TLB:TLB_shootdowns
      1.33 ±223%    +225.0%       4.33 ±137%     -85.0%       0.20 ±200%  interrupts.CPU84.120:PCI-MSI.31981653-edge.i40e-eth0-TxRx-84
      7245 ±148%     -33.7%       4805 ±194%     -72.3%       2008 ± 68%  interrupts.CPU84.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+102%       1.70 ± 26%  interrupts.CPU84.IWI:IRQ_work_interrupts
     60295           -96.8%       1915 ± 84%    +111.8%     127721        interrupts.CPU84.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU84.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6669 ± 26%  interrupts.CPU84.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6669 ± 26%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
    298141 ±127%     -96.9%       9333 ±218%     -71.1%      86088 ± 86%  interrupts.CPU84.RES:Rescheduling_interrupts
      0.67 ±111%     -75.0%       0.17 ±223%    +155.0%       1.70 ± 26%  interrupts.CPU84.TLB:TLB_shootdowns
      1.33 ±223%     -25.0%       1.00 ±223%     -92.5%       0.10 ±300%  interrupts.CPU85.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
      2953 ± 65%     +52.7%       4510 ±141%     +91.0%       5639 ±200%  interrupts.CPU85.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+102%       1.70 ± 26%  interrupts.CPU85.IWI:IRQ_work_interrupts
     60282           -96.8%       1953 ± 79%    +111.9%     127753        interrupts.CPU85.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU85.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6669 ± 26%  interrupts.CPU85.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6669 ± 26%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
    427549 ±104%     -97.6%      10055 ±182%     -68.1%     136231 ±109%  interrupts.CPU85.RES:Rescheduling_interrupts
      0.33 ±141%      +0.0%       0.33 ±141%    +410.0%       1.70 ± 37%  interrupts.CPU85.TLB:TLB_shootdowns
      0.00       +4.3e+102%       4.33 ±223%   +4e+103%      40.40 ±299%  interrupts.CPU86.122:PCI-MSI.31981655-edge.i40e-eth0-TxRx-86
      2952 ±144%     +40.6%       4151 ± 69%     +59.3%       4703 ±119%  interrupts.CPU86.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+102%       1.70 ± 26%  interrupts.CPU86.IWI:IRQ_work_interrupts
     60269           -98.3%       1034 ± 46%    +111.9%     127718        interrupts.CPU86.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU86.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6670 ± 26%  interrupts.CPU86.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6670 ± 26%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
    466540 ±109%     -97.8%      10446 ±108%     -42.1%     270229 ± 81%  interrupts.CPU86.RES:Rescheduling_interrupts
      0.17 ±223%    -100.0%       0.00          +980.0%       1.80 ± 22%  interrupts.CPU86.TLB:TLB_shootdowns
      1.00 ±223%    +600.0%       7.00 ±159%    -100.0%       0.00        interrupts.CPU87.123:PCI-MSI.31981656-edge.i40e-eth0-TxRx-87
      3901 ±117%      -5.2%       3699 ± 97%     +43.2%       5586 ±158%  interrupts.CPU87.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+102%       1.70 ± 26%  interrupts.CPU87.IWI:IRQ_work_interrupts
     60290           -98.1%       1171 ± 52%    +111.8%     127707        interrupts.CPU87.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU87.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6669 ± 26%  interrupts.CPU87.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6669 ± 26%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
    517377 ± 97%     -97.8%      11400 ±185%     -51.5%     250757 ±103%  interrupts.CPU87.RES:Rescheduling_interrupts
      0.50 ±100%     -66.7%       0.17 ±223%    +240.0%       1.70 ± 26%  interrupts.CPU87.TLB:TLB_shootdowns
      4.50 ±223%    -100.0%       0.00          +535.6%      28.60 ±300%  interrupts.CPU88.124:PCI-MSI.31981657-edge.i40e-eth0-TxRx-88
      2592 ±117%     +16.0%       3007 ±120%     -32.4%       1751 ± 65%  interrupts.CPU88.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.8e+102%       1.80 ± 22%  interrupts.CPU88.IWI:IRQ_work_interrupts
     60317           -97.6%       1451 ± 67%    +111.8%     127745        interrupts.CPU88.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU88.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7061 ± 22%  interrupts.CPU88.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7061 ± 22%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
    201008 ±134%     -97.5%       5037 ±165%     -23.1%     154523 ±119%  interrupts.CPU88.RES:Rescheduling_interrupts
      0.33 ±141%     -50.0%       0.17 ±223%    +500.0%       2.00 ± 44%  interrupts.CPU88.TLB:TLB_shootdowns
      9.17 ±223%     +69.1%      15.50 ±223%     -88.0%       1.10 ±271%  interrupts.CPU89.125:PCI-MSI.31981658-edge.i40e-eth0-TxRx-89
      4358 ±169%     +32.1%       5755 ±137%     -59.8%       1751 ± 56%  interrupts.CPU89.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+102%       1.70 ± 26%  interrupts.CPU89.IWI:IRQ_work_interrupts
     60246           -98.6%     828.83 ± 50%    +112.0%     127737        interrupts.CPU89.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU89.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6668 ± 26%  interrupts.CPU89.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6668 ± 26%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
    410372 ±126%     -98.0%       8249 ±142%     -51.8%     197982 ± 91%  interrupts.CPU89.RES:Rescheduling_interrupts
      0.67 ± 70%     +25.0%       0.83 ± 82%    +245.0%       2.30 ± 39%  interrupts.CPU89.TLB:TLB_shootdowns
      0.00          -100.0%       0.00         +2e+101%       0.20 ±200%  interrupts.CPU9.128:PCI-MSI.31981661-edge.i40e-eth0-TxRx-92
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU9.298:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU9.301:PCI-MSI.75776-edge.ioat-msix
     31.00 ±223%     -98.9%       0.33 ±223%     +30.0%      40.30 ±289%  interrupts.CPU9.45:PCI-MSI.31981578-edge.i40e-eth0-TxRx-9
      0.00       +1.7e+101%       0.17 ±223%   +3e+101%       0.30 ±152%  interrupts.CPU9.80:PCI-MSI.31981613-edge.i40e-eth0-TxRx-44
      4604 ± 92%     +36.7%       6292 ± 59%     +38.8%       6391 ±127%  interrupts.CPU9.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.2e+102%       1.20 ± 50%  interrupts.CPU9.IWI:IRQ_work_interrupts
     60641           -97.8%       1319 ± 62%    +110.6%     127725        interrupts.CPU9.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU9.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.8e+105%       6754 ± 22%  interrupts.CPU9.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.8e+105%       6754 ± 22%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    317983 ± 65%     -94.2%      18512 ± 58%    +194.1%     935335 ± 80%  interrupts.CPU9.RES:Rescheduling_interrupts
      0.33 ±141%    -100.0%       0.00          +140.0%       0.80 ± 93%  interrupts.CPU9.TLB:TLB_shootdowns
      2.83 ±223%     +58.8%       4.50 ±213%     -47.1%       1.50 ±177%  interrupts.CPU90.126:PCI-MSI.31981659-edge.i40e-eth0-TxRx-90
      1568 ±117%     +67.9%       2634 ±180%     +39.6%       2189 ± 84%  interrupts.CPU90.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+102%       1.70 ± 26%  interrupts.CPU90.IWI:IRQ_work_interrupts
     60292           -98.4%     973.83 ± 44%    +111.9%     127745        interrupts.CPU90.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU90.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6669 ± 26%  interrupts.CPU90.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6669 ± 26%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
    245411 ±125%     -99.3%       1657 ±223%     +10.8%     271965 ±180%  interrupts.CPU90.RES:Rescheduling_interrupts
      0.67 ±111%     -25.0%       0.50 ±152%    +185.0%       1.90 ± 28%  interrupts.CPU90.TLB:TLB_shootdowns
      0.00          -100.0%       0.00       +3.6e+102%       3.60 ±180%  interrupts.CPU91.127:PCI-MSI.31981660-edge.i40e-eth0-TxRx-91
      5225 ± 69%     -23.7%       3987 ±191%     -66.1%       1770 ±154%  interrupts.CPU91.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.8e+102%       1.80 ± 22%  interrupts.CPU91.IWI:IRQ_work_interrupts
     60290           -98.9%     656.83 ± 47%    +111.8%     127698        interrupts.CPU91.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU91.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7060 ± 22%  interrupts.CPU91.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7060 ± 22%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
    436645 ± 95%     -99.3%       3273 ±218%     -77.1%     100130 ±117%  interrupts.CPU91.RES:Rescheduling_interrupts
      0.33 ±141%      +0.0%       0.33 ±141%    +530.0%       2.10 ± 25%  interrupts.CPU91.TLB:TLB_shootdowns
     97.00 ±223%    -100.0%       0.00           -99.9%       0.10 ±300%  interrupts.CPU92.128:PCI-MSI.31981661-edge.i40e-eth0-TxRx-92
      1058 ± 60%    +244.5%       3644 ±177%    +225.0%       3438 ±176%  interrupts.CPU92.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.8e+102%       1.80 ± 22%  interrupts.CPU92.IWI:IRQ_work_interrupts
     60267           -98.1%       1156 ± 76%    +111.9%     127734        interrupts.CPU92.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU92.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7062 ± 22%  interrupts.CPU92.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7062 ± 22%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
    185271 ±124%     -97.9%       3825 ±207%     -26.0%     137144 ±104%  interrupts.CPU92.RES:Rescheduling_interrupts
      0.67 ±111%     -50.0%       0.33 ±141%    +200.0%       2.00 ± 22%  interrupts.CPU92.TLB:TLB_shootdowns
      0.33 ±223%   +1200.0%       4.33 ±223%    -100.0%       0.00        interrupts.CPU93.129:PCI-MSI.31981662-edge.i40e-eth0-TxRx-93
      1669 ±117%     +14.1%       1904 ± 89%     +81.7%       3032 ± 60%  interrupts.CPU93.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.8e+102%       1.80 ± 22%  interrupts.CPU93.IWI:IRQ_work_interrupts
     60276           -97.7%       1386 ± 58%    +112.0%     127774        interrupts.CPU93.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU93.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7061 ± 22%  interrupts.CPU93.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7061 ± 22%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
    273505 ±107%     -99.3%       1934 ±136%     +74.1%     476154 ± 81%  interrupts.CPU93.RES:Rescheduling_interrupts
      0.67 ± 70%     -25.0%       0.50 ±100%    +335.0%       2.90 ± 24%  interrupts.CPU93.TLB:TLB_shootdowns
      1330 ± 86%    +284.0%       5109 ±133%    +345.0%       5920 ± 67%  interrupts.CPU94.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.7e+102%       1.70 ± 26%  interrupts.CPU94.IWI:IRQ_work_interrupts
     60226           -98.3%       1046 ± 40%    +112.2%     127787        interrupts.CPU94.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU94.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +6.7e+105%       6668 ± 26%  interrupts.CPU94.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +6.7e+105%       6668 ± 26%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
     97035 ±107%     -89.1%      10581 ±154%    +258.1%     347484 ± 69%  interrupts.CPU94.RES:Rescheduling_interrupts
      0.67 ± 70%      +0.0%       0.67 ± 70%    +350.0%       3.00 ± 47%  interrupts.CPU94.TLB:TLB_shootdowns
      8250 ±105%     -61.0%       3214 ±186%     -54.6%       3747 ±104%  interrupts.CPU95.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.8e+102%       1.80 ± 22%  interrupts.CPU95.IWI:IRQ_work_interrupts
     60273           -98.9%     663.67 ± 56%    +111.8%     127629        interrupts.CPU95.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU95.MCP:Machine_check_polls
      0.00          -100.0%       0.00       +7.1e+105%       7061 ± 22%  interrupts.CPU95.NMI:Non-maskable_interrupts
      0.00          -100.0%       0.00       +7.1e+105%       7061 ± 22%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
    659427 ± 51%     -97.4%      17060 ±223%     -49.9%     330068 ± 71%  interrupts.CPU95.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00         +3e+101%       0.30 ±152%  interrupts.CPU95.TLB:TLB_shootdowns
      0.00          -100.0%       0.00       +1.4e+104%     143.90 ±  9%  interrupts.IWI:IRQ_work_interrupts
   5790318           -97.7%     136046 ± 14%    +111.8%   12262240        interrupts.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.MCP:Machine_check_polls
      0.00       +1.7e+101%       0.17 ±223% +6.6e+107%     659020 ±  6%  interrupts.NMI:Non-maskable_interrupts
      0.00       +1.7e+101%       0.17 ±223% +6.6e+107%     659020 ±  6%  interrupts.PMI:Performance_monitoring_interrupts
  41275590 ± 20%     -97.0%    1229430 ± 15%      +1.4%   41864694 ± 22%  interrupts.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.RTR:APIC_ICR_read_retries
     27.83 ± 59%     -31.7%      19.00 ± 22%    +391.5%     136.80 ± 32%  interrupts.TLB:TLB_shootdowns


>  fs/pipe.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 678dee2a8228..6d4342bad9f1 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -363,10 +363,9 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  		 * _very_ unlikely case that the pipe was full, but we got
>  		 * no data.
>  		 */
> -		if (unlikely(was_full)) {
> +		if (unlikely(was_full))
>  			wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
> -			kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> -		}
> +		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
>  
>  		/*
>  		 * But because we didn't read anything, at this point we can
> @@ -385,12 +384,11 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  		wake_next_reader = false;
>  	__pipe_unlock(pipe);
>  
> -	if (was_full) {
> +	if (was_full)
>  		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
> -		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> -	}
>  	if (wake_next_reader)
>  		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
> +	kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
>  	if (ret > 0)
>  		file_accessed(filp);
>  	return ret;
> @@ -565,10 +563,9 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  		 * become empty while we dropped the lock.
>  		 */
>  		__pipe_unlock(pipe);
> -		if (was_empty) {
> +		if (was_empty)
>  			wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
> -			kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> -		}
> +		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>  		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
>  		__pipe_lock(pipe);
>  		was_empty = pipe_empty(pipe->head, pipe->tail);
> @@ -591,10 +588,9 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  	 * Epoll nonsensically wants a wakeup whether the pipe
>  	 * was already empty or not.
>  	 */
> -	if (was_empty || pipe->poll_usage) {
> +	if (was_empty || pipe->poll_usage)
>  		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
> -		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> -	}
> +	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>  	if (wake_next_writer)
>  		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
>  	if (ret > 0 && sb_start_write_trylock(file_inode(filp)->i_sb)) {

