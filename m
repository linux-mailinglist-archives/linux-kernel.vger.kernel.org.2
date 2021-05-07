Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4739B375EDF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 04:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhEGCuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 22:50:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:60613 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231334AbhEGCuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 22:50:10 -0400
IronPort-SDR: CDQpu6Dc7jnZvUaIVpv15XR0qZYsxF9xEiIb2rChUNE4ywLRNSol0JGOFEtqg6tocfZDZZjGNf
 5o8MAaV31MnQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="195517422"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="195517422"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 19:49:10 -0700
IronPort-SDR: X6yzkxga3ndeGdJcCpfP7NpK+wY9qOdAkq0eVwM/yxTMjcOhV3E99y+Y+S3/ADAep3RQrjy6Xm
 AaA3FfNwXW8A==
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="434691968"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 19:49:05 -0700
Date:   Fri, 7 May 2021 11:06:06 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Pratik Sampat <psampat@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>
Subject: Re: [percpu]  ace7e70901:  aim9.sync_disk_rw.ops_per_sec -2.3%
 regression
Message-ID: <20210507030606.GA27263@xsang-OptiPlex-9020>
References: <20210427073448.GD32408@xsang-OptiPlex-9020>
 <YItcfQfZlNZTmQKR@carbon.dhcp.thefacebook.com>
 <40632FBD-8874-4B6C-A945-F2EBC96CF12B@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40632FBD-8874-4B6C-A945-F2EBC96CF12B@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Roman,
 
On Thu, May 06, 2021 at 12:54:59AM +0000, Roman Gushchin wrote:
> Ping

sorry for late.

the new patch makes the performance a little better but still has
1.9% regression comparing to
f183324133 ("percpu: implement partial chunk depopulation")

below is detail.
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime/ucode:
  gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/lkp-knl-f1/sync_disk_rw/aim9/300s/0xffff0190

commit: 
  f183324133 ("percpu: implement partial chunk depopulation")
  ace7e70901 ("percpu: use reclaim threshold instead of running for every page")
  0ed3240b17 ("percpu: optimize locking in pcpu_balance_workfn()")

f183324133ea535d ace7e7090137ee996757eb5eebc 0ed3240b17bd155d28f4b837f94 
---------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \  
    103531            -2.3%     101102            -1.9%     101563        aim9.sync_disk_rw.ops_per_sec
    300.12            -0.0%     300.11            -0.0%     300.11        aim9.time.elapsed_time
    300.12            -0.0%     300.11            -0.0%     300.11        aim9.time.elapsed_time.max
    732.67            +0.4%     735.57            +0.1%     733.43        aim9.time.involuntary_context_switches
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        aim9.time.major_page_faults
      2836 ±  2%      -1.3%       2800 ±  2%      +0.3%       2846 ±  2%  aim9.time.maximum_resident_set_size
      1187            +0.1%       1187            -0.0%       1186        aim9.time.minor_page_faults
      4096            +0.0%       4096            +0.0%       4096        aim9.time.page_size
     91.00            +0.2%      91.14            +0.5%      91.43        aim9.time.percent_of_cpu_this_job_got
    219.28            -0.5%     218.24            +0.2%     219.69        aim9.time.system_time
     55.21            +3.0%      56.87            +1.9%      56.27        aim9.time.user_time
     29.50 ±  6%      -5.6%      27.86 ±  6%      -2.7%      28.71 ±  7%  aim9.time.voluntary_context_switches
    380.82            +0.2%     381.57            +0.5%     382.62        uptime.boot
     91562            +0.2%      91788            +0.6%      92131        uptime.idle
     76.55 ±  2%      +0.7%      77.10 ±  3%      +2.4%      78.37 ±  4%  boot-time.boot
     27.14 ±  3%      +0.7%      27.34            -0.0%      27.14 ±  2%  boot-time.dhcp
     17296 ±  2%      +1.0%      17474 ±  3%      +2.6%      17745 ±  4%  boot-time.idle
      1.96            +1.2%       1.98 ±  2%      +0.8%       1.97        boot-time.smp_boot
 7.169e+10            -0.0%  7.167e+10            +0.3%  7.193e+10        cpuidle.C1.time
 1.553e+08            -3.0%  1.506e+08 ±  7%      -7.1%  1.443e+08 ± 18%  cpuidle.C1.usage
     95169 ±  6%  +29067.3%   27758401 ±243%     +16.7%     111068 ± 21%  cpuidle.POLL.time
      2206 ± 24%  +18692.6%     414689 ±243%     +38.7%       3059 ± 59%  cpuidle.POLL.usage
     94.91            +0.1       94.96            +0.2       95.09        mpstat.cpu.all.idle%
      4.42            -0.1        4.35            -0.2        4.24 ±  3%  mpstat.cpu.all.irq%
      0.17 ±  3%      +0.0        0.19 ±  2%      -0.0        0.16 ±  6%  mpstat.cpu.all.soft%
      0.35            -0.0        0.35            +0.0        0.35        mpstat.cpu.all.sys%
      0.15            +0.0        0.16            +0.0        0.15        mpstat.cpu.all.usr%
      0.00          -100.0%       0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
   8862949            -2.0%    8683426            -1.7%    8716693        numa-numastat.node0.local_node
   8862894            -2.0%    8683354            -1.7%    8716623        numa-numastat.node0.numa_hit
      0.00          -100.0%       0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
      1.17 ± 76%    +193.9%       3.43 ± 60%    +255.1%       4.14 ± 85%  numa-numastat.node1.numa_hit
      1.17 ± 76%    +193.9%       3.43 ± 60%    +255.1%       4.14 ± 85%  numa-numastat.node1.other_node
     94.00            +0.0%      94.00            +0.0%      94.00        vmstat.cpu.id
      5.00            +0.0%       5.00            -5.7%       4.71 ±  9%  vmstat.cpu.sy
      0.00          -100.0%       0.00          -100.0%       0.00        vmstat.cpu.us
      0.00          -100.0%       0.00          -100.0%       0.00        vmstat.io.bi
    544.67 ± 10%      +4.8%     570.86 ± 19%      +3.4%     563.43 ± 12%  vmstat.memory.buff
   1132342            -0.0%    1131884            -0.0%    1132148        vmstat.memory.cache
 1.041e+08            +0.0%  1.041e+08            -0.0%  1.041e+08        vmstat.memory.free
      1.00            +0.0%       1.00            +0.0%       1.00        vmstat.procs.r
      2580            -0.1%       2577            +0.4%       2591        vmstat.system.cs
    511107            -2.2%     499679 ±  5%      -7.1%     474682 ± 18%  vmstat.system.in
    300.12            -0.0%     300.11            -0.0%     300.11        time.elapsed_time
    300.12            -0.0%     300.11            -0.0%     300.11        time.elapsed_time.max
    732.67            +0.4%     735.57            +0.1%     733.43        time.involuntary_context_switches
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        time.major_page_faults
      2836 ±  2%      -1.3%       2800 ±  2%      +0.3%       2846 ±  2%  time.maximum_resident_set_size
      1187            +0.1%       1187            -0.0%       1186        time.minor_page_faults
      4096            +0.0%       4096            +0.0%       4096        time.page_size
     91.00            +0.2%      91.14            +0.5%      91.43        time.percent_of_cpu_this_job_got
    219.28            -0.5%     218.24            +0.2%     219.69        time.system_time
     55.21            +3.0%      56.87            +1.9%      56.27        time.user_time
     29.50 ±  6%      -5.6%      27.86 ±  6%      -2.7%      28.71 ±  7%  time.voluntary_context_switches
    120.33            -0.4%     119.86            -4.6%     114.86 ±  9%  turbostat.Avg_MHz
      8.61            -0.0        8.58            -0.4        8.21 ±  9%  turbostat.Busy%
      1400            +0.0%       1400            +0.0%       1400        turbostat.Bzy_MHz
 1.552e+08            -3.0%  1.505e+08 ±  7%      -7.1%  1.442e+08 ± 18%  turbostat.C1
     92.77            -0.0       92.73            +0.3       93.09        turbostat.C1%
     91.39            +0.0%      91.42            +0.4%      91.79        turbostat.CPU%c1
     61.50            -0.8%      61.00            -1.3%      60.71        turbostat.CoreTmp
 1.546e+08            -2.2%  1.512e+08 ±  5%      -7.1%  1.436e+08 ± 18%  turbostat.IRQ
     66.00            +0.4%      66.29            -0.4%      65.71        turbostat.PkgTmp
    110.87            -0.0%     110.83            +0.0%     110.88        turbostat.PkgWatt
      2.39 ±  5%      +2.7%       2.45 ±  7%     -15.9%       2.01 ± 17%  turbostat.RAMWatt
      1297            +0.0%       1297            +0.0%       1297        turbostat.TSC_MHz
     26815            -0.6%      26663            -1.5%      26426 ±  3%  meminfo.Active
     26267            -0.7%      26089            -1.6%      25859 ±  3%  meminfo.Active(anon)
    548.67 ± 10%      +4.8%     574.86 ± 19%      +3.4%     567.43 ± 12%  meminfo.Active(file)
    191276            -1.0%     189282 ±  3%      +0.0%     191289        meminfo.AnonHugePages
    251007            +0.1%     251224            +0.2%     251421        meminfo.AnonPages
    544.67 ± 10%      +4.8%     570.86 ± 19%      +3.4%     563.43 ± 12%  meminfo.Buffers
   1006852            -0.0%    1006628            -0.0%    1006418        meminfo.Cached
    200520            +0.0%     200520            +0.0%     200520        meminfo.CmaFree
    204800            +0.0%     204800            +0.0%     204800        meminfo.CmaTotal
  53537336            +0.0%   53537340            +0.0%   53537336        meminfo.CommitLimit
    368947            -0.0%     368817            -0.1%     368665        meminfo.Committed_AS
 1.003e+08            +0.2%  1.005e+08            -0.4%   99914313        meminfo.DirectMap1G
   9237504 ±  5%      -2.3%    9027876 ±  4%      +4.1%    9614482 ±  5%  meminfo.DirectMap2M
   1492529 ±  7%      +0.7%    1502428 ±  7%      +1.5%    1515008 ±  8%  meminfo.DirectMap4k
      0.00          -100.0%       0.00          -100.0%       0.00        meminfo.Dirty
      2048            +0.0%       2048            +0.0%       2048        meminfo.Hugepagesize
    264495            +0.1%     264854            +0.3%     265324        meminfo.Inactive
    264495            +0.1%     264854            +0.3%     265324        meminfo.Inactive(anon)
    125481            -0.3%     125131            +0.1%     125665        meminfo.KReclaimable
     34771            -0.2%      34693            -0.1%      34729        meminfo.KernelStack
     31799            -0.3%      31689            +0.1%      31836        meminfo.Mapped
 1.035e+08            +0.0%  1.035e+08            -0.0%  1.035e+08        meminfo.MemAvailable
 1.041e+08            +0.0%  1.041e+08            -0.0%  1.041e+08        meminfo.MemFree
 1.071e+08            +0.0%  1.071e+08            +0.0%  1.071e+08        meminfo.MemTotal
   2965112            -0.1%    2963540            +0.0%    2966167        meminfo.Memused
    685.67 ±129%     +26.3%     865.86 ±107%     +26.5%     867.57 ±107%  meminfo.Mlocked
      4233            +0.4%       4249            +0.7%       4265        meminfo.PageTables
    123600            +0.7%     124526            +0.5%     124251        meminfo.Percpu
    125481            -0.3%     125131            +0.1%     125665        meminfo.SReclaimable
    303579            +0.3%     304346            +0.6%     305416        meminfo.SUnreclaim
     40042            -0.6%      39816            -1.1%      39583 ±  2%  meminfo.Shmem
    429061            +0.1%     429478            +0.5%     431082        meminfo.Slab
    966908            +0.0%     966935            +0.0%     966961        meminfo.Unevictable
 3.436e+10            +0.0%  3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
    230733            -0.0%     230658            +0.1%     231045        meminfo.VmallocUsed
   3996086            -0.1%    3994006            -0.0%    3994530        meminfo.max_used_kB
     26858            -0.6%      26689            -1.7%      26401 ±  3%  numa-meminfo.node0.Active
     26309            -0.7%      26114            -1.8%      25833 ±  3%  numa-meminfo.node0.Active(anon)
    548.67 ± 10%      +4.8%     574.86 ± 19%      +3.4%     567.43 ± 12%  numa-meminfo.node0.Active(file)
    191320            -1.0%     189364 ±  3%      +0.0%     191355        numa-meminfo.node0.AnonHugePages
    251001            +0.1%     251233            +0.2%     251424        numa-meminfo.node0.AnonPages
    308912            +0.1%     309116            +0.3%     309956        numa-meminfo.node0.AnonPages.max
      0.00          -100.0%       0.00          -100.0%       0.00        numa-meminfo.node0.Dirty
    544628            -0.0%     544465            -0.1%     544187        numa-meminfo.node0.FilePages
    264479            +0.2%     264889            +0.3%     265337        numa-meminfo.node0.Inactive
    264479            +0.2%     264889            +0.3%     265337        numa-meminfo.node0.Inactive(anon)
    108211            +0.5%     108793            +0.9%     109226        numa-meminfo.node0.KReclaimable
     34759            -0.2%      34686            -0.1%      34720        numa-meminfo.node0.KernelStack
     19390            -0.3%      19328            +0.1%      19402        numa-meminfo.node0.Mapped
  96447669            +0.0%   96448315            -0.0%   96445999        numa-meminfo.node0.MemFree
  98862596            +0.0%   98862596            +0.0%   98862596        numa-meminfo.node0.MemTotal
   2414925            -0.0%    2414279            +0.1%    2416596        numa-meminfo.node0.MemUsed
    395.33 ±128%     +26.0%     498.14 ±106%     +26.0%     498.00 ±106%  numa-meminfo.node0.Mlocked
      4233            +0.2%       4243            +0.7%       4261        numa-meminfo.node0.PageTables
    108211            +0.5%     108793            +0.9%     109226        numa-meminfo.node0.SReclaimable
    292030            +0.1%     292224            +0.6%     293732        numa-meminfo.node0.SUnreclaim
     40066            -0.5%      39855            -1.2%      39574 ±  2%  numa-meminfo.node0.Shmem
    400242            +0.2%     401017            +0.7%     402959        numa-meminfo.node0.Slab
    504116            +0.0%     504166            +0.0%     504176        numa-meminfo.node0.Unevictable
    462792            -0.0%     462769            -0.0%     462785        numa-meminfo.node1.FilePages
     17280 ±  6%      -5.4%      16346 ±  8%      -4.8%      16448 ±  4%  numa-meminfo.node1.KReclaimable
     10.67 ± 70%     -57.1%       4.57 ±158%     -57.1%       4.57 ±158%  numa-meminfo.node1.KernelStack
     12442            -0.2%      12421            +0.4%      12495        numa-meminfo.node1.Mapped
   7662516            +0.0%    7662921            +0.0%    7663256        numa-meminfo.node1.MemFree
   8212076            +0.0%    8212088            +0.0%    8212076        numa-meminfo.node1.MemTotal
    549558            -0.1%     549165            -0.1%     548818        numa-meminfo.node1.MemUsed
    294.67 ±129%     +25.8%     370.71 ±107%     +26.6%     373.00 ±107%  numa-meminfo.node1.Mlocked
      4.00            +0.0%       4.00            +0.0%       4.00        numa-meminfo.node1.PageTables
     17280 ±  6%      -5.4%      16346 ±  8%      -4.8%      16448 ±  4%  numa-meminfo.node1.SReclaimable
     11552 ±  7%      +4.9%      12122 ± 10%      +1.1%      11681 ± 14%  numa-meminfo.node1.SUnreclaim
     28832 ±  5%      -1.3%      28469 ±  7%      -2.4%      28129 ±  7%  numa-meminfo.node1.Slab
    462792            -0.0%     462769            -0.0%     462785        numa-meminfo.node1.Unevictable
      6580            -0.7%       6532            -1.7%       6468 ±  3%  numa-vmstat.node0.nr_active_anon
    137.17 ± 10%      +4.8%     143.71 ± 19%      +3.4%     141.86 ± 12%  numa-vmstat.node0.nr_active_file
     62768            +0.1%      62817            +0.2%      62865        numa-vmstat.node0.nr_anon_pages
     93.00            -1.1%      92.00 ±  4%      -0.2%      92.86        numa-vmstat.node0.nr_anon_transparent_hugepages
     18.00 ± 18%     +11.9%      20.14 ± 25%      +3.2%      18.57 ± 18%  numa-vmstat.node0.nr_dirtied
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node0.nr_dirty
    136167            -0.0%     136118            -0.1%     136056        numa-vmstat.node0.nr_file_pages
     50130            +0.0%      50130            +0.0%      50130        numa-vmstat.node0.nr_free_cma
  24111954            +0.0%   24112004            -0.0%   24111486        numa-vmstat.node0.nr_free_pages
     66141            +0.1%      66223            +0.3%      66341        numa-vmstat.node0.nr_inactive_anon
      0.00          -100.0%       0.00       +2.9e+101%       0.29 ±158%  numa-vmstat.node0.nr_isolated_anon
     34756            -0.2%      34686            -0.1%      34721        numa-vmstat.node0.nr_kernel_stack
      4974            -0.5%       4948            -0.1%       4968        numa-vmstat.node0.nr_mapped
     97.83 ±130%     +26.7%     124.00 ±107%     +26.7%     124.00 ±107%  numa-vmstat.node0.nr_mlock
      1056            +0.3%       1059            +0.8%       1064        numa-vmstat.node0.nr_page_table_pages
     10026            -0.6%       9965            -1.2%       9902 ±  2%  numa-vmstat.node0.nr_shmem
     27051            +0.5%      27196            +0.9%      27305        numa-vmstat.node0.nr_slab_reclaimable
     73006            +0.1%      73056            +0.6%      73433        numa-vmstat.node0.nr_slab_unreclaimable
    126028            +0.0%     126041            +0.0%     126043        numa-vmstat.node0.nr_unevictable
     17.00 ± 19%     +12.6%      19.14 ± 27%      +3.4%      17.57 ± 19%  numa-vmstat.node0.nr_written
      6581            -0.8%       6528            -1.7%       6468 ±  3%  numa-vmstat.node0.nr_zone_active_anon
    137.17 ± 10%      +4.8%     143.71 ± 19%      +3.4%     141.86 ± 12%  numa-vmstat.node0.nr_zone_active_file
     66141            +0.1%      66223            +0.3%      66342        numa-vmstat.node0.nr_zone_inactive_anon
    126028            +0.0%     126041            +0.0%     126043        numa-vmstat.node0.nr_zone_unevictable
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node0.nr_zone_write_pending
   6428805            -1.4%    6337885            -1.0%    6366183        numa-vmstat.node0.numa_hit
    132774            +0.1%     132843            +0.0%     132784        numa-vmstat.node0.numa_interleave
   6428824            -1.4%    6337903            -1.0%    6366202        numa-vmstat.node0.numa_local
    115698            -0.0%     115692            -0.0%     115696        numa-vmstat.node1.nr_file_pages
   1915628            +0.0%    1915730            +0.0%    1915814        numa-vmstat.node1.nr_free_pages
     10.67 ± 70%     -57.1%       4.57 ±158%     -57.1%       4.57 ±158%  numa-vmstat.node1.nr_kernel_stack
      3108            -0.1%       3104            +0.5%       3122        numa-vmstat.node1.nr_mapped
     73.00 ±130%     +26.2%      92.14 ±107%     +26.8%      92.57 ±107%  numa-vmstat.node1.nr_mlock
      1.00            +0.0%       1.00            +0.0%       1.00        numa-vmstat.node1.nr_page_table_pages
      4320 ±  6%      -5.4%       4086 ±  8%      -4.8%       4112 ±  4%  numa-vmstat.node1.nr_slab_reclaimable
      2887 ±  7%      +4.9%       3030 ± 10%      +1.1%       2920 ± 14%  numa-vmstat.node1.nr_slab_unreclaimable
    115698            -0.0%     115692            -0.0%     115696        numa-vmstat.node1.nr_unevictable
    115698            -0.0%     115692            -0.0%     115696        numa-vmstat.node1.nr_zone_unevictable
    132956            -0.0%     132916            +0.0%     132965        numa-vmstat.node1.numa_hit
    132912            -0.0%     132869            +0.0%     132921        numa-vmstat.node1.numa_interleave
    132956            -0.0%     132916            +0.0%     132965        numa-vmstat.node1.numa_other
     37.99 ±  2%      -1.3%      37.50 ±  3%      -0.2%      37.91 ±  7%  perf-stat.i.MPKI
   5.6e+08 ±  2%      +2.9%  5.763e+08 ±  2%      -1.0%  5.545e+08 ± 10%  perf-stat.i.branch-instructions
      7.63 ±  2%      +0.4        7.99            +0.2        7.83 ±  4%  perf-stat.i.branch-miss-rate%
  42664479 ±  4%      +7.7%   45940583 ±  4%      +2.0%   43527067 ± 14%  perf-stat.i.branch-misses
     16.71            -0.5       16.18            -0.7       16.02 ±  5%  perf-stat.i.cache-miss-rate%
  16470516            -1.4%   16231807            -5.6%   15551526 ±  9%  perf-stat.i.cache-misses
  98614944            +1.8%  1.004e+08            -1.8%   96876155 ±  4%  perf-stat.i.cache-references
      2519            -0.2%       2514            +0.4%       2530        perf-stat.i.context-switches
      8.36            -3.0%       8.11            -5.8%       7.88 ±  5%  perf-stat.i.cpi
    255996            -0.0%     255993            -0.0%     255994        perf-stat.i.cpu-clock
 2.171e+10            +0.0%  2.171e+10            -6.1%   2.04e+10 ± 14%  perf-stat.i.cpu-cycles
    281.13            +0.1%     281.44            +0.2%     281.75        perf-stat.i.cpu-migrations
      1319 ±  2%      +1.5%       1339            -1.1%       1305 ±  5%  perf-stat.i.cycles-between-cache-misses
      2.11 ±  2%      -0.0        2.06 ±  3%      -0.1        2.03 ±  4%  perf-stat.i.iTLB-load-miss-rate%
  55721706            +0.8%   56151244 ±  3%      -4.3%   53299894 ± 13%  perf-stat.i.iTLB-load-misses
 2.654e+09 ±  2%      +3.0%  2.733e+09 ±  2%      -0.8%  2.632e+09 ± 10%  perf-stat.i.iTLB-loads
 2.651e+09 ±  2%      +2.9%  2.728e+09 ±  2%      -0.8%  2.629e+09 ± 10%  perf-stat.i.instructions
     47.53 ±  2%      +2.2%      48.59 ±  3%      +4.3%      49.59 ±  5%  perf-stat.i.instructions-per-iTLB-miss
      0.12            +3.0%       0.13            +6.5%       0.13 ±  6%  perf-stat.i.ipc
      2.35 ± 34%     +25.4%       2.95 ± 44%     +65.8%       3.89 ± 23%  perf-stat.i.major-faults
      0.08            +0.0%       0.08            -6.1%       0.08 ± 14%  perf-stat.i.metric.GHz
      0.03            -0.1%       0.03            +0.1%       0.03        perf-stat.i.metric.K/sec
     12.94 ±  2%      +2.9%      13.32 ±  2%      -0.9%      12.82 ± 10%  perf-stat.i.metric.M/sec
      2793            -0.1%       2791            -0.1%       2790        perf-stat.i.minor-faults
      2796            -0.1%       2794            -0.1%       2794        perf-stat.i.page-faults
    255996            -0.0%     255993            -0.0%     255994        perf-stat.i.task-clock
     37.18 ±  2%      -1.1%      36.77 ±  3%      -0.3%      37.06 ±  6%  perf-stat.overall.MPKI
      7.61 ±  2%      +0.4        7.97            +0.2        7.81 ±  4%  perf-stat.overall.branch-miss-rate%
     16.70            -0.5       16.17            -0.7       16.01 ±  5%  perf-stat.overall.cache-miss-rate%
      8.18            -2.8%       7.95            -5.7%       7.72 ±  6%  perf-stat.overall.cpi
      1318 ±  2%      +1.5%       1337            -1.1%       1304 ±  5%  perf-stat.overall.cycles-between-cache-misses
      2.05 ±  2%      -0.0        2.01 ±  3%      -0.1        1.98 ±  5%  perf-stat.overall.iTLB-load-miss-rate%
     47.66 ±  2%      +2.2%      48.71 ±  3%      +4.3%      49.73 ±  5%  perf-stat.overall.instructions-per-iTLB-miss
      0.12            +2.9%       0.13            +6.5%       0.13 ±  6%  perf-stat.overall.ipc
 5.591e+08 ±  2%      +2.9%  5.753e+08 ±  2%      -1.0%  5.535e+08 ± 10%  perf-stat.ps.branch-instructions
  42584908 ±  4%      +7.7%   45847160 ±  4%      +2.0%   43439164 ± 14%  perf-stat.ps.branch-misses
  16419650            -1.5%   16180804            -5.6%   15503940 ±  9%  perf-stat.ps.cache-misses
  98323595            +1.8%  1.001e+08            -1.8%   96588692 ±  4%  perf-stat.ps.cache-references
      2511            -0.2%       2505            +0.4%       2521        perf-stat.ps.context-switches
    255107            -0.0%     255102            -0.0%     255106        perf-stat.ps.cpu-clock
 2.165e+10            -0.0%  2.165e+10            -6.1%  2.034e+10 ± 14%  perf-stat.ps.cpu-cycles
    280.62            +0.1%     280.92            +0.2%     281.15        perf-stat.ps.cpu-migrations
  55529179            +0.8%   55955044 ±  3%      -4.3%   53117006 ± 13%  perf-stat.ps.iTLB-load-misses
  2.65e+09 ±  2%      +3.0%  2.728e+09 ±  2%      -0.9%  2.627e+09 ± 10%  perf-stat.ps.iTLB-loads
 2.646e+09 ±  2%      +2.9%  2.723e+09 ±  2%      -0.8%  2.624e+09 ± 10%  perf-stat.ps.instructions
      2.35 ± 34%     +25.2%       2.94 ± 44%     +65.3%       3.88 ± 23%  perf-stat.ps.major-faults
      2785            -0.1%       2783            -0.1%       2782        perf-stat.ps.minor-faults
      2788            -0.1%       2786            -0.1%       2786        perf-stat.ps.page-faults
    255107            -0.0%     255102            -0.0%     255106        perf-stat.ps.task-clock
 7.954e+11 ±  2%      +2.9%  8.183e+11 ±  2%      -0.9%  7.885e+11 ± 10%  perf-stat.total.instructions
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.compact_isolated
      6576            -0.9%       6520            -1.7%       6466 ±  3%  proc-vmstat.nr_active_anon
    137.17 ± 10%      +4.8%     143.71 ± 19%      +3.4%     141.86 ± 12%  proc-vmstat.nr_active_file
     62747            +0.1%      62801            +0.2%      62846        proc-vmstat.nr_anon_pages
     93.00            -0.9%      92.14 ±  4%      -0.2%      92.86        proc-vmstat.nr_anon_transparent_hugepages
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.nr_dirtied
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.nr_dirty
   2581622            +0.0%    2581654            -0.0%    2581593        proc-vmstat.nr_dirty_background_threshold
   5169558            +0.0%    5169622            -0.0%    5169499        proc-vmstat.nr_dirty_threshold
    251857            -0.0%     251800            -0.0%     251748        proc-vmstat.nr_file_pages
     50130            +0.0%      50130            +0.0%      50130        proc-vmstat.nr_free_cma
  26027500            +0.0%   26027814            -0.0%   26027203        proc-vmstat.nr_free_pages
     66118            +0.1%      66207            +0.3%      66321        proc-vmstat.nr_inactive_anon
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        proc-vmstat.nr_isolated_anon
     34770            -0.2%      34693            -0.1%      34724        proc-vmstat.nr_kernel_stack
      8077            -0.4%       8048            +0.1%       8086        proc-vmstat.nr_mapped
    172.33 ±129%     +26.3%     217.57 ±106%     +25.9%     217.00 ±107%  proc-vmstat.nr_mlock
      1059            +0.3%       1062            +0.5%       1064        proc-vmstat.nr_page_table_pages
     10018            -0.6%       9955            -1.2%       9898 ±  2%  proc-vmstat.nr_shmem
     31371            -0.3%      31283            +0.1%      31417        proc-vmstat.nr_slab_reclaimable
     75895            +0.3%      76087            +0.6%      76353        proc-vmstat.nr_slab_unreclaimable
    241726            +0.0%     241734            +0.0%     241740        proc-vmstat.nr_unevictable
      1.00            +0.0%       1.00            +0.0%       1.00        proc-vmstat.nr_written
      6577            -0.9%       6520            -1.7%       6466 ±  3%  proc-vmstat.nr_zone_active_anon
    137.17 ± 10%      +4.8%     143.71 ± 19%      +3.4%     141.86 ± 12%  proc-vmstat.nr_zone_active_file
     66118            +0.1%      66207            +0.3%      66321        proc-vmstat.nr_zone_inactive_anon
    241726            +0.0%     241734            +0.0%     241740        proc-vmstat.nr_zone_unevictable
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.nr_zone_write_pending
      3823            -0.6%       3800            +1.9%       3898        proc-vmstat.numa_hint_faults
      3823            -0.6%       3800            +1.9%       3898        proc-vmstat.numa_hint_faults_local
   8878045            -2.0%    8702700            -1.6%    8735667        proc-vmstat.numa_hit
    112.00 ± 50%     -13.4%      97.00 ± 54%     +51.9%     170.14 ±  2%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.numa_interleave
   8878044            -2.0%    8702696            -1.6%    8735663        proc-vmstat.numa_local
      1.50 ± 74%    +138.1%       3.57 ± 55%    +195.2%       4.43 ± 87%  proc-vmstat.numa_other
     63282 ± 46%     -12.9%      55142 ± 49%     +46.9%      92983 ±  2%  proc-vmstat.numa_pte_updates
    515593            -2.3%     503677            -1.9%     505820        proc-vmstat.pgactivate
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
   8967593            -2.0%    8788379            -1.6%    8821208        proc-vmstat.pgalloc_normal
    878257            +0.2%     879837            +0.1%     878786        proc-vmstat.pgfault
   8941947            -2.0%    8762451            -1.6%    8795417        proc-vmstat.pgfree
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgpgin
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgpgout
     50552            -0.2%      50460            -0.1%      50502        proc-vmstat.pgreuse
     73.00 ±  3%      +0.4%      73.29 ±  3%      -0.8%      72.43        proc-vmstat.thp_collapse_alloc
      0.50 ±223%    +100.0%       1.00 ±130%    +128.6%       1.14 ±108%  proc-vmstat.thp_deferred_split_page
     42.33            +0.6%      42.57            +0.9%      42.71        proc-vmstat.thp_fault_alloc
      0.50 ±223%    +100.0%       1.00 ±130%    +128.6%       1.14 ±108%  proc-vmstat.thp_split_pmd
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
    105.83            +0.3%     106.14           +10.3%     116.71 ± 21%  proc-vmstat.unevictable_pgs_culled
    586.00            +0.0%     586.00            +0.0%     586.00        proc-vmstat.unevictable_pgs_mlocked
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.unevictable_pgs_rescued
   2629888            +0.6%    2646966            +0.1%    2632045        proc-vmstat.unevictable_pgs_scanned
      0.00        +2.5e+10%     249.87 ±244%      +0.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.avg
      0.00        +1.3e+12%      13242 ±244%      +0.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.max
      0.00            +0.0%       0.00            +0.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.min
      0.00       +1.8e+105%       1801 ±244%    -100.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.stddev
     18405 ± 12%      +0.7%      18529 ±  6%      +2.2%      18809 ± 10%  sched_debug.cfs_rq:/.load.avg
    418300 ± 11%      +4.8%     438407 ±  9%     +15.9%     484971 ± 18%  sched_debug.cfs_rq:/.load.max
     78910 ±  6%      +2.0%      80514 ±  6%      +5.3%      83101 ±  8%  sched_debug.cfs_rq:/.load.stddev
     16.06 ± 13%      +4.1%      16.72 ± 10%      +4.7%      16.81 ±  4%  sched_debug.cfs_rq:/.load_avg.avg
    421.91 ±  9%     +25.1%     527.64 ± 13%     +15.0%     485.14 ± 12%  sched_debug.cfs_rq:/.load_avg.max
     72.62 ±  5%     +12.0%      81.32 ±  8%      +6.7%      77.48 ±  5%  sched_debug.cfs_rq:/.load_avg.stddev
      0.00        +2.5e+10%     249.87 ±244%      +0.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.avg
      0.00        +1.3e+12%      13242 ±244%      +0.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.max
      0.00            +0.0%       0.00            +0.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.min
      0.00       +1.8e+105%       1801 ±244%    -100.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.stddev
    358250 ± 10%      +4.9%     375743 ± 11%      +9.3%     391642 ±  8%  sched_debug.cfs_rq:/.min_vruntime.avg
    442576 ±  7%      +3.3%     457023 ±  9%      +6.5%     471206 ±  6%  sched_debug.cfs_rq:/.min_vruntime.max
    117912 ± 34%     +12.8%     132991 ± 32%     +48.9%     175603 ± 36%  sched_debug.cfs_rq:/.min_vruntime.min
     51761 ± 10%      +0.9%      52243 ± 18%      -3.5%      49953 ± 17%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.05 ±  9%      -3.7%       0.05 ±  4%      +0.6%       0.05 ±  8%  sched_debug.cfs_rq:/.nr_running.avg
      1.00            +0.0%       1.00            +0.0%       1.00        sched_debug.cfs_rq:/.nr_running.max
      0.22 ±  4%      -1.6%       0.21 ±  3%      +0.8%       0.22 ±  4%  sched_debug.cfs_rq:/.nr_running.stddev
      0.01 ±223%  +10517.9%       0.88 ± 98%   +3394.3%       0.29 ±122%  sched_debug.cfs_rq:/.removed.load_avg.avg
      0.86 ±223%  +12924.1%     112.15 ± 87%   +7591.1%      66.23 ±121%  sched_debug.cfs_rq:/.removed.load_avg.max
      0.08 ±223%  +11044.9%       9.37 ± 89%   +5097.5%       4.37 ±121%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      0.01 ±223%   +4750.0%       0.40 ± 93%   +1685.5%       0.15 ±120%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
      0.86 ±223%   +6262.8%      54.79 ± 87%   +3831.8%      33.86 ±119%  sched_debug.cfs_rq:/.removed.runnable_avg.max
      0.08 ±223%   +5098.9%       4.37 ± 87%   +2556.4%       2.23 ±120%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      0.01 ±223%   +4750.0%       0.40 ± 93%   +1685.5%       0.15 ±120%  sched_debug.cfs_rq:/.removed.util_avg.avg
      0.86 ±223%   +6262.8%      54.79 ± 87%   +3831.8%      33.86 ±119%  sched_debug.cfs_rq:/.removed.util_avg.max
      0.08 ±223%   +5098.9%       4.37 ± 87%   +2556.4%       2.23 ±120%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     45.86 ±  9%      -3.3%      44.37 ±  8%      +5.0%      48.17 ±  5%  sched_debug.cfs_rq:/.runnable_avg.avg
      1024            -0.9%       1015            +0.2%       1027        sched_debug.cfs_rq:/.runnable_avg.max
    191.09 ±  4%      -1.7%     187.93 ±  4%      +2.4%     195.67 ±  2%  sched_debug.cfs_rq:/.runnable_avg.stddev
    127233 ± 58%     -26.8%      93172 ± 75%     -14.6%     108684 ± 59%  sched_debug.cfs_rq:/.spread0.avg
    211559 ± 35%     -17.5%     174451 ± 41%     -11.0%     188247 ± 35%  sched_debug.cfs_rq:/.spread0.max
   -113105           +32.2%    -149579            -5.1%    -107354        sched_debug.cfs_rq:/.spread0.min
     51761 ± 10%      +0.9%      52243 ± 18%      -3.5%      49953 ± 17%  sched_debug.cfs_rq:/.spread0.stddev
     45.79 ±  9%      -3.5%      44.20 ±  8%      +4.8%      48.01 ±  5%  sched_debug.cfs_rq:/.util_avg.avg
      1023            -0.9%       1014            +0.1%       1024        sched_debug.cfs_rq:/.util_avg.max
    190.96 ±  4%      -1.7%     187.78 ±  4%      +2.3%     195.37 ±  2%  sched_debug.cfs_rq:/.util_avg.stddev
     13.16 ± 11%      -6.4%      12.31 ±  9%      +5.1%      13.82 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    712.63            -5.9%     670.75 ±  8%      +0.5%     716.43        sched_debug.cfs_rq:/.util_est_enqueued.max
     87.99 ±  5%      -5.5%      83.14 ±  7%      +5.0%      92.39 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
   1317111 ±  7%      +2.9%    1354705 ±  8%      +2.7%    1352759 ±  8%  sched_debug.cpu.avg_idle.avg
   4778622 ± 22%      -7.6%    4413375 ± 27%     +14.5%    5472387 ± 30%  sched_debug.cpu.avg_idle.max
    324439 ± 31%      +1.7%     329967 ± 36%      -3.7%     312477 ± 23%  sched_debug.cpu.avg_idle.min
    494330 ± 24%      -9.5%     447434 ± 21%      +4.4%     515859 ± 15%  sched_debug.cpu.avg_idle.stddev
    205657 ±  5%      +0.0%     205662 ±  5%      -1.6%     202420        sched_debug.cpu.clock.avg
    205845 ±  5%      +0.0%     205852 ±  5%      -1.6%     202610        sched_debug.cpu.clock.max
    205461 ±  5%      +0.0%     205464 ±  5%      -1.6%     202224        sched_debug.cpu.clock.min
    109.05            +0.6%     109.73            +0.6%     109.74        sched_debug.cpu.clock.stddev
    199388 ±  5%      +0.1%     199511 ±  5%      -1.4%     196636        sched_debug.cpu.clock_task.avg
    201330 ±  5%      +0.0%     201407 ±  5%      -1.5%     198383        sched_debug.cpu.clock_task.max
    194940 ±  6%      +0.0%     194974 ±  5%      -1.4%     192257        sched_debug.cpu.clock_task.min
    848.45 ±  7%      -0.8%     841.26 ±  9%     -10.5%     759.24 ±  8%  sched_debug.cpu.clock_task.stddev
     74.51 ±  8%     -10.0%      67.05 ±  8%      -1.8%      73.16 ±  6%  sched_debug.cpu.curr->pid.avg
      7080 ±  3%      -0.4%       7055 ±  3%      -1.5%       6973        sched_debug.cpu.curr->pid.max
    621.74 ±  5%      -4.5%     593.46 ±  3%      -1.7%     611.28 ±  3%  sched_debug.cpu.curr->pid.stddev
    687071 ±  7%      +3.1%     708055 ±  8%      +3.7%     712551 ±  9%  sched_debug.cpu.max_idle_balance_cost.avg
   2651195 ± 20%     -13.0%    2306941 ± 25%     +13.1%    2997994 ± 26%  sched_debug.cpu.max_idle_balance_cost.max
    501057            +1.5%     508372 ±  2%      -0.1%     500361        sched_debug.cpu.max_idle_balance_cost.min
    260536 ± 24%     -15.9%     219013 ± 25%      +2.5%     267003 ± 15%  sched_debug.cpu.max_idle_balance_cost.stddev
      4294            +0.0%       4294            -0.0%       4294        sched_debug.cpu.next_balance.avg
      4294            +0.0%       4294            -0.0%       4294        sched_debug.cpu.next_balance.max
      4294            +0.0%       4294            -0.0%       4294        sched_debug.cpu.next_balance.min
      0.00            +0.7%       0.00            +0.8%       0.00        sched_debug.cpu.next_balance.stddev
      0.02 ±  9%      -9.6%       0.01 ±  9%      +0.0%       0.02 ±  7%  sched_debug.cpu.nr_running.avg
      1.00            +0.0%       1.00            +2.9%       1.03 ±  6%  sched_debug.cpu.nr_running.max
      0.12 ±  3%      -3.7%       0.12 ±  4%      +0.4%       0.12 ±  3%  sched_debug.cpu.nr_running.stddev
      3029 ±  3%      -0.1%       3026 ±  3%      -0.7%       3008        sched_debug.cpu.nr_switches.avg
     37445 ± 12%      -9.3%      33949 ±  9%      -5.3%      35452 ± 21%  sched_debug.cpu.nr_switches.max
    925.22 ± 19%      +1.0%     934.19 ± 13%      -5.3%     875.94 ± 16%  sched_debug.cpu.nr_switches.min
      3504 ±  7%      -3.8%       3370 ±  4%      -4.1%       3361 ± 10%  sched_debug.cpu.nr_switches.stddev
      0.00 ± 55%     +19.3%       0.00 ± 30%     +34.2%       0.00 ± 26%  sched_debug.cpu.nr_uninterruptible.avg
    212.69            -0.7%     211.14 ±  3%      +0.3%     213.43 ±  2%  sched_debug.cpu.nr_uninterruptible.max
    -17.70           +10.9%     -19.63           +16.2%     -20.57        sched_debug.cpu.nr_uninterruptible.min
     13.81            +0.2%      13.84 ±  2%      +1.0%      13.95 ±  2%  sched_debug.cpu.nr_uninterruptible.stddev
    205460 ±  5%      +0.0%     205463 ±  5%      -1.6%     202223        sched_debug.cpu_clk
    996147            +0.0%     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.avg
    996147            +0.0%     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.max
    996147            +0.0%     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.min
 4.295e+09            +0.0%  4.295e+09            -0.0%  4.295e+09        sched_debug.jiffies
    204790 ±  5%      +0.0%     204795 ±  5%      -1.6%     201565        sched_debug.ktime
    950.00            +0.0%     950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.avg
    950.00            +0.0%     950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.max
    950.00            +0.0%     950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.min
    206248 ±  6%      -0.2%     205929 ±  5%      -1.6%     202950        sched_debug.sched_clk
      1.00            +0.0%       1.00            +0.0%       1.00        sched_debug.sched_clock_stable()
   4140603            +0.0%    4140603            +0.0%    4140603        sched_debug.sysctl_sched.sysctl_sched_features
     24.00            +0.0%      24.00            +0.0%      24.00        sched_debug.sysctl_sched.sysctl_sched_latency
      3.00            +0.0%       3.00            +0.0%       3.00        sched_debug.sysctl_sched.sysctl_sched_min_granularity
      1.00            +0.0%       1.00            +0.0%       1.00        sched_debug.sysctl_sched.sysctl_sched_tunable_scaling
      4.00            +0.0%       4.00            +0.0%       4.00        sched_debug.sysctl_sched.sysctl_sched_wakeup_granularity
      0.04 ±  4%      +2.3%       0.04 ± 11%      +4.1%       0.04 ±  5%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00          -100.0%       0.00        +2.9e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      0.00 ±223%     +58.2%       0.01 ±244%    +397.8%       0.02 ± 13%  perf-sched.sch_delay.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.isra
      0.01 ±110%    +193.5%       0.02 ± 68%     +55.8%       0.01 ± 63%  perf-sched.sch_delay.avg.ms.d_alloc_parallel.path_openat.do_filp_open.do_sys_openat2
      0.05 ± 14%     +39.5%       0.07 ± 20%     +64.3%       0.08 ± 68%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.04 ±  4%      +3.8%       0.04 ± 20%      +5.3%       0.04 ±  5%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.05 ± 14%     +21.9%       0.06 ± 22%     +43.0%       0.08 ± 29%  perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.03 ±  2%   +2234.4%       0.61 ±234%      +2.0%       0.03 ±  6%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.04 ±  2%      -1.6%       0.04            +1.2%       0.04 ±  2%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ±145%     -30.5%       0.01 ±158%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.01 ± 88%      -4.2%       0.01 ± 98%     +10.9%       0.01 ±109%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.01 ± 27%     +22.0%       0.01 ± 18%     +30.8%       0.01 ± 15%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.08 ± 32%      -2.1%       0.07 ± 36%     -13.7%       0.07 ± 59%  perf-sched.sch_delay.avg.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.00 ±223%     -21.1%       0.00 ±244%     +47.4%       0.01 ±158%  perf-sched.sch_delay.avg.ms.io_schedule.__lock_page.__do_fault.do_fault
      0.01 ± 85%     +97.3%       0.02 ± 72%    +106.8%       0.02 ± 21%  perf-sched.sch_delay.avg.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
      0.18 ±206%     -39.5%       0.11 ±138%     -66.3%       0.06 ±191%  perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00          -100.0%       0.00        +3.9e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.do_anonymous_page
      0.00          +3e+99%       0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.wp_page_copy
      0.01 ±223%    -100.0%       0.00           -23.8%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__flush_work.lru_add_drain_all.khugepaged
      0.00          -100.0%       0.00          +3e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.apparmor_file_alloc_security.security_file_alloc.__alloc_file
      0.00 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.copy_page_from_iter.pipe_write.new_sync_write
      0.00        +3.6e+99%       0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.copy_page_range.dup_mmap.dup_mm
      0.00        +5.9e+99%       0.01 ±244%    +9e+99%       0.01 ±161%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00 ±223%     -22.1%       0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.link_path_walk
      0.00          -100.0%       0.00        +4.6e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00 ±223%     -10.0%       0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      0.00 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.00          -100.0%       0.00          +3e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.00        +3.6e+99%       0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_openat
      0.00        +2.9e+99%       0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.do_exit
      0.00 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.exit_signals.do_exit.do_group_exit
      0.00          +6e+99%       0.01 ±159%  +4.1e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.filemap_read.__kernel_read.exec_binprm
      0.00          -100.0%       0.00        +3.1e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.filemap_read.new_sync_read.vfs_read
      0.00 ±223%    -100.0%       0.00            -3.1%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.force_qs_rnp.rcu_gp_kthread.kthread
      0.00          -100.0%       0.00        +2.9e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_fault
      0.01 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process
      0.00          -100.0%       0.00        +3.3e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_flags.do_sys_openat2
      0.00          -100.0%       0.00        +2.9e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma
      0.00       +9.8e+101%       0.98 ±244% +1.3e+103%      13.07 ±111%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      0.01 ±223%     -51.4%       0.00 ±244%     -51.4%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_write.new_sync_write
      0.01 ± 71%     -36.7%       0.01 ±115%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
      0.01 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.02 ± 73%     -13.4%       0.01 ± 88%     +27.7%       0.02 ± 99%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00        +3.6e+99%       0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.task_work_run.do_exit.do_group_exit
      0.00          -100.0%       0.00        +3.1e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00          -100.0%       0.00          +3e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.unmap_vmas.exit_mmap.mmput
      0.00          +3e+99%       0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.unmap_vmas.unmap_region.__do_munmap
      0.01 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.vmstat_shepherd.process_one_work.worker_thread
      0.01 ±142%      -8.7%       0.01 ±160%     +13.7%       0.01 ±115%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      0.03 ± 16%      -1.6%       0.03 ± 17%      +1.4%       0.03 ± 23%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.04 ±  6%     +25.6%       0.05 ± 16%     +47.0%       0.06 ± 35%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.03 ± 13%      +3.5%       0.03 ± 18%      +1.0%       0.03 ± 18%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.03 ± 10%      -4.7%       0.03 ±  8%      -1.0%       0.03 ±  4%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.04 ±  3%      -0.1%       0.04 ±  5%      +1.8%       0.04 ±  8%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00 ±223%    +267.9%       0.01 ±117%     +46.4%       0.01 ±244%  perf-sched.sch_delay.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      0.04 ± 39%      +2.3%       0.04 ± 24%      +7.4%       0.04 ± 29%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.02 ±101%     +61.4%       0.03 ± 66%     -49.8%       0.01 ±160%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion.__flush_work.lru_add_drain_all
      0.03 ± 10%      +9.4%       0.04 ± 15%      -2.6%       0.03 ± 15%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.02 ±  4%      -2.3%       0.02 ±  3%      +3.1%       0.02 ± 11%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      2.65 ±216%     -96.5%       0.09 ± 17%     -77.6%       0.59 ±216%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.06 ± 25%     +11.7%       0.07 ± 34%      +9.8%       0.07 ± 14%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00          -100.0%       0.00        +2.9e+99%       0.00 ±244%  perf-sched.sch_delay.max.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      0.00 ±223%     +52.4%       0.01 ±244%    +449.2%       0.02 ± 13%  perf-sched.sch_delay.max.ms.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.isra
      0.01 ±103%     +64.5%       0.02 ± 67%     +50.6%       0.02 ± 67%  perf-sched.sch_delay.max.ms.d_alloc_parallel.path_openat.do_filp_open.do_sys_openat2
      0.08 ± 25%    +129.5%       0.18 ± 68%    +135.3%       0.19 ±103%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.07 ± 42%     +19.8%       0.09 ± 73%     +25.0%       0.09 ± 22%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.09 ± 16%     +59.8%       0.14 ± 41%    +195.5%       0.26 ± 72%  perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.09 ± 27%  +1.6e+05%     143.22 ±244%    +155.0%       0.22 ± 55%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.12 ± 12%      +8.9%       0.14 ± 33%      -5.4%       0.12 ±  8%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ±145%     -28.8%       0.01 ±158%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.02 ± 46%      +8.5%       0.02 ±102%      -0.6%       0.02 ± 72%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.05 ± 22%      -2.8%       0.05 ± 13%      +4.0%       0.05 ± 23%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.17 ± 53%     +30.5%       0.23 ± 50%     -17.3%       0.14 ± 82%  perf-sched.sch_delay.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.00 ±223%     -21.1%       0.00 ±244%     +47.4%       0.01 ±158%  perf-sched.sch_delay.max.ms.io_schedule.__lock_page.__do_fault.do_fault
      0.02 ± 74%    +123.8%       0.04 ± 79%    +165.9%       0.05 ± 26%  perf-sched.sch_delay.max.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
    169.49 ±223%     +70.4%     288.75 ±158%     -13.8%     146.12 ±244%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00          -100.0%       0.00        +3.9e+99%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.do_anonymous_page
      0.00          +3e+99%       0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.wp_page_copy
      0.01 ±223%    -100.0%       0.00           -23.8%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__flush_work.lru_add_drain_all.khugepaged
      0.00          -100.0%       0.00          +3e+99%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.apparmor_file_alloc_security.security_file_alloc.__alloc_file
      0.00 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.copy_page_from_iter.pipe_write.new_sync_write
      0.00        +3.6e+99%       0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.copy_page_range.dup_mmap.dup_mm
      0.00        +8.6e+99%       0.01 ±244%    +9e+99%       0.01 ±161%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00 ±223%     -22.1%       0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.link_path_walk
      0.00          -100.0%       0.00        +4.6e+99%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00 ±223%     -10.0%       0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      0.00 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.00          -100.0%       0.00          +3e+99%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.00        +3.6e+99%       0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_openat
      0.00        +2.9e+99%       0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.exit_mmap.mmput.do_exit
      0.00 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.exit_signals.do_exit.do_group_exit
      0.00          +6e+99%       0.01 ±159%  +4.1e+99%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.filemap_read.__kernel_read.exec_binprm
      0.00          -100.0%       0.00        +3.1e+99%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.filemap_read.new_sync_read.vfs_read
      0.00 ±223%    -100.0%       0.00            -3.1%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.force_qs_rnp.rcu_gp_kthread.kthread
      0.00          -100.0%       0.00        +2.9e+99%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_fault
      0.01 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process
      0.00          -100.0%       0.00        +3.3e+99%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.getname_flags.do_sys_openat2
      0.00          -100.0%       0.00        +2.9e+99%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma
      0.00       +9.8e+101%       0.98 ±244% +1.3e+103%      13.07 ±111%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      0.01 ±223%     -51.4%       0.00 ±244%     -51.4%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.pipe_write.new_sync_write
      0.02 ± 72%     -39.4%       0.01 ±115%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
      0.01 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.02 ± 87%     -34.0%       0.01 ± 88%    +199.7%       0.07 ±139%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00        +3.6e+99%       0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.task_work_run.do_exit.do_group_exit
      0.00          -100.0%       0.00        +3.1e+99%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00          -100.0%       0.00          +3e+99%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.unmap_vmas.exit_mmap.mmput
      0.00          +3e+99%       0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.unmap_vmas.unmap_region.__do_munmap
      0.01 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.vmstat_shepherd.process_one_work.worker_thread
      0.12 ± 12%      +0.7%       0.12 ±  9%      -0.4%       0.12 ±  6%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.01 ±143%     -14.3%       0.01 ±160%      +6.7%       0.01 ±115%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      0.05 ± 14%      +5.8%       0.06 ± 19%     +40.8%       0.07 ± 61%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.07 ± 17%    +173.9%       0.19 ± 50%    +212.3%       0.21 ± 84%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.05 ± 26%      +5.6%       0.05 ± 36%      +3.0%       0.05 ± 35%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.07 ± 32%     -20.9%       0.05 ± 15%     -19.9%       0.06 ± 12%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.05 ±  3%      +3.2%       0.05 ± 11%      +5.5%       0.05 ±  9%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00 ±223%    +267.9%       0.01 ±117%     +46.4%       0.01 ±244%  perf-sched.sch_delay.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
     11.57 ±222%     +23.7%      14.31 ±119%     +30.2%      15.06 ± 96%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.02 ±101%     +61.4%       0.03 ± 66%     -49.8%       0.01 ±160%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion.__flush_work.lru_add_drain_all
     21.44 ± 21%      +8.6%      23.28 ± 20%      -0.3%      21.37 ± 46%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.06 ±  8%      -2.1%       0.06 ± 26%    +156.2%       0.16 ± 79%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    323.67 ±202%     -90.0%      32.27 ± 16%     -52.4%     154.18 ±208%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.23 ±157%     -73.9%       0.06 ± 63%     -68.6%       0.07 ±122%  perf-sched.total_sch_delay.average.ms
    488.61 ±140%      -8.0%     449.74 ±107%     -37.8%     303.98 ±141%  perf-sched.total_sch_delay.max.ms
    258.44            -0.3%     257.79            -0.5%     257.06        perf-sched.total_wait_and_delay.average.ms
     12954            -0.4%      12902            +0.4%      13011        perf-sched.total_wait_and_delay.count.ms
      9556 ±  2%      +3.1%       9855            +0.4%       9593 ±  3%  perf-sched.total_wait_and_delay.max.ms
    258.21            -0.2%     257.73            -0.5%     256.99        perf-sched.total_wait_time.average.ms
      9556 ±  2%      +3.1%       9855            +0.4%       9593 ±  3%  perf-sched.total_wait_time.max.ms
    895.86            +0.2%     897.67            +0.0%     896.10        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    397.38 ± 10%     +17.1%     465.53 ± 26%     -10.3%     356.58 ± 22%  perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    757.93 ±  8%      -3.5%     731.42 ±  8%      -1.2%     749.12 ±  8%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    397.42 ± 10%     +17.2%     465.58 ± 26%     -20.4%     316.40 ± 46%  perf-sched.wait_and_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
    276.84 ±  2%      +1.5%     281.04            +1.3%     280.37 ±  4%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      5.55            -1.0%       5.49            +0.2%       5.56        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00       +1.9e+104%     189.51 ±124%   +4e+103%      40.13 ±244%  perf-sched.wait_and_delay.avg.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
     52.73            +1.2%      53.37 ±  2%      -2.1%      51.63        perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00       +7.2e+103%      71.57 ±244%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00       +1.4e+104%     143.16 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00          -100.0%       0.00       +3.3e+104%     332.63 ±121%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      4.17 ± 37%     +42.0%       5.92 ± 20%      +9.3%       4.56 ± 35%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.46 ±  4%      +3.3%       4.61 ±  4%      +5.3%       4.70 ±  6%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    226.26 ± 70%      -4.7%     215.56 ± 86%     -14.3%     193.92 ± 86%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    813.83 ± 22%     -21.1%     642.34 ± 24%      -9.7%     734.96 ± 15%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    478.80            -0.1%     478.34            -0.1%     478.44        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      4.42 ±  2%      +2.5%       4.53            +0.7%       4.45 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    713.23            -0.4%     710.40            -0.5%     709.84        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.02 ±  3%      +7.1%       0.03 ± 20%     +23.4%       0.03 ± 17%  perf-sched.wait_and_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    743.24 ±  3%      -3.0%     720.85 ±  3%      -0.5%     739.22 ±  4%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
      9.83 ±  3%      +1.7%      10.00            +0.2%       9.86 ±  3%  perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      7.83 ± 13%     +22.2%       9.57 ±  9%     +11.2%       8.71 ± 17%  perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     12.00 ±  9%      +3.6%      12.43 ±  8%      +1.2%      12.14 ±  9%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      7.83 ± 13%     +22.2%       9.57 ±  9%      -7.0%       7.29 ± 45%  perf-sched.wait_and_delay.count.do_syslog.part.0.kmsg_read.vfs_read
    243.50            +0.1%     243.86            -0.0%     243.43        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    241.00            +0.6%     242.43            +0.2%     241.57        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00       +3.6e+102%       3.57 ±131% +1.4e+102%       1.43 ±244%  perf-sched.wait_and_delay.count.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      2961            -0.3%       2952            +1.5%       3006        perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00       +2.9e+101%       0.29 ±244%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00          -100.0%       0.00       +4.3e+101%       0.43 ±115%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      2816            +0.0%       2816            +0.0%       2816        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    352.50 ±  2%      -6.4%     329.86 ±  9%     -10.4%     315.86 ± 13%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork
     25.67 ± 71%      -9.3%      23.29 ± 86%     -17.6%      21.14 ± 86%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     33.17 ±  2%      -0.5%      33.00 ±  4%      -1.4%      32.71        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     40.00            -1.8%      39.29            -1.4%      39.43        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      1875 ±  3%      -1.9%       1839            +0.4%       1883 ±  4%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      3336            -0.0%       3335            +0.1%       3340        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
     71.17            +0.2%      71.29            -0.0%      71.14        perf-sched.wait_and_delay.count.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    863.17 ±  3%      +0.1%     864.00 ±  4%      +1.6%     876.86 ±  3%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
    997.53            +0.0%     997.56            +0.0%     997.54        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2685            +0.8%       2708            +0.2%       2690        perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1000            +0.0%       1000            +0.0%       1000        perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      2685            +0.8%       2708           -13.8%       2314 ± 40%  perf-sched.wait_and_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      1904 ± 36%     +38.3%       2634 ± 42%     +22.9%       2340 ± 28%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    135.59            +2.6%     139.10 ±  6%      +0.5%     136.29        perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00         +1e+105%       1048 ±118% +3.8e+104%     376.32 ±244%  perf-sched.wait_and_delay.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      2690            +0.8%       2712            +0.2%       2695        perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00       +1.4e+104%     143.14 ±244%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00       +1.4e+104%     143.16 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00          -100.0%       0.00       +3.3e+104%     332.63 ±121%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      3970 ±105%    +117.6%       8637 ± 36%     +24.5%       4941 ± 87%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      5.99            +0.1%       6.00            -0.2%       5.98        perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      1547 ± 70%     -11.6%       1368 ± 87%     -15.1%       1313 ± 86%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      6587 ± 59%     -52.9%       3103 ±109%      -3.3%       6372 ± 55%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    505.02            +0.0%     505.02            +0.0%     505.02        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     25.16 ± 97%     +28.8%      32.40 ± 47%     -23.7%      19.19 ± 56%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      1063            +2.3%       1088 ±  2%     +39.5%       1483 ± 64%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.06 ±  9%    +206.0%       0.20 ±164%    +209.5%       0.20 ± 58%  perf-sched.wait_and_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      8942 ±  5%      -1.5%       8812 ±  5%      -2.2%       8741 ±  5%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
    895.82            +0.2%     897.63            +0.0%     896.06        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00          -100.0%       0.00       +1.1e+100%       0.01 ±244%  perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      0.00          -100.0%       0.00        +2.6e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.isra
      0.01 ±106%     -74.3%       0.00 ±158%    +113.2%       0.03 ± 45%  perf-sched.wait_time.avg.ms.d_alloc_parallel.path_openat.do_filp_open.do_sys_openat2
    397.33 ± 10%     +17.1%     465.46 ± 26%     -10.3%     356.49 ± 22%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    757.89 ±  8%      -3.5%     731.38 ±  8%      -1.2%     749.08 ±  8%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    397.36 ± 10%     +17.2%     465.52 ± 26%     -19.8%     318.88 ± 44%  perf-sched.wait_time.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
    276.82 ±  2%      +1.3%     280.42            +1.3%     280.34 ±  4%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      5.51            -1.0%       5.45            +0.2%       5.52        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.05 ± 77%    +349.6%       0.21 ± 75%    +103.5%       0.10 ± 44%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.00         +2e+100%       0.02 ±185% +1.5e+100%       0.02 ±193%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.00       +2.9e+100%       0.03 ±244% +3.7e+100%       0.04 ±244%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_irq_work.[unknown]
      0.00       +1.1e+100%       0.01 ±244%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.27 ±127%   +7590.1%      20.76 ±240%     -46.0%       0.15 ±104%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
     70.02 ± 83%    +321.6%     295.23 ± 57%     +31.8%      92.26 ± 91%  perf-sched.wait_time.avg.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.01 ±153%     -95.0%       0.00 ±244%     -25.6%       0.01 ± 94%  perf-sched.wait_time.avg.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
     52.55            +1.4%      53.26 ±  2%      -1.9%      51.57        perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.08 ± 93%    +122.0%       0.19 ±154%     -39.7%       0.05 ±177%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
      0.04 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.apparmor_file_alloc_security.security_file_alloc.__alloc_file
      0.00       +6.9e+100%       0.07 ±244%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.copy_page_range.dup_mmap.dup_mm
      0.00       +7.2e+103%      71.56 ±244%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00       +1.4e+104%     143.15 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.10 ± 95%      +3.9%       0.10 ±115%     +28.3%       0.13 ± 63%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.down_write.generic_file_write_iter.new_sync_write
      0.00          -100.0%       0.00        +7.4e+99%       0.01 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
      0.00          -100.0%       0.00       +3.2e+100%       0.03 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_openat
      0.79 ±223%    -100.0%       0.00           -11.5%       0.70 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.force_qs_rnp.rcu_gp_kthread.kthread
      0.30 ± 63%      +4.7%       0.32 ± 91%     -49.7%       0.15 ± 40%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.06 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process
      0.00          -100.0%       0.00       +3.9e+100%       0.04 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mnt_want_write.path_openat.do_filp_open
      0.00       +5.3e+100%       0.05 ±244%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.__perf_event_read_value.perf_read
      0.00          -100.0%       0.00       +3.2e+104%     319.97 ±121%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      0.18 ± 68%     +87.3%       0.33 ±115%      -9.7%       0.16 ± 40%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.shmem_getpage_gfp.shmem_write_begin
      0.10 ± 72%     +41.1%       0.15 ±177%     +13.0%       0.12 ± 85%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.shmem_undo_range.shmem_truncate_range.shmem_evict_inode
      2.52 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.00          -100.0%       0.00        +4.3e+98%       0.00 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.15 ± 30%    +200.5%       0.45 ±127%    +108.5%       0.31 ±122%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
     34.69 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.vmstat_shepherd.process_one_work.worker_thread
      4.17 ± 37%     +42.1%       5.92 ± 20%      +9.4%       4.56 ± 35%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.43 ±  4%      +3.3%       4.58 ±  4%      +5.3%       4.67 ±  6%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    290.04 ± 24%      +3.7%     300.88 ± 30%      -7.7%     267.68 ± 31%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    813.80 ± 22%     -21.1%     642.31 ± 24%      -9.7%     734.93 ± 15%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    478.77            -0.1%     478.31            -0.1%     478.41        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.03 ± 84%     -12.1%       0.03 ± 99%     -48.2%       0.02 ±161%  perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      4.39 ±  2%      +2.5%       4.50            +0.6%       4.41 ±  4%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.62 ±198%     -76.3%       0.15 ± 50%     -82.3%       0.11 ± 32%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    713.19            -0.4%     710.36            -0.5%     709.81        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00 ± 82%    +277.1%       0.00 ±146%    +602.9%       0.01 ± 74%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
    740.59 ±  3%      -2.7%     720.76 ±  3%      -0.3%     738.63 ±  4%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
    997.48            +0.0%     997.51            +0.0%     997.50        perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00          -100.0%       0.00       +1.1e+100%       0.01 ±244%  perf-sched.wait_time.max.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      0.00          -100.0%       0.00        +7.6e+99%       0.01 ±244%  perf-sched.wait_time.max.ms.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.isra
      0.03 ±107%     -39.6%       0.02 ±173%    +152.7%       0.07 ± 92%  perf-sched.wait_time.max.ms.d_alloc_parallel.path_openat.do_filp_open.do_sys_openat2
      2685            +0.8%       2708            +0.2%       2690        perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1000            -0.0%       1000            +0.0%       1000        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      2685            +0.8%       2708           -13.6%       2320 ± 39%  perf-sched.wait_time.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      1904 ± 36%     +38.3%       2634 ± 42%     +22.9%       2340 ± 28%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    135.55            +2.6%     139.06 ±  6%      +0.5%     136.25        perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.11 ± 84%    +494.5%       0.68 ±130%     +98.7%       0.23 ± 33%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.00         +2e+100%       0.02 ±185% +1.5e+100%       0.02 ±193%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.00       +2.9e+100%       0.03 ±244% +3.7e+100%       0.04 ±244%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_irq_work.[unknown]
      0.00       +1.1e+100%       0.01 ±244%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      2.84 ±188%   +4984.7%     144.46 ±242%     -71.1%       0.82 ±140%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
    279.94 ±122%    +452.6%       1546 ± 59%    +103.5%     569.60 ±153%  perf-sched.wait_time.max.ms.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex
      0.03 ±121%     -81.6%       0.00 ±244%     +51.9%       0.04 ± 49%  perf-sched.wait_time.max.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
      2690            +0.8%       2712            +0.2%       2695        perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.11 ±105%    +402.2%       0.58 ±204%     -53.3%       0.05 ±178%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
      0.04 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.apparmor_file_alloc_security.security_file_alloc.__alloc_file
      0.00       +6.9e+100%       0.07 ±244%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.copy_page_range.dup_mmap.dup_mm
      0.00       +1.4e+104%     143.13 ±244%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00       +1.4e+104%     143.15 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.10 ± 90%      +2.4%       0.11 ±115%     +58.0%       0.16 ± 67%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.generic_file_write_iter.new_sync_write
      0.00          -100.0%       0.00        +7.4e+99%       0.01 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
      0.00          -100.0%       0.00       +3.2e+100%       0.03 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_openat
      0.79 ±223%    -100.0%       0.00           -11.5%       0.70 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.force_qs_rnp.rcu_gp_kthread.kthread
      1.17 ±144%     +39.1%       1.62 ±121%     -72.5%       0.32 ± 67%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.06 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.alloc_pid.copy_process
      0.00          -100.0%       0.00       +3.9e+100%       0.04 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mnt_want_write.path_openat.do_filp_open
      0.00       +5.3e+100%       0.05 ±244%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.__perf_event_read_value.perf_read
      0.00          -100.0%       0.00       +3.2e+104%     319.97 ±121%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.drm_gem_shmem_vunmap.mgag200_handle_damage
      0.38 ±103%    +151.3%       0.95 ±129%      -5.0%       0.36 ± 77%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.pagecache_get_page.shmem_getpage_gfp.shmem_write_begin
      0.15 ± 79%     +54.7%       0.23 ±181%      -1.0%       0.15 ± 82%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.shmem_undo_range.shmem_truncate_range.shmem_evict_inode
      2.52 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.00          -100.0%       0.00          +4e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.24 ±  9%    +510.2%       1.47 ±145%    +346.6%       1.08 ±162%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.vfs_write.ksys_write.do_syscall_64
     34.69 ±223%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.vmstat_shepherd.process_one_work.worker_thread
      3970 ±105%    +117.6%       8637 ± 36%     +24.5%       4941 ± 87%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      5.96            +0.1%       5.97            -0.2%       5.95        perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      2293 ±  3%      +2.1%       2340 ±  7%      +1.0%       2316 ±  3%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      6587 ± 59%     -52.9%       3103 ±109%      -3.3%       6372 ± 55%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    504.98            +0.0%     504.98            -0.0%     504.98        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.03 ± 84%     -12.1%       0.03 ± 99%     -48.2%       0.02 ±161%  perf-sched.wait_time.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
     22.11 ± 89%     +19.8%      26.49 ± 69%     -53.8%      10.23 ± 33%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      2.30 ±214%     -87.4%       0.29 ± 92%     -92.4%       0.17 ± 55%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      1063            +2.3%       1088 ±  2%     +39.5%       1483 ± 64%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.04 ± 77%    +394.0%       0.18 ±187%    +375.0%       0.17 ± 69%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      8942 ±  5%      -1.5%       8812 ±  5%      -2.2%       8741 ±  5%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
     40521            +0.2%      40606            +0.6%      40756        slabinfo.Acpi-Operand.active_objs
    724.00            +0.3%     725.86            +0.6%     728.57        slabinfo.Acpi-Operand.active_slabs
     40575            +0.2%      40674            +0.6%      40828        slabinfo.Acpi-Operand.num_objs
    724.00            +0.3%     725.86            +0.6%     728.57        slabinfo.Acpi-Operand.num_slabs
      1301 ±  9%      +8.9%       1418 ±  9%     +12.1%       1460 ±  7%  slabinfo.Acpi-Parse.active_objs
     17.83 ±  9%      +8.9%      19.43 ±  9%     +12.1%      20.00 ±  7%  slabinfo.Acpi-Parse.active_slabs
      1301 ±  9%      +8.9%       1418 ±  9%     +12.1%       1460 ±  7%  slabinfo.Acpi-Parse.num_objs
     17.83 ±  9%      +8.9%      19.43 ±  9%     +12.1%      20.00 ±  7%  slabinfo.Acpi-Parse.num_slabs
     12959            -0.7%      12866            -0.7%      12863        slabinfo.Acpi-State.active_objs
    253.50            -0.7%     251.71            -0.8%     251.57        slabinfo.Acpi-State.active_slabs
     12959            -0.7%      12866            -0.7%      12863        slabinfo.Acpi-State.num_objs
    253.50            -0.7%     251.71            -0.8%     251.57        slabinfo.Acpi-State.num_slabs
      3351 ±  3%      +2.2%       3425 ±  4%      -2.0%       3283 ±  6%  slabinfo.PING.active_objs
    104.33 ±  3%      +2.0%     106.43 ±  4%      -2.4%     101.86 ±  6%  slabinfo.PING.active_slabs
      3351 ±  3%      +2.2%       3425 ±  4%      -2.0%       3283 ±  6%  slabinfo.PING.num_objs
    104.33 ±  3%      +2.0%     106.43 ±  4%      -2.4%     101.86 ±  6%  slabinfo.PING.num_slabs
    512.00            +0.0%     512.00            +0.0%     512.00        slabinfo.RAW.active_objs
     16.00            +0.0%      16.00            +0.0%      16.00        slabinfo.RAW.active_slabs
    512.00            +0.0%     512.00            +0.0%     512.00        slabinfo.RAW.num_objs
     16.00            +0.0%      16.00            +0.0%      16.00        slabinfo.RAW.num_slabs
    264.33 ±  3%      +4.0%     274.86 ±  4%      +5.4%     278.57 ±  4%  slabinfo.RAWv6.active_objs
     10.17 ±  3%      +4.0%      10.57 ±  4%      +5.4%      10.71 ±  4%  slabinfo.RAWv6.active_slabs
    264.33 ±  3%      +4.0%     274.86 ±  4%      +5.4%     278.57 ±  4%  slabinfo.RAWv6.num_objs
     10.17 ±  3%      +4.0%      10.57 ±  4%      +5.4%      10.71 ±  4%  slabinfo.RAWv6.num_slabs
     56.00            -7.1%      52.00 ± 12%      +0.0%      56.00        slabinfo.TCP.active_objs
      4.00            -7.1%       3.71 ± 12%      +0.0%       4.00        slabinfo.TCP.active_slabs
     56.00            -7.1%      52.00 ± 12%      +0.0%      56.00        slabinfo.TCP.num_objs
      4.00            -7.1%       3.71 ± 12%      +0.0%       4.00        slabinfo.TCP.num_slabs
     39.00            +0.0%      39.00            -4.8%      37.14 ± 12%  slabinfo.TCPv6.active_objs
      3.00            +0.0%       3.00            -4.8%       2.86 ± 12%  slabinfo.TCPv6.active_slabs
     39.00            +0.0%      39.00            -4.8%      37.14 ± 12%  slabinfo.TCPv6.num_objs
      3.00            +0.0%       3.00            -4.8%       2.86 ± 12%  slabinfo.TCPv6.num_slabs
    157.00            -2.3%     153.43 ±  5%      -2.5%     153.14 ±  4%  slabinfo.UDPv6.active_objs
      6.00            -2.4%       5.86 ±  5%      -2.4%       5.86 ±  5%  slabinfo.UDPv6.active_slabs
    157.00            -2.3%     153.43 ±  5%      -2.5%     153.14 ±  4%  slabinfo.UDPv6.num_objs
      6.00            -2.4%       5.86 ±  5%      -2.4%       5.86 ±  5%  slabinfo.UDPv6.num_slabs
     40958            -0.4%      40787 ±  2%      +1.1%      41426 ±  4%  slabinfo.anon_vma.active_objs
    889.83            -0.4%     886.14 ±  2%      +1.2%     900.14 ±  4%  slabinfo.anon_vma.active_slabs
     40958            -0.4%      40787 ±  2%      +1.1%      41426 ±  4%  slabinfo.anon_vma.num_objs
    889.83            -0.4%     886.14 ±  2%      +1.2%     900.14 ±  4%  slabinfo.anon_vma.num_slabs
     88795            -0.2%      88613            +1.5%      90113 ±  4%  slabinfo.anon_vma_chain.active_objs
      1387            -0.2%       1384            +1.5%       1407 ±  4%  slabinfo.anon_vma_chain.active_slabs
     88795            -0.2%      88613            +1.5%      90113 ±  4%  slabinfo.anon_vma_chain.num_objs
      1387            -0.2%       1384            +1.5%       1407 ±  4%  slabinfo.anon_vma_chain.num_slabs
    140.00 ±  8%     -12.2%     122.86 ± 10%      -2.0%     137.14 ±  5%  slabinfo.bdev_cache.active_objs
      7.00 ±  8%     -12.2%       6.14 ± 10%      -2.0%       6.86 ±  5%  slabinfo.bdev_cache.active_slabs
    140.00 ±  8%     -12.2%     122.86 ± 10%      -2.0%     137.14 ±  5%  slabinfo.bdev_cache.num_objs
      7.00 ±  8%     -12.2%       6.14 ± 10%      -2.0%       6.86 ±  5%  slabinfo.bdev_cache.num_slabs
    144.00 ±  6%     +11.1%     160.00 ±  9%     +23.8%     178.29 ± 11%  slabinfo.biovec-128.active_objs
      9.00 ±  6%     +11.1%      10.00 ±  9%     +23.8%      11.14 ± 11%  slabinfo.biovec-128.active_slabs
    144.00 ±  6%     +11.1%     160.00 ±  9%     +23.8%     178.29 ± 11%  slabinfo.biovec-128.num_objs
      9.00 ±  6%     +11.1%      10.00 ±  9%     +23.8%      11.14 ± 11%  slabinfo.biovec-128.num_slabs
    384.00 ±  4%      +6.0%     406.86 ± 10%     +11.9%     429.71 ±  8%  slabinfo.biovec-64.active_objs
     12.00 ±  4%      +6.0%      12.71 ± 10%     +11.9%      13.43 ±  8%  slabinfo.biovec-64.active_slabs
    384.00 ±  4%      +6.0%     406.86 ± 10%     +11.9%     429.71 ±  8%  slabinfo.biovec-64.num_objs
     12.00 ±  4%      +6.0%      12.71 ± 10%     +11.9%      13.43 ±  8%  slabinfo.biovec-64.num_slabs
     57.33 ±  5%      -0.3%      57.14 ±  4%      -0.3%      57.14 ±  4%  slabinfo.biovec-max.active_objs
      7.17 ±  5%      -0.3%       7.14 ±  4%      -0.3%       7.14 ±  4%  slabinfo.biovec-max.active_slabs
     57.33 ±  5%      -0.3%      57.14 ±  4%      -0.3%      57.14 ±  4%  slabinfo.biovec-max.num_objs
      7.17 ±  5%      -0.3%       7.14 ±  4%      -0.3%       7.14 ±  4%  slabinfo.biovec-max.num_slabs
    624.00 ±  7%      +1.8%     635.14 ±  7%     +17.9%     735.43 ±  9%  slabinfo.buffer_head.active_objs
      8.00 ±  7%      +1.8%       8.14 ±  7%     +17.9%       9.43 ±  9%  slabinfo.buffer_head.active_slabs
    624.00 ±  7%      +1.8%     635.14 ±  7%     +17.9%     735.43 ±  9%  slabinfo.buffer_head.num_objs
      8.00 ±  7%      +1.8%       8.14 ±  7%     +17.9%       9.43 ±  9%  slabinfo.buffer_head.num_slabs
     13228            -0.1%      13217            +0.3%      13264        slabinfo.cred_jar.active_objs
    314.17            -0.0%     314.14            +0.4%     315.57        slabinfo.cred_jar.active_slabs
     13228            -0.1%      13217            +0.3%      13264        slabinfo.cred_jar.num_objs
    314.17            -0.0%     314.14            +0.4%     315.57        slabinfo.cred_jar.num_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.dax_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dax_cache.active_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.dax_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dax_cache.num_slabs
    141406            -0.5%     140636            +0.3%     141861        slabinfo.dentry.active_objs
      3369            -0.6%       3349            +0.3%       3378        slabinfo.dentry.active_slabs
    141538            -0.6%     140695            +0.3%     141920        slabinfo.dentry.num_objs
      3369            -0.6%       3349            +0.3%       3378        slabinfo.dentry.num_slabs
     30.00            +0.0%      30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.active_slabs
     30.00            +0.0%      30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.num_slabs
      1600 ± 23%      +6.9%       1711 ± 20%      -0.9%       1586 ± 15%  slabinfo.dmaengine-unmap-16.active_objs
     37.67 ± 23%      +7.0%      40.29 ± 20%      -1.0%      37.29 ± 16%  slabinfo.dmaengine-unmap-16.active_slabs
      1600 ± 23%      +6.9%       1711 ± 20%      -0.9%       1586 ± 15%  slabinfo.dmaengine-unmap-16.num_objs
     37.67 ± 23%      +7.0%      40.29 ± 20%      -1.0%      37.29 ± 16%  slabinfo.dmaengine-unmap-16.num_slabs
     15.00            +0.0%      15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.active_slabs
     15.00            +0.0%      15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.num_slabs
     53326 ±  4%      -5.8%      50212 ±  4%      +0.7%      53694 ±  3%  slabinfo.ep_head.active_objs
    208.17 ±  4%      -5.8%     196.14 ±  4%      +0.7%     209.57 ±  3%  slabinfo.ep_head.active_slabs
     53326 ±  4%      -5.8%      50212 ±  4%      +0.7%      53694 ±  3%  slabinfo.ep_head.num_objs
    208.17 ±  4%      -5.8%     196.14 ±  4%      +0.7%     209.57 ±  3%  slabinfo.ep_head.num_slabs
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
      2778 ± 10%      +2.7%       2853 ±  5%      +6.9%       2969 ±  6%  slabinfo.file_lock_cache.active_objs
     36.67 ±  9%      +2.5%      37.57 ±  5%      +7.1%      39.29 ±  6%  slabinfo.file_lock_cache.active_slabs
      2778 ± 10%      +2.7%       2853 ±  5%      +6.9%       2969 ±  6%  slabinfo.file_lock_cache.num_objs
     36.67 ±  9%      +2.5%      37.57 ±  5%      +7.1%      39.29 ±  6%  slabinfo.file_lock_cache.num_slabs
     11920            -0.1%      11907            +0.8%      12019        slabinfo.files_cache.active_objs
    258.50            -0.1%     258.29            +0.9%     260.86        slabinfo.files_cache.active_slabs
     11920            -0.1%      11907            +0.8%      12019        slabinfo.files_cache.num_objs
    258.50            -0.1%     258.29            +0.9%     260.86        slabinfo.files_cache.num_slabs
     68085 ±  4%      +0.5%      68421 ±  2%      +2.5%      69787 ±  2%  slabinfo.filp.active_objs
      1064 ±  4%      +0.6%       1070 ±  2%      +2.5%       1090 ±  2%  slabinfo.filp.active_slabs
     68120 ±  4%      +0.6%      68529 ±  2%      +2.5%      69827 ±  2%  slabinfo.filp.num_objs
      1064 ±  4%      +0.6%       1070 ±  2%      +2.5%       1090 ±  2%  slabinfo.filp.num_slabs
      3555 ±  9%      -2.0%       3484 ± 12%      +3.7%       3688 ± 13%  slabinfo.fsnotify_mark_connector.active_objs
     27.50 ±  9%      -2.3%      26.86 ± 12%      +3.9%      28.57 ± 13%  slabinfo.fsnotify_mark_connector.active_slabs
      3555 ±  9%      -2.0%       3484 ± 12%      +3.7%       3688 ± 13%  slabinfo.fsnotify_mark_connector.num_objs
     27.50 ±  9%      -2.3%      26.86 ± 12%      +3.9%      28.57 ± 13%  slabinfo.fsnotify_mark_connector.num_slabs
     13812            +0.1%      13830            +1.0%      13952        slabinfo.ftrace_event_field.active_objs
    162.50            +0.1%     162.71            +1.0%     164.14        slabinfo.ftrace_event_field.active_slabs
     13812            +0.1%      13830            +1.0%      13952        slabinfo.ftrace_event_field.num_objs
    162.50            +0.1%     162.71            +1.0%     164.14        slabinfo.ftrace_event_field.num_slabs
    104.00            +0.0%     104.00            +0.0%     104.00        slabinfo.hugetlbfs_inode_cache.active_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.active_slabs
    104.00            +0.0%     104.00            +0.0%     104.00        slabinfo.hugetlbfs_inode_cache.num_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.num_slabs
     82023            -0.0%      82022            +0.6%      82503        slabinfo.inode_cache.active_objs
      1521            -0.0%       1521            +0.6%       1530        slabinfo.inode_cache.active_slabs
     82196            -0.0%      82191            +0.6%      82677        slabinfo.inode_cache.num_objs
      1521            -0.0%       1521            +0.6%       1530        slabinfo.inode_cache.num_slabs
    256.00            +0.0%     256.00            +0.0%     256.00        slabinfo.jbd2_revoke_table_s.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.jbd2_revoke_table_s.active_slabs
    256.00            +0.0%     256.00            +0.0%     256.00        slabinfo.jbd2_revoke_table_s.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.jbd2_revoke_table_s.num_slabs
    114193            -0.1%     114110            +0.2%     114435        slabinfo.kernfs_node_cache.active_objs
      1784            -0.1%       1782            +0.2%       1787        slabinfo.kernfs_node_cache.active_slabs
    114193            -0.1%     114110            +0.2%     114435        slabinfo.kernfs_node_cache.num_objs
      1784            -0.1%       1782            +0.2%       1787        slabinfo.kernfs_node_cache.num_slabs
      4706 ±  9%      +7.0%       5035 ±  5%      +5.0%       4941 ±  7%  slabinfo.khugepaged_mm_slot.active_objs
     63.67 ±  9%      +6.8%      68.00 ±  5%      +4.8%      66.71 ±  7%  slabinfo.khugepaged_mm_slot.active_slabs
      4706 ±  9%      +7.0%       5035 ±  5%      +5.0%       4941 ±  7%  slabinfo.khugepaged_mm_slot.num_objs
     63.67 ±  9%      +6.8%      68.00 ±  5%      +4.8%      66.71 ±  7%  slabinfo.khugepaged_mm_slot.num_slabs
     18844            +0.1%      18859            -0.2%      18809        slabinfo.kmalloc-128.active_objs
    295.83            +0.5%     297.43            +0.1%     296.00        slabinfo.kmalloc-128.active_slabs
     18935            +0.6%      19049            +0.1%      18952        slabinfo.kmalloc-128.num_objs
    295.83            +0.5%     297.43            +0.1%     296.00        slabinfo.kmalloc-128.num_slabs
     73896            -0.1%      73796            +0.4%      74172        slabinfo.kmalloc-16.active_objs
    288.67            -0.1%     288.29            +0.4%     289.86        slabinfo.kmalloc-16.active_slabs
     73898            -0.1%      73801            +0.4%      74203        slabinfo.kmalloc-16.num_objs
    288.67            -0.1%     288.29            +0.4%     289.86        slabinfo.kmalloc-16.num_slabs
     12240            -0.0%      12235            -0.2%      12209        slabinfo.kmalloc-192.active_objs
    295.00            -0.4%     293.86            -0.1%     294.57        slabinfo.kmalloc-192.active_slabs
     12390            -0.3%      12347            -0.1%      12372        slabinfo.kmalloc-192.num_objs
    295.00            -0.4%     293.86            -0.1%     294.57        slabinfo.kmalloc-192.num_slabs
     11273            +0.4%      11314            +0.3%      11311        slabinfo.kmalloc-1k.active_objs
    355.00            +0.0%     355.14            +0.3%     356.14        slabinfo.kmalloc-1k.active_slabs
     11370            +0.1%      11382            +0.3%      11408        slabinfo.kmalloc-1k.num_objs
    355.00            +0.0%     355.14            +0.3%     356.14        slabinfo.kmalloc-1k.num_slabs
     20671            -0.2%      20626            -0.3%      20614        slabinfo.kmalloc-256.active_objs
    328.17            -0.5%     326.57            -0.7%     326.00        slabinfo.kmalloc-256.active_slabs
     21017            -0.4%      20926            -0.7%      20875        slabinfo.kmalloc-256.num_objs
    328.17            -0.5%     326.57            -0.7%     326.00        slabinfo.kmalloc-256.num_slabs
     11373            +1.4%      11536            +1.9%      11585        slabinfo.kmalloc-2k.active_objs
    712.83            +1.4%     723.14            +1.8%     725.43        slabinfo.kmalloc-2k.active_slabs
     11410            +1.5%      11576            +1.8%      11615        slabinfo.kmalloc-2k.num_objs
    712.83            +1.4%     723.14            +1.8%     725.43        slabinfo.kmalloc-2k.num_slabs
     75291 ±  2%      -0.5%      74893            +0.2%      75420 ±  2%  slabinfo.kmalloc-32.active_objs
    588.67 ±  2%      -0.6%     585.14            +0.1%     589.29 ±  2%  slabinfo.kmalloc-32.active_slabs
     75376 ±  2%      -0.6%      74958            +0.1%      75487 ±  2%  slabinfo.kmalloc-32.num_objs
    588.67 ±  2%      -0.6%     585.14            +0.1%     589.29 ±  2%  slabinfo.kmalloc-32.num_slabs
      3326            -0.0%       3325            +0.4%       3339        slabinfo.kmalloc-4k.active_objs
    419.50            +0.3%     420.86            +0.6%     421.86        slabinfo.kmalloc-4k.active_slabs
      3358            +0.3%       3370            +0.6%       3377        slabinfo.kmalloc-4k.num_objs
    419.50            +0.3%     420.86            +0.6%     421.86        slabinfo.kmalloc-4k.num_slabs
     36407 ±  2%      -0.8%      36104 ±  2%      -1.5%      35849 ±  3%  slabinfo.kmalloc-512.active_objs
    572.00 ±  2%      -0.6%     568.71 ±  2%      -1.4%     563.71 ±  3%  slabinfo.kmalloc-512.active_slabs
     36644 ±  2%      -0.6%      36421 ±  2%      -1.5%      36094 ±  3%  slabinfo.kmalloc-512.num_objs
    572.00 ±  2%      -0.6%     568.71 ±  2%      -1.4%     563.71 ±  3%  slabinfo.kmalloc-512.num_slabs
     35497            +0.2%      35566            +0.4%      35643        slabinfo.kmalloc-64.active_objs
    557.67            +0.2%     558.57            +0.5%     560.29        slabinfo.kmalloc-64.active_slabs
     35700            +0.3%      35792            +0.5%      35865        slabinfo.kmalloc-64.num_objs
    557.67            +0.2%     558.57            +0.5%     560.29        slabinfo.kmalloc-64.num_slabs
    138700            -0.2%     138485            -0.1%     138566        slabinfo.kmalloc-8.active_objs
    271.33            +0.1%     271.71            -0.1%     271.00        slabinfo.kmalloc-8.active_slabs
    139005            +0.1%     139168            -0.1%     138824        slabinfo.kmalloc-8.num_objs
    271.33            +0.1%     271.71            -0.1%     271.00        slabinfo.kmalloc-8.num_slabs
      1445            -0.2%       1442            -0.2%       1443        slabinfo.kmalloc-8k.active_objs
    364.17            -0.2%     363.43            -0.2%     363.57        slabinfo.kmalloc-8k.active_slabs
      1459            -0.2%       1456            -0.2%       1457        slabinfo.kmalloc-8k.num_objs
    364.17            -0.2%     363.43            -0.2%     363.57        slabinfo.kmalloc-8k.num_slabs
     21358 ±  2%      +0.3%      21430 ±  3%      -1.0%      21136 ±  3%  slabinfo.kmalloc-96.active_objs
    508.50 ±  2%      +0.4%     510.29 ±  3%      -0.9%     504.14 ±  3%  slabinfo.kmalloc-96.active_slabs
     21383 ±  2%      +0.3%      21456 ±  3%      -0.9%      21199 ±  3%  slabinfo.kmalloc-96.num_objs
    508.50 ±  2%      +0.4%     510.29 ±  3%      -0.9%     504.14 ±  3%  slabinfo.kmalloc-96.num_slabs
    554.67 ± 14%      -1.1%     548.57 ±  5%      +2.2%     566.86 ± 11%  slabinfo.kmalloc-rcl-128.active_objs
      8.67 ± 14%      -1.1%       8.57 ±  5%      +2.2%       8.86 ± 11%  slabinfo.kmalloc-rcl-128.active_slabs
    554.67 ± 14%      -1.1%     548.57 ±  5%      +2.2%     566.86 ± 11%  slabinfo.kmalloc-rcl-128.num_objs
      8.67 ± 14%      -1.1%       8.57 ±  5%      +2.2%       8.86 ± 11%  slabinfo.kmalloc-rcl-128.num_slabs
    294.00 ±  8%     -12.2%     258.00 ± 10%      -6.1%     276.00 ± 11%  slabinfo.kmalloc-rcl-192.active_objs
      7.00 ±  8%     -12.2%       6.14 ± 10%      -6.1%       6.57 ± 11%  slabinfo.kmalloc-rcl-192.active_slabs
    294.00 ±  8%     -12.2%     258.00 ± 10%      -6.1%     276.00 ± 11%  slabinfo.kmalloc-rcl-192.num_objs
      7.00 ±  8%     -12.2%       6.14 ± 10%      -6.1%       6.57 ± 11%  slabinfo.kmalloc-rcl-192.num_slabs
    192.00            +0.0%     192.00            +0.0%     192.00        slabinfo.kmalloc-rcl-256.active_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.kmalloc-rcl-256.active_slabs
    192.00            +0.0%     192.00            +0.0%     192.00        slabinfo.kmalloc-rcl-256.num_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.kmalloc-rcl-256.num_slabs
     18025            -0.1%      18010            -0.1%      18000        slabinfo.kmalloc-rcl-512.active_objs
    281.17            +0.1%     281.57            +0.0%     281.29        slabinfo.kmalloc-rcl-512.active_slabs
     18025            +0.1%      18046            +0.1%      18035        slabinfo.kmalloc-rcl-512.num_objs
    281.17            +0.1%     281.57            +0.0%     281.29        slabinfo.kmalloc-rcl-512.num_slabs
      5600 ±  8%      -5.8%       5272 ±  4%      +0.2%       5611 ±  9%  slabinfo.kmalloc-rcl-64.active_objs
     87.00 ±  8%      -5.9%      81.86 ±  4%      +0.2%      87.14 ±  9%  slabinfo.kmalloc-rcl-64.active_slabs
      5600 ±  8%      -5.8%       5272 ±  4%      +0.2%       5611 ±  9%  slabinfo.kmalloc-rcl-64.num_objs
     87.00 ±  8%      -5.9%      81.86 ±  4%      +0.2%      87.14 ±  9%  slabinfo.kmalloc-rcl-64.num_slabs
      2132 ± 11%      -3.4%       2061 ±  6%      +0.3%       2138 ±  7%  slabinfo.kmalloc-rcl-96.active_objs
     50.50 ± 11%      -3.5%      48.71 ±  6%      +0.1%      50.57 ±  7%  slabinfo.kmalloc-rcl-96.active_slabs
      2132 ± 11%      -3.4%       2061 ±  6%      +0.3%       2138 ±  7%  slabinfo.kmalloc-rcl-96.num_objs
     50.50 ± 11%      -3.5%      48.71 ±  6%      +0.1%      50.57 ±  7%  slabinfo.kmalloc-rcl-96.num_slabs
    586.67 ±  9%     +27.8%     749.71 ± 12%     +16.9%     685.71 ±  8%  slabinfo.kmem_cache.active_objs
      9.17 ±  9%     +27.8%      11.71 ± 12%     +16.9%      10.71 ±  8%  slabinfo.kmem_cache.active_slabs
    586.67 ±  9%     +27.8%     749.71 ± 12%     +16.9%     685.71 ±  8%  slabinfo.kmem_cache.num_objs
      9.17 ±  9%     +27.8%      11.71 ± 12%     +16.9%      10.71 ±  8%  slabinfo.kmem_cache.num_slabs
    733.67 ±  7%     +22.2%     896.71 ± 10%     +13.5%     832.71 ±  6%  slabinfo.kmem_cache_node.active_objs
     12.17 ±  7%     +20.9%      14.71 ± 10%     +12.7%      13.71 ±  6%  slabinfo.kmem_cache_node.active_slabs
    778.67 ±  7%     +20.9%     941.71 ± 10%     +12.7%     877.71 ±  6%  slabinfo.kmem_cache_node.num_objs
     12.17 ±  7%     +20.9%      14.71 ± 10%     +12.7%      13.71 ±  6%  slabinfo.kmem_cache_node.num_slabs
     48159            -0.3%      47993            -0.1%      48121        slabinfo.lsm_file_cache.active_objs
    282.50            -0.3%     281.57            -0.1%     282.29        slabinfo.lsm_file_cache.active_slabs
     48159            -0.3%      47993            -0.1%      48121        slabinfo.lsm_file_cache.num_objs
    282.50            -0.3%     281.57            -0.1%     282.29        slabinfo.lsm_file_cache.num_slabs
      7934            +0.2%       7948            +1.3%       8035        slabinfo.mm_struct.active_objs
    263.83            +0.2%     264.43            +1.3%     267.14        slabinfo.mm_struct.active_slabs
      7934            +0.2%       7948            +1.3%       8035        slabinfo.mm_struct.num_objs
    263.83            +0.2%     264.43            +1.3%     267.14        slabinfo.mm_struct.num_slabs
    900.00 ± 10%      +1.9%     917.14 ± 11%      +2.7%     924.43 ± 10%  slabinfo.mnt_cache.active_objs
     16.67 ± 10%      +2.9%      17.14 ± 11%      +3.7%      17.29 ± 11%  slabinfo.mnt_cache.active_slabs
    900.00 ± 10%      +1.9%     917.14 ± 11%      +2.7%     924.43 ± 10%  slabinfo.mnt_cache.num_objs
     16.67 ± 10%      +2.9%      17.14 ± 11%      +3.7%      17.29 ± 11%  slabinfo.mnt_cache.num_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.active_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.num_slabs
      2048            +0.2%       2052            +0.2%       2051        slabinfo.names_cache.active_objs
    256.00            +0.2%     256.57            +0.2%     256.43        slabinfo.names_cache.active_slabs
      2048            +0.2%       2052            +0.2%       2051        slabinfo.names_cache.num_objs
    256.00            +0.2%     256.57            +0.2%     256.43        slabinfo.names_cache.num_slabs
     36.00            +0.0%      36.00            +0.0%      36.00        slabinfo.nfs_read_data.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.nfs_read_data.active_slabs
     36.00            +0.0%      36.00            +0.0%      36.00        slabinfo.nfs_read_data.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.nfs_read_data.num_slabs
    310.00            +0.0%     310.00            +0.0%     310.00        slabinfo.numa_policy.active_objs
      5.00            +0.0%       5.00            +0.0%       5.00        slabinfo.numa_policy.active_slabs
    310.00            +0.0%     310.00            +0.0%     310.00        slabinfo.numa_policy.num_objs
      5.00            +0.0%       5.00            +0.0%       5.00        slabinfo.numa_policy.num_slabs
     20515 ±  2%      -2.1%      20088 ±  2%      -0.5%      20416 ±  2%  slabinfo.pde_opener.active_objs
    200.67 ±  2%      -2.1%     196.43 ±  2%      -0.5%     199.57 ±  2%  slabinfo.pde_opener.active_slabs
     20515 ±  2%      -2.1%      20088 ±  2%      -0.5%      20416 ±  2%  slabinfo.pde_opener.num_objs
    200.67 ±  2%      -2.1%     196.43 ±  2%      -0.5%     199.57 ±  2%  slabinfo.pde_opener.num_slabs
     18362            -0.2%      18321            +0.6%      18476        slabinfo.pid.active_objs
    286.17            -0.2%     285.57            +0.7%     288.14        slabinfo.pid.active_slabs
     18362            -0.2%      18321            +0.6%      18476        slabinfo.pid.num_objs
    286.17            -0.2%     285.57            +0.7%     288.14        slabinfo.pid.num_slabs
      3360 ±  5%      +2.6%       3446 ±  3%      +0.4%       3373 ±  5%  slabinfo.pool_workqueue.active_objs
     52.50 ±  4%      +3.4%      54.29 ±  4%      +1.2%      53.14 ±  5%  slabinfo.pool_workqueue.active_slabs
      3381 ±  4%      +3.5%       3500 ±  4%      +1.3%       3425 ±  5%  slabinfo.pool_workqueue.num_objs
     52.50 ±  4%      +3.4%      54.29 ±  4%      +1.2%      53.14 ±  5%  slabinfo.pool_workqueue.num_slabs
      1022 ±  4%      +8.0%       1104 ±  5%      +7.4%       1098 ±  6%  slabinfo.proc_dir_entry.active_objs
     24.33 ±  4%      +8.0%      26.29 ±  5%      +7.4%      26.14 ±  6%  slabinfo.proc_dir_entry.active_slabs
      1022 ±  4%      +8.0%       1104 ±  5%      +7.4%       1098 ±  6%  slabinfo.proc_dir_entry.num_objs
     24.33 ±  4%      +8.0%      26.29 ±  5%      +7.4%      26.14 ±  6%  slabinfo.proc_dir_entry.num_slabs
     30217            -0.6%      30022            -0.1%      30199        slabinfo.proc_inode_cache.active_objs
    629.00            -0.6%     625.00            -0.1%     628.57        slabinfo.proc_inode_cache.active_slabs
     30221            -0.6%      30026            -0.1%      30201        slabinfo.proc_inode_cache.num_objs
    629.00            -0.6%     625.00            -0.1%     628.57        slabinfo.proc_inode_cache.num_slabs
     25478            -0.2%      25419            -0.5%      25362        slabinfo.radix_tree_node.active_objs
    454.67            -0.3%     453.43            -0.5%     452.43        slabinfo.radix_tree_node.active_slabs
     25478            -0.2%      25419            -0.5%      25362        slabinfo.radix_tree_node.num_objs
    454.67            -0.3%     453.43            -0.5%     452.43        slabinfo.radix_tree_node.num_slabs
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
     11297            +0.4%      11341 ±  3%      -1.0%      11189 ±  2%  slabinfo.shmem_inode_cache.active_objs
    245.00            +0.4%     246.00 ±  2%      -0.9%     242.71 ±  2%  slabinfo.shmem_inode_cache.active_slabs
     11297            +0.4%      11341 ±  3%      -1.0%      11189 ±  2%  slabinfo.shmem_inode_cache.num_objs
    245.00            +0.4%     246.00 ±  2%      -0.9%     242.71 ±  2%  slabinfo.shmem_inode_cache.num_slabs
      5827            +0.7%       5869            +0.6%       5861        slabinfo.sighand_cache.active_objs
    387.83            +0.7%     390.71            +0.6%     390.29        slabinfo.sighand_cache.active_slabs
      5827            +0.7%       5869            +0.6%       5861        slabinfo.sighand_cache.num_objs
    387.83            +0.7%     390.71            +0.6%     390.29        slabinfo.sighand_cache.num_slabs
      9236            +0.0%       9238            +1.2%       9344        slabinfo.signal_cache.active_objs
    329.17            +0.1%     329.43            +1.2%     333.14        slabinfo.signal_cache.active_slabs
      9236            +0.0%       9238            +1.2%       9344        slabinfo.signal_cache.num_objs
    329.17            +0.1%     329.43            +1.2%     333.14        slabinfo.signal_cache.num_slabs
    682.67 ± 12%      +8.5%     740.57 ± 11%     +13.8%     777.14 ±  6%  slabinfo.skbuff_fclone_cache.active_objs
     10.67 ± 12%      +8.5%      11.57 ± 11%     +13.8%      12.14 ±  6%  slabinfo.skbuff_fclone_cache.active_slabs
    682.67 ± 12%      +8.5%     740.57 ± 11%     +13.8%     777.14 ±  6%  slabinfo.skbuff_fclone_cache.num_objs
     10.67 ± 12%      +8.5%      11.57 ± 11%     +13.8%      12.14 ±  6%  slabinfo.skbuff_fclone_cache.num_slabs
     18066 ±  2%      +0.4%      18146            +1.1%      18258        slabinfo.skbuff_head_cache.active_objs
    281.83 ±  2%      +0.6%     283.43            +1.2%     285.29        slabinfo.skbuff_head_cache.active_slabs
     18066 ±  2%      +0.4%      18146            +1.1%      18258        slabinfo.skbuff_head_cache.num_objs
    281.83 ±  2%      +0.6%     283.43            +1.2%     285.29        slabinfo.skbuff_head_cache.num_slabs
      5847 ±  2%      +0.6%       5883 ±  4%      -2.2%       5720 ±  5%  slabinfo.sock_inode_cache.active_objs
    149.50 ±  3%      +0.5%     150.29 ±  4%      -2.2%     146.29 ±  5%  slabinfo.sock_inode_cache.active_slabs
      5847 ±  2%      +0.6%       5883 ±  4%      -2.2%       5720 ±  5%  slabinfo.sock_inode_cache.num_objs
    149.50 ±  3%      +0.5%     150.29 ±  4%      -2.2%     146.29 ±  5%  slabinfo.sock_inode_cache.num_slabs
     15147            -0.4%      15081            +0.6%      15245        slabinfo.task_delay_info.active_objs
    296.33            -0.4%     295.14            +0.7%     298.43        slabinfo.task_delay_info.active_slabs
     15147            -0.4%      15081            +0.6%      15245        slabinfo.task_delay_info.num_objs
    296.33            -0.4%     295.14            +0.7%     298.43        slabinfo.task_delay_info.num_slabs
      1540 ±  4%      -0.4%       1534 ±  8%      -3.2%       1490 ±  6%  slabinfo.task_group.active_objs
     33.17 ±  5%      -0.9%      32.86 ±  8%      -3.5%      32.00 ±  6%  slabinfo.task_group.active_slabs
      1540 ±  4%      -0.4%       1534 ±  8%      -3.2%       1490 ±  6%  slabinfo.task_group.num_objs
     33.17 ±  5%      -0.9%      32.86 ±  8%      -3.5%      32.00 ±  6%  slabinfo.task_group.num_slabs
      2845            +0.2%       2849            +0.3%       2854        slabinfo.task_struct.active_objs
      2846            +0.1%       2850            +0.3%       2855        slabinfo.task_struct.active_slabs
      2846            +0.1%       2850            +0.3%       2855        slabinfo.task_struct.num_objs
      2846            +0.1%       2850            +0.3%       2855        slabinfo.task_struct.num_slabs
    148.00            +0.0%     148.00            -2.8%     143.86 ±  7%  slabinfo.taskstats.active_objs
      3.00            +0.0%       3.00            -4.8%       2.86 ± 12%  slabinfo.taskstats.active_slabs
    148.00            +0.0%     148.00            -2.8%     143.86 ±  7%  slabinfo.taskstats.num_objs
      3.00            +0.0%       3.00            -4.8%       2.86 ± 12%  slabinfo.taskstats.num_slabs
     10240 ±  4%      +6.4%      10894 ±  4%      +5.8%      10834 ±  3%  slabinfo.trace_event_file.active_objs
    222.17 ±  4%      +6.4%     236.43 ±  4%      +5.8%     235.00 ±  3%  slabinfo.trace_event_file.active_slabs
     10240 ±  4%      +6.4%      10894 ±  4%      +5.8%      10834 ±  3%  slabinfo.trace_event_file.num_objs
    222.17 ±  4%      +6.4%     236.43 ±  4%      +5.8%     235.00 ±  3%  slabinfo.trace_event_file.num_slabs
     66.00            +0.0%      66.00            +0.0%      66.00        slabinfo.tw_sock_TCP.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.active_slabs
     66.00            +0.0%      66.00            +0.0%      66.00        slabinfo.tw_sock_TCP.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.num_slabs
     99306            -0.3%      99012 ±  2%      +1.3%     100613 ±  4%  slabinfo.vm_area_struct.active_objs
      2483            -0.3%       2475 ±  2%      +1.3%       2515 ±  4%  slabinfo.vm_area_struct.active_slabs
     99347            -0.3%      99039 ±  2%      +1.3%     100643 ±  4%  slabinfo.vm_area_struct.num_objs
      2483            -0.3%       2475 ±  2%      +1.3%       2515 ±  4%  slabinfo.vm_area_struct.num_slabs
     22454            -0.3%      22376            +0.0%      22456        slabinfo.vmap_area.active_objs
    355.50            -0.4%     354.00            -0.2%     354.86        slabinfo.vmap_area.active_slabs
     22765            -0.4%      22678            -0.2%      22730        slabinfo.vmap_area.num_objs
    355.50            -0.4%     354.00            -0.2%     354.86        slabinfo.vmap_area.num_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.xfrm_state.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfrm_state.active_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.xfrm_state.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfrm_state.num_slabs
     75.96 ±  2%      -1.3       74.69            -0.4       75.60        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     74.77 ±  2%      -1.2       73.54            -0.5       74.29        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      7.33 ±  7%      -0.8        6.51 ± 17%      -0.1        7.27 ± 10%  perf-profile.calltrace.cycles-pp.rcu_eqs_exit.rcu_idle_exit.cpuidle_enter_state.cpuidle_enter.do_idle
      7.60 ±  6%      -0.8        6.78 ± 16%      -0.1        7.55 ± 10%  perf-profile.calltrace.cycles-pp.rcu_idle_exit.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     51.51 ±  2%      -0.7       50.83            -0.0       51.47 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     13.18 ±  2%      -0.5       12.70 ±  6%      -0.2       12.94 ±  6%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     47.26 ±  3%      -0.4       46.84 ±  2%      -0.2       47.10 ±  4%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      3.24 ±  8%      -0.3        2.93 ± 19%      -0.1        3.13 ± 14%  perf-profile.calltrace.cycles-pp.rcu_nmi_enter.irqentry_enter.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.41 ±  7%      -0.3        3.14 ± 18%      -0.1        3.31 ± 13%  perf-profile.calltrace.cycles-pp.irqentry_enter.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
     31.50 ±  3%      -0.3       31.24 ±  4%      +0.4       31.92 ±  7%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      3.43 ±  6%      -0.2        3.20 ±  7%      -0.3        3.10 ±  7%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      3.11 ±  6%      -0.2        2.87 ±  8%      -0.3        2.81 ±  8%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      9.81 ±  6%      -0.2        9.61 ±  3%      -0.0        9.79 ±  2%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
     10.32 ±  5%      -0.2       10.13 ±  2%      +0.0       10.33 ±  2%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.19 ±141%      -0.2        0.00            -0.0        0.17 ±158%  perf-profile.calltrace.cycles-pp.timekeeping_max_deferment.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle
      1.36 ± 14%      -0.2        1.18 ±  7%      -0.2        1.14 ± 15%  perf-profile.calltrace.cycles-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.18 ±141%      -0.2        0.00            -0.0        0.15 ±158%  perf-profile.calltrace.cycles-pp.rcu_eqs_enter.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.17 ±141%      -0.2        0.00            -0.1        0.07 ±244%  perf-profile.calltrace.cycles-pp.iov_iter_copy_from_user_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      1.16 ± 19%      -0.2        0.99 ± 11%      -0.2        0.97 ± 20%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.17 ±141%      -0.2        0.00            +0.0        0.18 ±162%  perf-profile.calltrace.cycles-pp.irqtime_account_process_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
     30.02 ±  3%      -0.2       29.86 ±  4%      +0.5       30.48 ±  7%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
     11.85 ±  7%      -0.2       11.70 ±  2%      -0.0       11.84 ±  2%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.60 ±  6%      -0.1        0.48 ± 41%      +0.0        0.63 ± 14%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      3.06 ±  5%      -0.1        2.93 ± 18%      -0.1        2.98 ± 20%  perf-profile.calltrace.cycles-pp.rcu_sched_clock_irq.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.29 ±100%      -0.1        0.17 ±158%      -0.1        0.18 ±159%  perf-profile.calltrace.cycles-pp.pagecache_get_page.shmem_getpage_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter
      0.76 ± 17%      -0.1        0.66 ± 42%      -0.1        0.70 ± 44%  perf-profile.calltrace.cycles-pp.irqentry_exit.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.56 ±  6%      -0.1        0.46 ± 40%      -0.1        0.48 ± 41%  perf-profile.calltrace.cycles-pp.arch_cpu_idle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.59 ±  4%      -0.1        0.49 ± 41%      -0.0        0.58 ±  7%  perf-profile.calltrace.cycles-pp.update_ts_time_stats.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      3.92 ± 29%      -0.1        3.83 ± 21%      -0.4        3.48 ± 26%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      4.17 ± 29%      -0.1        4.07 ± 21%      -0.5        3.70 ± 26%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      5.19 ± 29%      -0.1        5.09 ± 22%      -0.6        4.63 ± 26%  perf-profile.calltrace.cycles-pp.write
      4.41 ±  8%      -0.1        4.32 ±  4%      +0.1        4.48 ±  7%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      4.05 ± 29%      -0.1        3.96 ± 21%      -0.5        3.60 ± 26%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.80 ± 26%      -0.1        0.71 ± 16%      -0.1        0.71 ± 11%  perf-profile.calltrace.cycles-pp.ktime_get.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      4.35 ± 29%      -0.1        4.28 ± 21%      -0.5        3.88 ± 26%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      1.47 ±  5%      -0.1        1.40 ±  8%      -0.1        1.41 ±  6%  perf-profile.calltrace.cycles-pp.hrtimer_next_event_without.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.89 ±  7%      -0.1        0.82 ± 12%      -0.0        0.86 ±  8%  perf-profile.calltrace.cycles-pp.__hrtimer_next_event_base.hrtimer_next_event_without.tick_nohz_get_sleep_length.menu_select.do_idle
      2.78 ± 29%      -0.1        2.71 ± 21%      -0.4        2.41 ± 26%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.new_sync_write.vfs_write.ksys_write
      1.40 ± 29%      -0.1        1.34 ± 23%      -0.2        1.24 ± 28%  perf-profile.calltrace.cycles-pp.shmem_getpage_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      2.63 ± 15%      -0.1        2.57 ±  6%      -0.2        2.39 ± 12%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      3.23 ± 28%      -0.1        3.17 ± 20%      -0.4        2.86 ± 26%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.44 ± 29%      -0.1        1.39 ± 23%      -0.2        1.29 ± 27%  perf-profile.calltrace.cycles-pp.shmem_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      0.36 ± 70%      -0.0        0.31 ± 86%      +0.0        0.39 ± 63%  perf-profile.calltrace.cycles-pp.native_apic_msr_eoi_write.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.95 ±  7%      -0.0        0.90 ± 16%      +0.0        0.98 ± 17%  perf-profile.calltrace.cycles-pp.rcu_dynticks_eqs_exit.rcu_eqs_exit.rcu_idle_exit.cpuidle_enter_state.cpuidle_enter
      3.08 ± 29%      -0.0        3.04 ± 21%      -0.4        2.72 ± 26%  perf-profile.calltrace.cycles-pp.generic_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
      2.52 ± 29%      -0.0        2.48 ± 21%      -0.3        2.22 ± 26%  perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write.vfs_write
      0.21 ±141%      -0.0        0.18 ±158%      +0.1        0.26 ±116%  perf-profile.calltrace.cycles-pp.process_simple.perf_session__process_events.record__finish_output.cmd_record.cmd_sched
      0.80 ±  4%      -0.0        0.77 ±  7%      -0.0        0.78 ±  7%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.59 ± 47%      -0.0        0.57 ± 42%      +0.0        0.62 ± 45%  perf-profile.calltrace.cycles-pp.rcu_nmi_exit.irqentry_exit.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.50 ± 27%      -0.0        1.48 ± 11%      -0.2        1.32 ± 18%  perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.22 ±141%      -0.0        0.20 ±158%      +0.1        0.28 ±116%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.cmd_record.cmd_sched.run_builtin
      1.15 ± 12%      -0.0        1.13 ±  4%      -0.0        1.11 ± 13%  perf-profile.calltrace.cycles-pp.irqtime_account_irq.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.22 ±141%      -0.0        0.20 ±158%      +0.1        0.28 ±116%  perf-profile.calltrace.cycles-pp.record__finish_output.cmd_record.cmd_sched.run_builtin.main
      0.78            -0.0        0.78 ±  5%      +0.1        0.88 ± 17%  perf-profile.calltrace.cycles-pp.update_irq_load_avg.update_rq_clock.scheduler_tick.update_process_times.tick_sched_handle
      0.94 ± 75%      -0.0        0.94 ± 31%      +0.2        1.16 ± 26%  perf-profile.calltrace.cycles-pp.x86_pmu_disable.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.84 ± 13%      -0.0        0.84 ± 10%      -0.1        0.73 ± 42%  perf-profile.calltrace.cycles-pp._raw_spin_lock.get_next_timer_interrupt.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select
      0.00            +0.0        0.00            +0.1        0.08 ±244%  perf-profile.calltrace.cycles-pp.run_posix_cpu_timers.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.0        0.00            +0.1        0.09 ±244%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.0        0.00            +0.1        0.09 ±244%  perf-profile.calltrace.cycles-pp._raw_spin_lock.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.0        0.00            +0.1        0.10 ±244%  perf-profile.calltrace.cycles-pp.rb_insert_color.timerqueue_add.enqueue_hrtimer.__hrtimer_run_queues.hrtimer_interrupt
      0.98 ±  4%      +0.0        0.98 ±  5%      -0.0        0.96 ±  5%  perf-profile.calltrace.cycles-pp.hrtimer_update_next_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.80 ±  5%      +0.0        0.80 ± 15%      -0.1        0.67 ± 41%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.27 ±  5%      +0.0        1.28 ±  5%      +0.1        1.37 ± 18%  perf-profile.calltrace.cycles-pp.__remove_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.72 ± 25%      +0.0        0.73 ± 30%      +0.0        0.76 ± 27%  perf-profile.calltrace.cycles-pp.cmd_record.cmd_sched.run_builtin.main.__libc_start_main
      0.72 ± 25%      +0.0        0.73 ± 30%      +0.0        0.76 ± 27%  perf-profile.calltrace.cycles-pp.cmd_sched.run_builtin.main.__libc_start_main
      0.91 ±  4%      +0.0        0.92 ±  6%      +0.1        0.99 ± 22%  perf-profile.calltrace.cycles-pp.timerqueue_del.__remove_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.71 ± 15%      +0.0        0.73 ±  7%      -0.1        0.60 ± 44%  perf-profile.calltrace.cycles-pp.sched_clock_cpu.irqtime_account_irq.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.59 ±  6%      +0.0        1.61 ±  6%      +0.1        1.73 ± 14%  perf-profile.calltrace.cycles-pp.update_rq_clock.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      1.91 ±  7%      +0.0        1.93 ±  3%      -0.1        1.83 ± 12%  perf-profile.calltrace.cycles-pp.get_next_timer_interrupt.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle
      0.95 ± 17%      +0.0        0.97 ± 24%      +0.1        1.04 ± 22%  perf-profile.calltrace.cycles-pp.__libc_start_main
      0.95 ± 17%      +0.0        0.97 ± 24%      +0.1        1.04 ± 22%  perf-profile.calltrace.cycles-pp.main.__libc_start_main
      0.95 ± 17%      +0.0        0.97 ± 24%      +0.1        1.04 ± 22%  perf-profile.calltrace.cycles-pp.run_builtin.main.__libc_start_main
      1.20 ± 10%      +0.0        1.22 ±  7%      -0.1        1.14 ± 18%  perf-profile.calltrace.cycles-pp.irqtime_account_irq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      5.73 ±  4%      +0.0        5.76 ±  2%      -0.2        5.54 ±  8%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.60 ±  5%      +0.0        0.64 ± 10%      +0.1        0.70 ± 24%  perf-profile.calltrace.cycles-pp.update_blocked_averages.run_rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.71 ±  5%      +0.0        0.75 ± 10%      +0.1        0.82 ± 22%  perf-profile.calltrace.cycles-pp.run_rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.59 ± 11%      +0.0        0.63 ± 10%      +0.1        0.69 ±  9%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.59 ± 11%      +0.0        0.63 ± 10%      +0.1        0.69 ±  9%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.34 ±100%      +0.0        0.38 ± 88%      -0.1        0.23 ±158%  perf-profile.calltrace.cycles-pp.llseek
      0.88 ±  6%      +0.1        0.93 ±  7%      +0.1        0.94 ± 22%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__softirqentry_text_start.irq_exit_rcu
      0.80 ±  7%      +0.1        0.87 ±  7%      +0.1        0.86 ± 21%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains.__softirqentry_text_start
      0.61 ±  7%      +0.1        0.68 ±  4%      +0.0        0.63 ±  7%  perf-profile.calltrace.cycles-pp.hrtimer_get_next_event.get_next_timer_interrupt.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select
     22.38 ±  2%      +0.1       22.45 ±  4%      +1.1       23.45 ± 12%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.88 ±  7%      +0.1        0.95 ±  7%      +0.3        1.15 ± 51%  perf-profile.calltrace.cycles-pp.timerqueue_add.enqueue_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.1        0.07 ±244%      +0.0        0.00        perf-profile.calltrace.cycles-pp.native_sched_clock.sched_clock.sched_clock_cpu.update_rq_clock.scheduler_tick
      1.07 ±  6%      +0.1        1.15 ±  7%      +0.3        1.36 ± 46%  perf-profile.calltrace.cycles-pp.enqueue_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.1        0.08 ±244%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__hrtimer_get_next_event.hrtimer_update_next_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      4.71 ±  7%      +0.1        4.79 ±  7%      +0.7        5.45 ± 24%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.1        0.08 ±244%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sched_clock_cpu.update_rq_clock.scheduler_tick.update_process_times.tick_sched_handle
      1.50 ±  5%      +0.1        1.58 ±  7%      +0.1        1.61 ± 22%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.22 ±  5%      +0.1        1.30 ±  7%      +0.1        1.29 ± 22%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt
      1.04 ± 11%      +0.1        1.13 ±  7%      -0.1        0.96 ± 10%  perf-profile.calltrace.cycles-pp.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
     90.32 ±  2%      +0.1       90.41            +0.4       90.72        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     90.07 ±  2%      +0.1       90.16            +0.3       90.41        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     90.07 ±  2%      +0.1       90.16            +0.3       90.41        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      0.51 ± 46%      +0.1        0.61 ± 15%      -0.2        0.28 ±116%  perf-profile.calltrace.cycles-pp.sched_clock.sched_clock_cpu.irqtime_account_irq.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.54 ± 46%      +0.1        0.64 ±  8%      -0.0        0.52 ± 44%  perf-profile.calltrace.cycles-pp.native_sched_clock.sched_clock.sched_clock_cpu.irqtime_account_irq.sysvec_apic_timer_interrupt
      0.72 ±  8%      +0.1        0.82 ±  5%      +0.1        0.77 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_governor_latency_req.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.1        0.11 ±244%      +0.2        0.19 ±244%  perf-profile.calltrace.cycles-pp.ktime_get.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.52 ± 46%      +0.1        0.62 ±  8%      -0.1        0.43 ± 65%  perf-profile.calltrace.cycles-pp.sched_clock.sched_clock_cpu.irqtime_account_irq.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.11 ±244%      +0.0        0.00        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.poll_idle
      0.53 ± 46%      +0.1        0.64 ± 14%      -0.1        0.45 ± 65%  perf-profile.calltrace.cycles-pp.native_sched_clock.sched_clock.sched_clock_cpu.irqtime_account_irq.irq_exit_rcu
     89.91 ±  2%      +0.1       90.02            +0.4       90.26        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +0.1        0.11 ±244%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state
      0.00            +0.1        0.11 ±244%      +0.0        0.00        perf-profile.calltrace.cycles-pp._raw_spin_unlock_irqrestore.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.81 ± 12%      +0.1        0.92 ±  9%      -0.0        0.76 ± 12%  perf-profile.calltrace.cycles-pp.ktime_get.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +0.1        0.11 ±244%      +0.0        0.00        perf-profile.calltrace.cycles-pp._raw_spin_unlock_irqrestore.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.60 ± 45%      +0.1        0.74 ± 12%      -0.0        0.58 ± 44%  perf-profile.calltrace.cycles-pp.sched_clock_cpu.irqtime_account_irq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      3.56 ±  4%      +0.1        3.70 ±  2%      -0.1        3.48 ± 11%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.52 ± 45%      +0.2        0.67 ± 24%      +0.0        0.52 ± 42%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.55 ± 16%      +0.2        1.73 ± 18%      +0.1        1.63 ± 16%  perf-profile.calltrace.cycles-pp.native_sched_clock.sched_clock.sched_clock_cpu.cpuidle_enter_state.cpuidle_enter
      1.46 ± 17%      +0.2        1.65 ± 19%      +0.1        1.55 ± 17%  perf-profile.calltrace.cycles-pp.sched_clock.sched_clock_cpu.cpuidle_enter_state.cpuidle_enter.do_idle
      1.77 ± 15%      +0.2        1.96 ± 16%      +0.1        1.85 ± 14%  perf-profile.calltrace.cycles-pp.sched_clock_cpu.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +0.2        0.19 ±244%      +0.0        0.00        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state.cpuidle_enter
      0.00            +0.2        0.19 ±244%      +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle
      3.40 ±  5%      +0.2        3.63 ±  7%      +0.2        3.62 ± 17%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.27 ±100%      +0.3        0.53 ± 40%      -0.1        0.15 ±158%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      5.83 ±  6%      +0.3        6.11 ±  5%      +0.0        5.85 ±  7%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.09 ±223%      +0.5        0.59 ±  5%      +0.1        0.15 ±158%  perf-profile.calltrace.cycles-pp.tick_check_broadcast_expired.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +0.6        0.55 ±244%      +0.0        0.00        perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     10.31 ±  6%      +1.3       11.58 ±  6%      +0.7       11.01 ± 13%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     75.92 ±  2%      -1.3       74.62            -0.3       75.60 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
     76.17 ±  2%      -1.3       74.88            -0.3       75.87 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
      7.63 ±  6%      -0.8        6.81 ± 16%      -0.1        7.58 ± 10%  perf-profile.children.cycles-pp.rcu_idle_exit
      7.37 ±  7%      -0.8        6.55 ± 17%      -0.1        7.31 ± 10%  perf-profile.children.cycles-pp.rcu_eqs_exit
     13.26 ±  2%      -0.5       12.78 ±  6%      -0.2       13.03 ±  6%  perf-profile.children.cycles-pp.intel_idle
     51.05 ±  2%      -0.3       50.72 ±  2%      -0.2       50.90 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      3.25 ±  8%      -0.3        2.94 ± 19%      -0.1        3.14 ± 14%  perf-profile.children.cycles-pp.rcu_nmi_enter
      3.45 ±  7%      -0.3        3.19 ± 18%      -0.1        3.34 ± 13%  perf-profile.children.cycles-pp.irqentry_enter
      3.50 ±  5%      -0.2        3.28 ±  7%      -0.3        3.18 ±  7%  perf-profile.children.cycles-pp.irq_enter_rcu
      3.17 ±  6%      -0.2        2.95 ±  7%      -0.3        2.88 ±  8%  perf-profile.children.cycles-pp.tick_irq_enter
     48.27 ±  2%      -0.2       48.06 ±  2%      -0.2       48.03 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.20 ± 18%      -0.2        1.03 ± 12%      -0.2        1.01 ± 19%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      1.09 ± 49%      -0.1        0.96 ± 30%      +0.1        1.17 ± 26%  perf-profile.children.cycles-pp.x86_pmu_disable
     10.31 ±  5%      -0.1       10.18 ±  2%      -0.1       10.26        perf-profile.children.cycles-pp.update_process_times
     10.81 ±  5%      -0.1       10.69 ±  2%      -0.0       10.79 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
      5.32 ± 29%      -0.1        5.20 ± 22%      -0.6        4.73 ± 26%  perf-profile.children.cycles-pp.write
     32.22 ±  2%      -0.1       32.11 ±  5%      +0.4       32.59 ±  7%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      3.96 ± 29%      -0.1        3.86 ± 21%      -0.4        3.52 ± 26%  perf-profile.children.cycles-pp.vfs_write
      3.11 ±  5%      -0.1        3.02 ± 16%      -0.1        3.03 ± 19%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
     12.40 ±  6%      -0.1       12.31 ±  2%      -0.1       12.34 ±  2%  perf-profile.children.cycles-pp.tick_sched_timer
      4.09 ± 29%      -0.1        4.00 ± 21%      -0.5        3.64 ± 26%  perf-profile.children.cycles-pp.ksys_write
      1.52 ±  5%      -0.1        1.44 ±  8%      -0.1        1.46 ±  6%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      4.85 ±  7%      -0.1        4.78 ±  5%      +0.0        4.90 ±  8%  perf-profile.children.cycles-pp.scheduler_tick
      2.81 ± 29%      -0.1        2.74 ± 21%      -0.4        2.45 ± 25%  perf-profile.children.cycles-pp.__generic_file_write_iter
      4.84 ± 12%      -0.1        4.77 ±  9%      -0.4        4.47 ±  6%  perf-profile.children.cycles-pp.ktime_get
      5.75 ± 23%      -0.1        5.68 ± 13%      -0.3        5.45 ± 21%  perf-profile.children.cycles-pp.do_syscall_64
      6.43 ± 23%      -0.1        6.36 ± 14%      -0.3        6.09 ± 21%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.43 ± 29%      -0.1        1.37 ± 23%      -0.2        1.28 ± 27%  perf-profile.children.cycles-pp.shmem_getpage_gfp
      1.42 ±  3%      -0.1        1.36 ±  5%      -0.0        1.38 ±  5%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      1.33 ±  5%      -0.1        1.27 ±  4%      -0.1        1.26 ±  3%  perf-profile.children.cycles-pp.read_tsc
      3.26 ± 28%      -0.1        3.21 ± 20%      -0.4        2.90 ± 25%  perf-profile.children.cycles-pp.new_sync_write
      1.46 ± 29%      -0.1        1.41 ± 23%      -0.2        1.30 ± 27%  perf-profile.children.cycles-pp.shmem_write_begin
      0.67 ± 19%      -0.1        0.62 ± 22%      -0.0        0.67 ± 28%  perf-profile.children.cycles-pp.rcu_nmi_exit
      0.98 ±  7%      -0.1        0.92 ± 16%      +0.0        1.00 ± 17%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_exit
      0.61 ±  6%      -0.1        0.56 ±  7%      +0.0        0.64 ± 14%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.49 ±  9%      -0.0        0.44 ±  5%      -0.0        0.48 ± 10%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.79 ± 17%      -0.0        0.75 ± 19%      -0.0        0.79 ± 26%  perf-profile.children.cycles-pp.irqentry_exit
      0.56 ±  3%      -0.0        0.52 ±  9%      -0.0        0.53 ±  8%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.44 ± 32%      -0.0        0.39 ± 36%      +0.0        0.45 ± 34%  perf-profile.children.cycles-pp.process_simple
      2.70 ± 15%      -0.0        2.65 ±  6%      -0.3        2.44 ± 12%  perf-profile.children.cycles-pp.clockevents_program_event
      0.74 ±  9%      -0.0        0.70 ± 10%      -0.1        0.65 ± 14%  perf-profile.children.cycles-pp.rb_next
      2.56 ± 29%      -0.0        2.52 ± 20%      -0.3        2.26 ± 26%  perf-profile.children.cycles-pp.generic_perform_write
      3.12 ± 29%      -0.0        3.08 ± 21%      -0.4        2.76 ± 26%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.58 ±  5%      -0.0        0.54 ±  9%      -0.0        0.57 ±  5%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.05 ± 83%      -0.0        0.02 ±159%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.find_lock_entries
      0.18 ± 40%      -0.0        0.14 ± 36%      -0.0        0.18 ± 36%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.33 ±  9%      -0.0        0.29 ± 17%      -0.0        0.31 ± 23%  perf-profile.children.cycles-pp.rcu_needs_cpu
      0.52 ±  7%      -0.0        0.48 ±  4%      -0.0        0.47 ±  6%  perf-profile.children.cycles-pp.idle_cpu
      0.46 ±  4%      -0.0        0.43 ±  9%      -0.0        0.43 ±  6%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.31 ± 28%      -0.0        0.28 ± 21%      -0.0        0.27 ± 25%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.67 ±  4%      -0.0        0.64 ±  3%      -0.0        0.65 ±  5%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.25 ± 30%      -0.0        0.22 ± 20%      -0.0        0.22 ± 23%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.25 ±  5%      -0.0        0.22 ± 13%      -0.0        0.22 ±  9%  perf-profile.children.cycles-pp.irq_work_needs_cpu
      0.03 ±100%      -0.0        0.00            -0.0        0.01 ±158%  perf-profile.children.cycles-pp.rw_verify_area
      0.27 ± 28%      -0.0        0.24 ± 25%      -0.0        0.24 ± 24%  perf-profile.children.cycles-pp.copyin
      0.18 ± 30%      -0.0        0.15 ± 28%      -0.0        0.14 ± 31%  perf-profile.children.cycles-pp.common_file_perm
      0.31 ± 28%      -0.0        0.29 ± 22%      -0.1        0.25 ± 31%  perf-profile.children.cycles-pp.sync_disk_rw
      0.06 ± 87%      -0.0        0.03 ± 87%      -0.0        0.03 ± 89%  perf-profile.children.cycles-pp.aa_file_perm
      0.61 ±  4%      -0.0        0.58 ±  9%      -0.0        0.59 ±  7%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.91 ±  3%      -0.0        0.88 ±  3%      -0.0        0.89 ±  4%  perf-profile.children.cycles-pp.__x86_retpoline_rax
      0.83 ±  4%      -0.0        0.81 ±  5%      -0.0        0.81 ±  7%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.35 ± 10%      -0.0        0.33 ± 10%      +0.1        0.40 ± 26%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
     30.79 ±  2%      -0.0       30.77 ±  5%      +0.4       31.20 ±  7%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.48 ± 27%      -0.0        0.46 ± 26%      -0.0        0.44 ± 32%  perf-profile.children.cycles-pp.pagecache_get_page
      0.07 ±  5%      -0.0        0.05 ± 41%      -0.0        0.05 ± 41%  perf-profile.children.cycles-pp.timerqueue_iterate_next
      0.37 ± 28%      -0.0        0.35 ± 24%      -0.0        0.33 ± 26%  perf-profile.children.cycles-pp.__entry_text_start
      0.58 ±  6%      -0.0        0.56 ±  9%      -0.0        0.58 ±  7%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.06 ± 35%      -0.0        0.04 ± 98%      -0.0        0.05 ± 94%  perf-profile.children.cycles-pp.map__process_kallsym_symbol
      0.14 ± 22%      -0.0        0.12 ± 24%      -0.0        0.13 ± 35%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.28 ± 11%      -0.0        0.25 ± 18%      -0.0        0.26 ± 18%  perf-profile.children.cycles-pp.note_gp_changes
      0.02 ±141%      -0.0        0.00            -0.0        0.01 ±244%  perf-profile.children.cycles-pp.delay_tsc
      0.08 ± 31%      -0.0        0.06 ± 71%      -0.0        0.06 ± 20%  perf-profile.children.cycles-pp.current_time
      0.33 ± 23%      -0.0        0.31 ± 27%      -0.0        0.29 ± 23%  perf-profile.children.cycles-pp.dput
      0.30 ± 24%      -0.0        0.28 ± 29%      -0.0        0.26 ± 24%  perf-profile.children.cycles-pp.shmem_undo_range
      0.40 ± 21%      -0.0        0.38 ± 23%      -0.0        0.36 ± 22%  perf-profile.children.cycles-pp.__close
      0.21 ± 13%      -0.0        0.19 ± 12%      -0.0        0.20 ±  6%  perf-profile.children.cycles-pp.sched_idle_set_state
      0.25 ±  8%      -0.0        0.23 ±  9%      -0.0        0.23 ± 16%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.16 ± 31%      -0.0        0.14 ± 33%      -0.0        0.13 ± 30%  perf-profile.children.cycles-pp.xas_load
      0.39 ± 19%      -0.0        0.37 ± 23%      -0.0        0.35 ± 22%  perf-profile.children.cycles-pp.__fput
      0.02 ±141%      -0.0        0.00            +0.0        0.02 ±161%  perf-profile.children.cycles-pp.unmap_page_range
      0.02 ±141%      -0.0        0.00            +0.0        0.02 ±161%  perf-profile.children.cycles-pp.perf_read
      0.50 ±  5%      -0.0        0.48 ±  7%      +0.0        0.51 ± 21%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.17 ± 10%      -0.0        0.15 ±  6%      -0.0        0.16 ± 13%  perf-profile.children.cycles-pp.handle_mm_fault
      0.46 ± 29%      -0.0        0.45 ± 36%      +0.0        0.48 ± 32%  perf-profile.children.cycles-pp.perf_session__process_events
      0.15 ± 10%      -0.0        0.14 ±  9%      -0.0        0.15 ± 12%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.31 ± 24%      -0.0        0.29 ± 28%      -0.0        0.26 ± 25%  perf-profile.children.cycles-pp.evict
      0.41 ± 18%      -0.0        0.39 ± 22%      -0.0        0.37 ± 23%  perf-profile.children.cycles-pp.task_work_run
      0.12 ± 31%      -0.0        0.11 ± 25%      -0.0        0.10 ± 21%  perf-profile.children.cycles-pp.file_update_time
      0.30 ± 24%      -0.0        0.29 ± 30%      -0.0        0.26 ± 24%  perf-profile.children.cycles-pp.shmem_truncate_range
      0.30 ± 24%      -0.0        0.29 ± 30%      -0.0        0.26 ± 25%  perf-profile.children.cycles-pp.shmem_evict_inode
      0.19 ± 31%      -0.0        0.18 ± 35%      +0.0        0.20 ± 27%  perf-profile.children.cycles-pp.seq_read
      0.12 ± 15%      -0.0        0.11 ±  4%      -0.0        0.12 ± 11%  perf-profile.children.cycles-pp.local_touch_nmi
      0.22 ±  7%      -0.0        0.20 ±  7%      -0.0        0.21 ± 14%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.31 ± 28%      -0.0        0.29 ± 36%      +0.0        0.32 ± 32%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.04 ± 71%      -0.0        0.02 ±115%      +0.0        0.04 ± 65%  perf-profile.children.cycles-pp.filemap_map_pages
      0.46 ± 29%      -0.0        0.45 ± 37%      +0.0        0.48 ± 32%  perf-profile.children.cycles-pp.record__finish_output
      0.11 ± 22%      -0.0        0.10 ± 24%      -0.0        0.11 ± 31%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.05 ± 46%      -0.0        0.04 ± 88%      -0.0        0.04 ± 93%  perf-profile.children.cycles-pp.perf_callchain_user
      0.54 ±  9%      -0.0        0.53 ± 11%      +0.0        0.58 ± 15%  perf-profile.children.cycles-pp.__schedule
      0.09 ± 54%      -0.0        0.08 ± 20%      -0.0        0.08 ± 28%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.02 ±144%      -0.0        0.01 ±244%      +0.0        0.03 ± 94%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rbx
      0.03 ±100%      -0.0        0.02 ±159%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.proc_single_show
      0.03 ±100%      -0.0        0.02 ±159%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.proc_pid_status
      0.23 ±  7%      -0.0        0.21 ±  7%      -0.0        0.22 ± 16%  perf-profile.children.cycles-pp.exc_page_fault
      0.04 ± 71%      -0.0        0.02 ±116%      +0.0        0.04 ± 65%  perf-profile.children.cycles-pp.copy_process
      0.32 ± 23%      -0.0        0.31 ± 26%      -0.0        0.28 ± 23%  perf-profile.children.cycles-pp.__dentry_kill
      0.40 ± 27%      -0.0        0.39 ± 25%      -0.0        0.37 ± 25%  perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      0.02 ±142%      -0.0        0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.02 ±142%      -0.0        0.01 ±244%      -0.0        0.02 ±161%  perf-profile.children.cycles-pp.__open64_nocancel
      0.07 ± 14%      -0.0        0.06 ± 18%      -0.0        0.04 ± 67%  perf-profile.children.cycles-pp.setlocale
      0.13 ±  9%      -0.0        0.12 ±  9%      +0.0        0.14 ± 10%  perf-profile.children.cycles-pp.restore_regs_and_return_to_kernel
      0.19 ± 10%      -0.0        0.18 ± 17%      -0.0        0.19 ± 16%  perf-profile.children.cycles-pp.rcu_is_cpu_rrupt_from_idle
      0.08 ± 19%      -0.0        0.07 ± 13%      +0.0        0.09 ± 37%  perf-profile.children.cycles-pp.__x86_retpoline_rbx
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±244%  perf-profile.children.cycles-pp.account_system_index_time
      0.10 ± 25%      -0.0        0.09 ± 30%      +0.0        0.10 ± 25%  perf-profile.children.cycles-pp.path_lookupat
      0.02 ±141%      -0.0        0.01 ±244%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.xas_create_range
      0.02 ±141%      -0.0        0.01 ±244%      +0.0        0.02 ±158%  perf-profile.children.cycles-pp.unmap_vmas
      0.25 ± 30%      -0.0        0.24 ± 21%      -0.0        0.20 ± 34%  perf-profile.children.cycles-pp.shmem_alloc_page
      0.28 ± 27%      -0.0        0.28 ± 35%      +0.0        0.30 ± 32%  perf-profile.children.cycles-pp.machines__deliver_event
      0.53            -0.0        0.52 ±  6%      -0.0        0.52 ±  6%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.07 ± 16%      -0.0        0.06 ± 14%      -0.0        0.07 ± 15%  perf-profile.children.cycles-pp.do_fault
      0.17 ±  7%      -0.0        0.16 ± 13%      +0.0        0.18 ± 25%  perf-profile.children.cycles-pp._find_next_bit
      0.04 ± 72%      -0.0        0.03 ± 87%      +0.0        0.05 ± 43%  perf-profile.children.cycles-pp.step_into
      0.31 ± 32%      -0.0        0.30 ± 25%      -0.0        0.28 ± 27%  perf-profile.children.cycles-pp.security_file_permission
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.timekeeping_advance
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.lru_add_drain
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.children.cycles-pp.__vm_enough_memory
      0.02 ±141%      -0.0        0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.timestamp_truncate
      0.02 ±141%      -0.0        0.01 ±244%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.10 ±  9%      -0.0        0.09 ± 22%      -0.0        0.09 ± 15%  perf-profile.children.cycles-pp.arch_cpu_idle_exit
      0.12 ± 22%      -0.0        0.12 ± 22%      +0.0        0.14 ± 25%  perf-profile.children.cycles-pp.walk_component
      0.04 ± 71%      -0.0        0.03 ±116%      +0.0        0.06 ± 20%  perf-profile.children.cycles-pp.perf_pmu_disable
      0.07 ± 14%      -0.0        0.06 ± 12%      +0.0        0.08 ± 30%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.09 ± 14%      -0.0        0.09 ± 14%      -0.0        0.09 ± 22%  perf-profile.children.cycles-pp.hrtimer_run_queues
      0.11 ± 15%      -0.0        0.11 ± 13%      +0.0        0.12 ± 19%  perf-profile.children.cycles-pp.schedule_idle
      0.14 ± 12%      -0.0        0.13 ± 11%      +0.0        0.16 ± 23%  perf-profile.children.cycles-pp.do_execveat_common
      0.14 ± 12%      -0.0        0.13 ± 11%      +0.0        0.16 ± 21%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.10 ± 25%      -0.0        0.09 ± 27%      +0.0        0.10 ± 28%  perf-profile.children.cycles-pp.filename_lookup
      0.24 ±  7%      -0.0        0.23 ± 15%      +0.0        0.25 ± 15%  perf-profile.children.cycles-pp.balance_fair
      0.20 ±  9%      -0.0        0.19 ±  9%      +0.0        0.22 ± 13%  perf-profile.children.cycles-pp.rcu_segcblist_ready_cbs
      0.11 ± 10%      -0.0        0.10 ± 17%      +0.0        0.11 ± 21%  perf-profile.children.cycles-pp.__note_gp_changes
      0.12 ± 24%      -0.0        0.11 ± 27%      +0.0        0.12 ± 27%  perf-profile.children.cycles-pp.__do_sys_newstat
      0.23 ± 28%      -0.0        0.23 ± 19%      -0.0        0.20 ± 28%  perf-profile.children.cycles-pp.alloc_pages_vma
      0.09 ± 26%      -0.0        0.08 ± 15%      +0.0        0.09 ± 22%  perf-profile.children.cycles-pp.open64
      0.15 ± 32%      -0.0        0.15 ± 39%      +0.0        0.16 ± 33%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.11 ± 25%      -0.0        0.11 ± 33%      +0.0        0.12 ± 30%  perf-profile.children.cycles-pp.machine__process_fork_event
      0.20 ±  5%      -0.0        0.20 ± 11%      +0.0        0.23 ± 24%  perf-profile.children.cycles-pp.read
      0.09 ± 21%      -0.0        0.09 ± 17%      -0.0        0.08 ± 30%  perf-profile.children.cycles-pp.__pagevec_lru_add
      0.08 ± 10%      -0.0        0.08 ± 28%      +0.0        0.09 ± 18%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.27 ±  6%      -0.0        0.26 ± 14%      +0.0        0.28 ± 14%  perf-profile.children.cycles-pp.newidle_balance
      0.14 ± 12%      -0.0        0.13 ± 11%      +0.0        0.16 ± 20%  perf-profile.children.cycles-pp.execve
      0.39 ±  8%      -0.0        0.38 ± 10%      +0.0        0.42 ± 13%  perf-profile.children.cycles-pp.schedule
      0.12 ± 13%      -0.0        0.11 ± 11%      +0.0        0.13 ± 19%  perf-profile.children.cycles-pp.bprm_execve
      0.04 ±101%      -0.0        0.03 ± 87%      -0.0        0.03 ±117%  perf-profile.children.cycles-pp.xas_store
      0.33 ±  6%      -0.0        0.32 ± 12%      +0.0        0.35 ± 13%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.11 ± 28%      -0.0        0.10 ± 35%      +0.0        0.11 ± 33%  perf-profile.children.cycles-pp.thread__new
      0.07 ± 10%      -0.0        0.07 ± 13%      -0.0        0.07 ± 46%  perf-profile.children.cycles-pp.__do_sys_clone
      0.07 ± 10%      -0.0        0.07 ± 13%      -0.0        0.07 ± 46%  perf-profile.children.cycles-pp.kernel_clone
      0.11 ± 24%      -0.0        0.11 ± 32%      +0.0        0.12 ± 28%  perf-profile.children.cycles-pp.__xstat64
      0.25 ± 29%      -0.0        0.25 ± 29%      +0.1        0.31 ± 33%  perf-profile.children.cycles-pp.start_kernel
      0.22 ± 12%      -0.0        0.22 ±  7%      +0.0        0.22 ±  7%  perf-profile.children.cycles-pp.can_stop_idle_tick
      0.06 ± 11%      -0.0        0.06 ± 46%      +0.0        0.07 ± 41%  perf-profile.children.cycles-pp.evlist__close
      0.10 ± 27%      -0.0        0.10 ± 33%      +0.0        0.11 ± 33%  perf-profile.children.cycles-pp.nsinfo__new
      0.19 ± 32%      -0.0        0.19 ± 37%      +0.0        0.20 ± 32%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.10 ±  7%      -0.0        0.10 ± 16%      -0.0        0.09 ± 16%  perf-profile.children.cycles-pp.cpuidle_reflect
      0.01 ±223%      -0.0        0.01 ±244%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.sys_imageblit
      0.01 ±223%      -0.0        0.01 ±244%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.bit_putcs
      0.01 ±223%      -0.0        0.01 ±244%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.vt_console_print
      0.01 ±223%      -0.0        0.01 ±244%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.fbcon_putcs
      0.01 ±223%      -0.0        0.01 ±244%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.drm_fb_helper_sys_imageblit
      0.07 ±  8%      -0.0        0.07 ± 11%      +0.0        0.08 ± 32%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.07 ±  8%      -0.0        0.07 ± 11%      +0.0        0.08 ± 32%  perf-profile.children.cycles-pp.do_group_exit
      0.07 ±  8%      -0.0        0.07 ± 11%      +0.0        0.08 ± 32%  perf-profile.children.cycles-pp.do_exit
      0.04 ± 72%      -0.0        0.04 ± 88%      -0.0        0.03 ± 88%  perf-profile.children.cycles-pp.cpu_latency_qos_limit
      0.03 ±100%      -0.0        0.02 ±116%      -0.0        0.02 ±118%  perf-profile.children.cycles-pp.up_write
      0.12 ± 27%      -0.0        0.11 ± 16%      -0.0        0.10 ± 27%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.09 ± 27%      -0.0        0.08 ± 22%      -0.0        0.08 ± 25%  perf-profile.children.cycles-pp.__might_sleep
      0.09 ± 17%      -0.0        0.08 ± 26%      -0.0        0.08 ± 29%  perf-profile.children.cycles-pp.lru_cache_add
      0.13 ± 16%      -0.0        0.12 ±  8%      +0.0        0.13 ± 23%  perf-profile.children.cycles-pp.profile_tick
      0.11 ± 25%      -0.0        0.11 ± 28%      +0.0        0.12 ± 27%  perf-profile.children.cycles-pp.vfs_statx
      0.14 ± 31%      -0.0        0.14 ± 38%      +0.0        0.15 ± 34%  perf-profile.children.cycles-pp.thread__find_map
      0.12 ± 21%      -0.0        0.12 ± 19%      -0.0        0.12 ± 18%  perf-profile.children.cycles-pp.__unwind_start
      0.07 ± 10%      -0.0        0.07 ± 13%      +0.0        0.08 ± 25%  perf-profile.children.cycles-pp.mmput
      0.07 ± 14%      -0.0        0.07 ±  9%      -0.0        0.07 ± 30%  perf-profile.children.cycles-pp.update_load_avg
      0.10 ± 20%      -0.0        0.10 ± 25%      +0.0        0.11 ± 25%  perf-profile.children.cycles-pp.rcu_do_batch
      0.11 ± 35%      -0.0        0.11 ± 33%      +0.0        0.12 ± 30%  perf-profile.children.cycles-pp.seq_printf
      0.09 ± 42%      -0.0        0.09 ± 37%      +0.0        0.10 ± 35%  perf-profile.children.cycles-pp.s_show
      0.01 ±223%      -0.0        0.01 ±244%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.symbol__is_idle
      0.07 ± 16%      -0.0        0.07 ± 19%      +0.0        0.07 ± 23%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.14 ± 31%      -0.0        0.14 ± 39%      +0.0        0.14 ± 34%  perf-profile.children.cycles-pp.map__load
      0.09 ± 13%      -0.0        0.09 ± 13%      +0.0        0.10 ± 25%  perf-profile.children.cycles-pp.__libc_fork
      0.06 ± 13%      -0.0        0.05 ± 41%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.cpuidle_select
      0.02 ±141%      -0.0        0.01 ±158%      +0.0        0.03 ±120%  perf-profile.children.cycles-pp.perf_evsel__read
      0.04 ± 71%      -0.0        0.03 ± 87%      -0.0        0.02 ±161%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.26 ±  8%      -0.0        0.25 ±  5%      +0.0        0.27 ±  9%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.10 ± 30%      -0.0        0.09 ± 39%      +0.0        0.10 ± 38%  perf-profile.children.cycles-pp.kallsyms__parse
      0.03 ± 99%      -0.0        0.02 ±116%      +0.0        0.03 ±117%  perf-profile.children.cycles-pp.kmem_cache_free
      0.13 ± 31%      -0.0        0.13 ± 36%      +0.0        0.14 ± 36%  perf-profile.children.cycles-pp.__dso__load_kallsyms
      0.08 ±  5%      -0.0        0.08 ± 12%      +0.0        0.10 ± 19%  perf-profile.children.cycles-pp.load_elf_binary
      0.32 ± 31%      -0.0        0.32 ± 20%      -0.0        0.30 ± 30%  perf-profile.children.cycles-pp.shmem_alloc_and_acct_page
      0.20 ± 25%      -0.0        0.20 ± 22%      -0.0        0.17 ± 26%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.10 ± 18%      -0.0        0.10 ± 18%      +0.0        0.12 ± 13%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.07 ±  9%      -0.0        0.07 ± 13%      +0.0        0.08 ± 25%  perf-profile.children.cycles-pp.exit_mmap
      0.26 ± 27%      -0.0        0.26 ± 31%      +0.0        0.29 ± 28%  perf-profile.children.cycles-pp.seq_read_iter
      0.11 ± 30%      -0.0        0.11 ± 34%      +0.0        0.12 ± 33%  perf-profile.children.cycles-pp.____machine__findnew_thread
      0.01 ±223%      -0.0        0.01 ±244%      +0.0        0.01 ±244%  perf-profile.children.cycles-pp.__kernel_text_address
      0.01 ±223%      -0.0        0.01 ±244%      +0.0        0.02 ±159%  perf-profile.children.cycles-pp.rcu_dynticks_task_enter
      0.01 ±223%      -0.0        0.01 ±244%      +0.0        0.02 ±158%  perf-profile.children.cycles-pp.perf_output_sample
      0.34 ± 21%      -0.0        0.34 ± 19%      -0.0        0.31 ± 25%  perf-profile.children.cycles-pp.task_tick_fair
      0.07 ± 23%      -0.0        0.07 ± 20%      -0.0        0.06 ± 51%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.13 ± 37%      -0.0        0.13 ± 37%      +0.0        0.15 ± 32%  perf-profile.children.cycles-pp.proc_reg_read
      0.14 ± 29%      -0.0        0.14 ± 39%      -0.0        0.14 ± 34%  perf-profile.children.cycles-pp.ordered_events__queue
      0.25 ±  8%      -0.0        0.25 ±  7%      +0.0        0.25 ± 12%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.14 ± 33%      -0.0        0.14 ± 39%      +0.0        0.14 ± 34%  perf-profile.children.cycles-pp.dso__load
      0.07 ± 20%      -0.0        0.07 ± 19%      +0.0        0.08 ± 28%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.02 ±141%      -0.0        0.02 ±159%      -0.0        0.00        perf-profile.children.cycles-pp.unlock_page
      0.35 ± 25%      -0.0        0.35 ± 21%      -0.0        0.33 ± 26%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.20 ±  7%      -0.0        0.20 ± 12%      +0.0        0.21 ± 12%  perf-profile.children.cycles-pp.sched_clock_idle_wakeup_event
      0.06 ± 24%      -0.0        0.06 ± 53%      -0.0        0.05 ± 47%  perf-profile.children.cycles-pp.page_mapping
      0.10 ± 31%      -0.0        0.10 ± 30%      -0.0        0.09 ± 31%  perf-profile.children.cycles-pp.mark_page_accessed
      0.48 ± 12%      -0.0        0.48 ± 10%      +0.0        0.50 ± 21%  perf-profile.children.cycles-pp.perf_tp_event
      0.07 ±  9%      -0.0        0.07 ± 22%      +0.0        0.09 ± 16%  perf-profile.children.cycles-pp.evlist__delete
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.format_decode
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.__evlist__disable
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.enqueue_entity
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.run_timer_softirq
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.call_timer_fn
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.shmem_pseudo_vma_init
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.drm_gem_shmem_vmap
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.rcu_advance_cbs
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.getname_flags
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.kernel_text_address
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.dev_attr_show
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.orc_find
      0.10 ± 11%      +0.0        0.10 ± 22%      +0.0        0.11 ± 26%  perf-profile.children.cycles-pp.ksoftirqd_running
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.noop_fsync
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.children.cycles-pp.zap_pte_range
      0.00            +0.0        0.00            +0.0        0.01 ±158%  perf-profile.children.cycles-pp.__lookup_slow
      0.00            +0.0        0.00            +0.0        0.01 ±158%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.00            +0.0        0.00            +0.0        0.02 ±159%  perf-profile.children.cycles-pp.move_queued_task
      0.00            +0.0        0.00            +0.0        0.02 ±159%  perf-profile.children.cycles-pp.__msecs_to_jiffies
      0.00            +0.0        0.00            +0.0        0.02 ±159%  perf-profile.children.cycles-pp.begin_new_exec
      0.00            +0.0        0.00            +0.0        0.02 ±159%  perf-profile.children.cycles-pp.preempt_schedule_common
      0.06 ± 13%      +0.0        0.06 ± 47%      -0.0        0.05 ± 48%  perf-profile.children.cycles-pp.__orc_find
      0.10 ± 11%      +0.0        0.10 ± 13%      +0.0        0.10 ± 18%  perf-profile.children.cycles-pp.__cond_resched
      0.09 ± 25%      +0.0        0.09 ± 16%      -0.0        0.08 ± 28%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.01 ±223%      +0.0        0.01 ±244%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.01 ±223%      +0.0        0.01 ±244%      +0.0        0.02 ±159%  perf-profile.children.cycles-pp.perf_release
      0.01 ±223%      +0.0        0.01 ±244%      +0.0        0.02 ±159%  perf-profile.children.cycles-pp.perf_event_release_kernel
      0.33 ± 18%      +0.0        0.33 ± 14%      -0.0        0.32 ± 24%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.06 ± 46%      +0.0        0.06 ± 12%      -0.0        0.05 ± 48%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.13 ± 30%      +0.0        0.13 ± 39%      +0.0        0.13 ± 37%  perf-profile.children.cycles-pp.queue_event
      0.07 ± 23%      +0.0        0.07 ± 21%      +0.0        0.07 ± 34%  perf-profile.children.cycles-pp.pipe_read
      0.09 ±  8%      +0.0        0.09 ± 15%      +0.0        0.10 ± 20%  perf-profile.children.cycles-pp.exec_binprm
      0.12 ± 21%      +0.0        0.13 ± 17%      +0.0        0.13 ± 29%  perf-profile.children.cycles-pp.link_path_walk
      0.09 ± 29%      +0.0        0.09 ± 18%      -0.0        0.08 ± 31%  perf-profile.children.cycles-pp.rmqueue
      0.08 ± 26%      +0.0        0.08 ± 32%      +0.0        0.09 ± 80%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.03 ±100%      +0.0        0.03 ± 88%      +0.0        0.04 ± 93%  perf-profile.children.cycles-pp.xas_start
      0.12 ± 30%      +0.0        0.12 ± 19%      -0.0        0.11 ± 38%  perf-profile.children.cycles-pp.down_write
      0.01 ±223%      +0.0        0.01 ±244%      +0.0        0.04 ± 65%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.08 ± 29%      +0.0        0.08 ± 31%      -0.0        0.07 ± 26%  perf-profile.children.cycles-pp.set_page_dirty
      0.12 ± 34%      +0.0        0.12 ± 33%      +0.0        0.13 ± 30%  perf-profile.children.cycles-pp.vsnprintf
      0.07 ± 10%      +0.0        0.07 ± 17%      +0.0        0.07 ± 28%  perf-profile.children.cycles-pp.update_group_capacity
      0.01 ±223%      +0.0        0.01 ±244%      +0.0        0.02 ±118%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.01 ±223%      +0.0        0.01 ±244%      +0.0        0.03 ± 89%  perf-profile.children.cycles-pp.__wake_up_common
      0.49 ± 19%      +0.0        0.49 ± 21%      -0.0        0.45 ± 22%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.11 ± 36%      +0.0        0.11 ± 33%      +0.0        0.12 ± 29%  perf-profile.children.cycles-pp.seq_vprintf
      0.04 ± 71%      +0.0        0.04 ± 91%      -0.0        0.03 ±120%  perf-profile.children.cycles-pp.free_unref_page_list
      0.10 ±  8%      +0.0        0.10 ± 10%      +0.0        0.10 ± 22%  perf-profile.children.cycles-pp.task_tick_idle
      0.06 ± 14%      +0.0        0.07 ± 11%      +0.0        0.07 ± 21%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.45 ± 12%      +0.0        0.45 ± 10%      +0.0        0.46 ± 21%  perf-profile.children.cycles-pp.__perf_event_overflow
      0.14 ±  9%      +0.0        0.14 ±  9%      -0.0        0.13 ± 12%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_enter
      0.20 ± 15%      +0.0        0.20 ± 14%      -0.0        0.19 ± 17%  perf-profile.children.cycles-pp.unwind_next_frame
      0.06 ± 16%      +0.0        0.06 ± 20%      -0.0        0.06 ± 41%  perf-profile.children.cycles-pp.mmap_region
      0.06 ± 19%      +0.0        0.06 ± 11%      +0.0        0.07 ± 19%  perf-profile.children.cycles-pp.timer_clear_idle
      0.29 ± 10%      +0.0        0.29 ± 10%      -0.0        0.29 ±  8%  perf-profile.children.cycles-pp.trigger_load_balance
      0.46 ± 11%      +0.0        0.46 ±  9%      +0.0        0.47 ± 21%  perf-profile.children.cycles-pp.perf_swevent_overflow
      0.03 ±100%      +0.0        0.03 ± 87%      -0.0        0.02 ±115%  perf-profile.children.cycles-pp.tick_nohz_idle_retain_tick
      0.45 ± 11%      +0.0        0.45 ± 10%      +0.0        0.45 ± 21%  perf-profile.children.cycles-pp.perf_event_output_forward
      0.09 ± 11%      +0.0        0.10 ± 13%      +0.0        0.11 ±  9%  perf-profile.children.cycles-pp.rcu_idle_enter
      0.33 ±  7%      +0.0        0.34 ± 10%      +0.0        0.35 ± 23%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.03 ±100%      +0.0        0.04 ± 89%      -0.0        0.02 ±159%  perf-profile.children.cycles-pp.iov_iter_advance
      0.07 ± 14%      +0.0        0.08 ± 15%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.check_tsc_unstable
      0.01 ±223%      +0.0        0.01 ±158%      +0.0        0.01 ±244%  perf-profile.children.cycles-pp.__libc_write
      0.37 ± 16%      +0.0        0.37 ± 15%      -0.0        0.36 ± 22%  perf-profile.children.cycles-pp.update_curr
      0.39 ± 14%      +0.0        0.39 ± 11%      -0.0        0.39 ± 21%  perf-profile.children.cycles-pp.perf_prepare_sample
      0.03 ±100%      +0.0        0.03 ± 88%      +0.0        0.05 ± 43%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.87            +0.0        0.87 ±  7%      +0.1        0.98 ± 18%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.73 ± 25%      +0.0        0.73 ± 30%      +0.0        0.76 ± 27%  perf-profile.children.cycles-pp.cmd_record
      0.11 ± 29%      +0.0        0.11 ± 26%      -0.0        0.10 ± 18%  perf-profile.children.cycles-pp.__pagevec_release
      0.03 ± 99%      +0.0        0.03 ± 87%      +0.0        0.04 ± 91%  perf-profile.children.cycles-pp.__bitmap_and
      0.10 ± 33%      +0.0        0.11 ± 29%      +0.0        0.11 ± 39%  perf-profile.children.cycles-pp.delete_from_page_cache
      0.07 ± 11%      +0.0        0.07 ± 13%      +0.0        0.07 ± 18%  perf-profile.children.cycles-pp.do_mmap
      0.58 ± 22%      +0.0        0.59 ± 21%      -0.0        0.55 ± 20%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.07 ± 10%      +0.0        0.08 ± 12%      +0.0        0.08 ± 21%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.10 ± 13%      +0.0        0.11 ± 12%      +0.0        0.14 ± 28%  perf-profile.children.cycles-pp.update_dl_rq_load_avg
      0.03 ±103%      +0.0        0.04 ± 93%      +0.0        0.05 ± 65%  perf-profile.children.cycles-pp.free_unref_page
      0.06 ±  6%      +0.0        0.07 ± 17%      +0.0        0.08 ± 16%  perf-profile.children.cycles-pp.affine_move_task
      0.08 ±  7%      +0.0        0.09 ± 10%      +0.0        0.09 ± 29%  perf-profile.children.cycles-pp.intel_pmu_disable_all
      0.03 ±101%      +0.0        0.04 ± 88%      +0.0        0.04 ± 67%  perf-profile.children.cycles-pp.do_open
      0.02 ±144%      +0.0        0.03 ±120%      +0.0        0.04 ± 69%  perf-profile.children.cycles-pp.pipe_write
      0.01 ±223%      +0.0        0.02 ±159%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.number
      0.10 ± 15%      +0.0        0.11 ± 21%      +0.0        0.12 ± 21%  perf-profile.children.cycles-pp.try_to_wake_up
      0.01 ±223%      +0.0        0.01 ±158%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.01 ±223%      +0.0        0.01 ±158%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.__do_munmap
      0.01 ±223%      +0.0        0.01 ±158%      +0.0        0.01 ±244%  perf-profile.children.cycles-pp.unwind_get_return_address
      0.14 ± 23%      +0.0        0.14 ± 24%      -0.0        0.12 ± 27%  perf-profile.children.cycles-pp.get_page_from_freelist
      1.02 ±  4%      +0.0        1.02 ±  6%      -0.0        1.01 ±  5%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.12 ± 32%      +0.0        0.13 ± 30%      -0.0        0.12 ± 36%  perf-profile.children.cycles-pp.truncate_inode_page
      0.07 ± 14%      +0.0        0.07 ± 13%      +0.0        0.07 ± 43%  perf-profile.children.cycles-pp.tick_nohz_get_next_hrtimer
      0.11 ± 34%      +0.0        0.12 ± 20%      -0.0        0.10 ± 28%  perf-profile.children.cycles-pp.write@plt
      0.14 ±  9%      +0.0        0.15 ± 12%      +0.0        0.15 ± 23%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.14 ±  9%      +0.0        0.15 ± 12%      +0.0        0.15 ± 23%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.14 ±  9%      +0.0        0.15 ± 12%      +0.0        0.15 ± 23%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.14 ±  9%      +0.0        0.15 ± 12%      +0.0        0.15 ± 23%  perf-profile.children.cycles-pp.irq_work_run
      0.14 ±  9%      +0.0        0.15 ± 12%      +0.0        0.15 ± 23%  perf-profile.children.cycles-pp.irq_work_single
      0.34 ± 14%      +0.0        0.35 ± 11%      -0.0        0.34 ± 20%  perf-profile.children.cycles-pp.perf_callchain
      0.17 ± 19%      +0.0        0.18 ± 23%      +0.0        0.18 ± 21%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.00            +0.0        0.01 ±244%      +0.0        0.00        perf-profile.children.cycles-pp.rcu_all_qs
      0.00            +0.0        0.01 ±244%      +0.0        0.00        perf-profile.children.cycles-pp.sched_clock_idle_sleep_event
      0.00            +0.0        0.01 ±244%      +0.0        0.00        perf-profile.children.cycles-pp.cpu_stop_queue_work
      0.00            +0.0        0.01 ±244%      +0.0        0.00        perf-profile.children.cycles-pp.native_irq_return_ldt
      0.00            +0.0        0.01 ±244%      +0.0        0.00        perf-profile.children.cycles-pp.wake_up_q
      0.00            +0.0        0.01 ±244%      +0.0        0.00        perf-profile.children.cycles-pp.alloc_empty_file
      0.00            +0.0        0.01 ±244%      +0.0        0.01 ±244%  perf-profile.children.cycles-pp.rcu_irq_enter
      0.00            +0.0        0.01 ±244%      +0.0        0.01 ±244%  perf-profile.children.cycles-pp._free_event
      0.00            +0.0        0.01 ±244%      +0.0        0.01 ±244%  perf-profile.children.cycles-pp.lseek@plt
      0.00            +0.0        0.01 ±244%      +0.0        0.01 ±244%  perf-profile.children.cycles-pp.lf
      0.00            +0.0        0.01 ±244%      +0.0        0.01 ±244%  perf-profile.children.cycles-pp.con_scroll
      0.00            +0.0        0.01 ±244%      +0.0        0.01 ±244%  perf-profile.children.cycles-pp.fbcon_scroll
      0.00            +0.0        0.01 ±244%      +0.0        0.01 ±244%  perf-profile.children.cycles-pp.fbcon_redraw
      0.00            +0.0        0.01 ±244%      +0.0        0.01 ±158%  perf-profile.children.cycles-pp.do_dentry_open
      0.00            +0.0        0.01 ±244%      +0.0        0.02 ±161%  perf-profile.children.cycles-pp.migration_cpu_stop
      0.00            +0.0        0.01 ±244%      +0.0        0.02 ±161%  perf-profile.children.cycles-pp.sysfs_kf_seq_show
      0.00            +0.0        0.01 ±244%      +0.0        0.03 ±117%  perf-profile.children.cycles-pp.cpu_stopper_thread
      0.15 ± 13%      +0.0        0.16 ± 11%      +0.0        0.15 ± 21%  perf-profile.children.cycles-pp.printk
      0.01 ±223%      +0.0        0.02 ±159%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.shmem_file_llseek
      0.01 ±223%      +0.0        0.02 ±159%      +0.0        0.01 ±244%  perf-profile.children.cycles-pp.workingset_activation
      0.06 ± 20%      +0.0        0.07 ± 13%      -0.0        0.05 ± 44%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.72 ± 25%      +0.0        0.73 ± 30%      +0.0        0.76 ± 27%  perf-profile.children.cycles-pp.cmd_sched
      0.20 ±  2%      +0.0        0.21 ±  7%      +0.0        0.21 ±  8%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.23 ± 13%      +0.0        0.24 ± 19%      +0.0        0.25 ± 21%  perf-profile.children.cycles-pp.do_sys_open
      0.23 ± 14%      +0.0        0.24 ± 19%      +0.0        0.25 ± 21%  perf-profile.children.cycles-pp.do_sys_openat2
      0.06 ± 17%      +0.0        0.07 ± 10%      +0.0        0.07 ± 27%  perf-profile.children.cycles-pp.sched_clock_tick
      0.00            +0.0        0.01 ±244%      +0.0        0.03 ±169%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.34 ± 14%      +0.0        0.35 ± 11%      -0.0        0.33 ± 20%  perf-profile.children.cycles-pp.get_perf_callchain
      0.49 ±  5%      +0.0        0.50 ±  6%      +0.0        0.49 ±  5%  perf-profile.children.cycles-pp.__hrtimer_get_next_event
      0.01 ±223%      +0.0        0.02 ±158%      +0.0        0.03 ± 89%  perf-profile.children.cycles-pp.mutex_lock
      0.13 ± 19%      +0.0        0.14 ± 22%      -0.0        0.12 ± 17%  perf-profile.children.cycles-pp.release_pages
      0.25 ± 22%      +0.0        0.26 ± 25%      +0.0        0.29 ± 25%  perf-profile.children.cycles-pp.__libc_read
      0.08 ± 17%      +0.0        0.09 ± 12%      +0.0        0.09 ± 24%  perf-profile.children.cycles-pp.dequeue_entity
      0.05 ± 47%      +0.0        0.06 ±  8%      +0.0        0.05 ± 46%  perf-profile.children.cycles-pp.evsel__read_counter
      0.12 ± 30%      +0.0        0.13 ±  8%      -0.0        0.12 ± 18%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.10 ± 24%      +0.0        0.11 ± 27%      -0.0        0.10 ± 22%  perf-profile.children.cycles-pp.ksys_lseek
      0.41 ± 15%      +0.0        0.42 ± 19%      +0.1        0.48 ± 24%  perf-profile.children.cycles-pp.vfs_read
      0.20 ± 12%      +0.0        0.21 ± 17%      +0.0        0.22 ± 21%  perf-profile.children.cycles-pp.path_openat
      0.15 ± 19%      +0.0        0.16 ± 11%      +0.0        0.15 ± 19%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.20 ± 13%      +0.0        0.21 ± 18%      +0.0        0.22 ± 22%  perf-profile.children.cycles-pp.do_filp_open
      1.30 ±  4%      +0.0        1.31 ±  6%      +0.1        1.40 ± 18%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.22 ± 11%      +0.0        0.23 ±  4%      +0.0        0.22 ± 11%  perf-profile.children.cycles-pp.call_cpuidle
      0.08 ± 14%      +0.0        0.09 ±  6%      +0.0        0.10 ± 25%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.42 ± 15%      +0.0        0.43 ± 19%      +0.1        0.49 ± 24%  perf-profile.children.cycles-pp.ksys_read
      0.07 ± 29%      +0.0        0.08 ± 29%      -0.0        0.07 ± 23%  perf-profile.children.cycles-pp.force_qs_rnp
      0.02 ±142%      +0.0        0.03 ±115%      +0.0        0.02 ±158%  perf-profile.children.cycles-pp.sysfs__read_str
      0.27 ± 16%      +0.0        0.28 ± 14%      -0.0        0.26 ± 19%  perf-profile.children.cycles-pp.perf_callchain_kernel
      0.10 ±  6%      +0.0        0.11 ± 13%      +0.0        0.11 ± 37%  perf-profile.children.cycles-pp.account_process_tick
      0.03 ±105%      +0.0        0.04 ±104%      -0.0        0.02 ±158%  perf-profile.children.cycles-pp.__set_page_dirty_no_writeback
      0.07 ± 54%      +0.0        0.08 ± 25%      -0.0        0.06 ± 58%  perf-profile.children.cycles-pp.__delete_from_page_cache
      0.22 ± 11%      +0.0        0.23 ±  7%      +0.0        0.23 ± 20%  perf-profile.children.cycles-pp.irq_work_run_list
      0.02 ±141%      +0.0        0.03 ± 87%      -0.0        0.00        perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.14 ± 33%      +0.0        0.16 ± 35%      +0.0        0.15 ± 34%  perf-profile.children.cycles-pp.perf_session__write_header
      0.16 ±  9%      +0.0        0.18 ± 10%      -0.0        0.15 ± 10%  perf-profile.children.cycles-pp.rcu_dynticks_task_exit
      0.15 ± 12%      +0.0        0.16 ±  9%      +0.0        0.16 ± 20%  perf-profile.children.cycles-pp.vprintk_emit
      0.15 ± 12%      +0.0        0.16 ±  9%      +0.0        0.16 ± 20%  perf-profile.children.cycles-pp.console_unlock
      0.00            +0.0        0.01 ±158%      +0.0        0.02 ±116%  perf-profile.children.cycles-pp.update_iter
      0.00            +0.0        0.01 ±158%      +0.0        0.02 ±116%  perf-profile.children.cycles-pp.wait_for_completion
      0.00            +0.0        0.01 ±158%      +0.0        0.02 ±116%  perf-profile.children.cycles-pp.s_next
      0.07 ± 54%      +0.0        0.08 ± 35%      +0.0        0.08 ± 32%  perf-profile.children.cycles-pp.sysfs__read_int
      0.01 ±223%      +0.0        0.02 ±116%      -0.0        0.00        perf-profile.children.cycles-pp.try_charge
      0.01 ±223%      +0.0        0.02 ±116%      +0.0        0.02 ±161%  perf-profile.children.cycles-pp.schedule_timeout
      0.01 ±223%      +0.0        0.02 ±116%      +0.0        0.02 ±118%  perf-profile.children.cycles-pp.__intel_pmu_disable_all
      0.09 ± 28%      +0.0        0.10 ± 37%      -0.0        0.08 ± 34%  perf-profile.children.cycles-pp.__fget_light
      0.12 ± 33%      +0.0        0.13 ± 35%      +0.0        0.13 ± 31%  perf-profile.children.cycles-pp.write_cache
      0.04 ±100%      +0.0        0.05 ± 44%      -0.0        0.02 ±161%  perf-profile.children.cycles-pp.aim_rand
      0.10 ± 32%      +0.0        0.12 ± 30%      +0.0        0.11 ± 31%  perf-profile.children.cycles-pp.cpu_cache_level__read
      0.11 ± 27%      +0.0        0.13 ± 34%      +0.0        0.11 ± 23%  perf-profile.children.cycles-pp.rcu_gp_kthread
      0.22 ± 10%      +0.0        0.24 ± 10%      +0.0        0.27 ± 23%  perf-profile.children.cycles-pp.dispatch_events
      0.22 ± 10%      +0.0        0.24 ± 10%      +0.0        0.27 ± 23%  perf-profile.children.cycles-pp.process_interval
      0.14 ±  9%      +0.0        0.16 ± 13%      +0.0        0.17 ± 32%  perf-profile.children.cycles-pp.new_sync_read
      0.00            +0.0        0.02 ±159%      +0.0        0.02 ±159%  perf-profile.children.cycles-pp.__do_set_cpus_allowed
      0.11 ± 12%      +0.0        0.12 ± 14%      +0.0        0.13 ± 31%  perf-profile.children.cycles-pp.update_rt_rq_load_avg
      1.94 ±  7%      +0.0        1.95 ±  3%      -0.1        1.86 ± 12%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.05 ± 77%      +0.0        0.06 ± 29%      +0.0        0.06 ± 47%  perf-profile.children.cycles-pp.rb_free
      0.19 ± 23%      +0.0        0.21 ± 16%      -0.0        0.19 ± 26%  perf-profile.children.cycles-pp.___might_sleep
      0.95 ±  4%      +0.0        0.97 ±  6%      +0.1        1.04 ± 22%  perf-profile.children.cycles-pp.timerqueue_del
      0.10 ±  6%      +0.0        0.12 ± 13%      +0.0        0.13 ± 18%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
      0.22 ± 10%      +0.0        0.24 ± 10%      +0.0        0.27 ± 23%  perf-profile.children.cycles-pp.cmd_stat
      0.15 ± 25%      +0.0        0.17 ± 13%      +0.0        0.18 ± 27%  perf-profile.children.cycles-pp.io_serial_in
      0.22 ± 10%      +0.0        0.24 ± 10%      +0.0        0.27 ± 22%  perf-profile.children.cycles-pp.read_counters
      0.38 ± 44%      +0.0        0.40 ± 21%      +0.0        0.42 ± 29%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.05 ± 51%      +0.0        0.07 ± 29%      -0.0        0.04 ± 67%  perf-profile.children.cycles-pp.dyntick_save_progress_counter
      0.08 ± 29%      +0.0        0.10 ± 32%      +0.0        0.10 ± 32%  perf-profile.children.cycles-pp.__open64
      0.00            +0.0        0.02 ±158%      +0.0        0.01 ±244%  perf-profile.children.cycles-pp.memcpy_erms
      0.11 ± 31%      +0.0        0.13 ± 37%      +0.0        0.11 ± 25%  perf-profile.children.cycles-pp.__fdget_pos
      1.65 ±  3%      +0.0        1.67 ±  7%      -0.1        1.57 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.10 ± 17%      +0.0        0.12 ± 16%      +0.0        0.11 ± 21%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.11 ± 12%      +0.0        0.13 ± 11%      +0.0        0.12 ± 21%  perf-profile.children.cycles-pp.serial8250_console_write
      0.37 ±  2%      +0.0        0.39 ±  6%      +0.0        0.37 ± 11%  perf-profile.children.cycles-pp.menu_reflect
      0.15 ±  7%      +0.0        0.17 ±  9%      +0.0        0.18 ± 25%  perf-profile.children.cycles-pp.irq_work_tick
      0.10 ± 11%      +0.0        0.13 ± 16%      +0.0        0.12 ± 20%  perf-profile.children.cycles-pp.uart_console_write
      0.22 ± 28%      +0.0        0.25 ± 34%      -0.0        0.20 ± 30%  perf-profile.children.cycles-pp.raise_softirq
      0.31 ± 33%      +0.0        0.34 ± 23%      -0.0        0.27 ± 22%  perf-profile.children.cycles-pp.shmem_write_end
      0.02 ±142%      +0.0        0.04 ± 64%      +0.0        0.04 ± 89%  perf-profile.children.cycles-pp.lookup_fast
      0.12 ± 10%      +0.0        0.14 ± 12%      +0.0        0.15 ± 19%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      0.15 ±  4%      +0.0        0.17 ±  7%      +0.0        0.16 ± 15%  perf-profile.children.cycles-pp.tick_nohz_idle_got_tick
      0.95 ± 17%      +0.0        0.97 ± 24%      +0.1        1.04 ± 22%  perf-profile.children.cycles-pp.__libc_start_main
      0.95 ± 17%      +0.0        0.97 ± 24%      +0.1        1.04 ± 22%  perf-profile.children.cycles-pp.main
      0.95 ± 17%      +0.0        0.97 ± 24%      +0.1        1.04 ± 22%  perf-profile.children.cycles-pp.run_builtin
      0.04 ±101%      +0.0        0.06 ± 16%      +0.0        0.04 ± 90%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.11 ± 18%      +0.0        0.13 ± 12%      +0.0        0.12 ± 20%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.05 ± 76%      +0.0        0.08 ± 23%      -0.0        0.05 ± 67%  perf-profile.children.cycles-pp.generic_write_checks
      0.20 ±  5%      +0.0        0.23 ±  9%      +0.0        0.25 ± 24%  perf-profile.children.cycles-pp.rb_erase
      0.13 ± 29%      +0.0        0.16 ± 17%      +0.1        0.19 ± 17%  perf-profile.children.cycles-pp.process_one_work
      0.15 ± 24%      +0.0        0.18 ± 16%      +0.1        0.22 ± 15%  perf-profile.children.cycles-pp.worker_thread
      0.43 ±  4%      +0.0        0.46 ±  4%      +0.0        0.43 ±  2%  perf-profile.children.cycles-pp.tick_program_event
      0.09 ± 61%      +0.0        0.12 ± 24%      +0.0        0.11 ± 27%  perf-profile.children.cycles-pp.memcpy_toio
      0.47 ± 10%      +0.0        0.50 ± 12%      -0.0        0.46 ±  6%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.09 ± 61%      +0.0        0.12 ± 22%      +0.0        0.11 ± 27%  perf-profile.children.cycles-pp.drm_fb_memcpy_dstclip
      0.60 ± 28%      +0.0        0.64 ± 25%      +0.0        0.60 ± 29%  perf-profile.children.cycles-pp.llseek
      5.78 ±  4%      +0.0        5.82 ±  3%      -0.2        5.60 ±  8%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.11 ± 54%      +0.0        0.14 ± 20%      +0.1        0.17 ± 23%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.09 ± 60%      +0.0        0.13 ± 22%      +0.0        0.13 ± 19%  perf-profile.children.cycles-pp.mgag200_handle_damage
      0.09 ± 60%      +0.0        0.13 ± 22%      +0.0        0.13 ± 21%  perf-profile.children.cycles-pp.mgag200_simple_display_pipe_update
      0.09 ± 60%      +0.0        0.13 ± 22%      +0.0        0.14 ± 20%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      1.75 ±  6%      +0.0        1.79 ±  9%      +0.2        1.90 ± 14%  perf-profile.children.cycles-pp.update_rq_clock
      0.09 ± 60%      +0.0        0.13 ± 20%      +0.0        0.14 ± 20%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.09 ± 60%      +0.0        0.13 ± 20%      +0.0        0.14 ± 20%  perf-profile.children.cycles-pp.commit_tail
      0.09 ± 60%      +0.0        0.13 ± 20%      +0.0        0.14 ± 20%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail
      0.59 ± 11%      +0.0        0.63 ± 10%      +0.1        0.69 ±  9%  perf-profile.children.cycles-pp.kthread
      0.60 ± 12%      +0.0        0.64 ±  9%      +0.1        0.70 ±  9%  perf-profile.children.cycles-pp.ret_from_fork
      0.25 ± 12%      +0.0        0.29 ± 12%      +0.1        0.31 ± 19%  perf-profile.children.cycles-pp.sched_setaffinity
      0.09 ± 60%      +0.0        0.13 ± 19%      +0.0        0.14 ± 21%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.62 ±  4%      +0.0        0.66 ± 12%      +0.1        0.72 ± 24%  perf-profile.children.cycles-pp.update_blocked_averages
      0.05 ±  9%      +0.0        0.10 ± 17%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.cpuidle_get_cpu_driver
      0.72 ±  4%      +0.0        0.76 ± 11%      +0.1        0.83 ± 21%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.05 ±  7%      +0.0        0.10 ± 14%      +0.0        0.05 ± 42%  perf-profile.children.cycles-pp.rcu_irq_exit
      1.58 ±  9%      +0.1        1.63 ± 10%      +0.0        1.60 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
      2.64 ± 10%      +0.1        2.70 ±  6%      -0.1        2.58 ± 13%  perf-profile.children.cycles-pp.irqtime_account_irq
      1.14 ±  6%      +0.1        1.20 ±  9%      +0.1        1.22 ± 19%  perf-profile.children.cycles-pp.find_busiest_group
      0.23 ± 11%      +0.1        0.30 ±  8%      +0.0        0.25 ± 22%  perf-profile.children.cycles-pp.cpumask_next_and
      1.06 ±  7%      +0.1        1.13 ±  8%      +0.1        1.15 ± 18%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.64 ±  7%      +0.1        0.71 ±  4%      +0.0        0.65 ±  7%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.34 ±  5%      +0.1        0.41 ±  7%      +0.1        0.43 ± 31%  perf-profile.children.cycles-pp.rb_insert_color
      1.07 ± 11%      +0.1        1.15 ±  7%      -0.1        0.99 ± 10%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      1.10 ±  6%      +0.1        1.18 ±  7%      +0.3        1.38 ± 46%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.91 ±  7%      +0.1        1.00 ±  7%      +0.3        1.18 ± 51%  perf-profile.children.cycles-pp.timerqueue_add
      0.64 ± 11%      +0.1        0.73 ± 25%      +0.0        0.64 ± 13%  perf-profile.children.cycles-pp._raw_spin_lock_irq
     90.32 ±  2%      +0.1       90.41            +0.4       90.72        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     90.32 ±  2%      +0.1       90.41            +0.4       90.72        perf-profile.children.cycles-pp.cpu_startup_entry
     90.32 ±  2%      +0.1       90.41            +0.4       90.72        perf-profile.children.cycles-pp.do_idle
      4.79 ±  7%      +0.1        4.88 ±  7%      +0.7        5.53 ± 23%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      1.49 ±  6%      +0.1        1.58 ±  8%      +0.1        1.58 ± 20%  perf-profile.children.cycles-pp.load_balance
     23.10 ±  2%      +0.1       23.20 ±  4%      +1.0       24.11 ± 12%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.40 ±  7%      +0.1        0.49 ± 13%      +0.0        0.45 ± 26%  perf-profile.children.cycles-pp.hrtimer_forward
      1.51 ±  6%      +0.1        1.61 ±  8%      +0.1        1.63 ± 22%  perf-profile.children.cycles-pp.rebalance_domains
     90.07 ±  2%      +0.1       90.16            +0.3       90.41        perf-profile.children.cycles-pp.start_secondary
      0.35 ±  8%      +0.1        0.45 ±  6%      +0.1        0.40 ±  3%  perf-profile.children.cycles-pp.get_cpu_device
      0.54 ±  9%      +0.1        0.65 ± 11%      -0.0        0.51 ± 13%  perf-profile.children.cycles-pp.rcu_core
      0.74 ±  7%      +0.1        0.85 ±  6%      +0.1        0.80 ±  5%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.47 ±  6%      +0.1        0.59 ±  4%      -0.0        0.47 ±  7%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      3.62 ±  4%      +0.1        3.76 ±  2%      -0.1        3.53 ± 10%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.86 ± 19%      +0.2        1.05 ± 42%      -0.1        0.78 ± 29%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      3.48 ±  4%      +0.3        3.75 ±  8%      +0.2        3.70 ± 17%  perf-profile.children.cycles-pp.__softirqentry_text_start
      3.68 ± 14%      +0.3        3.99 ± 15%      -0.0        3.64 ± 16%  perf-profile.children.cycles-pp.native_sched_clock
      5.93 ±  5%      +0.3        6.25 ±  6%      +0.0        5.95 ±  7%  perf-profile.children.cycles-pp.irq_exit_rcu
      3.79 ± 14%      +0.3        4.10 ± 15%      -0.0        3.75 ± 16%  perf-profile.children.cycles-pp.sched_clock
      4.25 ± 13%      +0.3        4.58 ± 13%      -0.0        4.22 ± 14%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.6        0.56 ±244%      +0.0        0.00        perf-profile.children.cycles-pp.poll_idle
     10.41 ±  6%      +1.3       11.68 ±  6%      +0.7       11.11 ± 13%  perf-profile.children.cycles-pp.menu_select
      6.24 ±  7%      -0.8        5.47 ± 17%      -0.1        6.16 ± 10%  perf-profile.self.cycles-pp.rcu_eqs_exit
     13.24 ±  2%      -0.5       12.76 ±  6%      -0.2       13.01 ±  6%  perf-profile.self.cycles-pp.intel_idle
      3.23 ±  8%      -0.3        2.92 ± 19%      -0.1        3.12 ± 14%  perf-profile.self.cycles-pp.rcu_nmi_enter
      0.95 ± 22%      -0.2        0.78 ± 15%      -0.2        0.76 ± 24%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      2.41 ±  3%      -0.1        2.27 ±  7%      +0.0        2.44 ±  7%  perf-profile.self.cycles-pp.cpuidle_enter_state
      2.49 ±  8%      -0.1        2.35 ± 10%      -0.0        2.47 ± 23%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      1.09 ± 50%      -0.1        0.95 ± 31%      +0.1        1.16 ± 26%  perf-profile.self.cycles-pp.x86_pmu_disable
      1.57 ± 19%      -0.1        1.46 ± 13%      -0.1        1.45 ±  8%  perf-profile.self.cycles-pp.scheduler_tick
      0.64 ± 21%      -0.1        0.54 ± 25%      -0.0        0.63 ± 29%  perf-profile.self.cycles-pp.rcu_nmi_exit
      2.57 ±  8%      -0.1        2.47 ± 21%      -0.1        2.50 ± 23%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.80 ±  6%      -0.1        0.73 ±  9%      -0.0        0.77 ± 10%  perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
      1.23 ±  5%      -0.1        1.18 ±  4%      -0.1        1.17 ±  3%  perf-profile.self.cycles-pp.read_tsc
      1.06 ±  5%      -0.1        1.00 ±  5%      -0.0        1.04 ±  5%  perf-profile.self.cycles-pp.do_idle
      1.35 ±  7%      -0.1        1.30            -0.0        1.31 ±  4%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.96 ±  7%      -0.1        0.91 ± 17%      +0.0        0.99 ± 16%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_exit
      0.65 ±  5%      -0.1        0.60 ± 11%      -0.0        0.61 ±  7%  perf-profile.self.cycles-pp.tick_irq_enter
      0.60 ±  6%      -0.0        0.55 ±  7%      +0.0        0.63 ± 15%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.45 ±  5%      -0.0        0.41 ±  6%      -0.0        0.42 ± 10%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.55 ±  4%      -0.0        0.50 ± 10%      -0.0        0.52 ±  8%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.34 ± 14%      -0.0        0.30 ±  6%      -0.0        0.34 ±  9%  perf-profile.self.cycles-pp.rcu_eqs_enter
      0.38 ±  5%      -0.0        0.35 ±  9%      -0.0        0.36 ±  8%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.73 ±  9%      -0.0        0.69 ± 10%      -0.1        0.64 ± 15%  perf-profile.self.cycles-pp.rb_next
      0.27 ± 29%      -0.0        0.24 ± 29%      -0.1        0.21 ± 27%  perf-profile.self.cycles-pp.write
      0.26 ±  8%      -0.0        0.22 ±  9%      -0.0        0.22 ± 10%  perf-profile.self.cycles-pp.tick_nohz_irq_exit
      0.66 ±  5%      -0.0        0.62 ±  5%      -0.0        0.62 ±  7%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      1.05 ±  5%      -0.0        1.02 ±  6%      +0.0        1.07 ±  8%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.32 ±  9%      -0.0        0.29 ± 16%      -0.0        0.30 ± 23%  perf-profile.self.cycles-pp.rcu_needs_cpu
      0.51 ±  8%      -0.0        0.48 ±  4%      -0.0        0.47 ±  6%  perf-profile.self.cycles-pp.idle_cpu
      0.06 ±  9%      -0.0        0.03 ± 87%      -0.0        0.05 ± 41%  perf-profile.self.cycles-pp.timerqueue_iterate_next
      0.67 ±  4%      -0.0        0.64 ±  3%      -0.0        0.64 ±  4%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.82 ±  4%      -0.0        0.79 ±  6%      -0.0        0.80 ±  7%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.22 ± 31%      -0.0        0.19 ± 21%      -0.0        0.21 ± 23%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.03 ± 99%      -0.0        0.00            -0.0        0.01 ±244%  perf-profile.self.cycles-pp.rw_verify_area
      0.35 ± 10%      -0.0        0.33 ± 10%      +0.1        0.40 ± 26%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.12 ± 24%      -0.0        0.09 ± 27%      -0.0        0.10 ± 34%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.19 ± 13%      -0.0        0.17 ± 14%      -0.0        0.18 ±  5%  perf-profile.self.cycles-pp.sched_idle_set_state
      0.21 ±  4%      -0.0        0.19 ±  8%      +0.0        0.21 ± 10%  perf-profile.self.cycles-pp.hrtimer_next_event_without
      0.40 ± 10%      -0.0        0.38 ± 14%      +0.0        0.43 ± 29%  perf-profile.self.cycles-pp.timerqueue_del
      0.35 ±  3%      -0.0        0.33 ±  7%      -0.0        0.30 ±  8%  perf-profile.self.cycles-pp.clockevents_program_event
      0.49 ±  5%      -0.0        0.47 ±  7%      +0.0        0.50 ± 20%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.07 ± 11%      -0.0        0.05 ± 40%      -0.0        0.07 ± 42%  perf-profile.self.cycles-pp.__note_gp_changes
      0.02 ±142%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.12 ± 15%      -0.0        0.10 ±  6%      -0.0        0.11 ±  9%  perf-profile.self.cycles-pp.local_touch_nmi
      0.44 ±  5%      -0.0        0.42 ±  7%      -0.0        0.40 ± 10%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.30 ± 30%      -0.0        0.29 ± 23%      -0.0        0.28 ± 29%  perf-profile.self.cycles-pp.__entry_text_start
      0.23 ±  6%      -0.0        0.21 ± 12%      -0.0        0.21 ± 10%  perf-profile.self.cycles-pp.irq_work_needs_cpu
      0.13 ± 26%      -0.0        0.11 ± 30%      -0.0        0.12 ± 29%  perf-profile.self.cycles-pp.iov_iter_copy_from_user_atomic
      0.02 ±141%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.unlock_page
      0.56 ±  5%      -0.0        0.55 ± 10%      -0.0        0.56 ±  7%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.06 ± 23%      -0.0        0.05 ± 66%      -0.0        0.06 ± 47%  perf-profile.self.cycles-pp.new_sync_write
      0.44 ±  4%      -0.0        0.42 ±  3%      +0.0        0.44 ±  5%  perf-profile.self.cycles-pp.__x86_retpoline_rax
      0.35 ±  5%      -0.0        0.34 ±  8%      -0.0        0.34 ±  5%  perf-profile.self.cycles-pp.sched_clock
      0.28 ±  5%      -0.0        0.26 ±  6%      -0.0        0.28 ±  3%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.21 ±  2%      -0.0        0.19 ±  5%      +0.0        0.21 ±  8%  perf-profile.self.cycles-pp.menu_reflect
      0.12 ± 27%      -0.0        0.10 ± 22%      -0.0        0.08 ± 27%  perf-profile.self.cycles-pp.generic_perform_write
      0.09 ± 14%      -0.0        0.08 ± 12%      -0.0        0.09 ± 22%  perf-profile.self.cycles-pp.hrtimer_run_queues
      0.17 ± 11%      -0.0        0.16 ± 19%      -0.0        0.16 ± 23%  perf-profile.self.cycles-pp.rcu_is_cpu_rrupt_from_idle
      0.46 ±  3%      -0.0        0.45 ±  6%      -0.0        0.45 ±  8%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.11 ± 29%      -0.0        0.10 ± 26%      -0.0        0.08 ± 25%  perf-profile.self.cycles-pp.__generic_file_write_iter
      0.24 ± 34%      -0.0        0.23 ± 25%      -0.0        0.22 ± 28%  perf-profile.self.cycles-pp.pagecache_get_page
      0.03 ±100%      -0.0        0.02 ±159%      -0.0        0.01 ±244%  perf-profile.self.cycles-pp.xas_start
      0.07 ± 16%      -0.0        0.06 ± 44%      +0.0        0.07 ± 25%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.02 ±142%      -0.0        0.01 ±244%      -0.0        0.02 ±159%  perf-profile.self.cycles-pp.shmem_write_begin
      0.36 ±  5%      -0.0        0.35 ±  6%      +0.0        0.36 ±  8%  perf-profile.self.cycles-pp.__remove_hrtimer
      0.13 ±  9%      -0.0        0.12 ± 11%      +0.0        0.13 ± 10%  perf-profile.self.cycles-pp.restore_regs_and_return_to_kernel
      0.02 ±141%      -0.0        0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.__alloc_pages_nodemask
      0.02 ±141%      -0.0        0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.find_lock_entries
      0.27 ±  6%      -0.0        0.26 ±  6%      +0.0        0.27 ±  3%  perf-profile.self.cycles-pp.rcu_idle_exit
      0.04 ± 71%      -0.0        0.03 ±115%      +0.0        0.04 ± 66%  perf-profile.self.cycles-pp.perf_pmu_disable
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.file_update_time
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.xas_store
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.account_system_index_time
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.mem_cgroup_charge
      0.01 ±223%      -0.0        0.00            -0.0        0.00        perf-profile.self.cycles-pp.set_page_dirty
      0.01 ±223%      -0.0        0.00            -0.0        0.01 ±244%  perf-profile.self.cycles-pp.rcu_dynticks_task_enter
      0.07 ± 14%      -0.0        0.06 ± 12%      +0.0        0.07 ± 35%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.19 ± 36%      -0.0        0.19 ± 19%      -0.0        0.17 ± 30%  perf-profile.self.cycles-pp.vfs_write
      0.03 ±100%      -0.0        0.02 ±116%      -0.0        0.02 ±116%  perf-profile.self.cycles-pp.cpu_latency_qos_limit
      0.02 ±142%      -0.0        0.01 ±158%      +0.0        0.02 ±116%  perf-profile.self.cycles-pp.do_syscall_64
      0.04 ± 72%      -0.0        0.03 ± 89%      +0.0        0.05 ± 56%  perf-profile.self.cycles-pp.__x86_retpoline_rbx
      0.15 ± 28%      -0.0        0.14 ± 21%      -0.0        0.12 ± 29%  perf-profile.self.cycles-pp.sync_disk_rw
      0.18 ± 12%      -0.0        0.18 ± 10%      -0.0        0.17 ±  9%  perf-profile.self.cycles-pp.hrtimer_update_next_event
      0.18 ±  8%      -0.0        0.17 ± 14%      +0.0        0.18 ± 12%  perf-profile.self.cycles-pp.sched_clock_idle_wakeup_event
      0.19 ±  9%      -0.0        0.19 ±  9%      +0.0        0.22 ± 14%  perf-profile.self.cycles-pp.rcu_segcblist_ready_cbs
      0.09 ±  5%      -0.0        0.08 ± 12%      -0.0        0.08 ± 16%  perf-profile.self.cycles-pp.cpuidle_reflect
      0.04 ± 45%      -0.0        0.04 ± 64%      +0.0        0.05 ± 49%  perf-profile.self.cycles-pp.run_rebalance_domains
      0.24 ±  9%      -0.0        0.24 ±  4%      +0.0        0.25 ± 10%  perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.23 ± 17%      -0.0        0.23 ±  8%      -0.0        0.23 ± 10%  perf-profile.self.cycles-pp.trigger_load_balance
      0.21 ± 10%      -0.0        0.21 ±  8%      -0.0        0.21 ±  7%  perf-profile.self.cycles-pp.can_stop_idle_tick
      0.04 ±100%      -0.0        0.04 ± 87%      -0.0        0.02 ±116%  perf-profile.self.cycles-pp.mark_page_accessed
      0.13 ± 16%      -0.0        0.12 ±  8%      +0.0        0.13 ± 23%  perf-profile.self.cycles-pp.profile_tick
      0.17 ±  8%      -0.0        0.16 ± 13%      +0.0        0.18 ± 27%  perf-profile.self.cycles-pp._find_next_bit
      0.18 ±  6%      -0.0        0.18 ± 10%      +0.0        0.19 ± 18%  perf-profile.self.cycles-pp.enqueue_hrtimer
      0.01 ±223%      -0.0        0.01 ±244%      -0.0        0.01 ±244%  perf-profile.self.cycles-pp.__set_page_dirty_no_writeback
      0.10 ± 28%      -0.0        0.10 ± 27%      -0.0        0.09 ± 28%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.10 ± 25%      -0.0        0.09 ± 33%      -0.0        0.08 ± 38%  perf-profile.self.cycles-pp.common_file_perm
      0.02 ±141%      -0.0        0.01 ±158%      -0.0        0.01 ±244%  perf-profile.self.cycles-pp.up_write
      0.11 ± 34%      -0.0        0.10 ± 25%      -0.0        0.10 ± 21%  perf-profile.self.cycles-pp.shmem_getpage_gfp
      0.01 ±223%      -0.0        0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.timestamp_truncate
      0.01 ±223%      -0.0        0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.shmem_file_llseek
      0.01 ±223%      -0.0        0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.kmem_cache_alloc
      0.01 ±223%      -0.0        0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      0.01 ±223%      -0.0        0.01 ±244%      -0.0        0.01 ±244%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.38 ± 11%      -0.0        0.38 ±  9%      -0.0        0.37 ±  9%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.07 ± 23%      -0.0        0.07 ± 20%      -0.0        0.06 ± 51%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.35 ± 25%      -0.0        0.35 ± 21%      -0.0        0.33 ± 26%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.03 ±100%      -0.0        0.03 ± 89%      -0.0        0.02 ±159%  perf-profile.self.cycles-pp.iov_iter_advance
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.self.cycles-pp.format_decode
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.self.cycles-pp.vsnprintf
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.self.cycles-pp.release_pages
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.self.cycles-pp.lseek@plt
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.self.cycles-pp.orc_find
      0.00            +0.0        0.00            +0.0        0.01 ±244%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rbx
      0.00            +0.0        0.00            +0.0        0.01 ±158%  perf-profile.self.cycles-pp.__msecs_to_jiffies
      0.06 ± 13%      +0.0        0.06 ± 47%      -0.0        0.05 ± 45%  perf-profile.self.cycles-pp.__orc_find
      0.19 ±  8%      +0.0        0.19 ± 10%      -0.0        0.18 ±  7%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.14 ±  9%      +0.0        0.14 ± 10%      -0.0        0.13 ± 13%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_enter
      0.32 ±  6%      +0.0        0.32 ±  8%      +0.0        0.32 ±  7%  perf-profile.self.cycles-pp.__hrtimer_get_next_event
      0.11 ± 34%      +0.0        0.11 ± 27%      -0.0        0.09 ± 28%  perf-profile.self.cycles-pp.llseek
      0.07 ± 16%      +0.0        0.07 ± 20%      -0.0        0.05 ± 44%  perf-profile.self.cycles-pp.note_gp_changes
      0.07 ± 11%      +0.0        0.07 ± 15%      +0.0        0.07 ± 33%  perf-profile.self.cycles-pp.find_busiest_group
      0.10 ±  7%      +0.0        0.10 ± 21%      +0.0        0.11 ± 25%  perf-profile.self.cycles-pp.ksoftirqd_running
      0.10 ± 27%      +0.0        0.10 ± 33%      -0.0        0.09 ± 29%  perf-profile.self.cycles-pp.xas_load
      0.06 ± 47%      +0.0        0.06 ±  8%      -0.0        0.04 ± 66%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.08 ± 22%      +0.0        0.08 ± 10%      -0.0        0.08 ± 26%  perf-profile.self.cycles-pp.unwind_next_frame
      0.07 ± 24%      +0.0        0.07 ± 21%      -0.0        0.06 ± 47%  perf-profile.self.cycles-pp.__might_sleep
      0.33 ±  7%      +0.0        0.33 ± 10%      +0.0        0.34 ± 23%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.18 ± 16%      +0.0        0.18 ± 12%      +0.0        0.20 ± 22%  perf-profile.self.cycles-pp.cpuidle_enter
      0.31 ±  7%      +0.0        0.31 ± 12%      -0.0        0.31 ±  7%  perf-profile.self.cycles-pp.update_ts_time_stats
      0.03 ±100%      +0.0        0.03 ± 87%      -0.0        0.02 ±159%  perf-profile.self.cycles-pp.aim_rand
      0.08 ± 13%      +0.0        0.08 ±  9%      +0.0        0.09 ± 17%  perf-profile.self.cycles-pp.irq_work_run_list
      0.09 ± 10%      +0.0        0.09 ±  9%      +0.0        0.09 ± 20%  perf-profile.self.cycles-pp.task_tick_idle
      0.03 ±100%      +0.0        0.03 ± 86%      -0.0        0.01 ±244%  perf-profile.self.cycles-pp.aa_file_perm
      0.12 ± 16%      +0.0        0.12 ± 15%      +0.0        0.13 ± 28%  perf-profile.self.cycles-pp.io_serial_in
      0.06 ± 51%      +0.0        0.06 ± 53%      -0.0        0.04 ± 65%  perf-profile.self.cycles-pp.page_mapping
      0.60 ±  8%      +0.0        0.60 ±  8%      +0.2        0.77 ± 61%  perf-profile.self.cycles-pp.timerqueue_add
      0.02 ±141%      +0.0        0.02 ±116%      +0.0        0.02 ±160%  perf-profile.self.cycles-pp.down_write
      0.12 ±  8%      +0.0        0.12 ± 13%      +0.0        0.14 ± 14%  perf-profile.self.cycles-pp.arch_cpu_idle_enter
      0.15 ± 33%      +0.0        0.15 ± 22%      -0.0        0.13 ± 20%  perf-profile.self.cycles-pp.shmem_write_end
      0.06 ± 13%      +0.0        0.06 ±  8%      -0.0        0.05 ± 47%  perf-profile.self.cycles-pp.timer_clear_idle
      0.12 ± 29%      +0.0        0.12 ± 39%      +0.0        0.12 ± 36%  perf-profile.self.cycles-pp.queue_event
      0.06 ± 74%      +0.0        0.06 ± 45%      -0.0        0.05 ± 67%  perf-profile.self.cycles-pp.generic_file_write_iter
      0.25 ±  9%      +0.0        0.26 ± 10%      +0.0        0.28 ± 20%  perf-profile.self.cycles-pp.rebalance_domains
      0.37 ±  5%      +0.0        0.38 ±  8%      -0.0        0.34 ±  5%  perf-profile.self.cycles-pp.irq_enter_rcu
      0.85            +0.0        0.85 ±  6%      +0.1        0.96 ± 18%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.06 ± 15%      +0.0        0.06 ± 14%      +0.0        0.06 ± 51%  perf-profile.self.cycles-pp.update_group_capacity
      0.08 ± 12%      +0.0        0.08 ± 12%      +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.rcu_idle_enter
      0.47 ±  7%      +0.0        0.48 ±  4%      +0.0        0.52 ± 21%  perf-profile.self.cycles-pp.update_rq_clock
      0.06 ± 11%      +0.0        0.07 ± 14%      -0.0        0.06 ± 10%  perf-profile.self.cycles-pp.check_tsc_unstable
      0.05 ± 78%      +0.0        0.06 ± 42%      +0.0        0.05 ± 51%  perf-profile.self.cycles-pp.ksys_write
      0.01 ±223%      +0.0        0.01 ±158%      +0.0        0.02 ±161%  perf-profile.self.cycles-pp.arch_cpu_idle_exit
      0.16 ± 20%      +0.0        0.16 ± 24%      +0.0        0.17 ± 21%  perf-profile.self.cycles-pp.pm_qos_read_value
      0.02 ±141%      +0.0        0.02 ±116%      +0.0        0.03 ±124%  perf-profile.self.cycles-pp.__bitmap_and
      0.06 ± 17%      +0.0        0.07 ± 15%      +0.0        0.06 ± 45%  perf-profile.self.cycles-pp.tick_nohz_get_next_hrtimer
      0.10 ± 14%      +0.0        0.11 ± 12%      +0.0        0.14 ± 28%  perf-profile.self.cycles-pp.update_dl_rq_load_avg
      0.12 ± 18%      +0.0        0.13 ± 12%      -0.0        0.12 ± 19%  perf-profile.self.cycles-pp.irqentry_exit
      0.00            +0.0        0.01 ±244%      +0.0        0.00        perf-profile.self.cycles-pp.sched_clock_idle_sleep_event
      0.00            +0.0        0.01 ±244%      +0.0        0.00        perf-profile.self.cycles-pp.native_irq_return_ldt
      0.00            +0.0        0.01 ±244%      +0.0        0.01 ±244%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.0        0.01 ±244%      +0.0        0.01 ±244%  perf-profile.self.cycles-pp.tick_nohz_idle_retain_tick
      0.00            +0.0        0.01 ±244%      +0.0        0.01 ±158%  perf-profile.self.cycles-pp.kallsyms__parse
      0.01 ±223%      +0.0        0.02 ±159%      -0.0        0.01 ±244%  perf-profile.self.cycles-pp.number
      0.98 ±  4%      +0.0        0.98 ±  3%      +0.1        1.04 ± 16%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.07 ± 52%      +0.0        0.07 ± 20%      +0.0        0.07 ± 28%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.06 ± 54%      +0.0        0.07 ± 22%      +0.0        0.07 ± 36%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.19 ±  2%      +0.0        0.20 ±  8%      +0.0        0.20 ±  7%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.69 ± 10%      +0.0        0.70 ±  8%      +0.1        0.74 ± 19%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.10 ± 36%      +0.0        0.11 ± 18%      -0.0        0.09 ± 29%  perf-profile.self.cycles-pp.write@plt
      0.50 ±  5%      +0.0        0.51 ±  6%      +0.0        0.50 ±  4%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.02 ±142%      +0.0        0.03 ± 86%      -0.0        0.01 ±244%  perf-profile.self.cycles-pp.free_pcppages_bulk
      3.52 ± 17%      +0.0        3.53 ± 11%      -0.3        3.23 ±  8%  perf-profile.self.cycles-pp.ktime_get
      0.18 ± 25%      +0.0        0.19 ± 15%      -0.0        0.17 ± 25%  perf-profile.self.cycles-pp.___might_sleep
      0.05 ± 47%      +0.0        0.06 ± 12%      +0.0        0.05 ± 70%  perf-profile.self.cycles-pp.sched_clock_tick
      0.15 ± 10%      +0.0        0.17 ± 24%      +0.0        0.17 ± 31%  perf-profile.self.cycles-pp.tick_sched_handle
      0.21 ± 12%      +0.0        0.22 ±  3%      +0.0        0.22 ± 10%  perf-profile.self.cycles-pp.call_cpuidle
      0.21 ±  8%      +0.0        0.22 ±  9%      +0.0        0.22 ± 10%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
      0.04 ± 71%      +0.0        0.05 ± 41%      +0.0        0.05        perf-profile.self.cycles-pp.cpuidle_select
      0.11 ± 33%      +0.0        0.13 ±  8%      -0.0        0.11 ± 18%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.03 ± 70%      +0.0        0.05 ± 41%      -0.0        0.03 ±127%  perf-profile.self.cycles-pp.intel_pmu_disable_all
      0.10 ± 39%      +0.0        0.11 ± 24%      -0.0        0.10 ± 25%  perf-profile.self.cycles-pp.security_file_permission
      0.15 ±  7%      +0.0        0.16 ± 10%      -0.0        0.14 ± 10%  perf-profile.self.cycles-pp.rcu_dynticks_task_exit
      0.27 ±  7%      +0.0        0.29 ±  8%      +0.0        0.29 ± 21%  perf-profile.self.cycles-pp.tick_sched_timer
      0.00            +0.0        0.01 ±158%      +0.0        0.00        perf-profile.self.cycles-pp.generic_write_checks
      0.00            +0.0        0.01 ±158%      +0.0        0.01 ±244%  perf-profile.self.cycles-pp.__intel_pmu_disable_all
      0.00            +0.0        0.01 ±158%      +0.0        0.01 ±158%  perf-profile.self.cycles-pp.__pagevec_lru_add
      0.10 ±  3%      +0.0        0.11 ± 15%      +0.0        0.11 ± 33%  perf-profile.self.cycles-pp.account_process_tick
      0.11 ± 11%      +0.0        0.12 ± 16%      +0.0        0.13 ± 32%  perf-profile.self.cycles-pp.update_rt_rq_load_avg
      0.02 ±144%      +0.0        0.04 ± 88%      +0.0        0.02 ±118%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.00            +0.0        0.02 ±159%      +0.0        0.01 ±244%  perf-profile.self.cycles-pp.memcpy_erms
      0.05 ± 51%      +0.0        0.07 ± 29%      -0.0        0.04 ± 67%  perf-profile.self.cycles-pp.dyntick_save_progress_counter
      0.15 ± 10%      +0.0        0.17 ± 10%      +0.0        0.17 ± 21%  perf-profile.self.cycles-pp.update_blocked_averages
      0.37 ± 45%      +0.0        0.39 ± 22%      +0.0        0.41 ± 30%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      1.61 ±  4%      +0.0        1.63 ±  7%      -0.1        1.54 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.22 ± 28%      +0.0        0.24 ± 35%      -0.0        0.20 ± 31%  perf-profile.self.cycles-pp.raise_softirq
      0.14 ±  2%      +0.0        0.16 ± 12%      +0.0        0.15 ± 14%  perf-profile.self.cycles-pp.tick_nohz_idle_got_tick
      0.07 ± 51%      +0.0        0.09 ± 40%      -0.0        0.07 ± 51%  perf-profile.self.cycles-pp.__fget_light
      0.10 ± 17%      +0.0        0.13 ± 14%      +0.0        0.11 ± 21%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.04 ±101%      +0.0        0.06 ± 47%      +0.0        0.06 ± 25%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.21 ±  6%      +0.0        0.23 ±  7%      +0.0        0.22 ± 25%  perf-profile.self.cycles-pp.load_balance
      0.19 ±  6%      +0.0        0.22 ±  9%      +0.0        0.24 ± 24%  perf-profile.self.cycles-pp.rb_erase
      0.14 ±  8%      +0.0        0.16 ± 10%      +0.0        0.17 ± 23%  perf-profile.self.cycles-pp.irq_work_tick
      0.44 ± 10%      +0.0        0.47 ± 11%      -0.0        0.42 ±  5%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      1.14 ± 20%      +0.0        1.17 ± 17%      -0.1        1.07 ± 14%  perf-profile.self.cycles-pp.update_process_times
      0.42 ±  3%      +0.0        0.46 ±  4%      -0.0        0.42 ±  2%  perf-profile.self.cycles-pp.tick_program_event
      0.06 ± 54%      +0.0        0.10 ± 33%      +0.0        0.10 ± 26%  perf-profile.self.cycles-pp.memcpy_toio
      0.19 ± 11%      +0.0        0.23 ±  9%      +0.0        0.20 ±  9%  perf-profile.self.cycles-pp.hrtimer_get_next_event
      0.19 ±  3%      +0.0        0.23 ±  7%      +0.0        0.19 ± 10%  perf-profile.self.cycles-pp.irqentry_enter
      1.55 ± 10%      +0.0        1.60 ± 10%      +0.0        1.57 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock
      0.03 ± 70%      +0.1        0.09 ± 16%      +0.0        0.06 ± 10%  perf-profile.self.cycles-pp.cpuidle_get_cpu_driver
      0.69 ± 11%      +0.1        0.75 ±  4%      -0.1        0.62 ± 11%  perf-profile.self.cycles-pp.irq_exit_rcu
      0.32 ±  5%      +0.1        0.39 ±  7%      +0.1        0.41 ± 31%  perf-profile.self.cycles-pp.rb_insert_color
      0.06 ± 47%      +0.1        0.13 ±  9%      +0.0        0.06 ± 42%  perf-profile.self.cycles-pp.cpumask_next_and
      0.00            +0.1        0.08 ± 18%      +0.0        0.00        perf-profile.self.cycles-pp.rcu_irq_exit
      0.62 ± 11%      +0.1        0.71 ± 25%      +0.0        0.62 ± 13%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.39 ±  9%      +0.1        0.48 ± 13%      +0.0        0.44 ± 26%  perf-profile.self.cycles-pp.hrtimer_forward
      0.34 ±  8%      +0.1        0.44 ±  5%      +0.1        0.40 ±  3%  perf-profile.self.cycles-pp.get_cpu_device
      0.47 ±  5%      +0.1        0.59 ±  5%      -0.0        0.46 ±  7%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.14 ±  9%      +0.1        0.26 ± 10%      -0.0        0.12 ± 10%  perf-profile.self.cycles-pp.rcu_core
      0.77 ±  5%      +0.1        0.92 ±  3%      -0.0        0.76 ±  6%  perf-profile.self.cycles-pp.tick_nohz_next_event
      2.38 ± 13%      +0.2        2.56 ± 13%      +0.4        2.76 ± 31%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.80 ± 21%      +0.2        0.99 ± 44%      -0.1        0.72 ± 28%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      3.38 ± 15%      +0.3        3.71 ± 16%      -0.0        3.36 ± 18%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.4        0.35 ±244%      +0.0        0.00        perf-profile.self.cycles-pp.poll_idle
      3.46 ± 21%      +1.1        4.60 ± 16%      +0.8        4.29 ± 26%  perf-profile.self.cycles-pp.menu_select
    434.50 ±  2%      +6.5%     462.71 ± 10%     +30.9%     568.71 ±  5%  softirqs.BLOCK
      9.00 ±223%      +1.6%       9.14 ±120%    +314.3%      37.29 ± 98%  softirqs.CPU0.BLOCK
      5.00            +0.0%       5.00            +0.0%       5.00        softirqs.CPU0.HI
      0.67 ± 70%     -35.7%       0.43 ±115%    -100.0%       0.00        softirqs.CPU0.NET_TX
     35776 ±  9%      +0.4%      35902 ±  6%      +1.0%      36130 ± 11%  softirqs.CPU0.RCU
     29141 ±  6%      -5.8%      27449 ± 14%      -9.0%      26530 ± 18%  softirqs.CPU0.SCHED
    147.00 ±  6%      -2.8%     142.86            -2.6%     143.14        softirqs.CPU0.TASKLET
      6844 ± 38%     -30.9%       4728 ± 75%     -60.7%       2688 ± 34%  softirqs.CPU0.TIMER
      3.00 ±152%     +57.1%       4.71 ±228%     -95.2%       0.14 ±244%  softirqs.CPU1.BLOCK
      0.00          -100.0%       0.00       +4.3e+101%       0.43 ±169%  softirqs.CPU1.NET_TX
     35084 ± 11%      +4.0%      36503 ±  7%      +0.7%      35345 ± 12%  softirqs.CPU1.RCU
     23986 ± 17%      -0.4%      23886 ± 21%     +10.1%      26403 ± 11%  softirqs.CPU1.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU1.TASKLET
      1027 ±130%     -26.1%     759.14 ±131%    +144.1%       2508 ±120%  softirqs.CPU1.TIMER
      0.17 ±223%    +928.6%       1.71 ±244%   +5385.7%       9.14 ±172%  softirqs.CPU10.BLOCK
     34948 ±  4%      -2.4%      34095 ±  3%     -10.3%      31358 ± 13%  softirqs.CPU10.RCU
     25984 ±  3%      -7.4%      24063 ± 19%      -3.3%      25133 ±  7%  softirqs.CPU10.SCHED
      2.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU10.TASKLET
     77.50 ± 11%      +7.8%      83.57 ± 41%     -17.6%      63.86 ± 26%  softirqs.CPU10.TIMER
      3.67 ±223%    -100.0%       0.00           +24.7%       4.57 ±189%  softirqs.CPU100.BLOCK
     28392            -2.2%      27767 ±  6%      -6.7%      26502 ± 10%  softirqs.CPU100.RCU
     26738           -14.7%      22807 ± 26%      -0.8%      26527        softirqs.CPU100.SCHED
    146.00 ±136%     -66.2%      49.29 ±103%     -76.3%      34.57 ± 33%  softirqs.CPU100.TIMER
      0.00       +2.9e+101%       0.29 ±244%   +1e+102%       1.00 ±244%  softirqs.CPU101.BLOCK
     28160            -1.9%      27626 ±  6%      -7.2%      26125 ±  8%  softirqs.CPU101.RCU
     26689            -4.0%      25627 ±  7%      +0.3%      26764        softirqs.CPU101.SCHED
      0.00          -100.0%       0.00       +2.3e+102%       2.29 ±244%  softirqs.CPU101.TASKLET
     43.33 ± 89%     -30.4%      30.14 ± 41%      +3.5%      44.86 ± 75%  softirqs.CPU101.TIMER
      2.50 ±206%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU102.BLOCK
     28592 ±  3%      -2.8%      27800 ±  5%      -7.6%      26407 ±  9%  softirqs.CPU102.RCU
     25946 ±  5%      +2.1%      26498            +1.6%      26365        softirqs.CPU102.SCHED
      0.00          -100.0%       0.00       +2.9e+102%       2.86 ±244%  softirqs.CPU102.TASKLET
    150.83 ±165%     -77.1%      34.57 ± 42%     -52.4%      71.86 ±128%  softirqs.CPU102.TIMER
      6.83 ±223%    -100.0%       0.00            -3.8%       6.57 ±244%  softirqs.CPU103.BLOCK
     29325 ±  8%      -4.3%      28052 ±  4%      -7.7%      27069 ± 13%  softirqs.CPU103.RCU
     26751            -1.8%      26260 ±  3%      -6.7%      24949 ± 15%  softirqs.CPU103.SCHED
     83.17 ±129%     -65.5%      28.71 ± 25%    +191.7%     242.57 ±213%  softirqs.CPU103.TIMER
      2.17 ±223%    -100.0%       0.00           -73.6%       0.57 ±158%  softirqs.CPU104.BLOCK
     29079            -7.0%      27051 ±  7%      -7.1%      27019 ±  8%  softirqs.CPU104.RCU
     23130 ± 25%      +4.9%      24260 ± 21%      +6.9%      24720 ± 16%  softirqs.CPU104.SCHED
     27.83 ± 23%   +4604.5%       1309 ±219%      -0.9%      27.57 ±  9%  softirqs.CPU104.TIMER
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU105.BLOCK
     28935 ±  2%      -6.9%      26931 ±  9%      -8.7%      26403 ±  9%  softirqs.CPU105.RCU
     25044 ± 16%      +6.2%      26598            +4.7%      26224 ±  5%  softirqs.CPU105.SCHED
     25.00 ± 29%   +7097.1%       1799 ±159%      +0.0%      25.00 ± 19%  softirqs.CPU105.TIMER
      0.00          -100.0%       0.00       +1.9e+102%       1.86 ±244%  softirqs.CPU106.BLOCK
     29505 ±  6%      -6.2%      27670 ±  6%     -12.1%      25944 ± 10%  softirqs.CPU106.RCU
     23598 ± 18%     +11.3%      26257 ±  3%     +12.0%      26434        softirqs.CPU106.SCHED
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU106.TASKLET
     36.00 ± 36%    +754.0%     307.43 ±200%   +2032.5%     767.71 ±232%  softirqs.CPU106.TIMER
      0.00       +7.1e+101%       0.71 ±244%    -100.0%       0.00        softirqs.CPU107.BLOCK
     28333            -1.9%      27783 ±  6%      -7.6%      26189 ±  9%  softirqs.CPU107.RCU
     26729            -8.2%      24540 ± 22%      -6.3%      25054 ± 16%  softirqs.CPU107.SCHED
     24.00 ± 15%    +757.7%     205.86 ±211%     +89.9%      45.57 ± 78%  softirqs.CPU107.TIMER
     30095 ±  7%      -5.2%      28531 ±  6%      -5.5%      28439 ±  4%  softirqs.CPU108.RCU
     24013 ± 23%      +9.1%      26194            +0.6%      24160 ± 21%  softirqs.CPU108.SCHED
     35.33 ± 30%      -3.0%      34.29 ± 49%      -5.0%      33.57 ± 33%  softirqs.CPU108.TIMER
      0.00       +2.7e+102%       2.71 ±244%    -100.0%       0.00        softirqs.CPU109.BLOCK
     28970            -1.7%      28479 ±  6%      -4.7%      27616 ±  9%  softirqs.CPU109.RCU
     24795 ± 15%      -2.3%      24216 ± 22%      -1.2%      24502 ± 19%  softirqs.CPU109.SCHED
     22.83 ± 10%     +44.5%      33.00 ± 85%    +347.3%     102.14 ±145%  softirqs.CPU109.TIMER
      4.67 ±223%     +43.9%       6.71 ±227%    -100.0%       0.00        softirqs.CPU11.BLOCK
     36.33            -0.1%      36.29            +1.0%      36.71        softirqs.CPU11.NET_TX
     34319 ±  6%      +0.6%      34520 ±  3%      -7.1%      31873 ±  9%  softirqs.CPU11.RCU
     24651 ± 18%      -0.7%      24471 ± 18%      -4.0%      23668 ± 20%  softirqs.CPU11.SCHED
      1.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU11.TASKLET
    328.67 ± 65%     -38.8%     201.29 ± 17%     -45.5%     179.29 ±  4%  softirqs.CPU11.TIMER
     28820 ±  2%      +0.5%      28969 ±  6%      -4.5%      27525 ± 13%  softirqs.CPU110.RCU
     24364 ± 20%      +4.0%      25326 ±  8%      +9.9%      26773        softirqs.CPU110.SCHED
     41.17 ± 55%     -16.0%      34.57 ± 52%   +1792.7%     779.14 ±156%  softirqs.CPU110.TIMER
     29062 ±  3%      -2.5%      28335 ±  6%      -8.4%      26615 ±  8%  softirqs.CPU111.RCU
     26453 ±  2%      -1.4%      26090 ±  4%      +1.0%      26727        softirqs.CPU111.SCHED
      0.00       +1.4e+102%       1.43 ±244%    -100.0%       0.00        softirqs.CPU111.TASKLET
     62.83 ±132%     -57.9%      26.43 ± 42%     +29.6%      81.43 ±161%  softirqs.CPU111.TIMER
      0.00       +3.9e+102%       3.86 ±244%    -100.0%       0.00        softirqs.CPU112.BLOCK
     29277 ±  3%      -4.6%      27932 ±  6%      -6.7%      27327 ±  9%  softirqs.CPU112.RCU
     26153 ±  4%      -6.9%      24361 ± 21%      +1.8%      26612        softirqs.CPU112.SCHED
      0.00       +2.9e+101%       0.29 ±244%    -100.0%       0.00        softirqs.CPU112.TASKLET
     68.00 ± 84%     -46.2%      36.57 ± 51%     -52.1%      32.57 ± 23%  softirqs.CPU112.TIMER
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU113.BLOCK
     28773            -2.6%      28034 ±  6%      -6.9%      26793 ±  9%  softirqs.CPU113.RCU
     26580            -0.1%      26543            -0.1%      26548        softirqs.CPU113.SCHED
     33.17 ± 48%     -32.4%      22.43 ± 15%      +1.7%      33.71 ± 33%  softirqs.CPU113.TIMER
      0.00       +1.9e+102%       1.86 ±244% +1.4e+102%       1.43 ±244%  softirqs.CPU114.BLOCK
     28732            -2.6%      27971 ±  6%      -7.2%      26657 ±  9%  softirqs.CPU114.RCU
     26709            -2.9%      25935 ±  4%      -0.6%      26552        softirqs.CPU114.SCHED
    248.83 ±134%     -32.4%     168.29 ±124%     -88.7%      28.14 ± 24%  softirqs.CPU114.TIMER
      0.00       +7.1e+101%       0.71 ±162%    -100.0%       0.00        softirqs.CPU115.BLOCK
     28054 ± 11%      +0.2%      28102 ±  7%      -4.4%      26828 ±  9%  softirqs.CPU115.RCU
     26096 ±  4%      +1.7%      26551           -10.0%      23476 ± 23%  softirqs.CPU115.SCHED
      2323 ±219%     -81.5%     430.43 ±223%     -98.7%      30.29 ± 54%  softirqs.CPU115.TIMER
      0.00       +8.6e+101%       0.86 ±244%    -100.0%       0.00        softirqs.CPU116.BLOCK
     28487            -2.1%      27879 ±  5%      -7.9%      26224 ±  9%  softirqs.CPU116.RCU
     23078 ± 23%      +6.2%      24514 ± 22%     +14.2%      26346 ±  2%  softirqs.CPU116.SCHED
     25.33 ± 29%    +800.6%     228.14 ±216%   +2366.5%     624.86 ±229%  softirqs.CPU116.TIMER
      0.00          -100.0%       0.00       +2.9e+101%       0.29 ±244%  softirqs.CPU117.BLOCK
     28733 ±  2%      +0.2%      28778 ±  8%      -8.0%      26429 ±  9%  softirqs.CPU117.RCU
     26783 ±  2%      -5.5%      25322 ± 10%      -0.3%      26697        softirqs.CPU117.SCHED
     25.33 ± 26%    +462.8%     142.57 ±145%    +313.3%     104.71 ±176%  softirqs.CPU117.TIMER
     28515 ±  2%      -2.2%      27879 ±  5%      -8.2%      26181 ±  9%  softirqs.CPU118.RCU
     26886            -1.7%      26438 ±  2%      -7.3%      24934 ± 17%  softirqs.CPU118.SCHED
     91.67 ±152%     -66.8%      30.43 ± 26%    +957.9%     969.71 ±144%  softirqs.CPU118.TIMER
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU119.BLOCK
     28638            -1.7%      28150 ±  6%      -9.6%      25887 ±  9%  softirqs.CPU119.RCU
     24315 ± 24%      +8.7%      26432            +8.8%      26461 ±  2%  softirqs.CPU119.SCHED
     27.67 ± 51%      +4.3%      28.86 ± 44%   +5089.3%       1435 ±191%  softirqs.CPU119.TIMER
      0.83 ±223%     -48.6%       0.43 ±244%    -100.0%       0.00        softirqs.CPU12.BLOCK
    870.50 ± 87%     -24.0%     661.57 ± 79%     +26.1%       1097 ± 54%  softirqs.CPU12.NET_RX
      1.83 ± 58%     +24.7%       2.29 ± 19%      +9.1%       2.00 ± 37%  softirqs.CPU12.NET_TX
     30950 ±  3%      +0.2%      31023 ±  4%      -4.1%      29686 ±  8%  softirqs.CPU12.RCU
     24174 ± 20%      +3.8%      25091 ±  7%      +7.6%      26016 ±  4%  softirqs.CPU12.SCHED
    143.83 ± 95%     -43.7%      81.00 ± 19%     -33.1%      96.29 ± 41%  softirqs.CPU12.TIMER
      0.33 ±223%    -100.0%       0.00          +114.3%       0.71 ±244%  softirqs.CPU120.BLOCK
     28462 ±  3%      -1.4%      28059 ±  5%      -6.7%      26548 ±  8%  softirqs.CPU120.RCU
     23950 ± 24%      +8.7%      26026 ±  3%      +8.3%      25937 ±  3%  softirqs.CPU120.SCHED
      1281 ±218%     -97.1%      37.14 ± 45%     -95.9%      53.00 ± 90%  softirqs.CPU120.TIMER
      0.00       +2.9e+101%       0.29 ±244% +2.6e+102%       2.57 ±244%  softirqs.CPU121.BLOCK
     28771            -2.2%      28130 ±  6%      -7.7%      26566 ±  8%  softirqs.CPU121.RCU
     23976 ± 25%     +10.9%      26590           +11.2%      26663        softirqs.CPU121.SCHED
    168.33 ±190%     -83.5%      27.86 ± 26%     -74.7%      42.57 ± 74%  softirqs.CPU121.TIMER
     28825 ±  2%      -3.1%      27931 ±  6%      -7.1%      26779 ±  9%  softirqs.CPU122.RCU
     26524            -9.5%      24008 ± 21%      +0.5%      26653        softirqs.CPU122.SCHED
     39.67 ± 55%    +551.1%     258.29 ±187%     -33.4%      26.43 ± 13%  softirqs.CPU122.TIMER
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU123.BLOCK
     28915 ±  2%      -3.2%      28000 ±  5%      -7.3%      26793 ±  9%  softirqs.CPU123.RCU
     26752            -6.1%      25111 ± 13%      -7.4%      24768 ± 18%  softirqs.CPU123.SCHED
      0.00          -100.0%       0.00       +4.3e+101%       0.43 ±244%  softirqs.CPU123.TASKLET
    221.67 ±198%     -39.9%     133.29 ±112%     -84.7%      34.00 ± 81%  softirqs.CPU123.TIMER
      1.17 ±223%    +438.8%       6.29 ±208%    -100.0%       0.00        softirqs.CPU124.BLOCK
     28583 ±  2%      -2.8%      27779 ±  5%      -5.7%      26942 ± 10%  softirqs.CPU124.RCU
     24184 ± 22%      +2.4%      24767 ± 18%      +2.4%      24767 ± 20%  softirqs.CPU124.SCHED
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU124.TASKLET
     26.17 ± 11%     +21.2%      31.71 ± 12%   +2759.1%     748.14 ±114%  softirqs.CPU124.TIMER
      4.17 ±142%    -100.0%       0.00          +102.3%       8.43 ±244%  softirqs.CPU125.BLOCK
     29849 ±  8%      -6.6%      27879 ±  5%     -11.6%      26382 ±  9%  softirqs.CPU125.RCU
     24034 ± 25%     -11.0%      21378 ± 31%      +0.7%      24214 ± 23%  softirqs.CPU125.SCHED
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU125.TASKLET
     40.83 ± 80%     -35.6%      26.29 ± 21%     +34.7%      55.00 ± 99%  softirqs.CPU125.TIMER
     10.17 ±116%      -5.9%       9.57 ±170%     -67.7%       3.29 ±244%  softirqs.CPU126.BLOCK
     28622 ±  3%      -2.4%      27922 ±  6%      -5.1%      27167 ± 12%  softirqs.CPU126.RCU
     26568            -8.0%      24440 ± 20%      -0.2%      26506        softirqs.CPU126.SCHED
      8.00 ±223%     -98.2%       0.14 ±244%    -100.0%       0.00        softirqs.CPU126.TASKLET
     47.67 ± 60%   +1977.2%     990.14 ±184%     -22.1%      37.14 ± 25%  softirqs.CPU126.TIMER
      0.00       +1.4e+102%       1.43 ±193% +1.3e+103%      12.71 ±244%  softirqs.CPU127.BLOCK
     28787            +1.0%      29061 ±  6%      -7.8%      26544 ±  9%  softirqs.CPU127.RCU
     13716 ± 17%      -3.0%      13300 ± 15%     -17.0%      11385 ±  5%  softirqs.CPU127.SCHED
     23.67 ±  9%   +3916.5%     950.57 ±157%      +9.3%      25.86 ± 14%  softirqs.CPU127.TIMER
      0.00          -100.0%       0.00       +6.3e+102%       6.29 ±244%  softirqs.CPU128.BLOCK
     27779            -1.1%      27478 ±  6%      -5.7%      26196 ±  8%  softirqs.CPU128.RCU
     24576 ± 20%     -12.3%      21547 ± 26%      -9.3%      22286 ± 26%  softirqs.CPU128.SCHED
    257.00 ±206%     -79.8%      51.86 ±106%     -85.1%      38.29 ±112%  softirqs.CPU128.TIMER
      4.50 ±223%     +46.0%       6.57 ±244%    -100.0%       0.00        softirqs.CPU129.BLOCK
     27926 ±  2%      -1.6%      27486 ±  6%      -6.9%      26002 ±  8%  softirqs.CPU129.RCU
     21859 ± 29%      +3.8%      22697 ± 26%      +1.5%      22187 ± 32%  softirqs.CPU129.SCHED
      1.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU129.TASKLET
    204.00 ±162%     -81.4%      37.86 ± 76%     -90.4%      19.57 ± 24%  softirqs.CPU129.TIMER
      0.33 ±223%   +1828.6%       6.43 ±244%   +5300.0%      18.00 ±244%  softirqs.CPU13.BLOCK
    862.50 ±111%    +209.5%       2669 ±122%    +309.9%       3535 ±165%  softirqs.CPU13.NET_RX
      2.33 ± 47%     -26.5%       1.71 ± 51%     -32.7%       1.57 ± 46%  softirqs.CPU13.NET_TX
     33493 ±  7%      -4.5%      31983 ±  4%      -9.8%      30205 ± 10%  softirqs.CPU13.RCU
     25892 ±  3%      +0.9%      26130 ±  4%      -4.5%      24727 ± 16%  softirqs.CPU13.SCHED
      0.00       +2.9e+101%       0.29 ±244%    -100.0%       0.00        softirqs.CPU13.TASKLET
     62.83 ± 33%     -30.0%      44.00 ± 14%    +418.4%     325.71 ±178%  softirqs.CPU13.TIMER
      3.00 ±195%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU130.BLOCK
     28378            -2.2%      27760 ±  7%      -3.1%      27507 ±  4%  softirqs.CPU130.RCU
     20311 ± 33%     +23.9%      25171 ± 15%     +28.6%      26121 ±  4%  softirqs.CPU130.SCHED
      0.00       +5.7e+102%       5.71 ±179%    -100.0%       0.00        softirqs.CPU130.TASKLET
     27.83 ± 43%     -10.7%      24.86 ± 39%    +141.7%      67.29 ± 85%  softirqs.CPU130.TIMER
      0.67 ±165%    -100.0%       0.00           -57.1%       0.29 ±244%  softirqs.CPU131.BLOCK
     28315            -0.4%      28192 ±  7%      -5.9%      26656 ±  9%  softirqs.CPU131.RCU
     22518 ± 28%     +18.6%      26705           +18.0%      26574 ±  2%  softirqs.CPU131.SCHED
      0.00       +1.2e+103%      12.43 ±158%    -100.0%       0.00        softirqs.CPU131.TASKLET
     20.67 ± 10%    +455.1%     114.71 ±197%    +104.6%      42.29 ±102%  softirqs.CPU131.TIMER
      8.50 ±223%     -91.6%       0.71 ±162%    -100.0%       0.00        softirqs.CPU132.BLOCK
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU132.NET_TX
     28669            -1.5%      28227 ±  6%      -7.5%      26528 ±  9%  softirqs.CPU132.RCU
     26526 ±  2%      -6.0%      24932 ± 21%      +0.6%      26675        softirqs.CPU132.SCHED
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU132.TASKLET
     30.00 ± 54%   +3199.0%     989.71 ±167%     -15.7%      25.29 ± 49%  softirqs.CPU132.TIMER
      5.17 ±223%     -22.6%       4.00 ±225%    -100.0%       0.00        softirqs.CPU133.BLOCK
     28608 ±  2%      -2.0%      28032 ±  7%      -7.1%      26577 ±  9%  softirqs.CPU133.RCU
     24843 ± 18%      +7.0%      26577            +7.3%      26654        softirqs.CPU133.SCHED
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU133.TASKLET
     17.33 ± 19%    +119.2%      38.00 ± 39%     +90.4%      33.00 ± 65%  softirqs.CPU133.TIMER
      7.00 ±182%    -100.0%       0.00           -63.3%       2.57 ±244%  softirqs.CPU134.BLOCK
     29319            -0.9%      29046 ±  9%      -6.3%      27482 ± 10%  softirqs.CPU134.RCU
     26695            -9.2%      24242 ± 23%     -10.0%      24029 ± 22%  softirqs.CPU134.SCHED
     23.33 ± 20%   +1548.8%     384.71 ±227%   +1125.1%     285.86 ±212%  softirqs.CPU134.TIMER
      5.67 ±186%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU135.BLOCK
     29430            -2.1%      28806 ±  6%      -7.5%      27208 ±  9%  softirqs.CPU135.RCU
     24054 ± 23%      +9.7%      26385            +8.8%      26159 ±  3%  softirqs.CPU135.SCHED
     26.33 ± 35%      -3.4%      25.43 ± 38%     +48.1%      39.00 ± 76%  softirqs.CPU135.TIMER
      0.00          -100.0%       0.00       +8.6e+101%       0.86 ±244%  softirqs.CPU136.BLOCK
     28614 ±  2%      -0.4%      28498 ±  7%      -1.1%      28298 ± 16%  softirqs.CPU136.RCU
     26676            -0.6%      26520            -3.5%      25734 ±  5%  softirqs.CPU136.SCHED
      1.33 ±223%     +28.6%       1.71 ±244%    -100.0%       0.00        softirqs.CPU136.TASKLET
    369.50 ±209%     -21.6%     289.71 ±220%     -88.0%      44.29 ± 85%  softirqs.CPU136.TIMER
     28647 ±  2%      -2.1%      28036 ±  5%      -5.0%      27222 ± 10%  softirqs.CPU137.RCU
     26581            -8.3%      24386 ± 22%      -9.0%      24198 ± 22%  softirqs.CPU137.SCHED
      2.00 ±223%     -92.9%       0.14 ±244%     -50.0%       1.00 ±244%  softirqs.CPU137.TASKLET
    156.67 ±188%     -77.8%      34.71 ± 95%     -79.5%      32.14 ± 51%  softirqs.CPU137.TIMER
      0.00          -100.0%       0.00       +4.3e+101%       0.43 ±244%  softirqs.CPU138.BLOCK
     28618            -2.2%      27984 ±  6%      -7.5%      26467 ±  9%  softirqs.CPU138.RCU
     26608            -0.6%      26456            -0.8%      26407        softirqs.CPU138.SCHED
      4.83 ±223%     -97.0%       0.14 ±244%    -100.0%       0.00        softirqs.CPU138.TASKLET
     24.83 ± 40%     +48.4%      36.86 ±115%     +27.1%      31.57 ± 86%  softirqs.CPU138.TIMER
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU139.BLOCK
     28519 ±  2%      -1.5%      28089 ±  5%      -5.2%      27048 ±  8%  softirqs.CPU139.RCU
     23908 ± 24%      +5.2%      25158 ± 11%      +8.0%      25827 ±  7%  softirqs.CPU139.SCHED
     34.00 ± 64%     -33.2%      22.71 ± 37%    +138.2%      81.00 ±174%  softirqs.CPU139.TIMER
      0.00          -100.0%       0.00       +2.1e+102%       2.14 ±244%  softirqs.CPU14.BLOCK
    710.83 ± 32%    +695.1%       5651 ±115%    +672.8%       5493 ±168%  softirqs.CPU14.NET_RX
      2.17 ± 31%      -7.7%       2.00 ± 37%      -7.7%       2.00 ± 37%  softirqs.CPU14.NET_TX
     31345 ±  4%      +0.3%      31434 ±  6%      -1.8%      30782 ± 10%  softirqs.CPU14.RCU
     26087 ±  4%      -0.2%      26030 ±  5%      +4.8%      27349 ±  6%  softirqs.CPU14.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU14.TASKLET
    123.00 ± 40%     -25.3%      91.86 ± 35%    +590.5%     849.29 ±187%  softirqs.CPU14.TIMER
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU140.BLOCK
     28289            -0.5%      28158 ± 10%      -7.1%      26272 ±  8%  softirqs.CPU140.RCU
     22786 ± 24%     +11.9%      25496 ± 10%     +17.3%      26717        softirqs.CPU140.SCHED
     27.83 ± 64%      +8.8%      30.29 ± 60%    +104.3%      56.86 ±154%  softirqs.CPU140.TIMER
      0.00       +4.3e+101%       0.43 ±244% +2.9e+101%       0.29 ±244%  softirqs.CPU141.BLOCK
     28345 ±  2%      -3.8%      27271 ±  3%      -7.0%      26369 ±  8%  softirqs.CPU141.RCU
     26712            -0.6%      26560            -0.4%      26596        softirqs.CPU141.SCHED
     31.50 ± 44%     -25.6%      23.43 ± 11%     +66.0%      52.29 ±141%  softirqs.CPU141.TIMER
      0.00       +1.4e+101%       0.14 ±244% +8.7e+102%       8.71 ±244%  softirqs.CPU142.BLOCK
     28085 ±  2%      -2.5%      27376 ±  5%      -7.2%      26050 ±  9%  softirqs.CPU142.RCU
     26623            +0.0%      26631            -0.2%      26573        softirqs.CPU142.SCHED
     42.67 ±129%     -59.5%      17.29 ± 17%     -34.7%      27.86 ± 70%  softirqs.CPU142.TIMER
      0.00          -100.0%       0.00       +5.1e+102%       5.14 ±244%  softirqs.CPU143.BLOCK
     27934 ±  2%      +1.6%      28380 ± 14%      -6.6%      26096 ±  9%  softirqs.CPU143.RCU
     24145 ± 24%      +1.2%      24442 ± 21%     +10.6%      26697        softirqs.CPU143.SCHED
     32.33 ± 75%    +130.6%      74.57 ±159%      -5.9%      30.43 ± 37%  softirqs.CPU143.TIMER
      0.00       +1.1e+102%       1.14 ±244%    -100.0%       0.00        softirqs.CPU144.BLOCK
     27740            -1.3%      27381 ±  6%      -2.3%      27111 ± 13%  softirqs.CPU144.RCU
     26860            -8.7%      24513 ± 22%      -6.3%      25169 ±  9%  softirqs.CPU144.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU144.TASKLET
     42.67 ± 84%     -48.1%      22.14 ± 20%     -31.7%      29.14 ± 53%  softirqs.CPU144.TIMER
      0.17 ±223%    -100.0%       0.00           +71.4%       0.29 ±244%  softirqs.CPU145.BLOCK
     27902            +1.4%      28283 ±  9%      -6.8%      25993 ±  9%  softirqs.CPU145.RCU
     24054 ± 24%      +9.8%      26417            +4.6%      25169 ± 14%  softirqs.CPU145.SCHED
     27.67 ± 14%     +10.5%      30.57 ± 32%     +37.3%      38.00 ± 70%  softirqs.CPU145.TIMER
      0.67 ±223%    -100.0%       0.00          +500.0%       4.00 ±244%  softirqs.CPU146.BLOCK
     31208 ±  2%      -6.5%      29166 ±  6%      -9.4%      28287 ±  9%  softirqs.CPU146.RCU
     23929 ± 24%      +9.9%      26291           +10.3%      26398        softirqs.CPU146.SCHED
     19.00 ±  9%   +4523.3%     878.43 ±238%   +2151.9%     427.86 ±232%  softirqs.CPU146.TIMER
     15.00 ±223%    -100.0%       0.00           -92.4%       1.14 ±244%  softirqs.CPU147.BLOCK
     30472            -3.9%      29298 ±  7%      -6.2%      28592 ± 11%  softirqs.CPU147.RCU
     24290 ± 21%      -7.9%      22372 ± 27%      -0.7%      24125 ± 18%  softirqs.CPU147.SCHED
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU147.TASKLET
     24.00 ± 23%   +1897.6%     479.43 ±234%     +10.7%      26.57 ± 36%  softirqs.CPU147.TIMER
     28235 ±  3%      -1.7%      27745 ±  6%      -5.5%      26681 ± 10%  softirqs.CPU148.RCU
     26355 ±  3%      +0.9%      26591            -0.3%      26287 ±  2%  softirqs.CPU148.SCHED
     19.33 ± 21%    +144.6%      47.29 ±148%    +359.6%      88.86 ±171%  softirqs.CPU148.TIMER
     28404 ±  2%      -1.7%      27920 ±  6%      -7.0%      26409 ±  9%  softirqs.CPU149.RCU
     26577            -5.9%      24997 ± 16%      -6.4%      24872 ± 16%  softirqs.CPU149.SCHED
     20.33 ± 23%    +207.0%      62.43 ±156%    +660.2%     154.57 ±210%  softirqs.CPU149.TIMER
      0.00       +3.7e+102%       3.71 ±244% +7.3e+102%       7.29 ±233%  softirqs.CPU15.BLOCK
      3247 ± 78%     +35.4%       4396 ±135%     -66.7%       1082 ± 33%  softirqs.CPU15.NET_RX
      2.17 ± 41%     -47.3%       1.14 ± 30%     -20.9%       1.71 ± 26%  softirqs.CPU15.NET_TX
     34207 ±  5%      -6.9%      31854 ±  7%     -11.4%      30319 ± 10%  softirqs.CPU15.RCU
     26524 ±  3%      -5.9%      24967 ± 18%      -9.3%      24057 ± 19%  softirqs.CPU15.SCHED
    311.17 ±182%     -86.1%      43.29 ± 18%     -83.7%      50.86 ± 29%  softirqs.CPU15.TIMER
      0.00       +1.7e+102%       1.71 ±201% +4.3e+101%       0.43 ±244%  softirqs.CPU150.BLOCK
     30570 ±  2%      -5.0%      29042 ±  4%      -8.5%      27982 ±  9%  softirqs.CPU150.RCU
     25510 ±  6%      -7.5%      23607 ± 19%      +3.8%      26492        softirqs.CPU150.SCHED
     26.67 ± 52%     -19.6%      21.43 ± 14%     +10.4%      29.43 ± 66%  softirqs.CPU150.TIMER
      1.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU151.BLOCK
     29982            -3.5%      28918 ±  4%      -6.6%      28015 ±  9%  softirqs.CPU151.RCU
     26588           -25.1%      19905 ± 37%      -0.6%      26436        softirqs.CPU151.SCHED
     28.17 ± 60%     -21.4%      22.14 ± 18%     +67.9%      47.29 ± 93%  softirqs.CPU151.TIMER
      0.00       +2.9e+101%       0.29 ±244% +4.4e+102%       4.43 ±111%  softirqs.CPU152.BLOCK
     30636            -4.4%      29291 ±  4%      -7.6%      28295 ±  9%  softirqs.CPU152.RCU
     24088 ± 23%      +9.3%      26317            +9.7%      26419        softirqs.CPU152.SCHED
     18.50 ± 12%     +22.0%      22.57 ± 21%      +2.7%      19.00 ± 25%  softirqs.CPU152.TIMER
      0.00       +1.8e+103%      18.29 ±205%    -100.0%       0.00        softirqs.CPU153.BLOCK
     30641            -3.7%      29494 ±  4%      -6.9%      28518 ±  9%  softirqs.CPU153.RCU
     26581            -1.0%      26311            -9.2%      24130 ± 20%  softirqs.CPU153.SCHED
      0.00          -100.0%       0.00       +5.6e+102%       5.57 ±244%  softirqs.CPU153.TASKLET
     21.17 ± 24%     +10.0%      23.29 ± 39%     +78.2%      37.71 ± 62%  softirqs.CPU153.TIMER
      0.00          -100.0%       0.00       +1.3e+102%       1.29 ±214%  softirqs.CPU154.BLOCK
     27441            +1.2%      27773 ±  7%      -6.6%      25641 ±  9%  softirqs.CPU154.RCU
     26804           -13.1%      23303 ± 24%      -8.7%      24459 ± 22%  softirqs.CPU154.SCHED
     17.83 ± 16%     +53.0%      27.29 ± 49%    +216.4%      56.43 ±137%  softirqs.CPU154.TIMER
     27704            -1.5%      27276 ±  6%      -6.6%      25874 ±  9%  softirqs.CPU155.RCU
     26752            -0.9%      26501 ±  2%     -16.8%      22256 ± 32%  softirqs.CPU155.SCHED
     22.67 ± 12%     +14.1%      25.86 ± 23%    +238.4%      76.71 ±118%  softirqs.CPU155.TIMER
      0.00          -100.0%       0.00       +4.6e+102%       4.57 ±168%  softirqs.CPU156.BLOCK
     28990 ±  2%      +0.4%      29104 ±  8%      -6.4%      27123 ± 10%  softirqs.CPU156.RCU
     26751            -2.8%      26006 ±  5%      -1.2%      26437 ±  2%  softirqs.CPU156.SCHED
      1.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU156.TASKLET
     24.50 ± 51%    +104.7%      50.14 ± 97%      -2.6%      23.86 ± 27%  softirqs.CPU156.TIMER
      0.00       +2.9e+101%       0.29 ±244% +9.4e+102%       9.43 ±164%  softirqs.CPU157.BLOCK
     29153 ±  2%      -0.8%      28913 ±  7%      -7.2%      27054 ±  9%  softirqs.CPU157.RCU
     26527            -6.3%      24851 ± 16%      +0.5%      26658        softirqs.CPU157.SCHED
      2.83 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU157.TASKLET
     27.00 ± 35%    +180.4%      75.71 ± 84%     +14.3%      30.86 ± 50%  softirqs.CPU157.TIMER
      0.50 ±223%    +728.6%       4.14 ±244%     -71.4%       0.14 ±244%  softirqs.CPU158.BLOCK
     28301 ±  2%      -1.6%      27839 ±  5%      -6.4%      26492 ± 10%  softirqs.CPU158.RCU
     26721            -7.4%      24752 ± 16%      -4.4%      25534 ±  7%  softirqs.CPU158.SCHED
    115.50 ±180%     +83.8%     212.29 ±183%     -38.0%      71.57 ±154%  softirqs.CPU158.TIMER
     27743 ±  6%      +0.2%      27785 ±  5%      -4.0%      26626 ± 10%  softirqs.CPU159.RCU
     24149 ± 24%      -0.9%      23925 ± 21%      -0.1%      24133 ± 21%  softirqs.CPU159.SCHED
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU159.TASKLET
      1352 ±219%     -66.4%     455.14 ±223%     -95.2%      64.57 ± 93%  softirqs.CPU159.TIMER
      1.50 ±195%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU16.BLOCK
     35643 ±  4%      -5.3%      33739           -10.6%      31850 ± 13%  softirqs.CPU16.RCU
     23139 ± 22%      +4.9%      24267 ± 18%      +8.4%      25083 ±  7%  softirqs.CPU16.SCHED
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU16.TASKLET
    162.67 ± 67%     -30.6%     112.86 ± 17%    +314.3%     673.86 ±209%  softirqs.CPU16.TIMER
      2.50 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU160.BLOCK
     28608            -3.5%      27600 ±  4%      -7.3%      26526 ±  9%  softirqs.CPU160.RCU
     26660            -0.3%      26579            -8.1%      24506 ± 22%  softirqs.CPU160.SCHED
     20.67 ± 11%      +0.2%      20.71 ± 19%    +824.2%     191.00 ±155%  softirqs.CPU160.TIMER
      9.83 ±223%     -98.5%       0.14 ±244%     -33.2%       6.57 ±244%  softirqs.CPU161.BLOCK
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU161.NET_TX
     28560 ±  2%      -1.5%      28125 ±  7%      -7.1%      26519 ±  9%  softirqs.CPU161.RCU
     26822            -1.8%      26330 ±  5%     -13.3%      23252 ± 23%  softirqs.CPU161.SCHED
     29.33 ± 41%   +3344.2%       1010 ±237%    +743.5%     247.43 ±147%  softirqs.CPU161.TIMER
      0.00       +6.3e+102%       6.29 ±168% +1.4e+102%       1.43 ±193%  softirqs.CPU162.BLOCK
     28832            -2.9%      27999 ±  6%      -7.4%      26692 ±  9%  softirqs.CPU162.RCU
     23758 ± 25%     +11.8%      26553           +10.6%      26277 ±  3%  softirqs.CPU162.SCHED
     41.83 ±117%     -38.9%      25.57 ± 18%     -46.0%      22.57 ± 18%  softirqs.CPU162.TIMER
     28745 ±  2%      -3.0%      27894 ±  5%      -7.6%      26560 ±  8%  softirqs.CPU163.RCU
     26466 ±  2%      +0.1%      26502            +0.4%      26565        softirqs.CPU163.SCHED
     27.83 ± 28%      +0.1%      27.86 ± 28%     +22.2%      34.00 ± 69%  softirqs.CPU163.TIMER
      5.83 ±223%     -80.4%       1.14 ±183%     -92.7%       0.43 ±244%  softirqs.CPU164.BLOCK
     28429 ±  3%      -3.4%      27458 ±  6%      -8.5%      26021 ±  9%  softirqs.CPU164.RCU
     26900 ±  2%     -23.7%      20528 ± 34%      -1.0%      26623        softirqs.CPU164.SCHED
    404.00 ±199%     -95.2%      19.43 ± 11%     -94.4%      22.43 ± 14%  softirqs.CPU164.TIMER
      0.00          -100.0%       0.00       +7.1e+102%       7.14 ±216%  softirqs.CPU165.BLOCK
     28226 ±  3%      -4.0%      27111 ±  4%      -8.4%      25866 ±  9%  softirqs.CPU165.RCU
     27029            -2.2%      26426            -1.5%      26625        softirqs.CPU165.SCHED
    364.00 ±164%     -88.9%      40.43 ±109%     -89.8%      37.14 ± 69%  softirqs.CPU165.TIMER
      0.33 ±223%    +971.4%       3.57 ±244%    -100.0%       0.00        softirqs.CPU166.BLOCK
     28637 ±  4%      -3.9%      27525 ±  5%      -8.9%      26097 ±  9%  softirqs.CPU166.RCU
     25817 ±  6%      -3.9%      24804 ± 16%      +2.7%      26513        softirqs.CPU166.SCHED
      0.00       +1.4e+101%       0.14 ±244% +3.9e+102%       3.86 ±244%  softirqs.CPU166.TASKLET
     74.00 ±143%     -69.9%      22.29 ± 62%     -28.4%      53.00 ± 89%  softirqs.CPU166.TIMER
      0.17 ±223%     -14.3%       0.14 ±244%   +6842.9%      11.57 ±221%  softirqs.CPU167.BLOCK
     27467 ±  5%      +2.0%      28026 ±  4%      -5.7%      25911 ±  9%  softirqs.CPU167.RCU
     23984 ± 25%      +2.7%      24633 ± 16%      +9.3%      26220        softirqs.CPU167.SCHED
      1301 ±217%     -97.0%      38.86 ± 91%     -97.3%      35.71 ± 92%  softirqs.CPU167.TIMER
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU168.BLOCK
     30267 ±  3%      -3.6%      29172 ±  4%      -7.6%      27957 ± 10%  softirqs.CPU168.RCU
     26161 ±  4%     -15.5%      22107 ± 31%      -5.6%      24691 ± 16%  softirqs.CPU168.SCHED
     21.33 ± 32%   +4754.2%       1035 ±239%      -4.2%      20.43 ± 15%  softirqs.CPU168.TIMER
      4.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU169.BLOCK
     29677            -2.5%      28946 ±  5%      -6.7%      27690 ±  9%  softirqs.CPU169.RCU
     26439            -0.3%      26362            -7.2%      24528 ± 19%  softirqs.CPU169.SCHED
     19.33 ± 26%    +610.1%     137.29 ±194%     +17.5%      22.71 ± 17%  softirqs.CPU169.TIMER
      4.83 ±137%     -17.2%       4.00 ±244%    +201.5%      14.57 ±177%  softirqs.CPU17.BLOCK
      7.00 ± 14%      +2.0%       7.14 ± 18%     +12.2%       7.86 ± 15%  softirqs.CPU17.NET_RX
      0.33 ±223%    -100.0%       0.00           -57.1%       0.14 ±244%  softirqs.CPU17.NET_TX
     35148 ±  3%      -5.0%      33374 ±  5%     -13.9%      30269 ± 17%  softirqs.CPU17.RCU
     26015 ±  2%      -5.6%      24563 ± 13%      -6.7%      24263 ± 17%  softirqs.CPU17.SCHED
     55.67 ± 22%      -5.0%      52.86 ± 14%   +5473.5%       3102 ±166%  softirqs.CPU17.TIMER
      0.00          -100.0%       0.00       +5.7e+101%       0.57 ±244%  softirqs.CPU170.BLOCK
     28608 ±  4%      -3.8%      27532 ±  6%      -9.6%      25848 ±  9%  softirqs.CPU170.RCU
     22513 ± 21%     +21.5%      27344 ±  6%     +19.1%      26824        softirqs.CPU170.SCHED
      0.00          -100.0%       0.00       +3.4e+102%       3.43 ±244%  softirqs.CPU170.TASKLET
     24.00 ± 30%     +20.8%      29.00 ± 90%     +85.7%      44.57 ± 85%  softirqs.CPU170.TIMER
      0.00       +1.3e+103%      13.00 ±244%    -100.0%       0.00        softirqs.CPU171.BLOCK
     27805            -1.6%      27354 ±  6%      -7.8%      25625 ±  9%  softirqs.CPU171.RCU
     25228 ± 16%      +5.6%      26631            -0.7%      25061 ± 16%  softirqs.CPU171.SCHED
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU171.TASKLET
     34.17 ± 56%    +129.1%      78.29 ±117%     -23.9%      26.00 ± 22%  softirqs.CPU171.TIMER
      1.67 ±175%    -100.0%       0.00           -31.4%       1.14 ±244%  softirqs.CPU172.BLOCK
     29215            -3.3%      28243 ±  4%      -5.8%      27507 ±  9%  softirqs.CPU172.RCU
     26554            -0.7%      26366            -0.5%      26419        softirqs.CPU172.SCHED
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU172.TASKLET
     55.33 ±125%     -63.1%      20.43 ± 20%     -31.1%      38.14 ± 61%  softirqs.CPU172.TIMER
     29038            -1.8%      28510 ±  5%      -6.4%      27167 ±  9%  softirqs.CPU173.RCU
     24825 ± 15%      +6.8%      26513            +6.3%      26385        softirqs.CPU173.SCHED
     19.17 ± 10%    +857.8%     183.57 ±173%     +58.0%      30.29 ± 34%  softirqs.CPU173.TIMER
      0.00       +3.6e+102%       3.57 ±244% +6.6e+102%       6.57 ±244%  softirqs.CPU174.BLOCK
     28268            -0.5%      28122 ±  5%      -5.7%      26659 ± 10%  softirqs.CPU174.RCU
     24159 ± 23%      -8.1%      22206 ± 26%      +1.0%      24403 ± 22%  softirqs.CPU174.SCHED
      0.00       +5.7e+102%       5.71 ±244%    -100.0%       0.00        softirqs.CPU174.TASKLET
     29.83 ± 44%     -16.7%      24.86 ± 72%   +1113.9%     362.14 ±183%  softirqs.CPU174.TIMER
      0.00          -100.0%       0.00       +4.1e+102%       4.14 ±244%  softirqs.CPU175.BLOCK
     28615 ±  5%      -0.6%      28450 ±  9%     -10.4%      25634 ±  9%  softirqs.CPU175.RCU
     26110 ±  5%      -2.1%      25559 ±  9%      +2.4%      26749        softirqs.CPU175.SCHED
      0.00       +7.1e+101%       0.71 ±244%    -100.0%       0.00        softirqs.CPU175.TASKLET
     26.17 ± 38%     +24.5%      32.57 ± 51%   +3786.1%       1016 ±232%  softirqs.CPU175.TIMER
      7.17 ±223%      +1.7%       7.29 ±175%     -14.3%       6.14 ±244%  softirqs.CPU176.BLOCK
     28514 ±  3%      -3.0%      27667 ±  5%      -8.5%      26102 ±  9%  softirqs.CPU176.RCU
     26142 ±  4%      -6.1%      24541 ± 21%      +2.6%      26827        softirqs.CPU176.SCHED
      0.00       +4.3e+101%       0.43 ±244%    -100.0%       0.00        softirqs.CPU176.TASKLET
     24.67 ± 28%     -17.8%      20.29 ± 34%     +63.3%      40.29 ± 91%  softirqs.CPU176.TIMER
      0.17 ±223%    +928.6%       1.71 ±244%   +2985.7%       5.14 ±115%  softirqs.CPU177.BLOCK
     28374            +0.2%      28434 ±  8%      -7.4%      26285 ±  9%  softirqs.CPU177.RCU
     26391            -5.4%      24960 ± 16%      +0.7%      26565        softirqs.CPU177.SCHED
     20.83 ± 15%      +9.0%      22.71 ± 16%     +20.0%      25.00 ± 36%  softirqs.CPU177.TIMER
      0.33 ±223%    +242.9%       1.14 ±244%    +200.0%       1.00 ±244%  softirqs.CPU178.BLOCK
     28301 ±  2%      -3.0%      27447 ±  6%      -7.8%      26105 ±  9%  softirqs.CPU178.RCU
     26570            -7.8%      24490 ± 21%      -0.0%      26567        softirqs.CPU178.SCHED
      0.00          -100.0%       0.00       +2.9e+101%       0.29 ±244%  softirqs.CPU178.TASKLET
     39.83 ± 66%    +484.9%     233.00 ±216%    +611.5%     283.43 ±227%  softirqs.CPU178.TIMER
      0.00       +5.7e+102%       5.71 ±244% +2.9e+101%       0.29 ±244%  softirqs.CPU179.BLOCK
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU179.NET_TX
     29396 ±  8%      -6.0%      27641 ±  5%     -11.4%      26038 ±  9%  softirqs.CPU179.RCU
     25617 ±  9%      +3.9%      26613            +3.7%      26568        softirqs.CPU179.SCHED
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU179.TASKLET
     29.00 ± 58%    +125.1%      65.29 ±157%    +840.9%     272.86 ±227%  softirqs.CPU179.TIMER
      4.00 ±192%    -100.0%       0.00          +646.4%      29.86 ±148%  softirqs.CPU18.BLOCK
      7.00 ± 14%      +2.0%       7.14 ± 18%     +12.2%       7.86 ± 15%  softirqs.CPU18.NET_RX
     33335 ±  6%      -7.1%      30958 ±  6%     -12.2%      29270 ± 11%  softirqs.CPU18.RCU
     25579 ±  3%      -4.5%      24422 ± 15%      +4.1%      26626 ±  2%  softirqs.CPU18.SCHED
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU18.TASKLET
    112.17 ± 51%    +133.5%     261.86 ±153%    +394.2%     554.29 ±164%  softirqs.CPU18.TIMER
      0.00       +7.1e+101%       0.71 ±244%    -100.0%       0.00        softirqs.CPU180.BLOCK
     28366 ±  2%      -3.0%      27522 ±  5%      -8.3%      26009 ±  9%  softirqs.CPU180.RCU
     22329 ± 29%      +9.9%      24541 ± 19%      +9.9%      24550 ± 23%  softirqs.CPU180.SCHED
     19.83 ± 10%      -0.6%      19.71 ± 22%   +2509.6%     517.57 ±228%  softirqs.CPU180.TIMER
      0.00          -100.0%       0.00       +1.7e+102%       1.71 ±244%  softirqs.CPU181.BLOCK
     28416            -1.0%      28119 ±  5%      -8.0%      26147 ± 10%  softirqs.CPU181.RCU
     26555 ±  2%      -2.6%      25857 ±  4%      +0.5%      26696        softirqs.CPU181.SCHED
     23.67 ± 13%      +3.8%      24.57 ± 29%   +1474.8%     372.71 ±214%  softirqs.CPU181.TIMER
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU182.BLOCK
     28200            -2.1%      27615 ±  6%      -8.5%      25808 ±  9%  softirqs.CPU182.RCU
     24373 ± 23%      +8.9%      26550 ±  2%      +9.3%      26636        softirqs.CPU182.SCHED
     22.83 ± 16%      -2.4%      22.29 ± 29%   +1044.3%     261.29 ±220%  softirqs.CPU182.TIMER
      0.00          -100.0%       0.00       +4.4e+102%       4.43 ±163%  softirqs.CPU183.BLOCK
     28278            -0.8%      28050 ±  7%      -5.2%      26800 ± 11%  softirqs.CPU183.RCU
     24345 ± 23%      +9.5%      26646            +9.9%      26760        softirqs.CPU183.SCHED
     26.83 ± 58%     +11.3%      29.86 ± 19%      +5.9%      28.43 ± 65%  softirqs.CPU183.TIMER
      0.00         +1e+102%       1.00 ±244% +4.3e+102%       4.29 ±244%  softirqs.CPU184.BLOCK
     28269 ±  2%      -2.2%      27636 ±  5%      -7.6%      26108 ±  9%  softirqs.CPU184.RCU
     24038 ± 24%     +10.8%      26630            +3.1%      24785 ± 20%  softirqs.CPU184.SCHED
    225.83 ±187%     -91.6%      18.86 ±  7%     -90.4%      21.57 ± 29%  softirqs.CPU184.TIMER
      0.33 ±223%   +1400.0%       5.00 ±200%    +371.4%       1.57 ±244%  softirqs.CPU185.BLOCK
     27856 ±  3%      -0.5%      27727 ±  6%      -6.2%      26133 ±  9%  softirqs.CPU185.RCU
     26577            +0.7%      26755            +0.5%      26718        softirqs.CPU185.SCHED
      0.00       +2.9e+101%       0.29 ±244%    -100.0%       0.00        softirqs.CPU185.TASKLET
    923.67 ±218%     -43.7%     520.43 ±230%     -97.8%      20.57 ± 18%  softirqs.CPU185.TIMER
      0.00       +1.6e+102%       1.57 ±244%    -100.0%       0.00        softirqs.CPU186.BLOCK
     28420 ±  2%      -1.4%      28022 ±  6%      -7.6%      26248 ±  9%  softirqs.CPU186.RCU
     24239 ± 24%     +10.5%      26794            +1.3%      24556 ± 21%  softirqs.CPU186.SCHED
      0.00          -100.0%       0.00       +8.3e+102%       8.29 ±244%  softirqs.CPU186.TASKLET
     53.17 ±133%    +391.2%     261.14 ±218%     -60.2%      21.14 ± 17%  softirqs.CPU186.TIMER
     28336            -2.1%      27728 ±  5%      -7.3%      26262 ±  9%  softirqs.CPU187.RCU
     24833 ± 17%      +7.6%      26721            -0.7%      24663 ± 20%  softirqs.CPU187.SCHED
     37.83 ± 96%     +39.7%      52.86 ± 99%     -23.0%      29.14 ± 41%  softirqs.CPU187.TIMER
      8.83 ±175%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU188.BLOCK
     28368 ±  2%      -2.7%      27598 ±  6%      -7.5%      26238 ±  9%  softirqs.CPU188.RCU
     26817            -7.0%      24934 ± 18%      -0.5%      26684        softirqs.CPU188.SCHED
     34.00 ± 92%     -26.9%      24.86 ± 24%    +641.6%     252.14 ±184%  softirqs.CPU188.TIMER
      6.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU189.BLOCK
     28228 ±  2%      -2.0%      27656 ±  5%      -8.0%      25977 ±  9%  softirqs.CPU189.RCU
     26724            -8.3%      24498 ± 21%      -0.1%      26703        softirqs.CPU189.SCHED
     19.33 ± 33%    +140.9%      46.57 ±105%     +96.6%      38.00 ± 89%  softirqs.CPU189.TIMER
      0.33 ±223%   +1142.9%       4.14 ±244%     +28.6%       0.43 ±244%  softirqs.CPU19.BLOCK
      7.00 ± 14%      +2.0%       7.14 ± 18%     +12.2%       7.86 ± 15%  softirqs.CPU19.NET_RX
     31168 ±  3%      -4.2%      29861 ±  7%      -4.0%      29912 ± 16%  softirqs.CPU19.RCU
     26602           -20.4%      21183 ± 30%     -11.6%      23503 ± 16%  softirqs.CPU19.SCHED
     83.83 ±100%   +2018.0%       1775 ±156%   +1613.1%       1436 ±233%  softirqs.CPU19.TIMER
      5.83 ±145%     -82.9%       1.00 ±244%     -65.7%       2.00 ±207%  softirqs.CPU190.BLOCK
     28077 ±  2%      -1.6%      27619 ±  5%      -5.5%      26522 ± 11%  softirqs.CPU190.RCU
     21805 ± 32%     +22.0%      26598           +22.1%      26617        softirqs.CPU190.SCHED
     21.00 ± 21%    +374.1%      99.57 ±161%     +15.6%      24.29 ± 62%  softirqs.CPU190.TIMER
      0.00          -100.0%       0.00       +4.4e+102%       4.43 ±244%  softirqs.CPU191.BLOCK
     28414 ±  2%      -2.5%      27718 ±  6%      -7.3%      26343 ±  9%  softirqs.CPU191.RCU
     12812 ± 17%      +0.9%      12922 ± 19%      -9.6%      11580 ± 14%  softirqs.CPU191.SCHED
     21.50 ± 20%    +242.2%      73.57 ±111%     +30.9%      28.14 ± 44%  softirqs.CPU191.TIMER
      7.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU192.BLOCK
     26774 ±  9%      +2.4%      27409 ±  5%      -2.8%      26032 ±  9%  softirqs.CPU192.RCU
     24520 ± 19%      -2.9%      23813 ± 21%      -7.6%      22663 ± 27%  softirqs.CPU192.SCHED
      2.67 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU192.TASKLET
      2331 ±220%     -99.1%      20.86 ± 64%     -99.3%      17.14 ± 29%  softirqs.CPU192.TIMER
     27833 ±  2%      -2.1%      27261 ±  7%      -6.6%      25992 ±  5%  softirqs.CPU193.RCU
     24306 ± 18%     -14.9%      20689 ± 35%      +1.2%      24600 ± 23%  softirqs.CPU193.SCHED
      0.17 ±223%    -100.0%       0.00           -14.3%       0.14 ±244%  softirqs.CPU193.TASKLET
     41.33 ± 49%     +33.8%      55.29 ± 76%    +889.9%     409.14 ±225%  softirqs.CPU193.TIMER
      2.83 ±223%     +76.5%       5.00 ±244%     -84.9%       0.43 ±169%  softirqs.CPU194.BLOCK
     29178            -0.6%      28997 ±  5%      -7.7%      26933 ± 10%  softirqs.CPU194.RCU
     26513            -0.9%      26281 ±  2%      -1.1%      26223 ±  2%  softirqs.CPU194.SCHED
      0.00       +4.3e+101%       0.43 ±244%    -100.0%       0.00        softirqs.CPU194.TASKLET
     51.33 ±105%     -25.4%      38.29 ± 82%     -40.4%      30.57 ± 38%  softirqs.CPU194.TIMER
     11.83 ±223%     -52.9%       5.57 ±187%     -51.7%       5.71 ±244%  softirqs.CPU195.BLOCK
     29756            -3.2%      28813 ±  5%      -6.6%      27789 ± 12%  softirqs.CPU195.RCU
     26491            -0.3%      26424            -2.9%      25728 ±  6%  softirqs.CPU195.SCHED
    109.83 ± 22%     -20.5%      87.29 ± 37%     -14.9%      93.43 ± 28%  softirqs.CPU195.TIMER
      2.50 ±223%    -100.0%       0.00           -20.0%       2.00 ±244%  softirqs.CPU196.BLOCK
     28956 ±  3%      -3.2%      28018 ±  7%      -8.7%      26424 ±  9%  softirqs.CPU196.RCU
     26758            -8.3%      24542 ± 21%      -0.4%      26640        softirqs.CPU196.SCHED
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU196.TASKLET
     23.50 ± 45%    +233.1%      78.29 ±120%     +36.2%      32.00 ± 84%  softirqs.CPU196.TIMER
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU197.BLOCK
     28516 ±  2%      -1.4%      28113 ±  7%      -6.8%      26564 ±  8%  softirqs.CPU197.RCU
     26418            +1.5%      26823            +0.8%      26618        softirqs.CPU197.SCHED
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU197.TASKLET
     98.00 ±  6%     +38.5%     135.71 ± 58%      -6.7%      91.43 ±  8%  softirqs.CPU197.TIMER
      1.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU198.BLOCK
     28824 ±  2%      -0.9%      28558 ±  8%      -6.1%      27051 ±  6%  softirqs.CPU198.RCU
     26882            -0.8%      26666           -10.8%      23973 ± 22%  softirqs.CPU198.SCHED
     41.67 ± 83%    +213.0%     130.43 ±131%    +194.5%     122.71 ±139%  softirqs.CPU198.TIMER
      2.33 ±223%     -81.6%       0.43 ±244%    -100.0%       0.00        softirqs.CPU199.BLOCK
     28826 ±  3%      +1.4%      29242 ±  8%      -5.8%      27160 ±  9%  softirqs.CPU199.RCU
     26494            -4.5%      25303 ± 14%      +0.3%      26581 ±  2%  softirqs.CPU199.SCHED
     92.00 ± 27%     +77.0%     162.86 ± 85%     +21.0%     111.29 ± 43%  softirqs.CPU199.TIMER
      2.83 ±193%    +842.9%      26.71 ±158%    +137.0%       6.71 ±216%  softirqs.CPU2.BLOCK
     39675 ±  7%     -10.6%      35466 ±  8%     -11.9%      34937 ± 12%  softirqs.CPU2.RCU
     21463 ± 29%     +20.9%      25939 ±  5%     +20.7%      25903 ±  3%  softirqs.CPU2.SCHED
      0.00       +1.9e+102%       1.86 ±244%    -100.0%       0.00        softirqs.CPU2.TASKLET
    502.17 ±177%     +90.6%     957.29 ±222%     -30.6%     348.57 ±138%  softirqs.CPU2.TIMER
      4.33 ±223%     -90.1%       0.43 ±244%    -100.0%       0.00        softirqs.CPU20.BLOCK
      7.00 ± 14%      +2.0%       7.14 ± 18%     +12.2%       7.86 ± 15%  softirqs.CPU20.NET_RX
     34517 ±  4%      -4.3%      33031 ±  4%      -7.9%      31789 ± 10%  softirqs.CPU20.RCU
     24308 ± 16%      +5.1%      25551 ±  2%      +4.5%      25402 ±  3%  softirqs.CPU20.SCHED
     84.50 ± 16%     +27.6%     107.86 ± 52%    +427.8%     446.00 ±154%  softirqs.CPU20.TIMER
     28777            -2.9%      27939 ±  6%      -4.8%      27391 ± 12%  softirqs.CPU200.RCU
     26783            -0.7%      26596            -2.9%      26013 ±  8%  softirqs.CPU200.SCHED
      5.50 ±223%     -97.4%       0.14 ±244%    -100.0%       0.00        softirqs.CPU200.TASKLET
    231.33 ±205%     -50.1%     115.43 ±108%    +186.4%     662.57 ±213%  softirqs.CPU200.TIMER
      0.00       +1.3e+103%      12.86 ±244%    -100.0%       0.00        softirqs.CPU201.BLOCK
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU201.NET_TX
     29402 ±  6%      -3.0%      28507 ±  6%      -9.0%      26742 ±  9%  softirqs.CPU201.RCU
     26507            +0.5%      26645            -0.8%      26291 ±  2%  softirqs.CPU201.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU201.TASKLET
    110.33 ± 43%    +254.1%     390.71 ±173%     -15.8%      92.86 ± 29%  softirqs.CPU201.TIMER
      1.33 ±223%     -14.3%       1.14 ±211%     -89.3%       0.14 ±244%  softirqs.CPU202.BLOCK
     28530 ±  2%      -1.5%      28091 ±  6%      -5.3%      27008 ±  9%  softirqs.CPU202.RCU
     26691            -0.0%      26680            -9.9%      24045 ± 22%  softirqs.CPU202.SCHED
      0.83 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU202.TASKLET
     25.50 ± 36%     +19.9%      30.57 ± 92%     +13.7%      29.00 ± 53%  softirqs.CPU202.TIMER
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU203.BLOCK
     28761 ±  2%      -0.5%      28604 ±  7%      -6.6%      26875 ±  9%  softirqs.CPU203.RCU
     23861 ± 24%      -9.5%      21604 ± 30%      +0.4%      23945 ± 21%  softirqs.CPU203.SCHED
      0.83 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU203.TASKLET
    100.83 ± 12%     -12.0%      88.71 ± 10%      -4.5%      96.29 ± 34%  softirqs.CPU203.TIMER
      0.00       +4.1e+102%       4.14 ±244%    -100.0%       0.00        softirqs.CPU204.BLOCK
     28691            -3.3%      27743 ±  5%      -7.7%      26488 ±  9%  softirqs.CPU204.RCU
     22172 ± 29%      +7.1%      23746 ± 22%     +20.2%      26654        softirqs.CPU204.SCHED
     46.50 ±128%     -52.4%      22.14 ± 35%     +41.9%      66.00 ±127%  softirqs.CPU204.TIMER
      0.33 ±223%    -100.0%       0.00           -57.1%       0.14 ±244%  softirqs.CPU205.BLOCK
     28557            -0.1%      28533 ±  7%      -6.5%      26701 ±  9%  softirqs.CPU205.RCU
     26578            -8.1%      24420 ± 22%      -7.1%      24685 ± 17%  softirqs.CPU205.SCHED
    600.83 ±188%     -85.0%      90.00 ± 24%     -83.3%     100.14 ± 17%  softirqs.CPU205.TIMER
      0.00       +1.9e+102%       1.86 ±244% +1.4e+102%       1.43 ±193%  softirqs.CPU206.BLOCK
     28913 ±  2%      -1.5%      28476 ±  8%      -7.7%      26692 ±  9%  softirqs.CPU206.RCU
     24561 ± 24%      +8.2%      26583            +9.0%      26759        softirqs.CPU206.SCHED
      0.67 ±223%    -100.0%       0.00          +242.9%       2.29 ±244%  softirqs.CPU206.TASKLET
    500.17 ±204%     -21.5%     392.86 ±211%     -15.4%     423.29 ±121%  softirqs.CPU206.TIMER
     21.17 ±217%    -100.0%       0.00           -98.7%       0.29 ±244%  softirqs.CPU207.BLOCK
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU207.NET_TX
     28626 ±  2%      -2.0%      28041 ±  5%      -6.6%      26734 ±  9%  softirqs.CPU207.RCU
     26408            -7.6%      24388 ± 21%     -15.4%      22341 ± 30%  softirqs.CPU207.SCHED
      1.33 ±223%    -100.0%       0.00          +200.0%       4.00 ±244%  softirqs.CPU207.TASKLET
    128.00 ± 64%     -24.2%      97.00 ± 18%     -20.2%     102.14 ± 14%  softirqs.CPU207.TIMER
      1.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU208.BLOCK
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU208.NET_TX
     29941            -2.6%      29176 ±  7%      -3.2%      28981 ± 13%  softirqs.CPU208.RCU
     25194 ± 16%      +4.7%      26383            +1.7%      25626 ±  5%  softirqs.CPU208.SCHED
      1200 ±212%     -96.7%      39.86 ± 70%     -95.1%      58.86 ± 82%  softirqs.CPU208.TIMER
      1.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU209.BLOCK
     29999            -2.6%      29216 ±  6%      -6.4%      28093 ± 10%  softirqs.CPU209.RCU
     22122 ± 27%     +19.0%      26319           +11.5%      24666 ± 16%  softirqs.CPU209.SCHED
     94.50 ± 14%      +1.6%      96.00 ± 12%     +31.4%     124.14 ±115%  softirqs.CPU209.TIMER
      0.00          -100.0%       0.00       +2.9e+101%       0.29 ±244%  softirqs.CPU21.BLOCK
     36226 ±  5%      -4.3%      34669 ±  9%     -11.1%      32188 ±  9%  softirqs.CPU21.RCU
     25280 ± 11%      -1.8%      24822 ± 17%      -4.3%      24205 ± 22%  softirqs.CPU21.SCHED
     51.33 ± 26%    +525.9%     321.29 ±208%   +1061.0%     596.00 ±202%  softirqs.CPU21.TIMER
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU210.BLOCK
     28551 ±  2%      -2.2%      27933 ±  8%      -7.3%      26458 ±  9%  softirqs.CPU210.RCU
     26585            -0.5%      26444            -7.9%      24478 ± 22%  softirqs.CPU210.SCHED
     43.67 ± 70%     -56.5%      19.00 ± 18%     -22.5%      33.86 ± 76%  softirqs.CPU210.TIMER
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU211.NET_TX
     28613            -2.0%      28031 ±  6%      -6.2%      26839 ± 10%  softirqs.CPU211.RCU
     24135 ± 21%      -6.2%      22638 ± 27%      +9.3%      26389 ±  2%  softirqs.CPU211.SCHED
    104.67 ± 21%     -19.5%      84.29 ± 35%      -3.9%     100.57 ± 53%  softirqs.CPU211.TIMER
      0.00          -100.0%       0.00         +1e+102%       1.00 ±244%  softirqs.CPU212.BLOCK
     28275 ±  3%      -2.8%      27490 ±  6%      -7.8%      26057 ±  9%  softirqs.CPU212.RCU
     24521 ± 20%      -0.5%      24404 ± 22%      +8.7%      26654        softirqs.CPU212.SCHED
     31.17 ± 53%     -21.6%      24.43 ± 50%    +359.3%     143.14 ±167%  softirqs.CPU212.TIMER
     29496 ±  2%      -4.6%      28139 ±  4%      -7.9%      27177 ±  8%  softirqs.CPU213.RCU
     26357            -6.0%      24785 ± 16%      -6.3%      24685 ± 16%  softirqs.CPU213.SCHED
    113.33 ± 38%     -20.6%      90.00 ±  8%    +391.3%     556.86 ±123%  softirqs.CPU213.TIMER
      0.00       +1.7e+102%       1.71 ±244% +3.9e+102%       3.86 ±116%  softirqs.CPU214.BLOCK
     29736 ±  7%      -6.2%      27885 ±  7%     -10.7%      26556 ±  9%  softirqs.CPU214.RCU
     24976 ± 12%      +6.8%      26675            +6.8%      26685        softirqs.CPU214.SCHED
     33.67 ± 66%    +164.8%      89.14 ±157%     +16.3%      39.14 ±116%  softirqs.CPU214.TIMER
      0.00       +5.7e+101%       0.57 ±158%    -100.0%       0.00        softirqs.CPU215.BLOCK
     28679 ±  2%      -1.8%      28167 ±  7%      -5.6%      27085 ± 10%  softirqs.CPU215.RCU
     23916 ± 25%     +11.0%      26547           +11.4%      26634        softirqs.CPU215.SCHED
    163.83 ± 81%     -38.4%     100.86 ± 18%     -14.2%     140.57 ± 38%  softirqs.CPU215.TIMER
      1.17 ±223%    -100.0%       0.00           +34.7%       1.57 ±159%  softirqs.CPU216.BLOCK
     28337 ±  2%      -0.8%      28112 ±  8%      -7.3%      26276 ±  9%  softirqs.CPU216.RCU
     26654            -0.5%      26515            +0.1%      26674        softirqs.CPU216.SCHED
      0.00          -100.0%       0.00       +1.7e+102%       1.71 ±244%  softirqs.CPU216.TASKLET
     33.67 ± 83%     -14.7%      28.71 ± 49%     -23.2%      25.86 ± 31%  softirqs.CPU216.TIMER
      0.00       +1.4e+103%      14.14 ±222%    -100.0%       0.00        softirqs.CPU217.BLOCK
     28821 ±  2%      -2.4%      28122 ±  7%      -7.8%      26571 ±  9%  softirqs.CPU217.RCU
     23938 ± 23%     +11.5%      26693           +10.5%      26457        softirqs.CPU217.SCHED
      0.00          -100.0%       0.00       +1.1e+102%       1.14 ±244%  softirqs.CPU217.TASKLET
    444.50 ±171%     -76.9%     102.57 ± 10%     -65.4%     153.71 ± 43%  softirqs.CPU217.TIMER
      0.00       +8.6e+101%       0.86 ±244%    -100.0%       0.00        softirqs.CPU218.BLOCK
     29874            -2.3%      29187 ±  5%      -7.8%      27555 ± 10%  softirqs.CPU218.RCU
     26587            -2.9%      25806 ±  5%      -0.3%      26500        softirqs.CPU218.SCHED
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU218.TASKLET
     20.17 ± 17%     +31.8%      26.57 ± 44%     +10.5%      22.29 ± 19%  softirqs.CPU218.TIMER
      0.33 ±223%    -100.0%       0.00         +6928.6%      23.43 ±244%  softirqs.CPU219.BLOCK
     30282            -1.9%      29719 ±  6%      -8.3%      27769 ± 10%  softirqs.CPU219.RCU
     26455            -1.3%      26120 ±  2%      -9.1%      24051 ± 22%  softirqs.CPU219.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU219.TASKLET
     99.83 ±  3%      -9.1%      90.71 ± 28%     -10.9%      89.00 ± 25%  softirqs.CPU219.TIMER
      2.00 ±223%    +128.6%       4.57 ±244%     -35.7%       1.29 ±244%  softirqs.CPU22.BLOCK
     34636 ±  5%      -1.9%      33974 ±  4%      -9.2%      31466 ± 10%  softirqs.CPU22.RCU
     24893 ±  7%      +2.1%      25407 ±  4%      +3.9%      25863 ±  3%  softirqs.CPU22.SCHED
    111.17 ± 42%     -12.9%      96.86 ± 20%     -34.1%      73.29 ± 20%  softirqs.CPU22.TIMER
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU220.BLOCK
     28574 ±  2%      +2.2%      29188 ± 12%      -7.5%      26435 ±  9%  softirqs.CPU220.RCU
     23967 ± 24%      -5.3%      22696 ± 26%      -4.7%      22846 ± 26%  softirqs.CPU220.SCHED
      4.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU220.TASKLET
     68.67 ±150%    +104.9%     140.71 ±176%     -67.1%      22.57 ± 27%  softirqs.CPU220.TIMER
      0.00       +2.9e+101%       0.29 ±244% +1.5e+103%      15.29 ±244%  softirqs.CPU221.BLOCK
     28661 ±  2%      -2.4%      27979 ±  6%      -6.7%      26742 ±  8%  softirqs.CPU221.RCU
     26659            -4.9%      25339 ± 12%      -8.7%      24335 ± 22%  softirqs.CPU221.SCHED
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU221.TASKLET
    130.00 ± 56%     -36.0%      83.14 ± 22%     -22.4%     100.86 ±  7%  softirqs.CPU221.TIMER
      0.00       +4.3e+101%       0.43 ±169%    -100.0%       0.00        softirqs.CPU222.BLOCK
     28689 ±  2%      -2.8%      27884 ±  6%      -7.0%      26689 ± 11%  softirqs.CPU222.RCU
     26794            -7.0%      24926 ± 16%      -6.4%      25081 ± 15%  softirqs.CPU222.SCHED
     95.83 ±144%    +126.0%     216.57 ±223%     -53.8%      44.29 ±117%  softirqs.CPU222.TIMER
      0.00       +8.6e+101%       0.86 ±244% +1.4e+101%       0.14 ±244%  softirqs.CPU223.BLOCK
     27287 ±  5%      -1.1%      26982 ±  6%      -3.8%      26256 ± 10%  softirqs.CPU223.RCU
     23826 ± 24%      +9.1%      26000 ±  7%      -5.4%      22531 ± 28%  softirqs.CPU223.SCHED
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU223.TASKLET
      1282 ±201%     +24.9%       1601 ±231%     -78.5%     276.29 ±162%  softirqs.CPU223.TIMER
     28542 ±  2%      -2.9%      27700 ±  5%      -6.8%      26611 ± 10%  softirqs.CPU224.RCU
     26662            -0.6%      26489            -6.3%      24992 ± 17%  softirqs.CPU224.SCHED
     19.67 ± 28%    +420.8%     102.43 ±165%   +1134.9%     242.86 ±132%  softirqs.CPU224.TIMER
     17.67 ±179%     -76.5%       4.14 ±244%    -100.0%       0.00        softirqs.CPU225.BLOCK
     29123            -2.5%      28385 ±  7%      -8.8%      26557 ±  8%  softirqs.CPU225.RCU
     26487            -1.8%      26019 ±  3%     -13.4%      22930 ± 24%  softirqs.CPU225.SCHED
    110.33 ±  3%      +2.8%     113.43 ± 27%    +114.2%     236.29 ±117%  softirqs.CPU225.TIMER
     28496 ±  2%      -2.2%      27882 ±  6%      -7.7%      26313 ±  9%  softirqs.CPU226.RCU
     26198 ±  6%      +1.1%      26497            +1.9%      26698        softirqs.CPU226.SCHED
     24.33 ± 28%      -6.7%      22.71 ± 20%     -20.7%      19.29 ± 21%  softirqs.CPU226.TIMER
      1.67 ±175%    -100.0%       0.00           -82.9%       0.29 ±244%  softirqs.CPU227.BLOCK
     28597            -0.9%      28342 ±  8%      -6.8%      26664 ±  9%  softirqs.CPU227.RCU
     26349 ±  2%      -4.4%      25198 ± 14%      -5.7%      24851 ± 17%  softirqs.CPU227.SCHED
    102.67 ± 39%      +3.9%     106.71 ± 10%      +6.0%     108.86 ± 36%  softirqs.CPU227.TIMER
      0.00       +5.7e+102%       5.71 ±244% +4.3e+102%       4.29 ±235%  softirqs.CPU228.BLOCK
     28848 ±  2%      -3.7%      27784 ±  6%      -8.3%      26457 ±  9%  softirqs.CPU228.RCU
     24034 ± 24%     -14.5%      20542 ± 33%     +10.8%      26640        softirqs.CPU228.SCHED
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU228.TASKLET
     62.50 ± 97%     -62.5%      23.43 ± 55%     -60.2%      24.86 ± 61%  softirqs.CPU228.TIMER
      2.50 ±190%    +322.9%      10.57 ±163%     -94.3%       0.14 ±244%  softirqs.CPU229.BLOCK
     29169            -3.2%      28245 ±  5%      -7.2%      27082 ±  9%  softirqs.CPU229.RCU
     26535            -8.2%      24356 ± 22%      -0.3%      26444        softirqs.CPU229.SCHED
    147.67 ± 52%     -33.5%      98.14 ± 20%     -31.3%     101.43 ± 14%  softirqs.CPU229.TIMER
      0.33 ±223%    -100.0%       0.00          +371.4%       1.57 ±166%  softirqs.CPU23.BLOCK
     34421 ±  7%      +0.3%      34507 ±  4%      -9.5%      31156 ± 11%  softirqs.CPU23.RCU
     25965 ±  2%      -5.5%      24534 ± 16%      +1.5%      26348 ±  2%  softirqs.CPU23.SCHED
    121.83 ±124%     -27.1%      88.86 ± 78%     -43.6%      68.71 ± 71%  softirqs.CPU23.TIMER
      0.17 ±223%    +242.9%       0.57 ±244%    -100.0%       0.00        softirqs.CPU230.BLOCK
     29954 ± 14%      -8.2%      27500 ±  5%      -9.7%      27055 ± 13%  softirqs.CPU230.RCU
     24746 ± 19%      +0.8%      24955 ± 16%      +8.4%      26833        softirqs.CPU230.SCHED
      1220 ±216%     -98.0%      24.86 ± 71%     -78.2%     266.14 ±225%  softirqs.CPU230.TIMER
      4.33 ±223%     -76.9%       1.00 ±244%      -1.1%       4.29 ±244%  softirqs.CPU231.BLOCK
     28823 ±  2%      +0.9%      29086 ±  9%      -5.5%      27232 ± 10%  softirqs.CPU231.RCU
     26824            -6.0%      25212 ± 12%      -1.4%      26455        softirqs.CPU231.SCHED
    769.67 ±195%     -87.2%      98.57 ± 13%     -43.6%     434.14 ±175%  softirqs.CPU231.TIMER
      2.33 ±223%    -100.0%       0.00           +40.8%       3.29 ±181%  softirqs.CPU232.BLOCK
     30943            -2.9%      30046 ±  5%      -8.1%      28422 ±  9%  softirqs.CPU232.RCU
     23471 ± 24%      +3.9%      24376 ± 21%      +2.9%      24142 ± 21%  softirqs.CPU232.SCHED
     70.83 ±149%    +157.5%     182.43 ±215%     -69.5%      21.57 ± 43%  softirqs.CPU232.TIMER
      0.33 ±223%   +2385.7%       8.29 ±154%    -100.0%       0.00        softirqs.CPU233.BLOCK
     31311 ±  3%      -4.4%      29937 ±  5%      -9.2%      28429 ± 10%  softirqs.CPU233.RCU
     24714 ± 16%      +6.8%      26403            +6.7%      26363        softirqs.CPU233.SCHED
     95.50 ± 42%      +2.5%      97.86 ± 52%      +2.6%      98.00 ±  5%  softirqs.CPU233.TIMER
      0.00       +1.4e+101%       0.14 ±244% +1.1e+102%       1.14 ±244%  softirqs.CPU234.BLOCK
     32047            -3.6%      30888 ±  3%      -7.2%      29747 ± 10%  softirqs.CPU234.RCU
     24661 ± 16%      +6.6%      26288            +6.7%      26309        softirqs.CPU234.SCHED
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU234.TASKLET
     26.67 ± 69%     +21.6%      32.43 ± 54%     -22.3%      20.71 ± 19%  softirqs.CPU234.TIMER
      0.50 ±223%    +185.7%       1.43 ±217%    -100.0%       0.00        softirqs.CPU235.BLOCK
     32133 ±  2%      -3.6%      30976 ±  2%      -7.4%      29763 ± 10%  softirqs.CPU235.RCU
     24729 ± 16%      -2.5%      24103 ± 21%      +6.1%      26235        softirqs.CPU235.SCHED
     89.17 ± 20%     +43.4%     127.86 ± 67%     +69.8%     151.43 ± 72%  softirqs.CPU235.TIMER
      0.00          -100.0%       0.00       +4.3e+101%       0.43 ±244%  softirqs.CPU236.BLOCK
     31517 ±  3%      +2.1%      32180 ±  9%      -8.3%      28907 ± 10%  softirqs.CPU236.RCU
     23909 ± 23%      +0.9%      24118 ± 22%     +10.5%      26428        softirqs.CPU236.SCHED
     30.17 ±108%     +30.7%      39.43 ± 84%     +27.9%      38.57 ± 66%  softirqs.CPU236.TIMER
     14.83 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU237.BLOCK
     31451 ±  4%      -0.3%      31357 ±  6%      -6.6%      29384 ± 10%  softirqs.CPU237.RCU
     26202 ±  2%      +0.4%      26319            +0.7%      26385        softirqs.CPU237.SCHED
    100.67 ±  3%    +201.6%     303.57 ±170%     +11.5%     112.29 ± 61%  softirqs.CPU237.TIMER
     28738 ±  2%      +0.2%      28798 ±  8%      -7.8%      26507 ±  9%  softirqs.CPU238.RCU
     26758            -8.4%      24517 ± 14%      -6.0%      25155 ± 14%  softirqs.CPU238.SCHED
     23.83 ± 39%    +112.2%      50.57 ±133%    +482.6%     138.86 ±188%  softirqs.CPU238.TIMER
     16.33 ±205%     -93.0%       1.14 ±244%    -100.0%       0.00        softirqs.CPU239.BLOCK
     32326 ±  7%      -7.0%      30066 ±  5%      -8.4%      29619 ± 13%  softirqs.CPU239.RCU
     26062 ±  2%      -0.3%      25985 ±  3%      +0.8%      26276        softirqs.CPU239.SCHED
    106.83 ±  8%     -17.2%      88.43 ± 34%     -19.4%      86.14 ± 27%  softirqs.CPU239.TIMER
      0.33 ±223%   +1014.3%       3.71 ±244%   +1571.4%       5.57 ±182%  softirqs.CPU24.BLOCK
     32334 ±  9%      -4.3%      30954 ±  5%      -8.4%      29629 ± 10%  softirqs.CPU24.RCU
     26503 ±  2%      -0.3%      26415            -1.7%      26049 ±  2%  softirqs.CPU24.SCHED
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU24.TASKLET
      1021 ±203%     -91.8%      83.29 ± 13%     -91.6%      86.14 ±  6%  softirqs.CPU24.TIMER
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU240.BLOCK
     32521 ±  5%      -0.2%      32457 ±  4%      -7.7%      30024 ± 11%  softirqs.CPU240.RCU
     26533            -8.3%      24326 ± 21%      +0.3%      26609 ±  2%  softirqs.CPU240.SCHED
      0.00       +1.7e+102%       1.71 ±244%    -100.0%       0.00        softirqs.CPU240.TASKLET
     19.50 ± 31%      +0.4%      19.57 ± 30%   +1417.2%     295.86 ±223%  softirqs.CPU240.TIMER
      0.33 ±223%    -100.0%       0.00         +1442.9%       5.14 ±229%  softirqs.CPU241.BLOCK
     34134 ±  6%      -4.8%      32488 ±  3%     -13.1%      29649 ± 11%  softirqs.CPU241.RCU
     23647 ± 25%      +3.9%      24567 ± 16%     +11.7%      26417        softirqs.CPU241.SCHED
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU241.TASKLET
     84.00 ± 28%     +22.6%     103.00 ± 21%     +20.4%     101.14 ±  8%  softirqs.CPU241.TIMER
      0.00          -100.0%       0.00       +1.9e+102%       1.86 ±244%  softirqs.CPU242.BLOCK
     32444 ±  7%      -0.3%      32345 ±  5%      -7.6%      29981 ± 11%  softirqs.CPU242.RCU
     26579            -9.2%      24138 ± 22%      -0.6%      26412        softirqs.CPU242.SCHED
    113.83 ±135%     -66.4%      38.29 ±101%     -68.5%      35.86 ± 73%  softirqs.CPU242.TIMER
      0.00       +2.7e+102%       2.71 ±244% +2.1e+102%       2.14 ±244%  softirqs.CPU243.BLOCK
     34940 ±  8%      -7.4%      32344 ±  4%     -14.1%      30030 ± 11%  softirqs.CPU243.RCU
     25821 ±  4%      +1.7%      26266            +2.2%      26385        softirqs.CPU243.SCHED
     91.00 ± 47%     -14.1%      78.14 ± 20%     +56.4%     142.29 ± 78%  softirqs.CPU243.TIMER
      2.83 ±223%    +202.5%       8.57 ±158%    -100.0%       0.00        softirqs.CPU244.BLOCK
     32122 ±  5%      -6.6%      29994 ±  5%      -9.9%      28928 ± 11%  softirqs.CPU244.RCU
     23796 ± 24%     +10.2%      26228           +10.9%      26395        softirqs.CPU244.SCHED
     33.67 ± 54%     -29.6%      23.71 ± 31%      +6.9%      36.00 ±102%  softirqs.CPU244.TIMER
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU245.BLOCK
     30878 ±  4%      -2.1%      30240 ±  6%      -7.6%      28533 ± 11%  softirqs.CPU245.RCU
     26254            -2.7%      25537 ±  5%      +0.7%      26443        softirqs.CPU245.SCHED
      0.17 ±223%    -100.0%       0.00           -14.3%       0.14 ±244%  softirqs.CPU245.TASKLET
    103.83 ± 11%      +0.0%     103.86 ± 45%    +225.5%     338.00 ±172%  softirqs.CPU245.TIMER
      0.00          -100.0%       0.00       +4.1e+102%       4.14 ±244%  softirqs.CPU246.BLOCK
     32283 ±  6%      -6.1%      30329 ±  5%     -10.7%      28823 ± 10%  softirqs.CPU246.RCU
     26633            -1.1%      26337            -0.3%      26560        softirqs.CPU246.SCHED
     31.33 ± 88%     -19.8%      25.14 ± 47%     -38.0%      19.43 ± 35%  softirqs.CPU246.TIMER
      0.00       +2.9e+101%       0.29 ±244% +2.9e+101%       0.29 ±244%  softirqs.CPU247.BLOCK
     30689 ±  3%      -0.1%      30660 ±  7%      -4.8%      29229 ±  6%  softirqs.CPU247.RCU
     23862 ± 24%     +10.4%      26338           +10.7%      26424        softirqs.CPU247.SCHED
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU247.TASKLET
     94.17 ± 20%      +5.3%      99.14 ± 12%      +7.4%     101.14 ± 47%  softirqs.CPU247.TIMER
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU248.NET_TX
     32421 ±  6%      +1.2%      32808 ±  4%      -9.0%      29498 ± 11%  softirqs.CPU248.RCU
     23808 ± 24%      +1.7%      24213 ± 21%      +2.0%      24285 ± 19%  softirqs.CPU248.SCHED
    660.67 ±212%     -96.9%      20.57 ± 16%     -96.8%      21.29 ± 20%  softirqs.CPU248.TIMER
     14.67 ±223%     -65.9%       5.00 ±200%    -100.0%       0.00        softirqs.CPU249.BLOCK
     34348 ±  8%      -4.0%      32973 ±  4%     -12.5%      30062 ± 12%  softirqs.CPU249.RCU
     26489            -0.9%      26251            -0.3%      26408        softirqs.CPU249.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU249.TASKLET
    140.00 ± 49%     -28.1%     100.71 ±  8%     -30.7%      97.00 ± 12%  softirqs.CPU249.TIMER
      3.33 ±223%    +182.9%       9.43 ±120%     +24.3%       4.14 ±173%  softirqs.CPU25.BLOCK
     30898 ±  3%      +0.9%      31174 ±  6%      -2.0%      30265 ± 12%  softirqs.CPU25.RCU
     27081 ±  2%      -9.1%      24621 ± 20%      -2.4%      26421        softirqs.CPU25.SCHED
      0.00          -100.0%       0.00       +1.9e+102%       1.86 ±244%  softirqs.CPU25.TASKLET
      1339 ±215%     -96.4%      48.71 ± 27%     -70.4%     396.86 ±209%  softirqs.CPU25.TIMER
     32936 ±  6%      -0.8%      32681 ±  4%      -8.4%      30166 ± 11%  softirqs.CPU250.RCU
     24237 ± 22%      +8.4%      26276            +3.6%      25100 ± 12%  softirqs.CPU250.SCHED
     17.33 ± 27%     +96.2%      34.00 ± 50%     +43.4%      24.86 ± 14%  softirqs.CPU250.TIMER
      0.33 ±223%    +800.0%       3.00 ±192%   +4014.3%      13.71 ±239%  softirqs.CPU251.BLOCK
     33972 ±  5%      -2.8%      33019 ±  4%     -10.0%      30572 ± 12%  softirqs.CPU251.RCU
     24453 ± 17%      +7.7%      26343           -14.4%      20935 ± 31%  softirqs.CPU251.SCHED
    140.33 ± 49%     -32.6%      94.57 ± 20%      -7.6%     129.71 ± 32%  softirqs.CPU251.TIMER
      4.67 ±223%     -20.4%       3.71 ±166%    -100.0%       0.00        softirqs.CPU252.BLOCK
     33360 ±  3%      -7.9%      30722 ±  5%     -12.8%      29101 ± 11%  softirqs.CPU252.RCU
     19327 ± 38%     +20.5%      23286 ± 22%     +37.2%      26509        softirqs.CPU252.SCHED
    422.33 ±210%     -85.2%      62.43 ±132%     -73.7%     111.14 ±194%  softirqs.CPU252.TIMER
      2.50 ±223%    +882.9%      24.57 ±233%    -100.0%       0.00        softirqs.CPU253.BLOCK
     31043 ±  4%      -2.3%      30334 ±  5%      -7.5%      28718 ±  9%  softirqs.CPU253.RCU
     26599            -9.1%      24172 ± 21%      -0.7%      26403        softirqs.CPU253.SCHED
    102.83 ± 10%      -9.6%      93.00 ± 11%     +14.5%     117.71 ± 36%  softirqs.CPU253.TIMER
      1.67 ±197%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU254.BLOCK
     32196 ±  5%      -2.2%      31500 ±  7%      -9.9%      29023 ± 11%  softirqs.CPU254.RCU
     24038 ± 23%      +0.8%      24227 ± 20%      +9.4%      26307        softirqs.CPU254.SCHED
     19.50 ±  7%   +1955.7%     400.86 ±225%     +22.3%      23.86 ± 15%  softirqs.CPU254.TIMER
      7.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU255.BLOCK
     31907 ±  4%      -0.7%      31676 ±  5%      -7.8%      29424 ±  9%  softirqs.CPU255.RCU
     13225 ± 27%     +33.3%      17630 ± 44%     +14.3%      15110 ± 33%  softirqs.CPU255.SCHED
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU255.TASKLET
     51.17 ±  9%    +752.7%     436.29 ±160%     +13.6%      58.14 ± 13%  softirqs.CPU255.TIMER
      0.33 ±223%    +242.9%       1.14 ±164%    +114.3%       0.71 ±244%  softirqs.CPU26.BLOCK
     33518 ±  6%      -6.4%      31376 ±  5%     -10.8%      29907 ± 12%  softirqs.CPU26.RCU
     25700 ±  4%     -10.6%      22968 ± 20%      -3.1%      24911 ±  7%  softirqs.CPU26.SCHED
     82.83 ±  5%      -7.0%      77.00 ± 14%     -16.4%      69.29 ± 25%  softirqs.CPU26.TIMER
      0.00       +2.9e+101%       0.29 ±244% +1.1e+103%      10.57 ±244%  softirqs.CPU27.BLOCK
     32484 ±  9%      -6.2%      30479 ±  7%      -6.9%      30244 ± 13%  softirqs.CPU27.RCU
     26478 ±  2%      -8.8%      24140 ± 19%      -2.9%      25698 ±  2%  softirqs.CPU27.SCHED
     56.00 ± 27%     -16.6%      46.71 ± 39%     +23.0%      68.86 ± 64%  softirqs.CPU27.TIMER
      0.00          -100.0%       0.00       +5.7e+102%       5.71 ±217%  softirqs.CPU28.BLOCK
     33734 ±  6%      -0.3%      33638 ±  5%      -4.2%      32318 ± 13%  softirqs.CPU28.RCU
     23843 ± 20%      -0.1%      23814 ± 15%      +2.6%      24453 ± 16%  softirqs.CPU28.SCHED
      0.67 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU28.TASKLET
     76.67 ±  8%     +30.2%      99.86 ± 74%     +25.0%      95.86 ± 22%  softirqs.CPU28.TIMER
      0.00          -100.0%       0.00       +6.4e+102%       6.43 ±244%  softirqs.CPU29.BLOCK
     34727 ±  4%      -2.3%      33922 ±  7%     -11.2%      30852 ± 11%  softirqs.CPU29.RCU
     25220 ±  9%      -8.0%      23207 ± 18%      +4.2%      26268 ±  2%  softirqs.CPU29.SCHED
     45.00 ± 18%     +34.3%      60.43 ± 68%      +8.3%      48.71 ± 22%  softirqs.CPU29.TIMER
      5.00 ±206%     -54.3%       2.29 ±211%     -91.4%       0.43 ±169%  softirqs.CPU3.BLOCK
     38314 ±  4%      -9.2%      34802 ± 11%     -12.0%      33714 ± 10%  softirqs.CPU3.RCU
     26179 ±  4%     -12.8%      22818 ± 25%      -7.6%      24188 ± 12%  softirqs.CPU3.SCHED
      0.00       +1.3e+102%       1.29 ±244%    -100.0%       0.00        softirqs.CPU3.TASKLET
     70.50 ± 45%   +2093.1%       1546 ±236%   +1389.4%       1050 ±235%  softirqs.CPU3.TIMER
      0.00       +8.6e+101%       0.86 ±244% +1.4e+101%       0.14 ±244%  softirqs.CPU30.BLOCK
     35115 ±  4%      -7.6%      32444 ±  8%      -9.7%      31703 ± 13%  softirqs.CPU30.RCU
     23995 ± 23%      +7.0%      25682 ±  3%      -5.4%      22704 ± 13%  softirqs.CPU30.SCHED
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU30.TASKLET
     65.17 ± 29%   +1055.9%     753.29 ±219%     +39.6%      91.00 ± 36%  softirqs.CPU30.TIMER
     34540 ±  6%      -0.9%      34225 ±  7%     -10.6%      30869 ± 12%  softirqs.CPU31.RCU
     26592           -11.6%      23511 ± 18%     -12.4%      23288 ± 15%  softirqs.CPU31.SCHED
    963.50 ±213%     -54.4%     439.43 ±218%     -83.7%     156.57 ±175%  softirqs.CPU31.TIMER
      2.50 ±206%      +2.9%       2.57 ±169%     -71.4%       0.71 ±162%  softirqs.CPU32.BLOCK
     32803 ±  3%      -0.8%      32554 ±  5%     -10.8%      29269 ± 10%  softirqs.CPU32.RCU
     25875 ±  4%      -1.4%      25508 ±  3%      -0.5%      25754 ±  5%  softirqs.CPU32.SCHED
      0.00       +2.9e+101%       0.29 ±244% +1.4e+101%       0.14 ±244%  softirqs.CPU32.TASKLET
    103.50 ± 37%     -25.5%      77.14 ± 17%    +270.2%     383.14 ±174%  softirqs.CPU32.TIMER
      1.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU33.BLOCK
     32304 ±  4%      -1.4%      31860 ±  2%      -4.4%      30896 ± 12%  softirqs.CPU33.RCU
     25868 ±  4%      -1.4%      25494 ±  4%     -10.5%      23157 ± 20%  softirqs.CPU33.SCHED
     44.83 ±  4%     +24.3%      55.71 ± 57%   +1326.6%     639.57 ±145%  softirqs.CPU33.TIMER
     33099 ±  3%      -3.8%      31844 ±  4%     -10.0%      29787 ± 10%  softirqs.CPU34.RCU
     26097 ±  4%      -2.1%      25540 ±  3%      -1.2%      25775 ±  4%  softirqs.CPU34.SCHED
    123.50 ± 91%     -35.2%      80.00 ± 14%     -29.9%      86.57 ± 19%  softirqs.CPU34.TIMER
      0.00       +4.1e+102%       4.14 ±244%    -100.0%       0.00        softirqs.CPU35.BLOCK
     32634 ±  4%      -2.3%      31899 ±  3%      -8.6%      29829 ±  9%  softirqs.CPU35.RCU
     25549 ±  7%      +0.7%      25729 ±  3%      -6.3%      23930 ± 18%  softirqs.CPU35.SCHED
     70.67 ± 59%      +2.3%      72.29 ± 89%     -34.7%      46.14 ± 12%  softirqs.CPU35.TIMER
      1.00 ±223%     -71.4%       0.29 ±244%     +71.4%       1.71 ±158%  softirqs.CPU36.BLOCK
     30939 ±  3%      -2.9%      30044 ±  6%      -7.1%      28741 ±  9%  softirqs.CPU36.RCU
     26315 ±  5%     -12.8%      22954 ± 18%      -1.2%      26010 ±  3%  softirqs.CPU36.SCHED
    399.00 ±133%     -80.6%      77.57 ± 14%     -79.2%      83.00 ±  8%  softirqs.CPU36.TIMER
      0.00       +1.4e+101%       0.14 ±244% +2.7e+102%       2.71 ±148%  softirqs.CPU37.BLOCK
     31784 ±  4%      -4.7%      30275 ±  7%      -9.2%      28861 ± 10%  softirqs.CPU37.RCU
     25656 ±  8%      -0.7%      25488 ±  4%      +0.0%      25656 ±  5%  softirqs.CPU37.SCHED
    179.33 ±104%     -72.2%      49.86 ± 20%     -72.3%      49.71 ± 22%  softirqs.CPU37.TIMER
      0.17 ±223%   +1271.4%       2.29 ±135%    -100.0%       0.00        softirqs.CPU38.BLOCK
     31271 ±  5%      -3.8%      30068 ±  4%      -8.4%      28654 ±  9%  softirqs.CPU38.RCU
     25301 ±  6%      -8.4%      23182 ± 25%      +2.9%      26032 ±  2%  softirqs.CPU38.SCHED
      0.00          -100.0%       0.00       +1.4e+102%       1.43 ±244%  softirqs.CPU38.TASKLET
    105.50 ± 45%     -28.8%      75.14 ± 16%     +37.4%     145.00 ±106%  softirqs.CPU38.TIMER
      4.67 ±223%     -78.6%       1.00 ±244%    -100.0%       0.00        softirqs.CPU39.BLOCK
     30702 ±  8%      +1.8%      31256 ±  9%      -6.0%      28863 ± 10%  softirqs.CPU39.RCU
     24667 ± 18%      +0.1%      24686 ± 10%      -2.1%      24146 ± 16%  softirqs.CPU39.SCHED
      0.00          -100.0%       0.00       +5.7e+101%       0.57 ±244%  softirqs.CPU39.TASKLET
      1132 ±214%     -96.0%      45.71 ± 19%     -82.7%     195.57 ±185%  softirqs.CPU39.TIMER
      8.83 ±141%     -77.4%       2.00 ±160%      -4.6%       8.43 ±182%  softirqs.CPU4.BLOCK
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU4.NET_TX
     39017 ±  4%      -5.8%      36738 ±  4%      -9.6%      35289 ± 11%  softirqs.CPU4.RCU
     22124 ± 25%      +5.1%      23251 ± 21%      +8.6%      24030 ± 16%  softirqs.CPU4.SCHED
      0.00         +1e+102%       1.00 ±244%    -100.0%       0.00        softirqs.CPU4.TASKLET
     82.67 ±  6%   +1243.8%       1110 ±153%     +10.8%      91.57 ± 41%  softirqs.CPU4.TIMER
      4.83 ±223%     -76.4%       1.14 ±164%    -100.0%       0.00        softirqs.CPU40.BLOCK
     29568 ±  6%      -7.6%      27333 ±  8%     -10.0%      26605 ± 10%  softirqs.CPU40.RCU
     24690 ± 12%      +6.0%      26177            -4.3%      23627 ± 22%  softirqs.CPU40.SCHED
    115.50 ± 59%    +698.4%     922.14 ±143%     -27.6%      83.57 ±  6%  softirqs.CPU40.TIMER
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU41.BLOCK
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU41.NET_TX
     29153            -2.7%      28354 ±  7%      -8.0%      26813 ±  9%  softirqs.CPU41.RCU
     24384 ± 16%      +8.4%      26423 ±  4%      +4.2%      25401 ± 11%  softirqs.CPU41.SCHED
     50.33 ±  9%   +4092.3%       2110 ±187%      -7.5%      46.57 ± 12%  softirqs.CPU41.TIMER
      0.00       +7.9e+102%       7.86 ±158%    -100.0%       0.00        softirqs.CPU42.BLOCK
     30786            -3.6%      29680 ±  3%      -6.3%      28851 ±  8%  softirqs.CPU42.RCU
     21625 ± 24%     +15.9%      25058 ± 11%     +20.6%      26074        softirqs.CPU42.SCHED
      0.00          -100.0%       0.00       +2.4e+102%       2.43 ±244%  softirqs.CPU42.TASKLET
     74.33 ±  7%     +81.2%     134.71 ± 77%    +237.5%     250.86 ±111%  softirqs.CPU42.TIMER
      0.00         +2e+102%       2.00 ±244% +1.1e+103%      11.00 ±237%  softirqs.CPU43.BLOCK
     30661            -2.7%      29838 ±  5%      -7.5%      28376 ± 11%  softirqs.CPU43.RCU
     24432 ± 17%      -0.2%      24378 ± 16%      +1.8%      24868 ± 17%  softirqs.CPU43.SCHED
      0.00          -100.0%       0.00       +2.7e+102%       2.71 ±244%  softirqs.CPU43.TASKLET
     61.17 ± 49%    +647.4%     457.14 ±142%    +653.9%     461.14 ±210%  softirqs.CPU43.TIMER
      0.00       +1.4e+101%       0.14 ±244% +2.9e+101%       0.29 ±244%  softirqs.CPU44.BLOCK
     28548 ±  3%      -2.8%      27760 ±  8%      -6.4%      26717 ±  9%  softirqs.CPU44.RCU
     25586 ±  6%      +0.3%      25671 ±  5%      -0.2%      25540 ±  6%  softirqs.CPU44.SCHED
     85.83 ±  3%     +15.5%      99.14 ± 33%     -13.0%      74.71 ± 28%  softirqs.CPU44.TIMER
      0.00       +1.6e+102%       1.57 ±244%    -100.0%       0.00        softirqs.CPU45.BLOCK
     28837 ±  3%      -3.7%      27759 ±  7%      -8.0%      26540 ±  8%  softirqs.CPU45.RCU
     25251 ±  8%      +5.8%      26716            +4.6%      26404        softirqs.CPU45.SCHED
    203.67 ±161%     -77.1%      46.57 ± 20%     -61.0%      79.43 ±119%  softirqs.CPU45.TIMER
      0.00       +5.7e+101%       0.57 ±244%    -100.0%       0.00        softirqs.CPU46.BLOCK
     31807            -1.3%      31388 ±  5%      -6.6%      29718 ±  9%  softirqs.CPU46.RCU
     23587 ± 22%      +1.7%      23986 ± 16%     +10.1%      25973 ±  3%  softirqs.CPU46.SCHED
    138.83 ± 97%     -43.4%      78.57 ± 17%     -48.1%      72.00 ± 19%  softirqs.CPU46.TIMER
      0.33 ±223%     -14.3%       0.29 ±244%    -100.0%       0.00        softirqs.CPU47.BLOCK
     31938            -2.8%      31031 ±  5%      -6.9%      29719 ±  9%  softirqs.CPU47.RCU
     26132 ±  3%      -8.2%      23978 ± 16%      +1.0%      26399 ±  2%  softirqs.CPU47.SCHED
      0.00       +8.6e+101%       0.86 ±244%    -100.0%       0.00        softirqs.CPU47.TASKLET
     51.00 ± 11%     -13.2%      44.29 ± 13%      -4.8%      48.57 ± 47%  softirqs.CPU47.TIMER
      0.50 ±223%     -14.3%       0.43 ±244%     -71.4%       0.14 ±244%  softirqs.CPU48.BLOCK
     29140            +0.7%      29339 ± 10%      -7.6%      26935 ±  9%  softirqs.CPU48.RCU
     26061 ±  4%      -6.3%      24420 ± 16%      -0.5%      25921 ±  5%  softirqs.CPU48.SCHED
      0.00       +1.3e+102%       1.29 ±244%    -100.0%       0.00        softirqs.CPU48.TASKLET
     74.17 ± 16%     +38.3%     102.57 ± 38%     +25.8%      93.29 ± 24%  softirqs.CPU48.TIMER
      0.33 ±223%   +2557.1%       8.86 ±123%   +1185.7%       4.29 ±235%  softirqs.CPU49.BLOCK
     28983 ±  2%      -2.1%      28369 ±  5%      -7.3%      26867 ±  9%  softirqs.CPU49.RCU
     23876 ± 22%      +1.9%      24326 ± 16%     +11.0%      26497 ±  2%  softirqs.CPU49.SCHED
      0.00       +6.9e+102%       6.86 ±239%    -100.0%       0.00        softirqs.CPU49.TASKLET
     52.17 ± 52%      +8.7%      56.71 ± 22%      -0.0%      52.14 ± 26%  softirqs.CPU49.TIMER
      4.67 ±223%     -11.2%       4.14 ±235%    -100.0%       0.00        softirqs.CPU5.BLOCK
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU5.NET_TX
     37913 ±  4%      -5.2%      35929 ±  3%      -8.8%      34568 ± 11%  softirqs.CPU5.RCU
     24940 ± 18%      +5.0%      26181 ±  2%      -1.8%      24489 ± 11%  softirqs.CPU5.SCHED
      0.00       +7.6e+102%       7.57 ±244%    -100.0%       0.00        softirqs.CPU5.TASKLET
     48.33 ± 11%      +4.0%      50.29 ± 34%   +2322.8%       1171 ±236%  softirqs.CPU5.TIMER
      1.83 ±223%      +1.3%       1.86 ±153%     +79.2%       3.29 ±135%  softirqs.CPU50.BLOCK
     28665            +2.1%      29275 ± 11%      -6.2%      26883 ±  9%  softirqs.CPU50.RCU
     26580            -2.4%      25940 ±  4%      -0.4%      26467 ±  2%  softirqs.CPU50.SCHED
    105.33 ±111%     +62.9%     171.57 ±139%     -19.7%      84.57 ± 12%  softirqs.CPU50.TIMER
      1.67 ±175%     +28.6%       2.14 ±226%    -100.0%       0.00        softirqs.CPU51.BLOCK
     28837 ±  9%      -0.6%      28662 ± 11%      -6.8%      26889 ±  9%  softirqs.CPU51.RCU
     25861 ±  5%      +1.4%      26223 ±  2%      -5.1%      24544 ± 19%  softirqs.CPU51.SCHED
      0.00          -100.0%       0.00         +6e+102%       6.00 ±244%  softirqs.CPU51.TASKLET
      1266 ±208%     -63.3%     465.14 ±207%     -96.0%      50.43 ± 17%  softirqs.CPU51.TIMER
      0.00       +5.7e+101%       0.57 ±244%    -100.0%       0.00        softirqs.CPU52.BLOCK
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU52.NET_TX
     29028            -0.4%      28909 ±  7%      -3.7%      27956 ± 11%  softirqs.CPU52.RCU
     22246 ± 24%     +13.3%      25199 ±  7%     +19.1%      26504 ±  3%  softirqs.CPU52.SCHED
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU52.TASKLET
     83.67 ± 16%    +147.9%     207.43 ±146%    +748.6%     710.00 ±214%  softirqs.CPU52.TIMER
     30570 ±  7%      -5.0%      29040 ±  7%     -12.1%      26881 ±  9%  softirqs.CPU53.RCU
     25184 ±  6%      +1.3%      25514 ±  8%      +4.3%      26265 ±  4%  softirqs.CPU53.SCHED
      0.17 ±223%     -14.3%       0.14 ±244%    -100.0%       0.00        softirqs.CPU53.TASKLET
    439.67 ±205%     -88.3%      51.57 ± 17%     -83.0%      74.57 ± 91%  softirqs.CPU53.TIMER
     12.00 ±223%    -100.0%       0.00           -52.4%       5.71 ±244%  softirqs.CPU54.BLOCK
     28893            -1.4%      28498 ±  5%      -7.6%      26707 ±  9%  softirqs.CPU54.RCU
     25488 ±  3%      +0.2%      25531 ±  4%      +3.5%      26376 ±  2%  softirqs.CPU54.SCHED
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU54.TASKLET
     85.17 ± 24%    +144.1%     207.86 ±132%    +318.3%     356.29 ±186%  softirqs.CPU54.TIMER
      0.00       +4.1e+102%       4.14 ±244% +3.1e+102%       3.14 ±244%  softirqs.CPU55.BLOCK
     28939            -2.6%      28195 ±  6%      -9.2%      26282 ± 10%  softirqs.CPU55.RCU
     26747            -6.3%      25050 ±  8%      -0.6%      26583 ±  2%  softirqs.CPU55.SCHED
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        softirqs.CPU55.TASKLET
     74.00 ± 71%     +40.0%     103.57 ±135%   +1928.0%       1500 ±225%  softirqs.CPU55.TIMER
      7.17 ±223%     -70.1%       2.14 ±244%     -10.3%       6.43 ±167%  softirqs.CPU56.BLOCK
     29840 ±  6%      -4.9%      28380 ±  5%      -5.2%      28292 ± 13%  softirqs.CPU56.RCU
     23436 ± 23%     +12.2%      26287 ±  2%      +2.9%      24121 ± 16%  softirqs.CPU56.SCHED
    538.50 ±162%     -84.6%      82.71 ±  6%     -82.3%      95.29 ± 28%  softirqs.CPU56.TIMER
      0.00       +2.3e+102%       2.29 ±244%    -100.0%       0.00        softirqs.CPU57.BLOCK
     28677 ±  2%      -0.8%      28454 ±  6%      -6.9%      26687 ±  9%  softirqs.CPU57.RCU
     25797 ±  4%      +1.4%      26153 ±  3%      +0.7%      25988 ±  4%  softirqs.CPU57.SCHED
    726.17 ±200%     -90.6%      68.29 ± 51%     -81.9%     131.57 ±170%  softirqs.CPU57.TIMER
      0.00          -100.0%       0.00       +8.6e+102%       8.57 ±235%  softirqs.CPU58.BLOCK
     29377 ±  3%      -2.9%      28532 ±  6%      -8.0%      27029 ±  9%  softirqs.CPU58.RCU
     24827 ± 19%      +7.5%      26680            +5.0%      26061 ±  4%  softirqs.CPU58.SCHED
      0.00       +1.4e+101%       0.14 ±244% +1.4e+101%       0.14 ±244%  softirqs.CPU58.TASKLET
    425.50 ±181%     -24.3%     322.29 ±182%     -79.9%      85.43 ±  5%  softirqs.CPU58.TIMER
      0.00       +1.7e+102%       1.71 ±244% +1.1e+102%       1.14 ±244%  softirqs.CPU59.BLOCK
     29145 ±  2%      -2.5%      28419 ±  5%      -7.4%      26992 ±  9%  softirqs.CPU59.RCU
     24214 ± 20%      -0.1%      24197 ± 20%      +3.2%      24990 ± 17%  softirqs.CPU59.SCHED
    138.67 ±112%     -51.6%      67.14 ± 65%     -64.1%      49.71 ± 22%  softirqs.CPU59.TIMER
      0.00       +2.9e+101%       0.29 ±244%   +2e+102%       2.00 ±207%  softirqs.CPU6.BLOCK
     39432 ±  5%      -7.3%      36536 ±  3%     -11.5%      34905 ± 13%  softirqs.CPU6.RCU
     23495 ± 23%     +11.5%      26199 ±  2%      +5.5%      24782 ± 10%  softirqs.CPU6.SCHED
    150.50 ± 95%     -41.1%      88.57 ± 49%      -9.3%     136.57 ±110%  softirqs.CPU6.TIMER
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU60.BLOCK
     28801            -1.0%      28500 ±  6%      -6.2%      27015 ±  9%  softirqs.CPU60.RCU
     23994 ± 18%      +2.6%      24617 ± 10%      +0.2%      24052 ± 18%  softirqs.CPU60.SCHED
     88.00 ± 19%      -2.8%      85.57 ± 19%    +123.7%     196.86 ± 93%  softirqs.CPU60.TIMER
      7.17 ±142%     -66.1%       2.43 ±244%     -92.0%       0.57 ±244%  softirqs.CPU61.BLOCK
     28837            +1.9%      29385 ± 10%      -6.5%      26952 ±  9%  softirqs.CPU61.RCU
     23746 ± 22%     +11.1%      26388 ±  3%     +11.8%      26538        softirqs.CPU61.SCHED
     47.83 ± 30%     +67.2%      80.00 ± 43%     +95.3%      93.43 ± 58%  softirqs.CPU61.TIMER
      9.17 ±107%     -95.3%       0.43 ±244%      -3.4%       8.86 ±214%  softirqs.CPU62.BLOCK
     29049            -0.1%      29017 ±  9%      -6.5%      27166 ±  9%  softirqs.CPU62.RCU
     20935 ± 20%      +2.4%      21433 ± 17%     +10.9%      23219 ±  5%  softirqs.CPU62.SCHED
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU62.TASKLET
    104.50 ±  8%    +238.6%     353.86 ±128%      -5.4%      98.86 ± 31%  softirqs.CPU62.TIMER
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU63.BLOCK
     29210            -2.1%      28591 ±  6%      -6.1%      27434 ± 10%  softirqs.CPU63.RCU
     13323 ± 24%      -2.7%      12960 ± 20%      +4.4%      13911 ± 18%  softirqs.CPU63.SCHED
      2.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU63.TASKLET
     66.33 ± 10%    +403.7%     334.14 ±163%     +10.3%      73.14 ± 26%  softirqs.CPU63.TIMER
      1.00 ±223%     +14.3%       1.14 ±244%     -71.4%       0.29 ±244%  softirqs.CPU64.BLOCK
     28533 ±  2%      -0.9%      28275 ±  7%      -6.7%      26611 ±  9%  softirqs.CPU64.RCU
     22362 ± 20%     -22.4%      17358 ± 37%      +1.3%      22653 ± 25%  softirqs.CPU64.SCHED
      2.17 ±203%    -100.0%       0.00           -93.4%       0.14 ±244%  softirqs.CPU64.TASKLET
     36.17 ± 41%     +66.7%      60.29 ±106%     +78.5%      64.57 ±142%  softirqs.CPU64.TIMER
      0.00         +1e+103%      10.43 ±164% +1.1e+103%      10.71 ±244%  softirqs.CPU65.BLOCK
     30282 ±  5%      -4.6%      28880 ±  7%      -8.1%      27823 ± 12%  softirqs.CPU65.RCU
     23375 ± 23%      +5.8%      24720 ± 21%      -3.8%      22497 ± 32%  softirqs.CPU65.SCHED
      2072 ± 45%     -53.6%     962.43 ±113%     -48.4%       1068 ±100%  softirqs.CPU65.TIMER
      0.83 ±223%     -14.3%       0.71 ±244%   +1271.4%      11.43 ±138%  softirqs.CPU66.BLOCK
     28611            -2.3%      27954 ±  6%      -4.7%      27263 ±  5%  softirqs.CPU66.RCU
     24092 ± 24%     +11.4%      26839            +0.4%      24191 ± 22%  softirqs.CPU66.SCHED
      0.00       +4.3e+101%       0.43 ±169%    -100.0%       0.00        softirqs.CPU66.TASKLET
     35.50 ± 29%   +2650.9%     976.57 ±234%    +411.1%     181.43 ±202%  softirqs.CPU66.TIMER
      4.33 ±134%     -86.8%       0.57 ±158%     -80.2%       0.86 ±244%  softirqs.CPU67.BLOCK
     28820            -2.5%      28085 ±  7%      -4.0%      27671 ± 12%  softirqs.CPU67.RCU
     24346 ± 24%      +9.5%      26671            +5.3%      25642 ±  9%  softirqs.CPU67.SCHED
      0.00       +1.1e+102%       1.14 ±211%    -100.0%       0.00        softirqs.CPU67.TASKLET
     34.17 ± 32%    +634.2%     250.86 ±214%     +32.1%      45.14 ± 74%  softirqs.CPU67.TIMER
      1.33 ±223%     -14.3%       1.14 ±244%    -100.0%       0.00        softirqs.CPU68.BLOCK
     29503            -1.3%      29132 ±  5%      -8.5%      26984 ± 10%  softirqs.CPU68.RCU
     26599            +0.0%      26603            -0.5%      26456        softirqs.CPU68.SCHED
     46.33 ± 90%    +952.9%     487.86 ±158%     -39.6%      28.00 ±  7%  softirqs.CPU68.TIMER
      4.00 ±223%     +25.0%       5.00 ±200%    -100.0%       0.00        softirqs.CPU69.BLOCK
     29950 ±  5%      -4.7%      28540 ±  3%      -9.6%      27062 ± 10%  softirqs.CPU69.RCU
     24829 ± 18%      +6.4%      26425            +6.7%      26497        softirqs.CPU69.SCHED
     42.67 ± 70%     -29.4%      30.14 ± 49%     -43.1%      24.29 ± 10%  softirqs.CPU69.TIMER
      0.33 ±223%     -14.3%       0.29 ±244%    -100.0%       0.00        softirqs.CPU7.BLOCK
     39128 ±  4%      -7.3%      36268 ±  4%     -12.0%      34448 ± 15%  softirqs.CPU7.RCU
     26425 ±  3%      -1.9%      25923 ±  3%      -6.3%      24761 ±  6%  softirqs.CPU7.SCHED
     69.83 ± 61%     -32.1%      47.43 ± 28%      +7.8%      75.29 ± 70%  softirqs.CPU7.TIMER
      0.00       +6.4e+102%       6.43 ±244%   +1e+103%      10.00 ±244%  softirqs.CPU70.BLOCK
     28755            -2.0%      28188 ±  7%      -3.3%      27799 ±  8%  softirqs.CPU70.RCU
     26790            -0.5%      26644            -2.5%      26126 ±  5%  softirqs.CPU70.SCHED
     28.83 ± 12%      -2.9%      28.00 ± 27%    +169.0%      77.57 ±130%  softirqs.CPU70.TIMER
      0.17 ±223%    +757.1%       1.43 ±193%    -100.0%       0.00        softirqs.CPU71.BLOCK
     28704            +0.6%      28880 ±  6%      -6.6%      26806 ±  9%  softirqs.CPU71.RCU
     26715            -0.8%      26500            -9.5%      24176 ± 22%  softirqs.CPU71.SCHED
     29.83 ± 24%     +96.8%      58.71 ± 83%     +33.1%      39.71 ± 66%  softirqs.CPU71.TIMER
      0.00       +2.6e+102%       2.57 ±244%    -100.0%       0.00        softirqs.CPU72.BLOCK
     29286 ±  3%      -4.1%      28088 ±  5%      -8.2%      26892 ± 10%  softirqs.CPU72.RCU
     26844 ±  2%      -2.6%      26156 ±  4%     -10.7%      23960 ± 22%  softirqs.CPU72.SCHED
      0.00       +4.4e+102%       4.43 ±244% +6.6e+102%       6.57 ±244%  softirqs.CPU72.TASKLET
    386.33 ±206%     -83.2%      64.86 ± 97%     -91.1%      34.57 ± 45%  softirqs.CPU72.TIMER
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU73.BLOCK
     28790 ±  3%      -2.3%      28120 ±  5%      -6.9%      26814 ±  9%  softirqs.CPU73.RCU
     24311 ± 25%      -9.0%      22129 ± 32%      -0.9%      24096 ± 22%  softirqs.CPU73.SCHED
      0.33 ±223%    +457.1%       1.86 ±244%    -100.0%       0.00        softirqs.CPU73.TASKLET
    307.50 ±201%     -73.8%      80.71 ±148%     -91.1%      27.43 ± 14%  softirqs.CPU73.TIMER
      1.00 ±223%     -71.4%       0.29 ±244%    +414.3%       5.14 ±244%  softirqs.CPU74.BLOCK
     28713            -2.9%      27891 ±  5%      -7.5%      26560 ±  9%  softirqs.CPU74.RCU
     26786            -0.2%      26732            -3.5%      25857 ±  7%  softirqs.CPU74.SCHED
     50.00 ± 31%     -20.3%      39.86 ± 27%     -19.4%      40.29 ± 39%  softirqs.CPU74.TIMER
      0.00       +1.9e+102%       1.86 ±244%    -100.0%       0.00        softirqs.CPU75.BLOCK
     28368 ±  2%      -1.6%      27914 ±  5%      -5.6%      26768 ±  8%  softirqs.CPU75.RCU
     26769            -6.1%      25140 ± 12%     -10.3%      24013 ± 21%  softirqs.CPU75.SCHED
      0.17 ±223%    -100.0%       0.00           -14.3%       0.14 ±244%  softirqs.CPU75.TASKLET
     45.50 ± 47%      -1.7%      44.71 ± 63%     -30.0%      31.86 ± 28%  softirqs.CPU75.TIMER
      0.00       +1.4e+102%       1.43 ±244% +2.9e+101%       0.29 ±244%  softirqs.CPU76.BLOCK
     28636            -3.6%      27594 ±  5%      -7.3%      26545 ±  9%  softirqs.CPU76.RCU
     24784 ± 18%      +4.3%      25839 ±  4%      +2.2%      25319 ± 12%  softirqs.CPU76.SCHED
     52.67 ± 58%     -34.9%      34.29 ± 21%    +135.2%     123.86 ±184%  softirqs.CPU76.TIMER
      0.00          -100.0%       0.00       +2.9e+101%       0.29 ±244%  softirqs.CPU77.BLOCK
     28126            -3.2%      27214 ±  3%      -6.8%      26200 ±  8%  softirqs.CPU77.RCU
     21735 ± 32%     +22.7%      26667           +16.7%      25369 ± 14%  softirqs.CPU77.SCHED
     52.33 ± 82%     -14.0%      45.00 ± 94%     -39.4%      31.71 ± 52%  softirqs.CPU77.TIMER
      0.00       +2.9e+101%       0.29 ±244% +3.1e+102%       3.14 ±244%  softirqs.CPU78.BLOCK
     28363            -2.9%      27551 ±  5%      -7.1%      26340 ±  9%  softirqs.CPU78.RCU
     26746            -0.7%      26554 ±  2%      -0.5%      26619        softirqs.CPU78.SCHED
      1.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU78.TASKLET
     59.83 ± 72%     -36.7%      37.86 ± 77%     -51.8%      28.86 ± 37%  softirqs.CPU78.TIMER
      0.00          -100.0%       0.00       +1.4e+103%      13.57 ±233%  softirqs.CPU79.BLOCK
     27819            +2.0%      28379 ± 10%      -7.0%      25884 ±  8%  softirqs.CPU79.RCU
     26698           -12.0%      23495 ± 23%      -7.0%      24840 ± 19%  softirqs.CPU79.SCHED
     50.50 ±105%     -45.7%      27.43 ± 26%     -45.7%      27.43 ± 39%  softirqs.CPU79.TIMER
      2.17 ±223%     +51.6%       3.29 ±158%    -100.0%       0.00        softirqs.CPU8.BLOCK
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU8.NET_TX
     36617 ±  5%      -6.2%      34341 ±  4%     -14.6%      31256 ± 12%  softirqs.CPU8.RCU
     24534 ±  4%      -1.3%      24215 ± 20%      +5.0%      25768 ±  5%  softirqs.CPU8.SCHED
     46.67 ±  3%      -2.3%      45.57 ±  2%      -4.2%      44.71 ±  5%  softirqs.CPU8.TASKLET
    139.17 ± 55%     +60.3%     223.14 ±163%    +462.5%     782.86 ±219%  softirqs.CPU8.TIMER
      4.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU80.BLOCK
     28194 ±  2%      -0.3%      28097 ±  6%      -1.8%      27683 ± 18%  softirqs.CPU80.RCU
     26767            -1.2%      26457            -9.0%      24346 ± 17%  softirqs.CPU80.SCHED
     64.17 ±126%     -17.4%      53.00 ± 86%   +1177.9%     820.00 ±229%  softirqs.CPU80.TIMER
      0.17 ±223%    +585.7%       1.14 ±244%     +71.4%       0.29 ±244%  softirqs.CPU81.BLOCK
     28840 ±  2%      -3.9%      27720 ±  5%      -9.7%      26055 ± 10%  softirqs.CPU81.RCU
     24017 ± 24%     +11.3%      26724            +1.5%      24367 ± 22%  softirqs.CPU81.SCHED
     29.17 ± 41%      -1.6%      28.71 ± 22%    +827.2%     270.43 ±212%  softirqs.CPU81.TIMER
     29319            -5.3%      27768 ±  5%      -8.3%      26877 ±  9%  softirqs.CPU82.RCU
     26424            -9.2%      23994 ± 21%      -0.8%      26217 ±  2%  softirqs.CPU82.SCHED
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU82.TASKLET
     61.67 ±123%    +695.1%     490.29 ±221%      +1.0%      62.29 ±115%  softirqs.CPU82.TIMER
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU83.BLOCK
     28437 ±  2%      -3.2%      27514 ±  9%      -6.6%      26549 ± 12%  softirqs.CPU83.RCU
     24864 ± 17%      -1.0%      24618 ± 22%      +4.2%      25899 ±  8%  softirqs.CPU83.SCHED
     34.00 ± 47%   +3393.3%       1187 ±197%   +2497.5%     883.14 ±234%  softirqs.CPU83.TIMER
      0.00          -100.0%       0.00       +2.9e+101%       0.29 ±244%  softirqs.CPU84.BLOCK
     30751 ± 11%     -10.0%      27673 ±  7%     -15.1%      26100 ±  9%  softirqs.CPU84.RCU
     26658            -0.7%      26466 ±  2%      +0.2%      26702        softirqs.CPU84.SCHED
     30.83 ± 41%    +816.4%     282.57 ±203%   +1363.2%     451.14 ±221%  softirqs.CPU84.TIMER
     28726            -3.2%      27814 ±  6%     -10.7%      25647 ± 11%  softirqs.CPU85.RCU
     26584            -8.6%      24285 ± 18%      -5.3%      25178 ± 16%  softirqs.CPU85.SCHED
     38.50 ± 71%    +487.4%     226.14 ±195%   +4588.7%       1805 ±241%  softirqs.CPU85.TIMER
     30567 ±  6%      -4.9%      29065 ±  5%      -9.2%      27747 ±  9%  softirqs.CPU86.RCU
     25630 ±  7%      +1.1%      25900 ±  5%      +3.2%      26442        softirqs.CPU86.SCHED
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU86.TASKLET
     33.83 ± 33%    +104.4%      69.14 ±119%      +3.0%      34.86 ± 38%  softirqs.CPU86.TIMER
      0.33 ±223%    -100.0%       0.00         +1271.4%       4.57 ±244%  softirqs.CPU87.BLOCK
     29742            -2.7%      28950 ±  6%      -6.6%      27774 ±  9%  softirqs.CPU87.RCU
     26538            -6.7%      24757 ± 16%      -0.1%      26498        softirqs.CPU87.SCHED
     54.67 ±136%      -3.3%      52.86 ±118%     -13.5%      47.29 ± 57%  softirqs.CPU87.TIMER
      0.00       +8.6e+101%       0.86 ±244% +2.9e+101%       0.29 ±244%  softirqs.CPU88.BLOCK
     27728 ±  4%      -0.0%      27727 ±  6%      -6.4%      25960 ±  9%  softirqs.CPU88.RCU
     24298 ± 24%     +10.5%      26846            +9.9%      26694        softirqs.CPU88.SCHED
      0.00          -100.0%       0.00       +4.3e+101%       0.43 ±244%  softirqs.CPU88.TASKLET
    913.67 ±217%     -95.6%      39.86 ± 64%     -96.7%      30.00 ± 23%  softirqs.CPU88.TIMER
      0.67 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU89.BLOCK
     28232 ±  2%      +0.2%      28281 ±  8%      -6.3%      26440 ±  9%  softirqs.CPU89.RCU
     26759            -0.1%      26745           -25.0%      20074 ± 38%  softirqs.CPU89.SCHED
    682.83 ±215%     -96.5%      23.71 ± 23%     -95.5%      30.57 ± 49%  softirqs.CPU89.TIMER
      0.00       +2.9e+101%       0.29 ±244% +1.7e+102%       1.71 ±244%  softirqs.CPU9.BLOCK
     34251 ±  7%      +0.6%      34458 ±  3%      -7.6%      31657 ± 12%  softirqs.CPU9.RCU
     26463 ±  2%      -1.6%      26052 ±  3%      -7.2%      24553 ± 16%  softirqs.CPU9.SCHED
     39.50 ±  2%      -0.5%      39.29            +1.6%      40.14 ±  6%  softirqs.CPU9.TASKLET
     77.67 ± 76%     +22.1%      94.86 ± 83%    +436.4%     416.57 ±196%  softirqs.CPU9.TIMER
      0.00       +7.4e+102%       7.43 ±244% +8.6e+101%       0.86 ±244%  softirqs.CPU90.BLOCK
     27923 ±  2%      +1.0%      28212 ±  8%      -7.0%      25962 ±  9%  softirqs.CPU90.RCU
     26851           -14.8%      22876 ± 27%      -0.6%      26696        softirqs.CPU90.SCHED
     32.00 ± 32%      +0.0%      32.00 ± 45%      +6.2%      34.00 ± 27%  softirqs.CPU90.TIMER
      0.00       +2.9e+101%       0.29 ±244%    -100.0%       0.00        softirqs.CPU91.BLOCK
     28519            -1.9%      27982 ±  6%      -7.8%      26290 ±  8%  softirqs.CPU91.RCU
     26824            -4.5%      25612 ± 12%      -8.7%      24479 ± 22%  softirqs.CPU91.SCHED
     36.50 ± 79%     -29.2%      25.86 ± 12%     +96.9%      71.86 ± 93%  softirqs.CPU91.TIMER
      0.00          -100.0%       0.00       +6.3e+102%       6.29 ±244%  softirqs.CPU92.BLOCK
     29597            -1.8%      29053 ±  5%      -4.5%      28280 ± 11%  softirqs.CPU92.RCU
     26635            -3.1%      25805 ±  3%      -8.0%      24511 ± 16%  softirqs.CPU92.SCHED
      0.50 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU92.TASKLET
     32.00 ± 30%     +26.8%      40.57 ± 44%      +6.7%      34.14 ± 28%  softirqs.CPU92.TIMER
      4.67 ±223%    +169.4%      12.57 ±244%     -44.9%       2.57 ±244%  softirqs.CPU93.BLOCK
     29962 ±  2%      -2.9%      29087 ±  5%      -8.2%      27502 ±  9%  softirqs.CPU93.RCU
     26661            -7.6%      24639 ± 17%      -0.6%      26491        softirqs.CPU93.SCHED
     44.83 ± 82%     -29.3%      31.71 ± 38%     -42.3%      25.86 ± 26%  softirqs.CPU93.TIMER
      0.00          -100.0%       0.00       +2.3e+102%       2.29 ±244%  softirqs.CPU94.BLOCK
     28276 ±  2%      -2.4%      27587 ±  6%      -5.0%      26851 ± 10%  softirqs.CPU94.RCU
     26718            -8.7%      24387 ± 13%      -1.2%      26410 ±  5%  softirqs.CPU94.SCHED
     31.83 ± 42%   +1174.0%     405.57 ±189%    +930.8%     328.14 ±220%  softirqs.CPU94.TIMER
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU95.NET_TX
     28449            -3.7%      27383 ±  3%      -8.0%      26174 ± 10%  softirqs.CPU95.RCU
     26716            -0.6%      26568 ±  2%     -20.7%      21199 ± 32%  softirqs.CPU95.SCHED
     34.33 ± 48%   +2344.9%     839.43 ±226%    +105.1%      70.43 ±157%  softirqs.CPU95.TIMER
      0.67 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU96.BLOCK
     28571            -3.7%      27517 ±  4%      -7.4%      26449 ±  6%  softirqs.CPU96.RCU
     26659            +0.1%      26696            -7.7%      24615 ± 21%  softirqs.CPU96.SCHED
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU96.TASKLET
     38.67 ± 61%     -26.8%      28.29 ± 35%   +2223.2%     898.29 ±179%  softirqs.CPU96.TIMER
      5.33 ±207%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU97.BLOCK
     28413 ±  2%      -2.8%      27618 ±  5%      -9.5%      25722 ± 11%  softirqs.CPU97.RCU
     26610            +0.1%      26638           -11.6%      23514 ± 22%  softirqs.CPU97.SCHED
     24.00 ± 35%     +25.6%      30.14 ± 51%   +5680.4%       1387 ±228%  softirqs.CPU97.TIMER
      0.00         +4e+102%       4.00 ±244%    -100.0%       0.00        softirqs.CPU98.BLOCK
     29489 ±  6%      -4.3%      28235 ±  7%      -9.7%      26635 ±  7%  softirqs.CPU98.RCU
     22673 ± 24%     +16.7%      26470 ±  4%      +8.6%      24631 ± 19%  softirqs.CPU98.SCHED
     30.67 ± 43%   +1042.2%     350.29 ±182%     +31.4%      40.29 ± 72%  softirqs.CPU98.TIMER
     28764 ±  2%      -0.9%      28518 ±  6%      -7.3%      26656 ±  9%  softirqs.CPU99.RCU
     26541 ±  3%      +0.6%      26707           -14.6%      22672 ± 27%  softirqs.CPU99.SCHED
      7.00 ±223%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU99.TASKLET
     51.50 ±109%     +17.6%      60.57 ±127%     -39.3%      31.29 ± 27%  softirqs.CPU99.TIMER
      5.00            +0.0%       5.00            +0.0%       5.00        softirqs.HI
      5719 ± 31%    +134.4%      13408 ± 48%     +96.5%      11241 ± 85%  softirqs.NET_RX
     47.50 ±  2%      -5.3%      45.00 ±  2%      -2.6%      46.29 ±  2%  softirqs.NET_TX
   7687317 ±  2%      -2.5%    7491437 ±  5%      -7.6%    7105512 ±  9%  softirqs.RCU
   6434341            -0.4%    6410958            +0.5%    6463474        softirqs.SCHED
    291.67            -0.5%     290.29            -0.6%     289.86        softirqs.TASKLET
     53620 ±  2%      +0.2%      53743 ±  3%      +4.2%      55860 ±  2%  softirqs.TIMER
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.0:IR-IO-APIC.2-edge.timer
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.18:IR-IO-APIC.18-fasteoi.ehci_hcd:usb1,ehci_hcd:usb2,i801_smbus
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.31:IR-PCI-MSI.2621440-edge.eth0
      1577 ± 96%     -39.2%     958.43 ± 69%     +11.4%       1756 ± 61%  interrupts.32:IR-PCI-MSI.2621441-edge.eth0-TxRx-0
      1397 ±130%    +247.5%       4856 ±131%    +394.9%       6916 ±168%  interrupts.33:IR-PCI-MSI.2621442-edge.eth0-TxRx-1
      1193 ± 41%    +610.9%       8486 ±153%    +268.6%       4400 ±106%  interrupts.34:IR-PCI-MSI.2621443-edge.eth0-TxRx-2
      2739 ± 77%    +175.6%       7550 ±161%     -40.1%       1642 ± 42%  interrupts.35:IR-PCI-MSI.2621444-edge.eth0-TxRx-3
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.37:IR-PCI-MSI.3145729-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.38:IR-PCI-MSI.3145730-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.39:IR-PCI-MSI.3145731-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.3:IR-IO-APIC.3-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.40:IR-PCI-MSI.3145732-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.41:IR-PCI-MSI.327680-edge.xhci_hcd
      3.00            +0.0%       3.00            +0.0%       3.00        interrupts.42:IR-PCI-MSI.512000-edge.ahci[0000:00:1f.2]
     40.67 ±  4%      -0.9%      40.29 ±  4%      -0.9%      40.29 ±  4%  interrupts.4:IR-IO-APIC.4-edge.ttyS0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.8:IR-IO-APIC.8-edge.rtc0
      0.00          -100.0%       0.00       +5.7e+104%     574.71 ± 40%  interrupts.9:IR-IO-APIC.9-fasteoi.acpi
    353302            +0.1%     353702            -0.3%     352337        interrupts.CAL:Function_call_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.0:IR-IO-APIC.2-edge.timer
    938.00 ± 21%     -11.1%     833.86 ± 16%     -20.0%     750.29 ±  4%  interrupts.CPU0.CAL:Function_call_interrupts
    602641            -0.1%     601787            -7.2%     559520 ± 18%  interrupts.CPU0.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU0.MCP:Machine_check_polls
    210.00 ± 26%      -4.1%     201.29 ± 31%     +25.2%     262.86 ± 38%  interrupts.CPU0.NMI:Non-maskable_interrupts
    210.00 ± 26%      -4.1%     201.29 ± 31%     +25.2%     262.86 ± 38%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
      8.83 ± 34%      +8.4%       9.57 ± 68%    +207.3%      27.14 ± 32%  interrupts.CPU0.RES:Rescheduling_interrupts
     14.17 ± 17%     +18.0%      16.71 ± 12%     +16.0%      16.43 ± 22%  interrupts.CPU0.TLB:TLB_shootdowns
      0.00          -100.0%       0.00       +5.7e+104%     574.71 ± 40%  interrupts.CPU1.9:IR-IO-APIC.9-fasteoi.acpi
      1371 ±  5%     +18.9%       1630 ± 19%     +16.1%       1592 ± 18%  interrupts.CPU1.CAL:Function_call_interrupts
      0.50 ±223%    -100.0%       0.00           -71.4%       0.14 ±244%  interrupts.CPU1.IWI:IRQ_work_interrupts
    602267            -0.3%     600723            -7.1%     559218 ± 18%  interrupts.CPU1.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU1.MCP:Machine_check_polls
    994.33 ±172%     -78.9%     210.29 ± 33%     -77.8%     220.86 ± 40%  interrupts.CPU1.NMI:Non-maskable_interrupts
    994.33 ±172%     -78.9%     210.29 ± 33%     -77.8%     220.86 ± 40%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
     20.17 ± 36%     +42.4%      28.71 ± 31%     +16.2%      23.43 ± 27%  interrupts.CPU1.RES:Rescheduling_interrupts
    103.00 ±160%     -69.5%      31.43 ± 34%     -79.3%      21.29 ± 16%  interrupts.CPU1.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.8:IR-IO-APIC.8-edge.rtc0
      1651 ±  8%      -7.3%       1531 ±  9%      -3.7%       1591 ± 12%  interrupts.CPU10.CAL:Function_call_interrupts
    602439            -1.0%     596259 ±  2%      -7.2%     559157 ± 18%  interrupts.CPU10.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU10.MCP:Machine_check_polls
    264.83 ± 33%     -30.4%     184.29 ±  8%      +1.2%     268.00 ± 33%  interrupts.CPU10.NMI:Non-maskable_interrupts
    264.83 ± 33%     -30.4%     184.29 ±  8%      +1.2%     268.00 ± 33%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
     58.33 ± 17%     -12.1%      51.29 ± 51%     -13.1%      50.71 ± 30%  interrupts.CPU10.RES:Rescheduling_interrupts
     69.17 ± 10%      -9.9%      62.29 ± 17%     -20.5%      55.00 ± 37%  interrupts.CPU10.TLB:TLB_shootdowns
      1286 ±  3%      -1.6%       1265 ±  3%      +1.0%       1300 ±  6%  interrupts.CPU100.CAL:Function_call_interrupts
    602219            -2.9%     584454 ±  7%      -7.1%     559229 ± 18%  interrupts.CPU100.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU100.MCP:Machine_check_polls
    276.17 ± 33%     -23.1%     212.43 ±  6%     +20.5%     332.86 ± 29%  interrupts.CPU100.NMI:Non-maskable_interrupts
    276.17 ± 33%     -23.1%     212.43 ±  6%     +20.5%     332.86 ± 29%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
     17.83 ± 26%     -15.1%      15.14 ± 33%     +10.5%      19.71 ± 93%  interrupts.CPU100.RES:Rescheduling_interrupts
     16.17 ± 22%     +27.2%      20.57 ± 44%      +3.4%      16.71 ± 19%  interrupts.CPU100.TLB:TLB_shootdowns
      1225            +2.7%       1259 ±  4%      -5.2%       1161 ± 14%  interrupts.CPU101.CAL:Function_call_interrupts
    602064            -2.9%     584427 ±  7%      -7.1%     559262 ± 18%  interrupts.CPU101.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU101.MCP:Machine_check_polls
    323.67 ± 30%     +33.6%     432.43 ± 50%      +0.1%     324.14 ± 38%  interrupts.CPU101.NMI:Non-maskable_interrupts
    323.67 ± 30%     +33.6%     432.43 ± 50%      +0.1%     324.14 ± 38%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
     10.83 ± 30%     +74.1%      18.86 ± 64%      +4.2%      11.29 ± 42%  interrupts.CPU101.RES:Rescheduling_interrupts
     10.83 ± 11%     +13.4%      12.29 ± 38%      -5.1%      10.29 ± 26%  interrupts.CPU101.TLB:TLB_shootdowns
      1249 ±  3%      +3.6%       1294 ±  2%      +4.5%       1306 ±  5%  interrupts.CPU102.CAL:Function_call_interrupts
    602248            -3.3%     582586 ±  8%      -7.1%     559238 ± 18%  interrupts.CPU102.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU102.MCP:Machine_check_polls
    281.50 ± 33%     +24.7%     351.00 ± 25%      +8.4%     305.29 ± 34%  interrupts.CPU102.NMI:Non-maskable_interrupts
    281.50 ± 33%     +24.7%     351.00 ± 25%      +8.4%     305.29 ± 34%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
     13.83 ± 68%     +71.4%      23.71 ± 32%     +50.8%      20.86 ± 68%  interrupts.CPU102.RES:Rescheduling_interrupts
     14.17 ± 47%      +5.9%      15.00 ± 22%     +32.1%      18.71 ± 24%  interrupts.CPU102.TLB:TLB_shootdowns
      1235 ±  2%      +1.0%       1248 ± 15%      +0.1%       1237 ±  2%  interrupts.CPU103.CAL:Function_call_interrupts
      0.17 ±223%    +328.6%       0.71 ±244%    -100.0%       0.00        interrupts.CPU103.IWI:IRQ_work_interrupts
    602220            -3.6%     580424 ±  9%      -7.2%     559091 ± 18%  interrupts.CPU103.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU103.MCP:Machine_check_polls
    580.33 ±126%     -50.4%     288.00 ± 43%     -35.6%     373.57 ± 26%  interrupts.CPU103.NMI:Non-maskable_interrupts
    580.33 ±126%     -50.4%     288.00 ± 43%     -35.6%     373.57 ± 26%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
      8.17 ± 58%     +22.4%      10.00 ± 54%     +48.7%      12.14 ± 46%  interrupts.CPU103.RES:Rescheduling_interrupts
     10.33 ± 22%      -0.5%      10.29 ± 17%      -4.6%       9.86 ± 33%  interrupts.CPU103.TLB:TLB_shootdowns
      1292 ±  3%      -1.9%       1268 ±  4%      -2.7%       1257 ±  3%  interrupts.CPU104.CAL:Function_call_interrupts
    602286            -0.9%     597055 ±  2%      -7.2%     559089 ± 18%  interrupts.CPU104.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU104.MCP:Machine_check_polls
    279.17 ± 25%     -13.2%     242.43 ± 35%      -3.6%     269.00 ± 37%  interrupts.CPU104.NMI:Non-maskable_interrupts
    279.17 ± 25%     -13.2%     242.43 ± 35%      -3.6%     269.00 ± 37%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
     17.67 ± 25%     -36.1%      11.29 ± 56%     -19.9%      14.14 ± 32%  interrupts.CPU104.RES:Rescheduling_interrupts
     18.17 ± 16%     -27.7%      13.14 ± 32%      -4.1%      17.43 ± 15%  interrupts.CPU104.TLB:TLB_shootdowns
      1285 ±  9%      +2.2%       1313 ± 10%      -3.2%       1244        interrupts.CPU105.CAL:Function_call_interrupts
    602223            -2.4%     587692 ±  6%      -7.2%     559089 ± 18%  interrupts.CPU105.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU105.MCP:Machine_check_polls
    275.83 ± 32%      -4.2%     264.29 ± 33%      -5.2%     261.43 ± 38%  interrupts.CPU105.NMI:Non-maskable_interrupts
    275.83 ± 32%      -4.2%     264.29 ± 33%      -5.2%     261.43 ± 38%  interrupts.CPU105.PMI:Performance_monitoring_interrupts
     10.00 ± 21%      +4.3%      10.43 ± 22%     +28.6%      12.86 ± 36%  interrupts.CPU105.RES:Rescheduling_interrupts
      9.33 ± 24%     +11.7%      10.43 ± 28%     +14.8%      10.71 ± 35%  interrupts.CPU105.TLB:TLB_shootdowns
      1200 ± 17%     +22.2%       1465 ± 27%      +9.7%       1315 ±  7%  interrupts.CPU106.CAL:Function_call_interrupts
    602107            -3.6%     580540 ±  9%      -7.1%     559257 ± 18%  interrupts.CPU106.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU106.MCP:Machine_check_polls
    275.17 ± 32%      -4.3%     263.43 ± 30%      -6.8%     256.43 ± 42%  interrupts.CPU106.NMI:Non-maskable_interrupts
    275.17 ± 32%      -4.3%     263.43 ± 30%      -6.8%     256.43 ± 42%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
     16.17 ± 40%    +120.0%      35.57 ±113%     +16.6%      18.86 ±125%  interrupts.CPU106.RES:Rescheduling_interrupts
     20.17 ± 45%      -5.1%      19.14 ± 23%     -25.6%      15.00 ± 29%  interrupts.CPU106.TLB:TLB_shootdowns
      1238            +4.1%       1289 ±  9%      +1.0%       1250 ±  2%  interrupts.CPU107.CAL:Function_call_interrupts
    601964            -2.4%     587496 ±  6%      -7.1%     558956 ± 18%  interrupts.CPU107.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU107.MCP:Machine_check_polls
    243.83 ± 29%     +12.0%     273.14 ± 36%      -5.8%     229.57 ± 36%  interrupts.CPU107.NMI:Non-maskable_interrupts
    243.83 ± 29%     +12.0%     273.14 ± 36%      -5.8%     229.57 ± 36%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
     11.67 ± 45%     +42.0%      16.57 ± 92%      +6.5%      12.43 ± 43%  interrupts.CPU107.RES:Rescheduling_interrupts
     12.00 ± 35%     +17.9%      14.14 ± 35%     -15.5%      10.14 ± 23%  interrupts.CPU107.TLB:TLB_shootdowns
      1254 ±  2%      +8.0%       1354 ± 11%      -0.2%       1251 ±  2%  interrupts.CPU108.CAL:Function_call_interrupts
    602052            -1.0%     596224 ±  2%      -7.1%     559206 ± 18%  interrupts.CPU108.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU108.MCP:Machine_check_polls
    200.83 ± 28%     +35.6%     272.29 ± 31%      -6.4%     188.00 ± 36%  interrupts.CPU108.NMI:Non-maskable_interrupts
    200.83 ± 28%     +35.6%     272.29 ± 31%      -6.4%     188.00 ± 36%  interrupts.CPU108.PMI:Performance_monitoring_interrupts
     11.33 ± 26%    +129.4%      26.00 ± 93%     +12.2%      12.71 ± 64%  interrupts.CPU108.RES:Rescheduling_interrupts
     18.17 ± 11%     -12.7%      15.86 ± 27%     -17.4%      15.00 ± 40%  interrupts.CPU108.TLB:TLB_shootdowns
      1244            +4.8%       1303 ±  8%      -0.9%       1233        interrupts.CPU109.CAL:Function_call_interrupts
    602090            -1.2%     594801 ±  3%      -7.1%     559235 ± 18%  interrupts.CPU109.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU109.MCP:Machine_check_polls
    228.33 ± 33%      +7.4%     245.29 ± 34%      -6.0%     214.57 ± 41%  interrupts.CPU109.NMI:Non-maskable_interrupts
    228.33 ± 33%      +7.4%     245.29 ± 34%      -6.0%     214.57 ± 41%  interrupts.CPU109.PMI:Performance_monitoring_interrupts
      9.50 ± 52%     +82.0%      17.29 ± 98%     +11.3%      10.57 ± 29%  interrupts.CPU109.RES:Rescheduling_interrupts
     10.33 ± 26%      +2.3%      10.57 ± 13%      -7.4%       9.57 ± 14%  interrupts.CPU109.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.31:IR-PCI-MSI.2621440-edge.eth0
      1320 ±  3%     +16.7%       1541 ± 31%      -1.1%       1306 ±  5%  interrupts.CPU11.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +4.3e+101%       0.43 ±244%  interrupts.CPU11.IWI:IRQ_work_interrupts
    602345            -0.9%     597193 ±  2%      -7.2%     559105 ± 18%  interrupts.CPU11.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU11.MCP:Machine_check_polls
    180.33 ±  2%     +30.6%     235.57 ± 41%     +52.7%     275.43 ± 28%  interrupts.CPU11.NMI:Non-maskable_interrupts
    180.33 ±  2%     +30.6%     235.57 ± 41%     +52.7%     275.43 ± 28%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
     21.67 ± 18%     +75.4%      38.00 ± 89%      +6.2%      23.00 ± 61%  interrupts.CPU11.RES:Rescheduling_interrupts
     14.83 ± 15%     +10.8%      16.43 ± 15%     +11.7%      16.57 ± 23%  interrupts.CPU11.TLB:TLB_shootdowns
      1281 ±  3%      -0.3%       1277 ±  5%      -1.7%       1260 ±  3%  interrupts.CPU110.CAL:Function_call_interrupts
      0.00       +4.3e+101%       0.43 ±169%    -100.0%       0.00        interrupts.CPU110.IWI:IRQ_work_interrupts
    602273            -3.0%     583980 ±  7%      -7.2%     559155 ± 18%  interrupts.CPU110.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU110.MCP:Machine_check_polls
    294.83 ± 32%     +68.5%     496.86 ±123%      +4.6%     308.43 ± 40%  interrupts.CPU110.NMI:Non-maskable_interrupts
    294.83 ± 32%     +68.5%     496.86 ±123%      +4.6%     308.43 ± 40%  interrupts.CPU110.PMI:Performance_monitoring_interrupts
     18.83 ± 29%     -10.5%      16.86 ± 63%     -31.7%      12.86 ± 60%  interrupts.CPU110.RES:Rescheduling_interrupts
     17.83 ±  7%      -9.5%      16.14 ± 34%     -25.5%      13.29 ± 36%  interrupts.CPU110.TLB:TLB_shootdowns
      1283 ±  5%      -4.9%       1220            -3.3%       1241        interrupts.CPU111.CAL:Function_call_interrupts
    602123            -3.2%     582844 ±  8%      -7.1%     559178 ± 18%  interrupts.CPU111.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU111.MCP:Machine_check_polls
    292.67 ± 30%     -18.4%     238.71 ± 40%     -17.8%     240.57 ± 41%  interrupts.CPU111.NMI:Non-maskable_interrupts
    292.67 ± 30%     -18.4%     238.71 ± 40%     -17.8%     240.57 ± 41%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
     11.33 ± 25%     -18.1%       9.29 ± 44%     +13.4%      12.86 ± 38%  interrupts.CPU111.RES:Rescheduling_interrupts
      9.17 ± 17%      +7.5%       9.86 ± 28%      -1.8%       9.00 ± 11%  interrupts.CPU111.TLB:TLB_shootdowns
      1251 ±  4%      +2.7%       1285 ±  2%      +2.5%       1282 ±  3%  interrupts.CPU112.CAL:Function_call_interrupts
      0.50 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU112.IWI:IRQ_work_interrupts
    602238            -2.5%     587237 ±  6%      -7.1%     559321 ± 18%  interrupts.CPU112.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU112.MCP:Machine_check_polls
    286.17 ± 40%      +7.9%     308.86 ± 30%     -14.2%     245.57 ± 42%  interrupts.CPU112.NMI:Non-maskable_interrupts
    286.17 ± 40%      +7.9%     308.86 ± 30%     -14.2%     245.57 ± 42%  interrupts.CPU112.PMI:Performance_monitoring_interrupts
     16.00 ± 52%     +17.0%      18.71 ± 37%     +12.5%      18.00 ± 25%  interrupts.CPU112.RES:Rescheduling_interrupts
     14.00 ± 36%     +26.5%      17.71 ± 34%     +26.5%      17.71 ± 22%  interrupts.CPU112.TLB:TLB_shootdowns
      1304 ±  8%      -6.3%       1221            -5.1%       1238 ±  2%  interrupts.CPU113.CAL:Function_call_interrupts
    602251            -3.2%     582996 ±  7%      -7.1%     559199 ± 18%  interrupts.CPU113.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU113.MCP:Machine_check_polls
    260.50 ± 34%      +8.9%     283.57 ± 36%     -18.7%     211.86 ± 36%  interrupts.CPU113.NMI:Non-maskable_interrupts
    260.50 ± 34%      +8.9%     283.57 ± 36%     -18.7%     211.86 ± 36%  interrupts.CPU113.PMI:Performance_monitoring_interrupts
     20.83 ± 66%     -67.1%       6.86 ± 25%     -48.6%      10.71 ± 18%  interrupts.CPU113.RES:Rescheduling_interrupts
     16.17 ± 56%     -18.7%      13.14 ± 36%     -17.8%      13.29 ± 23%  interrupts.CPU113.TLB:TLB_shootdowns
      1312 ± 10%      +5.2%       1380 ± 15%      -1.3%       1295 ±  3%  interrupts.CPU114.CAL:Function_call_interrupts
    602415            -2.5%     587652 ±  6%      -7.2%     559231 ± 18%  interrupts.CPU114.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU114.MCP:Machine_check_polls
    308.33 ± 35%      -6.6%     288.00 ± 33%     -19.2%     249.00 ± 40%  interrupts.CPU114.NMI:Non-maskable_interrupts
    308.33 ± 35%      -6.6%     288.00 ± 33%     -19.2%     249.00 ± 40%  interrupts.CPU114.PMI:Performance_monitoring_interrupts
     19.17 ± 72%     +58.8%      30.43 ± 71%     -11.3%      17.00 ± 42%  interrupts.CPU114.RES:Rescheduling_interrupts
     12.00 ± 45%    +589.3%      82.71 ±184%     +45.2%      17.43 ± 24%  interrupts.CPU114.TLB:TLB_shootdowns
      1280 ±  6%      +6.6%       1365 ± 13%      -3.5%       1235 ±  2%  interrupts.CPU115.CAL:Function_call_interrupts
    602230            -3.4%     581740 ±  8%      -7.1%     559193 ± 18%  interrupts.CPU115.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU115.MCP:Machine_check_polls
    285.67 ± 35%     -19.1%     231.00 ± 29%      -5.1%     271.00 ± 40%  interrupts.CPU115.NMI:Non-maskable_interrupts
    285.67 ± 35%     -19.1%     231.00 ± 29%      -5.1%     271.00 ± 40%  interrupts.CPU115.PMI:Performance_monitoring_interrupts
     12.50 ± 25%     +87.4%      23.43 ± 85%     -21.1%       9.86 ± 46%  interrupts.CPU115.RES:Rescheduling_interrupts
     12.50 ± 51%     +47.4%      18.43 ±104%     -21.1%       9.86 ± 36%  interrupts.CPU115.TLB:TLB_shootdowns
      1411 ± 26%      -7.6%       1303 ±  5%      -7.9%       1299 ±  5%  interrupts.CPU116.CAL:Function_call_interrupts
    602260            -2.7%     585943 ±  6%      -7.1%     559278 ± 18%  interrupts.CPU116.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU116.MCP:Machine_check_polls
    246.67 ± 30%     +12.4%     277.29 ± 35%     +10.7%     273.14 ± 36%  interrupts.CPU116.NMI:Non-maskable_interrupts
    246.67 ± 30%     +12.4%     277.29 ± 35%     +10.7%     273.14 ± 36%  interrupts.CPU116.PMI:Performance_monitoring_interrupts
     12.50 ± 31%     +78.3%      22.29 ± 55%      +0.6%      12.57 ± 28%  interrupts.CPU116.RES:Rescheduling_interrupts
     15.33 ± 55%      +0.6%      15.43 ± 23%     -21.7%      12.00 ± 23%  interrupts.CPU116.TLB:TLB_shootdowns
      1230 ±  2%      -0.2%       1227            +0.2%       1232 ±  2%  interrupts.CPU117.CAL:Function_call_interrupts
      0.00       +2.9e+101%       0.29 ±244%    -100.0%       0.00        interrupts.CPU117.IWI:IRQ_work_interrupts
    602274            -4.1%     577303 ± 10%      -7.1%     559289 ± 18%  interrupts.CPU117.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU117.MCP:Machine_check_polls
    284.00 ± 34%      +0.1%     284.29 ± 32%     -17.6%     234.00 ± 36%  interrupts.CPU117.NMI:Non-maskable_interrupts
    284.00 ± 34%      +0.1%     284.29 ± 32%     -17.6%     234.00 ± 36%  interrupts.CPU117.PMI:Performance_monitoring_interrupts
      8.67 ± 59%     +13.7%       9.86 ± 37%     +23.6%      10.71 ± 44%  interrupts.CPU117.RES:Rescheduling_interrupts
     10.83 ± 30%      -6.4%      10.14 ± 17%     -10.3%       9.71 ± 47%  interrupts.CPU117.TLB:TLB_shootdowns
      1289 ±  4%      -0.4%       1284 ±  4%      -0.3%       1285 ±  2%  interrupts.CPU118.CAL:Function_call_interrupts
    602267            -2.8%     585307 ±  6%      -7.2%     559157 ± 18%  interrupts.CPU118.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU118.MCP:Machine_check_polls
    324.17 ± 34%      -8.2%     297.71 ± 33%     -27.2%     235.86 ± 37%  interrupts.CPU118.NMI:Non-maskable_interrupts
    324.17 ± 34%      -8.2%     297.71 ± 33%     -27.2%     235.86 ± 37%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
     13.00 ± 40%     +52.7%      19.86 ± 51%     +25.3%      16.29 ± 41%  interrupts.CPU118.RES:Rescheduling_interrupts
     16.67 ± 29%      +7.1%      17.86 ± 24%      -8.3%      15.29 ± 27%  interrupts.CPU118.TLB:TLB_shootdowns
      1272 ±  8%      -1.7%       1250 ±  2%      -0.2%       1270 ±  7%  interrupts.CPU119.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +2.9e+101%       0.29 ±244%  interrupts.CPU119.IWI:IRQ_work_interrupts
    602271            -3.9%     578591 ±  9%      -7.2%     559178 ± 18%  interrupts.CPU119.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU119.MCP:Machine_check_polls
    311.83 ± 33%     +12.9%     352.00 ± 26%     +78.9%     557.86 ±142%  interrupts.CPU119.NMI:Non-maskable_interrupts
    311.83 ± 33%     +12.9%     352.00 ± 26%     +78.9%     557.86 ±142%  interrupts.CPU119.PMI:Performance_monitoring_interrupts
     14.67 ± 71%     -10.4%      13.14 ± 39%     -46.4%       7.86 ± 41%  interrupts.CPU119.RES:Rescheduling_interrupts
     16.17 ± 91%     -32.8%      10.86 ± 15%     -36.4%      10.29 ± 21%  interrupts.CPU119.TLB:TLB_shootdowns
      1577 ± 96%     -39.2%     958.43 ± 69%     +11.4%       1756 ± 61%  interrupts.CPU12.32:IR-PCI-MSI.2621441-edge.eth0-TxRx-0
      1654 ± 10%      -2.5%       1613 ± 13%      -5.1%       1569 ± 10%  interrupts.CPU12.CAL:Function_call_interrupts
    602141            -3.4%     581940 ±  8%      -7.1%     559223 ± 18%  interrupts.CPU12.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU12.MCP:Machine_check_polls
    252.33 ± 34%      -5.5%     238.43 ± 35%      -8.2%     231.57 ± 40%  interrupts.CPU12.NMI:Non-maskable_interrupts
    252.33 ± 34%      -5.5%     238.43 ± 35%      -8.2%     231.57 ± 40%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
     47.50 ± 45%     +17.6%      55.86 ± 34%     +26.3%      60.00 ± 31%  interrupts.CPU12.RES:Rescheduling_interrupts
     59.67 ± 28%      +0.3%      59.86 ± 23%     +17.3%      70.00 ± 27%  interrupts.CPU12.TLB:TLB_shootdowns
      1340 ±  3%      -3.3%       1296 ±  2%      +1.0%       1354 ± 11%  interrupts.CPU120.CAL:Function_call_interrupts
    602140            -2.5%     586956 ±  6%      -7.1%     559422 ± 18%  interrupts.CPU120.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU120.MCP:Machine_check_polls
    263.17 ± 32%      -4.2%     252.14 ± 31%      -7.1%     244.57 ± 41%  interrupts.CPU120.NMI:Non-maskable_interrupts
    263.17 ± 32%      -4.2%     252.14 ± 31%      -7.1%     244.57 ± 41%  interrupts.CPU120.PMI:Performance_monitoring_interrupts
     23.33 ± 31%     -27.8%      16.86 ± 48%     +40.8%      32.86 ±122%  interrupts.CPU120.RES:Rescheduling_interrupts
     15.17 ± 29%     +13.0%      17.14 ± 21%      +5.5%      16.00 ± 30%  interrupts.CPU120.TLB:TLB_shootdowns
      1224            +2.0%       1248 ±  3%      +7.4%       1314 ±  7%  interrupts.CPU121.CAL:Function_call_interrupts
    602087            -2.8%     585081 ±  7%      -7.1%     559254 ± 18%  interrupts.CPU121.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU121.MCP:Machine_check_polls
    231.00 ± 27%      +8.7%     251.00 ± 36%     +13.5%     262.29 ± 37%  interrupts.CPU121.NMI:Non-maskable_interrupts
    231.00 ± 27%      +8.7%     251.00 ± 36%     +13.5%     262.29 ± 37%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
     10.50 ± 41%      -7.5%       9.71 ± 66%    +113.6%      22.43 ± 66%  interrupts.CPU121.RES:Rescheduling_interrupts
      9.67 ± 28%     +37.4%      13.29 ± 34%     +65.5%      16.00 ± 29%  interrupts.CPU121.TLB:TLB_shootdowns
      1311 ±  3%      +4.2%       1366 ± 12%     +15.4%       1513 ± 29%  interrupts.CPU122.CAL:Function_call_interrupts
    602143            -2.8%     585452 ±  7%      -7.1%     559151 ± 18%  interrupts.CPU122.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU122.MCP:Machine_check_polls
    266.00 ± 33%     +17.6%     312.71 ± 44%      -7.1%     247.14 ± 42%  interrupts.CPU122.NMI:Non-maskable_interrupts
    266.00 ± 33%     +17.6%     312.71 ± 44%      -7.1%     247.14 ± 42%  interrupts.CPU122.PMI:Performance_monitoring_interrupts
     18.67 ± 27%     +40.1%      26.14 ± 86%     +93.6%      36.14 ±111%  interrupts.CPU122.RES:Rescheduling_interrupts
     19.33 ± 44%     -12.8%      16.86 ± 20%     -23.2%      14.86 ± 32%  interrupts.CPU122.TLB:TLB_shootdowns
      1255 ±  3%      +1.8%       1278 ±  7%      +3.9%       1303 ± 12%  interrupts.CPU123.CAL:Function_call_interrupts
    602119            -3.5%     581166 ±  8%      -7.1%     559190 ± 18%  interrupts.CPU123.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU123.MCP:Machine_check_polls
    233.00 ± 33%     +45.2%     338.43 ± 26%      -8.3%     213.57 ± 36%  interrupts.CPU123.NMI:Non-maskable_interrupts
    233.00 ± 33%     +45.2%     338.43 ± 26%      -8.3%     213.57 ± 36%  interrupts.CPU123.PMI:Performance_monitoring_interrupts
     16.00 ± 39%     -32.1%      10.86 ±116%     +38.4%      22.14 ±138%  interrupts.CPU123.RES:Rescheduling_interrupts
     11.83 ± 26%      -9.5%      10.71 ± 26%      -3.4%      11.43 ± 18%  interrupts.CPU123.TLB:TLB_shootdowns
      1268 ±  2%      +2.0%       1293 ±  4%      +5.3%       1334 ±  9%  interrupts.CPU124.CAL:Function_call_interrupts
    602066            -2.8%     585157 ±  7%      -7.2%     559000 ± 18%  interrupts.CPU124.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU124.MCP:Machine_check_polls
    278.00 ± 33%     +27.7%     355.00 ± 25%     -16.6%     231.71 ± 38%  interrupts.CPU124.NMI:Non-maskable_interrupts
    278.00 ± 33%     +27.7%     355.00 ± 25%     -16.6%     231.71 ± 38%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
     16.50 ± 30%     +33.3%      22.00 ± 42%     +36.8%      22.57 ± 57%  interrupts.CPU124.RES:Rescheduling_interrupts
     16.00 ± 20%      +3.6%      16.57 ± 21%      +9.8%      17.57 ± 20%  interrupts.CPU124.TLB:TLB_shootdowns
      1335 ± 19%      -7.3%       1238 ±  2%     -11.8%       1178 ± 15%  interrupts.CPU125.CAL:Function_call_interrupts
    602254            -4.1%     577856 ± 10%      -7.1%     559257 ± 18%  interrupts.CPU125.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU125.MCP:Machine_check_polls
    272.00 ± 35%      +6.8%     290.57 ± 32%     -12.4%     238.29 ± 30%  interrupts.CPU125.NMI:Non-maskable_interrupts
    272.00 ± 35%      +6.8%     290.57 ± 32%     -12.4%     238.29 ± 30%  interrupts.CPU125.PMI:Performance_monitoring_interrupts
      7.83 ± 46%     +89.7%      14.86 ± 44%     +78.7%      14.00 ± 33%  interrupts.CPU125.RES:Rescheduling_interrupts
      9.50 ± 15%     +15.8%      11.00 ± 23%     +20.3%      11.43 ± 18%  interrupts.CPU125.TLB:TLB_shootdowns
      1353 ±  3%      -2.2%       1324 ±  4%      +7.1%       1450 ± 19%  interrupts.CPU126.CAL:Function_call_interrupts
    602483            -2.7%     586200 ±  6%      -7.2%     558992 ± 18%  interrupts.CPU126.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU126.MCP:Machine_check_polls
    285.67 ± 35%     -17.1%     236.71 ± 23%      -7.5%     264.29 ± 40%  interrupts.CPU126.NMI:Non-maskable_interrupts
    285.67 ± 35%     -17.1%     236.71 ± 23%      -7.5%     264.29 ± 40%  interrupts.CPU126.PMI:Performance_monitoring_interrupts
     26.83 ± 34%      +2.2%      27.43 ± 35%     +39.5%      37.43 ± 98%  interrupts.CPU126.RES:Rescheduling_interrupts
     24.00 ± 19%     -24.4%      18.14 ± 33%      +0.6%      24.14 ± 28%  interrupts.CPU126.TLB:TLB_shootdowns
      1237            +5.2%       1301 ±  4%      +3.5%       1279 ±  4%  interrupts.CPU127.CAL:Function_call_interrupts
    602183            -4.4%     575869 ± 11%      -7.2%     559060 ± 18%  interrupts.CPU127.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU127.MCP:Machine_check_polls
    327.50 ± 34%      +0.4%     328.71 ± 45%     -27.8%     236.43 ± 38%  interrupts.CPU127.NMI:Non-maskable_interrupts
    327.50 ± 34%      +0.4%     328.71 ± 45%     -27.8%     236.43 ± 38%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
     13.33 ± 31%     +70.4%      22.71 ± 45%     +14.6%      15.29 ± 49%  interrupts.CPU127.RES:Rescheduling_interrupts
     10.50 ± 15%     +52.4%      16.00 ± 38%     +27.9%      13.43 ± 17%  interrupts.CPU127.TLB:TLB_shootdowns
      1452 ± 36%     -14.7%       1238 ±  4%     -15.6%       1226        interrupts.CPU128.CAL:Function_call_interrupts
    602002            -2.9%     584363 ±  7%      -7.1%     559052 ± 18%  interrupts.CPU128.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU128.MCP:Machine_check_polls
    257.50 ± 30%     +21.1%     311.86 ± 29%     -14.1%     221.14 ± 37%  interrupts.CPU128.NMI:Non-maskable_interrupts
    257.50 ± 30%     +21.1%     311.86 ± 29%     -14.1%     221.14 ± 37%  interrupts.CPU128.PMI:Performance_monitoring_interrupts
      9.50 ± 24%      -2.3%       9.29 ±117%     -39.8%       5.71 ± 67%  interrupts.CPU128.RES:Rescheduling_interrupts
      7.33 ± 17%     +24.7%       9.14 ± 48%      +9.1%       8.00 ± 36%  interrupts.CPU128.TLB:TLB_shootdowns
      1219            +0.1%       1220           +14.2%       1392 ± 31%  interrupts.CPU129.CAL:Function_call_interrupts
    601757            -2.1%     588982 ±  5%      -7.1%     558915 ± 18%  interrupts.CPU129.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU129.MCP:Machine_check_polls
    519.83 ±117%     -20.7%     412.14 ±  4%     -52.9%     244.86 ± 31%  interrupts.CPU129.NMI:Non-maskable_interrupts
    519.83 ±117%     -20.7%     412.14 ±  4%     -52.9%     244.86 ± 31%  interrupts.CPU129.PMI:Performance_monitoring_interrupts
      7.67 ± 25%      -8.7%       7.00 ± 31%     -25.5%       5.71 ± 30%  interrupts.CPU129.RES:Rescheduling_interrupts
      9.83 ± 69%     -33.2%       6.57 ± 11%     -23.0%       7.57 ± 41%  interrupts.CPU129.TLB:TLB_shootdowns
      1397 ±130%    +247.5%       4856 ±131%    +394.9%       6916 ±168%  interrupts.CPU13.33:IR-PCI-MSI.2621442-edge.eth0-TxRx-1
      1370 ±  6%      -0.4%       1365 ±  4%      -0.4%       1365 ±  3%  interrupts.CPU13.CAL:Function_call_interrupts
    602371            -2.8%     585259 ±  7%      -7.2%     559294 ± 18%  interrupts.CPU13.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU13.MCP:Machine_check_polls
    269.67 ± 35%      +2.2%     275.57 ± 28%      -8.5%     246.86 ± 40%  interrupts.CPU13.NMI:Non-maskable_interrupts
    269.67 ± 35%      +2.2%     275.57 ± 28%      -8.5%     246.86 ± 40%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
     32.00 ± 51%     +27.2%      40.71 ± 46%      +1.3%      32.43 ± 34%  interrupts.CPU13.RES:Rescheduling_interrupts
     22.50 ± 60%     -11.1%      20.00 ± 25%      -4.8%      21.43 ± 26%  interrupts.CPU13.TLB:TLB_shootdowns
      1232            -0.6%       1224            +0.6%       1240 ±  2%  interrupts.CPU130.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU130.IWI:IRQ_work_interrupts
    602189            -1.3%     594108 ±  3%      -7.1%     559152 ± 18%  interrupts.CPU130.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU130.MCP:Machine_check_polls
    233.50 ± 35%     +81.9%     424.71 ± 54%     +10.4%     257.86 ± 45%  interrupts.CPU130.NMI:Non-maskable_interrupts
    233.50 ± 35%     +81.9%     424.71 ± 54%     +10.4%     257.86 ± 45%  interrupts.CPU130.PMI:Performance_monitoring_interrupts
      9.33 ± 34%     -28.1%       6.71 ± 72%     +25.5%      11.71 ± 44%  interrupts.CPU130.RES:Rescheduling_interrupts
      9.67 ± 22%     +10.8%      10.71 ± 33%      +0.5%       9.71 ± 35%  interrupts.CPU130.TLB:TLB_shootdowns
      1215            +0.5%       1221            +3.8%       1261 ±  5%  interrupts.CPU131.CAL:Function_call_interrupts
    602190            -1.9%     591005 ±  4%      -7.2%     558994 ± 18%  interrupts.CPU131.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU131.MCP:Machine_check_polls
    224.33 ± 29%     +12.1%     251.57 ± 37%     +16.0%     260.14 ± 37%  interrupts.CPU131.NMI:Non-maskable_interrupts
    224.33 ± 29%     +12.1%     251.57 ± 37%     +16.0%     260.14 ± 37%  interrupts.CPU131.PMI:Performance_monitoring_interrupts
     10.00 ± 51%     -45.7%       5.43 ± 66%     +47.1%      14.71 ± 99%  interrupts.CPU131.RES:Rescheduling_interrupts
      8.67 ± 10%      -4.4%       8.29 ± 20%      +0.5%       8.71 ± 24%  interrupts.CPU131.TLB:TLB_shootdowns
      1227            +0.3%       1230 ±  2%      -0.6%       1219        interrupts.CPU132.CAL:Function_call_interrupts
    601945            -1.9%     590610 ±  4%      -7.1%     559213 ± 18%  interrupts.CPU132.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU132.MCP:Machine_check_polls
    290.50 ± 32%     -22.5%     225.14 ± 27%     -16.1%     243.86 ± 42%  interrupts.CPU132.NMI:Non-maskable_interrupts
    290.50 ± 32%     -22.5%     225.14 ± 27%     -16.1%     243.86 ± 42%  interrupts.CPU132.PMI:Performance_monitoring_interrupts
     10.83 ± 66%     -15.6%       9.14 ± 46%     -40.7%       6.43 ± 54%  interrupts.CPU132.RES:Rescheduling_interrupts
      9.50 ± 20%     +26.3%      12.00 ± 55%      +6.8%      10.14 ± 33%  interrupts.CPU132.TLB:TLB_shootdowns
      1230 ±  2%      +1.7%       1250 ±  5%      -1.2%       1215        interrupts.CPU133.CAL:Function_call_interrupts
    601988            -2.0%     590034 ±  4%      -7.1%     559114 ± 18%  interrupts.CPU133.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU133.MCP:Machine_check_polls
    259.50 ± 33%     +29.1%     335.00 ± 26%      -5.6%     245.00 ± 42%  interrupts.CPU133.NMI:Non-maskable_interrupts
    259.50 ± 33%     +29.1%     335.00 ± 26%      -5.6%     245.00 ± 42%  interrupts.CPU133.PMI:Performance_monitoring_interrupts
      7.17 ± 56%    +111.3%      15.14 ± 78%     +55.5%      11.14 ± 53%  interrupts.CPU133.RES:Rescheduling_interrupts
      9.83 ± 19%     +23.5%      12.14 ± 61%      -7.0%       9.14 ± 31%  interrupts.CPU133.TLB:TLB_shootdowns
      1223            +3.9%       1270 ±  6%      +0.8%       1233 ±  3%  interrupts.CPU134.CAL:Function_call_interrupts
    602217            -1.2%     595114 ±  2%      -7.2%     559048 ± 18%  interrupts.CPU134.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU134.MCP:Machine_check_polls
    228.83 ± 35%      +4.7%     239.57 ± 33%      +1.5%     232.29 ± 30%  interrupts.CPU134.NMI:Non-maskable_interrupts
    228.83 ± 35%      +4.7%     239.57 ± 33%      +1.5%     232.29 ± 30%  interrupts.CPU134.PMI:Performance_monitoring_interrupts
      8.00 ± 47%    +103.6%      16.29 ± 86%     +30.4%      10.43 ± 48%  interrupts.CPU134.RES:Rescheduling_interrupts
      9.83 ± 30%     +81.6%      17.86 ± 80%      -7.0%       9.14 ± 30%  interrupts.CPU134.TLB:TLB_shootdowns
      1237 ±  3%      -0.3%       1234 ±  2%      -2.1%       1211        interrupts.CPU135.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +2.9e+101%       0.29 ±244%  interrupts.CPU135.IWI:IRQ_work_interrupts
    602202            -1.1%     595668 ±  2%      -7.2%     559020 ± 18%  interrupts.CPU135.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU135.MCP:Machine_check_polls
    203.50 ± 33%     +20.7%     245.71 ± 33%      +4.3%     212.29 ± 28%  interrupts.CPU135.NMI:Non-maskable_interrupts
    203.50 ± 33%     +20.7%     245.71 ± 33%      +4.3%     212.29 ± 28%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
     13.67 ± 37%     -25.8%      10.14 ± 64%     -68.6%       4.29 ± 34%  interrupts.CPU135.RES:Rescheduling_interrupts
     11.17 ± 53%     -19.4%       9.00 ± 24%     -29.6%       7.86 ± 22%  interrupts.CPU135.TLB:TLB_shootdowns
      1251 ±  4%      -2.4%       1220            -0.7%       1241 ±  3%  interrupts.CPU136.CAL:Function_call_interrupts
    602075            -3.6%     580691 ±  8%      -7.1%     559101 ± 18%  interrupts.CPU136.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU136.MCP:Machine_check_polls
    226.50 ± 29%     +34.1%     303.71 ± 31%     +18.1%     267.43 ± 44%  interrupts.CPU136.NMI:Non-maskable_interrupts
    226.50 ± 29%     +34.1%     303.71 ± 31%     +18.1%     267.43 ± 44%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
     12.83 ± 47%     -22.1%      10.00 ± 43%     -28.8%       9.14 ± 47%  interrupts.CPU136.RES:Rescheduling_interrupts
     11.00 ± 65%     -22.1%       8.57 ± 24%     -15.6%       9.29 ± 34%  interrupts.CPU136.TLB:TLB_shootdowns
      1256 ±  4%      +4.7%       1315 ± 14%      -1.6%       1236 ±  2%  interrupts.CPU137.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +8.6e+101%       0.86 ±244%  interrupts.CPU137.IWI:IRQ_work_interrupts
    601958            -2.6%     586042 ±  6%      -7.1%     558990 ± 18%  interrupts.CPU137.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU137.MCP:Machine_check_polls
    324.67 ± 26%     -29.2%     229.71 ± 31%     -12.7%     283.57 ± 47%  interrupts.CPU137.NMI:Non-maskable_interrupts
    324.67 ± 26%     -29.2%     229.71 ± 31%     -12.7%     283.57 ± 47%  interrupts.CPU137.PMI:Performance_monitoring_interrupts
     12.50 ± 85%     -28.0%       9.00 ± 64%     -36.0%       8.00 ± 59%  interrupts.CPU137.RES:Rescheduling_interrupts
     22.17 ±153%     -59.4%       9.00 ± 46%     -58.1%       9.29 ± 53%  interrupts.CPU137.TLB:TLB_shootdowns
      1227            -0.3%       1222 ±  3%      +0.8%       1236 ±  2%  interrupts.CPU138.CAL:Function_call_interrupts
    602361            -3.6%     580679 ±  9%      -7.2%     558987 ± 18%  interrupts.CPU138.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU138.MCP:Machine_check_polls
    264.67 ± 35%      +4.6%     276.71 ± 30%      +2.7%     271.86 ± 38%  interrupts.CPU138.NMI:Non-maskable_interrupts
    264.67 ± 35%      +4.6%     276.71 ± 30%      +2.7%     271.86 ± 38%  interrupts.CPU138.PMI:Performance_monitoring_interrupts
      9.17 ± 22%     -19.0%       7.43 ± 40%      +2.9%       9.43 ± 37%  interrupts.CPU138.RES:Rescheduling_interrupts
     11.33 ± 25%     +12.2%      12.71 ± 31%      +8.4%      12.29 ± 38%  interrupts.CPU138.TLB:TLB_shootdowns
      1234            +0.6%       1241 ±  3%      -0.5%       1227        interrupts.CPU139.CAL:Function_call_interrupts
    602047            -3.1%     583337 ±  7%      -7.2%     558876 ± 18%  interrupts.CPU139.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU139.MCP:Machine_check_polls
    237.83 ± 30%     +33.8%     318.14 ± 31%      +9.1%     259.43 ± 36%  interrupts.CPU139.NMI:Non-maskable_interrupts
    237.83 ± 30%     +33.8%     318.14 ± 31%      +9.1%     259.43 ± 36%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
     12.83 ± 51%     -64.4%       4.57 ± 62%     -38.8%       7.86 ± 46%  interrupts.CPU139.RES:Rescheduling_interrupts
      7.67 ±  6%     +19.3%       9.14 ± 22%      -1.2%       7.57 ± 11%  interrupts.CPU139.TLB:TLB_shootdowns
      1193 ± 41%    +610.9%       8486 ±153%    +268.6%       4400 ±106%  interrupts.CPU14.34:IR-PCI-MSI.2621443-edge.eth0-TxRx-2
      2165 ± 70%     -12.8%       1887 ± 48%      +8.7%       2354 ± 72%  interrupts.CPU14.CAL:Function_call_interrupts
    602237            -0.4%     599851            -7.1%     559360 ± 18%  interrupts.CPU14.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU14.MCP:Machine_check_polls
    261.67 ± 30%     -17.3%     216.29 ± 27%     +19.8%     313.43 ± 32%  interrupts.CPU14.NMI:Non-maskable_interrupts
    261.67 ± 30%     -17.3%     216.29 ± 27%     +19.8%     313.43 ± 32%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    115.33 ±125%      +8.8%     125.43 ±116%     +20.1%     138.57 ±121%  interrupts.CPU14.RES:Rescheduling_interrupts
     62.00 ± 25%      +4.8%      65.00 ± 23%      +8.1%      67.00 ± 19%  interrupts.CPU14.TLB:TLB_shootdowns
      1275 ±  9%      +0.2%       1278 ±  6%      -3.9%       1225        interrupts.CPU140.CAL:Function_call_interrupts
    602203            -5.7%     567897 ± 14%      -7.2%     558978 ± 18%  interrupts.CPU140.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU140.MCP:Machine_check_polls
    282.17 ± 36%     +17.2%     330.71 ± 32%     -12.3%     247.57 ± 31%  interrupts.CPU140.NMI:Non-maskable_interrupts
    282.17 ± 36%     +17.2%     330.71 ± 32%     -12.3%     247.57 ± 31%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
     13.67 ± 67%     -16.4%      11.43 ± 34%     -73.9%       3.57 ± 85%  interrupts.CPU140.RES:Rescheduling_interrupts
     15.33 ± 75%     -16.1%      12.86 ± 22%     -33.9%      10.14 ± 28%  interrupts.CPU140.TLB:TLB_shootdowns
      1241 ±  3%      +2.0%       1265 ±  7%      -1.4%       1223        interrupts.CPU141.CAL:Function_call_interrupts
    601885            -4.8%     573171 ± 12%      -7.1%     558916 ± 18%  interrupts.CPU141.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU141.MCP:Machine_check_polls
    312.50 ± 31%     +14.0%     356.14 ± 25%     -11.8%     275.71 ± 34%  interrupts.CPU141.NMI:Non-maskable_interrupts
    312.50 ± 31%     +14.0%     356.14 ± 25%     -11.8%     275.71 ± 34%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
     12.33 ± 43%     -23.6%       9.43 ± 52%     -40.9%       7.29 ± 54%  interrupts.CPU141.RES:Rescheduling_interrupts
      8.67 ± 28%     +10.4%       9.57 ± 18%      +3.8%       9.00 ± 27%  interrupts.CPU141.TLB:TLB_shootdowns
      1267 ±  7%      -3.6%       1221            -3.6%       1222        interrupts.CPU142.CAL:Function_call_interrupts
    602153            -4.2%     576909 ± 10%      -7.1%     559163 ± 18%  interrupts.CPU142.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU142.MCP:Machine_check_polls
    245.50 ± 31%     +10.0%     270.00 ± 36%     +11.7%     274.14 ± 34%  interrupts.CPU142.NMI:Non-maskable_interrupts
    245.50 ± 31%     +10.0%     270.00 ± 36%     +11.7%     274.14 ± 34%  interrupts.CPU142.PMI:Performance_monitoring_interrupts
     14.00 ± 67%     -62.2%       5.29 ± 67%     -34.7%       9.14 ± 46%  interrupts.CPU142.RES:Rescheduling_interrupts
      9.17 ± 23%      +4.4%       9.57 ±  9%     +24.7%      11.43 ± 20%  interrupts.CPU142.TLB:TLB_shootdowns
      1251 ±  7%      +3.1%       1290 ± 13%      +6.7%       1335 ± 12%  interrupts.CPU143.CAL:Function_call_interrupts
    602168            -3.0%     584227 ±  7%      -7.2%     559032 ± 18%  interrupts.CPU143.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU143.MCP:Machine_check_polls
    328.83 ± 36%      -8.0%     302.43 ± 36%     -20.6%     261.00 ± 42%  interrupts.CPU143.NMI:Non-maskable_interrupts
    328.83 ± 36%      -8.0%     302.43 ± 36%     -20.6%     261.00 ± 42%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
     10.67 ±123%     +43.3%      15.29 ± 75%     -19.6%       8.57 ± 84%  interrupts.CPU143.RES:Rescheduling_interrupts
      8.00 ± 16%     +14.3%       9.14 ± 20%     +16.1%       9.29 ± 18%  interrupts.CPU143.TLB:TLB_shootdowns
      1228            +0.5%       1234            +0.9%       1239        interrupts.CPU144.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU144.IWI:IRQ_work_interrupts
    602191            -2.6%     586660 ±  6%      -7.2%     559093 ± 18%  interrupts.CPU144.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU144.MCP:Machine_check_polls
    247.83 ± 33%     +20.6%     298.86 ± 36%    +176.4%     685.00 ±142%  interrupts.CPU144.NMI:Non-maskable_interrupts
    247.83 ± 33%     +20.6%     298.86 ± 36%    +176.4%     685.00 ±142%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
      9.67 ± 33%     +25.6%      12.14 ± 75%     -24.6%       7.29 ± 55%  interrupts.CPU144.RES:Rescheduling_interrupts
     11.17 ± 23%     -11.7%       9.86 ± 21%     -27.1%       8.14 ± 17%  interrupts.CPU144.TLB:TLB_shootdowns
      1218            +2.2%       1246 ±  3%      +0.3%       1222        interrupts.CPU145.CAL:Function_call_interrupts
    602106            -4.1%     577326 ± 10%      -7.2%     558784 ± 18%  interrupts.CPU145.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU145.MCP:Machine_check_polls
    253.67 ± 37%      +5.0%     266.29 ± 37%     +11.6%     283.00 ± 35%  interrupts.CPU145.NMI:Non-maskable_interrupts
    253.67 ± 37%      +5.0%     266.29 ± 37%     +11.6%     283.00 ± 35%  interrupts.CPU145.PMI:Performance_monitoring_interrupts
     11.50 ± 56%     +23.0%      14.14 ± 62%     -32.9%       7.71 ± 78%  interrupts.CPU145.RES:Rescheduling_interrupts
      9.83 ± 19%      -8.5%       9.00 ± 20%     -17.2%       8.14 ± 13%  interrupts.CPU145.TLB:TLB_shootdowns
      1344 ± 15%      -5.6%       1268 ±  3%      -7.6%       1241 ±  3%  interrupts.CPU146.CAL:Function_call_interrupts
    602131            -0.7%     598081            -7.1%     559095 ± 18%  interrupts.CPU146.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU146.MCP:Machine_check_polls
    201.67 ± 30%     +16.8%     235.57 ± 31%      +3.4%     208.57 ± 30%  interrupts.CPU146.NMI:Non-maskable_interrupts
    201.67 ± 30%     +16.8%     235.57 ± 31%      +3.4%     208.57 ± 30%  interrupts.CPU146.PMI:Performance_monitoring_interrupts
      6.00 ± 38%     +64.3%       9.86 ± 72%     +57.1%       9.43 ± 44%  interrupts.CPU146.RES:Rescheduling_interrupts
      9.67 ± 22%    +680.3%      75.43 ±202%     +15.3%      11.14 ± 20%  interrupts.CPU146.TLB:TLB_shootdowns
      1228 ±  2%      +1.3%       1244 ±  2%      -0.6%       1220        interrupts.CPU147.CAL:Function_call_interrupts
    602053            -2.1%     589639 ±  5%      -7.1%     559112 ± 18%  interrupts.CPU147.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU147.MCP:Machine_check_polls
    199.33 ± 33%      +0.9%     201.14 ± 29%     +63.9%     326.71 ± 84%  interrupts.CPU147.NMI:Non-maskable_interrupts
    199.33 ± 33%      +0.9%     201.14 ± 29%     +63.9%     326.71 ± 84%  interrupts.CPU147.PMI:Performance_monitoring_interrupts
      8.50 ± 74%     +51.3%      12.86 ± 89%     -14.3%       7.29 ± 44%  interrupts.CPU147.RES:Rescheduling_interrupts
      9.00 ± 19%      -6.3%       8.43 ± 13%     -17.5%       7.43 ± 26%  interrupts.CPU147.TLB:TLB_shootdowns
      1226 ±  2%      +2.0%       1251 ±  2%      +1.8%       1248 ±  2%  interrupts.CPU148.CAL:Function_call_interrupts
    601616            -2.7%     585370 ±  6%      -7.1%     559111 ± 18%  interrupts.CPU148.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU148.MCP:Machine_check_polls
    297.67 ± 32%      -3.2%     288.14 ± 34%     -21.5%     233.57 ± 31%  interrupts.CPU148.NMI:Non-maskable_interrupts
    297.67 ± 32%      -3.2%     288.14 ± 34%     -21.5%     233.57 ± 31%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
     12.50 ± 64%      +0.6%      12.57 ± 68%     -15.4%      10.57 ± 59%  interrupts.CPU148.RES:Rescheduling_interrupts
     10.83 ± 24%      -2.4%      10.57 ± 29%      -3.7%      10.43 ± 21%  interrupts.CPU148.TLB:TLB_shootdowns
      1230            -0.1%       1229 ±  2%      +0.5%       1236        interrupts.CPU149.CAL:Function_call_interrupts
    602249            -3.1%     583504 ±  7%      -7.2%     559082 ± 18%  interrupts.CPU149.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU149.MCP:Machine_check_polls
    264.17 ± 36%      +9.3%     288.86 ± 37%      -6.8%     246.29 ± 41%  interrupts.CPU149.NMI:Non-maskable_interrupts
    264.17 ± 36%      +9.3%     288.86 ± 37%      -6.8%     246.29 ± 41%  interrupts.CPU149.PMI:Performance_monitoring_interrupts
      9.00 ± 41%      -4.8%       8.57 ± 69%     +23.8%      11.14 ± 53%  interrupts.CPU149.RES:Rescheduling_interrupts
      9.17 ± 37%      +2.9%       9.43 ± 46%      -8.1%       8.43 ± 26%  interrupts.CPU149.TLB:TLB_shootdowns
      2739 ± 77%    +175.6%       7550 ±161%     -40.1%       1642 ± 42%  interrupts.CPU15.35:IR-PCI-MSI.2621444-edge.eth0-TxRx-3
      1591 ± 33%      +2.6%       1632 ± 31%      -2.6%       1549 ± 21%  interrupts.CPU15.CAL:Function_call_interrupts
    602448            -0.5%     599434            -7.1%     559385 ± 18%  interrupts.CPU15.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU15.MCP:Machine_check_polls
    299.67 ± 29%     -31.3%     206.00 ± 28%      -8.4%     274.43 ± 37%  interrupts.CPU15.NMI:Non-maskable_interrupts
    299.67 ± 29%     -31.3%     206.00 ± 28%      -8.4%     274.43 ± 37%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
     46.67 ±118%     +18.8%      55.43 ± 91%     -19.8%      37.43 ± 89%  interrupts.CPU15.RES:Rescheduling_interrupts
     23.17 ± 25%      +1.7%      23.57 ± 14%      +2.4%      23.71 ± 23%  interrupts.CPU15.TLB:TLB_shootdowns
      1251 ±  4%      -2.0%       1226            +3.3%       1292 ±  6%  interrupts.CPU150.CAL:Function_call_interrupts
    601947            -1.3%     594119 ±  3%      -7.1%     559061 ± 18%  interrupts.CPU150.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU150.MCP:Machine_check_polls
    242.33 ± 31%      -4.8%     230.71 ± 36%      -6.3%     227.00 ± 33%  interrupts.CPU150.NMI:Non-maskable_interrupts
    242.33 ± 31%      -4.8%     230.71 ± 36%      -6.3%     227.00 ± 33%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
     13.33 ± 87%     -38.9%       8.14 ± 48%     +35.0%      18.00 ± 75%  interrupts.CPU150.RES:Rescheduling_interrupts
     12.33 ± 46%      -7.3%      11.43 ± 18%     +14.7%      14.14 ± 53%  interrupts.CPU150.TLB:TLB_shootdowns
      1213           +10.5%       1340 ± 12%      +5.0%       1274 ±  9%  interrupts.CPU151.CAL:Function_call_interrupts
    602060            -0.8%     597067 ±  2%      -7.1%     559160 ± 18%  interrupts.CPU151.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU151.MCP:Machine_check_polls
    277.33 ± 28%      -7.8%     255.57 ± 36%     -25.7%     206.14 ± 32%  interrupts.CPU151.NMI:Non-maskable_interrupts
    277.33 ± 28%      -7.8%     255.57 ± 36%     -25.7%     206.14 ± 32%  interrupts.CPU151.PMI:Performance_monitoring_interrupts
      7.00 ± 26%    +130.6%      16.14 ± 78%    +112.2%      14.86 ± 70%  interrupts.CPU151.RES:Rescheduling_interrupts
      8.17 ± 16%     +19.0%       9.71 ± 16%      +6.7%       8.71 ± 20%  interrupts.CPU151.TLB:TLB_shootdowns
      1263 ±  7%      -3.0%       1226            -2.9%       1227        interrupts.CPU152.CAL:Function_call_interrupts
    602267            -0.3%     600469            -7.2%     559109 ± 18%  interrupts.CPU152.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU152.MCP:Machine_check_polls
    230.00 ± 36%      -2.4%     224.57 ± 35%      -1.2%     227.29 ± 35%  interrupts.CPU152.NMI:Non-maskable_interrupts
    230.00 ± 36%      -2.4%     224.57 ± 35%      -1.2%     227.29 ± 35%  interrupts.CPU152.PMI:Performance_monitoring_interrupts
     13.00 ± 70%      -8.8%      11.86 ± 42%     -16.5%      10.86 ± 43%  interrupts.CPU152.RES:Rescheduling_interrupts
     10.00 ± 19%      +5.7%      10.57 ± 25%      +0.0%      10.00 ± 28%  interrupts.CPU152.TLB:TLB_shootdowns
      1222            +1.1%       1235            -0.1%       1220        interrupts.CPU153.CAL:Function_call_interrupts
    602137            -0.3%     600200            -7.1%     559469 ± 18%  interrupts.CPU153.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU153.MCP:Machine_check_polls
    257.83 ± 32%     -13.6%     222.86 ± 35%     -21.9%     201.43 ± 30%  interrupts.CPU153.NMI:Non-maskable_interrupts
    257.83 ± 32%     -13.6%     222.86 ± 35%     -21.9%     201.43 ± 30%  interrupts.CPU153.PMI:Performance_monitoring_interrupts
     10.33 ± 33%      -8.8%       9.43 ± 44%     -17.1%       8.57 ± 53%  interrupts.CPU153.RES:Rescheduling_interrupts
      9.50 ± 25%      -8.3%       8.71 ± 14%      -0.8%       9.43 ± 18%  interrupts.CPU153.TLB:TLB_shootdowns
      1223            +4.1%       1273 ±  8%      +4.6%       1280 ±  5%  interrupts.CPU154.CAL:Function_call_interrupts
    602185            -2.1%     589693 ±  5%      -7.2%     559125 ± 18%  interrupts.CPU154.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU154.MCP:Machine_check_polls
    248.50 ± 31%     +35.5%     336.71 ± 32%     +16.1%     288.43 ± 42%  interrupts.CPU154.NMI:Non-maskable_interrupts
    248.50 ± 31%     +35.5%     336.71 ± 32%     +16.1%     288.43 ± 42%  interrupts.CPU154.PMI:Performance_monitoring_interrupts
      7.00 ± 39%      +8.2%       7.57 ± 52%     +91.8%      13.43 ± 66%  interrupts.CPU154.RES:Rescheduling_interrupts
      9.17 ± 31%     +29.4%      11.86 ± 36%     +52.7%      14.00 ± 47%  interrupts.CPU154.TLB:TLB_shootdowns
      1210            +1.0%       1223            +4.9%       1270 ±  6%  interrupts.CPU155.CAL:Function_call_interrupts
    602074            -3.6%     580464 ±  9%      -7.1%     559184 ± 18%  interrupts.CPU155.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU155.MCP:Machine_check_polls
    276.17 ± 36%     -11.4%     244.71 ± 29%      -2.8%     268.57 ± 34%  interrupts.CPU155.NMI:Non-maskable_interrupts
    276.17 ± 36%     -11.4%     244.71 ± 29%      -2.8%     268.57 ± 34%  interrupts.CPU155.PMI:Performance_monitoring_interrupts
      7.50 ± 22%     +12.4%       8.43 ± 40%     +88.6%      14.14 ± 74%  interrupts.CPU155.RES:Rescheduling_interrupts
      8.33 ± 17%      +6.3%       8.86 ± 22%     +98.9%      16.57 ± 64%  interrupts.CPU155.TLB:TLB_shootdowns
      1237            +0.7%       1246 ±  2%      +1.4%       1255 ±  2%  interrupts.CPU156.CAL:Function_call_interrupts
    602205            -2.0%     590418 ±  4%      -7.2%     558992 ± 18%  interrupts.CPU156.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU156.MCP:Machine_check_polls
    252.50 ± 35%     +25.4%     316.57 ± 69%      -2.1%     247.29 ± 34%  interrupts.CPU156.NMI:Non-maskable_interrupts
    252.50 ± 35%     +25.4%     316.57 ± 69%      -2.1%     247.29 ± 34%  interrupts.CPU156.PMI:Performance_monitoring_interrupts
      9.83 ± 25%     -11.4%       8.71 ± 73%     +33.7%      13.14 ± 56%  interrupts.CPU156.RES:Rescheduling_interrupts
     11.50 ± 16%      -9.3%      10.43 ± 25%      +0.6%      11.57 ± 27%  interrupts.CPU156.TLB:TLB_shootdowns
      1218            +1.0%       1230            +3.3%       1258 ±  3%  interrupts.CPU157.CAL:Function_call_interrupts
    602232            -2.2%     588803 ±  5%      -7.2%     559061 ± 18%  interrupts.CPU157.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU157.MCP:Machine_check_polls
    246.50 ± 34%      +1.5%     250.14 ± 36%      +9.5%     269.86 ± 33%  interrupts.CPU157.NMI:Non-maskable_interrupts
    246.50 ± 34%      +1.5%     250.14 ± 36%      +9.5%     269.86 ± 33%  interrupts.CPU157.PMI:Performance_monitoring_interrupts
     11.83 ± 23%     +14.7%      13.57 ± 81%      -3.4%      11.43 ± 51%  interrupts.CPU157.RES:Rescheduling_interrupts
      9.33 ± 19%      +7.1%      10.00 ± 35%      +8.7%      10.14 ± 37%  interrupts.CPU157.TLB:TLB_shootdowns
      1301 ±  9%      -3.2%       1259 ±  6%      -5.8%       1225        interrupts.CPU158.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +2.9e+101%       0.29 ±244%  interrupts.CPU158.IWI:IRQ_work_interrupts
    602076            -2.4%     587834 ±  6%      -7.2%     558848 ± 18%  interrupts.CPU158.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU158.MCP:Machine_check_polls
    265.50 ± 33%    +110.5%     559.00 ±104%      +3.1%     273.71 ± 34%  interrupts.CPU158.NMI:Non-maskable_interrupts
    265.50 ± 33%    +110.5%     559.00 ±104%      +3.1%     273.71 ± 34%  interrupts.CPU158.PMI:Performance_monitoring_interrupts
     10.83 ± 52%     -24.8%       8.14 ± 47%     -22.2%       8.43 ± 58%  interrupts.CPU158.RES:Rescheduling_interrupts
     11.33 ± 41%      +5.9%      12.00 ± 66%     -15.5%       9.57 ± 27%  interrupts.CPU158.TLB:TLB_shootdowns
      1349 ± 13%      -8.2%       1238 ±  3%      -9.9%       1215        interrupts.CPU159.CAL:Function_call_interrupts
    602047            -2.6%     586265 ±  6%      -7.1%     559087 ± 18%  interrupts.CPU159.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU159.MCP:Machine_check_polls
    235.67 ± 31%     +34.1%     316.00 ± 42%      +4.2%     245.57 ± 41%  interrupts.CPU159.NMI:Non-maskable_interrupts
    235.67 ± 31%     +34.1%     316.00 ± 42%      +4.2%     245.57 ± 41%  interrupts.CPU159.PMI:Performance_monitoring_interrupts
     20.00 ± 99%     -53.6%       9.29 ± 61%     -61.4%       7.71 ± 35%  interrupts.CPU159.RES:Rescheduling_interrupts
     10.00 ± 19%      +0.0%      10.00 ± 31%     -12.9%       8.71 ± 27%  interrupts.CPU159.TLB:TLB_shootdowns
     40.67 ±  4%      -0.9%      40.29 ±  4%      -0.9%      40.29 ±  4%  interrupts.CPU16.4:IR-IO-APIC.4-edge.ttyS0
      1732 ± 27%      -6.4%       1621 ± 15%     -11.7%       1529 ± 12%  interrupts.CPU16.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +5.7e+101%       0.57 ±244%  interrupts.CPU16.IWI:IRQ_work_interrupts
    602232            -0.3%     600527            -7.2%     558992 ± 18%  interrupts.CPU16.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU16.MCP:Machine_check_polls
    198.50 ± 32%     +38.1%     274.14 ± 28%     +26.8%     251.71 ± 29%  interrupts.CPU16.NMI:Non-maskable_interrupts
    198.50 ± 32%     +38.1%     274.14 ± 28%     +26.8%     251.71 ± 29%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
     61.50 ± 83%      +5.7%      65.00 ± 26%     -24.7%      46.29 ± 59%  interrupts.CPU16.RES:Rescheduling_interrupts
     64.33 ± 18%      +3.0%      66.29 ± 11%      -3.0%      62.43 ± 80%  interrupts.CPU16.TLB:TLB_shootdowns
      1340 ± 14%      -8.0%       1232 ±  2%      -7.4%       1241        interrupts.CPU160.CAL:Function_call_interrupts
    602075            -5.1%     571577 ± 13%      -7.1%     559034 ± 18%  interrupts.CPU160.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU160.MCP:Machine_check_polls
    295.00 ± 34%     -23.0%     227.29 ± 32%     -23.4%     225.86 ± 29%  interrupts.CPU160.NMI:Non-maskable_interrupts
    295.00 ± 34%     -23.0%     227.29 ± 32%     -23.4%     225.86 ± 29%  interrupts.CPU160.PMI:Performance_monitoring_interrupts
     21.33 ± 94%     -56.5%       9.29 ± 69%     -50.4%      10.57 ± 30%  interrupts.CPU160.RES:Rescheduling_interrupts
     11.00 ± 22%     +29.9%      14.29 ± 58%      +6.5%      11.71 ± 23%  interrupts.CPU160.TLB:TLB_shootdowns
      1227            +1.9%       1250 ±  2%      +4.7%       1284 ± 12%  interrupts.CPU161.CAL:Function_call_interrupts
    601995            -4.0%     577993 ± 10%      -7.1%     559107 ± 18%  interrupts.CPU161.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU161.MCP:Machine_check_polls
    266.00 ± 35%      -3.3%     257.29 ± 35%      +7.6%     286.14 ± 32%  interrupts.CPU161.NMI:Non-maskable_interrupts
    266.00 ± 35%      -3.3%     257.29 ± 35%      +7.6%     286.14 ± 32%  interrupts.CPU161.PMI:Performance_monitoring_interrupts
      9.83 ± 18%      +6.1%      10.43 ± 36%     -18.6%       8.00 ± 38%  interrupts.CPU161.RES:Rescheduling_interrupts
      9.50 ± 19%     -11.3%       8.43 ± 15%      -6.8%       8.86 ± 14%  interrupts.CPU161.TLB:TLB_shootdowns
      1229            +2.1%       1254 ±  3%      -3.7%       1183 ± 14%  interrupts.CPU162.CAL:Function_call_interrupts
    602010            -3.2%     583001 ±  8%      -7.1%     559142 ± 18%  interrupts.CPU162.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU162.MCP:Machine_check_polls
    285.33 ± 45%     -11.3%     253.00 ± 37%     -10.4%     255.71 ± 34%  interrupts.CPU162.NMI:Non-maskable_interrupts
    285.33 ± 45%     -11.3%     253.00 ± 37%     -10.4%     255.71 ± 34%  interrupts.CPU162.PMI:Performance_monitoring_interrupts
     13.83 ± 45%      -6.0%      13.00 ± 65%     -10.2%      12.43 ± 43%  interrupts.CPU162.RES:Rescheduling_interrupts
     12.83 ± 34%      +3.5%      13.29 ± 37%      -2.0%      12.57 ± 30%  interrupts.CPU162.TLB:TLB_shootdowns
      1221            +0.9%       1232            -0.2%       1219        interrupts.CPU163.CAL:Function_call_interrupts
    601889            -2.0%     589986 ±  5%      -7.2%     558534 ± 18%  interrupts.CPU163.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU163.MCP:Machine_check_polls
    272.50 ± 32%      -5.7%     256.86 ± 33%     +11.2%     303.14 ± 40%  interrupts.CPU163.NMI:Non-maskable_interrupts
    272.50 ± 32%      -5.7%     256.86 ± 33%     +11.2%     303.14 ± 40%  interrupts.CPU163.PMI:Performance_monitoring_interrupts
      7.67 ± 41%     +23.0%       9.43 ± 43%      -6.8%       7.14 ± 37%  interrupts.CPU163.RES:Rescheduling_interrupts
     10.67 ± 56%      +1.8%      10.86 ± 15%      -3.6%      10.29 ± 10%  interrupts.CPU163.TLB:TLB_shootdowns
      1221            +1.1%       1235            +5.2%       1284 ±  7%  interrupts.CPU164.CAL:Function_call_interrupts
    602205            -3.9%     578574 ±  9%      -7.1%     559262 ± 18%  interrupts.CPU164.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU164.MCP:Machine_check_polls
    243.00 ± 30%      -0.4%     242.14 ± 33%     +12.7%     273.86 ± 34%  interrupts.CPU164.NMI:Non-maskable_interrupts
    243.00 ± 30%      -0.4%     242.14 ± 33%     +12.7%     273.86 ± 34%  interrupts.CPU164.PMI:Performance_monitoring_interrupts
      9.00 ± 39%      +7.9%       9.71 ± 36%     +47.6%      13.29 ± 68%  interrupts.CPU164.RES:Rescheduling_interrupts
     11.83 ± 26%      -2.2%      11.57 ± 23%     -15.5%      10.00 ± 29%  interrupts.CPU164.TLB:TLB_shootdowns
      1231 ±  2%      +1.6%       1251 ±  5%      +6.7%       1313 ± 14%  interrupts.CPU165.CAL:Function_call_interrupts
    602126            -2.4%     587780 ±  5%      -7.1%     559236 ± 18%  interrupts.CPU165.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU165.MCP:Machine_check_polls
    288.17 ± 35%      -5.2%     273.29 ± 35%      +1.3%     292.00 ± 40%  interrupts.CPU165.NMI:Non-maskable_interrupts
    288.17 ± 35%      -5.2%     273.29 ± 35%      +1.3%     292.00 ± 40%  interrupts.CPU165.PMI:Performance_monitoring_interrupts
      9.83 ± 48%     -27.4%       7.14 ± 43%     +77.2%      17.43 ±113%  interrupts.CPU165.RES:Rescheduling_interrupts
      9.33 ± 33%    +443.4%      50.71 ±205%      -8.2%       8.57 ± 22%  interrupts.CPU165.TLB:TLB_shootdowns
      1223            +1.9%       1247 ±  2%      +0.1%       1225 ±  2%  interrupts.CPU166.CAL:Function_call_interrupts
    602272            -3.7%     579980 ±  9%      -7.2%     558811 ± 18%  interrupts.CPU166.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU166.MCP:Machine_check_polls
    285.33 ± 41%      +3.2%     294.57 ± 35%     -13.9%     245.71 ± 31%  interrupts.CPU166.NMI:Non-maskable_interrupts
    285.33 ± 41%      +3.2%     294.57 ± 35%     -13.9%     245.71 ± 31%  interrupts.CPU166.PMI:Performance_monitoring_interrupts
      7.50 ± 29%      -1.0%       7.43 ± 50%     +21.9%       9.14 ± 52%  interrupts.CPU166.RES:Rescheduling_interrupts
     11.00 ± 46%      -9.1%      10.00 ± 32%      +3.9%      11.43 ± 18%  interrupts.CPU166.TLB:TLB_shootdowns
      1245 ±  5%      -1.2%       1230            -2.0%       1220        interrupts.CPU167.CAL:Function_call_interrupts
    602331            -2.4%     588151 ±  5%      -7.2%     558872 ± 18%  interrupts.CPU167.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU167.MCP:Machine_check_polls
    298.17 ± 42%      +1.1%     301.57 ± 34%      -7.0%     277.29 ± 34%  interrupts.CPU167.NMI:Non-maskable_interrupts
    298.17 ± 42%      +1.1%     301.57 ± 34%      -7.0%     277.29 ± 34%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
      9.33 ± 41%     +11.7%      10.43 ± 52%      -3.6%       9.00 ± 59%  interrupts.CPU167.RES:Rescheduling_interrupts
      7.83 ± 15%     +18.5%       9.29 ± 22%     +11.2%       8.71 ± 19%  interrupts.CPU167.TLB:TLB_shootdowns
      1214            +2.3%       1242            +2.0%       1239 ±  2%  interrupts.CPU168.CAL:Function_call_interrupts
    602126            -0.8%     597580            -7.2%     558957 ± 18%  interrupts.CPU168.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU168.MCP:Machine_check_polls
    256.17 ± 51%     -13.1%     222.57 ± 35%     -17.8%     210.57 ± 37%  interrupts.CPU168.NMI:Non-maskable_interrupts
    256.17 ± 51%     -13.1%     222.57 ± 35%     -17.8%     210.57 ± 37%  interrupts.CPU168.PMI:Performance_monitoring_interrupts
      7.67 ± 27%     +41.6%      10.86 ± 34%     +58.4%      12.14 ± 58%  interrupts.CPU168.RES:Rescheduling_interrupts
     11.50 ± 53%      -6.8%      10.71 ± 40%      -0.6%      11.43 ± 22%  interrupts.CPU168.TLB:TLB_shootdowns
      1231 ±  2%      +0.2%       1233 ±  3%      -0.8%       1220        interrupts.CPU169.CAL:Function_call_interrupts
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU169.IWI:IRQ_work_interrupts
    601947            -0.9%     596432 ±  2%      -7.1%     558940 ± 18%  interrupts.CPU169.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU169.MCP:Machine_check_polls
    214.17 ± 43%      -6.3%     200.71 ± 29%      +1.3%     217.00 ± 41%  interrupts.CPU169.NMI:Non-maskable_interrupts
    214.17 ± 43%      -6.3%     200.71 ± 29%      +1.3%     217.00 ± 41%  interrupts.CPU169.PMI:Performance_monitoring_interrupts
     11.50 ± 57%      +1.9%      11.71 ± 49%      +0.6%      11.57 ± 36%  interrupts.CPU169.RES:Rescheduling_interrupts
      8.17 ± 21%      +3.2%       8.43 ± 21%     +32.9%      10.86 ± 49%  interrupts.CPU169.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.37:IR-PCI-MSI.3145729-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.3:IR-IO-APIC.3-edge
      2.50 ± 44%      +2.9%       2.57 ± 40%     -31.4%       1.71 ± 86%  interrupts.CPU17.42:IR-PCI-MSI.512000-edge.ahci[0000:00:1f.2]
      1679 ± 20%     -11.9%       1479 ± 23%     -22.6%       1299 ±  6%  interrupts.CPU17.CAL:Function_call_interrupts
    602147            -1.6%     592747 ±  3%      -7.2%     558939 ± 18%  interrupts.CPU17.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU17.MCP:Machine_check_polls
    254.67 ± 34%     +18.4%     301.57 ± 22%      -9.0%     231.71 ± 44%  interrupts.CPU17.NMI:Non-maskable_interrupts
    254.67 ± 34%     +18.4%     301.57 ± 22%      -9.0%     231.71 ± 44%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
     54.67 ± 54%     -36.2%      34.86 ± 60%     -74.7%      13.86 ± 77%  interrupts.CPU17.RES:Rescheduling_interrupts
     29.17 ± 47%     -21.1%      23.00 ± 14%     -17.7%      24.00 ±105%  interrupts.CPU17.TLB:TLB_shootdowns
      1230          +119.7%       2704 ±129%      -0.0%       1230 ±  2%  interrupts.CPU170.CAL:Function_call_interrupts
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        interrupts.CPU170.IWI:IRQ_work_interrupts
    602073            -2.9%     584662 ±  7%      -7.1%     559321 ± 18%  interrupts.CPU170.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU170.MCP:Machine_check_polls
    350.17 ± 28%     -27.5%     253.71 ± 31%     -18.7%     284.71 ± 39%  interrupts.CPU170.NMI:Non-maskable_interrupts
    350.17 ± 28%     -27.5%     253.71 ± 31%     -18.7%     284.71 ± 39%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
     13.67 ± 31%     +34.8%      18.43 ±115%     -32.1%       9.29 ± 52%  interrupts.CPU170.RES:Rescheduling_interrupts
      9.50 ± 13%      +0.8%       9.57 ± 13%     +11.3%      10.57 ± 21%  interrupts.CPU170.TLB:TLB_shootdowns
      1221            +0.3%       1224            -0.7%       1212        interrupts.CPU171.CAL:Function_call_interrupts
    601980            -3.0%     584105 ±  7%      -7.2%     558797 ± 18%  interrupts.CPU171.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU171.MCP:Machine_check_polls
    288.67 ± 34%      +7.5%     310.43 ± 33%      +1.6%     293.43 ± 40%  interrupts.CPU171.NMI:Non-maskable_interrupts
    288.67 ± 34%      +7.5%     310.43 ± 33%      +1.6%     293.43 ± 40%  interrupts.CPU171.PMI:Performance_monitoring_interrupts
      8.33 ± 52%     +54.3%      12.86 ± 55%     -10.9%       7.43 ± 55%  interrupts.CPU171.RES:Rescheduling_interrupts
      9.50 ± 14%     -15.8%       8.00 ± 16%      -3.8%       9.14 ± 22%  interrupts.CPU171.TLB:TLB_shootdowns
      1216            +0.5%       1222            +6.4%       1294 ± 11%  interrupts.CPU172.CAL:Function_call_interrupts
    602073            -2.0%     590074 ±  4%      -7.1%     559101 ± 18%  interrupts.CPU172.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU172.MCP:Machine_check_polls
    263.00 ± 32%     +24.3%     327.00 ± 68%     -25.1%     197.00 ± 38%  interrupts.CPU172.NMI:Non-maskable_interrupts
    263.00 ± 32%     +24.3%     327.00 ± 68%     -25.1%     197.00 ± 38%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
      7.83 ± 37%      -8.8%       7.14 ± 39%    +200.9%      23.57 ±108%  interrupts.CPU172.RES:Rescheduling_interrupts
      9.17 ± 26%      +9.1%      10.00 ± 29%    +108.8%      19.14 ± 93%  interrupts.CPU172.TLB:TLB_shootdowns
      1211            +8.2%       1310 ± 17%      +8.0%       1308 ±  8%  interrupts.CPU173.CAL:Function_call_interrupts
    602024            -1.1%     595423 ±  2%      -7.1%     559040 ± 18%  interrupts.CPU173.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU173.MCP:Machine_check_polls
    238.83 ± 34%      -1.0%     236.43 ± 34%     -16.7%     199.00 ± 40%  interrupts.CPU173.NMI:Non-maskable_interrupts
    238.83 ± 34%      -1.0%     236.43 ± 34%     -16.7%     199.00 ± 40%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
      7.50 ± 39%     -23.8%       5.71 ± 76%    +221.9%      24.14 ± 64%  interrupts.CPU173.RES:Rescheduling_interrupts
      7.50 ± 12%    +119.0%      16.43 ±133%    +111.4%      15.86 ± 66%  interrupts.CPU173.TLB:TLB_shootdowns
      1227            -0.3%       1224            -0.3%       1223 ±  2%  interrupts.CPU174.CAL:Function_call_interrupts
      0.00       +4.3e+101%       0.43 ±244%    -100.0%       0.00        interrupts.CPU174.IWI:IRQ_work_interrupts
    602074            -4.4%     575496 ± 11%      -7.1%     559202 ± 18%  interrupts.CPU174.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU174.MCP:Machine_check_polls
    312.67 ± 36%      -5.8%     294.43 ± 47%     -10.0%     281.29 ± 40%  interrupts.CPU174.NMI:Non-maskable_interrupts
    312.67 ± 36%      -5.8%     294.43 ± 47%     -10.0%     281.29 ± 40%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
      9.33 ± 47%      -0.5%       9.29 ± 27%     -20.4%       7.43 ± 60%  interrupts.CPU174.RES:Rescheduling_interrupts
     59.50 ±184%     -86.3%       8.14 ± 22%     -82.0%      10.71 ± 17%  interrupts.CPU174.TLB:TLB_shootdowns
      1221            +0.2%       1223            +5.7%       1290 ±  8%  interrupts.CPU175.CAL:Function_call_interrupts
    602043            -3.3%     582196 ±  8%      -7.1%     559162 ± 18%  interrupts.CPU175.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU175.MCP:Machine_check_polls
    318.67 ± 35%      +6.7%     340.14 ± 49%      +8.8%     346.86 ± 31%  interrupts.CPU175.NMI:Non-maskable_interrupts
    318.67 ± 35%      +6.7%     340.14 ± 49%      +8.8%     346.86 ± 31%  interrupts.CPU175.PMI:Performance_monitoring_interrupts
     10.83 ± 44%      +9.5%      11.86 ± 41%     +30.5%      14.14 ± 72%  interrupts.CPU175.RES:Rescheduling_interrupts
     10.33 ± 45%    +573.3%      69.57 ±222%     +61.8%      16.71 ±103%  interrupts.CPU175.TLB:TLB_shootdowns
      1251 ±  4%      +1.5%       1270 ±  8%      -2.0%       1225        interrupts.CPU176.CAL:Function_call_interrupts
    602126            -4.0%     578282 ± 10%      -7.1%     559100 ± 18%  interrupts.CPU176.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU176.MCP:Machine_check_polls
    286.33 ± 31%      +5.0%     300.57 ± 36%      -9.0%     260.57 ± 41%  interrupts.CPU176.NMI:Non-maskable_interrupts
    286.33 ± 31%      +5.0%     300.57 ± 36%      -9.0%     260.57 ± 41%  interrupts.CPU176.PMI:Performance_monitoring_interrupts
     10.83 ± 46%      +4.2%      11.29 ± 62%      -9.0%       9.86 ± 25%  interrupts.CPU176.RES:Rescheduling_interrupts
     12.67 ± 50%     -30.1%       8.86 ± 29%     -12.0%      11.14 ± 13%  interrupts.CPU176.TLB:TLB_shootdowns
      1226            +1.0%       1238 ±  2%      -1.1%       1213        interrupts.CPU177.CAL:Function_call_interrupts
    602013            -3.4%     581480 ±  8%      -7.1%     559051 ± 18%  interrupts.CPU177.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU177.MCP:Machine_check_polls
    272.17 ± 33%     +19.6%     325.57 ± 33%      -7.5%     251.71 ± 41%  interrupts.CPU177.NMI:Non-maskable_interrupts
    272.17 ± 33%     +19.6%     325.57 ± 33%      -7.5%     251.71 ± 41%  interrupts.CPU177.PMI:Performance_monitoring_interrupts
      9.83 ± 30%     -27.4%       7.14 ± 38%     -17.2%       8.14 ± 21%  interrupts.CPU177.RES:Rescheduling_interrupts
      8.50 ± 11%      +7.6%       9.14 ± 20%      -0.8%       8.43 ± 21%  interrupts.CPU177.TLB:TLB_shootdowns
      1225 ±  2%      +1.7%       1245 ±  2%      +2.5%       1255 ±  3%  interrupts.CPU178.CAL:Function_call_interrupts
    602102            -3.9%     578663 ±  9%      -7.1%     559110 ± 18%  interrupts.CPU178.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU178.MCP:Machine_check_polls
    285.50 ± 38%     -17.3%     236.14 ± 31%     -10.6%     255.14 ± 42%  interrupts.CPU178.NMI:Non-maskable_interrupts
    285.50 ± 38%     -17.3%     236.14 ± 31%     -10.6%     255.14 ± 42%  interrupts.CPU178.PMI:Performance_monitoring_interrupts
     10.67 ± 46%      -6.2%      10.00 ± 72%     -18.3%       8.71 ± 46%  interrupts.CPU178.RES:Rescheduling_interrupts
     12.83 ± 49%      +5.8%      13.57 ± 47%     -19.9%      10.29 ± 21%  interrupts.CPU178.TLB:TLB_shootdowns
      1235            +2.2%       1263 ±  7%      -0.3%       1231 ±  2%  interrupts.CPU179.CAL:Function_call_interrupts
    602028            -3.7%     579781 ±  9%      -7.1%     559026 ± 18%  interrupts.CPU179.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU179.MCP:Machine_check_polls
    282.67 ± 32%     -16.7%     235.43 ± 32%     -10.8%     252.14 ± 41%  interrupts.CPU179.NMI:Non-maskable_interrupts
    282.67 ± 32%     -16.7%     235.43 ± 32%     -10.8%     252.14 ± 41%  interrupts.CPU179.PMI:Performance_monitoring_interrupts
      7.17 ±104%    +121.3%      15.86 ±102%      -0.3%       7.14 ± 55%  interrupts.CPU179.RES:Rescheduling_interrupts
      8.50 ± 21%     +16.0%       9.86 ± 34%      +0.8%       8.57 ± 13%  interrupts.CPU179.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU18.38:IR-PCI-MSI.3145730-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU18.3:IR-IO-APIC.3-edge
      0.50 ±223%     -14.3%       0.43 ±244%    +157.1%       1.29 ±115%  interrupts.CPU18.42:IR-PCI-MSI.512000-edge.ahci[0000:00:1f.2]
      1741 ± 19%      -6.6%       1626 ± 26%      -8.8%       1588 ± 21%  interrupts.CPU18.CAL:Function_call_interrupts
    602321            -0.3%     600466            -7.2%     559096 ± 18%  interrupts.CPU18.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU18.MCP:Machine_check_polls
    309.00 ± 31%     -24.5%     233.43 ± 30%     -16.6%     257.71 ± 41%  interrupts.CPU18.NMI:Non-maskable_interrupts
    309.00 ± 31%     -24.5%     233.43 ± 30%     -16.6%     257.71 ± 41%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
     79.17 ± 55%     -15.7%      66.71 ±101%     -21.5%      62.14 ± 67%  interrupts.CPU18.RES:Rescheduling_interrupts
     71.00 ± 27%     -24.5%      53.57 ± 46%     -29.8%      49.86 ± 44%  interrupts.CPU18.TLB:TLB_shootdowns
      1246 ±  2%      -1.3%       1230 ±  3%      +1.9%       1270 ±  8%  interrupts.CPU180.CAL:Function_call_interrupts
    602092            -2.9%     584907 ±  7%      -7.1%     559072 ± 18%  interrupts.CPU180.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU180.MCP:Machine_check_polls
    284.50 ± 34%     -12.3%     249.57 ± 29%     +14.8%     326.57 ± 37%  interrupts.CPU180.NMI:Non-maskable_interrupts
    284.50 ± 34%     -12.3%     249.57 ± 29%     +14.8%     326.57 ± 37%  interrupts.CPU180.PMI:Performance_monitoring_interrupts
      9.00 ± 47%      +1.6%       9.14 ± 79%     +14.3%      10.29 ± 90%  interrupts.CPU180.RES:Rescheduling_interrupts
     12.50 ± 31%     -20.0%      10.00 ± 25%      -5.1%      11.86 ± 23%  interrupts.CPU180.TLB:TLB_shootdowns
      1219            +0.1%       1220            +0.2%       1221        interrupts.CPU181.CAL:Function_call_interrupts
      0.00       +2.9e+101%       0.29 ±244%    -100.0%       0.00        interrupts.CPU181.IWI:IRQ_work_interrupts
    602091            -2.9%     584699 ±  7%      -7.2%     559015 ± 18%  interrupts.CPU181.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU181.MCP:Machine_check_polls
    494.00 ± 93%     +96.5%     970.71 ±165%     -34.5%     323.43 ± 38%  interrupts.CPU181.NMI:Non-maskable_interrupts
    494.00 ± 93%     +96.5%     970.71 ±165%     -34.5%     323.43 ± 38%  interrupts.CPU181.PMI:Performance_monitoring_interrupts
      7.50 ± 41%      -6.7%       7.00 ± 53%     -23.8%       5.71 ± 45%  interrupts.CPU181.RES:Rescheduling_interrupts
      9.50 ± 36%     -15.8%       8.00 ± 11%      -6.8%       8.86 ± 20%  interrupts.CPU181.TLB:TLB_shootdowns
      1243 ±  3%      -1.7%       1222            -2.0%       1218        interrupts.CPU182.CAL:Function_call_interrupts
    602102            -2.9%     584748 ±  7%      -7.1%     559104 ± 18%  interrupts.CPU182.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU182.MCP:Machine_check_polls
    256.33 ± 35%     +32.0%     338.29 ± 30%     +21.3%     310.86 ± 40%  interrupts.CPU182.NMI:Non-maskable_interrupts
    256.33 ± 35%     +32.0%     338.29 ± 30%     +21.3%     310.86 ± 40%  interrupts.CPU182.PMI:Performance_monitoring_interrupts
     11.00 ± 54%     -36.4%       7.00 ± 27%     -36.4%       7.00 ± 30%  interrupts.CPU182.RES:Rescheduling_interrupts
     12.00 ± 30%      +1.2%      12.14 ± 51%     -21.4%       9.43 ± 27%  interrupts.CPU182.TLB:TLB_shootdowns
      1233            -1.5%       1215            +7.6%       1327 ± 21%  interrupts.CPU183.CAL:Function_call_interrupts
    602080            -2.9%     584612 ±  7%      -7.1%     559189 ± 18%  interrupts.CPU183.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU183.MCP:Machine_check_polls
    246.50 ± 31%     +23.2%     303.71 ± 36%      +9.0%     268.71 ± 38%  interrupts.CPU183.NMI:Non-maskable_interrupts
    246.50 ± 31%     +23.2%     303.71 ± 36%      +9.0%     268.71 ± 38%  interrupts.CPU183.PMI:Performance_monitoring_interrupts
     11.50 ± 39%     -35.4%       7.43 ± 79%     -35.4%       7.43 ± 15%  interrupts.CPU183.RES:Rescheduling_interrupts
      8.00 ± 22%      +7.1%       8.57 ± 27%      +7.1%       8.57 ± 25%  interrupts.CPU183.TLB:TLB_shootdowns
      1231            +0.3%       1235           +25.0%       1539 ± 41%  interrupts.CPU184.CAL:Function_call_interrupts
    601990            -3.7%     579975 ±  9%      -7.1%     559155 ± 18%  interrupts.CPU184.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU184.MCP:Machine_check_polls
    326.00 ± 31%     -18.8%     264.71 ± 34%     -40.2%     194.86 ± 15%  interrupts.CPU184.NMI:Non-maskable_interrupts
    326.00 ± 31%     -18.8%     264.71 ± 34%     -40.2%     194.86 ± 15%  interrupts.CPU184.PMI:Performance_monitoring_interrupts
      7.33 ± 44%     +32.5%       9.71 ± 50%     +83.1%      13.43 ± 58%  interrupts.CPU184.RES:Rescheduling_interrupts
      9.17 ± 23%     +15.3%      10.57 ± 20%     +48.1%      13.57 ± 46%  interrupts.CPU184.TLB:TLB_shootdowns
      1247 ±  5%      -1.4%       1230 ±  2%     +16.9%       1458 ± 27%  interrupts.CPU185.CAL:Function_call_interrupts
    602165            -3.7%     579615 ±  9%      -7.2%     559033 ± 18%  interrupts.CPU185.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU185.MCP:Machine_check_polls
    270.00 ± 35%      -2.8%     262.57 ± 34%      -5.7%     254.71 ± 42%  interrupts.CPU185.NMI:Non-maskable_interrupts
    270.00 ± 35%      -2.8%     262.57 ± 34%      -5.7%     254.71 ± 42%  interrupts.CPU185.PMI:Performance_monitoring_interrupts
      6.50 ± 42%     +38.5%       9.00 ± 40%     +71.4%      11.14 ±111%  interrupts.CPU185.RES:Rescheduling_interrupts
      7.67 ± 12%     +21.1%       9.29 ± 19%     +36.0%      10.43 ± 38%  interrupts.CPU185.TLB:TLB_shootdowns
      1237 ±  2%      +0.3%       1241            +1.9%       1260 ±  5%  interrupts.CPU186.CAL:Function_call_interrupts
    602047            -4.2%     576496 ± 10%      -7.1%     559373 ± 18%  interrupts.CPU186.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU186.MCP:Machine_check_polls
    279.50 ± 35%     +15.8%     323.57 ± 30%     -18.4%     228.14 ± 37%  interrupts.CPU186.NMI:Non-maskable_interrupts
    279.50 ± 35%     +15.8%     323.57 ± 30%     -18.4%     228.14 ± 37%  interrupts.CPU186.PMI:Performance_monitoring_interrupts
      9.67 ± 40%      -8.4%       8.86 ± 30%     +34.5%      13.00 ± 94%  interrupts.CPU186.RES:Rescheduling_interrupts
     10.17 ± 20%     +16.6%      11.86 ± 17%     +12.4%      11.43 ± 27%  interrupts.CPU186.TLB:TLB_shootdowns
      1225            -0.9%       1213            -0.2%       1223        interrupts.CPU187.CAL:Function_call_interrupts
    602052            -3.5%     580771 ±  9%      -7.1%     559072 ± 18%  interrupts.CPU187.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU187.MCP:Machine_check_polls
    273.00 ± 33%     +28.5%     350.86 ± 25%      +4.2%     284.57 ± 41%  interrupts.CPU187.NMI:Non-maskable_interrupts
    273.00 ± 33%     +28.5%     350.86 ± 25%      +4.2%     284.57 ± 41%  interrupts.CPU187.PMI:Performance_monitoring_interrupts
     11.83 ± 48%     -21.5%       9.29 ± 31%     -22.7%       9.14 ± 68%  interrupts.CPU187.RES:Rescheduling_interrupts
      8.33 ± 11%     +14.9%       9.57 ± 18%     +11.4%       9.29 ± 15%  interrupts.CPU187.TLB:TLB_shootdowns
      1232            +1.6%       1251 ±  2%      -1.8%       1209        interrupts.CPU188.CAL:Function_call_interrupts
    602285            -2.5%     586935 ±  6%      -7.2%     558626 ± 18%  interrupts.CPU188.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU188.MCP:Machine_check_polls
    315.17 ± 35%      -3.7%     303.57 ± 35%      -7.4%     292.00 ± 41%  interrupts.CPU188.NMI:Non-maskable_interrupts
    315.17 ± 35%      -3.7%     303.57 ± 35%      -7.4%     292.00 ± 41%  interrupts.CPU188.PMI:Performance_monitoring_interrupts
      9.50 ± 58%     +14.3%      10.86 ± 44%      -2.3%       9.29 ± 28%  interrupts.CPU188.RES:Rescheduling_interrupts
     11.00 ± 30%     +26.0%      13.86 ± 34%      -5.2%      10.43 ± 33%  interrupts.CPU188.TLB:TLB_shootdowns
      1224            +3.4%       1266 ±  7%      -0.4%       1220        interrupts.CPU189.CAL:Function_call_interrupts
    602219            -2.7%     586247 ±  6%      -7.2%     558972 ± 18%  interrupts.CPU189.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU189.MCP:Machine_check_polls
    306.83 ± 33%     -21.6%     240.43 ± 32%     -35.9%     196.57 ± 17%  interrupts.CPU189.NMI:Non-maskable_interrupts
    306.83 ± 33%     -21.6%     240.43 ± 32%     -35.9%     196.57 ± 17%  interrupts.CPU189.PMI:Performance_monitoring_interrupts
      7.00 ± 31%    +120.4%      15.43 ± 86%     -14.3%       6.00 ± 50%  interrupts.CPU189.RES:Rescheduling_interrupts
      7.67 ± 20%     +32.3%      10.14 ± 24%     +15.5%       8.86 ± 22%  interrupts.CPU189.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.39:IR-PCI-MSI.3145731-edge
      1380 ±  8%      +6.3%       1467 ± 10%      +0.9%       1393 ±  9%  interrupts.CPU19.CAL:Function_call_interrupts
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        interrupts.CPU19.IWI:IRQ_work_interrupts
    602197            -0.6%     598826            -7.1%     559255 ± 18%  interrupts.CPU19.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU19.MCP:Machine_check_polls
    242.33 ± 32%     +28.4%     311.14 ± 63%     +47.0%     356.14 ± 46%  interrupts.CPU19.NMI:Non-maskable_interrupts
    242.33 ± 32%     +28.4%     311.14 ± 63%     +47.0%     356.14 ± 46%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
     19.83 ± 43%     +96.6%      39.00 ± 52%     +19.6%      23.71 ± 17%  interrupts.CPU19.RES:Rescheduling_interrupts
     21.17 ± 43%     -22.4%      16.43 ± 42%      +1.9%      21.57 ± 30%  interrupts.CPU19.TLB:TLB_shootdowns
      1235            +4.7%       1292 ±  2%      +4.2%       1286 ±  8%  interrupts.CPU190.CAL:Function_call_interrupts
    602238            -3.1%     583752 ±  7%      -7.2%     558911 ± 18%  interrupts.CPU190.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU190.MCP:Machine_check_polls
    327.67 ± 33%      -7.6%     302.86 ± 33%     -18.1%     268.43 ± 41%  interrupts.CPU190.NMI:Non-maskable_interrupts
    327.67 ± 33%      -7.6%     302.86 ± 33%     -18.1%     268.43 ± 41%  interrupts.CPU190.PMI:Performance_monitoring_interrupts
      6.50 ± 49%    +113.2%      13.86 ± 30%    +126.4%      14.71 ± 99%  interrupts.CPU190.RES:Rescheduling_interrupts
     11.67 ± 26%      +6.5%      12.43 ± 21%      -6.9%      10.86 ± 35%  interrupts.CPU190.TLB:TLB_shootdowns
      1238 ±  3%      -0.2%       1235 ±  2%      +0.4%       1243 ±  2%  interrupts.CPU191.CAL:Function_call_interrupts
    602265            -3.2%     583183 ±  7%      -7.2%     558868 ± 18%  interrupts.CPU191.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU191.MCP:Machine_check_polls
    450.67 ± 95%     -33.4%     300.14 ± 29%     -17.6%     371.14 ± 48%  interrupts.CPU191.NMI:Non-maskable_interrupts
    450.67 ± 95%     -33.4%     300.14 ± 29%     -17.6%     371.14 ± 48%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
     10.67 ± 52%      +0.4%      10.71 ± 43%     -30.4%       7.43 ± 53%  interrupts.CPU191.RES:Rescheduling_interrupts
     20.67 ±122%     -55.8%       9.14 ± 10%      -3.9%      19.86 ±121%  interrupts.CPU191.TLB:TLB_shootdowns
      1272 ± 10%      -4.4%       1217            -4.8%       1212        interrupts.CPU192.CAL:Function_call_interrupts
    602071            -2.3%     588372 ±  5%      -7.2%     558844 ± 18%  interrupts.CPU192.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU192.MCP:Machine_check_polls
    244.33 ± 28%     +18.5%     289.43 ± 35%      -9.6%     220.86 ± 36%  interrupts.CPU192.NMI:Non-maskable_interrupts
    244.33 ± 28%     +18.5%     289.43 ± 35%      -9.6%     220.86 ± 36%  interrupts.CPU192.PMI:Performance_monitoring_interrupts
     14.17 ± 95%     -42.5%       8.14 ± 46%     -50.6%       7.00 ± 27%  interrupts.CPU192.RES:Rescheduling_interrupts
      6.83 ±  5%      +2.4%       7.00            +6.6%       7.29 ±  9%  interrupts.CPU192.TLB:TLB_shootdowns
      1211            +0.4%       1216            +0.1%       1213        interrupts.CPU193.CAL:Function_call_interrupts
    601474            -2.6%     585628 ±  6%      -7.1%     558941 ± 18%  interrupts.CPU193.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU193.MCP:Machine_check_polls
    341.00 ± 40%     -13.2%     295.86 ± 32%     -40.7%     202.29 ± 16%  interrupts.CPU193.NMI:Non-maskable_interrupts
    341.00 ± 40%     -13.2%     295.86 ± 32%     -40.7%     202.29 ± 16%  interrupts.CPU193.PMI:Performance_monitoring_interrupts
      5.83 ± 26%     +95.9%      11.43 ± 31%     +39.6%       8.14 ± 59%  interrupts.CPU193.RES:Rescheduling_interrupts
      7.33 ± 35%      +5.2%       7.71 ± 13%     +11.0%       8.14 ± 21%  interrupts.CPU193.TLB:TLB_shootdowns
      1215            +1.6%       1235            +2.8%       1249 ±  6%  interrupts.CPU194.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +5.7e+101%       0.57 ±244%  interrupts.CPU194.IWI:IRQ_work_interrupts
    601981            -0.3%     600360            -7.1%     558992 ± 18%  interrupts.CPU194.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU194.MCP:Machine_check_polls
    223.50 ± 37%     +19.8%     267.71 ± 31%    +119.4%     490.29 ±152%  interrupts.CPU194.NMI:Non-maskable_interrupts
    223.50 ± 37%     +19.8%     267.71 ± 31%    +119.4%     490.29 ±152%  interrupts.CPU194.PMI:Performance_monitoring_interrupts
      7.00 ± 56%     +14.3%       8.00 ± 54%     +46.9%      10.29 ±117%  interrupts.CPU194.RES:Rescheduling_interrupts
     10.33 ± 33%      -1.8%      10.14 ± 32%     +23.0%      12.71 ± 45%  interrupts.CPU194.TLB:TLB_shootdowns
      1238 ±  2%      -0.7%       1229            -0.8%       1228        interrupts.CPU195.CAL:Function_call_interrupts
    602105            -0.3%     600431            -7.1%     559190 ± 18%  interrupts.CPU195.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU195.MCP:Machine_check_polls
    267.67 ± 33%      -5.4%     253.29 ± 33%     -18.2%     219.00 ± 39%  interrupts.CPU195.NMI:Non-maskable_interrupts
    267.67 ± 33%      -5.4%     253.29 ± 33%     -18.2%     219.00 ± 39%  interrupts.CPU195.PMI:Performance_monitoring_interrupts
     20.83 ± 34%     -56.1%       9.14 ± 41%     -38.3%      12.86 ± 26%  interrupts.CPU195.RES:Rescheduling_interrupts
      8.17 ± 16%      +8.5%       8.86 ± 23%      +8.5%       8.86 ± 26%  interrupts.CPU195.TLB:TLB_shootdowns
      1221            +0.3%       1224            +1.3%       1236 ±  2%  interrupts.CPU196.CAL:Function_call_interrupts
    601792            -2.6%     586432 ±  6%      -7.1%     559009 ± 18%  interrupts.CPU196.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU196.MCP:Machine_check_polls
    303.00 ± 33%      -6.4%     283.71 ± 31%     -18.8%     246.14 ± 42%  interrupts.CPU196.NMI:Non-maskable_interrupts
    303.00 ± 33%      -6.4%     283.71 ± 31%     -18.8%     246.14 ± 42%  interrupts.CPU196.PMI:Performance_monitoring_interrupts
      9.83 ± 36%     +39.5%      13.71 ± 73%     +39.5%      13.71 ±102%  interrupts.CPU196.RES:Rescheduling_interrupts
     16.33 ±114%     -28.3%      11.71 ± 27%     -24.8%      12.29 ± 67%  interrupts.CPU196.TLB:TLB_shootdowns
      1268 ±  8%      -2.6%       1236            -2.1%       1241 ±  2%  interrupts.CPU197.CAL:Function_call_interrupts
    601986            -2.8%     585012 ±  7%      -7.1%     558976 ± 18%  interrupts.CPU197.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU197.MCP:Machine_check_polls
    250.50 ± 29%     +21.5%     304.29 ± 31%      -4.4%     239.57 ± 37%  interrupts.CPU197.NMI:Non-maskable_interrupts
    250.50 ± 29%     +21.5%     304.29 ± 31%      -4.4%     239.57 ± 37%  interrupts.CPU197.PMI:Performance_monitoring_interrupts
     21.00 ± 80%     -18.4%      17.14 ± 27%     -15.0%      17.86 ± 36%  interrupts.CPU197.RES:Rescheduling_interrupts
      6.83 ± 15%     +61.0%      11.00 ± 60%     +84.0%      12.57 ± 37%  interrupts.CPU197.TLB:TLB_shootdowns
      1240 ±  2%      -1.7%       1219            -1.3%       1224        interrupts.CPU198.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +4.3e+101%       0.43 ±244%  interrupts.CPU198.IWI:IRQ_work_interrupts
    602072            -1.8%     591072 ±  4%      -7.2%     558912 ± 18%  interrupts.CPU198.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU198.MCP:Machine_check_polls
    292.33 ± 33%     +12.0%     327.29 ± 26%    +253.5%       1033 ±194%  interrupts.CPU198.NMI:Non-maskable_interrupts
    292.33 ± 33%     +12.0%     327.29 ± 26%    +253.5%       1033 ±194%  interrupts.CPU198.PMI:Performance_monitoring_interrupts
      9.00 ± 36%     -19.0%       7.29 ± 96%     -11.1%       8.00 ± 34%  interrupts.CPU198.RES:Rescheduling_interrupts
     11.00 ± 21%     -13.0%       9.57 ± 15%     -19.5%       8.86 ± 16%  interrupts.CPU198.TLB:TLB_shootdowns
      1226            +8.5%       1330 ± 11%      +4.1%       1275 ±  9%  interrupts.CPU199.CAL:Function_call_interrupts
    602135            -2.7%     585741 ±  6%      -7.1%     559176 ± 18%  interrupts.CPU199.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU199.MCP:Machine_check_polls
    316.67 ± 35%     -25.0%     237.43 ± 34%     -37.1%     199.14 ± 15%  interrupts.CPU199.NMI:Non-maskable_interrupts
    316.67 ± 35%     -25.0%     237.43 ± 34%     -37.1%     199.14 ± 15%  interrupts.CPU199.PMI:Performance_monitoring_interrupts
     14.00 ± 20%     +74.5%      24.43 ± 81%     +40.8%      19.71 ± 60%  interrupts.CPU199.RES:Rescheduling_interrupts
      9.17 ± 31%    +250.6%      32.14 ± 95%     +94.8%      17.86 ±147%  interrupts.CPU199.TLB:TLB_shootdowns
      1765 ±  6%      +6.7%       1884 ± 11%      +1.1%       1785 ± 21%  interrupts.CPU2.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +2.9e+101%       0.29 ±244%  interrupts.CPU2.IWI:IRQ_work_interrupts
    602297            -0.1%     601535            -7.1%     559336 ± 18%  interrupts.CPU2.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU2.MCP:Machine_check_polls
    160.00 ±  4%     +45.2%     232.29 ± 33%     +69.4%     271.00 ± 47%  interrupts.CPU2.NMI:Non-maskable_interrupts
    160.00 ±  4%     +45.2%     232.29 ± 33%     +69.4%     271.00 ± 47%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
     48.17 ± 19%     +38.2%      66.57 ± 51%     +49.5%      72.00 ± 65%  interrupts.CPU2.RES:Rescheduling_interrupts
     72.83 ± 16%     -22.7%      56.29 ± 36%     -28.6%      52.00 ± 40%  interrupts.CPU2.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.40:IR-PCI-MSI.3145732-edge
      1700 ± 13%      +6.4%       1809 ± 47%      -9.2%       1544 ±  9%  interrupts.CPU20.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +2.9e+101%       0.29 ±244%  interrupts.CPU20.IWI:IRQ_work_interrupts
    601458            -0.6%     597589            -7.1%     559037 ± 18%  interrupts.CPU20.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU20.MCP:Machine_check_polls
    258.83 ± 34%     -13.8%     223.00 ± 34%     -18.5%     211.00 ± 37%  interrupts.CPU20.NMI:Non-maskable_interrupts
    258.83 ± 34%     -13.8%     223.00 ± 34%     -18.5%     211.00 ± 37%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
     50.50 ± 23%     +84.2%      93.00 ± 97%      +1.8%      51.43 ± 42%  interrupts.CPU20.RES:Rescheduling_interrupts
     67.50 ± 13%     -14.5%      57.71 ± 25%      -9.2%      61.29 ± 42%  interrupts.CPU20.TLB:TLB_shootdowns
      1230 ±  2%      +2.1%       1256 ±  2%      -0.1%       1229        interrupts.CPU200.CAL:Function_call_interrupts
    602215            -2.7%     585910 ±  6%      -7.2%     558976 ± 18%  interrupts.CPU200.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU200.MCP:Machine_check_polls
    308.33 ± 34%     -22.9%     237.86 ± 32%     +43.8%     443.43 ±102%  interrupts.CPU200.NMI:Non-maskable_interrupts
    308.33 ± 34%     -22.9%     237.86 ± 32%     +43.8%     443.43 ±102%  interrupts.CPU200.PMI:Performance_monitoring_interrupts
      9.67 ± 70%     +27.1%      12.29 ± 36%     -12.8%       8.43 ± 59%  interrupts.CPU200.RES:Rescheduling_interrupts
      8.67 ± 23%      +7.1%       9.29 ± 14%      +7.1%       9.29 ± 17%  interrupts.CPU200.TLB:TLB_shootdowns
      1225           +10.5%       1353 ± 14%      +3.5%       1267 ±  8%  interrupts.CPU201.CAL:Function_call_interrupts
    601974            -3.1%     583370 ±  7%      -7.2%     558692 ± 18%  interrupts.CPU201.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU201.MCP:Machine_check_polls
    247.33 ± 32%     +32.5%     327.71 ± 29%      -5.0%     235.00 ± 35%  interrupts.CPU201.NMI:Non-maskable_interrupts
    247.33 ± 32%     +32.5%     327.71 ± 29%      -5.0%     235.00 ± 35%  interrupts.CPU201.PMI:Performance_monitoring_interrupts
     20.17 ± 27%     +57.3%      31.71 ± 60%      +1.3%      20.43 ± 73%  interrupts.CPU201.RES:Rescheduling_interrupts
      7.33 ± 15%    +124.0%      16.43 ± 75%    +120.1%      16.14 ±111%  interrupts.CPU201.TLB:TLB_shootdowns
      1229           +11.2%       1367 ± 16%      +1.6%       1248 ±  5%  interrupts.CPU202.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +4.3e+101%       0.43 ±244%  interrupts.CPU202.IWI:IRQ_work_interrupts
    602116            -2.3%     588136 ±  5%      -7.1%     559078 ± 18%  interrupts.CPU202.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU202.MCP:Machine_check_polls
    237.67 ± 32%     +17.8%     279.86 ± 32%     +17.5%     279.29 ± 36%  interrupts.CPU202.NMI:Non-maskable_interrupts
    237.67 ± 32%     +17.8%     279.86 ± 32%     +17.5%     279.29 ± 36%  interrupts.CPU202.PMI:Performance_monitoring_interrupts
      7.17 ± 28%     +97.3%      14.14 ± 75%     +41.5%      10.14 ±124%  interrupts.CPU202.RES:Rescheduling_interrupts
      9.17 ± 31%      -8.1%       8.43 ± 12%     +83.9%      16.86 ±131%  interrupts.CPU202.TLB:TLB_shootdowns
      1227            -0.3%       1224            +1.2%       1241 ±  2%  interrupts.CPU203.CAL:Function_call_interrupts
      0.00       +4.3e+101%       0.43 ±244% +1.4e+101%       0.14 ±244%  interrupts.CPU203.IWI:IRQ_work_interrupts
    602210            -2.7%     586215 ±  6%      -7.2%     559099 ± 18%  interrupts.CPU203.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU203.MCP:Machine_check_polls
    246.67 ± 30%     +34.8%     332.43 ± 28%     +22.4%     301.86 ± 74%  interrupts.CPU203.NMI:Non-maskable_interrupts
    246.67 ± 30%     +34.8%     332.43 ± 28%     +22.4%     301.86 ± 74%  interrupts.CPU203.PMI:Performance_monitoring_interrupts
     17.17 ± 24%     -38.4%      10.57 ± 23%      -2.6%      16.71 ± 54%  interrupts.CPU203.RES:Rescheduling_interrupts
      7.00 ±  8%     +10.2%       7.71 ± 29%     +32.7%       9.29 ± 43%  interrupts.CPU203.TLB:TLB_shootdowns
      1218            +1.0%       1230            +0.1%       1219        interrupts.CPU204.CAL:Function_call_interrupts
    602131            -5.2%     570579 ± 13%      -7.2%     559058 ± 18%  interrupts.CPU204.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU204.MCP:Machine_check_polls
    271.00 ± 36%      -4.6%     258.43 ± 35%     -28.9%     192.57 ± 19%  interrupts.CPU204.NMI:Non-maskable_interrupts
    271.00 ± 36%      -4.6%     258.43 ± 35%     -28.9%     192.57 ± 19%  interrupts.CPU204.PMI:Performance_monitoring_interrupts
      7.67 ± 28%     +15.5%       8.86 ± 58%     -16.1%       6.43 ± 56%  interrupts.CPU204.RES:Rescheduling_interrupts
     28.00 ±152%     -63.8%      10.14 ± 14%     -61.7%      10.71 ± 14%  interrupts.CPU204.TLB:TLB_shootdowns
      1213            +0.6%       1221            +3.1%       1250 ±  3%  interrupts.CPU205.CAL:Function_call_interrupts
    601996            -5.4%     569223 ± 14%      -7.1%     559136 ± 18%  interrupts.CPU205.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU205.MCP:Machine_check_polls
    279.83 ± 36%      -7.9%     257.71 ± 28%      +0.2%     280.43 ± 40%  interrupts.CPU205.NMI:Non-maskable_interrupts
    279.83 ± 36%      -7.9%     257.71 ± 28%      +0.2%     280.43 ± 40%  interrupts.CPU205.PMI:Performance_monitoring_interrupts
     17.00 ± 32%     -21.8%      13.29 ± 25%     +12.6%      19.14 ± 47%  interrupts.CPU205.RES:Rescheduling_interrupts
      8.67 ± 30%      -2.7%       8.43 ± 39%     +76.4%      15.29 ± 60%  interrupts.CPU205.TLB:TLB_shootdowns
      1216            +6.6%       1297 ± 11%      +0.5%       1222        interrupts.CPU206.CAL:Function_call_interrupts
    602130            -3.1%     583599 ±  7%      -7.2%     559076 ± 18%  interrupts.CPU206.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU206.MCP:Machine_check_polls
    308.00 ± 33%      +3.1%     317.57 ± 29%     -27.7%     222.57 ± 39%  interrupts.CPU206.NMI:Non-maskable_interrupts
    308.00 ± 33%      +3.1%     317.57 ± 29%     -27.7%     222.57 ± 39%  interrupts.CPU206.PMI:Performance_monitoring_interrupts
      7.17 ± 45%    +155.1%      18.29 ±112%     +47.5%      10.57 ± 67%  interrupts.CPU206.RES:Rescheduling_interrupts
      8.83 ± 17%    +118.3%      19.29 ± 85%     +22.9%      10.86 ± 20%  interrupts.CPU206.TLB:TLB_shootdowns
      1222 ±  3%      +1.9%       1245 ±  2%      +6.0%       1295 ± 10%  interrupts.CPU207.CAL:Function_call_interrupts
    602160            -3.9%     578917 ±  9%      -7.1%     559174 ± 18%  interrupts.CPU207.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU207.MCP:Machine_check_polls
    285.17 ± 28%      +4.1%     296.86 ± 32%     -16.5%     238.14 ± 35%  interrupts.CPU207.NMI:Non-maskable_interrupts
    285.17 ± 28%      +4.1%     296.86 ± 32%     -16.5%     238.14 ± 35%  interrupts.CPU207.PMI:Performance_monitoring_interrupts
     17.00 ± 34%      -7.6%      15.71 ± 39%     +34.5%      22.86 ± 75%  interrupts.CPU207.RES:Rescheduling_interrupts
     10.33 ± 36%     +12.0%      11.57 ± 43%     +57.6%      16.29 ±107%  interrupts.CPU207.TLB:TLB_shootdowns
      1392 ± 27%     -10.2%       1250 ±  2%     -11.8%       1227        interrupts.CPU208.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +5.7e+101%       0.57 ±244%  interrupts.CPU208.IWI:IRQ_work_interrupts
    602015            -1.8%     591324 ±  4%      -7.1%     558973 ± 18%  interrupts.CPU208.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU208.MCP:Machine_check_polls
    352.33 ± 70%     -21.4%     277.00 ± 30%     -39.7%     212.29 ± 36%  interrupts.CPU208.NMI:Non-maskable_interrupts
    352.33 ± 70%     -21.4%     277.00 ± 30%     -39.7%     212.29 ± 36%  interrupts.CPU208.PMI:Performance_monitoring_interrupts
     23.67 ±151%     -67.4%       7.71 ± 35%     -66.2%       8.00 ± 59%  interrupts.CPU208.RES:Rescheduling_interrupts
     11.00 ± 18%      +7.8%      11.86 ± 27%     +61.0%      17.71 ±120%  interrupts.CPU208.TLB:TLB_shootdowns
      1431 ± 28%     -12.1%       1257 ±  3%     -13.4%       1239 ±  2%  interrupts.CPU209.CAL:Function_call_interrupts
    602024            -0.9%     596658 ±  2%      -7.2%     558874 ± 18%  interrupts.CPU209.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU209.MCP:Machine_check_polls
    218.83 ± 32%     +22.4%     267.86 ± 34%     -17.4%     180.71 ± 14%  interrupts.CPU209.NMI:Non-maskable_interrupts
    218.83 ± 32%     +22.4%     267.86 ± 34%     -17.4%     180.71 ± 14%  interrupts.CPU209.PMI:Performance_monitoring_interrupts
     36.17 ±125%     -49.8%      18.14 ± 39%     -62.9%      13.43 ± 35%  interrupts.CPU209.RES:Rescheduling_interrupts
     11.83 ± 44%      -2.2%      11.57 ± 35%     -19.1%       9.57 ± 35%  interrupts.CPU209.TLB:TLB_shootdowns
      1375 ± 10%      +4.1%       1431 ± 13%      -3.9%       1321 ±  4%  interrupts.CPU21.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU21.IWI:IRQ_work_interrupts
    602186            -0.6%     598485            -7.1%     559419 ± 18%  interrupts.CPU21.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU21.MCP:Machine_check_polls
    197.33 ± 31%     +22.0%     240.71 ± 34%      +2.6%     202.43 ± 56%  interrupts.CPU21.NMI:Non-maskable_interrupts
    197.33 ± 31%     +22.0%     240.71 ± 34%      +2.6%     202.43 ± 56%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
     31.33 ± 30%     +48.6%      46.57 ± 45%     -23.9%      23.86 ± 25%  interrupts.CPU21.RES:Rescheduling_interrupts
     23.00 ± 25%      -3.1%      22.29 ± 34%      -8.7%      21.00 ± 34%  interrupts.CPU21.TLB:TLB_shootdowns
      1299 ± 14%      -5.3%       1230            -6.3%       1217        interrupts.CPU210.CAL:Function_call_interrupts
    601969            -3.0%     584143 ±  7%      -7.1%     559031 ± 18%  interrupts.CPU210.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU210.MCP:Machine_check_polls
    266.67 ± 33%      -5.9%     250.86 ± 31%      -6.1%     250.43 ± 44%  interrupts.CPU210.NMI:Non-maskable_interrupts
    266.67 ± 33%      -5.9%     250.86 ± 31%      -6.1%     250.43 ± 44%  interrupts.CPU210.PMI:Performance_monitoring_interrupts
     17.67 ±146%     -41.8%      10.29 ± 68%     -48.2%       9.14 ± 34%  interrupts.CPU210.RES:Rescheduling_interrupts
     10.67 ± 17%     -14.3%       9.14 ± 30%      -0.9%      10.57 ± 36%  interrupts.CPU210.TLB:TLB_shootdowns
      1227            +0.4%       1232            +0.5%       1233 ±  2%  interrupts.CPU211.CAL:Function_call_interrupts
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        interrupts.CPU211.IWI:IRQ_work_interrupts
    602088            -2.8%     585270 ±  6%      -7.1%     559108 ± 18%  interrupts.CPU211.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU211.MCP:Machine_check_polls
    287.00 ± 31%     +33.7%     383.71 ± 18%     +30.8%     375.29 ± 92%  interrupts.CPU211.NMI:Non-maskable_interrupts
    287.00 ± 31%     +33.7%     383.71 ± 18%     +30.8%     375.29 ± 92%  interrupts.CPU211.PMI:Performance_monitoring_interrupts
     17.17 ± 41%     -10.1%      15.43 ± 40%     -31.8%      11.71 ± 23%  interrupts.CPU211.RES:Rescheduling_interrupts
     10.00 ± 36%     -17.1%       8.29 ± 29%      -1.4%       9.86 ± 48%  interrupts.CPU211.TLB:TLB_shootdowns
      1213            +6.3%       1288 ± 10%      +0.6%       1220        interrupts.CPU212.CAL:Function_call_interrupts
    601428            -2.6%     585952 ±  6%      -7.0%     559088 ± 18%  interrupts.CPU212.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU212.MCP:Machine_check_polls
    308.33 ± 35%      -6.1%     289.43 ± 31%     -17.5%     254.29 ± 43%  interrupts.CPU212.NMI:Non-maskable_interrupts
    308.33 ± 35%      -6.1%     289.43 ± 31%     -17.5%     254.29 ± 43%  interrupts.CPU212.PMI:Performance_monitoring_interrupts
     11.33 ± 45%     +32.4%      15.00 ±137%     -44.5%       6.29 ± 34%  interrupts.CPU212.RES:Rescheduling_interrupts
      8.17 ± 42%     +97.7%      16.14 ± 93%      -2.0%       8.00 ± 20%  interrupts.CPU212.TLB:TLB_shootdowns
      1285 ±  7%      -2.6%       1252 ±  2%      -3.9%       1235        interrupts.CPU213.CAL:Function_call_interrupts
    602136            -0.7%     598050            -7.1%     559141 ± 18%  interrupts.CPU213.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU213.MCP:Machine_check_polls
    287.00 ± 31%      -5.2%     272.14 ± 34%     -30.1%     200.71 ± 36%  interrupts.CPU213.NMI:Non-maskable_interrupts
    287.00 ± 31%      -5.2%     272.14 ± 34%     -30.1%     200.71 ± 36%  interrupts.CPU213.PMI:Performance_monitoring_interrupts
     23.00 ± 33%     -29.2%      16.29 ± 25%     -49.1%      11.71 ± 38%  interrupts.CPU213.RES:Rescheduling_interrupts
     13.00 ± 29%     -16.5%      10.86 ± 21%     -31.9%       8.86 ± 16%  interrupts.CPU213.TLB:TLB_shootdowns
      1228            +0.9%       1238 ±  2%      +1.1%       1242 ±  2%  interrupts.CPU214.CAL:Function_call_interrupts
      0.67 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU214.IWI:IRQ_work_interrupts
    602089            -2.0%     589936 ±  5%      -7.2%     559006 ± 18%  interrupts.CPU214.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU214.MCP:Machine_check_polls
    246.67 ± 27%      -5.9%     232.00 ± 31%     -15.2%     209.29 ± 37%  interrupts.CPU214.NMI:Non-maskable_interrupts
    246.67 ± 27%      -5.9%     232.00 ± 31%     -15.2%     209.29 ± 37%  interrupts.CPU214.PMI:Performance_monitoring_interrupts
      7.17 ± 23%     +41.5%      10.14 ± 50%     +53.5%      11.00 ± 59%  interrupts.CPU214.RES:Rescheduling_interrupts
     61.50 ±176%     -78.6%      13.14 ± 26%     -79.3%      12.71 ± 63%  interrupts.CPU214.TLB:TLB_shootdowns
      1219            +9.7%       1336 ± 16%      +3.8%       1265 ±  4%  interrupts.CPU215.CAL:Function_call_interrupts
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU215.IWI:IRQ_work_interrupts
    602064            -2.0%     590294 ±  4%      -7.2%     558958 ± 18%  interrupts.CPU215.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU215.MCP:Machine_check_polls
    295.17 ± 42%     -20.2%     235.43 ± 29%     -25.4%     220.29 ± 37%  interrupts.CPU215.NMI:Non-maskable_interrupts
    295.17 ± 42%     -20.2%     235.43 ± 29%     -25.4%     220.29 ± 37%  interrupts.CPU215.PMI:Performance_monitoring_interrupts
     10.83 ± 31%    +184.8%      30.86 ±104%     +79.3%      19.43 ± 54%  interrupts.CPU215.RES:Rescheduling_interrupts
     11.17 ± 40%     +40.7%      15.71 ± 98%     -14.3%       9.57 ± 31%  interrupts.CPU215.TLB:TLB_shootdowns
      1258 ±  7%      +0.3%       1261 ±  4%      -1.1%       1244 ±  2%  interrupts.CPU216.CAL:Function_call_interrupts
    602081            -2.7%     585759 ±  6%      -7.1%     559084 ± 18%  interrupts.CPU216.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU216.MCP:Machine_check_polls
    330.67 ± 26%     -23.0%     254.71 ± 38%     -26.5%     243.00 ± 42%  interrupts.CPU216.NMI:Non-maskable_interrupts
    330.67 ± 26%     -23.0%     254.71 ± 38%     -26.5%     243.00 ± 42%  interrupts.CPU216.PMI:Performance_monitoring_interrupts
     11.17 ± 87%      +3.6%      11.57 ± 42%      -1.5%      11.00 ± 62%  interrupts.CPU216.RES:Rescheduling_interrupts
     10.00 ± 22%     +35.7%      13.57 ± 46%     +28.6%      12.86 ± 18%  interrupts.CPU216.TLB:TLB_shootdowns
      1447 ± 34%     -13.6%       1250 ±  2%     -12.9%       1260 ±  2%  interrupts.CPU217.CAL:Function_call_interrupts
    602179            -2.0%     589935 ±  5%      -7.1%     559166 ± 18%  interrupts.CPU217.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU217.MCP:Machine_check_polls
    322.33 ± 30%      -6.6%     301.14 ± 33%     -22.3%     250.57 ± 30%  interrupts.CPU217.NMI:Non-maskable_interrupts
    322.33 ± 30%      -6.6%     301.14 ± 33%     -22.3%     250.57 ± 30%  interrupts.CPU217.PMI:Performance_monitoring_interrupts
     15.83 ± 33%     +14.6%      18.14 ± 36%     +34.4%      21.29 ± 28%  interrupts.CPU217.RES:Rescheduling_interrupts
      9.33 ± 14%      +2.6%       9.57 ± 30%     +14.8%      10.71 ± 39%  interrupts.CPU217.TLB:TLB_shootdowns
      1242 ±  2%      -0.2%       1240            +1.9%       1266 ±  7%  interrupts.CPU218.CAL:Function_call_interrupts
      0.00       +2.9e+101%       0.29 ±244%    -100.0%       0.00        interrupts.CPU218.IWI:IRQ_work_interrupts
    602035            -0.5%     599228            -7.1%     559100 ± 18%  interrupts.CPU218.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU218.MCP:Machine_check_polls
    264.33 ± 32%     -20.0%     211.43 ± 26%     -14.1%     227.00 ± 33%  interrupts.CPU218.NMI:Non-maskable_interrupts
    264.33 ± 32%     -20.0%     211.43 ± 26%     -14.1%     227.00 ± 33%  interrupts.CPU218.PMI:Performance_monitoring_interrupts
     11.00 ± 61%      -2.6%      10.71 ± 41%      -5.2%      10.43 ± 80%  interrupts.CPU218.RES:Rescheduling_interrupts
     10.83 ± 26%      +6.8%      11.57 ± 30%      +9.5%      11.86 ±  9%  interrupts.CPU218.TLB:TLB_shootdowns
      1217            +1.5%       1235            +1.8%       1239        interrupts.CPU219.CAL:Function_call_interrupts
    601775            -0.6%     598264            -7.1%     558996 ± 18%  interrupts.CPU219.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU219.MCP:Machine_check_polls
    245.00 ± 32%      -9.7%     221.14 ± 26%     -21.2%     193.00 ± 36%  interrupts.CPU219.NMI:Non-maskable_interrupts
    245.00 ± 32%      -9.7%     221.14 ± 26%     -21.2%     193.00 ± 36%  interrupts.CPU219.PMI:Performance_monitoring_interrupts
     14.33 ± 26%      -7.3%      13.29 ± 16%      +3.7%      14.86 ± 34%  interrupts.CPU219.RES:Rescheduling_interrupts
      9.67 ± 22%      -1.0%       9.57 ± 23%      +2.0%       9.86 ± 31%  interrupts.CPU219.TLB:TLB_shootdowns
      1667 ± 12%      -9.3%       1512 ±  8%      +8.9%       1816 ± 35%  interrupts.CPU22.CAL:Function_call_interrupts
    602206            -0.8%     597141 ±  2%      -7.2%     559050 ± 18%  interrupts.CPU22.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU22.MCP:Machine_check_polls
    339.83 ± 44%     -20.8%     269.00 ± 31%     -41.6%     198.57 ± 26%  interrupts.CPU22.NMI:Non-maskable_interrupts
    339.83 ± 44%     -20.8%     269.00 ± 31%     -41.6%     198.57 ± 26%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
     61.50 ± 47%      -6.6%      57.43 ± 33%     +43.1%      88.00 ± 86%  interrupts.CPU22.RES:Rescheduling_interrupts
     54.17 ± 41%     +13.1%      61.29 ± 23%      +6.3%      57.57 ± 24%  interrupts.CPU22.TLB:TLB_shootdowns
      1302 ± 11%      -1.7%       1280 ±  7%      -4.8%       1240 ±  2%  interrupts.CPU220.CAL:Function_call_interrupts
    602219            -2.0%     589908 ±  5%      -7.2%     559009 ± 18%  interrupts.CPU220.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU220.MCP:Machine_check_polls
    231.67 ± 29%      +5.8%     245.00 ± 29%      +5.0%     243.14 ± 41%  interrupts.CPU220.NMI:Non-maskable_interrupts
    231.67 ± 29%      +5.8%     245.00 ± 29%      +5.0%     243.14 ± 41%  interrupts.CPU220.PMI:Performance_monitoring_interrupts
      9.50 ± 17%     +62.4%      15.43 ± 69%      +9.8%      10.43 ± 42%  interrupts.CPU220.RES:Rescheduling_interrupts
     12.17 ± 23%     +30.3%      15.86 ± 74%    +342.7%      53.86 ±190%  interrupts.CPU220.TLB:TLB_shootdowns
      1283 ±  9%      -6.0%       1206 ± 14%      -3.4%       1239        interrupts.CPU221.CAL:Function_call_interrupts
    602169            -1.7%     592034 ±  4%      -7.1%     559142 ± 18%  interrupts.CPU221.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU221.MCP:Machine_check_polls
    350.00 ± 27%     -13.8%     301.71 ± 34%     -34.8%     228.14 ± 37%  interrupts.CPU221.NMI:Non-maskable_interrupts
    350.00 ± 27%     -13.8%     301.71 ± 34%     -34.8%     228.14 ± 37%  interrupts.CPU221.PMI:Performance_monitoring_interrupts
     25.00 ± 39%      -9.7%      22.57 ± 42%     -28.0%      18.00 ± 38%  interrupts.CPU221.RES:Rescheduling_interrupts
     13.67 ± 69%     -11.1%      12.14 ± 32%     -16.4%      11.43 ± 24%  interrupts.CPU221.TLB:TLB_shootdowns
      1313 ± 14%      -1.6%       1292 ±  6%      +3.1%       1354 ± 20%  interrupts.CPU222.CAL:Function_call_interrupts
    602010            -1.9%     590501 ±  4%      -7.2%     558901 ± 18%  interrupts.CPU222.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU222.MCP:Machine_check_polls
    291.50 ± 30%      +7.9%     314.43 ± 33%     -19.2%     235.57 ± 35%  interrupts.CPU222.NMI:Non-maskable_interrupts
    291.50 ± 30%      +7.9%     314.43 ± 33%     -19.2%     235.57 ± 35%  interrupts.CPU222.PMI:Performance_monitoring_interrupts
     22.67 ±105%     -30.0%      15.86 ± 62%     -32.6%      15.29 ±116%  interrupts.CPU222.RES:Rescheduling_interrupts
     11.00 ± 31%      -2.6%      10.71 ± 40%     +11.7%      12.29 ± 26%  interrupts.CPU222.TLB:TLB_shootdowns
      1316 ± 10%      -0.8%       1305 ± 14%      -5.2%       1247 ±  3%  interrupts.CPU223.CAL:Function_call_interrupts
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        interrupts.CPU223.IWI:IRQ_work_interrupts
    601882            -1.7%     591536 ±  4%      -7.1%     559098 ± 18%  interrupts.CPU223.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU223.MCP:Machine_check_polls
    289.50 ± 33%    +110.4%     609.14 ±133%     -10.6%     258.86 ± 27%  interrupts.CPU223.NMI:Non-maskable_interrupts
    289.50 ± 33%    +110.4%     609.14 ±133%     -10.6%     258.86 ± 27%  interrupts.CPU223.PMI:Performance_monitoring_interrupts
     21.50 ± 60%     -53.5%      10.00 ± 36%     -15.0%      18.29 ± 39%  interrupts.CPU223.RES:Rescheduling_interrupts
     15.33 ± 99%     -49.7%       7.71 ± 29%     -23.6%      11.71 ± 16%  interrupts.CPU223.TLB:TLB_shootdowns
      1255 ±  7%      +4.4%       1310 ± 15%      -0.1%       1253        interrupts.CPU224.CAL:Function_call_interrupts
      0.00       +2.9e+101%       0.29 ±244%    -100.0%       0.00        interrupts.CPU224.IWI:IRQ_work_interrupts
    602080            -3.4%     581759 ±  8%      -7.1%     559068 ± 18%  interrupts.CPU224.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU224.MCP:Machine_check_polls
    267.50 ± 32%     +17.2%     313.43 ± 40%     -29.5%     188.71 ± 16%  interrupts.CPU224.NMI:Non-maskable_interrupts
    267.50 ± 32%     +17.2%     313.43 ± 40%     -29.5%     188.71 ± 16%  interrupts.CPU224.PMI:Performance_monitoring_interrupts
      9.83 ±110%     -28.8%       7.00 ± 79%      +3.1%      10.14 ± 46%  interrupts.CPU224.RES:Rescheduling_interrupts
      9.83 ± 23%     +22.0%      12.00 ± 32%      +1.7%      10.00 ± 15%  interrupts.CPU224.TLB:TLB_shootdowns
      1235 ±  2%      +7.1%       1323 ± 13%      +0.3%       1238        interrupts.CPU225.CAL:Function_call_interrupts
    602112            -3.9%     578917 ±  9%      -7.2%     559016 ± 18%  interrupts.CPU225.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU225.MCP:Machine_check_polls
    315.00 ± 31%     -22.4%     244.29 ± 29%     -27.3%     229.00 ± 34%  interrupts.CPU225.NMI:Non-maskable_interrupts
    315.00 ± 31%     -22.4%     244.29 ± 29%     -27.3%     229.00 ± 34%  interrupts.CPU225.PMI:Performance_monitoring_interrupts
     20.00 ± 37%     +32.9%      26.57 ± 99%     -26.4%      14.71 ± 42%  interrupts.CPU225.RES:Rescheduling_interrupts
      9.67 ± 41%     +75.9%      17.00 ±113%     +38.9%      13.43 ± 33%  interrupts.CPU225.TLB:TLB_shootdowns
      1240 ±  2%      -1.2%       1225            -1.9%       1217        interrupts.CPU226.CAL:Function_call_interrupts
    602034            -2.8%     585387 ±  6%      -7.2%     558980 ± 18%  interrupts.CPU226.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU226.MCP:Machine_check_polls
    396.17 ± 23%     -49.2%     201.14 ±  4%     -37.6%     247.14 ± 40%  interrupts.CPU226.NMI:Non-maskable_interrupts
    396.17 ± 23%     -49.2%     201.14 ±  4%     -37.6%     247.14 ± 40%  interrupts.CPU226.PMI:Performance_monitoring_interrupts
     10.33 ± 36%     -15.7%       8.71 ± 47%     -39.2%       6.29 ± 43%  interrupts.CPU226.RES:Rescheduling_interrupts
     11.83 ± 46%     -10.7%      10.57 ± 33%      -3.4%      11.43 ± 30%  interrupts.CPU226.TLB:TLB_shootdowns
      1137 ± 17%      +9.4%       1243 ±  2%      +8.5%       1233        interrupts.CPU227.CAL:Function_call_interrupts
    602142            -2.4%     587961 ±  5%      -7.3%     558446 ± 18%  interrupts.CPU227.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU227.MCP:Machine_check_polls
    322.50 ± 31%     -15.2%     273.43 ± 34%     -34.3%     212.00 ±  5%  interrupts.CPU227.NMI:Non-maskable_interrupts
    322.50 ± 31%     -15.2%     273.43 ± 34%     -34.3%     212.00 ±  5%  interrupts.CPU227.PMI:Performance_monitoring_interrupts
     15.17 ± 38%      +3.6%      15.71 ± 18%     +11.1%      16.86 ± 31%  interrupts.CPU227.RES:Rescheduling_interrupts
     12.33 ± 65%     -25.9%       9.14 ± 45%     -24.7%       9.29 ± 22%  interrupts.CPU227.TLB:TLB_shootdowns
      1264 ±  2%      -2.1%       1238 ±  2%      +0.3%       1268 ±  5%  interrupts.CPU228.CAL:Function_call_interrupts
    602191            -2.6%     586259 ±  6%      -7.1%     559173 ± 18%  interrupts.CPU228.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU228.MCP:Machine_check_polls
    295.67 ± 30%     -21.8%     231.14 ± 29%     -21.6%     231.86 ± 27%  interrupts.CPU228.NMI:Non-maskable_interrupts
    295.67 ± 30%     -21.8%     231.14 ± 29%     -21.6%     231.86 ± 27%  interrupts.CPU228.PMI:Performance_monitoring_interrupts
     11.67 ± 54%      -2.0%      11.43 ± 54%     +23.7%      14.43 ± 71%  interrupts.CPU228.RES:Rescheduling_interrupts
     10.83 ± 15%      +2.9%      11.14 ± 35%     +62.2%      17.57 ± 82%  interrupts.CPU228.TLB:TLB_shootdowns
      1244 ±  2%      -1.0%       1231            +3.3%       1285 ±  6%  interrupts.CPU229.CAL:Function_call_interrupts
    602164            -3.5%     581256 ±  8%      -7.2%     559104 ± 18%  interrupts.CPU229.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU229.MCP:Machine_check_polls
    319.50 ± 33%     -15.6%     269.57 ± 35%     -29.5%     225.29 ± 31%  interrupts.CPU229.NMI:Non-maskable_interrupts
    319.50 ± 33%     -15.6%     269.57 ± 35%     -29.5%     225.29 ± 31%  interrupts.CPU229.PMI:Performance_monitoring_interrupts
     18.67 ± 11%     -34.2%      12.29 ± 47%     +17.9%      22.00 ± 67%  interrupts.CPU229.RES:Rescheduling_interrupts
      8.67 ± 29%      +0.5%       8.71 ± 23%     +26.9%      11.00 ± 38%  interrupts.CPU229.TLB:TLB_shootdowns
      1365 ±  7%      -1.0%       1351 ±  3%      +6.7%       1456 ± 21%  interrupts.CPU23.CAL:Function_call_interrupts
      0.67 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.IWI:IRQ_work_interrupts
    602187            -0.8%     597486 ±  2%      -7.1%     559354 ± 18%  interrupts.CPU23.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU23.MCP:Machine_check_polls
      1203 ±165%     -81.9%     218.29 ± 33%     -81.7%     220.00 ± 46%  interrupts.CPU23.NMI:Non-maskable_interrupts
      1203 ±165%     -81.9%     218.29 ± 33%     -81.7%     220.00 ± 46%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
     25.67 ± 46%     +24.7%      32.00 ± 36%     +15.8%      29.71 ± 99%  interrupts.CPU23.RES:Rescheduling_interrupts
     19.33 ± 48%     +21.2%      23.43 ± 29%      +3.4%      20.00 ± 23%  interrupts.CPU23.TLB:TLB_shootdowns
      1461 ± 26%     -15.6%       1233           -15.2%       1239        interrupts.CPU230.CAL:Function_call_interrupts
      1.00 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU230.IWI:IRQ_work_interrupts
    602175            -3.2%     582756 ±  7%      -7.2%     558995 ± 18%  interrupts.CPU230.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU230.MCP:Machine_check_polls
    342.17 ± 39%     -32.4%     231.43 ± 29%     -26.9%     250.00 ± 42%  interrupts.CPU230.NMI:Non-maskable_interrupts
    342.17 ± 39%     -32.4%     231.43 ± 29%     -26.9%     250.00 ± 42%  interrupts.CPU230.PMI:Performance_monitoring_interrupts
     13.50 ± 46%     -31.2%       9.29 ± 77%     -35.4%       8.71 ± 37%  interrupts.CPU230.RES:Rescheduling_interrupts
     11.17 ± 40%      -2.8%      10.86 ± 33%      +4.9%      11.71 ± 33%  interrupts.CPU230.TLB:TLB_shootdowns
      1245 ±  2%      -1.1%       1230            -1.0%       1232        interrupts.CPU231.CAL:Function_call_interrupts
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU231.IWI:IRQ_work_interrupts
    602177            -3.8%     579230 ±  9%      -7.2%     558819 ± 18%  interrupts.CPU231.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU231.MCP:Machine_check_polls
    368.17 ± 32%     -42.1%     213.14 ±  8%     -16.2%     308.43 ± 35%  interrupts.CPU231.NMI:Non-maskable_interrupts
    368.17 ± 32%     -42.1%     213.14 ±  8%     -16.2%     308.43 ± 35%  interrupts.CPU231.PMI:Performance_monitoring_interrupts
     15.00 ± 56%      -2.9%      14.57 ± 64%      +0.0%      15.00 ± 20%  interrupts.CPU231.RES:Rescheduling_interrupts
     13.67 ± 61%     -28.9%       9.71 ± 37%     -24.7%      10.29 ± 34%  interrupts.CPU231.TLB:TLB_shootdowns
      1242 ±  2%      -1.2%       1227            -0.9%       1231        interrupts.CPU232.CAL:Function_call_interrupts
    602054            -0.4%     599685            -7.2%     558945 ± 18%  interrupts.CPU232.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU232.MCP:Machine_check_polls
    278.00 ± 28%     -28.9%     197.71 ± 23%     -22.9%     214.29 ± 43%  interrupts.CPU232.NMI:Non-maskable_interrupts
    278.00 ± 28%     -28.9%     197.71 ± 23%     -22.9%     214.29 ± 43%  interrupts.CPU232.PMI:Performance_monitoring_interrupts
      9.33 ± 36%     -14.3%       8.00 ± 79%      -3.6%       9.00 ± 50%  interrupts.CPU232.RES:Rescheduling_interrupts
      9.83 ± 34%      -5.6%       9.29 ± 32%      -4.1%       9.43 ± 21%  interrupts.CPU232.TLB:TLB_shootdowns
      1277 ±  8%      -4.0%       1226            -3.1%       1237        interrupts.CPU233.CAL:Function_call_interrupts
      0.50 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU233.IWI:IRQ_work_interrupts
    602031            -0.3%     600036            -7.1%     559053 ± 18%  interrupts.CPU233.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU233.MCP:Machine_check_polls
    281.17 ± 28%     -15.8%     236.86 ± 30%     -26.7%     206.00 ± 36%  interrupts.CPU233.NMI:Non-maskable_interrupts
    281.17 ± 28%     -15.8%     236.86 ± 30%     -26.7%     206.00 ± 36%  interrupts.CPU233.PMI:Performance_monitoring_interrupts
     18.33 ± 67%     -36.9%      11.57 ± 47%     -24.4%      13.86 ± 34%  interrupts.CPU233.RES:Rescheduling_interrupts
     13.17 ±101%     -33.8%       8.71 ± 20%     -31.6%       9.00 ± 27%  interrupts.CPU233.TLB:TLB_shootdowns
      1226            +3.4%       1268 ±  4%      +0.9%       1237 ±  2%  interrupts.CPU234.CAL:Function_call_interrupts
    602000            -0.2%     600767            -7.1%     559073 ± 18%  interrupts.CPU234.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU234.MCP:Machine_check_polls
    197.83 ± 33%      +8.9%     215.43 ± 33%      -0.8%     196.29 ± 29%  interrupts.CPU234.NMI:Non-maskable_interrupts
    197.83 ± 33%      +8.9%     215.43 ± 33%      -0.8%     196.29 ± 29%  interrupts.CPU234.PMI:Performance_monitoring_interrupts
     10.17 ± 30%     +18.0%      12.00 ± 42%     -22.7%       7.86 ± 61%  interrupts.CPU234.RES:Rescheduling_interrupts
     10.83 ± 28%      +1.5%      11.00 ± 31%      +8.1%      11.71 ± 35%  interrupts.CPU234.TLB:TLB_shootdowns
      1228            +3.0%       1265 ±  8%      +0.6%       1235        interrupts.CPU235.CAL:Function_call_interrupts
    602209            -0.2%     600920            -7.2%     558903 ± 18%  interrupts.CPU235.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU235.MCP:Machine_check_polls
    286.00 ± 27%     -12.3%     250.86 ± 34%     -16.6%     238.43 ± 36%  interrupts.CPU235.NMI:Non-maskable_interrupts
    286.00 ± 27%     -12.3%     250.86 ± 34%     -16.6%     238.43 ± 36%  interrupts.CPU235.PMI:Performance_monitoring_interrupts
     12.00 ± 19%     +79.8%      21.57 ± 65%     +28.6%      15.43 ± 36%  interrupts.CPU235.RES:Rescheduling_interrupts
     11.17 ± 52%     -18.1%       9.14 ± 29%      -0.2%      11.14 ± 19%  interrupts.CPU235.TLB:TLB_shootdowns
      1230            +6.7%       1312 ± 15%      +3.0%       1267 ±  2%  interrupts.CPU236.CAL:Function_call_interrupts
    601971            -1.2%     594835 ±  3%      -7.1%     559025 ± 18%  interrupts.CPU236.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU236.MCP:Machine_check_polls
    247.50 ± 31%     -21.7%     193.71 ± 27%     -16.4%     206.86 ± 41%  interrupts.CPU236.NMI:Non-maskable_interrupts
    247.50 ± 31%     -21.7%     193.71 ± 27%     -16.4%     206.86 ± 41%  interrupts.CPU236.PMI:Performance_monitoring_interrupts
      7.00 ± 45%    +146.9%      17.29 ± 82%    +116.3%      15.14 ± 45%  interrupts.CPU236.RES:Rescheduling_interrupts
      8.83 ± 12%     +55.3%      13.71 ± 43%     +76.3%      15.57 ± 32%  interrupts.CPU236.TLB:TLB_shootdowns
      1217            +4.0%       1266 ±  2%      +1.1%       1231        interrupts.CPU237.CAL:Function_call_interrupts
    602160            -0.8%     597119 ±  2%      -7.2%     559020 ± 18%  interrupts.CPU237.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU237.MCP:Machine_check_polls
    235.33 ± 35%     -22.5%     182.43 ± 10%     -17.8%     193.43 ± 40%  interrupts.CPU237.NMI:Non-maskable_interrupts
    235.33 ± 35%     -22.5%     182.43 ± 10%     -17.8%     193.43 ± 40%  interrupts.CPU237.PMI:Performance_monitoring_interrupts
     14.67 ± 31%     +21.8%      17.86 ± 32%      +2.3%      15.00 ± 22%  interrupts.CPU237.RES:Rescheduling_interrupts
      8.67 ± 22%     +51.6%      13.14 ± 64%     +35.2%      11.71 ± 50%  interrupts.CPU237.TLB:TLB_shootdowns
      1237            +0.2%       1240 ±  2%      +3.9%       1286 ±  6%  interrupts.CPU238.CAL:Function_call_interrupts
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        interrupts.CPU238.IWI:IRQ_work_interrupts
    602017            -1.3%     594274 ±  3%      -7.1%     558983 ± 18%  interrupts.CPU238.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU238.MCP:Machine_check_polls
    327.83 ± 27%     +53.0%     501.57 ±115%     -20.7%     260.00 ± 33%  interrupts.CPU238.NMI:Non-maskable_interrupts
    327.83 ± 27%     +53.0%     501.57 ±115%     -20.7%     260.00 ± 33%  interrupts.CPU238.PMI:Performance_monitoring_interrupts
      9.67 ± 57%     -26.1%       7.14 ± 40%     +65.5%      16.00 ± 98%  interrupts.CPU238.RES:Rescheduling_interrupts
      9.00 ± 11%     +15.9%      10.43 ± 35%    +103.2%      18.29 ± 76%  interrupts.CPU238.TLB:TLB_shootdowns
      1220            +0.4%       1225            +2.9%       1255 ±  4%  interrupts.CPU239.CAL:Function_call_interrupts
      0.33 ±223%     -57.1%       0.14 ±244%    -100.0%       0.00        interrupts.CPU239.IWI:IRQ_work_interrupts
    601910            -0.4%     599605            -7.1%     559147 ± 18%  interrupts.CPU239.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU239.MCP:Machine_check_polls
    234.67 ± 37%     +35.8%     318.57 ± 52%      -1.4%     231.29 ± 33%  interrupts.CPU239.NMI:Non-maskable_interrupts
    234.67 ± 37%     +35.8%     318.57 ± 52%      -1.4%     231.29 ± 33%  interrupts.CPU239.PMI:Performance_monitoring_interrupts
     12.67 ± 32%      +0.4%      12.71 ± 36%      +1.5%      12.86 ± 65%  interrupts.CPU239.RES:Rescheduling_interrupts
      7.17 ± 14%     +41.5%      10.14 ± 35%     +79.4%      12.86 ± 43%  interrupts.CPU239.TLB:TLB_shootdowns
      2238 ± 63%     -26.9%       1636 ±  8%     -17.8%       1839 ± 23%  interrupts.CPU24.CAL:Function_call_interrupts
    602190            -0.3%     600638            -7.1%     559194 ± 18%  interrupts.CPU24.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU24.MCP:Machine_check_polls
    248.83 ± 34%      -6.0%     234.00 ± 31%     -10.6%     222.57 ± 38%  interrupts.CPU24.NMI:Non-maskable_interrupts
    248.83 ± 34%      -6.0%     234.00 ± 31%     -10.6%     222.57 ± 38%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
    115.00 ±119%     -42.5%      66.14 ± 34%     -22.0%      89.71 ± 58%  interrupts.CPU24.RES:Rescheduling_interrupts
     59.17 ± 40%      +9.4%      64.71 ± 15%     +18.3%      70.00 ± 16%  interrupts.CPU24.TLB:TLB_shootdowns
      1244 ±  2%      -0.3%       1240 ±  3%      -2.1%       1218        interrupts.CPU240.CAL:Function_call_interrupts
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU240.IWI:IRQ_work_interrupts
    602047            -0.9%     596503 ±  2%      -7.1%     559017 ± 18%  interrupts.CPU240.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU240.MCP:Machine_check_polls
    261.67 ± 31%      -7.7%     241.43 ± 32%      -5.6%     247.14 ± 31%  interrupts.CPU240.NMI:Non-maskable_interrupts
    261.67 ± 31%      -7.7%     241.43 ± 32%      -5.6%     247.14 ± 31%  interrupts.CPU240.PMI:Performance_monitoring_interrupts
     10.67 ± 30%      +9.8%      11.71 ± 63%     -34.4%       7.00 ± 15%  interrupts.CPU240.RES:Rescheduling_interrupts
      9.00 ± 20%     +25.4%      11.29 ± 43%    +476.2%      51.86 ±197%  interrupts.CPU240.TLB:TLB_shootdowns
      1218            +0.4%       1223            +1.7%       1238        interrupts.CPU241.CAL:Function_call_interrupts
    602128            -0.9%     596612 ±  2%      -7.1%     559104 ± 18%  interrupts.CPU241.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU241.MCP:Machine_check_polls
    262.00 ± 31%     -20.2%     209.14 ± 29%      +3.5%     271.14 ± 32%  interrupts.CPU241.NMI:Non-maskable_interrupts
    262.00 ± 31%     -20.2%     209.14 ± 29%      +3.5%     271.14 ± 32%  interrupts.CPU241.PMI:Performance_monitoring_interrupts
     11.50 ± 25%     +23.0%      14.14 ± 44%     +52.8%      17.57 ± 31%  interrupts.CPU241.RES:Rescheduling_interrupts
      8.33 ± 22%     +38.9%      11.57 ± 40%     +21.7%      10.14 ± 29%  interrupts.CPU241.TLB:TLB_shootdowns
      1223            +0.3%       1227            +0.2%       1225        interrupts.CPU242.CAL:Function_call_interrupts
    602015            -1.0%     596254 ±  2%      -7.1%     558986 ± 18%  interrupts.CPU242.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU242.MCP:Machine_check_polls
    266.50 ± 27%     -36.4%     169.43 ±  2%     -16.1%     223.71 ± 31%  interrupts.CPU242.NMI:Non-maskable_interrupts
    266.50 ± 27%     -36.4%     169.43 ±  2%     -16.1%     223.71 ± 31%  interrupts.CPU242.PMI:Performance_monitoring_interrupts
      8.33 ± 34%     -14.3%       7.14 ± 42%     -21.1%       6.57 ± 31%  interrupts.CPU242.RES:Rescheduling_interrupts
      8.33 ± 21%     +42.3%      11.86 ± 24%     +18.3%       9.86 ± 17%  interrupts.CPU242.TLB:TLB_shootdowns
      1258 ±  7%      -2.3%       1229            -1.3%       1242 ±  2%  interrupts.CPU243.CAL:Function_call_interrupts
    602040            -1.1%     595536 ±  2%      -7.1%     559121 ± 18%  interrupts.CPU243.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU243.MCP:Machine_check_polls
    284.33 ± 29%     -27.8%     205.43 ± 29%     -11.5%     251.57 ± 32%  interrupts.CPU243.NMI:Non-maskable_interrupts
    284.33 ± 29%     -27.8%     205.43 ± 29%     -11.5%     251.57 ± 32%  interrupts.CPU243.PMI:Performance_monitoring_interrupts
     19.83 ± 84%     -45.3%      10.86 ± 40%     -23.6%      15.14 ± 37%  interrupts.CPU243.RES:Rescheduling_interrupts
     16.00 ±106%     -32.1%      10.86 ± 56%     -26.8%      11.71 ± 15%  interrupts.CPU243.TLB:TLB_shootdowns
      1258 ±  2%      -1.4%       1240 ±  2%      -0.8%       1248 ±  3%  interrupts.CPU244.CAL:Function_call_interrupts
      0.00       +5.7e+101%       0.57 ±244%    -100.0%       0.00        interrupts.CPU244.IWI:IRQ_work_interrupts
    601973            -0.4%     599266            -7.1%     558966 ± 18%  interrupts.CPU244.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU244.MCP:Machine_check_polls
    234.33 ± 34%     +14.5%     268.43 ± 29%     +11.4%     261.00 ± 32%  interrupts.CPU244.NMI:Non-maskable_interrupts
    234.33 ± 34%     +14.5%     268.43 ± 29%     +11.4%     261.00 ± 32%  interrupts.CPU244.PMI:Performance_monitoring_interrupts
     13.83 ± 88%     -27.7%      10.00 ± 52%     -31.8%       9.43 ± 72%  interrupts.CPU244.RES:Rescheduling_interrupts
     13.17 ± 15%     -14.3%      11.29 ± 29%      -2.4%      12.86 ± 35%  interrupts.CPU244.TLB:TLB_shootdowns
      1253 ±  4%      +1.3%       1269 ±  8%      -1.5%       1233        interrupts.CPU245.CAL:Function_call_interrupts
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        interrupts.CPU245.IWI:IRQ_work_interrupts
    601916            -0.7%     597826            -7.1%     558980 ± 18%  interrupts.CPU245.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU245.MCP:Machine_check_polls
    262.33 ± 34%     +11.7%     293.00 ± 31%     +17.2%     307.43 ± 33%  interrupts.CPU245.NMI:Non-maskable_interrupts
    262.33 ± 34%     +11.7%     293.00 ± 31%     +17.2%     307.43 ± 33%  interrupts.CPU245.PMI:Performance_monitoring_interrupts
     17.67 ± 45%      -7.0%      16.43 ± 84%      -8.6%      16.14 ± 41%  interrupts.CPU245.RES:Rescheduling_interrupts
     12.67 ± 52%     -16.5%      10.57 ± 48%     -21.1%      10.00 ± 30%  interrupts.CPU245.TLB:TLB_shootdowns
      1262 ±  4%      +5.3%       1329 ± 16%      -2.7%       1227 ±  2%  interrupts.CPU246.CAL:Function_call_interrupts
    602062            -0.5%     599070            -7.1%     559217 ± 18%  interrupts.CPU246.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU246.MCP:Machine_check_polls
    231.50 ± 37%      -0.9%     229.43 ± 36%      +8.6%     251.43 ± 38%  interrupts.CPU246.NMI:Non-maskable_interrupts
    231.50 ± 37%      -0.9%     229.43 ± 36%      +8.6%     251.43 ± 38%  interrupts.CPU246.PMI:Performance_monitoring_interrupts
     12.67 ± 58%      -6.4%      11.86 ± 60%     -49.2%       6.43 ± 53%  interrupts.CPU246.RES:Rescheduling_interrupts
     11.67 ± 31%      +2.9%      12.00 ± 37%      -6.9%      10.86 ± 15%  interrupts.CPU246.TLB:TLB_shootdowns
      1153 ± 17%      +9.2%       1259 ±  4%      +6.6%       1228        interrupts.CPU247.CAL:Function_call_interrupts
    602054            -0.4%     599874            -7.1%     559235 ± 18%  interrupts.CPU247.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU247.MCP:Machine_check_polls
    322.50 ± 27%     -23.3%     247.43 ± 33%      -0.6%     320.43 ± 27%  interrupts.CPU247.NMI:Non-maskable_interrupts
    322.50 ± 27%     -23.3%     247.43 ± 33%      -0.6%     320.43 ± 27%  interrupts.CPU247.PMI:Performance_monitoring_interrupts
     19.50 ± 18%      -9.9%      17.57 ± 33%     -30.4%      13.57 ± 31%  interrupts.CPU247.RES:Rescheduling_interrupts
      8.50 ± 20%     +61.3%      13.71 ± 57%     +14.3%       9.71 ± 37%  interrupts.CPU247.TLB:TLB_shootdowns
      1237            +0.8%       1247 ±  2%      +0.1%       1238 ±  3%  interrupts.CPU248.CAL:Function_call_interrupts
    602017            -1.0%     596213 ±  2%      -7.1%     558996 ± 18%  interrupts.CPU248.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU248.MCP:Machine_check_polls
    229.33 ± 32%     -17.5%     189.14 ± 32%      +0.5%     230.57 ± 40%  interrupts.CPU248.NMI:Non-maskable_interrupts
    229.33 ± 32%     -17.5%     189.14 ± 32%      +0.5%     230.57 ± 40%  interrupts.CPU248.PMI:Performance_monitoring_interrupts
      7.33 ± 52%     +61.7%      11.86 ± 39%     +51.9%      11.14 ± 54%  interrupts.CPU248.RES:Rescheduling_interrupts
      9.67 ± 25%     +33.0%      12.86 ± 27%    +105.4%      19.86 ±105%  interrupts.CPU248.TLB:TLB_shootdowns
      1216            +1.3%       1232            -4.4%       1162 ± 15%  interrupts.CPU249.CAL:Function_call_interrupts
    602092            -0.9%     596465 ±  2%      -7.2%     558827 ± 18%  interrupts.CPU249.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU249.MCP:Machine_check_polls
    232.67 ± 33%     +10.9%     258.00 ± 33%     +17.6%     273.71 ± 36%  interrupts.CPU249.NMI:Non-maskable_interrupts
    232.67 ± 33%     +10.9%     258.00 ± 33%     +17.6%     273.71 ± 36%  interrupts.CPU249.PMI:Performance_monitoring_interrupts
     14.33 ± 28%      -8.3%      13.14 ± 28%      +3.7%      14.86 ± 23%  interrupts.CPU249.RES:Rescheduling_interrupts
      8.50 ± 20%     +36.1%      11.57 ± 32%     +10.9%       9.43 ± 33%  interrupts.CPU249.TLB:TLB_shootdowns
      1527 ± 23%     -12.5%       1336 ±  4%     -10.3%       1369 ±  9%  interrupts.CPU25.CAL:Function_call_interrupts
    602317            -0.4%     599663            -7.1%     559256 ± 18%  interrupts.CPU25.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU25.MCP:Machine_check_polls
    226.33 ± 39%     -12.0%     199.29 ± 26%      +3.9%     235.14 ± 31%  interrupts.CPU25.NMI:Non-maskable_interrupts
    226.33 ± 39%     -12.0%     199.29 ± 26%      +3.9%     235.14 ± 31%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
     46.83 ± 81%     -50.0%      23.43 ± 37%     -42.7%      26.86 ± 46%  interrupts.CPU25.RES:Rescheduling_interrupts
     20.67 ± 30%      +4.4%      21.57 ± 12%     +12.7%      23.29 ± 15%  interrupts.CPU25.TLB:TLB_shootdowns
      1224            +3.1%       1261 ±  4%      +1.9%       1247 ±  2%  interrupts.CPU250.CAL:Function_call_interrupts
    601980            -0.9%     596475 ±  2%      -7.1%     558998 ± 18%  interrupts.CPU250.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU250.MCP:Machine_check_polls
    173.17 ±  2%     +39.0%     240.71 ± 34%     +33.1%     230.43 ± 39%  interrupts.CPU250.NMI:Non-maskable_interrupts
    173.17 ±  2%     +39.0%     240.71 ± 34%     +33.1%     230.43 ± 39%  interrupts.CPU250.PMI:Performance_monitoring_interrupts
      7.00 ± 11%     +57.1%      11.00 ± 85%     +34.7%       9.43 ± 50%  interrupts.CPU250.RES:Rescheduling_interrupts
     10.50 ± 36%     +34.7%      14.14 ± 58%     +26.5%      13.29 ± 30%  interrupts.CPU250.TLB:TLB_shootdowns
      1221            +3.7%       1267 ±  6%      +1.0%       1233        interrupts.CPU251.CAL:Function_call_interrupts
    601952            -0.9%     596412 ±  2%      -7.1%     559115 ± 18%  interrupts.CPU251.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU251.MCP:Machine_check_polls
    272.50 ± 34%     -12.0%     239.71 ± 42%      -8.8%     248.57 ± 39%  interrupts.CPU251.NMI:Non-maskable_interrupts
    272.50 ± 34%     -12.0%     239.71 ± 42%      -8.8%     248.57 ± 39%  interrupts.CPU251.PMI:Performance_monitoring_interrupts
     14.83 ± 23%      -0.8%      14.71 ± 58%     -10.4%      13.29 ± 25%  interrupts.CPU251.RES:Rescheduling_interrupts
     12.00 ± 65%    +348.8%      53.86 ±189%     +14.3%      13.71 ± 40%  interrupts.CPU251.TLB:TLB_shootdowns
      1220            -0.1%       1218            +3.7%       1265 ± 10%  interrupts.CPU252.CAL:Function_call_interrupts
    602062            -0.4%     599477            -7.2%     558818 ± 18%  interrupts.CPU252.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU252.MCP:Machine_check_polls
    285.83 ± 30%     -29.5%     201.57 ± 31%     -23.8%     217.86 ± 41%  interrupts.CPU252.NMI:Non-maskable_interrupts
    285.83 ± 30%     -29.5%     201.57 ± 31%     -23.8%     217.86 ± 41%  interrupts.CPU252.PMI:Performance_monitoring_interrupts
     11.33 ± 63%     -28.2%       8.14 ± 41%      +0.8%      11.43 ±134%  interrupts.CPU252.RES:Rescheduling_interrupts
      7.67 ± 16%     +47.2%      11.29 ± 13%     +32.3%      10.14 ± 19%  interrupts.CPU252.TLB:TLB_shootdowns
      1252 ±  5%      -1.7%       1230            -1.1%       1237        interrupts.CPU253.CAL:Function_call_interrupts
    602075            -0.6%     598412            -7.2%     558950 ± 18%  interrupts.CPU253.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU253.MCP:Machine_check_polls
    262.00 ± 34%      +2.1%     267.57 ± 32%     +12.8%     295.57 ± 35%  interrupts.CPU253.NMI:Non-maskable_interrupts
    262.00 ± 34%      +2.1%     267.57 ± 32%     +12.8%     295.57 ± 35%  interrupts.CPU253.PMI:Performance_monitoring_interrupts
     15.83 ± 33%      +2.9%      16.29 ± 26%     +13.7%      18.00 ± 19%  interrupts.CPU253.RES:Rescheduling_interrupts
     12.33 ± 50%     -21.2%       9.71 ± 42%     -13.1%      10.71 ± 26%  interrupts.CPU253.TLB:TLB_shootdowns
      1221            +0.3%       1224            +4.3%       1273 ±  7%  interrupts.CPU254.CAL:Function_call_interrupts
    602098            -0.5%     599214            -7.2%     558962 ± 18%  interrupts.CPU254.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU254.MCP:Machine_check_polls
    235.50 ± 35%      +7.4%     252.86 ± 35%     +27.8%     301.00 ± 31%  interrupts.CPU254.NMI:Non-maskable_interrupts
    235.50 ± 35%      +7.4%     252.86 ± 35%     +27.8%     301.00 ± 31%  interrupts.CPU254.PMI:Performance_monitoring_interrupts
     10.50 ± 45%     -36.1%       6.71 ± 52%     +38.8%      14.57 ± 96%  interrupts.CPU254.RES:Rescheduling_interrupts
      9.67 ± 19%     +12.3%      10.86 ± 50%     +33.0%      12.86 ± 44%  interrupts.CPU254.TLB:TLB_shootdowns
      1191            +1.9%       1214 ±  2%      +6.8%       1272 ± 15%  interrupts.CPU255.CAL:Function_call_interrupts
      0.00       +2.9e+101%       0.29 ±244%    -100.0%       0.00        interrupts.CPU255.IWI:IRQ_work_interrupts
    602105            -0.4%     599460            -7.2%     559016 ± 18%  interrupts.CPU255.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU255.MCP:Machine_check_polls
    619.33 ± 30%     +24.6%     771.57 ± 49%      -0.8%     614.43 ± 71%  interrupts.CPU255.NMI:Non-maskable_interrupts
    619.33 ± 30%     +24.6%     771.57 ± 49%      -0.8%     614.43 ± 71%  interrupts.CPU255.PMI:Performance_monitoring_interrupts
     11.50 ± 28%      +4.3%      12.00 ± 63%     +70.2%      19.57 ± 96%  interrupts.CPU255.RES:Rescheduling_interrupts
    146.00 ± 84%     +45.0%     211.71 ± 68%     +11.4%     162.71 ± 98%  interrupts.CPU255.TLB:TLB_shootdowns
      1794 ± 11%     -15.8%       1510 ±  8%      -8.4%       1644 ± 12%  interrupts.CPU26.CAL:Function_call_interrupts
    602211            -0.7%     597940            -7.2%     559079 ± 18%  interrupts.CPU26.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU26.MCP:Machine_check_polls
    238.50 ± 36%     +11.6%     266.14 ± 28%     -11.2%     211.71 ± 31%  interrupts.CPU26.NMI:Non-maskable_interrupts
    238.50 ± 36%     +11.6%     266.14 ± 28%     -11.2%     211.71 ± 31%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
     74.83 ± 42%     -28.0%      53.86 ± 43%     -12.4%      65.57 ± 46%  interrupts.CPU26.RES:Rescheduling_interrupts
     69.67 ±  8%      -9.0%      63.43 ± 37%     -16.3%      58.29 ± 29%  interrupts.CPU26.TLB:TLB_shootdowns
      1351 ±  4%      -0.4%       1346 ±  5%      +0.2%       1354 ±  9%  interrupts.CPU27.CAL:Function_call_interrupts
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        interrupts.CPU27.IWI:IRQ_work_interrupts
    602331            -0.3%     600816            -7.1%     559428 ± 18%  interrupts.CPU27.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU27.MCP:Machine_check_polls
    285.67 ± 34%     +18.0%     337.14 ± 51%     -13.3%     247.71 ± 40%  interrupts.CPU27.NMI:Non-maskable_interrupts
    285.67 ± 34%     +18.0%     337.14 ± 51%     -13.3%     247.71 ± 40%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
     24.33 ± 32%     +16.8%      28.43 ± 29%     +11.0%      27.00 ± 68%  interrupts.CPU27.RES:Rescheduling_interrupts
     21.83 ± 26%      -9.7%      19.71 ± 34%    +298.5%      87.00 ±185%  interrupts.CPU27.TLB:TLB_shootdowns
      1668 ±  7%      -5.4%       1579 ± 13%      -5.1%       1583 ±  9%  interrupts.CPU28.CAL:Function_call_interrupts
      0.00       +2.9e+101%       0.29 ±244%    -100.0%       0.00        interrupts.CPU28.IWI:IRQ_work_interrupts
    602236            -0.8%     597167 ±  2%      -7.1%     559286 ± 18%  interrupts.CPU28.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU28.MCP:Machine_check_polls
    258.50 ± 32%     +99.5%     515.71 ±133%      -9.0%     235.29 ± 40%  interrupts.CPU28.NMI:Non-maskable_interrupts
    258.50 ± 32%     +99.5%     515.71 ±133%      -9.0%     235.29 ± 40%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
     66.67 ± 24%      +3.5%      69.00 ± 47%      +4.6%      69.71 ± 28%  interrupts.CPU28.RES:Rescheduling_interrupts
     67.00 ±  5%     -20.9%      53.00 ± 35%      +2.6%      68.71 ± 11%  interrupts.CPU28.TLB:TLB_shootdowns
      1367 ±  8%      +3.6%       1417 ± 11%      -0.3%       1364 ±  6%  interrupts.CPU29.CAL:Function_call_interrupts
    602257            -0.9%     597101 ±  2%      -7.1%     559259 ± 18%  interrupts.CPU29.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU29.MCP:Machine_check_polls
    224.00 ± 35%     +20.5%     270.00 ± 29%     +13.7%     254.71 ± 34%  interrupts.CPU29.NMI:Non-maskable_interrupts
    224.00 ± 35%     +20.5%     270.00 ± 29%     +13.7%     254.71 ± 34%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
     30.50 ± 38%     +21.3%      37.00 ± 20%     -11.0%      27.14 ± 26%  interrupts.CPU29.RES:Rescheduling_interrupts
     23.50 ± 26%      -5.2%      22.29 ± 44%      +2.7%      24.14 ± 16%  interrupts.CPU29.TLB:TLB_shootdowns
      1358 ±  3%      +4.8%       1424 ± 10%     +11.9%       1521 ± 16%  interrupts.CPU3.CAL:Function_call_interrupts
    602355            -0.1%     601478            -7.2%     559286 ± 18%  interrupts.CPU3.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU3.MCP:Machine_check_polls
    185.17 ± 29%     +28.1%     237.14 ± 34%    +137.8%     440.29 ±118%  interrupts.CPU3.NMI:Non-maskable_interrupts
    185.17 ± 29%     +28.1%     237.14 ± 34%    +137.8%     440.29 ±118%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
     35.17 ± 33%     -30.9%      24.29 ± 62%     -40.3%      21.00 ± 40%  interrupts.CPU3.RES:Rescheduling_interrupts
     23.33 ± 11%      -4.5%      22.29 ± 32%     -18.0%      19.14 ± 55%  interrupts.CPU3.TLB:TLB_shootdowns
      2017 ± 59%     -26.2%       1489 ± 10%      +5.6%       2131 ± 57%  interrupts.CPU30.CAL:Function_call_interrupts
    602283            -0.6%     598846            -7.2%     558831 ± 18%  interrupts.CPU30.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU30.MCP:Machine_check_polls
    258.33 ± 27%     -14.7%     220.29 ± 33%      +1.6%     262.43 ± 28%  interrupts.CPU30.NMI:Non-maskable_interrupts
    258.33 ± 27%     -14.7%     220.29 ± 33%      +1.6%     262.43 ± 28%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
     91.50 ±118%     -43.8%      51.43 ± 58%      +2.7%      94.00 ± 78%  interrupts.CPU30.RES:Rescheduling_interrupts
     54.83 ± 45%      -9.6%      49.57 ± 54%     +21.1%      66.43 ± 18%  interrupts.CPU30.TLB:TLB_shootdowns
      1560 ± 34%     -16.2%       1306 ±  5%      -3.5%       1505 ± 36%  interrupts.CPU31.CAL:Function_call_interrupts
    602439            -0.5%     599288            -7.2%     559074 ± 18%  interrupts.CPU31.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU31.MCP:Machine_check_polls
    266.83 ± 30%     +37.0%     365.43 ± 93%     -17.8%     219.29 ± 34%  interrupts.CPU31.NMI:Non-maskable_interrupts
    266.83 ± 30%     +37.0%     365.43 ± 93%     -17.8%     219.29 ± 34%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
     39.17 ±102%     -47.5%      20.57 ± 54%     -31.4%      26.86 ±105%  interrupts.CPU31.RES:Rescheduling_interrupts
     18.50 ± 37%      -8.1%      17.00 ± 46%     +17.4%      21.71 ± 14%  interrupts.CPU31.TLB:TLB_shootdowns
      2385 ± 41%     -27.5%       1730 ± 18%     -30.1%       1668 ± 15%  interrupts.CPU32.CAL:Function_call_interrupts
      0.00       +2.9e+101%       0.29 ±244%    -100.0%       0.00        interrupts.CPU32.IWI:IRQ_work_interrupts
    602327            -2.4%     588086 ±  5%      -7.2%     558772 ± 18%  interrupts.CPU32.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU32.MCP:Machine_check_polls
    263.17 ± 30%    +100.3%     527.00 ±123%      +1.2%     266.29 ± 48%  interrupts.CPU32.NMI:Non-maskable_interrupts
    263.17 ± 30%    +100.3%     527.00 ±123%      +1.2%     266.29 ± 48%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
    146.17 ± 73%     -60.0%      58.43 ± 28%     -60.7%      57.43 ± 43%  interrupts.CPU32.RES:Rescheduling_interrupts
     73.17 ±  9%     -25.6%      54.43 ± 23%     -23.7%      55.86 ± 39%  interrupts.CPU32.TLB:TLB_shootdowns
      2081 ± 49%     -35.1%       1351 ±  4%     -34.1%       1371 ±  7%  interrupts.CPU33.CAL:Function_call_interrupts
    602520            -2.7%     586156 ±  6%      -7.2%     558925 ± 18%  interrupts.CPU33.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU33.MCP:Machine_check_polls
    314.33 ± 27%     -14.0%     270.29 ± 31%     -38.2%     194.14 ± 40%  interrupts.CPU33.NMI:Non-maskable_interrupts
    314.33 ± 27%     -14.0%     270.29 ± 31%     -38.2%     194.14 ± 40%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
     92.33 ± 85%     -75.2%      22.86 ± 34%     -68.9%      28.71 ± 49%  interrupts.CPU33.RES:Rescheduling_interrupts
     21.33 ± 19%      +1.8%      21.71 ± 32%      +6.5%      22.71 ± 31%  interrupts.CPU33.TLB:TLB_shootdowns
      2664 ± 73%     -42.5%       1532 ±  9%     -39.5%       1612 ±  8%  interrupts.CPU34.CAL:Function_call_interrupts
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU34.IWI:IRQ_work_interrupts
    602049            -1.0%     596131 ±  2%      -7.1%     559029 ± 18%  interrupts.CPU34.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU34.MCP:Machine_check_polls
    405.50 ± 92%     -44.3%     226.00 ± 34%     -36.2%     258.57 ± 29%  interrupts.CPU34.NMI:Non-maskable_interrupts
    405.50 ± 92%     -44.3%     226.00 ± 34%     -36.2%     258.57 ± 29%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
     73.17 ± 44%     -27.2%      53.29 ± 41%     -11.9%      64.43 ± 37%  interrupts.CPU34.RES:Rescheduling_interrupts
     55.17 ± 47%     +17.6%      64.86 ± 16%     +12.4%      62.00 ± 23%  interrupts.CPU34.TLB:TLB_shootdowns
      1464 ± 15%      -5.2%       1387 ±  6%      -5.2%       1387 ± 10%  interrupts.CPU35.CAL:Function_call_interrupts
    602331            -1.1%     595719 ±  2%      -7.2%     558752 ± 18%  interrupts.CPU35.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU35.MCP:Machine_check_polls
    271.17 ± 29%     -28.5%     193.86 ± 30%     -16.0%     227.86 ± 32%  interrupts.CPU35.NMI:Non-maskable_interrupts
    271.17 ± 29%     -28.5%     193.86 ± 30%     -16.0%     227.86 ± 32%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
     32.33 ± 39%      +9.6%      35.43 ± 45%      +6.0%      34.29 ± 23%  interrupts.CPU35.RES:Rescheduling_interrupts
     21.67 ± 27%      +0.9%      21.86 ± 32%      +4.8%      22.71 ± 25%  interrupts.CPU35.TLB:TLB_shootdowns
      1686 ±  7%      -7.1%       1566 ±  9%     +11.4%       1879 ± 40%  interrupts.CPU36.CAL:Function_call_interrupts
    602170            -0.5%     599204            -7.1%     559354 ± 18%  interrupts.CPU36.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU36.MCP:Machine_check_polls
    252.67 ± 36%     +25.7%     317.57 ± 57%     -12.5%     221.14 ± 25%  interrupts.CPU36.NMI:Non-maskable_interrupts
    252.67 ± 36%     +25.7%     317.57 ± 57%     -12.5%     221.14 ± 25%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
     65.67 ± 21%      -1.2%      64.86 ± 36%     +48.4%      97.43 ± 77%  interrupts.CPU36.RES:Rescheduling_interrupts
     69.17 ±  9%     -12.0%      60.86 ± 17%     +26.0%      87.14 ± 41%  interrupts.CPU36.TLB:TLB_shootdowns
      1367 ±  5%      -0.5%       1359 ±  2%      -0.5%       1360 ± 14%  interrupts.CPU37.CAL:Function_call_interrupts
    602248            -1.0%     596229 ±  2%      -7.1%     559413 ± 18%  interrupts.CPU37.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU37.MCP:Machine_check_polls
    265.33 ± 35%      +2.8%     272.86 ± 30%     -15.6%     223.86 ± 40%  interrupts.CPU37.NMI:Non-maskable_interrupts
    265.33 ± 35%      +2.8%     272.86 ± 30%     -15.6%     223.86 ± 40%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
     29.50 ± 35%      -3.1%      28.57 ± 12%     +20.6%      35.57 ± 85%  interrupts.CPU37.RES:Rescheduling_interrupts
     20.17 ± 10%     +16.9%      23.57 ± 25%     +19.7%      24.14 ± 30%  interrupts.CPU37.TLB:TLB_shootdowns
      1539 ± 16%      +0.1%       1540 ±  4%     +16.6%       1795 ± 19%  interrupts.CPU38.CAL:Function_call_interrupts
    602376            -0.5%     599186            -7.2%     558791 ± 18%  interrupts.CPU38.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU38.MCP:Machine_check_polls
    364.67 ± 66%     -20.2%     290.86 ± 30%     -43.9%     204.43 ± 36%  interrupts.CPU38.NMI:Non-maskable_interrupts
    364.67 ± 66%     -20.2%     290.86 ± 30%     -43.9%     204.43 ± 36%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
     49.17 ± 64%     +12.7%      55.43 ± 34%     +88.6%      92.71 ± 49%  interrupts.CPU38.RES:Rescheduling_interrupts
     43.00 ± 64%     +40.2%      60.29 ± 23%     +69.1%      72.71 ± 12%  interrupts.CPU38.TLB:TLB_shootdowns
      1286 ±  4%      +5.3%       1354 ±  3%     +10.9%       1426 ± 17%  interrupts.CPU39.CAL:Function_call_interrupts
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU39.IWI:IRQ_work_interrupts
    602260            -0.5%     598995            -7.2%     559032 ± 18%  interrupts.CPU39.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU39.MCP:Machine_check_polls
    242.33 ± 62%      +6.9%     259.00 ± 35%      -7.5%     224.14 ± 39%  interrupts.CPU39.NMI:Non-maskable_interrupts
    242.33 ± 62%      +6.9%     259.00 ± 35%      -7.5%     224.14 ± 39%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
     14.33 ± 52%    +113.3%      30.57 ± 19%    +125.2%      32.29 ± 72%  interrupts.CPU39.RES:Rescheduling_interrupts
     19.67 ± 52%     +14.8%      22.57 ± 22%     +36.6%      26.86 ± 27%  interrupts.CPU39.TLB:TLB_shootdowns
      1616 ±  3%      -6.1%       1517 ± 19%     +14.7%       1854 ± 15%  interrupts.CPU4.CAL:Function_call_interrupts
    601721            +0.0%     601890            -7.1%     559277 ± 18%  interrupts.CPU4.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU4.MCP:Machine_check_polls
    218.67 ± 36%      +5.8%     231.43 ± 33%     +12.3%     245.57 ± 36%  interrupts.CPU4.NMI:Non-maskable_interrupts
    218.67 ± 36%      +5.8%     231.43 ± 33%     +12.3%     245.57 ± 36%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
     46.67 ± 10%     +21.5%      56.71 ± 30%     +44.8%      67.57 ± 26%  interrupts.CPU4.RES:Rescheduling_interrupts
     70.83 ±  8%     -15.5%      59.86 ± 24%     -17.3%      58.57 ± 22%  interrupts.CPU4.TLB:TLB_shootdowns
      1544 ± 12%      +1.7%       1571 ± 12%     +14.6%       1770 ± 10%  interrupts.CPU40.CAL:Function_call_interrupts
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU40.IWI:IRQ_work_interrupts
    602231            -2.3%     588662 ±  5%      -7.2%     558663 ± 18%  interrupts.CPU40.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU40.MCP:Machine_check_polls
      1286 ±175%     -83.0%     218.14 ± 12%     -80.3%     253.14 ± 41%  interrupts.CPU40.NMI:Non-maskable_interrupts
      1286 ±175%     -83.0%     218.14 ± 12%     -80.3%     253.14 ± 41%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
     54.17 ± 25%     +14.5%      62.00 ± 58%     +51.1%      81.86 ± 31%  interrupts.CPU40.RES:Rescheduling_interrupts
     53.33 ± 51%      -3.3%      51.57 ± 53%     +31.2%      70.00 ±  5%  interrupts.CPU40.TLB:TLB_shootdowns
      1342 ±  3%      +3.2%       1386 ±  8%      +3.2%       1385 ±  6%  interrupts.CPU41.CAL:Function_call_interrupts
    602454            -3.4%     581732 ±  8%      -7.2%     559152 ± 18%  interrupts.CPU41.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU41.MCP:Machine_check_polls
    309.83 ± 35%     -15.3%     262.57 ± 38%     -18.8%     251.57 ± 31%  interrupts.CPU41.NMI:Non-maskable_interrupts
    309.83 ± 35%     -15.3%     262.57 ± 38%     -18.8%     251.57 ± 31%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
     27.17 ± 44%     -14.3%      23.29 ± 61%     +23.0%      33.43 ± 40%  interrupts.CPU41.RES:Rescheduling_interrupts
     23.50 ± 41%     -18.5%      19.14 ± 43%      -1.5%      23.14 ± 24%  interrupts.CPU41.TLB:TLB_shootdowns
      1689 ± 14%     +12.7%       1904 ± 34%      -3.9%       1624 ±  4%  interrupts.CPU42.CAL:Function_call_interrupts
    601775            -1.2%     594579 ±  3%      -7.1%     559129 ± 18%  interrupts.CPU42.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU42.MCP:Machine_check_polls
    312.33 ± 28%      +2.9%     321.43 ± 25%     -16.6%     260.57 ± 39%  interrupts.CPU42.NMI:Non-maskable_interrupts
    312.33 ± 28%      +2.9%     321.43 ± 25%     -16.6%     260.57 ± 39%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
     50.00 ± 43%    +102.3%     101.14 ± 69%     +31.1%      65.57 ± 15%  interrupts.CPU42.RES:Rescheduling_interrupts
     55.83 ± 24%     +14.6%      64.00 ± 22%     +35.6%      75.71 ± 13%  interrupts.CPU42.TLB:TLB_shootdowns
      1399 ± 16%      +2.3%       1431 ± 18%      -9.5%       1266 ± 14%  interrupts.CPU43.CAL:Function_call_interrupts
    601999            -2.3%     588277 ±  5%      -7.1%     559125 ± 18%  interrupts.CPU43.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU43.MCP:Machine_check_polls
    244.17 ± 35%      +7.7%     262.86 ± 34%     -18.5%     199.00 ± 34%  interrupts.CPU43.NMI:Non-maskable_interrupts
    244.17 ± 35%      +7.7%     262.86 ± 34%     -18.5%     199.00 ± 34%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
     23.50 ± 20%     +92.7%      45.29 ± 68%     +20.4%      28.29 ± 29%  interrupts.CPU43.RES:Rescheduling_interrupts
     23.50 ± 21%     -14.9%      20.00 ± 12%      +5.8%      24.86 ± 15%  interrupts.CPU43.TLB:TLB_shootdowns
      1621 ±  3%     +24.4%       2016 ± 45%      -4.7%       1544 ±  9%  interrupts.CPU44.CAL:Function_call_interrupts
    601444            -2.1%     588696 ±  5%      -7.0%     559156 ± 18%  interrupts.CPU44.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU44.MCP:Machine_check_polls
    241.67 ± 32%      -0.2%     241.29 ± 30%      -7.7%     223.00 ± 35%  interrupts.CPU44.NMI:Non-maskable_interrupts
    241.67 ± 32%      -0.2%     241.29 ± 30%      -7.7%     223.00 ± 35%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
     59.50 ± 18%    +107.4%     123.43 ± 78%      -0.6%      59.14 ± 33%  interrupts.CPU44.RES:Rescheduling_interrupts
     72.33 ±  6%     -12.5%      63.29 ± 27%     -17.1%      60.00 ± 26%  interrupts.CPU44.TLB:TLB_shootdowns
      1453 ± 11%     +20.3%       1748 ± 30%      -9.3%       1319 ±  6%  interrupts.CPU45.CAL:Function_call_interrupts
    602015            -2.1%     589442 ±  5%      -7.1%     559221 ± 18%  interrupts.CPU45.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU45.MCP:Machine_check_polls
    230.17 ± 32%      +0.4%     231.14 ± 28%     +11.7%     257.14 ± 36%  interrupts.CPU45.NMI:Non-maskable_interrupts
    230.17 ± 32%      +0.4%     231.14 ± 28%     +11.7%     257.14 ± 36%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
     26.83 ± 30%    +130.5%      61.86 ± 61%     -20.7%      21.29 ± 43%  interrupts.CPU45.RES:Rescheduling_interrupts
     21.33 ± 20%      +7.1%      22.86 ± 24%     -10.3%      19.14 ± 43%  interrupts.CPU45.TLB:TLB_shootdowns
      1631 ±  5%      +4.8%       1710 ± 32%      -5.9%       1534 ±  8%  interrupts.CPU46.CAL:Function_call_interrupts
      0.00       +2.9e+101%       0.29 ±158%    -100.0%       0.00        interrupts.CPU46.IWI:IRQ_work_interrupts
    602383            -1.5%     593308 ±  3%      -7.2%     559190 ± 18%  interrupts.CPU46.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU46.MCP:Machine_check_polls
    238.00 ± 34%     +66.1%     395.29 ± 72%      -7.4%     220.43 ± 40%  interrupts.CPU46.NMI:Non-maskable_interrupts
    238.00 ± 34%     +66.1%     395.29 ± 72%      -7.4%     220.43 ± 40%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
     62.17 ± 17%      +1.1%      62.86 ± 59%     -18.2%      50.86 ± 35%  interrupts.CPU46.RES:Rescheduling_interrupts
     63.83 ± 19%     -14.3%      54.71 ± 47%     -15.0%      54.29 ± 31%  interrupts.CPU46.TLB:TLB_shootdowns
      1353 ±  7%      -1.3%       1336 ±  6%      -2.0%       1326 ±  2%  interrupts.CPU47.CAL:Function_call_interrupts
      0.50 ±223%     -71.4%       0.14 ±244%    -100.0%       0.00        interrupts.CPU47.IWI:IRQ_work_interrupts
    602381            -1.1%     595796 ±  2%      -7.2%     559155 ± 18%  interrupts.CPU47.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU47.MCP:Machine_check_polls
    236.00 ± 31%    +119.9%     518.86 ±101%     -10.2%     211.86 ± 41%  interrupts.CPU47.NMI:Non-maskable_interrupts
    236.00 ± 31%    +119.9%     518.86 ±101%     -10.2%     211.86 ± 41%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
     28.50 ± 34%      +1.8%      29.00 ± 57%     -21.8%      22.29 ± 46%  interrupts.CPU47.RES:Rescheduling_interrupts
     23.17 ± 36%      -2.6%      22.57 ± 42%     -11.8%      20.43 ± 33%  interrupts.CPU47.TLB:TLB_shootdowns
      1689 ± 17%      -0.7%       1678 ±  9%      +2.3%       1729 ±  9%  interrupts.CPU48.CAL:Function_call_interrupts
    602354            -2.3%     588220 ±  5%      -7.2%     559186 ± 18%  interrupts.CPU48.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU48.MCP:Machine_check_polls
    211.83 ±  5%     +11.3%     235.71 ± 22%     +35.8%     287.57 ± 41%  interrupts.CPU48.NMI:Non-maskable_interrupts
    211.83 ±  5%     +11.3%     235.71 ± 22%     +35.8%     287.57 ± 41%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
     55.83 ± 38%     +28.2%      71.57 ± 22%     +25.6%      70.14 ±  6%  interrupts.CPU48.RES:Rescheduling_interrupts
     57.33 ± 27%     +23.1%      70.57 ± 14%     +21.3%      69.57 ± 10%  interrupts.CPU48.TLB:TLB_shootdowns
      1365 ±  9%      +6.9%       1459 ±  8%      +2.7%       1402 ±  8%  interrupts.CPU49.CAL:Function_call_interrupts
    602392            -1.9%     591183 ±  4%      -7.1%     559381 ± 18%  interrupts.CPU49.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU49.MCP:Machine_check_polls
    236.67 ± 30%      +2.0%     241.29 ± 33%     -20.1%     189.00 ± 17%  interrupts.CPU49.NMI:Non-maskable_interrupts
    236.67 ± 30%      +2.0%     241.29 ± 33%     -20.1%     189.00 ± 17%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
     27.33 ± 52%     +61.0%      44.00 ± 33%     +12.9%      30.86 ± 51%  interrupts.CPU49.RES:Rescheduling_interrupts
     20.17 ± 23%    +235.1%      67.57 ±152%     +25.4%      25.29 ± 15%  interrupts.CPU49.TLB:TLB_shootdowns
      1536 ± 16%     -11.2%       1364 ±  5%      -7.5%       1422 ±  7%  interrupts.CPU5.CAL:Function_call_interrupts
    602515            -0.1%     601884            -7.2%     559264 ± 18%  interrupts.CPU5.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU5.MCP:Machine_check_polls
    217.33 ± 36%      -3.8%     209.14 ± 32%      +1.8%     221.14 ± 39%  interrupts.CPU5.NMI:Non-maskable_interrupts
    217.33 ± 36%      -3.8%     209.14 ± 32%      +1.8%     221.14 ± 39%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
     19.17 ± 32%     +78.1%      34.14 ± 53%     +34.2%      25.71 ± 41%  interrupts.CPU5.RES:Rescheduling_interrupts
     21.17 ± 26%      +3.3%      21.86 ± 20%      +1.2%      21.43 ± 24%  interrupts.CPU5.TLB:TLB_shootdowns
      1482 ± 11%     +37.1%       2032 ± 35%     +12.9%       1674 ±  7%  interrupts.CPU50.CAL:Function_call_interrupts
    602308            -3.0%     584474 ±  7%      -7.2%     559199 ± 18%  interrupts.CPU50.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU50.MCP:Machine_check_polls
    246.00 ± 31%     -15.6%     207.71 ±  6%     -21.1%     194.00 ± 19%  interrupts.CPU50.NMI:Non-maskable_interrupts
    246.00 ± 31%     -15.6%     207.71 ±  6%     -21.1%     194.00 ± 19%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
     40.33 ± 43%    +184.1%     114.57 ± 99%     +84.9%      74.57 ± 17%  interrupts.CPU50.RES:Rescheduling_interrupts
     47.67 ± 50%     +20.8%      57.57 ± 32%     +47.8%      70.43 ± 15%  interrupts.CPU50.TLB:TLB_shootdowns
      1343 ±  6%     +22.5%       1646 ± 39%      -0.6%       1335 ±  2%  interrupts.CPU51.CAL:Function_call_interrupts
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU51.IWI:IRQ_work_interrupts
    602450            -2.5%     587206 ±  6%      -7.1%     559443 ± 18%  interrupts.CPU51.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU51.MCP:Machine_check_polls
    819.33 ±127%     -67.4%     267.00 ± 36%     -69.5%     250.00 ± 41%  interrupts.CPU51.NMI:Non-maskable_interrupts
    819.33 ±127%     -67.4%     267.00 ± 36%     -69.5%     250.00 ± 41%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
     25.67 ± 69%    +133.8%      60.00 ±124%     +14.7%      29.43 ± 28%  interrupts.CPU51.RES:Rescheduling_interrupts
     17.00 ± 27%     +10.9%      18.86 ± 35%    +271.4%      63.14 ±160%  interrupts.CPU51.TLB:TLB_shootdowns
      1599 ±  7%     +11.9%       1790 ± 34%      +2.8%       1644 ±  9%  interrupts.CPU52.CAL:Function_call_interrupts
    602112            -3.7%     579783 ±  9%      -7.1%     559159 ± 18%  interrupts.CPU52.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU52.MCP:Machine_check_polls
    274.83 ± 36%     -22.8%     212.14 ±  9%      -8.4%     251.86 ± 42%  interrupts.CPU52.NMI:Non-maskable_interrupts
    274.83 ± 36%     -22.8%     212.14 ±  9%      -8.4%     251.86 ± 42%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
     55.83 ± 24%     +38.9%      77.57 ± 88%     +20.5%      67.29 ± 33%  interrupts.CPU52.RES:Rescheduling_interrupts
     66.83 ± 14%     -12.1%      58.71 ± 41%      +2.4%      68.43 ± 25%  interrupts.CPU52.TLB:TLB_shootdowns
      1332 ±  3%     +10.1%       1467 ± 22%      -0.4%       1327 ±  5%  interrupts.CPU53.CAL:Function_call_interrupts
      0.00       +4.3e+101%       0.43 ±244%    -100.0%       0.00        interrupts.CPU53.IWI:IRQ_work_interrupts
    602197            -3.0%     584372 ±  7%      -7.2%     559133 ± 18%  interrupts.CPU53.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU53.MCP:Machine_check_polls
    279.17 ± 40%     +62.3%     453.00 ±133%     -10.8%     249.14 ± 42%  interrupts.CPU53.NMI:Non-maskable_interrupts
    279.17 ± 40%     +62.3%     453.00 ±133%     -10.8%     249.14 ± 42%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
     22.50 ± 16%     +35.2%      30.43 ± 41%      +6.0%      23.86 ± 50%  interrupts.CPU53.RES:Rescheduling_interrupts
     22.33 ± 19%      -0.2%      22.29 ± 38%      +3.6%      23.14 ± 38%  interrupts.CPU53.TLB:TLB_shootdowns
      1571 ±  7%      -1.0%       1555 ±  8%      -5.0%       1492 ± 15%  interrupts.CPU54.CAL:Function_call_interrupts
    602229            -3.7%     580122 ±  9%      -7.1%     559274 ± 18%  interrupts.CPU54.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU54.MCP:Machine_check_polls
    244.50 ± 30%     +23.0%     300.86 ± 36%     -18.5%     199.29 ± 16%  interrupts.CPU54.NMI:Non-maskable_interrupts
    244.50 ± 30%     +23.0%     300.86 ± 36%     -18.5%     199.29 ± 16%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
     58.33 ± 40%      -0.1%      58.29 ± 35%      -0.1%      58.29 ± 44%  interrupts.CPU54.RES:Rescheduling_interrupts
     67.00 ± 24%     +14.3%      76.57 ± 25%      -8.1%      61.57 ± 41%  interrupts.CPU54.TLB:TLB_shootdowns
      1356 ±  3%      +7.4%       1457 ± 16%      +0.8%       1366 ±  9%  interrupts.CPU55.CAL:Function_call_interrupts
    602237            -3.7%     580216 ±  9%      -7.1%     559190 ± 18%  interrupts.CPU55.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU55.MCP:Machine_check_polls
    309.17 ± 32%     -22.8%     238.71 ± 33%      -6.0%     290.71 ± 84%  interrupts.CPU55.NMI:Non-maskable_interrupts
    309.17 ± 32%     -22.8%     238.71 ± 33%      -6.0%     290.71 ± 84%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
     28.33 ± 29%     +21.5%      34.43 ± 36%     -25.4%      21.14 ± 53%  interrupts.CPU55.RES:Rescheduling_interrupts
     20.50 ± 15%     +23.3%      25.29 ± 14%      -4.5%      19.57 ± 38%  interrupts.CPU55.TLB:TLB_shootdowns
      1510 ±  8%      +4.9%       1584 ±  6%     +31.4%       1984 ± 51%  interrupts.CPU56.CAL:Function_call_interrupts
    602347            -4.2%     577341 ± 10%      -7.1%     559313 ± 18%  interrupts.CPU56.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU56.MCP:Machine_check_polls
    282.33 ± 38%     -28.1%     203.00 ±  8%      -6.2%     264.86 ± 47%  interrupts.CPU56.NMI:Non-maskable_interrupts
    282.33 ± 38%     -28.1%     203.00 ±  8%      -6.2%     264.86 ± 47%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
     48.00 ± 34%     +16.7%      56.00 ± 26%    +128.6%     109.71 ±118%  interrupts.CPU56.RES:Rescheduling_interrupts
    112.33 ±105%     -43.0%      64.00 ± 10%     -43.9%      63.00 ± 12%  interrupts.CPU56.TLB:TLB_shootdowns
      1406 ±  2%      -4.6%       1342 ±  3%     +21.1%       1703 ± 45%  interrupts.CPU57.CAL:Function_call_interrupts
    602359            -2.4%     587601 ±  6%      -7.1%     559392 ± 18%  interrupts.CPU57.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU57.MCP:Machine_check_polls
    311.83 ± 34%     -26.3%     229.86 ± 30%      -5.2%     295.57 ± 46%  interrupts.CPU57.NMI:Non-maskable_interrupts
    311.83 ± 34%     -26.3%     229.86 ± 30%      -5.2%     295.57 ± 46%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
     24.50 ± 39%     +34.1%      32.86 ± 23%    +154.8%      62.43 ±124%  interrupts.CPU57.RES:Rescheduling_interrupts
     20.50 ± 30%      +8.0%      22.14 ± 22%     +22.0%      25.00 ± 22%  interrupts.CPU57.TLB:TLB_shootdowns
      1587 ±  5%     +27.2%       2018 ± 65%     +31.0%       2078 ± 40%  interrupts.CPU58.CAL:Function_call_interrupts
    602046            -2.1%     589322 ±  5%      -7.1%     559189 ± 18%  interrupts.CPU58.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU58.MCP:Machine_check_polls
    244.00 ± 32%     +12.0%     273.29 ± 35%     +27.6%     311.29 ± 37%  interrupts.CPU58.NMI:Non-maskable_interrupts
    244.00 ± 32%     +12.0%     273.29 ± 35%     +27.6%     311.29 ± 37%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
     54.33 ± 24%    +138.5%     129.57 ±138%    +126.9%     123.29 ±101%  interrupts.CPU58.RES:Rescheduling_interrupts
     67.17 ± 17%      -3.9%      64.57 ± 26%      +1.5%      68.14 ± 10%  interrupts.CPU58.TLB:TLB_shootdowns
      1357 ±  4%     +13.9%       1546 ± 33%      -1.2%       1342 ±  8%  interrupts.CPU59.CAL:Function_call_interrupts
    602317            -2.0%     590217 ±  4%      -7.2%     559085 ± 18%  interrupts.CPU59.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU59.MCP:Machine_check_polls
    207.83 ±  4%     +24.5%     258.71 ± 35%      +4.3%     216.71 ± 33%  interrupts.CPU59.NMI:Non-maskable_interrupts
    207.83 ±  4%     +24.5%     258.71 ± 35%      +4.3%     216.71 ± 33%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
     33.33 ± 11%     +76.1%      58.71 ± 80%      -1.4%      32.86 ± 51%  interrupts.CPU59.RES:Rescheduling_interrupts
     22.17 ± 36%      -5.3%      21.00 ± 20%     +14.1%      25.29 ± 15%  interrupts.CPU59.TLB:TLB_shootdowns
      1733 ± 16%     -11.4%       1535 ± 13%      -8.4%       1587 ± 11%  interrupts.CPU6.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU6.IWI:IRQ_work_interrupts
    602206            -0.2%     600955            -7.1%     559156 ± 18%  interrupts.CPU6.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU6.MCP:Machine_check_polls
    252.00 ± 33%     -27.6%     182.57 ± 26%      -0.3%     251.29 ± 73%  interrupts.CPU6.NMI:Non-maskable_interrupts
    252.00 ± 33%     -27.6%     182.57 ± 26%      -0.3%     251.29 ± 73%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
     59.67 ± 37%     -18.1%      48.86 ± 50%      +1.3%      60.43 ± 39%  interrupts.CPU6.RES:Rescheduling_interrupts
     62.17 ± 27%      -9.9%      56.00 ± 28%     -14.1%      53.43 ± 46%  interrupts.CPU6.TLB:TLB_shootdowns
      1635 ±  7%      -3.6%       1577 ±  7%     +20.2%       1965 ± 27%  interrupts.CPU60.CAL:Function_call_interrupts
    602170            -3.4%     581549 ±  8%      -7.2%     559063 ± 18%  interrupts.CPU60.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU60.MCP:Machine_check_polls
    272.33 ± 34%     -14.4%     233.14 ± 33%     -26.0%     201.43 ± 16%  interrupts.CPU60.NMI:Non-maskable_interrupts
    272.33 ± 34%     -14.4%     233.14 ± 33%     -26.0%     201.43 ± 16%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
     55.50 ± 16%     +16.1%      64.43 ± 34%     +90.2%     105.57 ± 47%  interrupts.CPU60.RES:Rescheduling_interrupts
     69.00 ±  9%      -7.2%      64.00 ±  7%      +2.5%      70.71 ± 10%  interrupts.CPU60.TLB:TLB_shootdowns
      1377 ±  7%      +2.7%       1413 ±  4%      +3.2%       1421 ±  8%  interrupts.CPU61.CAL:Function_call_interrupts
    602158            -3.3%     582400 ±  8%      -7.1%     559348 ± 18%  interrupts.CPU61.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU61.MCP:Machine_check_polls
    300.50 ± 33%     -22.4%     233.29 ± 31%     -11.2%     266.71 ± 34%  interrupts.CPU61.NMI:Non-maskable_interrupts
    300.50 ± 33%     -22.4%     233.29 ± 31%     -11.2%     266.71 ± 34%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
     22.33 ± 20%     +60.6%      35.86 ± 23%     +72.1%      38.43 ± 52%  interrupts.CPU61.RES:Rescheduling_interrupts
     20.67 ± 24%     +43.8%      29.71 ± 31%     +16.8%      24.14 ± 11%  interrupts.CPU61.TLB:TLB_shootdowns
      1354 ±  2%      -0.7%       1344 ±  5%      +4.6%       1416 ± 13%  interrupts.CPU62.CAL:Function_call_interrupts
    602197            -3.1%     583293 ±  8%      -7.2%     559046 ± 18%  interrupts.CPU62.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU62.MCP:Machine_check_polls
    282.83 ± 35%      -8.5%     258.71 ± 30%     -15.1%     240.14 ± 47%  interrupts.CPU62.NMI:Non-maskable_interrupts
    282.83 ± 35%      -8.5%     258.71 ± 30%     -15.1%     240.14 ± 47%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
     35.17 ± 26%      +1.6%      35.71 ± 49%     +47.1%      51.71 ± 74%  interrupts.CPU62.RES:Rescheduling_interrupts
     27.83 ± 25%     -11.2%      24.71 ± 19%     +14.5%      31.86 ± 12%  interrupts.CPU62.TLB:TLB_shootdowns
     11991            -1.3%      11832            +1.7%      12193 ±  7%  interrupts.CPU63.CAL:Function_call_interrupts
    602466            -3.0%     584676 ±  7%      -7.2%     559316 ± 18%  interrupts.CPU63.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU63.MCP:Machine_check_polls
    412.33 ± 41%      +5.6%     435.57 ± 92%     +38.1%     569.29 ± 79%  interrupts.CPU63.NMI:Non-maskable_interrupts
    412.33 ± 41%      +5.6%     435.57 ± 92%     +38.1%     569.29 ± 79%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
     44.83 ± 32%     -24.5%      33.86 ± 30%     +97.6%      88.57 ±114%  interrupts.CPU63.RES:Rescheduling_interrupts
     52.67 ± 44%     -28.4%      37.71 ± 20%      -8.0%      48.43 ± 54%  interrupts.CPU63.TLB:TLB_shootdowns
      1222            +0.4%       1227           +11.6%       1364 ± 26%  interrupts.CPU64.CAL:Function_call_interrupts
    602097            -2.0%     590154 ±  4%      -7.1%     559235 ± 18%  interrupts.CPU64.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU64.MCP:Machine_check_polls
    226.50 ± 28%      -4.8%     215.71 ± 32%     +16.2%     263.29 ± 40%  interrupts.CPU64.NMI:Non-maskable_interrupts
    226.50 ± 28%      -4.8%     215.71 ± 32%     +16.2%     263.29 ± 40%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
     15.00 ± 45%     -56.2%       6.57 ± 38%     -39.0%       9.14 ± 66%  interrupts.CPU64.RES:Rescheduling_interrupts
      7.33 ± 23%    +856.5%      70.14 ±219%     +26.6%       9.29 ± 41%  interrupts.CPU64.TLB:TLB_shootdowns
      1274 ±  7%      +1.5%       1293 ±  9%      -3.9%       1225        interrupts.CPU65.CAL:Function_call_interrupts
    601382            -1.5%     592417 ±  3%      -7.0%     559081 ± 18%  interrupts.CPU65.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU65.MCP:Machine_check_polls
    220.33 ± 25%     +14.6%     252.43 ± 35%      -2.7%     214.43 ± 39%  interrupts.CPU65.NMI:Non-maskable_interrupts
    220.33 ± 25%     +14.6%     252.43 ± 35%      -2.7%     214.43 ± 39%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
      7.83 ± 35%     +27.7%      10.00 ± 46%     -17.9%       6.43 ± 71%  interrupts.CPU65.RES:Rescheduling_interrupts
      8.33 ± 36%      -7.4%       7.71 ± 39%     -12.6%       7.29 ± 15%  interrupts.CPU65.TLB:TLB_shootdowns
      1266 ±  3%      +5.4%       1335 ±  6%      -1.6%       1246 ±  4%  interrupts.CPU66.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU66.IWI:IRQ_work_interrupts
    602349            -1.6%     592516 ±  4%      -7.2%     559183 ± 18%  interrupts.CPU66.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU66.MCP:Machine_check_polls
    262.50 ± 33%     +18.6%     311.29 ± 44%      +0.2%     263.00 ± 33%  interrupts.CPU66.NMI:Non-maskable_interrupts
    262.50 ± 33%     +18.6%     311.29 ± 44%      +0.2%     263.00 ± 33%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
     15.83 ± 40%      +5.6%      16.71 ± 58%      +1.1%      16.00 ± 35%  interrupts.CPU66.RES:Rescheduling_interrupts
     14.00 ± 20%      +5.1%      14.71 ± 26%     -20.4%      11.14 ± 37%  interrupts.CPU66.TLB:TLB_shootdowns
      1402 ± 25%     -11.6%       1239 ±  2%     -12.8%       1223        interrupts.CPU67.CAL:Function_call_interrupts
    602218            -2.9%     584575 ±  7%      -7.1%     559234 ± 18%  interrupts.CPU67.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU67.MCP:Machine_check_polls
    260.83 ± 36%      -3.3%     252.14 ± 35%      +1.6%     265.00 ± 41%  interrupts.CPU67.NMI:Non-maskable_interrupts
    260.83 ± 36%      -3.3%     252.14 ± 35%      +1.6%     265.00 ± 41%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
     13.83 ± 46%      +3.3%      14.29 ± 50%     +13.6%      15.71 ± 70%  interrupts.CPU67.RES:Rescheduling_interrupts
     12.33 ± 26%      -7.3%      11.43 ± 44%     -22.4%       9.57 ± 20%  interrupts.CPU67.TLB:TLB_shootdowns
      1294 ±  2%      +2.6%       1328 ±  8%      -1.3%       1278 ±  3%  interrupts.CPU68.CAL:Function_call_interrupts
    602213            -0.3%     600472            -7.1%     559262 ± 18%  interrupts.CPU68.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU68.MCP:Machine_check_polls
    261.33 ± 35%     -23.7%     199.29 ± 29%     -19.9%     209.43 ± 39%  interrupts.CPU68.NMI:Non-maskable_interrupts
    261.33 ± 35%     -23.7%     199.29 ± 29%     -19.9%     209.43 ± 39%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
     18.00 ± 28%      +8.7%      19.57 ± 59%     -24.6%      13.57 ± 46%  interrupts.CPU68.RES:Rescheduling_interrupts
     27.33 ± 82%     -50.3%      13.57 ± 23%     -42.0%      15.86 ± 16%  interrupts.CPU68.TLB:TLB_shootdowns
      1267 ±  4%      -3.0%       1228            -3.4%       1224        interrupts.CPU69.CAL:Function_call_interrupts
    602232            -0.3%     600377            -7.2%     559162 ± 18%  interrupts.CPU69.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU69.MCP:Machine_check_polls
    230.00 ± 36%      -4.2%     220.43 ± 34%      -8.1%     211.43 ± 40%  interrupts.CPU69.NMI:Non-maskable_interrupts
    230.00 ± 36%      -4.2%     220.43 ± 34%      -8.1%     211.43 ± 40%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
     16.67 ± 44%     -46.9%       8.86 ± 72%     -52.9%       7.86 ± 38%  interrupts.CPU69.RES:Rescheduling_interrupts
     11.33 ± 14%     -10.5%      10.14 ± 19%      -4.2%      10.86 ± 15%  interrupts.CPU69.TLB:TLB_shootdowns
      1473 ± 15%      -5.8%       1388 ±  8%      -4.7%       1404 ± 11%  interrupts.CPU7.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU7.IWI:IRQ_work_interrupts
    602413            -0.1%     601638            -7.1%     559372 ± 18%  interrupts.CPU7.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU7.MCP:Machine_check_polls
    185.67 ± 32%     +37.3%     255.00 ± 31%     +24.6%     231.29 ± 47%  interrupts.CPU7.NMI:Non-maskable_interrupts
    185.67 ± 32%     +37.3%     255.00 ± 31%     +24.6%     231.29 ± 47%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
     40.83 ± 53%     -19.2%      33.00 ± 59%     -52.4%      19.43 ± 22%  interrupts.CPU7.RES:Rescheduling_interrupts
     31.67 ± 57%     -17.9%      26.00 ± 68%     -43.2%      18.00 ± 39%  interrupts.CPU7.TLB:TLB_shootdowns
      1256 ±  3%      +5.4%       1325 ±  6%      -0.3%       1252 ±  3%  interrupts.CPU70.CAL:Function_call_interrupts
    602307            -1.9%     590625 ±  4%      -7.2%     558704 ± 18%  interrupts.CPU70.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU70.MCP:Machine_check_polls
    234.33 ± 30%      -4.6%     223.57 ± 29%      +2.8%     241.00 ± 60%  interrupts.CPU70.NMI:Non-maskable_interrupts
    234.33 ± 30%      -4.6%     223.57 ± 29%      +2.8%     241.00 ± 60%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
     14.17 ± 48%     +55.3%      22.00 ± 45%     +22.0%      17.29 ± 53%  interrupts.CPU70.RES:Rescheduling_interrupts
     13.50 ± 34%      +3.7%      14.00 ± 27%      -4.8%      12.86 ± 39%  interrupts.CPU70.TLB:TLB_shootdowns
      1242 ±  2%      +0.1%       1243            +0.1%       1244 ±  2%  interrupts.CPU71.CAL:Function_call_interrupts
    602322            -2.1%     589603 ±  5%      -7.2%     559174 ± 18%  interrupts.CPU71.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU71.MCP:Machine_check_polls
    301.00 ± 36%     -23.8%     229.29 ± 28%     -22.6%     232.86 ± 35%  interrupts.CPU71.NMI:Non-maskable_interrupts
    301.00 ± 36%     -23.8%     229.29 ± 28%     -22.6%     232.86 ± 35%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
     15.00 ± 17%     -39.0%       9.14 ± 46%     -23.8%      11.43 ± 45%  interrupts.CPU71.RES:Rescheduling_interrupts
     11.00 ± 27%      -7.8%      10.14 ± 22%     +11.7%      12.29 ± 41%  interrupts.CPU71.TLB:TLB_shootdowns
      1247 ±  2%     +11.0%       1384 ± 14%      +0.6%       1254        interrupts.CPU72.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU72.IWI:IRQ_work_interrupts
    602179            -3.2%     583061 ±  8%      -7.1%     559389 ± 18%  interrupts.CPU72.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU72.MCP:Machine_check_polls
    310.00 ± 33%     -23.1%     238.29 ± 33%     +43.3%     444.29 ±112%  interrupts.CPU72.NMI:Non-maskable_interrupts
    310.00 ± 33%     -23.1%     238.29 ± 33%     +43.3%     444.29 ±112%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
     13.50 ± 22%    +162.4%      35.43 ±104%     -11.1%      12.00 ± 43%  interrupts.CPU72.RES:Rescheduling_interrupts
     13.00 ± 34%     +36.3%      17.71 ± 29%      +3.3%      13.43 ± 43%  interrupts.CPU72.TLB:TLB_shootdowns
      1201 ±  2%      +6.6%       1280 ±  7%      +9.2%       1311 ± 13%  interrupts.CPU73.CAL:Function_call_interrupts
    602472            -4.0%     578296 ± 10%      -7.3%     558741 ± 18%  interrupts.CPU73.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU73.MCP:Machine_check_polls
    287.17 ± 36%      -4.3%     274.86 ± 39%     +11.8%     321.14 ± 37%  interrupts.CPU73.NMI:Non-maskable_interrupts
    287.17 ± 36%      -4.3%     274.86 ± 39%     +11.8%     321.14 ± 37%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
      7.00 ± 40%    +185.7%      20.00 ± 57%     +95.9%      13.71 ± 59%  interrupts.CPU73.RES:Rescheduling_interrupts
     11.83 ± 72%      -3.4%      11.43 ± 19%     -13.1%      10.29 ± 37%  interrupts.CPU73.TLB:TLB_shootdowns
      1324 ±  5%      +9.7%       1453 ± 14%      +1.4%       1342 ±  6%  interrupts.CPU74.CAL:Function_call_interrupts
    602204            -3.6%     580299 ±  9%      -7.2%     559071 ± 18%  interrupts.CPU74.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU74.MCP:Machine_check_polls
    243.67 ± 31%      -4.2%     233.43 ± 31%     +27.8%     311.43 ± 36%  interrupts.CPU74.NMI:Non-maskable_interrupts
    243.67 ± 31%      -4.2%     233.43 ± 31%     +27.8%     311.43 ± 36%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
     23.67 ± 55%     +17.7%      27.86 ± 39%     +20.1%      28.43 ± 56%  interrupts.CPU74.RES:Rescheduling_interrupts
     25.83 ± 29%     -11.0%      23.00 ± 28%     -20.9%      20.43 ± 34%  interrupts.CPU74.TLB:TLB_shootdowns
      1246            +1.8%       1268 ±  3%      +1.8%       1269 ±  2%  interrupts.CPU75.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU75.IWI:IRQ_work_interrupts
    602217            -4.3%     576263 ± 11%      -7.2%     558787 ± 18%  interrupts.CPU75.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU75.MCP:Machine_check_polls
    280.67 ± 33%      +4.4%     293.00 ± 31%    +120.6%     619.14 ±120%  interrupts.CPU75.NMI:Non-maskable_interrupts
    280.67 ± 33%      +4.4%     293.00 ± 31%    +120.6%     619.14 ±120%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
     14.67 ± 49%     +45.1%      21.29 ± 36%     +15.9%      17.00 ± 38%  interrupts.CPU75.RES:Rescheduling_interrupts
     13.33 ± 28%      +0.7%      13.43 ± 22%      +5.0%      14.00 ± 45%  interrupts.CPU75.TLB:TLB_shootdowns
      1282 ±  3%      -0.4%       1277 ±  4%      +3.5%       1326 ±  9%  interrupts.CPU76.CAL:Function_call_interrupts
    602290            -5.2%     570942 ± 13%      -7.2%     559186 ± 18%  interrupts.CPU76.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU76.MCP:Machine_check_polls
    314.50 ± 34%     -34.1%     207.14 ±  7%     -22.1%     245.14 ± 31%  interrupts.CPU76.NMI:Non-maskable_interrupts
    314.50 ± 34%     -34.1%     207.14 ±  7%     -22.1%     245.14 ± 31%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
     16.50 ± 51%      +1.3%      16.71 ± 43%     +35.9%      22.43 ± 91%  interrupts.CPU76.RES:Rescheduling_interrupts
     13.33 ± 24%     +28.6%      17.14 ± 30%     +27.5%      17.00 ± 62%  interrupts.CPU76.TLB:TLB_shootdowns
      1250 ±  3%      -1.3%       1234 ±  4%      +0.0%       1250 ±  3%  interrupts.CPU77.CAL:Function_call_interrupts
    602138            -5.2%     571128 ± 13%      -7.2%     559068 ± 18%  interrupts.CPU77.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU77.MCP:Machine_check_polls
    283.67 ± 37%     -15.4%     239.86 ± 30%      -4.3%     271.43 ± 35%  interrupts.CPU77.NMI:Non-maskable_interrupts
    283.67 ± 37%     -15.4%     239.86 ± 30%      -4.3%     271.43 ± 35%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
     11.83 ± 46%     -30.0%       8.29 ± 55%      +9.9%      13.00 ± 56%  interrupts.CPU77.RES:Rescheduling_interrupts
     13.00 ± 35%      -2.2%      12.71 ± 28%     -15.4%      11.00 ± 35%  interrupts.CPU77.TLB:TLB_shootdowns
      1336 ± 14%      +1.1%       1351 ± 11%      -1.8%       1312 ± 13%  interrupts.CPU78.CAL:Function_call_interrupts
    602118            -3.1%     583719 ±  7%      -7.1%     559147 ± 18%  interrupts.CPU78.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU78.MCP:Machine_check_polls
    315.67 ± 32%     -13.3%     273.57 ± 38%      -8.9%     287.57 ± 41%  interrupts.CPU78.NMI:Non-maskable_interrupts
    315.67 ± 32%     -13.3%     273.57 ± 38%      -8.9%     287.57 ± 41%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
     29.00 ± 87%     -23.2%      22.29 ± 99%     -19.7%      23.29 ±140%  interrupts.CPU78.RES:Rescheduling_interrupts
     15.50 ± 17%      -6.9%      14.43 ± 25%     -17.1%      12.86 ± 17%  interrupts.CPU78.TLB:TLB_shootdowns
      1289 ±  4%      -2.1%       1262 ±  7%     +10.2%       1421 ± 25%  interrupts.CPU79.CAL:Function_call_interrupts
    602079            -3.1%     583124 ±  8%      -7.1%     559223 ± 18%  interrupts.CPU79.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU79.MCP:Machine_check_polls
    327.33 ± 32%     -15.2%     277.43 ± 36%      -5.0%     311.00 ± 34%  interrupts.CPU79.NMI:Non-maskable_interrupts
    327.33 ± 32%     -15.2%     277.43 ± 36%      -5.0%     311.00 ± 34%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
     18.50 ± 38%     -30.5%      12.86 ±123%     -22.0%      14.43 ± 67%  interrupts.CPU79.RES:Rescheduling_interrupts
     13.33 ± 34%     -10.0%      12.00 ± 23%     -25.0%      10.00 ± 23%  interrupts.CPU79.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.18:IR-IO-APIC.18-fasteoi.ehci_hcd:usb1,ehci_hcd:usb2,i801_smbus
      1692 ± 17%     +21.5%       2055 ± 39%     +12.1%       1896 ± 28%  interrupts.CPU8.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU8.IWI:IRQ_work_interrupts
    602202            -1.0%     596078 ±  2%      -7.1%     559161 ± 18%  interrupts.CPU8.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU8.MCP:Machine_check_polls
    212.00 ± 34%     +29.2%     274.00 ± 31%     +60.6%     340.57 ± 31%  interrupts.CPU8.NMI:Non-maskable_interrupts
    212.00 ± 34%     +29.2%     274.00 ± 31%     +60.6%     340.57 ± 31%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
     40.00 ± 32%    +123.2%      89.29 ± 84%     +49.6%      59.86 ± 51%  interrupts.CPU8.RES:Rescheduling_interrupts
     67.83 ± 22%      -4.8%      64.57 ± 24%     -14.7%      57.86 ± 43%  interrupts.CPU8.TLB:TLB_shootdowns
      1208 ± 14%      +5.6%       1276 ±  4%      +6.2%       1283 ±  5%  interrupts.CPU80.CAL:Function_call_interrupts
    602122            -3.0%     583931 ±  7%      -7.1%     559166 ± 18%  interrupts.CPU80.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU80.MCP:Machine_check_polls
    282.17 ± 34%     +15.3%     325.43 ± 29%     +35.9%     383.43 ± 48%  interrupts.CPU80.NMI:Non-maskable_interrupts
    282.17 ± 34%     +15.3%     325.43 ± 29%     +35.9%     383.43 ± 48%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
     19.33 ± 38%     -20.9%      15.29 ± 58%     -32.0%      13.14 ± 80%  interrupts.CPU80.RES:Rescheduling_interrupts
     12.17 ± 32%     +25.6%      15.29 ± 18%     +75.0%      21.29 ±103%  interrupts.CPU80.TLB:TLB_shootdowns
      1278 ±  9%      +2.0%       1304 ±  8%      -3.5%       1233 ±  2%  interrupts.CPU81.CAL:Function_call_interrupts
    602228            -3.3%     582313 ±  8%      -7.2%     558962 ± 18%  interrupts.CPU81.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU81.MCP:Machine_check_polls
    310.50 ± 32%      -3.1%     301.00 ± 38%     -11.2%     275.57 ± 36%  interrupts.CPU81.NMI:Non-maskable_interrupts
    310.50 ± 32%      -3.1%     301.00 ± 38%     -11.2%     275.57 ± 36%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
     11.83 ± 93%     -15.5%      10.00 ± 24%     -22.7%       9.14 ± 46%  interrupts.CPU81.RES:Rescheduling_interrupts
      7.83 ± 20%     +55.0%      12.14 ± 22%     +29.5%      10.14 ± 47%  interrupts.CPU81.TLB:TLB_shootdowns
      1380 ±  9%      -6.1%       1296 ±  5%      -8.2%       1266 ±  3%  interrupts.CPU82.CAL:Function_call_interrupts
    602316            -0.6%     598413            -7.2%     559019 ± 18%  interrupts.CPU82.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU82.MCP:Machine_check_polls
    317.00 ± 33%     -23.3%     243.00 ± 35%     -22.4%     246.00 ± 31%  interrupts.CPU82.NMI:Non-maskable_interrupts
    317.00 ± 33%     -23.3%     243.00 ± 35%     -22.4%     246.00 ± 31%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
     19.83 ± 50%     -12.1%      17.43 ± 55%     -16.4%      16.57 ± 59%  interrupts.CPU82.RES:Rescheduling_interrupts
     17.83 ± 41%      -6.3%      16.71 ± 36%      -3.9%      17.14 ± 32%  interrupts.CPU82.TLB:TLB_shootdowns
      1276 ±  8%     +11.1%       1417 ± 12%      +3.7%       1323 ±  8%  interrupts.CPU83.CAL:Function_call_interrupts
      0.00       +2.9e+101%       0.29 ±244% +1.4e+101%       0.14 ±244%  interrupts.CPU83.IWI:IRQ_work_interrupts
    602154            -2.9%     584916 ±  7%      -7.2%     558922 ± 18%  interrupts.CPU83.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU83.MCP:Machine_check_polls
    241.83 ± 30%     +13.6%     274.71 ± 39%     +97.6%     477.86 ± 85%  interrupts.CPU83.NMI:Non-maskable_interrupts
    241.83 ± 30%     +13.6%     274.71 ± 39%     +97.6%     477.86 ± 85%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
     15.67 ± 71%     +83.3%      28.71 ± 89%     -23.4%      12.00 ± 37%  interrupts.CPU83.RES:Rescheduling_interrupts
     13.33 ± 67%     -25.0%      10.00 ± 28%     -19.6%      10.71 ± 25%  interrupts.CPU83.TLB:TLB_shootdowns
      1274 ±  2%      +5.1%       1339 ±  5%      -0.1%       1272 ±  4%  interrupts.CPU84.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +4.3e+101%       0.43 ±244%  interrupts.CPU84.IWI:IRQ_work_interrupts
    601433            -3.9%     578151 ± 10%      -7.0%     559153 ± 18%  interrupts.CPU84.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU84.MCP:Machine_check_polls
    280.67 ± 33%      -1.4%     276.71 ± 30%     +23.9%     347.86 ± 27%  interrupts.CPU84.NMI:Non-maskable_interrupts
    280.67 ± 33%      -1.4%     276.71 ± 30%     +23.9%     347.86 ± 27%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
     15.67 ± 37%     +79.6%      28.14 ± 49%     -19.8%      12.57 ± 41%  interrupts.CPU84.RES:Rescheduling_interrupts
     14.83 ± 31%      +4.0%      15.43 ± 36%      -2.7%      14.43 ± 31%  interrupts.CPU84.TLB:TLB_shootdowns
      1288 ±  6%     +13.0%       1456 ± 34%      -0.1%       1287 ± 11%  interrupts.CPU85.CAL:Function_call_interrupts
    602121            -3.8%     579004 ±  9%      -7.1%     559283 ± 18%  interrupts.CPU85.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU85.MCP:Machine_check_polls
    270.83 ± 34%     +31.2%     355.29 ± 27%      +7.4%     291.00 ± 37%  interrupts.CPU85.NMI:Non-maskable_interrupts
    270.83 ± 34%     +31.2%     355.29 ± 27%      +7.4%     291.00 ± 37%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
     18.00 ± 68%     +47.6%      26.57 ±147%     -46.0%       9.71 ± 57%  interrupts.CPU85.RES:Rescheduling_interrupts
     16.50 ±105%     -33.3%      11.00 ± 20%     -38.5%      10.14 ± 25%  interrupts.CPU85.TLB:TLB_shootdowns
      1212 ± 17%      +4.8%       1270 ±  3%     +14.1%       1383 ± 18%  interrupts.CPU86.CAL:Function_call_interrupts
      0.33 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU86.IWI:IRQ_work_interrupts
    602087            -0.9%     596837 ±  2%      -7.1%     559305 ± 18%  interrupts.CPU86.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU86.MCP:Machine_check_polls
    310.33 ± 30%      -9.5%     280.86 ± 30%     -14.6%     265.14 ± 30%  interrupts.CPU86.NMI:Non-maskable_interrupts
    310.33 ± 30%      -9.5%     280.86 ± 30%     -14.6%     265.14 ± 30%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
     18.00 ± 64%     -15.9%      15.14 ± 49%     +92.1%      34.57 ±120%  interrupts.CPU86.RES:Rescheduling_interrupts
     16.83 ± 34%     -12.6%      14.71 ± 26%      +1.0%      17.00 ± 22%  interrupts.CPU86.TLB:TLB_shootdowns
      1242 ±  2%      +5.3%       1308 ± 14%      +5.8%       1314 ± 10%  interrupts.CPU87.CAL:Function_call_interrupts
    601988            -0.8%     597009 ±  2%      -7.1%     559032 ± 18%  interrupts.CPU87.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU87.MCP:Machine_check_polls
    273.83 ± 26%     -27.0%     199.86 ± 30%     -18.9%     222.00 ± 33%  interrupts.CPU87.NMI:Non-maskable_interrupts
    273.83 ± 26%     -27.0%     199.86 ± 30%     -18.9%     222.00 ± 33%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
     10.17 ± 38%     +53.2%      15.57 ±149%     +95.3%      19.86 ± 77%  interrupts.CPU87.RES:Rescheduling_interrupts
     10.67 ± 21%     +54.0%      16.43 ± 84%     +21.9%      13.00 ± 41%  interrupts.CPU87.TLB:TLB_shootdowns
      1379 ± 11%      -3.6%       1329 ±  9%      -2.7%       1341 ±  9%  interrupts.CPU88.CAL:Function_call_interrupts
    602188            -1.1%     595263 ±  2%      -7.1%     559138 ± 18%  interrupts.CPU88.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU88.MCP:Machine_check_polls
    287.50 ± 31%     -16.4%     240.43 ± 30%      +5.2%     302.43 ± 33%  interrupts.CPU88.NMI:Non-maskable_interrupts
    287.50 ± 31%     -16.4%     240.43 ± 30%      +5.2%     302.43 ± 33%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
     30.17 ± 99%     -41.3%      17.71 ± 38%     -34.2%      19.86 ± 37%  interrupts.CPU88.RES:Rescheduling_interrupts
     12.50 ± 31%     +54.3%      19.29 ± 32%     +31.4%      16.43 ± 19%  interrupts.CPU88.TLB:TLB_shootdowns
      1309 ± 10%      -7.1%       1217            -5.6%       1235 ±  3%  interrupts.CPU89.CAL:Function_call_interrupts
    602215            -2.3%     588477 ±  5%      -7.1%     559257 ± 18%  interrupts.CPU89.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU89.MCP:Machine_check_polls
    266.67 ± 35%      -5.9%     251.00 ± 31%      -2.7%     259.43 ± 33%  interrupts.CPU89.NMI:Non-maskable_interrupts
    266.67 ± 35%      -5.9%     251.00 ± 31%      -2.7%     259.43 ± 33%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
     14.50 ± 27%     -22.2%      11.29 ± 47%     -36.9%       9.14 ± 47%  interrupts.CPU89.RES:Rescheduling_interrupts
      9.00 ± 16%     +14.3%      10.29 ± 23%      +9.5%       9.86 ± 27%  interrupts.CPU89.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU9.41:IR-PCI-MSI.327680-edge.xhci_hcd
      1389 ±  4%     +18.0%       1639 ± 33%      -4.5%       1326 ±  4%  interrupts.CPU9.CAL:Function_call_interrupts
    602250            -1.0%     596073 ±  2%      -7.1%     559252 ± 18%  interrupts.CPU9.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU9.MCP:Machine_check_polls
    235.67 ± 35%      -5.4%     223.00 ± 33%     +15.8%     272.86 ± 36%  interrupts.CPU9.NMI:Non-maskable_interrupts
    235.67 ± 35%      -5.4%     223.00 ± 33%     +15.8%     272.86 ± 36%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
     27.67 ± 38%     +69.4%      46.86 ±137%     -27.2%      20.14 ± 59%  interrupts.CPU9.RES:Rescheduling_interrupts
     23.67 ± 28%     -17.9%      19.43 ± 31%     -27.6%      17.14 ± 44%  interrupts.CPU9.TLB:TLB_shootdowns
      1328 ±  7%      -5.2%       1260            -4.5%       1268 ±  3%  interrupts.CPU90.CAL:Function_call_interrupts
      0.00       +7.1e+101%       0.71 ±244%    -100.0%       0.00        interrupts.CPU90.IWI:IRQ_work_interrupts
    602308            -3.1%     583689 ±  7%      -7.2%     559102 ± 18%  interrupts.CPU90.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU90.MCP:Machine_check_polls
    320.83 ± 32%     +19.0%     381.71 ± 29%      -6.8%     298.86 ± 41%  interrupts.CPU90.NMI:Non-maskable_interrupts
    320.83 ± 32%     +19.0%     381.71 ± 29%      -6.8%     298.86 ± 41%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
     24.83 ± 54%     -35.0%      16.14 ± 38%     -30.4%      17.29 ± 55%  interrupts.CPU90.RES:Rescheduling_interrupts
     17.33 ± 29%      -7.7%      16.00 ± 26%     +13.7%      19.71 ± 41%  interrupts.CPU90.TLB:TLB_shootdowns
      1229            +2.7%       1262 ±  5%      +0.1%       1231        interrupts.CPU91.CAL:Function_call_interrupts
      0.00       +1.4e+101%       0.14 ±244%    -100.0%       0.00        interrupts.CPU91.IWI:IRQ_work_interrupts
    602232            -2.5%     587118 ±  6%      -7.2%     559058 ± 18%  interrupts.CPU91.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU91.MCP:Machine_check_polls
    285.67 ± 37%    +254.6%       1013 ±176%      +5.9%     302.57 ± 33%  interrupts.CPU91.NMI:Non-maskable_interrupts
    285.67 ± 37%    +254.6%       1013 ±176%      +5.9%     302.57 ± 33%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
     11.67 ± 44%     -10.6%      10.43 ± 31%      +9.0%      12.71 ± 61%  interrupts.CPU91.RES:Rescheduling_interrupts
     10.50 ± 18%     -10.2%       9.43 ± 19%     +10.2%      11.57 ± 16%  interrupts.CPU91.TLB:TLB_shootdowns
      1291 ±  8%      +0.3%       1295 ±  6%      -1.9%       1267 ±  3%  interrupts.CPU92.CAL:Function_call_interrupts
    602168            -0.4%     599542            -7.1%     559288 ± 18%  interrupts.CPU92.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU92.MCP:Machine_check_polls
    206.67 ± 29%     +31.2%     271.14 ± 37%     +12.9%     233.43 ± 33%  interrupts.CPU92.NMI:Non-maskable_interrupts
    206.67 ± 29%     +31.2%     271.14 ± 37%     +12.9%     233.43 ± 33%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
     12.00 ± 41%     +46.4%      17.57 ± 62%     +23.8%      14.86 ± 36%  interrupts.CPU92.RES:Rescheduling_interrupts
     14.67 ± 17%     +14.9%      16.86 ± 38%     +30.5%      19.14 ± 46%  interrupts.CPU92.TLB:TLB_shootdowns
      1267 ±  7%      -2.9%       1230 ±  3%      -0.4%       1262 ±  4%  interrupts.CPU93.CAL:Function_call_interrupts
    602111            -0.5%     599385            -7.1%     559164 ± 18%  interrupts.CPU93.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU93.MCP:Machine_check_polls
    227.00 ± 35%      -8.3%     208.14 ± 39%      -0.4%     226.14 ± 32%  interrupts.CPU93.NMI:Non-maskable_interrupts
    227.00 ± 35%      -8.3%     208.14 ± 39%      -0.4%     226.14 ± 32%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
     19.00 ± 70%     -42.1%      11.00 ± 41%     -33.1%      12.71 ± 41%  interrupts.CPU93.RES:Rescheduling_interrupts
     11.67 ± 17%     -19.2%       9.43 ± 27%      +0.4%      11.71 ± 43%  interrupts.CPU93.TLB:TLB_shootdowns
      1281 ±  8%      -0.5%       1274 ±  2%      +2.1%       1307 ±  5%  interrupts.CPU94.CAL:Function_call_interrupts
      0.00          -100.0%       0.00       +7.1e+101%       0.71 ±244%  interrupts.CPU94.IWI:IRQ_work_interrupts
    602120            -3.1%     583511 ±  7%      -7.2%     558901 ± 18%  interrupts.CPU94.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU94.MCP:Machine_check_polls
    282.33 ± 32%      -4.1%     270.86 ± 28%     +14.8%     324.00 ± 38%  interrupts.CPU94.NMI:Non-maskable_interrupts
    282.33 ± 32%      -4.1%     270.86 ± 28%     +14.8%     324.00 ± 38%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
     21.00 ±112%     -36.7%      13.29 ± 66%     -19.0%      17.00 ± 49%  interrupts.CPU94.RES:Rescheduling_interrupts
     11.17 ± 37%     +35.6%      15.14 ± 30%     +49.7%      16.71 ± 30%  interrupts.CPU94.TLB:TLB_shootdowns
      1335 ± 11%      -4.4%       1276 ±  5%     +10.2%       1472 ± 39%  interrupts.CPU95.CAL:Function_call_interrupts
      0.00       +2.9e+101%       0.29 ±244%    -100.0%       0.00        interrupts.CPU95.IWI:IRQ_work_interrupts
    602146            -3.1%     583301 ±  7%      -7.2%     559061 ± 18%  interrupts.CPU95.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU95.MCP:Machine_check_polls
    305.67 ± 32%     +31.2%     401.00 ±101%      -2.1%     299.14 ± 33%  interrupts.CPU95.NMI:Non-maskable_interrupts
    305.67 ± 32%     +31.2%     401.00 ±101%      -2.1%     299.14 ± 33%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
     27.17 ± 85%     -61.6%      10.43 ± 74%     -60.6%      10.71 ± 45%  interrupts.CPU95.RES:Rescheduling_interrupts
     10.33 ± 44%     -11.5%       9.14 ± 26%     +18.9%      12.29 ± 30%  interrupts.CPU95.TLB:TLB_shootdowns
      1615 ± 36%     -21.0%       1276 ±  8%     -17.2%       1337 ±  7%  interrupts.CPU96.CAL:Function_call_interrupts
    602309            -5.1%     571319 ± 13%      -7.2%     559101 ± 18%  interrupts.CPU96.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU96.MCP:Machine_check_polls
    315.67 ± 36%      +2.7%     324.29 ± 28%      -5.7%     297.57 ± 32%  interrupts.CPU96.NMI:Non-maskable_interrupts
    315.67 ± 36%      +2.7%     324.29 ± 28%      -5.7%     297.57 ± 32%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
     60.17 ±102%     -86.0%       8.43 ± 33%     -69.4%      18.43 ± 29%  interrupts.CPU96.RES:Rescheduling_interrupts
     15.67 ± 28%      -2.4%      15.29 ± 14%     +14.9%      18.00 ± 30%  interrupts.CPU96.TLB:TLB_shootdowns
      1565 ± 31%     -19.6%       1258 ±  4%     -18.1%       1281 ± 10%  interrupts.CPU97.CAL:Function_call_interrupts
      0.00       +7.1e+101%       0.71 ±244%    -100.0%       0.00        interrupts.CPU97.IWI:IRQ_work_interrupts
    602145            -5.3%     570278 ± 13%      -7.1%     559161 ± 18%  interrupts.CPU97.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU97.MCP:Machine_check_polls
    279.50 ± 31%     +11.2%     310.71 ± 33%      -0.9%     277.00 ± 33%  interrupts.CPU97.NMI:Non-maskable_interrupts
    279.50 ± 31%     +11.2%     310.71 ± 33%      -0.9%     277.00 ± 33%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
     48.00 ±116%     -80.4%       9.43 ± 60%     -78.9%      10.14 ± 45%  interrupts.CPU97.RES:Rescheduling_interrupts
     10.17 ± 23%      +2.6%      10.43 ± 27%      +9.6%      11.14 ± 36%  interrupts.CPU97.TLB:TLB_shootdowns
      1283 ±  2%      -0.8%       1272 ±  3%      +2.7%       1318 ±  7%  interrupts.CPU98.CAL:Function_call_interrupts
      0.17 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU98.IWI:IRQ_work_interrupts
    602235            -3.3%     582199 ±  8%      -7.1%     559237 ± 18%  interrupts.CPU98.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU98.MCP:Machine_check_polls
    608.83 ±118%     -51.7%     294.29 ± 36%     -50.6%     301.00 ± 35%  interrupts.CPU98.NMI:Non-maskable_interrupts
    608.83 ±118%     -51.7%     294.29 ± 36%     -50.6%     301.00 ± 35%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
     15.67 ± 28%      +7.6%      16.86 ± 38%      +7.6%      16.86 ± 36%  interrupts.CPU98.RES:Rescheduling_interrupts
     12.17 ± 34%     +19.8%      14.57 ± 17%     +23.3%      15.00 ± 11%  interrupts.CPU98.TLB:TLB_shootdowns
      1373 ± 23%      -3.9%       1319 ± 10%      -1.1%       1358 ± 16%  interrupts.CPU99.CAL:Function_call_interrupts
      1.00 ±223%    -100.0%       0.00          -100.0%       0.00        interrupts.CPU99.IWI:IRQ_work_interrupts
    602442            -2.9%     584865 ±  7%      -7.3%     558540 ± 18%  interrupts.CPU99.LOC:Local_timer_interrupts
      1.00            +0.0%       1.00            +0.0%       1.00        interrupts.CPU99.MCP:Machine_check_polls
    297.67 ± 42%     -11.9%     262.14 ± 30%     +19.0%     354.14 ± 59%  interrupts.CPU99.NMI:Non-maskable_interrupts
    297.67 ± 42%     -11.9%     262.14 ± 30%     +19.0%     354.14 ± 59%  interrupts.CPU99.PMI:Performance_monitoring_interrupts
      8.67 ± 32%    +195.1%      25.57 ±121%     +92.9%      16.71 ± 86%  interrupts.CPU99.RES:Rescheduling_interrupts
     11.33 ± 32%     +45.0%      16.43 ± 96%     +34.9%      15.29 ± 77%  interrupts.CPU99.TLB:TLB_shootdowns
      8.00 ± 22%      +8.9%       8.71 ± 13%      +1.8%       8.14 ± 12%  interrupts.IWI:IRQ_work_interrupts
 1.541e+08            -2.2%  1.508e+08 ±  5%      -7.1%  1.431e+08 ± 18%  interrupts.LOC:Local_timer_interrupts
    256.00            +0.0%     256.00            +0.0%     256.00        interrupts.MCP:Machine_check_polls
     74199 ±  3%      -2.4%      72441 ±  2%      -7.8%      68414 ± 16%  interrupts.NMI:Non-maskable_interrupts
     74199 ±  3%      -2.4%      72441 ±  2%      -7.8%      68414 ± 16%  interrupts.PMI:Performance_monitoring_interrupts
      5638 ±  2%      +6.6%       6011 ±  7%      +3.1%       5813 ±  9%  interrupts.RES:Rescheduling_interrupts
      5247 ±  4%      +4.1%       5461 ±  4%      +1.8%       5343 ±  5%  interrupts.TLB:TLB_shootdowns



> 
> > On Apr 29, 2021, at 18:25, Roman Gushchin <guro@fb.com> wrote:
> > 
> > ﻿On Tue, Apr 27, 2021 at 03:34:48PM +0800, kernel test robot wrote:
> >> 
> >> 
> >> Greeting,
> >> 
> >> FYI, we noticed a -2.3% regression of aim9.sync_disk_rw.ops_per_sec due to commit:
> > 
> > Wow, that's very surprising, given that there are no pcpu allocations on any hot
> > paths there.
> > 
> > I tried hard to reproduce it, and I think I see something, however the data is
> > very noisy. I'm not sure I can confidently attribute the regression to
> > ace7e70901 ("percpu: use reclaim threshold instead of running for every page")
> > rather than
> > f183324133 ("percpu: implement partial chunk depopulation").
> > 
> > Anyway, in my setup the following patch seems to fix the regression.
> > Is it possible to test it?
> > 
> > Thank you!
> > 
> > Roman
> > 
> > --
> > 
> > From 6ee182110126cf93cf43389923bcf49ba12cb9a0 Mon Sep 17 00:00:00 2001
> > From: Roman Gushchin <guro@fb.com>
> > Date: Thu, 29 Apr 2021 18:01:40 -0700
> > Subject: [PATCH] percpu: optimize locking in pcpu_balance_workfn()
> > 
> > pcpu_balance_workfn() unconditionally calls pcpu_balance_free(),
> > pcpu_reclaim_populated(), pcpu_balance_populated() and
> > pcpu_balance_free() again.
> > 
> > Each call to pcpu_balance_free() and pcpu_reclaim_populated() will
> > cause at least one acquisition of the pcpu_lock. So even if the
> > balancing was scheduled because of a failed atomic allocation,
> > pcpu_lock will be acquired at least 4 times. This obviously
> > increases the contention on the pcpu_lock.
> > 
> > To optimize the scheme let's grab the pcpu_lock on the upper level
> > (in pcpu_balance_workfn()) and keep it generally locked for the whole
> > duration of the scheduled work, but release conditionally to perform
> > any slow operations like chunk (de)population and creation of new chunks.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> > mm/percpu.c | 41 +++++++++++++++++++++++++++++------------
> > 1 file changed, 29 insertions(+), 12 deletions(-)
> > 
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 245d89f6f0a9..f6bc8157cb3e 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -2005,6 +2005,9 @@ void __percpu *__alloc_reserved_percpu(size_t size, size_t align)
> >  * If empty_only is %false, reclaim all fully free chunks regardless of the
> >  * number of populated pages.  Otherwise, only reclaim chunks that have no
> >  * populated pages.
> > + *
> > + * CONTEXT:
> > + * pcpu_lock (can be dropped temporarily)
> >  */
> > static void pcpu_balance_free(enum pcpu_chunk_type type, bool empty_only)
> > {
> > @@ -2013,12 +2016,12 @@ static void pcpu_balance_free(enum pcpu_chunk_type type, bool empty_only)
> >    struct list_head *free_head = &pcpu_slot[pcpu_free_slot];
> >    struct pcpu_chunk *chunk, *next;
> > 
> > +    lockdep_assert_held(&pcpu_lock);
> > +
> >    /*
> >     * There's no reason to keep around multiple unused chunks and VM
> >     * areas can be scarce.  Destroy all free chunks except for one.
> >     */
> > -    spin_lock_irq(&pcpu_lock);
> > -
> >    list_for_each_entry_safe(chunk, next, free_head, list) {
> >        WARN_ON(chunk->immutable);
> > 
> > @@ -2030,8 +2033,10 @@ static void pcpu_balance_free(enum pcpu_chunk_type type, bool empty_only)
> >            list_move(&chunk->list, &to_free);
> >    }
> > 
> > -    spin_unlock_irq(&pcpu_lock);
> > +    if (list_empty(&to_free))
> > +        return;
> > 
> > +    spin_unlock_irq(&pcpu_lock);
> >    list_for_each_entry_safe(chunk, next, &to_free, list) {
> >        unsigned int rs, re;
> > 
> > @@ -2045,6 +2050,7 @@ static void pcpu_balance_free(enum pcpu_chunk_type type, bool empty_only)
> >        pcpu_destroy_chunk(chunk);
> >        cond_resched();
> >    }
> > +    spin_lock_irq(&pcpu_lock);
> > }
> > 
> > /**
> > @@ -2056,6 +2062,9 @@ static void pcpu_balance_free(enum pcpu_chunk_type type, bool empty_only)
> >  * OOM killer to be triggered.  We should avoid doing so until an actual
> >  * allocation causes the failure as it is possible that requests can be
> >  * serviced from already backed regions.
> > + *
> > + * CONTEXT:
> > + * pcpu_lock (can be dropped temporarily)
> >  */
> > static void pcpu_balance_populated(enum pcpu_chunk_type type)
> > {
> > @@ -2065,6 +2074,8 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
> >    struct pcpu_chunk *chunk;
> >    int slot, nr_to_pop, ret;
> > 
> > +    lockdep_assert_held(&pcpu_lock);
> > +
> >    /*
> >     * Ensure there are certain number of free populated pages for
> >     * atomic allocs.  Fill up from the most packed so that atomic
> > @@ -2092,13 +2103,11 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
> >        if (!nr_to_pop)
> >            break;
> > 
> > -        spin_lock_irq(&pcpu_lock);
> >        list_for_each_entry(chunk, &pcpu_slot[slot], list) {
> >            nr_unpop = chunk->nr_pages - chunk->nr_populated;
> >            if (nr_unpop)
> >                break;
> >        }
> > -        spin_unlock_irq(&pcpu_lock);
> > 
> >        if (!nr_unpop)
> >            continue;
> > @@ -2108,12 +2117,13 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
> >                         chunk->nr_pages) {
> >            int nr = min_t(int, re - rs, nr_to_pop);
> > 
> > +            spin_unlock_irq(&pcpu_lock);
> >            ret = pcpu_populate_chunk(chunk, rs, rs + nr, gfp);
> > +            cond_resched();
> > +            spin_lock_irq(&pcpu_lock);
> >            if (!ret) {
> >                nr_to_pop -= nr;
> > -                spin_lock_irq(&pcpu_lock);
> >                pcpu_chunk_populated(chunk, rs, rs + nr);
> > -                spin_unlock_irq(&pcpu_lock);
> >            } else {
> >                nr_to_pop = 0;
> >            }
> > @@ -2125,11 +2135,12 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
> > 
> >    if (nr_to_pop) {
> >        /* ran out of chunks to populate, create a new one and retry */
> > +        spin_unlock_irq(&pcpu_lock);
> >        chunk = pcpu_create_chunk(type, gfp);
> > +        cond_resched();
> > +        spin_lock_irq(&pcpu_lock);
> >        if (chunk) {
> > -            spin_lock_irq(&pcpu_lock);
> >            pcpu_chunk_relocate(chunk, -1);
> > -            spin_unlock_irq(&pcpu_lock);
> >            goto retry_pop;
> >        }
> >    }
> > @@ -2146,6 +2157,10 @@ static void pcpu_balance_populated(enum pcpu_chunk_type type)
> >  * populated pages threshold, reintegrate the chunk if it has empty free pages.
> >  * Each chunk is scanned in the reverse order to keep populated pages close to
> >  * the beginning of the chunk.
> > + *
> > + * CONTEXT:
> > + * pcpu_lock (can be dropped temporarily)
> > + *
> >  */
> > static void pcpu_reclaim_populated(enum pcpu_chunk_type type)
> > {
> > @@ -2155,7 +2170,7 @@ static void pcpu_reclaim_populated(enum pcpu_chunk_type type)
> >    LIST_HEAD(to_depopulate);
> >    int i, end;
> > 
> > -    spin_lock_irq(&pcpu_lock);
> > +    lockdep_assert_held(&pcpu_lock);
> > 
> >    list_splice_init(&pcpu_slot[pcpu_to_depopulate_slot], &to_depopulate);
> > 
> > @@ -2231,8 +2246,6 @@ static void pcpu_reclaim_populated(enum pcpu_chunk_type type)
> >                      &pcpu_slot[pcpu_to_depopulate_slot]);
> >        pcpu_schedule_balance_work();
> >    }
> > -
> > -    spin_unlock_irq(&pcpu_lock);
> > }
> > 
> > /**
> > @@ -2256,10 +2269,14 @@ static void pcpu_balance_workfn(struct work_struct *work)
> >     */
> >    for (type = 0; type < PCPU_NR_CHUNK_TYPES; type++) {
> >        mutex_lock(&pcpu_alloc_mutex);
> > +        spin_lock_irq(&pcpu_lock);
> > +
> >        pcpu_balance_free(type, false);
> >        pcpu_reclaim_populated(type);
> >        pcpu_balance_populated(type);
> >        pcpu_balance_free(type, true);
> > +
> > +        spin_unlock_irq(&pcpu_lock);
> >        mutex_unlock(&pcpu_alloc_mutex);
> >    }
> > }
> > -- 
> > 2.30.2
