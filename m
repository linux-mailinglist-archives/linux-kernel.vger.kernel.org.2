Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C713BAD70
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 16:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhGDOhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 10:37:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:5992 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhGDOhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 10:37:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10035"; a="207055962"
X-IronPort-AV: E=Sophos;i="5.83,323,1616482800"; 
   d="yaml'?scan'208";a="207055962"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2021 07:34:23 -0700
X-IronPort-AV: E=Sophos;i="5.83,323,1616482800"; 
   d="yaml'?scan'208";a="485079642"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2021 07:34:16 -0700
Date:   Sun, 4 Jul 2021 22:53:00 +0800
From:   kernel test robot <oliver.sang@intel.com>
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
Subject: [mm/memcg]  5387c90490:  hackbench.throughput 41.3% improvement
Message-ID: <20210704145300.GB21572@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Greeting,

FYI, we noticed a 41.3% improvement of hackbench.throughput due to commit:


commit: 5387c90490f7f42df3209154ca955a453ee01b41 ("mm/memcg: improve refill_obj_stock() performance")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: hackbench
on test machine: 104 threads 2 sockets Skylake with 192G memory
with following parameters:

	nr_threads: 100%
	iterations: 4
	mode: threads
	ipc: socket
	cpufreq_governor: performance
	ucode: 0x2006a0a

test-description: Hackbench is both a benchmark and a stress test for the Linux kernel scheduler.
test-url: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/sched/cfs-scheduler/hackbench.c

In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------+
| testcase: change | hackbench: hackbench.throughput 51.9% improvement                    |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                         |
|                  | ipc=socket                                                           |
|                  | iterations=8                                                         |
|                  | mode=process                                                         |
|                  | nr_threads=1600%                                                     |
|                  | ucode=0x4003006                                                      |
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
  gcc-9/performance/socket/4/x86_64-rhel-8.3/threads/100%/debian-10.4-x86_64-20200603.cgz/lkp-skl-fpga01/hackbench/0x2006a0a

commit: 
  68ac5b3c8d ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")
  5387c90490 ("mm/memcg: improve refill_obj_stock() performance")

