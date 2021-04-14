Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AA335FDC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 00:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhDNW2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 18:28:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:27625 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231207AbhDNW2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 18:28:16 -0400
IronPort-SDR: 7OMB4vKZu1zGihTiezKNvON0iaS1rsOCXtwgmm389eVKvg6UUalS+ZmR+20RofrorQEKVdTBW5
 STq2onfzYCpQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="194313232"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="194313232"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 15:27:54 -0700
IronPort-SDR: E1HUbE8H0p536tavThvDGbwkxkhL1lSYJz7o6WmdesbPwVLoYfd7xZ9qh3tQ87VQ0u4hV4Q7qD
 shiv5rpUh/Dw==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="418510218"
Received: from pradhakr-mobl1.amr.corp.intel.com ([10.212.182.24])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 15:27:54 -0700
Message-ID: <8d587ee3243d5d3d9c5ae83d38567ff1553cd7c5.camel@linux.intel.com>
Subject: Re: [thermal]  9223d0dccb:  stress-ng.msg.ops_per_sec -27.4%
 regression
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     kernel test robot <oliver.sang@intel.com>,
        Borislav Petkov <bp@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Date:   Wed, 14 Apr 2021 15:27:53 -0700
In-Reply-To: <20210413135800.GA10266@xsang-OptiPlex-9020>
References: <20210413135800.GA10266@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-04-13 at 21:58 +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a -27.4% regression of stress-ng.msg.ops_per_sec due
> to commit:
> 
> 
> commit: 9223d0dccb8f8523754122f68316dd1a4f39f7f8 ("thermal: Move
> therm_throt there from x86/mce")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
> master
> 
> 
> in testcase: stress-ng
> on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz
> with 192G memory
> with following parameters:
> 
> 	nr_threads: 10%
> 	disk: 1HDD
> 	testtime: 60s
> 	fs: ext4
> 	class: os
> 	test: msg
> 	cpufreq_governor: performance
> 	ucode: 0x5003006
> 
> 
> 

Is this reproducible? This patch doesn't set any value which restricts
performance. This driver reports the threshold violations.
It is possible that somehow we reached a thermal limit where we got
many interrupts in one run.

Thanks.


> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> Details are as below:
> -------------------------------------------------------------------
> ------------------------------->
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install                job.yaml  # job file is
> attached in this email
>         bin/lkp split-job --compatible job.yaml
>         bin/lkp run                    compatible-job.yaml
> 
> =====================================================================
> ====================
> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbo
> x_group/test/testcase/testtime/ucode:
>   os/gcc-9/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-10.4-
> x86_64-20200603.cgz/lkp-csl-2sp5/msg/stress-ng/60s/0x5003006
> 
> commit: 
>   4f432e8bb1 ("x86/mce: Get rid of mcheck_intel_therm_init()")
>   9223d0dccb ("thermal: Move therm_throt there from x86/mce")
> 
> 4f432e8bb15b352d 9223d0dccb8f8523754122f6831 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>  3.042e+08 ±  4%     -27.4%  2.209e+08 ±  2%  stress-ng.msg.ops
>    5069470 ±  4%     -27.4%    3682272 ±  2%  stress-
> ng.msg.ops_per_sec
>       2335 ±  8%     -35.0%       1517 ± 18%  stress-
> ng.time.involuntary_context_switches
>       1676            -4.9%       1594        stress-
> ng.time.percent_of_cpu_this_job_got
>       1019            -4.6%     973.25        stress-
> ng.time.system_time
>      20.97 ±  2%     -19.3%      16.93 ±  2%  stress-
> ng.time.user_time
>    1549846 ±159%   +1738.5%   28494120 ± 16%  stress-
> ng.time.voluntary_context_switches
>    2050707 ±134%   +1531.7%   33461885 ± 21%  cpuidle.POLL.time
>    1354230 ±171%   +1585.0%   22819237 ± 19%  cpuidle.POLL.usage
>      82.39            +1.2%      83.37        iostat.cpu.idle
>      17.20            -5.3%      16.29        iostat.cpu.system
>       0.04 ±  5%      +0.0        0.05 ±  3%  mpstat.cpu.all.soft%
>       0.37 ±  2%      -0.1        0.30 ±  2%  mpstat.cpu.all.usr%
>    1337633 ± 28%     -65.8%     457460 ± 95%  numa-
> numastat.node0.local_node
>     456832 ± 26%     -67.5%     148621 ± 25%  numa-
> numastat.node1.local_node
>     500231 ± 26%     -64.1%     179602 ± 12%  numa-
> numastat.node1.numa_hit
>      82.00            +1.2%      83.00        vmstat.cpu.id
>      49550 ±153%   +1673.1%     878579 ± 16%  vmstat.system.cs
>     197941           +26.4%     250229 ±  6%  vmstat.system.in
>      41605            -1.4%      41020        proc-
> vmstat.nr_slab_unreclaimable
>    1907890 ± 15%     -62.0%     724187 ± 63%  proc-vmstat.numa_hit
>    1821249 ± 16%     -65.0%     637560 ± 71%  proc-vmstat.numa_local
>    1925858 ± 15%     -61.7%     737459 ± 62%  proc-
> vmstat.pgalloc_normal
>    1796629 ± 16%     -66.1%     609149 ± 75%  proc-vmstat.pgfree
>       9427 ±  3%     -11.6%       8337 ±  2%  slabinfo.kmalloc-
> 512.active_objs
>       1182 ±  3%     -11.5%       1045 ±  2%  slabinfo.kmalloc-
> 512.active_slabs
>       9459 ±  3%     -11.5%       8370 ±  2%  slabinfo.kmalloc-
> 512.num_objs
>       1182 ±  3%     -11.5%       1045 ±  2%  slabinfo.kmalloc-
> 512.num_slabs
>      82005 ±  7%     -24.2%      62197 ±  5%  slabinfo.kmalloc-
> 64.active_objs
>       1282 ±  7%     -24.1%     973.67 ±  5%  slabinfo.kmalloc-
> 64.active_slabs
>      82119 ±  7%     -24.1%      62339 ±  5%  slabinfo.kmalloc-
> 64.num_objs
>       1282 ±  7%     -24.1%     973.67 ±  5%  slabinfo.kmalloc-
> 64.num_slabs
>       8300 ± 11%     +41.5%      11747 ± 10%  softirqs.CPU21.SCHED
>       6707 ± 23%     +39.9%       9384 ± 15%  softirqs.CPU41.SCHED
>       8143 ± 17%     +50.5%      12255 ± 27%  softirqs.CPU56.SCHED
>       8052 ± 14%     +82.7%      14708 ± 29%  softirqs.CPU58.SCHED
>       8701 ± 19%     +70.6%      14847 ± 23%  softirqs.CPU6.SCHED
>       6902 ± 18%     +50.7%      10401 ± 18%  softirqs.CPU72.SCHED
>       8097 ± 14%     +35.4%      10962 ± 17%  softirqs.CPU76.SCHED
>       7938 ± 18%     +24.3%       9864 ±  7%  softirqs.CPU79.SCHED
>     839280 ±  4%     +14.7%     963029 ±  2%  softirqs.SCHED
>     248119 ± 63%   +1378.0%    3667155 ±
> 28%  interrupts.CAL:Function_call_interrupts
>       4.83 ±169%   +5389.7%     265.33
> ±166%  interrupts.CPU12.RES:Rescheduling_interrupts
>     709.00 ± 31%   +2004.3%      14919
> ±120%  interrupts.CPU28.CAL:Function_call_interrupts
>     873.33 ± 64%   +7449.7%      65933
> ±107%  interrupts.CPU4.CAL:Function_call_interrupts
>     506.33 ±  3%   +9102.5%      46595
> ±158%  interrupts.CPU43.CAL:Function_call_interrupts
>      27.33 ± 75%    +750.6%     232.50 ±
> 99%  interrupts.CPU48.RES:Rescheduling_interrupts
>     558.67 ± 19%  +10960.8%      61792
> ±145%  interrupts.CPU50.CAL:Function_call_interrupts
>     706.00 ± 66%   +3143.2%      22897
> ±147%  interrupts.CPU53.CAL:Function_call_interrupts
>     732.00 ± 44%   +6764.9%      50251
> ±131%  interrupts.CPU56.CAL:Function_call_interrupts
>       1613 ± 84%   +8272.0%     135082
> ±130%  interrupts.CPU58.CAL:Function_call_interrupts
>     839.00 ± 42%  +23427.3%     197394 ±
> 68%  interrupts.CPU6.CAL:Function_call_interrupts
>      11.17 ± 79%   +4409.0%     503.50 ±
> 76%  interrupts.CPU6.RES:Rescheduling_interrupts
>     717.00 ± 67%   +1775.8%      13449
> ±109%  interrupts.CPU81.CAL:Function_call_interrupts
>       6.67 ±171%   +1212.5%      87.50 ±
> 96%  interrupts.CPU81.RES:Rescheduling_interrupts
>       1189 ± 20%    +988.6%      12948 ±
> 11%  interrupts.RES:Rescheduling_interrupts
>      12.68 ±  6%     +20.0%      15.22 ±  2%  perf-stat.i.MPKI
>   3.86e+09 ±  3%      -9.9%  3.478e+09 ±  2%  perf-stat.i.branch-
> instructions
>       0.67 ±  3%      +0.2        0.84        perf-stat.i.branch-
> miss-rate%
>   24129751           +14.6%   27646121 ±  4%  perf-stat.i.branch-
> misses
>      50806 ±154%   +1684.2%     906487 ± 16%  perf-stat.i.context-
> switches
>       2.58 ±  3%     +12.6%       2.91 ±  2%  perf-stat.i.cpi
>  4.686e+09 ±  2%      -8.6%  4.282e+09 ±  2%  perf-stat.i.dTLB-loads
>  2.615e+09 ±  2%      -6.3%  2.452e+09 ±  3%  perf-stat.i.dTLB-stores
>      83.94            +3.6       87.55        perf-stat.i.iTLB-load-
> miss-rate%
>   11626382 ±  5%     +41.1%   16403258 ±  6%  perf-stat.i.iTLB-load-
> misses
>  1.915e+10 ±  3%     -10.8%  1.707e+10 ±  2%  perf-
> stat.i.instructions
>       1660 ±  7%     -34.9%       1080 ±  6%  perf-
> stat.i.instructions-per-iTLB-miss
>       0.39 ±  3%     -10.7%       0.35 ±  2%  perf-stat.i.ipc
>       0.81 ±  6%     -42.1%       0.47 ± 28%  perf-
> stat.i.metric.K/sec
>     119.24 ±  2%      -8.2%     109.49 ±  2%  perf-
> stat.i.metric.M/sec
>   13094331 ± 11%     -17.0%   10864787 ±  9%  perf-stat.i.node-store-
> misses
>      12.83 ±  5%     +20.0%      15.40 ±  3%  perf-stat.overall.MPKI
>       0.63 ±  3%      +0.2        0.79 ±  2%  perf-
> stat.overall.branch-miss-rate%
>       2.60 ±  3%     +12.9%       2.94 ±  2%  perf-stat.overall.cpi
>      84.88            +3.9       88.76        perf-stat.overall.iTLB-
> load-miss-rate%
>       1653 ±  7%     -36.8%       1044 ±  6%  perf-
> stat.overall.instructions-per-iTLB-miss
>       0.38 ±  3%     -11.5%       0.34 ±  2%  perf-stat.overall.ipc
>  3.799e+09 ±  3%      -9.9%  3.422e+09 ±  2%  perf-stat.ps.branch-
> instructions
>   23742874           +14.6%   27204564 ±  4%  perf-stat.ps.branch-
> misses
>      49922 ±154%   +1687.0%     892147 ± 16%  perf-stat.ps.context-
> switches
>  4.613e+09 ±  2%      -8.6%  4.214e+09 ±  2%  perf-stat.ps.dTLB-loads
>  2.574e+09 ±  2%      -6.3%  2.413e+09 ±  3%  perf-stat.ps.dTLB-
> stores
>   11442374 ±  5%     +41.1%   16142526 ±  6%  perf-stat.ps.iTLB-load-
> misses
>  1.884e+10 ±  3%     -10.9%   1.68e+10 ±  2%  perf-
> stat.ps.instructions
>   12879684 ± 11%     -17.0%   10690222 ±  9%  perf-stat.ps.node-
> store-misses
>  1.185e+12 ±  3%     -10.3%  1.063e+12 ±  3%  perf-
> stat.total.instructions
>      34.69 ± 20%      -8.3       26.43 ±  3%  perf-
> profile.calltrace.cycles-
> pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_e
> ntry
>       6.46 ± 11%      -1.7        4.79 ±  4%  perf-
> profile.calltrace.cycles-
> pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgrcv.do_sysca
> ll_64.entry_SYSCALL_64_after_hwframe
>       5.42 ± 11%      -1.3        4.14 ± 10%  perf-
> profile.calltrace.cycles-
> pp.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       4.13 ± 11%      -1.1        3.04 ± 12%  perf-
> profile.calltrace.cycles-
> pp.__kmalloc.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_
> hwframe
>       2.33 ±  6%      -0.7        1.60 ± 18%  perf-
> profile.calltrace.cycles-
> pp.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_a
> fter_hwframe
>       1.94 ± 14%      -0.5        1.48 ± 16%  perf-
> profile.calltrace.cycles-
> pp.store_msg.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_aft
> er_hwframe
>       1.68 ± 13%      -0.4        1.26 ±  5%  perf-
> profile.calltrace.cycles-
> pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.68 ± 13%      -0.4        1.26 ±  5%  perf-
> profile.calltrace.cycles-
> pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.67 ± 13%      -0.4        1.26 ±  6%  perf-
> profile.calltrace.cycles-
> pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
>       1.67 ± 13%      -0.4        1.26 ±  6%  perf-
> profile.calltrace.cycles-
> pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_h
> wframe
>       1.42 ± 14%      -0.4        1.05 ±  6%  perf-
> profile.calltrace.cycles-
> pp.sysvipc_find_ipc.seq_read_iter.seq_read.vfs_read.ksys_read
>       1.36 ± 16%      -0.3        1.01 ± 24%  perf-
> profile.calltrace.cycles-
> pp.__check_object_size.store_msg.do_msg_fill.do_msgrcv.do_syscall_64
>       1.04 ± 16%      -0.3        0.78 ±  6%  perf-
> profile.calltrace.cycles-
> pp.__radix_tree_lookup.sysvipc_find_ipc.seq_read_iter.seq_read.vfs_re
> ad
>       0.68 ±  9%      -0.2        0.45 ± 44%  perf-
> profile.calltrace.cycles-
> pp.refill_obj_stock.kfree.free_msg.do_msgrcv.do_syscall_64
>       0.44 ± 73%      +0.5        0.90 ±  6%  perf-
> profile.calltrace.cycles-
> pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_st
> artup_64_no_verify
>       0.00            +0.8        0.81 ± 18%  perf-
> profile.calltrace.cycles-
> pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
>       0.00            +0.8        0.84 ± 19%  perf-
> profile.calltrace.cycles-
> pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_
> startup_64_no_verify
>       0.09 ±223%      +1.2        1.30 ± 22%  perf-
> profile.calltrace.cycles-
> pp.__schedule.schedule.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after
> _hwframe
>       0.09 ±223%      +1.3        1.35 ± 22%  perf-
> profile.calltrace.cycles-
> pp.schedule.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +1.4        1.40 ± 15%  perf-
> profile.calltrace.cycles-
> pp.try_to_wake_up.wake_up_q.do_msgsnd.do_syscall_64.entry_SYSCALL_64_
> after_hwframe
>       0.00            +1.5        1.46 ± 14%  perf-
> profile.calltrace.cycles-
> pp.wake_up_q.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.10 ±223%      +2.0        2.10 ± 22%  perf-
> profile.calltrace.cycles-
> pp.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_en
> try
>      27.77 ± 10%      +5.2       33.00 ±  4%  perf-
> profile.calltrace.cycles-
> pp.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      34.70 ± 20%      -8.1       26.57 ±  3%  perf-
> profile.children.cycles-pp.intel_idle
>      13.36 ±  9%      -4.3        9.10 ± 15%  perf-
> profile.children.cycles-pp.native_queued_spin_lock_slowpath
>       5.43 ± 11%      -1.3        4.16 ± 10%  perf-
> profile.children.cycles-pp.load_msg
>       4.18 ± 11%      -1.1        3.09 ± 12%  perf-
> profile.children.cycles-pp.__kmalloc
>       1.95 ± 14%      -0.5        1.49 ± 16%  perf-
> profile.children.cycles-pp.store_msg
>       1.99 ± 14%      -0.4        1.56 ± 16%  perf-
> profile.children.cycles-pp.__check_object_size
>       1.68 ± 13%      -0.4        1.26 ±  6%  perf-
> profile.children.cycles-pp.seq_read
>       1.68 ± 13%      -0.4        1.26 ±  5%  perf-
> profile.children.cycles-pp.seq_read_iter
>       1.68 ± 13%      -0.4        1.27 ±  6%  perf-
> profile.children.cycles-pp.ksys_read
>       1.68 ± 13%      -0.4        1.27 ±  6%  perf-
> profile.children.cycles-pp.vfs_read
>       0.70 ±  9%      -0.4        0.31 ± 13%  perf-
> profile.children.cycles-pp.get_obj_cgroup_from_current
>       1.42 ± 14%      -0.4        1.05 ±  6%  perf-
> profile.children.cycles-pp.sysvipc_find_ipc
>       1.49 ± 14%      -0.3        1.16 ±  5%  perf-
> profile.children.cycles-pp.__radix_tree_lookup
>       0.52 ± 17%      -0.2        0.28 ±  9%  perf-
> profile.children.cycles-pp.ipcperms
>       0.35 ± 25%      -0.2        0.11 ± 55%  perf-
> profile.children.cycles-pp.__slab_alloc
>       0.34 ± 25%      -0.2        0.10 ± 59%  perf-
> profile.children.cycles-pp.___slab_alloc
>       0.61 ± 21%      -0.2        0.39 ± 27%  perf-
> profile.children.cycles-pp.__list_del_entry_valid
>       0.64 ± 14%      -0.2        0.47 ± 19%  perf-
> profile.children.cycles-pp.idr_find
>       0.70 ±  9%      -0.2        0.54 ±  5%  perf-
> profile.children.cycles-pp.refill_obj_stock
>       0.69 ± 10%      -0.1        0.56 ±  2%  perf-
> profile.children.cycles-pp.syscall_return_via_sysret
>       0.47 ±  9%      -0.1        0.35 ±  7%  perf-
> profile.children.cycles-pp.__entry_text_start
>       0.60 ±  9%      -0.1        0.49 ±  3%  perf-
> profile.children.cycles-pp.__check_heap_object
>       0.37 ±  7%      -0.1        0.28 ±  9%  perf-
> profile.children.cycles-pp.drain_obj_stock
>       0.48 ± 12%      -0.1        0.39 ±  7%  perf-
> profile.children.cycles-pp._copy_from_user
>       0.48 ± 10%      -0.1        0.40 ±  6%  perf-
> profile.children.cycles-pp.ksys_msgsnd
>       0.44 ±  9%      -0.1        0.36 ±  3%  perf-
> profile.children.cycles-pp.copy_user_generic_unrolled
>       0.29 ±  6%      -0.1        0.22 ±  9%  perf-
> profile.children.cycles-pp.page_counter_cancel
>       0.29 ±  6%      -0.1        0.22 ±  9%  perf-
> profile.children.cycles-pp.page_counter_uncharge
>       0.23 ± 10%      -0.1        0.18 ±  2%  perf-
> profile.children.cycles-pp.__put_user_nocheck_8
>       0.28 ±  9%      -0.1        0.22 ±  4%  perf-
> profile.children.cycles-pp.__mod_memcg_lruvec_state
>       0.23 ±  7%      -0.1        0.18 ± 10%  perf-
> profile.children.cycles-pp.__memcg_kmem_uncharge
>       0.18 ±  9%      -0.0        0.14 ±  4%  perf-
> profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
>       0.24 ±  9%      -0.0        0.20 ±  8%  perf-
> profile.children.cycles-pp.__get_user_8
>       0.23 ± 11%      -0.0        0.18 ±  5%  perf-
> profile.children.cycles-pp.seq_printf
>       0.20 ± 10%      -0.0        0.16 ±  4%  perf-
> profile.children.cycles-pp.__might_sleep
>       0.22 ± 10%      -0.0        0.18 ±  5%  perf-
> profile.children.cycles-pp.vsnprintf
>       0.22 ± 10%      -0.0        0.18 ±  5%  perf-
> profile.children.cycles-pp.seq_vprintf
>       0.23 ± 10%      -0.0        0.19 ±  4%  perf-
> profile.children.cycles-pp.sysvipc_msg_proc_show
>       0.11 ±  6%      -0.0        0.08 ±  8%  perf-
> profile.children.cycles-pp.rcu_read_unlock_strict
>       0.08 ±  8%      -0.0        0.06 ± 16%  perf-
> profile.children.cycles-pp.msgctl_stat
>       0.09 ± 10%      +0.0        0.12 ±  9%  perf-
> profile.children.cycles-pp.exit_to_user_mode_prepare
>       0.07 ± 18%      +0.0        0.11 ±  9%  perf-
> profile.children.cycles-pp.native_irq_return_iret
>       0.02 ±141%      +0.1        0.07 ± 18%  perf-
> profile.children.cycles-pp._raw_spin_trylock
>       0.00            +0.1        0.06 ± 13%  perf-
> profile.children.cycles-pp.switch_mm_irqs_off
>       0.15 ± 12%      +0.1        0.22 ±  5%  perf-
> profile.children.cycles-pp.msgctl_info
>       0.00            +0.1        0.07 ± 19%  perf-
> profile.children.cycles-pp.ttwu_do_wakeup
>       0.00            +0.1        0.07 ± 23%  perf-
> profile.children.cycles-pp.hrtimer_next_event_without
>       0.00            +0.1        0.07 ± 28%  perf-
> profile.children.cycles-pp.tick_nohz_idle_enter
>       0.03 ±102%      +0.1        0.10 ± 14%  perf-
> profile.children.cycles-pp.read_tsc
>       0.01 ±223%      +0.1        0.09 ± 16%  perf-
> profile.children.cycles-pp.update_cfs_group
>       0.00            +0.1        0.08 ± 14%  perf-
> profile.children.cycles-pp.__update_load_avg_cfs_rq
>       0.00            +0.1        0.08 ± 13%  perf-
> profile.children.cycles-pp.__update_load_avg_se
>       0.00            +0.1        0.09 ± 14%  perf-
> profile.children.cycles-pp.reweight_entity
>       0.01 ±223%      +0.1        0.10 ± 17%  perf-
> profile.children.cycles-pp._raw_spin_unlock_irqrestore
>       0.00            +0.1        0.09 ± 17%  perf-
> profile.children.cycles-pp.get_next_timer_interrupt
>       0.00            +0.1        0.10 ± 18%  perf-
> profile.children.cycles-pp.send_call_function_single_ipi
>       0.01 ±223%      +0.1        0.13 ± 25%  perf-
> profile.children.cycles-pp.available_idle_cpu
>       0.01 ±223%      +0.1        0.15 ± 17%  perf-
> profile.children.cycles-pp.native_sched_clock
>       0.00            +0.1        0.14 ± 20%  perf-
> profile.children.cycles-pp.__switch_to_asm
>       0.02 ±144%      +0.1        0.16 ± 16%  perf-
> profile.children.cycles-pp.sched_clock
>       0.00            +0.1        0.15 ± 46%  perf-
> profile.children.cycles-pp.__sysvec_call_function_single
>       0.03 ±106%      +0.1        0.18 ± 16%  perf-
> profile.children.cycles-pp.sched_clock_cpu
>       0.02 ±223%      +0.2        0.17 ± 32%  perf-
> profile.children.cycles-pp.update_ts_time_stats
>       0.00            +0.2        0.16 ± 34%  perf-
> profile.children.cycles-pp.llist_add_batch
>       0.00            +0.2        0.16 ± 34%  perf-
> profile.children.cycles-pp.__smp_call_single_queue
>       0.01 ±223%      +0.2        0.17 ± 23%  perf-
> profile.children.cycles-pp.select_task_rq_fair
>       0.17 ± 46%      +0.2        0.34 ± 13%  perf-
> profile.children.cycles-pp.tick_nohz_get_sleep_length
>       0.00            +0.2        0.17 ± 45%  perf-
> profile.children.cycles-pp.sysvec_call_function_single
>       0.02 ±223%      +0.2        0.19 ± 32%  perf-
> profile.children.cycles-pp.nr_iowait_cpu
>       0.01 ±223%      +0.2        0.18 ± 24%  perf-
> profile.children.cycles-pp.perf_trace_sched_wakeup_template
>       0.02 ±223%      +0.2        0.20 ± 40%  perf-
> profile.children.cycles-pp.flush_smp_call_function_queue
>       0.00            +0.2        0.19 ± 42%  perf-
> profile.children.cycles-pp.finish_task_switch
>       0.02 ±223%      +0.2        0.22 ± 17%  perf-
> profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.02 ±223%      +0.2        0.21 ± 29%  perf-
> profile.children.cycles-pp.tick_nohz_idle_exit
>       0.01 ±223%      +0.2        0.22 ± 43%  perf-
> profile.children.cycles-pp.asm_sysvec_call_function_single
>       0.01 ±223%      +0.2        0.24 ± 21%  perf-
> profile.children.cycles-pp.__switch_to
>       0.00            +0.2        0.23 ± 13%  perf-
> profile.children.cycles-pp.set_next_entity
>       0.01 ±223%      +0.3        0.27 ± 15%  perf-
> profile.children.cycles-pp.update_rq_clock
>       0.01 ±223%      +0.3        0.29 ± 12%  perf-
> profile.children.cycles-pp.update_load_avg
>       0.03 ±223%      +0.3        0.33 ± 28%  perf-
> profile.children.cycles-pp.update_curr
>       0.01 ±223%      +0.3        0.34 ± 14%  perf-
> profile.children.cycles-pp.pick_next_task_fair
>       0.02 ±223%      +0.3        0.36 ± 23%  perf-
> profile.children.cycles-pp.ttwu_queue_wakelist
>       0.55 ± 32%      +0.4        0.91 ±  6%  perf-
> profile.children.cycles-pp.menu_select
>       0.02 ±223%      +0.4        0.39 ± 16%  perf-
> profile.children.cycles-pp.enqueue_entity
>       0.06 ±223%      +0.4        0.48 ± 36%  perf-
> profile.children.cycles-pp.sched_ttwu_pending
>       0.02 ±223%      +0.5        0.49 ± 18%  perf-
> profile.children.cycles-pp.enqueue_task_fair
>       0.02 ±223%      +0.5        0.50 ± 18%  perf-
> profile.children.cycles-pp.ttwu_do_activate
>       0.04 ±223%      +0.5        0.54 ± 23%  perf-
> profile.children.cycles-pp.dequeue_entity
>       0.07 ±223%      +0.5        0.58 ± 38%  perf-
> profile.children.cycles-pp.flush_smp_call_function_from_idle
>       0.04 ±223%      +0.5        0.58 ± 24%  perf-
> profile.children.cycles-pp.dequeue_task_fair
>       0.02 ±223%      +0.6        0.65 ± 16%  perf-
> profile.children.cycles-pp.wake_q_add
>       0.03 ±223%      +0.8        0.84 ± 19%  perf-
> profile.children.cycles-pp.schedule_idle
>       0.10 ±223%      +1.3        1.36 ± 22%  perf-
> profile.children.cycles-pp.schedule
>       0.05 ±223%      +1.4        1.40 ± 15%  perf-
> profile.children.cycles-pp.try_to_wake_up
>       0.12 ± 90%      +1.4        1.49 ± 14%  perf-
> profile.children.cycles-pp.wake_up_q
>       0.14 ±166%      +2.0        2.11 ± 22%  perf-
> profile.children.cycles-pp.poll_idle
>       0.13 ±200%      +2.0        2.12 ± 20%  perf-
> profile.children.cycles-pp.__schedule
>      27.85 ± 10%      +5.3       33.15 ±  4%  perf-
> profile.children.cycles-pp.do_msgsnd
>      34.70 ± 20%      -8.1       26.57 ±  3%  perf-
> profile.self.cycles-pp.intel_idle
>      13.28 ±  9%      -4.2        9.03 ± 15%  perf-
> profile.self.cycles-pp.native_queued_spin_lock_slowpath
>       0.66 ± 10%      -0.4        0.29 ± 14%  perf-
> profile.self.cycles-pp.get_obj_cgroup_from_current
>       1.41 ± 15%      -0.3        1.09 ±  5%  perf-
> profile.self.cycles-pp.__radix_tree_lookup
>       0.51 ± 17%      -0.2        0.27 ±  9%  perf-
> profile.self.cycles-pp.ipcperms
>       0.60 ± 22%      -0.2        0.38 ± 28%  perf-
> profile.self.cycles-pp.__list_del_entry_valid
>       0.24 ± 36%      -0.2        0.05 ± 46%  perf-
> profile.self.cycles-pp.___slab_alloc
>       0.63 ± 14%      -0.2        0.46 ± 18%  perf-
> profile.self.cycles-pp.idr_find
>       0.69 ± 10%      -0.1        0.56 ±  2%  perf-
> profile.self.cycles-pp.syscall_return_via_sysret
>       0.59 ±  9%      -0.1        0.47 ±  3%  perf-
> profile.self.cycles-pp.__check_heap_object
>       0.46 ± 10%      -0.1        0.35 ±  7%  perf-
> profile.self.cycles-pp.__entry_text_start
>       0.43 ±  9%      -0.1        0.35 ±  5%  perf-
> profile.self.cycles-pp.copy_user_generic_unrolled
>       0.33 ± 13%      -0.1        0.26        perf-
> profile.self.cycles-pp.refill_obj_stock
>       0.18 ± 13%      -0.1        0.11 ±  8%  perf-
> profile.self.cycles-pp.sysvipc_find_ipc
>       0.27 ±  7%      -0.1        0.20 ± 10%  perf-
> profile.self.cycles-pp.page_counter_cancel
>       0.23 ± 10%      -0.1        0.17 ±  4%  perf-
> profile.self.cycles-pp.__put_user_nocheck_8
>       0.27 ± 10%      -0.0        0.22 ±  4%  perf-
> profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>       0.17 ±  6%      -0.0        0.12 ±  3%  perf-
> profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
>       0.24 ± 10%      -0.0        0.19 ±  8%  perf-
> profile.self.cycles-pp.__get_user_8
>       0.26 ± 10%      -0.0        0.22 ±  7%  perf-
> profile.self.cycles-pp.obj_cgroup_charge
>       0.19 ± 11%      -0.0        0.15 ±  3%  perf-
> profile.self.cycles-pp.__might_sleep
>       0.08 ± 13%      -0.0        0.05 ± 45%  perf-
> profile.self.cycles-pp.drain_obj_stock
>       0.13 ± 11%      -0.0        0.10 ±  8%  perf-
> profile.self.cycles-pp.__mod_memcg_lruvec_state
>       0.11 ± 12%      -0.0        0.08 ±  5%  perf-
> profile.self.cycles-pp.store_msg
>       0.10 ± 14%      -0.0        0.08        perf-
> profile.self.cycles-pp.__might_fault
>       0.10 ±  7%      -0.0        0.08 ±  8%  perf-
> profile.self.cycles-pp.page_counter_try_charge
>       0.05 ±  9%      +0.0        0.09 ± 14%  perf-
> profile.self.cycles-pp.wake_up_q
>       0.09 ± 10%      +0.0        0.12 ± 10%  perf-
> profile.self.cycles-pp.do_msg_fill
>       0.07 ± 18%      +0.0        0.11 ±  9%  perf-
> profile.self.cycles-pp.native_irq_return_iret
>       0.02 ±141%      +0.1        0.07 ± 18%  perf-
> profile.self.cycles-pp._raw_spin_trylock
>       0.00            +0.1        0.06 ± 15%  perf-
> profile.self.cycles-pp.switch_mm_irqs_off
>       0.00            +0.1        0.07 ± 19%  perf-
> profile.self.cycles-pp.dequeue_entity
>       0.00            +0.1        0.07 ± 22%  perf-
> profile.self.cycles-pp.update_curr
>       0.03 ±102%      +0.1        0.10 ± 12%  perf-
> profile.self.cycles-pp.read_tsc
>       0.00            +0.1        0.08 ± 14%  perf-
> profile.self.cycles-pp.__update_load_avg_cfs_rq
>       0.10 ± 12%      +0.1        0.18 ±  5%  perf-
> profile.self.cycles-pp.msgctl_info
>       0.00            +0.1        0.08 ± 22%  perf-
> profile.self.cycles-pp.update_cfs_group
>       0.00            +0.1        0.08 ± 29%  perf-
> profile.self.cycles-pp.finish_task_switch
>       0.00            +0.1        0.08 ± 10%  perf-
> profile.self.cycles-pp.__update_load_avg_se
>       0.01 ±223%      +0.1        0.09 ± 52%  perf-
> profile.self.cycles-pp.ttwu_queue_wakelist
>       0.00            +0.1        0.09 ± 13%  perf-
> profile.self.cycles-pp.reweight_entity
>       0.00            +0.1        0.09 ± 16%  perf-
> profile.self.cycles-pp._raw_spin_unlock_irqrestore
>       0.00            +0.1        0.10 ± 22%  perf-
> profile.self.cycles-pp.enqueue_task_fair
>       0.00            +0.1        0.10 ± 18%  perf-
> profile.self.cycles-pp.send_call_function_single_ipi
>       0.00            +0.1        0.11 ± 16%  perf-
> profile.self.cycles-pp.try_to_wake_up
>       0.01 ±223%      +0.1        0.12 ± 31%  perf-
> profile.self.cycles-pp.perf_trace_sched_wakeup_template
>       0.00            +0.1        0.12 ± 13%  perf-
> profile.self.cycles-pp.set_next_entity
>       0.00            +0.1        0.12 ± 12%  perf-
> profile.self.cycles-pp.update_load_avg
>       0.01 ±223%      +0.1        0.13 ± 25%  perf-
> profile.self.cycles-pp.available_idle_cpu
>       0.01 ±223%      +0.1        0.15 ± 18%  perf-
> profile.self.cycles-pp.native_sched_clock
>       0.00            +0.1        0.14 ± 20%  perf-
> profile.self.cycles-pp.__switch_to_asm
>       0.37 ± 30%      +0.1        0.52 ±  2%  perf-
> profile.self.cycles-pp.menu_select
>       0.01 ±223%      +0.2        0.16 ± 27%  perf-
> profile.self.cycles-pp.enqueue_entity
>       0.00            +0.2        0.16 ± 34%  perf-
> profile.self.cycles-pp.llist_add_batch
>       0.02 ±223%      +0.2        0.19 ± 32%  perf-
> profile.self.cycles-pp.nr_iowait_cpu
>       0.01 ±223%      +0.2        0.19 ± 17%  perf-
> profile.self.cycles-pp.do_idle
>       0.00            +0.2        0.19 ± 18%  perf-
> profile.self.cycles-pp.update_rq_clock
>       0.02 ±223%      +0.2        0.22 ± 17%  perf-
> profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.01 ±223%      +0.2        0.23 ± 21%  perf-
> profile.self.cycles-pp.__switch_to
>       0.01 ±223%      +0.4        0.41 ± 19%  perf-
> profile.self.cycles-pp.__schedule
>       0.02 ±223%      +0.6        0.65 ± 17%  perf-
> profile.self.cycles-pp.wake_q_add
>       0.13 ±166%      +1.9        2.01 ± 22%  perf-
> profile.self.cycles-pp.poll_idle
>       9.95 ± 12%      +4.4       14.31 ±  4%  perf-
> profile.self.cycles-pp.do_msgsnd
>       4.52 ± 22%      +6.1       10.58 ±  9%  perf-
> profile.self.cycles-pp._raw_spin_lock
> 
> 
>                                                                      
>            
>                                stress-
> ng.msg.ops_per_sec                        
>                                                                      
>            
>   5.4e+06 +--------------------------------------------------------
> ---------+   
>   5.2e+06 |-
> +                +              +     +..+  :   .+.+   +..      |   
>           |                 : :            +
> :   +      :  +   :   :  +     |   
>     5e+06 |:+       .+.+    : :           +  :  +        :+     :
> :         |   
>   4.8e+06 |:+.+    +    :  +   :   .+.+. +    :+         +      :
> :         |   
>           | +  + ..     :
> :    +.+.     +     +                  :          |   
>   4.6e+06 |-
> +   +        ::                                      +          |   
>   4.4e+06 |-
> +            +                                                  |   
>   4.2e+06 |-
> +                                                               |   
>           |                                                          
>        |   
>     4e+06 |-
> +                    O  O             O                         |   
>   3.8e+06 |-+        O     O
> O        O     O   O          O            O   |   
>           |                    O        O O   O      O O O   O   O
> O  O   O |   
>   3.6e+06 |-+ O O  O   O
> O                                     O            |   
>   3.4e+06 +--------------------------------------------------------
> ---------+   
>                                                                      
>            
>                                                                      
>            
> [*] bisect-good sample
> [O] bisect-bad  sample
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are
> provided
> for informational purposes only. Any difference in system hardware or
> software
> design or configuration may affect actual performance.
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source
> Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel
> Corporation
> 
> Thanks,
> Oliver Sang
> 

