Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFA838F865
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 04:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhEYDB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 23:01:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:23670 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhEYDB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 23:01:26 -0400
IronPort-SDR: S5fK8di7YCSVUwxQ+ZBY22jOyODlo/S3mk9spTGS+usrkYUPz+9VJKblOXmug/ncd7nkAkmWM1
 8Yd1DoHv/4lQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="189463216"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="yaml'?scan'208";a="189463216"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 19:59:56 -0700
IronPort-SDR: agoSU3LTKgPO7lakA6G4UJbM7v0xFtsuQup9+qZTiu6M4TekjkuzHLgD/tZs/TtAiPDKV2l2A9
 SRB0q6exXFGQ==
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="yaml'?scan'208";a="476189399"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 19:59:51 -0700
Date:   Tue, 25 May 2021 11:16:36 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: [mm/gup]  57efa1fe59:  will-it-scale.per_thread_ops -9.2% regression
Message-ID: <20210525031636.GB7744@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Greeting,

FYI, we noticed a -9.2% regression of will-it-scale.per_thread_ops due to commit:


commit: 57efa1fe5957694fa541c9062de0a127f0b9acb0 ("mm/gup: prevent gup_fast from racing with COW during fork")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: will-it-scale
on test machine: 96 threads 2 sockets Ice Lake with 256G memory
with following parameters:

	nr_task: 50%
	mode: thread
	test: mmap1
	cpufreq_governor: performance
	ucode: 0xb000280

test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
test-url: https://github.com/antonblanchard/will-it-scale

In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops 3.7% improvement                    |
| test machine     | 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                                    |
|                  | mode=thread                                                                     |
|                  | nr_task=50%                                                                     |
|                  | test=mmap1                                                                      |
|                  | ucode=0x5003006                                                                 |
+------------------+---------------------------------------------------------------------------------+


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
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/thread/50%/debian-10.4-x86_64-20200603.cgz/lkp-icl-2sp1/mmap1/will-it-scale/0xb000280

commit: 
  c28b1fc703 ("mm/gup: reorganize internal_get_user_pages_fast()")
  57efa1fe59 ("mm/gup: prevent gup_fast from racing with COW during fork")

