Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE9741051F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 10:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbhIRIcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 04:32:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:17009 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237529AbhIRIct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 04:32:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10110"; a="210164632"
X-IronPort-AV: E=Sophos;i="5.85,303,1624345200"; 
   d="scan'208,223";a="210164632"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2021 01:31:24 -0700
X-IronPort-AV: E=Sophos;i="5.85,303,1624345200"; 
   d="scan'208,223";a="473352498"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2021 01:31:19 -0700
Date:   Sat, 18 Sep 2021 16:48:32 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [xfs]  ab23a77687:  aim7.jobs-per-min -18.5% regression
Message-ID: <20210918084818.GA24935@xsang-OptiPlex-9020>
References: <20210909142355.GA6270@xsang-OptiPlex-9020>
 <20210912233219.GB2335@rh>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210912233219.GB2335@rh>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Dave Chinner,

On Mon, Sep 13, 2021 at 09:32:19AM +1000, Dave Chinner wrote:
> On Thu, Sep 09, 2021 at 10:23:55PM +0800, kernel test robot wrote:
> > 
> > 
> > Hi Dave Chinner,
> > 
> > we reported "[xfs]  6df693ed7b:  aim7.jobs-per-min -15.7% regression" as [1]
> > when this change is still on
> > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git xfs-5.15-merge
> > 
> > now this change is on mainline.
> > so we report again to highlight we still observe similar performance regression
> > on mainline.
> > 
> > previously we also tried to test by turning off RWSEM_SPIN_ON_OWNER per your
> > guidance, but still observed similar regression, though we are not sure if our
> > method to turn off RWSEM_SPIN_ON_OWNER is enough. the detail result is in [2]
> > 
> > [1] https://lore.kernel.org/all/20210809064248.GB5761@xsang-OptiPlex-9020/
> > [2] https://lore.kernel.org/all/20210818085248.GA28771@xsang-OptiPlex-9020/
> 
> Did you look at the config that was generated before running the
> tests again?
> 
> > #
> > # Automatically generated file; DO NOT EDIT.
> > # Linux/x86_64 5.14.0-rc4 Kernel Configuration
> > #
> ....
> > CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> > CONFIG_MUTEX_SPIN_ON_OWNER=y
> > CONFIG_RWSEM_SPIN_ON_OWNER=y
> > CONFIG_LOCK_SPIN_ON_OWNER=y
> ....
> 
> 
> So these tests were still run with the same RWSEM_SPIN_ON_OWNER=y
> configuration, and so unsurprisingly the result was the same with
> spin contention on the directory inode rwsem.
> 
> You'll save yourself (and everyone else) a lot of time by validating
> that your config changes are valid before re-running tests...

maybe it's not a good practice for us to mix two reports, one still based on
branch, another is based on when the commit merged to mainline with a new
commit-id.
we will consider how to make things easy to understand in the future.

for this one, let me explain here.

we retested the ab23a77687 by default config (which still has
RWSEM_SPIN_ON_OWNER=y), confirmed regression still exists.

62af7d54a0ec0b6f ab23a7768739a23d21d8a16ca37 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    538894           -15.9%     453458        aim7.jobs-per-min


since:
* ab23a7768739a23 xfs: per-cpu deferred inode inactivation queues
* 62af7d54a0ec0b6 xfs: detach dquots from inode if we don't need to inactivate it
* c6c2066db3963e5 xfs: move xfs_inactive call to xfs_inode_mark_reclaimable


we noticed we should change code directly to disable RWSEM_SPIN_ON_OWNER,
so we insert a patch (as attached 0001-set-RWSEM_SPIN_ON_OWNER-default-to-n.patch)
after c6c2066db3963e5, then cherry-pick 62af7d54a0ec0b6 & ab23a7768739a23.
finally, it looks like below now:
* 1f9942500a8b xfs: per-cpu deferred inode inactivation queues
* dfc1c7b100ef xfs: detach dquots from inode if we don't need to inactivate it
* d47b9c79b4aa set RWSEM_SPIN_ON_OWNER default to n
* c6c2066db396 xfs: move xfs_inactive call to xfs_inode_mark_reclaimable


then we run tests to compare new commits dfc1c7b100ef and 1f9942500a8b.
the new config is attached as config-5.14.0-rc4-00010-g1f9942500a8b.
xsang@xsang-OptiPlex-9020:~$ grep RWSEM_SPIN_ON_OWNER config-5.14.0-rc4-00010-g1f9942500a8b
xsang@xsang-OptiPlex-9020:~$

and the only diff between this config with one we tested ab23a77687 is as:
--- ab23a7768739a23d21d8a16ca37dff96b1ca957a/.config   2021-08-18 13:20:42.342020080 +0800
+++ 1f9942500a8b3962c240b8da3b79e11c63d5644d/.config   2021-08-18 10:34:22.118459216 +0800
@@ -953,7 +953,6 @@ CONFIG_INLINE_WRITE_UNLOCK=y
 CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
 CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
 CONFIG_MUTEX_SPIN_ON_OWNER=y
-CONFIG_RWSEM_SPIN_ON_OWNER=y
 CONFIG_LOCK_SPIN_ON_OWNER=y
 CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
 CONFIG_QUEUED_SPINLOCKS=y

the detail comparison result is as below [1], regression is still existing:
(for comparison, also list the detail data for 62af7d54a0/ab23a77687 as [2])

please suggest if our patch to disable RWSEM_SPIN_ON_OWNER is enough.


[1]
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/4BRD_12G/xfs/x86_64-rhel-8.3-CONFIG_RWSEM_SPIN_ON_OWNER/3000/RAID1/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp9/disk_wrt/aim7/0x5003006

commit: 
  dfc1c7b100 ("xfs: detach dquots from inode if we don't need to inactivate it")
  1f9942500a ("xfs: per-cpu deferred inode inactivation queues") 

dfc1c7b100ef78a4 1f9942500a8b3962c240b8da3b7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    490.63 ±  3%      -3.1%     475.35 ±  3%  aim7.cpu
    528204           -16.3%     442100        aim7.jobs-per-min
    176.07           -16.3%     147.37        aim7.jobs-per-min-per-task
     99.00            -0.6%      98.40        aim7.jti
     34.08           +19.5%      40.72        aim7.real
     34.28           +19.4%      40.92        aim7.time.elapsed_time
     34.28           +19.4%      40.92        aim7.time.elapsed_time.max
    192.00            +0.0%     192.00        aim7.time.file_system_inputs
 6.168e+08            +0.0%  6.168e+08        aim7.time.file_system_outputs
      1736 ±  5%    +867.9%      16807 ±  4%  aim7.time.involuntary_context_switches
    211.30 ± 54%     -16.4%     176.70 ± 38%  aim7.time.major_page_faults
      2799            +0.0%       2800        aim7.time.maximum_resident_set_size
    166150            -0.8%     164854 ±  2%  aim7.time.minor_page_faults
      4096            +0.0%       4096        aim7.time.page_size
      1432 ±  3%     -18.8%       1162 ±  2%  aim7.time.percent_of_cpu_this_job_got
    472.65 ±  3%      -3.4%     456.53 ±  3%  aim7.time.system_time
     18.57 ±  3%      +4.5%      19.40 ±  2%  aim7.time.user_time
   1047684           -22.3%     813943        aim7.time.voluntary_context_switches
  2.59e+09           +22.5%  3.174e+09        cpuidle..time
   6334104           +20.2%    7615178        cpuidle..usage
     73.35            +8.9%      79.92        uptime.boot
      5555           +10.5%       6135        uptime.idle
     35.12            -0.3%      35.02        boot-time.boot
     16.99            -0.0%      16.98        boot-time.dhcp
      2674            -1.1%       2645        boot-time.idle
      0.88            +0.0%       0.88        boot-time.smp_boot
     83.24            +3.2%      85.94        iostat.cpu.idle
      0.01 ± 49%    +133.2%       0.03 ± 45%  iostat.cpu.iowait
     15.98 ±  3%     -16.5%      13.34 ±  2%  iostat.cpu.system
      0.77 ±  4%     -10.8%       0.69 ±  4%  iostat.cpu.user
     82.74            +2.7       85.45        mpstat.cpu.all.idle%
      0.01 ± 60%      +0.0        0.03 ± 53%  mpstat.cpu.all.iowait%
      1.06 ± 12%      -0.1        0.97 ±  3%  mpstat.cpu.all.irq%
      0.12 ±  6%      -0.0        0.11 ±  2%  mpstat.cpu.all.soft%
     15.29 ±  3%      -2.5       12.76 ±  2%  mpstat.cpu.all.sys%
      0.77 ±  4%      -0.1        0.68 ±  4%  mpstat.cpu.all.usr%
      0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
  38820787            +2.6%   39830510 ±  7%  numa-numastat.node0.local_node
  38830343            +2.6%   39830367 ±  7%  numa-numastat.node0.numa_hit
     44215 ± 67%      +0.0%      44231 ± 67%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
  38332075            -1.2%   37867576 ±  8%  numa-numastat.node1.local_node
  38331712            -1.2%   37854782 ±  8%  numa-numastat.node1.numa_hit
     35160 ± 85%      +0.3%      35269 ± 84%  numa-numastat.node1.other_node
     34.28           +19.4%      40.92        time.elapsed_time
     34.28           +19.4%      40.92        time.elapsed_time.max
    192.00            +0.0%     192.00        time.file_system_inputs
 6.168e+08            +0.0%  6.168e+08        time.file_system_outputs
      1736 ±  5%    +867.9%      16807 ±  4%  time.involuntary_context_switches
    211.30 ± 54%     -16.4%     176.70 ± 38%  time.major_page_faults
      2799            +0.0%       2800        time.maximum_resident_set_size
    166150            -0.8%     164854 ±  2%  time.minor_page_faults
      4096            +0.0%       4096        time.page_size
      1432 ±  3%     -18.8%       1162 ±  2%  time.percent_of_cpu_this_job_got
    472.65 ±  3%      -3.4%     456.53 ±  3%  time.system_time
     18.57 ±  3%      +4.5%      19.40 ±  2%  time.user_time
   1047684           -22.3%     813943        time.voluntary_context_switches
     82.80            +3.5%      85.70        vmstat.cpu.id
     15.50 ±  4%     -16.1%      13.00 ±  3%  vmstat.cpu.sy
      0.00          -100.0%       0.00        vmstat.cpu.us
      0.00          -100.0%       0.00        vmstat.cpu.wa
      6.00 ± 66%     -16.7%       5.00 ± 60%  vmstat.io.bi
      1504 ± 27%    +429.4%       7966 ±  6%  vmstat.io.bo
      4.00            +0.0%       4.00        vmstat.memory.buff
   2559089            +0.1%    2561253        vmstat.memory.cache
  1.27e+08            -0.0%   1.27e+08        vmstat.memory.free
      0.00          -100.0%       0.00        vmstat.procs.b
     14.10 ± 10%     -23.4%      10.80 ± 12%  vmstat.procs.r
     59393            -9.1%      53987        vmstat.system.cs
    182640            -2.3%     178448        vmstat.system.in
    487.20 ±  2%     -15.6%     411.10 ±  2%  turbostat.Avg_MHz
     18.02 ±  3%      -2.8       15.19 ±  2%  turbostat.Busy%
      2709            +0.1%       2711        turbostat.Bzy_MHz
    451822 ±183%     -64.7%     159601 ±  5%  turbostat.C1
      0.82 ±174%      -0.6        0.21 ±  4%  turbostat.C1%
   4837856 ± 26%     +26.2%    6103323 ± 10%  turbostat.C1E
     57.33 ± 36%      +2.0       59.34 ± 23%  turbostat.C1E%
   1032181 ± 85%     +29.8%    1339627 ± 50%  turbostat.C6
     24.25 ± 84%      +1.3       25.60 ± 54%  turbostat.C6%
     80.11 ±  3%      +5.6%      84.60        turbostat.CPU%c1
      1.87 ±140%     -89.1%       0.20 ± 20%  turbostat.CPU%c6
     53.90 ±  2%      +0.6%      54.20        turbostat.CoreTmp
   6723385           +16.2%    7815292        turbostat.IRQ
      0.86 ±163%    -100.0%       0.00        turbostat.Pkg%pc2
      0.34 ±211%    -100.0%       0.00        turbostat.Pkg%pc6
     53.70 ±  2%      +0.7%      54.10        turbostat.PkgTmp
    161.83            -3.1%     156.86        turbostat.PkgWatt
     56.63            -1.3%      55.89        turbostat.RAMWatt
      2095            +0.0%       2095        turbostat.TSC_MHz
     12476 ±  4%     +14.9%      14336 ±  3%  meminfo.Active
     11617 ±  4%     +15.9%      13467 ±  3%  meminfo.Active(anon)
    858.90 ±  2%      +1.1%     868.00        meminfo.Active(file)
     60182 ±  3%      +5.4%      63430 ±  4%  meminfo.AnonHugePages
    358575            +0.1%     358896        meminfo.AnonPages
      4.00            +0.0%       4.00        meminfo.Buffers
   2426718            -0.0%    2425701        meminfo.Cached
  65836764            +0.0%   65836764        meminfo.CommitLimit
   2687421            -0.2%    2681756        meminfo.Committed_AS
 1.223e+08            -0.3%  1.218e+08        meminfo.DirectMap1G
  12954419 ± 16%      +3.4%   13395968 ± 12%  meminfo.DirectMap2M
    767751 ±  4%      -2.9%     745632 ±  3%  meminfo.DirectMap4k
      8109 ± 10%     -26.1%       5990 ±  8%  meminfo.Dirty
      2048            +0.0%       2048        meminfo.Hugepagesize
    377479            -0.5%     375613        meminfo.Inactive
    368435            +0.1%     368738        meminfo.Inactive(anon)
      9043 ±  8%     -24.0%       6874 ±  7%  meminfo.Inactive(file)
    132478            +2.2%     135445        meminfo.KReclaimable
     60777            +0.6%      61169        meminfo.KernelStack
     33568            -1.4%      33101        meminfo.Mapped
 1.265e+08            -0.0%  1.264e+08        meminfo.MemAvailable
  1.27e+08            -0.0%   1.27e+08        meminfo.MemFree
 1.317e+08            +0.0%  1.317e+08        meminfo.MemTotal
   4662028            +0.7%    4696434        meminfo.Memused
    105244 ±  9%      -1.3%     103891 ±  6%  meminfo.PageTables
     47830            +0.4%      48019        meminfo.Percpu
    132478            +2.2%     135445        meminfo.SReclaimable
    297944            +2.1%     304270        meminfo.SUnreclaim
     21831 ±  2%      +7.3%      23414 ±  2%  meminfo.Shmem
    430423            +2.2%     439716        meminfo.Slab
   2389940            +0.0%    2390497        meminfo.Unevictable
 3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
    216339            +0.2%     216777        meminfo.VmallocUsed
      9.80 ±181%    +173.5%      26.80 ±110%  meminfo.Writeback
   4707899            +1.0%    4757215        meminfo.max_used_kB
      2781 ± 50%      -5.6%       2626 ± 39%  numa-meminfo.node0.Active
      1923 ± 73%      -4.1%       1844 ± 63%  numa-meminfo.node0.Active(anon)
    858.10 ±  2%      -9.0%     781.00 ± 33%  numa-meminfo.node0.Active(file)
     52900 ±  9%     -11.4%      46884 ± 40%  numa-meminfo.node0.AnonHugePages
    301584 ± 11%     -13.2%     261729 ± 34%  numa-meminfo.node0.AnonPages
    326923 ± 13%     -12.9%     284661 ± 34%  numa-meminfo.node0.AnonPages.max
      4103 ± 14%     -27.4%       2977 ± 13%  numa-meminfo.node0.Dirty
   1940693 ± 46%      +8.8%    2111010 ± 29%  numa-meminfo.node0.FilePages
    311780 ± 11%     -13.7%     268999 ± 34%  numa-meminfo.node0.Inactive
    306846 ± 11%     -13.5%     265276 ± 34%  numa-meminfo.node0.Inactive(anon)
      4933 ± 12%     -24.6%       3722 ± 20%  numa-meminfo.node0.Inactive(file)
     82740 ± 21%      +1.3%      83822 ± 12%  numa-meminfo.node0.KReclaimable
     44998 ± 39%      -9.4%      40767 ± 50%  numa-meminfo.node0.KernelStack
     25217 ± 48%      +4.4%      26337 ± 33%  numa-meminfo.node0.Mapped
  62268357            -0.1%   62200406        numa-meminfo.node0.MemFree
  65659180            +0.0%   65659180        numa-meminfo.node0.MemTotal
   3390821 ± 28%      +2.0%    3458772 ± 21%  numa-meminfo.node0.MemUsed
     86010 ± 49%     -15.9%      72304 ± 63%  numa-meminfo.node0.PageTables
     82740 ± 21%      +1.3%      83822 ± 12%  numa-meminfo.node0.SReclaimable
    188014 ± 20%      -6.1%     176544 ± 28%  numa-meminfo.node0.SUnreclaim
      7401 ± 62%     -24.8%       5562 ± 72%  numa-meminfo.node0.Shmem
    270755 ± 16%      -3.8%     260366 ± 20%  numa-meminfo.node0.Slab
   1924871 ± 46%      +9.0%    2098856 ± 29%  numa-meminfo.node0.Unevictable
      5.60 ±165%     +98.2%      11.10 ± 87%  numa-meminfo.node0.Writeback
      9694 ± 17%     +20.8%      11710 ± 10%  numa-meminfo.node1.Active
      9693 ± 17%     +19.9%      11623 ± 12%  numa-meminfo.node1.Active(anon)
      0.80 ±156%  +10762.5%      86.90 ±298%  numa-meminfo.node1.Active(file)
      7406 ± 69%    +124.2%      16602 ±107%  numa-meminfo.node1.AnonHugePages
     56981 ± 62%     +70.7%      97262 ± 91%  numa-meminfo.node1.AnonPages
     75128 ± 60%     +55.4%     116713 ± 80%  numa-meminfo.node1.AnonPages.max
      3889 ± 12%     -27.8%       2806 ±  8%  numa-meminfo.node1.Dirty
    486321 ±183%     -35.3%     314835 ±196%  numa-meminfo.node1.FilePages
     65527 ± 56%     +62.5%     106503 ± 85%  numa-meminfo.node1.Inactive
     61573 ± 59%     +68.2%     103555 ± 87%  numa-meminfo.node1.Inactive(anon)
      3953 ± 16%     -25.5%       2946 ± 18%  numa-meminfo.node1.Inactive(file)
     49748 ± 36%      +3.8%      51648 ± 21%  numa-meminfo.node1.KReclaimable
     15696 ±112%     +29.8%      20377 ±100%  numa-meminfo.node1.KernelStack
      8534 ±143%     -18.7%       6934 ±125%  numa-meminfo.node1.Mapped
  64743424            +0.1%   64776711        numa-meminfo.node1.MemFree
  66014352            +0.0%   66014352        numa-meminfo.node1.MemTotal
   1270927 ± 76%      -2.6%    1237639 ± 58%  numa-meminfo.node1.MemUsed
     19062 ±187%     +65.3%      31518 ±146%  numa-meminfo.node1.PageTables
     49748 ± 36%      +3.8%      51648 ± 21%  numa-meminfo.node1.SReclaimable
    109860 ± 35%     +16.3%     127723 ± 39%  numa-meminfo.node1.SUnreclaim
     14429 ± 32%     +23.7%      17852 ± 22%  numa-meminfo.node1.Shmem
    159609 ± 29%     +12.4%     179372 ± 30%  numa-meminfo.node1.Slab
    465068 ±191%     -37.3%     291641 ±212%  numa-meminfo.node1.Unevictable
      4.20 ±213%    +192.9%      12.30 ± 96%  numa-meminfo.node1.Writeback
    359.40 ±  4%      -3.0%     348.60 ±  4%  proc-vmstat.direct_map_level2_splits
      9.20 ± 20%      +6.5%       9.80 ± 16%  proc-vmstat.direct_map_level3_splits
      2904 ±  4%     +15.9%       3366 ±  3%  proc-vmstat.nr_active_anon
    214.40 ±  2%      +1.1%     216.70        proc-vmstat.nr_active_file
     89639            +0.1%      89718        proc-vmstat.nr_anon_pages
     28.80 ±  3%      +6.2%      30.60 ±  4%  proc-vmstat.nr_anon_transparent_hugepages
  76445660            +0.7%   76995988        proc-vmstat.nr_dirtied
      2046 ± 11%     -27.6%       1481 ±  8%  proc-vmstat.nr_dirty
   3155488            -0.0%    3154569        proc-vmstat.nr_dirty_background_threshold
   6318694            -0.0%    6316853        proc-vmstat.nr_dirty_threshold
    606699            -0.0%     606419        proc-vmstat.nr_file_pages
  31752898            -0.0%   31744271        proc-vmstat.nr_free_pages
     92104            +0.1%      92179        proc-vmstat.nr_inactive_anon
      2278 ± 10%     -25.5%       1697 ±  7%  proc-vmstat.nr_inactive_file
      1.00 ±300%     -80.0%       0.20 ±300%  proc-vmstat.nr_isolated_anon
     60765            +0.7%      61166        proc-vmstat.nr_kernel_stack
      8393            -1.4%       8279        proc-vmstat.nr_mapped
     26303 ±  9%      -1.3%      25968 ±  6%  proc-vmstat.nr_page_table_pages
      5457 ±  2%      +7.3%       5853 ±  2%  proc-vmstat.nr_shmem
     33120            +2.2%      33861        proc-vmstat.nr_slab_reclaimable
     74482            +2.1%      76067        proc-vmstat.nr_slab_unreclaimable
    597484            +0.0%     597623        proc-vmstat.nr_unevictable
      2.40 ±184%    +166.7%       6.40 ±114%  proc-vmstat.nr_writeback
      8307 ± 45%    +108.3%      17307 ± 31%  proc-vmstat.nr_written
      2904 ±  4%     +15.9%       3366 ±  3%  proc-vmstat.nr_zone_active_anon
    214.40 ±  2%      +1.1%     216.70        proc-vmstat.nr_zone_active_file
     92104            +0.1%      92179        proc-vmstat.nr_zone_inactive_anon
      2278 ± 10%     -25.5%       1698 ±  7%  proc-vmstat.nr_zone_inactive_file
    597484            +0.0%     597623        proc-vmstat.nr_zone_unevictable
      1832 ± 10%     -28.2%       1316 ±  9%  proc-vmstat.nr_zone_write_pending
     28.00 ±234%   +1031.1%     316.70 ±270%  proc-vmstat.numa_hint_faults
      5.60 ± 78%   +4453.6%     255.00 ±292%  proc-vmstat.numa_hint_faults_local
  77053874            +0.8%   77665728        proc-vmstat.numa_hit
      5.60 ± 81%    +103.6%      11.40 ±134%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00        proc-vmstat.numa_interleave
  77043945            +0.8%   77678606        proc-vmstat.numa_local
     79376            +0.2%      79501        proc-vmstat.numa_other
     22.40 ±300%    +403.6%     112.80 ±238%  proc-vmstat.numa_pages_migrated
      2867 ± 81%    +128.6%       6554 ±152%  proc-vmstat.numa_pte_updates
      7426 ±  7%     -18.8%       6031 ±  6%  proc-vmstat.pgactivate
      0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
  76960314            +0.8%   77556090        proc-vmstat.pgalloc_normal
    383699 ±  2%      +8.8%     417382 ±  2%  proc-vmstat.pgfault
  76771447            +0.8%   77390012        proc-vmstat.pgfree
     22.40 ±300%    +403.6%     112.80 ±238%  proc-vmstat.pgmigrate_success
    232.00 ± 58%      +0.0%     232.00 ± 58%  proc-vmstat.pgpgin
     55529 ± 28%    +531.0%     350410 ±  6%  proc-vmstat.pgpgout
     13642           +11.2%      15168 ±  2%  proc-vmstat.pgreuse
     31.20 ±  7%     +23.1%      38.40 ±  8%  proc-vmstat.thp_collapse_alloc
      0.00         +1e+101%       0.10 ±300%  proc-vmstat.thp_deferred_split_page
     11.10 ±  8%      -5.4%      10.50 ± 12%  proc-vmstat.thp_fault_alloc
      0.00         +1e+101%       0.10 ±300%  proc-vmstat.thp_migration_success
      0.00         +1e+101%       0.10 ±300%  proc-vmstat.thp_split_pmd
      0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
      1636            +1.2%       1656        proc-vmstat.unevictable_pgs_culled
    480.40 ± 73%      -4.1%     460.90 ± 64%  numa-vmstat.node0.nr_active_anon
    214.20            -9.0%     195.00 ± 33%  numa-vmstat.node0.nr_active_file
     75385 ± 11%     -13.2%      65430 ± 34%  numa-vmstat.node0.nr_anon_pages
     25.30 ±  9%     -10.7%      22.60 ± 40%  numa-vmstat.node0.nr_anon_transparent_hugepages
  13211748 ±  2%     +12.7%   14885292 ± 13%  numa-vmstat.node0.nr_dirtied
      1028 ± 14%     -24.3%     778.40 ± 11%  numa-vmstat.node0.nr_dirty
    485176 ± 46%      +8.8%     527782 ± 29%  numa-vmstat.node0.nr_file_pages
  15567109            -0.1%   15550102        numa-vmstat.node0.nr_free_pages
     76699 ± 11%     -13.5%      66317 ± 34%  numa-vmstat.node0.nr_inactive_anon
      1222 ± 12%     -21.2%     963.00 ± 17%  numa-vmstat.node0.nr_inactive_file
      1.00 ±300%    -100.0%       0.00        numa-vmstat.node0.nr_isolated_anon
     44985 ± 39%      -9.4%      40762 ± 50%  numa-vmstat.node0.nr_kernel_stack
      6305 ± 48%      +4.4%       6583 ± 33%  numa-vmstat.node0.nr_mapped
     21492 ± 49%     -15.9%      18072 ± 63%  numa-vmstat.node0.nr_page_table_pages
      1849 ± 62%     -24.9%       1390 ± 72%  numa-vmstat.node0.nr_shmem
     20684 ± 21%      +1.3%      20955 ± 12%  numa-vmstat.node0.nr_slab_reclaimable
     47001 ± 20%      -6.1%      44134 ± 28%  numa-vmstat.node0.nr_slab_unreclaimable
    481217 ± 46%      +9.0%     524714 ± 29%  numa-vmstat.node0.nr_unevictable
      1.30 ±172%     +92.3%       2.50 ± 95%  numa-vmstat.node0.nr_writeback
      2031 ± 43%     +69.1%       3434 ± 52%  numa-vmstat.node0.nr_written
    480.40 ± 73%      -4.1%     460.90 ± 64%  numa-vmstat.node0.nr_zone_active_anon
    214.20            -9.0%     195.00 ± 33%  numa-vmstat.node0.nr_zone_active_file
     76699 ± 11%     -13.5%      66317 ± 34%  numa-vmstat.node0.nr_zone_inactive_anon
      1214 ± 12%     -20.4%     967.20 ± 18%  numa-vmstat.node0.nr_zone_inactive_file
    481217 ± 46%      +9.0%     524714 ± 29%  numa-vmstat.node0.nr_zone_unevictable
    914.50 ± 14%     -22.9%     704.90 ±  9%  numa-vmstat.node0.nr_zone_write_pending
  14790078 ±  3%     +11.2%   16440537 ± 12%  numa-vmstat.node0.numa_hit
      3739 ±  5%      -1.7%       3676 ±  4%  numa-vmstat.node0.numa_interleave
  14753176 ±  3%     +11.2%   16410866 ± 12%  numa-vmstat.node0.numa_local
     45554 ± 62%      +1.9%      46438 ± 60%  numa-vmstat.node0.numa_other
      2423 ± 17%     +19.9%       2905 ± 12%  numa-vmstat.node1.nr_active_anon
      0.00       +2.2e+103%      21.70 ±298%  numa-vmstat.node1.nr_active_file
     14243 ± 62%     +70.8%      24321 ± 91%  numa-vmstat.node1.nr_anon_pages
      3.20 ± 68%    +140.6%       7.70 ±115%  numa-vmstat.node1.nr_anon_transparent_hugepages
  12882548 ±  2%      +6.1%   13664339 ± 14%  numa-vmstat.node1.nr_dirtied
      1008 ± 13%     -27.8%     728.60 ± 11%  numa-vmstat.node1.nr_dirty
    121604 ±183%     -35.2%      78751 ±196%  numa-vmstat.node1.nr_file_pages
  16185856            +0.1%   16194170        numa-vmstat.node1.nr_free_pages
     15392 ± 59%     +68.2%      25894 ± 87%  numa-vmstat.node1.nr_inactive_anon
      1031 ± 16%     -25.7%     766.20 ± 22%  numa-vmstat.node1.nr_inactive_file
     15688 ±112%     +29.9%      20376 ±100%  numa-vmstat.node1.nr_kernel_stack
      2141 ±142%     -18.8%       1740 ±124%  numa-vmstat.node1.nr_mapped
      4760 ±187%     +65.5%       7878 ±146%  numa-vmstat.node1.nr_page_table_pages
      3606 ± 32%     +23.7%       4462 ± 22%  numa-vmstat.node1.nr_shmem
     12436 ± 36%      +3.8%      12911 ± 21%  numa-vmstat.node1.nr_slab_reclaimable
     27462 ± 35%     +16.3%      31928 ± 39%  numa-vmstat.node1.nr_slab_unreclaimable
    116266 ±191%     -37.3%      72910 ±212%  numa-vmstat.node1.nr_unevictable
      1.00 ±219%    +160.0%       2.60 ±106%  numa-vmstat.node1.nr_writeback
      1787 ± 48%     +87.8%       3357 ± 45%  numa-vmstat.node1.nr_written
      2423 ± 17%     +19.9%       2905 ± 12%  numa-vmstat.node1.nr_zone_active_anon
      0.00       +2.2e+103%      21.70 ±298%  numa-vmstat.node1.nr_zone_active_file
     15391 ± 59%     +68.2%      25894 ± 87%  numa-vmstat.node1.nr_zone_inactive_anon
      1030 ± 14%     -25.6%     767.00 ± 22%  numa-vmstat.node1.nr_zone_inactive_file
    116266 ±191%     -37.3%      72910 ±212%  numa-vmstat.node1.nr_zone_unevictable
    876.50 ± 11%     -25.6%     652.30 ± 15%  numa-vmstat.node1.nr_zone_write_pending
  13631899 ±  3%      +6.1%   14469621 ± 14%  numa-vmstat.node1.numa_hit
      3880 ±  5%      +1.6%       3942 ±  5%  numa-vmstat.node1.numa_interleave
  13598197 ±  3%      +6.2%   14444328 ± 14%  numa-vmstat.node1.numa_local
     43850 ± 65%      -0.6%      43571 ± 64%  numa-vmstat.node1.numa_other
      8.32 ± 79%     -54.3%       3.80 ±  3%  perf-stat.i.MPKI
 7.542e+09           -13.2%  6.549e+09        perf-stat.i.branch-instructions
      1.49 ± 48%      -0.5        0.98 ± 11%  perf-stat.i.branch-miss-rate%
  44867276 ±  5%     -15.8%   37791437 ±  5%  perf-stat.i.branch-misses
     21.33 ±  3%      +2.1       23.45 ±  5%  perf-stat.i.cache-miss-rate%
  39756739 ±  3%     -15.3%   33664131 ±  4%  perf-stat.i.cache-misses
 1.541e+08 ±  5%     -19.2%  1.246e+08 ±  3%  perf-stat.i.cache-references
     60831            -8.7%      55517        perf-stat.i.context-switches
      1.71 ± 18%     -19.3%       1.38 ±  5%  perf-stat.i.cpi
     88036            -0.0%      88034        perf-stat.i.cpu-clock
 4.195e+10 ±  2%     -15.7%  3.535e+10 ±  2%  perf-stat.i.cpu-cycles
      1347 ±  7%      -0.5%       1341 ±  7%  perf-stat.i.cpu-migrations
      2409 ± 24%      +0.0%       2409 ± 15%  perf-stat.i.cycles-between-cache-misses
      0.07 ±134%      -0.1        0.02 ±140%  perf-stat.i.dTLB-load-miss-rate%
    995253 ± 27%     -16.5%     831043 ± 11%  perf-stat.i.dTLB-load-misses
 1.138e+10           -12.9%  9.915e+09        perf-stat.i.dTLB-loads
      0.01 ±104%      -0.0        0.01 ± 74%  perf-stat.i.dTLB-store-miss-rate%
    132663 ± 19%      -9.9%     119578 ±  7%  perf-stat.i.dTLB-store-misses
 6.322e+09           -13.0%  5.497e+09        perf-stat.i.dTLB-stores
     70.08            +1.5       71.53        perf-stat.i.iTLB-load-miss-rate%
  23726514 ±  5%     -18.7%   19281800 ±  2%  perf-stat.i.iTLB-load-misses
   5140165           -15.7%    4331943        perf-stat.i.iTLB-loads
 3.944e+10           -13.0%  3.433e+10        perf-stat.i.instructions
      2078 ±  9%      +1.5%       2109 ±  6%  perf-stat.i.instructions-per-iTLB-miss
      0.83 ±  3%      +5.3%       0.87 ±  2%  perf-stat.i.ipc
      8.91 ± 37%     -25.5%       6.64 ± 25%  perf-stat.i.major-faults
      0.48 ±  2%     -15.7%       0.40 ±  2%  perf-stat.i.metric.GHz
    343.47 ± 23%     -26.9%     251.09 ±  3%  perf-stat.i.metric.K/sec
    288.66           -13.0%     251.17        perf-stat.i.metric.M/sec
      7885 ±  2%     -10.6%       7048        perf-stat.i.minor-faults
     74.30            -1.7       72.62 ±  2%  perf-stat.i.node-load-miss-rate%
   7257614 ±  3%     -18.3%    5929307 ±  5%  perf-stat.i.node-load-misses
   2562674 ±  2%      -9.4%    2320638        perf-stat.i.node-loads
     44.46 ±  6%      -0.1       44.41 ±  3%  perf-stat.i.node-store-miss-rate%
   2331902           -11.0%    2074644 ±  4%  perf-stat.i.node-store-misses
   4038016            -8.9%    3680362        perf-stat.i.node-stores
      7894 ±  2%     -10.6%       7055        perf-stat.i.page-faults
     88036            -0.0%      88034        perf-stat.i.task-clock
      3.91 ±  5%      -7.1%       3.63 ±  3%  perf-stat.overall.MPKI
      0.59 ±  4%      -0.0        0.58 ±  5%  perf-stat.overall.branch-miss-rate%
     25.83 ±  3%      +1.2       27.00 ±  3%  perf-stat.overall.cache-miss-rate%
      1.07 ±  2%      -3.2%       1.03 ±  2%  perf-stat.overall.cpi
      1057 ±  2%      -0.4%       1053 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.01 ± 27%      -0.0        0.01 ± 11%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ± 18%      +0.0        0.00 ±  7%  perf-stat.overall.dTLB-store-miss-rate%
     82.18            -0.5       81.66        perf-stat.overall.iTLB-load-miss-rate%
      1666 ±  5%      +6.9%       1781 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.94 ±  2%      +3.3%       0.97 ±  2%  perf-stat.overall.ipc
     73.90            -2.1       71.80        perf-stat.overall.node-load-miss-rate%
     36.60            -0.6       36.00 ±  3%  perf-stat.overall.node-store-miss-rate%
 7.341e+09           -12.8%  6.398e+09        perf-stat.ps.branch-instructions
  43624329 ±  5%     -15.4%   36889044 ±  5%  perf-stat.ps.branch-misses
  38694537 ±  3%     -15.1%   32869201 ±  4%  perf-stat.ps.cache-misses
   1.5e+08 ±  5%     -18.9%  1.217e+08 ±  3%  perf-stat.ps.cache-references
     59190            -8.4%      54223        perf-stat.ps.context-switches
     85497            +0.5%      85893        perf-stat.ps.cpu-clock
 4.089e+10 ±  2%     -15.4%  3.457e+10 ±  2%  perf-stat.ps.cpu-cycles
      1317 ±  7%      -0.2%       1315 ±  7%  perf-stat.ps.cpu-migrations
    967238 ± 27%     -16.1%     811462 ± 11%  perf-stat.ps.dTLB-load-misses
 1.108e+10           -12.5%  9.687e+09        perf-stat.ps.dTLB-loads
    128874 ± 18%      -9.4%     116720 ±  7%  perf-stat.ps.dTLB-store-misses
 6.152e+09           -12.7%   5.37e+09        perf-stat.ps.dTLB-stores
  23094485 ±  5%     -18.4%   18837735 ±  2%  perf-stat.ps.iTLB-load-misses
   4999450           -15.4%    4229657        perf-stat.ps.iTLB-loads
 3.839e+10           -12.6%  3.354e+10        perf-stat.ps.instructions
      8.61 ± 37%     -24.9%       6.46 ± 25%  perf-stat.ps.major-faults
      7620 ±  2%     -10.0%       6859        perf-stat.ps.minor-faults
   7063866 ±  3%     -18.1%    5787643 ±  5%  perf-stat.ps.node-load-misses
   2493555 ±  2%      -9.1%    2267244        perf-stat.ps.node-loads
   2268900           -10.8%    2024612 ±  4%  perf-stat.ps.node-store-misses
   3930392            -8.5%    3596127        perf-stat.ps.node-stores
      7628 ±  2%     -10.0%       6866        perf-stat.ps.page-faults
     85497            +0.5%      85893        perf-stat.ps.task-clock
 1.348e+12            +3.6%  1.396e+12        perf-stat.total.instructions
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 57%      -9.3%       0.01 ± 72%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ±200%     -50.0%       0.00 ±300%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.01 ± 70%     -29.0%       0.00 ± 85%  perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.00 ± 70%    +488.9%       0.02 ±187%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.05 ± 85%     +44.6%       0.08 ±117%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ±167%      +0.0%       0.00 ±154%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.00          +3e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.00 ± 35%     +29.8%       0.01 ± 51%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.02 ±124%      +7.2%       0.03 ±174%  perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.kmalloc_large_node.__kmalloc_node
      0.00 ±200%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          +5e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.__split_vma
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.shift_arg_pages
      0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      0.00          +3e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
      0.00 ±213%     -22.2%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.00 ±209%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mmap_region
      0.00 ±213%     +83.3%       0.00 ±110%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.00 ±300%    +100.0%       0.00 ±200%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.00       +1.4e+100%       0.01 ±258%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap
      0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.anon_vma_clone.anon_vma_fork.dup_mmap
      0.00 ±299%     -28.6%       0.00 ±300%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.anon_vma_fork.dup_mmap.dup_mm
      0.01 ±249%     -63.6%       0.00 ± 77%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process
      0.00 ±202%     -42.9%       0.00 ±300%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      0.04 ±282%     -86.1%       0.01 ±231%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap
      0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.unmap_region
      0.00          +3e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
      0.64 ±298%     -95.6%       0.03 ±266%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 13%      +9.8%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.19 ±194%      +1.3%       0.19 ±195%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00 ±124%     -34.8%       0.00 ±200%  perf-sched.sch_delay.avg.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
      0.01 ± 72%    +346.2%       0.03 ± 96%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.11 ± 26%      +5.7%       0.11 ± 40%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 59%      -5.2%       0.01 ± 75%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ±200%     -50.0%       0.00 ±300%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.01 ± 75%     -32.5%       0.01 ± 87%  perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.03 ±186%   +1383.4%       0.45 ±229%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.60 ± 89%     +46.0%       2.33 ±124%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ±167%      +0.0%       0.00 ±154%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.00          +3e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.01 ± 15%     +25.4%       0.01 ± 19%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.56 ±146%      -2.7%       0.55 ±208%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.kmalloc_large_node.__kmalloc_node
      0.00 ±200%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          +5e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.__split_vma
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.shift_arg_pages
      0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      0.00          +3e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.path_openat.do_filp_open
      0.00 ±213%     -22.2%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.00 ±217%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mmap_region
      0.00 ±202%    +157.1%       0.00 ±101%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.01 ±300%     +41.5%       0.02 ±200%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.00       +6.2e+100%       0.06 ±288%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap
      0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.anon_vma_clone.anon_vma_fork.dup_mmap
      0.00 ±299%     -28.6%       0.00 ±300%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.anon_vma_fork.dup_mmap.dup_mm
      0.01 ±265%     -77.2%       0.00 ± 66%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process
      0.00 ±202%     -42.9%       0.00 ±300%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      0.13 ±290%     -75.0%       0.03 ±268%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap
      0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.unmap_region
      0.00          +5e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
      1.92 ±298%     -89.4%       0.20 ±289%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 13%      +9.8%       0.01 ± 14%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.81 ±197%     +24.6%       1.01 ±198%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00 ±124%     -34.8%       0.00 ±200%  perf-sched.sch_delay.max.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
      0.34 ±214%   +1053.0%       3.92 ±113%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      3.46 ±  3%      +1.4%       3.51 ±  2%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.02 ± 52%     +42.5%       0.03 ± 33%  perf-sched.total_sch_delay.average.ms
      5.24 ± 88%     +30.7%       6.84 ± 38%  perf-sched.total_sch_delay.max.ms
      0.97 ± 36%      +0.6%       0.98 ± 33%  perf-sched.total_wait_and_delay.average.ms
    457.90 ± 10%      -3.6%     441.20 ± 18%  perf-sched.total_wait_and_delay.count.ms
     13.58 ± 37%     +21.4%      16.48 ± 29%  perf-sched.total_wait_and_delay.max.ms
      0.95 ± 37%      -0.3%       0.95 ± 35%  perf-sched.total_wait_time.average.ms
     13.49 ± 37%     +21.5%      16.38 ± 30%  perf-sched.total_wait_time.max.ms
      1.30 ± 50%      -9.6%       1.17 ± 66%  perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ±300%     +25.0%       0.00 ±300%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1.12 ± 66%     -28.0%       0.81 ±100%  perf-sched.wait_and_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.41 ± 23%     +22.5%       0.51 ± 31%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.31 ±208%     -79.9%       0.06 ±200%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.43 ± 14%     +11.1%       0.47 ± 20%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00          +3e+98%       0.00 ±300%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.01 ±141%    +576.5%       0.03 ±208%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.59 ± 31%      -5.0%       0.56 ± 40%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00          +5e+98%       0.00 ±300%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__fput.task_work_run.do_exit
      0.00          +5e+98%       0.00 ±300%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.__split_vma
      0.00          +4e+98%       0.00 ±300%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.00 ±265%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.00          +4e+98%       0.00 ±300%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mmap_region
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      0.00 ±300%    +150.0%       0.00 ±161%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.07 ± 53%     +35.9%       0.09 ± 68%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.00 ±300%   +4633.3%       0.01 ±254%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap
      0.00          +2e+98%       0.00 ±300%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.__vma_adjust.__split_vma.mprotect_fixup
      0.00       +6.9e+100%       0.07 ±300%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.anon_vma_fork.dup_mmap.dup_mm
      0.04 ±215%     -43.7%       0.02 ±149%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process
      0.00          +4e+98%       0.00 ±300%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      0.07 ±201%     -60.7%       0.03 ±166%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap
      0.00          +8e+98%       0.00 ±200%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.unmap_region
      0.01 ±284%     -90.3%       0.00 ±169%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
      2.08 ± 95%     -24.0%       1.58 ± 62%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00 ±299%    +500.0%       0.00 ±123%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      2.97 ± 38%      -8.4%       2.72 ± 40%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
      2.16 ± 50%      -1.9%       2.12 ± 44%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      1.15 ± 23%      +9.8%       1.26 ± 35%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
      1.60 ± 50%     -12.5%       1.40 ± 65%  perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.10 ±300%      +0.0%       0.10 ±300%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1.40 ± 65%     -21.4%       1.10 ± 85%  perf-sched.wait_and_delay.count.do_syslog.part.0.kmsg_read.vfs_read
     37.00 ± 21%      +0.5%      37.20 ± 28%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.30 ±213%     +33.3%       0.40 ±200%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
     32.20 ± 22%     -12.1%      28.30 ± 30%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      1.40 ± 72%      +7.1%       1.50 ± 80%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.10 ± 31%      -1.9%      30.50 ± 39%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__fput.task_work_run.do_exit
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.__split_vma
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.down_write.unlink_anon_vmas.free_pgtables
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.down_write.vma_link.mmap_region
      0.10 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.30 ±213%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma
      0.10 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mmap_region
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
      0.20 ±300%     -50.0%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.swevent_hlist_put_cpu.sw_perf_event_destroy
      0.20 ±300%    +250.0%       0.70 ±157%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
    146.70 ± 13%      -6.1%     137.70 ± 19%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm.proc_pid_cmdline_read
      0.20 ±300%    +450.0%       1.10 ±149%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap
      0.00         +2e+101%       0.20 ±300%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.__vma_adjust.__split_vma.mprotect_fixup
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.anon_vma_fork.dup_mmap.dup_mm
      1.00 ±134%     +30.0%       1.30 ±124%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process
      0.00         +2e+101%       0.20 ±300%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      2.40 ± 83%      +8.3%       2.60 ± 77%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap
      0.00         +5e+101%       0.50 ±240%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.unmap_region
      0.40 ±200%    +175.0%       1.10 ±110%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
      6.40 ± 61%     +18.8%       7.60 ± 37%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.10 ±300%    +300.0%       0.40 ±122%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      4.10 ± 38%      +2.4%       4.20 ± 34%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.10 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.xfsaild.kthread.ret_from_fork
    147.40 ± 13%      -5.4%     139.40 ± 18%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
     35.90 ± 21%      +6.4%      38.20 ± 37%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      2.58 ± 50%      -9.6%       2.33 ± 66%  perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ±300%     +25.0%       0.00 ±300%  perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      2.23 ± 66%     -28.0%       1.61 ±100%  perf-sched.wait_and_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      3.90 ± 55%     +18.4%       4.62 ± 45%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.41 ±200%     -69.8%       0.12 ±200%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      1.77 ± 70%     +50.6%       2.67 ± 99%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00          +3e+98%       0.00 ±300%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.01 ±187%    +772.1%       0.10 ±223%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.97 ± 21%      +9.4%       2.15 ± 30%  perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00          +5e+98%       0.00 ±300%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__fput.task_work_run.do_exit
      0.00          +5e+98%       0.00 ±300%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.__vma_adjust.__split_vma
      0.00          +4e+98%       0.00 ±300%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.01 ±279%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.00          +4e+98%       0.00 ±300%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mmap_region
      0.02 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      0.00 ±300%    +300.0%       0.00 ±152%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      7.02 ± 71%      +6.9%       7.51 ± 70%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.00 ±300%  +12440.0%       0.06 ±283%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap
      0.00          +3e+98%       0.00 ±300%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.__vma_adjust.__split_vma.mprotect_fixup
      0.00       +6.9e+100%       0.07 ±300%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.anon_vma_fork.dup_mmap.dup_mm
      0.08 ±223%     -61.3%       0.03 ±127%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process
      0.00          +4e+98%       0.00 ±300%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      0.17 ±218%     -47.0%       0.09 ±155%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap
      0.00          +8e+98%       0.00 ±200%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.unmap_region
      0.01 ±286%     -90.2%       0.00 ±157%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
      9.50 ± 65%     -10.5%       8.50 ± 73%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00 ±299%    +500.0%       0.00 ±123%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      4.38 ± 33%      -4.3%       4.19 ± 34%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
     13.48 ± 37%     +15.1%      15.51 ± 38%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      6.47 ± 58%     +45.4%       9.40 ± 47%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
      1.29 ± 50%      -9.6%       1.16 ± 66%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ±300%      +0.0%       0.00 ±300%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1.12 ± 66%     -28.0%       0.80 ±100%  perf-sched.wait_time.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.41 ± 24%     +19.3%       0.49 ± 30%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.48 ±138%     -84.9%       0.07 ±170%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.38 ±  8%      +6.4%       0.40 ±  6%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ±300%   +1200.0%       0.03 ±233%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.56 ± 30%      -5.6%       0.53 ± 36%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc
      0.00          +5e+98%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__fput.task_work_run.do_exit
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00 ±221%   +1457.1%       0.01 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.00 ±198%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.02 ±188%     -93.5%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      0.01 ±300%     +23.0%       0.01 ±269%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.swevent_hlist_put_cpu.sw_perf_event_destroy
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.task_work_run.do_exit.do_group_exit
      0.07 ± 52%     +36.0%       0.09 ± 68%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.rdmsr_safe_on_cpu.msr_read
      0.00        +1.3e+99%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      0.01 ±262%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm.proc_pid_cmdline_read
      0.00 ±300%    +366.7%       0.00 ±194%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap
      0.00 ±213%     -83.3%       0.00 ±300%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.__vma_adjust.__split_vma.mprotect_fixup
      0.00 ±300%    +860.0%       0.00 ±300%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.anon_vma_clone.anon_vma_fork.dup_mmap
      0.01 ±299%   +1318.0%       0.07 ±291%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.anon_vma_fork.dup_mmap.dup_mm
      0.04 ±257%     -27.7%       0.03 ±128%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process
      0.04 ±158%     -49.2%       0.02 ±214%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap
      0.00 ±300%     -55.6%       0.00 ±300%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.unmap_region
      0.01 ±261%     -80.6%       0.00 ±228%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
      1.44 ± 62%      +7.8%       1.56 ± 61%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      2.79 ± 36%      -9.1%       2.53 ± 38%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      2.16 ± 50%      -3.2%       2.09 ± 45%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      1.04 ± 26%     +10.1%       1.15 ± 40%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      2.57 ± 50%      -9.6%       2.33 ± 66%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ±300%      +0.0%       0.00 ±300%  perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      2.23 ± 66%     -28.0%       1.61 ±100%  perf-sched.wait_time.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      3.90 ± 55%     +18.5%       4.62 ± 45%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.58 ±140%     -76.9%       0.13 ±182%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.81 ± 10%      +4.7%       0.85 ± 15%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ±300%   +1182.2%       0.09 ±232%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.96 ± 21%      +1.8%       1.99 ± 22%  perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc
      0.00          +5e+98%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__fput.task_work_run.do_exit
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00 ±221%   +1457.1%       0.01 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.01 ±230%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.03 ±195%     -95.4%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      0.01 ±300%     +23.0%       0.01 ±269%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.swevent_hlist_put_cpu.sw_perf_event_destroy
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.task_work_run.do_exit.do_group_exit
      7.02 ± 71%      +6.9%       7.51 ± 70%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.rdmsr_safe_on_cpu.msr_read
      0.00        +1.3e+99%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      0.01 ±262%    -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.down_read_killable.__access_remote_vm.proc_pid_cmdline_read
      0.00 ±300%    +520.0%       0.00 ±211%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap
      0.00 ±213%     -75.0%       0.00 ±300%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.__vma_adjust.__split_vma.mprotect_fixup
      0.00 ±300%    +860.0%       0.00 ±300%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.anon_vma_clone.anon_vma_fork.dup_mmap
      0.01 ±299%   +1318.0%       0.07 ±291%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.anon_vma_fork.dup_mmap.dup_mm
      0.07 ±269%     -50.9%       0.03 ±110%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process
      0.06 ±138%      -5.9%       0.06 ±204%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap
      0.00 ±300%     -55.6%       0.00 ±300%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.unmap_region
      0.01 ±274%     -86.6%       0.00 ±182%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
      7.88 ± 70%      +7.9%       8.50 ± 73%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      4.38 ± 33%      -4.5%       4.18 ± 34%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     13.47 ± 37%     +14.4%      15.41 ± 39%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      6.13 ± 66%     +42.2%       8.71 ± 56%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
    194230            -0.0%     194188        slabinfo.Acpi-Operand.active_objs
      3468            -0.0%       3467        slabinfo.Acpi-Operand.active_slabs
    194231            -0.0%     194191        slabinfo.Acpi-Operand.num_objs
      3468            -0.0%       3467        slabinfo.Acpi-Operand.num_slabs
      4665            -5.7%       4398 ±  2%  slabinfo.Acpi-Parse.active_objs
     63.50            -5.8%      59.80 ±  3%  slabinfo.Acpi-Parse.active_slabs
      4665            -5.7%       4398 ±  2%  slabinfo.Acpi-Parse.num_objs
     63.50            -5.8%      59.80 ±  3%  slabinfo.Acpi-Parse.num_slabs
      4579            +1.5%       4646 ±  3%  slabinfo.Acpi-State.active_objs
     89.30            +1.3%      90.50 ±  3%  slabinfo.Acpi-State.active_slabs
      4579            +1.5%       4646 ±  3%  slabinfo.Acpi-State.num_objs
     89.30            +1.3%      90.50 ±  3%  slabinfo.Acpi-State.num_slabs
    192.00            +0.0%     192.00        slabinfo.RAW.active_objs
      6.00            +0.0%       6.00        slabinfo.RAW.active_slabs
    192.00            +0.0%     192.00        slabinfo.RAW.num_objs
      6.00            +0.0%       6.00        slabinfo.RAW.num_slabs
    104.00            +0.0%     104.00        slabinfo.RAWv6.active_objs
      4.00            +0.0%       4.00        slabinfo.RAWv6.active_slabs
    104.00            +0.0%     104.00        slabinfo.RAWv6.num_objs
      4.00            +0.0%       4.00        slabinfo.RAWv6.num_slabs
     54.60 ±  7%      +0.0%      54.60 ±  7%  slabinfo.TCP.active_objs
      3.90 ±  7%      +0.0%       3.90 ±  7%  slabinfo.TCP.active_slabs
     54.60 ±  7%      +0.0%      54.60 ±  7%  slabinfo.TCP.num_objs
      3.90 ±  7%      +0.0%       3.90 ±  7%  slabinfo.TCP.num_slabs
     37.70 ± 10%      +0.0%      37.70 ± 10%  slabinfo.TCPv6.active_objs
      2.90 ± 10%      +0.0%       2.90 ± 10%  slabinfo.TCPv6.active_slabs
     37.70 ± 10%      +0.0%      37.70 ± 10%  slabinfo.TCPv6.num_objs
      2.90 ± 10%      +0.0%       2.90 ± 10%  slabinfo.TCPv6.num_slabs
    120.00 ± 15%      +8.0%     129.60 ±  9%  slabinfo.UDPv6.active_objs
      5.00 ± 15%      +8.0%       5.40 ±  9%  slabinfo.UDPv6.active_slabs
    120.00 ± 15%      +8.0%     129.60 ±  9%  slabinfo.UDPv6.num_objs
      5.00 ± 15%      +8.0%       5.40 ±  9%  slabinfo.UDPv6.num_slabs
      1745 ± 15%      +6.0%       1850 ± 12%  slabinfo.UNIX.active_objs
     58.10 ± 16%      +5.7%      61.40 ± 12%  slabinfo.UNIX.active_slabs
      1745 ± 15%      +6.0%       1850 ± 12%  slabinfo.UNIX.num_objs
     58.10 ± 16%      +5.7%      61.40 ± 12%  slabinfo.UNIX.num_slabs
     71032 ±  2%      +0.7%      71495        slabinfo.anon_vma.active_objs
      1544 ±  2%      +0.7%       1554        slabinfo.anon_vma.active_slabs
     71051 ±  2%      +0.6%      71502        slabinfo.anon_vma.num_objs
      1544 ±  2%      +0.7%       1554        slabinfo.anon_vma.num_slabs
    152836 ±  3%      -0.6%     151975 ±  2%  slabinfo.anon_vma_chain.active_objs
      2392 ±  3%      -0.6%       2377 ±  2%  slabinfo.anon_vma_chain.active_slabs
    153159 ±  3%      -0.6%     152197 ±  2%  slabinfo.anon_vma_chain.num_objs
      2392 ±  3%      -0.6%       2377 ±  2%  slabinfo.anon_vma_chain.num_slabs
    159.60 ± 13%      -6.6%     149.10 ± 11%  slabinfo.bdev_cache.active_objs
      7.60 ± 13%      -6.6%       7.10 ± 11%  slabinfo.bdev_cache.active_slabs
    159.60 ± 13%      -6.6%     149.10 ± 11%  slabinfo.bdev_cache.num_objs
      7.60 ± 13%      -6.6%       7.10 ± 11%  slabinfo.bdev_cache.num_slabs
      2085            +8.0%       2251        slabinfo.bfq_io_cq.active_objs
     59.00            +8.5%      64.00        slabinfo.bfq_io_cq.active_slabs
      2085            +8.0%       2251        slabinfo.bfq_io_cq.num_objs
     59.00            +8.5%      64.00        slabinfo.bfq_io_cq.num_slabs
     92.40 ± 23%     +28.1%     118.40 ± 21%  slabinfo.biovec-128.active_objs
      5.70 ± 23%     +29.8%       7.40 ± 21%  slabinfo.biovec-128.active_slabs
     92.40 ± 23%     +28.1%     118.40 ± 21%  slabinfo.biovec-128.num_objs
      5.70 ± 23%     +29.8%       7.40 ± 21%  slabinfo.biovec-128.num_slabs
    310.40 ±  9%      +9.3%     339.20 ±  6%  slabinfo.biovec-64.active_objs
      9.70 ±  9%      +9.3%      10.60 ±  6%  slabinfo.biovec-64.active_slabs
    310.40 ±  9%      +9.3%     339.20 ±  6%  slabinfo.biovec-64.num_objs
      9.70 ±  9%      +9.3%      10.60 ±  6%  slabinfo.biovec-64.num_slabs
    115.00 ±  9%     +13.7%     130.80 ±  7%  slabinfo.biovec-max.active_objs
     14.20 ± 11%     +21.1%      17.20 ± 11%  slabinfo.biovec-max.active_slabs
    116.20 ±  9%     +22.2%     142.00 ± 11%  slabinfo.biovec-max.num_objs
     14.20 ± 11%     +21.1%      17.20 ± 11%  slabinfo.biovec-max.num_slabs
      3.80 ±100%     +68.4%       6.40 ±100%  slabinfo.btrfs_delayed_tree_ref.active_objs
      0.00          -100.0%       0.00        slabinfo.btrfs_delayed_tree_ref.active_slabs
      3.80 ±100%     +68.4%       6.40 ±100%  slabinfo.btrfs_delayed_tree_ref.num_objs
      0.00          -100.0%       0.00        slabinfo.btrfs_delayed_tree_ref.num_slabs
    123.40 ±  9%      +9.1%     134.60 ± 14%  slabinfo.btrfs_extent_map.active_objs
      2.00            +5.0%       2.10 ± 14%  slabinfo.btrfs_extent_map.active_slabs
    123.40 ±  9%      +9.1%     134.60 ± 14%  slabinfo.btrfs_extent_map.num_objs
      2.00            +5.0%       2.10 ± 14%  slabinfo.btrfs_extent_map.num_slabs
    100.80 ±  9%      -0.9%      99.90 ± 12%  slabinfo.btrfs_inode.active_objs
      3.40 ± 14%      -2.9%       3.30 ± 13%  slabinfo.btrfs_inode.active_slabs
    100.80 ±  9%      -0.9%      99.90 ± 12%  slabinfo.btrfs_inode.num_objs
      3.40 ± 14%      -2.9%       3.30 ± 13%  slabinfo.btrfs_inode.num_slabs
      2143            -7.9%       1972 ±  4%  slabinfo.btrfs_ordered_extent.active_objs
     56.00            -8.2%      51.40 ±  4%  slabinfo.btrfs_ordered_extent.active_slabs
      2143            -7.9%       1972 ±  4%  slabinfo.btrfs_ordered_extent.num_objs
     56.00            -8.2%      51.40 ±  4%  slabinfo.btrfs_ordered_extent.num_slabs
    425.50 ±  7%      -2.1%     416.50 ±  6%  slabinfo.buffer_head.active_objs
     10.50 ±  7%      -4.8%      10.00 ±  8%  slabinfo.buffer_head.active_slabs
    425.50 ±  7%      -2.1%     416.50 ±  6%  slabinfo.buffer_head.num_objs
     10.50 ±  7%      -4.8%      10.00 ±  8%  slabinfo.buffer_head.num_slabs
      9500            -1.3%       9373 ±  2%  slabinfo.cred_jar.active_objs
    225.80            -1.3%     222.80 ±  2%  slabinfo.cred_jar.active_slabs
      9500            -1.3%       9373 ±  2%  slabinfo.cred_jar.num_objs
    225.80            -1.3%     222.80 ±  2%  slabinfo.cred_jar.num_slabs
     42.00            +0.0%      42.00        slabinfo.dax_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.dax_cache.active_slabs
     42.00            +0.0%      42.00        slabinfo.dax_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.dax_cache.num_slabs
    152179 ±  2%      +0.4%     152802 ±  3%  slabinfo.dentry.active_objs
      3680 ±  2%      +1.0%       3715 ±  3%  slabinfo.dentry.active_slabs
    154593 ±  2%      +0.9%     156056 ±  3%  slabinfo.dentry.num_objs
      3680 ±  2%      +1.0%       3715 ±  3%  slabinfo.dentry.num_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.active_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.num_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.active_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.num_slabs
     18953 ±  7%      -2.9%      18395 ±  9%  slabinfo.ep_head.active_objs
     74.00 ±  7%      -3.0%      71.80 ±  9%  slabinfo.ep_head.active_slabs
     18953 ±  7%      -2.9%      18395 ±  9%  slabinfo.ep_head.num_objs
     74.00 ±  7%      -3.0%      71.80 ±  9%  slabinfo.ep_head.num_slabs
      1103 ±  6%      +4.0%       1147 ±  9%  slabinfo.file_lock_cache.active_objs
     29.70 ±  6%      +4.4%      31.00 ±  9%  slabinfo.file_lock_cache.active_slabs
      1103 ±  6%      +4.0%       1147 ±  9%  slabinfo.file_lock_cache.num_objs
     29.70 ±  6%      +4.4%      31.00 ±  9%  slabinfo.file_lock_cache.num_slabs
      6755 ±  2%      -0.1%       6749 ±  2%  slabinfo.files_cache.active_objs
    146.40 ±  2%      -0.2%     146.10 ±  2%  slabinfo.files_cache.active_slabs
      6755 ±  2%      -0.1%       6749 ±  2%  slabinfo.files_cache.num_objs
    146.40 ±  2%      -0.2%     146.10 ±  2%  slabinfo.files_cache.num_slabs
     24337 ±  3%      +0.7%      24496 ±  3%  slabinfo.filp.active_objs
    776.80 ±  3%      +0.7%     782.20 ±  3%  slabinfo.filp.active_slabs
     24875 ±  3%      +0.7%      25052 ±  3%  slabinfo.filp.num_objs
    776.80 ±  3%      +0.7%     782.20 ±  3%  slabinfo.filp.num_slabs
      2736 ±  7%     +11.8%       3059 ± 11%  slabinfo.fsnotify_mark_connector.active_objs
     21.30 ±  7%     +11.7%      23.80 ± 12%  slabinfo.fsnotify_mark_connector.active_slabs
      2736 ±  7%     +11.8%       3059 ± 11%  slabinfo.fsnotify_mark_connector.num_objs
     21.30 ±  7%     +11.7%      23.80 ± 12%  slabinfo.fsnotify_mark_connector.num_slabs
     32453            +0.2%      32504        slabinfo.ftrace_event_field.active_objs
    381.80            +0.2%     382.40        slabinfo.ftrace_event_field.active_slabs
     32453            +0.2%      32504        slabinfo.ftrace_event_field.num_objs
    381.80            +0.2%     382.40        slabinfo.ftrace_event_field.num_slabs
     90.10 ± 26%     +17.6%     106.00        slabinfo.hugetlbfs_inode_cache.active_objs
      1.70 ± 26%     +17.6%       2.00        slabinfo.hugetlbfs_inode_cache.active_slabs
     90.10 ± 26%     +17.6%     106.00        slabinfo.hugetlbfs_inode_cache.num_objs
      1.70 ± 26%     +17.6%       2.00        slabinfo.hugetlbfs_inode_cache.num_slabs
     86196            -0.0%      86181        slabinfo.inode_cache.active_objs
      1568            +0.0%       1568        slabinfo.inode_cache.active_slabs
     86265            +0.0%      86288        slabinfo.inode_cache.num_objs
      1568            +0.0%       1568        slabinfo.inode_cache.num_slabs
      2634            +7.9%       2842        slabinfo.ip6-frags.active_objs
     59.30            +7.9%      64.00        slabinfo.ip6-frags.active_slabs
      2634            +7.9%       2842        slabinfo.ip6-frags.num_objs
     59.30            +7.9%      64.00        slabinfo.ip6-frags.num_slabs
     82332            +0.2%      82487        slabinfo.kernfs_node_cache.active_objs
      2572            +0.2%       2577        slabinfo.kernfs_node_cache.active_slabs
     82332            +0.2%      82487        slabinfo.kernfs_node_cache.num_objs
      2572            +0.2%       2577        slabinfo.kernfs_node_cache.num_slabs
      1624 ±  9%      +7.3%       1743 ± 14%  slabinfo.khugepaged_mm_slot.active_objs
     44.50 ±  9%      +7.2%      47.70 ± 14%  slabinfo.khugepaged_mm_slot.active_slabs
      1624 ±  9%      +7.3%       1743 ± 14%  slabinfo.khugepaged_mm_slot.num_objs
     44.50 ±  9%      +7.2%      47.70 ± 14%  slabinfo.khugepaged_mm_slot.num_slabs
      5193            +0.3%       5210        slabinfo.kmalloc-128.active_objs
    162.30            +0.3%     162.80        slabinfo.kmalloc-128.active_slabs
      5212            +0.2%       5223        slabinfo.kmalloc-128.num_objs
    162.30            +0.3%     162.80        slabinfo.kmalloc-128.num_slabs
     33402            +0.7%      33622        slabinfo.kmalloc-16.active_objs
    130.60            +0.2%     130.80        slabinfo.kmalloc-16.active_slabs
     33433            +0.6%      33627        slabinfo.kmalloc-16.num_objs
    130.60            +0.2%     130.80        slabinfo.kmalloc-16.num_slabs
      5619            +2.5%       5759        slabinfo.kmalloc-192.active_objs
    135.00            +2.1%     137.90        slabinfo.kmalloc-192.active_slabs
      5691            +2.1%       5811        slabinfo.kmalloc-192.num_objs
    135.00            +2.1%     137.90        slabinfo.kmalloc-192.num_slabs
      5133 ±  2%      +3.5%       5312        slabinfo.kmalloc-1k.active_objs
    159.80 ±  2%      +3.8%     165.90        slabinfo.kmalloc-1k.active_slabs
      5135 ±  2%      +3.6%       5318        slabinfo.kmalloc-1k.num_objs
    159.80 ±  2%      +3.8%     165.90        slabinfo.kmalloc-1k.num_slabs
      9888 ±  3%      +0.9%       9980 ±  5%  slabinfo.kmalloc-256.active_objs
    309.00 ±  3%      +0.8%     311.60 ±  5%  slabinfo.kmalloc-256.active_slabs
      9900 ±  3%      +0.8%       9981 ±  5%  slabinfo.kmalloc-256.num_objs
    309.00 ±  3%      +0.8%     311.60 ±  5%  slabinfo.kmalloc-256.num_slabs
      4531 ±  4%      +6.4%       4824 ±  6%  slabinfo.kmalloc-2k.active_objs
    285.80 ±  4%      +5.8%     302.30 ±  6%  slabinfo.kmalloc-2k.active_slabs
      4582 ±  4%      +5.7%       4844 ±  6%  slabinfo.kmalloc-2k.num_objs
    285.80 ±  4%      +5.8%     302.30 ±  6%  slabinfo.kmalloc-2k.num_slabs
     76817            +0.6%      77285        slabinfo.kmalloc-32.active_objs
    600.10            +0.9%     605.70        slabinfo.kmalloc-32.active_slabs
     76874            +0.9%      77587        slabinfo.kmalloc-32.num_objs
    600.10            +0.9%     605.70        slabinfo.kmalloc-32.num_slabs
      1856           +24.9%       2318        slabinfo.kmalloc-4k.active_objs
    234.00           +25.6%     293.90        slabinfo.kmalloc-4k.active_slabs
      1875           +25.5%       2353        slabinfo.kmalloc-4k.num_objs
    234.00           +25.6%     293.90        slabinfo.kmalloc-4k.num_slabs
     22436            +6.8%      23955 ±  2%  slabinfo.kmalloc-512.active_objs
    744.80 ±  2%      +8.6%     808.80 ±  2%  slabinfo.kmalloc-512.active_slabs
     23851 ±  2%      +8.6%      25901 ±  2%  slabinfo.kmalloc-512.num_objs
    744.80 ±  2%      +8.6%     808.80 ±  2%  slabinfo.kmalloc-512.num_slabs
     51420            +0.8%      51826        slabinfo.kmalloc-64.active_objs
    805.30            +0.9%     812.60        slabinfo.kmalloc-64.active_slabs
     51566            +0.9%      52046        slabinfo.kmalloc-64.num_objs
    805.30            +0.9%     812.60        slabinfo.kmalloc-64.num_slabs
     51828            +0.3%      52009        slabinfo.kmalloc-8.active_objs
    102.10            +1.2%     103.30        slabinfo.kmalloc-8.active_slabs
     52634            +0.9%      53103        slabinfo.kmalloc-8.num_objs
    102.10            +1.2%     103.30        slabinfo.kmalloc-8.num_slabs
    916.10           +15.0%       1053        slabinfo.kmalloc-8k.active_objs
    229.90           +16.1%     266.90        slabinfo.kmalloc-8k.active_slabs
    920.40           +16.2%       1069        slabinfo.kmalloc-8k.num_objs
    229.90           +16.1%     266.90        slabinfo.kmalloc-8k.num_slabs
      7430 ±  3%      -0.6%       7388 ±  4%  slabinfo.kmalloc-96.active_objs
    178.60 ±  3%      -0.7%     177.30 ±  4%  slabinfo.kmalloc-96.active_slabs
      7526 ±  3%      -0.8%       7466 ±  4%  slabinfo.kmalloc-96.num_objs
    178.60 ±  3%      -0.7%     177.30 ±  4%  slabinfo.kmalloc-96.num_slabs
    287.90 ± 25%     -11.1%     256.00        slabinfo.kmalloc-cg-16.active_objs
      1.00            +0.0%       1.00        slabinfo.kmalloc-cg-16.active_slabs
    287.90 ± 25%     -11.1%     256.00        slabinfo.kmalloc-cg-16.num_objs
      1.00            +0.0%       1.00        slabinfo.kmalloc-cg-16.num_slabs
      3250 ±  4%      -0.6%       3232 ±  6%  slabinfo.kmalloc-cg-192.active_objs
     77.00 ±  3%      -0.6%      76.50 ±  5%  slabinfo.kmalloc-cg-192.active_slabs
      3250 ±  4%      -0.6%       3232 ±  6%  slabinfo.kmalloc-cg-192.num_objs
     77.00 ±  3%      -0.6%      76.50 ±  5%  slabinfo.kmalloc-cg-192.num_slabs
      2973 ±  3%      -1.1%       2939 ±  7%  slabinfo.kmalloc-cg-1k.active_objs
     92.30 ±  3%      -0.9%      91.50 ±  7%  slabinfo.kmalloc-cg-1k.active_slabs
      2973 ±  3%      -1.1%       2939 ±  7%  slabinfo.kmalloc-cg-1k.num_objs
     92.30 ±  3%      -0.9%      91.50 ±  7%  slabinfo.kmalloc-cg-1k.num_slabs
    494.90 ±  9%      +3.4%     511.60 ±  9%  slabinfo.kmalloc-cg-256.active_objs
     15.20 ± 11%      +2.0%      15.50 ± 10%  slabinfo.kmalloc-cg-256.active_slabs
    494.90 ±  9%      +3.4%     511.60 ±  9%  slabinfo.kmalloc-cg-256.num_objs
     15.20 ± 11%      +2.0%      15.50 ± 10%  slabinfo.kmalloc-cg-256.num_slabs
    245.00 ± 11%      +6.4%     260.70 ± 14%  slabinfo.kmalloc-cg-2k.active_objs
     14.80 ± 12%      +6.8%      15.80 ± 14%  slabinfo.kmalloc-cg-2k.active_slabs
    245.00 ± 11%      +6.4%     260.70 ± 14%  slabinfo.kmalloc-cg-2k.num_objs
     14.80 ± 12%      +6.8%      15.80 ± 14%  slabinfo.kmalloc-cg-2k.num_slabs
     10193 ±  6%      +2.1%      10409 ±  5%  slabinfo.kmalloc-cg-32.active_objs
     79.20 ±  6%      +2.1%      80.90 ±  5%  slabinfo.kmalloc-cg-32.active_slabs
     10193 ±  6%      +2.1%      10409 ±  5%  slabinfo.kmalloc-cg-32.num_objs
     79.20 ±  6%      +2.1%      80.90 ±  5%  slabinfo.kmalloc-cg-32.num_slabs
    704.00            +0.0%     704.00        slabinfo.kmalloc-cg-4k.active_objs
     88.00            +0.0%      88.00        slabinfo.kmalloc-cg-4k.active_slabs
    704.00            +0.0%     704.00        slabinfo.kmalloc-cg-4k.num_objs
     88.00            +0.0%      88.00        slabinfo.kmalloc-cg-4k.num_slabs
      2812            +0.1%       2816        slabinfo.kmalloc-cg-512.active_objs
     87.90            +0.1%      88.00        slabinfo.kmalloc-cg-512.active_slabs
      2812            +0.1%       2816        slabinfo.kmalloc-cg-512.num_objs
     87.90            +0.1%      88.00        slabinfo.kmalloc-cg-512.num_slabs
      1715 ±  7%      -2.3%       1675 ±  9%  slabinfo.kmalloc-cg-64.active_objs
     26.10 ±  7%      -2.7%      25.40 ±  9%  slabinfo.kmalloc-cg-64.active_slabs
      1715 ±  7%      -2.3%       1675 ±  9%  slabinfo.kmalloc-cg-64.num_objs
     26.10 ±  7%      -2.7%      25.40 ±  9%  slabinfo.kmalloc-cg-64.num_slabs
     47956            +0.1%      47994        slabinfo.kmalloc-cg-8.active_objs
     93.00            +0.0%      93.00        slabinfo.kmalloc-cg-8.active_slabs
     47956            +0.1%      47994        slabinfo.kmalloc-cg-8.num_objs
     93.00            +0.0%      93.00        slabinfo.kmalloc-cg-8.num_slabs
     34.20 ±  4%      +1.2%      34.60 ±  3%  slabinfo.kmalloc-cg-8k.active_objs
      7.80 ±  5%      +1.3%       7.90 ±  3%  slabinfo.kmalloc-cg-8k.active_slabs
     34.20 ±  4%      +1.2%      34.60 ±  3%  slabinfo.kmalloc-cg-8k.num_objs
      7.80 ±  5%      +1.3%       7.90 ±  3%  slabinfo.kmalloc-cg-8k.num_slabs
    354.40 ±  5%      -2.1%     347.00 ±  5%  slabinfo.kmalloc-cg-96.active_objs
      7.60 ±  6%      -2.6%       7.40 ±  6%  slabinfo.kmalloc-cg-96.active_slabs
    354.40 ±  5%      -2.1%     347.00 ±  5%  slabinfo.kmalloc-cg-96.num_objs
      7.60 ±  6%      -2.6%       7.40 ±  6%  slabinfo.kmalloc-cg-96.num_slabs
    688.00 ± 25%      +9.3%     752.00 ± 14%  slabinfo.kmalloc-rcl-128.active_objs
     21.50 ± 25%      +9.3%      23.50 ± 14%  slabinfo.kmalloc-rcl-128.active_slabs
    688.00 ± 25%      +9.3%     752.00 ± 14%  slabinfo.kmalloc-rcl-128.num_objs
     21.50 ± 25%      +9.3%      23.50 ± 14%  slabinfo.kmalloc-rcl-128.num_slabs
     42.00            +0.0%      42.00        slabinfo.kmalloc-rcl-192.active_objs
      1.00            +0.0%       1.00        slabinfo.kmalloc-rcl-192.active_slabs
     42.00            +0.0%      42.00        slabinfo.kmalloc-rcl-192.num_objs
      1.00            +0.0%       1.00        slabinfo.kmalloc-rcl-192.num_slabs
      7433 ±  4%      +3.1%       7661 ±  2%  slabinfo.kmalloc-rcl-64.active_objs
    115.70 ±  4%      +3.1%     119.30 ±  2%  slabinfo.kmalloc-rcl-64.active_slabs
      7433 ±  4%      +3.2%       7667 ±  2%  slabinfo.kmalloc-rcl-64.num_objs
    115.70 ±  4%      +3.1%     119.30 ±  2%  slabinfo.kmalloc-rcl-64.num_slabs
      2751 ±  6%      +5.3%       2898 ±  7%  slabinfo.kmalloc-rcl-96.active_objs
     65.50 ±  6%      +5.3%      69.00 ±  7%  slabinfo.kmalloc-rcl-96.active_slabs
      2751 ±  6%      +5.3%       2898 ±  7%  slabinfo.kmalloc-rcl-96.num_objs
     65.50 ±  6%      +5.3%      69.00 ±  7%  slabinfo.kmalloc-rcl-96.num_slabs
    425.60 ±  7%      +6.0%     451.20 ±  8%  slabinfo.kmem_cache.active_objs
     13.30 ±  7%      +6.0%      14.10 ±  8%  slabinfo.kmem_cache.active_slabs
    425.60 ±  7%      +6.0%     451.20 ±  8%  slabinfo.kmem_cache.num_objs
     13.30 ±  7%      +6.0%      14.10 ±  8%  slabinfo.kmem_cache.num_slabs
    883.00 ±  7%      +5.8%     934.20 ±  9%  slabinfo.kmem_cache_node.active_objs
     14.00 ±  7%      +5.7%      14.80 ±  8%  slabinfo.kmem_cache_node.active_slabs
    896.00 ±  7%      +5.7%     947.20 ±  8%  slabinfo.kmem_cache_node.num_objs
     14.00 ±  7%      +5.7%      14.80 ±  8%  slabinfo.kmem_cache_node.num_slabs
     17539            -0.3%      17491        slabinfo.lsm_file_cache.active_objs
    102.90            -0.7%     102.20        slabinfo.lsm_file_cache.active_slabs
     17539            -0.3%      17491        slabinfo.lsm_file_cache.num_objs
    102.90            -0.7%     102.20        slabinfo.lsm_file_cache.num_slabs
      5613            +0.2%       5624        slabinfo.mm_struct.active_objs
    186.70            +0.2%     187.10        slabinfo.mm_struct.active_slabs
      5613            +0.2%       5624        slabinfo.mm_struct.num_objs
    186.70            +0.2%     187.10        slabinfo.mm_struct.num_slabs
      1084 ±  9%      +6.1%       1150 ±  4%  slabinfo.mnt_cache.active_objs
     20.50 ±  9%      +5.9%      21.70 ±  3%  slabinfo.mnt_cache.active_slabs
      1084 ±  9%      +6.1%       1150 ±  4%  slabinfo.mnt_cache.num_objs
     20.50 ±  9%      +5.9%      21.70 ±  3%  slabinfo.mnt_cache.num_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.active_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.num_slabs
      2710            +5.6%       2861        slabinfo.names_cache.active_objs
    341.80            +5.4%     360.40        slabinfo.names_cache.active_slabs
      2737            +5.5%       2887        slabinfo.names_cache.num_objs
    341.80            +5.4%     360.40        slabinfo.names_cache.num_slabs
     34.00            +0.0%      34.00        slabinfo.nfs_read_data.active_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.active_slabs
     34.00            +0.0%      34.00        slabinfo.nfs_read_data.num_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.num_slabs
      3767            +6.3%       4005        slabinfo.numa_policy.active_objs
     60.30            +6.5%      64.20        slabinfo.numa_policy.active_slabs
      3767            +6.3%       4005        slabinfo.numa_policy.num_objs
     60.30            +6.5%      64.20        slabinfo.numa_policy.num_slabs
      8210 ±  4%      +0.9%       8288 ±  5%  slabinfo.pde_opener.active_objs
     80.10 ±  5%      +0.6%      80.60 ±  5%  slabinfo.pde_opener.active_slabs
      8210 ±  4%      +0.9%       8288 ±  5%  slabinfo.pde_opener.num_objs
     80.10 ±  5%      +0.6%      80.60 ±  5%  slabinfo.pde_opener.num_slabs
      3817            +0.2%       3825        slabinfo.perf_event.active_objs
    142.00            +0.1%     142.10        slabinfo.perf_event.active_slabs
      3838            +0.3%       3848        slabinfo.perf_event.num_objs
    142.00            +0.1%     142.10        slabinfo.perf_event.num_slabs
      7486 ±  2%      +0.5%       7524        slabinfo.pid.active_objs
    233.70 ±  2%      +0.5%     234.80        slabinfo.pid.active_slabs
      7489 ±  2%      +0.5%       7526        slabinfo.pid.num_objs
    233.70 ±  2%      +0.5%     234.80        slabinfo.pid.num_slabs
      1605 ±  8%      +2.3%       1643 ±  9%  slabinfo.pool_workqueue.active_objs
     50.20 ±  8%      +2.6%      51.50 ±  9%  slabinfo.pool_workqueue.active_slabs
      1627 ±  8%      +2.1%       1662 ±  9%  slabinfo.pool_workqueue.num_objs
     50.20 ±  8%      +2.6%      51.50 ±  9%  slabinfo.pool_workqueue.num_slabs
      2717            +1.2%       2751        slabinfo.proc_dir_entry.active_objs
     64.70            +1.2%      65.50        slabinfo.proc_dir_entry.active_slabs
      2717            +1.2%       2751        slabinfo.proc_dir_entry.num_objs
     64.70            +1.2%      65.50        slabinfo.proc_dir_entry.num_slabs
     34360            +5.5%      36258        slabinfo.proc_inode_cache.active_objs
    708.70            +5.1%     744.60        slabinfo.proc_inode_cache.active_slabs
     34747            +5.1%      36508        slabinfo.proc_inode_cache.num_objs
    708.70            +5.1%     744.60        slabinfo.proc_inode_cache.num_slabs
     37758            +1.5%      38334        slabinfo.radix_tree_node.active_objs
    673.90            +1.5%     684.10        slabinfo.radix_tree_node.active_slabs
     37772            +1.5%      38334        slabinfo.radix_tree_node.num_objs
    673.90            +1.5%     684.10        slabinfo.radix_tree_node.num_slabs
     54.00 ± 13%      +8.3%      58.50 ±  7%  slabinfo.request_queue.active_objs
      3.60 ± 13%      +8.3%       3.90 ±  7%  slabinfo.request_queue.active_slabs
     54.00 ± 13%      +8.3%      58.50 ±  7%  slabinfo.request_queue.num_objs
      3.60 ± 13%      +8.3%       3.90 ±  7%  slabinfo.request_queue.num_slabs
     51.00            +0.0%      51.00        slabinfo.rpc_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.active_slabs
     51.00            +0.0%      51.00        slabinfo.rpc_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.num_slabs
    640.00            +0.0%     640.00        slabinfo.scsi_sense_cache.active_objs
     20.00            +0.0%      20.00        slabinfo.scsi_sense_cache.active_slabs
    640.00            +0.0%     640.00        slabinfo.scsi_sense_cache.num_objs
     20.00            +0.0%      20.00        slabinfo.scsi_sense_cache.num_slabs
      2992            +0.0%       2992        slabinfo.seq_file.active_objs
     88.00            +0.0%      88.00        slabinfo.seq_file.active_slabs
      2992            +0.0%       2992        slabinfo.seq_file.num_objs
     88.00            +0.0%      88.00        slabinfo.seq_file.num_slabs
      4570 ±  5%      +4.4%       4773 ±  3%  slabinfo.shmem_inode_cache.active_objs
     99.20 ±  5%      +4.1%     103.30 ±  3%  slabinfo.shmem_inode_cache.active_slabs
      4570 ±  5%      +4.4%       4773 ±  3%  slabinfo.shmem_inode_cache.num_objs
     99.20 ±  5%      +4.1%     103.30 ±  3%  slabinfo.shmem_inode_cache.num_slabs
      4916            +1.0%       4966        slabinfo.sighand_cache.active_objs
    329.50            +0.6%     331.50        slabinfo.sighand_cache.active_slabs
      4949            +0.6%       4980        slabinfo.sighand_cache.num_objs
    329.50            +0.6%     331.50        slabinfo.sighand_cache.num_slabs
      7238 ±  2%      -0.6%       7191 ±  2%  slabinfo.signal_cache.active_objs
    259.10 ±  2%      -0.7%     257.20 ±  2%  slabinfo.signal_cache.active_slabs
      7269 ±  2%      -0.9%       7207 ±  2%  slabinfo.signal_cache.num_objs
    259.10 ±  2%      -0.7%     257.20 ±  2%  slabinfo.signal_cache.num_slabs
      3493 ± 14%     +48.7%       5196 ±  6%  slabinfo.skbuff_ext_cache.active_objs
     82.90 ± 15%     +48.9%     123.40 ±  6%  slabinfo.skbuff_ext_cache.active_slabs
      3493 ± 14%     +49.0%       5204 ±  6%  slabinfo.skbuff_ext_cache.num_objs
     82.90 ± 15%     +48.9%     123.40 ±  6%  slabinfo.skbuff_ext_cache.num_slabs
    246.40 ± 14%     +10.4%     272.00 ±  9%  slabinfo.skbuff_fclone_cache.active_objs
      7.70 ± 14%     +10.4%       8.50 ±  9%  slabinfo.skbuff_fclone_cache.active_slabs
    246.40 ± 14%     +10.4%     272.00 ±  9%  slabinfo.skbuff_fclone_cache.num_objs
      7.70 ± 14%     +10.4%       8.50 ±  9%  slabinfo.skbuff_fclone_cache.num_slabs
      3840 ±  6%      -7.2%       3561 ±  6%  slabinfo.skbuff_head_cache.active_objs
    120.80 ±  6%      -7.7%     111.50 ±  6%  slabinfo.skbuff_head_cache.active_slabs
      3865 ±  6%      -7.7%       3568 ±  6%  slabinfo.skbuff_head_cache.num_objs
    120.80 ±  6%      -7.7%     111.50 ±  6%  slabinfo.skbuff_head_cache.num_slabs
      2875 ± 13%      +4.5%       3005 ±  9%  slabinfo.sock_inode_cache.active_objs
     73.60 ± 13%      +4.3%      76.80 ±  9%  slabinfo.sock_inode_cache.active_slabs
      2875 ± 13%      +4.5%       3005 ±  9%  slabinfo.sock_inode_cache.num_objs
     73.60 ± 13%      +4.3%      76.80 ±  9%  slabinfo.sock_inode_cache.num_slabs
      1290 ±  7%     +10.3%       1422 ± 10%  slabinfo.task_delay_info.active_objs
     25.30 ±  7%     +10.3%      27.90 ± 10%  slabinfo.task_delay_info.active_slabs
      1290 ±  7%     +10.3%       1422 ± 10%  slabinfo.task_delay_info.num_objs
     25.30 ±  7%     +10.3%      27.90 ± 10%  slabinfo.task_delay_info.num_slabs
      1384 ±  7%      -6.4%       1296 ±  9%  slabinfo.task_group.active_objs
     29.50 ±  7%      -6.1%      27.70 ± 10%  slabinfo.task_group.active_slabs
      1384 ±  7%      -6.4%       1296 ±  9%  slabinfo.task_group.num_objs
     29.50 ±  7%      -6.1%      27.70 ± 10%  slabinfo.task_group.num_slabs
      4014            +0.5%       4032        slabinfo.task_struct.active_objs
      4019            +0.4%       4036        slabinfo.task_struct.active_slabs
      4019            +0.4%       4036        slabinfo.task_struct.num_objs
      4019            +0.4%       4036        slabinfo.task_struct.num_slabs
    291.30 ±  9%      -4.3%     278.90 ±  9%  slabinfo.taskstats.active_objs
      6.20 ±  9%      -6.5%       5.80 ± 10%  slabinfo.taskstats.active_slabs
    291.30 ±  9%      -4.3%     278.90 ±  9%  slabinfo.taskstats.num_objs
      6.20 ±  9%      -6.5%       5.80 ± 10%  slabinfo.taskstats.num_slabs
      4004 ±  2%      +1.0%       4046 ±  2%  slabinfo.trace_event_file.active_objs
     86.60 ±  2%      +0.9%      87.40 ±  2%  slabinfo.trace_event_file.active_slabs
      4004 ±  2%      +1.0%       4046 ±  2%  slabinfo.trace_event_file.num_objs
     86.60 ±  2%      +0.9%      87.40 ±  2%  slabinfo.trace_event_file.num_slabs
     33.00            +0.0%      33.00        slabinfo.tw_sock_TCP.active_objs
      1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.active_slabs
     33.00            +0.0%      33.00        slabinfo.tw_sock_TCP.num_objs
      1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.num_slabs
    150338 ±  2%      -0.5%     149558 ±  2%  slabinfo.vm_area_struct.active_objs
      3767 ±  2%      -0.6%       3744 ±  2%  slabinfo.vm_area_struct.active_slabs
    150713 ±  2%      -0.6%     149791 ±  2%  slabinfo.vm_area_struct.num_objs
      3767 ±  2%      -0.6%       3744 ±  2%  slabinfo.vm_area_struct.num_slabs
     17747            +1.0%      17921        slabinfo.vmap_area.active_objs
    277.10            +1.2%     280.30        slabinfo.vmap_area.active_slabs
     17763            +1.2%      17970        slabinfo.vmap_area.num_objs
    277.10            +1.2%     280.30        slabinfo.vmap_area.num_slabs
     42.00            +0.0%      42.00        slabinfo.xfrm_state.active_objs
      1.00            +0.0%       1.00        slabinfo.xfrm_state.active_slabs
     42.00            +0.0%      42.00        slabinfo.xfrm_state.num_objs
      1.00            +0.0%       1.00        slabinfo.xfrm_state.num_slabs
      2163            +7.8%       2331        slabinfo.xfs_btree_cur.active_objs
     59.60            +7.4%      64.00        slabinfo.xfs_btree_cur.active_slabs
      2163            +7.8%       2331        slabinfo.xfs_btree_cur.num_objs
     59.60            +7.4%      64.00        slabinfo.xfs_btree_cur.num_slabs
      2453           -12.8%       2140 ±  6%  slabinfo.xfs_buf.active_objs
     57.90           -12.8%      50.50 ±  6%  slabinfo.xfs_buf.active_slabs
      2453           -12.8%       2140 ±  6%  slabinfo.xfs_buf.num_objs
     57.90           -12.8%      50.50 ±  6%  slabinfo.xfs_buf.num_slabs
      1994            +8.2%       2157        slabinfo.xfs_da_state.active_objs
     58.00            +8.6%      63.00        slabinfo.xfs_da_state.active_slabs
      1994            +8.2%       2157        slabinfo.xfs_da_state.num_objs
     58.00            +8.6%      63.00        slabinfo.xfs_da_state.num_slabs
      2086            -7.9%       1921 ±  4%  slabinfo.xfs_efd_item.active_objs
     56.00            -8.2%      51.40 ±  4%  slabinfo.xfs_efd_item.active_slabs
      2086            -7.9%       1921 ±  4%  slabinfo.xfs_efd_item.num_objs
     56.00            -8.2%      51.40 ±  4%  slabinfo.xfs_efd_item.num_slabs
      2540 ±  2%     -26.6%       1865 ±  7%  slabinfo.xfs_icr.active_objs
     54.70 ±  2%     -26.7%      40.10 ±  7%  slabinfo.xfs_icr.active_slabs
      2540 ±  2%     -26.6%       1865 ±  7%  slabinfo.xfs_icr.num_objs
     54.70 ±  2%     -26.7%      40.10 ±  7%  slabinfo.xfs_icr.num_slabs
      3837 ±  5%     +25.1%       4801 ±  2%  slabinfo.xfs_ili.active_objs
     97.10 ±  8%     +21.1%     117.60 ±  3%  slabinfo.xfs_ili.active_slabs
      4104 ±  8%     +20.8%       4958 ±  3%  slabinfo.xfs_ili.num_objs
     97.10 ±  8%     +21.1%     117.60 ±  3%  slabinfo.xfs_ili.num_slabs
      3252 ±  5%     +33.1%       4329 ±  3%  slabinfo.xfs_inode.active_objs
    107.50 ±  8%     +25.5%     134.90 ±  3%  slabinfo.xfs_inode.active_slabs
      3669 ±  8%     +25.5%       4605 ±  3%  slabinfo.xfs_inode.num_objs
    107.50 ±  8%     +25.5%     134.90 ±  3%  slabinfo.xfs_inode.num_slabs
    425.00            +0.4%     426.80        softirqs.BLOCK
     11.80 ± 99%     -42.4%       6.80 ± 93%  softirqs.CPU0.BLOCK
      1.00            +0.0%       1.00        softirqs.CPU0.HI
      5.50 ±184%    +594.5%      38.20 ±286%  softirqs.CPU0.NET_RX
      1.90 ±136%     -15.8%       1.60 ±185%  softirqs.CPU0.NET_TX
      9060 ± 11%      +4.6%       9476 ±  4%  softirqs.CPU0.RCU
     10808 ± 10%      +5.1%      11362 ± 11%  softirqs.CPU0.SCHED
    107.20 ±  5%      -2.1%     105.00        softirqs.CPU0.TASKLET
    524.70 ± 53%      +3.5%     543.00 ± 28%  softirqs.CPU0.TIMER
     11.60 ± 94%     -62.1%       4.40 ±155%  softirqs.CPU1.BLOCK
      0.80 ±122%      +0.0%       0.80 ±156%  softirqs.CPU1.NET_RX
      1.30 ±200%     -76.9%       0.30 ±152%  softirqs.CPU1.NET_TX
      8200 ± 14%      -1.7%       8062 ± 10%  softirqs.CPU1.RCU
      8657 ± 11%     +10.2%       9536 ± 11%  softirqs.CPU1.SCHED
      0.90 ±144%    +122.2%       2.00 ±220%  softirqs.CPU1.TASKLET
    290.50 ±133%      -1.8%     285.40 ±194%  softirqs.CPU1.TIMER
      0.00       +3.2e+102%       3.20 ±156%  softirqs.CPU10.BLOCK
      1.30 ± 35%      +7.7%       1.40 ± 34%  softirqs.CPU10.HI
     37.70 ±298%      -7.2%      35.00 ±287%  softirqs.CPU10.NET_RX
      0.20 ±300%     -50.0%       0.10 ±300%  softirqs.CPU10.NET_TX
      6207 ±  6%     +20.8%       7498 ±  5%  softirqs.CPU10.RCU
      6531 ±  4%     +16.2%       7588 ±  6%  softirqs.CPU10.SCHED
     37.00 ±  4%     +10.8%      41.00 ± 25%  softirqs.CPU10.TASKLET
     81.70 ± 25%     +77.1%     144.70 ± 84%  softirqs.CPU10.TIMER
      0.20 ±200%   +1900.0%       4.00 ±283%  softirqs.CPU11.BLOCK
      1.70 ±242%     -41.2%       1.00 ±148%  softirqs.CPU11.NET_RX
      0.50 ±204%     -40.0%       0.30 ±152%  softirqs.CPU11.NET_TX
      6633 ± 11%     +11.5%       7397 ±  3%  softirqs.CPU11.RCU
      6653 ±  6%     +15.3%       7668 ±  4%  softirqs.CPU11.SCHED
      0.20 ±300%    +150.0%       0.50 ±204%  softirqs.CPU11.TASKLET
    109.70 ± 40%    +184.8%     312.40 ±206%  softirqs.CPU11.TIMER
      4.40 ±204%     -79.5%       0.90 ±300%  softirqs.CPU12.BLOCK
     11.30 ±291%     -92.9%       0.80 ±222%  softirqs.CPU12.NET_RX
      0.10 ±300%    +100.0%       0.20 ±300%  softirqs.CPU12.NET_TX
      6638 ±  6%     +15.8%       7687 ± 11%  softirqs.CPU12.RCU
      6907 ±  7%     +12.4%       7763 ±  3%  softirqs.CPU12.SCHED
      0.70 ±300%    -100.0%       0.00        softirqs.CPU12.TASKLET
     92.10 ± 40%     +49.3%     137.50 ± 82%  softirqs.CPU12.TIMER
      0.40 ±200%    -100.0%       0.00        softirqs.CPU13.BLOCK
      1.70 ±146%     -52.9%       0.80 ±156%  softirqs.CPU13.NET_RX
      0.40 ±122%     -75.0%       0.10 ±300%  softirqs.CPU13.NET_TX
      6744 ± 28%      +8.2%       7301 ±  7%  softirqs.CPU13.RCU
      6670 ± 10%     +14.2%       7615 ±  8%  softirqs.CPU13.SCHED
      2.30 ± 39%    +195.7%       6.80 ±141%  softirqs.CPU13.TASKLET
    190.80 ±168%     -50.4%      94.60 ± 50%  softirqs.CPU13.TIMER
      4.80 ±225%     -87.5%       0.60 ±300%  softirqs.CPU14.BLOCK
    268.90 ±297%     -99.5%       1.40 ±111%  softirqs.CPU14.NET_RX
      0.20 ±200%    -100.0%       0.00        softirqs.CPU14.NET_TX
      6190 ±  6%     +15.5%       7152 ±  4%  softirqs.CPU14.RCU
      6883 ±  9%     +10.0%       7571 ±  3%  softirqs.CPU14.SCHED
      1.80 ± 33%     +44.4%       2.60 ± 57%  softirqs.CPU14.TASKLET
     76.90 ± 33%     +18.2%      90.90 ± 23%  softirqs.CPU14.TIMER
      2.20 ±226%     -50.0%       1.10 ±110%  softirqs.CPU15.NET_RX
      0.20 ±200%     -50.0%       0.10 ±300%  softirqs.CPU15.NET_TX
      6494 ±  7%     +13.9%       7398 ±  5%  softirqs.CPU15.RCU
      6772 ±  6%      +8.3%       7331 ±  9%  softirqs.CPU15.SCHED
      2.00           +10.0%       2.20 ± 18%  softirqs.CPU15.TASKLET
    293.90 ±214%     -47.7%     153.70 ±107%  softirqs.CPU15.TIMER
      0.80 ±300%      +0.0%       0.80 ±300%  softirqs.CPU16.BLOCK
      0.70 ± 91%     +42.9%       1.00 ±118%  softirqs.CPU16.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU16.NET_TX
      6299 ±  7%     +17.5%       7399 ±  6%  softirqs.CPU16.RCU
      6669 ±  5%      +8.9%       7262 ± 12%  softirqs.CPU16.SCHED
      2.40 ± 33%     -16.7%       2.00        softirqs.CPU16.TASKLET
    122.80 ± 60%     +13.2%     139.00 ± 80%  softirqs.CPU16.TIMER
      0.20 ±300%    -100.0%       0.00        softirqs.CPU17.BLOCK
      2.20 ±121%     -13.6%       1.90 ±129%  softirqs.CPU17.NET_RX
      0.20 ±200%      +0.0%       0.20 ±200%  softirqs.CPU17.NET_TX
      6407 ±  6%     +19.1%       7629 ±  7%  softirqs.CPU17.RCU
      6770 ±  2%     +14.1%       7725 ±  7%  softirqs.CPU17.SCHED
      2.60 ± 97%     -50.0%       1.30 ± 69%  softirqs.CPU17.TASKLET
     99.80 ± 79%    +254.3%     353.60 ±178%  softirqs.CPU17.TIMER
     21.70 ±188%    +204.6%      66.10 ±121%  softirqs.CPU18.BLOCK
      1.20 ±192%     +25.0%       1.50 ±213%  softirqs.CPU18.NET_RX
      0.30 ±152%     -33.3%       0.20 ±200%  softirqs.CPU18.NET_TX
      6634 ± 11%      +7.3%       7120 ±  3%  softirqs.CPU18.RCU
      6673 ±  6%     +10.7%       7385 ±  4%  softirqs.CPU18.SCHED
      0.80 ±122%     -12.5%       0.70 ±128%  softirqs.CPU18.TASKLET
    117.00 ± 75%     -22.2%      91.00 ± 21%  softirqs.CPU18.TIMER
     83.00 ±123%     -31.1%      57.20 ±146%  softirqs.CPU19.BLOCK
      0.60 ±110%    +166.7%       1.60 ±172%  softirqs.CPU19.NET_RX
      0.20 ±200%      +0.0%       0.20 ±200%  softirqs.CPU19.NET_TX
      6445 ±  6%     +18.1%       7611 ±  6%  softirqs.CPU19.RCU
      6609 ±  4%      +9.1%       7209 ±  9%  softirqs.CPU19.SCHED
      0.20 ±300%    +100.0%       0.40 ±200%  softirqs.CPU19.TASKLET
     98.50 ± 32%     +17.4%     115.60 ± 38%  softirqs.CPU19.TIMER
      3.40 ±246%     -11.8%       3.00 ±300%  softirqs.CPU2.BLOCK
     10.70 ±278%    +165.4%      28.40 ±265%  softirqs.CPU2.NET_RX
      0.70 ±300%     -71.4%       0.20 ±200%  softirqs.CPU2.NET_TX
      7060 ± 10%     +14.8%       8108 ±  6%  softirqs.CPU2.RCU
      7338 ±  7%      +9.5%       8034 ±  4%  softirqs.CPU2.SCHED
      0.10 ±300%    -100.0%       0.00        softirqs.CPU2.TASKLET
    126.50 ± 61%     -29.3%      89.40 ± 21%  softirqs.CPU2.TIMER
     93.00 ±145%     -72.5%      25.60 ±150%  softirqs.CPU20.BLOCK
      0.80 ±183%    +150.0%       2.00 ±237%  softirqs.CPU20.NET_RX
      0.20 ±200%     -50.0%       0.10 ±300%  softirqs.CPU20.NET_TX
      6491 ±  9%     +17.0%       7598 ± 11%  softirqs.CPU20.RCU
      6804 ±  5%     +10.5%       7519 ±  2%  softirqs.CPU20.SCHED
      0.70 ±300%     -71.4%       0.20 ±300%  softirqs.CPU20.TASKLET
    122.40 ± 79%      +3.4%     126.60 ± 69%  softirqs.CPU20.TIMER
      1.40 ±209%    -100.0%       0.00        softirqs.CPU21.BLOCK
      9.10 ±285%    +156.0%      23.30 ±292%  softirqs.CPU21.NET_RX
      0.40 ±200%     -75.0%       0.10 ±300%  softirqs.CPU21.NET_TX
      6627 ± 11%     +11.9%       7418 ±  5%  softirqs.CPU21.RCU
      6724 ± 11%     +12.7%       7581 ±  4%  softirqs.CPU21.SCHED
      0.20 ±300%      +0.0%       0.20 ±300%  softirqs.CPU21.TASKLET
    209.30 ±144%     -56.6%      90.90 ± 24%  softirqs.CPU21.TIMER
      0.10 ±300%  +10300.0%      10.40 ±153%  softirqs.CPU22.BLOCK
      9.00          +114.4%      19.30 ±151%  softirqs.CPU22.NET_RX
      2.70 ±100%     -40.7%       1.60 ±112%  softirqs.CPU22.NET_TX
      6154 ±  5%     +24.5%       7659 ±  8%  softirqs.CPU22.RCU
      6599 ±  5%     +16.2%       7667 ±  3%  softirqs.CPU22.SCHED
      0.00         +1e+102%       1.00 ±300%  softirqs.CPU22.TASKLET
    197.30 ± 56%     +79.1%     353.40 ± 64%  softirqs.CPU22.TIMER
      3.30 ±261%    -100.0%       0.00        softirqs.CPU23.BLOCK
      0.00       +1.5e+102%       1.50 ±200%  softirqs.CPU23.NET_RX
      0.00         +9e+101%       0.90 ±230%  softirqs.CPU23.NET_TX
      6352 ± 10%     +20.4%       7645 ±  7%  softirqs.CPU23.RCU
      7220 ± 17%     +12.1%       8097 ±  9%  softirqs.CPU23.SCHED
      0.00         +2e+101%       0.20 ±300%  softirqs.CPU23.TASKLET
    703.70 ±141%     +21.0%     851.20 ± 96%  softirqs.CPU23.TIMER
      0.40 ±200%   +2150.0%       9.00 ±300%  softirqs.CPU24.BLOCK
      3.40 ±159%    +888.2%      33.60 ±297%  softirqs.CPU24.NET_RX
      0.10 ±300%    +900.0%       1.00 ±268%  softirqs.CPU24.NET_TX
      6279 ± 17%     +16.2%       7296 ±  7%  softirqs.CPU24.RCU
      6483 ±  5%     +18.6%       7688 ±  8%  softirqs.CPU24.SCHED
      1.80 ± 33%     +50.0%       2.70 ± 77%  softirqs.CPU24.TASKLET
    226.70 ±159%     +59.5%     361.50 ±157%  softirqs.CPU24.TIMER
      6.10 ±294%     -50.8%       3.00 ±300%  softirqs.CPU25.BLOCK
     30.50 ±291%    -100.0%       0.00        softirqs.CPU25.NET_RX
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU25.NET_TX
      6020 ±  4%     +18.2%       7115 ±  5%  softirqs.CPU25.RCU
      6653 ±  8%     +11.6%       7423 ±  3%  softirqs.CPU25.SCHED
      1.80 ± 33%     +22.2%       2.20 ± 27%  softirqs.CPU25.TASKLET
    235.20 ±211%     -61.2%      91.20 ± 40%  softirqs.CPU25.TIMER
      0.10 ±300%   +2700.0%       2.80 ±300%  softirqs.CPU26.BLOCK
      1.50 ±278%    +133.3%       3.50 ±281%  softirqs.CPU26.NET_RX
      5917 ±  4%     +20.2%       7110 ±  6%  softirqs.CPU26.RCU
      6515 ±  2%     +12.3%       7316 ±  3%  softirqs.CPU26.SCHED
      2.00           -10.0%       1.80 ± 33%  softirqs.CPU26.TASKLET
    115.80 ±101%     +11.3%     128.90 ± 96%  softirqs.CPU26.TIMER
      0.00       +4.7e+102%       4.70 ±300%  softirqs.CPU27.BLOCK
      0.00         +4e+101%       0.40 ±300%  softirqs.CPU27.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU27.NET_TX
      5888 ±  6%     +19.0%       7006 ±  4%  softirqs.CPU27.RCU
      6536 ±  2%     +15.0%       7518 ±  6%  softirqs.CPU27.SCHED
      2.40 ± 50%    +112.5%       5.10 ±138%  softirqs.CPU27.TASKLET
     62.20 ± 46%    +333.4%     269.60 ±201%  softirqs.CPU27.TIMER
      1.70 ±300%     +76.5%       3.00 ±278%  softirqs.CPU28.BLOCK
     68.10 ±248%   +3781.4%       2643 ±299%  softirqs.CPU28.NET_RX
      5932 ±  3%     +19.6%       7093 ±  5%  softirqs.CPU28.RCU
      6526 ±  4%     +15.5%       7535 ±  8%  softirqs.CPU28.SCHED
      1.60 ± 50%     +68.8%       2.70 ± 77%  softirqs.CPU28.TASKLET
     65.30 ± 26%     +34.5%      87.80 ± 24%  softirqs.CPU28.TIMER
      3.90 ±222%    +176.9%      10.80 ±217%  softirqs.CPU29.BLOCK
     14.70 ±245%     -95.9%       0.60 ±249%  softirqs.CPU29.NET_RX
      0.10 ±300%      +0.0%       0.10 ±300%  softirqs.CPU29.NET_TX
      5868 ±  4%     +18.8%       6970 ±  3%  softirqs.CPU29.RCU
      6557 ±  3%     +13.0%       7411 ±  2%  softirqs.CPU29.SCHED
      2.00           +25.0%       2.50 ± 60%  softirqs.CPU29.TASKLET
    119.50 ±119%     -16.0%     100.40 ± 42%  softirqs.CPU29.TIMER
      3.40 ±182%     -58.8%       1.40 ±255%  softirqs.CPU3.BLOCK
      5.60 ±264%     +76.8%       9.90 ±276%  softirqs.CPU3.NET_RX
      0.30 ±152%    +166.7%       0.80 ±261%  softirqs.CPU3.NET_TX
      7086 ± 19%      +9.4%       7755 ± 10%  softirqs.CPU3.RCU
      6959 ± 11%     +15.4%       8034 ±  7%  softirqs.CPU3.SCHED
      1.10 ±201%     -54.5%       0.50 ±300%  softirqs.CPU3.TASKLET
    190.60 ±167%     -37.8%     118.50 ± 84%  softirqs.CPU3.TIMER
      0.10 ±300%   +5700.0%       5.80 ±200%  softirqs.CPU30.BLOCK
      1.10 ±224%     +45.5%       1.60 ±300%  softirqs.CPU30.NET_RX
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU30.NET_TX
      5987 ±  5%     +19.1%       7129 ±  4%  softirqs.CPU30.RCU
      6474 ±  2%     +13.2%       7328 ±  3%  softirqs.CPU30.SCHED
      2.00           +85.0%       3.70 ±120%  softirqs.CPU30.TASKLET
     81.30 ± 92%     +39.5%     113.40 ± 87%  softirqs.CPU30.TIMER
      0.10 ±300%    -100.0%       0.00        softirqs.CPU31.BLOCK
    254.70 ±299%    -100.0%       0.10 ±300%  softirqs.CPU31.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU31.NET_TX
      6074 ± 12%     +16.1%       7050 ±  5%  softirqs.CPU31.RCU
      6714 ± 12%     +11.5%       7486 ±  5%  softirqs.CPU31.SCHED
      1.80 ± 33%    +277.8%       6.80 ±141%  softirqs.CPU31.TASKLET
     68.30 ± 22%    +226.9%     223.30 ±205%  softirqs.CPU31.TIMER
     13.30 ±172%    -100.0%       0.00        softirqs.CPU32.BLOCK
     20.80 ±298%    +151.4%      52.30 ±293%  softirqs.CPU32.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU32.NET_TX
      6073 ±  7%     +17.0%       7104 ±  4%  softirqs.CPU32.RCU
      6594 ±  6%     +11.0%       7317 ±  2%  softirqs.CPU32.SCHED
      1.00 ±100%     -80.0%       0.20 ±300%  softirqs.CPU32.TASKLET
     73.00 ± 37%      +6.4%      77.70 ± 23%  softirqs.CPU32.TIMER
      4.50 ±300%      -4.4%       4.30 ±284%  softirqs.CPU33.BLOCK
      0.10 ±300%   +1100.0%       1.20 ±300%  softirqs.CPU33.NET_RX
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU33.NET_TX
      5880 ±  5%     +22.5%       7200 ±  8%  softirqs.CPU33.RCU
      6424           +14.0%       7322 ±  2%  softirqs.CPU33.SCHED
      2.00 ±300%     -90.0%       0.20 ±300%  softirqs.CPU33.TASKLET
     66.50 ± 24%     +41.4%      94.00 ± 33%  softirqs.CPU33.TIMER
     15.40 ±209%    -100.0%       0.00        softirqs.CPU34.BLOCK
      0.90 ±265%   +3411.1%      31.60 ±300%  softirqs.CPU34.NET_RX
      0.00         +8e+101%       0.80 ±300%  softirqs.CPU34.NET_TX
      6064 ±  6%     +18.1%       7163 ±  5%  softirqs.CPU34.RCU
      6456 ±  8%     +13.6%       7334 ±  4%  softirqs.CPU34.SCHED
      0.00         +2e+101%       0.20 ±300%  softirqs.CPU34.TASKLET
    253.60 ±205%     -66.8%      84.30 ± 26%  softirqs.CPU34.TIMER
      0.00       +7.7e+102%       7.70 ±201%  softirqs.CPU35.BLOCK
      1.00 ±300%     -90.0%       0.10 ±300%  softirqs.CPU35.NET_RX
      5938 ±  4%     +21.7%       7226 ±  8%  softirqs.CPU35.RCU
      6456           +14.5%       7391 ±  3%  softirqs.CPU35.SCHED
      1.30 ±300%    -100.0%       0.00        softirqs.CPU35.TASKLET
     65.40 ± 34%     +22.6%      80.20 ± 44%  softirqs.CPU35.TIMER
      0.00       +5.7e+102%       5.70 ±200%  softirqs.CPU36.BLOCK
      1.30 ±275%      +0.0%       1.30 ±233%  softirqs.CPU36.NET_RX
      5895 ±  5%     +20.3%       7090 ±  4%  softirqs.CPU36.RCU
      6482 ±  3%     +14.1%       7397 ±  3%  softirqs.CPU36.SCHED
    178.20 ±118%     -51.3%      86.70 ± 34%  softirqs.CPU36.TIMER
      4.80 ±210%     -41.7%       2.80 ±300%  softirqs.CPU37.BLOCK
      9.50 ±296%     -77.9%       2.10 ±206%  softirqs.CPU37.NET_RX
      0.00         +2e+101%       0.20 ±200%  softirqs.CPU37.NET_TX
      6224 ±  9%     +13.6%       7067 ±  2%  softirqs.CPU37.RCU
      6656 ±  5%     +10.5%       7355 ±  2%  softirqs.CPU37.SCHED
      0.70 ±255%    -100.0%       0.00        softirqs.CPU37.TASKLET
     70.50 ± 32%      +0.6%      70.90 ± 27%  softirqs.CPU37.TIMER
      0.00       +2.7e+102%       2.70 ±287%  softirqs.CPU38.BLOCK
      0.10 ±300%  +1.7e+05%     172.10 ±294%  softirqs.CPU38.NET_RX
      6066 ±  9%     +15.8%       7025 ±  4%  softirqs.CPU38.RCU
      6752 ±  9%      +7.5%       7260 ±  2%  softirqs.CPU38.SCHED
      0.80 ±300%     +37.5%       1.10 ±299%  softirqs.CPU38.TASKLET
    436.50 ±171%     -81.1%      82.70 ± 29%  softirqs.CPU38.TIMER
      0.00         +3e+101%       0.30 ±213%  softirqs.CPU39.BLOCK
     25.40 ±289%     -98.8%       0.30 ±300%  softirqs.CPU39.NET_RX
      0.10 ±300%    -100.0%       0.00        softirqs.CPU39.NET_TX
      5845 ±  4%     +22.5%       7162 ±  7%  softirqs.CPU39.RCU
      6456           +15.6%       7466 ±  4%  softirqs.CPU39.SCHED
      0.00         +7e+101%       0.70 ±300%  softirqs.CPU39.TASKLET
     72.50 ± 33%    +191.2%     211.10 ±208%  softirqs.CPU39.TIMER
      3.40 ±129%    +135.3%       8.00 ±163%  softirqs.CPU4.BLOCK
      6.30 ±199%    +555.6%      41.30 ±257%  softirqs.CPU4.NET_RX
      0.30 ±152%     -66.7%       0.10 ±300%  softirqs.CPU4.NET_TX
      6585 ±  6%     +14.7%       7552 ±  5%  softirqs.CPU4.RCU
      7005 ±  5%     +12.7%       7897 ±  4%  softirqs.CPU4.SCHED
      1.40 ±237%     -92.9%       0.10 ±300%  softirqs.CPU4.TASKLET
    107.30 ± 44%      -2.9%     104.20 ± 29%  softirqs.CPU4.TIMER
      0.00       +7.6e+102%       7.60 ±205%  softirqs.CPU40.BLOCK
     32.00 ±270%     -91.6%       2.70 ± 87%  softirqs.CPU40.NET_RX
      0.10 ±300%    +100.0%       0.20 ±200%  softirqs.CPU40.NET_TX
      6006 ±  4%     +19.1%       7155 ±  5%  softirqs.CPU40.RCU
      6721 ± 10%     +10.5%       7426 ±  2%  softirqs.CPU40.SCHED
     54.30 ± 21%     +51.6%      82.30 ± 27%  softirqs.CPU40.TIMER
      2.80 ±300%    -100.0%       0.00        softirqs.CPU41.BLOCK
      1.40 ±221%   +1285.7%      19.40 ±300%  softirqs.CPU41.NET_RX
      0.20 ±300%    -100.0%       0.00        softirqs.CPU41.NET_TX
      6152 ±  7%     +13.3%       6968 ±  6%  softirqs.CPU41.RCU
      6938 ± 10%      +4.4%       7241 ±  3%  softirqs.CPU41.SCHED
      0.00       +1.8e+102%       1.80 ±300%  softirqs.CPU41.TASKLET
    522.30 ±192%     -88.9%      58.10 ± 23%  softirqs.CPU41.TIMER
      0.00       +2.9e+102%       2.90 ±299%  softirqs.CPU42.BLOCK
      0.10 ±300%   +4100.0%       4.20 ±204%  softirqs.CPU42.NET_RX
      0.00         +2e+101%       0.20 ±300%  softirqs.CPU42.NET_TX
      6000 ±  7%     +20.1%       7207 ±  4%  softirqs.CPU42.RCU
      6557 ±  2%     +13.4%       7433 ±  2%  softirqs.CPU42.SCHED
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU42.TASKLET
     64.60 ± 31%     +26.6%      81.80 ± 21%  softirqs.CPU42.TIMER
      0.00       +5.7e+102%       5.70 ±191%  softirqs.CPU43.BLOCK
      0.50 ±300%    +280.0%       1.90 ±300%  softirqs.CPU43.NET_RX
      0.10 ±300%    +200.0%       0.30 ±213%  softirqs.CPU43.NET_TX
      6237 ±  6%     +17.1%       7305 ±  5%  softirqs.CPU43.RCU
      5994 ± 13%     +15.9%       6945 ±  6%  softirqs.CPU43.SCHED
      0.00       +1.8e+102%       1.80 ±265%  softirqs.CPU43.TASKLET
    211.90 ±208%     -57.2%      90.70 ± 54%  softirqs.CPU43.TIMER
      2.80 ±166%     +71.4%       4.80 ±178%  softirqs.CPU44.BLOCK
      1.30 ±178%     -46.2%       0.70 ± 91%  softirqs.CPU44.NET_RX
      1.60 ±185%     -37.5%       1.00 ±204%  softirqs.CPU44.NET_TX
      5831 ± 15%      +8.4%       6323 ±  7%  softirqs.CPU44.RCU
      6434 ± 14%     +14.5%       7364 ±  8%  softirqs.CPU44.SCHED
      1.80 ±300%     -94.4%       0.10 ±300%  softirqs.CPU44.TASKLET
    452.30 ±139%     -24.2%     342.70 ±179%  softirqs.CPU44.TIMER
      2.20 ±209%     +77.3%       3.90 ±275%  softirqs.CPU45.BLOCK
      2.50 ±203%   +1884.0%      49.60 ±279%  softirqs.CPU45.NET_RX
      0.00         +5e+101%       0.50 ±134%  softirqs.CPU45.NET_TX
      6395 ± 10%     +12.0%       7161 ±  5%  softirqs.CPU45.RCU
      6398 ± 14%     +15.3%       7376 ± 12%  softirqs.CPU45.SCHED
      1.00 ±300%     -90.0%       0.10 ±300%  softirqs.CPU45.TASKLET
    230.40 ±194%     +18.8%     273.80 ±205%  softirqs.CPU45.TIMER
      3.80 ±282%    -100.0%       0.00        softirqs.CPU46.BLOCK
      1.20 ±177%     +50.0%       1.80 ±148%  softirqs.CPU46.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU46.NET_TX
      6535 ±  9%     +12.1%       7323 ±  7%  softirqs.CPU46.RCU
      6222 ± 10%     +11.4%       6932 ±  7%  softirqs.CPU46.SCHED
      3.10 ±268%     -83.9%       0.50 ±134%  softirqs.CPU46.TASKLET
    115.10 ± 80%     -16.8%      95.80 ± 38%  softirqs.CPU46.TIMER
      1.40 ±166%     -14.3%       1.20 ±273%  softirqs.CPU47.BLOCK
     41.90 ±295%     -98.1%       0.80 ±145%  softirqs.CPU47.NET_RX
      0.20 ±200%     -50.0%       0.10 ±300%  softirqs.CPU47.NET_TX
      6514 ± 11%     +17.8%       7676 ± 14%  softirqs.CPU47.RCU
      6575 ±  8%     +13.2%       7441 ± 10%  softirqs.CPU47.SCHED
      0.20 ±200%    +150.0%       0.50 ±300%  softirqs.CPU47.TASKLET
     95.50 ± 97%    +269.3%     352.70 ±145%  softirqs.CPU47.TIMER
      0.70 ±255%   +1000.0%       7.70 ±102%  softirqs.CPU48.BLOCK
     10.80 ±287%     -67.6%       3.50 ±152%  softirqs.CPU48.NET_RX
      0.20 ±200%    +100.0%       0.40 ±122%  softirqs.CPU48.NET_TX
      6331 ±  9%     +17.3%       7427 ±  6%  softirqs.CPU48.RCU
      6831 ±  4%      +7.6%       7354 ±  4%  softirqs.CPU48.SCHED
      0.20 ±200%    -100.0%       0.00        softirqs.CPU48.TASKLET
    129.70 ± 82%     -34.4%      85.10 ± 21%  softirqs.CPU48.TIMER
      2.70 ±300%    -100.0%       0.00        softirqs.CPU49.BLOCK
      0.60 ± 81%  +22866.7%     137.80 ±293%  softirqs.CPU49.NET_RX
      0.30 ±152%     +33.3%       0.40 ±122%  softirqs.CPU49.NET_TX
      6350 ±  9%     +38.0%       8762 ± 17%  softirqs.CPU49.RCU
      6063 ± 16%     +25.8%       7626 ±  9%  softirqs.CPU49.SCHED
      2.70 ±300%     -29.6%       1.90 ±282%  softirqs.CPU49.TASKLET
     91.00 ± 52%    +700.8%     728.70 ±114%  softirqs.CPU49.TIMER
      0.90 ±300%    +655.6%       6.80 ±178%  softirqs.CPU5.BLOCK
     32.50 ±290%  +18595.4%       6076 ±299%  softirqs.CPU5.NET_RX
      0.30 ±152%      +0.0%       0.30 ±152%  softirqs.CPU5.NET_TX
      6712 ±  9%     +26.4%       8483 ± 14%  softirqs.CPU5.RCU
      7009 ±  3%     +19.3%       8362 ± 14%  softirqs.CPU5.SCHED
      2.90 ±267%     -72.4%       0.80 ±165%  softirqs.CPU5.TASKLET
     99.70 ± 25%    +263.0%     361.90 ±104%  softirqs.CPU5.TIMER
      0.80 ±300%     +25.0%       1.00 ±240%  softirqs.CPU50.BLOCK
      1.60 ±203%     -50.0%       0.80 ±122%  softirqs.CPU50.NET_RX
      0.40 ±122%    -100.0%       0.00        softirqs.CPU50.NET_TX
      6609 ± 20%      +9.0%       7206 ±  6%  softirqs.CPU50.RCU
      6709 ±  3%     +10.4%       7409 ±  2%  softirqs.CPU50.SCHED
      1.40 ±300%     -78.6%       0.30 ±213%  softirqs.CPU50.TASKLET
    209.60 ±190%     -14.4%     179.50 ± 97%  softirqs.CPU50.TIMER
      3.10 ±289%    -100.0%       0.00        softirqs.CPU51.BLOCK
      0.40 ±122%   +9825.0%      39.70 ±299%  softirqs.CPU51.NET_RX
      0.10 ±300%    +100.0%       0.20 ±200%  softirqs.CPU51.NET_TX
      6482 ± 10%     +12.2%       7271 ±  6%  softirqs.CPU51.RCU
      6835 ±  9%      +8.7%       7430 ±  3%  softirqs.CPU51.SCHED
      0.10 ±300%    -100.0%       0.00        softirqs.CPU51.TASKLET
    301.90 ±207%     -66.4%     101.50 ± 42%  softirqs.CPU51.TIMER
      0.00         +8e+101%       0.80 ±300%  softirqs.CPU52.BLOCK
     17.50 ±264%     +94.9%      34.10 ±289%  softirqs.CPU52.NET_RX
      0.20 ±200%     +50.0%       0.30 ±152%  softirqs.CPU52.NET_TX
      6146 ±  5%     +22.5%       7528 ± 12%  softirqs.CPU52.RCU
      6536 ±  9%     +13.6%       7424 ±  7%  softirqs.CPU52.SCHED
      1.20 ±273%     -83.3%       0.20 ±300%  softirqs.CPU52.TASKLET
     72.10 ± 38%     +41.7%     102.20 ± 38%  softirqs.CPU52.TIMER
      3.60 ±130%    +236.1%      12.10 ±213%  softirqs.CPU53.NET_RX
      0.40 ±165%     -50.0%       0.20 ±200%  softirqs.CPU53.NET_TX
      6476 ±  9%     +15.1%       7455 ±  6%  softirqs.CPU53.RCU
      6941 ±  5%      +6.0%       7359 ±  6%  softirqs.CPU53.SCHED
      2.60 ±287%      -7.7%       2.40 ±249%  softirqs.CPU53.TASKLET
     72.40 ± 27%     +84.0%     133.20 ±126%  softirqs.CPU53.TIMER
      0.10 ±300%    -100.0%       0.00        softirqs.CPU54.BLOCK
      0.70 ±255%    +585.7%       4.80 ±104%  softirqs.CPU54.NET_RX
      0.10 ±300%    +500.0%       0.60 ±152%  softirqs.CPU54.NET_TX
      6713 ± 12%      +8.0%       7247 ±  6%  softirqs.CPU54.RCU
      6905 ±  4%      +8.5%       7494 ±  2%  softirqs.CPU54.SCHED
      0.30 ±213%    +366.7%       1.40 ±300%  softirqs.CPU54.TASKLET
     82.00 ± 25%     +33.7%     109.60 ± 45%  softirqs.CPU54.TIMER
      1.20 ±300%      +0.0%       1.20 ±300%  softirqs.CPU55.BLOCK
    152.90 ±277%     -63.2%      56.20 ±286%  softirqs.CPU55.NET_RX
      0.10 ±300%      +0.0%       0.10 ±300%  softirqs.CPU55.NET_TX
      6553 ±  7%     +13.3%       7428 ±  6%  softirqs.CPU55.RCU
      6847 ±  2%     +12.2%       7681 ±  5%  softirqs.CPU55.SCHED
      0.00          -100.0%       0.00        softirqs.CPU55.TASKLET
    103.20 ± 97%     -17.4%      85.20 ± 23%  softirqs.CPU55.TIMER
      1.60 ±300%     -93.8%       0.10 ±300%  softirqs.CPU56.BLOCK
      1.90 ±170%     -47.4%       1.00 ±209%  softirqs.CPU56.NET_RX
      0.10 ±300%      +0.0%       0.10 ±300%  softirqs.CPU56.NET_TX
      6541 ±  7%      +9.8%       7182 ±  9%  softirqs.CPU56.RCU
      6495 ± 10%     +14.6%       7442 ±  2%  softirqs.CPU56.SCHED
      6.40 ±189%    -100.0%       0.00        softirqs.CPU56.TASKLET
     92.40 ± 36%      +3.9%      96.00 ± 37%  softirqs.CPU56.TIMER
      2.80 ±166%     +57.1%       4.40 ±145%  softirqs.CPU57.BLOCK
      2.10 ± 14%      +9.5%       2.30 ± 39%  softirqs.CPU57.NET_RX
      2.20 ± 27%      -9.1%       2.00        softirqs.CPU57.NET_TX
      6515 ±  8%     +23.8%       8067 ± 20%  softirqs.CPU57.RCU
      6998 ± 10%      +9.5%       7661 ±  5%  softirqs.CPU57.SCHED
      3.50 ± 31%     -37.1%       2.20 ± 27%  softirqs.CPU57.TASKLET
    346.40 ±177%     -36.2%     221.10 ±153%  softirqs.CPU57.TIMER
      1.40 ±169%     -42.9%       0.80 ±300%  softirqs.CPU58.BLOCK
      1.10 ±154%     -45.5%       0.60 ± 81%  softirqs.CPU58.NET_RX
      0.00         +5e+101%       0.50 ±100%  softirqs.CPU58.NET_TX
      6377 ±  7%     +17.4%       7486 ±  8%  softirqs.CPU58.RCU
      6287 ± 15%     +18.4%       7445 ±  5%  softirqs.CPU58.SCHED
      0.50 ±300%    -100.0%       0.00        softirqs.CPU58.TASKLET
     71.60 ± 31%     +27.7%      91.40 ± 28%  softirqs.CPU58.TIMER
      0.80 ± 75%   +1212.5%      10.50 ±290%  softirqs.CPU59.NET_RX
      0.10 ±300%    +100.0%       0.20 ±200%  softirqs.CPU59.NET_TX
      6656 ±  9%     +14.6%       7628 ±  8%  softirqs.CPU59.RCU
      6849 ±  3%     +11.1%       7608 ±  4%  softirqs.CPU59.SCHED
      0.30 ±213%    -100.0%       0.00        softirqs.CPU59.TASKLET
    112.50 ± 65%     +10.0%     123.70 ± 49%  softirqs.CPU59.TIMER
      0.00       +1.7e+102%       1.70 ±186%  softirqs.CPU6.BLOCK
     23.10 ±284%     -61.0%       9.00 ±274%  softirqs.CPU6.NET_RX
      0.10 ±300%    +300.0%       0.40 ±229%  softirqs.CPU6.NET_TX
      6449 ±  9%     +21.4%       7830 ± 18%  softirqs.CPU6.RCU
      6596 ± 10%     +17.3%       7735 ±  6%  softirqs.CPU6.SCHED
      2.10 ±268%    -100.0%       0.00        softirqs.CPU6.TASKLET
     76.60 ± 35%    +481.5%     445.40 ±153%  softirqs.CPU6.TIMER
      0.00       +3.4e+102%       3.40 ±300%  softirqs.CPU60.BLOCK
     10.10 ±277%     -98.0%       0.20 ±200%  softirqs.CPU60.NET_RX
      0.40 ±165%     -75.0%       0.10 ±300%  softirqs.CPU60.NET_TX
      6421 ±  5%     +13.2%       7271 ±  4%  softirqs.CPU60.RCU
      6499 ±  9%     +13.5%       7377 ±  6%  softirqs.CPU60.SCHED
      0.20 ±300%      +0.0%       0.20 ±300%  softirqs.CPU60.TASKLET
    176.70 ±133%     -47.5%      92.80 ± 33%  softirqs.CPU60.TIMER
      1.60 ±300%    +262.5%       5.80 ±190%  softirqs.CPU61.BLOCK
      0.60 ±200%   +6466.7%      39.40 ±293%  softirqs.CPU61.NET_RX
      0.10 ±300%    +200.0%       0.30 ±213%  softirqs.CPU61.NET_TX
      6265 ±  6%     +18.7%       7440 ±  5%  softirqs.CPU61.RCU
      6407 ± 14%     +12.4%       7203 ± 12%  softirqs.CPU61.SCHED
      2.30 ±233%      -8.7%       2.10 ±300%  softirqs.CPU61.TASKLET
     62.20 ± 14%     +49.0%      92.70 ± 31%  softirqs.CPU61.TIMER
      1.40 ±300%    +271.4%       5.20 ±217%  softirqs.CPU62.BLOCK
      1.40 ±169%     -14.3%       1.20 ±148%  softirqs.CPU62.NET_RX
      0.20 ±200%     -50.0%       0.10 ±300%  softirqs.CPU62.NET_TX
      6655 ± 16%     +12.5%       7485 ± 12%  softirqs.CPU62.RCU
      6645 ±  5%     +14.2%       7592 ±  3%  softirqs.CPU62.SCHED
      0.80 ±261%     -75.0%       0.20 ±300%  softirqs.CPU62.TASKLET
    223.60 ±158%     -50.6%     110.40 ± 51%  softirqs.CPU62.TIMER
      1.60 ±175%    -100.0%       0.00        softirqs.CPU63.BLOCK
      1.00 ± 89%   +2960.0%      30.60 ±294%  softirqs.CPU63.NET_RX
      0.10 ±300%    +400.0%       0.50 ±134%  softirqs.CPU63.NET_TX
      6613 ±  9%     +14.2%       7555 ± 18%  softirqs.CPU63.RCU
      6717 ±  4%     +11.0%       7458 ±  5%  softirqs.CPU63.SCHED
      1.30 ±161%     -38.5%       0.80 ±300%  softirqs.CPU63.TASKLET
     78.20 ± 43%    +185.3%     223.10 ±129%  softirqs.CPU63.TIMER
      1.80 ±213%    -100.0%       0.00        softirqs.CPU64.BLOCK
      1.00 ±118%   +2720.0%      28.20 ±229%  softirqs.CPU64.NET_RX
      0.30 ±152%     -66.7%       0.10 ±300%  softirqs.CPU64.NET_TX
      6513 ±  7%     +15.2%       7505 ±  7%  softirqs.CPU64.RCU
      6684 ±  6%     +11.5%       7449 ±  6%  softirqs.CPU64.SCHED
      0.40 ±229%     -75.0%       0.10 ±300%  softirqs.CPU64.TASKLET
    108.20 ± 86%     +40.4%     151.90 ±122%  softirqs.CPU64.TIMER
     24.80 ±228%     -93.5%       1.60 ±300%  softirqs.CPU65.BLOCK
      0.80 ±156%    +200.0%       2.40 ±207%  softirqs.CPU65.NET_RX
      0.30 ±152%    -100.0%       0.00        softirqs.CPU65.NET_TX
      6689 ± 10%      +9.4%       7319 ±  5%  softirqs.CPU65.RCU
      6849 ±  3%      +6.9%       7324 ±  7%  softirqs.CPU65.SCHED
      2.40 ±286%     -37.5%       1.50 ±235%  softirqs.CPU65.TASKLET
     64.90 ± 21%     +28.5%      83.40 ± 28%  softirqs.CPU65.TIMER
      1.60 ±300%    +187.5%       4.60 ±208%  softirqs.CPU66.BLOCK
      2.60 ±184%    +730.8%      21.60 ±214%  softirqs.CPU66.NET_RX
      0.70 ±300%      +0.0%       0.70 ±300%  softirqs.CPU66.NET_TX
      6121 ±  6%     +23.1%       7533 ±  8%  softirqs.CPU66.RCU
      6507 ±  2%     +15.2%       7493 ±  2%  softirqs.CPU66.SCHED
      0.10 ±300%    -100.0%       0.00        softirqs.CPU66.TASKLET
    140.00 ±157%     -39.8%      84.30 ± 22%  softirqs.CPU66.TIMER
      7.60 ±205%      +0.0%       7.60 ±205%  softirqs.CPU67.BLOCK
      0.30 ±300%    +533.3%       1.90 ±155%  softirqs.CPU67.NET_RX
      0.00         +4e+101%       0.40 ±122%  softirqs.CPU67.NET_TX
      6093 ±  6%     +16.4%       7095 ±  5%  softirqs.CPU67.RCU
      6668 ±  8%      +9.3%       7288        softirqs.CPU67.SCHED
      0.20 ±200%    -100.0%       0.00        softirqs.CPU67.TASKLET
    280.30 ±219%     -69.7%      84.90 ± 25%  softirqs.CPU67.TIMER
      0.00       +4.9e+102%       4.90 ±187%  softirqs.CPU68.BLOCK
     14.90 ±275%     -81.2%       2.80 ±222%  softirqs.CPU68.NET_RX
      0.00         +8e+101%       0.80 ±300%  softirqs.CPU68.NET_TX
      6025 ±  5%     +16.6%       7025 ±  5%  softirqs.CPU68.RCU
      6356 ± 13%     +13.8%       7230 ±  3%  softirqs.CPU68.SCHED
      0.10 ±300%    -100.0%       0.00        softirqs.CPU68.TASKLET
     87.40 ± 58%      +5.1%      91.90 ± 26%  softirqs.CPU68.TIMER
      2.80 ±300%     +67.9%       4.70 ±299%  softirqs.CPU69.BLOCK
      3053 ±299%    -100.0%       1.20 ±249%  softirqs.CPU69.NET_RX
      0.10 ±300%      +0.0%       0.10 ±300%  softirqs.CPU69.NET_TX
      6041 ±  7%     +19.5%       7222 ±  3%  softirqs.CPU69.RCU
      6442 ±  4%     +15.3%       7427 ±  5%  softirqs.CPU69.SCHED
     94.50 ±101%    +118.8%     206.80 ±156%  softirqs.CPU69.TIMER
      0.80 ±300%    +450.0%       4.40 ±242%  softirqs.CPU7.BLOCK
      0.40 ±165%     +50.0%       0.60 ±110%  softirqs.CPU7.NET_RX
      0.20 ±200%     -50.0%       0.10 ±300%  softirqs.CPU7.NET_TX
      6408 ±  8%     +19.7%       7667 ± 12%  softirqs.CPU7.RCU
      6837 ±  4%     +10.4%       7550 ±  4%  softirqs.CPU7.SCHED
      2.00 ±219%     +70.0%       3.40 ±263%  softirqs.CPU7.TASKLET
     76.10 ± 13%    +138.1%     181.20 ± 64%  softirqs.CPU7.TIMER
      7.40 ±300%     -62.2%       2.80 ±300%  softirqs.CPU70.BLOCK
      0.00       +2.5e+102%       2.50 ±204%  softirqs.CPU70.NET_RX
      0.00         +2e+101%       0.20 ±300%  softirqs.CPU70.NET_TX
      5954 ±  7%     +25.1%       7447 ±  6%  softirqs.CPU70.RCU
      6461           +16.1%       7502 ±  3%  softirqs.CPU70.SCHED
     74.80 ± 49%    +230.5%     247.20 ±165%  softirqs.CPU70.TIMER
     13.10 ±284%    +315.3%      54.40 ±297%  softirqs.CPU71.NET_RX
      6056 ±  7%     +21.1%       7336 ±  7%  softirqs.CPU71.RCU
      6696 ±  8%     +12.6%       7538 ±  5%  softirqs.CPU71.SCHED
    295.60 ±228%     -15.4%     250.10 ±194%  softirqs.CPU71.TIMER
      4.60 ±300%     +91.3%       8.80 ±200%  softirqs.CPU72.BLOCK
     21.00 ±273%     +67.6%      35.20 ±300%  softirqs.CPU72.NET_RX
      0.10 ±300%    -100.0%       0.00        softirqs.CPU72.NET_TX
      6058 ±  7%     +18.8%       7199 ±  6%  softirqs.CPU72.RCU
      6457 ±  4%     +15.8%       7477 ±  6%  softirqs.CPU72.SCHED
    215.10 ±213%     +24.4%     267.60 ±216%  softirqs.CPU72.TIMER
      0.10 ±300%  +12200.0%      12.30 ±123%  softirqs.CPU73.BLOCK
      0.30 ±300%   +9533.3%      28.90 ±268%  softirqs.CPU73.NET_RX
      6039 ±  8%     +16.1%       7014 ±  8%  softirqs.CPU73.RCU
      6701 ±  9%     +10.8%       7428        softirqs.CPU73.SCHED
      0.00         +8e+101%       0.80 ±261%  softirqs.CPU73.TASKLET
    203.00 ±220%     -14.9%     172.70 ±111%  softirqs.CPU73.TIMER
      0.20 ±300%      +0.0%       0.20 ±300%  softirqs.CPU74.BLOCK
      0.30 ±300%    -100.0%       0.00        softirqs.CPU74.NET_RX
      0.10 ±300%    -100.0%       0.00        softirqs.CPU74.NET_TX
      5919 ±  5%     +22.0%       7224 ±  4%  softirqs.CPU74.RCU
      6572 ±  6%     +15.7%       7603 ±  7%  softirqs.CPU74.SCHED
      0.20 ±300%    -100.0%       0.00        softirqs.CPU74.TASKLET
    211.60 ±209%     -13.1%     183.90 ±176%  softirqs.CPU74.TIMER
      0.00       +5.7e+102%       5.70 ±200%  softirqs.CPU75.BLOCK
      2.30 ±190%     -87.0%       0.30 ±300%  softirqs.CPU75.NET_RX
      6096 ± 27%      +8.5%       6615 ±  4%  softirqs.CPU75.RCU
      6484           +11.7%       7241 ±  3%  softirqs.CPU75.SCHED
      0.10 ±300%    +700.0%       0.80 ±300%  softirqs.CPU75.TASKLET
    203.30 ±206%     -33.6%     135.00 ± 64%  softirqs.CPU75.TIMER
      5.90 ±200%     +20.3%       7.10 ±300%  softirqs.CPU76.BLOCK
      3.70 ±236%     -13.5%       3.20 ±289%  softirqs.CPU76.NET_RX
      0.20 ±200%    -100.0%       0.00        softirqs.CPU76.NET_TX
      5637 ±  5%     +19.7%       6749 ±  6%  softirqs.CPU76.RCU
      6486           +13.9%       7388 ±  2%  softirqs.CPU76.SCHED
      0.40 ±300%    -100.0%       0.00        softirqs.CPU76.TASKLET
     57.60 ± 27%    +118.9%     126.10 ±137%  softirqs.CPU76.TIMER
      2.80 ±300%    +153.6%       7.10 ±202%  softirqs.CPU77.BLOCK
     32.20 ±199%    -100.0%       0.00        softirqs.CPU77.NET_RX
      5580 ±  5%     +21.7%       6790 ±  8%  softirqs.CPU77.RCU
      6461           +12.3%       7259 ±  4%  softirqs.CPU77.SCHED
     61.50 ± 30%     +64.6%     101.20 ±123%  softirqs.CPU77.TIMER
      2.90 ±299%    +265.5%      10.60 ±155%  softirqs.CPU78.BLOCK
      0.10 ±300%   +3400.0%       3.50 ±186%  softirqs.CPU78.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU78.NET_TX
      5609 ±  5%     +21.8%       6832 ±  9%  softirqs.CPU78.RCU
      6421           +14.1%       7325        softirqs.CPU78.SCHED
      0.00       +1.4e+102%       1.40 ±300%  softirqs.CPU78.TASKLET
     66.90 ± 65%      +8.8%      72.80 ± 42%  softirqs.CPU78.TIMER
      1.70 ±300%     +64.7%       2.80 ±300%  softirqs.CPU79.BLOCK
      9.60 ±279%    -100.0%       0.00        softirqs.CPU79.NET_RX
      0.30 ±152%    -100.0%       0.00        softirqs.CPU79.NET_TX
      6019 ± 10%     +10.4%       6644 ±  4%  softirqs.CPU79.RCU
      6522 ± 12%     +11.3%       7257        softirqs.CPU79.SCHED
    427.80 ±142%     -86.3%      58.40 ± 27%  softirqs.CPU79.TIMER
      0.80 ±300%      +0.0%       0.80 ±300%  softirqs.CPU8.BLOCK
     46.90 ±215%     -98.7%       0.60 ±110%  softirqs.CPU8.NET_RX
      0.30 ±152%     -66.7%       0.10 ±300%  softirqs.CPU8.NET_TX
      6420 ± 10%     +14.7%       7362 ±  5%  softirqs.CPU8.RCU
      6706 ±  7%     +12.7%       7560 ±  4%  softirqs.CPU8.SCHED
      2.00 ±253%     -90.0%       0.20 ±300%  softirqs.CPU8.TASKLET
     79.70 ± 25%     +17.8%      93.90 ± 67%  softirqs.CPU8.TIMER
      0.20 ±300%   +1300.0%       2.80 ±300%  softirqs.CPU80.BLOCK
      1.10 ±271%     -90.9%       0.10 ±300%  softirqs.CPU80.NET_RX
      0.60 ±300%    -100.0%       0.00        softirqs.CPU80.NET_TX
      5777 ± 11%     +15.9%       6697 ±  5%  softirqs.CPU80.RCU
      6622 ±  3%     +11.4%       7378        softirqs.CPU80.SCHED
      0.00         +4e+101%       0.40 ±300%  softirqs.CPU80.TASKLET
    268.80 ±178%     -74.8%      67.80 ± 18%  softirqs.CPU80.TIMER
      5.60 ±200%     +39.3%       7.80 ±200%  softirqs.CPU81.BLOCK
     13.90 ±297%     -88.5%       1.60 ±300%  softirqs.CPU81.NET_RX
      5653 ±  4%     +20.6%       6819 ±  7%  softirqs.CPU81.RCU
      6421 ±  4%     +16.1%       7453 ±  4%  softirqs.CPU81.SCHED
    100.50 ±116%    +103.5%     204.50 ±196%  softirqs.CPU81.TIMER
      2.60 ±299%     +11.5%       2.90 ±299%  softirqs.CPU82.BLOCK
      1.40 ±237%     -71.4%       0.40 ±229%  softirqs.CPU82.NET_RX
      5742 ±  8%     +20.9%       6940 ±  7%  softirqs.CPU82.RCU
      6546 ±  2%     +13.0%       7398 ±  3%  softirqs.CPU82.SCHED
     50.10 ± 23%    +313.6%     207.20 ±215%  softirqs.CPU82.TIMER
     10.40 ±158%     -98.1%       0.20 ±300%  softirqs.CPU83.BLOCK
     19.00 ±200%     -90.0%       1.90 ±249%  softirqs.CPU83.NET_RX
      5596 ±  5%     +19.3%       6679 ±  3%  softirqs.CPU83.RCU
      6502            +8.5%       7058 ±  3%  softirqs.CPU83.SCHED
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU83.TASKLET
     60.00 ± 23%     -19.8%      48.10 ± 25%  softirqs.CPU83.TIMER
      6.50 ±173%     -55.4%       2.90 ±299%  softirqs.CPU84.BLOCK
      0.00       +1.2e+102%       1.20 ±273%  softirqs.CPU84.NET_RX
      5685 ±  6%     +17.8%       6698 ±  8%  softirqs.CPU84.RCU
      6539 ±  2%     +10.7%       7240        softirqs.CPU84.SCHED
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU84.TASKLET
    117.30 ±163%     -50.0%      58.60 ± 26%  softirqs.CPU84.TIMER
      2.90 ±288%      -3.4%       2.80 ±300%  softirqs.CPU85.BLOCK
      0.90 ±300%     +11.1%       1.00 ±300%  softirqs.CPU85.NET_RX
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU85.NET_TX
      5497 ±  5%     +20.9%       6645 ±  6%  softirqs.CPU85.RCU
      6440           +11.4%       7171 ±  5%  softirqs.CPU85.SCHED
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU85.TASKLET
     51.20 ± 36%      +2.1%      52.30 ± 26%  softirqs.CPU85.TIMER
      0.00         +2e+101%       0.20 ±300%  softirqs.CPU86.BLOCK
      1.10 ±209%    +681.8%       8.60 ±225%  softirqs.CPU86.NET_RX
      0.10 ±300%    -100.0%       0.00        softirqs.CPU86.NET_TX
      5915 ± 10%     +15.8%       6849 ±  6%  softirqs.CPU86.RCU
      6489 ±  2%     +14.1%       7404 ±  5%  softirqs.CPU86.SCHED
      0.10 ±300%    -100.0%       0.00        softirqs.CPU86.TASKLET
     89.90 ±116%    +112.0%     190.60 ±207%  softirqs.CPU86.TIMER
      0.20 ±300%    -100.0%       0.00        softirqs.CPU87.BLOCK
      0.60 ±300%     -83.3%       0.10 ±300%  softirqs.CPU87.NET_RX
      5732 ±  6%     +27.2%       7293 ± 21%  softirqs.CPU87.RCU
      5770 ± 17%     +13.3%       6539 ±  9%  softirqs.CPU87.SCHED
    375.40 ±165%     +11.5%     418.70 ±172%  softirqs.CPU87.TIMER
      0.60 ±300%    +100.0%       1.20 ±196%  softirqs.CPU9.BLOCK
     24.30 ±201%     -94.2%       1.40 ± 34%  softirqs.CPU9.NET_RX
      1.00 ± 44%     -10.0%       0.90 ± 33%  softirqs.CPU9.NET_TX
      6653 ±  6%     +18.2%       7866 ± 20%  softirqs.CPU9.RCU
      6645 ± 11%     +10.4%       7336 ± 12%  softirqs.CPU9.SCHED
      1.90 ±266%    +163.2%       5.00 ±193%  softirqs.CPU9.TASKLET
    154.70 ± 80%     +31.9%     204.10 ±141%  softirqs.CPU9.TIMER
      2.30 ± 19%      +4.3%       2.40 ± 20%  softirqs.HI
      4424 ±212%    +123.9%       9905 ±189%  softirqs.NET_RX
     25.20 ± 10%      -2.0%      24.70 ±  8%  softirqs.NET_TX
    552382 ±  3%     +16.6%     644267 ±  2%  softirqs.RCU
    588333           +12.5%     661584        softirqs.SCHED
    229.10            +0.1%     229.30        softirqs.TASKLET
     14131            +7.5%      15187        softirqs.TIMER
     34.10 ±  8%      -1.3       32.76 ±  5%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      1.05 ±  5%      -1.0        0.00        perf-profile.calltrace.cycles-pp.destroy_inode.__dentry_kill.dput.__fput.task_work_run
     35.16 ±  7%      -1.0       34.12 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      1.03 ±  5%      -1.0        0.00        perf-profile.calltrace.cycles-pp.xfs_inode_mark_reclaimable.destroy_inode.__dentry_kill.dput.__fput
     35.23 ±  7%      -1.0       34.21 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     36.10 ±  7%      -1.0       35.08 ±  4%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      1.01 ±  5%      -1.0        0.00        perf-profile.calltrace.cycles-pp.xfs_inactive.xfs_inode_mark_reclaimable.destroy_inode.__dentry_kill.dput
     35.68 ±  7%      -1.0       34.68 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     35.68 ±  7%      -1.0       34.68 ±  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     35.68 ±  7%      -1.0       34.69 ±  4%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     52.12 ±  4%      -0.9       51.20 ±  2%  perf-profile.calltrace.cycles-pp.write
     48.86 ±  4%      -0.9       47.98 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     49.35 ±  4%      -0.9       48.47 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      0.85 ±  5%      -0.9        0.00        perf-profile.calltrace.cycles-pp.xfs_inactive_ifree.xfs_inactive.xfs_inode_mark_reclaimable.destroy_inode.__dentry_kill
     48.00 ±  4%      -0.8       47.16 ±  2%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     46.92 ±  4%      -0.8       46.08 ±  2%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     44.41 ±  4%      -0.8       43.64 ±  2%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     43.30 ±  4%      -0.7       42.64 ±  2%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.62 ±  6%      -0.6        0.00        perf-profile.calltrace.cycles-pp.xfs_ifree.xfs_inactive_ifree.xfs_inactive.xfs_inode_mark_reclaimable.destroy_inode
     38.69 ±  4%      -0.5       38.18 ±  2%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
     38.46 ±  4%      -0.5       37.96 ±  2%  perf-profile.calltrace.cycles-pp.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write.vfs_write
      7.81 ±  3%      -0.4        7.39 ±  2%  perf-profile.calltrace.cycles-pp.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      0.58 ±  4%      -0.3        0.25 ±100%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.uncharge_batch.mem_cgroup_uncharge_list.release_pages.__pagevec_release
      4.36 ±  5%      -0.3        4.07 ±  4%  perf-profile.calltrace.cycles-pp.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      3.99 ±  5%      -0.2        3.77 ±  4%  perf-profile.calltrace.cycles-pp.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
      0.49 ± 33%      -0.2        0.27 ±100%  perf-profile.calltrace.cycles-pp.lock_page_memcg.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor.iomap_apply
      2.93 ±  6%      -0.2        2.72 ±  5%  perf-profile.calltrace.cycles-pp.__set_page_dirty.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor.iomap_apply
      6.28 ±  8%      -0.2        6.10 ±  6%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      0.60 ± 10%      -0.2        0.42 ± 50%  perf-profile.calltrace.cycles-pp.xfs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     32.31 ±  4%      -0.1       32.17 ±  2%  perf-profile.calltrace.cycles-pp.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
      0.50 ± 33%      -0.1        0.37 ± 65%  perf-profile.calltrace.cycles-pp.xfs_iunlock.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
      1.64 ±  8%      -0.1        1.52 ±  7%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.__set_page_dirty.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor
      0.28 ±100%      -0.1        0.17 ±152%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru
      0.10 ±200%      -0.1        0.00        perf-profile.calltrace.cycles-pp.find_lock_entries.truncate_inode_pages_range.evict.__dentry_kill.dput
      1.98 ±  6%      -0.1        1.89 ±  4%  perf-profile.calltrace.cycles-pp.truncate_cleanup_page.truncate_inode_pages_range.evict.__dentry_kill.dput
      0.64 ±  4%      -0.1        0.55 ±  4%  perf-profile.calltrace.cycles-pp.xfs_buffered_write_iomap_end.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
      1.79 ±  6%      -0.1        1.70 ±  5%  perf-profile.calltrace.cycles-pp.__cancel_dirty_page.truncate_cleanup_page.truncate_inode_pages_range.evict.__dentry_kill
      0.72 ±  5%      -0.1        0.64 ±  2%  perf-profile.calltrace.cycles-pp.uncharge_batch.mem_cgroup_uncharge_list.release_pages.__pagevec_release.truncate_inode_pages_range
      2.58 ±  4%      -0.1        2.49 ±  4%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      0.92 ±  5%      -0.1        0.84 ±  5%  perf-profile.calltrace.cycles-pp.xfs_ilock.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
      3.78 ±  4%      -0.1        3.70 ±  4%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.77 ±  5%      -0.1        0.69 ±  6%  perf-profile.calltrace.cycles-pp.down_write.xfs_ilock.xfs_file_buffered_write.new_sync_write.vfs_write
      2.40 ±  4%      -0.1        2.32 ±  3%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.53 ±  7%      -0.1        1.45 ±  6%  perf-profile.calltrace.cycles-pp.account_page_cleaned.__cancel_dirty_page.truncate_cleanup_page.truncate_inode_pages_range.evict
      0.56 ±  6%      -0.1        0.48 ± 33%  perf-profile.calltrace.cycles-pp.xfs_iunlock.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      0.42 ± 66%      -0.1        0.34 ± 82%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__mod_lruvec_page_state.account_page_cleaned.__cancel_dirty_page
      0.98 ± 10%      -0.1        0.91 ±  8%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.__set_page_dirty.__set_page_dirty_nobuffers.iomap_write_end
      1.69 ±  8%      -0.1        1.62 ±  7%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      1.95 ±  4%      -0.1        1.88 ±  4%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.65 ±  3%      -0.1        0.58 ±  7%  perf-profile.calltrace.cycles-pp.xas_load.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      1.01 ±  5%      -0.1        0.94 ±  3%  perf-profile.calltrace.cycles-pp.mem_cgroup_uncharge_list.release_pages.__pagevec_release.truncate_inode_pages_range.evict
      0.83 ± 11%      -0.1        0.77 ± 10%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__mod_lruvec_page_state.__set_page_dirty.__set_page_dirty_nobuffers
      1.76 ±  4%      -0.1        1.69 ±  4%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply
      1.45 ± 11%      -0.1        1.38 ± 10%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      1.20 ±  8%      -0.1        1.14 ±  7%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.account_page_cleaned.__cancel_dirty_page.truncate_cleanup_page.truncate_inode_pages_range
      0.63 ±  8%      -0.1        0.57 ±  6%  perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      8.66 ±  5%      -0.1        8.60 ±  6%  perf-profile.calltrace.cycles-pp.__close
      0.05 ±300%      -0.1        0.00        perf-profile.calltrace.cycles-pp.xfs_iext_lookup_extent.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      8.64 ±  5%      -0.1        8.59 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      8.64 ±  5%      -0.0        8.59 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      8.62 ±  5%      -0.0        8.58 ±  6%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      3.41 ± 11%      -0.0        3.37 ±  9%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      8.62 ±  5%      -0.0        8.58 ±  6%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.62 ±  5%      -0.0        8.58 ±  6%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      8.61 ±  5%      -0.0        8.57 ±  6%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      8.59 ±  5%      -0.0        8.55 ±  6%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      8.57 ±  5%      -0.0        8.53 ±  6%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_prepare
      0.89 ±  9%      -0.0        0.85 ± 10%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      1.08 ±  4%      -0.0        1.04 ±  3%  perf-profile.calltrace.cycles-pp.xfs_ilock.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      1.02 ±  5%      -0.0        0.98 ±  5%  perf-profile.calltrace.cycles-pp.iov_iter_fault_in_readable.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      0.70 ± 12%      -0.0        0.66 ±  9%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.account_page_cleaned.__cancel_dirty_page.truncate_cleanup_page
      0.86 ±  5%      -0.0        0.83 ±  4%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      1.13 ±  5%      -0.0        1.10 ±  4%  perf-profile.calltrace.cycles-pp.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      0.91 ±  5%      -0.0        0.88 ±  4%  perf-profile.calltrace.cycles-pp.down_write.xfs_ilock.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write
      0.74 ± 10%      -0.0        0.71 ± 12%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__mod_lruvec_page_state.__add_to_page_cache_locked.add_to_page_cache_lru
      0.69 ±  4%      -0.0        0.67 ±  6%  perf-profile.calltrace.cycles-pp.__get_user_nocheck_1.iov_iter_fault_in_readable.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.64 ± 11%      -0.0        0.62 ±  7%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru.pagecache_get_page
      0.67 ±  5%      -0.0        0.65 ±  4%  perf-profile.calltrace.cycles-pp.common_file_perm.security_file_permission.vfs_write.ksys_write.do_syscall_64
      1.91 ±  5%      -0.0        1.89 ±  4%  perf-profile.calltrace.cycles-pp.__entry_text_start.write
      0.82 ±  7%      -0.0        0.80 ±  8%  perf-profile.calltrace.cycles-pp.unaccount_page_cache_page.delete_from_page_cache_batch.truncate_inode_pages_range.evict.__dentry_kill
      1.45 ±  9%      -0.0        1.44 ±  7%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      0.11 ±200%      -0.0        0.10 ±200%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.release_pages.__pagevec_release.truncate_inode_pages_range.evict
      0.80 ±  5%      -0.0        0.79 ±  4%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.71 ±  8%      -0.0        0.71 ±  9%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.unaccount_page_cache_page.delete_from_page_cache_batch.truncate_inode_pages_range.evict
      0.72 ±  4%      -0.0        0.72 ±  5%  perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.85 ±  5%      -0.0        0.85 ±  4%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.44 ±  5%      +0.0        1.44 ±  5%  perf-profile.calltrace.cycles-pp.memset_erms.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.05 ±300%      +0.0        0.05 ±299%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.unaccount_page_cache_page.delete_from_page_cache_batch.truncate_inode_pages_range
      1.53 ±  5%      +0.0        1.54 ±  4%  perf-profile.calltrace.cycles-pp.delete_from_page_cache_batch.truncate_inode_pages_range.evict.__dentry_kill.dput
      2.43 ±  5%      +0.0        2.43 ±  6%  perf-profile.calltrace.cycles-pp.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
      0.99 ±  4%      +0.0        0.99 ± 12%  perf-profile.calltrace.cycles-pp.file_update_time.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write
      0.62 ±  5%      +0.0        0.64 ±  4%  perf-profile.calltrace.cycles-pp.xfs_break_layouts.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write
      0.00            +0.1        0.06 ±300%  perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_remove.xfs_vn_unlink.vfs_unlink
      0.00            +0.1        0.06 ±299%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_remove.xfs_vn_unlink.vfs_unlink.do_unlinkat
      0.00            +0.1        0.10 ±200%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.00            +0.1        0.10 ±200%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel
      0.00            +0.1        0.10 ±200%  perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_vn_update_time.file_update_time.xfs_file_write_checks
      0.00            +0.1        0.10 ±200%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_vn_update_time.file_update_time.xfs_file_write_checks.xfs_file_buffered_write
      0.00            +0.1        0.10 ±200%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.00            +0.1        0.10 ±200%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64_no_verify
      0.00            +0.1        0.10 ±200%  perf-profile.calltrace.cycles-pp.start_kernel.secondary_startup_64_no_verify
      0.72 ±  5%      +0.1        0.84 ± 15%  perf-profile.calltrace.cycles-pp.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.70 ±  5%      +0.1        0.82 ± 15%  perf-profile.calltrace.cycles-pp.xfs_remove.xfs_vn_unlink.vfs_unlink.do_unlinkat.do_syscall_64
      0.70 ±  5%      +0.1        0.82 ± 15%  perf-profile.calltrace.cycles-pp.xfs_vn_unlink.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.12 ±204%  perf-profile.calltrace.cycles-pp.xfs_check_agi_freecount.xfs_dialloc.xfs_create.xfs_generic_create.path_openat
      0.96 ±  6%      +0.1        1.09 ± 14%  perf-profile.calltrace.cycles-pp.unlink
      0.92 ±  6%      +0.1        1.05 ± 14%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      0.92 ±  6%      +0.1        1.05 ± 14%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.89 ±  6%      +0.1        1.02 ± 14%  perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.00            +0.1        0.14 ±200%  perf-profile.calltrace.cycles-pp.xfs_vn_update_time.file_update_time.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write
      0.43 ± 50%      +0.3        0.69 ±  6%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.44 ± 50%      +0.3        0.70 ±  6%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.90 ±  4%      +0.3        1.17 ±  6%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.92 ±  6%      +0.3        1.19 ± 16%  perf-profile.calltrace.cycles-pp.xfs_generic_create.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.90 ±  6%      +0.3        1.17 ± 17%  perf-profile.calltrace.cycles-pp.xfs_create.xfs_generic_create.path_openat.do_filp_open.do_sys_openat2
      0.98 ±  4%      +0.3        1.26 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      1.43 ±  4%      +0.3        1.73 ± 12%  perf-profile.calltrace.cycles-pp.creat64
      1.41 ±  4%      +0.3        1.71 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      1.39 ±  4%      +0.3        1.69 ± 13%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      1.40 ±  4%      +0.3        1.71 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      1.39 ±  4%      +0.3        1.69 ± 13%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      1.34 ±  4%      +0.3        1.65 ± 13%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      1.35 ±  4%      +0.3        1.66 ± 13%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.26 ±  5%      +0.5       19.75 ±  3%  perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      0.00            +0.6        0.59 ±  5%  perf-profile.calltrace.cycles-pp.xfs_difree.xfs_ifree.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker
     13.06 ±  6%      +0.6       13.68 ±  4%  perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
     12.82 ±  6%      +0.6       13.44 ±  4%  perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply
      0.00            +0.6        0.62 ± 16%  perf-profile.calltrace.cycles-pp.xfs_dialloc.xfs_create.xfs_generic_create.path_openat.do_filp_open
      0.00            +0.8        0.80 ±  5%  perf-profile.calltrace.cycles-pp.xfs_ifree.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work
      9.02 ±  8%      +0.8        9.82 ±  6%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      2.67 ±  8%      +1.0        3.65 ± 11%  perf-profile.calltrace.cycles-pp.lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      7.50 ±  6%      +1.0        8.49 ±  6%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
      7.47 ±  6%      +1.0        8.46 ±  6%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.__dentry_kill.dput.__fput
      2.50 ±  9%      +1.0        3.50 ± 12%  perf-profile.calltrace.cycles-pp.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      0.84 ± 17%      +1.0        1.89 ± 21%  perf-profile.calltrace.cycles-pp.lock_page_lruvec_irqsave.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru.pagecache_get_page
      0.76 ± 18%      +1.0        1.80 ± 22%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.__pagevec_lru_add.lru_cache_add
      0.81 ± 17%      +1.0        1.86 ± 21%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru
      3.24 ±  8%      +1.0        4.28 ± 10%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill
      3.33 ±  8%      +1.1        4.44 ± 10%  perf-profile.calltrace.cycles-pp.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill.dput
      0.90 ± 19%      +1.1        2.02 ± 20%  perf-profile.calltrace.cycles-pp.lock_page_lruvec_irqsave.release_pages.__pagevec_release.truncate_inode_pages_range.evict
      0.86 ± 19%      +1.1        2.00 ± 20%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.release_pages.__pagevec_release.truncate_inode_pages_range
      0.82 ± 20%      +1.1        1.96 ± 20%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.release_pages.__pagevec_release
      0.00            +1.2        1.22 ±  4%  perf-profile.calltrace.cycles-pp.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread
      0.00            +1.3        1.32 ±  4%  perf-profile.calltrace.cycles-pp.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread.kthread
      0.00            +1.3        1.34 ±  4%  perf-profile.calltrace.cycles-pp.xfs_inodegc_worker.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +1.4        1.45 ±  4%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +1.5        1.45 ±  4%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.00            +1.5        1.52 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.00            +1.5        1.52 ±  3%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
     34.49 ±  7%      -1.4       33.13 ±  5%  perf-profile.children.cycles-pp.intel_idle
      1.05 ±  5%      -1.0        0.00        perf-profile.children.cycles-pp.destroy_inode
     35.63 ±  7%      -1.0       34.59 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
     35.64 ±  7%      -1.0       34.60 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
      1.03 ±  5%      -1.0        0.00        perf-profile.children.cycles-pp.xfs_inode_mark_reclaimable
     36.10 ±  7%      -1.0       35.08 ±  4%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     36.10 ±  7%      -1.0       35.08 ±  4%  perf-profile.children.cycles-pp.cpu_startup_entry
     36.10 ±  7%      -1.0       35.08 ±  4%  perf-profile.children.cycles-pp.do_idle
     35.68 ±  7%      -1.0       34.69 ±  4%  perf-profile.children.cycles-pp.start_secondary
     52.15 ±  4%      -0.9       51.21 ±  2%  perf-profile.children.cycles-pp.write
     48.03 ±  4%      -0.8       47.18 ±  2%  perf-profile.children.cycles-pp.ksys_write
     46.97 ±  4%      -0.8       46.13 ±  2%  perf-profile.children.cycles-pp.vfs_write
     44.43 ±  4%      -0.8       43.65 ±  2%  perf-profile.children.cycles-pp.new_sync_write
     43.33 ±  4%      -0.7       42.68 ±  2%  perf-profile.children.cycles-pp.xfs_file_buffered_write
     38.70 ±  4%      -0.5       38.19 ±  2%  perf-profile.children.cycles-pp.iomap_file_buffered_write
     38.50 ±  4%      -0.5       38.00 ±  2%  perf-profile.children.cycles-pp.iomap_apply
     59.98 ±  4%      -0.5       59.50 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     60.46 ±  4%      -0.5       59.99 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      7.85 ±  3%      -0.4        7.43 ±  2%  perf-profile.children.cycles-pp.iomap_write_end
      4.40 ±  5%      -0.3        4.11 ±  4%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      5.25 ±  8%      -0.2        5.00 ±  7%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      4.11 ±  5%      -0.2        3.88 ±  4%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      2.96 ±  5%      -0.2        2.74 ±  4%  perf-profile.children.cycles-pp.__set_page_dirty
      4.13 ± 10%      -0.2        3.95 ±  8%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      6.29 ±  8%      -0.2        6.12 ±  6%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      6.18 ±  4%      -0.2        6.02 ±  4%  perf-profile.children.cycles-pp.iomap_set_range_uptodate
      3.30 ± 11%      -0.1        3.15 ± 10%  perf-profile.children.cycles-pp.__mod_memcg_state
     32.38 ±  4%      -0.1       32.25 ±  2%  perf-profile.children.cycles-pp.iomap_write_actor
      2.05 ±  4%      -0.1        1.93 ±  4%  perf-profile.children.cycles-pp.xfs_ilock
      1.77 ±  4%      -0.1        1.66 ±  5%  perf-profile.children.cycles-pp.down_write
      0.69 ±  4%      -0.1        0.59 ±  4%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_end
      1.99 ±  6%      -0.1        1.90 ±  4%  perf-profile.children.cycles-pp.truncate_cleanup_page
      1.80 ±  6%      -0.1        1.71 ±  5%  perf-profile.children.cycles-pp.__cancel_dirty_page
      2.59 ±  4%      -0.1        2.51 ±  4%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.72 ±  5%      -0.1        0.64 ±  2%  perf-profile.children.cycles-pp.uncharge_batch
      0.61 ±  4%      -0.1        0.53 ±  2%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.60 ± 10%      -0.1        0.52 ±  4%  perf-profile.children.cycles-pp.xfs_file_write_iter
      1.54 ±  7%      -0.1        1.46 ±  6%  perf-profile.children.cycles-pp.account_page_cleaned
      9.16 ±  5%      -0.1        9.08 ±  6%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.96 ±  4%      -0.1        1.89 ±  4%  perf-profile.children.cycles-pp.copyin
      1.88 ±  4%      -0.1        1.81 ±  4%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      1.02 ±  5%      -0.1        0.95 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.59 ±  6%      -0.1        0.52 ±  3%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.49 ±  5%      -0.1        0.42 ±  3%  perf-profile.children.cycles-pp.page_counter_cancel
      0.16 ±  8%      -0.1        0.09 ±  9%  perf-profile.children.cycles-pp.xfs_inactive_truncate
      1.46 ± 11%      -0.1        1.39 ± 10%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      8.97 ±  5%      -0.1        8.91 ±  6%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.06 ±  8%      -0.1        0.00        perf-profile.children.cycles-pp.xfs_defer_finish
      1.15 ±  6%      -0.1        1.09 ±  4%  perf-profile.children.cycles-pp.xfs_iunlock
      0.63 ±  8%      -0.1        0.57 ±  5%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.06 ± 10%      -0.1        0.00        perf-profile.children.cycles-pp.xfs_defer_trans_roll
      0.96 ±  3%      -0.1        0.91 ±  6%  perf-profile.children.cycles-pp.xas_load
      0.06 ± 12%      -0.1        0.00        perf-profile.children.cycles-pp.xfs_trans_roll
      8.66 ±  5%      -0.1        8.60 ±  6%  perf-profile.children.cycles-pp.__close
      1.06 ±  4%      -0.1        1.00 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.10 ±  7%      -0.1        0.05 ± 34%  perf-profile.children.cycles-pp.xfs_itruncate_extents_flags
      3.42 ± 11%      -0.0        3.38 ±  9%  perf-profile.children.cycles-pp.mem_cgroup_charge
      8.62 ±  5%      -0.0        8.58 ±  6%  perf-profile.children.cycles-pp.task_work_run
      8.61 ±  5%      -0.0        8.57 ±  6%  perf-profile.children.cycles-pp.__fput
      0.60 ±  5%      -0.0        0.56 ±  7%  perf-profile.children.cycles-pp.lock_page_memcg
      8.57 ±  5%      -0.0        8.53 ±  6%  perf-profile.children.cycles-pp.__dentry_kill
      0.05 ±  7%      -0.0        0.01 ±203%  perf-profile.children.cycles-pp.generic_file_write_iter
      8.61 ±  5%      -0.0        8.57 ±  6%  perf-profile.children.cycles-pp.dput
      0.81 ±  6%      -0.0        0.77 ±  4%  perf-profile.children.cycles-pp.up_write
      0.61 ±  6%      -0.0        0.57 ±  6%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.56 ±  5%      -0.0        0.52 ±  6%  perf-profile.children.cycles-pp.__cond_resched
      0.44 ±  5%      -0.0        0.41 ±  7%  perf-profile.children.cycles-pp.rmqueue
      0.43 ±  7%      -0.0        0.40 ±  2%  perf-profile.children.cycles-pp.try_charge_memcg
      1.04 ±  4%      -0.0        1.01 ±  5%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.30 ±  7%      -0.0        0.27 ±  5%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.87 ±  5%      -0.0        0.84 ±  4%  perf-profile.children.cycles-pp.get_page_from_freelist
      1.15 ±  5%      -0.0        1.12 ±  4%  perf-profile.children.cycles-pp.__alloc_pages
      0.36 ±  5%      -0.0        0.32 ±  5%  perf-profile.children.cycles-pp.xfs_bmbt_to_iomap
      0.79 ±  4%      -0.0        0.76 ±  6%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.48 ±  6%      -0.0        0.45 ±  7%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.18 ±  6%      -0.0        0.16 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.48 ±  4%      -0.0        0.46 ±  5%  perf-profile.children.cycles-pp.find_lock_entries
      0.26 ±  6%      -0.0        0.24 ±  5%  perf-profile.children.cycles-pp.rcu_all_qs
      0.21 ±  5%      -0.0        0.19 ±  7%  perf-profile.children.cycles-pp.xfs_read_agi
      0.42 ± 12%      -0.0        0.40 ± 29%  perf-profile.children.cycles-pp.start_kernel
      0.17 ±  9%      -0.0        0.14 ±  7%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.12 ±  8%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.xfs_btree_lookup_get_block
      0.46 ±  5%      -0.0        0.44 ±  5%  perf-profile.children.cycles-pp.unlock_page
      0.06 ± 11%      -0.0        0.04 ± 67%  perf-profile.children.cycles-pp.iomap_adjust_read_range
      0.15 ± 13%      -0.0        0.13 ±  7%  perf-profile.children.cycles-pp.xfs_bmapi_reserve_delalloc
      0.31 ±  8%      -0.0        0.29 ± 12%  perf-profile.children.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.36 ±  5%      -0.0        0.34 ±  6%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.70 ±  5%      -0.0        0.68 ±  4%  perf-profile.children.cycles-pp.common_file_perm
      0.04 ± 50%      -0.0        0.02 ±130%  perf-profile.children.cycles-pp.xfs_dabuf_map
      0.10 ±  8%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.workingset_update_node
      0.06 ±  7%      -0.0        0.05 ± 34%  perf-profile.children.cycles-pp.dequeue_entity
      0.04 ± 66%      -0.0        0.02 ±123%  perf-profile.children.cycles-pp.policy_node
      0.02 ±152%      -0.0        0.00        perf-profile.children.cycles-pp.__inc_node_state
      0.12 ±  7%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.schedule_idle
      0.14 ±  6%      -0.0        0.12 ±  9%  perf-profile.children.cycles-pp.__list_add_valid
      0.04 ± 65%      -0.0        0.02 ±124%  perf-profile.children.cycles-pp.__xfs_dir3_free_read
      0.30 ±  5%      -0.0        0.29 ± 14%  perf-profile.children.cycles-pp.xfs_dir_removename
      0.20 ±  7%      -0.0        0.18 ±  7%  perf-profile.children.cycles-pp.aa_file_perm
      0.13 ± 10%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.iomap_page_create
      0.11 ±  6%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.__x64_sys_write
      0.10 ±  7%      -0.0        0.09 ± 12%  perf-profile.children.cycles-pp.xfs_btree_read_buf_block
      0.10 ±  7%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.xfs_buf_lock
      0.10 ±  7%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.down
      0.18 ±  4%      -0.0        0.16 ±  8%  perf-profile.children.cycles-pp.xfs_btree_lookup
      0.12 ±  8%      -0.0        0.10 ± 12%  perf-profile.children.cycles-pp.xfs_buf_unlock
      0.32 ±  3%      -0.0        0.30 ±  6%  perf-profile.children.cycles-pp.xfs_buf_find
      0.10 ±  7%      -0.0        0.09 ±  8%  perf-profile.children.cycles-pp.__down
      0.08 ± 12%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.08 ± 14%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.xfs_bmap_add_extent_hole_delay
      1.08 ±  5%      -0.0        1.07 ±  4%  perf-profile.children.cycles-pp.___might_sleep
      0.29 ±  6%      -0.0        0.28 ± 14%  perf-profile.children.cycles-pp.xfs_dir2_node_removename
      0.19 ±  4%      -0.0        0.18 ±  6%  perf-profile.children.cycles-pp.xfs_iread_extents
      0.13 ±  9%      -0.0        0.12 ± 13%  perf-profile.children.cycles-pp.xfs_buf_item_release
      0.07 ±  8%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.03 ± 82%      -0.0        0.02 ±123%  perf-profile.children.cycles-pp.get_task_policy
      0.07 ± 12%      -0.0        0.06 ± 12%  perf-profile.children.cycles-pp.enqueue_entity
      0.09 ±  7%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.schedule_timeout
      0.06 ± 10%      -0.0        0.05 ± 35%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.82 ±  7%      -0.0        0.81 ±  8%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.37 ±  6%      -0.0        0.36 ±  6%  perf-profile.children.cycles-pp.current_time
      0.22 ±  6%      -0.0        0.21 ±  8%  perf-profile.children.cycles-pp.page_mapping
      0.14 ±  9%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.file_remove_privs
      0.09 ±  7%      -0.0        0.08 ± 19%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      0.08 ±  9%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.xfs_perag_get
      0.06 ± 12%      -0.0        0.06 ± 54%  perf-profile.children.cycles-pp.xfs_log_ticket_ungrant
      0.07 ± 12%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.xfs_mod_fdblocks
      0.29 ±  5%      -0.0        0.28 ± 14%  perf-profile.children.cycles-pp.xfs_da3_node_lookup_int
      0.33 ±  4%      -0.0        0.32 ±  7%  perf-profile.children.cycles-pp.xfs_buf_get_map
      0.18 ±  5%      -0.0        0.17 ±  6%  perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.12 ±  7%      -0.0        0.12 ± 14%  perf-profile.children.cycles-pp.xfs_dir2_leafn_lookup_for_entry
      0.11 ±  9%      -0.0        0.10 ± 13%  perf-profile.children.cycles-pp.up
      0.09 ±  8%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.unlock_page_memcg
      0.08 ± 12%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.38 ±  6%      -0.0        0.38 ±  4%  perf-profile.children.cycles-pp.xfs_break_leased_layouts
      0.30 ±  7%      -0.0        0.29 ±  4%  perf-profile.children.cycles-pp.node_dirty_ok
      0.11 ±  7%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.07 ± 12%      -0.0        0.06 ±  4%  perf-profile.children.cycles-pp.iov_iter_init
      1.46 ±  9%      -0.0        1.45 ±  7%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.23 ±  4%      -0.0        0.23 ± 16%  perf-profile.children.cycles-pp.xfs_da_read_buf
      0.10 ±  6%      -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.08 ±  7%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.fprintf
      0.04 ± 50%      -0.0        0.03 ± 83%  perf-profile.children.cycles-pp._xfs_buf_obj_cmp
      0.52 ±  3%      -0.0        0.51 ±  8%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      0.38 ±  2%      -0.0        0.37 ±  7%  perf-profile.children.cycles-pp.xas_start
      0.36 ±  9%      -0.0        0.36 ±  9%  perf-profile.children.cycles-pp.generic_write_checks
      0.35 ±  3%      -0.0        0.34 ±  7%  perf-profile.children.cycles-pp.xfs_buf_read_map
      0.13 ±  9%      -0.0        0.12 ± 11%  perf-profile.children.cycles-pp.xfs_vn_lookup
      0.13 ±  7%      -0.0        0.12 ± 15%  perf-profile.children.cycles-pp.xfs_dir3_data_check
      0.11 ± 11%      -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.rw_verify_area
      0.06 ± 11%      -0.0        0.05 ± 37%  perf-profile.children.cycles-pp.xfs_dir3_data_read
      0.17 ±  7%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.84 ±  4%      -0.0        0.84 ±  4%  perf-profile.children.cycles-pp.xas_store
      0.86 ±  5%      -0.0        0.86 ±  4%  perf-profile.children.cycles-pp.security_file_permission
      0.16 ±  8%      -0.0        0.16 ± 13%  perf-profile.children.cycles-pp.xfs_trans_alloc
      0.19 ±  5%      -0.0        0.18 ± 11%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.13 ±  8%      -0.0        0.12 ± 15%  perf-profile.children.cycles-pp.__xfs_dir3_data_check
      0.14 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.xas_create
      0.14 ±  7%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.09 ± 13%      -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.07 ±  5%      -0.0        0.06 ± 10%  perf-profile.children.cycles-pp.balance_dirty_pages
      0.03 ± 81%      -0.0        0.02 ±100%  perf-profile.children.cycles-pp.update_curr
      0.03 ± 81%      -0.0        0.02 ±100%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.01 ±200%      -0.0        0.01 ±299%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.01 ±299%      -0.0        0.00        perf-profile.children.cycles-pp.obj_cgroup_charge_pages
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.alloc_empty_file
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_trans_dirty_buf
      0.06 ± 12%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.PageHuge
      0.83 ±  5%      -0.0        0.83 ±  4%  perf-profile.children.cycles-pp.__fdget_pos
      0.56 ±  5%      -0.0        0.56 ±  5%  perf-profile.children.cycles-pp.__might_sleep
      0.30 ±  7%      -0.0        0.29 ±  4%  perf-profile.children.cycles-pp.free_unref_page_list
      0.20 ±  7%      -0.0        0.20 ±  6%  perf-profile.children.cycles-pp.__unlock_page_memcg
      0.16 ±  5%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.xa_get_order
      0.14 ±  8%      -0.0        0.13 ± 12%  perf-profile.children.cycles-pp.rcu_do_batch
      0.11 ±  9%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.xas_find_conflict
      0.09 ±  9%      -0.0        0.09 ± 13%  perf-profile.children.cycles-pp.xfs_dir2_node_lookup
      0.12 ±  9%      -0.0        0.11 ± 14%  perf-profile.children.cycles-pp.xfs_dir_lookup
      0.20 ±  7%      -0.0        0.19 ±  6%  perf-profile.children.cycles-pp.file_modified
      0.19 ± 12%      -0.0        0.19 ± 12%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.15 ±  5%      -0.0        0.14 ±  9%  perf-profile.children.cycles-pp._xfs_trans_bjoin
      0.14 ±  7%      -0.0        0.14 ± 14%  perf-profile.children.cycles-pp.xfs_da3_node_read
      0.10 ±  6%      -0.0        0.10 ± 16%  perf-profile.children.cycles-pp.xfs_dir2_leafn_remove
      0.10 ±  9%      -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.page_cache_free_page
      0.05 ± 51%      -0.0        0.05 ± 34%  perf-profile.children.cycles-pp.xas_set_mark
      0.03 ± 81%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.xfs_trans_log_inode
      0.12 ±  9%      -0.0        0.11 ± 13%  perf-profile.children.cycles-pp.xfs_lookup
      0.34 ±  5%      -0.0        0.34 ±  7%  perf-profile.children.cycles-pp.__fsnotify_parent
      1.46 ±  5%      -0.0        1.46 ±  5%  perf-profile.children.cycles-pp.memset_erms
      0.72 ±  4%      -0.0        0.72 ±  5%  perf-profile.children.cycles-pp.__fget_light
      0.12 ±  8%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.14 ±  8%      -0.0        0.14 ± 10%  perf-profile.children.cycles-pp.timestamp_truncate
      0.08 ±  6%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.xas_alloc
      0.08 ± 10%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.times
      0.06 ± 15%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.01 ±200%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.xfs_bmapi_read
      0.15 ±  5%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.11 ±  7%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.xas_find
      2.48 ±  5%      -0.0        2.48 ±  6%  perf-profile.children.cycles-pp.xfs_file_write_checks
      0.15 ±  9%      -0.0        0.15 ± 25%  perf-profile.children.cycles-pp.xfs_dir_createname
      0.14 ±  8%      -0.0        0.14 ± 22%  perf-profile.children.cycles-pp.xfs_dir2_node_addname
      0.10 ±  6%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.update_load_avg
      0.12 ± 10%      -0.0        0.12 ± 14%  perf-profile.children.cycles-pp.kmem_cache_free
      0.08 ± 10%      -0.0        0.08 ± 27%  perf-profile.children.cycles-pp.xfs_dir2_node_addname_int
      0.07 ± 10%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.vfprintf
      0.06 ± 15%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.14 ±  4%      +0.0        0.14 ±  6%  perf-profile.children.cycles-pp.xas_clear_mark
      0.13 ±  7%      +0.0        0.13 ± 12%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.13 ± 11%      +0.0        0.13 ± 11%  perf-profile.children.cycles-pp.xfs_inode_item_format
      0.10 ± 10%      +0.0        0.10 ± 13%  perf-profile.children.cycles-pp.xfs_get_extsz_hint
      0.02 ±152%      +0.0        0.02 ±152%  perf-profile.children.cycles-pp.xfs_trans_log_buf
      0.01 ±300%      +0.0        0.01 ±299%  perf-profile.children.cycles-pp.mod_objcg_state
      0.18 ±  7%      +0.0        0.18 ±  8%  perf-profile.children.cycles-pp.__xa_set_mark
      0.12 ±  9%      +0.0        0.12 ± 17%  perf-profile.children.cycles-pp.xfs_log_reserve
      0.09 ±  6%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.node_page_state
      0.07 ±  8%      +0.0        0.08 ± 17%  perf-profile.children.cycles-pp.task_tick_fair
      0.06 ± 12%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.xfs_buf_rele
      0.05 ± 52%      +0.0        0.05 ± 52%  perf-profile.children.cycles-pp.xfs_iextents_copy
      0.07 ±  8%      +0.0        0.07 ± 15%  perf-profile.children.cycles-pp.xfs_buf_item_init
      0.01 ±300%      +0.0        0.01 ±300%  perf-profile.children.cycles-pp.__generic_file_write_iter
      0.13 ± 12%      +0.0        0.13 ± 15%  perf-profile.children.cycles-pp.xfs_trans_reserve
      0.06 ± 35%      +0.0        0.06 ± 37%  perf-profile.children.cycles-pp.xfs_inode_item_format_data_fork
      0.05 ± 35%      +0.0        0.05 ±  7%  perf-profile.children.cycles-pp.memcg_check_events
      0.04 ± 51%      +0.0        0.05 ± 53%  perf-profile.children.cycles-pp.xfs_verify_dir_ino
      1.54 ±  5%      +0.0        1.54 ±  4%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.26 ±  8%      +0.0        0.26 ± 10%  perf-profile.children.cycles-pp.__count_memcg_events
      0.18 ±  6%      +0.0        0.18 ±  9%  perf-profile.children.cycles-pp.rcu_core
      0.09 ± 13%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.wait_for_stable_page
      0.26 ±  7%      +0.0        0.26 ±  9%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.generic_perform_write
      0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.xfs_btree_get_block
      0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.xlog_ioend_work
      0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.xlog_state_do_callback
      0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.xfs_btree_check_block
      0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.down_read
      0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.xfs_buf_offset
      1.01 ±  4%      +0.0        1.02 ± 12%  perf-profile.children.cycles-pp.file_update_time
      0.06 ±  8%      +0.0        0.06 ± 26%  perf-profile.children.cycles-pp.xfs_init_new_inode
      0.38 ±  6%      +0.0        0.39 ± 19%  perf-profile.children.cycles-pp._raw_spin_lock
      0.19 ±  8%      +0.0        0.19 ±  6%  perf-profile.children.cycles-pp.xfs_iunlink_remove
      0.16 ± 10%      +0.0        0.17 ± 12%  perf-profile.children.cycles-pp.try_to_wake_up
      0.05 ± 35%      +0.0        0.06 ± 38%  perf-profile.children.cycles-pp.xlog_grant_add_space
      0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.xfs_iget
      0.18 ±  4%      +0.0        0.19 ±  5%  perf-profile.children.cycles-pp.xas_init_marks
      0.05 ± 34%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.__x64_sys_times
      0.05 ± 36%      +0.0        0.06 ± 15%  perf-profile.children.cycles-pp.dec_zone_page_state
      0.20 ±  9%      +0.0        0.20 ±  5%  perf-profile.children.cycles-pp.alloc_pages
      0.47 ±  6%      +0.0        0.48 ±  4%  perf-profile.children.cycles-pp.xfs_iext_lookup_extent
      0.10 ±  8%      +0.0        0.11 ± 19%  perf-profile.children.cycles-pp.rwsem_wake
      0.09 ± 10%      +0.0        0.10 ± 18%  perf-profile.children.cycles-pp.wake_up_q
      0.02 ±152%      +0.0        0.02 ±100%  perf-profile.children.cycles-pp.thread_group_cputime_adjusted
      0.00            +0.0        0.01 ±200%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +0.0        0.01 ±200%  perf-profile.children.cycles-pp.thread_group_cputime
      0.00            +0.0        0.01 ±200%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.00            +0.0        0.01 ±200%  perf-profile.children.cycles-pp.xfs_iext_get_extent
      0.00            +0.0        0.01 ±200%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.0        0.01 ±200%  perf-profile.children.cycles-pp.__switch_to_asm
      0.64 ±  4%      +0.0        0.66 ±  4%  perf-profile.children.cycles-pp.xfs_break_layouts
      0.02 ±122%      +0.0        0.03 ± 82%  perf-profile.children.cycles-pp.free_pcp_prepare
      0.02 ±122%      +0.0        0.03 ± 82%  perf-profile.children.cycles-pp.do_sys_times
      0.00            +0.0        0.01 ±201%  perf-profile.children.cycles-pp.xfs_btree_rec_offset
      0.08 ±  6%      +0.0        0.09 ± 11%  perf-profile.children.cycles-pp.rebalance_domains
      0.05 ±  9%      +0.0        0.07 ± 12%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.11 ± 10%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.05 ± 34%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.05 ± 34%      +0.0        0.06 ± 20%  perf-profile.children.cycles-pp.xfs_ialloc_read_agi
      0.07 ± 12%      +0.0        0.08 ± 11%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.04 ± 50%      +0.0        0.06 ± 14%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.0        0.02 ±152%  perf-profile.children.cycles-pp.flush_pending_writes
      0.00            +0.0        0.02 ±152%  perf-profile.children.cycles-pp.brd_do_bvec
      0.00            +0.0        0.02 ±153%  perf-profile.children.cycles-pp.io_serial_in
      0.27 ± 10%      +0.0        0.29 ±  8%  perf-profile.children.cycles-pp.uncharge_page
      0.04 ± 50%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.07 ± 12%      +0.0        0.09 ± 11%  perf-profile.children.cycles-pp.xfs_isilocked
      1.24 ±  5%      +0.0        1.25 ±  3%  perf-profile.children.cycles-pp.__entry_text_start
      0.00            +0.0        0.02 ±122%  perf-profile.children.cycles-pp.brd_submit_bio
      0.00            +0.0        0.02 ±122%  perf-profile.children.cycles-pp.md_thread
      0.00            +0.0        0.02 ±122%  perf-profile.children.cycles-pp.raid1d
      0.00            +0.0        0.02 ±122%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.0        0.02 ±122%  perf-profile.children.cycles-pp.tick_irq_enter
      0.04 ± 65%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.native_sched_clock
      0.36 ±  7%      +0.0        0.38 ±  5%  perf-profile.children.cycles-pp.xfs_errortag_test
      0.28 ±  3%      +0.0        0.30 ±  7%  perf-profile.children.cycles-pp.__schedule
      0.04 ± 50%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +0.0        0.02 ±123%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.04 ± 50%      +0.0        0.07 ± 12%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.0        0.02 ±100%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.0        0.02 ±100%  perf-profile.children.cycles-pp.xlog_cil_push_work
      0.06 ± 12%      +0.0        0.08 ± 12%  perf-profile.children.cycles-pp.xfs_iunlink_update_inode
      0.03 ± 81%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.serial8250_console_write
      0.03 ± 81%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.03 ± 81%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.03 ± 81%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.03 ± 81%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.irq_work_run
      0.03 ± 81%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.irq_work_single
      0.00            +0.0        0.03 ±100%  perf-profile.children.cycles-pp.flush_bio_list
      0.40 ±  7%      +0.0        0.43 ± 29%  perf-profile.children.cycles-pp.xfs_vn_update_time
      0.03 ± 81%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.printk
      0.03 ± 81%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.vprintk_emit
      0.03 ± 81%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.console_unlock
      0.04 ± 65%      +0.0        0.06 ± 10%  perf-profile.children.cycles-pp.update_blocked_averages
      0.03 ± 81%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.irq_work_run_list
      0.08 ± 14%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp.write@plt
      0.00            +0.0        0.03 ± 82%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +0.0        0.03 ± 82%  perf-profile.children.cycles-pp.submit_bio_noacct
      0.00            +0.0        0.03 ± 83%  perf-profile.children.cycles-pp.xfs_buf_item_size_segment
      0.00            +0.0        0.04 ± 65%  perf-profile.children.cycles-pp.__page_cache_alloc
      0.16 ±  6%      +0.0        0.20 ±  4%  perf-profile.children.cycles-pp.menu_select
      0.32 ±  5%      +0.0        0.36 ±  9%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.18 ±  5%      +0.0        0.22 ±  9%  perf-profile.children.cycles-pp.scheduler_tick
      0.17 ±  4%      +0.0        0.21 ±  7%  perf-profile.children.cycles-pp.schedule
      0.01 ±200%      +0.0        0.05 ±  8%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.01 ±200%      +0.0        0.05 ±  8%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.01 ±200%      +0.0        0.05 ±  9%  perf-profile.children.cycles-pp.uart_console_write
      0.12 ±  8%      +0.0        0.17 ±  5%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.02 ±153%      +0.0        0.06 ± 14%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.00            +0.0        0.05 ± 34%  perf-profile.children.cycles-pp.xfs_verify_agino
      0.08 ± 13%      +0.1        0.13 ± 10%  perf-profile.children.cycles-pp.xfs_iunlink
      0.35 ±  5%      +0.1        0.40 ±  7%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.30 ±  7%      +0.1        0.36 ± 10%  perf-profile.children.cycles-pp.clockevents_program_event
      0.02 ±123%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.xfs_imap_to_bp
      0.00            +0.1        0.05 ± 38%  perf-profile.children.cycles-pp.xfs_buf_item_size
      0.05 ± 34%      +0.1        0.10 ±  7%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.05 ±  9%      +0.1        0.11 ± 10%  perf-profile.children.cycles-pp.load_balance
      0.01 ±200%      +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.1        0.06 ± 10%  perf-profile.children.cycles-pp.xfs_inobt_btrec_to_irec
      0.08 ± 16%      +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.lru_add_drain
      0.08 ± 16%      +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.09 ±  9%      +0.1        0.16 ±  9%  perf-profile.children.cycles-pp.xfs_difree_finobt
      0.30 ±  3%      +0.1        0.37 ±  7%  perf-profile.children.cycles-pp.tick_sched_handle
      0.01 ±299%      +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.xfs_inobt_irec_to_allocmask
      0.29 ±  4%      +0.1        0.36 ±  7%  perf-profile.children.cycles-pp.update_process_times
      0.00            +0.1        0.07 ± 13%  perf-profile.children.cycles-pp.xfs_next_bit
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.newidle_balance
      0.33 ±  2%      +0.1        0.41 ±  7%  perf-profile.children.cycles-pp.tick_sched_timer
      0.33 ±  6%      +0.1        0.41 ± 10%  perf-profile.children.cycles-pp.ktime_get
      0.30 ±  6%      +0.1        0.38 ±  6%  perf-profile.children.cycles-pp.disk_wrt
      0.00            +0.1        0.09 ±  8%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.44 ±  2%      +0.1        0.53 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +0.1        0.10 ±  9%  perf-profile.children.cycles-pp.find_busiest_group
      0.09 ±  8%      +0.1        0.19 ± 12%  perf-profile.children.cycles-pp.__xfs_btree_check_sblock
      0.31 ±  4%      +0.1        0.43 ±  5%  perf-profile.children.cycles-pp.xfs_difree_inobt
      0.72 ±  5%      +0.1        0.84 ± 15%  perf-profile.children.cycles-pp.vfs_unlink
      0.70 ±  5%      +0.1        0.82 ± 15%  perf-profile.children.cycles-pp.xfs_remove
      0.70 ±  5%      +0.1        0.82 ± 15%  perf-profile.children.cycles-pp.xfs_vn_unlink
      0.89 ±  6%      +0.1        1.02 ± 14%  perf-profile.children.cycles-pp.do_unlinkat
      0.97 ±  6%      +0.1        1.10 ± 14%  perf-profile.children.cycles-pp.unlink
      0.14 ±  6%      +0.2        0.30 ± 11%  perf-profile.children.cycles-pp.xfs_btree_get_rec
      0.14 ±  7%      +0.2        0.30 ±  6%  perf-profile.children.cycles-pp.xfs_btree_increment
      0.82 ±  3%      +0.2        0.99 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.15 ±  7%      +0.2        0.32 ±  9%  perf-profile.children.cycles-pp.xfs_btree_check_sblock
      0.83 ±  3%      +0.2        1.00 ±  6%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.62 ±  6%      +0.2        0.80 ±  5%  perf-profile.children.cycles-pp.xfs_ifree
      0.41 ±  5%      +0.2        0.59 ±  5%  perf-profile.children.cycles-pp.xfs_difree
      0.16 ±  8%      +0.2        0.36 ± 12%  perf-profile.children.cycles-pp.memcpy_erms
      0.19 ±  7%      +0.2        0.44 ± 12%  perf-profile.children.cycles-pp.xfs_buf_item_format_segment
      0.20 ±  6%      +0.2        0.45 ± 12%  perf-profile.children.cycles-pp.xfs_buf_item_format
      0.65 ±  5%      +0.3        0.90 ± 12%  perf-profile.children.cycles-pp.xlog_cil_insert_items
      1.29 ±  2%      +0.3        1.56 ±  6%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.13 ±  5%      +0.3        1.41 ± 11%  perf-profile.children.cycles-pp.__xfs_trans_commit
      0.92 ±  6%      +0.3        1.19 ± 16%  perf-profile.children.cycles-pp.xfs_generic_create
      0.90 ±  6%      +0.3        1.17 ± 17%  perf-profile.children.cycles-pp.xfs_create
      0.35 ±  6%      +0.3        0.62 ± 16%  perf-profile.children.cycles-pp.xfs_dialloc
      1.11 ±  5%      +0.3        1.39 ± 11%  perf-profile.children.cycles-pp.xlog_cil_commit
      1.40 ±  2%      +0.3        1.69 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.45 ±  4%      +0.3        1.75 ± 12%  perf-profile.children.cycles-pp.creat64
      0.27 ±  5%      +0.3        0.58 ±  9%  perf-profile.children.cycles-pp.xfs_inobt_get_rec
      1.40 ±  4%      +0.3        1.70 ± 13%  perf-profile.children.cycles-pp.do_sys_open
      1.39 ±  4%      +0.3        1.70 ± 13%  perf-profile.children.cycles-pp.do_sys_openat2
      1.35 ±  4%      +0.3        1.66 ± 13%  perf-profile.children.cycles-pp.path_openat
      1.35 ±  4%      +0.3        1.66 ± 13%  perf-profile.children.cycles-pp.do_filp_open
      1.01 ±  5%      +0.3        1.32 ±  4%  perf-profile.children.cycles-pp.xfs_inactive
      0.85 ±  5%      +0.4        1.22 ±  4%  perf-profile.children.cycles-pp.xfs_inactive_ifree
      0.53 ±  4%      +0.5        0.99 ±  7%  perf-profile.children.cycles-pp.xfs_check_agi_freecount
     19.28 ±  5%      +0.5       19.77 ±  3%  perf-profile.children.cycles-pp.iomap_write_begin
     13.09 ±  6%      +0.6       13.71 ±  4%  perf-profile.children.cycles-pp.grab_cache_page_write_begin
     12.91 ±  6%      +0.6       13.53 ±  4%  perf-profile.children.cycles-pp.pagecache_get_page
      9.02 ±  8%      +0.8        9.82 ±  6%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      2.68 ±  8%      +1.0        3.65 ± 11%  perf-profile.children.cycles-pp.lru_cache_add
      7.50 ±  6%      +1.0        8.49 ±  6%  perf-profile.children.cycles-pp.evict
      7.48 ±  6%      +1.0        8.46 ±  6%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      3.38 ±  7%      +1.0        4.42 ±  9%  perf-profile.children.cycles-pp.release_pages
      2.59 ±  9%      +1.1        3.64 ± 12%  perf-profile.children.cycles-pp.__pagevec_lru_add
      3.33 ±  8%      +1.1        4.44 ± 10%  perf-profile.children.cycles-pp.__pagevec_release
      0.00            +1.3        1.34 ±  4%  perf-profile.children.cycles-pp.xfs_inodegc_worker
      0.00            +1.4        1.45 ±  4%  perf-profile.children.cycles-pp.process_one_work
      0.00            +1.5        1.45 ±  4%  perf-profile.children.cycles-pp.worker_thread
      0.01 ±299%      +1.5        1.52 ±  3%  perf-profile.children.cycles-pp.kthread
      0.01 ±299%      +1.5        1.52 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
      2.08 ± 15%      +2.2        4.30 ± 19%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.79 ± 18%      +2.2        4.03 ± 20%  perf-profile.children.cycles-pp.lock_page_lruvec_irqsave
      1.80 ± 18%      +2.2        4.05 ± 19%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     34.49 ±  7%      -1.4       33.13 ±  5%  perf-profile.self.cycles-pp.intel_idle
      6.13 ±  4%      -0.2        5.97 ±  4%  perf-profile.self.cycles-pp.iomap_set_range_uptodate
      3.28 ± 11%      -0.1        3.14 ± 10%  perf-profile.self.cycles-pp.__mod_memcg_state
      1.10 ±  8%      -0.1        0.99 ±  5%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_begin
      1.50 ±  5%      -0.1        1.40 ±  5%  perf-profile.self.cycles-pp.pagecache_get_page
      0.93 ±  4%      -0.1        0.83 ±  5%  perf-profile.self.cycles-pp.down_write
      0.52 ±  5%      -0.1        0.43 ±  6%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_end
      0.59 ± 10%      -0.1        0.51 ±  3%  perf-profile.self.cycles-pp.xfs_file_write_iter
      1.79 ±  7%      -0.1        1.72 ±  9%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      1.87 ±  4%      -0.1        1.80 ±  4%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.48 ±  4%      -0.1        0.41 ±  3%  perf-profile.self.cycles-pp.page_counter_cancel
      1.43 ± 11%      -0.1        1.36 ± 10%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.47 ±  6%      -0.1        0.41 ±  3%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.98 ±  5%      -0.1        0.92 ±  5%  perf-profile.self.cycles-pp.write
      0.56 ±  9%      -0.1        0.50 ±  6%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      1.32 ±  4%      -0.1        1.27 ±  5%  perf-profile.self.cycles-pp.iomap_apply
      1.04 ±  4%      -0.1        0.99 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.61 ±  3%      -0.0        0.57 ±  5%  perf-profile.self.cycles-pp.xas_load
      0.58 ±  6%      -0.0        0.54 ±  8%  perf-profile.self.cycles-pp.lock_page_memcg
      0.69 ±  5%      -0.0        0.65 ±  4%  perf-profile.self.cycles-pp.iomap_write_end
      0.85 ±  5%      -0.0        0.82 ±  6%  perf-profile.self.cycles-pp.vfs_write
      0.38 ±  4%      -0.0        0.35 ±  6%  perf-profile.self.cycles-pp.new_sync_write
      0.76 ±  6%      -0.0        0.73 ±  4%  perf-profile.self.cycles-pp.up_write
      0.69 ±  6%      -0.0        0.66 ±  6%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.34 ±  5%      -0.0        0.31 ±  6%  perf-profile.self.cycles-pp.xfs_bmbt_to_iomap
      0.36 ±  7%      -0.0        0.33 ±  6%  perf-profile.self.cycles-pp.xfs_iunlock
      0.67 ±  8%      -0.0        0.65 ±  6%  perf-profile.self.cycles-pp.xfs_file_buffered_write
      0.47 ±  7%      -0.0        0.44 ±  7%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.77 ±  4%      -0.0        0.74 ±  6%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.05 ± 34%      -0.0        0.02 ±122%  perf-profile.self.cycles-pp.xa_get_order
      0.18 ±  7%      -0.0        0.15 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.26 ±  7%      -0.0        0.23 ±  6%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.44 ±  7%      -0.0        0.42 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.77 ±  3%      -0.0        0.75 ±  5%  perf-profile.self.cycles-pp.iomap_write_begin
      0.16 ± 10%      -0.0        0.14 ±  7%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.45 ±  5%      -0.0        0.43 ±  5%  perf-profile.self.cycles-pp.unlock_page
      0.29 ±  6%      -0.0        0.27 ±  7%  perf-profile.self.cycles-pp.__cond_resched
      0.63 ±  5%      -0.0        0.62 ±  3%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.06 ± 11%      -0.0        0.04 ± 67%  perf-profile.self.cycles-pp.iomap_adjust_read_range
      0.18 ±  6%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.rcu_all_qs
      0.30 ±  9%      -0.0        0.28 ± 13%  perf-profile.self.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.18 ±  4%      -0.0        0.17 ±  9%  perf-profile.self.cycles-pp.__set_page_dirty
      0.39 ±  5%      -0.0        0.37 ±  5%  perf-profile.self.cycles-pp.find_lock_entries
      0.13 ±  9%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.iomap_page_create
      0.30 ±  4%      -0.0        0.28 ±  6%  perf-profile.self.cycles-pp.xfs_ilock
      0.30 ±  7%      -0.0        0.29 ±  4%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.02 ±152%      -0.0        0.00        perf-profile.self.cycles-pp.__inc_node_state
      0.14 ±  9%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.lru_cache_add
      0.09 ±  9%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.__x64_sys_write
      0.06 ± 10%      -0.0        0.04 ± 68%  perf-profile.self.cycles-pp.xfs_log_ticket_ungrant
      0.35 ±  5%      -0.0        0.34 ±  6%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.22 ±  6%      -0.0        0.20 ±  8%  perf-profile.self.cycles-pp.page_mapping
      0.19 ±  5%      -0.0        0.18 ±  6%  perf-profile.self.cycles-pp.xfs_iread_extents
      0.10 ±  8%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.workingset_update_node
      0.36 ±  7%      -0.0        0.35 ±  5%  perf-profile.self.cycles-pp.__add_to_page_cache_locked
      0.25 ±  6%      -0.0        0.24 ±  6%  perf-profile.self.cycles-pp.file_update_time
      0.13 ±  6%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.__list_add_valid
      0.06 ±  8%      -0.0        0.04 ± 51%  perf-profile.self.cycles-pp.add_to_page_cache_lru
      0.05 ± 34%      -0.0        0.04 ± 65%  perf-profile.self.cycles-pp.update_load_avg
      0.04 ± 50%      -0.0        0.03 ±102%  perf-profile.self.cycles-pp._xfs_buf_obj_cmp
      0.51 ±  5%      -0.0        0.50 ±  6%  perf-profile.self.cycles-pp.__might_sleep
      0.03 ±100%      -0.0        0.02 ±153%  perf-profile.self.cycles-pp.xfs_inode_item_format
      0.06 ±  8%      -0.0        0.05 ± 35%  perf-profile.self.cycles-pp.__schedule
      0.58 ±  5%      -0.0        0.57 ±  6%  perf-profile.self.cycles-pp.__pagevec_lru_add
      0.34 ±  3%      -0.0        0.33 ±  7%  perf-profile.self.cycles-pp.xas_start
      0.21 ±  7%      -0.0        0.20 ±  7%  perf-profile.self.cycles-pp.iomap_file_buffered_write
      0.20 ±  9%      -0.0        0.19 ±  6%  perf-profile.self.cycles-pp.node_dirty_ok
      0.48 ±  4%      -0.0        0.47 ±  6%  perf-profile.self.cycles-pp.release_pages
      0.19 ±  6%      -0.0        0.18 ±  9%  perf-profile.self.cycles-pp.rmqueue
      0.04 ± 50%      -0.0        0.03 ± 82%  perf-profile.self.cycles-pp.kmem_cache_free
      1.05 ±  5%      -0.0        1.05 ±  3%  perf-profile.self.cycles-pp.___might_sleep
      0.33 ±  6%      -0.0        0.32 ±  7%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.16 ±  6%      -0.0        0.15 ±  7%  perf-profile.self.cycles-pp.__cancel_dirty_page
      0.13 ±  6%      -0.0        0.13 ±  6%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.10 ± 10%      -0.0        0.09 ± 10%  perf-profile.self.cycles-pp.rw_verify_area
      0.08 ± 11%      -0.0        0.07 ±  9%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.12 ±  6%      -0.0        0.11 ±  7%  perf-profile.self.cycles-pp.rcu_read_unlock_strict
      0.41 ±  5%      -0.0        0.40 ±  7%  perf-profile.self.cycles-pp.__set_page_dirty_nobuffers
      0.37 ±  6%      -0.0        0.36 ±  4%  perf-profile.self.cycles-pp.xfs_break_leased_layouts
      0.08 ±  6%      -0.0        0.07 ± 14%  perf-profile.self.cycles-pp.unlock_page_memcg
      0.14 ± 10%      -0.0        0.14 ±  6%  perf-profile.self.cycles-pp.current_time
      0.11 ±  9%      -0.0        0.11 ±  9%  perf-profile.self.cycles-pp.truncate_cleanup_page
      0.61 ±  6%      -0.0        0.60 ±  2%  perf-profile.self.cycles-pp.iomap_write_actor
      0.18 ±  7%      -0.0        0.18 ± 10%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.16 ±  7%      -0.0        0.15 ±  7%  perf-profile.self.cycles-pp.aa_file_perm
      0.13 ±  7%      -0.0        0.13 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.13 ±  9%      -0.0        0.12 ±  9%  perf-profile.self.cycles-pp.file_remove_privs
      0.06 ± 11%      -0.0        0.05 ±  5%  perf-profile.self.cycles-pp.iov_iter_init
      0.03 ±100%      -0.0        0.02 ±122%  perf-profile.self.cycles-pp.get_task_policy
      0.05 ± 52%      -0.0        0.04 ± 50%  perf-profile.self.cycles-pp.xas_set_mark
      0.51 ±  5%      -0.0        0.50 ±  5%  perf-profile.self.cycles-pp.common_file_perm
      0.18 ±  9%      -0.0        0.18 ±  8%  perf-profile.self.cycles-pp.__unlock_page_memcg
      0.11 ± 10%      -0.0        0.10 ± 11%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.10 ± 11%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.07 ±  8%      -0.0        0.07 ± 16%  perf-profile.self.cycles-pp._xfs_trans_bjoin
      0.06 ± 11%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.03 ± 81%      -0.0        0.02 ±100%  perf-profile.self.cycles-pp.PageHuge
      0.03 ± 81%      -0.0        0.02 ±100%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.xfs_trans_dirty_buf
      0.14 ±  9%      -0.0        0.13 ± 11%  perf-profile.self.cycles-pp.account_page_cleaned
      0.69 ±  4%      -0.0        0.68 ±  5%  perf-profile.self.cycles-pp.__fget_light
      0.18 ±  7%      -0.0        0.18 ±  9%  perf-profile.self.cycles-pp.generic_write_checks
      0.13 ± 12%      -0.0        0.12 ±  8%  perf-profile.self.cycles-pp.__fdget_pos
      0.09 ±  8%      -0.0        0.09 ± 11%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.10 ±  9%      -0.0        0.09 ± 11%  perf-profile.self.cycles-pp.page_cache_free_page
      0.07 ± 11%      -0.0        0.06 ± 17%  perf-profile.self.cycles-pp.__xfs_dir3_data_check
      0.06 ±  7%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.xfs_perag_get
      0.09 ± 10%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.xas_find_conflict
      0.06 ± 14%      -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.lock_page_lruvec_irqsave
      0.25 ±  6%      -0.0        0.25 ±  9%  perf-profile.self.cycles-pp.iov_iter_fault_in_readable
      0.24 ±  9%      -0.0        0.24 ±  7%  perf-profile.self.cycles-pp.ksys_write
      0.09 ± 11%      -0.0        0.09 ± 14%  perf-profile.self.cycles-pp.xfs_get_extsz_hint
      0.07 ± 17%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.uncharge_batch
      0.18 ±  8%      -0.0        0.18 ±  5%  perf-profile.self.cycles-pp.__alloc_pages
      0.18 ± 12%      -0.0        0.17 ± 12%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.15 ±  6%      -0.0        0.15 ±  8%  perf-profile.self.cycles-pp.do_syscall_64
      0.12 ±  4%      -0.0        0.11 ±  7%  perf-profile.self.cycles-pp.security_file_permission
      0.12 ±  7%      -0.0        0.12 ± 10%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.07 ±  9%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.free_unref_page_list
      0.05 ± 52%      -0.0        0.04 ± 51%  perf-profile.self.cycles-pp.free_unref_page_prepare
      0.08 ± 12%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.copyin
      0.06 ± 10%      -0.0        0.06 ± 12%  perf-profile.self.cycles-pp.vfprintf
      0.28 ±  5%      -0.0        0.27 ±  7%  perf-profile.self.cycles-pp.xfs_file_write_checks
      0.12 ±  9%      -0.0        0.12 ± 12%  perf-profile.self.cycles-pp.timestamp_truncate
      0.13 ±  7%      -0.0        0.13 ±  8%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.08 ±  7%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.xas_find
      0.08 ± 13%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.unaccount_page_cache_page
      0.09 ± 15%      -0.0        0.09 ± 11%  perf-profile.self.cycles-pp.wait_for_stable_page
      0.10 ±  8%      +0.0        0.10 ± 18%  perf-profile.self.cycles-pp.xlog_cil_commit
      0.10 ± 10%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.06 ± 16%      +0.0        0.06 ± 12%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.20 ±  7%      +0.0        0.20 ±  7%  perf-profile.self.cycles-pp.xfs_break_layouts
      0.14 ±  8%      +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.try_charge_memcg
      0.09 ± 10%      +0.0        0.09 ±  6%  perf-profile.self.cycles-pp.node_page_state
      0.06 ±  8%      +0.0        0.06 ± 11%  perf-profile.self.cycles-pp.file_modified
      0.04 ± 51%      +0.0        0.04 ± 53%  perf-profile.self.cycles-pp.xfs_verify_dir_ino
      0.36 ±  6%      +0.0        0.37 ±  5%  perf-profile.self.cycles-pp.xas_store
      0.26 ±  8%      +0.0        0.26 ± 10%  perf-profile.self.cycles-pp.__count_memcg_events
      0.14 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.13 ±  5%      +0.0        0.13 ±  7%  perf-profile.self.cycles-pp.xas_clear_mark
      0.08 ± 10%      +0.0        0.09 ± 16%  perf-profile.self.cycles-pp.xlog_cil_insert_items
      0.08 ±  9%      +0.0        0.09 ± 10%  perf-profile.self.cycles-pp.grab_cache_page_write_begin
      0.04 ± 50%      +0.0        0.04 ± 33%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.07 ±  8%      +0.0        0.07 ± 11%  perf-profile.self.cycles-pp.xfs_buf_item_init
      1.45 ±  5%      +0.0        1.45 ±  5%  perf-profile.self.cycles-pp.memset_erms
      0.06 ± 11%      +0.0        0.06 ± 10%  perf-profile.self.cycles-pp.xfs_buf_find
      0.05 ± 35%      +0.0        0.06 ± 39%  perf-profile.self.cycles-pp.xlog_grant_add_space
      0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.brd_do_bvec
      0.00            +0.0        0.01 ±299%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.xfs_btree_rec_offset
      0.06 ± 34%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.xas_create
      0.21 ±  6%      +0.0        0.22 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock
      0.45 ±  6%      +0.0        0.46 ±  4%  perf-profile.self.cycles-pp.xfs_iext_lookup_extent
      0.11 ±  8%      +0.0        0.12 ±  7%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.00            +0.0        0.01 ±200%  perf-profile.self.cycles-pp.__switch_to_asm
      0.01 ±300%      +0.0        0.02 ±153%  perf-profile.self.cycles-pp.write@plt
      0.05 ±  9%      +0.0        0.07 ± 12%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.12 ±  9%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.menu_select
      0.48 ±  6%      +0.0        0.50 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.09 ±  9%      +0.0        0.10 ±  6%  perf-profile.self.cycles-pp.alloc_pages
      0.04 ± 51%      +0.0        0.06 ± 11%  perf-profile.self.cycles-pp.dec_zone_page_state
      0.00            +0.0        0.02 ±153%  perf-profile.self.cycles-pp.io_serial_in
      0.72 ± 13%      +0.0        0.74 ± 12%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.26 ±  9%      +0.0        0.28 ±  7%  perf-profile.self.cycles-pp.uncharge_page
      0.01 ±200%      +0.0        0.03 ± 81%  perf-profile.self.cycles-pp.free_pcp_prepare
      0.04 ± 50%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.03 ± 81%      +0.0        0.05 ±  7%  perf-profile.self.cycles-pp.xas_init_marks
      0.04 ± 51%      +0.0        0.07 ± 14%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.04 ± 50%      +0.0        0.06 ± 10%  perf-profile.self.cycles-pp.update_process_times
      0.05 ± 35%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.xfs_isilocked
      0.00            +0.0        0.02 ±100%  perf-profile.self.cycles-pp.read_tsc
      0.29 ± 10%      +0.0        0.32 ±  5%  perf-profile.self.cycles-pp.xfs_errortag_test
      0.10 ±  8%      +0.0        0.13 ± 10%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.51 ± 14%      +0.0        0.54 ± 12%  perf-profile.self.cycles-pp.mem_cgroup_charge
      0.00            +0.0        0.03 ± 82%  perf-profile.self.cycles-pp.__page_cache_alloc
      0.02 ±122%      +0.0        0.06 ±  8%  perf-profile.self.cycles-pp.native_sched_clock
      0.02 ±153%      +0.0        0.06 ± 14%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.00            +0.0        0.05 ± 34%  perf-profile.self.cycles-pp.xfs_verify_agino
      0.00            +0.1        0.05 ±  9%  perf-profile.self.cycles-pp.xfs_inobt_btrec_to_irec
      0.55 ±  4%      +0.1        0.60 ±  2%  perf-profile.self.cycles-pp.__entry_text_start
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.xfs_buf_item_format_segment
      0.00            +0.1        0.07 ± 16%  perf-profile.self.cycles-pp.xfs_next_bit
      0.30 ±  8%      +0.1        0.37 ± 11%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.1        0.07 ±  8%  perf-profile.self.cycles-pp.xfs_btree_check_sblock
      0.00            +0.1        0.07 ±  9%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.02 ±100%      +0.1        0.10 ± 10%  perf-profile.self.cycles-pp.xfs_inobt_get_rec
      0.02 ±152%      +0.1        0.09 ±  9%  perf-profile.self.cycles-pp.xfs_btree_increment
      0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.xfs_btree_get_rec
      0.08 ±  8%      +0.1        0.17 ± 12%  perf-profile.self.cycles-pp.__xfs_btree_check_sblock
      0.22 ±  6%      +0.1        0.31 ±  6%  perf-profile.self.cycles-pp.disk_wrt
      0.16 ±  7%      +0.2        0.36 ± 13%  perf-profile.self.cycles-pp.memcpy_erms
      1.80 ± 18%      +2.2        4.05 ± 19%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.00          -100.0%       0.00        interrupts.0:IO-APIC.2-edge.timer
      1.20 ±222%   +3158.3%      39.10 ±214%  interrupts.100:PCI-MSI.31981633-edge.i40e-eth0-TxRx-64
      1.00 ±268%    +130.0%       2.30 ±200%  interrupts.101:PCI-MSI.31981634-edge.i40e-eth0-TxRx-65
      1.40 ±300%   +2157.1%      31.60 ±253%  interrupts.102:PCI-MSI.31981635-edge.i40e-eth0-TxRx-66
      1.00 ±236%    -100.0%       0.00        interrupts.103:PCI-MSI.31981636-edge.i40e-eth0-TxRx-67
     10.50 ±247%     -50.5%       5.20 ±247%  interrupts.104:PCI-MSI.31981637-edge.i40e-eth0-TxRx-68
      6089 ±299%    -100.0%       1.50 ±256%  interrupts.105:PCI-MSI.31981638-edge.i40e-eth0-TxRx-69
      0.00       +2.7e+102%       2.70 ±287%  interrupts.106:PCI-MSI.31981639-edge.i40e-eth0-TxRx-70
      6.70 ±270%   +1307.5%      94.30 ±299%  interrupts.107:PCI-MSI.31981640-edge.i40e-eth0-TxRx-71
     37.70 ±285%      +1.6%      38.30 ±298%  interrupts.108:PCI-MSI.31981641-edge.i40e-eth0-TxRx-72
      0.30 ±300%  +13133.3%      39.70 ±281%  interrupts.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
      0.10 ±300%    -100.0%       0.00        interrupts.110:PCI-MSI.31981643-edge.i40e-eth0-TxRx-74
      1.50 ±225%     -93.3%       0.10 ±300%  interrupts.111:PCI-MSI.31981644-edge.i40e-eth0-TxRx-75
      2.40 ±300%     -12.5%       2.10 ±284%  interrupts.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
     56.00 ±212%    -100.0%       0.00        interrupts.113:PCI-MSI.31981646-edge.i40e-eth0-TxRx-77
      0.00       +2.8e+102%       2.80 ±188%  interrupts.114:PCI-MSI.31981647-edge.i40e-eth0-TxRx-78
     18.10 ±300%    -100.0%       0.00        interrupts.115:PCI-MSI.31981648-edge.i40e-eth0-TxRx-79
      1.10 ±300%     -90.9%       0.10 ±300%  interrupts.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
      0.00       +1.8e+102%       1.80 ±300%  interrupts.117:PCI-MSI.31981650-edge.i40e-eth0-TxRx-81
      1.30 ±275%     -69.2%       0.40 ±300%  interrupts.118:PCI-MSI.31981651-edge.i40e-eth0-TxRx-82
     28.90 ±203%     -91.7%       2.40 ±229%  interrupts.119:PCI-MSI.31981652-edge.i40e-eth0-TxRx-83
      0.00       +1.2e+102%       1.20 ±300%  interrupts.120:PCI-MSI.31981653-edge.i40e-eth0-TxRx-84
      0.90 ±265%     +44.4%       1.30 ±300%  interrupts.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
      1.20 ±229%    +683.3%       9.40 ±237%  interrupts.122:PCI-MSI.31981655-edge.i40e-eth0-TxRx-86
      1.30 ±299%     -69.2%       0.40 ±229%  interrupts.123:PCI-MSI.31981656-edge.i40e-eth0-TxRx-87
      0.00          -100.0%       0.00        interrupts.281:PCI-MSI.327680-edge.xhci_hcd
      0.00          -100.0%       0.00        interrupts.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.285:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.287:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.288:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.289:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.290:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.291:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.291:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.292:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.293:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.293:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.295:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.295:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.296:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.296:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.297:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.297:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.297:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.298:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.298:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.298:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.299:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.299:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.299:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.300:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.300:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.300:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.301:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.301:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.301:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.302:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.302:PCI-MSI.67188736-edge.ioat-msix
      1.00 ±100%      +0.0%       1.00 ±100%  interrupts.303:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.303:PCI-MSI.67188736-edge.ioat-msix
      4.40 ±271%     -50.0%       2.20 ±227%  interrupts.36:PCI-MSI.31981569-edge.i40e-eth0-TxRx-0
      0.60 ±300%     -83.3%       0.10 ±300%  interrupts.37:PCI-MSI.31981570-edge.i40e-eth0-TxRx-1
     17.40 ±296%    +197.1%      51.70 ±276%  interrupts.38:PCI-MSI.31981571-edge.i40e-eth0-TxRx-2
      5.30 ±300%    +243.4%      18.20 ±298%  interrupts.39:PCI-MSI.31981572-edge.i40e-eth0-TxRx-3
      0.00          -100.0%       0.00        interrupts.3:IO-APIC.3-edge
      5.50 ±222%     +78.2%       9.80 ±184%  interrupts.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
     63.40 ±300%     -92.9%       4.50 ±300%  interrupts.41:PCI-MSI.31981574-edge.i40e-eth0-TxRx-5
     30.70 ±288%     -99.7%       0.10 ±300%  interrupts.42:PCI-MSI.31981575-edge.i40e-eth0-TxRx-6
      0.20 ±300%     -50.0%       0.10 ±300%  interrupts.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
     12.90 ±294%     -97.7%       0.30 ±300%  interrupts.44:PCI-MSI.31981577-edge.i40e-eth0-TxRx-8
      4.70 ±200%    -100.0%       0.00        interrupts.45:PCI-MSI.31981578-edge.i40e-eth0-TxRx-9
     75.10 ±300%     -82.2%      13.40 ±276%  interrupts.46:PCI-MSI.31981579-edge.i40e-eth0-TxRx-10
      1.50 ±300%     -86.7%       0.20 ±300%  interrupts.47:PCI-MSI.31981580-edge.i40e-eth0-TxRx-11
      7.70 ±287%     -92.2%       0.60 ±213%  interrupts.48:PCI-MSI.31981581-edge.i40e-eth0-TxRx-12
      2.50 ±235%     -92.0%       0.20 ±300%  interrupts.49:PCI-MSI.31981582-edge.i40e-eth0-TxRx-13
      0.00          -100.0%       0.00        interrupts.4:IO-APIC.4-edge.ttyS0
      1.80 ±169%     -33.3%       1.20 ±222%  interrupts.50:PCI-MSI.31981583-edge.i40e-eth0-TxRx-14
      2.70 ±287%     -77.8%       0.60 ±199%  interrupts.51:PCI-MSI.31981584-edge.i40e-eth0-TxRx-15
      0.30 ±213%    +233.3%       1.00 ±268%  interrupts.52:PCI-MSI.31981585-edge.i40e-eth0-TxRx-16
      1.60 ±201%     -68.8%       0.50 ±240%  interrupts.53:PCI-MSI.31981586-edge.i40e-eth0-TxRx-17
      0.00         +1e+102%       1.00 ±268%  interrupts.54:PCI-MSI.31981587-edge.i40e-eth0-TxRx-18
      0.00          -100.0%       0.00        interrupts.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
      1.00 ±268%    +130.0%       2.30 ±300%  interrupts.56:PCI-MSI.31981589-edge.i40e-eth0-TxRx-20
     11.80 ±297%     +67.8%      19.80 ±300%  interrupts.57:PCI-MSI.31981590-edge.i40e-eth0-TxRx-21
      1.00         +1520.0%      16.20 ±275%  interrupts.58:PCI-MSI.31981591-edge.i40e-eth0-TxRx-22
      0.00         +9e+101%       0.90 ±300%  interrupts.59:PCI-MSI.31981592-edge.i40e-eth0-TxRx-23
      3.30 ±179%   +1936.4%      67.20 ±297%  interrupts.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
     25.30 ±293%    -100.0%       0.00        interrupts.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
      1.70 ±244%    +305.9%       6.90 ±290%  interrupts.62:PCI-MSI.31981595-edge.i40e-eth0-TxRx-26
      0.00       +1.1e+102%       1.10 ±242%  interrupts.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
     55.60 ±298%   +9406.7%       5285 ±299%  interrupts.64:PCI-MSI.31981597-edge.i40e-eth0-TxRx-28
      3.30 ±185%     -78.8%       0.70 ±221%  interrupts.65:PCI-MSI.31981598-edge.i40e-eth0-TxRx-29
      0.90 ±235%     +77.8%       1.60 ±300%  interrupts.66:PCI-MSI.31981599-edge.i40e-eth0-TxRx-30
    188.10 ±298%     -99.9%       0.10 ±300%  interrupts.67:PCI-MSI.31981600-edge.i40e-eth0-TxRx-31
      4.80 ±300%   +1172.9%      61.10 ±295%  interrupts.68:PCI-MSI.31981601-edge.i40e-eth0-TxRx-32
      0.00       +1.6e+102%       1.60 ±300%  interrupts.69:PCI-MSI.31981602-edge.i40e-eth0-TxRx-33
      0.40 ±300%   +9250.0%      37.40 ±300%  interrupts.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
      1.80 ±300%    -100.0%       0.00        interrupts.71:PCI-MSI.31981604-edge.i40e-eth0-TxRx-35
      1.10 ±245%     +45.5%       1.60 ±198%  interrupts.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
     19.00 ±300%     -93.2%       1.30 ±228%  interrupts.73:PCI-MSI.31981606-edge.i40e-eth0-TxRx-37
      0.00       +2.3e+103%      23.40 ±255%  interrupts.74:PCI-MSI.31981607-edge.i40e-eth0-TxRx-38
     48.40 ±300%     -99.8%       0.10 ±300%  interrupts.75:PCI-MSI.31981608-edge.i40e-eth0-TxRx-39
     21.70 ±259%     -86.2%       3.00 ±145%  interrupts.76:PCI-MSI.31981609-edge.i40e-eth0-TxRx-40
      1.10 ±245%   +3345.5%      37.90 ±296%  interrupts.77:PCI-MSI.31981610-edge.i40e-eth0-TxRx-41
      0.20 ±300%   +1500.0%       3.20 ±222%  interrupts.78:PCI-MSI.31981611-edge.i40e-eth0-TxRx-42
      0.00       +3.2e+102%       3.20 ±300%  interrupts.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
      0.20 ±300%    -100.0%       0.00        interrupts.80:PCI-MSI.31981613-edge.i40e-eth0-TxRx-44
      4.70 ±216%   +1387.2%      69.90 ±284%  interrupts.81:PCI-MSI.31981614-edge.i40e-eth0-TxRx-45
      0.40 ±300%    +325.0%       1.70 ±213%  interrupts.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
     65.10 ±300%     -98.3%       1.10 ±143%  interrupts.83:PCI-MSI.31981616-edge.i40e-eth0-TxRx-47
      3.80 ±291%     +10.5%       4.20 ±157%  interrupts.84:PCI-MSI.31981617-edge.i40e-eth0-TxRx-48
      0.00       +2.7e+104%     266.20 ±297%  interrupts.85:PCI-MSI.31981618-edge.i40e-eth0-TxRx-49
      1.40 ±300%     -71.4%       0.40 ±229%  interrupts.86:PCI-MSI.31981619-edge.i40e-eth0-TxRx-50
      0.10 ±300%    -100.0%       0.00        interrupts.87:PCI-MSI.31981620-edge.i40e-eth0-TxRx-51
      3.50 ±196%    +291.4%      13.70 ±290%  interrupts.88:PCI-MSI.31981621-edge.i40e-eth0-TxRx-52
      4.60 ±171%    +310.9%      18.90 ±232%  interrupts.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
      0.00          -100.0%       0.00        interrupts.8:IO-APIC.8-edge.rtc0
      0.90 ±300%    +266.7%       3.30 ±132%  interrupts.90:PCI-MSI.31981623-edge.i40e-eth0-TxRx-54
    266.80 ±294%     -99.4%       1.70 ±299%  interrupts.91:PCI-MSI.31981624-edge.i40e-eth0-TxRx-55
      2.40 ±249%     -62.5%       0.90 ±235%  interrupts.92:PCI-MSI.31981625-edge.i40e-eth0-TxRx-56
      0.30 ±213%    -100.0%       0.00        interrupts.93:PCI-MSI.31981626-edge.i40e-eth0-TxRx-57
      1.80 ±200%     -88.9%       0.20 ±300%  interrupts.94:PCI-MSI.31981627-edge.i40e-eth0-TxRx-58
      0.10 ±300%    +100.0%       0.20 ±300%  interrupts.95:PCI-MSI.31981628-edge.i40e-eth0-TxRx-59
     12.30 ±297%     -98.4%       0.20 ±300%  interrupts.96:PCI-MSI.31981629-edge.i40e-eth0-TxRx-60
      0.00         +5e+102%       5.00 ±286%  interrupts.97:PCI-MSI.31981630-edge.i40e-eth0-TxRx-61
      0.50 ±184%    +340.0%       2.20 ±191%  interrupts.98:PCI-MSI.31981631-edge.i40e-eth0-TxRx-62
      0.20 ±300%  +30150.0%      60.50 ±298%  interrupts.99:PCI-MSI.31981632-edge.i40e-eth0-TxRx-63
     68308           -19.7%      54831        interrupts.CAL:Function_call_interrupts
      0.00          -100.0%       0.00        interrupts.CPU0.0:IO-APIC.2-edge.timer
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU0.111:PCI-MSI.31981644-edge.i40e-eth0-TxRx-75
      0.00          -100.0%       0.00        interrupts.CPU0.285:PCI-MSI.67584-edge.ioat-msix
      4.40 ±271%     -54.5%       2.00 ±251%  interrupts.CPU0.36:PCI-MSI.31981569-edge.i40e-eth0-TxRx-0
      0.00          -100.0%       0.00        interrupts.CPU0.3:IO-APIC.3-edge
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU0.67:PCI-MSI.31981600-edge.i40e-eth0-TxRx-31
    968.40 ± 49%     -14.2%     831.10 ± 36%  interrupts.CPU0.CAL:Function_call_interrupts
      1.30 ± 35%     -38.5%       0.80 ± 75%  interrupts.CPU0.IWI:IRQ_work_interrupts
     71205           +18.8%      84560        interrupts.CPU0.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU0.MCP:Machine_check_polls
      2304 ± 16%     -23.7%       1757 ± 30%  interrupts.CPU0.NMI:Non-maskable_interrupts
      2304 ± 16%     -23.7%       1757 ± 30%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
     41.10 ± 27%    +211.9%     128.20 ± 24%  interrupts.CPU0.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00        interrupts.CPU0.RTR:APIC_ICR_read_retries
      1.70 ±114%     +11.8%       1.90 ±121%  interrupts.CPU0.TLB:TLB_shootdowns
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU1.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
      0.00          -100.0%       0.00        interrupts.CPU1.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU1.287:PCI-MSI.71680-edge.ioat-msix
      0.50 ±300%    -100.0%       0.00        interrupts.CPU1.37:PCI-MSI.31981570-edge.i40e-eth0-TxRx-1
      0.00          -100.0%       0.00        interrupts.CPU1.68:PCI-MSI.31981601-edge.i40e-eth0-TxRx-32
    935.60 ± 38%     -18.4%     763.80 ± 30%  interrupts.CPU1.CAL:Function_call_interrupts
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU1.IWI:IRQ_work_interrupts
     71102           +18.9%      84539        interrupts.CPU1.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU1.MCP:Machine_check_polls
      1969 ± 29%      -5.6%       1860 ± 23%  interrupts.CPU1.NMI:Non-maskable_interrupts
      1969 ± 29%      -5.6%       1860 ± 23%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
     39.60 ± 21%    +184.1%     112.50 ± 36%  interrupts.CPU1.RES:Rescheduling_interrupts
      2.20 ±126%     -13.6%       1.90 ± 64%  interrupts.CPU1.TLB:TLB_shootdowns
      0.10 ±300%    -100.0%       0.00        interrupts.CPU10.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
      0.00          -100.0%       0.00        interrupts.CPU10.281:PCI-MSI.327680-edge.xhci_hcd
      0.00          -100.0%       0.00        interrupts.CPU10.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU10.287:PCI-MSI.71680-edge.ioat-msix
     75.00 ±300%     -82.1%      13.40 ±276%  interrupts.CPU10.46:PCI-MSI.31981579-edge.i40e-eth0-TxRx-10
      0.20 ±200%      +0.0%       0.20 ±200%  interrupts.CPU10.77:PCI-MSI.31981610-edge.i40e-eth0-TxRx-41
    777.00 ±  4%     -17.0%     645.00 ± 25%  interrupts.CPU10.CAL:Function_call_interrupts
     71142           +19.0%      84631        interrupts.CPU10.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU10.MCP:Machine_check_polls
      2282 ± 17%     -19.6%       1833 ± 24%  interrupts.CPU10.NMI:Non-maskable_interrupts
      2282 ± 17%     -19.6%       1833 ± 24%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
     39.00 ± 21%    +186.7%     111.80 ± 43%  interrupts.CPU10.RES:Rescheduling_interrupts
      2.20 ± 97%      +9.1%       2.40 ± 65%  interrupts.CPU10.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU11.122:PCI-MSI.31981655-edge.i40e-eth0-TxRx-86
      0.00          -100.0%       0.00        interrupts.CPU11.285:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU11.287:PCI-MSI.71680-edge.ioat-msix
      1.50 ±300%     -93.3%       0.10 ±300%  interrupts.CPU11.47:PCI-MSI.31981580-edge.i40e-eth0-TxRx-11
      0.10 ±300%    -100.0%       0.00        interrupts.CPU11.78:PCI-MSI.31981611-edge.i40e-eth0-TxRx-42
      0.00          -100.0%       0.00        interrupts.CPU11.8:IO-APIC.8-edge.rtc0
    771.40 ±  8%     -19.3%     622.90 ±  7%  interrupts.CPU11.CAL:Function_call_interrupts
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU11.IWI:IRQ_work_interrupts
     71044           +18.9%      84445        interrupts.CPU11.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU11.MCP:Machine_check_polls
      2207 ± 23%     -17.5%       1821 ± 22%  interrupts.CPU11.NMI:Non-maskable_interrupts
      2207 ± 23%     -17.5%       1821 ± 22%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
     36.20 ± 15%    +180.7%     101.60 ± 29%  interrupts.CPU11.RES:Rescheduling_interrupts
      3.10 ±111%     -41.9%       1.80 ± 64%  interrupts.CPU11.TLB:TLB_shootdowns
      0.10 ±300%    +100.0%       0.20 ±200%  interrupts.CPU12.123:PCI-MSI.31981656-edge.i40e-eth0-TxRx-87
      7.50 ±295%     -93.3%       0.50 ±240%  interrupts.CPU12.48:PCI-MSI.31981581-edge.i40e-eth0-TxRx-12
      0.00          -100.0%       0.00        interrupts.CPU12.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
    837.40 ± 31%     -25.8%     621.60 ±  8%  interrupts.CPU12.CAL:Function_call_interrupts
      0.00         +2e+101%       0.20 ±300%  interrupts.CPU12.IWI:IRQ_work_interrupts
     71149           +18.6%      84378        interrupts.CPU12.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU12.MCP:Machine_check_polls
      2380 ± 17%     -23.2%       1829 ± 23%  interrupts.CPU12.NMI:Non-maskable_interrupts
      2380 ± 17%     -23.2%       1829 ± 23%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
     38.90 ± 17%    +205.1%     118.70 ± 29%  interrupts.CPU12.RES:Rescheduling_interrupts
      1.90 ± 54%      +5.3%       2.00 ± 54%  interrupts.CPU12.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU13.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU13.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU13.287:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU13.288:PCI-MSI.73728-edge.ioat-msix
      0.00         +2e+101%       0.20 ±200%  interrupts.CPU13.36:PCI-MSI.31981569-edge.i40e-eth0-TxRx-0
      2.20 ±255%     -95.5%       0.10 ±300%  interrupts.CPU13.49:PCI-MSI.31981582-edge.i40e-eth0-TxRx-13
      0.10 ±300%    -100.0%       0.00        interrupts.CPU13.80:PCI-MSI.31981613-edge.i40e-eth0-TxRx-44
    738.00 ±  6%     +20.9%     892.00 ±114%  interrupts.CPU13.CAL:Function_call_interrupts
      0.20 ±300%     -50.0%       0.10 ±300%  interrupts.CPU13.IWI:IRQ_work_interrupts
     71116           +18.7%      84427        interrupts.CPU13.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU13.MCP:Machine_check_polls
      2363 ± 17%     -16.0%       1985 ± 18%  interrupts.CPU13.NMI:Non-maskable_interrupts
      2363 ± 17%     -16.0%       1985 ± 18%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
     35.00 ± 11%    +206.0%     107.10 ± 20%  interrupts.CPU13.RES:Rescheduling_interrupts
      1.60 ± 57%     +12.5%       1.80 ± 69%  interrupts.CPU13.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU14.287:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU14.288:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU14.289:PCI-MSI.75776-edge.ioat-msix
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU14.37:PCI-MSI.31981570-edge.i40e-eth0-TxRx-1
      0.00          -100.0%       0.00        interrupts.CPU14.4:IO-APIC.4-edge.ttyS0
      1.70 ±166%     -47.1%       0.90 ±265%  interrupts.CPU14.50:PCI-MSI.31981583-edge.i40e-eth0-TxRx-14
      0.20 ±200%     -50.0%       0.10 ±300%  interrupts.CPU14.81:PCI-MSI.31981614-edge.i40e-eth0-TxRx-45
    852.10 ± 31%     -30.1%     595.60 ±  5%  interrupts.CPU14.CAL:Function_call_interrupts
      0.00          -100.0%       0.00        interrupts.CPU14.IWI:IRQ_work_interrupts
     71092           +18.8%      84458        interrupts.CPU14.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU14.MCP:Machine_check_polls
      2293 ± 17%     -15.4%       1940 ± 17%  interrupts.CPU14.NMI:Non-maskable_interrupts
      2293 ± 17%     -15.4%       1940 ± 17%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
     37.10 ± 16%    +189.2%     107.30 ± 39%  interrupts.CPU14.RES:Rescheduling_interrupts
      1.80 ± 85%     +16.7%       2.10 ± 58%  interrupts.CPU14.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU15.288:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU15.289:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU15.290:PCI-MSI.77824-edge.ioat-msix
      0.10 ±300%    -100.0%       0.00        interrupts.CPU15.38:PCI-MSI.31981571-edge.i40e-eth0-TxRx-2
      2.60 ±299%     -84.6%       0.40 ±300%  interrupts.CPU15.51:PCI-MSI.31981584-edge.i40e-eth0-TxRx-15
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU15.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
    770.00 ±  6%     -21.9%     601.60 ±  7%  interrupts.CPU15.CAL:Function_call_interrupts
     71059           +18.8%      84431        interrupts.CPU15.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU15.MCP:Machine_check_polls
      2387 ± 17%     -23.3%       1831 ± 24%  interrupts.CPU15.NMI:Non-maskable_interrupts
      2387 ± 17%     -23.3%       1831 ± 24%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
     38.50 ± 17%    +181.3%     108.30 ± 32%  interrupts.CPU15.RES:Rescheduling_interrupts
      1.70 ± 87%     +17.6%       2.00 ± 77%  interrupts.CPU15.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU16.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU16.285:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU16.289:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU16.290:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU16.291:PCI-MSI.79872-edge.ioat-msix
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU16.39:PCI-MSI.31981572-edge.i40e-eth0-TxRx-3
      0.00          -100.0%       0.00        interrupts.CPU16.4:IO-APIC.4-edge.ttyS0
      0.10 ±300%    +700.0%       0.80 ±300%  interrupts.CPU16.52:PCI-MSI.31981585-edge.i40e-eth0-TxRx-16
      0.00         +3e+101%       0.30 ±152%  interrupts.CPU16.83:PCI-MSI.31981616-edge.i40e-eth0-TxRx-47
    739.80 ±  2%     -23.2%     567.80 ±  9%  interrupts.CPU16.CAL:Function_call_interrupts
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU16.IWI:IRQ_work_interrupts
     71072           +18.8%      84457        interrupts.CPU16.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU16.MCP:Machine_check_polls
      2448 ±  7%     -23.3%       1878 ± 24%  interrupts.CPU16.NMI:Non-maskable_interrupts
      2448 ±  7%     -23.3%       1878 ± 24%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
     35.50 ± 16%    +199.4%     106.30 ± 21%  interrupts.CPU16.RES:Rescheduling_interrupts
      1.80 ± 85%      -5.6%       1.70 ± 52%  interrupts.CPU16.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU17.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU17.290:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU17.291:PCI-MSI.79872-edge.ioat-msix
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU17.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
      1.50 ±200%     -73.3%       0.40 ±300%  interrupts.CPU17.53:PCI-MSI.31981586-edge.i40e-eth0-TxRx-17
      0.10 ±300%    +100.0%       0.20 ±200%  interrupts.CPU17.84:PCI-MSI.31981617-edge.i40e-eth0-TxRx-48
    732.20 ±  9%     -18.0%     600.10 ±  6%  interrupts.CPU17.CAL:Function_call_interrupts
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU17.IWI:IRQ_work_interrupts
     71102           +18.8%      84469        interrupts.CPU17.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU17.MCP:Machine_check_polls
      2471 ±  7%     -20.4%       1967 ± 16%  interrupts.CPU17.NMI:Non-maskable_interrupts
      2471 ±  7%     -20.4%       1967 ± 16%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
     39.60 ± 18%    +219.7%     126.60 ± 32%  interrupts.CPU17.RES:Rescheduling_interrupts
      2.20 ± 72%      -9.1%       2.00 ± 44%  interrupts.CPU17.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU18.291:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU18.291:PCI-MSI.79872-edge.ioat-msix
      0.00         +4e+101%       0.40 ±200%  interrupts.CPU18.303:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.10 ±300%    -100.0%       0.00        interrupts.CPU18.41:PCI-MSI.31981574-edge.i40e-eth0-TxRx-5
      0.00         +9e+101%       0.90 ±300%  interrupts.CPU18.54:PCI-MSI.31981587-edge.i40e-eth0-TxRx-18
      0.00          -100.0%       0.00        interrupts.CPU18.85:PCI-MSI.31981618-edge.i40e-eth0-TxRx-49
    799.80 ± 13%     -26.7%     586.20 ±  7%  interrupts.CPU18.CAL:Function_call_interrupts
      0.10 ±300%    -100.0%       0.00        interrupts.CPU18.IWI:IRQ_work_interrupts
     71002           +19.0%      84505        interrupts.CPU18.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU18.MCP:Machine_check_polls
      2437 ±  5%     -21.0%       1926 ± 16%  interrupts.CPU18.NMI:Non-maskable_interrupts
      2437 ±  5%     -21.0%       1926 ± 16%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
     39.30 ±  9%    +194.7%     115.80 ± 28%  interrupts.CPU18.RES:Rescheduling_interrupts
      2.10 ± 75%      +9.5%       2.30 ± 97%  interrupts.CPU18.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU19.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU19.292:PCI-MSI.79872-edge.ioat-msix
      0.40 ±200%     +50.0%       0.60 ±152%  interrupts.CPU19.303:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU19.42:PCI-MSI.31981575-edge.i40e-eth0-TxRx-6
      0.00          -100.0%       0.00        interrupts.CPU19.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
      0.00         +2e+101%       0.20 ±200%  interrupts.CPU19.86:PCI-MSI.31981619-edge.i40e-eth0-TxRx-50
    762.20 ±  8%     -22.3%     592.40 ±  5%  interrupts.CPU19.CAL:Function_call_interrupts
     71093           +18.9%      84501        interrupts.CPU19.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU19.MCP:Machine_check_polls
      2475 ±  5%     -30.8%       1712 ± 29%  interrupts.CPU19.NMI:Non-maskable_interrupts
      2475 ±  5%     -30.8%       1712 ± 29%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
     39.30 ± 21%    +176.6%     108.70 ± 28%  interrupts.CPU19.RES:Rescheduling_interrupts
      2.10 ± 80%      +4.8%       2.20 ± 66%  interrupts.CPU19.TLB:TLB_shootdowns
      0.20 ±200%    -100.0%       0.00        interrupts.CPU2.113:PCI-MSI.31981646-edge.i40e-eth0-TxRx-77
     17.30 ±298%    +198.8%      51.70 ±276%  interrupts.CPU2.38:PCI-MSI.31981571-edge.i40e-eth0-TxRx-2
      0.00          -100.0%       0.00        interrupts.CPU2.3:IO-APIC.3-edge
      0.00          -100.0%       0.00        interrupts.CPU2.69:PCI-MSI.31981602-edge.i40e-eth0-TxRx-33
      1216 ± 62%     -41.8%     707.50 ± 25%  interrupts.CPU2.CAL:Function_call_interrupts
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU2.IWI:IRQ_work_interrupts
     71038           +18.9%      84471        interrupts.CPU2.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU2.MCP:Machine_check_polls
      2343 ± 18%     -26.1%       1731 ± 29%  interrupts.CPU2.NMI:Non-maskable_interrupts
      2343 ± 18%     -26.1%       1731 ± 29%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
     36.10 ±  7%    +211.4%     112.40 ± 27%  interrupts.CPU2.RES:Rescheduling_interrupts
      1.40 ±116%      -7.1%       1.30 ± 77%  interrupts.CPU2.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU20.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU20.293:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.60 ±152%    -100.0%       0.00        interrupts.CPU20.303:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.CPU20.3:IO-APIC.3-edge
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU20.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
      0.90 ±300%    +155.6%       2.30 ±300%  interrupts.CPU20.56:PCI-MSI.31981589-edge.i40e-eth0-TxRx-20
      0.10 ±300%    -100.0%       0.00        interrupts.CPU20.87:PCI-MSI.31981620-edge.i40e-eth0-TxRx-51
    783.40 ±  8%     -23.4%     600.30 ±  3%  interrupts.CPU20.CAL:Function_call_interrupts
      0.20 ±200%    -100.0%       0.00        interrupts.CPU20.IWI:IRQ_work_interrupts
     71080           +18.9%      84497        interrupts.CPU20.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU20.MCP:Machine_check_polls
      2359 ± 18%     -21.2%       1858 ± 23%  interrupts.CPU20.NMI:Non-maskable_interrupts
      2359 ± 18%     -21.2%       1858 ± 23%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
     34.30 ± 19%    +207.3%     105.40 ± 20%  interrupts.CPU20.RES:Rescheduling_interrupts
      2.00 ± 80%     -10.0%       1.80 ± 54%  interrupts.CPU20.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU21.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU21.3:IO-APIC.3-edge
      0.20 ±200%    -100.0%       0.00        interrupts.CPU21.44:PCI-MSI.31981577-edge.i40e-eth0-TxRx-8
     11.70 ±300%     +69.2%      19.80 ±300%  interrupts.CPU21.57:PCI-MSI.31981590-edge.i40e-eth0-TxRx-21
      0.10 ±300%    -100.0%       0.00        interrupts.CPU21.88:PCI-MSI.31981621-edge.i40e-eth0-TxRx-52
    724.90 ±  8%     -20.0%     580.20 ± 10%  interrupts.CPU21.CAL:Function_call_interrupts
     71153           +18.7%      84471        interrupts.CPU21.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU21.MCP:Machine_check_polls
      2227 ± 24%      -8.6%       2037 ±  7%  interrupts.CPU21.NMI:Non-maskable_interrupts
      2227 ± 24%      -8.6%       2037 ±  7%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
     35.20 ± 14%    +203.1%     106.70 ± 31%  interrupts.CPU21.RES:Rescheduling_interrupts
      2.20 ± 53%     -18.2%       1.80 ± 64%  interrupts.CPU21.TLB:TLB_shootdowns
      1.00         +1520.0%      16.20 ±275%  interrupts.CPU22.58:PCI-MSI.31981591-edge.i40e-eth0-TxRx-22
    789.30 ±  4%     -16.8%     656.90 ± 17%  interrupts.CPU22.CAL:Function_call_interrupts
     71113           +18.8%      84491        interrupts.CPU22.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU22.MCP:Machine_check_polls
      2451 ±  3%     -22.6%       1897 ± 15%  interrupts.CPU22.NMI:Non-maskable_interrupts
      2451 ±  3%     -22.6%       1897 ± 15%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
     35.00 ± 17%    +236.0%     117.60 ± 27%  interrupts.CPU22.RES:Rescheduling_interrupts
      1.80 ± 69%      +0.0%       1.80 ± 95%  interrupts.CPU22.TLB:TLB_shootdowns
      0.00         +9e+101%       0.90 ±300%  interrupts.CPU23.59:PCI-MSI.31981592-edge.i40e-eth0-TxRx-23
    844.40 ± 14%     -13.7%     728.30 ± 54%  interrupts.CPU23.CAL:Function_call_interrupts
     71087           +18.8%      84484        interrupts.CPU23.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU23.MCP:Machine_check_polls
      2482 ±  5%     -29.1%       1760 ± 20%  interrupts.CPU23.NMI:Non-maskable_interrupts
      2482 ±  5%     -29.1%       1760 ± 20%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
     32.00 ± 20%    +213.1%     100.20 ± 31%  interrupts.CPU23.RES:Rescheduling_interrupts
      1.60 ± 75%      -6.3%       1.50 ± 53%  interrupts.CPU23.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU24.293:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU24.295:PCI-MSI.67174400-edge.ioat-msix
      3.30 ±179%   +1927.3%      66.90 ±298%  interrupts.CPU24.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
    757.60 ± 13%     -20.8%     599.90 ±  4%  interrupts.CPU24.CAL:Function_call_interrupts
     71091           +18.9%      84523        interrupts.CPU24.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU24.MCP:Machine_check_polls
      2330 ± 15%     -19.5%       1875 ± 19%  interrupts.CPU24.NMI:Non-maskable_interrupts
      2330 ± 15%     -19.5%       1875 ± 19%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
     32.90 ± 15%    +180.9%      92.40 ± 28%  interrupts.CPU24.RES:Rescheduling_interrupts
      2.20 ± 56%     -18.2%       1.80 ± 64%  interrupts.CPU24.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU25.293:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU25.295:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU25.296:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU25.297:PCI-MSI.67176448-edge.ioat-msix
     25.30 ±293%    -100.0%       0.00        interrupts.CPU25.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
    744.70 ±  3%      -9.0%     678.00 ± 35%  interrupts.CPU25.CAL:Function_call_interrupts
      0.10 ±300%    -100.0%       0.00        interrupts.CPU25.IWI:IRQ_work_interrupts
     71018           +19.0%      84483        interrupts.CPU25.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU25.MCP:Machine_check_polls
      2347 ± 15%     -24.2%       1779 ± 26%  interrupts.CPU25.NMI:Non-maskable_interrupts
      2347 ± 15%     -24.2%       1779 ± 26%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
     33.90 ± 16%    +175.2%      93.30 ± 25%  interrupts.CPU25.RES:Rescheduling_interrupts
      1.60 ± 80%     +12.5%       1.80 ± 41%  interrupts.CPU25.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU26.295:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU26.296:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU26.297:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU26.298:PCI-MSI.67178496-edge.ioat-msix
      1.50 ±278%    +346.7%       6.70 ±295%  interrupts.CPU26.62:PCI-MSI.31981595-edge.i40e-eth0-TxRx-26
    777.20 ±  5%     -21.2%     612.30 ± 10%  interrupts.CPU26.CAL:Function_call_interrupts
      0.20 ±200%     -50.0%       0.10 ±300%  interrupts.CPU26.IWI:IRQ_work_interrupts
     71014           +19.0%      84483        interrupts.CPU26.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU26.MCP:Machine_check_polls
      2339 ± 15%     -23.6%       1786 ± 24%  interrupts.CPU26.NMI:Non-maskable_interrupts
      2339 ± 15%     -23.6%       1786 ± 24%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
     34.40 ± 16%    +206.1%     105.30 ± 28%  interrupts.CPU26.RES:Rescheduling_interrupts
      2.10 ± 68%     +19.0%       2.50 ± 67%  interrupts.CPU26.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU27.296:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU27.297:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU27.297:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU27.298:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU27.299:PCI-MSI.67180544-edge.ioat-msix
      0.00         +8e+101%       0.80 ±300%  interrupts.CPU27.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
    824.70 ± 26%     -27.8%     595.60 ±  5%  interrupts.CPU27.CAL:Function_call_interrupts
      0.10 ±300%    -100.0%       0.00        interrupts.CPU27.IWI:IRQ_work_interrupts
     71075           +18.9%      84540        interrupts.CPU27.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU27.MCP:Machine_check_polls
      2447 ±  5%     -22.2%       1903 ± 19%  interrupts.CPU27.NMI:Non-maskable_interrupts
      2447 ±  5%     -22.2%       1903 ± 19%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
     32.10 ± 15%    +198.4%      95.80 ± 33%  interrupts.CPU27.RES:Rescheduling_interrupts
      1.60 ± 75%     +50.0%       2.40 ± 56%  interrupts.CPU27.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU28.297:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU28.298:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU28.298:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU28.299:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU28.300:PCI-MSI.67182592-edge.ioat-msix
     55.50 ±299%   +9423.2%       5285 ±299%  interrupts.CPU28.64:PCI-MSI.31981597-edge.i40e-eth0-TxRx-28
    769.70 ± 11%     -17.0%     638.90 ± 20%  interrupts.CPU28.CAL:Function_call_interrupts
     71091           +18.8%      84451        interrupts.CPU28.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU28.MCP:Machine_check_polls
      2452 ±  2%     -28.9%       1743 ± 24%  interrupts.CPU28.NMI:Non-maskable_interrupts
      2452 ±  2%     -28.9%       1743 ± 24%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
     33.20 ± 18%    +202.4%     100.40 ± 33%  interrupts.CPU28.RES:Rescheduling_interrupts
      2.20 ± 75%     +13.6%       2.50 ± 60%  interrupts.CPU28.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU29.298:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU29.299:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU29.299:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU29.300:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU29.301:PCI-MSI.67184640-edge.ioat-msix
      3.20 ±192%     -81.2%       0.60 ±249%  interrupts.CPU29.65:PCI-MSI.31981598-edge.i40e-eth0-TxRx-29
    749.50 ±  3%     -18.2%     613.00 ± 22%  interrupts.CPU29.CAL:Function_call_interrupts
     71060           +18.9%      84474        interrupts.CPU29.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU29.MCP:Machine_check_polls
      2352 ± 16%     -18.4%       1920 ± 19%  interrupts.CPU29.NMI:Non-maskable_interrupts
      2352 ± 16%     -18.4%       1920 ± 19%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
     28.00 ± 18%    +298.6%     111.60 ± 22%  interrupts.CPU29.RES:Rescheduling_interrupts
      2.30 ± 55%      -8.7%       2.10 ± 68%  interrupts.CPU29.TLB:TLB_shootdowns
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU3.114:PCI-MSI.31981647-edge.i40e-eth0-TxRx-78
      0.00          -100.0%       0.00        interrupts.CPU3.286:PCI-MSI.69632-edge.ioat-msix
      5.30 ±300%    +241.5%      18.10 ±300%  interrupts.CPU3.39:PCI-MSI.31981572-edge.i40e-eth0-TxRx-3
      0.00          -100.0%       0.00        interrupts.CPU3.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
    976.70 ± 53%      +2.3%     998.90 ± 79%  interrupts.CPU3.CAL:Function_call_interrupts
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU3.IWI:IRQ_work_interrupts
     71120           +18.8%      84479        interrupts.CPU3.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU3.MCP:Machine_check_polls
      2216 ± 23%     -22.1%       1725 ± 28%  interrupts.CPU3.NMI:Non-maskable_interrupts
      2216 ± 23%     -22.1%       1725 ± 28%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
     36.90 ± 13%    +212.5%     115.30 ± 34%  interrupts.CPU3.RES:Rescheduling_interrupts
      1.40 ± 91%      +7.1%       1.50 ± 68%  interrupts.CPU3.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU30.299:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.300:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.300:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.301:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.302:PCI-MSI.67186688-edge.ioat-msix
      0.80 ±261%    +100.0%       1.60 ±300%  interrupts.CPU30.66:PCI-MSI.31981599-edge.i40e-eth0-TxRx-30
    764.00 ±  6%     -22.6%     591.50 ±  3%  interrupts.CPU30.CAL:Function_call_interrupts
     71044           +19.0%      84538        interrupts.CPU30.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU30.MCP:Machine_check_polls
      2198 ± 21%     -18.3%       1796 ± 26%  interrupts.CPU30.NMI:Non-maskable_interrupts
      2198 ± 21%     -18.3%       1796 ± 26%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
     31.80 ± 11%    +178.3%      88.50 ± 29%  interrupts.CPU30.RES:Rescheduling_interrupts
      1.80 ± 77%     -11.1%       1.60 ± 63%  interrupts.CPU30.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU31.300:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.301:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.301:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.302:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.303:PCI-MSI.67188736-edge.ioat-msix
    188.00 ±298%    -100.0%       0.00        interrupts.CPU31.67:PCI-MSI.31981600-edge.i40e-eth0-TxRx-31
    731.90 ±  2%     -20.6%     580.90 ±  4%  interrupts.CPU31.CAL:Function_call_interrupts
     71074           +19.1%      84644        interrupts.CPU31.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU31.MCP:Machine_check_polls
      2169 ± 23%     -17.4%       1791 ± 23%  interrupts.CPU31.NMI:Non-maskable_interrupts
      2169 ± 23%     -17.4%       1791 ± 23%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
     29.90 ± 24%    +256.2%     106.50 ± 32%  interrupts.CPU31.RES:Rescheduling_interrupts
      2.10 ± 91%      +9.5%       2.30 ± 72%  interrupts.CPU31.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU32.302:PCI-MSI.67188736-edge.ioat-msix
      4.80 ±300%   +1172.9%      61.10 ±295%  interrupts.CPU32.68:PCI-MSI.31981601-edge.i40e-eth0-TxRx-32
    745.70 ±  2%     -20.8%     590.90 ±  8%  interrupts.CPU32.CAL:Function_call_interrupts
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU32.IWI:IRQ_work_interrupts
     71063           +18.9%      84488        interrupts.CPU32.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU32.MCP:Machine_check_polls
      2306 ± 16%     -22.6%       1784 ± 24%  interrupts.CPU32.NMI:Non-maskable_interrupts
      2306 ± 16%     -22.6%       1784 ± 24%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
     29.20 ± 14%    +216.4%      92.40 ± 31%  interrupts.CPU32.RES:Rescheduling_interrupts
      2.30 ± 89%     -34.8%       1.50 ± 68%  interrupts.CPU32.TLB:TLB_shootdowns
      0.00       +1.6e+102%       1.60 ±300%  interrupts.CPU33.69:PCI-MSI.31981602-edge.i40e-eth0-TxRx-33
    756.50 ±  5%     -20.9%     598.20 ±  5%  interrupts.CPU33.CAL:Function_call_interrupts
     71084           +18.8%      84459        interrupts.CPU33.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU33.MCP:Machine_check_polls
      2174 ± 23%     -14.6%       1857 ± 20%  interrupts.CPU33.NMI:Non-maskable_interrupts
      2174 ± 23%     -14.6%       1857 ± 20%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
     34.50 ± 24%    +153.0%      87.30 ± 27%  interrupts.CPU33.RES:Rescheduling_interrupts
      2.40 ± 56%     -12.5%       2.10 ± 58%  interrupts.CPU33.TLB:TLB_shootdowns
      0.40 ±300%   +9250.0%      37.40 ±300%  interrupts.CPU34.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
    734.80 ±  2%     -16.6%     612.50 ±  9%  interrupts.CPU34.CAL:Function_call_interrupts
     71106           +18.7%      84431        interrupts.CPU34.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU34.MCP:Machine_check_polls
      2298 ± 16%     -23.1%       1768 ± 24%  interrupts.CPU34.NMI:Non-maskable_interrupts
      2298 ± 16%     -23.1%       1768 ± 24%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
     31.40 ± 18%    +190.1%      91.10 ± 33%  interrupts.CPU34.RES:Rescheduling_interrupts
      2.30 ± 64%      +8.7%       2.50 ± 51%  interrupts.CPU34.TLB:TLB_shootdowns
      1.80 ±300%    -100.0%       0.00        interrupts.CPU35.71:PCI-MSI.31981604-edge.i40e-eth0-TxRx-35
    747.80 ±  3%     -22.1%     582.70 ±  3%  interrupts.CPU35.CAL:Function_call_interrupts
     71124           +18.7%      84441        interrupts.CPU35.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU35.MCP:Machine_check_polls
      2181 ± 24%     -12.7%       1904 ± 19%  interrupts.CPU35.NMI:Non-maskable_interrupts
      2181 ± 24%     -12.7%       1904 ± 19%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
     30.30 ± 10%    +199.0%      90.60 ± 22%  interrupts.CPU35.RES:Rescheduling_interrupts
      2.40 ± 72%     -33.3%       1.60 ± 80%  interrupts.CPU35.TLB:TLB_shootdowns
      1.00 ±268%     +50.0%       1.50 ±213%  interrupts.CPU36.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
    742.60 ±  2%     -22.5%     575.60 ±  3%  interrupts.CPU36.CAL:Function_call_interrupts
     71070           +18.8%      84466        interrupts.CPU36.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU36.MCP:Machine_check_polls
      2176 ± 23%     -13.6%       1881 ± 20%  interrupts.CPU36.NMI:Non-maskable_interrupts
      2176 ± 23%     -13.6%       1881 ± 20%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
     35.30 ± 12%    +177.1%      97.80 ± 41%  interrupts.CPU36.RES:Rescheduling_interrupts
      1.80 ± 59%     +27.8%       2.30 ± 58%  interrupts.CPU36.TLB:TLB_shootdowns
     18.90 ±300%     -94.2%       1.10 ±271%  interrupts.CPU37.73:PCI-MSI.31981606-edge.i40e-eth0-TxRx-37
    755.50           -21.5%     592.80 ±  5%  interrupts.CPU37.CAL:Function_call_interrupts
      0.10 ±300%    -100.0%       0.00        interrupts.CPU37.IWI:IRQ_work_interrupts
     71091           +18.8%      84471        interrupts.CPU37.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU37.MCP:Machine_check_polls
      2272 ± 24%     -17.2%       1881 ± 19%  interrupts.CPU37.NMI:Non-maskable_interrupts
      2272 ± 24%     -17.2%       1881 ± 19%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
     29.50 ± 15%    +257.6%     105.50 ± 26%  interrupts.CPU37.RES:Rescheduling_interrupts
      2.10 ± 72%     +14.3%       2.40 ± 33%  interrupts.CPU37.TLB:TLB_shootdowns
      0.00       +2.3e+103%      23.40 ±255%  interrupts.CPU38.74:PCI-MSI.31981607-edge.i40e-eth0-TxRx-38
    753.80 ±  7%     -24.7%     567.30 ±  8%  interrupts.CPU38.CAL:Function_call_interrupts
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU38.IWI:IRQ_work_interrupts
     71108           +18.8%      84464        interrupts.CPU38.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU38.MCP:Machine_check_polls
      2302 ± 15%     -15.6%       1942 ±  6%  interrupts.CPU38.NMI:Non-maskable_interrupts
      2302 ± 15%     -15.6%       1942 ±  6%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
     32.50 ± 18%    +169.5%      87.60 ± 25%  interrupts.CPU38.RES:Rescheduling_interrupts
      1.90 ± 54%     +15.8%       2.20 ± 39%  interrupts.CPU38.TLB:TLB_shootdowns
     48.30 ±300%    -100.0%       0.00        interrupts.CPU39.75:PCI-MSI.31981608-edge.i40e-eth0-TxRx-39
    747.40 ±  2%     -20.5%     594.00 ±  3%  interrupts.CPU39.CAL:Function_call_interrupts
     71079           +18.8%      84464        interrupts.CPU39.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU39.MCP:Machine_check_polls
      2314 ± 18%     -14.8%       1971 ±  6%  interrupts.CPU39.NMI:Non-maskable_interrupts
      2314 ± 18%     -14.8%       1971 ±  6%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
     33.90 ± 15%    +187.9%      97.60 ± 17%  interrupts.CPU39.RES:Rescheduling_interrupts
      2.80 ± 50%      -7.1%       2.60 ± 35%  interrupts.CPU39.TLB:TLB_shootdowns
      0.10 ±300%    -100.0%       0.00        interrupts.CPU4.115:PCI-MSI.31981648-edge.i40e-eth0-TxRx-79
      5.40 ±227%     +79.6%       9.70 ±186%  interrupts.CPU4.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
      0.00          -100.0%       0.00        interrupts.CPU4.71:PCI-MSI.31981604-edge.i40e-eth0-TxRx-35
    937.80 ± 38%     -12.9%     816.80 ± 72%  interrupts.CPU4.CAL:Function_call_interrupts
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU4.IWI:IRQ_work_interrupts
     71066           +18.7%      84348        interrupts.CPU4.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU4.MCP:Machine_check_polls
      2356 ± 15%     -21.1%       1858 ± 23%  interrupts.CPU4.NMI:Non-maskable_interrupts
      2356 ± 15%     -21.1%       1858 ± 23%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
     37.00 ± 13%    +208.6%     114.20 ± 38%  interrupts.CPU4.RES:Rescheduling_interrupts
      1.60 ± 69%     +18.8%       1.90 ± 49%  interrupts.CPU4.TLB:TLB_shootdowns
     21.70 ±259%     -86.2%       3.00 ±145%  interrupts.CPU40.76:PCI-MSI.31981609-edge.i40e-eth0-TxRx-40
    742.30 ±  3%     -21.0%     586.60 ± 12%  interrupts.CPU40.CAL:Function_call_interrupts
     71075           +18.8%      84459        interrupts.CPU40.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU40.MCP:Machine_check_polls
      2086 ± 28%     -12.4%       1827 ± 15%  interrupts.CPU40.NMI:Non-maskable_interrupts
      2086 ± 28%     -12.4%       1827 ± 15%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
     31.90 ± 17%    +221.0%     102.40 ± 34%  interrupts.CPU40.RES:Rescheduling_interrupts
      2.70 ± 59%     -11.1%       2.40 ± 56%  interrupts.CPU40.TLB:TLB_shootdowns
      0.90 ±265%   +4088.9%      37.70 ±298%  interrupts.CPU41.77:PCI-MSI.31981610-edge.i40e-eth0-TxRx-41
    725.90 ±  3%     -19.6%     583.80 ±  2%  interrupts.CPU41.CAL:Function_call_interrupts
     71105           +18.9%      84576        interrupts.CPU41.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU41.MCP:Machine_check_polls
      2060 ± 28%      -8.8%       1879 ± 14%  interrupts.CPU41.NMI:Non-maskable_interrupts
      2060 ± 28%      -8.8%       1879 ± 14%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
     31.90 ± 19%    +191.5%      93.00 ± 18%  interrupts.CPU41.RES:Rescheduling_interrupts
      3.00 ± 49%      -6.7%       2.80 ± 52%  interrupts.CPU41.TLB:TLB_shootdowns
      0.10 ±300%   +3100.0%       3.20 ±222%  interrupts.CPU42.78:PCI-MSI.31981611-edge.i40e-eth0-TxRx-42
    744.50 ±  2%     -21.9%     581.80 ±  6%  interrupts.CPU42.CAL:Function_call_interrupts
     71073           +18.9%      84477        interrupts.CPU42.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU42.MCP:Machine_check_polls
      2105 ± 29%     -11.8%       1857 ± 16%  interrupts.CPU42.NMI:Non-maskable_interrupts
      2105 ± 29%     -11.8%       1857 ± 16%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
     33.20 ± 11%    +220.2%     106.30 ± 25%  interrupts.CPU42.RES:Rescheduling_interrupts
      3.10 ± 48%      -9.7%       2.80 ± 52%  interrupts.CPU42.TLB:TLB_shootdowns
      0.00       +3.2e+102%       3.20 ±300%  interrupts.CPU43.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
    781.40 ±  5%     -23.4%     598.80 ±  3%  interrupts.CPU43.CAL:Function_call_interrupts
      0.10 ±300%    -100.0%       0.00        interrupts.CPU43.IWI:IRQ_work_interrupts
     71103           +18.8%      84497        interrupts.CPU43.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU43.MCP:Machine_check_polls
      2234 ± 23%     -18.3%       1824 ± 15%  interrupts.CPU43.NMI:Non-maskable_interrupts
      2234 ± 23%     -18.3%       1824 ± 15%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
     33.30 ± 23%    +219.2%     106.30 ± 32%  interrupts.CPU43.RES:Rescheduling_interrupts
      3.10 ± 50%     -32.3%       2.10 ± 61%  interrupts.CPU43.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU44.3:IO-APIC.3-edge
      0.00          -100.0%       0.00        interrupts.CPU44.45:PCI-MSI.31981578-edge.i40e-eth0-TxRx-9
      0.10 ±300%    -100.0%       0.00        interrupts.CPU44.80:PCI-MSI.31981613-edge.i40e-eth0-TxRx-44
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU44.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
    751.30           -22.3%     584.00 ±  2%  interrupts.CPU44.CAL:Function_call_interrupts
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU44.IWI:IRQ_work_interrupts
     71038           +18.9%      84457        interrupts.CPU44.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU44.MCP:Machine_check_polls
      2145 ± 22%     -10.2%       1927 ± 15%  interrupts.CPU44.NMI:Non-maskable_interrupts
      2145 ± 22%     -10.2%       1927 ± 15%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
     32.70 ± 25%    +226.6%     106.80 ± 33%  interrupts.CPU44.RES:Rescheduling_interrupts
      2.00 ± 59%     +10.0%       2.20 ± 60%  interrupts.CPU44.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU45.3:IO-APIC.3-edge
      0.10 ±300%    -100.0%       0.00        interrupts.CPU45.46:PCI-MSI.31981579-edge.i40e-eth0-TxRx-10
      4.50 ±221%   +1451.1%      69.80 ±285%  interrupts.CPU45.81:PCI-MSI.31981614-edge.i40e-eth0-TxRx-45
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU45.90:PCI-MSI.31981623-edge.i40e-eth0-TxRx-54
    743.00 ±  3%     -20.8%     588.10        interrupts.CPU45.CAL:Function_call_interrupts
     71103           +18.8%      84462        interrupts.CPU45.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU45.MCP:Machine_check_polls
      1964 ± 34%      -4.9%       1869 ± 22%  interrupts.CPU45.NMI:Non-maskable_interrupts
      1964 ± 34%      -4.9%       1869 ± 22%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
     26.40 ± 15%    +360.2%     121.50 ± 34%  interrupts.CPU45.RES:Rescheduling_interrupts
      3.10 ± 78%      +0.0%       3.10 ± 75%  interrupts.CPU45.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU46.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU46.285:PCI-MSI.67584-edge.ioat-msix
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU46.47:PCI-MSI.31981580-edge.i40e-eth0-TxRx-11
      0.00          -100.0%       0.00        interrupts.CPU46.4:IO-APIC.4-edge.ttyS0
      0.40 ±300%    +300.0%       1.60 ±229%  interrupts.CPU46.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
      0.20 ±200%    -100.0%       0.00        interrupts.CPU46.91:PCI-MSI.31981624-edge.i40e-eth0-TxRx-55
    744.80 ±  2%     -22.8%     574.90 ±  6%  interrupts.CPU46.CAL:Function_call_interrupts
      0.00          -100.0%       0.00        interrupts.CPU46.IWI:IRQ_work_interrupts
     71220           +18.7%      84516        interrupts.CPU46.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU46.MCP:Machine_check_polls
      2347 ± 16%     -22.4%       1822 ± 22%  interrupts.CPU46.NMI:Non-maskable_interrupts
      2347 ± 16%     -22.4%       1822 ± 22%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
     26.10 ± 13%    +337.2%     114.10 ± 31%  interrupts.CPU46.RES:Rescheduling_interrupts
      2.10 ± 68%     +14.3%       2.40 ± 50%  interrupts.CPU46.TLB:TLB_shootdowns
      0.20 ±200%     -50.0%       0.10 ±300%  interrupts.CPU47.48:PCI-MSI.31981581-edge.i40e-eth0-TxRx-12
      0.00          -100.0%       0.00        interrupts.CPU47.4:IO-APIC.4-edge.ttyS0
     65.10 ±300%     -98.8%       0.80 ±175%  interrupts.CPU47.83:PCI-MSI.31981616-edge.i40e-eth0-TxRx-47
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU47.92:PCI-MSI.31981625-edge.i40e-eth0-TxRx-56
    724.00 ±  8%     -18.8%     588.00 ±  6%  interrupts.CPU47.CAL:Function_call_interrupts
     71139           +18.8%      84485        interrupts.CPU47.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU47.MCP:Machine_check_polls
      2250 ± 23%     -14.1%       1933 ± 15%  interrupts.CPU47.NMI:Non-maskable_interrupts
      2250 ± 23%     -14.1%       1933 ± 15%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
     28.10 ± 24%    +243.4%      96.50 ± 31%  interrupts.CPU47.RES:Rescheduling_interrupts
      2.20 ± 63%      +4.5%       2.30 ± 43%  interrupts.CPU47.TLB:TLB_shootdowns
      0.30 ±152%     -66.7%       0.10 ±300%  interrupts.CPU48.49:PCI-MSI.31981582-edge.i40e-eth0-TxRx-13
      3.70 ±300%      +8.1%       4.00 ±164%  interrupts.CPU48.84:PCI-MSI.31981617-edge.i40e-eth0-TxRx-48
      0.10 ±300%    -100.0%       0.00        interrupts.CPU48.93:PCI-MSI.31981626-edge.i40e-eth0-TxRx-57
    779.00 ±  6%     -23.4%     596.50 ±  4%  interrupts.CPU48.CAL:Function_call_interrupts
     71081           +18.9%      84510        interrupts.CPU48.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU48.MCP:Machine_check_polls
      2002 ± 29%     -19.3%       1615 ± 28%  interrupts.CPU48.NMI:Non-maskable_interrupts
      2002 ± 29%     -19.3%       1615 ± 28%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
     28.10 ± 23%    +310.3%     115.30 ± 37%  interrupts.CPU48.RES:Rescheduling_interrupts
      2.50 ± 57%      +4.0%       2.60 ± 42%  interrupts.CPU48.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU49.3:IO-APIC.3-edge
      0.00          -100.0%       0.00        interrupts.CPU49.4:IO-APIC.4-edge.ttyS0
      0.10 ±300%    +200.0%       0.30 ±152%  interrupts.CPU49.50:PCI-MSI.31981583-edge.i40e-eth0-TxRx-14
      0.00       +2.7e+104%     266.20 ±297%  interrupts.CPU49.85:PCI-MSI.31981618-edge.i40e-eth0-TxRx-49
      0.20 ±200%     -50.0%       0.10 ±300%  interrupts.CPU49.94:PCI-MSI.31981627-edge.i40e-eth0-TxRx-58
    742.30 ±  2%     -19.8%     595.10 ±  6%  interrupts.CPU49.CAL:Function_call_interrupts
     71208           +18.6%      84461        interrupts.CPU49.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU49.MCP:Machine_check_polls
      2190 ± 23%     -21.7%       1714 ± 25%  interrupts.CPU49.NMI:Non-maskable_interrupts
      2190 ± 23%     -21.7%       1714 ± 25%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
     27.30 ± 17%    +280.6%     103.90 ± 51%  interrupts.CPU49.RES:Rescheduling_interrupts
      2.50 ± 48%      -4.0%       2.40 ± 27%  interrupts.CPU49.TLB:TLB_shootdowns
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU5.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
      0.00          -100.0%       0.00        interrupts.CPU5.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU5.287:PCI-MSI.71680-edge.ioat-msix
     63.30 ±300%     -92.9%       4.50 ±300%  interrupts.CPU5.41:PCI-MSI.31981574-edge.i40e-eth0-TxRx-5
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU5.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
    898.90 ± 38%     +12.7%       1012 ± 60%  interrupts.CPU5.CAL:Function_call_interrupts
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU5.IWI:IRQ_work_interrupts
     71149           +18.6%      84368        interrupts.CPU5.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU5.MCP:Machine_check_polls
      2323 ± 17%     -20.8%       1839 ± 23%  interrupts.CPU5.NMI:Non-maskable_interrupts
      2323 ± 17%     -20.8%       1839 ± 23%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
     36.50 ± 16%    +195.9%     108.00 ± 30%  interrupts.CPU5.RES:Rescheduling_interrupts
      1.50 ± 85%      -6.7%       1.40 ± 57%  interrupts.CPU5.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU50.283:PCI-MSI.65536-edge.ioat-msix
      0.10 ±300%    +100.0%       0.20 ±200%  interrupts.CPU50.51:PCI-MSI.31981584-edge.i40e-eth0-TxRx-15
      1.40 ±300%     -85.7%       0.20 ±300%  interrupts.CPU50.86:PCI-MSI.31981619-edge.i40e-eth0-TxRx-50
      0.10 ±300%    -100.0%       0.00        interrupts.CPU50.95:PCI-MSI.31981628-edge.i40e-eth0-TxRx-59
    754.30 ±  5%     -20.7%     597.80 ±  6%  interrupts.CPU50.CAL:Function_call_interrupts
     71162           +18.8%      84537        interrupts.CPU50.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU50.MCP:Machine_check_polls
      2361 ± 18%     -17.6%       1944 ± 17%  interrupts.CPU50.NMI:Non-maskable_interrupts
      2361 ± 18%     -17.6%       1944 ± 17%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
     31.50 ± 43%    +240.0%     107.10 ± 23%  interrupts.CPU50.RES:Rescheduling_interrupts
      2.10 ± 65%     +14.3%       2.40 ± 33%  interrupts.CPU50.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU51.3:IO-APIC.3-edge
      0.20 ±200%      +0.0%       0.20 ±200%  interrupts.CPU51.52:PCI-MSI.31981585-edge.i40e-eth0-TxRx-16
      0.00          -100.0%       0.00        interrupts.CPU51.87:PCI-MSI.31981620-edge.i40e-eth0-TxRx-51
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU51.96:PCI-MSI.31981629-edge.i40e-eth0-TxRx-60
    766.30 ±  7%     -21.5%     601.70 ±  7%  interrupts.CPU51.CAL:Function_call_interrupts
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU51.IWI:IRQ_work_interrupts
     71052           +18.9%      84515        interrupts.CPU51.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU51.MCP:Machine_check_polls
      2329 ± 18%     -20.8%       1845 ± 23%  interrupts.CPU51.NMI:Non-maskable_interrupts
      2329 ± 18%     -20.8%       1845 ± 23%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
     31.30 ± 31%    +262.9%     113.60 ± 46%  interrupts.CPU51.RES:Rescheduling_interrupts
      1.60 ± 69%     +50.0%       2.40 ± 50%  interrupts.CPU51.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU52.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU52.4:IO-APIC.4-edge.ttyS0
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU52.53:PCI-MSI.31981586-edge.i40e-eth0-TxRx-17
      3.40 ±203%    +302.9%      13.70 ±290%  interrupts.CPU52.88:PCI-MSI.31981621-edge.i40e-eth0-TxRx-52
      0.00          -100.0%       0.00        interrupts.CPU52.97:PCI-MSI.31981630-edge.i40e-eth0-TxRx-61
    748.00 ±  4%     -17.4%     617.70 ± 12%  interrupts.CPU52.CAL:Function_call_interrupts
     71108           +18.8%      84494        interrupts.CPU52.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU52.MCP:Machine_check_polls
      2317 ± 16%     -26.0%       1713 ± 24%  interrupts.CPU52.NMI:Non-maskable_interrupts
      2317 ± 16%     -26.0%       1713 ± 24%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
     27.20 ± 24%    +250.4%      95.30 ± 25%  interrupts.CPU52.RES:Rescheduling_interrupts
      2.30 ± 61%     +56.5%       3.60 ± 22%  interrupts.CPU52.TLB:TLB_shootdowns
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU53.54:PCI-MSI.31981587-edge.i40e-eth0-TxRx-18
      4.50 ±171%    +317.8%      18.80 ±233%  interrupts.CPU53.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
      0.20 ±200%     +50.0%       0.30 ±152%  interrupts.CPU53.98:PCI-MSI.31981631-edge.i40e-eth0-TxRx-62
    771.80 ±  5%     -23.9%     587.40 ±  3%  interrupts.CPU53.CAL:Function_call_interrupts
     71217           +18.6%      84498        interrupts.CPU53.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU53.MCP:Machine_check_polls
      1958 ± 32%      -8.3%       1796 ± 21%  interrupts.CPU53.NMI:Non-maskable_interrupts
      1958 ± 32%      -8.3%       1796 ± 21%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
     29.00 ± 19%    +224.8%      94.20 ± 29%  interrupts.CPU53.RES:Rescheduling_interrupts
      1.70 ± 79%    +147.1%       4.20 ± 60%  interrupts.CPU53.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU54.3:IO-APIC.3-edge
      0.00          -100.0%       0.00        interrupts.CPU54.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
      0.90 ±300%    +255.6%       3.20 ±132%  interrupts.CPU54.90:PCI-MSI.31981623-edge.i40e-eth0-TxRx-54
      0.10 ±300%    +100.0%       0.20 ±200%  interrupts.CPU54.99:PCI-MSI.31981632-edge.i40e-eth0-TxRx-63
    761.00 ±  2%     -22.4%     590.60 ±  4%  interrupts.CPU54.CAL:Function_call_interrupts
     71119           +18.8%      84513        interrupts.CPU54.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU54.MCP:Machine_check_polls
      1934 ± 31%     -21.7%       1514 ± 29%  interrupts.CPU54.NMI:Non-maskable_interrupts
      1934 ± 31%     -21.7%       1514 ± 29%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
     32.50 ± 20%    +180.3%      91.10 ± 24%  interrupts.CPU54.RES:Rescheduling_interrupts
      2.10 ± 72%     +23.8%       2.60 ± 67%  interrupts.CPU54.TLB:TLB_shootdowns
      0.30 ±152%     -33.3%       0.20 ±200%  interrupts.CPU55.100:PCI-MSI.31981633-edge.i40e-eth0-TxRx-64
      0.00          -100.0%       0.00        interrupts.CPU55.3:IO-APIC.3-edge
      0.10 ±300%    -100.0%       0.00        interrupts.CPU55.56:PCI-MSI.31981589-edge.i40e-eth0-TxRx-20
    266.60 ±295%     -99.4%       1.70 ±299%  interrupts.CPU55.91:PCI-MSI.31981624-edge.i40e-eth0-TxRx-55
    756.60 ±  3%     -22.7%     585.10 ±  3%  interrupts.CPU55.CAL:Function_call_interrupts
     71070           +18.8%      84446        interrupts.CPU55.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU55.MCP:Machine_check_polls
      2313 ± 16%     -34.1%       1525 ± 31%  interrupts.CPU55.NMI:Non-maskable_interrupts
      2313 ± 16%     -34.1%       1525 ± 31%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
     27.20 ± 20%    +266.5%      99.70 ± 30%  interrupts.CPU55.RES:Rescheduling_interrupts
      2.30 ± 47%      +4.3%       2.40 ± 50%  interrupts.CPU55.TLB:TLB_shootdowns
      0.20 ±200%    -100.0%       0.00        interrupts.CPU56.101:PCI-MSI.31981634-edge.i40e-eth0-TxRx-65
      0.10 ±300%    -100.0%       0.00        interrupts.CPU56.57:PCI-MSI.31981590-edge.i40e-eth0-TxRx-21
      2.40 ±249%     -66.7%       0.80 ±261%  interrupts.CPU56.92:PCI-MSI.31981625-edge.i40e-eth0-TxRx-56
    753.60 ±  4%     -22.6%     583.00 ±  3%  interrupts.CPU56.CAL:Function_call_interrupts
     71334           +18.4%      84466        interrupts.CPU56.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU56.MCP:Machine_check_polls
      2236 ± 22%     -27.8%       1615 ± 28%  interrupts.CPU56.NMI:Non-maskable_interrupts
      2236 ± 22%     -27.8%       1615 ± 28%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
     27.90 ± 27%    +247.0%      96.80 ± 26%  interrupts.CPU56.RES:Rescheduling_interrupts
      2.20 ± 72%     +13.6%       2.50 ± 40%  interrupts.CPU56.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU57.102:PCI-MSI.31981635-edge.i40e-eth0-TxRx-66
      0.00          -100.0%       0.00        interrupts.CPU57.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU57.285:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU57.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU57.290:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU57.4:IO-APIC.4-edge.ttyS0
      0.00          -100.0%       0.00        interrupts.CPU57.58:PCI-MSI.31981591-edge.i40e-eth0-TxRx-22
      0.20 ±200%    -100.0%       0.00        interrupts.CPU57.93:PCI-MSI.31981626-edge.i40e-eth0-TxRx-57
    763.30 ±  7%     -23.5%     584.20 ±  3%  interrupts.CPU57.CAL:Function_call_interrupts
      0.00          -100.0%       0.00        interrupts.CPU57.IWI:IRQ_work_interrupts
     71099           +18.8%      84489        interrupts.CPU57.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU57.MCP:Machine_check_polls
      2116 ± 28%     -27.7%       1530 ± 33%  interrupts.CPU57.NMI:Non-maskable_interrupts
      2116 ± 28%     -27.7%       1530 ± 33%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
     28.80 ± 38%    +239.6%      97.80 ± 27%  interrupts.CPU57.RES:Rescheduling_interrupts
      2.10 ± 58%      +9.5%       2.30 ± 33%  interrupts.CPU57.TLB:TLB_shootdowns
      0.30 ±152%    -100.0%       0.00        interrupts.CPU58.103:PCI-MSI.31981636-edge.i40e-eth0-TxRx-67
      0.00          -100.0%       0.00        interrupts.CPU58.3:IO-APIC.3-edge
      0.00          -100.0%       0.00        interrupts.CPU58.59:PCI-MSI.31981592-edge.i40e-eth0-TxRx-23
      1.60 ±200%     -93.8%       0.10 ±300%  interrupts.CPU58.94:PCI-MSI.31981627-edge.i40e-eth0-TxRx-58
    752.70 ±  3%     -21.6%     589.90 ±  3%  interrupts.CPU58.CAL:Function_call_interrupts
     71157           +18.8%      84514        interrupts.CPU58.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU58.MCP:Machine_check_polls
      1861 ± 35%     -12.4%       1630 ± 30%  interrupts.CPU58.NMI:Non-maskable_interrupts
      1861 ± 35%     -12.4%       1630 ± 30%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
     24.40 ± 19%    +287.7%      94.60 ± 37%  interrupts.CPU58.RES:Rescheduling_interrupts
      2.70 ± 75%     +29.6%       3.50 ± 44%  interrupts.CPU58.TLB:TLB_shootdowns
      0.10 ±300%    +100.0%       0.20 ±200%  interrupts.CPU59.104:PCI-MSI.31981637-edge.i40e-eth0-TxRx-68
      0.00          -100.0%       0.00        interrupts.CPU59.286:PCI-MSI.69632-edge.ioat-msix
      0.00         +3e+101%       0.30 ±152%  interrupts.CPU59.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
      0.00         +2e+101%       0.20 ±300%  interrupts.CPU59.95:PCI-MSI.31981628-edge.i40e-eth0-TxRx-59
    760.50 ±  4%     -22.3%     591.10 ±  5%  interrupts.CPU59.CAL:Function_call_interrupts
     71105           +18.8%      84496        interrupts.CPU59.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU59.MCP:Machine_check_polls
      1759 ± 36%      +2.8%       1808 ± 20%  interrupts.CPU59.NMI:Non-maskable_interrupts
      1759 ± 36%      +2.8%       1808 ± 20%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
     27.00 ± 18%    +284.1%     103.70 ± 29%  interrupts.CPU59.RES:Rescheduling_interrupts
      1.70 ± 52%     +52.9%       2.60 ± 46%  interrupts.CPU59.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU6.117:PCI-MSI.31981650-edge.i40e-eth0-TxRx-81
      0.00          -100.0%       0.00        interrupts.CPU6.3:IO-APIC.3-edge
     30.70 ±288%    -100.0%       0.00        interrupts.CPU6.42:PCI-MSI.31981575-edge.i40e-eth0-TxRx-6
      0.10 ±300%    +100.0%       0.20 ±200%  interrupts.CPU6.73:PCI-MSI.31981606-edge.i40e-eth0-TxRx-37
    749.70 ±  3%     -20.8%     593.90 ±  8%  interrupts.CPU6.CAL:Function_call_interrupts
     71035           +19.0%      84514        interrupts.CPU6.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU6.MCP:Machine_check_polls
      2225 ± 22%     -12.1%       1956 ± 18%  interrupts.CPU6.NMI:Non-maskable_interrupts
      2225 ± 22%     -12.1%       1956 ± 18%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
     35.80 ±  9%    +194.4%     105.40 ± 37%  interrupts.CPU6.RES:Rescheduling_interrupts
      1.40 ± 91%     +71.4%       2.40 ± 67%  interrupts.CPU6.TLB:TLB_shootdowns
      0.00         +2e+101%       0.20 ±200%  interrupts.CPU60.105:PCI-MSI.31981638-edge.i40e-eth0-TxRx-69
      0.00          -100.0%       0.00        interrupts.CPU60.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU60.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
     12.20 ±300%     -99.2%       0.10 ±300%  interrupts.CPU60.96:PCI-MSI.31981629-edge.i40e-eth0-TxRx-60
    770.40 ±  4%     -21.2%     607.00 ±  5%  interrupts.CPU60.CAL:Function_call_interrupts
     71097           +18.9%      84515        interrupts.CPU60.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU60.MCP:Machine_check_polls
      1971 ± 31%     -13.7%       1701 ± 25%  interrupts.CPU60.NMI:Non-maskable_interrupts
      1971 ± 31%     -13.7%       1701 ± 25%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
     28.30 ± 15%    +255.8%     100.70 ± 40%  interrupts.CPU60.RES:Rescheduling_interrupts
      2.40 ± 46%      -4.2%       2.30 ± 19%  interrupts.CPU60.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU61.106:PCI-MSI.31981639-edge.i40e-eth0-TxRx-70
      0.00          -100.0%       0.00        interrupts.CPU61.286:PCI-MSI.69632-edge.ioat-msix
      0.20 ±200%      +0.0%       0.20 ±200%  interrupts.CPU61.62:PCI-MSI.31981595-edge.i40e-eth0-TxRx-26
      0.00         +5e+102%       5.00 ±286%  interrupts.CPU61.97:PCI-MSI.31981630-edge.i40e-eth0-TxRx-61
    745.20 ±  7%     -23.2%     572.60 ± 10%  interrupts.CPU61.CAL:Function_call_interrupts
     71124           +18.9%      84587        interrupts.CPU61.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU61.MCP:Machine_check_polls
      2107 ± 28%     -18.6%       1714 ± 26%  interrupts.CPU61.NMI:Non-maskable_interrupts
      2107 ± 28%     -18.6%       1714 ± 26%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
     27.60 ± 30%    +258.7%      99.00 ± 27%  interrupts.CPU61.RES:Rescheduling_interrupts
      2.50 ± 62%     +12.0%       2.80 ± 61%  interrupts.CPU61.TLB:TLB_shootdowns
      0.20 ±200%    -100.0%       0.00        interrupts.CPU62.107:PCI-MSI.31981640-edge.i40e-eth0-TxRx-71
      0.00         +3e+101%       0.30 ±152%  interrupts.CPU62.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
      0.30 ±300%    +533.3%       1.90 ±203%  interrupts.CPU62.98:PCI-MSI.31981631-edge.i40e-eth0-TxRx-62
    732.30 ±  2%     -18.9%     593.70 ±  2%  interrupts.CPU62.CAL:Function_call_interrupts
     71055           +18.9%      84477        interrupts.CPU62.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU62.MCP:Machine_check_polls
      2304 ± 17%     -29.9%       1615 ± 32%  interrupts.CPU62.NMI:Non-maskable_interrupts
      2304 ± 17%     -29.9%       1615 ± 32%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
     34.30 ± 48%    +290.1%     133.80 ± 24%  interrupts.CPU62.RES:Rescheduling_interrupts
      2.40 ± 56%     +16.7%       2.80 ± 41%  interrupts.CPU62.TLB:TLB_shootdowns
      0.10 ±300%    +100.0%       0.20 ±200%  interrupts.CPU63.108:PCI-MSI.31981641-edge.i40e-eth0-TxRx-72
      0.00          -100.0%       0.00        interrupts.CPU63.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU63.4:IO-APIC.4-edge.ttyS0
      0.10 ±300%    +200.0%       0.30 ±152%  interrupts.CPU63.64:PCI-MSI.31981597-edge.i40e-eth0-TxRx-28
      0.10 ±300%  +60200.0%      60.30 ±298%  interrupts.CPU63.99:PCI-MSI.31981632-edge.i40e-eth0-TxRx-63
    758.40 ±  3%     -21.1%     598.30 ±  4%  interrupts.CPU63.CAL:Function_call_interrupts
      0.00          -100.0%       0.00        interrupts.CPU63.IWI:IRQ_work_interrupts
     71122           +18.8%      84523        interrupts.CPU63.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU63.MCP:Machine_check_polls
      2363 ± 15%     -27.4%       1716 ± 27%  interrupts.CPU63.NMI:Non-maskable_interrupts
      2363 ± 15%     -27.4%       1716 ± 27%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
     31.70 ± 24%    +269.4%     117.10 ± 44%  interrupts.CPU63.RES:Rescheduling_interrupts
      2.10 ± 58%     +47.6%       3.10 ± 33%  interrupts.CPU63.TLB:TLB_shootdowns
      0.90 ±265%   +4222.2%      38.90 ±215%  interrupts.CPU64.100:PCI-MSI.31981633-edge.i40e-eth0-TxRx-64
      0.00         +2e+101%       0.20 ±200%  interrupts.CPU64.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU64.65:PCI-MSI.31981598-edge.i40e-eth0-TxRx-29
    783.30 ± 11%     -23.6%     598.30 ±  4%  interrupts.CPU64.CAL:Function_call_interrupts
     71136           +18.7%      84428        interrupts.CPU64.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU64.MCP:Machine_check_polls
      2208 ± 22%     -16.4%       1846 ± 22%  interrupts.CPU64.NMI:Non-maskable_interrupts
      2208 ± 22%     -16.4%       1846 ± 22%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
     32.30 ± 43%    +271.5%     120.00 ± 29%  interrupts.CPU64.RES:Rescheduling_interrupts
      2.20 ± 56%     +50.0%       3.30 ± 45%  interrupts.CPU64.TLB:TLB_shootdowns
      0.80 ±300%    +187.5%       2.30 ±200%  interrupts.CPU65.101:PCI-MSI.31981634-edge.i40e-eth0-TxRx-65
      0.10 ±300%    -100.0%       0.00        interrupts.CPU65.110:PCI-MSI.31981643-edge.i40e-eth0-TxRx-74
      0.00          -100.0%       0.00        interrupts.CPU65.303:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.10 ±300%    -100.0%       0.00        interrupts.CPU65.66:PCI-MSI.31981599-edge.i40e-eth0-TxRx-30
    744.20 ±  2%     -20.6%     590.70 ±  3%  interrupts.CPU65.CAL:Function_call_interrupts
      0.10 ±300%    -100.0%       0.00        interrupts.CPU65.IWI:IRQ_work_interrupts
     71191           +18.7%      84494        interrupts.CPU65.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU65.MCP:Machine_check_polls
      2239 ± 23%     -18.0%       1836 ± 22%  interrupts.CPU65.NMI:Non-maskable_interrupts
      2239 ± 23%     -18.0%       1836 ± 22%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
     30.50 ± 29%    +250.5%     106.90 ± 25%  interrupts.CPU65.RES:Rescheduling_interrupts
      2.70 ± 52%     +25.9%       3.40 ± 64%  interrupts.CPU65.TLB:TLB_shootdowns
      1.40 ±300%   +2157.1%      31.60 ±253%  interrupts.CPU66.102:PCI-MSI.31981635-edge.i40e-eth0-TxRx-66
    783.70 ±  6%     -19.1%     634.20 ± 13%  interrupts.CPU66.CAL:Function_call_interrupts
     71121           +18.8%      84511        interrupts.CPU66.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU66.MCP:Machine_check_polls
      2223 ± 23%     -18.4%       1814 ± 24%  interrupts.CPU66.NMI:Non-maskable_interrupts
      2223 ± 23%     -18.4%       1814 ± 24%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
     25.70 ± 22%    +305.4%     104.20 ± 19%  interrupts.CPU66.RES:Rescheduling_interrupts
      2.50 ± 69%      -4.0%       2.40 ± 42%  interrupts.CPU66.TLB:TLB_shootdowns
      0.70 ±300%    -100.0%       0.00        interrupts.CPU67.103:PCI-MSI.31981636-edge.i40e-eth0-TxRx-67
    751.50 ±  2%     -22.9%     579.10 ±  3%  interrupts.CPU67.CAL:Function_call_interrupts
     71110           +18.7%      84425        interrupts.CPU67.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU67.MCP:Machine_check_polls
      2224 ± 23%     -20.5%       1769 ± 22%  interrupts.CPU67.NMI:Non-maskable_interrupts
      2224 ± 23%     -20.5%       1769 ± 22%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
     24.80 ± 34%    +279.8%      94.20 ± 32%  interrupts.CPU67.RES:Rescheduling_interrupts
      2.70 ± 40%      -3.7%       2.60 ± 46%  interrupts.CPU67.TLB:TLB_shootdowns
     10.40 ±250%     -51.9%       5.00 ±251%  interrupts.CPU68.104:PCI-MSI.31981637-edge.i40e-eth0-TxRx-68
    745.10 ±  9%     -19.4%     600.70 ±  8%  interrupts.CPU68.CAL:Function_call_interrupts
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU68.IWI:IRQ_work_interrupts
     71150           +18.7%      84459        interrupts.CPU68.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU68.MCP:Machine_check_polls
      2309 ± 16%     -19.5%       1857 ± 16%  interrupts.CPU68.NMI:Non-maskable_interrupts
      2309 ± 16%     -19.5%       1857 ± 16%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
     26.70 ± 18%    +229.6%      88.00 ± 26%  interrupts.CPU68.RES:Rescheduling_interrupts
      3.00 ± 57%     -16.7%       2.50 ± 36%  interrupts.CPU68.TLB:TLB_shootdowns
      6089 ±299%    -100.0%       1.30 ±299%  interrupts.CPU69.105:PCI-MSI.31981638-edge.i40e-eth0-TxRx-69
    758.70 ±  5%     -23.6%     579.50 ±  2%  interrupts.CPU69.CAL:Function_call_interrupts
     71119           +18.8%      84465        interrupts.CPU69.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU69.MCP:Machine_check_polls
      2365 ± 16%     -22.2%       1840 ± 16%  interrupts.CPU69.NMI:Non-maskable_interrupts
      2365 ± 16%     -22.2%       1840 ± 16%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
     30.60 ± 48%    +185.6%      87.40 ± 33%  interrupts.CPU69.RES:Rescheduling_interrupts
      3.30 ± 38%     -27.3%       2.40 ± 50%  interrupts.CPU69.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU7.118:PCI-MSI.31981651-edge.i40e-eth0-TxRx-82
      0.00          -100.0%       0.00        interrupts.CPU7.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU7.286:PCI-MSI.69632-edge.ioat-msix
      0.10 ±300%    -100.0%       0.00        interrupts.CPU7.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
      0.00          -100.0%       0.00        interrupts.CPU7.74:PCI-MSI.31981607-edge.i40e-eth0-TxRx-38
    768.10 ±  6%     -23.1%     590.90 ±  3%  interrupts.CPU7.CAL:Function_call_interrupts
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU7.IWI:IRQ_work_interrupts
     71057           +19.0%      84539        interrupts.CPU7.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU7.MCP:Machine_check_polls
      2329 ± 16%     -14.9%       1981 ± 20%  interrupts.CPU7.NMI:Non-maskable_interrupts
      2329 ± 16%     -14.9%       1981 ± 20%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
     41.50 ± 13%    +175.9%     114.50 ± 32%  interrupts.CPU7.RES:Rescheduling_interrupts
      1.40 ±102%     +21.4%       1.70 ± 87%  interrupts.CPU7.TLB:TLB_shootdowns
      0.00       +2.7e+102%       2.70 ±287%  interrupts.CPU70.106:PCI-MSI.31981639-edge.i40e-eth0-TxRx-70
    758.30           -20.2%     604.80 ±  4%  interrupts.CPU70.CAL:Function_call_interrupts
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU70.IWI:IRQ_work_interrupts
     71035           +19.0%      84542        interrupts.CPU70.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU70.MCP:Machine_check_polls
      2358 ± 16%     -29.0%       1673 ± 29%  interrupts.CPU70.NMI:Non-maskable_interrupts
      2358 ± 16%     -29.0%       1673 ± 29%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
     27.90 ± 26%    +226.5%      91.10 ± 24%  interrupts.CPU70.RES:Rescheduling_interrupts
      2.60 ± 62%     -15.4%       2.20 ± 39%  interrupts.CPU70.TLB:TLB_shootdowns
      6.50 ±279%   +1350.8%      94.30 ±299%  interrupts.CPU71.107:PCI-MSI.31981640-edge.i40e-eth0-TxRx-71
    733.10 ±  5%     -18.5%     597.20 ±  7%  interrupts.CPU71.CAL:Function_call_interrupts
     71096           +18.8%      84482        interrupts.CPU71.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU71.MCP:Machine_check_polls
      2311 ± 16%     -22.2%       1798 ± 25%  interrupts.CPU71.NMI:Non-maskable_interrupts
      2311 ± 16%     -22.2%       1798 ± 25%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
     31.90 ± 31%    +192.2%      93.20 ± 34%  interrupts.CPU71.RES:Rescheduling_interrupts
      3.10 ± 46%      -6.5%       2.90 ± 49%  interrupts.CPU71.TLB:TLB_shootdowns
     37.60 ±286%      +1.3%      38.10 ±300%  interrupts.CPU72.108:PCI-MSI.31981641-edge.i40e-eth0-TxRx-72
    740.10 ±  7%     -20.3%     589.90 ±  3%  interrupts.CPU72.CAL:Function_call_interrupts
     71118           +18.8%      84493        interrupts.CPU72.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU72.MCP:Machine_check_polls
      2347 ± 16%     -25.5%       1748 ± 24%  interrupts.CPU72.NMI:Non-maskable_interrupts
      2347 ± 16%     -25.5%       1748 ± 24%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
     29.10 ± 23%    +235.4%      97.60 ± 39%  interrupts.CPU72.RES:Rescheduling_interrupts
      2.30 ± 39%     +17.4%       2.70 ± 33%  interrupts.CPU72.TLB:TLB_shootdowns
      0.30 ±300%  +13066.7%      39.50 ±283%  interrupts.CPU73.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
    748.20 ±  5%     -20.7%     593.10 ±  3%  interrupts.CPU73.CAL:Function_call_interrupts
     71185           +18.7%      84483        interrupts.CPU73.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU73.MCP:Machine_check_polls
      2345 ± 15%     -23.0%       1807 ± 24%  interrupts.CPU73.NMI:Non-maskable_interrupts
      2345 ± 15%     -23.0%       1807 ± 24%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
     28.60 ± 19%    +244.4%      98.50 ± 28%  interrupts.CPU73.RES:Rescheduling_interrupts
      3.30 ± 33%      -9.1%       3.00 ± 39%  interrupts.CPU73.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU74.110:PCI-MSI.31981643-edge.i40e-eth0-TxRx-74
    754.30 ±  4%     -18.0%     618.70 ±  6%  interrupts.CPU74.CAL:Function_call_interrupts
     71116           +18.8%      84490        interrupts.CPU74.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU74.MCP:Machine_check_polls
      2362 ± 17%     -28.5%       1688 ± 30%  interrupts.CPU74.NMI:Non-maskable_interrupts
      2362 ± 17%     -28.5%       1688 ± 30%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
     29.50 ± 30%    +192.9%      86.40 ± 23%  interrupts.CPU74.RES:Rescheduling_interrupts
      2.90 ± 32%      -6.9%       2.70 ± 28%  interrupts.CPU74.TLB:TLB_shootdowns
      1.50 ±225%    -100.0%       0.00        interrupts.CPU75.111:PCI-MSI.31981644-edge.i40e-eth0-TxRx-75
    761.90 ±  3%     -23.7%     581.50 ±  2%  interrupts.CPU75.CAL:Function_call_interrupts
     71131           +18.8%      84491        interrupts.CPU75.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU75.MCP:Machine_check_polls
      2477 ±  5%     -35.8%       1591 ± 31%  interrupts.CPU75.NMI:Non-maskable_interrupts
      2477 ±  5%     -35.8%       1591 ± 31%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
     29.00 ± 23%    +191.0%      84.40 ± 31%  interrupts.CPU75.RES:Rescheduling_interrupts
      2.90 ± 39%      +6.9%       3.10 ± 39%  interrupts.CPU75.TLB:TLB_shootdowns
      2.40 ±300%     -16.7%       2.00 ±300%  interrupts.CPU76.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
    748.50 ±  3%     -19.3%     603.70 ±  5%  interrupts.CPU76.CAL:Function_call_interrupts
      0.00         +2e+101%       0.20 ±300%  interrupts.CPU76.IWI:IRQ_work_interrupts
     71105           +18.8%      84498        interrupts.CPU76.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU76.MCP:Machine_check_polls
      2453 ±  4%     -26.2%       1809 ± 23%  interrupts.CPU76.NMI:Non-maskable_interrupts
      2453 ±  4%     -26.2%       1809 ± 23%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
     29.50 ± 35%    +187.8%      84.90 ± 29%  interrupts.CPU76.RES:Rescheduling_interrupts
      3.30 ± 40%     -18.2%       2.70 ± 43%  interrupts.CPU76.TLB:TLB_shootdowns
     55.80 ±213%    -100.0%       0.00        interrupts.CPU77.113:PCI-MSI.31981646-edge.i40e-eth0-TxRx-77
    746.60 ±  3%     -18.4%     608.90 ± 11%  interrupts.CPU77.CAL:Function_call_interrupts
     71145           +18.7%      84449        interrupts.CPU77.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU77.MCP:Machine_check_polls
      2311 ± 15%     -32.3%       1565 ± 30%  interrupts.CPU77.NMI:Non-maskable_interrupts
      2311 ± 15%     -32.3%       1565 ± 30%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
     27.90 ± 28%    +251.3%      98.00 ± 28%  interrupts.CPU77.RES:Rescheduling_interrupts
      3.10 ± 36%      -3.2%       3.00 ± 44%  interrupts.CPU77.TLB:TLB_shootdowns
      0.00       +2.7e+102%       2.70 ±196%  interrupts.CPU78.114:PCI-MSI.31981647-edge.i40e-eth0-TxRx-78
    742.90 ±  2%     -22.8%     573.60 ±  5%  interrupts.CPU78.CAL:Function_call_interrupts
     71128           +18.8%      84487        interrupts.CPU78.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU78.MCP:Machine_check_polls
      2337 ± 14%     -20.6%       1856 ± 18%  interrupts.CPU78.NMI:Non-maskable_interrupts
      2337 ± 14%     -20.6%       1856 ± 18%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
     26.40 ± 26%    +214.4%      83.00 ± 31%  interrupts.CPU78.RES:Rescheduling_interrupts
      3.30 ± 33%     -12.1%       2.90 ± 32%  interrupts.CPU78.TLB:TLB_shootdowns
     18.00 ±300%    -100.0%       0.00        interrupts.CPU79.115:PCI-MSI.31981648-edge.i40e-eth0-TxRx-79
    751.50 ±  3%     -20.0%     601.20 ±  3%  interrupts.CPU79.CAL:Function_call_interrupts
     71172           +18.7%      84495        interrupts.CPU79.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU79.MCP:Machine_check_polls
      2197 ± 23%     -19.8%       1761 ± 23%  interrupts.CPU79.NMI:Non-maskable_interrupts
      2197 ± 23%     -19.8%       1761 ± 23%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
     29.20 ± 19%    +230.8%      96.60 ± 22%  interrupts.CPU79.RES:Rescheduling_interrupts
      4.10 ± 27%     -26.8%       3.00 ± 39%  interrupts.CPU79.TLB:TLB_shootdowns
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU8.119:PCI-MSI.31981652-edge.i40e-eth0-TxRx-83
      0.00          -100.0%       0.00        interrupts.CPU8.286:PCI-MSI.69632-edge.ioat-msix
     12.70 ±300%     -97.6%       0.30 ±300%  interrupts.CPU8.44:PCI-MSI.31981577-edge.i40e-eth0-TxRx-8
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU8.75:PCI-MSI.31981608-edge.i40e-eth0-TxRx-39
    774.80 ± 12%     -22.5%     600.60 ±  6%  interrupts.CPU8.CAL:Function_call_interrupts
     71169           +18.8%      84531        interrupts.CPU8.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU8.MCP:Machine_check_polls
      2286 ± 15%     -18.8%       1855 ± 24%  interrupts.CPU8.NMI:Non-maskable_interrupts
      2286 ± 15%     -18.8%       1855 ± 24%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
     41.70 ± 45%    +168.6%     112.00 ± 33%  interrupts.CPU8.RES:Rescheduling_interrupts
      2.60 ± 92%      +3.8%       2.70 ± 95%  interrupts.CPU8.TLB:TLB_shootdowns
      1.10 ±300%    -100.0%       0.00        interrupts.CPU80.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
    792.40 ±  7%     -20.4%     630.80 ± 10%  interrupts.CPU80.CAL:Function_call_interrupts
     71145           +18.8%      84508        interrupts.CPU80.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU80.MCP:Machine_check_polls
      2196 ± 24%     -19.3%       1771 ± 26%  interrupts.CPU80.NMI:Non-maskable_interrupts
      2196 ± 24%     -19.3%       1771 ± 26%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
     29.90 ± 28%    +197.3%      88.90 ± 21%  interrupts.CPU80.RES:Rescheduling_interrupts
      3.60 ± 30%     -16.7%       3.00 ± 36%  interrupts.CPU80.TLB:TLB_shootdowns
      0.00       +1.8e+102%       1.80 ±300%  interrupts.CPU81.117:PCI-MSI.31981650-edge.i40e-eth0-TxRx-81
    773.00 ±  7%     -24.7%     582.30 ±  9%  interrupts.CPU81.CAL:Function_call_interrupts
     71150           +18.8%      84508        interrupts.CPU81.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU81.MCP:Machine_check_polls
      2365 ± 15%     -25.0%       1774 ± 25%  interrupts.CPU81.NMI:Non-maskable_interrupts
      2365 ± 15%     -25.0%       1774 ± 25%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
     29.20 ± 41%    +231.5%      96.80 ± 25%  interrupts.CPU81.RES:Rescheduling_interrupts
      3.30 ± 33%      +3.0%       3.40 ± 23%  interrupts.CPU81.TLB:TLB_shootdowns
      1.30 ±275%     -69.2%       0.40 ±300%  interrupts.CPU82.118:PCI-MSI.31981651-edge.i40e-eth0-TxRx-82
    731.00 ± 12%     -17.2%     605.10 ±  6%  interrupts.CPU82.CAL:Function_call_interrupts
     71191           +18.7%      84499        interrupts.CPU82.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU82.MCP:Machine_check_polls
      2349 ± 16%     -21.1%       1852 ± 17%  interrupts.CPU82.NMI:Non-maskable_interrupts
      2349 ± 16%     -21.1%       1852 ± 17%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
     30.30 ± 22%    +202.3%      91.60 ± 36%  interrupts.CPU82.RES:Rescheduling_interrupts
      3.00 ± 44%      -6.7%       2.80 ± 41%  interrupts.CPU82.TLB:TLB_shootdowns
     28.80 ±204%     -92.0%       2.30 ±236%  interrupts.CPU83.119:PCI-MSI.31981652-edge.i40e-eth0-TxRx-83
    756.30 ±  2%     -18.1%     619.10 ±  4%  interrupts.CPU83.CAL:Function_call_interrupts
     71129           +18.8%      84499        interrupts.CPU83.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU83.MCP:Machine_check_polls
      2319 ± 16%     -23.8%       1767 ± 23%  interrupts.CPU83.NMI:Non-maskable_interrupts
      2319 ± 16%     -23.8%       1767 ± 23%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
     26.10 ± 14%    +208.8%      80.60 ± 18%  interrupts.CPU83.RES:Rescheduling_interrupts
      3.10 ± 36%      -3.2%       3.00 ± 36%  interrupts.CPU83.TLB:TLB_shootdowns
      0.00       +1.2e+102%       1.20 ±300%  interrupts.CPU84.120:PCI-MSI.31981653-edge.i40e-eth0-TxRx-84
    750.80 ±  3%     -17.0%     623.00 ± 14%  interrupts.CPU84.CAL:Function_call_interrupts
     71144           +18.7%      84472        interrupts.CPU84.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU84.MCP:Machine_check_polls
      2220 ± 21%     -21.5%       1742 ± 23%  interrupts.CPU84.NMI:Non-maskable_interrupts
      2220 ± 21%     -21.5%       1742 ± 23%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
     37.40 ± 25%    +212.8%     117.00 ± 37%  interrupts.CPU84.RES:Rescheduling_interrupts
      3.00 ± 29%     +16.7%       3.50 ± 26%  interrupts.CPU84.TLB:TLB_shootdowns
      0.80 ±300%     +62.5%       1.30 ±300%  interrupts.CPU85.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
    757.90 ±  4%     -21.2%     597.20 ±  4%  interrupts.CPU85.CAL:Function_call_interrupts
     71131           +18.8%      84520        interrupts.CPU85.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU85.MCP:Machine_check_polls
      2100 ± 25%     -20.2%       1675 ± 26%  interrupts.CPU85.NMI:Non-maskable_interrupts
      2100 ± 25%     -20.2%       1675 ± 26%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
     43.40 ± 23%    +144.0%     105.90 ± 28%  interrupts.CPU85.RES:Rescheduling_interrupts
      4.00 ± 25%     -15.0%       3.40 ± 26%  interrupts.CPU85.TLB:TLB_shootdowns
      1.20 ±229%    +683.3%       9.40 ±237%  interrupts.CPU86.122:PCI-MSI.31981655-edge.i40e-eth0-TxRx-86
    729.80 ±  8%     -13.0%     634.70 ±  8%  interrupts.CPU86.CAL:Function_call_interrupts
     71133           +18.8%      84489        interrupts.CPU86.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU86.MCP:Machine_check_polls
      2117 ± 25%     -10.3%       1899 ± 18%  interrupts.CPU86.NMI:Non-maskable_interrupts
      2117 ± 25%     -10.3%       1899 ± 18%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
     36.50 ± 24%    +209.0%     112.80 ± 22%  interrupts.CPU86.RES:Rescheduling_interrupts
      3.60 ± 30%     +33.3%       4.80 ± 35%  interrupts.CPU86.TLB:TLB_shootdowns
      1.20 ±300%     -83.3%       0.20 ±300%  interrupts.CPU87.123:PCI-MSI.31981656-edge.i40e-eth0-TxRx-87
    679.90 ±  2%     -11.0%     605.10 ±  9%  interrupts.CPU87.CAL:Function_call_interrupts
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU87.IWI:IRQ_work_interrupts
     71115           +18.8%      84503        interrupts.CPU87.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU87.MCP:Machine_check_polls
      2070 ± 26%     -16.2%       1735 ± 22%  interrupts.CPU87.NMI:Non-maskable_interrupts
      2070 ± 26%     -16.2%       1735 ± 22%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
     31.80 ± 26%    +209.1%      98.30 ± 59%  interrupts.CPU87.RES:Rescheduling_interrupts
      0.50 ±134%     +80.0%       0.90 ±104%  interrupts.CPU87.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU9.120:PCI-MSI.31981653-edge.i40e-eth0-TxRx-84
      0.00          -100.0%       0.00        interrupts.CPU9.285:PCI-MSI.67584-edge.ioat-msix
      4.70 ±200%    -100.0%       0.00        interrupts.CPU9.45:PCI-MSI.31981578-edge.i40e-eth0-TxRx-9
      0.00          -100.0%       0.00        interrupts.CPU9.76:PCI-MSI.31981609-edge.i40e-eth0-TxRx-40
    960.90 ± 46%     -19.9%     769.70 ± 64%  interrupts.CPU9.CAL:Function_call_interrupts
     71094           +19.0%      84618        interrupts.CPU9.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU9.MCP:Machine_check_polls
      2336 ± 18%     -17.3%       1931 ± 20%  interrupts.CPU9.NMI:Non-maskable_interrupts
      2336 ± 18%     -17.3%       1931 ± 20%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
     32.40 ± 23%    +213.3%     101.50 ± 28%  interrupts.CPU9.RES:Rescheduling_interrupts
      1.80 ± 64%     +27.8%       2.30 ± 64%  interrupts.CPU9.TLB:TLB_shootdowns
      3.00            +0.0%       3.00        interrupts.IWI:IRQ_work_interrupts
   6257732           +18.8%    7435130        interrupts.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.MCP:Machine_check_polls
    198753 ±  8%     -20.1%     158792 ±  6%  interrupts.NMI:Non-maskable_interrupts
    198753 ±  8%     -20.1%     158792 ±  6%  interrupts.PMI:Performance_monitoring_interrupts
      2838 ±  3%    +218.0%       9026 ±  9%  interrupts.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00        interrupts.RTR:APIC_ICR_read_retries
    206.90 ± 43%      +3.7%     214.60 ± 28%  interrupts.TLB:TLB_shootdowns

[2]
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
    692.01 ±  6%     +30.7%     904.12 ±  2%  aim7.cpu
    538894           -15.9%     453458        aim7.jobs-per-min
    179.63           -15.9%     151.15        aim7.jobs-per-min-per-task
     97.00            -0.9%      96.10        aim7.jti
     33.40           +18.8%      39.70        aim7.real
     33.60           +18.7%      39.90        aim7.time.elapsed_time
     33.60           +18.7%      39.90        aim7.time.elapsed_time.max
    192.00            +0.0%     192.00        aim7.time.file_system_inputs
 6.168e+08            +0.0%  6.168e+08        aim7.time.file_system_outputs
      2075 ±  8%    +794.2%      18556        aim7.time.involuntary_context_switches
      2027 ± 32%     -29.0%       1438 ± 41%  aim7.time.major_page_faults
      2823            -0.3%       2813        aim7.time.maximum_resident_set_size
    165376            +1.4%     167638 ±  2%  aim7.time.minor_page_faults
      4096            +0.0%       4096        aim7.time.page_size
      2060 ±  5%     +10.1%       2267 ±  2%  aim7.time.percent_of_cpu_this_job_got
    674.84 ±  6%     +31.3%     885.96 ±  2%  aim7.time.system_time
     17.86 ±  2%      +5.6%      18.86        aim7.time.user_time
    912280           -34.7%     595708        aim7.time.voluntary_context_switches
 2.379e+09 ±  2%     +11.7%  2.656e+09        cpuidle..time
   5871992 ±  4%      +3.0%    6050675 ± 14%  cpuidle..usage
     72.82            +8.1%      78.71        uptime.boot
      5300            +5.5%       5591        uptime.idle
     34.92            +0.4%      35.06        boot-time.boot
     16.89            +0.7%      17.00        boot-time.dhcp
      2622            +1.1%       2651        boot-time.idle
      0.88            -0.0%       0.88        boot-time.smp_boot
     76.96            -3.7%      74.09        iostat.cpu.idle
      0.02 ± 72%      -9.0%       0.02 ± 47%  iostat.cpu.iowait
     22.23 ±  4%     +13.3%      25.19 ±  2%  iostat.cpu.system
      0.79 ±  4%     -10.5%       0.71        iostat.cpu.user
     75.95            -2.9       73.01        mpstat.cpu.all.idle%
      0.02 ± 90%      -0.0        0.02 ± 60%  mpstat.cpu.all.iowait%
      1.04 ±  9%      +0.1        1.11 ±  7%  mpstat.cpu.all.irq%
      0.12 ±  5%      -0.0        0.11 ±  5%  mpstat.cpu.all.soft%
     22.09 ±  5%      +3.0       25.05 ±  2%  mpstat.cpu.all.sys%
      0.79 ±  4%      -0.1        0.70        mpstat.cpu.all.usr%
      0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
  39082384            +1.1%   39493389        numa-numastat.node0.local_node
  39087528            +1.1%   39503011        numa-numastat.node0.numa_hit
     43051 ± 46%     +48.8%      64044 ± 36%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
  38376221            -0.6%   38148152 ±  2%  numa-numastat.node1.local_node
  38371842            -0.6%   38136374 ±  2%  numa-numastat.node1.numa_hit
     36339 ± 55%     -57.5%      15444 ±151%  numa-numastat.node1.other_node
     33.60           +18.7%      39.90        time.elapsed_time
     33.60           +18.7%      39.90        time.elapsed_time.max
    192.00            +0.0%     192.00        time.file_system_inputs
 6.168e+08            +0.0%  6.168e+08        time.file_system_outputs
      2075 ±  8%    +794.2%      18556        time.involuntary_context_switches
      2027 ± 32%     -29.0%       1438 ± 41%  time.major_page_faults
      2823            -0.3%       2813        time.maximum_resident_set_size
    165376            +1.4%     167638 ±  2%  time.minor_page_faults
      4096            +0.0%       4096        time.page_size
      2060 ±  5%     +10.1%       2267 ±  2%  time.percent_of_cpu_this_job_got
    674.84 ±  6%     +31.3%     885.96 ±  2%  time.system_time
     17.86 ±  2%      +5.6%      18.86        time.user_time
    912280           -34.7%     595708        time.voluntary_context_switches
     76.50            -3.7%      73.70        vmstat.cpu.id
     21.70 ±  4%     +13.8%      24.70 ±  2%  vmstat.cpu.sy
      0.00          -100.0%       0.00        vmstat.cpu.us
      0.00          -100.0%       0.00        vmstat.cpu.wa
      2.80 ± 85%     +14.3%       3.20 ± 75%  vmstat.io.bi
      2530 ± 17%    +124.0%       5669 ±  9%  vmstat.io.bo
      4.00            +0.0%       4.00        vmstat.memory.buff
   2564394            +0.2%    2570736        vmstat.memory.cache
  1.27e+08            -0.0%   1.27e+08        vmstat.memory.free
      0.00          -100.0%       0.00        vmstat.procs.b
     19.00 ±  5%     +10.5%      21.00 ± 17%  vmstat.procs.r
     51907 ±  2%     -14.5%      44375        vmstat.system.cs
    185136            -7.1%     171923 ± 14%  vmstat.system.in
    666.20 ±  4%     +12.7%     750.60 ±  2%  turbostat.Avg_MHz
     24.43 ±  3%      +3.1       27.53 ±  2%  turbostat.Busy%
      2733            -0.0%       2732        turbostat.Bzy_MHz
     90379 ±  3%     +52.1%     137469 ± 27%  turbostat.C1
      0.30 ±  6%      -0.1        0.19 ± 10%  turbostat.C1%
   4794198 ± 12%     -17.5%    3956071 ± 33%  turbostat.C1E
     55.97 ± 26%     -21.6       34.40 ± 54%  turbostat.C1E%
    972593 ± 71%     +99.6%    1941448 ± 36%  turbostat.C6
     19.68 ± 76%     +18.7       38.33 ± 49%  turbostat.C6%
     74.59 ±  3%      -7.8%      68.76 ±  5%  turbostat.CPU%c1
      0.98 ±221%    +276.8%       3.71 ± 94%  turbostat.CPU%c6
     54.40 ±  3%      +1.7%      55.30        turbostat.CoreTmp
   6829961 ±  2%      +7.7%    7355161 ± 14%  turbostat.IRQ
      0.38 ±300%    +410.2%       1.95 ±104%  turbostat.Pkg%pc2
      0.17 ±299%    +570.4%       1.13 ±114%  turbostat.Pkg%pc6
     54.50 ±  3%      +1.3%      55.20        turbostat.PkgTmp
    168.21            +0.6%     169.27        turbostat.PkgWatt
     57.08            -1.6%      56.16        turbostat.RAMWatt
      2095            +0.0%       2095        turbostat.TSC_MHz
     15462 ± 11%     +20.4%      18614 ±  2%  meminfo.Active
     14620 ± 12%     +21.5%      17768 ±  2%  meminfo.Active(anon)
    842.00            +0.5%     846.30 ±  2%  meminfo.Active(file)
     58629 ±  4%      +8.8%      63797 ±  2%  meminfo.AnonHugePages
    354304            +0.9%     357479        meminfo.AnonPages
      4.00            +0.0%       4.00        meminfo.Buffers
   2430501            +0.1%    2431819        meminfo.Cached
      0.00       +1.2e+107%     120842 ± 81%  meminfo.CmaFree
      0.00       +1.2e+107%     122880 ± 81%  meminfo.CmaTotal
  65836764            +0.0%   65836764        meminfo.CommitLimit
   2612758            +1.3%    2647986        meminfo.Committed_AS
  1.23e+08 ±  2%      -1.4%  1.212e+08        meminfo.DirectMap1G
  12239099 ± 20%     +14.7%   14042316 ±  3%  meminfo.DirectMap2M
    749067 ±  2%      -2.8%     728429 ±  6%  meminfo.DirectMap4k
     10755 ± 12%     -26.0%       7959 ± 11%  meminfo.Dirty
      2048            +0.0%       2048        meminfo.Hugepagesize
    377102            -0.2%     376293        meminfo.Inactive
    365520            +0.5%     367427        meminfo.Inactive(anon)
     11581 ± 11%     -23.4%       8865 ± 10%  meminfo.Inactive(file)
    132705            +4.3%     138409        meminfo.KReclaimable
     59372            +1.9%      60496        meminfo.KernelStack
     34963 ±  2%      -3.5%      33747        meminfo.Mapped
 1.264e+08            -0.0%  1.264e+08        meminfo.MemAvailable
  1.27e+08            -0.0%   1.27e+08        meminfo.MemFree
 1.317e+08            +0.0%  1.317e+08        meminfo.MemTotal
   4683971            +0.5%    4709269        meminfo.Memused
     99649 ±  4%      +4.0%     103626 ±  8%  meminfo.PageTables
     47730            +0.2%      47829        meminfo.Percpu
    132705            +4.3%     138409        meminfo.SReclaimable
    296336            +1.9%     301931        meminfo.SUnreclaim
     26011 ±  9%      +7.9%      28058        meminfo.Shmem
    429043            +2.6%     440341        meminfo.Slab
   2389112            +0.0%    2389729        meminfo.Unevictable
 3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
    214867            +0.5%     215955        meminfo.VmallocUsed
      3.70 ±207%    +640.5%      27.40 ± 77%  meminfo.Writeback
   4734072            +0.7%    4768311        meminfo.max_used_kB
      2562 ± 34%     -23.0%       1974 ± 13%  numa-meminfo.node0.Active
      1803 ± 56%     -37.5%       1127 ± 23%  numa-meminfo.node0.Active(anon)
    758.80 ± 33%     +11.6%     846.60 ±  2%  numa-meminfo.node0.Active(file)
     44109 ± 33%     +21.1%      53399 ±  7%  numa-meminfo.node0.AnonHugePages
    266565 ± 29%      +9.0%     290524 ± 10%  numa-meminfo.node0.AnonPages
    291555 ± 29%      +7.1%     312176 ± 11%  numa-meminfo.node0.AnonPages.max
      5297 ± 13%     -20.6%       4207 ± 15%  numa-meminfo.node0.Dirty
   1480005 ± 73%     +60.0%    2368025 ±  3%  numa-meminfo.node0.FilePages
    273205 ± 29%     +10.1%     300898 ± 10%  numa-meminfo.node0.Inactive
    267208 ± 29%     +10.7%     295852 ± 10%  numa-meminfo.node0.Inactive(anon)
      5996 ± 15%     -15.9%       5046 ± 17%  numa-meminfo.node0.Inactive(file)
     68453 ± 28%     +28.7%      88105 ±  7%  numa-meminfo.node0.KReclaimable
     39339 ± 50%     +13.0%      44465 ± 39%  numa-meminfo.node0.KernelStack
     18047 ± 74%     +68.8%      30470 ±  8%  numa-meminfo.node0.Mapped
  62912306            -1.7%   61824920        numa-meminfo.node0.MemFree
  65659180            +0.0%   65659180        numa-meminfo.node0.MemTotal
   2746872 ± 42%     +39.6%    3834258 ±  5%  numa-meminfo.node0.MemUsed
     68981 ± 63%     +20.9%      83373 ± 49%  numa-meminfo.node0.PageTables
     68453 ± 28%     +28.7%      88105 ±  7%  numa-meminfo.node0.SReclaimable
    166000 ± 24%     +14.2%     189573 ± 21%  numa-meminfo.node0.SUnreclaim
      2670 ±102%    +149.0%       6648 ± 67%  numa-meminfo.node0.Shmem
    234455 ± 19%     +18.4%     277680 ± 15%  numa-meminfo.node0.Slab
   1469089 ± 73%     +60.2%    2353352 ±  2%  numa-meminfo.node0.Unevictable
      4.00 ±210%    +230.0%      13.20 ±113%  numa-meminfo.node0.Writeback
     12901 ± 17%     +29.0%      16639 ±  3%  numa-meminfo.node1.Active
     12818 ± 17%     +29.8%      16639 ±  3%  numa-meminfo.node1.Active(anon)
     83.10 ±299%    -100.0%       0.00        numa-meminfo.node1.Active(file)
     14548 ±107%     -28.0%      10470 ± 33%  numa-meminfo.node1.AnonHugePages
     87802 ± 92%     -23.6%      67083 ± 45%  numa-meminfo.node1.AnonPages
    110981 ± 76%     -19.0%      89846 ± 39%  numa-meminfo.node1.AnonPages.max
      4808 ±  6%     -23.7%       3668 ± 11%  numa-meminfo.node1.Dirty
    950098 ±113%     -93.2%      64197 ±110%  numa-meminfo.node1.FilePages
    103369 ± 78%     -26.9%      75524 ± 41%  numa-meminfo.node1.Inactive
     98374 ± 81%     -27.0%      71777 ± 43%  numa-meminfo.node1.Inactive(anon)
      4994 ± 14%     -25.0%       3746 ± 11%  numa-meminfo.node1.Inactive(file)
     64273 ± 30%     -21.7%      50307 ± 13%  numa-meminfo.node1.KReclaimable
     19996 ± 98%     -20.0%      16005 ±109%  numa-meminfo.node1.KernelStack
     17019 ± 75%     -79.4%       3501 ± 76%  numa-meminfo.node1.Mapped
  64077339            +1.7%   65139245        numa-meminfo.node1.MemFree
  66014352            +0.0%   66014352        numa-meminfo.node1.MemTotal
   1937011 ± 60%     -54.8%     875105 ± 26%  numa-meminfo.node1.MemUsed
     30599 ±145%     -33.9%      20238 ±187%  numa-meminfo.node1.PageTables
     64273 ± 30%     -21.7%      50307 ± 13%  numa-meminfo.node1.SReclaimable
    130288 ± 30%     -13.8%     112341 ± 37%  numa-meminfo.node1.SUnreclaim
     23341 ± 17%      -8.0%      21480 ± 20%  numa-meminfo.node1.Shmem
    194562 ± 22%     -16.4%     162649 ± 27%  numa-meminfo.node1.Slab
    920027 ±117%     -96.0%      36377 ±193%  numa-meminfo.node1.Unevictable
      1.60 ±300%    +775.0%      14.00 ± 63%  numa-meminfo.node1.Writeback
      0.00       +2.2e+104%     220.80 ± 81%  proc-vmstat.cma_alloc_success
      0.00          -100.0%       0.00        proc-vmstat.compact_isolated
    350.20 ±  2%      -2.9%     340.20 ±  6%  proc-vmstat.direct_map_level2_splits
      8.40 ± 27%     +17.9%       9.90 ±  3%  proc-vmstat.direct_map_level3_splits
      3654 ± 12%     +21.5%       4441 ±  2%  proc-vmstat.nr_active_anon
    210.40            +0.5%     211.50 ±  2%  proc-vmstat.nr_active_file
     88575            +0.9%      89372        proc-vmstat.nr_anon_pages
     28.10 ±  4%     +10.0%      30.90 ±  2%  proc-vmstat.nr_anon_transparent_hugepages
  76766318            +0.3%   76961254        proc-vmstat.nr_dirtied
      2749 ±  8%     -23.9%       2092 ±  8%  proc-vmstat.nr_dirty
   3155008            -0.0%    3154310        proc-vmstat.nr_dirty_background_threshold
   6317730            -0.0%    6316335        proc-vmstat.nr_dirty_threshold
    607687            +0.1%     608061        proc-vmstat.nr_file_pages
      0.00         +3e+106%      30210 ± 81%  proc-vmstat.nr_free_cma
  31747399            -0.0%   31741068        proc-vmstat.nr_free_pages
     91378            +0.5%      91858        proc-vmstat.nr_inactive_anon
      2962 ±  7%     -21.9%       2313 ±  7%  proc-vmstat.nr_inactive_file
      1.40 ±300%     -14.3%       1.20 ±229%  proc-vmstat.nr_isolated_anon
     59368            +1.9%      60492        proc-vmstat.nr_kernel_stack
      8742 ±  2%      -3.5%       8440        proc-vmstat.nr_mapped
     24910 ±  4%      +4.0%      25906 ±  8%  proc-vmstat.nr_page_table_pages
      6502 ±  9%      +7.9%       7014        proc-vmstat.nr_shmem
     33176            +4.3%      34603        proc-vmstat.nr_slab_reclaimable
     74083            +1.9%      75482        proc-vmstat.nr_slab_unreclaimable
    597277            +0.0%     597432        proc-vmstat.nr_unevictable
      0.80 ±207%    +712.5%       6.50 ± 84%  proc-vmstat.nr_writeback
     11430 ± 29%     +42.5%      16289 ± 32%  proc-vmstat.nr_written
      3654 ± 12%     +21.5%       4441 ±  2%  proc-vmstat.nr_zone_active_anon
    210.40            +0.5%     211.50 ±  2%  proc-vmstat.nr_zone_active_file
     91378            +0.5%      91858        proc-vmstat.nr_zone_inactive_anon
      2961 ±  7%     -21.9%       2314 ±  7%  proc-vmstat.nr_zone_inactive_file
    597277            +0.0%     597432        proc-vmstat.nr_zone_unevictable
      2429 ±  8%     -27.5%       1760 ±  6%  proc-vmstat.nr_zone_write_pending
      5.10 ± 86%  +12762.7%     656.00 ±296%  proc-vmstat.numa_hint_faults
      4.70 ± 97%    +859.6%      45.10 ±245%  proc-vmstat.numa_hint_faults_local
  77410785            +0.3%   77621935        proc-vmstat.numa_hit
      4.60 ± 96%    +102.2%       9.30 ± 58%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00        proc-vmstat.numa_interleave
  77409874            +0.3%   77624099        proc-vmstat.numa_local
     79391            +0.1%      79488        proc-vmstat.numa_other
      0.40 ±300%  +1.5e+05%     610.90 ±300%  proc-vmstat.numa_pages_migrated
      2355 ± 96%    +281.9%       8994 ±145%  proc-vmstat.numa_pte_updates
      9577 ±  7%      -1.9%       9397 ±  4%  proc-vmstat.pgactivate
      0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
  77309650            +0.3%   77527382        proc-vmstat.pgalloc_normal
    410192 ±  2%      +4.0%     426744        proc-vmstat.pgfault
  77139051            +0.3%   77355935        proc-vmstat.pgfree
      0.40 ±300%  +1.5e+05%     610.90 ±300%  proc-vmstat.pgmigrate_success
    123.20 ± 66%     +22.1%     150.40 ± 72%  proc-vmstat.pgpgin
     93739 ± 18%    +160.1%     243822 ±  9%  proc-vmstat.pgpgout
     14072 ±  3%      +9.4%      15388 ±  4%  proc-vmstat.pgreuse
     31.20 ±  7%      +5.1%      32.80 ±  7%  proc-vmstat.thp_collapse_alloc
      0.10 ±300%    -100.0%       0.00        proc-vmstat.thp_deferred_split_page
     10.10 ± 18%     +11.9%      11.30 ±  6%  proc-vmstat.thp_fault_alloc
      0.00          -100.0%       0.00        proc-vmstat.thp_migration_success
      0.10 ±300%    -100.0%       0.00        proc-vmstat.thp_split_pmd
      0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
      1634            +0.7%       1645        proc-vmstat.unevictable_pgs_culled
    450.70 ± 56%     -37.5%     281.50 ± 23%  numa-vmstat.node0.nr_active_anon
    189.60 ± 33%     +11.6%     211.60 ±  2%  numa-vmstat.node0.nr_active_file
     66640 ± 29%      +9.0%      72629 ± 10%  numa-vmstat.node0.nr_anon_pages
     21.20 ± 33%     +19.8%      25.40 ±  7%  numa-vmstat.node0.nr_anon_transparent_hugepages
  13654262 ±  4%      +5.8%   14449444 ±  2%  numa-vmstat.node0.nr_dirtied
      1361 ± 15%     -23.8%       1037 ± 14%  numa-vmstat.node0.nr_dirty
    370040 ± 73%     +60.0%     592003 ±  2%  numa-vmstat.node0.nr_file_pages
      0.00         +3e+106%      30210 ± 81%  numa-vmstat.node0.nr_free_cma
  15728082            -1.7%   15456235        numa-vmstat.node0.nr_free_pages
     66803 ± 29%     +10.7%      73961 ± 10%  numa-vmstat.node0.nr_inactive_anon
      1532 ± 16%     -19.0%       1240 ± 18%  numa-vmstat.node0.nr_inactive_file
     39335 ± 50%     +13.0%      44461 ± 39%  numa-vmstat.node0.nr_kernel_stack
      4513 ± 74%     +68.8%       7617 ±  8%  numa-vmstat.node0.nr_mapped
     17244 ± 63%     +20.9%      20843 ± 49%  numa-vmstat.node0.nr_page_table_pages
    667.00 ±102%    +149.2%       1661 ± 67%  numa-vmstat.node0.nr_shmem
     17115 ± 29%     +28.7%      22026 ±  7%  numa-vmstat.node0.nr_slab_reclaimable
     41499 ± 24%     +14.2%      47392 ± 21%  numa-vmstat.node0.nr_slab_unreclaimable
    367272 ± 73%     +60.2%     588337 ±  2%  numa-vmstat.node0.nr_unevictable
      0.90 ±213%    +233.3%       3.00 ±123%  numa-vmstat.node0.nr_writeback
      2714 ± 30%     +26.8%       3441 ± 33%  numa-vmstat.node0.nr_written
    450.70 ± 56%     -37.5%     281.50 ± 23%  numa-vmstat.node0.nr_zone_active_anon
    189.60 ± 33%     +11.6%     211.60 ±  2%  numa-vmstat.node0.nr_zone_active_file
     66803 ± 29%     +10.7%      73961 ± 10%  numa-vmstat.node0.nr_zone_inactive_anon
      1542 ± 15%     -19.6%       1239 ± 17%  numa-vmstat.node0.nr_zone_inactive_file
    367272 ± 73%     +60.2%     588337 ±  2%  numa-vmstat.node0.nr_zone_unevictable
      1214 ± 14%     -30.0%     850.80 ± 14%  numa-vmstat.node0.nr_zone_write_pending
  14975845 ±  5%      +7.7%   16133171 ±  3%  numa-vmstat.node0.numa_hit
      3846 ±  5%      -4.0%       3693 ±  7%  numa-vmstat.node0.numa_interleave
  14940789 ±  5%      +7.7%   16089361 ±  3%  numa-vmstat.node0.numa_local
     47300 ± 41%     +35.7%      64207 ± 35%  numa-vmstat.node0.numa_other
      3204 ± 17%     +29.8%       4159 ±  3%  numa-vmstat.node1.nr_active_anon
     20.70 ±299%    -100.0%       0.00        numa-vmstat.node1.nr_active_file
     21955 ± 92%     -23.6%      16773 ± 45%  numa-vmstat.node1.nr_anon_pages
      6.80 ±113%     -32.4%       4.60 ± 37%  numa-vmstat.node1.nr_anon_transparent_hugepages
  13176623 ±  5%      +3.8%   13680469 ±  4%  numa-vmstat.node1.nr_dirtied
      1249 ± 15%     -25.6%     929.90 ± 11%  numa-vmstat.node1.nr_dirty
    237575 ±113%     -93.2%      16062 ±110%  numa-vmstat.node1.nr_file_pages
  16019334            +1.7%   16284810        numa-vmstat.node1.nr_free_pages
     24598 ± 81%     -27.0%      17948 ± 43%  numa-vmstat.node1.nr_inactive_anon
      1302 ± 16%     -27.6%     943.80 ±  9%  numa-vmstat.node1.nr_inactive_file
     19992 ± 98%     -19.9%      16004 ±109%  numa-vmstat.node1.nr_kernel_stack
      4263 ± 75%     -79.3%     881.60 ± 76%  numa-vmstat.node1.nr_mapped
      7647 ±145%     -33.9%       5058 ±187%  numa-vmstat.node1.nr_page_table_pages
      5836 ± 17%      -8.0%       5371 ± 20%  numa-vmstat.node1.nr_shmem
     16068 ± 30%     -21.7%      12576 ± 13%  numa-vmstat.node1.nr_slab_reclaimable
     32570 ± 30%     -13.8%      28084 ± 37%  numa-vmstat.node1.nr_slab_unreclaimable
    230006 ±117%     -96.0%       9093 ±193%  numa-vmstat.node1.nr_unevictable
      0.40 ±300%    +700.0%       3.20 ± 66%  numa-vmstat.node1.nr_writeback
      3029 ± 40%      +7.6%       3259 ± 41%  numa-vmstat.node1.nr_written
      3204 ± 17%     +29.8%       4159 ±  3%  numa-vmstat.node1.nr_zone_active_anon
     20.70 ±299%    -100.0%       0.00        numa-vmstat.node1.nr_zone_active_file
     24597 ± 81%     -27.0%      17947 ± 43%  numa-vmstat.node1.nr_zone_inactive_anon
      1297 ± 16%     -27.6%     939.00 ± 10%  numa-vmstat.node1.nr_zone_inactive_file
    230006 ±117%     -96.0%       9093 ±193%  numa-vmstat.node1.nr_zone_unevictable
      1088 ± 19%     -30.6%     755.40 ± 12%  numa-vmstat.node1.nr_zone_write_pending
  14189150 ±  5%      +1.1%   14343600 ±  4%  numa-vmstat.node1.numa_hit
      3786 ±  6%      +3.4%       3915 ±  6%  numa-vmstat.node1.numa_interleave
  14159552 ±  5%      +1.2%   14328541 ±  4%  numa-vmstat.node1.numa_local
     42303 ± 46%     -39.6%      25572 ± 89%  numa-vmstat.node1.numa_other
      6.04 ± 77%    +103.4%      12.29 ± 66%  perf-stat.i.MPKI
 8.013e+09            +0.5%  8.054e+09        perf-stat.i.branch-instructions
      1.30 ± 38%      +0.5        1.81 ± 43%  perf-stat.i.branch-miss-rate%
  49176033 ±  8%     -15.0%   41780646 ±  3%  perf-stat.i.branch-misses
     21.66 ± 11%      +2.0       23.70 ± 10%  perf-stat.i.cache-miss-rate%
  45624630 ±  2%     -15.9%   38369109 ±  3%  perf-stat.i.cache-misses
 1.855e+08 ±  3%     -21.3%   1.46e+08 ±  6%  perf-stat.i.cache-references
     54083           -16.0%      45444        perf-stat.i.context-switches
      1.81 ± 11%     +23.4%       2.24 ± 14%  perf-stat.i.cpi
     88050            -0.0%      88036        perf-stat.i.cpu-clock
 5.842e+10 ±  4%     +12.3%  6.562e+10 ±  2%  perf-stat.i.cpu-cycles
      2320 ±  8%     -21.4%       1823 ±  3%  perf-stat.i.cpu-migrations
      2446 ± 28%     -16.8%       2035 ± 15%  perf-stat.i.cycles-between-cache-misses
      0.06 ±115%      +0.1        0.15 ± 54%  perf-stat.i.dTLB-load-miss-rate%
    986584 ± 25%     +23.1%    1214426 ± 10%  perf-stat.i.dTLB-load-misses
 1.192e+10            -0.8%  1.183e+10        perf-stat.i.dTLB-loads
      0.01 ± 86%      +0.0        0.03 ± 46%  perf-stat.i.dTLB-store-miss-rate%
    122987 ± 15%     +13.9%     140142 ±  8%  perf-stat.i.dTLB-store-misses
  6.46e+09           -13.4%  5.592e+09        perf-stat.i.dTLB-stores
     71.42            +5.3       76.76 ±  4%  perf-stat.i.iTLB-load-miss-rate%
  25851914 ±  4%     -17.8%   21254498 ±  6%  perf-stat.i.iTLB-load-misses
   4982161 ±  2%     -22.5%    3862684 ±  6%  perf-stat.i.iTLB-loads
 4.157e+10            +0.4%  4.175e+10        perf-stat.i.instructions
      2059 ±  7%     +10.5%       2275 ±  7%  perf-stat.i.instructions-per-iTLB-miss
      0.66 ±  3%     -10.6%       0.59 ±  2%  perf-stat.i.ipc
     63.32 ± 31%     -38.0%      39.25 ± 38%  perf-stat.i.major-faults
      0.66 ±  4%     +12.4%       0.75 ±  2%  perf-stat.i.metric.GHz
    324.07 ± 17%     +14.2%     370.06 ± 27%  perf-stat.i.metric.K/sec
    301.90            -3.6%     291.16        perf-stat.i.metric.M/sec
      8714 ±  2%     -12.4%       7637 ±  2%  perf-stat.i.minor-faults
     77.25            -1.1       76.20        perf-stat.i.node-load-miss-rate%
   8172568 ±  3%     -16.0%    6865546 ±  3%  perf-stat.i.node-load-misses
   2458033 ±  3%      -9.0%    2237467        perf-stat.i.node-loads
     46.91 ±  6%      -3.7       43.19 ±  6%  perf-stat.i.node-store-miss-rate%
   2446012 ±  2%      -7.2%    2270050        perf-stat.i.node-store-misses
   3990181            -8.8%    3637626        perf-stat.i.node-stores
      8777 ±  2%     -12.5%       7676 ±  2%  perf-stat.i.page-faults
     88050            -0.0%      88036        perf-stat.i.task-clock
      4.46 ±  4%     -21.7%       3.50 ±  6%  perf-stat.overall.MPKI
      0.61 ±  8%      -0.1        0.52 ±  2%  perf-stat.overall.branch-miss-rate%
     24.63 ±  3%      +1.7       26.35 ±  4%  perf-stat.overall.cache-miss-rate%
      1.41 ±  5%     +11.9%       1.57 ±  2%  perf-stat.overall.cpi
      1280 ±  3%     +33.7%       1711 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.01 ± 25%      +0.0        0.01 ± 10%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ± 14%      +0.0        0.00 ±  9%  perf-stat.overall.dTLB-store-miss-rate%
     83.84            +0.8       84.60        perf-stat.overall.iTLB-load-miss-rate%
      1610 ±  3%     +22.4%       1970 ±  5%  perf-stat.overall.instructions-per-iTLB-miss
      0.71 ±  5%     -10.8%       0.64 ±  2%  perf-stat.overall.ipc
     76.87            -1.5       75.41        perf-stat.overall.node-load-miss-rate%
     38.01            +0.4       38.42        perf-stat.overall.node-store-miss-rate%
   7.8e+09            +0.8%  7.866e+09        perf-stat.ps.branch-instructions
  47806303 ±  8%     -14.7%   40756219 ±  3%  perf-stat.ps.branch-misses
  44419565 ±  2%     -15.6%   37469682 ±  3%  perf-stat.ps.cache-misses
 1.806e+08 ±  3%     -21.0%  1.426e+08 ±  6%  perf-stat.ps.cache-references
     52651           -15.7%      44379        perf-stat.ps.context-switches
     85475            +0.4%      85829        perf-stat.ps.cpu-clock
 5.687e+10 ±  4%     +12.7%   6.41e+10 ±  2%  perf-stat.ps.cpu-cycles
      2258 ±  8%     -21.2%       1780 ±  3%  perf-stat.ps.cpu-migrations
    958906 ± 25%     +23.4%    1183647 ± 10%  perf-stat.ps.dTLB-load-misses
 1.161e+10            -0.4%  1.156e+10        perf-stat.ps.dTLB-loads
    119447 ± 15%     +14.3%     136547 ±  8%  perf-stat.ps.dTLB-store-misses
 6.289e+09           -13.1%  5.462e+09        perf-stat.ps.dTLB-stores
  25168969 ±  4%     -17.5%   20761854 ±  6%  perf-stat.ps.iTLB-load-misses
   4846973 ±  2%     -22.2%    3771293 ±  6%  perf-stat.ps.iTLB-loads
 4.047e+10            +0.7%  4.077e+10        perf-stat.ps.instructions
     60.98 ± 30%     -37.7%      38.02 ± 38%  perf-stat.ps.major-faults
      8413 ±  2%     -11.8%       7419 ±  2%  perf-stat.ps.minor-faults
   7957212 ±  3%     -15.7%    6704753 ±  3%  perf-stat.ps.node-load-misses
   2392713 ±  3%      -8.7%    2185237        perf-stat.ps.node-loads
   2381437 ±  2%      -6.9%    2216514        perf-stat.ps.node-store-misses
   3884548            -8.5%    3553178        perf-stat.ps.node-stores
      8474 ±  2%     -12.0%       7457 ±  2%  perf-stat.ps.page-faults
     85475            +0.4%      85829        perf-stat.ps.task-clock
  1.41e+12 ±  2%     +17.2%  1.652e+12        perf-stat.total.instructions
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ±100%     +60.4%       0.01 ± 52%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ±200%     -50.0%       0.00 ±300%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.01 ± 54%     -23.1%       0.01 ± 83%  perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.01 ±177%     -43.3%       0.01 ±194%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.04 ±114%     +59.0%       0.06 ±114%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ±200%     +66.7%       0.00 ±167%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.00          +3e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.00 ±160%     -55.6%       0.00 ±300%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.00 ± 27%     +13.6%       0.01 ± 38%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.06 ±150%     -92.6%       0.00 ± 38%  perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.wp_page_copy
      0.00 ±200%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.link_path_walk
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_map
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.00          +3e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mmput.do_exit.do_group_exit
      0.00          +7e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.kernfs_dop_revalidate.lookup_fast
      0.00 ±160%     +11.1%       0.00 ±154%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.task_work_run.do_exit.do_group_exit
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.00          +3e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.unmap_vmas.unmap_region.__do_munmap
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm
      0.00          +1e+98%       0.00 ±300%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      0.73 ±142%     -48.0%       0.38 ±261%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ±  9%      +8.4%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.21 ±193%    +222.0%       0.66 ±222%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00 ±208%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
      0.02 ±153%     -63.2%       0.01 ± 57%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.15 ± 69%     -24.1%       0.11 ± 45%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ±100%     +69.6%       0.01 ± 55%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ±200%     -50.0%       0.00 ±300%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.01 ± 56%     -23.3%       0.01 ± 84%  perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.15 ±249%     -21.2%       0.12 ±221%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.17 ±128%     +77.5%       2.07 ±120%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ±200%     +83.3%       0.00 ±159%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.00          +3e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.00 ±154%     -60.0%       0.00 ±300%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.01 ± 14%     +15.4%       0.01 ± 12%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.23 ±138%     -98.8%       0.02 ±128%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.wp_page_copy
      0.00 ±200%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.link_path_walk
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_map
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.00          +3e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.00          +4e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mmput.do_exit.do_group_exit
      0.00          +7e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.kernfs_dop_revalidate.lookup_fast
      0.00 ±154%     +20.0%       0.00 ±157%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.task_work_run.do_exit.do_group_exit
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.00          +3e+98%       0.00 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.unmap_vmas.unmap_region.__do_munmap
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm
      0.00        +9.2e+99%       0.01 ±300%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.69 ±135%     -50.6%       2.31 ±257%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ±  9%      +8.4%       0.01 ± 10%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.00 ±300%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.91 ±199%     +44.0%       1.31 ±153%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00 ±208%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
      2.31 ±192%     -87.1%       0.30 ±159%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      3.47            -0.3%       3.46        perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.04 ± 64%     -27.1%       0.03 ± 65%  perf-sched.total_sch_delay.average.ms
      7.64 ± 64%     -23.5%       5.85 ± 83%  perf-sched.total_sch_delay.max.ms
      0.91 ± 33%      -7.2%       0.85 ± 33%  perf-sched.total_wait_and_delay.average.ms
    430.80 ± 15%      +0.7%     433.80 ± 13%  perf-sched.total_wait_and_delay.count.ms
     12.85 ± 44%      +3.6%      13.31 ± 34%  perf-sched.total_wait_and_delay.max.ms
      0.88 ± 33%      -6.4%       0.82 ± 34%  perf-sched.total_wait_time.average.ms
     12.84 ± 44%      +2.8%      13.20 ± 34%  perf-sched.total_wait_time.max.ms
      0.84 ±100%     +61.8%       1.37 ± 50%  perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1.30 ± 50%     -22.4%       1.01 ± 82%  perf-sched.wait_and_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.46 ± 26%      +9.0%       0.50 ± 34%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00       +1.8e+101%       0.18 ±210%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.44 ± 11%      +1.0%       0.44 ± 16%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.64 ±300%     -99.9%       0.00 ±300%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.00 ±213%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.00 ± 57%    +918.8%       0.03 ±245%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.61 ± 41%      -1.5%       0.60 ± 44%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          +4e+98%       0.00 ±300%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.link_path_walk
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.00        +4.8e+99%       0.00 ±300%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.seq_open.single_open
      0.00       +1.6e+102%       1.64 ±299%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
      0.01 ±221%  +13688.1%       0.92 ±300%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.swevent_hlist_put_cpu.sw_perf_event_destroy
      0.00 ±300%     +50.0%       0.00 ±300%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.task_work_run.do_exit.do_group_exit
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.00          +3e+98%       0.00 ±300%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.unmap_vmas.unmap_region.__do_munmap
      0.09 ±100%      +7.2%       0.10 ± 78%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      1.95 ± 55%     -35.4%       1.26 ±110%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00 ±122%     -37.1%       0.00 ±200%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      2.53 ± 60%     +18.9%       3.01 ± 38%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
      1.95 ± 41%     -14.6%       1.66 ± 48%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.98 ± 36%     +28.3%       1.26 ± 28%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
      1.00 ±100%     +60.0%       1.60 ± 50%  perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.20 ±200%     -50.0%       0.10 ±300%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      1.60 ± 50%     -25.0%       1.20 ± 81%  perf-sched.wait_and_delay.count.do_syslog.part.0.kmsg_read.vfs_read
     32.30 ± 36%      +9.9%      35.50 ± 28%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00         +6e+101%       0.60 ±133%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
     26.40 ± 47%     +12.9%      29.80 ± 40%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.10 ±300%    +100.0%       0.20 ±300%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.40 ±165%    -100.0%       0.00        perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      1.50 ± 53%     +13.3%       1.70 ± 69%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     27.00 ± 54%      -8.1%      24.80 ± 52%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
      0.10 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.down_read.walk_component.link_path_walk
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.down_write.unlink_file_vma.free_pgtables
      0.10 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.dput.step_into.path_openat
      0.00         +2e+101%       0.20 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.10 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.dput.terminate_walk.path_openat
      0.10 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc.seq_open.single_open
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
      0.50 ±134%     -80.0%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      0.10 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.mutex_lock.swevent_hlist_put_cpu.sw_perf_event_destroy
      0.20 ±300%     +50.0%       0.30 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.10 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.task_work_run.do_exit.do_group_exit
      0.10 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.00         +1e+101%       0.10 ±300%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.unmap_vmas.unmap_region.__do_munmap
    145.70 ± 13%      -2.2%     142.50 ± 15%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      6.50 ± 30%     -27.7%       4.70 ± 88%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.40 ±122%     -50.0%       0.20 ±200%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.20 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      3.50 ± 53%     +11.4%       3.90 ± 40%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.10 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.xfsaild.kthread.ret_from_fork
    146.90 ± 13%      -1.8%     144.30 ± 14%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
     31.40 ± 36%     +20.7%      37.90 ± 35%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      1.68 ±100%     +61.9%       2.73 ± 50%  perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      2.60 ± 50%     -22.4%       2.02 ± 82%  perf-sched.wait_and_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      4.24 ± 40%     -11.0%       3.77 ± 46%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00       +2.4e+101%       0.24 ±191%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      1.64 ± 69%     +50.0%       2.47 ± 88%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.64 ±300%     -99.8%       0.00 ±299%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.00 ±202%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.01 ± 52%   +1154.7%       0.07 ±238%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.40 ± 39%     -24.1%       1.82 ±  5%  perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          +4e+98%       0.00 ±300%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.down_read.walk_component.link_path_walk
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.00        +9.5e+99%       0.01 ±300%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.seq_open.single_open
      0.00       +1.6e+102%       1.64 ±299%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
      0.01 ±253%   +7795.7%       0.92 ±300%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.swevent_hlist_put_cpu.sw_perf_event_destroy
      0.00 ±300%     +66.7%       0.00 ±300%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.task_work_run.do_exit.do_group_exit
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.00          +3e+98%       0.00 ±300%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.unmap_vmas.unmap_region.__do_munmap
      6.70 ± 89%     +17.3%       7.86 ± 63%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      7.91 ± 65%     -16.1%       6.64 ±113%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00 ±122%     -37.1%       0.00 ±200%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      3.69 ± 52%     +19.0%       4.39 ± 28%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00 ±300%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
     11.73 ± 49%      -6.9%      10.91 ± 54%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      5.26 ± 59%     +74.1%       9.16 ± 48%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.84 ±100%     +61.8%       1.36 ± 50%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1.30 ± 50%     -22.4%       1.01 ± 82%  perf-sched.wait_time.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.44 ± 25%     +10.5%       0.49 ± 33%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.07 ±170%    +150.5%       0.18 ±210%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.40 ±  5%      -4.7%       0.38 ±  4%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.64 ±300%     -99.9%       0.00 ±300%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.00         +3e+100%       0.03 ±268%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.55 ± 33%      +8.2%       0.59 ± 44%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.step_into.path_openat
      0.00        +4.8e+99%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.00        +3.9e+99%       0.00 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.seq_open.single_open
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.kernfs_fop_open.do_dentry_open
      0.00       +1.4e+100%       0.01 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.single_open.do_dentry_open
      0.00        +2.8e+99%       0.00 ±299%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.kernfs_iop_permission.inode_permission
      0.02 ±300%  +10448.4%       1.64 ±299%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
      0.03 ±136%   +2641.2%       0.92 ±300%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mutex_lock.swevent_hlist_put_cpu.sw_perf_event_destroy
      0.00 ±299%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm
      0.09 ±100%      +7.1%       0.10 ± 79%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      1.22 ± 41%     -27.9%       0.88 ±108%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      2.32 ± 58%      +0.8%       2.34 ± 50%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      1.92 ± 41%     -14.0%       1.65 ± 48%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.84 ± 52%     +37.6%       1.15 ± 30%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      1.68 ±100%     +61.8%       2.72 ± 50%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      2.60 ± 50%     -22.4%       2.01 ± 82%  perf-sched.wait_time.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      4.24 ± 40%     -11.0%       3.77 ± 46%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.07 ±170%    +232.0%       0.24 ±191%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.83 ± 16%      -4.0%       0.79 ± 11%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.64 ±300%     -99.8%       0.00 ±299%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.00       +6.3e+100%       0.06 ±255%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.82 ±  5%      -0.2%       1.81 ±  5%  perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.step_into.path_openat
      0.00        +9.5e+99%       0.01 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.step_into.walk_component
      0.00        +3.9e+99%       0.00 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc.seq_open.single_open
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.kernfs_fop_open.do_dentry_open
      0.00       +1.4e+100%       0.01 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_trace.single_open.do_dentry_open
      0.00        +2.8e+99%       0.00 ±299%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.kernfs_iop_permission.inode_permission
      0.02 ±300%  +10448.4%       1.64 ±299%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
      0.04 ±129%   +2287.1%       0.92 ±300%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.perf_event_release_kernel.perf_release
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mutex_lock.swevent_hlist_put_cpu.sw_perf_event_destroy
      0.00 ±299%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm
      6.70 ± 89%     +17.3%       7.86 ± 63%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      4.83 ± 65%      +3.4%       4.99 ±121%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      3.68 ± 52%      +5.5%       3.88 ± 46%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.01 ±300%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
     11.66 ± 50%      -6.5%      10.91 ± 54%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      4.12 ± 93%    +116.8%       8.94 ± 52%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
    194155            +0.1%     194273        slabinfo.Acpi-Operand.active_objs
      3467            +0.1%       3469        slabinfo.Acpi-Operand.active_slabs
    194168            +0.1%     194290        slabinfo.Acpi-Operand.num_objs
      3467            +0.1%       3469        slabinfo.Acpi-Operand.num_slabs
      4438            +2.5%       4551        slabinfo.Acpi-Parse.active_objs
     60.40            +2.3%      61.80        slabinfo.Acpi-Parse.active_slabs
      4438            +2.5%       4551        slabinfo.Acpi-Parse.num_objs
     60.40            +2.3%      61.80        slabinfo.Acpi-Parse.num_slabs
      6359 ±  2%      +3.0%       6550        slabinfo.Acpi-State.active_objs
    124.30 ±  2%      +3.0%     128.00        slabinfo.Acpi-State.active_slabs
      6359 ±  2%      +3.0%       6550        slabinfo.Acpi-State.num_objs
    124.30 ±  2%      +3.0%     128.00        slabinfo.Acpi-State.num_slabs
    192.00            +0.0%     192.00        slabinfo.RAW.active_objs
      6.00            +0.0%       6.00        slabinfo.RAW.active_slabs
    192.00            +0.0%     192.00        slabinfo.RAW.num_objs
      6.00            +0.0%       6.00        slabinfo.RAW.num_slabs
    104.00            +0.0%     104.00        slabinfo.RAWv6.active_objs
      4.00            +0.0%       4.00        slabinfo.RAWv6.active_slabs
    104.00            +0.0%     104.00        slabinfo.RAWv6.num_objs
      4.00            +0.0%       4.00        slabinfo.RAWv6.num_slabs
     55.80 ± 10%      +0.4%      56.00        slabinfo.TCP.active_objs
      3.90 ±  7%      +2.6%       4.00        slabinfo.TCP.active_slabs
     55.80 ± 10%      +0.4%      56.00        slabinfo.TCP.num_objs
      3.90 ±  7%      +2.6%       4.00        slabinfo.TCP.num_slabs
     39.00            +0.0%      39.00        slabinfo.TCPv6.active_objs
      3.00            +0.0%       3.00        slabinfo.TCPv6.active_slabs
     39.00            +0.0%      39.00        slabinfo.TCPv6.num_objs
      3.00            +0.0%       3.00        slabinfo.TCPv6.num_slabs
    126.70 ±  8%      -1.5%     124.80 ± 11%  slabinfo.UDPv6.active_objs
      5.20 ±  7%      +0.0%       5.20 ± 11%  slabinfo.UDPv6.active_slabs
    126.70 ±  8%      -1.5%     124.80 ± 11%  slabinfo.UDPv6.num_objs
      5.20 ±  7%      +0.0%       5.20 ± 11%  slabinfo.UDPv6.num_slabs
      2009 ± 11%     -12.1%       1765 ± 16%  slabinfo.UNIX.active_objs
     66.60 ± 11%     -12.2%      58.50 ± 16%  slabinfo.UNIX.active_slabs
      2009 ± 11%     -12.1%       1765 ± 16%  slabinfo.UNIX.num_objs
     66.60 ± 11%     -12.2%      58.50 ± 16%  slabinfo.UNIX.num_slabs
     71425            -0.5%      71046        slabinfo.anon_vma.active_objs
      1552            -0.6%       1544        slabinfo.anon_vma.active_slabs
     71448            -0.5%      71063        slabinfo.anon_vma.num_objs
      1552            -0.6%       1544        slabinfo.anon_vma.num_slabs
    153790            -0.4%     153193 ±  2%  slabinfo.anon_vma_chain.active_objs
      2409            -0.4%       2399 ±  2%  slabinfo.anon_vma_chain.active_slabs
    154252            -0.4%     153577 ±  2%  slabinfo.anon_vma_chain.num_objs
      2409            -0.4%       2399 ±  2%  slabinfo.anon_vma_chain.num_slabs
    168.00 ± 13%      -5.0%     159.60 ±  8%  slabinfo.bdev_cache.active_objs
      8.00 ± 13%      -5.0%       7.60 ±  8%  slabinfo.bdev_cache.active_slabs
    168.00 ± 13%      -5.0%     159.60 ±  8%  slabinfo.bdev_cache.num_objs
      8.00 ± 13%      -5.0%       7.60 ±  8%  slabinfo.bdev_cache.num_slabs
      2087            +6.6%       2225        slabinfo.bfq_io_cq.active_objs
     59.00            +6.6%      62.90        slabinfo.bfq_io_cq.active_slabs
      2087            +6.6%       2225        slabinfo.bfq_io_cq.num_objs
     59.00            +6.6%      62.90        slabinfo.bfq_io_cq.num_slabs
     96.00 ± 32%      -1.1%      94.90 ± 23%  slabinfo.biovec-128.active_objs
      6.00 ± 32%      -1.7%       5.90 ± 23%  slabinfo.biovec-128.active_slabs
     96.00 ± 32%      -1.1%      94.90 ± 23%  slabinfo.biovec-128.num_objs
      6.00 ± 32%      -1.7%       5.90 ± 23%  slabinfo.biovec-128.num_slabs
    300.80 ± 10%      +2.1%     307.20 ±  9%  slabinfo.biovec-64.active_objs
      9.40 ± 10%      +2.1%       9.60 ±  9%  slabinfo.biovec-64.active_slabs
    300.80 ± 10%      +2.1%     307.20 ±  9%  slabinfo.biovec-64.num_objs
      9.40 ± 10%      +2.1%       9.60 ±  9%  slabinfo.biovec-64.num_slabs
    125.20 ±  5%      -0.4%     124.70 ± 11%  slabinfo.biovec-max.active_objs
     15.60 ±  5%      +0.6%      15.70 ± 13%  slabinfo.biovec-max.active_slabs
    127.60 ±  6%      +1.4%     129.40 ± 12%  slabinfo.biovec-max.num_objs
     15.60 ±  5%      +0.6%      15.70 ± 13%  slabinfo.biovec-max.num_slabs
      1.30 ±300%     +92.3%       2.50 ±200%  slabinfo.btrfs_delayed_tree_ref.active_objs
      0.00          -100.0%       0.00        slabinfo.btrfs_delayed_tree_ref.active_slabs
      1.30 ±300%     +92.3%       2.50 ±200%  slabinfo.btrfs_delayed_tree_ref.num_objs
      0.00          -100.0%       0.00        slabinfo.btrfs_delayed_tree_ref.num_slabs
    120.40 ± 14%      -0.9%     119.30 ± 12%  slabinfo.btrfs_extent_map.active_objs
      2.10 ± 14%      -4.8%       2.00        slabinfo.btrfs_extent_map.active_slabs
    120.40 ± 14%      -0.9%     119.30 ± 12%  slabinfo.btrfs_extent_map.num_objs
      2.10 ± 14%      -4.8%       2.00        slabinfo.btrfs_extent_map.num_slabs
     98.90 ± 13%      -5.8%      93.20 ± 16%  slabinfo.btrfs_inode.active_objs
      3.50 ± 14%      -8.6%       3.20 ± 12%  slabinfo.btrfs_inode.active_slabs
     98.90 ± 13%      -5.8%      93.20 ± 16%  slabinfo.btrfs_inode.num_objs
      3.50 ± 14%      -8.6%       3.20 ± 12%  slabinfo.btrfs_inode.num_slabs
      1987 ±  2%      +3.7%       2060 ±  2%  slabinfo.btrfs_ordered_extent.active_objs
     51.90 ±  2%      +3.5%      53.70 ±  2%  slabinfo.btrfs_ordered_extent.active_slabs
      1987 ±  2%      +3.7%       2060 ±  2%  slabinfo.btrfs_ordered_extent.num_objs
     51.90 ±  2%      +3.5%      53.70 ±  2%  slabinfo.btrfs_ordered_extent.num_slabs
    433.50 ± 12%      -8.2%     397.80 ±  9%  slabinfo.buffer_head.active_objs
     10.30 ± 13%      -7.8%       9.50 ±  9%  slabinfo.buffer_head.active_slabs
    433.50 ± 12%      -8.2%     397.80 ±  9%  slabinfo.buffer_head.num_objs
     10.30 ± 13%      -7.8%       9.50 ±  9%  slabinfo.buffer_head.num_slabs
      9366 ±  2%      +0.4%       9405 ±  2%  slabinfo.cred_jar.active_objs
    222.60 ±  2%      +0.5%     223.70 ±  2%  slabinfo.cred_jar.active_slabs
      9366 ±  2%      +0.4%       9405 ±  2%  slabinfo.cred_jar.num_objs
    222.60 ±  2%      +0.5%     223.70 ±  2%  slabinfo.cred_jar.num_slabs
     42.00            +0.0%      42.00        slabinfo.dax_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.dax_cache.active_slabs
     42.00            +0.0%      42.00        slabinfo.dax_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.dax_cache.num_slabs
    152188            +0.8%     153359        slabinfo.dentry.active_objs
      3685            +1.3%       3732        slabinfo.dentry.active_slabs
    154799            +1.3%     156768        slabinfo.dentry.num_objs
      3685            +1.3%       3732        slabinfo.dentry.num_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.active_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.num_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.active_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.num_slabs
     19909 ±  5%      +3.1%      20528 ±  7%  slabinfo.ep_head.active_objs
     77.70 ±  5%      +3.1%      80.10 ±  7%  slabinfo.ep_head.active_slabs
     19909 ±  5%      +3.1%      20528 ±  7%  slabinfo.ep_head.num_objs
     77.70 ±  5%      +3.1%      80.10 ±  7%  slabinfo.ep_head.num_slabs
      1098 ±  7%      -0.3%       1095 ±  6%  slabinfo.file_lock_cache.active_objs
     29.60 ±  7%      +0.0%      29.60 ±  6%  slabinfo.file_lock_cache.active_slabs
      1098 ±  7%      -0.3%       1095 ±  6%  slabinfo.file_lock_cache.num_objs
     29.60 ±  7%      +0.0%      29.60 ±  6%  slabinfo.file_lock_cache.num_slabs
      6790 ±  2%      +0.0%       6792        slabinfo.files_cache.active_objs
    147.10 ±  2%      +0.2%     147.40        slabinfo.files_cache.active_slabs
      6790 ±  2%      +0.0%       6792        slabinfo.files_cache.num_objs
    147.10 ±  2%      +0.2%     147.40        slabinfo.files_cache.num_slabs
     24463 ±  2%      -0.0%      24455 ±  2%  slabinfo.filp.active_objs
    783.40 ±  2%      -0.2%     782.20 ±  3%  slabinfo.filp.active_slabs
     25082 ±  2%      -0.1%      25045 ±  3%  slabinfo.filp.num_objs
    783.40 ±  2%      -0.2%     782.20 ±  3%  slabinfo.filp.num_slabs
      2816 ± 10%      -3.2%       2726 ± 10%  slabinfo.fsnotify_mark_connector.active_objs
     21.90 ±  9%      -2.7%      21.30 ± 10%  slabinfo.fsnotify_mark_connector.active_slabs
      2816 ± 10%      -3.2%       2726 ± 10%  slabinfo.fsnotify_mark_connector.num_objs
     21.90 ±  9%      -2.7%      21.30 ± 10%  slabinfo.fsnotify_mark_connector.num_slabs
     32470            +0.0%      32478        slabinfo.ftrace_event_field.active_objs
    382.00            +0.0%     382.10        slabinfo.ftrace_event_field.active_slabs
     32470            +0.0%      32478        slabinfo.ftrace_event_field.num_objs
    382.00            +0.0%     382.10        slabinfo.ftrace_event_field.num_slabs
    106.00            -5.0%     100.70 ± 15%  slabinfo.hugetlbfs_inode_cache.active_objs
      2.00            -5.0%       1.90 ± 15%  slabinfo.hugetlbfs_inode_cache.active_slabs
    106.00            -5.0%     100.70 ± 15%  slabinfo.hugetlbfs_inode_cache.num_objs
      2.00            -5.0%       1.90 ± 15%  slabinfo.hugetlbfs_inode_cache.num_slabs
     86264            +0.1%      86330        slabinfo.inode_cache.active_objs
      1569            +0.1%       1571        slabinfo.inode_cache.active_slabs
     86338            +0.1%      86428        slabinfo.inode_cache.num_objs
      1569            +0.1%       1571        slabinfo.inode_cache.num_slabs
      2638            +6.5%       2809        slabinfo.ip6-frags.active_objs
     59.70            +6.0%      63.30        slabinfo.ip6-frags.active_slabs
      2638            +6.5%       2809        slabinfo.ip6-frags.num_objs
     59.70            +6.0%      63.30        slabinfo.ip6-frags.num_slabs
     82327            -0.1%      82266        slabinfo.kernfs_node_cache.active_objs
      2572            -0.1%       2570        slabinfo.kernfs_node_cache.active_slabs
     82327            -0.1%      82266        slabinfo.kernfs_node_cache.num_objs
      2572            -0.1%       2570        slabinfo.kernfs_node_cache.num_slabs
      1699 ± 12%      -2.0%       1665 ±  9%  slabinfo.khugepaged_mm_slot.active_objs
     46.50 ± 12%      -2.2%      45.50 ±  9%  slabinfo.khugepaged_mm_slot.active_slabs
      1699 ± 12%      -2.0%       1665 ±  9%  slabinfo.khugepaged_mm_slot.num_objs
     46.50 ± 12%      -2.2%      45.50 ±  9%  slabinfo.khugepaged_mm_slot.num_slabs
      5191            +0.4%       5212        slabinfo.kmalloc-128.active_objs
    161.90            +0.4%     162.50        slabinfo.kmalloc-128.active_slabs
      5197            +0.4%       5220        slabinfo.kmalloc-128.num_objs
    161.90            +0.4%     162.50        slabinfo.kmalloc-128.num_slabs
     33313            +1.1%      33681        slabinfo.kmalloc-16.active_objs
    130.10            +0.8%     131.20        slabinfo.kmalloc-16.active_slabs
     33319            +1.1%      33700        slabinfo.kmalloc-16.num_objs
    130.10            +0.8%     131.20        slabinfo.kmalloc-16.num_slabs
      5694            -0.1%       5691        slabinfo.kmalloc-192.active_objs
    137.00            -0.4%     136.40        slabinfo.kmalloc-192.active_slabs
      5773            -0.4%       5753        slabinfo.kmalloc-192.num_objs
    137.00            -0.4%     136.40        slabinfo.kmalloc-192.num_slabs
      5100            +3.4%       5274        slabinfo.kmalloc-1k.active_objs
    159.50            +3.3%     164.80        slabinfo.kmalloc-1k.active_slabs
      5115            +3.4%       5286        slabinfo.kmalloc-1k.num_objs
    159.50            +3.3%     164.80        slabinfo.kmalloc-1k.num_slabs
      9820 ±  4%      +0.7%       9889 ±  3%  slabinfo.kmalloc-256.active_objs
    306.50 ±  4%      +0.7%     308.60 ±  3%  slabinfo.kmalloc-256.active_slabs
      9821 ±  4%      +0.7%       9889 ±  3%  slabinfo.kmalloc-256.num_objs
    306.50 ±  4%      +0.7%     308.60 ±  3%  slabinfo.kmalloc-256.num_slabs
      4720 ±  3%      -2.1%       4622 ±  5%  slabinfo.kmalloc-2k.active_objs
    296.80 ±  3%      -2.2%     290.20 ±  5%  slabinfo.kmalloc-2k.active_slabs
      4756 ±  3%      -2.3%       4648 ±  5%  slabinfo.kmalloc-2k.num_objs
    296.80 ±  3%      -2.2%     290.20 ±  5%  slabinfo.kmalloc-2k.num_slabs
     77088            -0.2%      76965        slabinfo.kmalloc-32.active_objs
    602.50            -0.0%     602.40        slabinfo.kmalloc-32.active_slabs
     77187            -0.0%      77163        slabinfo.kmalloc-32.num_objs
    602.50            -0.0%     602.40        slabinfo.kmalloc-32.num_slabs
      1883           +19.4%       2248 ±  2%  slabinfo.kmalloc-4k.active_objs
    236.90           +19.7%     283.60 ±  3%  slabinfo.kmalloc-4k.active_slabs
      1898           +19.7%       2273 ±  2%  slabinfo.kmalloc-4k.num_objs
    236.90           +19.7%     283.60 ±  3%  slabinfo.kmalloc-4k.num_slabs
     21978           +10.6%      24315        slabinfo.kmalloc-512.active_objs
    714.90 ±  2%     +14.5%     818.80        slabinfo.kmalloc-512.active_slabs
     22890 ±  2%     +14.6%      26221        slabinfo.kmalloc-512.num_objs
    714.90 ±  2%     +14.5%     818.80        slabinfo.kmalloc-512.num_slabs
     51949            -0.2%      51856        slabinfo.kmalloc-64.active_objs
    814.40            -0.2%     813.00        slabinfo.kmalloc-64.active_slabs
     52139            -0.1%      52068        slabinfo.kmalloc-64.num_objs
    814.40            -0.2%     813.00        slabinfo.kmalloc-64.num_slabs
     51880            +0.4%      52062        slabinfo.kmalloc-8.active_objs
    102.80            +0.5%     103.30        slabinfo.kmalloc-8.active_slabs
     53005            +0.4%      53198        slabinfo.kmalloc-8.num_objs
    102.80            +0.5%     103.30        slabinfo.kmalloc-8.num_slabs
    948.10            +9.8%       1040        slabinfo.kmalloc-8k.active_objs
    238.70           +10.5%     263.70        slabinfo.kmalloc-8k.active_slabs
    956.60           +10.5%       1057        slabinfo.kmalloc-8k.num_objs
    238.70           +10.5%     263.70        slabinfo.kmalloc-8k.num_slabs
      7539 ±  2%      -3.0%       7316 ±  3%  slabinfo.kmalloc-96.active_objs
    181.60 ±  2%      -3.5%     175.20 ±  3%  slabinfo.kmalloc-96.active_slabs
      7642 ±  2%      -3.5%       7378 ±  3%  slabinfo.kmalloc-96.num_objs
    181.60 ±  2%      -3.5%     175.20 ±  3%  slabinfo.kmalloc-96.num_slabs
    328.80 ± 56%     -22.0%     256.60        slabinfo.kmalloc-cg-16.active_objs
      1.20 ± 50%     -16.7%       1.00        slabinfo.kmalloc-cg-16.active_slabs
    328.80 ± 56%     -22.0%     256.60        slabinfo.kmalloc-cg-16.num_objs
      1.20 ± 50%     -16.7%       1.00        slabinfo.kmalloc-cg-16.num_slabs
      3270 ±  5%      +0.2%       3276 ±  4%  slabinfo.kmalloc-cg-192.active_objs
     77.40 ±  5%      +0.0%      77.40 ±  4%  slabinfo.kmalloc-cg-192.active_slabs
      3270 ±  5%      +0.2%       3276 ±  4%  slabinfo.kmalloc-cg-192.num_objs
     77.40 ±  5%      +0.0%      77.40 ±  4%  slabinfo.kmalloc-cg-192.num_slabs
      2911 ±  4%      +3.5%       3011 ±  3%  slabinfo.kmalloc-cg-1k.active_objs
     90.60 ±  4%      +3.3%      93.60 ±  3%  slabinfo.kmalloc-cg-1k.active_slabs
      2911 ±  4%      +3.5%       3011 ±  3%  slabinfo.kmalloc-cg-1k.num_objs
     90.60 ±  4%      +3.3%      93.60 ±  3%  slabinfo.kmalloc-cg-1k.num_slabs
    525.70 ± 11%      -8.9%     478.70 ± 11%  slabinfo.kmalloc-cg-256.active_objs
     16.10 ± 10%      -9.3%      14.60 ± 12%  slabinfo.kmalloc-cg-256.active_slabs
    525.70 ± 11%      -8.9%     478.70 ± 11%  slabinfo.kmalloc-cg-256.num_objs
     16.10 ± 10%      -9.3%      14.60 ± 12%  slabinfo.kmalloc-cg-256.num_slabs
    254.50 ± 17%      -1.6%     250.40 ±  8%  slabinfo.kmalloc-cg-2k.active_objs
     15.60 ± 17%      -2.6%      15.20 ±  8%  slabinfo.kmalloc-cg-2k.active_slabs
    254.50 ± 17%      -1.6%     250.40 ±  8%  slabinfo.kmalloc-cg-2k.num_objs
     15.60 ± 17%      -2.6%      15.20 ±  8%  slabinfo.kmalloc-cg-2k.num_slabs
     10628 ±  3%      -4.0%      10203 ±  5%  slabinfo.kmalloc-cg-32.active_objs
     82.70 ±  2%      -4.0%      79.40 ±  5%  slabinfo.kmalloc-cg-32.active_slabs
     10628 ±  3%      -4.0%      10203 ±  5%  slabinfo.kmalloc-cg-32.num_objs
     82.70 ±  2%      -4.0%      79.40 ±  5%  slabinfo.kmalloc-cg-32.num_slabs
    704.00            +0.0%     704.00        slabinfo.kmalloc-cg-4k.active_objs
     88.00            +0.0%      88.00        slabinfo.kmalloc-cg-4k.active_slabs
    704.00            +0.0%     704.00        slabinfo.kmalloc-cg-4k.num_objs
     88.00            +0.0%      88.00        slabinfo.kmalloc-cg-4k.num_slabs
      2810            +0.2%       2816        slabinfo.kmalloc-cg-512.active_objs
     87.80            +0.2%      88.00        slabinfo.kmalloc-cg-512.active_slabs
      2810            +0.2%       2816        slabinfo.kmalloc-cg-512.num_objs
     87.80            +0.2%      88.00        slabinfo.kmalloc-cg-512.num_slabs
      1672 ±  7%      -6.4%       1565 ±  6%  slabinfo.kmalloc-cg-64.active_objs
     25.40 ±  7%      -6.7%      23.70 ±  6%  slabinfo.kmalloc-cg-64.active_slabs
      1672 ±  7%      -6.4%       1565 ±  6%  slabinfo.kmalloc-cg-64.num_objs
     25.40 ±  7%      -6.7%      23.70 ±  6%  slabinfo.kmalloc-cg-64.num_slabs
     47961            +0.1%      48010        slabinfo.kmalloc-cg-8.active_objs
     93.00            +0.0%      93.00        slabinfo.kmalloc-cg-8.active_slabs
     47961            +0.1%      48010        slabinfo.kmalloc-cg-8.num_objs
     93.00            +0.0%      93.00        slabinfo.kmalloc-cg-8.num_slabs
     33.00 ±  8%      +4.8%      34.60 ±  3%  slabinfo.kmalloc-cg-8k.active_objs
      7.50 ±  8%      +5.3%       7.90 ±  3%  slabinfo.kmalloc-cg-8k.active_slabs
     33.00 ±  8%      +4.8%      34.60 ±  3%  slabinfo.kmalloc-cg-8k.num_objs
      7.50 ±  8%      +5.3%       7.90 ±  3%  slabinfo.kmalloc-cg-8k.num_slabs
    336.50 ±  8%      +4.3%     351.10 ±  5%  slabinfo.kmalloc-cg-96.active_objs
      7.20 ± 10%      +4.2%       7.50 ±  6%  slabinfo.kmalloc-cg-96.active_slabs
    336.50 ±  8%      +4.3%     351.10 ±  5%  slabinfo.kmalloc-cg-96.num_objs
      7.20 ± 10%      +4.2%       7.50 ±  6%  slabinfo.kmalloc-cg-96.num_slabs
    572.80 ± 12%      +5.0%     601.60 ± 14%  slabinfo.kmalloc-rcl-128.active_objs
     17.90 ± 12%      +5.0%      18.80 ± 14%  slabinfo.kmalloc-rcl-128.active_slabs
    572.80 ± 12%      +5.0%     601.60 ± 14%  slabinfo.kmalloc-rcl-128.num_objs
     17.90 ± 12%      +5.0%      18.80 ± 14%  slabinfo.kmalloc-rcl-128.num_slabs
     42.00            +0.0%      42.00        slabinfo.kmalloc-rcl-192.active_objs
      1.00            +0.0%       1.00        slabinfo.kmalloc-rcl-192.active_slabs
     42.00            +0.0%      42.00        slabinfo.kmalloc-rcl-192.num_objs
      1.00            +0.0%       1.00        slabinfo.kmalloc-rcl-192.num_slabs
      7563 ±  3%      -4.0%       7261 ±  5%  slabinfo.kmalloc-rcl-64.active_objs
    117.80 ±  3%      -4.1%     113.00 ±  5%  slabinfo.kmalloc-rcl-64.active_slabs
      7563 ±  3%      -4.0%       7261 ±  5%  slabinfo.kmalloc-rcl-64.num_objs
    117.80 ±  3%      -4.1%     113.00 ±  5%  slabinfo.kmalloc-rcl-64.num_slabs
      2755 ±  6%      +0.5%       2767 ±  6%  slabinfo.kmalloc-rcl-96.active_objs
     65.60 ±  6%      +0.5%      65.90 ±  6%  slabinfo.kmalloc-rcl-96.active_slabs
      2755 ±  6%      +0.5%       2767 ±  6%  slabinfo.kmalloc-rcl-96.num_objs
     65.60 ±  6%      +0.5%      65.90 ±  6%  slabinfo.kmalloc-rcl-96.num_slabs
    470.40 ±  8%      -4.1%     451.20 ±  8%  slabinfo.kmem_cache.active_objs
     14.70 ±  8%      -4.1%      14.10 ±  8%  slabinfo.kmem_cache.active_slabs
    470.40 ±  8%      -4.1%     451.20 ±  8%  slabinfo.kmem_cache.num_objs
     14.70 ±  8%      -4.1%      14.10 ±  8%  slabinfo.kmem_cache.num_slabs
    966.20 ±  8%      -2.6%     940.60 ±  7%  slabinfo.kmem_cache_node.active_objs
     15.30 ±  8%      -2.6%      14.90 ±  7%  slabinfo.kmem_cache_node.active_slabs
    979.20 ±  8%      -2.6%     953.60 ±  7%  slabinfo.kmem_cache_node.num_objs
     15.30 ±  8%      -2.6%      14.90 ±  7%  slabinfo.kmem_cache_node.num_slabs
     17207            +1.8%      17523        slabinfo.lsm_file_cache.active_objs
    100.80            +1.9%     102.70        slabinfo.lsm_file_cache.active_slabs
     17207            +1.8%      17523        slabinfo.lsm_file_cache.num_objs
    100.80            +1.9%     102.70        slabinfo.lsm_file_cache.num_slabs
      5639            -0.5%       5611        slabinfo.mm_struct.active_objs
    187.50            -0.4%     186.70        slabinfo.mm_struct.active_slabs
      5639            -0.5%       5611        slabinfo.mm_struct.num_objs
    187.50            -0.4%     186.70        slabinfo.mm_struct.num_slabs
      1191 ±  7%      -0.7%       1183 ±  8%  slabinfo.mnt_cache.active_objs
     22.50 ±  7%      +0.4%      22.60 ±  8%  slabinfo.mnt_cache.active_slabs
      1191 ±  7%      -0.7%       1183 ±  8%  slabinfo.mnt_cache.num_objs
     22.50 ±  7%      +0.4%      22.60 ±  8%  slabinfo.mnt_cache.num_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.active_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.num_slabs
      2578            +5.9%       2731        slabinfo.names_cache.active_objs
    324.90            +5.9%     344.10        slabinfo.names_cache.active_slabs
      2603            +5.9%       2756        slabinfo.names_cache.num_objs
    324.90            +5.9%     344.10        slabinfo.names_cache.num_slabs
     34.00            +0.0%      34.00        slabinfo.nfs_read_data.active_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.active_slabs
     34.00            +0.0%      34.00        slabinfo.nfs_read_data.num_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.num_slabs
      3764            +5.7%       3979        slabinfo.numa_policy.active_objs
     60.30            +5.8%      63.80        slabinfo.numa_policy.active_slabs
      3764            +5.7%       3979        slabinfo.numa_policy.num_objs
     60.30            +5.8%      63.80        slabinfo.numa_policy.num_slabs
      8368 ±  2%      -2.0%       8204 ±  4%  slabinfo.pde_opener.active_objs
     81.70 ±  2%      -2.3%      79.80 ±  4%  slabinfo.pde_opener.active_slabs
      8368 ±  2%      -2.0%       8204 ±  4%  slabinfo.pde_opener.num_objs
     81.70 ±  2%      -2.3%      79.80 ±  4%  slabinfo.pde_opener.num_slabs
      3812            +0.3%       3823        slabinfo.perf_event.active_objs
    141.80            +0.1%     142.00        slabinfo.perf_event.active_slabs
      3833            +0.3%       3844        slabinfo.perf_event.num_objs
    141.80            +0.1%     142.00        slabinfo.perf_event.num_slabs
      7409            +1.0%       7482        slabinfo.pid.active_objs
    231.10            +1.0%     233.30        slabinfo.pid.active_slabs
      7409            +1.0%       7482        slabinfo.pid.num_objs
    231.10            +1.0%     233.30        slabinfo.pid.num_slabs
      1666 ±  7%      -8.0%       1532 ±  7%  slabinfo.pool_workqueue.active_objs
     52.20 ±  7%      -7.5%      48.30 ±  7%  slabinfo.pool_workqueue.active_slabs
      1681 ±  6%      -7.3%       1559 ±  7%  slabinfo.pool_workqueue.num_objs
     52.20 ±  7%      -7.5%      48.30 ±  7%  slabinfo.pool_workqueue.num_slabs
      2746 ±  2%      +0.5%       2759        slabinfo.proc_dir_entry.active_objs
     65.40 ±  2%      +0.5%      65.70        slabinfo.proc_dir_entry.active_slabs
      2746 ±  2%      +0.5%       2759        slabinfo.proc_dir_entry.num_objs
     65.40 ±  2%      +0.5%      65.70        slabinfo.proc_dir_entry.num_slabs
     33773            +6.5%      35963        slabinfo.proc_inode_cache.active_objs
    699.30            +6.0%     741.50        slabinfo.proc_inode_cache.active_slabs
     34297            +6.0%      36349        slabinfo.proc_inode_cache.num_objs
    699.30            +6.0%     741.50        slabinfo.proc_inode_cache.num_slabs
     39490 ±  2%     +12.0%      44234        slabinfo.radix_tree_node.active_objs
    705.90 ±  2%     +11.9%     790.10        slabinfo.radix_tree_node.active_slabs
     39559 ±  2%     +11.9%      44271        slabinfo.radix_tree_node.num_objs
    705.90 ±  2%     +11.9%     790.10        slabinfo.radix_tree_node.num_slabs
     60.00            -2.5%      58.50 ±  7%  slabinfo.request_queue.active_objs
      4.00            -2.5%       3.90 ±  7%  slabinfo.request_queue.active_slabs
     60.00            -2.5%      58.50 ±  7%  slabinfo.request_queue.num_objs
      4.00            -2.5%       3.90 ±  7%  slabinfo.request_queue.num_slabs
      4.30 ±300%    -100.0%       0.00        slabinfo.request_sock_TCP.active_objs
      0.00          -100.0%       0.00        slabinfo.request_sock_TCP.active_slabs
      4.30 ±300%    -100.0%       0.00        slabinfo.request_sock_TCP.num_objs
      0.00          -100.0%       0.00        slabinfo.request_sock_TCP.num_slabs
     51.00            +0.0%      51.00        slabinfo.rpc_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.active_slabs
     51.00            +0.0%      51.00        slabinfo.rpc_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.num_slabs
    636.80            +0.0%     636.80        slabinfo.scsi_sense_cache.active_objs
     19.90            +0.0%      19.90        slabinfo.scsi_sense_cache.active_slabs
    636.80            +0.0%     636.80        slabinfo.scsi_sense_cache.num_objs
     19.90            +0.0%      19.90        slabinfo.scsi_sense_cache.num_slabs
      2992            +0.0%       2992        slabinfo.seq_file.active_objs
     88.00            +0.0%      88.00        slabinfo.seq_file.active_slabs
      2992            +0.0%       2992        slabinfo.seq_file.num_objs
     88.00            +0.0%      88.00        slabinfo.seq_file.num_slabs
      4794 ±  2%      -5.5%       4529 ±  4%  slabinfo.shmem_inode_cache.active_objs
    103.90 ±  2%      -5.8%      97.90 ±  4%  slabinfo.shmem_inode_cache.active_slabs
      4794 ±  2%      -5.5%       4529 ±  4%  slabinfo.shmem_inode_cache.num_objs
    103.90 ±  2%      -5.8%      97.90 ±  4%  slabinfo.shmem_inode_cache.num_slabs
      4903            +0.9%       4950        slabinfo.sighand_cache.active_objs
    328.30            +0.7%     330.70        slabinfo.sighand_cache.active_slabs
      4932            +0.7%       4966        slabinfo.sighand_cache.num_objs
    328.30            +0.7%     330.70        slabinfo.sighand_cache.num_slabs
      7039            +1.8%       7163 ±  2%  slabinfo.signal_cache.active_objs
    252.80            +1.3%     256.00 ±  2%  slabinfo.signal_cache.active_slabs
      7090            +1.2%       7178 ±  2%  slabinfo.signal_cache.num_objs
    252.80            +1.3%     256.00 ±  2%  slabinfo.signal_cache.num_slabs
      4305 ±  8%      -6.9%       4006 ±  9%  slabinfo.skbuff_ext_cache.active_objs
    102.00 ±  8%      -6.7%      95.20 ±  8%  slabinfo.skbuff_ext_cache.active_slabs
      4305 ±  8%      -6.6%       4019 ±  8%  slabinfo.skbuff_ext_cache.num_objs
    102.00 ±  8%      -6.7%      95.20 ±  8%  slabinfo.skbuff_ext_cache.num_slabs
    270.90 ± 14%     -13.8%     233.60 ±  6%  slabinfo.skbuff_fclone_cache.active_objs
      8.40 ± 13%     -13.1%       7.30 ±  6%  slabinfo.skbuff_fclone_cache.active_slabs
    270.90 ± 14%     -13.8%     233.60 ±  6%  slabinfo.skbuff_fclone_cache.num_objs
      8.40 ± 13%     -13.1%       7.30 ±  6%  slabinfo.skbuff_fclone_cache.num_slabs
      3836 ±  8%      -3.1%       3718 ±  6%  slabinfo.skbuff_head_cache.active_objs
    120.10 ±  8%      -2.8%     116.70 ±  6%  slabinfo.skbuff_head_cache.active_slabs
      3843 ±  8%      -2.8%       3734 ±  6%  slabinfo.skbuff_head_cache.num_objs
    120.10 ±  8%      -2.8%     116.70 ±  6%  slabinfo.skbuff_head_cache.num_slabs
      3298 ±  9%     -12.1%       2901 ± 12%  slabinfo.sock_inode_cache.active_objs
     84.30 ±  9%     -12.2%      74.00 ± 12%  slabinfo.sock_inode_cache.active_slabs
      3298 ±  9%     -12.1%       2901 ± 12%  slabinfo.sock_inode_cache.num_objs
     84.30 ±  9%     -12.2%      74.00 ± 12%  slabinfo.sock_inode_cache.num_slabs
      1335 ±  8%      -4.2%       1280 ± 11%  slabinfo.task_delay_info.active_objs
     26.10 ±  8%      -3.8%      25.10 ± 11%  slabinfo.task_delay_info.active_slabs
      1335 ±  8%      -4.2%       1280 ± 11%  slabinfo.task_delay_info.num_objs
     26.10 ±  8%      -3.8%      25.10 ± 11%  slabinfo.task_delay_info.num_slabs
      1379 ±  6%      -6.0%       1296 ±  8%  slabinfo.task_group.active_objs
     29.60 ±  7%      -6.4%      27.70 ±  8%  slabinfo.task_group.active_slabs
      1379 ±  6%      -6.0%       1296 ±  8%  slabinfo.task_group.num_objs
     29.60 ±  7%      -6.4%      27.70 ±  8%  slabinfo.task_group.num_slabs
      3920            +1.7%       3987        slabinfo.task_struct.active_objs
      3926            +1.7%       3993        slabinfo.task_struct.active_slabs
      3926            +1.7%       3993        slabinfo.task_struct.num_objs
      3926            +1.7%       3993        slabinfo.task_struct.num_slabs
    293.80 ± 12%      -5.1%     278.80 ±  9%  slabinfo.taskstats.active_objs
      6.10 ± 15%      -4.9%       5.80 ± 10%  slabinfo.taskstats.active_slabs
    293.80 ± 12%      -5.1%     278.80 ±  9%  slabinfo.taskstats.num_objs
      6.10 ± 15%      -4.9%       5.80 ± 10%  slabinfo.taskstats.num_slabs
      4031 ±  3%      -1.8%       3959        slabinfo.trace_event_file.active_objs
     87.10 ±  3%      -1.6%      85.70        slabinfo.trace_event_file.active_slabs
      4031 ±  3%      -1.8%       3959        slabinfo.trace_event_file.num_objs
     87.10 ±  3%      -1.6%      85.70        slabinfo.trace_event_file.num_slabs
     33.00            +0.0%      33.00        slabinfo.tw_sock_TCP.active_objs
      1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.active_slabs
     33.00            +0.0%      33.00        slabinfo.tw_sock_TCP.num_objs
      1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.num_slabs
    148188            +0.1%     148279        slabinfo.vm_area_struct.active_objs
      3717            +0.0%       3718        slabinfo.vm_area_struct.active_slabs
    148730            +0.0%     148759        slabinfo.vm_area_struct.num_objs
      3717            +0.0%       3718        slabinfo.vm_area_struct.num_slabs
     17542 ±  3%      +1.2%      17756 ±  2%  slabinfo.vmap_area.active_objs
    275.70 ±  2%      +1.2%     278.90        slabinfo.vmap_area.active_slabs
     17674 ±  2%      +1.1%      17872        slabinfo.vmap_area.num_objs
    275.70 ±  2%      +1.2%     278.90        slabinfo.vmap_area.num_slabs
     42.00            +0.0%      42.00        slabinfo.xfrm_state.active_objs
      1.00            +0.0%       1.00        slabinfo.xfrm_state.active_slabs
     42.00            +0.0%      42.00        slabinfo.xfrm_state.num_objs
      1.00            +0.0%       1.00        slabinfo.xfrm_state.num_slabs
      2170            +6.2%       2306        slabinfo.xfs_btree_cur.active_objs
     59.90            +6.5%      63.80        slabinfo.xfs_btree_cur.active_slabs
      2170            +6.2%       2306        slabinfo.xfs_btree_cur.num_objs
     59.90            +6.5%      63.80        slabinfo.xfs_btree_cur.num_slabs
      2374 ±  2%      +7.3%       2548        slabinfo.xfs_buf.active_objs
     55.90 ±  2%      +7.9%      60.30        slabinfo.xfs_buf.active_slabs
      2374 ±  2%      +7.3%       2548        slabinfo.xfs_buf.num_objs
     55.90 ±  2%      +7.9%      60.30        slabinfo.xfs_buf.num_slabs
      1993            +7.1%       2134        slabinfo.xfs_da_state.active_objs
     58.00            +6.9%      62.00        slabinfo.xfs_da_state.active_slabs
      1993            +7.1%       2134        slabinfo.xfs_da_state.num_objs
     58.00            +6.9%      62.00        slabinfo.xfs_da_state.num_slabs
      1934 ±  2%      +3.7%       2006 ±  2%  slabinfo.xfs_efd_item.active_objs
     51.90 ±  2%      +3.5%      53.70 ±  2%  slabinfo.xfs_efd_item.active_slabs
      1934 ±  2%      +3.7%       2006 ±  2%  slabinfo.xfs_efd_item.num_objs
     51.90 ±  2%      +3.5%      53.70 ±  2%  slabinfo.xfs_efd_item.num_slabs
      2119 ±  4%      -3.0%       2056 ±  6%  slabinfo.xfs_icr.active_objs
     45.70 ±  5%      -3.1%      44.30 ±  6%  slabinfo.xfs_icr.active_slabs
      2119 ±  4%      -3.0%       2056 ±  6%  slabinfo.xfs_icr.num_objs
     45.70 ±  5%      -3.1%      44.30 ±  6%  slabinfo.xfs_icr.num_slabs
      3057 ± 12%     +41.6%       4328 ±  8%  slabinfo.xfs_ili.active_objs
     73.60 ± 14%     +43.8%     105.80 ± 10%  slabinfo.xfs_ili.active_slabs
      3111 ± 14%     +43.3%       4460 ± 10%  slabinfo.xfs_ili.num_objs
     73.60 ± 14%     +43.8%     105.80 ± 10%  slabinfo.xfs_ili.num_slabs
      2775 ±  8%     +44.6%       4014 ±  7%  slabinfo.xfs_inode.active_objs
     84.60 ±  8%     +40.5%     118.90 ±  8%  slabinfo.xfs_inode.active_slabs
      2893 ±  8%     +40.2%       4056 ±  8%  slabinfo.xfs_inode.num_objs
     84.60 ±  8%     +40.5%     118.90 ±  8%  slabinfo.xfs_inode.num_slabs
    420.60            +0.2%     421.60        softirqs.BLOCK
      8.50 ±118%     +50.6%      12.80 ± 72%  softirqs.CPU0.BLOCK
      1.00            +0.0%       1.00        softirqs.CPU0.HI
     47.10 ±297%     -98.3%       0.80 ±156%  softirqs.CPU0.NET_RX
      0.20 ±200%   +1050.0%       2.30 ±144%  softirqs.CPU0.NET_TX
      8400 ±  7%      +5.3%       8847 ± 15%  softirqs.CPU0.RCU
     10641 ±  9%      -0.9%      10549 ± 10%  softirqs.CPU0.SCHED
    105.00            +0.3%     105.30        softirqs.CPU0.TASKLET
    625.50 ± 61%      -4.2%     599.40 ± 42%  softirqs.CPU0.TIMER
      6.70 ±120%     -61.2%       2.60 ±160%  softirqs.CPU1.BLOCK
    158.60 ±251%     -98.4%       2.50 ±176%  softirqs.CPU1.NET_RX
      0.20 ±200%      +0.0%       0.20 ±200%  softirqs.CPU1.NET_TX
      7233 ± 10%     +10.8%       8011 ± 11%  softirqs.CPU1.RCU
      8560 ± 13%     +10.9%       9493 ±  7%  softirqs.CPU1.SCHED
      0.10 ±300%   +2400.0%       2.50 ±273%  softirqs.CPU1.TASKLET
    185.20 ±106%     +45.6%     269.70 ±109%  softirqs.CPU1.TIMER
      0.80 ±300%    -100.0%       0.00        softirqs.CPU10.BLOCK
      1.40 ± 34%     -14.3%       1.20 ± 33%  softirqs.CPU10.HI
    163.70 ±244%     -95.8%       6.80 ±270%  softirqs.CPU10.NET_RX
      0.30 ±213%     -66.7%       0.10 ±300%  softirqs.CPU10.NET_TX
      6078 ±  9%      +8.4%       6586 ±  5%  softirqs.CPU10.RCU
      6772 ±  3%      +7.2%       7259 ±  2%  softirqs.CPU10.SCHED
     40.40 ± 25%      -9.9%      36.40        softirqs.CPU10.TASKLET
     65.40 ± 21%    +136.5%     154.70 ± 90%  softirqs.CPU10.TIMER
      5.30 ±200%     -50.9%       2.60 ±200%  softirqs.CPU11.BLOCK
      3.40 ±158%     +55.9%       5.30 ±226%  softirqs.CPU11.NET_RX
      0.20 ±200%    +250.0%       0.70 ± 91%  softirqs.CPU11.NET_TX
      5966 ±  4%     +11.5%       6651 ±  5%  softirqs.CPU11.RCU
      6708 ±  3%      +4.8%       7029 ±  4%  softirqs.CPU11.SCHED
      2.30 ±244%     -91.3%       0.20 ±300%  softirqs.CPU11.TASKLET
     75.70 ± 28%      +8.1%      81.80 ± 23%  softirqs.CPU11.TIMER
      4.00 ±196%      -5.0%       3.80 ±160%  softirqs.CPU12.BLOCK
      0.80 ±156%      +0.0%       0.80 ±145%  softirqs.CPU12.NET_RX
      0.30 ±213%     -33.3%       0.20 ±200%  softirqs.CPU12.NET_TX
      6099 ±  5%      +9.8%       6696 ±  5%  softirqs.CPU12.RCU
      6823 ±  5%      +4.3%       7118 ±  5%  softirqs.CPU12.SCHED
      0.40 ±200%     -50.0%       0.20 ±300%  softirqs.CPU12.TASKLET
     71.10 ± 19%     +65.7%     117.80 ± 95%  softirqs.CPU12.TIMER
      1.60 ±300%     -87.5%       0.20 ±300%  softirqs.CPU13.BLOCK
     16.40 ±291%     -95.7%       0.70 ±212%  softirqs.CPU13.NET_RX
      0.10 ±300%      +0.0%       0.10 ±300%  softirqs.CPU13.NET_TX
      6046 ±  5%      +8.7%       6570 ±  6%  softirqs.CPU13.RCU
      6889 ±  4%      +2.7%       7076 ±  7%  softirqs.CPU13.SCHED
      2.50 ± 48%     -20.0%       2.00        softirqs.CPU13.TASKLET
    149.50 ±164%      -5.2%     141.70 ± 75%  softirqs.CPU13.TIMER
      0.10 ±300%   +1500.0%       1.60 ±300%  softirqs.CPU14.BLOCK
      9.20 ±250%     +16.3%      10.70 ±242%  softirqs.CPU14.NET_RX
      0.20 ±200%     -50.0%       0.10 ±300%  softirqs.CPU14.NET_TX
      6095 ± 10%     +12.6%       6863 ± 13%  softirqs.CPU14.RCU
      6738 ±  3%      +8.2%       7289 ±  6%  softirqs.CPU14.SCHED
      2.00            +0.0%       2.00        softirqs.CPU14.TASKLET
    104.60 ± 47%    +135.4%     246.20 ±121%  softirqs.CPU14.TIMER
      1.30 ±275%    -100.0%       0.00        softirqs.CPU15.BLOCK
     27.70 ±203%     -95.3%       1.30 ±175%  softirqs.CPU15.NET_RX
      0.00       +1.5e+102%       1.50 ±171%  softirqs.CPU15.NET_TX
      6318 ±  7%     +14.9%       7261 ± 25%  softirqs.CPU15.RCU
      6949 ±  6%      +5.5%       7333 ±  3%  softirqs.CPU15.SCHED
      2.60 ±103%      +7.7%       2.80 ±111%  softirqs.CPU15.TASKLET
    301.00 ±200%     -15.4%     254.70 ±196%  softirqs.CPU15.TIMER
      3.60 ±300%     -50.0%       1.80 ±213%  softirqs.CPU16.BLOCK
      4.70 ±272%     -95.7%       0.20 ±200%  softirqs.CPU16.NET_RX
      0.20 ±200%      +0.0%       0.20 ±300%  softirqs.CPU16.NET_TX
      6325 ±  9%      +8.0%       6831 ±  7%  softirqs.CPU16.RCU
      6856 ±  3%      +2.0%       6994 ±  5%  softirqs.CPU16.SCHED
      1.60 ± 50%    +225.0%       5.20 ±184%  softirqs.CPU16.TASKLET
     97.80 ± 87%     +22.6%     119.90 ± 66%  softirqs.CPU16.TIMER
     15.70 ±273%     +27.4%      20.00 ±268%  softirqs.CPU17.BLOCK
      8.40 ±268%     +28.6%      10.80 ±196%  softirqs.CPU17.NET_RX
      0.50 ±134%     -60.0%       0.20 ±200%  softirqs.CPU17.NET_TX
      6378 ± 15%      +9.5%       6985 ± 11%  softirqs.CPU17.RCU
      6753 ±  5%      +2.7%       6932 ±  2%  softirqs.CPU17.SCHED
      1.40 ± 65%     +28.6%       1.80 ± 41%  softirqs.CPU17.TASKLET
    226.40 ±134%     -66.7%      75.30 ± 17%  softirqs.CPU17.TIMER
     45.80 ±208%      -5.5%      43.30 ±237%  softirqs.CPU18.BLOCK
      0.60 ±213%     -16.7%       0.50 ±184%  softirqs.CPU18.NET_RX
      0.20 ±200%      +0.0%       0.20 ±200%  softirqs.CPU18.NET_TX
      6239 ±  4%     +13.3%       7071 ± 14%  softirqs.CPU18.RCU
      6777 ±  3%      +5.7%       7165 ±  4%  softirqs.CPU18.SCHED
      0.80 ±122%     -37.5%       0.50 ±161%  softirqs.CPU18.TASKLET
    142.30 ± 85%     +32.3%     188.30 ±168%  softirqs.CPU18.TIMER
     79.30 ±122%      -4.3%      75.90 ±135%  softirqs.CPU19.BLOCK
      1.00 ±118%   +2270.0%      23.70 ±287%  softirqs.CPU19.NET_RX
      0.30 ±213%    -100.0%       0.00        softirqs.CPU19.NET_TX
      6237 ±  5%      +8.5%       6765 ±  7%  softirqs.CPU19.RCU
      6581 ±  6%      +9.7%       7217 ±  2%  softirqs.CPU19.SCHED
      0.60 ±152%     -50.0%       0.30 ±152%  softirqs.CPU19.TASKLET
     87.00 ± 27%     +37.7%     119.80 ± 67%  softirqs.CPU19.TIMER
      1.10 ±300%   +2927.3%      33.30 ±255%  softirqs.CPU2.BLOCK
      2.20 ±225%     -50.0%       1.10 ±183%  softirqs.CPU2.NET_RX
      0.80 ±261%     +37.5%       1.10 ±213%  softirqs.CPU2.NET_TX
      6806 ± 10%      +7.0%       7285 ±  8%  softirqs.CPU2.RCU
      7631 ±  6%      +7.0%       8169 ±  8%  softirqs.CPU2.SCHED
      1.70 ±263%    -100.0%       0.00        softirqs.CPU2.TASKLET
    231.00 ± 68%     -47.4%     121.50 ± 41%  softirqs.CPU2.TIMER
     23.40 ±285%     -33.3%      15.60 ±250%  softirqs.CPU20.BLOCK
      2.20 ±197%     -68.2%       0.70 ±169%  softirqs.CPU20.NET_RX
      0.10 ±300%    +100.0%       0.20 ±200%  softirqs.CPU20.NET_TX
      6306 ±  6%     +10.6%       6976 ±  7%  softirqs.CPU20.RCU
      7055 ±  7%      +3.1%       7272 ±  5%  softirqs.CPU20.SCHED
      0.10 ±300%    +900.0%       1.00 ±300%  softirqs.CPU20.TASKLET
    238.50 ±128%     -48.2%     123.50 ± 99%  softirqs.CPU20.TIMER
      1.60 ±300%     +12.5%       1.80 ±213%  softirqs.CPU21.BLOCK
      0.40 ±165%    +600.0%       2.80 ±194%  softirqs.CPU21.NET_RX
      0.20 ±200%    +300.0%       0.80 ±300%  softirqs.CPU21.NET_TX
      6174 ±  8%     +15.9%       7156 ± 10%  softirqs.CPU21.RCU
      6584 ±  5%      +8.7%       7154 ±  4%  softirqs.CPU21.SCHED
      0.00          -100.0%       0.00        softirqs.CPU21.TASKLET
    131.80 ± 92%     -14.3%     112.90 ± 69%  softirqs.CPU21.TIMER
      0.10 ±300%  +12200.0%      12.30 ±254%  softirqs.CPU22.BLOCK
     11.00 ± 42%      -1.8%      10.80 ± 28%  softirqs.CPU22.NET_RX
      2.30 ±102%     +21.7%       2.80 ±104%  softirqs.CPU22.NET_TX
      6501 ± 12%      +0.2%       6512 ±  3%  softirqs.CPU22.RCU
      7153 ±  8%      -0.2%       7139 ±  2%  softirqs.CPU22.SCHED
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU22.TASKLET
    486.20 ±134%     -58.2%     203.40 ± 54%  softirqs.CPU22.TIMER
      0.30 ±300%    +533.3%       1.90 ±300%  softirqs.CPU23.BLOCK
     20.40 ±217%    +148.0%      50.60 ±217%  softirqs.CPU23.NET_RX
      0.60 ±300%     -83.3%       0.10 ±300%  softirqs.CPU23.NET_TX
      6278 ± 13%      +4.2%       6541 ±  4%  softirqs.CPU23.RCU
      7110 ± 11%      +7.9%       7673 ± 10%  softirqs.CPU23.SCHED
    450.10 ±158%     +65.8%     746.10 ±118%  softirqs.CPU23.TIMER
      3.30 ±260%    +163.6%       8.70 ±260%  softirqs.CPU24.BLOCK
      1.30 ±124%   +2346.2%      31.80 ±193%  softirqs.CPU24.NET_RX
      0.00         +9e+101%       0.90 ±265%  softirqs.CPU24.NET_TX
      6198 ± 20%      +4.1%       6450 ±  3%  softirqs.CPU24.RCU
      6539 ±  2%      +8.1%       7070        softirqs.CPU24.SCHED
      2.00           -10.0%       1.80 ± 33%  softirqs.CPU24.TASKLET
    166.00 ±180%     -26.7%     121.70 ±103%  softirqs.CPU24.TIMER
     12.80 ±236%     -44.5%       7.10 ±299%  softirqs.CPU25.BLOCK
     38.70 ±289%     -65.9%      13.20 ±277%  softirqs.CPU25.NET_RX
      0.10 ±300%    -100.0%       0.00        softirqs.CPU25.NET_TX
      5981 ± 13%      +5.7%       6324 ±  2%  softirqs.CPU25.RCU
      6769 ±  5%      +3.9%       7035 ±  2%  softirqs.CPU25.SCHED
      2.00 ± 22%     -10.0%       1.80 ± 33%  softirqs.CPU25.TASKLET
     59.00 ± 21%     +24.7%      73.60 ± 15%  softirqs.CPU25.TIMER
      2.10 ±239%     -90.5%       0.20 ±300%  softirqs.CPU26.BLOCK
      5.20 ±200%     -78.8%       1.10 ±271%  softirqs.CPU26.NET_RX
      5813 ±  7%      +6.7%       6203        softirqs.CPU26.RCU
      6689 ±  3%      +4.6%       6993        softirqs.CPU26.SCHED
      1.80 ± 33%     +11.1%       2.00        softirqs.CPU26.TASKLET
     65.00 ± 20%     +62.5%     105.60 ± 69%  softirqs.CPU26.TIMER
      2.80 ±300%    -100.0%       0.00        softirqs.CPU27.BLOCK
      0.00       +4.8e+102%       4.80 ±210%  softirqs.CPU27.NET_RX
      5743 ±  6%     +10.0%       6319 ±  5%  softirqs.CPU27.RCU
      6524 ±  4%      +8.2%       7062 ±  3%  softirqs.CPU27.SCHED
      2.00           -10.0%       1.80 ± 33%  softirqs.CPU27.TASKLET
     66.60 ± 15%     +12.9%      75.20 ± 19%  softirqs.CPU27.TIMER
     10.50 ±296%     -73.3%       2.80 ±300%  softirqs.CPU28.BLOCK
     27.40 ±278%     -57.7%      11.60 ±297%  softirqs.CPU28.NET_RX
      0.10 ±300%    -100.0%       0.00        softirqs.CPU28.NET_TX
      5809 ±  7%      +7.2%       6229 ±  3%  softirqs.CPU28.RCU
      6727 ±  3%      +5.0%       7064 ±  6%  softirqs.CPU28.SCHED
      1.60 ± 50%     +43.8%       2.30 ± 39%  softirqs.CPU28.TASKLET
    169.80 ±186%     +30.0%     220.80 ±205%  softirqs.CPU28.TIMER
      2.10 ±240%    +209.5%       6.50 ±173%  softirqs.CPU29.NET_RX
      0.00         +3e+101%       0.30 ±213%  softirqs.CPU29.NET_TX
      6081 ± 12%      +5.6%       6421 ±  6%  softirqs.CPU29.RCU
      6625 ±  3%      +7.3%       7108 ±  3%  softirqs.CPU29.SCHED
      2.00            -5.0%       1.90 ± 36%  softirqs.CPU29.TASKLET
     98.80 ±103%     -20.9%      78.20 ± 19%  softirqs.CPU29.TIMER
      2.20 ±196%   +1127.3%      27.00 ±262%  softirqs.CPU3.BLOCK
      0.90 ± 92%     +33.3%       1.20 ± 97%  softirqs.CPU3.NET_RX
      0.30 ±152%      +0.0%       0.30 ±152%  softirqs.CPU3.NET_TX
      6549 ±  7%     +13.0%       7398 ± 15%  softirqs.CPU3.RCU
      7048 ±  4%     +10.9%       7819 ±  8%  softirqs.CPU3.SCHED
      0.80 ±175%     +37.5%       1.10 ±149%  softirqs.CPU3.TASKLET
     94.50 ± 61%    +128.0%     215.50 ±129%  softirqs.CPU3.TIMER
      0.00         +1e+103%      10.20 ±223%  softirqs.CPU30.BLOCK
      0.60 ±249%   +1750.0%      11.10 ±265%  softirqs.CPU30.NET_RX
      5801 ±  7%      +9.9%       6374 ±  5%  softirqs.CPU30.RCU
      6626 ±  3%      +8.1%       7164 ±  3%  softirqs.CPU30.SCHED
      2.00            +0.0%       2.00        softirqs.CPU30.TASKLET
     65.70 ± 22%    +204.1%     199.80 ±182%  softirqs.CPU30.TIMER
      7.60 ±204%     -61.8%       2.90 ±299%  softirqs.CPU31.BLOCK
     12.00 ±300%     -95.0%       0.60 ±169%  softirqs.CPU31.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU31.NET_TX
      5807 ±  8%     +10.7%       6429 ±  5%  softirqs.CPU31.RCU
      6691 ±  4%      +6.2%       7106 ±  2%  softirqs.CPU31.SCHED
      2.10 ± 14%      +9.5%       2.30 ± 39%  softirqs.CPU31.TASKLET
    118.30 ±133%     -20.7%      93.80 ± 17%  softirqs.CPU31.TIMER
      0.30 ±300%    +866.7%       2.90 ±299%  softirqs.CPU32.BLOCK
      2.70 ±200%  +10714.8%     292.00 ±271%  softirqs.CPU32.NET_RX
      0.00         +2e+101%       0.20 ±200%  softirqs.CPU32.NET_TX
      5816 ±  7%     +10.9%       6452 ±  6%  softirqs.CPU32.RCU
      6620 ±  3%      +7.3%       7100 ±  4%  softirqs.CPU32.SCHED
      0.60 ±152%      +0.0%       0.60 ±152%  softirqs.CPU32.TASKLET
     67.80 ± 20%     +11.4%      75.50 ± 15%  softirqs.CPU32.TIMER
      4.70 ±300%     -40.4%       2.80 ±300%  softirqs.CPU33.BLOCK
      2.70 ±176%     -88.9%       0.30 ±300%  softirqs.CPU33.NET_RX
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU33.NET_TX
      6030 ± 11%      +5.1%       6335 ±  4%  softirqs.CPU33.RCU
      6936 ± 10%      +1.7%       7052 ±  6%  softirqs.CPU33.SCHED
      0.00         +2e+101%       0.20 ±300%  softirqs.CPU33.TASKLET
    269.80 ±171%     -19.8%     216.30 ±191%  softirqs.CPU33.TIMER
      9.00 ±200%     -45.6%       4.90 ±206%  softirqs.CPU34.BLOCK
      1.10 ±271%   +5909.1%      66.10 ±217%  softirqs.CPU34.NET_RX
      0.80 ±300%    -100.0%       0.00        softirqs.CPU34.NET_TX
      5899 ±  8%      +6.5%       6282 ±  2%  softirqs.CPU34.RCU
      6540 ±  4%      +9.2%       7142 ±  3%  softirqs.CPU34.SCHED
      0.50 ±240%     -80.0%       0.10 ±300%  softirqs.CPU34.TASKLET
     80.50 ± 45%      +1.4%      81.60 ± 18%  softirqs.CPU34.TIMER
      2.10 ±231%    +123.8%       4.70 ±299%  softirqs.CPU35.BLOCK
      4.70 ±299%     -76.6%       1.10 ±271%  softirqs.CPU35.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU35.NET_TX
      5858 ±  8%      +8.5%       6354 ±  6%  softirqs.CPU35.RCU
      6561 ±  3%      +8.7%       7135 ±  2%  softirqs.CPU35.SCHED
      0.00         +1e+102%       1.00 ±268%  softirqs.CPU35.TASKLET
     67.10 ± 29%    +118.5%     146.60 ±105%  softirqs.CPU35.TIMER
      0.00       +3.4e+102%       3.40 ±261%  softirqs.CPU36.BLOCK
      1.50 ±300%   +2120.0%      33.30 ±234%  softirqs.CPU36.NET_RX
      0.20 ±300%     -50.0%       0.10 ±300%  softirqs.CPU36.NET_TX
      5887 ± 10%      +7.0%       6298 ±  2%  softirqs.CPU36.RCU
      6762 ± 10%      +4.7%       7083 ±  2%  softirqs.CPU36.SCHED
      0.40 ±300%    -100.0%       0.00        softirqs.CPU36.TASKLET
    217.00 ±218%     -66.0%      73.80 ± 18%  softirqs.CPU36.TIMER
      9.30 ±195%     -69.9%       2.80 ±300%  softirqs.CPU37.BLOCK
      0.50 ±300%    +220.0%       1.60 ±279%  softirqs.CPU37.NET_RX
      0.10 ±300%    -100.0%       0.00        softirqs.CPU37.NET_TX
      5931 ±  8%      +7.7%       6389 ±  4%  softirqs.CPU37.RCU
      6821 ±  8%      +4.4%       7121 ±  2%  softirqs.CPU37.SCHED
      4.30 ±300%    -100.0%       0.00        softirqs.CPU37.TASKLET
     59.20 ± 15%    +231.1%     196.00 ±130%  softirqs.CPU37.TIMER
      2.90 ±299%    -100.0%       0.00        softirqs.CPU38.BLOCK
      1.90 ±163%   +5231.6%     101.30 ±300%  softirqs.CPU38.NET_RX
      0.10 ±300%    -100.0%       0.00        softirqs.CPU38.NET_TX
      5888 ±  8%      +5.6%       6217 ±  4%  softirqs.CPU38.RCU
      6745 ±  4%      +3.3%       6969        softirqs.CPU38.SCHED
      0.00          -100.0%       0.00        softirqs.CPU38.TASKLET
    267.20 ±149%     -64.4%      95.00 ± 37%  softirqs.CPU38.TIMER
      0.20 ±300%    -100.0%       0.00        softirqs.CPU39.BLOCK
      0.00          -100.0%       0.00        softirqs.CPU39.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU39.NET_TX
      5878 ± 10%      +5.0%       6174 ±  2%  softirqs.CPU39.RCU
      6597 ±  6%      +6.8%       7044 ±  3%  softirqs.CPU39.SCHED
      0.70 ±202%    -100.0%       0.00        softirqs.CPU39.TASKLET
     71.00 ± 19%    +206.2%     217.40 ±203%  softirqs.CPU39.TIMER
      5.80 ±207%     -96.6%       0.20 ±300%  softirqs.CPU4.BLOCK
      1.60 ±151%     -75.0%       0.40 ±122%  softirqs.CPU4.NET_RX
      0.20 ±200%     +50.0%       0.30 ±152%  softirqs.CPU4.NET_TX
      6504 ±  9%     +10.6%       7196 ±  9%  softirqs.CPU4.RCU
      6848 ±  6%     +11.8%       7656 ±  8%  softirqs.CPU4.SCHED
      0.60 ±249%     -50.0%       0.30 ±213%  softirqs.CPU4.TASKLET
    187.40 ± 83%     +84.5%     345.80 ±157%  softirqs.CPU4.TIMER
     12.60 ±252%     -69.0%       3.90 ±124%  softirqs.CPU40.NET_RX
      0.00         +3e+101%       0.30 ±152%  softirqs.CPU40.NET_TX
      5856 ± 13%      +6.3%       6226 ±  2%  softirqs.CPU40.RCU
      6639 ±  5%      +4.9%       6964        softirqs.CPU40.SCHED
      0.40 ±229%    +100.0%       0.80 ±300%  softirqs.CPU40.TASKLET
    132.80 ±102%     -35.3%      85.90 ± 58%  softirqs.CPU40.TIMER
     30.40 ±275%   +3935.5%       1226 ±299%  softirqs.CPU41.NET_RX
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU41.NET_TX
      5991 ±  9%      +7.4%       6431 ±  6%  softirqs.CPU41.RCU
      6709 ±  5%      +5.6%       7084 ±  5%  softirqs.CPU41.SCHED
      0.10 ±300%    -100.0%       0.00        softirqs.CPU41.TASKLET
     86.60 ± 56%    +197.5%     257.60 ±202%  softirqs.CPU41.TIMER
      1.70 ±300%     +64.7%       2.80 ±300%  softirqs.CPU42.BLOCK
     70.70 ±253%     -74.7%      17.90 ±251%  softirqs.CPU42.NET_RX
      0.10 ±300%    +100.0%       0.20 ±300%  softirqs.CPU42.NET_TX
      5971 ±  8%      +5.6%       6307 ±  4%  softirqs.CPU42.RCU
      6838 ±  6%      +5.6%       7221 ±  7%  softirqs.CPU42.SCHED
      2.30 ±285%    -100.0%       0.00        softirqs.CPU42.TASKLET
    134.10 ±138%    +110.4%     282.10 ±220%  softirqs.CPU42.TIMER
      2.90 ±299%    -100.0%       0.00        softirqs.CPU43.BLOCK
     11.30 ±291%    +244.2%      38.90 ±292%  softirqs.CPU43.NET_RX
      0.90 ±230%     -88.9%       0.10 ±300%  softirqs.CPU43.NET_TX
      5937 ±  6%      +7.2%       6362 ±  6%  softirqs.CPU43.RCU
      6059 ±  7%     +12.2%       6799 ±  9%  softirqs.CPU43.SCHED
      0.20 ±200%     +50.0%       0.30 ±300%  softirqs.CPU43.TASKLET
    150.80 ±158%     +33.4%     201.20 ±181%  softirqs.CPU43.TIMER
     30.20 ±159%     -92.1%       2.40 ±195%  softirqs.CPU44.BLOCK
     64.40 ±289%     -97.0%       1.90 ±231%  softirqs.CPU44.NET_RX
      0.40 ±165%    -100.0%       0.00        softirqs.CPU44.NET_TX
      5347 ± 10%      +6.2%       5681 ± 10%  softirqs.CPU44.RCU
      6613 ± 12%      +6.8%       7061 ±  3%  softirqs.CPU44.SCHED
      0.10 ±300%    +200.0%       0.30 ±300%  softirqs.CPU44.TASKLET
    310.70 ±183%     -28.9%     220.90 ± 79%  softirqs.CPU44.TIMER
     10.30 ±154%     -19.4%       8.30 ±156%  softirqs.CPU45.BLOCK
     11.40 ±255%      +7.0%      12.20 ±291%  softirqs.CPU45.NET_RX
      0.10 ±300%      +0.0%       0.10 ±300%  softirqs.CPU45.NET_TX
      5811 ±  8%     +11.9%       6504 ±  7%  softirqs.CPU45.RCU
      6568 ±  4%     +12.2%       7370 ±  8%  softirqs.CPU45.SCHED
      0.20 ±200%    +500.0%       1.20 ±300%  softirqs.CPU45.TASKLET
     85.00 ± 30%    +425.3%     446.50 ±153%  softirqs.CPU45.TIMER
      3.30 ±230%     -30.3%       2.30 ±198%  softirqs.CPU46.BLOCK
     13.30 ±275%     +37.6%      18.30 ±292%  softirqs.CPU46.NET_RX
      0.00         +4e+101%       0.40 ±229%  softirqs.CPU46.NET_TX
      6085 ±  7%     +15.8%       7050 ± 17%  softirqs.CPU46.RCU
      6656 ±  5%      +4.4%       6950 ± 11%  softirqs.CPU46.SCHED
      0.30 ±213%   +1633.3%       5.20 ±176%  softirqs.CPU46.TASKLET
    103.60 ± 58%    +317.8%     432.80 ±129%  softirqs.CPU46.TIMER
      2.40 ±300%     +62.5%       3.90 ±231%  softirqs.CPU47.BLOCK
    133.10 ±298%     -91.4%      11.50 ±288%  softirqs.CPU47.NET_RX
      0.20 ±200%      +0.0%       0.20 ±200%  softirqs.CPU47.NET_TX
      5999 ±  4%     +11.0%       6656 ±  8%  softirqs.CPU47.RCU
      6464 ±  5%      +4.5%       6757 ±  9%  softirqs.CPU47.SCHED
      0.10 ±300%    +300.0%       0.40 ±165%  softirqs.CPU47.TASKLET
     99.00 ± 41%     +28.7%     127.40 ± 77%  softirqs.CPU47.TIMER
      1.80 ±175%    +144.4%       4.40 ±217%  softirqs.CPU48.BLOCK
      0.90 ±104%     +33.3%       1.20 ±219%  softirqs.CPU48.NET_RX
      0.10 ±300%    -100.0%       0.00        softirqs.CPU48.NET_TX
      6476 ± 17%      +3.0%       6671 ±  3%  softirqs.CPU48.RCU
      6672 ±  4%     +10.4%       7369 ±  8%  softirqs.CPU48.SCHED
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU48.TASKLET
    208.40 ±150%     +43.7%     299.50 ±209%  softirqs.CPU48.TIMER
      1.60 ±259%     -43.8%       0.90 ±265%  softirqs.CPU49.BLOCK
      4.20 ±204%     -76.2%       1.00 ±118%  softirqs.CPU49.NET_RX
      0.20 ±200%     -50.0%       0.10 ±300%  softirqs.CPU49.NET_TX
      6263 ±  8%     +14.1%       7147 ± 10%  softirqs.CPU49.RCU
      6597 ±  5%     +11.3%       7341 ±  8%  softirqs.CPU49.SCHED
      0.60 ±213%     +83.3%       1.10 ±192%  softirqs.CPU49.TASKLET
     99.70 ± 73%    +164.3%     263.50 ±146%  softirqs.CPU49.TIMER
      0.80 ±300%     -25.0%       0.60 ±300%  softirqs.CPU5.BLOCK
      3.50 ±290%     -71.4%       1.00 ±178%  softirqs.CPU5.NET_RX
      0.20 ±200%     -50.0%       0.10 ±300%  softirqs.CPU5.NET_TX
      6480 ± 16%     +18.2%       7659 ± 15%  softirqs.CPU5.RCU
      6898 ±  4%      +9.2%       7534 ±  7%  softirqs.CPU5.SCHED
      0.40 ±300%     -75.0%       0.10 ±300%  softirqs.CPU5.TASKLET
    203.10 ±176%      +9.7%     222.80 ±157%  softirqs.CPU5.TIMER
      0.80 ±300%    +200.0%       2.40 ±189%  softirqs.CPU50.BLOCK
     36.40 ±291%    +928.3%     374.30 ±297%  softirqs.CPU50.NET_RX
      0.40 ±165%     -50.0%       0.20 ±200%  softirqs.CPU50.NET_TX
      6204 ± 14%      +7.8%       6688 ±  6%  softirqs.CPU50.RCU
      6586 ±  2%      +9.7%       7222 ±  3%  softirqs.CPU50.SCHED
      0.50 ±204%     -40.0%       0.30 ±213%  softirqs.CPU50.TASKLET
    260.70 ±146%     -53.8%     120.50 ± 46%  softirqs.CPU50.TIMER
      1.00 ±118%    +750.0%       8.50 ±280%  softirqs.CPU51.NET_RX
      0.10 ±300%    +100.0%       0.20 ±200%  softirqs.CPU51.NET_TX
      5779 ±  5%     +16.9%       6758 ±  4%  softirqs.CPU51.RCU
      6639 ±  3%      +9.6%       7275 ±  3%  softirqs.CPU51.SCHED
      1.30 ±182%     +69.2%       2.20 ±300%  softirqs.CPU51.TASKLET
     92.20 ± 45%    +131.8%     213.70 ±142%  softirqs.CPU51.TIMER
      0.10 ±300%    -100.0%       0.00        softirqs.CPU52.BLOCK
      0.70 ±128%    +271.4%       2.60 ±171%  softirqs.CPU52.NET_RX
      0.10 ±300%      +0.0%       0.10 ±300%  softirqs.CPU52.NET_TX
      6286 ±  9%      +7.3%       6745 ± 11%  softirqs.CPU52.RCU
      6913 ±  9%      +4.1%       7199 ±  3%  softirqs.CPU52.SCHED
      0.00       +1.5e+102%       1.50 ±300%  softirqs.CPU52.TASKLET
    304.30 ±201%     -64.1%     109.30 ± 45%  softirqs.CPU52.TIMER
      3.40 ±162%    -100.0%       0.00        softirqs.CPU53.BLOCK
      5.60 ±270%    +391.1%      27.50 ±275%  softirqs.CPU53.NET_RX
      0.20 ±300%      +0.0%       0.20 ±200%  softirqs.CPU53.NET_TX
      6253 ±  6%     +10.8%       6927 ±  5%  softirqs.CPU53.RCU
      6682 ±  4%     +11.6%       7457 ±  2%  softirqs.CPU53.SCHED
      0.10 ±300%   +2900.0%       3.00 ±278%  softirqs.CPU53.TASKLET
     74.50 ± 44%     +46.7%     109.30 ± 72%  softirqs.CPU53.TIMER
      0.00       +2.4e+102%       2.40 ±213%  softirqs.CPU54.BLOCK
      0.60 ±133%     +33.3%       0.80 ±122%  softirqs.CPU54.NET_RX
      0.10 ±300%      +0.0%       0.10 ±300%  softirqs.CPU54.NET_TX
      6162 ±  5%     +18.5%       7304 ± 13%  softirqs.CPU54.RCU
      6843 ±  7%      +7.9%       7385 ±  5%  softirqs.CPU54.SCHED
      0.00         +6e+101%       0.60 ±213%  softirqs.CPU54.TASKLET
    289.60 ±213%     +42.6%     413.10 ±137%  softirqs.CPU54.TIMER
      7.00 ±157%     -90.0%       0.70 ±212%  softirqs.CPU55.NET_RX
      0.30 ±213%     -33.3%       0.20 ±200%  softirqs.CPU55.NET_TX
      6265 ±  8%      +6.3%       6657 ±  8%  softirqs.CPU55.RCU
      6811 ±  5%      +7.9%       7351 ±  4%  softirqs.CPU55.SCHED
      0.10 ±300%   +2600.0%       2.70 ±254%  softirqs.CPU55.TASKLET
    100.50 ± 65%     +12.2%     112.80 ± 62%  softirqs.CPU55.TIMER
      5.00 ±273%     -64.0%       1.80 ±263%  softirqs.CPU56.NET_RX
      0.10 ±300%      +0.0%       0.10 ±300%  softirqs.CPU56.NET_TX
      6227 ±  6%     +13.9%       7095 ±  4%  softirqs.CPU56.RCU
      6918 ± 10%      +6.0%       7330 ±  7%  softirqs.CPU56.SCHED
      1.10 ±271%     -63.6%       0.40 ±300%  softirqs.CPU56.TASKLET
    272.60 ±233%     -44.5%     151.30 ±131%  softirqs.CPU56.TIMER
      0.00       +3.6e+102%       3.60 ±213%  softirqs.CPU57.BLOCK
      4.20 ±109%     -40.5%       2.50 ± 36%  softirqs.CPU57.NET_RX
      2.00            +0.0%       2.00        softirqs.CPU57.NET_TX
      6380 ±  6%      +7.8%       6878 ± 11%  softirqs.CPU57.RCU
      6914 ±  6%      +5.6%       7304 ±  3%  softirqs.CPU57.SCHED
      4.10 ±100%      +4.9%       4.30 ±147%  softirqs.CPU57.TASKLET
    125.50 ± 60%     -15.8%     105.70 ± 43%  softirqs.CPU57.TIMER
      3.30 ±271%     -39.4%       2.00 ±204%  softirqs.CPU58.BLOCK
      4.90 ±224%    +357.1%      22.40 ±269%  softirqs.CPU58.NET_RX
      0.30 ±213%     -66.7%       0.10 ±300%  softirqs.CPU58.NET_TX
      6539 ± 11%      +6.7%       6981 ±  6%  softirqs.CPU58.RCU
      6969 ±  3%      +5.4%       7344 ±  6%  softirqs.CPU58.SCHED
      2.80 ±300%     -89.3%       0.30 ±213%  softirqs.CPU58.TASKLET
     86.00 ± 21%     +21.5%     104.50 ± 34%  softirqs.CPU58.TIMER
      0.20 ±300%    +250.0%       0.70 ±255%  softirqs.CPU59.BLOCK
      0.90 ±168%   +1177.8%      11.50 ±251%  softirqs.CPU59.NET_RX
      0.40 ±200%     -25.0%       0.30 ±213%  softirqs.CPU59.NET_TX
      6036 ±  5%     +15.8%       6989 ±  6%  softirqs.CPU59.RCU
      6729           +11.7%       7515 ±  7%  softirqs.CPU59.SCHED
      0.10 ±300%   +1000.0%       1.10 ±164%  softirqs.CPU59.TASKLET
     93.80 ± 28%    +234.1%     313.40 ±194%  softirqs.CPU59.TIMER
      1.20 ±200%     +66.7%       2.00 ±188%  softirqs.CPU6.BLOCK
     24.50 ±213%     -96.7%       0.80 ±108%  softirqs.CPU6.NET_RX
      0.20 ±200%    -100.0%       0.00        softirqs.CPU6.NET_TX
      6331 ± 11%      +4.8%       6636 ±  4%  softirqs.CPU6.RCU
      7149 ± 13%      +5.0%       7504 ±  9%  softirqs.CPU6.SCHED
      0.20 ±300%    +100.0%       0.40 ±200%  softirqs.CPU6.TASKLET
    258.30 ±205%     -26.7%     189.30 ±113%  softirqs.CPU6.TIMER
      0.00         +2e+101%       0.20 ±300%  softirqs.CPU60.BLOCK
     17.50 ±191%     -89.1%       1.90 ±113%  softirqs.CPU60.NET_RX
      0.30 ±152%      +0.0%       0.30 ±152%  softirqs.CPU60.NET_TX
      6692 ± 26%      +4.2%       6976 ±  6%  softirqs.CPU60.RCU
      6770 ±  3%      +8.1%       7321 ±  4%  softirqs.CPU60.SCHED
      1.00 ±300%    +340.0%       4.40 ±183%  softirqs.CPU60.TASKLET
    190.90 ±167%     -55.7%      84.50 ± 17%  softirqs.CPU60.TIMER
      3.50 ±300%     +17.1%       4.10 ±198%  softirqs.CPU61.BLOCK
      1.50 ±237%     +53.3%       2.30 ±160%  softirqs.CPU61.NET_RX
      0.10 ±300%    +300.0%       0.40 ±165%  softirqs.CPU61.NET_TX
      6093 ±  8%     +12.4%       6847 ±  6%  softirqs.CPU61.RCU
      6677 ±  4%     +10.3%       7364 ±  7%  softirqs.CPU61.SCHED
      1.90 ±249%    -100.0%       0.00        softirqs.CPU61.TASKLET
     78.70 ± 27%     +18.2%      93.00 ± 27%  softirqs.CPU61.TIMER
      2.10 ±193%    +147.6%       5.20 ±217%  softirqs.CPU62.BLOCK
     17.90 ±198%    +436.9%      96.10 ±154%  softirqs.CPU62.NET_RX
      0.40 ±122%     -50.0%       0.20 ±200%  softirqs.CPU62.NET_TX
      6161 ±  5%      +7.6%       6630 ±  5%  softirqs.CPU62.RCU
      6895 ±  3%      +7.2%       7389 ±  4%  softirqs.CPU62.SCHED
      1.10 ±299%     +45.5%       1.60 ±145%  softirqs.CPU62.TASKLET
     79.70 ± 29%      +6.9%      85.20 ± 24%  softirqs.CPU62.TIMER
      0.00         +2e+101%       0.20 ±300%  softirqs.CPU63.BLOCK
      1.40 ±186%   +2585.7%      37.60 ±296%  softirqs.CPU63.NET_RX
      0.30 ±213%     -66.7%       0.10 ±300%  softirqs.CPU63.NET_TX
      6300 ±  7%      +8.4%       6826 ±  8%  softirqs.CPU63.RCU
      6783 ±  3%      +9.0%       7393 ±  5%  softirqs.CPU63.SCHED
      0.40 ±200%    +650.0%       3.00 ±225%  softirqs.CPU63.TASKLET
     75.30 ± 14%     +33.2%     100.30 ± 33%  softirqs.CPU63.TIMER
      0.80 ±300%      +0.0%       0.80 ±300%  softirqs.CPU64.BLOCK
      2.30 ±102%     -73.9%       0.60 ±110%  softirqs.CPU64.NET_RX
      0.30 ±152%      +0.0%       0.30 ±213%  softirqs.CPU64.NET_TX
      6152 ±  7%     +10.8%       6816 ±  8%  softirqs.CPU64.RCU
      6667 ±  3%      +9.2%       7281 ±  3%  softirqs.CPU64.SCHED
      1.60 ±279%     -87.5%       0.20 ±300%  softirqs.CPU64.TASKLET
     89.30 ± 33%      -0.2%      89.10 ± 37%  softirqs.CPU64.TIMER
      0.00       +5.2e+102%       5.20 ±217%  softirqs.CPU65.BLOCK
      0.50 ±100%    +340.0%       2.20 ±147%  softirqs.CPU65.NET_RX
      0.10 ±300%    +500.0%       0.60 ±110%  softirqs.CPU65.NET_TX
      5995 ±  6%     +16.1%       6962 ±  6%  softirqs.CPU65.RCU
      6749 ±  5%      +9.2%       7367 ±  4%  softirqs.CPU65.SCHED
      0.00       +2.1e+102%       2.10 ±268%  softirqs.CPU65.TASKLET
    137.80 ±113%     -20.5%     109.60 ± 69%  softirqs.CPU65.TIMER
     10.00 ±176%     -70.0%       3.00 ±300%  softirqs.CPU66.BLOCK
      1.40 ± 57%    +792.9%      12.50 ±270%  softirqs.CPU66.NET_RX
      1.20 ±200%    -100.0%       0.00        softirqs.CPU66.NET_TX
      6228 ± 11%      +3.4%       6438 ±  5%  softirqs.CPU66.RCU
      6873 ±  7%      +1.3%       6964 ±  4%  softirqs.CPU66.SCHED
      0.10 ±300%      +0.0%       0.10 ±300%  softirqs.CPU66.TASKLET
    246.20 ±199%     -62.0%      93.50 ± 23%  softirqs.CPU66.TIMER
      0.10 ±300%    +100.0%       0.20 ±300%  softirqs.CPU67.BLOCK
      0.90 ±265%     -33.3%       0.60 ±300%  softirqs.CPU67.NET_RX
      0.10 ±300%      +0.0%       0.10 ±300%  softirqs.CPU67.NET_TX
      6105 ±  9%      +2.3%       6245 ±  4%  softirqs.CPU67.RCU
      6786 ± 11%      +2.5%       6955        softirqs.CPU67.SCHED
      5.60 ±202%    -100.0%       0.00        softirqs.CPU67.TASKLET
    494.40 ±166%     -84.4%      76.90 ± 18%  softirqs.CPU67.TIMER
      3.00 ±300%    -100.0%       0.00        softirqs.CPU68.BLOCK
      5.10 ±193%    -100.0%       0.00        softirqs.CPU68.NET_RX
      0.20 ±200%    -100.0%       0.00        softirqs.CPU68.NET_TX
      6036 ± 10%      +2.6%       6193 ±  3%  softirqs.CPU68.RCU
      6743 ±  4%      +3.1%       6952        softirqs.CPU68.SCHED
      1.10 ±201%    -100.0%       0.00        softirqs.CPU68.TASKLET
    121.80 ± 95%     -18.0%      99.90 ± 47%  softirqs.CPU68.TIMER
      0.20 ±300%   +1300.0%       2.80 ±300%  softirqs.CPU69.BLOCK
     33.80 ±296%     -60.1%      13.50 ±261%  softirqs.CPU69.NET_RX
      5721 ±  9%     +11.2%       6362 ±  6%  softirqs.CPU69.RCU
      6618 ±  3%      +8.3%       7167 ±  5%  softirqs.CPU69.SCHED
     85.70 ± 45%    +221.8%     275.80 ±177%  softirqs.CPU69.TIMER
      0.00       +1.4e+102%       1.40 ±189%  softirqs.CPU7.BLOCK
     11.50 ±183%     -91.3%       1.00 ±148%  softirqs.CPU7.NET_RX
      0.50 ±100%     -80.0%       0.10 ±300%  softirqs.CPU7.NET_TX
      6116 ±  7%     +18.1%       7223 ± 14%  softirqs.CPU7.RCU
      6956 ±  4%      +5.2%       7314 ±  7%  softirqs.CPU7.SCHED
      1.40 ±255%     -92.9%       0.10 ±300%  softirqs.CPU7.TASKLET
    113.30 ±116%    +131.4%     262.20 ±142%  softirqs.CPU7.TIMER
      0.20 ±300%  +21400.0%      43.00 ±202%  softirqs.CPU70.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU70.NET_TX
      6038 ± 12%      +4.1%       6285 ±  2%  softirqs.CPU70.RCU
      6691 ±  3%      +5.9%       7085 ±  2%  softirqs.CPU70.SCHED
     81.30 ± 49%      -8.1%      74.70 ± 22%  softirqs.CPU70.TIMER
      0.10 ±300%    -100.0%       0.00        softirqs.CPU71.BLOCK
      1.10 ±224%    +518.2%       6.80 ±300%  softirqs.CPU71.NET_RX
      0.20 ±200%    -100.0%       0.00        softirqs.CPU71.NET_TX
      6016 ± 12%      +4.0%       6260 ±  2%  softirqs.CPU71.RCU
      6648 ±  4%      +7.1%       7120 ±  5%  softirqs.CPU71.SCHED
      3.80 ±274%    -100.0%       0.00        softirqs.CPU71.TASKLET
     68.70 ± 32%    +242.9%     235.60 ±205%  softirqs.CPU71.TIMER
      1.10 ±271%     -63.6%       0.40 ±229%  softirqs.CPU72.NET_RX
      0.10 ±300%    -100.0%       0.00        softirqs.CPU72.NET_TX
      6468 ± 24%      -0.2%       6452 ±  5%  softirqs.CPU72.RCU
      6720 ±  7%      +7.2%       7202 ±  6%  softirqs.CPU72.SCHED
      0.40 ±200%    -100.0%       0.00        softirqs.CPU72.TASKLET
    207.50 ±205%     +84.6%     383.00 ±164%  softirqs.CPU72.TIMER
      3.00 ±278%     +90.0%       5.70 ±200%  softirqs.CPU73.BLOCK
     40.00 ±294%     -97.2%       1.10 ±300%  softirqs.CPU73.NET_RX
      6191 ± 18%      +1.3%       6272 ±  4%  softirqs.CPU73.RCU
      6609 ±  3%      +6.5%       7038        softirqs.CPU73.SCHED
    166.80 ±189%     -54.8%      75.40 ± 16%  softirqs.CPU73.TIMER
      0.00         +1e+103%      10.10 ±300%  softirqs.CPU74.BLOCK
      0.00         +8e+101%       0.80 ±175%  softirqs.CPU74.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU74.NET_TX
      6331 ± 29%      +0.3%       6347 ±  4%  softirqs.CPU74.RCU
      6739 ±  6%      +4.9%       7073 ±  3%  softirqs.CPU74.SCHED
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU74.TASKLET
    355.40 ±165%     -57.5%     150.90 ± 82%  softirqs.CPU74.TIMER
      2.80 ±300%    +203.6%       8.50 ±152%  softirqs.CPU75.BLOCK
     12.70 ±294%    +357.5%      58.10 ±299%  softirqs.CPU75.NET_RX
      0.10 ±300%    -100.0%       0.00        softirqs.CPU75.NET_TX
      5538 ±  6%      +6.9%       5918 ±  2%  softirqs.CPU75.RCU
      6726 ±  7%      +4.3%       7012 ±  3%  softirqs.CPU75.SCHED
      0.10 ±300%    -100.0%       0.00        softirqs.CPU75.TASKLET
    242.70 ±173%     -71.0%      70.30 ± 12%  softirqs.CPU75.TIMER
      5.90 ±200%     -23.7%       4.50 ±207%  softirqs.CPU76.BLOCK
      0.30 ±300%   +3933.3%      12.10 ±289%  softirqs.CPU76.NET_RX
      5551 ±  8%      +8.6%       6027 ±  6%  softirqs.CPU76.RCU
      6602 ±  3%      +7.3%       7085 ±  2%  softirqs.CPU76.SCHED
      0.10 ±300%    -100.0%       0.00        softirqs.CPU76.TASKLET
     66.50 ± 30%     +57.7%     104.90 ± 63%  softirqs.CPU76.TIMER
    136.30 ±292%     -93.0%       9.50 ±286%  softirqs.CPU77.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU77.NET_TX
      5498 ±  6%     +10.9%       6097 ±  5%  softirqs.CPU77.RCU
      6594 ±  4%      +7.3%       7076 ±  3%  softirqs.CPU77.SCHED
      1.00 ±209%     +40.0%       1.40 ±300%  softirqs.CPU77.TASKLET
     94.90 ± 95%      -2.7%      92.30 ± 33%  softirqs.CPU77.TIMER
      2.30 ±300%     -91.3%       0.20 ±300%  softirqs.CPU78.BLOCK
     17.00 ±280%     +76.5%      30.00 ±180%  softirqs.CPU78.NET_RX
      0.10 ±300%    -100.0%       0.00        softirqs.CPU78.NET_TX
      5553 ±  7%     +10.0%       6106 ± 11%  softirqs.CPU78.RCU
      6713 ± 10%      +5.3%       7068 ±  3%  softirqs.CPU78.SCHED
      1.30 ±250%    -100.0%       0.00        softirqs.CPU78.TASKLET
     66.40 ± 28%      +7.5%      71.40 ± 18%  softirqs.CPU78.TIMER
      2.80 ±277%    -100.0%       0.00        softirqs.CPU79.BLOCK
     19.10 ±298%     -99.0%       0.20 ±200%  softirqs.CPU79.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU79.NET_TX
      5518 ±  7%     +10.5%       6099 ±  9%  softirqs.CPU79.RCU
      6767 ±  6%      +5.3%       7124 ±  4%  softirqs.CPU79.SCHED
      1.80 ±206%     -27.8%       1.30 ±275%  softirqs.CPU79.TASKLET
    130.20 ±128%    +111.4%     275.20 ±226%  softirqs.CPU79.TIMER
      0.40 ±229%    +250.0%       1.40 ±277%  softirqs.CPU8.NET_RX
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU8.NET_TX
      6326 ± 17%      +6.5%       6741 ±  7%  softirqs.CPU8.RCU
      6791 ±  3%      +7.0%       7264 ±  8%  softirqs.CPU8.SCHED
      2.60 ±275%    -100.0%       0.00        softirqs.CPU8.TASKLET
    246.30 ±139%     -45.9%     133.20 ± 64%  softirqs.CPU8.TIMER
      0.20 ±300%   +1400.0%       3.00 ±300%  softirqs.CPU80.BLOCK
      1.20 ±300%     -83.3%       0.20 ±300%  softirqs.CPU80.NET_RX
      5470 ±  8%      +8.0%       5906 ±  3%  softirqs.CPU80.RCU
      6529 ±  5%      +7.8%       7040        softirqs.CPU80.SCHED
      0.00       +2.6e+102%       2.60 ±299%  softirqs.CPU80.TASKLET
     74.30 ± 41%      -5.4%      70.30 ± 21%  softirqs.CPU80.TIMER
      1.50 ±193%     -86.7%       0.20 ±300%  softirqs.CPU81.BLOCK
     28.10 ±277%     -44.1%      15.70 ±283%  softirqs.CPU81.NET_RX
      0.20 ±200%    -100.0%       0.00        softirqs.CPU81.NET_TX
      5666 ±  7%      +7.6%       6096 ±  4%  softirqs.CPU81.RCU
      6654 ±  3%      +5.3%       7009        softirqs.CPU81.SCHED
      0.20 ±200%    -100.0%       0.00        softirqs.CPU81.TASKLET
    117.10 ±111%     -42.2%      67.70 ± 22%  softirqs.CPU81.TIMER
      0.00       +2.9e+102%       2.90 ±288%  softirqs.CPU82.BLOCK
      1.00 ±219%    +350.0%       4.50 ±152%  softirqs.CPU82.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU82.NET_TX
      5643 ±  8%      +9.7%       6189 ±  4%  softirqs.CPU82.RCU
      6689 ±  7%      +8.4%       7251 ±  8%  softirqs.CPU82.SCHED
      0.10 ±300%    -100.0%       0.00        softirqs.CPU82.TASKLET
    220.40 ±220%     -45.4%     120.30 ± 76%  softirqs.CPU82.TIMER
      7.40 ±291%     +56.8%      11.60 ±188%  softirqs.CPU83.BLOCK
      7.60 ±300%     -89.5%       0.80 ±300%  softirqs.CPU83.NET_RX
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU83.NET_TX
      5572 ± 11%      +4.9%       5845 ±  3%  softirqs.CPU83.RCU
      6367 ±  8%     +10.4%       7029 ±  2%  softirqs.CPU83.SCHED
      0.20 ±200%     -50.0%       0.10 ±300%  softirqs.CPU83.TASKLET
     61.40 ± 25%     +14.0%      70.00 ± 20%  softirqs.CPU83.TIMER
      7.40 ±202%    -100.0%       0.00        softirqs.CPU84.BLOCK
     58.20 ±253%     -87.8%       7.10 ±267%  softirqs.CPU84.NET_RX
      0.20 ±200%    -100.0%       0.00        softirqs.CPU84.NET_TX
      5522 ±  8%      +5.9%       5847 ±  2%  softirqs.CPU84.RCU
      6801 ±  9%      +3.0%       7006        softirqs.CPU84.SCHED
      0.10 ±300%   +1100.0%       1.20 ±273%  softirqs.CPU84.TASKLET
     95.10 ±103%     -18.9%      77.10 ± 19%  softirqs.CPU84.TIMER
      6.40 ±261%     -96.9%       0.20 ±300%  softirqs.CPU85.BLOCK
      0.90 ±300%     -22.2%       0.70 ±255%  softirqs.CPU85.NET_RX
      0.10 ±300%    -100.0%       0.00        softirqs.CPU85.NET_TX
      5423 ±  9%      +7.1%       5806 ±  3%  softirqs.CPU85.RCU
      6473 ±  4%      +7.9%       6982        softirqs.CPU85.SCHED
      0.10 ±300%   +3300.0%       3.40 ±299%  softirqs.CPU85.TASKLET
     61.00 ± 29%     +25.1%      76.30 ± 25%  softirqs.CPU85.TIMER
      3.20 ±279%     -12.5%       2.80 ±300%  softirqs.CPU86.BLOCK
      4.50 ±292%    +120.0%       9.90 ±238%  softirqs.CPU86.NET_RX
      0.30 ±152%    +233.3%       1.00 ±236%  softirqs.CPU86.NET_TX
      5826 ± 12%      +6.0%       6174 ±  4%  softirqs.CPU86.RCU
      6644 ±  5%      +6.5%       7074 ±  4%  softirqs.CPU86.SCHED
      0.00          -100.0%       0.00        softirqs.CPU86.TASKLET
     62.60 ± 15%    +221.1%     201.00 ±189%  softirqs.CPU86.TIMER
     16.70 ±159%    -100.0%       0.00        softirqs.CPU87.BLOCK
      0.90 ±265%     +44.4%       1.30 ±300%  softirqs.CPU87.NET_RX
      1.30 ±182%     -84.6%       0.20 ±200%  softirqs.CPU87.NET_TX
      5846 ± 11%      +5.1%       6145 ±  6%  softirqs.CPU87.RCU
      6021 ±  8%      +4.3%       6283 ±  4%  softirqs.CPU87.SCHED
      0.00         +1e+101%       0.10 ±300%  softirqs.CPU87.TASKLET
    151.30 ±158%     -38.7%      92.70 ± 64%  softirqs.CPU87.TIMER
      2.40 ±138%    -100.0%       0.00        softirqs.CPU9.BLOCK
      2.70 ±122%     -55.6%       1.20 ± 33%  softirqs.CPU9.NET_RX
      1.00            +0.0%       1.00        softirqs.CPU9.NET_TX
      6288 ± 11%      +9.3%       6874 ±  7%  softirqs.CPU9.RCU
      6840 ±  9%      +5.2%       7196 ±  3%  softirqs.CPU9.SCHED
      1.70 ±244%    -100.0%       0.00        softirqs.CPU9.TASKLET
    301.50 ±210%     -61.8%     115.30 ± 49%  softirqs.CPU9.TIMER
      2.40 ± 20%      -8.3%       2.20 ± 18%  softirqs.HI
      1463 ± 42%     +96.5%       2875 ±128%  softirqs.NET_RX
     24.80 ±  8%      +3.2%      25.60 ±  9%  softirqs.NET_TX
    535575 ±  4%      +8.5%     580870        softirqs.RCU
    598311 ±  2%      +6.5%     637462        softirqs.SCHED
    229.20            -0.2%     228.80        softirqs.TASKLET
     14037            +7.2%      15041        softirqs.TIMER
     51.37 ±  3%     -15.0       36.39 ±  2%  perf-profile.calltrace.cycles-pp.write
     49.29 ±  3%     -14.2       35.09 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     48.93 ±  3%     -14.2       34.78 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     48.28 ±  3%     -14.0       34.24 ±  2%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     47.45 ±  3%     -13.9       33.56 ±  2%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     45.46 ±  3%     -13.6       31.84 ±  3%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     44.60 ±  3%     -13.5       31.13 ±  3%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
     40.66 ±  3%     -12.6       28.03 ±  3%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
     40.47 ±  3%     -12.6       27.88 ±  3%  perf-profile.calltrace.cycles-pp.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write.vfs_write
     35.46 ±  3%     -11.6       23.89 ±  4%  perf-profile.calltrace.cycles-pp.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
     24.02 ±  5%      -8.8       15.22 ±  6%  perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
     28.83 ±  8%      -8.7       20.10 ±  8%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     28.47 ±  8%      -8.6       19.87 ±  8%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     28.46 ±  8%      -8.6       19.87 ±  8%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     28.46 ±  8%      -8.6       19.87 ±  8%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     28.13 ±  8%      -8.5       19.63 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     28.08 ±  8%      -8.5       19.59 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     27.17 ±  8%      -8.2       18.95 ±  8%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     19.31 ±  6%      -8.2       11.15 ±  9%  perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
     19.12 ±  6%      -8.1       10.99 ±  9%  perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply
     16.17 ±  8%      -7.6        8.54 ± 12%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
     14.78 ±  7%      -7.5        7.24 ± 12%  perf-profile.calltrace.cycles-pp.__close
     14.77 ±  7%      -7.5        7.24 ± 12%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     14.76 ±  7%      -7.5        7.23 ± 12%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     14.76 ±  7%      -7.5        7.23 ± 12%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     14.77 ±  7%      -7.5        7.24 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     14.75 ±  7%      -7.5        7.22 ± 12%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.75 ±  7%      -7.5        7.22 ± 12%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     14.73 ±  7%      -7.5        7.21 ± 12%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
     14.72 ±  7%      -7.5        7.20 ± 12%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_prepare
     13.76 ±  8%      -6.6        7.16 ± 12%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
     13.73 ±  8%      -6.6        7.14 ± 12%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.__dentry_kill.dput.__fput
      9.35 ± 12%      -5.2        4.11 ± 19%  perf-profile.calltrace.cycles-pp.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill.dput
      8.94 ± 11%      -5.0        3.95 ± 19%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill
      7.68 ± 14%      -4.3        3.36 ± 20%  perf-profile.calltrace.cycles-pp.lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      7.57 ± 14%      -4.3        3.27 ± 21%  perf-profile.calltrace.cycles-pp.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      6.27 ± 16%      -4.1        2.19 ± 31%  perf-profile.calltrace.cycles-pp.lock_page_lruvec_irqsave.release_pages.__pagevec_release.truncate_inode_pages_range.evict
      6.24 ± 17%      -4.1        2.16 ± 32%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.release_pages.__pagevec_release.truncate_inode_pages_range
      6.20 ± 17%      -4.1        2.14 ± 32%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.release_pages.__pagevec_release
      5.75 ± 18%      -3.7        2.04 ± 31%  perf-profile.calltrace.cycles-pp.lock_page_lruvec_irqsave.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru.pagecache_get_page
      5.71 ± 18%      -3.7        2.02 ± 31%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru
      5.67 ± 19%      -3.7        1.98 ± 32%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.lock_page_lruvec_irqsave.__pagevec_lru_add.lru_cache_add
      8.43 ±  3%      -3.3        5.13 ±  7%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      5.31 ±  4%      -2.3        3.03 ±  9%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      7.29 ±  4%      -2.0        5.27 ±  2%  perf-profile.calltrace.cycles-pp.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      4.69 ±  3%      -1.5        3.15 ±  4%  perf-profile.calltrace.cycles-pp.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      3.36 ±  4%      -1.2        2.19 ±  5%  perf-profile.calltrace.cycles-pp.__set_page_dirty.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor.iomap_apply
      0.94 ±  6%      -0.9        0.00        perf-profile.calltrace.cycles-pp.destroy_inode.__dentry_kill.dput.__fput.task_work_run
      2.18 ±  5%      -0.9        1.25 ±  9%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      0.93 ±  6%      -0.9        0.00        perf-profile.calltrace.cycles-pp.xfs_inode_mark_reclaimable.destroy_inode.__dentry_kill.dput.__fput
      0.92 ±  6%      -0.9        0.00        perf-profile.calltrace.cycles-pp.xfs_inactive.xfs_inode_mark_reclaimable.destroy_inode.__dentry_kill.dput
      2.18 ±  4%      -0.9        1.30 ±  8%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.__set_page_dirty.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor
      2.20 ±  4%      -0.9        1.34 ±  8%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      2.10 ±  4%      -0.9        1.25 ±  8%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      0.77 ±  6%      -0.8        0.00        perf-profile.calltrace.cycles-pp.xfs_inactive_ifree.xfs_inactive.xfs_inode_mark_reclaimable.destroy_inode.__dentry_kill
      2.24 ±  2%      -0.8        1.47 ±  5%  perf-profile.calltrace.cycles-pp.truncate_cleanup_page.truncate_inode_pages_range.evict.__dentry_kill.dput
      2.07 ±  3%      -0.7        1.34 ±  5%  perf-profile.calltrace.cycles-pp.__cancel_dirty_page.truncate_cleanup_page.truncate_inode_pages_range.evict.__dentry_kill
      1.84 ±  3%      -0.7        1.17 ±  6%  perf-profile.calltrace.cycles-pp.account_page_cleaned.__cancel_dirty_page.truncate_cleanup_page.truncate_inode_pages_range.evict
      3.27 ±  8%      -0.7        2.62 ±  4%  perf-profile.calltrace.cycles-pp.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
      0.64 ±  5%      -0.6        0.00        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.release_pages.__pagevec_release.truncate_inode_pages_range.evict
      0.63 ±  6%      -0.6        0.00        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.unaccount_page_cache_page.delete_from_page_cache_batch.truncate_inode_pages_range
      1.56 ±  4%      -0.6        0.95 ±  8%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.account_page_cleaned.__cancel_dirty_page.truncate_cleanup_page.truncate_inode_pages_range
      1.40 ±  6%      -0.6        0.81 ±  9%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.__set_page_dirty.__set_page_dirty_nobuffers.iomap_write_end
      0.80 ±  7%      -0.6        0.21 ±122%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru
      0.58 ±  7%      -0.6        0.00        perf-profile.calltrace.cycles-pp.lock_page_memcg.__set_page_dirty_nobuffers.iomap_write_end.iomap_write_actor.iomap_apply
      0.58 ±  5%      -0.6        0.00        perf-profile.calltrace.cycles-pp.page_counter_uncharge.uncharge_batch.mem_cgroup_uncharge_list.release_pages.__pagevec_release
      0.78 ±  4%      -0.6        0.20 ±122%  perf-profile.calltrace.cycles-pp.uncharge_batch.mem_cgroup_uncharge_list.release_pages.__pagevec_release.truncate_inode_pages_range
      0.57 ±  7%      -0.6        0.00        perf-profile.calltrace.cycles-pp.xfs_ifree.xfs_inactive_ifree.xfs_inactive.xfs_inode_mark_reclaimable.destroy_inode
      0.88 ±  6%      -0.6        0.32 ± 81%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__mod_lruvec_page_state.account_page_cleaned.__cancel_dirty_page
      1.26 ±  6%      -0.5        0.71 ± 10%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__mod_lruvec_page_state.__set_page_dirty.__set_page_dirty_nobuffers
      0.58 ±  7%      -0.5        0.05 ±299%  perf-profile.calltrace.cycles-pp.down_write.xfs_ilock.xfs_file_buffered_write.new_sync_write.vfs_write
      1.28 ±  5%      -0.5        0.76 ± 10%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      0.91 ±  6%      -0.5        0.40 ± 66%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru.pagecache_get_page
      2.20 ±  9%      -0.5        1.69 ±  2%  perf-profile.calltrace.cycles-pp.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
      0.50 ± 34%      -0.5        0.00        perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.26 ±  4%      -0.5        0.76 ±  6%  perf-profile.calltrace.cycles-pp.mem_cgroup_uncharge_list.release_pages.__pagevec_release.truncate_inode_pages_range.evict
      0.49 ± 33%      -0.5        0.00        perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.release_pages.__pagevec_release.truncate_inode_pages_range
      1.15 ±  5%      -0.5        0.66 ± 11%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__mod_lruvec_page_state.__add_to_page_cache_locked.add_to_page_cache_lru
      1.65 ±  3%      -0.5        1.18 ±  4%  perf-profile.calltrace.cycles-pp.delete_from_page_cache_batch.truncate_inode_pages_range.evict.__dentry_kill.dput
      1.00 ±  6%      -0.5        0.53 ± 34%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.account_page_cleaned.__cancel_dirty_page.truncate_cleanup_page
      0.44 ± 50%      -0.4        0.00        perf-profile.calltrace.cycles-pp.common_file_perm.security_file_permission.vfs_write.ksys_write.do_syscall_64
      1.19 ± 28%      -0.4        0.76 ±  4%  perf-profile.calltrace.cycles-pp.__entry_text_start.write
      0.43 ± 50%      -0.4        0.00        perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      2.71 ±  7%      -0.4        2.32 ±  3%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.05 ±  4%      -0.4        0.68 ±  8%  perf-profile.calltrace.cycles-pp.unaccount_page_cache_page.delete_from_page_cache_batch.truncate_inode_pages_range.evict.__dentry_kill
      0.37 ± 85%      -0.4        0.00        perf-profile.calltrace.cycles-pp.xfs_vn_update_time.file_update_time.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write
      0.97 ±  5%      -0.4        0.61 ±  8%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.unaccount_page_cache_page.delete_from_page_cache_batch.truncate_inode_pages_range.evict
      0.75 ±101%      -0.3        0.40 ± 65%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      2.05 ±  8%      -0.3        1.71 ±  3%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      0.33 ± 82%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__get_user_nocheck_1.iov_iter_fault_in_readable.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.32 ± 81%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__mod_lruvec_page_state.unaccount_page_cache_page.delete_from_page_cache_batch
      0.32 ± 81%      -0.3        0.00        perf-profile.calltrace.cycles-pp.xfs_buffered_write_iomap_end.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write.new_sync_write
      1.05 ± 12%      -0.3        0.73 ±  5%  perf-profile.calltrace.cycles-pp.file_update_time.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write
      1.75 ±  7%      -0.3        1.45 ±  3%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.61 ±  9%      -0.3        0.31 ± 81%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.80 ± 98%      -0.3        0.54 ± 34%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      1.56 ±  8%      -0.3        1.31 ±  3%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.42 ±  8%      -0.2        1.19 ±  3%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter_atomic.iomap_write_actor.iomap_apply
      0.22 ±122%      -0.2        0.00        perf-profile.calltrace.cycles-pp.xas_load.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      0.22 ±122%      -0.2        0.00        perf-profile.calltrace.cycles-pp.xfs_break_layouts.xfs_file_write_checks.xfs_file_buffered_write.new_sync_write.vfs_write
      0.85 ±  6%      -0.2        0.69 ±  4%  perf-profile.calltrace.cycles-pp.xfs_ilock.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      0.15 ±300%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.15 ±300%      -0.1        0.00        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.78 ±  6%      -0.1        0.64 ±  3%  perf-profile.calltrace.cycles-pp.iov_iter_fault_in_readable.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_write
      0.89 ±  6%      -0.1        0.75 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      0.72 ±  6%      -0.1        0.58 ±  4%  perf-profile.calltrace.cycles-pp.down_write.xfs_ilock.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write
      1.20 ±  4%      -0.1        1.08 ±  2%  perf-profile.calltrace.cycles-pp.memset_erms.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.69 ±  7%      -0.1        0.57 ±  4%  perf-profile.calltrace.cycles-pp.xfs_ilock.xfs_file_buffered_write.new_sync_write.vfs_write.ksys_write
      0.12 ±300%      -0.1        0.00        perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.11 ±299%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__softirqentry_text_start.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.11 ±200%      -0.1        0.00        perf-profile.calltrace.cycles-pp.xfs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.67 ±  7%      -0.1        0.57 ±  3%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      0.10 ±200%      -0.1        0.00        perf-profile.calltrace.cycles-pp.uncharge_page.mem_cgroup_uncharge_list.release_pages.__pagevec_release.truncate_inode_pages_range
      0.10 ±200%      -0.1        0.00        perf-profile.calltrace.cycles-pp.lru_add_drain.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill
      0.10 ±200%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__pagevec_lru_add.lru_add_drain_cpu.lru_add_drain.__pagevec_release.truncate_inode_pages_range
      0.10 ±200%      -0.1        0.00        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.__pagevec_release.truncate_inode_pages_range.evict
      0.08 ±300%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.69 ±  6%      -0.1        0.61 ±  4%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.07 ±300%      -0.1        0.00        perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.06 ±300%      -0.1        0.00        perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.06 ±300%      -0.1        0.00        perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.06 ±300%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_vn_update_time.file_update_time.xfs_file_write_checks.xfs_file_buffered_write
      0.06 ±299%      -0.1        0.00        perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_vn_update_time.file_update_time.xfs_file_write_checks
      0.06 ±300%      -0.1        0.00        perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.90 ± 14%      +0.0        0.92 ± 11%  perf-profile.calltrace.cycles-pp.xfs_generic_create.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.88 ± 14%      +0.0        0.91 ± 11%  perf-profile.calltrace.cycles-pp.xfs_create.xfs_generic_create.path_openat.do_filp_open.do_sys_openat2
      0.90 ±  9%      +0.1        1.00 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.69 ±  8%      +0.1        0.79 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      0.05 ±300%      +0.1        0.17 ±152%  perf-profile.calltrace.cycles-pp.xfs_dialloc.xfs_create.xfs_generic_create.path_openat.do_filp_open
      0.53 ± 39%      +0.1        0.67 ± 12%  perf-profile.calltrace.cycles-pp.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.47 ± 54%      +0.2        0.66 ± 13%  perf-profile.calltrace.cycles-pp.xfs_vn_unlink.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.47 ± 54%      +0.2        0.66 ± 12%  perf-profile.calltrace.cycles-pp.xfs_remove.xfs_vn_unlink.vfs_unlink.do_unlinkat.do_syscall_64
      0.00            +0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.xfs_ifree.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work
      0.00            +0.8        0.77 ±  5%  perf-profile.calltrace.cycles-pp.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread
      0.00            +0.8        0.84 ±  4%  perf-profile.calltrace.cycles-pp.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread.kthread
      0.00            +0.9        0.85 ±  4%  perf-profile.calltrace.cycles-pp.xfs_inodegc_worker.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.9        0.90 ±  5%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.9        0.91 ±  4%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.00            +0.9        0.94 ±  5%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.00            +0.9        0.94 ±  5%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.00           +14.7       14.74 ±  7%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      2.11 ± 10%     +14.8       16.88 ±  6%  perf-profile.calltrace.cycles-pp.creat64
      2.10 ± 10%     +14.8       16.87 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      2.09 ± 10%     +14.8       16.86 ±  6%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      2.10 ± 10%     +14.8       16.86 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      2.08 ± 10%     +14.8       16.86 ±  6%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      2.06 ± 10%     +14.8       16.84 ±  6%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.05 ± 10%     +14.8       16.83 ±  6%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.82 ±  9%     +14.8       15.64 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.59 ±  8%     +15.0       15.62 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.55 ±  9%     +15.2       16.71 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      2.28 ± 10%     +15.2       17.51 ±  4%  perf-profile.calltrace.cycles-pp.unlink
      2.26 ± 10%     +15.2       17.49 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      2.26 ± 10%     +15.2       17.49 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      2.24 ± 10%     +15.2       17.47 ±  4%  perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
     51.46 ±  3%     -14.6       36.84 ±  2%  perf-profile.children.cycles-pp.write
     48.32 ±  3%     -14.1       34.26 ±  2%  perf-profile.children.cycles-pp.ksys_write
     47.50 ±  3%     -13.9       33.59 ±  2%  perf-profile.children.cycles-pp.vfs_write
     45.48 ±  3%     -13.6       31.85 ±  3%  perf-profile.children.cycles-pp.new_sync_write
     44.63 ±  3%     -13.5       31.16 ±  3%  perf-profile.children.cycles-pp.xfs_file_buffered_write
     40.66 ±  3%     -12.6       28.04 ±  3%  perf-profile.children.cycles-pp.iomap_file_buffered_write
     40.50 ±  3%     -12.6       27.90 ±  3%  perf-profile.children.cycles-pp.iomap_apply
     35.53 ±  3%     -11.6       23.94 ±  4%  perf-profile.children.cycles-pp.iomap_write_actor
     24.03 ±  5%      -8.8       15.24 ±  6%  perf-profile.children.cycles-pp.iomap_write_begin
     28.83 ±  8%      -8.7       20.10 ±  8%  perf-profile.children.cycles-pp.do_idle
     28.83 ±  8%      -8.7       20.10 ±  8%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     28.83 ±  8%      -8.7       20.10 ±  8%  perf-profile.children.cycles-pp.cpu_startup_entry
     28.48 ±  8%      -8.6       19.86 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter_state
     28.49 ±  8%      -8.6       19.86 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter
     28.47 ±  8%      -8.6       19.87 ±  8%  perf-profile.children.cycles-pp.start_secondary
     27.52 ±  8%      -8.3       19.18 ±  8%  perf-profile.children.cycles-pp.intel_idle
     19.34 ±  6%      -8.2       11.17 ±  9%  perf-profile.children.cycles-pp.grab_cache_page_write_begin
     19.19 ±  6%      -8.1       11.05 ±  9%  perf-profile.children.cycles-pp.pagecache_get_page
     12.48 ± 17%      -8.1        4.39 ± 31%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     12.61 ± 17%      -8.1        4.53 ± 30%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     12.40 ± 17%      -8.0        4.35 ± 31%  perf-profile.children.cycles-pp.lock_page_lruvec_irqsave
     16.18 ±  8%      -7.6        8.54 ± 12%  perf-profile.children.cycles-pp.add_to_page_cache_lru
     15.16 ±  7%      -7.6        7.56 ± 11%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     15.02 ±  7%      -7.6        7.45 ± 12%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
     14.78 ±  7%      -7.5        7.24 ± 12%  perf-profile.children.cycles-pp.__close
     14.75 ±  7%      -7.5        7.23 ± 12%  perf-profile.children.cycles-pp.dput
     14.75 ±  7%      -7.5        7.22 ± 12%  perf-profile.children.cycles-pp.task_work_run
     14.75 ±  7%      -7.5        7.22 ± 12%  perf-profile.children.cycles-pp.__fput
     14.72 ±  7%      -7.5        7.20 ± 12%  perf-profile.children.cycles-pp.__dentry_kill
     13.76 ±  8%      -6.6        7.16 ± 12%  perf-profile.children.cycles-pp.evict
     13.73 ±  8%      -6.6        7.15 ± 12%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      9.35 ± 12%      -5.2        4.11 ± 19%  perf-profile.children.cycles-pp.__pagevec_release
      9.07 ± 11%      -5.0        4.04 ± 18%  perf-profile.children.cycles-pp.release_pages
      7.98 ± 15%      -4.6        3.42 ± 21%  perf-profile.children.cycles-pp.__pagevec_lru_add
      7.69 ± 14%      -4.3        3.36 ± 20%  perf-profile.children.cycles-pp.lru_cache_add
      8.44 ±  3%      -3.3        5.14 ±  7%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      6.92 ±  4%      -2.7        4.21 ±  8%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      5.91 ±  5%      -2.4        3.50 ±  9%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      5.32 ±  4%      -2.3        3.04 ±  9%  perf-profile.children.cycles-pp.mem_cgroup_charge
      5.16 ±  5%      -2.2        2.97 ± 11%  perf-profile.children.cycles-pp.__mod_memcg_state
      7.32 ±  4%      -2.0        5.30 ±  2%  perf-profile.children.cycles-pp.iomap_write_end
      4.73 ±  3%      -1.5        3.18 ±  4%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      3.38 ±  4%      -1.2        2.20 ±  5%  perf-profile.children.cycles-pp.__set_page_dirty
      0.94 ±  6%      -0.9        0.00        perf-profile.children.cycles-pp.destroy_inode
      2.19 ±  4%      -0.9        1.26 ±  9%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.93 ±  6%      -0.9        0.00        perf-profile.children.cycles-pp.xfs_inode_mark_reclaimable
      2.11 ±  4%      -0.9        1.25 ±  8%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      2.24 ±  2%      -0.8        1.48 ±  5%  perf-profile.children.cycles-pp.truncate_cleanup_page
      2.07 ±  3%      -0.7        1.35 ±  5%  perf-profile.children.cycles-pp.__cancel_dirty_page
      4.46 ±  7%      -0.7        3.78 ±  3%  perf-profile.children.cycles-pp.iomap_set_range_uptodate
      1.86 ±  3%      -0.7        1.18 ±  6%  perf-profile.children.cycles-pp.account_page_cleaned
      3.36 ±  8%      -0.7        2.69 ±  4%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      2.23 ±  9%      -0.5        1.72 ±  2%  perf-profile.children.cycles-pp.xfs_file_write_checks
      1.26 ±  4%      -0.5        0.77 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      1.66 ±  3%      -0.5        1.18 ±  4%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      1.50 ± 83%      -0.4        1.08 ±  7%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.40 ± 87%      -0.4        1.00 ±  6%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.06 ±  5%      -0.4        0.68 ±  7%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      2.06 ±  8%      -0.3        1.72 ±  3%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      1.06 ± 12%      -0.3        0.74 ±  4%  perf-profile.children.cycles-pp.file_update_time
      1.59 ±  6%      -0.3        1.29 ±  4%  perf-profile.children.cycles-pp.xfs_ilock
      0.78 ±  4%      -0.3        0.49 ±  5%  perf-profile.children.cycles-pp.uncharge_batch
      1.57 ±  8%      -0.3        1.32 ±  3%  perf-profile.children.cycles-pp.copyin
      0.40 ± 18%      -0.3        0.14 ± 28%  perf-profile.children.cycles-pp.lru_add_drain
      0.40 ± 18%      -0.3        0.14 ± 29%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      1.51 ±  8%      -0.2        1.27 ±  3%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      1.37 ±  6%      -0.2        1.12 ±  4%  perf-profile.children.cycles-pp.down_write
      0.92 ± 87%      -0.2        0.68 ±  6%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.91 ± 88%      -0.2        0.67 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.56 ± 20%      -0.2        0.32 ± 12%  perf-profile.children.cycles-pp.xfs_vn_update_time
      0.61 ±  5%      -0.2        0.39 ±  4%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.64 ±  7%      -0.2        0.43 ±  8%  perf-profile.children.cycles-pp.lock_page_memcg
      0.46 ±  7%      -0.2        0.27 ± 11%  perf-profile.children.cycles-pp.uncharge_page
      0.91 ±  6%      -0.2        0.74 ±  3%  perf-profile.children.cycles-pp.xfs_iunlock
      0.82 ±  8%      -0.2        0.66 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.92 ±  8%      -0.2        0.77 ±  4%  perf-profile.children.cycles-pp.__entry_text_start
      0.46 ±  5%      -0.2        0.31 ±  4%  perf-profile.children.cycles-pp.page_counter_cancel
      0.58 ±104%      -0.2        0.43 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.81 ±  6%      -0.1        0.66 ±  3%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.49 ±118%      -0.1        0.35 ±  6%  perf-profile.children.cycles-pp.tick_sched_timer
      0.91 ±  6%      -0.1        0.76 ±  2%  perf-profile.children.cycles-pp.__alloc_pages
      0.37 ±  6%      -0.1        0.23 ±  8%  perf-profile.children.cycles-pp.__count_memcg_events
      0.45 ±119%      -0.1        0.32 ±  6%  perf-profile.children.cycles-pp.tick_sched_handle
      0.45 ±120%      -0.1        0.31 ±  7%  perf-profile.children.cycles-pp.update_process_times
      0.38 ± 89%      -0.1        0.24 ±  6%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.55 ±  6%      -0.1        0.41 ±  5%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_end
      0.36 ± 10%      -0.1        0.23 ± 10%  perf-profile.children.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.35 ± 91%      -0.1        0.22 ±  5%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.36 ±  6%      -0.1        0.23 ± 23%  perf-profile.children.cycles-pp.start_kernel
      1.23 ±  4%      -0.1        1.10 ±  2%  perf-profile.children.cycles-pp.memset_erms
      0.53 ±  6%      -0.1        0.40 ±  9%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.42 ± 14%      -0.1        0.30 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock
      0.40 ±  6%      -0.1        0.28 ±  4%  perf-profile.children.cycles-pp.try_charge_memcg
      0.52 ±  7%      -0.1        0.40 ±  4%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.34 ±  5%      -0.1        0.22 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.64 ±  6%      -0.1        0.52 ±  4%  perf-profile.children.cycles-pp.up_write
      0.60 ±  7%      -0.1        0.49 ±  4%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.86 ±  6%      -0.1        0.74 ±  4%  perf-profile.children.cycles-pp.___might_sleep
      0.75 ±  8%      -0.1        0.64 ±  4%  perf-profile.children.cycles-pp.xas_load
      0.68 ±  7%      -0.1        0.58 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.63 ±  9%      -0.1        0.52 ±  5%  perf-profile.children.cycles-pp.__fdget_pos
      0.68 ±  8%      -0.1        0.58 ±  3%  perf-profile.children.cycles-pp.xas_store
      0.55 ±  8%      -0.1        0.45 ±  6%  perf-profile.children.cycles-pp.__fget_light
      0.49 ±  5%      -0.1        0.39 ±  4%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.19 ± 40%      -0.1        0.09 ± 11%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.22 ± 17%      -0.1        0.12 ± 18%  perf-profile.children.cycles-pp.xfs_trans_alloc
      0.28 ±  5%      -0.1        0.19 ±  6%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.31 ±126%      -0.1        0.22 ±  7%  perf-profile.children.cycles-pp.scheduler_tick
      0.09 ± 11%      -0.1        0.00        perf-profile.children.cycles-pp.xfs_itruncate_extents_flags
      0.51 ±  9%      -0.1        0.42 ±  4%  perf-profile.children.cycles-pp.xfs_break_layouts
      0.20 ±  5%      -0.1        0.12 ±  9%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.18 ± 20%      -0.1        0.10 ± 20%  perf-profile.children.cycles-pp.xfs_log_reserve
      0.19 ± 19%      -0.1        0.11 ± 18%  perf-profile.children.cycles-pp.xfs_trans_reserve
      0.38 ±  7%      -0.1        0.30 ±  4%  perf-profile.children.cycles-pp.find_lock_entries
      0.27 ± 67%      -0.1        0.19 ± 14%  perf-profile.children.cycles-pp.ktime_get
      0.14 ±  7%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.xfs_inactive_truncate
      0.70 ±  6%      -0.1        0.62 ±  4%  perf-profile.children.cycles-pp.security_file_permission
      0.92 ±  6%      -0.1        0.84 ±  4%  perf-profile.children.cycles-pp.xfs_inactive
      0.36 ±  7%      -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.unlock_page
      0.43 ±  8%      -0.1        0.35 ±  6%  perf-profile.children.cycles-pp.__cond_resched
      0.46 ± 11%      -0.1        0.39 ± 10%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      0.39 ±  5%      -0.1        0.31 ±  4%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.25 ± 62%      -0.1        0.18 ± 14%  perf-profile.children.cycles-pp.clockevents_program_event
      0.10 ± 24%      -0.1        0.03 ±103%  perf-profile.children.cycles-pp.xlog_grant_add_space
      0.55 ±  6%      -0.1        0.48 ±  5%  perf-profile.children.cycles-pp.common_file_perm
      0.46 ± 10%      -0.1        0.39 ±  6%  perf-profile.children.cycles-pp.xfs_file_write_iter
      0.57 ±  7%      -0.1        0.50 ±  5%  perf-profile.children.cycles-pp.xfs_ifree
      0.46 ±  7%      -0.1        0.39 ±  2%  perf-profile.children.cycles-pp.__might_sleep
      0.22 ±  7%      -0.1        0.15 ±  7%  perf-profile.children.cycles-pp.__unlock_page_memcg
      0.29 ±  9%      -0.1        0.22 ± 19%  perf-profile.children.cycles-pp.xfs_bmbt_to_iomap
      0.32 ± 10%      -0.1        0.25 ± 11%  perf-profile.children.cycles-pp.xfs_buf_read_map
      0.17 ± 70%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.rcu_core
      0.28 ± 11%      -0.1        0.23 ± 12%  perf-profile.children.cycles-pp.xfs_buf_find
      0.06 ± 14%      -0.1        0.00        perf-profile.children.cycles-pp.xfs_defer_finish
      0.30 ± 11%      -0.1        0.24 ± 11%  perf-profile.children.cycles-pp.xfs_buf_get_map
      0.09 ± 20%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.xfs_log_ticket_ungrant
      1.09 ± 12%      -0.1        1.04 ±  6%  perf-profile.children.cycles-pp.__xfs_trans_commit
      0.06 ± 11%      -0.1        0.00        perf-profile.children.cycles-pp.xfs_defer_trans_roll
      0.30 ±  9%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.xfs_break_leased_layouts
      0.05 ± 12%      -0.1        0.00        perf-profile.children.cycles-pp.xfs_trans_roll
      0.05 ±  8%      -0.1        0.00        perf-profile.children.cycles-pp.generic_file_write_iter
      0.20 ±  9%      -0.1        0.14 ± 10%  perf-profile.children.cycles-pp.xfs_read_agi
      0.05 ± 36%      -0.1        0.00        perf-profile.children.cycles-pp.dequeue_task_fair
      0.30 ±  8%      -0.1        0.25 ±  4%  perf-profile.children.cycles-pp.generic_write_checks
      0.30 ±  7%      -0.0        0.26 ±  4%  perf-profile.children.cycles-pp.current_time
      0.18 ±  8%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.xfs_iunlink_remove
      1.07 ± 12%      -0.0        1.02 ±  6%  perf-profile.children.cycles-pp.xlog_cil_commit
      0.33 ±  8%      -0.0        0.28 ±  5%  perf-profile.children.cycles-pp.rmqueue
      0.17 ± 10%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.06 ± 11%      -0.0        0.01 ±200%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.10 ±114%      -0.0        0.05 ± 34%  perf-profile.children.cycles-pp.rebalance_domains
      0.13 ± 66%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.rcu_do_batch
      0.25 ±  7%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.24 ±  7%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.node_dirty_ok
      0.07 ± 11%      -0.0        0.02 ±100%  perf-profile.children.cycles-pp.schedule_idle
      0.14 ± 76%      -0.0        0.10 ± 12%  perf-profile.children.cycles-pp.menu_select
      0.28 ± 10%      -0.0        0.24 ±  4%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.17 ± 16%      -0.0        0.12 ± 13%  perf-profile.children.cycles-pp.xfs_dir_createname
      0.16 ±  9%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.06 ± 13%      -0.0        0.02 ±152%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.04 ±134%      -0.0        0.00        perf-profile.children.cycles-pp.update_rq_clock
      0.12 ± 51%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.kmem_cache_free
      0.16 ± 16%      -0.0        0.12 ± 12%  perf-profile.children.cycles-pp.xfs_dir2_node_addname
      0.04 ± 52%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.PageHuge
      0.04 ± 66%      -0.0        0.00        perf-profile.children.cycles-pp.dequeue_entity
      0.24 ±  8%      -0.0        0.21 ±  5%  perf-profile.children.cycles-pp.free_unref_page_list
      0.06 ± 12%      -0.0        0.02 ±122%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      0.05 ± 35%      -0.0        0.02 ±152%  perf-profile.children.cycles-pp.balance_dirty_pages
      0.04 ± 65%      -0.0        0.00        perf-profile.children.cycles-pp.__generic_file_write_iter
      0.18 ±131%      -0.0        0.15 ±  9%  perf-profile.children.cycles-pp.task_tick_fair
      0.15 ± 13%      -0.0        0.11 ± 10%  perf-profile.children.cycles-pp.try_to_wake_up
      0.18 ± 11%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.page_mapping
      0.19 ± 12%      -0.0        0.16 ±  9%  perf-profile.children.cycles-pp.rcu_all_qs
      0.16 ±  7%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.alloc_pages
      0.14 ± 11%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.26 ± 18%      -0.0        0.23 ± 11%  perf-profile.children.cycles-pp.xfs_da3_node_lookup_int
      0.10 ±  8%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.xfs_buf_lock
      0.10 ±  7%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.down
      0.10 ±  8%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.__down
      0.14 ±  9%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.aa_file_perm
      0.29 ±  8%      -0.0        0.26 ±  5%  perf-profile.children.cycles-pp.xas_start
      0.16 ±  8%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.10 ± 16%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.xfs_dir2_node_addname_int
      0.15 ± 12%      -0.0        0.12 ± 10%  perf-profile.children.cycles-pp.xfs_btree_lookup
      0.14 ±  6%      -0.0        0.11 ±  5%  perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.03 ±189%      -0.0        0.00        perf-profile.children.cycles-pp.update_curr
      0.20 ± 17%      -0.0        0.17 ± 13%  perf-profile.children.cycles-pp.xfs_da_read_buf
      0.05 ± 37%      -0.0        0.02 ±100%  perf-profile.children.cycles-pp.vfprintf
      0.03 ±253%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.10 ± 11%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.xfs_buf_unlock
      0.29 ±  8%      -0.0        0.26 ±  5%  perf-profile.children.cycles-pp.xfs_difree_inobt
      0.09 ±  7%      -0.0        0.06 ± 12%  perf-profile.children.cycles-pp.schedule_timeout
      0.11 ± 11%      -0.0        0.08 ±  9%  perf-profile.children.cycles-pp.xfs_buf_item_release
      0.10 ± 41%      -0.0        0.07 ± 13%  perf-profile.children.cycles-pp.xfs_get_extsz_hint
      0.03 ±100%      -0.0        0.00        perf-profile.children.cycles-pp.enqueue_entity
      0.12 ±  7%      -0.0        0.09 ±  8%  perf-profile.children.cycles-pp.__list_add_valid
      0.10 ± 11%      -0.0        0.08 ± 14%  perf-profile.children.cycles-pp.xfs_btree_lookup_get_block
      0.02 ±184%      -0.0        0.00        perf-profile.children.cycles-pp.sched_clock_cpu
      0.05 ± 34%      -0.0        0.02 ±100%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.10 ± 12%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.up
      0.04 ± 66%      -0.0        0.02 ±152%  perf-profile.children.cycles-pp.xfs_inobt_irec_to_allocmask
      0.15 ±  8%      -0.0        0.13 ±  7%  perf-profile.children.cycles-pp.xas_init_marks
      0.12 ±  8%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.xas_create
      0.13 ± 92%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.update_load_avg
      0.35 ±  8%      -0.0        0.33 ±  4%  perf-profile.children.cycles-pp.xfs_iext_lookup_extent
      0.11 ± 15%      -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.rwsem_wake
      0.07 ±  5%      -0.0        0.04 ± 33%  perf-profile.children.cycles-pp.xas_alloc
      0.05 ± 34%      -0.0        0.02 ±100%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.06 ±  9%      -0.0        0.04 ± 65%  perf-profile.children.cycles-pp.__x64_sys_write
      0.03 ±253%      -0.0        0.01 ±200%  perf-profile.children.cycles-pp.update_blocked_averages
      0.12 ±  5%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.xas_clear_mark
      0.02 ±234%      -0.0        0.00        perf-profile.children.cycles-pp._raw_spin_trylock
      0.06 ± 15%      -0.0        0.04 ± 50%  perf-profile.children.cycles-pp.fprintf
      0.15 ± 10%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.file_modified
      0.12 ±  8%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.09 ± 11%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.xas_find
      0.10 ± 10%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.12 ± 11%      -0.0        0.10 ± 17%  perf-profile.children.cycles-pp.xfs_vn_lookup
      0.02 ±176%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.06 ± 17%      -0.0        0.04 ± 50%  perf-profile.children.cycles-pp.xfs_perag_get
      0.09 ± 10%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.xfs_btree_read_buf_block
      0.11 ± 11%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.timestamp_truncate
      0.06 ± 12%      -0.0        0.04 ± 65%  perf-profile.children.cycles-pp.xfs_mod_fdblocks
      0.05 ± 34%      -0.0        0.03 ± 81%  perf-profile.children.cycles-pp.iov_iter_init
      0.15 ±  8%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.__xa_set_mark
      0.11 ± 12%      -0.0        0.09 ± 16%  perf-profile.children.cycles-pp.xfs_lookup
      0.08 ± 11%      -0.0        0.06 ±  4%  perf-profile.children.cycles-pp.node_page_state
      0.08 ± 15%      -0.0        0.06 ± 12%  perf-profile.children.cycles-pp.wake_up_q
      0.12 ± 16%      -0.0        0.11 ± 11%  perf-profile.children.cycles-pp.xfs_da3_node_read
      0.10 ±  9%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.iomap_page_create
      0.11 ± 13%      -0.0        0.09 ± 16%  perf-profile.children.cycles-pp.xfs_dir_lookup
      0.02 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.12 ± 11%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.09 ± 15%      -0.0        0.07 ± 18%  perf-profile.children.cycles-pp.xfs_dir2_node_lookup
      0.08 ± 10%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.page_cache_free_page
      0.03 ±100%      -0.0        0.01 ±200%  perf-profile.children.cycles-pp.memcg_check_events
      0.02 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.calc_global_load_tick
      0.26 ± 22%      -0.0        0.24 ± 13%  perf-profile.children.cycles-pp.xfs_dir_removename
      0.12 ± 14%      -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.xfs_bmapi_reserve_delalloc
      0.08 ±  7%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.28 ±  8%      -0.0        0.27 ± 12%  perf-profile.children.cycles-pp.xfs_errortag_test
      0.38 ±  7%      -0.0        0.36 ±  6%  perf-profile.children.cycles-pp.xfs_difree
      0.15 ±  7%      -0.0        0.14 ±  9%  perf-profile.children.cycles-pp.xfs_iread_extents
      0.09 ± 14%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.write@plt
      0.06 ± 15%      -0.0        0.05 ± 34%  perf-profile.children.cycles-pp.xfs_bmap_add_extent_hole_delay
      0.06 ± 12%      -0.0        0.04 ± 51%  perf-profile.children.cycles-pp.xfs_buf_item_init
      0.05 ± 33%      -0.0        0.03 ± 82%  perf-profile.children.cycles-pp.xas_set_mark
      0.02 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.03 ±103%      -0.0        0.02 ±152%  perf-profile.children.cycles-pp.xfs_dir3_data_read
      0.24 ± 22%      -0.0        0.23 ± 13%  perf-profile.children.cycles-pp.xfs_dir2_node_removename
      0.08 ± 10%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.xas_find_conflict
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.native_irq_return_iret
      0.06 ± 15%      -0.0        0.05 ± 34%  perf-profile.children.cycles-pp.xfs_isilocked
      0.04 ± 65%      -0.0        0.02 ±123%  perf-profile.children.cycles-pp.xfs_init_new_inode
      0.13 ± 13%      -0.0        0.11 ±  9%  perf-profile.children.cycles-pp._xfs_trans_bjoin
      0.11 ± 11%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.xa_get_order
      0.01 ±206%      -0.0        0.00        perf-profile.children.cycles-pp.mod_objcg_state
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.07 ± 10%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.unlock_page_memcg
      0.07 ± 12%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.times
      0.11 ± 13%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.file_remove_privs
      0.10 ± 10%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_dabuf_map
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.native_sched_clock
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.08 ±  9%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.08 ±  7%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.wait_for_stable_page
      0.03 ± 82%      -0.0        0.02 ±122%  perf-profile.children.cycles-pp.dec_zone_page_state
      0.02 ±153%      -0.0        0.01 ±300%  perf-profile.children.cycles-pp.__x64_sys_times
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.__update_load_avg_se
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.hrtimer_active
      0.07 ± 14%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_trans_log_inode
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.iomap_adjust_read_range
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.tick_nohz_next_event
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.08 ± 10%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.rw_verify_area
      0.11 ± 22%      -0.0        0.10 ± 13%  perf-profile.children.cycles-pp.xfs_dir2_leafn_lookup_for_entry
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.update_irq_load_avg
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.irqtime_account_irq
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.read_tsc
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.irq_enter_rcu
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.note_gp_changes
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.tick_irq_enter
      0.02 ±158%      -0.0        0.01 ±200%  perf-profile.children.cycles-pp.xfs_verify_dir_ino
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.03 ± 82%      -0.0        0.02 ±100%  perf-profile.children.cycles-pp.xfs_buf_rele
      0.07 ± 13%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.workingset_update_node
      0.12 ± 25%      -0.0        0.11 ± 14%  perf-profile.children.cycles-pp.xfs_dir3_data_check
      0.02 ±152%      -0.0        0.01 ±200%  perf-profile.children.cycles-pp._xfs_buf_obj_cmp
      0.01 ±299%      -0.0        0.00        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.01 ±299%      -0.0        0.00        perf-profile.children.cycles-pp.xfs_trans_log_buf
      0.01 ±299%      -0.0        0.00        perf-profile.children.cycles-pp.free_pcp_prepare
      0.01 ±299%      -0.0        0.00        perf-profile.children.cycles-pp.xlog_space_left
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.down_read
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.trigger_load_balance
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.01 ±300%      -0.0        0.00        perf-profile.children.cycles-pp.generic_perform_write
      0.12 ± 25%      -0.0        0.11 ± 14%  perf-profile.children.cycles-pp.__xfs_dir3_data_check
      0.08 ± 25%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.xfs_dir2_leafn_remove
      0.06 ± 15%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.xfs_ialloc_read_agi
      0.09 ± 18%      -0.0        0.09 ± 11%  perf-profile.children.cycles-pp.xfs_inode_item_format
      0.02 ±152%      +0.0        0.02 ±152%  perf-profile.children.cycles-pp.xfs_next_bit
      0.77 ±  6%      +0.0        0.77 ±  5%  perf-profile.children.cycles-pp.xfs_inactive_ifree
      0.06 ± 13%      +0.0        0.06 ± 15%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.00            +0.0        0.01 ±299%  perf-profile.children.cycles-pp.xfs_verify_agino
      0.01 ±200%      +0.0        0.02 ±152%  perf-profile.children.cycles-pp.xfs_inode_item_format_data_fork
      0.00            +0.0        0.01 ±300%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.01 ±300%      +0.0        0.02 ±152%  perf-profile.children.cycles-pp.xfs_iextents_copy
      0.08 ±  8%      +0.0        0.09 ±  6%  perf-profile.children.cycles-pp.xfs_difree_finobt
      0.00            +0.0        0.02 ±152%  perf-profile.children.cycles-pp.xfs_buf_item_size
      0.00            +0.0        0.02 ±122%  perf-profile.children.cycles-pp.xfs_inobt_btrec_to_irec
      0.20 ±  8%      +0.0        0.23 ±  5%  perf-profile.children.cycles-pp.__schedule
      0.04 ±162%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.update_cfs_group
      0.90 ± 14%      +0.0        0.92 ± 11%  perf-profile.children.cycles-pp.xfs_generic_create
      0.88 ± 14%      +0.0        0.91 ± 11%  perf-profile.children.cycles-pp.xfs_create
      0.63 ± 12%      +0.0        0.66 ±  6%  perf-profile.children.cycles-pp.xlog_cil_insert_items
      0.03 ± 81%      +0.0        0.06 ± 10%  perf-profile.children.cycles-pp.xfs_iunlink_update_inode
      0.10 ± 13%      +0.0        0.13 ±  8%  perf-profile.children.cycles-pp.__xfs_btree_check_sblock
      0.06 ± 22%      +0.0        0.10 ± 12%  perf-profile.children.cycles-pp.xfs_iunlink
      0.01 ±200%      +0.0        0.05 ±  8%  perf-profile.children.cycles-pp.xfs_imap_to_bp
      0.14 ±  9%      +0.0        0.19 ±  5%  perf-profile.children.cycles-pp.schedule
      0.14 ± 12%      +0.1        0.20 ±  8%  perf-profile.children.cycles-pp.xfs_btree_increment
      0.18 ± 12%      +0.1        0.23 ±  5%  perf-profile.children.cycles-pp.disk_wrt
      0.16 ± 12%      +0.1        0.22 ±  8%  perf-profile.children.cycles-pp.xfs_btree_check_sblock
      0.14 ± 12%      +0.1        0.20 ±  9%  perf-profile.children.cycles-pp.xfs_btree_get_rec
      0.05 ±144%      +0.1        0.12 ±  5%  perf-profile.children.cycles-pp.load_balance
      0.04 ± 50%      +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.02 ±300%      +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.find_busiest_group
      0.02 ±300%      +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.29 ± 13%      +0.1        0.38 ±  9%  perf-profile.children.cycles-pp.xfs_inobt_get_rec
      0.58 ± 19%      +0.1        0.67 ± 12%  perf-profile.children.cycles-pp.vfs_unlink
      0.56 ± 20%      +0.1        0.66 ± 13%  perf-profile.children.cycles-pp.xfs_vn_unlink
      0.56 ± 20%      +0.1        0.66 ± 12%  perf-profile.children.cycles-pp.xfs_remove
      0.00            +0.1        0.10 ±  7%  perf-profile.children.cycles-pp.newidle_balance
      0.37 ± 16%      +0.1        0.48 ± 13%  perf-profile.children.cycles-pp.xfs_dialloc
      0.13 ± 14%      +0.1        0.25 ±  8%  perf-profile.children.cycles-pp.memcpy_erms
      0.54 ± 11%      +0.1        0.67 ±  9%  perf-profile.children.cycles-pp.xfs_check_agi_freecount
      0.16 ± 14%      +0.1        0.31 ±  7%  perf-profile.children.cycles-pp.xfs_buf_item_format_segment
      0.18 ± 15%      +0.1        0.32 ±  7%  perf-profile.children.cycles-pp.xfs_buf_item_format
      1.59 ±  8%      +0.2        1.79 ±  4%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.00            +0.9        0.85 ±  4%  perf-profile.children.cycles-pp.xfs_inodegc_worker
      0.00            +0.9        0.90 ±  5%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.9        0.91 ±  4%  perf-profile.children.cycles-pp.worker_thread
      0.01 ±299%      +0.9        0.94 ±  5%  perf-profile.children.cycles-pp.kthread
      0.01 ±299%      +0.9        0.94 ±  5%  perf-profile.children.cycles-pp.ret_from_fork
     68.55 ±  3%      +8.2       76.79 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     68.20 ±  3%      +8.3       76.48        perf-profile.children.cycles-pp.do_syscall_64
      2.12 ± 10%     +14.8       16.89 ±  6%  perf-profile.children.cycles-pp.creat64
      2.09 ± 10%     +14.8       16.86 ±  6%  perf-profile.children.cycles-pp.do_sys_openat2
      2.09 ± 10%     +14.8       16.86 ±  6%  perf-profile.children.cycles-pp.do_sys_open
      2.06 ± 10%     +14.8       16.84 ±  6%  perf-profile.children.cycles-pp.do_filp_open
      2.06 ± 10%     +14.8       16.84 ±  6%  perf-profile.children.cycles-pp.path_openat
      2.29 ± 11%     +15.2       17.52 ±  4%  perf-profile.children.cycles-pp.unlink
      2.24 ± 10%     +15.2       17.47 ±  4%  perf-profile.children.cycles-pp.do_unlinkat
      0.64 ± 10%     +29.7       30.38 ±  5%  perf-profile.children.cycles-pp.osq_lock
      2.37 ±  7%     +30.0       32.35 ±  5%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     27.52 ±  8%      -8.3       19.18 ±  8%  perf-profile.self.cycles-pp.intel_idle
     12.48 ± 17%      -8.1        4.39 ± 31%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      5.14 ±  6%      -2.2        2.95 ± 11%  perf-profile.self.cycles-pp.__mod_memcg_state
      2.16 ±  5%      -0.9        1.24 ±  9%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      2.23 ±  9%      -0.8        1.39 ±  8%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      4.42 ±  7%      -0.7        3.75 ±  3%  perf-profile.self.cycles-pp.iomap_set_range_uptodate
      1.32 ±  6%      -0.6        0.72 ± 12%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      1.01 ±  7%      -0.5        0.53 ± 14%  perf-profile.self.cycles-pp.mem_cgroup_charge
      0.97 ± 18%      -0.3        0.71 ±  5%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_begin
      1.50 ±  8%      -0.2        1.26 ±  3%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      1.07 ±  7%      -0.2        0.86 ±  3%  perf-profile.self.cycles-pp.iomap_apply
      0.62 ±  7%      -0.2        0.42 ±  8%  perf-profile.self.cycles-pp.lock_page_memcg
      0.46 ±  7%      -0.2        0.26 ± 12%  perf-profile.self.cycles-pp.uncharge_page
      1.14 ±  6%      -0.2        0.95 ±  4%  perf-profile.self.cycles-pp.pagecache_get_page
      0.62 ±  8%      -0.2        0.44 ±  8%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.81 ±  8%      -0.2        0.65 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.46 ±  5%      -0.2        0.30 ±  4%  perf-profile.self.cycles-pp.page_counter_cancel
      0.69 ±  8%      -0.2        0.54 ±  5%  perf-profile.self.cycles-pp.down_write
      0.37 ±  6%      -0.1        0.23 ±  8%  perf-profile.self.cycles-pp.__count_memcg_events
      0.74 ±  8%      -0.1        0.60 ±  5%  perf-profile.self.cycles-pp.write
      0.35 ± 10%      -0.1        0.22 ± 10%  perf-profile.self.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.42 ±  7%      -0.1        0.29 ±  5%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_end
      1.21 ±  5%      -0.1        1.09 ±  2%  perf-profile.self.cycles-pp.memset_erms
      0.51 ±  6%      -0.1        0.39 ±  7%  perf-profile.self.cycles-pp.__pagevec_lru_add
      0.59 ±  7%      -0.1        0.48 ±  4%  perf-profile.self.cycles-pp.xfs_file_buffered_write
      0.84 ±  6%      -0.1        0.73 ±  3%  perf-profile.self.cycles-pp.___might_sleep
      0.47 ±  6%      -0.1        0.36 ± 10%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      0.58 ±  8%      -0.1        0.47 ±  4%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.60 ±  7%      -0.1        0.50 ±  4%  perf-profile.self.cycles-pp.up_write
      0.54 ±  8%      -0.1        0.43 ±  5%  perf-profile.self.cycles-pp.iomap_write_end
      0.67 ±  5%      -0.1        0.57 ±  3%  perf-profile.self.cycles-pp.vfs_write
      0.43 ±  7%      -0.1        0.33 ±  3%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.50 ±  9%      -0.1        0.40 ±  5%  perf-profile.self.cycles-pp.iomap_write_actor
      0.63 ±  7%      -0.1        0.53 ±  3%  perf-profile.self.cycles-pp.iomap_write_begin
      0.52 ±  9%      -0.1        0.43 ±  6%  perf-profile.self.cycles-pp.__fget_light
      0.49 ±  8%      -0.1        0.40 ±  4%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.20 ±  6%      -0.1        0.11 ±  6%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.40 ±  7%      -0.1        0.32 ±  5%  perf-profile.self.cycles-pp.release_pages
      0.48 ±  8%      -0.1        0.40 ±  5%  perf-profile.self.cycles-pp.xas_load
      0.36 ±  8%      -0.1        0.28 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.25 ± 69%      -0.1        0.17 ± 15%  perf-profile.self.cycles-pp.ktime_get
      0.36 ±  8%      -0.1        0.28 ±  3%  perf-profile.self.cycles-pp.unlock_page
      0.38 ±  5%      -0.1        0.30 ±  5%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.10 ± 24%      -0.1        0.03 ±103%  perf-profile.self.cycles-pp.xlog_grant_add_space
      0.41 ±  7%      -0.1        0.34 ±  7%  perf-profile.self.cycles-pp.__entry_text_start
      0.23 ±  6%      -0.1        0.16 ±  5%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.42 ±  7%      -0.1        0.35 ±  2%  perf-profile.self.cycles-pp.__might_sleep
      0.30 ±  7%      -0.1        0.24 ±  3%  perf-profile.self.cycles-pp.find_lock_entries
      0.45 ± 10%      -0.1        0.39 ±  6%  perf-profile.self.cycles-pp.xfs_file_write_iter
      0.06 ± 18%      -0.1        0.00        perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.27 ±  9%      -0.1        0.21 ± 19%  perf-profile.self.cycles-pp.xfs_bmbt_to_iomap
      0.20 ±  8%      -0.1        0.14 ±  9%  perf-profile.self.cycles-pp.__unlock_page_memcg
      0.08 ± 22%      -0.1        0.02 ±153%  perf-profile.self.cycles-pp.xfs_log_ticket_ungrant
      0.31 ±  7%      -0.1        0.25 ±  6%  perf-profile.self.cycles-pp.__set_page_dirty_nobuffers
      0.29 ± 10%      -0.1        0.23 ±  7%  perf-profile.self.cycles-pp.new_sync_write
      0.28 ±  7%      -0.1        0.22 ±  5%  perf-profile.self.cycles-pp.__add_to_page_cache_locked
      0.25 ± 13%      -0.1        0.19 ±  6%  perf-profile.self.cycles-pp.xfs_ilock
      0.29 ±  7%      -0.1        0.23 ±  4%  perf-profile.self.cycles-pp.xfs_iunlock
      0.06 ± 16%      -0.1        0.01 ±300%  perf-profile.self.cycles-pp.write@plt
      0.29 ±  9%      -0.1        0.23 ±  4%  perf-profile.self.cycles-pp.xfs_break_leased_layouts
      0.36 ±  8%      -0.0        0.31 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.17 ± 10%      -0.0        0.12 ±  8%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.05 ± 34%      -0.0        0.01 ±299%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.24 ±  9%      -0.0        0.20 ±  5%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.28 ±  9%      -0.0        0.24 ±  5%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.11 ±  8%      -0.0        0.06 ± 12%  perf-profile.self.cycles-pp.uncharge_batch
      0.41 ±  5%      -0.0        0.37 ±  5%  perf-profile.self.cycles-pp.common_file_perm
      0.22 ± 11%      -0.0        0.18 ±  6%  perf-profile.self.cycles-pp.file_update_time
      0.19 ±  7%      -0.0        0.15 ±  6%  perf-profile.self.cycles-pp.ksys_write
      0.24 ±  7%      -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.29 ± 10%      -0.0        0.25 ±  5%  perf-profile.self.cycles-pp.xas_store
      0.22 ±  8%      -0.0        0.18 ±  6%  perf-profile.self.cycles-pp.__cond_resched
      0.07 ± 12%      -0.0        0.04 ± 65%  perf-profile.self.cycles-pp.lock_page_lruvec_irqsave
      0.17 ± 21%      -0.0        0.14 ±  6%  perf-profile.self.cycles-pp.iomap_file_buffered_write
      0.10 ± 70%      -0.0        0.06 ± 35%  perf-profile.self.cycles-pp.menu_select
      0.05 ± 37%      -0.0        0.02 ±152%  perf-profile.self.cycles-pp.xfs_perag_get
      0.16 ±  9%      -0.0        0.13 ±  6%  perf-profile.self.cycles-pp.node_dirty_ok
      0.04 ± 67%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.vfprintf
      0.19 ± 15%      -0.0        0.16 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock
      0.15 ±  6%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.__set_page_dirty
      0.14 ± 11%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.20 ±  6%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.iov_iter_fault_in_readable
      0.22 ±  6%      -0.0        0.18 ±  6%  perf-profile.self.cycles-pp.xfs_file_write_checks
      0.13 ± 11%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.try_charge_memcg
      0.17 ± 11%      -0.0        0.14 ±  7%  perf-profile.self.cycles-pp.page_mapping
      0.26 ±  9%      -0.0        0.23 ±  6%  perf-profile.self.cycles-pp.xas_start
      0.03 ±102%      -0.0        0.00        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.14 ± 11%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.11 ±  8%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.__list_add_valid
      0.05 ± 51%      -0.0        0.02 ±122%  perf-profile.self.cycles-pp.xfs_buf_find
      0.03 ± 82%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.add_to_page_cache_lru
      0.12 ±  6%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.do_syscall_64
      0.04 ± 53%      -0.0        0.02 ±122%  perf-profile.self.cycles-pp.xfs_isilocked
      0.13 ±  8%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.__cancel_dirty_page
      0.12 ± 11%      -0.0        0.09 ±  8%  perf-profile.self.cycles-pp.aa_file_perm
      0.10 ±  8%      -0.0        0.08        perf-profile.self.cycles-pp.__mod_lruvec_state
      0.05 ±  9%      -0.0        0.03 ± 81%  perf-profile.self.cycles-pp.unlock_page_memcg
      0.10 ±  6%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.rcu_read_unlock_strict
      0.15 ±  9%      -0.0        0.13 ±  5%  perf-profile.self.cycles-pp.generic_write_checks
      0.34 ±  7%      -0.0        0.31 ±  4%  perf-profile.self.cycles-pp.xfs_iext_lookup_extent
      0.11 ±  7%      -0.0        0.09 ±  6%  perf-profile.self.cycles-pp.xas_clear_mark
      0.11 ±  7%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.02 ±234%      -0.0        0.00        perf-profile.self.cycles-pp._raw_spin_trylock
      0.15 ±  7%      -0.0        0.13 ±  8%  perf-profile.self.cycles-pp.__alloc_pages
      0.16 ±  9%      -0.0        0.14 ±  8%  perf-profile.self.cycles-pp.xfs_break_layouts
      0.13 ± 11%      -0.0        0.11 ± 10%  perf-profile.self.cycles-pp.rcu_all_qs
      0.14 ±  7%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.rmqueue
      0.06 ± 11%      -0.0        0.04 ± 65%  perf-profile.self.cycles-pp.free_unref_page_list
      0.06 ± 11%      -0.0        0.04 ± 65%  perf-profile.self.cycles-pp.copyin
      0.10 ±  7%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.lru_cache_add
      0.08 ± 43%      -0.0        0.06 ± 17%  perf-profile.self.cycles-pp.xfs_get_extsz_hint
      0.02 ±123%      -0.0        0.00        perf-profile.self.cycles-pp.free_unref_page_prepare
      0.03 ±100%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.__x64_sys_write
      0.02 ±176%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.02 ±165%      -0.0        0.00        perf-profile.self.cycles-pp.kmem_cache_free
      0.11 ± 12%      -0.0        0.09 ±  8%  perf-profile.self.cycles-pp.account_page_cleaned
      0.10 ± 10%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.iomap_page_create
      0.11 ±  8%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.07 ± 12%      -0.0        0.05 ± 34%  perf-profile.self.cycles-pp.xas_find
      0.11 ± 11%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.current_time
      0.09 ±  9%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.truncate_cleanup_page
      0.10 ± 13%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.timestamp_truncate
      0.08 ± 10%      -0.0        0.06 ±  4%  perf-profile.self.cycles-pp.node_page_state
      0.02 ±153%      -0.0        0.00        perf-profile.self.cycles-pp.__schedule
      0.02 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.calc_global_load_tick
      0.11 ± 13%      -0.0        0.09 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.10 ± 10%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.__fdget_pos
      0.02 ±152%      -0.0        0.00        perf-profile.self.cycles-pp.file_modified
      0.09 ±  9%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.security_file_permission
      0.08 ±  9%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.08 ± 10%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.page_cache_free_page
      0.06 ± 12%      -0.0        0.04 ± 51%  perf-profile.self.cycles-pp.xfs_buf_item_init
      0.02 ±122%      -0.0        0.01 ±300%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.02 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.update_blocked_averages
      0.07 ± 38%      -0.0        0.06 ± 35%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.native_irq_return_iret
      0.09 ± 17%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.xlog_cil_commit
      0.06 ± 16%      -0.0        0.05 ± 33%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.09 ± 11%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.15 ±  7%      -0.0        0.14 ±  9%  perf-profile.self.cycles-pp.xfs_iread_extents
      0.07 ±  9%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.alloc_pages
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.native_sched_clock
      0.08 ±  8%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.06 ± 10%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.xas_find_conflict
      0.02 ±123%      -0.0        0.01 ±200%  perf-profile.self.cycles-pp.iov_iter_init
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.08 ± 10%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.08 ±  7%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.wait_for_stable_page
      0.10 ± 13%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.file_remove_privs
      0.03 ± 81%      -0.0        0.02 ±122%  perf-profile.self.cycles-pp.xas_set_mark
      0.03 ±200%      -0.0        0.02 ±122%  perf-profile.self.cycles-pp.update_process_times
      0.02 ±152%      -0.0        0.01 ±299%  perf-profile.self.cycles-pp.xfs_inode_item_format
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.xas_init_marks
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.PageHuge
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.iomap_adjust_read_range
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.__update_load_avg_se
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.hrtimer_active
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.update_irq_load_avg
      0.08 ± 12%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.07 ± 12%      -0.0        0.06 ± 10%  perf-profile.self.cycles-pp.xlog_cil_insert_items
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.update_curr
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.tick_nohz_next_event
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.read_tsc
      0.02 ±158%      -0.0        0.01 ±200%  perf-profile.self.cycles-pp.xfs_verify_dir_ino
      0.09 ±  8%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.update_rq_clock
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.mod_objcg_state
      0.06 ± 17%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp._xfs_trans_bjoin
      0.06 ± 10%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.unaccount_page_cache_page
      0.07 ± 11%      -0.0        0.06 ± 12%  perf-profile.self.cycles-pp.workingset_update_node
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.do_idle
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.07 ± 10%      -0.0        0.07 ±  9%  perf-profile.self.cycles-pp.rw_verify_area
      0.02 ±152%      -0.0        0.01 ±200%  perf-profile.self.cycles-pp._xfs_buf_obj_cmp
      0.01 ±299%      -0.0        0.00        perf-profile.self.cycles-pp.xa_get_order
      0.01 ±299%      -0.0        0.00        perf-profile.self.cycles-pp.free_pcp_prepare
      0.01 ±299%      -0.0        0.00        perf-profile.self.cycles-pp.xlog_space_left
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.scheduler_tick
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.__softirqentry_text_start
      0.01 ±300%      -0.0        0.00        perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.02 ±122%      -0.0        0.02 ±152%  perf-profile.self.cycles-pp.dec_zone_page_state
      0.06 ± 10%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.grab_cache_page_write_begin
      0.04 ± 50%      -0.0        0.04 ± 50%  perf-profile.self.cycles-pp.xas_create
      0.07 ± 22%      -0.0        0.07 ± 15%  perf-profile.self.cycles-pp.__xfs_dir3_data_check
      0.23 ± 10%      +0.0        0.24 ± 13%  perf-profile.self.cycles-pp.xfs_errortag_test
      0.05 ± 35%      +0.0        0.05 ± 35%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.00            +0.0        0.01 ±300%  perf-profile.self.cycles-pp.xfs_inobt_btrec_to_irec
      0.01 ±299%      +0.0        0.02 ±152%  perf-profile.self.cycles-pp.xfs_next_bit
      0.06 ±144%      +0.0        0.07 ±  8%  perf-profile.self.cycles-pp.update_load_avg
      0.04 ± 68%      +0.0        0.06 ± 14%  perf-profile.self.cycles-pp.xfs_inobt_get_rec
      0.04 ±162%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.0        0.02 ±100%  perf-profile.self.cycles-pp.xfs_btree_check_sblock
      0.08 ± 13%      +0.0        0.12 ±  9%  perf-profile.self.cycles-pp.__xfs_btree_check_sblock
      0.02 ±152%      +0.0        0.06 ± 12%  perf-profile.self.cycles-pp.xfs_btree_increment
      0.01 ±299%      +0.0        0.05        perf-profile.self.cycles-pp.xfs_buf_item_format_segment
      0.00            +0.0        0.05 ± 34%  perf-profile.self.cycles-pp.xfs_btree_get_rec
      0.14 ± 13%      +0.1        0.20 ±  6%  perf-profile.self.cycles-pp.disk_wrt
      0.01 ±300%      +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.13 ± 14%      +0.1        0.25 ±  8%  perf-profile.self.cycles-pp.memcpy_erms
      1.58 ±  8%      +0.2        1.78 ±  4%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.64 ±  9%     +29.6       30.20 ±  5%  perf-profile.self.cycles-pp.osq_lock
      0.00          -100.0%       0.00        interrupts.0:IO-APIC.2-edge.timer
      1.50 ±179%    -100.0%       0.00        interrupts.100:PCI-MSI.31981633-edge.i40e-eth0-TxRx-64
      0.20 ±300%   +1100.0%       2.40 ±213%  interrupts.101:PCI-MSI.31981634-edge.i40e-eth0-TxRx-65
      0.00       +1.7e+103%      17.00 ±300%  interrupts.102:PCI-MSI.31981635-edge.i40e-eth0-TxRx-66
      0.10 ±300%    +500.0%       0.60 ±200%  interrupts.103:PCI-MSI.31981636-edge.i40e-eth0-TxRx-67
      3.50 ±204%     -91.4%       0.30 ±213%  interrupts.104:PCI-MSI.31981637-edge.i40e-eth0-TxRx-68
     67.00 ±300%     -85.4%       9.80 ±241%  interrupts.105:PCI-MSI.31981638-edge.i40e-eth0-TxRx-69
      0.40 ±200%   +8350.0%      33.80 ±284%  interrupts.106:PCI-MSI.31981639-edge.i40e-eth0-TxRx-70
      0.00          -100.0%       0.00        interrupts.107:PCI-MSI.31981640-edge.i40e-eth0-TxRx-71
      0.80 ±300%     -87.5%       0.10 ±300%  interrupts.108:PCI-MSI.31981641-edge.i40e-eth0-TxRx-72
      9.70 ±293%     -85.6%       1.40 ±253%  interrupts.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
      0.10 ±300%   +1000.0%       1.10 ±271%  interrupts.110:PCI-MSI.31981643-edge.i40e-eth0-TxRx-74
     25.30 ±298%    +176.7%      70.00 ±299%  interrupts.111:PCI-MSI.31981644-edge.i40e-eth0-TxRx-75
      0.00       +9.5e+102%       9.50 ±279%  interrupts.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
    271.70 ±294%     -96.6%       9.30 ±269%  interrupts.113:PCI-MSI.31981646-edge.i40e-eth0-TxRx-77
     32.50 ±296%     +52.0%      49.40 ±198%  interrupts.114:PCI-MSI.31981647-edge.i40e-eth0-TxRx-78
     36.40 ±297%    -100.0%       0.00        interrupts.115:PCI-MSI.31981648-edge.i40e-eth0-TxRx-79
      0.60 ±300%     +33.3%       0.80 ±229%  interrupts.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
     37.60 ±284%     -23.1%      28.90 ±295%  interrupts.117:PCI-MSI.31981650-edge.i40e-eth0-TxRx-81
      0.90 ±235%    +466.7%       5.10 ±152%  interrupts.118:PCI-MSI.31981651-edge.i40e-eth0-TxRx-82
      6.90 ±300%    -100.0%       0.00        interrupts.119:PCI-MSI.31981652-edge.i40e-eth0-TxRx-83
     43.60 ±293%     -68.1%      13.90 ±276%  interrupts.120:PCI-MSI.31981653-edge.i40e-eth0-TxRx-84
      0.00       +1.4e+102%       1.40 ±300%  interrupts.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
      9.00 ±300%     -10.0%       8.10 ±299%  interrupts.122:PCI-MSI.31981655-edge.i40e-eth0-TxRx-86
      0.80 ±261%    +175.0%       2.20 ±271%  interrupts.123:PCI-MSI.31981656-edge.i40e-eth0-TxRx-87
      0.00          -100.0%       0.00        interrupts.281:PCI-MSI.327680-edge.xhci_hcd
      0.00          -100.0%       0.00        interrupts.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.285:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.286:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.287:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.287:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.288:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.288:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.289:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.289:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.290:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.290:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.291:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.291:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.292:PCI-MSI.79872-edge.ioat-msix
      0.20 ±300%    -100.0%       0.00        interrupts.293:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.293:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.294:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.295:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.295:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.296:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.296:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.297:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.297:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.297:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.297:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.298:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.298:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.298:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.299:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.299:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.299:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.300:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.300:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.300:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.301:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.301:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.301:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.302:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.302:PCI-MSI.67188736-edge.ioat-msix
      0.00         +4e+101%       0.40 ±200%  interrupts.303:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.303:PCI-MSI.67188736-edge.ioat-msix
     58.50 ±299%     -99.3%       0.40 ±300%  interrupts.36:PCI-MSI.31981569-edge.i40e-eth0-TxRx-0
    272.70 ±293%     -99.0%       2.80 ±194%  interrupts.37:PCI-MSI.31981570-edge.i40e-eth0-TxRx-1
      1.70 ±299%     -88.2%       0.20 ±300%  interrupts.38:PCI-MSI.31981571-edge.i40e-eth0-TxRx-2
      0.70 ±157%     -71.4%       0.20 ±300%  interrupts.39:PCI-MSI.31981572-edge.i40e-eth0-TxRx-3
      0.00          -100.0%       0.00        interrupts.3:IO-APIC.3-edge
      0.50 ±240%     -80.0%       0.10 ±300%  interrupts.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
      3.00 ±289%     -66.7%       1.00 ±268%  interrupts.41:PCI-MSI.31981574-edge.i40e-eth0-TxRx-5
     21.00 ±220%     -99.5%       0.10 ±300%  interrupts.42:PCI-MSI.31981575-edge.i40e-eth0-TxRx-6
      6.00 ±300%     -91.7%       0.50 ±240%  interrupts.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
      0.00         +2e+101%       0.20 ±300%  interrupts.44:PCI-MSI.31981577-edge.i40e-eth0-TxRx-8
      1.90 ±187%    -100.0%       0.00        interrupts.45:PCI-MSI.31981578-edge.i40e-eth0-TxRx-9
    326.90 ±245%     -97.6%       7.80 ±300%  interrupts.46:PCI-MSI.31981579-edge.i40e-eth0-TxRx-10
      4.80 ±223%     +70.8%       8.20 ±300%  interrupts.47:PCI-MSI.31981580-edge.i40e-eth0-TxRx-11
      0.90 ±300%     -33.3%       0.60 ±213%  interrupts.48:PCI-MSI.31981581-edge.i40e-eth0-TxRx-12
     14.20 ±295%     -92.3%       1.10 ±242%  interrupts.49:PCI-MSI.31981582-edge.i40e-eth0-TxRx-13
      6.40 ±300%    -100.0%       0.00        interrupts.4:IO-APIC.4-edge.ttyS0
      5.00 ±300%    +180.0%      14.00 ±232%  interrupts.50:PCI-MSI.31981583-edge.i40e-eth0-TxRx-14
     33.60 ±208%     -95.8%       1.40 ±277%  interrupts.51:PCI-MSI.31981584-edge.i40e-eth0-TxRx-15
      4.90 ±279%    -100.0%       0.00        interrupts.52:PCI-MSI.31981585-edge.i40e-eth0-TxRx-16
      6.90 ±300%     -30.4%       4.80 ±286%  interrupts.53:PCI-MSI.31981586-edge.i40e-eth0-TxRx-17
      0.00          -100.0%       0.00        interrupts.54:PCI-MSI.31981587-edge.i40e-eth0-TxRx-18
      0.50 ±300%   +9040.0%      45.70 ±299%  interrupts.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
      2.00 ±222%    -100.0%       0.00        interrupts.56:PCI-MSI.31981589-edge.i40e-eth0-TxRx-20
      0.20 ±200%   +1700.0%       3.60 ±180%  interrupts.57:PCI-MSI.31981590-edge.i40e-eth0-TxRx-21
      3.20 ±148%     -12.5%       2.80 ±102%  interrupts.58:PCI-MSI.31981591-edge.i40e-eth0-TxRx-22
     24.80 ±200%     +27.4%      31.60 ±250%  interrupts.59:PCI-MSI.31981592-edge.i40e-eth0-TxRx-23
      1.00 ±300%   +5430.0%      55.30 ±220%  interrupts.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
      2.00 ±300%    +580.0%      13.60 ±283%  interrupts.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
      3.30 ±261%     -60.6%       1.30 ±275%  interrupts.62:PCI-MSI.31981595-edge.i40e-eth0-TxRx-26
      0.00       +1.7e+102%       1.70 ±300%  interrupts.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
      2.00 ±183%   +1055.0%      23.10 ±300%  interrupts.64:PCI-MSI.31981597-edge.i40e-eth0-TxRx-28
      1.50 ±240%    +353.3%       6.80 ±215%  interrupts.65:PCI-MSI.31981598-edge.i40e-eth0-TxRx-29
      0.50 ±204%    +220.0%       1.60 ±175%  interrupts.66:PCI-MSI.31981599-edge.i40e-eth0-TxRx-30
     15.20 ±297%     -98.0%       0.30 ±213%  interrupts.67:PCI-MSI.31981600-edge.i40e-eth0-TxRx-31
      2.80 ±199%   +1210.7%      36.70 ±204%  interrupts.68:PCI-MSI.31981601-edge.i40e-eth0-TxRx-32
      4.00 ±224%    -100.0%       0.00        interrupts.69:PCI-MSI.31981602-edge.i40e-eth0-TxRx-33
      0.80 ±300%   +2800.0%      23.20 ±187%  interrupts.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
      9.50 ±300%     -74.7%       2.40 ±272%  interrupts.71:PCI-MSI.31981604-edge.i40e-eth0-TxRx-35
      1.40 ±300%   +1064.3%      16.30 ±144%  interrupts.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
      0.00       +1.8e+102%       1.80 ±281%  interrupts.73:PCI-MSI.31981606-edge.i40e-eth0-TxRx-37
      1.50 ±213%  +13420.0%     202.80 ±299%  interrupts.74:PCI-MSI.31981607-edge.i40e-eth0-TxRx-38
      0.20 ±300%     -50.0%       0.10 ±300%  interrupts.75:PCI-MSI.31981608-edge.i40e-eth0-TxRx-39
     23.00 ±278%     -92.2%       1.80 ± 33%  interrupts.76:PCI-MSI.31981609-edge.i40e-eth0-TxRx-40
      6.90 ±186%  +29595.7%       2049 ±299%  interrupts.77:PCI-MSI.31981610-edge.i40e-eth0-TxRx-41
     62.60 ±225%     -98.7%       0.80 ±300%  interrupts.78:PCI-MSI.31981611-edge.i40e-eth0-TxRx-42
     20.50 ±295%    +271.7%      76.20 ±299%  interrupts.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
      9.20 ±253%     -81.5%       1.70 ±299%  interrupts.80:PCI-MSI.31981613-edge.i40e-eth0-TxRx-44
      1.60 ±261%    +743.8%      13.50 ±300%  interrupts.81:PCI-MSI.31981614-edge.i40e-eth0-TxRx-45
     24.90 ±298%     +44.6%      36.00 ±300%  interrupts.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
    265.50 ±300%     -91.6%      22.40 ±300%  interrupts.83:PCI-MSI.31981616-edge.i40e-eth0-TxRx-47
      0.50 ±204%     +80.0%       0.90 ±300%  interrupts.84:PCI-MSI.31981617-edge.i40e-eth0-TxRx-48
      6.00 ±294%     -85.0%       0.90 ±300%  interrupts.85:PCI-MSI.31981618-edge.i40e-eth0-TxRx-49
     49.10 ±299%     -75.2%      12.20 ±254%  interrupts.86:PCI-MSI.31981619-edge.i40e-eth0-TxRx-50
      1.10 ±245%    +654.5%       8.30 ±296%  interrupts.87:PCI-MSI.31981620-edge.i40e-eth0-TxRx-51
      0.30 ±300%    +666.7%       2.30 ±226%  interrupts.88:PCI-MSI.31981621-edge.i40e-eth0-TxRx-52
      3.90 ±291%      +5.1%       4.10 ±188%  interrupts.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
      0.00          -100.0%       0.00        interrupts.8:IO-APIC.8-edge.rtc0
      0.00          -100.0%       0.00        interrupts.90:PCI-MSI.31981623-edge.i40e-eth0-TxRx-54
      9.70 ±208%     -89.7%       1.00 ±268%  interrupts.91:PCI-MSI.31981624-edge.i40e-eth0-TxRx-55
      9.50 ±293%     -85.3%       1.40 ±300%  interrupts.92:PCI-MSI.31981625-edge.i40e-eth0-TxRx-56
      2.30 ±205%    -100.0%       0.00        interrupts.93:PCI-MSI.31981626-edge.i40e-eth0-TxRx-57
      3.50 ±248%    +311.4%      14.40 ±265%  interrupts.94:PCI-MSI.31981627-edge.i40e-eth0-TxRx-58
      0.00       +1.1e+103%      11.40 ±299%  interrupts.95:PCI-MSI.31981628-edge.i40e-eth0-TxRx-59
      7.20 ±286%     -76.4%       1.70 ±232%  interrupts.96:PCI-MSI.31981629-edge.i40e-eth0-TxRx-60
      1.40 ±300%     +35.7%       1.90 ±248%  interrupts.97:PCI-MSI.31981630-edge.i40e-eth0-TxRx-61
      7.90 ±291%   +1644.3%     137.80 ±194%  interrupts.98:PCI-MSI.31981631-edge.i40e-eth0-TxRx-62
      0.20 ±300%    -100.0%       0.00        interrupts.99:PCI-MSI.31981632-edge.i40e-eth0-TxRx-63
     57986 ±  2%      -2.9%      56304        interrupts.CAL:Function_call_interrupts
      0.00          -100.0%       0.00        interrupts.CPU0.0:IO-APIC.2-edge.timer
      0.20 ±200%     -50.0%       0.10 ±300%  interrupts.CPU0.111:PCI-MSI.31981644-edge.i40e-eth0-TxRx-75
     58.40 ±300%     -99.3%       0.40 ±300%  interrupts.CPU0.36:PCI-MSI.31981569-edge.i40e-eth0-TxRx-0
      0.00          -100.0%       0.00        interrupts.CPU0.3:IO-APIC.3-edge
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU0.67:PCI-MSI.31981600-edge.i40e-eth0-TxRx-31
    661.00 ± 46%      +8.5%     717.20 ± 48%  interrupts.CPU0.CAL:Function_call_interrupts
      1.80 ± 64%     -22.2%       1.40 ± 79%  interrupts.CPU0.IWI:IRQ_work_interrupts
     70968 ±  2%      +9.0%      77320 ± 15%  interrupts.CPU0.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU0.MCP:Machine_check_polls
      3437 ±  8%     -11.7%       3035 ± 23%  interrupts.CPU0.NMI:Non-maskable_interrupts
      3437 ±  8%     -11.7%       3035 ± 23%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
     40.60 ± 18%    +229.3%     133.70 ±  9%  interrupts.CPU0.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00        interrupts.CPU0.RTR:APIC_ICR_read_retries
      3.50 ±113%      -5.7%       3.30 ±103%  interrupts.CPU0.TLB:TLB_shootdowns
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU1.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
    272.50 ±293%     -99.0%       2.60 ±205%  interrupts.CPU1.37:PCI-MSI.31981570-edge.i40e-eth0-TxRx-1
      0.00          -100.0%       0.00        interrupts.CPU1.68:PCI-MSI.31981601-edge.i40e-eth0-TxRx-32
      1255 ± 81%     -47.0%     665.50 ± 17%  interrupts.CPU1.CAL:Function_call_interrupts
      0.50 ±100%     -60.0%       0.20 ±200%  interrupts.CPU1.IWI:IRQ_work_interrupts
     71048 ±  2%      +8.9%      77360 ± 15%  interrupts.CPU1.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU1.MCP:Machine_check_polls
      2799 ± 33%     +14.2%       3198 ± 15%  interrupts.CPU1.NMI:Non-maskable_interrupts
      2799 ± 33%     +14.2%       3198 ± 15%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
     45.10 ± 20%    +185.6%     128.80 ± 14%  interrupts.CPU1.RES:Rescheduling_interrupts
      2.80 ± 90%     -35.7%       1.80 ±128%  interrupts.CPU1.TLB:TLB_shootdowns
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU10.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
      0.00          -100.0%       0.00        interrupts.CPU10.281:PCI-MSI.327680-edge.xhci_hcd
      0.00          -100.0%       0.00        interrupts.CPU10.287:PCI-MSI.69632-edge.ioat-msix
    326.70 ±245%     -97.6%       7.80 ±300%  interrupts.CPU10.46:PCI-MSI.31981579-edge.i40e-eth0-TxRx-10
      0.20 ±200%    -100.0%       0.00        interrupts.CPU10.77:PCI-MSI.31981610-edge.i40e-eth0-TxRx-41
    660.90 ± 10%      +0.9%     666.60 ± 15%  interrupts.CPU10.CAL:Function_call_interrupts
      0.70 ± 65%     -71.4%       0.20 ±200%  interrupts.CPU10.IWI:IRQ_work_interrupts
     71116 ±  2%      +8.6%      77204 ± 15%  interrupts.CPU10.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU10.MCP:Machine_check_polls
      3162 ± 24%      -9.8%       2853 ± 28%  interrupts.CPU10.NMI:Non-maskable_interrupts
      3162 ± 24%      -9.8%       2853 ± 28%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
     39.50 ± 17%    +178.2%     109.90 ± 23%  interrupts.CPU10.RES:Rescheduling_interrupts
      2.30 ± 47%     -47.8%       1.20 ± 89%  interrupts.CPU10.TLB:TLB_shootdowns
      0.10 ±300%    -100.0%       0.00        interrupts.CPU11.122:PCI-MSI.31981655-edge.i40e-eth0-TxRx-86
      0.00          -100.0%       0.00        interrupts.CPU11.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU11.287:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU11.289:PCI-MSI.75776-edge.ioat-msix
      4.70 ±227%     +72.3%       8.10 ±299%  interrupts.CPU11.47:PCI-MSI.31981580-edge.i40e-eth0-TxRx-11
      0.10 ±300%    -100.0%       0.00        interrupts.CPU11.78:PCI-MSI.31981611-edge.i40e-eth0-TxRx-42
      0.00          -100.0%       0.00        interrupts.CPU11.8:IO-APIC.8-edge.rtc0
    642.20 ±  7%      -1.4%     633.50 ±  6%  interrupts.CPU11.CAL:Function_call_interrupts
      0.40 ±122%      +0.0%       0.40 ±122%  interrupts.CPU11.IWI:IRQ_work_interrupts
     70964 ±  2%      +8.7%      77169 ± 15%  interrupts.CPU11.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU11.MCP:Machine_check_polls
      2907 ± 28%      -2.3%       2841 ± 28%  interrupts.CPU11.NMI:Non-maskable_interrupts
      2907 ± 28%      -2.3%       2841 ± 28%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
     41.10 ± 11%    +200.5%     123.50 ± 19%  interrupts.CPU11.RES:Rescheduling_interrupts
      2.90 ± 28%     -34.5%       1.90 ±149%  interrupts.CPU11.TLB:TLB_shootdowns
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU12.123:PCI-MSI.31981656-edge.i40e-eth0-TxRx-87
      0.00          -100.0%       0.00        interrupts.CPU12.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU12.287:PCI-MSI.71680-edge.ioat-msix
      0.80 ±300%     -37.5%       0.50 ±240%  interrupts.CPU12.48:PCI-MSI.31981581-edge.i40e-eth0-TxRx-12
      0.00         +2e+101%       0.20 ±200%  interrupts.CPU12.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
    626.40 ±  3%      +5.9%     663.40 ± 14%  interrupts.CPU12.CAL:Function_call_interrupts
      1.10 ± 63%     -81.8%       0.20 ±200%  interrupts.CPU12.IWI:IRQ_work_interrupts
     70974 ±  2%      +8.8%      77223 ± 15%  interrupts.CPU12.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU12.MCP:Machine_check_polls
      3325 ± 18%      -9.0%       3028 ± 23%  interrupts.CPU12.NMI:Non-maskable_interrupts
      3325 ± 18%      -9.0%       3028 ± 23%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
     40.40 ±  8%    +190.1%     117.20 ± 21%  interrupts.CPU12.RES:Rescheduling_interrupts
      2.40 ± 46%     -12.5%       2.10 ± 72%  interrupts.CPU12.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU13.285:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU13.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU13.287:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU13.288:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU13.288:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU13.290:PCI-MSI.77824-edge.ioat-msix
      0.10 ±300%    -100.0%       0.00        interrupts.CPU13.36:PCI-MSI.31981569-edge.i40e-eth0-TxRx-0
     14.10 ±297%     -94.3%       0.80 ±300%  interrupts.CPU13.49:PCI-MSI.31981582-edge.i40e-eth0-TxRx-13
      0.00          -100.0%       0.00        interrupts.CPU13.80:PCI-MSI.31981613-edge.i40e-eth0-TxRx-44
    642.30 ±  2%      -5.8%     605.20 ±  4%  interrupts.CPU13.CAL:Function_call_interrupts
      0.60 ± 81%     -66.7%       0.20 ±200%  interrupts.CPU13.IWI:IRQ_work_interrupts
     70966 ±  2%      +8.9%      77263 ± 15%  interrupts.CPU13.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU13.MCP:Machine_check_polls
      3155 ± 24%      -4.1%       3026 ± 22%  interrupts.CPU13.NMI:Non-maskable_interrupts
      3155 ± 24%      -4.1%       3026 ± 22%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
     43.70 ± 29%    +167.0%     116.70 ± 18%  interrupts.CPU13.RES:Rescheduling_interrupts
      2.20 ± 56%     -36.4%       1.40 ± 72%  interrupts.CPU13.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU14.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU14.287:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU14.288:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU14.289:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU14.289:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU14.290:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU14.291:PCI-MSI.79872-edge.ioat-msix
      0.20 ±200%      +0.0%       0.20 ±200%  interrupts.CPU14.37:PCI-MSI.31981570-edge.i40e-eth0-TxRx-1
      0.00          -100.0%       0.00        interrupts.CPU14.4:IO-APIC.4-edge.ttyS0
      5.00 ±300%    +178.0%      13.90 ±234%  interrupts.CPU14.50:PCI-MSI.31981583-edge.i40e-eth0-TxRx-14
      0.00          -100.0%       0.00        interrupts.CPU14.81:PCI-MSI.31981614-edge.i40e-eth0-TxRx-45
    690.50 ± 24%     -13.5%     597.10 ±  3%  interrupts.CPU14.CAL:Function_call_interrupts
      0.60 ± 81%     -33.3%       0.40 ±122%  interrupts.CPU14.IWI:IRQ_work_interrupts
     70951 ±  2%      +8.7%      77138 ± 15%  interrupts.CPU14.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU14.MCP:Machine_check_polls
      2798 ± 33%     +14.8%       3211 ± 17%  interrupts.CPU14.NMI:Non-maskable_interrupts
      2798 ± 33%     +14.8%       3211 ± 17%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
     43.50 ± 12%    +194.0%     127.90 ± 15%  interrupts.CPU14.RES:Rescheduling_interrupts
      2.70 ±109%     -55.6%       1.20 ±110%  interrupts.CPU14.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU15.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU15.287:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU15.288:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU15.289:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU15.290:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU15.290:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU15.291:PCI-MSI.79872-edge.ioat-msix
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU15.38:PCI-MSI.31981571-edge.i40e-eth0-TxRx-2
     33.50 ±209%     -96.1%       1.30 ±300%  interrupts.CPU15.51:PCI-MSI.31981584-edge.i40e-eth0-TxRx-15
      0.20 ±200%     -50.0%       0.10 ±300%  interrupts.CPU15.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
    776.80 ± 50%     -20.8%     615.40 ±  4%  interrupts.CPU15.CAL:Function_call_interrupts
      0.80 ± 75%     -75.0%       0.20 ±200%  interrupts.CPU15.IWI:IRQ_work_interrupts
     70886 ±  2%      +8.9%      77205 ± 15%  interrupts.CPU15.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU15.MCP:Machine_check_polls
      3113 ± 24%      -3.5%       3003 ± 22%  interrupts.CPU15.NMI:Non-maskable_interrupts
      3113 ± 24%      -3.5%       3003 ± 22%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
     40.70 ± 24%    +186.0%     116.40 ± 16%  interrupts.CPU15.RES:Rescheduling_interrupts
      2.40 ± 77%     -33.3%       1.60 ± 75%  interrupts.CPU15.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU16.288:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU16.289:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU16.290:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU16.291:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU16.291:PCI-MSI.79872-edge.ioat-msix
      0.20 ±200%     -50.0%       0.10 ±300%  interrupts.CPU16.39:PCI-MSI.31981572-edge.i40e-eth0-TxRx-3
      4.70 ±292%    -100.0%       0.00        interrupts.CPU16.52:PCI-MSI.31981585-edge.i40e-eth0-TxRx-16
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU16.83:PCI-MSI.31981616-edge.i40e-eth0-TxRx-47
    660.70 ± 12%      -9.1%     600.50 ±  4%  interrupts.CPU16.CAL:Function_call_interrupts
      0.50 ±100%     -60.0%       0.20 ±200%  interrupts.CPU16.IWI:IRQ_work_interrupts
     70992 ±  2%      +8.9%      77346 ± 15%  interrupts.CPU16.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU16.MCP:Machine_check_polls
      2641 ± 36%      +8.1%       2856 ± 27%  interrupts.CPU16.NMI:Non-maskable_interrupts
      2641 ± 36%      +8.1%       2856 ± 27%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
     39.20 ± 14%    +187.5%     112.70 ± 13%  interrupts.CPU16.RES:Rescheduling_interrupts
      2.70 ± 46%     -55.6%       1.20 ± 89%  interrupts.CPU16.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU17.289:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU17.290:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU17.291:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU17.292:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU17.303:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU17.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
      6.90 ±300%     -30.4%       4.80 ±286%  interrupts.CPU17.53:PCI-MSI.31981586-edge.i40e-eth0-TxRx-17
      0.10 ±300%    -100.0%       0.00        interrupts.CPU17.84:PCI-MSI.31981617-edge.i40e-eth0-TxRx-48
    644.50 ± 15%      +2.1%     657.80 ± 32%  interrupts.CPU17.CAL:Function_call_interrupts
      0.40 ±122%     -50.0%       0.20 ±200%  interrupts.CPU17.IWI:IRQ_work_interrupts
     70984 ±  2%      +8.7%      77187 ± 15%  interrupts.CPU17.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU17.MCP:Machine_check_polls
      2619 ± 36%     +15.9%       3037 ± 23%  interrupts.CPU17.NMI:Non-maskable_interrupts
      2619 ± 36%     +15.9%       3037 ± 23%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
     40.00 ± 18%    +212.0%     124.80 ± 12%  interrupts.CPU17.RES:Rescheduling_interrupts
      2.50 ± 74%     -32.0%       1.70 ± 74%  interrupts.CPU17.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU18.290:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU18.291:PCI-MSI.79872-edge.ioat-msix
      0.20 ±300%    -100.0%       0.00        interrupts.CPU18.293:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.CPU18.297:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.CPU18.303:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.10 ±300%    +100.0%       0.20 ±200%  interrupts.CPU18.41:PCI-MSI.31981574-edge.i40e-eth0-TxRx-5
      0.00          -100.0%       0.00        interrupts.CPU18.54:PCI-MSI.31981587-edge.i40e-eth0-TxRx-18
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU18.85:PCI-MSI.31981618-edge.i40e-eth0-TxRx-49
    608.20 ±  9%      +3.8%     631.10 ±  7%  interrupts.CPU18.CAL:Function_call_interrupts
      0.50 ±100%     -60.0%       0.20 ±200%  interrupts.CPU18.IWI:IRQ_work_interrupts
     70962 ±  2%      +8.8%      77221 ± 15%  interrupts.CPU18.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU18.MCP:Machine_check_polls
      2624 ± 36%     +14.6%       3006 ± 22%  interrupts.CPU18.NMI:Non-maskable_interrupts
      2624 ± 36%     +14.6%       3006 ± 22%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
     39.00 ± 17%    +211.8%     121.60 ± 22%  interrupts.CPU18.RES:Rescheduling_interrupts
      1.90 ± 59%     -31.6%       1.30 ± 91%  interrupts.CPU18.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU19.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU19.285:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU19.291:PCI-MSI.79872-edge.ioat-msix
      0.00         +4e+101%       0.40 ±200%  interrupts.CPU19.303:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.CPU19.3:IO-APIC.3-edge
      0.10 ±300%    -100.0%       0.00        interrupts.CPU19.42:PCI-MSI.31981575-edge.i40e-eth0-TxRx-6
      0.00          -100.0%       0.00        interrupts.CPU19.4:IO-APIC.4-edge.ttyS0
      0.50 ±300%   +9020.0%      45.60 ±299%  interrupts.CPU19.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
      0.00          -100.0%       0.00        interrupts.CPU19.86:PCI-MSI.31981619-edge.i40e-eth0-TxRx-50
    627.70 ±  2%      -1.8%     616.60 ±  7%  interrupts.CPU19.CAL:Function_call_interrupts
      0.80 ± 50%     -62.5%       0.30 ±152%  interrupts.CPU19.IWI:IRQ_work_interrupts
     70914 ±  2%      +8.9%      77252 ± 15%  interrupts.CPU19.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU19.MCP:Machine_check_polls
      3087 ± 23%      -1.5%       3041 ± 22%  interrupts.CPU19.NMI:Non-maskable_interrupts
      3087 ± 23%      -1.5%       3041 ± 22%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
     40.80 ± 17%    +195.3%     120.50 ± 19%  interrupts.CPU19.RES:Rescheduling_interrupts
      2.00 ± 59%     -20.0%       1.60 ± 75%  interrupts.CPU19.TLB:TLB_shootdowns
      0.20 ±200%     -50.0%       0.10 ±300%  interrupts.CPU2.113:PCI-MSI.31981646-edge.i40e-eth0-TxRx-77
      0.00          -100.0%       0.00        interrupts.CPU2.285:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU2.303:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      1.70 ±299%     -94.1%       0.10 ±300%  interrupts.CPU2.38:PCI-MSI.31981571-edge.i40e-eth0-TxRx-2
      0.20 ±200%    -100.0%       0.00        interrupts.CPU2.69:PCI-MSI.31981602-edge.i40e-eth0-TxRx-33
    816.40 ± 34%     +28.8%       1051 ± 80%  interrupts.CPU2.CAL:Function_call_interrupts
      0.80 ± 50%     -62.5%       0.30 ±152%  interrupts.CPU2.IWI:IRQ_work_interrupts
     71013 ±  2%      +8.8%      77258 ± 15%  interrupts.CPU2.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU2.MCP:Machine_check_polls
      3337 ± 17%      -5.2%       3165 ± 17%  interrupts.CPU2.NMI:Non-maskable_interrupts
      3337 ± 17%      -5.2%       3165 ± 17%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
     47.10 ± 27%    +153.5%     119.40 ± 21%  interrupts.CPU2.RES:Rescheduling_interrupts
      2.20 ± 60%     -13.6%       1.90 ±101%  interrupts.CPU2.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU20.289:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU20.303:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.CPU20.3:IO-APIC.3-edge
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU20.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
      1.90 ±234%    -100.0%       0.00        interrupts.CPU20.56:PCI-MSI.31981589-edge.i40e-eth0-TxRx-20
      0.20 ±200%    -100.0%       0.00        interrupts.CPU20.87:PCI-MSI.31981620-edge.i40e-eth0-TxRx-51
    651.60 ±  5%      -2.1%     637.70 ± 13%  interrupts.CPU20.CAL:Function_call_interrupts
      0.70 ± 91%     -57.1%       0.30 ±152%  interrupts.CPU20.IWI:IRQ_work_interrupts
     70927 ±  2%      +8.9%      77228 ± 15%  interrupts.CPU20.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU20.MCP:Machine_check_polls
      2941 ± 28%      +2.7%       3019 ± 21%  interrupts.CPU20.NMI:Non-maskable_interrupts
      2941 ± 28%      +2.7%       3019 ± 21%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
     43.10 ± 32%    +162.6%     113.20 ± 14%  interrupts.CPU20.RES:Rescheduling_interrupts
      2.10 ± 49%      -9.5%       1.90 ± 89%  interrupts.CPU20.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU21.44:PCI-MSI.31981577-edge.i40e-eth0-TxRx-8
      0.00       +3.3e+102%       3.30 ±193%  interrupts.CPU21.57:PCI-MSI.31981590-edge.i40e-eth0-TxRx-21
      0.10 ±300%    -100.0%       0.00        interrupts.CPU21.88:PCI-MSI.31981621-edge.i40e-eth0-TxRx-52
    626.20 ±  3%      -2.8%     608.40 ±  3%  interrupts.CPU21.CAL:Function_call_interrupts
      0.60 ± 81%     -16.7%       0.50 ±134%  interrupts.CPU21.IWI:IRQ_work_interrupts
     70983 ±  2%      +8.8%      77221 ± 15%  interrupts.CPU21.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU21.MCP:Machine_check_polls
      2953 ± 29%      +3.5%       3056 ± 22%  interrupts.CPU21.NMI:Non-maskable_interrupts
      2953 ± 29%      +3.5%       3056 ± 22%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
     39.70 ± 19%    +227.2%     129.90 ± 18%  interrupts.CPU21.RES:Rescheduling_interrupts
      2.30 ± 70%      +0.0%       2.30 ±113%  interrupts.CPU21.TLB:TLB_shootdowns
      3.20 ±148%     -12.5%       2.80 ±102%  interrupts.CPU22.58:PCI-MSI.31981591-edge.i40e-eth0-TxRx-22
      1018 ± 63%     -38.7%     624.00 ±  4%  interrupts.CPU22.CAL:Function_call_interrupts
      0.60 ± 81%     -66.7%       0.20 ±200%  interrupts.CPU22.IWI:IRQ_work_interrupts
     70986 ±  2%      +8.2%      76837 ± 15%  interrupts.CPU22.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU22.MCP:Machine_check_polls
      3058 ± 22%      +8.1%       3304 ±  4%  interrupts.CPU22.NMI:Non-maskable_interrupts
      3058 ± 22%      +8.1%       3304 ±  4%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
     38.80 ± 12%    +188.1%     111.80 ± 10%  interrupts.CPU22.RES:Rescheduling_interrupts
      2.30 ± 51%      +4.3%       2.40 ± 75%  interrupts.CPU22.TLB:TLB_shootdowns
     24.80 ±200%     +27.4%      31.60 ±250%  interrupts.CPU23.59:PCI-MSI.31981592-edge.i40e-eth0-TxRx-23
    645.90 ±  9%      -4.1%     619.20 ±  4%  interrupts.CPU23.CAL:Function_call_interrupts
      0.50 ±100%     -60.0%       0.20 ±200%  interrupts.CPU23.IWI:IRQ_work_interrupts
     70958 ±  2%      +8.3%      76817 ± 15%  interrupts.CPU23.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU23.MCP:Machine_check_polls
      2835 ± 28%     +16.3%       3297 ±  4%  interrupts.CPU23.NMI:Non-maskable_interrupts
      2835 ± 28%     +16.3%       3297 ±  4%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
     38.10 ± 23%    +219.2%     121.60 ± 18%  interrupts.CPU23.RES:Rescheduling_interrupts
      2.50 ± 69%     -16.0%       2.10 ± 91%  interrupts.CPU23.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU24.293:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU24.294:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU24.295:PCI-MSI.67174400-edge.ioat-msix
      0.90 ±300%   +6011.1%      55.00 ±221%  interrupts.CPU24.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
    645.10 ±  7%      -7.4%     597.40 ± 10%  interrupts.CPU24.CAL:Function_call_interrupts
      0.50 ±100%     -60.0%       0.20 ±200%  interrupts.CPU24.IWI:IRQ_work_interrupts
     70926 ±  2%      +8.3%      76843 ± 15%  interrupts.CPU24.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU24.MCP:Machine_check_polls
      2850 ± 26%     +10.2%       3141 ± 16%  interrupts.CPU24.NMI:Non-maskable_interrupts
      2850 ± 26%     +10.2%       3141 ± 16%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
     34.50 ± 14%    +204.3%     105.00 ± 15%  interrupts.CPU24.RES:Rescheduling_interrupts
      2.60 ± 35%     -38.5%       1.60 ± 89%  interrupts.CPU24.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU25.293:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU25.295:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU25.296:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU25.297:PCI-MSI.67176448-edge.ioat-msix
      1.90 ±300%    +610.5%      13.50 ±285%  interrupts.CPU25.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
    634.40 ±  5%      -2.6%     617.80 ±  2%  interrupts.CPU25.CAL:Function_call_interrupts
      0.40 ±122%     -50.0%       0.20 ±200%  interrupts.CPU25.IWI:IRQ_work_interrupts
     71005 ±  2%      +8.2%      76836 ± 15%  interrupts.CPU25.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU25.MCP:Machine_check_polls
      2990 ± 21%      +4.1%       3112 ± 17%  interrupts.CPU25.NMI:Non-maskable_interrupts
      2990 ± 21%      +4.1%       3112 ± 17%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
     33.90 ± 19%    +213.0%     106.10 ± 14%  interrupts.CPU25.RES:Rescheduling_interrupts
      2.10 ± 39%      -9.5%       1.90 ±101%  interrupts.CPU25.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU26.295:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU26.296:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU26.297:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU26.298:PCI-MSI.67178496-edge.ioat-msix
      3.20 ±270%     -62.5%       1.20 ±300%  interrupts.CPU26.62:PCI-MSI.31981595-edge.i40e-eth0-TxRx-26
    692.00 ± 20%     -12.5%     605.70 ±  4%  interrupts.CPU26.CAL:Function_call_interrupts
      0.70 ± 65%     -71.4%       0.20 ±200%  interrupts.CPU26.IWI:IRQ_work_interrupts
     70995 ±  2%      +8.2%      76798 ± 15%  interrupts.CPU26.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU26.MCP:Machine_check_polls
      3344 ±  7%      -6.8%       3117 ± 17%  interrupts.CPU26.NMI:Non-maskable_interrupts
      3344 ±  7%      -6.8%       3117 ± 17%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
     30.00 ± 14%    +270.3%     111.10 ± 12%  interrupts.CPU26.RES:Rescheduling_interrupts
      2.40 ± 67%     -33.3%       1.60 ± 93%  interrupts.CPU26.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU27.296:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU27.297:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU27.298:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU27.299:PCI-MSI.67180544-edge.ioat-msix
      0.00       +1.7e+102%       1.70 ±300%  interrupts.CPU27.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
    620.60 ±  3%      -3.4%     599.30 ±  5%  interrupts.CPU27.CAL:Function_call_interrupts
      0.80 ± 50%     -75.0%       0.20 ±200%  interrupts.CPU27.IWI:IRQ_work_interrupts
     70964 ±  2%      +8.2%      76811 ± 15%  interrupts.CPU27.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU27.MCP:Machine_check_polls
      3426 ±  5%      -8.2%       3146 ± 16%  interrupts.CPU27.NMI:Non-maskable_interrupts
      3426 ±  5%      -8.2%       3146 ± 16%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
     33.80 ± 20%    +231.1%     111.90 ± 15%  interrupts.CPU27.RES:Rescheduling_interrupts
      2.50 ± 65%     -36.0%       1.60 ± 63%  interrupts.CPU27.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU28.297:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU28.298:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU28.299:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU28.300:PCI-MSI.67182592-edge.ioat-msix
      1.90 ±193%   +1110.5%      23.00 ±300%  interrupts.CPU28.64:PCI-MSI.31981597-edge.i40e-eth0-TxRx-28
    630.30 ±  5%      -7.1%     585.50 ±  8%  interrupts.CPU28.CAL:Function_call_interrupts
      0.70 ±128%     -71.4%       0.20 ±200%  interrupts.CPU28.IWI:IRQ_work_interrupts
     70973 ±  2%      +8.2%      76795 ± 15%  interrupts.CPU28.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU28.MCP:Machine_check_polls
      3385 ±  6%      -8.1%       3109 ± 16%  interrupts.CPU28.NMI:Non-maskable_interrupts
      3385 ±  6%      -8.1%       3109 ± 16%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
     29.90 ± 23%    +280.3%     113.70 ± 12%  interrupts.CPU28.RES:Rescheduling_interrupts
      2.40 ± 65%     -41.7%       1.40 ± 91%  interrupts.CPU28.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU29.298:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU29.299:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU29.300:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU29.301:PCI-MSI.67184640-edge.ioat-msix
      1.50 ±240%    +353.3%       6.80 ±215%  interrupts.CPU29.65:PCI-MSI.31981598-edge.i40e-eth0-TxRx-29
    599.40 ±  8%      -2.6%     583.60 ± 11%  interrupts.CPU29.CAL:Function_call_interrupts
      0.50 ±100%     -80.0%       0.10 ±300%  interrupts.CPU29.IWI:IRQ_work_interrupts
     70994 ±  2%      +8.2%      76839 ± 15%  interrupts.CPU29.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU29.MCP:Machine_check_polls
      3043 ± 25%      +2.7%       3125 ± 16%  interrupts.CPU29.NMI:Non-maskable_interrupts
      3043 ± 25%      +2.7%       3125 ± 16%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
     36.90 ± 10%    +178.9%     102.90 ± 14%  interrupts.CPU29.RES:Rescheduling_interrupts
      2.70 ± 62%     -22.2%       2.10 ± 61%  interrupts.CPU29.TLB:TLB_shootdowns
      0.20 ±200%      +0.0%       0.20 ±200%  interrupts.CPU3.114:PCI-MSI.31981647-edge.i40e-eth0-TxRx-78
      0.00          -100.0%       0.00        interrupts.CPU3.286:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU3.287:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU3.303:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.50 ±184%     -80.0%       0.10 ±300%  interrupts.CPU3.39:PCI-MSI.31981572-edge.i40e-eth0-TxRx-3
      0.00         +2e+101%       0.20 ±200%  interrupts.CPU3.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
    887.20 ± 51%      +1.8%     903.40 ± 55%  interrupts.CPU3.CAL:Function_call_interrupts
      0.60 ± 81%     -66.7%       0.20 ±200%  interrupts.CPU3.IWI:IRQ_work_interrupts
     71027 ±  2%      +8.7%      77227 ± 15%  interrupts.CPU3.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU3.MCP:Machine_check_polls
      3295 ± 17%      -7.7%       3041 ± 22%  interrupts.CPU3.NMI:Non-maskable_interrupts
      3295 ± 17%      -7.7%       3041 ± 22%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
     38.00 ± 22%    +220.5%     121.80 ± 14%  interrupts.CPU3.RES:Rescheduling_interrupts
      1.90 ± 59%     -10.5%       1.70 ± 83%  interrupts.CPU3.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU30.298:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.299:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.300:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.300:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.301:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.302:PCI-MSI.67186688-edge.ioat-msix
      0.40 ±229%    +275.0%       1.50 ±186%  interrupts.CPU30.66:PCI-MSI.31981599-edge.i40e-eth0-TxRx-30
    626.60 ±  2%      -4.6%     597.50 ±  3%  interrupts.CPU30.CAL:Function_call_interrupts
      0.60 ± 81%     -83.3%       0.10 ±300%  interrupts.CPU30.IWI:IRQ_work_interrupts
     70942 ±  2%      +8.3%      76812 ± 15%  interrupts.CPU30.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU30.MCP:Machine_check_polls
      3017 ± 25%      -1.8%       2964 ± 22%  interrupts.CPU30.NMI:Non-maskable_interrupts
      3017 ± 25%      -1.8%       2964 ± 22%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
     34.30 ±  9%    +228.9%     112.80 ± 20%  interrupts.CPU30.RES:Rescheduling_interrupts
      2.60 ± 75%     -50.0%       1.30 ±114%  interrupts.CPU30.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU31.299:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.300:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.301:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.301:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.302:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.303:PCI-MSI.67188736-edge.ioat-msix
     15.10 ±299%     -98.7%       0.20 ±300%  interrupts.CPU31.67:PCI-MSI.31981600-edge.i40e-eth0-TxRx-31
    625.70 ±  3%      -2.7%     608.50 ±  3%  interrupts.CPU31.CAL:Function_call_interrupts
      0.60 ± 81%     -66.7%       0.20 ±200%  interrupts.CPU31.IWI:IRQ_work_interrupts
     70938 ±  2%      +8.3%      76823 ± 15%  interrupts.CPU31.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU31.MCP:Machine_check_polls
      3148 ± 16%     -11.5%       2786 ± 26%  interrupts.CPU31.NMI:Non-maskable_interrupts
      3148 ± 16%     -11.5%       2786 ± 26%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
     31.60 ± 19%    +235.4%     106.00 ± 22%  interrupts.CPU31.RES:Rescheduling_interrupts
      2.40 ± 50%     -20.8%       1.90 ± 59%  interrupts.CPU31.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU32.300:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU32.301:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU32.302:PCI-MSI.67188736-edge.ioat-msix
      2.80 ±199%   +1210.7%      36.70 ±204%  interrupts.CPU32.68:PCI-MSI.31981601-edge.i40e-eth0-TxRx-32
    621.40 ±  2%      -4.9%     590.70 ±  9%  interrupts.CPU32.CAL:Function_call_interrupts
      0.70 ± 91%     -85.7%       0.10 ±300%  interrupts.CPU32.IWI:IRQ_work_interrupts
     70962 ±  2%      +8.3%      76818 ± 15%  interrupts.CPU32.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU32.MCP:Machine_check_polls
      3231 ± 17%     -19.5%       2600 ± 28%  interrupts.CPU32.NMI:Non-maskable_interrupts
      3231 ± 17%     -19.5%       2600 ± 28%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
     29.80 ± 21%    +244.6%     102.70 ± 19%  interrupts.CPU32.RES:Rescheduling_interrupts
      2.80 ± 61%     -21.4%       2.20 ± 66%  interrupts.CPU32.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU33.301:PCI-MSI.67188736-edge.ioat-msix
      3.80 ±229%    -100.0%       0.00        interrupts.CPU33.69:PCI-MSI.31981602-edge.i40e-eth0-TxRx-33
    629.60 ±  3%      -3.9%     605.10 ±  4%  interrupts.CPU33.CAL:Function_call_interrupts
      0.70 ± 91%     -85.7%       0.10 ±300%  interrupts.CPU33.IWI:IRQ_work_interrupts
     70960 ±  2%      +8.3%      76825 ± 15%  interrupts.CPU33.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU33.MCP:Machine_check_polls
      3158 ± 17%     -27.9%       2278 ± 35%  interrupts.CPU33.NMI:Non-maskable_interrupts
      3158 ± 17%     -27.9%       2278 ± 35%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
     32.90 ± 14%    +228.0%     107.90 ± 16%  interrupts.CPU33.RES:Rescheduling_interrupts
      2.10 ± 68%      +0.0%       2.10 ± 86%  interrupts.CPU33.TLB:TLB_shootdowns
      0.80 ±300%   +2775.0%      23.00 ±189%  interrupts.CPU34.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
    618.40 ±  3%      -5.2%     586.10 ±  5%  interrupts.CPU34.CAL:Function_call_interrupts
      0.70 ± 65%     -85.7%       0.10 ±300%  interrupts.CPU34.IWI:IRQ_work_interrupts
     70969 ±  2%      +8.2%      76819 ± 15%  interrupts.CPU34.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU34.MCP:Machine_check_polls
      3201 ± 16%     -13.2%       2778 ± 27%  interrupts.CPU34.NMI:Non-maskable_interrupts
      3201 ± 16%     -13.2%       2778 ± 27%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
     33.80 ± 11%    +201.2%     101.80 ± 19%  interrupts.CPU34.RES:Rescheduling_interrupts
      2.10 ± 61%      -9.5%       1.90 ± 86%  interrupts.CPU34.TLB:TLB_shootdowns
      9.40 ±299%     -77.7%       2.10 ±300%  interrupts.CPU35.71:PCI-MSI.31981604-edge.i40e-eth0-TxRx-35
    621.30 ±  2%      -4.0%     596.70 ±  3%  interrupts.CPU35.CAL:Function_call_interrupts
      0.70 ± 65%     -71.4%       0.20 ±300%  interrupts.CPU35.IWI:IRQ_work_interrupts
     70953 ±  2%      +8.3%      76833 ± 15%  interrupts.CPU35.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU35.MCP:Machine_check_polls
      3379 ±  6%     -23.2%       2596 ± 30%  interrupts.CPU35.NMI:Non-maskable_interrupts
      3379 ±  6%     -23.2%       2596 ± 30%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
     31.70 ± 14%    +249.8%     110.90 ± 15%  interrupts.CPU35.RES:Rescheduling_interrupts
      2.20 ± 63%     -31.8%       1.50 ±120%  interrupts.CPU35.TLB:TLB_shootdowns
      1.40 ±300%   +1057.1%      16.20 ±144%  interrupts.CPU36.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
    616.10            -1.3%     607.80 ±  2%  interrupts.CPU36.CAL:Function_call_interrupts
      0.70 ± 65%     -85.7%       0.10 ±300%  interrupts.CPU36.IWI:IRQ_work_interrupts
     70968 ±  2%      +8.2%      76796 ± 15%  interrupts.CPU36.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU36.MCP:Machine_check_polls
      3381 ±  7%     -18.3%       2763 ± 26%  interrupts.CPU36.NMI:Non-maskable_interrupts
      3381 ±  7%     -18.3%       2763 ± 26%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
     34.30 ± 11%    +279.6%     130.20 ± 18%  interrupts.CPU36.RES:Rescheduling_interrupts
      2.40 ± 46%     -29.2%       1.70 ± 83%  interrupts.CPU36.TLB:TLB_shootdowns
      0.00       +1.8e+102%       1.80 ±281%  interrupts.CPU37.73:PCI-MSI.31981606-edge.i40e-eth0-TxRx-37
    631.60 ± 11%      -6.2%     592.60 ±  5%  interrupts.CPU37.CAL:Function_call_interrupts
      0.70 ± 65%     -85.7%       0.10 ±300%  interrupts.CPU37.IWI:IRQ_work_interrupts
     71107 ±  2%      +8.1%      76848 ± 15%  interrupts.CPU37.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU37.MCP:Machine_check_polls
      3374 ±  5%      -8.2%       3098 ± 16%  interrupts.CPU37.NMI:Non-maskable_interrupts
      3374 ±  5%      -8.2%       3098 ± 16%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
     31.00 ± 19%    +276.1%     116.60 ± 25%  interrupts.CPU37.RES:Rescheduling_interrupts
      3.20 ± 45%     -25.0%       2.40 ± 83%  interrupts.CPU37.TLB:TLB_shootdowns
      1.50 ±213%  +13406.7%     202.60 ±300%  interrupts.CPU38.74:PCI-MSI.31981607-edge.i40e-eth0-TxRx-38
    620.90            -2.9%     602.90 ±  3%  interrupts.CPU38.CAL:Function_call_interrupts
      0.80 ± 50%     -75.0%       0.20 ±200%  interrupts.CPU38.IWI:IRQ_work_interrupts
     70985 ±  2%      +8.2%      76787 ± 15%  interrupts.CPU38.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU38.MCP:Machine_check_polls
      3365 ±  5%     -18.1%       2756 ± 25%  interrupts.CPU38.NMI:Non-maskable_interrupts
      3365 ±  5%     -18.1%       2756 ± 25%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
     33.50 ± 10%    +232.5%     111.40 ± 20%  interrupts.CPU38.RES:Rescheduling_interrupts
      2.10 ± 61%     -33.3%       1.40 ± 91%  interrupts.CPU38.TLB:TLB_shootdowns
      0.10 ±300%    -100.0%       0.00        interrupts.CPU39.75:PCI-MSI.31981608-edge.i40e-eth0-TxRx-39
    627.00 ±  4%      -1.5%     617.80 ±  6%  interrupts.CPU39.CAL:Function_call_interrupts
      0.70 ± 65%     -85.7%       0.10 ±300%  interrupts.CPU39.IWI:IRQ_work_interrupts
     70994 ±  2%      +8.2%      76819 ± 15%  interrupts.CPU39.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU39.MCP:Machine_check_polls
      3197 ± 16%     -13.4%       2769 ± 25%  interrupts.CPU39.NMI:Non-maskable_interrupts
      3197 ± 16%     -13.4%       2769 ± 25%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
     36.30 ± 20%    +218.5%     115.60 ± 16%  interrupts.CPU39.RES:Rescheduling_interrupts
      2.70 ± 55%     -29.6%       1.90 ± 95%  interrupts.CPU39.TLB:TLB_shootdowns
      0.10 ±300%    -100.0%       0.00        interrupts.CPU4.115:PCI-MSI.31981648-edge.i40e-eth0-TxRx-79
      0.00          -100.0%       0.00        interrupts.CPU4.286:PCI-MSI.69632-edge.ioat-msix
      0.40 ±300%    -100.0%       0.00        interrupts.CPU4.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
      0.10 ±300%    +200.0%       0.30 ±152%  interrupts.CPU4.71:PCI-MSI.31981604-edge.i40e-eth0-TxRx-35
    658.20 ±  7%     +11.5%     734.00 ± 51%  interrupts.CPU4.CAL:Function_call_interrupts
      0.70 ± 65%     -57.1%       0.30 ±152%  interrupts.CPU4.IWI:IRQ_work_interrupts
     70938 ±  2%      +8.8%      77210 ± 15%  interrupts.CPU4.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU4.MCP:Machine_check_polls
      3319 ± 18%      -8.5%       3038 ± 23%  interrupts.CPU4.NMI:Non-maskable_interrupts
      3319 ± 18%      -8.5%       3038 ± 23%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
     38.70 ± 21%    +196.9%     114.90 ± 10%  interrupts.CPU4.RES:Rescheduling_interrupts
      2.20 ± 39%     -36.4%       1.40 ± 91%  interrupts.CPU4.TLB:TLB_shootdowns
     23.00 ±278%     -92.2%       1.80 ± 33%  interrupts.CPU40.76:PCI-MSI.31981609-edge.i40e-eth0-TxRx-40
    613.80 ± 10%      -0.1%     613.40 ±  5%  interrupts.CPU40.CAL:Function_call_interrupts
      0.50 ±100%    -100.0%       0.00        interrupts.CPU40.IWI:IRQ_work_interrupts
     70957 ±  2%      +8.2%      76809 ± 15%  interrupts.CPU40.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU40.MCP:Machine_check_polls
      3160 ± 17%     -13.2%       2742 ± 25%  interrupts.CPU40.NMI:Non-maskable_interrupts
      3160 ± 17%     -13.2%       2742 ± 25%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
     38.70 ± 28%    +205.7%     118.30 ± 17%  interrupts.CPU40.RES:Rescheduling_interrupts
      3.00 ± 44%     -23.3%       2.30 ± 61%  interrupts.CPU40.TLB:TLB_shootdowns
      6.70 ±192%  +30482.1%       2049 ±299%  interrupts.CPU41.77:PCI-MSI.31981610-edge.i40e-eth0-TxRx-41
    618.90 ±  2%      -0.8%     613.80 ±  2%  interrupts.CPU41.CAL:Function_call_interrupts
      0.60 ± 81%     -66.7%       0.20 ±200%  interrupts.CPU41.IWI:IRQ_work_interrupts
     70986 ±  2%      +8.2%      76827 ± 15%  interrupts.CPU41.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU41.MCP:Machine_check_polls
      3161 ± 17%      -6.3%       2962 ± 22%  interrupts.CPU41.NMI:Non-maskable_interrupts
      3161 ± 17%      -6.3%       2962 ± 22%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
     34.20 ± 22%    +225.7%     111.40 ± 15%  interrupts.CPU41.RES:Rescheduling_interrupts
      2.80 ± 52%     -28.6%       2.00 ± 89%  interrupts.CPU41.TLB:TLB_shootdowns
     62.50 ±225%     -98.7%       0.80 ±300%  interrupts.CPU42.78:PCI-MSI.31981611-edge.i40e-eth0-TxRx-42
    630.40 ±  5%      -3.4%     608.80 ±  3%  interrupts.CPU42.CAL:Function_call_interrupts
      0.70 ± 65%     -85.7%       0.10 ±300%  interrupts.CPU42.IWI:IRQ_work_interrupts
     71054 ±  2%      +8.0%      76762 ± 15%  interrupts.CPU42.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU42.MCP:Machine_check_polls
      3327 ±  7%      -6.7%       3103 ± 15%  interrupts.CPU42.NMI:Non-maskable_interrupts
      3327 ±  7%      -6.7%       3103 ± 15%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
     39.90 ± 33%    +179.9%     111.70 ± 15%  interrupts.CPU42.RES:Rescheduling_interrupts
      2.90 ± 36%     -13.8%       2.50 ± 60%  interrupts.CPU42.TLB:TLB_shootdowns
     20.50 ±295%    +270.7%      76.00 ±300%  interrupts.CPU43.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
    623.30 ±  9%      +0.9%     629.00 ±  4%  interrupts.CPU43.CAL:Function_call_interrupts
      0.80 ± 75%     -87.5%       0.10 ±300%  interrupts.CPU43.IWI:IRQ_work_interrupts
     70985 ±  2%      +8.2%      76807 ± 15%  interrupts.CPU43.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU43.MCP:Machine_check_polls
      3329 ±  4%     -12.7%       2907 ± 20%  interrupts.CPU43.NMI:Non-maskable_interrupts
      3329 ±  4%     -12.7%       2907 ± 20%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
     48.80 ± 68%    +116.6%     105.70 ± 18%  interrupts.CPU43.RES:Rescheduling_interrupts
      3.40 ± 39%      -2.9%       3.30 ± 66%  interrupts.CPU43.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU44.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU44.303:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.20 ±200%    -100.0%       0.00        interrupts.CPU44.45:PCI-MSI.31981578-edge.i40e-eth0-TxRx-9
      9.20 ±253%     -81.5%       1.70 ±299%  interrupts.CPU44.80:PCI-MSI.31981613-edge.i40e-eth0-TxRx-44
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU44.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
    644.40 ±  5%      -5.3%     610.30 ±  3%  interrupts.CPU44.CAL:Function_call_interrupts
      0.50 ±100%     -40.0%       0.30 ±152%  interrupts.CPU44.IWI:IRQ_work_interrupts
     70949 ±  2%      +9.0%      77317 ± 15%  interrupts.CPU44.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU44.MCP:Machine_check_polls
      3017 ± 24%      +0.1%       3021 ± 24%  interrupts.CPU44.NMI:Non-maskable_interrupts
      3017 ± 24%      +0.1%       3021 ± 24%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
     33.80 ± 21%    +247.9%     117.60 ± 18%  interrupts.CPU44.RES:Rescheduling_interrupts
      2.30 ± 51%     -34.8%       1.50 ± 90%  interrupts.CPU44.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU45.3:IO-APIC.3-edge
      0.20 ±200%    -100.0%       0.00        interrupts.CPU45.46:PCI-MSI.31981579-edge.i40e-eth0-TxRx-10
      1.60 ±261%    +743.8%      13.50 ±300%  interrupts.CPU45.81:PCI-MSI.31981614-edge.i40e-eth0-TxRx-45
      0.00          -100.0%       0.00        interrupts.CPU45.90:PCI-MSI.31981623-edge.i40e-eth0-TxRx-54
    638.00 ±  3%      -3.9%     613.40 ±  5%  interrupts.CPU45.CAL:Function_call_interrupts
      0.60 ± 81%     -50.0%       0.30 ±152%  interrupts.CPU45.IWI:IRQ_work_interrupts
     70840 ±  2%      +9.0%      77249 ± 15%  interrupts.CPU45.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU45.MCP:Machine_check_polls
      3040 ± 25%      +9.7%       3333 ±  3%  interrupts.CPU45.NMI:Non-maskable_interrupts
      3040 ± 25%      +9.7%       3333 ±  3%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
     33.60 ± 10%    +229.8%     110.80 ± 24%  interrupts.CPU45.RES:Rescheduling_interrupts
      2.70 ± 57%     -37.0%       1.70 ± 59%  interrupts.CPU45.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU46.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU46.3:IO-APIC.3-edge
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU46.47:PCI-MSI.31981580-edge.i40e-eth0-TxRx-11
     24.70 ±300%     +45.3%      35.90 ±300%  interrupts.CPU46.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
      0.10 ±300%    +100.0%       0.20 ±200%  interrupts.CPU46.91:PCI-MSI.31981624-edge.i40e-eth0-TxRx-55
    614.40 ±  9%      +1.5%     623.90 ±  4%  interrupts.CPU46.CAL:Function_call_interrupts
      0.60 ± 81%     -50.0%       0.30 ±152%  interrupts.CPU46.IWI:IRQ_work_interrupts
     70974 ±  2%      +9.0%      77336 ± 15%  interrupts.CPU46.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU46.MCP:Machine_check_polls
      3217 ± 18%      -0.7%       3193 ± 16%  interrupts.CPU46.NMI:Non-maskable_interrupts
      3217 ± 18%      -0.7%       3193 ± 16%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
     32.10 ± 10%    +266.0%     117.50 ± 16%  interrupts.CPU46.RES:Rescheduling_interrupts
      2.20 ± 56%     +13.6%       2.50 ± 69%  interrupts.CPU46.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU47.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU47.3:IO-APIC.3-edge
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU47.48:PCI-MSI.31981581-edge.i40e-eth0-TxRx-12
      0.00          -100.0%       0.00        interrupts.CPU47.4:IO-APIC.4-edge.ttyS0
    265.40 ±300%     -91.6%      22.30 ±300%  interrupts.CPU47.83:PCI-MSI.31981616-edge.i40e-eth0-TxRx-47
      0.30 ±152%    -100.0%       0.00        interrupts.CPU47.92:PCI-MSI.31981625-edge.i40e-eth0-TxRx-56
    626.00 ±  2%      -7.5%     579.00 ± 10%  interrupts.CPU47.CAL:Function_call_interrupts
      0.50 ±100%     -60.0%       0.20 ±200%  interrupts.CPU47.IWI:IRQ_work_interrupts
     70981 ±  2%      +8.8%      77255 ± 15%  interrupts.CPU47.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU47.MCP:Machine_check_polls
      3020 ± 24%      +4.3%       3150 ± 16%  interrupts.CPU47.NMI:Non-maskable_interrupts
      3020 ± 24%      +4.3%       3150 ± 16%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
     32.50 ± 15%    +247.4%     112.90 ± 12%  interrupts.CPU47.RES:Rescheduling_interrupts
      2.50 ± 60%     -12.0%       2.20 ± 72%  interrupts.CPU47.TLB:TLB_shootdowns
      0.10 ±300%    +200.0%       0.30 ±152%  interrupts.CPU48.49:PCI-MSI.31981582-edge.i40e-eth0-TxRx-13
      0.00          -100.0%       0.00        interrupts.CPU48.4:IO-APIC.4-edge.ttyS0
      0.40 ±229%    +125.0%       0.90 ±300%  interrupts.CPU48.84:PCI-MSI.31981617-edge.i40e-eth0-TxRx-48
      0.00          -100.0%       0.00        interrupts.CPU48.93:PCI-MSI.31981626-edge.i40e-eth0-TxRx-57
    648.10 ±  5%      -7.2%     601.30 ±  2%  interrupts.CPU48.CAL:Function_call_interrupts
      0.50 ±100%     -60.0%       0.20 ±200%  interrupts.CPU48.IWI:IRQ_work_interrupts
     71001 ±  2%      +8.8%      77266 ± 15%  interrupts.CPU48.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU48.MCP:Machine_check_polls
      3018 ± 23%      -0.1%       3014 ± 22%  interrupts.CPU48.NMI:Non-maskable_interrupts
      3018 ± 23%      -0.1%       3014 ± 22%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
     31.70 ± 15%    +258.0%     113.50 ± 12%  interrupts.CPU48.RES:Rescheduling_interrupts
      2.30 ± 51%     +13.0%       2.60 ± 86%  interrupts.CPU48.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU49.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU49.285:PCI-MSI.67584-edge.ioat-msix
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU49.50:PCI-MSI.31981583-edge.i40e-eth0-TxRx-14
      5.90 ±294%     -86.4%       0.80 ±300%  interrupts.CPU49.85:PCI-MSI.31981618-edge.i40e-eth0-TxRx-49
      0.00          -100.0%       0.00        interrupts.CPU49.94:PCI-MSI.31981627-edge.i40e-eth0-TxRx-58
    641.60 ±  6%      -5.8%     604.60 ±  4%  interrupts.CPU49.CAL:Function_call_interrupts
      0.60 ± 81%     -33.3%       0.40 ±122%  interrupts.CPU49.IWI:IRQ_work_interrupts
     70973 ±  2%      +8.9%      77273 ± 15%  interrupts.CPU49.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU49.MCP:Machine_check_polls
      3029 ± 24%      -0.7%       3008 ± 23%  interrupts.CPU49.NMI:Non-maskable_interrupts
      3029 ± 24%      -0.7%       3008 ± 23%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
     26.20 ± 23%    +314.1%     108.50 ± 13%  interrupts.CPU49.RES:Rescheduling_interrupts
      2.30 ± 55%     +21.7%       2.80 ± 71%  interrupts.CPU49.TLB:TLB_shootdowns
      0.00         +2e+101%       0.20 ±200%  interrupts.CPU5.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
      2.90 ±299%     -72.4%       0.80 ±300%  interrupts.CPU5.41:PCI-MSI.31981574-edge.i40e-eth0-TxRx-5
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU5.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
    653.30 ± 15%     +80.6%       1179 ± 71%  interrupts.CPU5.CAL:Function_call_interrupts
      0.90 ± 33%     -77.8%       0.20 ±200%  interrupts.CPU5.IWI:IRQ_work_interrupts
     71034 ±  2%      +8.8%      77273 ± 15%  interrupts.CPU5.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU5.MCP:Machine_check_polls
      3478 ±  5%     -12.3%       3049 ± 22%  interrupts.CPU5.NMI:Non-maskable_interrupts
      3478 ±  5%     -12.3%       3049 ± 22%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
     40.20 ± 18%    +184.1%     114.20 ± 19%  interrupts.CPU5.RES:Rescheduling_interrupts
      2.20 ± 48%     -31.8%       1.50 ±108%  interrupts.CPU5.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU50.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU50.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU50.3:IO-APIC.3-edge
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU50.51:PCI-MSI.31981584-edge.i40e-eth0-TxRx-15
     49.10 ±299%     -75.2%      12.20 ±254%  interrupts.CPU50.86:PCI-MSI.31981619-edge.i40e-eth0-TxRx-50
      0.00          -100.0%       0.00        interrupts.CPU50.95:PCI-MSI.31981628-edge.i40e-eth0-TxRx-59
    656.20 ± 11%      -7.6%     606.50 ±  3%  interrupts.CPU50.CAL:Function_call_interrupts
      0.60 ± 81%     -50.0%       0.30 ±152%  interrupts.CPU50.IWI:IRQ_work_interrupts
     70967 ±  2%      +8.9%      77280 ± 15%  interrupts.CPU50.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU50.MCP:Machine_check_polls
      3195 ± 18%     -11.4%       2830 ± 28%  interrupts.CPU50.NMI:Non-maskable_interrupts
      3195 ± 18%     -11.4%       2830 ± 28%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
     33.60 ± 26%    +256.8%     119.90 ± 22%  interrupts.CPU50.RES:Rescheduling_interrupts
      3.10 ± 36%     -32.3%       2.10 ± 61%  interrupts.CPU50.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU51.285:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU51.3:IO-APIC.3-edge
      0.20 ±200%    -100.0%       0.00        interrupts.CPU51.52:PCI-MSI.31981585-edge.i40e-eth0-TxRx-16
      0.90 ±265%    +822.2%       8.30 ±296%  interrupts.CPU51.87:PCI-MSI.31981620-edge.i40e-eth0-TxRx-51
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU51.96:PCI-MSI.31981629-edge.i40e-eth0-TxRx-60
    628.60 ±  3%      -3.3%     607.80 ±  2%  interrupts.CPU51.CAL:Function_call_interrupts
      0.60 ± 81%     -66.7%       0.20 ±200%  interrupts.CPU51.IWI:IRQ_work_interrupts
     70976 ±  2%      +8.9%      77287 ± 15%  interrupts.CPU51.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU51.MCP:Machine_check_polls
      3192 ± 17%      -0.5%       3177 ± 16%  interrupts.CPU51.NMI:Non-maskable_interrupts
      3192 ± 17%      -0.5%       3177 ± 16%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
     34.50 ± 21%    +230.4%     114.00 ± 19%  interrupts.CPU51.RES:Rescheduling_interrupts
      3.00 ± 36%     -43.3%       1.70 ±105%  interrupts.CPU51.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU52.53:PCI-MSI.31981586-edge.i40e-eth0-TxRx-17
      0.20 ±300%   +1050.0%       2.30 ±226%  interrupts.CPU52.88:PCI-MSI.31981621-edge.i40e-eth0-TxRx-52
      0.00         +3e+101%       0.30 ±152%  interrupts.CPU52.97:PCI-MSI.31981630-edge.i40e-eth0-TxRx-61
    616.60 ±  4%      -2.0%     604.00 ±  4%  interrupts.CPU52.CAL:Function_call_interrupts
      0.40 ±122%     -75.0%       0.10 ±300%  interrupts.CPU52.IWI:IRQ_work_interrupts
     70980 ±  2%      +8.9%      77273 ± 15%  interrupts.CPU52.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU52.MCP:Machine_check_polls
      2831 ± 28%      +5.8%       2994 ± 21%  interrupts.CPU52.NMI:Non-maskable_interrupts
      2831 ± 28%      +5.8%       2994 ± 21%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
     30.20 ± 23%    +307.3%     123.00 ± 22%  interrupts.CPU52.RES:Rescheduling_interrupts
      2.80 ± 44%     -28.6%       2.00 ± 59%  interrupts.CPU52.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU53.54:PCI-MSI.31981587-edge.i40e-eth0-TxRx-18
      3.80 ±300%      +5.3%       4.00 ±193%  interrupts.CPU53.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU53.98:PCI-MSI.31981631-edge.i40e-eth0-TxRx-62
    621.30 ±  4%      -1.2%     613.90 ±  6%  interrupts.CPU53.CAL:Function_call_interrupts
      0.50 ±100%     -80.0%       0.10 ±300%  interrupts.CPU53.IWI:IRQ_work_interrupts
     70967 ±  2%      +8.9%      77270 ± 15%  interrupts.CPU53.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU53.MCP:Machine_check_polls
      3036 ± 23%     -12.8%       2647 ± 30%  interrupts.CPU53.NMI:Non-maskable_interrupts
      3036 ± 23%     -12.8%       2647 ± 30%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
     29.80 ± 14%    +278.9%     112.90 ± 17%  interrupts.CPU53.RES:Rescheduling_interrupts
      2.60 ± 57%      -3.8%       2.50 ± 44%  interrupts.CPU53.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU54.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU54.3:IO-APIC.3-edge
      0.00          -100.0%       0.00        interrupts.CPU54.4:IO-APIC.4-edge.ttyS0
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU54.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
      0.00          -100.0%       0.00        interrupts.CPU54.90:PCI-MSI.31981623-edge.i40e-eth0-TxRx-54
      0.10 ±300%    -100.0%       0.00        interrupts.CPU54.99:PCI-MSI.31981632-edge.i40e-eth0-TxRx-63
    636.20 ±  3%      -2.6%     619.80 ±  7%  interrupts.CPU54.CAL:Function_call_interrupts
      0.50 ±100%     -60.0%       0.20 ±200%  interrupts.CPU54.IWI:IRQ_work_interrupts
     70868 ±  2%      +9.0%      77249 ± 15%  interrupts.CPU54.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU54.MCP:Machine_check_polls
      3170 ± 17%     -11.5%       2806 ± 26%  interrupts.CPU54.NMI:Non-maskable_interrupts
      3170 ± 17%     -11.5%       2806 ± 26%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
     30.10 ± 14%    +266.1%     110.20 ± 12%  interrupts.CPU54.RES:Rescheduling_interrupts
      2.80 ± 38%     -25.0%       2.10 ± 68%  interrupts.CPU54.TLB:TLB_shootdowns
      0.20 ±200%    -100.0%       0.00        interrupts.CPU55.100:PCI-MSI.31981633-edge.i40e-eth0-TxRx-64
      0.00          -100.0%       0.00        interrupts.CPU55.3:IO-APIC.3-edge
      0.10 ±300%    -100.0%       0.00        interrupts.CPU55.56:PCI-MSI.31981589-edge.i40e-eth0-TxRx-20
      9.60 ±207%     -91.7%       0.80 ±300%  interrupts.CPU55.91:PCI-MSI.31981624-edge.i40e-eth0-TxRx-55
    666.50 ±  7%      -8.6%     609.30 ±  2%  interrupts.CPU55.CAL:Function_call_interrupts
      0.60 ± 81%     -83.3%       0.10 ±300%  interrupts.CPU55.IWI:IRQ_work_interrupts
     70983 ±  2%      +8.8%      77247 ± 15%  interrupts.CPU55.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU55.MCP:Machine_check_polls
      3157 ± 17%     -11.4%       2798 ± 26%  interrupts.CPU55.NMI:Non-maskable_interrupts
      3157 ± 17%     -11.4%       2798 ± 26%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
     34.70 ± 17%    +220.2%     111.10 ± 11%  interrupts.CPU55.RES:Rescheduling_interrupts
      2.80 ± 41%     -28.6%       2.00 ± 77%  interrupts.CPU55.TLB:TLB_shootdowns
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU56.101:PCI-MSI.31981634-edge.i40e-eth0-TxRx-65
      0.00          -100.0%       0.00        interrupts.CPU56.3:IO-APIC.3-edge
      0.20 ±200%     +50.0%       0.30 ±152%  interrupts.CPU56.57:PCI-MSI.31981590-edge.i40e-eth0-TxRx-21
      9.20 ±300%     -84.8%       1.40 ±300%  interrupts.CPU56.92:PCI-MSI.31981625-edge.i40e-eth0-TxRx-56
    633.80 ±  3%      -4.8%     603.40 ±  2%  interrupts.CPU56.CAL:Function_call_interrupts
      0.50 ±100%     -80.0%       0.10 ±300%  interrupts.CPU56.IWI:IRQ_work_interrupts
     70991 ±  2%      +8.8%      77270 ± 15%  interrupts.CPU56.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU56.MCP:Machine_check_polls
      3168 ± 17%     -17.2%       2624 ± 29%  interrupts.CPU56.NMI:Non-maskable_interrupts
      3168 ± 17%     -17.2%       2624 ± 29%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
     29.20 ± 16%    +260.3%     105.20 ± 15%  interrupts.CPU56.RES:Rescheduling_interrupts
      3.60 ± 48%     -36.1%       2.30 ± 67%  interrupts.CPU56.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU57.102:PCI-MSI.31981635-edge.i40e-eth0-TxRx-66
      0.00          -100.0%       0.00        interrupts.CPU57.283:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU57.285:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU57.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU57.287:PCI-MSI.71680-edge.ioat-msix
      6.40 ±300%    -100.0%       0.00        interrupts.CPU57.4:IO-APIC.4-edge.ttyS0
      0.00          -100.0%       0.00        interrupts.CPU57.58:PCI-MSI.31981591-edge.i40e-eth0-TxRx-22
      2.30 ±205%    -100.0%       0.00        interrupts.CPU57.93:PCI-MSI.31981626-edge.i40e-eth0-TxRx-57
    638.10 ±  7%      -1.6%     627.80 ±  8%  interrupts.CPU57.CAL:Function_call_interrupts
      0.40 ±122%     -75.0%       0.10 ±300%  interrupts.CPU57.IWI:IRQ_work_interrupts
     71064 ±  2%      +8.7%      77276 ± 15%  interrupts.CPU57.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU57.MCP:Machine_check_polls
      2498 ± 36%     +12.7%       2816 ± 26%  interrupts.CPU57.NMI:Non-maskable_interrupts
      2498 ± 36%     +12.7%       2816 ± 26%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
     28.40 ± 20%    +305.3%     115.10 ± 16%  interrupts.CPU57.RES:Rescheduling_interrupts
      2.60 ± 49%     -23.1%       2.00 ± 63%  interrupts.CPU57.TLB:TLB_shootdowns
      0.10 ±300%    +100.0%       0.20 ±200%  interrupts.CPU58.103:PCI-MSI.31981636-edge.i40e-eth0-TxRx-67
      0.00          -100.0%       0.00        interrupts.CPU58.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU58.59:PCI-MSI.31981592-edge.i40e-eth0-TxRx-23
      3.50 ±248%    +311.4%      14.40 ±265%  interrupts.CPU58.94:PCI-MSI.31981627-edge.i40e-eth0-TxRx-58
    630.10 ±  2%      -2.0%     617.40 ±  6%  interrupts.CPU58.CAL:Function_call_interrupts
      1.40 ±160%     -85.7%       0.20 ±200%  interrupts.CPU58.IWI:IRQ_work_interrupts
     71026 ±  2%      +8.7%      77237 ± 15%  interrupts.CPU58.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU58.MCP:Machine_check_polls
      3343 ±  6%     -15.3%       2830 ± 27%  interrupts.CPU58.NMI:Non-maskable_interrupts
      3343 ±  6%     -15.3%       2830 ± 27%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
     32.60 ± 28%    +233.7%     108.80 ± 12%  interrupts.CPU58.RES:Rescheduling_interrupts
      2.80 ± 41%     -17.9%       2.30 ± 51%  interrupts.CPU58.TLB:TLB_shootdowns
      0.00         +2e+101%       0.20 ±200%  interrupts.CPU59.104:PCI-MSI.31981637-edge.i40e-eth0-TxRx-68
      0.00          -100.0%       0.00        interrupts.CPU59.286:PCI-MSI.69632-edge.ioat-msix
      0.10 ±300%    +200.0%       0.30 ±152%  interrupts.CPU59.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
      0.00       +1.1e+103%      11.40 ±299%  interrupts.CPU59.95:PCI-MSI.31981628-edge.i40e-eth0-TxRx-59
    643.50 ±  7%      -5.6%     607.30 ±  3%  interrupts.CPU59.CAL:Function_call_interrupts
      0.70 ± 65%     -57.1%       0.30 ±152%  interrupts.CPU59.IWI:IRQ_work_interrupts
     70954 ±  2%      +8.8%      77229 ± 15%  interrupts.CPU59.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU59.MCP:Machine_check_polls
      3161 ± 18%      -5.5%       2988 ± 23%  interrupts.CPU59.NMI:Non-maskable_interrupts
      3161 ± 18%      -5.5%       2988 ± 23%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
     35.20 ± 43%    +250.0%     123.20 ± 22%  interrupts.CPU59.RES:Rescheduling_interrupts
      2.40 ± 50%      -4.2%       2.30 ± 47%  interrupts.CPU59.TLB:TLB_shootdowns
      0.20 ±200%      +0.0%       0.20 ±200%  interrupts.CPU6.117:PCI-MSI.31981650-edge.i40e-eth0-TxRx-81
      0.00          -100.0%       0.00        interrupts.CPU6.286:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU6.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU6.287:PCI-MSI.71680-edge.ioat-msix
     20.90 ±221%     -99.5%       0.10 ±300%  interrupts.CPU6.42:PCI-MSI.31981575-edge.i40e-eth0-TxRx-6
      0.00          -100.0%       0.00        interrupts.CPU6.73:PCI-MSI.31981606-edge.i40e-eth0-TxRx-37
      1019 ± 95%     +11.6%       1138 ± 91%  interrupts.CPU6.CAL:Function_call_interrupts
      0.80 ± 50%     -62.5%       0.30 ±152%  interrupts.CPU6.IWI:IRQ_work_interrupts
     70974 ±  2%      +8.7%      77176 ± 15%  interrupts.CPU6.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU6.MCP:Machine_check_polls
      3471 ±  7%     -13.1%       3016 ± 23%  interrupts.CPU6.NMI:Non-maskable_interrupts
      3471 ±  7%     -13.1%       3016 ± 23%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
     42.10 ± 24%    +205.7%     128.70 ± 16%  interrupts.CPU6.RES:Rescheduling_interrupts
      2.30 ± 64%     -43.5%       1.30 ± 69%  interrupts.CPU6.TLB:TLB_shootdowns
      0.10 ±300%    -100.0%       0.00        interrupts.CPU60.105:PCI-MSI.31981638-edge.i40e-eth0-TxRx-69
      0.00          -100.0%       0.00        interrupts.CPU60.285:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU60.3:IO-APIC.3-edge
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU60.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
      7.10 ±290%     -77.5%       1.60 ±229%  interrupts.CPU60.96:PCI-MSI.31981629-edge.i40e-eth0-TxRx-60
    619.50 ±  2%      +0.2%     620.50 ±  8%  interrupts.CPU60.CAL:Function_call_interrupts
      0.60 ± 81%     -83.3%       0.10 ±300%  interrupts.CPU60.IWI:IRQ_work_interrupts
     71034 ±  2%      +9.0%      77400 ± 15%  interrupts.CPU60.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU60.MCP:Machine_check_polls
      3044 ± 24%      -1.2%       3006 ± 22%  interrupts.CPU60.NMI:Non-maskable_interrupts
      3044 ± 24%      -1.2%       3006 ± 22%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
     28.40 ± 13%    +302.8%     114.40 ± 18%  interrupts.CPU60.RES:Rescheduling_interrupts
      2.80 ± 47%     -25.0%       2.10 ± 91%  interrupts.CPU60.TLB:TLB_shootdowns
      0.10 ±300%    -100.0%       0.00        interrupts.CPU61.106:PCI-MSI.31981639-edge.i40e-eth0-TxRx-70
      0.00          -100.0%       0.00        interrupts.CPU61.286:PCI-MSI.69632-edge.ioat-msix
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU61.62:PCI-MSI.31981595-edge.i40e-eth0-TxRx-26
      1.40 ±300%     +14.3%       1.60 ±300%  interrupts.CPU61.97:PCI-MSI.31981630-edge.i40e-eth0-TxRx-61
    633.20 ±  3%      -2.4%     618.00 ±  6%  interrupts.CPU61.CAL:Function_call_interrupts
      0.60 ± 81%     -33.3%       0.40 ±122%  interrupts.CPU61.IWI:IRQ_work_interrupts
     70987 ±  2%      +8.8%      77226 ± 15%  interrupts.CPU61.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU61.MCP:Machine_check_polls
      3035 ± 24%     +10.8%       3363 ±  4%  interrupts.CPU61.NMI:Non-maskable_interrupts
      3035 ± 24%     +10.8%       3363 ±  4%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
     30.10 ± 21%    +305.6%     122.10 ± 16%  interrupts.CPU61.RES:Rescheduling_interrupts
      2.60 ± 39%     -11.5%       2.30 ± 55%  interrupts.CPU61.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU62.107:PCI-MSI.31981640-edge.i40e-eth0-TxRx-71
      0.00          -100.0%       0.00        interrupts.CPU62.285:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU62.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU62.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
      7.80 ±295%   +1665.4%     137.70 ±194%  interrupts.CPU62.98:PCI-MSI.31981631-edge.i40e-eth0-TxRx-62
    656.40 ±  9%      -3.9%     631.00 ±  6%  interrupts.CPU62.CAL:Function_call_interrupts
      0.60 ± 81%     -66.7%       0.20 ±200%  interrupts.CPU62.IWI:IRQ_work_interrupts
     70970 ±  2%      +8.9%      77295 ± 15%  interrupts.CPU62.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU62.MCP:Machine_check_polls
      2990 ± 24%      -0.0%       2990 ± 22%  interrupts.CPU62.NMI:Non-maskable_interrupts
      2990 ± 24%      -0.0%       2990 ± 22%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
     45.30 ± 36%    +163.8%     119.50 ± 17%  interrupts.CPU62.RES:Rescheduling_interrupts
      2.90 ± 42%     -10.3%       2.60 ± 64%  interrupts.CPU62.TLB:TLB_shootdowns
      0.00         +1e+101%       0.10 ±300%  interrupts.CPU63.108:PCI-MSI.31981641-edge.i40e-eth0-TxRx-72
      0.00          -100.0%       0.00        interrupts.CPU63.285:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU63.288:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU63.3:IO-APIC.3-edge
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU63.64:PCI-MSI.31981597-edge.i40e-eth0-TxRx-28
      0.10 ±300%    -100.0%       0.00        interrupts.CPU63.99:PCI-MSI.31981632-edge.i40e-eth0-TxRx-63
    631.50 ±  8%      +0.4%     634.30 ±  7%  interrupts.CPU63.CAL:Function_call_interrupts
      0.50 ±100%     -40.0%       0.30 ±152%  interrupts.CPU63.IWI:IRQ_work_interrupts
     70950 ±  2%      +9.1%      77397 ± 15%  interrupts.CPU63.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU63.MCP:Machine_check_polls
      2686 ± 34%     +12.5%       3021 ± 23%  interrupts.CPU63.NMI:Non-maskable_interrupts
      2686 ± 34%     +12.5%       3021 ± 23%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
     46.10 ± 34%    +180.7%     129.40 ± 28%  interrupts.CPU63.RES:Rescheduling_interrupts
      2.80 ± 47%      -7.1%       2.60 ± 67%  interrupts.CPU63.TLB:TLB_shootdowns
      1.30 ±185%    -100.0%       0.00        interrupts.CPU64.100:PCI-MSI.31981633-edge.i40e-eth0-TxRx-64
      0.00         +2e+101%       0.20 ±200%  interrupts.CPU64.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
      0.00          -100.0%       0.00        interrupts.CPU64.286:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU64.65:PCI-MSI.31981598-edge.i40e-eth0-TxRx-29
    629.70 ±  3%      -0.4%     627.00 ±  5%  interrupts.CPU64.CAL:Function_call_interrupts
      0.50 ±100%     -60.0%       0.20 ±200%  interrupts.CPU64.IWI:IRQ_work_interrupts
     71032 ±  2%      +8.8%      77249 ± 15%  interrupts.CPU64.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU64.MCP:Machine_check_polls
      2688 ± 33%     +11.6%       2999 ± 22%  interrupts.CPU64.NMI:Non-maskable_interrupts
      2688 ± 33%     +11.6%       2999 ± 22%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
     38.30 ± 31%    +238.9%     129.80 ± 11%  interrupts.CPU64.RES:Rescheduling_interrupts
      3.20 ± 36%     -34.4%       2.10 ± 61%  interrupts.CPU64.TLB:TLB_shootdowns
      0.10 ±300%   +2200.0%       2.30 ±218%  interrupts.CPU65.101:PCI-MSI.31981634-edge.i40e-eth0-TxRx-65
      0.00         +2e+101%       0.20 ±200%  interrupts.CPU65.110:PCI-MSI.31981643-edge.i40e-eth0-TxRx-74
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU65.66:PCI-MSI.31981599-edge.i40e-eth0-TxRx-30
    627.00 ±  2%      -3.1%     607.70 ±  5%  interrupts.CPU65.CAL:Function_call_interrupts
      0.40 ±122%     -25.0%       0.30 ±152%  interrupts.CPU65.IWI:IRQ_work_interrupts
     70994 ±  2%      +8.7%      77180 ± 15%  interrupts.CPU65.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU65.MCP:Machine_check_polls
      2513 ± 37%     +19.8%       3012 ± 22%  interrupts.CPU65.NMI:Non-maskable_interrupts
      2513 ± 37%     +19.8%       3012 ± 22%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
     36.80 ± 32%    +242.1%     125.90 ± 12%  interrupts.CPU65.RES:Rescheduling_interrupts
      3.00 ± 42%     -33.3%       2.00 ± 59%  interrupts.CPU65.TLB:TLB_shootdowns
      0.00       +1.7e+103%      17.00 ±300%  interrupts.CPU66.102:PCI-MSI.31981635-edge.i40e-eth0-TxRx-66
    654.40 ±  7%      -6.9%     609.50 ±  2%  interrupts.CPU66.CAL:Function_call_interrupts
      0.40 ±122%    -100.0%       0.00        interrupts.CPU66.IWI:IRQ_work_interrupts
     70991 ±  2%      +8.3%      76854 ± 15%  interrupts.CPU66.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU66.MCP:Machine_check_polls
      2612 ± 33%     +12.1%       2927 ± 22%  interrupts.CPU66.NMI:Non-maskable_interrupts
      2612 ± 33%     +12.1%       2927 ± 22%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
     26.10 ± 31%    +359.8%     120.00 ± 20%  interrupts.CPU66.RES:Rescheduling_interrupts
      3.60 ± 39%     -52.8%       1.70 ± 83%  interrupts.CPU66.TLB:TLB_shootdowns
      0.00         +4e+101%       0.40 ±300%  interrupts.CPU67.103:PCI-MSI.31981636-edge.i40e-eth0-TxRx-67
    619.40 ±  2%      -3.9%     595.10 ±  2%  interrupts.CPU67.CAL:Function_call_interrupts
      0.30 ±152%    -100.0%       0.00        interrupts.CPU67.IWI:IRQ_work_interrupts
     71167 ±  2%      +8.0%      76837 ± 15%  interrupts.CPU67.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU67.MCP:Machine_check_polls
      2573 ± 33%     +13.6%       2923 ± 21%  interrupts.CPU67.NMI:Non-maskable_interrupts
      2573 ± 33%     +13.6%       2923 ± 21%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
     26.40 ± 21%    +353.8%     119.80 ± 23%  interrupts.CPU67.RES:Rescheduling_interrupts
      3.70 ± 40%     -37.8%       2.30 ± 64%  interrupts.CPU67.TLB:TLB_shootdowns
      3.50 ±204%     -97.1%       0.10 ±300%  interrupts.CPU68.104:PCI-MSI.31981637-edge.i40e-eth0-TxRx-68
    638.10 ±  7%      -4.4%     609.80 ±  6%  interrupts.CPU68.CAL:Function_call_interrupts
      0.50 ±100%    -100.0%       0.00        interrupts.CPU68.IWI:IRQ_work_interrupts
     71023 ±  2%      +8.2%      76854 ± 15%  interrupts.CPU68.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU68.MCP:Machine_check_polls
      2625 ± 33%      +5.3%       2763 ± 26%  interrupts.CPU68.NMI:Non-maskable_interrupts
      2625 ± 33%      +5.3%       2763 ± 26%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
     27.30 ± 21%    +283.9%     104.80 ± 14%  interrupts.CPU68.RES:Rescheduling_interrupts
      2.70 ± 40%     -11.1%       2.40 ± 70%  interrupts.CPU68.TLB:TLB_shootdowns
     66.90 ±300%     -85.4%       9.80 ±241%  interrupts.CPU69.105:PCI-MSI.31981638-edge.i40e-eth0-TxRx-69
    631.90 ±  4%      -3.8%     608.10 ±  3%  interrupts.CPU69.CAL:Function_call_interrupts
      0.40 ±122%    -100.0%       0.00        interrupts.CPU69.IWI:IRQ_work_interrupts
     70987 ±  2%      +8.2%      76825 ± 15%  interrupts.CPU69.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU69.MCP:Machine_check_polls
      2583 ± 34%     +13.0%       2918 ± 23%  interrupts.CPU69.NMI:Non-maskable_interrupts
      2583 ± 34%     +13.0%       2918 ± 23%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
     29.20 ± 18%    +272.9%     108.90 ± 20%  interrupts.CPU69.RES:Rescheduling_interrupts
      2.80 ± 26%     -10.7%       2.50 ± 54%  interrupts.CPU69.TLB:TLB_shootdowns
      0.10 ±300%    -100.0%       0.00        interrupts.CPU7.118:PCI-MSI.31981651-edge.i40e-eth0-TxRx-82
      0.00          -100.0%       0.00        interrupts.CPU7.286:PCI-MSI.69632-edge.ioat-msix
      6.00 ±300%     -93.3%       0.40 ±300%  interrupts.CPU7.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
      0.00         +2e+101%       0.20 ±200%  interrupts.CPU7.74:PCI-MSI.31981607-edge.i40e-eth0-TxRx-38
    875.80 ± 55%     -31.8%     597.70 ±  8%  interrupts.CPU7.CAL:Function_call_interrupts
      0.90 ± 33%     -77.8%       0.20 ±200%  interrupts.CPU7.IWI:IRQ_work_interrupts
     70920 ±  2%      +8.9%      77256 ± 15%  interrupts.CPU7.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU7.MCP:Machine_check_polls
      3492 ±  7%     -17.9%       2866 ± 28%  interrupts.CPU7.NMI:Non-maskable_interrupts
      3492 ±  7%     -17.9%       2866 ± 28%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
     39.10 ± 12%    +199.7%     117.20 ± 21%  interrupts.CPU7.RES:Rescheduling_interrupts
      2.20 ± 56%     -36.4%       1.40 ±120%  interrupts.CPU7.TLB:TLB_shootdowns
      0.30 ±213%  +11166.7%      33.80 ±284%  interrupts.CPU70.106:PCI-MSI.31981639-edge.i40e-eth0-TxRx-70
    617.90 ±  4%      -1.6%     607.90 ±  4%  interrupts.CPU70.CAL:Function_call_interrupts
      0.60 ± 81%    -100.0%       0.00        interrupts.CPU70.IWI:IRQ_work_interrupts
     71007 ±  2%      +8.2%      76832 ± 15%  interrupts.CPU70.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU70.MCP:Machine_check_polls
      2772 ± 30%      +5.8%       2931 ± 22%  interrupts.CPU70.NMI:Non-maskable_interrupts
      2772 ± 30%      +5.8%       2931 ± 22%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
     29.70 ± 18%    +254.5%     105.30 ± 14%  interrupts.CPU70.RES:Rescheduling_interrupts
      3.10 ± 46%     -22.6%       2.40 ± 65%  interrupts.CPU70.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU71.107:PCI-MSI.31981640-edge.i40e-eth0-TxRx-71
    625.30            -3.6%     602.90 ±  4%  interrupts.CPU71.CAL:Function_call_interrupts
      0.60 ± 81%    -100.0%       0.00        interrupts.CPU71.IWI:IRQ_work_interrupts
     71112 ±  2%      +8.0%      76833 ± 15%  interrupts.CPU71.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU71.MCP:Machine_check_polls
      2792 ± 30%     -13.8%       2406 ± 32%  interrupts.CPU71.NMI:Non-maskable_interrupts
      2792 ± 30%     -13.8%       2406 ± 32%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
     28.70 ± 18%    +284.0%     110.20 ± 15%  interrupts.CPU71.RES:Rescheduling_interrupts
      3.50 ± 19%     -28.6%       2.50 ± 57%  interrupts.CPU71.TLB:TLB_shootdowns
      0.80 ±300%    -100.0%       0.00        interrupts.CPU72.108:PCI-MSI.31981641-edge.i40e-eth0-TxRx-72
    636.60 ±  2%      -2.5%     620.40 ±  6%  interrupts.CPU72.CAL:Function_call_interrupts
      0.50 ±100%    -100.0%       0.00        interrupts.CPU72.IWI:IRQ_work_interrupts
     70986 ±  2%      +8.2%      76837 ± 15%  interrupts.CPU72.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU72.MCP:Machine_check_polls
      2779 ± 30%      -1.9%       2725 ± 26%  interrupts.CPU72.NMI:Non-maskable_interrupts
      2779 ± 30%      -1.9%       2725 ± 26%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
     29.20 ± 17%    +252.4%     102.90 ± 20%  interrupts.CPU72.RES:Rescheduling_interrupts
      3.40 ± 45%      -8.8%       3.10 ± 63%  interrupts.CPU72.TLB:TLB_shootdowns
      9.70 ±293%     -87.6%       1.20 ±300%  interrupts.CPU73.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
    627.70 ±  3%      -1.6%     617.50 ±  8%  interrupts.CPU73.CAL:Function_call_interrupts
      0.60 ± 81%    -100.0%       0.00        interrupts.CPU73.IWI:IRQ_work_interrupts
     71023 ±  2%      +8.2%      76858 ± 15%  interrupts.CPU73.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU73.MCP:Machine_check_polls
      2963 ± 24%     -13.8%       2553 ± 29%  interrupts.CPU73.NMI:Non-maskable_interrupts
      2963 ± 24%     -13.8%       2553 ± 29%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
     27.30 ± 24%    +321.2%     115.00 ± 21%  interrupts.CPU73.RES:Rescheduling_interrupts
      3.00 ± 33%     -23.3%       2.30 ± 75%  interrupts.CPU73.TLB:TLB_shootdowns
      0.10 ±300%    +800.0%       0.90 ±300%  interrupts.CPU74.110:PCI-MSI.31981643-edge.i40e-eth0-TxRx-74
    615.00 ±  9%      +0.2%     616.20 ±  6%  interrupts.CPU74.CAL:Function_call_interrupts
      0.40 ±122%    -100.0%       0.00        interrupts.CPU74.IWI:IRQ_work_interrupts
     71011 ±  2%      +8.2%      76854 ± 15%  interrupts.CPU74.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU74.MCP:Machine_check_polls
      2900 ± 23%      -5.4%       2744 ± 27%  interrupts.CPU74.NMI:Non-maskable_interrupts
      2900 ± 23%      -5.4%       2744 ± 27%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
     28.20 ± 25%    +282.6%     107.90 ± 16%  interrupts.CPU74.RES:Rescheduling_interrupts
      3.30 ± 35%      -6.1%       3.10 ± 56%  interrupts.CPU74.TLB:TLB_shootdowns
     25.10 ±300%    +178.5%      69.90 ±300%  interrupts.CPU75.111:PCI-MSI.31981644-edge.i40e-eth0-TxRx-75
    641.00 ±  5%      -5.0%     609.20 ±  3%  interrupts.CPU75.CAL:Function_call_interrupts
      0.60 ± 81%    -100.0%       0.00        interrupts.CPU75.IWI:IRQ_work_interrupts
     71031 ±  2%      +8.2%      76831 ± 15%  interrupts.CPU75.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU75.MCP:Machine_check_polls
      3090 ± 17%      -5.8%       2909 ± 22%  interrupts.CPU75.NMI:Non-maskable_interrupts
      3090 ± 17%      -5.8%       2909 ± 22%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
     25.50 ± 22%    +311.4%     104.90 ±  4%  interrupts.CPU75.RES:Rescheduling_interrupts
      3.20 ± 30%     -18.8%       2.60 ± 39%  interrupts.CPU75.TLB:TLB_shootdowns
      0.00       +9.4e+102%       9.40 ±282%  interrupts.CPU76.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
    621.30 ±  5%      -2.9%     603.30 ±  3%  interrupts.CPU76.CAL:Function_call_interrupts
      0.60 ± 81%    -100.0%       0.00        interrupts.CPU76.IWI:IRQ_work_interrupts
     71035 ±  2%      +8.2%      76832 ± 15%  interrupts.CPU76.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU76.MCP:Machine_check_polls
      2967 ± 25%      -2.4%       2897 ± 22%  interrupts.CPU76.NMI:Non-maskable_interrupts
      2967 ± 25%      -2.4%       2897 ± 22%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
     28.70 ± 24%    +234.5%      96.00 ± 17%  interrupts.CPU76.RES:Rescheduling_interrupts
      3.40 ± 35%     -11.8%       3.00 ± 44%  interrupts.CPU76.TLB:TLB_shootdowns
    271.50 ±294%     -96.6%       9.20 ±272%  interrupts.CPU77.113:PCI-MSI.31981646-edge.i40e-eth0-TxRx-77
    640.00 ±  7%      -4.0%     614.20 ±  3%  interrupts.CPU77.CAL:Function_call_interrupts
      0.60 ± 81%    -100.0%       0.00        interrupts.CPU77.IWI:IRQ_work_interrupts
     71000 ±  2%      +8.3%      76886 ± 15%  interrupts.CPU77.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU77.MCP:Machine_check_polls
      2956 ± 25%      -2.8%       2874 ± 22%  interrupts.CPU77.NMI:Non-maskable_interrupts
      2956 ± 25%      -2.8%       2874 ± 22%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
     28.70 ± 19%    +313.6%     118.70 ± 16%  interrupts.CPU77.RES:Rescheduling_interrupts
      3.50 ± 29%      -8.6%       3.20 ± 41%  interrupts.CPU77.TLB:TLB_shootdowns
     32.30 ±297%     +52.3%      49.20 ±198%  interrupts.CPU78.114:PCI-MSI.31981647-edge.i40e-eth0-TxRx-78
    631.40 ±  5%      -2.7%     614.30 ±  3%  interrupts.CPU78.CAL:Function_call_interrupts
      0.50 ±100%    -100.0%       0.00        interrupts.CPU78.IWI:IRQ_work_interrupts
     70983 ±  2%      +8.3%      76843 ± 15%  interrupts.CPU78.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU78.MCP:Machine_check_polls
      2936 ± 25%      +4.7%       3075 ± 16%  interrupts.CPU78.NMI:Non-maskable_interrupts
      2936 ± 25%      +4.7%       3075 ± 16%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
     27.30 ± 37%    +326.0%     116.30 ± 20%  interrupts.CPU78.RES:Rescheduling_interrupts
      3.50 ± 14%      -8.6%       3.20 ± 62%  interrupts.CPU78.TLB:TLB_shootdowns
     36.30 ±298%    -100.0%       0.00        interrupts.CPU79.115:PCI-MSI.31981648-edge.i40e-eth0-TxRx-79
    637.70 ±  3%      -3.9%     613.00 ±  3%  interrupts.CPU79.CAL:Function_call_interrupts
      0.50 ±100%    -100.0%       0.00        interrupts.CPU79.IWI:IRQ_work_interrupts
     71009 ±  2%      +8.3%      76892 ± 15%  interrupts.CPU79.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU79.MCP:Machine_check_polls
      2946 ± 24%      -8.5%       2695 ± 26%  interrupts.CPU79.NMI:Non-maskable_interrupts
      2946 ± 24%      -8.5%       2695 ± 26%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
     28.20 ± 37%    +242.2%      96.50 ± 18%  interrupts.CPU79.RES:Rescheduling_interrupts
      3.60 ± 33%      +0.0%       3.60 ± 52%  interrupts.CPU79.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU8.119:PCI-MSI.31981652-edge.i40e-eth0-TxRx-83
      0.00          -100.0%       0.00        interrupts.CPU8.287:PCI-MSI.71680-edge.ioat-msix
      0.00         +2e+101%       0.20 ±300%  interrupts.CPU8.44:PCI-MSI.31981577-edge.i40e-eth0-TxRx-8
      0.10 ±300%      +0.0%       0.10 ±300%  interrupts.CPU8.75:PCI-MSI.31981608-edge.i40e-eth0-TxRx-39
    610.50 ±  6%     +59.5%     973.80 ± 77%  interrupts.CPU8.CAL:Function_call_interrupts
      0.60 ± 81%     -33.3%       0.40 ±122%  interrupts.CPU8.IWI:IRQ_work_interrupts
     70945 ±  2%      +8.8%      77182 ± 15%  interrupts.CPU8.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU8.MCP:Machine_check_polls
      3111 ± 25%     -12.8%       2712 ± 32%  interrupts.CPU8.NMI:Non-maskable_interrupts
      3111 ± 25%     -12.8%       2712 ± 32%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
     34.20 ±  9%    +260.8%     123.40 ± 20%  interrupts.CPU8.RES:Rescheduling_interrupts
      2.60 ± 35%     -38.5%       1.60 ±108%  interrupts.CPU8.TLB:TLB_shootdowns
      0.60 ±300%      +0.0%       0.60 ±249%  interrupts.CPU80.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
    640.70 ±  4%      -4.6%     611.50 ± 12%  interrupts.CPU80.CAL:Function_call_interrupts
      0.50 ±100%    -100.0%       0.00        interrupts.CPU80.IWI:IRQ_work_interrupts
     70999 ±  2%      +8.4%      76951 ± 16%  interrupts.CPU80.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU80.MCP:Machine_check_polls
      2782 ± 30%      -7.9%       2563 ± 29%  interrupts.CPU80.NMI:Non-maskable_interrupts
      2782 ± 30%      -7.9%       2563 ± 29%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
     27.30 ± 33%    +268.5%     100.60 ± 12%  interrupts.CPU80.RES:Rescheduling_interrupts
      3.50 ± 34%     -17.1%       2.90 ± 60%  interrupts.CPU80.TLB:TLB_shootdowns
     37.40 ±285%     -23.3%      28.70 ±297%  interrupts.CPU81.117:PCI-MSI.31981650-edge.i40e-eth0-TxRx-81
    616.50 ±  9%      -0.6%     612.80 ±  2%  interrupts.CPU81.CAL:Function_call_interrupts
      0.60 ± 81%    -100.0%       0.00        interrupts.CPU81.IWI:IRQ_work_interrupts
     71008 ±  2%      +8.3%      76871 ± 15%  interrupts.CPU81.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU81.MCP:Machine_check_polls
      2825 ± 29%      -2.4%       2757 ± 26%  interrupts.CPU81.NMI:Non-maskable_interrupts
      2825 ± 29%      -2.4%       2757 ± 26%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
     29.30 ± 31%    +247.4%     101.80 ± 25%  interrupts.CPU81.RES:Rescheduling_interrupts
      3.60 ± 35%     -13.9%       3.10 ± 36%  interrupts.CPU81.TLB:TLB_shootdowns
      0.80 ±261%    +537.5%       5.10 ±152%  interrupts.CPU82.118:PCI-MSI.31981651-edge.i40e-eth0-TxRx-82
    634.70 ±  4%      -0.8%     629.40 ±  4%  interrupts.CPU82.CAL:Function_call_interrupts
      0.50 ±100%    -100.0%       0.00        interrupts.CPU82.IWI:IRQ_work_interrupts
     71020 ±  2%      +8.2%      76878 ± 15%  interrupts.CPU82.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU82.MCP:Machine_check_polls
      2792 ± 29%      +3.7%       2895 ± 20%  interrupts.CPU82.NMI:Non-maskable_interrupts
      2792 ± 29%      +3.7%       2895 ± 20%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
     29.30 ± 33%    +266.2%     107.30 ± 20%  interrupts.CPU82.RES:Rescheduling_interrupts
      3.40 ± 32%      +8.8%       3.70 ± 32%  interrupts.CPU82.TLB:TLB_shootdowns
      6.90 ±300%    -100.0%       0.00        interrupts.CPU83.119:PCI-MSI.31981652-edge.i40e-eth0-TxRx-83
    626.30            -6.0%     588.90 ± 10%  interrupts.CPU83.CAL:Function_call_interrupts
      0.30 ±152%    -100.0%       0.00        interrupts.CPU83.IWI:IRQ_work_interrupts
     71015 ±  2%      +8.2%      76862 ± 15%  interrupts.CPU83.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU83.MCP:Machine_check_polls
      2743 ± 30%      +6.0%       2908 ± 21%  interrupts.CPU83.NMI:Non-maskable_interrupts
      2743 ± 30%      +6.0%       2908 ± 21%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
     26.30 ± 31%    +287.8%     102.00 ± 29%  interrupts.CPU83.RES:Rescheduling_interrupts
      4.30 ± 34%     -30.2%       3.00 ± 33%  interrupts.CPU83.TLB:TLB_shootdowns
     43.60 ±293%     -68.8%      13.60 ±280%  interrupts.CPU84.120:PCI-MSI.31981653-edge.i40e-eth0-TxRx-84
    641.80 ±  4%      -6.0%     603.50 ±  2%  interrupts.CPU84.CAL:Function_call_interrupts
      0.60 ± 81%    -100.0%       0.00        interrupts.CPU84.IWI:IRQ_work_interrupts
     70975 ±  2%      +8.3%      76881 ± 15%  interrupts.CPU84.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU84.MCP:Machine_check_polls
      2788 ± 29%      +3.7%       2892 ± 21%  interrupts.CPU84.NMI:Non-maskable_interrupts
      2788 ± 29%      +3.7%       2892 ± 21%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
     45.50 ± 27%    +138.7%     108.60 ± 19%  interrupts.CPU84.RES:Rescheduling_interrupts
      3.60 ± 37%     -22.2%       2.80 ± 50%  interrupts.CPU84.TLB:TLB_shootdowns
      0.00       +1.3e+102%       1.30 ±299%  interrupts.CPU85.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
    625.70 ± 10%      -6.7%     583.80 ±  7%  interrupts.CPU85.CAL:Function_call_interrupts
      0.50 ±100%    -100.0%       0.00        interrupts.CPU85.IWI:IRQ_work_interrupts
     70948 ±  2%      +8.4%      76942 ± 15%  interrupts.CPU85.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU85.MCP:Machine_check_polls
      2749 ± 29%      -0.5%       2737 ± 26%  interrupts.CPU85.NMI:Non-maskable_interrupts
      2749 ± 29%      -0.5%       2737 ± 26%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
     49.20 ± 28%    +150.0%     123.00 ± 18%  interrupts.CPU85.RES:Rescheduling_interrupts
      3.60 ± 43%     +22.2%       4.40 ± 32%  interrupts.CPU85.TLB:TLB_shootdowns
      8.90 ±300%      -9.0%       8.10 ±299%  interrupts.CPU86.122:PCI-MSI.31981655-edge.i40e-eth0-TxRx-86
    636.30 ±  4%      -4.0%     610.60 ±  3%  interrupts.CPU86.CAL:Function_call_interrupts
      0.40 ±122%    -100.0%       0.00        interrupts.CPU86.IWI:IRQ_work_interrupts
     71000 ±  2%      +8.2%      76834 ± 15%  interrupts.CPU86.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU86.MCP:Machine_check_polls
      2756 ± 29%      -0.6%       2739 ± 26%  interrupts.CPU86.NMI:Non-maskable_interrupts
      2756 ± 29%      -0.6%       2739 ± 26%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
     45.90 ± 49%    +156.2%     117.60 ± 25%  interrupts.CPU86.RES:Rescheduling_interrupts
      3.80 ± 30%      +5.3%       4.00 ± 29%  interrupts.CPU86.TLB:TLB_shootdowns
      0.70 ±300%    +200.0%       2.10 ±284%  interrupts.CPU87.123:PCI-MSI.31981656-edge.i40e-eth0-TxRx-87
    600.40 ±  2%      -0.7%     596.10 ±  3%  interrupts.CPU87.CAL:Function_call_interrupts
      0.50 ±100%    -100.0%       0.00        interrupts.CPU87.IWI:IRQ_work_interrupts
     71000 ±  2%      +8.2%      76832 ± 15%  interrupts.CPU87.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU87.MCP:Machine_check_polls
      2755 ± 29%      +6.0%       2921 ± 22%  interrupts.CPU87.NMI:Non-maskable_interrupts
      2755 ± 29%      +6.0%       2921 ± 22%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
     53.30 ± 36%    +118.4%     116.40 ± 12%  interrupts.CPU87.RES:Rescheduling_interrupts
      0.50 ±100%     +40.0%       0.70 ±111%  interrupts.CPU87.TLB:TLB_shootdowns
      0.00         +3e+101%       0.30 ±152%  interrupts.CPU9.120:PCI-MSI.31981653-edge.i40e-eth0-TxRx-84
      0.00          -100.0%       0.00        interrupts.CPU9.287:PCI-MSI.69632-edge.ioat-msix
      1.70 ±200%    -100.0%       0.00        interrupts.CPU9.45:PCI-MSI.31981578-edge.i40e-eth0-TxRx-9
      0.00          -100.0%       0.00        interrupts.CPU9.76:PCI-MSI.31981609-edge.i40e-eth0-TxRx-40
    638.80 ±  3%      +0.1%     639.60 ± 10%  interrupts.CPU9.CAL:Function_call_interrupts
      0.70 ± 65%     -71.4%       0.20 ±200%  interrupts.CPU9.IWI:IRQ_work_interrupts
     70936 ±  2%      +8.9%      77239 ± 15%  interrupts.CPU9.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU9.MCP:Machine_check_polls
      3111 ± 23%      -7.9%       2864 ± 28%  interrupts.CPU9.NMI:Non-maskable_interrupts
      3111 ± 23%      -7.9%       2864 ± 28%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
     38.40 ± 20%    +205.7%     117.40 ± 10%  interrupts.CPU9.RES:Rescheduling_interrupts
      2.30 ± 47%     -30.4%       1.60 ±115%  interrupts.CPU9.TLB:TLB_shootdowns
     53.90 ± 56%     -72.0%      15.10 ±106%  interrupts.IWI:IRQ_work_interrupts
   6246811 ±  2%      +8.5%    6780137 ± 15%  interrupts.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.MCP:Machine_check_polls
    266303 ± 12%      -3.2%     257827 ±  3%  interrupts.NMI:Non-maskable_interrupts
    266303 ± 12%      -3.2%     257827 ±  3%  interrupts.PMI:Performance_monitoring_interrupts
      3090 ±  5%    +225.8%      10070        interrupts.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00        interrupts.RTR:APIC_ICR_read_retries
    241.50 ± 27%     -21.0%     190.80 ± 49%  interrupts.TLB:TLB_shootdowns




> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> dchinner@redhat.com
> 

--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.14.0-rc4-00010-g1f9942500a8b"

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

--R3G7APHDIzY6R/pk
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-set-RWSEM_SPIN_ON_OWNER-default-to-n.patch"

From d47b9c79b4aa02fe3e56794dcf06c85ca360269d Mon Sep 17 00:00:00 2001
From: Oliver Sang <oliver.sang@intel.com>
Date: Wed, 18 Aug 2021 10:22:50 +0800
Subject: [PATCH] set RWSEM_SPIN_ON_OWNER default to n

---
 kernel/Kconfig.locks | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 3de8fd11873b..de85a350dd2d 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -229,7 +229,7 @@ config MUTEX_SPIN_ON_OWNER
 	depends on SMP && ARCH_SUPPORTS_ATOMIC_RMW
 
 config RWSEM_SPIN_ON_OWNER
-       def_bool y
+       def_bool n
        depends on SMP && ARCH_SUPPORTS_ATOMIC_RMW
 
 config LOCK_SPIN_ON_OWNER
-- 
2.17.1


--R3G7APHDIzY6R/pk--