68ac5b3c8db2fda0 5387c90490f7f42df3209154ca9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     82459           +41.3%     116521 ±  2%  hackbench.throughput
    601.44           -29.1%     426.40 ±  2%  hackbench.time.elapsed_time
    601.44           -29.1%     426.40 ±  2%  hackbench.time.elapsed_time.max
 2.344e+09 ±  3%     -85.5%  3.396e+08 ± 21%  hackbench.time.involuntary_context_switches
     53613           -32.8%      36018 ±  2%  hackbench.time.system_time
 3.493e+09 ±  2%     -77.9%  7.702e+08 ± 14%  hackbench.time.voluntary_context_switches
   1374661 ± 22%     -58.4%     572519 ± 13%  numa-numastat.node0.local_node
   1403760 ± 21%     -55.5%     623973 ± 15%  numa-numastat.node0.numa_hit
    651.41           -26.7%     477.78 ±  2%  uptime.boot
      5074 ±  3%      +9.5%       5557 ±  3%  uptime.idle
  65187074 ± 25%    +336.1%  2.843e+08 ±  6%  cpuidle.C1.time
   5686636 ± 13%    +402.4%   28566892 ±  5%  cpuidle.C1.usage
   5451564 ± 23%    +189.6%   15789364 ±  5%  cpuidle.POLL.time
   1684249 ± 24%    +103.1%    3421281 ± 11%  cpuidle.POLL.usage
      3.45 ±  4%      +6.9       10.38 ± 36%  mpstat.cpu.all.idle%
      1.19 ±  4%      -0.1        1.04 ±  3%  mpstat.cpu.all.irq%
      0.02            +0.0        0.04 ±  5%  mpstat.cpu.all.soft%
     12.20            +2.7       14.92 ±  5%  mpstat.cpu.all.usr%
   3295209           +80.7%    5954774 ± 20%  vmstat.memory.cache
      2143           -22.4%       1663        vmstat.procs.r
   9678625 ±  2%     -72.3%    2678610 ± 17%  vmstat.system.cs
    955036 ±  3%     -41.1%     562152 ±  7%  vmstat.system.in
    568807 ±  3%     +10.5%     628623 ±  5%  numa-vmstat.node0.nr_file_pages
     16548 ± 30%    +239.6%      56197 ± 46%  numa-vmstat.node0.nr_mapped
    523.67 ± 35%     +55.0%     811.67 ± 17%  numa-vmstat.node0.nr_page_table_pages
     36972 ± 26%     +53.5%      56757 ±  5%  numa-vmstat.node0.nr_slab_unreclaimable
    193900 ±  8%    +319.4%     813228 ± 37%  numa-vmstat.node1.nr_shmem
   5677672 ± 13%    +403.0%   28559515 ±  5%  turbostat.C1
      0.10 ± 26%      +0.5        0.64 ±  7%  turbostat.C1%
      0.68 ±  2%     +97.8%       1.34 ±  3%  turbostat.CPU%c1
 5.956e+08 ±  3%     -56.6%  2.585e+08 ±  5%  turbostat.IRQ
    118.32           +12.9%     133.57        turbostat.RAMWatt
   3177467           +81.9%    5780159 ± 20%  meminfo.Cached
   1203614          +222.4%    3880986 ± 31%  meminfo.Committed_AS
   4677171           +64.7%    7701539 ± 17%  meminfo.Memused
    297339           +24.9%     371485        meminfo.SUnreclaim
    806445          +323.2%    3412731 ± 35%  meminfo.Shmem
    420575           +19.0%     500317        meminfo.Slab
   5215936           +51.2%    7884576 ± 14%  meminfo.max_used_kB
   2275408 ±  3%     +10.5%    2514228 ±  5%  numa-meminfo.node0.FilePages
     64515 ± 31%    +247.9%     224420 ± 46%  numa-meminfo.node0.Mapped
   3161940 ±  5%     +18.3%    3741976 ±  3%  numa-meminfo.node0.MemUsed
      2096 ± 35%     +55.0%       3249 ± 17%  numa-meminfo.node0.PageTables
    148152 ± 26%     +53.3%     227063 ±  5%  numa-meminfo.node0.SUnreclaim
    224798 ± 18%     +37.9%     309991 ±  5%  numa-meminfo.node0.Slab
    774062 ±  8%    +320.0%    3251142 ± 37%  numa-meminfo.node1.Shmem
   4772460            -1.6%    4696954        proc-vmstat.nr_dirty_background_threshold
   9556589            -1.6%    9405393        proc-vmstat.nr_dirty_threshold
    794697           +81.8%    1444609 ± 20%  proc-vmstat.nr_file_pages
  48011598            -1.6%   47256315        proc-vmstat.nr_free_pages
    201937          +322.3%     852751 ± 35%  proc-vmstat.nr_shmem
     30809            +4.5%      32203        proc-vmstat.nr_slab_reclaimable
     74338           +24.9%      92861        proc-vmstat.nr_slab_unreclaimable
   3223037 ±  2%     -20.0%    2579246 ± 17%  proc-vmstat.numa_hit
   3128922 ±  2%     -20.6%    2485141 ± 18%  proc-vmstat.numa_local
   6652818 ±  3%     -50.8%    3274182 ± 18%  proc-vmstat.pgalloc_normal
   6372725 ±  3%     -68.5%    2009197 ± 11%  proc-vmstat.pgfree
     78108           -13.4%      67635 ±  4%  proc-vmstat.pgreuse
     64709 ±  4%      -8.6%      59163 ±  5%  slabinfo.anon_vma_chain.active_objs
      1012 ±  4%      -8.5%     926.50 ±  5%  slabinfo.anon_vma_chain.active_slabs
     64825 ±  4%      -8.5%      59329 ±  5%  slabinfo.anon_vma_chain.num_objs
      1012 ±  4%      -8.5%     926.50 ±  5%  slabinfo.anon_vma_chain.num_slabs
    766.50           +17.5%     900.50        slabinfo.kmalloc-256.active_slabs
     24539           +17.5%      28832        slabinfo.kmalloc-256.num_objs
    766.50           +17.5%     900.50        slabinfo.kmalloc-256.num_slabs
     39056 ±  3%    +181.6%     109997 ±  3%  slabinfo.kmalloc-512.active_objs
      1397 ±  3%    +217.3%       4434 ±  4%  slabinfo.kmalloc-512.active_slabs
     44743 ±  3%    +217.2%     141914 ±  4%  slabinfo.kmalloc-512.num_objs
      1397 ±  3%    +217.3%       4434 ±  4%  slabinfo.kmalloc-512.num_slabs
     31672           +31.2%      41555 ± 11%  slabinfo.radix_tree_node.active_objs
    565.17           +31.2%     741.67 ± 11%  slabinfo.radix_tree_node.active_slabs
     31677           +31.2%      41555 ± 11%  slabinfo.radix_tree_node.num_objs
    565.17           +31.2%     741.67 ± 11%  slabinfo.radix_tree_node.num_slabs
     30624 ±  3%    +229.8%     101008 ±  3%  slabinfo.skbuff_head_cache.active_objs
      1117 ±  4%    +267.9%       4111 ±  4%  slabinfo.skbuff_head_cache.active_slabs
     35782 ±  4%    +267.8%     131591 ±  4%  slabinfo.skbuff_head_cache.num_objs
      1117 ±  4%    +267.9%       4111 ±  4%  slabinfo.skbuff_head_cache.num_slabs
     12.17 ± 59%     -76.6%       2.85 ±105%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
    107.59 ± 26%     -86.3%      14.72 ± 87%  perf-sched.sch_delay.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     12.08 ± 10%     -80.9%       2.30 ±127%  perf-sched.sch_delay.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     11216 ± 19%     -53.8%       5178 ± 79%  perf-sched.sch_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     12780 ± 13%     -58.6%       5291 ± 82%  perf-sched.sch_delay.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     13649 ± 12%     -49.4%       6904 ± 79%  perf-sched.total_wait_time.max.ms
     95.29 ± 22%     -66.6%      31.87 ± 85%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    509.93 ± 20%     -88.0%      61.07 ± 83%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     43.59 ± 11%     -80.4%       8.55 ±127%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     23259 ± 15%     -55.3%      10391 ± 79%  perf-sched.wait_and_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     25565 ± 13%     -57.7%      10809 ± 83%  perf-sched.wait_and_delay.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
    177.56 ± 57%     -70.7%      52.07 ± 81%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     35.59 ± 19%     -74.3%       9.13 ± 94%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
     36.21 ± 47%     -82.1%       6.50 ± 99%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
     95.29 ± 22%     -66.6%      31.87 ± 85%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
    402.34 ± 20%     -88.5%      46.35 ± 82%  perf-sched.wait_time.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     31.51 ± 12%     -80.2%       6.24 ±126%  perf-sched.wait_time.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     13649 ± 12%     -55.2%       6120 ± 83%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12457 ± 15%     -53.4%       5811 ± 84%  perf-sched.wait_time.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     13018 ± 14%     -57.3%       5565 ± 83%  perf-sched.wait_time.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     11.68            -4.0%      11.22 ±  3%  perf-stat.i.MPKI
  1.91e+10 ±  2%     -13.0%  1.662e+10 ±  4%  perf-stat.i.branch-instructions
 3.114e+08           -13.3%    2.7e+08 ±  4%  perf-stat.i.branch-misses
      6.20            +9.1       15.31 ±  4%  perf-stat.i.cache-miss-rate%
  63695030 ±  4%    +112.1%  1.351e+08 ±  4%  perf-stat.i.cache-misses
 1.062e+09 ±  3%     -13.9%  9.139e+08 ±  8%  perf-stat.i.cache-references
   9804802 ±  2%     -72.2%    2721599 ± 18%  perf-stat.i.context-switches
      3.20 ±  2%     +12.1%       3.59 ±  4%  perf-stat.i.cpi
    682632 ±  6%     -64.6%     241483 ± 19%  perf-stat.i.cpu-migrations
      5079 ±  4%     -57.8%       2145 ±  4%  perf-stat.i.cycles-between-cache-misses
      0.08 ±  2%      +0.1        0.15 ±  4%  perf-stat.i.dTLB-load-miss-rate%
  19602583           +76.8%   34648829 ±  3%  perf-stat.i.dTLB-load-misses
 2.642e+10 ±  2%     -10.9%  2.353e+10 ±  4%  perf-stat.i.dTLB-loads
      0.01 ±  8%      +0.0        0.04 ± 10%  perf-stat.i.dTLB-store-miss-rate%
    886982 ±  8%    +468.7%    5044093 ±  9%  perf-stat.i.dTLB-store-misses
 1.612e+10            -8.9%  1.468e+10 ±  4%  perf-stat.i.dTLB-stores
     71.40           +12.4       83.83        perf-stat.i.iTLB-load-miss-rate%
  11045291 ±  6%     -52.6%    5234559 ± 10%  perf-stat.i.iTLB-loads
  9.29e+10 ±  2%     -11.1%   8.26e+10 ±  4%  perf-stat.i.instructions
      3720           -11.7%       3283 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.32 ±  2%      -9.9%       0.29 ±  4%  perf-stat.i.ipc
    532.69 ±  5%     +33.9%     713.49 ±  5%  perf-stat.i.metric.K/sec
    602.85 ±  2%     -11.1%     535.87 ±  4%  perf-stat.i.metric.M/sec
      2939 ±  3%     +60.2%       4710 ±  8%  perf-stat.i.minor-faults
     87.86           -38.2       49.64 ±  6%  perf-stat.i.node-load-miss-rate%
   2480788 ±  7%    +578.9%   16841829 ±  4%  perf-stat.i.node-loads
     91.60           -43.7       47.94 ±  6%  perf-stat.i.node-store-miss-rate%
  10368046 ±  6%     +17.6%   12189032 ±  6%  perf-stat.i.node-store-misses
    965185 ±  7%   +1354.2%   14035704 ±  4%  perf-stat.i.node-stores
      2941 ±  3%     +60.2%       4712 ±  8%  perf-stat.i.page-faults
      6.05            +8.9       14.91 ±  5%  perf-stat.overall.cache-miss-rate%
      3.11 ±  2%     +11.6%       3.47 ±  5%  perf-stat.overall.cpi
      4511 ±  3%     -53.1%       2113 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.07 ±  2%      +0.1        0.15 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ±  9%      +0.0        0.03 ± 10%  perf-stat.overall.dTLB-store-miss-rate%
     70.35           +13.2       83.55        perf-stat.overall.iTLB-load-miss-rate%
      3571 ±  2%     -12.3%       3131 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.32 ±  2%     -10.2%       0.29 ±  4%  perf-stat.overall.ipc
     89.09           -38.4       50.67 ±  8%  perf-stat.overall.node-load-miss-rate%
     90.82           -44.9       45.92 ±  5%  perf-stat.overall.node-store-miss-rate%
 1.896e+10 ±  2%     -12.8%  1.654e+10 ±  4%  perf-stat.ps.branch-instructions
 3.094e+08           -13.1%  2.688e+08 ±  4%  perf-stat.ps.branch-misses
  63654107 ±  3%    +111.9%  1.349e+08 ±  4%  perf-stat.ps.cache-misses
 1.053e+09 ±  3%     -13.8%  9.081e+08 ±  7%  perf-stat.ps.cache-references
   9699719 ±  2%     -72.4%    2679869 ± 18%  perf-stat.ps.context-switches
    670636 ±  6%     -65.0%     234729 ± 18%  perf-stat.ps.cpu-migrations
  19593701           +76.7%   34623370 ±  3%  perf-stat.ps.dTLB-load-misses
 2.624e+10 ±  2%     -10.7%  2.342e+10 ±  4%  perf-stat.ps.dTLB-loads
    901124 ±  9%    +459.7%    5043349 ±  9%  perf-stat.ps.dTLB-store-misses
 1.601e+10            -8.7%  1.462e+10 ±  4%  perf-stat.ps.dTLB-stores
  10905261 ±  6%     -52.5%    5180101 ± 10%  perf-stat.ps.iTLB-loads
 9.225e+10 ±  2%     -10.9%  8.219e+10 ±  4%  perf-stat.ps.instructions
      1.12 ± 44%     +99.7%       2.24 ± 25%  perf-stat.ps.major-faults
      2910 ±  3%     +56.2%       4547 ±  8%  perf-stat.ps.minor-faults
   2537682 ±  7%    +568.1%   16953030 ±  4%  perf-stat.ps.node-loads
  10280989 ±  6%     +16.7%   11999128 ±  6%  perf-stat.ps.node-store-misses
   1033899 ±  7%   +1266.0%   14122866 ±  4%  perf-stat.ps.node-stores
      2912 ±  3%     +56.2%       4550 ±  8%  perf-stat.ps.page-faults
 5.555e+13 ±  2%     -36.9%  3.505e+13 ±  2%  perf-stat.total.instructions
     82383           -38.1%      51010 ±  2%  softirqs.CPU0.RCU
     11946 ±  8%     +51.9%      18143 ±  6%  softirqs.CPU0.SCHED
     83901           -39.4%      50854 ±  2%  softirqs.CPU1.RCU
     10530 ±  9%     +62.6%      17122 ±  5%  softirqs.CPU1.SCHED
     82690           -40.3%      49378 ±  2%  softirqs.CPU10.RCU
      8595 ±  5%     +68.9%      14520 ±  4%  softirqs.CPU10.SCHED
     81004           -39.4%      49126 ±  3%  softirqs.CPU100.RCU
     10023 ± 14%     +60.5%      16092 ±  5%  softirqs.CPU100.SCHED
     80721           -39.7%      48692 ±  3%  softirqs.CPU101.RCU
      9652 ± 12%     +67.1%      16127 ±  3%  softirqs.CPU101.SCHED
     81743           -39.5%      49494 ±  4%  softirqs.CPU102.RCU
      9461 ± 12%     +68.5%      15946 ±  4%  softirqs.CPU102.SCHED
     81567           -39.9%      49048 ±  4%  softirqs.CPU103.RCU
     10377 ± 13%     +57.1%      16306 ±  3%  softirqs.CPU103.SCHED
     83547           -39.9%      50187 ±  3%  softirqs.CPU11.RCU
      8718 ±  7%     +67.4%      14598 ±  4%  softirqs.CPU11.SCHED
     83780           -39.7%      50514 ±  3%  softirqs.CPU12.RCU
      8551 ±  7%     +69.7%      14515 ±  5%  softirqs.CPU12.SCHED
     82874 ±  2%     -37.9%      51480 ±  3%  softirqs.CPU13.RCU
      8707 ±  7%     +74.3%      15179 ±  5%  softirqs.CPU13.SCHED
     79623 ±  9%     -37.1%      50081 ±  4%  softirqs.CPU14.RCU
      8757 ±  8%     +62.8%      14260 ±  5%  softirqs.CPU14.SCHED
     91367           -40.7%      54191 ±  5%  softirqs.CPU15.RCU
      8433 ±  6%     +69.1%      14260 ±  5%  softirqs.CPU15.SCHED
     91569           -41.1%      53944 ±  3%  softirqs.CPU16.RCU
      8422 ±  5%     +75.1%      14746 ±  5%  softirqs.CPU16.SCHED
     90429 ±  5%     -40.0%      54232 ±  2%  softirqs.CPU17.RCU
      8511 ±  7%     +69.8%      14452 ±  3%  softirqs.CPU17.SCHED
     92542           -41.6%      54049 ±  3%  softirqs.CPU18.RCU
      8609 ±  9%     +64.8%      14191 ±  5%  softirqs.CPU18.SCHED
     93207           -42.0%      54033 ±  3%  softirqs.CPU19.RCU
      8866 ±  6%     +59.6%      14153 ±  4%  softirqs.CPU19.SCHED
     83467           -39.0%      50951 ±  3%  softirqs.CPU2.RCU
      9144 ±  7%     +63.6%      14964 ±  5%  softirqs.CPU2.SCHED
     90907           -41.1%      53543 ±  3%  softirqs.CPU20.RCU
      8915 ± 10%     +63.0%      14530 ±  4%  softirqs.CPU20.SCHED
     91022           -40.9%      53798 ±  3%  softirqs.CPU21.RCU
      8302 ±  4%     +73.1%      14372 ±  4%  softirqs.CPU21.SCHED
     90088 ±  4%     -40.4%      53699 ±  3%  softirqs.CPU22.RCU
      8682 ±  5%     +64.6%      14291 ±  4%  softirqs.CPU22.SCHED
     91532           -40.7%      54267 ±  3%  softirqs.CPU23.RCU
      8545 ±  6%     +72.0%      14696 ±  5%  softirqs.CPU23.SCHED
     92532           -41.1%      54495 ±  3%  softirqs.CPU24.RCU
      8682 ±  7%     +68.9%      14661 ±  4%  softirqs.CPU24.SCHED
     90745 ±  6%     -40.1%      54374 ±  3%  softirqs.CPU25.RCU
      8656 ±  6%     +67.3%      14479 ±  5%  softirqs.CPU25.SCHED
     80912           -41.1%      47680 ±  3%  softirqs.CPU26.RCU
      9647 ± 12%     +63.0%      15726 ±  8%  softirqs.CPU26.SCHED
     81056           -40.1%      48515 ±  2%  softirqs.CPU27.RCU
     10080 ± 12%     +70.4%      17182 ±  8%  softirqs.CPU27.SCHED
     80849           -40.3%      48288 ±  4%  softirqs.CPU28.RCU
      9318 ± 16%     +73.8%      16195 ±  4%  softirqs.CPU28.SCHED
     81348           -40.3%      48602 ±  3%  softirqs.CPU29.RCU
      9837 ±  9%     +61.9%      15923 ±  3%  softirqs.CPU29.SCHED
     82656 ±  2%     -38.1%      51137 ±  4%  softirqs.CPU3.RCU
      8719 ±  5%     +70.4%      14859 ±  4%  softirqs.CPU3.SCHED
     83915           -38.2%      51833 ±  5%  softirqs.CPU30.RCU
      9430 ±  9%     +70.3%      16062 ±  5%  softirqs.CPU30.SCHED
     84800 ±  2%     -40.3%      50624 ±  3%  softirqs.CPU31.RCU
      9622 ± 12%     +67.9%      16158 ±  6%  softirqs.CPU31.SCHED
     81832 ±  8%     -38.0%      50745 ±  3%  softirqs.CPU32.RCU
      9722 ± 10%     +66.6%      16202 ±  5%  softirqs.CPU32.SCHED
     83675           -39.7%      50422 ±  3%  softirqs.CPU33.RCU
      9401 ± 11%     +72.2%      16187 ±  5%  softirqs.CPU33.SCHED
     84672           -40.0%      50793 ±  3%  softirqs.CPU34.RCU
      9561 ± 17%     +65.6%      15831 ±  5%  softirqs.CPU34.SCHED
     84570           -40.1%      50664 ±  3%  softirqs.CPU35.RCU
      9508 ± 12%     +68.9%      16065 ±  3%  softirqs.CPU35.SCHED
     84118           -39.4%      50963 ±  3%  softirqs.CPU36.RCU
      9782 ± 16%     +62.9%      15935 ±  6%  softirqs.CPU36.SCHED
     85110           -40.0%      51085 ±  3%  softirqs.CPU37.RCU
      9587 ± 15%     +65.5%      15866 ±  5%  softirqs.CPU37.SCHED
     85245 ±  2%     -40.1%      51046 ±  3%  softirqs.CPU38.RCU
      9434 ± 13%     +69.1%      15955 ±  4%  softirqs.CPU38.SCHED
     84202           -39.8%      50729 ±  3%  softirqs.CPU39.RCU
      9671 ± 11%     +63.8%      15841 ±  5%  softirqs.CPU39.SCHED
     83756 ±  3%     -40.1%      50200 ±  3%  softirqs.CPU4.RCU
      8758 ±  6%     +67.9%      14703 ±  5%  softirqs.CPU4.SCHED
     84595           -40.2%      50626 ±  3%  softirqs.CPU40.RCU
      9627 ± 15%     +62.6%      15651 ±  7%  softirqs.CPU40.SCHED
     83591           -39.5%      50583 ±  3%  softirqs.CPU41.RCU
      8874 ±  8%     +80.0%      15972 ±  6%  softirqs.CPU41.SCHED
     84667 ±  2%     -39.9%      50851 ±  3%  softirqs.CPU42.RCU
      9534 ± 17%     +66.2%      15850 ±  5%  softirqs.CPU42.SCHED
     85428 ±  2%     -40.2%      51057 ±  3%  softirqs.CPU43.RCU
      9135 ±  9%     +75.2%      16002 ±  4%  softirqs.CPU43.SCHED
     84516 ±  2%     -40.1%      50629 ±  3%  softirqs.CPU44.RCU
      9459 ± 13%     +68.8%      15971 ±  4%  softirqs.CPU44.SCHED
     85668           -40.8%      50691 ±  3%  softirqs.CPU45.RCU
      9758 ± 19%     +62.6%      15862 ±  6%  softirqs.CPU45.SCHED
     84519           -40.4%      50333 ±  3%  softirqs.CPU46.RCU
      9430 ± 11%     +69.3%      15970 ±  4%  softirqs.CPU46.SCHED
     84197           -40.3%      50268 ±  3%  softirqs.CPU47.RCU
      9879 ± 18%     +61.5%      15951 ±  5%  softirqs.CPU47.SCHED
     84157           -40.3%      50225 ±  3%  softirqs.CPU48.RCU
      9486 ± 15%     +70.4%      16166 ±  4%  softirqs.CPU48.SCHED
     84677           -40.9%      50082 ±  4%  softirqs.CPU49.RCU
      9683 ± 12%     +63.1%      15789 ±  5%  softirqs.CPU49.SCHED
     83127           -39.5%      50295 ±  3%  softirqs.CPU5.RCU
      8662 ±  6%     +68.8%      14625 ±  6%  softirqs.CPU5.SCHED
     84627           -40.4%      50461 ±  3%  softirqs.CPU50.RCU
      9172 ± 11%     +72.1%      15788 ±  3%  softirqs.CPU50.SCHED
     85517           -41.2%      50256 ±  3%  softirqs.CPU51.RCU
     10235 ± 18%     +57.5%      16117 ±  5%  softirqs.CPU51.SCHED
     89582 ±  2%     -41.6%      52277 ±  4%  softirqs.CPU52.RCU
      8268 ±  5%     +69.3%      13998 ±  5%  softirqs.CPU52.SCHED
     91542 ±  2%     -42.7%      52468 ±  3%  softirqs.CPU53.RCU
      8564 ±  4%     +67.9%      14382 ±  5%  softirqs.CPU53.SCHED
     91896 ±  2%     -42.8%      52597 ±  4%  softirqs.CPU54.RCU
      7566 ±  4%     +77.8%      13452 ±  8%  softirqs.CPU54.SCHED
     91657 ±  3%     -41.9%      53221 ±  4%  softirqs.CPU55.RCU
      8339 ±  5%     +72.7%      14402 ±  4%  softirqs.CPU55.SCHED
     92388 ±  2%     -42.2%      53390 ±  2%  softirqs.CPU56.RCU
      8593 ±  5%     +67.9%      14426 ±  4%  softirqs.CPU56.SCHED
     91852           -41.7%      53505 ±  2%  softirqs.CPU57.RCU
      8502 ±  5%     +71.3%      14568 ±  4%  softirqs.CPU57.SCHED
     93510 ±  2%     -42.8%      53479 ±  2%  softirqs.CPU58.RCU
      8769 ±  7%     +66.6%      14611 ±  4%  softirqs.CPU58.SCHED
     87046 ± 10%     -39.3%      52836 ±  3%  softirqs.CPU59.RCU
      8785 ±  9%     +63.6%      14375 ±  5%  softirqs.CPU59.SCHED
     84834 ±  2%     -40.3%      50626 ±  3%  softirqs.CPU6.RCU
      8858 ±  6%     +65.3%      14639 ±  5%  softirqs.CPU6.SCHED
     83069           -39.6%      50157 ±  3%  softirqs.CPU60.RCU
      8628 ±  7%     +69.9%      14661 ±  5%  softirqs.CPU60.SCHED
     83152           -40.1%      49776 ±  3%  softirqs.CPU61.RCU
      8854 ± 10%     +63.8%      14501 ±  6%  softirqs.CPU61.SCHED
     82984           -40.1%      49686 ±  2%  softirqs.CPU62.RCU
      8622 ±  5%     +71.5%      14785 ±  5%  softirqs.CPU62.SCHED
     84589           -40.4%      50403 ±  2%  softirqs.CPU63.RCU
      8722 ±  7%     +67.0%      14565 ±  4%  softirqs.CPU63.SCHED
     84360           -40.3%      50355 ±  3%  softirqs.CPU64.RCU
      8807 ±  6%     +61.3%      14203 ±  4%  softirqs.CPU64.SCHED
     82988           -39.5%      50218 ±  3%  softirqs.CPU65.RCU
      8580 ±  5%     +69.1%      14506 ±  5%  softirqs.CPU65.SCHED
     80761 ±  7%     -37.3%      50666 ±  3%  softirqs.CPU66.RCU
      8602 ±  5%     +71.9%      14789 ±  4%  softirqs.CPU66.SCHED
     82949           -39.5%      50221 ±  3%  softirqs.CPU67.RCU
      8626 ±  6%     +71.1%      14762 ±  5%  softirqs.CPU67.SCHED
     83358           -39.0%      50882 ±  3%  softirqs.CPU68.RCU
      8559 ±  6%     +72.7%      14784 ±  3%  softirqs.CPU68.SCHED
     80823 ±  9%     -37.2%      50754 ±  3%  softirqs.CPU69.RCU
      8981 ± 12%     +63.6%      14693 ±  4%  softirqs.CPU69.SCHED
     81901 ±  7%     -38.3%      50504 ±  4%  softirqs.CPU7.RCU
      9028 ±  6%     +59.1%      14360 ±  6%  softirqs.CPU7.SCHED
     84749 ±  2%     -39.9%      50898 ±  3%  softirqs.CPU70.RCU
      8761 ±  7%     +67.9%      14707 ±  4%  softirqs.CPU70.SCHED
     84493 ±  2%     -39.7%      50972 ±  3%  softirqs.CPU71.RCU
      8746 ±  6%     +66.0%      14519 ±  6%  softirqs.CPU71.SCHED
     83345           -39.6%      50312 ±  3%  softirqs.CPU72.RCU
      8936 ± 12%     +63.5%      14610 ±  5%  softirqs.CPU72.SCHED
     83229           -39.0%      50755 ±  3%  softirqs.CPU73.RCU
      8482 ±  5%     +77.3%      15042 ±  5%  softirqs.CPU73.SCHED
     79942 ±  9%     -37.1%      50285 ±  3%  softirqs.CPU74.RCU
      8981 ±  7%     +64.1%      14740 ±  5%  softirqs.CPU74.SCHED
     83686 ±  2%     -41.2%      49243 ±  3%  softirqs.CPU75.RCU
      8671 ±  5%     +71.8%      14901 ±  5%  softirqs.CPU75.SCHED
     84048 ±  2%     -41.8%      48892 ±  4%  softirqs.CPU76.RCU
      9352 ±  8%     +57.0%      14684 ±  3%  softirqs.CPU76.SCHED
     80865 ±  7%     -39.9%      48572 ±  3%  softirqs.CPU77.RCU
      8789 ±  4%     +69.0%      14853 ±  4%  softirqs.CPU77.SCHED
     87858           -41.6%      51306 ±  3%  softirqs.CPU78.RCU
      9232 ±  9%     +69.4%      15642 ±  8%  softirqs.CPU78.SCHED
     88237           -40.7%      52303 ±  3%  softirqs.CPU79.RCU
     10236 ± 12%     +61.0%      16483 ±  9%  softirqs.CPU79.SCHED
     82490 ±  2%     -39.1%      50211 ±  3%  softirqs.CPU8.RCU
      8488 ±  5%     +69.0%      14344 ±  6%  softirqs.CPU8.SCHED
     88590           -41.2%      52132 ±  4%  softirqs.CPU80.RCU
     10327 ± 10%     +53.8%      15886 ±  5%  softirqs.CPU80.SCHED
     87957           -40.4%      52465 ±  3%  softirqs.CPU81.RCU
      9534 ± 13%     +73.0%      16494 ±  7%  softirqs.CPU81.SCHED
     87951           -40.6%      52263 ±  3%  softirqs.CPU82.RCU
      9557 ± 10%     +71.7%      16409 ±  7%  softirqs.CPU82.SCHED
     87989 ±  2%     -40.7%      52154 ±  3%  softirqs.CPU83.RCU
     10051 ± 23%     +59.6%      16040 ±  5%  softirqs.CPU83.SCHED
     87013 ±  4%     -40.0%      52210 ±  3%  softirqs.CPU84.RCU
     10147 ± 13%     +55.9%      15817 ±  6%  softirqs.CPU84.SCHED
     87829           -40.7%      52106 ±  3%  softirqs.CPU85.RCU
      9448 ± 11%     +69.9%      16054 ±  4%  softirqs.CPU85.SCHED
     88170           -40.3%      52637 ±  3%  softirqs.CPU86.RCU
      9309 ± 11%     +73.6%      16158 ±  5%  softirqs.CPU86.SCHED
     88373           -40.9%      52219 ±  3%  softirqs.CPU87.RCU
      9834 ± 12%     +63.0%      16033 ±  3%  softirqs.CPU87.SCHED
     87687           -40.3%      52361 ±  3%  softirqs.CPU88.RCU
      9885 ± 14%     +60.9%      15907 ±  7%  softirqs.CPU88.SCHED
     88035           -40.9%      52034 ±  3%  softirqs.CPU89.RCU
      9647 ± 13%     +65.9%      16003 ±  5%  softirqs.CPU89.SCHED
     82978 ±  2%     -40.2%      49601 ±  3%  softirqs.CPU9.RCU
      8802 ±  7%     +62.1%      14265 ±  5%  softirqs.CPU9.SCHED
     82405           -40.1%      49331 ±  2%  softirqs.CPU90.RCU
      9559 ± 14%     +67.0%      15961 ±  5%  softirqs.CPU90.SCHED
     81438           -39.6%      49209 ±  3%  softirqs.CPU91.RCU
      9803 ± 11%     +64.1%      16091 ±  7%  softirqs.CPU91.SCHED
     81721           -40.1%      48978 ±  3%  softirqs.CPU92.RCU
      9665 ± 13%     +63.8%      15828 ±  6%  softirqs.CPU92.SCHED
     81370           -39.7%      49067 ±  3%  softirqs.CPU93.RCU
      9448 ± 10%     +67.2%      15794 ±  6%  softirqs.CPU93.SCHED
     81624           -39.9%      49065 ±  3%  softirqs.CPU94.RCU
      9737 ± 16%     +64.4%      16010 ±  6%  softirqs.CPU94.SCHED
     81770           -39.6%      49413 ±  3%  softirqs.CPU95.RCU
      9066 ± 10%     +83.2%      16607 ±  9%  softirqs.CPU95.SCHED
     81782           -39.9%      49184 ±  3%  softirqs.CPU96.RCU
      9772 ± 14%     +61.6%      15792 ±  4%  softirqs.CPU96.SCHED
     82155           -40.0%      49329 ±  3%  softirqs.CPU97.RCU
      9878 ± 18%     +59.8%      15789 ±  6%  softirqs.CPU97.SCHED
     81298           -39.6%      49144 ±  3%  softirqs.CPU98.RCU
      9705 ± 14%     +63.7%      15889 ±  5%  softirqs.CPU98.SCHED
     81242           -39.4%      49224 ±  3%  softirqs.CPU99.RCU
      9817 ± 14%     +64.9%      16184 ±  5%  softirqs.CPU99.SCHED
   8852871           -40.1%    5301088 ±  3%  softirqs.RCU
    958083 ±  4%     +66.6%    1596070 ±  3%  softirqs.SCHED
     92537           -30.2%      64615 ±  2%  softirqs.TIMER
      1205           -29.0%     856.00 ±  2%  interrupts.9:IO-APIC.9-fasteoi.acpi
  89891349 ± 18%     -60.7%   35361947 ± 25%  interrupts.CAL:Function_call_interrupts
   1623974 ± 57%     -71.7%     459021 ± 84%  interrupts.CPU0.CAL:Function_call_interrupts
   1205651           -29.1%     855249 ±  2%  interrupts.CPU0.LOC:Local_timer_interrupts
   3196764 ±  7%     -66.4%    1072530 ±  6%  interrupts.CPU0.RES:Rescheduling_interrupts
      1205           -29.0%     856.00 ±  2%  interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
   1205641           -29.1%     855146 ±  2%  interrupts.CPU1.LOC:Local_timer_interrupts
   3425943 ±  6%     -69.8%    1033843 ± 10%  interrupts.CPU1.RES:Rescheduling_interrupts
    707756 ± 71%     -59.9%     283504 ± 29%  interrupts.CPU10.CAL:Function_call_interrupts
   1205637           -29.1%     855186 ±  2%  interrupts.CPU10.LOC:Local_timer_interrupts
   3586704 ±  2%     -70.0%    1076909 ±  6%  interrupts.CPU10.RES:Rescheduling_interrupts
   1205570           -29.1%     855284 ±  2%  interrupts.CPU100.LOC:Local_timer_interrupts
   3642188 ± 10%     -68.5%    1146714 ± 16%  interrupts.CPU100.RES:Rescheduling_interrupts
   1220194 ± 53%     -66.3%     411230 ± 58%  interrupts.CPU101.CAL:Function_call_interrupts
   1205569           -29.1%     855310 ±  2%  interrupts.CPU101.LOC:Local_timer_interrupts
   3686422 ±  9%     -69.4%    1127680 ±  8%  interrupts.CPU101.RES:Rescheduling_interrupts
   1205539           -29.1%     855303 ±  2%  interrupts.CPU102.LOC:Local_timer_interrupts
   3466868 ±  9%     -66.0%    1178496 ±  9%  interrupts.CPU102.RES:Rescheduling_interrupts
    753033 ± 38%     -51.9%     362540 ± 39%  interrupts.CPU103.CAL:Function_call_interrupts
   1205534           -29.1%     855323 ±  2%  interrupts.CPU103.LOC:Local_timer_interrupts
   3450153 ±  8%     -68.4%    1088970 ±  6%  interrupts.CPU103.RES:Rescheduling_interrupts
    724554 ± 60%     -62.5%     271669 ± 33%  interrupts.CPU11.CAL:Function_call_interrupts
   1205604           -29.1%     855122 ±  2%  interrupts.CPU11.LOC:Local_timer_interrupts
   3400360 ±  6%     -68.8%    1061657 ± 15%  interrupts.CPU11.RES:Rescheduling_interrupts
    641236 ± 59%     -61.2%     248758 ± 32%  interrupts.CPU12.CAL:Function_call_interrupts
   1205609           -29.1%     855116 ±  2%  interrupts.CPU12.LOC:Local_timer_interrupts
   3561488 ±  5%     -70.5%    1050780 ±  8%  interrupts.CPU12.RES:Rescheduling_interrupts
    734040 ± 70%     -63.5%     268243 ± 31%  interrupts.CPU13.CAL:Function_call_interrupts
   1205642           -29.1%     855148 ±  2%  interrupts.CPU13.LOC:Local_timer_interrupts
   3308551 ±  8%     -66.5%    1109093 ±  8%  interrupts.CPU13.RES:Rescheduling_interrupts
    785202 ± 64%     -67.1%     258319 ± 29%  interrupts.CPU14.CAL:Function_call_interrupts
   1205608           -29.1%     855174 ±  2%  interrupts.CPU14.LOC:Local_timer_interrupts
   3615978 ±  7%     -70.6%    1063276 ±  8%  interrupts.CPU14.RES:Rescheduling_interrupts
    757597 ± 64%     -67.7%     244389 ± 16%  interrupts.CPU15.CAL:Function_call_interrupts
   1205614           -29.1%     855152 ±  2%  interrupts.CPU15.LOC:Local_timer_interrupts
   3343478 ±  4%     -66.8%    1110832 ± 11%  interrupts.CPU15.RES:Rescheduling_interrupts
    505614 ± 44%     -54.3%     230896 ± 17%  interrupts.CPU16.CAL:Function_call_interrupts
   1205612           -29.1%     855161 ±  2%  interrupts.CPU16.LOC:Local_timer_interrupts
   3677516 ±  9%     -74.0%     957228 ±  4%  interrupts.CPU16.RES:Rescheduling_interrupts
    756708 ± 52%     -70.5%     223318 ± 17%  interrupts.CPU17.CAL:Function_call_interrupts
   1205608           -29.1%     855129 ±  2%  interrupts.CPU17.LOC:Local_timer_interrupts
   3411368 ±  3%     -70.5%    1005739 ±  9%  interrupts.CPU17.RES:Rescheduling_interrupts
    650745 ± 48%     -64.0%     234382 ± 15%  interrupts.CPU18.CAL:Function_call_interrupts
   1205588           -29.1%     855144 ±  2%  interrupts.CPU18.LOC:Local_timer_interrupts
   3489665 ±  6%     -67.4%    1137268 ± 20%  interrupts.CPU18.RES:Rescheduling_interrupts
   1205594           -29.1%     855172 ±  2%  interrupts.CPU19.LOC:Local_timer_interrupts
   3184389 ±  4%     -67.2%    1044787 ± 12%  interrupts.CPU19.RES:Rescheduling_interrupts
   1205645           -29.1%     855163 ±  2%  interrupts.CPU2.LOC:Local_timer_interrupts
   3344801 ±  5%     -67.3%    1094443 ±  6%  interrupts.CPU2.RES:Rescheduling_interrupts
    718386 ± 67%     -63.5%     262499 ± 19%  interrupts.CPU20.CAL:Function_call_interrupts
   1205599           -29.1%     855188 ±  2%  interrupts.CPU20.LOC:Local_timer_interrupts
   3403935 ±  6%     -67.7%    1100497 ±  8%  interrupts.CPU20.RES:Rescheduling_interrupts
   1205604           -29.1%     855136 ±  2%  interrupts.CPU21.LOC:Local_timer_interrupts
   3497519 ±  8%     -69.7%    1060157 ± 11%  interrupts.CPU21.RES:Rescheduling_interrupts
    775676 ± 52%     -55.6%     344109 ± 51%  interrupts.CPU22.CAL:Function_call_interrupts
   1205655           -29.1%     855162 ±  2%  interrupts.CPU22.LOC:Local_timer_interrupts
   3455529 ±  6%     -67.9%    1108198 ± 10%  interrupts.CPU22.RES:Rescheduling_interrupts
    705272 ± 56%     -62.7%     262796 ± 21%  interrupts.CPU23.CAL:Function_call_interrupts
   1205628           -29.1%     855179 ±  2%  interrupts.CPU23.LOC:Local_timer_interrupts
   3677020 ±  9%     -71.0%    1066870 ±  6%  interrupts.CPU23.RES:Rescheduling_interrupts
   1205621           -29.1%     855116 ±  2%  interrupts.CPU24.LOC:Local_timer_interrupts
   3311684 ±  6%     -69.2%    1020747 ±  3%  interrupts.CPU24.RES:Rescheduling_interrupts
    656460 ± 67%     -65.4%     227021 ± 16%  interrupts.CPU25.CAL:Function_call_interrupts
   1205631           -29.1%     855144 ±  2%  interrupts.CPU25.LOC:Local_timer_interrupts
   3232461 ±  7%     -68.0%    1034332 ± 13%  interrupts.CPU25.RES:Rescheduling_interrupts
   1205541           -29.1%     855326 ±  2%  interrupts.CPU26.LOC:Local_timer_interrupts
   2889950 ± 15%     -61.4%    1115390 ±  6%  interrupts.CPU26.RES:Rescheduling_interrupts
   1026174 ± 48%     -69.4%     314389 ± 32%  interrupts.CPU27.CAL:Function_call_interrupts
   1205558           -29.1%     855282 ±  2%  interrupts.CPU27.LOC:Local_timer_interrupts
   3593896 ±  7%     -69.9%    1081988 ±  7%  interrupts.CPU27.RES:Rescheduling_interrupts
    984752 ± 53%     -64.3%     351367 ± 48%  interrupts.CPU28.CAL:Function_call_interrupts
   1205555           -29.1%     855306 ±  2%  interrupts.CPU28.LOC:Local_timer_interrupts
   3424262 ± 10%     -67.1%    1127593 ±  9%  interrupts.CPU28.RES:Rescheduling_interrupts
   1205576           -29.1%     855297 ±  2%  interrupts.CPU29.LOC:Local_timer_interrupts
   3512273 ±  8%     -68.6%    1104147 ± 12%  interrupts.CPU29.RES:Rescheduling_interrupts
    669897 ± 54%     -58.9%     275239 ± 27%  interrupts.CPU3.CAL:Function_call_interrupts
   1205627           -29.1%     855178 ±  2%  interrupts.CPU3.LOC:Local_timer_interrupts
   3595156 ±  5%     -69.9%    1082314 ±  8%  interrupts.CPU3.RES:Rescheduling_interrupts
   1004398 ± 38%     -58.3%     418341 ± 60%  interrupts.CPU30.CAL:Function_call_interrupts
   1205681           -29.1%     855320 ±  2%  interrupts.CPU30.LOC:Local_timer_interrupts
   3499045 ±  2%     -68.5%    1101860 ±  9%  interrupts.CPU30.RES:Rescheduling_interrupts
   1112178 ± 39%     -67.4%     362178 ± 36%  interrupts.CPU31.CAL:Function_call_interrupts
   1205626           -29.1%     855320 ±  2%  interrupts.CPU31.LOC:Local_timer_interrupts
   3329087 ±  4%     -65.4%    1153373 ±  7%  interrupts.CPU31.RES:Rescheduling_interrupts
   1205545           -29.0%     855336 ±  2%  interrupts.CPU32.LOC:Local_timer_interrupts
   3613423 ±  7%     -67.6%    1169236 ± 11%  interrupts.CPU32.RES:Rescheduling_interrupts
   1205644           -29.1%     855326 ±  2%  interrupts.CPU33.LOC:Local_timer_interrupts
   3581469 ±  8%     -68.2%    1140463 ± 10%  interrupts.CPU33.RES:Rescheduling_interrupts
   1205560           -29.1%     855270 ±  2%  interrupts.CPU34.LOC:Local_timer_interrupts
   3470665 ±  4%     -65.9%    1182794 ± 12%  interrupts.CPU34.RES:Rescheduling_interrupts
   1205608           -29.1%     855330 ±  2%  interrupts.CPU35.LOC:Local_timer_interrupts
   3591355 ±  6%     -67.4%    1169240 ± 13%  interrupts.CPU35.RES:Rescheduling_interrupts
   1205561           -29.1%     855312 ±  2%  interrupts.CPU36.LOC:Local_timer_interrupts
   3565397 ±  7%     -68.0%    1141008 ±  8%  interrupts.CPU36.RES:Rescheduling_interrupts
   1205566           -29.1%     855277 ±  2%  interrupts.CPU37.LOC:Local_timer_interrupts
   3496519 ±  4%     -69.1%    1079423 ±  7%  interrupts.CPU37.RES:Rescheduling_interrupts
   1205562           -29.1%     855258 ±  2%  interrupts.CPU38.LOC:Local_timer_interrupts
   3564781 ±  7%     -69.5%    1088902 ± 12%  interrupts.CPU38.RES:Rescheduling_interrupts
   1205555           -29.0%     855356 ±  2%  interrupts.CPU39.LOC:Local_timer_interrupts
   3286445 ±  9%     -64.2%    1177572 ± 13%  interrupts.CPU39.RES:Rescheduling_interrupts
    487100 ± 43%     -47.5%     255865 ± 23%  interrupts.CPU4.CAL:Function_call_interrupts
   1205646           -29.1%     855198 ±  2%  interrupts.CPU4.LOC:Local_timer_interrupts
   3273624 ±  5%     -66.2%    1106857 ± 15%  interrupts.CPU4.RES:Rescheduling_interrupts
   1205633           -29.1%     855273 ±  2%  interrupts.CPU40.LOC:Local_timer_interrupts
   3479005           -64.1%    1248042 ± 12%  interrupts.CPU40.RES:Rescheduling_interrupts
   1205609           -29.1%     855264 ±  2%  interrupts.CPU41.LOC:Local_timer_interrupts
   3647883 ± 10%     -68.3%    1157486 ±  7%  interrupts.CPU41.RES:Rescheduling_interrupts
   1205645           -29.1%     855251 ±  2%  interrupts.CPU42.LOC:Local_timer_interrupts
   3676170 ±  7%     -69.2%    1133012 ± 10%  interrupts.CPU42.RES:Rescheduling_interrupts
   1205540           -29.1%     855299 ±  2%  interrupts.CPU43.LOC:Local_timer_interrupts
   3629110 ±  8%     -69.7%    1100768 ±  5%  interrupts.CPU43.RES:Rescheduling_interrupts
   1205622           -29.1%     855335 ±  2%  interrupts.CPU44.LOC:Local_timer_interrupts
   3463203 ±  5%     -64.9%    1215805 ± 13%  interrupts.CPU44.RES:Rescheduling_interrupts
   1079682 ± 54%     -71.2%     310597 ± 37%  interrupts.CPU45.CAL:Function_call_interrupts
   1205568           -29.1%     855297 ±  2%  interrupts.CPU45.LOC:Local_timer_interrupts
   3679792 ± 19%     -69.9%    1108076 ±  9%  interrupts.CPU45.RES:Rescheduling_interrupts
   1205556           -29.1%     855281 ±  2%  interrupts.CPU46.LOC:Local_timer_interrupts
   3498927 ±  6%     -67.1%    1151118 ± 10%  interrupts.CPU46.RES:Rescheduling_interrupts
   1205560           -29.1%     855311 ±  2%  interrupts.CPU47.LOC:Local_timer_interrupts
   3719213 ±  6%     -68.3%    1178088 ± 14%  interrupts.CPU47.RES:Rescheduling_interrupts
   1205608           -29.1%     855310 ±  2%  interrupts.CPU48.LOC:Local_timer_interrupts
   3651264 ±  8%     -69.0%    1132056 ± 14%  interrupts.CPU48.RES:Rescheduling_interrupts
   1235025 ± 51%     -66.8%     409515 ± 54%  interrupts.CPU49.CAL:Function_call_interrupts
   1205544           -29.0%     855344 ±  2%  interrupts.CPU49.LOC:Local_timer_interrupts
   3487785 ±  6%     -68.7%    1091874 ±  6%  interrupts.CPU49.RES:Rescheduling_interrupts
    649411 ± 60%     -56.1%     284866 ± 37%  interrupts.CPU5.CAL:Function_call_interrupts
   1205621           -29.1%     855152 ±  2%  interrupts.CPU5.LOC:Local_timer_interrupts
   3481679 ±  5%     -68.2%    1107732 ± 17%  interrupts.CPU5.RES:Rescheduling_interrupts
   1205609           -29.1%     855312 ±  2%  interrupts.CPU50.LOC:Local_timer_interrupts
   3656124 ±  5%     -67.7%    1180412 ± 10%  interrupts.CPU50.RES:Rescheduling_interrupts
   1205628           -29.1%     855379 ±  2%  interrupts.CPU51.LOC:Local_timer_interrupts
   3642072 ±  9%     -70.0%    1093120 ±  8%  interrupts.CPU51.RES:Rescheduling_interrupts
   1535288 ± 61%     -73.9%     400663 ± 64%  interrupts.CPU52.CAL:Function_call_interrupts
   1205570           -29.1%     855149 ±  2%  interrupts.CPU52.LOC:Local_timer_interrupts
   3181327 ±  8%     -66.1%    1079937 ±  4%  interrupts.CPU52.RES:Rescheduling_interrupts
   1205565           -29.1%     855109 ±  2%  interrupts.CPU53.LOC:Local_timer_interrupts
   3287450 ±  9%     -68.9%    1022387 ±  7%  interrupts.CPU53.RES:Rescheduling_interrupts
   1205586           -29.1%     855161 ±  2%  interrupts.CPU54.LOC:Local_timer_interrupts
   3447162 ±  8%     -68.2%    1095360 ±  9%  interrupts.CPU54.RES:Rescheduling_interrupts
    673858 ± 62%     -57.6%     285884 ± 29%  interrupts.CPU55.CAL:Function_call_interrupts
   1205592           -29.1%     855167 ±  2%  interrupts.CPU55.LOC:Local_timer_interrupts
   3681265 ±  4%     -69.9%    1107408 ±  9%  interrupts.CPU55.RES:Rescheduling_interrupts
   1205653           -29.1%     855132 ±  2%  interrupts.CPU56.LOC:Local_timer_interrupts
   3492355 ±  5%     -69.2%    1074433 ± 17%  interrupts.CPU56.RES:Rescheduling_interrupts
    609594 ± 74%     -57.4%     259486 ± 30%  interrupts.CPU57.CAL:Function_call_interrupts
   1205600           -29.1%     855174 ±  2%  interrupts.CPU57.LOC:Local_timer_interrupts
   3250090 ±  8%     -68.5%    1023666 ± 13%  interrupts.CPU57.RES:Rescheduling_interrupts
   1205585           -29.1%     855155 ±  2%  interrupts.CPU58.LOC:Local_timer_interrupts
   3292319 ±  6%     -67.8%    1059167 ± 12%  interrupts.CPU58.RES:Rescheduling_interrupts
    589279 ± 38%     -54.7%     266987 ± 21%  interrupts.CPU59.CAL:Function_call_interrupts
   1205592           -29.1%     855127 ±  2%  interrupts.CPU59.LOC:Local_timer_interrupts
   2995999 ± 12%     -64.6%    1060886 ± 11%  interrupts.CPU59.RES:Rescheduling_interrupts
    604415 ± 67%     -60.6%     237906 ± 18%  interrupts.CPU6.CAL:Function_call_interrupts
   1205626           -29.1%     855145 ±  2%  interrupts.CPU6.LOC:Local_timer_interrupts
   3320534 ±  7%     -68.0%    1062145 ± 11%  interrupts.CPU6.RES:Rescheduling_interrupts
    681116 ± 56%     -57.6%     288687 ± 31%  interrupts.CPU60.CAL:Function_call_interrupts
   1205605           -29.1%     855108 ±  2%  interrupts.CPU60.LOC:Local_timer_interrupts
   3447925 ± 11%     -68.3%    1092859 ± 16%  interrupts.CPU60.RES:Rescheduling_interrupts
   1205600           -29.1%     855136 ±  2%  interrupts.CPU61.LOC:Local_timer_interrupts
   3688455 ± 10%     -68.8%    1149466 ± 12%  interrupts.CPU61.RES:Rescheduling_interrupts
   1205607           -29.1%     855183 ±  2%  interrupts.CPU62.LOC:Local_timer_interrupts
   3384029 ±  7%     -68.4%    1070519 ±  8%  interrupts.CPU62.RES:Rescheduling_interrupts
    549499 ± 52%     -56.7%     237951 ± 27%  interrupts.CPU63.CAL:Function_call_interrupts
   1205597           -29.1%     855069 ±  2%  interrupts.CPU63.LOC:Local_timer_interrupts
   3329589 ±  6%     -69.4%    1017592 ± 10%  interrupts.CPU63.RES:Rescheduling_interrupts
    612129 ± 48%     -59.2%     249650 ± 31%  interrupts.CPU64.CAL:Function_call_interrupts
   1205619           -29.1%     855146 ±  2%  interrupts.CPU64.LOC:Local_timer_interrupts
      7832           -23.7%       5977 ± 27%  interrupts.CPU64.NMI:Non-maskable_interrupts
      7832           -23.7%       5977 ± 27%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
   3357501 ± 11%     -69.3%    1029447 ±  8%  interrupts.CPU64.RES:Rescheduling_interrupts
    659883 ± 70%     -61.9%     251209 ± 26%  interrupts.CPU65.CAL:Function_call_interrupts
   1205621           -29.1%     855152 ±  2%  interrupts.CPU65.LOC:Local_timer_interrupts
   3421441 ± 12%     -68.0%    1093274 ± 11%  interrupts.CPU65.RES:Rescheduling_interrupts
    569279 ± 75%     -52.3%     271317 ± 26%  interrupts.CPU66.CAL:Function_call_interrupts
   1205711           -29.1%     855164 ±  2%  interrupts.CPU66.LOC:Local_timer_interrupts
   3597977 ± 10%     -70.5%    1059957 ±  8%  interrupts.CPU66.RES:Rescheduling_interrupts
    772167 ± 57%     -69.0%     239751 ± 14%  interrupts.CPU67.CAL:Function_call_interrupts
   1205625           -29.1%     855124 ±  2%  interrupts.CPU67.LOC:Local_timer_interrupts
   3415111 ±  5%     -67.5%    1110632 ±  8%  interrupts.CPU67.RES:Rescheduling_interrupts
    454837 ± 40%     -50.0%     227206 ± 15%  interrupts.CPU68.CAL:Function_call_interrupts
   1205569           -29.1%     855170 ±  2%  interrupts.CPU68.LOC:Local_timer_interrupts
      7836           -38.8%       4795 ± 35%  interrupts.CPU68.NMI:Non-maskable_interrupts
      7836           -38.8%       4795 ± 35%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
   3416078 ±  8%     -72.0%     956119 ±  5%  interrupts.CPU68.RES:Rescheduling_interrupts
    627063 ± 46%     -60.8%     246039 ± 27%  interrupts.CPU69.CAL:Function_call_interrupts
   1205639           -29.1%     855170 ±  2%  interrupts.CPU69.LOC:Local_timer_interrupts
   3327270 ±  6%     -69.3%    1020049 ± 11%  interrupts.CPU69.RES:Rescheduling_interrupts
    593490 ± 42%     -52.4%     282559 ± 29%  interrupts.CPU7.CAL:Function_call_interrupts
   1205657           -29.1%     855174 ±  2%  interrupts.CPU7.LOC:Local_timer_interrupts
   3303249 ±  5%     -67.7%    1067112 ± 10%  interrupts.CPU7.RES:Rescheduling_interrupts
    652681 ± 58%     -65.0%     228460 ± 15%  interrupts.CPU70.CAL:Function_call_interrupts
   1205689           -29.1%     855186 ±  2%  interrupts.CPU70.LOC:Local_timer_interrupts
      7831           -38.9%       4784 ± 35%  interrupts.CPU70.NMI:Non-maskable_interrupts
      7831           -38.9%       4784 ± 35%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
   3225378 ±  9%     -67.3%    1055573 ±  9%  interrupts.CPU70.RES:Rescheduling_interrupts
   1205544           -29.1%     855158 ±  2%  interrupts.CPU71.LOC:Local_timer_interrupts
   3349906 ±  4%     -69.4%    1026051 ± 13%  interrupts.CPU71.RES:Rescheduling_interrupts
    667025 ± 62%     -58.9%     274338 ± 23%  interrupts.CPU72.CAL:Function_call_interrupts
   1205643           -29.1%     855196 ±  2%  interrupts.CPU72.LOC:Local_timer_interrupts
   3452935 ± 10%     -68.3%    1096091 ±  8%  interrupts.CPU72.RES:Rescheduling_interrupts
   1205653           -29.1%     855183 ±  2%  interrupts.CPU73.LOC:Local_timer_interrupts
   3347362 ± 14%     -66.9%    1107626 ± 12%  interrupts.CPU73.RES:Rescheduling_interrupts
   1205609           -29.1%     855130 ±  2%  interrupts.CPU74.LOC:Local_timer_interrupts
   3510382 ±  9%     -67.8%    1128850 ± 12%  interrupts.CPU74.RES:Rescheduling_interrupts
   1205610           -29.1%     855095 ±  2%  interrupts.CPU75.LOC:Local_timer_interrupts
   3684382 ±  5%     -69.9%    1108322 ±  8%  interrupts.CPU75.RES:Rescheduling_interrupts
   1205626           -29.1%     855135 ±  2%  interrupts.CPU76.LOC:Local_timer_interrupts
   3424662 ±  8%     -70.0%    1026323 ±  5%  interrupts.CPU76.RES:Rescheduling_interrupts
    679078 ± 73%     -65.9%     231660 ± 18%  interrupts.CPU77.CAL:Function_call_interrupts
   1205618           -29.1%     855181 ±  2%  interrupts.CPU77.LOC:Local_timer_interrupts
   3145940 ±  8%     -66.5%    1055195 ± 12%  interrupts.CPU77.RES:Rescheduling_interrupts
   1205573           -29.1%     855322 ±  2%  interrupts.CPU78.LOC:Local_timer_interrupts
   2959807 ± 11%     -62.0%    1126121 ±  8%  interrupts.CPU78.RES:Rescheduling_interrupts
   1036604 ± 45%     -68.8%     323128 ± 30%  interrupts.CPU79.CAL:Function_call_interrupts
   1205615           -29.1%     855298 ±  2%  interrupts.CPU79.LOC:Local_timer_interrupts
   3462919 ±  7%     -69.0%    1071952 ±  7%  interrupts.CPU79.RES:Rescheduling_interrupts
   1205598           -29.1%     855153 ±  2%  interrupts.CPU8.LOC:Local_timer_interrupts
   3589350 ±  7%     -69.3%    1101811 ± 16%  interrupts.CPU8.RES:Rescheduling_interrupts
   1205586           -29.1%     855353 ±  2%  interrupts.CPU80.LOC:Local_timer_interrupts
   3502569 ±  9%     -68.1%    1118950 ±  9%  interrupts.CPU80.RES:Rescheduling_interrupts
   1205553           -29.1%     855317 ±  2%  interrupts.CPU81.LOC:Local_timer_interrupts
   3453668 ±  2%     -67.5%    1124145 ± 11%  interrupts.CPU81.RES:Rescheduling_interrupts
   1205574           -29.0%     855366 ±  2%  interrupts.CPU82.LOC:Local_timer_interrupts
   3443920 ±  9%     -68.3%    1092950 ±  5%  interrupts.CPU82.RES:Rescheduling_interrupts
   1205620           -29.1%     855340 ±  2%  interrupts.CPU83.LOC:Local_timer_interrupts
   3332776 ±  5%     -65.4%    1152593 ±  6%  interrupts.CPU83.RES:Rescheduling_interrupts
   1205595           -29.0%     855383 ±  2%  interrupts.CPU84.LOC:Local_timer_interrupts
   3298021 ± 11%     -63.9%    1191118 ± 13%  interrupts.CPU84.RES:Rescheduling_interrupts
   1205568           -29.1%     855327 ±  2%  interrupts.CPU85.LOC:Local_timer_interrupts
   3403587 ±  7%     -65.2%    1185507 ±  9%  interrupts.CPU85.RES:Rescheduling_interrupts
   1205556           -29.0%     855358 ±  2%  interrupts.CPU86.LOC:Local_timer_interrupts
   3413766 ±  6%     -65.8%    1168950 ± 11%  interrupts.CPU86.RES:Rescheduling_interrupts
   1205588           -29.1%     855254 ±  2%  interrupts.CPU87.LOC:Local_timer_interrupts
   3819022 ±  3%     -69.0%    1182764 ± 11%  interrupts.CPU87.RES:Rescheduling_interrupts
   1205634           -29.0%     855403 ±  2%  interrupts.CPU88.LOC:Local_timer_interrupts
   3554878 ±  4%     -68.0%    1135894 ±  9%  interrupts.CPU88.RES:Rescheduling_interrupts
   1205618           -29.1%     855273 ±  2%  interrupts.CPU89.LOC:Local_timer_interrupts
   3506043 ±  4%     -69.3%    1075922 ±  3%  interrupts.CPU89.RES:Rescheduling_interrupts
    637361 ± 38%     -54.9%     287418 ± 24%  interrupts.CPU9.CAL:Function_call_interrupts
   1205624           -29.1%     855173 ±  2%  interrupts.CPU9.LOC:Local_timer_interrupts
   3575063 ±  4%     -66.4%    1200524 ± 15%  interrupts.CPU9.RES:Rescheduling_interrupts
   1205711           -29.1%     855277 ±  2%  interrupts.CPU90.LOC:Local_timer_interrupts
   3540800 ±  7%     -68.4%    1118482 ±  9%  interrupts.CPU90.RES:Rescheduling_interrupts
   1205569           -29.1%     855324 ±  2%  interrupts.CPU91.LOC:Local_timer_interrupts
   3631748 ±  6%     -67.7%    1172587 ± 14%  interrupts.CPU91.RES:Rescheduling_interrupts
   1205564           -29.1%     855323 ±  2%  interrupts.CPU92.LOC:Local_timer_interrupts
   3573401 ±  6%     -66.0%    1216552 ± 13%  interrupts.CPU92.RES:Rescheduling_interrupts
   1205583           -29.1%     855337 ±  2%  interrupts.CPU93.LOC:Local_timer_interrupts
   3802054 ±  9%     -69.1%    1173720 ± 10%  interrupts.CPU93.RES:Rescheduling_interrupts
   1205561           -29.1%     855271 ±  2%  interrupts.CPU94.LOC:Local_timer_interrupts
   3658583 ± 16%     -68.8%    1140697 ±  7%  interrupts.CPU94.RES:Rescheduling_interrupts
   1205530           -29.1%     855297 ±  2%  interrupts.CPU95.LOC:Local_timer_interrupts
   3497532 ±  8%     -68.3%    1109998 ±  7%  interrupts.CPU95.RES:Rescheduling_interrupts
   1205578           -29.1%     855338 ±  2%  interrupts.CPU96.LOC:Local_timer_interrupts
   3462753 ± 11%     -66.0%    1177706 ± 11%  interrupts.CPU96.RES:Rescheduling_interrupts
   1098954 ± 63%     -69.3%     337065 ± 44%  interrupts.CPU97.CAL:Function_call_interrupts
   1205573           -29.1%     855301 ±  2%  interrupts.CPU97.LOC:Local_timer_interrupts
   3430508 ±  7%     -67.5%    1114780 ±  8%  interrupts.CPU97.RES:Rescheduling_interrupts
   1205586           -29.1%     855315 ±  2%  interrupts.CPU98.LOC:Local_timer_interrupts
   3582330 ±  6%     -68.1%    1142146 ±  9%  interrupts.CPU98.RES:Rescheduling_interrupts
   1082601 ± 43%     -65.9%     369132 ± 51%  interrupts.CPU99.CAL:Function_call_interrupts
   1205570           -29.0%     855354 ±  2%  interrupts.CPU99.LOC:Local_timer_interrupts
   3408496 ±  9%     -65.4%    1179828 ± 15%  interrupts.CPU99.RES:Rescheduling_interrupts
    506.50 ±  2%    +358.4%       2321 ± 35%  interrupts.IWI:IRQ_work_interrupts
 1.254e+08           -29.1%   88944386 ±  2%  interrupts.LOC:Local_timer_interrupts
 3.601e+08           -68.1%   1.15e+08 ±  5%  interrupts.RES:Rescheduling_interrupts
     23.71 ±  6%     -12.3       11.38 ± 15%  perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     23.78 ±  6%     -12.3       11.46 ± 15%  perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
     24.29 ±  6%     -10.1       14.15 ± 18%  perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
     44.65            -8.8       35.82 ± 44%  perf-profile.calltrace.cycles-pp.__libc_read
     12.80 ±  6%      -8.8        4.03 ± 15%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
     41.47            -8.1       33.38 ± 44%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read
     41.23            -8.0       33.26 ± 44%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      7.15 ±  5%      -7.1        0.00        perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     10.39 ±  5%      -5.7        4.71 ± 16%  perf-profile.calltrace.cycles-pp.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     12.04 ±  4%      -4.3        7.71 ± 15%  perf-profile.calltrace.cycles-pp.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
     10.12 ±  7%      -3.8        6.31 ± 16%  perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     10.20 ±  7%      -3.8        6.41 ± 16%  perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      7.54 ±  7%      -3.5        4.06 ± 15%  perf-profile.calltrace.cycles-pp.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      4.26 ±  6%      -1.8        2.49 ± 17%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      4.50 ±  2%      -1.8        2.72 ± 45%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      3.31 ±  7%      -1.3        1.98 ± 21%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common
      1.24 ±  3%      -0.9        0.32 ±102%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      2.40 ±  7%      -0.9        1.49 ± 27%  perf-profile.calltrace.cycles-pp.select_idle_cpu.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function
     41.59            -0.7       40.88        perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write
     42.10            -0.6       41.50        perf-profile.calltrace.cycles-pp.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write.ksys_write
      1.01 ±  3%      -0.5        0.47 ± 45%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      0.46 ± 44%      +0.2        0.65 ±  6%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.63 ±  4%      +0.2        0.84 ±  8%  perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.44 ± 44%      +0.3        0.73 ± 10%  perf-profile.calltrace.cycles-pp.__fget_files.__fget_light.__fdget_pos.ksys_write.do_syscall_64
      0.62 ±  2%      +0.3        0.94 ±  9%  perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      0.64 ±  2%      +0.3        0.97 ±  9%  perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      0.80 ±  2%      +0.4        1.16 ± 10%  perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      0.55 ±  5%      +0.4        0.92 ± 11%  perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      0.60 ±  7%      +0.5        1.08 ± 29%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      0.46 ± 45%      +0.5        0.95 ± 15%  perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      0.08 ±223%      +0.5        0.58 ±  5%  perf-profile.calltrace.cycles-pp.sock_recvmsg.sock_read_iter.new_sync_read.vfs_read.ksys_read
      1.03 ±  2%      +0.5        1.53 ± 12%  perf-profile.calltrace.cycles-pp.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.97 ±  2%      +0.5        1.47 ± 13%  perf-profile.calltrace.cycles-pp.unix_destruct_scm.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic
      1.01 ±  2%      +0.5        1.52 ± 12%  perf-profile.calltrace.cycles-pp.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      0.76 ±  4%      +0.5        1.30 ± 14%  perf-profile.calltrace.cycles-pp.sock_wfree.unix_destruct_scm.skb_release_head_state.skb_release_all.consume_skb
      1.58            +0.7        2.25 ±  9%  perf-profile.calltrace.cycles-pp.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      1.54            +0.7        2.23 ±  9%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      1.50            +0.7        2.19 ±  9%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg
      0.18 ±141%      +0.7        0.88 ± 11%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      0.00            +0.7        0.70 ± 12%  perf-profile.calltrace.cycles-pp.__slab_free.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00            +0.8        0.77 ± 12%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00            +1.0        0.96 ± 31%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__schedule.schedule.schedule_timeout
      1.10 ±  9%      +1.0        2.14 ± 29%  perf-profile.calltrace.cycles-pp._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.64 ± 16%      +1.3        1.93 ± 30%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.00            +1.3        1.33 ± 20%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.obj_cgroup_uncharge_pages.kmem_cache_free.unix_stream_read_generic
      0.11 ±223%      +1.7        1.80 ± 21%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule.exit_to_user_mode_prepare
      0.00            +1.7        1.69 ± 19%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.obj_cgroup_uncharge_pages.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
      0.12 ±223%      +1.7        1.87 ± 22%  perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00            +1.8        1.82 ± 19%  perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00            +1.9        1.90 ± 34%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg
      0.26 ±100%      +1.9        2.21 ± 19%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.00            +2.0        2.00 ± 20%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb
      0.00            +2.1        2.06 ± 32%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_sendmsg
      0.00            +2.1        2.14 ± 19%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00            +2.7        2.66 ± 19%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.obj_cgroup_uncharge_pages.kfree.consume_skb
      4.48 ± 12%      +2.9        7.40 ± 20%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      4.38 ± 13%      +3.0        7.36 ± 20%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.67 ± 10%      +3.3        3.94 ± 20%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve
      0.91 ± 10%      +3.3        4.22 ± 19%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      0.98 ±  9%      +3.3        4.32 ± 19%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      0.00            +3.4        3.38 ± 19%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.obj_cgroup_uncharge_pages.kfree.consume_skb.unix_stream_read_generic
      0.00            +3.7        3.66 ± 19%  perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      3.65 ± 16%      +3.8        7.41 ± 16%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      2.40 ± 22%      +4.0        6.39 ± 20%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      0.20 ±223%      +4.4        4.61 ± 16%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule.schedule_timeout
      0.22 ±223%      +4.6        4.82 ± 16%  perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      1.75 ± 32%      +4.6        6.38 ± 16%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      0.94 ± 56%      +4.7        5.68 ± 20%  perf-profile.calltrace.cycles-pp.update_curr.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      0.84 ± 58%      +4.8        5.61 ± 15%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.22 ±223%      +4.8        5.03 ± 20%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.enqueue_entity
      0.22 ±223%      +4.9        5.14 ± 20%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.enqueue_entity.enqueue_task_fair
      0.21 ±223%      +4.9        5.13 ± 15%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_wakeup_template
      0.21 ±223%      +5.0        5.16 ± 15%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up
      0.21 ±223%      +5.0        5.17 ± 15%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function
      0.91 ± 59%      +5.0        5.95 ± 16%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.24 ±223%      +5.1        5.33 ± 20%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.enqueue_entity.enqueue_task_fair.ttwu_do_activate
      0.23 ±223%      +5.1        5.32 ± 16%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity
      0.26 ±223%      +5.2        5.43 ± 15%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.23 ±223%      +5.2        5.45 ± 16%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair
      0.26 ±223%      +5.4        5.61 ± 16%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair.__schedule
      0.30 ±223%      +5.9        6.18 ± 18%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch
      0.30 ±223%      +5.9        6.23 ± 18%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch.__schedule
      0.30 ±223%      +5.9        6.24 ± 18%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch.__schedule.schedule
      0.00            +6.0        5.96 ± 20%  perf-profile.calltrace.cycles-pp.unwind_next_frame.__unwind_start.perf_callchain_kernel.get_perf_callchain.perf_callchain
     13.17 ± 10%      +6.5       19.67 ± 16%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_sendmsg
     12.98 ± 10%      +6.6       19.54 ± 16%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg
      0.00            +6.6        6.57 ± 21%  perf-profile.calltrace.cycles-pp.unwind_next_frame.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample
     12.81 ± 10%      +6.6       19.44 ± 16%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable
      0.00            +7.0        6.95 ± 18%  perf-profile.calltrace.cycles-pp.__unwind_start.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample
      8.23 ± 14%      +7.2       15.44 ± 17%  perf-profile.calltrace.cycles-pp.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      8.02 ± 14%      +7.3       15.34 ± 17%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      7.82 ± 14%      +7.4       15.25 ± 17%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg
     13.78 ± 10%      +8.3       22.12 ± 15%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
     14.12 ± 10%      +8.6       22.67 ± 14%  perf-profile.calltrace.cycles-pp.sock_def_readable.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      0.44 ±223%      +9.8       10.26 ± 18%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime
      0.44 ±223%      +9.9       10.32 ± 18%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr
      0.77 ±223%     +16.9       17.66 ± 19%  perf-profile.calltrace.cycles-pp.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
      0.84 ±223%     +18.4       19.29 ± 18%  perf-profile.calltrace.cycles-pp.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
      0.85 ±223%     +18.6       19.40 ± 18%  perf-profile.calltrace.cycles-pp.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow
      0.92 ±223%     +20.2       21.07 ± 18%  perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event
     23.72 ±  6%     -12.3       11.40 ± 15%  perf-profile.children.cycles-pp.__alloc_skb
     23.78 ±  6%     -12.3       11.46 ± 15%  perf-profile.children.cycles-pp.alloc_skb_with_frags
     24.29 ±  6%     -10.1       14.16 ± 18%  perf-profile.children.cycles-pp.sock_alloc_send_pskb
     10.46 ±  5%      -9.9        0.55 ±  8%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
     44.80            -8.8       35.98 ± 44%  perf-profile.children.cycles-pp.__libc_read
     12.84 ±  6%      -8.8        4.07 ± 15%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
     10.40 ±  5%      -5.7        4.72 ± 16%  perf-profile.children.cycles-pp.kfree
     12.04 ±  4%      -4.3        7.71 ± 15%  perf-profile.children.cycles-pp.consume_skb
     10.17 ±  7%      -3.8        6.36 ± 16%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
     10.21 ±  7%      -3.8        6.42 ± 16%  perf-profile.children.cycles-pp.kmalloc_reserve
      3.80 ±  7%      -3.7        0.13 ± 11%  perf-profile.children.cycles-pp.refill_obj_stock
      7.56 ±  7%      -3.5        4.08 ± 15%  perf-profile.children.cycles-pp.kmem_cache_free
      3.32 ± 10%      -2.3        1.03 ± 11%  perf-profile.children.cycles-pp.mod_objcg_state
      4.28 ±  6%      -1.7        2.53 ± 17%  perf-profile.children.cycles-pp.select_task_rq_fair
     11.30 ±  3%      -1.7        9.58 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      2.54 ±  6%      -1.4        1.12 ± 19%  perf-profile.children.cycles-pp.pick_next_task_fair
      3.33 ±  7%      -1.3        2.01 ± 21%  perf-profile.children.cycles-pp.select_idle_sibling
      2.54 ±  4%      -1.2        1.36 ± 17%  perf-profile.children.cycles-pp.update_load_avg
      2.42 ±  7%      -0.9        1.53 ± 26%  perf-profile.children.cycles-pp.select_idle_cpu
      1.13 ± 10%      -0.8        0.30 ± 22%  perf-profile.children.cycles-pp.get_mem_cgroup_from_objcg
     41.62            -0.7       40.92        perf-profile.children.cycles-pp.unix_stream_sendmsg
      1.27 ±  8%      -0.7        0.58 ± 13%  perf-profile.children.cycles-pp.switch_fpu_return
      1.24 ±  5%      -0.7        0.56 ± 21%  perf-profile.children.cycles-pp.reweight_entity
     42.10            -0.6       41.52        perf-profile.children.cycles-pp.sock_sendmsg
      1.52 ±  8%      -0.6        0.97 ± 21%  perf-profile.children.cycles-pp.available_idle_cpu
      0.82 ±  4%      -0.4        0.38 ± 20%  perf-profile.children.cycles-pp.set_next_entity
      0.84 ±  3%      -0.4        0.44 ± 16%  perf-profile.children.cycles-pp.update_rq_clock
      0.78 ±  9%      -0.4        0.38 ± 18%  perf-profile.children.cycles-pp.__switch_to_asm
      0.62 ± 10%      -0.4        0.24 ± 23%  perf-profile.children.cycles-pp.pick_next_entity
      0.66 ±  4%      -0.4        0.29 ± 22%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.72 ±  4%      -0.4        0.36 ± 18%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.63 ±  3%      -0.4        0.28 ± 23%  perf-profile.children.cycles-pp.check_preempt_curr
      0.55 ±  3%      -0.3        0.21 ± 19%  perf-profile.children.cycles-pp.__enqueue_entity
      0.60 ±  9%      -0.3        0.28 ± 13%  perf-profile.children.cycles-pp.__switch_to
      0.50 ± 11%      -0.3        0.19 ± 20%  perf-profile.children.cycles-pp.put_prev_entity
      0.65 ±  4%      -0.3        0.35 ± 16%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.47 ±  6%      -0.3        0.21 ± 23%  perf-profile.children.cycles-pp.check_preempt_wakeup
      0.40 ± 10%      -0.2        0.18 ± 21%  perf-profile.children.cycles-pp.copy_fpregs_to_fpstate
      0.35 ±  9%      -0.2        0.13 ± 18%  perf-profile.children.cycles-pp.___perf_sw_event
      0.26 ± 13%      -0.2        0.10 ± 23%  perf-profile.children.cycles-pp.clear_buddies
      0.27 ±  7%      -0.1        0.13 ± 10%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.26 ±  9%      -0.1        0.13 ± 19%  perf-profile.children.cycles-pp.__calc_delta
      0.30 ±  3%      -0.1        0.16 ± 19%  perf-profile.children.cycles-pp.update_min_vruntime
      0.41 ±  3%      -0.1        0.28 ± 45%  perf-profile.children.cycles-pp.__pthread_disable_asynccancel
      0.27 ±  4%      -0.1        0.14 ± 22%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.20 ±  3%      -0.1        0.08 ± 16%  perf-profile.children.cycles-pp.rb_erase
      0.17 ±  8%      -0.1        0.08 ± 18%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.18 ± 11%      -0.1        0.10 ± 11%  perf-profile.children.cycles-pp.cpus_share_cache
      0.12 ±  6%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.clockevents_program_event
      0.23 ±  4%      -0.1        0.14 ±  7%  perf-profile.children.cycles-pp.preempt_schedule_common
      0.24 ±  6%      -0.1        0.16 ± 23%  perf-profile.children.cycles-pp._find_next_bit
      0.15 ±  9%      -0.1        0.07 ± 35%  perf-profile.children.cycles-pp.set_next_buddy
      0.14 ± 10%      -0.1        0.06 ± 23%  perf-profile.children.cycles-pp.resched_curr
      0.10 ± 11%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.13 ±  7%      -0.1        0.06 ± 20%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.25 ±  4%      -0.1        0.18 ± 10%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.14 ±  5%      -0.1        0.07 ± 20%  perf-profile.children.cycles-pp.rb_insert_color
      0.14 ± 14%      -0.1        0.07 ± 20%  perf-profile.children.cycles-pp.migrate_task_rq_fair
      0.41            -0.1        0.35 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.08 ±  4%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.rb_next
      0.11 ±  4%      -0.0        0.07 ± 18%  perf-profile.children.cycles-pp.__list_add_valid
      0.10 ±  6%      -0.0        0.06 ± 17%  perf-profile.children.cycles-pp.cpumask_next
      0.10 ± 10%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.08 ± 16%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.05            +0.0        0.07 ±  9%  perf-profile.children.cycles-pp.kmalloc_slab
      0.18 ±  3%      +0.0        0.21 ±  5%  perf-profile.children.cycles-pp.__might_fault
      0.10 ±  3%      +0.0        0.13 ±  7%  perf-profile.children.cycles-pp.apparmor_socket_getpeersec_dgram
      0.14 ±  3%      +0.0        0.18 ±  8%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.02 ±142%      +0.0        0.06 ± 14%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.15 ±  4%      +0.0        0.20 ±  6%  perf-profile.children.cycles-pp.security_socket_getpeersec_dgram
      0.15 ±  6%      +0.1        0.20        perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.10 ±  3%      +0.1        0.16 ± 12%  perf-profile.children.cycles-pp.aa_file_perm
      0.00            +0.1        0.06 ± 18%  perf-profile.children.cycles-pp.perf_trace_run_bpf_submit
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.rcu_is_watching
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.perf_swevent_get_recursion_context
      0.36 ±  4%      +0.1        0.42 ±  4%  perf-profile.children.cycles-pp.fsnotify
      0.01 ±223%      +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.08 ± 20%      +0.1        0.14 ± 19%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.00            +0.1        0.07 ± 27%  perf-profile.children.cycles-pp.__module_text_address
      0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.ftrace_ops_trampoline
      0.25 ±  5%      +0.1        0.33 ± 10%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.is_ftrace_trampoline
      0.08 ± 21%      +0.1        0.16 ± 11%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.06 ± 14%      +0.1        0.15 ± 18%  perf-profile.children.cycles-pp.refill_stock
      0.57 ±  4%      +0.1        0.66 ±  5%  perf-profile.children.cycles-pp.common_file_perm
      0.28 ± 11%      +0.1        0.37 ± 15%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.1        0.09 ± 23%  perf-profile.children.cycles-pp.is_module_text_address
      0.02 ±142%      +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.drain_stock
      0.40 ±  5%      +0.1        0.51 ±  6%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.41 ±  3%      +0.1        0.52 ±  4%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.29            +0.1        0.40 ± 11%  perf-profile.children.cycles-pp.fput_many
      0.48 ±  3%      +0.1        0.59 ±  5%  perf-profile.children.cycles-pp.sock_recvmsg
      0.00            +0.1        0.12 ± 16%  perf-profile.children.cycles-pp.get_stack_info_noinstr
      0.31 ± 10%      +0.1        0.43 ± 15%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.25 ±  9%      +0.1        0.37 ± 11%  perf-profile.children.cycles-pp.__build_skb_around
      0.02 ±141%      +0.1        0.16 ± 18%  perf-profile.children.cycles-pp.try_charge
      0.00            +0.2        0.15 ± 16%  perf-profile.children.cycles-pp.local_clock
      0.01 ±223%      +0.2        0.16 ± 15%  perf-profile.children.cycles-pp.__is_insn_slot_addr
      0.32 ±  9%      +0.2        0.48 ± 10%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.2        0.16 ± 14%  perf-profile.children.cycles-pp.get_callchain_entry
      0.50 ±  4%      +0.2        0.67 ±  5%  perf-profile.children.cycles-pp.aa_sk_perm
      0.11 ± 24%      +0.2        0.28 ± 30%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.00            +0.2        0.17 ± 14%  perf-profile.children.cycles-pp.perf_tp_event_match
      0.01 ±223%      +0.2        0.19 ± 11%  perf-profile.children.cycles-pp.bpf_ksym_find
      0.18 ± 10%      +0.2        0.36 ± 15%  perf-profile.children.cycles-pp.skb_release_data
      0.25 ±  5%      +0.2        0.44 ± 14%  perf-profile.children.cycles-pp.skb_unlink
      0.00            +0.2        0.19 ± 15%  perf-profile.children.cycles-pp.get_stack_info
      0.34 ±  7%      +0.2        0.54 ±  5%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.01 ±223%      +0.2        0.21 ± 63%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.01 ±223%      +0.2        0.21 ± 63%  perf-profile.children.cycles-pp.__generic_file_write_iter
      0.01 ±223%      +0.2        0.21 ± 63%  perf-profile.children.cycles-pp.generic_perform_write
      0.91 ±  4%      +0.2        1.11 ±  6%  perf-profile.children.cycles-pp.security_file_permission
      0.00            +0.2        0.21 ± 57%  perf-profile.children.cycles-pp.perf_output_copy
      0.16 ± 16%      +0.2        0.37 ± 24%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.43 ±  7%      +0.2        0.64 ± 11%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.33 ± 13%      +0.2        0.55 ± 10%  perf-profile.children.cycles-pp.finish_task_switch
      0.01 ±223%      +0.2        0.25 ± 17%  perf-profile.children.cycles-pp.perf_instruction_pointer
      0.46 ±  3%      +0.3        0.71 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.01 ±223%      +0.3        0.27 ± 12%  perf-profile.children.cycles-pp.is_bpf_text_address
      0.46 ±  3%      +0.3        0.72 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.04 ±  2%      +0.3        1.31 ±  8%  perf-profile.children.cycles-pp.__fget_light
      0.51 ±  4%      +0.3        0.79 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.78 ±  4%      +0.3        1.06 ± 10%  perf-profile.children.cycles-pp.__fget_files
      1.06 ±  2%      +0.3        1.34 ±  8%  perf-profile.children.cycles-pp.__fdget_pos
      0.57 ±  3%      +0.3        0.86 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.24 ±  2%      +0.3        0.54 ± 18%  perf-profile.children.cycles-pp.unix_write_space
      0.01 ±223%      +0.3        0.31 ± 12%  perf-profile.children.cycles-pp.perf_misc_flags
      0.11 ± 12%      +0.3        0.42 ±  6%  perf-profile.children.cycles-pp.task_tick_fair
      0.23 ±  7%      +0.3        0.55 ±  4%  perf-profile.children.cycles-pp.tick_sched_timer
      0.21 ±  7%      +0.3        0.53 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.21 ±  6%      +0.3        0.54 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.65            +0.3        0.97 ±  9%  perf-profile.children.cycles-pp.simple_copy_to_iter
      0.14 ±  8%      +0.3        0.47 ±  4%  perf-profile.children.cycles-pp.scheduler_tick
      0.27 ±  5%      +0.3        0.60 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +0.3        0.34 ± 58%  perf-profile.children.cycles-pp.perf_output_sample
      0.02 ±223%      +0.4        0.37 ± 11%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.80 ±  2%      +0.4        1.16 ±  9%  perf-profile.children.cycles-pp._copy_to_iter
      0.02 ±223%      +0.4        0.38 ± 15%  perf-profile.children.cycles-pp.perf_output_begin_forward
      0.19 ± 96%      +0.4        0.56 ± 27%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.55 ±  5%      +0.4        0.92 ± 11%  perf-profile.children.cycles-pp.copyout
      0.20 ± 95%      +0.4        0.57 ± 27%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.14 ± 94%      +0.4        0.53 ± 28%  perf-profile.children.cycles-pp.sched_ttwu_pending
      1.05            +0.4        1.44 ±  8%  perf-profile.children.cycles-pp.__check_object_size
      0.22 ± 95%      +0.4        0.62 ± 27%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.01 ±223%      +0.4        0.40 ± 26%  perf-profile.children.cycles-pp.unfreeze_partials
      0.02 ±144%      +0.4        0.43 ± 26%  perf-profile.children.cycles-pp.put_cpu_partial
      0.02 ±223%      +0.4        0.44 ± 15%  perf-profile.children.cycles-pp.ftrace_graph_ret_addr
      0.02 ±223%      +0.4        0.45 ± 12%  perf-profile.children.cycles-pp.perf_event_pid_type
      0.02 ±223%      +0.5        0.51 ± 15%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      1.03            +0.5        1.53 ± 12%  perf-profile.children.cycles-pp.skb_release_all
      0.86 ±  3%      +0.5        1.35 ± 11%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      1.00 ±  2%      +0.5        1.50 ± 13%  perf-profile.children.cycles-pp.unix_destruct_scm
      1.02 ±  2%      +0.5        1.52 ± 12%  perf-profile.children.cycles-pp.skb_release_head_state
      0.76 ±  4%      +0.5        1.30 ± 14%  perf-profile.children.cycles-pp.sock_wfree
      0.22 ± 40%      +0.6        0.78 ± 18%  perf-profile.children.cycles-pp.set_task_cpu
      0.04 ±223%      +0.6        0.66 ± 17%  perf-profile.children.cycles-pp.perf_trace_sched_migrate_task
      1.58            +0.7        2.26 ±  9%  perf-profile.children.cycles-pp.unix_stream_read_actor
      1.55            +0.7        2.23 ±  9%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      1.51            +0.7        2.20 ±  9%  perf-profile.children.cycles-pp.__skb_datagram_iter
      0.03 ±223%      +0.7        0.73 ± 14%  perf-profile.children.cycles-pp.kvm_is_in_guest
      0.06 ± 54%      +0.8        0.83 ± 22%  perf-profile.children.cycles-pp.get_partial_node
      0.04 ±223%      +0.9        0.98 ± 14%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.04 ±223%      +1.0        1.01 ± 15%  perf-profile.children.cycles-pp.perf_callchain_user
      0.24 ± 24%      +1.0        1.22 ± 20%  perf-profile.children.cycles-pp.___slab_alloc
      0.25 ± 24%      +1.0        1.25 ± 20%  perf-profile.children.cycles-pp.__slab_alloc
      0.46 ± 11%      +1.0        1.47 ± 12%  perf-profile.children.cycles-pp.__slab_free
      0.00            +1.2        1.21 ± 53%  perf-profile.children.cycles-pp.intel_idle
      0.06 ±223%      +1.3        1.32 ± 16%  perf-profile.children.cycles-pp.kernel_text_address
      0.00            +1.3        1.28 ± 53%  perf-profile.children.cycles-pp.cpuidle_enter
      0.00            +1.3        1.28 ± 53%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.06 ±223%      +1.4        1.45 ± 18%  perf-profile.children.cycles-pp.stack_access_ok
      0.01 ±223%      +1.6        1.60 ± 54%  perf-profile.children.cycles-pp.start_secondary
      0.01 ±223%      +1.6        1.61 ± 54%  perf-profile.children.cycles-pp.do_idle
      0.01 ±223%      +1.6        1.61 ± 54%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.01 ±223%      +1.6        1.61 ± 54%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.08 ±223%      +1.6        1.70 ± 16%  perf-profile.children.cycles-pp.__kernel_text_address
      0.10 ±223%      +2.1        2.17 ± 17%  perf-profile.children.cycles-pp.unwind_get_return_address
      0.34 ±  9%      +2.2        2.49 ± 20%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.10 ±223%      +2.2        2.30 ± 15%  perf-profile.children.cycles-pp.orc_find
      3.20 ±  4%      +3.0        6.16 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock
      0.76 ±  7%      +3.3        4.03 ± 19%  perf-profile.children.cycles-pp.page_counter_cancel
      4.58 ± 12%      +3.4        7.95 ± 17%  perf-profile.children.cycles-pp.ttwu_do_activate
      1.91 ±  6%      +3.4        5.33 ± 21%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      4.48 ± 12%      +3.4        7.90 ± 17%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.86 ±  8%      +3.6        5.49 ± 19%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.16 ±223%      +3.7        3.82 ± 16%  perf-profile.children.cycles-pp.__orc_find
      3.66 ± 16%      +3.9        7.55 ± 16%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.94 ±  7%      +4.2        5.19 ± 19%  perf-profile.children.cycles-pp.page_counter_uncharge
      2.51 ± 21%      +4.4        6.86 ± 17%  perf-profile.children.cycles-pp.enqueue_entity
      1.78 ± 31%      +4.7        6.51 ± 15%  perf-profile.children.cycles-pp.dequeue_entity
      0.84 ± 58%      +4.9        5.72 ± 14%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      1.36 ±  9%      +5.0        6.37 ± 19%  perf-profile.children.cycles-pp.obj_cgroup_charge_pages
      1.06 ±  9%      +5.0        6.08 ± 20%  perf-profile.children.cycles-pp.page_counter_try_charge
      1.48 ±  8%      +5.0        6.53 ± 19%  perf-profile.children.cycles-pp.obj_cgroup_charge
      1.13 ± 16%      +6.5        7.64 ±  8%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.42 ±173%      +6.6        7.06 ± 16%  perf-profile.children.cycles-pp.perf_trace_sched_switch
     13.18 ± 10%      +6.8       19.97 ± 16%  perf-profile.children.cycles-pp.__wake_up_common
     13.00 ± 10%      +6.8       19.84 ± 16%  perf-profile.children.cycles-pp.autoremove_wake_function
     12.83 ± 10%      +6.9       19.75 ± 16%  perf-profile.children.cycles-pp.try_to_wake_up
      0.33 ±223%      +7.2        7.56 ± 17%  perf-profile.children.cycles-pp.__unwind_start
      8.25 ± 14%      +7.5       15.73 ± 16%  perf-profile.children.cycles-pp.schedule_timeout
     10.33 ± 15%      +8.4       18.70 ± 17%  perf-profile.children.cycles-pp.schedule
     14.13 ± 10%      +8.5       22.68 ± 14%  perf-profile.children.cycles-pp.sock_def_readable
     10.39 ± 15%      +8.6       18.98 ± 16%  perf-profile.children.cycles-pp.__schedule
     13.80 ± 10%      +8.6       22.42 ± 14%  perf-profile.children.cycles-pp.__wake_up_common_lock
      2.88 ± 38%     +10.0       12.88 ± 16%  perf-profile.children.cycles-pp.update_curr
      0.65 ±165%     +11.1       11.71 ± 16%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.62 ±223%     +13.8       14.40 ± 16%  perf-profile.children.cycles-pp.unwind_next_frame
      0.82 ±223%     +18.1       18.92 ± 16%  perf-profile.children.cycles-pp.perf_callchain_kernel
      0.89 ±223%     +19.5       20.42 ± 16%  perf-profile.children.cycles-pp.get_perf_callchain
      0.90 ±223%     +19.6       20.54 ± 16%  perf-profile.children.cycles-pp.perf_callchain
      0.97 ±223%     +21.4       22.35 ± 16%  perf-profile.children.cycles-pp.perf_prepare_sample
      1.00 ±223%     +22.4       23.36 ± 15%  perf-profile.children.cycles-pp.perf_event_output_forward
      1.01 ±223%     +22.5       23.48 ± 15%  perf-profile.children.cycles-pp.__perf_event_overflow
      1.01 ±223%     +22.5       23.54 ± 15%  perf-profile.children.cycles-pp.perf_swevent_overflow
      1.31 ±176%     +23.0       24.27 ± 15%  perf-profile.children.cycles-pp.perf_tp_event
     10.27 ±  5%      -9.8        0.44 ±  8%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      6.50 ±  5%      -5.9        0.64 ±  6%  perf-profile.self.cycles-pp.kfree
      5.18 ±  8%      -4.4        0.76 ±  5%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      4.63 ±  7%      -4.1        0.53 ±  6%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      4.44 ±  7%      -3.5        0.92 ± 10%  perf-profile.self.cycles-pp.kmem_cache_free
      3.14 ± 10%      -2.5        0.64 ±  8%  perf-profile.self.cycles-pp.mod_objcg_state
      7.51 ±  4%      -1.8        5.75 ± 11%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.12 ± 10%      -0.8        0.29 ± 22%  perf-profile.self.cycles-pp.get_mem_cgroup_from_objcg
      1.26 ±  9%      -0.7        0.58 ± 14%  perf-profile.self.cycles-pp.switch_fpu_return
      1.19 ±  2%      -0.6        0.54 ± 25%  perf-profile.self.cycles-pp.update_curr
      1.40 ±  4%      -0.6        0.77 ± 15%  perf-profile.self.cycles-pp.__schedule
      1.50 ±  8%      -0.5        0.96 ± 21%  perf-profile.self.cycles-pp.available_idle_cpu
      1.07 ±  5%      -0.4        0.63 ± 19%  perf-profile.self.cycles-pp.update_load_avg
      0.78 ±  9%      -0.4        0.38 ± 17%  perf-profile.self.cycles-pp.__switch_to_asm
      0.71 ±  4%      -0.3        0.36 ± 18%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.55 ±  3%      -0.3        0.21 ± 20%  perf-profile.self.cycles-pp.__enqueue_entity
      0.82 ±  7%      -0.3        0.49 ± 27%  perf-profile.self.cycles-pp.select_idle_cpu
      0.62 ±  4%      -0.3        0.32 ± 16%  perf-profile.self.cycles-pp.update_rq_clock
      0.62 ±  5%      -0.3        0.33 ± 16%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.52 ±  9%      -0.3        0.24 ± 13%  perf-profile.self.cycles-pp.__switch_to
      0.47 ±  7%      -0.3        0.20 ± 13%  perf-profile.self.cycles-pp.reweight_entity
      0.53 ±  5%      -0.3        0.27 ± 18%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.56 ±  3%      -0.2        0.31 ± 12%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.42 ±  3%      -0.2        0.18 ± 22%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.40 ± 11%      -0.2        0.18 ± 19%  perf-profile.self.cycles-pp.copy_fpregs_to_fpstate
      0.45 ±  5%      -0.2        0.26 ± 16%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.30 ±  9%      -0.2        0.11 ± 19%  perf-profile.self.cycles-pp.___perf_sw_event
      0.42 ±  5%      -0.2        0.22 ± 18%  perf-profile.self.cycles-pp.enqueue_entity
      0.42 ±  2%      -0.2        0.23 ± 15%  perf-profile.self.cycles-pp.prepare_to_wait
      0.39 ±  6%      -0.2        0.21 ± 15%  perf-profile.self.cycles-pp.select_idle_sibling
      0.46 ±  3%      -0.2        0.30 ± 15%  perf-profile.self.cycles-pp.try_to_wake_up
      0.28 ±  8%      -0.2        0.12 ± 22%  perf-profile.self.cycles-pp.pick_next_entity
      0.23 ± 12%      -0.1        0.09 ± 23%  perf-profile.self.cycles-pp.clear_buddies
      0.40 ±  8%      -0.1        0.26 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.26 ±  9%      -0.1        0.12 ± 20%  perf-profile.self.cycles-pp.__calc_delta
      0.30 ±  2%      -0.1        0.16 ± 18%  perf-profile.self.cycles-pp.update_min_vruntime
      0.27 ±  8%      -0.1        0.13 ± 10%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.39 ±  3%      -0.1        0.26 ± 45%  perf-profile.self.cycles-pp.__pthread_disable_asynccancel
      0.24 ±  5%      -0.1        0.11 ± 18%  perf-profile.self.cycles-pp.dequeue_entity
      0.22 ±  6%      -0.1        0.10 ± 13%  perf-profile.self.cycles-pp.schedule_timeout
      0.26 ±  6%      -0.1        0.15 ± 11%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.19 ±  4%      -0.1        0.08 ± 16%  perf-profile.self.cycles-pp.rb_erase
      0.21 ±  7%      -0.1        0.10 ± 22%  perf-profile.self.cycles-pp.check_preempt_wakeup
      0.15 ±  6%      -0.1        0.05 ± 50%  perf-profile.self.cycles-pp.check_preempt_curr
      0.17 ±  4%      -0.1        0.08 ± 22%  perf-profile.self.cycles-pp.set_next_entity
      0.17 ±  8%      -0.1        0.08 ± 18%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.42 ±  4%      -0.1        0.33 ±  5%  perf-profile.self.cycles-pp.vfs_read
      0.18 ± 11%      -0.1        0.10 ± 11%  perf-profile.self.cycles-pp.cpus_share_cache
      0.17 ±  8%      -0.1        0.08 ± 20%  perf-profile.self.cycles-pp.schedule
      0.38 ±  5%      -0.1        0.29 ± 12%  perf-profile.self.cycles-pp.cpuacct_charge
      0.14 ±  8%      -0.1        0.06 ± 33%  perf-profile.self.cycles-pp.set_next_buddy
      0.14 ±  9%      -0.1        0.06 ± 21%  perf-profile.self.cycles-pp.resched_curr
      0.19 ±  6%      -0.1        0.12 ± 16%  perf-profile.self.cycles-pp.finish_task_switch
      0.14 ±  5%      -0.1        0.07 ± 23%  perf-profile.self.cycles-pp.rb_insert_color
      0.22 ±  6%      -0.1        0.15 ± 22%  perf-profile.self.cycles-pp._find_next_bit
      0.20 ±  6%      -0.1        0.13 ± 30%  perf-profile.self.cycles-pp.cpumask_next_wrap
      0.31 ±  6%      -0.1        0.25 ±  4%  perf-profile.self.cycles-pp.new_sync_read
      0.22 ±  5%      -0.1        0.16 ±  8%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.18 ± 10%      -0.1        0.12 ±  7%  perf-profile.self.cycles-pp.__wake_up_common
      0.21 ±  6%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.unix_destruct_scm
      0.10 ±  4%      -0.0        0.06 ± 16%  perf-profile.self.cycles-pp.__list_add_valid
      0.18 ±  4%      -0.0        0.15 ±  6%  perf-profile.self.cycles-pp.do_syscall_64
      0.18 ±  7%      -0.0        0.15 ±  5%  perf-profile.self.cycles-pp._copy_to_iter
      0.10 ± 11%      -0.0        0.07 ±  9%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.13 ±  3%      +0.0        0.15 ±  5%  perf-profile.self.cycles-pp._copy_from_iter
      0.05            +0.0        0.07 ± 10%  perf-profile.self.cycles-pp.kmalloc_slab
      0.08 ±  5%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.__cond_resched
      0.09 ± 10%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.rcu_read_unlock_strict
      0.08 ±  4%      +0.0        0.11 ± 10%  perf-profile.self.cycles-pp.apparmor_socket_getpeersec_dgram
      0.11 ±  3%      +0.0        0.15 ± 10%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.self.cycles-pp.security_socket_recvmsg
      0.09 ±  7%      +0.0        0.13 ± 12%  perf-profile.self.cycles-pp.security_file_permission
      0.04 ± 47%      +0.0        0.09 ±  9%  perf-profile.self.cycles-pp.perf_trace_buf_alloc
      0.09            +0.0        0.14 ± 11%  perf-profile.self.cycles-pp.aa_file_perm
      0.00            +0.1        0.06 ± 20%  perf-profile.self.cycles-pp.get_stack_info_noinstr
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.perf_trace_run_bpf_submit
      0.01 ±223%      +0.1        0.06 ± 19%  perf-profile.self.cycles-pp.perf_trace_buf_update
      0.00            +0.1        0.06 ± 19%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.00            +0.1        0.06 ± 18%  perf-profile.self.cycles-pp.rcu_is_watching
      0.00            +0.1        0.06 ± 18%  perf-profile.self.cycles-pp.perf_swevent_get_recursion_context
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.perf_swevent_overflow
      0.00            +0.1        0.06 ± 23%  perf-profile.self.cycles-pp.is_bpf_text_address
      0.34 ±  5%      +0.1        0.40 ±  4%  perf-profile.self.cycles-pp.fsnotify
      0.27 ±  7%      +0.1        0.34 ±  7%  perf-profile.self.cycles-pp.aa_sk_perm
      0.00            +0.1        0.06 ± 21%  perf-profile.self.cycles-pp.perf_instruction_pointer
      0.01 ±223%      +0.1        0.07 ± 18%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.ftrace_ops_trampoline
      0.24 ±  5%      +0.1        0.31 ± 10%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.00            +0.1        0.08 ±  9%  perf-profile.self.cycles-pp.perf_misc_flags
      0.00            +0.1        0.08 ± 13%  perf-profile.self.cycles-pp.get_stack_info
      0.00            +0.1        0.08 ± 16%  perf-profile.self.cycles-pp.perf_event_pid_type
      0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.__perf_event_overflow
      0.27 ± 10%      +0.1        0.36 ± 15%  perf-profile.self.cycles-pp.native_sched_clock
      0.30 ±  3%      +0.1        0.39 ±  8%  perf-profile.self.cycles-pp.sock_write_iter
      0.28 ±  2%      +0.1        0.38 ±  7%  perf-profile.self.cycles-pp.vfs_write
      0.28            +0.1        0.39 ± 11%  perf-profile.self.cycles-pp.fput_many
      0.00            +0.1        0.10 ± 16%  perf-profile.self.cycles-pp.__perf_event_header__init_id
      0.00            +0.1        0.11 ± 19%  perf-profile.self.cycles-pp.perf_callchain
      0.15 ± 17%      +0.1        0.26 ± 13%  perf-profile.self.cycles-pp.__build_skb_around
      0.00            +0.1        0.11 ± 23%  perf-profile.self.cycles-pp.unfreeze_partials
      0.32 ±  2%      +0.1        0.43 ±  7%  perf-profile.self.cycles-pp.__alloc_skb
      0.16 ± 15%      +0.1        0.28 ± 23%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.00            +0.1        0.12 ± 27%  perf-profile.self.cycles-pp.obj_cgroup_charge_pages
      0.00            +0.1        0.12 ± 24%  perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      0.00            +0.1        0.13 ± 17%  perf-profile.self.cycles-pp.__is_insn_slot_addr
      0.00            +0.1        0.14 ± 15%  perf-profile.self.cycles-pp.local_clock
      0.10 ± 25%      +0.1        0.24 ± 18%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.00            +0.2        0.16 ± 15%  perf-profile.self.cycles-pp.get_callchain_entry
      0.01 ±223%      +0.2        0.17 ± 20%  perf-profile.self.cycles-pp.get_partial_node
      0.11 ± 24%      +0.2        0.28 ± 31%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.00            +0.2        0.17 ± 14%  perf-profile.self.cycles-pp.perf_tp_event_match
      0.30 ±  7%      +0.2        0.47 ±  5%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.17 ±  9%      +0.2        0.35 ± 14%  perf-profile.self.cycles-pp.skb_release_data
      0.01 ±223%      +0.2        0.19 ± 11%  perf-profile.self.cycles-pp.bpf_ksym_find
      0.22 ± 15%      +0.2        0.40 ± 13%  perf-profile.self.cycles-pp.perf_tp_event
      0.42 ±  7%      +0.2        0.63 ± 11%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.33 ±  3%      +0.2        0.54 ± 12%  perf-profile.self.cycles-pp.sock_def_readable
      0.16 ± 22%      +0.2        0.38 ± 17%  perf-profile.self.cycles-pp.___slab_alloc
      0.01 ±223%      +0.2        0.24 ± 13%  perf-profile.self.cycles-pp.perf_event_output_forward
      0.50 ±  7%      +0.2        0.74 ± 12%  perf-profile.self.cycles-pp.sock_wfree
      0.76 ±  4%      +0.3        1.04 ± 10%  perf-profile.self.cycles-pp.__fget_files
      0.40 ±  4%      +0.3        0.68 ± 10%  perf-profile.self.cycles-pp.__check_object_size
      0.01 ±223%      +0.3        0.29 ± 16%  perf-profile.self.cycles-pp.perf_callchain_user
      0.01 ±223%      +0.3        0.30 ± 17%  perf-profile.self.cycles-pp.perf_prepare_sample
      0.01 ±223%      +0.3        0.33 ± 18%  perf-profile.self.cycles-pp.get_perf_callchain
      0.02 ±223%      +0.3        0.34 ± 17%  perf-profile.self.cycles-pp.__kernel_text_address
      0.02 ±223%      +0.3        0.35 ± 15%  perf-profile.self.cycles-pp.perf_output_begin_forward
      0.02 ±223%      +0.3        0.35 ± 11%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.02 ±223%      +0.3        0.36 ± 16%  perf-profile.self.cycles-pp.ftrace_graph_ret_addr
      0.02 ±223%      +0.5        0.48 ± 17%  perf-profile.self.cycles-pp.unwind_get_return_address
      0.02 ±223%      +0.5        0.49 ± 15%  perf-profile.self.cycles-pp.__get_user_nocheck_8
      0.84 ±  3%      +0.5        1.32 ± 11%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.03 ±223%      +0.6        0.63 ± 17%  perf-profile.self.cycles-pp.kernel_text_address
      0.03 ±223%      +0.6        0.64 ± 13%  perf-profile.self.cycles-pp.kvm_is_in_guest
      0.03 ±223%      +0.7        0.72 ± 17%  perf-profile.self.cycles-pp.__unwind_start
      0.46 ± 11%      +1.0        1.45 ± 11%  perf-profile.self.cycles-pp.__slab_free
      0.00            +1.2        1.21 ± 53%  perf-profile.self.cycles-pp.intel_idle
      0.06 ±223%      +1.2        1.27 ± 17%  perf-profile.self.cycles-pp.stack_access_ok
      0.07 ±223%      +1.5        1.55 ± 16%  perf-profile.self.cycles-pp.perf_callchain_kernel
      0.09 ±223%      +2.1        2.18 ± 15%  perf-profile.self.cycles-pp.orc_find
      0.34 ±  9%      +2.1        2.46 ± 20%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.76 ±  8%      +3.2        3.97 ± 19%  perf-profile.self.cycles-pp.page_counter_cancel
      0.16 ±223%      +3.6        3.81 ± 16%  perf-profile.self.cycles-pp.__orc_find
      0.89 ±  8%      +3.8        4.66 ± 19%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.29 ±223%      +6.4        6.64 ± 17%  perf-profile.self.cycles-pp.unwind_next_frame
      1.12 ± 17%      +6.5        7.63 ±  8%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


                                                                                
                                hackbench.throughput                            
                                                                                
  120000 +------------------------------------------------------------------+   
         |OOOOOOOOOOOOOOOO O OO OOO OOOOOOOOO OOOOO O  O  O  O   O         O|   
  100000 |-+              O    O                                            |   
         |                                                                  |   
         |                                        ++++++                    |   
   80000 |-+                                      :                         |   
         |                                +++++  :                          |   
   60000 |+++ +++++++++++       ++++ ++++ :+   +++                          |   
         |   +      +    +++++++    +    +                                  |   
   40000 |-+                                                                |   
         |                                                                  |   
         |                                                                  |   
   20000 |-+                                                                |   
         |                                                                  |   
       0 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       hackbench.time.voluntary_context_switches                
                                                                                
    4e+09 +-----------------------------------------------------------------+   
          |                                         +                       |   
  3.5e+09 |++   + +    +          +   +     ++++  ++ +++                    |   
    3e+09 |-++++ ++++++ ++++++++++ +++ +++++    ++                          |   
          |                                                                 |   
  2.5e+09 |-+                                                               |   
          |                                                                 |   
    2e+09 |-+                                                               |   
          |                                                                 |   
  1.5e+09 |-+                                                         O     |   
    1e+09 |-+                                            O  O  OO  OO       |   
          |              O   OOO  O  OO OO O  O O   O  OO  O  O  O  OO OOOO |   
    5e+08 |OOOOOOOOOOOOOO OOO   OO OO  O  O OO O OOO      O  O    O        O|   
          |                                                                 |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      hackbench.time.involuntary_context_switches               
                                                                                
  2.5e+09 +-----------------------------------------------------------------+   
          |                                  +     + +++                    |   
          |+    + +    +   +   ++ +   +     + ++  +                         |   
    2e+09 |-++ + ++++ + ++ :+++  + + + ++ ++    ++                          |   
          |   +      +    +         +    +                                  |   
          |                                                                 |   
  1.5e+09 |-+                                                               |   
          |                                                                 |   
    1e+09 |-+                                                               |   
          |                                                                 |   
          |                                                         O O     |   
    5e+08 |-+                                            O  O  OO  O        |   
          |              O O OOO  O  OO OO O  O O   O  OO  O  O  O  OO OOOO |   
          |OOOOOOOOOOOOOO O O   OO OO  O  O OO O OOO      O  O    O        O|   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2sp4: 96 threads 2 sockets Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase/ucode:
  gcc-9/performance/socket/8/x86_64-rhel-8.3/process/1600%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp4/hackbench/0x4003006

