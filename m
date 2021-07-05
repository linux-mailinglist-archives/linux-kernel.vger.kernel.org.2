Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A1E3BBAA5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhGEKBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 06:01:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:21280 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230050AbhGEKBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 06:01:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10035"; a="230674413"
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="yaml'?scan'208";a="230674413"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 02:58:42 -0700
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="yaml'?scan'208";a="496070675"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 02:58:35 -0700
Date:   Mon, 5 Jul 2021 17:58:33 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com
Subject: [mm/memcg] 68ac5b3c8d: hackbench.throughput 42.4% improvement
Message-ID: <20210705095833.GD2022171@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a 42.4% improvement of hackbench.throughput due to commit:


commit: 68ac5b3c8db2fda00af594eca4100aceaf927c0e ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: hackbench
on test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
with following parameters:

	nr_threads: 100%
	iterations: 4
	mode: threads
	ipc: socket
	cpufreq_governor: performance
	ucode: 0x5003006

test-description: Hackbench is both a benchmark and a stress test for the Linux kernel scheduler.
test-url: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/sched/cfs-scheduler/hackbench.c

In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------+
| testcase: change | hackbench: hackbench.throughput 32.7% improvement                    |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                         |
|                  | ipc=socket                                                           |
|                  | iterations=8                                                         |
|                  | mode=process                                                         |
|                  | nr_threads=1600%                                                     |
|                  | ucode=0x4003006                                                      |
+------------------+----------------------------------------------------------------------+
| testcase: change | hackbench: hackbench.throughput 40.7% improvement                    |
| test machine     | 104 threads 2 sockets Skylake with 192G memory                       |
| test parameters  | cpufreq_governor=performance                                         |
|                  | ipc=socket                                                           |
|                  | iterations=4                                                         |
|                  | mode=threads                                                         |
|                  | nr_threads=100%                                                      |
|                  | ucode=0x2006a0a                                                      |
+------------------+----------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in this email
        bin/lkp split-job --compatible job.yaml  # generate the yaml file for lkp run
        bin/lkp run                    generated-yaml-file

=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase/ucode:
  gcc-9/performance/socket/4/x86_64-rhel-8.3/threads/100%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2ap4/hackbench/0x5003006

commit: 
  fdbcb2a6d6 ("mm/memcg: move mod_objcg_state() to memcontrol.c")
  68ac5b3c8d ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")