c28b1fc70390df32 57efa1fe5957694fa541c9062de 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    342141            -9.2%     310805 ±  2%  will-it-scale.48.threads
      7127            -9.2%       6474 ±  2%  will-it-scale.per_thread_ops
    342141            -9.2%     310805 ±  2%  will-it-scale.workload
   2555927 ±  3%     +45.8%    3727702        meminfo.Committed_AS
     12108 ± 13%     -36.7%       7665 ±  7%  vmstat.system.cs
   1142492 ± 30%     -47.3%     602364 ± 11%  cpuidle.C1.usage
    282373 ± 13%     -45.6%     153684 ±  7%  cpuidle.POLL.usage
     48437 ±  3%      -5.9%      45563        proc-vmstat.nr_active_anon
     54617 ±  3%      -5.5%      51602        proc-vmstat.nr_shmem
     48437 ±  3%      -5.9%      45563        proc-vmstat.nr_zone_active_anon
     70511 ±  3%      -5.1%      66942 ±  2%  proc-vmstat.pgactivate
    278653 ±  8%     +23.4%     343904 ±  4%  sched_debug.cpu.avg_idle.stddev
     22572 ± 16%     -36.3%      14378 ±  4%  sched_debug.cpu.nr_switches.avg
     66177 ± 16%     -36.8%      41800 ± 21%  sched_debug.cpu.nr_switches.max
     11613 ± 15%     -41.4%       6810 ± 23%  sched_debug.cpu.nr_switches.stddev
     22.96 ± 15%     +55.6%      35.73 ± 12%  perf-sched.total_wait_and_delay.average.ms
     69713 ± 19%     -38.0%      43235 ± 12%  perf-sched.total_wait_and_delay.count.ms
     22.95 ± 15%     +55.6%      35.72 ± 12%  perf-sched.total_wait_time.average.ms
     29397 ± 23%     -35.3%      19030 ± 17%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.down_write_killable.__vm_munmap.__x64_sys_munmap
     31964 ± 20%     -50.8%      15738 ± 14%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
      4.59 ±  6%     +12.2%       5.15 ±  4%  perf-stat.i.MPKI
 3.105e+09            -2.1%   3.04e+09        perf-stat.i.branch-instructions
     12033 ± 12%     -36.8%       7600 ±  7%  perf-stat.i.context-switches
     10.06            +1.9%      10.25        perf-stat.i.cpi
 4.067e+09            -1.3%  4.016e+09        perf-stat.i.dTLB-loads
 4.521e+08            -5.1%  4.291e+08 ±  2%  perf-stat.i.dTLB-stores
 1.522e+10            -1.6%  1.497e+10        perf-stat.i.instructions
      0.10            -1.9%       0.10        perf-stat.i.ipc
      0.19 ±  8%     -22.8%       0.15 ±  5%  perf-stat.i.metric.K/sec
     80.30            -1.7%      78.93        perf-stat.i.metric.M/sec
    167270 ±  6%     -14.9%     142312 ± 11%  perf-stat.i.node-loads
     49.76            -1.6       48.11        perf-stat.i.node-store-miss-rate%
   3945152            +6.2%    4189006        perf-stat.i.node-stores
      4.59 ±  6%     +12.1%       5.15 ±  4%  perf-stat.overall.MPKI
     10.04            +1.8%      10.23        perf-stat.overall.cpi
      0.10            -1.8%       0.10        perf-stat.overall.ipc
     49.76            -1.6       48.12        perf-stat.overall.node-store-miss-rate%
  13400506            +8.2%   14504566        perf-stat.overall.path-length
 3.094e+09            -2.1%   3.03e+09        perf-stat.ps.branch-instructions
     12087 ± 13%     -36.9%       7622 ±  7%  perf-stat.ps.context-switches
 4.054e+09            -1.3%  4.002e+09        perf-stat.ps.dTLB-loads
 4.508e+08            -5.1%  4.278e+08 ±  2%  perf-stat.ps.dTLB-stores
 1.516e+10            -1.6%  1.492e+10        perf-stat.ps.instructions
   3932404            +6.2%    4175831        perf-stat.ps.node-stores
 4.584e+12            -1.7%  4.506e+12        perf-stat.total.instructions
    364038 ±  6%     -40.3%     217265 ±  9%  interrupts.CAL:Function_call_interrupts
      5382 ± 33%     -63.4%       1970 ± 35%  interrupts.CPU44.CAL:Function_call_interrupts
      6325 ± 19%     -58.1%       2650 ± 37%  interrupts.CPU47.CAL:Function_call_interrupts
     11699 ± 19%     -60.6%       4610 ± 23%  interrupts.CPU48.CAL:Function_call_interrupts
     94.20 ± 22%     -45.8%      51.09 ± 46%  interrupts.CPU48.TLB:TLB_shootdowns
      9223 ± 24%     -52.5%       4383 ± 28%  interrupts.CPU49.CAL:Function_call_interrupts
      9507 ± 24%     -57.5%       4040 ± 27%  interrupts.CPU50.CAL:Function_call_interrupts
      4530 ± 18%     -33.9%       2993 ± 28%  interrupts.CPU62.CAL:Function_call_interrupts
     82.00 ± 21%     -41.9%      47.64 ± 38%  interrupts.CPU63.TLB:TLB_shootdowns
      4167 ± 16%     -45.4%       2276 ± 22%  interrupts.CPU64.CAL:Function_call_interrupts
    135.20 ± 31%     -58.4%      56.27 ± 51%  interrupts.CPU64.TLB:TLB_shootdowns
      4155 ± 17%     -42.5%       2387 ± 27%  interrupts.CPU65.CAL:Function_call_interrupts
     95.00 ± 48%     -53.8%      43.91 ± 42%  interrupts.CPU65.TLB:TLB_shootdowns
      4122 ± 20%     -39.4%       2497 ± 29%  interrupts.CPU66.CAL:Function_call_interrupts
      3954 ± 14%     -41.4%       2318 ± 28%  interrupts.CPU67.CAL:Function_call_interrupts
      3802 ± 17%     -41.9%       2209 ± 17%  interrupts.CPU70.CAL:Function_call_interrupts
      3787 ± 11%     -48.2%       1961 ± 29%  interrupts.CPU71.CAL:Function_call_interrupts
      3580 ± 14%     -45.1%       1964 ± 19%  interrupts.CPU72.CAL:Function_call_interrupts
      3711 ± 20%     -51.3%       1806 ± 25%  interrupts.CPU73.CAL:Function_call_interrupts
      3494 ± 21%     -40.6%       2076 ± 21%  interrupts.CPU76.CAL:Function_call_interrupts
      3416 ± 21%     -45.2%       1873 ± 26%  interrupts.CPU77.CAL:Function_call_interrupts
      3047 ± 24%     -38.0%       1890 ± 18%  interrupts.CPU78.CAL:Function_call_interrupts
      3102 ± 28%     -41.8%       1805 ± 16%  interrupts.CPU80.CAL:Function_call_interrupts
      2811 ± 23%     -36.5%       1785 ± 22%  interrupts.CPU83.CAL:Function_call_interrupts
      2617 ± 17%     -30.7%       1814 ± 30%  interrupts.CPU84.CAL:Function_call_interrupts
      3322 ± 25%     -38.1%       2055 ± 29%  interrupts.CPU87.CAL:Function_call_interrupts
      2941 ± 12%     -39.2%       1787 ± 27%  interrupts.CPU93.CAL:Function_call_interrupts
     72.56           -19.7       52.82        perf-profile.calltrace.cycles-pp.__mmap
     72.52           -19.7       52.78        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
     72.48           -19.7       52.74        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     72.49           -19.7       52.76        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     72.47           -19.7       52.74        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     71.74           -19.7       52.04        perf-profile.calltrace.cycles-pp.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     71.63           -19.7       51.95        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
     71.52           -19.6       51.88        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
     70.12           -19.2       50.92        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
      0.91 ±  2%      -0.2        0.70        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
      0.87 ±  2%      +0.1        0.95 ±  2%  perf-profile.calltrace.cycles-pp.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.63 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
     24.24 ±  3%     +19.4       43.62        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
     24.72 ±  3%     +19.8       44.47        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.__vm_munmap.__x64_sys_munmap
     24.87 ±  3%     +19.8       44.62        perf-profile.calltrace.cycles-pp.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.78 ±  3%     +19.8       44.54        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
     25.94 ±  3%     +19.8       45.73        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     25.97 ±  3%     +19.8       45.77        perf-profile.calltrace.cycles-pp.__munmap
     25.90 ±  3%     +19.8       45.70        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     25.88 ±  3%     +19.8       45.68        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     25.87 ±  3%     +19.8       45.67        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     72.57           -19.7       52.83        perf-profile.children.cycles-pp.__mmap
     72.48           -19.7       52.74        perf-profile.children.cycles-pp.ksys_mmap_pgoff
     72.48           -19.7       52.74        perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.22 ±  5%      -0.1        0.14 ±  6%  perf-profile.children.cycles-pp.unmap_region
      0.08 ± 23%      -0.0        0.04 ± 61%  perf-profile.children.cycles-pp.__schedule
      0.06 ±  7%      -0.0        0.03 ± 75%  perf-profile.children.cycles-pp.perf_event_mmap
      0.12 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.up_write
      0.09 ±  7%      -0.0        0.06 ± 16%  perf-profile.children.cycles-pp.unmap_vmas
      0.10 ±  4%      -0.0        0.08 ±  3%  perf-profile.children.cycles-pp.up_read
      0.18 ±  2%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.vm_area_dup
      0.18 ±  5%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.vma_merge
      0.12 ±  4%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.kmem_cache_free
      0.19 ±  6%      +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.get_unmapped_area
      0.16 ±  6%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.17 ±  6%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.07 ± 10%      +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.find_vma
      0.27 ±  4%      +0.1        0.35 ±  2%  perf-profile.children.cycles-pp.__vma_adjust
      0.35 ±  2%      +0.1        0.43 ±  3%  perf-profile.children.cycles-pp.__split_vma
      0.87 ±  2%      +0.1        0.95 ±  2%  perf-profile.children.cycles-pp.__do_munmap
      1.23            +0.1        1.33        perf-profile.children.cycles-pp.rwsem_spin_on_owner
     25.98 ±  3%     +19.8       45.78        perf-profile.children.cycles-pp.__munmap
     25.87 ±  3%     +19.8       45.68        perf-profile.children.cycles-pp.__vm_munmap
     25.88 ±  3%     +19.8       45.68        perf-profile.children.cycles-pp.__x64_sys_munmap
      0.53 ±  2%      -0.2        0.35 ±  3%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.08 ±  5%      -0.1        0.03 ± 75%  perf-profile.self.cycles-pp.do_mmap
      0.11 ±  6%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.up_write
      0.19 ±  4%      -0.0        0.16 ±  5%  perf-profile.self.cycles-pp.down_write_killable
      0.05 ±  8%      +0.0        0.07 ±  8%  perf-profile.self.cycles-pp.downgrade_write
      0.11 ±  4%      +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.__vma_adjust
      0.16 ±  6%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.vm_unmapped_area
      0.05 ±  9%      +0.0        0.10 ± 13%  perf-profile.self.cycles-pp.find_vma
      1.21            +0.1        1.31        perf-profile.self.cycles-pp.rwsem_spin_on_owner


                                                                                
                           will-it-scale.per_thread_ops                         
                                                                                
  7400 +--------------------------------------------------------------------+   
       |                                                      +             |   
  7200 |.++.                  .+. +.+        .++.            : :.+ .+  +.   |   
       |    ++.+.++         ++   +   +.+.++.+    ++.+.++.++. : +  +  : : +  |   
  7000 |-+         + +     :                                +        ::     |   
       |            + + .+ :                                          +     |   
  6800 |-+             +  +                                                 |   
       |                                                          O         |   
  6600 |-+        O    O            O  O    O O  OO      OO    O            |   
       | OO  O   O  O    OO O        O   O     O    O  O    O O          O  |   
  6400 |-+     O     O       O O  O                   O               OO  O |   
       |                                  O                      O  O       |   
  6200 |-+                       O                                          |   
       |    O                                                               |   
  6000 +--------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2sp9: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/thread/50%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp9/mmap1/will-it-scale/0x5003006