commit: 
  68ac5b3c8d ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")
  5387c90490 ("mm/memcg: improve refill_obj_stock() performance")

68ac5b3c8db2fda0 5387c90490f7f42df3209154ca9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     88731 ±  2%     +51.9%     134791        hackbench.throughput
      1198 ±  2%     -29.4%     846.30        hackbench.time.elapsed_time
      1198 ±  2%     -29.4%     846.30        hackbench.time.elapsed_time.max
 3.018e+08 ± 19%     -80.7%   58143527 ±  4%  hackbench.time.involuntary_context_switches
      8720            -3.9%       8384        hackbench.time.percent_of_cpu_this_job_got
    103040 ±  2%     -32.3%      69790        hackbench.time.system_time
      1444 ±  3%     -19.0%       1169        hackbench.time.user_time
  6.95e+08 ±  9%     -47.3%  3.664e+08        hackbench.time.voluntary_context_switches
      1235 ±  2%     -28.5%     883.79        uptime.boot
  3.53e+08 ±  3%      +5.9%  3.739e+08 ±  4%  cpuidle.C1.time
  11398249 ±  7%     +20.0%   13679143 ± 13%  cpuidle.C1.usage
   4054497 ±  7%     +31.0%    5312525 ± 21%  numa-numastat.node1.local_node
   4091772 ±  7%     +30.1%    5321980 ± 21%  numa-numastat.node1.numa_hit
   2127053           +14.6%    2438337 ± 12%  meminfo.Inactive
   2126906           +14.6%    2438190 ± 12%  meminfo.Inactive(anon)
     48105 ± 13%    +517.3%     296955 ± 81%  meminfo.Mapped
      9.59            +5.6       15.23 ± 12%  mpstat.cpu.all.idle%
      0.00 ± 21%      +0.0        0.00 ± 14%  mpstat.cpu.all.iowait%
      1.25            +0.2        1.45        mpstat.cpu.all.usr%
      6676 ±  3%     -27.5%       4838 ±  5%  vmstat.procs.r
    876931 ± 10%     -35.4%     566878        vmstat.system.cs
    198694 ± 15%      +8.1%     214875        vmstat.system.in
      7497 ± 35%    +100.0%      14992 ± 22%  numa-vmstat.node0.nr_mapped
     22560 ± 44%    +449.2%     123907 ± 51%  numa-vmstat.node1.nr_inactive_anon
    363.67 ±  9%     +43.3%     521.00 ±  7%  numa-vmstat.node1.nr_page_table_pages
     93398 ±  6%     -30.7%      64683 ±  7%  numa-vmstat.node1.nr_slab_unreclaimable
     22560 ± 44%    +449.2%     123907 ± 51%  numa-vmstat.node1.nr_zone_inactive_anon
    527933           +15.7%     610634 ± 12%  proc-vmstat.nr_inactive_anon
     12053 ±  8%    +533.6%      76375 ± 81%  proc-vmstat.nr_mapped
    712630            -7.3%     660684        proc-vmstat.nr_slab_unreclaimable
    527933           +15.7%     610634 ± 12%  proc-vmstat.nr_zone_inactive_anon
    185313 ± 21%     +79.2%     332164 ± 41%  proc-vmstat.numa_pte_updates
    961071            -3.3%     929685        proc-vmstat.pgreuse
  11391736 ±  7%     +20.1%   13679615 ± 13%  turbostat.C1
      0.31 ±  4%      +0.2        0.46 ±  4%  turbostat.C1%
      8.10 ±  3%     +39.8%      11.33 ±  2%  turbostat.CPU%c1
     75.83 ±  2%      +4.2%      79.00        turbostat.PkgTmp
    274.06            +4.4%     286.20        turbostat.PkgWatt
     71.28           +14.8%      81.85        turbostat.RAMWatt
     29763 ± 35%     +94.1%      57779 ± 22%  numa-meminfo.node0.Mapped
    213202 ± 25%     +86.4%     397378 ± 18%  numa-meminfo.node1.AnonPages.max
     90610 ± 42%    +434.9%     484697 ± 50%  numa-meminfo.node1.Inactive
     90610 ± 42%    +434.9%     484697 ± 50%  numa-meminfo.node1.Inactive(anon)
      1462 ± 10%     +41.8%       2073 ±  8%  numa-meminfo.node1.PageTables
    424993 ±  5%     -32.9%     285287 ±  6%  numa-meminfo.node1.SUnreclaim
    503312 ±  7%     -28.1%     361751 ±  5%  numa-meminfo.node1.Slab
      2069 ±  7%     +19.2%       2467 ± 10%  slabinfo.dmaengine-unmap-16.active_objs
      2069 ±  7%     +19.2%       2467 ± 10%  slabinfo.dmaengine-unmap-16.num_objs
     67777 ±  3%     -19.8%      54363 ±  2%  slabinfo.kmalloc-256.active_objs
      4029 ±  3%     -20.4%       3206 ±  8%  slabinfo.kmalloc-256.active_slabs
    128973 ±  3%     -20.4%     102611 ±  8%  slabinfo.kmalloc-256.num_objs
      4029 ±  3%     -20.4%       3206 ±  8%  slabinfo.kmalloc-256.num_slabs
    305469 ±  3%     -18.8%     248152 ±  2%  slabinfo.kmalloc-512.active_objs
     23018 ±  4%     -27.0%      16815 ±  4%  slabinfo.kmalloc-512.active_slabs
    736603 ±  4%     -26.9%     538104 ±  4%  slabinfo.kmalloc-512.num_objs
     23018 ±  4%     -27.0%      16815 ±  4%  slabinfo.kmalloc-512.num_slabs
     57170 ±  6%      +9.9%      62827 ±  6%  slabinfo.proc_inode_cache.active_objs
    213837 ±  4%     -30.0%     149771 ±  4%  slabinfo.skbuff_head_cache.active_objs
     20252 ±  4%     -31.3%      13913 ±  5%  slabinfo.skbuff_head_cache.active_slabs
    648092 ±  4%     -31.3%     445250 ±  5%  slabinfo.skbuff_head_cache.num_objs
     20252 ±  4%     -31.3%      13913 ±  5%  slabinfo.skbuff_head_cache.num_slabs
      9.09 ±  2%      +5.1%       9.55 ±  4%  perf-stat.i.MPKI
 7.058e+09 ±  2%     +14.1%  8.056e+09 ±  2%  perf-stat.i.branch-instructions
  42700294 ±  2%      +9.6%   46778564 ±  5%  perf-stat.i.branch-misses
  1.42e+08 ±  3%     +27.3%  1.806e+08        perf-stat.i.cache-misses
 3.069e+08 ±  3%     +21.1%  3.716e+08 ±  4%  perf-stat.i.cache-references
    790961 ±  7%     -15.5%     668663 ±  3%  perf-stat.i.context-switches
      6.83            -6.3%       6.40        perf-stat.i.cpi
 2.103e+11            -7.0%  1.957e+11        perf-stat.i.cpu-cycles
     43342 ±  3%     +16.5%      50479 ±  5%  perf-stat.i.cpu-migrations
 9.593e+09 ±  2%     +15.9%  1.112e+10 ±  3%  perf-stat.i.dTLB-loads
 5.023e+09 ±  2%     +17.0%  5.875e+09 ±  3%  perf-stat.i.dTLB-stores
     60.11            -2.0       58.09        perf-stat.i.iTLB-load-miss-rate%
  22838344 ±  3%     +12.7%   25735632 ±  5%  perf-stat.i.iTLB-load-misses
   6214874 ±  5%     -14.4%    5317074 ±  3%  perf-stat.i.iTLB-loads
 3.441e+10 ±  2%     +15.0%  3.957e+10 ±  3%  perf-stat.i.instructions
      3456 ±  3%      +9.2%       3776        perf-stat.i.instructions-per-iTLB-miss
      0.19           +14.6%       0.22        perf-stat.i.ipc
    826.53 ± 11%     +25.0%       1033 ± 11%  perf-stat.i.major-faults
      2.15            -7.4%       1.99        perf-stat.i.metric.GHz
    932.12 ±  2%     +16.5%       1086        perf-stat.i.metric.K/sec
    226.32 ±  2%     +14.6%     259.45 ±  3%  perf-stat.i.metric.M/sec
     45074 ±  2%     +16.6%      52551 ±  2%  perf-stat.i.minor-faults
  17095614 ±  2%     +16.8%   19974228 ±  2%  perf-stat.i.node-load-misses
  25241388 ±  4%     +25.9%   31770755 ±  2%  perf-stat.i.node-loads
   8040076 ±  3%      +5.4%    8478188        perf-stat.i.node-store-misses
  25780743 ±  3%     +23.9%   31948210        perf-stat.i.node-stores
     45900 ±  2%     +16.7%      53584        perf-stat.i.page-faults
      8.96 ±  2%      +4.2%       9.34        perf-stat.overall.MPKI
      0.63            -0.0        0.59        perf-stat.overall.branch-miss-rate%
     51.11 ±  2%      +4.3       55.39        perf-stat.overall.cache-miss-rate%
      5.55           -26.5%       4.08        perf-stat.overall.cpi
      1212 ±  3%     -34.9%     789.00        perf-stat.overall.cycles-between-cache-misses
     84.57            +6.9       91.44        perf-stat.overall.iTLB-load-miss-rate%
      1308            +1.8%       1332        perf-stat.overall.instructions-per-iTLB-miss
      0.18           +36.0%       0.25        perf-stat.overall.ipc
     32.99            -1.6       31.38        perf-stat.overall.node-load-miss-rate%
     18.38            -3.7       14.73 ±  2%  perf-stat.overall.node-store-miss-rate%
 9.668e+09           +29.8%  1.255e+10        perf-stat.ps.branch-instructions
  61121486 ±  2%     +20.2%   73498533        perf-stat.ps.branch-misses
 2.236e+08 ±  3%     +47.8%  3.304e+08        perf-stat.ps.cache-misses
 4.376e+08 ±  3%     +36.3%  5.967e+08        perf-stat.ps.cache-references
    868230 ± 10%     -35.4%     560685        perf-stat.ps.context-switches
 2.708e+11            -3.7%  2.607e+11        perf-stat.ps.cpu-cycles
     22081 ±  3%     +19.4%      26354 ±  6%  perf-stat.ps.cpu-migrations
 1.389e+10           +31.7%  1.829e+10        perf-stat.ps.dTLB-loads
 8.253e+09           +32.3%  1.092e+10        perf-stat.ps.dTLB-stores
  37312739           +28.5%   47963236        perf-stat.ps.iTLB-load-misses
   6820471 ± 10%     -34.2%    4490884        perf-stat.ps.iTLB-loads
 4.881e+10           +30.9%  6.388e+10        perf-stat.ps.instructions
    238.96 ±  9%     +51.7%     362.46 ±  9%  perf-stat.ps.major-faults
     16479 ±  2%     +40.7%      23188        perf-stat.ps.minor-faults
  19674114 ±  2%     +33.9%   26336370        perf-stat.ps.node-load-misses
  39977675 ±  3%     +44.1%   57598395        perf-stat.ps.node-loads
  10261782 ±  3%     +10.2%   11306322 ±  2%  perf-stat.ps.node-store-misses
  45563654 ±  2%     +43.6%   65439023        perf-stat.ps.node-stores
     16718 ±  2%     +40.9%      23550        perf-stat.ps.page-faults
 5.849e+13            -7.5%   5.41e+13        perf-stat.total.instructions
     74.65 ±174%     -95.2%       3.62 ± 10%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      6.38 ± 37%     -90.1%       0.63 ± 10%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.82 ±205%    +700.9%      22.58 ± 99%  perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
     61.66 ± 55%     -94.4%       3.45 ±  9%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
     55.16 ±190%     -94.3%       3.14 ±  6%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
     61.35 ±130%     -97.5%       1.51 ± 18%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00 ±223%  +1.7e+05%       4.82 ± 48%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.switch_task_namespaces.do_exit.do_group_exit
      0.05 ±182%   +5386.3%       2.80 ± 94%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.03 ±223%    +655.6%       0.24 ± 82%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap
    642.60 ±104%    -100.0%       0.01        perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
     81.46 ± 26%     -78.6%      17.43 ±  2%  perf-sched.sch_delay.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     30.24 ± 14%     -90.8%       2.78 ± 34%  perf-sched.sch_delay.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00 ±223%    +800.0%       0.00 ± 33%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
      3.97 ±159%   +5369.6%     216.94 ± 96%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     51249 ± 10%     -87.2%       6550 ± 19%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     48.63 ±215%   +6430.7%       3175 ± 99%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
     47502 ±  9%     -95.6%       2108 ± 97%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
     16.80 ± 58%    +112.8%      35.76 ± 38%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.remove_vma.exit_mmap.mmput
    336.46 ±141%    +532.8%       2129 ± 85%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.00 ±223%  +2.6e+05%       7.32 ±  2%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.switch_task_namespaces.do_exit.do_group_exit
      0.44 ±207%   +2924.7%      13.35 ± 74%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.03 ±223%  +12398.4%       3.94 ± 95%  perf-sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap
     10700 ±146%    -100.0%       0.01 ± 10%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
     50088 ± 11%     -87.1%       6447 ± 18%  perf-sched.sch_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     51831 ± 10%     -86.9%       6804 ± 23%  perf-sched.sch_delay.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.03 ± 74%  +1.2e+06%     351.38 ± 99%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00 ±223%   +2750.0%       0.01 ± 78%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open.isra
     28.77 ±  9%     -88.0%       3.44 ± 33%  perf-sched.total_sch_delay.average.ms
     51831 ± 10%     -84.6%       7979 ±  5%  perf-sched.total_sch_delay.max.ms
    500.44 ± 30%     -91.7%      41.45 ± 10%  perf-sched.total_wait_and_delay.average.ms
    103802 ± 10%     -86.6%      13886 ± 24%  perf-sched.total_wait_and_delay.max.ms
    471.67 ± 31%     -91.9%      38.01 ±  8%  perf-sched.total_wait_time.average.ms
     52524 ±  9%     -82.2%       9330 ±  6%  perf-sched.total_wait_time.max.ms
      7243 ± 40%     -97.3%     193.02 ± 10%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      2463 ± 45%     -95.0%     122.45 ±100%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    151.19 ± 35%     -91.5%      12.91 ±  7%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2134 ± 40%     -96.1%      82.24 ± 36%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      2717 ± 24%     -95.6%     120.86 ± 27%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      1830 ± 34%     -91.8%     150.13 ± 59%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      2670 ± 45%     -95.3%     126.44 ± 32%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      1984 ± 34%     -90.7%     184.87 ± 44%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
    427.53 ± 25%     -91.7%      35.57 ± 21%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      6459 ± 47%     -88.3%     756.04 ± 75%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      2610 ± 30%     -94.7%     137.44 ± 67%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
    958.17 ± 53%    +977.9%      10328 ± 77%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      3.50 ±147%   +5057.1%     180.50 ± 90%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
     41.50 ±148%   +1483.1%     657.00 ± 82%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
    192.83 ± 32%    +612.3%       1373 ± 82%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
     83.00 ± 20%    +336.7%     362.50 ± 74%  perf-sched.wait_and_delay.count.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      0.83 ±223%    +980.0%       9.00 ± 33%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1076 ± 47%    +884.3%      10591 ± 77%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
     76448 ± 32%     -87.9%       9266 ±  2%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     52597 ± 37%     -93.8%       3243 ±100%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    101251 ± 11%     -86.7%      13467 ± 21%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     94618 ± 10%     -91.5%       8053 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
     51519 ± 10%     -86.1%       7183 ± 13%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
     53886 ± 30%     -86.8%       7106 ± 21%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
     49146 ± 11%     -87.2%       6274 ± 22%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
     99599 ± 10%     -87.2%      12761 ± 20%  perf-sched.wait_and_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
    103736 ± 10%     -86.7%      13844 ± 24%  perf-sched.wait_and_delay.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     51474 ± 11%     -81.9%       9330 ±  6%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
     69804 ± 26%     -87.4%       8767 ±  5%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
      7024 ± 40%     -97.3%     188.98 ± 11%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      2388 ± 42%     -94.1%     140.98 ± 70%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    144.81 ± 35%     -91.5%      12.28 ±  7%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.89 ±152%   +2800.1%     112.68 ± 99%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.shmem_alloc_page
      2072 ± 41%     -96.2%      78.80 ± 37%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      2661 ± 27%     -95.6%     117.73 ± 27%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      0.05 ± 94%    +586.5%       0.37 ± 89%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.04 ±150%  +2.9e+05%     122.78 ± 93%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.dput.path_put.free_fs_struct
      0.00 ±223%  +1.7e+05%       4.66 ± 59%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.exit_signals.do_exit.do_group_exit
      1768 ± 34%     -91.6%     148.62 ± 60%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00 ±223%  +8.1e+06%     162.30 ± 99%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.mmput.do_exit.do_group_exit
      0.21 ±186%   +5716.7%      12.26 ± 77%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap
    431.11 ± 37%     -96.3%      15.87 ± 56%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
      2662 ± 45%     -95.3%     124.57 ± 32%  perf-sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
    917.87 ± 80%     -99.7%       2.66 ± 12%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    612.52 ± 78%     -94.2%      35.51 ± 73%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      1902 ± 35%     -91.2%     167.44 ± 48%  perf-sched.wait_time.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
    397.28 ± 27%     -91.7%      32.78 ± 20%  perf-sched.wait_time.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      6459 ± 47%     -88.3%     755.56 ± 75%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      2571 ± 31%     -94.7%     137.15 ± 67%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
     51872 ± 10%     -85.0%       7779 ± 16%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     44962 ± 16%     -92.0%       3613 ± 79%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     52368 ±  9%     -84.8%       7967 ± 15%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.17 ±141%   +4384.5%     232.00 ± 93%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__alloc_pages.alloc_pages_vma.shmem_alloc_page
     52181 ±  9%     -86.2%       7196 ± 14%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
     51516 ± 10%     -86.1%       7179 ± 13%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      0.24 ±121%   +7956.8%      18.95 ± 99%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.__fput.task_work_run
      0.10 ±173%  +2.3e+06%       2173 ± 98%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.dput.path_put.free_fs_struct
      0.00 ±223%  +5.2e+05%      13.99 ±  5%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.exit_signals.do_exit.do_group_exit
     49218 ± 14%     -85.6%       7106 ± 21%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00 ±223%  +2.7e+07%     530.74 ± 99%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.mmput.do_exit.do_group_exit
      0.23 ±171%  +1.9e+05%     438.66 ± 96%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap
     29872 ± 46%     -91.4%       2563 ± 93%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_completion.affine_move_task.__set_cpus_allowed_ptr
     49135 ± 11%     -87.2%       6274 ± 22%  perf-sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
     14166 ±110%    -100.0%       3.50 ± 14%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork
     52040 ± 10%     -84.8%       7888 ± 16%  perf-sched.wait_time.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     52228 ±  9%     -84.9%       7898 ± 16%  perf-sched.wait_time.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     51474 ± 11%     -81.9%       9330 ±  6%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
     51558 ± 10%     -86.2%       7136 ± 30%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
     90666 ± 10%     -42.1%      52520        softirqs.CPU0.RCU
     51463 ±  3%      -7.9%      47422        softirqs.CPU0.SCHED
     90265 ±  7%     -40.6%      53641        softirqs.CPU1.RCU
     89635 ± 14%     -41.2%      52698        softirqs.CPU10.RCU
     48032 ±  4%      -8.3%      44041        softirqs.CPU10.SCHED
     91634 ± 11%     -42.0%      53161        softirqs.CPU11.RCU
     47798 ±  4%      -7.7%      44097        softirqs.CPU11.SCHED
     90853 ± 11%     -42.3%      52394        softirqs.CPU12.RCU
     90341 ± 11%     -42.4%      52071        softirqs.CPU13.RCU
     90927 ± 11%     -46.8%      48391 ±  9%  softirqs.CPU14.RCU
     90667 ± 11%     -42.9%      51795        softirqs.CPU15.RCU
     99573 ± 12%     -42.6%      57185 ±  3%  softirqs.CPU16.RCU
     97966 ± 13%     -41.4%      57371 ±  3%  softirqs.CPU17.RCU
    101014 ± 12%     -42.0%      58586 ±  4%  softirqs.CPU18.RCU
    100440 ± 11%     -42.3%      57965 ±  3%  softirqs.CPU19.RCU
     90949 ± 11%     -41.8%      52957        softirqs.CPU2.RCU
    100584 ± 11%     -42.0%      58364 ±  3%  softirqs.CPU20.RCU
    100354 ± 11%     -40.1%      60121        softirqs.CPU21.RCU
     99481 ± 11%     -42.4%      57252 ±  3%  softirqs.CPU22.RCU
     99254 ± 11%     -41.9%      57620 ±  3%  softirqs.CPU23.RCU
     97263 ± 11%     -40.7%      57647 ±  2%  softirqs.CPU24.RCU
     96476 ± 12%     -41.0%      56898 ±  2%  softirqs.CPU25.RCU
     96395 ± 11%     -41.1%      56742        softirqs.CPU26.RCU
     94372 ± 13%     -39.9%      56724 ±  2%  softirqs.CPU27.RCU
     95926 ± 12%     -39.6%      57921        softirqs.CPU28.RCU
     95279 ± 12%     -39.8%      57381        softirqs.CPU29.RCU
     90706 ± 11%     -41.9%      52660        softirqs.CPU3.RCU
     48176 ±  4%      -7.3%      44642        softirqs.CPU3.SCHED
     94335 ± 10%     -39.6%      57009 ±  2%  softirqs.CPU30.RCU
     96239 ± 12%     -40.8%      56966 ±  2%  softirqs.CPU31.RCU
     90870 ± 12%     -41.4%      53255 ±  5%  softirqs.CPU32.RCU
     90844 ± 12%     -41.5%      53125 ±  5%  softirqs.CPU33.RCU
     90742 ± 12%     -41.6%      52956 ±  6%  softirqs.CPU34.RCU
     44647 ±  3%      -8.2%      40988        softirqs.CPU34.SCHED
     90796 ± 12%     -37.3%      56933 ± 11%  softirqs.CPU35.RCU
     44182 ±  3%      -8.9%      40263        softirqs.CPU35.SCHED
     91525 ± 12%     -45.6%      49821 ± 13%  softirqs.CPU36.RCU
     91537 ± 12%     -41.4%      53607 ±  5%  softirqs.CPU37.RCU
     90960 ± 11%     -41.2%      53490 ±  5%  softirqs.CPU38.RCU
     90620 ± 12%     -41.5%      53040 ±  5%  softirqs.CPU39.RCU
     91567 ± 10%     -42.2%      52904        softirqs.CPU4.RCU
     90523 ± 11%     -40.3%      54022 ±  5%  softirqs.CPU40.RCU
     90743 ± 12%     -40.8%      53759 ±  5%  softirqs.CPU41.RCU
     91862 ± 12%     -40.0%      55081 ±  5%  softirqs.CPU42.RCU
     91010 ± 12%     -41.5%      53199 ±  5%  softirqs.CPU43.RCU
     91228 ± 11%     -41.0%      53796 ±  5%  softirqs.CPU44.RCU
     90426 ± 12%     -41.3%      53111 ±  6%  softirqs.CPU45.RCU
     90685 ± 11%     -41.6%      52997 ±  5%  softirqs.CPU46.RCU
     90912 ± 12%     -41.6%      53098 ±  6%  softirqs.CPU47.RCU
     91490 ± 12%     -41.9%      53170        softirqs.CPU48.RCU
     89350 ±  8%     -40.1%      53536        softirqs.CPU49.RCU
     92261 ± 11%     -42.9%      52639        softirqs.CPU5.RCU
     48355 ±  4%      -8.7%      44172        softirqs.CPU5.SCHED
     90939 ± 11%     -42.8%      51994        softirqs.CPU50.RCU
     48293 ±  4%      -8.5%      44180        softirqs.CPU50.SCHED
     91370 ± 11%     -41.9%      53087        softirqs.CPU51.RCU
     92263 ± 12%     -42.2%      53351 ±  2%  softirqs.CPU52.RCU
     48457 ±  4%      -9.3%      43929        softirqs.CPU52.SCHED
     91577 ± 11%     -42.3%      52806 ±  2%  softirqs.CPU53.RCU
     92103 ± 11%     -42.4%      53037 ±  2%  softirqs.CPU54.RCU
     91884 ± 11%     -42.2%      53116 ±  2%  softirqs.CPU55.RCU
     90404 ± 11%     -42.8%      51732 ±  2%  softirqs.CPU56.RCU
     48444 ±  4%      -7.1%      44985        softirqs.CPU56.SCHED
     91686 ± 13%     -41.9%      53236        softirqs.CPU57.RCU
     48647 ±  4%      -7.6%      44927        softirqs.CPU57.SCHED
     90029 ± 14%     -41.0%      53128        softirqs.CPU58.RCU
     92244 ± 11%     -42.4%      53153 ±  2%  softirqs.CPU59.RCU
     90959 ± 12%     -42.6%      52202        softirqs.CPU6.RCU
     92044 ± 11%     -42.6%      52791 ±  2%  softirqs.CPU60.RCU
     91630 ± 11%     -42.0%      53171        softirqs.CPU61.RCU
     48620 ±  4%      -7.2%      45114        softirqs.CPU61.SCHED
     90861 ± 11%     -46.0%      49068 ±  4%  softirqs.CPU62.RCU
     48682 ±  4%      -7.6%      44962        softirqs.CPU62.SCHED
     91707 ± 11%     -42.4%      52788        softirqs.CPU63.RCU
    100669 ± 11%     -41.9%      58458 ±  3%  softirqs.CPU64.RCU
     97372 ± 14%     -40.2%      58204 ±  4%  softirqs.CPU65.RCU
    102174 ± 10%     -39.2%      62079 ±  8%  softirqs.CPU66.RCU
    101076 ± 11%     -41.3%      59348 ±  4%  softirqs.CPU67.RCU
     49027 ±  5%      -8.4%      44896        softirqs.CPU67.SCHED
    101268 ± 10%     -41.7%      59004 ±  3%  softirqs.CPU68.RCU
     48450 ±  4%      -7.5%      44815        softirqs.CPU68.SCHED
    102974 ± 12%     -40.9%      60814        softirqs.CPU69.RCU
     92197 ± 10%     -42.8%      52778        softirqs.CPU7.RCU
     48087 ±  5%      -9.5%      43505        softirqs.CPU7.SCHED
     99972 ± 11%     -42.1%      57915 ±  3%  softirqs.CPU70.RCU
    100098 ± 11%     -41.4%      58704 ±  3%  softirqs.CPU71.RCU
     97160 ± 11%     -40.6%      57754 ±  2%  softirqs.CPU72.RCU
     96268 ± 12%     -40.2%      57598        softirqs.CPU73.RCU
     96164 ± 11%     -40.6%      57137        softirqs.CPU74.RCU
     94295 ± 13%     -39.2%      57325 ±  2%  softirqs.CPU75.RCU
     95673 ± 11%     -40.3%      57103 ±  2%  softirqs.CPU76.RCU
     94985 ± 11%     -38.7%      58209 ±  4%  softirqs.CPU77.RCU
     94691 ±  9%     -39.5%      57304 ±  2%  softirqs.CPU78.RCU
     96298 ± 11%     -40.6%      57235 ±  2%  softirqs.CPU79.RCU
     91480 ± 11%     -42.8%      52334        softirqs.CPU8.RCU
     48241 ±  3%      -8.0%      44373        softirqs.CPU8.SCHED
     90984 ± 11%     -41.0%      53650 ±  5%  softirqs.CPU80.RCU
     91361 ± 11%     -41.2%      53727 ±  5%  softirqs.CPU81.RCU
     91808 ± 12%     -40.8%      54316 ±  5%  softirqs.CPU82.RCU
     92117 ± 12%     -40.9%      54474 ±  5%  softirqs.CPU83.RCU
     90851 ± 12%     -42.7%      52046 ±  7%  softirqs.CPU84.RCU
     90966 ± 12%     -41.1%      53568 ±  4%  softirqs.CPU85.RCU
     91375 ± 11%     -41.2%      53737 ±  5%  softirqs.CPU86.RCU
     91211 ± 12%     -40.7%      54047 ±  3%  softirqs.CPU87.RCU
     92204 ± 12%     -40.7%      54685 ±  5%  softirqs.CPU88.RCU
     44711 ±  3%      -8.8%      40770        softirqs.CPU88.SCHED
     92197 ± 12%     -41.1%      54310 ±  4%  softirqs.CPU89.RCU
     91370 ± 11%     -42.2%      52772        softirqs.CPU9.RCU
     47961 ±  4%      -7.7%      44262        softirqs.CPU9.SCHED
     91228 ± 12%     -40.5%      54251 ±  5%  softirqs.CPU90.RCU
     91678 ± 12%     -41.3%      53774 ±  4%  softirqs.CPU91.RCU
     91366 ± 12%     -40.9%      53966 ±  4%  softirqs.CPU92.RCU
     91670 ± 12%     -41.4%      53740 ±  5%  softirqs.CPU93.RCU
     91846 ± 11%     -41.4%      53849 ±  5%  softirqs.CPU94.RCU
     91251 ± 11%     -41.2%      53680 ±  4%  softirqs.CPU95.RCU
   8973612 ± 11%     -41.4%    5254181 ±  3%  softirqs.RCU
    142298 ±  6%     -31.4%      97607        softirqs.TIMER
      1171 ±  2%     -29.3%     828.00        interrupts.293:PCI-MSI.327680-edge.xhci_hcd
      0.67 ±141%  +90125.0%     601.50 ± 96%  interrupts.36:PCI-MSI.31981569-edge.i40e-eth0-TxRx-0
      0.67 ±223%  +2.6e+05%       1702 ± 89%  interrupts.42:PCI-MSI.31981575-edge.i40e-eth0-TxRx-6
     14.17 ±211%  +11984.7%       1712 ± 80%  interrupts.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
      0.33 ±223%  +1.9e+05%     617.50 ± 99%  interrupts.85:PCI-MSI.31981618-edge.i40e-eth0-TxRx-49
      0.00       +9.1e+104%     908.00 ± 98%  interrupts.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
   9672064 ± 11%     -16.1%    8112763 ±  6%  interrupts.CAL:Function_call_interrupts
      0.33 ±141%  +1.8e+05%     600.50 ± 96%  interrupts.CPU0.36:PCI-MSI.31981569-edge.i40e-eth0-TxRx-0
    108653 ± 35%     -51.2%      53039 ± 13%  interrupts.CPU0.CAL:Function_call_interrupts
    153129 ± 24%     -40.9%      90491        interrupts.CPU0.RES:Rescheduling_interrupts
    137010 ± 24%     -33.8%      90658        interrupts.CPU1.RES:Rescheduling_interrupts
      1171 ±  2%     -29.3%     828.00        interrupts.CPU10.293:PCI-MSI.327680-edge.xhci_hcd
     98261 ± 28%     -59.2%      40075 ± 36%  interrupts.CPU10.CAL:Function_call_interrupts
      8709           -27.4%       6321 ±  8%  interrupts.CPU10.NMI:Non-maskable_interrupts
      8709           -27.4%       6321 ±  8%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
     83384 ± 22%     -48.0%      43324 ± 19%  interrupts.CPU11.CAL:Function_call_interrupts
      8679           -27.1%       6330 ±  8%  interrupts.CPU11.NMI:Non-maskable_interrupts
      8679           -27.1%       6330 ±  8%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    126665 ± 17%     -31.6%      86592        interrupts.CPU11.RES:Rescheduling_interrupts
    137653 ± 22%     -36.9%      86888 ±  5%  interrupts.CPU12.RES:Rescheduling_interrupts
     94196 ± 21%     -46.8%      50088 ± 23%  interrupts.CPU13.CAL:Function_call_interrupts
      8679           -27.4%       6301 ±  9%  interrupts.CPU13.NMI:Non-maskable_interrupts
      8679           -27.4%       6301 ±  9%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    150899 ± 13%     -39.7%      90941        interrupts.CPU13.RES:Rescheduling_interrupts
     88472 ± 17%     -50.4%      43838 ± 15%  interrupts.CPU14.CAL:Function_call_interrupts
    145702 ± 17%     -39.2%      88557 ±  9%  interrupts.CPU15.RES:Rescheduling_interrupts
    107349 ± 18%     -57.2%      45983 ± 17%  interrupts.CPU16.CAL:Function_call_interrupts
    162249 ± 27%     -42.7%      92892 ±  7%  interrupts.CPU16.RES:Rescheduling_interrupts
     94151 ± 21%     -53.2%      44062 ± 38%  interrupts.CPU17.CAL:Function_call_interrupts
    154164 ± 14%     -44.7%      85208        interrupts.CPU17.RES:Rescheduling_interrupts
     93957 ± 18%     -51.4%      45677 ± 24%  interrupts.CPU18.CAL:Function_call_interrupts
    156643 ± 17%     -42.9%      89440 ±  2%  interrupts.CPU18.RES:Rescheduling_interrupts
     14.00 ±214%  +12128.6%       1712 ± 80%  interrupts.CPU19.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
     97845 ± 10%     -51.5%      47434 ±  7%  interrupts.CPU2.CAL:Function_call_interrupts
    154321 ± 22%     -41.3%      90564 ±  2%  interrupts.CPU2.RES:Rescheduling_interrupts
     97332 ± 33%     -65.1%      33960 ± 16%  interrupts.CPU20.CAL:Function_call_interrupts
    161508 ± 26%     -48.3%      83533 ±  2%  interrupts.CPU20.RES:Rescheduling_interrupts
    101433 ± 24%     -49.8%      50929 ± 39%  interrupts.CPU21.CAL:Function_call_interrupts
      8678           -27.3%       6309 ±  8%  interrupts.CPU21.NMI:Non-maskable_interrupts
      8678           -27.3%       6309 ±  8%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
    146323 ± 23%     -40.0%      87782        interrupts.CPU21.RES:Rescheduling_interrupts
     89347 ± 16%     -50.4%      44339 ±  9%  interrupts.CPU22.CAL:Function_call_interrupts
      8680           -27.5%       6292 ±  8%  interrupts.CPU22.NMI:Non-maskable_interrupts
      8680           -27.5%       6292 ±  8%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
     92971 ±  8%     -44.2%      51920 ± 32%  interrupts.CPU23.CAL:Function_call_interrupts
      8681           -26.8%       6353 ± 10%  interrupts.CPU24.NMI:Non-maskable_interrupts
      8681           -26.8%       6353 ± 10%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
    107963 ± 26%     +40.5%     151674 ± 30%  interrupts.CPU25.CAL:Function_call_interrupts
     95907 ± 22%     +80.8%     173388 ± 34%  interrupts.CPU26.CAL:Function_call_interrupts
      8678           -27.0%       6337 ± 10%  interrupts.CPU29.NMI:Non-maskable_interrupts
      8678           -27.0%       6337 ± 10%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
    146737 ± 19%     -39.4%      88973 ±  2%  interrupts.CPU3.RES:Rescheduling_interrupts
     82742 ± 23%     +42.9%     118237 ± 12%  interrupts.CPU30.CAL:Function_call_interrupts
      8680           -47.1%       4590 ± 23%  interrupts.CPU30.NMI:Non-maskable_interrupts
      8680           -47.1%       4590 ± 23%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
      8678           -26.7%       6361 ± 10%  interrupts.CPU32.NMI:Non-maskable_interrupts
      8678           -26.7%       6361 ± 10%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
    101076 ± 19%     +21.6%     122921 ± 14%  interrupts.CPU33.CAL:Function_call_interrupts
      8681           -43.4%       4917 ± 42%  interrupts.CPU34.NMI:Non-maskable_interrupts
      8681           -43.4%       4917 ± 42%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
     88529 ± 15%     +71.6%     151900 ± 21%  interrupts.CPU37.CAL:Function_call_interrupts
     91637 ± 22%     +42.0%     130151 ±  4%  interrupts.CPU39.CAL:Function_call_interrupts
     98424 ± 23%     -52.7%      46561 ± 18%  interrupts.CPU4.CAL:Function_call_interrupts
    135853 ±  8%     -31.8%      92647 ±  7%  interrupts.CPU4.RES:Rescheduling_interrupts
      8681           -26.4%       6392 ± 11%  interrupts.CPU41.NMI:Non-maskable_interrupts
      8681           -26.4%       6392 ± 11%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
      8691           -27.1%       6334 ± 10%  interrupts.CPU42.NMI:Non-maskable_interrupts
      8691           -27.1%       6334 ± 10%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
     85664 ± 16%     +70.1%     145682 ± 24%  interrupts.CPU44.CAL:Function_call_interrupts
     96126 ± 17%     +30.4%     125315 ± 18%  interrupts.CPU46.CAL:Function_call_interrupts
    129280 ± 33%     -65.7%      44346 ± 23%  interrupts.CPU48.CAL:Function_call_interrupts
      0.17 ±223%  +3.7e+05%     617.50 ± 99%  interrupts.CPU49.85:PCI-MSI.31981618-edge.i40e-eth0-TxRx-49
     87848 ± 13%     -45.6%      47768 ± 32%  interrupts.CPU49.CAL:Function_call_interrupts
      8677           -26.9%       6343 ±  9%  interrupts.CPU49.NMI:Non-maskable_interrupts
      8677           -26.9%       6343 ±  9%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
    157134 ± 32%     -43.1%      89471 ±  5%  interrupts.CPU49.RES:Rescheduling_interrupts
     94157 ±  9%     -55.7%      41675 ± 30%  interrupts.CPU5.CAL:Function_call_interrupts
    137144 ± 21%     -35.0%      89077 ±  2%  interrupts.CPU5.RES:Rescheduling_interrupts
     96730 ± 30%     -45.9%      52337 ± 35%  interrupts.CPU50.CAL:Function_call_interrupts
    169729 ± 33%     -49.1%      86377 ±  2%  interrupts.CPU50.RES:Rescheduling_interrupts
     85659 ± 17%     -44.8%      47268 ± 23%  interrupts.CPU51.CAL:Function_call_interrupts
      8679           -63.6%       3162 ±  9%  interrupts.CPU51.NMI:Non-maskable_interrupts
      8679           -63.6%       3162 ±  9%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
    150936 ± 21%     -44.4%      83937 ±  9%  interrupts.CPU51.RES:Rescheduling_interrupts
     89499 ± 11%     -50.0%      44788 ± 33%  interrupts.CPU52.CAL:Function_call_interrupts
    136534 ± 13%     -38.5%      84029 ±  5%  interrupts.CPU52.RES:Rescheduling_interrupts
      0.00       +9.1e+104%     907.00 ± 98%  interrupts.CPU53.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
     95165 ± 19%     -60.2%      37920 ± 24%  interrupts.CPU54.CAL:Function_call_interrupts
      8677           -25.4%       6475 ±  5%  interrupts.CPU54.NMI:Non-maskable_interrupts
      8677           -25.4%       6475 ±  5%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
    144257 ± 24%     -46.1%      77713        interrupts.CPU54.RES:Rescheduling_interrupts
     86110 ± 23%     -48.8%      44102 ± 28%  interrupts.CPU55.CAL:Function_call_interrupts
    165553 ± 39%     -50.9%      81250 ±  2%  interrupts.CPU55.RES:Rescheduling_interrupts
     88875 ± 11%     -43.7%      49999 ± 23%  interrupts.CPU56.CAL:Function_call_interrupts
      8678           -26.8%       6348 ±  9%  interrupts.CPU56.NMI:Non-maskable_interrupts
      8678           -26.8%       6348 ±  9%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
    152559 ± 29%     -41.3%      89528 ±  2%  interrupts.CPU56.RES:Rescheduling_interrupts
    104697 ± 24%     -65.9%      35666 ± 27%  interrupts.CPU57.CAL:Function_call_interrupts
     93088 ± 27%     -49.5%      47014 ± 38%  interrupts.CPU58.CAL:Function_call_interrupts
    136961 ± 30%     -30.7%      94848 ±  2%  interrupts.CPU58.RES:Rescheduling_interrupts
     89163 ± 25%     -55.2%      39970 ±  2%  interrupts.CPU59.CAL:Function_call_interrupts
    137811 ± 16%     -41.7%      80338 ±  3%  interrupts.CPU59.RES:Rescheduling_interrupts
      0.67 ±223%  +2.6e+05%       1702 ± 89%  interrupts.CPU6.42:PCI-MSI.31981575-edge.i40e-eth0-TxRx-6
     95706 ± 21%     -50.2%      47643        interrupts.CPU6.CAL:Function_call_interrupts
     93374 ± 20%     -53.4%      43499 ± 40%  interrupts.CPU60.CAL:Function_call_interrupts
      8677           -47.3%       4573 ± 25%  interrupts.CPU60.NMI:Non-maskable_interrupts
      8677           -47.3%       4573 ± 25%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
    144391 ± 29%     -45.4%      78879        interrupts.CPU60.RES:Rescheduling_interrupts
    110191 ± 24%     -58.2%      46066 ± 33%  interrupts.CPU61.CAL:Function_call_interrupts
    161787 ± 23%     -52.2%      77254        interrupts.CPU61.RES:Rescheduling_interrupts
     92640 ± 21%     -48.6%      47661 ± 13%  interrupts.CPU62.CAL:Function_call_interrupts
      8676           -27.4%       6297 ±  9%  interrupts.CPU62.NMI:Non-maskable_interrupts
      8676           -27.4%       6297 ±  9%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
    132790 ± 19%     -44.1%      74282        interrupts.CPU62.RES:Rescheduling_interrupts
     89631 ± 30%     -58.2%      37443 ±  5%  interrupts.CPU63.CAL:Function_call_interrupts
    156124 ± 26%     -44.4%      86878 ±  5%  interrupts.CPU63.RES:Rescheduling_interrupts
    103552 ± 21%     -62.3%      39058 ± 20%  interrupts.CPU64.CAL:Function_call_interrupts
    166368 ± 28%     -51.7%      80391 ±  3%  interrupts.CPU64.RES:Rescheduling_interrupts
     91047 ± 16%     -47.1%      48199 ± 41%  interrupts.CPU65.CAL:Function_call_interrupts
    153443 ± 22%     -52.2%      73270        interrupts.CPU65.RES:Rescheduling_interrupts
     96228 ± 15%     -53.2%      44992 ±  4%  interrupts.CPU66.CAL:Function_call_interrupts
      8679           -27.4%       6305 ±  9%  interrupts.CPU66.NMI:Non-maskable_interrupts
      8679           -27.4%       6305 ±  9%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
    180396 ± 28%     -53.5%      83869        interrupts.CPU66.RES:Rescheduling_interrupts
     95624 ± 24%     -59.0%      39222 ± 30%  interrupts.CPU67.CAL:Function_call_interrupts
    103497 ± 27%     -55.8%      45774 ± 24%  interrupts.CPU68.CAL:Function_call_interrupts
    166658 ± 29%     -51.0%      81734        interrupts.CPU68.RES:Rescheduling_interrupts
    105198 ± 12%     -49.1%      53522 ± 11%  interrupts.CPU69.CAL:Function_call_interrupts
      8676           -27.3%       6308 ±  9%  interrupts.CPU69.NMI:Non-maskable_interrupts
      8676           -27.3%       6308 ±  9%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
    139760 ± 23%     -44.2%      77968        interrupts.CPU69.RES:Rescheduling_interrupts
     92717 ± 30%     -51.5%      44928 ±  6%  interrupts.CPU7.CAL:Function_call_interrupts
     98184 ± 28%     -57.0%      42241 ± 38%  interrupts.CPU70.CAL:Function_call_interrupts
     93861 ± 24%     -57.0%      40372 ± 26%  interrupts.CPU71.CAL:Function_call_interrupts
    136432 ± 18%     -40.9%      80625 ±  3%  interrupts.CPU71.RES:Rescheduling_interrupts
      8677           -27.0%       6335 ± 10%  interrupts.CPU73.NMI:Non-maskable_interrupts
      8677           -27.0%       6335 ± 10%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
      8677           -47.0%       4596 ± 24%  interrupts.CPU75.NMI:Non-maskable_interrupts
      8677           -47.0%       4596 ± 24%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
      8679           -27.1%       6326 ± 10%  interrupts.CPU76.NMI:Non-maskable_interrupts
      8679           -27.1%       6326 ± 10%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
     86491 ± 27%     -42.9%      49374 ±  9%  interrupts.CPU8.CAL:Function_call_interrupts
      8682           -63.3%       3184 ±  9%  interrupts.CPU8.NMI:Non-maskable_interrupts
      8682           -63.3%       3184 ±  9%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    101544 ± 23%     +26.6%     128589 ± 15%  interrupts.CPU82.CAL:Function_call_interrupts
      8680           -47.0%       4603 ± 24%  interrupts.CPU85.NMI:Non-maskable_interrupts
      8680           -47.0%       4603 ± 24%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
      8675           -47.1%       4585 ± 23%  interrupts.CPU86.NMI:Non-maskable_interrupts
      8675           -47.1%       4585 ± 23%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
      8677           -47.1%       4587 ± 23%  interrupts.CPU88.NMI:Non-maskable_interrupts
      8677           -47.1%       4587 ± 23%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
      8679           -26.4%       6384 ± 11%  interrupts.CPU89.NMI:Non-maskable_interrupts
      8679           -26.4%       6384 ± 11%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
     86292 ± 14%     -39.4%      52293 ±  3%  interrupts.CPU9.CAL:Function_call_interrupts
      8679           -27.4%       6301 ±  8%  interrupts.CPU9.NMI:Non-maskable_interrupts
      8679           -27.4%       6301 ±  8%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
      7232 ± 28%     -56.0%       3181 ± 10%  interrupts.CPU94.NMI:Non-maskable_interrupts
      7232 ± 28%     -56.0%       3181 ± 10%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
    288.00           -33.3%     192.00        interrupts.MCP:Machine_check_polls
    763672           -26.8%     558809 ±  8%  interrupts.NMI:Non-maskable_interrupts
    763672           -26.8%     558809 ±  8%  interrupts.PMI:Performance_monitoring_interrupts
  12807267 ± 11%     -25.5%    9535680 ± 15%  interrupts.RES:Rescheduling_interrupts
     39.16           -14.8       24.36 ±  4%  perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     39.22           -14.8       24.45 ±  4%  perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
     40.41           -14.1       26.34 ±  4%  perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
     12.52 ±  2%     -12.5        0.00        perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     20.73           -12.5        8.28 ±  4%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
     19.57            -7.5       12.12 ±  2%  perf-profile.calltrace.cycles-pp.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     14.54            -6.2        8.34 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
     23.30            -5.9       17.39 ±  2%  perf-profile.calltrace.cycles-pp.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      5.72 ±  2%      -5.7        0.00        perf-profile.calltrace.cycles-pp.refill_obj_stock.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      5.62 ±  2%      -5.6        0.00        perf-profile.calltrace.cycles-pp.drain_obj_stock.refill_obj_stock.kfree.consume_skb.unix_stream_read_generic
      5.57            -5.6        0.00        perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     47.67            -4.8       42.88        perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write
     47.98            -4.7       43.34        perf-profile.calltrace.cycles-pp.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write.ksys_write
     48.20            -4.5       43.66        perf-profile.calltrace.cycles-pp.sock_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     48.38            -4.2       44.14        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.61            -3.9       42.70        perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read
     46.71            -3.9       42.83        perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read.ksys_read
     47.21            -3.6       43.60        perf-profile.calltrace.cycles-pp.sock_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
     47.37            -3.5       43.86        perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     17.37            -2.7       14.64 ±  4%  perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     17.44            -2.7       14.74 ±  4%  perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      8.71 ±  3%      -2.3        6.42 ± 16%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      8.77 ±  3%      -2.3        6.48 ± 16%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      8.96 ±  3%      -2.2        6.72 ± 15%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write
      8.94 ±  3%      -2.2        6.70 ± 15%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      9.06 ±  3%      -2.2        6.82 ± 15%  perf-profile.calltrace.cycles-pp.__libc_write
      8.52 ±  4%      -2.1        6.38 ± 13%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      8.57 ±  4%      -2.1        6.43 ± 13%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      8.65 ±  4%      -2.1        6.52 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read
      8.63 ±  4%      -2.1        6.50 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      8.76 ±  4%      -2.1        6.64 ± 13%  perf-profile.calltrace.cycles-pp.__libc_read
      0.62 ±  2%      +0.0        0.66 ±  3%  perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.54 ±  4%      +0.2        0.70 ±  4%  perf-profile.calltrace.cycles-pp.unix_write_space.sock_wfree.unix_destruct_scm.skb_release_head_state.skb_release_all
      1.23 ±  3%      +0.2        1.41 ±  4%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      0.61 ±  2%      +0.2        0.80 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      0.62            +0.2        0.82 ±  3%  perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      1.26 ±  3%      +0.2        1.46 ±  4%  perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      1.41 ±  3%      +0.3        1.66 ±  3%  perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      0.77 ±  2%      +0.3        1.09 ±  4%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      2.08 ±  2%      +0.5        2.55 ±  3%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg
      2.09 ±  2%      +0.5        2.58 ±  3%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      2.10 ±  2%      +0.5        2.60 ±  3%  perf-profile.calltrace.cycles-pp.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.00            +0.5        0.53 ±  3%  perf-profile.calltrace.cycles-pp.zap_pte_range.unmap_page_range.unmap_vmas.exit_mmap.mmput
      0.00            +0.5        0.54 ±  4%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.do_exit
      0.00            +0.6        0.56 ±  5%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.do_exit.do_group_exit
      0.00            +0.6        0.58 ±  4%  perf-profile.calltrace.cycles-pp._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      0.00            +0.6        0.62 ±  4%  perf-profile.calltrace.cycles-pp.__build_skb_around.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      0.00            +0.6        0.63 ±  7%  perf-profile.calltrace.cycles-pp.mutex_unlock.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.00            +0.7        0.70        perf-profile.calltrace.cycles-pp.__slab_free.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00            +0.7        0.70        perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule.exit_to_user_mode_prepare
      0.00            +0.7        0.72        perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      1.86 ±  2%      +0.7        2.60 ±  4%  perf-profile.calltrace.cycles-pp.sock_wfree.unix_destruct_scm.skb_release_head_state.skb_release_all.consume_skb
      0.00            +0.7        0.74 ± 16%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_uncharge.obj_cgroup_uncharge_pages.kmem_cache_free.unix_stream_read_generic
      0.80            +0.8        1.58 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.00            +0.8        0.81        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.skb_queue_tail.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      0.00            +0.8        0.81 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.00            +0.8        0.84        perf-profile.calltrace.cycles-pp.skb_queue_tail.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      0.08 ±223%      +0.9        0.94 ±  6%  perf-profile.calltrace.cycles-pp.skb_set_owner_w.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      1.14 ±  3%      +0.9        2.00 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      0.00            +0.9        0.89 ± 31%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg
      0.00            +0.9        0.90 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.72 ± 15%      +0.9        1.66        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.0        0.95 ± 29%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_sendmsg
      0.81 ± 14%      +1.0        1.79        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.91 ±  2%      +1.0        2.92 ±  4%  perf-profile.calltrace.cycles-pp.unix_destruct_scm.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic
      1.94 ±  2%      +1.0        2.96 ±  4%  perf-profile.calltrace.cycles-pp.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      1.93 ±  2%      +1.0        2.96 ±  4%  perf-profile.calltrace.cycles-pp.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      0.00            +1.0        1.04 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.skb_unlink.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00            +1.1        1.06 ± 18%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node
      0.00            +1.1        1.06 ±  2%  perf-profile.calltrace.cycles-pp.skb_unlink.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.00            +1.1        1.07        perf-profile.calltrace.cycles-pp.unwind_next_frame.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample
      0.00            +1.1        1.10 ±  2%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00            +1.1        1.12 ± 26%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.11 ±223%      +1.1        1.25        perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.11 ±223%      +1.1        1.26        perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.73 ±  8%      +1.2        1.90        perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.enqueue_entity
      0.74 ±  8%      +1.2        1.94        perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.enqueue_entity.enqueue_task_fair
      0.69 ±  8%      +1.2        1.92        perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule.schedule_timeout
      0.75 ±  7%      +1.2        2.00        perf-profile.calltrace.cycles-pp.perf_trace_sched_switch.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      0.75 ±  8%      +1.2        2.00        perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.enqueue_entity.enqueue_task_fair.ttwu_do_activate
      0.73 ±  8%      +1.3        2.04 ±  3%  perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_wakeup_template
      0.74 ±  8%      +1.3        2.05 ±  3%  perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up
      0.74 ±  8%      +1.3        2.06 ±  3%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function
      0.79 ±  8%      +1.3        2.11        perf-profile.calltrace.cycles-pp.update_curr.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      0.89 ±  7%      +1.3        2.24 ±  2%  perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity
      0.00            +1.4        1.35 ± 27%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.4        1.36 ±  5%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x64_sys_exit_group
      0.92 ±  6%      +1.4        2.28 ±  2%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair
      0.00            +1.4        1.36 ±  4%  perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00            +1.4        1.37 ± 27%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.77 ±  7%      +1.4        2.14 ±  3%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.96 ±  6%      +1.4        2.34 ±  2%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.dequeue_entity.dequeue_task_fair.__schedule
      0.80 ±  7%      +1.4        2.20 ±  3%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.00 ±  6%      +1.5        2.46 ±  2%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.90 ±  8%      +1.5        2.38        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      0.00            +1.5        1.48 ± 15%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_uncharge.obj_cgroup_uncharge_pages.kfree.consume_skb
      1.04 ±  6%      +1.6        2.62 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      1.01 ±  7%      +1.7        2.67        perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.00            +1.7        1.66 ± 28%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +1.7        1.66 ± 28%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +1.7        1.66 ± 28%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      1.03 ±  7%      +1.7        2.70        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.00            +1.7        1.72 ± 29%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      1.14 ±  6%      +1.8        2.90        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      0.00            +1.9        1.86 ± 11%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.9        1.86 ± 11%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.9        1.86 ± 11%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.66 ±  8%      +1.9        2.52        perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch
      0.68 ±  8%      +1.9        2.56        perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch.__schedule
      0.68 ±  8%      +1.9        2.56        perf-profile.calltrace.cycles-pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch.__schedule.schedule
      0.08 ±223%      +2.0        2.08 ± 18%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller
      0.00            +2.0        2.04 ± 13%  perf-profile.calltrace.cycles-pp.perf_callchain_user.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
      1.57 ±  7%      +2.5        4.09        perf-profile.calltrace.cycles-pp.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime
      1.60 ±  7%      +2.5        4.12        perf-profile.calltrace.cycles-pp.__perf_event_overflow.perf_swevent_overflow.perf_tp_event.perf_trace_sched_stat_runtime.update_curr
      0.00            +4.2        4.23 ±  3%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.obj_cgroup_uncharge_pages.kmem_cache_free.unix_stream_read_generic
      2.78 ±  6%      +4.5        7.28        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg
      2.80 ±  6%      +4.5        7.32        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      2.83 ±  6%      +4.5        7.37        perf-profile.calltrace.cycles-pp.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.17 ±223%      +4.6        4.74        perf-profile.calltrace.cycles-pp.perf_callchain_kernel.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward
      1.18 ±  6%      +4.7        5.89 ±  7%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb
      3.29 ± 15%      +4.9        8.22 ±  2%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable
      3.31 ± 15%      +5.0        8.26 ±  2%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg
      3.35 ± 15%      +5.0        8.34 ±  2%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_sendmsg
      1.32 ±  5%      +5.0        6.36 ±  6%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge_pages.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      1.37 ±  5%      +5.1        6.45 ±  6%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.00            +5.1        5.14 ±  5%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.obj_cgroup_uncharge_pages.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
      2.66 ±  8%      +5.1        7.80        perf-profile.calltrace.cycles-pp.get_perf_callchain.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow
      2.68 ±  8%      +5.2        7.84        perf-profile.calltrace.cycles-pp.perf_callchain.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow
      2.88 ±  7%      +5.4        8.24        perf-profile.calltrace.cycles-pp.perf_prepare_sample.perf_event_output_forward.__perf_event_overflow.perf_swevent_overflow.perf_tp_event
      0.00            +5.6        5.58 ±  4%  perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      3.49 ± 11%      +6.0        9.52 ±  6%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      4.02 ± 10%      +7.0       10.97 ±  5%  perf-profile.calltrace.cycles-pp.sock_def_readable.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      0.00            +8.3        8.28 ±  2%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.obj_cgroup_uncharge_pages.kfree.consume_skb
      2.63 ± 13%      +9.0       11.59 ±  6%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve
      3.38 ±  5%      +9.3       12.64 ±  5%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      3.22 ± 11%      +9.3       12.51 ±  5%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge_pages.obj_cgroup_charge.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      0.00           +10.1       10.07 ±  4%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.obj_cgroup_uncharge_pages.kfree.consume_skb.unix_stream_read_generic
      0.00           +11.0       10.96 ±  3%  perf-profile.calltrace.cycles-pp.obj_cgroup_uncharge_pages.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
     18.12 ±  2%     -17.5        0.60 ±  8%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
     39.18           -14.8       24.38 ±  4%  perf-profile.children.cycles-pp.__alloc_skb
     39.22           -14.8       24.46 ±  4%  perf-profile.children.cycles-pp.alloc_skb_with_frags
     40.41           -14.1       26.35 ±  4%  perf-profile.children.cycles-pp.sock_alloc_send_pskb
     20.76           -12.4        8.32 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      9.95            -9.8        0.17        perf-profile.children.cycles-pp.refill_obj_stock
      9.77            -9.8        0.00        perf-profile.children.cycles-pp.drain_obj_stock
     19.57            -7.4       12.14 ±  2%  perf-profile.children.cycles-pp.kfree
     23.30            -5.9       17.39 ±  2%  perf-profile.children.cycles-pp.consume_skb
     14.56            -5.9        8.68 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
     47.69            -4.8       42.92        perf-profile.children.cycles-pp.unix_stream_sendmsg
     48.00            -4.6       43.35        perf-profile.children.cycles-pp.sock_sendmsg
     48.20            -4.5       43.66        perf-profile.children.cycles-pp.sock_write_iter
     48.39            -4.2       44.16        perf-profile.children.cycles-pp.new_sync_write
     48.96            -4.0       44.98        perf-profile.children.cycles-pp.vfs_write
     46.63            -3.9       42.72        perf-profile.children.cycles-pp.unix_stream_read_generic
     49.27            -3.9       45.40        perf-profile.children.cycles-pp.ksys_write
     46.71            -3.9       42.84        perf-profile.children.cycles-pp.unix_stream_recvmsg
     47.21            -3.6       43.60        perf-profile.children.cycles-pp.sock_read_iter
     47.38            -3.5       43.87        perf-profile.children.cycles-pp.new_sync_read
      5.10            -3.4        1.72 ±  4%  perf-profile.children.cycles-pp.mod_objcg_state
     48.06            -3.2       44.86        perf-profile.children.cycles-pp.vfs_read
     98.81            -3.1       95.68        perf-profile.children.cycles-pp.do_syscall_64
     48.31            -3.1       45.20        perf-profile.children.cycles-pp.ksys_read
     98.97            -3.0       95.92        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     17.41            -2.7       14.70 ±  4%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
     17.45            -2.7       14.76 ±  4%  perf-profile.children.cycles-pp.kmalloc_reserve
      9.08 ±  3%      -2.2        6.85 ± 15%  perf-profile.children.cycles-pp.__libc_write
      8.79 ±  4%      -2.1        6.67 ± 13%  perf-profile.children.cycles-pp.__libc_read
      2.45 ±  3%      -1.4        1.04 ± 11%  perf-profile.children.cycles-pp.get_mem_cgroup_from_objcg
      0.08 ±  6%      +0.0        0.09        perf-profile.children.cycles-pp.check_stack_object
      0.42            +0.0        0.44        perf-profile.children.cycles-pp.task_tick_fair
      0.07 ±  5%      +0.0        0.09        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.06 ±  8%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.get_stack_info
      0.06 ±  8%      +0.0        0.09        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.04 ± 72%      +0.0        0.08 ± 12%  perf-profile.children.cycles-pp.mem_cgroup_from_task
      0.13 ±  3%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.aa_file_perm
      0.06 ±  6%      +0.0        0.10        perf-profile.children.cycles-pp.security_socket_getpeersec_dgram
      0.10 ±  4%      +0.0        0.14        perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.07 ±  7%      +0.0        0.11        perf-profile.children.cycles-pp.rcu_all_qs
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.kmalloc_slab
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__calc_delta
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__mmdrop
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.preempt_schedule_common
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__dentry_kill
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.d_invalidate
      0.45            +0.1        0.50 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.update_min_vruntime
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.machines__deliver_event
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.___perf_sw_event
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.copy_fpregs_to_fpstate
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.perf_tp_event_match
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.get_callchain_entry
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__is_insn_slot_addr
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.perf_trace_buf_update
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.get_stack_info_noinstr
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.ktime_get
      0.11            +0.1        0.17        perf-profile.children.cycles-pp.perf_event_pid_type
      0.08            +0.1        0.14        perf-profile.children.cycles-pp.__update_load_avg_se
      0.01 ±223%      +0.1        0.07        perf-profile.children.cycles-pp.perf_misc_flags
      0.15 ±  4%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.__might_fault
      0.10 ±  4%      +0.1        0.16        perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.00            +0.1        0.06 ± 23%  perf-profile.children.cycles-pp.ordered_events__queue
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__free_pages_ok
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.pick_next_entity
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.proc_invalidate_siblings_dcache
      0.08 ±  6%      +0.1        0.14        perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.put_prev_entity
      0.17 ±  2%      +0.1        0.24 ±  2%  perf-profile.children.cycles-pp.__ksize
      0.09 ±  4%      +0.1        0.16 ±  6%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.09 ±  5%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.__switch_to_asm
      0.10 ±  4%      +0.1        0.17 ±  5%  perf-profile.children.cycles-pp.set_next_entity
      0.00            +0.1        0.08 ± 33%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.00            +0.1        0.08 ± 33%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.05 ±  7%      +0.1        0.13        perf-profile.children.cycles-pp.cpuacct_charge
      0.05 ± 45%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.12 ±  4%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.wait_for_unix_gc
      0.07            +0.1        0.15        perf-profile.children.cycles-pp.__list_del_entry_valid
      0.08 ±  5%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.__switch_to
      0.00            +0.1        0.08 ± 37%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.bpf_ksym_find
      0.00            +0.1        0.08 ± 25%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.00            +0.1        0.08 ± 25%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.51            +0.1        0.59 ±  3%  perf-profile.children.cycles-pp.tick_sched_handle
      0.05 ±  8%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.17 ±  3%      +0.1        0.26        perf-profile.children.cycles-pp.__cond_resched
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.kvm_is_in_guest
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.unlink_file_vma
      0.08 ±  6%      +0.1        0.16        perf-profile.children.cycles-pp.perf_output_begin_forward
      0.52            +0.1        0.60 ±  4%  perf-profile.children.cycles-pp.tick_sched_timer
      0.09 ±  5%      +0.1        0.18        perf-profile.children.cycles-pp.load_new_mm_cr3
      0.07 ± 10%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.update_rq_clock
      0.01 ±223%      +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.check_preempt_wakeup
      0.49            +0.1        0.58 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.26 ±  2%      +0.1        0.34 ± 10%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.00            +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.worker_thread
      0.27 ±  3%      +0.1        0.36        perf-profile.children.cycles-pp.__entry_text_start
      0.08 ±  8%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.ftrace_graph_ret_addr
      0.24 ±  2%      +0.1        0.34        perf-profile.children.cycles-pp.security_socket_sendmsg
      0.00            +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.filemap_map_pages
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.uncharge_batch
      0.23            +0.1        0.32        perf-profile.children.cycles-pp.__might_sleep
      0.01 ±223%      +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.bad_get_user
      0.00            +0.1        0.10 ± 40%  perf-profile.children.cycles-pp.copy_page_range
      0.00            +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.release_task
      0.09 ±  4%      +0.1        0.19        perf-profile.children.cycles-pp.reweight_entity
      0.01 ±223%      +0.1        0.11        perf-profile.children.cycles-pp.is_bpf_text_address
      0.56            +0.1        0.66 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.10 ±  4%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.cmp_ex_search
      0.02 ±141%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.check_preempt_curr
      0.00            +0.1        0.11 ± 18%  perf-profile.children.cycles-pp.do_fault
      0.00            +0.1        0.11        perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.00            +0.1        0.11 ±  9%  perf-profile.children.cycles-pp.wait_task_zombie
      0.08 ±  7%      +0.1        0.20 ±  7%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.00            +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.rcu_do_batch
      0.17 ±  6%      +0.1        0.28        perf-profile.children.cycles-pp.switch_fpu_return
      0.00            +0.1        0.12        perf-profile.children.cycles-pp.remove_vma
      0.20 ±  2%      +0.1        0.32        perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.41 ±  2%      +0.1        0.54        perf-profile.children.cycles-pp.__fget_light
      0.00            +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.rcu_core
      0.28 ±  2%      +0.1        0.41        perf-profile.children.cycles-pp.__check_heap_object
      0.01 ±223%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.unfreeze_partials
      0.00            +0.1        0.13 ± 38%  perf-profile.children.cycles-pp.__alloc_pages
      0.00            +0.1        0.13 ±  7%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.06 ±  7%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.update_cfs_group
      0.02 ±141%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.put_cpu_partial
      0.00            +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.00            +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.46 ±  2%      +0.1        0.60        perf-profile.children.cycles-pp.__fdget_pos
      0.25 ±  2%      +0.1        0.40        perf-profile.children.cycles-pp.security_socket_recvmsg
      0.30 ±  4%      +0.1        0.44        perf-profile.children.cycles-pp.fsnotify
      0.64 ±  2%      +0.2        0.80 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.64 ±  2%      +0.2        0.80 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.15 ±  2%      +0.2        0.31 ±  3%  perf-profile.children.cycles-pp.drain_stock
      0.33 ±  2%      +0.2        0.50 ± 13%  perf-profile.children.cycles-pp.copyin
      0.66 ±  3%      +0.2        0.82 ±  2%  perf-profile.children.cycles-pp.unix_write_space
      0.41 ±  3%      +0.2        0.57        perf-profile.children.cycles-pp.common_file_perm
      0.52 ±  3%      +0.2        0.69        perf-profile.children.cycles-pp._copy_from_iter
      0.00            +0.2        0.17 ±  5%  perf-profile.children.cycles-pp.kthread
      0.00            +0.2        0.17 ±  5%  perf-profile.children.cycles-pp.__softirqentry_text_start
      1.53 ±  3%      +0.2        1.70        perf-profile.children.cycles-pp.copyout
      0.30 ±  2%      +0.2        0.47 ±  2%  perf-profile.children.cycles-pp.sock_recvmsg
      0.56 ±  3%      +0.2        0.73        perf-profile.children.cycles-pp.__build_skb_around
      0.39 ±  3%      +0.2        0.56        perf-profile.children.cycles-pp.mutex_lock
      0.15 ±  5%      +0.2        0.32        perf-profile.children.cycles-pp.bsearch
      0.34 ±  3%      +0.2        0.52        perf-profile.children.cycles-pp.___might_sleep
      0.23 ±  3%      +0.2        0.41 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.38            +0.2        0.56        perf-profile.children.cycles-pp.aa_sk_perm
      0.00            +0.2        0.19 ± 21%  perf-profile.children.cycles-pp.wp_page_copy
      0.00            +0.2        0.19        perf-profile.children.cycles-pp.ret_from_fork
      0.15 ±  3%      +0.2        0.34        perf-profile.children.cycles-pp.search_extable
      0.47 ±  3%      +0.2        0.66        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.17 ±  4%      +0.2        0.36 ±  4%  perf-profile.children.cycles-pp.refill_stock
      0.16 ±  4%      +0.2        0.35        perf-profile.children.cycles-pp.search_exception_tables
      0.00            +0.2        0.20 ± 33%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.2        0.20        perf-profile.children.cycles-pp.__memcg_kmem_uncharge_page
      0.76 ±  2%      +0.2        0.96        perf-profile.children.cycles-pp.simple_copy_to_iter
      0.00            +0.2        0.20 ±  7%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.00            +0.2        0.21 ±  4%  perf-profile.children.cycles-pp.put_task_stack
      0.18 ±  3%      +0.2        0.40        perf-profile.children.cycles-pp.fixup_exception
      0.00            +0.2        0.22 ±  4%  perf-profile.children.cycles-pp.process_simple
      0.00            +0.2        0.22 ± 33%  perf-profile.children.cycles-pp.dup_mmap
      0.10 ±  3%      +0.2        0.33 ±  9%  perf-profile.children.cycles-pp.prepare_to_wait
      0.00            +0.2        0.24 ±  4%  perf-profile.children.cycles-pp.cmd_record
      0.00            +0.2        0.24 ±  4%  perf-profile.children.cycles-pp.record__finish_output
      0.00            +0.2        0.24 ±  4%  perf-profile.children.cycles-pp.perf_session__process_events
      0.21 ±  4%      +0.2        0.46        perf-profile.children.cycles-pp.kernelmode_fixup_or_oops
      1.71 ±  2%      +0.2        1.95 ±  2%  perf-profile.children.cycles-pp._copy_to_iter
      0.00            +0.2        0.24 ± 34%  perf-profile.children.cycles-pp.dup_mm
      0.00            +0.2        0.25 ±  4%  perf-profile.children.cycles-pp.page_remove_rmap
      0.60 ±  2%      +0.3        0.86        perf-profile.children.cycles-pp.security_file_permission
      0.68 ±  2%      +0.3        0.94 ±  6%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.28 ±  5%      +0.3        0.56        perf-profile.children.cycles-pp.get_partial_node
      0.00            +0.3        0.29 ±  3%  perf-profile.children.cycles-pp.wait_consider_task
      0.19 ±  4%      +0.3        0.48        perf-profile.children.cycles-pp.kernel_text_address
      0.00            +0.3        0.30 ± 42%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
      0.27 ±  4%      +0.3        0.56        perf-profile.children.cycles-pp.native_irq_return_iret
      0.20 ±  6%      +0.3        0.50        perf-profile.children.cycles-pp.stack_access_ok
      0.72 ±  4%      +0.3        1.02 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.14 ±  4%      +0.3        0.44 ±  2%  perf-profile.children.cycles-pp.try_charge
      0.00            +0.3        0.30 ±  3%  perf-profile.children.cycles-pp.release_pages
      1.83 ±  2%      +0.3        2.14        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.00            +0.3        0.32 ±  7%  perf-profile.children.cycles-pp.free_pgtables
      0.00            +0.3        0.32 ± 34%  perf-profile.children.cycles-pp.copy_process
      0.95 ±  2%      +0.3        1.28        perf-profile.children.cycles-pp.skb_copy_datagram_from_iter
      0.00            +0.3        0.34 ±  2%  perf-profile.children.cycles-pp.tlb_flush_mmu
      0.00            +0.3        0.34 ± 36%  perf-profile.children.cycles-pp.__do_sys_clone
      0.00            +0.3        0.34 ± 36%  perf-profile.children.cycles-pp.kernel_clone
      1.11            +0.3        1.46        perf-profile.children.cycles-pp.__check_object_size
      0.19 ±  3%      +0.3        0.54 ±  6%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.4        0.35 ±  2%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.00            +0.4        0.36 ± 21%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.25 ±  4%      +0.4        0.62        perf-profile.children.cycles-pp.__kernel_text_address
      0.00            +0.4        0.38 ± 20%  perf-profile.children.cycles-pp.perf_trace_sched_migrate_task
      0.00            +0.4        0.38 ± 23%  perf-profile.children.cycles-pp.handle_mm_fault
      0.25 ±  6%      +0.4        0.64 ±  5%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.04 ± 44%      +0.4        0.45 ±  6%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.4        0.42 ± 36%  perf-profile.children.cycles-pp.__libc_fork
      0.00            +0.4        0.42 ± 19%  perf-profile.children.cycles-pp.set_task_cpu
      0.32 ±  4%      +0.4        0.76 ±  4%  perf-profile.children.cycles-pp.mutex_unlock
      0.44 ±  5%      +0.4        0.88 ±  2%  perf-profile.children.cycles-pp.___slab_alloc
      0.45 ±  4%      +0.4        0.90 ±  2%  perf-profile.children.cycles-pp.__slab_alloc
      2.52 ±  2%      +0.5        2.98        perf-profile.children.cycles-pp.__skb_datagram_iter
      0.00            +0.5        0.46 ±  2%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.00            +0.5        0.46 ±  2%  perf-profile.children.cycles-pp.kernel_wait4
      0.00            +0.5        0.46 ±  2%  perf-profile.children.cycles-pp.do_wait
      2.54 ±  2%      +0.5        3.00        perf-profile.children.cycles-pp.skb_copy_datagram_iter
      0.00            +0.5        0.46 ±  3%  perf-profile.children.cycles-pp.__libc_wait
      0.32 ±  4%      +0.5        0.79 ±  3%  perf-profile.children.cycles-pp.orc_find
      0.32 ±  3%      +0.5        0.78        perf-profile.children.cycles-pp.unwind_get_return_address
      0.00            +0.5        0.46 ± 20%  perf-profile.children.cycles-pp.do_user_addr_fault
      2.56 ±  2%      +0.5        3.02        perf-profile.children.cycles-pp.unix_stream_read_actor
      0.60 ±  2%      +0.5        1.10 ±  3%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.00            +0.5        0.54 ±  4%  perf-profile.children.cycles-pp.zap_pte_range
      0.00            +0.5        0.54 ±  4%  perf-profile.children.cycles-pp.unmap_page_range
      0.00            +0.6        0.56 ±  5%  perf-profile.children.cycles-pp.unmap_vmas
      0.18 ± 22%      +0.6        0.80 ± 10%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.35 ±  4%      +0.6        0.99 ±  2%  perf-profile.children.cycles-pp.skb_queue_tail
      0.26 ± 15%      +0.7        0.94 ±  8%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.28 ±  3%      +0.7        1.00 ±  9%  perf-profile.children.cycles-pp.exc_page_fault
      2.26 ±  2%      +0.8        3.04        perf-profile.children.cycles-pp.sock_wfree
      2.33 ±  2%      +0.8        3.13        perf-profile.children.cycles-pp.unix_destruct_scm
      2.36 ±  2%      +0.8        3.16        perf-profile.children.cycles-pp.skb_release_all
      2.35 ±  2%      +0.8        3.16        perf-profile.children.cycles-pp.skb_release_head_state
      0.61 ±  3%      +0.8        1.42        perf-profile.children.cycles-pp.__orc_find
      0.44 ±  4%      +0.8        1.26        perf-profile.children.cycles-pp.skb_unlink
      0.91 ± 11%      +1.0        1.92        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      1.02 ± 10%      +1.0        2.07        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.00            +1.2        1.17 ± 28%  perf-profile.children.cycles-pp.intel_idle
      0.80 ±  2%      +1.4        2.16        perf-profile.children.cycles-pp.__slab_free
      0.00            +1.4        1.36 ±  5%  perf-profile.children.cycles-pp.exit_mmap
      0.00            +1.4        1.36 ±  4%  perf-profile.children.cycles-pp.mmput
      0.00            +1.4        1.41 ± 28%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.00            +1.4        1.42 ± 28%  perf-profile.children.cycles-pp.cpuidle_enter
      0.84 ±  4%      +1.5        2.33 ±  4%  perf-profile.children.cycles-pp.asm_exc_page_fault
      1.15 ±  3%      +1.5        2.66        perf-profile.children.cycles-pp.__unwind_start
      1.15 ±  3%      +1.5        2.70 ±  4%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      1.40 ±  4%      +1.6        3.00        perf-profile.children.cycles-pp.__get_user_nocheck_8
      1.28 ±  3%      +1.6        2.91        perf-profile.children.cycles-pp.enqueue_entity
      0.00            +1.7        1.66 ± 28%  perf-profile.children.cycles-pp.start_secondary
      1.52 ±  2%      +1.7        3.22 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      1.49 ±  4%      +1.7        3.21        perf-profile.children.cycles-pp.perf_callchain_user
      0.00            +1.7        1.72 ± 29%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.00            +1.7        1.72 ± 29%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.00            +1.7        1.72 ± 29%  perf-profile.children.cycles-pp.do_idle
      1.43 ±  3%      +1.8        3.26        perf-profile.children.cycles-pp.enqueue_task_fair
      1.46 ±  3%      +1.8        3.30        perf-profile.children.cycles-pp.ttwu_do_activate
      1.46 ±  6%      +1.9        3.32 ±  3%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.00            +1.9        1.87 ± 11%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.00            +1.9        1.87 ± 11%  perf-profile.children.cycles-pp.do_group_exit
      0.00            +1.9        1.87 ± 11%  perf-profile.children.cycles-pp.do_exit
      1.66 ±  2%      +1.9        3.56 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.84 ±  4%      +2.8        3.64 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.08 ± 20%      +2.8        2.90 ± 16%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      2.80 ±  2%      +2.9        5.66        perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      2.14 ±  4%      +3.0        5.12        perf-profile.children.cycles-pp.unwind_next_frame
      2.97 ±  2%      +3.1        6.12        perf-profile.children.cycles-pp.update_curr
      2.63 ±  3%      +3.7        6.30 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      2.82 ±  4%      +3.9        6.71        perf-profile.children.cycles-pp.perf_callchain_kernel
      3.48 ±  2%      +4.4        7.93        perf-profile.children.cycles-pp.schedule_timeout
      3.87 ± 10%      +4.9        8.73 ±  2%  perf-profile.children.cycles-pp.autoremove_wake_function
      3.84 ± 10%      +4.9        8.72 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
      3.91 ± 10%      +4.9        8.80 ±  2%  perf-profile.children.cycles-pp.__wake_up_common
      1.53 ±  7%      +5.3        6.82 ± 14%  perf-profile.children.cycles-pp.propagate_protected_usage
      4.04 ±  4%      +5.3        9.35        perf-profile.children.cycles-pp.schedule
      4.06 ±  4%      +5.5        9.59 ±  2%  perf-profile.children.cycles-pp.__schedule
      4.42 ±  4%      +5.7       10.11        perf-profile.children.cycles-pp.get_perf_callchain
      4.45 ±  4%      +5.7       10.16        perf-profile.children.cycles-pp.perf_callchain
      4.79 ±  3%      +5.9       10.72        perf-profile.children.cycles-pp.perf_prepare_sample
      3.97 ± 10%      +6.0       10.00 ±  5%  perf-profile.children.cycles-pp.__wake_up_common_lock
      4.93 ±  4%      +6.4       11.28 ±  3%  perf-profile.children.cycles-pp.perf_event_output_forward
      5.03 ±  4%      +6.4       11.39 ±  3%  perf-profile.children.cycles-pp.perf_swevent_overflow
      4.99 ±  4%      +6.4       11.35 ±  3%  perf-profile.children.cycles-pp.__perf_event_overflow
      5.19 ±  3%      +6.5       11.70 ±  3%  perf-profile.children.cycles-pp.perf_tp_event
      4.02 ± 10%      +7.0       10.97 ±  5%  perf-profile.children.cycles-pp.sock_def_readable
      2.74 ±  9%     +10.2       12.93 ±  2%  perf-profile.children.cycles-pp.page_counter_cancel
      5.47 ±  3%     +11.5       16.93 ±  3%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      3.39 ±  7%     +12.6       15.94 ±  4%  perf-profile.children.cycles-pp.page_counter_uncharge
      4.32 ±  6%     +13.6       17.88 ±  6%  perf-profile.children.cycles-pp.page_counter_try_charge
      4.91 ±  5%     +14.0       18.92 ±  5%  perf-profile.children.cycles-pp.obj_cgroup_charge_pages
      5.05 ±  5%     +14.1       19.10 ±  5%  perf-profile.children.cycles-pp.obj_cgroup_charge
     17.91 ±  2%     -17.4        0.49 ±  8%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
     11.30 ±  2%     -10.7        0.62        perf-profile.self.cycles-pp.kfree
      7.86            -6.9        0.94        perf-profile.self.cycles-pp.kmem_cache_free
      7.66 ±  2%      -6.9        0.76        perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      5.86 ±  3%      -5.3        0.52        perf-profile.self.cycles-pp.kmem_cache_alloc_node
      4.83            -4.0        0.80        perf-profile.self.cycles-pp.mod_objcg_state
      2.44 ±  3%      -1.4        1.02 ± 11%  perf-profile.self.cycles-pp.get_mem_cgroup_from_objcg
      0.36 ± 44%      -0.2        0.18        perf-profile.self.cycles-pp.select_idle_cpu
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.__skb_datagram_iter
      0.06 ±  8%      +0.0        0.07        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.05            +0.0        0.07        perf-profile.self.cycles-pp.__fdget_pos
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.05 ± 13%      +0.0        0.08 ± 20%  perf-profile.self.cycles-pp.perf_event_output_forward
      0.06 ±  6%      +0.0        0.08        perf-profile.self.cycles-pp.unix_destruct_scm
      0.05            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.sock_recvmsg
      0.05 ±  7%      +0.0        0.08        perf-profile.self.cycles-pp.reweight_entity
      0.04 ± 73%      +0.0        0.07 ± 14%  perf-profile.self.cycles-pp.mem_cgroup_from_task
      0.05 ±  8%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.ksys_write
      0.08 ±  4%      +0.0        0.11        perf-profile.self.cycles-pp.unix_stream_recvmsg
      0.11 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.aa_file_perm
      0.05 ±  7%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.skb_copy_datagram_from_iter
      0.04 ± 44%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.ksys_read
      0.05            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.12 ±  5%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp._copy_to_iter
      0.09 ±  4%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.security_file_permission
      0.06 ±  7%      +0.0        0.10        perf-profile.self.cycles-pp.__cond_resched
      0.03 ± 70%      +0.0        0.07        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.04 ± 44%      +0.0        0.08        perf-profile.self.cycles-pp.rcu_all_qs
      0.12 ±  4%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp._copy_from_iter
      0.06 ±  7%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.sock_sendmsg
      0.06 ±  7%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.06            +0.0        0.10        perf-profile.self.cycles-pp.rcu_read_unlock_strict
      0.09 ±  4%      +0.0        0.13        perf-profile.self.cycles-pp.sock_alloc_send_pskb
      0.09 ±  5%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.03 ± 70%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.alloc_skb_with_frags
      0.05 ±  7%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.enqueue_entity
      0.09            +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.do_syscall_64
      0.04 ± 45%      +0.0        0.09        perf-profile.self.cycles-pp.dequeue_task_fair
      0.15 ±  3%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.10 ±  7%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.get_partial_node
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.exc_page_fault
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.refill_stock
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__calc_delta
      0.01 ±223%      +0.1        0.06        perf-profile.self.cycles-pp.kmalloc_reserve
      0.10 ±  4%      +0.1        0.15        perf-profile.self.cycles-pp.perf_prepare_sample
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.update_min_vruntime
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.copy_fpregs_to_fpstate
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.perf_tp_event_match
      0.11 ±  6%      +0.1        0.17        perf-profile.self.cycles-pp.refill_obj_stock
      0.06 ±  9%      +0.1        0.12        perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.schedule_timeout
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.kernelmode_fixup_or_oops
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.security_socket_recvmsg
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.security_socket_getpeersec_dgram
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.get_callchain_entry
      0.00            +0.1        0.06 ± 16%  perf-profile.self.cycles-pp.do_wait
      0.00            +0.1        0.06 ± 16%  perf-profile.self.cycles-pp.try_charge
      0.08 ±  6%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.native_sched_clock
      0.08 ±  6%      +0.1        0.14        perf-profile.self.cycles-pp.__update_load_avg_se
      0.17            +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.__ksize
      0.12 ±  4%      +0.1        0.18 ± 13%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.07 ±  8%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.get_perf_callchain
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.check_preempt_wakeup
      0.05 ±  8%      +0.1        0.12        perf-profile.self.cycles-pp.__kernel_text_address
      0.03 ± 70%      +0.1        0.10        perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.06 ±  8%      +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.prepare_to_wait
      0.05 ±  7%      +0.1        0.12        perf-profile.self.cycles-pp.bsearch
      0.08 ±  7%      +0.1        0.15        perf-profile.self.cycles-pp.ftrace_graph_ret_addr
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.select_idle_sibling
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.pick_next_task_fair
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.wait_for_unix_gc
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.unfreeze_partials
      0.09 ±  5%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.__switch_to_asm
      0.07 ±  7%      +0.1        0.14        perf-profile.self.cycles-pp.__list_del_entry_valid
      0.05            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.cpuacct_charge
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__wake_up_common
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.kvm_is_in_guest
      0.22 ±  3%      +0.1        0.30 ±  3%  perf-profile.self.cycles-pp.__entry_text_start
      0.04 ± 71%      +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.bpf_ksym_find
      0.06 ±  7%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.perf_output_begin_forward
      0.06 ±  9%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__switch_to
      0.20 ±  5%      +0.1        0.28        perf-profile.self.cycles-pp.vfs_read
      0.25 ±  3%      +0.1        0.33 ±  9%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.09 ±  4%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.perf_tp_event
      0.09 ±  4%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.load_new_mm_cr3
      0.17 ±  4%      +0.1        0.25        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.15 ±  3%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.new_sync_read
      0.06            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.try_to_wake_up
      0.20 ±  2%      +0.1        0.29 ±  3%  perf-profile.self.cycles-pp.__might_sleep
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.select_task_rq_fair
      0.02 ±141%      +0.1        0.11        perf-profile.self.cycles-pp.update_rq_clock
      0.08 ± 11%      +0.1        0.18 ±  5%  perf-profile.self.cycles-pp.perf_callchain_user
      0.00            +0.1        0.10 ±  5%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.20 ±  3%      +0.1        0.30        perf-profile.self.cycles-pp.sock_read_iter
      0.06 ±  7%      +0.1        0.16        perf-profile.self.cycles-pp.unwind_get_return_address
      0.24 ±  3%      +0.1        0.34        perf-profile.self.cycles-pp.vfs_write
      0.00            +0.1        0.10 ± 10%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.23 ±  2%      +0.1        0.33        perf-profile.self.cycles-pp.aa_sk_perm
      0.15 ±  2%      +0.1        0.26        perf-profile.self.cycles-pp.new_sync_write
      0.09 ±  4%      +0.1        0.20        perf-profile.self.cycles-pp.cmp_ex_search
      0.21 ±  4%      +0.1        0.32 ±  3%  perf-profile.self.cycles-pp.sock_write_iter
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.release_pages
      0.40 ±  3%      +0.1        0.52        perf-profile.self.cycles-pp.__fget_light
      0.51 ±  3%      +0.1        0.62 ±  2%  perf-profile.self.cycles-pp.__check_object_size
      0.16 ±  5%      +0.1        0.28        perf-profile.self.cycles-pp.switch_fpu_return
      0.28 ±  3%      +0.1        0.40        perf-profile.self.cycles-pp.common_file_perm
      0.16 ±  2%      +0.1        0.28        perf-profile.self.cycles-pp.___slab_alloc
      0.29 ±  2%      +0.1        0.42        perf-profile.self.cycles-pp.mutex_lock
      0.27 ±  2%      +0.1        0.40        perf-profile.self.cycles-pp.__check_heap_object
      0.32 ±  2%      +0.1        0.46 ±  2%  perf-profile.self.cycles-pp.__alloc_skb
      0.08 ±  5%      +0.1        0.22        perf-profile.self.cycles-pp.kernel_text_address
      0.06 ±  7%      +0.1        0.20 ±  4%  perf-profile.self.cycles-pp.update_cfs_group
      0.07 ±  7%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.update_curr
      0.00            +0.1        0.14 ± 28%  perf-profile.self.cycles-pp.queued_write_lock_slowpath
      0.46 ±  4%      +0.1        0.60        perf-profile.self.cycles-pp.__build_skb_around
      0.09 ±  5%      +0.1        0.24        perf-profile.self.cycles-pp.__unwind_start
      0.28 ±  3%      +0.2        0.43        perf-profile.self.cycles-pp.fsnotify
      0.18 ±  4%      +0.2        0.35 ±  2%  perf-profile.self.cycles-pp.unix_write_space
      0.33 ±  4%      +0.2        0.51        perf-profile.self.cycles-pp.___might_sleep
      0.47 ±  3%      +0.2        0.65        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.24 ±  6%      +0.2        0.43 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.06            +0.2        0.26 ±  7%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.2        0.20 ±  2%  perf-profile.self.cycles-pp.page_remove_rmap
      0.00            +0.2        0.23 ±  4%  perf-profile.self.cycles-pp.zap_pte_range
      0.20 ±  3%      +0.2        0.44 ±  2%  perf-profile.self.cycles-pp.consume_skb
      0.32            +0.2        0.57 ±  3%  perf-profile.self.cycles-pp.unix_stream_sendmsg
      0.18 ±  6%      +0.3        0.44        perf-profile.self.cycles-pp.stack_access_ok
      0.00            +0.3        0.28 ±  3%  perf-profile.self.cycles-pp.wait_consider_task
      0.27 ±  4%      +0.3        0.56        perf-profile.self.cycles-pp.native_irq_return_iret
      0.16 ±  7%      +0.3        0.45 ±  6%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.82 ±  3%      +0.3        2.12        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.24 ±  5%      +0.3        0.55        perf-profile.self.cycles-pp.perf_callchain_kernel
      0.08 ± 19%      +0.4        0.46 ±  9%  perf-profile.self.cycles-pp.obj_cgroup_charge_pages
      0.08 ± 19%      +0.4        0.50 ± 13%  perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      0.31 ±  5%      +0.4        0.74 ±  4%  perf-profile.self.cycles-pp.mutex_unlock
      0.31 ±  3%      +0.4        0.76 ±  3%  perf-profile.self.cycles-pp.orc_find
      0.59 ±  2%      +0.5        1.09 ±  3%  perf-profile.self.cycles-pp.skb_set_owner_w
      1.58 ±  2%      +0.6        2.18        perf-profile.self.cycles-pp.sock_wfree
      0.18 ± 23%      +0.6        0.79 ± 10%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.61 ±  3%      +0.8        1.41        perf-profile.self.cycles-pp.__orc_find
      0.96 ±  2%      +0.8        1.77 ±  2%  perf-profile.self.cycles-pp.unix_stream_read_generic
      0.53 ±  5%      +0.9        1.44        perf-profile.self.cycles-pp.sock_def_readable
      0.80 ±  4%      +1.0        1.76        perf-profile.self.cycles-pp.__get_user_nocheck_8
      0.00            +1.2        1.17 ± 28%  perf-profile.self.cycles-pp.intel_idle
      0.79 ±  2%      +1.3        2.13        perf-profile.self.cycles-pp.__slab_free
      0.95 ±  4%      +1.4        2.31        perf-profile.self.cycles-pp.unwind_next_frame
      0.84 ±  4%      +1.7        2.54        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      2.53 ±  2%      +2.1        4.63 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.08 ± 20%      +2.8        2.89 ± 16%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.52 ±  7%      +5.2        6.76 ± 14%  perf-profile.self.cycles-pp.propagate_protected_usage
      2.74 ±  9%     +10.1       12.82 ±  2%  perf-profile.self.cycles-pp.page_counter_cancel
      3.39 ±  8%     +10.5       13.86 ±  4%  perf-profile.self.cycles-pp.page_counter_try_charge





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.13.0-00079-g5387c90490f7"

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