fdbcb2a6d6778e0b 68ac5b3c8db2fda00af594eca41 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     64004 ±  5%     +42.4%      91157 ±  2%  hackbench.throughput
      1533 ±  2%     -33.0%       1027 ±  3%  hackbench.time.elapsed_time
      1533 ±  2%     -33.0%       1027 ±  3%  hackbench.time.elapsed_time.max
 4.679e+09 ±  4%     +13.9%  5.327e+09 ±  3%  hackbench.time.involuntary_context_switches
    282365 ±  2%     -33.7%     187168 ±  3%  hackbench.time.system_time
      4044 ±  2%     +11.1%       4492        hackbench.time.user_time
 7.581e+09            +2.9%  7.802e+09        hackbench.time.voluntary_context_switches
    284299 ± 26%     -75.0%      71180 ± 22%  numa-meminfo.node3.AnonPages.max
      1580 ±  2%     -32.0%       1074 ±  3%  uptime.boot
   8025999 ±  3%     +59.8%   12822101 ±  5%  vmstat.system.cs
      2.69 ±  4%      +1.5        4.23 ±  7%  mpstat.cpu.all.idle%
      1.37 ±  3%      +0.9        2.24 ±  3%  mpstat.cpu.all.usr%
   1338201 ± 22%     -48.0%     696011 ± 22%  numa-numastat.node0.local_node
   1368199 ± 20%     -45.4%     746623 ± 18%  numa-numastat.node0.numa_hit
      0.55 ± 13%     +39.3%       0.76 ±  9%  turbostat.CPU%c1
  1.58e+09 ± 11%     -27.7%  1.142e+09 ± 15%  turbostat.IRQ
     46.55 ±223%    +523.7%     290.31        turbostat.PkgWatt
    138673            -3.0%     134515        proc-vmstat.nr_kernel_stack
   4798903 ±  6%     -21.4%    3773357 ±  3%  proc-vmstat.numa_hit
   4538312 ±  6%     -22.6%    3512942 ±  4%  proc-vmstat.numa_local
   9270219 ± 10%     -27.2%    6747732 ±  6%  proc-vmstat.pgalloc_normal
   5263974 ±  6%     -16.0%    4421768 ±  6%  proc-vmstat.pgfault
   8639280 ± 11%     -29.2%    6114666 ±  6%  proc-vmstat.pgfree
    201629 ±  3%     -26.0%     149254 ±  5%  proc-vmstat.pgreuse
     14.09 ±  2%     -15.2%      11.94        perf-stat.i.MPKI
 1.679e+10 ±  3%     +47.6%  2.478e+10 ±  5%  perf-stat.i.branch-instructions
 1.962e+08 ±  2%     +46.4%  2.873e+08 ±  4%  perf-stat.i.branch-misses
     23.61 ±  5%      -6.5       17.08 ± 13%  perf-stat.i.cache-miss-rate%
 1.103e+09 ±  2%     +24.5%  1.374e+09 ±  4%  perf-stat.i.cache-references
   8258347 ±  3%     +61.2%   13309378 ±  5%  perf-stat.i.context-switches
      7.73 ±  2%     -31.5%       5.30 ±  5%  perf-stat.i.cpi
    757865 ±  4%     +54.3%    1169348 ±  3%  perf-stat.i.cpu-migrations
 2.305e+10 ±  3%     +46.4%  3.374e+10 ±  5%  perf-stat.i.dTLB-loads
 1.351e+10 ±  3%     +48.0%  1.999e+10 ±  4%  perf-stat.i.dTLB-stores
 1.029e+08           +29.9%  1.336e+08 ±  3%  perf-stat.i.iTLB-load-misses
   1627438 ±  9%     +22.9%    2000194 ±  9%  perf-stat.i.iTLB-loads
 8.229e+10 ±  3%     +46.5%  1.206e+11 ±  5%  perf-stat.i.instructions
    784.62 ±  2%     +13.1%     887.30 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.14 ±  3%     +46.5%       0.20 ±  5%  perf-stat.i.ipc
    282.63 ±  3%     +46.6%     414.21 ±  5%  perf-stat.i.metric.M/sec
      3392 ±  5%     +24.6%       4227 ±  3%  perf-stat.i.minor-faults
      3395 ±  5%     +24.7%       4232 ±  3%  perf-stat.i.page-faults
     13.40 ±  3%     -15.8%      11.28        perf-stat.overall.MPKI
     23.13 ±  6%      -6.7       16.39 ± 13%  perf-stat.overall.cache-miss-rate%
      7.30 ±  3%     -31.3%       5.02 ±  5%  perf-stat.overall.cpi
    799.61 ±  2%     +12.9%     903.10 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.14 ±  3%     +45.9%       0.20 ±  5%  perf-stat.overall.ipc
 1.647e+10 ±  3%     +46.6%  2.415e+10 ±  6%  perf-stat.ps.branch-instructions
 1.919e+08 ±  2%     +45.4%   2.79e+08 ±  4%  perf-stat.ps.branch-misses
 1.081e+09 ±  2%     +22.5%  1.324e+09 ±  5%  perf-stat.ps.cache-references
   8024383 ±  3%     +59.9%   12828939 ±  5%  perf-stat.ps.context-switches
    706549 ±  4%     +52.4%    1077133 ±  4%  perf-stat.ps.cpu-migrations
  2.26e+10 ±  2%     +45.6%  3.289e+10 ±  5%  perf-stat.ps.dTLB-loads
 1.324e+10 ±  2%     +47.3%   1.95e+10 ±  5%  perf-stat.ps.dTLB-stores
  1.01e+08           +28.8%    1.3e+08 ±  3%  perf-stat.ps.iTLB-load-misses
   1553977 ±  8%     +24.9%    1940929 ±  8%  perf-stat.ps.iTLB-loads
 8.074e+10 ±  3%     +45.5%  1.175e+11 ±  5%  perf-stat.ps.instructions
      3373 ±  5%     +25.2%       4223 ±  4%  perf-stat.ps.minor-faults
   1548676 ± 14%     +41.1%    2185441 ±  8%  perf-stat.ps.node-stores
      3376 ±  5%     +25.2%       4227 ±  4%  perf-stat.ps.page-faults
     70.29 ± 13%     -64.8%      24.74 ± 17%  perf-sched.sch_delay.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
    113.50 ±101%     -96.1%       4.42 ±201%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
     11944 ±134%     -99.8%      18.11 ±219%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
     51600 ± 20%     -48.4%      26647 ± 16%  perf-sched.sch_delay.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     17653 ± 71%     -93.8%       1093 ±203%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
     46.30 ± 13%     -66.5%      15.49 ± 19%  perf-sched.total_sch_delay.average.ms
     51658 ± 20%     -48.1%      26788 ± 16%  perf-sched.total_sch_delay.max.ms
    175.44 ± 16%     -62.1%      66.54 ± 18%  perf-sched.total_wait_and_delay.average.ms
   1854505 ±  4%     +10.3%    2045473 ±  2%  perf-sched.total_wait_and_delay.count.ms
    104015 ± 20%     -48.5%      53554 ± 16%  perf-sched.total_wait_and_delay.max.ms
    129.14 ± 17%     -60.5%      51.04 ± 18%  perf-sched.total_wait_time.average.ms
     54569 ± 18%     -49.1%      27787 ± 16%  perf-sched.total_wait_time.max.ms
      2614 ± 39%     -66.8%     868.44 ± 81%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    106.50 ± 19%     -71.5%      30.39 ± 27%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
    260.22 ± 26%     -65.9%      88.85 ± 35%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
    253.08 ± 15%     -85.5%      36.62 ±101%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
    296.64 ± 26%     -73.9%      77.38 ± 49%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
    344.94 ± 24%     -85.2%      51.19 ±104%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
    206.16 ± 15%     -57.7%      87.25 ± 15%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      3615 ± 15%     -57.0%       1556 ± 15%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
    611366 ± 10%     +25.0%     764401 ±  5%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35418 ±  5%     -30.1%      24750 ± 10%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      1907 ±  5%     -66.1%     647.33 ±103%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      1009 ±  6%     -29.4%     712.67 ± 45%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
    305.67 ± 18%     -22.0%     238.33 ± 10%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
     80491 ± 40%     -46.6%      42961 ± 38%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     50832 ± 26%     -79.3%      10535 ±101%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
     43152 ± 35%     -62.7%      16096 ± 49%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
     35946 ± 21%     -70.9%      10460 ±100%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
    103767 ± 19%     -48.7%      53272 ± 16%  perf-sched.wait_and_delay.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     61843 ± 22%     -56.8%      26686 ± 13%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      2613 ± 39%     -66.6%     871.99 ± 80%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    290.13 ± 37%     -76.1%      69.34 ± 96%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
    104.89 ± 18%     -71.6%      29.74 ± 26%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
    258.62 ± 25%     -66.6%      86.50 ± 33%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
    249.20 ± 16%     -74.7%      63.10 ± 23%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
    296.60 ± 26%     -71.1%      85.74 ± 26%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
    344.89 ± 24%     -82.5%      60.26 ± 76%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
    135.87 ± 18%     -54.0%      62.51 ± 16%  perf-sched.wait_time.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      3502 ± 16%     -55.7%       1551 ± 15%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
     14789 ±105%     -76.7%       3442 ±219%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     50293 ± 22%     -74.6%      12773 ± 76%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     54516 ± 18%     -49.2%      27716 ± 16%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     53531 ± 19%     -49.2%      27167 ± 14%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
     47573 ± 14%     -58.8%      19614 ± 14%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
     43152 ± 35%     -56.8%      18656 ± 19%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
     35946 ± 21%     -64.0%      12942 ± 66%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
     52900 ± 21%     -48.7%      27133 ± 17%  perf-sched.wait_time.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     52252 ± 19%     -48.9%      26686 ± 13%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      7.50 ±  7%      -5.6        1.89 ± 29%  perf-profile.calltrace.cycles-pp.mod_objcg_state.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      5.58 ±  9%      -4.6        1.01 ± 48%  perf-profile.calltrace.cycles-pp.mod_objcg_state.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     42.60 ±  2%      -2.6       40.00 ±  3%  perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read
     42.67 ±  2%      -2.6       40.11 ±  3%  perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read.ksys_read
     25.82 ±  2%      -2.2       23.62 ±  6%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     25.96 ±  2%      -2.1       23.83 ±  6%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     26.25 ±  2%      -2.0       24.24 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     26.28 ±  2%      -2.0       24.28 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read
     26.63 ±  2%      -1.9       24.74 ±  6%  perf-profile.calltrace.cycles-pp.__libc_read
      5.57 ±  6%      +2.4        7.95 ± 21%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     20.20 ±  9%     -16.4        3.84 ± 26%  perf-profile.children.cycles-pp.mod_objcg_state
      9.12 ± 17%      -8.8        0.33 ± 33%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      9.00 ± 17%      -8.7        0.29 ± 37%  perf-profile.children.cycles-pp.__mod_memcg_state
     42.62 ±  2%      -2.6       40.03 ±  3%  perf-profile.children.cycles-pp.unix_stream_read_generic
     42.67 ±  2%      -2.6       40.11 ±  3%  perf-profile.children.cycles-pp.unix_stream_recvmsg
      2.71 ± 14%      -1.4        1.27 ± 60%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
     98.60            -0.7       97.87        perf-profile.children.cycles-pp.do_syscall_64
     98.72            -0.7       98.05        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.27 ± 15%      -0.1        0.14 ± 45%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.27 ± 14%      -0.1        0.16 ± 35%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.14 ± 17%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.aa_file_perm
      0.10 ± 18%      -0.1        0.03 ±103%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.10 ± 18%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.llist_add_batch
      0.09 ± 22%      -0.1        0.03 ±105%  perf-profile.children.cycles-pp.llist_reverse_order
      0.08 ±  6%      +0.0        0.10        perf-profile.children.cycles-pp.__ksize
      0.05 ±  8%      +0.0        0.08 ± 13%  perf-profile.children.cycles-pp.rb_insert_color
      0.06 ± 46%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.resched_curr
      0.16 ±  5%      +0.0        0.20 ±  4%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.13 ±  4%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.__check_heap_object
      0.05 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__pthread_enable_asynccancel
      0.10 ±  6%      +0.0        0.15 ± 11%  perf-profile.children.cycles-pp.clear_buddies
      0.10 ±  4%      +0.0        0.15 ±  9%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.11 ± 16%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      0.08 ±  5%      +0.1        0.14 ± 45%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.26 ±  3%      +0.1        0.31 ±  7%  perf-profile.children.cycles-pp.mutex_lock
      0.02 ±141%      +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.rcu_all_qs
      0.14 ±  4%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.update_min_vruntime
      0.09 ± 16%      +0.1        0.15 ± 16%  perf-profile.children.cycles-pp.__build_skb_around
      0.07 ± 17%      +0.1        0.14 ± 24%  perf-profile.children.cycles-pp.rb_erase
      0.10 ±  4%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.copyin
      0.09 ± 13%      +0.1        0.16 ± 30%  perf-profile.children.cycles-pp.skb_unlink
      0.00            +0.1        0.06 ± 19%  perf-profile.children.cycles-pp.wakeup_preempt_entity
      0.12 ±  3%      +0.1        0.19 ±  7%  perf-profile.children.cycles-pp.sock_recvmsg
      0.60 ±  2%      +0.1        0.66 ±  3%  perf-profile.children.cycles-pp.__check_object_size
      0.01 ±223%      +0.1        0.08 ± 18%  perf-profile.children.cycles-pp.fput
      0.08 ±  8%      +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.unix_write_space
      0.09 ±  9%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.20 ±  5%      +0.1        0.28 ±  9%  perf-profile.children.cycles-pp.___might_sleep
      0.16 ±  5%      +0.1        0.25 ±  5%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.12 ±  6%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.__pthread_disable_asynccancel
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.__list_add_valid
      0.13 ±  3%      +0.1        0.21 ± 10%  perf-profile.children.cycles-pp.__entry_text_start
      0.19 ± 11%      +0.1        0.27 ± 10%  perf-profile.children.cycles-pp.put_prev_entity
      0.18 ±  6%      +0.1        0.26 ±  8%  perf-profile.children.cycles-pp._copy_from_iter
      0.12 ±  8%      +0.1        0.21 ± 10%  perf-profile.children.cycles-pp.fput_many
      0.47 ±  8%      +0.1        0.57 ± 11%  perf-profile.children.cycles-pp.prepare_to_wait
      0.20 ±  8%      +0.1        0.31 ±  6%  perf-profile.children.cycles-pp.__enqueue_entity
      0.40 ±  7%      +0.1        0.51 ±  8%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.20 ±  9%      +0.1        0.32 ± 11%  perf-profile.children.cycles-pp.check_preempt_wakeup
      0.21 ±  8%      +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.pick_next_entity
      0.30 ± 10%      +0.1        0.44 ± 34%  perf-profile.children.cycles-pp.update_cfs_group
      0.26 ±  7%      +0.1        0.40 ±  2%  perf-profile.children.cycles-pp.check_preempt_curr
      0.63 ±  8%      +0.2        0.79 ±  7%  perf-profile.children.cycles-pp.reweight_entity
      0.34 ±  6%      +0.2        0.51 ±  9%  perf-profile.children.cycles-pp.skb_copy_datagram_from_iter
      0.28 ±  7%      +0.2        0.46 ±  4%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.34 ±  7%      +0.2        0.51 ± 14%  perf-profile.children.cycles-pp.__fget_files
      0.51 ±  5%      +0.2        0.68 ±  7%  perf-profile.children.cycles-pp.__fdget_pos
      0.31 ±  8%      +0.2        0.49 ± 12%  perf-profile.children.cycles-pp.__switch_to_asm
      0.48 ±  5%      +0.2        0.67 ±  7%  perf-profile.children.cycles-pp.__fget_light
      0.29 ± 11%      +0.2        0.49 ±  5%  perf-profile.children.cycles-pp.set_next_entity
      0.48 ±  5%      +0.3        0.74 ± 12%  perf-profile.children.cycles-pp.switch_fpu_return
      0.36 ±  8%      +0.3        0.68 ± 33%  perf-profile.children.cycles-pp.page_counter_cancel
      1.40 ±  6%      +0.4        1.75 ±  9%  perf-profile.children.cycles-pp.update_load_avg
      0.48 ±  7%      +0.4        0.83 ± 33%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.58 ±  8%      +0.4        0.98 ± 36%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.89 ±  7%      +0.5        1.42 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.81 ± 20%      +0.9        1.75 ± 20%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.94 ±  7%      +1.0        2.98 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock
      8.30 ±  7%      +3.1       11.36 ± 23%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      9.00 ± 17%      -8.7        0.29 ± 37%  perf-profile.self.cycles-pp.__mod_memcg_state
     10.31 ±  7%      -6.9        3.42 ± 28%  perf-profile.self.cycles-pp.mod_objcg_state
      1.49 ±  8%      -1.4        0.06 ±  8%  perf-profile.self.cycles-pp.refill_obj_stock
      0.38 ± 19%      -0.3        0.04 ±112%  perf-profile.self.cycles-pp.obj_cgroup_charge_pages
      0.35 ± 19%      -0.3        0.05 ± 83%  perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      0.17 ± 15%      -0.1        0.07 ± 84%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.11 ± 18%      -0.1        0.04 ±107%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.14 ± 16%      -0.1        0.07        perf-profile.self.cycles-pp.aa_file_perm
      0.18 ±  5%      -0.1        0.11 ±  3%  perf-profile.self.cycles-pp._copy_to_iter
      0.10 ± 18%      -0.1        0.03 ±101%  perf-profile.self.cycles-pp.llist_add_batch
      0.09 ± 20%      -0.1        0.03 ±105%  perf-profile.self.cycles-pp.llist_reverse_order
      0.19 ±  9%      -0.1        0.13 ± 11%  perf-profile.self.cycles-pp.new_sync_write
      0.07 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__ksize
      0.09            +0.0        0.11 ±  9%  perf-profile.self.cycles-pp.aa_sk_perm
      0.05 ±  8%      +0.0        0.08 ± 13%  perf-profile.self.cycles-pp.unix_stream_recvmsg
      0.05 ±  8%      +0.0        0.08 ± 14%  perf-profile.self.cycles-pp.rb_insert_color
      0.09 ±  7%      +0.0        0.12 ± 19%  perf-profile.self.cycles-pp.mutex_unlock
      0.06 ± 46%      +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.resched_curr
      0.12 ±  3%      +0.0        0.16 ±  5%  perf-profile.self.cycles-pp.__check_heap_object
      0.05 ±  7%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__pthread_enable_asynccancel
      0.09 ±  9%      +0.0        0.13 ± 11%  perf-profile.self.cycles-pp.clear_buddies
      0.12 ±  9%      +0.0        0.17 ±  6%  perf-profile.self.cycles-pp.__alloc_skb
      0.07 ± 11%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.set_next_entity
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.10 ± 10%      +0.1        0.15 ±  5%  perf-profile.self.cycles-pp.pick_next_entity
      0.02 ±141%      +0.1        0.07 ± 14%  perf-profile.self.cycles-pp._copy_from_iter
      0.13 ±  7%      +0.1        0.18 ±  8%  perf-profile.self.cycles-pp.sock_write_iter
      0.14 ±  5%      +0.1        0.20 ±  3%  perf-profile.self.cycles-pp.update_min_vruntime
      0.02 ±142%      +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.sock_alloc_send_pskb
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.unix_destruct_scm
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.ksys_read
      0.20 ±  8%      +0.1        0.26 ±  7%  perf-profile.self.cycles-pp.sock_def_readable
      0.08 ± 16%      +0.1        0.14 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.05            +0.1        0.11 ± 14%  perf-profile.self.cycles-pp.__libc_write
      0.05 ± 71%      +0.1        0.10 ± 23%  perf-profile.self.cycles-pp.__build_skb_around
      0.07 ±  6%      +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.unix_write_space
      0.08 ±  4%      +0.1        0.14 ± 12%  perf-profile.self.cycles-pp.__entry_text_start
      0.24 ±  6%      +0.1        0.30 ±  6%  perf-profile.self.cycles-pp.enqueue_entity
      0.07 ± 18%      +0.1        0.13 ± 26%  perf-profile.self.cycles-pp.rb_erase
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.rcu_all_qs
      0.00            +0.1        0.06 ± 19%  perf-profile.self.cycles-pp.wakeup_preempt_entity
      0.12 ±  4%      +0.1        0.18 ±  7%  perf-profile.self.cycles-pp.new_sync_read
      0.08 ±  8%      +0.1        0.15 ±  9%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.12 ±  6%      +0.1        0.18 ± 13%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.09 ± 15%      +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.consume_skb
      0.07 ± 10%      +0.1        0.15 ± 18%  perf-profile.self.cycles-pp.check_preempt_wakeup
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__list_add_valid
      0.09 ±  4%      +0.1        0.17 ±  7%  perf-profile.self.cycles-pp.sock_read_iter
      0.19 ±  3%      +0.1        0.27 ±  8%  perf-profile.self.cycles-pp.___might_sleep
      0.16 ±  3%      +0.1        0.24 ±  7%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.12 ±  4%      +0.1        0.20 ±  4%  perf-profile.self.cycles-pp.__pthread_disable_asynccancel
      0.15 ±  8%      +0.1        0.24 ± 11%  perf-profile.self.cycles-pp.vfs_read
      0.11 ±  8%      +0.1        0.20 ± 10%  perf-profile.self.cycles-pp.fput_many
      0.16 ±  4%      +0.1        0.26 ±  3%  perf-profile.self.cycles-pp.prepare_to_wait
      0.13 ±  5%      +0.1        0.22 ±  5%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.20 ±  9%      +0.1        0.30 ±  6%  perf-profile.self.cycles-pp.__enqueue_entity
      0.40 ±  8%      +0.1        0.50 ±  8%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.30 ±  9%      +0.1        0.43 ± 33%  perf-profile.self.cycles-pp.update_cfs_group
      0.72 ±  6%      +0.2        0.88 ±  3%  perf-profile.self.cycles-pp.unix_stream_read_generic
      0.20 ± 22%      +0.2        0.36 ± 17%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.32 ±  7%      +0.2        0.49 ± 13%  perf-profile.self.cycles-pp.__fget_files
      0.31 ±  8%      +0.2        0.49 ± 12%  perf-profile.self.cycles-pp.__switch_to_asm
      0.58 ±  7%      +0.2        0.76 ± 10%  perf-profile.self.cycles-pp.update_load_avg
      0.90 ±  5%      +0.2        1.12 ±  7%  perf-profile.self.cycles-pp.__schedule
      0.46 ±  5%      +0.3        0.73 ± 12%  perf-profile.self.cycles-pp.switch_fpu_return
      0.48 ±  4%      +0.3        0.75 ±  2%  perf-profile.self.cycles-pp.update_curr
      0.36 ±  8%      +0.3        0.67 ± 32%  perf-profile.self.cycles-pp.page_counter_cancel
      0.46 ±  8%      +0.3        0.79 ± 34%  perf-profile.self.cycles-pp.page_counter_try_charge
      1.20 ±  9%      +0.8        2.04 ± 43%  perf-profile.self.cycles-pp.drain_obj_stock
      0.81 ± 20%      +0.9        1.75 ± 20%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      4.48 ±  8%      +2.6        7.07 ± 21%  perf-profile.self.cycles-pp.kfree
      8.14 ±  7%      +3.0       11.17 ± 23%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
 1.531e+09 ± 15%     -36.3%  9.749e+08 ± 20%  interrupts.CAL:Function_call_interrupts
   3068881 ±  2%     -33.0%    2057122 ±  3%  interrupts.CPU0.LOC:Local_timer_interrupts
   3068930 ±  2%     -33.0%    2057189 ±  3%  interrupts.CPU1.LOC:Local_timer_interrupts
   1920898 ±  5%     +18.5%    2276692 ± 12%  interrupts.CPU1.RES:Rescheduling_interrupts
   3069047 ±  2%     -33.0%    2057271 ±  3%  interrupts.CPU10.LOC:Local_timer_interrupts
   3068860 ±  2%     -33.0%    2057039 ±  3%  interrupts.CPU100.LOC:Local_timer_interrupts
   3068788 ±  2%     -33.0%    2057016 ±  3%  interrupts.CPU101.LOC:Local_timer_interrupts
   3068902 ±  2%     -33.0%    2056953 ±  3%  interrupts.CPU102.LOC:Local_timer_interrupts
   3068874 ±  2%     -33.0%    2057082 ±  3%  interrupts.CPU103.LOC:Local_timer_interrupts
   3068837 ±  2%     -33.0%    2057099 ±  3%  interrupts.CPU104.LOC:Local_timer_interrupts
   3068782 ±  2%     -33.0%    2057017 ±  3%  interrupts.CPU105.LOC:Local_timer_interrupts
   3068825 ±  2%     -33.0%    2056945 ±  3%  interrupts.CPU106.LOC:Local_timer_interrupts
   3068774 ±  2%     -33.0%    2056953 ±  3%  interrupts.CPU107.LOC:Local_timer_interrupts
   3068907 ±  2%     -33.0%    2057107 ±  3%  interrupts.CPU108.LOC:Local_timer_interrupts
   3068930 ±  2%     -33.0%    2057005 ±  3%  interrupts.CPU109.LOC:Local_timer_interrupts
   3069038 ±  2%     -33.0%    2057015 ±  3%  interrupts.CPU11.LOC:Local_timer_interrupts
   3068767 ±  2%     -33.0%    2057060 ±  3%  interrupts.CPU110.LOC:Local_timer_interrupts
   3069063 ±  2%     -33.0%    2057173 ±  3%  interrupts.CPU111.LOC:Local_timer_interrupts
   2047029 ± 20%     +50.9%    3089234 ± 19%  interrupts.CPU111.RES:Rescheduling_interrupts
   3068794 ±  2%     -33.0%    2057038 ±  3%  interrupts.CPU112.LOC:Local_timer_interrupts
   3068806 ±  2%     -33.0%    2057275 ±  3%  interrupts.CPU113.LOC:Local_timer_interrupts
   3068865 ±  2%     -33.0%    2057053 ±  3%  interrupts.CPU114.LOC:Local_timer_interrupts
   3068846 ±  2%     -33.0%    2056994 ±  3%  interrupts.CPU115.LOC:Local_timer_interrupts
   3068875 ±  2%     -33.0%    2057000 ±  3%  interrupts.CPU116.LOC:Local_timer_interrupts
   3068933 ±  2%     -33.0%    2057012 ±  3%  interrupts.CPU117.LOC:Local_timer_interrupts
   2181060 ± 15%     +29.6%    2826706 ± 17%  interrupts.CPU117.RES:Rescheduling_interrupts
   3068848 ±  2%     -33.0%    2057041 ±  3%  interrupts.CPU118.LOC:Local_timer_interrupts
   1928528 ± 16%     +66.8%    3216476 ± 22%  interrupts.CPU118.RES:Rescheduling_interrupts
   3068981 ±  2%     -33.0%    2057056 ±  3%  interrupts.CPU119.LOC:Local_timer_interrupts
   3068882 ±  2%     -33.0%    2057126 ±  3%  interrupts.CPU12.LOC:Local_timer_interrupts
   3068504 ±  2%     -33.0%    2056694 ±  3%  interrupts.CPU120.LOC:Local_timer_interrupts
   3068536 ±  2%     -33.0%    2056659 ±  3%  interrupts.CPU121.LOC:Local_timer_interrupts
  10108354 ± 22%     -45.9%    5470800 ± 50%  interrupts.CPU122.CAL:Function_call_interrupts
   3068562 ±  2%     -33.0%    2056653 ±  3%  interrupts.CPU122.LOC:Local_timer_interrupts
   3068480 ±  2%     -33.0%    2056677 ±  3%  interrupts.CPU123.LOC:Local_timer_interrupts
   3068501 ±  2%     -33.0%    2056658 ±  3%  interrupts.CPU124.LOC:Local_timer_interrupts
   3068580 ±  2%     -33.0%    2056697 ±  3%  interrupts.CPU125.LOC:Local_timer_interrupts
   3068654 ±  2%     -33.0%    2056619 ±  3%  interrupts.CPU126.LOC:Local_timer_interrupts
   3068613 ±  2%     -33.0%    2056633 ±  3%  interrupts.CPU127.LOC:Local_timer_interrupts
   8613086 ± 30%     -38.0%    5335817 ± 40%  interrupts.CPU128.CAL:Function_call_interrupts
   3068601 ±  2%     -33.0%    2056671 ±  3%  interrupts.CPU128.LOC:Local_timer_interrupts
   3068506 ±  2%     -33.0%    2056669 ±  3%  interrupts.CPU129.LOC:Local_timer_interrupts
   3068927 ±  2%     -33.0%    2057122 ±  3%  interrupts.CPU13.LOC:Local_timer_interrupts
   3068604 ±  2%     -33.0%    2056721 ±  3%  interrupts.CPU130.LOC:Local_timer_interrupts
   3068608 ±  2%     -33.0%    2056674 ±  3%  interrupts.CPU131.LOC:Local_timer_interrupts
   3068614 ±  2%     -33.0%    2056682 ±  3%  interrupts.CPU132.LOC:Local_timer_interrupts
   3068628 ±  2%     -33.0%    2056688 ±  3%  interrupts.CPU133.LOC:Local_timer_interrupts
   3068579 ±  2%     -33.0%    2056754 ±  3%  interrupts.CPU134.LOC:Local_timer_interrupts
   9908620 ± 17%     -41.8%    5762355 ± 37%  interrupts.CPU135.CAL:Function_call_interrupts
   3068551 ±  2%     -33.0%    2056654 ±  3%  interrupts.CPU135.LOC:Local_timer_interrupts
   2579601 ± 13%     +26.8%    3271812 ±  8%  interrupts.CPU135.RES:Rescheduling_interrupts
   9893222 ± 13%     -41.9%    5750291 ± 41%  interrupts.CPU136.CAL:Function_call_interrupts
   3068594 ±  2%     -33.0%    2056682 ±  3%  interrupts.CPU136.LOC:Local_timer_interrupts
   8859106 ± 29%     -36.4%    5638024 ± 45%  interrupts.CPU137.CAL:Function_call_interrupts
   3068569 ±  2%     -33.0%    2056686 ±  3%  interrupts.CPU137.LOC:Local_timer_interrupts
  10450231 ± 29%     -50.0%    5220116 ± 43%  interrupts.CPU138.CAL:Function_call_interrupts
   3068487 ±  2%     -33.0%    2056626 ±  3%  interrupts.CPU138.LOC:Local_timer_interrupts
  10266532 ± 14%     -46.7%    5467357 ± 40%  interrupts.CPU139.CAL:Function_call_interrupts
   3068574 ±  2%     -33.0%    2056681 ±  3%  interrupts.CPU139.LOC:Local_timer_interrupts
   3068883 ±  2%     -33.0%    2057013 ±  3%  interrupts.CPU14.LOC:Local_timer_interrupts
   3068438 ±  2%     -33.0%    2056701 ±  3%  interrupts.CPU140.LOC:Local_timer_interrupts
  10997529 ± 34%     -52.2%    5258673 ± 43%  interrupts.CPU141.CAL:Function_call_interrupts
   3068575 ±  2%     -33.0%    2056672 ±  3%  interrupts.CPU141.LOC:Local_timer_interrupts
  10525182 ± 20%     -45.5%    5740160 ± 36%  interrupts.CPU142.CAL:Function_call_interrupts
   3068527 ±  2%     -33.0%    2056675 ±  3%  interrupts.CPU142.LOC:Local_timer_interrupts
   3068512 ±  2%     -33.0%    2056710 ±  3%  interrupts.CPU143.LOC:Local_timer_interrupts
  15399949 ± 14%     -41.8%    8962485 ± 27%  interrupts.CPU144.CAL:Function_call_interrupts
   3068419 ±  2%     -33.0%    2056607 ±  3%  interrupts.CPU144.LOC:Local_timer_interrupts
  10281339 ± 11%     -36.3%    6544192 ± 28%  interrupts.CPU145.CAL:Function_call_interrupts
   3068492 ±  2%     -33.0%    2056585 ±  3%  interrupts.CPU145.LOC:Local_timer_interrupts
  10754518 ± 10%     -35.4%    6942483 ± 32%  interrupts.CPU146.CAL:Function_call_interrupts
   3068391 ±  2%     -33.0%    2056699 ±  3%  interrupts.CPU146.LOC:Local_timer_interrupts
  11596622 ± 11%     -49.4%    5862855 ± 14%  interrupts.CPU147.CAL:Function_call_interrupts
   3068489 ±  2%     -33.0%    2056558 ±  3%  interrupts.CPU147.LOC:Local_timer_interrupts
   3068564 ±  2%     -33.0%    2056604 ±  3%  interrupts.CPU148.LOC:Local_timer_interrupts
  10264948 ± 18%     -41.0%    6052360 ± 24%  interrupts.CPU149.CAL:Function_call_interrupts
   3068493 ±  2%     -33.0%    2056571 ±  3%  interrupts.CPU149.LOC:Local_timer_interrupts
   3068985 ±  2%     -33.0%    2057059 ±  3%  interrupts.CPU15.LOC:Local_timer_interrupts
  10640620 ± 21%     -36.8%    6719798 ± 27%  interrupts.CPU150.CAL:Function_call_interrupts
   3068456 ±  2%     -33.0%    2056548 ±  3%  interrupts.CPU150.LOC:Local_timer_interrupts
  11941375 ± 27%     -45.5%    6507800 ± 38%  interrupts.CPU151.CAL:Function_call_interrupts
   3068543 ±  2%     -33.0%    2056582 ±  3%  interrupts.CPU151.LOC:Local_timer_interrupts
   3068545 ±  2%     -33.0%    2056610 ±  3%  interrupts.CPU152.LOC:Local_timer_interrupts
   3068506 ±  2%     -33.0%    2056602 ±  3%  interrupts.CPU153.LOC:Local_timer_interrupts
   3068491 ±  2%     -33.0%    2056578 ±  3%  interrupts.CPU154.LOC:Local_timer_interrupts
   3068416 ±  2%     -33.0%    2056585 ±  3%  interrupts.CPU155.LOC:Local_timer_interrupts
  11182149 ± 28%     -43.0%    6371185 ± 22%  interrupts.CPU156.CAL:Function_call_interrupts
   3068566 ±  2%     -33.0%    2056586 ±  3%  interrupts.CPU156.LOC:Local_timer_interrupts
  10314090 ± 21%     -37.9%    6403854 ± 41%  interrupts.CPU157.CAL:Function_call_interrupts
   3068567 ±  2%     -33.0%    2056610 ±  3%  interrupts.CPU157.LOC:Local_timer_interrupts
  11129901 ± 16%     -38.7%    6827535 ± 42%  interrupts.CPU158.CAL:Function_call_interrupts
   3068396 ±  2%     -33.0%    2056570 ±  3%  interrupts.CPU158.LOC:Local_timer_interrupts
   3068626 ±  2%     -33.0%    2056594 ±  3%  interrupts.CPU159.LOC:Local_timer_interrupts
   3068810 ±  2%     -33.0%    2057138 ±  3%  interrupts.CPU16.LOC:Local_timer_interrupts
   2006008 ±  8%     +21.9%    2445856 ±  8%  interrupts.CPU16.RES:Rescheduling_interrupts
   3068549 ±  2%     -33.0%    2056601 ±  3%  interrupts.CPU160.LOC:Local_timer_interrupts
   3068397 ±  2%     -33.0%    2056605 ±  3%  interrupts.CPU161.LOC:Local_timer_interrupts
  12689653 ± 26%     -45.5%    6921228 ± 42%  interrupts.CPU162.CAL:Function_call_interrupts
   3068611 ±  2%     -33.0%    2056601 ±  3%  interrupts.CPU162.LOC:Local_timer_interrupts
  11554610 ± 25%     -51.1%    5646100 ± 27%  interrupts.CPU163.CAL:Function_call_interrupts
   3068522 ±  2%     -33.0%    2056610 ±  3%  interrupts.CPU163.LOC:Local_timer_interrupts
  11058349 ± 22%     -52.9%    5206973 ± 30%  interrupts.CPU164.CAL:Function_call_interrupts
   3068378 ±  2%     -33.0%    2056602 ±  3%  interrupts.CPU164.LOC:Local_timer_interrupts
   3068367 ±  2%     -33.0%    2056597 ±  3%  interrupts.CPU165.LOC:Local_timer_interrupts
  10546615 ± 15%     -41.1%    6216711 ± 24%  interrupts.CPU166.CAL:Function_call_interrupts
   3068546 ±  2%     -33.0%    2056587 ±  3%  interrupts.CPU166.LOC:Local_timer_interrupts
   3068381 ±  2%     -33.0%    2056590 ±  3%  interrupts.CPU167.LOC:Local_timer_interrupts
  14348960 ± 26%     -44.5%    7968793 ± 28%  interrupts.CPU168.CAL:Function_call_interrupts
   3068429 ±  2%     -33.0%    2056515 ±  3%  interrupts.CPU168.LOC:Local_timer_interrupts
   9037033 ±  8%     -40.9%    5343981 ± 33%  interrupts.CPU169.CAL:Function_call_interrupts
   3068245 ±  2%     -33.0%    2056521 ±  3%  interrupts.CPU169.LOC:Local_timer_interrupts
   3068796 ±  2%     -33.0%    2057061 ±  3%  interrupts.CPU17.LOC:Local_timer_interrupts
   3068458 ±  2%     -33.0%    2056570 ±  3%  interrupts.CPU170.LOC:Local_timer_interrupts
   3068456 ±  2%     -33.0%    2056537 ±  3%  interrupts.CPU171.LOC:Local_timer_interrupts
   2955398 ±  8%     +18.1%    3491658 ±  9%  interrupts.CPU171.RES:Rescheduling_interrupts
   3068436 ±  2%     -33.0%    2056565 ±  3%  interrupts.CPU172.LOC:Local_timer_interrupts
   2682491 ± 11%     +25.5%    3366650 ±  7%  interrupts.CPU172.RES:Rescheduling_interrupts
  10459980 ± 17%     -35.6%    6741253 ± 40%  interrupts.CPU173.CAL:Function_call_interrupts
   3068448 ±  2%     -33.0%    2056554 ±  3%  interrupts.CPU173.LOC:Local_timer_interrupts
   3068386 ±  2%     -33.0%    2056544 ±  3%  interrupts.CPU174.LOC:Local_timer_interrupts
  10400439 ± 22%     -42.0%    6030941 ± 19%  interrupts.CPU175.CAL:Function_call_interrupts
   3068481 ±  2%     -33.0%    2056548 ±  3%  interrupts.CPU175.LOC:Local_timer_interrupts
   3068419 ±  2%     -33.0%    2056525 ±  3%  interrupts.CPU176.LOC:Local_timer_interrupts
   9716947 ± 21%     -36.1%    6213209 ± 38%  interrupts.CPU177.CAL:Function_call_interrupts
   3068339 ±  2%     -33.0%    2056576 ±  3%  interrupts.CPU177.LOC:Local_timer_interrupts
   2786012 ± 13%     +26.8%    3533937 ±  3%  interrupts.CPU177.RES:Rescheduling_interrupts
   9637199 ± 27%     -48.9%    4919892 ± 36%  interrupts.CPU178.CAL:Function_call_interrupts
   3068474 ±  2%     -33.0%    2056541 ±  3%  interrupts.CPU178.LOC:Local_timer_interrupts
   9888292 ± 37%     -46.3%    5308589 ± 23%  interrupts.CPU179.CAL:Function_call_interrupts
   3068405 ±  2%     -33.0%    2056544 ±  3%  interrupts.CPU179.LOC:Local_timer_interrupts
   3069027 ±  2%     -33.0%    2057052 ±  3%  interrupts.CPU18.LOC:Local_timer_interrupts
   3068383 ±  2%     -33.0%    2056569 ±  3%  interrupts.CPU180.LOC:Local_timer_interrupts
   3068302 ±  2%     -33.0%    2056495 ±  3%  interrupts.CPU181.LOC:Local_timer_interrupts
  10805869 ± 23%     -46.2%    5813818 ± 28%  interrupts.CPU182.CAL:Function_call_interrupts
   3068259 ±  2%     -33.0%    2056541 ±  3%  interrupts.CPU182.LOC:Local_timer_interrupts
   2762944 ±  6%     +31.1%    3623514 ± 14%  interrupts.CPU182.RES:Rescheduling_interrupts
  10793214 ± 25%     -45.8%    5852092 ± 23%  interrupts.CPU183.CAL:Function_call_interrupts
   3068289 ±  2%     -33.0%    2056543 ±  3%  interrupts.CPU183.LOC:Local_timer_interrupts
   2586038 ± 12%     +30.6%    3377221 ± 12%  interrupts.CPU183.RES:Rescheduling_interrupts
   3068277 ±  2%     -33.0%    2056545 ±  3%  interrupts.CPU184.LOC:Local_timer_interrupts
   3068374 ±  2%     -33.0%    2056550 ±  3%  interrupts.CPU185.LOC:Local_timer_interrupts
   3068253 ±  2%     -33.0%    2056481 ±  3%  interrupts.CPU186.LOC:Local_timer_interrupts
   2649495 ± 12%     +31.9%    3494494 ± 10%  interrupts.CPU186.RES:Rescheduling_interrupts
  10025765 ± 21%     -43.0%    5712695 ± 25%  interrupts.CPU187.CAL:Function_call_interrupts
   3068329 ±  2%     -33.0%    2056551 ±  3%  interrupts.CPU187.LOC:Local_timer_interrupts
   2892028 ± 13%     +26.9%    3670638 ± 12%  interrupts.CPU187.RES:Rescheduling_interrupts
  11151288 ± 17%     -37.4%    6986064 ± 32%  interrupts.CPU188.CAL:Function_call_interrupts
   3068414 ±  2%     -33.0%    2056521 ±  3%  interrupts.CPU188.LOC:Local_timer_interrupts
   3068465 ±  2%     -33.0%    2056552 ±  3%  interrupts.CPU189.LOC:Local_timer_interrupts
   3068875 ±  2%     -33.0%    2057045 ±  3%  interrupts.CPU19.LOC:Local_timer_interrupts
   3068371 ±  2%     -33.0%    2056571 ±  3%  interrupts.CPU190.LOC:Local_timer_interrupts
   3068404 ±  2%     -33.0%    2056531 ±  3%  interrupts.CPU191.LOC:Local_timer_interrupts
   2761094 ± 11%     +22.6%    3384449 ± 13%  interrupts.CPU191.RES:Rescheduling_interrupts
   3068844 ±  2%     -33.0%    2057030 ±  3%  interrupts.CPU2.LOC:Local_timer_interrupts
   3068960 ±  2%     -33.0%    2057035 ±  3%  interrupts.CPU20.LOC:Local_timer_interrupts
   3068786 ±  2%     -33.0%    2057052 ±  3%  interrupts.CPU21.LOC:Local_timer_interrupts
   3068957 ±  2%     -33.0%    2057028 ±  3%  interrupts.CPU22.LOC:Local_timer_interrupts
   3068805 ±  2%     -33.0%    2057075 ±  3%  interrupts.CPU23.LOC:Local_timer_interrupts
   3068509 ±  2%     -33.0%    2056726 ±  3%  interrupts.CPU24.LOC:Local_timer_interrupts
   3068428 ±  2%     -33.0%    2056699 ±  3%  interrupts.CPU25.LOC:Local_timer_interrupts
   3068521 ±  2%     -33.0%    2056656 ±  3%  interrupts.CPU26.LOC:Local_timer_interrupts
   3068485 ±  2%     -33.0%    2056654 ±  3%  interrupts.CPU27.LOC:Local_timer_interrupts
   3068591 ±  2%     -33.0%    2056697 ±  3%  interrupts.CPU28.LOC:Local_timer_interrupts
   3068586 ±  2%     -33.0%    2056722 ±  3%  interrupts.CPU29.LOC:Local_timer_interrupts
   3068781 ±  2%     -33.0%    2057281 ±  3%  interrupts.CPU3.LOC:Local_timer_interrupts
   2058882 ±  8%     +37.5%    2830697 ± 16%  interrupts.CPU3.RES:Rescheduling_interrupts
   9634161 ± 25%     -48.5%    4959876 ± 37%  interrupts.CPU30.CAL:Function_call_interrupts
   3068605 ±  2%     -33.0%    2056691 ±  3%  interrupts.CPU30.LOC:Local_timer_interrupts
   3068530 ±  2%     -33.0%    2056720 ±  3%  interrupts.CPU31.LOC:Local_timer_interrupts
   3068594 ±  2%     -33.0%    2056673 ±  3%  interrupts.CPU32.LOC:Local_timer_interrupts
   3068489 ±  2%     -33.0%    2056665 ±  3%  interrupts.CPU33.LOC:Local_timer_interrupts
   9626755 ± 23%     -43.7%    5423271 ± 39%  interrupts.CPU34.CAL:Function_call_interrupts
   3068542 ±  2%     -33.0%    2056673 ±  3%  interrupts.CPU34.LOC:Local_timer_interrupts
   3068547 ±  2%     -33.0%    2056637 ±  3%  interrupts.CPU35.LOC:Local_timer_interrupts
   3068584 ±  2%     -33.0%    2056645 ±  3%  interrupts.CPU36.LOC:Local_timer_interrupts
   2308345 ±  3%     +21.9%    2814386 ±  5%  interrupts.CPU36.RES:Rescheduling_interrupts
   3068617 ±  2%     -33.0%    2056701 ±  3%  interrupts.CPU37.LOC:Local_timer_interrupts
   2447075 ±  5%     +18.6%    2902611 ±  8%  interrupts.CPU37.RES:Rescheduling_interrupts
   9333901 ± 18%     -43.7%    5253242 ± 46%  interrupts.CPU38.CAL:Function_call_interrupts
   3068597 ±  2%     -33.0%    2056701 ±  3%  interrupts.CPU38.LOC:Local_timer_interrupts
   8973018 ± 11%     -29.1%    6363051 ± 41%  interrupts.CPU39.CAL:Function_call_interrupts
   3068594 ±  2%     -33.0%    2056719 ±  3%  interrupts.CPU39.LOC:Local_timer_interrupts
   3068897 ±  2%     -33.0%    2057142 ±  3%  interrupts.CPU4.LOC:Local_timer_interrupts
   8916276 ± 24%     -38.4%    5488654 ± 40%  interrupts.CPU40.CAL:Function_call_interrupts
   3068610 ±  2%     -33.0%    2056665 ±  3%  interrupts.CPU40.LOC:Local_timer_interrupts
   3068577 ±  2%     -33.0%    2056681 ±  3%  interrupts.CPU41.LOC:Local_timer_interrupts
  10118061 ± 29%     -48.1%    5247165 ± 42%  interrupts.CPU42.CAL:Function_call_interrupts
   3068526 ±  2%     -33.0%    2056558 ±  3%  interrupts.CPU42.LOC:Local_timer_interrupts
   9709031 ± 12%     -42.0%    5627612 ± 37%  interrupts.CPU43.CAL:Function_call_interrupts
   3068543 ±  2%     -33.0%    2056676 ±  3%  interrupts.CPU43.LOC:Local_timer_interrupts
   9925720 ± 28%     -50.1%    4948073 ± 39%  interrupts.CPU44.CAL:Function_call_interrupts
   3068519 ±  2%     -33.0%    2056749 ±  3%  interrupts.CPU44.LOC:Local_timer_interrupts
   9581695 ± 18%     -42.5%    5508025 ± 43%  interrupts.CPU45.CAL:Function_call_interrupts
   3068590 ±  2%     -33.0%    2056696 ±  3%  interrupts.CPU45.LOC:Local_timer_interrupts
   9195132 ± 24%     -35.5%    5931145 ± 43%  interrupts.CPU46.CAL:Function_call_interrupts
   3068544 ±  2%     -33.0%    2056696 ±  3%  interrupts.CPU46.LOC:Local_timer_interrupts
   3068531 ±  2%     -33.0%    2056571 ±  3%  interrupts.CPU47.LOC:Local_timer_interrupts
   3068482 ±  2%     -33.0%    2056580 ±  3%  interrupts.CPU48.LOC:Local_timer_interrupts
  10877934 ± 17%     -38.7%    6666999 ± 38%  interrupts.CPU49.CAL:Function_call_interrupts
   3068444 ±  2%     -33.0%    2056577 ±  3%  interrupts.CPU49.LOC:Local_timer_interrupts
   3068920 ±  2%     -33.0%    2057131 ±  3%  interrupts.CPU5.LOC:Local_timer_interrupts
  10434336 ± 20%     -42.8%    5966100 ± 30%  interrupts.CPU50.CAL:Function_call_interrupts
   3068377 ±  2%     -33.0%    2056590 ±  3%  interrupts.CPU50.LOC:Local_timer_interrupts
   3068408 ±  2%     -33.0%    2056586 ±  3%  interrupts.CPU51.LOC:Local_timer_interrupts
   2394615 ±  5%     +12.6%    2695289 ±  4%  interrupts.CPU51.RES:Rescheduling_interrupts
  11720117 ± 14%     -50.6%    5785902 ± 24%  interrupts.CPU52.CAL:Function_call_interrupts
   3068577 ±  2%     -33.0%    2056563 ±  3%  interrupts.CPU52.LOC:Local_timer_interrupts
   2253641 ±  6%     +27.7%    2878787 ±  8%  interrupts.CPU52.RES:Rescheduling_interrupts
  10368352 ± 19%     -49.2%    5265238 ± 31%  interrupts.CPU53.CAL:Function_call_interrupts
   3068506 ±  2%     -33.0%    2056579 ±  3%  interrupts.CPU53.LOC:Local_timer_interrupts
   3068443 ±  2%     -33.0%    2056580 ±  3%  interrupts.CPU54.LOC:Local_timer_interrupts
  11142575 ± 15%     -40.7%    6611607 ± 34%  interrupts.CPU55.CAL:Function_call_interrupts
   3068447 ±  2%     -33.0%    2056593 ±  3%  interrupts.CPU55.LOC:Local_timer_interrupts
  10507699 ± 21%     -40.8%    6221308 ± 25%  interrupts.CPU56.CAL:Function_call_interrupts
   3068546 ±  2%     -33.0%    2056569 ±  3%  interrupts.CPU56.LOC:Local_timer_interrupts
  11506471 ± 17%     -45.7%    6247067 ± 38%  interrupts.CPU57.CAL:Function_call_interrupts
   3068520 ±  2%     -33.0%    2056614 ±  3%  interrupts.CPU57.LOC:Local_timer_interrupts
  10149739 ± 20%     -39.9%    6095837 ± 23%  interrupts.CPU58.CAL:Function_call_interrupts
   3068431 ±  2%     -33.0%    2056573 ±  3%  interrupts.CPU58.LOC:Local_timer_interrupts
   3068377 ±  2%     -33.0%    2056566 ±  3%  interrupts.CPU59.LOC:Local_timer_interrupts
   3068862 ±  2%     -33.0%    2056994 ±  3%  interrupts.CPU6.LOC:Local_timer_interrupts
   3068645 ±  2%     -33.0%    2056612 ±  3%  interrupts.CPU60.LOC:Local_timer_interrupts
   9349585 ±  9%     -33.4%    6228620 ± 34%  interrupts.CPU61.CAL:Function_call_interrupts
   3068468 ±  2%     -33.0%    2056547 ±  3%  interrupts.CPU61.LOC:Local_timer_interrupts
  10179611 ± 22%     -45.1%    5589466 ± 24%  interrupts.CPU62.CAL:Function_call_interrupts
   3068405 ±  2%     -33.0%    2056589 ±  3%  interrupts.CPU62.LOC:Local_timer_interrupts
   9645667 ± 23%     -42.5%    5546114 ± 24%  interrupts.CPU63.CAL:Function_call_interrupts
   3068614 ±  2%     -33.0%    2056621 ±  3%  interrupts.CPU63.LOC:Local_timer_interrupts
   2437604 ± 14%     +20.8%    2943790 ±  9%  interrupts.CPU63.RES:Rescheduling_interrupts
   3068509 ±  2%     -33.0%    2056525 ±  3%  interrupts.CPU64.LOC:Local_timer_interrupts
   2251691 ±  6%     +29.9%    2925998 ± 13%  interrupts.CPU64.RES:Rescheduling_interrupts
   3068329 ±  2%     -33.0%    2056632 ±  3%  interrupts.CPU65.LOC:Local_timer_interrupts
   3068522 ±  2%     -33.0%    2056593 ±  3%  interrupts.CPU66.LOC:Local_timer_interrupts
  10646786 ± 21%     -41.8%    6197071 ± 33%  interrupts.CPU67.CAL:Function_call_interrupts
   3068457 ±  2%     -33.0%    2056518 ±  3%  interrupts.CPU67.LOC:Local_timer_interrupts
  10774555 ± 35%     -44.0%    6033539 ± 40%  interrupts.CPU68.CAL:Function_call_interrupts
   3068410 ±  2%     -33.0%    2056612 ±  3%  interrupts.CPU68.LOC:Local_timer_interrupts
   2318101 ± 11%     +27.2%    2947490 ±  9%  interrupts.CPU68.RES:Rescheduling_interrupts
  10792638 ± 23%     -41.9%    6272497 ± 25%  interrupts.CPU69.CAL:Function_call_interrupts
   3068572 ±  2%     -33.0%    2056539 ±  3%  interrupts.CPU69.LOC:Local_timer_interrupts
   2308398 ± 12%     +30.7%    3017171 ± 10%  interrupts.CPU69.RES:Rescheduling_interrupts
   3068931 ±  2%     -33.0%    2057070 ±  3%  interrupts.CPU7.LOC:Local_timer_interrupts
  10843214 ± 28%     -50.0%    5417943 ± 23%  interrupts.CPU70.CAL:Function_call_interrupts
   3068472 ±  2%     -33.0%    2056640 ±  3%  interrupts.CPU70.LOC:Local_timer_interrupts
   9594747 ± 20%     -38.5%    5903738 ± 32%  interrupts.CPU71.CAL:Function_call_interrupts
   3068422 ±  2%     -33.0%    2056599 ±  3%  interrupts.CPU71.LOC:Local_timer_interrupts
   3068473 ±  2%     -33.0%    2056592 ±  3%  interrupts.CPU72.LOC:Local_timer_interrupts
   1474907 ± 14%     +30.4%    1923058 ±  8%  interrupts.CPU72.RES:Rescheduling_interrupts
   3068248 ±  2%     -33.0%    2056570 ±  3%  interrupts.CPU73.LOC:Local_timer_interrupts
  10473721 ± 30%     -44.1%    5855397 ± 29%  interrupts.CPU74.CAL:Function_call_interrupts
   3068397 ±  2%     -33.0%    2056552 ±  3%  interrupts.CPU74.LOC:Local_timer_interrupts
   2372716 ± 11%     +25.9%    2986766 ±  8%  interrupts.CPU74.RES:Rescheduling_interrupts
   3068444 ±  2%     -33.0%    2056444 ±  3%  interrupts.CPU75.LOC:Local_timer_interrupts
  11003452 ± 27%     -53.5%    5111244 ± 29%  interrupts.CPU76.CAL:Function_call_interrupts
   3068425 ±  2%     -33.0%    2056621 ±  3%  interrupts.CPU76.LOC:Local_timer_interrupts
   2395091 ±  3%     +23.6%    2961177 ±  5%  interrupts.CPU76.RES:Rescheduling_interrupts
  10304316 ± 22%     -47.7%    5391627 ± 37%  interrupts.CPU77.CAL:Function_call_interrupts
   3068453 ±  2%     -33.0%    2056581 ±  3%  interrupts.CPU77.LOC:Local_timer_interrupts
   3068435 ±  2%     -33.0%    2056550 ±  3%  interrupts.CPU78.LOC:Local_timer_interrupts
   3068478 ±  2%     -33.0%    2056579 ±  3%  interrupts.CPU79.LOC:Local_timer_interrupts
   3068902 ±  2%     -33.0%    2057100 ±  3%  interrupts.CPU8.LOC:Local_timer_interrupts
   9206669 ± 19%     -31.1%    6341522 ± 30%  interrupts.CPU80.CAL:Function_call_interrupts
   3068424 ±  2%     -33.0%    2056560 ±  3%  interrupts.CPU80.LOC:Local_timer_interrupts
   3068415 ±  2%     -33.0%    2056524 ±  3%  interrupts.CPU81.LOC:Local_timer_interrupts
   2256903 ±  7%     +35.1%    3048124 ±  9%  interrupts.CPU81.RES:Rescheduling_interrupts
  10279497 ± 22%     -40.6%    6102509 ± 32%  interrupts.CPU82.CAL:Function_call_interrupts
   3068481 ±  2%     -33.0%    2056568 ±  3%  interrupts.CPU82.LOC:Local_timer_interrupts
   2299462 ± 13%     +33.1%    3059500 ± 16%  interrupts.CPU82.RES:Rescheduling_interrupts
   3068382 ±  2%     -33.0%    2056553 ±  3%  interrupts.CPU83.LOC:Local_timer_interrupts
   2334299 ± 15%     +38.1%    3223620 ±  8%  interrupts.CPU83.RES:Rescheduling_interrupts
   3068415 ±  2%     -33.0%    2056565 ±  3%  interrupts.CPU84.LOC:Local_timer_interrupts
   3068289 ±  2%     -33.0%    2056562 ±  3%  interrupts.CPU85.LOC:Local_timer_interrupts
   3068338 ±  2%     -33.0%    2056564 ±  3%  interrupts.CPU86.LOC:Local_timer_interrupts
   9737271 ± 21%     -37.1%    6127891 ± 32%  interrupts.CPU87.CAL:Function_call_interrupts
   3068239 ±  2%     -33.0%    2056566 ±  3%  interrupts.CPU87.LOC:Local_timer_interrupts
   2450244 ± 12%     +19.3%    2923936 ±  7%  interrupts.CPU87.RES:Rescheduling_interrupts
   3068293 ±  2%     -33.0%    2056580 ±  3%  interrupts.CPU88.LOC:Local_timer_interrupts
   3068428 ±  2%     -33.0%    2056514 ±  3%  interrupts.CPU89.LOC:Local_timer_interrupts
   3068866 ±  2%     -33.0%    2057208 ±  3%  interrupts.CPU9.LOC:Local_timer_interrupts
  10771708 ± 22%     -40.4%    6418307 ± 41%  interrupts.CPU90.CAL:Function_call_interrupts
   3068285 ±  2%     -33.0%    2056556 ±  3%  interrupts.CPU90.LOC:Local_timer_interrupts
   3068278 ±  2%     -33.0%    2056556 ±  3%  interrupts.CPU91.LOC:Local_timer_interrupts
  11162745 ± 21%     -48.6%    5740747 ± 33%  interrupts.CPU92.CAL:Function_call_interrupts
   3068462 ±  2%     -33.0%    2056557 ±  3%  interrupts.CPU92.LOC:Local_timer_interrupts
   3068440 ±  2%     -33.0%    2056573 ±  3%  interrupts.CPU93.LOC:Local_timer_interrupts
   2384662 ±  6%     +27.4%    3038680 ± 11%  interrupts.CPU93.RES:Rescheduling_interrupts
  11224988 ± 21%     -50.3%    5582800 ± 29%  interrupts.CPU94.CAL:Function_call_interrupts
   3068420 ±  2%     -33.0%    2056571 ±  3%  interrupts.CPU94.LOC:Local_timer_interrupts
   2166238 ±  8%     +34.8%    2920149 ±  9%  interrupts.CPU94.RES:Rescheduling_interrupts
   3068516 ±  2%     -33.0%    2056621 ±  3%  interrupts.CPU95.LOC:Local_timer_interrupts
   3068777 ±  2%     -33.0%    2057005 ±  3%  interrupts.CPU96.LOC:Local_timer_interrupts
   1558944 ± 11%     +42.2%    2217344 ± 14%  interrupts.CPU96.RES:Rescheduling_interrupts
   3068840 ±  2%     -33.0%    2057051 ±  3%  interrupts.CPU97.LOC:Local_timer_interrupts
   3068904 ±  2%     -33.0%    2057003 ±  3%  interrupts.CPU98.LOC:Local_timer_interrupts
   3068839 ±  2%     -33.0%    2057016 ±  3%  interrupts.CPU99.LOC:Local_timer_interrupts
 5.892e+08 ±  2%     -33.0%  3.949e+08 ±  3%  interrupts.LOC:Local_timer_interrupts
    768.00           -25.0%     576.00        interrupts.MCP:Machine_check_polls
 4.829e+08 ±  2%     +17.6%  5.679e+08 ±  2%  interrupts.RES:Rescheduling_interrupts
    193152 ±  9%     -27.0%     141046 ± 10%  softirqs.CPU0.RCU
     20466 ±  5%     -19.9%      16386 ±  9%  softirqs.CPU0.SCHED
    198795 ±  8%     -27.6%     143897 ± 11%  softirqs.CPU1.RCU
    199997 ±  6%     -27.7%     144536 ± 10%  softirqs.CPU10.RCU
     16821           -23.2%      12913 ± 11%  softirqs.CPU10.SCHED
    201971 ±  6%     -27.8%     145893 ±  9%  softirqs.CPU100.RCU
    203243 ±  6%     -30.3%     141724 ± 11%  softirqs.CPU101.RCU
     16916 ±  3%     -23.6%      12922 ± 15%  softirqs.CPU101.SCHED
    202568 ±  6%     -28.1%     145584 ±  9%  softirqs.CPU102.RCU
     16083 ±  3%     -20.3%      12823 ± 11%  softirqs.CPU102.SCHED
    202688 ±  7%     -28.3%     145381 ± 10%  softirqs.CPU103.RCU
    201501 ±  6%     -28.4%     144361 ± 10%  softirqs.CPU104.RCU
     16532 ±  3%     -23.4%      12665 ± 11%  softirqs.CPU104.SCHED
    199791 ±  6%     -28.2%     143353 ± 10%  softirqs.CPU105.RCU
    201042 ±  6%     -28.3%     144152 ± 10%  softirqs.CPU106.RCU
    202312 ±  6%     -28.1%     145480 ± 10%  softirqs.CPU107.RCU
     16444 ±  3%     -23.2%      12634 ± 13%  softirqs.CPU107.SCHED
    203312 ±  7%     -28.5%     145443 ± 10%  softirqs.CPU108.RCU
     16406 ±  2%     -22.8%      12662 ± 13%  softirqs.CPU108.SCHED
    202511 ±  7%     -28.7%     144477 ± 10%  softirqs.CPU109.RCU
    201374 ±  6%     -28.2%     144674 ± 10%  softirqs.CPU11.RCU
     16619 ±  3%     -23.1%      12773 ± 11%  softirqs.CPU11.SCHED
    195860 ±  3%     -26.3%     144303 ±  9%  softirqs.CPU110.RCU
     16435 ±  3%     -21.9%      12831 ± 12%  softirqs.CPU110.SCHED
    200642 ±  6%     -28.5%     143450 ± 10%  softirqs.CPU111.RCU
     16380 ±  3%     -23.6%      12510 ± 11%  softirqs.CPU111.SCHED
    211528 ±  6%     -28.9%     150296 ±  8%  softirqs.CPU112.RCU
     16474 ±  3%     -22.3%      12807 ± 11%  softirqs.CPU112.SCHED
    204714 ±  9%     -26.6%     150278 ±  8%  softirqs.CPU113.RCU
    211999 ±  6%     -28.9%     150629 ±  9%  softirqs.CPU114.RCU
    206050 ±  9%     -26.8%     150897 ±  8%  softirqs.CPU115.RCU
     16399 ±  3%     -23.5%      12552 ± 11%  softirqs.CPU115.SCHED
    205829 ± 10%     -26.7%     150890 ±  8%  softirqs.CPU116.RCU
    211008 ±  6%     -28.6%     150563 ±  9%  softirqs.CPU117.RCU
    211452 ±  6%     -29.1%     149985 ±  9%  softirqs.CPU118.RCU
     16363 ±  2%     -21.9%      12772 ± 12%  softirqs.CPU118.SCHED
    211001 ±  6%     -28.8%     150251 ±  9%  softirqs.CPU119.RCU
     16215 ±  3%     -21.6%      12715 ± 11%  softirqs.CPU119.SCHED
    201592 ±  6%     -27.9%     145412 ± 10%  softirqs.CPU12.RCU
    214923 ±  5%     -28.9%     152762 ±  9%  softirqs.CPU120.RCU
     21496 ±  5%     -22.8%      16594 ± 15%  softirqs.CPU120.SCHED
    216154 ±  6%     -29.0%     153419 ±  9%  softirqs.CPU121.RCU
     23229 ±  8%     -22.2%      18076 ± 20%  softirqs.CPU121.SCHED
    214137 ±  6%     -28.7%     152664 ±  9%  softirqs.CPU122.RCU
     23979 ±  6%     -29.8%      16833 ± 14%  softirqs.CPU122.SCHED
    214695 ±  6%     -28.9%     152625 ±  9%  softirqs.CPU123.RCU
     23136 ±  6%     -25.7%      17189 ± 17%  softirqs.CPU123.SCHED
    214970 ±  6%     -29.0%     152602 ±  9%  softirqs.CPU124.RCU
    214197 ±  6%     -29.0%     152008 ±  9%  softirqs.CPU125.RCU
     23064 ±  7%     -22.0%      17979 ± 19%  softirqs.CPU125.SCHED
    214136 ±  6%     -28.9%     152201 ±  9%  softirqs.CPU126.RCU
    214555 ±  5%     -29.0%     152287 ±  9%  softirqs.CPU127.RCU
     22979 ±  6%     -25.8%      17052 ± 15%  softirqs.CPU127.SCHED
    209028 ±  6%     -28.9%     148635 ± 10%  softirqs.CPU128.RCU
    208002 ±  6%     -28.8%     148083 ±  9%  softirqs.CPU129.RCU
     23928 ± 11%     -27.1%      17436 ± 16%  softirqs.CPU129.SCHED
    202575 ±  6%     -28.5%     144932 ± 10%  softirqs.CPU13.RCU
    209069 ±  6%     -29.2%     148034 ±  9%  softirqs.CPU130.RCU
     23435 ±  7%     -28.9%      16657 ± 16%  softirqs.CPU130.SCHED
    207986 ±  6%     -29.1%     147499 ±  9%  softirqs.CPU131.RCU
     23531 ±  8%     -24.7%      17709 ± 20%  softirqs.CPU131.SCHED
    208157 ±  6%     -29.1%     147628 ±  9%  softirqs.CPU132.RCU
     23491 ±  3%     -25.2%      17567 ± 20%  softirqs.CPU132.SCHED
    209272 ±  6%     -28.8%     148934 ±  9%  softirqs.CPU133.RCU
     23297 ±  7%     -25.1%      17460 ± 16%  softirqs.CPU133.SCHED
    209483 ±  6%     -28.9%     148915 ±  9%  softirqs.CPU134.RCU
     23150 ±  8%     -24.6%      17465 ± 17%  softirqs.CPU134.SCHED
    208558 ±  6%     -30.7%     144575 ± 12%  softirqs.CPU135.RCU
     23637 ± 11%     -25.3%      17667 ± 18%  softirqs.CPU135.SCHED
    208527 ±  6%     -28.7%     148690 ± 10%  softirqs.CPU136.RCU
     23160 ±  6%     -26.6%      17008 ± 15%  softirqs.CPU136.SCHED
    208023 ±  5%     -28.8%     148204 ± 10%  softirqs.CPU137.RCU
     23032 ±  5%     -25.5%      17159 ± 17%  softirqs.CPU137.SCHED
    207076 ±  6%     -28.6%     147817 ±  9%  softirqs.CPU138.RCU
     22784 ±  7%     -23.3%      17468 ± 17%  softirqs.CPU138.SCHED
    209164 ±  6%     -28.8%     148824 ±  9%  softirqs.CPU139.RCU
     24161 ± 10%     -21.8%      18898 ± 20%  softirqs.CPU139.SCHED
    196930 ±  4%     -27.0%     143744 ± 10%  softirqs.CPU14.RCU
     16312 ±  2%     -22.1%      12708 ± 12%  softirqs.CPU14.SCHED
    208960 ±  6%     -29.0%     148425 ±  9%  softirqs.CPU140.RCU
     23188 ±  9%     -24.5%      17507 ± 17%  softirqs.CPU140.SCHED
    207359 ±  6%     -28.7%     147876 ±  9%  softirqs.CPU141.RCU
     23048 ± 10%     -24.6%      17386 ± 16%  softirqs.CPU141.SCHED
    207289 ±  6%     -28.7%     147752 ±  9%  softirqs.CPU142.RCU
     24215 ±  9%     -30.2%      16912 ± 14%  softirqs.CPU142.SCHED
    207500 ±  6%     -29.2%     146807 ± 10%  softirqs.CPU143.RCU
     24472 ± 12%     -26.8%      17911 ± 17%  softirqs.CPU143.SCHED
    206965 ±  6%     -27.9%     149195 ±  9%  softirqs.CPU144.RCU
     21705 ± 10%     -18.8%      17632 ±  8%  softirqs.CPU144.SCHED
    207306 ±  6%     -28.4%     148376 ±  9%  softirqs.CPU145.RCU
     22890 ±  3%     -17.9%      18789 ± 11%  softirqs.CPU145.SCHED
    206457 ±  6%     -28.3%     147988 ±  9%  softirqs.CPU146.RCU
     23549 ±  6%     -21.3%      18533 ± 11%  softirqs.CPU146.SCHED
    206651 ±  6%     -28.2%     148428 ±  9%  softirqs.CPU147.RCU
     24170 ±  5%     -23.1%      18583 ±  9%  softirqs.CPU147.SCHED
    206659 ±  6%     -28.6%     147586 ±  9%  softirqs.CPU148.RCU
     23554 ±  3%     -22.2%      18317 ±  6%  softirqs.CPU148.SCHED
    205141 ±  6%     -28.2%     147197 ±  9%  softirqs.CPU149.RCU
     23640 ±  6%     -23.1%      18177 ±  9%  softirqs.CPU149.SCHED
    199223 ±  6%     -29.6%     140263 ± 12%  softirqs.CPU15.RCU
     16350 ±  2%     -24.3%      12381 ±  8%  softirqs.CPU15.SCHED
    205951 ±  6%     -28.4%     147445 ±  9%  softirqs.CPU150.RCU
     23317 ±  8%     -18.7%      18965 ± 13%  softirqs.CPU150.SCHED
    207287 ±  6%     -27.9%     149366 ±  9%  softirqs.CPU151.RCU
     24764 ±  5%     -28.4%      17742 ± 10%  softirqs.CPU151.SCHED
    206844 ±  6%     -28.5%     147853 ±  9%  softirqs.CPU152.RCU
     23983 ±  5%     -23.5%      18358 ±  9%  softirqs.CPU152.SCHED
    205850 ±  6%     -28.4%     147337 ±  9%  softirqs.CPU153.RCU
     24407 ±  4%     -24.1%      18528 ±  8%  softirqs.CPU153.SCHED
    205499 ±  6%     -28.3%     147405 ±  9%  softirqs.CPU154.RCU
     24013 ±  8%     -20.9%      18990 ±  9%  softirqs.CPU154.SCHED
    205700 ±  6%     -28.2%     147610 ±  9%  softirqs.CPU155.RCU
     23743 ±  3%     -18.4%      19368 ±  8%  softirqs.CPU155.SCHED
    207376 ±  6%     -28.1%     149119 ±  9%  softirqs.CPU156.RCU
     24700 ±  3%     -23.5%      18889 ±  9%  softirqs.CPU156.SCHED
    207621 ±  6%     -28.5%     148425 ±  9%  softirqs.CPU157.RCU
     24326 ±  6%     -21.3%      19154 ± 12%  softirqs.CPU157.SCHED
    206327 ±  6%     -28.2%     148212 ±  9%  softirqs.CPU158.RCU
     23142 ±  8%     -16.4%      19341 ± 11%  softirqs.CPU158.SCHED
    205910 ±  6%     -28.5%     147251 ±  9%  softirqs.CPU159.RCU
     22984 ±  4%     -16.4%      19217 ±  7%  softirqs.CPU159.SCHED
    210167 ±  6%     -28.1%     151069 ±  9%  softirqs.CPU16.RCU
     16472 ±  3%     -23.2%      12658 ± 10%  softirqs.CPU16.SCHED
    216218 ±  6%     -29.0%     153586 ±  9%  softirqs.CPU160.RCU
     24504 ±  7%     -21.6%      19220 ±  6%  softirqs.CPU160.SCHED
    216579 ±  6%     -28.9%     154091 ±  9%  softirqs.CPU161.RCU
     24635 ±  4%     -26.6%      18091 ±  7%  softirqs.CPU161.SCHED
    216831 ±  6%     -28.7%     154593 ±  9%  softirqs.CPU162.RCU
     24022 ±  5%     -23.3%      18418 ± 11%  softirqs.CPU162.SCHED
    217526 ±  6%     -28.7%     155182 ±  9%  softirqs.CPU163.RCU
     24587 ±  4%     -23.8%      18726 ± 11%  softirqs.CPU163.SCHED
    216490 ±  6%     -28.7%     154426 ±  9%  softirqs.CPU164.RCU
     22371 ±  5%     -19.7%      17971 ± 11%  softirqs.CPU164.SCHED
    216040 ±  6%     -28.8%     153740 ±  9%  softirqs.CPU165.RCU
     24296 ±  7%     -23.9%      18477 ±  9%  softirqs.CPU165.SCHED
    216407 ±  6%     -28.8%     154003 ±  9%  softirqs.CPU166.RCU
     23290 ±  4%     -23.5%      17808 ± 10%  softirqs.CPU166.SCHED
    216708 ±  6%     -29.0%     153826 ±  9%  softirqs.CPU167.RCU
     23006 ±  6%     -23.1%      17685 ± 11%  softirqs.CPU167.SCHED
    206126 ±  6%     -28.2%     148036 ± 10%  softirqs.CPU168.RCU
     23048 ± 12%     -27.3%      16762 ±  3%  softirqs.CPU168.SCHED
    206232 ±  6%     -28.8%     146881 ±  9%  softirqs.CPU169.RCU
     22923 ±  8%     -17.2%      18971 ±  7%  softirqs.CPU169.SCHED
    209777 ±  6%     -27.7%     151673 ±  9%  softirqs.CPU17.RCU
    205532 ±  6%     -28.7%     146562 ±  9%  softirqs.CPU170.RCU
     24167 ±  9%     -23.1%      18573 ± 12%  softirqs.CPU170.SCHED
    205693 ±  6%     -28.9%     146334 ±  9%  softirqs.CPU171.RCU
     23912 ± 15%     -24.1%      18158 ±  7%  softirqs.CPU171.SCHED
    205799 ±  6%     -28.8%     146575 ±  9%  softirqs.CPU172.RCU
     23413 ±  9%     -23.0%      18026 ± 10%  softirqs.CPU172.SCHED
    206142 ±  6%     -28.8%     146788 ±  9%  softirqs.CPU173.RCU
     23375 ±  9%     -21.0%      18472 ±  4%  softirqs.CPU173.SCHED
    206185 ±  6%     -28.8%     146701 ±  9%  softirqs.CPU174.RCU
     24200 ± 11%     -23.0%      18639 ±  6%  softirqs.CPU174.SCHED
    205957 ±  6%     -28.6%     147038 ±  9%  softirqs.CPU175.RCU
     24269 ±  8%     -24.5%      18330 ± 10%  softirqs.CPU175.SCHED
    202506 ±  6%     -28.5%     144871 ±  9%  softirqs.CPU176.RCU
     23579 ±  7%     -19.4%      19008 ±  8%  softirqs.CPU176.SCHED
    203330 ±  6%     -28.1%     146103 ±  9%  softirqs.CPU177.RCU
     23615 ±  9%     -20.8%      18712 ±  7%  softirqs.CPU177.SCHED
    204672 ±  6%     -28.0%     147343 ±  9%  softirqs.CPU178.RCU
     23916 ±  9%     -22.9%      18429 ±  7%  softirqs.CPU178.SCHED
    204454 ±  6%     -28.3%     146649 ±  9%  softirqs.CPU179.RCU
     23892 ± 11%     -19.0%      19352 ± 10%  softirqs.CPU179.SCHED
    208829 ±  6%     -28.1%     150229 ±  9%  softirqs.CPU18.RCU
     16298 ±  2%     -20.9%      12891 ± 14%  softirqs.CPU18.SCHED
    203207 ±  6%     -28.4%     145583 ±  9%  softirqs.CPU180.RCU
     24035 ± 10%     -20.6%      19074 ± 10%  softirqs.CPU180.SCHED
    202998 ±  6%     -28.6%     144903 ±  9%  softirqs.CPU181.RCU
    202865 ±  6%     -28.3%     145452 ±  9%  softirqs.CPU182.RCU
    204074 ±  6%     -28.3%     146359 ±  9%  softirqs.CPU183.RCU
     24052 ±  9%     -21.9%      18788 ±  8%  softirqs.CPU183.SCHED
    204385 ±  6%     -28.7%     145695 ±  9%  softirqs.CPU184.RCU
     24065 ±  6%     -21.3%      18951 ± 10%  softirqs.CPU184.SCHED
    204303 ±  6%     -28.3%     146551 ±  9%  softirqs.CPU185.RCU
     24618 ±  9%     -21.5%      19320 ±  7%  softirqs.CPU185.SCHED
    202553 ±  6%     -28.4%     144931 ±  9%  softirqs.CPU186.RCU
     22909 ±  8%     -21.0%      18106 ± 12%  softirqs.CPU186.SCHED
    203676 ±  6%     -28.4%     145832 ±  9%  softirqs.CPU187.RCU
     24933 ± 15%     -26.2%      18407 ± 14%  softirqs.CPU187.SCHED
    202625 ±  6%     -28.3%     145229 ±  9%  softirqs.CPU188.RCU
     24220 ± 11%     -24.2%      18369 ±  7%  softirqs.CPU188.SCHED
    203753 ±  6%     -28.5%     145671 ±  9%  softirqs.CPU189.RCU
     23515 ± 13%     -18.8%      19083 ±  8%  softirqs.CPU189.SCHED
    210120 ±  6%     -27.4%     152454 ±  9%  softirqs.CPU19.RCU
     16227 ±  2%     -21.1%      12804 ± 13%  softirqs.CPU19.SCHED
    203955 ±  6%     -28.1%     146583 ±  9%  softirqs.CPU190.RCU
     23566 ±  7%     -17.8%      19369 ±  7%  softirqs.CPU190.SCHED
    203773 ±  6%     -28.8%     145160 ±  9%  softirqs.CPU191.RCU
     24056 ±  8%     -21.6%      18849 ±  6%  softirqs.CPU191.SCHED
    198967 ±  6%     -28.1%     143092 ± 10%  softirqs.CPU2.RCU
     17293 ±  4%     -19.6%      13907 ± 11%  softirqs.CPU2.SCHED
    209889 ±  6%     -27.6%     151960 ±  9%  softirqs.CPU20.RCU
    209219 ±  6%     -27.8%     151011 ±  9%  softirqs.CPU21.RCU
    209780 ±  6%     -28.1%     150848 ±  9%  softirqs.CPU22.RCU
    209554 ±  6%     -30.1%     146396 ±  3%  softirqs.CPU23.RCU
    217072 ±  5%     -29.1%     153886 ±  9%  softirqs.CPU24.RCU
     21938 ±  6%     -24.2%      16630 ± 16%  softirqs.CPU24.SCHED
    218118 ±  6%     -29.5%     153831 ±  9%  softirqs.CPU25.RCU
     23877 ± 11%     -29.0%      16943 ± 20%  softirqs.CPU25.SCHED
    216947 ±  6%     -29.1%     153895 ±  9%  softirqs.CPU26.RCU
     23484 ±  7%     -26.3%      17304 ± 15%  softirqs.CPU26.SCHED
    216514 ±  6%     -29.5%     152609 ±  9%  softirqs.CPU27.RCU
     23146 ±  7%     -26.9%      16915 ± 16%  softirqs.CPU27.SCHED
    215799 ±  5%     -29.3%     152597 ±  9%  softirqs.CPU28.RCU
     23394 ± 10%     -25.4%      17451 ± 17%  softirqs.CPU28.SCHED
    215717 ±  6%     -29.0%     153205 ±  9%  softirqs.CPU29.RCU
     23278 ±  8%     -24.8%      17496 ± 17%  softirqs.CPU29.SCHED
    202354 ±  6%     -29.4%     142794 ± 11%  softirqs.CPU3.RCU
     16384 ±  4%     -20.7%      12989 ± 11%  softirqs.CPU3.SCHED
    215070 ±  6%     -29.2%     152337 ±  9%  softirqs.CPU30.RCU
    217099 ±  6%     -29.1%     153870 ±  9%  softirqs.CPU31.RCU
     23577 ± 12%     -27.8%      17019 ± 16%  softirqs.CPU31.SCHED
    208449 ±  6%     -28.9%     148126 ± 10%  softirqs.CPU32.RCU
     22628 ± 13%     -22.5%      17545 ± 16%  softirqs.CPU32.SCHED
    208025 ±  6%     -29.1%     147574 ±  9%  softirqs.CPU33.RCU
     23533 ± 13%     -27.6%      17042 ± 16%  softirqs.CPU33.SCHED
    208432 ±  6%     -29.0%     148018 ± 10%  softirqs.CPU34.RCU
     23026 ±  5%     -27.3%      16737 ± 14%  softirqs.CPU34.SCHED
    207774 ±  6%     -28.9%     147669 ±  9%  softirqs.CPU35.RCU
     24112 ± 13%     -25.3%      18016 ± 20%  softirqs.CPU35.SCHED
    208130 ±  6%     -29.2%     147338 ±  9%  softirqs.CPU36.RCU
     22962 ±  7%     -25.1%      17190 ± 17%  softirqs.CPU36.SCHED
    209296 ±  6%     -29.1%     148353 ±  9%  softirqs.CPU37.RCU
     23993 ±  8%     -26.0%      17746 ± 16%  softirqs.CPU37.SCHED
    208823 ±  6%     -28.5%     149327 ± 10%  softirqs.CPU38.RCU
     23357 ± 10%     -22.0%      18228 ± 17%  softirqs.CPU38.SCHED
    209460 ±  6%     -30.2%     146293 ± 11%  softirqs.CPU39.RCU
    202232 ±  6%     -28.6%     144389 ± 10%  softirqs.CPU4.RCU
    208879 ±  6%     -29.1%     148189 ± 10%  softirqs.CPU40.RCU
     23097 ±  7%     -26.4%      16990 ± 14%  softirqs.CPU40.SCHED
    209006 ±  6%     -29.3%     147795 ±  9%  softirqs.CPU41.RCU
     23867 ±  9%     -28.3%      17118 ± 18%  softirqs.CPU41.SCHED
    207817 ±  6%     -29.2%     147220 ± 10%  softirqs.CPU42.RCU
     23410 ±  8%     -27.4%      16998 ± 16%  softirqs.CPU42.SCHED
    209588 ±  6%     -29.0%     148790 ± 10%  softirqs.CPU43.RCU
     24198 ± 13%     -24.5%      18280 ± 19%  softirqs.CPU43.SCHED
    207943 ±  6%     -28.8%     148055 ± 10%  softirqs.CPU44.RCU
     23126 ±  8%     -26.4%      17012 ± 14%  softirqs.CPU44.SCHED
    207889 ±  6%     -28.8%     147933 ± 10%  softirqs.CPU45.RCU
     23334 ±  9%     -25.5%      17380 ± 16%  softirqs.CPU45.SCHED
    207374 ±  6%     -29.0%     147309 ± 10%  softirqs.CPU46.RCU
     23398 ±  8%     -27.2%      17039 ± 16%  softirqs.CPU46.SCHED
    206686 ±  6%     -29.1%     146562 ± 10%  softirqs.CPU47.RCU
     23642 ±  8%     -25.4%      17628 ± 18%  softirqs.CPU47.SCHED
    206436 ±  6%     -28.6%     147323 ±  9%  softirqs.CPU48.RCU
     22261 ±  7%     -23.3%      17082 ±  8%  softirqs.CPU48.SCHED
    206917 ±  6%     -28.7%     147434 ±  9%  softirqs.CPU49.RCU
     22614 ±  2%     -18.9%      18331 ± 10%  softirqs.CPU49.SCHED
    202825 ±  7%     -29.3%     143367 ± 10%  softirqs.CPU5.RCU
     16444 ±  2%     -22.7%      12711 ± 11%  softirqs.CPU5.SCHED
    205598 ±  6%     -28.4%     147197 ±  9%  softirqs.CPU50.RCU
     23126 ±  3%     -20.3%      18430 ± 12%  softirqs.CPU50.SCHED
    205405 ±  6%     -28.5%     146785 ±  9%  softirqs.CPU51.RCU
     23817 ±  5%     -22.0%      18577 ±  7%  softirqs.CPU51.SCHED
    204054 ±  6%     -28.2%     146499 ±  9%  softirqs.CPU52.RCU
     23330 ±  3%     -21.4%      18343 ±  8%  softirqs.CPU52.SCHED
    206074 ±  6%     -28.2%     147912 ±  9%  softirqs.CPU53.RCU
     24062 ±  4%     -25.7%      17875 ±  6%  softirqs.CPU53.SCHED
    205523 ±  6%     -28.5%     146965 ±  9%  softirqs.CPU54.RCU
     23084 ±  8%     -20.1%      18443 ± 10%  softirqs.CPU54.SCHED
    206208 ±  6%     -28.7%     147108 ±  9%  softirqs.CPU55.RCU
     24389 ±  7%     -28.9%      17342 ± 10%  softirqs.CPU55.SCHED
    205438 ±  6%     -28.3%     147389 ±  9%  softirqs.CPU56.RCU
     23920 ±  4%     -23.5%      18287 ± 10%  softirqs.CPU56.SCHED
    205279 ±  6%     -28.5%     146806 ±  9%  softirqs.CPU57.RCU
     23767 ±  4%     -22.0%      18536 ± 10%  softirqs.CPU57.SCHED
    206739 ±  6%     -28.4%     148086 ±  9%  softirqs.CPU58.RCU
     23688 ± 10%     -20.3%      18881 ±  8%  softirqs.CPU58.SCHED
    205733 ±  6%     -28.3%     147452 ±  9%  softirqs.CPU59.RCU
     23463 ±  7%     -18.0%      19250 ±  9%  softirqs.CPU59.SCHED
    201813 ±  6%     -28.1%     145159 ± 10%  softirqs.CPU6.RCU
    206398 ±  6%     -28.5%     147496 ±  9%  softirqs.CPU60.RCU
     23978 ±  4%     -20.7%      19014 ±  8%  softirqs.CPU60.SCHED
    206583 ±  6%     -28.3%     148071 ±  9%  softirqs.CPU61.RCU
     23640 ±  7%     -16.0%      19853 ±  9%  softirqs.CPU61.SCHED
    205225 ±  6%     -28.2%     147391 ±  9%  softirqs.CPU62.RCU
     22642 ±  8%     -16.4%      18938 ±  8%  softirqs.CPU62.SCHED
    205633 ±  6%     -28.3%     147520 ±  9%  softirqs.CPU63.RCU
     23103 ±  4%     -17.6%      19045 ±  5%  softirqs.CPU63.SCHED
    214687 ±  6%     -28.6%     153332 ±  9%  softirqs.CPU64.RCU
     23454 ±  8%     -18.5%      19116 ±  5%  softirqs.CPU64.SCHED
    215835 ±  6%     -28.9%     153451 ±  8%  softirqs.CPU65.RCU
     24143 ±  7%     -25.8%      17908 ±  9%  softirqs.CPU65.SCHED
    215972 ±  6%     -28.9%     153606 ±  9%  softirqs.CPU66.RCU
     23860 ±  6%     -23.2%      18336 ±  9%  softirqs.CPU66.SCHED
    215406 ±  6%     -28.5%     154006 ±  9%  softirqs.CPU67.RCU
     22980 ±  3%     -19.1%      18589 ±  9%  softirqs.CPU67.SCHED
    214782 ±  6%     -28.8%     152916 ±  9%  softirqs.CPU68.RCU
     23292 ±  4%     -21.2%      18361 ± 12%  softirqs.CPU68.SCHED
    214593 ±  6%     -28.7%     152948 ±  9%  softirqs.CPU69.RCU
     23892 ±  5%     -22.9%      18425 ± 11%  softirqs.CPU69.SCHED
    201838 ±  6%     -28.5%     144292 ± 10%  softirqs.CPU7.RCU
    215956 ±  6%     -28.4%     154696 ±  9%  softirqs.CPU70.RCU
     23312 ±  8%     -22.7%      18026 ±  9%  softirqs.CPU70.SCHED
    215406 ±  6%     -28.7%     153489 ±  9%  softirqs.CPU71.RCU
     22148 ±  2%     -20.3%      17645 ± 10%  softirqs.CPU71.SCHED
    203716 ±  6%     -28.6%     145467 ±  9%  softirqs.CPU72.RCU
     21959 ±  9%     -23.2%      16861 ±  5%  softirqs.CPU72.SCHED
    203812 ±  6%     -28.3%     146175 ±  9%  softirqs.CPU73.RCU
    203810 ±  6%     -28.6%     145609 ±  9%  softirqs.CPU74.RCU
     23846 ± 10%     -22.9%      18395 ±  9%  softirqs.CPU74.SCHED
    203782 ±  6%     -28.6%     145431 ±  9%  softirqs.CPU75.RCU
     24210 ± 13%     -25.4%      18054 ±  5%  softirqs.CPU75.SCHED
    204045 ±  6%     -28.6%     145695 ±  9%  softirqs.CPU76.RCU
     24107 ±  4%     -24.1%      18309 ±  8%  softirqs.CPU76.SCHED
    204587 ±  6%     -28.6%     145982 ±  9%  softirqs.CPU77.RCU
     23196 ± 11%     -20.8%      18363 ±  6%  softirqs.CPU77.SCHED
    203973 ±  6%     -28.3%     146159 ±  9%  softirqs.CPU78.RCU
     23708 ±  8%     -22.7%      18333 ±  8%  softirqs.CPU78.SCHED
    204523 ±  6%     -28.9%     145363 ±  9%  softirqs.CPU79.RCU
     23358 ±  7%     -19.6%      18773 ±  8%  softirqs.CPU79.SCHED
    201301 ±  6%     -28.4%     144045 ± 10%  softirqs.CPU8.RCU
     16536 ±  2%     -25.0%      12401 ±  7%  softirqs.CPU8.SCHED
    202735 ±  6%     -28.4%     145162 ±  9%  softirqs.CPU80.RCU
     24125 ±  9%     -22.4%      18713 ±  7%  softirqs.CPU80.SCHED
    202638 ±  6%     -28.0%     145932 ±  9%  softirqs.CPU81.RCU
     23794 ± 11%     -23.9%      18098 ±  6%  softirqs.CPU81.SCHED
    204200 ±  6%     -28.2%     146676 ±  9%  softirqs.CPU82.RCU
     23274 ±  7%     -22.0%      18151 ±  9%  softirqs.CPU82.SCHED
    204940 ±  6%     -28.2%     147106 ±  9%  softirqs.CPU83.RCU
    202867 ±  6%     -27.9%     146170 ±  9%  softirqs.CPU84.RCU
     23219 ±  9%     -21.2%      18286 ±  6%  softirqs.CPU84.SCHED
    202233 ±  6%     -28.1%     145390 ±  9%  softirqs.CPU85.RCU
    202773 ±  6%     -28.2%     145568 ±  9%  softirqs.CPU86.RCU
     24198 ±  8%     -20.0%      19347 ±  7%  softirqs.CPU86.SCHED
    203138 ±  6%     -28.1%     145995 ±  9%  softirqs.CPU87.RCU
     24121 ± 10%     -22.9%      18590 ± 10%  softirqs.CPU87.SCHED
    204056 ±  6%     -28.3%     146306 ±  9%  softirqs.CPU88.RCU
     23484 ±  8%     -21.7%      18399 ±  9%  softirqs.CPU88.SCHED
    204461 ±  6%     -28.0%     147236 ±  9%  softirqs.CPU89.RCU
     23871 ± 10%     -20.9%      18892 ±  4%  softirqs.CPU89.SCHED
    199606 ±  6%     -28.1%     143488 ± 10%  softirqs.CPU9.RCU
    201165 ±  6%     -28.1%     144674 ±  9%  softirqs.CPU90.RCU
     23158 ±  9%     -20.5%      18403 ±  5%  softirqs.CPU90.SCHED
    203664 ±  6%     -28.3%     146065 ±  9%  softirqs.CPU91.RCU
     23715 ± 12%     -25.6%      17637 ±  8%  softirqs.CPU91.SCHED
    203117 ±  6%     -28.0%     146167 ±  9%  softirqs.CPU92.RCU
     24175 ± 10%     -22.6%      18704 ±  8%  softirqs.CPU92.SCHED
    202988 ±  6%     -27.9%     146298 ±  9%  softirqs.CPU93.RCU
     23486 ±  8%     -19.8%      18840 ±  7%  softirqs.CPU93.SCHED
    204067 ±  6%     -27.9%     147224 ±  9%  softirqs.CPU94.RCU
    203850 ±  6%     -28.1%     146595 ±  9%  softirqs.CPU95.RCU
     24015 ±  8%     -23.7%      18317 ± 11%  softirqs.CPU95.SCHED
    199699 ±  8%     -28.2%     143289 ±  9%  softirqs.CPU96.RCU
    197219 ± 11%     -28.1%     141731 ± 13%  softirqs.CPU97.RCU
     16779 ±  3%     -23.8%      12785 ± 13%  softirqs.CPU97.SCHED
    201869 ±  6%     -28.8%     143794 ±  9%  softirqs.CPU98.RCU
     16393 ±  3%     -21.2%      12917 ± 12%  softirqs.CPU98.SCHED
    201718 ±  7%     -30.3%     140575 ± 12%  softirqs.CPU99.RCU
  39732848 ±  6%     -28.5%   28390119 ±  9%  softirqs.RCU
   4184661 ±  4%     -22.6%    3239867 ±  6%  softirqs.SCHED
    253050 ±  6%     -31.0%     174587 ±  9%  softirqs.TIMER


                                                                                
                                hackbench.throughput                            
                                                                                
  140000 +------------------------------------------------------------------+   
         |                                                   O   O          |   
  120000 |OOO    OO   OO O    O  OO  O          O OOOOOO OOOO OOO           |   
         |   O O    OO     OO  O   O  O     O  O                            |   
  100000 |-+  O    O    O       O                                           |   
         |                                 O                      OOO OOO   |   
   80000 |-+                                                                |   
         |  +     +      +      +                     +      +    +    +  + |   
   60000 |++ +++.+ ++++++ +++.++ ++                +++ +.++++ ++++ ++.+ ++ +|   
         |                         +  +  +.+   ++ +                         |   
   40000 |-+                       :  :  : :   :: :                         |   
         |                         :  :  : :   :: :                         |   
   20000 |-+                        :: ::   : :  :                          |   
         |                          :: ::   : :  :                          |   
       0 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             hackbench.time.system_time                         
                                                                                
  350000 +------------------------------------------------------------------+   
         |                         +  +  +.+    +                           |   
  300000 |++  + .+ + ++++  ++.++  +:  :  : :   +: ++++  .++++  +++   .+ +  +|   
         |  ++ +  + +    ++     ++ :  :  : :   :: :   ++     ++   +++  + ++ |   
  250000 |-+                       :  :  : :   :: :                         |   
         |                         :  :  : :   :: :                         |   
  200000 |-+                       :  :  : :   :: :                OO O     |   
         |              O       O  :  :  : :   :: :               O    OO   |   
  150000 |OOOOOO OOOOOOO O OO OO OOO::O::  O:  :O::  O   OOOO O             |   
         |                          :: ::   : :  : OO OO     O OOO          |   
  100000 |-+                        :: ::   : :  :                          |   
         |                          :: ::   : :  :                          |   
   50000 |-+                        :: ::   : :  :                          |   
         |                          :: ::   : :  :                          |   
       0 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            hackbench.time.elapsed_time                         
                                                                                
  2000 +--------------------------------------------------------------------+   
  1800 |-+                                    +  +                          |   
       |+        +  ++.    ++     +  +  +.+   :+ :+.+    ++                 |   
  1600 |-++ .+++ ::+   ++ +  ++ .+:  :  : :   :: :   ++ +  ++. +++   ++.++ +|   
  1400 |-+ +    + +      +     +  :  :  : :   :: :     +      +   +++     + |   
       |                          :  :  : :   :: :                          |   
  1200 |-+                        :  :  : :   :: :                  O       |   
  1000 |-+   O                O   :  :  : :   :: :                OO OO O   |   
   800 |OOOO  OOOOOOO  O  OOOO O  O: :: :  : :OO:        O                  |   
       |             O  O        O :: ::   : :  :OO OOOOO OOO OOOO          |   
   600 |-+                         :: ::   : :  :                           |   
   400 |-+                         :: ::   : :  :                           |   
       |                           :: ::   : :  :                           |   
   200 |-+                         :: ::   : :  :                           |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                          hackbench.time.elapsed_time.max                       
                                                                                
  2000 +--------------------------------------------------------------------+   
  1800 |-+                                    +  +                          |   
       |+        +  ++.    ++     +  +  +.+   :+ :+.+    ++                 |   
  1600 |-++ .+++ ::+   ++ +  ++ .+:  :  : :   :: :   ++ +  ++. +++   ++.++ +|   
  1400 |-+ +    + +      +     +  :  :  : :   :: :     +      +   +++     + |   
       |                          :  :  : :   :: :                          |   
  1200 |-+                        :  :  : :   :: :                  O       |   
  1000 |-+   O                O   :  :  : :   :: :                OO OO O   |   
   800 |OOOO  OOOOOOO  O  OOOO O  O: :: :  : :OO:        O                  |   
       |             O  O        O :: ::   : :  :OO OOOOO OOO OOOO          |   
   600 |-+                         :: ::   : :  :                           |   
   400 |-+                         :: ::   : :  :                           |   
       |                           :: ::   : :  :                           |   
   200 |-+                         :: ::   : :  :                           |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2sp4: 96 threads 2 sockets Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase/ucode:
  gcc-9/performance/socket/8/x86_64-rhel-8.3/process/1600%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp4/hackbench/0x4003006