commit: 
  c28b1fc703 ("mm/gup: reorganize internal_get_user_pages_fast()")
  57efa1fe59 ("mm/gup: prevent gup_fast from racing with COW during fork")

c28b1fc70390df32 57efa1fe5957694fa541c9062de 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    247840            +3.7%     257132 ±  2%  will-it-scale.44.threads
      5632            +3.7%       5843 ±  2%  will-it-scale.per_thread_ops
    247840            +3.7%     257132 ±  2%  will-it-scale.workload
      0.10 ±  5%      +0.0        0.13 ±  8%  perf-profile.children.cycles-pp.find_vma
     14925 ± 19%     -48.2%       7724 ±  8%  softirqs.CPU87.SCHED
      9950 ±  3%     -36.1%       6355 ±  2%  vmstat.system.cs
   3312916 ±  4%     +13.9%    3774536 ±  9%  cpuidle.C1.time
   1675504 ±  5%     -36.6%    1061625        cpuidle.POLL.time
    987055 ±  5%     -41.8%     574757 ±  2%  cpuidle.POLL.usage
    165545 ±  3%     -12.2%     145358 ±  4%  meminfo.Active
    165235 ±  3%     -12.1%     145188 ±  4%  meminfo.Active(anon)
    180757 ±  3%     -11.7%     159538 ±  3%  meminfo.Shmem
   2877001 ± 11%     +16.2%    3342948 ± 10%  sched_debug.cfs_rq:/.min_vruntime.avg
   5545708 ± 11%      +9.8%    6086941 ±  8%  sched_debug.cfs_rq:/.min_vruntime.max
   2773178 ± 11%     +15.4%    3199941 ±  9%  sched_debug.cfs_rq:/.spread0.avg
    733740 ±  3%     -12.0%     646033 ±  5%  sched_debug.cpu.avg_idle.avg
     17167 ± 10%     -28.2%      12332 ±  7%  sched_debug.cpu.nr_switches.avg
     49180 ± 14%     -33.5%      32687 ± 22%  sched_debug.cpu.nr_switches.max
      9311 ± 18%     -36.2%       5943 ± 22%  sched_debug.cpu.nr_switches.stddev
     41257 ±  3%     -12.1%      36252 ±  4%  proc-vmstat.nr_active_anon
    339681            -1.6%     334294        proc-vmstat.nr_file_pages
     10395            -3.5%      10036        proc-vmstat.nr_mapped
     45130 ±  3%     -11.7%      39848 ±  3%  proc-vmstat.nr_shmem
     41257 ±  3%     -12.1%      36252 ±  4%  proc-vmstat.nr_zone_active_anon
    841530            -1.7%     826917        proc-vmstat.numa_local
     21515 ± 11%     -68.9%       6684 ± 70%  proc-vmstat.numa_pages_migrated
     60224 ±  3%     -11.1%      53513 ±  3%  proc-vmstat.pgactivate
    981265            -2.5%     956415        proc-vmstat.pgalloc_normal
    895893            -1.9%     878978        proc-vmstat.pgfree
     21515 ± 11%     -68.9%       6684 ± 70%  proc-vmstat.pgmigrate_success
      0.07 ±135%     -74.1%       0.02 ±  5%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity
     21.44 ±  5%     +80.9%      38.79 ±  3%  perf-sched.total_wait_and_delay.average.ms
     67273 ±  6%     -44.9%      37095 ±  5%  perf-sched.total_wait_and_delay.count.ms
     21.44 ±  5%     +80.9%      38.79 ±  3%  perf-sched.total_wait_time.average.ms
      0.08 ± 14%     +60.1%       0.13 ±  9%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.down_write_killable.__vm_munmap.__x64_sys_munmap
      0.09 ± 12%     +58.0%       0.15 ± 15%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
    255.38 ± 14%     +22.1%     311.71 ± 17%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     31877 ± 10%     -54.2%      14606 ± 13%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.down_write_killable.__vm_munmap.__x64_sys_munmap
     27110 ±  7%     -47.3%      14280 ±  4%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
    138.60 ± 13%     -21.4%     109.00 ± 15%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      1.00 ±199%     -99.9%       0.00 ±200%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.remove_vma.__do_munmap.__vm_munmap
      0.08 ± 14%     +60.9%       0.13 ±  9%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.down_write_killable.__vm_munmap.__x64_sys_munmap
      0.09 ± 12%     +58.2%       0.15 ± 15%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
    255.38 ± 14%     +22.1%     311.71 ± 17%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      1.00 ±199%     -99.9%       0.00 ±200%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.remove_vma.__do_munmap.__vm_munmap
      4.99           -36.1%       3.19 ± 36%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      9869 ±  3%     -36.2%       6295 ±  2%  perf-stat.i.context-switches
      0.00 ±  7%      +0.0        0.00 ± 29%  perf-stat.i.dTLB-load-miss-rate%
     76953 ±  7%    +327.4%     328871 ± 29%  perf-stat.i.dTLB-load-misses
   4152320            -3.0%    4026365        perf-stat.i.iTLB-load-misses
   1665297            -2.2%    1628746        perf-stat.i.iTLB-loads
      8627            +3.5%       8933        perf-stat.i.instructions-per-iTLB-miss
      0.33 ±  3%     -11.0%       0.29 ±  6%  perf-stat.i.metric.K/sec
     87.42            +1.7       89.11        perf-stat.i.node-load-miss-rate%
   7507752            -9.2%    6814138        perf-stat.i.node-load-misses
   1078418 ±  2%     -22.9%     831563 ±  3%  perf-stat.i.node-loads
   3091445            -8.2%    2838247        perf-stat.i.node-store-misses
      0.00 ±  7%      +0.0        0.00 ± 29%  perf-stat.overall.dTLB-load-miss-rate%
      8599            +3.6%       8907        perf-stat.overall.instructions-per-iTLB-miss
     87.44            +1.7       89.13        perf-stat.overall.node-load-miss-rate%
  43415811            -3.3%   41994695 ±  2%  perf-stat.overall.path-length
      9895 ±  3%     -36.4%       6291 ±  2%  perf-stat.ps.context-switches
     76756 ±  7%    +327.0%     327716 ± 29%  perf-stat.ps.dTLB-load-misses
   4138410            -3.0%    4012712        perf-stat.ps.iTLB-load-misses
   1659653            -2.2%    1623167        perf-stat.ps.iTLB-loads
   7483002            -9.2%    6791226        perf-stat.ps.node-load-misses
   1074856 ±  2%     -22.9%     828780 ±  3%  perf-stat.ps.node-loads
   3081222            -8.2%    2828732        perf-stat.ps.node-store-misses
    335021 ±  2%     -27.9%     241715 ± 12%  interrupts.CAL:Function_call_interrupts
      3662 ± 31%     -61.3%       1417 ± 16%  interrupts.CPU10.CAL:Function_call_interrupts
      4671 ± 32%     -65.6%       1607 ± 30%  interrupts.CPU12.CAL:Function_call_interrupts
      4999 ± 34%     -68.1%       1592 ± 43%  interrupts.CPU14.CAL:Function_call_interrupts
    129.00 ± 30%     -46.8%      68.60 ± 34%  interrupts.CPU14.RES:Rescheduling_interrupts
      4531 ± 49%     -58.5%       1881 ± 39%  interrupts.CPU15.CAL:Function_call_interrupts
      4639 ± 28%     -37.6%       2893 ±  2%  interrupts.CPU18.NMI:Non-maskable_interrupts
      4639 ± 28%     -37.6%       2893 ±  2%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
      6310 ± 49%     -68.5%       1988 ± 57%  interrupts.CPU21.CAL:Function_call_interrupts
    149.40 ± 49%     -49.3%      75.80 ± 42%  interrupts.CPU21.RES:Rescheduling_interrupts
      3592 ± 38%     -63.0%       1330 ± 14%  interrupts.CPU24.CAL:Function_call_interrupts
      5350 ± 21%     -30.5%       3720 ± 44%  interrupts.CPU24.NMI:Non-maskable_interrupts
      5350 ± 21%     -30.5%       3720 ± 44%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
    139.00 ± 27%     -33.4%      92.60 ± 26%  interrupts.CPU24.RES:Rescheduling_interrupts
      3858 ± 42%     -53.7%       1785 ± 38%  interrupts.CPU26.CAL:Function_call_interrupts
      5964 ± 28%     -42.4%       3432 ± 55%  interrupts.CPU27.NMI:Non-maskable_interrupts
      5964 ± 28%     -42.4%       3432 ± 55%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
      3429 ± 37%     -57.1%       1470 ± 44%  interrupts.CPU28.CAL:Function_call_interrupts
      3008 ± 35%     -37.6%       1877 ± 38%  interrupts.CPU29.CAL:Function_call_interrupts
      4684 ± 73%     -60.0%       1872 ± 34%  interrupts.CPU30.CAL:Function_call_interrupts
      4300 ± 46%     -54.7%       1949 ± 13%  interrupts.CPU43.CAL:Function_call_interrupts
     10255 ± 26%     -50.0%       5127 ± 29%  interrupts.CPU44.CAL:Function_call_interrupts
      5800 ± 20%     -28.3%       4158 ± 27%  interrupts.CPU52.CAL:Function_call_interrupts
      4802 ± 19%     -31.7%       3279 ± 18%  interrupts.CPU58.CAL:Function_call_interrupts
      4042 ± 32%     -65.6%       1391 ± 41%  interrupts.CPU6.CAL:Function_call_interrupts
    128.60 ± 31%     -52.9%      60.60 ± 38%  interrupts.CPU6.RES:Rescheduling_interrupts
      4065 ± 20%     -37.8%       2530 ±  6%  interrupts.CPU63.CAL:Function_call_interrupts
      4340 ± 24%     -36.2%       2771 ± 11%  interrupts.CPU64.CAL:Function_call_interrupts
      3983 ± 11%     -27.1%       2904 ± 19%  interrupts.CPU65.CAL:Function_call_interrupts
      3392 ± 25%     -55.2%       1518 ± 53%  interrupts.CPU7.CAL:Function_call_interrupts
    171.80 ± 67%     -62.5%      64.40 ± 32%  interrupts.CPU7.RES:Rescheduling_interrupts
      2942 ± 33%     -50.5%       1455 ± 25%  interrupts.CPU8.CAL:Function_call_interrupts
      7818           -27.3%       5681 ± 31%  interrupts.CPU85.NMI:Non-maskable_interrupts
      7818           -27.3%       5681 ± 31%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
    320.80 ± 54%     -44.6%     177.80 ± 58%  interrupts.CPU87.TLB:TLB_shootdowns
      3212 ± 31%     -64.8%       1130 ± 36%  interrupts.CPU9.CAL:Function_call_interrupts





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='will-it-scale'
	export testcase='will-it-scale'
	export category='benchmark'
	export nr_task=48
	export job_origin='will-it-scale-part2.yaml'
	export queue_cmdline_keys=
	export queue='vip'
	export testbox='lkp-icl-2sp1'
	export tbox_group='lkp-icl-2sp1'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='608271eb0b9a9366cf75aa8b'
	export job_file='/lkp/jobs/scheduled/lkp-icl-2sp1/will-it-scale-performance-thread-50%-mmap1-ucode=0xb000280-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-57efa1fe5957694fa541-20210423-26319-1fupkzh-3.yaml'
	export id='2d333079611b73199587392d819fd36dc870581a'
	export queuer_version='/lkp/xsang/.src-20210423-103236'
	export model='Ice Lake'
	export nr_node=2
	export nr_cpu=96
	export memory='256G'
	export nr_hdd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-ST9500530NS_9SP1KLAR-part1'
	export ssd_partitions='/dev/nvme0n1p1'
	export swap_partitions=
	export kernel_cmdline_hw='acpi_rsdp=0x665fd014'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204005K800RGN-part3'
	export commit='57efa1fe5957694fa541c9062de0a127f0b9acb0'
	export ucode='0xb000280'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_IXGBE=y