--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='hackbench'
	export testcase='hackbench'
	export category='benchmark'
	export disable_latency_stats=1
	export nr_threads=104
	export iterations=4
	export job_origin='hackbench-100.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-skl-fpga01'
	export tbox_group='lkp-skl-fpga01'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='60e19ef7a7dd30dfb2ade854'
	export job_file='/lkp/jobs/scheduled/lkp-skl-fpga01/hackbench-performance-socket-4-threads-100%-ucode=0x2006a0a-monitor=40f1cfd2-debian-10.4-x86_64-20200603.cgz-5387c90490f7f42df32-20210704-57266-130fn2v-5.yaml'
	export id='a5119a77bb4b7c6bce704c5f018f78d2338dc035'
	export queuer_version='/lkp-src'
	export model='Skylake'
	export nr_node=2
	export nr_cpu=104
	export memory='192G'
	export kernel_cmdline_hw='acpi_rsdp=0x6b447014'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_CVWL34300015800RGN-part1'
	export commit='5387c90490f7f42df3209154ca955a453ee01b41'
	export ucode='0x2006a0a'
	export enqueue_time='2021-07-04 19:43:51 +0800'
	export _id='60e19f06a7dd30dfb2ade856'
	export _rt='/result/hackbench/performance-socket-4-threads-100%-ucode=0x2006a0a-monitor=40f1cfd2/lkp-skl-fpga01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='4d6db5cf9df2ed0ea6bc403b8d4ab34f132c3571'
	export base_commit='62fb9874f5da54fdb243003b386128037319b219'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='40f1cfd2'
	export result_root='/result/hackbench/performance-socket-4-threads-100%-ucode=0x2006a0a-monitor=40f1cfd2/lkp-skl-fpga01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/3'
	export scheduler_version='/lkp/lkp/.src-20210702-175843'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-fpga01/hackbench-performance-socket-4-threads-100%-ucode=0x2006a0a-monitor=40f1cfd2-debian-10.4-x86_64-20200603.cgz-5387c90490f7f42df32-20210704-57266-130fn2v-5.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=5387c90490f7f42df3209154ca955a453ee01b41
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/vmlinuz-5.13.0-00079-g5387c90490f7
acpi_rsdp=0x6b447014
max_uptime=2100
RESULT_ROOT=/result/hackbench/performance-socket-4-threads-100%-ucode=0x2006a0a-monitor=40f1cfd2/lkp-skl-fpga01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hackbench_20210701.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/hackbench-x86_64-1.10-1_20210701.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20210621.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-303392fd5c16-1_20210703.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.13.0'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/vmlinuz-5.13.0-00079-g5387c90490f7'
	export dequeue_time='2021-07-04 19:57:57 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-fpga01/hackbench-performance-socket-4-threads-100%-ucode=0x2006a0a-monitor=40f1cfd2-debian-10.4-x86_64-20200603.cgz-5387c90490f7f42df32-20210704-57266-130fn2v-5.cgz'

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