commit: 
  fdbcb2a6d6 ("mm/memcg: move mod_objcg_state() to memcontrol.c")
  68ac5b3c8d ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")

fdbcb2a6d6778e0b 68ac5b3c8db2fda00af594eca41 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          0:6           -8%           0:6     perf-profile.children.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
     66846 ±  2%     +32.7%      88731 ±  2%  hackbench.throughput
      1616 ±  2%     -25.9%       1198 ±  2%  hackbench.time.elapsed_time
      1616 ±  2%     -25.9%       1198 ±  2%  hackbench.time.elapsed_time.max
 1.933e+09 ± 21%     -84.4%  3.018e+08 ± 19%  hackbench.time.involuntary_context_switches
      8906            -2.1%       8720        hackbench.time.percent_of_cpu_this_job_got
    141381 ±  2%     -27.1%     103040 ±  2%  hackbench.time.system_time
      2576 ± 17%     -43.9%       1444 ±  3%  hackbench.time.user_time
 2.635e+09 ± 18%     -73.6%   6.95e+08 ±  9%  hackbench.time.voluntary_context_switches
   2989130 ± 64%     -67.4%     975670 ±111%  cpuidle.POLL.usage
   5035530 ± 62%     -61.2%    1951377 ± 45%  numa-meminfo.node1.MemUsed
      1653 ±  2%     -25.3%       1235 ±  2%  uptime.boot
   5919793 ± 65%     -55.4%    2642061 ±  7%  numa-vmstat.node1.numa_hit
   5855661 ± 66%     -55.6%    2597226 ±  7%  numa-vmstat.node1.numa_local
     12579 ± 13%     -46.9%       6676 ±  3%  vmstat.procs.r
   2882862 ± 21%     -69.6%     876931 ± 10%  vmstat.system.cs
      7.30 ±  3%      +2.3        9.59        mpstat.cpu.all.idle%
      0.89 ±  3%      -0.1        0.81        mpstat.cpu.all.irq%
      0.02 ±  2%      +0.0        0.03 ±  3%  mpstat.cpu.all.soft%
      1.62 ± 18%      -0.4        1.25        mpstat.cpu.all.usr%
    209656            -4.6%     200066 ±  3%  proc-vmstat.nr_active_anon
    816698            +2.6%     838072        proc-vmstat.nr_kernel_stack
    215126            -4.3%     205815 ±  3%  proc-vmstat.nr_shmem
    679175 ±  2%      +4.9%     712630        proc-vmstat.nr_slab_unreclaimable
    209656            -4.6%     200066 ±  3%  proc-vmstat.nr_zone_active_anon
    270489 ±  5%     +12.9%     305469 ±  3%  slabinfo.kmalloc-512.active_objs
    183677 ±  7%     +16.4%     213837 ±  4%  slabinfo.skbuff_head_cache.active_objs
     17316 ± 11%     +17.0%      20252 ±  4%  slabinfo.skbuff_head_cache.active_slabs
    554151 ± 11%     +17.0%     648092 ±  4%  slabinfo.skbuff_head_cache.num_objs
     17316 ± 11%     +17.0%      20252 ±  4%  slabinfo.skbuff_head_cache.num_slabs
      0.23 ±  9%      +0.1        0.31 ±  4%  turbostat.C1%
      4.63 ± 18%      +2.3        6.96 ± 15%  turbostat.C1E%
      5.99 ±  5%     +35.3%       8.10 ±  3%  turbostat.CPU%c1
 4.141e+08 ± 17%     -42.8%  2.368e+08 ± 15%  turbostat.IRQ
     33.06 ±100%    +115.6%      71.28        turbostat.RAMWatt
     11.17 ±  3%     -18.6%       9.09 ±  2%  perf-stat.i.MPKI
 9.476e+09 ± 11%     -25.5%  7.058e+09 ±  2%  perf-stat.i.branch-instructions
      0.81 ±  3%      -0.2        0.60 ±  3%  perf-stat.i.branch-miss-rate%
  79936790 ± 14%     -46.6%   42700294 ±  2%  perf-stat.i.branch-misses
     30.13 ±  5%      +9.5       39.61        perf-stat.i.cache-miss-rate%
 4.864e+08 ± 10%     -36.9%  3.069e+08 ±  3%  perf-stat.i.cache-references
   2395540 ± 22%     -67.0%     790961 ±  7%  perf-stat.i.context-switches
 2.355e+11           -10.7%  2.103e+11        perf-stat.i.cpu-cycles
      2082 ±  2%      +5.2%       2191 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.23 ± 30%      -0.1        0.12 ± 29%  perf-stat.i.dTLB-load-miss-rate%
  35585799 ± 40%     -58.5%   14773839 ± 35%  perf-stat.i.dTLB-load-misses
 1.258e+10 ± 10%     -23.8%  9.593e+09 ±  2%  perf-stat.i.dTLB-loads
 6.796e+09 ± 11%     -26.1%  5.023e+09 ±  2%  perf-stat.i.dTLB-stores
  47077684 ± 13%     -51.5%   22838344 ±  3%  perf-stat.i.iTLB-load-misses
  19003694 ± 22%     -67.3%    6214874 ±  5%  perf-stat.i.iTLB-loads
 4.606e+10 ± 10%     -25.3%  3.441e+10 ±  2%  perf-stat.i.instructions
      2554 ±  8%     +35.3%       3456 ±  3%  perf-stat.i.instructions-per-iTLB-miss
    503.38 ±  7%     +64.2%     826.53 ± 11%  perf-stat.i.major-faults
      2.44           -11.8%       2.15        perf-stat.i.metric.GHz
      1067 ±  8%     -12.7%     932.12 ±  2%  perf-stat.i.metric.K/sec
    307.12 ± 10%     -26.3%     226.32 ±  2%  perf-stat.i.metric.M/sec
     33337 ±  4%     +35.2%      45074 ±  2%  perf-stat.i.minor-faults
     55.51 ±  5%      -9.1       46.40 ±  3%  perf-stat.i.node-load-miss-rate%
  26572946 ± 12%     -35.7%   17095614 ±  2%  perf-stat.i.node-load-misses
  20452087 ±  3%     +23.4%   25241388 ±  4%  perf-stat.i.node-loads
  17722287 ±  3%     +45.5%   25780743 ±  3%  perf-stat.i.node-stores
     33840 ±  4%     +35.6%      45900 ±  2%  perf-stat.i.page-faults
     10.95 ±  3%     -18.1%       8.96 ±  2%  perf-stat.overall.MPKI
      0.88 ±  2%      -0.2        0.63        perf-stat.overall.branch-miss-rate%
     31.07 ±  9%     +20.0       51.11 ±  2%  perf-stat.overall.cache-miss-rate%
      1528 ±  2%     -20.7%       1212 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.30 ± 33%      -0.1        0.17 ± 36%  perf-stat.overall.dTLB-load-miss-rate%
     72.51 ±  3%     +12.1       84.57        perf-stat.overall.iTLB-load-miss-rate%
    907.89           +44.1%       1308        perf-stat.overall.instructions-per-iTLB-miss
     52.18 ±  4%     -19.2       32.99        perf-stat.overall.node-load-miss-rate%
     28.66 ±  7%     -10.3       18.38        perf-stat.overall.node-store-miss-rate%
  95699062 ± 11%     -36.1%   61121486 ±  2%  perf-stat.ps.branch-misses
 1.812e+08 ±  2%     +23.4%  2.236e+08 ±  3%  perf-stat.ps.cache-misses
 5.873e+08 ±  7%     -25.5%  4.376e+08 ±  3%  perf-stat.ps.cache-references
   2870044 ± 21%     -69.7%     868230 ± 10%  perf-stat.ps.context-switches
 2.769e+11            -2.2%  2.708e+11        perf-stat.ps.cpu-cycles
     41347 ± 25%     -46.6%      22081 ±  3%  perf-stat.ps.cpu-migrations
  45624790 ± 39%     -48.5%   23501280 ± 37%  perf-stat.ps.dTLB-load-misses
  59221419 ±  9%     -37.0%   37312739        perf-stat.ps.iTLB-load-misses
  22801344 ± 21%     -70.1%    6820471 ± 10%  perf-stat.ps.iTLB-loads
    164.81 ±  7%     +45.0%     238.96 ±  9%  perf-stat.ps.major-faults
     12346 ±  2%     +33.5%      16479 ±  2%  perf-stat.ps.minor-faults
  28298925 ±  7%     -30.5%   19674114 ±  2%  perf-stat.ps.node-load-misses
  25850519 ±  2%     +54.6%   39977675 ±  3%  perf-stat.ps.node-loads
  24700103 ±  4%     +84.5%   45563654 ±  2%  perf-stat.ps.node-stores
     12511 ±  2%     +33.6%      16718 ±  2%  perf-stat.ps.page-faults
  8.67e+13 ±  7%     -32.5%  5.849e+13        perf-stat.total.instructions
      0.00 ±152%  +1.9e+07%     642.60 ±104%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    136.59 ± 25%     -77.9%      30.24 ± 14%  perf-sched.sch_delay.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.01           +21.4%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.46 ±217%   +8382.5%      38.95 ± 78%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
    116306 ±  4%     -55.9%      51249 ± 10%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ±104%    +1e+08%      10700 ±146%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      1.80 ±222%  +4.9e+05%       8729 ±221%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     91893 ± 26%     -45.5%      50088 ± 11%  perf-sched.sch_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
    117071 ±  4%     -55.7%      51831 ± 10%  perf-sched.sch_delay.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     88.71 ±221%  +33947.1%      30203 ± 63%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
     85.67 ± 23%     -66.4%      28.77 ±  9%  perf-sched.total_sch_delay.average.ms
    117076 ±  4%     -55.7%      51831 ± 10%  perf-sched.total_sch_delay.max.ms
   1024233 ±  2%     -20.5%     814352 ±  4%  perf-sched.total_wait_and_delay.count.ms
    234198 ±  4%     -55.7%     103802 ± 10%  perf-sched.total_wait_and_delay.max.ms
    117346 ±  4%     -55.2%      52524 ±  9%  perf-sched.total_wait_time.max.ms
     25223 ± 44%     -71.3%       7243 ± 40%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1144 ± 10%     -62.6%     427.53 ± 25%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
    182.67 ± 21%    +424.5%     958.17 ± 53%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     32.00 ±108%    +242.7%     109.67 ± 21%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    406629 ±  4%     -49.1%     207148 ± 11%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2931 ± 19%    +107.7%       6087 ± 14%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
    217.50 ± 26%     +80.8%     393.33 ± 15%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
     64.83 ± 76%    +197.4%     192.83 ± 32%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
     21.83 ±101%    +280.2%      83.00 ± 20%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
     11787 ± 20%    +376.9%      56211 ± 18%  perf-sched.wait_and_delay.count.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
    116.67 ±  5%     +54.6%     180.33 ±  9%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
    223.67 ± 17%    +381.1%       1076 ± 47%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
    162248 ± 29%     -52.9%      76448 ± 32%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    220396 ±  6%     -54.1%     101251 ± 11%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
    123552 ± 15%     -23.4%      94618 ± 10%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
    130467 ± 34%     -60.5%      51519 ± 10%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
    165624 ± 29%     -39.9%      99599 ± 10%  perf-sched.wait_and_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
    234198 ±  4%     -55.7%     103736 ± 10%  perf-sched.wait_and_delay.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
    116481 ±  4%     -55.8%      51474 ± 11%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
    116612 ±  4%     -40.1%      69804 ± 26%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
     22554 ± 42%     -68.9%       7024 ± 40%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.06 ± 97%  +1.9e+06%       1048 ±221%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.63 ±144%  +3.3e+05%       2076 ±142%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      1.06 ±206%    +562.6%       7.01 ± 91%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.wp_page_copy
      0.84 ±204%    +1e+06%       8433 ±177%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.34 ±190%  +1.2e+06%       3939 ± 81%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
      0.05 ± 57%  +2.7e+06%       1299 ±114%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      0.26 ±223%  +7.5e+05%       1948 ±199%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1007 ±  9%     -60.6%     397.28 ± 27%  perf-sched.wait_time.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
    115581 ±  4%     -55.1%      51872 ± 10%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.27 ±165%    +3e+06%       8348 ±222%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    117266 ±  4%     -55.3%      52368 ±  9%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.07 ±141%  +4.3e+05%      17691 ±140%  perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      2.05 ±207%    +747.8%      17.36 ± 62%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.wp_page_copy
    115804 ±  4%     -54.9%      52181 ±  9%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      3.56 ±213%  +6.7e+05%      23768 ± 81%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
    107150 ± 13%     -51.9%      51516 ± 10%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      7.64 ±149%  +3.1e+05%      23760 ±101%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.down_write.unlink_anon_vmas.free_pgtables
      1.54 ±209%  +1.9e+06%      29014 ± 72%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
      0.26 ± 58%    +1e+07%      26321 ±100%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      0.52 ±223%  +1.8e+06%       9162 ±212%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    113782 ±  4%     -54.3%      52040 ± 10%  perf-sched.wait_time.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
    117327 ±  4%     -55.5%      52228 ±  9%  perf-sched.wait_time.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
    116481 ±  4%     -55.8%      51474 ± 11%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
    116541 ±  4%     -55.8%      51558 ± 10%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
    114184 ±  8%     -20.6%      90666 ± 10%  softirqs.CPU0.RCU
    114289 ±  7%     -21.0%      90265 ±  7%  softirqs.CPU1.RCU
    119909 ±  5%     -25.2%      89635 ± 14%  softirqs.CPU10.RCU
    120164 ±  5%     -23.7%      91634 ± 11%  softirqs.CPU11.RCU
    116012 ± 10%     -21.7%      90853 ± 11%  softirqs.CPU12.RCU
    119396 ±  4%     -24.3%      90341 ± 11%  softirqs.CPU13.RCU
    116589 ±  7%     -22.0%      90927 ± 11%  softirqs.CPU14.RCU
    119794 ±  5%     -24.3%      90667 ± 11%  softirqs.CPU15.RCU
    133127 ±  4%     -25.2%      99573 ± 12%  softirqs.CPU16.RCU
    133994 ±  5%     -26.9%      97966 ± 13%  softirqs.CPU17.RCU
    135938 ±  5%     -25.7%     101014 ± 12%  softirqs.CPU18.RCU
    134987 ±  4%     -25.6%     100440 ± 11%  softirqs.CPU19.RCU
    119761 ±  5%     -24.1%      90949 ± 11%  softirqs.CPU2.RCU
    135228 ±  4%     -25.6%     100584 ± 11%  softirqs.CPU20.RCU
    134220 ±  4%     -25.2%     100354 ± 11%  softirqs.CPU21.RCU
    133607 ±  5%     -25.5%      99481 ± 11%  softirqs.CPU22.RCU
    132953 ±  5%     -25.3%      99254 ± 11%  softirqs.CPU23.RCU
    125453 ±  5%     -22.5%      97263 ± 11%  softirqs.CPU24.RCU
     52187 ± 10%     -15.3%      44184 ±  3%  softirqs.CPU24.SCHED
    125561 ±  5%     -23.2%      96476 ± 12%  softirqs.CPU25.RCU
     52772 ± 10%     -16.0%      44354 ±  3%  softirqs.CPU25.SCHED
    123367 ±  5%     -21.9%      96395 ± 11%  softirqs.CPU26.RCU
     52972 ± 10%     -15.6%      44713 ±  3%  softirqs.CPU26.SCHED
    122905 ±  5%     -23.2%      94372 ± 13%  softirqs.CPU27.RCU
     53253 ± 11%     -16.5%      44456 ±  2%  softirqs.CPU27.SCHED
    123695 ±  6%     -22.4%      95926 ± 12%  softirqs.CPU28.RCU
     52960 ± 10%     -15.7%      44628 ±  3%  softirqs.CPU28.SCHED
    121430 ±  5%     -21.5%      95279 ± 12%  softirqs.CPU29.RCU
     53015 ± 10%     -15.7%      44673 ±  4%  softirqs.CPU29.SCHED
    119944 ±  4%     -24.4%      90706 ± 11%  softirqs.CPU3.RCU
    124998 ±  5%     -24.5%      94335 ± 10%  softirqs.CPU30.RCU
     53154 ± 11%     -16.3%      44481 ±  3%  softirqs.CPU30.SCHED
    125493 ±  6%     -23.3%      96239 ± 12%  softirqs.CPU31.RCU
     53027 ± 11%     -16.7%      44164 ±  3%  softirqs.CPU31.SCHED
    119025 ±  4%     -23.7%      90870 ± 12%  softirqs.CPU32.RCU
     53067 ± 11%     -16.2%      44476 ±  3%  softirqs.CPU32.SCHED
    117982 ±  5%     -23.0%      90844 ± 12%  softirqs.CPU33.RCU
     52814 ± 11%     -16.1%      44305 ±  3%  softirqs.CPU33.SCHED
    117877 ±  5%     -23.0%      90742 ± 12%  softirqs.CPU34.RCU
     53003 ± 10%     -15.8%      44647 ±  3%  softirqs.CPU34.SCHED
    118295 ±  4%     -23.2%      90796 ± 12%  softirqs.CPU35.RCU
     52789 ± 11%     -16.3%      44182 ±  3%  softirqs.CPU35.SCHED
    120083 ±  4%     -23.8%      91525 ± 12%  softirqs.CPU36.RCU
     52671 ± 10%     -16.7%      43875 ±  3%  softirqs.CPU36.SCHED
    120626 ±  4%     -24.1%      91537 ± 12%  softirqs.CPU37.RCU
     52745 ± 11%     -16.0%      44288 ±  3%  softirqs.CPU37.SCHED
    120928 ±  5%     -24.8%      90960 ± 11%  softirqs.CPU38.RCU
     53088 ± 10%     -16.5%      44341 ±  3%  softirqs.CPU38.SCHED
    118700 ±  5%     -23.7%      90620 ± 12%  softirqs.CPU39.RCU
     52680 ± 11%     -16.0%      44227 ±  4%  softirqs.CPU39.SCHED
    120774 ±  5%     -24.2%      91567 ± 10%  softirqs.CPU4.RCU
    119135 ±  5%     -24.0%      90523 ± 11%  softirqs.CPU40.RCU
     53445 ± 11%     -17.1%      44317 ±  4%  softirqs.CPU40.SCHED
    118090 ±  4%     -23.2%      90743 ± 12%  softirqs.CPU41.RCU
     53166 ± 11%     -17.2%      44045 ±  3%  softirqs.CPU41.SCHED
    120017 ±  5%     -23.5%      91862 ± 12%  softirqs.CPU42.RCU
     52816 ± 10%     -16.1%      44303 ±  3%  softirqs.CPU42.SCHED
    119579 ±  4%     -23.9%      91010 ± 12%  softirqs.CPU43.RCU
     53167 ± 10%     -16.9%      44207 ±  3%  softirqs.CPU43.SCHED
    119165 ±  5%     -23.4%      91228 ± 11%  softirqs.CPU44.RCU
     52960 ± 11%     -17.0%      43966 ±  3%  softirqs.CPU44.SCHED
    117999 ±  4%     -23.4%      90426 ± 12%  softirqs.CPU45.RCU
     53045 ± 11%     -16.4%      44338 ±  4%  softirqs.CPU45.SCHED
    118010 ±  4%     -23.2%      90685 ± 11%  softirqs.CPU46.RCU
     52727 ± 12%     -16.2%      44176 ±  3%  softirqs.CPU46.SCHED
    118424 ±  4%     -23.2%      90912 ± 12%  softirqs.CPU47.RCU
     52314 ± 11%     -16.0%      43941 ±  3%  softirqs.CPU47.SCHED
    114734 ± 12%     -20.3%      91490 ± 12%  softirqs.CPU48.RCU
    112041 ±  8%     -20.3%      89350 ±  8%  softirqs.CPU49.RCU
    120529 ±  4%     -23.5%      92261 ± 11%  softirqs.CPU5.RCU
    117409 ±  6%     -22.5%      90939 ± 11%  softirqs.CPU50.RCU
    118919 ±  6%     -23.2%      91370 ± 11%  softirqs.CPU51.RCU
    118703 ±  6%     -22.3%      92263 ± 12%  softirqs.CPU52.RCU
    118382 ±  6%     -22.6%      91577 ± 11%  softirqs.CPU53.RCU
    119135 ±  6%     -22.7%      92103 ± 11%  softirqs.CPU54.RCU
    119265 ±  6%     -23.0%      91884 ± 11%  softirqs.CPU55.RCU
    117401 ±  6%     -23.0%      90404 ± 11%  softirqs.CPU56.RCU
    119001 ±  6%     -23.0%      91686 ± 13%  softirqs.CPU57.RCU
    118121 ±  5%     -23.8%      90029 ± 14%  softirqs.CPU58.RCU
    118586 ±  6%     -22.2%      92244 ± 11%  softirqs.CPU59.RCU
    120277 ±  4%     -24.4%      90959 ± 12%  softirqs.CPU6.RCU
    115244 ± 11%     -20.1%      92044 ± 11%  softirqs.CPU60.RCU
    118905 ±  5%     -22.9%      91630 ± 11%  softirqs.CPU61.RCU
    114662 ±  8%     -20.8%      90861 ± 11%  softirqs.CPU62.RCU
    118251 ±  5%     -22.4%      91707 ± 11%  softirqs.CPU63.RCU
    134012 ±  5%     -24.9%     100669 ± 11%  softirqs.CPU64.RCU
    134233 ±  5%     -27.5%      97372 ± 14%  softirqs.CPU65.RCU
    137160 ±  4%     -25.5%     102174 ± 10%  softirqs.CPU66.RCU
    135877 ±  5%     -25.6%     101076 ± 11%  softirqs.CPU67.RCU
    134922 ±  5%     -24.9%     101268 ± 10%  softirqs.CPU68.RCU
    134720 ±  4%     -23.6%     102974 ± 12%  softirqs.CPU69.RCU
    119952 ±  4%     -23.1%      92197 ± 10%  softirqs.CPU7.RCU
    132918 ±  5%     -24.8%      99972 ± 11%  softirqs.CPU70.RCU
    132785 ±  4%     -24.6%     100098 ± 11%  softirqs.CPU71.RCU
    127056 ±  5%     -23.5%      97160 ± 11%  softirqs.CPU72.RCU
     53218 ± 10%     -15.7%      44852 ±  4%  softirqs.CPU72.SCHED
    126480 ±  6%     -23.9%      96268 ± 12%  softirqs.CPU73.RCU
     53562 ± 11%     -16.9%      44500 ±  4%  softirqs.CPU73.SCHED
    124660 ±  5%     -22.9%      96164 ± 11%  softirqs.CPU74.RCU
     53777 ± 11%     -16.5%      44879 ±  2%  softirqs.CPU74.SCHED
    124245 ±  5%     -24.1%      94295 ± 13%  softirqs.CPU75.RCU
     53874 ± 12%     -16.3%      45068 ±  3%  softirqs.CPU75.SCHED
    125293 ±  6%     -23.6%      95673 ± 11%  softirqs.CPU76.RCU
     54049 ± 11%     -17.3%      44711 ±  3%  softirqs.CPU76.SCHED
    121514 ±  4%     -21.8%      94985 ± 11%  softirqs.CPU77.RCU
     53659 ± 11%     -16.9%      44576 ±  3%  softirqs.CPU77.SCHED
    125807 ±  5%     -24.7%      94691 ±  9%  softirqs.CPU78.RCU
     53936 ± 12%     -17.1%      44693 ±  4%  softirqs.CPU78.SCHED
    126021 ±  5%     -23.6%      96298 ± 11%  softirqs.CPU79.RCU
     53883 ± 12%     -17.3%      44557 ±  3%  softirqs.CPU79.SCHED
    119710 ±  5%     -23.6%      91480 ± 11%  softirqs.CPU8.RCU
    118989 ±  5%     -23.5%      90984 ± 11%  softirqs.CPU80.RCU
     54159 ± 12%     -17.4%      44760 ±  3%  softirqs.CPU80.SCHED
    119117 ±  5%     -23.3%      91361 ± 11%  softirqs.CPU81.RCU
     53858 ± 11%     -16.8%      44802 ±  3%  softirqs.CPU81.SCHED
    119650 ±  5%     -23.3%      91808 ± 12%  softirqs.CPU82.RCU
     54282 ± 12%     -17.9%      44592 ±  3%  softirqs.CPU82.SCHED
    120091 ±  5%     -23.3%      92117 ± 12%  softirqs.CPU83.RCU
     53733 ± 11%     -16.9%      44641 ±  3%  softirqs.CPU83.SCHED
    119260 ±  4%     -23.8%      90851 ± 12%  softirqs.CPU84.RCU
     53562 ± 12%     -16.1%      44931 ±  2%  softirqs.CPU84.SCHED
    119637 ±  4%     -24.0%      90966 ± 12%  softirqs.CPU85.RCU
     54234 ± 12%     -17.7%      44625 ±  3%  softirqs.CPU85.SCHED
    119399 ±  4%     -23.5%      91375 ± 11%  softirqs.CPU86.RCU
     53875 ± 12%     -15.9%      45325 ±  5%  softirqs.CPU86.SCHED
    119617 ±  5%     -23.7%      91211 ± 12%  softirqs.CPU87.RCU
     54188 ± 11%     -17.5%      44681 ±  3%  softirqs.CPU87.SCHED
    120626 ±  5%     -23.6%      92204 ± 12%  softirqs.CPU88.RCU
     54135 ± 13%     -17.4%      44711 ±  3%  softirqs.CPU88.SCHED
    120031 ±  5%     -23.2%      92197 ± 12%  softirqs.CPU89.RCU
     54187 ± 12%     -17.6%      44624 ±  3%  softirqs.CPU89.SCHED
    120401 ±  4%     -24.1%      91370 ± 11%  softirqs.CPU9.RCU
    119423 ±  4%     -23.6%      91228 ± 12%  softirqs.CPU90.RCU
     53697 ± 11%     -17.3%      44396 ±  3%  softirqs.CPU90.SCHED
    119554 ±  4%     -23.3%      91678 ± 12%  softirqs.CPU91.RCU
     54189 ± 12%     -17.4%      44748 ±  3%  softirqs.CPU91.SCHED
    119817 ±  4%     -23.7%      91366 ± 12%  softirqs.CPU92.RCU
     54229 ± 12%     -17.4%      44793 ±  2%  softirqs.CPU92.SCHED
    119474 ±  5%     -23.3%      91670 ± 12%  softirqs.CPU93.RCU
     53702 ± 11%     -16.9%      44639 ±  3%  softirqs.CPU93.SCHED
    119441 ±  4%     -23.1%      91846 ± 11%  softirqs.CPU94.RCU
     53648 ± 12%     -16.9%      44594 ±  3%  softirqs.CPU94.SCHED
    120184 ±  3%     -24.1%      91251 ± 11%  softirqs.CPU95.RCU
     53668 ± 12%     -17.6%      44196 ±  3%  softirqs.CPU95.SCHED
  11743411 ±  5%     -23.6%    8973612 ± 11%  softirqs.RCU
   5039118 ±  3%     -11.6%    4452992        softirqs.SCHED
    180426 ±  3%     -21.1%     142298 ±  6%  softirqs.TIMER
      1579 ±  2%     -25.8%       1171 ±  2%  interrupts.293:PCI-MSI.327680-edge.xhci_hcd
  67312831 ± 28%     -85.6%    9672064 ± 11%  interrupts.CAL:Function_call_interrupts
   1000046 ± 73%     -89.1%     108653 ± 35%  interrupts.CPU0.CAL:Function_call_interrupts
    435107 ± 21%     -64.8%     153129 ± 24%  interrupts.CPU0.RES:Rescheduling_interrupts
    441799 ± 53%     -78.0%      97386 ± 12%  interrupts.CPU1.CAL:Function_call_interrupts
    476047 ± 19%     -71.2%     137010 ± 24%  interrupts.CPU1.RES:Rescheduling_interrupts
      1579 ±  2%     -25.8%       1171 ±  2%  interrupts.CPU10.293:PCI-MSI.327680-edge.xhci_hcd
    446904 ± 52%     -78.0%      98261 ± 28%  interrupts.CPU10.CAL:Function_call_interrupts
    602379 ± 27%     -75.6%     146834 ± 31%  interrupts.CPU10.RES:Rescheduling_interrupts
    564799 ± 44%     -85.2%      83384 ± 22%  interrupts.CPU11.CAL:Function_call_interrupts
    598246 ± 24%     -78.8%     126665 ± 17%  interrupts.CPU11.RES:Rescheduling_interrupts
    514319 ± 51%     -83.9%      82697 ± 10%  interrupts.CPU12.CAL:Function_call_interrupts
    459552 ± 23%     -70.0%     137653 ± 22%  interrupts.CPU12.RES:Rescheduling_interrupts
    410806 ± 43%     -77.1%      94196 ± 21%  interrupts.CPU13.CAL:Function_call_interrupts
    520277 ± 34%     -71.0%     150899 ± 13%  interrupts.CPU13.RES:Rescheduling_interrupts
    487114 ± 32%     -81.8%      88472 ± 17%  interrupts.CPU14.CAL:Function_call_interrupts
    642852 ± 20%     -79.7%     130512 ± 20%  interrupts.CPU14.RES:Rescheduling_interrupts
    583107 ± 36%     -85.6%      83840 ± 25%  interrupts.CPU15.CAL:Function_call_interrupts
    598732 ± 18%     -75.7%     145702 ± 17%  interrupts.CPU15.RES:Rescheduling_interrupts
    528273 ± 50%     -79.7%     107349 ± 18%  interrupts.CPU16.CAL:Function_call_interrupts
    787747 ± 38%     -79.4%     162249 ± 27%  interrupts.CPU16.RES:Rescheduling_interrupts
    665311 ± 34%     -85.8%      94151 ± 21%  interrupts.CPU17.CAL:Function_call_interrupts
    636120 ± 19%     -75.8%     154164 ± 14%  interrupts.CPU17.RES:Rescheduling_interrupts
    586596 ± 47%     -84.0%      93957 ± 18%  interrupts.CPU18.CAL:Function_call_interrupts
    656525 ± 39%     -76.1%     156643 ± 17%  interrupts.CPU18.RES:Rescheduling_interrupts
    513755 ± 42%     -83.9%      82705 ± 26%  interrupts.CPU19.CAL:Function_call_interrupts
    527848 ± 11%     -71.5%     150534 ± 32%  interrupts.CPU19.RES:Rescheduling_interrupts
    526368 ± 51%     -81.4%      97845 ± 10%  interrupts.CPU2.CAL:Function_call_interrupts
    592304 ± 26%     -73.9%     154321 ± 22%  interrupts.CPU2.RES:Rescheduling_interrupts
    523825 ± 49%     -81.4%      97332 ± 33%  interrupts.CPU20.CAL:Function_call_interrupts
    535373 ± 28%     -69.8%     161508 ± 26%  interrupts.CPU20.RES:Rescheduling_interrupts
    523377 ± 28%     -80.6%     101433 ± 24%  interrupts.CPU21.CAL:Function_call_interrupts
    559624 ± 30%     -73.9%     146323 ± 23%  interrupts.CPU21.RES:Rescheduling_interrupts
    635043 ± 40%     -85.9%      89347 ± 16%  interrupts.CPU22.CAL:Function_call_interrupts
    595030 ± 12%     -76.6%     139054 ± 29%  interrupts.CPU22.RES:Rescheduling_interrupts
    536335 ± 44%     -82.7%      92971 ±  8%  interrupts.CPU23.CAL:Function_call_interrupts
    620371 ± 25%     -77.4%     139904 ± 20%  interrupts.CPU23.RES:Rescheduling_interrupts
   1260708 ± 34%     -88.6%     144250 ± 38%  interrupts.CPU24.CAL:Function_call_interrupts
    361897 ± 44%     -72.3%     100327 ± 13%  interrupts.CPU24.RES:Rescheduling_interrupts
    781039 ± 59%     -86.2%     107963 ± 26%  interrupts.CPU25.CAL:Function_call_interrupts
    587739 ± 38%     -81.6%     108021 ± 24%  interrupts.CPU25.RES:Rescheduling_interrupts
    821224 ± 50%     -88.3%      95907 ± 22%  interrupts.CPU26.CAL:Function_call_interrupts
    651514 ± 39%     -81.9%     118003 ± 20%  interrupts.CPU26.RES:Rescheduling_interrupts
   1130601 ± 46%     -89.6%     117172 ± 46%  interrupts.CPU27.CAL:Function_call_interrupts
    729288 ± 39%     -82.3%     128807 ± 26%  interrupts.CPU27.RES:Rescheduling_interrupts
    855810 ± 50%     -85.8%     121530 ± 28%  interrupts.CPU28.CAL:Function_call_interrupts
    632698 ± 51%     -81.5%     116816 ± 21%  interrupts.CPU28.RES:Rescheduling_interrupts
    793580 ± 49%     -86.3%     108455 ± 30%  interrupts.CPU29.CAL:Function_call_interrupts
    643494 ± 39%     -83.1%     108795 ± 29%  interrupts.CPU29.RES:Rescheduling_interrupts
    445293 ± 37%     -79.7%      90248 ± 27%  interrupts.CPU3.CAL:Function_call_interrupts
    534975 ± 29%     -72.6%     146737 ± 19%  interrupts.CPU3.RES:Rescheduling_interrupts
    839914 ± 49%     -90.1%      82742 ± 23%  interrupts.CPU30.CAL:Function_call_interrupts
    500713 ± 40%     -79.6%     102122 ± 23%  interrupts.CPU30.RES:Rescheduling_interrupts
    757309 ± 58%     -86.5%     102592 ± 20%  interrupts.CPU31.CAL:Function_call_interrupts
    575342 ± 48%     -80.1%     114516 ± 19%  interrupts.CPU31.RES:Rescheduling_interrupts
    827692 ± 51%     -85.7%     118517 ± 32%  interrupts.CPU32.CAL:Function_call_interrupts
    624069 ± 45%     -82.0%     112286 ± 24%  interrupts.CPU32.RES:Rescheduling_interrupts
    741985 ± 55%     -86.4%     101076 ± 19%  interrupts.CPU33.CAL:Function_call_interrupts
    649128 ± 41%     -82.9%     110727 ± 19%  interrupts.CPU33.RES:Rescheduling_interrupts
   1012379 ± 38%     -90.2%      99150 ± 22%  interrupts.CPU34.CAL:Function_call_interrupts
    677784 ± 24%     -84.3%     106581 ± 21%  interrupts.CPU34.RES:Rescheduling_interrupts
    751227 ± 46%     -85.7%     107452 ± 32%  interrupts.CPU35.CAL:Function_call_interrupts
    534488 ± 42%     -77.7%     119311 ± 16%  interrupts.CPU35.RES:Rescheduling_interrupts
    749457 ± 45%     -86.6%     100264 ± 38%  interrupts.CPU36.CAL:Function_call_interrupts
    502370 ± 31%     -80.7%      96905 ± 23%  interrupts.CPU36.RES:Rescheduling_interrupts
    741542 ± 55%     -88.1%      88529 ± 15%  interrupts.CPU37.CAL:Function_call_interrupts
    554068 ± 38%     -81.2%     104428 ± 19%  interrupts.CPU37.RES:Rescheduling_interrupts
    825045 ± 51%     -87.2%     105916 ± 32%  interrupts.CPU38.CAL:Function_call_interrupts
    629181 ± 45%     -79.9%     126330 ± 36%  interrupts.CPU38.RES:Rescheduling_interrupts
    984619 ± 46%     -90.7%      91637 ± 22%  interrupts.CPU39.CAL:Function_call_interrupts
    650113 ± 33%     -79.3%     134709 ± 35%  interrupts.CPU39.RES:Rescheduling_interrupts
    488311 ± 48%     -79.8%      98424 ± 23%  interrupts.CPU4.CAL:Function_call_interrupts
    544078 ± 24%     -75.0%     135853 ±  8%  interrupts.CPU4.RES:Rescheduling_interrupts
    965807 ± 53%     -88.9%     107209 ± 23%  interrupts.CPU40.CAL:Function_call_interrupts
    660162 ± 45%     -81.7%     120858 ± 19%  interrupts.CPU40.RES:Rescheduling_interrupts
   1031514 ± 50%     -91.3%      89924 ± 22%  interrupts.CPU41.CAL:Function_call_interrupts
    644803 ± 38%     -82.0%     115873 ± 19%  interrupts.CPU41.RES:Rescheduling_interrupts
    768801 ± 48%     -86.6%     102982 ± 25%  interrupts.CPU42.CAL:Function_call_interrupts
    579411 ± 38%     -81.5%     107132 ± 15%  interrupts.CPU42.RES:Rescheduling_interrupts
    901315 ± 62%     -90.2%      88679 ± 25%  interrupts.CPU43.CAL:Function_call_interrupts
    601838 ± 45%     -81.2%     113099 ± 17%  interrupts.CPU43.RES:Rescheduling_interrupts
   1000987 ± 39%     -91.4%      85664 ± 16%  interrupts.CPU44.CAL:Function_call_interrupts
    555650 ± 49%     -78.4%     120169 ± 10%  interrupts.CPU44.RES:Rescheduling_interrupts
    974069 ± 58%     -88.5%     112212 ± 39%  interrupts.CPU45.CAL:Function_call_interrupts
    663758 ± 41%     -81.5%     122815 ± 20%  interrupts.CPU45.RES:Rescheduling_interrupts
   1012208 ± 51%     -90.5%      96126 ± 17%  interrupts.CPU46.CAL:Function_call_interrupts
    577721 ± 41%     -81.1%     109166 ± 22%  interrupts.CPU46.RES:Rescheduling_interrupts
   1030696 ± 49%     -89.6%     107235 ± 18%  interrupts.CPU47.CAL:Function_call_interrupts
    611193 ± 63%     -81.7%     112079 ± 28%  interrupts.CPU47.RES:Rescheduling_interrupts
    714260 ± 59%     -81.9%     129280 ± 33%  interrupts.CPU48.CAL:Function_call_interrupts
    405969 ± 28%     -59.6%     164096 ± 27%  interrupts.CPU48.RES:Rescheduling_interrupts
    447297 ± 76%     -80.4%      87848 ± 13%  interrupts.CPU49.CAL:Function_call_interrupts
    527389 ± 26%     -70.2%     157134 ± 32%  interrupts.CPU49.RES:Rescheduling_interrupts
    581797 ± 38%     -83.8%      94157 ±  9%  interrupts.CPU5.CAL:Function_call_interrupts
    572139 ± 21%     -76.0%     137144 ± 21%  interrupts.CPU5.RES:Rescheduling_interrupts
    491168 ± 49%     -80.3%      96730 ± 30%  interrupts.CPU50.CAL:Function_call_interrupts
    578016 ± 21%     -70.6%     169729 ± 33%  interrupts.CPU50.RES:Rescheduling_interrupts
    414679 ± 56%     -79.3%      85659 ± 17%  interrupts.CPU51.CAL:Function_call_interrupts
    561418 ± 35%     -73.1%     150936 ± 21%  interrupts.CPU51.RES:Rescheduling_interrupts
    528740 ± 40%     -83.1%      89499 ± 11%  interrupts.CPU52.CAL:Function_call_interrupts
    643967 ± 34%     -78.8%     136534 ± 13%  interrupts.CPU52.RES:Rescheduling_interrupts
    568698 ± 35%     -82.9%      97199 ± 35%  interrupts.CPU53.CAL:Function_call_interrupts
    692481 ± 22%     -80.8%     132633 ± 22%  interrupts.CPU53.RES:Rescheduling_interrupts
    430150 ± 55%     -77.9%      95165 ± 19%  interrupts.CPU54.CAL:Function_call_interrupts
    404094 ± 32%     -64.3%     144257 ± 24%  interrupts.CPU54.RES:Rescheduling_interrupts
    360051 ± 52%     -76.1%      86110 ± 23%  interrupts.CPU55.CAL:Function_call_interrupts
    366324 ± 37%     -54.8%     165553 ± 39%  interrupts.CPU55.RES:Rescheduling_interrupts
    446431 ± 52%     -80.1%      88875 ± 11%  interrupts.CPU56.CAL:Function_call_interrupts
    476211 ± 32%     -68.0%     152559 ± 29%  interrupts.CPU56.RES:Rescheduling_interrupts
    421204 ± 46%     -75.1%     104697 ± 24%  interrupts.CPU57.CAL:Function_call_interrupts
    489921 ± 24%     -63.9%     177068 ± 55%  interrupts.CPU57.RES:Rescheduling_interrupts
    482474 ± 69%     -80.7%      93088 ± 27%  interrupts.CPU58.CAL:Function_call_interrupts
    623436 ± 26%     -78.0%     136961 ± 30%  interrupts.CPU58.RES:Rescheduling_interrupts
    579962 ± 54%     -84.6%      89163 ± 25%  interrupts.CPU59.CAL:Function_call_interrupts
    681328 ± 31%     -79.8%     137811 ± 16%  interrupts.CPU59.RES:Rescheduling_interrupts
    483707 ± 51%     -80.2%      95706 ± 21%  interrupts.CPU6.CAL:Function_call_interrupts
    459200 ± 28%     -69.3%     140942 ± 23%  interrupts.CPU6.RES:Rescheduling_interrupts
    470781 ± 47%     -80.2%      93374 ± 20%  interrupts.CPU60.CAL:Function_call_interrupts
    469003 ± 36%     -69.2%     144391 ± 29%  interrupts.CPU60.RES:Rescheduling_interrupts
    461804 ± 56%     -76.1%     110191 ± 24%  interrupts.CPU61.CAL:Function_call_interrupts
    520967 ± 29%     -68.9%     161787 ± 23%  interrupts.CPU61.RES:Rescheduling_interrupts
    422032 ± 56%     -78.0%      92640 ± 21%  interrupts.CPU62.CAL:Function_call_interrupts
    543922 ± 31%     -75.6%     132790 ± 19%  interrupts.CPU62.RES:Rescheduling_interrupts
    587153 ± 55%     -84.7%      89631 ± 30%  interrupts.CPU63.CAL:Function_call_interrupts
    708789 ± 16%     -78.0%     156124 ± 26%  interrupts.CPU63.RES:Rescheduling_interrupts
    585654 ± 47%     -82.3%     103552 ± 21%  interrupts.CPU64.CAL:Function_call_interrupts
    688309 ± 21%     -75.8%     166368 ± 28%  interrupts.CPU64.RES:Rescheduling_interrupts
    581141 ± 35%     -84.3%      91047 ± 16%  interrupts.CPU65.CAL:Function_call_interrupts
    616229 ± 26%     -75.1%     153443 ± 22%  interrupts.CPU65.RES:Rescheduling_interrupts
    473840 ± 58%     -79.7%      96228 ± 15%  interrupts.CPU66.CAL:Function_call_interrupts
    529502 ± 34%     -65.9%     180396 ± 28%  interrupts.CPU66.RES:Rescheduling_interrupts
    514035 ± 41%     -81.4%      95624 ± 24%  interrupts.CPU67.CAL:Function_call_interrupts
    567972 ± 24%     -72.3%     157117 ± 24%  interrupts.CPU67.RES:Rescheduling_interrupts
    488636 ± 54%     -78.8%     103497 ± 27%  interrupts.CPU68.CAL:Function_call_interrupts
    588887 ± 26%     -71.7%     166658 ± 29%  interrupts.CPU68.RES:Rescheduling_interrupts
    473929 ± 50%     -77.8%     105198 ± 12%  interrupts.CPU69.CAL:Function_call_interrupts
    536660 ± 27%     -74.0%     139760 ± 23%  interrupts.CPU69.RES:Rescheduling_interrupts
    457894 ± 56%     -79.8%      92717 ± 30%  interrupts.CPU7.CAL:Function_call_interrupts
    470890 ± 51%     -66.4%     158208 ± 32%  interrupts.CPU7.RES:Rescheduling_interrupts
    639309 ± 51%     -84.6%      98184 ± 28%  interrupts.CPU70.CAL:Function_call_interrupts
    734558 ± 19%     -80.8%     141367 ± 43%  interrupts.CPU70.RES:Rescheduling_interrupts
    662121 ± 52%     -85.8%      93861 ± 24%  interrupts.CPU71.CAL:Function_call_interrupts
    640700 ± 34%     -78.7%     136432 ± 18%  interrupts.CPU71.RES:Rescheduling_interrupts
   1123094 ± 40%     -89.1%     122248 ± 12%  interrupts.CPU72.CAL:Function_call_interrupts
    367557 ± 41%     -72.8%     100138 ± 14%  interrupts.CPU72.RES:Rescheduling_interrupts
    636351 ± 64%     -83.6%     104327 ± 37%  interrupts.CPU73.CAL:Function_call_interrupts
    501361 ± 42%     -77.4%     113354 ± 28%  interrupts.CPU73.RES:Rescheduling_interrupts
    747849 ± 57%     -85.1%     111620 ± 38%  interrupts.CPU74.CAL:Function_call_interrupts
    617694 ± 33%     -76.8%     143288 ± 30%  interrupts.CPU74.RES:Rescheduling_interrupts
    860857 ± 56%     -84.5%     133631 ± 39%  interrupts.CPU75.CAL:Function_call_interrupts
    650519 ± 39%     -79.5%     133493 ± 29%  interrupts.CPU75.RES:Rescheduling_interrupts
    820666 ± 55%     -83.8%     132983 ± 26%  interrupts.CPU76.CAL:Function_call_interrupts
    553758 ± 27%     -78.2%     120779 ± 14%  interrupts.CPU76.RES:Rescheduling_interrupts
    785724 ± 62%     -85.7%     112086 ± 37%  interrupts.CPU77.CAL:Function_call_interrupts
    656443 ± 39%     -84.2%     103477 ± 36%  interrupts.CPU77.RES:Rescheduling_interrupts
    793606 ± 45%     -87.5%      98917 ± 29%  interrupts.CPU78.CAL:Function_call_interrupts
    579013 ± 43%     -82.0%     104251 ± 29%  interrupts.CPU78.RES:Rescheduling_interrupts
    727899 ± 64%     -85.7%     103882 ± 34%  interrupts.CPU79.CAL:Function_call_interrupts
    544650 ± 39%     -78.5%     117180 ± 31%  interrupts.CPU79.RES:Rescheduling_interrupts
    563180 ± 36%     -84.6%      86491 ± 27%  interrupts.CPU8.CAL:Function_call_interrupts
    524707 ± 26%     -72.8%     142526 ± 25%  interrupts.CPU8.RES:Rescheduling_interrupts
    929710 ± 53%     -88.7%     104876 ± 32%  interrupts.CPU80.CAL:Function_call_interrupts
    669860 ± 40%     -79.7%     135924 ± 39%  interrupts.CPU80.RES:Rescheduling_interrupts
    771837 ± 62%     -86.8%     102018 ± 44%  interrupts.CPU81.CAL:Function_call_interrupts
    599243 ± 43%     -77.5%     134873 ± 36%  interrupts.CPU81.RES:Rescheduling_interrupts
    996596 ± 63%     -89.8%     101544 ± 23%  interrupts.CPU82.CAL:Function_call_interrupts
    758943 ± 36%     -86.2%     105049 ± 17%  interrupts.CPU82.RES:Rescheduling_interrupts
    720908 ± 64%     -85.4%     105078 ± 42%  interrupts.CPU83.CAL:Function_call_interrupts
    596410 ± 50%     -78.1%     130869 ± 27%  interrupts.CPU83.RES:Rescheduling_interrupts
    595394 ± 52%     -84.9%      89866 ± 29%  interrupts.CPU84.CAL:Function_call_interrupts
    438388 ± 15%     -78.8%      92874 ± 27%  interrupts.CPU84.RES:Rescheduling_interrupts
    500965 ± 41%     -76.8%     116426 ± 14%  interrupts.CPU85.RES:Rescheduling_interrupts
    565738 ± 40%     -74.7%     143308 ± 48%  interrupts.CPU86.RES:Rescheduling_interrupts
    855623 ± 41%     -87.5%     106874 ± 25%  interrupts.CPU87.CAL:Function_call_interrupts
    657859 ± 42%     -77.8%     146024 ± 37%  interrupts.CPU87.RES:Rescheduling_interrupts
    984596 ± 68%     -88.9%     109768 ± 21%  interrupts.CPU88.CAL:Function_call_interrupts
    616449 ± 34%     -81.4%     114878 ± 23%  interrupts.CPU88.RES:Rescheduling_interrupts
    957564 ± 70%     -89.1%     104327 ± 25%  interrupts.CPU89.CAL:Function_call_interrupts
    685537 ± 46%     -83.7%     112008 ± 20%  interrupts.CPU89.RES:Rescheduling_interrupts
    505120 ± 35%     -82.9%      86292 ± 14%  interrupts.CPU9.CAL:Function_call_interrupts
    557760 ± 23%     -71.8%     157380 ± 35%  interrupts.CPU9.RES:Rescheduling_interrupts
    594960 ± 42%     -79.0%     124824 ± 16%  interrupts.CPU90.RES:Rescheduling_interrupts
    972190 ± 55%     -89.1%     105610 ± 56%  interrupts.CPU91.CAL:Function_call_interrupts
    737043 ± 39%     -84.3%     115867 ± 20%  interrupts.CPU91.RES:Rescheduling_interrupts
    870362 ± 47%     -89.2%      93606 ± 31%  interrupts.CPU92.CAL:Function_call_interrupts
    595357 ± 43%     -78.5%     128171 ± 24%  interrupts.CPU92.RES:Rescheduling_interrupts
    966701 ± 61%     -87.4%     122268 ± 34%  interrupts.CPU93.CAL:Function_call_interrupts
    612011 ± 28%     -77.7%     136594 ± 23%  interrupts.CPU93.RES:Rescheduling_interrupts
   1067318 ± 53%     -90.2%     104449 ± 19%  interrupts.CPU94.CAL:Function_call_interrupts
    699603 ± 32%     -83.8%     113008 ± 27%  interrupts.CPU94.RES:Rescheduling_interrupts
   1086161 ± 42%     -91.1%      96762 ± 20%  interrupts.CPU95.CAL:Function_call_interrupts
    685521 ± 49%     -82.9%     116896 ± 34%  interrupts.CPU95.RES:Rescheduling_interrupts
    432.00 ± 11%     -33.3%     288.00        interrupts.MCP:Machine_check_polls
  55987281 ± 21%     -77.1%   12807267 ± 11%  interrupts.RES:Rescheduling_interrupts
     11.78 ± 26%      -8.9        2.88 ±  7%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event
     11.12 ± 27%      -8.4        2.68 ±  8%  perf-profile.calltrace.cycles-pp.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow
     11.08 ± 27%      -8.4        2.66 ±  8%  perf-profile.calltrace.cycles-pp.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
      9.99 ±  6%      -8.0        2.04 ±  2%  perf-profile.calltrace.cycles-pp.mod_objcg_state.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      9.93 ± 20%      -6.4        3.49 ± 11%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      9.78 ± 20%      -6.4        3.35 ± 15%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_sendmsg
      9.72 ± 20%      -6.4        3.31 ± 15%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg
      9.67 ± 20%      -6.4        3.29 ± 15%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable
      6.34 ± 22%      -6.2        0.17 ±223%  perf-profile.calltrace.cycles-pp.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
      6.16 ±  7%      -6.2        0.00        perf-profile.calltrace.cycles-pp.mod_objcg_state.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      7.75 ±  7%      -6.1        1.62        perf-profile.calltrace.cycles-pp.mod_objcg_state.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     10.12 ± 20%      -6.1        4.02 ± 10%  perf-profile.calltrace.cycles-pp.sock_def_readable.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      6.10 ±  7%      -6.1        0.00        perf-profile.calltrace.cycles-pp.mod_objcg_state.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      8.02 ± 20%      -5.2        2.83 ±  6%  perf-profile.calltrace.cycles-pp.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      7.96 ± 20%      -5.2        2.80 ±  6%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      7.90 ± 20%      -5.1        2.78 ±  6%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg
      5.74 ± 26%      -4.1        1.60 ±  7%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr
      5.71 ± 26%      -4.1        1.57 ±  7%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime
      3.90 ± 28%      -3.2        0.68 ±  8%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch.__schedule.schedule
      3.90 ± 28%      -3.2        0.68 ±  8%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch.__schedule
      3.78 ± 26%      -3.1        0.66 ±  8%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch
      3.88 ± 25%      -2.7        1.14 ±  6%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      3.62 ± 26%      -2.6        1.03 ±  7%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      3.58 ± 26%      -2.6        1.01 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      3.47 ± 25%      -2.4        1.04 ±  6%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      3.34 ± 25%      -2.3        1.00 ±  6%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      3.23 ± 26%      -2.3        0.90 ±  8%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      3.20 ± 25%      -2.2        0.96 ±  6%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair.__schedule
      3.15 ± 25%      -2.2        0.92 ±  6%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair
      2.93 ± 20%      -2.2        0.72 ± 15%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.02 ± 20%      -2.2        0.81 ± 14%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.08 ± 25%      -2.2        0.89 ±  7%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity
      2.91 ± 27%      -2.1        0.79 ±  8%  perf-profile.calltrace.cycles-pp.update_curr.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      2.84 ± 26%      -2.0        0.80 ±  7%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      2.79 ± 27%      -2.0        0.75 ±  8%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.enqueue_entity.enqueue_task_fair.ttwu_do_activate
      2.78 ± 26%      -2.0        0.77 ±  7%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common
      2.74 ± 27%      -2.0        0.74 ±  8%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.enqueue_entity.enqueue_task_fair
      2.69 ± 27%      -2.0        0.73 ±  8%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.enqueue_entity
      2.67 ± 26%      -1.9        0.74 ±  8%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function
      2.66 ± 26%      -1.9        0.74 ±  8%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up
      2.66 ± 26%      -1.9        0.73 ±  8%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_wakeup_template
      2.51 ± 27%      -1.8        0.75 ±  7%  perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      2.31 ± 29%      -1.6        0.69 ±  8%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule.schedule_timeout
      1.91 ± 37%      -1.4        0.47 ±100%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.73 ± 38%      -1.3        0.46 ±100%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.55 ±  4%      +0.2        0.77 ±  2%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      0.74 ± 11%      +0.3        1.07 ±  3%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_objcg.obj_cgroup_uncharge_pages.drain_obj_stock.refill_obj_stock.kfree
     47.29            +0.4       47.67        perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write
     47.56            +0.4       47.98        perf-profile.calltrace.cycles-pp.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write.ksys_write
     47.95            +0.4       48.38        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     47.74            +0.5       48.20        perf-profile.calltrace.cycles-pp.sock_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.83 ±  9%      +0.5        1.37 ±  5%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.00            +0.5        0.54 ±  4%  perf-profile.calltrace.cycles-pp.unix_write_space.sock_wfree.unix_destruct_scm.skb_release_head_state.skb_release_all
      0.76 ± 10%      +0.6        1.32 ±  5%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00            +0.6        0.61 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      0.00            +0.6        0.62 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00            +0.6        0.62        perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      0.58 ±  4%      +0.6        1.23 ±  3%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      0.60 ±  4%      +0.7        1.26 ±  3%  perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      0.75 ±  3%      +0.7        1.41 ±  3%  perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      1.11 ± 11%      +0.8        1.87 ±  4%  perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.drain_obj_stock.refill_obj_stock.kmem_cache_free.unix_stream_read_generic
      0.00            +0.8        0.80        perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      1.18 ±  2%      +0.9        2.08 ±  2%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg
      1.19 ±  2%      +0.9        2.09 ±  2%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      1.20 ±  2%      +0.9        2.10 ±  2%  perf-profile.calltrace.cycles-pp.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.83 ±  6%      +1.1        1.94 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.82 ±  6%      +1.1        1.93 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      0.75 ±  6%      +1.1        1.86 ±  2%  perf-profile.calltrace.cycles-pp.sock_wfree.unix_destruct_scm.skb_release_head_state.skb_release_all.consume_skb
      0.78 ±  6%      +1.1        1.91 ±  2%  perf-profile.calltrace.cycles-pp.unix_destruct_scm.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic
      0.00            +1.1        1.14 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      0.00            +1.2        1.18 ±  6%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb
      0.00            +1.2        1.22 ±  8%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.obj_cgroup_uncharge_pages.drain_obj_stock.refill_obj_stock.kmem_cache_free
      0.00            +1.5        1.46 ±  7%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.obj_cgroup_uncharge_pages.drain_obj_stock.refill_obj_stock.kfree
      1.44 ± 11%      +1.7        3.12 ±  9%  perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.drain_obj_stock.refill_obj_stock.kfree.consume_skb
      2.53 ± 21%      +1.7        4.22        perf-profile.calltrace.cycles-pp.refill_obj_stock.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      1.46 ± 12%      +1.8        3.22 ± 11%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
     37.73            +1.8       39.52        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.92            +1.8       39.74        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.51 ± 11%      +1.9        3.38 ±  5%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     44.66            +1.9       46.61        perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read
     44.74            +2.0       46.71        perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read.ksys_read
     45.13            +2.1       47.21        perf-profile.calltrace.cycles-pp.sock_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
     45.27            +2.1       47.37        perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.2        2.18 ±  9%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.obj_cgroup_uncharge_pages.drain_obj_stock.refill_obj_stock
     17.32 ±  7%      +2.2       19.57        perf-profile.calltrace.cycles-pp.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.18 ±141%      +2.5        2.63 ± 13%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve
      1.59 ± 11%      +2.6        4.14        perf-profile.calltrace.cycles-pp.drain_obj_stock.refill_obj_stock.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
      3.15 ± 17%      +2.6        5.72 ±  2%  perf-profile.calltrace.cycles-pp.refill_obj_stock.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
     17.76 ±  6%      +3.0       20.73        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      2.38 ± 16%      +3.2        5.57        perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      2.21 ± 20%      +3.4        5.62 ±  2%  perf-profile.calltrace.cycles-pp.drain_obj_stock.refill_obj_stock.kfree.consume_skb.unix_stream_read_generic
     18.88 ±  6%      +4.4       23.30        perf-profile.calltrace.cycles-pp.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
     34.61 ±  6%      +4.5       39.16        perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     34.65 ±  6%      +4.6       39.22        perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
     35.25 ±  6%      +5.2       40.41        perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      5.31 ±  7%      +7.2       12.52 ±  2%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     30.03 ±  6%     -24.9        5.10        perf-profile.children.cycles-pp.mod_objcg_state
     17.84 ±  8%     -17.6        0.26 ± 15%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
     17.60 ±  8%     -17.4        0.18 ± 22%  perf-profile.children.cycles-pp.__mod_memcg_state
     14.38 ± 20%      -9.2        5.19 ±  3%  perf-profile.children.cycles-pp.perf_tp_event
     14.00 ± 20%      -9.0        5.03 ±  4%  perf-profile.children.cycles-pp.perf_swevent_overflow
     13.95 ± 20%      -9.0        4.99 ±  4%  perf-profile.children.cycles-pp.__perf_event_overflow
     13.86 ± 20%      -8.9        4.93 ±  4%  perf-profile.children.cycles-pp.perf_event_output_forward
     13.57 ± 20%      -8.8        4.79 ±  3%  perf-profile.children.cycles-pp.perf_prepare_sample
     12.77 ± 21%      -8.3        4.45 ±  4%  perf-profile.children.cycles-pp.perf_callchain
     12.72 ± 21%      -8.3        4.42 ±  4%  perf-profile.children.cycles-pp.get_perf_callchain
     11.23 ± 20%      -7.2        4.04 ±  4%  perf-profile.children.cycles-pp.schedule
     11.22 ± 20%      -7.2        4.06 ±  4%  perf-profile.children.cycles-pp.__schedule
     10.15 ± 20%      -6.2        3.97 ± 10%  perf-profile.children.cycles-pp.__wake_up_common_lock
     10.12 ± 20%      -6.1        4.02 ± 10%  perf-profile.children.cycles-pp.sock_def_readable
     10.00 ± 20%      -6.1        3.91 ± 10%  perf-profile.children.cycles-pp.__wake_up_common
      9.93 ± 20%      -6.1        3.87 ± 10%  perf-profile.children.cycles-pp.autoremove_wake_function
      9.88 ± 20%      -6.0        3.84 ± 10%  perf-profile.children.cycles-pp.try_to_wake_up
      8.18 ± 21%      -5.4        2.82 ±  4%  perf-profile.children.cycles-pp.perf_callchain_kernel
      8.23 ± 19%      -4.7        3.48 ±  2%  perf-profile.children.cycles-pp.schedule_timeout
      7.34 ± 19%      -4.4        2.97 ±  2%  perf-profile.children.cycles-pp.update_curr
      6.89 ± 19%      -4.1        2.80 ±  2%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      6.22 ± 22%      -4.1        2.14 ±  4%  perf-profile.children.cycles-pp.unwind_next_frame
      4.78 ± 22%      -3.3        1.46 ±  6%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      4.28 ± 20%      -2.8        1.49 ±  4%  perf-profile.children.cycles-pp.perf_callchain_user
      3.56 ± 21%      -2.7        0.91 ± 11%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      3.67 ± 21%      -2.6        1.02 ± 10%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.99 ± 20%      -2.6        1.40 ±  4%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      3.98 ± 20%      -2.5        1.46 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
      3.94 ± 20%      -2.5        1.43 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
      4.13 ± 19%      -2.5        1.66 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      3.55 ± 21%      -2.3        1.28 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
      3.79 ± 19%      -2.3        1.52 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      3.35 ± 22%      -2.2        1.15 ±  3%  perf-profile.children.cycles-pp.__unwind_start
      3.09 ± 20%      -1.9        1.15 ±  3%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      2.48 ± 20%      -1.6        0.84 ±  4%  perf-profile.children.cycles-pp.asm_exc_page_fault
      1.76 ± 20%      -1.1        0.61 ±  3%  perf-profile.children.cycles-pp.__orc_find
      0.96 ± 20%      -0.6        0.32 ±  3%  perf-profile.children.cycles-pp.unwind_get_return_address
      0.97 ± 23%      -0.6        0.32 ±  4%  perf-profile.children.cycles-pp.orc_find
      0.77 ± 20%      -0.5        0.25 ±  4%  perf-profile.children.cycles-pp.__kernel_text_address
      0.78 ± 18%      -0.5        0.28 ±  3%  perf-profile.children.cycles-pp.exc_page_fault
      0.70 ± 20%      -0.4        0.27 ±  4%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.65 ± 22%      -0.4        0.23 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.63 ± 19%      -0.4        0.21 ±  4%  perf-profile.children.cycles-pp.kernelmode_fixup_or_oops
      0.60 ± 20%      -0.4        0.19 ±  4%  perf-profile.children.cycles-pp.kernel_text_address
      0.61 ± 22%      -0.4        0.20 ±  6%  perf-profile.children.cycles-pp.stack_access_ok
      0.55 ± 20%      -0.4        0.18 ±  3%  perf-profile.children.cycles-pp.fixup_exception
      0.48 ± 20%      -0.3        0.16 ±  4%  perf-profile.children.cycles-pp.search_exception_tables
      0.47 ± 19%      -0.3        0.15 ±  3%  perf-profile.children.cycles-pp.search_extable
      0.44 ± 20%      -0.3        0.15 ±  5%  perf-profile.children.cycles-pp.bsearch
      0.52 ± 16%      -0.3        0.25 ±  6%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.46 ± 20%      -0.3        0.19 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      0.44 ± 16%      -0.2        0.20 ±  2%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.30 ± 19%      -0.2        0.10 ±  4%  perf-profile.children.cycles-pp.cmp_ex_search
      0.36 ± 17%      -0.2        0.17 ±  6%  perf-profile.children.cycles-pp.switch_fpu_return
      0.25 ± 25%      -0.2        0.06 ±  9%  perf-profile.children.cycles-pp.__enqueue_entity
      0.28 ± 20%      -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.load_new_mm_cr3
      0.26 ± 31%      -0.2        0.08 ± 36%  perf-profile.children.cycles-pp.cpumask_next_wrap
      0.26 ± 15%      -0.2        0.09 ±  4%  perf-profile.children.cycles-pp.reweight_entity
      0.23 ± 20%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.__switch_to_asm
      0.18 ± 23%      -0.1        0.04 ± 44%  perf-profile.children.cycles-pp.finish_task_switch
      0.21 ± 20%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.perf_output_begin_forward
      0.21 ± 22%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.ftrace_graph_ret_addr
      0.23 ± 16%      -0.1        0.11        perf-profile.children.cycles-pp.perf_event_pid_type
      0.20 ± 32%      -0.1        0.08 ± 20%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.18 ± 21%      -0.1        0.07 ± 10%  perf-profile.children.cycles-pp.update_rq_clock
      0.20 ± 12%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__switch_to
      0.20 ± 20%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.19 ± 20%      -0.1        0.08        perf-profile.children.cycles-pp.__update_load_avg_se
      0.15 ± 13%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.17 ± 18%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.native_sched_clock
      0.19 ± 14%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.13 ± 17%      -0.1        0.05 ± 45%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.18 ± 15%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.set_next_entity
      0.13 ± 18%      -0.1        0.05 ±  7%  perf-profile.children.cycles-pp.cpuacct_charge
      0.16 ± 17%      -0.1        0.10 ±  3%  perf-profile.children.cycles-pp.prepare_to_wait
      0.13 ± 16%      -0.1        0.08 ±  7%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.10 ±  9%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.update_cfs_group
      0.09 ± 21%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.get_stack_info
      0.09 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.security_socket_getpeersec_dgram
      0.15 ±  6%      +0.0        0.17 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.09 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.wait_for_unix_gc
      0.22 ±  5%      +0.0        0.26 ±  2%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.21 ±  5%      +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.19 ±  4%      +0.0        0.23        perf-profile.children.cycles-pp.__might_sleep
      0.20 ±  3%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.32 ±  4%      +0.1        0.38        perf-profile.children.cycles-pp.aa_sk_perm
      0.24 ±  5%      +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.sock_recvmsg
      0.55 ±  4%      +0.1        0.60 ±  2%  perf-profile.children.cycles-pp.security_file_permission
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.28 ±  4%      +0.1        0.34 ±  3%  perf-profile.children.cycles-pp.___might_sleep
      0.10 ± 11%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.refill_stock
      0.34 ±  6%      +0.1        0.41 ±  2%  perf-profile.children.cycles-pp.__fget_light
      0.22 ±  6%      +0.1        0.30 ±  4%  perf-profile.children.cycles-pp.fsnotify
      0.07 ± 15%      +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.drain_stock
      0.38 ±  5%      +0.1        0.46 ±  2%  perf-profile.children.cycles-pp.__fdget_pos
      0.09 ±  9%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.__ksize
      0.18 ±  4%      +0.1        0.27 ±  3%  perf-profile.children.cycles-pp.__entry_text_start
      0.18 ±  6%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.__check_heap_object
      0.04 ± 71%      +0.1        0.14 ±  4%  perf-profile.children.cycles-pp.try_charge
      0.22 ±  5%      +0.1        0.33 ±  2%  perf-profile.children.cycles-pp.copyin
      0.37 ±  4%      +0.2        0.52 ±  3%  perf-profile.children.cycles-pp._copy_from_iter
      0.31 ±  3%      +0.2        0.47 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.22 ±  3%      +0.2        0.39 ±  3%  perf-profile.children.cycles-pp.mutex_lock
      0.09 ± 10%      +0.2        0.28 ±  5%  perf-profile.children.cycles-pp.get_partial_node
      0.13 ±  6%      +0.2        0.32 ±  4%  perf-profile.children.cycles-pp.mutex_unlock
      0.16 ±  4%      +0.2        0.35 ±  4%  perf-profile.children.cycles-pp.skb_queue_tail
      0.67 ±  5%      +0.3        0.95 ±  2%  perf-profile.children.cycles-pp.skb_copy_datagram_from_iter
      0.16 ±  6%      +0.3        0.44 ±  5%  perf-profile.children.cycles-pp.___slab_alloc
      0.16 ±  7%      +0.3        0.45 ±  4%  perf-profile.children.cycles-pp.__slab_alloc
      0.47 ±  3%      +0.3        0.76 ±  2%  perf-profile.children.cycles-pp.simple_copy_to_iter
      0.30 ±  2%      +0.3        0.60 ±  2%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.13 ±  6%      +0.3        0.44 ±  4%  perf-profile.children.cycles-pp.skb_unlink
      0.32 ±  5%      +0.3        0.66 ±  3%  perf-profile.children.cycles-pp.unix_write_space
      0.21 ± 10%      +0.4        0.56 ±  3%  perf-profile.children.cycles-pp.__build_skb_around
      0.73 ±  3%      +0.4        1.11        perf-profile.children.cycles-pp.__check_object_size
     47.31            +0.4       47.69        perf-profile.children.cycles-pp.unix_stream_sendmsg
      0.44 ±  5%      +0.4        0.84 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     47.57            +0.4       48.00        perf-profile.children.cycles-pp.sock_sendmsg
     47.96            +0.4       48.39        perf-profile.children.cycles-pp.new_sync_write
     48.51            +0.4       48.96        perf-profile.children.cycles-pp.vfs_write
     47.74            +0.5       48.20        perf-profile.children.cycles-pp.sock_write_iter
      0.28 ± 13%      +0.5        0.76        perf-profile.children.cycles-pp.skb_release_data
     48.76            +0.5       49.27        perf-profile.children.cycles-pp.ksys_write
      0.28 ±  6%      +0.5        0.80 ±  2%  perf-profile.children.cycles-pp.__slab_free
      0.74 ±  4%      +0.8        1.53 ±  3%  perf-profile.children.cycles-pp.copyout
      0.91 ±  3%      +0.8        1.71 ±  2%  perf-profile.children.cycles-pp._copy_to_iter
      0.92 ±  3%      +0.9        1.83 ±  2%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      1.43 ±  2%      +1.1        2.52 ±  2%  perf-profile.children.cycles-pp.__skb_datagram_iter
      1.44 ±  2%      +1.1        2.54 ±  2%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      1.45 ±  2%      +1.1        2.56 ±  2%  perf-profile.children.cycles-pp.unix_stream_read_actor
      0.34 ± 13%      +1.2        1.53 ±  7%  perf-profile.children.cycles-pp.propagate_protected_usage
      1.36 ±  7%      +1.3        2.63 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      1.01 ±  6%      +1.4        2.36 ±  2%  perf-profile.children.cycles-pp.skb_release_all
      1.00 ±  6%      +1.4        2.35 ±  2%  perf-profile.children.cycles-pp.skb_release_head_state
      0.91 ±  7%      +1.4        2.26 ±  2%  perf-profile.children.cycles-pp.sock_wfree
      0.95 ±  6%      +1.4        2.33 ±  2%  perf-profile.children.cycles-pp.unix_destruct_scm
     44.68            +2.0       46.63        perf-profile.children.cycles-pp.unix_stream_read_generic
     44.74            +2.0       46.71        perf-profile.children.cycles-pp.unix_stream_recvmsg
     45.13            +2.1       47.21        perf-profile.children.cycles-pp.sock_read_iter
     45.27            +2.1       47.38        perf-profile.children.cycles-pp.new_sync_read
      0.58 ± 12%      +2.2        2.74 ±  9%  perf-profile.children.cycles-pp.page_counter_cancel
      2.86 ± 11%      +2.2        5.05 ±  5%  perf-profile.children.cycles-pp.obj_cgroup_charge
     45.86            +2.2       48.06        perf-profile.children.cycles-pp.vfs_read
      2.71 ± 12%      +2.2        4.91 ±  5%  perf-profile.children.cycles-pp.obj_cgroup_charge_pages
     46.09            +2.2       48.31        perf-profile.children.cycles-pp.ksys_read
     17.33 ±  7%      +2.2       19.57        perf-profile.children.cycles-pp.kfree
      3.13 ± 11%      +2.3        5.47 ±  3%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.77 ± 12%      +2.6        3.39 ±  7%  perf-profile.children.cycles-pp.page_counter_uncharge
     17.80 ±  6%      +3.0       20.76        perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.89 ± 13%      +3.4        4.32 ±  6%  perf-profile.children.cycles-pp.page_counter_try_charge
      6.15 ± 11%      +3.8        9.95        perf-profile.children.cycles-pp.refill_obj_stock
     18.88 ±  6%      +4.4       23.30        perf-profile.children.cycles-pp.consume_skb
     34.62 ±  6%      +4.6       39.18        perf-profile.children.cycles-pp.__alloc_skb
     34.66 ±  6%      +4.6       39.22        perf-profile.children.cycles-pp.alloc_skb_with_frags
     35.25 ±  6%      +5.2       40.41        perf-profile.children.cycles-pp.sock_alloc_send_pskb
      4.45 ± 11%      +5.3        9.77        perf-profile.children.cycles-pp.drain_obj_stock
      8.01 ±  7%     +10.1       18.12 ±  2%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
     17.60 ±  8%     -17.4        0.18 ± 23%  perf-profile.self.cycles-pp.__mod_memcg_state
     11.95 ±  7%      -7.1        4.83        perf-profile.self.cycles-pp.mod_objcg_state
      2.76 ± 22%      -1.8        0.95 ±  4%  perf-profile.self.cycles-pp.unwind_next_frame
      1.64 ± 11%      -1.5        0.11 ±  6%  perf-profile.self.cycles-pp.refill_obj_stock
      2.30 ± 20%      -1.5        0.80 ±  4%  perf-profile.self.cycles-pp.__get_user_nocheck_8
      1.75 ± 20%      -1.1        0.61 ±  3%  perf-profile.self.cycles-pp.__orc_find
      0.80 ± 12%      -0.7        0.08 ± 19%  perf-profile.self.cycles-pp.obj_cgroup_charge_pages
      0.78 ± 12%      -0.7        0.08 ± 19%  perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      0.92 ± 22%      -0.6        0.31 ±  3%  perf-profile.self.cycles-pp.orc_find
      0.70 ± 22%      -0.5        0.24 ±  5%  perf-profile.self.cycles-pp.perf_callchain_kernel
      0.70 ± 20%      -0.4        0.27 ±  4%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.54 ± 23%      -0.4        0.18 ±  6%  perf-profile.self.cycles-pp.stack_access_ok
      0.48 ± 13%      -0.2        0.24 ±  6%  perf-profile.self.cycles-pp.__schedule
      0.30 ± 22%      -0.2        0.09 ±  5%  perf-profile.self.cycles-pp.__unwind_start
      0.29 ± 19%      -0.2        0.09 ±  4%  perf-profile.self.cycles-pp.cmp_ex_search
      0.36 ± 16%      -0.2        0.16 ±  5%  perf-profile.self.cycles-pp.switch_fpu_return
      0.25 ± 25%      -0.2        0.06 ±  9%  perf-profile.self.cycles-pp.__enqueue_entity
      0.28 ± 20%      -0.2        0.09 ±  4%  perf-profile.self.cycles-pp.load_new_mm_cr3
      0.27 ± 22%      -0.2        0.08 ±  5%  perf-profile.self.cycles-pp.kernel_text_address
      0.26 ± 18%      -0.2        0.08 ± 11%  perf-profile.self.cycles-pp.perf_callchain_user
      0.23 ± 20%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.__switch_to_asm
      0.22 ± 18%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.perf_tp_event
      0.20 ± 22%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.unwind_get_return_address
      0.23 ± 14%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.perf_prepare_sample
      0.16 ± 28%      -0.1        0.04 ±100%  perf-profile.self.cycles-pp.cpumask_next_wrap
      0.20 ± 32%      -0.1        0.08 ± 20%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.19 ± 20%      -0.1        0.07 ±  8%  perf-profile.self.cycles-pp.get_perf_callchain
      0.18 ± 20%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.perf_output_begin_forward
      0.18 ± 19%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.update_curr
      0.18 ± 20%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.16 ± 13%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__switch_to
      0.15 ± 20%      -0.1        0.05 ±  7%  perf-profile.self.cycles-pp.bsearch
      0.15 ± 12%      -0.1        0.05 ±  7%  perf-profile.self.cycles-pp.reweight_entity
      0.18 ± 24%      -0.1        0.08 ±  7%  perf-profile.self.cycles-pp.ftrace_graph_ret_addr
      0.12 ± 31%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp._find_next_bit
      0.16 ± 20%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.native_sched_clock
      0.14 ± 22%      -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__kernel_text_address
      0.12 ± 20%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.14 ± 18%      -0.1        0.06        perf-profile.self.cycles-pp.update_load_avg
      0.18 ± 15%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.18 ± 12%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.23 ± 11%      -0.1        0.16 ±  7%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.12 ± 19%      -0.1        0.05        perf-profile.self.cycles-pp.cpuacct_charge
      0.13 ± 19%      -0.1        0.06        perf-profile.self.cycles-pp.try_to_wake_up
      0.11 ± 15%      -0.1        0.05 ±  7%  perf-profile.self.cycles-pp.enqueue_entity
      0.12 ± 17%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.10 ± 17%      -0.1        0.04 ± 45%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.11            -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.10 ± 10%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.update_cfs_group
      0.09 ±  9%      -0.0        0.05 ± 13%  perf-profile.self.cycles-pp.perf_event_output_forward
      0.08 ± 14%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.prepare_to_wait
      0.08 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.rcu_read_unlock_strict
      0.06 ± 11%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.security_file_permission
      0.18 ±  7%      +0.0        0.21 ±  4%  perf-profile.self.cycles-pp.sock_write_iter
      0.21 ±  4%      +0.0        0.25 ±  3%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.08 ±  8%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp._copy_from_iter
      0.17 ±  5%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__might_sleep
      0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.01 ±223%      +0.0        0.06 ±  8%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.18 ±  5%      +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.aa_sk_perm
      0.07            +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.01 ±223%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.unix_destruct_scm
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__fdget_pos
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.sock_recvmsg
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.skb_copy_datagram_from_iter
      0.15 ±  5%      +0.1        0.20 ±  3%  perf-profile.self.cycles-pp.sock_read_iter
      0.27 ±  3%      +0.1        0.33 ±  4%  perf-profile.self.cycles-pp.___might_sleep
      0.34 ±  6%      +0.1        0.40 ±  3%  perf-profile.self.cycles-pp.__fget_light
      0.22 ±  6%      +0.1        0.28 ±  3%  perf-profile.self.cycles-pp.fsnotify
      0.10 ±  4%      +0.1        0.18 ±  4%  perf-profile.self.cycles-pp.unix_write_space
      0.15 ±  4%      +0.1        0.22 ±  3%  perf-profile.self.cycles-pp.__entry_text_start
      0.08 ±  8%      +0.1        0.17        perf-profile.self.cycles-pp.__ksize
      0.18 ±  5%      +0.1        0.27 ±  2%  perf-profile.self.cycles-pp.__check_heap_object
      0.07 ± 11%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.___slab_alloc
      0.11 ±  3%      +0.1        0.20 ±  3%  perf-profile.self.cycles-pp.consume_skb
      0.00            +0.1        0.10 ±  7%  perf-profile.self.cycles-pp.get_partial_node
      0.19 ±  5%      +0.1        0.32 ±  2%  perf-profile.self.cycles-pp.__alloc_skb
      0.14 ±  5%      +0.1        0.29 ±  2%  perf-profile.self.cycles-pp.mutex_lock
      0.31 ±  3%      +0.2        0.47 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.12 ±  6%      +0.2        0.31 ±  5%  perf-profile.self.cycles-pp.mutex_unlock
      0.26 ±  4%      +0.3        0.51 ±  3%  perf-profile.self.cycles-pp.__check_object_size
      0.30 ±  2%      +0.3        0.59 ±  2%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.15 ± 11%      +0.3        0.46 ±  4%  perf-profile.self.cycles-pp.__build_skb_around
      0.18 ±  3%      +0.3        0.53 ±  5%  perf-profile.self.cycles-pp.sock_def_readable
      0.57 ±  4%      +0.4        0.96 ±  2%  perf-profile.self.cycles-pp.unix_stream_read_generic
      0.43 ±  6%      +0.4        0.84 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.28 ± 13%      +0.5        0.76        perf-profile.self.cycles-pp.skb_release_data
      0.28 ±  6%      +0.5        0.79 ±  2%  perf-profile.self.cycles-pp.__slab_free
      5.10 ±  6%      +0.8        5.86 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.91 ±  3%      +0.9        1.82 ±  3%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.58 ±  9%      +1.0        1.58 ±  2%  perf-profile.self.cycles-pp.sock_wfree
      0.34 ± 13%      +1.2        1.52 ±  7%  perf-profile.self.cycles-pp.propagate_protected_usage
      1.15 ±  5%      +1.4        2.53 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.58 ± 12%      +2.2        2.74 ±  9%  perf-profile.self.cycles-pp.page_counter_cancel
      5.49 ±  6%      +2.2        7.66 ±  2%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      0.73 ± 13%      +2.7        3.39 ±  8%  perf-profile.self.cycles-pp.page_counter_try_charge
      1.32 ± 11%      +2.9        4.26 ±  3%  perf-profile.self.cycles-pp.drain_obj_stock
      3.94 ±  7%      +3.9        7.86        perf-profile.self.cycles-pp.kmem_cache_free
      3.97 ±  7%      +7.3       11.30 ±  2%  perf-profile.self.cycles-pp.kfree
      7.90 ±  7%     +10.0       17.91 ±  2%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current