CONFIG_SATA_AHCI'
	export enqueue_time='2021-04-23 15:06:19 +0800'
	export _id='608271ef0b9a9366cf75aa8e'
	export _rt='/result/will-it-scale/performance-thread-50%-mmap1-ucode=0xb000280-monitor=70d6d718/lkp-icl-2sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/57efa1fe5957694fa541c9062de0a127f0b9acb0'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='59d492ff832e57456a83d5652009434a44874a3e'
	export base_commit='f40ddce88593482919761f74910f42f4b84c004b'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='70d6d718'
	export result_root='/result/will-it-scale/performance-thread-50%-mmap1-ucode=0xb000280-monitor=70d6d718/lkp-icl-2sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/57efa1fe5957694fa541c9062de0a127f0b9acb0/8'
	export scheduler_version='/lkp/lkp/.src-20210422-153727'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-icl-2sp1/will-it-scale-performance-thread-50%-mmap1-ucode=0xb000280-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-57efa1fe5957694fa541-20210423-26319-1fupkzh-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=57efa1fe5957694fa541c9062de0a127f0b9acb0
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/57efa1fe5957694fa541c9062de0a127f0b9acb0/vmlinuz-5.10.0-00044-g57efa1fe5957
acpi_rsdp=0x665fd014
max_uptime=2100
RESULT_ROOT=/result/will-it-scale/performance-thread-50%-mmap1-ucode=0xb000280-monitor=70d6d718/lkp-icl-2sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/57efa1fe5957694fa541c9062de0a127f0b9acb0/8
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/57efa1fe5957694fa541c9062de0a127f0b9acb0/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/will-it-scale_20210401.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/will-it-scale-x86_64-a34a85c-1_20210401.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-d19cc4bfbff1-1_20210401.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.10.0-00044-g57efa1fe5957'
	export good_samples='7084