--6sX45UoQRIJXqkqR
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
testbox: lkp-skl-fpga01
tbox_group: lkp-skl-fpga01
kconfig: x86_64-rhel-8.3
submit_id: 60e1957ca7dd30dd9870a42f
job_file: "/lkp/jobs/scheduled/lkp-skl-fpga01/hackbench-performance-socket-4-threads-100%-ucode=0x2006a0a-monitor=40f1cfd2-debian-10.4-x86_64-20200603.cgz-5387c90490f7f42df32-20210704-56728-t3hf7t-1.yaml"
id: 1783d691b1c49597c2aa33905828ef84b39e4401
queuer_version: "/lkp-src"
:#! hosts/lkp-skl-fpga01:
model: Skylake
nr_node: 2
nr_cpu: 104
memory: 192G
kernel_cmdline_hw: acpi_rsdp=0x6b447014
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_CVWL34300015800RGN-part1"
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
commit: 5387c90490f7f42df3209154ca955a453ee01b41
:#! include/testbox/lkp-skl-fpga01:
ucode: '0x2006a0a'
enqueue_time: 2021-07-04 19:03:24.552140064 +08:00
_id: 60e1958ba7dd30dd9870a430
_rt: "/result/hackbench/performance-socket-4-threads-100%-ucode=0x2006a0a-monitor=40f1cfd2/lkp-skl-fpga01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41"
:#! schedule options:
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 4d6db5cf9df2ed0ea6bc403b8d4ab34f132c3571
base_commit: 62fb9874f5da54fdb243003b386128037319b219
branch: linux-devel/devel-hourly-20210703-042256
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 40f1cfd2
result_root: "/result/hackbench/performance-socket-4-threads-100%-ucode=0x2006a0a-monitor=40f1cfd2/lkp-skl-fpga01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/0"
scheduler_version: "/lkp/lkp/.src-20210702-175843"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-fpga01/hackbench-performance-socket-4-threads-100%-ucode=0x2006a0a-monitor=40f1cfd2-debian-10.4-x86_64-20200603.cgz-5387c90490f7f42df32-20210704-56728-t3hf7t-1.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210703-042256
- commit=5387c90490f7f42df3209154ca955a453ee01b41
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/vmlinuz-5.13.0-00079-g5387c90490f7
- acpi_rsdp=0x6b447014
- max_uptime=2100
- RESULT_ROOT=/result/hackbench/performance-socket-4-threads-100%-ucode=0x2006a0a-monitor=40f1cfd2/lkp-skl-fpga01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/modules.cgz"
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
:#! user overrides:
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/5387c90490f7f42df3209154ca955a453ee01b41/vmlinuz-5.13.0-00079-g5387c90490f7"
dequeue_time: 2021-07-04 19:07:01.840657227 +08:00
job_state: finished
loadavg: 420.83 936.88 542.70 1/867 30341
start_time: '1550139139'
end_time: '1550139556'
version: "/lkp/lkp/.src-20210702-175917:0e9ef164:07b503fa6"

--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "/usr/bin/hackbench" "-g" "104" "--threads" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "104" "--threads" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "104" "--threads" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "104" "--threads" "-l" "30000" "-s" "100"

--6sX45UoQRIJXqkqR--