***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets Skylake with 192G memory
=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase/ucode:
  gcc-9/performance/socket/4/x86_64-rhel-8.3/threads/100%/debian-10.4-x86_64-20200603.cgz/lkp-skl-fpga01/hackbench/0x2006a0a

commit: 
  fdbcb2a6d6 ("mm/memcg: move mod_objcg_state() to memcontrol.c")
  68ac5b3c8d ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")

fdbcb2a6d6778e0b 68ac5b3c8db2fda00af594eca41 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     58594 ±  2%     +40.7%      82459        hackbench.throughput
    876.58           -31.4%     601.44        hackbench.time.elapsed_time
    876.58           -31.4%     601.44        hackbench.time.elapsed_time.max
 2.049e+09 ±  2%     +14.4%  2.344e+09 ±  3%  hackbench.time.involuntary_context_switches
     80437           -33.3%      53613        hackbench.time.system_time
      9246           -15.3%       7833        hackbench.time.user_time
 3.259e+09            +7.2%  3.493e+09 ±  2%  hackbench.time.voluntary_context_switches
   7604601 ± 19%     -25.2%    5686636 ± 13%  cpuidle.C1.usage
    926.06           -29.7%     651.41        uptime.boot
      2.47 ±  6%      +1.0        3.45 ±  4%  mpstat.cpu.all.idle%
      9.97            +2.2       12.20        mpstat.cpu.all.usr%
   6057764 ±  3%     +59.8%    9678625 ±  2%  vmstat.system.cs
    730949           +30.7%     955036 ±  3%  vmstat.system.in
   7598688 ± 19%     -25.3%    5677672 ± 13%  turbostat.C1
      0.44 ±  2%     +54.6%       0.68 ±  2%  turbostat.CPU%c1
 6.632e+08 ±  2%     -10.2%  5.956e+08 ±  3%  turbostat.IRQ
      4.86 ± 20%     +52.8       57.63 ± 25%  turbostat.PKG_%
    355.39            +4.7%     372.20        turbostat.PkgWatt
    123.74            -4.4%     118.32        turbostat.RAMWatt
     45898           -14.9%      39056 ±  3%  slabinfo.kmalloc-512.active_objs
      1681 ±  2%     -16.9%       1397 ±  3%  slabinfo.kmalloc-512.active_slabs
     53826 ±  2%     -16.9%      44743 ±  3%  slabinfo.kmalloc-512.num_objs
      1681 ±  2%     -16.9%       1397 ±  3%  slabinfo.kmalloc-512.num_slabs
     36866 ±  2%     -16.9%      30624 ±  3%  slabinfo.skbuff_head_cache.active_objs
      1381 ±  2%     -19.1%       1117 ±  4%  slabinfo.skbuff_head_cache.active_slabs
     44208 ±  2%     -19.1%      35782 ±  4%  slabinfo.skbuff_head_cache.num_objs
      1381 ±  2%     -19.1%       1117 ±  4%  slabinfo.skbuff_head_cache.num_slabs
    191781 ±  3%     -13.1%     166659 ± 11%  proc-vmstat.nr_active_anon
     71587            +2.5%      73405 ±  2%  proc-vmstat.nr_anon_pages
    812663            -2.2%     794697        proc-vmstat.nr_file_pages
    220808            -8.5%     201937        proc-vmstat.nr_shmem
    191781 ±  3%     -13.1%     166659 ± 11%  proc-vmstat.nr_zone_active_anon
   2969387            +8.5%    3223037 ±  2%  proc-vmstat.numa_hit
   2875316            +8.8%    3128922 ±  2%  proc-vmstat.numa_local
    245303            -1.6%     241489        proc-vmstat.pgactivate
   5358774 ±  2%     +24.1%    6652818 ±  3%  proc-vmstat.pgalloc_normal
   2267435 ±  3%     -20.8%    1795974 ±  3%  proc-vmstat.pgfault
   5077096 ±  2%     +25.5%    6372725 ±  3%  proc-vmstat.pgfree
    109324 ±  2%     -28.6%      78108        proc-vmstat.pgreuse
      0.00 ±141%  +1.5e+05%       6.71 ± 71%  perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      1.22 ± 11%     -58.1%       0.51 ± 37%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.09 ±127%    +119.6%       0.19 ± 51%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.00 ±141%  +1.5e+05%       6.72 ± 71%  perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
     15588 ±  6%     -26.1%      11520 ± 16%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7662 ± 28%     -89.5%     802.08 ±187%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      2234 ±139%     -99.3%      14.55 ± 52%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
     16317 ± 11%     -21.7%      12780 ± 13%  perf-sched.sch_delay.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.97 ±138%    +205.9%       2.98        perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
     16552 ±  9%     -21.9%      12925 ± 13%  perf-sched.total_sch_delay.max.ms
     33139 ±  9%     -21.9%      25866 ± 13%  perf-sched.total_wait_and_delay.max.ms
     16912 ±  9%     -19.3%      13649 ± 12%  perf-sched.total_wait_time.max.ms
    134.61 ± 15%     -29.2%      95.29 ± 22%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
     11728 ±  5%     -67.7%       3789 ± 46%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
     15675 ± 13%     -39.7%       9455 ± 32%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     31257 ±  6%     -26.0%      23132 ± 16%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     32739 ± 10%     -21.9%      25565 ± 13%  perf-sched.wait_and_delay.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     15848 ±  7%     -23.2%      12170 ± 12%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
    384.57 ± 38%     -53.8%     177.56 ± 57%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    134.61 ± 15%     -29.2%      95.29 ± 22%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
     14420 ± 11%     -45.9%       7800 ± 32%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      3754 ± 68%     -75.8%     909.20 ±144%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     16912 ±  9%     -19.3%      13649 ± 12%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16327 ±  8%     -22.0%      12732 ±  9%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
     16535 ± 10%     -21.3%      13018 ± 14%  perf-sched.wait_time.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     15848 ±  7%     -23.2%      12170 ± 12%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
     14.02 ±  2%     -16.7%      11.68        perf-stat.i.MPKI
 1.293e+10           +47.8%   1.91e+10 ±  2%  perf-stat.i.branch-instructions
 2.072e+08           +50.3%  3.114e+08        perf-stat.i.branch-misses
     10.77 ±  5%      -4.6        6.20        perf-stat.i.cache-miss-rate%
  90573100 ±  6%     -29.7%   63695030 ±  4%  perf-stat.i.cache-misses
  8.59e+08           +23.6%  1.062e+09 ±  3%  perf-stat.i.cache-references
   6175726 ±  3%     +58.8%    9804802 ±  2%  perf-stat.i.context-switches
      4.79           -33.1%       3.20 ±  2%  perf-stat.i.cpi
    411441 ±  3%     +65.9%     682632 ±  6%  perf-stat.i.cpu-migrations
      3333 ±  6%     +52.4%       5079 ±  4%  perf-stat.i.cycles-between-cache-misses
      0.08            -0.0        0.08 ±  2%  perf-stat.i.dTLB-load-miss-rate%
  14103769           +39.0%   19602583        perf-stat.i.dTLB-load-misses
 1.813e+10           +45.7%  2.642e+10 ±  2%  perf-stat.i.dTLB-loads
      0.01 ±  4%      -0.0        0.01 ±  8%  perf-stat.i.dTLB-store-miss-rate%
 1.097e+10           +46.9%  1.612e+10        perf-stat.i.dTLB-stores
  17167651           +51.2%   25957899        perf-stat.i.iTLB-load-misses
   6491659           +70.1%   11045291 ±  6%  perf-stat.i.iTLB-loads
 6.344e+10           +46.4%   9.29e+10 ±  2%  perf-stat.i.instructions
      0.22           +46.6%       0.32 ±  2%  perf-stat.i.ipc
    411.82           +46.4%     602.85 ±  2%  perf-stat.i.metric.M/sec
      2569 ±  2%     +14.4%       2939 ±  3%  perf-stat.i.minor-faults
  25184851 ±  7%     -15.5%   21292414 ± 15%  perf-stat.i.node-load-misses
   2862951 ±  2%     -13.3%    2480788 ±  7%  perf-stat.i.node-loads
     90.43            +1.2       91.60        perf-stat.i.node-store-miss-rate%
   8837079 ±  4%     +17.3%   10368046 ±  6%  perf-stat.i.node-store-misses
      2570 ±  2%     +14.4%       2941 ±  3%  perf-stat.i.page-faults
     13.60           -16.1%      11.41        perf-stat.overall.MPKI
     10.66 ±  5%      -4.6        6.05        perf-stat.overall.cache-miss-rate%
      4.61           -32.5%       3.11 ±  2%  perf-stat.overall.cpi
      3189 ±  6%     +41.5%       4511 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.08            -0.0        0.07 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ±  3%      -0.0        0.01 ±  9%  perf-stat.overall.dTLB-store-miss-rate%
     72.72            -2.4       70.35        perf-stat.overall.iTLB-load-miss-rate%
      3674            -2.8%       3571 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.22           +48.2%       0.32 ±  2%  perf-stat.overall.ipc
 1.272e+10           +49.1%  1.896e+10 ±  2%  perf-stat.ps.branch-instructions
 2.043e+08           +51.4%  3.094e+08        perf-stat.ps.branch-misses
  90522814 ±  5%     -29.7%   63654107 ±  3%  perf-stat.ps.cache-misses
 8.489e+08           +24.0%  1.053e+09 ±  3%  perf-stat.ps.cache-references
   6061055 ±  3%     +60.0%    9699719 ±  2%  perf-stat.ps.context-switches
    396845 ±  3%     +69.0%     670636 ±  6%  perf-stat.ps.cpu-migrations
  14020909           +39.7%   19593701        perf-stat.ps.dTLB-load-misses
 1.786e+10           +46.9%  2.624e+10 ±  2%  perf-stat.ps.dTLB-loads
 1.081e+10           +48.1%  1.601e+10        perf-stat.ps.dTLB-stores
  16997675           +52.0%   25833087        perf-stat.ps.iTLB-load-misses
   6375875           +71.0%   10905261 ±  6%  perf-stat.ps.iTLB-loads
 6.244e+10           +47.7%  9.225e+10 ±  2%  perf-stat.ps.instructions
      2525 ±  2%     +15.2%       2910 ±  3%  perf-stat.ps.minor-faults
  24698062 ±  6%     -14.9%   21009262 ± 15%  perf-stat.ps.node-load-misses
   2896962 ±  2%     -12.4%    2537682 ±  7%  perf-stat.ps.node-loads
   8640562 ±  4%     +19.0%   10280989 ±  6%  perf-stat.ps.node-store-misses
      2526 ±  2%     +15.2%       2912 ±  3%  perf-stat.ps.page-faults
      1755           -31.3%       1205        interrupts.9:IO-APIC.9-fasteoi.acpi
 1.303e+08 ± 13%     -31.0%   89891349 ± 18%  interrupts.CAL:Function_call_interrupts
   1756087           -31.3%    1205651        interrupts.CPU0.LOC:Local_timer_interrupts
      1755           -31.3%       1205        interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
   1756083           -31.3%    1205641        interrupts.CPU1.LOC:Local_timer_interrupts
   1756283           -31.4%    1205637        interrupts.CPU10.LOC:Local_timer_interrupts
   3130211           +14.6%    3586704 ±  2%  interrupts.CPU10.RES:Rescheduling_interrupts
   1756032           -31.3%    1205570        interrupts.CPU100.LOC:Local_timer_interrupts
   2193714 ± 20%     -44.4%    1220194 ± 53%  interrupts.CPU101.CAL:Function_call_interrupts
   1756012           -31.3%    1205569        interrupts.CPU101.LOC:Local_timer_interrupts
   1713690 ±  5%     -36.5%    1088363 ± 44%  interrupts.CPU102.CAL:Function_call_interrupts
   1756044           -31.3%    1205539        interrupts.CPU102.LOC:Local_timer_interrupts
   1660404 ± 34%     -54.6%     753033 ± 38%  interrupts.CPU103.CAL:Function_call_interrupts
   1756050           -31.3%    1205534        interrupts.CPU103.LOC:Local_timer_interrupts
   1756187           -31.4%    1205604        interrupts.CPU11.LOC:Local_timer_interrupts
   2966878 ±  4%     +14.6%    3400360 ±  6%  interrupts.CPU11.RES:Rescheduling_interrupts
   1756030           -31.3%    1205609        interrupts.CPU12.LOC:Local_timer_interrupts
   2885830 ± 10%     +23.4%    3561488 ±  5%  interrupts.CPU12.RES:Rescheduling_interrupts
   1756038           -31.3%    1205642        interrupts.CPU13.LOC:Local_timer_interrupts
   1755967           -31.3%    1205608        interrupts.CPU14.LOC:Local_timer_interrupts
   2869980 ±  3%     +26.0%    3615978 ±  7%  interrupts.CPU14.RES:Rescheduling_interrupts
   1756056           -31.3%    1205614        interrupts.CPU15.LOC:Local_timer_interrupts
   2966138 ±  6%     +12.7%    3343478 ±  4%  interrupts.CPU15.RES:Rescheduling_interrupts
   1756030           -31.3%    1205612        interrupts.CPU16.LOC:Local_timer_interrupts
   3168638 ± 10%     +16.1%    3677516 ±  9%  interrupts.CPU16.RES:Rescheduling_interrupts
   1756080           -31.3%    1205608        interrupts.CPU17.LOC:Local_timer_interrupts
   2936901 ± 10%     +16.2%    3411368 ±  3%  interrupts.CPU17.RES:Rescheduling_interrupts
   1756057           -31.3%    1205588        interrupts.CPU18.LOC:Local_timer_interrupts
   2969000 ±  3%     +17.5%    3489665 ±  6%  interrupts.CPU18.RES:Rescheduling_interrupts
   1756069           -31.3%    1205594        interrupts.CPU19.LOC:Local_timer_interrupts
   2782993 ±  2%     +14.4%    3184389 ±  4%  interrupts.CPU19.RES:Rescheduling_interrupts
   1756028           -31.3%    1205645        interrupts.CPU2.LOC:Local_timer_interrupts
   1755968           -31.3%    1205599        interrupts.CPU20.LOC:Local_timer_interrupts
   2947698 ±  6%     +15.5%    3403935 ±  6%  interrupts.CPU20.RES:Rescheduling_interrupts
   1756098           -31.3%    1205604        interrupts.CPU21.LOC:Local_timer_interrupts
   1756007           -31.3%    1205655        interrupts.CPU22.LOC:Local_timer_interrupts
   3030421 ±  3%     +14.0%    3455529 ±  6%  interrupts.CPU22.RES:Rescheduling_interrupts
   1756298           -31.4%    1205628        interrupts.CPU23.LOC:Local_timer_interrupts
   3121273 ±  3%     +17.8%    3677020 ±  9%  interrupts.CPU23.RES:Rescheduling_interrupts
   1756010           -31.3%    1205621        interrupts.CPU24.LOC:Local_timer_interrupts
   1756021           -31.3%    1205631        interrupts.CPU25.LOC:Local_timer_interrupts
   4335710 ± 14%     -36.8%    2739263 ± 43%  interrupts.CPU26.CAL:Function_call_interrupts
   1756035           -31.3%    1205541        interrupts.CPU26.LOC:Local_timer_interrupts
   1756047           -31.3%    1205558        interrupts.CPU27.LOC:Local_timer_interrupts
   3134334 ±  3%     +14.7%    3593896 ±  7%  interrupts.CPU27.RES:Rescheduling_interrupts
   1775870 ± 12%     -44.5%     984752 ± 53%  interrupts.CPU28.CAL:Function_call_interrupts
   1756012           -31.3%    1205555        interrupts.CPU28.LOC:Local_timer_interrupts
   1756067           -31.3%    1205576        interrupts.CPU29.LOC:Local_timer_interrupts
   1755936           -31.3%    1205627        interrupts.CPU3.LOC:Local_timer_interrupts
   3100930 ±  3%     +15.9%    3595156 ±  5%  interrupts.CPU3.RES:Rescheduling_interrupts
   1756116           -31.3%    1205681        interrupts.CPU30.LOC:Local_timer_interrupts
   1756050           -31.3%    1205626        interrupts.CPU31.LOC:Local_timer_interrupts
   1756078           -31.4%    1205545        interrupts.CPU32.LOC:Local_timer_interrupts
   2028831 ± 12%     -52.4%     966184 ± 54%  interrupts.CPU33.CAL:Function_call_interrupts
   1756051           -31.3%    1205644        interrupts.CPU33.LOC:Local_timer_interrupts
   1756065           -31.3%    1205560        interrupts.CPU34.LOC:Local_timer_interrupts
   1700094 ± 22%     -45.2%     931953 ± 40%  interrupts.CPU35.CAL:Function_call_interrupts
   1756018           -31.3%    1205608        interrupts.CPU35.LOC:Local_timer_interrupts
   1756097           -31.3%    1205561        interrupts.CPU36.LOC:Local_timer_interrupts
   1900638 ± 12%     -58.7%     784528 ± 44%  interrupts.CPU37.CAL:Function_call_interrupts
   1756059           -31.3%    1205566        interrupts.CPU37.LOC:Local_timer_interrupts
   1661249 ± 18%     -48.4%     856586 ± 55%  interrupts.CPU38.CAL:Function_call_interrupts
   1756054           -31.3%    1205562        interrupts.CPU38.LOC:Local_timer_interrupts
   1756036           -31.3%    1205555        interrupts.CPU39.LOC:Local_timer_interrupts
   1756081           -31.3%    1205646        interrupts.CPU4.LOC:Local_timer_interrupts
   1756068           -31.3%    1205633        interrupts.CPU40.LOC:Local_timer_interrupts
   2224396 ±  4%     -56.3%     970965 ± 38%  interrupts.CPU41.CAL:Function_call_interrupts
   1756154           -31.3%    1205609        interrupts.CPU41.LOC:Local_timer_interrupts
   1756099           -31.3%    1205645        interrupts.CPU42.LOC:Local_timer_interrupts
   1570767 ± 25%     -43.5%     887763 ± 41%  interrupts.CPU43.CAL:Function_call_interrupts
   1756063           -31.3%    1205540        interrupts.CPU43.LOC:Local_timer_interrupts
   1899270 ± 32%     -47.8%     992296 ± 59%  interrupts.CPU44.CAL:Function_call_interrupts
   1756085           -31.3%    1205622        interrupts.CPU44.LOC:Local_timer_interrupts
   1849890 ±  9%     -41.6%    1079682 ± 54%  interrupts.CPU45.CAL:Function_call_interrupts
   1756067           -31.3%    1205568        interrupts.CPU45.LOC:Local_timer_interrupts
   1756083           -31.3%    1205556        interrupts.CPU46.LOC:Local_timer_interrupts
   2083619 ±  6%     -53.6%     966803 ± 52%  interrupts.CPU47.CAL:Function_call_interrupts
   1756159           -31.4%    1205560        interrupts.CPU47.LOC:Local_timer_interrupts
   3321506 ±  2%     +12.0%    3719213 ±  6%  interrupts.CPU47.RES:Rescheduling_interrupts
   1735617 ± 12%     -35.2%    1124501 ± 33%  interrupts.CPU48.CAL:Function_call_interrupts
   1756085           -31.3%    1205608        interrupts.CPU48.LOC:Local_timer_interrupts
   1756070           -31.3%    1205544        interrupts.CPU49.LOC:Local_timer_interrupts
   1756167           -31.3%    1205621        interrupts.CPU5.LOC:Local_timer_interrupts
   3027953           +15.0%    3481679 ±  5%  interrupts.CPU5.RES:Rescheduling_interrupts
   1756016           -31.3%    1205609        interrupts.CPU50.LOC:Local_timer_interrupts
   1588161 ± 21%     -45.2%     871046 ± 34%  interrupts.CPU51.CAL:Function_call_interrupts
   1756163           -31.3%    1205628        interrupts.CPU51.LOC:Local_timer_interrupts
   1755990           -31.3%    1205570        interrupts.CPU52.LOC:Local_timer_interrupts
   1756046           -31.3%    1205565        interrupts.CPU53.LOC:Local_timer_interrupts
   2716149 ±  7%     +21.0%    3287450 ±  9%  interrupts.CPU53.RES:Rescheduling_interrupts
   1756063           -31.3%    1205586        interrupts.CPU54.LOC:Local_timer_interrupts
   1756003           -31.3%    1205592        interrupts.CPU55.LOC:Local_timer_interrupts
   3041413 ±  5%     +21.0%    3681265 ±  4%  interrupts.CPU55.RES:Rescheduling_interrupts
   1756173           -31.3%    1205653        interrupts.CPU56.LOC:Local_timer_interrupts
   3120053 ±  8%     +11.9%    3492355 ±  5%  interrupts.CPU56.RES:Rescheduling_interrupts
   1756039           -31.3%    1205600        interrupts.CPU57.LOC:Local_timer_interrupts
   1756021           -31.3%    1205585        interrupts.CPU58.LOC:Local_timer_interrupts
   2920530 ±  7%     +12.7%    3292319 ±  6%  interrupts.CPU58.RES:Rescheduling_interrupts
   1756023           -31.3%    1205592        interrupts.CPU59.LOC:Local_timer_interrupts
   1756033           -31.3%    1205626        interrupts.CPU6.LOC:Local_timer_interrupts
   1756029           -31.3%    1205605        interrupts.CPU60.LOC:Local_timer_interrupts
   2573666 ±  7%     +34.0%    3447925 ± 11%  interrupts.CPU60.RES:Rescheduling_interrupts
   1756033           -31.3%    1205600        interrupts.CPU61.LOC:Local_timer_interrupts
   3064524 ±  2%     +20.4%    3688455 ± 10%  interrupts.CPU61.RES:Rescheduling_interrupts
   1756011           -31.3%    1205607        interrupts.CPU62.LOC:Local_timer_interrupts
   1756034           -31.3%    1205597        interrupts.CPU63.LOC:Local_timer_interrupts
   2857476 ±  6%     +16.5%    3329589 ±  6%  interrupts.CPU63.RES:Rescheduling_interrupts
   1756039           -31.3%    1205619        interrupts.CPU64.LOC:Local_timer_interrupts
   1756011           -31.3%    1205621        interrupts.CPU65.LOC:Local_timer_interrupts
   1756032           -31.3%    1205711        interrupts.CPU66.LOC:Local_timer_interrupts
   3025406 ±  6%     +18.9%    3597977 ± 10%  interrupts.CPU66.RES:Rescheduling_interrupts
   1756037           -31.3%    1205625        interrupts.CPU67.LOC:Local_timer_interrupts
   2925726 ±  4%     +16.7%    3415111 ±  5%  interrupts.CPU67.RES:Rescheduling_interrupts
   1756040           -31.3%    1205569        interrupts.CPU68.LOC:Local_timer_interrupts
   2892746 ±  5%     +18.1%    3416078 ±  8%  interrupts.CPU68.RES:Rescheduling_interrupts
   1755976           -31.3%    1205639        interrupts.CPU69.LOC:Local_timer_interrupts
   1756062           -31.3%    1205657        interrupts.CPU7.LOC:Local_timer_interrupts
   2757608 ±  2%     +19.8%    3303249 ±  5%  interrupts.CPU7.RES:Rescheduling_interrupts
   1756014           -31.3%    1205689        interrupts.CPU70.LOC:Local_timer_interrupts
   1756028           -31.3%    1205544        interrupts.CPU71.LOC:Local_timer_interrupts
   2874234 ±  3%     +16.5%    3349906 ±  4%  interrupts.CPU71.RES:Rescheduling_interrupts
   1756053           -31.3%    1205643        interrupts.CPU72.LOC:Local_timer_interrupts
   1756051           -31.3%    1205653        interrupts.CPU73.LOC:Local_timer_interrupts
   1756002           -31.3%    1205609        interrupts.CPU74.LOC:Local_timer_interrupts
   2994525 ±  9%     +17.2%    3510382 ±  9%  interrupts.CPU74.RES:Rescheduling_interrupts
   1756006           -31.3%    1205610        interrupts.CPU75.LOC:Local_timer_interrupts
   3070769 ±  3%     +20.0%    3684382 ±  5%  interrupts.CPU75.RES:Rescheduling_interrupts
   1756026           -31.3%    1205626        interrupts.CPU76.LOC:Local_timer_interrupts
   1756039           -31.3%    1205618        interrupts.CPU77.LOC:Local_timer_interrupts
   4859129 ± 10%     -52.9%    2288910 ± 46%  interrupts.CPU78.CAL:Function_call_interrupts
   1756010           -31.3%    1205573        interrupts.CPU78.LOC:Local_timer_interrupts
   2448504 ± 14%     -57.7%    1036604 ± 45%  interrupts.CPU79.CAL:Function_call_interrupts
   1756068           -31.3%    1205615        interrupts.CPU79.LOC:Local_timer_interrupts
   1756007           -31.3%    1205598        interrupts.CPU8.LOC:Local_timer_interrupts
   2944757 ±  3%     +21.9%    3589350 ±  7%  interrupts.CPU8.RES:Rescheduling_interrupts
   1704443 ± 12%     -51.3%     830489 ± 40%  interrupts.CPU80.CAL:Function_call_interrupts
   1756090           -31.3%    1205586        interrupts.CPU80.LOC:Local_timer_interrupts
   1756119           -31.4%    1205553        interrupts.CPU81.LOC:Local_timer_interrupts
   1951835 ± 20%     -47.0%    1034865 ± 32%  interrupts.CPU82.CAL:Function_call_interrupts
   1756134           -31.4%    1205574        interrupts.CPU82.LOC:Local_timer_interrupts
   1756078           -31.3%    1205620        interrupts.CPU83.LOC:Local_timer_interrupts
   1837507 ± 31%     -51.7%     886753 ± 50%  interrupts.CPU84.CAL:Function_call_interrupts
   1756088           -31.3%    1205595        interrupts.CPU84.LOC:Local_timer_interrupts
   2088115 ± 16%     -61.4%     805593 ± 48%  interrupts.CPU85.CAL:Function_call_interrupts
   1756056           -31.3%    1205568        interrupts.CPU85.LOC:Local_timer_interrupts
   2016702 ± 33%     -63.2%     741626 ± 43%  interrupts.CPU86.CAL:Function_call_interrupts
   1756042           -31.3%    1205556        interrupts.CPU86.LOC:Local_timer_interrupts
   1756147           -31.4%    1205588        interrupts.CPU87.LOC:Local_timer_interrupts
   3362776 ±  2%     +13.6%    3819022 ±  3%  interrupts.CPU87.RES:Rescheduling_interrupts
   1756143           -31.3%    1205634        interrupts.CPU88.LOC:Local_timer_interrupts
   3217725 ±  7%     +10.5%    3554878 ±  4%  interrupts.CPU88.RES:Rescheduling_interrupts
   1972919 ± 32%     -66.3%     663970 ± 44%  interrupts.CPU89.CAL:Function_call_interrupts
   1756070           -31.3%    1205618        interrupts.CPU89.LOC:Local_timer_interrupts
   3189844 ±  4%      +9.9%    3506043 ±  4%  interrupts.CPU89.RES:Rescheduling_interrupts
   1756034           -31.3%    1205624        interrupts.CPU9.LOC:Local_timer_interrupts
   1734960 ± 19%     -53.4%     808272 ± 42%  interrupts.CPU90.CAL:Function_call_interrupts
   1756122           -31.3%    1205711        interrupts.CPU90.LOC:Local_timer_interrupts
   1818256           -42.8%    1039860 ± 51%  interrupts.CPU91.CAL:Function_call_interrupts
   1756039           -31.3%    1205569        interrupts.CPU91.LOC:Local_timer_interrupts
   2060769 ± 12%     -52.1%     987566 ± 45%  interrupts.CPU92.CAL:Function_call_interrupts
   1756061           -31.3%    1205564        interrupts.CPU92.LOC:Local_timer_interrupts
   1978905 ±  9%     -51.0%     969386 ± 39%  interrupts.CPU93.CAL:Function_call_interrupts
   1756138           -31.4%    1205583        interrupts.CPU93.LOC:Local_timer_interrupts
   3177803 ±  8%     +19.6%    3802054 ±  9%  interrupts.CPU93.RES:Rescheduling_interrupts
   1756068           -31.3%    1205561        interrupts.CPU94.LOC:Local_timer_interrupts
   3054954 ±  8%     +19.8%    3658583 ± 16%  interrupts.CPU94.RES:Rescheduling_interrupts
   1765762 ± 24%     -56.9%     760270 ± 37%  interrupts.CPU95.CAL:Function_call_interrupts
   1756126           -31.4%    1205530        interrupts.CPU95.LOC:Local_timer_interrupts
   1756081           -31.3%    1205578        interrupts.CPU96.LOC:Local_timer_interrupts
   1756089           -31.3%    1205573        interrupts.CPU97.LOC:Local_timer_interrupts
   3015595 ±  2%     +13.8%    3430508 ±  7%  interrupts.CPU97.RES:Rescheduling_interrupts
   1912617 ± 22%     -51.6%     925102 ± 52%  interrupts.CPU98.CAL:Function_call_interrupts
   1756082           -31.3%    1205586        interrupts.CPU98.LOC:Local_timer_interrupts
   1907270 ± 22%     -43.2%    1082601 ± 43%  interrupts.CPU99.CAL:Function_call_interrupts
   1756075           -31.3%    1205570        interrupts.CPU99.LOC:Local_timer_interrupts
 1.826e+08           -31.3%  1.254e+08        interrupts.LOC:Local_timer_interrupts
    208.00           -50.0%     104.00        interrupts.MCP:Machine_check_polls
 3.278e+08            +9.8%  3.601e+08        interrupts.RES:Rescheduling_interrupts
      5.90 ± 20%      -4.3        1.57 ± 10%  perf-profile.calltrace.cycles-pp.mod_objcg_state.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      3.67 ± 13%      -2.4        1.24 ±  9%  perf-profile.calltrace.cycles-pp.mod_objcg_state.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     35.11 ±  4%      -1.9       33.25        perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read
     35.32 ±  4%      -1.8       33.49        perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read.ksys_read
     36.03 ±  3%      -1.7       34.36        perf-profile.calltrace.cycles-pp.sock_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
     36.32 ±  3%      -1.6       34.69        perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.24 ±  3%      -1.5       35.77        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     37.82 ±  3%      -1.3       36.47        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     44.56            -1.2       43.41        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     52.26            -0.9       51.33        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     52.40            -0.9       51.50        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write
      0.82 ± 20%      -0.6        0.26 ±100%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     54.68            -0.4       54.25        perf-profile.calltrace.cycles-pp.__libc_write
      0.60 ± 12%      +0.1        0.74 ±  9%  perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.drain_obj_stock.refill_obj_stock.kmem_cache_free.unix_stream_read_generic
      0.62 ±  9%      +0.1        0.76 ±  4%  perf-profile.calltrace.cycles-pp.sock_wfree.unix_destruct_scm.skb_release_head_state.skb_release_all.consume_skb
      0.65 ± 15%      +0.2        0.82 ±  2%  perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_write
      0.66 ± 13%      +0.2        0.84 ±  3%  perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_read
      0.71 ± 15%      +0.2        0.90 ±  2%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__libc_write
      0.82 ± 20%      +0.2        1.01 ±  3%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      0.74 ± 15%      +0.2        0.92 ±  3%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__libc_read
      0.71 ±  7%      +0.2        0.91 ± 10%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      0.76 ± 11%      +0.2        0.97 ±  2%  perf-profile.calltrace.cycles-pp.unix_destruct_scm.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic
      0.35 ± 70%      +0.2        0.56 ±  3%  perf-profile.calltrace.cycles-pp._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      0.80 ± 11%      +0.2        1.01 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      0.81 ± 11%      +0.2        1.03 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.35 ± 70%      +0.2        0.57 ±  5%  perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      0.35 ± 70%      +0.3        0.62 ±  4%  perf-profile.calltrace.cycles-pp.check_preempt_curr.ttwu_do_wakeup.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.36 ± 70%      +0.3        0.63 ±  4%  perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.37 ± 70%      +0.3        0.64 ±  4%  perf-profile.calltrace.cycles-pp.ttwu_do_wakeup.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.36 ± 70%      +0.3        0.64 ±  4%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      0.84 ± 11%      +0.3        1.12 ±  8%  perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.drain_obj_stock.refill_obj_stock.kfree.consume_skb
      0.36 ± 70%      +0.3        0.66 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.90 ± 19%      +0.3        1.24 ±  3%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      0.48 ± 70%      +0.4        0.85 ±  3%  perf-profile.calltrace.cycles-pp.prepare_to_wait.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      1.05 ± 16%      +0.4        1.50 ±  7%  perf-profile.calltrace.cycles-pp.drain_obj_stock.refill_obj_stock.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
      0.00            +0.5        0.55 ±  5%  perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      0.00            +0.7        0.67 ± 10%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve
      1.42 ± 16%      +0.7        2.16 ±  7%  perf-profile.calltrace.cycles-pp.drain_obj_stock.refill_obj_stock.kfree.consume_skb.unix_stream_read_generic
      3.65 ± 23%      +0.8        4.50 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      2.29 ± 26%      +1.0        3.25 ±  6%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      5.22 ± 26%      +1.9        7.15 ±  5%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     13.43 ± 13%     -10.1        3.32 ± 10%  perf-profile.children.cycles-pp.mod_objcg_state
      4.19 ±  7%      -4.0        0.16 ± 16%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      3.96 ±  8%      -3.8        0.11 ± 24%  perf-profile.children.cycles-pp.__mod_memcg_state
     35.15 ±  4%      -1.9       33.29        perf-profile.children.cycles-pp.unix_stream_read_generic
     35.33 ±  4%      -1.8       33.50        perf-profile.children.cycles-pp.unix_stream_recvmsg
     36.05 ±  3%      -1.7       34.38        perf-profile.children.cycles-pp.sock_read_iter
     36.33 ±  3%      -1.6       34.72        perf-profile.children.cycles-pp.new_sync_read
     37.25 ±  3%      -1.5       35.78        perf-profile.children.cycles-pp.vfs_read
     93.98            -1.4       92.63        perf-profile.children.cycles-pp.do_syscall_64
     37.84 ±  3%      -1.3       36.50        perf-profile.children.cycles-pp.ksys_read
     94.32            -1.3       93.03        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     44.58            -1.2       43.42        perf-profile.children.cycles-pp.vfs_write
     54.81            -0.4       54.41        perf-profile.children.cycles-pp.__libc_write
      0.13 ±  9%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.06 ± 13%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.08 ± 10%      +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.09 ±  9%      +0.0        0.11 ±  5%  perf-profile.children.cycles-pp.__x64_sys_write
      0.09 ±  9%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__list_add_valid
      0.08 ± 20%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.apparmor_socket_sendmsg
      0.10 ± 19%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.apparmor_socket_recvmsg
      0.08 ± 12%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.20            +0.0        0.23 ±  4%  perf-profile.children.cycles-pp.preempt_schedule_common
      0.08 ± 17%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__x64_sys_read
      0.03 ± 70%      +0.0        0.07 ± 10%  perf-profile.children.cycles-pp.check_cfs_rq_runtime
      0.34 ±  3%      +0.0        0.38 ±  5%  perf-profile.children.cycles-pp.cpuacct_charge
      0.03 ± 70%      +0.0        0.08 ± 16%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.07 ± 71%      +0.0        0.11 ±  9%  perf-profile.children.cycles-pp.ktime_get
      0.09 ± 25%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.rb_insert_color
      0.20 ±  6%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.unix_write_space
      0.22 ± 10%      +0.0        0.27 ±  7%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.13 ±  7%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.wait_for_unix_gc
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.kmalloc_slab
      0.36 ±  3%      +0.1        0.41        perf-profile.children.cycles-pp.__cond_resched
      0.25 ± 16%      +0.1        0.30 ±  3%  perf-profile.children.cycles-pp.update_min_vruntime
      0.36 ± 11%      +0.1        0.41 ±  3%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.27 ± 13%      +0.1        0.33 ±  4%  perf-profile.children.cycles-pp.__check_heap_object
      0.06 ± 14%      +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.wakeup_preempt_entity
      0.11 ±  4%      +0.1        0.18 ± 10%  perf-profile.children.cycles-pp.skb_release_data
      0.16 ± 21%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.mutex_unlock
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.put_pid
      0.28 ± 18%      +0.1        0.34 ±  5%  perf-profile.children.cycles-pp.copyin
      0.14 ± 15%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.__ksize
      0.34 ±  9%      +0.1        0.40 ±  5%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.22 ± 23%      +0.1        0.29        perf-profile.children.cycles-pp.fput_many
      0.18 ± 16%      +0.1        0.25 ±  5%  perf-profile.children.cycles-pp.skb_unlink
      0.18 ± 12%      +0.1        0.25 ±  4%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.13 ± 20%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.rb_erase
      0.40 ± 11%      +0.1        0.48 ±  3%  perf-profile.children.cycles-pp.sock_recvmsg
      0.34 ± 22%      +0.1        0.41 ±  3%  perf-profile.children.cycles-pp.__pthread_disable_asynccancel
      0.17 ±  7%      +0.1        0.25 ±  9%  perf-profile.children.cycles-pp.__build_skb_around
      0.49 ±  8%      +0.1        0.57 ±  4%  perf-profile.children.cycles-pp.common_file_perm
      0.49 ± 12%      +0.1        0.57 ±  3%  perf-profile.children.cycles-pp._copy_from_iter
      0.18 ± 24%      +0.1        0.27 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.42 ± 21%      +0.1        0.51        perf-profile.children.cycles-pp.mutex_lock
      0.33 ±  9%      +0.1        0.43 ±  7%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.36 ±  6%      +0.1        0.46 ± 11%  perf-profile.children.cycles-pp.__slab_free
      0.30 ± 15%      +0.1        0.40 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.37 ± 18%      +0.1        0.47 ±  6%  perf-profile.children.cycles-pp.check_preempt_wakeup
      0.23 ± 10%      +0.1        0.34 ±  9%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.36 ± 15%      +0.1        0.47 ±  4%  perf-profile.children.cycles-pp.skb_queue_tail
      0.42 ±  5%      +0.1        0.55 ±  5%  perf-profile.children.cycles-pp.copyout
      0.43 ± 22%      +0.1        0.55 ±  3%  perf-profile.children.cycles-pp.__enqueue_entity
      0.62 ±  9%      +0.1        0.76 ±  4%  perf-profile.children.cycles-pp.sock_wfree
      0.58 ± 15%      +0.1        0.72 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.47 ± 21%      +0.2        0.63 ±  3%  perf-profile.children.cycles-pp.check_preempt_curr
      0.50 ± 20%      +0.2        0.66 ±  4%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.61 ± 14%      +0.2        0.78 ±  4%  perf-profile.children.cycles-pp.__fget_files
      0.63 ± 22%      +0.2        0.82 ±  4%  perf-profile.children.cycles-pp.set_next_entity
      0.67 ± 10%      +0.2        0.86 ±  3%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.50 ± 19%      +0.2        0.69 ±  6%  perf-profile.children.cycles-pp.update_cfs_group
      0.84 ± 13%      +0.2        1.04 ±  2%  perf-profile.children.cycles-pp.__fget_light
      0.86 ± 13%      +0.2        1.06 ±  2%  perf-profile.children.cycles-pp.__fdget_pos
      0.65 ± 17%      +0.2        0.86 ±  4%  perf-profile.children.cycles-pp.prepare_to_wait
      0.78 ± 12%      +0.2        1.00 ±  2%  perf-profile.children.cycles-pp.unix_destruct_scm
      0.80 ± 11%      +0.2        1.02 ±  2%  perf-profile.children.cycles-pp.skb_release_head_state
      0.81 ± 11%      +0.2        1.03        perf-profile.children.cycles-pp.skb_release_all
      0.48 ± 15%      +0.3        0.76 ±  7%  perf-profile.children.cycles-pp.page_counter_cancel
      0.61 ± 14%      +0.3        0.94 ±  7%  perf-profile.children.cycles-pp.page_counter_uncharge
      1.50 ± 12%      +0.4        1.86 ±  8%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.68 ± 13%      +0.4        1.06 ±  9%  perf-profile.children.cycles-pp.page_counter_try_charge
      1.65 ± 14%      +0.4        2.05 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.50 ±  7%      +0.4        1.91 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.51 ± 14%      +0.4        1.92 ±  2%  perf-profile.children.cycles-pp.__entry_text_start
      2.58 ± 17%      +1.1        3.66 ±  7%  perf-profile.children.cycles-pp.drain_obj_stock
      7.55 ± 26%      +2.9       10.46 ±  5%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      9.13 ± 22%      -6.0        3.14 ± 10%  perf-profile.self.cycles-pp.mod_objcg_state
      3.95 ±  8%      -3.8        0.11 ± 24%  perf-profile.self.cycles-pp.__mod_memcg_state
      1.49 ± 21%      -1.4        0.10 ±  3%  perf-profile.self.cycles-pp.refill_obj_stock
      0.12 ±  7%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.06            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.sock_sendmsg
      0.09 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__list_add_valid
      0.08 ± 17%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.apparmor_socket_recvmsg
      0.11 ±  7%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp._copy_from_iter
      0.09 ± 14%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.07 ± 12%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__x64_sys_read
      0.03 ± 70%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.sock_recvmsg
      0.11 ± 12%      +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.07 ± 11%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.ksys_write
      0.11 ± 19%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.ksys_read
      0.14 ± 10%      +0.0        0.18 ± 10%  perf-profile.self.cycles-pp.__wake_up_common
      0.06 ± 72%      +0.0        0.10 ± 10%  perf-profile.self.cycles-pp.ktime_get
      0.26 ± 10%      +0.0        0.30 ±  3%  perf-profile.self.cycles-pp.sock_write_iter
      0.33 ±  5%      +0.0        0.38 ±  5%  perf-profile.self.cycles-pp.cpuacct_charge
      0.18 ± 19%      +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.__libc_write
      0.09 ± 25%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.rb_insert_color
      0.22 ± 10%      +0.0        0.27 ±  8%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.18 ±  7%      +0.0        0.23 ±  4%  perf-profile.self.cycles-pp.__libc_read
      0.10 ± 29%      +0.0        0.15 ±  6%  perf-profile.self.cycles-pp.check_preempt_curr
      0.16 ± 12%      +0.0        0.21 ±  7%  perf-profile.self.cycles-pp.check_preempt_wakeup
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.kmalloc_slab
      0.21 ± 17%      +0.1        0.26 ±  6%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.check_cfs_rq_runtime
      0.15 ± 20%      +0.1        0.21 ±  6%  perf-profile.self.cycles-pp.unix_destruct_scm
      0.09 ±  5%      +0.1        0.15 ± 17%  perf-profile.self.cycles-pp.__build_skb_around
      0.17 ± 17%      +0.1        0.22 ±  3%  perf-profile.self.cycles-pp.unix_write_space
      0.24 ± 15%      +0.1        0.30 ±  2%  perf-profile.self.cycles-pp.update_min_vruntime
      0.27 ± 13%      +0.1        0.33 ±  4%  perf-profile.self.cycles-pp.__check_heap_object
      0.22 ± 12%      +0.1        0.27 ±  7%  perf-profile.self.cycles-pp.aa_sk_perm
      0.15 ± 20%      +0.1        0.21 ±  3%  perf-profile.self.cycles-pp.mutex_unlock
      0.14 ± 13%      +0.1        0.20 ±  4%  perf-profile.self.cycles-pp.__ksize
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.wait_for_unix_gc
      0.16 ± 10%      +0.1        0.22 ±  5%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.11 ±  7%      +0.1        0.17 ±  9%  perf-profile.self.cycles-pp.skb_release_data
      0.22 ± 22%      +0.1        0.28        perf-profile.self.cycles-pp.fput_many
      0.25 ± 11%      +0.1        0.32 ±  2%  perf-profile.self.cycles-pp.__alloc_skb
      0.28 ± 24%      +0.1        0.35        perf-profile.self.cycles-pp.mutex_lock
      0.12 ± 23%      +0.1        0.19 ±  4%  perf-profile.self.cycles-pp.rb_erase
      0.32 ± 23%      +0.1        0.39 ±  3%  perf-profile.self.cycles-pp.__pthread_disable_asynccancel
      0.17 ± 19%      +0.1        0.24 ±  5%  perf-profile.self.cycles-pp.dequeue_entity
      0.05 ± 70%      +0.1        0.12 ±  9%  perf-profile.self.cycles-pp.wakeup_preempt_entity
      0.25 ±  9%      +0.1        0.33 ±  3%  perf-profile.self.cycles-pp.sock_def_readable
      0.38 ±  9%      +0.1        0.46 ±  6%  perf-profile.self.cycles-pp.common_file_perm
      0.30 ± 14%      +0.1        0.38 ±  3%  perf-profile.self.cycles-pp.sock_read_iter
      0.60 ±  8%      +0.1        0.69 ±  2%  perf-profile.self.cycles-pp.unix_stream_sendmsg
      0.38 ± 12%      +0.1        0.46 ±  3%  perf-profile.self.cycles-pp.try_to_wake_up
      0.46 ± 15%      +0.1        0.56 ±  3%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.41 ± 11%      +0.1        0.50 ±  7%  perf-profile.self.cycles-pp.sock_wfree
      0.33 ± 10%      +0.1        0.42 ±  7%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.32 ± 21%      +0.1        0.42 ±  2%  perf-profile.self.cycles-pp.prepare_to_wait
      0.32 ± 24%      +0.1        0.42 ±  3%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.35 ±  6%      +0.1        0.46 ± 11%  perf-profile.self.cycles-pp.__slab_free
      0.23 ± 12%      +0.1        0.34 ±  9%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.50 ± 24%      +0.1        0.62 ±  4%  perf-profile.self.cycles-pp.update_rq_clock
      0.41 ± 22%      +0.1        0.55 ±  3%  perf-profile.self.cycles-pp.__enqueue_entity
      0.57 ± 15%      +0.1        0.71 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.60 ± 13%      +0.2        0.76 ±  4%  perf-profile.self.cycles-pp.__fget_files
      0.49 ± 19%      +0.2        0.68 ±  6%  perf-profile.self.cycles-pp.update_cfs_group
      0.66 ± 11%      +0.2        0.84 ±  3%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      1.14 ± 16%      +0.3        1.40 ±  4%  perf-profile.self.cycles-pp.__schedule
      0.94 ± 17%      +0.3        1.19 ±  2%  perf-profile.self.cycles-pp.update_curr
      0.48 ± 15%      +0.3        0.76 ±  8%  perf-profile.self.cycles-pp.page_counter_cancel
      0.57 ± 13%      +0.3        0.89 ±  8%  perf-profile.self.cycles-pp.page_counter_try_charge
      1.31 ± 14%      +0.4        1.68 ±  2%  perf-profile.self.cycles-pp.__entry_text_start
      1.65 ± 14%      +0.4        2.05 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.34 ± 17%      +0.4        1.78 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.71 ± 20%      +0.5        2.17 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      1.08 ± 23%      +0.7        1.76 ±  7%  perf-profile.self.cycles-pp.drain_obj_stock
      2.35 ± 10%      +2.1        4.44 ±  7%  perf-profile.self.cycles-pp.kmem_cache_free
      7.40 ± 26%      +2.9       10.27 ±  5%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      2.60 ± 12%      +3.9        6.50 ±  5%  perf-profile.self.cycles-pp.kfree
    109386           -24.7%      82383        softirqs.CPU0.RCU
     15341 ±  5%     -22.1%      11946 ±  8%  softirqs.CPU0.SCHED
    113388           -26.0%      83901        softirqs.CPU1.RCU
     12942 ±  7%     -18.6%      10530 ±  9%  softirqs.CPU1.SCHED
    111188           -25.6%      82690        softirqs.CPU10.RCU
     11168 ±  2%     -23.0%       8595 ±  5%  softirqs.CPU10.SCHED
    109889           -26.3%      81004        softirqs.CPU100.RCU
     14260 ±  5%     -29.7%      10023 ± 14%  softirqs.CPU100.SCHED
    109411           -26.2%      80721        softirqs.CPU101.RCU
     14045 ±  8%     -31.3%       9652 ± 12%  softirqs.CPU101.SCHED
    109913           -25.6%      81743        softirqs.CPU102.RCU
     13603 ± 12%     -30.4%       9461 ± 12%  softirqs.CPU102.SCHED
    110978           -26.5%      81567        softirqs.CPU103.RCU
     14320 ±  7%     -27.5%      10377 ± 13%  softirqs.CPU103.SCHED
    113121 ±  2%     -26.1%      83547        softirqs.CPU11.RCU
     11268 ±  2%     -22.6%       8718 ±  7%  softirqs.CPU11.SCHED
    113553           -26.2%      83780        softirqs.CPU12.RCU
     11282 ±  3%     -24.2%       8551 ±  7%  softirqs.CPU12.SCHED
    112337 ±  2%     -26.2%      82874 ±  2%  softirqs.CPU13.RCU
     11479 ±  2%     -24.1%       8707 ±  7%  softirqs.CPU13.SCHED
    112127           -29.0%      79623 ±  9%  softirqs.CPU14.RCU
     11495 ±  2%     -23.8%       8757 ±  8%  softirqs.CPU14.SCHED
    126475 ±  2%     -27.8%      91367        softirqs.CPU15.RCU
     11571 ±  2%     -27.1%       8433 ±  6%  softirqs.CPU15.SCHED
    125147           -26.8%      91569        softirqs.CPU16.RCU
     11050 ±  5%     -23.8%       8422 ±  5%  softirqs.CPU16.SCHED
    126468           -28.5%      90429 ±  5%  softirqs.CPU17.RCU
     10891 ±  3%     -21.8%       8511 ±  7%  softirqs.CPU17.SCHED
    126847           -27.0%      92542        softirqs.CPU18.RCU
     10796 ±  3%     -20.3%       8609 ±  9%  softirqs.CPU18.SCHED
    127636           -27.0%      93207        softirqs.CPU19.RCU
     11135 ±  2%     -20.4%       8866 ±  6%  softirqs.CPU19.SCHED
    112062 ±  2%     -25.5%      83467        softirqs.CPU2.RCU
     11754           -22.2%       9144 ±  7%  softirqs.CPU2.SCHED
    113957 ± 11%     -20.2%      90907        softirqs.CPU20.RCU
     11197 ±  6%     -20.4%       8915 ± 10%  softirqs.CPU20.SCHED
    125383 ±  2%     -27.4%      91022        softirqs.CPU21.RCU
     11275 ±  3%     -26.4%       8302 ±  4%  softirqs.CPU21.SCHED
    124972 ±  2%     -27.9%      90088 ±  4%  softirqs.CPU22.RCU
     11370 ±  3%     -23.6%       8682 ±  5%  softirqs.CPU22.SCHED
    126353 ±  2%     -27.6%      91532        softirqs.CPU23.RCU
     11324 ±  3%     -24.5%       8545 ±  6%  softirqs.CPU23.SCHED
    126661 ±  2%     -26.9%      92532        softirqs.CPU24.RCU
     11120 ±  4%     -21.9%       8682 ±  7%  softirqs.CPU24.SCHED
    126860           -28.5%      90745 ±  6%  softirqs.CPU25.RCU
     10945           -20.9%       8656 ±  6%  softirqs.CPU25.SCHED
    110300           -26.6%      80912        softirqs.CPU26.RCU
     12543 ±  8%     -23.1%       9647 ± 12%  softirqs.CPU26.SCHED
    110556           -26.7%      81056        softirqs.CPU27.RCU
     14373 ± 13%     -29.9%      10080 ± 12%  softirqs.CPU27.SCHED
    111033           -27.2%      80849        softirqs.CPU28.RCU
     14005 ±  7%     -33.5%       9318 ± 16%  softirqs.CPU28.SCHED
    104861 ±  8%     -22.4%      81348        softirqs.CPU29.RCU
     14384 ±  5%     -31.6%       9837 ±  9%  softirqs.CPU29.SCHED
    112140 ±  2%     -26.3%      82656 ±  2%  softirqs.CPU3.RCU
     11745 ±  3%     -25.8%       8719 ±  5%  softirqs.CPU3.SCHED
    114089           -26.4%      83915        softirqs.CPU30.RCU
     14207 ±  5%     -33.6%       9430 ±  9%  softirqs.CPU30.SCHED
    113403 ±  2%     -25.2%      84800 ±  2%  softirqs.CPU31.RCU
     13544 ±  4%     -29.0%       9622 ± 12%  softirqs.CPU31.SCHED
    114790           -28.7%      81832 ±  8%  softirqs.CPU32.RCU
     14011 ±  6%     -30.6%       9722 ± 10%  softirqs.CPU32.SCHED
    114298           -26.8%      83675        softirqs.CPU33.RCU
     14702 ±  7%     -36.1%       9401 ± 11%  softirqs.CPU33.SCHED
    114243 ±  2%     -25.9%      84672        softirqs.CPU34.RCU
     13441 ±  5%     -28.9%       9561 ± 17%  softirqs.CPU34.SCHED
    115097 ±  2%     -26.5%      84570        softirqs.CPU35.RCU
     14226 ±  6%     -33.2%       9508 ± 12%  softirqs.CPU35.SCHED
    115565 ±  2%     -27.2%      84118        softirqs.CPU36.RCU
     13705 ± 11%     -28.6%       9782 ± 16%  softirqs.CPU36.SCHED
    116062 ±  3%     -26.7%      85110        softirqs.CPU37.RCU
     14157 ±  9%     -32.3%       9587 ± 15%  softirqs.CPU37.SCHED
    116212 ±  2%     -26.6%      85245 ±  2%  softirqs.CPU38.RCU
     13646 ±  9%     -30.9%       9434 ± 13%  softirqs.CPU38.SCHED
    114536           -26.5%      84202        softirqs.CPU39.RCU
     13891 ±  5%     -30.4%       9671 ± 11%  softirqs.CPU39.SCHED
    107336 ±  8%     -22.0%      83756 ±  3%  softirqs.CPU4.RCU
     11885 ±  3%     -26.3%       8758 ±  6%  softirqs.CPU4.SCHED
    114987           -26.4%      84595        softirqs.CPU40.RCU
     14076 ± 12%     -31.6%       9627 ± 15%  softirqs.CPU40.SCHED
    114484 ±  2%     -27.0%      83591        softirqs.CPU41.RCU
     13850 ±  6%     -35.9%       8874 ±  8%  softirqs.CPU41.SCHED
    116063           -27.1%      84667 ±  2%  softirqs.CPU42.RCU
     14224 ±  8%     -33.0%       9534 ± 17%  softirqs.CPU42.SCHED
    115606           -26.1%      85428 ±  2%  softirqs.CPU43.RCU
     13433 ±  3%     -32.0%       9135 ±  9%  softirqs.CPU43.SCHED
    115318 ±  2%     -26.7%      84516 ±  2%  softirqs.CPU44.RCU
     14774 ±  5%     -36.0%       9459 ± 13%  softirqs.CPU44.SCHED
    116588 ±  2%     -26.5%      85668        softirqs.CPU45.RCU
     13793 ± 10%     -29.3%       9758 ± 19%  softirqs.CPU45.SCHED
    115365           -26.7%      84519        softirqs.CPU46.RCU
     13898 ±  8%     -32.1%       9430 ± 11%  softirqs.CPU46.SCHED
    115826           -27.3%      84197        softirqs.CPU47.RCU
     13557 ±  5%     -27.1%       9879 ± 18%  softirqs.CPU47.SCHED
    115566           -27.2%      84157        softirqs.CPU48.RCU
     13896 ±  7%     -31.7%       9486 ± 15%  softirqs.CPU48.SCHED
    115762           -26.9%      84677        softirqs.CPU49.RCU
     14081 ±  5%     -31.2%       9683 ± 12%  softirqs.CPU49.SCHED
    112583           -26.2%      83127        softirqs.CPU5.RCU
     11497 ±  3%     -24.7%       8662 ±  6%  softirqs.CPU5.SCHED
    116177           -27.2%      84627        softirqs.CPU50.RCU
     13451 ± 13%     -31.8%       9172 ± 11%  softirqs.CPU50.SCHED
    116569           -26.6%      85517        softirqs.CPU51.RCU
     14579 ±  5%     -29.8%      10235 ± 18%  softirqs.CPU51.SCHED
    120241 ±  2%     -25.5%      89582 ±  2%  softirqs.CPU52.RCU
     10709 ±  3%     -22.8%       8268 ±  5%  softirqs.CPU52.SCHED
    123731 ±  2%     -26.0%      91542 ±  2%  softirqs.CPU53.RCU
     11339 ±  4%     -24.5%       8564 ±  4%  softirqs.CPU53.SCHED
    122537 ±  2%     -25.0%      91896 ±  2%  softirqs.CPU54.RCU
     11006 ±  9%     -31.3%       7566 ±  4%  softirqs.CPU54.SCHED
    124865 ±  2%     -26.6%      91657 ±  3%  softirqs.CPU55.RCU
     11073 ±  5%     -24.7%       8339 ±  5%  softirqs.CPU55.SCHED
     11530 ±  3%     -25.5%       8593 ±  5%  softirqs.CPU56.SCHED
    124438 ±  2%     -26.2%      91852        softirqs.CPU57.RCU
     10909 ±  3%     -22.1%       8502 ±  5%  softirqs.CPU57.SCHED
    125889 ±  2%     -25.7%      93510 ±  2%  softirqs.CPU58.RCU
     11441 ±  4%     -23.4%       8769 ±  7%  softirqs.CPU58.SCHED
    122714           -29.1%      87046 ± 10%  softirqs.CPU59.RCU
     11610 ±  2%     -24.3%       8785 ±  9%  softirqs.CPU59.SCHED
    113688           -25.4%      84834 ±  2%  softirqs.CPU6.RCU
     11723 ±  2%     -24.4%       8858 ±  6%  softirqs.CPU6.SCHED
    112505           -26.2%      83069        softirqs.CPU60.RCU
     11303 ±  3%     -23.7%       8628 ±  7%  softirqs.CPU60.SCHED
    111675           -25.5%      83152        softirqs.CPU61.RCU
     11008 ±  2%     -19.6%       8854 ± 10%  softirqs.CPU61.SCHED
    111654           -25.7%      82984        softirqs.CPU62.RCU
     10974 ±  2%     -21.4%       8622 ±  5%  softirqs.CPU62.SCHED
    113013           -25.2%      84589        softirqs.CPU63.RCU
     11383 ±  4%     -23.4%       8722 ±  7%  softirqs.CPU63.SCHED
    113944           -26.0%      84360        softirqs.CPU64.RCU
     11270 ±  2%     -21.9%       8807 ±  6%  softirqs.CPU64.SCHED
    112766           -26.4%      82988        softirqs.CPU65.RCU
     11198 ±  4%     -23.4%       8580 ±  5%  softirqs.CPU65.SCHED
    111974           -27.9%      80761 ±  7%  softirqs.CPU66.RCU
     11420 ±  3%     -24.7%       8602 ±  5%  softirqs.CPU66.SCHED
    111724           -25.8%      82949        softirqs.CPU67.RCU
     11407 ±  5%     -24.4%       8626 ±  6%  softirqs.CPU67.SCHED
    112065           -25.6%      83358        softirqs.CPU68.RCU
     11401 ±  9%     -24.9%       8559 ±  6%  softirqs.CPU68.SCHED
    114047           -29.1%      80823 ±  9%  softirqs.CPU69.RCU
     11465 ±  2%     -21.7%       8981 ± 12%  softirqs.CPU69.SCHED
    111811 ±  2%     -26.7%      81901 ±  7%  softirqs.CPU7.RCU
     11527 ±  2%     -21.7%       9028 ±  6%  softirqs.CPU7.SCHED
    113806           -25.5%      84749 ±  2%  softirqs.CPU70.RCU
     11231 ±  5%     -22.0%       8761 ±  7%  softirqs.CPU70.SCHED
    113642           -25.6%      84493 ±  2%  softirqs.CPU71.RCU
     11748 ±  8%     -25.6%       8746 ±  6%  softirqs.CPU71.SCHED
    107927 ±  5%     -22.8%      83345        softirqs.CPU72.RCU
     11561 ±  2%     -22.7%       8936 ± 12%  softirqs.CPU72.SCHED
    111669           -25.5%      83229        softirqs.CPU73.RCU
     11172 ±  4%     -24.1%       8482 ±  5%  softirqs.CPU73.SCHED
    113287           -29.4%      79942 ±  9%  softirqs.CPU74.RCU
     11715 ±  6%     -23.3%       8981 ±  7%  softirqs.CPU74.SCHED
    112331 ±  3%     -25.5%      83686 ±  2%  softirqs.CPU75.RCU
     11128 ±  3%     -22.1%       8671 ±  5%  softirqs.CPU75.SCHED
    111893 ±  3%     -24.9%      84048 ±  2%  softirqs.CPU76.RCU
     11210 ±  3%     -16.6%       9352 ±  8%  softirqs.CPU76.SCHED
    112187 ±  4%     -27.9%      80865 ±  7%  softirqs.CPU77.RCU
     11295 ±  4%     -22.2%       8789 ±  4%  softirqs.CPU77.SCHED
    118790           -26.0%      87858        softirqs.CPU78.RCU
     13396 ±  4%     -31.1%       9232 ±  9%  softirqs.CPU78.SCHED
    118851 ±  2%     -25.8%      88237        softirqs.CPU79.RCU
     13523 ±  7%     -24.3%      10236 ± 12%  softirqs.CPU79.SCHED
    111449           -26.0%      82490 ±  2%  softirqs.CPU8.RCU
     11214 ±  2%     -24.3%       8488 ±  5%  softirqs.CPU8.SCHED
    118692           -25.4%      88590        softirqs.CPU80.RCU
     14082 ±  4%     -26.7%      10327 ± 10%  softirqs.CPU80.SCHED
    116649 ±  5%     -24.6%      87957        softirqs.CPU81.RCU
     14559 ±  7%     -34.5%       9534 ± 13%  softirqs.CPU81.SCHED
    119797 ±  2%     -26.6%      87951        softirqs.CPU82.RCU
     14468 ±  7%     -33.9%       9557 ± 10%  softirqs.CPU82.SCHED
    118499           -25.7%      87989 ±  2%  softirqs.CPU83.RCU
    119911 ±  2%     -27.4%      87013 ±  4%  softirqs.CPU84.RCU
     14860 ±  3%     -31.7%      10147 ± 13%  softirqs.CPU84.SCHED
    119690           -26.6%      87829        softirqs.CPU85.RCU
     14141 ±  8%     -33.2%       9448 ± 11%  softirqs.CPU85.SCHED
    119016 ±  2%     -25.9%      88170        softirqs.CPU86.RCU
     13379 ±  8%     -30.4%       9309 ± 11%  softirqs.CPU86.SCHED
    119242 ±  2%     -25.9%      88373        softirqs.CPU87.RCU
     13944 ±  7%     -29.5%       9834 ± 12%  softirqs.CPU87.SCHED
    119490 ±  2%     -26.6%      87687        softirqs.CPU88.RCU
     14066 ± 11%     -29.7%       9885 ± 14%  softirqs.CPU88.SCHED
    118674 ±  2%     -25.8%      88035        softirqs.CPU89.RCU
     14090 ±  5%     -31.5%       9647 ± 13%  softirqs.CPU89.SCHED
    111284 ±  2%     -25.4%      82978 ±  2%  softirqs.CPU9.RCU
     10915           -19.4%       8802 ±  7%  softirqs.CPU9.SCHED
    111624 ±  2%     -26.2%      82405        softirqs.CPU90.RCU
     14343 ±  9%     -33.4%       9559 ± 14%  softirqs.CPU90.SCHED
    110317           -26.2%      81438        softirqs.CPU91.RCU
     13801 ±  4%     -29.0%       9803 ± 11%  softirqs.CPU91.SCHED
    110304 ±  2%     -25.9%      81721        softirqs.CPU92.RCU
     13623 ± 11%     -29.1%       9665 ± 13%  softirqs.CPU92.SCHED
    111772           -27.2%      81370        softirqs.CPU93.RCU
     14274 ±  6%     -33.8%       9448 ± 10%  softirqs.CPU93.SCHED
    110389           -26.1%      81624        softirqs.CPU94.RCU
     14238 ±  9%     -31.6%       9737 ± 16%  softirqs.CPU94.SCHED
    111415 ±  2%     -26.6%      81770        softirqs.CPU95.RCU
     13761 ±  8%     -34.1%       9066 ± 10%  softirqs.CPU95.SCHED
    110596           -26.1%      81782        softirqs.CPU96.RCU
     14044 ±  6%     -30.4%       9772 ± 14%  softirqs.CPU96.SCHED
    111174 ±  2%     -26.1%      82155        softirqs.CPU97.RCU
     14260 ± 12%     -30.7%       9878 ± 18%  softirqs.CPU97.SCHED
    111371 ±  2%     -27.0%      81298        softirqs.CPU98.RCU
     14319 ±  9%     -32.2%       9705 ± 14%  softirqs.CPU98.SCHED
    109567           -25.9%      81242        softirqs.CPU99.RCU
     13355 ±  9%     -26.5%       9817 ± 14%  softirqs.CPU99.SCHED
  12003152           -26.2%    8852871        softirqs.RCU
   1320123 ±  4%     -27.4%     958083 ±  4%  softirqs.SCHED
    124887           -25.9%      92537        softirqs.TIMER





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Rong Chen


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.13.0-00078-g68ac5b3c8db2"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.13.0 Kernel Configuration
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
CONFIG_TASKS_RCU=y
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
# CONFIG_CHECKPOINT_RESTORE is not set
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
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
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
CONFIG_PERF_EVENTS_AMD_POWER=m
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
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
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
CONFIG_X86_RESERVE_LOW=64
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
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y

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
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
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
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
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
CONFIG_NEED_MULTIPLE_NODES=y
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
# CONFIG_PM_QOS_KUNIT_TEST is not set
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

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

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
# CONFIG_LED_TRIGGER_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
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
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
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
# CONFIG_WWAN is not set
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
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
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
# CONFIG_SENSORS_MP2975 is not set
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
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
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
CONFIG_DVB_SP8870=m
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
CONFIG_DRM_KMS_FB_HELPER=y
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
# CONFIG_INFINIBAND_I40IW is not set
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
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS=y
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
CONFIG_HP_WIRELESS=m
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
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
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
CONFIG_IOMMU_IO_PGTABLE=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

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
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
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
# CONFIG_PSTORE_BLK is not set
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
# CONFIG_CIFS_STATS2 is not set
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
# CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
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
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
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
# CONFIG_PRINTK_CALLER is not set
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
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
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
CONFIG_LOCK_TORTURE_TEST=m
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
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
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
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=m
CONFIG_KUNIT_EXAMPLE_TEST=m
# CONFIG_KUNIT_ALL_TESTS is not set
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
# CONFIG_BITFIELD_KUNIT is not set
# CONFIG_RESOURCE_KUNIT_TEST is not set
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
# CONFIG_LINEAR_RANGES_TEST is not set
# CONFIG_CMDLINE_KUNIT_TEST is not set
# CONFIG_BITS_TEST is not set
# CONFIG_SLUB_KUNIT_TEST is not set
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
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='hackbench'
	export testcase='hackbench'
	export category='benchmark'
	export disable_latency_stats=1
	export nr_threads=192
	export iterations=4
	export job_origin='hackbench-100.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2ap4'
	export tbox_group='lkp-csl-2ap4'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='60e199d0b7a6f0d1be268127'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap4/hackbench-performance-socket-4-threads-100%-ucode=0x5003006-monitor=40f1cfd2-debian-10.4-x86_64-20200603.cgz-68ac5b3c8db2fda00af-20210704-53694-upcl65-4.yaml'
	export id='23c74ec0a699eb56d9c9f98fa904c5399dd86600'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=4
	export nr_cpu=192
	export memory='192G'
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF87091000G1P6IGN-*-part1'
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export kernel_cmdline_hw='acpi_rsdp=0x67f44014'
	export brand='Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz'
	export commit='68ac5b3c8db2fda00af594eca4100aceaf927c0e'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_BLK_DEV_NVME'
	export ucode='0x5003006'
	export enqueue_time='2021-07-04 19:21:52 +0800'
	export _id='60e199dfb7a6f0d1be268128'
	export _rt='/result/hackbench/performance-socket-4-threads-100%-ucode=0x5003006-monitor=40f1cfd2/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/68ac5b3c8db2fda00af594eca4100aceaf927c0e'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='e8a7cf1166157eba3e6c393b5fa90befcb74b7f6'
	export base_commit='62fb9874f5da54fdb243003b386128037319b219'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='40f1cfd2'
	export result_root='/result/hackbench/performance-socket-4-threads-100%-ucode=0x5003006-monitor=40f1cfd2/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/68ac5b3c8db2fda00af594eca4100aceaf927c0e/3'
	export scheduler_version='/lkp/lkp/.src-20210702-175843'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2ap4/hackbench-performance-socket-4-threads-100%-ucode=0x5003006-monitor=40f1cfd2-debian-10.4-x86_64-20200603.cgz-68ac5b3c8db2fda00af-20210704-53694-upcl65-4.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=68ac5b3c8db2fda00af594eca4100aceaf927c0e
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/68ac5b3c8db2fda00af594eca4100aceaf927c0e/vmlinuz-5.13.0-00078-g68ac5b3c8db2
acpi_rsdp=0x67f44014
max_uptime=2100
RESULT_ROOT=/result/hackbench/performance-socket-4-threads-100%-ucode=0x5003006-monitor=40f1cfd2/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/68ac5b3c8db2fda00af594eca4100aceaf927c0e/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/68ac5b3c8db2fda00af594eca4100aceaf927c0e/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hackbench_20210701.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/hackbench-x86_64-1.10-1_20210701.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20210621.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-303392fd5c16-1_20210703.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.13.0-intel-next-08538-g8eec61a75de5'
	export repeat_to=6
	export bad_samples='97541.94303550528