6873
6971'
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/57efa1fe5957694fa541c9062de0a127f0b9acb0/vmlinuz-5.10.0-00044-g57efa1fe5957'
	export dequeue_time='2021-04-23 16:58:17 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-icl-2sp1/will-it-scale-performance-thread-50%-mmap1-ucode=0xb000280-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-57efa1fe5957694fa541-20210423-26319-1fupkzh-3.cgz'

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
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor pmeter_server='lkp-nhm-dp2' pmeter_device='yokogawa-wt310' $LKP_SRC/monitors/wrapper pmeter
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test mode='thread' test='mmap1' $LKP_SRC/tests/wrapper will-it-scale
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env mode='thread' test='mmap1' $LKP_SRC/stats/wrapper will-it-scale
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
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	$LKP_SRC/stats/wrapper perf-profile
	env pmeter_server='lkp-nhm-dp2' pmeter_device='yokogawa-wt310' $LKP_SRC/stats/wrapper pmeter

	$LKP_SRC/stats/wrapper time will-it-scale.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
suite: will-it-scale
testcase: will-it-scale
category: benchmark
nr_task: 50%
will-it-scale:
  mode: thread
  test: mmap1
job_origin: will-it-scale-part2.yaml
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-icl-2sp1
tbox_group: lkp-icl-2sp1
kconfig: x86_64-rhel-8.3
submit_id: 6039018663f28a9f5549bb6e
job_file: "/lkp/jobs/scheduled/lkp-icl-2sp1/will-it-scale-performance-thread-50%-mmap1-ucode=0xb000280-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-57efa1fe5957694fa541-20210226-40789-1bw58rx-2.yaml"
id: 568034105811dd2aa8af615c3d1cbd509191f301
queuer_version: "/lkp-src"
model: Ice Lake
nr_node: 2
nr_cpu: 96
memory: 256G
nr_hdd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-ST9500530NS_9SP1KLAR-part1"
ssd_partitions: "/dev/nvme0n1p1"
swap_partitions: 
kernel_cmdline_hw: acpi_rsdp=0x665fd014
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204005K800RGN-part3"
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
sched_debug: 
perf-stat: 
mpstat: 
perf-profile: 
cpufreq_governor: performance
commit: 57efa1fe5957694fa541c9062de0a127f0b9acb0
ucode: '0xb000280'
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_IXGBE=y
- CONFIG_SATA_AHCI
pmeter:
  pmeter_server: lkp-nhm-dp2
  pmeter_device: yokogawa-wt310
enqueue_time: 2021-02-26 22:11:18.355364388 +08:00
_id: 603906b363f28a9f5549bb70
_rt: "/result/will-it-scale/performance-thread-50%-mmap1-ucode=0xb000280-monitor=70d6d718/lkp-icl-2sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/57efa1fe5957694fa541c9062de0a127f0b9acb0"
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 59d492ff832e57456a83d5652009434a44874a3e
base_commit: f40ddce88593482919761f74910f42f4b84c004b
branch: linus/master
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 70d6d718
result_root: "/result/will-it-scale/performance-thread-50%-mmap1-ucode=0xb000280-monitor=70d6d718/lkp-icl-2sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/57efa1fe5957694fa541c9062de0a127f0b9acb0/0"
scheduler_version: "/lkp/lkp/.src-20210226-170207"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-icl-2sp1/will-it-scale-performance-thread-50%-mmap1-ucode=0xb000280-monitor=70d6d718-debian-10.4-x86_64-20200603.cgz-57efa1fe5957694fa541-20210226-40789-1bw58rx-2.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linus/master
- commit=57efa1fe5957694fa541c9062de0a127f0b9acb0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/57efa1fe5957694fa541c9062de0a127f0b9acb0/vmlinuz-5.10.0-00044-g57efa1fe5957
- acpi_rsdp=0x665fd014
- max_uptime=2100
- RESULT_ROOT=/result/will-it-scale/performance-thread-50%-mmap1-ucode=0xb000280-monitor=70d6d718/lkp-icl-2sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/57efa1fe5957694fa541c9062de0a127f0b9acb0/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/57efa1fe5957694fa541c9062de0a127f0b9acb0/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/will-it-scale_20210108.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/will-it-scale-x86_64-6b6f1f6-1_20210108.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-e71ba9452f0b-1_20210106.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 
last_kernel: 5.11.0-07287-g933a73780a7a
repeat_to: 3
good_samples:
- 7084
- 6873
- 6971

#! queue options

#! user overrides
queue_at_least_once: 0

#! schedule options
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/57efa1fe5957694fa541c9062de0a127f0b9acb0/vmlinuz-5.10.0-00044-g57efa1fe5957"
dequeue_time: 2021-02-26 22:36:05.668722260 +08:00

#! /lkp/lkp/.src-20210226-170207/include/site/inn

#! runtime status
job_state: finished
loadavg: 40.45 29.66 13.27 1/716 10184
start_time: '1614350233'
end_time: '1614350535'
version: "/lkp/lkp/.src-20210226-170239:f6d2b143:03255feb8"

--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "/lkp/benchmarks/python3/bin/python3" "./runtest.py" "mmap1" "295" "thread" "48"

--aM3YZ0Iwxop3KEKx--