108572.3936593722
116755.74697732343'
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/68ac5b3c8db2fda00af594eca4100aceaf927c0e/vmlinuz-5.13.0-00078-g68ac5b3c8db2'
	export dequeue_time='2021-07-04 19:24:15 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap4/hackbench-performance-socket-4-threads-100%-ucode=0x5003006-monitor=40f1cfd2-debian-10.4-x86_64-20200603.cgz-68ac5b3c8db2fda00af-20210704-53694-upcl65-4.cgz'

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
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test mode='threads' ipc='socket' $LKP_SRC/tests/wrapper hackbench
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env mode='threads' ipc='socket' $LKP_SRC/stats/wrapper hackbench
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
	$LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time hackbench.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/hackbench-100.yaml:
suite: hackbench
testcase: hackbench
category: benchmark
disable_latency_stats: 1
nr_threads: 100%
iterations: 4
hackbench:
  mode: threads
  ipc: socket
job_origin: hackbench-100.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2ap4
tbox_group: lkp-csl-2ap4
kconfig: x86_64-rhel-8.3
submit_id: 60e186eeb7a6f0cfa477ebe1
job_file: "/lkp/jobs/scheduled/lkp-csl-2ap4/hackbench-performance-socket-4-threads-100%-ucode=0x5003006-monitor=40f1cfd2-debian-10.4-x86_64-20200603.cgz-68ac5b3c8db2fda00af-20210704-53156-qy37c8-0.yaml"
id: 861e7980a4ef012e8670953dad16c4f665805651
queuer_version: "/lkp-src"
:#! hosts/lkp-csl-2ap4:
model: Cascade Lake
nr_node: 4
nr_cpu: 192
memory: 192G
ssd_partitions: "/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF87091000G1P6IGN-*-part1"
rootfs_partition: LABEL=LKP-ROOTFS
kernel_cmdline_hw: acpi_rsdp=0x67f44014
brand: Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz
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
:#! include/category/ALL:
cpufreq_governor: performance
:#! include/queue/cyclic:
commit: 68ac5b3c8db2fda00af594eca4100aceaf927c0e
:#! include/testbox/lkp-csl-2ap4:
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_BLK_DEV_NVME
ucode: '0x5003006'
enqueue_time: 2021-07-04 18:01:18.907888849 +08:00
_id: 60e186eeb7a6f0cfa477ebe1
_rt: "/result/hackbench/performance-socket-4-threads-100%-ucode=0x5003006-monitor=40f1cfd2/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/68ac5b3c8db2fda00af594eca4100aceaf927c0e"
:#! schedule options:
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: e8a7cf1166157eba3e6c393b5fa90befcb74b7f6
base_commit: 62fb9874f5da54fdb243003b386128037319b219
branch: linux-devel/devel-hourly-20210703-011846
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 40f1cfd2
result_root: "/result/hackbench/performance-socket-4-threads-100%-ucode=0x5003006-monitor=40f1cfd2/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/68ac5b3c8db2fda00af594eca4100aceaf927c0e/0"
scheduler_version: "/lkp/lkp/.src-20210702-175843"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2ap4/hackbench-performance-socket-4-threads-100%-ucode=0x5003006-monitor=40f1cfd2-debian-10.4-x86_64-20200603.cgz-68ac5b3c8db2fda00af-20210704-53156-qy37c8-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210703-011846
- commit=68ac5b3c8db2fda00af594eca4100aceaf927c0e
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/68ac5b3c8db2fda00af594eca4100aceaf927c0e/vmlinuz-5.13.0-00078-g68ac5b3c8db2
- acpi_rsdp=0x67f44014
- max_uptime=2100
- RESULT_ROOT=/result/hackbench/performance-socket-4-threads-100%-ucode=0x5003006-monitor=40f1cfd2/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/68ac5b3c8db2fda00af594eca4100aceaf927c0e/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/68ac5b3c8db2fda00af594eca4100aceaf927c0e/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hackbench_20210701.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/hackbench-x86_64-1.10-1_20210701.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20210621.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-303392fd5c16-1_20210703.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /lkp/lkp/.src-20210702-175843/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.13.0
repeat_to: 3
bad_samples:
- 97541.94303550528
- 108572.3936593722
- 116755.74697732343
:#! user overrides:
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/68ac5b3c8db2fda00af594eca4100aceaf927c0e/vmlinuz-5.13.0-00078-g68ac5b3c8db2"
dequeue_time: 2021-07-04 18:03:07.359666259 +08:00
job_state: finished
loadavg: 1293.79 2847.98 2216.37 1/1473 54868
start_time: '1625393821'
end_time: '1625394809'
version: "/lkp/lkp/.src-20210702-175917:0e9ef164:07b503fa6"

--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "/usr/bin/hackbench" "-g" "192" "--threads" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "192" "--threads" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "192" "--threads" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "192" "--threads" "-l" "30000" "-s" "100"

--zCKi3GIZzVBPywwA--
